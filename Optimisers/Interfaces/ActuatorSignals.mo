within Optimisers.Interfaces;
model ActuatorSignals "Interface to get actuator signals"
  extends Modelica.Blocks.Icons.Block;
  ActuatorPort actuatorPort
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{120,-70},{80,-30}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
equation
  y = actuatorPort.goalF;
  u = actuatorPort.goalR;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ActuatorSignals;
