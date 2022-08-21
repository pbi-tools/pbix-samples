let
    Source = Excel.Workbook(File.Contents("C:\Users\willthom\Microsoft\Gartner Data and Analytics Summit - Bake-off\acaps_covid19_government_measures_dataset.xlsx"), null, true),
    Dataset_Sheet = Source{[Item="Dataset",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Dataset_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"ISO", type text}, {"COUNTRY", type text}, {"REGION", type text}, {"ADMIN_LEVEL_NAME", type text}, {"PCODE", type any}, {"LOG_TYPE", type text}, {"CATEGORY", type text}, {"MEASURE", type text}, {"TARGETED_POP_GROUP", type text}, {"COMMENTS", type text}, {"NON_COMPLIANCE", type text}, {"DATE_IMPLEMENTED", type date}, {"SOURCE", type text}, {"SOURCE_TYPE", type text}, {"LINK", type text}, {"ENTRY_DATE", type date}, {"Alternative source", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"ADMIN_LEVEL_NAME", "PCODE", "LOG_TYPE"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Columns",null,"False",Replacer.ReplaceValue,{"TARGETED_POP_GROUP"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","checked","True",Replacer.ReplaceText,{"TARGETED_POP_GROUP"}),
    #"Renamed Columns" = Table.RenameColumns(#"Replaced Value1",{{"TARGETED_POP_GROUP", "Specific Group Targeted"}, {"MEASURE", "Measure"}, {"CATEGORY", "Category"}}),
    #"Replaced Value2" = Table.ReplaceValue(#"Renamed Columns",null,"Not applicable",Replacer.ReplaceValue,{"NON_COMPLIANCE"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Replaced Value2",{{"DATE_IMPLEMENTED", "Date implemented"}, {"COMMENTS", "Comments"}, {"SOURCE", "Source"}, {"SOURCE_TYPE", "Source type"}, {"ENTRY_DATE", "Entry date"}})
in
    #"Renamed Columns1"