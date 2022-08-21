section Section1;

shared BU =  let
    Source = Sql.Database(".", "IP", [Query="select distinct market BU,#(lf)  REGIONTITLE Region,#(lf)  MARKETDIRECTOR VP#(lf)from hr.bu"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"BU", "BU"}, {"Region", "RegionSeq"}, {"VP", "VP"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"BU", type text}, {"RegionSeq", type text}, {"VP", type text}})
in
    #"Changed Type";

shared FP =  let
    Source = Sql.Database(".", "IP", [Query="SELECT [HR].[FP].*   FROM [HR].[FP]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"FP", "FP"}, {"FPDesc", "FPDesc"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"FP", type text}, {"FPDesc", type text}})
in
    #"Changed Type";

shared PayType =  let
    Source = Sql.Database(".", "IP", [Query="select distinct PayTypeID, [Hrly-Salaried] PayType#(lf)from [HR].[PayGroup]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"PayTypeID", "PayTypeID"}, {"PayType", "PayType"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"PayTypeID", type text}, {"PayType", type text}})
in
    #"Changed Type";

shared SeparationReason =  let
    Source = Sql.Database(".", "IP", [Query="SELECT distinct SeparationTypeID, [Vol-Invol] SeparationReason#(lf)  FROM [IP].[HR].[TermReason]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"SeparationTypeID", "SeparationTypeID"}, {"SeparationReason", "SeparationReason"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"SeparationTypeID", type text}, {"SeparationReason", type text}})
in
    #"Changed Type";

shared Date =  let
    Source = Sql.Database(".", "IP", [Query="SELECT [HR].[Date].*   FROM [HR].[Date]"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Date", "Date"}, {"Month", "Month"}, {"MonthNumber", "MonthNumber"}, {"Period", "Period"}, {"PeriodNumber", "PeriodNumber"}, {"Qtr", "Qtr"}, {"QtrNumber", "QtrNumber"}, {"Year", "Year"}, {"Day", "Day"}, {"MonthStartDate", "MonthStartDate"}, {"MonthEndDate", "MonthEndDate"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"Date", type datetime}, {"Month", type text}, {"MonthNumber", Int64.Type}, {"Period", type text}, {"PeriodNumber", Int64.Type}, {"Qtr", Int64.Type}, {"QtrNumber", type text}, {"Year", Int64.Type}, {"Day", Int64.Type}, {"MonthStartDate", type datetime}, {"MonthEndDate", type datetime}})
in
    #"Changed Type";

shared Employee =  let
    Source = Sql.Database(".", "IP", [Query="SELECT dateadd(year, 1, d.date) Date#(lf)  ,Market BU#(lf)  ,[EmplID]#(lf)  ,iif([Gender]='M', 'C', 'D') Gender --  ,iif([Gender]='M', 'F', 'M') Gender#(lf)  ,[Age] - (2013 - year(d.date)) Age#(lf)  ,[EthnicGroup]#(lf)  ,[FP]#(lf)  ,dateadd(year, 1, [SenDate]) HireDate#(lf)  ,p.PayTypeID#(lf)  ,null [TermDate]#(lf)  ,null [TermReason]#(lf) FROM [IP].[HR].[AllEmps] E , [HR].[Date] d , [HR].[BU] b , hr.PayGroup p --, hr.TermReason t#(lf) where d.day = 1 and e.SenDate <= d.MonthEndDate and isnull(e.termdate, '9999-01-01') >= d.MonthEndDate and d.Date < '2014-01-01'#(lf)  and p.PayGroup = e.PayGroup#(lf)  and b.UNIT = e.Unit and [EmplID] % 2 = 0#(lf)union all#(lf)--seps#(lf)SELECT dateadd(year, 1, d.date) Date#(lf)    ,Market BU#(lf)      ,[EmplID]#(lf)      ,iif([Gender]='M', 'C', 'D') Gender#(lf)      ,[Age] - (2013 - year(d.date)) Age#(lf)      ,[EthnicGroup]#(lf)      ,[FP]#(lf)      ,dateadd(year, 1,[SenDate]) HireDate#(lf)      ,p.PayTypeID#(lf)      ,dateadd(year, 1, [TermDate]) [TermDate]#(lf)      ,t.[SeparationTypeID] [TermReason]#(lf)  FROM [IP].[HR].[AllEmps] E, [HR].[Date] d , [HR].[BU] b, hr.PayGroup p , hr.TermReason t#(lf) where d.day = 1 and e.TermDate <= d.MonthEndDate and e.TermDate >= d.MonthStartDate and d.Date < '2014-01-01'#(lf)  and p.PayGroup = e.PayGroup #(lf)  and t.[Term-Discharge]= e.[Term-Discharge]#(lf)  and b.UNIT = e.Unit and [EmplID] % 2 = 0"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"date", "date"}, {"EmplID", "EmplID"}, {"Gender", "Gender"}, {"Age", "Age"}, {"EthnicGroup", "EthnicGroup"}, {"FP", "FP"}, {"TermDate", "TermDate"}, {"BU", "BU"}, {"HireDate", "HireDate"}, {"PayTypeID", "PayTypeID"}, {"TermReason", "TermReason"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"date", type datetime}, {"EmplID", Int64.Type}, {"Gender", type text}, {"Age", Int64.Type}, {"EthnicGroup", type text}, {"FP", type text}, {"TermDate", type datetime}, {"BU", type text}, {"HireDate", type datetime}, {"PayTypeID", type text}, {"TermReason", type text}})
in
    #"Changed Type";

shared Ethnicity =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUXIvyi8tUHBUitWJVjKC853AfGM43xnMN4HzXcB8UzjfFcw3g/PdwHxzON9dKTYWAA==", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "Ethnic Group"}, {"Column2", "Ethnicity"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"Ethnic Group", type text}, {"Ethnicity", type text}})
 in
    #"Changed Type";

shared Gender =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WclHSUfJNzEkFUoZKsTrRSs5AlltqLkTISCk2FgA=", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "ID"}, {"Column2", "Gender"}, {"Column3", "Sort"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"ID", type text}, {"Gender", type text}, {"Sort", Int64.Type}})
 in
    #"Changed Type";

shared AgeGroup =  let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WMlTSUYopNTAwTjY2UIrViVYyAgoYG+iaWIJ5xkCeqYG2UmwsAA==", BinaryEncoding.Base64), Compression.Deflate))),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Column1", "AgeGroupID"}, {"Column2", "AgeGroup"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"AgeGroupID", Int64.Type}, {"AgeGroup", type text}})
 in
    #"Changed Type";