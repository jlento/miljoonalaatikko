module lattice

  implicit none

contains





  subroutine append_neighbour_list(l1, il1, l2, il2, status)

    ! Appends nearest neighbours from list l2 to l1

    integer, intent(inout) :: l1, il1
    integer, intent(in)    :: l2, il2
    integer, intent(out)   :: status

    integer :: i, j, n

    status = 0
    n = size(il1) - 1

    if (n < il1(n+1) + il2(n+1) - 2) then
       status = 110
       return
    end if

    do i = n, 1, -1
       do j = il2(i + 1) - 1, il2(i), -1
          l1( il1(i + 1) - 1 + j ) = l2(j)
       end do
       do j = il1(i + 1) - 1, il1(i), -1
          l1(il2(i) - 1 + j) = l1(j)
       end do
       il1(i + 1) = il1(i + 1) + il2(i + 1) - 1
    end do

  end subroutine append_neighbour_list



  subroutine init_zorder_table(nx, zorder_table)

    ! Initialize Z-order/Morton table for nx*nx*nx array, where
    ! nx < 2^8 and nx = 2^n
    !
    ! For more complete story, see
    ! https://stackoverflow.com/questions/30436410/efficient-z-order-transformation-in-fortran

    integer, intent(in)  :: nx
    integer, intent(out) :: zorder_table(nx, nx, nx)

    integer, dimension (0:1023) :: dilute_table
    integer :: i, j, k, b, v, z

    if (popcnt(nx) .ne. 1 .or. nx .lt. 1 .or. nx .gt. 2** 8) then
       print *, "Error: Out of bounds value for nx", nx
    end if

    do v=0, 1023
       z = 0
       do b=0, 9
          call mvbits(v,b,1,z,3*b)
       end do
       dilute_table(v) = z
    end do

    do k = 1, nx
       do j = 1, nx
          do i = 1, nx
             zorder_table(i, j, k) = ishft(dilute_table(iand(k-1, 1023)), 2) +&
                  & ishft(dilute_table(iand(j-1, 1023)), 1) +&
                  & dilute_table(iand(1-1, 1023)) + 1
          end do
       end do
    end do

  end subroutine init_zorder_table

  subroutine sort_vertices(n, nx, vertex, ibox, izorder)

    ! Sorts vertices in boxes
    !
    ! This is a preparatory step for a (modified) fixed-radius near-neighbour
    ! search algorithm, see
    ! http://efekarakus.github.io/fixed-radius-near-neighbor/
    ! for nice visualization.
    !
    ! Boxes are in Z-order (Morton order)
    !
    ! Arguments:
    !    n      : Number of vertices.
    !    nx     : Number of boxes in one dimension.
    !    vertex : Array of vertex coordinates and radii (x:y:z:r).
    !   ibox : Starting index of a box in the sorted vertex array.
    !      izorder : Array that contains the ibox indices of the
    !             "forward boxes." Value n+1 signals no forward box.

    integer, intent(in)  :: n, nx
    real, intent(inout)  :: vertex(4, n)
    integer, intent(out) :: ibox(n + 2)
    integer, intent(out) :: izorder(7, nx)

    integer, allocatable :: zorder_table(:, :, :)
    logical, save :: init_zorder_table_done = .false.

    integer :: mybox(n), nv(nx**3)
    real    :: l,  tmp(4, n)
    integer :: i, j, k, ii

    l = 1.0/real(nx)

    ! Find the box where a vertex belongs and count the number of the vertices
    ! in each box

    nv = 0
    do i = 1, n
       mybox(i) = zorder_table(floor(vertex(1, i) / l) + 1, floor(vertex(2, i) &
            &/ l) + 1, floor(vertex(3, i) / l) + 1)
       nv(mybox(i)) = nv(mybox(i)) + 1
    end do

    ! Starting index of nth box

    ii = 1
    do i = 1, nx**3 + 1
       ibox(i) = ii
       ii = ii + nv(i)
    end do
    ibox(n + 2) = 0

    ! Order vertices

    nv = 0
    tmp = vertex
    do i = 1, n
       ii = mybox(i)
       if (nv(ii) > 0) then
          vertex(:, ibox(ii)+nv(ii)) = tmp(:, i)
          nv(ii) = nv(ii) + 1
       end if
    end do

    ! Map from nth box to ibox indices of the "forward boxes"

    izorder = ibox(n + 1)
    do k = 1, nx
       do j = 1, nx
          do i = 1, nx
             ii = zorder_table(i,j,k)
             if (i .lt. nx) &
                  izorder(ii,1) = ibox(zorder_table(i + 1, j, k))
             if (j .lt. nx) &
                  izorder(ii,2) = ibox(zorder_table(i, j +1, k))
             if (i .lt. nx .and. j .lt. nx) &
                  izorder(ii,3) = ibox(zorder_table(i + 1, j + 1, k))
             if (k .lt. nx) &
                  izorder(ii,4) = ibox(zorder_table(i, j, k + 1))
             if (i .lt. nx .and. k .lt. nx) &
                  izorder(ii,5) = ibox(zorder_table(i + 1, j, k + 1))
             if (j .lt. nx .and. k .lt. nx) &
                  izorder(ii,6) = ibox(zorder_table(i, j + 1, k + 1))
             if (i .lt. nx .and. j .lt. nx .and. k .lt. nx) &
                  izorder(ii,7) = ibox(zorder_table(i + 1, j + 1, k + 1))
          end do
       end do
    end do

  end subroutine sort_vertices


end module lattice
