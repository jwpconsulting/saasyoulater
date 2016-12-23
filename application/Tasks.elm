module Tasks exposing (..)

import Model
import Task
import LocalStorage


retrieveCurrency : Task.Task Never (Maybe String)
retrieveCurrency =
    LocalStorage.get Model.currencyKey
