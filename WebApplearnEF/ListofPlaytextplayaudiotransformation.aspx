<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListofPlaytextplayaudiotransformation.aspx.cs" Inherits="WebApplearnEF.ListofPlaytextplayaudiotransformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
    
    </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="dummyindex" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="Lang" HeaderText="Lang" SortExpression="Lang" />
                <asp:BoundField DataField="playtext" HeaderText="playtext" SortExpression="playtext" />
                <asp:TemplateField HeaderText="playaudioURL" SortExpression="playaudioURL">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("playaudioURL") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("playaudioURL") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="dummyindex" HeaderText="dummyindex" InsertVisible="False" ReadOnly="True" SortExpression="dummyindex" />
                <asp:HyperLinkField DataNavigateUrlFields="dummyindex" DataNavigateUrlFormatString="ver2/Lplaytextplayaudioequivalent.aspx?dummyindex={0}" DataTextField="dummyindex" DataTextFormatString="{0}" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=visualimpariedlearning.database.windows.net;Initial Catalog=learnthinksavedb;Persist Security Info=True;User ID=mystudent;Password=Jesus123;MultipleActiveResultSets=True;Application Name=EntityFramework" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [playtextplayaudio] WHERE ([Lang] = @Lang) ORDER BY [dummyindex]">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="en-HI" Name="Lang" QueryStringField="lang" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
