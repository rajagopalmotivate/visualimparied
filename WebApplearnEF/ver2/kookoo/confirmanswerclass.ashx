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

        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        StudentClassStd  = (string) context.Request.QueryString["std"];
        string kookooevent = "";
        if (context.Request.QueryString["event"] !=null)
            kookooevent = (string) context.Request.QueryString["event"];

        string finalanswer = "";


        finalanswer = confirmuserinputonClsStd();

        if (kookooevent.Equals("GotDTMF"))
        {
            string userEnteredKeys = (string)context.Request.QueryString["data"];
            if (string.IsNullOrEmpty(userEnteredKeys))
                finalanswer = retryoncemoreDidNotPress();
            else
                finalanswer = redirectoConfirmationDialog(userEnteredKeys);
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }



    private string tryagin()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Oops. the server is unable to add due to a technical problem. Please call again</playtext>  
</Response>";
        return answerxml;
    }

    private string confirmuserinputonClsStd()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Just want to confirm your input now. Is this correct? </playtext> 
    <playtext>Are you in standard  </playtext>     
    <say-as  format='501' lang='EN'>{StudentClassStd}</say-as>
    <collectdtmf l='1' >     
        <playtext>Press 1 to confirm. Press 0 for enter your standard again.</playtext>   
    </collectdtmf>
</Response>";
        return answerxml;
    }

    private string retryoncemoreDidNotPress()
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>I did NOT receive any key presses yet </playtext> 
    <playtext>Are you in standard  </playtext><playtext>{StudentClassStd} </playtext>     
    <playtext>Again, </playtext> <say-as  format='501' lang='EN'>{StudentClassStd}</say-as>
    <collectdtmf l='1' >     
        <playtext>Press 1 to confirm. Press 0 for no.</playtext>   
    </collectdtmf>
</Response>";
        return answerxml;
    }


    private string redirectoConfirmationDialog(string userpressed)
    {
        string answerxml = "";
        int userinput = int.Parse(userpressed);
        if (userinput == 1)
        {
            answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Your roll no is </playtext> <say-as  format='501' lang='EN'>{rollno}</say-as>
    <playtext>You are registered to be coached on standard </playtext> <say-as  format='501' lang='EN'>{StudentClassStd}</say-as>
    <playtext>One moment. Please wait as we are now registering you in database </playtext> 
    <gotourl>{StudentStatus.baseURL}SavingStandardInfo.ashx?rollno={rollno}&amp;lang={lang}&amp;std={StudentClassStd}</gotourl>    
</Response>";
            return answerxml;
        }
        else
        {
            answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Sorry. Our system understood incorrectly. If you face this issue frequently, try dialing again without putting on speaker phone . To enroll yourself for the coaching for right standard, kindly call the same number again </playtext> 
    <playtext>Buy for now </playtext> 
    <hangup> </hangup>
</Response>";
            return answerxml;
        }
    }



    public bool IsReusable
    {
        get {
            return false;
        }
    }

}