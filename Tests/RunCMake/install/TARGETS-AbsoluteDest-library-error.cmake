enable_language(C)
add_library(mylib MODULE empty.c)
install(TARGETS mylib LIBRARY DESTINATION /absolute/lib)
