# - spdk config
# Find the SPDK includes and libraries
#
# Defined variables:
#   SPDK_INCLUDE_DIR
#   SPDK_LIBRARY
#   SPDK_FOUND
#   SPDK::<LIBRARY>
#     ex. SPDK::spdk_blob

function(set_library_target NAMESPACE LIB_NAME LIB_FILE_NAME INCLUDE_DIR)
	if(NOT TARGET ${NAMESPACE}::${LIB_NAME})
		add_library(${NAMESPACE}::${LIB_NAME} STATIC IMPORTED)
		set_target_properties(${NAMESPACE}::${LIB_NAME} PROPERTIES
			IMPORTED_LOCATION "${LIB_FILE_NAME}"
			INTERFACE_INCLUDE_DIRECTORIES "${INCLUDE_DIR}")
	endif()
	set(${NAMESPACE}_${LIB_NAME}_FOUND 1)
endfunction()

find_path(SPDK_INCLUDE_DIR spdk/env.h
	PATHS
		ENV SPDK_ROOT_DIR
		ENV SPDK_INCLUDE_DIR
		${SPDK_ROOT_DIR}
		${SPDK_INCLUDE_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		include
)
find_library(SPDK_LIBRARY
	NAMES spdk
	PATHS
		ENV SPDK_ROOT_DIR
		ENV SPDK_LIB_DIR
		${SPDK_ROOT_DIR}
		${SPDK_LIB_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		lib
)
mark_as_advanced(SPDK_INCLUDE_DIR SPKD_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SPDK
	REQUIRED_VARS
		SPDK_INCLUDE_DIR
		SPDK_LIBRARY
)

if (SPDK_FOUND)
	get_filename_component(SPDK_LIBRARY_DIR ${SPDK_LIBRARY} DIRECTORY)
	file(GLOB SPDK_LIBRARY ${SPDK_LIBRARY_DIR}/libspdk*.so)
	foreach(LIB_FILE_NAME ${SPDK_LIBRARY})
		get_filename_component(LIB_NAME ${LIB_FILE_NAME} NAME_WE)
		get_filename_component(FULL_LIB_NAME ${LIB_FILE_NAME} NAME)
		string(REPLACE "lib" "" LIB_NAME "${LIB_NAME}")
		set_library_target("SPDK" "${LIB_NAME}" "${SPDK_LIBRARY_DIR}/${FULL_LIB_NAME}" "${SPDK_INCLUDE_DIR}")
	endforeach()
endif()

