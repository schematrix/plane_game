
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

int echoPin= 2;
int triggerPin= 3;
unsigned long pulsetime = 0;
unsigned distance =0;
unsigned OldDistance =0;

void setup (){
  pinMode (echoPin, INPUT);
  pinMode (triggerPin, OUTPUT);
  Serial.begin(9600);  
}

void loop(){

  digitalWrite(triggerPin, LOW);
  delayMicroseconds(100);
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(100);
  digitalWrite(triggerPin, LOW);
  pulsetime = pulseIn(echoPin, HIGH);
  distance = pulsetime / 58;
  delay(10);


  
  if (OldDistance != distance) {

    Serial.println(distance); 

    OldDistance = distance;
  }

  delay(50);  
} 






