# Bouncing particles assignment
Configure and build the Fortran code and associated libraries and copy them to ./bin

    ./configure_and_build.sh


# Running the Fortran code

    ./run_fortran.sh

# Create a F2PY interface for the Fortran code
In a terminal run the following command: 

   f2py -m particle -c particle_driver.f90 -I./build -L./build -lpartlib

# Script for running Python simulation code
The following script will open a user interface to run the simulation
    ./run_pysim.sh

# Visualising particle movement

    run_player.sh

Reads the state file and animate the simulation steps continously.


# Cleaning build

The build can be cleaned using the clean_build.cmd and clean_build.sh scripts. This script will remove the bin and builddir directories.
