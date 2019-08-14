#include "types.h"
#include "user.h"
#include "date.h"
int
main(int argc, char *argv[])
{

	// create a new copy of the current memory state
	// name one as parent one as child 
	// return 0 in child and the child's pid in parent 
	int pid = fork();
	if(pid==0){
		
		printf(1,"I am the child\n");
		int pid2 = fork();
		if (pid2==0){
			printf(1,"The Pid inside fork , fork is %d\n",pid2 );

			// replace this memory with a new memory image; load this image from the file provided as the first argument 
			// two args prog. filename and array of string arguments
			exec("user_ps",argv);
			// If Exec is success it never returns 
			printf(1,"Exec_Error!!!!!!!!");
			return 0;
		}
		wait();
		
		printf(1,"Child's child has done\n");
		//exec("user_add",argv);

		return 0;
	}
	
	printf(1,"I am the parent and I am waiting \n");

	// returns the pid of any child of this process which returns child
	wait();
		
	printf(1,"Child's has done\n");
	printf(1,"I am the parent and I am exiting\n");

	
	//terminate the current process
	exit();
}