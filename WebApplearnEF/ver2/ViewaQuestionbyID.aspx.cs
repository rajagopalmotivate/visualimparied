using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class ViewaQuestionbyID : System.Web.UI.Page
    {
        int QuestionNo = -999;
        protected void Page_Load(object sender, EventArgs e)
        {
            QuestionNo = getQuestionNo();

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