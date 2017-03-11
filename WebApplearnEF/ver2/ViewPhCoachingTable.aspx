<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPhCoachingTable.aspx.cs" Inherits="WebApplearnEF.ver2.ViewPhCoachingTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    
    </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateEditButton="True">
        </asp:GridView>
    </form>
</body>
</html>
