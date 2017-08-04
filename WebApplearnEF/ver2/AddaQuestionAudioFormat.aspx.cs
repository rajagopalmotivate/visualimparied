using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class AddaQuestionAudioFormat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private ListofQuestionsWithDetailsofEachQuestionTAB InsertRowinDB()
        {
            ListofQuestionsWithDetailsofEachQuestionTAB answer = null;
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var newquestion = new ListofQuestionsWithDetailsofEachQuestionTAB();
                newquestion.Lang = this.DropDownListLang.SelectedValue;
                newquestion.QuestionType = "MCQ";
                ListofQuestionsWithDetailsofEachQuestionTAB savedrow= context.ListofQuestionsWithDetailsofEachQuestionTAB.Add(newquestion);
                int nofofobjectsinsertedtoDB = context.SaveChanges();
                if (nofofobjectsinsertedtoDB == 1)
                    answer = savedrow;
                else
                    answer = null;
             }
            return answer;
        }

        private bool UpdateRowinDB(ListofQuestionsWithDetailsofEachQuestionTAB rowtoupdate)
        {
            bool isSuccessful = false;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                rowtoupdate.E1QuestionText = "";
                context.Entry(rowtoupdate).State = System.Data.Entity.EntityState.Modified;
                int nofofobjectsinsertedtoDB = context.SaveChanges();
                if (nofofobjectsinsertedtoDB == 1)
                    isSuccessful = true;
                else
                    isSuccessful = false;
            }
            return isSuccessful;
        }



        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            if ( isvalidinputs() == false)
            {
                this.LabelInvalidInput.Text = "Insufficent inputs. Please upload all the inputs to proceed";
                return; 
            }

            bool issuccessfuladditon = false; 
            
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var newquestion = new ListofQuestionsWithDetailsofEachQuestionTAB();
                newquestion.Lang = this.DropDownListLang.SelectedValue; 
                newquestion.QuestionType = "MCQ";
                newquestion.E1QuestionUseText = false;
                newquestion.E1QuestionAudio = this.HyperLinkQuestion.NavigateUrl;
                


                context.ListofQuestionsWithDetailsofEachQuestionTAB.Add (newquestion); 
                context.SaveChanges();
                issuccessfuladditon = true; 

            }

            if ( issuccessfuladditon == true)
            {
                Response.Redirect("ViewListofQuestionsTAB.aspx?selectrecentlyupdatedrows=3");
            }

        }

        private bool isvalidinputs()
        {
            bool ans = false;

            if (this.HyperLinkQuestion.NavigateUrl.Contains("http") && this.HyperLinkOption1.NavigateUrl.Contains("http") && this.HyperLinkOption2.NavigateUrl.Contains("http") && this.HyperLinkSummary.NavigateUrl.Contains("http"))
                ans = true;

            if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 3)
                if (!this.HyperLinkOption3.NavigateUrl.Contains("http")) ans = false; 

            return ans;
        }




        private bool uploadafile(string choice , FileUpload fileuploadcontrol, HyperLink hyperlinkcontrol )
        {
            bool isSuccess = false;
            if (fileuploadcontrol.HasFile)
            {
                try
                {

                    string filename = Path.GetFileName(fileuploadcontrol.FileName);
                    // FileUpload1.SaveAs(Server.MapPath("~/") + filename);

                    var connectionstring = @"DefaultEndpointsProtocol=https;AccountName=wiproimagine;AccountKey=ulsN9W/kEhLHbmovBTgYq6L/W+ePfngkT8XKYALbt9vnGh/YoOJv0RffWgc5duA9UuxnIjpXOOS0d8gAZh1RGA==;EndpointSuffix=core.windows.net";

                    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionstring);
                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();


                    CloudBlobContainer container = blobClient.GetContainerReference("visualimparied");
                    container.CreateIfNotExists();


                    container.SetPermissions(new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Blob });

                    // CloudBlockBlob blockBlob = container.GetBlockBlobReference("myblob");

                    CloudBlockBlob blockBlob = container.GetBlockBlobReference(filename);

                    using (fileuploadcontrol.PostedFile.InputStream)
                    {
                        blockBlob.UploadFromStream((Stream)fileuploadcontrol.PostedFile.InputStream);
                        isSuccess = true;
                    }




                    //StatusLabel.Text = "Upload status: File uploaded!";
                }
                catch (Exception ex)
                {
                    isSuccess = false;
                    hyperlinkcontrol.Text = ex.Message; 
                        //  StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            else
            {
                hyperlinkcontrol.Text = "Please click BROWSE button ";
                isSuccess = false;
            }
            return isSuccess;
        }

        protected void ButtonQuestion_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonOption1_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonOption2_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonOption3_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonHint_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonSummary_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonStep1InsertRow_Click(object sender, EventArgs e)
        {

        }
    }
}