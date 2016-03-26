module Update (..) where

import Effects exposing (Effects)


import Models exposing (..)
import Actions exposing (..)
import Mailboxes exposing (..)


import Players.Update


import Routing


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case action of
    PlayersAction subAction ->
      let
        updateModel =
          {
            players = model.players,
            showErrorAddress = Signal.forwardTo actionsMailbox.address ShowError,
            deleteConfirmationAddress = askDeleteConfirmationMailbox.address
          }

        ( updatedPlayers, fx ) =
          Players.Update.update subAction updateModel
      in
        ( { model | players = updatedPlayers }, Effects.map PlayersAction fx )

    RoutingAction subAction ->
      let
        (updateRouting, fx) =
          Routing.update subAction model.routing
      in
        ({ model | routing = updateRouting }, Effects.map RoutingAction fx)

    NoOp ->
      ( model, Effects.none )

    ShowError message ->
      ({ model | errorMessage = message }, Effects.none)
