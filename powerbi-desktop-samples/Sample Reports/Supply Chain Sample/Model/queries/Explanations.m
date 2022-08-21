let
    Source = Excel.Workbook(File.Contents("C:\Users\juluczni\Documents\Explanations.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Product ID", Int64.Type}, {"Location", type text}, {"Factor", type text}, {"Risk", Int64.Type}})
in
    #"Changed Type"