let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Customers_table = Source{[Name="Customers",Signature="table"]}[Data]
in
    Customers_table