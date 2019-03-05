shared Role = let
    Source = Excel.Workbook(File.Contents(Filepath), null, true),
    Role_Sheet = Source{[Item="Role",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Role_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Role ID", Int64.Type}, {"Role in Org", type text}})
in
    #"Changed Type";