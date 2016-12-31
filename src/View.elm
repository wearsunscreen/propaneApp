module View exposing (..)

import Date
import Date.Extra exposing (toFormattedString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (toInt)
import Time exposing (Time)
import Tuple exposing (..)
import Types exposing (..)


newestEntry : Model -> Entry
newestEntry model =
    List.head model.record.entries ?? ( 0, 0 )


promptPercent : Model -> Html Msg
promptPercent model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "font-weight", "bolder" )
            , ( "font-size", "200%" )
            , ( "padding", "30px" )
            ]
        ]
        [ text "What is your tank level today?"
        , input [ type_ "text", placeholder "percent full", onInput EnterSample ] []
        , text "%"
        , viewValidation model
        ]


view : Model -> Html Msg
view model =
    let
        sameDay : Time -> Time -> Bool
        sameDay t1 t2 =
            let
                s1 =
                    toFormattedString "M d y" (Date.fromTime t1)

                s2 =
                    toFormattedString "M d y" (Date.fromTime t2)
            in
                s1 /= s2

        prompt =
            case model.time of
                Nothing ->
                    True

                Just theTime ->
                    sameDay theTime (Tuple.second (newestEntry model))
    in
        div
            [ style
                [ ( "color", "green" )
                , ( "text-align", "center" )
                , ( "padding", "30px" )
                ]
            ]
            [ if prompt then
                promptPercent model
              else
                viewStatus model
            , viewRecord model
            , viewTime model
            ]


viewStatus : Model -> Html Msg
viewStatus model =
    let
        time =
            case model.time of
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
            case model.time of
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


viewRecord : Model -> Html Msg
viewRecord model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "30px" )
            ]
        ]
        (List.map viewEntry model.record.entries)


viewEntry : Entry -> Html Msg
viewEntry ( percent, date ) =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "5px" )
            ]
        ]
        [ text (toString percent)
        , text "% "
        , text (toFormattedString "MMM d, y" (Date.fromTime date))
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
