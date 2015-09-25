       class-id batsweb.Global
               inherits type System.Web.HttpApplication public.
       working-storage section.
      *copy "y:\sydexsource\bats\batsglobal.cpb".
           
       method-id Application_Start internal.
       local-storage section.
       procedure division using by value sender as object by value e as type EventArgs.
           *> Code that runs on application startup
           goback.           
       end method.
              
       method-id Application_End internal.
       local-storage section.
       01 bat666rununit         type RunUnit.
       01 BAT666WEBF                type BAT666WEBF.
       01 bat666data type batsweb.bat666Data.
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 bat360data type batsweb.bat360Data.

       01 batsw060rununit         type RunUnit.
       01 BATSW060WEBF                type BATSW060WEBF.
       01 batsw060data type batsweb.batsw060Data.

       procedure division using by value sender as object by value e as type EventArgs.
            *>  Code that runs on application shutdown
       if  self::Session::Item("666rununit") not = null
           set bat666rununit to self::Session::Item("666rununit")
                   as type RunUnit
           set bat666data to self::Session["bat666data"] as type batsweb.bat666Data     
           MOVE "X" TO bat666data::BAT666-ACTION
           invoke bat666rununit::Call("BAT666WEBF")
           invoke bat666rununit::StopRun.     
       if  self::Session::Item("360rununit") not = null
           set bat360rununit to self::Session::Item("360rununit")
                   as type RunUnit
           set bat360data to self::Session["bat360data"] as type batsweb.bat360Data     
           MOVE "X" TO bat360data::BAT360-ACTION
           invoke bat360rununit::Call("BAT360WEBF")
           invoke bat360rununit::StopRun.        
       if  self::Session::Item("w060rununit") not = null
           set batsw060rununit to self::Session::Item("w060rununit")
                   as type RunUnit
           set batsw060data to self::Session["batsw060data"] as type batsweb.batsw060Data     
           MOVE "X" TO batsw060data::BATSW060-ACTION
           invoke batsw060rununit::Call("BATSW060WEBF")
           invoke batsw060rununit::StopRun.        
    
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
