section Section1;

shared BU =  let
    Source = Sql.Database(".", "IP", [Query="select distinct market BU,
  REGIONTITLE Region,
  MARKETDIRECTOR VP
from hr.bu"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"BU", "BU"}, {"Region", "RegionSeq"}, {"VP", "VP"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"BU", type text}, {"RegionSeq", type text}, {"VP", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "BU"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;