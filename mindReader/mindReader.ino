/* Mind Reader 
 *  by
 *  Nick Alexander
 * 
 * Arduino code based on Creation & Computation 03 Arduino to P5
 *  by
 *  Kate Hartman / Nick Puckett
 */
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>

#define BNO055_SAMPLERATE_DELAY_MS (100)

Adafruit_BNO055 bno = Adafruit_BNO055();
imu::Vector<3> euler;

unsigned long lastRead;

long lastSend;                                               //used for the timer controlling the send rate
int sendDelay = 20;                                         //ms between data sends. required for proper functionality


const int potentiometer = A0; //potentiometer
const int lightPin = A1; //light sensor
const int switchPin = 7; //switch
int sensorVals[5];                                          //array used to hold the sensor values
                                                            //in this case it is initiated with [2] because there are
                                                            //2 sensor values to send. If you need to send 5 values you
int s1, s2, s3;                                                            //should iniate the array with [5]
int xEuler, yEuler, zEuler;



void setup() {

Serial.begin(9600);                                         //turn on the Serial port @ 9600 baud, this is the default for the P5 server

  /* Initialise the sensor */
  if (!bno.begin())
  {
    /* There was a problem detecting the BNO055 ... check your connections */
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while (1);
  }
 
  delay(1000);
  bno.setExtCrystalUse(true);
}

void loop() {

s1 = analogRead(potentiometer);
s2 = analogRead(lightPin);
//s3 = digitalRead(switchPin);

//checkToggle;
checkOrient();


sensorVals[0] = 100; //dummy - the first in the string is always returning NaN                           //read the sensor values and put them into the array
sensorVals[1] = map(s2,0, 1023,0, 255);                             //LX Sensor
sensorVals[2] = xEuler;                                             //x axis
sensorVals[3] = yEuler;                                             //y axis
sensorVals[4] = zEuler;                                             //z axis
sensorVals[5] = map(s1, 0,  1023, 0, 255);                          //potentiometer

sendData(sensorVals,(sizeof(sensorVals)/sizeof(int)), sendDelay);   //execute the sendData function
                                                                    //(sizeof(sensorVals)/sizeof(int)) is used because we are passing an
                                                                    //array into the function and arduino can't determine the size of the
                                                                    //array in that scope

}


void sendData(int sVal[], int arLength, int sDel)           //this is the function that sends data out the Serial port
{                                                           //the format is   "sensorvalue1,sensorvalue2,sensorvalue3,..."
    if(millis()-lastSend>=sDel)                             //simple timer controls how often it sends
    {
      for(int i=0;i<arLength;i++)                           //for loop is used to package up all the values in the array
      {
        if(i<arLength-1)                                    //this checks what to do if it ISN'T the last value
        {                                                   //it uses Serial.print and adds the comma to the string
        Serial.print(sVal[i]);                                
        Serial.print(",");
        }
          else
          {
          Serial.println(sVal[i]);                          //there is a different command for the final value
          }                                                 //we use Serial.println because the server looks for the newline character to know the end of the messages
      }                                                     //it also doesn't need the comma because it is the last value
      lastSend = millis();                                  //save the time that the value is sent, so the timer will work   
    } 
}    
void checkOrient(){
   // Possible vector values can be:
  // - VECTOR_ACCELEROMETER - m/s^2
  // - VECTOR_MAGNETOMETER  - uT
  // - VECTOR_GYROSCOPE     - rad/s
  // - VECTOR_EULER         - degrees
  // - VECTOR_LINEARACCEL   - m/s^2
  // - VECTOR_GRAVITY       - m/s^2

 imu::Vector<3> euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);
 
 // euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);

 
   /* Display the floating point data */
  Serial.print("X: ");
  Serial.print(euler.x());
  Serial.print(" Y: ");
  Serial.print(euler.y());
  Serial.print(" Z: ");
  Serial.print(euler.z());
  Serial.println("");
  /*
    Display calibration status for each sensor.
    uint8_t system, gyro, accel, mag = 0;
    bno.getCalibration(&system, &gyro, &accel, &mag);
    if (gyro+accel+mag != 9) { //not yet calibrated
      Serial.print("CALIBRATION: Sys=");
      Serial.print(system, DEC);
      Serial.print(" G=");
      Serial.print(gyro, DEC);
      Serial.print(" A=");
      Serial.print(accel, DEC);
      Serial.print(" M=");
      Serial.print(mag, DEC);
    } */
  
  xEuler = map(euler.x(), 0, 360, 0, 255);
  yEuler = map(euler.y(), -90, 90, 0, 255);
  zEuler = map(euler.z(), -180, 180, 0, 255);

    delay(BNO055_SAMPLERATE_DELAY_MS);
    lastRead = millis();
}

/*void checkToggle(){
  stateA = digitalRead(posOne);
  stateB = digitalRead(posTwo);

  if ((stateA == 1) && (stateB==0)){
    digitalWrite(ledPin1,HIGH);
    digitalWrite(ledPin2,LOW);
    Serial.println("stateA");
}
  if ((stateB == 1) && (stateA==0)){
    digitalWrite(ledPin2,HIGH);
    digitalWrite(ledPin1,LOW);
    Serial.println("stateB");
}
  if ((stateA == 1) && (stateB==1)){
    digitalWrite(ledPin1,LOW);
    digitalWrite(ledPin2,LOW);
    Serial.println("off");
}
} */
