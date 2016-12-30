module Main exposing (..)

import Html exposing (program)
import State exposing (subs, update)
import Types exposing (Model, Msg)
import View exposing (view)


main : Program Never Types.Model Types.Msg
main =
    Html.program
        { init = State.init
        , view = View.view
        , update = State.update
        , subscriptions = State.subs
        }
