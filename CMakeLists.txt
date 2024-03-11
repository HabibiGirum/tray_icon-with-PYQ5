

project("osquery")
cmake_minimum_required(VERSION 3.17.5)
# install(CODE "execute_process(COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/preinstall.sh)")

set(OSQUERY_DATA_PATH "" CACHE PATH "osquery package data")
set(CPACK_PACKAGE_VERSION "5.10.2" )

if(OSQUERY_DATA_PATH STREQUAL "")
  message(FATAL_ERROR "Missing data folder")
endif()

# if(NOT CPACK_GENERATOR)
#   message(FATAL_ERROR "The CPACK_GENERATOR variable was not set")
# endif()

# if(OSQUERY_PACKAGE_VERSION STREQUAL "")
#   message(FATAL_ERROR "The OSQUERY_PACKAGE_VERSION variable was not set")
# endif()
# set(CPACK_PACKAGE_VERSION "${OSQUERY_PACKAGE_VERSION}")

set(CPACK_PACKAGE_DESCRIPTION "osquery is an operating system instrumentation toolchain.")
set(CPACK_COMPONENT_OSQUERY_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}")
set(CPACK_PACKAGE_NAME "osquery")

string(TOLOWER "${CMAKE_SYSTEM_NAME}" platform_name)
set(platform_name "windows")

include("platform/common.cmake")
include("platform/${platform_name}/common.cmake")

# string(TOLOWER "${CPACK_GENERATOR}" generator_name)
include("platform/${platform_name}/wix.cmake")
set(CPACK_PACKAGE_NAME "Vistar")

include(CPack)

cpack_add_component("osquery"
  DISPLAY_NAME "Main binaries and tools"
  REQUIRED
)