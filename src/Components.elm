module Components exposing (grid, topMenu)

import Debug exposing (toString)
import Html exposing (Attribute, Html, a, div, i, input, label, li, nav, text, ul)
import Html.Attributes exposing (alt, class, for, href, id, placeholder, style)


type alias GridSize =
    Int


grid : GridSize -> List (Attribute msg) -> List (Html msg) -> Html msg
grid n a b =
    let
        atribute =
            class ("c-" ++ toString n) :: a
    in
    div atribute b


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
