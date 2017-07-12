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
        string circle = (string) context.Request.QueryString["circle"];
        string kookooevent = (string) context.Request.QueryString["event"];
        string finalanswer = "";

        if (kookooevent.Contains("NewCall"))
        {
            //check if many phone nos are associated with the phone

            mystudent = StudentStatus.getStudentbyAssociatedPhoneNo(callerphoneno);
            if (mystudent == null) finalanswer = optintobeCoachedTEL("Welcome", circle);
            else
            {
                if(( mystudent.Lang !=null  ) && ( mystudent.ClassStd >= 1 )&& ( mystudent.Board !=null ) )
                    finalanswer = welcomeRegisteredSudentTELProccedQuizzing(mystudent.StudentRollNo, mystudent.Lang);
                else
                {

                }
            }
        }

        if (kookooevent.Contains("GotDTMF"))
        {
            string dtmfnumberpressed = (string)context.Request.QueryString["data"];
            finalanswer = optintobeCoachedTEL("Welcome", "");
            if (dtmfnumberpressed.Contains("1")) finalanswer = addNewUsertoDB("REGISTER");
            if (dtmfnumberpressed.Contains("0")) finalanswer = playsorrytext();
            if (dtmfnumberpressed.Contains("9")) finalanswer = askstudentforrollno(); ///find out what is the students Roll No
            //   if (dtmfnumberpressed.Contains("2")) finalanswer = addNewUsertoDB("TRY IT");            
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }


    private string optintobeCoachedTEL(string questiontotheuser, string circle)
    {

        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Welcome to Mitra jyothi Audio Classes. </playtext>
    <playtext>You need just a telephone to avail this phone based coaching.</playtext>
    <playtext>Everyone can study.</playtext>
    <playtext>Do you want to register for free coaching? </playtext>
    <collectdtmf l='1' >     
        <playtext>Press 1 for yes. Press 0 for no.</playtext>   
        <playtext>Incase you already have registered before, but calling from a new phone number, Press 9 </playtext>                                   
    </collectdtmf>
    <playtext>No response received so far</playtext>
 
</Response>";
        return answerxml;
    }



    private string optintobeCoachedTELold(string questiontotheuser)
    {
        string answerxml = $@"
<Response sid='{sessionid}' > 
    <playtext>Welcome to Mitra jyothi Audio Classes. </playtext>
    <playtext>You need just a telephone to avail this phone based coaching.</playtext>
    <playtext>Everyone can study.</playtext>
    <playtext>Do you want to register for free coaching? </playtext>
    <collectdtmf l='1' >     
        <playtext>Press 1 for yes. Press 0 for no.</playtext>                   
    </collectdtmf>
    <playtext>No response received so far</playtext>
    <playtext>You could try it for few days too. It is free of cost. Incase you want to opt out, you can unsubscribe on any day. We recommend you try it our coaching for few days. This will help your studies. Do you want to try out?</playtext> 
    <collectdtmf l='1' t='#' o='7000'> 
        <playtext> Press 1 to register for phone coaching plan. Press 2 to try for few days. Press 0 for no. </playtext>    
        <playtext>Waiting for you..</playtext>                   
    </collectdtmf>
        <playtext>Sorry no response. Please call us back. Wish you happy days ahead. Thank you for calling us.</playtext>                   
    <hangup></hangup>    
</Response>";
        return answerxml;
    }




    private string welcomeRegisteredSudentTELProccedQuizzing(long rollno, string lang)
    {
        //TODO: Based on student's lang, play the below in the prefered lang
        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext>Welcome again to Mitra jyothi Audio Classes.  Welcome back. Your roll number is {rollno}</playtext>
            <playtext>Shall we start coaching you now   </playtext>
            <gotourl>{StudentStatus.baseURL}JustCalledStartQuizzing.ashx?rollno={rollno}&amp;lang={lang}</gotourl>    
        </Response>";
        return answerxml;
    }



    private string addNewUsertoDB(string optin)
    {
        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext>We are happy for you. Thanks for choosing to {optin} </playtext>
            <playtext>Give us a few seconds to register you into the system database.</playtext>
             <gotourl>{StudentStatus.baseURL}adddnewuser.ashx?mode={optin}&amp;lang='EN-IN'</gotourl>    
        </Response>";
        return answerxml;
    }

    private string playsorrytext()
    {
        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext>You pressed 0. We are sorry to hear. We understand your situation. Please do call us any time back. Wish you a wonderful year ahead </playtext>
         <hangup></hangup>    
        </Response>";
        return answerxml;
    }

    private string askstudentforrollno()
    {
        string answerxml = $@"
        <Response sid='{sessionid}' > 
            <playtext>You pressed 9. Good to know you are already registered student with a roll number, but calling from a new phone</playtext>
            <gotourl>{StudentStatus.baseURL}asksrollnobutdifferentph.ashx</gotourl>    
        </Response>";
        return answerxml;
    }

    private string nodtmfresponse()
    {
        string answerxml = @"
<Response filler='yes'> 
    <playtext quality='best'>Sorry, we need to record again</playtext>  
</Response>";

        return answerxml;
    }

    private string dtmftimeresponse(string recordedurl, string callerid)
    {
        string answerxml = @"
<Response> 
    <playtext>How are you </playtext>"+
    "<playaudio>"+ recordedurl + "</playaudio>"   +
    "<playtext>thank you </playtext>"+
    "<hangup></hangup>"+
    "</Response>";

        return answerxml;
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}