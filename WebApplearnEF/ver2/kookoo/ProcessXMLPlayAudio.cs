using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace WebApplearnEF.ver2.kookoo
{
    public class ProcessXMLPlayAudio
    {


        public static void autoInsertNodesinDB(XmlDocument sourcexmldoc)
        {
            AutoInsertNodesinDB(sourcexmldoc);
        }


        public static XmlDocument ReplaceNodesPlayTexttoPlayAudio(XmlDocument doc, string lang)
        {
            XmlNode responsenode = doc.SelectSingleNode(@"Response");
            XmlNodeList listofoldchilds = responsenode.SelectNodes(@"//playtext");
            foreach (XmlNode node in listofoldchilds)
            {
                string playaudiourl = GetEquivalentPlayAudioURL(node.InnerText, lang);
                if(playaudiourl != null)
                {
                    XmlNode newchild = doc.CreateElement("playaudio");
                    newchild.InnerText = playaudiourl;
                    node.ParentNode.ReplaceChild(newchild, node);
                }
            }
            return doc;
        }

        private static string GetEquivalentPlayAudioURL(string playtextstring, string lang)
        {
            string playaudiourl = playtextstring; 
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var arowinDB = from arow in context.playtextplayaudio
                               where ((arow.Lang == lang) && (arow.playtext == playtextstring))
                               select arow;

                var exisitingrowsinDB = arowinDB.FirstOrDefault();
                if (exisitingrowsinDB == null)
                {
                    return null;
                }
                else
                {
                    playaudiourl = exisitingrowsinDB.playaudioURL;
                }
            }
            return playaudiourl;
        }



        private static void AutoInsertNodesinDB(XmlDocument doc)
        {
            XmlNode responsenode = doc.SelectSingleNode(@"Response");
            XmlNodeList listofoldchilds = responsenode.SelectNodes(@"//playtext");
            foreach (XmlNode node in listofoldchilds)
            {
 //               InsertifDoesntExist(node.InnerText, UtilitiesClasses.LANGUAGECODE.ENGLISH);
                InsertifDoesntExist(node.InnerText, "en-HI" );
                InsertifDoesntExist(node.InnerText, "en-TA");

            }
        }

        private static bool InsertifDoesntExist(string playtextstring, string lang)
        {
            bool isSuccessful = false;
            bool isRowAlreadyExists = false;
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var arowinDB = from arow in context.playtextplayaudio
                               where ((arow.Lang == lang) && (arow.playtext == playtextstring))
                               select arow;

                var exisitingrowsinDB = arowinDB.FirstOrDefault();
                if (exisitingrowsinDB == null)
                {
                   isRowAlreadyExists = false;
                   bool isSuccessfulDBoperation = InserttoDB(playtextstring, lang);
                }
                else
                {
                    isRowAlreadyExists = true;
                }
            }
            return isSuccessful;
        }


        private static bool InserttoDB(string playtextstring, string lang)
        {
            int playtextplayaudiodummyindex = -1;
            bool isSuccessfulDBoperation = false;
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var newrow = new playtextplayaudio();
                newrow.Lang = lang.ToString();
                newrow.playtext = playtextstring;

                var savedrow = context.playtextplayaudio.Add(newrow);
                int noofrowsaffected = context.SaveChanges();
                if (noofrowsaffected == 1)
                {
                    isSuccessfulDBoperation = true;
                    playtextplayaudiodummyindex = savedrow.dummyindex;
                }
                else
                {
                    isSuccessfulDBoperation = false;
                    playtextplayaudiodummyindex = -99;
                } 
            }
            return isSuccessfulDBoperation;
        }
    }
}
