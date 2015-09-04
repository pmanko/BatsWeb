       class-id batsweb.fullatbat is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "C:\Users\Piotrek\sydexsource\shared\WS-SYS.CBL".
       01  node-name.
           05  name-len         pic x comp-5 value 10.
           05  id1              pic x(10) value "bat666_dg".        
       01  mem-flag             pic x(4) comp-5.
       01  mem-size             pic x(4) comp-5.
       01 bat666rununit         type RunUnit.
       01 BAT666WEBF                type BAT666WEBF.
       01 SH-BAT666-MEM-POINTER           POINTER.

       method-id Page_Load protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\bats\bat666_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
      *     invoke Button5::Attributes::Add("onclick", "return window.confirm('Are you sure?')")
           if self::IsPostBack
               go to team-done.
           invoke self::ClientScript::RegisterStartupScript(type of self, "yourMessage", 
           'function HandleOnclose() {alert("Close Session"); PageMethods.CleanupPage();}'
            & 'window.onbeforeunload = HandleOnclose;', true)
      *     invoke self::OnUnload(new System.Web.UI.Page.
      *     add_FormClosed(new System.Windows.Forms.FormClosedEventHandler(self::batssy30form1_Closed)).
           set bat666rununit to type RunUnit::New() 
           set BAT666WEBF to new BAT666WEBF
           invoke bat666rununit::Add(BAT666WEBF)
           set self::Session::Item("rununit") to  bat666rununit

           set mem-size to length of BAT666-DIALOG-FIELDS.
           call "CBL_ALLOC_SHMEM" using
               by reference SH-BAT666-MEM-POINTER
               by value mem-size
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS to SH-BAT666-MEM-POINTER
           call "CBL_PUT_SHMEM_PTR" using
               by value SH-BAT666-MEM-POINTER
               by reference node-name.
           INITIALIZE BAT666-DIALOG-FIELDS
           set BAT666-WEB-FORM-SESSION-ID to self::Session::SessionID
           set BAT666-WEB-FORM-DB to self::Session::Item("database") 
           move "I" to BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")

           move 1 to aa.
       team-loop.
           if aa > BAT666-NUM-TEAMS
               go to team-done.
           invoke DropDownList3::Items::Add(BAT666-TEAM-NAME(aa))
           invoke DropDownList1::Items::Add(BAT666-TEAM-NAME(aa))
           add 1 to aa
           go to team-loop.
       team-done.
           goback.
       end method.
 
       method-id DropDownList1_SelectedIndexChanged protected.
       linkage section.
           COPY "c:\Users\Piotrek\SYDEXSOURCE\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag

           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           set Panel9::Height to 111
           set Panel9::Width to 239
      *     set Panel9::Visible to true.   
           MOVE BAT666-TEAM-NAME(DropDownList1::SelectedIndex + 1) to BAT666-SEL-TEAM
           MOVE BAT666-SEL-TEAM to BAT666-PITCHER-ROSTER-TEAM
           MOVE "P" to BAT666-IND-PB-FLAG
           MOVE "RP" to BAT668-ACTION
           MOVE "T" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           move 1 to aa.
       pitcher-loop.
           if aa > BAT666-ROSTER-NUM-ENTRIES
               go to pitcher-done.
           invoke DropDownList2::Items::Add(BAT666-ROSTER-NAME(aa) & " " & BAT666-ROSTER-POS(aa))
           add 1 to aa
           go to pitcher-loop.
       pitcher-done.
       end method.

       method-id DropDownList3_SelectedIndexChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\SYDEXSOURCE\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           MOVE BAT666-TEAM-NAME(DropDownList1::SelectedIndex + 1) to BAT666-SEL-TEAM
           MOVE BAT666-SEL-TEAM to BAT666-PITCHER-ROSTER-TEAM
           MOVE "B" to BAT666-IND-PB-FLAG
           MOVE "RP" to BAT668-ACTION
           MOVE "T" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           move 1 to aa.
       batter-loop.
           if aa > BAT666-ROSTER-NUM-ENTRIES
               go to batter-done.
           invoke DropDownList4::Items::Add(BAT666-ROSTER-NAME(aa) & " " & BAT666-ROSTER-POS(aa))
           add 1 to aa
           go to batter-loop.
       batter-done.
       end method.

       method-id Button5_Click protected.
       local-storage section.
       01 javaScript type System.Text.StringBuilder.
       01 confirmMessage type String.
       linkage section.
           COPY "C:\Users\Piotrek\SYDEXSOURCE\BATS\bat666_dg.CPB".   
       procedure division using by value sender as object e as type System.EventArgs.
          declare mymsg = "This is a message!"
      *     if DropDownList4::SelectedItem = null
          invoke type System.Web.UI.ScriptManager::RegisterStartupScript(self, type of self, "yourMessage", "window.onload = function(){alert('" & mymsg & "');}", true).
      *     if DropDownList1::SelectedItem = null
      *         invoke javaScript::Append("var userConfirmation = window.confirm('" + confirmMessage + "')")
      *         invoke javaScript::Append("__doPostBack('UserConfirmationPostBack',userConfirmation);")
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           MOVE "GO" to BAT668-ACTION
           MOVE "T" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")

           MOVE "RA" TO BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           move 1 to aa.
           set Label4::Text to BAT666-WF-VIDEO-TITL(1).
       lines-loop.
           if aa > BAT666-NUM-AB
               go to lines-done.
           invoke ListBox1::Items::Add(BAT666-T-LINE(aa))
           add 1 to aa.
           go to lines-loop.
       lines-done.
       end method.

       method-id DropDownList2_SelectedIndexChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat666_dg.CPB". 
       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           MOVE BAT666-ROSTER-NAME(DropDownList2::SelectedIndex + 1) to BAT666-SEL-PLAYER
           MOVE BAT666-ROSTER-ID(DropDownList2::SelectedIndex + 1) to BAT666-SAVE-PITCHER-ID
           MOVE "I " to BAT666-PITCHER-FLAG
           MOVE BAT666-SEL-TEAM to BAT666-PITCHER-ROSTER-TEAM
           MOVE BAT666-SEL-PLAYER to BAT666-PITCHER-DSP-NAME
           MOVE "TI" to BAT668-ACTION
           MOVE "T" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
           invoke bat666rununit::Call("BAT666WEBF")
           MOVE " " to BAT666-IND-PB-FLAG
       end method.

       method-id ListBox1_SelectedIndexChanged protected.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat666_dg.CPB". 

       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           MOVE "Y" TO BAT666-T-SEL(ListBox1::SelectedIndex + 1).
           MOVE "               00000000000" TO BAT666-I-KEY.
           MOVE "VS" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
       
           invoke bat666rununit::Call("BAT666WEBF")
       
       end method.

       method-id DropDownList5_SelectedIndexChanged protected.
       procedure division using by value sender as object e as type System.EventArgs.
       end method.

       method-id Button1_Click protected.
       local-storage section.
       01 confirmMessage type String.
       procedure division using by value sender as object e as type System.EventArgs.
           set confirmMessage to "Haltest"
           if DropDownList4::SelectedItem = null
               invoke ClientScript::RegisterStartupScript(self::GetType, "myalert", "alert(confirmMessage)", true).
      *    declare mymsg = "This is a message!"
      *    invoke type System.Web.UI.ScriptManager::RegisterStartupScript(self, type of self, "yourMessage", "window.onload = function(){alert('" & mymsg & "');}", true)

       end method.
    
       method-id CleanupPage public static
       attribute System.Web.Services.WebMethod.
       local-storage section.
       01 confirmMessage type String.
       linkage section.
           COPY "C:\Users\Piotrek\sydexsource\BATS\bat666_dg.CPB". 
       procedure division.
           continue
      *      set bat666rununit to self::Session::Item("rununit") as type RunUnit
      *     call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
      *         returning mem-flag
      *     set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           set confirmMessage to "Haltest"

      *     MOVE "X" TO BAT666-ACTION.
      *     invoke bat666rununit::Call("BAT666WEBF")

      *     invoke bat666rununit::StopRun.
      *     call "CBL_FREE_SHMEM" using  SH-BAT666-MEM-POINTER
           goback.
       end method.

       end class.
