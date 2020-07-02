module Components.TopMenu.View exposing (topMenu)

import Html exposing (Html, a, div, i, input, label, nav, text)
import Html.Attributes exposing (alt, class, for, href, id, placeholder)


topMenu : Html msg
topMenu =
    nav [ class "top-menu" ]
        [ div
            [ class "menu" ]
            [ button "#" "menu" "menu" ]
        , searchIcon
        ]


button : String -> String -> String -> Html msg
button link iconName name =
    a
        [ href link
        , alt name
        ]
        [ i [ class "button" ]
            [ text iconName ]
        ]


searchIcon : Html msg
searchIcon =
    let
        search =
            "search"
    in
    div [ class search ]
        [ label
            [ for search ]
            [ i []
                [ text search ]
            ]
        , input
            [ id search
            , placeholder "Szukaj"
            ]
            []
        ]
