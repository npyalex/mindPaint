import processing.sound.*;  //not used yet. for adding sound playback options later.
import controlP5.*;         //to ease the transition from p5 to Processing
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

int timer; 

PFont font;
 
String reportString;
String waitingForData = "Low Reception. Please Be Patient.";
String noSignal = "Waiting for Brain Data.";
String filename = "mindPainter####.jpg"; //####=frameCount when the screenshots were taken

boolean screenShotHasRun = false;

void setup(){
  //fullScreen(); //slows down the program 
  font = createFont("Proxima Nova", 16, true);  //Proxima Nova is the best font ¯\_(-_-)_/¯
  textFont(font);
  size(1060,730); //comment this out if you want to run at fullscreen
  background(0);
  printArray(Serial.list());
  frameRate(2000); 
  myPort = new Serial(this, Serial.list()[0],57600); //[0]=COM6
}
 
void draw(){
   screenShot();
   consoleMessages();    

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
/*              
      print("Delta"+" "+ Delta+", ");
      print("Theta"+" "+ Theta+", ");
      println("LoAlpha"+" "+ LoAlpha+", ");
      print("HiAlpha"+" "+ HiAlpha+", ");
      print("LoBeta"+" "+ LoBeta+", ");
      println("HiBeta"+" "+ HiBeta+", ");
      print("LoGamma"+" "+ LoGamma+", ");
      print("MidGamma"+" "+ MidGamma+", ");
      println("Attn"+" "+ Attn+", ");
      println("Med"+" "+ Med);
*/
                  
               
          }//closes the if data received statement
        }//closes while myport.available
    //*******Draw functions must be in here to properly align with brain readings!**********   
    drawShape();
    //************************************************************************************
      }//closes if bytepayload==32
    }//closes if myport reads 170 
  }

}

void drawShape(){ //draw a shape based on the rhodeona curve using the mind readings as variables
   if(millis()-timer>=2000){ //redraw the screen with what is read every 2 secs
        background(Med); //background should get brighter the higher the user's attention(using Attn)
        translate(width/2,height/2);
        fill(HiAlpha,LoBeta,MidGamma); //(HiAlpha,LoBeta,MidGamma)
        beginShape();           
        for (float a = 0; a < TWO_PI*8; a += 0.01) { //shape should get more complex the higher the user's meditation
 //the multiplier of TWO_PI(8 as of writing) should be a single integer, not a variable
 //the number that the cosine is multiplied by (200 as of writing) should be a single integer, not a variable
          float r = (200) * cos(Attn*a);  //base for generating vertex points - using Med*a
          float x = r * (cos(a))*(Theta*HiAlpha); //vertex points - using Theta/2 
          float y = r * (sin(a))*(LoAlpha*HiBeta); //vertex points - using LoAlpha/2
        
        if ((LoAlpha>=0)&&(LoGamma>=0)&&(MidGamma>=0)){
          stroke(LoAlpha,LoGamma,HiBeta);    //(LoAlpha,LoGamma,HiBeta)
            }else{
          stroke(255);
            }
        strokeWeight(1);
        vertex(x,y);
        }
        endShape();
        timer = millis();
  }//closes the timer if-statement 
} //closes the function

void consoleMessages(){
     if ((Delta<=1)||(Theta<=1)||(LoAlpha<=1)||(HiAlpha<=1)||(LoBeta<=1)||(HiBeta<=1)||(LoGamma<=1)||(MidGamma<=1)||(Attn<=1)||(Med<=1)){
          fill(151);
    //      translate(0,0);
          textAlign(LEFT);
          text(waitingForData, 0,30); //if any sensor is reporting low or no data, write some text
        }
   if((Delta<=0)&&(Theta<=0)&&(LoAlpha<=0)&&(HiAlpha<=0)&&(LoBeta<=0)&&(HiBeta<=0)&&(LoGamma<=0)&&(MidGamma<=0)&&(Attn<=0)&&(Med<=0))
        {
          fill(151);
   //       translate(0,0);
          textAlign(LEFT);
          text(noSignal, 0,50); //if no sensors are returning data, write some text
        }
}// closes the function

void screenShot(){ //save the current frame to the sketch folder
  if (keyPressed){
    if((key=='c')&&(screenShotHasRun==false)){
      saveFrame(filename);
      screenShotHasRun=true; //prevent a held key from taking lots of screenshots
      println("Screenshot saved!");
   }
  }
}
void keyReleased(){
    if ((key=='c')&&(screenShotHasRun==true)){
      screenShotHasRun=false; //allow screenShot to run again once the key is released
//      println("C Released");
    }
}
