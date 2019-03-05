section Section1;

shared Categories = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Categories_table = Source{[Name="Categories",Signature="table"]}[Data],
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(Categories_table, [DefaultColumnName = "Categories"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;