  type, abstract :: list
     procedure :: tail
     procedure( elementFromList ), deferred :: head
  end type list

  abstract interface
     function elementFromList(self)
       import list
       import generic_type
       type(list) ::self
       type(generic_type) :: elementFromList
     end function elementFromList
  end interface
