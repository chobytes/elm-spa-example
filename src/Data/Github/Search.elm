module Data.Github.Search exposing (..)

import Json.Decode exposing (..)
--import Json.Decode.Extra exposing (..)
import Json.Decode.Pipeline exposing (..)
import Result as Result
import Data.Github.Search.Repository as Repo

type alias SearchResult =
    { count_total : Int
    , incomplete_results : Bool
    , items : List Repository
    }

decoder : Decoder SearchResult
decoder =
    decode SearchResult
        |> required "total_count" int
        |> required "incomplete_results" bool
        |> required "items" (list repoDecoder)





type alias Repository =
    { id : Int
    , name : String
    , full_name : String
    }

repoDecoder : Decoder Repository
repoDecoder =
    decode Repository
        |> required "id" int
        |> required "name" string
        |> required "full_name" string
