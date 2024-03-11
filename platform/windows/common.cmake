
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
# set(OSQUERY_BITNESS "" CACHE STRING "osquery build bitness (32 or 64)")


set(PROGRAM_FILES_DIR "Program Files")

# set(directory_name_list
#   "osquery"
# )

set(file_name_list
    "osqueryi.exe"
)

# foreach(directory_name ${directory_name_list})
#   install(
#     DIRECTORY "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/${directory_name}"
#     DESTINATION "."
#     COMPONENT osquery
#   )
# endforeach()


  install(
    FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryi.exe"
    DESTINATION "."
    COMPONENT osquery
  )


install(
  FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryd/osqueryd.exe"
  DESTINATION "osqueryd"
  COMPONENT osquery
)

# install(
#   FILES "${OSQUERY_DATA_PATH}/${PROGRAM_FILES_DIR}/osquery/osqueryd/osqueryd.exe"
#   DESTINATION "osqueryd"
#   COMPONENT osquery
# )
