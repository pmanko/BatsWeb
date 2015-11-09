       class-id batsweb.breakdown is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       01 mydata type batsweb.bat310Data.

       method-id Page_Load protected.
       local-storage section.
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
           
      *    Setup
           set self::Session::Item("database") to self::Request::QueryString["league"]
           if self::Session["bat310data"] = null
               set mydata to new batsweb.bat310Data
               invoke mydata::populateData
               set self::Session["bat310data"] to mydata              
           else
               set mydata to self::Session["bat310data"] as type batsweb.bat310Data.
           
       end method.
 
       end class.
