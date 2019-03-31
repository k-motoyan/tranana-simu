module Subscriptions exposing (subscriptions)


import Model exposing (Model)
import Port exposing (setModel)
import Update exposing (Msg(SetModel))


subscriptions : Model -> Sub Msg
subscriptions model = setModel SetModel
