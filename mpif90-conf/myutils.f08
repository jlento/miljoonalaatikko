module myutils
  implicit none

contains

  subroutine myutils_command_line_arg( n, strbuf )
    integer, intent(in) :: n
    character(:), allocatable, intent(out) :: strbuf
    integer :: i
    call get_command_argument(n, length = i )
    allocate( character(len=i) :: strbuf )
    call get_command_argument(n, value = strbuf )
  end subroutine myutils_command_line_arg

end module myutils
