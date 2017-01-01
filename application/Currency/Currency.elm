module Currency.Currency
    exposing
        ( Currency(..)
        , currencies
        )


type Currency
    = USD
    | EUR
    | AUD
    | JPY
    | TRY


currencies : List Currency
currencies =
    [ USD
    , EUR
    , AUD
    , JPY
    , TRY
    ]
