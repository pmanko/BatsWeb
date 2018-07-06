       class-id pucksweb.playerBreakdown is partial 
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
       01 pk310rununit         type RunUnit.
       01 PK310WEBF                type PK310WEBF.
       01 mydata type pucksweb.pk310Data.
       01 mydata300 type pucksweb.pk300Data.
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
           COPY "Y:\sydexsource\PUCKS\PK310_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
           if self::IsPostBack
               invoke self::loadLines
               exit method.

      *    Setup - from main menu                
           SET self::Session::Item("database") to self::Request::QueryString["league"]
           if   self::Session["pk310data"] = null
              set mydata to new pucksweb.pk310Data
              invoke mydata::populateData
              set self::Session["pk310data"] to mydata
           else
               set mydata to self::Session["pk310data"] as type pucksweb.pk310Data.

           if  self::Session::Item("310rununit") not = null
               set pk310rununit to self::Session::Item("310rununit")
                   as type RunUnit
                ELSE
                set pk310rununit to type RunUnit::New()
                set PK310WEBF to new PK310WEBF
                invoke pk310rununit::Add(PK310WEBF)
                set self::Session::Item("310rununit") to pk310rununit.
           
           set address of PK310-DIALOG-FIELDS to myData::tablePointer
           move "I" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")

       invoke ddPeriod::Items::Clear.
       invoke ddSituation::Items::Clear.
       invoke ddScore::Items::Clear.
       invoke ddNHLEvent::Items::Clear.
       invoke ddCustomEvent::Items::Clear.
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
       nhlevent-loop.
           if aa > DIALOG-EVT-NUM-ENTRIES
               go to nhlevent-done.
           invoke ddNHLEvent::Items::Add(DIALOG-EVT(AA)::Trim)
           add 1 to aa
           go to nhlevent-loop.
       nhlevent-done.
             
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
           if ddCustomEvent::Items::Count not = 0
               set ddCustomEvent::SelectedIndex to 0.
           set ddNHLEvent::SelectedIndex to 0
           set ddPctChances::SelectedIndex to 0
           set ddPeriod::SelectedIndex to 0
           set ddScore::SelectedIndex to 0
           set ddShotResult::SelectedIndex to 0
           set ddShotType::SelectedIndex to 0
           set ddSituation::SelectedIndex to 0
           move 1 to SH-PK300-FLAG
           move "Y" to PK310-BYPASS-FLAG
           move "FD" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if PK310-BYPASS-FLAG not = "Y"
               invoke self::Recalc.

           invoke self::pk300.
      *pk300 stuff
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
           else if actionFlag = 'shot-loc'
               set callbackReturn to actionFlag & "|" & self::shotLocations(methodArg)
           else if actionFlag = "play-rink"
               set callbackReturn to actionFlag & "|" & self::playRink(methodArg)
           else if actionFlag = "store-rink"
               set callbackReturn to actionFlag & "|" & self::storeRink(methodArg)
           else if actionFlag = "play-full"
               set callbackReturn to actionFlag & "|" & self::btnPlayAll_Click()
           else if actionFlag = "play-field"
               set callbackReturn to actionFlag & "|" & self::playField(methodArg)
           else if actionFlag = 'update-play'
               set callbackReturn to actionFlag & "|" & self::playSelected(methodArg)
           else if actionFlag = "update-play-dblclick"
               set callbackReturn to actionFlag & "|" & self::playSelected(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################

      ****************************** Radio Button Methods **************************************
       method-id rbStartAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbStartAll::Checked
               MOVE "A" to PK300-GAME-FLAG.
       end method.

       method-id rbStartDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbStartDate::Checked
               MOVE "D" to PK300-GAME-FLAG.
       end method.

       method-id rbEndAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbEndAll::Checked
               MOVE "A" to PK300-END-GAME-FLAG.
       end method.

       method-id rbEndDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbEndDate::Checked
               MOVE "D" to PK300-END-GAME-FLAG.
       end method.

       method-id rbAllGames_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbAllSeasonGames::Checked
               MOVE "A" to PK300-GAME-TYPE-FLAG.
       end method.

       method-id rbPreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbPreSeason::Checked
               MOVE "S" to PK300-GAME-TYPE-FLAG.
       end method.

       method-id rbRegularSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbRegSeason::Checked
               MOVE "R" to PK300-GAME-TYPE-FLAG.
       end method.

       method-id rbExcludePreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbExcludePreSeason::Checked
               MOVE "N" to PK300-GAME-TYPE-FLAG.
       end method.

       method-id rbPlayoffs_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbPlayoffs::Checked
               MOVE "P" to PK300-GAME-TYPE-FLAG.
       end method.

       method-id rbAllLocations_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbAllLocations::Checked
               MOVE " " to PK300-PLAYER-LOC-FLAG.
       end method.

       method-id rbHome_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbPlayerHome::Checked
               MOVE "H" to PK300-PLAYER-LOC-FLAG.
       end method.

       method-id rbAway_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbPlayerAway::Checked
               MOVE "A" to PK300-PLAYER-LOC-FLAG.
       end method.

       method-id rbCheckToi_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbChkTOI::Checked
                MOVE "T" to PK300-TIME-ON-ICE-FLAG.
       end method.

       method-id rbCheckName_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbChkPlayerName::Checked
               MOVE "A" to PK300-TIME-ON-ICE-FLAG.
       end method.

       method-id rbShowOld_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbOldToNew::Checked
               MOVE "O" to PK300-GAME-SHOW-FLAG.
       end method.

       method-id rbShowNew_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           if rbNewToOld::Checked
               MOVE "N" to PK300-GAME-SHOW-FLAG.
       end method.

       method-id rbFOAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if rbFOAll::Checked = true
               move " " to PK310-FACEOFF-WINNER-FLAG
               if resetFlag not = "Y"
                   INVOKE self::Recalc.   
       end method.

       method-id rbFOTeam_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if rbFOTeam::Checked = true
               move "T" to PK310-FACEOFF-WINNER-FLAG
               if resetFlag not = "Y"
                   INVOKE self::Recalc.   
       end method.

       method-id rbFOOpp_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if rbFOOpp::Checked = true
               move "O" to PK310-FACEOFF-WINNER-FLAG
               if resetFlag not = "Y"
                   INVOKE self::Recalc.     
       end method.

       method-id rbAllEvents_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
            if rbAllEvents::Checked = true
               move "A" to PK310-ADVANCED-TYPE.
       end method.

       method-id rbNhlOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
            if rbNHLOnly::Checked = true
               move "N" to PK310-ADVANCED-TYPE.     
       end method.

       method-id rbCustomOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
            if rbCustomOnly::Checked = true
               move "C" to PK310-ADVANCED-TYPE.    
       end method.

       method-id rbGreaterOrEq_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           if rbGreaterOrEq::Checked = true
               move "M" to PK310-CHANCE-FLAG
       end method.
       
       method-id rbLess_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           if rbLess::Checked = true
               move "L" to PK310-CHANCE-FLAG
       end method.
      ******************************************************************************************

      ********************************** DropDown Methods **************************************

       method-id ddPeriod_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-PRD-MASTER to ddPeriod::SelectedItem
           set DIALOG-PRD-IDX to ddPeriod::SelectedIndex
           add 1 to DIALOG-PRD-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddNhlEvent_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-EVT-MASTER to ddNHLEvent::SelectedItem
           set DIALOG-EVT-IDX to ddNHLEvent::SelectedIndex
           add 1 to DIALOG-EVT-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddCustomEvent_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-CUSTOM-MASTER to ddCustomEvent::SelectedItem
           set DIALOG-CUSTOM-IDX to ddCustomEvent::SelectedIndex
           add 1 to DIALOG-CUSTOM-IDX
           if resetFlag not = "Y"
               invoke self::Recalc.   
       end method.

       method-id ddScore_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
               set PK310-CHA-MASTER to ddPctChances::SelectedItem
               set PK310-CHA-IDX to ddPctChances::SelectedIndex
               add 1 to PK310-CHA-IDX
               if resetFlag not = "Y"
                   invoke self::Recalc.
       end method.

       method-id ddPlayerTeam private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value selectedTeam as String
                          returning teamList as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
               set pk310rununit to self::Session::Item("310rununit")
                   as type RunUnit       
           set PK300-SEL-TEAM to selectedTeam 
           move PK300-SEL-TEAM to PK300-PLAYER-TEAM
           MOVE "RP" TO PK300-ACTION 
           invoke pk310rununit::Call("PK300WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.              
           set teamList to ""

           move 1 to aa.
       5-loop.
           if aa > PK300-NUM-PLAYERS
               go to 10-done
           else
               set teamList to teamList & (" " & PK300-ROSTER-NAME(aa) & " " & PK300-ROSTER-POS(aa)) & ";".
      *         set teamList to teamList & aa & "," & (" " & PK300-ROSTER-NAME(aa) & " " & PK300-ROSTER-POS(aa)) & ";".
           add 1 to aa.
           go to 5-loop.
       10-done.
           move 1 to aa.

       end method.
      ******************************************************************************************

      ********************************** Checkbox Methods **************************************

       method-id cbFirstShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if cbFirstShotsOnly::Checked = true
               set cbReboundShotsOnly::Enabled to false
               move "1" to PK310-RBDS-ONLY-FLAG
           else  
               set cbReboundShotsOnly::Enabled to true
               move " " to PK310-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.     
       end method.

       method-id cbReboundShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if cbReboundShotsOnly::Checked = true
               set cbFirstShotsOnly::Enabled to false
               move "Y" to PK310-RBDS-ONLY-FLAG
           else  
               set cbFirstShotsOnly::Enabled to true
               move " " to PK310-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.   
       end method.

       method-id cbUseDuration_CheckedChanged protected.
       local-storage section.
       01 num          type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if cbUseDuration::Checked
               invoke type System.Single::TryParse(tbDuration::Text::ToString, by reference num)
               set PK310-PLAY-DURATION to num
               move "Y" to PK310-USE-DUR-FLAG
               set ddShotResult::Enabled to false
               set ddShotType::Enabled to false
               set ddPctChances::Enabled to false              
           else
               move " " to PK310-USE-DUR-FLAG
               set ddShotResult::Enabled to true
               set ddShotType::Enabled to true
               set ddPctChances::Enabled to true                 
               if resetFlag not = "Y"
                   INVOKE self::Recalc.     
       
      *  coded for reset button don't want to wipe flag         
           if resetFlag not = "Y"
               set resetFlag to "Y"
               move 0 to ddScore::SelectedIndex
               move 0 to ddShotType::SelectedIndex
               move 0 to ddShotResult::SelectedIndex
               set resetFlag to "N" 
           else
               move 0 to ddScore::SelectedIndex
               move 0 to ddShotType::SelectedIndex
               move 0 to ddShotResult::SelectedIndex.     
       end method.

       method-id cbLeft_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if cbLeft::Checked = true
               set cbRight::Enabled to false
               move "L" to PK310-HAND-FLAG
           else    
               set cbRight::Enabled to true
               move " " to PK310-HAND-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.
       end method.

       method-id cbRight_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if cbRight::Checked = true
               set cbLeft::Enabled to false
               move "R" to PK310-HAND-FLAG
           else    
               set cbLeft::Enabled to true
               move " " to PK310-HAND-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.   
       end method.

      ******************************************************************************************

      ************************************ Button Methods **************************************
       method-id btnGo_Click protected.
       local-storage section.
       01 gmDate        type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
               set pk310rununit to self::Session::Item("310rununit")
                   as type RunUnit       
           invoke type System.Single::TryParse(startDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK300-GAME-DATE to gmDate
           invoke type System.Single::TryParse(endDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK300-END-GAME-DATE to gmDate

           IF PK300-PLAYER = " " or PK300-OPPONENT = " "
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & "Please make a Player / Opponent Selection"  & "');", true)
               exit method.

           MOVE "GO" to PK300-ACTION
           invoke pk310rununit::Call("PK300WEBF")
           if ERROR-FOUND = "Y"
               MOVE " " TO ERROR-FOUND
               MOVE " " TO PK300-ACTION
               invoke pk310rununit::Call("PK300WEBF")
           else
               invoke self::Recalc.                 
       end method.

       method-id btnReset_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set resetFlag to "Y"
           MOVE " " to PK310-ADVANCED-DESC
           move " " to PK310-ADVANCED-DESC2
           move " " to PK310-ADVANCED-INIT           
           move 0 to ddPeriod::SelectedIndex
           set DIALOG-PRD-MASTER to ddPeriod::SelectedItem
           set DIALOG-PRD-IDX to ddPeriod::SelectedIndex
           add 1 to DIALOG-PRD-IDX
           move 0 to ddNHLEvent::SelectedIndex
           set DIALOG-EVT-MASTER to ddNHLEvent::SelectedItem
           set DIALOG-EVT-IDX to ddNHLEvent::SelectedIndex
           add 1 to DIALOG-EVT-IDX
           move 0 to ddCustomEvent::SelectedIndex
           set DIALOG-CUSTOM-MASTER to ddCustomEvent::SelectedItem
           set DIALOG-CUSTOM-IDX to ddCustomEvent::SelectedIndex
           add 1 to DIALOG-CUSTOM-IDX
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
           move " " to PK310-RBDS-ONLY-FLAG.
           set cbUseDuration::Checked to false
           move " " to PK310-USE-DUR-FLAG
           set cbLeft::Enabled to true
           set cbRight::Enabled to true
           set cbLeft::Checked to false
           set cbRight::Checked to false
           move " " to PK310-HAND-FLAG.
           set rbFOAll::Checked to true
           move " " to PK310-FACEOFF-WINNER-FLAG
           set resetFlag to "N"
           invoke self::Recalc
       end method.

       method-id btnGoDuration_Click protected.
       local-storage section.
       01 num              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke type System.Single::TryParse(tbDuration::Text::ToString, by reference num)
           set PK310-PLAY-DURATION to num           
           invoke self::Recalc
       end method.

       method-id btnOK_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set PK310-ADVANCED-INIT to tbAuthor::Text::ToUpper
           set PK310-ADVANCED-DESC to tbNote1::Text::ToUpper
           set PK310-ADVANCED-DESC2 to tbNote2::Text::ToUpper
           move "CA" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.  
           invoke self::Recalc
       end method.

       method-id btnChancesOK_Click protected.
       local-storage section.
       01 num              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           invoke type System.Single::TryParse(tbChances::Text::ToString, by reference num)
           set PK310-CHANCE-VALUE to num   
           set PK310-CHA-MASTER to ddPctChances::SelectedItem
           set PK310-CHA-IDX to ddPctChances::SelectedIndex
           add 1 to PK310-CHA-IDX
           invoke self::Recalc
       end method.

      ******************************************************************************************

       method-id pk300 protected.
       local-storage section.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".
       procedure division.
          if self::Session["pk300data"] = null
               set mydata300 to new pucksweb.pk300Data
               invoke mydata300::populateData
               set self::Session["pk300data"] to mydata300              
           else
               set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data.
          
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           INITIALIZE PK300-DIALOG-FIELDS
           MOVE "IN" TO PK300-ACTION
           invoke pk310rununit::Call("PK300WEBF").
           move "N " to PK300-ACTION
           invoke pk310rununit::Call("PK300WEBF").

           set lblCurrentOpponent::Text to PK300-OPPONENT::Trim
           set lblCurrentPlayer::Text to PK300-PLAYER::Trim

      *radio buttons for Player Location
           if PK300-PLAYER-LOC-FLAG = " "
               SET rbAllLocations::Checked to true
           else if PK300-PLAYER-LOC-FLAG = "H"
               set rbPlayerHome::Checked to true
           else if  PK300-PLAYER-LOC-FLAG = "A"
               set rbPlayerAway::Checked to true.
      *radio buttons for "Games" (Season)
           if PK300-GAME-TYPE-FLAG = "A"
               set rbAllSeasonGames::Checked to true
           else if PK300-GAME-TYPE-FLAG = "R"
               set rbRegSeason::Checked to true
           else if PK300-GAME-TYPE-FLAG = "N"
               set rbExcludePreSeason::Checked to true
           else if PK300-GAME-TYPE-FLAG = "P"
               set rbPlayoffs::Checked to true
           else if PK300-GAME-TYPE-FLAG = "S"
               set rbPreSeason::Checked to true.

      *radio buttons for "Other Sort Options"
           if PK300-TIME-ON-ICE-FLAG = "T" or PK300-TIME-ON-ICE-FLAG = " "
               set PK300-TIME-ON-ICE-FLAG TO "T"
               set rbChkTOI::Checked to true
           else if PK300-TIME-ON-ICE-FLAG = "A"
               set rbChkPlayerName::Checked to true.
          if PK300-GAME-SHOW-FLAG = "O"
               set rbOldToNew::Checked to true
           else
               set PK300-GAME-SHOW-FLAG to "N"
               set rbNewToOld::Checked to true.

      *radio buttons for Start/End dates or 'All' dates
           if PK300-GAME-FLAG = "D"
               set rbStartDate::Checked to true
           else
               set PK300-GAME-FLAG to "A"
               SET rbStartAll::Checked to true.
           if PK300-END-GAME-FLAG = "D"
               set rbEndDate::Checked to true
           else
               set PK300-END-GAME-FLAG to "A"
               SET rbEndAll::Checked to true.
           set startDateTextBox::Text to PK300-GAME-DATE::ToString("00/00/00")
           set endDateTextBox::Text to PK300-END-GAME-DATE::ToString("00/00/00")
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
      *    if not type File::Exists("c:\pucks99\pkplayer2.dat")
      *        go to 10-done.
           open input play-file.
      *     initialize play-alt-key1
      *     start play-file key > play-alt-key1.
       5-loop.
           read play-file next
               at end go to 10-done.
           move spaces to playerName
           string play-last-name, ", " play-first-name
               delimited "  " into playerName
           set nameArray to nameArray & playerName & ";"
           add 1 to aa
           go to 5-loop.
       10-done.
           close play-file.
PM         set self::Session::Item("nameArray") to nameArray       
           move 1 to aa. 
       15-loop.
           if aa > PK300-NUM-TEAMS
               go to 20-done
           else
               invoke ddTeam::Items::Add(PK300-TEAM-NAME(aa)).
               invoke ddPlayerTeam::Items::Add(PK300-TEAM-NAME(aa)).
           add 1 to aa
           go to 15-loop.
       20-done.    
           MOVE PK300-PLAYER-TEAM to PK300-SEL-TEAM
           if PK300-SEL-TEAM not = spaces
               set ddPlayerTeam::Text to PK300-SEL-TEAM
               set ddTeam::Text to PK300-SEL-TEAM. 
       end method.

       method-id Recalc protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move "RE" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           
**********Recalc and Redisplay All Data Fields
           set lblPlayer::Text, lblCurrentPlayer::Text to PK310-PLAYER::Trim
           set lblOpponent::Text, lblCurrentOpponent::Text to PK310-OPPONENT::Trim
           set lblGames::Text to DIALOG-GAME-RANGE::Trim
           set lblLocation::Text to DIALOG-GAME-LOC::Trim 
       
           set btnTeamShots::Text to PK310-T-SHOTS
           set btnTeamMisses::Text to PK310-T-SHOTS-MISSED
           set btnTeamBlocked::Text to PK310-T-SHOTS-BLOCKED
           set btnTeamOnGoal::Text to PK310-T-SHOTS-ON-GOAL
           set btnTeamGoals::Text to PK310-T-GOALS
           set btnTeamRbds::Text to PK310-T-REBOUNDS
           set btnTeamTakes::Text to PK310-T-TAKES
           set btnTeamGives::Text to PK310-T-GIVES
           set btnTeamHits::Text to PK310-T-HITS
           set btnTeamPens::Text to PK310-T-PENS
           set btnTeamPenMin::Text to PK310-T-PEN-MINUTES
           set btnTeamRbdGoals::Text to PK310-T-REBOUND-GOALS
           set btnTeamFOTotW::Text to PK310-T-FO-WON
           set btnTeamFODefW::Text to PK310-T-FO-WON-DEF
           set btnTeamFONeuW::Text to PK310-T-FO-WON-NEU
           set btnTeamFOOffW::Text to PK310-T-FO-WON-OFF
           set btnTeamFOTotL::Text to PK310-T-FO-LOSS
           set btnTeamFODefL::Text to PK310-T-FO-LOSS-DEF
           set btnTeamFONeuL::Text to PK310-T-FO-LOSS-NEU
           set btnTeamFOOffL::Text to PK310-T-FO-LOSS-OFF
           set lblTeamFOPct::Text to PK310-T-FACEOFF-PCT

           set btnPlShots::Text to PK310-I-SHOTS
           set btnPlMisses::Text to PK310-I-SHOTS-MISSED
           set btnPlBlocks::Text to PK310-I-SHOTS-BLOCKED
           set btnPlOnGoal::Text to PK310-I-SHOTS-ON-GOAL
           set btnPlGoals::Text to PK310-I-GOALS
           set btnPlRbds::Text to PK310-I-REBOUNDS
           set btnPlRbdGoals::Text to PK310-I-REBOUND-GOALS
           set btnPlTakes::Text to PK310-I-TAKES
           set btnPlGives::Text to PK310-I-GIVES
           set btnPlHits::Text to PK310-I-HITS
           set btnPlPens::Text to PK310-I-PENS
           set btnPlPenMin::Text to PK310-I-PENS-MINUTES
           set btnPlPenDr::Text to PK310-I-PENS-CAUSED
           set btnPlPenDrMin::Text to PK310-I-PENS-DR-MINS
           set btnPlPenDiff::Text to PK310-I-PENS-DIFF
           set btnPlAss1::Text to PK310-I-ASSIST1
           set btnPlAss2::Text to PK310-I-ASSIST2
           set btnPlFOTotW::Text to PK310-I-FO-WON
           set btnPlFODefW::Text to PK310-I-FO-WON-DEF
           set btnPlFONeuW::Text to PK310-I-FO-WON-NEU
           set btnPlFOOffW::Text to PK310-I-FO-WON-OFF
           set btnPlFOTotL::Text to PK310-I-FO-LOSS
           set btnPlFODefL::Text to PK310-I-FO-LOSS-DEF
           set btnPlFONeuL::Text to PK310-I-FO-LOSS-NEU
           set btnPlFOOffL::Text to PK310-I-FO-LOSS-OFF
           set lblPlFOPct::Text to PK310-I-FACEOFF-PCT

           set btnOppShots::Text to PK310-O-SHOTS
           set btnOppMisses::Text to PK310-O-SHOTS-MISSED
           set btnOppBlocked::Text to PK310-O-SHOTS-BLOCKED
           set btnOppOnGoal::Text to PK310-O-SHOTS-ON-GOAL
           set btnOppGoals::Text to PK310-O-GOALS
           set btnOppRbds::Text to PK310-O-REBOUNDS
           set btnOppTakes::Text to PK310-O-TAKES
           set btnOppGives::Text to PK310-O-GIVES
           set btnOppHits::Text to PK310-O-HITS
           set btnOppPens::Text to PK310-O-PENS
           set btnOppPenMin::Text to PK310-O-PEN-MINUTES
           set btnOppRbdGoals::Text to PK310-O-REBOUND-GOALS
               
           set lblGP::Text to PK310-T-G
           set lblTotMins::Text to PK310-DISPLAY-MINUTES & ":" & PK310-DISPLAY-SECONDS::ToString("00")
           set lblMinPerGame::Text to PK310-AVG-GAME-MINUTES & ":" & PK310-AVG-GAME-SECONDS::ToString("00")
           
           set lblTeamSVShots::Text to PK310-T-SHOTS
           set lblTeamSVValue::Text to PK310-T-SH-VALUE
           set lblTeamSVExp::Text to PK310-T-NHL-ALL-VALUE
           set lblTeamSVDiff::Text to PK310-T-NHL-ALL-PCT
           set lblTeamSVRbds::Text to PK310-T-REBOUNDS
           set lblTeamSVRbdValue::Text to PK310-T-REB-VALUE
           set lblTeamSVRbdExp::Text to PK310-T-NHL-RBD-VALUE
           set lblTeamSVRbdDiff::Text to PK310-T-NHL-RBD-PCT
           set lblTeamSVGoals::Text to PK310-T-NON-EMPTY-GOALS
           set lblTeamSVGoalsExp::Text to PK310-T-EXP-GOALS
           set lblTeamSVGoalsDiff::Text to PK310-T-GOAL-DIF::ToString("+#;-#;0")
           set lblTeamSVOnGoal::Text to PK310-T-GOAL-SH-DIFF
           set lblTeamSVOnGoalDiff::Text to PK310-T-SHOOT-GOAL-DIFF::ToString("+#;-#;0")
           set lblTeamSVBlocked::Text to PK310-T-BL-SHOTS-PCT
           set lblTeamSVBlockedDiff::Text to PK310-T-BL-GOAL-DIFF::ToString("+#;-#;0")
           set lblTeamSVMissed::Text to PK310-T-MISS-SHOTS-PCT
           set lblTeamSVMissedDiff::Text to PK310-T-MISS-GOAL-DIFF::ToString("+#;-#;0")
           set lblTeamSVRbdGoals::Text to PK310-T-REBOUND-GOALS
           set lblTeamSVEmpty::Text TO PK310-T-EMPTY-NET    

           set lblPlSVShots::Text to PK310-I-SHOTS
           set lblPlSVValue::Text to PK310-I-SH-VALUE
           set lblPlSVRbds::Text to PK310-I-REBOUNDS
           set lblPlSVRbdValue::Text to PK310-I-REB-VALUE
           set lblPlSVGoals::Text to PK310-I-NON-EMPTY-GOALS
           set lblPlSVGoalExp::Text to PK310-I-EXP-GOALS
           set lblPlSVGoalDiff::Text to PK310-I-GOAL-DIF::ToString("+#;-#;0")
           set lblPlSVOnGoal::Text to PK310-I-GOAL-SH-DIFF
           set lblPlSVOnGoalDiff::Text to PK310-I-SHOOT-GOAL-DIFF::ToString("+#;-#;0")
           set lblPlSVBlocked::Text to PK310-I-BL-SHOTS-PCT
           set lblPlSVBlockedDiff::Text to PK310-I-BL-GOAL-DIFF::ToString("+#;-#;0")
           set lblPlSVMissed::Text to PK310-I-MISS-SHOTS-PCT
           set lblPlSVMissedDiff::Text to PK310-I-MISS-GOAL-DIFF::ToString("+#;-#;0")
           set lblPlSVRbdGoals::Text to PK310-I-REBOUND-GOALS
           set lblPlSVEmpty::Text TO PK310-I-EMPTY-NET
           
           set lblOppSVShots::Text to PK310-O-SHOTS
           set lblOppSVValue::Text to PK310-O-SH-VALUE
           set lblOppSVExp::Text to PK310-O-NHL-ALL-VALUE
           set lblOppSVDiff::Text to PK310-O-NHL-ALL-PCT
           set lblOppSVRbds::Text to PK310-O-REBOUNDS
           set lblOppSVRbdValue::Text to PK310-O-REB-VALUE
           set lblOppSVRbdExp::Text to PK310-O-NHL-RBD-VALUE
           set lblOppSVRbdDiff::Text to PK310-O-NHL-RBD-PCT
           set lblOppSVGoals::Text to PK310-O-NON-EMPTY-GOALS
           set lblOppSVGoalExp::Text to PK310-O-EXP-GOALS
           set lblOppSVGoalDiff::Text to PK310-O-GOAL-DIFF::ToString("+#;-#;0")
           set lblOppSVOnGoal::Text to PK310-O-GOAL-SH-DIFF
           set lblOppSVOnGoalDiff::Text to PK310-O-SHOOT-GOAL-DIFF::ToString("+#;-#;0")
           set lblOppSVBlocked::Text to PK310-O-BL-SHOTS-PCT
           set lblOppSVBlockedDiff::Text to PK310-O-BL-GOAL-DIFF::ToString("+#;-#;0")
           set lblOppSVMissed::Text to PK310-O-MISS-SHOTS-PCT
           set lblOppSVMissedDiff::Text to PK310-O-MISS-GOAL-DIFF::ToString("+#;-#;0")
           set lblOppSVRbdGoals::Text to PK310-O-REBOUND-GOALS
           set lblOppSVEmpty::Text TO PK310-O-EMPTY-NET           
           
           set lblSVvsOpp::Text to PK310-TOT-DIF::ToString("+#;-#;0")
           set lblSVPct::Text to PK310-PCT-DIF
           set lblSVNHL::Text to PK310-NHL-PCT-DIFF
           
           if PK310-TOT-DIF < 0
               set lblSVvsOpp::ForeColor to type Color::DarkRed
               set lblSVPct::ForeColor to type Color::DarkRed
           else
               set lblSVvsOpp::ForeColor to type Color::DodgerBlue
               set lblSVPct::ForeColor to type Color::DodgerBlue.
           if PK310-T-GOAL-DIF < 0
               set lblTeamSVGoalsDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVGoalsDiff::ForeColor to type Color::DodgerBlue.     
           if PK310-I-GOAL-DIF < 0
               set lblPlSVGoalDiff::ForeColor to type Color::DarkRed
           else
               set lblPlSVGoalDiff::ForeColor to type Color::DodgerBlue.      
           if PK310-O-GOAL-DIFF < 0
               set lblOppSVGoalDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVGoalDiff::ForeColor to type Color::DodgerBlue.                 
           if PK310-T-SH-VALUE < PK310-T-NHL-ALL-VALUE
               set lblTeamSVDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVDiff::ForeColor to type Color::DodgerBlue.
           if PK310-T-REB-VALUE < PK310-T-NHL-RBD-VALUE
               set lblTeamSVRbdDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVRbdDiff::ForeColor to type Color::DodgerBlue.           
           if PK310-O-SH-VALUE < PK310-O-NHL-ALL-VALUE
               set lblOppSVDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVDiff::ForeColor to type Color::DodgerBlue.
           if PK310-O-REB-VALUE < PK310-O-NHL-RBD-VALUE
               set lblOppSVRbdDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVRbdDiff::ForeColor to type Color::DodgerBlue.           
           if PK310-T-SHOOT-GOAL-DIFF < 0
               set lblTeamSVOnGoalDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVOnGoalDiff::ForeColor to type Color::DodgerBlue.   
           if PK310-T-BL-GOAL-DIFF < 0
               set lblTeamSVBlockedDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVBlockedDiff::ForeColor to type Color::DodgerBlue.  
           if PK310-T-MISS-GOAL-DIFF < 0
               set lblTeamSVMissedDiff::ForeColor to type Color::DarkRed
           else
               set lblTeamSVMissedDiff::ForeColor to type Color::DodgerBlue.                
           if PK310-I-SHOOT-GOAL-DIFF < 0
               set lblPlSVOnGoalDiff::ForeColor to type Color::DarkRed
           else
               set lblPlSVOnGoalDiff::ForeColor to type Color::DodgerBlue.   
           if PK310-I-BL-GOAL-DIFF < 0
               set lblPlSVBlockedDiff::ForeColor to type Color::DarkRed
           else
               set lblPlSVBlockedDiff::ForeColor to type Color::DodgerBlue.  
           if PK310-I-MISS-GOAL-DIFF < 0
               set lblPlSVMissedDiff::ForeColor to type Color::DarkRed
           else
               set lblPlSVMissedDiff::ForeColor to type Color::DodgerBlue.        
           if PK310-O-SHOOT-GOAL-DIFF < 0
               set lblOppSVOnGoalDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVOnGoalDiff::ForeColor to type Color::DodgerBlue.   
           if PK310-O-BL-GOAL-DIFF < 0
               set lblOppSVBlockedDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVBlockedDiff::ForeColor to type Color::DodgerBlue.  
           if PK310-O-MISS-GOAL-DIFF < 0
               set lblOppSVMissedDiff::ForeColor to type Color::DarkRed
           else
               set lblOppSVMissedDiff::ForeColor to type Color::DodgerBlue.        
               
           invoke self::loadLines

           invoke ddCustomEvent::Items::Clear
           move 1 to aa.
       custevent-loop.
           if aa > DIALOG-CUSTOM-NUM
               go to custevent-done.
           invoke ddCustomEvent::Items::Add(DIALOG-CUSTOM-DESC(AA)::Trim)
           add 1 to aa
           go to custevent-loop.
       custevent-done.           
           set resetFlag to "Y"
           if ddCustomEvent::Items::Count not = 0
               set ddCustomEvent::SelectedIndex to DIALOG-CUSTOM-IDX - 1.            
           set resetFlag to "N"           
       end method.

       method-id loadLines protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           invoke playTable::Rows::Clear()
           invoke self::addTableRow(playTable, "  Date  Pd V H   Description"::Replace(" ", "&nbsp;"), 'h')               
           move 1 to aa.
       5-loop.
           if aa > PK310-NUM-LINES
               go to 10-done.
           invoke self::addTableRow(playTable, PK310-DATA-LINE(AA), 'b').
           add 1 to aa.
           go to 5-loop.
       10-done.
       end method.
      * ########################
      * #### Helper Methods ####
      * ########################
        
        
      * #### One Click Dates ####
       method-id SetGameDates private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".
       procedure division using by value dateChoiceFlag as String
                          returning startEndDates as String.
                          
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
               set pk310rununit to self::Session::Item("310rununit")
                   as type RunUnit           
           if dateChoiceFlag = "A"
               MOVE "A" to PK300-DATE-CHOICE-FLAG
               MOVE "A" to PK300-GAME-FLAG
               MOVE "A" to PK300-END-GAME-FLAG
               set startEndDates to "ALL"
           else
               MOVE dateChoiceFlag to PK300-DATE-CHOICE-FLAG
               MOVE "DC" to PK300-ACTION
               invoke pk310rununit::Call("PK300WEBF")
               MOVE "D" to PK300-GAME-FLAG
               MOVE "D" to PK300-END-GAME-FLAG
               if ERROR-FIELD NOT = SPACES
                   set startEndDates to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if    
               set startEndDates to PK300-GAME-DATE::ToString("##/##/##") & ";" & PK300-END-GAME-DATE::ToString("##/##/##").
       end method.
       
      * ######################## 
      * #### Player Selection ####
      * ######################## 
        
      * ########################
      * #### Team Selection ####
      * ########################   
       method-id btnPlayerTeamOK_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           
           set PK300-PLAYER-TEAM, PK300-PLAYER to teamName  

           MOVE "T" to PK300-PLAYER-FLAG
           move PK300-PLAYER-TEAM to PK300-PLAYER.
      *    Called on client side: 
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
      *    set pitcherTextBox::Text to PK300-PITCHER
           
           set playerTeam to PK300-PLAYER::Trim
           
       end method.
       
       method-id btnOppTeamOK_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           
           set PK300-OPPONENT-TEAM, PK300-OPPONENT to teamName 
               
           MOVE "T" to PK300-OPPONENT-FLAG
           MOVE PK300-OPPONENT-TEAM to PK300-OPPONENT
      * Called Client-Side    
      *    SET batterSelectionTextBox::Text to PK300-BATTER::Trim
      *    set batterTextBox::Text to PK300-BATTER
      *    invoke bHiddenFieldTeam_ModalPopupExtender::Hide
            
           set playerTeam to PK300-OPPONENT::Trim
       end method.
       
       method-id btnOppAll_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "A" to PK300-OPPONENT-FLAG
           MOVE "ALL" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnEastConf_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "1" to PK300-OPPONENT-FLAG
           MOVE "EASTERN CONF" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnEastAtl_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "2" to PK300-OPPONENT-FLAG
           MOVE "EASTERN ATL" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnEastMetro_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "3" to PK300-OPPONENT-FLAG
           MOVE "EASTERN MET" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnWestConf_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "4" to PK300-OPPONENT-FLAG
           MOVE "WESTERN CONF" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnWestCent_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "5" to PK300-OPPONENT-FLAG
           MOVE "WESTERN CENT" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnWestPac_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           
           MOVE "6" to PK300-OPPONENT-FLAG
           MOVE "WESTERN PAC" to PK300-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK300-PITCHER::Trim
           
           set oppSelection to PK300-OPPONENT::Trim
       end method.

       method-id btnSelectPlayer_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division returning returnVal as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
               type RunUnit
           MOVE "I" to PK300-PLAYER-FLAG
           MOVE "RB" to PK300-ACTION
           
           invoke pk310rununit::Call("PK300WEBF")
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
           COPY "Y:\sydexsource\pucks\pk300_dg.CPB".  
       procedure division using by value selectedPlayerInfo as String 
                          returning playerName as String.
           set mydata300 to self::Session["pk300data"] as type pucksweb.pk300Data
           set address of PK300-DIALOG-FIELDS to myData300::tablePointer
           set pk310rununit to self::Session::Item("310rununit") as
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
               set PK300-SEL-PLAYER to play-first-name::Trim & " " & play-last-name::Trim 
               MOVE play-player-id to PK300-LOCATE-SEL-ID
               CLOSE PLAY-FILE
               move "LP" to PK300-ACTION
               invoke pk310rununit::Call("PK300WEBF")
               move PK300-LOCATE-SEL-ID to PK300-SAVE-PLAYER-ID           
               move "TI" to PK300-ACTION
               invoke pk310rununit::Call("PK300WEBF")
               if ERROR-FIELD NOT = SPACES
                   set playerName to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
                   exit method
               END-IF    
           else 
      *        Player is selected using list box   
               invoke type System.Single::TryParse(selectedPlayer::Substring(0, selectedPlayer::IndexOf(",")), by reference selIndex)
               MOVE PK300-ROSTER-NAME(selIndex) TO PK300-SEL-PLAYER
               MOVE PK300-ROSTER-ID(selIndex) TO PK300-SAVE-PLAYER-ID.
           
           move PK300-SEL-PLAYER to PK300-PLAYER 
           
           set playerName to PK300-PLAYER
       end method.  
   
       method-id shotLocations protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk310_dg.CPB".  
       procedure division using shotCall as String returning returnVal as String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move shotCall to PK310-SHOT-CALL
           move "BT" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           set lblTopLeft::Text to PK310-NET-TOP-LEFT
           set lblTopCenter::Text to PK310-NET-TOP-CENTER
           set lblTopRight::Text to PK310-NET-TOP-RIGHT
           set lblBotLeft::Text to PK310-NET-BOT-LEFT
           set lblBotCenter::Text to PK310-NET-BOT-CENTER
           set lblBotRight::Text to PK310-NET-BOT-RIGHT
           set returnVal to PK310-NET-TOP-LEFT & ";" & PK310-NET-TOP-CENTER & ";" & PK310-NET-TOP-RIGHT & ";" & 
               PK310-NET-BOT-LEFT & ";" & PK310-NET-BOT-CENTER & ";" & PK310-NET-BOT-RIGHT
       end method.  

       method-id btnPlayAll_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk310_dg.CPB".  
       procedure division returning returnVal as String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move "VA" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
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
           COPY "Y:\sydexsource\pucks\pk310_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK310-FIELD-IP to num
           move "VF" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           invoke self::batstube
           if PK310-WF-VID-COUNT = 0
               set returnVal to "er|" & "No video clips found"
               exit method
       end method.  

       method-id playNet protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using netLoc as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if netLoc = 'top-left'
               move 1 to PK310-NET-M-IN-X
               move 1 to PK310-NET-M-IN-Y
               move 1 to PK310-NET-M-OUT-X
               move 1 to PK310-NET-M-OUT-Y
           else
           if netLoc = 'top-center'
               move 2 to PK310-NET-M-IN-X
               move 1 to PK310-NET-M-IN-Y
               move 2 to PK310-NET-M-OUT-X
               move 1 to PK310-NET-M-OUT-Y
           else
           if netLoc = 'top-right'
               move 3 to PK310-NET-M-IN-X
               move 1 to PK310-NET-M-IN-Y
               move 3 to PK310-NET-M-OUT-X
               move 1 to PK310-NET-M-OUT-Y
           else
           if netLoc = 'bottom-left'
               move 1 to PK310-NET-M-IN-X
               move 2 to PK310-NET-M-IN-Y
               move 1 to PK310-NET-M-OUT-X
               move 2 to PK310-NET-M-OUT-Y
           else
           if netLoc = 'bottom-center'
               move 2 to PK310-NET-M-IN-X
               move 2 to PK310-NET-M-IN-Y
               move 2 to PK310-NET-M-OUT-X
               move 2 to PK310-NET-M-OUT-Y
           else
           if netLoc = 'bottom-right'
               move 3 to PK310-NET-M-IN-X
               move 2 to PK310-NET-M-IN-Y
               move 3 to PK310-NET-M-OUT-X
               move 2 to PK310-NET-M-OUT-Y.
           move "VN" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK310-WF-VID-COUNT = 0
               set returnVal to "er|" & "No clip at that location"
               exit method.
           invoke self::batstube.
       end method.

       method-id playRink protected.
       local-storage section.
PM    *01 xVal type String. 
 PM   *01 yVal type String.
       01 iNum         type Int16.
       01 vals     type String occurs 4.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           MOVE MOUSEX TO PK310-RINK-M-IN-X
           MOVE MOUSEX2 TO PK310-RINK-M-OUT-X
           MOVE MOUSEY TO PK310-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK310-RINK-M-OUT-Y
           IF MOUSEX = MOUSEX2 AND MOUSEY = MOUSEY2
               SUBTRACT 3 FROM PK310-RINK-M-IN-X
               SUBTRACT 3 FROM PK310-RINK-M-IN-Y
               ADD 3 TO PK310-RINK-M-OUT-X
               ADD 3 TO PK310-RINK-M-OUT-Y.
           move "R4" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK310-WF-VID-COUNT = 0
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
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
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
           MOVE MOUSEX TO PK310-RINK-M-IN-X
           MOVE MOUSEX2 TO PK310-RINK-M-OUT-X
           MOVE MOUSEY TO PK310-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK310-RINK-M-OUT-Y
       end method.


       method-id playSelected protected.
       local-storage section.
       01 num          type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set pk310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move 0 to aa.
           if indexString = null
               exit method.
           invoke type Single::TryParse(indexString, reference num)
           SET PK310-SEL-LINES, PK310-LINE-IP to num + 1
           move "VL" to PK310-ACTION
           invoke pk310rununit::Call("PK310WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

      * ########################   

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
       
       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > PK310-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & PK310-WF-VIDEO-PATH(aa)::Trim & "#t=" &  PK310-WF-VIDEO-START(AA) & "," & 
               (PK310-WF-VIDEO-START(AA) + PK310-WF-VIDEO-DURATION(AA)) & ";"
PM    *     set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-A(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
      *         (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM         set vidTitles to vidTitles & PK310-WF-VIDEO-TITL(aa) & ";"
           
           if PK310-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & PK310-WF-VIDEO-PATH(aa) & PK310-WF-VIDEO-B(aa) & "#t=" &  PK310-WF-VIDEO-START(AA) & "," & 
               (PK310-WF-VIDEO-START(AA) + PK310-WF-VIDEO-DURATION(AA)) & ";"
               set vidTitles to vidTitles & "B;".
           if PK310-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & PK310-WF-VIDEO-PATH(aa) & PK310-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if PK310-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & PK310-WF-VIDEO-PATH(aa) & PK310-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.
       end class.
