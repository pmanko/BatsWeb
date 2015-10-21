       class-id batsweb.pitchervsbatter is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat766rununit         type RunUnit.
       01 BAT766WEBF                type BAT766WEBF.
       01 mydata type batsweb.bat766Data.
       01 abnum        type Single.
       
       method-id Page_Load protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat766_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           if self::IsPostBack
               exit method.
           if  self::Session::Item("766rununit") not = null
               set bat766rununit to self::Session::Item("766rununit")
                   as type RunUnit
               else
               set bat766rununit to type RunUnit::New()
               set BAT766WEBF to new BAT766WEBF
               invoke bat766rununit::Add(BAT766WEBF)
               set self::Session::Item("766rununit") to  bat766rununit.

           set mydata to self::Session["bat766data"] as type batsweb.bat766Data
           set address of BAT766-DIALOG-FIELDS to myData::tablePointer
           move "I" to BAT766-ACTION
           invoke bat766rununit::Call("BAT766WEBF")
           goback.
       end method.
 
       end class.
