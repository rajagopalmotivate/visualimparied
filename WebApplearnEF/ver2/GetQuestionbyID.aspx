<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetQuestionbyID.aspx.cs" Inherits="WebApplearnEF.ver2.GetQuestionbyID" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <p>
        See details of a Question given Unique Question ID<br />
    </p>
    <form id="form1" runat="server">
        <p>
            Question Id :
            <asp:Label ID="LabelQuestionId" runat="server" Text=""></asp:Label>
        </p>
    <div>
    
        <asp:FormView ID="FormView1" runat="server">
        </asp:FormView>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    
        <asp:HyperLink ID="HyperLinkEdit" runat="server">Edit this Question</asp:HyperLink>
    
    </div>
    </form>
</body>
</html>
