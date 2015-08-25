       class-id batsweb.Account.Register is partial
               inherits type System.Web.UI.Page public.
       working-storage section.
           
       method-id Page_Load protected.
       local-storage section.
       01 returnUrl string.
       
       procedure division using by value sender as object by value e as type EventArgs.
           set returnUrl to super::Request::QueryString::Item("ReturnUrl")
           set RegisterUser::ContinueDestinationPageUrl to returnUrl
          
           goback.           
       end method.
       
       method-id RegisterUser_CreatedUser protected.
       
       local-storage section.
       01 continueUrl string.
       
       procedure division using by value sender as object by value e as type EventArgs.
           
		   invoke type FormsAuthentication::SetAuthCookie( RegisterUser::UserName false)
           
           set continueUrl to RegisterUser::ContinueDestinationPageUrl
           if String::IsNullOrEmpty( continueUrl )
               set continueUrl to "~/"
           end-if
           
           invoke super::Response::Redirect(continueUrl)
           
           goback.
       end method.
       
       end class.	
