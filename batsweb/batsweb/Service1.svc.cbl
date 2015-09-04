       class-id batsweb.Service1 public
                attribute System.ServiceModel.ServiceContract(name Namespace = "")
                attribute System.ServiceModel.Activation.AspNetCompatibilityRequirements(name RequirementsMode = type System.ServiceModel.Activation.AspNetCompatibilityRequirementsMode::Allowed)
       
       working-storage section.

       *> To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
       *> To create an operation that returns XML,
       *>     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
       *>     and include the following line in the operation body:
       *>         set WebOperationContext::Current::OutgoingResponse::ContentType to "text/xml"
       
       method-id DoWork public 
                 attribute System.ServiceModel.OperationContractAttribute()
                 attribute System.ServiceModel.Web.WebGetAttribute().
       procedure division returning videos as string occurs any.
           set content of videos to ("MAJORS/VID2015/05/28/0280020/0280020L/1288A.mp4","MAJORS/VID2015/05/28/0280020/0280020L/1289A.mp4")
           goback.
       end method.

       *> Add more operations here and mark them with attribute System.ServiceModel.OperationContract()
       
       end class.
