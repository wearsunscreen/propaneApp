module State exposing (..)

import Date exposing (Date)
import Task exposing (..)
import Time exposing (Time)
import Types exposing (..)


bugbug_RefillValues : List Refill
bugbug_RefillValues =
    let
        testDate : String -> Date
        testDate s =
            case Date.fromString s of
                Ok d ->
                    d

                Err s ->
                    Date.fromTime 0.0
    in
        [ ( 100.0, testDate "Jan 1, 2016" )
        , ( 100.0, testDate "Mar 3, 2016" )
        , ( 10.0, testDate "May 5, 2016" )
        , ( 50.0, testDate "Nov 11, 2016" )
        , ( 100.0, testDate "Dec 11, 2016" )
        ]


init : ( Model, Cmd Msg )
init =
    ( { record =
            { version = 1
            , tankSize = 250
            , refills = bugbug_RefillValues
            }
      , percent = ""
      , recentUsage = Nothing
      , today = Nothing
      }
    , Cmd.none
    )


saveSample : Date -> Model -> Model
saveSample date model =
    let
        percent =
            case String.toFloat model.percent of
                Ok x ->
                    x

                Err msg ->
                    0
    in
        { model
            | record =
                { version = model.record.version
                , tankSize = model.record.tankSize
                , refills =
                    ( percent, date )
                        :: model.record.refills
                        |> List.sortBy (Tuple.second >> Date.toTime)
                }
            , recentUsage = model.recentUsage
            , today = Just date
        }


subs : Model -> Sub Msg
subs model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg = " msg of
        EnterSample percent ->
            ( { model | percent = percent }, Cmd.none )

        OnSave ->
            model ! [ Task.perform ShowStatus Date.now ]

        CloseWelcomeScreen ->
            model ! [ Task.perform ShowStatus Date.now ]

        ShowStatus time ->
            ( saveSample time model, Cmd.none )
