       class-id batsweb.gameSummary is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.
       
       method-id Page_Load protected.
       local-storage section.
           01 dataLine             type String.
           01 gameNum              pic x.
       LINKAGE SECTION.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.

           if self::IsPostBack
               exit method.
           invoke self::ClientScript::RegisterStartupScript(type of self, "yourMessage",
           'function HandleOnclose() {alert("Close Session"); PageMethods.CleanupPage();}'
            & 'window.onbeforeunload = HandleOnclose;', true)
           if  self::Session::Item("360rununit") not = null
               set bat360rununit to self::Session::Item("360rununit")
                   as type RunUnit
                ELSE
                set bat360rununit to type RunUnit::New()
                set BAT360WEBF to new BAT360WEBF
                invoke bat360rununit::Add(BAT360WEBF)
                set self::Session::Item("360rununit") to  bat360rununit.
           invoke ListBox2::Attributes::Add("ondblclick", ClientScript::GetPostBackEventReference(ListBox2, "move"))
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer
           set label1::Text to label1::Text::Replace(" ", "&nbsp;")
           set gamesHeader::Text to gamesHeader::Text::Replace(" ", "&nbsp;")
           move "I" to BAT360-ACTION
           move "I" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if BAT360-GAMES-CHOICE = " "
               set allRadioButton::Checked to true
           else if BAT360-GAMES-CHOICE = "N"
               set nlRadioButton::Checked to true
           else if BAT360-GAMES-CHOICE = "M"
               set alRadioButton::Checked to true
           else if BAT360-GAMES-CHOICE = "T"
               set teamRadioButton::Checked to true.
           invoke self::loadGames.
           move 1 to aa.
       team-loop.
           if aa > BAT360-NUM-TEAMS
               go to team-done.
           invoke teamDropDownList::Items::Add(BAT360-TEAM-NAME(aa))
           add 1 to aa
           go to team-loop.
       team-done.
           if BAT360-GAME-SEL-YR not = zeroes
               set yearDropDownList::Text to BAT360-GAME-SEL-YR::ToString
           else
               set yearDropDownList::Text to type DateTime::Today::Year::ToString.
           goback.
       end method.
       
       method-id loadGames protected.
       local-storage section.
           01 dataLine             type String.
           01 gameNum              pic x.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           invoke listbox1::Items::Clear.
           move 1 to aa.
       games-loop.
           if aa > BAT360-NUM-GAMES
               go to games-done
           else
               if BAT360-G-NUM(AA) = 0
                   move space to gameNum
               else
                   move BAT360-G-NUM(AA) to gameNum
               end-if
               Set dataLine to BAT360-G-DSP-DATE(aa)::ToString("0#/##/##") & " "
                  & gameNum & " " & BAT360-G-VIS(aa) & " "
                  & BAT360-G-HOME(aa) & " " & BAT360-G-TIME(aa)
               INSPECT dataline REPLACING ALL " " BY X'A0'
               invoke listbox1::Items::Add(dataLine).
           add 1 to aa
           go to games-loop.
       games-done.
       end method.

       method-id inningsButton_Click protected.
       local-storage section.
       01 WS-DATA-LINE.
           05  WS-DATA-L PIC X(39).
           05  WS-ASTERISK PIC X.
           05  WS-DATA-R PIC X(39).
       
       01 WS-DATA-LINE2.
           05  WS2-DATA-L PIC X(39).
           05  WS2-ASTERISK PIC X.
           05  WS2-DATA-R PIC X(39).
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer
           MOVE BAT360-G-GAME-DATE(BAT360-SEL-GAME) to BAT360-I-GAME-DATE
           MOVE BAT360-G-GAME-ID(BAT360-SEL-GAME) to BAT360-I-GAME-ID
           MOVE "RA" to BAT360-ACTION
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit

           invoke bat360rununit::Call("BAT360WEBF")
           invoke listbox2::Items::Clear.

           move 1 to aa.
       ab-loop.
           if aa > BAT360-NUM-AB
               go to ab-done
           else
               MOVE BAT360-AB-LINE(AA) TO WS-DATA-LINE, WS-DATA-LINE2
               MOVE SPACES TO WS-ASTERISK
      *        IF WS-DATA-L = SPACES
                   INSPECT WS-DATA-LINE REPLACING ALL " " BY X'A0'
      *        END-IF
               invoke listbox2::Items::Add(WS-DATA-LINE).
      *        IF AA > 1
                   IF WS2-DATA-L = SPACES
                       invoke listbox2::Items[aa - 1]::Attributes::Add("style", "color:blue")
                   ELSE
                       Invoke listbox2::Items[aa - 1]::Attributes::Add("style", "color:blue")
                   END-IF
      *        END-IF   
           add 1 to aa
           go to ab-loop.
       ab-done.
           invoke listbox3::Items::Clear
           move 1 to aa.
       5-loop.
           if aa > BAT360-NUM-T-LINES
               go to 10-done
           else
               INSPECT BAT360-T-LINE(aa) REPLACING ALL " " BY X'A0'
               invoke listbox3::Items::Add(BAT360-T-LINE(aa)).
           add 1 to aa
           go to 5-loop.
       10-done.
       end method.

       method-id allRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE " " to BAT360-GAMES-CHOICE
           MOVE "RG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames.
       end method.

       method-id teamRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "T" to BAT360-GAMES-CHOICE
           if BAT360-GAMES-TEAM = spaces
               exit method.
           MOVE "RG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames.
       end method.

       method-id nlRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "N" to BAT360-GAMES-CHOICE
           MOVE "RG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames.
       end method.

       method-id alRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "M" to BAT360-GAMES-CHOICE
           MOVE "RG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames.
       end method.

       method-id teamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set BAT360-GAMES-TEAM TO teamDropDownList::SelectedItem    
           if BAT360-GAMES-CHOICE = "T"
               MOVE "RG" to BAT360-ACTION
               invoke bat360rununit::Call("BAT360WEBF")
               invoke self::loadGames.
       end method.

       method-id pitchersCheckBox_CheckedChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if pitchersCheckBox::Checked
               MOVE "Y" to BAT360-STARTING-PITCHERS
               MOVE "RG" to BAT360-ACTION
           else
               MOVE "N" to BAT360-STARTING-PITCHERS
               MOVE "RG" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames
       end method.

       method-id yearDropDownList_SelectedIndexChanged protected.
       local-storage section.
       01 seasonYear       type Single.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type System.Single::TryParse(yearDropDownList::Text::ToString, by reference seasonYear)
           set BAT360-GAME-SEL-YR to seasonYear
           MOVE "RG" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::loadGames
       end method.

       method-id visButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "SV" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           if BAT360-V-ROSTER-NAME(1) not = spaces
               set Button1::Visible to true
               set Button1::Text to BAT360-V-ROSTER-NAME(1)::Trim. 
           if BAT360-V-ROSTER-NAME(2) not = spaces
               set Button2::Visible to true
               set Button2::Text to BAT360-V-ROSTER-NAME(2)::Trim. 
           if BAT360-V-ROSTER-NAME(3) not = spaces
               set Button3::Visible to true
               set Button3::Text to BAT360-V-ROSTER-NAME(3)::Trim. 
           if BAT360-V-ROSTER-NAME(4) not = spaces
               set Button4::Visible to true
               set Button4::Text to BAT360-V-ROSTER-NAME(4)::Trim. 
           if BAT360-V-ROSTER-NAME(5) not = spaces
               set Button5::Visible to true
               set Button5::Text to BAT360-V-ROSTER-NAME(5)::Trim. 
           if BAT360-V-ROSTER-NAME(6) not = spaces
               set Button6::Visible to true
               set Button6::Text to BAT360-V-ROSTER-NAME(6)::Trim. 
           if BAT360-V-ROSTER-NAME(7) not = spaces
               set Button7::Visible to true
               set Button7::Text to BAT360-V-ROSTER-NAME(7)::Trim. 
           if BAT360-V-ROSTER-NAME(8) not = spaces
               set Button8::Visible to true
               set Button8::Text to BAT360-V-ROSTER-NAME(8)::Trim. 
           if BAT360-V-ROSTER-NAME(9) not = spaces
               set Button9::Visible to true
               set Button9::Text to BAT360-V-ROSTER-NAME(9)::Trim. 
           if BAT360-V-ROSTER-NAME(10) not = spaces
               set Button10::Visible to true
               set Button10::Text to BAT360-V-ROSTER-NAME(10)::Trim. 
           if BAT360-V-ROSTER-NAME(11) not = spaces
               set Button11::Visible to true
               set Button11::Text to BAT360-V-ROSTER-NAME(11)::Trim. 
           if BAT360-V-ROSTER-NAME(12) not = spaces
               set Button12::Visible to true
               set Button12::Text to BAT360-V-ROSTER-NAME(12)::Trim. 
           if BAT360-V-ROSTER-NAME(13) not = spaces
               set Button13::Visible to true
               set Button13::Text to BAT360-V-ROSTER-NAME(13)::Trim. 
           if BAT360-V-ROSTER-NAME(14) not = spaces
               set Button14::Visible to true
               set Button14::Text to BAT360-V-ROSTER-NAME(14)::Trim. 
           if BAT360-V-ROSTER-NAME(15) not = spaces
               set Button15::Visible to true
               set Button15::Text to BAT360-V-ROSTER-NAME(15)::Trim. 
           if BAT360-V-ROSTER-NAME(16) not = spaces
               set Button16::Visible to true
               set Button16::Text to BAT360-V-ROSTER-NAME(16)::Trim. 
           if BAT360-V-ROSTER-NAME(17) not = spaces
               set Button17::Visible to true
               set Button17::Text to BAT360-V-ROSTER-NAME(17)::Trim. 
           if BAT360-V-ROSTER-NAME(18) not = spaces
               set Button18::Visible to true
               set Button18::Text to BAT360-V-ROSTER-NAME(18)::Trim. 
           if BAT360-V-ROSTER-NAME(19) not = spaces
               set Button19::Visible to true
               set Button19::Text to BAT360-V-ROSTER-NAME(19)::Trim. 
           if BAT360-V-ROSTER-NAME(20) not = spaces
               set Button20::Visible to true
               set Button20::Text to BAT360-V-ROSTER-NAME(20)::Trim. 
           if BAT360-V-ROSTER-NAME(21) not = spaces
               set Button21::Visible to true
               set Button21::Text to BAT360-V-ROSTER-NAME(21)::Trim. 
           if BAT360-V-ROSTER-NAME(22) not = spaces
               set Button22::Visible to true
               set Button22::Text to BAT360-V-ROSTER-NAME(22)::Trim. 
           if BAT360-V-ROSTER-NAME(23) not = spaces
               set Button23::Visible to true
               set Button23::Text to BAT360-V-ROSTER-NAME(23)::Trim. 
           if BAT360-V-ROSTER-NAME(24) not = spaces
               set Button24::Visible to true
               set Button24::Text to BAT360-V-ROSTER-NAME(24)::Trim. 
           if BAT360-V-ROSTER-NAME(25) not = spaces
               set Button25::Visible to true
               set Button25::Text to BAT360-V-ROSTER-NAME(25)::Trim. 
           if BAT360-V-ROSTER-NAME(26) not = spaces
               set Button26::Visible to true
               set Button26::Text to BAT360-V-ROSTER-NAME(26)::Trim. 
           if BAT360-V-ROSTER-NAME(27) not = spaces
               set Button27::Visible to true
               set Button27::Text to BAT360-V-ROSTER-NAME(27)::Trim. 
           if BAT360-V-ROSTER-NAME(28) not = spaces
               set Button28::Visible to true
               set Button28::Text to BAT360-V-ROSTER-NAME(28)::Trim. 
           if BAT360-V-ROSTER-NAME(29) not = spaces
               set Button29::Visible to true
               set Button29::Text to BAT360-V-ROSTER-NAME(29)::Trim. 
           if BAT360-V-ROSTER-NAME(30) not = spaces
               set Button30::Visible to true
               set Button30::Text to BAT360-V-ROSTER-NAME(30)::Trim. 
      *     invoke HiddenField1Vis_ModalPopupExtender::Show.
       end method.

       method-id homeButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "SV" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           if BAT360-V-ROSTER-NAME(1) not = spaces
               set Button1::Visible to true
               set Button1::Text to BAT360-V-ROSTER-NAME(1)::Trim. 
           if BAT360-V-ROSTER-NAME(2) not = spaces
               set Button2::Visible to true
               set Button2::Text to BAT360-V-ROSTER-NAME(2)::Trim. 
           if BAT360-V-ROSTER-NAME(3) not = spaces
               set Button3::Visible to true
               set Button3::Text to BAT360-V-ROSTER-NAME(3)::Trim. 
           if BAT360-V-ROSTER-NAME(4) not = spaces
               set Button4::Visible to true
               set Button4::Text to BAT360-V-ROSTER-NAME(4)::Trim. 
           if BAT360-V-ROSTER-NAME(5) not = spaces
               set Button5::Visible to true
               set Button5::Text to BAT360-V-ROSTER-NAME(5)::Trim. 
           if BAT360-V-ROSTER-NAME(6) not = spaces
               set Button6::Visible to true
               set Button6::Text to BAT360-V-ROSTER-NAME(6)::Trim. 
           if BAT360-V-ROSTER-NAME(7) not = spaces
               set Button7::Visible to true
               set Button7::Text to BAT360-V-ROSTER-NAME(7)::Trim. 
           if BAT360-V-ROSTER-NAME(8) not = spaces
               set Button8::Visible to true
               set Button8::Text to BAT360-V-ROSTER-NAME(8)::Trim. 
           if BAT360-V-ROSTER-NAME(9) not = spaces
               set Button9::Visible to true
               set Button9::Text to BAT360-V-ROSTER-NAME(9)::Trim. 
           if BAT360-V-ROSTER-NAME(10) not = spaces
               set Button10::Visible to true
               set Button10::Text to BAT360-V-ROSTER-NAME(10)::Trim. 
           if BAT360-V-ROSTER-NAME(11) not = spaces
               set Button11::Visible to true
               set Button11::Text to BAT360-V-ROSTER-NAME(11)::Trim. 
           if BAT360-V-ROSTER-NAME(12) not = spaces
               set Button12::Visible to true
               set Button12::Text to BAT360-V-ROSTER-NAME(12)::Trim. 
           if BAT360-V-ROSTER-NAME(13) not = spaces
               set Button13::Visible to true
               set Button13::Text to BAT360-V-ROSTER-NAME(13)::Trim. 
           if BAT360-V-ROSTER-NAME(14) not = spaces
               set Button14::Visible to true
               set Button14::Text to BAT360-V-ROSTER-NAME(14)::Trim. 
           if BAT360-V-ROSTER-NAME(15) not = spaces
               set Button15::Visible to true
               set Button15::Text to BAT360-V-ROSTER-NAME(15)::Trim. 
      *     set homeButton_PopupControlExtender::Visible to true
       end method.

       method-id ListBox2_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set BAT360-SEL-AB to ListBox2::SelectedIndex
           add 1 to BAT360-SEL-AB
           MOVE BAT360-SEL-AB to BAT360-AB-IP
           MOVE BAT360-AB-KEY(BAT360-SEL-AB) to BAT360-I-KEY
       end method.

       method-id fromSelected_Click protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if BAT360-AB-IP = 0
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('No starting point is highlighted!');", true)
               exit method.   
           IF BAT360-REC-TYPE(BAT360-SEL-AB) NOT = "B"
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You cannot select a header field!');", true)
               exit method.      
           MOVE "VS" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id ListBox1_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set BAT360-SEL-GAME TO (ListBox1::SelectedIndex + 1)
       end method.

       method-id playVis_Click protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "VV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id playHome_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "VH" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")               
           invoke self::batstube.
       end method.

       method-id playFull_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "VX" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
       lines-loop.
           if aa > BAT360-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & BAT360-WF-VIDEO-PATH(aa) & BAT360-WF-VIDEO-A(aa) & ","
PM         set vidTitles to vidTitles & BAT360-WF-VIDEO-TITL(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
           invoke self::ClientScript::RegisterStartupScript(self::GetType(), "callcallBatstube", "callBatstube();", true).
       end method.
       
       method-id Button1_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 1 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id Button2_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 2 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id Button3_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 3 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id Button4_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 4 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id Button5_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 5 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button6_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 6 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button7_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 7 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.    
       end method.

       method-id Button8_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 8 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.    
       end method.

       method-id Button9_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 9 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button10_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 10 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.   
       end method.

       method-id Button11_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 11 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.  
       end method.

       method-id Button12_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 12 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.    
       end method.

       method-id Button13_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 13 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.   
       end method.

       method-id Button14_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 14 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.    
       end method.

       method-id Button15_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 15 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.   
       end method.

       method-id Button16_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 16 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button17_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 17 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button18_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 18 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button19_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 19 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button20_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 20 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button21_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 21 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button22_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 22 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button23_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 23 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button24_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 24 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button25_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 25 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button26_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 26 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button27_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 27 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.     
       end method.

       method-id Button28_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 28 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.      
       end method.

       method-id Button29_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 29 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.       
       end method.

       method-id Button30_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE 30 to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id printButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE "PG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           MOVE " " to SYD145WD-FILENAME
           MOVE "S" to SYD145WD-PAGE-ORIENT
           MOVE 1 to SYD145WD-COPIES
           MOVE " " to SYD145WD-NOTEPAD
       end method.

       end class.
