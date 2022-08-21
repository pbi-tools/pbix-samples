let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    Product_Table = Source{[Item="Product",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Product_Table,{{"ProductKey", Int64.Type}, {"SKU", type text}, {"Product", type text}, {"Standard Cost", type number}, {"Color", type text}, {"List Price", type number}, {"Model", type text}, {"Subcategory", type text}, {"Category", type text}})
in
    #"Changed Type"