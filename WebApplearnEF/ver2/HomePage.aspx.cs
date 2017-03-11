using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    // Always called like this . HomePage.aspx?userID=354
    public partial class HomePage : System.Web.UI.Page
    {
        int userID = -1; 
        protected void Page_Load(object sender, EventArgs e)
        {
            userID = GetUserID(); //gets userid from querystring, validates too 
            populateUserName(userID);
        }

        private int GetUserID()
        {
            int ans = -99; 
          string userid =   Request.QueryString["userID"];
            if (userid == null) Response.Redirect("Login1.aspx");
            userid = userid.Trim();

            try
            {
                ans = int.Parse(userid); 
            }
            catch (Exception ex)
            {
                Response.Redirect("Login.aspx");
            }

            return ans; 
        }

        private void populateUserName(int userID)
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var users = from auser in context.UserIdentityTAB
                            where auser.userid  == userID
                            orderby auser.name
                            select auser;

               int noofusersmatched = users.Count();

               var user = users.First();

                this.Label1.Text = "Welcome " + user.name;
                this.Label2.Text =  user.userid  + " (Please remember this unique user number or your personal mobile phone no)";
                this.Label3.Text = user.phone;
                this.Label4.Text = user.email; 
            }
        }
    }
}