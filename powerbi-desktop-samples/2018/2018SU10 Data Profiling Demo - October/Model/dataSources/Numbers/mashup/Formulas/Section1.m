section Section1;

shared Numbers = let
    Source = {1..1000},
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Changed Type" = Table.TransformColumnTypes(#"Converted to Table",{{"Column1", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","60","not a number",Replacer.ReplaceText,{"Column1"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","67","meh",Replacer.ReplaceText,{"Column1"}),
    #"Replaced Value2" = Table.ReplaceValue(#"Replaced Value1","500","blah",Replacer.ReplaceText,{"Column1"}),
    #"Replaced Value3" = Table.ReplaceValue(#"Replaced Value2","999","hello, I am an error",Replacer.ReplaceText,{"Column1"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Replaced Value3",{{"Column1", Int64.Type}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type1", [DefaultColumnName = "Numbers"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;