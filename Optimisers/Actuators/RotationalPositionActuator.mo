within Optimisers.Actuators;
model RotationalPositionActuator
  extends Interfaces.PartialActuator(final constrained=false);
  Modelica.Mechanics.Rotational.Sources.Position position
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(extent={{12,-30},{-8,-10}})));
  Interfaces.ActuatorSignals goalSignals
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(actuatorPort, goalSignals.actuatorPort)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,0,0}));
  connect(goalSignals.y, position.phi_ref) annotation (Line(points={{-60,5},{-36,
          5},{-36,30},{-10,30}},color={0,0,127}));
  connect(position.flange, flange_b)
    annotation (Line(points={{12,30},{56,30},{56,0},{100,0}}, color={0,0,0}));
  connect(position.flange, angleSensor.flange) annotation (Line(points={{12,30},
          {56,30},{56,-20},{12,-20}}, color={0,0,0}));
  connect(angleSensor.phi, goalSignals.u) annotation (Line(points={{-9,-20},{-48,
          -20},{-48,-5},{-60,-5}},color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-20.0},{100.0,20.0}}),
        Line(points={{-29.0,32.0},{30.0,32.0}}),
        Line(points={{0.0,52.0},{0.0,32.0}}),
        Line(points={{-30.0,-32.0},{30.0,-32.0}}),
        Line(points={{-20.0,-32.0},{-30.0,-42.0}}),
        Line(points={{-10.0,-32.0},{-30.0,-52.0}}),
        Line(points={{0.0,-32.0},{-20.0,-52.0}}),
        Line(points={{10.0,-32.0},{-10.0,-52.0}}),
        Line(points={{20.0,-32.0},{0.0,-52.0}}),
        Line(points={{30.0,-32.0},{10.0,-52.0}}),
        Line(points={{30.0,-42.0},{20.0,-52.0}})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end RotationalPositionActuator;
