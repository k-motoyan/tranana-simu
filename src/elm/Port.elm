port module Port exposing (save, load, setModel)


import Model exposing (Model)


port save : { key: String, model: Model } -> Cmd msg


port load : String -> Cmd msg


port setModel : (Model -> msg) -> Sub msg
