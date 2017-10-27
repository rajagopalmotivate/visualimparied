<%@ WebHandler Language="C#" Class="JHandler" %>

using System;
using System.Web;
using System.Xml;
using System.IO;
using System.Data.Common;
using WebApplearnEF.ver2.kookoo;
using WebApplearnEF.ver2;

//SID
//SK4c5bbb44d17f0460cd166e5dc1b9b4b7
//SECRET
//UMzZFx9PvmSeRQUDCCrL5CdC0TYSSvib


public class JHandler : IHttpHandler
{

    public void ProcessRequest (HttpContext context)
    {
        XmlDocument doc = GetXmlToShow(context);
        ProcessXMLPlayAudio.autoInsertNodesinDB(doc);
        doc = ProcessXMLPlayAudio.ReplaceNodesPlayTexttoPlayAudio (doc, lang);

        context.Response.ContentType = "text/xml";

        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        context.Response.Expires = -1;
        context.Response.Cache.SetAllowResponseInBrowserHistory(true);
        doc.Save(context.Response.Output); //doc saves itself to the textwriter, using the encoding of the text-writer (which comes from response.contentEncoding)
        context.Response.Flush();
        context.Response.End();
    }

    long rollno;
    StudentTAB mystudent;
    string sessionid;
    string lang;

    private XmlDocument GetXmlToShow(HttpContext context)
    {
        long callerphoneno =  long.Parse ((string) context.Request.QueryString["cid"]);
        callerphoneno = UtilitiesClasses.getPhonenumbersinConsistentFormat(callerphoneno);
        sessionid = (string) context.Request.QueryString["sid"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        

        string finalanswer = "";

        if ( context.Request.QueryString["event"] == null )
        {
            mystudent = StudentStatus.getStudenDetailsByRollNo(rollno);
            //TODO: MOTIVATE STUDENT 
            finalanswer = selectSubject();
        }
        else 
        {
            string kookooevent = (string) context.Request.QueryString["event"];
            string dtmfnumberpressed = (string)context.Request.QueryString["data"];
            if(dtmfnumberpressed.Length == 0 )   finalanswer = selectSubjectRepeat();
            if (dtmfnumberpressed.Contains("1")) finalanswer = ContinueQuiz(1);
            if (dtmfnumberpressed.Contains("2")) finalanswer = ContinueQuiz(2);
            if (dtmfnumberpressed.Contains("9")) finalanswer = Help();
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }


    private string selectSubject()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <collectdtmf l='1' >  
        <playtext>Choose subject to learn now. </playtext>   
        <playtext> 1 for SCIENCE.  2 for MATHS. </playtext>   
    </collectdtmf>
    <playtext>No response received so far</playtext> 
</Response>";
        return answerxml;
    }

    private string Help()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <collectdtmf l='1' >  
        <playtext>You can start learning for free. You can call us everyday. </playtext>   
    </collectdtmf>
    <playtext>No response received so far</playtext> 
</Response>";
        return answerxml;
    }


    private string selectSubjectRepeat()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <collectdtmf l='1' >    
        <playtext>What subject do you want to learn now? </playtext> 
        <playtext>Press 1 for SCIENCE. Press 2 for MATHS. </playtext>   
    </collectdtmf>
    <playtext>No response received so far</playtext> 
</Response>";
        return answerxml;
    }






    private string ContinueQuiz(int subject)
    {
        string subjectstring="MATH";
        if (subject == 2) subjectstring = "MATH";
        if (subject == 1) subjectstring = "SCIENCE";

        string subjectstringdemo="MATH";


        string langstring = UtilitiesClasses.getLanguageinStringFormat(lang);

        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext>Your selected </playtext> <playtext>{subjectstring}</playtext>
            <playtext> In the database today, We have only few MATH questions. So let's do math </playtext>            
            <playtext>Shall we start coaching you now   </playtext>
            <gotourl>{StudentStatus.baseURL}ContinueQuiz.ashx?rollno={rollno}&amp;lang={lang}&amp;subject={subjectstringdemo}</gotourl>    
        </Response>";
        return answerxml;
    }


    public bool IsReusable
    {
        get {
            return false;
        }
    }

}