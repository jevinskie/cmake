function(_expect_empty NAME)
  if(NOT DEFINED ${NAME})
    message(SEND_ERROR "Variable '${NAME}' is not defined")
  elseif(NOT "${${NAME}}" STREQUAL "")
    message(SEND_ERROR
      "Variable '${NAME}' has value '${${NAME}}' (expected: empty)")
  endif()
endfunction()

function(expect_empty SUFFIX)
  _expect_empty(PROJECT_${SUFFIX})
  _expect_empty(CMAKE_PROJECT_${SUFFIX})
  _expect_empty(${PROJECT_NAME}_${SUFFIX})
endfunction()

project(Omissions LANGUAGES)

# TODO: Test these when a policy is in place to handle projects expecting
# legacy handling of the version variables
# expect_empty(VERSION)
# expect_empty(VERSION_MAJOR)
# expect_empty(VERSION_MINOR)
# expect_empty(VERSION_PATCH)
# expect_empty(VERSION_TWEAK)

expect_empty(COMPAT_VERSION)
expect_empty(SPDX_LICENSE)
expect_empty(DESCRIPTION)
expect_empty(HOMEPAGE_URL)
