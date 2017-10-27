using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace WebApplearnEF.ver2
{
    public partial class XMLTry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            TryingwithAllnodes();
        }


        private void workingwellwithFirstnodes()
        {

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(this.TextBox1.Text);


            XmlNode responsenode = doc.SelectSingleNode(@"Response");




            XmlNodeList listofoldchilds = responsenode.SelectNodes(@"playtext");
            foreach (XmlNode node in listofoldchilds)
            {
                //   this.TextBox2.Text += node.OuterXml + System.Environment.NewLine;
                //  doc.ReplaceChild(newchild, node);
                // node.ParentNode.RemoveChild(node);
                //  responsenode.ReplaceChild(newchild, node);
                XmlNode newchild = doc.CreateElement("playaudio");
                newchild.InnerText = node.InnerText;
                responsenode.ReplaceChild(newchild, node);
            }

            this.TextBox2.Text = doc.OuterXml;
        }


        private void TryingwithAllnodes()
        {

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(this.TextBox1.Text);


            XmlNode responsenode = doc.SelectSingleNode(@"Response");




            XmlNodeList listofoldchilds = responsenode.SelectNodes(@"//playtext");
            foreach (XmlNode node in listofoldchilds)
            {
                //   this.TextBox2.Text += node.OuterXml + System.Environment.NewLine;
                //  doc.ReplaceChild(newchild, node);
                // node.ParentNode.RemoveChild(node);
                //  responsenode.ReplaceChild(newchild, node);
                XmlNode newchild = doc.CreateElement("playaudio");
                newchild.InnerText = node.InnerText;
                node.ParentNode.ReplaceChild(newchild, node);
            }

            this.TextBox2.Text = doc.OuterXml;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string answerxml = $@"
<Response > 
    <playtext>Welcome to Mitra Jyothi Audio Classes. </playtext>
    <playtext>You need just a telephone to avail this phone based coaching.</playtext>
    <playtext>Everyone can study.</playtext>
    <playtext>Do you want to register for free coaching? </playtext>
    <collectdtmf l='1' >     
        <playtext>Press 1 for yes. Press 0 for no.</playtext>   
        <playtext>Incase you already have registered before, but calling from a new phone number, Press 9 </playtext>                                   
    </collectdtmf>
    <playtext>No response received so far</playtext>
 
</Response>";


            string answerxml2 = $@"
<Response > 
    <playtext>Welcome to Mitra Jyothi Audio Classes. </playtext>
    <playtext>You need just a telephone to avail this phone based coaching.</playtext>
    <playtext>Everyone can study.</playtext>
    <playtext>Do you want to register for free coaching? </playtext>
    <playtext>No response received so far</playtext>
 
</Response>";

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(answerxml);

            this.TextBox1.Text = doc.OuterXml;

        }
    }
}