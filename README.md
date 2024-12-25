# Data Transmission from Nexys 4 DDR to Arduino Uno via UART

This project demonstrates data transmission from a Nexys 4 DDR FPGA board to an Arduino Uno microcontroller using the Universal Asynchronous Receiver/Transmitter (UART) protocol. The goal is to transmit 4-bit data from the FPGA to the Arduino and display it on the Arduino's serial monitor, with visual feedback provided by LEDs.

## Table of Contents
- [Introduction](#introduction)
- [Project Objectives](#project-objectives)
- [Hardware & Software](#hardware--software)
- [Design and Implementation](#design-and-implementation)
- [Testing and Results](#testing-and-results)
- [Conclusion](#conclusion)
- [Appendix](#appendix)

## Introduction
This project enables serial data communication between the Nexys 4 DDR FPGA and Arduino Uno via the UART protocol. Four switches on the Nexys 4 DDR provide the 4-bit input data, which is sent to the Arduino when a button is pressed. The received data is displayed on the Arduino's serial monitor, and LEDs on the Nexys board visually confirm the transmitted data.

## Project Objectives
1. Implement a UART transmitter on the Nexys 4 DDR FPGA.
2. Transmit 4-bit data from switches on the Nexys 4 DDR to an Arduino Uno.
3. Display the received data on the Arduino's serial monitor.
4. Provide visual feedback using LEDs to indicate the transmitted data.

## Hardware & Software

### Hardware
- Nexys 4 DDR FPGA Development Board
- Arduino Uno Microcontroller
- USB Cable (for Arduino)
- Jumper Wires

### Software
- [Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html) (for FPGA development)
- [Arduino IDE](https://www.arduino.cc/en/software)

## Design and Implementation

### FPGA (Verilog)
The Verilog module for the UART transmitter includes:
- **Baud Rate Generator**: Generates the necessary timing for UART communication, configurable to baud rates like 9600.
- **State Machine**: Manages the transmission sequence (idle, start bit, data bits, stop bit).
- **Data Input**: Reads the 4-bit data from the switches.
- **Send Button**: Initiates data transmission.
- **UART Transmitter**: Serially transmits data with start and stop bits.
- **LED Driver**: Mirrors the switch values on the LEDs for visual feedback.

### Arduino (C++)
A simple Arduino sketch initializes serial communication, continuously checks for incoming data, and displays it on the serial monitor.

### Constraints File
The `.xdc` file maps the Verilog signals to the physical pins on the Nexys 4 DDR, including the switches, buttons, LEDs, and UART transmit pin.

### Block Diagram
Refer to the repository for the complete block diagram.

## Testing and Results
The project was tested using various switch combinations on the Nexys 4 DDR. For example:
- Set switches to the binary representation of `4` (`0100`).
- Press the send button.
- The transmitted data was successfully displayed on the Arduino's serial monitor as:

```plaintext
Start Bit | Data Bits (D7-D0) | Stop Bit
0         | 00000100          | 1
```

The LEDs on the Nexys 4 DDR correctly reflected the switch input, verifying successful data transmission.

## Conclusion
This project demonstrates effective UART-based communication between an FPGA and a microcontroller. It highlights the implementation of a UART transmitter in Verilog and the successful reception of data on the Arduino. LEDs provided real-time visual feedback, enhancing the user experience.

## Appendix
The repository includes:
- Project Demo Video
- Verilog Code File
- Arduino Code File
- Constraints File (.xdc)
- Block Diagram

---

### Contributors
- **Chintan Maru** - chinmaru2004@gmail.com
- **Jaimin Leuva** - 202101078@daiict.ac.in

---

For any queries or suggestions, feel free to open an issue or contact us.
