let
    Source = Csv.Document(File.Contents("C:\Users\willthom\Microsoft\Gartner Data and Analytics Summit - Bake-off\covid-vaccine-willingness.csv"),[Delimiter=",", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Entity", type text}, {"Code", type text}, {"Day", type date}, {"willingness_covid_vaccinate_this_week", type number}})
in
    #"Changed Type"