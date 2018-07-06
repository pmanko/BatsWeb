       class-id batsweb.ezVideoFull is partial 
                implements type System.Web.UI.ICallbackEventHandler
                inherits type System.Web.UI.Page public.
 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT PLAY-FILE ASSIGN LK-PLAYER-FILE
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS PLAY-KEY
              ALTERNATE KEY IS PLAY-ALT-KEY WITH DUPLICATES
              LOCK MANUAL
              FILE STATUS IS STATUS-COMN.
       DATA DIVISION.
       FILE SECTION.
       COPY "Y:\SYDEXSOURCE\FDS\FDPLAY.CBL".                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat130virununit         type RunUnit.
       01 BAT130VIWEBF                type BAT130VIWEBF.
       01 mydata type batsweb.bat130viData.
       01 gmDate        type Single.
       01 callbackReturn type String.
       01 nameArray      type String.       
       01 playerName      type String.
       
       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.   
       linkage section.
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".              
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
                                                                        
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####           
        
           if self::IsPostBack
               invoke self::populateTeam
               invoke self::loadList           
               exit method.
               
      *    Setup - from main menu                          
           SET self::Session::Item("database") to self::Request::QueryString["league"]
      *     if   self::Session["bat130vidata"] = null
              set mydata to new batsweb.bat130viData
              invoke mydata::populateData
              set self::Session["bat130vidata"] to mydata
      *     else
      *         set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData.
           
           if  self::Session::Item("130virununit") not = null
               set bat130virununit to self::Session::Item("130virununit")
               as type RunUnit
                ELSE
                set bat130virununit to type RunUnit::New()
                set BAT130VIWEBF to new BAT130VIWEBF
                invoke bat130virununit::Add(BAT130VIWEBF)
                set self::Session::Item("130virununit") to  bat130virununit.

           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer
           move "IN" to BAT130VI-ACTION
           invoke bat130virununit::Call("BAT130VIWEBF")
           move "I" to BAT130VI-ACTION
           invoke bat130virununit::Call("BAT130VIWEBF")
           set textBox1::Text to BAT130VI-END-GAME-DATE::ToString("00/00/00")
           move 1 to aa.
       team-loop.
           if aa > BAT130VI-NUM-TEAMS
               go to team-done.
           if BAT130VI-TEAM-NAME(aa) alphabetic
                  invoke teamDropDownList::Items::Add(BAT130VI-TEAM-NAME(aa)).
           add 1 to aa
           go to team-loop.           
       team-done.    
           invoke self::populateTeam().                                         
           
           SET LK-PLAYER-FILE TO BAT130VI-WF-LK-PLAYER-FILE
           open input play-file.
           initialize play-alt-key
           start play-file key > play-alt-key
               invalid key
               go to 10-done.           
           move 1 to aa.     
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
      *     invoke self::loadList           
           goback.
       end method.
 
      *#####               Client Callback Implementation             #####
      *##### (https://msdn.microsoft.com/en-us/library/ms178208.aspx) #####
      *####################################################################
 
       method-id RaiseCallbackEvent public.
       local-storage section.
       01 actionFlag type String.
       01 methodArg type String.       

       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           set callbackReturn to "hal"
           if actionFlag = 'update-video'
               set callbackReturn to actionFlag & "|" & self::videoSelected(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
      *####################################################################

       method-id teamDropDownList_SelectedIndexChanged protected.
       procedure division using by value sender as object e as type System.EventArgs.
           invoke self::populateTeam.     
       end method.
       
       method-id populateTeam protected.
       local-storage section.
           01 dataLine             type String.       
       linkage section.
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".       
       procedure division.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set BAT130VI-SEL-TEAM to teamDropDownList::SelectedItem
           MOVE "RP" to BAT130VI-ACTION
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.           
       
           invoke playerTable::Rows::Clear()

           move 1 to aa.
       5-loop.
           if aa > BAT130VI-NUM-PLAYERS
               go to 10-done
           else
      *         invoke playerListBox::Items::Add(" " & BAT666-ROSTER-NAME(aa) & " " & BAT666-ROSTER-POS(aa))
               set dataLine to (BAT130VI-ROSTER-NAME(aa) & " " & BAT130VI-ROSTER-POS(aa) & " " & BAT130VI-ROSTER-ID(aa)).
               invoke self::addTableRow(playerTable, " " & dataline, 'b').
           add 1 to aa.
           go to 5-loop.
       10-done.

       end method.

       method-id player_Selected protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".       
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           
      *    if team is changed instead of ok button
           if playerIndexField::Value = spaces
               exit method.
           invoke type System.Single::TryParse(TextBox1::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT130VI-END-GAME-DATE to gmDate.               
           move playerValueField::Value to BAT130VI-I-NAME.
       
      *    MOVE BAT666-ROSTER-NAME(self::getSelectedIndex(indexString)) to BAT666-SEL-PLAYER.
      *     SET selectedplayerlabel::Text to BAT666-SEL-PLAYER
           MOVE BAT130VI-ROSTER-ID(type Int32::Parse(playerIndexField::Value) + 1) TO BAT130VI-I-ID
           MOVE "RC" to BAT130VI-ACTION
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           INVOKE self::loadList.           
       end method.
 
       method-id showButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".       
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke type System.Single::TryParse(TextBox1::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT130VI-END-GAME-DATE to gmDate.               
           if playerValueField::Value = spaces
               SET LK-PLAYER-FILE TO BAT130VI-WF-LK-PLAYER-FILE
               MOVE SPACES TO PLAY-ALT-KEY
               unstring locatePlayerTextBox::Text delimited ", " into play-last-name, play-first-name
               open input play-file
               READ PLAY-FILE KEY PLAY-ALT-KEY
               set BAT130VI-I-NAME to play-first-name::Trim & " " & play-last-name 
               MOVE play-player-id to BAT130VI-LOCATE-SEL-ID
               move "LP" to BAT130VI-ACTION
               invoke bat130virununit::Call("BAT130VIWEBF")
               if ERROR-FIELD NOT = SPACES
                   invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
                   move spaces to ERROR-FIELD
               END-IF    
               CLOSE PLAY-FILE
           ELSE    
               MOVE "RC" to BAT130VI-ACTION
               invoke bat130virununit::Call("BAT130VIWEBF").
           MOVE SPACES TO playerValueField::Value
           INVOKE self::loadList.           
       end method.
       
       method-id showvideobutton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat130vi_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
      *    if playerlistBox::SelectedItem = null
      *        invoke message-box::Show ("You must select a player." "Warning" message-button::"OK")
      *        exit method.
           MOVE "RC" to BAT130VI-ACTION
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           INVOKE self::loadList.      
       end method.
       
       method-id loadList protected.
       local-storage section.
           01 dataLine             type String.   
       linkage section.
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".       
       procedure division.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set nameValue::Text to BAT130VI-I-NAME::Trim
           set batsValue::Text to BAT130VI-I-BATS
           set throwsValue::Text to BAT130VI-I-THROWS
           set posValue1::Text to BAT130VI-I-POS1
           set posValue2::Text to BAT130VI-I-POS2
           set posValue3::Text to BAT130VI-I-POS3
           invoke videoTable::Rows::Clear()
           move 1 to aa.
       lines-loop.
           if aa > BAT130VI-NUM-VIDEOS
               go to lines-done.
      *     INSPECT BAT666-T-LINE(AA) REPLACING ALL " " BY X'A0'
           
           set dataLine to(BAT130VI-V-DATE(aa)::ToString("##/##/##") & " " & BAT130VI-V-DESC(aa))
           invoke self::addTableRow(videoTable, " " & dataline, 'b').
      *     set getVidPaths to getVidPaths & BAT666-T-LINE(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.     
      *     set self::Session::Item("testing") to getVidPaths
     
       end method.
       
       method-id videosDropDownList_SelectedIndexChanged protected.
       linkage section.       
           COPY "Y:\sydexsource\BATS\bat130vi_dg.CPB".       
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set BAT130VI-VIDEO-SELECTION to videosDropDownList::SelectedItem
           move "SE" to BAT130VI-ACTION.
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           INVOKE self::loadList.      
       end method.       
       
       
       method-id searchButton_Click protected.
       linkage section.       
           COPY "Y:\SYDEXSOURCE\BATS\bat130vi_dg.CPB". 
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set BAT130VI-ADVANCED-1 TO search1textBox::Text::Trim
           set BAT130VI-ADVANCED-2 TO search2textBox::Text::Trim
           MOVE "Advanced" to BAT130VI-VIDEO-SELECTION
           MOVE "SE" TO BAT130VI-ACTION
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           INVOKE self::loadList.      
       end method.
    
       method-id resetButton_Click protected.
       linkage section.       
           COPY "Y:\SYDEXSOURCE\BATS\bat130vi_dg.CPB". 
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           move spaces to BAT130VI-ADVANCED-1, BAT130VI-ADVANCED-2
           set search1textBox::Text to ""
           set search2textBox::Text to ""
           set BAT130VI-VIDEO-SELECTION to videosDropDownList::SelectedItem
           MOVE "SE" TO BAT130VI-ACTION
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           invoke bat130virununit::Call("BAT130VIWEBF")
           INVOKE self::loadList.      
       end method.       
       
       method-id videoSelected protected.
       local-storage section.
       01 selected  type Int32[].
       linkage section.       
           COPY "Y:\SYDEXSOURCE\BATS\bat130vi_dg.CPB". 
       procedure division using by value indexString as type String 
                          returning atBatReturn as type String.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           move 0 to aa.
           set selected to self::getSelectedIndeces(indexString).
           MOVE " " TO BAT130VI-VIDEO-PLAY-TBL.
               
       videos-loop.
           if aa = selected::Count
               go to videos-done.
           MOVE "Y" to BAT130VI-V-PLAY-FLAG(selected[aa] + 1).
           add 1 to aa.
           go to videos-loop.
       videos-done.
           
           MOVE "VP" to BAT130VI-ACTION
           invoke bat130virununit::Call("BAT130VIWEBF")
           if ERROR-FIELD NOT = SPACES
               set atBatReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.                             
           invoke self::batstube.
               
       end method.
     
       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat130vi_dg.CPB". 
       procedure division.
           set mydata to self::Session["bat130vidata"] as type batsweb.bat130viData
           set address of BAT130VI-DIALOG-FIELDS to myData::tablePointer 
           set bat130virununit to self::Session::Item("130virununit") as
               type RunUnit
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > BAT130VI-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & BAT130VI-WF-VIDEO-PATH(aa) & BAT130VI-WF-VIDEO-A(aa) & ";"
PM         set vidTitles to vidTitles & BAT130VI-WF-VIDEO-TITL(aa) & ";"
           
           if BAT130VI-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & BAT130VI-WF-VIDEO-PATH(aa) & BAT130VI-WF-VIDEO-B(aa) & ";"
               set vidTitles to vidTitles & "B;".
           if BAT130VI-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & BAT130VI-WF-VIDEO-PATH(aa) & BAT130VI-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if BAT130VI-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & BAT130VI-WF-VIDEO-PATH(aa) & BAT130VI-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.

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

       end class.
