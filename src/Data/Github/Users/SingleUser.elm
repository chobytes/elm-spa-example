module Data.Github.Users.SingleUser exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias User =
    { login : String
    , id : Int
    , avatar_url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , name : Maybe String
    , company : Maybe String
    , blog : String
    , location : Maybe String
    , email : Maybe String -- only available to authenticated api users --
    , hireable : Maybe Bool -- sometimes null? --
    , bio : Maybe String
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , created_at : String -- need figure out dates >_< --
    , updated_at : String
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
        |> required "gists_url" string
        |> required "starred_url" string
        |> required "subscriptions_url" string
        |> required "organizations_url" string
        |> required "repos_url" string
        |> required "events_url" string
        |> required "received_events_url" string
        |> required "type" string
        |> required "site_admin" bool
        |> required "name" (nullable string)
        |> required "company" (nullable string)
        |> required "blog" string
        |> required "location" (nullable string)
        |> required "email" (nullable string)
        |> required "hireable" (nullable bool)
        |> required "bio" (nullable string)
        |> required "public_repos" int
        |> required "public_gists" int
        |> required "followers" int
        |> required "following" int
        |> required "created_at" string -- not ideal ;~;
        |> required "updated_at" string
