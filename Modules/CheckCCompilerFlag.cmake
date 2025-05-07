# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
CheckCCompilerFlag
------------------

Check once whether the C compiler supports a given flag.

.. command:: check_c_compiler_flag

  .. code-block:: cmake

    check_c_compiler_flag(<flag> <resultVar>)

Check once that the ``<flag>`` is accepted by the compiler without a diagnostic.
The result is stored in the internal cache variable specified by
``<resultVar>``, with boolean ``true`` for success and boolean ``false`` for
failure.

``true`` indicates only that the compiler did not issue a diagnostic message
when given the flag. Whether the flag has any effect is beyond the scope of
this module.

Internally, :command:`try_compile` is used to perform the check. If
:variable:`CMAKE_TRY_COMPILE_TARGET_TYPE` is set to ``EXECUTABLE`` (default),
the check compiles and links an executable program. If set to
``STATIC_LIBRARY``, the check is compiled but not linked.

See also :command:`check_compiler_flag` for a more general command syntax.

The compile and link commands can be influenced by setting any of the
following variables prior to calling ``check_c_compiler_flag()``. Unknown flags
in these variables can case a false negative result.

.. include:: /module/include/CMAKE_REQUIRED_FLAGS.rst

.. include:: /module/include/CMAKE_REQUIRED_DEFINITIONS.rst

.. include:: /module/include/CMAKE_REQUIRED_INCLUDES.rst

.. include:: /module/include/CMAKE_REQUIRED_LINK_OPTIONS.rst

.. include:: /module/include/CMAKE_REQUIRED_LIBRARIES.rst

.. include:: /module/include/CMAKE_REQUIRED_LINK_DIRECTORIES.rst

.. include:: /module/include/CMAKE_REQUIRED_QUIET.rst

#]=======================================================================]

include_guard(GLOBAL)
include(Internal/CheckCompilerFlag)

macro (CHECK_C_COMPILER_FLAG _FLAG _RESULT)
  cmake_check_compiler_flag(C "${_FLAG}" ${_RESULT})
endmacro ()

# FIXME(#24994): The following module is included only for compatibility
# with projects that accidentally relied on it with CMake 3.26 and below.
include(CheckCSourceCompiles)
