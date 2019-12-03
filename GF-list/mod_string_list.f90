module mod_string_list
  use mod_string, element_type => string

  include 'list_specs.f90'

  type, extends(list) :: string_list
  end type string_list

  include 'list_procs.f90'

end module mod_string_list
