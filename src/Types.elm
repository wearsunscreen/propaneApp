module Types exposing (..)


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


type Msg
    = Name String
    | Password String
    | PasswordAgain String
