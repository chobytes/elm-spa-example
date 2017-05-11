module Data.Repository exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

import Data.Github.Repository.Owner as Owner

type alias Repository =
    { id : Int
    , name : String
    , fullname : String
    , owner : Owner
    , private : Bool
    , url : String
    }


decode : Decoder Repository
decode =
    decode Repository
        |> required "id" int
        |> required "name" string
        |> required "fullname" string
        |> required "owner" Owner.decode
        |> required "private" bool
        |> required "url" string
