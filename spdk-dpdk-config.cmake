# - spdk-dpdk config
# Find the DPDK includes and libraries
#
# Defined variables:
#   DPDK_INCLUDE_DIR
#   DPDK_FOUND
#   DPDK_LIBRARY
#   (DPDK_LIBRARY_RTE_EAL)
#   DPDK::<LIBRARY>
#     ex. DPDK::rte_eal

function(set_library_target NAMESPACE LIB_NAME LIB_FILE_NAME INCLUDE_DIR)
	if(NOT TARGET ${NAMESPACE}::${LIB_NAME})
		add_library(${NAMESPACE}::${LIB_NAME} STATIC IMPORTED)
		set_target_properties(${NAMESPACE}::${LIB_NAME} PROPERTIES
			IMPORTED_LOCATION "${LIB_FILE_NAME}"
			INTERFACE_INCLUDE_DIRECTORIES "${INCLUDE_DIR}")
		set(${NAMESPACE}_${LIB_NAME}_FOUND 1)
	endif()
endfunction()

find_path(DPDK_INCLUDE_DIR rte_eal.h
	PATHS
		ENV DPDK_ROOT_DIR
		ENV DPDK_INCLUDE_DIR
		ENV SPDK_ROOT_DIR
		${DPDK_ROOT_DIR}
		${DPDK_INCLUDE_DIR}
		${SPDK_ROOT_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		include
	NO_DEFAULT_PATH
)
find_library(DPDK_LIBRARY
	NAMES dpdk
	PATHS
		ENV DPDK_ROOT_DIR
		ENV DPDK_LIB_DIR
		ENV SPDK_ROOT_DIR
		${DPDK_ROOT_DIR}
		${DPDK_LIB_DIR}
		${SPDK_ROOT_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		lib
	NO_DEFAULT_PATH
)
find_library(DPDK_LIBRARY_RTE_EAL
	NAMES rte_eal
	PATHS
		ENV DPDK_ROOT_DIR
		ENV DPDK_LIB_DIR
		ENV SPDK_ROOT_DIR
		${DPDK_ROOT_DIR}
		${DPDK_LIB_DIR}
		${SPDK_ROOT_DIR}
		/usr
		/usr/local
	PATH_SUFFIXES
		lib
	NO_DEFAULT_PATH
)
mark_as_advanced(DPDK_INCLUDE_DIR DPDK_LIBRARY DPKD_LIBRARY_RTE_EAL)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DPDK
	REQUIRED_VARS
		DPDK_INCLUDE_DIR
		DPDK_LIBRARY_RTE_EAL
)

if (DPDK_FOUND)
	get_filename_component(DPDK_LIBRARY_DIR ${DPDK_LIBRARY_RTE_EAL} DIRECTORY)
	file(GLOB DPDK_LIBS ${DPDK_LIBRARY_DIR}/librte*.so)
	foreach(LIB_FILE_NAME ${DPDK_LIBS})
		get_filename_component(LIB_NAME ${LIB_FILE_NAME} NAME_WE)
		get_filename_component(FULL_LIB_NAME ${LIB_FILE_NAME} NAME)
		string(REPLACE "lib" "" LIB_NAME "${LIB_NAME}")
		set_library_target("DPDK" "${LIB_NAME}" "${DPDK_LIBRARY_DIR}/${FULL_LIB_NAME}" "${DPDK_INCLUDE_DIR}")
	endforeach()
endif()
