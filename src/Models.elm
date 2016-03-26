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
    players = [ ],
    routing = Routing.initialModel
  }