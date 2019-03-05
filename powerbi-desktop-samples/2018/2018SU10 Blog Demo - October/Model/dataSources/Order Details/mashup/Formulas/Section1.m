section Section1;

shared #"Order Details" = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Order_Details_table = Source{[Name="Order_Details",Signature="table"]}[Data],
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(Order_Details_table, [DefaultColumnName = "Order Details"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;