       class-id pucksweb.scoutPage is partial 
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
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.
       LINKAGE SECTION.
           COPY "Y:\sydexsource\PUCKS\PK360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.

      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####               
           
      *    if self::IsPostBack
      *        invoke self::loadGames
      *        invoke self::loadLines
               exit method.

      *    Setup - from main menu                
           SET self::Session::Item("database") to self::Request::QueryString["league"]
           if   self::Session["pk360data"] = null
              set mydata to new pucksweb.pk360Data
              invoke mydata::populateData
              set self::Session["pk360data"] to mydata
           else
               set mydata to self::Session["pk360data"] as type pucksweb.pk360Data.

           if  self::Session::Item("360rununit") not = null
               set pk360rununit to self::Session::Item("360rununit")
                   as type RunUnit
                ELSE
                set pk360rununit to type RunUnit::New()
                set PK360WEBF to new PK360WEBF
                invoke pk360rununit::Add(PK360WEBF)
                set self::Session::Item("360rununit") to pk360rununit.
           
           set address of PK360-DIALOG-FIELDS to myData::tablePointer

           move "I" to PK360-ACTION
           invoke pk360rununit::Call("PK360WEBF")
       move 1 to aa.
       5-loop.
           if aa > PK360-NUM-TEAMS
               go to 10-done
           else
               invoke ddTeam::Items::Add(PK360-TEAM-NAME(aa)).
           add 1 to aa
           go to 5-loop.
       10-done.

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
       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           
           if actionFlag = 'change-team'
               set callbackReturn to actionFlag & "|" & self::ddTeam(methodArg).
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.

      *####################################################################
 

       method-id ddTeam private.
       linkage section.
           COPY "Y:\sydexsource\PUCKS\PK360_dg.CPB".
       procedure division using by value selectedTeam as String
                          returning teamList as String.
           set myData to self::Session["pk360data"] as type pucksweb.pk360Data
           set address of PK360-DIALOG-FIELDS to myData::tablePointer
           set pk360rununit to self::Session::Item("360rununit")
                   as type RunUnit       
      *    set PK340-SEL-TEAM to selectedTeam 
      *    move PK340-SEL-TEAM to PK340-PLAYER-TEAM
      *    MOVE "RP" TO PK340-ACTION 
      *    invoke pk330rununit::Call("PK340WEBF")
      *    if ERROR-FIELD NOT = SPACES
      *        invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('" & ERROR-FIELD & "');", true)
      *        move spaces to ERROR-FIELD.              
      *    set teamList to ""

       end method.

       end class.
