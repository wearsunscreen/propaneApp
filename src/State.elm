module State exposing (..)

import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model "" "" "", Cmd.none )


subs : Model -> Sub Msg
subs model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        m =
            case msg of
                Name name ->
                    { model | name = name }

                Password password ->
                    { model | password = password }

                PasswordAgain password ->
                    { model | passwordAgain = password }
    in
        ( m, Cmd.none )
