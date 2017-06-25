using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class AddQuestiontoPhoneId : System.Web.UI.Page
    {
        int PhLessonID = -99999;
        int QuestionID = -99999;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack == false)
            {
                PhLessonID = getPhLessonID();
                QuestionID = getQuestionID();

            }else
            {
                PhLessonID = int.Parse(this.LabelPhoneID.Text);
                QuestionID = int.Parse(this.LabelQuestionNO.Text);
            }

                this.LabelPhoneID.Text = PhLessonID + "";
                this.LabelQuestionNO.Text = QuestionID + "";

                this.LabelDisplay.Text = "You have selected a question to be added to the Phone coaching session. The Question No is " + QuestionID + " , And Phone Coaching ID is " + PhLessonID;
            
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

        private int getQuestionID()
        {
            int ans = -99;

            string userid = Request.QueryString["QuestionNo"];
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

        protected void ButtonConfirmAddition_Click(object sender, EventArgs e)
        {
            using (var context = new learnthinksavedbEntities29Jan2016() )
            {
                var coachingsession = from a in context.PhoneCoachingPlanListofSessionsTAB
                                      where a.PhLessonID == PhLessonID
                                      select a;
                PhoneCoachingPlanListofSessionsTAB mycoachingsession = coachingsession.FirstOrDefault();
                string listofquestions =  mycoachingsession.ListofQuestionsXML;

                if(listofquestions == null )
                {
                    listofquestions = QuestionID.ToString();
                }
                else
                {
                    if (listofquestions.Length > 0)
                        listofquestions = listofquestions + "," + QuestionID;
                    else
                        listofquestions = QuestionID.ToString();
                }          




                mycoachingsession.ListofQuestionsXML = listofquestions;

                context.Entry(mycoachingsession).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges(); 
            }
            this.LabelDisplaySaved.Text = "Saved";
            Response.Redirect("WhatisInaPhoneCoachingSession.aspx?PhLessonID=" + PhLessonID); 
        }
    }
}