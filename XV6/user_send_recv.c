#include "types.h"
#include "stat.h"
#include "user.h"


#define PROCS 8
int
main(int argc, char *argv[])
{
	if(argc< 2){
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[2];
	int type = atoi(argv[1]);
	printf(1,"Type is %d and filename is %s\n",type, filename);

	int tot_sum = 0;	
	float variance = 0.0;

	int size=1000;
	short arr[size];
	char c;
	int fd = open(filename, 0);
	for(int i=0; i<size; i++){
		read(fd, &c, 1);
		arr[i]=c-'0';
		read(fd, &c, 1);
	}	
  	close(fd);
  	// this is to supress warning
  	printf(1,"first elem %d\n", arr[0]);
  
  	//----FILL THE CODE HERE for unicast sum and multicast variance

  	int pid = getpid();
	
	int cid;
	for (int i = 0; i < PROCS; ++i)
	{
		cid = fork();
		if(cid==0){
		// This is child
			int psum2 = 0;
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
			{
				psum2 += arr[j];
			}
			printf(1,"The pid of child is %d\n",getpid() );
			send(getpid(),pid,(char *)(&psum2));	

			exit();
		}
	}
	// U N I C A S T ///
	
	char *msg = (char *)malloc(MSGSIZE);
	int stat=-1;
	int  myid;
	int  from;
	for (int i = 0; i < PROCS; ++i)
	{
		while(stat==-1){
				stat = recv(&myid,&from,msg);
		}
		int psum = *(int *) msg;
		stat = -1;
		printf(1,"Sum recevied from %d is %d\n",from,psum );
		tot_sum += psum;
	}	
	
	int sum = 0;

	for (int i = 0; i < PROCS; ++i)
	{
			int ps = 0;
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
			{
				ps += arr[j];
			}
			sum += ps;
			printf(1, "Sum of i : %d is %d \n",i,ps );

	}	
	
	if(type==0 ){ //unicast sum
		printf(1,"Sum of array for file %s is %d and actual sum is %d\n", filename,tot_sum, sum);
	}
	else{ //mulicast variance
		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
	}
	exit();
}




// #include "types.h"
// #include "stat.h"
// #include "user.h"

// int
// main(int argc, char *argv[])
// {
// 	if(argc< 2){
// 		printf(1,"Need type and input filename\n");
// 		exit();
// 	}
// 	char *filename;
// 	filename=argv[2];
// 	int type = atoi(argv[1]);
// 	printf(1,"Type is %d and filename is %s\n",type, filename);

// 	int tot_sum = 0;	
// 	float variance = 0.0;

// 	int size=1000;
// 	short arr[size];
// 	char c;
// 	int fd = open(filename, 0);
// 	for(int i=0; i<size; i++){
// 		read(fd, &c, 1);
// 		arr[i]=c-'0';
// 		read(fd, &c, 1);
// 	}	
//   	close(fd);
//   	// this is to supress warning
//   	printf(1,"first elem %d\n", arr[0]);
  
//   	//----FILL THE CODE HERE for unicast sum and multicast variance

//   	// int pid = getpid();
// 	int cid = fork();
	
// 	// U N I C A S T ///
	
// 	if(cid==0){
// 		// This is child
// 		int psum2 = 0;
// 		for (int i = 2*size/3; i < size; ++i)
// 		{
// 			psum2 += arr[i];
// 		}
// 		char *msg = (char *)malloc(MSGSIZE);
// 		char *msg2 = (char *)malloc(MSGSIZE);

// 		int stat=-1;
// 		int  myid;
// 		int  from;
// 		while(stat==-1){
// 			stat = recv(&myid,&from,msg);
// 		}
// 		int stat2 = -1;
// 		while(stat2==-1){
// 			stat2 = recv(&myid,&from,msg2);
// 		}
// 		// printf(1,"\nMSG is %s\n",msg );
// 		// printf(1,"2 CHILD: msg recv is: %d \n", *((int*)msg) );
// 		int psum1 = *((int*)msg);
// 		int psum3 = *((int*)msg2);

// 		tot_sum = psum2 + psum1 + psum3;
// 		// printf(1," The total sum is  NOWWWWWWWWWWWWWWWW %d\n", tot_sum );
// 		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);

// 		exit();
// 	}else{
// 		// This is parent 
	
		


		

// 		char *msg_child = (char *)malloc(MSGSIZE);
// 		// printf(1," F %d\n",psum );
// 		int coordintor_proc = cid;

// 		cid = fork();

// 		if (cid==0){
// 			int psum = 0;

// 			for (int i = size/3; i < 2*size/3; ++i)
// 			{
// 				psum += arr[i];
// 			}
// 			send(getpid(),coordintor_proc,(char *)(&psum));	
// 			exit();
// 		}
// 		else{
// 			int psum = 0;

// 			for (int i = 0; i < size/3; ++i)
// 			{
// 				psum += arr[i];
// 			}
// 			send(getpid(),coordintor_proc,(char *)(&psum));	
// 			wait();
// 			wait();
// 			free(msg_child);

// 		}
		


// 	}







//   	//------------------

//   	if(type==0 && cid==0){ //unicast sum
// 		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
// 	}
// 	else{ //mulicast variance
// 		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
// 	}
// 	exit();
// }
















// #include "types.h"
// #include "stat.h"
// #include "user.h"

// int main(void)
// {
// 	printf(1,"%s\n","IPC Test case");
	
// 	// int pid = getpid();
// 	int cid = fork();
	
// 	// U N I C A S T ///
// 	if(cid==0){
// 		// This is child
// 		char *msg = (char *)malloc(MSGSIZE);
// 		int stat=-1;
// 		int  myid;
// 		int  from;
// 		while(stat==-1){
// 			stat = recv(&myid,&from,msg);
// 		}
// 		printf(1,"\nMSG is %d\n",*((int *)msg) );
// 		printf(1,"2 CHILD: msg recv is: %d \n", *((int *)msg) );

// 		exit();
// 	}else{
// 		// This is parent 
		

// 		char *msg_child = (char *)malloc(MSGSIZE);
// 		int n  = 2288;
// 		int * np = &n;
// 		msg_child = (char *) np;//"2288";
// 		int coordintor_proc = cid;
// 		// msg_child = "SHASH";
// 		send(getpid(),coordintor_proc,msg_child);	
// 		printf(1,"1 PARENT: msg sent is: %s \n", msg_child );
		
// 		wait();
// 		printf(1,"My child has exited now I am exiting\n");
// 		free(msg_child);
// 		exit();

// 	}
// 	// printf(1,"Parent pid %d\n",pid );

// 	// // M U L T I C A S T ///
// 	// if(cid==0){
// 	// 	// This is child
// 	// 	printf(1,"I am child my pisd is : %d\n", getpid());
// 	// 	char *msg_child = (char *)malloc(MSGSIZE);
// 	// 	msg_child = "RAM";
// 	// 	send(getpid(),pid,msg_child);	
// 	// 	printf(1,"1 CHILD: msg sent is: %s to %d \n", msg_child,pid );
		
// 	// 	// wait();
// 	// 	// printf(1,"I am child and  1 I am exiting\n");
// 	// 	free(msg_child);
// 	// 	exit();
// 	// }else{
// 	// 	// This is parent
// 	// 	// int cid2;
// 	// 	// cid2 = fork(); 
// 	// 	// if(cid2==0){
// 	// 	// 	char *msg_child = (char *)malloc(MSGSIZE);
// 	// 	// 	msg_child = "CHANDRA";
// 	// 	// 	send(getpid(),pid,msg_child);	
// 	// 	// 	printf(1,"2 CHILD: msg sent is: %s to %d \n", msg_child,pid );
			
// 	// 	// 	// wait();
// 	// 	// 	// printf(1,"I am child and  2 I am exiting\n");
// 	// 	// 	free(msg_child);
// 	// 	// 	exit();
// 	// 	// }

// 	// 	// else{
// 	// 		char *msg1 = (char *)malloc(MSGSIZE);
// 	// 		char *msg2 = (char *)malloc(MSGSIZE);
// 	// 		int stat1=-1;
// 	// 		wait();
// 	// 		wait();
// 	// 		printf(1,"I am parent my pid  is %d\n",pid );
// 	// 		while(stat1==-1){
// 	// 			stat1 = recv(msg1);
// 	// 		}
// 	// 		int stat2=-1;
// 	// 		while(stat2==-1){
// 	// 			stat2 = recv(msg2);
// 	// 		}
// 	// 		printf(1,"2 PARENT: msg recv are : %s and %s \n", msg1,msg2 );
// 	// 	// }
// 	// }
// 	 exit();
// }
