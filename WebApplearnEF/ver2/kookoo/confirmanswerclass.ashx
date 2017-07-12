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
        string callerphoneno =  (string) context.Request.QueryString["cid_e164"];
        sessionid = (string) context.Request.QueryString["sid"];
        string kookooevent = (string) context.Request.QueryString["event"];
        string finalanswer = "";

        long rollno = addNewUsertoDB(context);
        if (rollno != -1)
            finalanswer = congratsonRegistering(rollno);
        else
        {
            //sendalertoadmin(); 
            finalanswer = tryagin();
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }

    private long addNewUsertoDB(HttpContext mycontext)
    {
        long rollno = -1;
        using (var context = new learnthinksavedbEntities29Jan2016())
        {
            StudentTAB mystudent = new StudentTAB();
            if ((string)mycontext.Request.QueryString["cid"] != null)
            {
                long callerphoneno = long.Parse((string)mycontext.Request.QueryString["cid"]);
                mystudent.AssociatedPhoneNo = UtilitiesClasses.getPhonenumbersinConsistentFormat(callerphoneno);
            }
            if ( (string)mycontext.Request.QueryString["cid_e164"] !=null )
                mystudent.AssociatedPhoneNoE164 = (string)mycontext.Request.QueryString["cid_e164"];

            StudentTAB savedrow = context.StudentTAB.Add(mystudent);
            context.SaveChanges();
            rollno = savedrow.StudentRollNo;
        }

        return rollno;
    }

    private string tryagin()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Oops. the server is unable to add due to a technical problem. Please call again</playtext>  
</Response>";
        return answerxml;
    }

    private string congratsonRegistering(long rollno)
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Congratulations, You are registered as a student at Mitra Jyothi Coaching Program </playtext> 
    <playtext>You can call this phone number anytime to talk to your coach.</playtext> 
    <playtext>Your roll number is </playtext><playtext>{rollno} </playtext>     
    <playtext>Please note down your roll numbers</playtext> 
    <playtext>Again, Your roll number is </playtext> <say-as  format='501' lang='EN'>{rollno}</say-as>
    <gotourl>{StudentStatus.baseURL}adddnewusersteps.ashx?step=GETLANG</gotourl>
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