# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.


# This module is shared by multiple linkers; use include blocker.
include_guard()

block(SCOPE_FOR POLICIES)
cmake_policy(SET CMP0054 NEW)

macro(__linker_mold lang)
  if(CMAKE_EFFECTIVE_SYSTEM_NAME STREQUAL "Apple")
    include(Linker/AppleClang)

    __linker_appleclang(${lang})
  else()
    include(Linker/GNU)

    __linker_gnu(${lang})
  endif()
endmacro()

endblock()
