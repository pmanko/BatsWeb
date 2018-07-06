       class-id pucksweb.playerBreakdownRink is partial 
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 pk310rununit         type RunUnit.
       01 PK310WEBF                type PK310WEBF.
       01 mydata type pucksweb.pk310Data.
       01  downlocx             pic 9(4).
       01  downlocy             pic 9(4).
       01  uplocx               pic 9(4).
       01  uplocy               pic 9(4).       
       01  WS-CLICK-IP          PIC X.
       method-id Page_Load protected.
       local-storage section.
       01  drawArea             type Bitmap.
       01  g                   type Graphics.
       01  mypen               type Pen.
       01  WS-HORIZ            PIC X(4) COMP-5 VALUE 0.
       01  WS-VERT             PIC X(4) COMP-5 VALUE 0.
       01  WS-HORIZ-ST            PIC X(4) COMP-5 VALUE 0.
       01  WS-VERT-ST             PIC X(4) COMP-5 VALUE 0.
       01  ws-x        pic 9(4).
       01  ws-y        pic 9(4).
       01  ws-x2        pic 9(4).
       01  ws-y2        pic 9(4). 
       01  dimx              type Double.
       01  dimy              type Double.   
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk310_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           set mydata to self::Session["pk310data"] as type pucksweb.pk310Data
           set address of PK310-DIALOG-FIELDS to myData::tablePointer 
           set drawArea to type Bitmap::FromFile(Server::MapPath("Images\\nhlrink2.png")) as type Bitmap
           COMPUTE WS-HORIZ-ST ROUNDED = (PK310-RINK-X / 4)
           COMPUTE WS-VERT-ST ROUNDED = (PK310-RINK-Y / 4)
           compute dimx = (drawArea::Width / 277)
           compute dimy = (drawArea::Height / 336)
           set g to type Graphics::FromImage(drawArea)
           invoke g::Clear(type Color::White)
           invoke g::DrawImageUnscaled(type Bitmap::FromFile(Server::MapPath("Images\\nhlrink2.png")) as type Bitmap, 0, 0)

           MOVE 1 TO AA.
           if PK310-SHOT-CALL = "T" 
                PERFORM SHOW-T-SHOTS 1500 TIMES
           else     
           if PK310-SHOT-CALL = "I" 
                PERFORM SHOW-I-SHOTS 1500 TIMES
           else     
           if PK310-SHOT-CALL = "O" 
                PERFORM SHOW-O-SHOTS 1500 TIMES.
      *    IF DOWNLOCX < UPLOCX
      *        MOVE DOWNLOCX TO WS-X
      *        COMPUTE WS-X2 = UPLOCX - DOWNLOCX
      *    ELSE
      *        MOVE UPLOCX TO WS-X
      *        COMPUTE WS-X2 = DOWNLOCX - UPLOCX.
      *
      *    IF DOWNLOCY < UPLOCY
      *        MOVE DOWNLOCY TO WS-Y
      *        COMPUTE WS-Y2 = UPLOCY - DOWNLOCY
      *    ELSE
      *        MOVE UPLOCY TO WS-Y
      *        COMPUTE WS-Y2 = DOWNLOCY - UPLOCY.

       210-RECTANGLE.

           set Response::ContentType to "image/jpeg"
           invoke drawArea::Save(Response::OutputStream, type ImageFormat::Jpeg)
           invoke drawArea::Dispose
           invoke g::Dispose()
           invoke Response::End()
           exit method.

       SHOW-T-SHOTS.
           IF PK310-T-SHOT-LOC-X(AA) = 0 AND PK310-T-SHOT-LOC-Y(AA) = 0
               NEXT SENTENCE
               ELSE
               COMPUTE WS-HORIZ ROUNDED = (PK310-T-SHOT-LOC-X(AA) / 2.67) * dimx
      *                    + WS-HORIZ-ST
               COMPUTE WS-VERT ROUNDED = (PK310-T-SHOT-LOC-Y(AA) / 2.67) * dimy
      *                    + WS-VERT-ST
               SUBTRACT 3 FROM WS-HORIZ
               SUBTRACT 3 FROM WS-VERT
               IF PK310-T-GOAL-FLAG(AA) = "Y"
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Chartreuse), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
               IF PK310-T-GOAL-FLAG(AA) = "S"
                   invoke g::DrawEllipse(type Pens::RoyalBlue, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::RoyalBlue), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Black), WS-HORIZ, WS-VERT, 7, 7).
        
           ADD 1 TO AA.

       SHOW-I-SHOTS.
           IF PK310-I-SHOT-LOC-X(AA) = 0 AND PK310-I-SHOT-LOC-Y(AA) = 0
               NEXT SENTENCE
               ELSE
               COMPUTE WS-HORIZ = (PK310-I-SHOT-LOC-X(AA) / 2.67) * dimx
      *                    + WS-HORIZ-ST
               COMPUTE WS-VERT = (PK310-I-SHOT-LOC-Y(AA) / 2.67) * dimy 
      *                    + WS-VERT-ST
               SUBTRACT 3 FROM WS-HORIZ
               SUBTRACT 3 FROM WS-VERT
               IF PK310-I-GOAL-FLAG(AA) = "Y"
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Chartreuse), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
               IF PK310-I-GOAL-FLAG(AA) = "S"
                   invoke g::DrawEllipse(type Pens::RoyalBlue, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::RoyalBlue), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Black), WS-HORIZ, WS-VERT, 7, 7).
       
           ADD 1 TO AA.
           
       SHOW-O-SHOTS.
           IF PK310-O-SHOT-LOC-X(AA) = 0 AND PK310-O-SHOT-LOC-Y(AA) = 0
               NEXT SENTENCE
               ELSE
               COMPUTE WS-HORIZ = (PK310-O-SHOT-LOC-X(AA) / 2.67) * dimx
      *                    + WS-HORIZ-ST
               COMPUTE WS-VERT = (PK310-O-SHOT-LOC-Y(AA) / 2.67) * dimy   
      *                    + WS-VERT-ST
               SUBTRACT 3 FROM WS-HORIZ
               SUBTRACT 3 FROM WS-VERT
               IF PK310-O-GOAL-FLAG(AA) = "Y"
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Chartreuse), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
               IF PK310-O-GOAL-FLAG(AA) = "S"
                   invoke g::DrawEllipse(type Pens::RoyalBlue, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::RoyalBlue), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Black), WS-HORIZ, WS-VERT, 7, 7).
       
           ADD 1 TO AA.           
       ALL-DONE.
           goback.
       end method.
 
       end class.
