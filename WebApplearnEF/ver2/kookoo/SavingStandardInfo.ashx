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
    long rollno = 0;
    string lang;
    string StudentClassStd;


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        string callerphoneno =  (string) context.Request.QueryString["cid_e164"];
        sessionid = (string) context.Request.QueryString["sid"];
        string kookooevent = (string) context.Request.QueryString["event"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        StudentClassStd  = (string) context.Request.QueryString["std"];
        string finalanswer = "";

        bool isupdatesuccessful = updateUsertoDBwithStdClass(rollno, StudentClassStd, "CBSE", "EN-IN");

        if (isupdatesuccessful)
            finalanswer = ConfirmationDialog();
        else
            finalanswer = ExceptionHandling();


        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }



    private string ConfirmationDialog()
    {
        string answerxml = "";
        answerxml = $@"
<Response sid='{sessionid}' > 
            <playtext>Congratuations. You are now registered to be coached on standard {StudentClassStd} </playtext> 
            <playtext>Shall we start coaching you right now   </playtext>
            <gotourl>{StudentStatus.baseURL}JustCalledStartQuizzing.ashx?rollno={rollno}&amp;lang={lang}</gotourl>    
</Response>";
        return answerxml;
    }


    private string ExceptionHandling()
    {
        string answerxml = "";
        answerxml = $@"
<Response sid='{sessionid}' > 
            <playtext>Sorry. There is a technical glitch in this system in updating the database record with your standard.</playtext> 
            <playtext>You can call us again . Bye for now  </playtext>
            <hangup></hangup>
</Response>";
        return answerxml;
    }

    private bool updateUsertoDBwithStdClass(long rollnumber, string clsstandard, string board, string lang)
    {
        bool issuccess = false;

        StudentTAB mystudent = StudentStatus.getStudenDetailsByRollNo (rollnumber);

        if (mystudent == null) return issuccess;
        using (var context = new learnthinksavedbEntities29Jan2016())
        {
            mystudent.ClassStd = int.Parse(  clsstandard);
            mystudent.Board = board;
            mystudent.Lang = lang;
            context.Entry(mystudent).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            issuccess = true;
        }
        return issuccess;
    }


    public bool IsReusable
    {
        get {
            return false;
        }
    }

}