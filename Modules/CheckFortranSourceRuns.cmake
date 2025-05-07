# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
CheckFortranSourceRuns
----------------------

.. versionadded:: 3.14

Check once if given Fortran source compiles and links into an executable and can
subsequently be run.

.. command:: check_fortran_source_runs

  .. code-block:: cmake

    check_fortran_source_runs(<code> <resultVar>
        [SRC_EXT <extension>])

  Check once that the source supplied in ``<code>`` can be built, linked as an
  executable, and then run. The ``<code>`` must contain a Fortran ``program``.

  The result is stored in the internal cache variable specified by
  ``<resultVar>``. If the code builds and runs with exit code ``0``, success is
  indicated by boolean ``true``. Failure to build or run is indicated by boolean
  ``false``, such as an empty string or an error message.

  .. code-block:: cmake

    check_fortran_source_runs("program test
    real :: x[*]
    call co_sum(x)
    end program"
    HAVE_COARRAY)

  By default, the test source file will be given a ``.F90`` file extension. The
  ``SRC_EXT`` option can be used to override this with ``.<extension>`` instead.

  See also :command:`check_source_runs` for a more general command syntax.

  The compile and link commands can be influenced by setting any of the
  following variables prior to calling ``check_fortran_source_runs()``:

.. include:: /module/include/CMAKE_REQUIRED_FLAGS.rst

.. include:: /module/include/CMAKE_REQUIRED_DEFINITIONS.rst

.. include:: /module/include/CMAKE_REQUIRED_INCLUDES.rst

.. include:: /module/include/CMAKE_REQUIRED_LINK_OPTIONS.rst

.. include:: /module/include/CMAKE_REQUIRED_LIBRARIES.rst

.. include:: /module/include/CMAKE_REQUIRED_LINK_DIRECTORIES.rst

.. include:: /module/include/CMAKE_REQUIRED_QUIET.rst

#]=======================================================================]

include_guard(GLOBAL)
include(Internal/CheckSourceRuns)

macro(CHECK_Fortran_SOURCE_RUNS SOURCE VAR)
  # Pass the SRC_EXT we used by default historically.
  # A user-provided SRC_EXT argument in ARGN will override ours.
  cmake_check_source_runs(Fortran "${SOURCE}" ${VAR} SRC_EXT "F90" ${ARGN})
endmacro()
