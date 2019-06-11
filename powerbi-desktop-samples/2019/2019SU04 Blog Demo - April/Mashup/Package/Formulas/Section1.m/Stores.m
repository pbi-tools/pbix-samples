shared Stores = let
    Source = Excel.Workbook(File.Contents("C:\Users\amac\OneDrive - Microsoft\Reports and Datasets\2016 09 06 Contoso.xlsx"), null, true),
    Stores_Table = Source{[Item="Stores",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Stores_Table,{{"StoreKey", Int64.Type}, {"GeographyKey", Int64.Type}, {"StoreManager", Int64.Type}, {"StoreType", type text}, {"StoreName", type text}, {"StoreDescription", type text}, {"Status", type text}, {"ZipCode", Int64.Type}, {"ZipCodeExtension", Int64.Type}, {"StorePhone", type text}, {"StoreFax", type text}, {"AddressLine1", type text}, {"AddressLine2", type text}, {"EmployeeCount", Int64.Type}, {"SellingAreaSize", Int64.Type}, {"GeoLocation", type text}, {"Geometry", type text}})
in
    #"Changed Type";