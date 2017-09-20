<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="XMLTry.aspx.cs" Inherits="WebApplearnEF.ver2.XMLTry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="TextBox1" runat="server" Height="338px" TextMode="MultiLine" Width="1251px"></asp:TextBox>
    
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
    
    </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
        <br />
        <asp:TextBox ID="TextBox2" runat="server" Height="341px" TextMode="MultiLine" Width="1259px"></asp:TextBox>
    </form>
</body>
</html>
