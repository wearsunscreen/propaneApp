module Types exposing (..)

import Maybe


-- Types


type alias Model =
    { percent : String
    }


type Msg
    = SetSample String
    | SaveSample
    | Reset



-- Some convenience functions


(??) : Maybe a -> a -> a
(??) m d =
    Maybe.withDefault d m


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
