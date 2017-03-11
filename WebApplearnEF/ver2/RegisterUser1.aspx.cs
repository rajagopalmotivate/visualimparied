using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class RegisterUser1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           string phoneno = Request.QueryString["phoneno"];
            this.TextBoxPhone.Text = phoneno;
            this.TextBoxPhone.Enabled = false; 
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //TODO: validate user inputs 
            // if null, 
            // if phone number already exisits, ask?

            UserIdentityTAB newrow = new UserIdentityTAB();
            newrow.phone = this.TextBoxPhone.Text;
            newrow.email = this.TextBoxEmail.Text;
            newrow.name = this.TextBoxName.Text;
            newrow.langforcomm = "en-IN";
            newrow.city = this.DropDownListLocationCity.SelectedIndex;
            newrow.school = this.DropDownListSchoolName.SelectedIndex;  

          //  newrow.email = this.TextBoxEmail.Text;
            // newrow.school = this.DropDownListSchoolName.SelectedItem

            AudioURLTrascribedStringTAB newrow1 = new AudioURLTrascribedStringTAB();
            newrow1.AudioURL = "nandri";

            Table_Test newrow3 = new Table_Test();
            newrow3.test4 = "test"; 

            using (var entitiesframework = new learnthinksavedbEntities29Jan2016  ())
            {                  
              entitiesframework.UserIdentityTAB .Add(newrow); 
             //   entitiesframework.AudioURLTrascribedStringTAB.Add(newrow1);
             //   entitiesframework.Table_Test.Add(newrow3);
                entitiesframework.SaveChanges();
                this.HyperLink1.Text = "Thank you for registering. Pls login to start";
            }


        }
    }
}