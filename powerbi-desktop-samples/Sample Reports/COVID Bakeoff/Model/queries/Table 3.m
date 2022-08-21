let
    Source = Web.BrowserContents("http://countryflags.azurewebsites.net/"),
    #"Extracted Table From Html" = Html.Table(Source, {{"Country", "[style*=""font-size\:14px""]"}, {"Population", ":nth-last-child(4):nth-child(2) > SPAN[style*=""font-weight\:bold""]:nth-child(1):nth-last-child(1)"}, {"Growth Rate", ".col-md-4 DIV:nth-child(3) *"}, {"FlagURL", "IMG", each [Attributes][src]?}, {"Area (km2)", ".col-md-4 DIV:nth-child(4) *"}, {"Density", ".col-md-4 DIV:nth-child(5) *"}}, [RowSelector=".col-md-4"]),
    #"Changed Type" = Table.TransformColumnTypes(#"Extracted Table From Html",{{"Country", type text}, {"Population", Int64.Type}, {"Growth Rate", type number}, {"FlagURL", type text}, {"Area (km2)", type number}, {"Density", type number}}),
    #"Inserted Text Between Delimiters" = Table.AddColumn(#"Changed Type", "Text Between Delimiters", each Text.BetweenDelimiters([Country], "(", ")"), type text)
in
    #"Inserted Text Between Delimiters"