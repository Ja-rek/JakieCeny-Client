module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav exposing (Key, load, pushUrl)
import Components exposing (topMenu)
import Components.LeftMenu exposing (leftMenu)
import Html exposing (Html, div, nav, text)
import Html.Attributes exposing (class)
import Pages.Products as Products exposing (init, productsPage)
import Route
import Seo exposing (Page)
import Url exposing (Url)



--MODEL


type alias Model =
    { key : Key
    , state : State
    }


type State
    = Home
    | Products (Page Products.Model)
    | NotFound


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    initPage url key



--UPDATE


type Msg
    = UrlChanged Url
    | UrlRequested UrlRequest
    | ProductsMsg Products.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
    case ( msg, m.state ) of
        ( UrlRequested urlRequest, _ ) ->
            case urlRequest of
                Internal url ->
                    ( m, pushUrl m.key <| Url.toString url )

                External url ->
                    ( m, load url )

        ( UrlChanged url, _ ) ->
            initPage url m.key

        ( ProductsMsg subMsg, Products subModel ) ->
            mapBoth m.key ProductsMsg Products <| Products.update subMsg subModel

        _ ->
            ( m, Cmd.none )


initPage : Url -> Nav.Key -> ( Model, Cmd Msg )
initPage url key =
    case Route.fromUrl url of
        Route.Home ->
            ( Model key Home, Cmd.none )

        Route.NotFound ->
            ( Model key NotFound, Cmd.none )

        Route.Products ->
            mapBoth key ProductsMsg Products <| Products.init ()


mapBoth :
    Key
    -> (a -> b)
    -> (c -> State)
    -> ( c, Cmd a )
    -> ( Model, Cmd b )
mapBoth key msg model ( subModel, subCmd ) =
    ( Model key (model subModel), Cmd.map msg subCmd )



-- VIEW


view : Model -> Document Msg
view m =
    case m.state of
        Home ->
            notFound

        Products sm ->
            viewLayout sm ProductsMsg <| productsPage sm

        _ ->
            notFound


viewLayout : Page m -> (a -> msg) -> Html a -> Document msg
viewLayout p msg html =
    Seo.map p msg <| layout <| html


layout : Html msg -> List (Html msg)
layout page =
    [ topMenu
    , page
    ]


notFound : Document msg
notFound =
    { title = "Not found", body = layout (text "Not found") }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions m =
    case m.state of
        Products m_ ->
            Sub.map ProductsMsg (Products.subscriptions m_)

        _ ->
            Sub.none



--MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }
