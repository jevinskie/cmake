find_package(IONS CONFIG REQUIRED)

add_executable(main main.c)
target_link_libraries(main PRIVATE IONS::objlib)

enable_testing()
add_test(NAME run COMMAND main)
