# Checksums computed from assets associated with the dcmqi GitHub release

set(version "1.5.2")

set(linux_filename        "dcmqi-${version}-linux.tar.gz")
set(linux_sha256          "09e59dac5d11941e3d49298cc43e91763763badf750c56bd8f3c185021f5f757")

set(macos_arm64_filename  "dcmqi-${version}-mac-arm64.tar.gz")
set(macos_arm64_sha256    "feab6633536dd506cb5d806118595dad3d73991965b5e0929aa35c58c973f919")

set(macos_x86_64_filename "dcmqi-${version}-mac-x86_64.tar.gz")
set(macos_x86_64_sha256   "8de7d962644b28366589ffbf487649a9d3532e109cf6853f5af51d4c97f0b7bf")

set(win64_filename        "dcmqi-${version}-win64.zip")
set(win64_sha256          "6a8798c9201a99afe6cdafd5eeb89c40d3436f40d66f8ecaabe45d9294aecfd4")


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
