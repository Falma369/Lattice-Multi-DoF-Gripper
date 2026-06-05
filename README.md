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

### 3. `Lattice Joint 20260306`
**Matlab code for the lattice generation** This folder contains the scripts required to generate the lattice structures.

**Usage:**
1. Open MATLAB and navigate to this folder, open the `Joint_1Dof_SP_Lattice_20260304` file.
2. Adjust the desired parameters and the saving location for the datas in the script to modify the resulting generated lattice structure.
3. Run the `Joint_1Dof_SP_Lattice_20260304` file.
---

### 4. `cad_models`
**Key CAD Components (Autodesk Fusion 360):** The solid components designed for structural support and mechatronic integration can be found on the Fusion360 of the CREATE Lab in the "Fexure robtic hand' folder under the name "Tifaine Mezencev".

---

## 🛠️ Prerequisites & Dependencies

To fully replicate or interact with this project, ensure you have the following software installed:
* **MATLAB** (for test-bench analysis)
* **OpenSCAD** (for mesh conversion)
* **Arduino IDE** (with the ESP8266 board manager extension installed)
* **Autodesk Fusion 360** (to view or modify the structural CAD files)
