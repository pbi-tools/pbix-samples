let
    Source = Csv.Document(Web.Contents("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/locations.csv"),[Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"location", type text}, {"iso_code", type text}, {"vaccines", type text}, {"last_observation_date", type date}, {"source_name", type text}, {"source_website", type text}})
in
    #"Changed Type"