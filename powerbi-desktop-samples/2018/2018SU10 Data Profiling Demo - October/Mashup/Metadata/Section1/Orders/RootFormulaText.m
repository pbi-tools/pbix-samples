let
    Source = OData.Feed("http://services.odata.org/V4/Northwind/Northwind.svc/"),
    Orders_table = Source{[Name="Orders",Signature="table"]}[Data]
in
    Orders_table