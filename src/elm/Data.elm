module Data exposing (Charactor, charactors, Book, books)


type alias Charactor =
    { name: String
    , hp: Int
    , atk: Int
    , mgk: Int
    , skl: Int
    , spd: Int
    , luk: Int
    , def: Int
    , bod: Int
    , mov: Int
    }


charactors : List Charactor
charactors =
    [ { name = "選択してください"
      , hp = 0
      , atk = 0
      , mgk = 0
      , skl = 0
      , spd = 0
      , luk = 0
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "リーフ"
      , hp = 70
      , atk = 35
      , mgk = 10
      , skl = 35
      , spd = 40
      , luk = 40
      , def = 25
      , bod = 15
      , mov = 3
      }
    , { name = "エーヴェル"
      , hp = 30
      , atk = 15
      , mgk = 10
      , skl = 15
      , spd = 10
      , luk = 25
      , def = 5
      , bod = 5
      , mov = 2
      }
    , { name = "マーティ"
      , hp = 90
      , atk = 15
      , mgk = 5
      , skl = 10
      , spd = 15
      , luk = 40
      , def = 50
      , bod = 75
      , mov = 2
      }
    , { name = "サフィ"
      , hp = 35
      , atk = 30
      , mgk = 60
      , skl = 45
      , spd = 40
      , luk = 5
      , def = 3
      , bod = 2
      , mov = 0
      }
    , { name = "フェルグス"
      , hp = 65
      , atk = 35
      , mgk = 10
      , skl = 45
      , spd = 35
      , luk = 40
      , def = 25
      , bod = 20
      , mov = 1
      }
    , { name = "ダルシン"
      , hp = 60
      , atk = 50
      , mgk = 5
      , skl = 40
      , spd = 25
      , luk = 25
      , def = 20
      , bod = 25
      , mov = 2
      }
    , { name = "シヴァ"
      , hp = 70
      , atk = 45
      , mgk = 5
      , skl = 50
      , spd = 35
      , luk = 60
      , def = 30
      , bod = 20
      , mov = 2
      }
    , { name = "カリオン"
      , hp = 75
      , atk = 40
      , mgk = 10
      , skl = 65
      , spd = 45
      , luk = 55
      , def = 25
      , bod = 25
      , mov = 1
      }
    , { name = "ロベルト"
      , hp = 65
      , atk = 45
      , mgk = 10
      , skl = 50
      , spd = 60
      , luk = 70
      , def = 25
      , bod = 20
      , mov = 1
      }
    , { name = "ホメロス"
      , hp = 65
      , atk = 0
      , mgk = 40
      , skl = 70
      , spd = 70
      , luk = 55
      , def = 15
      , bod = 10
      , mov = 3
      }
    , { name = "セティ"
      , hp = 75
      , atk = 10
      , mgk = 75
      , skl = 75
      , spd = 80
      , luk = 65
      , def = 20
      , bod = 15
      , mov = 1
      }
    ]


type alias Book = Charactor


books : List Book
books =
    [ { name = "ヘズルの書"
      , hp = 30
      , atk = 10
      , mgk = 0
      , skl = 0
      , spd = 0
      , luk = -10
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "バルドの書"
      , hp = 5
      , atk = 5
      , mgk = 0
      , skl = 5
      , spd = 5
      , luk = 5
      , def = 5
      , bod = 0
      , mov = 0
      }
    , { name = "セティの書"
      , hp = -10
      , atk = 0
      , mgk = 10
      , skl = 0
      , spd = 30
      , luk = 0
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "オードの書"
      , hp = 0
      , atk = 0
      , mgk = 0
      , skl = 30
      , spd = 0
      , luk = 0
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "ネールの書"
      , hp = 10
      , atk = 10
      , mgk = 0
      , skl = -10
      , spd = 0
      , luk = 0
      , def = 10
      , bod = 10
      , mov = 0
      }
    , { name = "ファラの書"
      , hp = 0
      , atk = 5
      , mgk = 5
      , skl = 10
      , spd = 10
      , luk = 0
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "ヘイムの書"
      , hp = 0
      , atk = 0
      , mgk = 30
      , skl = 0
      , spd = 0
      , luk = 10
      , def = -10
      , bod = 0
      , mov = 0
      }
    , { name = "ダインの書"
      , hp = 0
      , atk = 5
      , mgk = 0
      , skl = 0
      , spd = -10
      , luk = 0
      , def = 30
      , bod = 0
      , mov = 5
      }
    , { name = "ウルの書"
      , hp = 0
      , atk = 0
      , mgk = 0
      , skl = 10
      , spd = 10
      , luk = 10
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "ブラギの書"
      , hp = 0
      , atk = -10
      , mgk = 10
      , skl = 0
      , spd = 0
      , luk = 30
      , def = 0
      , bod = 0
      , mov = 0
      }
    , { name = "ノヴァの書"
      , hp = 0
      , atk = 30
      , mgk = -10
      , skl = 0
      , spd = 10
      , luk = -5
      , def = 5
      , bod = 0
      , mov = 0
      }
    , { name = "トードの書"
      , hp = 5
      , atk = 5
      , mgk = 5
      , skl = 10
      , spd = 0
      , luk = 5
      , def = 0
      , bod = 0
      , mov = 0
      }
    ]
