let
    Source = Csv.Document(Web.Contents("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"),[Delimiter=",", Columns=46, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Filtered Rows" = Table.SelectRows(#"Promoted Headers", each ([RegionName] = "")),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"CountryName", type text}, {"CountryCode", type text}, {"RegionName", type text}, {"RegionCode", type text}, {"Jurisdiction", type text}, {"Date", Int64.Type}, {"C1_School closing", type text}, {"C1_Flag", type text}, {"C2_Workplace closing", type text}, {"C2_Flag", type text}, {"C3_Cancel public events", type text}, {"C3_Flag", type text}, {"C4_Restrictions on gatherings", type text}, {"C4_Flag", type text}, {"C5_Close public transport", type text}, {"C5_Flag", type text}, {"C6_Stay at home requirements", type text}, {"C6_Flag", type text}, {"C7_Restrictions on internal movement", type text}, {"C7_Flag", type text}, {"C8_International travel controls", type text}, {"E1_Income support", type text}, {"E1_Flag", type text}, {"E2_Debt/contract relief", type text}, {"E3_Fiscal measures", type text}, {"E4_International support", type text}, {"H1_Public information campaigns", type text}, {"H1_Flag", type text}, {"H2_Testing policy", type text}, {"H3_Contact tracing", type text}, {"H4_Emergency investment in healthcare", type text}, {"H5_Investment in vaccines", type text}, {"H6_Facial Coverings", type text}, {"H6_Flag", type text}, {"H7_Vaccination policy", type text}, {"H7_Flag", type text}, {"H8_Protection of elderly people", type text}, {"H8_Flag", type text}, {"M1_Wildcard", type text}, {"ConfirmedCases", Int64.Type}, {"ConfirmedDeaths", Int64.Type}, {"StringencyIndex", type number}, {"StringencyIndexForDisplay", type number}, {"StringencyLegacyIndex", type number}, {"StringencyLegacyIndexForDisplay", type number}, {"GovernmentResponseIndex", type number}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"RegionName", "RegionCode", "Jurisdiction"}),
    #"Added Custom" = Table.AddColumn(#"Removed Columns", "School closures", each 
if [C1_School closing] = "0.00" then "No measures"
else if [C1_School closing] = "1.00" then "Recommend closing"
else if [C1_School closing] = "2.00" then "Require closing some levels"
else if [C1_School closing] = "3.00" then "Require closing all"
else "No measures"),
    #"Added Custom1" = Table.AddColumn(#"Added Custom", "Workplace closures", each if [C2_Workplace closing] = "0.00" then "No measures"
else if [C2_Workplace closing] = "1.00" then "Recommend closing"
else if [C2_Workplace closing] = "2.00" then "Require closing some workplaces"
else if [C2_Workplace closing] = "3.00" then "Require closing all"
else "No measures"),
    #"Added Custom2" = Table.AddColumn(#"Added Custom1", "Cancelling public events", each if [C3_Cancel public events] = "0.00" then "No measures"
else if [C3_Cancel public events] = "1.00" then "Recommend cancelling"
else if [C3_Cancel public events] = "2.00" then "Require cancelling"
else "No measures"),
    #"Added Custom3" = Table.AddColumn(#"Added Custom2", "Restrictions on gathering", each if [C4_Restrictions on gatherings] = "0.00" then "No measures"
else if [C4_Restrictions on gatherings] = "1.00" then "No gatherings >1000"
else if [C4_Restrictions on gatherings] = "2.00" then "No gatherings >100"
else if [C4_Restrictions on gatherings] = "3.00" then "No gatherings >10"
else if [C4_Restrictions on gatherings] = "4.00" then "No gatherings"
else "No measures"),
    #"Added Custom4" = Table.AddColumn(#"Added Custom3", "Public transport closures", each if [C5_Close public transport] = "0.00" then "No measures"
else if [C5_Close public transport] = "1.00" then "Recommend closing"
else if [C5_Close public transport] = "2.00" then "Require closing"
else "No measures"),
    #"Added Custom5" = Table.AddColumn(#"Added Custom4", "Stay at home requirements", each if [C6_Stay at home requirements] = "0.00" then "No measures"
else if [C6_Stay at home requirements] = "1.00" then "Recommend not leaving house"
else if [C6_Stay at home requirements] = "2.00" then "Require not leaving house with exceptions"
else if [C6_Stay at home requirements] = "3.00" then "Require not leaving house with minimal exceptions"
else "No measures"),
    #"Added Custom6" = Table.AddColumn(#"Added Custom5", "Internal mov't restrictions", each if [C7_Restrictions on internal movement] = "0.00" then "No measures"
else if [C7_Restrictions on internal movement] = "1.00" then "Recommend not travelling"
else if [C7_Restrictions on internal movement] = "2.00" then "Restricted travelling"
else "No measures"),
    #"Added Custom7" = Table.AddColumn(#"Added Custom6", "International travel controls", each if [C8_International travel controls] = "0.00" then "No measures"
else if [C8_International travel controls] = "1.00" then "Screening arrivals"
else if [C8_International travel controls] = "2.00" then "Quarantine arrivals"
else if [C8_International travel controls] = "3.00" then "Ban arrivals from some regions"
else if [C8_International travel controls] = "4.00" then "Ban all arrivals"
else "No measures"),
    #"Added Custom8" = Table.AddColumn(#"Added Custom7", "Face coverings", each if [H6_Facial Coverings] = "0.00" then "No measures"
else if [H6_Facial Coverings] = "1.00" then "Recommended"
else if [H6_Facial Coverings] = "2.00" then "Required in some spaces"
else if [H6_Facial Coverings] = "3.00" then "Required in public spaces"
else if [H6_Facial Coverings] = "4.00" then "Required outside the home"
else "No measures"),
    #"Added Custom9" = Table.AddColumn(#"Added Custom8", "Vaccination Policy", each if [H7_Vaccination policy] = "0.00" then "No availability"
else if [H7_Vaccination policy] = "1.00" then "One vulnerable groups"
else if [H7_Vaccination policy] = "2.00" then "Two vulnerable groups"
else if [H7_Vaccination policy] = "3.00" then "All vulnerable groups"
else if [H7_Vaccination policy] = "4.00" then "Vulnerable and some others"
else if [H7_Vaccination policy] = "5.00" then "Available to all"
else "No availability")
in
    #"Added Custom9"