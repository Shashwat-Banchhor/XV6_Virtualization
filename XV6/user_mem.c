#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
    

    create_container(1);
    create_container(2);
    create_container(3);


    int pid = fork();
    if (pid==0){


        join_container(1);
        sleep(100);
        printf(1,"Before leave\n");

        ps();
        printf(1,"After leave\n");
        sleep(300);
        ps();



     

        exit();
        
    }
    // wait();
    //     exit();

    pid = fork();
    if (pid==0){


        join_container(2);
        memory_log_on();
        int * m = (int *)container_malloc(4);
        printf(1,"%s %d\n", "m is", *m);
        sleep(2000);
        memory_log_off();


        exit();
        
    }

    pid = fork();
    if (pid==0){


        join_container(1);
        
        sleep(200);
        leave_container();
        join_container(3);

        exit();
        
    }
   
   

    wait();
    wait();
    wait();
   
        // exec("cat",argv_c);



    printf(1,"Parent ps:\n");
    ps();

    // exec("ls",argv_c);

    destroy_container(1);
    destroy_container(2);
    destroy_container(3);

    
    // }
    
    // wait();
    // wait();
    // exec("ls",argv_c);

    // scheduler_log_off();

    exit();
}


