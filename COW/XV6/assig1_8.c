#include "types.h"
#include "stat.h"
#include "user.h"

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
	int cid = fork();
	
	// U N I C A S T ///
	
	if(cid==0){
		// This is child
		int psum2 = 0;
		for (int i = size/2; i < size; ++i)
		{
			psum2 += arr[i];
		}
		char *msg = (char *)malloc(MSGSIZE);
		int stat=-1;
		int  myid;
		int  from;
		while(stat==-1){
			stat = recv(&myid,&from,msg);
		}
		// printf(1,"\nMSG is %s\n",msg );
		// printf(1,"2 CHILD: msg recv is: %d \n", *((int*)msg) );
		int psum1 = *((int*)msg);

		tot_sum = psum2 + psum1;
		float mean = tot_sum / 1000.0;
		if (type==1){
			// printf(1,"Executing 0 \n");
			int mean_int = (int) mean; 
			send(getpid(),pid,(char *)(&mean_int));
			// printf(1,"Executing 1\n");	
			char *msg2 = (char *)malloc(MSGSIZE);

			int stat2 = -1;
			while(stat2==-1){
				stat2 = recv(&myid,&from,msg2);
			}
			// printf(1,"Executing 2\n");
			int  pvar1   = *((int*)msg2);

			float pvar2 = 0.0;
			for (int i = size/2; i < size; ++i)
			{
				pvar2 += (arr[i] - mean )*(arr[i] - mean);
			}
			// printf(1, "pvar 1 : %d  pvar 2 %d\n",(int)pvar1,(int)pvar2 );
			// printf(1,"Executing \n");
			variance = pvar2 + pvar1 ;
			variance = variance / 1000;
		}
	}else{
		// This is parent 
	
		


		int psum = 0;
		for (int i = 0; i < size/2; ++i)
		{
			psum += arr[i];
		}

		char *msg_child = (char *)malloc(MSGSIZE);
		// printf(1," F %d\n",psum );
		// char *s1 = (char *)malloc(MSGSIZE);
		// char *s2 = (char *)malloc(MSGSIZE);
		// msg_child = itoa(s1,s2,psum);
		// itoa(psum,msg_child,10);
		// *(msg_child +6) = '%';
		// *(msg_child +7) = 'c';
		// char * omsg_child = "2288";

		// for (int i = 0; i <= 7; ++i)
		// {
		// 	printf(1," %c,%c\n",*(msg_child+i),*(omsg_child+i) );
		// }
		// printf(1,"S %d\n",psum );
		// printf(1,"Output is %s and correct is %d\n",msg_child,psum );
		// printf(1,"PID %d\n", pid );
		send(getpid(),cid,(char *)(&psum));	
		// printf(1,"1 PARENT: msg sent is: %s \n", msg_child );

		// exit();
		
		if(type==1){	
			int  myid,from;
			char *msg2 = (char *)malloc(MSGSIZE);

				int stat2 = -1;
				while(stat2==-1){
					stat2 = recv(&myid,&from,msg2);
				}

			int mean =  *(int *) msg2;
			// printf(1,"In parent Mean is %d\n",mean );
				float pvar2 = 0.0;
				for (int i = size/2; i < size; ++i)
				{
					pvar2 += (arr[i] - mean )*(arr[i] - mean);
				}
			int pvar2_int = (int) pvar2;
			// printf(1," in parent pvar %d\n", pvar2_int );
			send(getpid(),cid,(char *)(&pvar2_int));	
		}

		wait();
		// printf(1,"My child has exited now I am exiting\n");
		free(msg_child);

	}







  	//------------------

  	if(type==0 && cid==0){ //unicast sum
		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
	}
	else{ //mulicast variance
		if (cid==0){	
			printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
		}
	}
	exit();
}
