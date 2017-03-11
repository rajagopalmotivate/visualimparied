using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class GetQuestionbyID : System.Web.UI.Page
    {
        int QuestionNo = -999; 
        protected void Page_Load(object sender, EventArgs e)
        {
            QuestionNo = getQuestionNo();
            this.LabelQuestionId.Text = QuestionNo + "";
            this.HyperLinkEdit.NavigateUrl = "EditaQuestion.aspx?QuestionNo";

            populateDataGrid();
            
        }

        private void populateDataGrid()
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var listofquestionsTAB = (from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                          where listofquestions.QuestionNo == QuestionNo
                                          orderby listofquestions.QuestionNo descending
                                          select listofquestions).Take(1);

                GridView1.DataSource = listofquestionsTAB.ToList();

                GridView1.DataBind();

               // FormView1.DataSource = listofquestionsTAB;
               // FormView1.DataBind(); 
            }
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

    }
}