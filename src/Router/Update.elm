module Router.Update exposing (init, update)

import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Router.Routes exposing (toPage, toPath)
import Router.Types exposing (Msg(..), Page(..), Router)
import Url exposing (Url)


init : () -> Url -> Key -> ( Router, Cmd Msg )
init _ url key =
    ( { page = toPage url
      , key = key
      }
    , Cmd.none
    )


update : Msg -> Router -> ( Router, Cmd Msg )
update msg state =
    case msg of
        OnUrlChange url ->
            ( { state | page = toPage url }, Cmd.none )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( state, pushUrl state.key <| Url.toString url )

                External url ->
                    ( state, load url )

        Go page ->
            ( state, pushUrl state.key <| toPath page )
