@echo off

setlocal
set PATH=.\bin;%PATH%
set PYTHONPATH=.\bin;%PYTHONPATH%
python particles.py
endlocal