module particle_sim

    use particle_defs
    use particle_data
    use vector_operations

    implicit none

contains

    subroutine update_particle_system(psys, dtin)
        
        ! Update positions of particle system
        
        type(particle_system), intent(inout) :: psys
        real(rk), intent(in), optional :: dtin
        real(rk) :: dt
        integer(ik):: i

        if (present(dtin)) then
            dt = dtin
        else
            dt = psys % rmin/(3.0_rk * psys % v0)
        end if

        ! Update particles here
        do i = 1, psys % n_particles
           psys % pos(i, 1) = psys % pos(i, 1)+ dt * psys % vel(i,1)
           psys % pos(i, 2) = psys % pos(i, 2)+ dt * psys % vel(i,2)
        end do
        
    end subroutine update_particle_system

    subroutine check_boundary(psys)
        
        ! Check for boundary collision
        type(particle_system), intent(inout) :: psys
        integer(ik) :: i
        ! Implement check for collision with boundary
        do i=1,psys%n_particles
           if ( psys%pos(i,1) .gt. 1.0 - psys % r(i) .or. psys%pos(i,1) .lt. psys % r(i) .or. psys%pos(i,1) .lt. 0.0)  then 
              print *,"collision with wall y"
              print *,psys % vel(i,1), "before"
              psys % vel(i,1) = - psys % vel(i,1)
              print *,psys % vel(i,1), "after"
              call update_particle_system(psys) 
           end if
           if (psys%pos(i,2) .gt. 1.0 -psys % r(i) .or. psys%pos(i,2) .lt. psys %r(i) .or. psys%pos(i,2) .lt. 0.0 ) then 
              print *,"collision with wall x"
              print *,psys % vel(i,2), "before"
              psys % vel(i,2) = - psys % vel(i,2)
              print *,psys % vel(i,2), "after"
              call update_particle_system(psys) 
           end if
        end do

    end subroutine check_boundary

    subroutine check_collision(psys)
        
        ! Check for particle collisions and update if neccesary
        type(particle_system), intent(inout) :: psys
        integer(ik):: i,j
        real(ik) :: colldist 
        real(8) :: myfactor
        type(vector) :: pos1,pos2, vel1,vel2, diffpos,diffvel

        ! check all possible combinations betwen particles
        do i=1,psys%n_particles
           do j=i+1,psys%n_particles

              !create vector types for the position of particles i,j
              pos1%c(1)= psys%pos(i,1)
              pos1%c(2)= psys%pos(i,2)
              pos2%c(1)= psys%pos(j,1)
              pos2%c(2)= psys%pos(j,2)
              
              !create vector types for the velocity of particle i,j             
              vel2%c(1)= psys%vel(j,1)
              vel2%c(2)= psys%vel(j,2)
              vel1%c(1)= psys%vel(i,1)
              vel1%c(2)= psys%vel(i,2)

              ! collision distance 
              colldist = psys%r(i) +psys%r(j)

              !if particles collide update their velocities
              if ( sqrt(vector_dot_vector(pos2-pos1,pos2-pos1)) .le. colldist ) then
                 diffpos = pos2-pos1
                 diffvel = vel2-vel1
                 myfactor = vector_dot_vector(diffvel,diffpos)/vector_dot_vector(diffpos,diffpos)
                 vel1 = vel1 +   diffpos * myfactor

                 ! now change the formula to update the velocity of particle j 
                 diffvel = vel1-vel2
                 myfactor = vector_dot_vector(diffvel,diffpos)/vector_dot_vector(diffpos,diffpos)
                 vel2 = vel2 +   diffpos * myfactor

                 !we need to update the particle system as well
                 psys%vel(i,1)=vel1%c(1) 
                 psys%vel(i,2)=vel1%c(2) 
                 psys%vel(j,1)=vel2%c(1) 
                 psys%vel(j,2)=vel2%c(2)
                 call update_particle_system(psys) 
                 print *,"collision with of particles ",i,j
                 
              end if
           end do
        end do
        
    end subroutine check_collision

end module particle_sim
