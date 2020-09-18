@echo off

setlocal
set PATH=.\bin;%PATH%
set PYTHONPATH=.\bin;%PYTHONPATH%
python configure_and_build.py
endlocal