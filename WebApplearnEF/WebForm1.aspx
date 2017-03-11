<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplearnEF.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:Panel ID="Panel1" runat="server" BackColor="#CCFFCC" Height="115px" Width="1786px">
            <strong>Insert Audio into Table</strong><br />
            <br />
            URL:<asp:TextBox ID="TextBox1" runat="server" Width="673px"></asp:TextBox>
            <asp:Button ID="mystudent1" runat="server" Text="InsertAudio" OnClick="mystudent1_Click" />
        </asp:Panel>
        <p>
            &nbsp;</p>
        <asp:Panel ID="Panel2" runat="server">
            <strong>Update Audio URL in Table</strong><br /> URL
            <asp:TextBox ID="TextBox2" runat="server"  Width="623px"></asp:TextBox>
            <asp:Button ID="updateAudioURLButton" runat="server" OnClick="updateAudioURLButton_Click" Text="update AudioURL" Width="174px" />
            <br />
            <br />
            <br />
        </asp:Panel>
        <asp:Button ID="Button1Delete" runat="server" OnClick="Button1Delete_Click" Text="Button Delete" />
    </form>
</body>
</html>
