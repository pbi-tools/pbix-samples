shared Subscription = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Subscription_Sheet = Source{[Item="Subscription",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Subscription_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Subscription ID", Int64.Type}, {"Subscription Type", type text}})
in
    #"Changed Type";