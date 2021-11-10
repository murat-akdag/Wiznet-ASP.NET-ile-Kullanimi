using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EthernetShieldAsp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        Socket istemciBaglantisi;
        NetworkStream agAkisi;
        StreamWriter yazici;
        BinaryReader okuyucu;
        BinaryWriter binaryYazici;
        string alinanMetin;
        public static bool isBagli=false;

        

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        
        protected void btnBaglan_Click(object sender, EventArgs e)
        {
            if (isBagli == true)
            {
                Response.Write("<script>alert('Zaten mevcut bir bağlanti var...')</script>");
            }
            
            else
            {
                try
                {
                    istemciBaglantisi = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                    istemciBaglantisi.Connect(IPAddress.Parse(txtIP.Text), int.Parse(txtPort.Text));
                    
                    //görseller 
                    btnYak.Enabled = true;
                    trckbar1.Enabled = true;
                    timer1.Enabled = true;
                    Label2.Enabled = true;
                    btnYolla.Enabled = true;
                    btnSondur.Enabled = true;
                    txtIP.Enabled = false;
                    txtPort.Enabled = false;
                    isBagli = true;

                    Response.Write("<script>alert('Bağlantı Sağlandı, © Murat Akdağ')</script>");

                    Label4.Text = "Bağlantı Var";
                    Label4.ForeColor = Color.Green;
                    //
                }
                catch (SocketException)
                {
                    Response.Write("<script>alert('Yanlış ip veya port numarası...')</script>");
                }
            }
        }



        protected void btnBaglantiKes_Click(object sender, EventArgs e)
        {
            if (isBagli == true)
            {
                //görseller
                btnYak.Enabled = false;
                btnSondur.Enabled = false;
                trckbar1.Enabled = false;
                timer1.Enabled = false;
                Label2.Enabled = false;
                btnYolla.Enabled = false;
                isBagli = false;
                txtIP.Enabled = true;
                txtPort.Enabled = true;
                //

                Response.Write("<script>alert('Bağlantı Kesildi,© Murat Akdağ')</script>");
                Label4.Text = "Bağlantı Yok";
                Label4.ForeColor = Color.Red;
            }
            else
            {
                Response.Write("<script>alert('Zaten bağlantı yok...')</script>");
            }
        }



        protected void btnYak_Click(object sender, EventArgs e)
        {
            byte R = byte.Parse(String.Format("{0}", Request.Form["rgb_r"]));
            byte G = byte.Parse(String.Format("{0}", Request.Form["rgb_g"]));
            byte B = byte.Parse(String.Format("{0}", Request.Form["rgb_b"]));
            Yazdir("c" + (255 - R) + "r" + (255 - G) + "g" + (255 - B) + "b");
        }
      

        protected void servo_changed(object sender, EventArgs e)
        {
                Label2.Text = trckbar1.Text;
                Yazdir("s" + trckbar1.Text);
        }

        protected void btnYolla_Click(object sender, EventArgs e)
        {
                Yazdir("y" + txtYazi.Text);
                txtYazi.Text = "";
        }

        
        protected void Unnamed1_Tick(object sender, EventArgs e)
        {
            if (isBagli == true)
            {
                lblDerece.Text = "";
                istemciBaglantisi = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                istemciBaglantisi.Connect(IPAddress.Parse(txtIP.Text), int.Parse(txtPort.Text));
                agAkisi = new NetworkStream(istemciBaglantisi);
                binaryYazici = new BinaryWriter(agAkisi);
                binaryYazici.Write("t");
             
                try
                {
                    okuyucu = new BinaryReader(agAkisi);
                    alinanMetin = okuyucu.ReadString();
                    lblDerece.Text = alinanMetin;
                    binaryYazici.Flush();
                    binaryYazici.Close();
                    okuyucu.Close();
                }
                catch (EndOfStreamException)
                {
                    
                }
               
                istemciBaglantisi.Close();
            }
        }

        protected void btnSondur_Click(object sender, EventArgs e)
        {
            Yazdir("c" + (255) + "r" + (255) + "g" + (255) + "b");
        }

        private void Yazdir(string veri)
        {
            istemciBaglantisi = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            istemciBaglantisi.Connect(IPAddress.Parse(txtIP.Text), int.Parse(txtPort.Text));
            agAkisi = new NetworkStream(istemciBaglantisi);
            yazici = new StreamWriter(agAkisi);

            yazici.Write(veri);
            yazici.Flush();
            yazici.Close();
            istemciBaglantisi.Close();
        }
    }
}