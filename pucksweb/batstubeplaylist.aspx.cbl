       class-id pucksweb.batstube is partial 
                implements type System.Web.UI.ICallbackEventHandler
                inherits type System.Web.UI.Page public.
                 
       working-storage section.
       01 callbackReturn type String.
       01 aa                       type Single.
       01 clipName                 type String.
       01 clipDesc                 type String.
       01 clipStart                type String.
       01 clipDuration             type String.
PM     01 vidPaths                 type String. 
 PM    01 vidTitles                type String.
       01 app-data-folder          type String.
       01 chars                    type String constant private value "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".
       method-id Page_Load protected.
       local-storage section.
       01 clips                    type String occurs any.
       01 cm                       type ClientScriptManager.
       01 cbReference              type String.
       01 callbackScript           type String.       

       procedure division using by value param-sender as object
                                         param-e as type System.EventArgs.


      * #### ICallback Implementation ####
           set cm to self::ClientScript
           set cbReference to cm::GetCallbackEventReference(self, "arg", "GetServerData", "context")
           set callbackScript to "function CallServer(arg, context)" & "{" & cbReference & "};"
           invoke cm::RegisterClientScriptBlock(self::GetType(), "CallServer", callbackScript, true)
      * #### End ICallback Implement  ####            

      *    declare stream as type Byte occurs any = type System.Text.Encoding::UTF8::GetBytes("sf33fvv4")
      *    declare base64 as type String = type Convert::ToBase64String(type System.Text.Encoding::UTF8::GetBytes("sf33fvv4"))
      *    declare encodedValue as type Byte occurs any = type MachineKey::Protect(stream)

           if Request::QueryString["c"] not = null
               set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
               declare decodedString as type String = type System.Text.Encoding::UTF8::GetString(type Convert::FromBase64String(Request::QueryString["c"]))
      *        declare requestStream as type Byte occurs any = type System.Text.Encoding::UTF8::GetBytes(Request::QueryString["c"])
      *        declare decodedValue as type Byte occurs any = type MachineKey::Unprotect(requestStream)
      *        declare decodedString as type String = type System.Text.Encoding::UTF8::GetString(decodedValue)
               if type File::Exists(app-data-folder & "\" & decodedString & ".txt")
                   set clips to (type File::ReadAllText(app-data-folder & "\" & decodedString & ".txt"))::Split(',')
PM    *            set self::Session::Item("video-paths") to "\VID2017\04\23\CAPITALS_MAPLE_LEAFS\1041A.MP4"
PM    *            set self::Session::Item("video-titles") to "123"
               end-if
           else
               go to clips-end
           end-if

           move 0 to aa.
       clips-loop.
           if aa = clips::Length - 1
               go to clips-done.
      * for bats
      *    set clipName to clips[aa]::Substring(clips[aa]::IndexOf("@") + 1) 
      *    set clipDesc to clips[aa]::Substring(0, clips[aa]::IndexOf("@")) 
           set clipName to clips[aa]::Substring(clips[aa]::IndexOf("@") + 1, (clips[aa]::LastIndexOf(':') - clips[aa]::IndexOf('@') - 1)) 
           set clipDesc to clips[aa]::Substring(0, clips[aa]::IndexOf("@")) 
           set clipStart to clips[aa]::Substring(clips[aa]::LastIndexOf(':') + 1, (clips[aa]::IndexOf(';') - clips[aa]::LastIndexOf(':') - 1)) 
           set clipDuration to clips[aa]::Substring(clips[aa]::IndexOf(";") + 1) 

PM         set vidPaths to vidPaths & clipName & "#t=" & clipStart &  "," & clipDuration & ";" 
PM         set vidTitles to vidTitles & clipDesc & ";"
           add 1 to aa
           go to clips-loop.
       clips-done.
PM         set self::Session::Item("video-paths") to vidPaths
PM         set self::Session::Item("video-titles") to vidTitles.
       clips-end.

           goback.
       end method.
 
      *#####               Client Callback Implementation             #####
      *##### (https://msdn.microsoft.com/en-us/library/ms178208.aspx) #####
      *####################################################################
 
       method-id RaiseCallbackEvent public.
       local-storage section.
       01 actionFlag type String.
       01 methodArg type String.       
       procedure division using by value eventArgument as String.
           unstring eventArgument
               delimited by "|"
               into actionFlag, methodArg
           end-unstring.
           
           if actionFlag = 'share-playlist'
               set callbackReturn to actionFlag & "|" & self::sharePlaylist()
           else if actionFlag = 'set-start'
               set callbackReturn to actionFlag & "|" & self::setStart(methodArg)
           else if actionFlag = 'set-end'
               set callbackReturn to actionFlag & "|" & self::setEnd(methodArg)
           else if actionFlag = 'move-up'
               set callbackReturn to actionFlag & "|" & self::moveUp(methodArg)
           else if actionFlag = 'move-down'
               set callbackReturn to actionFlag & "|" & self::moveDown(methodArg)
           else if actionFlag = 'remove-clip'
               set callbackReturn to actionFlag & "|" & self::removeClip(methodArg)
           else if actionFlag = 'add-clips'
               set callbackReturn to actionFlag & "|" & self::addClips(methodArg).


      *     else if (type Single::TryParse(actionFlag, reference n))
       end method.
       
       method-id GetCallbackResult public.
       procedure division returning returnToClient as String.
       
           set returnToClient to callbackReturn.
           
       end method.
       
      *####################################################################
       
       method-id sharePlaylist final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 fileText                 type String.
       01 stringChars              type Char occurs 8.
       01 rand                     type Random.
       linkage section.
       procedure division using pathChange as type String returning returnVal as String.
           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
PM         set vidPaths to pathChange::Substring(0, pathChange::IndexOf('~'))
PM         set vidTitles to pathChange::Substring(pathChange::IndexOf('~') + 1)

           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           set fileText to fileText & clipTitles[aa]::Trim & "@" & clipPaths[aa]::Substring(0, clipPaths[aa]::IndexOf("#")) & ":" & clipPaths[aa]::Substring(clipPaths[aa]::LastIndexOf("=") + 1)::Replace(",", ";") & ','
           add 1 to aa
           go to clips-loop.
       clips-done.

           set rand to new Random
           move 0 to aa.
       filename-loop.
           if aa = stringChars::Length
               go to filename-done.
           set stringChars[aa] to chars[rand::Next(chars::Length)]
           add 1 to aa.
           go to filename-loop.
       filename-done.
           declare fileName as type String = new String(stringChars)
           if type File::Exists(app-data-folder & fileName & ".txt")
               move 0 to aa
               go to filename-loop.
      *    declare stream as type Byte occurs any = type System.Text.Encoding::UTF8::GetBytes(fileName)
           declare base64 as type String = type Convert::ToBase64String(type System.Text.Encoding::UTF8::GetBytes(fileName))

           invoke type File::WriteAllText(app-data-folder & "\" & fileName & ".txt", fileText)

           set returnVal to "localhost:53112/batstube.aspx?c=" & base64
       end method.

       method-id setStart final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 changePath                type String.
       01 changeTime                type String.
       01 holdPath                 type String.
       01 holdDouble                 type Double.
       linkage section.
       procedure division using pathTime as type String returning returnVal as String.
           set changePath to pathTime::Substring(0, pathTime::IndexOf(';'))
           set changeTime to pathTime::Substring(pathTime::IndexOf(';') + 1, pathTime::IndexOf('+') - pathTime::IndexOf(';') - 1)
PM         set vidPaths to pathTime::Substring(pathTime::IndexOf('+') + 1)
           invoke type Double::TryParse(changeTime, reference holdDouble)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
      *    set holdPath to changePath::Substring(22)::Replace('/','\')
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           if clipPaths[aa] = changePath::Replace('/','\')
               go to clips-done.
           add 1 to aa
           go to clips-loop.
       clips-done.
           set holdPath to clipPaths[aa]
           set clipPaths[aa] to holdPath::Substring(0, holdPath::IndexOf('=') + 1) & type Convert::ToInt32(holdDouble) & holdPath::Substring(holdPath::IndexOf(','))
           set vidPaths to ""
           move 0 to aa.
       vidPaths-loop.
           if aa = clipPaths::Length - 1
               go to vidPaths-done.
           set vidPaths to vidPaths & clipPaths[aa] & ';'
           add 1 to aa
           go to vidPaths-loop.
       vidPaths-done.
           set returnVal to vidPaths
       end method.

       method-id setEnd final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 changePath                type String.
       01 changeTime                type String.
       01 holdPath                 type String.
       01 holdDouble                 type Double.
       linkage section.
       procedure division using pathTime as type String returning returnVal as String.
           set changePath to pathTime::Substring(0, pathTime::IndexOf(';'))
           set changeTime to pathTime::Substring(pathTime::IndexOf(';') + 1, pathTime::IndexOf('+') - pathTime::IndexOf(';') - 1)
PM         set vidPaths to pathTime::Substring(pathTime::IndexOf('+') + 1)
           invoke type Double::TryParse(changeTime, reference holdDouble)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           if clipPaths[aa] = changePath::Replace('/','\')
               go to clips-done.
           add 1 to aa
           go to clips-loop.
       clips-done.
           set holdPath to clipPaths[aa]
           set clipPaths[aa] to holdPath::Substring(0, holdPath::IndexOf(',') + 1) & type Convert::ToInt32(holdDouble)
           set vidPaths to ""
           move 0 to aa.
       vidPaths-loop.
           if aa = clipPaths::Length - 1
               go to vidPaths-done.
           set vidPaths to vidPaths & clipPaths[aa] & ';'
           add 1 to aa
           go to vidPaths-loop.
       vidPaths-done.
           set returnVal to vidPaths
       end method.

       method-id moveUp final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 changePath                type String.
       01 holdPath                 type String.
       01 holdTitle                 type String.
       linkage section.
       procedure division using pathChange as type String returning returnVal as String.
           set changePath to pathChange::Substring(0, pathChange::IndexOf('+'))
PM         set vidPaths to pathChange::Substring(pathChange::IndexOf('+') + 1, pathChange::IndexOf('~') - pathChange::IndexOf('+') - 1)
PM         set vidTitles to pathChange::Substring(pathChange::IndexOf('~') + 1)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           if clipPaths[aa] = changePath::Replace('/','\')
               go to clips-done.
           add 1 to aa
           go to clips-loop.
       clips-done.
      *    move aa to moveIndex.
           if aa = 0
               go to vidPaths-done.
           set holdPath to clipPaths[aa]
           set holdTitle to clipTitles[aa]
           move clipPaths[aa - 1] to clipPaths[aa]
           move clipTitles[aa - 1] to clipTitles[aa]
           move holdPath to clipPaths[aa - 1]
           move holdTitle to clipTitles[aa - 1]
           set vidPaths to ""
           set vidTitles to ""
           move 0 to aa.
       vidPaths-loop.
           if aa = clipPaths::Length - 1
               go to vidPaths-done.
           set vidPaths to vidPaths & clipPaths[aa] & ';'
           set vidTitles to vidTitles & clipTitles[aa] & ';'
           add 1 to aa
           go to vidPaths-loop.
       vidPaths-done.
           set returnVal to vidPaths & '~' & vidTitles

       end method.

       method-id moveDown final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 changePath                type String.
       01 holdPath                 type String.
       01 holdTitle                 type String.
       linkage section.
       procedure division using pathChange as type String returning returnVal as String.
           set changePath to pathChange::Substring(0, pathChange::IndexOf('+'))
PM         set vidPaths to pathChange::Substring(pathChange::IndexOf('+') + 1, pathChange::IndexOf('~') - pathChange::IndexOf('+') - 1)
PM         set vidTitles to pathChange::Substring(pathChange::IndexOf('~') + 1)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           if clipPaths[aa] = changePath::Replace('/','\')
               go to clips-done.
           add 1 to aa
           go to clips-loop.
       clips-done.
      *    move aa to moveIndex.
           if aa = clipPaths::Length - 2
               go to vidPaths-done.
           set holdPath to clipPaths[aa]
           set holdTitle to clipTitles[aa]
           move clipPaths[aa + 1] to clipPaths[aa]
           move clipTitles[aa + 1] to clipTitles[aa]
           move holdPath to clipPaths[aa + 1]
           move holdTitle to clipTitles[aa + 1]
           set vidPaths to ""
           set vidTitles to ""
           move 0 to aa.
       vidPaths-loop.
           if aa = clipPaths::Length - 1
               go to vidPaths-done.
           set vidPaths to vidPaths & clipPaths[aa] & ';'
           set vidTitles to vidTitles & clipTitles[aa] & ';'
           add 1 to aa
           go to vidPaths-loop.
       vidPaths-done.
           set returnVal to vidPaths & '~' & vidTitles

       end method.

       method-id removeClip final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 changePath                type String.
       linkage section.
       procedure division using pathChange as type String returning returnVal as String.
           set changePath to pathChange::Substring(0, pathChange::IndexOf('+'))
PM         set vidPaths to pathChange::Substring(pathChange::IndexOf('+') + 1, pathChange::IndexOf('~') - pathChange::IndexOf('+') - 1)
PM         set vidTitles to pathChange::Substring(pathChange::IndexOf('~') + 1)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           set vidPaths to ""
           set vidTitles to ""
           move 0 to aa.
       clips-loop.
           if aa = clipPaths::Length - 1
               go to clips-done.
           if clipPaths[aa] = changePath::Replace('/','\')
               add 1 to aa
               go to clips-loop.
           set vidPaths to vidPaths & clipPaths[aa] & ';'
           set vidTitles to vidTitles & clipTitles[aa] & ';'
           add 1 to aa
           go to clips-loop.
       clips-done.
           set returnVal to vidPaths & '~' & vidTitles

       end method.

       method-id addClips final private.
       local-storage section.
       01 clipTitles               type String occurs any.
       01 clipPaths                type String occurs any.
       01 clips                    type String occurs any.
       01 changePath               type String.
       01 newPaths                  type String.
       01 newTitles                type String.
       01 holdTitle                 type String.
       01 stringChars              type Char occurs 8.
       01 rand                     type Random.
       linkage section.
       procedure division using pathChange as type String returning returnVal as String.
           set app-data-folder to type HttpContext::Current::Server::MapPath("~/App_Data")
           set changePath to pathChange::Substring(0, pathChange::IndexOf('+'))
PM         set vidPaths to pathChange::Substring(pathChange::IndexOf('+') + 1, pathChange::IndexOf('~') - pathChange::IndexOf('+') - 1)
PM         set vidTitles to pathChange::Substring(pathChange::IndexOf('~') + 1)
           set clipPaths to vidPaths::Split(';')
           set clipTitles to vidTitles::Split(';')
           declare decodedString as type String = type System.Text.Encoding::UTF8::GetString(type Convert::FromBase64String(changePath::Substring(changePath::IndexOf('=') + 1)))
           if type File::Exists(app-data-folder & "\" & decodedString & ".txt")
               set clips to (type File::ReadAllText(app-data-folder & "\" & decodedString & ".txt"))::Split(',')
           else
               go to clips-done.
          move 0 to aa.
       clips-loop.
           if aa = clips::Length - 1
               go to clips-done.
      * for bats
      *    set clipName to clips[aa]::Substring(clips[aa]::IndexOf("@") + 1) 
      *    set clipDesc to clips[aa]::Substring(0, clips[aa]::IndexOf("@")) 
           set clipName to clips[aa]::Substring(clips[aa]::IndexOf("@") + 1, (clips[aa]::LastIndexOf(':') - clips[aa]::IndexOf('@') - 1)) 
           set clipDesc to clips[aa]::Substring(0, clips[aa]::IndexOf("@")) 
           set clipStart to clips[aa]::Substring(clips[aa]::LastIndexOf(':') + 1, (clips[aa]::IndexOf(';') - clips[aa]::LastIndexOf(':') - 1)) 
           set clipDuration to clips[aa]::Substring(clips[aa]::IndexOf(";") + 1) 

PM         set newPaths to newPaths & clipName & "#t=" & clipStart &  "," & clipDuration & ";" 
PM         set newTitles to newTitles & clipDesc & ";"
           add 1 to aa
           go to clips-loop.
       clips-done.
           set returnVal to vidPaths & newPaths & '~' & vidTitles & newTitles

       end method.


       method-id playsButton_Click protected.
       linkage section.
       procedure division using by value sender as object e as type System.EventArgs.
PM         set vidPaths to self::Session::Item("video-paths")
PM         set vidTitles to self::Session::Item("paths-change")
PM         set self::Session::Item("video-paths") to "\VID2017\04\23\CAPITALS_MAPLE_LEAFS\1041A.mp4#t=11,21;\VID2017\04\23\CAPITALS_MAPLE_LEAFS\1042A.mp4#t=9,30;\VID2017\04\23\CAPITALS_MAPLE_LEAFS\1043A.mp4#t=49,70;"
       end method.

       end class.
