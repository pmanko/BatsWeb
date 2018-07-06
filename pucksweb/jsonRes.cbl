       class-id pucksweb.jsonRes public.
       01 players         List [type playerD] public.
       01 games           List [type gameD] public.
       01 gameData        List [type gameDataD] public.
       01 toiData         List [type toiDataD] public.
       end class.
       
       class-id playerD public.
       01 #id                 type Single public.
       01 firstName           String public.
       01 lastName            String public.
       01 team                String public.
       01 pos                 String public.
       end class.

       class-id gameD public.
      *01 #id                 type Single public.
       01 awayTeam            String public.
       01 homeTeam            String public.
       01 #date               type String public.
      * 01 season              String public.
       01 awayScore           type Single public.
       01 homeScore           type Single public.
       01 gameType            type Char public.
       01 lastPosted          type Single public.
       01 gameDone            type Char public.
       end class.

       class-id gameDataD public.
       01 period                  type Single public.
       01 elapsedTime             type Single public.
       01 gameTime                type String public.
       01 visScore                type Single public.
       01 homeScore               type Single public.
       01 visSkaters              type Single public.
       01 homeSkaters             type Single public.
       01 clipType                type String public.
       01 clipTypeSubCode         type String public.
       01 mediaFile               type String public.
       01 mediaDuration           type Double public.
       01 mediaStart              type Double public.
       01 zone                    type Char public.
       01 aTeam                   type String public.
       01 bTeam                   type String public.
       01 aStrength               type Single public.
       01 bStrength               type Single public.
       01 aPlayerId               type Single public.
       01 bPlayerId               type Single public.
       01 shotType                type String public.
       01 emptyNet                type Char public.
       01 goalZone                type Char public.
       01 x                       type Single public.
       01 y                       type Single public.
       01 aReason                 type String public.
       end class.

       class-id toiDataD public.
       01 playerId                type Single public.
       01 period                  type Single public.
       01 elapsedTime             type Single public.
       01 gameTime                type String public.
       01 duration                type Single public.
       01 mediaFile               type String public.
       01 mediaDuration           type Double public.
       01 mediaStart              type Double public.
       01 visSkaters              type Single public.
       01 homeSkaters             type Single public.
       01 strength                type String public.
       01 #first                  type String public.
       01 #last                   type String public.

       end class.