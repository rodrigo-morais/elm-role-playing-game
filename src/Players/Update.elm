module Players.Update (..) where

import Effects exposing (Effects)


import Players.Actions exposing (..)
import Players.Models exposing (..)


import Hop.Navigate exposing (navigateTo)


type alias UpdateModel =
  {
    players : List Player,
    showErrorAddress : Signal.Address String
  }


update : Action -> UpdateModel -> ( List Player, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model.players, Effects.none )

    ListPlayers ->
      let
        path =
          "/players"
      in
        (model.players, Effects.map HopAction (navigateTo path))

    EditPlayer id ->
      let
        path =
          "/players/" ++ (toString id) ++ "/edit"
      in
        (model.players, Effects.map HopAction (navigateTo path))

    HopAction _ ->
      (model.players, Effects.none)

    FetchAllDone result ->
      case result of
        Ok players ->
          (players, Effects.none)

        Err error ->
          let
            errorMessage =
              toString error

            fx =
              Signal.send model.showErrorAddress errorMessage
              |> Effects.task
              |> Effects.map TaskDone
          in
            (model.players, fx)

    TaskDone () ->
      (model.players, Effects.none)