section Section1;

shared SeparationReason =  let
    Source = Sql.Database(".", "IP", [Query="SELECT distinct SeparationTypeID, [Vol-Invol] SeparationReason
  FROM [IP].[HR].[TermReason]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"SeparationTypeID", "SeparationTypeID"}, {"SeparationReason", "SeparationReason"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"SeparationTypeID", type text}, {"SeparationReason", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "SeparationReason"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;