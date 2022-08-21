let
    Source = Csv.Document(Web.Contents("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/us_state_vaccinations.csv"),[Delimiter=",", Columns=14, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Removed Other Columns" = Table.SelectColumns(#"Promoted Headers",{"location"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Filtered Rows" = Table.SelectRows(#"Removed Duplicates", each ([location] <> "Bureau of Prisons" and [location] <> "Dept of Defense" and [location] <> "Federated States of Micronesia" and [location] <> "Indian Health Svc" and [location] <> "Long Term Care" and [location] <> "Northern Mariana Islands" and [location] <> "Republic of Palau" and [location] <> "United States" and [location] <> "Veterans Health")),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows",{{"location", "State"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns"," State","",Replacer.ReplaceText,{"State"}),
    #"Merged Queries" = Table.NestedJoin(#"Replaced Value1", {"State"}, #"state population", {"State"}, "Table 1", JoinKind.LeftOuter),
    #"Expanded Table 1" = Table.ExpandTableColumn(#"Merged Queries", "Table 1", {"Population estimate, July 1, 2019[2]"}, {"Population estimate, July 1, 2019[2]"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Expanded Table 1",{{"Population estimate, July 1, 2019[2]", "Population"}}),
    #"Replaced Value" = Table.ReplaceValue(#"Renamed Columns1",null,58791,Replacer.ReplaceValue,{"Population"}),
    #"Added Custom" = Table.AddColumn(#"Replaced Value", "Flag", each "https://www.states101.com/img/flags/gif/small/"&[State]&".gif"),
    #"Replaced Value2" = Table.ReplaceValue(#"Added Custom"," ","-",Replacer.ReplaceText,{"Flag"}),
    #"Lowercased Text" = Table.TransformColumns(#"Replaced Value2",{{"Flag", Text.Lower, type text}}),
    #"Merged Queries1" = Table.NestedJoin(#"Lowercased Text", {"State"}, Lats, {"State"}, "Lats", JoinKind.LeftOuter),
    #"Expanded Lats" = Table.ExpandTableColumn(#"Merged Queries1", "Lats", {"Average Temperature ", "Latitude", "Longitude"}, {"Average Temperature ", "Latitude", "Longitude"})
in
    #"Expanded Lats"