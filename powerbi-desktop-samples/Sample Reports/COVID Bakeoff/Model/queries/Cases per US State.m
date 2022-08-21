let
    Source = Sql.Database("dsna-researchlab-wcu-sqlserver.database.windows.net", "researchlab", [Query="SELECT [Key]#(lf),[GeoLevel]#(lf),[CountyName]#(lf)#(tab)#(tab),[Date]#(lf)#(tab)#(tab),[Date_Day1Case]#(lf)#(tab)#(tab),[Date_Day1Death]#(lf)#(tab)#(tab),[Date_Max]#(lf)                ,[Days_from_Day1Case]#(lf)                ,[Days_from_Day1Death]#(lf)#(tab)#(tab),[CumulativeCases]#(lf)#(tab)#(tab),[CumulativeDeaths]#(lf)#(tab)#(tab),[IncrementalCases]#(lf)#(tab)#(tab),[IncrementalDeaths]#(lf)#(tab)#(tab),[IncrementalCasesNoNegatives]#(lf)#(tab)#(tab),[IncrementalDeathsNoNegatives]#(lf)  FROM [COVID19].[vw_WHO_USAFacts_BingTracker_Data_Combined]"]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Date", type date}, {"Date_Day1Case", type date}, {"Date_Day1Death", type date}, {"Date_Max", type date}, {"CumulativeCases", Int64.Type}, {"CumulativeDeaths", Int64.Type}, {"IncrementalCases", Int64.Type}, {"IncrementalDeaths", Int64.Type}, {"IncrementalCasesNoNegatives", Int64.Type}, {"IncrementalDeathsNoNegatives", Int64.Type}, {"Days_from_Day1Case", Int64.Type}, {"Days_from_Day1Death", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([GeoLevel] = "State")),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"CountyName", "GeoLevel", "Date_Day1Case", "Date_Day1Death", "Date_Max", "Days_from_Day1Case", "Days_from_Day1Death", "IncrementalCases", "IncrementalDeaths"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"IncrementalCasesNoNegatives", "IncrementalCases"}, {"IncrementalDeathsNoNegatives", "IncrementalDeaths"}}),
    #"Inserted Text After Delimiter" = Table.AddColumn(#"Renamed Columns1", "Text After Delimiter", each Text.AfterDelimiter([Key], "_"), type text),
    #"Filtered Rows1" = Table.SelectRows(#"Inserted Text After Delimiter", each ([Key] <> null)),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows1",{{"Text After Delimiter", "State"}}),
    #"Merged Queries" = Table.NestedJoin(#"Renamed Columns", {"State", "Date"}, us_state_vaccinations, {"location", "date"}, "us_state_vaccinations", JoinKind.LeftOuter),
    #"Expanded us_state_vaccinations" = Table.ExpandTableColumn(#"Merged Queries", "us_state_vaccinations", {"total_vaccinations", "total_distributed", "people_vaccinated", "people_fully_vaccinated_per_hundred", "total_vaccinations_per_hundred", "people_fully_vaccinated", "people_vaccinated_per_hundred", "distributed_per_hundred", "daily_vaccinations_raw", "daily_vaccinations", "daily_vaccinations_per_million", "share_doses_used"}, {"total_vaccinations", "total_distributed", "people_vaccinated", "people_fully_vaccinated_per_hundred", "total_vaccinations_per_hundred", "people_fully_vaccinated", "people_vaccinated_per_hundred", "distributed_per_hundred", "daily_vaccinations_raw", "daily_vaccinations", "daily_vaccinations_per_million", "share_doses_used"}),
    #"Renamed Columns2" = Table.RenameColumns(#"Expanded us_state_vaccinations",{{"IncrementalCases", "Incremental cases"}, {"people_fully_vaccinated_per_hundred", "People fully vaccinated per hundred"}}),
    #"Fix New York spike" = Table.ReplaceValue(#"Renamed Columns2",each [Incremental cases],each if [Key]="State_New York" and [Incremental cases]=20184 then 7154 else [Incremental cases],Replacer.ReplaceValue,{"Incremental cases"}),
    #"Fix Minnesota spike" = Table.ReplaceValue(#"Fix New York spike",each [Incremental cases],each 
        if [Key]="State_Minnesota" and [Incremental cases]=0 then 1651 
        else if [Key]="State_Missouri" and [Incremental cases]=50328 then 512 
        else [Incremental cases],Replacer.ReplaceValue,{"Incremental cases"}),
    #"Fix New Jersey spiek" = Table.ReplaceValue(#"Fix Minnesota spike",each [Incremental cases],each if [Key]="State_New Jersey" and [Incremental cases]=51092 then 4215 else [Incremental cases],Replacer.ReplaceValue,{"Incremental cases"})
in
    #"Fix New Jersey spiek"