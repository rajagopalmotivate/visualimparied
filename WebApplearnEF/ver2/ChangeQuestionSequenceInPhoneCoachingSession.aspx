<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangeQuestionSequenceInPhoneCoachingSession.aspx.cs" Inherits="WebApplearnEF.ver2.ChangeQuestionSequenceInPhoneCoachingSession" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="LabelInputError" runat="server" Text=""></asp:Label>
    
        <br />
        <asp:CheckBox ID="CheckBoxAllowBlank" Visible="false" Text="Check this to checkbox to confirm that there will no questions asked on this day" runat="server" />
        <br />
        <br />
    
        <br />
        Change the sequence of questions in a particular Coaching Phone Session
        <br />
        <br />
        PhLessonID :
        <asp:Label ID="LabelPhoneID" runat="server" Text=""></asp:Label>

        <br />
        <br />
        Sequence of Questions (Current):

        <asp:Label ID="LabelQuestions" runat="server" Text=""></asp:Label>

    
        <br />
        <br />
        Type the
        Sequence of Questions and Click the button:
        <br />
        Please use commas to seperate the questions noumbers.
            <br /><asp:TextBox ID="TextBoxXMLeditedbyuser" runat="server"  Width="566px"></asp:TextBox>
        <asp:Label ID="LabelValidateInput" runat="server" Text=""></asp:Label>
        <br />
        <asp:Button ID="ButtonUpdateRow" runat="server" Text="Update the record" OnClick="ButtonUpdateRow_Click" />

    
    </div>
    </form>
</body>
</html>
