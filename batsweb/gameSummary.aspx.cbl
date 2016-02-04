
       class-id batsweb.gameSummary is partial
                implements type System.Web.UI.ICallbackEventHandler
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.
       01 callbackReturn type String.
       
       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.       
       LINKAGE SECTION.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
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
           if   self::Session["bat360data"] = null
              set mydata to new batsweb.bat360Data
              invoke mydata::populateData
              set self::Session["bat360data"] to mydata
           else
               set mydata to self::Session["bat360data"] as type batsweb.bat360Data.

           
           
           if  self::Session::Item("360rununit") not = null
               set bat360rununit to self::Session::Item("360rununit")
                   as type RunUnit
                ELSE
                set bat360rununit to type RunUnit::New()
                set BAT360WEBF to new BAT360WEBF
                invoke bat360rununit::Add(BAT360WEBF)
                set self::Session::Item("360rununit") to  bat360rununit.
      *     invoke ListBox2::Attributes::Add("ondblclick", ClientScript::GetPostBackEventReference(ListBox2, "move"))
      *     invoke ListBox1::Attributes::Add("ondblclick", ClientScript::GetPostBackEventReference(ListBox1, "move"))
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer
           move "I" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           
           if actionFlag = 'play-home'
               set callbackReturn to actionFlag & "|" & self::playVids("VH")
           else if actionFlag = 'play-vis'
               set callbackReturn to actionFlag & "|" & self::playVids("VV")
           else if actionFlag = 'play-full'
               set callbackReturn to actionFlag & "|" & self::playVids("VX")
           else if actionFlag = 'from-selected'
               set callbackReturn to actionFlag & "|" & self::fromSelectd()
           else if actionFlag = 'inning-selected'
               set callbackReturn to actionFlag & "|" & self::inningSelected(methodArg)
           else if actionFlag = 'show-detail'
               set callbackReturn to actionFlag & "|" & self::showDetail()
           else if actionFlag = 'select-home-player'
               set callbackReturn to actionFlag & "|" & self::selectHomePlayer().
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################
    
      * ######################################################
        
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
           01 dataLine             type String.
           01 gameNum              pic x.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer 
           invoke gamesTable::Rows::Clear()
           invoke self::addTableRow(gamesTable, "Date        Vis                         Home                     Time Video"::Replace(" ", "&nbsp;"), 'h')
           
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
               invoke self::addTableRow(gamesTable, " " & dataLine, 'b').
           add 1 to aa
           go to games-loop.
       games-done.
       end method.

       method-id inningsButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if GamesValueField::Value = null
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You must select a game');", true)
               exit method.
           move BAT360-G-GAME-DATE(BAT360-SEL-GAME) to BAT360-I-GAME-DATE
           move BAT360-G-GAME-ID(BAT360-SEL-GAME) to BAT360-I-GAME-ID


           MOVE "RA" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
           invoke self::loadLines.
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           set BAT360-GAMES-TEAM to teamDropDownList::SelectedItem
           if BAT360-GAMES-TEAM = spaces
               exit method.
           MOVE "RG" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
               if ERROR-FIELD NOT = SPACES
                   invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
                   move spaces to ERROR-FIELD
               end-if    
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.                      
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

       method-id selectHomePlayer protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division returning playerList as String.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           MOVE "SH" to BAT360-ACTION.
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playerList to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.                      
           
           move BAT360-H-ROSTER-NAME to playerList
      * Create a button (or table?) for each home player using BAT360-H-ROSTER-NAME Array         
      * ASYNC - Return roster array and create things on the client side  
      *    if BAT360-H-ROSTER-NAME(1) not = spaces
      *        set Button31::Visible to true
      *        set Button31::Text to BAT360-H-ROSTER-NAME(1)::Trim. 
      *    if BAT360-H-ROSTER-NAME(2) not = spaces
      *        set Button32::Visible to true
      *        set Button32::Text to BAT360-H-ROSTER-NAME(2)::Trim. 
      *    if BAT360-H-ROSTER-NAME(3) not = spaces
      *        set Button33::Visible to true
      *        set Button33::Text to BAT360-H-ROSTER-NAME(3)::Trim. 
      *    if BAT360-H-ROSTER-NAME(4) not = spaces
      *        set Button34::Visible to true
      *        set Button34::Text to BAT360-H-ROSTER-NAME(4)::Trim. 
      *    if BAT360-H-ROSTER-NAME(5) not = spaces
      *        set Button35::Visible to true
      *        set Button35::Text to BAT360-H-ROSTER-NAME(5)::Trim. 
      *    if BAT360-H-ROSTER-NAME(6) not = spaces
      *        set Button36::Visible to true
      *        set Button36::Text to BAT360-H-ROSTER-NAME(6)::Trim. 
      *    if BAT360-H-ROSTER-NAME(7) not = spaces
      *        set Button37::Visible to true
      *        set Button37::Text to BAT360-H-ROSTER-NAME(7)::Trim. 
      *    if BAT360-H-ROSTER-NAME(8) not = spaces
      *        set Button38::Visible to true
      *        set Button38::Text to BAT360-H-ROSTER-NAME(8)::Trim. 
      *    if BAT360-H-ROSTER-NAME(9) not = spaces
      *        set Button39::Visible to true
      *        set Button39::Text to BAT360-H-ROSTER-NAME(9)::Trim. 
      *    if BAT360-H-ROSTER-NAME(10) not = spaces
      *        set Button40::Visible to true
      *        set Button40::Text to BAT360-H-ROSTER-NAME(10)::Trim. 
      *    if BAT360-H-ROSTER-NAME(11) not = spaces
      *        set Button41::Visible to true
      *        set Button41::Text to BAT360-H-ROSTER-NAME(11)::Trim. 
      *    if BAT360-H-ROSTER-NAME(12) not = spaces
      *        set Button42::Visible to true
      *        set Button42::Text to BAT360-H-ROSTER-NAME(12)::Trim. 
      *    if BAT360-H-ROSTER-NAME(13) not = spaces
      *        set Button43::Visible to true
      *        set Button43::Text to BAT360-H-ROSTER-NAME(13)::Trim. 
      *    if BAT360-H-ROSTER-NAME(14) not = spaces
      *        set Button44::Visible to true
      *        set Button44::Text to BAT360-H-ROSTER-NAME(14)::Trim. 
      *    if BAT360-H-ROSTER-NAME(15) not = spaces
      *        set Button45::Visible to true
      *        set Button45::Text to BAT360-H-ROSTER-NAME(15)::Trim. 
      *    if BAT360-H-ROSTER-NAME(16) not = spaces
      *        set Button46::Visible to true
      *        set Button46::Text to BAT360-H-ROSTER-NAME(16)::Trim. 
      *    if BAT360-H-ROSTER-NAME(17) not = spaces
      *        set Button47::Visible to true
      *        set Button47::Text to BAT360-H-ROSTER-NAME(17)::Trim. 
      *    if BAT360-H-ROSTER-NAME(18) not = spaces
      *        set Button48::Visible to true
      *        set Button48::Text to BAT360-H-ROSTER-NAME(18)::Trim. 
      *    if BAT360-H-ROSTER-NAME(19) not = spaces
      *        set Button49::Visible to true
      *        set Button49::Text to BAT360-H-ROSTER-NAME(19)::Trim. 
      *    if BAT360-H-ROSTER-NAME(20) not = spaces
      *        set Button50::Visible to true
      *        set Button50::Text to BAT360-H-ROSTER-NAME(20)::Trim. 
      *    if BAT360-H-ROSTER-NAME(21) not = spaces
      *        set Button51::Visible to true
      *        set Button51::Text to BAT360-H-ROSTER-NAME(21)::Trim. 
      *    if BAT360-H-ROSTER-NAME(22) not = spaces
      *        set Button52::Visible to true
      *        set Button52::Text to BAT360-H-ROSTER-NAME(22)::Trim. 
      *    if BAT360-H-ROSTER-NAME(23) not = spaces
      *        set Button53::Visible to true
      *        set Button53::Text to BAT360-H-ROSTER-NAME(23)::Trim. 
      *    if BAT360-H-ROSTER-NAME(24) not = spaces
      *        set Button54::Visible to true
      *        set Button54::Text to BAT360-H-ROSTER-NAME(24)::Trim. 
      *    if BAT360-H-ROSTER-NAME(25) not = spaces
      *        set Button55::Visible to true
      *        set Button55::Text to BAT360-H-ROSTER-NAME(25)::Trim. 
      *    if BAT360-H-ROSTER-NAME(26) not = spaces
      *        set Button56::Visible to true
      *        set Button56::Text to BAT360-H-ROSTER-NAME(26)::Trim. 
      *    if BAT360-H-ROSTER-NAME(27) not = spaces
      *        set Button57::Visible to true
      *        set Button57::Text to BAT360-H-ROSTER-NAME(27)::Trim. 
      *    if BAT360-H-ROSTER-NAME(28) not = spaces
      *        set Button58::Visible to true
      *        set Button58::Text to BAT360-H-ROSTER-NAME(28)::Trim. 
      *    if BAT360-H-ROSTER-NAME(29) not = spaces
      *        set Button59::Visible to true
      *        set Button59::Text to BAT360-H-ROSTER-NAME(29)::Trim. 
      *    if BAT360-H-ROSTER-NAME(30) not = spaces
      *        set Button60::Visible to true
      *        set Button60::Text to BAT360-H-ROSTER-NAME(30)::Trim. 
      *    invoke HiddenField2Home_ModalPopupExtender::Show.
       end method.

       method-id inningSelected protected.
       local-storage section.
       01 ctrl             type Control.
       01 atbatflag        pic x.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value inningIndex as String returning returnVal as  String.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
               
           set BAT360-SEL-AB to type Int32::Parse(inningIndex)
           
           add 1 to BAT360-SEL-AB
           MOVE BAT360-SEL-AB to BAT360-AB-IP
           MOVE BAT360-AB-KEY(BAT360-SEL-AB) to BAT360-I-KEY
           
      *    if self::Request::Params::Get("__EVENTTARGET") not = null or spaces
      *        if self::Request::Params::Get("__EVENTTARGET") not = "ctl00$MainContent$ListBox2"
      *            exit method.
      *    
           MOVE "VD" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.                      
           invoke self::batstube.
               
       end method.

       method-id fromSelectd protected.
       local-storage section.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
               
           if BAT360-AB-IP = 0
               set returnVal to "er|" & "No starting point is highlighted!"
               exit method.   
           IF BAT360-REC-TYPE(BAT360-SEL-AB) NOT = "B"
               set returnVal to "er|" & "You cannot select a header field!"
               exit method.      
               
           MOVE "VS" to BAT360-ACTION
           
           invoke bat360rununit::Call("BAT360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id gameSelected protected.
       local-storage section.
       01 temp type String.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set BAT360-AB-IP to 0
           set BAT360-SEL-GAME TO (type Int32::Parse(gamesIndexField::Value) + 1)
           
           
      *    if self::Request::Params::Get("__EVENTTARGET") not = null or spaces
      *        if self::Request::Params::Get("__EVENTTARGET") not = "ctl00$MainContent$gamesValueField"
      *            exit method.
                   
           MOVE BAT360-G-GAME-DATE(BAT360-SEL-GAME) to BAT360-I-GAME-DATE
           MOVE BAT360-G-GAME-ID(BAT360-SEL-GAME) to BAT360-I-GAME-ID
           MOVE "RA" to BAT360-ACTION
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit

           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
           invoke self::loadLines
       end method.
       
       method-id loadLines protected.
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
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       

           invoke inningSummaryTable::Rows::Clear()
           invoke self::addTableRow(inningSummaryTable, " Inn Batter         Out Rnrs  Res  RBI   Inn Batter         Out Rnrs  Res  RBI"::Replace(" ", "&nbsp;"), 'h')

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
               invoke self::addTableRow(inningSummaryTable, " " & WS-DATA-LINE, 'b').
      *        IF AA > 1
      *             IF WS2-DATA-L = SPACES
      *                 invoke listbox2::Items[aa - 1]::Attributes::Add("style", "color:blue")
      *             ELSE
      *                 Invoke listbox2::Items[aa - 1]::Attributes::Add("style", "color:blue")
      *             END-IF
      *        END-IF   
           add 1 to aa
           go to ab-loop.
       ab-done.
      *    invoke listbox3::Items::Clear
           invoke statsTable::Rows::Clear()
           
           move 1 to aa.
       5-loop.
           if aa > BAT360-NUM-T-LINES
               go to 10-done
           else
               INSPECT BAT360-T-LINE(aa) REPLACING ALL " " BY X'A0'
      *        invoke listbox3::Items::Add(BAT360-T-LINE(aa)).
               invoke self::addTableRow(statsTable, BAT360-T-LINE(aa), 'b')
           add 1 to aa
           go to 5-loop.
       10-done.
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
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
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
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
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE aa to BAT360-V-SEL-BUTTON
           MOVE "PV" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
           invoke self::batstube.
       end method.
       
       
       method-id homePlayerButtonClick protected.
       procedure division using by value aaValue as String.
           invoke self::homePlayer(type Int32::Parse(aaValue))
       end method.    
       
       
       method-id homePlayer protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value aaVal as type Int32 
                          returning returnVal as String.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           MOVE aaVal to BAT360-H-SEL-BUTTON
           MOVE "PH" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
               move spaces to ERROR-FIELD.               
           invoke self::batstube.
       end method.
       
       method-id printButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
      *     MOVE "PG" to BAT360-ACTION
      *     invoke bat360rununit::Call("BAT360WEBF")
      *     MOVE " " to SYD145WD-FILENAME
      *     MOVE "S" to SYD145WD-PAGE-ORIENT
      *     MOVE 1 to SYD145WD-COPIES
      *     MOVE " " to SYD145WD-NOTEPAD
       end method.

       method-id showDetail protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer   
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           if BAT360-AB-IP = 0
               set returnVal to "er|" & "No at bat is highlighted!"
               exit method.   
           move "VA" to BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD.               
               exit method.   
       end method.
      *
      *method-id game_Selected protected.
      *local-storage section.
      *01 selected  type Int32.
      *linkage section.
      *COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
      *procedure division using by value indexString as type String 
      *                   returning gamesReturn as type String.
      *
      *    set mydata to self::Session["bat360data"] as type batsweb.bat360Data
      *    set address of BAT360-DIALOG-FIELDS to myData::tablePointer
      *
      *    set selected to self::getSelectedIndex(indexString).
      *    set BAT360-AB-IP to 0
      *    set BAT360-SEL-GAME TO (selected)
      *    MOVE BAT360-G-GAME-DATE(BAT360-SEL-GAME) to BAT360-I-GAME-DATE
      *    MOVE BAT360-G-GAME-ID(BAT360-SEL-GAME) to BAT360-I-GAME-ID
      *end method.
      *              
      *    
      *method-id show_Innings protected.
      *local-storage section.
      *linkage section.
      *COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
      *procedure division.
      *
      *    set mydata to self::Session["bat360data"] as type batsweb.bat360Data
      *    set address of BAT360-DIALOG-FIELDS to myData::tablePointer          
      *    MOVE "RA" to BAT360-ACTION
      *    set bat360rununit to self::Session::Item("360rununit")
      *        as type RunUnit
      *
      *    invoke bat360rununit::Call("BAT360WEBF")
      *    if ERROR-FIELD NOT = SPACES
      *        invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
      *        move spaces to ERROR-FIELD.    
      *    invoke self::loadLines.
      *end method.
       
       
       
      * #### Helpers ####
       method-id playVids protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value actionFlag as type String
                          returning returnVal as type String.
                          
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer    
           
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit
               
           MOVE actionFlag to BAT360-ACTION
           
           invoke bat360rununit::Call("BAT360WEBF")   
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.         
               
           invoke self::batstube.
       end method.

       end class.
