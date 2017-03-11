<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditaQuestion.aspx.cs" Inherits="WebApplearnEF.ver2.EditaQuestion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <p>
        <br />
    </p>
    <p>
        &nbsp;</p>
    <form id="form1" runat="server">
        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Question (Audio Recording or Text)</td>
                <td>
                    <table style="width:100%;">
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
                            <td>
                                <asp:RadioButtonList ID="RadioButtonListQuestionOption" runat="server">
                                    <asp:ListItem Value="0">Use Audio Recording</asp:ListItem>
                                    <asp:ListItem Value="1">Use Text </asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Question (Audio Recording)</td>
                <td>
                    <asp:HyperLink ID="HyperLinkQuestionRecordAudioNow" runat="server">Record audio now</asp:HyperLink>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Question (Text)</td>
                <td>
                    <asp:TextBox ID="TextBoxQuestion" runat="server" Height="64px" TextMode="MultiLine" Width="537px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="ButtonSave" runat="server" Text="Save changes" OnClick="ButtonSave_Click" />
                    <asp:Label ID="LabelDisplaySaved" runat="server" Text=""></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    <div>
    
        &nbsp;&nbsp;&nbsp;&nbsp;
    
    </div>
    </form>
</body>
</html>
