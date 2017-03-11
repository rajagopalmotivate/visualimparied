<%@ WebHandler Language="C#" Class="JHandler" %>

using System;
using System.Web;
using System.Xml;
using System.IO;
using System.Data.Common;
using System.Threading.Tasks;

//SID
//SK4c5bbb44d17f0460cd166e5dc1b9b4b7
//SECRET
//UMzZFx9PvmSeRQUDCCrL5CdC0TYSSvib


public class JHandler : IHttpHandler
{

    public  void ProcessRequest (HttpContext context)
    {
        httpContext = context;
        XmlDocument doc = GetXmlToShow(context);
        context.Response.ContentType = "text/xml";
        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        context.Response.Expires = -1;
       // context.Response.Cache.SetAllowResponseInBrowserHistory(true);
        context.Response.BufferOutput = false;
        doc.Save(context.Response.Output);
        context.Response.Flush();

      //  saveRecordedWavFileinDatabase(urlofrecordedfile, sessionid);
//        StartTranscribingAsync(urlofrecordedfile);

    }

    private  void StartTranscribingAsync(string urlofrecordedfile)
    {
           string uniquegooglecallidentifier = transcribeAsyncStartTranscibing(urlofrecordedfile);
           httpContext.Application[sessionid] = uniquegooglecallidentifier;
        

    }



    string sessionid;
    string urlofrecordedfile;
    HttpContext httpContext;

    //primary action is saveRecordedWavFile()
    private XmlDocument GetXmlToShow(HttpContext context)
    {
        string callerid =  (string) context.Request.QueryString["From"];
        sessionid = (string) context.Request.QueryString["CallSid"];
        string kookooevent = "completed"; // (string) context.Request.QueryString["RecordingStatus"];
        string finalanswer = "";
        if (kookooevent.Contains("completed"))
        {
            urlofrecordedfile =  (string) context.Request.QueryString["RecordingUrl"];
            if (urlofrecordedfile.Length == 0)
            {
                finalanswer = nodtmfresponse();
            }
            else
            {
                finalanswer = saveRecordedWavFile(context, urlofrecordedfile, callerid, sessionid);
            }
        }
        else
        {
            finalanswer = errorresponse();
        }



        //Or since this is sample code, pull XML out of your rear:
        XmlDocument doc = new XmlDocument();
        //  doc.LoadXml("<Patron><Name>Glory to Jesus...i cant do this, only Jesus can help me</Name></Patron>");

        doc.LoadXml(finalanswer);
        return doc;
    }


    private string errorresponse()
    {
        string answerxml = @"
<Response> 
    <Say>Glory to Jesus.</Say>  
    <Say> Reached here without recording</Say>
    <Say>Thank you</Say>"+
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

    private string transcribe(string recordedurl)
    {
        string ans = GoogleTranscribe.mainCalltoSpeech(recordedurl);
        return ans;
    }

    private string transcribeAsync(string recordedurl)
    {
        GoogleTranscribeAsync myGoogleTransciber = new GoogleTranscribeAsync();
        myGoogleTransciber.CreateSingleton();
        string uniquegooglecallidentifier = myGoogleTransciber.MainTranscribe(recordedurl);

        while( ! myGoogleTransciber.isAnswerReady(uniquegooglecallidentifier))
        {
            System.Threading.Thread.Sleep(500);
        }

       
        string ans = myGoogleTransciber.getTransicbedAnswer(uniquegooglecallidentifier);
        return ans;
    }

    private string transcribeAsyncStartTranscibing(string recordedurl)
    {
        GoogleTranscribeAsync myGoogleTransciber = new GoogleTranscribeAsync();
        myGoogleTransciber.CreateSingleton();
        string uniquegooglecallidentifier = myGoogleTransciber.MainTranscribe(recordedurl);
        return uniquegooglecallidentifier;
    }



    private bool transcribeAsyncisReady(string uniquegooglecallidentifier)
    {
        GoogleTranscribeAsync myGoogleTransciber = new GoogleTranscribeAsync();
        myGoogleTransciber.CreateSingleton();
        bool ans = myGoogleTransciber.isAnswerReady(uniquegooglecallidentifier);
        return ans;
    }

    private string transcribeAsyncGetTranscribedText(string uniquegooglecallidentifier)
    {
        GoogleTranscribeAsync myGoogleTransciber = new GoogleTranscribeAsync();
        myGoogleTransciber.CreateSingleton();
        string ans = myGoogleTransciber.getTransicbedAnswer(uniquegooglecallidentifier);
        return ans;
    }

    private string saveRecordedWavFile(HttpContext context, string recordedurl, string callerid, string phonesessionid)
    {


        string redirecturl = @"StartTranscribing.ashx?RecordedAudioURL=" + recordedurl;

        string answerxml = @"
<Response>"   +
    "<Say> Please wait. Just waiting long.. </Say>" +
    "<Redirect method='GET'>" + redirecturl + "</Redirect>"+
"</Response>";

        return answerxml;
    }

    private void saveRecordedWavFileinDatabase(string url, string sessionid)
    {
        //copy to gs bucket and save in db
        httpContext.Application[sessionid + "RECORDEDURL"] = url;
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}