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

        private ListofQuestionsWithDetailsofEachQuestionTAB insertandupdateQuestion()
        {
            bool isfullysuccess = false;
            ListofQuestionsWithDetailsofEachQuestionTAB question ;

            question = InsertRowinDB();
            if (question!=null)
            {
                this.QuestionUniqueID.Text = question.QuestionNo + "";

                bool isAudioFilesUploadedSuccessfully = uploadAllAudioFiles();
                isfullysuccess = UpdateRowinDB(question);
            }
            else
            {
                isfullysuccess = false;
                this.LabelInvalidInput.Text = "New question created BUT Update failed. Check Did you upload audio files?";
            }

            if (isfullysuccess) return question;
            else return null;
        }

        private ListofQuestionsWithDetailsofEachQuestionTAB InsertRowinDB()
        {
            ListofQuestionsWithDetailsofEachQuestionTAB answer = null;
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var newquestion = new ListofQuestionsWithDetailsofEachQuestionTAB();
                newquestion.Lang = this.DropDownListLang.SelectedValue;
                newquestion.Subject = this.DropDownListSubject.SelectedValue;
                newquestion.Board = this.DropDownListBoard.SelectedValue;
                newquestion.ClassStd = int.Parse( this.DropDownListStandard.SelectedValue);
                newquestion.QuestionType = this.DropDownList1.SelectedValue.ToString();
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
                rowtoupdate.E1QuestionUseText = false;
                rowtoupdate.E1QuestionAudio = this.HyperLinkQuestion.NavigateUrl.ToString();
                rowtoupdate.E2Option1UseText = false;
                rowtoupdate.E2Option1Audio = this.HyperLinkOption1.NavigateUrl.ToString();
                rowtoupdate.E3Option2UseText = false;
                rowtoupdate.E3Option2Audio = this.HyperLinkOption2.NavigateUrl.ToString();
                rowtoupdate.HowManyChoicesforAnswer = int.Parse(this.DropDownListHowmanychoices.SelectedValue);
                if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 3)
                {
                    rowtoupdate.E4Option3UseText = false;
                    rowtoupdate.E4Option3Audio = this.HyperLinkOption3.NavigateUrl.ToString();
                }
                rowtoupdate.CorrectAnswers = this.DropDownListCorrectAnswer.SelectedValue;
                rowtoupdate.E5HintUseText = false;
                rowtoupdate.E5HintAudio = this.HyperLinkHint.NavigateUrl.ToString();
                rowtoupdate.E6ResponsetoCorrectAnswerUseText = false;
                rowtoupdate.E6ResponsetoCorrectAnswerAudio = this.HyperLinkSummary.NavigateUrl.ToString();

                //rowtoupdate


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
            if ( isvalidinputs () == false)
            {
                this.LabelInvalidInput.Text = "Insufficent inputs. Please upload all the inputs to proceed";
                return; 
            }

            ListofQuestionsWithDetailsofEachQuestionTAB question = insertandupdateQuestion();

            if (question != null)
            {

                this.LabelInvalidInput.Text = " Created Question No  " +  question.QuestionNo ;
                this.ButtonSubmit.Enabled = false;
                this.ButtonSubmit.Text = "Successfully updated. ";
                this.HyperLinkSuccessClicktoContinue.Text = "Continue to Next screen";
                this.HyperLinkSuccessClicktoContinue.NavigateUrl = "ViewListofQuestionsTAB.aspx";
              //  Response.Redirect("ViewDetailsofAQuestion.aspx?QuestionUniqueID=" + question.QuestionNo );
            }
            else
            {
                this.LabelInvalidInput.Text += ". Try again. ";
            }

        }

        private bool isvalidinputs()
        {
            bool ans = false;

            if( (string.IsNullOrWhiteSpace(FileUploadQuestion.FileName)==false)
             && (string.IsNullOrWhiteSpace(FileUploadOption1.FileName) == false)
             && (string.IsNullOrWhiteSpace(FileUploadOption2.FileName) == false)
             && (string.IsNullOrWhiteSpace(FileUploadSummary.FileName) == false)
             && (string.IsNullOrWhiteSpace(FileUploadHint.FileName) == false)
                )               
                ans = true;

            if (ans == true)
                if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 3)
                    if (string.IsNullOrWhiteSpace(FileUploadOption3.FileName) == false) ans = true;
                    else ans = false;

            return ans;
        }


        private bool isvalidinputsAllFilesuploaded()
        {
            bool ans = false;


            if (this.HyperLinkQuestion.NavigateUrl.Contains("http") && this.HyperLinkOption1.NavigateUrl.Contains("http") && this.HyperLinkOption2.NavigateUrl.Contains("http") && this.HyperLinkSummary.NavigateUrl.Contains("http"))
                ans = true;

            if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 3)
                if (!this.HyperLinkOption3.NavigateUrl.Contains("http")) ans = false; 

            return ans;
        }


        private bool uploadAllAudioFiles()
        {
            bool isAllFilesUploadedSuccessfully = true;
            try {
                bool isFileUploadSuccess = false;
                isFileUploadSuccess = uploadafile("Question", FileUploadQuestion, HyperLinkQuestion, "question.mp3");
                if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
                isFileUploadSuccess = uploadafile("Option1", FileUploadOption1, HyperLinkOption1, "option1.mp3" );
                if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
                isFileUploadSuccess = uploadafile("Option2", FileUploadOption2, HyperLinkOption2, "option2.mp3");
                if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
                if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 3)
                {
                    isFileUploadSuccess = uploadafile("Option3", FileUploadOption3, HyperLinkOption3, "option3.mp3");
                    if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
                }
                isFileUploadSuccess = uploadafile("Summary", FileUploadSummary, HyperLinkSummary , "summary.mp3");
                if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
                isFileUploadSuccess = uploadafile("Hint", FileUploadHint, HyperLinkHint , "hint.mp3");
                if (isFileUploadSuccess == false) isAllFilesUploadedSuccessfully = false;
            }catch(Exception ex)
            {
                this.LabelInvalidInput.Text = ex.Message;
                isAllFilesUploadedSuccessfully = false;
            }
            return isAllFilesUploadedSuccessfully;
        }


        private bool uploadafile(string choice , FileUpload fileuploadcontrol, HyperLink hyperlinkcontrol, string blobname )
        {
            string UniqueQuestionID = this.QuestionUniqueID.Text;
            if (int.Parse(UniqueQuestionID) <= 0) return false;

            bool isSuccess = false;
            if (fileuploadcontrol.HasFile)
            {
                try
                {

                    string filename = Path.GetFileName(fileuploadcontrol.FileName);
                    // FileUpload1.SaveAs(Server.MapPath("~/") + filename);

                    // var connectionstring = @"DefaultEndpointsProtocol=https;AccountName=wiproimagine;AccountKey=ulsN9W/kEhLHbmovBTgYq6L/W+ePfngkT8XKYALbt9vnGh/YoOJv0RffWgc5duA9UuxnIjpXOOS0d8gAZh1RGA==;EndpointSuffix=core.windows.net";
                     var  connectionstring = @"DefaultEndpointsProtocol=https;AccountName=visualimpared;AccountKey=Lf9v/OzP8rbktLjYl3sOfGXE0W2Gu4qfs836a2JAlA1Nr2GuFvi46ujp7F2Jpkh+Rc+Q2NG8L240wNuxu0KuOA==;EndpointSuffix=core.windows.net";
                    connectionstring = (string)System.Configuration.ConfigurationManager.ConnectionStrings["Azureblobstoragevisualimparied"].ConnectionString;

                    connectionstring = @"DefaultEndpointsProtocol=https;AccountName=mydigitaleye;AccountKey=eVKnB1YUQp/vvAZaER2i/+lqgEgubG2A40wX1o5lyIE3IdaCTbKis/RyEXu5N4kRaYEsAEPVL2qIRjINZ1R20w==;EndpointSuffix=core.windows.net";


                    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionstring);
                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();


                    CloudBlobContainer container = blobClient.GetContainerReference("educationlearnstorage" + UniqueQuestionID);
                    container.CreateIfNotExists();

                    container.SetPermissions(new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Blob });

                    // CloudBlockBlob blockBlob = container.GetBlockBlobReference("myblob");

                    CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobname);

                    using (fileuploadcontrol.PostedFile.InputStream)
                    {
                        blockBlob.UploadFromStream((Stream)fileuploadcontrol.PostedFile.InputStream);
                        isSuccess = true;
                    }
                    if(isSuccess)
                    {
                        hyperlinkcontrol.Text = blockBlob.StorageUri.PrimaryUri.ToString() ;
                        hyperlinkcontrol.NavigateUrl = blockBlob.StorageUri.PrimaryUri.ToString() ;
                    }
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

        protected void DropDownListHowmanychoices_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.Parse(this.DropDownListHowmanychoices.SelectedValue) == 2)
            { this.HyperLinkOption3.Enabled = false; this.HyperLinkOption3.Text = "This particular input is NOT required"; }
            else
            { this.HyperLinkOption3.Enabled = true; this.HyperLinkOption3.Text = "Input the value"; }
        }
    }
}