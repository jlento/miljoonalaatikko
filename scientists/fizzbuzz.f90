program fizzbuzz
  implicit none
  integer :: i

  do i = 1, 21
     write (*, '(3A10)') iffy(i), early(i), mathy(i)
  end do

contains

  function iffy(i) result (str)

    integer, intent(in) :: i
    character (len = 10) :: str

    if (mod(i, 3) == 0) then
       if (mod(i, 5) == 0) then
          str = 'FizzBuzz'
       else
          str = 'Fizz'
       end if
    else if (mod(i, 5) == 0) then
       str = 'Buzz'
    else
       write (str, '(G0)') i
    end if

  end function iffy
  

  function early(i) result (str)

    integer, intent(in) :: i
    character (len = 10) :: str

    if (mod(i, 5) == 0 .and. mod(i, 3) == 0) then
       str = 'FizzBuzz'
       return
    end if
    if (mod(i, 3) == 0) then
       str = 'Fizz'
       return
    end if
    if (mod(i, 5) == 0) then
       str = 'Buzz'
       return
    end if
    write (str, '(G0)') i

  end function early

  function mathy(i) result (str)

    integer, intent(in) :: i
    character (len = 10) :: str

    select case (mod(i, 15))
    case (0)
       str = 'FizzBuzz'
    case (3, 6, 9, 12)
       str = 'Fizz'
    case (5, 10)
       str = 'Buzz'
    case default
       write (str, '(G0)') i
    end select

  end function mathy

end program fizzbuzz
