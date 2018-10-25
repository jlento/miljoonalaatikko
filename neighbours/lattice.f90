module lattice

  implicit none

contains

  pure subroutine init_lattice(zorder, status)

    ! Initialize Z-order/Morton table for nx*nx*nx lattice, where
    ! nx < 2^8 and nx = 2^n
    !
    ! For more complete story, see
    ! https://stackoverflow.com/questions/30436410/efficient-z-order-transformation-in-fortran
    !
    ! For convenience, there is a "padding" with zeros, i.e.
    ! zorder(i,j,k) = 0, when i,j,k=0, or i,j,k=nx+1

    integer, intent(out) :: zorder(0:, 0:, 0:), status

    integer, dimension (0:1023) :: dilute_table
    integer :: i, j, k, b, v, z, nx

    status = 0
    nx = size(zorder, 1) - 2
    zorder = 0


    if (popcnt(nx) .ne. 1 .or. nx .lt. 1 .or. nx .gt. 2 ** 8) then
       status = 1
       return
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
             zorder(i, j, k) = ishft(dilute_table(iand(k-1, 1023)), 2) +&
                  & ishft(dilute_table(iand(j-1, 1023)), 1) +&
                  & dilute_table(iand(i-1, 1023)) + 1
          end do
       end do
    end do

  end subroutine init_lattice


  pure subroutine sort_vertices(vertices, zorder, ibox, ifbox, mybox, nv, tmp)

    ! Sorts vertices in boxes
    !
    ! This is a preparatory step for a (modified) fixed-radius near-neighbour
    ! search algorithm, see
    ! http://efekarakus.github.io/fixed-radius-near-neighbor/ for nice
    ! visualization. The differences here are that the boxes are organized and
    ! scanned in Z-order (Morton order), and the lattice is 3D, obviously.
    !
    ! Arguments:
    !    vertices  --  The array of the vertex coordinates and radii (x:y:z:r)
    !    zorder    --  The map from the lattice coordinates to the Z-order
    !    ibox      --  The starting index of the box in the sorted vertex array
    !    ifbox     --  The starting indices of the "forward boxes." Value
    !                  0 signals no forward box

    real, intent(inout)  :: vertices(:, :)
    integer, intent(in)  :: zorder(0:, 0:, 0:)
    integer, intent(out) :: ibox(:), ifbox(:, :)
    integer, intent(out) :: mybox(:), nv(:)
    real, intent(out)    :: tmp(:, :)

    real    :: c
    integer :: i, j, k, ii, n, nx

    n = size(vertices, 2)
    nx = size(zorder, 1) - 2
    c = real(nx)

    ! Find the box where a vertex belongs and count the number of the vertices
    ! in each box

    nv = 0
    do i = 1, n
       mybox(i) = zorder(floor(c * vertices(1, i)) + 1, floor(c * vertices(2,&
            & i)) + 1, floor(c * vertices(3, i)) + 1)
       nv(mybox(i)) = nv(mybox(i)) + 1
    end do

    ! Starting index of nth box

    ibox(1) = 1
    do i = 1, nx**3
       ibox(i + 1) = ibox(i) + nv(i)
    end do

    nv = 0
    tmp = vertices
    do i = 1, n
       ii = mybox(i)
       vertices(:, ibox(ii)+nv(ii)) = tmp(:, i)
       nv(ii) = nv(ii) + 1
    end do

    ! Map from nth box to the "forward boxes"

    do k = 1, nx
       do j = 1, nx
          do i = 1, nx
             ii = zorder(i,j,k)
             ifbox(1, ii)  = zorder(i + 1, j - 1, k - 1)
             ifbox(2, ii)  = zorder(i + 1, j,     k - 1)
             ifbox(3, ii)  = zorder(i + 1, j + 1, k - 1)
             ifbox(4, ii)  = zorder(i + 1, j - 1, k)
             ifbox(5, ii)  = zorder(i + 1, j,     k)
             ifbox(6, ii)  = zorder(i,     j + 1, k)
             ifbox(7, ii)  = zorder(i + 1, j + 1, k)
             ifbox(8, ii)  = zorder(i,     j - 1, k + 1)
             ifbox(9, ii)  = zorder(i + 1, j - 1, k + 1)
             ifbox(10, ii) = zorder(i,     j,     k + 1)
             ifbox(11, ii) = zorder(i + 1, j,     k + 1)
             ifbox(12, ii) = zorder(i,     j + 1, k + 1)
             ifbox(13, ii) = zorder(i + 1, j + 1, k + 1)
          end do
       end do
    end do

  end subroutine sort_vertices

end module lattice
