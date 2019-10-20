let
    Source = Excel.Workbook(File.Contents("C:\Users\amac\OneDrive - Microsoft\Reports and Datasets\2016 09 06 Contoso.xlsx"), null, true),
    Inventory_Table = Source{[Item="Inventory",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Inventory_Table,{{"InventoryRecID", Int64.Type}, {"InvDate", type date}, {"StoreKey", Int64.Type}, {"ProductKey", Int64.Type}, {"ComboKey", type number}, {"OnHandQuantity", Int64.Type}, {"OnOrderQuantity", Int64.Type}, {"SafetyStockQuantity", Int64.Type}, {"UnitCost", type number}, {"DaysInStock", Int64.Type}, {"MinDayInStock", Int64.Type}, {"MaxDayInStock", Int64.Type}, {"Aging", Int64.Type}})
in
    #"Changed Type"