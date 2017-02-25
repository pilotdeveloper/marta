
/*
* Getting Started example sketch for nRF24L01+ radios
* This is an example of how to send data from one node to another using data structures
* Updated: Dec 2014 by TMRh20
*/

#include <SPI.h>
#include "RF24.h"

byte addresses[][6] = {"1Node","2Node"};

/****************** User Config ***************************/
/***      Set this radio as radio number 0 or 1         ***/
bool radioNumber = 1;

/* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins 7 & 8 */
RF24 radio(9,10);
/**********************************************************/

struct dataStruct{
  unsigned long _micros;
  unsigned char state;
}CountData;

void setup() {

  Serial.begin(115200);  
  radio.begin();

  // Set the PA Level low to prevent power supply related issues since this is a
 // getting_started sketch, and the likelihood of close proximity of the devices. RF24_PA_MAX is default.
  radio.setPALevel(RF24_PA_MIN);
  
  // Open a writing and reading pipe on each radio, with opposite addresses
  if(radioNumber){
    radio.openWritingPipe(addresses[1]);
    radio.openReadingPipe(1,addresses[0]);
  }else{
    radio.openWritingPipe(addresses[0]);
    radio.openReadingPipe(1,addresses[1]);
  }
  
  CountData.state = 0;
  // Start the radio for sending data
  radio.stopListening();                                    // First, stop listening so we can talk.
}




void loop() {

   if(Serial.available()){
      CountData.state = Serial.read();
   }

    CountData.state=3;
  

    CountData._micros = micros();
    radio.write( &CountData, sizeof(CountData) );

    // Try again 100ms later
    delay(100);


} // Loop
