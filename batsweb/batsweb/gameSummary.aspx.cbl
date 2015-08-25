       class-id batsweb.gameSummary is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "C:\Users\Piotrek\sydexsource\shared\WS-SYS.CBL".
       01  node-name.
           05  name-len         pic x comp-5 value 10.
           05  id1              pic x(10) value "bat666_dg".        
       01  mem-flag             pic x(4) comp-5.
       01  mem-size             pic x(4) comp-5.
       01 bat666rununit         type RunUnit.
       01 BAT666WEBF                type BAT666WEBF.
       01 SH-BAT666-MEM-POINTER           POINTER.
       
       method-id Page_Load protected.
       local-storage section.
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
       end method.
 
       end class.
