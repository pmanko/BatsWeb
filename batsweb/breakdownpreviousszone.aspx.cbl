       class-id batsweb.breakdownpreviousszone is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 bat310rununit         type RunUnit.
       01 BAT310WEBF                type BAT310WEBF.
       01 mydata type batsweb.bat310Data.
       
       method-id Page_Load protected.
       local-storage section.
        01  aa    pic 9999.
        01  g           type Graphics.
        01  mypen       type Pen.
        01  mylemonbrush      type Brush.
        01  mybrightgreenbrush      type Brush.
        01  mygreenbrush      type Brush.
        01  myroyalbluebrush     type Brush.
        01  myredbrush     type Brush.
        01  myblackbrush     type Brush.
        01  myyellowbrush     type Brush.
        01  mywhitebrush     type Brush.
        01  mycyanbrush     type Brush.
        01  myfontbrush     type Brush.
        01  myfont      type Font.
        01  myfont2      type Font.
        01  mystringformat type StringFormat.
        01  myrectangle  type Rectangle.
        01  ws-x        pic 9(4).
        01  ws-y        pic 9(4).
        01  ws-x2        pic 9(4).
        01  ws-y2        pic 9(4).

        01  ws-col      pic 9(4).
        01  ws-row      pic 9(4).
        01  Byte-x      pic X.
        01  testval2     pic 99.
        01  mytext      pic x.
        01  mytext2     pic xx.
        01  dimx              pic 9(7).
        01  dimy              pic 9(7).
        01  dim2x              pic 9(7).
        01  dim2y              pic 9(7).
        01  drawArea          type Bitmap.
        01  pfc    type PrivateFontCollection.
        01  pfc2    type PrivateFontCollection.       
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           goback.
       end method.
 
       end class.
