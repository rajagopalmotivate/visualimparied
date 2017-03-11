using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class testing12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<ListofQuestionsWithDetailsofEachQuestionTAB> GridView1_GetData()
        {
            var context = new learnthinksavedbEntities29Jan2016();
            
                var listofquestionsTAB = from listofquestions in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                         orderby listofquestions.Lang, listofquestions.QuestionType, listofquestions.QuestionNo
                                         where (listofquestions.QuestionNo == 2 || listofquestions.QuestionNo == 3)
                                         select listofquestions;

                return listofquestionsTAB; 
            

        }

        public string QuestionNaviatetoURL(int questionNo)
        {
            return "question.aspx?id=" + questionNo;
        }
    }
}