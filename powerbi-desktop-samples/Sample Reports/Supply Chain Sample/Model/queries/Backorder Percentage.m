let
    Source = Excel.Workbook(File.Contents("C:\Users\juluczni\Documents\Backorders %.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Month", type text}, {"Region", type text}, {"Plant", type text}, {"Product Type", type text}, {"Forecast Bias", type text}, {"Buyer Type", type text}, {"Shipment Destination", type text}, {"Shipment Type", type text}, {"Product ID", type text}, {"Forecast Accuracy", type text}, {"Brand", type text}, {"Backorder %", type number}, {"Distribution Center", type text}, {"Demand Type", type text}})
in
    #"Changed Type"