       class-id batsweb.EZvideo is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 batsw060rununit         type RunUnit.
       01 BATSW060WEBF                type BATSW060WEBF.
       01 mydata type batsweb.batsw060Data.
       01 gmDate        type Single.
       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".

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

           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer

           move "I" to BATSW060-ACTION
           invoke batsw060rununit::Call("BATSW060WEBF")
           set textBox1::Text to BATSW060-START-DATE::ToString("00/00/00")
           set textBox2::Text to BATSW060-END-DATE::ToString("00/00/00")
           invoke self::populate_listbox().
           goback.
       end method.

       method-id populate_listbox protected.
       linkage section.
            COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
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




       method-id allGamesButton_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::populate_listbox().
       end method.

       method-id Button2_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".
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
       COPY "Y:\sydexsource\BATS\batsw060webf_dg.CPB".


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

PM         set vidPaths to ""
PM         set vidTitles to ""
      *    invoke BulletedList2::Items::Clear
           move 1 to aa.
       lines-loop.
           if aa > BATSW060-NUM-SEL
               go to lines-done.
      *    set newListItem to new ListItem
      *    set newListItem::Text to BAT666-WF-VIDEO-TITL(AA) & " | " & BAT666-WF-VIDEO-A(aa) & ":" & BAT666-WF-VIDEO-B(aa) & ":" & BAT666-WF-VIDEO-C(aa) & ":" & BAT666-WF-VIDEO-D(aa)
      *    invoke newListItem::Attributes::Add("class", "list-group-item")
      *    invoke BulletedList2::Items::Add(newListItem)

PM         set vidPaths to vidPaths & BATSW060-WF-VIDEO-PATH(aa) & BATSW060-WF-VIDEO-A(aa) & ","
PM         set vidTitles to vidTitles & BATSW060-WF-VIDEO-TITL(aa) & ","

           add 1 to aa.
           go to lines-loop.
       lines-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
      *    set vid_paths::Value to getVidPaths
      *    set vid_titles::Value to getVidTitles
           invoke self::ClientScript::RegisterStartupScript(self::GetType(), "alert", "callBatstube();", true).
       end method.





       end class.
