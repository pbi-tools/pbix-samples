section Section1;

shared #"Tooltip Info" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("pZJBT8IwGIb/SrMz8o2Wjs0bARLloEjkYAiHbpRtGWtnW8Dx651pQnBoCnprmqd93u/Nt1x6T9wgzbZcozuUMMNTqWoUK86KtTwIr+NlxlT6HiAvWZofuep+HbjOWFJ0E1k292mEMQQhjeCt3i/iXTfNN62H5zxUpeVSb9X5HkAbqfjt9j6QHgngMRTJ/Nlpl5a7tBe8RrnYbHdcJFzpa+09oNj3Ybpm40XltG8tZ+1zbnZK/K/6PlAa+MDHU1nE7uEt19a3ikfXywc4CEHF0xf24ZZbri3/Y+8YaN8PIA9mRZa5d85y526kmtIbvzjtwF6jQ8YMuvjr1xAECKGQPZTvi6Mzg7DcTxlu1GKIKA5hXkyS4at7dstZ70weuBpW1dU9E8DRIIJ1PZqQkXtGyzWu1Sc=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [nombre = _t, URL = _t, DLINK = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"nombre", type text}, {"URL", type text}, {"DLINK", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Tooltip Info"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;