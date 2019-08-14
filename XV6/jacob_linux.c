// #include "types.h"
// #include "stat.h"
// #include "user.h"
#include<stdio.h>
#include<unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <ctime>
#include <iostream>
#include <stdio.h>


// #define N 20
// #define E 0.00001
// #define T 100.0
// #define P 8
// #define L 20000

float fabsm(float a){
	if(a<0)
	return -1*a;
return a;
}

// Utility
int max(int a,int b){
    return a>b?a:b;
}

int min(int a,int b){
    return a>b?b:a;
}




int main(int argc, char *argv[])
{	
	int N , P,T,L;
	float E ; 
	

	FILE *fin = fopen(argv[1], "r");

	fscanf(fin, "%d", &N);
	fscanf(fin, "%f", &E);
	fscanf(fin, "%d", &P);

	fscanf(fin, "%d", &T);

	fscanf(fin, "%d", &L);

	
	// fclose(fin);















	int CommunicationPipes[(P+1)][2];
    int barrierToCoOrdinatorPipes[P+1][2];
    int barrierFromCoOrdinatorPipes[P+1][2];
    int answers[2*P+1][2];
    int DifferencePipes[P+1][2];
    int returnstatus;

    // MAKE PIPES 
    for (int i = 0; i < P+1; ++i)
    {
      returnstatus = pipe(CommunicationPipes[2*i]);
      if (returnstatus == -1) {
        printf("Unable to create Communicator\n");
        return 1;
      }
      returnstatus = pipe(CommunicationPipes[2*i+1]);
      if (returnstatus == -1) {
        printf("Unable to create Communicator \n");
        return 1;
      }
      
      returnstatus = pipe(DifferencePipes[i]);
      if (returnstatus == -1) {
        printf("Unable to create Communicator \n");
        return 1;
      }
      returnstatus = pipe(barrierToCoOrdinatorPipes[i]);
      if (returnstatus == -1) {
        printf("Unable to create Barrier to Co-ord \n");
        return 1;
      } 
      returnstatus = pipe(barrierFromCoOrdinatorPipes[i]);
      if (returnstatus == -1) {
        printf("Unable to create Barrier from Co-Ords \n");
        return 1;
      }  
    }




    clock_t curr_t , end_t;
    curr_t = clock();
	float diff;
	int i,j;
	float mean;
	float u[N][N];
	float w[N][N];

	int count=0;
	
	// Done by Co-ordinator
	mean = 0.0;
	for (i = 0; i < N; i++){
		u[i][0] = u[i][N-1] = u[0][i] = T;
		u[N-1][i] = 0.0;
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
	}
	mean /= (4.0 * N);
	

    int share = int(N/float(P) + 0.999);

	for (int proc = 0 ; proc < P; proc++){
		
		int pid = fork();
		if (pid==0){
			
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
	        {
	            for (int j = 0; j < N; ++j)
	            {
	                if (i>0 && j>0 && i < N-1 && j< N-1){
	                    u[i][j] = mean;
	                }
	            }
	        }
	        
	        char * send_msg;
	        send_msg = (char *) u[proc*share];
	        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
	        exit(0);
		}

	}
	
	for (int proc = 0 ; proc < P; proc++){
		char * rd_msg[140];
		read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
		float  * arr = (float *)rd_msg;
		for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
        {
            for (int j = 0; j < N; ++j)
            {
                // if (i>0 && j>0 && i < N-1 && j< N-1){	
                	u[i][j] = arr[(i-proc*share)*N+j];
                // }
                
            }
        }
	}


	// exit(0)	;	
	for(;;){
		
		diff = 0.0;
		for (int proc = 0 ; proc < P; proc++){
			
			int pid = fork();
			if (pid==0){
			
				for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
		        {
		            for (int j = 0; j < N; ++j)
		            {
		                if (i>0 && j>0 && i < N-1 && j< N-1){
	                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
		                        u[i][j-1] + u[i][j+1])/4.0;
			                if( fabsm(w[i][j] - u[i][j]) > diff )
			                    diff = fabsm(w[i][j]- u[i][j]);
	                    }
		            }
		        }
		        
		        char * send_msg;

		        send_msg = (char *) w[proc*share];
		        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
		        send_msg =(char *) (&diff);
		        write(DifferencePipes[proc][1],send_msg, sizeof(float));

		        exit(0);
			}
		}

		int diff_count = 0;
	    // Parent Does Co-Ordination
		for (int proc = 0 ; proc < P; proc++){
			char * rd_msg[140];
			read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
			float  * arr = (float *)rd_msg;
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
	        {
	            for (int j = 0; j < N; ++j)
	            {
	                if (i>0 && j>0 && i < N-1 && j< N-1){	
	                	u[i][j] = arr[(i-proc*share)*N+j];
	                }
	                
	            }
	        }

	        read(DifferencePipes[proc][0],rd_msg,sizeof(float));
			float  * darr = (float *)rd_msg;
			if (darr[0] <= E || count >L){
	         		diff_count ++;
	         		// printf("Proc %d : Diff Count : %d , count : %d\n",proc,diff_count,count );
	        }
	       

		}

	    count++;
	     

		if(diff_count==P){//(diff<= E || count > L){ 
			break;
		}
	
		
	}

	// time(&end_t);
	end_t = clock();
	double computation =((double)(end_t - curr_t))/CLOCKS_PER_SEC;
	//std::cout<<"Time Taken : " << computation << "\n";
	

	// Print the answer
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
			printf("%d ",((int)u[i][j]));
		printf("\n");
	}
	exit(0);

}
