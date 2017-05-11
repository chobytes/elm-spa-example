module Data.User exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias User =
    { login : String
    , id : Int
    , avatar_url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    }


decoder : Decoder User
decoder =
    decode User
        |> required "login" string
        |> required "id" int
        |> required "avatar_url" string
        |> required "html_url" string
        |> required "followers_url" string
        |> required "following_url" string
