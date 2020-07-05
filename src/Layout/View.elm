module Layout.View exposing (view)

import Browser exposing (Document)
import Common.Types exposing (Msg(..))
import Components.TopMenu.View exposing (topMenu)
import Html exposing (Html, button, div, map, text)
import Html.Attributes exposing (style)
import Layout.Types exposing (Layout)
import Pages.Products.View exposing (products)
import Router.Types exposing (Page(..))


view : Layout -> Document Msg
view state =
    { title = "Application Title"
    , body =
        [ topMenu
        , switchPage state
        ]
    }


switchPage : Layout -> Html Msg
switchPage l =
    case l.router.page of
        Home ->
            div [ style "margin-top" "200px" ] [ text "home" ]

        Products ->
            Html.map XProducts (products l.products)

        NotFound ->
            div [ style "margin-top" "200px" ] [ text "NotFound" ]
