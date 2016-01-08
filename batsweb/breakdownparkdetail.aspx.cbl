       class-id batsweb.breakdownparkdetail is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat310rununit         type RunUnit.
       01 BAT310WEBF                type BAT310WEBF.
       01 mydata type batsweb.bat310Data.
       01 teststring type String protected.
       
       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           if self::IsPostBack
               exit method.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer       
           move 1 to aa.
       parks-loop.
           if aa > BAT310-BPARK-NUM-ENTRIES
               go to parks-done.
           invoke parkDropDownList::Items::Add(BAT310-BPARK(AA)::Trim)
           if BAT310-BPARK(AA) = BAT310-SEL-BPARK
               set parkDropDownList::SelectedIndex to (AA - 1).
           add 1 to aa
           go to parks-loop.
       parks-done.
           invoke self::Recalc.

           goback.
       end method.
       
       method-id Recalc protected.
       local-storage section.
       01  avg         type Double.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat310_dg.CPB".
       procedure division.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           
           set avg to BAT310-LOC-PCT(1)
           set lfLabel::Text to avg::ToString & "%" 
           set avg to BAT310-LOC-PCT(2)
           set cfLabel::Text to avg::ToString & "%"
           set avg to BAT310-LOC-PCT(3)
           set rfLabel::Text to avg::ToString & "%"
           set avg to BAT310-LOC-PCT(4)
           set 3bLabel::Text to avg::ToString & "%"   
           set avg to BAT310-LOC-PCT(5)
           set ssLabel::Text to avg::ToString & "%"
           set avg to BAT310-LOC-PCT(6)
           set 2bLabel::Text to avg::ToString & "%"
           set avg to BAT310-LOC-PCT(7)
           set 1bLabel::Text to avg::ToString & "%"                
       end method.
       
       method-id parkDropDownList_SelectedIndexChanged protected.
       linkage section.
           COPY "Y:\sydexsource\BATS\bat310_dg.CPB".
       procedure division using by value sender as object e as type System.EventArgs.
           set mydata to self::Session["bat310data"] as type batsweb.bat310Data
           set address of BAT310-DIALOG-FIELDS to myData::tablePointer
           set bat310rununit to self::Session::Item("310rununit")
               as type RunUnit
           set BAT310-SEL-BPARK to parkDropDownList::SelectedItem
           MOVE "FB" TO BAT310-ACTION
           invoke bat310rununit::Call("BAT300WEBF")
           invoke self::Recalc
       end method.         
       end class.
