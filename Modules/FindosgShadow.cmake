# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindosgShadow
-------------

Finds the osgShadow NodeKit from the OpenSceneGraph toolkit.

.. note::

  In most cases, it's recommended to use the :module:`FindOpenSceneGraph` module
  instead and list osgShadow as a component.  This will automatically handle
  dependencies such as the OpenThreads and core osg libraries:

  .. code-block:: cmake

    find_package(OpenSceneGraph COMPONENTS osgShadow)

This module is used internally by :module:`FindOpenSceneGraph` to find the
osgShadow NodeKit.  It is not intended to be included directly during typical
use of the :command:`find_package` command.  However, it is available as a
standalone module for advanced use cases where finer control over detection is
needed.  For example, to find the osgShadow explicitly or bypass automatic
component detection:

.. code-block:: cmake

  find_package(osgShadow)

OpenSceneGraph and osgShadow headers are intended to be included in C++ project
source code as:

.. code-block:: c++
  :caption: ``example.cxx``

  #include <osg/PositionAttitudeTransform>
  #include <osgShadow/ShadowTexture>
  // ...

When working with the OpenSceneGraph toolkit, other libraries such as OpenGL may
also be required.

Result Variables
^^^^^^^^^^^^^^^^

This module defines the following variables:

``osgShadow_FOUND``
  Boolean indicating whether the osgShadow NodeKit of the OpenSceneGraph
  toolkit is found.  For backward compatibility, the ``OSGSHADOW_FOUND``
  variable is also set to the same value.

``OSGSHADOW_LIBRARIES``
  The libraries needed to link against to use osgShadow.

``OSGSHADOW_LIBRARY``
  A result variable that is set to the same value as the ``OSGSHADOW_LIBRARIES``
  variable.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``OSGSHADOW_INCLUDE_DIR``
  The include directory containing headers needed to use osgShadow.

``OSGSHADOW_LIBRARY_DEBUG``
  The path to the osgShadow debug library.

Hints
^^^^^

This module accepts the following variables:

``OSGDIR``
  Environment variable that can be set to help locate the OpenSceneGraph
  toolkit, including its osgShadow NodeKit, when installed in a custom
  location.  It should point to the OpenSceneGraph installation prefix used when
  it was configured, built, and installed: ``./configure --prefix=$OSGDIR``.

Examples
^^^^^^^^

Finding osgShadow explicitly with this module and creating an interface
:ref:`imported target <Imported Targets>` that encapsulates its usage
requirements for linking it to a project target:

.. code-block:: cmake

  find_package(osgShadow)

  if(osgShadow_FOUND AND NOT TARGET osgShadow::osgShadow)
    add_library(osgShadow::osgShadow INTERFACE IMPORTED)
    set_target_properties(
      osgShadow::osgShadow
      PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OSGSHADOW_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES "${OSGSHADOW_LIBRARIES}"
    )
  endif()

  target_link_libraries(example PRIVATE osgShadow::osgShadow)

See Also
^^^^^^^^

* The :module:`FindOpenSceneGraph` module to find OpenSceneGraph toolkit.
#]=======================================================================]

# Created by Eric Wing.

include(${CMAKE_CURRENT_LIST_DIR}/Findosg_functions.cmake)
OSG_FIND_PATH   (OSGSHADOW osgShadow/ShadowTexture)
OSG_FIND_LIBRARY(OSGSHADOW osgShadow)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(osgShadow DEFAULT_MSG
    OSGSHADOW_LIBRARY OSGSHADOW_INCLUDE_DIR)
