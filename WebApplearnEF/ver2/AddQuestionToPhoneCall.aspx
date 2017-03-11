<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestionToPhoneCall.aspx.cs" Inherits="WebApplearnEF.ver2.AddQuestionToPhoneCall" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <strong>Page to add a question to Phone Call </strong>
        <br />
        <br />
        Phone Lesson ID:
    
        <asp:Label ID="LabelDisplayPhLessonID" runat="server"></asp:Label>
    
        <br />
        <br />
        Please select 1 question to add from the below table to the above Phone Call<br />
        <asp:GridView ID="GridView1" runat="server" >
                         <Columns>

                <asp:TemplateField HeaderText="QuestionNo" >
                    <ItemTemplate >                 
                         <a href='<%# GetStatusString(Eval("QuestionNo").ToString())%>'>Add</a>
                    </ItemTemplate>
                </asp:TemplateField>
      </Columns>

        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
