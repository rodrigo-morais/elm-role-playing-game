module Players.Actions (..) where


import Players.Models exposing (PlayerId, Player)


import Http


import Hop


type Action =
  NoOp
  | HopAction ()
  | EditPlayer PlayerId
  | ListPlayers
  | FetchAllDone (Result Http.Error (List Player))