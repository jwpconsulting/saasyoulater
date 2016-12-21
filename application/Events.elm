module Events exposing (onSelect)

import Html
import Html.Events
import Json.Decode


emptyIsNothing : String -> Maybe String
emptyIsNothing s =
    if s == "" then
        Nothing
    else
        Just s


maybeTargetValue : Json.Decode.Decoder (Maybe String)
maybeTargetValue =
    Json.Decode.map emptyIsNothing Html.Events.targetValue


onSelect : (Maybe String -> msg) -> Html.Attribute msg
onSelect f =
    Html.Events.on "change" (Json.Decode.map f maybeTargetValue)
