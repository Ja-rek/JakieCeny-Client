module Components.Grid.View exposing (grid)

import Debug exposing (toString)
import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (class)


type alias GridSize =
    Int


grid : GridSize -> List (Attribute msg) -> List (Html msg) -> Html msg
grid n a b =
    let
        atribute =
            class ("c-" ++ toString n) :: a
    in
    div atribute b
