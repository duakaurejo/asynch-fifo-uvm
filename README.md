# Asynchronous FIFO UVM

This project implements a Universal Verification Methodology (UVM) testbench for verifying an asynchronous FIFO design based on the Sunburst Design paper by Clifford E. Cummings. My focus was on learning UVM and CDC (clock domain crossing) concepts through practical implementation.

## Code Access
The full project is written and simulated on EDA Playground.

[Run the testbench here](https://edaplayground.com/x/YdkP)

> Note: RTL design files are taken directly from the Sunburst paper [1].

## Architecture & Results
The UVM testbench is structured with separate write and read agents, each composed of a sequencer, driver, and monitor. A shared scoreboard checks correctness, while the environment instantiates and connects all components. Multiple tests trigger different sequence patterns (e.g., write-only, read-only, fill-then-empty, parallel) to verify FIFO behavior under various conditions.

![image](https://github.com/user-attachments/assets/c1210b14-921d-4bda-b5e9-edd69dcdb23f)
> **Figure**: Waveform showing results of the read/write parallel test across asynchronous clock domains.

## References

[1] Clifford E. Cummings, *Simulation and Synthesis Techniques for Asynchronous FIFO Design*  
    [Sunburst Design Paper (PDF)](http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf)  

[2] Explore Electronics – *Synchronous FIFO UVM Example*  
    [https://www.edaplayground.com/x/sKnN](https://www.edaplayground.com/x/sKnN)  



