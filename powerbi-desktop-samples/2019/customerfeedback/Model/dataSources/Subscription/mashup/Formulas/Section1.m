section Section1;

shared Subscription = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Subscription_Sheet = Source{[Item="Subscription",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Subscription_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Subscription ID", Int64.Type}, {"Subscription Type", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Subscription"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared Filepath = "C:\temp\Customer Feedback.xlsx" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true];