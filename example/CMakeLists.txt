# This is an example project to show and test the usage of the FindOpenCL
# script.

cmake_minimum_required( VERSION 2.6 )
project( Example )

# This is only required for the script to work in the version control
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/..")

find_package( OpenCL REQUIRED )

include_directories( ${OPENCL_INCLUDE_DIR} )

add_executable( example example.cpp )
target_link_libraries( example ${OPENCL_LIBRARIES} )
