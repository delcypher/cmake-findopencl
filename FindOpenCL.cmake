# - Try to find OpenCL
# This module tries to find an OpenCL implementation on your system. It supports
# AMD / ATI, Apple and NVIDIA implementations, but shoudl work, too.
#
# Once done this will define
#  OPENCL_FOUND        - system has OpenCL
#  OPENCL_INCLUDE_DIRS  - the OpenCL include directory
#  OPENCL_LIBRARIES    - link these to use OpenCL
#
# WIN32 should work, but is untested

FIND_PACKAGE( PackageHandleStandardArgs )

SET (OPENCL_VERSION_STRING "0.1.0")
SET (OPENCL_VERSION_MAJOR 0)
SET (OPENCL_VERSION_MINOR 1)
SET (OPENCL_VERSION_PATCH 0)

IF (APPLE)

  FIND_LIBRARY(OPENCL_LIBRARIES OpenCL DOC "OpenCL lib for OSX")
  FIND_PATH(OPENCL_INCLUDE_DIRS OpenCL/cl.h DOC "Include for OpenCL on OSX")
  FIND_PATH(_OPENCL_CPP_INCLUDE_DIRS OpenCL/cl.hpp DOC "Include for OpenCL CPP bindings on OSX")

ELSE (APPLE)

	IF (WIN32)
	
	    FIND_PATH(OPENCL_INCLUDE_DIRS CL/cl.h)
	    FIND_PATH(_OPENCL_CPP_INCLUDE_DIRS CL/cl.hpp)
	
	    # TODO this is only a hack assuming the 64 bit library will
	    # not be found on 32 bit system
	    FIND_LIBRARY(OPENCL_LIBRARIES opencl64 )
	    IF( OPENCL_LIBRARIES )
	        FIND_LIBRARY(OPENCL_LIBRARIES opencl32 )
	    ENDIF( OPENCL_LIBRARIES )
	
	ELSE (WIN32)

            # Unix style platforms
            FIND_LIBRARY(OPENCL_LIBRARIES OpenCL
              ENV LD_LIBRARY_PATH
            )

            GET_FILENAME_COMPONENT(OPENCL_LIB_DIR ${OPENCL_LIBRARIES} PATH)
            GET_FILENAME_COMPONENT(_OPENCL_INC_CAND ${OPENCL_LIB_DIR}/../../include ABSOLUTE)

            # The AMD SDK currently does not place its headers
            # in /usr/include, therefore also search relative
            # to the library
            FIND_PATH(OPENCL_INCLUDE_DIRS CL/cl.h PATHS ${_OPENCL_INC_CAND})
            FIND_PATH(_OPENCL_CPP_INCLUDE_DIRS CL/cl.hpp PATHS ${_OPENCL_INC_CAND})

	ENDIF (WIN32)

ENDIF (APPLE)

FIND_PACKAGE_HANDLE_STANDARD_ARGS( OpenCL DEFAULT_MSG OPENCL_LIBRARIES OPENCL_INCLUDE_DIRS )

IF( _OPENCL_CPP_INCLUDE_DIRS )
	SET( OPENCL_HAS_CPP_BINDINGS TRUE )
	LIST( APPEND OPENCL_INCLUDE_DIRS ${_OPENCL_CPP_INCLUDE_DIRS} )
	# This is often the same, so clean up
	LIST( REMOVE_DUPLICATES OPENCL_INCLUDE_DIRS )
ENDIF( _OPENCL_CPP_INCLUDE_DIRS )

MARK_AS_ADVANCED(
  OPENCL_INCLUDE_DIRS
)

