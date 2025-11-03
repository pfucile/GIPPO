# GIPPO - Graph-based Iterative Printing Path Optimization

GIPPO is a comprehensive platform for the generation of complex architected lattices and their optimization towards extrusion 3D Printing using graph-theory.
It comprises three main modules:
1) Design generation and graph conversion. This occurs in Grasshopper, a plugin for Rhinoceros
2) Printing path optimization, developed in MATLAB and deployed as a standalone app with an intuitive and user-friendly GUI. Using a modified version of Prim's algorithm, the trajectories are optimized iteratively to minimize short paths, and thus weak points in the structure
3) Universal G-code generation. Back in Grasshopper, through a series of python and graphical scripts, different G-codes, compatible with different 3D printing firmwares, can be generated from the same optimized structure. There is full control on process parameters.

The entire software has been developed by Maria Kalogeropoulou, Vivek Cherian David, Pierpaolo Fucile as part of the MERLN Institute, with the supervision of Prof. Lorenzo Moroni.

This software is part of the project 3D-MENTOR (with project number 18647) of the VICI research programme, which is financed by the Dutch Research Council (NWO). 


## License
Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

## Disclaimer
This code has been tested on several 3D printing systems but might require customization depending on your printer. The code is currently in an experimental state, feel free to use this code for your projects and to contribute back to this project. 


## System requirements
GIPPO is free to use and open to users contributions. Though, to run it on your computer, you need a licensed version of Rhinoceros (at least version 8.0). MATLAB is not required, since the standalone desktop app comes with a MATLAB realtime installation. However, in order to have the optimization algorithm running faster thanks to the parallel computing module of MATLAB, a version of the software installed on your computer is suggested.

## GIPPO Installation instructions 

### Grasshopper module
Save the content of the Grasshopper Design Platform folder in your computer
Open the GIPPO_1.0.0.gh file on your Grasshopper environment.
In case some boxes appear with a warning sign, right click on them --> Update --> select the *.ghcluster file labelled above the box from the Beta_Clusters file.
In the grasshopper script, a step-by-step guide to successfully operate GIPPO is provided.

### Matlab Standalone app
Run GIPPO_Matlab_App_Installer.exe installer and follow the instructions. 
Once the app is installed, launch the *.exe file:
1) Click on the "Start parallel computing processors" to enable the multi-core processing;
2) Choose the optimization method (i.e., min-based or max-based);
3) A browsing window will pop up. Select the folder where the files from the grasshopper script (step 3) were saved;
4) Wait for the optimization to be over;
5) The "Save Optimized Path" button will pop up. Name and save the file(s). For multi-layer structures, choose the name, and GIPPO will automatically name each optimized layer (e.g., Structure_Layer_01, Structure_Layer_02, etc.);
6) Go back to Grasshopper and prepare your gcode!
