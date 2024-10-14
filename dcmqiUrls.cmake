# Checksum copied from "dcmqi_checksums.txt" associated with the dcmqi GitHub release

set(version "1.3.4")

set(linux_filename    "dcmqi-${version}-linux.tar.gz")
set(linux_sha256      "4b9ecc27bde8befd35c0b95449744c3a3b43466592a7211e8f5adbfe9e497608")

set(macos_filename    "dcmqi-${version}-mac.tar.gz")
set(macos_sha256      "691cc64815016b76665c798713dee38447ec8acf9a6f059db5e78415a902c4b0")

set(win64_filename    "dcmqi-${version}-win64.zip")
set(win64_sha256      "f9d5ec1bf9e5b0ba4e2cddabfa8d773afee167a48f71a48ec61549a6dcba06bd")


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
