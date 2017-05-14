module Page.Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ports
import Json.Decode as Decode

import Data.Github.Search as Search


-- Model

type alias Model =
    { searchForm : String
    , searchResult : Maybe (Result String Search.SearchResult)
    }



init : Model
init =
    { searchForm = ""
    , searchResult = Nothing
    }



-- Update
type Msg = SetSearchForm String
         | SetSearchResult (Result String Search.SearchResult)
         | Search


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetSearchForm data ->
            ({ model | searchForm = data }, Cmd.none)

        SetSearchResult res ->
            ({ model | searchResult = Just res }, Cmd.none)

        Search -> (model, Ports.search model.searchForm)



-- View
view : Model -> Html Msg
view model =
    let res = case model.searchResult of
                  Just (Ok repo) -> text <| toString repo
                  Just (Err e) -> text <| toString e
                  Nothing -> text ""
    in div []
        [ fieldset []
              [ legend [] [ text "Search Github!" ]
              , input [ value model.searchForm
                      , type_ "text"
                      , onInput SetSearchForm
                      ] []
              , button [ onClick Search ] [ text "Search" ]
              ]
        , p [] [res]
        ]




-- Subscriptions --
subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.getSearchResult (Decode.decodeValue Search.decoder)
        |> Sub.map SetSearchResult
