within Optimisers.Blocks.Tables.Utilities;
function isCSVFile "Check if file is .mat"
  input String filename;
  output Boolean csv;
protected
  Integer n;
algorithm
  n := Modelica.Utilities.Strings.length(filename);
  if n > 4 then
    csv := Modelica.Utilities.Strings.isEqual(".csv",
      Modelica.Utilities.Strings.substring(
      filename,
      n - 3,
      n));
  else
    csv := false;
  end if;
end isCSVFile;
