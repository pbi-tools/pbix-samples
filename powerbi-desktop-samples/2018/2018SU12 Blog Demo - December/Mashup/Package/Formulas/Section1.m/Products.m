shared Products = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Products_table = Source{[Name="Products",Signature="table"]}[Data]
in
    Products_table;