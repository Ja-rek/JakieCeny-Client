module Pages.Products exposing (Model, Msg(..), Product, ProductStatus(..), Property, init, productsPage, subscriptions, update)

import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events as Event
import Components exposing (grid)
import Components.LeftMenu as LeftMenu exposing (Msg(..), leftMenu)
import Components.RippleButton as RippleButton
import Html exposing (Html, div, img, li, span, text, ul)
import Html.Attributes exposing (class, src, style)
import Http
import InfiniteList as IL
import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (optional)
import Seo exposing (Page, Seo)
import Task



--MODEL


type alias Model =
    { infList : IL.Model
    , content : List Product
    , height : Int
    , productStatus : ProductStatus
    , leftMenu : LeftMenu.Model
    }


type ProductStatus
    = Loading
    | Fail
    | Succes (List Product)


type alias Product =
    { id : Int
    , name : String
    , img : String
    , price : Float
    , totalOfferts : Int
    , properties : List Property
    }


type alias Property =
    { value : String
    , name : String
    }


init : () -> ( Page Model, Cmd Msg )
init _ =
    ( { seo = Seo "Product"
      , infList = IL.init
      , content = []
      , height = 0
      , productStatus = Loading
      , leftMenu = LeftMenu.Model [] []
      }
    , Cmd.batch
        [ Task.perform GotViewport getViewport
        , getModel
        ]
    )



--UPDATE


type Msg
    = InfListMsg IL.Model
    | GotNewWidth Int
    | GotViewport Viewport
    | GotProduct (Result Http.Error (List Product))
    | LeftMenu LeftMenu.Msg


update : Msg -> Page Model -> ( Page Model, Cmd Msg )
update msg m =
    case msg of
        InfListMsg infList ->
            ( { m | infList = infList }, Cmd.none )

        GotNewWidth h ->
            ( { m | height = h }, Cmd.none )

        GotViewport viewport ->
            ( { m | height = roundHeight viewport }, Cmd.none )

        GotProduct productResult ->
            case productResult of
                Ok p ->
                    ( { m | productStatus = Succes p }, Cmd.none )

                Err _ ->
                    ( { m | productStatus = Fail }, Cmd.none )

        LeftMenu smsg ->
            let
                ( sm, scmd ) =
                    LeftMenu.update smsg m.leftMenu
            in
            ( { m | leftMenu = sm }, Cmd.map LeftMenu scmd )


roundHeight : Viewport -> Int
roundHeight v =
    round v.viewport.height - margin


margin : Int
margin =
    104



--SUBSCRIPTIONS


subscriptions : Page Model -> Sub Msg
subscriptions m =
    Sub.batch
        [ Event.onResize (\_ h -> GotNewWidth (h - margin))
        , Sub.map (LeftMenu << SectionActivated) (RippleButton.subscriptions m.leftMenu.rippleEfect)
        ]



--DATA


getModel : Cmd Msg
getModel =
    Http.get
        { url = "http://localhost:5000/offert?categoryid=3"
        , expect = Http.expectJson GotProduct productListDecoder
        }


productListDecoder : Decoder (List Product)
productListDecoder =
    Decode.list productDecoder


productDecoder : Decoder Product
productDecoder =
    Decode.succeed Product
        |> optional "id" int 0
        |> optional "name" string "No title"
        |> optional "img" string "No title"
        |> optional "price" float 0
        |> optional "totalOfferts" int 0
        |> optional "properties" (Decode.list propertyDecoder) []


propertyDecoder : Decoder Property
propertyDecoder =
    Decode.succeed Property
        |> optional "value" string ""
        |> optional "name" string ""



--VIEW


productsPage : Page Model -> Html Msg
productsPage m =
    div
        [ style "height" (String.fromInt m.height ++ "px")
        , class "products-page"
        , IL.onScroll InfListMsg
        ]
        [ Html.map LeftMenu (leftMenu m.leftMenu)
        , grid 12
            [ class "panel" ]
            [ case m.productStatus of
                Succes p ->
                    IL.view (config m.height) m.infList p

                Fail ->
                    text "error"

                Loading ->
                    text "loading..."
            ]
        ]


headers : List String -> Html msg
headers _ =
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
            (styles |> List.map (\( attr, value ) -> style attr value))
            children
        ]


config : Int -> IL.Config Product Msg
config h =
    let
        itemHeight =
            111
    in
    IL.config
        { itemView = productsView
        , itemHeight = IL.withConstantHeight itemHeight
        , containerHeight = h
        }
        |> IL.withOffset 300
        |> IL.withCustomContainer customContainer
