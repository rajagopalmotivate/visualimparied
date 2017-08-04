using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class StudentStatus
    {
        public static string  baseURL = @"http://webapplearnef20170718064606.azurewebsites.net/ver2/kookoo/";

        public static StudentTAB getStudentbyAssociatedPhoneNo( long callerPhoneNo )
        {
            StudentTAB mystudent ;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetastudentrecord = from astudent in context.StudentTAB
                            where astudent.AssociatedPhoneNo   == callerPhoneNo
                            select astudent;

                mystudent =  querytogetastudentrecord.FirstOrDefault();
            }
            return mystudent;
        }



        public static StudentTAB getStudenDetailsByRollNo(long rollno)
        {
            StudentTAB mystudent;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetastudentrecord = from astudent in context.StudentTAB
                                               where astudent.StudentRollNo  == rollno
                                               select astudent;

                mystudent = querytogetastudentrecord.FirstOrDefault();
            }
            return mystudent;
        }


        public static bool updateDBaboutLastCompletedQuestion(string sid, long callerPhoneNo, long QuestionNO)
        {

            return true; 
        }


        public static bool updateDBaboutLastCompletedQuestion(long rollno, long QuestionNO)
        {

            return true;
        }



        public static StudentSubscriptionProgressionTAB getStudentProgression(long studentRollno)
        {
            StudentSubscriptionProgressionTAB  mystudentprogression;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetastudentrecord = from astudent in context.StudentSubscriptionProgressionTAB
                                               where astudent.StudentRollNo  == studentRollno
                                               select astudent;

                mystudentprogression = querytogetastudentrecord.FirstOrDefault();
            }
            return mystudentprogression;
        }

        public static StudentSubscriptionProgressionTAB getStudentProgression(long studentRollno, string lang , string subject, int classStandard) 
        {
            StudentSubscriptionProgressionTAB mystudentprogression;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetastudentrecord = from astudent in context.StudentSubscriptionProgressionTAB
                                               where ((astudent.StudentRollNo == studentRollno) && ( astudent.Lang == lang ) && ( astudent.Subject == subject ) && (astudent.ClassStd == classStandard) )
                                               select astudent;

                mystudentprogression = querytogetastudentrecord.FirstOrDefault();
            }
            return mystudentprogression;
        }


        public static ListofQuestionsWithDetailsofEachQuestionTAB getQuestionDetails(long QuestionNO)
        {
            ListofQuestionsWithDetailsofEachQuestionTAB myquestion; 

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetaquestionrecord = from aquestion in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                               where aquestion.QuestionNo == QuestionNO
                                               select aquestion;

                myquestion = querytogetaquestionrecord.FirstOrDefault();
            }
            return myquestion;
        }


        public static PhoneCoachingPlanListofSessionsTAB getListofQuestionsDuringthisDay(int PhCoachSessionNo, int ClassStd, string Board, string Lang, string Subject)
        {
            PhoneCoachingPlanListofSessionsTAB myListofQuestionsDuringthisDay;

            bool isinputvalid = true;
            if (!((ClassStd > 0) && (ClassStd <= 12))) isinputvalid = false;
            if (!((Lang.Equals("EN-IN")) || (Lang.Equals("HI-IN")))) isinputvalid = false;
            if (!((Board.Equals("CBSE")) || (Board.Equals("CBSE")))) isinputvalid = false;
            if (!((Subject.Equals("MATH")) || (Subject.Equals("SCIENCE")))) isinputvalid = false;
            if (isinputvalid == false) { throw new FormatException("invalid input"); }

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetListofQuestionsOnaDay = from arow in context.PhoneCoachingPlanListofSessionsTAB
                                                      where arow.Board == Board && arow.ClassStd == ClassStd && arow.Lang == Lang && arow.Subject == Subject && arow.PhCoachSessionNo == PhCoachSessionNo
                                                      select arow;

                myListofQuestionsDuringthisDay = querytogetListofQuestionsOnaDay.FirstOrDefault();
            }
            return myListofQuestionsDuringthisDay;
        }


       

    }
}
