module Model exposing (..)

import Date exposing (Date)
import Maybe


-- Types


type alias Refill =
    { date : Date
    , gallons : Float
    }


type alias Record =
    { version : Int
    , tankSize : Int
    , refills : List Refill
    }


type alias Model =
    { percent : String
    , today : Maybe Date
    , recentUsage : Maybe Float
    , record : Record
    }


type Msg
    = CloseWelcomeScreen
    | EnterSample String
    | OnSave
    | ShowStatus Date



-- Some convenience functions


(??) : Maybe a -> a -> a
(??) m d =
    Maybe.withDefault d m


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
