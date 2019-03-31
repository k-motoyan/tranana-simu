module View exposing (view)


import Html exposing
    ( Html
    , text
    , div
    , p
    , span
    , button
    , label
    , select
    , option
    , input
    , table
    , thead
    , tbody
    , tr
    , th
    , td
    )
import Html.Attributes exposing
    ( class
    , style
    , value
    , type_
    , id
    , for
    , hidden
    , disabled
    , checked
    )
import Html.Events exposing (onClick, on, targetValue)
import Json.Decode as Decoder

import Data exposing (charactors, Book, books)
import Model exposing
    ( Model
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
    , isDefaultCharactor
    , isSelectedBook
    , isSelectableBook
    )
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ class "container is-fluid" ]
        [ div
            [ class "tile is-ancestor" ]
            [ div
                [ class "tile is-6 is-vertical is-parent"]
                [ div
                    [ class "tile is-child box" ]
                    [ p [ class "title is-4" ] [ text "キャラクター" ]
                    , div [ class "select"] [ charactorSelectBox ]
                    ]
                , div
                    [ class "tile is-child box" ]
                    [ p [ class "title is-4" ] [ text "聖戦士の書" ]
                    , bookList model.selectedBooks
                    ]
                ]
            , div
                [ class "tile is-parent" ]
                [ div
                    [ class "tile is-child box" ]
                    [ p [ class "title is-4" ] [ text "シミュレーション結果" ]
                    , statusView model
                    , saveButton model
                    , notificationView model
                    ]
                ]
            ]
        ]


charactorSelectBox : Html Msg
charactorSelectBox =
    let
        handler selectedValue = CharactorSelect selectedValue
    in
        select [ on "change" (Decoder.map handler targetValue) ] charactorOptions


charactorOptions : List (Html Msg)
charactorOptions = 
    List.map (\c -> option [ value c.name ] [ text c.name ]) charactors


bookList : List Book -> Html Msg
bookList selectedBooks =
    table
        [ class "table is-hoverable is-size-7" ]
        [ thead
            []
            [ tr
                []
                [ th [] []
                , th [] [ text "HP" ]
                , th [] [ text "攻撃" ]
                , th [] [ text "魔力" ]
                , th [] [ text "技術" ]
                , th [] [ text "速度" ]
                , th [] [ text "幸運" ]
                , th [] [ text "防御" ]
                , th [] [ text "体格" ]
                , th [] [ text "移動" ]
                ]
            ]
        , tbody [] <| List.map (bookRow selectedBooks) books
        ]


bookRow : List Book -> Book -> Html Msg
bookRow selectedBooks book =
    tr
        []
        [ td
            []
            [ input
                [ id (String.append book.name "_checkbox")
                , type_ "checkbox"
                , onClick (BookSelect book.name)
                , checked (isSelectedBook selectedBooks book.name)
                , disabled <| not ((selectedBooks |> isSelectableBook) || (isSelectedBook selectedBooks book.name))
                ]
                []
            , label [ for (String.append book.name "_checkbox") ] [ text book.name ]
            ]
        , td [] [ text (book.hp |> toString) ]
        , td [] [ text (book.atk |> toString) ]
        , td [] [ text (book.mgk |> toString) ]
        , td [] [ text (book.skl |> toString) ]
        , td [] [ text (book.spd |> toString) ]
        , td [] [ text (book.luk |> toString) ]
        , td [] [ text (book.def |> toString) ]
        , td [] [ text (book.bod |> toString) ]
        , td [] [ text (book.mov |> toString) ]
        ]


statusView : Model -> Html Msg
statusView model =
    let
        data =
            [ { title = "HP", growthRate = model |> toHP, fluctuate = model |> fluctuateHP }
            , { title = "攻撃", growthRate = model |> toAtk, fluctuate = model |> fluctuateAtk }
            , { title = "魔力", growthRate = model |> toMgc, fluctuate = model |> fluctuateMgc }
            , { title = "技術", growthRate = model |> toSkl, fluctuate = model |> fluctuateSkl }
            , { title = "速度", growthRate = model |> toSpd, fluctuate = model |> fluctuateSpd }
            , { title = "幸運", growthRate = model |> toLuk, fluctuate = model |> fluctuateLuk }
            , { title = "守備", growthRate = model |> toDef, fluctuate = model |> fluctuateDef }
            , { title = "体格", growthRate = model |> toBod, fluctuate = model |> fluctuateBod }
            , { title = "移動", growthRate = model |> toMov, fluctuate = model |> fluctuateMov }
            ]

        decorateFluctuate = \value ->
            if value > 0 then
                "+" ++ (value |> toString) ++ " %"
            else if value < 0 then
                (value |> toString) ++ " %"
            else
                "--"

        fluctuateClass = \value ->
            if value > 0 then
                class "has-text-info"
            else if value < 0 then
                class "has-text-danger"
            else
                class ""

        makeRow = \data ->
            tr
                []
                [ th [] [ text data.title ]
                , td
                    [ style [ ("width", "80px") ] ]
                    [ div
                        [ class "has-background-success has-width-transition"
                        , style
                            [ ("width", (data.growthRate |> toString) ++ "%")
                            , ("height", "10px")
                            , ("display", "inline-block")
                            ]
                        ]
                        []
                    ]
                , td
                    []
                    [ text <| (data.growthRate |> toString) ++ " %" ]
                , td
                    [ fluctuateClass data.fluctuate ]
                    [ text (data.fluctuate |> decorateFluctuate) ]
                ]
    in
        table
            [ class "table" ]
            [ thead
                []
                [ tr
                    []
                    [ th [] []
                    , th [] []
                    , th [] [ text "成長率" ]
                    , th [] [ text "増減" ]
                    ]
                ]
            , tbody [] <| List.map makeRow data
            ]


saveButton : Model -> Html Msg
saveButton model =
    div
        [ class "buttons are-medium" ]
        [ button
            [ class "button is-primary is-outlined"
            , disabled (model.selectedCharactor |> isDefaultCharactor)
            , onClick OnClickSave
            ]
            [ text "保存" ]
        , button
            [ class "button is-outlined"
            , disabled (model.selectedCharactor |> isDefaultCharactor)
            , onClick OnClickLoad
            ]
            [ text "復元" ]
        ]


notificationView : Model -> Html Msg
notificationView model =
    div
        []
        [ saveCompletedView model.isShowSaveCompleted
        , loadCompletedView model.isShowLoadCompleted
        , loadFailedView model.isShowLoadFailed
        ]


saveCompletedView : Bool -> Html Msg
saveCompletedView isShow =
    div
        [ class <| appendHiddenClass "notification is-primary" isShow
        , style [ ("cursor", "pointer") ]
        , onClick OnClickNotificationDelete
        ]
        [ button [ class "delete" ] []
        , text "シミュレーション結果を保存しました。"
        ]


loadCompletedView : Bool -> Html Msg
loadCompletedView isShow =
    div
        [ class <| appendHiddenClass "notification is-primary" isShow
        , style [ ("cursor", "pointer") ]
        , onClick OnClickNotificationDelete
        ]
        [ button [ class "delete" ] []
        , text "シミュレーション結果を読み込みました。"
        ]


loadFailedView : Bool -> Html Msg
loadFailedView isShow =
    div
        [ class <| appendHiddenClass "notification is-danger" isShow
        , style [ ("cursor", "pointer") ]
        , onClick OnClickNotificationDelete
        ]
        [ button [ class "delete" ] []
        , text "シミュレーション結果の読み込みに失敗しました。"
        ]


appendHiddenClass : String -> Bool -> String
appendHiddenClass baseClass isShow =
    if isShow then
        baseClass
    else
        baseClass ++ " is-hidden"
