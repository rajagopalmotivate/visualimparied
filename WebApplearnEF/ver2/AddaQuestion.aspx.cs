using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class AddaQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            bool issuccessfuladditon = false; 
            
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var newquestion = new ListofQuestionsWithDetailsofEachQuestionTAB();
                newquestion.Lang = this.DropDownListLang.SelectedValue; 
                newquestion.QuestionType = "MCQ";
                newquestion.E1QuestionText = this.TextBox1.Text;
                newquestion.E2Option1Text = this.TextBox2.Text;
                newquestion.E3Option2Text = this.TextBox3.Text;
                newquestion.E4Option3Text = this.TextBox4.Text;

                context.ListofQuestionsWithDetailsofEachQuestionTAB.Add (newquestion); 
                context.SaveChanges();
                issuccessfuladditon = true; 

            }

            if ( issuccessfuladditon == true)
            {
                Response.Redirect("ViewListofQuestionsTAB.aspx?selectrecentlyupdatedrows=3");
            }

        }



    }
}