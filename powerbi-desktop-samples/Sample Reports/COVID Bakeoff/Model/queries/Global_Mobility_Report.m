let
    Source = Csv.Document(Web.Contents("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv"),[Delimiter=",", Columns=15, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"country_region_code", type text}, {"country_region", type text}, {"sub_region_1", type text}, {"sub_region_2", type text}, {"metro_area", type text}, {"iso_3166_2_code", type text}, {"census_fips_code", type text}, {"place_id", type text}, {"date", type date}, {"retail_and_recreation_percent_change_from_baseline", Int64.Type}, {"grocery_and_pharmacy_percent_change_from_baseline", Int64.Type}, {"parks_percent_change_from_baseline", Int64.Type}, {"transit_stations_percent_change_from_baseline", Int64.Type}, {"workplaces_percent_change_from_baseline", Int64.Type}, {"residential_percent_change_from_baseline", Int64.Type}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"census_fips_code", "place_id", "iso_3166_2_code"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Columns", each ([sub_region_1] = ""))
in
    #"Filtered Rows"