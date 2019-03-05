section Section1;

shared Sales = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("Rc49DoAwCAbQuzB3sPRPRr2EQ9NB49Kkzl5fSlGnwkvhI2ewYGCtrfFjpwmKyYBcb4NQyXF9M9X96uqVPTfH+Ok8ebGgC6tgEIvfeJ8mQtHEzXLKxjd61uiRY9GJ0n9jiAlKeQA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ID = _t, #"Sales Person" = _t, #"Sales Amount" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ID", Int64.Type}, {"Sales Amount", Int64.Type}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Sales"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;