using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class ViewListofQuestionsTAB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SelectTop3(3); 
        }

        private void SelectTop3(int top3)
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var listofquestionsTAB = (from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                          orderby listofquestions.QuestionNo descending
                                          select listofquestions).Take(top3);

                GridView1.DataSource = listofquestionsTAB.ToList();

                GridView1.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SelectTop3(10);
        }
    }
}