module packed
  implicit none

  ! Defining datastructures for storing nearest neigbour information and
  ! vertices in boxes.

  type packed_integers
     integer, allocatable :: ibin(:), data(:)
  end type packed_integers

  type packed_vertices
     integer, allocatable :: ibin(:), data(:, :)
  end type packed_vertices

  interface packed_integers
     module procedure new_packed_integers
  end interface packed_integers

  interface packed_vertices
     module procedure new_packed_vertices
  end interface packed_vertices

contains

  function new_packed_integers(n, nbins)
    type(packed_integers) :: new_packed_integers
    integer, intent(in) :: n, nbins
    allocate(new_packed_integers%ibin(nbins + 1))
    allocate(new_packed_integers%data(n))
  end function new_packed_integers

  function new_packed_vertices(n, nbins)
    type(packed_vertices) :: new_packed_vertices
    integer, intent(in) :: n, nbins
    allocate(new_packed_vertices%ibin(nbins + 1))
    allocate(new_packed_vertices%data(4, n))
  end function new_packed_vertices

end module packed
