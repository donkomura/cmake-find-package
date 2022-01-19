cmake_minimum_required(VERSION 3.8)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}")
project(example)

find_package(Threads REQUIRED)
find_package(spdk CONFIG REQUIRED)
find_package(spdk-dpdk CONFIG REQUIRED)
find_package(isal CONFIG REQUIRED)

include_directories(${SPDK_INCLUDE_DIR} ${DPDK_INCLUDE_DIR})

# core libraries
set(SPDK_BLOCKDEV_LIBS
	SPDK::spdk_bdev_malloc SPDK::spdk_bdev_null
	SPDK::spdk_bdev_nvme SPDK::spdk_bdev_passthru SPDK::spdk_bdev_lvol
	SPDK::spdk_bdev_raid SPDK::spdk_bdev_error SPDK::spdk_bdev_split
	SPDK::spdk_bdev_gpt SPDK::spdk_bdev_delay SPDK::spdk_bdev_zone_block)
set(SPDK_BLOB_LIBS
	SPDK::spdk_blobfs SPDK::spdk_blobfs_bdev SPDK::spdk_blob_bdev
	SPDK::spdk_blob SPDK::spdk_lvol SPDK::spdk_vmd SPDK::spdk_nvme)
set(SPDK_RDMA_LIBS SPDK::spdk_rdma)
set(SPDK_LINUX_LIBS SPDK::spdk_bdev_flt SPDK::spdk_flt SPDK::spdk_aio)
set(SPDK_ACCEL_LIBS SPDK::spdk_accel_ioat SPDK::spdk_ioat SPDK::spdk_accel)
set(SPDK_SCHED_LIBS SPDK::spdk_scheduler_dynamic SPDK::spdk_scheduler_dpdk_governor
	SPDK::spdk_scheduler_gscheduler)
set(SPDK_SOCK_LIBS SPDK::spdk_sock_posix SPDK::spdk_sock)

add_executable(blob blob.cpp)
target_link_libraries(blob
	${Boost_LIBRARIES}
	${SPDK_BLOCKDEV_LIBS}
	${SPDK_BLOB_LIBS}
	${SPDK_ACCEL_LIBS}
	${SPDK_SCHED_LIBS}
	${SPDK_SOCK_LIBS}
	${SPDK_RDMA_LIBS}
	# dependents
	SPDK::spdk_bdev_virtio
	SPDK::spdk_bdev
	SPDK::spdk_virtio
	SPDK::spdk_init
	SPDK::spdk_event
	SPDK::spdk_event_accel
	SPDK::spdk_event_bdev
	SPDK::spdk_event_vmd
	SPDK::spdk_event_sock
	SPDK::spdk_env_dpdk
	SPDK::spdk_dma
	SPDK::spdk_json
	SPDK::spdk_jsonrpc
	SPDK::spdk_rpc
	SPDK::spdk_trace
	SPDK::spdk_notify
	SPDK::spdk_thread
	SPDK::spdk_util
	SPDK::spdk_log
	DPDK::rte_eal
	DPDK::rte_mempool
	DPDK::rte_ring
	DPDK::rte_mbuf
	DPDK::rte_bus_pci
	DPDK::rte_pci
	DPDK::rte_mempool_ring
	DPDK::rte_power
	DPDK::rte_ethdev
	DPDK::rte_net
	DPDK::rte_telemetry
	DPDK::rte_kvargs
	DPDK::rte_vhost
	DPDK::rte_cryptodev
	DPDK::rte_hash
	DPDK::rte_rcu
	ISAL::ISAL
	numa
	rdmacm
	uuid
	ibverbs
	pthread
	dl
	rt
)
