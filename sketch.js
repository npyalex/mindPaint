/*
MindReader (working title)
by Nick Alexander for OCAD Digital Futures M.Des 2018

based on code by Kate Hartman & Nick Puckett for Creation & Computation
with inspiration from the incomparable Coding Train
*/




var serial;       //variable to hold the serial port object
var ardVal = [];  //array that will hold all values coming from arduino
//var dt = new Date('May 13, 1988 00:00:00');
var lastRead;   //= dt.getTime();
var refreshRate = 10;

var ran = false;
var serialPortName = 'COM4';        //FOR PC it will be COMX on mac it will be something like "/dev/cu.usbmodemXXXX"
                                    //Look at P5 Serial to see the available ports
function setup() {
  
  createCanvas(windowWidth,windowHeight);
  //Setting up the serial port
  serial = new p5.SerialPort();       //create the serial port object
  serial.open(serialPortName);        //open the serialport. determined 
  serial.on('open',ardCon);           //open the socket connection and execute the ardCon callback
  serial.on('data',dataReceived);     //when data is received execute the dataReceived function

  lastRead = frameCount;
}

function draw() 
{    
    var k=ardVal[0];                   //draws a shape based on the rhodeona curve
    var j=ardVal[1];                    //using external arduino inputs
    background(51);                     //TODO: background colour adjusted on the fly by an input
    translate(width/2,height/2)
    noFill();
    
    if (frameCount-lastRead>=refreshRate)// && (ran==false) //(millis()-lastRead>=sampleRate)
    {
    beginShape();
    for (var a = 0; a < TWO_PI*8; a += 0.01) {
        var r = 200 * cos(k*a); 
        var x = r * (cos(a)*j);
        var y = r * (sin(a)*j);
        stroke(135,206,250);                    //TODO: stroke colour adjusted on the fly by an input
        strokeWeight(1);
        vertex(x,y);
        lastRead = frameCount;
        }
    endShape();
 //   ran = true;
        }

    
console.log(frameCount-lastRead>=refreshRate);
}


function dataReceived()   //this function is called every time data is received
{
var rawData = serial.readStringUntil('\r\n'); //read the incoming string until it sees a newline
    if(rawData.length>1)                      //check that there is something in the string
    {                                         //values received in pairs  index,value
      var incoming = rawData.split(",");      //split the string into components using the comma as a delimiter
      for(var i=0;i<incoming.length;i++)
      {
      ardVal[i]=parseInt(incoming[i]);        //convert the values to ints and put them into the ardVal array
      }
    }
}

function ardCon()
{
  console.log("Connection Established");
}

//function getRandomInt(max) {
//  return Math.floor(Math.random() * Math.floor(max));
//}

function windowResized() 
{
    resizeCanvas(windowWidth, windowHeight);
}