module Currency.Currency
    exposing
        ( Currency(..)
        , currencies
        )


type Currency
    = USD
    | AUD
    | EUR
    | INR
    | JPY
    | TRY
    | UAH
    | VND


currencies : List Currency
currencies =
    [ USD
    , AUD
    , EUR
    , INR
    , JPY
    , TRY
    , UAH
    , VND
    ]
