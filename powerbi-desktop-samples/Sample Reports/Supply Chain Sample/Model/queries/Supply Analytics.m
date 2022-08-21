let
    Source = Excel.Workbook(File.Contents("C:\Users\Justyna\Documents\MBAS 2019\Backorders2.xlsx"), null, true),
    #"bank-full2_Sheet" = Source{[Item="Backorders",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"bank-full2_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Manufactured Goods %", type number}, {"Demand Type", type text}, {"Forecast Accuracy", type text}, {"Forecast Bias", type text}, {"Product Advertised", type text}, {"Multiple Retailers", type text}, {"Type", type text}, {"Day Contacted", Int64.Type}, {"Plant", type text}, {"Product ", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Manufactured Goods"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Columns", each true)
in
    #"Filtered Rows"