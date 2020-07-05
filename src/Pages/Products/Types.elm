module Pages.Products.Types exposing (Msg(..), Product, ProductStatus(..), Products, Property)

import Browser.Dom exposing (Viewport)
import Http
import InfiniteList as IL


type Msg
    = InfListMsg IL.Model
    | GotNewWidth Int
    | GotViewport Viewport
    | GotProduct (Result Http.Error (List Product))


type alias Products =
    { infList : IL.Model
    , content : List Product
    , height : Int
    , productStatus : ProductStatus
    }


type ProductStatus
    = Loading
    | Fail
    | Succes (List Product)


type alias Product =
    { id : Int
    , name : String
    , img : String
    , price : Float
    , totalOfferts : Int
    , properties : List Property
    }


type alias Property =
    { value : String
    , name : String
    }
