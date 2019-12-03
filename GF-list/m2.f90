module m2
  use m1, arr_type => integer_type
  type myarr
     type(arr_type) :: a(3)
  end type myarr
end module m2
