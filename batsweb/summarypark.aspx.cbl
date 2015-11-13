       class-id batsweb.summarypark is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.
       01  drawArea          type Bitmap.
       01  g           type Graphics.
       01  mypen       type Pen.
       01  ws-x        pic 9(4).
       01  ws-y        pic 9(4).
       01  ws-x2        pic 9(4).
       01  ws-y2        pic 9(4).
           
       method-id Page_Load protected.
       local-storage section.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat360_dg.CPB".   
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           set mydata to self::Session["bat360data"] as type batsweb.bat360Data
           set address of BAT360-DIALOG-FIELDS to myData::tablePointer     
           set drawArea to type Bitmap::FromFile(Server::MapPath("Images\\" & BAT360-BPARK-BITMAP)) as type Bitmap
           set g to type Graphics::FromImage(drawArea)
           invoke g::Clear(type Color::White)
           invoke g::DrawImageUnscaled(type Bitmap::FromFile(Server::MapPath("Images\\" & BAT360-BPARK-BITMAP)) as type Bitmap, 0, 0)      
           IF BAT360-HITLOC-X = 0 AND BAT360-HITLOC-Y= 0
               GO TO SKIP-LINE.                                                                        
           set mypen to new Pen(type Brushes::Black, 2)
           COMPUTE WS-X ROUNDED = 296 / 597 * 597
           COMPUTE WS-Y ROUNDED = 440 / 480 * 480.
           COMPUTE WS-X2 ROUNDED = BAT360-HITLOC-X / 597 * 597
           COMPUTE WS-Y2 ROUNDED = BAT360-HITLOC-Y / 488 * 480.

           invoke g::DrawLine(mypen, ws-x, ws-y, ws-x2, ws-y2)
           set Response::ContentType to "image/jpeg"
           invoke drawArea::Save(Response::OutputStream, type ImageFormat::Jpeg)
           invoke Response::End()
           invoke drawArea::Dispose
           invoke mypen::Dispose()
           invoke g::Dispose().
       SKIP-LINE.               
           goback.
       end method.
 
       end class.
