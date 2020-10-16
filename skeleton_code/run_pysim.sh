#!/bin/sh

export PATH=./bin:$PATH
export PYTHONPATH=./bin:$PYTHONPATH
echo $PYTHONPATH
export LD_LIBRARY_PATH=./bin:$LD_LIBRARY_PATH
if [ ! -f particle.state ]; then
    echo "File particle.state not found!"
else
    echo "deleting old particle.state"
    rm particle.state
fi

#python3 particle_sim.py
python3 runSimulation.py

