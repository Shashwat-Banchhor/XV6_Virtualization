#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;



#define MAX_CONTAINERS 1024

struct {
  // Container Table lock
  struct spinlock lock;
  // Table of Containers
  struct container containers[MAX_CONTAINERS];
  int size;

} container_table;

int intialized_ctable = 0;


static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
  initlock(&container_table.lock, "container_table");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
    {  
      p->in_container_id = -1;
      goto found;
    }
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  // added 
  for (int i = 0; i < MSGSIZE; ++i)
  {
    p->received_buffer[i] = -1;
  }
  // addition ends here
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE



int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();





  // Allocate process.
  //  pick us an unused proc structure and set it's state as empryo an
  // update the kernel stack
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  // copies page directory from parent to child process
  // returns pointer to new page directory
  // ikt fails then everything is reverted
  // state set back to unsused
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }

  // tf is the tractframe // created when a sys_call is invoked
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;


// copy from parent to child 
  // exec name cwd, file pointers
  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  // sceduler can select the child process and allocate the cpu
  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;

  // child process will differ only in 2 registers eax and eip(insstruction pointer)
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  // int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  // for(fd = 0; fd < NOFILE; fd++){
  //   if(curproc->ofile[fd]){
  //     fileclose(curproc->ofile[fd]);
  //     curproc->ofile[fd] = 0;
  //   }
  // }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  

  // ptable is an array of proc 
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    // check every process 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      // is current proc the parent of p
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  

  int turn_cid = -1;
  

  int counter = 0;
  // int process_ran = 0;
  for(;;){
    // Enable interrupts on this processor.
    sti();



    // Loop over process table looking for process to run.

    acquire(&container_table.lock);
      int ind = 0;
      int flag = 0;
    // cprintf("before   my_turn %d counter %d counter_cid %d\n",turn_cid,counter,container_table.containers[counter].cid);

      for(ind = counter ; ind< container_table.size ; ind++)
        {
          
          if(container_table.containers[ind].cid != turn_cid){
            turn_cid = container_table.containers[ind].cid;
            counter = ind;
            flag = 1;
            break;
          }
        }
      if (flag ==0){
        counter  =0;
        turn_cid  = -1;
      }
    release(&container_table.lock);
    // cprintf(" after my_turn %d counter %d counter_cid %d\n",turn_cid,counter,container_table.containers[counter].cid);

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      
      // if(process_ran == 1){
      //   acquire(&container_table.lock);
      //     int ind = 0;
      //     int flag = 0;
      //   // cprintf("before   my_turn %d counter %d counter_cid %d\n",turn_cid,counter,container_table.containers[counter].cid);

      //     for(ind = counter ; ind< container_table.size ; ind++)
      //       {
              
      //         if(container_table.containers[ind].cid != turn_cid){
      //           turn_cid = container_table.containers[ind].cid;
      //           counter = ind;
      //           flag = 1;
      //           break;
      //         }
      //       }
      //     if (flag ==0){
      //       counter  =0;
      //       turn_cid  = -1;
      //     }
      //   release(&container_table.lock);

      //   process_ran = 0;
      // }

      if(p->state != RUNNABLE || p->in_container_id != turn_cid ){
        // process_ran= 0;
        continue;
      }
      // process_ran = 1;
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.

      if (scheduler_log==1){
        cprintf("Container + %d : Scheduling process + %d\n",p->in_container_id,p->pid);
      }



      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
      break;
    }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}



///////A D D E D//////////////


int
print_ps(void)
{

  // container_id
  struct proc *p = myproc();
  int my_cid  = p->in_container_id;

  struct proc *listp;
  acquire(&ptable.lock);
  for(listp = ptable.proc; listp < &ptable.proc[NPROC]; listp++){
      if (listp->in_container_id == my_cid){
        if(listp->state != UNUSED)
        {
          cprintf("pid:%d name:%s\n",listp->pid,listp->name);
        }
      }
    
  }
  release(&ptable.lock);
  return 0;
}

static int init_flag = 0;
char* Message_Buffers[MSGSIZE*NPROC*NPROC];
int Receive_Queue[MSGSIZE*NPROC*NPROC];
int Sender_Queue[MSGSIZE*NPROC*NPROC];
int Wait_Queue[MSGSIZE * NPROC*NPROC];



int
send_msg(int sender_id,int recv_id,void * msg)
{
    // WITH BUSY WAIT old 
      // while(1){
      //   if (init_flag==0){
      //     for (int i = 0; i < MSGSIZE*MSGSIZE; ++i)
      //     {
      //       Receive_Queue[i]= -1;
      //     }
      //     init_flag =1;
      //   }
      //   if (init_flag==1){
      //     break;
      //   }
      // }
      // char * message = (char *) msg;

      // int i;
      // int start = sender_id*MSGSIZE;

      // for (i = start; i < start + MSGSIZE; ++i)
      // {
      //   if (Receive_Queue[i]==-1){
      //     break;
      //   }
      // }
      // if (i==start+MSGSIZE){
      //   cprintf("Error Message_Buffer is Overflowing!!!! \n");
      // }

      // // cprintf("The reciever is  %d and message to send is %s \n",i,message);

      // // send the message to message buffer
      // // cprintf("Message buffer : %s \n",Message_Buffers[i]);
      // // for (int j = 0; j < MSGSIZE; ++j)
      // // {
      // //   *(Message_Buffers[i]+j) = *(message+j);
      // //   // cprintf("Message_Buffers[%d] %d is %s \n",i,j,Message_Buffers[i]+j);
      // // }
      // Message_Buffers[i] = message;
      // // cprintf("Message buffer : %s \n",Message_Buffers[i]);
       
      // Receive_Queue[i] = recv_id;
      // for (int i = start; i < start + MSGSIZE; ++i)
      // {
      //   cprintf("%d: %s",Receive_Queue[i],Message_Buffers[i]);
      // }
      // cprintf("\nMessage_Buffers is filled with the message\n");

  // ////////////////////////////////////////////CHECK IF INITIALIZED//////
  while(1){
    if (init_flag==0){
      for (int i = 0; i < MSGSIZE*NPROC*NPROC; ++i)
      {
        Message_Buffers[i] = (char *) kalloc();
        Receive_Queue[i]= -1;
        Wait_Queue[i] = -1;
        Sender_Queue[i] = -1;
      }
      init_flag =1;
    }
    if (init_flag==1){
      break;
    }
  }
  /////////////////////////////////////////////////////////////////////////



  char * message = (char *) msg;

  int i;
  int start = recv_id*NPROC*MSGSIZE + sender_id*MSGSIZE;

  for (i = start; i < start + MSGSIZE; ++i)
  {
    if (Receive_Queue[i]==-1){
      break;
    }
  }
  if (i==MSGSIZE*NPROC*NPROC){
    cprintf("Error Message_Buffer is Overflowing!!!! \n");
  }

  for (int j = 0; j < MSGSIZE; ++j)
  {
    *(Message_Buffers[i]+j) = *(message+j);
  }

  cprintf("Sending message in Message_Buffer[%d] =  %d \n",i,*((int*)Message_Buffers[i]));

  // strcpy(Message_Buffers[i],message);
  // while((*Message_Buffers[i]++ = *message++) != 0)
  //   ;
  //Message_Buffers[i] = message;
  // cprintf("Message_Buffer[i] is : %s \n",Message_Buffers[i]); 
   
  Receive_Queue[i] = recv_id;
  Sender_Queue[i]  = sender_id;

  for (i = start; i < MSGSIZE*NPROC + start; ++i)
  {
    if (Wait_Queue[i]==recv_id){
      break;
    }
  }

  struct proc * p ;
  if(i<MSGSIZE*NPROC*NPROC){
    int wait_pid = Wait_Queue[i];
    Wait_Queue[i]=-1;
    acquire(&ptable.lock);
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != UNUSED){  
          if(p->pid == wait_pid){
            p->state  = RUNNABLE;
           // Wake process from sleep if necessary.
          }
          
        }
      }
    release(&ptable.lock);
  }

  
  // for (i = start; i < start + MSGSIZE; ++i)
  // {
  //   cprintf("%d: %s ",Receive_Queue[i],Message_Buffers[i]);
  // }
  
  // cprintf("\nMessage_Buffers is filled with the message\n");
  return 0;


}



char *
recv_msg(int * myid,int * from,void * mesg)
{ 

  
  // msg is char *
  while(1){
    if (init_flag==0){
      for (int i = 0; i < MSGSIZE*NPROC*NPROC; ++i)
      {
        Message_Buffers[i] = (char *) kalloc();

        Receive_Queue[i]= -1;
        Wait_Queue[i] = -1;
        Sender_Queue[i] = -1;
      }
      init_flag =1;
    }
    if (init_flag==1){
      break;
    }
  }
  char * msg = (char *) mesg;
  struct proc * p ;
  p = myproc();
  int pid = p->pid;
  int i;
         cprintf("Receiving message pid[%d] \n",pid);

  // *myid = pid;

  // cprintf("Recv PID is %d \n",pid);
  while(1){  
    
  // int start = 0;
  // for (int i = start; i < start + MSGSIZE; ++i)
  // {
  //   // cprintf(" \n INside Recv %d: %s ",Receive_Queue[i], Message_Buffers[i]);
  // }
         // cprintf("Receiving message pid[%d] \n",pid);

    int start = pid*MSGSIZE*NPROC;
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
    {

      if (Receive_Queue[i]==pid){
  
        // cprintf("  i is %d We found a message here  %d: %s ",i,Receive_Queue[i],Message_Buffers[i]);
         cprintf("Receiving message in Message_Buffer[R %d] \n",i);
        
        break;
      }
    }
    // cprintf("Receiving message in Message_Buffer[%d] \n",i);

    if (i<MSGSIZE*NPROC*NPROC){
    // cprintf("Receiving message in Message_Buffer[%d] \n",i);

      break;
    }
    else{
      // BLock the current process

      acquire(&ptable.lock);
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state!= UNUSED){  
          if(p->pid == pid){
            p->state  = SLEEPING;
           // Wake process from sleep if necessary.

          for (i = start; i < MSGSIZE*NPROC+start; ++i)
          {
                if (Wait_Queue[i]==-1){
                  break;
                 }
          }
            // Inser the process in the wait queue;
          Wait_Queue[i] = pid;
          sched();
           
          }
        }
  
      }
      release(&ptable.lock);
    }
  }
   // cprintf("Received Message before %d:  %s",pid,Message_Buffers[i]);
  // copy the msg 
  for (int j = 0; j < MSGSIZE; ++j)
  {
    *(msg+j) = *(Message_Buffers[i]+j);
  }
  // I have received the message clear the the Receive Queue
  *myid = Receive_Queue[i];
  *from = Sender_Queue[i];

  Receive_Queue[i] = -1;
  Sender_Queue[i] = -1;
  // cprintf("Received Message %d:  %s",pid,msg);
  return msg;
}

void
multicast_msg(char * msg, int * grpid,int grpsiz){

  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    int i;
    
    // is this process in grpid
    for (i = 0; i < grpsiz; ++i)
      {
        if (grpid[i]==p->pid){
          break;
        }
      }  
    // process not  in grpid
    if (i==grpsiz){
      continue;
    }
    
    // find where to put the message in the message_buffer of the process
    for (i = 0; i < MSGSIZE; ++i)
    {
      if (p->received_buffer[i] == -1){
        break;
      }
    }
    if (i==MSGSIZE){
      cprintf("The message_buffer of Process %d is overflowing.!!\n",p->pid);
    }

  // copy the message 
  //p->message_buffer[i] = msg;
  for (int j = 0; j < MSGSIZE; ++j)
  {
    *(p->message_buffer[i]+j) = *(msg+j) ;
  }



  }
  release(&ptable.lock);

  return ;
} 



int
getNewCid(int container_id){


  // int cid;
  acquire(&container_table.lock);

    if (!intialized_ctable){
      for (int j = 0;j< MAX_CONTAINERS ; j++){
        container_table.containers[j].cid= -1;
      }
      container_table.size = 0;
      intialized_ctable = 1;
    }


    container_table.containers[container_table.size].cid = container_id;
    container_table.size += 1;
  release(&container_table.lock);

  return container_id;
}

int
destroyCid(int container_id){
  
  int flag = 0;
  acquire(&container_table.lock);
      
      for(int i = 0 ;i< container_table.size ; i++)
      {
        if (container_table.containers[i].cid==container_id){
            for(int j= i ; j<(container_table.size-1);j++){
              container_table.containers[j].cid = container_table.containers[j+1].cid ;
            }
            container_table.containers[container_table.size-1].cid = -1;
            container_table.size -= 1;
            flag =1;
            break;
        } 
      }
  release(&container_table.lock);

  if (flag==0){
    return 0;
  }
  else{
    struct proc *listp;
    acquire(&ptable.lock);
      for (listp=ptable.proc;listp<&ptable.proc[NPROC];listp++){
        if (listp->in_container_id==container_id){
          listp->in_container_id = -1;
        }
      }
    release(&ptable.lock);


  }

  return container_id;
}




int
joinCid(int container_id){
  
  struct proc * currproc = myproc();
  int i ;
  acquire(&container_table.lock);
      
      for(i = 0 ;i< container_table.size ; i++)
      {
        if (container_table.containers[i].cid==container_id){
            currproc->in_container_id = container_id ; 
            break; 
        }
      }

  release(&container_table.lock);
  if (i==container_table.size){
    return -1;
  }

  return container_id;
}


int
leaveCid(void){
  struct proc * currproc = myproc();
  currproc->in_container_id = -1; 
  
  return 0;
}


int
print_ctable(void){
  acquire(&container_table.lock);
    int i = 0;
    for(i = 0 ;i< container_table.size ; i++)
      {
        cprintf("%d %d\n",i+1,container_table.containers[i].cid);
      }

  release(&container_table.lock);

  return 0;
}

int
sz_ctable(void){
  acquire(&container_table.lock);
    
    cprintf("Size of ctable %d\n",container_table.size);
  
  release(&container_table.lock);

  return 0;
}


int
log_on(void){
  scheduler_log = 1;
  return 1;
}

int
log_off(void){
  scheduler_log = 0;
  return 1;
}

