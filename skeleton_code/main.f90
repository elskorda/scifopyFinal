program particles

    use particle_defs
    use particle_data
    use particle_sim

    implicit none

    type(particle_system) :: psys
    integer(rk) :: l, times_to_repeat


    times_to_repeat = 100 

    call check_collision(psys)
   

    ! allocate particle system
    call allocate_particle_system(psys,max_particles)

    !initialize particle system
    call init_particle_system(psys)

    ! print particle system after initialization
    

    
    call write_particle_sizes(psys)
     
    ! Perform particle simulation 
    do l=1 , times_to_repeat
       call print_particle_system(psys)
       call check_boundary(psys)
       call update_particle_system(psys,psys%dt) 
       call check_collision(psys)
       call update_particle_system(psys,psys%dt) 
       !call print_particle_system(psys)   
       call write_particle_positions(psys)
    end do

    ! Deallocate particle system
    call deallocate_particle_system(psys)
    
    stop
    

end program particles
