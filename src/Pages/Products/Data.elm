module Pages.Products.Data exposing (getProducts)

import Http
import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (optional)
import Pages.Products.Types exposing (Msg(..), Product, Property)


getProducts : Cmd Msg
getProducts =
    Http.get
        { url = "http://localhost:5000/offert?categoryid=3"
        , expect = Http.expectJson GotProduct productListDecoder
        }


productListDecoder : Decoder (List Product)
productListDecoder =
    Decode.list productDecoder


productDecoder : Decoder Product
productDecoder =
    Decode.succeed Product
        |> optional "id" int 0
        |> optional "name" string "No title"
        |> optional "img" string "No title"
        |> optional "price" float 0
        |> optional "totalOfferts" int 0
        |> optional "properties" (Decode.list propertyDecoder) []


propertyDecoder : Decoder Property
propertyDecoder =
    Decode.succeed Property
        |> optional "value" string ""
        |> optional "name" string ""
