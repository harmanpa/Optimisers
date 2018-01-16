within Optimisers.Blocks.Tables;
package Utilities
extends Modelica.Icons.UtilitiesPackage;

function readTableSize
  "Read size of table from either .mat or .csv (no headers)"
  input String filename;
  input String tablename;
  output Integer[2] size;
  algorithm
  if isMATFile(filename) then
    size := Modelica.Utilities.Streams.readMatrixSize(filename, tablename);
  elseif isCSVFile(filename) then
    size[1] := Modelica.Utilities.Streams.countLines(filename);
    size[2] := if size[1] > 0 then Modelica.Utilities.Strings.count(
      Modelica.Utilities.Streams.readLine(filename, 1), ",") + 1 else 0;
  else
    assert(false, "File must be either .mat or .csv");
  end if;
  end readTableSize;

function readTable "Read a table from either .mat or .csv (no headers)"
  input String filename;
  input String tablename;
  input Integer nRows;
  input Integer nCols;
  output Real[nRows, nCols] table;
protected
  function parseCSVRow
    input String row;
    input Integer nCols;
    output Real[nCols] tableRow;
  protected
    Integer nextIndex=1;
    Real result;
    String delimiter;
    algorithm
    for i in 1:nCols loop
      (result,nextIndex) := Modelica.Utilities.Strings.scanReal(row, nextIndex);
      tableRow[i] := result;
      if i < nCols then
        (delimiter,nextIndex) := Modelica.Utilities.Strings.scanDelimiter(row,
          nextIndex);
      end if;
    end for;
    end parseCSVRow;
  algorithm
  if isMATFile(filename) then
    table := Modelica.Utilities.Streams.readRealMatrix(
        filename,
        tablename,
        nRows,
        nCols);
  elseif isCSVFile(filename) then
    for i in 1:nRows loop
      table[i, :] := parseCSVRow(Modelica.Utilities.Streams.readLine(filename,
        i), nCols);
    end for;
  else
    assert(false, "File must be either .mat or .csv");
  end if;
  end readTable;

function appendTable
  "Append a row to a table in either .mat or .csv (no headers)"
  input String filename;
  input String tablename;
  input Integer nRow;
  input Real[:] rowData;
protected
  Integer nCols=size(rowData, 1);
  Real[nRow, size(rowData, 1)] table;
  String row;
  algorithm
  if isMATFile(filename) then
    if nRow > 1 then
      table[1:nRow - 1, :] := Modelica.Utilities.Streams.readRealMatrix(
          filename,
          tablename,
          nRow - 1,
          nCols);
    end if;
    table[nRow, :] := rowData;
    Modelica.Utilities.Streams.writeRealMatrix(
        filename,
        tablename,
        table,
        true);
  elseif isCSVFile(filename) then
    if nRow == 1 then
      Modelica.Utilities.Files.removeFile(filename);
    end if;
    row := "";
    for i in 1:nCols loop
      row := row + String(rowData[i]);
      if i < nCols then
        row := row + ",";
      end if;
    end for;
    Modelica.Utilities.Streams.print(row, filename);
  else
    assert(false, "File must be either .mat or .csv");
  end if;
  end appendTable;

function writeTable "Write a table to either .mat or .csv (no headers)"
  input String filename;
  input String tablename;
  input Real[:, :] table;
protected
  Integer nRows=size(table, 1);
  Integer nCols=size(table, 2);
  algorithm
  if isMATFile(filename) then
    Modelica.Utilities.Streams.writeRealMatrix(
        filename,
        tablename,
        table,
        true);
  elseif isCSVFile(filename) then
    for i in 1:nRows loop
      appendTable(
          filename,
          tablename,
          i,
          table[i, :]);
    end for;
  else
    assert(false, "File must be either .mat or .csv");
  end if;
  end writeTable;
end Utilities;
