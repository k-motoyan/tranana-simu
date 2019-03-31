module Update exposing (Msg(..), update)


import Data exposing (Charactor, charactors, Book, books)
import Model exposing (Model, selectCharactor, selectBook, dropBook, clearNotification)
import Port exposing (save, load)


type Msg
    = CharactorSelect String
    | BookSelect String
    | OnClickSave
    | OnClickLoad
    | OnClickNotificationDelete
    | SetModel Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CharactorSelect name ->
            let
                newModel =
                    { model
                    | selectedCharactor = selectCharactor charactors name
                    , selectedBooks = []
                    }
            in
                ( newModel, Cmd.none )

        BookSelect name ->
            case selectBook model.selectedBooks name of
                Just book ->
                    ( { model | selectedBooks = dropBook model.selectedBooks name }, Cmd.none )
                Nothing ->
                    case selectBook books name of
                        Just book ->
                            ( { model | selectedBooks = book :: model.selectedBooks }, Cmd.none )
                        Nothing ->
                            ( model, Cmd.none )

        OnClickSave ->
            case model.selectedCharactor of
                Just c ->
                    let
                        newModel = model |> clearNotification
                    in
                        ( newModel, save { key = c.name, model = newModel } )
                Nothing ->
                    ( model, Cmd.none )

        OnClickLoad ->
            case model.selectedCharactor of
                Just c ->
                    ( model |> clearNotification, load c.name )
                Nothing ->
                    ( model, Cmd.none )

        OnClickNotificationDelete ->
            ( model |> clearNotification, Cmd.none )

        SetModel newModel ->
            ( newModel, Cmd.none )
