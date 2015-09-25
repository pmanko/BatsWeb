       class-id batsweb.EZvideo is partial
                inherits type System.Web.UI.Page public.

       working-storage section.
       COPY "y:\sydexsource\shared\WS-SYS.CBL".
       01 batsw060rununit         type RunUnit.
       01 BATSW060WEBF                type BATSW060WEBF.
       01 mydata type batsweb.batsw060Data.
       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".

       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.

           if self::IsPostBack
               go to POST-done.

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
           invoke self::populate_listbox().
       POST-done.
           goback.
       end method.

       method-id populate_listbox protected.
       linkage section.
            COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
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
           COPY "Y:\SYDEXSOURCE\BATS\batsw060webf_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["batsw060data"] as type batsweb.batsw060Data
           set address of BATSW060-DIALOG-FIELDS to myData::tablePointer
           move "RG" to BATSW060-ACTION
           set batsw060rununit to self::Session::Item("w060rununit") as
               type RunUnit
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke self::populate_listbox().
 
       end method.

       end class.

