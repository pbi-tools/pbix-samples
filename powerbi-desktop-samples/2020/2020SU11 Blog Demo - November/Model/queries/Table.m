let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WclSK1YlWcgKTzkqxsQA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Type = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Type", type text}})
in
    #"Changed Type"