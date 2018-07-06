       class-id pucksweb.summaryFwdLinesDefPairs is partial 
                implements type System.Web.UI.ICallbackEventHandler
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 pk360rununit         type RunUnit.
       01 PK360WEBF                type PK360WEBF.
       01 mydata type pucksweb.pk360Data.
       01 callbackReturn type String.
       
       method-id Page_Load protected.
       local-storage section.
       01  shotValue            type Single.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.       
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
           if self::IsPostBack
               exit method.

           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer

           if PK360-TOI-TEAM-FLAG = "H"
               set lblTeam::Text to PK360-I-HOME
           else
               set lblTeam::Text to PK360-I-VIS.
           invoke self::loadLines

           goback.
       end method.


      *#####               Client Callback Implementation             #####
      *##### (https://msdn.microsoft.com/en-us/library/ms178208.aspx) #####
      *####################################################################
 
       method-id RaiseCallbackEvent public.
       local-storage section.
       01 actionFlag type String.
       01 methodArg type String.       
       01 n          type Single.
       01 num          type String.
       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           
           if actionFlag = 'def-even' or 'def-sh' or 'fwd-even' or 'fwd-pp'
               set callbackReturn to actionFlag & "|" & self::lineSelected(actionFlag, methodArg)
           else if actionFlag = "opp-toi"
               set callbackReturn to actionFlag & "|" & self::oppToi(actionFlag, methodArg)
           else if actionFlag = 'update-toi'
               set callbackReturn to actionFlag & "|" & self::toiSelected(methodArg)
           else if actionFlag = "update-toi-dblclick"
               set callbackReturn to actionFlag & "|" & self::toiSelected(methodArg)
           else if actionFlag = 'from-toi'
               set callbackReturn to actionFlag & "|" & self::fromToi(methodArg)             
           else if actionFlag = 'def-opp'
               set callbackReturn to actionFlag & "|" & self::oppLines('d')
           else if actionFlag = 'fwd-opp'
               set callbackReturn to actionFlag & "|" & self::oppLines('f').
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################
        
       method-id loadLines final private.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer
           move 1 to aa.
           if PK360-TOI-TEAM-FLAG = "V"
               go to vis-def-ev
           else
               go to home-def-ev.
               
       vis-def-ev.
           if aa > PK360-V-DEF-EV-NUM-LINES
               move 1 to aa
               go to vis-def-sh.
           set defEvenField::Value to defEvenField::Value & PK360-V-DEF-EV-DATA-LINE(AA)::Trim & ";"
           add 1 to aa.
           go to vis-def-ev.
       vis-def-sh.
           if aa > PK360-V-DEF-SH-NUM-LINES
               move 1 to aa
               go to vis-fwd-ev.       
           set defShField::Value to defShField::Value & PK360-V-DEF-SH-DATA-LINE(AA)::Trim & ";"
           add 1 to aa.
           go to vis-def-sh.
       vis-fwd-ev.
           if aa > PK360-V-FWD-EV-NUM-LINES
               move 1 to aa
               go to vis-fwd-pp.       
           set fwdEvenField::Value to fwdEvenField::Value & PK360-V-FWD-EV-DATA-LINE(aa)::Trim & ";"
           add 1 to aa.
           go to vis-fwd-ev.       
       vis-fwd-pp.
           if aa > PK360-V-FWD-PP-NUM-LINES
               move 1 to aa
               exit method.       
           set fwdPpField::Value to fwdPpField::Value & PK360-V-FWD-PP-DATA-LINE(aa)::Trim & ";"
           add 1 to aa.
           go to vis-fwd-pp.  
           
       home-def-ev.
           if aa > PK360-H-DEF-EV-NUM-LINES
               move 1 to aa
               go to home-def-sh.
           set defEvenField::Value to defEvenField::Value & PK360-H-DEF-EV-DATA-LINE(AA)::Trim & ";"
           add 1 to aa.
           go to home-def-ev.
       home-def-sh.
           if aa > PK360-H-DEF-SH-NUM-LINES
               move 1 to aa
               go to home-fwd-ev.       
           set defShField::Value to defShField::Value & PK360-H-DEF-SH-DATA-LINE(AA)::Trim & ";"
           add 1 to aa.
           go to home-def-sh.
       home-fwd-ev.
           if aa > PK360-H-FWD-EV-NUM-LINES
               move 1 to aa
               go to home-fwd-pp.       
           set fwdEvenField::Value to fwdEvenField::Value & PK360-H-FWD-EV-DATA-LINE(aa)::Trim & ";"
           add 1 to aa.
           go to home-fwd-ev.       
       home-fwd-pp.
           if aa > PK360-H-FWD-PP-NUM-LINES
               exit method.       
           set fwdPpField::Value to fwdPpField::Value & PK360-H-FWD-PP-DATA-LINE(aa)::Trim & ";"
           add 1 to aa.
           go to home-fwd-pp.             
       end method.

       method-id lineSelected protected.
       local-storage section.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value actionFlag as type String
                          indexString as type String
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type Int32::TryParse(indexString, reference selected)
           set PK360-SEL-LINE TO selected + 1
           if PK360-TOI-TEAM-FLAG = "H"
               if actionFlag = "fwd-pp"
                   move "HF2" to PK360-ACTION
               else if actionFlag = "fwd-even"
                   move "HF1" to PK360-ACTION
               else if actionFlag = "def-even"
                   move "HD1" to PK360-ACTION
               else if actionFlag = "def-sh"
                   move "HD2" to PK360-ACTION.
           if PK360-TOI-TEAM-FLAG = "V"
               if actionFlag = "fwd-pp"
                   move "VF2" to PK360-ACTION
               else if actionFlag = "fwd-even"
                   move "VF1" to PK360-ACTION
               else if actionFlag = "def-even"
                   move "VD1" to PK360-ACTION
               else if actionFlag = "def-sh"
                   move "VD2" to PK360-ACTION.
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          

           set playReturn to self::toiLines.

       end method.

       method-id toiLines final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-TOI
               go to 10-done.
           set dataLine to (" " & PK360-T-PERIOD(aa) & " " & PK360-T-IN-TIME-XXX(AA) & " " & PK360-T-OUT-TIME-XXX(AA) & " " &
               type System.String::Format("{0,5:#####}", PK360-T-DURATION(AA)) & " " & PK360-T-SHIFT-TYPE(AA))
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.
       
       end method.

       method-id oppToi protected.
       local-storage section.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value actionFlag as type String
                          indexString as type String
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type Int32::TryParse(indexString, reference selected)
           set PK360-SEL-OPP-LINE TO selected + 1
           move "OLV" to PK360-ACTION.
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          

           set playReturn to self::toiLines.

       end method.

       method-id oppLines protected.
       local-storage section.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value defFwd as type Char
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

           if PK360-SEL-LINE = 0
               set playReturn to "er|" & "You must select a pair!"
               exit method.
           if defFwd = "d"
               if PK360-TOI-TEAM-FLAG = "V"
                   move "VO1" to PK360-ACTION
                   invoke pk360rununit::Call("PK360WEBF")
                   move "H" to PK360-OPP-IP-FLAG           
               else
                   move "HO1" to PK360-ACTION
                   invoke pk360rununit::Call("PK360WEBF")
                   move "V" to PK360-OPP-IP-FLAG.
           if defFwd = "f"
               if PK360-TOI-TEAM-FLAG = "V"
                   move "VO2" to PK360-ACTION
                   invoke pk360rununit::Call("PK360WEBF")
                   move "H" to PK360-OPP-IP-FLAG           
               else
                   move "HO2" to PK360-ACTION
                   invoke pk360rununit::Call("PK360WEBF")
                   move "V" to PK360-OPP-IP-FLAG.

           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          

           set playReturn to self::loadOpp
       end method.


       method-id loadOpp final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
       
           move 1 to aa.
       5-loop.
           if aa > PK360-NUM-OFF-LINES
               go to 10-done.
           set dataLine to (PK360-LINE-TEAM(aa) & " " & PK360-LINE-NAMES(AA) & " " & type System.String::Format("{0,5:####0}", PK360-LINE-MIN(AA)) & PK360-LINE-COLON(AA) & 
               PK360-LINE-SECS(AA)::ToString("00") & " " & type System.String::Format("{0,4:###0}", PK360-LINE-5-FOR(AA)) & " " & type System.String::Format("{0,4:###0}", PK360-LINE-5-AG(AA)) &  " " &                                                                                                                                                                                                                                             
               type System.String::Format("{0,5:####0}", PK360-LINE-5-TOT(AA)) & " " & type System.String::Format("{0,4:###0}", PK360-LINE-SV-FOR(AA)) & " " & type System.String::Format("{0,4:###0}", PK360-LINE-SV-AG(AA)) &                                                                                                                                                                        
               " " & type System.String::Format("{0,5:####0}", PK360-LINE-SV-TOT(AA)))                                 
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.
       end method.


       method-id toiSelected protected.
       local-storage section.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           if indexString = null
               set PK360-TOI-IP, PK360-WK-T-IP to 0
               exit method.
           invoke type Int32::TryParse(indexString, reference selected)
           set PK360-TOI-IP to selected + 1
           set PK360-WK-T-IP TO PK360-TOI-IP
                          
           MOVE "TP" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.


       method-id fromToi protected.
       local-storage section.
       01 selected  type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit

           if indexString = null
               set PK360-TOI-IP, PK360-WK-T-IP to 0
           else
               invoke type Int32::TryParse(indexString, reference selected)
               set PK360-TOI-IP to selected + 1
               set PK360-WK-T-IP TO PK360-TOI-IP.
                                         
           MOVE "TA" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

       method-id batstube protected.
       local-storage section.
PM     01 vidPaths type String. 
 PM    01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set vidPaths to ""
PM         set vidTitles to ""
           move 1 to aa.
           
       lines-loop.
           if aa > PK360-WF-VID-COUNT
               go to lines-done.
           
PM         set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa)::Trim & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
               (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM    *     set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-A(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
      *         (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
PM         set vidTitles to vidTitles & PK360-WF-VIDEO-TITL(aa) & ";"
           
           if PK360-WF-VIDEO-B(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-B(aa) & "#t=" &  PK360-WF-VIDEO-START(AA) & "," & 
               (PK360-WF-VIDEO-START(AA) + PK360-WF-VIDEO-DURATION(AA)) & ";"
               set vidTitles to vidTitles & "B;".
           if PK360-WF-VIDEO-C(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-C(aa) & ";"
               set vidTitles to vidTitles & "C;".
           if PK360-WF-VIDEO-D(aa) not = spaces
               set vidPaths to vidPaths & PK360-WF-VIDEO-PATH(aa) & PK360-WF-VIDEO-D(aa) & ";"
               set vidTitles to vidTitles & "D;".
           
           add 1 to aa.
           go to lines-loop.
       lines-done.
       
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles
       end method.

       end class.
