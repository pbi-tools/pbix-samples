section Section1;

shared Ethnicity =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUXIvyi8tUHBUitWJVjKC853AfGM43xnMN4HzXcB8UzjfFcw3g/PdwHxzON9dKTYWAA==", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "Ethnic Group"}, {"Column2", "Ethnicity"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"Ethnic Group", type text}, {"Ethnicity", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Ethnicity"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
 in
    AutoRemovedColumns1;