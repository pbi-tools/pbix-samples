section Section1;

shared Association = let
    Source = Excel.Workbook(File.Contents("C:\Users\mimyersm\Dropbox\Data-27-09-2019.xlsx"), null, true),
    Association_Sheet = Source{[Item="Association",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Association_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"RuleID", Int64.Type}, {"LeftItemSetId", Int64.Type}, {"RightItemSetId", Int64.Type}, {"Probability", type number}, {"Importance", type number}, {"Support", Int64.Type}}),
    #"Inserted Merged Column" = Table.AddColumn(#"Changed Type", "Merged", each Text.Combine({Text.From([LeftItemSetId], "en-CA"), Text.From([RightItemSetId], "en-CA")}, ""), type text),
    #"Removed Duplicates" = Table.Distinct(#"Inserted Merged Column", {"Merged"}),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Duplicates",{"Merged"})
in
    #"Removed Columns";

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

shared #"Associated Product" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("ldRZb4JAEAfw78KzcZi9t2/W2Naj1mIPj/igqIgUKohH/fTdpgn7urwQQvILs7P/mfncQ6/h7crycLwDiNNlFN82RfPvZXPcLcOkGX6n5nukCQNUSoB4jMOo1zxkkbdozD3iyhFQM2iX/tvqqdLUVVNQVEvo58ktsJy51y4oJ9CN8mTUrzh3/zvVgkEsHtYdrLhwP7pA8wjWpwvfV1y6Fy+F1JAEcRG0K65qNN7nAkL6Lrv23rT72SWa1p1n3UnxVXH069w7UdDJsvQSW18jdspHCS013OYd651zR4Ci0kB7sdrb5qNz8gggckh/Xgq/a3mN5CkU8OEPR9uV5c7JQ2AoKezOvfZAW+8cPQKEMwW3oxy2fOtrZA8JkTC+5odka71z+CgwxXzI0uHs+WS9c/rM6FAzeVxdp/xml45z+ogZPVSw+jy2cmm9c/oIKKIF3HOcFtx65/SZ/jGN8DoWk/hgfY29h8rUv+7sB1lqfZ3Fx83anZTlfhD9+8Uv", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ProductID = _t, #"Product Image" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ProductID", Int64.Type}, {"Product Image", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"ProductID"}, Product, {"ProductID"}, "Product", JoinKind.LeftOuter),
    #"Expanded Product" = Table.ExpandTableColumn(#"Merged Queries", "Product", {"Product"}, {"Product.1"}),
    #"Renamed Columns" = Table.RenameColumns(#"Expanded Product",{{"Product.1", "Product"}})
in
    #"Renamed Columns";

shared #"Analysis DAX" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Column1 = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Column1"})
in
    #"Removed Columns";

shared Product = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("xZlbU+JKEMe/imXt4+72ZC65nDcuwopCooAG9+xDhAEiIYFcUPj0ZwZxq04lW0UrWz4AIanBmV/9u/vf7c+f57XxWGbZ+ddzQ73c6TQcyzNmisONWzlR75Z6zfN8lf0DEC6DWbiT6Xd9IbN5MF58HydLdX/mUAoWowxYNiw6/vdVPDt2oQFUWAReLo3gKsYtdJgwwZ/vltdzzEIOnBEL/IF3wdhhoSDq7QsnZ9/Ovljk/NfXn+cXL2MZqbu0ik4nmEj1wY/HYwtHwLZ2PSEWZrMMTGFaENV/pCmSq6C2BfWXvvTu/g6eeRDPNAVWRaixDeLD5ZH7tZlgMBzE1m0NuV/DsYBGuS8SHFqHCg43IrBb0V8g5Mayl+RvMikB6qofjvNAXdnHq8jkFoPH0ct6scKJwbbVUZ+ajfVmizuqyYgNu2S6uUFFZxUjRx/034IQJn8zKvIoSRYa4ClExMHi1IaUR/MFSkRaC5Y6Z+HW2r1PA8Ttkoi85FmmXhLGuXpkVjFy00MYmsfLyDFsGN8+bYtnzJYpCFOR6sh2R2ZISIQbcPGUT9rso5BsUlKRVzxGYTaX6aFilRgNinRdJGH2lq2OPC5jnMHWn8otxXEyDdsBLtru3MGFqQpvBnGcLy47H+YkSpz68yCVb2KyTwaKgU2YBSzcxA83uPMawrCg77aKtvg0UGY5dfcX25VG4JwmKdnENGBN89YcuVnTsQU0zHbH739eUhIlPHdhFiYaAal0jsk2iM7qUSEP7ulYo2PZHLxCNC9RQaOslUFM6BGzNTaQ6Ywp2V4NZ+mPD9d/XhbRfZJqC21U2+t3QVKZm5ocwsFktOkiUxJ1YDhdT3yUizwpI6ucuf2662simsDhWqeddipljPPXDoXu3fXDCCUB1XyYjgkX7qB3E2AjzITheOI9LnE8qVrXMNPM7f1ZOco5NtNwo6VhVJprrG50ATZMWBRB3LlGNlmOcpzS9xcP409LQey3cRwrUHtEo2C53Nd7o9JcvyewtEvuxh5HBRYHw1H9Wf3+ub1rfR4gWgKko+nM7V1oIOLD0UWJJSATt5NZjuw7uLBgSu3WGIn1b8bX3lSf1S81G+2aX797UZBPk3R5oDSSUZQ8HzqTow0jERBNRlFjgDutan0NWDQv2WSDOy5XfQtMdhub2Mi/yGyYssud9/hnv3gVhLsg0i2qUWmr8T2+Y6jt+q77coXqshgY2lGncbJ20Xn6ZFFW0eMrzcTxax6q9NPYOZEe93ACV9vuHUF5RbWQKgkVsr99Qg2YTjonomYpD7VURO2HjJVe+l39hgGMKvcfDBcDnuLCxXIEgel4MWNPn9ZvUFKCtE9AtdUqe3tcykg6wXffMzGiWhtcsvkFcrq6b1qWs8hxZ0g92Q6DxOsOot0HUxIry2kgg72caKWr9op0Fb01bkfGDVXNOrhZcIezjoqsYakS1WNOiCptChCxTaiNBs0WsiZWaKnsjPp5qhjpZ5WTa+RcXzWvVBnAWer7HirWmFqoSv99XTYbyBIuVDGD0ZXkg9GH+fCygpJvTd280kpn/b6+TOUHrhJL4+l6fT3F7dlRUZbZtV0fNdA9aV/GWDlrv1qfPb7KXNSTSYzGxJWPJAS2de/+DlXG9XhWh2pv+Zgh/wtiOdyB2XAtQ2T/UspG1Pk/pl//AQ==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Product = _t, ProductID = _t, Category = _t, CategoryID = _t, Segment = _t, SegmentID = _t, #"Product Image" = _t, #"Category Image" = _t, #"Segement Color" = _t, #"Segment image" = _t, Price = _t, #"Price Range" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Product", type text}, {"ProductID", Int64.Type}, {"Category", type text}, {"CategoryID", Int64.Type}, {"Segment", type text}, {"SegmentID", Int64.Type}, {"Product Image", type text}, {"Category Image", type text}, {"Segement Color", type text}, {"Segment image", type text}, {"Price", Int64.Type}})
in
    #"Changed Type";

shared #"Design DAX" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Column1 = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Column1"})
in
    #"Removed Columns";

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
    #"Removed Columns5" = Table.RemoveColumns(#"Renamed Columns2",{"Price"})
in
    #"Removed Columns5";

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

shared STable = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45Wci4tKkrNK1HwSy1RCE7MSS1W0lEyVIrViVZyrSgpSlQIKMpPyywBChopxcYCAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Metric = _t, Sort = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Metric", type text}, {"Sort", Int64.Type}})
in
    #"Changed Type";

shared #"Tooltip Info" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("pZJBT8IwGIb/SrMz8o2Wjs0bARLloEjkYAiHbpRtGWtnW8Dx651pQnBoCnprmqd93u/Nt1x6T9wgzbZcozuUMMNTqWoUK86KtTwIr+NlxlT6HiAvWZofuep+HbjOWFJ0E1k292mEMQQhjeCt3i/iXTfNN62H5zxUpeVSb9X5HkAbqfjt9j6QHgngMRTJ/Nlpl5a7tBe8RrnYbHdcJFzpa+09oNj3Ybpm40XltG8tZ+1zbnZK/K/6PlAa+MDHU1nE7uEt19a3ikfXywc4CEHF0xf24ZZbri3/Y+8YaN8PIA9mRZa5d85y526kmtIbvzjtwF6jQ8YMuvjr1xAECKGQPZTvi6Mzg7DcTxlu1GKIKA5hXkyS4at7dstZ70weuBpW1dU9E8DRIIJ1PZqQkXtGyzWu1Sc=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [nombre = _t, URL = _t, DLINK = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"nombre", type text}, {"URL", type text}, {"DLINK", type text}})
in
    #"Changed Type";

shared #"Tooltip Info2" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45W8kstUQhOzEktVtBVCIwpNTAwMnNU0lHKKCkpKLbS18/MTUxPLc5ITM7WS87P1c/UL8gPKC8IzyhIR1OUWZVapIeuOjfd0shE39zU0kAfoksvPTNNKVYnWikotaS0KI9oS3PDvXLyAlOJttRI38LM1EgfogtiaSwA", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Nombre = _t, URL = _t, DLINK = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Nombre", type text}, {"URL", type text}, {"DLINK", type text}})
in
    #"Changed Type";

shared Details = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("lVXbcpswEP0VDc/OxMF2mjzKgBtNsWEwzmXSPChY2JrIKCNEU/ep39JP65dUK18mDYEQZjxjpLO7hz1npft7By98Esy8wOk5Z+YXxUGCUxLNcGjeXOehV4Ngs3eXEs8iBhYRhzidRMnUhvScOLoJEjQmyA/m39IoNkvD93Bo/yTsWSqNrjl7QWZ51JpzGo1JCFwuOqScykcu2DHzpQ1ZkNPFreXec0J8Fy1S+LJ+be+Qy5NFyUvNCo1CupWVBvhZDe5FYZTAltuYacozJUuZa5NTSFUCetCIvuKrNRTXipa25rAGHSd45pPZV9gddSgb5TnPOBUoVnJZZdoyOP9MYChX0kZ9qUWRWRokE7wzykVjUlLoimv+gwGsrsix64JRhXyqKfJN9xV/rDSXBehclyq4Nb49mNSta3NsqXw5SSVgmkXyqBBIS4SzQ71miaa84JtqY8jy7Ana4tY1MszAoHhPrlkmz/S6PIkF1blUG8A2K5MwIx9bGkMaX2ZbAO8EsdM5J3M7cz1nEuB0kQRz9L3q991z5OEYm/khKQkA4l68F3Qo4ituWjGVS5DKvfwQqtdKVqs1UO23gVMphebPgDtrw+2fv7//IJ/ltBIwBQO3Y8j+CIjpCugPBm1h17ysjLmvGF0yBehhxyL7T0Ep+2nJjT4Z94bkeVv4zZpqRHLAvav1AYcLKra/bL5WeV/RIUWmGC3Zqc92fyC4VfBXwRNeLA05phjSa17+N67Ivue52SygQcNWY0y40EyZbhRAYNhqjrGUTxuqnmC5qyUMs2dBt2jOBMu0GZ+d7hDQag9zCC85fI7xyMTMJtWaFysAdfWJPcfsoQ+Yzi7hWthOtPribZkxtTfL8GOTaJ5ZZFebwE2oKdyDfKdQZ4tIxbLdLTYyDnj4Bw==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [#"Design Factor" = _t, DFSort = _t, Topic = _t, TSort = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"DFSort", Int64.Type}, {"TSort", Int64.Type}})
in
    #"Changed Type";