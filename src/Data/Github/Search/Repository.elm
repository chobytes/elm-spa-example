module Data.Github.Search.Repository exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


type alias Repository =
    { id : Int
    , name : String
    , full_name : String
    }
