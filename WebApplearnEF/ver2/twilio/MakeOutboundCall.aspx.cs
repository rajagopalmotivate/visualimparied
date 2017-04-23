using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using Twilio.Types;

namespace WebApplearnEF.ver2.twilio
{
    public partial class MakeOutboundCall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           string tophoneno = (string)  Request.QueryString["tophoneno"];

            this.HyperLink1.Text = "Call me at +91 9445412134";

        }

        private void makeoutboundcall()
        {
            // Find your Account Sid and Auth Token at twilio.com/console
            const string accountSid = "AC9ed83c24916ef72ab4fc3989f9b352c1";
            const string authToken = "ccfd95896232517077cdbac0c6dd44b5";
            TwilioClient.Init(accountSid, authToken);


            var to = new PhoneNumber("+919445412134");
            var from = new PhoneNumber("+13396746789");

            string CallbackURLstring = @"";

            var call = CallResource.Create(to,
                                           from,
                                           url: new Uri("http://c3f7bf3a.ngrok.io/ver2/twilio/TrackAnOutboundCall.ashx"));


        }

        protected void ButtonMakeOutboundCall_Click(object sender, EventArgs e)
        {
            makeoutboundcall();
        }
    }
}