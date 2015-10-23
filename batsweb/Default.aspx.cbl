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
           set self::Session["team"] to "DEMO".
           goback.
       end method.

       method-id Button3_Click protected.
       local-storage section.
       01 app-data-folder pic x(256).
       procedure division using by value sender as object e as type System.EventArgs.
          set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
          string '"' app-data-folder delimited by "  "
              '\WEBSYNC\BATSW020.DAT"' delimited by size
              into WS-BATSW020-FILE.
          set WS-TEAM-NAME to TextBox4::Text.
          set WS-FIRST to TextBox1::Text.
          set WS-LAST to TextBox3::Text.
          set WS-PASS to TextBox2::Text.
          invoke self::verify_password
          set TextBox2::Text to WS-REJECT-FLAG.
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

            MOVE self::Session["team"] TO WEBPASS-TEAM-NAME
            MOVE WS-LAST TO WEBPASS-LAST
            MOVE WS-FIRST TO WEBPASS-FIRST
            READ WEBPASS-FILE
                INVALID KEY
                    CLOSE WEBPASS-FILE
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
      *          MOVE "LOG IN FAILED" TO ERROR-MESSAGE-TEXT
      *          MOVE "INCORRECT PASSWORD"
      *                  TO ERROR-MESSAGE-TEXT2
      *          PERFORM 9000-DISPLAY-ERROR-MESSAGE THRU 9099-EXIT
       100-DONE.
           CLOSE WEBPASS-FILE.

           goback.
       end method.

       end class.
