<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddaQuestion.aspx.cs" Inherits="WebApplearnEF.ver2.AddaQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <table style="width:100%;">
            <tr>
                <td>Language </td>
                <td>
                    <asp:DropDownList ID="DropDownListLang" runat="server">
                        <asp:ListItem Value="en-IN">English (India) (en-IN)</asp:ListItem>
                        <asp:ListItem Value="hi-IN">हिन्दी (भारत) (hi-IN)</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Type</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" Height="22px" Width="290px">
                        <asp:ListItem Value="MCQ">Multiple Choice Question (MCQ)</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Question</td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Height="64px" TextMode="MultiLine" Width="537px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Answer Choice 1</td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" Width="232px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Answer Choice 2</td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Width="236px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Answer Choice 2</td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" Width="234px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="ButtonSubmit" runat="server" OnClick="ButtonSubmit_Click" Text="Submit" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
