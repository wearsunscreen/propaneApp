module Main exposing (..)

import Html exposing (program)
import Model exposing (Model, Msg)
import Update exposing (subs, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = Update.init
        , view = View.view
        , update = Update.update
        , subscriptions = Update.subs
        }
