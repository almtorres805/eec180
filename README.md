# Digital Systems Class Repository

Welcome to my repository for the Digital Systems class with emphasis on hardware description languages (VHDL), logic synthesis, and field-programmable gate arrays (FPGA).! In this course, I worked with the Terasic DE10-Lite which is a Altera MAX 10 based FPGA board, a 32-bit Arm Cortex-M4 Wi-Fi® wireless MCU, to complete various labs. Additionally, I utilized Quartus, a programmable logic device design software, to write Verilog code and program the FPGA board, while also using ModelSim for result simulation. Below, you'll find information about the labs I completed during the course.

## Lab 1: Implementing Combinational Logic in the MAX10 FPGA
This lab consisted of 2 parts. Please refer to the [report](https://github.com/almtorres805/eec180/blob/main/Lab1_submission/Lab1_submission/lab1%20(3).pdf) for important information such as, simulated results, Karnaugh maps, truth tables, snippets, and more.

[Link to Lab1 Folder](https://github.com/almtorres805/eec180/blob/main/Lab1_submission/Lab1_submission)
### Part 1
Implementing Basic Combinational Logic Gates on the DE10-Lite Board
Following the example given in Part 0, create a new project and implement some logic gates of your choice using the switches,
buttons, LEDs and 7-segment displays on the DE10-Lite board. Download your design and verify proper operation. There are
many possible design options. A few examples are 2-, 3- or 4-input AND, NAND, OR, NOR gates. You could also use a
pushbutton to directly control an LED or segment of a 7-segment display. Note that the segments of the 7-segment display are
active-low, and bit 7 corresponds to the decimal point.

Design a “testbench” verilog module which instantiates a copy of your module, exercises the circuit through all possible input
combinations, and prints inputs and outputs alongside each other in a format that is easy to read.

### Part 2
In this part, design a simple combinational circuit so that the value of the 4-bit switch input, SW[3] – SW[0], is displayed in
decimal on HEX[1] and HEX[0]. Thus, your display will show the values 00, 01, 02, … 09, 10, 11, 12, 13, 14, 15 depending on
the positions of SW[3]–SW[0]. The other 7-segment displays (HEX5–HEX2) must be off.
Perform the following steps and show all work:
1) Write a truth table for the outputs (i.e., the segments on the HEX1 and HEX0 displays) based on the 4-bit input
(SW[3]–SW[0]).
2) Draw a Karnaugh map for each output function.
3) Use the Karnaugh map to generate logic equations for each output.
4) Implement each logic equation using a Verilog assign statement.
5) Design and implement a testbench to test the 16 input cases.
6) Compile your Verilog design and test it in the DE10-Lite board.

Later, you will learn other ways to describe combinational logic in Verilog, such as using a case statement to directly implement a
truth table without solving for the logic equations.

## Lab 2: An Adder-Based Design

Please refer to the [lab 2 report](https://github.com/almtorres805/eec180/blob/main/Lab2_Submission/Lab2_Submission/Lab2_report.pdf) and the [circuit diagram for the lab](https://github.com/almtorres805/eec180/blob/main/Lab2_Submission/Lab2_Submission/lab2_circuit_diagram.pdf)

[lab2 folder](https://github.com/almtorres805/eec180/tree/main/Lab2_Submission/Lab2_Submission)

### Part 1: A Hexadecimal display driver
Design and implement a purely-combinational (non-recursive) 7-segment
display driver module seg7.v in verilog that inputs a 4-bit signal and drives 7
outputs that correspond to 0–9, A–F with a low output turning on an LED
segment and a high output turning the corresponding segment off (active
low). Use a single case statement.

### Part 2: A Combinational 4-bit Adder
Design and implement the following modules in verilog:
1. Write a module fa.v for a full-adder in Verilog using either wires or regs. A full-adder has inputs a, b,
and ci (carry-in) and produces outputs s (sum) and co (carry-out).

2. Create a module add4bit.v in Verilog that
implements a 4-bit ripple-carry adder by instantiating
four full-adder circuits.

### Part 3: Top Level Design
Use SystemBuilder to create a new Quartus project and top-level module called top.v with the following features:
1. It instantiates two copies of add4bit.v
2. One 4-bit input of each 4-bit adder is tied to four SW switches—both adders connected to the same 4 switches
3. The other input of one adder is tied to 0000. The other input of the other adder is tied to 0001.
4. Each adder’s output is tied to a seg7.v circuit and then connected to a HEX display.
When working correctly, one hex display will show the value on the four switches and the other active hex display
will show the same value plus one. For example, if the switches are set to 1001, the two active hex displays should
display “9” and “A”. If they are set to “1111”, the displays should show “F” and “0”.

### Part 4: Implementation and Verification on the DE10-Lite
Since you are not using Modelsim to debug your design, identify the most important internal signals and connect
them to the LEDR and unused HEX LEDs for debugging purposes. Download your design onto the DE10-Lite board
and verify it works correctly.

## Lab 3: Simulating Using Testbenches
Please refer to [lab 3 report](https://github.com/almtorres805/eec180/blob/main/Lab3_submission/Lab3_submission/Report.pdf) and [lab 3 folder](https://github.com/almtorres805/eec180/blob/main/Lab3_submission/Lab3_submission)

### Part 1: Three 3-bit adder modules
Design and implement in verilog three 3-bit adders—meaning they have two 3-bit inputs, a ci carry input, and one
4-bit output. Begin by drawing detailed circuit diagrams of your add3.v and add3_error.v
1. add3.v Build using three full-adder cells.
2. add3_error.v Build using any method you like. The module adds two 3-bit numbers except for the two
cases 7 + 4 + (ci=0) = 12, where 7 and 4 can be on either input: 7 + 4 + 0 = 12 and 4 + 7 + 0 = 12.
3. add3_ref.v A Golden Reference design following the guidelines from posted handouts; for example, it
must be written in a fundamentally different way than add3.v

### Part 2: Testbench #1
Design and implement in verilog a testbench that uses Approach #1 (one large initial block, however you do not
need a clock for this lab) explained on slides 115–116 in the Verilog 5: Testing handout.
A) Test fifteen different input cases for add3.v and print inputs and outputs in text so it is clear your adder is
functioning correctly. You must include these cases: 0+0, 0+1, 1+0, 5+5, 7+0, 0+7, 7+7.
B) Using the same testbench, generate waveforms that show any ten test cases clearly enough to verify correct
operation.

### Part 3: Testbench #2
Design and implement in verilog a testbench that uses the “Golden Reference” verification method explained in the
Verilog 5: Testing handout. Use add3.v for the hardware design and use add3_ref.v for the golden reference. In
addition to printing the input and output, it must also print “pass” or “fail” depending on whether the hardware
design matches the reference.
A) Test all possible input cases.
B) Again test all possible input cases but use add3_error.v instead of add3.v to verify your testbench is checking
correctly.

## Lab 4: A Flip-Flop-Based Shift Register
Please refer to [lab 4 report](https://github.com/almtorres805/eec180/blob/main/Lab4_submission/report.pdf) and [lab 4 folder](https://github.com/almtorres805/eec180/blob/main/Lab4_submission)

### Circuit Description
A circuit contains ten positive-edge-triggered D flip-flops (FFs) wired in a chain with one LEDR LED connected to
the output of each FF, and also some additional circuits to implement the following functions:
- Each time the system is clocked one cycle, the pattern of lit LEDs moves one position to the right when the
DE10-Lite board is viewed with the SW switches on the bottom
- The KEY0 button makes the clock signal go high when pressed and makes it go low when released. (Although
this violates one of our two clock-related rules, we will do it anyway for this lab only because building this
functionality correctly with a true multi-MHz clock is significantly more complex. Tell your TA if you
observe strange behavior such as an LED occasionally skipping over one LEDR position.)
- The KEY1 button initializes the values in the ten FFs if held pressed during an active clock edge. The
initialized values depends on the position of several SW switches; how you do this is up to you. Consider
what happens for all positions that the SW switches may be in and describe in your report.

a) 00_0000_0000 all LEDs off

b) 11_1111_1111 all LEDs on

c) 10_1010_1010 alternating pattern (LEDR9, …, LEDR0)
- In most cases, the input to the leftmost FF injects zeros into the shift register chain. Only in the case when all
LEDs are off, the circuit will inject a one into the shift register chain. If built properly, the chain will circulate
a single lit LED after ten clock cycles, no matter what the beginning pattern happened to be.


## Lab 5: Counter Design
Please refer to [lab 5 report](https://github.com/almtorres805/eec180/blob/main/lab5_submission/Lab5_report.pdf) for circuit diagram and [lab 5 folder](https://github.com/almtorres805/eec180/blob/main/lab5_submission)

This lab involves the design and implementation of counting circuits that display values on the DE10-Lite’s
7-segment displays. All circuits are synchronously clocked by only the 50 MHz standard clock. 

### Part 1: Counter1 - Pulse Generator
The first counter contains 6 bits and counts in a circular sequence from all zeros to divideby minus one. It has 4 I/O ports

### Part 2: Counter2 - Main Counter 
The second counter contains 24 bits and has 6 I/O ports.

### Part 3: Top Level
Create a top level module with an instance of Counter1 and Counter2 that are connected to each other, switches,
keys, LEDs, and displays as described.
Connect the 24-bit counter2 display output to the board’s 7-segment displays using your seg7.v module from the
earlier lab, so that display is shown as 6 hexadecimal digits.

### Part 4: Test Bench
Design and write a testbench for your Counter1 module that exercises all functions.
Design and write a testbench for your top-level module that exercises all functions.
Once your test benches are working correctly, demonstrate them to your TA and have them checked off.
Suggestion: implement multiple independent tests that are shorter in length and focus on specific features.

### Part 5: Demonstrate functionality on FPGA board

## Lab 6: Matrix Multiplication
