module Page.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Html msg
view =
    h1 [] [ text "Meow! Welcome! Navigate somewhere and check it out!" ]
