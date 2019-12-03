module mod_cell
  use iso_fortran_env, only : error_unit
  implicit none

  type, abstract :: cell
  end type cell

  type, extends ( cell ) :: empty_cell
  end type empty_cell

  type ( empty_cell ), target :: unit

contains

  function empty()
    type ( empty_cell ), pointer :: empty
    empty => unit
  end function empty

  function isempty ( c )
    logical :: isempty
    class ( cell ) :: c
    select type ( c )
    type is ( empty_cell )
       isempty = .true.
    class default
       isempty = .false.
    end select
  end function isempty

end module mod_cell

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module mod_cons_cell
  use mod_cell
  implicit none

  type, extends ( cell ) :: cons_cell
     class ( * ), pointer :: car_ptr, cdr_ptr
     integer :: nrefs = 0
  end type cons_cell

contains

  function car ( self )
    class ( * ), pointer :: car
    class ( cell ) :: self
    select type ( self )
    type is (cons_cell )
       car => self % car_ptr
    class default
       write(error_unit,'("ERROR: Called car() on non cons cell.")')
       stop 1
    end select
  end function car

  function cdr ( self )
    class ( * ), pointer :: cdr
    class ( cell ) :: self
    select type ( self )
    type is (cons_cell )
       cdr => self % cdr_ptr
    class default
       write(error_unit,'("ERROR: Called cdr() on non cons cell.")')
       stop 1
    end select
  end function cdr

  function new_cons_cell ( car, cdr, nrefs )
    type ( cons_cell ), pointer :: new_cons_cell
    class ( * ), pointer :: car, cdr
    integer :: nrefs
    allocate ( new_cons_cell )
    new_cons_cell % car_ptr => car
    new_cons_cell % cdr_ptr => cdr
    new_cons_cell % nrefs = nrefs
  end function new_cons_cell

  subroutine incr ( self )
    class ( cell ) :: self
    select type ( self )
    type is ( empty_cell )
       write(error_unit,'("ERROR: Called incr() on empty cell.")')
       stop 1
    type is (cons_cell )
       self % nrefs = self % nrefs + 1
    end select
  end subroutine incr

  subroutine decr ( self )
    class ( cell ) :: self
    select type ( self )
    type is ( empty_cell )
       write(error_unit,'("ERROR: Called decr() on empty cell.")')
       stop 1
    type is (cons_cell )
       self % nrefs = self % nrefs - 1
    end select
  end subroutine decr

end module mod_cons_cell

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module mod_integer_list
  use mod_cons_cell
  implicit none

  type integer_list
     class ( cell ), pointer :: ptr
   contains
     final :: integer_list_free
  end type integer_list

  interface cons
     procedure integer_list_cons_to_integer_list, integer_list_cons_to_empty
  end interface cons

  interface operator (.cons.)
     procedure integer_list_cons_to_integer_list, integer_list_cons_to_empty
  end interface operator (.cons.)

  interface head
     procedure integer_list_head
  end interface head

  interface tail
     procedure integer_list_tail
  end interface tail

  interface free
     procedure integer_list_free
  end interface free

  interface assignment(=)
     procedure integer_list_assign_integer_list, integer_list_assign_empty
  end interface assignment(=)

contains

!  function integer_list_empty()
!    type ( integer_list ) :: integer_list_empty
!    integer_list_empty % ptr => unit
!  end function integer_list_empty

  function integer_list_cons_to_empty ( x, xs )
    type ( integer_list ) :: integer_list_cons_to_empty
    integer, intent ( in ) :: x
    type ( empty_cell ), intent(in) :: xs
    type ( cons_cell ), pointer :: new_cons_cell
    integer, pointer :: val
    print *, 'allocating'
    allocate ( val, source = x )
    allocate ( new_cons_cell, source = cons_cell ( val, empty(), 1 ) )
    integer_list_cons_to_empty % ptr => new_cons_cell
  end function integer_list_cons_to_empty

  function integer_list_cons_to_integer_list ( x, xs )
    type ( integer_list ) :: integer_list_cons_to_integer_list
    integer, intent ( in ) :: x
    type ( integer_list ), intent(in) :: xs
    type ( cons_cell ), pointer :: new_cons_cell
    integer, pointer :: val
    print *, 'allocating'
    allocate ( val, source = x )
    allocate ( new_cons_cell, source = cons_cell ( val, xs % ptr, 1 ) )
    if ( .not. isempty ( xs % ptr ) ) call incr ( xs % ptr )
    integer_list_cons_to_integer_list % ptr => new_cons_cell
  end function integer_list_cons_to_integer_list

  function integer_list_head( xs )
    integer :: integer_list_head
    type ( integer_list ), intent(in) :: xs
    if ( isempty ( xs % ptr ) ) then
       write(error_unit,'("ERROR: Called head() on empty list.")')
       stop 1
    else
       select type ( p => car ( xs % ptr ) )
       type is ( integer )
          integer_list_head = p
       class default
          write(error_unit,'("ERROR: List element is not an integer?")')
          stop 1
       end select
    end if
  end function integer_list_head

  function integer_list_tail( xs )
    type ( integer_list ) :: integer_list_tail, xs
    if ( isempty ( xs % ptr ) ) then
       write(error_unit,'("ERROR: Called tail() on empty list.")')
       stop 1
    else
       select type ( p => cdr ( xs % ptr ) )
       class is ( cell )
          integer_list_tail % ptr => p
          if ( .not. isempty ( integer_list_tail % ptr ) ) call incr ( p )
       class default
          write ( error_unit,*) 'Tail is not a cell?'
          stop 1
       end select
    end if
  end function integer_list_tail

  subroutine integer_list_assign_integer_list ( ys, xs )
     type ( integer_list ), intent(in)  :: xs
     type ( integer_list ), intent(out) :: ys
     ys % ptr => xs % ptr
     call incr ( xs % ptr )
   end subroutine integer_list_assign_integer_list

  subroutine integer_list_assign_empty ( ys, xs )
     type ( empty_cell ), intent(in)  :: xs
     type ( integer_list ), intent(out) :: ys
     ys % ptr => unit
   end subroutine integer_list_assign_empty

   subroutine integer_list_free ( xs )
     type ( integer_list ) :: xs
     if ( associated ( xs % ptr ) ) then
        call free_cell ( xs % ptr )
     end if
   contains
     recursive subroutine free_cell ( ptr )
       class ( cell ), pointer :: ptr
       call decr ( ptr )
       select type ( p => ptr )
       type is ( cons_cell )
          if ( p % nrefs .lt. 1 ) then
             call free_cell ( ptr )
             print *, 'de-allocating'
             if ( associated ( p % car_ptr ) ) deallocate ( p % car_ptr )
             if ( associated ( p % cdr_ptr ) ) deallocate ( p % cdr_ptr )
             deallocate ( ptr )
          end if
       end select
     end subroutine free_cell
   end subroutine integer_list_free

end module mod_integer_list
