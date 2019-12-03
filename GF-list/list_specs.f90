  implicit none

  type list
   contains
     procedure, nopass     :: empty => unit
     procedure, pass(self) :: cons  => sexpr
     procedure, pass(self) :: head  => car
     procedure, pass(self) :: tail  => cdr
  end type list
