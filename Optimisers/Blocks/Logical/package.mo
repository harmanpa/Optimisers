within Optimisers.Blocks;
package Logical "Logical blocks"
extends Modelica.Icons.Package;

block Stop "Stop simulation on Boolean input"
  extends Modelica.Blocks.Interfaces.partialBooleanSI;
  parameter String message="Simulation stop requested";
  equation
  when u then
    terminate(message);
  end when;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
          points={{-80,36},{-80,-36},{-36,-80},{36,-80},{80,-36},{80,36},{36,80},
              {-36,80},{-80,36}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-46,34},{44,-26}},
          lineColor={255,255,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Stop")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
  end Stop;
end Logical;
