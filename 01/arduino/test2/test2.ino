#include <OneWire.h>
#include <DallasTemperature.h>
 
//the pin you connect the ds18b20 to
#define DS18B20 2
 
OneWire ourWire(DS18B20);
DallasTemperature sensors(&ourWire);
 
void setup()
{
Serial.begin(9600);
delay(1000);
//start reading
sensors.begin();
}
 
void loop()
{
//read temperature and output via serial
sensors.requestTemperatures();
double c = sensors.getTempCByIndex(0);
Serial.print(c);
Serial.print(" degrees C, ");
Serial.print(Celcius2Fahrenheit(c));
Serial.println(" degrees F");
}

double Celcius2Fahrenheit(double celsius)
{
  return 1.8 * celsius + 32;
}
