using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApplearnEF.ver2.kookoo
{
    public class QuestionDetails
    {
    
        public static ListofQuestionsWithDetailsofEachQuestionTAB getQuestionDetails(long QuestionNO)
        {
            ListofQuestionsWithDetailsofEachQuestionTAB myquestion; 

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var querytogetaquestionrecord = from aquestion in context.ListofQuestionsWithDetailsofEachQuestionTAB
                                               where aquestion.QuestionNo == QuestionNO
                                               select aquestion;

                myquestion = querytogetaquestionrecord.FirstOrDefault();
            }
            return myquestion;
        }

    }
}
