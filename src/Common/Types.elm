module Common.Types exposing (Msg(..))

import Router.Types as Router exposing (Msg(..), Page(..), Router)


type Msg
    = Router Router.Msg
