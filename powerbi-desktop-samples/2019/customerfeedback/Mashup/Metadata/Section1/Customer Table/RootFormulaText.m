let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    #"Customer Table_Sheet" = Source{[Item="Customer Table",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Customer Table_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Customer ID", Int64.Type}, {"Tenure", Int64.Type}, {"Geography ID", Int64.Type}, {"Completed tutorial", type text}, {"Subscription ID", Int64.Type}, {"Role", Int64.Type}, {"Company ID", Int64.Type}, {"Rating", type text}, {"Theme", type text}, {"Original Score", Int64.Type}})
in
    #"Changed Type"