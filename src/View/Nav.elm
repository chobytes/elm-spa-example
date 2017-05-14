module View.Nav exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

view : Html msg
view =
    div []
        [ ul []
              [ li [] [ a [ href "#" ] [ text "Home"] ]
              , li [] [ a [ href "#users" ] [ text "Users"] ]
              , li [] [ a [ href "#search" ] [ text "Search" ] ]
              , li [] [ a [ href "#nonesenseurl" ] [ text "404" ] ]
              ]
        ]
