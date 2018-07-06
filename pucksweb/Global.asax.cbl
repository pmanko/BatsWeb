       class-id pucksweb.Global
               inherits type System.Web.HttpApplication public.
       working-storage section.
           
       method-id Application_Start internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
           *> Code that runs on application startup
           goback.           
       end method.
              
       method-id Application_End internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
            *>  Code that runs on application shutdown
           goback.           
       end method.
       
       method-id Application_Error internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
            *> Code that runs when an unhandled error occurs
           goback.           
       end method.
       
       method-id Session_Start internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
           *> Code that runs when a new session is started
           goback.           
       end method.
       
       method-id Session_End internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
           *> Code that runs when a session ends. 
           *> Note: The Session_End event is raised only when the sessionstate mode
           *> is set to InProc in the Web.config file. If session mode is set to StateServer 
           *> or SQLServer, the event is not raised. 
           goback.           
       end method.
       
       end class.
