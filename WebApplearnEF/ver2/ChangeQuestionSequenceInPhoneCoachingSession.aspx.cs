using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class ChangeQuestionSequenceInPhoneCoachingSession : System.Web.UI.Page
    {
        int PhLessonID = -99999;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack == false)
            {
                PhLessonID = getPhLessonID();
                this.LabelPhoneID.Text = PhLessonID + "";
                PhoneCoachingPlanListofSessionsTAB acoachingsession = populateQuestionSequence();
                string XMLlistofQuestions = acoachingsession.ListofQuestionsXML;
                this.LabelQuestions.Text = XMLlistofQuestions;
                this.TextBoxXMLeditedbyuser.Text = XMLlistofQuestions;
            }
            else
            {
                PhLessonID = int.Parse(this.LabelPhoneID.Text);
            }


       

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

        private PhoneCoachingPlanListofSessionsTAB populateQuestionSequence()
        {
            PhoneCoachingPlanListofSessionsTAB ans = null;
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var coachingsession = from a in context.PhoneCoachingPlanListofSessionsTAB
                                      where a.PhLessonID == PhLessonID
                                      select a;
                ans = coachingsession.FirstOrDefault();
            }
            return ans;
        }

        private void updateRecord()
        {
            string  XMLlistofQuestionsEdited = this.TextBoxXMLeditedbyuser.Text;
            if (XMLlistofQuestionsEdited.Trim() == string.Empty)
            {
                this.LabelInputError.Text = "Question is currently empty. To confirm there is no questions on this day, check the checkbox below";
                this.CheckBoxAllowBlank.Visible = true;

                if ( this.CheckBoxAllowBlank.Checked == true )
                {
                    this.LabelInputError.Text = "Question is empty. This is confirmed by user";
                }
                else
                {
                    return;
                }
            }

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var coachingsession = from a in context.PhoneCoachingPlanListofSessionsTAB
                                      where a.PhLessonID == PhLessonID
                                      select a;
                PhoneCoachingPlanListofSessionsTAB mycoachingsession = coachingsession.FirstOrDefault();
               
                mycoachingsession.ListofQuestionsXML = XMLlistofQuestionsEdited;

                context.Entry(mycoachingsession).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }

            this.LabelInputError.Text = "Saved changes";
           Response.Redirect("WhatisInaPhoneCoachingSession.aspx?PhLessonID=" + PhLessonID);
        }

        protected void ButtonUpdateRow_Click(object sender, EventArgs e)
        {
            bool isvalidcommansepatedinputstring = checkinputvalidity(); 

            if (isvalidcommansepatedinputstring == true)  updateRecord(); 
        }

        private bool checkinputvalidity()
        {
            bool ans = false;
            string xmlstring = this.TextBoxXMLeditedbyuser.Text;

            //remove empty spaces
            xmlstring = xmlstring.Trim();
            xmlstring = xmlstring.Replace("   ", "");
            xmlstring = xmlstring.Replace("  ", "");
            xmlstring = xmlstring.Replace(" ", "");
            xmlstring = xmlstring.Replace(" ", "");

            char[] seperator = { ',' };
            string[] arrayofquestionnos = xmlstring.Split(seperator);

            ans = true; 
            for (int i = 0; i < arrayofquestionnos.Length; i++)
            {
                try {
                    int.Parse(arrayofquestionnos[i]);
                }catch(Exception )
                {
                    ans = false;               
                }
            }

            this.TextBoxXMLeditedbyuser.Text = xmlstring;

            if(ans == true)            this.LabelValidateInput.Text = "Validated the input";
            else this.LabelValidateInput.Text = "please enter valid input. A valid input is comman seperated integers. Example of valid input is 58,7,932. Here the 3 questions will be asked one by one. The Question ID are used and seperated by commas";

            return ans; 
        }
    }
}