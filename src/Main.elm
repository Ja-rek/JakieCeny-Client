module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (..)
import Router.Types as Router exposing (Msg(..), Page(..), Router)
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = GotRouterMsg << Router.OnUrlRequest
        , onUrlChange = GotRouterMsg << Router.OnUrlChange
        }


type alias Model =
    { router : Router
    , url : Url
    }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model (Router Home key) url, Cmd.none )


type Msg
    = GotRouterMsg Router.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Application Title"
    , body =
        [ div []
            [ text "New Application"
            , text (Url.toString model.url)
            ]
        ]
    }
