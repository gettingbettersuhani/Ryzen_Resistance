**FPGA-Based Real-Time ECG Arrhythmia Detection**

**Project Overview:**

This project implements a real-time ECG arrhythmia detection system directly on FPGA hardware using a fixed-point Logistic Regression model.

The model is trained in Python using features extracted from the MIT-BIH ECG dataset and then deployed onto a Nexys A7 FPGA board as a hardware-based inference engine.

The system eliminates cloud dependency and enables low-latency, energy-efficient biomedical signal classification at the edge.
____________________________________________________________________________________________________________________________________________________________________________________
**System Architecture:**

The architecture is divided into two main stages:

**Software Training Stage**
1. Load MIT-BIH dataset
2. Extract ECG features
3. Train Logistic Regression model
4. Convert weights to fixed-point format

**Hardware Inference Stage**

1. Fixed-point feature input
2. Multiply-and-add computation block
3. Bias addition
4. Threshold decision logic
5. Binary classification output
________________________________________________________________________________________________________________________________________________________________________________________________

**Model Details**
*Model:* Logistic Regression
*Features Used:*
1. Mean
2. Variance
3. Maximum value
4. Minimum value
5. RR Interval

*Classification:*
0 → Normal
1 → Arrhythmia
__________________________________________________________________________________________________________________________________________________________________
