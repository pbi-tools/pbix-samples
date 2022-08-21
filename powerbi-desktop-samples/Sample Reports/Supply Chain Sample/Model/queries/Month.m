let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlfSUfJKzCtNLKpUitWJVrIA8t1Sk4rgApZAAd/EouQMMM/QAMh1LCjKzIFwDcGyEJWGRiCzSvNSY/JAJEQMLJQDUQCSdyxNLy0uAXONgdzg1IKS1Nyk1CKwiAlQxD+5JB/GNwXy/fLLEArMgAIuqclQgVgA", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ID = _t, Month = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ID", Int64.Type}, {"Month", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","June#(lf)June","June",Replacer.ReplaceText,{"Month"})
in
    #"Replaced Value"