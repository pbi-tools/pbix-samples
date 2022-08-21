let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    SalesOrder_Table = Source{[Item="SalesOrder",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(SalesOrder_Table,{{"Channel", type text}, {"SalesOrderLineKey", Int64.Type}, {"Sales Order", type text}, {"Sales Order Line", type text}})
in
    #"Changed Type"