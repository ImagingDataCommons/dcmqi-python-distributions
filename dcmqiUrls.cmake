# Checksums computed from assets associated with the dcmqi GitHub release

set(version "1.5.4")

set(linux_filename        "dcmqi-1.5.4-linux.tar.gz")
set(linux_sha256          "efa6c64147e8597020471241eab04b442575cae553772a22ab5b0ff477169c43")

set(macos_arm64_filename  "dcmqi-1.5.4-mac-arm64.tar.gz")
set(macos_arm64_sha256    "f0b48112838ae70fd9380fd607d0ed945f152ebcc5ed80f035540a676fe9cfd3")

set(macos_x86_64_filename "dcmqi-1.5.4-mac-x86_64.tar.gz")
set(macos_x86_64_sha256   "ec4d3893497a523c145096483718534c9a4ff6942bad30262d999197693ff4e0")

set(win64_filename        "dcmqi-1.5.4-win64.zip")
set(win64_sha256          "cf966ebe902a8b6c4e592c428158d8c1e0938727d8ed46078fb2f9ced6e40d48")


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
