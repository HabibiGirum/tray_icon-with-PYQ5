

project("osquery")
cmake_minimum_required(VERSION 3.17.5)

set(OSQUERY_DATA_PATH "" CACHE PATH "osquery package data")
set(CPACK_PACKAGE_VERSION "1.0.1")

if(OSQUERY_DATA_PATH STREQUAL "")
  message(FATAL_ERROR "Missing data folder")
endif()
# set(CPACK_GENERATOR "WIX")

# if(NOT CPACK_GENERATOR)
#   message(FATAL_ERROR "The CPACK_GENERATOR variable was not set")
# endif()

if(OSQUERY_PACKAGE_VERSION STREQUAL "")
  message(FATAL_ERROR "The OSQUERY_PACKAGE_VERSION variable was not set")
endif()
set(CPACK_PACKAGE_VERSION "${OSQUERY_PACKAGE_VERSION}")

set(CPACK_PACKAGE_DESCRIPTION "osquery is an operating system instrumentation toolchain.")
set(CPACK_COMPONENT_OSQUERY_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}")
set(CPACK_PACKAGE_NAME "osquery")
# set(CPACK_PACKAGE_VENDOR "osquery")
# set(CPACK_PACKAGE_CONTACT "osquery@osquery.io")
# set(CPACK_PACKAGE_HOMEPAGE_URL "https://osquery.io")

# string(TOLOWER "${CMAKE_SYSTEM_NAME}" platform_name)
# if(platform_name STREQUAL "darwin")
#   set(platform_name "macos")
# endif()

include("platform/common.cmake")
include("platform/windows/common.cmake")

# string(TOLOWER "${CPACK_GENERATOR}" generator_name)
include("platform/windows/wix.cmake")

include(CPack)

cpack_add_component("osquery"
  DISPLAY_NAME "Main binaries and tools"
  REQUIRED
)