module State exposing (..)

import Task exposing (..)
import Time exposing (Time)
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


saveSample : Time -> Model -> Model
saveSample time model =
    let
        percent =
            case String.toInt model.percent of
                Ok x ->
                    x

                Err msg ->
                    0
    in
        { model
            | record =
                { version = model.record.version
                , tankSize = model.record.tankSize
                , entries =
                    ( percent, time )
                        :: model.record.entries
                        |> List.sortBy Tuple.second
                }
            , time = Just time
        }


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
            ( saveSample time model, Cmd.none )
