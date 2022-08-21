section Section1;

shared Employee =  let
    Source = Sql.Database(".", "IP", [Query="SELECT dateadd(year, 1, d.date) Date
  ,Market BU
  ,[EmplID]
  ,iif([Gender]='M', 'C', 'D') Gender --  ,iif([Gender]='M', 'F', 'M') Gender
  ,[Age] - (2013 - year(d.date)) Age
  ,[EthnicGroup]
  ,[FP]
  ,dateadd(year, 1, [SenDate]) HireDate
  ,p.PayTypeID
  ,null [TermDate]
  ,null [TermReason]
 FROM [IP].[HR].[AllEmps] E , [HR].[Date] d , [HR].[BU] b , hr.PayGroup p --, hr.TermReason t
 where d.day = 1 and e.SenDate <= d.MonthEndDate and isnull(e.termdate, '9999-01-01') >= d.MonthEndDate and d.Date < '2014-01-01'
  and p.PayGroup = e.PayGroup
  and b.UNIT = e.Unit and [EmplID] % 2 = 0
union all
--seps
SELECT dateadd(year, 1, d.date) Date
    ,Market BU
      ,[EmplID]
      ,iif([Gender]='M', 'C', 'D') Gender
      ,[Age] - (2013 - year(d.date)) Age
      ,[EthnicGroup]
      ,[FP]
      ,dateadd(year, 1,[SenDate]) HireDate
      ,p.PayTypeID
      ,dateadd(year, 1, [TermDate]) [TermDate]
      ,t.[SeparationTypeID] [TermReason]
  FROM [IP].[HR].[AllEmps] E, [HR].[Date] d , [HR].[BU] b, hr.PayGroup p , hr.TermReason t
 where d.day = 1 and e.TermDate <= d.MonthEndDate and e.TermDate >= d.MonthStartDate and d.Date < '2014-01-01'
  and p.PayGroup = e.PayGroup 
  and t.[Term-Discharge]= e.[Term-Discharge]
  and b.UNIT = e.Unit and [EmplID] % 2 = 0"]),
    #"Renamed Columns" = Table.RenameColumns(Source, {{"date", "date"}, {"EmplID", "EmplID"}, {"Gender", "Gender"}, {"Age", "Age"}, {"EthnicGroup", "EthnicGroup"}, {"FP", "FP"}, {"TermDate", "TermDate"}, {"BU", "BU"}, {"HireDate", "HireDate"}, {"PayTypeID", "PayTypeID"}, {"TermReason", "TermReason"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {{"date", type datetime}, {"EmplID", Int64.Type}, {"Gender", type text}, {"Age", Int64.Type}, {"EthnicGroup", type text}, {"FP", type text}, {"TermDate", type datetime}, {"BU", type text}, {"HireDate", type datetime}, {"PayTypeID", type text}, {"TermReason", type text}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Employee"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;