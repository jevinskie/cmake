CMAKE_COMPILER_IS_GNUCC
-----------------------

.. deprecated:: 3.24

  Use the :variable:`CMAKE_C_COMPILER_ID <CMAKE_<LANG>_COMPILER_ID>` variable
  instead.

  The ``CMAKE_COMPILER_IS_*`` variables were used in early CMake versions before
  the introduction of :variable:`CMAKE_<LANG>_COMPILER_ID` variables in CMake
  2.6.

The ``CMAKE_COMPILER_IS_GNUCC`` variable is set to boolean true if the ``C``
compiler is GNU.

Examples
^^^^^^^^

In earlier versions of CMake, the ``CMAKE_COMPILER_IS_GNUCC`` variable was used
to check if the ``C`` compiler was GNU:

.. code-block:: cmake

  if(CMAKE_COMPILER_IS_GNUCC)
    # GNU C compiler-specific logic.
  endif()

Starting with CMake 2.6, the ``CMAKE_C_COMPILER_ID`` variable should be used
instead:

.. code-block:: cmake

  if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    # GNU C compiler-specific logic.
  endif()

When upgrading code, consider whether additional ``C`` compilers should be
targeted beyond just ``GNU``.  In the past, the ``LCC`` and ``QCC`` compilers
also had this variable set (see :policy:`CMP0047` and :policy:`CMP0129` policies
for details). To account for this, the following approach can be used:

.. code-block:: cmake

  # Targeting GNU, LCC, and QCC compilers for C:
  if(CMAKE_C_COMPILER_ID MATCHES "^(GNU|LCC|QCC)$")
    # ...
  endif()
