module Main exposing (..)


import Html exposing (Html)

import Model exposing (Model, initModel)
import Subscriptions exposing (subscriptions)
import Update exposing (Msg, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = ( initModel, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        }
