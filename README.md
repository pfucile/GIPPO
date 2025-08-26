# GIPPO - Graph-based Iterative Printing Path Optimization

GIPPO is a comprehensive platform for the generation of complex architected lattices and their optimization towards extrusion 3D Printing using graph-theory.
It comprises three main modules:
1) Design generation and graph conversion. This occurs in Grasshopper, a plugin for Rhinoceros
2) Printing path optimization, developed in MATLAB and deployed as a standalone app with an intuitive and user-friendly GUI. Using a modified version of Prim's algorithm, the trajectories are optimized iteratively to minimize short paths, and thus weak points in the structure
3) Universal G-code generation. Back in Grasshopper, through a series of python and graphical scripts, different G-codes, compatible with different 3D printing firmwares, can be generated from the same optimized structure. There is full control on process parameters.


## License
Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

## Disclaimer
___This code has only been tested for a few 3D printing systems. The code is currently in an experimental state, feel free to use this code for your projects and to contribute back to this project. 


## System requirements
GIPPO is free to use and open to users contributions. Though, to run it on your computer, you need a licensed version of Rhinoceros (at least version 8.0). MATLAB is not required, since the standalone desktop app comes with a MATLAB realtime installation. However, in order to have the optimization algorithm running faster thanks to the parallel computing module of MATLAB, a version of the software installed on your computer is suggested.

## GIPPO Installation instructions 

### Grasshopper module
Save the content of the Grasshopper Design Platform folder on your computer
Open the GIPPO_1.0.0.gh file on your Grasshopper environment.
In case some boxes appear with a warning sign, right click on them --> Update --> select the *.ghcluster file labelled above the box from the Beta_Clusters file.

### Matlab Standalone app
Run GIPPO_Matlab_App_Installer.exe installer and follow the instructions. 
