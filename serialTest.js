var myPort = 'COM6'; 

var payloadLength = 0;

var Delta;
var Thetal
var LoAlpha;
var HiAlpha;
var LoBeta;
var HiBeta;
var LoGamma;
var MidGamma;
var Attn;
var Med;

//String reportString;

function setup(){
  createCanvas(windowWidth,windowHeight);
  background(0);
  //printArray(Serial.list());
  frameRate(2000); 
  serial = new p5.SerialPort();       //create the serial port object
  serial.open(myPort); 
//    myPort = new Serial(this, Serial.list()[0],57600); //[0]=COM8
}

function draw(){
   //  if(myPort.read() == 170){
    //if(myPort.read() == 170){
 
    //  reportString = "";
    if (serial.on){
 
      var inBytePayloadLen = myPort.read();
 
      if(inBytePayloadLen == 32){
 
        //byte[] inBuffer = new byte[32];
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
        for (var a = 0; a < TWO_PI*8; a += 0.01) {
          var r = 200 * cos(Delta*a); 
          var x = r * (cos(a))*(Theta/4);
          var y = r * (sin(a))*(LoAlpha/4);
        
        if ((Attn>=0)&&(LoGamma>=0)&&(MidGamma>=0)){
          stroke(Attn,LoGamma,MidGamma);    
            }else{
          stroke(255);
            }
        strokeWeight(1);
        vertex(x,y);
        }
        endShape();
            }
        }
     }