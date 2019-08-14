
// #include "types.h"
// #include "stat.h"
// #include "user.h"

// char *argv_c[] = { "Child" };
// char *argv_p[] = { "Parent" };
// int
// main(void)
// {
//     int a = create_container(7);
//     // int * ap = &a;
//     // char * arg = (char *) ap;
//     printf(1,"%d and destroy it %d \n",a , 6 );

// 	int pid = fork();
//     if(pid==0){

//         // exec("container_manager", &arg);
//         printf(1,"%s\n","I am Child" );

//         printf(1,"My old CID is %d\n", getcid() );
//         join_container(7);
//         printf(1,"My new CID is %d\n", getcid() );

//         int fd = open("new_file",512);
//         close(fd);
//         // open("new_file",0);
               
//         // ls();
//         exec("ls",argv_c);
//     }
//             // ps();

//     // }else{

//     //     int b = join_container(7);
//     //     printf(1,"%d\n", b );

//     //     int  l = leave_container();
//     //     printf(1,"%s %d\n","left" , l );

//     //     int  d = destroy_container(7);
//     //     printf(1,"%s %d\n","Destroyed CID" , d );
//     //     sleep(5);
//     //     ps();

//     // 	// CONTINUE WITH THE PARENT
//     // }

//     wait();

//     exit();
// }





#include "types.h"
#include "stat.h"
#include "user.h"

// char *argv_p[] = {"ls"};

char *argv_c[] = {"cat","new_file_2"};

// char *argv_p[] = { "Child"};
int
main(void)
{
    // scheduler_log_on();
    int a = create_container(7);
        create_container(6);

        // open("abc",512);

    // int * ap = &a;
    // char * arg = (char *) ap;
    printf(1,"%d and destroy it %d \n",a , 6 );
    // int c = 100;
    // // char * s1   ="0";
    // // char * s2  = ''; 

    // char * s1 = "100";
    // int n = atoi(s1);
    // printf(1,"Integer is %d\n", n);
    // char * s = itoa(c);
    // printf(1,"Strign is %s \n",s );

    // exit();

    int pid = fork();
    if(pid==0){

        // exec("container_manager", &arg);
        printf(1,"%s\n","I am Child" );

        printf(1,"My old CID is %d\n", getcid() );
        join_container(7);
        printf(1,"My new CID is %d\n", getcid() );
        //CREATE
        // int fd = 
        // ps();
        printf(1,"%s\n","I am CONTAINERCHECK2" );
        // open("abc",512);
        // exit();
        open("new_file_2",512);

        //RDONLY
        int fd1 = open("new_file_2",2);
        // int fd2 = open("abc",2);
        write(fd1,"shashwat",8);

        close(fd1);
        // close(fd2); 
        printf(1,"%s\n","Just before exec" );
        // sleep(20000);
        

        // int fd2 = open("assig2a.inp",1);
        // write(fd2,"shashwat",8);
        // close(fd2);



        // exec("cat",argv_c);

        // ls();
        // printf("%s\n", );
        // exec("ls",argv_p);
        exit();
    }
        // exit();

    pid = fork();
    if (pid==0){

        // exec("container_manager", &arg);

        // printf(1,"%s\n","I am Child2 " );
        // printf(1,"%s\n","I am Parent  " );

        // printf(1,"My old CID is %d\n", getcid() );
        join_container(6);
        // printf(1,"My new CID is %d\n", getcid() );
        //CREATE
        // int fd = 
        open("new_file_2",512);
        open("new_file_4",512);


        int fd1 = open("new_file_2",2);

        write(fd1,"banchhor",8);
        close(fd1);
        // sleep(20000);
        // int fd2 = open("assig2a.inp",1);
        // write(fd2,"banchhor",8);
        // close(fd2);

        exec("ls",argv_p);
        // exec("ls",argv_p);

        exit();
        //RDONLY
        // open("new_file",0);
        // close(fd);       
        // ls();
        // exec("ls",argv_c);
    }
   


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

    wait();
    wait();
        // exec("cat",argv_c);

    // exec("ls",argv_p);
    
    // }
    
    // wait();
    // wait();
    // exec("ls",argv_c);

    // scheduler_log_off();

    exit();
}




