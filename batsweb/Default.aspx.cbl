       $set ilusing"System.Web.Security"

       class-id batsweb._Default is partial
                implements type System.Web.UI.ICallbackEventHandler
               inherits type System.Web.UI.Page public.

       $SET CALLFH"EXTFH"
       $SET DATACOMPRESS"1"
        SELECT WEBPASS-FILE ASSIGN WS-BATSW020-FILE
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS WEBPASS-KEY
              LOCK MANUAL
              FILE STATUS IS STATUS-COMN.
       file section.
       FD  WEBPASS-FILE
           LABEL RECORDS ARE STANDARD
           DATA RECORD IS WEBPASS-REC.

       01  WEBPASS-REC.
           05  WEBPASS-KEY.
               10  WEBPASS-TEAM-NAME       PIC X(15).
               10  WEBPASS-LAST            PIC X(15).
               10  WEBPASS-FIRST           PIC X(15).
           05  WEBPASS-REST.
               10  WEBPASS-PASS            PIC 9(18).
               10  WEBPASS-LEVEL           PIC X.
               10  FILLER                  PIC X(50).



       working-storage section.
       01  WS-TEAM-NAME       PIC X(15).
       01  WS-LAST            PIC X(15).
       01  WS-FIRST           PIC X(15).
       01  WS-PASS            PIC X(6).
       01  WS-BATSW020-FILE   PIC X(256) VALUE "BATSW020.DAT".
       01  WS-REJECT-FLAG     PIC X.
       01  STATUS-COMN.
           05  STATUS-BYTE-1           PIC X      VALUE SPACES.
           05  STATUS-BYTE-2           PIC X      VALUE SPACES.
       01 plaintext           type Byte occurs any.
       01 entropy           type Byte occurs 20.
       01 ticket          type FormsAuthenticationTicket.
       01 aa               type Single.
       01 team             type String.
       01 callbackReturn type String.

       method-id Page_Load protected.
       local-storage section.
       01 cm type ClientScriptManager.
       01 cbReference type String.
       01 callbackScript type String.              
       procedure division using by value sender as object by value e as type EventArgs.
       
      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####   
        
           if self::IsPostBack
               exit method.
      *         set TextBox2::Text to type HttpContext::Current::Request::Cookies["creds"]["Password"].
           if type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"] not = null
               set rememberCheckBox::Checked to true
               set ticket to type FormsAuthentication::Decrypt(type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"]::Value)
               set first_name::Text to ticket::Name::Substring(0, 15)::Trim
               set last_name::Text to ticket::Name::Substring(15, 15)::Trim
               set password::Text to ticket::Name::Substring(30, 6)::Trim
               set team to ticket::Name::Substring(36, 15)::Trim.
           move 0 to aa.
       5-loop.
           if teamDropDownList::Items::Count = aa
               go to 10-done.
           if team = teamDropDownList::Items[aa]::ToString
               set teamDropDownList::SelectedIndex to aa
               go to 10-done.
           if self::Request::QueryString::ToString::Replace("_", " ") = teamDropDownList::Items[aa]::ToString
               set teamDropDownList::SelectedIndex to aa
               go to 10-done.
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
       
       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           
           if actionFlag = 'login'
               set callbackReturn to actionFlag & "|" & self::login(methodArg).
       
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################
       
       method-id login protected.
       local-storage section.
       01 app-data-folder pic x(256).
       01 userName        type String.
       01 encTicket       type String.
       01 teamName        pic x(15). 
       01 remember        type String.
             
      * procedure division using by value sender as object e as type System.EventArgs.
       procedure division using by value loginParams as String returning returnVal as  String.
       
           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
           
           string '"' app-data-folder delimited by "  "
      *     string '"' app-data-folder delimited by "Programs" teamName delimited by "  "
              '\WEBSYNC\BATSW020.DAT"' delimited by size
              into WS-BATSW020-FILE.
           
           unstring loginParams
               delimited by ","
               into WS-TEAM-NAME, WS-FIRST, WS-LAST, WS-PASS
           end-unstring.
           
           set teamName to WS-TEAM-NAME::Replace(" ", type String::Empty)   
           
           invoke self::verify_password
           
           if WS-REJECT-FLAG = "Y"
               set userName to WS-FIRST & WS-LAST & WS-PASS & WS-TEAM-NAME
               set ticket to type FormsAuthenticationTicket::New(userName, False, 525600)
               set encTicket to type FormsAuthentication::Encrypt(ticket)
               invoke self::Response::Cookies::Add(type HttpCookie::New(type FormsAuthentication::FormsCookieName, encTicket))
               set type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"]::Expires to type DateTime::Now::AddYears(1)
               set type HttpContext::Current::Session::Item("team") to WS-TEAM-NAME::Trim
      *         set type HttpContext::Current::Session::Item("BAM") to READ TXT FILE FOR CREDS
                set returnVal to "success|" & type FormsAuthentication::GetRedirectUrl(userName, False)
           else
               set returnVal to "failure|" & WS-FIRST::Trim & WS-LAST::Trim & WS-PASS::Trim & WS-TEAM-NAME::Trim
       end method.

      * Outdated - Leaving for reference
      *method-id loginButton_Click protected.
      *local-storage section.
      *01 app-data-folder pic x(256).
      *01 userName        type String.
      *01 encTicket       type String.
      *01 teamName        pic x(15).       
      *procedure division using by value sender as object e as type System.EventArgs.
      * procedure division returning retVal as type String.
      *    set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
      *    set WS-TEAM-NAME to teamDropDownList::SelectedItem.
      *    set teamName to teamDropDownList::SelectedItem::ToString::Replace(" ", type String::Empty).
      *    string '"' app-data-folder delimited by "  "
      *    string '"' app-data-folder delimited by "Programs" teamName delimited by "  "
      *      '\WEBSYNC\BATSW020.DAT"' delimited by size
      *      into WS-BATSW020-FILE.
      *    set WS-FIRST to first_name::Text::ToUpper.
      *    set WS-LAST to last_name::Text::ToUpper.
      *    set WS-PASS to password::Text.
      *    invoke self::verify_password
      *    if WS-REJECT-FLAG = "Y"
      *        set userName to WS-FIRST & WS-LAST & WS-PASS & WS-TEAM-NAME
      *        set ticket to type FormsAuthenticationTicket::New(userName, rememberCheckBox::Checked, 525600)
      *        set encTicket to type FormsAuthentication::Encrypt(ticket)
      *        invoke self::Response::Cookies::Add(type HttpCookie::New(type FormsAuthentication::FormsCookieName, encTicket))
      *        set type HttpContext::Current::Request::Cookies[".ASPXFORMSAUTH"]::Expires to type DateTime::Now::AddYears(1)
      *        set type HttpContext::Current::Session::Item("team") to WS-TEAM-NAME::Trim
      *        invoke self::Response::Redirect(type FormsAuthentication::GetRedirectUrl(userName, rememberCheckBox::Checked))
      *         invoke self::Response::Redirect("~/mainmenu.aspx")
      *    else
      *        set Msg::Text to "Login failed. Name or password incorrect".
      *end method.


       method-id verify_password protected.
       local-storage section.
       77  WORK-PASS                   PIC X(6)  COMP-X VALUE 0.
       77  WORK-PASS-X REDEFINES WORK-PASS  PIC X(6).
       77  WORK-FIELD                  PIC 9(18).
       procedure division.
            OPEN INPUT WEBPASS-FILE.
            IF STATUS-BYTE-1 NOT EQUAL ZEROES
               go to  100-done.

            MOVE WS-TEAM-NAME::ToUpper to WEBPASS-TEAM-NAME
            MOVE WS-TEAM-NAME to self::Session["team"]
            MOVE WS-LAST TO WEBPASS-LAST
            MOVE WS-FIRST TO WEBPASS-FIRST
            READ WEBPASS-FILE
                INVALID KEY
                    CLOSE WEBPASS-FILE
      *             invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Log in failed. Name incorrect or not authorized');", true)
      *              MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *              MOVE "NAME INCORRECT, OR NOT AUTHORIZED"
      *                  TO ERROR-MESSAGE-TEXT2
      *              PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
                    MOVE "X" TO WS-REJECT-FLAG

                    GO TO 100-DONE.
            MOVE WS-PASS  TO WORK-PASS-X
            COMPUTE WORK-FIELD = WORK-PASS * 17.
            COMPUTE WORK-FIELD = 13 * (WORK-FIELD + 7).
            IF WORK-FIELD = WEBPASS-PASS
      *          MOVE WEBPASS-LEVEL TO BATSWEB1-SEC-LEVEL
      *           MOVE "Log In successful" TO ERROR-MESSAGE-TEXT
      *           PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
                MOVE "Y" TO WS-REJECT-FLAG

                ELSE
                MOVE "N" TO WS-REJECT-FLAG.
      *         invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Log in failed. Incorrect password');", true).
      *          MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *          MOVE "INCORRECT PASSWORD"
      *                  TO ERROR-MESSAGE-TEXT2
      *          PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
       100-DONE.
           CLOSE WEBPASS-FILE.

           goback.
       end method.

       end class.
