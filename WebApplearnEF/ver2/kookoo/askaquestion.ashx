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

        context.Response.ContentType = "text/xml";


        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        context.Response.Expires = -1;
        context.Response.Cache.SetAllowResponseInBrowserHistory(true); //"works around an Internet&nbsp;Explorer bug"
                                                                       //  context.Response.BufferOutput = false;
                                                                       //  context.Response.Flush(); 

        doc.Save(context.Response.Output); //doc saves itself to the textwriter, using the encoding of the text-writer (which comes from response.contentEncoding)

        context.Response.Flush();
        context.Response.End();

    }


    StudentTAB mystudent;
    string sessionid;

    private XmlDocument GetXmlToShow(HttpContext context)
    {
        long callerphoneno =  long.Parse ((string) context.Request.QueryString["cid"]);
        callerphoneno = UtilitiesClasses.getPhonenumbersinConsistentFormat(callerphoneno);
        sessionid = (string) context.Request.QueryString["sid"];
        string kookooevent = (string) context.Request.QueryString["event"];
        string QuestionNo = (string) context.Request.QueryString["QuestionNo"];

        string finalanswer = "";

        if (string.IsNullOrEmpty(kookooevent))
        {
            finalanswer = askthequestion(QuestionNo);
        }
        else if (kookooevent.Equals("GotDTMF"))
        {
            string studentsAnswerChoice = (string)context.Request.QueryString["data"];
            if (string.IsNullOrEmpty(studentsAnswerChoice))
                finalanswer = askthequestion(QuestionNo);
            else
                finalanswer = checktheanswer(QuestionNo, studentsAnswerChoice);
        }
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }

    public string askthequestion(string QuestionNostring)
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        string question = myquestion.E1QuestionText;
        string option1 = myquestion.E2Option1Text;
        string option2 = myquestion.E3Option2Text;
        string option3 = myquestion.E4Option3Text;

        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Here comes your Question. </playtext>
            <playtext>{question}</playtext>
            <playtext>Please answer now by pressing 1 or 2 or 3  </playtext>
          <collectdtmf l='1' o='15000'>     
             <playtext>Press 1 for </playtext>             
             <playtext>{option1} </playtext>                   
             <playtext>Press 2 for </playtext>             
             <playtext>{option2} </playtext>   
             <playtext>Press 3 for </playtext>             
             <playtext>{option3} </playtext> 
            <playtext>Please answer now by pressing 1 or 2 or 3  </playtext>          
          </collectdtmf>
        </Response>";

        return xmlresponse;
    }


    public string checktheanswer(string QuestionNostring, string studentsAnswerChoice )
    {
        long QuestionNo = long.Parse(QuestionNostring);
        string reply = "";
        if (studentsAnswerChoice == "1") reply = "correct answer. Very good.";
        else  reply = "oops. The correct answer is option 1"; 

        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Checking your answer </playtext>
            <playtext>{reply}</playtext>
            <gotourl>{StudentStatus.baseURL}completedaQuestion.ashx?QuestionNo={QuestionNostring}</gotourl>    
        </Response>";

        return xmlresponse;
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}