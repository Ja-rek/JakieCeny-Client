module Components.LeftMenu exposing (Model, Msg(..), leftMenu, update)

import Components.RippleButton as RippleButton exposing (rippleButton)
import Debug exposing (toString)
import Html exposing (Attribute, Html, a, div, i, input, label, li, nav, text, ul)
import Html.Attributes exposing (alt, class, for, href, id, placeholder, style)


type alias Model =
    { categories : List SectionButton
    , rippleEfect : RippleButton.Model
    }


type alias SectionButton =
    { index : Int
    , url : String
    , title : String
    }


type Msg
    = SectionActivated RippleButton.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
    case msg of
        SectionActivated rb ->
            let
                ( sm, scmd ) =
                    RippleButton.update rb m.rippleEfect
            in
            ( { m | rippleEfect = sm }, Cmd.map SectionActivated scmd )


aa : Int -> Model -> Html Msg
aa i m =
    Html.map SectionActivated (rippleButton m.rippleEfect i (Just "sdfs") "biuro")


leftMenu : Model -> Html Msg
leftMenu m =
    nav [ class "left-menu" ]
        [ ul
            []
            [ li [ class "title" ] [ text "Kategorie" ]
            , li []
                [ aa 1 m ]
            , li [] [ text "aaaaa" ]
            , li
                []
                [ aa 2 m
                , ul
                    [ style "display" "none" ]
                    [ li [] [ text "test2" ] ]
                , ul
                    [ style "display" "none" ]
                    [ li [] [ text "test3" ] ]
                ]
            ]
        ]
