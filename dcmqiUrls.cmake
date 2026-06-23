# Checksums computed from assets associated with the dcmqi GitHub release

set(version "1.5.5")

set(linux_filename        "dcmqi-1.5.5-linux.tar.gz")
set(linux_sha256          "b1a39c660862ed1d11959d72734b64d79c04299a7b68a5705def1a7e2728a1b6")

set(macos_arm64_filename  "dcmqi-1.5.5-mac-arm64.tar.gz")
set(macos_arm64_sha256    "746c710f5e27ee4ab0f7e9223b0d0c2ab19ecba7c8125704090b301a4fabe9de")

set(macos_x86_64_filename "dcmqi-1.5.5-mac-x86_64.tar.gz")
set(macos_x86_64_sha256   "e693fbf04faf572c9257527a00155d2c3829736c8dfbea8a5264d120f7389fd8")

set(win64_filename        "dcmqi-1.5.5-win64.zip")
set(win64_sha256          "0a07fee85ba1aa8eb92051f3f378276e36bcf069f8b6ba2ee7f99854662bc547")


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
