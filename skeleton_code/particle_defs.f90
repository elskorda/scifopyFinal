module particle_defs

  integer, parameter :: rk = selected_real_kind(15,300)
  integer, parameter :: ik = selected_int_kind(5)
  integer, parameter :: max_particles = 2
  real(rk), parameter :: pi = 3.141592653589793238462643383279502884197_rk
  real(rk), parameter :: vinit = 0.01
  real(rk), parameter :: radiusMin = 0.005
  real(rk), parameter :: radiusMax = 0.015
  
end module particle_defs
