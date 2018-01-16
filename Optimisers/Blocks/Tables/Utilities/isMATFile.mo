within Optimisers.Blocks.Tables.Utilities;
function isMATFile "Check if file is .mat"
  input String filename;
  output Boolean mat;
protected
  Integer n;
algorithm
  n := Modelica.Utilities.Strings.length(filename);
  if n > 4 then
    mat := Modelica.Utilities.Strings.isEqual(".mat",
      Modelica.Utilities.Strings.substring(
      filename,
      n - 3,
      n));
  else
    mat := false;
  end if;
end isMATFile;
