module View exposing (..)

import Date exposing (Date, fromTime, now)
import Date.Extra exposing (..)
import DateSelectorDropdown
import Debug as D exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Refills
import Result exposing (..)
import String exposing (toInt)


getRateDays : Model -> Result String ( Float, Date )
getRateDays model =
    case model.refills of
        [] ->
            Err "no refills"

        [ r1 ] ->
            Err "no refills"

        r1 :: r2 :: rest ->
            let
                daysBetweenLastFills =
                    log "daysBetweenLastFills" (diff Date.Extra.Day (log "r2" r2.date) (log "r1" r1.date))

                galsPerDay =
                    Debug.log "galsPerDay"
                        ((toFloat (truncate (r1.gallons / (toFloat daysBetweenLastFills) * 10))) / 10)

                daysToNextFill =
                    ((toFloat model.tankSize) * 0.55) / galsPerDay |> truncate

                dateOfNextRefill =
                    Date.Extra.add Day daysToNextFill r1.date
            in
                Ok ( galsPerDay, dateOfNextRefill )


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "30px" )
            ]
        ]
        (case model.mode of
            Welcome ->
                [ welcomeScreen model ]

            Status ->
                [ viewStatus model
                , viewRecord model
                ]

            EditRefills ->
                Refills.view model
        )


viewStatus : Model -> Html Msg
viewStatus model =
    case getRateDays model of
        Err s ->
            div
                [ style
                    [ ( "color", "red" )
                    , ( "text-align", "center" )
                    , ( "font-size", "140%" )
                    , ( "padding", "30px" )
                    ]
                ]
                [ text "Cannot calculate usage before the second refill" ]

        Ok ( rate, refillDate ) ->
            div
                [ style
                    [ ( "color", "green" )
                    , ( "text-align", "center" )
                    , ( "font-size", "180%" )
                    , ( "padding", "30px" )
                    ]
                ]
                [ text ("Call to refill on " ++ (toFormattedString "MMM d, y" refillDate))
                , p [] []
                , text (toString rate ++ " gallons used per day.")
                , p [] []
                , div [] [ button [ onClick EnterAddRefills ] [ text "Add Refill" ] ]
                ]


viewTime : Model -> Html Msg
viewTime model =
    let
        time =
            case model.today of
                Nothing ->
                    "Today is ??"

                Just theTime ->
                    toString theTime
    in
        div
            [ style
                [ ( "color", "green" )
                , ( "text-align", "center" )
                , ( "padding", "30px" )
                ]
            ]
            [ text time ]


viewRecord : Model -> Html Msg
viewRecord model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "30px" )
            ]
        ]
        (List.map viewRefill model.refills)


viewRefill : Refill -> Html Msg
viewRefill refill =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "5px" )
            ]
        ]
        [ text (toString refill.gallons)
        , text " gallons on "
        , text (toFormattedString "MMM d, y" refill.date)
        ]


welcomeScreen : Model -> Html Msg
welcomeScreen model =
    div [ style [ ( "padding", "30px" ) ] ]
        [ div
            [ style
                [ ( "color", "green" )
                , ( "text-align", "center" )
                , ( "font-weight", "bolder" )
                , ( "font-size", "220%" )
                ]
            ]
            [ text "Welcome to Propane!" ]
        , div [] [ button [ onClick CloseWelcomeScreen ] [ text "Ok" ] ]
        ]
