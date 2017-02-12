

const int solPin = 4; // solenoid
const int ledPin = 5; // LED
const int switchPin = 6; // switch
const int stp1dirPin = 7; // stepper 1 direction
const int stp1stepPin = 8; // stepper 1 step
const int stp2dirPin = 9; // stepper 2 direction
const int stp2stepPin = 10; // stepper 2 step
const int stp3dirPin = 11; // stepper 3 direction
const int stp3stepPin = 12; // stepper 3 step

// switch
int switchState = 0;         // variable for reading the pushbutton status
int switchStatePrev = 0;
int powerState = false;

// steppers
int steps = 200/5;

// the setup function runs once when you press reset or power the board
void setup() {
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
  // switch
  ////////////////
  // read the state of the pushbutton value:
  switchState = digitalRead(switchPin);

   // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (switchState == LOW and switchStatePrev == HIGH) {
    // turn LED on:
    if (powerState == false) {
      powerState = true;
    }
    else {
      powerState = false;
    }
  }

  // store current state for next loop
  switchStatePrev = switchState;
  
  ////////////////
  // solenoid
  ////////////////
  digitalWrite(solPin, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(10);                       // wait for a second
  digitalWrite(solPin, LOW);    // turn the LED off by making the voltage LOW

  ////////////////
  // LED
  ////////////////
  /* // loop
  digitalWrite(ledPin, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(10);                       // wait for a second
  digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW*/

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (powerState == true) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

//  if (powerState == true) {
    
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
  //    delay(25); 
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
  //    delay(25); 
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
  //    delay(25); 
    }
  
    ////////////////
    // delay
    ////////////////
    //  delay(1000); // wait for a second
//  }
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
*/
