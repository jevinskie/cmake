include(${CMAKE_CURRENT_LIST_DIR}/Assertions.cmake)

set(CREATION_INFO_EXPECTED [=[
{
  "@id": "_:Build#CreationInfo",
  "comment": "This SBOM was generated from the CMakeLists.txt File",
  "createdBy":
  [
    "https://gitlab.kitware.com/cmake/cmake"
  ],
  "specVersion": "3.0.1",
  "type": "CreationInfo"
}
]=])

set(SPDX_DOCUMENT_EXPECTED [=[
{
  "name" : "dog",
  "profileConformance" :
  [
    "core",
    "software"
  ],
  "creationInfo" : "_:Build#CreationInfo",
  "spdxId" : "urn:dog#SPDXDocument",
  "type" : "SpdxDocument"
}
]=])

set(APPLICATION_EXPECTED [=[
{
  "spdxId" : "urn:canine#Package",
  "name" : "canine",
  "software_primaryPurpose" : "library",
  "type" : "software_Package"
}
]=])

set(DEPENDENCY_EXPECTED [=[
{
  "spdxId" : "urn:mammal#Package",
  "name" : "mammal",
  "type" : "software_Package"
}
]=])

set(BUILD_LINKED_LIBRARIES_EXPECTED [=[
{
  "creationInfo" : "_:Build#CreationInfo",
  "description" : "Required Build-Time Libraries",
  "from" : "urn:canine#Package",
  "relationshipType" : "dependsOn",
  "spdxId" : "urn:Shared#Relationship",
  "to" :
  [
    "urn:mammal#Package"
  ],
  "type" : "Relationship"
}
]=])


expect_value("${content}" "https://spdx.org/rdf/3.0.1/spdx-context.jsonld" "@context")
string(JSON CREATION_INFO GET "${content}" "@graph" "0")
expect_object("${CREATION_INFO}" CREATION_INFO_EXPECTED)

string(JSON SPDX_DOCUMENT GET "${content}" "@graph" "1")
expect_object("${SPDX_DOCUMENT}" SPDX_DOCUMENT_EXPECTED)
expect_object("${SPDX_DOCUMENT}" APPLICATION_EXPECTED "rootElement")
expect_object("${SPDX_DOCUMENT}" DEPENDENCY_EXPECTED "element")
string(JSON LINKED_LIBRARIES GET "${content}" "@graph" "2")
expect_object("${LINKED_LIBRARIES}" BUILD_LINKED_LIBRARIES_EXPECTED)
