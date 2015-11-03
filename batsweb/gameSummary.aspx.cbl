       class-id batsweb.gameSummary is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "C:\Users\Piotrek\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.
       
       method-id Page_Load protected.
       local-storage section.
           01 dataLine             type String.
           01 gameNum              pic x.
       LINKAGE SECTION.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           invoke HiddenField1Vis_ModalPopupExtender::Show.
       end method.

       method-id homeButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "SH" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           if BAT360-H-ROSTER-NAME(1) not = spaces
               set Button31::Visible to true
               set Button31::Text to BAT360-H-ROSTER-NAME(1)::Trim. 
           if BAT360-H-ROSTER-NAME(2) not = spaces
               set Button32::Visible to true
               set Button32::Text to BAT360-H-ROSTER-NAME(2)::Trim. 
           if BAT360-H-ROSTER-NAME(3) not = spaces
               set Button33::Visible to true
               set Button33::Text to BAT360-H-ROSTER-NAME(3)::Trim. 
           if BAT360-H-ROSTER-NAME(4) not = spaces
               set Button34::Visible to true
               set Button34::Text to BAT360-H-ROSTER-NAME(4)::Trim. 
           if BAT360-H-ROSTER-NAME(5) not = spaces
               set Button35::Visible to true
               set Button35::Text to BAT360-H-ROSTER-NAME(5)::Trim. 
           if BAT360-H-ROSTER-NAME(6) not = spaces
               set Button36::Visible to true
               set Button36::Text to BAT360-H-ROSTER-NAME(6)::Trim. 
           if BAT360-H-ROSTER-NAME(7) not = spaces
               set Button37::Visible to true
               set Button37::Text to BAT360-H-ROSTER-NAME(7)::Trim. 
           if BAT360-H-ROSTER-NAME(8) not = spaces
               set Button38::Visible to true
               set Button38::Text to BAT360-H-ROSTER-NAME(8)::Trim. 
           if BAT360-H-ROSTER-NAME(9) not = spaces
               set Button39::Visible to true
               set Button39::Text to BAT360-H-ROSTER-NAME(9)::Trim. 
           if BAT360-H-ROSTER-NAME(10) not = spaces
               set Button40::Visible to true
               set Button40::Text to BAT360-H-ROSTER-NAME(10)::Trim. 
           if BAT360-H-ROSTER-NAME(11) not = spaces
               set Button41::Visible to true
               set Button41::Text to BAT360-H-ROSTER-NAME(11)::Trim. 
           if BAT360-H-ROSTER-NAME(12) not = spaces
               set Button42::Visible to true
               set Button42::Text to BAT360-H-ROSTER-NAME(12)::Trim. 
           if BAT360-H-ROSTER-NAME(13) not = spaces
               set Button43::Visible to true
               set Button43::Text to BAT360-H-ROSTER-NAME(13)::Trim. 
           if BAT360-H-ROSTER-NAME(14) not = spaces
               set Button44::Visible to true
               set Button44::Text to BAT360-H-ROSTER-NAME(14)::Trim. 
           if BAT360-H-ROSTER-NAME(15) not = spaces
               set Button45::Visible to true
               set Button45::Text to BAT360-H-ROSTER-NAME(15)::Trim. 
           if BAT360-H-ROSTER-NAME(16) not = spaces
               set Button46::Visible to true
               set Button46::Text to BAT360-H-ROSTER-NAME(16)::Trim. 
           if BAT360-H-ROSTER-NAME(17) not = spaces
               set Button47::Visible to true
               set Button47::Text to BAT360-H-ROSTER-NAME(17)::Trim. 
           if BAT360-H-ROSTER-NAME(18) not = spaces
               set Button48::Visible to true
               set Button48::Text to BAT360-H-ROSTER-NAME(18)::Trim. 
           if BAT360-H-ROSTER-NAME(19) not = spaces
               set Button49::Visible to true
               set Button49::Text to BAT360-H-ROSTER-NAME(19)::Trim. 
           if BAT360-H-ROSTER-NAME(20) not = spaces
               set Button50::Visible to true
               set Button50::Text to BAT360-H-ROSTER-NAME(20)::Trim. 
           if BAT360-H-ROSTER-NAME(21) not = spaces
               set Button51::Visible to true
               set Button51::Text to BAT360-H-ROSTER-NAME(21)::Trim. 
           if BAT360-H-ROSTER-NAME(22) not = spaces
               set Button52::Visible to true
               set Button52::Text to BAT360-H-ROSTER-NAME(22)::Trim. 
           if BAT360-H-ROSTER-NAME(23) not = spaces
               set Button53::Visible to true
               set Button53::Text to BAT360-H-ROSTER-NAME(23)::Trim. 
           if BAT360-H-ROSTER-NAME(24) not = spaces
               set Button54::Visible to true
               set Button54::Text to BAT360-H-ROSTER-NAME(24)::Trim. 
           if BAT360-H-ROSTER-NAME(25) not = spaces
               set Button55::Visible to true
               set Button55::Text to BAT360-H-ROSTER-NAME(25)::Trim. 
           if BAT360-H-ROSTER-NAME(26) not = spaces
               set Button56::Visible to true
               set Button56::Text to BAT360-H-ROSTER-NAME(26)::Trim. 
           if BAT360-H-ROSTER-NAME(27) not = spaces
               set Button57::Visible to true
               set Button57::Text to BAT360-H-ROSTER-NAME(27)::Trim. 
           if BAT360-H-ROSTER-NAME(28) not = spaces
               set Button58::Visible to true
               set Button58::Text to BAT360-H-ROSTER-NAME(28)::Trim. 
           if BAT360-H-ROSTER-NAME(29) not = spaces
               set Button59::Visible to true
               set Button59::Text to BAT360-H-ROSTER-NAME(29)::Trim. 
           if BAT360-H-ROSTER-NAME(30) not = spaces
               set Button60::Visible to true
               set Button60::Text to BAT360-H-ROSTER-NAME(30)::Trim. 
           invoke HiddenField2Home_ModalPopupExtender::Show.
       end method.

       method-id ListBox2_SelectedIndexChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set BAT360-SEL-AB to ListBox2::SelectedIndex
           add 1 to BAT360-SEL-AB
           MOVE BAT360-SEL-AB to BAT360-AB-IP
           MOVE BAT360-AB-KEY(BAT360-SEL-AB) to BAT360-I-KEY
           MOVE "VD" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.

       method-id fromSelected_Click protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 1 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button2_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 2 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button3_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 3 to aa
       end method.

       method-id Button4_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 4 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button5_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 5 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button6_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 6 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button7_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 7 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button8_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 8 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button9_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 9 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button10_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 10 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button11_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 11 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button12_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 12 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button13_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 13 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button14_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 14 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button15_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 15 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button16_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 16 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button17_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 17 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button18_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 18 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button19_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 19 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button20_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 20 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button21_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 21 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button22_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 22 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button23_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 23 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button24_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 24 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button25_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 25 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button26_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 26 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button27_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 27 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button28_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 28 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button29_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 29 to aa
           invoke self::visitorPlayer.
       end method.

       method-id Button30_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           MOVE 30 to aa
           invoke self::visitorPlayer.
       end method.
       
       method-id visitorPlayer protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE aa to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.
       
       method-id Button31_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 1 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button32_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 2 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button33_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 3 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button34_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 4 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button35_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 5 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button36_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 6 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button37_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 7 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button38_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 8 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button39_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 9 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button40_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 10 to aa.
           invoke self::homePlayer.
       end method. 
       method-id Button41_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 11 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button42_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 12 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button43_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 13 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button44_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 14 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button45_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 15 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button46_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 16 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button47_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 17 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button48_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 18 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button49_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 19 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button50_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 20 to aa.
           invoke self::homePlayer.
       end method. 
       method-id Button51_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 21 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button52_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 22 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button53_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 23 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button54_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 24 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button55_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 25 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button56_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 26 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button57_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 27 to aa.
           invoke self::homePlayer.
       end method.     
       method-id Button58_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 28 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button59_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 29 to aa.
           invoke self::homePlayer.
       end method.
       method-id Button60_Click protected.
       procedure division using by value sender as object e as type System.EventArgs.
           move 30 to aa.
           invoke self::homePlayer.
       end method. 
       
       method-id homePlayer protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE aa to BAT360-V-SEL-BUTTON
           MOVE "PH" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke self::batstube.
       end method.
       
       method-id printButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat360_dg.CPB".
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
