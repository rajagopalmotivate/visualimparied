using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class UtilitiesClasses
    {

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

    }

}
