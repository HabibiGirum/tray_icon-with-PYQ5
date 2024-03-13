set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(OSQUERY_BITNESS "64")
set(PROGRAM_FILES_DIR "Program Files")
install(
  FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryi.exe"
  DESTINATION "."
  COMPONENT vistar
)


install(
  FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/vistar/vistar.exe"
  DESTINATION "vistar"
  COMPONENT vistar
)