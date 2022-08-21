let
    Source = Sql.Database("dsna-researchlab-wcu-sqlserver.database.windows.net", "researchlab", [Query="SELECT [Key]#(lf),[GeoLevel]#(lf),[CountyName]#(lf)#(tab)#(tab),[Date]#(lf)#(tab)#(tab),[Date_Day1Case]#(lf)#(tab)#(tab),[Date_Day1Death]#(lf)#(tab)#(tab),[Date_Max]#(lf)                ,[Days_from_Day1Case]#(lf)                ,[Days_from_Day1Death]#(lf)#(tab)#(tab),[CumulativeCases]#(lf)#(tab)#(tab),[CumulativeDeaths]#(lf)#(tab)#(tab),[IncrementalCases]#(lf)#(tab)#(tab),[IncrementalDeaths]#(lf)#(tab)#(tab),[IncrementalCasesNoNegatives]#(lf)#(tab)#(tab),[IncrementalDeathsNoNegatives]#(lf)  FROM [COVID19].[vw_WHO_USAFacts_BingTracker_Data_Combined]"]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Date", type date}, {"Date_Day1Case", type date}, {"Date_Day1Death", type date}, {"Date_Max", type date}, {"CumulativeCases", Int64.Type}, {"CumulativeDeaths", Int64.Type}, {"IncrementalCases", Int64.Type}, {"IncrementalDeaths", Int64.Type}, {"IncrementalCasesNoNegatives", Int64.Type}, {"IncrementalDeathsNoNegatives", Int64.Type}, {"Days_from_Day1Case", Int64.Type}, {"Days_from_Day1Death", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([GeoLevel] = "Country")),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"CountyName", "Date_Day1Case", "Date_Day1Death", "Date_Max", "Days_from_Day1Case", "Days_from_Day1Death", "IncrementalCasesNoNegatives", "IncrementalDeathsNoNegatives"}),
    #"Inserted Text After Delimiter" = Table.AddColumn(#"Removed Columns", "Text After Delimiter", each Text.AfterDelimiter([Key], "_"), type text),
    #"Filtered Rows1" = Table.SelectRows(#"Inserted Text After Delimiter", each ([Key] <> null)),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows1",{{"Text After Delimiter", "Country"}}),
    #"Replaced Value" = Table.ReplaceValue(#"Renamed Columns","The United Kingdom","United Kingdom",Replacer.ReplaceText,{"Country"})
in
    #"Replaced Value"