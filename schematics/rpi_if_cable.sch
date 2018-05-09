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
L Raspberry_Pi_2_3 J?
U 1 1 5AF4CD94
P 6900 3800
F 0 "J?" H 7600 2550 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 6500 4700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x20" H 7900 5050 50  0001 C CNN
F 3 "" H 6950 3650 50  0001 C CNN
	1    6900 3800
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x16_Female J?
U 1 1 5AF4CEDC
P 3800 3650
F 0 "J?" H 3800 4450 50  0000 C CNN
F 1 "Conn_01x16_Female" H 3800 2750 50  0000 C CNN
F 2 "" H 3800 3650 50  0001 C CNN
F 3 "" H 3800 3650 50  0001 C CNN
	1    3800 3650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7200 5100 7200 5350
Wire Wire Line
	7200 5350 4300 5350
Wire Wire Line
	4300 5350 4300 4050
Wire Wire Line
	4300 4350 4000 4350
Wire Wire Line
	4000 4450 4300 4450
Connection ~ 4300 4450
Wire Wire Line
	6500 5100 6500 5350
Connection ~ 6500 5350
Wire Wire Line
	6600 5100 6600 5350
Connection ~ 6600 5350
Wire Wire Line
	6700 5100 6700 5350
Connection ~ 6700 5350
Wire Wire Line
	6800 5100 6800 5350
Connection ~ 6800 5350
Wire Wire Line
	6900 5100 6900 5350
Connection ~ 6900 5350
Wire Wire Line
	7000 5100 7000 5350
Connection ~ 7000 5350
Wire Wire Line
	7100 5100 7100 5350
Connection ~ 7100 5350
Text Label 3300 3000 0    60   ~ 0
1_dir
Text Label 3300 3100 0    60   ~ 0
2_dir
Text Label 3300 3200 0    60   ~ 0
3_dir
Text Label 3300 3300 0    60   ~ 0
1_run
Text Label 3300 3400 0    60   ~ 0
2_run
Text Label 3300 3500 0    60   ~ 0
3_run
Text Label 3300 3600 0    60   ~ 0
latch_a0
Text Label 3300 3700 0    60   ~ 0
latch_a1
Text Label 3300 3800 0    60   ~ 0
latch_a2
Text Label 3300 3900 0    60   ~ 0
ld_latch
Text Label 3300 4200 0    60   ~ 0
rdy_in
Text Label 3300 4000 0    60   ~ 0
new_run
Text Label 3300 4100 0    60   ~ 0
gnd
Text Label 3300 4300 0    60   ~ 0
jam_in
Wire Wire Line
	4000 2950 5600 2950
Wire Wire Line
	5600 2950 5600 3100
Wire Wire Line
	5600 3100 6000 3100
Wire Wire Line
	4000 3050 5500 3050
Wire Wire Line
	5500 3050 5500 3200
Wire Wire Line
	5500 3200 6000 3200
Wire Wire Line
	4000 3150 5400 3150
Wire Wire Line
	5400 3150 5400 3300
Wire Wire Line
	5400 3300 6000 3300
Wire Wire Line
	4000 3250 5300 3250
Wire Wire Line
	5300 3250 5300 3400
Wire Wire Line
	5300 3400 6000 3400
Wire Wire Line
	4000 3350 5200 3350
Wire Wire Line
	5200 3350 5200 3500
Wire Wire Line
	5200 3500 6000 3500
Wire Wire Line
	4000 3450 5100 3450
Wire Wire Line
	5100 3450 5100 3600
Wire Wire Line
	5100 3600 6000 3600
Wire Wire Line
	4000 3550 5000 3550
Wire Wire Line
	5000 3550 5000 3700
Wire Wire Line
	5000 3700 6000 3700
Wire Wire Line
	4000 3650 4900 3650
Wire Wire Line
	4900 3650 4900 3800
Wire Wire Line
	4900 3800 6000 3800
Wire Wire Line
	4000 3750 4800 3750
Wire Wire Line
	4800 3750 4800 3900
Wire Wire Line
	4800 3900 6000 3900
Wire Wire Line
	4000 3850 4700 3850
Wire Wire Line
	4700 3850 4700 4000
Wire Wire Line
	4700 4000 6000 4000
Wire Wire Line
	4000 3950 4600 3950
Wire Wire Line
	4600 3950 4600 4100
Wire Wire Line
	4600 4100 6000 4100
Wire Wire Line
	4300 4050 4000 4050
Connection ~ 4300 4350
Wire Wire Line
	4000 4150 4500 4150
Wire Wire Line
	4500 4150 4500 5500
Wire Wire Line
	4500 5500 7950 5500
Wire Wire Line
	7950 5500 7950 4300
Wire Wire Line
	7950 4300 7800 4300
Wire Wire Line
	4000 4250 4600 4250
Wire Wire Line
	4600 4250 4600 5600
Wire Wire Line
	4600 5600 8050 5600
Wire Wire Line
	8050 5600 8050 4200
Wire Wire Line
	8050 4200 7800 4200
Text Notes 7750 7500 0    60   ~ 0
rpi interface cable
Text Notes 8550 7650 0    60   ~ 0
9 may 2018
Text Notes 10650 7650 0    60   ~ 0
1.0a
Text Notes 7100 6700 0    60   ~ 0
raspberry pi interface cable 
$EndSCHEMATC
