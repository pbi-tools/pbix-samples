section Section1;

shared Products = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Products_table = Source{[Name="Products",Signature="table"]}[Data],
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(Products_table, [DefaultColumnName = "Products"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;