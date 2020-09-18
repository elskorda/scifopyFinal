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
           if (1-psys%pos(i,1) .le. psys%r(i) .or.  psys%pos(i,1) .le. psys%r(i) )  then 
              ! print *,"particle ", i, " bounces in the horizontal  boundary"
              psys % vel(i,2) = -1.* psys % vel(i,2)
           else if (1-psys%pos(i,2) .le. psys%r(i) .or. psys%pos(i,2) .le. psys%r(i)) then 
              print *,"particle ", i, " bounces in the vertical  boundary"
              ! psys % vel(i,1) = -1.* psys % vel(i,1)
           else
              print *, i ," :: ", psys%pos(i,1), "," , psys%pos(i,2), " with r= " ,  psys%r(i)
              !     (1-psys%pos(i,1) < psys%r(i)) the
           end if
        end do

    end subroutine check_boundary

    subroutine check_collision(psys)
        
        ! Check for particle collisions and update if neccesary
        type(particle_system), intent(inout) :: psys
        integer(ik):: i,j
        real(ik) :: diffx, diffy , colldist
        ! check all possible combinations betwen particles
        do i=1,psys%n_particles
           do j=i+1,psys%n_particles
              diffx = (psys%pos(i,1)- psys%pos(j,1) )
              diffy = (psys%pos(i,2)- psys%pos(j,2) )
              colldist = psys%r(i) +psys%r(j)
              if ( sqrt( diffx*diffx + diffy*diffy) .le. colldist ) then
                 write(*,'(A5,2F12.5,A5,2F12.5,A5)')'particles', i, 'and ', j,'collide'
              end if
           end do
        end do
        
    end subroutine check_collision

end module particle_sim
