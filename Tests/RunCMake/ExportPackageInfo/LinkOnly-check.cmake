include(${CMAKE_CURRENT_LIST_DIR}/Assertions.cmake)

set(out_dir "${RunCMake_BINARY_DIR}/LinkOnly-build")

file(READ "${out_dir}/bar.cps" content)
string(JSON component GET "${content}" "components" "bar")
expect_array("${component}" 2 "link_requires")
expect_value("${component}" "foo:linkOnlyOne" "link_requires" 0)
expect_value("${component}" "foo:linkOnlyTwo" "link_requires" 1)
expect_array("${component}" 1 "requires")
expect_value("${component}" "foo:foo" "requires" 0)
expect_missing("${component}" "foo:foo" "link_libraries")
