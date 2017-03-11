using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class EditaQuestion : System.Web.UI.Page
    {
        int QuestionNo = -999;
        ListofQuestionsWithDetailsofEachQuestionTAB myQuestionObject; 
        protected void Page_Load(object sender, EventArgs e)
        {
            QuestionNo = getQuestionNo();
            myQuestionObject = getQuestionObject();

            populateForm();
        }

        private int getQuestionNo()
        {
            int ans = -99;

            string userid = Request.QueryString["QuestionNo"];
            if (userid == null) Response.Redirect("ViewListofQuestionsTAB.aspx");
            userid = userid.Trim();

            try
            {
                ans = int.Parse(userid);
            }
            catch (Exception ex)
            {
                Response.Redirect("ViewListofQuestionsTAB.aspx");
            }

            return ans;
        }

        private ListofQuestionsWithDetailsofEachQuestionTAB getQuestionObject()
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var listofquestionsTAB = (from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                          where listofquestions.QuestionNo == QuestionNo
                                          orderby listofquestions.QuestionNo descending
                                          select listofquestions).Take(1);

                ListofQuestionsWithDetailsofEachQuestionTAB ans = listofquestionsTAB.First();

                return ans;
                // FormView1.DataSource = listofquestionsTAB;
                // FormView1.DataBind(); 
            }
        }

        private void populateForm()
        {
            this.TextBoxQuestion.Text = myQuestionObject.E1QuestionText;
            if (myQuestionObject.E1QuestionUseText == true) this.RadioButtonListQuestionOption.SelectedIndex = 1;
            else this.RadioButtonListQuestionOption.SelectedIndex = 0;  
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            saveChanges();
        }

        private void saveChanges()
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var aquestion = from question in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                      where question.QuestionNo == QuestionNo
                                      select question;

               ListofQuestionsWithDetailsofEachQuestionTAB questionobject =  aquestion.FirstOrDefault();

                if (this.RadioButtonListQuestionOption.SelectedIndex == 1)
                    questionobject.E1QuestionUseText = true;
                else
                    questionobject.E1QuestionUseText = false; 

                questionobject.E1QuestionText = this.TextBoxQuestion.Text; 



                context.Entry(questionobject).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }
            this.LabelDisplaySaved.Text = "Saved";

        }
    }
}