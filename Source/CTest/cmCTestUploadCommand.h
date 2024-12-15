/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file Copyright.txt or https://cmake.org/licensing for details.  */
#pragma once

#include "cmConfigure.h" // IWYU pragma: keep

#include <string>
#include <vector>

#include "cmArgumentParserTypes.h"
#include "cmCTestHandlerCommand.h"

class cmExecutionStatus;

class cmCTestUploadCommand : public cmCTestHandlerCommand
{
public:
  using cmCTestHandlerCommand::cmCTestHandlerCommand;

protected:
  struct UploadArguments : BasicArguments
  {
    ArgumentParser::MaybeEmpty<std::vector<std::string>> Files;
    bool Quiet = false;
  };

private:
  std::string GetName() const override { return "ctest_upload"; }

  bool ExecuteUpload(UploadArguments& args, cmExecutionStatus& status) const;

  bool InitialPass(std::vector<std::string> const& args,
                   cmExecutionStatus& status) const override;
};
