module m1
  type integer_type
     integer :: i
  end type integer_type
end module m1

module m2
  use m1, arr_type => integer_type
  type myarr
     type(arr_type) :: a(3)
  end type myarr
end module m2

program p
  use m2, int_array => myarr
  type(int_array) :: x
  x % a (:) % i = [1,2,3]
  print *, x % a (2 ) % i
end program p
