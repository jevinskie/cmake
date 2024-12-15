/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file Copyright.txt or https://cmake.org/licensing for details.  */
#pragma once

#include "cmConfigure.h" // IWYU pragma: keep

#include <memory>
#include <string>
#include <vector>

class cmCTest;
class cmGlobalGenerator;
class cmMakefile;
class cmake;

/** \class cmCTestScriptHandler
 * \brief A class that handles ctest -S invocations
 */
class cmCTestScriptHandler
{
public:
  /**
   * Add a script to run, and if is should run in the current process
   */
  void AddConfigurationScript(const std::string&, bool pscope);

  /**
   * Run a dashboard using a specified configuration script
   */
  int ProcessHandler();

  /*
   * Run a script
   */
  static bool RunScript(cmCTest* ctest, cmMakefile* mf,
                        const std::string& script, bool InProcess,
                        int* returnValue);

  /*
   * Some elapsed time handling functions
   */
  void UpdateElapsedTime();

  cmCTestScriptHandler(cmCTest* ctest);
  cmCTestScriptHandler(const cmCTestScriptHandler&) = delete;
  const cmCTestScriptHandler& operator=(const cmCTestScriptHandler&) = delete;
  ~cmCTestScriptHandler();

  void CreateCMake();
  cmake* GetCMake() { return this->CMake.get(); }
  cmMakefile* GetMakefile() { return this->Makefile.get(); }

private:
  // reads in a script
  int ReadInScript(const std::string& total_script_arg);
  int ExecuteScript(const std::string& total_script_arg);

  int RunConfigurationScript(const std::string& script, bool pscope);

  cmCTest* CTest = nullptr;
  std::vector<std::string> ConfigurationScripts;
  std::vector<bool> ScriptProcessScope;

  std::unique_ptr<cmMakefile> Makefile;
  cmMakefile* ParentMakefile = nullptr;
  std::unique_ptr<cmGlobalGenerator> GlobalGenerator;
  std::unique_ptr<cmake> CMake;
};
