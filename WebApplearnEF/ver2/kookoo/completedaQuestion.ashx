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

        updateStudentLastCompletedQuestion(callerphoneno, QuestionNo);
        finalanswer = getScore();


        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }

    public string getScore()
    {
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> Good, You completed this Question </playtext>
            <gotourl>{StudentStatus.baseURL}startorContinueQuiz.ashx</gotourl>    
        </Response>";

        return xmlresponse;
    }


    private void updateStudentLastCompletedQuestion(long callerphoneno, string completedquestion)
    {

    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}