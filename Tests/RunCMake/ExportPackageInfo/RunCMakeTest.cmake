include(RunCMake)

# Test experimental gate
run_cmake(ExperimentalGate)
run_cmake(ExperimentalWarning)

# Enable experimental feature and suppress warnings
set(RunCMake_TEST_OPTIONS
  -Wno-dev
  "-DCMAKE_EXPERIMENTAL_EXPORT_PACKAGE_INFO:STRING=b80be207-778e-46ba-8080-b23bba22639e"
  "-DCMAKE_EXPERIMENTAL_FIND_CPS_PACKAGES:STRING=e82e467b-f997-4464-8ace-b00808fff261"
  )

# Test incorrect usage
run_cmake(BadArgs1)
run_cmake(BadArgs2)
run_cmake(BadArgs3)
run_cmake(BadArgs4)
run_cmake(BadName)
run_cmake(DuplicateOutput)
run_cmake(BadDefaultTarget)
run_cmake(ReferencesNonExportedTarget)
run_cmake(ReferencesWronglyExportedTarget)
run_cmake(ReferencesWronglyImportedTarget)
run_cmake(ReferencesWronglyNamespacedTarget)
run_cmake(DependsMultipleDifferentNamespace)
run_cmake(DependsMultipleDifferentSets)
run_cmake(LinkInterfaceGeneratorExpression)
run_cmake(LinkOnlyRecursive)

# Test functionality
run_cmake(Appendix)
run_cmake(InterfaceProperties)
run_cmake(Metadata)
run_cmake(ProjectMetadata)
run_cmake(NoProjectMetadata)
run_cmake(Minimal)
run_cmake(MinimalVersion)
run_cmake(LowerCaseFile)
run_cmake(Requirements)
run_cmake(TargetTypes)
run_cmake(DependsMultiple)
run_cmake(LinkOnly)
run_cmake(Config)
run_cmake(EmptyConfig)
run_cmake(FileSetHeaders)
run_cmake(DependencyVersionCMake)
run_cmake(DependencyVersionCps)
