section Section1;

shared Calendar = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("fZSxisMwDIZfJWQuqSQ7dtztlg6FPkHpkIMbrxyFG+7tq4vcwD9I4IQUvg/kfk5ut5H4qEuI28ByItI1rNPwPY2HkfW6rI/+xOP9oHzxeQFeNp6Tzyfg08YL+XwGPhtffX4Gfrb5dR5x+KLX+euz76TY/OTzFfhqfPX5BfjF5s8+34Bv+/zJ60V6u67P/tfqz/cOXIPR4H0PriFoyL4L10hoWOfEgZHRsNKkU2XP+E/98fPsh4StNefAKGhYbeHAqGhYb1kCY0HDitN81OUYbdv5Xz+8bM1ZfEMIDOnNW2AwGtZcSmAIGtZcj61+DBxje7V/H/2lEmtOLTAyGtacS2DMaFhzSYFR0LDmiQKjoqHN7y8=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Date = _t, Week = _t, #"Month Name" = _t, MonthSort = _t, #"Week of Year" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Date", type datetime}, {"Week", Int64.Type}, {"Month Name", type text}, {"MonthSort", Int64.Type}, {"Week of Year", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Month Name", "Month"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"Week of Year"}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Removed Columns", [DefaultColumnName = "Calendar"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;