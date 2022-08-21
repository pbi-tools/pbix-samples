let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    Reseller_Table = Source{[Item="Reseller",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Reseller_Table,{{"ResellerKey", Int64.Type}, {"Reseller ID", type text}, {"Business Type", type text}, {"Reseller", type text}, {"City", type text}, {"State-Province", type text}, {"Country-Region", type text}, {"Postal Code", type text}})
in
    #"Changed Type"