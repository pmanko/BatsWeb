       class-id batsweb.atbatdetail is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.

       method-id Page_Load protected.
       local-storage section.
       01 dataLine         type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           if self::IsPostBack
               exit method.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set dateTextBox::Text to BAT360-GAME-DATE-DSP::ToString("00/00/00")
           set visTextBox::Text to BAT360-I-VIS::Trim
           set homeTextBox::Text to BAT360-I-HOME::Trim
           set visScoreTextBox::Text to BAT360-I-VIS-SCORE::ToString
           set homeScoreTextBox::Text to BAT360-I-HOME-SCORE::ToString
           set inningTextBox::Text to BAT360-I-INNING::ToString
           set battingTextBox::Text to BAT360-I-CURR-BATTING::ToString
           set pitcherTextBox::Text to BAT360-PITCHER::Trim
           set batterTextBox::Text to BAT360-BATTER::Trim
           set outsLabel::Text to BAT360-I-OUTS::ToString
           set hitLabel::Text to BAT360-I-HIT-DESC::Trim
           set resultLabel::Text to BAT360-I-RES-DESC::Trim
           set posLabel1::Text to BAT360-I-FIELDER-POS::Trim
           set posLabel2::Text to BAT360-I-FIELDER2-POS::Trim
           set fieldedLabel1::Text to BAT360-I-FIELDER-NAME::Trim
           set fieldedLabel2::Text to BAT360-I-FIELDER2-NAME::Trim
           set flagLabel1::Text to BAT360-I-FIELDER-FLAG::Trim
           set flagLabel2::Text to BAT360-I-FIELDER2-FLAG::Trim
           set countLabel::Text to BAT360-I-FINAL-COUNT::Trim
           set rbiLabel::Text to BAT360-I-RBI::ToString
           set catcherLabel::Text to BAT360-CATCHER
           move 1 to aa.
           invoke ListBox1::Items::Clear.
       pitch-loop.
           if aa > BAT360-NUM-PITCHES
               go to pitch-done.
           set dataline to (" " & BAT360-P-NUM(aa) & "  " & BAT360-P-TYPE(aa) & "  " & BAT360-P-DESC(aa) &
           " " & BAT360-P-RESULT(aa) & " " & BAT360-P-VEL(aa) & " " & BAT360-P-FLAG(aa) & BAT360-P-FLAG2(AA) & "  " & BAT360-P-VIDEO(aa))
           INSPECT dataline REPLACING ALL " " BY X'A0'
           invoke ListBox1::Items::Add(dataline)
           add 1 to aa
           go to pitch-loop.
       pitch-done.
           set Label1::Text to Label1::Text::Replace(" ", "&nbsp;")
           goback.
       end method.
       
       method-id szoneImageButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat360_dg.CPB".
       procedure division using by value sender as object e as type System.Web.UI.ImageClickEventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer       
           set bat360rununit to self::Session::Item("360rununit")
               as type RunUnit      
           set MOUSEX to e::X
           set MOUSEY to e::Y
           move "MO" to BAT360-ACTION
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
       
       end class.
