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


type alias DateSelector =
    { isOpen : Bool
    , maximum : Date
    , minimum : Date
    , selected : Maybe Date
    }


type alias Model =
    { dateSelector : DateSelector
    , percent : String
    , recentUsage : Maybe Float
    , record : Record
    , today : Maybe Date
    }


type Msg
    = CloseWelcomeScreen
    | EnterSample String
    | OnSave
    | ShowStatus Date
    | SelectDate Date
    | ToggleDate



-- Some convenience functions


(??) : Maybe a -> a -> a
(??) m d =
    Maybe.withDefault d m


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
