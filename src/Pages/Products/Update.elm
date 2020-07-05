module Pages.Products.Update exposing (initModel, margin, reducer, roundHeight, subscriptions)

import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events as Event
import InfiniteList as IL
import Pages.Products.Data exposing (getProducts)
import Pages.Products.Types exposing (Msg(..), ProductStatus(..), Products)
import Task


subscriptions : state -> Sub Msg
subscriptions _ =
    Event.onResize (\_ h -> GotNewWidth (h - margin))


initModel : () -> ( Products, Cmd Msg )
initModel _ =
    ( { infList = IL.init
      , content = []
      , height = 0
      , productStatus = Loading
      }
    , Cmd.batch
        [ Task.perform GotViewport getViewport
        , getProducts
        ]
    )


reducer : Msg -> Products -> ( Products, Cmd Msg )
reducer msg state =
    case msg of
        InfListMsg infList ->
            ( { state | infList = infList }, Cmd.none )

        GotNewWidth h ->
            ( { state | height = h }, Cmd.none )

        GotViewport viewport ->
            ( { state | height = roundHeight viewport }, Cmd.none )

        GotProduct productResult ->
            case productResult of
                Ok products ->
                    ( { state | productStatus = Succes products }, Cmd.none )

                Err _ ->
                    ( { state | productStatus = Fail }, Cmd.none )


roundHeight : Viewport -> Int
roundHeight v =
    round v.viewport.height - margin


margin : Int
margin =
    2
