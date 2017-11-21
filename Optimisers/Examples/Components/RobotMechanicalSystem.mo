within Optimisers.Examples.Components;
model RobotMechanicalSystem "Mechanical system of 6DoF robot"
  extends
    Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.MechanicalStructure(
      world(animateWorld=true));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b load_frame
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,200})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
      animation=false, r=rLoad)
    annotation (Placement(transformation(extent={{-42,188},{-22,208}})));
equation
  connect(load_frame, fixedTranslation.frame_b) annotation (Line(
      points={{0,200},{-12,200},{-12,198},{-22,198}},
      color={95,95,95},
      thickness=0.5));
  connect(load.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{-60,198},{-42,198}},
      color={95,95,95},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RobotMechanicalSystem;
