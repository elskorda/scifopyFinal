program particles

    use particle_defs
    use particle_data
    use particle_sim

    implicit none

    type(particle_system) :: psys
    integer(rk) :: i
    

    ! allocate particle system
    call allocate_particle_system(psys,max_particles)

    !initialize particle system
    call init_particle_system(psys)

    ! print particle system after initialization
    call print_particle_system(psys)

    
    ! call write_particle_sizes(psys)
    
    call update_particle_system(psys,radiusMin/(3 * vinit))

    
    call check_boundary(psys)
    call print_particle_system(psys)
    call check_collision(psys)
    
    ! Perform particle simulation 
    ! do ...
    !    call check_collision(psys)
    !    ...
    !    call write_particle_positions(psys)
    ! end 



    ! Deallocate particle system
    call deallocate_particle_system(psys)
    
    stop
    

end program particles
