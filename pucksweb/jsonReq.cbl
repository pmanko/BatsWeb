       class-id pucksweb.jsonReq public.
       01 credentials      type credentialsD public.
       01 #type            type Char public.
       01 database         type String public.
       01 visitors         type String public.
       01 home             type String public.
       01 year             type String public.
       01 #date            type String public.
       end class.
       
       class-id credentialsD public.
       01 team              String public.
       01 username          String public.
       01 password          String public.
       end class.
