using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           
        }

        UserIdentityTAB logginUser = null; 

        private bool isExisitingUserinDB_And_LoginIfExisitng(string phoneno)
        {
            bool isExisitingUser = false;


            using (var context = new learnthinksavedbEntities29Jan2016())
            {



                var users = from auser in context.UserIdentityTAB
                            where auser.phone == phoneno
                            orderby auser.name
                            select auser;

                int noofusersmatched = users.Count();

                if (noofusersmatched == 0) isExisitingUser = false;
                else
                {
                    isExisitingUser = true;

                    // If more than 1 user is associated with the same phone no, redirect to another screen to login by UserID
                    if (noofusersmatched > 1)
                    {
                        Response.Redirect("LoginByUserID.aspx?phoneno=" + phoneno);
                    }

                    if (noofusersmatched == 1)
                        foreach (var user in users)
                        {
                            int userid = user.userid;
                            Response.Redirect("HomePage.aspx?phoneno=" + phoneno + "&userID=" + userid);
                        }

                    // logginUser = users.First <UserIdentityTAB> () ;
                }


                /*
                var L2EQuery = context.UserIdentityTABs.Where(s => s.phone == phoneno);
                var userrow = L2EQuery.FirstOrDefault<UserIdentityTAB>();
                if (userrow == null) isExisitingUser = false;
                else
                {
                    isExisitingUser = true;
                    logginUser = userrow; 
                }
                */
            }
            return isExisitingUser; 
        }

        private bool isValidinput()
        {
            bool isValid = false; 
            string phoneno = this.TextBox1.Text;
            if (phoneno.Length > 0  )
            {
                try
                {
                    long phone = long.Parse(phoneno);
                    isValid = true;
                }
                catch (Exception ex)
                {
                    isValid = false; 
                }

            }

            return isValid; 
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            if (isValidinput() == false)
            {
                this.Label1.Text = "Please enter a valid phone number. Pls enter only numbers. Use the example phone format provided in this page";
                return;
            }
            string phoneno = this.TextBox1.Text;
            bool isExisitingUser = isExisitingUserinDB_And_LoginIfExisitng(phoneno);

            if (isExisitingUser == false)
            { 
                //redirect to register button 
                Response.Redirect("RegisterUser1.aspx?phoneno=" + phoneno);
            }

            

            this.Label1.Text = "hiiiii";
        }
    }
}