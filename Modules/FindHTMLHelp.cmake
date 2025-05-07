# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindHTMLHelp
------------

This module finds the Microsoft HTML Help Compiler and its API.  It is part of
the HTML Help Workshop.

.. note::

  HTML Help Workshop is in maintenance mode only and is considered deprecated.
  For modern documentation, consider alternatives such as Microsoft Help Viewer
  for producing ``.mshc`` files or web-based documentation tools.

Cache Variables
^^^^^^^^^^^^^^^

This module may set the following cache variables:

``HTML_HELP_COMPILER``
  Full path to the HTML Help Compiler (``hhc.exe``), used to compile ``.chm``
  files.
``HTML_HELP_INCLUDE_PATH``
  Directory containing ``htmlhelp.h``, required for applications integrating the
  HTML Help API.
``HTML_HELP_LIBRARY``
  Full path to ``htmlhelp.lib`` library, required for linking applications that
  use the HTML Help API.

Examples
^^^^^^^^

Finding HTML Help Compiler:

.. code-block:: cmake

  find_package(HTMLHelp)
  message(STATUS "HTML Help Compiler found at: ${HTML_HELP_COMPILER}")
#]=======================================================================]

if(WIN32)

  find_program(HTML_HELP_COMPILER
    NAMES hhc
    PATHS
      "[HKEY_CURRENT_USER\\Software\\Microsoft\\HTML Help Workshop;InstallDir]"
    PATH_SUFFIXES "HTML Help Workshop"
    )

  get_filename_component(HTML_HELP_COMPILER_PATH "${HTML_HELP_COMPILER}" PATH)

  find_path(HTML_HELP_INCLUDE_PATH
    NAMES htmlhelp.h
    PATHS
      "${HTML_HELP_COMPILER_PATH}/include"
      "[HKEY_CURRENT_USER\\Software\\Microsoft\\HTML Help Workshop;InstallDir]/include"
    PATH_SUFFIXES "HTML Help Workshop/include"
    )

  find_library(HTML_HELP_LIBRARY
    NAMES htmlhelp
    PATHS
      "${HTML_HELP_COMPILER_PATH}/lib"
      "[HKEY_CURRENT_USER\\Software\\Microsoft\\HTML Help Workshop;InstallDir]/lib"
    PATH_SUFFIXES "HTML Help Workshop/lib"
    )

  mark_as_advanced(
    HTML_HELP_COMPILER
    HTML_HELP_INCLUDE_PATH
    HTML_HELP_LIBRARY
    )

endif()
