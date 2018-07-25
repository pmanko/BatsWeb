       class-id pucksweb.gameSummary is partial 
                implements type System.Web.UI.ICallbackEventHandler
                inherits type System.Web.UI.Page public.
                 
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *   SELECT GAME-FILE ASSIGN LK-GAME-FILE
      *       ORGANIZATION IS INDEXED
      *       ACCESS IS DYNAMIC
      *       RECORD KEY IS GAME-KEY
      *       LOCK MANUAL
      *       FILE STATUS IS STATUS-COMN.
      *DATA DIVISION.
      *FILE SECTION.
      *COPY "Y:\SYDEXSOURCE\FDS\FDPKGAME.CBL".

       working-storage section.
      *copy "y:\sydexsource\pucks\pucksglobal.cpb".
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
      *COPY "y:\sydexsource\pucks\wspuckf.CBL".
      *77  WS-NETWORK-FLAG             PIC X      VALUE "A".
       01 pk360rununit         type RunUnit.
       01 PK360WEBF                type PK360WEBF.
       01 mydata type pucksweb.pk360Data.
       01 callbackReturn type String.
       01 firstTimeFlag pic x.

       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.       
       LINKAGE SECTION.
           COPY "Y:\sydexsource\PUCKS\PK360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
           if self::IsPostBack
               invoke self::loadGames
               invoke self::loadLines
               exit method.

      *    Setup - from main menu                
           SET self::Session::Item("database") to self::Request::QueryString["league"]
           if   self::Session["pk360data"] = null
              set mydata to new pucksweb.pk360Data
              invoke mydata::populateData
              set self::Session["pk360data"] to mydata
           else
               set mydata to self::Session["pk360data"] as type pucksweb.pk360Data.

           if  self::Session::Item("360rununit") not = null
               set pk360rununit to self::Session::Item("360rununit")
                   as type RunUnit
                ELSE
                set pk360rununit to type RunUnit::New()
                set PK360WEBF to new PK360WEBF
                invoke pk360rununit::Add(PK360WEBF)
                set self::Session::Item("360rununit") to pk360rununit.
           
           set address of PK360-DIALOG-FIELDS to myData::tablePointer
      *
      *    INITIALIZE PUCKS-DATA-BLOCK.
      *    MOVE "Y" TO SH-WEB-FORM-IP.
      *    set SH-WEB-FORM-APP-FOLDER to
      *      type HttpContext::Current::Server::MapPath("~/App_Data")
      *    set SH-WEB-FORM-SESSION-ID
      *          to type HttpContext::Current::Session::SessionID
      *    set SH-WEB-FORM-DB
      *          to type HttpContext::Current::Session::Item("database")
      *    set SH-WF-TEAM to
      *      type HttpContext::Current::Session::Item("team").
      *    CALL "PKFIL2" USING LK-FILE-NAMES, WS-NETWORK-FLAG.
      *    invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & LK-GAME-FILE::Trim & "');", true)

           move "I" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
          
      *     set label1::Text to files[0]::Length
           if ERROR-FIELD NOT = SPACES
              invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
      *        invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & PK360-TEST-PATH::Trim & "');", true)
               move spaces to ERROR-FIELD.   
           invoke self::loadGames.

          IF PK360-GAMES-CHOICE = " "
               SET rbAllGames::Checked to true
            else if PK360-GAMES-CHOICE = "T"
               set rbTeam::Checked to true.

       move 1 to aa.
       5-loop.
           if aa > PK360-NUM-TEAMS
               go to 10-done
           else
               invoke ddTeam::Items::Add(PK360-TEAM-NAME(aa)).
           add 1 to aa
           go to 5-loop.
       10-done.
           if PK360-GAME-SEL-YR not = zeroes
               set ddYear::Text to PK360-GAME-SEL-YR::ToString
           else
               set ddYear::Text to type DateTime::Today::Year::ToString.
           if PK360-GAMES-TEAM not = spaces
               set ddTeam::Text to PK360-GAMES-TEAM.

           move 1 to aa.
       event-loop.
           if aa > DIALOG-EVT-NUM-ENTRIES
               go to event-done.
           invoke ddNHLEvent::Items::Add(DIALOG-EVT(aa))
           add 1 to aa
           go to event-loop.
       event-done.
           move 1 to aa.
       custom-loop.
           if aa > DIALOG-CUSTOM-NUM
               go to custom-done.
           invoke ddCustomEvent::Items::Add(DIALOG-CUSTOM-DESC(aa))
           add 1 to aa
           go to custom-loop.
       custom-done.
           set ddNHLEvent::SelectedIndex to 0
           if ddCustomEvent::Items::Count not = 0
               set ddCustomEvent::SelectedIndex to 0.

           goback.
       end method.

      *#####               Client Callback Implementation             #####
      *##### (https://msdn.microsoft.com/en-us/library/ms178208.aspx) #####
      *####################################################################
 
       method-id RaiseCallbackEvent public.
       local-storage section.
       01 actionFlag type String.
       01 methodArg type String.       
       01 n          type Single.
       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           
           if actionFlag = 'game-selected'
               set callbackReturn to actionFlag & "|" & self::gameSelected(methodArg)
           else if actionFlag = 'play-full'
               set callbackReturn to actionFlag & "|" & self::playFull()
           else if actionFlag = 'from-sel'
               set callbackReturn to actionFlag & "|" & self::fromSelected(methodArg)     
           else if actionFlag = 'from-toi'
               set callbackReturn to actionFlag & "|" & self::fromToi(methodArg)                             
           else if actionFlag = 'play-sel'
               set callbackReturn to actionFlag & "|" & self::playSelection(methodArg)  
           else if actionFlag = 'play-jump'
               set callbackReturn to actionFlag & "|" & self::playJump(methodArg) 
           else if actionFlag = 'play-goals'
               set callbackReturn to actionFlag & "|" & self::playGoals() 
           else if actionFlag = 'show-goals'
               set callbackReturn to actionFlag & "|" & self::showGoals(methodArg)
           else if actionFlag = 'goals-selection'
               set callbackReturn to actionFlag & "|" & self::goalsSelection(methodArg)
           else if actionFlag = 'update-play'
               set callbackReturn to actionFlag & "|" & self::playSelected(methodArg)
           else if actionFlag = "update-play-dblclick"
               set callbackReturn to actionFlag & "|" & self::playSelected(methodArg)
           else if actionFlag = 'update-goals'
               set callbackReturn to actionFlag & "|" & self::goalSelected(methodArg)
           else if actionFlag = "update-goals-dblclick"
               set callbackReturn to actionFlag & "|" & self::goalSelected(methodArg)
           else if actionFlag = 'update-toi'
               set callbackReturn to actionFlag & "|" & self::toiSelected(methodArg)
           else if actionFlag = "update-toi-dblclick"
               set callbackReturn to actionFlag & "|" & self::toiSelected(methodArg)
           else if actionFlag = 'cb-pp'
               set callbackReturn to actionFlag & "|" & self::cbPPGoals(methodArg)
           else if actionFlag = 'cb-chance'
               set callbackReturn to actionFlag & "|" & self::cbChance(methodArg)
           else if actionFlag = 'vis-fwd'
               set callbackReturn to actionFlag & "|" & self::fwdLines("V")
           else if actionFlag = 'home-fwd'
               set callbackReturn to actionFlag & "|" & self::fwdLines("H")
      *    List Box Re-Engineering
           else if actionFlag = 'vis-pp'
               set callbackReturn to actionFlag & "|" & self::visPPList()
           else if actionFlag = 'vis-sh'
               set callbackReturn to actionFlag & "|" & self::visSHList()
           else if actionFlag = 'vis-toi'
               set callbackReturn to actionFlag & "|" & self::visTOIList()
           else if actionFlag = 'home-pp'
               set callbackReturn to actionFlag & "|" & self::homePPList()
           else if actionFlag = 'home-sh'
               set callbackReturn to actionFlag & "|" & self::homeSHList()
           else if actionFlag = 'home-toi'
               set callbackReturn to actionFlag & "|" & self::homeTOIList()
      *    else if actionFlag = 'dd-period'
      *        set callbackReturn to actionFlag & "|" & self::ddPeriod()
           else if actionFlag = 'player'
               invoke type Single::TryParse(methodArg, reference n)
               set callbackReturn to actionFlag & "|" & self::player(n)
           else if actionFlag ='vis-rink' or 'home-rink'
               set callbackReturn to 'rink' & "|" & self::playRink(actionFlag, methodArg).
      *     else if (type Single::TryParse(actionFlag, reference n))
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################

      * ###################################################### 
      * ######### List Box Replacement Table Methods #########
      * ######################################################
       method-id addTableRow private.
       local-storage section.
       01 tRow type System.Web.UI.WebControls.TableRow.
       01 td type System.Web.UI.WebControls.TableCell.
       procedure division using by value targetTable as type System.Web.UI.WebControls.Table,
                          by value rowContent as type String,
                          by value rowType as type String.
           
           set td to type System.Web.UI.WebControls.TableCell::New()
           set tRow to type System.Web.UI.WebControls.TableRow::New()

           set td::Text to rowContent
           if rowType = 'b'
               set tRow::TableSection to type System.Web.UI.WebControls.TableRowSection::TableBody
           else
               set tRow::TableSection to type System.Web.UI.WebControls.TableRowSection::TableHeader.
           
    
           invoke tRow::Cells::Add(td)
           invoke targetTable::Rows::Add(tRow)
       end method.
       
       method-id getSelectedIndeces private.
       local-storage section.
       01 i type Int32.
       01 strArray type String[].
       procedure division using by value fieldValue as type String
                          returning indexArray as type Int32[].
       
           set strArray to fieldValue::Split(';')
           
           set size of indexArray to strArray::Length
           
           perform varying i from 0 by 1 until i >= strArray::Length
               set indexArray[i] to type Int32::Parse(strArray[i])
           end-perform
           
       end method.
       
       method-id getSelectedValues private.
       local-storage section.
       01 i type Int32.
       procedure division using by value fieldValue as type String
                          returning strArray as type String[].
      
           set strArray to fieldValue::Split(';')           
       end method.
       
       method-id getSelectedValue private.
       local-storage section.
       01 i type Int32.
       procedure division using by value fieldValue as type String
                          returning val as type String.
       
           set val to self::getSelectedValues(fieldValue)[0]           
       end method.       
       
       method-id getSelectedIndex private.
       local-storage section.
       01 i type Int32.
       procedure division using by value fieldValue as type String
                          returning idx as type Int32.
       
           set idx to self::getSelectedIndeces(fieldValue)[0]           
       end method.       
      * ######################################################       

       method-id loadGames protected.
       local-storage section.
      *    01 dataLine             type String.
      *    01 gameNum              pic x.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
      *    invoke gamesTable::Rows::Clear()
      *    invoke self::addTableRow(gamesTable, " Date       Vis                     Score Home                    Score Video Gametype"::Replace(" ", "&nbsp;"), 'h')
           set gamesField::Value to ""
           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-GAMES
               go to 10-done.
      *    else
      *    if PK360-G-NUM(AA) = 0
      *        move space to gameNum
      *    else
      *        move PK360-G-NUM(AA) to gameNum
      *    end-if
      *    set dataLine to PK360-G-DSP-DATE(AA)::ToString("0#/##/##") & " " &
      *    PK360-G-VIS(aa) & " " & PK360-G-VIS-SCORE(aa) & " " & PK360-G-HOME(aa) & " " & PK360-G-HOME-SCORE(aa) & " " & PK360-G-VIDEO(aa) & " " & PK360-G-PLAYOFF(AA)
      *    INSPECT dataline REPLACING ALL " " BY X'A0'
      *    invoke self::addTableRow(gamesTable, " " & dataLine, 'b').
           set gamesField::Value to gamesField::Value & PK360-G-DSP-DATE(AA)::ToString("0#/##/##") & "," &
           PK360-G-VIS(aa)::Trim & "," & PK360-G-VIS-SCORE(aa) & "," & PK360-G-HOME(aa)::Trim & "," & PK360-G-HOME-SCORE(aa) & "," & PK360-G-PLAYOFF(AA) & ";"
           add 1 to aa.
           go to 5-loop.
       10-done.
       end method.

       method-id loadLines final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
      *    invoke playTable::Rows::Clear()
      *    invoke self::addTableRow(playTable, "Pd V H   Description"::Replace(" ", "&nbsp;"), 'h')
           set playsField::Value to ""
           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-LINES
               go to 10-done.
      *    invoke self::addTableRow(playTable, " " & PK360-DATA-LINE(AA), 'b').
           set playsField::Value to playsField::Value & PK360-DATA-LINE(AA)::Trim & ";"
      *        MOVE BAT360-AB-LINE(AA) TO WS-DATA-LINE, WS-DATA-LINE2
      *        MOVE SPACES TO WS-ASTERISK
      *        IF WS-DATA-L = SPACES
      *            INSPECT WS-DATA-LINE REPLACING ALL " " BY X'A0'
      *        END-IF
           add 1 to aa.
           go to 5-loop.
       10-done.

     **Visitor Stats****
           set visTotalShots::Text to PK360-V-SHOTS
           set visTotalVal::Text to PK360-V-SH-VALUE
           set visFirstShots::Text to PK360-V-1ST-SHOTS
           set visFirstVal::Text to PK360-V-1ST-VALUE
           set visRebounds::Text to PK360-V-REB-SHOTS
           set visReboundVal::Text to PK360-V-REB-VALUE
           set visOppBlocked::Text to PK360-V-SH-BL-VALUE
           set visNetVal::Text to PK360-V-NET-VALUE
           set visEmptyGoals::Text to PK360-V-EMPTY-NET
           set visReboundGoals::Text to PK360-V-REB-GOALS

     **Home Stats****
           set homeTotalShots::Text to PK360-H-SHOTS
           set homeTotalVal::Text to PK360-H-SH-VALUE
           set homeFirstShots::Text to PK360-H-1ST-SHOTS
           set homeFirstVal::Text to PK360-H-1ST-VALUE
           set homeRebounds::Text to PK360-H-REB-SHOTS
           set homeReboundVal::Text to PK360-H-REB-VALUE
           set homeOppBlocked::Text to PK360-H-SH-BL-VALUE
           set homeNetVal::Text to PK360-H-NET-VALUE
           set homeEmptyGoals::Text to PK360-H-EMPTY-NET
           set homeReboundGoals::Text to PK360-H-REB-GOALS

      *TOI tables and such
       end method.

      ****************************** Radio Button Methods **************************************

       method-id rbAllGames_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if rbAllGames::Checked = true
               MOVE " " TO PK360-GAMES-CHOICE
               MOVE "RG" TO PK360-ACTION
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
                   move spaces to ERROR-FIELD
               else  
                   invoke self::loadGames.
       end method.

       method-id rbTeam_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if rbTeam::Checked = true
               set PK360-GAMES-TEAM to ddTeam::SelectedItem
               MOVE "T" TO PK360-GAMES-CHOICE
               if PK360-GAMES-TEAM IS NOT = " "
                   MOVE "RG" TO PK360-ACTION
                   invoke pk360rununit::Call("PK360WEBF")
                   if ERROR-FIELD NOT = SPACES
                       invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
                       move spaces to ERROR-FIELD
                   else  
                       invoke self::loadGames.
       end method.

       method-id rbAllEvents_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
            if rbAllEvents::Checked = true
               move "A" to PK360-ADVANCED-TYPE.
       end method.

       method-id rbNHLOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
            if rbNHLOnly::Checked = true
               move "N" to PK360-ADVANCED-TYPE.     
       end method.

       method-id rbCustomOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
            if rbCustomOnly::Checked = true
               move "C" to PK360-ADVANCED-TYPE.    
       end method.

      ****************************** DropDown Methods **************************************

       method-id ddTeam_SelectedIndexChanged protected.
       local-storage section.
       01 seasonYear       type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set PK360-GAMES-TEAM to ddTeam::SelectedItem
           if PK360-GAMES-CHOICE = "I" OR rbTeam::Checked = true
               move "RG" to PK360-ACTION
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
                   move spaces to ERROR-FIELD
               else  
                   invoke self::loadGames.
       end method.

       method-id ddYear_SelectedIndexChanged protected.
       local-storage section.
       01 seasonYear       type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set PK360-GAME-SEL-YR to ddYear::SelectedItem
           move "RG" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD
           else  
               invoke self::loadGames.
       end method.

       method-id ddNhlEvent_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           invoke type ScriptManager::RegisterStartupScript(self, self::GetType(), "", "dropdownflag();", true);
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set DIALOG-EVT-IDX TO ddNHLEvent::SelectedIndex
           add 1 to DIALOG-EVT-IDX
           if firstTimeFlag = "Y"
               exit method.
           move "RE" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD
           else  
               invoke self::loadLines.
       end method.

       method-id ddCustomEvent_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           invoke type ScriptManager::RegisterStartupScript(self, self::GetType(), "", "dropdownflag();", true);
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           add 1 to DIALOG-CUSTOM-IDX
           if firstTimeFlag = "Y"
               exit method.
           move "RE" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD
           else  
               invoke self::loadLines.
       end method.
       
       method-id ddPeriod_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           invoke type ScriptManager::RegisterStartupScript(self, self::GetType(), "", "dropdownflag();", true);
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set DIALOG-PRD-IDX to ddPeriod::SelectedIndex
           add 1 to DIALOG-PRD-IDX
           move "RA" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")

      **Group Box Labels for Vis and Home Team, Score and Shootouts********
           set lblHomeReport::Text to PK360-I-HOME & " " & PK360-SHOT-HOME-SCORE & " " & PK360-H-SHOOTOUT
           set lblVisReport::Text to PK360-I-VIS & " " & PK360-SHOT-VIS-SCORE & " " & PK360-V-SHOOTOUT
      *
     **Visitor Stats****
      *    set visTotalShots::Text to PK360-V-SHOTS
      *    set visTotalVal::Text to PK360-V-SH-VALUE
      *    set visFirstShots::Text to PK360-V-1ST-SHOTS
      *    set visFirstVal::Text to PK360-V-1ST-VALUE
      *    set visRebounds::Text to PK360-V-REB-SHOTS
      *    set visReboundVal::Text to PK360-V-REB-VALUE
      *    set visOppBlocked::Text to PK360-V-SH-BL-VALUE
      *    set visNetVal::Text to PK360-V-NET-VALUE
      *    set visEmptyGoals::Text to PK360-V-EMPTY-NET
      *    set visReboundGoals::Text to PK360-V-REB-GOALS
      *
     **Home Stats****
      *    set homeTotalShots::Text to PK360-H-SHOTS
      *    set homeTotalVal::Text to PK360-H-SH-VALUE
      *    set homeFirstShots::Text to PK360-H-1ST-SHOTS
      *    set homeFirstVal::Text to PK360-H-1ST-VALUE
      *    set homeRebounds::Text to PK360-H-REB-SHOTS
      *    set homeReboundVal::Text to PK360-H-REB-VALUE
      *    set homeOppBlocked::Text to PK360-H-SH-BL-VALUE
      *    set homeNetVal::Text to PK360-H-NET-VALUE
      *    set homeEmptyGoals::Text to PK360-H-EMPTY-NET
      *    set homeReboundGoals::Text to PK360-H-REB-GOALS
           invoke self::loadLines
       end method.
      *  CHECKBOX METHODS **************************************************

       method-id cbPPGoals protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value checked as type String 
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if checked = "true"
               MOVE "P" to PK360-CHANCE-FLAG2
               move  "GO" to PK360-ACTION 
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   set returnVal to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if     
               set returnVal to self::loadGoals
      *            set self::Text to "Power Play Goals"
           else
               MOVE " " to PK360-CHANCE-FLAG2
               move  "GO" to PK360-ACTION 
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   set returnVal to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if     
               set returnVal to self::loadGoals.
      *            set self::Text to "Goals"
               
       end method.

       method-id cbChance protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value checked as type String 
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if checked = "true"
               MOVE "Y" to PK360-CHANCE-FLAG
               move  "GO" to PK360-ACTION 
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   set returnVal to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if     
               set returnVal to self::loadGoals
      *            set self::Text to "Power Play Goals"
           else
               MOVE " " to PK360-CHANCE-FLAG
               move  "GO" to PK360-ACTION 
               invoke pk360rununit::Call("PK360WEBF")
               if ERROR-FIELD NOT = SPACES
                   set returnVal to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if     
               set returnVal to self::loadGoals.
      *            set self::Text to "Goals"
               
       end method.


      *    BUTTON METHODS *****************************************************************
       method-id fwdLines protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value team as type Char 
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set PK360-ACTION to "CL" & team
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
           end-if     
           set PK360-TOI-TEAM-FLAG TO team
               
       end method.

       method-id goalsButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
       end method.
       
       method-id playsButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

      *    if GamesValueField::Value = null or spaces
      *        invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You must select a game');", true)
      *        exit method.

           invoke self::loadStats
       end method.

       method-id btnOK_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set PK360-ADVANCED-INIT to tbAuthor::Text::ToUpper
           set PK360-ADVANCED-DESC to tbNote1::Text::ToUpper
           set PK360-ADVANCED-DESC2 to tbNote2::Text::ToUpper
           move "CA" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.  
           invoke self::loadLines
       end method.

       method-id gameSelected protected.
       local-storage section.
       01 temp type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

                  set PK360-SEL-GAME TO (type Int32::Parse(indexString) + 1)
      *           set gamesIndexField::Value TO PK360-SEL-GAME
           set playReturn to self::loadStats
       end method.

       method-id loadStats protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE PK360-G-GAME-DATE(PK360-SEL-GAME) to PK360-I-GAME-DATE
           MOVE PK360-G-GAME-ID(PK360-SEL-GAME) to PK360-I-GAME-ID
           MOVE PK360-G-VIS(PK360-SEL-GAME) to PK360-I-VIS
           MOVE PK360-G-HOME(PK360-SEL-GAME) to PK360-I-HOME
           MOVE PK360-G-VIS-SCORE(PK360-SEL-GAME) to PK360-I-VIS-SCORE
           MOVE PK360-G-HOME-SCORE(PK360-SEL-GAME) to PK360-I-HOME-SCORE
           MOVE 1 to DIALOG-CUSTOM-IDX
           MOVE "RA" TO PK360-ACTION
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.  
               
           set lblHome::Text to PK360-I-HOME
           set lblHomeReport::Text to PK360-I-HOME & " " & PK360-SHOT-HOME-SCORE & " " & PK360-H-SHOOTOUT
           set lblVis::Text to PK360-I-VIS
           set lblVisReport::Text to PK360-I-VIS & " " & PK360-SHOT-VIS-SCORE & " " & PK360-V-SHOOTOUT
           invoke ddCustomEvent::Items::Clear
           invoke ddNHLEvent::Items::Clear
           move 1 to aa.
       event-loop.
           if aa > DIALOG-EVT-NUM-ENTRIES
               go to event-done.
           invoke ddNHLEvent::Items::Add(DIALOG-EVT(aa))
           add 1 to aa
           go to event-loop.
       event-done.
           move 1 to aa.
       custom-loop.
           if aa > DIALOG-CUSTOM-NUM
               go to custom-done.
           invoke ddCustomEvent::Items::Add(DIALOG-CUSTOM-DESC(aa))
           add 1 to aa
           go to custom-loop.
       custom-done.
           set firstTimeFlag to "Y"
           set ddNHLEvent::SelectedIndex to 0
           if ddCustomEvent::Items::Count not = 0
               set ddCustomEvent::SelectedIndex to 0.
           set firstTimeFlag to "N"
                      
      *    set playReturn to self::loadStats
           invoke self::loadLines

       end method.

       method-id playSelected protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32[].
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move 0 to aa.
           move " " to PK360-ANY-FOUND
           initialize PK360-SHOW-EVENTS-TBL
           if indexString = null
               exit method.
           set selected to self::getSelectedIndeces(indexString).
                      
       videos-loop.
           if aa = selected::Count
               go to videos-done.

           set PK360-SEL-LINES to selected[aa]
      *   now longer need plus 1 for rowindex
      *    set PK360-SEL-LINES to selected[aa] + 1
           move PK360-SEL-LINES to PK360-LINE-IP        
           move "Y" to PK360-ANY-FOUND
           move "Y" to PK360-SHOW-EVENT(PK360-LINE-IP).
           add 1 to aa
           go to videos-loop.
       videos-done.
                        
           MOVE "VL" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.

       end method.

       method-id goalSelected protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if indexString = null
               set PK360-SEL-LINES, PK360-LINE-IP to 0
               exit method.
           set selected to self::getSelectedIndex(indexString).
           set PK360-SEL-LINES to selected + 1
           set PK360-LINE-IP TO PK360-SEL-LINES
                          
           MOVE "VI" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.


       method-id toiSelected protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if indexString = null
               set PK360-TOI-IP, PK360-WK-T-IP to 0
               exit method.
           set selected to self::getSelectedIndex(indexString).
           set PK360-TOI-IP to selected + 1
           set PK360-WK-T-IP TO PK360-TOI-IP
                          
           MOVE "TP" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

       method-id showGoals protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set PK360-SEL-GAME TO (type Int32::Parse(indexString) + 1)
           if PK360-SEL-GAME = 0
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You must select a game date!');", true).

           MOVE PK360-G-GAME-DATE(PK360-SEL-GAME) to PK360-I-GAME-DATE
           move PK360-G-GAME-ID(PK360-SEL-GAME) to PK360-I-GAME-ID
           move "GO" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.  
           MOVE "N" to PK360-IND-FLAG.
           set returnVal to self::loadGoals
       end method.

       method-id loadGoals protected.
       local-storage section.
       01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           move 1 to aa.
       5-loop.
           if aa > PK360-GO-NUM-LINES
               go to 10-done.
           set dataLine to PK360-DATA-LINE2(AA)
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.
       
       end method.

      * TOI listboxs
       method-id visPPList final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           move 0 to PK360-SEL-TOI-ID
           move "P" to PK360-SHIFT-TYPE
           move "V" to PK360-SHIFT-TEAM
           move "TV" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
      *     SET lblPlayerName::Text to PK360-I-TOI-NAME::Trim

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.     

           move 1 to aa.
           set returnVal to self::toiLines.
       end method.

       method-id visSHList final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           move 0 to PK360-SEL-TOI-ID
           move "S" to PK360-SHIFT-TYPE
           move "V" to PK360-SHIFT-TEAM
           move "TV" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
      *     SET lblPlayerName::Text to PK360-I-TOI-NAME::Trim

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.     

           set returnVal to self::toiLines.
       end method.

       method-id visTOIList final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           if PK360-V-NUM-TOI = 0
               set returnVal to "er|" & "No time on ice found for this team."
           else
               set PK360-TOI-TEAM-FLAG TO "V".

           if PK360-V-TOI-NAME(1) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(1)::Trim & ";".
           if PK360-V-TOI-NAME(2) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(2)::Trim & ";".
           if PK360-V-TOI-NAME(3) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(3)::Trim & ";".
           if PK360-V-TOI-NAME(4) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(4)::Trim & ";".
           if PK360-V-TOI-NAME(5) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(5)::Trim & ";".
           if PK360-V-TOI-NAME(6) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(6)::Trim & ";".
           if PK360-V-TOI-NAME(7) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(7)::Trim & ";".
           if PK360-V-TOI-NAME(8) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(8)::Trim & ";".
           if PK360-V-TOI-NAME(9) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(9)::Trim & ";".
           if PK360-V-TOI-NAME(10) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(10)::Trim & ";".
           if PK360-V-TOI-NAME(11) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(11)::Trim & ";".
           if PK360-V-TOI-NAME(12) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(12)::Trim & ";".
           if PK360-V-TOI-NAME(13) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(13)::Trim & ";".
           if PK360-V-TOI-NAME(14) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(14)::Trim & ";".
           if PK360-V-TOI-NAME(15) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(15)::Trim & ";".
           if PK360-V-TOI-NAME(16) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(16)::Trim & ";".
           if PK360-V-TOI-NAME(17) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(17)::Trim & ";".
           if PK360-V-TOI-NAME(18) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(18)::Trim & ";".
           if PK360-V-TOI-NAME(19) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(19)::Trim & ";".
           if PK360-V-TOI-NAME(20) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(20)::Trim & ";".
           if PK360-V-TOI-NAME(21) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(21)::Trim & ";".
           if PK360-V-TOI-NAME(22) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(22)::Trim & ";".
           if PK360-V-TOI-NAME(23) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(23)::Trim & ";".
           if PK360-V-TOI-NAME(24) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(24)::Trim & ";".
           if PK360-V-TOI-NAME(25) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(25)::Trim & ";".
           if PK360-V-TOI-NAME(26) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(26)::Trim & ";".
           if PK360-V-TOI-NAME(27) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(27)::Trim & ";".
           if PK360-V-TOI-NAME(28) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(28)::Trim & ";".
           if PK360-V-TOI-NAME(29) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(29)::Trim & ";".
           if PK360-V-TOI-NAME(30) not = spaces
               set returnVal to returnVal & PK360-V-TOI-NAME(30)::Trim & ";".
       end method.

       method-id homePPList final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           move 0 to PK360-SEL-TOI-ID
           move "P" to PK360-SHIFT-TYPE
           move "H" to PK360-SHIFT-TEAM
           move "TV" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
      *     SET lblPlayerName::Text to PK360-I-TOI-NAME::Trim

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.     
                 
           set returnVal to self::toiLines.
       end method.

       method-id homeSHList final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           move 0 to PK360-SEL-TOI-ID
           move "S" to PK360-SHIFT-TYPE
           move "H" to PK360-SHIFT-TEAM
           move "TV" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
      *     SET lblPlayerName::Text to PK360-I-TOI-NAME::Trim

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.     
           set returnVal to self::toiLines.
       end method.

       method-id toiLines final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-TOI
               go to 10-done.
           set dataLine to (" " & PK360-T-PERIOD(aa) & " " & PK360-T-IN-TIME-XXX(AA) & " " & PK360-T-OUT-TIME-XXX(AA) & " " &
               type System.String::Format("{0,5:#####}", PK360-T-DURATION(AA)) & " " & PK360-T-SHIFT-TYPE(AA))
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.
       
       end method.

       method-id homeTOIList final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""
           if PK360-H-NUM-TOI = 0
               set returnVal to "er|" & "No time on ice found for this team."
               exit method
           else
               set PK360-TOI-TEAM-FLAG TO "H".
           if PK360-H-TOI-NAME(1) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(1)::Trim & ";".
           if PK360-H-TOI-NAME(2) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(2)::Trim & ";".
           if PK360-H-TOI-NAME(3) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(3)::Trim & ";".
           if PK360-H-TOI-NAME(4) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(4)::Trim & ";".
           if PK360-H-TOI-NAME(5) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(5)::Trim & ";".
           if PK360-H-TOI-NAME(6) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(6)::Trim & ";".
           if PK360-H-TOI-NAME(7) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(7)::Trim & ";".
           if PK360-H-TOI-NAME(8) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(8)::Trim & ";".
           if PK360-H-TOI-NAME(9) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(9)::Trim & ";".
           if PK360-H-TOI-NAME(10) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(10)::Trim & ";".
           if PK360-H-TOI-NAME(11) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(11)::Trim & ";".
           if PK360-H-TOI-NAME(12) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(12)::Trim & ";".
           if PK360-H-TOI-NAME(13) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(13)::Trim & ";".
           if PK360-H-TOI-NAME(14) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(14)::Trim & ";".
           if PK360-H-TOI-NAME(15) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(15)::Trim & ";".
           if PK360-H-TOI-NAME(16) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(16)::Trim & ";".
           if PK360-H-TOI-NAME(17) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(17)::Trim & ";".
           if PK360-H-TOI-NAME(18) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(18)::Trim & ";".
           if PK360-H-TOI-NAME(19) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(19)::Trim & ";".
           if PK360-H-TOI-NAME(20) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(20)::Trim & ";".
           if PK360-H-TOI-NAME(21) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(21)::Trim & ";".
           if PK360-H-TOI-NAME(22) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(22)::Trim & ";".
           if PK360-H-TOI-NAME(23) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(23)::Trim & ";".
           if PK360-H-TOI-NAME(24) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(24)::Trim & ";".
           if PK360-H-TOI-NAME(25) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(25)::Trim & ";".
           if PK360-H-TOI-NAME(26) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(26)::Trim & ";".
           if PK360-H-TOI-NAME(27) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(27)::Trim & ";".
           if PK360-H-TOI-NAME(28) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(28)::Trim & ";".
           if PK360-H-TOI-NAME(29) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(29)::Trim & ";".
           if PK360-H-TOI-NAME(30) not = spaces
               set returnVal to returnVal & PK360-H-TOI-NAME(30)::Trim & ";".
       end method.

       method-id player final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\PUCKS\PK360_dg.CPB".
       procedure division using num as type Single returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""

           if PK360-TOI-TEAM-FLAG = "V"
               MOVE PK360-V-TOI-ID(num) TO PK360-SEL-TOI-ID
           else
               MOVE PK360-H-TOI-ID(num) TO PK360-SEL-TOI-ID.
           MOVE "TS" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 

           set PK360-TOI-IP, PK360-WK-T-IP to 0

           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-TOI
               go to 10-done.
           set dataLine to (" " & PK360-T-PERIOD(aa) & " " & PK360-T-IN-TIME-XXX(AA) & " " & PK360-T-OUT-TIME-XXX(AA) & " " &
               type System.String::Format("{0,5:#####}", PK360-T-DURATION(AA)) & " " & PK360-T-SHIFT-TYPE(AA))
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.

       end method.

      * VIDEO *****************

       method-id fromToi protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

           if indexString = null
               set PK360-TOI-IP, PK360-WK-T-IP to 0
           else
               set selected to self::getSelectedIndex(indexString).
               set PK360-TOI-IP to selected + 1
               set PK360-WK-T-IP TO PK360-TOI-IP.
                                         
           MOVE "TA" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

       method-id fromSelected protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32[].
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move 0 to aa.
           move " " to PK360-ANY-FOUND
           initialize PK360-SHOW-EVENTS-TBL
           if indexString = null
               set playReturn to "er|" & "No starting point is highlighted"
               exit method.
           set selected to self::getSelectedIndeces(indexString).

       videos-loop.
           if aa = selected::Count
               go to videos-done.

           set PK360-SEL-LINES to selected[aa] 
           move PK360-SEL-LINES to PK360-LINE-IP        
           move "Y" to PK360-ANY-FOUND
           move "Y" to PK360-SHOW-EVENT(PK360-LINE-IP).
       videos-done.
                              
           MOVE "VH" to PK360-ACTION
           
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id playSelection protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32[].
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move 0 to aa.
           move " " to PK360-ANY-FOUND
           initialize PK360-SHOW-EVENTS-TBL
           if indexString = null
               go to videos-done.
           set selected to self::getSelectedIndeces(indexString).
       videos-loop.
           if aa = selected::Count
               go to videos-done.

           set PK360-SEL-LINES to selected[aa]
           move PK360-SEL-LINES to PK360-LINE-IP        
           move "Y" to PK360-ANY-FOUND
           move "Y" to PK360-SHOW-EVENT(PK360-LINE-IP).
           add 1 to AA.
           go to videos-loop.
       videos-done.
           if PK360-ANY-FOUND = space
               move "Y" to PK360-ALL-FLAG.                              
           MOVE "VS" to PK360-ACTION
           
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.
       
       method-id playFull protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move "VA" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id playGoals protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move "VT" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id goalsSelection protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32[].
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move 0 to aa.
           move " " to PK360-ANY-FOUND
           initialize PK360-SHOW-EVENTS-TBL
           if indexString = null
               set playReturn to "er|" & "No starting point is highlighted"
               exit method.
           set selected to self::getSelectedIndeces(indexString).

       videos-loop.
           if aa = selected::Count
               go to videos-done.

           set PK360-SEL-LINES to selected[aa] + 1
           move PK360-SEL-LINES to PK360-LINE-IP        
           move "Y" to PK360-ANY-FOUND
           move "Y" to PK360-SHOW-EVENT(PK360-LINE-IP).
           add 1 to AA.
           go to videos-loop.
       videos-done.
                              
           MOVE "VG" to PK360-ACTION
           
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.

       end method.

       method-id playJump protected.
       local-storage section.
       01 num type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type System.Single::TryParse(indexString::Substring(0, 1), by reference num)
           set PK360-JUMP-PERIOD to num
           invoke type System.Single::TryParse(indexString::Substring(2, indexString::IndexOf(":") - 2), by reference num)
           set PK360-JUMP-MIN to num
           invoke type System.Single::TryParse(indexString::Substring(indexString::IndexOf(":") + 1), by reference num)
           set PK360-JUMP-SEC to num
           move "PJ" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > PK360-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa)::Trim & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
               (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM    *     set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-A(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
      *         (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM         set vidTitles to vidTitles & PK360-WF-VIDEO-TITL(aa) & ";"
           
           if PK360-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-B(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
               (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
               set vidTitles to vidTitles & "B;".
           if PK360-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if PK360-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.


      *************** RINK CLICKS ****************************

       method-id playRink protected.
       local-storage section.
PM    *01 xVal type String. 
 PM   *01 yVal type String.
       01 iNum         type Int16.
       01 vals     type String occurs 4.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using homeAway as type String, 
                          xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set vals to xyVal::Split(",")
      *    set xVal to xyVal::Substring(0, xyVal::IndexOf(","))
      *    set yVal to xyVal::Substring(xyVal::IndexOf(",") + 1)
           invoke type Int16::TryParse(vals[0], iNum)
           set MOUSEX to iNum          
           invoke type Int16::TryParse(vals[1], iNum)
           set MOUSEY to iNum
           invoke type Int16::TryParse(vals[2], iNum)
           set MOUSEX2 to iNum + MOUSEX         
           invoke type Int16::TryParse(vals[3], iNum)
           set MOUSEY2 to iNum + MOUSEY
           if homeAway = 'vis-rink'
               MOVE MOUSEX TO PK360-RINK-V-IN-X
               MOVE MOUSEX2 TO PK360-RINK-V-OUT-X
               MOVE MOUSEY TO PK360-RINK-V-IN-Y
               MOVE MOUSEY2 TO PK360-RINK-V-OUT-Y
               move "L4" to PK360-ACTION
               invoke pk360rununit::Call("PK360WEBF")
           else
               MOVE MOUSEX TO PK360-RINK-h-IN-X
               MOVE MOUSEX2 TO PK360-RINK-H-OUT-X
               MOVE MOUSEY TO PK360-RINK-H-IN-Y
               MOVE MOUSEY2 TO PK360-RINK-H-OUT-Y
               move "R4" to PK360-ACTION
               invoke pk360rununit::Call("PK360WEBF").
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK360-WF-VID-COUNT = 0
               set returnVal to "er|" & "No clip at that location"
               exit method.

           invoke self::batstube.
      *    set vidPaths to ""
PM    *    set vidTitles to ""
      *    move 1 to aa.
      *lines-loop.
      *    if aa > BAT310-WF-VID-COUNT
      *        go to lines-done.
      *    
      *    
      *    REFACTOR BATSTUBE SETUP --> SINGLE CLASS     
PM    *    set vidPaths to vidPaths & BAT310-WF-VIDEO-PATH(aa) & BAT310-WF-VIDEO-A(aa) & ";"          
PM    *    set vidTitles to vidTitles & BAT310-WF-VIDEO-TITL(aa) & ";"
      *    
      *    if BAT310-WF-VIDEO-B(aa) not = spaces
      *        set vidPaths to vidPaths & BAT310-WF-VIDEO-PATH(aa) & BAT310-WF-VIDEO-B(aa) & ";"
      *        set vidTitles to vidTitles & "B;".
      *    if BAT310-WF-VIDEO-C(aa) not = spaces
      *        set vidPaths to vidPaths & BAT310-WF-VIDEO-PATH(aa) & BAT310-WF-VIDEO-C(aa) & ";"
      *        set vidTitles to vidTitles & "C;".
      *    if BAT310-WF-VIDEO-D(aa) not = spaces
      *        set vidPaths to vidPaths & BAT310-WF-VIDEO-PATH(aa) & BAT310-WF-VIDEO-D(aa) & ";"
      *        set vidTitles to vidTitles & "D;".
      *        
      *    add 1 to aa.
      *    go to lines-loop.
      *lines-done.
PM    *    set self::Session::Item("video-paths") to vidPaths
PM    *    set self::Session::Item("video-titles") to vidTitles
      *    END REFACTOR
           set returnVal to "play"
           
       end method.

       end class.
