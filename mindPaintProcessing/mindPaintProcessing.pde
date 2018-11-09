import processing.sound.*;                            //used for camera feedback sound as well as future sound options
import controlP5.*;                                   //to ease the transition from p5 to Processing
import processing.serial.*;

Serial myPort;
SoundFile file;

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
String noSignal = "Press 'n' to see your brain numbers and other options.";
String filename = "mindPainter####.jpg";                //####=frameCount when the screenshots were taken
String title = "MindPainter";
String pressStart = "Please wait while your brain gathers its art supplies...";

boolean screenShotHasRun;
boolean showReadings;
boolean mediMode;

void setup(){
  //fullScreen();                                       //slows down the program 
  font = createFont("Proxima Nova", 16, true);          //Proxima Nova is the best font ¯\_(-_-)_/¯
  textFont(font);
  size(1060,730);                                       //comment this out if you want to run at fullscreen
  background(0);
  printArray(Serial.list());                            //prints out all serial ports at startup
  frameRate(2000);
  myPort = new Serial(this, Serial.list()[0],57600);    //[0]=COM6 for me
  screenShotHasRun = false;
  showReadings = false;
  mediMode = false;
  file = new SoundFile(this,"cameraClick.mp3");
}
 
void draw(){
   showConsole();
   screenShot();  
   consoleMessages();
   switchModes();

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
               
              Delta = int(inBuffer[5]);      //deep sleep /visual processing
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
    if (mediMode == true){
      meditationMode();
    } else {
      drawShape();
    }
    //************************************************************************************
      }//closes if bytepayload==32
    }//closes if myport reads 170 
  }
}

void drawShape(){                                       //draw a shape based on the rhodeona curve using the mind readings as variables
   if(millis()-timer>=2000){                             //redraw the screen with what is read every 2 secs
        background(Med);                               //background should get brighter based on the user's meditation 
        translate(width/2,height/2);                     //centre the shape on the screen
        fill(HiAlpha,LoBeta,MidGamma);                    //(HiAlpha,LoBeta,MidGamma)
        beginShape();           
        for (float a = 0; a < TWO_PI*16; a += 0.01) { //shape should get more complex the higher the user's meditation
                                                           //the multiplier of TWO_PI(8 as of writing) should be a single integer, not a variable
                                                           //the number that the cosine is multiplied by (200 as of writing) should be a single integer, not a variable
          float r = (200) * cos(Delta*a);                   //base for generating vertex points
          float x = r * (cos(a))*(Theta*HiAlpha);            //vertex points
          float y = r * (sin(a))*(LoAlpha*HiBeta);         //vertex points
        
        if ((LoAlpha>=0)&&(LoGamma>=0)&&(MidGamma>=0)){
          stroke(LoAlpha,LoGamma,HiBeta);                  //(R,G,B)
            }else{
          stroke(255);
            }
        strokeWeight(1);
        vertex(x,y);
        }
        endShape();
        timer = millis();
  }//closes the timer if-statement 
} //closes the drawShape function

void consoleMessages(){
     if ((Delta<=1)||(Theta<=1)||(LoAlpha<=1)||(HiAlpha<=1)||(LoBeta<=1)||(HiBeta<=1)||(LoGamma<=1)||(MidGamma<=1)||(Attn<=1)||(Med<=1)){
          fill(151);
          textAlign(LEFT);
          text(waitingForData, 0,30);                       //if any sensor is reporting low or no data, write some text
        }
   if((Delta<=0)&&(Theta<=0)&&(LoAlpha<=0)&&(HiAlpha<=0)&&(LoBeta<=0)&&(HiBeta<=0)&&(LoGamma<=0)&&(MidGamma<=0)&&(Attn<=0)&&(Med<=0))
        {
          fill(151);
          textAlign(LEFT);
          text(noSignal, 0,50);                             //if no sensors are returning data, write some text
          textAlign(CENTER,CENTER);
          textSize(32);
          text(title,530,365);
          textSize(16);
          text(pressStart,530,390);
        }
    if(showReadings==true){
          fill(151);
          textAlign(LEFT);
          text("Delta:"+Delta, 0, 490);
          text("Theta:"+Theta,0,510);
          text("LoAlpha:"+LoAlpha,0,530);
          text("HiAlpha:"+HiAlpha,0,550);
          text("LoBeta:"+LoBeta,0,570);
          text("HiBeta:"+HiBeta,0,590);
          text("LoGamma:"+LoGamma,0,610);
          text("MidGamma:"+MidGamma,0,630);
          text("Attention:"+Attn,0,650);
          text("Meditation:"+Med,0,670);
          text("Press 'c' at any time to save your painting", 0, 690);
          text("Press 'm' to enter meditation mode and press 'q' to return to paint mode", 0, 710);
          text("Press any key to close", 0, 730);
//        println("CONSOLE OPEN");
      }
}// closes the function

void screenShot(){                                         //save the current frame to the sketch folder
  if (keyPressed){
    if((key=='c')&&(screenShotHasRun==false)){
      saveFrame(filename);
      file.play();                                         //play a camera shutter sound
      screenShotHasRun=true;                               //prevent a held key from taking lots of screenshots
      println("Screenshot saved!");
     }
  }
}
void showConsole() {
  if (keyPressed){    
    if(key=='n'){
      showReadings = true;
 //     println("Console ON");
    } else {
      showReadings = false;
    }
  }
}
void switchModes(){
  if (keyPressed){
    if(key == 'm'){
      mediMode = true;
//      println("Meditation Mode Activated");
    } else if ((key == 'q')){
      mediMode = false;
//      println("Meditation Mode Deactivated");
      } 
    }
  }
void keyReleased(){
   if ((key=='c')&&(screenShotHasRun==true)){
      screenShotHasRun=false;                             //allow screenShot to run again once the key is released
//      println("C Released");
   }
}
void meditationMode(){                                       
   if(millis()-timer>=2000){                             
        background(Med);                               
        translate(width/2,height/2);                     
        fill(HiAlpha,LoBeta,MidGamma);                    
        beginShape();           
        for (float a = 0; a < TWO_PI*8; a += 0.01) { 
          float r = (200) * cos(Attn*a);                   
          float x = r * (cos(a))*(Med);             
          float y = r * (sin(a))*(Med);         
        
        if ((LoAlpha>=0)&&(LoGamma>=0)&&(MidGamma>=0)){
          stroke(LoAlpha,LoGamma,HiBeta);                  
            }else{
          stroke(255);
            }
        strokeWeight(1);
        vertex(x,y);
        }
        endShape();
        timer = millis();
  }//closes the timer if-statement 
} //closes the meditationMode function
