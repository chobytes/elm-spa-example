module Data.Repository.Owner exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


type alias Owner =
    { login : String
    , id : Int
    , url : String
    }


decode : Decoder Owner
decode =
    decode Owner
        |> required "login" string
        |> required "id" int
        |> required "url" string
