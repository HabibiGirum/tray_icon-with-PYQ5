set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(OSQUERY_BITNESS "" CACHE STRING "osquery build bitness (32 or 64)")


set(PROGRAM_FILES_DIR "Program Files")



install(
  FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryi.exe"
  DESTINATION "."
  COMPONENT osquery
)


install(
  FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryd/vistar.exe"
  DESTINATION "osqueryd"
  COMPONENT osquery
)

# set(VISTAR_EXE_PATH "${CMAKE_SOURCE_DIR}/dist/vistar.exe")

# if(EXISTS "${VISTAR_EXE_PATH}")
#   install(
#     FILES "${VISTAR_EXE_PATH}"
#     DESTINATION "vistar"  
#     COMPONENT osquery
#   )
# else()
#   message(WARNING "File not found: ${VISTAR_EXE_PATH}. Skipping installation.")
# endif()