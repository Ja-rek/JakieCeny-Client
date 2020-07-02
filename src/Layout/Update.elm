module Layout.Update exposing (init, subscriptions, update)

import Browser.Navigation exposing (Key)
import Common.Types exposing (Msg(..))
import Layout.Types exposing (Layout)
import Router.Routes exposing (routes)
import Router.Types as Rout exposing (Page(..))
import Router.Update as Rout exposing (update)
import Url exposing (Url)
import Url.Parser exposing (parse)


subscriptions : Layout -> Sub Msg
subscriptions state =
    Sub.none


update : Msg -> Layout -> ( Layout, Cmd Msg )
update msg state =
    case msg of
        Router subMsg ->
            let
                ( newState, newCmd ) =
                    Rout.update subMsg state.router
            in
            ( { state | router = newState }, Cmd.map Router newCmd )


init : () -> Url -> Key -> ( Layout, Cmd Msg )
init _ url key =
    ( Layout
        (Rout.Router (Maybe.withDefault NotFound <| parse routes url) key)
    , Cmd.none
    )
