# Checksums computed from assets associated with the dcmqi GitHub release

set(version "1.5.3")

set(linux_filename        "dcmqi-1.5.3-linux.tar.gz")
set(linux_sha256          "bb56072bd5c01005fc7ceaefb9c0010320d7fb0e25e0138ccaa102393b798821")

set(macos_arm64_filename  "dcmqi-1.5.3-mac-arm64.tar.gz")
set(macos_arm64_sha256    "edc3426eb551b8f2ae995c2a1ea099812589eda923dcd8a6ece8fd3b7cbe4947")

set(macos_x86_64_filename "dcmqi-1.5.3-mac-x86_64.tar.gz")
set(macos_x86_64_sha256   "3fb3bb20ccf04f3658b13fd06a11bce7c6f5b40b3495b179353274a3af202966")

set(win64_filename        "dcmqi-1.5.3-win64.zip")
set(win64_sha256          "48a52a505c8b371be57168e56b33d903955736c76a6f57c232f9b2762088743d")


cmake_host_system_information(RESULT is_64bit QUERY IS_64BIT)

set(archive "linux")

if(APPLE)
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
    set(archive "macos_arm64")
  else()
    set(archive "macos_x86_64")
  endif()
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
