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
    string subject;
    string CoachingSession;
    string QuestionId;
    string StudentClassStd;


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        string kookooevent = (string) context.Request.QueryString["event"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        subject = (string) context.Request.QueryString["subject"];
        CoachingSession = (string) context.Request.QueryString["CoachingSession"];
        QuestionId = (string) context.Request.QueryString["QuestionId"];
        StudentClassStd  = (string) context.Request.QueryString["std"];



        string finalanswer = "";

        updateStudentLastCompletedQuestion(rollno, lang, subject, StudentClassStd ,  CoachingSession, QuestionId );
        finalanswer = getScore();


        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }

    public string getScore()
    {
        string xmlresponse = "";
        // Reward for completed 3 or 4 questions today. Track questions completed in a phone call
        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> { Motivational.getAlternatives("You have made good progress, You completed this Question")}  </playtext>
            <gotourl>{StudentStatus.baseURL}ContinueQuiz.ashx?rollno={rollno}&amp;lang={lang}&amp;subject={subject}</gotourl>       
        </Response>";

        return xmlresponse;
    }


    private void updateStudentLastCompletedQuestion(long rollno, string lang, string subject, string std,  string CoachingSession, string QuestionId )
    {
        StudentSubscriptionProgressionTAB studentprogress = StudentStatus.getStudentProgression(rollno);
        if( studentprogress == null )
        {
            //insert new row
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                StudentSubscriptionProgressionTAB mystudentsprogress = new StudentSubscriptionProgressionTAB();
                mystudentsprogress.StudentRollNo = rollno;
                mystudentsprogress.Lang = lang;
                mystudentsprogress.ClassStd = int.Parse(std);
                mystudentsprogress.Subject = subject;
                mystudentsprogress.CurrentPhCoachSessionNo = int.Parse(CoachingSession);
                mystudentsprogress.CurrentPhCoachSNoCurrentQuestionNo = long.Parse(QuestionId);
                StudentSubscriptionProgressionTAB studentprogressinseredrow = context.StudentSubscriptionProgressionTAB.Add(mystudentsprogress);
                context.SaveChanges();
            }

        }
        else
        {
            //update row
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                studentprogress.CurrentPhCoachSessionNo = int.Parse(CoachingSession);
                studentprogress.CurrentPhCoachSNoCurrentQuestionNo = long.Parse(QuestionId);
                context.Entry(studentprogress).State = System.Data.Entity.EntityState.Modified;
                int issuccesssavingrecord = context.SaveChanges();
            }
        }
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}