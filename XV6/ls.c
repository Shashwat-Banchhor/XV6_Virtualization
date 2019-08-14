#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

char*
fmtname(char *path, int length)
{
            // static char buf[DIRSIZ+1];
            // char *p;

            // // Find first character after last slash.
            // for(p=path+strlen(path); p >= path && *p != '/'; p--)
            //   ;
            // p++;

            // // Return blank-padded name.
            // if(strlen(p) >= DIRSIZ)
            //   return p;
            // memmove(buf, p, strlen(p));
            // memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
            // return buf;


  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+length; p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  int net_len = strlen(path) - strlen(p);
  length = length - net_len; 
  if(length >= DIRSIZ)
    return p;
  memmove(buf, p, length);
  memset(buf+length, ' ', DIRSIZ-length);
  return buf;
}

void
ls(char *path)
{
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  char *str_files[512];
  int size = 0;

  // printf(1,"%s %s\n","path bef swithc 3", path );

  if((fd = open(path, 0)) < 0){
    // printf(2, "ls: cannot open 34%s\n", path);
    return;
  }
  // printf(1,"%s %s\n","path bef swithc 3", path );

  if(fstat(fd, &st) < 0){
    // printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  // printf(1,"%s %s\n","path bef swithc 3", path );
  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path,strlen(path)), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      

      // printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
      if (getcid()>0){
        int flag_print = 0;
        if (st.cid==0){
          char *sbuf = fmtname(buf,strlen(buf));
          for (int i = 0; i < size;i++)
          {
              // printf(1,"CID : %d Sbuf: %s indx : %d str: %s\n",st.cid,sbuf,i,str_files[i] );
              if (strcmp(sbuf,str_files[i])==0){
                flag_print = 1;
                break;
              }

          }
          if (flag_print==0){
            str_files[size] = (char *) malloc(16);
            strcpy(str_files[size],sbuf);
            size++;
          }
        }
        else{
          char *sbuf = fmtname(buf,st.path_len+strlen(path)+1);
          for (int i = 0; i < size;i++)
          {
              // printf(1,"CID : %d Sbuf: %s indx : %d str: %s res: %d\n",st.cid,sbuf,i,str_files[i],strcmp(sbuf,str_files[i]) );

              if (strcmp(sbuf,str_files[i])==0){
                if (st.cid == getcid())
                {
                  flag_print = 1;
                  break;

                }
              }
          }
          if (st.cid==getcid() && flag_print==0){
            str_files[size] = (char *)malloc(16);
            strcpy(str_files[size],sbuf);
            size++;
          }
        }

        if (st.cid ==0){
            if (flag_print==0){  
             printf(1, "%s %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size);
          // printf(1, "%s %d %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size , st.cid);
              
            }
          // printf(1, "%s %d %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size , st.cid);


        }
        else{
          if (st.cid == getcid()){
          if (flag_print==0){
            printf(1, "%s %d %d %d\n", fmtname(buf,st.path_len+strlen(path)+1), st.type, st.ino, st.size);
          // printf(1, "%s %d %d %d %d\n", fmtname(buf,st.path_len+strlen(path)+1), st.type, st.ino, st.size , st.cid);

          }

          // printf(1, "%s %d %d %d %d pathlen: %d %d %s \n", fmtname(buf,st.path_len+strlen(path)+1), st.type, st.ino, st.size , st.cid,st.path_len,strlen(fmtname(buf,st.path_len+strlen(path)+1)),buf);
            
            //TRIM
            // char new_buf[512];
            // strcpy(new_buf, buf);

            //PRINT 
          }
        }
      }
      else{
        if (st.cid ==0){
          printf(1, "%s %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size);

          // printf(1, "%s %d %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size , st.cid);

        }
      }
      // printf(1, "%s %d %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size , st.cid);

      // ADDED ///
      // int cid  = getcid();
      // printf(1," %s CID_FILE : %d ST_CID : %d\n", fmtname(buf), cid , st.cid );
      // if (st.cid == cid){
      //   printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
      // }
      ////////////
    }
    break;
  }
  close(fd);
}

int
main(int argc, char *argv[])
{
  int i;
  // printf(1,"ARGG C: %d\n",argc );
  if(argc < 2){
    ls(".");
    exit();
  }
    // printf(1,"ARGV %d %s\n",0,argv[0] );

  for(i=1; i<argc; i++){
    // printf(1,"ARGV %d %s\n",i,argv[i] );
    ls(argv[i]);
  }
  exit();

}

///////////////////////////////////////////////////////////###############################################################

// #include "types.h"
// #include "stat.h"
// #include "user.h"
// #include "fs.h"

// char*
// fmtname(char *path)
// {
//   static char buf[DIRSIZ+1];
//   char *p;

//   // Find first character after last slash.
//   for(p=path+strlen(path); p >= path && *p != '/'; p--)
//     ;
//   p++;

//   // Return blank-padded name.
//   if(strlen(p) >= DIRSIZ)
//     return p;
//   memmove(buf, p, strlen(p));
//   memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
//   return buf;
// }

// void
// ls(char *path)
// {
//   char buf[512], *p;
//   int fd;
//   struct dirent de;
//   struct stat st;

//   if((fd = open(path, 0)) < 0){
//     printf(2, "ls: cannot open %s\n", path);
//     return;
//   }

//   if(fstat(fd, &st) < 0){
//     printf(2, "ls: cannot stat 1%s\n", path);
//     close(fd);
//     return;
//   }

//   switch(st.type){
//   case T_FILE:
//     printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
//     break;

//   case T_DIR:
//     if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
//       printf(1, "ls: path too long\n");
//       break;
//     }
//     strcpy(buf, path);
//     p = buf+strlen(buf);
//     *p++ = '/';
//     while(read(fd, &de, sizeof(de)) == sizeof(de)){
//       if(de.inum == 0)
//         continue;
//       memmove(p, de.name, DIRSIZ);
//       p[DIRSIZ] = 0;
//       if(stat(buf, &st) < 0){
//         printf(1, "ls: cannot stat 2%s\n", buf);
//         continue;
//       }
//       printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size,st.cid);
//     }
//     break;
//   }
//   close(fd);
// }

// int
// main(int argc, char *argv[])
// {
//   int i;

//   if(argc < 2){
//     ls(".");
//     exit();
//   }
//   for(i=1; i<argc; i++)
//     ls(argv[i]);
//   exit();
// }