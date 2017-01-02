module View exposing (..)

import Date exposing (Date, fromTime, now)
import Date.Extra exposing (toFormattedString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (toInt)
import Task exposing (perform)
import Time exposing (Time)
import Tuple exposing (..)
import Types exposing (..)


newestRefill : Model -> Refill
newestRefill model =
    List.head model.record.refills ?? ( 0, (Date.fromTime 0.0) )


view : Model -> Html Msg
view model =
    let
        knowDate =
            case model.today of
                Nothing ->
                    True

                Just theTime ->
                    False
    in
        div
            [ style
                [ ( "color", "green" )
                , ( "text-align", "center" )
                , ( "padding", "30px" )
                ]
            ]
            (if knowDate then
                [ welcomeScreen model ]
             else
                [ viewStatus model
                , viewRecord model
                , viewTime model
                ]
            )


viewStatus : Model -> Html Msg
viewStatus model =
    let
        time =
            case model.today of
                Nothing ->
                    ""

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
        (List.map viewRefill model.record.refills)


viewRefill : Refill -> Html Msg
viewRefill ( percent, date ) =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "5px" )
            ]
        ]
        [ text (toString percent)
        , text "% "
        , text (toFormattedString "MMM d, y" date)
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message, noPress ) =
            case String.toInt model.percent of
                Err msg ->
                    ( "red", "Percent must be between 0 and 100", True )

                Ok n ->
                    if n >= 0 && n <= 100 then
                        ( "green", " ", False )
                    else
                        ( "red", "Percent must be between 0 and 100", True )
    in
        div [ style [ ( "padding", "30px" ) ] ]
            [ div
                [ style
                    [ ( "color", color )
                    , ( "text-align", "center" )
                    , ( "font-weight", "bolder" )
                    , ( "font-size", "110%" )
                    ]
                ]
                [ text message ]
            , div [] [ button [ onClick OnSave, disabled noPress ] [ text "Save" ] ]
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
