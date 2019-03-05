section Section1;

shared Company = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Company_Sheet = Source{[Item="Company",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Company_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Company ID", Int64.Type}, {"Company Size", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Company"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared Filepath = "C:\temp\Customer Feedback.xlsx" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true];