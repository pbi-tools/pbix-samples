let
    Source = Excel.Workbook(File.Contents("C:\Users\jterh\OneDrive - Microsoft\Downloads\Hotel Bookings.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Promo Code", type text}, {"Status", type text}, {"Lead time", Int64.Type}, {"Purchase Year", Int64.Type}, {"Purchase month name", type text}, {"Purchase week number", Int64.Type}, {"Purchase day of the month", Int64.Type}, {"Stays in weekend nights", Int64.Type}, {"Stays in week nights", Int64.Type}, {"Adults", Int64.Type}, {"Children", Int64.Type}, {"Babies", Int64.Type}, {"Brand", type text}, {"Country of origin", type text}, {"Product Type", type text}, {"Age Group", type text}, {"Is repeated guest", type text}, {"Previous cancelations", Int64.Type}, {"Previous bookings not canceled", Int64.Type}, {"Reserved room type code", type text}, {"Assigned room type code", type text}, {"Booking changes", Int64.Type}, {"Customer Segment", type text}, {"City", type text}, {"Agent", Int64.Type}, {"Company", type text}, {"Days in waiting list", Int64.Type}, {"Region", type text}, {"Average Daily Rate", type number}, {"Required parking spaces", Int64.Type}, {"Total of special requests", Int64.Type}, {"Reservation status", type text}, {"Reservation status date", type date}, {"No. of Guests", Int64.Type}, {"Purchase month", Int64.Type}, {"Purchase date", type date}, {"Booking ID", Int64.Type}, {"Revenue", type number}, {"Assigned room type", type text}, {"Purchase Size", type text}, {"Loyalty card", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Booking ID", "Transaction ID"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Purchase", each Date.AddMonths([Purchase date], 32)),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Custom",{{"Purchase", "Purchasing Date"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns1",{{"Purchasing Date", type date}}),
    #"Renamed Columns2" = Table.RenameColumns(#"Changed Type1",{{"Country of origin", "Country"}, {"Is repeated guest", "Repeat customer"}, {"Transaction ID", "Customer"}, {"Average Daily Rate", "Time Spent on Website"}, {"Revenue", "Revenue Total"}, {"Product Type", "Product"}})
in
    #"Renamed Columns2"