module Pages.Products.View exposing (products)

import Components.Grid.View exposing (grid)
import Components.Panel.View exposing (panel)
import Html exposing (Html, div, img, li, span, text, ul)
import Html.Attributes exposing (class, height, src, style)
import InfiniteList as IL
import Pages.Products.Types exposing (Msg(..), Product, ProductStatus(..), Products)


products : Products -> Html Msg
products model =
    div
        [ style "height" (String.fromInt model.height ++ "px")
        , style "width" "auto"
        , style "overflow" "auto"
        , style "border" "1px solid #000"
        , style "margin" "auto"
        , IL.onScroll InfListMsg
        ]
        [ grid 6
            [ class "panel", style "margin" "30px" ]
            [ case model.productStatus of
                Succes p ->
                    IL.view (config model.height) model.infList p

                Fail ->
                    text "error"

                Loading ->
                    text "loading..."
            ]
        ]


headers : List String -> Html msg
headers names =
    div [ class "products-header" ]
        [ div [] [ text "Nazwa" ]
        , div [] [ text "Cena" ]
        , div [] [ text "Img" ]
        , div [] [ text "Ekran Dotykowy" ]
        , div [] [ text "4G" ]
        ]



--(List.map (\name -> div [] [ text name ]) names)


productsView : Int -> Int -> Product -> Html Msg
productsView _ _ product =
    li []
        [ div [ class "description" ]
            [ span [ class "images" ] [ img [ src "tel.jpg" ] [] ]
            , span [] [ text product.name ]
            ]
        , div [] [ text <| String.fromFloat product.price ++ " zł" ]
        , div [] [ text product.img ]
        , div [] [ text <| String.fromFloat product.price ++ " zł" ]
        , div [] [ text product.img ]
        ]


customContainer : List ( String, String ) -> List (Html msg) -> Html msg
customContainer styles children =
    div [ class "products" ]
        [ headers [ "Name", "Price" ]
        , ul
            ((styles ++ [ ( "padding-left", "40px" ) ]) |> List.map (\( attr, value ) -> style attr value))
            children
        ]


config : Int -> IL.Config Product Msg
config h =
    let
        itemHeight =
            131
    in
    IL.config
        { itemView = productsView
        , itemHeight = IL.withConstantHeight itemHeight
        , containerHeight = h
        }
        |> IL.withOffset 300
        |> IL.withCustomContainer customContainer
