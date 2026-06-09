# Lattice-Multi-DoF-Gripper
Semester Project - Tifaine Mezencev - CREATE Lab

This repository contains the code and resources for the Lattice Multi-DoF Gripper project.

## 📁 Repository Structure

### 1. `code_motor_control`
**Motor control file** This folder contains the code to upload to the ESP8266 microprocessor to control the motors. 

**How to access the Web User Interface:**
1. Power on the ESP8266.
2. From your computer or smartphone, connect to the created Wi-Fi network:
   * **Network Name (SSID):** `Gripper-WiFi`
   * **Password:** `epfl2026`
3. Open any internet browser and enter the following address: `http://192.168.4.1/`
4. The user interface will then appear, allowing you to control the thre servo motors of the gripper.

---

### 2. `Test-bench computation and resulting graphs`
**Test-bench: tension VS resulting angle** These are the MATLAB files containing the code for the angle versus tension force computation, as well as the resulting graphs from the test bench.

---

### 3. `cad_models`
**Key CAD Components (Autodesk Fusion 360):** The solid components designed for structural support and mechatronic integration can be found on the Fusion360 of the CREATE Lab in the "Fexure robtic hand' folder under the name "Tifaine Mezencev".

---

## 🛠️ Prerequisites & Dependencies

To fully replicate or interact with this project, ensure you have the following software installed:
* **MATLAB** (for test-bench analysis)
* **OpenSCAD** (for mesh conversion)
* **Arduino IDE** (with the ESP8266 board manager extension installed)
* **Autodesk Fusion 360** (to view or modify the structural CAD files)
