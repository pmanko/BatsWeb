       class-id pucksweb.freeTrial is partial
                inherits type System.Web.UI.Page public.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

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
               10  WEBPASS-FIRST           PIC X(30).
           05  WEBPASS-REST.
               10  WEBPASS-PASS            PIC X(24).
               10  WEBPASS-LEVEL           PIC X.
               10  FILLER                  PIC X(44).

       working-storage section.
       01  WS-TEAM-NAME       PIC X(15).
       01  WS-LAST            PIC X(15).
       01  WS-FIRST           PIC X(15).
       01  WS-PASS            PIC X(6).
       01  WS-BATSW020-FILE   PIC X(256) VALUE "PKW020.DAT".
       01  WS-REJECT-FLAG     PIC X.
       01  STATUS-COMN.
           05  STATUS-BYTE-1           PIC X      VALUE SPACES.
           05  STATUS-BYTE-2           PIC X      VALUE SPACES.
       01 app-data-folder     PIC X(256).

       method-id Page_Load protected.
       local-storage section.
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
       end method.

       method-id btnTrial_Click protected.
       local-storage section.
       01  WORK-FIELD                  PIC 9(18).
      *01  WORK-PASS                   PIC X(18)  COMP-X VALUE 0.
      *01  WORK-PASS-X REDEFINES WORK-PASS  PIC X(18).
       01  xorConstant                 type Byte value h"2a".
       procedure division using by value sender as object e as type System.EventArgs.
           if tbEmail::Text = spaces or tbEmail::Text = spaces or tbName::Text = spaces
               set lblMsg::Text to "Please fill in all fields"
               EXIT method.

           if tbPass::Text not = tbPass2::Text
               set lblMsg::Text to "Password fields do not match"
               EXIT method.


           declare mail as type MailMessage = new MailMessage()
      *    try
      *        invoke mail::To::Add(new MailAddress(tbEmail::Text))
      *    catch exc as type FormatException
      *        set lblMsg::Text to "Incorrect email address format, please check"
      *    end-try

           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")

 debug*     string '"' app-data-folder delimited by "  "
             string '"' app-data-folder delimited by "  "
      *     string '"' app-data-folder delimited by "pucksweb" "HALTEST" delimited by "  "
              '\WEBSYNC\PKW020.DAT"' delimited by size
              into WS-BATSW020-FILE.

           OPEN I-O WEBPASS-FILE.
           IF STATUS-BYTE-1 NOT EQUAL ZEROES
               EXIT method.
      *        go to  100-done.

           MOVE "HALTEST" to WEBPASS-TEAM-NAME
           MOVE tbUser::Text::ToUpper TO WEBPASS-FIRST
           READ WEBPASS-FILE
               NOT INVALID KEY
                   CLOSE WEBPASS-FILE
                   MOVE "X" TO WS-REJECT-FLAG
                   set lblMsg::Text to "Username in use, please choose another."
                   EXIT method.
            MOVE 1      TO WEBPASS-LEVEL.


      *    set WORK-PASS-X to tbPass::Text
      *    COMPUTE WEBPASS-PASS = WORK-PASS * 7.
           declare bData as type Byte occurs any = type System.Text.Encoding::UTF8::GetBytes(tbPass::Text) 
           perform varying i as type Single from 0 by 1
             until i = bData::Length
               set bData[i] to bData[i] b-xor xorConstant
           end-perform
           declare boutput as type String = type Convert::ToBase64String(bData)

           SET WEBPASS-PASS to boutput
           WRITE WEBPASS-REC.
           CLOSE WEBPASS-FILE.
           declare smtpClient as type SmtpClient = new SmtpClient
           set smtpClient::UseDefaultCredentials = false
           set smtpClient::Host = "smtp.gmail.com"
           set smtpClient::Port = 587
           set smtpClient::EnableSsl = true
           set smtpClient::DeliveryMethod = type SmtpDeliveryMethod::Network
           set smtpClient::Credentials = new System.Net.NetworkCredential("pucksweb@gmail.com", "sydex123")

      *    Setting From , To and CC
           set mail::From = new MailAddress("pucksweb@gmail.com", "Pucksweb Site")
      *     mail::CC::Add(new MailAddress("MyEmailID@gmail.com"))
           set mail::Subject to "Feedback"
           set mail::Body to "Hey Joe:" & type Environment::NewLine& "Team Name: " & ddTeam::SelectedItem  & type Environment::NewLine & "Name: " & tbName::Text & type Environment::NewLine &
           "Username: " & tbUser::Text & type Environment::NewLine & "Email: " & tbEmail::Text & type Environment::NewLine & "Password: " & tbPass::Text
           set mail::IsBodyHtml to false
           invoke mail::To::Add(new MailAddress("hal@sydexsports.com"))

           invoke smtpClient::Send(mail)
           set lblMsg::Text to "Succesfully registered! Check your email for account activation"
           set btnReturn::Visible to true
       end method.

       end class.
