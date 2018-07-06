       class-id pucksweb.Account.Login is partial
               inherits type System.Web.UI.Page public.
       working-storage section.
           
       method-id Page_Load protected.
       local-storage section.
       01 returnUrl string.
       01 encodedUrl string.
       
       procedure division using by value sender as object by value e as type EventArgs.
           set returnUrl to super::Request::QueryString::Item("ReturnUrl")
           set encodedUrl to type HttpUtility::UrlEncode(returnUrl)
           set RegisterHyperLink::NavigateUrl to String::Concat( "Register.aspx?ReturnUrl=" encodedUrl)
           goback.           
       end method.
              
       end class.
