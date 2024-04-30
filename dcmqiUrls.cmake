# Checksum copied from "dcmqi_checksums.txt" associated with the dcmqi GitHub release

set(version "1.3.2")

set(linux_filename    "dcmqi-${version}-linux.tar.gz")
set(linux_sha256      "bdeb99a05465e568629a7e9f72903e3f3c108ab756856f4f5e1c1a714df7c609")

set(macos_filename    "dcmqi-${version}-mac.tar.gz")
set(macos_sha256      "07f785318c3b73af73fed5919080481ef1580dbfdbde2a1aec272736848cc417")

set(win64_filename    "dcmqi-${version}-win64.zip")
set(win64_sha256      "e5a5328743f8128517f21b0ea1e20fd68b2844908f7349a5b40d7b0aa9af7374")


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
