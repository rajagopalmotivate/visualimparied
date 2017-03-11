using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void mystudent1_Click(object sender, EventArgs e)
        {
            /*
            AudioURLTrascribedStringTABLE newrow = new AudioURLTrascribedStringTABLE();
            newrow.AudioURL = "http://thankyouJ.com/recording1.wav";

            using (var EFcontext = new learnthinksavedbEntities())
            {
                EFcontext.AudioURLTrascribedString.Add(newrow);
                EFcontext.SaveChanges();
            }
            */
        }

        protected void updateAudioURLButton_Click(object sender, EventArgs e)
        {
            /*
            int searchaudioid = 2; 
            using (var EFcontext = new learnthinksavedbEntities())
            {
             //   EFcontext.Configuration.UseDatabaseNullSemantics 
                AudioURLTrascribedStringTABLE searchforrow = EFcontext.AudioURLTrascribedString.First(i => i.AudioId == searchaudioid);

            //    AudioURLTrascribedStringTABLE searchforrow = EFcontext.AudioURLTrascribedString.Find()
                    

                searchforrow.AudioURL = @"http://goole.com";
            
                EFcontext.SaveChanges();
            }
            */
        }

        protected void Button1Delete_Click(object sender, EventArgs e)
        {
            /*
            using (var EFcontext = new learnthinksavedbEntities())
            {
                AudioURLTrascribedStringTABLE searchforrow = EFcontext.AudioURLTrascribedString.First(i => i.AudioId == 1);

                EFcontext.AudioURLTrascribedString.Remove(searchforrow);


                EFcontext.SaveChanges();
            }*/
        }
    }
}