module particle_data

    use particle_defs
    use particle_utils

    implicit none

    type particle_system
        integer(ik) :: n_particles
        real(rk) :: v0
        real(rk) :: rmin
        real(rk) :: rmax
        real(rk) :: dt
        real(rk), allocatable :: pos(:,:)
        real(rk), allocatable :: vel(:,:)
        real(rk), allocatable :: r(:)
     end type particle_system

contains

    subroutine allocate_particle_system(psys, n)

      integer(ik), intent(in) :: n
      type(particle_system) :: psys
      allocate(psys%pos(n,2))
      allocate(psys%vel(n,2))
      allocate(psys%r(n))
    end subroutine allocate_particle_system

    subroutine deallocate_particle_system(psys)
        type(particle_system) :: psys
        deallocate(psys%pos)
        deallocate(psys%vel)
        deallocate(psys%r)
        psys%n_particles=-1
    end subroutine deallocate_particle_system

    subroutine init_particle_system(psys)
      type(particle_system), intent(inout) :: psys
      integer(ik) :: i
      real(ik):: myrand, x, y 
      psys%n_particles= max_particles 
      psys%v0 = vinit
      psys%rmin = radiusMin
      psys%rmax = radiusMax
      psys%dt = radiusMin/(3 * vinit)

      write(*,'(F12.5)'),radiusMax
      
      call init_random_seed()
      do i = 1, max_particles
         
         ! fill the size (r) of each ball/particle
         call random_number(myrand)
         myrand = myrand/100 +0.005
         psys%r(i) = myrand
         
         !call random again to create the angle for the initial velocity
         call random_number(myrand)
         myrand = myrand*2*pi
         psys%vel(i,1) =  psys%v0 * cos(myrand)
         psys%vel(i,2)  =  psys%v0 * sin(myrand) 
                  
         !create the positions of the particles
         call random_number(x)
         call random_number(y)
         psys % pos(i, 1) = x
         psys % pos(i, 2) = y
      
      end do        
    end subroutine init_particle_system

    subroutine print_particle_system(psys)
        
        ! Pretty print the particle system

        type(particle_system), intent(inout) :: psys
        integer(ik) :: i
      
        ! print *, 'Max particle x coord = ', maxval(psys % pos(:, 1))
        ! print *, 'Min particle x coord = ', minval(psys % pos(:, 1))
        ! print *, 'Max particle y coord = ', maxval(psys % pos(:, 2))
        ! print *, 'Min particle y coord = ', minval(psys % pos(:, 2))
 
        write(*,*) '----- Particle postion - velocity -----------------------------'
        do i=1,psys%n_particles
            write(*,'(2F12.5,A5,2F12.5)') psys%pos(i,:), '-', psys%vel(i,:)
        end do
         
        write(*,*) '----- Particle size -------------------------------------------'
        do i=1,psys%n_particles
                write(*,'(F12.5)') psys%r(i)
        end do


    end subroutine print_particle_system

    subroutine write_particle_sizes(psys)
        
        ! Append particle sizes to particle state file (particle.state)

        type(particle_system), intent(inout) :: psys
        integer(ik) :: i

        open(unit = 15, file = 'particle.state', access = 'APPEND')
        write(15, '(I10)') psys % n_particles
        do i = 1, psys % n_particles
            write(15, '(2F12.5)') psys % r(i)
        end do
        close(unit = 15)

    end subroutine write_particle_sizes

    subroutine write_particle_positions(psys)
        
        ! Append current position to particle state file (particle.state)

        type(particle_system), intent(inout) :: psys
        integer(ik) :: i

        open(unit = 15, file = 'particle.state', access = 'APPEND')
        write(15, '(I10)') psys % n_particles
        do i = 1, psys % n_particles
            write(15, '(2F12.5)') psys % pos(i,:)
        end do
        close(unit = 15)

    end subroutine write_particle_positions

end module particle_data
