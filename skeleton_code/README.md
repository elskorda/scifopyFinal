# Bouncing particles assignment

# Requirements

## Windows

All building should be done from an Anaconda prompt.

## Linux

All building should be done from an Anaconda prompt with CMake and a Fortran compiler available.

## Requirements LUNARC

Load the following modules:

    ml foss/2019a
    ml Anaconda3
    ml CMake

# Configuring and building

## Windows

    configure_and_build.cmd

This will configure and build the Fortran code and associated libraries and copy them to .\bin

## Linux

    ./configure_and_build.sh

This will configure and build the Fortran code and associated libraries and copy them to ./bin

# Rebuilding

## Windows

    build.cmd

This will build the Fortran code and associated libraries and copy them to .\bin

## Linux

    ./configure_and_build.sh

This will build the Fortran code and associated libraries and copy them to ./bin

# Running the Fortran code

## Windows

    run_fortran.cmd

This script sets up the paths required run the Fortran code. Output will be a .state file.

## Linux

    run_fortran.cmd

This script sets up the paths required run the Fortran code. Output will be a .state file.

# Visualising particle movement

Particle movement can be visualised using the particle player app.

## Windows

    run_player.cmd

Reads the state file and animate the simulation steps continously.

## Linux

    run_player.sh

Reads the state file and animate the simulation steps continously.

# Script for running Python simulation code

A template for a script needed to run the Python based particle code is provided as run_pysim.cmd and run_pysim.sh.

# Cleaning build

The build can be cleaned using the clean_build.cmd and clean_build.sh scripts. This script will remove the bin and builddir directories.
