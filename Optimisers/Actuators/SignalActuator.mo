within Optimisers.Actuators;
model SignalActuator
  extends Modelica.Blocks.Interfaces.SO;
  extends Interfaces.PartialActuator(final constrained=false);
  Interfaces.ActuatorSignals goalSignals
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
equation
  connect(actuatorPort, goalSignals.actuatorPort)
    annotation (Line(points={{-100,0},{-62,0}}, color={0,0,0}));
  connect(goalSignals.y, goalSignals.u) annotation (Line(points={{-42,5},{-28,5},
          {-28,-5},{-42,-5}}, color={0,0,127}));
  connect(goalSignals.y, y) annotation (Line(points={{-42,5},{-28,5},{-28,0},{
          110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalActuator;
