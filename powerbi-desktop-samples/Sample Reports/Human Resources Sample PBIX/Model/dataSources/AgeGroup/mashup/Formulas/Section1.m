section Section1;

shared AgeGroup =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUYopNTAwTjY2UIrViVYyAgoYG+iaWIJ5xkCeqYG2UmwsAA==", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "AgeGroupID"}, {"Column2", "AgeGroup"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"AgeGroupID", Int64.Type}, {"AgeGroup", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "AgeGroup"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
 in
    AutoRemovedColumns1;