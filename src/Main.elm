module Main (..) where

import Html exposing (..)
import Effects exposing(Effects, Never)
import Task
import StartApp


import Actions exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (view)
import Mailboxes exposing (..)


import Players.Effects
import Players.Actions


import Routing


-- START APP
init : (AppModel, Effects Action)
init =
  let
    fxs = [ Effects.map PlayersAction Players.Effects.fetchAll ]
    fx = Effects.batch fxs
  in
    (Models.initialModel, fx)


routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction Routing.signal


getDeleteConfirmationSignal : Signal Actions.Action
getDeleteConfirmationSignal =
  let
    toAction id =
        id
        |> Players.Actions.DeletePlayer
        |> PlayersAction
  in
    Signal.map toAction getDeleteConfirmation


app : StartApp.App AppModel
app =
  StartApp.start
  {
    init = init,
    inputs = [ routerSignal, actionsMailbox.signal, getDeleteConfirmationSignal ],
    update = update,
    view = view
  }


-- MAIN
main : Signal.Signal Html
main =
  app.html


-- PORT
port runner : Signal (Task.Task Never ())
port runner =
  app.tasks


port routeRunTask : Task.Task () ()
port routeRunTask =
  Routing.run


port askDeleteConfirmation : Signal (Int, String)
port askDeleteConfirmation =
  askDeleteConfirmationMailbox.signal


port getDeleteConfirmation : Signal Int