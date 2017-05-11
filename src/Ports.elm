port module Ports exposing (..)

import Json.Decode exposing (Value)

port searchUsers : String -> Cmd msg
port receiveUser : (Value -> msg) -> Sub msg
