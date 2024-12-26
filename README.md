# AbPTM

## Short description
AbPTM is a web-based app developed in R/Shiny designed to detect residues prone to post-translational modifications in antibody protein sequences.

The tool allows to create a comprehensive profile for each input sequence, which includes:
* Numbering and antigen receptor classification via ANARCI (https://github.com/oxpig/ANARCI)
* Canonical loop structure annotation (including the detection of the heavy chain, light chain and CDRs) via SCALOP (https://github.com/oxpig/SCALOP)
* Detection of PTM prone residues via an embedded motif search
* Indication of residue physicochemical properties using multiple popular schemes.

Results can be downloaded in tsv format for further analysis or archiving purposes.

## Overview of the project directory tree

    <root_dir> |> AbPTM.R
               | 
               |     CODE |> AbPTM_aux.R (auxiliary functions)
               |          |> AbPTM_help.R (code for help section)
               |          |> AbPTM_themes.R (additional interface elements)
               |               
               | SOFTWARE |> ANARCI
               |          |> SCALOP              
                
---

## Computational environment
The app was developed under a ubuntu environment in R version 4.4.2.  
Follows a list of software dependencies.

### R libraries
* shiny 1.5.0
* shinydashboard 0.7.1
* shinycssloaders 1.0.0
* shinyjs 2.0.0
* gmthemes 0.2.1
* ggplot2 3.3.3
* shinyWidgets 0.5.6
* waiter 0.2.0
* shinyBS 0.61.1
* plotly 4.9.3
* DT 0.17
* seqinr 4.2-5
* dqshiny 0.0.5

### Third-party software
* [ANARCI](https://github.com/oxpig/ANARCI)  
* [SCALOP](https://github.com/oxpig/SCALOP)  

ANARCI and SCALOP must be installed in the SOFTWARE folder of the app.


### How to run
The app can be executed locally from within R by running the following commands:<br/>
setwd("AbPTM_HOME/")#..must be defined as the app root folder..<br/>
library(shiny)<br/>
runApp("AbPTM.R")
