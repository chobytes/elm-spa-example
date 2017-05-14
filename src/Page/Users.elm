module Page.Users exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ports exposing (getUser)
import Json.Decode as Decode

import Data.Github.Users.SingleUser as User


type alias Model =
    { searchForm : String
    , user : Result String User.User
    }


init : Model
init = Model "" <| Err ""


type Msg = SetSearchForm String
         | SearchUser
         | SetUser (Result String User.User)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetSearchForm data ->
            ({ model | searchForm = data }, Cmd.none)

        SearchUser ->
            let nextModel = { model | searchForm = "" }
            in (nextModel, getUser model.searchForm)

        SetUser (Ok user) ->
            ({ model | user = Ok user }, Cmd.none)

        SetUser (Err e) ->
            ({ model | user = Err e }, Cmd.none)


view : Model -> Html Msg
view model =
    let userRes =
            case model.user of
                Err e -> text e
                Ok user -> text <| toString user
    in div []
        [ h1 [] [ text "Github!" ]
        , fieldset []
            [ legend [] [ text "Find by username" ]
            , input [ value model.searchForm
                    , type_ "text"
                    , onInput SetSearchForm ] []
            , button [ onClick SearchUser ] [ text "Search" ]
            ]
        , userRes
        ]


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map SetUser <| Ports.receiveUser (Decode.decodeValue User.decoder)
