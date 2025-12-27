# FPGA ALU & Control Datapath (VHDL)

A synthesizable **8-bit Arithmetic Logic Unit (ALU)** and **Moore Finite State Machine (FSM)** control loop, designed for the **Altera Cyclone II** FPGA architecture.

![VHDL](https://img.shields.io/badge/Language-VHDL_93-00599C?style=flat-square)
![Architecture](https://img.shields.io/badge/Architecture-RTL_Design-orange?style=flat-square)
![Platform](https://img.shields.io/badge/Hardware-Altera_DE2-D1251A?style=flat-square)

## ⚡ System Architecture
This project implements a modular datapath focusing on **Register Transfer Level (RTL)** logic. It decouples the arithmetic execution (ALU) from the control logic (FSM), mimicking the execution stage of a Von Neumann architecture.

### Core Modules
* **ALU (Arithmetic Logic Unit):**
    * **Width:** 8-bit operands / 16-bit opcode.
    * **Operations:** ADD, SUB, NAND, NOR, XOR, Logical Shift, and Half-Byte Swapping.
    * **Features:** Zero-flag detection and overflow handling.
* **Control FSM:**
    * **Type:** Moore State Machine (Output depends only on current state).
    * **Logic:** 9-state transition loop driving datapath control signals.
* **I/O Drivers:**
    * **7-Segment Decoder:** Hexadecimal-to-7-segment mapping for real-time state visualization.

## 🛠️ Implementation Details
* **Hardware Target:** Altera DE2 (Cyclone II EP2C35F672C6).
* **Synthesis Tools:** Quartus II / ModelSim.
* **Clock Domain:** Single-cycle synchronous execution (Rising Edge).

## 📂 Repository Structure
```text
.
├── src/
│   ├── ALU.vhd              # Main Arithmetic Logic Unit
│   ├── FSM.vhd              # Moore State Machine Controller
│   ├── Decoder.vhd          # Instruction/Opcode Decoder
│   ├── Register8Bit.vhd     # General Purpose Storage Register
│   └── SevenSegmentDriver.vhd # LED Visualization Driver
└── README.md
```

## 🚀 Usage
1.  Import the `src/` directory into a **Quartus II** project.
2.  Set `FSM.vhd` as the Top-Level Entity.
3.  Assign pins using the Altera DE2 `.qsf` mapping.
4.  Compile and verify RTL Schematic.