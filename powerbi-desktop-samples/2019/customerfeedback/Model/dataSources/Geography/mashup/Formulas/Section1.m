section Section1;

shared Geography = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Geography_Sheet = Source{[Item="Geography",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Geography_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Geography ID", Int64.Type}, {"Continent", type text}, {"Country-Region", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Geography"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared Filepath = "C:\temp\Customer Feedback.xlsx" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true];