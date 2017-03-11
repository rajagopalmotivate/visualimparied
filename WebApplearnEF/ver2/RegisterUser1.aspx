<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterUser1.aspx.cs" Inherits="WebApplearnEF.ver2.RegisterUser1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <script>
        function ShowCal() {
            var elem = document.getElementById('Button1');



                elem.style.visibility = "hidden";
                elem.style.display = "none";


                var elemlabel = document.getElementById('Label1');



                elemlabel.textContent = "please wait";
            
        }
    </script>
</head>
<body>
    <p>
        <br />
    </p>
    <p>
        <strong>If you first time here, please register </strong>
    </p>
    <form id="form1" runat="server">
    <div>
    
        <strong>Register</strong>
        <br />
        <br />
        <br />
        Your phone:
        <asp:TextBox ID="TextBoxPhone" runat="server" Width="253px"></asp:TextBox>
        <br />
        Your email:
        <asp:TextBox ID="TextBoxEmail" runat="server" Width="252px"></asp:TextBox>
        <br />
        Your name:
        <asp:TextBox ID="TextBoxName" runat="server" Width="254px"></asp:TextBox>
        <br />
        Your city:
        <asp:DropDownList ID="DropDownListLocationCity" runat="server" Height="16px" Width="197px">
            <asp:ListItem>Bangalore</asp:ListItem>
            <asp:ListItem>Delhi</asp:ListItem>
            <asp:ListItem>Chennai</asp:ListItem>
        </asp:DropDownList>
        <br />
        Your school:<asp:DropDownList ID="DropDownListSchoolName" runat="server" Height="16px" Width="222px">
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Register"  OnClientClick="ShowCal()" OnClick="Button1_Click"  />
    
    &nbsp;&nbsp;
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" NavigateUrl="login1.aspx" runat="server"></asp:HyperLink>
    
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
