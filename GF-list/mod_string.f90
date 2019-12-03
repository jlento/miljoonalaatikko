module mod_string
  implicit none
  type string
     character(len=:), allocatable :: data
  end type string
end module mod_string
