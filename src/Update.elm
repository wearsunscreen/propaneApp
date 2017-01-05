module Update exposing (..)

import Date exposing (..)
import Date.Extra exposing (..)
import List exposing (..)
import Model exposing (..)
import Task exposing (..)


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
        sortRefills
            [ { gallons = 100, date = fromCalendarDate 2016 Sep 1 }
            , { gallons = 100, date = fromCalendarDate 2016 Nov 17 }
            , { gallons = 100, date = fromCalendarDate 2016 Dec 12 }
            , { gallons = 100, date = fromCalendarDate 2017 Jan 21 }
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


sortRefills : List Refill -> List Refill
sortRefills list =
    let
        compareRefill : Refill -> Refill -> Order
        compareRefill a b =
            Basics.compare (toTime a.date) (toTime b.date)
    in
        List.sortWith compareRefill list |> List.reverse


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

        ShowStatus date ->
            ( { model | today = Just date }, Cmd.none )
