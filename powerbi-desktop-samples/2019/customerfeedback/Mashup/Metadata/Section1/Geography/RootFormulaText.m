let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Geography_Sheet = Source{[Item="Geography",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Geography_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Geography ID", Int64.Type}, {"Continent", type text}, {"Country-Region", type text}})
in
    #"Changed Type"