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

# set(CPACK_WIX_UI_BANNER "${VISTAR_DATA_PATH}/images/banner.bmp")
set(CPACK_WIX_PRODUCT_ICON "${VISTAR_DATA_PATH}/images/vistar.ico")
set(CPACK_WIX_PROGRAM_MENU_FOLDER "Vistar")
set(CPACK_WIX_UI_DIALOG "${VISTAR_DATA_PATH}/images/Vistar.bmp")
set(CPACK_WIX_UPGRADE_GUID "ea6c7327-461e-4033-847c-acdf2b85dede")
set(CPACK_WIX_PATCH_FILE "${VISTAR_DATA_PATH}/osquery_wix_patch.xml")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "Vistar")
set(CPACK_WIX_EXTENSIONS "WixUI_Minimal")