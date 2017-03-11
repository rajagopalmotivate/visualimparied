<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestiontoPhoneId.aspx.cs" Inherits="WebApplearnEF.ver2.AddQuestiontoPhoneId" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <asp:Label ID="LabelDisplaySaved" runat="server" Text=""></asp:Label>
           <br />
        <asp:Label ID="LabelDisplay" runat="server" Text=""></asp:Label>
    
        <br />
        <br />
        Question No:
        <asp:Label ID="LabelQuestionNO" runat="server" Text=""></asp:Label>
        <br />
        Phone ID: <asp:Label ID="LabelPhoneID" runat="server" Text="Label"></asp:Label>
        <br />
    
    </div>
        <asp:Button ID="ButtonConfirmAddition" runat="server" Text="Confirm Adding the Question" OnClick="ButtonConfirmAddition_Click" />
    </form>
</body>
</html>
