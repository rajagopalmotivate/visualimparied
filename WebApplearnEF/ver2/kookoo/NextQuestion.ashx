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
        context.Response.Cache.SetAllowResponseInBrowserHistory(true);
        doc.Save(context.Response.Output); //doc saves itself to the textwriter, using the encoding of the text-writer (which comes from response.contentEncoding)
        context.Response.Flush();
        context.Response.End();
    }

    long rollno;
    StudentTAB mystudent;
    string sessionid;
    string lang;
    string subject;
    string CoachingSession;
    string QuestionId;
    string StudentClassStd;


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        subject = (string) context.Request.QueryString["subject"];
        CoachingSession = (string) context.Request.QueryString["CoachingSession"];
        QuestionId = (string) context.Request.QueryString["QuestionId"];
        StudentClassStd  = (string) context.Request.QueryString["std"];
           

        string finalanswer = "";

        finalanswer = AskaQuestion();

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }


    private string AskaQuestion()
    {
        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext> Question Unique Number is {QuestionId}  </playtext>
            <gotourl>{StudentStatus.baseURL}AskaQuestion.ashx?rollno={rollno}&amp;lang={lang}&amp;std={StudentClassStd}&amp;subject={subject}&amp;CoachingSession={CoachingSession}&amp;QuestionId={QuestionId}</gotourl>    
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