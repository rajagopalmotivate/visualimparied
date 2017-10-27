using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class UtilitiesClasses
    {
        public static string getLanguageinStringFormat(string lang)
        {
            string ans = "Language is NOT Defined";
            if (lang.ToUpper().Contains("EN-IN")) ans = "English";
            else if (lang.ToUpper().Contains("HI-IN")) ans = "Hindi";
            return ans; 
        }


        public enum LANGUAGECODE2 { ENGLISH, HINDI };

      


        public static long getPhonenumbersinConsistentFormat(long callerPhoneNo)
        {
            long ans = callerPhoneNo;

            string callerPhoneNostring = callerPhoneNo.ToString();
            int countofcellnowith91 = "919513376285".Length;
            int landlineexample =       "8022585452".Length;

            if ( callerPhoneNostring.Length == countofcellnowith91)
            {//remove 91
                ans = callerPhoneNo - 910000000000; 
            }

            return ans;
        }


        public static string GetLocalAudioONEString(string xmlstring, LANGUAGECODE2 langcode )
        {
            string ans = "";
            if (xmlstring.Contains(@"<playtext>"))
            {
                
            }
            else
                ans = xmlstring;

            return ans;

        }

    }

}
