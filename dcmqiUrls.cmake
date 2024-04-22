# Checksum copied from "dcmqi_checksums.txt" associated with the dcmqi GitHub release

set(version "1.3.1")

set(linux_filename    "dcmqi-${version}-linux.tar.gz")
set(linux_sha256      "b119f1d292f3214203e5812fadbc527282400eed8342431539411d62fcc91c89")

set(macos_filename    "dcmqi-${version}-mac.tar.gz")
set(macos_sha256      "24ed2dcce2cfe918e17c889e22505c679c73263eab247ad291e19ab8b26ebf5a")

set(win64_filename    "dcmqi-${version}-win64.zip")
set(win64_sha256      "141a3f713ace11bc956818d34af6a923f92d3dcaaf0675c1c88db75f2ac221f4")


cmake_host_system_information(RESULT is_64bit QUERY IS_64BIT)

set(archive "linux")

if(APPLE)
  set(archive "macos")
endif()

if(WIN32)
  if(is_64bit AND NOT (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "ARM64"))
    set(archive "win64")
  endif()
endif()

if(NOT DEFINED "${archive}_filename")
  message(FATAL_ERROR "Failed to determine which archive to download: '${archive}_filename' variable is not defined")
endif()

if(NOT DEFINED "${archive}_sha256")
  message(FATAL_ERROR "Could you make sure variable '${archive}_sha256' is defined ?")
endif()

set(dcmqi_archive_filename "${${archive}_filename}")
set(dcmqi_archive_sha256 "${${archive}_sha256}")

set(dcmqi_archive_url "https://github.com/QIICR/dcmqi/releases/download/v${version}/${dcmqi_archive_filename}")
