using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//using Google.Apis.CloudSpeechAPI.v1beta1;
using Google.Apis.Speech.v1beta1;

using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using System.IO;
using System.Threading;
using System.Web;

public class GoogleTranscribeAsync
    {
        // [START authenticating]

        private SpeechService CreateAuthorizedClient()
        {

        string filepath = HttpContext.Current.Server.MapPath("My First Project-f4fe667f2d92.json");
        FileStream mystream = new FileStream(filepath, FileMode.Open);
        GoogleCredential credential = GoogleCredential.FromStream(mystream);


        // Inject the Cloud Storage scope if required.
        if (credential.IsCreateScopedRequired)
            {
                credential = credential.CreateScoped(new[]
                {
                    SpeechService.Scope.CloudPlatform
                });
            }
            return new SpeechService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "DotNet Google Cloud Platform Speech Sample",
            });
        }
        // [END authenticating]


        private SpeechService mySpeechService; 

        public void CreateSingleton()
        {
            if (mySpeechService == null)
                mySpeechService = CreateAuthorizedClient();
        }

        // [START run_application]
        public string MainTranscribe( string audioURL)
        {

            string audio_file_path = audioURL;

        // audioURL = "http://nandithankyoufatherjesus.azurewebsites.net/raintext.wav"; 
        byte[] bytearrayofaudiofile;
        System.Net.WebClient myWebClient = new System.Net.WebClient();
        bytearrayofaudiofile = myWebClient.DownloadData(audioURL);
        // [END run_application]
        // [START construct_request]
        var request = new Google.Apis.Speech.v1beta1.Data.AsyncRecognizeRequest()
            {
                Config = new Google.Apis.Speech.v1beta1.Data.RecognitionConfig()
                {
                    Encoding = "LINEAR16",
                    SampleRate = 8000,
                    LanguageCode = "en-IN"
                },
                Audio = new Google.Apis.Speech.v1beta1.Data.RecognitionAudio()
                {
                    Content = Convert.ToBase64String(bytearrayofaudiofile)
                }
            };
            // [END construct_request]
            // [START send_request]
            Google.Apis.Speech.v1beta1.Data.Operation asyncResponse = mySpeechService.Speech.Asyncrecognize(request).Execute();
            return asyncResponse.Name; 
        }

        public bool isAnswerReady(string asyncResponseName)
        {
            string name = asyncResponseName;
            Google.Apis.Speech.v1beta1.Data.Operation op;
            op = mySpeechService.Operations.Get(name).Execute();
            bool ans = (op.Done.HasValue && op.Done.Value);   
            return ans; //if transcription answer is ready, returns true
        }

        public string getTransicbedAnswer( string asyncResponseName)
        {
            string name = asyncResponseName;
            Google.Apis.Speech.v1beta1.Data.Operation op;

           op = mySpeechService.Operations.Get(name).Execute();
       
            dynamic results = op.Response["results"];

            string ans = "";
            foreach (var result in results)
            {
                foreach (var alternative in result.alternatives)
                    ans += alternative.transcript + "  .Jesus is my KING and LORD.   ";
            }
            // [END send_request]

            return ans;
        }


    }

