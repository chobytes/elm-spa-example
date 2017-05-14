module Data.Github.Search.Repository exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
--import Data.Github.Search

type alias Repository =
    { id : Int
    , name : String
    , full_name : String
    }


decoder : Decoder Repository
decoder =
    decode Repository
        |> required "id" int
        |> required "name" string
        |> required "full_name" string
