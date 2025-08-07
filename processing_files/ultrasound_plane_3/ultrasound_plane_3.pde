/*
/ ___| / ___| | | | ____|  \/  |  / \|_   _|  _ \|_ _\ \/ /
\___ \| |   | |_| |  _| | |\/| | / _ \ | | | |_) || | \  / 
 ___) | |___|  _  | |___| |  | |/ ___ \| | |  _ < | | /  \ 
|____/ \____|_| |_|_____|_|  |_/_/   \_\_| |_| \_\___/_/\_\
*/                                                       

// ------------------------------------------------------------
// Ultrasound Plane Game - Originally designed by Yörük
// A simple plane game controlled by ultrasonic sensor data from Arduino.
// Revised and cleaned by Burak B. (schematrix)
// ------------------------------------------------------------

import processing.serial.*;

Serial myPort;        // Serial port object

// Game and sensor variables
int score = 0;
float distancePlaneBird;

float planeHeight;     // Vertical position (Y coordinate) of the plane
float planeAngle;      // Angle of the plane
int ultrasonicDistance; // Distance read from the ultrasonic sensor
int incomingDistance;   // Raw incoming distance data from serial port

float birdX, birdY;    // Bird position
float grassX = 0;      // Horizontal offset for the grass

String serialData;     // Raw data from serial port

// Positions of clouds
float[] cloudX = new float[6];
float[] cloudY = new float[6];

// Images
PImage imgCloud;
PImage imgBird;
PImage imgPlane;
PImage imgGrass;

void setup() {
  size(800, 600);
  frameRate(30);
  rectMode(CORNERS);
  noCursor();
  textSize(16);
  
  println(Serial.list());  // List available serial ports (debug purpose)
  
  // Open serial port (check your connected port index here)
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.bufferUntil('\n');  // Read until newline character
  
  // Initial values
  planeHeight = 300;
  score = 0;
  
  // Load images
  imgCloud = loadImage("cloud.png");
  imgBird = loadImage("bird.png");
  imgPlane = loadImage("plane.png");
  imgGrass = loadImage("grass.png");
  
  // Initialize cloud positions randomly
  for (int i = 1; i <= 5; i++) {
    cloudX[i] = random(1000);
    cloudY[i] = random(400);
  }
  
  // Initialize bird position
  birdX = 900;
  birdY = random(height);
}

void serialEvent(Serial port) {
  serialData = port.readString();
  if (serialData != null) {
    serialData = trim(serialData);  // Clean trailing characters
    try {
      incomingDistance = Integer.parseInt(serialData);
      println("Distance: " + incomingDistance);
      if (incomingDistance > 1 && incomingDistance < 100) {
        ultrasonicDistance = incomingDistance;
      }
    } catch (Exception e) {
      println("Invalid data: " + serialData);
    }
  }
}

void draw() {
  background(0);
  drawSky();
  
  fill(5, 72, 0);
  
  // Draw and scroll grass horizontally
  for (int i = -2; i <= 4; i++) {
    image(imgGrass, 224 * i + grassX, 550, 224, 58);
  }
  grassX -= cos(radians(planeAngle)) * 10;
  if (grassX < -224) grassX = 224;
  
  // Calculate plane angle and height based on ultrasonic distance
  planeAngle = (18 - ultrasonicDistance) * 4;
  planeHeight += sin(radians(planeAngle)) * 10;
  planeHeight = constrain(planeHeight, 0, height);
  
  // Calculate distance between plane and bird, update score if collision occurs
  distancePlaneBird = dist(width / 2, planeHeight, birdX, birdY);
  if (distancePlaneBird < 40) {
    score++;
    birdX = 900;
    birdY = random(height);
  }
  
  // Display score and debug info
  fill(255);
  text("Score: " + score, 200, 30);
  text("Angle: " + nf(planeAngle, 1, 2), 10, 30);
  text("Height: " + nf(planeHeight, 1, 2), 10, 60);
  
  // Draw plane and other game elements
  drawPlane(planeHeight, planeAngle);
  
  // Move and draw the bird
  birdX -= cos(radians(planeAngle)) * 10;
  if (birdX < -30) {
    birdX = 900;
    birdY = random(height);
  }
  image(imgBird, birdX, birdY, 59, 38);
  
  // Move and draw clouds
  for (int i = 1; i <= 5; i++) {
    cloudX[i] -= cos(radians(planeAngle)) * (10 + 2 * i);
    image(imgCloud, cloudX[i], cloudY[i], 300, 200);
    if (cloudX[i] < -300) {
      cloudX[i] = 1000;
      cloudY[i] = random(400);
    }
  }
}

void drawSky() {
  noStroke();
  rectMode(CORNERS);
  for (int i = 1; i < height; i += 10) {
    fill(49 + i * 0.165, 118 + i * 0.118, 181 + i * 0.075);
    rect(0, i, width, i + 10);
  }
}

void drawPlane(float y, float angle) {
  noStroke();
  pushMatrix();
  translate(width / 2, y);
  rotate(radians(angle));
  scale(0.5);
  image(imgPlane, -111, -55, 223, 110);
  popMatrix();
}
