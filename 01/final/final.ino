/*
 * Augmented Tea Ceremony
 * by Michael James
 * 
 * Rev: 02-16-2017
 */

////////////////////////////////
// custom settings
////////////////////////////////

// temperature checkpoints
double hotThresh = 170; // temperature above which water is "hot"
double targetTemp = 165; // temperature at which tea is ready to steep
double comfortTemp = 131; // temperature at which tea is ready to drink

unsigned long steepTimeSec = 180; // duration of steep in seconds
int steps = 200/7; // steps per stepper movement (200 is a full rotation)

// pin assignments
#define DS18B20 2 // the pin you connect the temp sensor (ds18b20) to
const int solPin = 4; // solenoid
const int ledPin = 5; // LED
const int switchPin = 6; // switch
const int stp1dirPin = 7; // stepper 1 direction
const int stp2dirPin = 9; // stepper 2 direction
const int stp3dirPin = 11; // stepper 3 direction
const int stpStepPins[] = {8, 10, 12};

// set which dispensers to rotate
const bool rot1 = true;
const bool rot2 = false;
const bool rot3 = true;

////////////////////////////////

// setup Dallas Temperature for Sensor
#include <OneWire.h>
#include <DallasTemperature.h>
OneWire ourWire(DS18B20);
DallasTemperature sensors(&ourWire);

// game variables
bool record = false; // record has started
bool recordDone = false;
bool start = false; // record has started and stopped, so begin
bool startDone = false;
bool hot = false; // temperature sensor has been placed in hot water
bool hotDone = false;
bool steep = false; // water is ready for steeping
bool steepDone = false;
bool removeDone = false;
bool drink = false; // water is ready for drinking

unsigned long steepTime = steepTimeSec * 1000;
unsigned long steepStart;
unsigned long lastTime = 0; // timestamp when last loop ended
double t; // current temperature

// switch
int switchState = true;         // variable for reading the pushbutton status
int switchStatePrev = true;

// the following variables are unsigned long's because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
unsigned long lastDebounceTime = 0;  // the last time the output pin was toggled
unsigned long debounceDelay = 0;    // the debounce time; increase if the output flickers

////////////////////////////////
// setup
////////////////////////////////

// the setup function runs once when you press reset or power the board
void setup() {
  Serial.begin(9600);

  delay(1000);
  //start reading
  sensors.begin();
  sensors.setResolution(9);
  
  pinMode(solPin, OUTPUT); // solenoid
  pinMode(ledPin, OUTPUT); // LED
  pinMode(switchPin, INPUT_PULLUP); // switch
  
  // stepper 1
  pinMode(stpStepPins[0], OUTPUT); 
  pinMode(stp1dirPin, OUTPUT);
  // stepper 2
  pinMode(stpStepPins[1], OUTPUT); 
  pinMode(stp2dirPin, OUTPUT);
  // stepper 3
  pinMode(stpStepPins[2], OUTPUT); 
  pinMode(stp3dirPin, OUTPUT);

  // Enables the motor to move in a particular direction
  digitalWrite(stp1dirPin,HIGH);
  digitalWrite(stp2dirPin,LOW);
  digitalWrite(stp3dirPin,HIGH);
}

////////////////////////////////
// loop
////////////////////////////////

// the loop function runs over and over again forever
void loop() {
  
  ////////////////
  // switch
  ////////////////
  
  // read the state of the switch into a local variable:
  int reading = digitalRead(switchPin);

  // check to see if you just pressed the button
  // (i.e. the input went from LOW to HIGH),  and you've waited
  // long enough since the last press to ignore any noise:

  // If the switch changed, due to noise or pressing:
  if (reading != switchStatePrev) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > debounceDelay) {
    // whatever the reading is at, it's been there for longer
    // than the debounce delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading != switchState) {
      switchState = reading;

      // only toggle the LED if the new button state is HIGH
      if (switchState == HIGH) {
        if (!record) {
          record = true;
        } else {
          start = true;
        }

//        dispense(); 
      }
    }
  }

  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  switchStatePrev = reading;

  ////////////////
  // LED
  ////////////////
  
  // LED on if in record mode
  if ((record) and (!start)) {
    digitalWrite(ledPin, HIGH); 
  } else {
    digitalWrite(ledPin, LOW); 
  }

  ////////////////
  // temperature
  ////////////////
  if (start) {
    //read temperature and output via serial
    sensors.requestTemperatures();
    t = sensors.getTempFByIndex(0);
  }

  if ((record) and (start) and (t > hotThresh)) {
    hot = true;
  }

  if ((record) and (start) and (hot) and (t < targetTemp)) {
    steep = true;
  }

  if ((record) and (start) and (hot) and (steep) and (t < comfortTemp)) {
    drink = true;
  }

  ////////////////
  // bell strikes
  ////////////////

  // record starts
  if ((record) and (!recordDone)) {
    ringSol();
    recordDone = true;
  }

  // record stops
  if ((start) and (!startDone)) {
    ringSol();
    startDone = true;
  }

  // temperature sensor placed in hot water
  if ((hot) and (!hotDone)) {
    ringSol();
    delay(30 * 1000); // 10 sec delay between temp sensor in hot water & dispenses
    dispense();
    hotDone = true;
  }

  // tea at target temp, ready to steep
  if ((steep) and (!steepDone)) {
    ringSol(); // put infuser in
    steepDone = true;
    steepStart = millis();
  }

  // steeper time end
  if ((steep) and (steepDone) and (millis() - steepStart > steepTime) and (!removeDone)) {
    ringSol(); // take infuser out
    removeDone = true;
  }

  // tea at comfortable temp, ready to drink (reset system)
  if (drink) {
    ringSol();
    record = false;
    start = false;
    hot = false;
    steep = false;
    drink = false;
    
    recordDone = false;
    startDone = false;
    hotDone = false;
    steepDone = false;
    removeDone = false;

    switchState = true;         // variable for reading the pushbutton status
    switchStatePrev = true;
  }

  ////////////////
  // print for debugging
  ////////////////

  // print temperature
  Serial.print(t);
  Serial.print(", ");
  
  // print loop time
  unsigned long now = millis();
  Serial.print(now - lastTime);
  lastTime = now;

  // print current stage
  if (record) {Serial.print(", record");}
  if (start) {Serial.print(", start");}
  if (hot) {Serial.print(", hot");}
  if (steep) {
    Serial.print(", steep");
    unsigned long stopwatch = (millis() - steepStart) / 1000;
    if (stopwatch < steepTimeSec) {
      Serial.print(stopwatch);
      Serial.print(" ");
      Serial.print(steepTimeSec);
    }
  }
  if (removeDone) {Serial.print(", remove");}
  if (drink) {Serial.print(", drink");}
  Serial.println();
}

////////////////////////////////
// ring solenoid
////////////////////////////////

void ringSol() {
  digitalWrite(solPin, HIGH);   // turn the SOL on (HIGH is the voltage level)
  delay(10);                       // wait
  digitalWrite(solPin, LOW);    // turn the SOL off by making the voltage LOW
  Serial.print(t);
  Serial.println(" ring!");
}

////////////////////////////////
// rotate stepper
////////////////////////////////

void rotStepper(int sel) {
  int pin;
  // set stepper to rotate
  switch (sel) {
      case 1:
        pin = stpStepPins[0];
        break;
      case 2:
        pin = stpStepPins[1];
        break;
      case 3:
        pin = stpStepPins[2];
        break;
    }
  if (pin == stpStepPins[0] or pin == stpStepPins[1] or pin == stpStepPins[2]) {
    // rotate selected stepper
    for(int x = 0; x < steps; x++) {
      digitalWrite(pin,HIGH); 
      delayMicroseconds(500); 
      digitalWrite(pin,LOW); 
      delayMicroseconds(500);
      delay(25); // slowing motor gives it torque to rotate dispenser
    }
  }
}

////////////////////////////////
// dispense
////////////////////////////////

void dispense() {
  delay(10 * 1000);
  int dispenseDelay = 3000;
  int ringDelay = 5000;

  // dispense 1
  ringSol();
  delay(dispenseDelay);
  if (rot1) {rotStepper(1);}
  delay(ringDelay);

  // dispense 2
  ringSol();
  delay(dispenseDelay);
  if (rot2) {rotStepper(1);}
  delay(ringDelay);

  // dispense 3
  ringSol();
  delay(dispenseDelay);
  if (rot3) {rotStepper(3);}
}

///////////////////////////////////////////
// credits
///////////////////////////////////////////
/*
 * Arduino Blink Tutorial
 * Arduino Debouncer Tutorial
*/
