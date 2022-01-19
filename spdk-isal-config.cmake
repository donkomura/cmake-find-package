# - isa-l config
# Find the isa-l includes and libraries
#
# Defined variables:
#   ISAL_INCLUDE_DIR
#   ISAL_LIBRARY
#   ISAL::ISAL

find_path(ISAL_INCLUDE_DIR crc.h
	PATHS
		ENV ISAL_ROOT_DIR
		ENV ISAL_INCLUDE_DIR
		${ISAL_ROOT_DIR}
		${ISAL_LIB_DIR}
		${SPDK_ROOT_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		include
	NO_DEFAULT_PATH
)
find_library(ISAL_LIBRARY
	NAMES isal
	PATHS
		ENV ISAL_ROOT_DIR
		ENV ISAL_LIB_DIR
		${ISAL_ROOT_DIR}
		${ISAL_LIB_DIR}
		${SPDK_ROOT_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		lib
	NO_DEFAULT_PATH
)

mark_as_advanced(ISAL_INCLUDE_DIR ISAL_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ISAL
	REQUIRED_VARS
		ISAL_INCLUDE_DIR
		ISAL_LIBRARY
)

if (ISAL_FOUND AND NOT TARGET ISAL::ISAL)
	add_library(ISAL::ISAL UNKNOWN IMPORTED)
	set_target_properties(ISAL::ISAL PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${ISAL_INCLUDE_DIR}"
		IMPORTED_LOCATION "${ISAL_LIBRARY}"
)
endif()
