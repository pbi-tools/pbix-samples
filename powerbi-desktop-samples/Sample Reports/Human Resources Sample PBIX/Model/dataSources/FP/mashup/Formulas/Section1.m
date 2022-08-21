section Section1;

shared FP =  let
    Source = Sql.Database(".", "IP", [Query="SELECT [HR].[FP].*   FROM [HR].[FP]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"FP", "FP"}, {"FPDesc", "FPDesc"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"FP", type text}, {"FPDesc", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "FP"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;