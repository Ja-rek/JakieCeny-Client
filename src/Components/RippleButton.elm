module Components.RippleButton exposing (Model, Msg(..), init, rippleButton, subscriptions, update)

import Animation exposing (px)
import Animation.Messenger
import Html exposing (Html, a, button, span, text)
import Html.Attributes exposing (class, href, name, style)
import Html.Events.Extra.Mouse exposing (onClick)
import Tuple exposing (first, second)


init : Model
init =
    []


type alias Model =
    List Ripple


type alias Ripple =
    { possition : Possition
    , buttonIndex : Int
    , animation : Animation.Messenger.State Msg
    }


type alias Possition =
    { x : Float
    , y : Float
    }



--UPDATE


type Msg
    = RippleAdded Possition Int
    | AnimateRipple Animation.Msg
    | RemovedRipple


update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
    case msg of
        RippleAdded p i ->
            let
                animation =
                    Animation.queue
                        [ Animation.set
                            [ Animation.top (px p.x)
                            , Animation.top (px p.y)
                            ]
                        , Animation.to
                            [ Animation.opacity 0
                            , Animation.scale 5
                            ]
                        , Animation.Messenger.send RemovedRipple
                        ]
                        (Animation.style
                            [ Animation.opacity 1
                            ]
                        )
            in
            ( m ++ [ Ripple (Possition p.x p.y) i animation ], Cmd.none )

        RemovedRipple ->
            ( List.drop 1 m, Cmd.none )

        AnimateRipple t ->
            ( m |> List.map (\r -> { r | animation = first <| Animation.Messenger.update t r.animation })
            , m
                |> List.map
                    (\r -> second <| Animation.Messenger.update t r.animation)
                |> Cmd.batch
            )



--Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription AnimateRipple <| List.map .animation model



--View


rippleButton : Model -> Int -> Maybe String -> String -> Html Msg
rippleButton m i u t =
    a
        [ onClick (\e -> rippleAddedMsg e.offsetPos i)
        , class "ripple-button"
        ]
        (text t :: List.map (\r -> animationByIndex r i) m)


animationByIndex : Ripple -> Int -> Html msg
animationByIndex r i =
    if r.buttonIndex == i then
        span (Animation.render r.animation) []

    else
        text ""


rippleAddedMsg : ( Float, Float ) -> Int -> Msg
rippleAddedMsg ( x, y ) i =
    RippleAdded (Possition x y) i
