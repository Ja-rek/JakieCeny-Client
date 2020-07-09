module Route exposing (Route(..), fromUrl)

import Browser exposing (UrlRequest(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


type Route
    = Home
    | NotFound
    | Products


fromUrl : Url -> Route
fromUrl url =
    Maybe.withDefault NotFound <| parse routes url


routes : Parser (Route -> a) a
routes =
    oneOf
        [ map Home top
        , map NotFound (s "404")
        , map Products (s "products")
        ]
