//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"








char *
itoa(int n)
{
 
  char * s = kalloc();
  // s = s1;
  int k = 0 ;
  // *s = '0';
  if (n==0){ *(s+k) = '0'; k++; *(s+k) = '\0'; return s;}
  
  while(n>0){
    
      int p = n%10;
      switch(p){
        case 0:
          *(s+k) = '0';
          k++;
          break;
        case 1:
          *(s+k) = '1';
          k++;
          break;
        case 2:
          *(s+k) = '2';
          k++;
          break;
        case 3:
          *(s+k) = '3';
          k++;
          break;
        case 4:
          *(s+k) = '4';
          k++;
          break;
        case 5:
          *(s+k) = '5';
          k++;
          break;
        case 6:
          *(s+k) = '6';
          k++;
          break;
        case 7:
          *(s+k) = '7';
          k++;
          break;
        case 8:
          *(s+k) = '8';
          k++;
          break;
        case 9:
          *(s+k) = '9';
          k++;
          break;
      }
      n = n/10;
  }
  // *(s+k) = '\0';
  // printf(1,"K is %d S  is %s\n",k , s );
  // *(s+k) = '\0';
  char * to_ret = kalloc() ;
  // to_ret = s2;
  int q = 0;
  // *to_ret = '0';
  while(k>0){
    *(to_ret+q) = *(s+k-1);
    // printf(1,"To ret is now %s \n",to_ret);
    k--;
    q++;
  }
  *(to_ret + q) = '\0';
  // cprintf("To ret is %s",to_ret);

  return to_ret;
}








// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

int
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
new_read(int fd,char *p,int n)
{
  struct file *f;
  // int n;
  // char *p;

  // if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    // return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;


  return fileread(f, p, n);
}

int
sys_read(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return fileread(f, p, n);
}


int
new_write(int fd,char *p ,int n)
{
  struct file *f;
  // int n;
  // char *p;

  // if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  //   return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;

  return filewrite(f, p, n);
}


int
sys_write(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  return 0;
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
  cprintf("In sys_close %d \n",f->ip->cid );
  fileclose(f);
  cprintf("In sys_close after fileclose %d \n",f->ip->cid );

  return 0;
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

//PAGEBREAK!
int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];




  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  

  // ADDED

  // struct proc *curproc = myproc();
  // ip->cid =  curproc->in_container_id ;
  // cprintf("File cid set %d", ip->cid);

  return ip;
}


int
new_open(char *path, int omode)
{
  // char *path;
  int fd;
  struct file *f;
  struct inode *ip;
  struct inode *ip_old;


  /// ADDED //
  int flag = 0;
  // int flag_read = 0;
  // cprintf("Entered in open");
  //////////////


  // if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  //   return -1;

  
  begin_op();

  if(omode & O_CREATE){
     int l  = strlen(path);

    if(myproc()->in_container_id > 0 ){

      char * new_path = kalloc();
      int i = 0;
      while(i<l){
        *(new_path + i) = *(path + i );
        i++;
       }


     char * cid_str = itoa(myproc()->in_container_id);
     int c_len = strlen(cid_str);
     i = 0 ;
     while(i<c_len){
      *(new_path+l+ i) = *(cid_str+i);
      i++;
     }
     // *(path + l+ i )= '\0';
     // cprintf("Path is %s", path);
    ip = create(new_path, T_FILE, 0, 0);

    }
    else{
      ip = create(path, T_FILE, 0, 0);
    }
    // ADDED /
    flag = 1;
    ip->path_len = l;
   // char * s = itoa(0);
    // cprintf("String is %s \n\n", s);

    //////////
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {

    if (myproc()->in_container_id > 0){

      ip_old  = namei(path);

       int l  = strlen(path);

      char * new_path = kalloc();
      int i = 0;
      while(i<l){
        *(new_path + i) = *(path + i );
        i++;
       }

       char * cid_str = itoa(myproc()->in_container_id);
       int c_len = strlen(cid_str);
       i = 0 ;
       while(i<c_len){
        *(new_path+l+ i) = *(cid_str+i);
        i++;
       }
      if((ip = namei(new_path)) == 0){
        if (ip_old==0){
          end_op();
          return -1;
        }
        else{

          ip = ip_old;
          // flag_read = 1;
          // end_op();
          // return -1;
        }
      }
    }
    else{
      if((ip = namei(path)) == 0){
        end_op();
        return -1;
      }
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  end_op();

  //// ADDED
  if(flag==1){
    ip->cid = myproc()->in_container_id;
  }
  
  ///////////////////////

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  //// ADDED
  // if(flag==1){
    // f->cid = myproc()->in_container_id;
  // }

  // cprintf("Returning from open f->cid is %d",f->ip->cid);
  // struct proc *curproc = myproc();
  // if (curproc->in_container_id != f->ip->cid){
  //   return 0;
  // }

  // cprintf("Path len %d , Path cid %d", ip->path_len,ip->cid);
  
  // if (flag_read==1){
  //   char * buffer  = kalloc();
  //   new_read(fd,buffer,f->ip->size);
  //   int fd2 = new_open(path,O_CREATE);
  //   new_write(fd2,buffer,f->ip->size);
  //   return fd2;
  // }
  //////////////////////
  return fd;
}

int
sys_open(void)
{
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;
  struct inode *ip_old;

  int old_omode;

  /// ADDED //
  int flag = 0;
  int flag_read = 0;
  // cprintf("Entered in open");
  //////////////


  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  
  begin_op();

  if(omode & O_CREATE){
     int l  = strlen(path);

    if(myproc()->in_container_id > 0 ){

      char * new_path = kalloc();
      int i = 0;
      while(i<l){
        *(new_path + i) = *(path + i );
        i++;
       }


     char * cid_str = itoa(myproc()->in_container_id);
     int c_len = strlen(cid_str);
     i = 0 ;
     while(i<c_len){
      *(new_path+l+ i) = *(cid_str+i);
      i++;
     }
     // *(path + l+ i )= '\0';
     // cprintf("Path is %s", path);
    ip = create(new_path, T_FILE, 0, 0);

    }
    else{
      ip = create(path, T_FILE, 0, 0);
    }
    // ADDED /
    flag = 1;
    ip->path_len = l;
   // char * s = itoa(0);
    // cprintf("String is %s \n\n", s);

    //////////
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {

    if (myproc()->in_container_id > 0){

      ip_old  = namei(path);

       int l  = strlen(path);

      char * new_path = kalloc();
      int i = 0;
      while(i<l){
        *(new_path + i) = *(path + i );
        i++;
       }

       char * cid_str = itoa(myproc()->in_container_id);
       int c_len = strlen(cid_str);
       i = 0 ;
       while(i<c_len){
        *(new_path+l+ i) = *(cid_str+i);
        i++;
       }
      if((ip = namei(new_path)) == 0){
        if (ip_old==0){
          end_op();
          return -1;
        }
        else{

          ip = ip_old;
          if ((omode & O_WRONLY) || (omode & O_RDWR))
          {     
                 old_omode = omode;
                 omode  = O_RDWR;
                 flag_read = 1;
          }
          // end_op();
          // return -1;
        }
      }
    }
    else{
      if((ip = namei(path)) == 0){
        end_op();
        return -1;
      }
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  end_op();

  //// ADDED
  if(flag==1){
    ip->cid = myproc()->in_container_id;
  }
  
  ///////////////////////

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  //// ADDED
  // if(flag==1){
    // f->cid = myproc()->in_container_id;
  // }

  // cprintf("Returning from open f->cid is %d",f->ip->cid);
  // struct proc *curproc = myproc();
  // if (curproc->in_container_id != f->ip->cid){
  //   return 0;
  // }

  // cprintf("Path len %d , Path cid %d", ip->path_len,ip->cid);
  
  if (flag_read==1){
    


    char * buffer  = kalloc();
    
    // new_open(path,O_RDONLY);
    new_read(fd,buffer,f->ip->size);
    // cprintf("BUFFER : %s\n",buffer);

    int fd2 = new_open(path,O_CREATE);
    fd2 = new_open(path,O_WRONLY);
    new_write(fd2,buffer,f->ip->size);
    // cprintf("Written : %d",written);

    f->readable = !(old_omode & O_WRONLY);
    f->writable = (old_omode & O_WRONLY) || (old_omode & O_RDWR);

    
    return fd2;
  }
  //////////////////////
  return fd;
}



int
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_chdir(void)
{
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
