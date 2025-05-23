# Calculator in Assembly

This is a basic calculator that is written using assembly programming and is run on Easy68k. This project is part of my introduction to microprocessor course in my university.

## Features

- Do logical (AND, OR, NOT, XOR) and arithmetics (addition, subtraction, multiplication, division) operations.
- Handles signed numbers
- Gives quotient and remainder for division operation
- Logical operations only accept binary numbers. If non-binary numbers are given, program will restart.

## Progress

:white_check_mark: addition, subtraction, multiplication, division, AND, OR, XOR, NOT, trim binary output

## Bugs

- When doing logical operations, it successfully trims the output only at the first instance. The next instance of logical operation will also include some of unchanged numbers in the memory from the previous calculation.

