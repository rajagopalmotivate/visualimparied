<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewListofQuestionsTAB.aspx.cs" Inherits="WebApplearnEF.ver2.ViewListofQuestionsTAB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        </div>
        <p>
            Look for the question you just added, and click it to continue editing the question. </p>
        <p>
            This is list of most recently added questions, with the most recent one at the 1st item in this table</p>
        <p>
            <asp:GridView ID="GridView1" runat="server" >
             <Columns>
                <asp:TemplateField>
                    <ItemTemplate>                 
                         <a href='<%# DataBinder.Eval(Container.DataItem, "QuestionNo", "GetQuestionbyID.aspx?QuestionNo={0}") %>'>See Details</a>
                    </ItemTemplate>
                </asp:TemplateField>
               </Columns>
            </asp:GridView>
        </p>
        <p>
    
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Incase you can't find the question ?" />
    
        </p>
    </form>
</body>
</html>
