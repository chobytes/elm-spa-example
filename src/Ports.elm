port module Ports exposing (..)

import Json.Decode exposing (Value)

port getUser : String -> Cmd msg
port receiveUser : (Value -> msg) -> Sub msg

port search : String -> Cmd msg
port getSearchResult : (Value -> msg) -> Sub msg
