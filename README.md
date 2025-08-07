

# Ultrasound Plane Game - Arduino Ultrasonic Sensor Project

This project, developed by **schematrix**, implements an ultrasonic sensor-based control mechanism for a plane game. The ultrasonic sensor measures distance to obstacles or hand gestures and transmits this data via serial communication to a Processing sketch, which controls the plane's altitude and gameplay.

## Overview

The Arduino sketch reads distance data from an HC-SR04 ultrasonic sensor and sends it over the serial port in real-time. A Processing application receives this data to dynamically control the plane’s vertical position, creating an interactive gaming experience based on physical movement.

## Features

- Accurate distance measurement using an ultrasonic sensor
- Efficient serial communication with Processing for responsive game control
- Data filtering to minimize redundant serial transmissions
- Modular and clean Arduino code for easy customization and integration

## Hardware Requirements (BOM)

| Component                | Quantity | Notes                           |
|--------------------------|----------|--------------------------------|
| Arduino Uno or Compatible| 1        | Microcontroller board           |
| HC-SR04 Ultrasonic Sensor| 1        | For distance measurement        |
| Jumper Wires             | Several  | Male-to-male and male-to-female|
| Breadboard               | 1        | For prototyping connections     |
| Power Source             | 1        | USB cable or external power     |

## Wiring

| Sensor Pin | Arduino Pin          |
|------------|----------------------|
| VCC        | 5V                   |
| TRIG       | Digital Pin 3         |
| ECHO       | Digital Pin 2         |
| GND        | Ground (GND)          |

## Usage Instructions

1. Connect the ultrasonic sensor to the Arduino following the wiring diagram.
2. Upload the provided Arduino sketch to the board.
3. Run the accompanying Processing sketch to receive sensor data and control the game visuals.
4. Use hand movements or obstacles to influence the plane’s altitude based on distance readings.

## Arduino Sketch Details

- Triggers the ultrasonic sensor and measures echo pulse duration.
- Converts pulse duration to distance in centimeters using standard speed of sound.
- Sends distance data via serial only when the measurement changes, reducing unnecessary data transmission.

## License

This project is open-source under the MIT License. Contributions and modifications are welcome.

---

**revised by schematrix, burak b.**  
For questions or feedback, please contact Yoruk16_72 AT yahoo DOT fr.
