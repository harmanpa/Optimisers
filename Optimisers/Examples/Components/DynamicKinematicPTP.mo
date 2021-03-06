within Optimisers.Examples.Components;
model DynamicKinematicPTP
  "Move as fast as possible along a distance within given kinematic constraints"


  parameter Real qd_max[nout](each final min=Modelica.Constants.small) = ones(
    nout) "Maximum velocities der(q)";
  parameter Real qdd_max[nout](each final min=Modelica.Constants.small) = ones(
    nout) "Maximum accelerations der(qd)";
  parameter Modelica.SIunits.Time startTime=0
    "Time instant at which movement starts";
  parameter Modelica.SIunits.Time waitTime=0
    "Time to wait after movement before starting another";
  parameter Real q_min=1e-3 "Smallest distance to try and move";
  extends Modelica.Blocks.Interfaces.MO;

  //protected
  Real deltaq[nout] "Distance to move";
  Real sd_max;
  Real sdd_max;
  Real sdd;
  Real aux1[nout];
  Real aux2[nout];
  Modelica.SIunits.Time Ta1;
  Modelica.SIunits.Time Ta2;
  Modelica.SIunits.Time Tv;
  Modelica.SIunits.Time Te;
  Boolean noWphase;
  Modelica.SIunits.Time lastStartTime;
  Boolean ready(start=false, fixed=true);
public
  Modelica.Blocks.Interfaces.RealInput u_r[nout] "Requested position"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput u_m[nout] "Measured position"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.BooleanOutput done(start=true, fixed=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));
equation
  when {pre(done) and ready} then
    lastStartTime = if initial() then startTime else time;
    deltaq = u_r - u_m;
    aux1 = {deltaq[i]/qd_max[i] for i in 1:nout};
    aux2 = {deltaq[i]/qdd_max[i] for i in 1:nout};
    sd_max = 1/max(abs(aux1));
    sdd_max = 1/max(abs(aux2));

    Ta1 = sqrt(1/sdd_max);
    Ta2 = sd_max/sdd_max;
    noWphase = Ta2 >= Ta1;
    Tv = if noWphase then Ta1 else 1/sd_max;
    Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
  end when;

  // path-acceleration
  sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 +
    lastStartTime then sdd_max else (if time < Te + lastStartTime then -sdd_max
     else 0)) else (if time < Ta2 + lastStartTime then sdd_max else (if time <
    Tv + lastStartTime then 0 else (if time < Te + lastStartTime then -sdd_max
     else 0)))));

  done = time > Te + lastStartTime + waitTime;
  ready = max(abs(u_r - u_m)) > q_min;

  // acceleration
  y = deltaq*sdd;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-80,78},{-80,-82}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{82,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-70,0},{-70,70},{-30,70},{-30,0},{20,0},{20,-70},
              {60,-70},{60,0},{68,0}}),
        Text(
          extent={{2,80},{80,20}},
          lineColor={192,192,192},
          textString="acc"),
        Text(
          extent={{-150,-150},{150,-110}},
          lineColor={0,0,0},
          textString="deltaq=%deltaq")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-80,78},{-80,-72}}, color={95,95,95}),
          Polygon(
          points={{-80,91},{-86,71},{-75,71},{-80,91},{-80,91}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Line(points={{-90,0},{82,0}}, color={
          95,95,95}),Polygon(
          points={{89,0},{68,5},{68,-5},{89,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),Line(
          points={{-80,0},{-70,0},{-70,70},{-30,70},{-30,0},{20,0},{20,-70},{60,
            -70},{60,0},{68,0}},
          color={0,0,255},
          thickness=0.5),Text(
          extent={{-73,95},{-16,80}},
          lineColor={0,0,0},
          textString="acceleration"),Text(
          extent={{66,20},{88,8}},
          lineColor={0,0,0},
          textString="time")}),
    Documentation(info="<html>
<p>The goal is to move as <b>fast</b> as possible to the request position, <b>u_r</b>, from the measured position, <b>u_m</b>, under given <b>kinematical constraints</b>. The distance can be a positional or angular range. In robotics such a movement is called <b>PTP</b> (Point-To-Point). This source block generates the <b>acceleration</b> qdd of this signal as output: </p>
<p><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png\" alt=\"KinematicPTP.png\"/> </p>
<p>After integrating the output two times, the position q is obtained. The signal is constructed in such a way that it is not possible to move faster, given the <b>maximally</b> allowed <b>velocity</b> qd_max and the <b>maximally</b> allowed <b>acceleration</b> qdd_max. </p>
<p>If several distances are given (vector deltaq has more than 1 element), an acceleration output vector is constructed such that all signals are in the same periods in the acceleration, constant velocity and deceleration phase. This means that only one of the signals is at its limits whereas the others are synchronized in such a way that the end point is reached at the same time instant. </p>
<p>This element is useful to generate a reference signal for a controller which controls a drive train or in combination with model Modelica.Mechanics.Rotational.<b>Accelerate</b> to drive a flange according to a given acceleration. </p>
</html>", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>June 27, 2001</i>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><i>Nov. 3, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
end DynamicKinematicPTP;
