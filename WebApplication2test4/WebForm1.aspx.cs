using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2test4
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            AudioURLTrascribedStringTAB newaudiourl = new AudioURLTrascribedStringTAB();
            newaudiourl.AudioURL = "fsfs";

            Table_Test newrow = new Table_Test();
            newrow.test4 = "fsfsf";

            using (var x = new learnthinksavedbEntities1 () )
            {
                x.AudioURLTrascribedStringTAB.Add(newaudiourl);
                x.Table_Test.Add(newrow);

                x.SaveChanges();    


            }
        }
    }
}