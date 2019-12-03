program test
  use mod_integer_list
!  use mod_real_list
  implicit none
  type ( integer_list ) :: l1, l2, l3
  integer :: i

  l1 = empty()
!  print *, isempty(l1 % ptr)
  l2 = cons ( 1, empty())
!  print *, isempty(l2 % ptr)
  print *, head ( l2 )
!  print *, head ( tail ( l2 ) )

  ! do i = 1, 5
  !    l1 = 1 .cons. empty()
  !    select type ( p => l1 % ptr)
  !    type is ( cons_cell )
  !       print '(2i10)', loc(p), p % nrefs
  !    end select
  ! end do

  ! do i = 1, 5
  !    l2 = 2 .cons. ( 1 .cons. empty() )
  !    select type ( p2 => l2 % ptr)
  !    type is ( cons_cell )
  !       select type ( p1 => p2 % cdr_priv )
  !       type is ( cons_cell )
  !          print '(4i10)', loc(p2), p2 % nrefs, loc(p1), p1 % nrefs
  !       end select
  !    end select
  ! end do

  ! do i = 1, 5
  !    l2 = 2 .cons. l1
  !    select type ( p2 => l2 % ptr)
  !    type is ( cons_cell )
  !       select type ( p1 => p2 % cdr_priv )
  !       type is ( cons_cell )
  !          print '(4i10)', loc(p2), p2 % nrefs, loc(p1), p1 % nrefs
  !       end select
  !    end select
  ! end do

!  do i = 1, 5
!     l3 = 2 .cons. l1
!     print '(6i10)', loc(l2 % ptr), l2 % ptr % nrefs, loc(l2 % ptr % cdr), l2 % ptr % cdr % nrefs, &
!          loc(l2 % ptr % cdr % cdr ), l2 % ptr % cdr % cdr % nrefs
!  end do

!  do i = 1, 5
!     l2 = 2 .cons. ( 1 .cons. empty() )
!     print '(6i10)', loc(l2 % ptr), l2 % ptr % nrefs, loc(l2 % ptr % cdr), l2 % ptr % cdr % nrefs, &
!          loc(l2 % ptr % cdr % cdr ), l2 % ptr % cdr % cdr % nrefs
!  end do

!  do i = 1, 5
!     print '(6i10)', loc(l2 % ptr), l2 % ptr % nrefs, loc(l2 % ptr % cdr), l2 % ptr % cdr % nrefs, &
!          loc(l2 % ptr % cdr % cdr ), l2 % ptr % cdr % cdr % nrefs
!  end do

!    l1 = 2 .cons. ( 1 .cons. empty())
!    l3 = 2 .cons. ( 1 .cons. empty() )
!    print *, head(l3)
!    print *, head(tail(l3))
!    print *, head(l2)
!    print *, head(l1)
!    print *, head ( cons ( 2, cons ( 1, empty() ) ) )
!    print *, head ( l1 )
!    print *, head ( tail ( l1 ) )
!    print *, head ( tail ( tail ( l1 ) ) )
!    print *, head ( l0 )

end program test
