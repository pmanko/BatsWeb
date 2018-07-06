       class-id pucksweb.goalieAnalysis is partial 
                implements type System.Web.UI.ICallbackEventHandler
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

       DATA DIVISION.
       FILE SECTION.
       COPY "Y:\SYDEXSOURCE\FDS\FDPKPLAY.CBL".

       working-storage section.
       copy "y:\sydexsource\pucks\pucksglobal.cpb".
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       COPY "y:\sydexsource\pucks\wspuckf.CBL".
       77  WS-NETWORK-FLAG             PIC X      VALUE "A".
       01 pk330rununit         type RunUnit.
       01 PK330WEBF                type PK330WEBF.
       01 mydata type pucksweb.pk330Data.
       01 myData330 type pucksweb.pk340Data.
       01 callbackReturn type String.
       01 playerName      type String.
       01 nameArray      type String.
       01 firstTimeFlag  pic x.
       01 resetFlag      pic x.
       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.   
       LINKAGE SECTION.
           COPY "Y:\sydexsource\PUCKS\PK330_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
           if self::IsPostBack
               exit method.

      *    Setup - from main menu                
           SET self::Session::Item("database") to self::Request::QueryString["league"]
           if   self::Session["pk330data"] = null
              set mydata to new pucksweb.pk330Data
              invoke mydata::populateData
              set self::Session["pk330data"] to mydata
           else
               set mydata to self::Session["pk330data"] as type pucksweb.pk330Data.

           if  self::Session::Item("330rununit") not = null
               set pk330rununit to self::Session::Item("330rununit")
                   as type RunUnit
                ELSE
                set pk330rununit to type RunUnit::New()
                set PK330WEBF to new PK330WEBF
                invoke pk330rununit::Add(PK330WEBF)
                set self::Session::Item("330rununit") to pk330rununit.
           
           set address of PK330-DIALOG-FIELDS to myData::tablePointer
           move "I" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")

       invoke ddPeriod::Items::Clear.
       invoke ddSituation::Items::Clear.
       invoke ddScore::Items::Clear.
       invoke ddShotResult::Items::Clear.
       invoke ddShotType::Items::Clear.
       
       move 1 to aa.
       period-loop.
           if aa > DIALOG-PRD-NUM-ENTRIES
               go to period-done.
           invoke ddPeriod::Items::Add(DIALOG-PRD-DESC(AA)::Trim)
           add 1 to aa
           go to period-loop.
       period-done.   
       
       move 1 to aa.
       situation-loop.
           if aa > DIALOG-ADV-NUM-ENTRIES
               go to situation-done.
           invoke ddSituation::Items::Add(DIALOG-ADV(AA)::Trim)
           add 1 to aa
           go to situation-loop.
       situation-done. 
       
       move 1 to aa.
       score-loop.
           if aa > DIALOG-SCR-NUM-ENTRIES
               go to score-done.
           invoke ddScore::Items::Add(DIALOG-SCR-DESC(AA)::Trim)
           add 1 to aa
           go to score-loop.
       score-done.
       
       move 1 to aa.
       shotresult-loop.
           if aa > DIALOG-SHR-NUM-ENTRIES
               go to shotresult-done.
           invoke ddShotResult::Items::Add(DIALOG-SHR(AA)::Trim)
           add 1 to aa
           go to shotresult-loop.
       shotresult-done.
       
       move 1 to aa.
       shottype-loop.
           if aa > DIALOG-SHT-NUM-ENTRIES
               go to shottype-done.
           invoke ddShotType::Items::Add(DIALOG-SHT(AA)::Trim)
           add 1 to aa
           go to shottype-loop.
       shottype-done.
           set ddPctChances::SelectedIndex to 0
           set ddPeriod::SelectedIndex to 0
           set ddScore::SelectedIndex to 0
           set ddShotResult::SelectedIndex to 0
           set ddShotType::SelectedIndex to 0
           set ddSituation::SelectedIndex to 0
           move 1 to SH-PK340-FLAG
           move "Y" to PK330-BYPASS-FLAG
           move "FD" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           if PK330-BYPASS-FLAG not = "Y"
               invoke self::Recalc.

           invoke self::pk340.
           set tbRbdSeconds::Text to PK330-REBOUND-SECS
      *pk340 stuff
      *     invoke self::Recalc      
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
           
           if actionFlag = "od"
               set callbackReturn to actionFlag & "|" & self::SetGameDates(methodArg)
           else if actionFlag = "pt"
               set callbackReturn to actionFlag & "|" & self::btnPlayerTeamOK_Click(methodArg)
           else if actionFlag = "ot"
               set callbackReturn to actionFlag & "|" & self::btnOppTeamOK_Click(methodArg)
           else if actionFlag = "oo"
               set callbackReturn to actionFlag & "|" & self::btnOppAll_Click()
           else if actionFlag = "oe"
               set callbackReturn to actionFlag & "|" & self::btnEastConf_Click()
           else if actionFlag = "oa"
               set callbackReturn to actionFlag & "|" & self::btnEastAtl_Click()
           else if actionFlag = "om"
               set callbackReturn to actionFlag & "|" & self::btnEastMetro_Click()
           else if actionFlag = "ow"
               set callbackReturn to actionFlag & "|" & self::btnWestConf_Click()
           else if actionFlag = "oc"
               set callbackReturn to actionFlag & "|" & self::btnWestCent_Click()
           else if actionFlag = "op"
               set callbackReturn to actionFlag & "|" & self::btnWestPac_Click()
           else if actionFlag = "sp"
               set callbackReturn to actionFlag & "|" & self::btnSelectPlayer_Click()
           else if actionFlag = 'lr'
               set callbackReturn to actionFlag & "|" & self::ddPlayerTeam(methodArg)
           else if actionFlag = 'po'
               set callbackReturn to actionFlag & "|" & self::btnSelectPlayerOK_Click(methodArg)
           else if actionFlag = 'top-left' or 'top-center' or 'top-right' or 'bottom-left' or 'bottom-center' or 'bottom-right'
               set callbackReturn to actionFlag & "|" & self::playNet(actionFlag)
           else if actionFlag = "play-rink"
               set callbackReturn to actionFlag & "|" & self::playRink(methodArg)
           else if actionFlag = "store-rink"
               set callbackReturn to actionFlag & "|" & self::storeRink(methodArg)
           else if actionFlag = 'cb-hide'
               invoke self::cbHideLines(methodArg)
               set callbackReturn to actionFlag
           else if actionFlag = "play-full"
               set callbackReturn to actionFlag & "|" & self::btnPlayAll_Click()
           else if actionFlag = "play-field"
               set callbackReturn to actionFlag & "|" & self::playField(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################

      ****************************** Radio Button Methods **************************************
       method-id rbStartAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbStartAll::Checked
               MOVE "A" to PK340-GAME-FLAG.
       end method.

       method-id rbStartDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbStartDate::Checked
               MOVE "D" to PK340-GAME-FLAG.
       end method.

       method-id rbEndAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbEndAll::Checked
               MOVE "A" to PK340-END-GAME-FLAG.
       end method.

       method-id rbEndDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbEndDate::Checked
               MOVE "D" to PK340-END-GAME-FLAG.
       end method.

       method-id rbAllGames_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbAllSeasonGames::Checked
               MOVE "A" to PK340-GAME-TYPE-FLAG.
       end method.

       method-id rbPreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbPreSeason::Checked
               MOVE "S" to PK340-GAME-TYPE-FLAG.
       end method.

       method-id rbRegularSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbRegSeason::Checked
               MOVE "R" to PK340-GAME-TYPE-FLAG.
       end method.

       method-id rbExcludePreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbExcludePreSeason::Checked
               MOVE "N" to PK340-GAME-TYPE-FLAG.
       end method.

       method-id rbPlayoffs_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbPlayoffs::Checked
               MOVE "P" to PK340-GAME-TYPE-FLAG.
       end method.

       method-id rbAllLocations_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbAllLocations::Checked
               MOVE " " to PK340-PLAYER-LOC-FLAG.
       end method.

       method-id rbHome_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbPlayerHome::Checked
               MOVE "H" to PK340-PLAYER-LOC-FLAG.
       end method.

       method-id rbAway_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           if rbPlayerAway::Checked
               MOVE "A" to PK340-PLAYER-LOC-FLAG.
       end method.

       method-id rbGreaterOrEq_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           if rbGreaterOrEq::Checked = true
               move "M" to PK330-CHANCE-FLAG
       end method.
       
       method-id rbLess_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           if rbLess::Checked = true
               move "L" to PK330-CHANCE-FLAG
       end method.
      ******************************************************************************************

      ********************************** DropDown Methods **************************************

       method-id ddPeriod_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set DIALOG-PRD-MASTER to ddPeriod::SelectedItem
           set DIALOG-PRD-IDX to ddPeriod::SelectedIndex
           add 1 to DIALOG-PRD-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddScore_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set DIALOG-SCR-MASTER to ddScore::SelectedItem
           set DIALOG-SCR-IDX to ddScore::SelectedIndex
           add 1 to DIALOG-SCR-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddSituation_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set DIALOG-ADV-MASTER to ddSituation::SelectedItem
           set DIALOG-ADV-IDX to ddSituation::SelectedIndex
           add 1 to DIALOG-ADV-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddShotResult_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set DIALOG-SHR-MASTER to ddShotResult::SelectedItem
           set DIALOG-SHR-IDX to ddShotResult::SelectedIndex
           add 1 to DIALOG-SHR-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddShotType_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set DIALOG-SHT-MASTER to ddShotType::SelectedItem
           set DIALOG-SHT-IDX to ddShotType::SelectedIndex
           add 1 to DIALOG-SHT-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddPctChances_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
          if ddPctChances::SelectedIndex = 4     
               invoke type ScriptManager::RegisterStartupScript(self, self::GetType(), "", "openChances();", true);
      *        if CustomChancesForm = null or CustomChancesForm::IsDisposed
      *            set CustomChancesForm to new PlayerBreakdown.CustomChancesForm
      *            invoke CustomChancesForm::add_FormClosed(new System.Windows.Forms.FormClosedEventHandler(self::CustomChancesForm_Closed))
      *        else
      *            invoke CustomChancesForm::Focus
      *        end-if
      *        invoke CustomChancesForm::Show  
      *    else    
           else
               set PK330-CHA-MASTER to ddPctChances::SelectedItem
               set PK330-CHA-IDX to ddPctChances::SelectedIndex
               add 1 to PK330-CHA-IDX
               if resetFlag not = "Y"
                   invoke self::Recalc.
       end method.

       method-id ddPlayerTeam private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value selectedTeam as String
                          returning teamList as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
               set pk330rununit to self::Session::Item("330rununit")
                   as type RunUnit       
           set PK340-SEL-TEAM to selectedTeam 
           move PK340-SEL-TEAM to PK340-PLAYER-TEAM
           MOVE "RP" TO PK340-ACTION 
           invoke pk330rununit::Call("PK340WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.              
           set teamList to ""

           move 1 to aa.
       5-loop.
           if aa > PK340-NUM-PLAYERS
               go to 10-done
           else
               set teamList to teamList & (" " & PK340-ROSTER-NAME(aa) & " " & PK340-ROSTER-POS(aa)) & ";".
      *         set teamList to teamList & aa & "," & (" " & PK340-ROSTER-NAME(aa) & " " & PK340-ROSTER-POS(aa)) & ";".
           add 1 to aa.
           go to 5-loop.
       10-done.
           move 1 to aa.

       end method.
      ******************************************************************************************

      ********************************** Checkbox Methods **************************************
       method-id cbShCausingRbd_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           if cbShCausingRbd::Checked = true
               set cbReboundShotsOnly::Enabled to false
               set cbFirstShotsOnly::Enabled to false
               move "P" to PK330-RBDS-ONLY-FLAG
           else
               set cbReboundShotsOnly::Enabled to true
               set cbFirstShotsOnly::Enabled to true
               move " " to PK330-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.     
       end method.


       method-id cbFirstShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           if cbFirstShotsOnly::Checked = true
               set cbReboundShotsOnly::Enabled to false
               set cbShCausingRbd::Enabled to false
               move "1" to PK330-RBDS-ONLY-FLAG
           else  
               set cbReboundShotsOnly::Enabled to true
               set cbShCausingRbd::Enabled to true
               move " " to PK330-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.     
       end method.

       method-id cbReboundShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           if cbReboundShotsOnly::Checked = true
               set cbFirstShotsOnly::Enabled to false
               set cbShCausingRbd::Enabled to false
               move "Y" to PK330-RBDS-ONLY-FLAG
           else  
               set cbFirstShotsOnly::Enabled to true
               set cbShCausingRbd::Enabled to true
               move " " to PK330-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.   
       end method.

       method-id cbHideLines protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value checked as type String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           if checked = "true"
               move "Y" to PK330-HIDE-LINES
           else
               move " " to PK330-HIDE-LINES.
       end method.

      ******************************************************************************************

      ************************************ Button Methods **************************************
       method-id btnGo_Click protected.
       local-storage section.
       01 gmDate        type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
               set pk330rununit to self::Session::Item("330rununit")
                   as type RunUnit       
           invoke type System.Single::TryParse(startDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK340-GAME-DATE to gmDate
           invoke type System.Single::TryParse(endDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK340-END-GAME-DATE to gmDate

           IF PK340-PLAYER = " " or PK340-OPPONENT = " "
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & "Please make a Player / Opponent Selection"  & "');", true)
               exit method.

           MOVE "GO" to PK340-ACTION
           invoke pk330rununit::Call("PK340WEBF")
           if ERROR-FOUND = "Y"
               MOVE " " TO ERROR-FOUND
               MOVE " " TO PK340-ACTION
               invoke pk330rununit::Call("PK340WEBF")
           else
               invoke self::Recalc.                 
       end method.

       method-id btnReset_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set resetFlag to "Y"
           move 0 to ddPeriod::SelectedIndex
           set DIALOG-PRD-MASTER to ddPeriod::SelectedItem
           set DIALOG-PRD-IDX to ddPeriod::SelectedIndex
           add 1 to DIALOG-PRD-IDX
           move 0 to ddSituation::SelectedIndex
           set DIALOG-ADV-MASTER to ddSituation::SelectedItem
           set DIALOG-ADV-IDX to ddSituation::SelectedIndex
           add 1 to DIALOG-ADV-IDX
           move 0 to ddScore::SelectedIndex
           set DIALOG-SCR-MASTER to ddScore::SelectedItem
           set DIALOG-SCR-IDX to ddScore::SelectedIndex
           add 1 to DIALOG-SCR-IDX
           move 0 to ddShotType::SelectedIndex
           set DIALOG-SHT-MASTER to ddShotType::SelectedItem
           set DIALOG-SHT-IDX to ddShotType::SelectedIndex
           add 1 to DIALOG-SHT-IDX
           move 0 to ddShotResult::SelectedIndex
           set DIALOG-SHR-MASTER to ddShotType::SelectedItem
           set DIALOG-SHR-IDX to ddShotType::SelectedIndex
           add 1 to DIALOG-SHR-IDX
           set cbFirstShotsOnly::Enabled to true
           set cbReboundShotsOnly::Enabled to true
           set cbFirstShotsOnly::Checked to false
           set cbReboundShotsOnly::Checked to false
           move " " to PK330-RBDS-ONLY-FLAG.
           set resetFlag to "N"
           invoke self::Recalc
       end method.

       method-id btnChancesOK_Click protected.
       local-storage section.
       01 num              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           invoke type System.Single::TryParse(tbChances::Text::ToString, by reference num)
           set PK330-CHANCE-VALUE to num   
           set PK330-CHA-MASTER to ddPctChances::SelectedItem
           set PK330-CHA-IDX to ddPctChances::SelectedIndex
           add 1 to PK330-CHA-IDX
           invoke self::Recalc
       end method.

       method-id btnGoRbd_Click protected.
       local-storage section.
       01 secs              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           invoke type System.Single::TryParse(tbRbdSeconds::Text::ToString, by reference secs)
           set PK330-REBOUND-SECS to secs
           invoke self::Recalc.
       end method.

      ******************************************************************************************

       method-id pk340 protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".
       procedure division.
          if self::Session["pk340data"] = null
               set myData330 to new pucksweb.pk340Data
               invoke myData330::populateData
               set self::Session["pk340data"] to myData330              
           else
               set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data.
          
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           INITIALIZE PK340-DIALOG-FIELDS
           MOVE "IN" TO PK340-ACTION
           invoke pk330rununit::Call("PK340WEBF").
           move "N " to PK340-ACTION
           invoke pk330rununit::Call("PK340WEBF").

           set lblCurrentOpponent::Text to PK340-OPPONENT::Trim
           set lblCurrentPlayer::Text to PK340-PLAYER::Trim

      *radio buttons for Player Location
           if PK340-PLAYER-LOC-FLAG = " "
               SET rbAllLocations::Checked to true
           else if PK340-PLAYER-LOC-FLAG = "H"
               set rbPlayerHome::Checked to true
           else if  PK340-PLAYER-LOC-FLAG = "A"
               set rbPlayerAway::Checked to true.
      *radio buttons for "Games" (Season)
           if PK340-GAME-TYPE-FLAG = "R"
               set rbRegSeason::Checked to true
           else if PK340-GAME-TYPE-FLAG = "N"
               set rbExcludePreSeason::Checked to true
           else if PK340-GAME-TYPE-FLAG = "P"
               set rbPlayoffs::Checked to true
           else if PK340-GAME-TYPE-FLAG = "S"
               set rbPreSeason::Checked to true
           else 
               set PK340-GAME-TYPE-FLAG to "A"
               set rbAllSeasonGames::Checked to true.

      *radio buttons for Start/End dates or 'All' dates
           if PK340-GAME-FLAG = "A"
               SET rbStartAll::Checked to true
           else
               set rbStartDate::Checked to true.
           if PK340-END-GAME-FLAG = "A"
               SET rbEndAll::Checked to true
           else
               set rbEndDate::Checked to true.
           set startDateTextBox::Text to PK340-GAME-DATE::ToString("00/00/00")
           set endDateTextBox::Text to PK340-END-GAME-DATE::ToString("00/00/00")
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
       5-loop.
           read play-file next
               at end go to 10-done.
           move spaces to playerName
           string play-last-name, ", " play-first-name
               delimited "  " into playerName
           if play-pos = "G"
               set nameArray to nameArray & playerName & ";".
           go to 5-loop.
       10-done.
           close play-file.
PM         set self::Session::Item("nameArray") to nameArray       
           move 1 to aa. 
       15-loop.
           if aa > PK340-NUM-TEAMS
               go to 20-done
           else
               invoke ddTeam::Items::Add(PK340-TEAM-NAME(aa))
               invoke ddPlayerTeam::Items::Add(PK340-TEAM-NAME(aa)).
           add 1 to aa
           go to 15-loop.
       20-done.    
           MOVE PK340-PLAYER-TEAM to PK340-SEL-TEAM
           if PK340-SEL-TEAM not = spaces
               set ddPlayerTeam::Text to PK340-SEL-TEAM
               set ddTeam::Text to PK340-SEL-TEAM. 
       end method.

       method-id Recalc protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           move "RE" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           
**********Recalc and Redisplay All Data Fields
           set lblPlayer::Text, lblCurrentPlayer::Text to PK330-PLAYER::Trim
           set lblOpponent::Text, lblCurrentOpponent::Text to PK330-OPPONENT::Trim
           set lblGames::Text to DIALOG-GAME-RANGE::Trim
           set lblLocation::Text to DIALOG-GAME-LOC::Trim 
       
           set lblTopLeft::Text to PK330-NET-TOP-LEFT
           set lblTopCenter::Text to PK330-NET-TOP-CENTER
           set lblTopRight::Text to PK330-NET-TOP-RIGHT
           set lblBotLeft::Text to PK330-NET-BOT-LEFT
           set lblBotCenter::Text to PK330-NET-BOT-CENTER
           SET lblBotRight::Text to PK330-NET-BOT-RIGHT
           set btnOppShots::Text to PK330-O-SHOTS
           set btnOppOnGoal::Text to PK330-O-ON-GOAL
           set btnOppSavePct::Text to PK330-SAVE-PCT
           set btnOppGoals::Text to PK330-O-GOALS
           set btnOppExpSvPct::Text to PK330-EXP-SAVE-PCT
           set btnOppRbd::Text to PK330-O-REBOUNDS
           set btnOppRbdPct::Text to PK330-REBOUND-PCT
           set btnOppRbdG::Text to PK330-O-REBOUND-GOALS
           set btnOppRbdGPct::Text to PK330-REBOUND-GOAL-PCT
           set lblGoalieGames::Text to PK330-T-G
               
       end method.

      * #### One Click Dates ####
       method-id SetGameDates private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".
       procedure division using by value dateChoiceFlag as String
                          returning startEndDates as String.
                          
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
               set pk330rununit to self::Session::Item("330rununit")
                   as type RunUnit           
           if dateChoiceFlag = "A"
               MOVE "A" to PK340-DATE-CHOICE-FLAG
               MOVE "A" to PK340-GAME-FLAG
               MOVE "A" to PK340-END-GAME-FLAG
               set startEndDates to "ALL"
           else
               MOVE dateChoiceFlag to PK340-DATE-CHOICE-FLAG
               MOVE "DC" to PK340-ACTION
               invoke pk330rununit::Call("PK340WEBF")
               MOVE "D" to PK340-GAME-FLAG
               MOVE "D" to PK340-END-GAME-FLAG
               if ERROR-FIELD NOT = SPACES
                   set startEndDates to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if    
               set startEndDates to PK340-GAME-DATE::ToString("##/##/##") & ";" & PK340-END-GAME-DATE::ToString("##/##/##").
       end method.
       
      * ######################## 
      * #### Player Selection ####
      * ######################## 
        
      * ########################
      * #### Team Selection ####
      * ########################   
       method-id btnPlayerTeamOK_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           
           set PK340-PLAYER-TEAM, PK340-PLAYER to teamName  

           MOVE "T" to PK340-PLAYER-FLAG
           move PK340-PLAYER-TEAM to PK340-PLAYER.
      *    Called on client side: 
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
      *    set pitcherTextBox::Text to PK340-PITCHER
           
           set playerTeam to PK340-PLAYER::Trim
           
       end method.
       
       method-id btnOppTeamOK_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           
           set PK340-OPPONENT-TEAM, PK340-OPPONENT to teamName 
               
           MOVE "T" to PK340-OPPONENT-FLAG
           MOVE PK340-OPPONENT-TEAM to PK340-OPPONENT
      * Called Client-Side    
      *    SET batterSelectionTextBox::Text to PK340-BATTER::Trim
      *    set batterTextBox::Text to PK340-BATTER
      *    invoke bHiddenFieldTeam_ModalPopupExtender::Hide
            
           set playerTeam to PK340-OPPONENT::Trim
       end method.
       
       method-id btnOppAll_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "A" to PK340-OPPONENT-FLAG
           MOVE "ALL" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnEastConf_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "1" to PK340-OPPONENT-FLAG
           MOVE "EASTERN CONF" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnEastAtl_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "2" to PK340-OPPONENT-FLAG
           MOVE "EASTERN ATL" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnEastMetro_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "3" to PK340-OPPONENT-FLAG
           MOVE "EASTERN MET" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnWestConf_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "4" to PK340-OPPONENT-FLAG
           MOVE "WESTERN CONF" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnWestCent_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "5" to PK340-OPPONENT-FLAG
           MOVE "WESTERN CENT" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnWestPac_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning oppSelection as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           
           MOVE "6" to PK340-OPPONENT-FLAG
           MOVE "WESTERN PAC" to PK340-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK340-PITCHER::Trim
           
           set oppSelection to PK340-OPPONENT::Trim
       end method.

       method-id btnSelectPlayer_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division returning returnVal as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
           MOVE "I" to PK340-PLAYER-FLAG
           MOVE "RB" to PK340-ACTION
           
           invoke pk330rununit::Call("PK340WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD.              
           
      * Called Client-Side    
      *    set teamList to self::populateTeamAsync(selectedTeam)     
      *    invoke ipHiddenField_ModalPopupExtender::Show
       end method.    

       method-id btnSelectPlayerOK_Click protected.
       local-storage section.
       01 selectedPlayer type String.
       01 selectionType type String.
       01 selIndex type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk340_dg.CPB".  
       procedure division using by value selectedPlayerInfo as String 
                          returning playerName as String.
           set myData330 to self::Session["pk340data"] as type pucksweb.pk340Data
           set address of PK340-DIALOG-FIELDS to myData330::tablePointer
           set pk330rununit to self::Session::Item("330rununit") as
               type RunUnit
         
           unstring selectedPlayerInfo delimited ";" into selectionType, selectedPlayer
           
               
           if selectionType = "located"
      *        Player is selected using autofill textbox
               CALL "PKFIL2" USING LK-FILE-NAMES, WS-NETWORK-FLAG
      *        CALL "PKNTWK2" USING LK-FILE-NAMES
               MOVE SPACES TO PLAY-ALT-KEY1
               unstring selectedPlayer delimited ", " into play-last-name, play-first-name
               open input play-file
               if status-byte-1 not = zeroes
                   set play-player-id to 4
               end-if
               READ PLAY-FILE KEY PLAY-ALT-KEY1
               set PK340-SEL-PLAYER to play-first-name::Trim & " " & play-last-name::Trim 
               MOVE play-player-id to PK340-LOCATE-SEL-ID
               CLOSE PLAY-FILE
               move "LP" to PK340-ACTION
               invoke pk330rununit::Call("PK340WEBF")
               move PK340-LOCATE-SEL-ID to PK340-SAVE-PLAYER-ID           
               move "TI" to PK340-ACTION
               invoke pk330rununit::Call("PK340WEBF")
               if ERROR-FIELD NOT = SPACES
                   set playerName to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
                   exit method
               END-IF    
           else 
      *        Player is selected using list box   
               invoke type System.Single::TryParse(selectedPlayer::Substring(0, selectedPlayer::IndexOf(",")), by reference selIndex)
               MOVE PK340-ROSTER-NAME(selIndex) TO PK340-SEL-PLAYER
               MOVE PK340-ROSTER-ID(selIndex) TO PK340-SAVE-PLAYER-ID.
           
           move PK340-SEL-PLAYER to PK340-PLAYER 
           
           set playerName to PK340-PLAYER
       end method.  
   
       method-id btnPlayAll_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk330_dg.CPB".  
       procedure division returning returnVal as String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           move "VA" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           invoke self::batstube
       end method.  
   
       method-id playField protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk330_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK330-FIELD-IP to num
           move "VF" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           invoke self::batstube
           if PK330-WF-VID-COUNT = 0
               set returnVal to "er|" & "No video clips found"
               exit method
       end method.  

       method-id playNet protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using netLoc as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           if netLoc = 'top-left'
               move 1 to PK330-NET-M-IN-X
               move 1 to PK330-NET-M-IN-Y
               move 1 to PK330-NET-M-OUT-X
               move 1 to PK330-NET-M-OUT-Y
           else
           if netLoc = 'top-center'
               move 2 to PK330-NET-M-IN-X
               move 1 to PK330-NET-M-IN-Y
               move 2 to PK330-NET-M-OUT-X
               move 1 to PK330-NET-M-OUT-Y
           else
           if netLoc = 'top-right'
               move 3 to PK330-NET-M-IN-X
               move 1 to PK330-NET-M-IN-Y
               move 3 to PK330-NET-M-OUT-X
               move 1 to PK330-NET-M-OUT-Y
           else
           if netLoc = 'bottom-left'
               move 1 to PK330-NET-M-IN-X
               move 2 to PK330-NET-M-IN-Y
               move 1 to PK330-NET-M-OUT-X
               move 2 to PK330-NET-M-OUT-Y
           else
           if netLoc = 'bottom-center'
               move 2 to PK330-NET-M-IN-X
               move 2 to PK330-NET-M-IN-Y
               move 2 to PK330-NET-M-OUT-X
               move 2 to PK330-NET-M-OUT-Y
           else
           if netLoc = 'bottom-right'
               move 3 to PK330-NET-M-IN-X
               move 2 to PK330-NET-M-IN-Y
               move 3 to PK330-NET-M-OUT-X
               move 2 to PK330-NET-M-OUT-Y.
           move "VN" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK330-WF-VID-COUNT = 0
               set returnVal to "er|" & "No clip at that location"
               exit method.
           invoke self::batstube.
       end method.

       method-id playRink protected.
       local-storage section.
       01 iNum         type Int16.
       01 vals     type String occurs 4.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set vals to xyVal::Split(",")
           invoke type Int16::TryParse(vals[0], iNum)
           set MOUSEX to iNum          
           invoke type Int16::TryParse(vals[1], iNum)
           set MOUSEY to iNum
           invoke type Int16::TryParse(vals[2], iNum)
           set MOUSEX2 to iNum + MOUSEX         
           invoke type Int16::TryParse(vals[3], iNum)
           set MOUSEY2 to iNum + MOUSEY
           MOVE MOUSEX TO PK330-RINK-M-IN-X
           MOVE MOUSEX2 TO PK330-RINK-M-OUT-X
           MOVE MOUSEY TO PK330-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK330-RINK-M-OUT-Y
           IF MOUSEX = MOUSEX2 AND MOUSEY = MOUSEY2
               SUBTRACT 3 FROM PK330-RINK-M-IN-X
               SUBTRACT 3 FROM PK330-RINK-M-IN-Y
               ADD 3 TO PK330-RINK-M-OUT-X
               ADD 3 TO PK330-RINK-M-OUT-Y.
           move "R4" to PK330-ACTION
           invoke pk330rununit::Call("PK330WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK330-WF-VID-COUNT = 0
               set returnVal to "er|" & "No clip at that location"
               exit method.

           invoke self::batstube.
           set returnVal to "play"
           
       end method.

       method-id storeRink protected.
       local-storage section.
       01 iNum         type Int16.
       01 vals     type String occurs 4.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set pk330rununit to self::Session::Item("330rununit")
               as type RunUnit
           set vals to xyVal::Split(",")
           invoke type Int16::TryParse(vals[0], iNum)
           set MOUSEX to iNum          
           invoke type Int16::TryParse(vals[1], iNum)
           set MOUSEY to iNum
           invoke type Int16::TryParse(vals[2], iNum)
           set MOUSEX2 to iNum + MOUSEX         
           invoke type Int16::TryParse(vals[3], iNum)
           set MOUSEY2 to iNum + MOUSEY
           MOVE MOUSEX TO PK330-RINK-M-IN-X
           MOVE MOUSEX2 TO PK330-RINK-M-OUT-X
           MOVE MOUSEY TO PK330-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK330-RINK-M-OUT-Y
       end method.

       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > PK330-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & PK330-WF-VIDEO-PATH(aa)::Trim & "#t=" &  PK330-WF-VIDEO-START(AA) & "," & 
               (PK330-WF-VIDEO-START(AA) + PK330-WF-VIDEO-DURATION(AA)) & ";"
PM    *     set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-A(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
      *         (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM         set vidTitles to vidTitles & PK330-WF-VIDEO-TITL(aa) & ";"
           
           if PK330-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & PK330-WF-VIDEO-PATH(aa) & PK330-WF-VIDEO-B(aa) & "#t=" &  PK330-WF-VIDEO-START(AA) & "," & 
               (PK330-WF-VIDEO-START(AA) + PK330-WF-VIDEO-DURATION(AA)) & ";"
               set vidTitles to vidTitles & "B;".
           if PK330-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & PK330-WF-VIDEO-PATH(aa) & PK330-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if PK330-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & PK330-WF-VIDEO-PATH(aa) & PK330-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.
       end class.
