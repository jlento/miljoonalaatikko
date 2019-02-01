program myapp
  use mympi
  use myutils
  implicit none

  ! Myapp configuration defaults
  integer :: maxruntime = 60     ! seconds
  integer :: griddims(3) =(/ 10, 20, 30 /)
  namelist /myapp_conf/ maxruntime, griddims

  ! Local variables
  integer :: istat, irank, myrank, commsize
  character(:), allocatable :: strbuf

  ! The usual MPI stuff
  call mpi_init(istat)
  call mpi_comm_size(MPI_COMM_WORLD, commsize , istat)
  call mpi_comm_rank(MPI_COMM_WORLD, myrank , istat)

  ! Read configuration from file
  call mympi_cache_file( file='myapp.conf', buffer=strbuf )
  read(strbuf, nml = myapp_conf)
  deallocate( strbuf )

  ! Read configuration from command line
  if ( command_argument_count() .gt. 0 ) then
    call myutils_command_line_arg( 1, strbuf )
    read(strbuf, nml = myapp_conf)
    deallocate( strbuf )
 end if

  ! Print configuration to stdout
  do irank = 0, commsize - 1
     if ( irank .eq. myrank ) then
        write(*,fmt='(A,I5,A)') '=== task ', myrank, ' ==='
        write(*,nml=myapp_conf)
     end if
     call mpi_barrier(MPI_COMM_WORLD, istat)
  end do

  call mpi_finalize(istat)

end program myapp
