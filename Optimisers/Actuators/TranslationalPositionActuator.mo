within Optimisers.Actuators;
model TranslationalPositionActuator
  extends Interfaces.PartialActuator(final constrained=false);
  Modelica.Mechanics.Translational.Sources.Position position
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor
    annotation (Placement(transformation(extent={{8,-44},{-12,-24}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange
    "Flange of component"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Interfaces.ActuatorSignals goalSignals
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation
  connect(position.flange, flange)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,0}));
  connect(positionSensor.flange, flange) annotation (Line(points={{8,-34},{36,-34},
          {36,0},{100,0}}, color={0,127,0}));
  connect(actuatorPort, goalSignals.actuatorPort)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,0,0}));
  connect(goalSignals.y, position.s_ref) annotation (Line(points={{-50,5},{-32,
          5},{-32,0},{-12,0}}, color={0,0,127}));
  connect(goalSignals.u, positionSensor.s) annotation (Line(points={{-50,-5},{-40,
          -5},{-40,-34},{-13,-34}}, color={0,0,127}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(points={{0,52},{0,32}}, color={0,
          0,0}),Line(points={{-29,32},{30,32}}),Line(points={{-30,-32},{30,-32}}),
          Line(points={{-20,-32},{-30,-42}}),Line(points={{-10,-32},{-30,-52}}),
          Line(points={{0,-32},{-20,-52}}),Line(points={{10,-32},{-10,-52}}),
          Line(points={{20,-32},{0,-52}}),Line(points={{30,-32},{10,-52}}),Line(
          points={{30,-42},{20,-52}})}));
end TranslationalPositionActuator;
