module Components.LeftMenu.View exposing (leftMenu)

import Html exposing (Html, li, nav, text, ul)
import Html.Attributes exposing (class, style)


leftMenu : Html msg
leftMenu =
    nav [ class "left-menu" ]
        [ ul
            []
            [ li [] [ text "Artykuły BHP" ]
            , li [] [ text "Biuro" ]
            , li [] [ text "Loading Page" ]
            , li
                []
                [ text "Gastronomia i hotelarstwo"
                , ul
                    [ style "display" "none" ]
                    [ li [] [ text "test2" ] ]
                , ul
                    [ style "display" "none" ]
                    [ li [] [ text "test3" ] ]
                ]
            ]
        ]
