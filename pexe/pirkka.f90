program pirkka
  implicit none

  real, dimension(181,360,100) :: a, b
  real :: s
  integer :: i, j, k

  INTEGER :: &
       nb_ticks_initial, & ! initial value of the clock tick counter
       nb_ticks_final,   & ! final value of the clock tick counter
       nb_ticks_max,     & ! maximum value of the clock counter
       nb_ticks_sec,     & ! number of clock ticks per second
       nb_ticks           ! number of clock ticks of the code
  REAL :: elapsed_time  ! real time in seconds

  ! Initialisations

  CALL SYSTEM_CLOCK(COUNT_RATE=nb_ticks_sec, COUNT_MAX=nb_ticks_max)
  do k = 1, 100
     do j = 1, 360
        do i = 1, 181
           a(i,j,k) = 1.0
           b(i,j,k) = -1.0
        end do
     end do
  end do

  CALL SYSTEM_CLOCK(COUNT=nb_ticks_initial)
  do k = 1, 100
     s = sum(abs(b-a))
  end do
  CALL SYSTEM_CLOCK(COUNT=nb_ticks_final)
  nb_ticks = nb_ticks_final - nb_ticks_initial
  IF (nb_ticks_final < nb_ticks_initial) &
       nb_ticks = nb_ticks + nb_ticks_max
  elapsed_time   = REAL(nb_ticks) / nb_ticks_sec
  print *, s, elapsed_time

  s = 0.0
  CALL SYSTEM_CLOCK(COUNT=nb_ticks_final)
  do k = 1, 100
     do j = 1, 360
        do i = 1, 181
           s = s + abs(b(i,j,k)-a(i,j,k))
        end do
     end do
  end do
  nb_ticks = nb_ticks_final - nb_ticks_initial
  IF (nb_ticks_final < nb_ticks_initial) &
       nb_ticks = nb_ticks + nb_ticks_max
  elapsed_time   = REAL(nb_ticks) / nb_ticks_sec
  print *, s, elapsed_time

end program pirkka

