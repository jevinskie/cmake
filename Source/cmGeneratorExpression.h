/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file LICENSE.rst or https://cmake.org/licensing for details.  */
#pragma once

#include "cmConfigure.h" // IWYU pragma: keep

#include <map>
#include <memory>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include <cm/string_view>

#include "cmListFileCache.h"
#include "cmLocalGenerator.h"

class cmake;
class cmCompiledGeneratorExpression;
class cmGeneratorTarget;
struct cmGeneratorExpressionDAGChecker;
struct cmGeneratorExpressionEvaluator;

/** \class cmGeneratorExpression
 * \brief Evaluate generate-time query expression syntax.
 *
 * cmGeneratorExpression instances are used by build system generator
 * implementations to evaluate the $<> generator expression syntax.
 * Generator expressions are evaluated just before the generate step
 * writes strings into the build system.  They have knowledge of the
 * build configuration which is not available at configure time.
 */
class cmGeneratorExpression
{
public:
  /** Construct. */
  cmGeneratorExpression(cmake& cmakeInstance,
                        cmListFileBacktrace backtrace = cmListFileBacktrace());
  ~cmGeneratorExpression();

  cmGeneratorExpression(cmGeneratorExpression const&) = delete;
  cmGeneratorExpression& operator=(cmGeneratorExpression const&) = delete;

  std::unique_ptr<cmCompiledGeneratorExpression> Parse(
    std::string input) const;

  static std::string Evaluate(
    std::string input, cmLocalGenerator const* lg, std::string const& config,
    cmGeneratorTarget const* headTarget = nullptr,
    cmGeneratorExpressionDAGChecker* dagChecker = nullptr,
    cmGeneratorTarget const* currentTarget = nullptr,
    std::string const& language = std::string());

  enum PreprocessContext
  {
    StripAllGeneratorExpressions,
    BuildInterface,
    InstallInterface
  };

  static std::string Preprocess(std::string const& input,
                                PreprocessContext context,
                                cm::string_view importPrefix = {});

  static std::string Collect(
    std::string const& input,
    std::map<std::string, std::vector<std::string>>& collected);

  static void Split(std::string const& input,
                    std::vector<std::string>& output);

  static cm::string_view::size_type Find(cm::string_view const& input);

  static bool IsValidTargetName(std::string const& input);

  static std::string StripEmptyListElements(std::string const& input);

  static bool StartsWithGeneratorExpression(std::string const& input)
  {
    return input.length() >= 2 && input[0] == '$' && input[1] == '<';
  }
  static bool StartsWithGeneratorExpression(char const* input)
  {
    return input && input[0] == '$' && input[1] == '<';
  }

  static void ReplaceInstallPrefix(std::string& input,
                                   std::string const& replacement);

private:
  cmake& CMakeInstance;
  cmListFileBacktrace Backtrace;
};

class cmCompiledGeneratorExpression
{
public:
  ~cmCompiledGeneratorExpression();

  cmCompiledGeneratorExpression(cmCompiledGeneratorExpression const&) = delete;
  cmCompiledGeneratorExpression& operator=(
    cmCompiledGeneratorExpression const&) = delete;

  std::string const& Evaluate(
    cmLocalGenerator const* lg, std::string const& config,
    cmGeneratorTarget const* headTarget = nullptr,
    cmGeneratorExpressionDAGChecker* dagChecker = nullptr,
    cmGeneratorTarget const* currentTarget = nullptr,
    std::string const& language = std::string()) const;

  /** Get set of targets found during evaluations.  */
  std::set<cmGeneratorTarget*> const& GetTargets() const
  {
    return this->DependTargets;
  }

  std::set<std::string> const& GetSeenTargetProperties() const
  {
    return this->SeenTargetProperties;
  }

  std::set<cmGeneratorTarget const*> const& GetAllTargetsSeen() const
  {
    return this->AllTargetsSeen;
  }

  std::string const& GetInput() const { return this->Input; }

  cmListFileBacktrace GetBacktrace() const { return this->Backtrace; }
  bool GetHadContextSensitiveCondition() const
  {
    return this->HadContextSensitiveCondition;
  }
  bool GetHadHeadSensitiveCondition() const
  {
    return this->HadHeadSensitiveCondition;
  }
  bool GetHadLinkLanguageSensitiveCondition() const
  {
    return this->HadLinkLanguageSensitiveCondition;
  }
  std::set<cmGeneratorTarget const*> GetSourceSensitiveTargets() const
  {
    return this->SourceSensitiveTargets;
  }

  void SetEvaluateForBuildsystem(bool eval)
  {
    this->EvaluateForBuildsystem = eval;
  }

  void SetQuiet(bool quiet) { this->Quiet = quiet; }

  void GetMaxLanguageStandard(cmGeneratorTarget const* tgt,
                              std::map<std::string, std::string>& mapping);

private:
  cmCompiledGeneratorExpression(cmake& cmakeInstance,
                                cmListFileBacktrace backtrace,
                                std::string input);

  friend class cmGeneratorExpression;

  cmListFileBacktrace Backtrace;
  std::vector<std::unique_ptr<cmGeneratorExpressionEvaluator>> Evaluators;
  std::string const Input;
  bool NeedsEvaluation;
  bool EvaluateForBuildsystem = false;
  bool Quiet = false;

  mutable std::set<cmGeneratorTarget*> DependTargets;
  mutable std::set<cmGeneratorTarget const*> AllTargetsSeen;
  mutable std::set<std::string> SeenTargetProperties;
  mutable std::map<cmGeneratorTarget const*,
                   std::map<std::string, std::string>>
    MaxLanguageStandard;
  mutable std::string Output;
  mutable bool HadContextSensitiveCondition = false;
  mutable bool HadHeadSensitiveCondition = false;
  mutable bool HadLinkLanguageSensitiveCondition = false;
  mutable std::set<cmGeneratorTarget const*> SourceSensitiveTargets;
};

class cmGeneratorExpressionInterpreter
{
public:
  cmGeneratorExpressionInterpreter(cmLocalGenerator const* localGenerator,
                                   std::string config,
                                   cmGeneratorTarget const* headTarget,
                                   std::string language = std::string())
    : GeneratorExpression(*localGenerator->GetCMakeInstance())
    , LocalGenerator(localGenerator)
    , Config(std::move(config))
    , HeadTarget(headTarget)
    , Language(std::move(language))
  {
  }

  cmGeneratorExpressionInterpreter(cmGeneratorExpressionInterpreter const&) =
    delete;
  cmGeneratorExpressionInterpreter& operator=(
    cmGeneratorExpressionInterpreter const&) = delete;

  std::string const& Evaluate(std::string expression,
                              std::string const& property);

protected:
  cmGeneratorExpression GeneratorExpression;
  std::unique_ptr<cmCompiledGeneratorExpression> CompiledGeneratorExpression;
  cmLocalGenerator const* LocalGenerator = nullptr;
  std::string Config;
  cmGeneratorTarget const* HeadTarget = nullptr;
  std::string Language;
};
