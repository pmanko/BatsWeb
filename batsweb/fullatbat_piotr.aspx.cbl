       class-id batsweb.fullatbat_piotr is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
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
           COPY "Y:\sydexsource\bats\bat666_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
       end method.
 

       method-id DropDownList1_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag

           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
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
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".
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
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB".   
       procedure division using by value sender as object e as type System.EventArgs.
      *     if DropDownList4::SelectedItem = null
      *   invoke type System.Web.UI.ScriptManager::RegisterStartupScript(self, type of self, "yourMessage", "window.onload = function(){alert('" & mymsg & "');}", true).
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
           invoke ListBox1::Items::Clear
           move 1 to aa.
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
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB". 
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
       local-storage section.
       01 getVidPaths type String. 
       01 getVidTitles type String.
       01 newListItem type ListItem.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB". 

       procedure division using by value sender as object e as type System.EventArgs.
           call "CBL_GET_SHMEM_PTR" using  SH-BAT666-MEM-POINTER node-name
               returning mem-flag
           set address of BAT666-DIALOG-FIELDS  to SH-BAT666-MEM-POINTER
           MOVE "Y" TO BAT666-T-SEL(ListBox1::SelectedIndex + 1).
           MOVE "               00000000000" TO BAT666-I-KEY.
           MOVE "VS" to BAT666-ACTION
           set bat666rununit to self::Session::Item("rununit") as type RunUnit
       
           invoke bat666rununit::Call("BAT666WEBF")
           
           set getVidPaths to ""
           set getVidTitles to ""
           invoke BulletedList2::Items::Clear
           move 1 to aa.
       lines-loop.
           if aa > BAT666-WF-VID-COUNT
               go to lines-done.
      *    set Label4::Text to Label4::Text & BAT666-WF-VIDEO-TITL(aa) & BAT666-WF-VIDEO-PATH(aa) & BAT666-WF-VIDEO-A(aa) & "<br/>" 
           
           set newListItem to new ListItem
           set newListItem::Text to BAT666-WF-VIDEO-TITL(AA) & " | " & BAT666-WF-VIDEO-A(aa) & ":" & BAT666-WF-VIDEO-B(aa) & ":" & BAT666-WF-VIDEO-C(aa) & ":" & BAT666-WF-VIDEO-D(aa)
           invoke newListItem::Attributes::Add("class", "list-group-item")
           invoke BulletedList2::Items::Add(newListItem)
           
           set getVidPaths to getVidPaths & BAT666-WF-VIDEO-PATH(aa) & BAT666-WF-VIDEO-A(aa) & ","
           set getVidTitles to getVidTitles & BAT666-WF-VIDEO-TITL(aa) & ","
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
           set vid_paths::Value to getVidPaths
           set vid_titles::Value to getVidTitles
      *    invoke self::Response::Redirect("Vids.html#?paths=" & getParams, false)

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
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB". 
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

       method-id Button8_Click protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat666_dg.CPB". 

       procedure division using by value sender as object e as type System.EventArgs.
       end method.



       end class.
