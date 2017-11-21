within Optimisers.Types;
class OptimiserObject "Core optimiser object"
  extends ExternalObject;
  encapsulated function constructor "Constructor"
    import Modelica;
    import Optimisers;
    extends Modelica.Icons.Function;
    input Integer method=1 "Method";
    input Integer n=2 "Problem dimension";
    input Integer m=0 "Number of constraints";
    input Real rhobeg=1e-2 "Initial trust region";
    input Real rhoend=1e-6 "End trust region";
    input Integer maxfun=5000 "Maximum evaluations";
    input Integer npt=2*n + 1 "Number of points (NEWUOA only)";
    output Optimisers.Types.OptimiserObject opt;
  external"C" opt = Optimiser_Create(
        method,
        n,
        m,
        rhobeg,
        rhoend,
        maxfun,
        npt) annotation (Include="#include \"modelica_optimisers.c\"");
  end constructor;

  encapsulated function destructor "Destructor"
    import Modelica;
    import Optimisers;
    extends Modelica.Icons.Function;
    input Optimisers.Types.OptimiserObject opt;
  external"C" Optimiser_Destroy(opt)
      annotation (Include="#include \"modelica_optimisers.c\"");
  end destructor;
end OptimiserObject;
