       class-id batsweb.breakdown is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat310rununit         type RunUnit.
       01 BAT310WEBF                type BAT310WEBF.
       01 mydata type batsweb.bat310Data.
       01 mydata300 type batsweb.bat300Data.

       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           
           set self::Session::Item("database") to self::Request::QueryString["league"]
           if self::Session["bat310data"] = null
               set mydata to new batsweb.bat310Data
               invoke mydata::populateData
               set self::Session["bat310data"] to mydata              
           else
               set mydata to self::Session["bat310data"] as type batsweb.bat310Data.
           if self::IsPostBack
               exit method.
           if  self::Session::Item("310rununit") not = null
               set bat310rununit to self::Session::Item("310rununit")
                   as type RunUnit
               else
               set bat310rununit to type RunUnit::New()
               set BAT310WEBF to new BAT310WEBF
               invoke bat310rununit::Add(BAT310WEBF)
               set self::Session::Item("310rununit") to  bat310rununit.              
               
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           INITIALIZE BAT310-DIALOG-FIELDS
           MOVE "I" TO BAT310-ACTION
           invoke bat310rununit::Call("BAT310WEBF")
      *show and hide batter based on L or R handedness

           invoke runnersdd::Items::Clear.
           invoke outsdd::Items::Clear.
           invoke inndd::Items::Clear.
           invoke countdd::Items::Clear.
           invoke pitchlocdd::Items::Clear
           invoke catcherdd::Items::Clear.
           invoke result1dd::Items::Clear.
           invoke result2dd::Items::Clear.
           invoke pitchtypedd::Items::Clear.

           move 1 to aa.
       runners-loop.
           if aa > DIALOG-RUN-NUM-ENTRIES
               go to runners-done.
           invoke runnersdd::Items::Add(DIALOG-RUN(AA)::Trim)
           add 1 to aa
           go to runners-loop.
       runners-done.
           move 1 to aa.
       outs-loop.
           if aa > DIALOG-OUT-NUM-ENTRIES
               go to outs-done.
           invoke outsdd::Items::Add(DIALOG-OUT(AA)::Trim)
           add 1 to aa
           go to outs-loop.
       outs-done.
           move 1 to aa.
       inning-loop.
           if aa > DIALOG-INN-NUM-ENTRIES
               go to inning-done.
           invoke inndd::Items::Add(DIALOG-INNING-DESC(AA)::Trim)
           add 1 to aa
           go to inning-loop.
       inning-done.
       move 1 to aa.
       count-loop.
           if aa > DIALOG-COUNT-NUM-ENTRIES
               go to count-done.
           invoke countdd::Items::Add(DIALOG-COUNT-DESC(AA)::Trim)
           add 1 to aa
           go to count-loop.
       count-done.
       move 1 to aa.
       location-loop.
           if aa > DIALOG-PLO-NUM-ENTRIES
               go to location-done.
           invoke pitchlocdd::Items::Add(DIALOG-PLO(AA)::Trim)
           add 1 to aa
           go to location-loop.
       location-done.
       move 1 to aa.
       catcher-loop.
           if aa > DIALOG-CAT-NUM-ENTRIES
               go to catcher-done.
           invoke catcherdd::Items::Add(DIALOG-CAT(AA)::Trim)
           add 1 to aa
           go to catcher-loop.
       catcher-done.
       move 1 to aa.
       result1-loop.
           if aa > DIALOG-RES-NUM-ENTRIES
               go to result1-done.
           invoke result1dd::Items::Add(DIALOG-RES(AA)::Trim)
           add 1 to aa
           go to result1-loop.
       result1-done.
       move 1 to aa.
       result2-loop.
           if aa > DIALOG-RES-NUM-ENTRIES
               go to result2-done.
           invoke result2dd::Items::Add(DIALOG-RES(AA)::Trim)
           add 1 to aa
           go to result2-loop.
       result2-done.
       move 1 to aa.
       pitchtype-loop.
           if aa > DIALOG-PTY-NUM-ENTRIES
               go to pitchtype-done.
           invoke pitchtypedd::Items::Add(DIALOG-PTY(AA)::Trim)
           add 1 to aa
           go to pitchtype-loop.
       pitchtype-done.
           set result1dd::SelectedIndex to 0
           set result2dd::SelectedIndex to 0
           set inndd::SelectedIndex to 0
           set outsdd::SelectedIndex to 0
           set runnersdd::SelectedIndex to 0
           if catcherdd::Items::Count not = 0
               set catcherdd::SelectedIndex to 0.
           set countdd::SelectedIndex to 0
           set pitchlocdd::SelectedIndex to 0
           set pitchtypedd::SelectedIndex to 0

      *     attach method self::MouseDownploc to szonebox::MouseDown
      *     attach method self::MouseUpploc to szonebox::MouseUp
      *     attach method self::MouseMoveloc to szonebox::MouseMove

      *     move 1 to SH-BAT300-FLAG
      *    CHECK IF WE HAVE A TEMP FILE TO PROCESS
           move "FC" to BAT310-ACTION
           invoke bat310rununit::Call("BAT310WEBF")
           IF BAT310-BYPASS-FLAG = "Y"
               invoke selectionButton_ModalPopupExtender::Show
           else
               move "IN" to BAT310-ACTION
               invoke bat310rununit::Call("BAT310WEBF")
               invoke self::Recalc.
           invoke self::bat300
           goback.
       end method.
       
       method-id bat300 protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division.
           if self::Session["bat300data"] = null
               set mydata300 to new batsweb.bat300Data
               invoke mydata300::populateData
               set self::Session["bat300data"] to mydata300              
           else
               set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data.
          
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           INITIALIZE BAT300-DIALOG-FIELDS
           MOVE "IN" TO BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF").
           MOVE "N" TO BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF").
           
           
           set batterSelectionTextBox::Text to BAT300-BATTER::Trim
           set pitcherSelectionTextBox::Text to BAT300-PITCHER::Trim
       
      *pitcher location radio buttons in "Other Selections"
          if BAT300-PITCHER-LOC-FLAG = " "
            set allLocRadioButton::Checked to true
          else if BAT300-PITCHER-LOC-FLAG = "H"
            set pitchHomeRadioButton::Checked to true
          else if BAT300-PITCHER-LOC-FLAG = "A"
            set pitchAwayRadioButton::Checked to true.
           
      *hides NL and AL buttons for college  
      *     if SH-BATS-PRODUCT-FLAG is not = " "
      *         set btnALBatter::Visible to false
      *         set btnALPitcher::Visible to false
      *         set btnNLBatter::Visible to false
      *         set btnNLPitcher::Visible to false.
               
      *"Additional Pitcher Options" radio buttons & display field        
           if BAT300-PITCHER-TYPE-FLAG = "P"
               set pitcherpowerRadioButton::Checked to true
           else if BAT300-PITCHER-TYPE-FLAG = "A" or BAT300-PITCHER-TYPE-FLAG = " "
               set pitcheranyRadioButton::Checked to true
           else if BAT300-PITCHER-TYPE-FLAG = "C"  
               set pitchercontrolRadioButton::Checked to true
           else if BAT300-PITCHER-TYPE-FLAG = "B"   
               set pitcherbreakingRadioButton::Checked to true
           else 
               set pitchercustomRadioButton::Checked to true.
           SET pitcheroptionsTextBox::Text to BAT300-PITCHER-TYPE-FLAG::Trim.
           
      *"Additional Batter Options" radio buttons & display field
           if BAT300-BATTER-TYPE-FLAG = "P"
               set batterpowerRadioButton::Checked to true
           else if BAT300-BATTER-TYPE-FLAG = "A" or BAT300-BATTER-TYPE-FLAG = " "
               set batteranyRadioButton::Checked to true
           else if BAT300-BATTER-TYPE-FLAG = "S"  
               set battersingleRadioButton::Checked to true
           else
               set battercustomRadioButton::Checked to true.
           SET batteroptionsTextBox::Text to BAT300-BATTER-TYPE-FLAG::Trim.
               
      *options for "Individual Pitchers Only" radio buttons
           if BAT300-START-R-FLAG = "A"
               set allinningsRadioButton::Checked to true
           else if BAT300-START-R-FLAG = "S"  
               set startinningsRadioButton::Checked to true
           else if BAT300-START-R-FLAG = "R"  
               set reliefRadioButton::Checked to true.
      
      *checkboxes for MaxAbs and My Team's Games Only
           if BAT300-MAX-FLAG = "Y"
               SET maxAtBatsCheckBox::Checked to true
               set maxABTextBox::Text to BAT300-MAX-NUM::ToString
           else
               SET maxAtBatsCheckBox::Checked to false.
               
           if BAT300-TEAM-ONLY-FLAG = "Y"   
               set myCheckBox::Checked to true
           else
               set myCheckBox::Checked to false.

      *Batter handedness radio buttons
           if BAT300-BATTER-BATS-FLAG = "L"
               set batsleftRadioButton::Checked to true
           else if BAT300-BATTER-BATS-FLAG = "R"   
               set batsrightRadioButton::Checked to true
           else
               set batseitherRadioButton::Checked to true.
      
      *Pitcher handedness radio buttons
           if BAT300-PITCHER-THROWS-FLAG = "R"
               set throwsrightRadioButton::Checked to true
           else if BAT300-PITCHER-THROWS-FLAG = "L"    
               set throwsleftRadioButton::Checked to true
           else
               set throwseitherRadioButton::Checked to true.
       
      *Day/Night game time radio buttons
           if BAT300-TIME-FLAG = "D"
               set dayRadioButton::Checked to true
           else if BAT300-TIME-FLAG = "N" 
               set nightRadioButton::Checked to true
           else
               set allTimeRadioButton::Checked to true.
      
      *Show Dodgers custom buttons 
      *     if BAT300-CONTROL-TEAM-NAME = "LOS ANGELES DODGERS"
      *         set btnLABatter::Visible to true
      *         set btnLAPitcher::Visible to true.
               
      *radio buttons for Start/End dates or 'All' dates
           if BAT300-DATE-CHOICE-FLAG = "A"
               SET allstartRadioButton::Checked to true    
               SET allendRadioButton::Checked to true
           else
               set startDateRadioButton::Checked to true
               set endDateRadioButton::Checked to true.
 
           
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("00/00/00")
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("00/00/00")
           move 1 to aa. 
       5-loop.
          if aa > BAT300-NUM-TEAMS
               go to 10-done
          else
               invoke teamDropDownList::Items::Add(BAT300-TEAM-NAME(aa))
               invoke bTeamDropDownList::Items::Add(BAT300-TEAM-NAME(aa))
               invoke pTeamDropDownList::Items::Add(BAT300-TEAM-NAME(aa)).
          add 1 to aa
          go to 5-loop.
       10-done.    
           
       end method.
  
       method-id result1dd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-RES-IDX to result1dd::SelectedIndex
           set DIALOG-RES-MASTER TO result1dd::SelectedItem
           add 1 to DIALOG-RES-IDX
           invoke self::Recalc.
       end method.
       
       method-id result2dd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-RES-IDX2 to result2dd::SelectedIndex
           set DIALOG-RES-MASTER2 TO result2dd::SelectedItem
           add 1 to DIALOG-RES-IDX2
           invoke self::Recalc.
       end method.
              
       method-id inndd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-INN-IDX to inndd::SelectedIndex
           set DIALOG-INN-MASTER TO inndd::SelectedItem
           add 1 to DIALOG-INN-IDX
           invoke self::Recalc.
       end method.
       
       method-id outsdd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-OUT-IDX to outsdd::SelectedIndex
           set DIALOG-OUT-MASTER TO outsdd::SelectedItem
           add 1 to DIALOG-OUT-IDX
           invoke self::Recalc.
       end method.
       
       method-id catcherdd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-CAT-IDX to catcherdd::SelectedIndex
           set DIALOG-CAT-MASTER TO catcherdd::SelectedItem
           add 1 to DIALOG-OUT-IDX
           invoke self::Recalc.
       end method.       
       
       method-id runnersdd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-RUN-IDX to runnersdd::SelectedIndex
           set DIALOG-RUN-MASTER TO runnersdd::SelectedItem
           add 1 to DIALOG-RUN-IDX
           invoke self::Recalc.
       end method.  
       
       method-id pitchtypedd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-PTY-IDX to pitchtypedd::SelectedIndex
           set DIALOG-PTY-MASTER TO pitchtypedd::SelectedItem
           add 1 to DIALOG-PTY-IDX
           invoke self::Recalc.
       end method.  
       
       method-id pitchlocdd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-PLO-IDX to pitchlocdd::SelectedIndex
           set DIALOG-PLO-MASTER TO pitchlocdd::SelectedItem
           add 1 to DIALOG-PLO-IDX
           invoke self::Recalc.
       end method.  
       
       method-id countdd_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set DIALOG-CNT-IDX to outsdd::SelectedIndex
           set DIALOG-COUNT-MASTER TO outsdd::SelectedItem
           add 1 to DIALOG-CNT-IDX
           invoke self::Recalc.
       end method.  
       
       method-id resetButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move 0 to result1dd::SelectedIndex
           set DIALOG-RES-IDX to (result1dd::SelectedIndex + 1)
           set DIALOG-RES-MASTER TO result1dd::SelectedItem
           move 0 to result2dd::SelectedIndex
           set DIALOG-RES-IDX2 to (result2dd::SelectedIndex + 1)
           set DIALOG-RES-MASTER2 TO result2dd::SelectedItem
           move 0 to runnersdd::SelectedIndex
           set DIALOG-RUN-MASTER to outsdd::SelectedItem
           set DIALOG-RUN-IDX to (outsdd::SelectedIndex + 1)           
           move 0 to outsdd::SelectedIndex
           set DIALOG-OUT-MASTER to outsdd::SelectedItem
           set DIALOG-OUT-IDX to (outsdd::SelectedIndex + 1)
           move 0 to inndd::SelectedIndex
           set DIALOG-INN-MASTER to outsdd::SelectedItem
           set DIALOG-INN-IDX to (outsdd::SelectedIndex + 1)
           MOVE "RA" TO BAT310-ACTION
           invoke bat310rununit::Call("BAT310WEBF")
           invoke self::Recalc.
       end method.
       
       method-id Recalc protected.
       local-storage section.
       01  avg         type Double.
       01  mypen       type Pen.

       01  ws-x        pic 9(4).
       01  ws-y        pic 9(4).
       01  ws-new-x1        pic 9(4).
       01  ws-new-y1        pic 9(4).
       01  ws-x2        pic 9(4).
       01  ws-y2        pic 9(4).
       01  drawArea          type Bitmap.
       01  g           type Graphics.
       01  WORKF                       PIC S999   VALUE ZERO.

       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           move "RE" to BAT310-ACTION
           invoke bat310rununit::Call("BAT310WEBF")

                  set batterTextBox::Text to DIALOG-BATTER::Trim
                  set pitcherTextBox::Text to DIALOG-PITCHER::Trim
                  set gamesTextBox::Text to DIALOG-GAME-RANGE::Trim
                  set locationTextBox::Text to DIALOG-GAME-LOC::Trim
                  set gLabel::Text to BAT310-G::ToString
                  set abLabel::Text to BAT310-AB::ToString
                  set hLabel::Text to BAT310-H::ToString
                  set doubleLabel::Text to BAT310-2B::ToString
                  set tripleLabel::Text to BAT310-3B::ToString
                  set hrLabel::Text to BAT310-HR::ToString
                  set rbiLabel::Text to BAT310-RBI::ToString
                  set bbLabel::Text to BAT310-BB::ToString
                  set kLabel::Text to BAT310-K::ToString
                  set sacLabel::Text to BAT310-SAC::ToString
                  set dpLabel::Text to BAT310-DP::ToString
                  set hbpLabel::Text to BAT310-HBP::ToString
                  set tpaLabel::Text to BAT310-TPA::ToString
                  set avg to BAT310-BA
                  set avgLabel::Text to avg::ToString("#.000")
                  set avg to BAT310-SP
                  set slgLabel::Text to avg::ToString("#.000")
                  set avg to BAT310-OBP
                  set obpLabel::Text to avg::ToString("#.000")
                  set avg to BAT310-OPS
                  set opsLabel::Text to avg::ToString("#.000")
                  set fbLabel::Text to BAT310-FB::ToString
                  set gbLabel::Text to BAT310-GB::ToString
                  set ldLabel::Text to BAT310-LD::ToString
                  set puLabel::Text to BAT310-PU::ToString
                  set buLabel::Text to BAT310-BU::ToString
                  set hardLabel::Text to BAT310-HARD::Trim
                  set medLabel::Text to BAT310-MEDIUM::Trim
                  set softLabel::Text to BAT310-SOFT::Trim

           invoke plListBox::Items::Clear
           move 1 to aa.
       5-loop.
           if aa > BAT310-NUM-PITCH-LIST
               go to 10-done.
           INSPECT BAT310-PITCH-DESC(AA) REPLACING ALL " " BY X'A0'
           invoke plListBox::Items::Add(BAT310-PITCH-DESC(AA))
           add 1 to aa.
           go to 5-loop.
       10-done.

           IF BAT310-INFIELD-IP = "Y"
                  MOVE "if1.png" TO BAT310-BPARK-BITMAP.

      *      if HitLocationsform = null or HitLocationsform::IsDisposed
      *          next sentence
      *      else
      *          invoke HitLocationsform::Recalc.


       end method.
       
       method-id reloadCatchers final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           move 1 to aa.
           invoke catcherdd::Items::Clear.
       catcher-loop.
           if aa > DIALOG-CAT-NUM-ENTRIES
               go to catcher-done.
           invoke catcherdd::Items::Add(DIALOG-CAT(AA)::Trim)
           add 1 to aa
           go to catcher-loop.
       catcher-done.
           set catcherdd::SelectedIndex to 0
       end method.      
     

       method-id btnPitchTypes_Click final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           move "T" to BAT310-DISPLAY-TYPE
           INVOKE self::Recalc
       end method.

       method-id btnPitchResults_Click final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           move "R" to BAT310-DISPLAY-TYPE
           INVOKE self::Recalc
       end method.

       method-id allGamesButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "A" to BAT300-DATE-CHOICE-FLAG
           MOVE "A" to BAT300-GAME-FLAG
           MOVE "A" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to false
           set endDateRadioButton::Checked to false
           set allStartRadioButton::Checked to true
           set allEndRadioButton::Checked to true
       end method.

       method-id currentYearButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat310data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "C" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")

           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id pastYearButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "P" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")
           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id twoWeeksButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "W" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")

           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id currentMonthButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "M" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")
           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id twoMonthsButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "2" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")
           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id threeMonthsButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "3" to BAT300-DATE-CHOICE-FLAG
           MOVE "DC" to BAT300-ACTION
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")
           MOVE "D" to BAT300-GAME-FLAG
           MOVE "D" to BAT300-END-GAME-FLAG
           set startDateRadioButton::Checked to true
           set endDateRadioButton::Checked to true.
           set startDateTextBox::Text to BAT300-GAME-DATE::ToString("##/##/##").
           set endDateTextBox::Text to BAT300-END-GAME-DATE::ToString("##/##/##").
       end method.

       method-id batterteamButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "T " to BAT300-BATTER-SEL-FLAG
           invoke bHiddenFieldTeam_ModalPopupExtender::Show
       end method. 

       method-id bTeamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set BAT300-BATTER-TEAM to bTeamDropDownList::SelectedItem.
       end method.
     
       method-id pTeamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set BAT300-PITCHER-TEAM to pTeamDropDownList::SelectedItem.
       end method. 
       
       method-id bTeamOKButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if BAT300-BATTER-TEAM = spaces
               set BAT300-BATTER-TEAM to bTeamDropDownList::SelectedItem.
           MOVE "T" to BAT300-ACTION
           MOVE "TI" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           SET batterSelectionTextBox::Text to BAT300-BATTER::Trim
           set batterTextBox::Text to BAT300-BATTER
      *     invoke bHiddenFieldTeam_ModalPopupExtender::Hide
       end method.
   
       method-id pitcherteamButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "T " to BAT300-PITCHER-SEL-FLAG
           invoke pHiddenFieldTeam_ModalPopupExtender::Show
       end method. 
       
       method-id pTeamOKButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat300_dg.CPB".  
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           if BAT300-PITCHER-TEAM = spaces
               set BAT300-PITCHER-TEAM to pTeamDropDownList::SelectedItem.
           MOVE "T" to BAT300-ACTION
           MOVE "TI" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           SET pitcherSelectionTextBox::Text to BAT300-PITCHER::Trim
           set pitcherTextBox::Text to BAT300-PITCHER
       end method.
  
       method-id selectpitcherButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           MOVE "P" to BAT300-IND-PB-FLAG
           MOVE "I" to BAT300-PITCHER-SEL-FLAG
           MOVE "RP" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           move " " to BAT300-SEL-TEAM
           invoke self::populateTeam.     
           invoke ipHiddenField_ModalPopupExtender::Show
       end method.    
    
       method-id selectbatterButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           MOVE "B" to BAT300-IND-PB-FLAG
           MOVE "I" to BAT300-PITCHER-SEL-FLAG
           MOVE "RB" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           move " " to BAT300-SEL-TEAM
           invoke self::populateTeam.     
           invoke ipHiddenField_ModalPopupExtender::Show
       end method.    
         
       method-id teamDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           invoke self::populateTeam.     
       end method. 

       method-id populateTeam protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set BAT300-SEL-TEAM to teamDropDownList::SelectedItem
           
         if BAT300-IND-PB-FLAG = "P"
            MOVE BAT300-SEL-TEAM TO BAT300-PITCHER-ROSTER-TEAM
            MOVE "RP" TO BAT300-ACTION  
         else
            MOVE BAT300-SEL-TEAM TO BAT300-BATTER-ROSTER-TEAM
            MOVE "RB" TO BAT300-ACTION  
         end-if.
         
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           invoke bat310rununit::Call("BAT300WEBF")
           invoke playerListBox::Items::Clear.
           move 1 to aa.
       5-loop.
           if aa > BAT300-ROSTER-NUM-ENTRIES
               go to 10-done
           else
               invoke playerListBox::Items::Add(" " & BAT300-ROSTER-NAME(aa) & " " & BAT300-ROSTER-POS(aa)).
           add 1 to aa.
           go to 5-loop.
       10-done.
      *     set playernamelb::TopIndex to playernamelb::Items::Count - 1.
       end method.

       method-id playerListBox_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
      *    if team is changed instead of ok button
           if playerListBox::SelectedItem = null
               exit method.
           MOVE playerListBox::SelectedItem to BAT300-SEL-PLAYER
           
           if BAT300-IND-PB-FLAG = "P" THEN
               MOVE BAT300-ROSTER-ID(playerListBox::SelectedIndex + 1) TO BAT300-SAVE-PITCHER-ID
           ELSE
               MOVE BAT300-ROSTER-ID(playerListBox::SelectedIndex + 1) TO BAT300-SAVE-BATTER-ID
           END-IF.
       end method.
      
       method-id playerOKButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
         
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           if BAT300-IND-PB-FLAG = "P"
               move BAT300-SEL-TEAM to BAT300-PITCHER-ROSTER-TEAM  
               move BAT300-SEL-PLAYER to BAT300-PITCHER-DSP-NAME  
               move " " to BAT300-PITCHER-THROWS-FLAG
           else
               MOVE BAT300-SEL-TEAM TO BAT300-BATTER-ROSTER-TEAM
               MOVE BAT300-SEL-PLAYER TO BAT300-BATTER-DSP-NAME  
               move " " to BAT300-BATTER-BATS-FLAG
           end-if.
           MOVE "TI" TO BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           MOVE " " to BAT300-IND-PB-FLAG   
           set pitcherTextBox::Text to BAT300-PITCHER
           set batterTextBox::Text to BAT300-BATTER
       end method.  
   
       method-id pitcherallButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".   
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           MOVE "A" to BAT300-PITCHER-SEL-FLAG
           MOVE "TI" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           set pitcherSelectionTextBox::Text to BAT300-PITCHER::Trim
       end method.

       method-id batterallButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".   
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           MOVE "A" to BAT300-BATTER-SEL-FLAG
           MOVE "TI" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           set batterSelectionTextBox::Text to BAT300-BATTER::Trim
       end method.
       
       method-id resetselectionButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set allStartRadioButton::Checked to True
           set allendRadioButton::Checked to True 
           set allLocRadioButton::Checked to true
           set allTimeRadioButton::Checked to true
           set maxAtBatsCheckBox::Checked to false
           set maxABTextBox::Text to BAT300-MAX-NUM::ToString
           set myCheckBox::Checked to false
           set batseitherRadioButton::Checked to true
           set throwseitherRadioButton::Checked to true
           set allinningsRadioButton::Checked to true
           set batteranyRadioButton::Checked to true
           set pitcheranyRadioButton::Checked to true
       end method.

       method-id goButton_Click protected.
       local-storage section.
       01 gmDate        type Single.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           invoke type System.Single::TryParse(startDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT300-GAME-DATE to gmDate 
           invoke type System.Single::TryParse(endDateTextBox::Text::ToString::Replace("/", ""), by reference gmDate)
           set BAT300-END-GAME-DATE to gmDate
           MOVE "GO" to BAT300-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
      *     if ERROR-FOUND = "Y" 
      *         MOVE " " TO ERROR-FOUND
      *         MOVE " " TO BAT300-ACTION
      *         call "BAT300WINF"
      *     else
      *         set self::DialogResult to type DialogResult::OK.
           invoke self::reloadCatchers
           invoke self::Recalc
       end method.
       
       method-id allButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit") as
               type RunUnit
           MOVE "VA" TO BAT310-ACTION
           invoke bat310rununit::Call("BAT310WEBF")
           invoke self::batstube.
       end method.
       
       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer   
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
       lines-loop.
           if aa > BAT310-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & BAT310-WF-VIDEO-PATH(aa) & BAT310-WF-VIDEO-A(aa) & ","
PM         set vidTitles to vidTitles & BAT310-WF-VIDEO-TITL(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
           invoke self::ClientScript::RegisterStartupScript(self::GetType(), "callcallBatstube", "callBatstube();", true).
       end method.
       
       method-id allStartRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "A" to BAT300-GAME-FLAG
       end method.

       method-id startDateRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "D" to BAT300-GAME-FLAG
       end method.

       method-id allEndRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
          MOVE "A" to BAT300-END-GAME-FLAG
       end method.

       method-id endDateRadioButton_CheckedChanged protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "A" to BAT300-END-GAME-FLAG
       end method.
       
       method-id allLocRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           move " " to BAT300-BATTER-LOC-FLAG
           move " " to BAT300-PITCHER-LOC-FLAG.
       end method.

       method-id pitchHomeRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           move "A" to BAT300-BATTER-LOC-FLAG
           move "H" to BAT300-PITCHER-LOC-FLAG.
       end method.

       method-id pitchAwayRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           move "H" to BAT300-BATTER-LOC-FLAG
           move "A" to BAT300-PITCHER-LOC-FLAG.
       end method.

       method-id allTimeRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "A" to BAT300-TIME-FLAG.
       end method.

       method-id dayRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "D" to BAT300-TIME-FLAG.
       end method.

       method-id nightRadioButton_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           MOVE "N" to BAT300-TIME-FLAG.
       end method.

       method-id maxAtBatsCheckBox_CheckedChanged protected.
       01 abnum    type Single.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
           if maxAtBatsCheckBox::Checked
               move "Y" to BAT300-MAX-FLAG
               invoke maxABTextBox::Focus
               invoke type System.Single::TryParse(maxABTextBox::Text::ToString, by reference abnum)
               set BAT300-MAX-NUM TO abnum
            else
               move "N" to BAT300-MAX-FLAG.
       end method.

       method-id myCheckBox_CheckedChanged protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\bat300_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata300 to self::Session["bat300data"] as type batsweb.bat300Data
           set address of BAT300-DIALOG-FIELDS to myData300::tablePointer
            if myCheckBox::Checked
               move "Y" to BAT300-TEAM-ONLY-FLAG
            else
               move "N" to BAT300-TEAM-ONLY-FLAG.
       end method.
  
       method-id typesButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           move "T" to BAT310-DISPLAY-TYPE
           INVOKE self::Recalc
       end method.

       method-id resultsButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           move "R" to BAT310-DISPLAY-TYPE
           INVOKE self::Recalc
       end method.

       method-id videosButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           MOVE "SC" TO BAT310-ACTION
           CALL "BAT310WINF"
      *     set ComparePlaysForm to new type BatterPitcherBreakdown.ComparePlaysForm
      *     invoke ComparePlaysForm::Show
       end method.
  
       method-id prevButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           IF DIALOG-CNT-IDX < 3 or DIALOG-CNT-IDX > 13
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You must select a count!');", true)
               exit method
           Else
      *         set PrevPitchForm to new type BatterPitcherBreakdown.PrevPitchForm
      *         invoke PrevPitchForm::Show
       end method.

       method-id nextButton_Click protected.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           IF DIALOG-CNT-IDX < 2 or DIALOG-CNT-IDX > 13
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('You must select a count!');", true)
               exit method
           Else
      *         set NextPitchForm to new type BatterPitcherBreakdown.NextPitchForm
      *         invoke NextPitchForm::Show.
       end method.

       end class.
