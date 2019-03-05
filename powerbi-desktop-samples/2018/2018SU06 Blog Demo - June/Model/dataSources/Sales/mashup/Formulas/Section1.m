section Section1;

shared Sales = let
    Source = Excel.Workbook(File.Contents("C:\Users\amac\Documents\2016 09 06 Contoso - Sales.xlsx"), null, true),
    Sales_Table = Source{[Item="Sales",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Sales_Table,{{"SalesOrderID", type text}, {"Country", type text}, {"OrderDate", type date}, {"SalesChannelCode", type text}, {"ProdID", Int64.Type}, {"StyleName", type text}, {"CustomerAccountNumber", type text}, {"StoreKey", Int64.Type}, {"ProductLabel", Int64.Type}, {"ProductName", type text}, {"ProductDescription", type text}, {"Manufacturer", type text}, {"BrandName", type text}, {"Class", type text}, {"Color", type text}, {"StockType", type text}, {"Units", Int64.Type}, {"SalesAmount", type number}, {"PurchAgain", Int64.Type}, {"NSAT", Int64.Type}, {"SubCategory", type text}, {"Category", type text}}),
    #"Added Conditional Column" = Table.AddColumn(#"Changed Type", "Custom", each if [SalesAmount] >= 5000 then "Large" else if [SalesAmount] >= 1000 then "Medium" else "Small"),
    #"Renamed Columns" = Table.RenameColumns(#"Added Conditional Column",{{"Custom", "Sale Size"}, {"PurchAgain", "RePurch"}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Renamed Columns", [DefaultColumnName = "Sales"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;