section Section1;

shared Date =  let
    Source = Sql.Database(".", "IP", [Query="SELECT [HR].[Date].*   FROM [HR].[Date]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Date", "Date"}, {"Month", "Month"}, {"MonthNumber", "MonthNumber"}, {"Period", "Period"}, {"PeriodNumber", "PeriodNumber"}, {"Qtr", "Qtr"}, {"QtrNumber", "QtrNumber"}, {"Year", "Year"}, {"Day", "Day"}, {"MonthStartDate", "MonthStartDate"}, {"MonthEndDate", "MonthEndDate"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"Date", type datetime}, {"Month", type text}, {"MonthNumber", Int64.Type}, {"Period", type text}, {"PeriodNumber", Int64.Type}, {"Qtr", Int64.Type}, {"QtrNumber", type text}, {"Year", Int64.Type}, {"Day", Int64.Type}, {"MonthStartDate", type datetime}, {"MonthEndDate", type datetime}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Date"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;