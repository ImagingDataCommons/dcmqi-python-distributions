# Guided by the structure set-up by JC for the s5cmd python distributions project:
# https://github.com/ImagingDataCommons/s5cmd-python-distributions/blob/56b84d679e3a14421ca4884406e825117eee4232/CMakeLists.txt

cmake_minimum_required(VERSION 3.15...3.26)
project(${SKBUILD_PROJECT_NAME} LANGUAGES NONE)

# Set in the current scope the following variables:
# - dcmqi_archive_url
# - dcmqi_archive_sha256
include(${CMAKE_CURRENT_SOURCE_DIR}/dcmqiUrls.cmake)

#
# Download & extract archive
#
set(download_dir "${PROJECT_BINARY_DIR}")
set(extract_dir "${PROJECT_BINARY_DIR}/dcmqi-binary-distribution")
include(FetchContent)
FetchContent_Populate(dcmqi
  URL ${dcmqi_archive_url}
  URL_HASH SHA256=${dcmqi_archive_sha256}
  DOWNLOAD_DIR ${download_dir}
  SOURCE_DIR "${extract_dir}"
  )

#
# Install executable
#

set(_permissions PERMISSIONS
  OWNER_READ OWNER_WRITE OWNER_EXECUTE
  GROUP_READ GROUP_EXECUTE
  WORLD_READ WORLD_EXECUTE
  )

set(itkimage2segimage_executable_name "itkimage2segimage${CMAKE_EXECUTABLE_SUFFIX}")
set(segimage2itkimage_executable_name "segimage2itkimage${CMAKE_EXECUTABLE_SUFFIX}")
set(tid1500writer_executable_name "tid1500writer${CMAKE_EXECUTABLE_SUFFIX}")
set(tid1500reader_executable_name "tid1500reader${CMAKE_EXECUTABLE_SUFFIX}")
set(itkimage2paramap_executable_name "itkimage2paramap${CMAKE_EXECUTABLE_SUFFIX}")
set(paramap2itkimage_executable_name "paramap2itkimage${CMAKE_EXECUTABLE_SUFFIX}")

install(PROGRAMS ${extract_dir}/bin/${itkimage2segimage_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
install(PROGRAMS ${extract_dir}/bin/${segimage2itkimage_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
install(PROGRAMS ${extract_dir}/bin/${tid1500writer_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
install(PROGRAMS ${extract_dir}/bin/${tid1500reader_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
install(PROGRAMS ${extract_dir}/bin/${itkimage2paramap_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
install(PROGRAMS ${extract_dir}/bin/${paramap2itkimage_executable_name} DESTINATION "dcmqi/bin" ${_permissions})
