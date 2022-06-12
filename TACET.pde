import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

String data="";
float roll, pitch, x_axis, y_axis, z_axis;

void setup() {
  size (960, 640, P3D);
  myPort = new Serial(this, "COM3", 9600); // starts the serial communication
  myPort.bufferUntil('\n');
}

void draw() {
  translate(width/2, height/2, 0);
  background(33);
  textSize(22);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);

  //Rotate the object
  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  
  //3D 0bject
  textSize(30);  
  fill(255, 255, 255);
  box (386, 40, 200); // Draw box
  textSize(25);
  fill(0, 0, 0);
  text("TACET", -183, 10, 101);
}

//Read data
void serialEvent (Serial myPort) { 
  data = myPort.readStringUntil('\n');

  if (data != null) {
    data = trim(data);
    String items[] = split(data, '/');
    if (items.length > 1) {
      roll = float(items[0]);
      pitch = float(items[1]);
    }
  }
}
