within Optimisers;
model ModelOptimiser "Optimiser"
  extends Modelica.Blocks.Icons.Block;
  Real f;

  ActuatorPort actuatorPort[nActuators] "Connectors for actuators"
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Interfaces.ConstraintPort constraintPort[nConstraints]
    "Connectors for constraints"
    annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
  Modelica.Blocks.Interfaces.RealInput objective
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput reset annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Boolean ready(final start=false, final fixed=true);
  Boolean continue(final start=true, final fixed=true);
  Real x[nActuators];
  Real c[nConstraints];
  parameter Integer nActuators=0 "Number of parameters of optimisation problem"
    annotation (Evaluate=true, Dialog(
      connectorSizing=true,
      tab="General",
      group="Ports"));
  parameter Integer nConstraints=0
    "Number of constraints of optimisation problem" annotation (Evaluate=true,
      Dialog(
      connectorSizing=true,
      tab="General",
      group="Ports"));
  parameter Real actuatorTolerance=1e-8 "Accuracy of actuated signals";
protected
  Optimisers.Types.OptimiserObject opt=Optimisers.Types.OptimiserObject(n=
      nActuators, m=nConstraints);
  connector ActuatorPort
    output Real goalF;
    input Real goalR;
    annotation (Icon(graphics={Ellipse(
            origin={0,9.88827e-005},
            fillColor={161,0,4},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-80,-80.0001},{80,79.9999}})}));
  end ActuatorPort;

public
  Modelica.Blocks.Interfaces.BooleanOutput done annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));
  Boolean optimiserActive(start=true, fixed=true);
  Boolean iterate;
equation
  ready = sum({abs(actuatorPort[i].goalR - actuatorPort[i].goalF) for i in 1:
    nActuators}) <= nActuators*actuatorTolerance;
  x = {actuatorPort[i].goalF for i in 1:nActuators};
  c = {constraintPort[i].constraint for i in 1:nConstraints};
  f = objective;
  when pre(ready) and pre(iterate) then
    (continue,x) = Functions.iterate(
      opt,
      pre(x),
      f,
      c);
  end when;
  iterate = optimiserActive and (pre(reset) or pre(continue));
  when done then
    optimiserActive = false;
  elsewhen pre(reset) then
    optimiserActive = Optimisers.Functions.restart(opt);
  end when;
  done = not continue;
  annotation (
    Placement(transformation(extent={{90,40},{110,60}})),
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(
          origin={0.8208,2.2398},
          fillColor={161,0,4},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-17.8562,-17.8563},{17.8563,17.8562}}), Line(
          points={{-88,44},{-64,24},{-18,18},{-6,-56},{42,-56},{74,48}},
          color={0,0,0},
          smooth=Smooth.Bezier)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end ModelOptimiser;
