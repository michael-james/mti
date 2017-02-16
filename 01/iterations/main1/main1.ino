#include <OneWire.h>
#include <DallasTemperature.h>
 
//the pin you connect the ds18b20 to
#define DS18B20 2 // temp sensor pin
 
OneWire ourWire(DS18B20);
DallasTemperature sensors(&ourWire);

const int solPin = 4; // solenoid
const int ledPin = 5; // LED
const int switchPin = 6; // switch
const int stp1dirPin = 7; // stepper 1 direction
const int stp1stepPin = 8; // stepper 1 step
const int stp2dirPin = 9; // stepper 2 direction
const int stp2stepPin = 10; // stepper 2 step
const int stp3dirPin = 11; // stepper 3 direction
const int stp3stepPin = 12; // stepper 3 step

unsigned long lastTime = 0;

// switch
int switchState = true;         // variable for reading the pushbutton status
int switchStatePrev = true;
int powerState = false;

// the following variables are unsigned long's because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
unsigned long lastDebounceTime = 0;  // the last time the output pin was toggled
unsigned long debounceDelay = 0;    // the debounce time; increase if the output flickers

// steppers
int steps = 200/5;

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
  pinMode(stp1stepPin, OUTPUT); 
  pinMode(stp1dirPin, OUTPUT);
  // stepper 2
  pinMode(stp2stepPin, OUTPUT); 
  pinMode(stp2dirPin, OUTPUT);
  // stepper 3
  pinMode(stp3stepPin, OUTPUT); 
  pinMode(stp3dirPin, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {

  ////////////////
  // temperature
  ////////////////
  //read temperature and output via serial
  sensors.requestTemperatures();
  double f = sensors.getTempFByIndex(0);
  Serial.print(f);
  Serial.print(" degrees F, delay ");
  unsigned long now = millis();
  Serial.println(now - lastTime);
  lastTime = now;
  
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
        powerState = !powerState;
      }
    }
  }

  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  switchStatePrev = reading;

  if (powerState == true) {

    ////////////////
    // solenoid
    ////////////////
    digitalWrite(solPin, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(10);                       // wait for a second
    digitalWrite(solPin, LOW);    // turn the LED off by making the voltage LOW

    ////////////////
    // LED
    ////////////////
    digitalWrite(ledPin, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(10);                       // wait for a second
    digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW
  
    ////////////////
    // stepper 1
    ////////////////
    digitalWrite(stp1dirPin,HIGH); // Enables the motor to move in a particular direction
    // Makes 200 pulses for making one full cycle rotation
    for(int x = 0; x < steps; x++) {
      digitalWrite(stp1stepPin,HIGH); 
      delayMicroseconds(500); 
      digitalWrite(stp1stepPin,LOW); 
      delayMicroseconds(500);
      delay(50); 
    }
  
    ////////////////
    // stepper 2
    ////////////////
    digitalWrite(stp2dirPin,HIGH); // Enables the motor to move in a particular direction
    // Makes 200 pulses for making one full cycle rotation
    for(int x = 0; x < steps; x++) {
      digitalWrite(stp2stepPin,HIGH); 
      delayMicroseconds(500); 
      digitalWrite(stp2stepPin,LOW); 
      delayMicroseconds(500);
      delay(50); 
    }
  
    ////////////////
    // stepper 3
    ////////////////
    digitalWrite(stp3dirPin,HIGH); // Enables the motor to move in a particular direction
    // Makes 200 pulses for making one full cycle rotation
    for(int x = 0; x < steps; x++) {
      digitalWrite(stp3stepPin,HIGH); 
      delayMicroseconds(500); 
      digitalWrite(stp3stepPin,LOW); 
      delayMicroseconds(500);
      delay(50); 
    }
  
    ////////////////
    // delay
    ////////////////
    //delay(1000); // wait for a second
    
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
    digitalWrite(solPin, LOW);
  }
}

double Celcius2Fahrenheit(double celsius) {
  return 1.8 * celsius + 32;
}

///////////////////////////////////////////
// Credits
///////////////////////////////////////////
/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO 
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN takes care 
  of use the correct LED pin whatever is the board used.
  If you want to know what pin the on-board LED is connected to on your Arduino model, check
  the Technical Specs of your board  at https://www.arduino.cc/en/Main/Products
  
  This example code is in the public domain.

  modified 8 May 2014
  by Scott Fitzgerald
  
  modified 2 Sep 2016
  by Arturo Guadalupi

////////

  Arduino Debouncer Tutorial

*/
