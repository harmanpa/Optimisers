within Optimisers.Examples;
model RobotPosition "Calculate target positions for 6DoF robot"
  extends Modelica.Icons.Example;
  ModelOptimiser modelOptimiser(nActuators=6)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Components.RobotMechanicalSystem robotMechanicalSystem
    annotation (Placement(transformation(extent={{40,-40},{100,20}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsolutePosition absolutePosition(
      resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world)
    annotation (Placement(transformation(extent={{70,32},{50,52}})));
  Blocks.Math.SumOfSquares sumOfSquares(nin=3)
    annotation (Placement(transformation(extent={{-72,-20},{-52,0}})));
  Modelica.Blocks.Math.Feedback feedback[3]
    annotation (Placement(transformation(extent={{-52,64},{-32,84}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator
    annotation (Placement(transformation(extent={{0,4},{20,24}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator1
    annotation (Placement(transformation(extent={{0,-14},{20,6}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator2
    annotation (Placement(transformation(extent={{-2,-34},{18,-14}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator3
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator4
    annotation (Placement(transformation(extent={{0,-72},{20,-52}})));
  Actuators.RotationalPositionActuator rotationalPositionActuator5
    annotation (Placement(transformation(extent={{0,-92},{20,-72}})));
  Blocks.Tables.TriggeredTableRead triggeredTableRead(table=[0, 1, 1; 0, 0, 1;
        1, 0, 1; 1, 1, 1; 0, 1, 1])
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  Modelica.Blocks.Math.IntegerChange integerChange
    annotation (Placement(transformation(extent={{-72,-52},{-52,-32}})));
  Blocks.Tables.TriggeredTableWrite triggeredTableWrite(
    nin=6,
    filename="RobotPositionOutput.mat",
    tablename="angles")
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor[6]
    annotation (Placement(transformation(extent={{48,-80},{68,-60}})));
equation
  connect(sumOfSquares.y, modelOptimiser.objective)
    annotation (Line(points={{-51,-10},{-40,-10}}, color={0,0,127}));
  connect(absolutePosition.frame_a, robotMechanicalSystem.load_frame)
    annotation (Line(
      points={{70,42},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(feedback.y, sumOfSquares.u) annotation (Line(points={{-33,74},{-18,74},
          {-18,28},{-88,28},{-88,-10},{-74,-10}}, color={0,0,127}));
  connect(modelOptimiser.actuatorPort[1], rotationalPositionActuator.actuatorPort)
    annotation (Line(points={{-20,-5.83333},{-12,-5.83333},{-12,14},{0,14}},
        color={0,0,0}));
  connect(rotationalPositionActuator.flange_b, robotMechanicalSystem.axis6)
    annotation (Line(points={{20,14},{28,14},{28,9.5},{38.5,9.5}}, color={0,0,0}));
  connect(rotationalPositionActuator1.flange_b, robotMechanicalSystem.axis5)
    annotation (Line(points={{20,-4},{30,-4},{30,0.5},{38.5,0.5}}, color={0,0,0}));
  connect(rotationalPositionActuator2.flange_b, robotMechanicalSystem.axis4)
    annotation (Line(points={{18,-24},{30,-24},{30,-8.5},{38.5,-8.5}}, color={0,
          0,0}));
  connect(rotationalPositionActuator3.flange_b, robotMechanicalSystem.axis3)
    annotation (Line(points={{20,-42},{30,-42},{30,-17.5},{38.5,-17.5}}, color=
          {0,0,0}));
  connect(rotationalPositionActuator4.flange_b, robotMechanicalSystem.axis2)
    annotation (Line(points={{20,-62},{30,-62},{30,-26.5},{38.5,-26.5}}, color=
          {0,0,0}));
  connect(rotationalPositionActuator5.flange_b, robotMechanicalSystem.axis1)
    annotation (Line(points={{20,-82},{30,-82},{30,-35.5},{38.5,-35.5}}, color=
          {0,0,0}));
  connect(rotationalPositionActuator1.actuatorPort, modelOptimiser.actuatorPort[
    2]) annotation (Line(points={{0,-4},{-10,-4},{-10,-5.5},{-20,-5.5}}, color=
          {0,0,0}));
  connect(rotationalPositionActuator2.actuatorPort, modelOptimiser.actuatorPort[
    3]) annotation (Line(points={{-2,-24},{-12,-24},{-12,-5.16667},{-20,-5.16667}},
        color={0,0,0}));
  connect(rotationalPositionActuator3.actuatorPort, modelOptimiser.actuatorPort[
    4]) annotation (Line(points={{0,-42},{-10,-42},{-10,-4.83333},{-20,-4.83333}},
        color={0,0,0}));
  connect(rotationalPositionActuator4.actuatorPort, modelOptimiser.actuatorPort[
    5]) annotation (Line(points={{0,-62},{-10,-62},{-10,-4.5},{-20,-4.5}},
        color={0,0,0}));
  connect(rotationalPositionActuator5.actuatorPort, modelOptimiser.actuatorPort[
    6]) annotation (Line(points={{0,-82},{-10,-82},{-10,-4.16667},{-20,-4.16667}},
        color={0,0,0}));
  connect(absolutePosition.r, feedback.u2)
    annotation (Line(points={{49,42},{-42,42},{-42,66}}, color={0,0,127}));
  connect(modelOptimiser.done, triggeredTableRead.trigger) annotation (Line(
        points={{-30,0},{-30,8},{-90,8},{-90,64}}, color={255,0,255}));
  connect(triggeredTableRead.y, feedback.u1)
    annotation (Line(points={{-79,74},{-50,74}}, color={0,0,127}));
  connect(integerChange.y, modelOptimiser.reset) annotation (Line(points={{-51,
          -42},{-30,-42},{-30,-20}}, color={255,0,255}));
  connect(triggeredTableRead.row, integerChange.u) annotation (Line(points={{-95,
          84},{-95,92},{-110,92},{-110,-42},{-74,-42}}, color={255,127,0}));
  connect(angleSensor.phi, triggeredTableWrite.u)
    annotation (Line(points={{69,-70},{78,-70}}, color={0,0,127}));
  connect(angleSensor[1].flange, rotationalPositionActuator5.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,-82},{20,-82}}, color={0,0,0}));
  connect(angleSensor[2].flange, rotationalPositionActuator4.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,-62},{20,-62}}, color={0,0,0}));
  connect(angleSensor[3].flange, rotationalPositionActuator3.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,-42},{20,-42}}, color={0,0,0}));
  connect(angleSensor[4].flange, rotationalPositionActuator2.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,-24},{18,-24}}, color={0,0,0}));
  connect(angleSensor[5].flange, rotationalPositionActuator1.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,-4},{20,-4}}, color={0,0,0}));
  connect(angleSensor[6].flange, rotationalPositionActuator.flange_b)
    annotation (Line(points={{48,-70},{30,-70},{30,14},{20,14}}, color={0,0,0}));
  connect(modelOptimiser.done, triggeredTableWrite.trigger) annotation (Line(
        points={{-30,0},{-30,8},{-94,8},{-94,-66},{-16,-66},{-16,-94},{90,-94},
          {90,-80}},color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end RobotPosition;
