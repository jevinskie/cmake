enable_language(C)

include(CTest)

find_package(Python2 3 QUIET)
if (Python2_FOUND)
  message (FATAL_ERROR "Wrong python version found: ${Python2_VERSION}")
endif()

find_package(Python2 REQUIRED COMPONENTS Interpreter Development)
if (NOT Python2_FOUND)
  message (FATAL_ERROR "Failed to find Python 2")
endif()
if (NOT Python2_Development_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development' component")
endif()
if (NOT Python2_Development.Module_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development.Module' component")
endif()
if (NOT Python2_Development.Embed_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development.Embed' component")
endif()

if(NOT TARGET Python2::Interpreter)
  message(SEND_ERROR "Python2::Interpreter not found")
endif()

if(NOT TARGET Python2::Python)
  message(SEND_ERROR "Python2::Python not found")
endif()
if(NOT TARGET Python2::Module)
  message(SEND_ERROR "Python2::Module not found")
endif()

Python2_add_library (spam2 MODULE spam.c)
target_compile_definitions (spam2 PRIVATE PYTHON2)

add_test (NAME python2_spam2
          COMMAND "${CMAKE_COMMAND}" -E env "PYTHONPATH=$<TARGET_FILE_DIR:spam2>"
          "${Python2_INTERPRETER}" -c "import spam2; spam2.system(\"cd\")")

add_test(NAME findpython2_script
         COMMAND "${CMAKE_COMMAND}" -DPYTHON_PACKAGE_NAME=Python2
         -DPython2_FIND_STRATEGY=${Python2_FIND_STRATEGY}
         -P "${CMAKE_CURRENT_LIST_DIR}/FindPythonScript.cmake")


#
# New search with user's prefix
#
foreach(item IN ITEMS FOUND Development_FOUND Development.Module_FOUND Development.Embed_FOUND)
  unset(Python2_${item})
endforeach()

set(Python2_ARTIFACTS_PREFIX "_TEST")
find_package(Python2 REQUIRED COMPONENTS Interpreter Development)
if (NOT Python2_TEST_FOUND OR NOT Python2_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 (TEST prefix)")
endif()
if (NOT Python2_TEST_Development_FOUND OR NOT Python2_Development_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development' component (TEST prefix)")
endif()
if (NOT Python2_TEST_Development.Module_FOUND OR NOT Python2_Development.Module_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development.Module' component (TEST prefix)")
endif()
if (NOT Python2_TEST_Development.Embed_FOUND OR NOT Python2_Development.Embed_FOUND)
  message (FATAL_ERROR "Failed to find Python 2 'Development.Embed' component (TEST prefix)")
endif()

if(NOT TARGET Python2_TEST::Interpreter)
  message(SEND_ERROR "Python2_TEST::Interpreter not found")
endif()

if(NOT TARGET Python2_TEST::Python)
  message(SEND_ERROR "Python2_TEST::Python not found")
endif()
if(NOT TARGET Python2_TEST::Module)
  message(SEND_ERROR "Python2_TEST::Module not found")
endif()

Python2_TEST_add_library (TEST_spam2 MODULE TEST_spam.c)
target_compile_definitions (TEST_spam2 PRIVATE PYTHON2)

add_test (NAME python2_TEST_spam2
          COMMAND "${CMAKE_COMMAND}" -E env "PYTHONPATH=$<TARGET_FILE_DIR:TEST_spam2>"
          "${Python2_INTERPRETER}" -c "import TEST_spam2; TEST_spam2.system(\"cd\")")
