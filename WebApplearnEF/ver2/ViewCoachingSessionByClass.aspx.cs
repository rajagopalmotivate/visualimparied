using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplearnEF.ver2
{
    public partial class ViewCoachingSessionByClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonFindCoachingClasses_Click(object sender, EventArgs e)
        {
            DisplayLabelSavedStaus.Text = "";
            FindCoachingSessionsByClass();
        }

        private void FindCoachingSessionsByClass()
        {
            string subject = this.DropDownListSubject.SelectedValue;
            int classstd = int.Parse(this.DropDownListClass.SelectedValue);

            string board = this.DropDownListBoard.SelectedValue;
            string lang = this.DropDownListLang.SelectedValue;

            this.LabelDisplay.Text = "Coaching Plan for " + board + " " + subject + " in " + " std " + classstd + "  students: ";

            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                var phoneCoachingsessions = from phonecoachingsession in context.PhoneCoachingPlanListofSessionsTAB
                                            orderby phonecoachingsession.Lang, phonecoachingsession.Board, phonecoachingsession.ClassStd, phonecoachingsession.Subject, phonecoachingsession.PhLessonID
                                            where phonecoachingsession.Board == board && phonecoachingsession.ClassStd == classstd && phonecoachingsession.Subject == subject && phonecoachingsession.Lang == lang
                                            select phonecoachingsession;

                List<PhoneCoachingPlanListofSessionsTAB> mylist = phoneCoachingsessions.ToList();

                GridView1.DataSource = mylist;
                GridView1.DataBind();

                int noofsessions = mylist.Count;
                this.LabelDisplay2.Text = "";
                if (noofsessions == 0) this.LabelDisplay.Text = "Currently there is no coaching plan for this. You may click the add button to add coaching session";
                else this.LabelDisplay2.Text = "This is a " + noofsessions + " day plan. ";

                if (noofsessions != 0)
                {
                    this.DisplayLabelNoCoachingDays.Text = mylist[mylist.Count - 1].PhCoachSessionNo + "";
                    this.DisplayLabelTextBeforeNoCoachingDays.Text = "This module runs for " + noofsessions + " days. The last phone call of this module is on Day No: ";
                }
                else
                {
                    this.DisplayLabelNoCoachingDays.Text = "0";
                    this.DisplayLabelTextBeforeNoCoachingDays.Text = "This module runs for " + noofsessions + " days. The last phone call of this module is on Day No: ";
                }

                GridView2.DataSource = mylist;
                GridView2.DataBind();
            }

            this.ButtonAddnewRow.Visible = true;
        }

        protected void ButtonAddnewRow_Click(object sender, EventArgs e)
        {
            using (var context = new learnthinksavedbEntities29Jan2016())
            {
                PhoneCoachingPlanListofSessionsTAB x = new PhoneCoachingPlanListofSessionsTAB();
                x.Subject = this.DropDownListSubject.SelectedValue;
                x.ClassStd = int.Parse(this.DropDownListClass.SelectedValue);
                x.Board = this.DropDownListBoard.SelectedValue;
                x.Lang = this.DropDownListLang.SelectedValue;

                try
                {
                    int lastdayofsession = int.Parse(this.DisplayLabelNoCoachingDays.Text);
                    x.PhCoachSessionNo  = lastdayofsession + 1;
                }catch(Exception)
                {
                }

                PhoneCoachingPlanListofSessionsTAB savedrow = context.PhoneCoachingPlanListofSessionsTAB.Add(x);
                this.DisplayLabelSavedStaus.Text = " Saved successfully. Your added a extra day to this plan. The day added is = " + savedrow.PhCoachSessionNo; 
                context.SaveChanges();
            }
            FindCoachingSessionsByClass();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}