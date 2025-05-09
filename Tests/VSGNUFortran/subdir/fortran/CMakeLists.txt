cmake_minimum_required(VERSION 3.10)
project(FortranHello Fortran C)

# add a function to test for -lsunquad on sunpro sun systems.
function(test_sunquad result)
  set( TEST_DIR "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/sunq")
  file(WRITE "${TEST_DIR}/testsunq.f" "
      PROGRAM TEST
      END
  ")
  file(WRITE ${TEST_DIR}/CMakeLists.txt "
project(sunq Fortran)
add_library(sunq SHARED testsunq.f)
target_link_libraries(sunq sunquad)
")
  message(STATUS "looking for -lsunquad")
  try_compile(RESULT "${TEST_DIR}" "${TEST_DIR}" sunq OUTPUT_VARIABLE OUT)
  if("${RESULT}")
    message(STATUS "-lsunquad found")
  else()
    message(STATUS "-lsunquad not found")
  endif()
  message(STATUS
    "looking for sunquad:\nRESULT=[${RESULT}]\nOUTPUT=[\n${OUT}\n]")
  set(${result} "${RESULT}" PARENT_SCOPE)
endfunction()

if(CMAKE_Fortran_COMPILER_ID STREQUAL "LFortran")
  add_compile_options(--implicit-interface --generate-object-code)
endif()

# check for the fortran c interface mangling
include(FortranCInterface)
FortranCInterface_HEADER(HelloWorldFCMangle.h
                         MACRO_NAMESPACE "FC_"
                         SYMBOL_NAMESPACE "FC_"
                         SYMBOLS hello world)
add_library(hello SHARED hello.f)
add_library(world SHARED world.f)
target_link_libraries(hello PRIVATE world)
if(CMAKE_Fortran_COMPILER_ID MATCHES SunPro)
  target_link_libraries(hello PRIVATE fsu)
  if(CMAKE_Fortran_PLATFORM_ID MATCHES SunOS)
    target_link_libraries(hello PRIVATE sunmath m)
    test_sunquad(CMAKE_HAS_SUNQUAD)
    if(CMAKE_HAS_SUNQUAD)
      target_link_libraries(hello PRIVATE sunquad)
    endif()
  endif()
elseif(CMAKE_Fortran_COMPILER_ID MATCHES Fujitsu)
  # Fujitsu Fortran doesn't automatically link its runtime libraries into
  # SOs
  target_link_libraries(world PRIVATE fj90i fj90f fjsrcinfo)
  target_link_libraries(hello PRIVATE fj90i fj90f fjsrcinfo)
endif()
