using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class AddQuestionToPhoneCall : System.Web.UI.Page
    {
        int PhLessonID = -99999; 
        protected void Page_Load(object sender, EventArgs e)
        {
            PhLessonID = getPhLessonID();
            this.LabelDisplayPhLessonID.Text = getPhLessonID() + "";
            populatelistofQuestions(); 
        }

        protected string GetStatusString(string QuestionNo)
        {
            string url = "AddQuestiontoPhoneId.aspx?PhLessonID=" + PhLessonID + "&QuestionNo=" + QuestionNo;
            return url;
        }

        private void populatelistofQuestions()
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var listofquestionsTAB = (from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                          orderby listofquestions.QuestionNo descending
                                          select listofquestions); 

                GridView1.DataSource = listofquestionsTAB.ToList();
                GridView1.DataBind();
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

    }
}