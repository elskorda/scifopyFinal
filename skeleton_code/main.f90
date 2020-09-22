program particles

    use particle_defs
    use particle_data
    use particle_sim

    implicit none

    type(particle_system) :: psys
    integer(rk) :: i, times_to_repeat


     times_to_repeat = 100 

    call check_collision(psys)
   

    ! allocate particle system
    call allocate_particle_system(psys,max_particles)

    !initialize particle system
    call init_particle_system(psys)

    ! print particle system after initialization
    !call print_particle_system(psys)

    
    ! call write_particle_sizes(psys)
     
    ! Perform particle simulation 
    do i=1 , times_to_repeat

       call check_boundary(psys)
       call check_collision(psys)
       call update_particle_system(psys,radiusMin/(3 * vinit)) 
       !call print_particle_system(psys)   
       call write_particle_positions(psys)
    end do

    ! Deallocate particle system
    call deallocate_particle_system(psys)
    
    stop
    

end program particles
