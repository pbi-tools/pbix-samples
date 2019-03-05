shared #"Support Tickets" = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    #"Support Tickets_Sheet" = Source{[Item="Support Tickets",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Support Tickets_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Support Ticket ID", Int64.Type}, {"Customer ID", Int64.Type}, {"Date Created", type date}, {"Date Completed", type date}, {"Escalated", Int64.Type}, {"Duration", Int64.Type}})
in
    #"Changed Type";