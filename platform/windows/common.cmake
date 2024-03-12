set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(OSQUERY_BITNESS "" CACHE STRING "osquery build bitness (32 or 64)")

if ("${OSQUERY_BITNESS}" STREQUAL "32")
  set(PROGRAM_FILES_DIR "Program Files (x86)")
else()
  set(PROGRAM_FILES_DIR "Program Files")
endif()

set(directory_name_list
  "certs"
  "packs"
  "log"
)

set(file_name_list
  "manage-osqueryd.ps1"
  "osquery.conf"
  "osquery.flags"
  "osquery.man"
  "osquery_utils.ps1"
  "osqueryi.exe"
)

foreach(directory_name ${directory_name_list})
  install(
    DIRECTORY "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/${directory_name}"
    DESTINATION "."
    COMPONENT osquery
  )
endforeach()

foreach(file_name ${file_name_list})
  install(
    FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/${file_name}"
    DESTINATION "."
    COMPONENT osquery
  )
endforeach()

set(VISTAR_EXE_PATH "${CMAKE_SOURCE_DIR}/dist/vistar.exe")

if(EXISTS "${VISTAR_EXE_PATH}")
  install(
    FILES "${VISTAR_EXE_PATH}"
    DESTINATION "vistar"  
    COMPONENT osquery
  )
else()
  message(WARNING "File not found: ${VISTAR_EXE_PATH}. Skipping installation.")
endif()