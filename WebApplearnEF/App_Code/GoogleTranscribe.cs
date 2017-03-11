using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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


    public class GoogleTranscribe
    {
        // [START authenticating]
        static public SpeechService CreateAuthorizedClient()
        {
            //  InputStream resourceAsStream = AuthTest.class.getClassLoader().getResourceAsStream("Google-Play-Android-Developer.json");

            string filepath = HttpContext.Current.Server.MapPath("My First Project-f4fe667f2d92.json");
            FileStream mystream = new FileStream(filepath, FileMode.Open);
            GoogleCredential credential = GoogleCredential.FromStream(mystream);

     //   GoogleCredential credential =                GoogleCredential.GetApplicationDefaultAsync().Result;
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

        // [START run_application]
        static public string mainCalltoSpeech( string audioURL)
        {
           // audioURL = "http://nandithankyoufatherjesus.azurewebsites.net/raintext.wav"; 
            string answer = "";
            byte[] bytearrayofaudiofile;


            /* FILE SYSTEM BASED AUDIO FILE
            string filepath = HttpContext.Current.Server.MapPath(audiofilepath);
            string audio_file_path = filepath;
            bytearrayofaudiofile = File.ReadAllBytes(audio_file_path); 
            */

            var service = CreateAuthorizedClient();

            System.Net.WebClient myWebClient = new System.Net.WebClient();
            bytearrayofaudiofile = myWebClient.DownloadData(audioURL);

            // [END run_application]
            // [START construct_request]
            //en-IN
            var request = new Google.Apis.Speech.v1beta1.Data.SyncRecognizeRequest()
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
            var response = service.Speech.Syncrecognize(request).Execute();
            foreach (var result in response.Results)
            {
                foreach (var alternative in result.Alternatives)
                    answer += alternative.Transcript + " . NEXT Alternative. ";
            }
            // [END send_request]

            return answer;
        }
    }

