module linear
  implicit none

contains

    subroutine nnsearch(vertices, i, from, to, neighbors, ineighbors, status)

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
             goto 99
          end if
       end if
    end do

    return
99  status = 99

  end subroutine nnsearch


  subroutine linear_nnsearch(vertices, neighbors, ineighbors, status)

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

  end subroutine linear_nnsearch

end module linear
