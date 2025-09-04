project(test-CMP0200-WARN C)

set(CMAKE_POLICY_WARNING_CMP0200 ON)

add_library(lib_test INTERFACE IMPORTED)
set_target_properties(lib_test PROPERTIES
  IMPORTED_CONFIGURATIONS "DOG;CAT"
)

add_executable(exe_test configtest.c)
target_link_libraries(exe_test PRIVATE lib_test)
