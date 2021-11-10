#include <Servo.h>
Servo myservo;
#include <SPI.h>
#include <Ethernet.h>
#include <LiquidCrystal.h>

byte mac[]={0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
IPAddress ip(169, 254, 17, 14);
EthernetServer server(8080);
LiquidCrystal lcd(A4, 8, 7, A1, A2, A3);

EthernetClient client;
String veri="";

void setup() {
  myservo.attach(9);
  Serial.begin(9600);
  Ethernet.begin(mac, ip);
  lcd.begin(16, 2);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
  pinMode(3,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
}

void loop() {
  char secim;
  client = server.available();
  if(client)
  {
      veri="";
      while(client.available())
      {
        char c=client.read();
        if(((int)c)==1)
          continue;
        veri+=c;
      }
        secim=veri[0];
        Serial.println(secim);
  }

  switch(secim)
  {
    case 'c':
    {
      int index1=veri.indexOf('r');
      int index2=veri.indexOf('g');
      Serial.println(veri);
      analogWrite(3,(veri.substring(1,index1).toInt()));
      analogWrite(5,(veri.substring(index1+1,index2)).toInt());
      analogWrite(6,(veri.substring(index2+1,veri.length()-1)).toInt());
    }
      break;

    case 's':
    {
      Serial.println(veri.substring(1,4).toInt());
      myservo.write(veri.substring(1,4).toInt());
    }
      break;

    case 'y':
    {
      lcd.clear();
      lcd.print(veri.substring(1,veri.length()));
      Serial.println(veri+"Bu yazidir");
    }
      break;

    case 't':
    {
      float derece=(((analogRead(A0)/1023.0)*5000)/10.0);
      termometre(derece);
    }
      break;  
  }
}

 void termometre(float derece){
    while(client.connected())
    {
      client.println();
      client.println();
      client.println();
      client.println();
      client.println();
      client.println(derece);
    }
  }







