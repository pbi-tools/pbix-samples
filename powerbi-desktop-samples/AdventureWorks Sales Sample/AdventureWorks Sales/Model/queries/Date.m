let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\_Corp Era\Power BI\AW2020 Sample\Sales\AdventureWorks Sales.xlsx"), null, true),
    Date_Table = Source{[Item="Date",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Date_Table,{{"DateKey", Int64.Type}, {"Date", type date}, {"Fiscal Year", type text}, {"Fiscal Quarter", type text}, {"Month", type date}, {"Full Date", type date}, {"MonthKey", Int64.Type}})
in
    #"Changed Type"