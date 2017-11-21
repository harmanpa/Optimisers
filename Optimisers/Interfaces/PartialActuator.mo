within Optimisers.Interfaces;
partial model PartialActuator "Base actuator model"
  parameter Boolean constrained=false;
  ActuatorPort actuatorPort annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  ConstraintPort constraintPort if constrained
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
end PartialActuator;
