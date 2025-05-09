# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

project(CMAKE_FORM)

# Disable warnings to avoid changing 3rd party code.
if(CMAKE_C_COMPILER_ID MATCHES
    "^(GNU|LCC|Clang|AppleClang|IBMClang|XLClang|XL|VisualAge|SunPro|HP|Intel|IntelLLVM|NVHPC)$")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w")
elseif(CMAKE_C_COMPILER_ID STREQUAL "PathScale")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -woffall")
endif()

configure_file(cmFormConfigure.h.in cmFormConfigure.h)

add_library(cmForm
             fld_arg.c
             fld_attr.c
             fld_current.c
             fld_def.c
             fld_dup.c
             fld_ftchoice.c
             fld_ftlink.c
             fld_info.c
             fld_just.c
             fld_link.c
             fld_max.c
             fld_move.c
             fld_newftyp.c
             fld_opts.c
             fld_pad.c
             fld_page.c
             fld_stat.c
             fld_type.c
             fld_user.c
             frm_cursor.c
             frm_data.c
             frm_def.c
             frm_driver.c
             frm_hook.c
             frm_opts.c
             frm_page.c
             frm_post.c
             frm_req_name.c
             frm_scale.c
             frm_sub.c
             frm_user.c
             frm_win.c
             fty_alnum.c
             fty_alpha.c
             fty_enum.c
             fty_int.c
             fty_ipv4.c
             fty_num.c
             fty_regex.c
   )

target_include_directories(cmForm
  PUBLIC
    ${CURSES_INCLUDE_PATH}
    ${CMAKE_FORM_BINARY_DIR}
    ${CMAKE_FORM_SOURCE_DIR}
  )

target_link_libraries(cmForm ${CURSES_LIBRARY})

if(CURSES_EXTRA_LIBRARY)
  target_link_libraries(cmForm ${CURSES_EXTRA_LIBRARY})
endif()
