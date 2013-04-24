#include <SoftwareSerial.h>

SoftwareSerial mySerial(13,12); // RX, TX

const int ledPin = 9;      // the pin that the LED is attached to

const int redPin = 3;      // the pin that the red pin of the RGB LED is attached to
const int greenPin = 5;    // the pin that the green pin of the RGB LED is attached to
const int bluePin = 6;     // the pin that the blue pin of the RGB LED is attached to

#define HEADER        '|'
#define MESSAGE_BYTES  5  // the total bytes in a message

void setup()
{
  // initialize the serial communication:
//  Serial.begin(9600);
  // initialize the ledPin as an output:
  pinMode(ledPin, OUTPUT);
  
  // bluetooth serial
  mySerial.begin(9600);
}

void loop() {

  if ( mySerial.available() >= MESSAGE_BYTES)
  {
    if( mySerial.read() == HEADER)
    {
      int brightness = mySerial.read();

      int red = mySerial.read();      
      int green = mySerial.read();
      int blue = mySerial.read();
      
      analogWrite(ledPin, brightness);
      analogWrite(redPin, red);
      analogWrite(greenPin, green);
      analogWrite(bluePin, blue);
    }
  }

  /*
    // read the most recent byte (which will be from 0 to 255):
   info = Serial.read();
   // set the brightness of the LED:
   analogWrite(ledPin, brightness);
   */
}



