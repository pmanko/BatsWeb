       class-id pucksweb.lineBreakdown is partial 
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
       01 pk320rununit         type RunUnit.
       01 PK320WEBF                type PK320WEBF.
       01 mydata type pucksweb.pk320Data.
       01 mydata322 type pucksweb.pk322Data.
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
           COPY "Y:\sydexsource\PUCKS\PK320_dg.CPB".
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
           if   self::Session["pk320data"] = null
              set mydata to new pucksweb.pk320Data
              invoke mydata::populateData
              set self::Session["pk320data"] to mydata
           else
               set mydata to self::Session["pk320data"] as type pucksweb.pk320Data.

           if  self::Session::Item("320rununit") not = null
               set pk320rununit to self::Session::Item("320rununit")
                   as type RunUnit
                ELSE
                set pk320rununit to type RunUnit::New()
                set PK320WEBF to new PK320WEBF
                invoke pk320rununit::Add(PK320WEBF)
                set self::Session::Item("320rununit") to pk320rununit.
           
           set address of PK320-DIALOG-FIELDS to myData::tablePointer
           move "I" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")

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
           move 1 to SH-PK322-FLAG
           move "Y" to PK320-BYPASS-FLAG
           move "FD" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if PK320-BYPASS-FLAG not = "Y"
               invoke self::Recalc.

           invoke self::pk322.
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
           else if actionFlag = "oo"
               set callbackReturn to actionFlag & "|" & self::btnOppAll_Click()
           else if actionFlag = "sp"
               set callbackReturn to actionFlag & "|" & self::btnSelectPlayer_Click()
           else if actionFlag = 'lr'
               set callbackReturn to actionFlag & "|" & self::ddPlayerTeam(methodArg)
           else if actionFlag = 'lt'
               invoke self::ddLineTeam(methodArg)
               set callbackReturn to actionFlag
           else if actionFlag = 'ot'
               invoke self::ddOppTeam(methodArg)
               set callbackReturn to actionFlag
           else if actionFlag = 'li'
               set callbackReturn to actionFlag & "|" & self::li(methodArg)
           else if actionFlag = 'lic'
               set callbackReturn to actionFlag & "|" & self::lic(methodArg)
           else if actionFlag = 'le'
               set callbackReturn to actionFlag & "|" & self::le(methodArg)
           else if actionFlag = 'lec'
               set callbackReturn to actionFlag & "|" & self::lec(methodArg)
           else if actionFlag = 'oi'
               set callbackReturn to actionFlag & "|" & self::oi(methodArg)
           else if actionFlag = 'oic'
               set callbackReturn to actionFlag & "|" & self::oic(methodArg)
           else if actionFlag = 'oe'
               set callbackReturn to actionFlag & "|" & self::oe(methodArg)
           else if actionFlag = 'oec'
               set callbackReturn to actionFlag & "|" & self::oec(methodArg)
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
               invoke self::playSelected(methodArg)           
               set callbackReturn to actionFlag & "|"
           else if actionFlag = "update-play-dblclick"
               set callbackReturn to actionFlag & "|" & self::playSelected(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################

      ****************************** Radio Button Methods **************************************
       method-id rbLineTeam_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbLineTeam::Checked = true
               MOVE "T" to PK322-PLAYER-FLAG.
       end method.

       method-id rbLineToInclude_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbLineToInclude::Checked = true
               MOVE "I" to PK322-PLAYER-FLAG.
       end method.

       method-id rbOppAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbOppAll::Checked = true
               move "A" to PK322-OPPONENT-FLAG
               move "ALL" to PK322-OPPONENT
               move " " to PK322-OPP-CONF.
      * do through javascript 
      *         set btnOppConf::Text to PK322-OPP-CONF::Trim.
       end method.

        method-id rbOppConf_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbOppConf::Checked = true
               move " " to PK322-OPPONENT-FLAG.
      * do through javascript 
      *        set SelectConferenceForm to new type PK322.SelectConferenceForm
      *        if SelectConferenceForm::ShowDialog = type DialogResult::OK
      *            set lblOppConf::Text to PK322-OPP-CONF::Trim.
       end method.

        method-id rbOppTeam_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbOppTeam::Checked = true
                    MOVE " " to PK322-OPP-CONF
                    move "T" to PK322-OPPONENT-FLAG
                    move PK322-OPPONENT-TEAM to PK322-OPPONENT.
      * do through javascript 
      *              set lblOppConf::Text to PK322-OPP-CONF::Trim.
       end method.

       method-id rbOppToInclude_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbOppToInclude::Checked = true
                    MOVE " " to PK322-OPP-CONF
                    move "I" to PK322-OPPONENT-FLAG.
      * do through javascript 
      *              set lblOppConf::Text to PK322-OPP-CONF::Trim.
       end method.

       method-id rbStartAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbStartAll::Checked = true
               MOVE "A" to PK322-GAME-FLAG.
       end method.

       method-id rbStartDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbStartDate::Checked
               MOVE "D" to PK322-GAME-FLAG.
       end method.

       method-id rbEndAll_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbEndAll::Checked
               MOVE "A" to PK322-END-GAME-FLAG.
       end method.

       method-id rbEndDate_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbEndDate::Checked
               MOVE "D" to PK322-END-GAME-FLAG.
       end method.

       method-id rbAllGames_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbAllSeasonGames::Checked
               MOVE "A" to PK322-GAME-TYPE-FLAG.
       end method.

       method-id rbPreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbPreSeason::Checked
               MOVE "S" to PK322-GAME-TYPE-FLAG.
       end method.

       method-id rbRegularSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbRegSeason::Checked
               MOVE "R" to PK322-GAME-TYPE-FLAG.
       end method.

       method-id rbExcludePreSeason_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbExcludePreSeason::Checked
               MOVE "N" to PK322-GAME-TYPE-FLAG.
       end method.

       method-id rbPlayoffs_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbPlayoffs::Checked
               MOVE "P" to PK322-GAME-TYPE-FLAG.
       end method.

       method-id rbAllLocations_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbAllLocations::Checked
               MOVE " " to PK322-PLAYER-LOC-FLAG.
       end method.

       method-id rbHome_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbPlayerHome::Checked
               MOVE "H" to PK322-PLAYER-LOC-FLAG.
       end method.

       method-id rbAway_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbPlayerAway::Checked
               MOVE "A" to PK322-PLAYER-LOC-FLAG.
       end method.

       method-id rbShowOld_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbOldToNew::Checked
               MOVE "O" to PK322-GAME-SHOW-FLAG.
       end method.

       method-id rbShowNew_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if rbNewToOld::Checked
               MOVE "N" to PK322-GAME-SHOW-FLAG.
       end method.

       method-id rbAllEvents_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
            if rbAllEvents::Checked = true
               move "A" to PK320-ADVANCED-TYPE.
       end method.

       method-id rbNhlOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
            if rbNHLOnly::Checked = true
               move "N" to PK320-ADVANCED-TYPE.     
       end method.

       method-id rbCustomOnly_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
            if rbCustomOnly::Checked = true
               move "C" to PK320-ADVANCED-TYPE.    
       end method.

       method-id rbGreaterOrEq_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           if rbGreaterOrEq::Checked = true
               move "M" to PK320-CHANCE-FLAG
       end method.
       
       method-id rbLess_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           if rbLess::Checked = true
               move "L" to PK320-CHANCE-FLAG
       end method.

      ******************************************************************************************

      ********************************** DropDown Methods **************************************

       method-id ddPeriod_SelectedIndexChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           else    
               set PK320-CHA-MASTER to ddPctChances::SelectedItem
               set PK320-CHA-IDX to ddPctChances::SelectedIndex
               add 1 to PK320-CHA-IDX
               if resetFlag not = "Y"
                   invoke self::Recalc.
       end method.

       method-id ddPlayerTeam final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value selectedTeam as String
                          returning teamList as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
               set pk320rununit to self::Session::Item("320rununit")
                   as type RunUnit       
           set PK322-SEL-TEAM to selectedTeam 
           if PK322-P-O-FLAG = "P"
               MOVE PK322-SEL-TEAM to PK322-PLAYER-TEAM
           else
           if PK322-P-O-FLAG = "O"
               MOVE PK322-SEL-TEAM to PK322-OPPONENT-TEAM
           else
           IF PK322-EXCLUDE-FLAG = "E" 
               MOVE PK322-SEL-TEAM to PK322-PLAYER-TEAM
           else
           IF PK322-EXCLUDE-OPP-FLAG = "E" 
               MOVE PK322-SEL-TEAM to PK322-OPPONENT-TEAM.   
           MOVE "RB" TO PK322-ACTION 
           invoke pk320rununit::Call("PK322WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.              
           set teamList to ""

           move 1 to aa.
       5-loop.
           if aa > PK322-NUM-PLAYERS
               go to 10-done
           else
               set teamList to teamList & (" " & PK322-ROSTER-NAME(aa) & " " & PK322-ROSTER-POS(aa)) & ";".
      *         set teamList to teamList & aa & "," & (" " & PK322-ROSTER-NAME(aa) & " " & PK322-ROSTER-POS(aa)) & ";".
           add 1 to aa.
           go to 5-loop.
       10-done.
           move 1 to aa.

       end method.

       method-id ddLineTeam final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value selectedTeam as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
      *     MOVE "T" to PK322-PLAYER-FLAG
            set PK322-PLAYER-TEAM, PK322-PLAYER to selectedTeam.     
       end method.

       method-id ddOppTeam final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value selectedTeam as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
      *     MOVE "T" to PK322-OPPONENT-FLAG
           set PK322-OPPONENT-TEAM, PK322-OPPONENT to selectedTeam
       end method.

       method-id ddOppConf_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           if ddOppConf::SelectedIndex = 0
               set PK322-OPPONENT-FLAG to 1
               move "EASTERN CONF" to PK322-OPPONENT
               move "EASTERN CONF" to PK322-OPP-CONF
           else 
           if ddOppConf::SelectedIndex = 1
               set PK322-OPPONENT-FLAG to 2
               move "EASTERN ATL" to PK322-OPPONENT
               move "EASTERN ATL" to PK322-OPP-CONF
           else 
           if ddOppConf::SelectedIndex = 2
               set PK322-OPPONENT-FLAG to 3
               move "EASTERN MET" to PK322-OPPONENT
               move "EASTERN MET" to PK322-OPP-CONF
           else 
           if ddOppConf::SelectedIndex = 3
               set PK322-OPPONENT-FLAG to 4
               move "WESTERN CONF" to PK322-OPPONENT
               move "WESTERN CONF" to PK322-OPP-CONF
           else 
           if ddOppConf::SelectedIndex = 4
               set PK322-OPPONENT-FLAG to 5
               move "WESTERN CENT" to PK322-OPPONENT
               move "WESTERN CENT" to PK322-OPP-CONF
           else 
           if ddOppConf::SelectedIndex = 5
               set PK322-OPPONENT-FLAG to 6
               move "WESTERN PAC" to PK322-OPPONENT
               move "WESTERN PAC" to PK322-OPP-CONF.
       end method.

      ******************************************************************************************

      ********************************** Checkbox Methods **************************************

       method-id cbFirstShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbFirstShotsOnly::Checked = true
               set cbReboundShotsOnly::Enabled to false
               move "1" to PK320-RBDS-ONLY-FLAG
           else  
               set cbReboundShotsOnly::Enabled to true
               move " " to PK320-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.     
       end method.

       method-id cbReboundShotsOnly_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbReboundShotsOnly::Checked = true
               set cbFirstShotsOnly::Enabled to false
               move "Y" to PK320-RBDS-ONLY-FLAG
           else  
               set cbFirstShotsOnly::Enabled to true
               move " " to PK320-RBDS-ONLY-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.   
       end method.

       method-id cbUseDuration_CheckedChanged protected.
       local-storage section.
       01 num          type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbUseDuration::Checked
               invoke type System.Single::TryParse(tbDuration::Text::ToString, by reference num)
               set PK320-PLAY-DURATION to num
               move "Y" to PK320-USE-DUR-FLAG
               set ddShotResult::Enabled to false
               set ddShotType::Enabled to false
               set ddPctChances::Enabled to false              
           else
               move " " to PK320-USE-DUR-FLAG
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbLeft::Checked = true
               set cbRight::Enabled to false
               move "L" to PK320-HAND-FLAG
           else    
               set cbRight::Enabled to true
               move " " to PK320-HAND-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.
       end method.

       method-id cbRight_CheckedChanged protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbRight::Checked = true
               set cbLeft::Enabled to false
               move "R" to PK320-HAND-FLAG
           else    
               set cbLeft::Enabled to true
               move " " to PK320-HAND-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.   
       end method.

       method-id cbFOOppWon_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if cbFOOppWon::Checked = true
               move "Y" to PK320-FACEOFF-LOSS-FLAG
           else
               move " " to PK320-FACEOFF-LOSS-FLAG.
           if resetFlag not = "Y"
               INVOKE self::Recalc.

       end method.
      ******************************************************************************************

      ************************************ Button Methods **************************************
       method-id btnGo_Click protected.
       local-storage section.
       01 gmDate        type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk322_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
               set pk320rununit to self::Session::Item("320rununit")
                   as type RunUnit       
           invoke type System.Single::TryParse(startDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK322-GAME-DATE to gmDate
           invoke type System.Single::TryParse(endDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set PK322-END-GAME-DATE to gmDate

           MOVE "GO" to PK322-ACTION
           invoke pk320rununit::Call("PK322WEBF")
           if ERROR-FOUND = "Y"
               MOVE " " TO ERROR-FOUND
               MOVE " " TO PK322-ACTION
               invoke pk320rununit::Call("PK322WEBF")
           else
               invoke self::Recalc. 
           set lblLI1::Text to PK322-PLAYER-NAME(1)::Trim
           set lblLI2::Text to PK322-PLAYER-NAME(2)::Trim
           set lblLI3::Text to PK322-PLAYER-NAME(3)::Trim
           set lblLI4::Text to PK322-PLAYER-NAME(4)::Trim
           set lblLI5::Text to PK322-PLAYER-NAME(5)::Trim
           set lblLE1::Text to PK322-X-PLAYER-NAME(1)::Trim
           set lblLE2::Text to PK322-X-PLAYER-NAME(2)::Trim
           set lblLE3::Text to PK322-X-PLAYER-NAME(3)::Trim
           set lblLE4::Text to PK322-X-PLAYER-NAME(4)::Trim
           set lblLE5::Text to PK322-X-PLAYER-NAME(5)::Trim
    ******Opponent Player Selection Fields
           set lblOI1::Text to PK322-O-PLAYER-NAME(1)::Trim
           set lblOI2::Text to PK322-O-PLAYER-NAME(2)::Trim
           set lblOI3::Text to PK322-O-PLAYER-NAME(3)::Trim
           set lblOI4::Text to PK322-O-PLAYER-NAME(4)::Trim
           set lblOI5::Text to PK322-O-PLAYER-NAME(5)::Trim
           set lblOE1::Text to PK322-X-O-PLAYER-NAME(1)::Trim
           set lblOE2::Text to PK322-X-O-PLAYER-NAME(2)::Trim
           set lblOE3::Text to PK322-X-O-PLAYER-NAME(3)::Trim
           set lblOE4::Text to PK322-X-O-PLAYER-NAME(4)::Trim
           set lblOE5::Text to PK322-X-O-PLAYER-NAME(5)::Trim                               
       end method.

       method-id btnReset_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           set resetFlag to "Y"
           MOVE " " to PK320-ADVANCED-DESC
           move " " to PK320-ADVANCED-DESC2
           move " " to PK320-ADVANCED-INIT           
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
           move " " to PK320-RBDS-ONLY-FLAG.
           set cbUseDuration::Checked to false
           move " " to PK320-USE-DUR-FLAG
           set cbLeft::Enabled to true
           set cbRight::Enabled to true
           set cbLeft::Checked to false
           set cbRight::Checked to false
           move " " to PK320-HAND-FLAG.
           set cbFOOppWon::Checked to true
           move " " to PK320-FACEOFF-LOSS-FLAG
           set resetFlag to "N"
           invoke self::Recalc
       end method.

       method-id btnGoDuration_Click protected.
       local-storage section.
       01 num              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           invoke type System.Single::TryParse(tbDuration::Text::ToString, by reference num)
           set PK320-PLAY-DURATION to num           
           invoke self::Recalc
       end method.

       method-id btnOK_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           set PK320-ADVANCED-INIT to tbAuthor::Text::ToUpper
           set PK320-ADVANCED-DESC to tbNote1::Text::ToUpper
           set PK320-ADVANCED-DESC2 to tbNote2::Text::ToUpper
           move "CA" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.  
           invoke self::Recalc
       end method.

       method-id btnChancesOK_Click protected.
       local-storage section.
       01 num              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           invoke type System.Single::TryParse(tbChances::Text::ToString, by reference num)
           set PK320-CHANCE-VALUE to num   
           set PK320-CHA-MASTER to ddPctChances::SelectedItem
           set PK320-CHA-IDX to ddPctChances::SelectedIndex
           add 1 to PK320-CHA-IDX
           invoke self::Recalc
       end method.
      ******************************************************************************************

       method-id pk322 protected.
       local-storage section.
       01 num          type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".
       procedure division.
          if self::Session["pk322data"] = null
               set mydata322 to new pucksweb.pk322Data
               invoke mydata322::populateData
               set self::Session["pk322data"] to mydata322              
           else
               set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data.
          
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           INITIALIZE PK322-DIALOG-FIELDS
           MOVE "IN" TO PK322-ACTION
           invoke pk320rununit::Call("PK322WEBF").
           move "N " to PK322-ACTION
           invoke pk320rununit::Call("PK322WEBF").
           IF PK322-PLAYER-LOC-FLAG = " "
               set rbAllLocations::Checked to true
           ELSE IF PK322-PLAYER-LOC-FLAG = "H"
               SET rbPlayerHome::Checked to true
           else if PK322-PLAYER-LOC-FLAG = "A"
               SET rbPlayerAway::Checked to true.

           if PK322-GAME-SHOW-FLAG = "O"
               set rbOldToNew::Checked to true
           else
               set PK322-GAME-SHOW-FLAG to "N"
               set rbNewToOld::Checked to true.

           if PK322-PLAYER-FLAG = "T"
               set rbLineTeam::Checked to true
           else
               set rbLineToInclude::Checked to true.
           if PK322-OPPONENT-FLAG = "A"
               move "ALL" to PK322-OPPONENT
               set rbOppAll::Checked to true
           else if PK322-OPPONENT-FLAG = "T"
               set rbOppTeam::Checked to true
           else if PK322-OPPONENT-FLAG = "I"
               set rbOppToInclude::Checked to true
           else if PK322-OPPONENT-FLAG = "1" or "2" or "3" or "4" or "5" or "6" or "7" or "8"
               set rbOppConf::Checked to true.

           if  PK322-GAME-TYPE-FLAG = "R"
               set rbRegSeason::Checked to true
           else if PK322-GAME-TYPE-FLAG = "P"
               set rbPlayoffs::Checked to true
           else if PK322-GAME-TYPE-FLAG = "S"
               set rbPreSeason::Checked to true
           else if PK322-GAME-TYPE-FLAG = "N"
               set rbExcludePreSeason::Checked to true
           else
               move "A" to PK322-GAME-TYPE-FLAG
               set rbAllSeasonGames::Checked to true.

     ****Line Player Selection Fields
           if PK322-PLAYER-FLAG = "T"
               set ddLineTeam::Text to PK322-PLAYER-TEAM.
           set lblLI1::Text to PK322-PLAYER-NAME(1)::Trim
           set lblLI2::Text to PK322-PLAYER-NAME(2)::Trim
           set lblLI3::Text to PK322-PLAYER-NAME(3)::Trim
           set lblLI4::Text to PK322-PLAYER-NAME(4)::Trim
           set lblLI5::Text to PK322-PLAYER-NAME(5)::Trim
           set lblLE1::Text to PK322-X-PLAYER-NAME(1)::Trim
           set lblLE2::Text to PK322-X-PLAYER-NAME(2)::Trim
           set lblLE3::Text to PK322-X-PLAYER-NAME(3)::Trim
           set lblLE4::Text to PK322-X-PLAYER-NAME(4)::Trim
           set lblLE5::Text to PK322-X-PLAYER-NAME(5)::Trim
    ******Opponent Player Selection Fields
           set lblOI1::Text to PK322-O-PLAYER-NAME(1)::Trim
           set lblOI2::Text to PK322-O-PLAYER-NAME(2)::Trim
           set lblOI3::Text to PK322-O-PLAYER-NAME(3)::Trim
           set lblOI4::Text to PK322-O-PLAYER-NAME(4)::Trim
           set lblOI5::Text to PK322-O-PLAYER-NAME(5)::Trim
           set lblOE1::Text to PK322-X-O-PLAYER-NAME(1)::Trim
           set lblOE2::Text to PK322-X-O-PLAYER-NAME(2)::Trim
           set lblOE3::Text to PK322-X-O-PLAYER-NAME(3)::Trim
           set lblOE4::Text to PK322-X-O-PLAYER-NAME(4)::Trim
           set lblOE5::Text to PK322-X-O-PLAYER-NAME(5)::Trim
           if PK322-OPPONENT-FLAG = "1" or "2" or "3" or "4" or "5" or "6"
               invoke type Single::TryParse(PK322-OPPONENT-FLAG, reference num)
               set ddOppConf::SelectedIndex to num + 1.
           if PK322-OPPONENT-FLAG = "T"
               set ddOppTeam::Text to PK322-OPPONENT-TEAM::Trim.

      *radio buttons for Start/End dates or 'All' dates
           if PK322-GAME-FLAG = "A"
               SET rbStartAll::Checked to true
           else
               set rbStartDate::Checked to true.
           if PK322-END-GAME-FLAG = "A"
               SET rbEndAll::Checked to true
           else
               set rbEndDate::Checked to true.
           set startDateTextBox::Text to PK322-GAME-DATE::ToString("00/00/00")
           set endDateTextBox::Text to PK322-END-GAME-DATE::ToString("00/00/00")
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
           set nameArray to nameArray & playerName & ";"
           add 1 to aa
           go to 5-loop.
       10-done.
           close play-file.
PM         set self::Session::Item("nameArray") to nameArray       
           move 1 to aa. 
       15-loop.
           if aa > PK322-NUM-TEAMS
               go to 20-done
           else
               invoke ddTeam::Items::Add(PK322-TEAM-NAME(aa))
               invoke ddPlayerTeam::Items::Add(PK322-TEAM-NAME(aa))
               invoke ddOppTeam::Items::Add(PK322-TEAM-NAME(aa))
               invoke ddLineTeam::Items::Add(PK322-TEAM-NAME(aa)).
           add 1 to aa
           go to 15-loop.
       20-done.    
           MOVE PK322-PLAYER-TEAM to PK322-SEL-TEAM
           if PK322-SEL-TEAM not = spaces
               set ddPlayerTeam::Text to PK322-SEL-TEAM
               set ddTeam::Text to PK322-SEL-TEAM 
               set ddLineTeam::Text to PK322-SEL-TEAM. 
           if PK322-OPPONENT-TEAM not = spaces
               set ddOppTeam::Text to PK322-OPPONENT-TEAM.
       end method.

       method-id Recalc protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           move "RE" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           
**********Recalc and Redisplay All Data Fields
           set lblPlayer::Text to PK320-PLAYER::Trim
           set lblOpponent::Text to PK320-OPPONENT::Trim
           set lblGames::Text to DIALOG-GAME-RANGE::Trim
           set lblLocation::Text to DIALOG-GAME-LOC::Trim

            set btnTeamShots::Text to PK320-T-SHOTS
            set btnTeamMisses::Text to PK320-T-SHOTS-MISSED
            set btnTeamBlocked::Text to PK320-T-SHOTS-BLOCKED
            set btnTeamOnGoal::Text to PK320-T-SHOTS-ON-GOAL
            set btnTeamGoals::Text to PK320-T-GOALS
            set btnTeamRbds::Text to PK320-T-REBOUNDS
            set btnTeamTakes::Text to PK320-T-TAKES
            set btnTeamGives::Text to PK320-T-GIVES
            set btnTeamHits::Text to PK320-T-HITS
            set btnTeamPens::Text to PK320-T-PENS
            set btnTeamPenMin::Text to PK320-T-PEN-MIN
            set btnTeamRbdGoals::Text to PK320-T-REBOUND-GOALS

            set btnFOTotW::Text to PK320-T-TOT-FACEOFFS-WON
            set btnFODefW::Text to PK320-T-FO-WON-DEF
            set btnFONeuW::Text to PK320-T-FO-WON-NEU
            set btnFOOffW::Text to PK320-T-FO-WON-OFF
            set btnFOTotL::Text to PK320-T-TOT-FACEOFFS-LOSS
            set btnFODefL::Text to PK320-T-FO-LOSS-DEF
            set btnFONeuL::Text to PK320-T-FO-LOSS-NEU
            set btnFOOffL::Text to PK320-T-FO-LOSS-OFF

            set btnOppShots::Text to PK320-O-SHOTS
            set btnOppMisses::Text to PK320-O-SHOTS-MISSED
            set btnOppBlocked::Text to PK320-O-SHOTS-BLOCKED
            set btnOppOnGoal::Text to PK320-O-SHOTS-ON-GOAL
            set btnOppGoals::Text to PK320-O-GOALS
            set btnOppRbds::Text to PK320-O-REBOUNDS
            set btnOppTakes::Text to PK320-O-TAKES
            set btnOppGives::Text to PK320-O-GIVES
            set btnOppHits::Text to PK320-O-HITS
            set btnOppPens::Text to PK320-O-PENS
            set btnOppPenMin::Text to PK320-O-PEN-MIN
            set btnOppRbdGoals::Text to PK320-O-REBOUND-GOALS

            set lblTotalGms::Text to PK320-T-G
            set lblTotalMin::Text to PK320-DISPLAY-MINUTES & ":" & PK320-DISPLAY-SECONDS::ToString("00")
            set lblTotalMinPerGame::Text to PK320-AVG-GAME-MINUTES & ":" & PK320-AVG-GAME-SECONDS::ToString("00")

            set lblTeamSVShots::Text to PK320-T-SHOTS
            set lblTeamSVValue::Text to PK320-T-SH-VALUE
            set lblTeamSVExp::Text to PK320-T-NHL-ALL-VALUE
            set lblTeamSVDiff::Text to PK320-T-NHL-ALL-PCT
            set lblTeamSVRbds::Text to PK320-T-REBOUNDS
            set lblTeamSVRbdValue::Text to PK320-T-REB-VALUE
            set lblTeamSVRbdExp::Text to PK320-T-NHL-RBD-VALUE
            set lblTeamSVRbdDiff::Text to PK320-T-NHL-RBD-PCT
            set lblTeamSVGoals::Text to PK320-T-NON-EMPTY-GOALS
            set lblTeamSVGoalsExp::Text to PK320-T-EXP-GOALS
            set lblTeamSVGoalsDiff::Text to PK320-T-GOAL-DIFF::ToString("+#;-#;0")
            set lblTeamSVOnGoal::Text to PK320-T-GOAL-SH-DIFF
            set lblTeamSVOnGoalDiff::Text to PK320-T-SHOOT-GOAL-DIFF::ToString("+#;-#;0")
            set lblTeamSVBlocked::Text to PK320-T-BL-SHOTS-PCT
            set lblTeamSVBlockedDiff::Text to PK320-T-BL-GOAL-DIFF::ToString("+#;-#;0")
            set lblTeamSVMissed::Text to PK320-T-MISS-SHOTS-PCT
            set lblTeamSVMissedDiff::Text to PK320-T-MISS-GOAL-DIFF::ToString("+#;-#;0")
            set lblTeamSVRbdGoals::Text to PK320-T-REBOUND-GOALS
            set lblTeamSVEmpty::Text TO PK320-T-EMPTY-NET

            set lblOppSVShots::Text to PK320-O-SHOTS
            set lblOppSVValue::Text to PK320-O-SH-VALUE
            set lblOppSVExp::Text to PK320-O-NHL-ALL-VALUE
            set lblOppSVDiff::Text to PK320-O-NHL-ALL-PCT
            set lblOppSVRbds::Text to PK320-O-REBOUNDS
            set lblOppSVRbdValue::Text to PK320-O-REB-VALUE
            set lblOppSVRbdExp::Text to PK320-O-NHL-RBD-VALUE
            set lblOppSVRbdDiff::Text to PK320-O-NHL-RBD-PCT
            set lblOppSVGoals::Text to PK320-O-NON-EMPTY-GOALS
            set lblOppSVGoalExp::Text to PK320-O-EXP-GOALS
            set lblOppSVGoalDiff::Text to PK320-O-GOAL-DIFF::ToString("+#;-#;0")
            set lblOppSVOnGoal::Text to PK320-O-GOAL-SH-DIFF
            set lblOppSVOnGoalDiff::Text to PK320-O-SHOOT-GOAL-DIFF::ToString("+#;-#;0")
            set lblOppSVBlocked::Text to PK320-O-BL-SHOTS-PCT
            set lblOppSVBlockedDiff::Text to PK320-O-BL-GOAL-DIFF::ToString("+#;-#;0")
            set lblOppSVMissed::Text to PK320-O-MISS-SHOTS-PCT
            set lblOppSVMissedDiff::Text to PK320-O-MISS-GOAL-DIFF::ToString("+#;-#;0")
            set lblOppSVRbdGoals::Text to PK320-O-REBOUND-GOALS
            set lblOppSVEmpty::Text TO PK320-O-EMPTY-NET

            set lblSVvsOpp::Text to PK320-TOT-DIF::ToString("+#;-#;0")
            set lblSVPct::Text to PK320-PCT-DIF
            set lblSVNHL::Text to PK320-NHL-PCT-DIFF

            if PK320-TOT-DIF < 0
                set lblSVvsOpp::ForeColor to type Color::DarkRed
                set lblSVPct::ForeColor to type Color::DarkRed
            else
                set lblSVvsOpp::ForeColor to type Color::DodgerBlue
                set lblSVPct::ForeColor to type Color::DodgerBlue.
           if PK320-T-GOAL-DIFF < 0
                set lblTeamSVGoalsDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVGoalsDiff::ForeColor to type Color::DodgerBlue.

            if PK320-O-GOAL-DIFF < 0
                set lblOppSVGoalDiff::ForeColor to type Color::DarkRed
            else
                set lblOppSVGoalDiff::ForeColor to type Color::DodgerBlue.
            if PK320-T-SH-VALUE < PK320-T-NHL-ALL-VALUE
                set lblTeamSVDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVDiff::ForeColor to type Color::DodgerBlue.
            if PK320-T-REB-VALUE < PK320-T-NHL-RBD-VALUE
                set lblTeamSVRbdDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVRbdDiff::ForeColor to type Color::DodgerBlue.
            if PK320-O-SH-VALUE < PK320-O-NHL-ALL-VALUE
                set lblOppSVDiff::ForeColor to type Color::DarkRed
            else
                set lblOppSVDiff::ForeColor to type Color::DodgerBlue.
            if PK320-O-REB-VALUE < PK320-O-NHL-RBD-VALUE
                set lblOppSVRbdDiff::ForeColor to type Color::DarkRed
            else
                set lblOppSVRbdDiff::ForeColor to type Color::DodgerBlue.
            if PK320-T-SHOOT-GOAL-DIFF < 0
                set lblTeamSVOnGoalDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVOnGoalDiff::ForeColor to type Color::DodgerBlue.
            if PK320-T-BL-GOAL-DIFF < 0
                set lblTeamSVBlockedDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVBlockedDiff::ForeColor to type Color::DodgerBlue.
            if PK320-T-MISS-GOAL-DIFF < 0
                set lblTeamSVMissedDiff::ForeColor to type Color::DarkRed
            else
                set lblTeamSVMissedDiff::ForeColor to type Color::DodgerBlue.

            if PK320-O-SHOOT-GOAL-DIFF < 0
                set lblOppSVOnGoalDiff::ForeColor to type Color::DarkRed
            else
                set lblOppSVOnGoalDiff::ForeColor to type Color::DodgerBlue.
            if PK320-O-BL-GOAL-DIFF < 0
                set lblOppSVBlockedDiff::ForeColor to type Color::DarkRed
            else
                set lblOppSVBlockedDiff::ForeColor to type Color::DodgerBlue.
            if PK320-O-MISS-GOAL-DIFF < 0
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           invoke playTable::Rows::Clear()
           invoke self::addTableRow(playTable, "  Date  Pd V H   Description"::Replace(" ", "&nbsp;"), 'h')               
           move 1 to aa.
       5-loop.
           if aa > PK320-NUM-LINES
               go to 10-done.
           invoke self::addTableRow(playTable, PK320-DATA-LINE(AA), 'b').
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
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".
       procedure division using by value dateChoiceFlag as String
                          returning startEndDates as String.
                          
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
               set pk320rununit to self::Session::Item("320rununit")
                   as type RunUnit           
           if dateChoiceFlag = "A"
               MOVE "A" to PK322-DATE-CHOICE-FLAG
               MOVE "A" to PK322-GAME-FLAG
               MOVE "A" to PK322-END-GAME-FLAG
               set startEndDates to "ALL"
           else
               MOVE dateChoiceFlag to PK322-DATE-CHOICE-FLAG
               MOVE "DC" to PK322-ACTION
               invoke pk320rununit::Call("PK322WEBF")
               MOVE "D" to PK322-GAME-FLAG
               MOVE "D" to PK322-END-GAME-FLAG
               if ERROR-FIELD NOT = SPACES
                   set startEndDates to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
               end-if    
               set startEndDates to PK322-GAME-DATE::ToString("##/##/##") & ";" & PK322-END-GAME-DATE::ToString("##/##/##").
       end method.
       
      * ######################## 
      * #### Player Selection ####
      * ######################## 
        
      * ########################
      * #### Team Selection ####
      * ########################   
       method-id btnPlayerTeamOK_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           
           set PK322-PLAYER-TEAM, PK322-PLAYER to teamName  

           MOVE "T" to PK322-PLAYER-FLAG
           move PK322-PLAYER-TEAM to PK322-PLAYER.
      *    Called on client side: 
      *    set pitcherSelectionTextBox::Text to PK322-PITCHER::Trim
      *    set pitcherTextBox::Text to PK322-PITCHER
           
           set playerTeam to PK322-PLAYER::Trim
           
       end method.
       
       method-id btnOppTeamOK_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using by value teamName as String
                          returning playerTeam as String.
                          
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           
           set PK322-OPPONENT-TEAM, PK322-OPPONENT to teamName 
               
           MOVE "T" to PK322-OPPONENT-FLAG
           MOVE PK322-OPPONENT-TEAM to PK322-OPPONENT
      * Called Client-Side    
      *    SET batterSelectionTextBox::Text to PK322-BATTER::Trim
      *    set batterTextBox::Text to PK322-BATTER
      *    invoke bHiddenFieldTeam_ModalPopupExtender::Hide
            
           set playerTeam to PK322-OPPONENT::Trim
       end method.
       
       method-id btnOppAll_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division returning oppSelection as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           
           MOVE "A" to PK322-OPPONENT-FLAG
           MOVE "ALL" to PK322-OPPONENT
      *    Called on client side:     
      *    set pitcherSelectionTextBox::Text to PK322-PITCHER::Trim
           
           set oppSelection to PK322-OPPONENT::Trim
       end method.

       method-id btnSelectPlayer_Click private.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           if PK322-P-O-FLAG = "P"
               MOVE PK322-PLAYER-TEAM to PK322-SEL-TEAM
           else
           if PK322-P-O-FLAG = "O"
               MOVE PK322-OPPONENT-TEAM to PK322-SEL-TEAM
           else
           IF PK322-EXCLUDE-FLAG = "E" 
               MOVE PK322-PLAYER-TEAM to PK322-SEL-TEAM
           else
           IF PK322-EXCLUDE-OPP-FLAG = "E" 
               MOVE PK322-OPPONENT-TEAM to PK322-SEL-TEAM.
           
           if PK322-SEL-TEAM not = spaces
               set ddPlayerTeam::Text to PK322-SEL-TEAM. 
           MOVE "RB" to PK322-ACTION
           
           invoke pk320rununit::Call("PK322WEBF")
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
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using by value selectedPlayerInfo as String 
                          returning playerName as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
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
               set PK322-SEL-PLAYER to play-first-name::Trim & " " & play-last-name::Trim 
               MOVE play-player-id to PK322-LOCATE-SEL-ID
               CLOSE PLAY-FILE
               move "LP" to PK322-ACTION
               invoke pk320rununit::Call("PK322WEBF")
               move PK322-LOCATE-SEL-ID to PK322-SAVE-PLAYER-ID           
               move "TI" to PK322-ACTION
               invoke pk320rununit::Call("PK322WEBF")
               if ERROR-FIELD NOT = SPACES
                   set playerName to "er|" & ERROR-FIELD
                   move spaces to ERROR-FIELD
                   exit method
               END-IF    
           else 
      *        Player is selected using list box   
               invoke type System.Single::TryParse(selectedPlayer::Substring(0, selectedPlayer::IndexOf(",")), by reference selIndex)
               MOVE PK322-ROSTER-NAME(selIndex) TO PK322-SEL-PLAYER
               MOVE PK322-ROSTER-ID(selIndex) TO PK322-SAVE-PLAYER-ID.
           
           if PK322-P-O-FLAG = "O"
               IF PK322-CURR-P-NUM = "1"
                   set playerName to "11;"
                   MOVE PK322-SEL-PLAYER TO PK322-O-PLAYER-NAME(1)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-O-PLAYER-ID(1)
               END-IF
               IF PK322-CURR-P-NUM = "2"
                   set playerName to "12;"
                   MOVE PK322-SEL-PLAYER TO PK322-O-PLAYER-NAME(2)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-O-PLAYER-ID(2)
               END-IF
               IF PK322-CURR-P-NUM = "3"
                   set playerName to "13;"
                   MOVE PK322-SEL-PLAYER TO PK322-O-PLAYER-NAME(3)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-O-PLAYER-ID(3)
               END-IF
               IF PK322-CURR-P-NUM = "4"
                   set playerName to "14;"
                   MOVE PK322-SEL-PLAYER TO PK322-O-PLAYER-NAME(4)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-O-PLAYER-ID(4)
               END-IF
               IF PK322-CURR-P-NUM = "5"
                   set playerName to "15;"
                   MOVE PK322-SEL-PLAYER TO PK322-O-PLAYER-NAME(5)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-O-PLAYER-ID(5)
               END-IF
               go to player-done. 
               
           IF PK322-EXCLUDE-FLAG = "E" 
               IF PK322-CURR-P-NUM = "1"
                   set playerName to "6;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-PLAYER-NAME(1)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-PLAYER-ID(1)
               END-IF
               IF PK322-CURR-P-NUM = "2"
                   set playerName to "7;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-PLAYER-NAME(2)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-PLAYER-ID(2)
               END-IF
               IF PK322-CURR-P-NUM = "3"
                   set playerName to "8;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-PLAYER-NAME(3)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-PLAYER-ID(3)
               END-IF
               IF PK322-CURR-P-NUM = "4"
                   set playerName to "9;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-PLAYER-NAME(4)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-PLAYER-ID(4)
               END-IF
               IF PK322-CURR-P-NUM = "5"
                   set playerName to "10;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-PLAYER-NAME(5)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-PLAYER-ID(5)
               END-IF
               go to player-done. 
                      
           IF PK322-EXCLUDE-OPP-FLAG = "E" 
               IF PK322-CURR-P-NUM = "1"
                   set playerName to "16;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-O-PLAYER-NAME(1)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-O-PLAYER-ID(1)
               END-IF
               IF PK322-CURR-P-NUM = "2"
                   set playerName to "17;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-O-PLAYER-NAME(2)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-O-PLAYER-ID(2)
               END-IF
               IF PK322-CURR-P-NUM = "3"
                   set playerName to "18;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-O-PLAYER-NAME(3)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-O-PLAYER-ID(3)
               END-IF
               IF PK322-CURR-P-NUM = "4"
                   set playerName to "19;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-O-PLAYER-NAME(4)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-O-PLAYER-ID(4)
               END-IF
               IF PK322-CURR-P-NUM = "5"
                   set playerName to "20;"
                   MOVE PK322-SEL-PLAYER TO PK322-X-O-PLAYER-NAME(5)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-X-O-PLAYER-ID(5)
               END-IF
               go to player-done. 
                      

           If PK322-P-O-FLAG = "P"
               IF PK322-CURR-P-NUM = "1"
                   set playerName to "1;"
                   MOVE PK322-SEL-PLAYER TO PK322-PLAYER-NAME(1)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-PLAYER-ID(1)
               END-IF
               IF PK322-CURR-P-NUM = "2"
                   set playerName to "2;"
                   MOVE PK322-SEL-PLAYER TO PK322-PLAYER-NAME(2)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-PLAYER-ID(2)
               END-IF
               IF PK322-CURR-P-NUM = "3"
                   set playerName to "3;"
                   MOVE PK322-SEL-PLAYER TO PK322-PLAYER-NAME(3)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-PLAYER-ID(3)
               END-IF
               IF PK322-CURR-P-NUM = "4"
                   set playerName to "4;"
                   MOVE PK322-SEL-PLAYER TO PK322-PLAYER-NAME(4)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-PLAYER-ID(4)
               END-IF
               IF PK322-CURR-P-NUM = "5"
                   set playerName to "5;"
                   MOVE PK322-SEL-PLAYER TO PK322-PLAYER-NAME(5)
                   MOVE PK322-SAVE-PLAYER-ID TO PK322-PLAYER-ID(5). 

       player-done.
           set playerName to playerName & PK322-SEL-PLAYER
           MOVE " " TO PK322-SEL-PLAYER
           MOVE 0 TO PK322-SAVE-PLAYER-ID
           MOVE 0 TO PK322-CURR-P-NUM
           MOVE " " TO PK322-P-O-FLAG
           MOVE " " to PK322-EXCLUDE-FLAG
           
       end method.  

       method-id shotLocations protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk320_dg.CPB".  
       procedure division using shotCall as String returning returnVal as String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           move shotCall to PK320-SHOT-CALL
           move "BT" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           set lblTopLeft::Text to PK320-NET-TOP-LEFT
           set lblTopCenter::Text to PK320-NET-TOP-CENTER
           set lblTopRight::Text to PK320-NET-TOP-RIGHT
           set lblBotLeft::Text to PK320-NET-BOT-LEFT
           set lblBotCenter::Text to PK320-NET-BOT-CENTER
           set lblBotRight::Text to PK320-NET-BOT-RIGHT
           set returnVal to PK320-NET-TOP-LEFT & ";" & PK320-NET-TOP-CENTER & ";" & PK320-NET-TOP-RIGHT & ";" & 
               PK320-NET-BOT-LEFT & ";" & PK320-NET-BOT-CENTER & ";" & PK320-NET-BOT-RIGHT
       end method.  
         
       method-id btnPlayAll_Click protected.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk320_dg.CPB".  
       procedure division returning returnVal as String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           move "VA" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           invoke self::batstube
       end method.  

       method-id playNet protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using netLoc as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           if netLoc = 'top-left'
               move 1 to PK320-NET-M-IN-X
               move 1 to PK320-NET-M-IN-Y
               move 1 to PK320-NET-M-OUT-X
               move 1 to PK320-NET-M-OUT-Y
           else
           if netLoc = 'top-center'
               move 2 to PK320-NET-M-IN-X
               move 1 to PK320-NET-M-IN-Y
               move 2 to PK320-NET-M-OUT-X
               move 1 to PK320-NET-M-OUT-Y
           else
           if netLoc = 'top-right'
               move 3 to PK320-NET-M-IN-X
               move 1 to PK320-NET-M-IN-Y
               move 3 to PK320-NET-M-OUT-X
               move 1 to PK320-NET-M-OUT-Y
           else
           if netLoc = 'bottom-left'
               move 1 to PK320-NET-M-IN-X
               move 2 to PK320-NET-M-IN-Y
               move 1 to PK320-NET-M-OUT-X
               move 2 to PK320-NET-M-OUT-Y
           else
           if netLoc = 'bottom-center'
               move 2 to PK320-NET-M-IN-X
               move 2 to PK320-NET-M-IN-Y
               move 2 to PK320-NET-M-OUT-X
               move 2 to PK320-NET-M-OUT-Y
           else
           if netLoc = 'bottom-right'
               move 3 to PK320-NET-M-IN-X
               move 2 to PK320-NET-M-IN-Y
               move 3 to PK320-NET-M-OUT-X
               move 2 to PK320-NET-M-OUT-Y.
           move "VN" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK320-WF-VID-COUNT = 0
               set returnVal to "er|" & "No clip at that location"
               exit method.
           invoke self::batstube.
       end method.

       method-id playRink protected.
       local-storage section.
       01 iNum         type Int16.
       01 vals     type String occurs 4.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           MOVE MOUSEX TO PK320-RINK-M-IN-X
           MOVE MOUSEX2 TO PK320-RINK-M-OUT-X
           MOVE MOUSEY TO PK320-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK320-RINK-M-OUT-Y
           IF MOUSEX = MOUSEX2 AND MOUSEY = MOUSEY2
               SUBTRACT 3 FROM PK320-RINK-M-IN-X
               SUBTRACT 3 FROM PK320-RINK-M-IN-Y
               ADD 3 TO PK320-RINK-M-OUT-X
               ADD 3 TO PK320-RINK-M-OUT-Y.
           move "R4" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.
           if PK320-WF-VID-COUNT = 0
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using xyVal as type String,
                          returning returnVal as type String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
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
           MOVE MOUSEX TO PK320-RINK-M-IN-X
           MOVE MOUSEX2 TO PK320-RINK-M-OUT-X
           MOVE MOUSEY TO PK320-RINK-M-IN-Y
           MOVE MOUSEY2 TO PK320-RINK-M-OUT-Y
       end method.

       method-id playField protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk320_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK320-FIELD-IP to num
           move "VF" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method
           END-IF    
           invoke self::batstube
           if PK320-WF-VID-COUNT = 0
               set returnVal to "er|" & "No video clips found"
               exit method
       end method.  

       method-id playSelected protected.
       local-storage section.
       01 num          type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set pk320rununit to self::Session::Item("320rununit")
               as type RunUnit
           move 0 to aa.
           if indexString = null
               exit method.
           invoke type Single::TryParse(indexString, reference num)
           SET PK320-SEL-LINES, PK320-LINE-IP to num + 1
           move "VL" to PK320-ACTION
           invoke pk320rununit::Call("PK320WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

       method-id li protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK322-CURR-P-NUM to num
           MOVE "P" to PK322-P-O-FLAG
      *     set returnVal to PK322-PLAYER-NAME(num)::Trim
       end method.  

       method-id lic protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           MOVE " " to PK322-PLAYER-NAME(num)
           move 0 to PK322-PLAYER-ID(num)
      *     set returnVal to PK322-PLAYER-NAME(num)::Trim
       end method.  

       method-id le protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK322-CURR-P-NUM to num
     	   MOVE "E" to PK322-EXCLUDE-FLAG
      *     set returnVal to PK322-X-PLAYER-NAME(num)::Trim

       end method.  

       method-id lec protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           MOVE " " to PK322-X-PLAYER-NAME(num)
           move 0 to PK322-X-PLAYER-ID(num)
      *     set returnVal to PK322-PLAYER-NAME(num)::Trim
       end method.  


       method-id oi protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK322-CURR-P-NUM to num
           MOVE "O" to PK322-P-O-FLAG
      *     set returnVal to PK322-PLAYER-NAME(num)::Trim
       end method.  

       method-id oic protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           MOVE " " to PK322-O-PLAYER-NAME(num)
           move 0 to PK322-O-PLAYER-ID(num)
       end method.  

       method-id oe protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           set PK322-CURR-P-NUM to num
     	   MOVE "E" to PK322-EXCLUDE-OPP-FLAG
           set returnVal to PK322-OPPONENT-TEAM

       end method.  

       method-id oec protected.
       local-storage section.
       01 num       type Single.
       linkage section.
           COPY "Y:\sydexsource\pucks\pk322_dg.CPB".  
       procedure division using fieldNum as type String
                           returning returnVal as String.
           set mydata322 to self::Session["pk322data"] as type pucksweb.pk322Data
           set address of PK322-DIALOG-FIELDS to mydata322::tablePointer
           set pk320rununit to self::Session::Item("320rununit") as
               type RunUnit
           invoke type System.Single::TryParse(fieldNum, by reference num)
           MOVE " " to PK322-X-O-PLAYER-NAME(num)
           move 0 to PK322-X-O-PLAYER-ID(num)
      *     set returnVal to PK322-PLAYER-NAME(num)::Trim
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
           COPY "Y:\SYDEXSOURCE\pucks\pk320_dg.CPB".
       procedure division.
           set mydata to self::Session["pk320data"] as type pucksweb.pk320Data
           set address of PK320-DIALOG-FIELDS to myData::tablePointer 
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > PK320-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & PK320-WF-VIDEO-PATH(aa)::Trim & "#t=" &  PK320-WF-VIDEO-START(AA) & "," & 
               (PK320-WF-VIDEO-START(AA) + PK320-WF-VIDEO-DURATION(AA)) & ";"
PM    *     set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-A(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
      *         (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM         set vidTitles to vidTitles & PK320-WF-VIDEO-TITL(aa) & ";"
           
           if PK320-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & PK320-WF-VIDEO-PATH(aa) & PK320-WF-VIDEO-B(aa) & "#t=" &  PK320-WF-VIDEO-START(AA) & "," & 
               (PK320-WF-VIDEO-START(AA) + PK320-WF-VIDEO-DURATION(AA)) & ";"
               set vidTitles to vidTitles & "B;".
           if PK320-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & PK320-WF-VIDEO-PATH(aa) & PK320-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if PK320-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & PK320-WF-VIDEO-PATH(aa) & PK320-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.
       end class.
