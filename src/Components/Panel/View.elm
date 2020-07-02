module Components.Panel.View exposing (panel)

import Html exposing (Attribute, Html, section)
import Html.Attributes exposing (class)


panel : List (Attribute msg) -> List (Html msg) -> Html msg
panel a b =
    let
        atribute =
            class "panel" :: a
    in
    section atribute b
