section Section1;

shared Sales = let
    Source = Excel.Workbook(File.Contents("C:\Users\mimyersm\Desktop\Sales & Marketing Datas.xlsx"), null, true),
    Data_Sheet = Source{[Item="Data",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Data_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"ProductID", Int64.Type}, {"StoreID", Int64.Type}, {"Unit", Int64.Type}, {"Week", Int64.Type}, {"Gender", type text}, {"Age", Int64.Type}, {"Status", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type",1,2,Replacer.ReplaceValue,{"Week"}),
    #"Merged Queries" = Table.NestedJoin(#"Replaced Value", {"ProductID"}, Product, {"ProductID"}, "Product", JoinKind.LeftOuter),
    #"Expanded Product" = Table.ExpandTableColumn(#"Merged Queries", "Product", {"Price"}, {"Price"}),
    #"Inserted Multiplication" = Table.AddColumn(#"Expanded Product", "Multiplication", each [Price] * [Unit], Int64.Type),
    #"Renamed Columns" = Table.RenameColumns(#"Inserted Multiplication",{{"Multiplication", "Amount"}}),
    #"Removed Columns" = Table.RemoveColumns(#"Renamed Columns",{"Price"}),
    #"Merged Queries1" = Table.NestedJoin(#"Removed Columns", {"Week"}, Calendar, {"Week"}, "Calendar", JoinKind.LeftOuter),
    #"Expanded Calendar" = Table.ExpandTableColumn(#"Merged Queries1", "Calendar", {"Date"}, {"Date"}),
    #"Removed Columns1" = Table.RemoveColumns(#"Expanded Calendar",{"Week", "Gender", "Age"})
in
    #"Removed Columns1";

shared Store = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("bZLNasNADITfxec0SPsjrY5paaFQSkohl5DDus3B4NjUsUsfv6tk7VKyJ8sLn0Yz0n5fYbWqNnUdz+n7+DMehy62qbwLvGZ21tv043At5MlKqqvDal8Zhdrma2oKFIrx2tWZNaBxxs2UtrqPQx1vIRJvxWQpH4TCDCn9HtvvqTSgMyySKUT6k/KpeIonVXru/jECQYAzA44uo14YSsXLsS/JMFp3RYJFNn5GtM8udpvh/HlsS6D3EK4gpwBhAfXxNY7TUMrCWnA5dnZgYHGlVrexLdmiQCZkW2yQabGFoFQzTKdbqQBANsfOQF4WKVR+259KlJcgIVMklI5kofT1bWrq0rYCIVieY0z7Ws4J1e1D3439uS9Ys4HAzJxmunA67q75GPuhKWXCHn3eG4ulfFSHXw==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ManufacturerID = _t, Manufacturer = _t, Type = _t, Longitude = _t, Latitude = _t, image = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ManufacturerID", Int64.Type}, {"Manufacturer", type text}, {"Type", type text}, {"Longitude", type number}, {"Latitude", type number}, {"image", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"ManufacturerID", "StoreID"}, {"Manufacturer", "Store"}})
in
    #"Renamed Columns";

shared Calendar = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("fZSxisMwDIZfJWQuqSQ7dtztlg6FPkHpkIMbrxyFG+7tq4vcwD9I4IQUvg/kfk5ut5H4qEuI28ByItI1rNPwPY2HkfW6rI/+xOP9oHzxeQFeNp6Tzyfg08YL+XwGPhtffX4Gfrb5dR5x+KLX+euz76TY/OTzFfhqfPX5BfjF5s8+34Bv+/zJ60V6u67P/tfqz/cOXIPR4H0PriFoyL4L10hoWOfEgZHRsNKkU2XP+E/98fPsh4StNefAKGhYbeHAqGhYb1kCY0HDitN81OUYbdv5Xz+8bM1ZfEMIDOnNW2AwGtZcSmAIGtZcj61+DBxje7V/H/2lEmtOLTAyGtacS2DMaFhzSYFR0LDmiQKjoqHN7y8=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Date = _t, Week = _t, #"Month Name" = _t, MonthSort = _t, #"Week of Year" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Date", type datetime}, {"Week", Int64.Type}, {"Month Name", type text}, {"MonthSort", Int64.Type}, {"Week of Year", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Month Name", "Month"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"Week of Year"})
in
    #"Removed Columns";

shared Product = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("xZlbU+JKEMe/imXt4+72ZC65nDcuwopCooAG9+xDhAEiIYFcUPj0ZwZxq04lW0UrWz4AIanBmV/9u/vf7c+f57XxWGbZ+ddzQ73c6TQcyzNmisONWzlR75Z6zfN8lf0DEC6DWbiT6Xd9IbN5MF58HydLdX/mUAoWowxYNiw6/vdVPDt2oQFUWAReLo3gKsYtdJgwwZ/vltdzzEIOnBEL/IF3wdhhoSDq7QsnZ9/Ovljk/NfXn+cXL2MZqbu0ik4nmEj1wY/HYwtHwLZ2PSEWZrMMTGFaENV/pCmSq6C2BfWXvvTu/g6eeRDPNAVWRaixDeLD5ZH7tZlgMBzE1m0NuV/DsYBGuS8SHFqHCg43IrBb0V8g5Mayl+RvMikB6qofjvNAXdnHq8jkFoPH0ct6scKJwbbVUZ+ajfVmizuqyYgNu2S6uUFFZxUjRx/034IQJn8zKvIoSRYa4ClExMHi1IaUR/MFSkRaC5Y6Z+HW2r1PA8Ttkoi85FmmXhLGuXpkVjFy00MYmsfLyDFsGN8+bYtnzJYpCFOR6sh2R2ZISIQbcPGUT9rso5BsUlKRVzxGYTaX6aFilRgNinRdJGH2lq2OPC5jnMHWn8otxXEyDdsBLtru3MGFqQpvBnGcLy47H+YkSpz68yCVb2KyTwaKgU2YBSzcxA83uPMawrCg77aKtvg0UGY5dfcX25VG4JwmKdnENGBN89YcuVnTsQU0zHbH739eUhIlPHdhFiYaAal0jsk2iM7qUSEP7ulYo2PZHLxCNC9RQaOslUFM6BGzNTaQ6Ywp2V4NZ+mPD9d/XhbRfZJqC21U2+t3QVKZm5ocwsFktOkiUxJ1YDhdT3yUizwpI6ucuf2662simsDhWqeddipljPPXDoXu3fXDCCUB1XyYjgkX7qB3E2AjzITheOI9LnE8qVrXMNPM7f1ZOco5NtNwo6VhVJprrG50ATZMWBRB3LlGNlmOcpzS9xcP409LQey3cRwrUHtEo2C53Nd7o9JcvyewtEvuxh5HBRYHw1H9Wf3+ub1rfR4gWgKko+nM7V1oIOLD0UWJJSATt5NZjuw7uLBgSu3WGIn1b8bX3lSf1S81G+2aX797UZBPk3R5oDSSUZQ8HzqTow0jERBNRlFjgDutan0NWDQv2WSDOy5XfQtMdhub2Mi/yGyYssud9/hnv3gVhLsg0i2qUWmr8T2+Y6jt+q77coXqshgY2lGncbJ20Xn6ZFFW0eMrzcTxax6q9NPYOZEe93ACV9vuHUF5RbWQKgkVsr99Qg2YTjonomYpD7VURO2HjJVe+l39hgGMKvcfDBcDnuLCxXIEgel4MWNPn9ZvUFKCtE9AtdUqe3tcykg6wXffMzGiWhtcsvkFcrq6b1qWs8hxZ0g92Q6DxOsOot0HUxIry2kgg72caKWr9op0Fb01bkfGDVXNOrhZcIezjoqsYakS1WNOiCptChCxTaiNBs0WsiZWaKnsjPp5qhjpZ5WTa+RcXzWvVBnAWer7HirWmFqoSv99XTYbyBIuVDGD0ZXkg9GH+fCygpJvTd280kpn/b6+TOUHrhJL4+l6fT3F7dlRUZbZtV0fNdA9aV/GWDlrv1qfPb7KXNSTSYzGxJWPJAS2de/+DlXG9XhWh2pv+Zgh/wtiOdyB2XAtQ2T/UspG1Pk/pl//AQ==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Product = _t, ProductID = _t, Category = _t, CategoryID = _t, Segment = _t, SegmentID = _t, #"Product Image" = _t, #"Category Image" = _t, #"Segement Color" = _t, #"Segment image" = _t, Price = _t, #"Price Range" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Product", type text}, {"ProductID", Int64.Type}, {"Category", type text}, {"CategoryID", Int64.Type}, {"Segment", type text}, {"SegmentID", Int64.Type}, {"Product Image", type text}, {"Category Image", type text}, {"Segement Color", type text}, {"Segment image", type text}, {"Price", Int64.Type}})
in
    #"Changed Type";

shared Customer = let
    Source = Excel.Workbook(File.Contents("C:\Users\mimyersm\Desktop\Sales & Marketing Datas.xlsx"), null, true),
    Data_Sheet = Source{[Item="Data",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Data_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"ProductID", Int64.Type}, {"StoreID", Int64.Type}, {"Unit", Int64.Type}, {"Week", Int64.Type}, {"Gender", type text}, {"Age", Int64.Type}, {"Status", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Status"}),
    #"Merged Queries" = Table.NestedJoin(#"Removed Columns", {"ProductID"}, Product, {"ProductID"}, "Product", JoinKind.LeftOuter),
    #"Expanded Product" = Table.ExpandTableColumn(#"Merged Queries", "Product", {"Product", "Category", "Segment", "Price", "Price Range"}, {"Product.1", "Category", "Segment", "Price", "Price Range"}),
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Product",{{"Product.1", "Product"}}),
    #"Removed Columns1" = Table.RemoveColumns(#"Renamed Columns",{"ProductID"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Columns1","M","Male",Replacer.ReplaceText,{"Gender"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","F","Female",Replacer.ReplaceText,{"Gender"}),
    #"Merged Queries1" = Table.NestedJoin(#"Replaced Value1", {"StoreID"}, Store, {"StoreID"}, "Store", JoinKind.LeftOuter),
    #"Expanded Store" = Table.ExpandTableColumn(#"Merged Queries1", "Store", {"Store", "Type"}, {"Store.1", "Type"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Expanded Store",{{"Store.1", "Store"}}),
    #"Merged Queries2" = Table.NestedJoin(#"Renamed Columns1", {"ID"}, #"Issues and Promotions", {"ID"}, "Issues and Promotions", JoinKind.LeftOuter),
    #"Removed Columns2" = Table.RemoveColumns(#"Merged Queries2",{"StoreID"}),
    #"Expanded Issues and Promotions" = Table.ExpandTableColumn(#"Removed Columns2", "Issues and Promotions", {"Issue", "Promotion"}, {"Issue", "Promotion"}),
    #"Removed Columns3" = Table.RemoveColumns(#"Expanded Issues and Promotions",{"Week"}),
    #"Merged Queries3" = Table.NestedJoin(#"Removed Columns3", {"ID"}, Sales, {"ID"}, "Sales", JoinKind.LeftOuter),
    #"Expanded Sales" = Table.ExpandTableColumn(#"Merged Queries3", "Sales", {"Amount"}, {"Amount"}),
    #"Merged Queries4" = Table.NestedJoin(#"Expanded Sales", {"Age"}, Age, {"Age"}, "Age.1", JoinKind.LeftOuter),
    #"Expanded Age.1" = Table.ExpandTableColumn(#"Merged Queries4", "Age.1", {"Age Bucket"}, {"Age Bucket"}),
    #"Removed Columns4" = Table.RemoveColumns(#"Expanded Age.1",{"Age"}),
    #"Renamed Columns2" = Table.RenameColumns(#"Removed Columns4",{{"Age Bucket", "Age"}}),
    #"Removed Columns5" = Table.RemoveColumns(#"Renamed Columns2",{"Price"}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Removed Columns5", [DefaultColumnName = "Customer"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;

shared #"Issues and Promotions" = let
    Source = Excel.Workbook(File.Contents("C:\Users\mimyersm\Desktop\Sales & Marketing Datas.xlsx"), null, true),
    #"Issues and Promotions_Sheet" = Source{[Item="Issues and Promotions",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Issues and Promotions_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"Issue", type text}, {"Promotion", type text}})
in
    #"Changed Type";

shared Age = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("dc8rDsAgEIThqxA0AnZZHmchCER1k7amty+gaMKYEZ/6pxTtRJs+6jkVWfUe7bp1Nd0D8Ag8Ac97JwvcdSc3XVYn4AzcAxfg4y+F4fzricAT8Lx3tsDHX549vPYwAWfgHrhsvH4=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Age = _t, #"Age Bucket" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Age", Int64.Type}, {"Age Bucket", type text}})
in
    #"Changed Type";