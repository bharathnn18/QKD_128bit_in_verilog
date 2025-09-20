# 🔐 128-bit QKD Implementation in Verilog

## 📌 Overview
This project implements a **128-bit Quantum Key Distribution (QKD)** system using **Verilog** for hardware design and **Python** for quantum random number generation.  
The final output is a **QKD-based 128-bit secret key** that can be directly used in any cryptographic algorithm requiring a 128-bit user-provided key. This ensures a stronger and more secure key distribution mechanism compared to conventional methods.

---

## 🧩 Project Flow
1. **Quantum Random Number Generation (Python)**
   - Python script generates true random numbers using quantum-inspired logic.
   - Output is stored in a `.mem` file with the format:
     ```
     abc
     ```
     where:
     - `a` → Sender’s random number  
     - `b` → Sender’s random basis  
     - `c` → Receiver’s random basis  

2. **Classical Post-Processing (Verilog)**
   - The `.mem` file is read into the Verilog design.  
   - Verilog handles the **classical BB84 steps**, such as:
     - Basis comparison  
     - Sifted key extraction  
     - Error correction & final key generation  

3. **128-bit Secret Key**
   - A secure **128-bit QKD key** is generated.  
   - This key can be used in:
     - AES-128  
     - Twofish  
     - Any cryptographic algorithm requiring a 128-bit key
