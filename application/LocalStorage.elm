port module LocalStorage exposing (..)


port get : String -> Cmd msg


port receive : (( String, Maybe String ) -> msg) -> Sub msg


port set : ( String, String ) -> Cmd msg
