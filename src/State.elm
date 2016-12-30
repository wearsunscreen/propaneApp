module State exposing (..)

import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model "", Cmd.none )


subs : Model -> Sub Msg
subs model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        m =
            case msg of
                SaveSample ->
                    model

                SetSample percent ->
                    { model | percent = percent }

                Reset ->
                    model
    in
        ( m, Cmd.none )
