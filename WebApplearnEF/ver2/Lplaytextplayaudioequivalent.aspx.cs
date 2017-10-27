using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class Lplaytextplayaudioequivalent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if( ! Page.IsPostBack )
            {
                // string IDstring = Request.QueryString
                loadValues();
            }
        }


        private void loadValues()
        {
            int myID = 2;
            string myIDstring = Request.QueryString["dummyindex"];
            myID = int.Parse(myIDstring);

            playtextplayaudio row; 
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var listofquestionsTAB = (from listofquestions in context.playtextplayaudio
                                          where listofquestions.dummyindex == myID
                                          select listofquestions).Take(1);
                row = listofquestionsTAB.FirstOrDefault();
            }
            this.Label1.Text = row.dummyindex.ToString();
            this.Label2.Text = row.Lang.ToString();
            this.Label3.Text = row.playtext.ToString();
            if(row.playaudioURL !=null)
                this.TextBox1.Text = row.playaudioURL.ToString();
        }

        private void insertValues()
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                playtextplayaudio x = new playtextplayaudio();
                x.dummyindex = int.Parse( this.Label1.Text);
                x.playaudioURL = this.TextBox1.Text;
                x.Lang = this.Label2.Text;
                x.playtext = this.Label3.Text;
                context.Entry(x).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            insertValues();
        }
    }
}