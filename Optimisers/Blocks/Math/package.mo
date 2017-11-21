within Optimisers.Blocks;
package Math "Math blocks"
extends Modelica.Icons.Package;

block SumOfSquares "Calculate sum-of-squares of inputs"
  extends Modelica.Blocks.Interfaces.MISO;
  equation
  y = sum({u[i]^2 for i in 1:nin});
  end SumOfSquares;
end Math;
