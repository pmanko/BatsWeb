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
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
           if self::IsPostBack
               exit method.
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
      *         invoke type Single::TryParse(methodArg, reference n)
               set callbackReturn to actionFlag & "|" & self::visPlayer(methodArg).
      *     else if actionFlag = 'home-player'
      *         invoke type Single::TryParse(methodArg, reference n)
      *         set callbackReturn to actionFlag & "|" & self::homePlayer(methodArg).
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
       procedure division using num as type String
      *procedure division using playerName as type String,
                               returning returnVal as type String.
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
      *    call "PK360WINF"
      *    set GoalsForm to new type GameSummary.GoalsForm
      *    invoke GoalsForm::Show   
       end method.

       method-id homePlayer final private.
       local-storage section.
           01 dataLine             type String.
       linkage section.
           COPY "Y:\SYDEXSOURCE\PUCKS\PK360_dg.CPB".
       procedure division using num as type Single returning returnVal as type String.
           set mydata to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer 
           set pk360rununit to self::Session::Item("360rununit")
               as type RunUnit
           set returnVal to ""

       end method.

       end class.