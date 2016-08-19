module Model
    exposing
        ( Model
        , init
        , maxMonths
        )


type alias Model =
    { months : Int
    , churnRate : Float
    , initialRevenue : Int
    , customerGrowth : Int
    , revenueGrossMargin : Float
    , cac : Int
    , opCost : Int
    }


init : Model
init =
    { months = 24
    , churnRate = 0.03
    , initialRevenue = 30
    , customerGrowth = 10
    , revenueGrossMargin = 0.75
    , cac = 50
    , opCost = 200
    }


maxMonths : Int
maxMonths =
    100
