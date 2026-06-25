# Checksums computed from assets associated with the dcmqi GitHub release

set(version "1.5.6")

set(linux_filename        "dcmqi-1.5.6-linux.tar.gz")
set(linux_sha256          "eb2743e5c24dec38aafe06612b18d200516f39b8f0d62592a926ca6e8cfb5187")

set(macos_arm64_filename  "dcmqi-1.5.6-mac-arm64.tar.gz")
set(macos_arm64_sha256    "20965b3afcd1d2a878fd3e09e3ee44de655e350d6fe43f9663c93348610f662e")

set(macos_x86_64_filename "dcmqi-1.5.6-mac-x86_64.tar.gz")
set(macos_x86_64_sha256   "6678f2a60547c3a14a9f0376932217c3faee28158b6805c3b89d303df0640747")

set(win64_filename        "dcmqi-1.5.6-win64.zip")
set(win64_sha256          "72f4bf6bc6b265e5843c42436267fb59a8079ca765095f218300d019f9e15e3d")


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
