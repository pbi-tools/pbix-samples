shared #"Order Details" = let
    Source = OData.Feed("http://services.odata.org/V3/Northwind/Northwind.svc/"),
    Order_Details_table = Source{[Name="Order_Details",Signature="table"]}[Data]
in
    Order_Details_table;