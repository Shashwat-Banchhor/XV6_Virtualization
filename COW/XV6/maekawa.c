#include "types.h"
#include "stat.h"
#include "user.h"

// #include <omp.h>

// using namespace std;


 // 1 -> request
 // 2 -> grant
 // 3 -> fail
 // 4 -> inquire
 // 5 -> yield
 // 6 -> not yield
 // 7 -> release

struct msg{
	int msg_type;
	int i;
	int j;
	int ts;
};



int
main(int argc, char *argv[])
{
	// ifstream infile;
	// infile.open("assig2b.inp");
	int num_P,num_P1,num_P2,num_P3;
	create_container(7);
	create_container(6);

	// infile >>num_P;
	// infile >>num_P1;
	// infile >>num_P2;
	// infile >>num_P3;
	// struct timeval  tv1, tv2;
	// gettimeofday(&tv1, NULL);
	// scheduler_log_on();
	char *filename; 
	char c;
	filename = "assig2a.inp";
	int fd = open(filename, 0);
	// printf(1,"123 %d \n",(fd));

	read(fd, &c, 1);
	// printf(1,"%d \n",((c)));

	num_P = 0;
	while((c-0)!=10){
		num_P = num_P*10 + (c - '0');
		read(fd, &c, 1);
	}

	read(fd, &c, 1);
	// printf(1,"%d \n",((c)));

	num_P1 = 0;
	while((c-0)!=10){
		num_P1 = num_P1*10 + (c - '0');
		read(fd, &c, 1);
	}

	read(fd, &c, 1);
	// printf(1,"%d \n",((c)));

	num_P2 = 0;
	while((c-0)!=10){
		num_P2 = num_P2*10 + (c - '0');
		read(fd, &c, 1);
	}

	read(fd, &c, 1);
	// printf(1,"%d \n",((c)));

	num_P3 = 0;
	int r;
	while((c-0)!=10){
		num_P3 = num_P3*10 + (c - '0');
		r = read(fd, &c, 1);
		// printf(1,"%d \n",((r)));		
		if(r == 0){
			break;
		}
	}
  	close(fd);

	int N = 0;
	if(num_P == 4){
		N=2;
	}
	else if(num_P == 9){
		N = 3;
	}
	else if(num_P == 16){
		N = 4;
	}
	else if(num_P == 25){
		N = 5;
	}
	else{
		printf(1,"Wrong Input\n");
		exit();
	}
	// printf(1,"%d \n",(N));

	int p[N][N][2];

	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++){
			if(pipe(p[i][j])<0){
				printf(1,"Pipe Not created\n");
				return(0);
			}
		}
	}
	struct msg mqueue[2*N -1];
	int size = 0;
	int x,y;
	x = -1;
	y = -1;
	int cid;
	// printf("%d\n",N);
	int wp,wb;
	int br =0;
	// int stored_pid[N][N];
	for(wp=0;wp<N;wp++){
		for(wb=0;wb<N;wb++){
			// printf("in%d\n",N);
			cid = fork();
			if(cid == 0){
				if (wp%2==0){
					join_container(6);
				}
				else{
					join_container(7);

				}
				x = wp;
				y = wb;
				br = 1;
				break;
			}
			// stored_pid[wp][wb] = cid;
		}
		if(br == 1)
			break;
	}
	if(x!=-1){
		int uid = N*x + y;
		// printf("%d\n",uid);
		if(uid < num_P1){
			if(num_P == num_P1){
				exit();
			}
			int new_ts = N*x + y;

			struct msg request_lock;
			request_lock.i = x;
			request_lock.j = y;
			request_lock.msg_type = 1;
			request_lock.ts = new_ts;

			struct msg recv_msg;
			int grant_send = 0;
			int grant_x,grant_y;
			int grant_ts;
			grant_ts = -1;
			grant_y = -1;
			grant_x = -1;

			// struct Proc_node* head;
			struct msg send_msg;
			send_msg.i = x;
			send_msg.j = y;
			send_msg.ts = new_ts;

			int acq_lock[N][N];
			int grant_lock[N][N];
			int fail[N][N];
			for(int l=0;l<N;l++){
				for(int m=0;m<N;m++){
					if((N*l + m) < num_P1){
						acq_lock[l][m] = 1;
					}else{
						acq_lock[l][m] = 0;
					}
					grant_lock[l][m] = 0;
					fail[N][N] = 0;
				}
			}
			int entered_cs = 1;
			int count_fail = 0;

			int my_break = 1;
			for(int l =0;l<N;l++){
				// if(l!=y){
					if(acq_lock[x][l] == 0){
						my_break = 0;
					}
				// }
			}

			for(int l =0;l<N;l++){
				// if(l!=x){
					if(acq_lock[l][y] == 0){
						my_break = 0;
					}
				// }
			}
			if(my_break == 1){
				// printf("%d %d broke\n",x,y);
				exit();
			}

			while(1){
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
				// printf("%d %d recv %d %d type %d\n",x,y,recv_msg.i,recv_msg.j,recv_msg.msg_type);
				if(recv_msg.msg_type == 1){
					if(grant_send == 0){
						grant_send = 1;
						grant_x = recv_msg.i;
						grant_y = recv_msg.j;
						grant_ts = recv_msg.ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
					}
					else{

						if(recv_msg.ts > grant_ts){
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
							}
							send_msg.msg_type = 3;
							// send_msg.ts = clock();							
							write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));

						}
						else{
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
								send_msg.msg_type = 4;
								// send_msg.ts = clock();							
								write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
								
								if(ind == 0){
									send_msg.msg_type = 4;
									// send_msg.ts = clock();							
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
								}
								else{
									send_msg.msg_type = 3;
									// send_msg.ts = clock();							
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
								}
							}
						}
					}

				}
				else if(recv_msg.msg_type == 4){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(fail[x][l] == 1){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(fail[l][y] == 1){
								flag = 0;
							}
						// }
					}
					if((flag == 0) && (entered_cs == 0)){
						grant_lock[recv_msg.i][recv_msg.j] = 0;
						send_msg.msg_type = 5;
						// send_msg.ts = clock();							
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
					}
				}
				else if(recv_msg.msg_type == 5){
					int prev_ts = grant_ts;
					int prev_x = grant_x;
					int prev_y = grant_y;
					if(size == 0){
						// printf("Error\n");
					}

					grant_x = mqueue[0].i;
					grant_y = mqueue[0].j;
					grant_ts = mqueue[0].ts;

					for(int l =0;l<(size - 1);l++){
							mqueue[l].msg_type = mqueue[l+1].msg_type;
							mqueue[l].i = mqueue[l+1].i;
							mqueue[l].j = mqueue[l+1].j;
							mqueue[l].ts = mqueue[l+1].ts;
					}

					size--;

					int ind = -1;
					for(int l =0;l<size;l++){
						if(mqueue[l].ts > prev_ts){
							ind = l;
							break;
						}
					}
					if(ind == -1){
						mqueue[size].msg_type = 1;
						mqueue[size].i = prev_x;
						mqueue[size].j = prev_y;
						mqueue[size].ts = prev_ts;
						size++;								
					}
					else{
						for(int l=size;l>ind;l--){
							mqueue[l].msg_type = mqueue[l-1].msg_type;
							mqueue[l].i = mqueue[l-1].i;
							mqueue[l].j = mqueue[l-1].j;
							mqueue[l].ts = mqueue[l-1].ts;
						}
						mqueue[ind].msg_type = 1;
						mqueue[ind].i = prev_x;
						mqueue[ind].j = prev_y;
						mqueue[ind].ts = prev_ts;
						size++;
					}
					send_msg.msg_type = 2;
					// send_msg.ts = clock();

					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

				}
				else if(recv_msg.msg_type == 7){
					acq_lock[recv_msg.i][recv_msg.j] = 1;
					if(size <= 0){
						// printf("\nRelease Error\n");
						grant_send = 0;
					}
					else{
						grant_x = mqueue[0].i;
						grant_y = mqueue[0].j;
						grant_ts = mqueue[0].ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

						for(int l =0;l<(size-1);l++){
								mqueue[l].msg_type = mqueue[l+1].msg_type;
								mqueue[l].i = mqueue[l+1].i;
								mqueue[l].j = mqueue[l+1].j;
								mqueue[l].ts = mqueue[l+1].ts;
						}
						size--;
					}

				}
				else if(recv_msg.msg_type == 2){
					grant_lock[recv_msg.i][recv_msg.j] = 1;
					fail[recv_msg.i][recv_msg.j] = 0;
				}
				else if(recv_msg.msg_type == 3){
					fail[recv_msg.i][recv_msg.j] = 1;
					grant_lock[recv_msg.i][recv_msg.j] = 0;
					count_fail++;
				}
				int my_break = 1;
				for(int l =0;l<N;l++){
					// if(l!=y){
						if(acq_lock[x][l] == 0){
							my_break = 0;
						}
					// }
				}

				for(int l =0;l<N;l++){
					// if(l!=x){
						if(acq_lock[l][y] == 0){
							my_break = 0;
						}
					// }
				}
				if(my_break == 1){
					exit();
					break;
				}

				if(entered_cs == 0){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(grant_lock[x][l] == 0){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(grant_lock[l][y] == 0){
								flag = 0;
							}
						// }
					}
					if(flag == 1){
						entered_cs = 1;
						// gettimeofday(&tv2, NULL);
						// printf(1,"%d acquired the lock at time %f.\n",getpid(),(double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
      //    (double) (tv2.tv_sec - tv1.tv_sec));
						// sleep(2);
						// gettimeofday(&tv2, NULL);
						// printf(1,"%d released the lock at time %f.\n",getpid(),(double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
      //    (double) (tv2.tv_sec - tv1.tv_sec));
						request_lock.i = x;
						request_lock.j = y;
						request_lock.msg_type = 7;
						// request_lock.ts = clock();

						for(int j=0;j<N;j++){
							// if(j!= y){
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
							// }
						}

						for(int i=0;i<N;i++){
							if(i!= x){
								write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
							}
						}
					}
				}
			}
		}
		else if(uid < (num_P1 + num_P2)){
		// printf("Inside P2\n");
			int new_ts = N*x + y;

			struct msg request_lock;
			request_lock.i = x;
			request_lock.j = y;
			request_lock.msg_type = 1;
			request_lock.ts = new_ts;

			for(int j=0;j<N;j++){
				// if(j!= y){
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
				// }
			}

			for(int i=0;i<N;i++){
				if(i!= x){
					write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
				}
			}
			struct msg recv_msg;
			int grant_send = 0;
			int grant_x,grant_y;
			int grant_ts;
			grant_ts = -1;
			grant_y = -1;
			grant_x = -1;

			// struct Proc_node* head;
			struct msg send_msg;
			send_msg.i = x;
			send_msg.j = y;
			send_msg.ts = new_ts;

			int acq_lock[N][N];
			int grant_lock[N][N];
			int fail[N][N];
			for(int l=0;l<N;l++){
				for(int m=0;m<N;m++){
					if((N*l + m) < num_P1){
						acq_lock[l][m] = 1;
					}else{
						acq_lock[l][m] = 0;
					}
					grant_lock[l][m] = 0;
					fail[N][N] = 0;
				}
			}
			int entered_cs = 0;
			int count_fail = 0;

			while(1){
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
				// printf(1,"%d %d recv %d %d type %d\n",x,y,recv_msg.i,recv_msg.j,recv_msg.msg_type);
				if(recv_msg.msg_type == 1){
					if(grant_send == 0){
						grant_send = 1;
						grant_x = recv_msg.i;
						grant_y = recv_msg.j;
						grant_ts = recv_msg.ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
					}
					else{

						if(recv_msg.ts > grant_ts){
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
							}
							send_msg.msg_type = 3;
							// send_msg.ts = clock();							
							write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));

						}
						else{
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
								send_msg.msg_type = 4;
								// send_msg.ts = clock();							
								write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
								
								if(ind == 0){
									send_msg.msg_type = 4;
									// send_msg.ts = clock();							
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
								}
								else{
									send_msg.msg_type = 3;
									// send_msg.ts = clock();							
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
								}
							}
						}
					}

				}
				else if(recv_msg.msg_type == 4){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(fail[x][l] == 1){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(fail[l][y] == 1){
								flag = 0;
							}
						// }
					}
					if((flag == 0) && (entered_cs == 0)){
						grant_lock[recv_msg.i][recv_msg.j] = 0;
						send_msg.msg_type = 5;
						// send_msg.ts = clock();							
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
					}
				}
				else if(recv_msg.msg_type == 5){
					int prev_ts = grant_ts;
					int prev_x = grant_x;
					int prev_y = grant_y;
					if(size == 0){
						// printf("Error\n");
					}

					grant_x = mqueue[0].i;
					grant_y = mqueue[0].j;
					grant_ts = mqueue[0].ts;

					for(int l =0;l<(size - 1);l++){
							mqueue[l].msg_type = mqueue[l+1].msg_type;
							mqueue[l].i = mqueue[l+1].i;
							mqueue[l].j = mqueue[l+1].j;
							mqueue[l].ts = mqueue[l+1].ts;
					}

					size--;

					int ind = -1;
					for(int l =0;l<size;l++){
						if(mqueue[l].ts > prev_ts){
							ind = l;
							break;
						}
					}
					if(ind == -1){
						mqueue[size].msg_type = 1;
						mqueue[size].i = prev_x;
						mqueue[size].j = prev_y;
						mqueue[size].ts = prev_ts;
						size++;								
					}
					else{
						for(int l=size;l>ind;l--){
							mqueue[l].msg_type = mqueue[l-1].msg_type;
							mqueue[l].i = mqueue[l-1].i;
							mqueue[l].j = mqueue[l-1].j;
							mqueue[l].ts = mqueue[l-1].ts;
						}
						mqueue[ind].msg_type = 1;
						mqueue[ind].i = prev_x;
						mqueue[ind].j = prev_y;
						mqueue[ind].ts = prev_ts;
						size++;
					}
					send_msg.msg_type = 2;
					// send_msg.ts = clock();

					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

				}
				else if(recv_msg.msg_type == 7){
					acq_lock[recv_msg.i][recv_msg.j] = 1;
					if(size <= 0){
						// printf("\nRelease Error\n");
						grant_send = 0;
					}
					else{
						grant_x = mqueue[0].i;
						grant_y = mqueue[0].j;
						grant_ts = mqueue[0].ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

						for(int l =0;l<(size-1);l++){
								mqueue[l].msg_type = mqueue[l+1].msg_type;
								mqueue[l].i = mqueue[l+1].i;
								mqueue[l].j = mqueue[l+1].j;
								mqueue[l].ts = mqueue[l+1].ts;
						}
						size--;
					}

				}
				else if(recv_msg.msg_type == 2){
					grant_lock[recv_msg.i][recv_msg.j] = 1;
					fail[recv_msg.i][recv_msg.j] = 0;
				}
				else if(recv_msg.msg_type == 3){
					fail[recv_msg.i][recv_msg.j] = 1;
					grant_lock[recv_msg.i][recv_msg.j] = 0;
					count_fail++;
				}
				int my_break = 1;
				for(int l =0;l<N;l++){
					// if(l!=y){
						if(acq_lock[x][l] == 0){
							my_break = 0;
						}
					// }
				}

				for(int l =0;l<N;l++){
					// if(l!=x){
						if(acq_lock[l][y] == 0){
							my_break = 0;
						}
					// }
				}
				if(my_break == 1){
					exit();
					break;
				}

				if(entered_cs == 0){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(grant_lock[x][l] == 0){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(grant_lock[l][y] == 0){
								flag = 0;
							}
						// }
					}
					if(flag == 1){
						entered_cs = 1;
						// gettimeofday(&tv2, NULL);
						printf(1,"%d acquired the lock at time %d.\n",getpid(),(int)uptime());
						sleep(200);
						// gettimeofday(&tv2, NULL);
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
						request_lock.i = x;
						request_lock.j = y;
						request_lock.msg_type = 7;
						// request_lock.ts = clock();

						for(int j=0;j<N;j++){
							// if(j!= y){
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
							// }
						}

						for(int i=0;i<N;i++){
							if(i!= x){
								write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
							}
						}
					}
				}
			}
		}
		else{
		// printf("Inside P3\n");
			int new_ts = N*x + y;

			struct msg request_lock;
			request_lock.i = x;
			request_lock.j = y;
			request_lock.msg_type = 1;
			request_lock.ts = new_ts;

			for(int j=0;j<N;j++){
				// if(j!= y){
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
				// }
			}

			for(int i=0;i<N;i++){
				if(i!= x){
					write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
				}
			}
			struct msg recv_msg;
			int grant_send = 0;
			int grant_x,grant_y;
			int grant_ts;
			grant_ts = -1;
			grant_y = -1;
			grant_x = -1;
			// struct Proc_node* head;
			struct msg send_msg;
			send_msg.i = x;
			send_msg.j = y;
			send_msg.ts = new_ts;

			int acq_lock[N][N];
			int grant_lock[N][N];
			int fail[N][N];
			for(int l=0;l<N;l++){
				for(int m=0;m<N;m++){
					if((N*l + m) < num_P1){
						acq_lock[l][m] = 1;
					}else{
						acq_lock[l][m] = 0;
					}
					grant_lock[l][m] = 0;
					fail[N][N] = 0;
				}
			}
			int entered_cs = 0;
			int count_fail = 0;

			while(1){
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
				// printf("%d %d recv %d %d type %d\n",x,y,recv_msg.i,recv_msg.j,recv_msg.msg_type);
				if(recv_msg.msg_type == 1){
					if(grant_send == 0){
						grant_send = 1;
						grant_x = recv_msg.i;
						grant_y = recv_msg.j;
						grant_ts = recv_msg.ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
					}
					else{

						if(recv_msg.ts > grant_ts){
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
							}
							send_msg.msg_type = 3;
							// send_msg.ts = clock();							
							write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));

						}
						else{
							int ind = -1;
							for(int l =0;l<size;l++){
								if(mqueue[l].ts > recv_msg.ts){
									ind = l;
									break;
								}
							}
							if(ind == -1){
								mqueue[size].msg_type = recv_msg.msg_type;
								mqueue[size].i = recv_msg.i;
								mqueue[size].j = recv_msg.j;
								mqueue[size].ts = recv_msg.ts;
								size++;								
								send_msg.msg_type = 4;
								// send_msg.ts = clock();							
								write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
							}
							else{
								for(int l=size;l>ind;l--){
									mqueue[l].msg_type = mqueue[l-1].msg_type;
									mqueue[l].i = mqueue[l-1].i;
									mqueue[l].j = mqueue[l-1].j;
									mqueue[l].ts = mqueue[l-1].ts;
								}
								mqueue[ind].msg_type = recv_msg.msg_type;
								mqueue[ind].i = recv_msg.i;
								mqueue[ind].j = recv_msg.j;
								mqueue[ind].ts = recv_msg.ts;
								size++;
								
								if(ind == 0){
									send_msg.msg_type = 4;
									// send_msg.ts = clock();							
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
								}
								else{
									send_msg.msg_type = 3;
									// send_msg.ts = clock();							
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
								}
							}
						}
					}

				}
				else if(recv_msg.msg_type == 4){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(fail[x][l] == 1){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(fail[l][y] == 1){
								flag = 0;
							}
						// }
					}
					if((flag == 0) && (entered_cs == 0)){
						grant_lock[recv_msg.i][recv_msg.j] = 0;
						send_msg.msg_type = 5;
						// send_msg.ts = clock();							
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
					}
				}
				else if(recv_msg.msg_type == 5){
					int prev_ts = grant_ts;
					int prev_x = grant_x;
					int prev_y = grant_y;
					if(size == 0){
						// printf("Error\n");
					}

					grant_x = mqueue[0].i;
					grant_y = mqueue[0].j;
					grant_ts = mqueue[0].ts;

					for(int l =0;l<(size - 1);l++){
							mqueue[l].msg_type = mqueue[l+1].msg_type;
							mqueue[l].i = mqueue[l+1].i;
							mqueue[l].j = mqueue[l+1].j;
							mqueue[l].ts = mqueue[l+1].ts;
					}

					size--;

					int ind = -1;
					for(int l =0;l<size;l++){
						if(mqueue[l].ts > prev_ts){
							ind = l;
							break;
						}
					}
					if(ind == -1){
						mqueue[size].msg_type = 1;
						mqueue[size].i = prev_x;
						mqueue[size].j = prev_y;
						mqueue[size].ts = prev_ts;
						size++;								
					}
					else{
						for(int l=size;l>ind;l--){
							mqueue[l].msg_type = mqueue[l-1].msg_type;
							mqueue[l].i = mqueue[l-1].i;
							mqueue[l].j = mqueue[l-1].j;
							mqueue[l].ts = mqueue[l-1].ts;
						}
						mqueue[ind].msg_type = 1;
						mqueue[ind].i = prev_x;
						mqueue[ind].j = prev_y;
						mqueue[ind].ts = prev_ts;
						size++;
					}
					send_msg.msg_type = 2;
					// send_msg.ts = clock();

					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

				}
				else if(recv_msg.msg_type == 7){
					acq_lock[recv_msg.i][recv_msg.j] = 1;
					if(size <= 0){
						// printf("\nRelease Error\n");
						grant_send = 0;
					}
					else{
						grant_x = mqueue[0].i;
						grant_y = mqueue[0].j;
						grant_ts = mqueue[0].ts;
						send_msg.msg_type = 2;
						// send_msg.ts = clock();
	
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));

						for(int l =0;l<(size-1);l++){
								mqueue[l].msg_type = mqueue[l+1].msg_type;
								mqueue[l].i = mqueue[l+1].i;
								mqueue[l].j = mqueue[l+1].j;
								mqueue[l].ts = mqueue[l+1].ts;
						}
						size--;
					}

				}
				else if(recv_msg.msg_type == 2){
					grant_lock[recv_msg.i][recv_msg.j] = 1;
					fail[recv_msg.i][recv_msg.j] = 0;
				}
				else if(recv_msg.msg_type == 3){
					fail[recv_msg.i][recv_msg.j] = 1;
					grant_lock[recv_msg.i][recv_msg.j] = 0;
					count_fail++;
				}
				int my_break = 1;
				for(int l =0;l<N;l++){
					// if(l!=y){
						if(acq_lock[x][l] == 0){
							my_break = 0;
						}
					// }
				}

				for(int l =0;l<N;l++){
					// if(l!=x){
						if(acq_lock[l][y] == 0){
							my_break = 0;
						}
					// }
				}
				if(my_break == 1){
					exit();
					break;
				}
				if(entered_cs == 0){
					int flag = 1;
					for(int l =0;l<N;l++){
						// if(l!=y){
							if(grant_lock[x][l] == 0){
								flag = 0;
							}
						// }
					}

					for(int l =0;l<N;l++){
						// if(l!=x){
							if(grant_lock[l][y] == 0){
								flag = 0;
							}
						// }
					}
					if(flag == 1){
						entered_cs = 1;
						printf(1,"%d acquired the lock at time %d.\n",getpid(),(int)uptime());
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
						request_lock.i = x;
						request_lock.j = y;
						request_lock.msg_type = 7;
						// request_lock.ts = clock();

						for(int j=0;j<N;j++){
							// if(j!= y){
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
							// }
						}

						for(int i=0;i<N;i++){
							if(i!= x){
								write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
							}
						}
					}
				}
			}
		}
	}
	else{
		join_container(6);
		ps();
		for(int l=0;l<N;l++){
			for(int m=0;m<N;m++){
				wait();
			}
		}
		exit();
		// int returnstatus;
		// for(int l=0;l<N;l++){
		// 	for(int m=0;m<N;m++){
		// 		waitpid(stored_pid[l][m],&returnstatus,0);
		// 	}
		// }
	}
}