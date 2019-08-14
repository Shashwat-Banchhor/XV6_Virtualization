struct stat;
struct rtcdate;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
/// ADDED
int toggle(void);
int add(int,int);
int ps(void);
int send(int,int,void *);
int recv(int *,int *,void *);
int send_multi(char *, int * ,int);
int print_count(void);
int create_container(int container_id);
int destroy_container(int container_id);
int leave_container(void);
int join_container(int container_id);
int getcid(void);
int p_ctable(void);
int sz_ctable(void);
int scheduler_log_on(void);
int scheduler_log_off(void);

// int read_file()

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
// char* itoa(int n);
// char *itoa(char * s1,char *s2, int n);


#define MSGSIZE 8