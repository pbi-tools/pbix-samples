let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("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", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [URL = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"URL", type text}})
in
    #"Changed Type"