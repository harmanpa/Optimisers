within ;

package Optimisers "Model-based optimisation library"
extends Modelica.Icons.Package;

annotation (
  Icon(graphics={Ellipse(
        origin={0.8208,2.2398},
        fillColor={161,0,4},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        extent={{-17.8562,-17.8563},{17.8563,17.8562}}), Line(
        points={{-88,44},{-64,24},{-18,18},{-6,-56},{42,-56},{74,48}},
        color={0,0,0},
        smooth=Smooth.Bezier)}),
  version="0.1",
  uses(Modelica(version="3.2.2")),
  Documentation(info="<html>
<p>This library is for model-based optimisation of cyber-physical systems.</p>
</html>"));
end Optimisers;
