

#include "types.h"
#include "stat.h"
#include "user.h"

// char *argv_p[] = {"ls"};

char *argv_c[] = {"ls"};

// char *argv_p[] = { "Child"};
int
main(void)
{
    

    create_container(1);
    create_container(2);
    create_container(3);


    int pid = fork();
    if(pid==0){

        // exec("container_manager", &arg);
        printf(1,"%s\n","I am Child" );

        printf(1,"My old CID is %d\n", getcid() );
        join_container(1);
        printf(1,"My new CID is %d\n", getcid() );
        


        //CREATE
        // int fd = 
        // ps();
        
       open("file_10",512);



        // open("abc",512);
        // exit();
       open("new_file_2",512);
   
        int fd1 = open("new_file_2",2);
        // int fd2 = open("abc",2);
        write(fd1,"Mohit",5);

        close(fd1);
        // close(fd2); 
        printf(1,"%s\n","Just before exec" );
        

        int fd2 = open("assig2a.inp",1);
        write(fd2,"Gupta",5);
        // close(fd2);

        // // fd2 = open("assig2a.inp",1);
        write(fd2,"pqrstuOP",8);
        close(fd2);
        sleep(100);
        ps();
        sleep(100);




        exec("ls",argv_c);

     
        exit();
    }
    // wait();
    //     exit();

    pid = fork();
    if (pid==0){


        join_container(2);
        //CREATE
        // int fd = 
       open("file_11",512);


        open("new_file_2",512);
        open("new_file_4",512);


        int fd1 = open("new_file_2",2);

        write(fd1,"Shashwat",8);
        close(fd1);
        // sleep(20000);
        int fd2 = open("assig2a.inp",1);
        write(fd2,"Banchhor",8);
        // close(fd2);
         // fd2 = open("assig2a.inp",1);
        write(fd2,"abcdef",6);
        close(fd2);
      

        sleep(1000);


        exec("ls",argv_c);
        // exec("ls",argv_p);

        exit();
        
    }

    pid = fork();
    if (pid==0){


        join_container(3);
        //CREATE
        // int fd = 

       open("file_12",512);


        open("new_file_2",512);
        open("new_file_4",512);


        int fd1 = open("new_file_2",2);

        write(fd1,"Operating",9);
        close(fd1);
        // sleep(20000);
        int fd2 = open("assig2a.inp",1);
        write(fd2,"Systems01",9);
        // close(fd2);
         // fd2 = open("assig2a.inp",1);
        write(fd2,"abcdef",6);
        close(fd2);
      

        sleep(2000);


        exec("ls",argv_c);
        // exec("ls",argv_p);

        exit();
        
    }
   
    pid = fork();
    if (pid==0){


        join_container(1);
        //CREATE
        // int fd = 
       open("file_13",512);



        // exec("ls",argv_c);
        // exec("ls",argv_p);
       sleep(2000);

        exit();
        
    }

    pid = fork();
    if (pid==0){


        join_container(1);
       
       open("file_14",512);


        // exec("ls",argv_c);
       sleep(2000);
        exit();
        
    }

   

    wait();
    wait();
    wait();
    wait();
    wait();
        // exec("cat",argv_c);



    
    ps();

    exec("ls",argv_c);

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




















































// #include "types.h"
// #include "stat.h"
// #include "user.h"

// // char *argv_p[] = {"ls"};

// char *argv_c[] = {};

// // char *argv_p[] = { "Child"};
// int
// main(void)
// {
//     // CALL KAR
//     create_container(8);
//     create_container(7);
//     create_container(6);
    
//     int pid = fork();
//     if(pid==0){

//         // exec("container_manager", &arg);
//         printf(1,"%s\n","I am Child1" );

//         printf(1,"My old CID is %d\n", getcid() );
//         join_container(7);
//         printf(1,"My new CID is %d .. I have joined container 7\n", getcid() );
    
        
//         int fd0 = open("new_file_2",512);
//         close(fd0);
//         int fd1 = open("new_file_2",2);
//         write(fd1,"shashwat",8);
//         close(fd1);
       

//         int fd2 = open("assig2a.inp",1);
//         write(fd2,"Shashwat",8);
//         write(fd2,"\nMohit\n\n",8);
//         close(fd2);


//         printf(1,"%s\n","This is CAT of child 1.." );
//         printf(1,"%s\n","______________________________________________" );

//         exec("ls",argv_c);

//         exit();
//     }
   
//     pid = fork();
//     if (pid==0){
//         printf(1,"%s\n","I am Child2 " );
        
//         join_container(6);
        
//         open("new_file_2",512);
//         open("new_file_4",512);
//         // MOBILE SWITCH OFFF HO GAYA !!!! RUK 

//         int fd1 = open("new_file_2",2);

//         write(fd1,"Banchhor\n",9);
//         close(fd1);
//         // sleep(20000);


//         int fd2 = open("assig2a.inp",1);
//         write(fd2,"Banchhor",8);
//         // close(fd2);
//         sleep(400);
//          // fd2 = open("assig2a.inp",1);
//         write(fd2,"\nGupta",6);
//         close(fd2);
//         // sleep(1000);
//         // memory_log_on();

//         // int *m = (int *)container_malloc(4);
//         // *m = 9;
        
//         // printf(1,"%d\n",*m );
//         // memory_log_off();


//          printf(1,"%s\n","This is CAT of child 2.." );
//         printf(1,"%s\n","______________________________________________" );
//         exec("ls",argv_c);
//         // exec("ls",argv_p);

//         exit();
//         //RDONLY
//         // open("new_file",0);
//         // close(fd);       
//         // ls();
//         // exec("ls",argv_c);
//     }
   
//     // int pid = fork();
//     // if(pid==0){

//     //     // exec("container_manager", &arg);
//     //     printf(1,"%s\n","I am Child3" );

//     //     printf(1,"My old CID is %d\n", getcid() );
//     //     join_container(7);
//     //     printf(1,"My new CID is %d\n", getcid() );
//     //     //CREATE
//     //     // int fd = 
//     //     // ps();
//     //     printf(1,"%s\n","I am CONTAINERCHECK2" );
//     //     // open("abc",512);
//     //     // exit();
//     //     open("new_file_2",512);

//     //     //RDONLY
//     //     int fd1 = open("new_file_2",2);
//     //     // int fd2 = open("abc",2);
//     //     write(fd1,"shashwat",8);

//     //     close(fd1);
//     //     // close(fd2); 
//     //     printf(1,"%s\n","Just before exec" );
//     //     // sleep(20000);
        

//     //     int fd2 = open("assig2a.inp",1);
//     //     write(fd2,"shashwat",8);
//     //     // close(fd2);

//     //     // fd2 = open("assig2a.inp",1);
//     //     write(fd2,"pqrstuOP",8);
//     //     close(fd2);


//     //     memory_log_on();

//     //     int *m = (int *)container_malloc(4);
//     //     char *y = (char *)container_malloc(3);

//     //     *m = 7;
//     //     *y = 's';

//     //     printf(1,"%d %c\n",*m, *y);
//     //     // memory_log_off();




//     //     exec("ls",argv_c);

//     //     // ls();
//     //     // printf("%s\n", );
//     //     // exec("ls",argv_p);
//     //     exit();
//     // }
   
//     // pid = fork();
//     // if (pid==0){

//     //     // exec("container_manager", &arg);

//     //     printf(1,"%s\n","I am Child4 " );
//     //     // printf(1,"%s\n","I am Parent  " );

//     //     // printf(1,"My old CID is %d\n", getcid() );
//     //     join_container(6);
//     //     // printf(1,"My new CID is %d\n", getcid() );
//     //     //CREATE
//     //     // int fd = 
//     //     open("new_file_2",512);
//     //     open("new_file_4",512);


//     //     int fd1 = open("new_file_2",2);

//     //     write(fd1,"banchhor7",9);
//     //     close(fd1);
//     //     // sleep(20000);
//     //     int fd2 = open("assig2a.inp",1);
//     //     write(fd2,"banchhor",8);
//     //     // close(fd2);
//     //     sleep(200);
//     //      // fd2 = open("assig2a.inp",1);
//     //     write(fd2,"abcdef",6);
//     //     close(fd2);
//     //     // sleep(1000);
//     //     memory_log_on();

//     //     int *m = (int *)container_malloc(4);
//     //     *m = 9;
        
//     //     printf(1,"%d\n",*m );
//     //     memory_log_off();



//     //     exec("ls",argv_c);
//     //     // exec("ls",argv_p);

//     //     exit();
//     //     //RDONLY
//     //     // open("new_file",0);
//     //     // close(fd);       
//     //     // ls();
//     //     // exec("ls",argv_c);
//     // }

//     // pid = fork();
//     // if (pid==0){

//     //     // exec("container_manager", &arg);

//     //     printf(1,"%s\n","I am Child5 " );
//     //     // printf(1,"%s\n","I am Parent  " );

//     //     // printf(1,"My old CID is %d\n", getcid() );
//     //     join_container(6);
//     //     // printf(1,"My new CID is %d\n", getcid() );
//     //     //CREATE
//     //     // int fd = 
//     //     open("new_file_2",512);
//     //     open("new_file_4",512);


//     //     int fd1 = open("new_file_2",2);

//     //     write(fd1,"banchhor7",9);
//     //     close(fd1);
//     //     // sleep(20000);
//     //     int fd2 = open("assig2a.inp",1);
//     //     write(fd2,"banchhor",8);
//     //     // close(fd2);
//     //     sleep(200);
//     //      // fd2 = open("assig2a.inp",1);
//     //     write(fd2,"abcdef",6);
//     //     close(fd2);
//     //     // sleep(1000);
//     //     memory_log_on();

//     //     int *m = (int *)container_malloc(4);
//     //     *m = 9;
        
//     //     printf(1,"%d\n",*m );
//     //     memory_log_off();



//     //     exec("ls",argv_c);
   

//     //     exit();
     
//     // }

            

//     wait();
//     wait();
//     wait();
//     wait();
//     wait();
        
//     exit();
// }




