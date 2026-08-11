# Selects the dcmqi release asset matching the platform and architecture being built for.
#
# The available assets and their checksums come from dcmqiUrls.cmake, which the update-dcmqi
# workflow regenerates; this file holds the logic and is written by hand.
#
# Picking the wrong asset is silent: a mismatched archive still extracts and installs, and the
# wheel only fails later, when a user runs a binary that cannot execute on their machine. So
# anything short of an exact platform/architecture match is a hard error here.

if(NOT DEFINED version)
  message(FATAL_ERROR "dcmqiUrls.cmake must be included before dcmqiArchive.cmake")
endif()

# The architecture this build *targets*, which is not always the host's:
#
#  * Visual Studio generators carry the target in CMAKE_GENERATOR_PLATFORM, and
#    scikit-build-core sets it from the interpreter the wheel is being built for. A 32-bit
#    Python on a 64-bit runner therefore reports "Win32" here while the host still looks
#    64-bit -- precisely the case that used to be mistaken for win64.
#  * macOS cross builds set CMAKE_OSX_ARCHITECTURES (scikit-build-core derives it from
#    ARCHFLAGS, which cibuildwheel sets).
#
# CMAKE_SYSTEM_PROCESSOR reports the host whenever we are not cross-compiling, so it only
# serves as the fallback.
set(_dcmqi_arch "${CMAKE_SYSTEM_PROCESSOR}")
if(APPLE AND CMAKE_OSX_ARCHITECTURES)
  list(LENGTH CMAKE_OSX_ARCHITECTURES _dcmqi_arch_count)
  if(_dcmqi_arch_count GREATER 1)
    message(FATAL_ERROR
      "CMAKE_OSX_ARCHITECTURES asks for a universal build (${CMAKE_OSX_ARCHITECTURES}), but "
      "dcmqi publishes one archive per architecture. Build a separate wheel for each.")
  endif()
  set(_dcmqi_arch "${CMAKE_OSX_ARCHITECTURES}")
elseif(CMAKE_GENERATOR_PLATFORM)
  set(_dcmqi_arch "${CMAKE_GENERATOR_PLATFORM}")
endif()

string(TOLOWER "${_dcmqi_arch}" _dcmqi_arch)
if(_dcmqi_arch MATCHES "^(x86_64|x64|amd64)$")
  set(_dcmqi_arch "x86_64")
elseif(_dcmqi_arch MATCHES "^(arm64|aarch64)$")
  set(_dcmqi_arch "arm64")
elseif(_dcmqi_arch MATCHES "^(win32|x86|i[3-6]86)$")
  set(_dcmqi_arch "x86")
endif()

if(APPLE)
  set(_dcmqi_platform "macos")
elseif(WIN32)
  set(_dcmqi_platform "win")
elseif(UNIX)
  set(_dcmqi_platform "linux")
else()
  message(FATAL_ERROR
    "dcmqi publishes no binary package for this operating system "
    "(CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME})")
endif()

# Asset variables are named <platform>_<arch>. The two assets whose upstream names predate
# architecture qualification get an alias: "linux" and "win64" both mean x86_64. See
# CPACK_SYSTEM_NAME in QIICR/dcmqi.
set(_dcmqi_candidates "${_dcmqi_platform}_${_dcmqi_arch}")
if(_dcmqi_platform STREQUAL "linux" AND _dcmqi_arch STREQUAL "x86_64")
  list(APPEND _dcmqi_candidates "linux")
elseif(_dcmqi_platform STREQUAL "win" AND _dcmqi_arch STREQUAL "x86_64")
  list(APPEND _dcmqi_candidates "win64")
elseif(_dcmqi_platform STREQUAL "macos")
  # Older releases shipped a single, unqualified macOS archive; the generator still emits
  # that name if upstream ever stops splitting by architecture.
  list(APPEND _dcmqi_candidates "macos")
endif()

set(archive "")
foreach(_dcmqi_candidate IN LISTS _dcmqi_candidates)
  if(DEFINED ${_dcmqi_candidate}_filename AND DEFINED ${_dcmqi_candidate}_sha256)
    set(archive "${_dcmqi_candidate}")
    break()
  endif()
endforeach()

if(NOT archive)
  string(REPLACE ";" ", " _dcmqi_tried "${_dcmqi_candidates}")
  message(FATAL_ERROR
    "dcmqi v${version} publishes no binary package for ${_dcmqi_platform}/${_dcmqi_arch}, so no "
    "wheel can be built for it. Looked for the asset variables: ${_dcmqi_tried}. "
    "Published assets: https://github.com/QIICR/dcmqi/releases/tag/v${version}")
endif()

set(dcmqi_archive_filename "${${archive}_filename}")
set(dcmqi_archive_sha256 "${${archive}_sha256}")
set(dcmqi_archive_url
  "https://github.com/QIICR/dcmqi/releases/download/v${version}/${dcmqi_archive_filename}")

message(STATUS
  "dcmqi archive for ${_dcmqi_platform}/${_dcmqi_arch}: ${dcmqi_archive_filename}")
