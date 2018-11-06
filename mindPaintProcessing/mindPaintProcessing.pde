import processing.sound.*;
import controlP5.*;
import processing.serial.*;
Serial myPort;
 
 
int payloadLength = 0;
 
int Delta;
int Theta;
int LoAlpha;
int HiAlpha;
int LoBeta;
int HiBeta;
int LoGamma;
int MidGamma;
int Attn;
int Med;
int LineCounter;
 
String reportString;
 
void setup(){
  //fullScreen();
  size(1060,720);
  background(0);
  printArray(Serial.list());
  frameRate(2000); 
  myPort = new Serial(this, Serial.list()[0],57600); //[0]=COM8
//  LineCounter = 0;
}
 
void draw(){
 
   if(myPort.read() == 170){
    if(myPort.read() == 170){
 
      reportString = "";
 
      int inBytePayloadLen = myPort.read();
 
      if(inBytePayloadLen == 32){
 
        byte[] inBuffer = new byte[32];
        while (myPort.available() > 0) {
            inBuffer = myPort.readBytes();
            myPort.readBytes(inBuffer);
            if (inBuffer != null) {
 
              Delta = int(inBuffer[5]);      //deep sleep
              Theta = int(inBuffer[8]);      //meditation & sleep
              LoAlpha = int(inBuffer[11]);    //imagination
              HiAlpha = int(inBuffer[14]);    //intuition
              LoBeta = int(inBuffer[17]);    //alertness
              HiBeta = int(inBuffer[20]);    //stress
              LoGamma = int(inBuffer[23]);    //info processing
              MidGamma = int(inBuffer[26]);    //insight
              Attn = int(inBuffer[29]);      //attention 
              Med = int(inBuffer[31]);      //meditation
 
            }
        }
        background(LoBeta);
        translate(width/2,height/2);
        fill(HiAlpha,LoBeta,MidGamma);
        beginShape();           //draw a shape based on the rhodeona curve using the mind readings as variables
        for (float a = 0; a < TWO_PI*8; a += 0.01) {
          float r = 200 * cos(Delta*a); 
          float x = r * (cos(a))*(Theta/4);
          float y = r * (sin(a))*(LoAlpha/4);
        
        if ((Attn>=0)&&(LoGamma>=0)&&(MidGamma>=0)){
          stroke(Attn,LoGamma,MidGamma);    
            }else{
          stroke(255);
            }
        strokeWeight(1);
        vertex(x,y);
        }
        endShape();
 /*
        noStroke();
        fill(0);
        rect(float(LineCounter),0,1,250);
 
        //Do Delta
        fill(255,0,0);
        rect(float(LineCounter),25 - (Delta / 10),1,Delta / 10);
 
        //Do Theta
        rect(float(LineCounter),50 - (Theta / 10),1,Theta / 10);
 
        //Do Low Alpha
        rect(float(LineCounter),75 - (LoAlpha / 10),1,LoAlpha / 10);
 
        //Do High Alpha
        rect(float(LineCounter),100 - (HiAlpha / 10),1,HiAlpha / 10);
 
        //Do Low Beta
        rect(float(LineCounter),125 - (LoBeta / 10),1,LoBeta / 10);
 
        //Do High Beta
        rect(float(LineCounter),150 - (HiBeta / 10),1,HiBeta / 10);
 
        //Do Low Gamma
        rect(float(LineCounter),175 - (LoGamma / 10),1,LoGamma / 10);
 
        //Do Mid Gamma
        rect(float(LineCounter),200 - (MidGamma / 10),1,MidGamma / 10);
 
        //Do Attention
        fill(0,255,0);
        rect(float(LineCounter),225 - (Attn / 10),1,Attn / 10);
 
        //Do Meditation
        fill(255,255,0);
        rect(float(LineCounter),250 - (Med / 10),1,Med / 10);
 
        LineCounter++;
        if(LineCounter > 600){
          LineCounter = 0;
 */       }
      }
    }
   }
//}
