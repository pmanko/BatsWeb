       class-id batsweb.EZvideo is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "C:\Users\Piotrek\sydexsource\shared\WS-SYS.CBL".
       01 batsw060rununit         type RunUnit.
       01 BATSW060WEBF                type BATSW060WEBF.
       01 mydata type batsweb.batsw060Data.
       01 gmDate        type Single.
       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".

       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.

           if self::IsPostBack
               exit method.

           if  self::Session::Item("w060rununit") not = null
               set batsw060rununit to self::Session::Item("w060rununit")
               as type RunUnit
                ELSE
                set batsw060rununit to type RunUnit::New()
                set BATSW060WEBF to new BATSW060WEBF
                invoke batsw060rununit::Add(BATSW060WEBF)
                set self::Session::Item("w060rununit") to  batsw060rununit.

           invoke ListBox1::Attributes::Add("ondblclick", ClientScript::GetPostBackEventReference(ListBox1, "move"))
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer

           move "I" to BATSW060-ACTION
           invoke batsw060rununit::Call("BATSW060WEBF")
           set headerLabel::Text to headerLabel::Text::Replace(" ", "&nbsp;")
           set textBox1::Text to BATSW060-START-DATE::ToString("00/00/00")
           set textBox2::Text to BATSW060-END-DATE::ToString("00/00/00")
           invoke self::populate_listbox().
           goback.
       end method.

       method-id populate_listbox protected.
       linkage section.
            COPY "C:\Users\Piotrek\sydexsource
            \BATS\batsw060webf_dg.CPB".
       procedure division.
            set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
            set address of BATSW060-DIALOG-FIELDS to myData::tablePointer

            invoke ListBox1::Items::Clear.
            move 1 to aa.
       vid-loop.
           if aa > BATSW060-NUM-VID
               go to vid-done.
           invoke ListBox1::Items::Add(BATSW060-V-TEAM(aa) & " " & BATSW060-V-NAME(aa) & " " & BATSW060-V-DSP-DATE(aa)::ToString("0#/##/##") & " " & BATSW060-V-DESC(aa))
           add 1 to aa
           go to vid-loop.
       vid-done.

       end method.

       method-id RadioButtonTeam_CheckedChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           move 1 to BATSW060-SORT-TYPE.
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::populate_listbox().
       end method.

       method-id RadioButtonName_CheckedChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           move 2 to BATSW060-SORT-TYPE.
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::populate_listbox().
       end method.

       method-id RadioButtonDate_CheckedChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           move 3 to BATSW060-SORT-TYPE.
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::populate_listbox().
       end method.

       method-id Button2_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke type System.Single::TryParse(TextBox1::Text::ToString::Replace("/", ""), by reference gmDate)
           set BATSW060-START-DATE to gmDate
           invoke type System.Single::TryParse(TextBox2::Text::ToString::Replace("/", ""), by reference gmDate)
           set BATSW060-END-DATE to gmDate
           invoke self::populate_listbox().

       end method.


       method-id ListBox1_SelectedIndexChanged protected.
       local-storage section.
PM     01 vidPaths type String.
 PM    01 vidTitles type String.
       01 selected  type Int32[].
      *01 newListItem type ListItem.
       linkage section.
       COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".


       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           initialize BATSW060-SEL-VID-TBL
           move 0 to aa.
           set selected to ListBox1::GetSelectedIndices.
       videos-loop.
           if aa = selected::Count
               go to videos-done.
           MOVE "Y" TO BATSW060-SEL-VID-FLAG(selected[aa] + 1).
           add 1 to aa.
           go to videos-loop.
       videos-done.
           MOVE "PV" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::batstube.

      *     if aa > BATSW060-NUM-SEL
       end method.


       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer       
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
       lines-loop.
           if aa > BATSW060-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & BATSW060-WF-VIDEO-PATH(aa) & BATSW060-WF-VIDEO-A(aa) & ","
PM         set vidTitles to vidTitles & BATSW060-WF-VIDEO-TITL(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
           invoke self::ClientScript::RegisterStartupScript(self::GetType(), "callcallBatstube", "callBatstube();", true).
       end method.


       method-id Button3_Click protected.
      * Play video Button
       procedure division using by value sender as object e as type System.EventArgs.
      *    invoke self::ClientScript::RegisterStartupScript(self::GetType(), "alert", "callBatstube();", true).
           invoke self::batstube.
       end method.

       method-id allGamesButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "A" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to "01/01/00".
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id currentYearButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "C" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id pastYearButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "P" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id twoWeeksButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "W" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id currentMonthButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "M" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id twoMonthsButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "2" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.

       method-id threeMonthsButton_Click protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           MOVE "3" to BATSW060-DATE-CHOICE-FLAG
           MOVE "DC" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke BATSW060rununit::Call("BATSW060WEBF")
           set TextBox1::Text to BATSW060-START-DATE::ToString("##/##/##").
           set TextBox2::Text to BATSW060-END-DATE::ToString("##/##/##").
       end method.
       end class.
