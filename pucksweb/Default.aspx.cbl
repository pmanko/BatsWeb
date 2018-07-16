       $set ilusing"System.Web.Security"

       class-id pucksweb._Default is partial     
               inherits type System.Web.UI.Page public.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT PLAY-FILE ASSIGN LK-PLAYER-FILE
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS PLAY-KEY
              ALTERNATE KEY IS PLAY-ALT-KEY1
              ALTERNATE KEY IS PLAY-ALT-KEY2
              LOCK MANUAL
              FILE STATUS IS STATUS-COMN.

          SELECT GAME-FILE ASSIGN LK-GAME-FILE
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS GAME-KEY
              LOCK MANUAL
              FILE STATUS IS STATUS-COMN.

       $SET CALLFH"EXTFH"
       $SET DATACOMPRESS"1"
        SELECT WEBPASS-FILE ASSIGN WS-BATSW020-FILE
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS WEBPASS-KEY
              LOCK MANUAL
              FILE STATUS IS STATUS-COMN.

       file section.
       COPY "Y:\SYDEXSOURCE\FDS\FDPKPLAY.CBL".
       COPY "y:\SYDEXsource\FDS\FDPKGAME.CBL".
       FD  WEBPASS-FILE
           LABEL RECORDS ARE STANDARD
           DATA RECORD IS WEBPASS-REC.

       01  WEBPASS-REC.
           05  WEBPASS-KEY.
               10  WEBPASS-TEAM-NAME       PIC X(15).
      *        10  WEBPASS-LAST            PIC X(15).
               10  WEBPASS-FIRST           PIC X(30).
           05  WEBPASS-REST.
               10  WEBPASS-PASS            PIC X(24).
               10  WEBPASS-LEVEL           PIC X.
               10  FILLER                  PIC X(44).

       working-storage section.
       copy "y:\sydexsource\pucks\pucksglobal.cpb".
       COPY "y:\sydexsource\pucks\wspuckf.CBL".
       77  WS-NETWORK-FLAG             PIC X      VALUE "A".
       01  WS-TEAM-NAME       PIC X(15).
       01  WS-LAST            PIC X(15).
       01  WS-FIRST           PIC X(15).
       01  WS-PASS            type String.
       01  WS-BATSW020-FILE   PIC X(256) VALUE "PKW020.DAT".
       01  WS-REJECT-FLAG     PIC X.
       01  STATUS-COMN.
           05  STATUS-BYTE-1           PIC X      VALUE SPACES.
           05  STATUS-BYTE-2           PIC X      VALUE SPACES.
       01 plaintext           type Byte occurs any.
       01 entropy           type Byte occurs 20.
       01 ticket          type FormsAuthenticationTicket.
       01 aa               type Single.
       01 bb               type Single.
       01 team             type String.
       01 callbackReturn type String.
       01 reader           type StreamReader.
       01 writer           type StreamWriter.
      * 01 jReader          type JsonTextReader.
       01 app-data-folder pic x(256).
       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.              
       procedure division using by value sender as object by value e as type EventArgs.
           
      *     if IsJsonRequest()
          if Request::ContentType = "application/json"
              invoke self::processJson.
           
      * #### ICallback Implementation ####
      *    set cm to self::ClientScript
      *    set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
      *    set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
      *    invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####   
        
           if self::IsPostBack
               exit method.
      *         set TextBox2::Text to type HttpContext::Current::Request::Cookies["creds"]["Password"].
           if type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"] not = null
               set rememberCheckBox::Checked to true
               set ticket to type FormsAuthentication::Decrypt(type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"]::Value)
               set first_name::Text to ticket::Name::Substring(0, 15)::Trim
      *         set last_name::Text to ticket::Name::Substring(15, 15)::Trim
               set password::Text to ticket::Name::Substring(15, 6)::Trim
               set team to ticket::Name::Substring(21, 15)::Trim.
           move 0 to aa.
       5-loop.
           if teamDropDownList::Items::Count = aa
               go to 10-done.
           if team = teamDropDownList::Items[aa]::ToString
               set teamDropDownList::SelectedIndex to aa
               go to 10-done.
           if self::Request::QueryString::ToString::Replace("_", " ") = teamDropDownList::Items[aa]::ToString
               set teamDropDownList::SelectedIndex to aa
               go to 10-done.
           add 1 to aa
           go to 5-loop.
       10-done.
           goback.
       end method.

      *#####               Client Callback Implementation             #####
      *##### (https://msdn.microsoft.com/en-us/library/ms178208.aspx) #####
      *####################################################################
      *
      *method-id RaiseCallbackEvent public.
      *local-storage section.
      *01 actionFlag type String.
      *01 methodArg type String.       
      *
      *procedure division using by value eventArgument as String.
      *    unstring eventArgument
      *        delimited by "|"
      *        into actionFlag, methodArg
      *    end-unstring.
      *    
      *    if actionFlag = 'login'
      *        set callbackReturn to actionFlag & "|" & self::login(methodArg).
      *
      *end method.
      *
      *method-id GetCallbackResult public.
      *procedure division returning returnToClient as String.
      *
      *    set returnToClient to callbackReturn.
      *    
      *end method.
      *
      *####################################################################

       method-id loginButton_Click protected.
       local-storage section.
       01 userName        type String.
       01 encTicket       type String.
       01 teamName        pic x(15). 
       procedure division using by value sender as object e as type System.EventArgs.
      * procedure division using by value loginParams as String returning returnVal as  String.
           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
          
           set WS-TEAM-NAME to teamDropDownList::SelectedItem.
           set teamName to teamDropDownList::SelectedItem::ToString::Replace(" ", type String::Empty).
 debug*     string '"' app-data-folder delimited by "  "
             string '"' app-data-folder delimited by "  "
      *     string '"' app-data-folder delimited by "pucksweb" teamName delimited by "  "
              '\WEBSYNC\PKW020.DAT"' delimited by size
              into WS-BATSW020-FILE.
   
           set WS-FIRST to first_name::Text::ToUpper.
      *     set WS-LAST to last_name::Text::ToUpper.
           set WS-LAST to "".
           set WS-PASS to password::Text.
                   
           invoke self::verify_password
           
           if WS-REJECT-FLAG = "Y"
               set userName to WS-FIRST & WS-LAST & WS-PASS & WS-TEAM-NAME
               set ticket to type FormsAuthenticationTicket::New(userName, False, 525600)
               set encTicket to type FormsAuthentication::Encrypt(ticket)
               invoke self::Response::Cookies::Add(type HttpCookie::New(type FormsAuthentication::FormsCookieName, encTicket))
               set type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"]::Expires to type DateTime::Now::AddYears(1)
               set type HttpContext::Current::Session::Item("team") to WS-TEAM-NAME::Trim
      *         set type HttpContext::Current::Session::Item("BAM") to type File::ReadAllText(type HttpContext::Current::Server::MapPath("~/Credentials") & "\" & WS-FIRST::Trim & ".txt")
               invoke self::Response::Redirect(type FormsAuthentication::GetRedirectUrl(userName, rememberCheckBox::Checked))
      *         invoke self::Response::Redirect("~/mainmenu.aspx")
           else
               set Msg::Text to "Login failed. Name or password incorrect".
       end method.


       method-id btnTrial_Click protected.
       local-storage section.
       01 userName        type String.
       01 encTicket       type String.
       01 teamName        pic x(15). 
       procedure division using by value sender as object e as type System.EventArgs.
           OPEN INPUT WEBPASS-FILE.
            IF STATUS-BYTE-1 NOT EQUAL ZEROES
               go to  100-done.

            MOVE WS-TEAM-NAME::ToUpper to WEBPASS-TEAM-NAME
      *     MOVE tbUser::Text TO WEBPASS-FIRST
      *     MOVE WS-FIRST TO WEBPASS-FIRST
            READ WEBPASS-FILE
                INVALID KEY
                    CLOSE WEBPASS-FILE
      *             invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Log in failed. Name incorrect or not authorized');", true)
      *              MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *              MOVE "NAME INCORRECT, OR NOT AUTHORIZED"
      *                  TO ERROR-MESSAGE-TEXT2
      *              PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
                    MOVE "X" TO WS-REJECT-FLAG

                    GO TO 100-DONE.
       100-DONE.
           CLOSE WEBPASS-FILE.

       end method.



       method-id verify_password protected.
       local-storage section.
       77  WORK-PASS                   PIC X(6)  COMP-X VALUE 0.
       77  WORK-PASS-X REDEFINES WORK-PASS  PIC X(6).
       77  WORK-FIELD                  PIC 9(18).
       01  xorConstant                 type Byte value h"2a".
       procedure division.
            OPEN INPUT WEBPASS-FILE.
            IF STATUS-BYTE-1 NOT EQUAL ZEROES
               go to  100-done.

            MOVE WS-TEAM-NAME::ToUpper to WEBPASS-TEAM-NAME
            MOVE WS-TEAM-NAME to self::Session["team"]
            MOVE WS-FIRST TO WEBPASS-FIRST
      *     MOVE WS-FIRST TO WEBPASS-FIRST
            READ WEBPASS-FILE
                INVALID KEY
                    CLOSE WEBPASS-FILE
      *             invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Log in failed. Name incorrect or not authorized');", true)
      *              MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *              MOVE "NAME INCORRECT, OR NOT AUTHORIZED"
      *                  TO ERROR-MESSAGE-TEXT2
      *              PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
                    MOVE "X" TO WS-REJECT-FLAG

                    GO TO 100-DONE.

           declare bData as type Byte occurs any = type System.Text.Encoding::UTF8::GetBytes(WS-PASS) 
           perform varying i as type Single from 0 by 1
             until i = bData::Length
               set bData[i] to bData[i] b-xor xorConstant
           end-perform
           declare boutput as type String = type Convert::ToBase64String(bData)


      *    declare bData2 as type Byte occurs any = type Convert::FromBase64String(WS-PASS)
      *    perform varying i as type Single from 0 by 1
      *      until i = bData2::Length
      *        set bData2[i] to bData2[i] b-xor xorConstant
      *    end-perform
      *    declare boutput2 as type String = type  System.Text.Encoding::UTF8::GetString(bData2)

      *     MOVE WS-PASS  TO WORK-PASS-X
      *     COMPUTE WORK-FIELD = WORK-PASS * 17.
      *     COMPUTE WORK-FIELD = 13 * (WORK-FIELD + 7).
      *     IF WORK-FIELD = WEBPASS-PASS
            IF boutput = WEBPASS-PASS::Trim
      *          MOVE WEBPASS-LEVEL TO BATSWEB1-SEC-LEVEL
      *           MOVE "Log In successful" TO ERROR-MESSAGE-TEXT
      *           PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
                MOVE "Y" TO WS-REJECT-FLAG

                ELSE
                MOVE "N" TO WS-REJECT-FLAG.
      *         invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Log in failed. Incorrect password');", true).
      *          MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *          MOVE "INCORRECT PASSWORD"
      *                  TO ERROR-MESSAGE-TEXT2
      *          PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
       100-DONE.
           CLOSE WEBPASS-FILE.

           goback.
       end method.

       method-id processJson protected
       local-storage section.
       01 json1                    type String.
       01 jsonRet                  type String.
       01 jsonRes                  type pucksweb.jsonRes.
       01 jsonReq                  type pucksweb.jsonReq.
      *01 mydata                   type pucksweb.bat300appData.
      *01 bat300apprununit         type RunUnit.
      *01 BAT300APPWEBF            type BAT300APPWEBF.       
       01 emptyTbl                 type String occurs 22.
       01 teamName        pic x(15). 
       01  WK-SEL-YEAR-FORMAT.
           05  WK-SEL-YEAR-START       PIC 9(4).
           05  FILLER                  PIC X VALUE "-".
           05  WK-SEL-YEAR-END         PIC 9(4).
       01  WS-SEL-YEAR-START.
           05 WS-SEL-Y-S               PIC 9999.
           05 FILLER                   PIC 9999 VALUE 0801.
       01  WS-SEL-YEAR-END.
           05 WS-SEL-Y-E               PIC 9999.
           05 FILLER                   PIC 9999 VALUE 0731.
       01  LK-FIELDS.
          05  LK-GAME-KEY.
               10  LK-GAME-DATE-1.
                   15  LK-GAME-DATE-YYYY           PIC 9999.
                   15  LK-GAME-DATE-MM             PIC 99.
                   15  LK-GAME-DATE-DD             PIC 99.
               10  LK-GAME-HOME                PIC X(15).
               10  LK-GAME-VISITORS            PIC X(15).
          05  LK-EVENT-TABLE OCCURS 3000 TIMES.
               10  LK-E-PRD                    PIC 99.
               10  LK-E-PRD-TIME-SECS        PIC 9(5).
               10  LK-E-PRD-CLOCK            PIC X(5).
               10  LK-E-VIS-SCORE               PIC 9(2).
               10  LK-E-HOME-SCORE              PIC 9(2).
               10  LK-E-VIS-SKATERS            PIC 9.
               10  LK-E-HOME-SKATERS            PIC 9.
               10  LK-E-CLIP-TYPE.
                   15  LK-E-CLIP-TYPE-CODE         PIC X(4).
                   15  LK-E-CLIP-SUB-CODE         PIC X(4).
               10  LK-E-MEDIA-FILE                 PIC X(100).
               10  LK-E-MEDIA-DURATION         PIC 9(5)V9.
               10  LK-E-MEDIA-START-SECS         PIC 9(5)V9.

               10  LK-E-ZONE                 PIC X.
               10  LK-E-ATEAM                PIC X(15).
               10  LK-E-BTEAM                PIC X(15).
               10  LK-E-A-STRENGTH            PIC 9.
               10  LK-E-B-STRENGTH           PIC 9.

               10  LK-E-APLAYERID            PIC X(7).
               10  LK-E-BPLAYERID            PIC X(7).
               10  LK-E-SHOT-TYPE            PIC XX.
               10  LK-E-EMPTY-NET            PIC X.
               10  LK-E-GOALZONE            PIC X.
               10  LK-E-X                     PIC 9(4).
               10  LK-E-Y                     PIC 9(4).
               10  LK-E-AREASON              PIC X(50).
           05  LK-TOI-TABLE OCCURS 3000 TIMES.
               10  LK-T-PLAYERID            PIC X(7).
               10  LK-T-PRD                    PIC 99.
               10  LK-T-PRD-TIME-SECS        PIC 9(5).
               10  LK-T-PRD-CLOCK            PIC X(5).
               10  LK-T-DURATION             PIC 9(5).
               10  LK-T-MEDIA-FILE                 PIC X(100).
               10  LK-T-MEDIA-DURATION         PIC 9(5)V9.
               10  LK-T-MEDIA-START-SECS         PIC 9(5)V9.
               10  LK-T-VIS-SKATERS            PIC 9.
               10  LK-T-HOME-SKATERS            PIC 9.
               10  LK-T-STRENGTH           PIC XX.
               10  LK-T-LAST            PIC X(15).
               10  LK-T-FIRST            PIC X(15).
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300app_dg.CPB".       
       procedure division.
           set reader to new StreamReader(Request::InputStream)
           set json1 to reader::ReadToEnd()
           invoke reader::Dispose.
       try 
           set jsonReq to type JsonConvert::DeserializeObject[type pucksweb.jsonReq](json1)
       catch ex as type Exception
           invoke self::Response::Write(ex::Message)
           invoke self::Response::End
           exit method           
       end-try

           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
           set WS-TEAM-NAME,  to jsonReq::credentials::team
      *     set WS-FIRST to jsonReq::credentials::first
           set WS-FIRST to jsonReq::credentials::username
           set WS-PASS to jsonReq::credentials::password
           set type HttpContext::Current::Session::Item("team") to WS-TEAM-NAME::Trim
           set teamName to WS-TEAM-NAME::Replace(" ", type String::Empty)   
debug * 
      *       string '"' app-data-folder delimited by "  "
             string '"' app-data-folder delimited by "pucksweb" teamName delimited by "  "
              '\WEBSYNC\BATSW020.DAT"' delimited by size
              into WS-BATSW020-FILE.
           
           invoke self::verify_password
           if WS-REJECT-FLAG not = "Y"
               invoke self::Response::Write("Invalid Credentials!")
               invoke self::Response::End
               exit method.

           set type HttpContext::Current::Session::Item("team") to jsonReq::credentials::team
               SET self::Session::Item("database") to jsonReq::database.

           set jsonRes to new pucksweb.jsonRes
           if jsonReq::type = "P"
               perform GET-PLAYERS thru PLAYER-DONE
           else if jsonReq::type = "G"
               perform GET-GAMES thru GAMES-DONE
           else if jsonReq::type = "D"
               perform GET-DATA thru DATA-DONE.

           set jsonRet to type JsonConvert::SerializeObject(jsonRes)
           invoke self::Response::Write(jsonRet)
           invoke self::Response::End
           exit method.

       GET-PLAYERS.
           set jsonRes::players to new List[type playerD]
           move 0 to aa.
           INITIALIZE PUCKS-DATA-BLOCK.
           MOVE "Y" TO SH-WEB-FORM-IP.
           set SH-WEB-FORM-APP-FOLDER to
             type HttpContext::Current::Server::MapPath("~/App_Data")
           set SH-WEB-FORM-SESSION-ID
                 to type HttpContext::Current::Session::SessionID
           set SH-WEB-FORM-DB
                 to type HttpContext::Current::Session::Item("database")
           set SH-WF-TEAM to
             type HttpContext::Current::Session::Item("team").
           CALL "PKFIL2" USING LK-FILE-NAMES, WS-NETWORK-FLAG.
           open input play-file.
       player-loop.
           read play-file next
               at end go to player-done.
           invoke jsonRes::players::Add(type playerD::New())   
           set jsonRes::players[aa]::id to PLAY-NHL-ID-R
           set jsonRes::players[aa]::lastName to PLAY-LAST-NAME::Trim
           set jsonRes::players[aa]::firstName to PLAY-FIRST-NAME::Trim
           set jsonRes::players[aa]::team to PLAY-TEAM-NAME::Trim
           set jsonRes::players[aa]::pos to PLAY-POS::Trim
           add 1 to aa
           go to player-loop.
       player-done.
           close play-file.

       GET-GAMES.
           set jsonRes::games to new List[type gameD]
           move 0 to aa.
           INITIALIZE PUCKS-DATA-BLOCK.
           MOVE "Y" TO SH-WEB-FORM-IP.
           set SH-WEB-FORM-APP-FOLDER to
             type HttpContext::Current::Server::MapPath("~/App_Data")
           set SH-WEB-FORM-SESSION-ID
                 to type HttpContext::Current::Session::SessionID
           set SH-WEB-FORM-DB
                 to type HttpContext::Current::Session::Item("database")
           set SH-WF-TEAM to
             type HttpContext::Current::Session::Item("team").
           CALL "PKFIL2" USING LK-FILE-NAMES, WS-NETWORK-FLAG.
           open input game-file.
           IF STATUS-BYTE-1 NOT EQUAL ZEROES
               GO TO games-done.
           MOVE jsonReq::year TO WK-SEL-YEAR-FORMAT.
           MOVE WK-SEL-YEAR-START TO WS-SEL-Y-S
           MOVE WK-SEL-YEAR-END TO WS-SEL-Y-E.

           INITIALIZE GAME-KEY.
           MOVE WS-SEL-YEAR-START TO GAME-DATE-1.

           START GAME-FILE KEY NOT < GAME-KEY
               INVALID KEY
                   GO TO games-done.
       games-loop.
           READ GAME-FILE NEXT WITH NO LOCK
               AT END
               GO TO games-done.

           IF GAME-DATE-1 > WS-SEL-YEAR-END
               GO TO games-done.

           invoke jsonRes::games::Add(type gameD::New())   

           IF GAME-HOME-SCORE NOT NUMERIC
               MOVE 0 TO GAME-HOME-SCORE.
           IF GAME-VIS-SCORE NOT NUMERIC
               MOVE 0 TO GAME-VIS-SCORE.

           set jsonRes::games[aa]::date to GAME-DATE-1
           set jsonRes::games[aa]::awayTeam to GAME-VISITORS::Trim
           set jsonRes::games[aa]::homeTeam to GAME-HOME-TEAM::Trim
           set jsonRes::games[aa]::awayScore to GAME-VIS-SCORE
           set jsonRes::games[aa]::homeScore to GAME-HOME-SCORE
           set jsonRes::games[aa]::gameType to GAME-PLAYOFF
           set jsonRes::games[aa]::lastPosted to GAME-UPL-TIME
           set jsonRes::games[aa]::gameDone to GAME-NHL-DONE
           add 1 to aa
           go to games-loop.
       games-done.
           close game-file.

       GET-DATA.
           set jsonRes::gameData to new List[type gameDataD]
           set jsonRes::toiData to new List[type toiDataD]
           initialize LK-FIELDS
           move jsonReq::date to LK-GAME-DATE-1
           move jsonReq::visitors to LK-GAME-VISITORS
           move jsonReq::home to LK-GAME-HOME
           call "PK360APP" using LK-FIELDS
           MOVE 1 TO aa.
       EVENT-LOOP.
           if LK-E-PRD(aa) = 0
               move 1 to aa
               go to TOI-LOOP.
           invoke jsonRes::gameData::Add(type gameDataD::New())   
           set jsonRes::gameData[aa - 1]::period to LK-E-PRD(aa)
           set jsonRes::gameData[aa - 1]::elapsedTime to LK-E-PRD-TIME-SECS(aa)
           set jsonRes::gameData[aa - 1]::gameTime to LK-E-PRD-CLOCK(aa)
           set jsonRes::gameData[aa - 1]::visScore to LK-E-VIS-SCORE(aa)
           set jsonRes::gameData[aa - 1]::homeScore to LK-E-HOME-SCORE(aa)
           set jsonRes::gameData[aa - 1]::visSkaters to LK-E-VIS-SKATERS(aa)
           set jsonRes::gameData[aa - 1]::homeSkaters to LK-E-HOME-SKATERS(aa)
           set jsonRes::gameData[aa - 1]::clipType to LK-E-CLIP-TYPE-CODE(aa)::Trim
           set jsonRes::gameData[aa - 1]::clipTypeSubCode to LK-E-CLIP-SUB-CODE(aa)::Trim
           if LK-GAME-DATE-1 > 20170800
               set jsonRes::gameData[aa - 1]::mediaFile to "https://vidsn.sydexsports.net" & LK-E-MEDIA-FILE(aa)::Replace("\", "/")::Trim
           else
               set jsonRes::gameData[aa - 1]::mediaFile to "https://vids10.sydexsports.net" & LK-E-MEDIA-FILE(aa)::Replace("\", "/")::Trim.
           set jsonRes::gameData[aa - 1]::mediaDuration to LK-E-MEDIA-DURATION(aa)
           set jsonRes::gameData[aa - 1]::mediaStart to LK-E-MEDIA-START-SECS(aa)
           set jsonRes::gameData[aa - 1]::zone to LK-E-ZONE(aa)
           set jsonRes::gameData[aa - 1]::aTeam to LK-E-ATEAM(aa)::Trim
           set jsonRes::gameData[aa - 1]::bTeam to LK-E-BTEAM(aa)::Trim
           set jsonRes::gameData[aa - 1]::aStrength to LK-E-A-STRENGTH(aa)
           set jsonRes::gameData[aa - 1]::bStrength to LK-E-B-STRENGTH(aa)
           set jsonRes::gameData[aa - 1]::aPlayerId to LK-E-APLAYERID(aa)
           set jsonRes::gameData[aa - 1]::bPlayerId to LK-E-BPLAYERID(aa)
           set jsonRes::gameData[aa - 1]::shotType to LK-E-SHOT-TYPE(aa)::Trim
           set jsonRes::gameData[aa - 1]::emptyNet to LK-E-EMPTY-NET(aa)
           set jsonRes::gameData[aa - 1]::goalZone to LK-E-GOALZONE(aa)
           set jsonRes::gameData[aa - 1]::x to LK-E-X(aa)
           set jsonRes::gameData[aa - 1]::y to LK-E-Y(aa)
           set jsonRes::gameData[aa - 1]::aReason to LK-E-AREASON(aa)::Trim
           add 1 to aa
           go to EVENT-LOOP.
       TOI-LOOP.
           if LK-T-PRD(aa) = 0
               go to DATA-DONE.
           invoke jsonRes::toiData::Add(type toiDataD::New())   
           set jsonRes::toiData[aa - 1]::playerId to LK-T-PLAYERID(aa)
           set jsonRes::toiData[aa - 1]::period to LK-T-PRD(aa)
           set jsonRes::toiData[aa - 1]::elapsedTime to LK-T-PRD-TIME-SECS(aa)
           set jsonRes::toiData[aa - 1]::gameTime to LK-T-PRD-CLOCK(aa)
           set jsonRes::toiData[aa - 1]::duration to LK-T-DURATION(aa)
           if LK-GAME-DATE-1 > 20170800
               set jsonRes::toiData[aa - 1]::mediaFile to "https://vidsn.sydexsports.net" & LK-T-MEDIA-FILE(aa)::Replace("\", "/")::Trim
           else
               set jsonRes::toiData[aa - 1]::mediaFile to "https://vids10.sydexsports.net" & LK-E-MEDIA-FILE(aa)::Replace("\", "/")::Trim.
           set jsonRes::toiData[aa - 1]::mediaDuration to LK-T-MEDIA-DURATION(aa)
           set jsonRes::toiData[aa - 1]::mediaStart to LK-T-MEDIA-START-SECS(aa)
           set jsonRes::toiData[aa - 1]::visSkaters to LK-T-VIS-SKATERS(aa)
           set jsonRes::toiData[aa - 1]::homeSkaters to LK-T-HOME-SKATERS(aa)
           set jsonRes::toiData[aa - 1]::strength to LK-T-STRENGTH(aa)
           set jsonRes::toiData[aa - 1]::first to LK-T-LAST(aa)::Trim
           set jsonRes::toiData[aa - 1]::last to LK-T-FIRST(aa)::Trim
           add 1 to aa
           go to TOI-LOOP.
       DATA-DONE.


      *database-start.
      *    if jsonReq::database = "B"
      *        SET self::Session::Item("database") to "MA"
      *    else
      *    if jsonReq::database = "I"
      *        SET self::Session::Item("database") to "MI"
      *    else
      *        SET self::Session::Item("database") to jsonReq::database.
      *    if self::Session["bat300appdata"] = null
      *        set mydata to new batsweb.bat300appData
      *        invoke mydata::populateData
      *        set self::Session["bat300appdata"] to mydata
      *    else
      *        set mydata to self::Session["bat300appdata"] as type batsweb.bat300appData.
      *
      *    if  self::Session::Item("300apprununit") not = null
      *        set bat300apprununit to self::Session::Item("300apprununit")
      *            as type RunUnit
      *        else
      *        set bat300apprununit to type RunUnit::New()
      *        set BAT300APPWEBF to new BAT300APPWEBF
      *        invoke bat300apprununit::Add(BAT300APPWEBF)
      *        set self::Session::Item("300apprununit") to  bat300apprununit.
      *   
      *    set address of BAT300APP-DIALOG-FIELDS to myData::tablePointer
       end method.

              
       end class.
