shared Company = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Company_Sheet = Source{[Item="Company",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Company_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Company ID", Int64.Type}, {"Company Size", type text}})
in
    #"Changed Type";