#include "types.h"
#include "stat.h"
#include "user.h"

char *argv_c[] = {"cat","new_file_2"};
// char *argv_p[] = { "Child"};
int
main(void)
{
    // int a = create_container(7);
    // printf(1,"%d and destroy it %d \n",a , 6 );
   	int b = getcid();
   	printf(1,"My cid is %d\n",b );
   	exit();
   	
    int pid = fork();
    if(pid==0){

        // exec("container_manager", &arg);
        printf(1,"%s\n","I am Child1" );

        // printf(1,"My old CID is %d\n", getcid() );
        join_container(7);
        // printf(1,"My new CID is %d\n", getcid() );
       
        // ps();
        // printf(1,"%s\n","I am CONTAINERCHECK2" );
   
        // open("new_file_2",512);

        // //RDONLY
        // int fd1 = open("new_file_2",2);
        // // int fd2 = open("abc",2);
        // write(fd1,"shashwat",8);

        // close(fd1);
        // // close(fd2);       
        // exec("cat",argv_c);

        // // ls();
        // // printf("%s\n", );
        // // exec("ls",argv_c);
        sz_ctable();

        while(1){
        	;// int a =  7	;
        }
        exit();
    }
        // exit();

    pid = fork();
    if (pid==0){

        

        printf(1,"%s\n","I am Child2 " );
        

        create_container(6);
        join_container(6);
        sz_ctable();
        while(1){
        	;// p_ctable();
        }
        exit();
        
    }
	else{

 

    //  // CONTINUE WITH THE PARENT
	    

		// p_ctable();
	    wait();
	    wait();
    


    exit();
}
}




