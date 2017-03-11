
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
        //GetXmlToShow will look for parameters from the context
        XmlDocument doc = GetXmlToShow(context);

        //Don't forget to set a valid xml type.
        //If you leave the default "text/html", the browser will refuse to display it correctly
        context.Response.ContentType = "text/xml";

        //We'd like UTF-8.
        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        //context.Response.ContentEncoding = System.Text.Encoding.UnicodeEncoding; //But no reason you couldn't use UTF-16:
        //context.Response.ContentEncoding = System.Text.Encoding.UTF32; //Or UTF-32
        //context.Response.ContentEncoding = new System.Text.Encoding(500); //Or EBCDIC (500 is the code page for IBM EBCDIC International)
        //context.Response.ContentEncoding = System.Text.Encoding.ASCII; //Or ASCII
        //context.Response.ContentEncoding = new System.Text.Encoding(28591); //Or ISO8859-1
        //context.Response.ContentEncoding = new System.Text.Encoding(1252); //Or Windows-1252 (a version of ISO8859-1, but with 18 useful characters where they were empty spaces)

        //Tell the client don't cache it (it's too volatile)
        //Commenting out NoCache allows the browser to cache the results (so they can view the XML source)
        //But leaves the possiblity that the browser might not request a fresh copy
        //context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        //And now we tell the browser that it expires immediately, and the cached copy you have should be refreshed
        context.Response.Expires = -1;

        context.Response.Cache.SetAllowResponseInBrowserHistory(true); //"works around an Internet&nbsp;Explorer bug"

        doc.Save(context.Response.Output); //doc saves itself to the textwriter, using the encoding of the text-writer (which comes from response.contentEncoding)

        #region Notes
        /*
         * 1. Use Response.Output, and NOT Response.OutputStream.
         *  Both are streams, but Output is a TextWriter.
         *  When an XmlDocument saves itself to a TextWriter, it will use the encoding
         *  specified by the TextWriter. The XmlDocument will automatically change any
         *  XML declaration node, i.e.:
         *     <?xml version="1.0" encoding="ISO-8859-1"?>
         *  to match the encoding used by the Response.Output's encoding setting
         * 2. The Response.Output TextWriter's encoding settings comes from the
         *  Response.ContentEncoding value.
         * 3. Use doc.Save, not Response.Write(doc.ToString()) or Response.Write(doc.InnerXml)
         * 3. You DON'T want to save the XML to a string, or stuff the XML into a string
         *  and response.Write that, because that
         *   - doesn't follow the encoding specified
         *   - wastes memory
         *
         * To sum up: by Saving to a TextWriter: the XML Declaration node, the XML contents,
         * and the HTML Response content-encoding will all match.
         */
        #endregion Notes
    }


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        //Use context.Request to get the account number they want to return
        //GET /GetPatronInformation.ashx?accountNumber=619

        string callerid =  (string) context.Request.QueryString["From"];
        string sessionid = (string) context.Request.QueryString["CallSid"];
        string googleid = (string) context.Request.QueryString["googleid"];

        string kookooevent = "completed"; // (string) context.Request.QueryString["RecordingStatus"];

        string finalanswer = "";


        string urlofrecordedfile = (string)context.Request.QueryString["RecordingUrl"];

        finalanswer = dtmftimeresponse(context, googleid,  callerid, sessionid);

        //Or since this is sample code, pull XML out of your rear:
        XmlDocument doc = new XmlDocument();
        //  doc.LoadXml("<Patron><Name>Glory to Jesus...i cant do this, only Jesus can help me</Name></Patron>");

        doc.LoadXml(finalanswer);
        return doc;
    }


    private string firsttimeresponse()
    {
        string answerxml = @"
<Response> 
    <Say>Glory to Jesus.</Say>  
    <Say> Hello, How are you  </Say>
    <Record  maxLenght='30' action='JhandlerTwilioRecord.ashx' ></Record>    
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

    private string fetchResponsebasedonnTranscribedText(string uniquegooglecallidentifier)
    {
        string transribedtext = transcribeAsyncGetTranscribedText(uniquegooglecallidentifier);
        string answerxml = @"
               <Response> 
                    <Say>You said</Say>"+
                    "<Say>"+ transribedtext +"</Say>"+
                     "<Say>Thank you my LORD Jesus, Made possible only due to JESUS's grace </Say>"+
               "</Response>";
        return answerxml;
    }

    private string dtmftimeresponse(HttpContext context, string googleid, string callerid, string phonesessionid)
    {
        string uniquegooglecallidentifier = "";
        string answerxml = "";

        if(context.Application[phonesessionid] !=null)
            uniquegooglecallidentifier =  (string)context.Application[phonesessionid];



        if(uniquegooglecallidentifier.Length > 0)
        {
            bool isReady = transcribeAsyncisReady(uniquegooglecallidentifier);
            if (isReady == true)
            {
                answerxml = fetchResponsebasedonnTranscribedText(uniquegooglecallidentifier);
            }
            else
            {
                string redirecturl = @"GetTranscribedText.ashx?googleid=" + uniquegooglecallidentifier;

                answerxml = @"
               <Response> 
                    <Play>http://learnthink.azurewebsites.net/optimized/Alarm06.wav</Play>
                    <Say>music transcribing</Say>" +
                    "<Redirect method='GET'>" + redirecturl + "</Redirect>"+
               "</Response>";
            }
        }
        else
        {

               string redirecturl = @"GetTranscribedText.ashx?googleid=" ; 

                answerxml = @"
               <Response> 
                    <Say>music waiting for unique google id </Say>" +
                    "<Redirect method='GET'>" + redirecturl + "</Redirect>"+
               "</Response>";
        }



        return answerxml;
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}