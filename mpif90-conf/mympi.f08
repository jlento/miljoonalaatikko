module mympi
  use mpi
  implicit none

contains

  subroutine mympi_cache_file( file, buffer, comm )
    character(*), intent(in) :: file
    character(:), allocatable, intent(out) :: buffer
    integer, optional :: comm

    integer :: communicator, myrank, istat, s, u

    if ( present( comm ) ) then
       communicator = comm
    else
       communicator = MPI_COMM_WORLD
    end if

    call mpi_comm_rank(communicator, myrank , istat)

    if ( myrank .eq. 0 ) then
       inquire(file=file,size=s)
    end if
    call mpi_bcast( s, 1, MPI_INT, 0, communicator, istat)

    allocate(character(len=s)::buffer)

    if ( myrank .eq. 0 ) then
       open( file=file, newunit=u, access='STREAM')
       read(u) buffer
       close(u)
    end if

    call mpi_bcast( buffer, s, MPI_CHAR, 0, communicator, istat)

  end subroutine mympi_cache_file

end module mympi
