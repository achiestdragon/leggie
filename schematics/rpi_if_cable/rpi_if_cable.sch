EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:rpi_if_cable-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Raspberry_Pi_2_3 J6
U 1 1 5AF4CD94
P 9750 2450
F 0 "J6" H 10450 1200 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 9350 3350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x20" H 10750 3700 50  0001 C CNN
F 3 "" H 9800 2300 50  0001 C CNN
	1    9750 2450
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x16_Female J5
U 1 1 5AF4CEDC
P 6650 2300
F 0 "J5" H 6650 3100 50  0000 C CNN
F 1 "Conn_01x16_Female" H 6650 1400 50  0000 C CNN
F 2 "" H 6650 2300 50  0001 C CNN
F 3 "" H 6650 2300 50  0001 C CNN
	1    6650 2300
	-1   0    0    -1  
$EndComp
Text Label 6100 1750 0    60   ~ 0
1_dir
Text Label 6100 1950 0    60   ~ 0
2_dir
Text Label 6100 2150 0    60   ~ 0
3_dir
Text Label 6100 1650 0    60   ~ 0
1_run
Text Label 6100 1850 0    60   ~ 0
2_run
Text Label 6100 2050 0    60   ~ 0
3_run
Text Label 6150 2250 0    60   ~ 0
latch_a0
Text Label 6150 2350 0    60   ~ 0
latch_a1
Text Label 6150 2450 0    60   ~ 0
latch_a2
Text Label 6100 2550 0    60   ~ 0
ld_latch
Text Label 6150 2850 0    60   ~ 0
rdy_in
Text Label 6150 2650 0    60   ~ 0
new_run
Text Label 6150 3050 0    60   ~ 0
gnd
Text Label 6150 2950 0    60   ~ 0
jam_in
Text Notes 7750 7500 0    60   ~ 0
rpi interface cable
Text Notes 8550 7650 0    60   ~ 0
9 may 2018
Text Notes 10650 7650 0    60   ~ 0
1.0a
Text Notes 7100 6700 0    60   ~ 0
raspberry pi interface cable 
$Comp
L Conn_01x16_Male J4
U 1 1 5AF361C3
P 5900 2300
F 0 "J4" H 5900 3100 50  0000 C CNN
F 1 "Conn_01x16_Male" H 5900 1400 50  0000 C CNN
F 2 "" H 5900 2300 50  0001 C CNN
F 3 "" H 5900 2300 50  0001 C CNN
	1    5900 2300
	-1   0    0    -1  
$EndComp
$Comp
L Conn_01x16_Male J1
U 1 1 5AF36338
P 1050 1800
F 0 "J1" H 1050 2600 50  0000 C CNN
F 1 "Conn_01x16_Male" H 1050 900 50  0000 C CNN
F 2 "" H 1050 1800 50  0001 C CNN
F 3 "" H 1050 1800 50  0001 C CNN
	1    1050 1800
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x16_Male J2
U 1 1 5AF3639A
P 1050 3800
F 0 "J2" H 1050 4600 50  0000 C CNN
F 1 "Conn_01x16_Male" H 1050 2900 50  0000 C CNN
F 2 "" H 1050 3800 50  0001 C CNN
F 3 "" H 1050 3800 50  0001 C CNN
	1    1050 3800
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x16_Male J3
U 1 1 5AF364C3
P 1050 5900
F 0 "J3" H 1050 6700 50  0000 C CNN
F 1 "Conn_01x16_Male" H 1050 5000 50  0000 C CNN
F 2 "" H 1050 5900 50  0001 C CNN
F 3 "" H 1050 5900 50  0001 C CNN
	1    1050 5900
	1    0    0    -1  
$EndComp
$Comp
L 74LS138 U1
U 1 1 5AF36F8D
P 3900 4200
F 0 "U1" H 4000 4700 50  0000 C CNN
F 1 "74hc238" H 4100 3650 50  0000 C CNN
F 2 "" H 3900 4200 50  0001 C CNN
F 3 "" H 3900 4200 50  0001 C CNN
	1    3900 4200
	-1   0    0    -1  
$EndComp
$Comp
L 74LS27 U2
U 3 1 5AF38806
P 5600 6250
F 0 "U2" H 5600 6300 50  0000 C CNN
F 1 "74hc27" H 5600 6200 50  0000 C CNN
F 2 "" H 5600 6250 50  0001 C CNN
F 3 "" H 5600 6250 50  0001 C CNN
	3    5600 6250
	1    0    0    -1  
$EndComp
$Comp
L 74LS27 U2
U 2 1 5AF38969
P 5600 5600
F 0 "U2" H 5600 5650 50  0000 C CNN
F 1 "74hc27" H 5600 5550 50  0000 C CNN
F 2 "" H 5600 5600 50  0001 C CNN
F 3 "" H 5600 5600 50  0001 C CNN
	2    5600 5600
	1    0    0    -1  
$EndComp
$Comp
L 74LS27 U2
U 1 1 5AF389D6
P 5600 5000
F 0 "U2" H 5600 5050 50  0000 C CNN
F 1 "74hc27" H 5600 4950 50  0000 C CNN
F 2 "" H 5600 5000 50  0001 C CNN
F 3 "" H 5600 5000 50  0001 C CNN
	1    5600 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10050 3750 10050 4000
Wire Wire Line
	10050 4000 7150 4000
Wire Wire Line
	7150 3000 6850 3000
Wire Wire Line
	6850 3100 7150 3100
Connection ~ 7150 3100
Wire Wire Line
	9350 3750 9350 4000
Connection ~ 9350 4000
Wire Wire Line
	9450 3750 9450 4000
Connection ~ 9450 4000
Wire Wire Line
	9550 3750 9550 4000
Connection ~ 9550 4000
Wire Wire Line
	9650 3750 9650 4000
Connection ~ 9650 4000
Wire Wire Line
	9750 3750 9750 4000
Connection ~ 9750 4000
Wire Wire Line
	9850 3750 9850 4000
Connection ~ 9850 4000
Wire Wire Line
	9950 3750 9950 4000
Connection ~ 9950 4000
Wire Wire Line
	6850 1600 8450 1600
Wire Wire Line
	8450 1600 8450 1750
Wire Wire Line
	8450 1750 8850 1750
Wire Wire Line
	6850 1700 8350 1700
Wire Wire Line
	8350 1700 8350 1850
Wire Wire Line
	8350 1850 8850 1850
Wire Wire Line
	6850 1800 8250 1800
Wire Wire Line
	8250 1800 8250 1950
Wire Wire Line
	8250 1950 8850 1950
Wire Wire Line
	6850 1900 8150 1900
Wire Wire Line
	8150 1900 8150 2050
Wire Wire Line
	8150 2050 8850 2050
Wire Wire Line
	6850 2000 8050 2000
Wire Wire Line
	8050 2000 8050 2150
Wire Wire Line
	8050 2150 8850 2150
Wire Wire Line
	6850 2100 7950 2100
Wire Wire Line
	7950 2100 7950 2250
Wire Wire Line
	7950 2250 8850 2250
Wire Wire Line
	6850 2200 7850 2200
Wire Wire Line
	7850 2200 7850 2350
Wire Wire Line
	7850 2350 8850 2350
Wire Wire Line
	6850 2300 7750 2300
Wire Wire Line
	7750 2300 7750 2450
Wire Wire Line
	7750 2450 8850 2450
Wire Wire Line
	6850 2400 7650 2400
Wire Wire Line
	7650 2400 7650 2550
Wire Wire Line
	7650 2550 8850 2550
Wire Wire Line
	6850 2500 7550 2500
Wire Wire Line
	7550 2500 7550 2650
Wire Wire Line
	7550 2650 8850 2650
Wire Wire Line
	6850 2600 7450 2600
Wire Wire Line
	7450 2600 7450 2750
Wire Wire Line
	7450 2750 8850 2750
Connection ~ 7150 3000
Wire Wire Line
	6850 2800 7350 2800
Wire Wire Line
	7350 2800 7350 4150
Wire Wire Line
	7350 4150 10800 4150
Wire Wire Line
	10800 4150 10800 2950
Wire Wire Line
	10800 2950 10650 2950
Wire Wire Line
	6850 2900 7450 2900
Wire Wire Line
	7450 2900 7450 4250
Wire Wire Line
	7450 4250 10900 4250
Wire Wire Line
	10900 4250 10900 2850
Wire Wire Line
	10900 2850 10650 2850
Wire Wire Line
	5050 1600 5700 1600
Wire Wire Line
	5050 1600 5050 1100
Wire Wire Line
	5050 1100 1250 1100
Wire Wire Line
	4950 1700 5700 1700
Wire Wire Line
	4950 1700 4950 1200
Wire Wire Line
	4950 1200 1250 1200
Wire Wire Line
	4850 1800 5700 1800
Wire Wire Line
	4850 1800 4850 1300
Wire Wire Line
	4850 1300 1250 1300
Wire Wire Line
	4750 1900 5700 1900
Wire Wire Line
	4750 1900 4750 1400
Wire Wire Line
	4750 1400 1250 1400
Wire Wire Line
	4650 2000 5700 2000
Wire Wire Line
	4650 2000 4650 1500
Wire Wire Line
	4650 1500 1250 1500
Wire Wire Line
	4550 2100 5700 2100
Wire Wire Line
	4550 2100 4550 1600
Wire Wire Line
	4550 1600 1250 1600
Wire Wire Line
	1450 1100 1450 5200
Wire Wire Line
	1450 5200 1250 5200
Connection ~ 1450 1100
Wire Wire Line
	1550 1200 1550 5300
Wire Wire Line
	1550 5300 1250 5300
Connection ~ 1550 1200
Wire Wire Line
	1250 5400 1650 5400
Wire Wire Line
	1650 5400 1650 1300
Connection ~ 1650 1300
Wire Wire Line
	1750 1400 1750 5500
Wire Wire Line
	1750 5500 1250 5500
Connection ~ 1750 1400
Wire Wire Line
	1250 5600 1850 5600
Wire Wire Line
	1850 5600 1850 1500
Connection ~ 1850 1500
Wire Wire Line
	1950 1600 1950 5700
Wire Wire Line
	1950 5700 1250 5700
Connection ~ 1950 1600
Wire Wire Line
	1250 3100 1450 3100
Connection ~ 1450 3100
Wire Wire Line
	1250 3200 1550 3200
Connection ~ 1550 3200
Wire Wire Line
	1250 3300 1650 3300
Connection ~ 1650 3300
Wire Wire Line
	1250 3400 1750 3400
Connection ~ 1750 3400
Wire Wire Line
	1250 3500 1850 3500
Connection ~ 1850 3500
Wire Wire Line
	1250 3600 1950 3600
Connection ~ 1950 3600
Wire Wire Line
	3300 3850 3200 3850
Wire Wire Line
	3200 3850 3200 1800
Wire Wire Line
	3200 1800 1250 1800
Wire Wire Line
	3100 3950 3300 3950
Wire Wire Line
	3100 3950 3100 1900
Wire Wire Line
	3100 1900 1250 1900
Wire Wire Line
	3300 4050 3000 4050
Wire Wire Line
	3000 4050 3000 3800
Wire Wire Line
	3000 3800 1250 3800
Wire Wire Line
	3300 4150 2900 4150
Wire Wire Line
	2900 4150 2900 3900
Wire Wire Line
	2900 3900 1250 3900
Wire Wire Line
	3300 4250 2900 4250
Wire Wire Line
	2900 4250 2900 5900
Wire Wire Line
	2900 5900 1250 5900
Wire Wire Line
	3300 4350 3000 4350
Wire Wire Line
	3000 4350 3000 6000
Wire Wire Line
	3000 6000 1250 6000
Wire Wire Line
	4500 3850 4600 3850
Wire Wire Line
	4600 3850 4600 2200
Wire Wire Line
	4600 2200 5700 2200
Wire Wire Line
	4700 2300 5700 2300
Wire Wire Line
	4700 2300 4700 3950
Wire Wire Line
	4700 3950 4500 3950
Wire Wire Line
	4800 2400 5700 2400
Wire Wire Line
	4800 2400 4800 4050
Wire Wire Line
	4800 4050 4500 4050
Wire Wire Line
	1250 2500 5700 2500
Wire Wire Line
	2150 2500 2150 6600
Wire Wire Line
	2150 4500 1250 4500
Connection ~ 2150 2500
Wire Wire Line
	2150 6600 1250 6600
Connection ~ 2150 4500
Wire Wire Line
	1250 6700 6750 6700
Wire Wire Line
	2050 2600 2050 6700
Wire Wire Line
	2050 4600 1250 4600
Wire Wire Line
	1250 2600 2050 2600
Connection ~ 2050 4600
Wire Wire Line
	6750 6700 6750 3350
Wire Wire Line
	6750 3350 5000 3350
Connection ~ 2050 6700
Wire Wire Line
	5000 3000 5700 3000
Connection ~ 5000 3000
Wire Wire Line
	5000 3100 5700 3100
Connection ~ 5000 3100
Wire Wire Line
	5000 4450 4500 4450
Connection ~ 5000 3350
Wire Wire Line
	5000 4550 4500 4550
Connection ~ 5000 4450
Wire Wire Line
	1250 6500 2300 6500
Wire Wire Line
	2300 6500 2300 2400
Wire Wire Line
	2300 2400 1250 2400
Wire Wire Line
	1250 4400 2300 4400
Connection ~ 2300 4400
Wire Wire Line
	5700 2600 2300 2600
Connection ~ 2300 2600
Wire Wire Line
	5700 2800 5200 2800
Wire Wire Line
	5200 2800 5200 4500
Wire Wire Line
	5200 4500 6200 4500
Wire Wire Line
	6200 4500 6200 5000
Wire Wire Line
	5000 4850 2650 4850
Wire Wire Line
	2650 4850 2650 2200
Wire Wire Line
	2650 2200 1250 2200
Wire Wire Line
	5000 5000 2550 5000
Wire Wire Line
	2550 5000 2550 4200
Wire Wire Line
	2550 4200 1250 4200
Wire Wire Line
	5000 5150 2550 5150
Wire Wire Line
	2550 5150 2550 6300
Wire Wire Line
	2550 6300 1250 6300
Wire Wire Line
	5000 5450 2750 5450
Wire Wire Line
	2750 5450 2750 2300
Wire Wire Line
	2750 2300 1250 2300
Wire Wire Line
	5000 5600 2400 5600
Wire Wire Line
	2400 5600 2400 4300
Wire Wire Line
	2400 4300 1250 4300
Wire Wire Line
	5000 5750 2400 5750
Wire Wire Line
	2400 5750 2400 6400
Wire Wire Line
	2400 6400 1250 6400
Wire Wire Line
	6200 5600 6300 5600
Wire Wire Line
	6300 5600 6300 4350
Wire Wire Line
	6300 4350 5350 4350
Wire Wire Line
	5350 4350 5350 2900
Wire Wire Line
	5350 2900 5700 2900
Wire Wire Line
	5500 6450 5500 6700
Connection ~ 5500 6700
Wire Wire Line
	5500 4800 5500 3550
Wire Wire Line
	3900 3550 6150 3550
Wire Wire Line
	3900 2700 3900 3750
Wire Wire Line
	3900 4650 3900 6700
Connection ~ 3900 6700
Wire Wire Line
	7150 4000 7150 3000
Wire Wire Line
	5000 4550 5000 3000
Wire Wire Line
	5700 2700 3900 2700
Connection ~ 3900 3550
Wire Wire Line
	6850 2700 7350 2700
Wire Wire Line
	7350 2700 7350 1050
Wire Wire Line
	7350 1050 9950 1050
Wire Wire Line
	9950 1050 9950 1150
Text Label 6150 3150 0    60   ~ 0
gnd
Text Label 6100 2750 0    60   ~ 0
3v3
Text Notes 7050 950  0    60   ~ 0
cable to raspberry pi 40 pin headder
Text Notes 2950 900  0    60   ~ 0
rpi to if control interface\n
Text Label 5550 4750 0    60   ~ 0
14
Text Label 5600 6600 0    60   ~ 0
7
Text Label 3950 4750 0    60   ~ 0
8
Text Label 3950 3700 0    60   ~ 0
16
Wire Wire Line
	4500 4350 4900 4350
Wire Wire Line
	4900 4350 4900 3550
Connection ~ 4900 3550
$Comp
L C C1
U 1 1 5AF3A347
P 5750 3900
F 0 "C1" H 5775 4000 50  0000 L CNN
F 1 "0.1uF" H 5775 3800 50  0000 L CNN
F 2 "" H 5788 3750 50  0001 C CNN
F 3 "" H 5750 3900 50  0001 C CNN
	1    5750 3900
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 5AF3A446
P 6150 3900
F 0 "C2" H 6175 4000 50  0000 L CNN
F 1 "0.1uF" H 6175 3800 50  0000 L CNN
F 2 "" H 6188 3750 50  0001 C CNN
F 3 "" H 6150 3900 50  0001 C CNN
	1    6150 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 3550 6150 3750
Connection ~ 5500 3550
Wire Wire Line
	5750 3750 5750 3550
Connection ~ 5750 3550
Wire Wire Line
	5750 4050 5750 4200
Wire Wire Line
	5750 4200 6750 4200
Connection ~ 6750 4200
Wire Wire Line
	6150 4050 6150 4200
Connection ~ 6150 4200
$EndSCHEMATC
