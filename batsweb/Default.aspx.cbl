       $set ilusing"System.Web.Security"

       class-id batsweb._Default is partial
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


       method-id Page_Load protected.
       local-storage section.

       procedure division using by value sender as object by value e as type EventArgs.
           if self::IsPostBack
               exit method.       
      *     if type HttpContext::Current::Request::Cookies["creds"] not = null
      *         set TextBox1::Text to type HttpContext::Current::Request::Cookies["creds"]["firstName"]
      *         set TextBox3::Text to type HttpContext::Current::Request::Cookies["creds"]["lastName"]
      *         set TextBox2::Text to type HttpContext::Current::Request::Cookies["creds"]["Password"].
           if self::Request::QueryString::ToString = "MARLINS"
               set teamDropDownList::SelectedIndex to 1.
           goback.
       end method.

       method-id loginButton_Click protected.
       local-storage section.
       01 app-data-folder pic x(256).
       01 ticket          type FormsAuthenticationTicket.
       01 encTicket       type String.
       01 userName        type String.
       
       procedure division using by value sender as object e as type System.EventArgs.
           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
           set WS-TEAM-NAME to teamDropDownList::SelectedItem.
           string '"' app-data-folder delimited by "  " "\" WS-TEAM-NAME delimited by "  "
              '\WEBSYNC\BATSW020.DAT"' delimited by size
              into WS-BATSW020-FILE.
           set WS-FIRST to TextBox1::Text::ToUpper.
           set WS-LAST to TextBox3::Text::ToUpper.
           set WS-PASS to TextBox2::Text.
           
           invoke self::verify_password
               
           if WS-REJECT-FLAG = "Y"
               set userName to WS-FIRST & WS-LAST & WS-TEAM-NAME
               set ticket to type FormsAuthenticationTicket::New(userName, rememberCheckBox::Checked, 60)
               set encTicket to type FormsAuthentication::Encrypt(ticket)
               
               invoke self::Response::Cookies::Add(type HttpCookie::New(type FormsAuthentication::FormsCookieName, encTicket))
               invoke self::Response::Redirect(type FormsAuthentication::GetRedirectUrl(userName, rememberCheckBox::Checked))

           else
               set Msg::Text to "Login failed. Name or password incorrect".
             
           
      *         if rememberCheckBox::Checked = true
      *             set cook to new HttpCookie("creds")
      *             invoke cook::Values::Add("firstName", WS-FIRST)
      *             invoke cook::Values::Add("lastName", WS-LAST)
      *             invoke cook::Values::Add("Password", WS-PASS)
      *         end-if
      *        invoke self::Response::Redirect("/mainmenu.aspx").
       end method.

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
