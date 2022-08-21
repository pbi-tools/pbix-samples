let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    Customer_Table = Source{[Item="Customer",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Customer_Table,{{"CustomerKey", Int64.Type}, {"Customer ID", type text}, {"Customer", type text}, {"City", type text}, {"State-Province", type text}, {"Country-Region", type text}, {"Postal Code", type text}})
in
    #"Changed Type"