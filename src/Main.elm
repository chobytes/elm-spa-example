module Main exposing (..)

import Navigation exposing (..)
import Router
import Html exposing (..)
import Data.Github.Users.SingleUser as User
import Ports
import Json.Decode as Decode

import Page.Home as Home
import Page.Users as Users
import Page.Search as Search
import View.Nav as Nav


main =
    Navigation.program (SetRoute << Router.match)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- Model

type Page = NotFound
          | UsersPage Users.Model
          | SearchPage Search.Model
          | HomePage
          | Blank

type alias Model =
    { page : Page }


init : Location -> (Model, Cmd Msg)
init location =
    -- Immediately invoke router
    update (SetRoute <| Router.match location) { page = Blank }






-- Update

type Msg = SetRoute (Maybe Router.Route)
         | UsersMsg Users.Msg
         | SearchMsg Search.Msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case (msg, model.page) of
        (SetRoute route, _) ->
            case route of
                Just Router.Search ->
                    ({ model | page = SearchPage Search.init }, Cmd.none)

                Just Router.Users ->
                    ({ model | page = UsersPage Users.init }, Cmd.none)

                Just Router.Home ->
                    ({ model | page = HomePage }, Cmd.none)

                Nothing ->
                    ({ model | page = NotFound }, Cmd.none)

        (UsersMsg subMsg, UsersPage subModel) ->
            let (nextModel, subCmd) =
                    Users.update subMsg subModel
            in ({ model | page = UsersPage nextModel }, Cmd.map UsersMsg subCmd)

        (SearchMsg subMsg, SearchPage subModel) ->
            let (nextModel, subCmd) =
                    Search.update subMsg subModel
            in ({ model | page = SearchPage nextModel }, Cmd.map SearchMsg subCmd)

        (_, NotFound) ->
            (model, Cmd.none)

        (_,_) ->
            (model, Cmd.none)




view : Model -> Html Msg
view model =
    div []
        [ Nav.view
        , case model.page of
              Blank -> text ""
              NotFound -> text "404"
              HomePage -> Home.view
              UsersPage subModel -> Users.view subModel |> Html.map UsersMsg
              SearchPage subModel -> Search.view subModel |> Html.map SearchMsg
        ]


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map (UsersMsg << Users.SetUser)
        <| Ports.receiveUser (Decode.decodeValue User.decoder)
