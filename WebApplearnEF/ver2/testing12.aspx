<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing12.aspx.cs" Inherits="WebApplearnEF.ver2.testing12" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:GridView ID="GridView1" runat="server" SelectMethod="GridView1_GetData"              ItemType="WebApplearnEF.ver2.ListofQuestionsWithDetailsofEachQuestionTAB"             DataKeyNames="QuestionNo" AutoGenerateColumns="False"             >
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
            <EmptyDataTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
            </EmptyDataTemplate>
        </asp:GridView>
    </form>
</body>
</html>
