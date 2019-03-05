let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUXLKzMkBUiERSrE60UpGQGY4RMTZESxiDBXJTMwFsSCCJkBmVH4qkPSLVIqNBQA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ID = _t, #"First Name" = _t, State = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ID", Int64.Type}, {"First Name", type text}, {"State", type text}}),
    #"Merged Queries" = Table.FuzzyNestedJoin(#"Changed Type",{"First Name"},Sales,{"Sales Person"},"Sales",JoinKind.LeftOuter,[IgnoreCase=true, IgnoreSpace=true]),
    #"Expanded Sales" = Table.ExpandTableColumn(#"Merged Queries", "Sales", {"ID", "Sales Person", "Sales Amount"}, {"Sales.ID", "Sales.Sales Person", "Sales.Sales Amount"})
in
    #"Expanded Sales"