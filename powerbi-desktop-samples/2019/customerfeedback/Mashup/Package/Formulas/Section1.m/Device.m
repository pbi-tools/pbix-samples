shared Device = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Device_Sheet = Source{[Item="Device",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Device_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"Customer ID", Int64.Type}, {"device", type text}})
in
    #"Changed Type";