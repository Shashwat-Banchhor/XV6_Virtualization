// Per-CPU state
struct cpu {
  uchar apicid;                // Local APIC ID
  struct context *scheduler;   // swtch() here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint started;       // Has the CPU started?
  int ncli;                    // Depth of pushcli nest ing.
  int intena;                  // Were interrupts enabled before pushcli?
  struct proc *proc;           // The process running on this cpu or null
};

extern struct cpu cpus[NCPU];
extern int ncpu;

////////////////////////////// ADDED BELOW //////////////////////////////////////
extern int system_trace;
extern int call_count[] ; //28  zeros
extern char * sys_call_name[];
extern int print_ps(void);
extern int send_msg(int sender_id,int recv_id,void * msg);
extern char * recv_msg(int * myid, int * from,void * msg);
void multicast_msg(char * msg, int * grpid,int grpsiz);


// Message_Buffers stores multiple message buffers :- which are 8 byte long messages(store as char*)  


#define MSGSIZE 8
extern char* Message_Buffers[MSGSIZE *NPROC*NPROC];
extern int Receive_Queue[MSGSIZE * NPROC*NPROC];
extern int Sender_Queue[MSGSIZE * NPROC*NPROC];
extern int Wait_Queue[MSGSIZE * NPROC*NPROC];

// extern int current_msg_index;



////////////////////////////// ADDED ABOVE //////////////////////////////////////

//PAGEBREAK: 17
// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context {
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  uint sz;                     // Size of process memory (bytes)
  pde_t* pgdir;                // Page table
  char *kstack;                // Bottom of kernel stack for this process
  enum procstate state;        // Process state
  int pid;                     // Process ID
  struct proc *parent;         // Parent process
  struct trapframe *tf;        // Trap frame for current syscall
  struct context *context;     // swtch() here to run process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
  // a d d e d //
  // static int messages_received;
  char * message_buffer[MSGSIZE];
  int  received_buffer[MSGSIZE];


  int in_container_id ; 



};

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap


struct container
{
  int cid;
  // struct proc proc[NPROC];

};

int scheduler_log; 

