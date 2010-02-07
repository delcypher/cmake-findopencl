/**
 * Example application to show using OpenCL in combination with CMake
 *
 * Author: Matthias Bach <matthias.bach@kip.uni-heidelberg.de>
 */

#include <iostream>

#include <CL/cl.h>

using namespace std;

int main( int, char** )
{
	char chBuffer[ 256 ];

	// Get and log the platform info
	clGetPlatformInfo( (cl_platform_id) CL_PLATFORM_NVIDIA, CL_PLATFORM_VERSION, sizeof(chBuffer), chBuffer, NULL);

	cout << chBuffer << endl;

	return 0;
}
