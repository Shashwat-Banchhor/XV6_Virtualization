
#include "types.h"
#include "stat.h"
#include "user.h"

char *argv_c[] = { "Child" };
char *argv_p[] = { "Parent" };
int
main(void)
{
    int a = create_container(7);
    // int * ap = &a;
    // char * arg = (char *) ap;
    printf(1,"%d and destroy it %d \n",a , 6 );

	int pid = fork();
    if(pid==0){

        // exec("container_manager", &arg);
        printf(1,"%s\n","I am Child" );

        printf(1,"My old CID is %d\n", getcid() );
        join_container(7);
        printf(1,"My new CID is %d\n", getcid() );
        //CREATE
        // int fd = 
        printf(1,"%s\n","I am CONTAINERCHECK2" );
        // open("abc",512);
        // open("new_file_2",512);

        //RDONLY
        // open("new_file",0);
        // close(fd);       
        // ls();
        // printf("%s\n", );
        // exec("ls",argv_c);
        // exit();
    }
    else{

        // exec("container_manager", &arg);

        // printf(1,"%s\n","I am Child2 " );
        printf(1,"%s\n","I am Parent  " );

        create_container(6);
        printf(1,"My old CID is %d\n", getcid() );
        join_container(6);
        printf(1,"My new CID is %d\n", getcid() );
        //CREATE
        // int fd = 
        open("new_file_3",512);
        open("new_file_4",512);
        // exit();
        //RDONLY
        // open("new_file",0);
        // close(fd);       
        // ls();
        // exec("ls",argv_c);
    // }



            // ps();

    // }else{

    //     int b = join_container(7);
    //     printf(1,"%d\n", b );

    //     int  l = leave_container();
    //     printf(1,"%s %d\n","left" , l );

    //     int  d = destroy_container(7);
    //     printf(1,"%s %d\n","Destroyed CID" , d );
    //     sleep(5);
    //     ps();

    // 	// CONTINUE WITH THE PARENT
         wait();
    // wait();
    // exec("ls",argv_c);
    
    }

    wait();
    // wait();
    // exec("ls",argv_c);


    exit();
}




