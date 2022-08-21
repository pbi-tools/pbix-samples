section Section1;

shared PayType =  let
    Source = Sql.Database(".", "IP", [Query="select distinct PayTypeID, [Hrly-Salaried] PayType
from [HR].[PayGroup]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"PayTypeID", "PayTypeID"}, {"PayType", "PayType"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"PayTypeID", type text}, {"PayType", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "PayType"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;