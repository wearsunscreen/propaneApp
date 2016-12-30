module Types exposing (..)

import Maybe
import Time exposing (Time)


-- Types


{-| Entry holds
    percent, as Int 0 - 100
    Time, date of recording
-}
type alias Entry =
    ( Int, Time )


type alias Record =
    { version : Int
    , tankSize : Int
    , entries : List Entry
    }


type alias Model =
    { percent : String
    , time : Maybe Time
    , record : Record
    }


type Msg
    = EnterSample String
    | OnSave
    | StoreSample Time.Time
    | Reset



-- Some convenience functions


(??) : Maybe a -> a -> a
(??) m d =
    Maybe.withDefault d m


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
