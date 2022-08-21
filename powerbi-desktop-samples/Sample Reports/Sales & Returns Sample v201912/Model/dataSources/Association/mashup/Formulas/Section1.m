section Section1;

shared Association = let
    Source = Excel.Workbook(File.Contents("C:\Users\mimyersm\Dropbox\Data-27-09-2019.xlsx"), null, true),
    Association_Sheet = Source{[Item="Association",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Association_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"RuleID", Int64.Type}, {"LeftItemSetId", Int64.Type}, {"RightItemSetId", Int64.Type}, {"Probability", type number}, {"Importance", type number}, {"Support", Int64.Type}}),
    #"Inserted Merged Column" = Table.AddColumn(#"Changed Type", "Merged", each Text.Combine({Text.From([LeftItemSetId], "en-CA"), Text.From([RightItemSetId], "en-CA")}, ""), type text),
    #"Removed Duplicates" = Table.Distinct(#"Inserted Merged Column", {"Merged"}),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Duplicates",{"Merged"}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Removed Columns", [DefaultColumnName = "Association"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;