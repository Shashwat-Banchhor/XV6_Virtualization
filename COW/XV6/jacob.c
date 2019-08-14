#include "types.h"
#include "stat.h"
#include "user.h"




// #define N 11
// #define E 0.00001
// #define T 100.0
// #define P 4
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
	
	
/// READ THE FILE 

    if(argc< 1){
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[1];

	int NN=0, PP=0,TT=0,LL=0;
	float EE = 0.00001;
	// short arr[50];
	char c;
	int before_dot = 0;//, after_dot = 0;
	char * current  = (char *) malloc(20*sizeof(char));
	int k =0;
	int fd = open(filename, 0);
	int lct = 0;
	for(int i=0; i<50; i++){
		read(fd, &c, 1);
		if (c=='\n' ){
			// printf(1,"line" );
			lct += 1;

			current[k] = '\0';
			int n = atoi(current);
			// printf(1," n is %d\n", n );
			if (lct==1){
				NN = n ;
				// printf(1,"N is assigned : \n" ); 
			}
			if (lct==2){
				int p = 0;
				float after = 0.0 ;
				while(current[p]!= '\0' ){
					int den = 10;
					for (int i = 0; i < p; ++i)
					{
						den = den * 10;
					}
					after = after/10 + (((int) (current[p]-'0'))/(float) den);
					p+=1;
				}  
				// float bef = (float ) before_dot;
				EE = before_dot + after ;
				// printf(1,"E is assigned %d.%s\n" , before_dot , current ); 
			}
			if (lct==3){
				PP= n;
			}
			if (lct==4){
				TT = n;
			}
			if (lct == 5){
				LL = n;
				break;
			}
			k = 0;
			continue;
		}	

		if (c== '.'){
			current[k] = '\0';
			k = 0;
			before_dot = atoi(current);
			continue;

		}	
		// arr[i]=c-'0';
		// printf(1,"%c ",c );
		current[k] = c ; 
		k++;

		// read(fd, &c, 1);
	}	
  	close(fd);
  	// this is to supress warning
  	// printf(1,"%d , %d , %d , %d ,/ %d \n",NN,PP,TT,LL, (int) EE);

 //  	// exit();





  	int N  = NN ,L = LL, P  = PP, T=  TT;
  	float E = EE; 
  	if (N<P){
  		P = N;
  	}








	int CommunicationPipes[(P+1)][2];
    
    int DifferencePipes[P+1][2];
    int returnstatus;
    // printf(1," P is %d\n", P);
    // MAKE PIPES 
    for (int i = 0; i < P+1; ++i)
    {
      returnstatus = pipe(CommunicationPipes[i]);
      if (returnstatus == -1) {
        // printf(1,"Unable to create Communicator %d\n" ,i);
        return 1;
      }
      // returnstatus = pipe(CommunicationPipes[i+1]);
      // if (returnstatus == -1) {
      //   printf(1,"Unable to create Communicator %d \n" ,i);
      //   return 1;
      // }
      
      returnstatus = pipe(DifferencePipes[i]);
      if (returnstatus == -1) {
        printf(1,"Unable to create Communicator %d \n" ,i);
        return 1;
      }
      
    }






	float diff;
	int i,j;
	float mean;
	float u[N][N];
	float w[N][N];

	int count=0;
	mean = 0.0;
	for (i = 0; i < N; i++){
		u[i][0] = u[i][N-1] = u[0][i] = T;
		u[N-1][i] = 0.0;
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
	}
	mean /= (4.0 * N);

	// ADDED /////////////////

	// for(i =0; i <N; i++){
	// 	for(j = 0; j<N; j++)
	// 		printf(1,"%d ",((int)u[i][j]));
	// 	printf(1,"\n");
	// }
	// 	printf(1,"Mean %d \n",(int) mean);


	// END ///////////////////


	// INITIALIZE 
	// for (i = 1; i < N-1; i++ )
	// 	for ( j= 1; j < N-1; j++) u[i][j] = mean;

	float f = (float) P; 
	float sf = N/f;
	int share = (int) (sf + 0.999);

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
	        exit();
		}

	}
	
	for (int i = 0; i < P; ++i){wait();}

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

	// COMPUTE 
	// for(;;){
	// 	diff = 0.0;
	// 	for(i =1 ; i < N-1; i++){
	// 		for(j =1 ; j < N-1; j++){
	// 			w[i][j] = ( u[i-1][j] + u[i+1][j]+
	// 				    u[i][j-1] + u[i][j+1])/4.0;
	// 			if( fabsm(w[i][j] - u[i][j]) > diff )
	// 				diff = fabsm(w[i][j]- u[i][j]);	
	// 		}
	// 	}
	//     count++;
	       
	// 	if(diff<= E || count > L){ 
	// 		break;
	// 	}
	
	// 	for (i =1; i< N-1; i++)	
	// 		for (j =1; j< N-1; j++) u[i][j] = w[i][j];
	// }
	for(;;){
		
		diff = 0.0;
		for (int proc = 0 ; proc < P; proc++){
			// printf(1,"Proc %d\n",proc );
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

		        exit();
			}
		}

		for (int i = 0; i < P; ++i)
		{
			wait();
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
	         		// printf(1,"Proc %d : Diff Count : %d\n",proc,diff_count );
	         		// printf(1,"Proc %d : Diff Count : %d , count : %d\n",proc,diff_count,count );

	        }
	       

		}

	    count++;
	     

		if(diff_count==P){//(diff<= E || count > L){ 
			break;
		}
	
	}


	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
			printf(1,"%d ",((int)u[i][j]));
		printf(1,"\n");
	}
	exit();

}
