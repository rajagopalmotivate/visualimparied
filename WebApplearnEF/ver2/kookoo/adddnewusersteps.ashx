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
    long rollno;
    string lang; 


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        string callerphoneno =  (string) context.Request.QueryString["cid_e164"];
        sessionid = (string) context.Request.QueryString["sid"];
        string kookooevent = (string) context.Request.QueryString["event"];
        string internaltrackurl = (string) context.Request.QueryString["step"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];


        string finalanswer = "";

        if (internaltrackurl.Equals("GETLANG"))
        {
            if (string.IsNullOrEmpty(kookooevent))
            {
                finalanswer = askuserinputonClsStd();
            }
            else if (kookooevent.Equals("GotDTMF"))
            {
                string userEnteredKeys = (string)context.Request.QueryString["data"];
                if (string.IsNullOrEmpty(userEnteredKeys))
                    finalanswer = retryoncemoreDidNotPress();
                else
                    finalanswer = redirectoConfirmationDialog(userEnteredKeys);
            }
        }
        else if (internaltrackurl.Equals("CONFIRMLANG"))
        {
            if( string.IsNullOrEmpty(kookooevent) )
            {
                string userEnteredKeys = (string)context.Request.QueryString["UserEnteredData"];
                finalanswer = confirmuserinput(userEnteredKeys);
            }
            else if ( kookooevent.Equals("Recognize")  )
            {
                string spokendata = (string)context.Request.QueryString["data"];
                string userEnteredKeys = (string)context.Request.QueryString["UserEnteredData"];

                if( string.IsNullOrEmpty(spokendata) )
                    finalanswer =  retryoncemoreDidNotHear(userEnteredKeys);
                else if ( spokendata.Equals("No")  )
                    finalanswer = retryoncemoreDidNotPressCorrectly();
                else if (spokendata.Equals("Yes") )
                {
                    bool isupdated = updateUsertoDBwithStdClass(context, userEnteredKeys);
                    if (isupdated) finalanswer = updatedSuccessfully();
                    else finalanswer = hangup();
                }
            }
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);

        return doc;
    }

    private bool updateUsertoDBwithStdClass(HttpContext mycontext, string userEnteredKeys)
    {
        bool issuccess = false;

        long callernumber = 0;

        if ((string)mycontext.Request.QueryString["cid"] != null)
        {
            callernumber = long.Parse((string)mycontext.Request.QueryString["cid"]);
            callernumber = UtilitiesClasses.getPhonenumbersinConsistentFormat(callernumber);
        }
        else
            return issuccess;
        StudentTAB mystudent = StudentStatus.getStudentbyAssociatedPhoneNo(callernumber);

        if (mystudent == null) return issuccess;
        using (var context = new learnthinksavedbEntities29Jan2016())
        {
            mystudent.ClassStd = int.Parse( userEnteredKeys);
            context.Entry(mystudent).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            issuccess = true;
        }
        return issuccess;
    }


    private string askuserinputonClsStd()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>What standard are you studying? </playtext> 
    <collectdtmf l='2' o='4000'>  
        <playtext>Use your phone's key pad to press the number. </playtext> 
        <playtext>For example, if you are in standard 7, just press 7. </playtext> 
        <playtext> After you press, request you to wait for few seconds. </playtext> 
    </collectdtmf>
</Response>";
        return answerxml;
    }

    private string redirectoConfirmationDialog(string dtfmdata)
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Thank you. You pressed {dtfmdata}</playtext>  
    <gotourl>{StudentStatus.baseURL}confirmanswerclass.ashx?rollno={rollno}&amp;lang={lang}&amp;std={dtfmdata}</gotourl>
</Response>";
        return answerxml;
    }


    private string confirmuserinput(string dtfmdata)
    {
        string xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> You entered  {dtfmdata} </playtext>
            <gotourl>{StudentStatus.baseURL}confirmanswerclass.ashx?rollno={rollno}&amp;lang={lang}&amp;std={dtfmdata}</gotourl>    
        </Response>";
        return xmlresponse;
    }


    private string retryoncemoreDidNotPress()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Sorry, I couldn't detect any key presses. Did you press any key?. Let's try again</playtext> 
    <gotourl>{StudentStatus.baseURL}adddnewusersteps.ashx?step=GETLANG</gotourl>
</Response>";
        return answerxml;
    }

    private string retryoncemoreDidNotHear(string entereddata)
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Sorry, i couldnot understand the speech. Let's try this again</playtext> 
    <gotourl>{StudentStatus.baseURL}adddnewusersteps.ashx?step=CONFIRMLANG&amp;UserEnteredData={entereddata}</gotourl>
</Response>";
        return answerxml;
    }

    private string retryoncemoreDidNotPressCorrectly()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Sorry, we didn't understand your key press this time. Let's try this again</playtext> 
    <gotourl>{StudentStatus.baseURL}adddnewusersteps.ashx?step=GETLANG</gotourl>
</Response>";
        return answerxml;
    }


    private string updatedSuccessfully()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Thank you, I noted down your standard in the database. </playtext> 
    <playtext>You can call this phone number daily to learn and practice </playtext> 
    <playtext>You can call us anytime even now, Let me take leave of you now. Good day</playtext> 
    <hangup></hangup>    
</Response>";
        return answerxml;
    }


    private string hangup()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Sorry, there is some technical error. Please try again. Due to technical error, I need to hangup </playtext> 
    <hangup></hangup> 
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