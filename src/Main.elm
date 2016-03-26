module Main (..) where

import Html exposing (..)
import Effects exposing(Effects, Never)
import Task
import StartApp

import Actions exposing (Action)
import Models exposing (..)
import Update exposing (..)
import View exposing (view)


-- START APP
init : (AppModel, Effects Action)
init =
  (initialModel, Effects.none)


app : StartApp.App AppModel
app =
  StartApp.start
  {
    init = init,
    inputs = [ ],
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