using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.WindowsAzure; // Namespace for CloudConfigurationManager
using Microsoft.WindowsAzure.Storage; // Namespace for CloudStorageAccount
using Microsoft.WindowsAzure.Storage.Blob; // Namespace for Blob storage types
using System.Configuration;

namespace WebApplearnEF
{
    public partial class UploadFileLearn1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

//            var connectionString = ConfigurationManager.ConnectionStrings["BlobStorageConnectionString"].ConnectionString;



        }

        protected void SubmitFileButton_Click(object sender, EventArgs e)
        {
            if ( FileUpload1.HasFile)
            {
                try
                {

                    string filename = Path.GetFileName(FileUpload1.FileName);
                   // FileUpload1.SaveAs(Server.MapPath("~/") + filename);

                    var connectionstring = @"DefaultEndpointsProtocol=https;AccountName=wiproimagine;AccountKey=ulsN9W/kEhLHbmovBTgYq6L/W+ePfngkT8XKYALbt9vnGh/YoOJv0RffWgc5duA9UuxnIjpXOOS0d8gAZh1RGA==;EndpointSuffix=core.windows.net";

                    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionstring);
                    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();


                    CloudBlobContainer container = blobClient.GetContainerReference("imagine");
                    container.CreateIfNotExists();


                    container.SetPermissions(new BlobContainerPermissions { PublicAccess = BlobContainerPublicAccessType.Blob });

                    // CloudBlockBlob blockBlob = container.GetBlockBlobReference("myblob");

                    CloudBlockBlob blockBlob = container.GetBlockBlobReference(filename);

                    using (FileUpload1.PostedFile.InputStream)
                        { blockBlob.UploadFromStream((Stream)FileUpload1.PostedFile.InputStream); }



        
                    //StatusLabel.Text = "Upload status: File uploaded!";
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                  //  StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
        }
    }
}