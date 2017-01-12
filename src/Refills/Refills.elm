module Refills exposing (..)

import DateSelectorDropdown
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)


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
        model.dateSelector.minimum
        model.dateSelector.maximum
        model.dateSelector.selected
    , p [] []
    , div [] [ button [ onClick CloseWelcomeScreen ] [ text "Go Back" ] ]
    ]
