       class-id pucksweb.goalieAnalysisRbdRink is partial 
                inherits type System.Web.UI.Page public.
        
       working-storage section.
       COPY "Y:\sydexsource\shared\WS-SYS.CBL".
       01 pk330rununit         type RunUnit.
       01 PK330WEBF                type PK330WEBF.
       01 mydata type pucksweb.pk330Data.
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
       01  ws-x        pic 9(4).
       01  ws-y        pic 9(4).
       77  WORK-X-IN                   PIC 9(5)  VALUE ZERO.
       77  WORK-X-OUT                  PIC 9(5)  VALUE ZERO.
       77  WORK-Y-IN                   PIC 9(5)  VALUE ZERO.
       77  WORK-Y-OUT                   PIC 9(5)  VALUE ZERO.
       01  dimx              type Double.
       01  dimx2             type Single.
       01  dimy              type Double.   
       01  dimy2             type Single.   
       linkage section.
           COPY "Y:\SYDEXSOURCE\pucks\pk330_dg.CPB".
       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.
           set mydata to self::Session["pk330data"] as type pucksweb.pk330Data
           set address of PK330-DIALOG-FIELDS to myData::tablePointer 
           set drawArea to type Bitmap::FromFile(Server::MapPath("Images\\nhlrink2.png")) as type Bitmap
           COMPUTE WORK-X-IN ROUNDED = 2.67 * PK330-RINK-M-IN-X
           IF WORK-X-IN > 7
                   SUBTRACT 7 FROM WORK-X-IN
                   ELSE
                   MOVE 0 TO WORK-X-IN.
           COMPUTE WORK-X-OUT ROUNDED = 2.67 * PK330-RINK-M-OUT-X  + 7.
           COMPUTE WORK-Y-IN ROUNDED = 2.67 * PK330-RINK-M-IN-Y
           IF WORK-Y-IN > 7
                   SUBTRACT 7 FROM WORK-Y-IN
                   ELSE
                   MOVE 0 TO WORK-Y-IN.

           COMPUTE WORK-Y-OUT ROUNDED = 2.67 * PK330-RINK-M-OUT-Y + 7.

           compute dimx = (drawArea::Width / 277)
           compute dimy = (drawArea::Height / 336)
           compute dimx2 rounded = 138 * dimx
           compute dimy2 rounded = 295 * dimy

           set g to type Graphics::FromImage(drawArea)
           invoke g::Clear(type Color::White)
           invoke g::DrawImageUnscaled(type Bitmap::FromFile(Server::MapPath("Images\\nhlrink2.png")) as type Bitmap, 0, 0)

           MOVE 1 TO AA.
           PERFORM SHOW-SHOTS THRU SHOTS-EXIT 9999 TIMES.

       210-RECTANGLE.

           set Response::ContentType to "image/jpeg"
           invoke drawArea::Save(Response::OutputStream, type ImageFormat::Jpeg)
           invoke drawArea::Dispose
           invoke g::Dispose()
           invoke Response::End()
           exit method.

       SHOW-SHOTS.
          IF  WORK-X-IN = 15 AND
               WORK-X-OUT = 15 AND
               WORK-Y-IN = 15 AND
               WORK-Y-OUT = 15
           NEXT SENTENCE
           ELSE
           IF PK330-T-SHOT-LOC-X(AA) NOT < WORK-X-IN AND
              PK330-T-SHOT-LOC-X(AA) NOT > WORK-X-OUT AND
              PK330-T-SHOT-LOC-Y(AA) NOT < WORK-Y-IN AND
              PK330-T-SHOT-LOC-Y(AA) NOT > WORK-Y-OUT
               NEXT SENTENCE
               ELSE
               GO TO SHOTS-EXIT.

           IF PK330-T-SHOT-LOC-X(AA) = 0 AND PK330-T-SHOT-LOC-Y(AA) = 0
               GO TO SHOTS-EXIT
               ELSE
               COMPUTE WS-HORIZ ROUNDED = (PK330-T-SHOT-LOC-X(AA) / 2.67) * dimx
               COMPUTE WS-VERT ROUNDED = (PK330-T-SHOT-LOC-Y(AA) / 2.67) * dimy
               SUBTRACT 3 FROM WS-HORIZ
               SUBTRACT 3 FROM WS-VERT
               IF PK330-T-GOAL-FLAG(AA) = "Y"
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Chartreuse), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
               IF PK330-T-GOAL-FLAG(AA) = "S"
                   invoke g::DrawEllipse(type Pens::RoyalBlue, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::RoyalBlue), WS-HORIZ, WS-VERT, 7, 7)
               ELSE
                   invoke g::DrawEllipse(type Pens::Black, WS-HORIZ, WS-VERT, 7, 7)
                   invoke g::FillEllipse(type SolidBrush::New(type Color::Black), WS-HORIZ, WS-VERT, 7, 7).
        
           IF PK330-T-NEXT-SHOT-LOC-X(AA) = 0 AND PK330-T-NEXT-SHOT-LOC-Y(AA) = 0
               GO TO SHOTS-EXIT
           ELSE
               COMPUTE WS-X ROUNDED = (PK330-T-SHOT-LOC-X(AA) / 2.67) * dimx
               COMPUTE WS-Y ROUNDED = (PK330-T-SHOT-LOC-Y(AA) / 2.67) * dimy
               IF PK330-HIDE-LINES NOT = "Y"
                   invoke g::DrawLine(type Pens::Blue, ws-x, WS-Y, dimx2, dimy2).
               COMPUTE WS-X ROUNDED = (PK330-T-NEXT-SHOT-LOC-X(AA) / 2.67) * dimx
               COMPUTE WS-Y ROUNDED = (PK330-T-NEXT-SHOT-LOC-Y(AA) / 2.67) * dimy
               invoke g::DrawLine(type Pens::Red, ws-x, WS-Y, dimx2, dimy2).


       SHOTS-EXIT.
          add 1 to AA.
          exit.

       end method.
 
       end class.
