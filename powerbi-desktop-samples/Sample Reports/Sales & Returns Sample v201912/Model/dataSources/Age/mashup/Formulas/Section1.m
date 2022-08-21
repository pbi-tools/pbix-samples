section Section1;

shared Age = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("dc8rDsAgEIThqxA0AnZZHmchCER1k7amty+gaMKYEZ/6pxTtRJs+6jkVWfUe7bp1Nd0D8Ag8Ac97JwvcdSc3XVYn4AzcAxfg4y+F4fzricAT8Lx3tsDHX549vPYwAWfgHrhsvH4=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Age = _t, #"Age Bucket" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Age", Int64.Type}, {"Age Bucket", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Age"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;