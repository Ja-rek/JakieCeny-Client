module Router.Types exposing (Msg(..), Page(..), Router)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


type alias Router =
    { page : Page
    , key : Key
    }


type Page
    = Home
    | NotFound
    | Products


type Msg
    = OnUrlChange Url
    | OnUrlRequest UrlRequest
    | Go Page
