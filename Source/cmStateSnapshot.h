/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file LICENSE.rst or https://cmake.org/licensing for details.  */

#pragma once

#include "cmConfigure.h" // IWYU pragma: keep

#include <string>
#include <vector>

#include <cm/string_view>

#include "cmPolicies.h"
#include "cmStateTypes.h"
#include "cmValue.h"

class cmPackageState;
class cmState;
class cmStateDirectory;

class cmStateSnapshot
{
public:
  cmStateSnapshot(cmState* state = nullptr);
  cmStateSnapshot(cmState* state, cmStateDetail::PositionType position);

  cmValue GetDefinition(std::string const& name) const;
  bool IsInitialized(std::string const& name) const;
  void SetDefinition(std::string const& name, cm::string_view value);
  void RemoveDefinition(std::string const& name);
  std::vector<std::string> ClosureKeys() const;
  bool RaiseScope(std::string const& var, char const* varDef);

  void SetListFile(std::string const& listfile);

  std::string const& GetExecutionListFile() const;

  std::vector<cmStateSnapshot> GetChildren();

  bool IsValid() const;
  cmStateSnapshot GetBuildsystemDirectory() const;
  cmStateSnapshot GetBuildsystemDirectoryParent() const;
  cmStateSnapshot GetCallStackParent() const;
  cmStateSnapshot GetCallStackBottom() const;
  cmStateEnums::SnapshotType GetType() const;

  void SetPolicy(cmPolicies::PolicyID id, cmPolicies::PolicyStatus status);
  cmPolicies::PolicyStatus GetPolicy(cmPolicies::PolicyID id,
                                     bool parent_scope = false) const;
  void PushPolicy(cmPolicies::PolicyMap const& entry, bool weak);
  bool PopPolicy();
  bool CanPopPolicyScope();

  cmState* GetState() const;

  cmStateDirectory GetDirectory() const;

  void SetProjectName(std::string const& name);
  std::string GetProjectName() const;

  cmPackageState& GetPackageState(std::string const& packagePath);

  void InitializeFromParent_ForSubdirsCommand();

  struct StrictWeakOrder
  {
    bool operator()(cmStateSnapshot const& lhs,
                    cmStateSnapshot const& rhs) const;
  };

  void SetDirectoryDefinitions();
  void SetDefaultDefinitions();

private:
  friend bool operator==(cmStateSnapshot const& lhs,
                         cmStateSnapshot const& rhs);
  friend bool operator!=(cmStateSnapshot const& lhs,
                         cmStateSnapshot const& rhs);
  friend class cmState;
  friend class cmStateDirectory;
  friend struct StrictWeakOrder;

  void InitializeFromParent();

  cmState* State;
  cmStateDetail::PositionType Position;
};

bool operator==(cmStateSnapshot const& lhs, cmStateSnapshot const& rhs);
bool operator!=(cmStateSnapshot const& lhs, cmStateSnapshot const& rhs);
