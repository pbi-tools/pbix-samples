let
    Source = Excel.Workbook(File.Contents("C:\Users\willthom\Microsoft\Gartner Data and Analytics Summit - Bake-off\acaps_covid19_government_measures_dataset.xlsx"), null, true),
    Dataset_Sheet = Source{[Item="Dataset",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Dataset_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"ISO", type text}, {"COUNTRY", type text}, {"REGION", type text}, {"ADMIN_LEVEL_NAME", type text}, {"PCODE", type any}, {"LOG_TYPE", type text}, {"CATEGORY", type text}, {"MEASURE", type text}, {"TARGETED_POP_GROUP", type text}, {"COMMENTS", type text}, {"NON_COMPLIANCE", type text}, {"DATE_IMPLEMENTED", type date}, {"SOURCE", type text}, {"SOURCE_TYPE", type text}, {"LINK", type text}, {"ENTRY_DATE", type date}, {"Alternative source", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"ISO", "COUNTRY", "REGION"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Added Custom" = Table.AddColumn(#"Removed Duplicates", "Custom", each if [COUNTRY] = "United States" or [COUNTRY] = "Canada" then "North America" else if [REGION] = "Americas" then "Central and South America" else [REGION]),
    #"Renamed Columns" = Table.RenameColumns(#"Added Custom",{{"Custom", "Regions"}}),
    #"Merged Queries" = Table.NestedJoin(#"Renamed Columns", {"ISO"}, #"Table 3", {"Text Between Delimiters"}, "Table 3", JoinKind.LeftOuter),
    #"Expanded Table 3" = Table.ExpandTableColumn(#"Merged Queries", "Table 3", {"Population", "Growth Rate", "FlagURL", "Area (km2)", "Density"}, {"Population", "Growth Rate", "FlagURL", "Area (km2)", "Density"}),
    #"Added Prefix" = Table.TransformColumns(#"Expanded Table 3", {{"FlagURL", each "http://countryflags.azurewebsites.net/" & _, type text}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Prefix",{{"Regions", "Continent"}, {"FlagURL", "Flag"}, {"COUNTRY", "Country"}})
in
    #"Renamed Columns1"