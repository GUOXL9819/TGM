# Temperature Gradient Method for Extracting Background Temperature and Calculating Temperature Rise Area of Nuclear Power Plants' Thermal Discharge

## Project Overview
This project utilizes the **Temperature Gradient Method (TGM)** to calculate the background temperature and temperature rise area of thermal discharge from nuclear power plants.

## Methodology
TGM follows these main steps:

1. **Data Acquisition**
   - Use the thermal infrared bands of Landsat 8/9 TIRS sensors to calculate Water Surface Temperature (WST).
   - Apply the Radiative Transfer Equation (RTE) for SST retrieval.

2. **Water Body Identification**
   - Compute the **Modified Normalized Difference Water Index (MNDWI)** to distinguish water bodies from land.
   - Apply a thresholding method to remove land temperature data, ensuring calculations are limited to water bodies.

3. **Background Temperature Calculation**
   - Compute the spatial gradient of water surface temperature.
   - Set a critical gradient to determine the background temperature.

4. **Thermal Discharge Diffusion Analysis**
   - Calculate the area of thermal discharge diffusion.
   - Analyze the diffusion characteristics in different geographic regions, such as bays, coastal areas, and lakes.

5. **Results Output**
   - Generate visual representations of thermal discharge impact areas (PNG).
   - Output calculation results in CSV format.

## Data Input
- **Satellite Data**: Landsat 8/9 water surface temperature data

## Data Output
- **Thermal Discharge Impact Area** (PNG)

## Note
Currently, we have only uploaded the MATLAB version of the program for calculating background temperature and temperature rise area using the Temperature Gradient Method, provided for reference. In the future, we will also add the water surface temperature calculation program and the Python version of the program. We apologize for any inconvenience this may cause.

## Contact
For more information, please contact the author at: **gxinglong0222@163.com**
