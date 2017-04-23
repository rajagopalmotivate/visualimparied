<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakeOutboundCall.aspx.cs" Inherits="WebApplearnEF.ver2.twilio.MakeOutboundCall" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
        <br />
        <br />
        <asp:Button ID="ButtonMakeOutboundCall" runat="server" OnClick="ButtonMakeOutboundCall_Click" Text="Give me a call" />
    
    </div>
    </form>
</body>
</html>
