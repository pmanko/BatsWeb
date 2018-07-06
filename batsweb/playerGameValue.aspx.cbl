       class-id pucksweb.playerGameValue is partial 
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

           set lblHome::Text to PK360-I-HOME
           set lblVis::Text to PK360-I-VIS
*******Visitor Loop*************
           move 1 to aa.
       5-loop.
           if PK360-V-TOI-NAME(aa) = " " 
               go to 10-done.
            
           set visField::Value to visField::Value & PK360-V-TOI-NAME(AA)::Trim
           set shotValue to PK360-E-V-SHOT-VALUE(AA)
           set visField::Value to visField::Value & "," & shotValue
           set visField::Value to visField::Value & "," & PK360-T-V-5PCT-CHA(AA)
           set visField::Value to visField::Value & "," & PK360-O-V-5PCT-CHA(AA)
           set visField::Value to visField::Value & "," & PK360-V-5PCT-DIF(AA)
           set visField::Value to visField::Value & ";"

           add 1 to aa.
           go to 5-loop.
       10-done. 
       
****** Home Loop*************
           move 1 to aa.
       H-loop.
           if PK360-H-TOI-NAME(aa) = " " 
               go to H-done.
            
           set homeField::Value to homeField::Value & PK360-H-TOI-NAME(AA)::Trim
           set shotValue to PK360-E-H-SHOT-VALUE(AA)
           set homeField::Value to homeField::Value & "," & shotValue
           set homeField::Value to homeField::Value & "," & PK360-T-H-5PCT-CHA(AA)
           set homeField::Value to homeField::Value & "," & PK360-O-H-5PCT-CHA(AA)
           set homeField::Value to homeField::Value & "," & PK360-H-5PCT-DIF(AA)
           set homeField::Value to homeField::Value & ";"
           add 1 to aa.
           go to H-loop.
       H-done. 
            
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
           
           if actionFlag = 'vis-player'
               set callbackReturn to actionFlag & "|" & self::visPlayer(methodArg)
           else if actionFlag = 'home-player'
               set callbackReturn to actionFlag & "|" & self::homePlayer(methodArg)
           else if actionFlag = 'play-all'
               set callbackReturn to actionFlag & "|" & self::playGoals() 
           else if actionFlag = 'play-sel'
               set callbackReturn to actionFlag & "|" & self::goalsSelection(methodArg)
           else if actionFlag = 'update-goals'
               set callbackReturn to actionFlag & "|" & self::goalSelected(methodArg)
           else if actionFlag = "update-goals-dblclick"
               set callbackReturn to actionFlag & "|" & self::goalSelected(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################
 
       method-id visPlayer final private.
       local-storage section.
       01 playerNum             type Single.
       01 colIndex              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\PUCKS\PK360_dg.CPB".
       procedure division using num as type String returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type Single::TryParse(num::Substring(0, num::IndexOf(",")), reference playerNum)
           invoke type Single::TryParse(num::Substring(num::IndexOf(",") + 1), reference colIndex)

           set returnVal to ""
           move 1 to aa.
       name-loop.
           if PK360-V-TOI-NAME(aa) = spaces
               go to name-done.
           if PK360-V-TOI-NAME(aa) = PK360-V-TOI-NAME(playerNum + 1) 
               move "Y" to PK360-IND-FLAG
               move PK360-V-TOI-ID(aa) to PK360-SEL-TOI-ID
               if colIndex = 0 or 1
                   move "GV1" to PK360-ACTION
               else
               if colIndex = 2
                   move "GV2" to PK360-ACTION
               else    
               if colIndex = 3
                   move "GV3" to PK360-ACTION
               else    
               if colIndex = 4
                   move "GV4" to PK360-ACTION
               end-if
               go to name-done.
           add 1 to aa
           go to name-loop.
       name-done.            
           invoke pk360rununit::Call("PK360WEBF")

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          

           set returnVal to self::loadGoals
       end method.

       method-id homePlayer final private.
       local-storage section.
       01 playerNum             type Single.
       01 colIndex              type Single.
       linkage section.
           COPY "Y:\SYDEXSOURCE\PUCKS\PK360_dg.CPB".
       procedure division using num as type String returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           invoke type Single::TryParse(num::Substring(0, num::IndexOf(",")), reference playerNum)
           invoke type Single::TryParse(num::Substring(num::IndexOf(",") + 1), reference colIndex)

           set returnVal to ""
           move 1 to aa.
       name-loop.
           if PK360-H-TOI-NAME(aa) = spaces
               go to name-done.
           if PK360-H-TOI-NAME(aa) = PK360-H-TOI-NAME(playerNum + 1) 
               move "Y" to PK360-IND-FLAG
               move PK360-H-TOI-ID(aa) to PK360-SEL-TOI-ID
               if colIndex = 0 or 1
                   move "GV1" to PK360-ACTION
               else
               if colIndex = 2
                   move "GV2" to PK360-ACTION
               else    
               if colIndex = 3
                   move "GV3" to PK360-ACTION
               else    
               if colIndex = 4
                   move "GV4" to PK360-ACTION
               end-if
               go to name-done.
           add 1 to aa
           go to name-loop.
       name-done.            
           invoke pk360rununit::Call("PK360WEBF")

           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          

           set returnVal to self::loadGoals
       end method.

       method-id loadGoals protected.
       local-storage section.
       01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           move 1 to aa.
       5-loop.
           if aa > PK360-GO-NUM-LINES
               go to 10-done.
           set dataLine to " " & PK360-DATA-LINE2(AA)::Trim
           INSPECT dataline REPLACING ALL " " BY X'A0'
           set returnVal to returnVal & dataline & ';'
           add 1 to aa.
           go to 5-loop.
       10-done.
       
       end method.

       method-id goalSelected protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
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
               set PK360-SEL-LINES, PK360-LINE-IP to 0
               exit method.
           invoke type Int32::TryParse(indexString, reference selected)
           set PK360-SEL-LINES to selected + 1
           set PK360-LINE-IP TO PK360-SEL-LINES
                          
           MOVE "VI" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           if ERROR-FIELD NOT = SPACES
               set playReturn to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method.          
                   
           invoke self::batstube.
       end method.

       method-id playGoals protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move "VT" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
           
           if ERROR-FIELD NOT = SPACES
               set returnVal to "er|" & ERROR-FIELD
               move spaces to ERROR-FIELD
               exit method. 
                       
           invoke self::batstube.
       end method.

       method-id goalsSelection protected.
       local-storage section.
       01 vidPaths type String. 
       01 vidTitles type String.
       01 selected  type Int32[].
       01 strArray  type String[].
       01 i type Int32.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk360_dg.CPB".
       procedure division using by value indexString as type String 
                          returning playReturn as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           move 0 to aa.
           move " " to PK360-ANY-FOUND
           initialize PK360-SHOW-EVENTS-TBL
           if indexString = null
               set playReturn to "er|" & "No starting point is highlighted"
               exit method.
           set strArray to indexString::Split(';').           
           set size of selected to strArray::Length
           
           perform varying i from 0 by 1 until i >= strArray::Length
               set selected[i] to type Int32::Parse(strArray[i])
           end-perform.
       videos-loop.
           if aa = selected::Count
               go to videos-done.

           set PK360-SEL-LINES to selected[aa] + 1
           move PK360-SEL-LINES to PK360-LINE-IP        
           move "Y" to PK360-ANY-FOUND
           move "Y" to PK360-SHOW-EVENT(PK360-LINE-IP).
           add 1 to AA.
           go to videos-loop.
       videos-done.
                              
           MOVE "VG" to PK360-ACTION
           
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