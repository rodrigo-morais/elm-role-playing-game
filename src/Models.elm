module Models (..) where 


import Routing


import Players.Models exposing (Player)

type alias AppModel =
  {
    players : List Player,
    routing : Routing.Model
  }


initialModel : AppModel
initialModel =
  {
    players = [ Player 1 "Sam" 1 ],
    routing = Routing.initialModel
  }