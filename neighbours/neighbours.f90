program neighbours

  ! Compares two algorithms for fixed-radius nearest-neighbor searches
  !
  ! Brute force "linear" algorithm should scale as O(n^2), and
  ! "lattice" as O(n+k), where n is the number of vertices and k
  ! is the average number of nearest neigbors.

  use nearest_neighbours

  implicit none

  integer, parameter    :: n = 2500, nrounds = 1
  type(packed_vertices) :: vertices
  type(packed_integers) :: neighbour

  integer, allocatable :: ibox(:), ifbox(:, :)
  integer, allocatable :: zorder_table(:, :, :), izorder(:, :, :)

  integer              :: i, j, k, ii, nave, status, nx
  integer              :: count1, count2, rate, linear_time, lattice_time
  real                 :: rmax

  ! Prepare random vertices in 1x1x1 box, with random "radii." The "data
  ! structure" for a single vertex is [x,y,z,r].

  ! Maximum vertex radius

  rmax = 1.0 / real(n) ** (1.0/3.0)

  ! Number of boxes in one dimension (2^n)

  nx = 2 ** floor(log(rmax) / log(2.0))

  ! Allocate vertex data structure

  vertices = packed_vertices(n, nx ** 3)

  ! Generate random positions and radii

  call random_number(vertex%data)
  vertex%data(4,:) = 0.5 * (vertexdata(4,:) + 1.0) / n**(1.0/3.0)

  ! Estimate the average number of neighbours + some headroom

  nave = ceiling(real(n) * 16.0 * rmax ** 3.0)

  ! Allocate nearest neighbour data structure

  neighbour = packed_integers(n * nave, n)


  ! *** Brute force search ***

  call system_clock(count1, rate)
  do i = 1, nrounds
     call linear(vertex, 1, n, neighbour, status)
  end do
  call system_clock(count2)
  linear_time = (count2 - count1) / rate


  ! *** Lattice search ***


  ! Lookup table for Z-ordering (Morton order) lattice boxes

  allocate(zorder_table(nx, nx, nx))
  call init_zorder_table(nx, zorder_table)

  ! Lookup tables for finding boxes and their "forward boxes" in ordered vertex
  ! array
  !
  ! ibox(nx + 1) is used just for computing the number of vertices in ibox(nx),
  ! and ibox(nx + 2) (= 0) is used as "no forward box in this direction."

  allocate(ibox(nx ** 3 + 2), ifbox(nx ** 3, 7))


!  sv = 0
!  nv = 0
!  iv = 0
!  call system_clock(count1, rate)
!  do i = 1, nrounds
!     call sort_vertices(n, nx, vertex, ibox, zorder_table, izorder)
!     call lattice(vertex, nx, sv, nv, iv, status)
!  end do
!  call system_clock(count2, rate)
!  print *, "Number of vertices in bins ", sum(nv)
!  print *, "Max number of vertices in a single bin ", maxval(nv)
!  print *, "Min number of vertices in a single bin ", minval(nv)
!  print *, "Length of neighbour index list ", sv(n-1) + nv(n-1) - 1
!  print *, "Boxed neighbour search status ", status
!  print *, "Boxed neighbour search took ", real(count2 - count1) / real(rate)
!  print *
!  print *, nv
!  print *, sv
!  print *, iv(1:sv(n-1) + nv(n-1) - 1)
!  print *

  !  if (status == 0) then
!     do i = 1, n
!       write(*,'(21(i4))') nn(i,:)
!     end do
!  else
!     print *, 'Error: nnmax exceeded!'
!  end if

end program neighbours
