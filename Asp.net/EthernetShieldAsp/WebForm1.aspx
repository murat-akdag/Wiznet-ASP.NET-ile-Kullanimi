<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="EthernetShieldAsp.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="colorpicker.js"></script>
    <link rel="stylesheet" type="text/css" href="themes.css" />
    <link href="tasari.css" rel="stylesheet" />
</head>
<body>
    
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="container">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnYak" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="txtIP" />
                    <asp:AsyncPostBackTrigger ControlID="txtPort" />
                    <asp:AsyncPostBackTrigger ControlID="btnYolla" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="txtYazi" />
                    <asp:AsyncPostBackTrigger ControlID="btnSondur" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>


            <div id="divBaglan" class="divBaglan">
                <asp:Label ID="Label1" runat="server" Text="IP :"></asp:Label>
                <asp:TextBox ID="txtIP" runat="server" Width="111px">169.254.17.14</asp:TextBox>
                &nbsp;&nbsp;&nbsp; Port :
                 <asp:TextBox ID="txtPort" runat="server" Width="45px">8080</asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:Button ID="btnBaglan" runat="server" Text="Bağlan" Width="90px" OnClick="btnBaglan_Click"  CssClass="btnBaglanti"/>
                &nbsp;
                 <asp:Button ID="btnBaglantiKes" runat="server" Text="Bağlantıyı Kes" Width="100px" OnClick="btnBaglantiKes_Click" CssClass="btncikis"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label4" runat="server" Text="Durum"></asp:Label>
            </div>

            <div id="divLED" class="divLED">
                <div id="color-picker" class="cp-default"></div>

                <div id="io" class="io">
                    R: 
           <input id="rgb_r" name="rgb_r" type="number" value="0" aria-readonly="False" class="input" />
                    G:
           <input id="rgb_g" name="rgb_g" type="number" value="0" aria-readonly="False" class="input" />
                    B:
           <input id="rgb_b" name="rgb_b" type="number" value="0" aria-readonly="False" class="input" />
                    <br />
                    <br />
                    <asp:Button ID="btnYak" runat="server" Text="YAK" OnClick="btnYak_Click" Enabled="False" />
                    <asp:Button ID="btnSondur" runat="server" Text="SÖNDÜR" Enabled="False" OnClick="btnSondur_Click" />
                </div>
            </div>


            <div id="divMotor" class="divMotor">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:Image ID="Image1" runat="server" ImageUrl="~/apcnews2012masterclass_arduino_rolly_thumb_mainImage6.jpg6.jpg" Height="251px" Width="376px" />
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 
                  
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                     <ContentTemplate>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <asp:TextBox ID="trckbar1" runat="server" TextMode="Range" min="0" max="180" value="0" step="1" Width="254px" OnTextChanged="servo_changed" AutoPostBack="True" Enabled="False">0</asp:TextBox>
                         <asp:Label ID="Label2" runat="server" Enabled="False"></asp:Label>
                     </ContentTemplate>
                 </asp:UpdatePanel>
            </div>

            <div id="divLCD" class="divLCD">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/lcd_display.png" Height="145px" Width="402px" />
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <asp:TextBox ID="txtYazi" runat="server" Width="202px"></asp:TextBox>
                <asp:Button ID="btnYolla" runat="server" Text="YOLLA" Enabled="False" OnClick="btnYolla_Click"/>

                &nbsp;
            </div>

            <div id="divDerece" class="divDerece">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <br />
                        <asp:Label ID="lblDerece" CssClass="lblDerece" runat="server"></asp:Label>
                         <asp:Label ID="Label3"  runat="server" Font-Size="80px">°C</asp:Label>
                         <asp:Timer runat="server" Interval="5000" ID="timer1" Enabled="False" OnTick="Unnamed1_Tick"></asp:Timer>
                   </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </form>
    &nbsp;<script type="text/javascript">
              var iR = document.getElementById('rgb_r');
              var iG = document.getElementById('rgb_g');
              var iB = document.getElementById('rgb_b');
              var color = document.getElementById('color-picker');
              var iO = document.getElementById('io');
              var btn = document.getElementById('btnYak');

              function updateInputs(hex, hsv, rgb) {
                  iR.value = rgb.r;
                  iG.value = rgb.g;
                  iB.value = rgb.b;
                  btn.style.backgroundColor = hex;
              };
              ColorPicker(color, updateInputs);
    </script>
</body>
</html>
