shared Categories = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Categories_table = Source{[Name="Categories",Signature="table"]}[Data]
in
    Categories_table;