

project("vistar")
cmake_minimum_required(VERSION 3.17.5)

set(OSQUERY_DATA_PATH "" CACHE PATH "osquery package data")
set(CPACK_PACKAGE_VERSION "1.0.1")

if(OSQUERY_DATA_PATH STREQUAL "")
  message(FATAL_ERROR "Missing data folder")
endif()
set(CPACK_GENERATOR "WIX")


set(OSQUERY_BITNESS "64")

set(CPACK_PACKAGE_DESCRIPTION "osquery is an operating system instrumentation toolchain.")
set(CPACK_COMPONENT_OSQUERY_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}")
set(CPACK_PACKAGE_NAME "vistar")


include("platform/common.cmake")
include("platform/windows/common.cmake")
include("platform/windows/wix.cmake")

include(CPack)

cpack_add_component("osquery"
  DISPLAY_NAME "Main binaries and tools"
  REQUIRED
)
