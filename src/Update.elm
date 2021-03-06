module Update exposing (..)

import Date exposing (..)
import Date.Extra exposing (..)
import List exposing (..)
import Model exposing (..)
import Refills
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
    ( { mode = Welcome
      , record =
            { version = 1
            , tankSize = 250
            , refills = bugbug_RefillValues
            }
      , dateSelector =
            DateSelector
                False
                (fromCalendarDate 2017 Sep 15)
                (fromCalendarDate 2011 Mar 15)
                (Just <| fromCalendarDate 2016 Sep 15)
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


selectDate : Date -> DateSelector -> DateSelector
selectDate date ds =
    { ds | selected = Just date }


toggleDateSelector : DateSelector -> DateSelector
toggleDateSelector ds =
    { ds | isOpen = not ds.isOpen }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterEditRefills ->
            ( { model | mode = EditRefills }, Cmd.none )

        EnterSample percent ->
            ( { model | percent = percent }, Cmd.none )

        OnSave ->
            model ! [ Task.perform ShowStatus Date.now ]

        CloseWelcomeScreen ->
            { model | mode = Status } ! [ Task.perform ShowStatus Date.now ]

        ShowStatus date ->
            ( { model | today = Just date }, Cmd.none )

        SelectDate date ->
            ( { model | dateSelector = selectDate date model.dateSelector }, Cmd.none )

        ToggleDate ->
            ( { model | dateSelector = toggleDateSelector model.dateSelector }, Cmd.none )
