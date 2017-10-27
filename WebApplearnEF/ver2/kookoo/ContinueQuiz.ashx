<%@ WebHandler Language="C#" Class="JHandler" %>

using System;
using System.Web;
using System.Xml;
using System.IO;
using System.Data.Common;
using WebApplearnEF.ver2.kookoo;
using WebApplearnEF.ver2;
using System.Collections;

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



    long rollno;
    StudentTAB mystudent =null;
    string sessionid;

    int lastcompletedquestion = -1;
    int lastcompletedphonecoachingsession = -1;
    string lastcompletedsubject = "None";
    //  long nextQuestionID = -100;
    //   int nextPhoneCoachingSessionNo = -100;
    int StudentClassStd = -1;
    string StudentBoard = "CBSE";
    string StudentLangMedium = "en-IN";
    string lang;
    string subject;


    private XmlDocument GetXmlToShow(HttpContext context)
    {
        long callerphoneno =  long.Parse ((string) context.Request.QueryString["cid"]);
        callerphoneno = UtilitiesClasses.getPhonenumbersinConsistentFormat(callerphoneno);
        sessionid = (string) context.Request.QueryString["sid"];
        string kookooevent = (string) context.Request.QueryString["event"];
        rollno = long.Parse( (string) context.Request.QueryString["rollno"]);
        lang = (string) context.Request.QueryString["lang"];
        subject = (string) context.Request.QueryString["subject"];


        string finalanswer = "";

        getStudentsClassBoardDetails(rollno);
        if (mystudent == null) redirecttoUngresiteredStudent();
        if (!(mystudent.ClassStd >= 1)) redirecttocompleteStudentRegistration(rollno);


        StudentClassStd = (int) mystudent.ClassStd;

        //  getLastCompletedPhoneCoachingSessionQuestion(rollno);
        getLastCompletedPhoneCoachingSessionQuestion(rollno, StudentClassStd, lang, subject);

        bool isCompletedAllphonecoachingClassFortheYear = false;
        try {
            getNextCoachingNoandQuestionNo(rollno);
        }catch( InvalidDataException  ex)
        {
            isCompletedAllphonecoachingClassFortheYear = true;
        }

        if (isCompletedAllphonecoachingClassFortheYear == true)
        {
            finalanswer = VeryBIGCongratsForCompletingCourse();
        }
        else
        {
            finalanswer = startquizzing(lastcompletedquestion);
        }

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(finalanswer);
        return doc;
    }

    public string startquizzing(int lastcompletedquestion)
    {
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> Ready? You are now in coaching session number </playtext><say-as  format='501' lang='EN'>{nextphonecoachingsession}</say-as>
            <gotourl>{StudentStatus.baseURL}NextQuestion.ashx?rollno={rollno}&amp;lang={lang}&amp;subject={lastcompletedsubject}&amp;std={StudentClassStd}&amp;CoachingSession={nextphonecoachingsession}&amp;QuestionId={nextquestion}</gotourl>    
        </Response>";

        return xmlresponse;
    }

    private void getStudentsClassBoardDetails(long rollno)
    {
        StudentTAB studentdetails = StudentStatus.getStudenDetailsByRollNo(rollno);
        if (studentdetails == null) throw new InvalidDataException("EXCEPTION: Rollno not found in STUDENTTAB database ");
        else mystudent = studentdetails;
    }

    public string redirecttoUngresiteredStudent()
    {
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> We apologize, this phone number is NOT yet registered into this system. To register this phone number or anyone, please dial again after disconnecting. Thank you and bye </playtext>
            <hangup></hangup>
        </Response>";

        return xmlresponse;
    }

    public string redirecttocompleteStudentRegistration(long rollno)
    {
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> Your roll number is registered into the system. But you have to provide few more details to proceed. Please wait while we redirect </playtext>
            <gotourl>{StudentStatus.baseURL}CollectDetailsClass.ashx?rollno={rollno}</gotourl>    
        </Response>";

        return xmlresponse;
    }

    private bool getLastCompletedPhoneCoachingSessionQuestion(long rollno)
    {
        StudentSubscriptionProgressionTAB mystudentprogress = StudentStatus.getStudentProgression(rollno);
        if(mystudentprogress == null)
        {
            lastcompletedphonecoachingsession = 1;
            lastcompletedsubject = "MATH";
        }
        else
        {
            lastcompletedphonecoachingsession = (int) mystudentprogress.CurrentPhCoachSessionNo;

            lastcompletedquestion =  (int) mystudentprogress.CurrentPhCoachSNoCurrentQuestionNo;

            lastcompletedsubject = (string)mystudentprogress.Subject;
        }

        return true;
    }

    private bool getLastCompletedPhoneCoachingSessionQuestion(long rollno, int classstandard,  string lang, string subject)
    {
        StudentSubscriptionProgressionTAB mystudentprogress = StudentStatus.getStudentProgression(rollno, lang, subject, classstandard);
        if(mystudentprogress == null)
        {
            lastcompletedphonecoachingsession = 1;
            lastcompletedsubject = "MATH";
        }
        else
        {
            lastcompletedphonecoachingsession = (int) mystudentprogress.CurrentPhCoachSessionNo;

            lastcompletedquestion =  (int) mystudentprogress.CurrentPhCoachSNoCurrentQuestionNo;

            lastcompletedsubject = (string)mystudentprogress.Subject;
        }

        return true;
    }

    private ArrayList getlistofquestionsinACoachingSession(int phonecoachingsession)
    {
        string XMLListofQuestions = "";
        PhoneCoachingPlanListofSessionsTAB CoachingSessionObject=   StudentStatus.getListofQuestionsDuringthisDay(phonecoachingsession, 5, "CBSE", "en-IN", "MATH");
        if (CoachingSessionObject != null)
            XMLListofQuestions = CoachingSessionObject.ListofQuestionsXML;
        else
        {
            throw new InvalidDataException ("YOU HAVE COMPLETED ALL THE PHONE COACHING SESSIONS");
            return null;
        }
        ArrayList listofquestionsinthephonesession = parsetogetListofQuestions(XMLListofQuestions);
        return listofquestionsinthephonesession;
    }

    int nextquestion = -1;
    int nextphonecoachingsession = -1;

    private void getNextCoachingNoandQuestionNo(long rollno)
    {
        //Test data 
        //    lastcompletedphonecoachingsession = 4   ;
        //    lastcompletedquestion = 6  ;


        nextquestion = -1;
        nextphonecoachingsession = -1;
        bool isStartWithFIRSTQuestionofTheCoachingSession = false;

        ArrayList listofquestionsinthephonesession = getlistofquestionsinACoachingSession(lastcompletedphonecoachingsession);

        //incase of [ListofQuestionsXML] is blank, move to the next day [PhCoachSessionNo]
        while(listofquestionsinthephonesession == null)
        {
            lastcompletedphonecoachingsession++;
            listofquestionsinthephonesession = getlistofquestionsinACoachingSession(lastcompletedphonecoachingsession);
            isStartWithFIRSTQuestionofTheCoachingSession = true;
        }

        if(isStartWithFIRSTQuestionofTheCoachingSession==true)
        {
            nextphonecoachingsession = lastcompletedphonecoachingsession;
            // listofquestionsinthephonesession.Count == 0 is not likely to exist as getlistofquestionsinACoachingSession return null 
            if (listofquestionsinthephonesession.Count >= 1) nextquestion = (int) listofquestionsinthephonesession[0];
            return;
        }

        //
        if(isStartWithFIRSTQuestionofTheCoachingSession == false)
            if ( listofquestionsinthephonesession.Contains( (int) lastcompletedquestion) )
            {
                int indexof = listofquestionsinthephonesession.LastIndexOf( (int) lastcompletedquestion);
                bool iscompletedallquestionsinthelist = false;
                if ((indexof + 1) < listofquestionsinthephonesession.Count)
                {
                    iscompletedallquestionsinthelist = false;
                    nextphonecoachingsession = lastcompletedphonecoachingsession;
                    nextquestion = (int) listofquestionsinthephonesession[indexof + 1];
                    return;
                }
                else
                {
                    iscompletedallquestionsinthelist = true;
                    //get the next avialable coaching session and choose its first element 
                    lastcompletedphonecoachingsession++;
                    lastcompletedquestion = -1;

                    getNextDay();
                    return;
                }
                return;
            }
            else
            { // Just go to the next day
                getNextDay();
            }
    }


    //Assigns nextphonecoachingsession and nextquestion by looking at next avialale 
    private void getNextDay()
    {
        ArrayList listofquestionsinthephonesessionNEXT1 = getlistofquestionsinACoachingSession(lastcompletedphonecoachingsession);
        while (listofquestionsinthephonesessionNEXT1 == null)
        {
            lastcompletedphonecoachingsession++;
            listofquestionsinthephonesessionNEXT1 = getlistofquestionsinACoachingSession(lastcompletedphonecoachingsession);
        }
        nextphonecoachingsession = lastcompletedphonecoachingsession;

        if (listofquestionsinthephonesessionNEXT1.Count >= 1)
            nextquestion = (int) listofquestionsinthephonesessionNEXT1[0];
    }


    // returns a array of QuestionIDs in the string 
    // incase of 0 elements, returns null
    private ArrayList parsetogetListofQuestions(string XMLListofQuestions)
    {
        if (XMLListofQuestions == null)
            return null;

        char[] seperator = { ',' };
        string[] arrayofquestionnos = XMLListofQuestions.Split(seperator);
        //int[] intarrayofquestionnos = new int[30];

        if (arrayofquestionnos == null)
        {
            // intarrayofquestionnos = null;
            return null;
        }

        if (arrayofquestionnos.Length == 0)
        {
            // intarrayofquestionnos = null;
            return null;
        }

        ArrayList mylistofquestion = new ArrayList();

        for (int i = 0; i < arrayofquestionnos.Length; i++)
        {

            mylistofquestion.Add(int.Parse(arrayofquestionnos[i]));

        }

        return mylistofquestion;
    }

    public string VeryBIGCongratsForCompletingCourse()
    {
        // Student has completed all the subject.  Need a way to register for the next class.
        string xmlresponse = "";

        xmlresponse = $@"
        <Response sid='{sessionid}' > 
            <playtext> Very Hearty CONGRATULATIONS. YOU HAVE COMPLETED ALL THE PHONE COACHING SESSIONS in this subject. </playtext>
            <playtext> You have made fanastic progress in this subject. If you wish to learn for the next subject, please dail again.  Thank you.  Good bye</playtext>
            <hangup></hangup>
        </Response>";

        return xmlresponse;
    }

    private void updateStudentLastCompletedQuestion(long callerphoneno, string completedquestion)
    {

    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}