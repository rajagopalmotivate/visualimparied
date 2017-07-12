using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class Motivational
    {
        public static string getAlternatives(string message)
        {
            string ans = "Good";
            if(message.Contains("You have made good progress, You completed this Question"))
            {
                if( (DateTime.Now.Second % 2 ) == 0) 
                    ans = "You have made good progress, You completed this Question"; 
                else
                    ans = "Good progress. I am impressed.";
            }

            return ans;
        }
    }
}
