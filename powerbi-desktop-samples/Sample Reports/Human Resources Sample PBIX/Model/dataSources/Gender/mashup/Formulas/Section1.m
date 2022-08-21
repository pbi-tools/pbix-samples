section Section1;

shared Gender =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WclHSUfJNzEkFUoZKsTrRSs5AlltqLkTISCk2FgA=", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "ID"}, {"Column2", "Gender"}, {"Column3", "Sort"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"ID", type text}, {"Gender", type text}, {"Sort", Int64.Type}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Gender"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
 in
    AutoRemovedColumns1;