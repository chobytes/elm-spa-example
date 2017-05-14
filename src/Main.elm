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
          | UsersPage
          | SearchPage
          | HomePage
          | Blank

type alias Model =
    { currentPage : Page
    , searchModel : Search.Model
    , usersModel : Users.Model
    }


init : Location -> (Model, Cmd Msg)
init location =
    update (SetRoute <| Router.match location) -- Immediately invoke router
        <| { currentPage = Blank
           , searchModel = Search.init
           , usersModel = Users.init
           }


-- Update

type Msg = SetRoute (Maybe Router.Route)
         | UsersMsg Users.Msg
         | SearchMsg Search.Msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetRoute route ->
            case route of
                Just Router.Search ->
                    ({ model | currentPage = SearchPage }, Cmd.none)

                Just Router.Users ->
                    ({ model | currentPage = UsersPage }, Cmd.none)

                Just Router.Home ->
                    ({ model | currentPage = HomePage }, Cmd.none)

                Nothing ->
                    ({ model | currentPage = NotFound }, Cmd.none)

        UsersMsg subMsg ->
            let (nextModel, subCmd) =
                    Users.update subMsg model.usersModel
            in ({ model | usersModel = nextModel }, Cmd.map UsersMsg subCmd)

        SearchMsg subMsg ->
            let (nextModel, subCmd) =
                    Search.update subMsg model.searchModel
            in ({ model | searchModel = nextModel }, Cmd.map SearchMsg subCmd)




view : Model -> Html Msg
view model =
    div []
        [ Nav.view
        , case model.currentPage of
              Blank -> text ""

              NotFound -> text "404"

              HomePage -> Home.view

              UsersPage ->
                  Users.view model.usersModel |> Html.map UsersMsg

              SearchPage ->
                  Search.view model.searchModel |> Html.map SearchMsg
        ]


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Users.subscriptions model.usersModel |> Sub.map UsersMsg
              , Search.subscriptions model.searchModel |> Sub.map SearchMsg ]
