! Type 'generic_type' comes from the wrapper

  type, abstract ::  abstract_list
   contains
     procedure(car), deferred :: head
     procedure(cdr), deferred :: tail
  end type abstract_list

  abstract interface
     function car(self)
       import abstract_list
       import generic_type
       class(abstract_list) :: self
       type(generic_type)   :: car
     end function car
     function cdr(self)
       import abstract_list
       class(abstract_list) :: self
       class(abstract_list), pointer :: cdr
     end function cdr
  end interface

  type, extends(abstract_list) :: empty
   contains
     procedure :: head => empty_head
     procedure :: tail => empty_tail
  end type empty

  interface empty
     procedure :: create_empty
  end interface empty

  type, extends(abstract_list) :: cons
     type(generic_type) :: car
     class(abstract_list), pointer :: cdr
   contains
     procedure :: head => cons_head
     procedure :: tail => cons_tail
  end type cons

  type(empty), target :: unit

contains

  function create_empty()
    type(empty), target :: create_empty
    create_empty = unit
  end function create_empty

  function empty_head(self)
    class(empty) :: self
    type(generic_type)   :: empty_head
    stop('Exception: Calling head on empty.')
  end function empty_head

  function empty_tail(self)
    class(empty) :: self
    class(abstract_list), pointer :: empty_tail
    stop('Exception: Calling tail on empty.')
  end function empty_tail

  function cons_head(self)
    class(cons) :: self
    type(generic_type)   :: cons_head
    cons_head = self%car
  end function cons_head

  function cons_tail(self)
    class(cons) :: self
    class(abstract_list), pointer :: cons_tail
!    select type( s => self%cdr )
!    type is (empty)
!       cons_tail => empty()
!    type is (cons)
!       cons_tail => self%cdr
!    end select
  end function cons_tail
