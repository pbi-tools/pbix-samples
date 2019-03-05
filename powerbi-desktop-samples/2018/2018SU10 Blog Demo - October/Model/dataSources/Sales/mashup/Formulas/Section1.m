section Section1;

shared Sales = let
    Source = Excel.Workbook(File.Contents("C:\Users\amac\OneDrive - Microsoft\Reports and Datasets\2016 09 06 Contoso.xlsx"), null, true),
    Sales_Table = Source{[Item="Sales",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Sales_Table,{{"SalesOrderID", type text}, {"Country", type text}, {"OrderDate", type date}, {"SalesChannelCode", type text}, {"ProdID", Int64.Type}, {"StyleName", type text}, {"CustomerAccountNumber", type text}, {"StoreKey", Int64.Type}, {"ProductLabel", Int64.Type}, {"ProductName", type text}, {"ProductDescription", type text}, {"Manufacturer", type text}, {"BrandName", type text}, {"Class", type text}, {"Color", type text}, {"StockType", type text}, {"Units", Int64.Type}, {"SalesAmount", type number}, {"NSAT", Int64.Type}, {"SubCategory", type text}, {"Category", type text}}),
    #"Added Conditional Column" = Table.AddColumn(#"Changed Type", "Custom", each if [SalesAmount] >= 5000 then "Large" else if [SalesAmount] >= 1000 then "Medium" else "Small"),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Added Conditional Column", "ProductName", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, true), {"ProductName.1", "ProductName.2"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"ProductName.1", type text}, {"ProductName.2", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"ProductName.2"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"ProductName.1", "ProductName"}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Renamed Columns1", [DefaultColumnName = "Sales"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;