within Optimisers.Functions;
function iterate "Perform one step of the optimisation algorithm"
  extends Modelica.Icons.Function;
  input Types.OptimiserObject optimiser "Global optmiser object";
  input Real[:] x "Current parameter values";
  input Real f "Current objective value";
  input Real[:] c "Current constraint values";
  output Boolean continue "true if further iterations required";
  output Real[size(x, 1)] nextX "Next parameter values";
external"C" continue = Optimiser_Iterate(
    optimiser,
    x,
    f,
    c,
    nextX) annotation (Include="#include \"modelica_optimisers.c\"");
end iterate;
