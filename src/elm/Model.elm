module Model exposing
    ( Model
    , initModel
    , toHP
    , toAtk
    , toMgc
    , toSkl
    , toSpd
    , toLuk
    , toDef
    , toBod
    , toMov
    , fluctuateHP
    , fluctuateAtk
    , fluctuateMgc
    , fluctuateSkl
    , fluctuateSpd
    , fluctuateLuk
    , fluctuateDef
    , fluctuateBod
    , fluctuateMov
    , selectCharactor
    , selectBook
    , dropBook
    , isDefaultCharactor
    , isSelectedBook
    , isSelectableBook
    , clearNotification
    )


import Data exposing (Charactor, charactors, Book, books)


type alias Model =
    { selectedCharactor: Maybe Charactor
    , selectedBooks: List Book
    , isShowSaveCompleted: Bool
    , isShowLoadCompleted: Bool
    , isShowLoadFailed: Bool
    }


initModel : Model
initModel =
    { selectedCharactor = Nothing
    , selectedBooks = []
    , isShowSaveCompleted = False
    , isShowLoadCompleted = False
    , isShowLoadFailed = False
    }


-- Model transform


toHP : Model -> Int
toHP model =
    calcParameter model (\c -> c.hp) fluctuateHP


toAtk : Model -> Int
toAtk model =
    calcParameter model (\c -> c.atk) fluctuateAtk


toMgc : Model -> Int
toMgc model =
    calcParameter model (\c -> c.mgk) fluctuateMgc


toSkl : Model -> Int
toSkl model =
    calcParameter model (\c -> c.skl) fluctuateSkl


toSpd : Model -> Int
toSpd model =
    calcParameter model (\c -> c.spd) fluctuateSpd


toLuk : Model -> Int
toLuk model =
    calcParameter model (\c -> c.luk) fluctuateLuk


toDef : Model -> Int
toDef model =
    calcParameter model (\c -> c.def) fluctuateDef


toBod : Model -> Int
toBod model =
    calcParameter model (\c -> c.bod) fluctuateBod


toMov : Model -> Int
toMov model =
    calcParameter model (\c -> c.mov) fluctuateMov


calcParameter : Model -> (Charactor -> Int) -> (Model -> Int) -> Int
calcParameter model parameterCallback fluctuateCallback =
    case model.selectedCharactor of
        Just c ->
            (parameterCallback c) + (fluctuateCallback model)
        Nothing ->
            0


fluctuateHP : Model -> Int
fluctuateHP model =
    List.foldl (\book total -> book.hp + total) 0 model.selectedBooks


fluctuateAtk : Model -> Int
fluctuateAtk model =
    List.foldl (\book total -> book.atk + total) 0 model.selectedBooks


fluctuateMgc : Model -> Int
fluctuateMgc model =
    List.foldl (\book total -> book.mgk + total) 0 model.selectedBooks


fluctuateSkl : Model -> Int
fluctuateSkl model =
    List.foldl (\book total -> book.skl + total) 0 model.selectedBooks


fluctuateSpd : Model -> Int
fluctuateSpd model =
    List.foldl (\book total -> book.spd + total) 0 model.selectedBooks


fluctuateLuk : Model -> Int
fluctuateLuk model =
    List.foldl (\book total -> book.luk + total) 0 model.selectedBooks


fluctuateDef : Model -> Int
fluctuateDef model =
    List.foldl (\book total -> book.def + total) 0 model.selectedBooks


fluctuateBod : Model -> Int
fluctuateBod model =
    List.foldl (\book total -> book.bod + total) 0 model.selectedBooks


fluctuateMov : Model -> Int
fluctuateMov model =
    List.foldl (\book total -> book.mov + total) 0 model.selectedBooks


-- Charactor transform


selectCharactor : List Charactor -> String -> Maybe Charactor
selectCharactor charactors name =
    List.filter (\c -> c.name == name) charactors |> List.head


isDefaultCharactor : Maybe Charactor -> Bool
isDefaultCharactor charactor =
    case charactor of
        Just c ->
            c.name == "選択してください"
        Nothing ->
            True


-- Book transform


selectBook : List Book -> String -> Maybe Book
selectBook books name =
    List.filter (\b -> b.name == name) books |> List.head


dropBook : List Book -> String -> List Book
dropBook books name =
    List.filter (\b -> b.name /= name) books


isSelectedBook : List Book -> String -> Bool
isSelectedBook selectedBooks name =
    case selectBook selectedBooks name of
        Just _ ->
            True
        Nothing ->
            False


isSelectableBook : List Book -> Bool
isSelectableBook selectedBooks =
    List.length selectedBooks < 7


-- State modifier


clearNotification : Model -> Model
clearNotification model =
    { model
    | isShowSaveCompleted = False
    , isShowLoadCompleted = False
    , isShowLoadFailed = False
    }
