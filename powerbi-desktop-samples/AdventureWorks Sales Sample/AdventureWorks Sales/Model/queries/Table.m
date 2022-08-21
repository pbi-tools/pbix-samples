let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WckxOTi0uzi/KTC1W0lEyUYrViVZyyswG8wzBPOec/JKMzLx0oIAxRCA/tyA/LzWvBKTGSCk2FgA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Category = _t, Sorting = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Category", type text}, {"Sorting", Int64.Type}})
in
    #"Changed Type"