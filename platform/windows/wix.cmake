#
# Copyright (c) 2014-present, The osquery authors
#
# This source code is licensed as defined by the LICENSE file found in the
# root directory of this source tree.
#
# SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0-only)
#

if(OSQUERY_BITNESS STREQUAL "32")
  set(CPACK_WIX_SIZEOF_VOID_P "4")

elseif(OSQUERY_BITNESS STREQUAL "64")
  set(CPACK_WIX_SIZEOF_VOID_P "8")

else()
  message(FATAL_ERROR "The OSQUERY_BITNESS variable must be set to either 32 or 64 according to the build type")
endif()

set(CPACK_WIX_PRODUCT_ICON "${CMAKE_SOURCE_DIR}/images/vistar.ico")
set(CPACK_WIX_UPGRADE_GUID "3f59e9c0-720f-4948-afa9-883805397642")
set(CPACK_WIX_PATCH_FILE "${CMAKE_SOURCE_DIR}/osquery_wix_patch.xml")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "osquery")
set(CPACK_WIX_EXTENSIONS "WixUtilExtension")