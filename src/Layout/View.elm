module Layout.View exposing (view)

import Browser exposing (Document)
import Common.Types exposing (Msg(..))
import Html exposing (a, div, text)
import Html.Attributes exposing (href)
import Layout.Types exposing (Layout)


view : Layout -> Document Msg
view layot =
    { title = "Application Title"
    , body =
        [ div []
            [ text "New Application"
            , text (Debug.toString layot.router)
            , a [ href "/" ] [ text "home" ]
            , a [ href "/productS" ] [ text "products" ]
            ]
        ]
    }
