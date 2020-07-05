module Layout.Types exposing (Layout)

import Pages.Products.Types exposing (Products)
import Router.Types exposing (Router)


type alias Layout =
    { router : Router
    , products : Products
    }
