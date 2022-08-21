section Section1;

shared Details = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("lVXbcpswEP0VDc/OxMF2mjzKgBtNsWEwzmXSPChY2JrIKCNEU/ep39JP65dUK18mDYEQZjxjpLO7hz1npft7By98Esy8wOk5Z+YXxUGCUxLNcGjeXOehV4Ngs3eXEs8iBhYRhzidRMnUhvScOLoJEjQmyA/m39IoNkvD93Bo/yTsWSqNrjl7QWZ51JpzGo1JCFwuOqScykcu2DHzpQ1ZkNPFreXec0J8Fy1S+LJ+be+Qy5NFyUvNCo1CupWVBvhZDe5FYZTAltuYacozJUuZa5NTSFUCetCIvuKrNRTXipa25rAGHSd45pPZV9gddSgb5TnPOBUoVnJZZdoyOP9MYChX0kZ9qUWRWRokE7wzykVjUlLoimv+gwGsrsix64JRhXyqKfJN9xV/rDSXBehclyq4Nb49mNSta3NsqXw5SSVgmkXyqBBIS4SzQ71miaa84JtqY8jy7Ana4tY1MszAoHhPrlkmz/S6PIkF1blUG8A2K5MwIx9bGkMaX2ZbAO8EsdM5J3M7cz1nEuB0kQRz9L3q991z5OEYm/khKQkA4l68F3Qo4ituWjGVS5DKvfwQqtdKVqs1UO23gVMphebPgDtrw+2fv7//IJ/ltBIwBQO3Y8j+CIjpCugPBm1h17ysjLmvGF0yBehhxyL7T0Ep+2nJjT4Z94bkeVv4zZpqRHLAvav1AYcLKra/bL5WeV/RIUWmGC3Zqc92fyC4VfBXwRNeLA05phjSa17+N67Ivue52SygQcNWY0y40EyZbhRAYNhqjrGUTxuqnmC5qyUMs2dBt2jOBMu0GZ+d7hDQag9zCC85fI7xyMTMJtWaFysAdfWJPcfsoQ+Yzi7hWthOtPribZkxtTfL8GOTaJ5ZZFebwE2oKdyDfKdQZ4tIxbLdLTYyDnj4Bw==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [#"Design Factor" = _t, DFSort = _t, Topic = _t, TSort = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"DFSort", Int64.Type}, {"TSort", Int64.Type}}),
    AutoRemovedColumns1 = 
    let
        t = Table.FromValue(#"Changed Type", [DefaultColumnName = "Details"]),
        removed = Table.RemoveColumns(t, Table.ColumnsOfType(t, {type table, type record, type list}))
    in
        Table.TransformColumnNames(removed, Text.Clean)
in
    AutoRemovedColumns1;