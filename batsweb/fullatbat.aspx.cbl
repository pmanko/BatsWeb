       class-id batsweb.fullatbat is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat666rununit         type RunUnit.
       01 BAT666WEBF                type BAT666WEBF.
       01 mydata type batsweb.bat666Data.
       method-id Page_Load protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           if (Request["__EVENTARGUMENT"] not = null and Request["__EVENTARGUMENT"] = "move")
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "alert", "callBatstube();", true).
           if self::IsPostBack
               exit method.
      *     invoke self::ClientScript::RegisterStartupScript(type of self, "yourMessage",
      *     'function HandleOnclose() {alert("Close Session"); PageMethods.CleanupPage();}'
      *      & 'window.onbeforeunload = HandleOnclose;', true)
           if  self::Session::Item("666rununit") not = null
               set bat666rununit to self::Session::Item("666rununit")
                   as type RunUnit
               else
               set bat666rununit to type RunUnit::New()
               set BAT666WEBF to new BAT666WEBF
               invoke bat666rununit::Add(BAT666WEBF)
               set self::Session::Item("666rununit") to  bat666rununit.

           invoke ListBox1::Attributes::Add("ondblclick", ClientScript::GetPostBackEventReference(ListBox1, "move"))
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           move "I" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           if BAT666-GAME-FLAG = "D"
               set startDateRadioButton::Checked to true
           else
               set allStartRadioButton::Checked to true.
           if BAT666-END-GAME-FLAG = "D"
               set endDateRadioButton::Checked to true
           else
               set allEndRadioButton::Checked to true.
           set textBox1::Text to BAT666-GAME-DATE::ToString("00/00/00")
           set textBox4::Text to BAT666-END-GAME-DATE::ToString("00/00/00")
           set pitcherTextBox::Text to BAT666-PITCHER
           set batterTextBox::Text to BAT666-BATTER
           set BAT666-PITCHER-TYPE-FLAG TO " "    
           set BAT666-BATTER-TYPE-FLAG TO " "    
           move 1 to aa.
       team-loop.
           if aa > BAT666-NUM-TEAMS
               go to team-done.
           invoke teamDropDownList::Items::Add(BAT666-TEAM-NAME(aa))
           invoke pTeamDropDownList::Items::Add(BAT666-TEAM-NAME(aa))
           invoke bTeamDropDownList::Items::Add(BAT666-TEAM-NAME(aa))
           add 1 to aa
           go to team-loop.
       team-done.
          move 1 to aa.
       runners-loop.
           if aa > DIALOG-RUN-NUM-ENTRIES
               go to runners-done.
           invoke Runners::Items::Add(DIALOG-RUN(AA)::Trim)
           add 1 to aa
           go to runners-loop.
       runners-done.
           move 1 to aa.
       outs-loop.
           if aa > DIALOG-OUT-NUM-ENTRIES
               go to outs-done.
           invoke Outs::Items::Add(DIALOG-OUT(AA)::Trim)
           add 1 to aa
           go to outs-loop.
       outs-done.
           move 1 to aa.
       inning-loop.
           if aa > DIALOG-INN-NUM-ENTRIES
               go to inning-done.
           invoke Innings::Items::Add(DIALOG-INNING-DESC(AA)::Trim)
           add 1 to aa
           go to inning-loop.
       inning-done.
           goback.
       end method.

       method-id Button5_Click protected.
       local-storage section.
       01 javaScript type System.Text.StringBuilder.
       01 confirmMessage type String.
       01 gmDate        type Single.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           invoke type System.Single::TryParse(TextBox1::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT666-GAME-DATE to gmDate
           invoke type System.Single::TryParse(TextBox4::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT666-END-GAME-DATE to gmDate
           MOVE "GO" to BAT668-ACTION
           MOVE "T" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")

           MOVE "RA" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.
       end method.
       
       method-id loadList protected.
       local-storage section.
       01 getVidPaths type String.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division.
           set getVidPaths to ""

           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           invoke ListBox1::Items::Clear.
           
           move 1 to aa.
       lines-loop.
           if aa > BAT666-NUM-AB
               go to lines-done.
           invoke ListBox1::Items::Add(" " & BAT666-T-LINE(aa))
           set getVidPaths to getVidPaths & BAT666-T-LINE(aa) & ","
           add 1 to aa.
           go to lines-loop.
       lines-done.     
      *     set ListBox1::TopIndex to ListBox1::Items::Count - 1.
           set self::Session::Item("testing") to getVidPaths
     
       end method.
       
       method-id ListBox1_SelectedIndexChanged protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       01 selected  type Int32[].
      *01 newListItem type ListItem.
       linkage section.
       COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       
       
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           initialize BAT666-T-AB-SEL-TBL
           move 0 to aa.
           set selected to ListBox1::GetSelectedIndices.
       videos-loop.
           if aa = selected::Count
               go to videos-done.
           MOVE "Y" TO BAT666-T-SEL(selected[aa] + 1).
           add 1 to aa.
           go to videos-loop.
       videos-done.
           MOVE "               00000000000" TO BAT666-I-KEY.
           MOVE "VS" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit") as type RunUnit

           invoke bat666rununit::Call("BAT666WEBF")
           
PM         set vidPaths to ""
PM         set vidTitles to ""
      *    invoke BulletedList2::Items::Clear
           move 1 to aa.
       lines-loop.
           if aa > BAT666-WF-VID-COUNT
               go to lines-done.
      *    set newListItem to new ListItem
      *    set newListItem::Text to BAT666-WF-VIDEO-TITL(AA) & " | " & BAT666-WF-VIDEO-A(aa) & ":" & BAT666-WF-VIDEO-B(aa) & ":" & BAT666-WF-VIDEO-C(aa) & ":" & BAT666-WF-VIDEO-D(aa)
      *    invoke newListItem::Attributes::Add("class", "list-group-item")
      *    invoke BulletedList2::Items::Add(newListItem)
           
PM         set vidPaths to vidPaths & BAT666-WF-VIDEO-PATH(aa) & BAT666-WF-VIDEO-A(aa) & ","
PM         set vidTitles to vidTitles & BAT666-WF-VIDEO-TITL(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
      *    set vid_paths::Value to getVidPaths
      *    set vid_titles::Value to getVidTitles
       end method.


       method-id Button1_Click protected.
       local-storage section.
       01 confirmMessage type String.
       procedure division using by value sender as object e as type System.EventArgs.
      *         invoke ClientScript::RegisterStartupScript(self::GetType, "myalert", "alert(confirmMessage)", true).
      *    declare mymsg = "This is a message!"
      *    invoke type System.Web.UI.ScriptManager::RegisterStartupScript(self, type of self, "yourMessage", "window.onload = function(){alert('" & mymsg & "');}", true)

       end method.

       method-id CleanupPage public static
       attribute System.Web.Services.WebMethod.
       local-storage section.
       01 confirmMessage type String.
       linkage section.
       procedure division.
           continue
      *      set bat666rununit to self::Session::Item("666rununit") as type rununit


     **          call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
      *         returning mem-flag
      *     set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           set confirmMessage to "Haltest"

      *     MOVE "X" TO BAT666-ACTION.
      *     invoke bat666rununit::Call("BAT666WEBF")

      *     invoke bat666rununit::StopRun.
      *     call "CBL_FREE_SHMEM" using  SH-BAT666-MEM-POINTER
           goback.
       end method.

       method-id allStartRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "A" to BAT666-GAME-FLAG
       end method.

       method-id startDateRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "D" to BAT666-GAME-FLAG
       end method.

       method-id allEndRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
          set mydata to self::Session["bat666data"] as type batsweb.bat666Data
          set address of BAT666-DIALOG-FIELDS to myData::tablePointer
          MOVE "A" to BAT666-END-GAME-FLAG
       end method.

       method-id endDateRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
        set mydata to self::Session["bat666data"] as type batsweb.bat666Data
        set address of BAT666-DIALOG-FIELDS to myData::tablePointer
        MOVE "A" to BAT666-END-GAME-FLAG
       end method.

       method-id maxAtBatsCheckBox_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer

           if maxAtBatsCheckBox::Checked
               move "Y" to BAT666-MAX-FLAG
               invoke maxABTextBox::Focus
           else
               move "N" to BAT666-MAX-FLAG.
       end method.

       method-id sortByInningCheckBox_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer

           if sortByInningCheckBox::Checked
               move "Y" to BAT666-SORT-FLAG
               set sortByBatterCheckBox::Checked to false
               set sortByOldCheckBox::Checked to false
           else
               move "N" to BAT666-SORT-FLAG.
       end method.

       method-id sortByBatterCheckBox_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer

           if sortByBatterCheckBox::Checked
               move "B" to BAT666-SORT-FLAG
               set sortByInningCheckBox::Checked to false
               set sortByOldCheckBox::Checked to false
           else
               move "N" to BAT666-SORT-FLAG.
       end method.

       method-id sortByOldCheckBox_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer

           if sortByOldCheckBox::Checked
               move "O" to BAT666-SORT-FLAG
               set sortByBatterCheckBox::Checked to false
               set sortByInningCheckBox::Checked to false
           else
               move "N" to BAT666-SORT-FLAG.
       end method.

       method-id allGamesButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "A" to BAT666-DATE-CHOICE-FLAG
           MOVE "A" to BAT666-GAME-FLAG
           MOVE "A" to BAT666-END-GAME-FLAG
           set allStartRadioButton::Checked to true
           set allEndRadioButton::Checked to true
       end method.

       method-id currentYearButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "C" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")

           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id pastYearButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "P" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id twoWeeksButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "W" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")

           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id currentMonthButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "M" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id twoMonthsButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "2" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id threeMonthsButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "3" to BAT666-DATE-CHOICE-FLAG
           MOVE "DC" to BAT666-ACTION
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE "D" to BAT666-GAME-FLAG
           MOVE "D" to BAT666-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set TextBox1::Text to BAT666-GAME-DATE::ToString("##/##/##").
           set TextBox4::Text to BAT666-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id teamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set BAT666-SEL-TEAM to teamDropDownList::SelectedItem
           
         if BAT666-IND-PB-FLAG = "P"
            MOVE BAT666-SEL-TEAM TO BAT666-PITCHER-ROSTER-TEAM
            MOVE "RP" TO BAT668-ACTION  
            MOVE "T" TO BAT666-ACTION
         else
            MOVE BAT666-SEL-TEAM TO BAT666-BATTER-ROSTER-TEAM
            MOVE "RB" TO BAT668-ACTION  
            MOVE "T" TO BAT666-ACTION
         end-if.
         
           set bat666rununit to self::Session::Item("666rununit") as
               type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           invoke playerListBox::Items::Clear.
           move 1 to aa.
       5-loop.
           if aa > BAT666-ROSTER-NUM-ENTRIES
               go to 10-done
           else
               invoke playerListBox::Items::Add(" " & BAT666-ROSTER-NAME(aa) & " " & BAT666-ROSTER-POS(aa)).
           add 1 to aa.
           go to 5-loop.
       10-done.
      *     set playernamelb::TopIndex to playernamelb::Items::Count - 1.
       end method.

       method-id playerOKButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           if BAT666-IND-PB-FLAG = "P"
               move BAT666-SEL-TEAM to BAT666-PITCHER-ROSTER-TEAM  
               move BAT666-SEL-PLAYER to BAT666-PITCHER-DSP-NAME  
           else
               MOVE BAT666-SEL-TEAM TO BAT666-BATTER-ROSTER-TEAM
               MOVE BAT666-SEL-PLAYER TO BAT666-BATTER-DSP-NAME  
           end-if.
           move "TI" to BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE " " to BAT666-IND-PB-FLAG   
           set pitcherTextBox::Text to BAT666-PITCHER
           set batterTextBox::Text to BAT666-BATTER
       end method.

       method-id playerListBox_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE playerListBox::SelectedItem to BAT666-SEL-PLAYER
      *     SET selectedplayerlabel::Text to BAT666-SEL-PLAYER
           
           if BAT666-IND-PB-FLAG = "P" THEN
               MOVE BAT666-ROSTER-ID(playerListBox::SelectedIndex + 1) TO BAT666-SAVE-PITCHER-ID
           ELSE
               MOVE BAT666-ROSTER-ID(playerListBox::SelectedIndex + 1) TO BAT666-SAVE-BATTER-ID
           END-IF.
       end method.

       method-id pPlayerButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "I " TO BAT666-PITCHER-FLAG  
           MOVE "P" TO BAT666-IND-PB-FLAG  
           MOVE "RP" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE " " TO BAT666-SEL-TEAM
           invoke pitcherOKButton_ModalPopupExtender::Show.
           set teamDropDownList::SelectedIndex to 0
       end method.

       method-id bPlayerButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "I " TO BAT666-BATTER-FLAG  
           MOVE "B" TO BAT666-IND-PB-FLAG  
           MOVE "RP" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE " " TO BAT666-SEL-TEAM
           invoke pitcherOKButton_ModalPopupExtender::Show.
           set teamDropDownList::SelectedIndex to 0
       end method.

       method-id Result1_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           set BAT666-RES-IDX to Result1::SelectedIndex
           set BAT666-RESULT1 TO Result1::SelectedItem
           add 1 to BAT666-RES-IDX
           MOVE "RA" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.       
       end method.

       method-id Result2_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           set BAT666-RES-IDX2 to Result1::SelectedIndex
           set BAT666-RESULT2 TO Result1::SelectedItem
           add 1 to BAT666-RES-IDX2
           MOVE "RA" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.     
       end method.

       method-id Runners_SelectedIndexChanged protected.
       linkage section.       
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           set DIALOG-RUN-MASTER to Runners::SelectedItem
           set DIALOG-RUN-IDX to Runners::SelectedIndex
           add 1 to DIALOG-RUN-IDX
           MOVE "RA" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.  
       end method.

       method-id Innings_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           set DIALOG-INN-MASTER to Innings::SelectedItem
           set DIALOG-INN-IDX to Innings::SelectedIndex
           add 1 to DIALOG-INN-IDX
           MOVE "RA" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.  
       end method.

       method-id Outs_SelectedIndexChanged protected.
       linkage section.       
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           set DIALOG-OUT-MASTER to Outs::SelectedItem
           set DIALOG-OUT-IDX to Outs::SelectedIndex
           add 1 to DIALOG-OUT-IDX
           MOVE "RA" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke self::loadList.
       end method.

       method-id resetButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           move 0 to result1::SelectedIndex
           set BAT666-RES-IDX to (Result1::SelectedIndex + 1)
           set BAT666-RESULT1 TO Result1::SelectedItem
           move 0 to result2::SelectedIndex
           set BAT666-RES-IDX2 to (Result2::SelectedIndex + 1)
           set BAT666-RESULT2 TO Result2::SelectedItem
           move 0 to runners::SelectedIndex
           set DIALOG-RUN-MASTER to Outs::SelectedItem
           set DIALOG-RUN-IDX to (Outs::SelectedIndex + 1)           
           move 0 to outs::SelectedIndex
           set DIALOG-OUT-MASTER to Outs::SelectedItem
           set DIALOG-OUT-IDX to (Outs::SelectedIndex + 1)
           move 0 to innings::SelectedIndex
           set DIALOG-INN-MASTER to Outs::SelectedItem
           set DIALOG-INN-IDX to (Outs::SelectedIndex + 1)
           MOVE "RA" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           INVOKE self::loadList.   
       end method.

       method-id pAllLeftButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "AL" TO BAT666-PITCHER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET pCurrentSelection::Text to BAT666-PITCHER::Trim
           set pitcherTextBox::Text to BAT666-PITCHER
       end method.

       method-id pAllButton_Click protected.
        linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "A" TO BAT666-PITCHER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET pCurrentSelection::Text to BAT666-PITCHER::Trim
           set pitcherTextBox::Text to BAT666-PITCHER
       end method.

       method-id pAllRightButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "AR" TO BAT666-PITCHER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET pCurrentSelection::Text to BAT666-PITCHER::Trim
           set pitcherTextBox::Text to BAT666-PITCHER
       end method.

       method-id bAllLeftButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "AL" TO BAT666-BATTER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET bCurrentSelection::Text to BAT666-BATTER::Trim
           set batterTextBox::Text to BAT666-BATTER
       end method.

       method-id bAllButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "A" TO BAT666-BATTER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET bCurrentSelection::Text to BAT666-BATTER::Trim
           set batterTextBox::Text to BAT666-BATTER
       end method.

       method-id bAllRightButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "AR" TO BAT666-BATTER-FLAG
           MOVE "TI" TO BAT668-ACTION  
           MOVE "T" TO BAT666-ACTION  
           invoke bat666rununit::Call("BAT666WEBF")
           SET bCurrentSelection::Text to BAT666-BATTER::Trim
           set batterTextBox::Text to BAT666-BATTER
       end method.

       method-id pTeamButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "T " to BAT666-PITCHER-FLAG
           invoke pHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id pTeamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set BAT666-PITCHER-TEAM to pTeamDropDownList::SelectedItem.
           invoke pHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id pTeamOKButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "T" to BAT666-ACTION
           MOVE "TI" to BAT668-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           SET pCurrentSelection::Text to BAT666-PITCHER::Trim
           set pitcherTextBox::Text to BAT666-PITCHER
       end method.

       method-id pTeamLeftButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "TL" to BAT666-PITCHER-FLAG
           invoke pHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id pTeamRightButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "TR" to BAT666-PITCHER-FLAG
           invoke pHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id bTeamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set BAT666-BATTER-TEAM to bTeamDropDownList::SelectedItem.
           invoke bHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id bTeamOKButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           set bat666rununit to self::Session::Item("666rununit")
               as type RunUnit
           MOVE "T" to BAT666-ACTION
           MOVE "TI" to BAT668-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           SET bCurrentSelection::Text to BAT666-BATTER::Trim
           set batterTextBox::Text to BAT666-BATTER
       end method.

       method-id bTeamButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "T " to BAT666-BATTER-FLAG
           invoke bHiddenFieldTeam_ModalPopupExtender::Show
       end method.
       
       method-id bTeamLeftButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "TL" to BAT666-BATTER-FLAG
           invoke bHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       method-id bTeamRightButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat666data"] as type batsweb.bat666Data
           set address of BAT666-DIALOG-FIELDS to myData::tablePointer
           MOVE "TR" to BAT666-BATTER-FLAG
           invoke bHiddenFieldTeam_ModalPopupExtender::Show
       end method.

       end class.