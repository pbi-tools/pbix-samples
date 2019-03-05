section Section1;

shared Device = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Device_Sheet = Source{[Item="Device",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Device_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"Customer ID", Int64.Type}, {"device", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Device"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared Filepath = "C:\temp\Customer Feedback.xlsx" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true];