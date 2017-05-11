module Router exposing (..)

import UrlParser exposing (..)
import Navigation exposing (..)

import UrlParser exposing (..)


type Route = Users

router = oneOf [ Users <$> top ]


match : Location -> Maybe Route
match location =
    case String.isEmpty location.hash of
        True -> Just Users
        False -> parseHash router location


-- Helpers

pure = UrlParser.s

infixl 4 <$>
(<$>) = UrlParser.map

infixl 7 :>
(:>) = (</>)

infixl 8 ?>
(?>) = (<?>)

string = UrlParser.string

int = UrlParser.int
