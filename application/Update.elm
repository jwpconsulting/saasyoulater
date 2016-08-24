module Update exposing (update)

import Model exposing (Model, maxMonths)
import String
import Msg exposing (..)


decodeInt : String -> Int
decodeInt string =
    case String.toInt string of
        Ok value ->
            value

        Err _ ->
            0


decodeIntWithMaximum : String -> Int -> Int
decodeIntWithMaximum string value =
    min (decodeInt string) value


decodePercentage : String -> Float
decodePercentage string =
    case String.toFloat string of
        Ok value ->
            value / 100

        _ ->
            0


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetMonths monthsString ->
            { model | months = decodeIntWithMaximum monthsString maxMonths } ! []

        SetChurnRate churnRate ->
            { model | churnRate = decodePercentage churnRate } ! []

        SetCustomerGrowth customerGrowth ->
            { model | customerGrowth = decodeInt customerGrowth } ! []

        SetRevenue revenue ->
            { model | revenue = decodeInt revenue } ! []

        SetCAC cac ->
            { model | cac = decodeInt cac } ! []

        SetOpCost opCost ->
            { model | opCost = decodeInt opCost } ! []

        SetMargin margin ->
            { model | revenueGrossMargin = decodePercentage margin } ! []
