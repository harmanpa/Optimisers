within Optimisers.Blocks;
package Tables "Table blocks"
extends Modelica.Icons.Package;

block TriggeredTableRead "Output single row, increment with Boolean trigger"
  extends Modelica.Blocks.Interfaces.MO(final nout=tableSize[2]);
  Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  parameter Boolean tableOnFile=false "Table is read from file"
    annotation (Evaluate=true);
  parameter Real[:, :] table=[0, 0; 1, 0] "Table data if tableOnFile==false"
    annotation (Dialog(enable=not tableOnFile));
  parameter String filename="" annotation (Dialog(enable=tableOnFile));
  parameter String tablename="" annotation (Dialog(enable=tableOnFile));
  Modelica.Blocks.Interfaces.IntegerOutput row(start=0, fixed=true) annotation
    (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,100})));
protected
  parameter Integer[2] tableSize=if tableOnFile then
      Modelica.Utilities.Streams.readMatrixSize(filename, tablename) else {size(
      table, 1),size(table, 2)};
  parameter Real[tableSize[1], tableSize[2]] data=if tableOnFile then
      Modelica.Utilities.Streams.readRealMatrix(
        filename,
        tablename,
        tableSize[1],
        tableSize[2]) else table;
public
  Modelica.Blocks.Interfaces.BooleanOutput lastRow annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,100})));
  equation
  when {initial(),pre(trigger) and pre(row) < tableSize[1]} then
    row = pre(row) + 1;
    y = data[row, :];
  end when;
  lastRow = row == tableSize[1];
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
        Line(points={{-80.0,68.0},{-80.0,-80.0}}, color={192,192,192}),
        Line(points={{-90.0,-70.0},{82.0,-70.0}}, color={192,192,192}),
        Polygon(
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
        Line(points={{-48.0,-50.0},{-48.0,70.0},{52.0,70.0},{52.0,-50.0},{-48.0,
              -50.0},{-48.0,-20.0},{52.0,-20.0},{52.0,10.0},{-48.0,10.0},{-48.0,
              40.0},{52.0,40.0},{52.0,70.0},{2.0,70.0},{2.0,-51.0}}),
        Line(points={{0,-78},{0,-60},{-64,-60},{-64,26},{-54,26}}, color={255,0,
              255})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end TriggeredTableRead;

block TriggeredTableWrite
  "Write single row to file, increment with Boolean trigger"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer nin=1 "Number of inputs";
  Modelica.Blocks.Interfaces.RealInput u[nin] "Connector of Real input signals"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  parameter String filename="";
  parameter String tablename="";
  Modelica.Blocks.Interfaces.IntegerOutput row(final start=0, final fixed=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));
protected
  function appendMatrix
    input String filename;
    input String tablename;
    input Integer nRow;
    input Real[:] rowData;
  protected
    Integer nCols=size(rowData, 1);
    Real[nRow, size(rowData, 1)] table;
    algorithm
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
    end appendMatrix;

  algorithm
  when {initial(), trigger} then
    // Note: following if is required due to OMC calling "when initial()" clause multiple times
    if trigger or row==0 then
      row := pre(row) + 1;
      appendMatrix(
        filename,
        tablename,
        row,
        u);
      end if;
  end when;
  annotation (Icon(graphics={
        Polygon(
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
        Line(points={{-80.0,68.0},{-80.0,-80.0}}, color={192,192,192}),
        Line(points={{-90.0,-70.0},{82.0,-70.0}}, color={192,192,192}),
        Polygon(
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
        Line(points={{-48.0,-50.0},{-48.0,70.0},{52.0,70.0},{52.0,-50.0},{-48.0,
              -50.0},{-48.0,-20.0},{52.0,-20.0},{52.0,10.0},{-48.0,10.0},{-48.0,
              40.0},{52.0,40.0},{52.0,70.0},{2.0,70.0},{2.0,-51.0}}),
        Line(points={{0,-78},{0,-60},{-64,-60},{-64,26},{-54,26}}, color={255,0,
              255})}));
  end TriggeredTableWrite;













end Tables;
