module Common.Types exposing (Msg(..))

import Pages.Products.Types as Products exposing (Msg(..))
import Router.Types as Router exposing (Msg(..))


type Msg
    = Router Router.Msg
    | XProducts Products.Msg
