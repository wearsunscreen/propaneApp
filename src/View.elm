module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (toInt)
import Types exposing (..)


prompt : Model -> Html msg
prompt model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "font-weight", "bolder" )
            , ( "font-size", "200%" )
            , ( "padding", "30px" )
            ]
        ]
        [ text "What is your tank level today?" ]


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "color", "green" )
            , ( "text-align", "center" )
            , ( "padding", "30px" )
            ]
        ]
        [ prompt model
        , input [ type_ "text", placeholder "percent full", onInput SetSample ] []
        , text "%"
        , viewValidation model
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message, noPress ) =
            case String.toInt model.percent of
                Err s ->
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
            , div [] [ button [ onClick SaveSample, disabled noPress ] [ text "Save" ] ]
            ]
