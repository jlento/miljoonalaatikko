module fixed_radius

  implicit none

contains

    pure subroutine nnsearch(vertices, i, from, to, neighbors, ineighbors, status)

    ! Searches the neighborss of ith vertex from the range of vertices,
    ! given
    !   vertices    -- array of vertex coordinates and radii
    !   i           -- ith vertex
    !   from, to    -- the range of the vertices
    !   neighbors   -- "packed" array of neighbor vertex indices
    !   ineighbors  -- array of indices pointing to start of the sub-array of
    !                  neighbor indices corresponding to ith vertex

    real, intent(in)       :: vertices(:, :)
    integer, intent(in)    :: i, from, to
    integer, intent(inout) :: neighbors(:), ineighbors(:)
    integer, intent(out)   ::status

    integer                :: j, inmax

    inmax = size(neighbors)

    do j = from, to
       if (sum((vertices(1:3, i) - vertices(1:3, j)) ** 2) < (vertices(4, i) +&
            & vertices(4, j)) ** 2) then
          neighbors(ineighbors(i + 1 )) = j
          ineighbors(i + 1) = ineighbors(i + 1) + 1
          if (ineighbors(i + 1) > inmax) then
             status = 99
             return
          end if
       end if
    end do

  end subroutine nnsearch


  pure subroutine nnsearch_linear(vertices, neighbors, ineighbors, status)

    ! The brute force algorithm that scales as n^2

    real, intent(in)       :: vertices(:, :)
    integer, intent(out)   :: neighbors(:), ineighbors(:), status

    integer              :: i, n

    n = size(vertices,2)
    ineighbors(1) = 1
    status = 0

    do i = 1, n - 1
       ineighbors(i + 1) = ineighbors(i)
       call nnsearch(vertices, i, i + 1, n, neighbors, ineighbors, status)
       if (status .ne. 0) exit
    end do

  end subroutine nnsearch_linear


  pure subroutine nnsearch_lattice(vertices, ibox, ifbox, neighbors, ineighbors,&
       & status)

    ! For each vertex, search the box in which the vertex is, plus the
    ! seven "forward boxes"

    real, intent(in)       :: vertices(:,:)
    integer, intent(in)    :: ibox(:), ifbox(:, :)
    integer, intent(out)   :: neighbors(:), ineighbors(:), status

    integer :: i, j, k, jj, kk, n, nbox

    n          = size(vertices,2)
    nbox       = size(ibox) - 1
    status     = 0

    !print *, ifbox

    ineighbors(1) = 1
    top: do i = 1, nbox
       jj = ibox(i+1) - 1
       do j = ibox(i), jj
          if (j .eq. n) cycle
          ineighbors(j + 1) = ineighbors(j)
          call nnsearch(vertices, j, j + 1, jj, neighbors, ineighbors&
               &, status)
          if (status .ne. 0) then
             return
          end if
          do k = 1, 13
             kk = ifbox(k, i)
             if (kk .ne. 0) then
                call nnsearch(vertices, j, ibox(kk), ibox(kk + 1) - 1,&
                     & neighbors, ineighbors , status)
                if (status .ne. 0) exit
             end if
          end do
       end do
    end do top

  end subroutine nnsearch_lattice

end module fixed_radius
