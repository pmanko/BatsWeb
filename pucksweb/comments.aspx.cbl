       class-id pucksweb.comments is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.

       method-id Page_Load protected.
       local-storage section.
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
       end method.
 
       method-id btnSubmit_Click protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk340_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           if(tbComment::Text = "" or tbEmail::Text = "" or tbName::Text = "")
               invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Please fill in all fields');", true)
               exit method.
      *    declare smtpClient as type SmtpClient = new SmtpClient("hal@sydexsports.com", 25)
           declare smtpClient as type SmtpClient = new SmtpClient
           set smtpClient::UseDefaultCredentials = false
           set smtpClient::Host = "smtp.gmail.com"
           set smtpClient::Port = 587
      *     set smtpClient::DeliveryMethod = type SmtpDeliveryMethod::PickupDirectoryFromIis
           set smtpClient::EnableSsl = true
           set smtpClient::DeliveryMethod = type SmtpDeliveryMethod::Network
           set smtpClient::Credentials = new System.Net.NetworkCredential("pucksweb@gmail.com", "sydex123")
           declare mail as type MailMessage = new MailMessage()

      *    Setting From , To and CC
           set mail::From = new MailAddress("pucksweb@gmail.com", "Pucksweb Site")
      *     mail::CC::Add(new MailAddress("MyEmailID@gmail.com"))
           set mail::Subject to "Feedback"
           set mail::Body to "From: " & tbName::Text & type Environment::NewLine & "Email: " & tbEmail::Text & type Environment::NewLine & "Comment: " & tbComment::Text
           set mail::IsBodyHtml to false
           invoke mail::To::Add(new MailAddress("hal@sydexsports.com"))

           invoke smtpClient::Send(mail);
           set tbComment::Text, tbEmail::Text, tbName::Text to ""
           invoke self::ClientScript::RegisterStartupScript(self::GetType(), "AlertBox", "alert('Thanks for your feedback!');", true)
       end method.

       end class.
