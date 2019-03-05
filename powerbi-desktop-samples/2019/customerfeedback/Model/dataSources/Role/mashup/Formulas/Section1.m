section Section1;

shared Role = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Role_Sheet = Source{[Item="Role",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Role_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Role ID", Int64.Type}, {"Role in Org", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Role"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared Filepath = "C:\temp\Customer Feedback.xlsx" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true];