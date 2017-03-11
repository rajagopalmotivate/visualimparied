using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class ViewPhCoachingTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var phoneCoachingsessions = from phonecoachingsession in context.PhoneCoachingPlanListofSessionsTAB
                                            orderby phonecoachingsession.Lang, phonecoachingsession.Board, phonecoachingsession.ClassStd , phonecoachingsession.Subject
                                            select phonecoachingsession;

                GridView1.DataSource = phoneCoachingsessions.ToList();
                GridView1.DataBind();
            }
        }
    }
}