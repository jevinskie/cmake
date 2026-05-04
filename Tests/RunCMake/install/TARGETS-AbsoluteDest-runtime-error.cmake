enable_language(C)
add_executable(myexe empty.c)
install(TARGETS myexe RUNTIME DESTINATION /absolute/bin)
