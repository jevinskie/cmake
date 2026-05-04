enable_language(C)
add_library(mylib STATIC empty.c)

# FIXME(#27770): This diagnostic is issued at generate time. Currently, the
# install generator doesn't capture the immediate diagnostic state, only the
# top-most state of the current subdirectory, which we cannot affect (because
# this test was include()d. When we fix that, we should test by changing the
# diagnostic action here rather than by -W... in the test CLI arguments.
# cmake_diagnostic(SET CMD_INSTALL_ABSOLUTE_DESTINATION SEND_ERROR)

cmake_diagnostic(PROMOTE CMD_INSTALL_ABSOLUTE_DESTINATION WARN)
install(TARGETS mylib DESTINATION /absolute/path)
