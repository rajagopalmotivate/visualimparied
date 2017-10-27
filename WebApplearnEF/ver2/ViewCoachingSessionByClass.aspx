<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCoachingSessionByClass.aspx.cs" Inherits="WebApplearnEF.ver2.ViewCoachingSessionByClass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script>
        function DisableButtonInJavascriptClient() {
            var elem = document.getElementById('ButtonAddnewRow');
            elem.style.visibility = "hidden";
            elem.style.display = "none";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
                    <asp:Label ID="DisplayLabelSavedStaus" runat="server" Text=""></asp:Label>
        <br />
        <br />
    
        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Subject</td>
                <td>
                    <asp:DropDownList ID="DropDownListSubject" runat="server">
                        <asp:ListItem>MATH</asp:ListItem>
                        <asp:ListItem>SCIENCE</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>class</td>
                <td>
                    <asp:DropDownList ID="DropDownListClass" runat="server">
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Board</td>
                <td>
                    <asp:DropDownList ID="DropDownListBoard" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem>CBSE</asp:ListItem>
                        <asp:ListItem>StatePunjab</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Lang (medium of instruction) </td>
                <td>
                    <asp:DropDownList ID="DropDownListLang" runat="server">
                        <asp:ListItem Value="EN-IN">English (India) (en-IN)</asp:ListItem>
                        <asp:ListItem Value="HI-IN">हिन्दी (भारत) (en-HI)</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="ButtonFindCoachingClasses" runat="server" OnClick="ButtonFindCoachingClasses_Click" Text="Find Coaching Classes" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
        <p>
                    <asp:Label ID="LabelDisplay" runat="server" Text=""></asp:Label>
                </p>
        <p>
                    <asp:Label ID="LabelDisplay2" runat="server" Text=""></asp:Label>
        </p>
        <p>
                    <asp:Label ID="DisplayLabel3" runat="server" Text=""></asp:Label>
                </p>
        <p>
                    <asp:GridView ID="GridView2"  ItemType="WebApplearnEF.ver2.PhoneCoachingPlanListofSessionsTAB" runat="server" AutoGenerateColumns="false" >
             <Columns>
                <asp:DynamicField DataField="Board" AccessibleHeaderText="Board"  HeaderText="Board" />
                <asp:DynamicField DataField="Lang" AccessibleHeaderText="Lang"  HeaderText="Language" />
                <asp:DynamicField DataField="ClassStd" AccessibleHeaderText="ClassStd"  HeaderText="Class Std" />
                <asp:DynamicField DataField="PhCoachSessionNo" AccessibleHeaderText="PhCoachSessionNo" HeaderText="Day (Phone Coaching Session No)" />
                <asp:TemplateField HeaderText="What the student will learn in this phone call" >
                    <ItemTemplate >                 
                         <a href='<%# DataBinder.Eval(Container.DataItem, "PhLessonID", "WhatisInaPhoneCoachingSession.aspx?PhLessonID={0}") %>'>Details</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:DynamicField DataField="ListofQuestionsXML" AccessibleHeaderText="ListofQuestionsXML" HeaderText="List of Questions during this phone call (ListofQuestionsXML)" />
                <asp:DynamicField DataField="PhLessonID" AccessibleHeaderText="PhLessonID" HeaderText="Unique Lesson ID" />

            </Columns>
                    </asp:GridView>
                </p>
        <p>
                    &nbsp;</p>
        <p>
                    <asp:Label ID="DisplayLabelTextBeforeNoCoachingDays" runat="server" Text=""></asp:Label>
                    <asp:Label ID="DisplayLabelNoCoachingDays" runat="server" Text=""></asp:Label>
        </p>
        <p>
                    <asp:Button ID="ButtonAddnewRow" runat="server" OnClientClick=" DisableButtonInJavascriptClient()"  Visible="false" Text="Click this to Add another day of coaching for this standard" OnClick="ButtonAddnewRow_Click" />
        </p>
        <p>
                    &nbsp;</p>
        <p>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </p>
    </form>
</body>
</html>
