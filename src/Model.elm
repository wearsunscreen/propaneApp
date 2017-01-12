module Model exposing (..)

import Date exposing (Date)
import Maybe


-- Types


type alias DateSelector =
    { isOpen : Bool
    , maximum : Date
    , minimum : Date
    , selected : Maybe Date
    }


type Msg
    = AddRefill
    | CloseWelcomeScreen
    | EnterAddRefills
    | OnSave
    | ShowStatus Date
    | SelectDate Date
    | ToggleDate


type Mode
    = Welcome
    | Status
    | EditRefills


type alias Model =
    { dateSelector : DateSelector
    , mode : Mode
    , refills : List Refill
    , tankSize : Float
    , today : Maybe Date
    , version : Int
    }


type alias Refill =
    { date : Date
    , gallons : Float
    }



-- Some convenience functions


(??) : Maybe a -> a -> a
(??) m d =
    Maybe.withDefault d m


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
