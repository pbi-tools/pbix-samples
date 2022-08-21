let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    Sales_Table = Source{[Item="Sales",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Sales_Table,{{"SalesOrderLineKey", Int64.Type}, {"ResellerKey", Int64.Type}, {"CustomerKey", Int64.Type}, {"ProductKey", Int64.Type}, {"OrderDateKey", Int64.Type}, {"DueDateKey", Int64.Type}, {"ShipDateKey", Int64.Type}, {"SalesTerritoryKey", Int64.Type}, {"Order Quantity", Int64.Type}, {"Unit Price", type number}, {"Extended Amount", type number}, {"Unit Price Discount Pct", Int64.Type}, {"Product Standard Cost", type number}, {"Total Product Cost", type number}, {"Sales Amount", type number}})
in
    #"Changed Type"