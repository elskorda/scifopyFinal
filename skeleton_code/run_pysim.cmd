@echo off

setlocal
set PATH=.\bin;%PATH%
set PYTHONPATH=.\bin;%PYTHONPATH%
python particle_sim.py
endlocal