let
    Source = Excel.Workbook(AzureStorage.BlobContents("https://demostoragepbi.blob.core.windows.net/demo/automl%20demo.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Product ID", Int64.Type}, {"Location", type text}, {"Risk Score", type text}, {"Backorder Risk", Int64.Type}, {"Distribution Center", type text}})
in
    #"Changed Type"