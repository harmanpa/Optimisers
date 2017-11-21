within Optimisers.Functions;
function restart "Reset the optimiser for a new objective"
  extends Modelica.Icons.Function;
  input Types.OptimiserObject optimiser "Global optimiser object";
  output Boolean continue;
external"C" continue = Optimiser_Restart(optimiser)
    annotation (Include="#include \"modelica_optimisers.c\"");
end restart;
