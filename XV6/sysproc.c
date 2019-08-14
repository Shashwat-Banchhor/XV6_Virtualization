#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#define MSGSIZE 8 

extern int print_ps(void);

extern int getNewCid(int container_id);
extern int joinCid(int container_id);
extern int leaveCid(void);
extern int destroyCid(int container_id);
extern int print_ctable(void);
extern int sz_ctable(void);
extern int log_on(void);
extern int log_off(void);
extern int mem_log_on(void);
extern int mem_log_off(void);
extern int con_malloc(int,int);



int
sys_fork(void)
{
  
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_toggle(void){
  if (system_trace==1){
    system_trace = 0;
  }
  else{
    system_trace = 1;
    for (int i = 0; i < 30; ++i)
    {
      // reinitialize
      call_count[i] =0;
    }

  }
  return 0;
}

int
sys_add(void){
  int a,b;
  if(argint(0,&a)<0)
   { return -1;}
  if(argint(1,&b)<0)
    {return -1;}

  return a+b;
}

int
sys_ps(void){
  
  
  (void) print_ps();

  return 0;
}

int
sys_send(void){//int sender_pid, int rec_pid, void *msg){
  

  int sender_pid,rec_pid;
  char * msg;
  if(argint(0,&sender_pid)<0)
    {cprintf("Error extracting msg args"); return -1;}
  if(argint(1,&rec_pid)<0)
    {cprintf("Error extracting msg args"); return -1;}
  if(argptr(2,&msg,MSGSIZE)<0)
    {cprintf("Error extracting msg args"); return -1;}
  
  // cprintf ("Going to Send Message : %s \n",msg);
  // put the mesaage int the messagebuffer. 
  send_msg(sender_pid,rec_pid,msg);
  // cprintf("Message Sent !!! \n");
  
  // success 
  return 0;
}


int
sys_recv(void){//void *msg){
 // cprintf ("Receiving Message \n"); 
  
 char * msg;
 int * myid;
 int  * from;
  if(argintptr(0,(void *) &myid,sizeof(*myid))<0)
    {cprintf("Error extracting msg args"); return -1;}
  if(argintptr(1,(void *) &from,sizeof(*from))<0)
    {cprintf("Error extracting msg args"); return -1;}
  if(argptr(2,&msg,MSGSIZE)<0)
    {cprintf("Error extracting msg args"); return -1;}
  msg = recv_msg(myid,from,msg);
  // cprintf("Messafe Recvievd is %s",msg);
 // success 
  return 0;
}



int 
sys_send_multi(void){

    char * msg;int grpsiz;
    
    // initialize grpid
    int  grpid[MSGSIZE];
    for (int i = 0; i < MSGSIZE; ++i)
    {
      grpid[i] = -1;
    }
    if(argptr(0,&msg,MSGSIZE)<0)
    {cprintf("Error extracting msg args"); return -1;}
    if(argint(1,&grpsiz)<0)
    {cprintf("Error extracting grpid args"); return -1;}
    for (int i = 0; i < grpsiz; ++i)
      {
        if(argint(i+2,&grpid[i])<0)
        {cprintf("Error extracting grpid args"); return -1;}
      }  
     
    // do the message spread
    multicast_msg(msg,grpid,grpsiz);
    return 0;
}

int 
sys_create_container(){
  int container_id;
  if(argint(0,&container_id)<0)
   { return -1;}
  
  return getNewCid(container_id);
}

int 
sys_destroy_container(void){
  int container_id;
  if(argint(0,&container_id)<0)
   { return -1;}

  return destroyCid(container_id);
}


int sys_join_container(void){

  int container_id;
  if(argint(0,&container_id)<0)
   { return -1;}


  return joinCid(container_id);
}

int sys_leave_container(void){

  return leaveCid();
}


int
sys_getcid(void)
{
  return myproc()->in_container_id;
}

int
sys_p_ctable(void)
{
  return print_ctable();
}


int
sys_sz_ctable(void)
{
  return sz_ctable();
}

int
sys_scheduler_log_on(void){
  return log_on(); 
}

int
sys_scheduler_log_off(void){
  return log_off(); 
}

int
sys_memory_log_on(void){
  return mem_log_on(); 
}

int
sys_memory_log_off(void){
  return mem_log_off(); 
}

int
sys_container_malloc_scall(void){

  int addr;
  if(argint(0,&addr)<0)
   { return -1;}

  int assign;
  if(argint(1,&assign)<0)
   { return -1;}

  return con_malloc(addr,assign);
}

int
sys_print_count(void){
  
  for (int i = 0; i < 30; ++i)
  {
    if (call_count[i] > 0){
    if (i==1){
      cprintf("sys_fork %d \n",call_count[i]);
    }
    if (i==2){
      cprintf("sys_exit %d \n",call_count[i]);
    }
    if (i==3){
      cprintf("sys_wait %d \n",call_count[i]);
    }
    if (i==4){
      cprintf("sys_pipe %d \n",call_count[i]);
    }
    if (i==5){
      cprintf("sys_read %d \n",call_count[i]);
    }
    if (i==6){
      cprintf("sys_kill %d \n",call_count[i]);
    }
    if (i==7){
      cprintf("sys_exec %d \n",call_count[i]);
    }
    if (i==8){
      cprintf("sys_fstat %d \n",call_count[i]);
    }
    if (i==9){
      cprintf("sys_chdir %d \n",call_count[i]);
    }
    if (i==10){
      cprintf("sys_dup %d \n",call_count[i]);
    }
    if (i==11){
      cprintf("sys_getpid %d \n",call_count[i]);
    }
    if (i==12){
      cprintf("sys_sbrk %d \n",call_count[i]);
    }
    if (i==13){
      cprintf("sys_sleep %d \n",call_count[i]);
    }
    if (i==14){
      cprintf("sys_uptime %d \n",call_count[i]);
    }
    if (i==15){
      cprintf("sys_open %d \n",call_count[i]);
    }
    if (i==16){
      cprintf("sys_write %d \n",call_count[i]);
    }
    if (i==17){
      cprintf("sys_mknod %d \n",call_count[i]);
    }
    if (i==18){
      cprintf("sys_unlink %d \n",call_count[i]);
    }
    if (i==19){
      cprintf("sys_link %d \n",call_count[i]);
    }
    if (i==20){
      cprintf("sys_mkdir %d \n",call_count[i]);
    }
    if (i==21){
      cprintf("sys_close %d \n",call_count[i]);
    }
    if (i==22){
      cprintf("sys_toggle %d \n",call_count[i]);
    }
    if (i==23){
      cprintf("sys_add %d \n",call_count[i]);
    }
    if (i==24){
      cprintf("sys_ps %d \n",call_count[i]);
    }
    if (i==25){
      cprintf("sys_send %d \n",call_count[i]);
    }
    if (i==26){
      cprintf("sys_recv %d \n",call_count[i]);
    }
    if (i==27){
      cprintf("sys_send_multi %d \n",call_count[i]);
    }
    if (i==28){
      cprintf("sys_print_count %d \n",call_count[i]);
    }
    if (i==29){
      cprintf("sys_close %d \n",call_count[i]);
    }
  }
  }



  return 0;
}