using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class StudentStatus
    {
        public static string  baseURL = @"http://067e0831.ngrok.io/ver2/kookoo/";

        public static StudentTAB getStudentbyAssociatedPhoneNo( long callerPhoneNo )
        {
            StudentTAB mystudent ;

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetastudentrecord = from astudent in context.StudentTAB
                            where astudent.AssociatedPhoneNo   == callerPhoneNo
                            select astudent;

                mystudent =  querytogetastudentrecord.FirstOrDefault();
            }
            return mystudent;
        }


    }
}
