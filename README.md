# Asynchronous FIFO UVM

This project implements a Universal Verification Methodology (UVM) testbench for verifying an asynchronous FIFO design based on the Sunburst Design paper by Clifford E. Cummings. My focus was on learning UVM and CDC (clock domain crossing) concepts through practical implementation.

## Code Access
The full project is written and simulated on EDA Playground.

[Run the testbench here](https://edaplayground.com/x/YdkP)

> Note: RTL design files are taken directly from the Sunburst paper [1].

## Motivation

While studying clock domain crossing techniques, I came across Clifford Cummings' paper on asynchronous FIFO design [1]. Around the same time, I began learning UVM due to my growing interest in RTL verification.

To combine both learning goals:
* I initially wrote a synchronous FIFO (see my other repo).
* Then, instead of writing the async FIFO RTL from scratch, I used the Sunburst RTL as a starting point so I could focus more on building the UVM environment.
* I planned to add "almost full" and "almost empty" flags to the design but haven't had time yet.

## Architecture & Results
The UVM testbench is structured with separate write and read agents, each composed of a sequencer, driver, and monitor. A shared scoreboard checks correctness, while the environment instantiates and connects all components. Multiple tests trigger different sequence patterns (e.g., write-only, read-only, fill-then-empty, parallel) to verify FIFO behavior under various conditions.

![image](https://github.com/user-attachments/assets/c1210b14-921d-4bda-b5e9-edd69dcdb23f)
> **Figure**: Waveform showing results of the read/write parallel test across asynchronous clock domains.

## References

[1] Clifford E. Cummings, *Simulation and Synthesis Techniques for Asynchronous FIFO Design*  
    [Sunburst Design Paper (PDF)](http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf)  
↳ Used for the core FIFO RTL design and CDC concepts.

[2] Explore Electronics – *Synchronous FIFO UVM Example*  
    [https://www.edaplayground.com/x/sKnN](https://www.edaplayground.com/x/sKnN)  
↳ Used  as a learning reference. I reviewed this occasionally when I got stuck understanding UVM structure or component connectivity.


