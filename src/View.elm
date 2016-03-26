module View (..) where


import Html exposing (..)

import Models exposing (Model)
import Actions exposing (Action)

view : Signal.Address Action -> Model -> Html
view address model =
  div [ ]
      [
        text "Hello"
      ]