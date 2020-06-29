module Router.Routes exposing (routes, toPath)

import Router.Types exposing (Page(..))
import Url.Parser exposing (Parser, map, oneOf, s, top)


routes : Parser (Page -> a) a
routes =
    oneOf
        [ map Home top
        , map NotFound (s "404")
        , map Products (s "products")
        ]


toPath : Page -> String
toPath page =
    case page of
        Home ->
            "/"

        NotFound ->
            "/404"

        Products ->
            "/products"
