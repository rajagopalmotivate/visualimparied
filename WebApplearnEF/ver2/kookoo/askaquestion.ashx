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
        string kookooevent = (string) context.Request.QueryString["event"];
        //   string QuestionNo = (string) context.Request.QueryString["QuestionNo"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        subject = (string) context.Request.QueryString["subject"];
        CoachingSession = (string) context.Request.QueryString["CoachingSession"];
        QuestionId = (string) context.Request.QueryString["QuestionId"];
        StudentClassStd  = (string) context.Request.QueryString["std"];



        string finalanswer = "";

        if (string.IsNullOrEmpty(kookooevent))
        {
            finalanswer = askthequestionVoiceorText(QuestionId);
        }
        else if (kookooevent.Equals("GotDTMF"))
        {
            string studentsAnswerChoice = (string)context.Request.QueryString["data"];
            if (string.IsNullOrEmpty(studentsAnswerChoice))
                finalanswer = askthequestionVoiceorText(QuestionId);
            else
                finalanswer = checktheanswer(QuestionId, studentsAnswerChoice);
        }
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }


    public string askthequestionVoiceorText(string QuestionNostring)
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        bool isUseText = true;

        if (myquestion.E1QuestionUseText != null)
            if (myquestion.E1QuestionUseText == false) isUseText = false;

        if (isUseText)
            return askthequestion(QuestionNostring);
        else
            return askthequestionVoice(QuestionNostring);

    }


    public string askthequestionVoice(string QuestionNostring)
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        string questionmp3URL = myquestion.E1QuestionAudio;
        string option1mp3URL = myquestion.E2Option1Audio;
        string option2mp3URL = myquestion.E3Option2Audio;
        string option3mp3URL = myquestion.E4Option3Audio;
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Here comes your Question. </playtext>
            <playaudio>{questionmp3URL}</playaudio>
          <collectdtmf l='1' o='15000'>     
             <playtext>Press 1 for </playtext>             
            <playaudio>{option1mp3URL}</playaudio>
             <playtext>Press 2 for </playtext>             
            <playaudio>{option2mp3URL}</playaudio>
             <playtext>Press 3 for </playtext>             
            <playaudio>{option3mp3URL}</playaudio>
            <playtext>Please answer now by pressing 1 or 2 or 3  </playtext>          
          </collectdtmf>
        </Response>";

        return xmlresponse;

    }


    public string askthequestion(string QuestionNostring)
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        string question = myquestion.E1QuestionText;
        string option1 = myquestion.E2Option1Text;
        string option2 = myquestion.E3Option2Text;
        string option3 = myquestion.E4Option3Text;

        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Here comes your Question. </playtext>
            <playtext>{question}</playtext>
          <collectdtmf l='1' o='15000'>     
             <playtext>Press 1 for </playtext>             
             <playtext>{option1} </playtext>                   
             <playtext>Press 2 for </playtext>             
             <playtext>{option2} </playtext>   
             <playtext>Press 3 for </playtext>             
             <playtext>{option3} </playtext> 
            <playtext>Please answer now by pressing 1 or 2 or 3  </playtext>          
          </collectdtmf>
        </Response>";

        return xmlresponse;
    }


    public string askthequestion(string QuestionNostring, string urlbased)
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        string question = myquestion.E1QuestionText;
        string option1 = myquestion.E2Option1Text;
        string option2 = myquestion.E3Option2Text;
        string option3 = myquestion.E4Option3Text;

        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Here comes your Question. </playtext>
            <playtext>{question}</playtext>
          <collectdtmf l='1' o='15000'>     
             <playtext>Press 1 for </playtext>             
             <playtext>{option1} </playtext>                   
             <playtext>Press 2 for </playtext>             
             <playtext>{option2} </playtext>   
             <playtext>Press 3 for </playtext>             
             <playtext>{option3} </playtext> 
            <playtext>Please answer now by pressing 1 or 2 or 3  </playtext>          
          </collectdtmf>
        </Response>";

        return xmlresponse;
    }


    public string checktheanswer(string QuestionNostring, string studentsAnswerChoice )
    {
        long QuestionNo = long.Parse(QuestionNostring);
        ListofQuestionsWithDetailsofEachQuestionTAB myquestion = StudentStatus.getQuestionDetails(QuestionNo);
        string rightanswers = myquestion.CorrectAnswers;
        char[] seperators = { ',' };
        string[] listofrightanswers = rightanswers.Split(seperators);
        System.Collections.ArrayList listofrightanswersint = new System.Collections.ArrayList(2);
        foreach (string answer in listofrightanswers) listofrightanswersint.Add( int.Parse(answer));
        int studentsAnswerChoiceint = int.Parse(studentsAnswerChoice);


        string reply = "";


        if ( listofrightanswersint.Contains(studentsAnswerChoiceint)  ) reply = "correct answer. Very good.";
        else  reply = "I am sorry.";

        string replycorrectchoices = "";
        foreach (int correctanswer in listofrightanswersint) replycorrectchoices = replycorrectchoices + " option " + correctanswer+ " ";
        reply = reply + " The correct answer is " + replycorrectchoices;

        string xmlresponse = "";


        if( myquestion.E1QuestionUseText == false)
        {
            string quizzsummary = myquestion.E6ResponsetoCorrectAnswerAudio;

            xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Checking your answer </playtext>
            <playtext>{reply}</playtext>
            <playaudio>{quizzsummary}</playaudio>
            <gotourl>{StudentStatus.baseURL}completedaQuestion.ashx?rollno={rollno}&amp;lang={lang}&amp;std={StudentClassStd}&amp;subject={subject}&amp;CoachingSession={CoachingSession}&amp;QuestionId={QuestionNostring}</gotourl>    
        </Response>";
        }
        else
        {
            xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext>Checking your answer </playtext>
            <playtext>{reply}</playtext>
            <gotourl>{StudentStatus.baseURL}completedaQuestion.ashx?rollno={rollno}&amp;lang={lang}&amp;std={StudentClassStd}&amp;subject={subject}&amp;CoachingSession={CoachingSession}&amp;QuestionId={QuestionNostring}</gotourl>    
        </Response>";
        }

        return xmlresponse;
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}