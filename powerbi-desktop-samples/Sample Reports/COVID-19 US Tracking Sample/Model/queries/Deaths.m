let
    Source = Csv.Document(AzureStorage.BlobContents("https://usafactsstatic.blob.core.windows.net/public/data/covid-19/covid_deaths_usafacts.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Cols = Table.ColumnNames(#"Promoted Headers"),
    ColsUnpivot = List.Skip(Cols,4),
    #"Unpivoted Only Selected Columns" = Table.Unpivot(#"Promoted Headers", ColsUnpivot, "Attribute", "Value"),
    #"Changed Type" = Table.TransformColumnTypes(#"Unpivoted Only Selected Columns",{{"Value", Int64.Type}}),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Changed Type", {"Value"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Errors",{{"Attribute", "Date"}, {"Value", "Deaths"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "FIPS", each Text.PadStart(Text.From([countyFIPS]),5,"0")),
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom",{"countyFIPS"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Removed Columns",{{"Date", type date}})
in
    #"Changed Type1"