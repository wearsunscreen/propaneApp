module Refills exposing (..)

import Date exposing (Date)
import Date.Extra
import DateSelectorDropdown
import List
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)


addRefill : Maybe Date -> Float -> List Refill -> List Refill
addRefill date gallons list =
    case date of
        Nothing ->
            list

        Just d ->
            { date = d
            , gallons = gallons
            }
                :: list


jan1_2016 : Date.Date
jan1_2016 =
    Date.fromTime 1451606400.0


minimumDate : Model -> Date
minimumDate model =
    case List.head model.refills of
        Nothing ->
            (Date.Extra.fromCalendarDate 2015 Date.Jan 1)

        Just refill ->
            Debug.log "min date" refill.date


view : Model -> List (Html Msg)
view model =
    [ Html.node "style"
        []
        [ text <|
            String.join " "
                [ "@import url(./propaneApp.css);"
                , "@import url(./date-selector.css);"
                ]
        ]
    , DateSelectorDropdown.view
        ToggleDate
        SelectDate
        model.dateSelector.isOpen
        (minimumDate model)
        (model.today ?? Date.Extra.fromCalendarDate 2050 Date.Jan 1)
        model.dateSelector.selected
    , span [] [ text " " ]
    , button [ onClick AddRefill ] [ text "Ok" ]
    , button [ onClick CloseWelcomeScreen ] [ text "Cancel" ]
    ]
