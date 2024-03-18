

project("vistar")
cmake_minimum_required(VERSION 3.17.5)

set(OSQUERY_DATA_PATH "" CACHE PATH "osquery package data")
set(CPACK_PACKAGE_VERSION "" CACHE STRING "osquery package version")

if(OSQUERY_DATA_PATH STREQUAL "")
  message(FATAL_ERROR "Missing data folder")
endif()

if(NOT CPACK_GENERATOR)
  message(FATAL_ERROR "The CPACK_GENERATOR variable was not set")
endif()

if(OSQUERY_PACKAGE_VERSION STREQUAL "")
  message(FATAL_ERROR "The OSQUERY_PACKAGE_VERSION variable was not set")
endif()
set(CPACK_PACKAGE_VERSION "${OSQUERY_PACKAGE_VERSION}")

set(CPACK_PACKAGE_DESCRIPTION "osquery is an operating system instrumentation toolchain.")
set(CPACK_COMPONENT_OSQUERY_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}")
set(CPACK_PACKAGE_NAME "vistar")
set(CPACK_PACKAGE_VENDOR "vistar")
set(CPACK_PACKAGE_CONTACT "osquery@osquery.io")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://osquery.io")

string(TOLOWER "${CMAKE_SYSTEM_NAME}" platform_name)
if(platform_name STREQUAL "darwin")
  set(platform_name "macos")
endif()

include("platform/common.cmake")
include("platform/${platform_name}/common.cmake")

string(TOLOWER "${CPACK_GENERATOR}" generator_name)
include("platform/${platform_name}/${generator_name}.cmake")

include(CPack)

cpack_add_component("vistar"
  DISPLAY_NAME "Main binaries and tools"
  REQUIRED
)