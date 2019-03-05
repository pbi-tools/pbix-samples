section Section1;

shared Customers = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Customers_table = Source{[Name="Customers",Signature="table"]}[Data],
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(Customers_table, [DefaultColumnName = "Customers"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;