#include "types.h"
#include "stat.h"
#include "user.h"

int 
main(int argc, char **argv)
{
    
	// create a data structure to manage container services
	// local to this instance of the container manager
	printf(1,"%s %d\n","container id recv", *(int *)argv[0] );
	sleep(10);

    exit();
}


