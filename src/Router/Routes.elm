module Router.Routes exposing (routes, toPage, toPath)

import Router.Types exposing (Page(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


routes : Parser (Page -> a) a
routes =
    oneOf
        [ map Home top
        , map NotFound (s "404")
        , map Products (s "products")
        ]


toPage : Url -> Page
toPage url =
    Maybe.withDefault NotFound <| parse routes url


toPath : Page -> String
toPath page =
    case page of
        Home ->
            "/"

        NotFound ->
            "/404"

        Products ->
            "/products"
