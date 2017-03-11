<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login1.aspx.cs" Inherits="WebApplearnEF.ver2.login1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-small;
        }
    </style>
    <script>
        function ShowCal() {
            var elem = document.getElementById('Button2');



                elem.style.visibility = "hidden";
                elem.style.display = "none";


                var elemlabel = document.getElementById('Label1');



                elemlabel.textContent = "please wait";
            
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <br />
        <strong>Login
        <br />
        <br />
        </strong>Login using your phone no .
        <br />
        </div>
        Phone no:
        <asp:TextBox ID="TextBox1" runat="server" Width="263px"></asp:TextBox>
        <br />
        <br />
        <span class="auto-style1">(Format: 9194441234544 or 91442424242)</span><br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" OnClientClick="ShowCal()" Text="Login Now" />
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>
