section Section1;

shared #"Tooltip Info2" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45W8kstUQhOzEktVtBVCIwpNTAwMnNU0lHKKCkpKLbS18/MTUxPLc5ITM7WS87P1c/UL8gPKC8IzyhIR1OUWZVapIeuOjfd0shE39zU0kAfoksvPTNNKVYnWikotaS0KI9oS3PDvXLyAlOJttRI38LM1EgfogtiaSwA", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Nombre = _t, URL = _t, DLINK = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Nombre", type text}, {"URL", type text}, {"DLINK", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Tooltip Info2"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;