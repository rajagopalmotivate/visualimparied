<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WhatisInaPhoneCoachingSession.aspx.cs" Inherits="WebApplearnEF.ver2.WhatisInaPhoneCoachingSession" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Phone Lesson ID:
    
        <asp:Label ID="LabelDisplayPhLessonID" runat="server"></asp:Label>
    
        <br />
    
        <asp:Label ID="LabelDisplay" runat="server" Text=""></asp:Label>
    
    </div>
        <asp:Label ID="LabelDiplay2" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server"></asp:HyperLink>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" Height="119px" TextMode="MultiLine" Width="347px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
              <asp:GridView ID="GridView1" runat="server"             ItemType="WebApplearnEF.ver2.ListofQuestionsWithDetailsofEachQuestionTAB"             DataKeyNames="QuestionNo" AutoGenerateColumns="False"             >
            <Columns>
                <asp:DynamicField DataField="QuestionNo" AccessibleHeaderText="Question Number" HeaderText="Question No" />
                <asp:DynamicField DataField="QuestionType" AccessibleHeaderText="Question Type" HeaderText="Question Type" />
                <asp:DynamicField DataField="E1QuestionText" AccessibleHeaderText="Question Text"  HeaderText="Question Test" />
                <asp:DynamicField DataField="E2Option1Text" AccessibleHeaderText="Answer Choice 1"  HeaderText="Choice 1" />
                <asp:DynamicField DataField="E3Option2Text" AccessibleHeaderText="Answer Choice 2"  HeaderText="Choice 2" />
                <asp:DynamicField DataField="E4Option3Text" AccessibleHeaderText="Answer Choice 3" HeaderText="Choice 3" />
                <asp:TemplateField>
                    <ItemTemplate>                 
                         <a href='<%# DataBinder.Eval(Container.DataItem, "QuestionNo", "details.asp?id={0}") %>'>See Details</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </p>
        <p>
              &nbsp;</p>
        <p>
              You can add a new question or change the sequence of questions </p>
        <p>
              <asp:Button ID="ButtonAddNewQuestionTocall" runat="server" OnClick="ButtonAddNewQuestionTocall_Click" Text="Add another question to this phone call" Width="424px" />
        &nbsp;<asp:HyperLink ID="HyperLinkAddAnotherQuestion" runat="server">Add another question to this phone call</asp:HyperLink>
        </p>
        <p>
              <asp:Button ID="ButtonChangeSequence" runat="server" Text="Change the sequence of questions asked in this phone call" />
        &nbsp;<asp:HyperLink ID="HyperLinkChangeSequenceofQuestionsForaPhCoachingSession" runat="server">Change Sequence of Questions</asp:HyperLink>
        </p>
        <p>
              &nbsp;</p>
    </form>
</body>
</html>
