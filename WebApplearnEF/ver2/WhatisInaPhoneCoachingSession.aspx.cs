using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class WhatisInaPhoneCoachingSession : System.Web.UI.Page
    {
        int PhLessonID = -1;
        PhoneCoachingPlanListofSessionsTAB coachingsession;
        string XMLListofQuestions = "";



        //PhLessonID=4
        protected void Page_Load(object sender, EventArgs e)
        {
            PhLessonID = getPhLessonID();

            coachingsession =  populateDetailsofCoachingSession(PhLessonID);
            XMLListofQuestions = coachingsession.ListofQuestionsXML;

            displayDetailsofCoachingSession();

            processListofQuestions();

            DisplayGetData();

            populatehyperlinks();
        }

        private void populatehyperlinks()
        {
            this.HyperLinkAddAnotherQuestion.NavigateUrl = "AddQuestionToPhoneCall.aspx?PhLessonID=" + PhLessonID;
            this.HyperLinkChangeSequenceofQuestionsForaPhCoachingSession.NavigateUrl = "ChangeQuestionSequenceInPhoneCoachingSession.aspx?PhLessonID=" + PhLessonID;
        }

        private PhoneCoachingPlanListofSessionsTAB populateDetailsofCoachingSession(int PhLessonID)
        {
            PhoneCoachingPlanListofSessionsTAB ans = null; 
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var coachingsession = from a in context.PhoneCoachingPlanListofSessionsTAB
                                      where a.PhLessonID == PhLessonID
                                      select a;
                ans =  coachingsession.FirstOrDefault(); 
            }
            return ans; 
        }

        private int getPhLessonID()
        {
            int ans = -99;

            string userid = Request.QueryString["PhLessonID"];
            if (userid == null) Response.Redirect("ViewCoachingSessionByClass.aspx.aspx");
            userid = userid.Trim();

            try
            {
                ans = int.Parse(userid);
            }
            catch (Exception ex)
            {
                Response.Redirect("ViewCoachingSessionByClass.aspx");
            }

            return ans; 
        }


        private void displayDetailsofCoachingSession()
        {
            this.LabelDisplayPhLessonID.Text = "" + coachingsession.PhLessonID; 
           this.LabelDisplay.Text =  coachingsession.Board + ", Std " + coachingsession.ClassStd + ", Coaching session " + coachingsession.Subject + " " + coachingsession.PhCoachSessionNo;
           this.LabelDiplay2.Text = " List of questions covered in this phone call : " + XMLListofQuestions;
        }


        string[] arrayofquestionnos;
        int[] intarrayofquestionnos = new int[30]; 



        private void processListofQuestions()
        {
            if (XMLListofQuestions == null)
            {
                intarrayofquestionnos = null;
                this.HyperLink2.Text = "No questions have been addded so far.";

                return;
            }

            char[] seperator = { ',' };
            arrayofquestionnos = XMLListofQuestions.Split(seperator);

            if (arrayofquestionnos == null)
            {
                intarrayofquestionnos = null;
                this.HyperLink2.Text = "No questions have been addded so far.";
                return; 
            }

            if (arrayofquestionnos.Length == 0)
            {
                intarrayofquestionnos = null;
                this.HyperLink2.Text = "No questions have been addded so far.";
                return;
            }

            for (int i = 0; i < intarrayofquestionnos.Length; i++)
            {
                int j = -1;

                if (i < arrayofquestionnos.Length) j = i; else j = 0;

                if (arrayofquestionnos[j].Length == 0)
                    intarrayofquestionnos[i] = 0; 
                else
                    intarrayofquestionnos[i] = int.Parse(arrayofquestionnos[j]); 
            }



            for (int i = 0; i < intarrayofquestionnos.Length; i++)
            {
                this.TextBox1.Text += intarrayofquestionnos[i] + ", ";
            }


        }

        public void DisplayGetData2()
        {
            if (intarrayofquestionnos == null) return;

            var context = new learnthinksavedbEntities29Jan2016();

            System.Collections.ArrayList myarraylist = new System.Collections.ArrayList();
            for (int i = 0; i < intarrayofquestionnos.Length; i++)
            {
                myarraylist.Add(intarrayofquestionnos[i]); 
            }


            var listofquestionsTAB = from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                     orderby listofquestions.Lang, listofquestions.QuestionType, listofquestions.QuestionNo
                                     where myarraylist.Contains (listofquestions.QuestionNo) 
                                     select listofquestions;

            GridView1.DataSource = listofquestionsTAB.ToList();

            
            this.TextBox1.Text += System.Environment.NewLine + "Count " + listofquestionsTAB.ToList().Count;

            GridView1.DataBind();

        }


        public void DisplayGetData()
        {
            if (intarrayofquestionnos == null) return; 

            var context = new learnthinksavedbEntities29Jan2016();

            int x0 = intarrayofquestionnos[0];
            int x1 = intarrayofquestionnos[1];
            int x2 = intarrayofquestionnos[2];
            int x3 = intarrayofquestionnos[3];
            int x4 = intarrayofquestionnos[4];
            int x5 = intarrayofquestionnos[5];
            int x6 = intarrayofquestionnos[6];
            int x7 = intarrayofquestionnos[7];
            int x8 = intarrayofquestionnos[8];
            int x9 = intarrayofquestionnos[9];
            int x10 = intarrayofquestionnos[10];
            int x11 = intarrayofquestionnos[11];
            int x12 = intarrayofquestionnos[12];
            int x13 = intarrayofquestionnos[13];
            int x14 = intarrayofquestionnos[14];
            int x15 = intarrayofquestionnos[15];
            int x16 = intarrayofquestionnos[16];
            int x17 = intarrayofquestionnos[17];
            int x18 = intarrayofquestionnos[18];
            int x19 = intarrayofquestionnos[19];
            int x20 = intarrayofquestionnos[20];
            int x21 = intarrayofquestionnos[21];
            int x22 = intarrayofquestionnos[22];
            int x23 = intarrayofquestionnos[23];
            int x24 = intarrayofquestionnos[24];
            int x25 = intarrayofquestionnos[25];
            int x26 = intarrayofquestionnos[26];
            int x27 = intarrayofquestionnos[27];
            int x28 = intarrayofquestionnos[28];
            int x29 = intarrayofquestionnos[29];



            var listofquestionsTAB = from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                     orderby listofquestions.Lang, listofquestions.QuestionType, listofquestions.QuestionNo
                                     where (listofquestions.QuestionNo == x0 || listofquestions.QuestionNo == x1
                                     || listofquestions.QuestionNo == x2 || listofquestions.QuestionNo == x3
                                     || listofquestions.QuestionNo == x4 || listofquestions.QuestionNo == x5
                                     || listofquestions.QuestionNo == x6 || listofquestions.QuestionNo == x7
                                     || listofquestions.QuestionNo == x8 || listofquestions.QuestionNo == x9
                                     || listofquestions.QuestionNo == x10 || listofquestions.QuestionNo == x11
                                     || listofquestions.QuestionNo == x12 || listofquestions.QuestionNo == x13
                                     || listofquestions.QuestionNo == x14 || listofquestions.QuestionNo == x15
                                     || listofquestions.QuestionNo == x16 || listofquestions.QuestionNo == x17
                                     || listofquestions.QuestionNo == x18 || listofquestions.QuestionNo == x19
                                     || listofquestions.QuestionNo == x20 || listofquestions.QuestionNo == x21
                                     || listofquestions.QuestionNo == x22 || listofquestions.QuestionNo == x23
                                     || listofquestions.QuestionNo == x24 || listofquestions.QuestionNo == x25
                                     || listofquestions.QuestionNo == x26 || listofquestions.QuestionNo == x27
                                     || listofquestions.QuestionNo == x28 || listofquestions.QuestionNo == x29
                                     )
                                     select listofquestions;


            var mylist = listofquestionsTAB.ToList();


            var oneitem = mylist.Where(x => x.QuestionNo == intarrayofquestionnos[0]);

            var mysequncedlist = oneitem.ToList();

            for (int i = 1; i < arrayofquestionnos.Length; i++)
            {
                var oneitem3 = mylist.Where(x => x.QuestionNo == intarrayofquestionnos[i]);
                mysequncedlist.AddRange(oneitem3);
            }

            //   GridView1.DataSource = listofquestionsTAB.ToList();
            GridView1.DataSource = mysequncedlist; 


            this.TextBox1.Text += System.Environment.NewLine + "Count " + listofquestionsTAB.ToList().Count  ;

            GridView1.DataBind();

        }



        public IQueryable<ListofQuestionsWithDetailsofEachQuestionTAB> GridView1_GetData()
        {

            var context = new learnthinksavedbEntities29Jan2016();

            int x0 = intarrayofquestionnos[0];
            int x1 = intarrayofquestionnos[1];


            var listofquestionsTAB = from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                     orderby listofquestions.Lang, listofquestions.QuestionType, listofquestions.QuestionNo
                                     where (listofquestions.QuestionNo == x0 || listofquestions.QuestionNo == x1)
                                     select listofquestions;

            return listofquestionsTAB;


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
     //       DisplayGetData();

        }

        protected void ButtonAddNewQuestionTocall_Click(object sender, EventArgs e)
        {
            string PhLessonID = this.LabelDisplayPhLessonID.Text;
            Response.Redirect("AddQuestionToPhoneCall.aspx?PhLessonID=" + PhLessonID);
        }



        /*    public IQueryable<ListofQuestionsWithDetailsofEachQuestionTAB> GridView1_GetData()
            {

                var context = new learnthinksavedbEntities29Jan2016();

                var listofquestionsTAB = from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                         orderby listofquestions.Lang, listofquestions.QuestionType, listofquestions.QuestionNo
                                         where (listofquestions.QuestionNo == intarrayofquestionnos[0] || listofquestions.QuestionNo == intarrayofquestionnos[1]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[2] || listofquestions.QuestionNo == intarrayofquestionnos[3]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[4] || listofquestions.QuestionNo == intarrayofquestionnos[5]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[6] || listofquestions.QuestionNo == intarrayofquestionnos[7]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[8] || listofquestions.QuestionNo == intarrayofquestionnos[9]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[10] || listofquestions.QuestionNo == intarrayofquestionnos[11]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[12] || listofquestions.QuestionNo == intarrayofquestionnos[13]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[14] || listofquestions.QuestionNo == intarrayofquestionnos[15]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[16] || listofquestions.QuestionNo == intarrayofquestionnos[17]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[18] || listofquestions.QuestionNo == intarrayofquestionnos[19]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[20] || listofquestions.QuestionNo == intarrayofquestionnos[21]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[22] || listofquestions.QuestionNo == intarrayofquestionnos[23]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[24] || listofquestions.QuestionNo == intarrayofquestionnos[25]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[26] || listofquestions.QuestionNo == intarrayofquestionnos[27]
                                         || listofquestions.QuestionNo == intarrayofquestionnos[28] || listofquestions.QuestionNo == intarrayofquestionnos[29]       
                                         )
                                         select listofquestions;

                return listofquestionsTAB; 


            }*/

    }
}