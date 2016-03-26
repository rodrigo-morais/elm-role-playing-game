module Update (..) where


import Effects exposing(Effects, Never)

import Models exposing (Model)
import Actions exposing (Action)

update : Action -> Model -> (Model, Effects Action)
update action model =
  (model, Effects.none)