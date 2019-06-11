section Section1;

shared Products = let
    Source = Excel.Workbook(File.Contents("C:\Users\amac\OneDrive - Microsoft\Reports and Datasets\2016 09 06 Contoso.xlsx"), null, true),
    Products_Table = Source{[Item="Products",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Products_Table,{{"ProductKey", Int64.Type}, {"ProductLabel", Int64.Type}, {"ProductName", type text}, {"ProductDescription", type text}, {"Manufacturer", type text}, {"BrandName", type text}, {"Class", type text}, {"StyleName", Int64.Type}, {"ColorName", type text}, {"StockTypeName", type text}, {"UnitCost", type number}, {"UnitPrice", type number}, {"SubCategory", type text}, {"GeneralCategory", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Products"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;