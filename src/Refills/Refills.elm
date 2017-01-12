module Refills exposing (..)

import Date
import Date.Extra
import DateSelectorDropdown
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)


addRefill : List Refill -> List Refill
addRefill list =
    list


jan1_2016 : Date.Date
jan1_2016 =
    Date.fromTime 1451606400.0


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
        (Date.Extra.fromCalendarDate 2015 Date.Jan 1)
        (model.today ?? Date.Extra.fromCalendarDate 2100 Date.Jan 1)
        model.dateSelector.selected
    , span [] [ text " " ]
    , button [ onClick AddRefill ] [ text "Ok" ]
    , button [ onClick CloseWelcomeScreen ] [ text "Cancel" ]
    ]
