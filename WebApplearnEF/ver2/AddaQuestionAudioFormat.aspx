<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddaQuestionAudioFormat.aspx.cs" Inherits="WebApplearnEF.ver2.AddaQuestionAudioFormat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div>
    
        <strong>Add a Question to the Database</strong><br />
        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td>
                    Please be ready with all the audio recordings before proceeding</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Label ID="LabelInvalidInput" runat="server" Text="" ForeColor="#FF3300"></asp:Label>
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
                <td>Language (Medium of Instruction)</td>
                <td>
                    <asp:DropDownList ID="DropDownListLang" runat="server">
                        <asp:ListItem Value="en-IN">English (India) (en-IN)</asp:ListItem>
                        <asp:ListItem Value="hi-IN">हिन्दी (भारत) (hi-IN)</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Board</td>
                <td>
                    <asp:DropDownList ID="DropDownListBoard" runat="server">
                        <asp:ListItem Value="CBSE">CBSE</asp:ListItem>
                        <asp:ListItem Value="TN">TN</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Subject</td>
                <td>
                    <asp:DropDownList ID="DropDownListSubject" runat="server">
                        <asp:ListItem Value="MATH">MATH</asp:ListItem>
                        <asp:ListItem Value="SCIENCE">SCIENCE</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Question targeted for students in class </td>
                <td>
                    <asp:DropDownList ID="DropDownListStandard" runat="server">
                        <asp:ListItem Value="1">Std 1</asp:ListItem>
                        <asp:ListItem Value="2">Std 2</asp:ListItem>
                        <asp:ListItem Value="3">Std 3</asp:ListItem>
                        <asp:ListItem Value="4">Std 4</asp:ListItem>
                        <asp:ListItem Value="5">Std 5</asp:ListItem>
                        <asp:ListItem Value="6">Std 6</asp:ListItem>
                        <asp:ListItem Value="7">Std 7</asp:ListItem>
                        <asp:ListItem Value="8">Std 8</asp:ListItem>
                        <asp:ListItem Value="9">Std 9</asp:ListItem>
                        <asp:ListItem Value="10">Std 10</asp:ListItem>
                        <asp:ListItem Value="11">Std 11</asp:ListItem>
                        <asp:ListItem Value="12">Std 12</asp:ListItem>
                        <asp:ListItem Value="10001">Bank Exam 1</asp:ListItem>
                        <asp:ListItem Value="10002">Bank Exam 2</asp:ListItem>
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
                <td>How many choices </td>
                <td>
                    <asp:DropDownList ID="DropDownListHowmanychoices" runat="server" OnSelectedIndexChanged="DropDownListHowmanychoices_SelectedIndexChanged">
                        <asp:ListItem Value="2">MCQ with 2 choices (true or false style)</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">MCQ with 3 choices</asp:ListItem>
                    </asp:DropDownList>
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
                <td>Question Unique ID</td>
                <td>
                    <asp:Label ID="QuestionUniqueID" runat="server" ForeColor="#3399FF" Font-Size="Large" style="font-weight: 700"></asp:Label>
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
                <td>Question</td>
                <td>
                    <asp:HyperLink ID="HyperLinkQuestion" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadQuestion" runat="server" />
                    <asp:Button ID="ButtonQuestion" runat="server" Text="Save" OnClick="ButtonQuestion_Click" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Answer Choice 1</td>
                <td>
                    <asp:HyperLink ID="HyperLinkOption1" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadOption1" runat="server" />
                    <asp:Button ID="ButtonOption1" runat="server" Text="Save" OnClick="ButtonOption1_Click" />
                </td>
            </tr>
            <tr>
                <td>Answer Choice 2</td>
                <td>
                    <asp:HyperLink ID="HyperLinkOption2" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadOption2" runat="server" />
                    <asp:Button ID="ButtonOption2" runat="server" Text="Save" OnClick="ButtonOption2_Click" />
                </td>
            </tr>
            <tr>
                <td>Answer Choice 3</td>
                <td>
                    <asp:HyperLink ID="HyperLinkOption3" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadOption3" runat="server" />
                    <asp:Button ID="ButtonOption3" runat="server" Text="Save" OnClick="ButtonOption3_Click" />
                </td>
            </tr>
            <tr>
                <td>Correct Answer (choice no)</td>
                <td>
                    <asp:DropDownList ID="DropDownListCorrectAnswer" runat="server">
                        <asp:ListItem Value="1">Answer Choice 1</asp:ListItem>
                        <asp:ListItem Value="2">Answer Choice 2</asp:ListItem>
                        <asp:ListItem Value="3">Answer Choice 3</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Hint (Plays on request)</td>
                <td>
                    <asp:HyperLink ID="HyperLinkHint" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadHint" runat="server" />
                    <asp:Button ID="ButtonHint" runat="server" Text="Save" OnClick="ButtonHint_Click" />
                </td>
            </tr>
            <tr>
                <td>Point to remember at the end of quiz</td>
                <td>
                    <asp:HyperLink ID="HyperLinkSummary" runat="server">Please upload audio</asp:HyperLink>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadSummary" runat="server" />
                    <asp:Button ID="ButtonSummary" runat="server" Text="Save" OnClick="ButtonSummary_Click" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="ButtonStep1InsertRow" runat="server" OnClick="ButtonStep1InsertRow_Click" Text="I confirm i have validated above inputs" Visible="False" />
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
                    <asp:Button ID="ButtonSubmit" runat="server" OnClick="ButtonSubmit_Click" Text="Submit Question to Database" Width="537px" />
                &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:HyperLink ID="HyperLinkSuccessClicktoContinue" runat="server">[HyperLinkSuccessClicktoContinue]</asp:HyperLink>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
