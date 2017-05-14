module Page.Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Data.Github.Search.Repository as Repo


-- Model

type alias Model =
    { searchForm : String
    , searchType : Maybe SearchType
    , searchResult : Maybe (Result String) }


type SearchType = Repository
                -- | Code
                -- | Commits
                -- | Issues
                -- | Users

type SearchResult = RepositoryData Repo.Repository


init : Model
init =
    { searchForm = ""
    , searchType = Nothing
    , searchResult = Nothing
    }




--

type Msg = SetSearchForm String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetSearchForm data ->
            ({ model | searchForm = data }, Cmd.none)






-- View

view : Model -> Html Msg
view model =
    div []
        [ fieldset []
              [ legend [] [ text "Search Github!" ]
              , input [ value model.searchForm
                      , type_ "text"
                      , onInput SetSearchForm
                      ] []
              , button [] [ text "Search" ]
              ]
        ]
