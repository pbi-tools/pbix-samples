let
    Source = OxCGRT_latest,
    #"Removed Columns" = Table.RemoveColumns(Source,{"C1_School closing", "C1_Flag", "C2_Workplace closing", "C2_Flag", "C3_Cancel public events", "C3_Flag", "C4_Restrictions on gatherings", "C4_Flag", "C5_Close public transport", "C5_Flag", "C6_Stay at home requirements", "C6_Flag", "C7_Restrictions on internal movement", "C7_Flag", "C8_International travel controls", "E1_Income support", "E1_Flag", "E2_Debt/contract relief", "E3_Fiscal measures", "E4_International support", "H1_Public information campaigns", "H1_Flag", "H2_Testing policy", "H3_Contact tracing", "H4_Emergency investment in healthcare", "H5_Investment in vaccines", "H6_Facial Coverings", "H6_Flag", "H7_Vaccination policy", "H7_Flag", "H8_Protection of elderly people", "H8_Flag", "M1_Wildcard", "ConfirmedCases", "ConfirmedDeaths", "StringencyIndex", "StringencyIndexForDisplay", "StringencyLegacyIndex", "StringencyLegacyIndexForDisplay", "GovernmentResponseIndex"})
in
    #"Removed Columns"