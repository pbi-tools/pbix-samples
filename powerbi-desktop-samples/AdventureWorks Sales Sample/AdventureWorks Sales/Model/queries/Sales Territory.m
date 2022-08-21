let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    SalesTerritory_Table = Source{[Item="SalesTerritory",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(SalesTerritory_Table,{{"SalesTerritoryKey", Int64.Type}, {"Region", type text}, {"Country", type text}, {"Group", type text}})
in
    #"Changed Type"