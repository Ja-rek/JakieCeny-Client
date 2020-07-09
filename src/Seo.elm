module Seo exposing (Page, Seo, map)

import Browser exposing (Document)
import Html as Html exposing (Html, map)
import List as List


type alias Page m =
    { m
        | seo : Seo
    }


map : Page m -> (a -> msg) -> List (Html a) -> Document msg
map p msg htmls =
    Document p.seo.title <| List.map (\html -> Html.map msg html) htmls


type alias Seo =
    { title : String
    }
