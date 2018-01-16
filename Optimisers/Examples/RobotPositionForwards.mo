within Optimisers.Examples;
model RobotPositionForwards "Use calculated target positions for 6DoF robot"
  extends Modelica.Icons.Example;
  Components.RobotMechanicalSystem robotMechanicalSystem
    annotation (Placement(transformation(extent={{40,-40},{100,20}})));
  Modelica.Mechanics.Rotational.Sources.Accelerate accelerator[6]
    annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
  Blocks.Tables.TriggeredTableRead triggeredTableRead(
    tableOnFile=true,
    tablename="angles",
    filename="RobotPositionOutput.csv")
    annotation (Placement(transformation(extent={{-94,-24},{-74,-4}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor[6]
    annotation (Placement(transformation(extent={{46,-66},{66,-46}})));
  Components.DynamicKinematicPTP dynamicKinematicPTP(waitTime=0.5, nout=6)
    annotation (Placement(transformation(extent={{-44,-24},{-24,-4}})));
equation
  connect(accelerator.flange, angleSensor.flange)
    annotation (Line(points={{20,-14},{20,-56},{46,-56}}, color={0,0,0}));
  connect(accelerator[1].flange, robotMechanicalSystem.axis1) annotation (Line(
        points={{20,-14},{20,-35.5},{38.5,-35.5}}, color={0,0,0}));
  connect(accelerator[2].flange, robotMechanicalSystem.axis2) annotation (Line(
        points={{20,-14},{20,-26.5},{38.5,-26.5}}, color={0,0,0}));
  connect(accelerator[3].flange, robotMechanicalSystem.axis3) annotation (Line(
        points={{20,-14},{20,-17.5},{38.5,-17.5}}, color={0,0,0}));
  connect(accelerator[4].flange, robotMechanicalSystem.axis4)
    annotation (Line(points={{20,-14},{20,-8.5},{38.5,-8.5}}, color={0,0,0}));
  connect(accelerator[5].flange, robotMechanicalSystem.axis5)
    annotation (Line(points={{20,-14},{20,0.5},{38.5,0.5}}, color={0,0,0}));
  connect(accelerator[6].flange, robotMechanicalSystem.axis6)
    annotation (Line(points={{20,-14},{20,9.5},{38.5,9.5}}, color={0,0,0}));
  connect(dynamicKinematicPTP.y, accelerator.a_ref) annotation (Line(points={{-23,
          -14},{-14,-14},{-14,-14},{-2,-14}}, color={0,0,127}));
  connect(angleSensor.phi, dynamicKinematicPTP.u_m) annotation (Line(points={{
          67,-56},{76,-56},{76,-70},{-34,-70},{-34,-24}}, color={0,0,127}));
  connect(triggeredTableRead.y, dynamicKinematicPTP.u_r)
    annotation (Line(points={{-73,-14},{-44,-14}}, color={0,0,127}));
  connect(dynamicKinematicPTP.done, triggeredTableRead.trigger) annotation (
      Line(points={{-34,-4},{-34,6},{-58,6},{-58,-32},{-84,-32},{-84,-24}},
        color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15));
end RobotPositionForwards;
