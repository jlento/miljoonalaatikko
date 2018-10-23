program nnsearches

  ! Compares two algorithms for fixed-radius nearest-neighbor searches
  !
  ! Brute force "linear" algorithm should scale as O(n^2), and
  ! "lattice" as O(n+k), where n is the number of vertices and k
  ! is the number of nearest neigbors.

  use lattice, only : init_lattice, sort_vertices
  use fixed_radius, only  : nnsearch_linear, nnsearch_lattice

  implicit none


  ! *** Parameters ***

  integer, parameter :: n = 2500
  integer, parameter :: nrounds = 200
  real, parameter    :: rmax = 1.0 / real(n) ** (1.0/3.0)
  integer, parameter :: nx = 2 ** (floor(-log(2.0*rmax) / log(2.0)))
  integer, parameter :: nave = ceiling(real(n) * 16.0 * rmax ** 3.0)


  ! *** Variables ***

  real    :: vertices(4, n)
  integer :: neighbors(n * nave), ineighbors(n)
  integer :: zorder(0:nx+1, 0:nx+1, 0:nx+1)
  integer :: ibox(nx ** 3 + 1), ifbox(13, nx ** 3)

  integer :: wrk1(n), wrk2(nx ** 3)
  real    :: wrk3(4, n)

  integer :: i, status
  integer :: count1, count2, rate, linear_nnn, lattice_nnn
  real    :: linear_time, lattice_time

  write(*,'("#")')
  write(*,'("#                          Number of vertices : ",i0)') n
  write(*,'("#         Number of rounds to repeat searches : ",i0)') nrounds
  write(*,'("#                       Maximum vertex radius : ",g0)') rmax
  write(*,'("#            Number of boxes in one dimension : ",i0)') nx
  write(*,'("# Estimate of the average number of neighbors : ",i0)') nave
  write(*,'("#")')

  ! Random vertices in 1x1x1 box, with random "radii." The "data
  ! structure" for a single vertex is [x,y,z,r].

  call random_number(vertices)
  vertices(4,:) = 0.5 * (vertices(4,:) + 1.0) * rmax


  ! *** Brute force search ***

  call system_clock(count1, rate)
  do i = 1, nrounds
     call nnsearch_linear(vertices, neighbors, ineighbors, status)
  end do
  call system_clock(count2)
  linear_time = real(count2 - count1) / real(rate)
  linear_nnn = ineighbors(n)


  ! *** Lattice search ***

  call init_lattice(zorder)

  call system_clock(count1, rate)
  do i = 1, nrounds
     call sort_vertices(vertices, zorder, ibox, ifbox, wrk1, wrk2, wrk3)
     call nnsearch_lattice(vertices, ibox, ifbox, neighbors, ineighbors, status)
  end do
  call system_clock(count2, rate)
  lattice_time = real(count2 - count1) / real(rate)
  lattice_nnn = ineighbors(n)

  write(*,'("# ",4(A19))') "#nn(linear)", "#nn(lattice)",&
       & "time(linear)", "time(lattice)"
  write(*,'("  ",2(I19),2(F19.3))') linear_nnn, lattice_nnn, linear_time,&
       & lattice_time

end program nnsearches
