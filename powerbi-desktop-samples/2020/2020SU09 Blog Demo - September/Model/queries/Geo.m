let
    Source = Csv.Document(File.Contents("C:\Users\juluczni\Documents\Transactions by Region and City.csv"),[Delimiter=",", Columns=4, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"City", type text}, {"Revenue per transaction", Currency.Type}, {"Transactions", Int64.Type}, {"Region", type text}})
in
    #"Changed Type"