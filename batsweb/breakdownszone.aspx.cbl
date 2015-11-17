       class-id batsweb.breakdownszone is partial 
                inherits type System.Web.UI.Page public.
 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat360rununit         type RunUnit.
       01 BAT360WEBF                type BAT360WEBF.
       01 mydata type batsweb.bat360Data.

       method-id Page_Load protected.
       local-storage section.
       01  aa    pic 9999.
       01  g           type Graphics.
       01  mypen       type Pen.
       01  mybrush      type Brush.
       01  mybrushred     type Brush.
       01  myfont      type Font.
       01  mystringformat type StringFormat.
       01  myrectangle  type Rectangle.
       01  ws-x        pic 9(4).
       01  ws-y        pic 9(4).
       01  ws-x2        pic 9(4).
       01  ws-y2        pic 9(4).
       01  ws-col      pic 9(4).
       01  ws-row      pic 9(4).
       01  testval1     pic 9.
       01  testval2     pic 99.
       01  mytext      pic x.
       01  mytext2     pic xx.
       01  dimx              pic 9(7).
       01  dimy              pic 9(7).
       01  dim2x              pic 9(7).
       01  dim2y              pic 9(7).
       01  drawArea          type Bitmap.
       linkage section.
           COPY "Y:\SYDEXSOURCE\BATS\bat360_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           set dimx to 288
           set dimy to 336
           set dim2x to 288
           set dim2y to 336
           set drawArea to type Bitmap::FromFile(Server::MapPath("Images\\szone2.png")) as type Bitmap
           set g to type Graphics::FromImage(drawArea)
           invoke g::Clear(type Color::White)
           invoke g::DrawImageUnscaled(type Bitmap::FromFile(Server::MapPath("Images\\szone2.png")) as type Bitmap, 0, 0)
    
           set Response::ContentType to "image/jpeg"
           invoke drawArea::Save(Response::OutputStream, type ImageFormat::Jpeg)
           invoke Response::End()
           invoke drawArea::Dispose
           invoke g::Dispose()


           goback.
       end method.
 
       end class.
