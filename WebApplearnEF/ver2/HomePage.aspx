<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WebApplearnEF.ver2.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
   
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        <br />
        User ID:
        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
        <br />
        Phone No:
        <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
        <br />
        Email:<asp:Label ID="Label4" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        If you are volunteer to be a coaching program owner, you can create a coaching session from an question bank.&nbsp;&nbsp;
        <br />
        <asp:HyperLink ID="link1" NavigateUrl="ViewCoachingSessionByClass.aspx" runat="server">See list of Phone based Coaching Sessions </asp:HyperLink>
        <br />
        <br />
        If you volunteer to be a teach a subject for a class, you can contribute a new question by recording your a audio.
        <br />
        <br />
        <br />
        If you volunteer to adopt students in your school or town or association, you can circulate this phone number to your students. To have this number as a toll free service for your student, fill in this &quot;Find a donor&quot; form, and we will publish your request to potential corporate doners. <br />
        <br />
        If you are exploring to adopt 1 or 2 kids and educate them for 1 year, you can look at the list of students who need support. When you adopt a student, you can also track his/her progress, and even talk to them to motivate them.
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        About the concepts in the system :-
        <br />
        <br />
        Coaching Plan, A Phone Call or a Phone based Coaching Session, List of Questions to be asked in each Phone Call.<br />
        <br />
        A Coaching Plan has typically runs for 1 academic year and has 365 days or less. <br />
        A Coaching Plan is intended to coach a student on a subject for 1 academic year by making a phone call every day.<br />
        So, a Coaching Plan is list of Phone calls.
        <br />
        <br />
        Each Phone calls last for 5 to 10 minutes, and contains 3 to 5 questions.<br />
        So, A Phone Call or a Phone Coaching Session will contain list of questions.<br />
        <br />
        Each Phone call is unique number is PHLessonID. <br />
        Each Question is unique number is QuestionID. <br />
    
    </div>
        <br />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
