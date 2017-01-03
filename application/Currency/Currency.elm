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
    | UAH


currencies : List Currency
currencies =
    [ USD
    , EUR
    , AUD
    , JPY
    , TRY
    , UAH
    ]
