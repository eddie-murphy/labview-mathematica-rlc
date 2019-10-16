# labview-mathematica-rlc
## LabVIEW 2018/2019 program that solves for the values of each component in a physical Resistor, Inductor, and Capacitor (RLC) circuit by analyzing the frequency response of the circuit.
* Calls on Mathematica using wolfram script to perform non-linear regression.
* Included is the main program vi, along with all the other sub vi's. Programs contain comments for understanding. 

## Necessary Equipment: 
* 1 Function Waveform Generator (Agilent 33120A), 
* 2 Digital Multimeters (Agilent 34401A),
* 2 Decade Resistors (General Radio 1443-J),
* 1 Decade Capacitor (General Radio 1419-B),
* 1 Decade Inductor (General Radio 1491-D), 
* 9 Banana cables,
* 2 usb to serial converters,
* 3 serial cables,
* 1 BNC to Banana Cable Converter,
* 3 null modem adapters,
* 1 Computer with LabVIEW 2019 or LabVIEW 2018
* 1 Computer with Mathematica 12

## Drawing of Setup (also looked in root directory as *setup.png*)
![setup](https://github.com/eddie-murphy/labview-mathematica-rlc-circuit-solver/blob/master/setup.png)

## Steps to Follow Once you have the Equipment Set Up:

1: Choose Capacitor Value:

  * Capacitor Range: (2.7 ≤ C ≤ 1,000) x 10^(-9)  F

2: Choose Inductor Value: 

  * Inductor Range: (0.027 ≤ L ≤10)  H

3: Choose Resistor Value:

  * If L ≤ 0.16 H : 

    * Then (1 < R < 3000)  Ω

  * If (0.16 < L ≤5) H : 

    * Then R > 3000 Ω

  * If L > 5 H : 

    * Then R > 6000 Ω
