section Section1;

shared Orders = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Orders_table = Source{[Name="Orders",Signature="table"]}[Data],
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(Orders_table, [DefaultColumnName = "Orders"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;