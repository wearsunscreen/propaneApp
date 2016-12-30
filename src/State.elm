module State exposing (..)

import Task exposing (..)
import Time
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { record =
            { version = 1
            , tankSize = 250
            , entries = []
            }
      , time = Nothing
      , percent = ""
      }
    , Cmd.none
    )


subs : Model -> Sub Msg
subs model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterSample percent ->
            ( { model | percent = percent }, Cmd.none )

        OnSave ->
            model ! [ Task.perform StoreSample Time.now ]

        Reset ->
            ( model, Cmd.none )

        StoreSample time ->
            ( { model | time = Just time }, Cmd.none )
