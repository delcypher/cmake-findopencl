/**
 * Example application to show using OpenCL in combination with CMake
 *
 * Author: Matthias Bach <matthias.bach@kip.uni-heidelberg.de>
 */

#include <iostream>

#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif

using namespace std;

int main( int, char** )
{
	char chBuffer[ 256 ];

	// Get and log the platform info
	clGetPlatformInfo( 0, CL_PLATFORM_VERSION, sizeof(chBuffer), chBuffer, NULL);

	cout << chBuffer << endl;

	return 0;
}
