contains

  function unit()
    type(list), pointer :: unit
    unit => null()
  end function unit

  function sexpr( x, self )
    type( element_type )   :: x
    class( list )          :: self
    class( list ), pointer :: sexpr
  end function sexpr
    
  function car(self)
    class(list)          :: self
    type(element_type)   :: car
  end function car

  function cdr(self)
    class(list)          :: self
    class(list), pointer :: cdr
  end function cdr
