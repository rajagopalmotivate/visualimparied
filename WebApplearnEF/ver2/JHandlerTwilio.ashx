<%@ WebHandler Language="C#" Class="JHandler" %>

using System;
using System.Web;
using System.Xml;
using System.IO;
using System.Data.Common;

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


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        //Use context.Request to get the account number they want to return
        //GET /GetPatronInformation.ashx?accountNumber=619

        string callerid =  (string) context.Request.QueryString["From"];
        string sessionid = (string) context.Request.QueryString["CallSid"];
        string kookooevent = "";// (string) context.Request.QueryString["event"];


        string finalanswer = "";

        if (kookooevent.Contains("Record"))
        {
            string urlofrecordedfile =  (string) context.Request.QueryString["data"];

            if (urlofrecordedfile.Length == 0)
            {
                finalanswer = nodtmfresponse();
            }
            else
            {
                finalanswer = dtmftimeresponse(urlofrecordedfile, callerid);
            }

        }
        else
        {
            
            string questiontotheuser =  User.BOTGetQuestiontoUser (callerid);
            finalanswer = firsttimeresponse(questiontotheuser);
        }



        //Or since this is sample code, pull XML out of your rear:
        XmlDocument doc = new XmlDocument();
        //  doc.LoadXml("<Patron><Name>Glory to Jesus...i cant do this, only Jesus can help me</Name></Patron>");

        doc.LoadXml(finalanswer);
        return doc;
    }


    private string firsttimeresponse(string questiontotheuser)
    {
        string answerxml = @"
<Response> 
    <Say>"  + questiontotheuser +  
    @"</Say>
    <Record  maxLength='12' finishOnKey='*' action='RecordAsync.ashx'  method='GET' />  
    <Say>I didnot receive any recording</Say>"+
"</Response>";

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