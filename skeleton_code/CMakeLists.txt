cmake_minimum_required(VERSION 2.6)
project(particles)
enable_language(Fortran)

add_executable(particles main.f90 particle_defs.f90 particle_utils.f90 particle_data.f90
particle_sim.f90 vector_operations.f90)

add_library(partlib SHARED particle_defs.f90 particle_utils.f90
particle_data.f90 particle_sim.f90 particle_state.f90 vector_operations.f90)

add_custom_command(TARGET partlib
    POST_BUILD
    COMMAND f2py -m particle -c ${PROJECT_SOURCE_DIR}/particle_driver.f90 --opt=-O3 -lpartlib -L${CMAKE_BINARY_DIR}
)