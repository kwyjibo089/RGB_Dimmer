
import processing.serial.*;
Serial port;

color white = color(255, 255, 255);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);

String oldMessage = "foo";

int brightness = 0;
int redValue = 0;
int greenValue =0;
int blueValue =0;

void setup() {
  size(256, 220);

  println("Available serial ports:");
  //println(Serial.list());

  // Uses the first port in this list (number 0).  Change this to
  // select the port corresponding to your Arduino board.  The last
  // parameter (e.g. 9600) is the speed of the communication.  It
  // has to correspond to the value passed to Serial.begin() in your
  // Arduino sketch.
  //port = new Serial(this, Serial.list()[0], 9600);  

  // If you know the name of the port used by the Arduino board, you
  // can specify it directly like this.
  port = new Serial(this, "COM40", 9600);
}

void draw() {
  // draw a gradient from black to white
  for (int i = 0; i < 256; i++) {
    stroke(i);
    line(i, 0, i, 50);
  }

  setGradient(0, 70, 256, 50, white, red);  
  setGradient(0, 120, 256, 50, white, green);  
  setGradient(0, 170, 256, 50, white, blue);  

  // write the current X-position of the mouse to the serial port as
  // a single byte
  int xpos = mouseX;
  int ypos = mouseY;
 
  //port.write(xpos);

  if (xpos > 0 && xpos < 256)
  {
    if (ypos > 0 && ypos <= 50) {
      // brightness
      brightness = xpos;
    } 
    else if (ypos >= 70  && ypos < 120) {
      // red gradient
      redValue = xpos;
    } 
    else if (ypos >= 120 && ypos < 170) {
      // green gradient
      greenValue = xpos;
    } 
    else if (ypos >= 170 && ypos <= 220) {
      // blue gradient
      blueValue = xpos;
    }
    sendMessage(brightness, redValue, greenValue, blueValue);
  }
}

void sendMessage(int brightness,int red,int green,int blue){
  String msg = brightness + "|" + red + "|" + green + "|" + blue;
  if (!msg.equals(oldMessage)) {
    println(msg);
    port.write("|");
    port.write(brightness);
    port.write(red);
    port.write(green);
    port.write(blue);
    oldMessage = msg;    
  }
}

/*
public void serialEvent(Serial p) {
  // handle incoming serial data
  String inString = port.readStringUntil('\n');
  if(inString != null) {
      println( inString );   // echo text string from Arduino
  }
}
*/

// taken from
// http://processing.org/learning/basics/lineargradient.html
void setGradient(int x, int y, float w, float h, color c1, color c2) {

  noFill();

  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(i, y, i, y+h);
  }
}

