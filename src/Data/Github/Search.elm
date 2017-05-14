module Data.Github.Search exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Data.Github.Search.Repository as Repo


type alias Search a =
    { count_total : Int
    , incomplete_results : Bool
    , items : List a
    }


decodeRepo : Decoder (Search Repo.Repository)
decodeRepo =
    decode Search
        |> required "total_count" int
        |> required "incomplete_results" bool
        |> required "item" (list Repo.decode)
