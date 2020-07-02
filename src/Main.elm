module Main exposing (main)

import Browser
import Common.Types as Common exposing (Msg(..))
import Layout.Types exposing (Layout)
import Layout.Update exposing (init, subscriptions, update)
import Layout.View exposing (view)
import Router.Types exposing (Msg(..))


main : Program () Layout Common.Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = Router << OnUrlRequest
        , onUrlChange = Router << OnUrlChange
        }
