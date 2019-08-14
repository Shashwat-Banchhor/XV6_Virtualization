
_user_send_recv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:


#define PROCS 8
int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
	if(argc< 2){
  14:	83 39 01             	cmpl   $0x1,(%ecx)
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
	if(argc< 2){
  1a:	0f 8e ae 01 00 00    	jle    1ce <main+0x1ce>
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[2];
  20:	8b 78 08             	mov    0x8(%eax),%edi
	int type = atoi(argv[1]);
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	ff 70 04             	pushl  0x4(%eax)
	filename=argv[2];
  29:	89 7d c0             	mov    %edi,-0x40(%ebp)
	int type = atoi(argv[1]);
  2c:	e8 1f 04 00 00       	call   450 <atoi>
	printf(1,"Type is %d and filename is %s\n",type, filename);
  31:	57                   	push   %edi
  32:	50                   	push   %eax
  33:	68 60 0a 00 00       	push   $0xa60
  38:	6a 01                	push   $0x1
	int type = atoi(argv[1]);
  3a:	89 45 bc             	mov    %eax,-0x44(%ebp)
	printf(1,"Type is %d and filename is %s\n",type, filename);
  3d:	e8 4e 06 00 00       	call   690 <printf>

	int tot_sum = 0;	
	float variance = 0.0;

	int size=1000;
	short arr[size];
  42:	81 ec c0 07 00 00    	sub    $0x7c0,%esp
  48:	89 e3                	mov    %esp,%ebx
	char c;
	int fd = open(filename, 0);
  4a:	51                   	push   %ecx
  4b:	51                   	push   %ecx
  4c:	6a 00                	push   $0x0
  4e:	57                   	push   %edi
  4f:	8d 7d df             	lea    -0x21(%ebp),%edi
	short arr[size];
  52:	89 5d d0             	mov    %ebx,-0x30(%ebp)
	int fd = open(filename, 0);
  55:	e8 a8 04 00 00       	call   502 <open>
  5a:	89 c6                	mov    %eax,%esi
  5c:	8d 83 d0 07 00 00    	lea    0x7d0(%ebx),%eax
  62:	83 c4 10             	add    $0x10,%esp
  65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  68:	90                   	nop
  69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	for(int i=0; i<size; i++){
		read(fd, &c, 1);
  70:	83 ec 04             	sub    $0x4,%esp
  73:	83 c3 02             	add    $0x2,%ebx
  76:	6a 01                	push   $0x1
  78:	57                   	push   %edi
  79:	56                   	push   %esi
  7a:	e8 5b 04 00 00       	call   4da <read>
		arr[i]=c-'0';
  7f:	66 0f be 45 df       	movsbw -0x21(%ebp),%ax
		read(fd, &c, 1);
  84:	83 c4 0c             	add    $0xc,%esp
		arr[i]=c-'0';
  87:	83 e8 30             	sub    $0x30,%eax
  8a:	66 89 43 fe          	mov    %ax,-0x2(%ebx)
		read(fd, &c, 1);
  8e:	6a 01                	push   $0x1
  90:	57                   	push   %edi
  91:	56                   	push   %esi
  92:	e8 43 04 00 00       	call   4da <read>
	for(int i=0; i<size; i++){
  97:	83 c4 10             	add    $0x10,%esp
  9a:	3b 5d d4             	cmp    -0x2c(%ebp),%ebx
  9d:	75 d1                	jne    70 <main+0x70>
	}	
  	close(fd);
  9f:	83 ec 0c             	sub    $0xc,%esp
  a2:	56                   	push   %esi
  	//----FILL THE CODE HERE for unicast sum and multicast variance

  	int pid = getpid();
	
	int cid;
	for (int i = 0; i < PROCS; ++i)
  a3:	31 f6                	xor    %esi,%esi
  	close(fd);
  a5:	e8 40 04 00 00       	call   4ea <close>
  	printf(1,"first elem %d\n", arr[0]);
  aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  ad:	83 c4 0c             	add    $0xc,%esp
  b0:	0f bf 00             	movswl (%eax),%eax
  b3:	50                   	push   %eax
  b4:	68 06 0a 00 00       	push   $0xa06
  b9:	6a 01                	push   $0x1
  bb:	e8 d0 05 00 00       	call   690 <printf>
  	int pid = getpid();
  c0:	e8 7d 04 00 00       	call   542 <getpid>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	89 c3                	mov    %eax,%ebx
	{
		cid = fork();
  ca:	e8 eb 03 00 00       	call   4ba <fork>
		if(cid==0){
  cf:	85 c0                	test   %eax,%eax
  d1:	8d 56 01             	lea    0x1(%esi),%edx
  d4:	0f 84 07 01 00 00    	je     1e1 <main+0x1e1>
	for (int i = 0; i < PROCS; ++i)
  da:	83 fa 08             	cmp    $0x8,%edx
  dd:	89 d6                	mov    %edx,%esi
  df:	75 e9                	jne    ca <main+0xca>
			exit();
		}
	}
	// U N I C A S T ///
	
	char *msg = (char *)malloc(MSGSIZE);
  e1:	83 ec 0c             	sub    $0xc,%esp
  e4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  e7:	8d 75 e0             	lea    -0x20(%ebp),%esi
  ea:	6a 08                	push   $0x8
  ec:	e8 ff 07 00 00       	call   8f0 <malloc>
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	89 c3                	mov    %eax,%ebx
  f6:	c7 45 cc 08 00 00 00 	movl   $0x8,-0x34(%ebp)
	int tot_sum = 0;	
  fd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int  myid;
	int  from;
	for (int i = 0; i < PROCS; ++i)
	{
		while(stat==-1){
				stat = recv(&myid,&from,msg);
 108:	83 ec 04             	sub    $0x4,%esp
 10b:	53                   	push   %ebx
 10c:	57                   	push   %edi
 10d:	56                   	push   %esi
 10e:	e8 6f 04 00 00       	call   582 <recv>
		while(stat==-1){
 113:	83 c4 10             	add    $0x10,%esp
 116:	83 f8 ff             	cmp    $0xffffffff,%eax
 119:	74 ed                	je     108 <main+0x108>
		}
		int psum = *(int *) msg;
 11b:	8b 03                	mov    (%ebx),%eax
		stat = -1;
		printf(1,"Sum recevied from %d is %d\n",from,psum );
 11d:	50                   	push   %eax
 11e:	ff 75 e4             	pushl  -0x1c(%ebp)
 121:	68 2d 0a 00 00       	push   $0xa2d
 126:	6a 01                	push   $0x1
 128:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 12b:	e8 60 05 00 00       	call   690 <printf>
		tot_sum += psum;
 130:	8b 45 d4             	mov    -0x2c(%ebp),%eax
	for (int i = 0; i < PROCS; ++i)
 133:	83 c4 10             	add    $0x10,%esp
		tot_sum += psum;
 136:	01 45 c4             	add    %eax,-0x3c(%ebp)
	for (int i = 0; i < PROCS; ++i)
 139:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
 13d:	75 c9                	jne    108 <main+0x108>
	}	
	
	int sum = 0;
 13f:	8b 75 cc             	mov    -0x34(%ebp),%esi

	for (int i = 0; i < PROCS; ++i)
 142:	31 ff                	xor    %edi,%edi
	int sum = 0;
 144:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
 14b:	90                   	nop
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	{
			int ps = 0;
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
 150:	8d 57 01             	lea    0x1(%edi),%edx
 153:	89 f0                	mov    %esi,%eax
 155:	81 c6 e8 03 00 00    	add    $0x3e8,%esi
 15b:	c1 f8 03             	sar    $0x3,%eax
 15e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 161:	89 f2                	mov    %esi,%edx
 163:	c1 fa 03             	sar    $0x3,%edx
 166:	39 c2                	cmp    %eax,%edx
 168:	7e 60                	jle    1ca <main+0x1ca>
 16a:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 16d:	8d 04 41             	lea    (%ecx,%eax,2),%eax
 170:	8d 1c 51             	lea    (%ecx,%edx,2),%ebx
			int ps = 0;
 173:	31 d2                	xor    %edx,%edx
 175:	8d 76 00             	lea    0x0(%esi),%esi
			{
				ps += arr[j];
 178:	0f bf 08             	movswl (%eax),%ecx
 17b:	83 c0 02             	add    $0x2,%eax
 17e:	01 ca                	add    %ecx,%edx
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
 180:	39 d8                	cmp    %ebx,%eax
 182:	75 f4                	jne    178 <main+0x178>
			}
			sum += ps;
			printf(1, "Sum of i : %d is %d \n",i,ps );
 184:	52                   	push   %edx
 185:	57                   	push   %edi
 186:	68 49 0a 00 00       	push   $0xa49
 18b:	6a 01                	push   $0x1
			sum += ps;
 18d:	01 55 c8             	add    %edx,-0x38(%ebp)
			printf(1, "Sum of i : %d is %d \n",i,ps );
 190:	e8 fb 04 00 00       	call   690 <printf>
 195:	8b 7d d4             	mov    -0x2c(%ebp),%edi
	for (int i = 0; i < PROCS; ++i)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	83 ff 08             	cmp    $0x8,%edi
 19e:	75 b0                	jne    150 <main+0x150>

	}	
	
	if(type==0 ){ //unicast sum
 1a0:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
 1a4:	0f 85 a0 00 00 00    	jne    24a <main+0x24a>
		printf(1,"Sum of array for file %s is %d and actual sum is %d\n", filename,tot_sum, sum);
 1aa:	83 ec 0c             	sub    $0xc,%esp
 1ad:	ff 75 c8             	pushl  -0x38(%ebp)
 1b0:	ff 75 c4             	pushl  -0x3c(%ebp)
 1b3:	ff 75 c0             	pushl  -0x40(%ebp)
 1b6:	68 80 0a 00 00       	push   $0xa80
 1bb:	6a 01                	push   $0x1
 1bd:	e8 ce 04 00 00       	call   690 <printf>
 1c2:	83 c4 20             	add    $0x20,%esp
	}
	else{ //mulicast variance
		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
	}
	exit();
 1c5:	e8 f8 02 00 00       	call   4c2 <exit>
			int ps = 0;
 1ca:	31 d2                	xor    %edx,%edx
 1cc:	eb b6                	jmp    184 <main+0x184>
		printf(1,"Need type and input filename\n");
 1ce:	53                   	push   %ebx
 1cf:	53                   	push   %ebx
 1d0:	68 e8 09 00 00       	push   $0x9e8
 1d5:	6a 01                	push   $0x1
 1d7:	e8 b4 04 00 00       	call   690 <printf>
		exit();
 1dc:	e8 e1 02 00 00       	call   4c2 <exit>
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
 1e1:	69 f6 e8 03 00 00    	imul   $0x3e8,%esi,%esi
			int psum2 = 0;
 1e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
 1ee:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
 1f4:	c1 fe 03             	sar    $0x3,%esi
 1f7:	c1 fa 03             	sar    $0x3,%edx
 1fa:	39 f2                	cmp    %esi,%edx
 1fc:	7e 21                	jle    21f <main+0x21f>
 1fe:	8b 7d d0             	mov    -0x30(%ebp),%edi
 201:	01 f6                	add    %esi,%esi
 203:	01 d2                	add    %edx,%edx
 205:	8d 0c 37             	lea    (%edi,%esi,1),%ecx
 208:	01 fa                	add    %edi,%edx
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				psum2 += arr[j];
 210:	0f bf 31             	movswl (%ecx),%esi
 213:	83 c1 02             	add    $0x2,%ecx
 216:	01 f0                	add    %esi,%eax
			for (int j = i*size/PROCS; j < (i+1)*size/PROCS; ++j)
 218:	39 d1                	cmp    %edx,%ecx
 21a:	75 f4                	jne    210 <main+0x210>
 21c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			printf(1,"The pid of child is %d\n",getpid() );
 21f:	e8 1e 03 00 00       	call   542 <getpid>
 224:	52                   	push   %edx
 225:	50                   	push   %eax
 226:	68 15 0a 00 00       	push   $0xa15
 22b:	6a 01                	push   $0x1
 22d:	e8 5e 04 00 00       	call   690 <printf>
			send(getpid(),pid,(char *)(&psum2));	
 232:	e8 0b 03 00 00       	call   542 <getpid>
 237:	8d 55 e4             	lea    -0x1c(%ebp),%edx
 23a:	83 c4 0c             	add    $0xc,%esp
 23d:	52                   	push   %edx
 23e:	53                   	push   %ebx
 23f:	50                   	push   %eax
 240:	e8 35 03 00 00       	call   57a <send>
			exit();
 245:	e8 78 02 00 00       	call   4c2 <exit>
		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
 24a:	6a 00                	push   $0x0
 24c:	ff 75 c0             	pushl  -0x40(%ebp)
 24f:	68 b8 0a 00 00       	push   $0xab8
 254:	6a 01                	push   $0x1
 256:	e8 35 04 00 00       	call   690 <printf>
 25b:	83 c4 10             	add    $0x10,%esp
 25e:	e9 62 ff ff ff       	jmp    1c5 <main+0x1c5>
 263:	66 90                	xchg   %ax,%ax
 265:	66 90                	xchg   %ax,%ax
 267:	66 90                	xchg   %ax,%ax
 269:	66 90                	xchg   %ax,%ax
 26b:	66 90                	xchg   %ax,%ax
 26d:	66 90                	xchg   %ax,%ax
 26f:	90                   	nop

00000270 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	89 c2                	mov    %eax,%edx
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	83 c1 01             	add    $0x1,%ecx
 283:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 287:	83 c2 01             	add    $0x1,%edx
 28a:	84 db                	test   %bl,%bl
 28c:	88 5a ff             	mov    %bl,-0x1(%edx)
 28f:	75 ef                	jne    280 <strcpy+0x10>
    ;
  return os;
}
 291:	5b                   	pop    %ebx
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2aa:	0f b6 02             	movzbl (%edx),%eax
 2ad:	0f b6 19             	movzbl (%ecx),%ebx
 2b0:	84 c0                	test   %al,%al
 2b2:	75 1c                	jne    2d0 <strcmp+0x30>
 2b4:	eb 2a                	jmp    2e0 <strcmp+0x40>
 2b6:	8d 76 00             	lea    0x0(%esi),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2c6:	83 c1 01             	add    $0x1,%ecx
 2c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 2cc:	84 c0                	test   %al,%al
 2ce:	74 10                	je     2e0 <strcmp+0x40>
 2d0:	38 d8                	cmp    %bl,%al
 2d2:	74 ec                	je     2c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 2d4:	29 d8                	sub    %ebx,%eax
}
 2d6:	5b                   	pop    %ebx
 2d7:	5d                   	pop    %ebp
 2d8:	c3                   	ret    
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2e2:	29 d8                	sub    %ebx,%eax
}
 2e4:	5b                   	pop    %ebx
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <strlen>:

uint
strlen(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f6:	80 39 00             	cmpb   $0x0,(%ecx)
 2f9:	74 15                	je     310 <strlen+0x20>
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
 300:	83 c2 01             	add    $0x1,%edx
 303:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 307:	89 d0                	mov    %edx,%eax
 309:	75 f5                	jne    300 <strlen+0x10>
    ;
  return n;
}
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 310:	31 c0                	xor    %eax,%eax
}
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 31a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 327:	8b 4d 10             	mov    0x10(%ebp),%ecx
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	89 d7                	mov    %edx,%edi
 32f:	fc                   	cld    
 330:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 332:	89 d0                	mov    %edx,%eax
 334:	5f                   	pop    %edi
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <strchr>:

char*
strchr(const char *s, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 34a:	0f b6 10             	movzbl (%eax),%edx
 34d:	84 d2                	test   %dl,%dl
 34f:	74 1d                	je     36e <strchr+0x2e>
    if(*s == c)
 351:	38 d3                	cmp    %dl,%bl
 353:	89 d9                	mov    %ebx,%ecx
 355:	75 0d                	jne    364 <strchr+0x24>
 357:	eb 17                	jmp    370 <strchr+0x30>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 360:	38 ca                	cmp    %cl,%dl
 362:	74 0c                	je     370 <strchr+0x30>
  for(; *s; s++)
 364:	83 c0 01             	add    $0x1,%eax
 367:	0f b6 10             	movzbl (%eax),%edx
 36a:	84 d2                	test   %dl,%dl
 36c:	75 f2                	jne    360 <strchr+0x20>
      return (char*)s;
  return 0;
 36e:	31 c0                	xor    %eax,%eax
}
 370:	5b                   	pop    %ebx
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <gets>:

char*
gets(char *buf, int max)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 386:	31 f6                	xor    %esi,%esi
 388:	89 f3                	mov    %esi,%ebx
{
 38a:	83 ec 1c             	sub    $0x1c,%esp
 38d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 390:	eb 2f                	jmp    3c1 <gets+0x41>
 392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 398:	8d 45 e7             	lea    -0x19(%ebp),%eax
 39b:	83 ec 04             	sub    $0x4,%esp
 39e:	6a 01                	push   $0x1
 3a0:	50                   	push   %eax
 3a1:	6a 00                	push   $0x0
 3a3:	e8 32 01 00 00       	call   4da <read>
    if(cc < 1)
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	85 c0                	test   %eax,%eax
 3ad:	7e 1c                	jle    3cb <gets+0x4b>
      break;
    buf[i++] = c;
 3af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3b3:	83 c7 01             	add    $0x1,%edi
 3b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 3b9:	3c 0a                	cmp    $0xa,%al
 3bb:	74 23                	je     3e0 <gets+0x60>
 3bd:	3c 0d                	cmp    $0xd,%al
 3bf:	74 1f                	je     3e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 3c1:	83 c3 01             	add    $0x1,%ebx
 3c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3c7:	89 fe                	mov    %edi,%esi
 3c9:	7c cd                	jl     398 <gets+0x18>
 3cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 3d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 3d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
 3db:	90                   	nop
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e0:	8b 75 08             	mov    0x8(%ebp),%esi
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	01 de                	add    %ebx,%esi
 3e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 3ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 3ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f0:	5b                   	pop    %ebx
 3f1:	5e                   	pop    %esi
 3f2:	5f                   	pop    %edi
 3f3:	5d                   	pop    %ebp
 3f4:	c3                   	ret    
 3f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <stat>:

int
stat(const char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 405:	83 ec 08             	sub    $0x8,%esp
 408:	6a 00                	push   $0x0
 40a:	ff 75 08             	pushl  0x8(%ebp)
 40d:	e8 f0 00 00 00       	call   502 <open>
  if(fd < 0)
 412:	83 c4 10             	add    $0x10,%esp
 415:	85 c0                	test   %eax,%eax
 417:	78 27                	js     440 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 419:	83 ec 08             	sub    $0x8,%esp
 41c:	ff 75 0c             	pushl  0xc(%ebp)
 41f:	89 c3                	mov    %eax,%ebx
 421:	50                   	push   %eax
 422:	e8 f3 00 00 00       	call   51a <fstat>
  /// ADDED

    // st->cid = fd->cid;

  ///
  close(fd);
 427:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 42a:	89 c6                	mov    %eax,%esi
  close(fd);
 42c:	e8 b9 00 00 00       	call   4ea <close>
  return r;
 431:	83 c4 10             	add    $0x10,%esp
}
 434:	8d 65 f8             	lea    -0x8(%ebp),%esp
 437:	89 f0                	mov    %esi,%eax
 439:	5b                   	pop    %ebx
 43a:	5e                   	pop    %esi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 440:	be ff ff ff ff       	mov    $0xffffffff,%esi
 445:	eb ed                	jmp    434 <stat+0x34>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <atoi>:

int
atoi(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 457:	0f be 11             	movsbl (%ecx),%edx
 45a:	8d 42 d0             	lea    -0x30(%edx),%eax
 45d:	3c 09                	cmp    $0x9,%al
  n = 0;
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 464:	77 1f                	ja     485 <atoi+0x35>
 466:	8d 76 00             	lea    0x0(%esi),%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 470:	8d 04 80             	lea    (%eax,%eax,4),%eax
 473:	83 c1 01             	add    $0x1,%ecx
 476:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 47a:	0f be 11             	movsbl (%ecx),%edx
 47d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 480:	80 fb 09             	cmp    $0x9,%bl
 483:	76 eb                	jbe    470 <atoi+0x20>
  return n;
}
 485:	5b                   	pop    %ebx
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	56                   	push   %esi
 494:	53                   	push   %ebx
 495:	8b 5d 10             	mov    0x10(%ebp),%ebx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 49e:	85 db                	test   %ebx,%ebx
 4a0:	7e 14                	jle    4b6 <memmove+0x26>
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 4b2:	39 d3                	cmp    %edx,%ebx
 4b4:	75 f2                	jne    4a8 <memmove+0x18>
  return vdst;
}
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    

000004ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ba:	b8 01 00 00 00       	mov    $0x1,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <exit>:
SYSCALL(exit)
 4c2:	b8 02 00 00 00       	mov    $0x2,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <wait>:
SYSCALL(wait)
 4ca:	b8 03 00 00 00       	mov    $0x3,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <pipe>:
SYSCALL(pipe)
 4d2:	b8 04 00 00 00       	mov    $0x4,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <read>:
SYSCALL(read)
 4da:	b8 05 00 00 00       	mov    $0x5,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <write>:
SYSCALL(write)
 4e2:	b8 10 00 00 00       	mov    $0x10,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <close>:
SYSCALL(close)
 4ea:	b8 15 00 00 00       	mov    $0x15,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kill>:
SYSCALL(kill)
 4f2:	b8 06 00 00 00       	mov    $0x6,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <exec>:
SYSCALL(exec)
 4fa:	b8 07 00 00 00       	mov    $0x7,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <open>:
SYSCALL(open)
 502:	b8 0f 00 00 00       	mov    $0xf,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mknod>:
SYSCALL(mknod)
 50a:	b8 11 00 00 00       	mov    $0x11,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <unlink>:
SYSCALL(unlink)
 512:	b8 12 00 00 00       	mov    $0x12,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <fstat>:
SYSCALL(fstat)
 51a:	b8 08 00 00 00       	mov    $0x8,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <link>:
SYSCALL(link)
 522:	b8 13 00 00 00       	mov    $0x13,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <mkdir>:
SYSCALL(mkdir)
 52a:	b8 14 00 00 00       	mov    $0x14,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <chdir>:
SYSCALL(chdir)
 532:	b8 09 00 00 00       	mov    $0x9,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <dup>:
SYSCALL(dup)
 53a:	b8 0a 00 00 00       	mov    $0xa,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <getpid>:
SYSCALL(getpid)
 542:	b8 0b 00 00 00       	mov    $0xb,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <sbrk>:
SYSCALL(sbrk)
 54a:	b8 0c 00 00 00       	mov    $0xc,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <sleep>:
SYSCALL(sleep)
 552:	b8 0d 00 00 00       	mov    $0xd,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <uptime>:
SYSCALL(uptime)
 55a:	b8 0e 00 00 00       	mov    $0xe,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <toggle>:
SYSCALL(toggle)
 562:	b8 16 00 00 00       	mov    $0x16,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <add>:
SYSCALL(add)
 56a:	b8 17 00 00 00       	mov    $0x17,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <ps>:
SYSCALL(ps)
 572:	b8 18 00 00 00       	mov    $0x18,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <send>:
SYSCALL(send)
 57a:	b8 19 00 00 00       	mov    $0x19,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <recv>:
SYSCALL(recv)
 582:	b8 1a 00 00 00       	mov    $0x1a,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <send_multi>:
SYSCALL(send_multi)
 58a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <print_count>:
SYSCALL(print_count)
 592:	b8 1c 00 00 00       	mov    $0x1c,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <create_container>:
SYSCALL(create_container)
 59a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <destroy_container>:
SYSCALL(destroy_container)
 5a2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <join_container>:
SYSCALL(join_container)
 5aa:	b8 1f 00 00 00       	mov    $0x1f,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <leave_container>:
SYSCALL(leave_container)
 5b2:	b8 20 00 00 00       	mov    $0x20,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <getcid>:
SYSCALL(getcid)
 5ba:	b8 21 00 00 00       	mov    $0x21,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <p_ctable>:
SYSCALL(p_ctable)
 5c2:	b8 22 00 00 00       	mov    $0x22,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <sz_ctable>:
SYSCALL(sz_ctable)
 5ca:	b8 23 00 00 00       	mov    $0x23,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <scheduler_log_off>:
SYSCALL(scheduler_log_off)
 5d2:	b8 25 00 00 00       	mov    $0x25,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <scheduler_log_on>:
SYSCALL(scheduler_log_on)
 5da:	b8 24 00 00 00       	mov    $0x24,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    
 5e2:	66 90                	xchg   %ax,%ax
 5e4:	66 90                	xchg   %ax,%ax
 5e6:	66 90                	xchg   %ax,%ax
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f9:	85 d2                	test   %edx,%edx
{
 5fb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 5fe:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 600:	79 76                	jns    678 <printint+0x88>
 602:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 606:	74 70                	je     678 <printint+0x88>
    x = -xx;
 608:	f7 d8                	neg    %eax
    neg = 1;
 60a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 611:	31 f6                	xor    %esi,%esi
 613:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 616:	eb 0a                	jmp    622 <printint+0x32>
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 620:	89 fe                	mov    %edi,%esi
 622:	31 d2                	xor    %edx,%edx
 624:	8d 7e 01             	lea    0x1(%esi),%edi
 627:	f7 f1                	div    %ecx
 629:	0f b6 92 e8 0a 00 00 	movzbl 0xae8(%edx),%edx
  }while((x /= base) != 0);
 630:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 632:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 635:	75 e9                	jne    620 <printint+0x30>
  if(neg)
 637:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 63a:	85 c0                	test   %eax,%eax
 63c:	74 08                	je     646 <printint+0x56>
    buf[i++] = '-';
 63e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 643:	8d 7e 02             	lea    0x2(%esi),%edi
 646:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 64a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 64d:	8d 76 00             	lea    0x0(%esi),%esi
 650:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 653:	83 ec 04             	sub    $0x4,%esp
 656:	83 ee 01             	sub    $0x1,%esi
 659:	6a 01                	push   $0x1
 65b:	53                   	push   %ebx
 65c:	57                   	push   %edi
 65d:	88 45 d7             	mov    %al,-0x29(%ebp)
 660:	e8 7d fe ff ff       	call   4e2 <write>

  while(--i >= 0)
 665:	83 c4 10             	add    $0x10,%esp
 668:	39 de                	cmp    %ebx,%esi
 66a:	75 e4                	jne    650 <printint+0x60>
    putc(fd, buf[i]);
}
 66c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66f:	5b                   	pop    %ebx
 670:	5e                   	pop    %esi
 671:	5f                   	pop    %edi
 672:	5d                   	pop    %ebp
 673:	c3                   	ret    
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 678:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 67f:	eb 90                	jmp    611 <printint+0x21>
 681:	eb 0d                	jmp    690 <printf>
 683:	90                   	nop
 684:	90                   	nop
 685:	90                   	nop
 686:	90                   	nop
 687:	90                   	nop
 688:	90                   	nop
 689:	90                   	nop
 68a:	90                   	nop
 68b:	90                   	nop
 68c:	90                   	nop
 68d:	90                   	nop
 68e:	90                   	nop
 68f:	90                   	nop

00000690 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 699:	8b 75 0c             	mov    0xc(%ebp),%esi
 69c:	0f b6 1e             	movzbl (%esi),%ebx
 69f:	84 db                	test   %bl,%bl
 6a1:	0f 84 b3 00 00 00    	je     75a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 6a7:	8d 45 10             	lea    0x10(%ebp),%eax
 6aa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 6ad:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 6af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6b2:	eb 2f                	jmp    6e3 <printf+0x53>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6b8:	83 f8 25             	cmp    $0x25,%eax
 6bb:	0f 84 a7 00 00 00    	je     768 <printf+0xd8>
  write(fd, &c, 1);
 6c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6c4:	83 ec 04             	sub    $0x4,%esp
 6c7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6ca:	6a 01                	push   $0x1
 6cc:	50                   	push   %eax
 6cd:	ff 75 08             	pushl  0x8(%ebp)
 6d0:	e8 0d fe ff ff       	call   4e2 <write>
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 6db:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6df:	84 db                	test   %bl,%bl
 6e1:	74 77                	je     75a <printf+0xca>
    if(state == 0){
 6e3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6e5:	0f be cb             	movsbl %bl,%ecx
 6e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6eb:	74 cb                	je     6b8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ed:	83 ff 25             	cmp    $0x25,%edi
 6f0:	75 e6                	jne    6d8 <printf+0x48>
      if(c == 'd'){
 6f2:	83 f8 64             	cmp    $0x64,%eax
 6f5:	0f 84 05 01 00 00    	je     800 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 701:	83 f9 70             	cmp    $0x70,%ecx
 704:	74 72                	je     778 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 706:	83 f8 73             	cmp    $0x73,%eax
 709:	0f 84 99 00 00 00    	je     7a8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 70f:	83 f8 63             	cmp    $0x63,%eax
 712:	0f 84 08 01 00 00    	je     820 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 718:	83 f8 25             	cmp    $0x25,%eax
 71b:	0f 84 ef 00 00 00    	je     810 <printf+0x180>
  write(fd, &c, 1);
 721:	8d 45 e7             	lea    -0x19(%ebp),%eax
 724:	83 ec 04             	sub    $0x4,%esp
 727:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 72b:	6a 01                	push   $0x1
 72d:	50                   	push   %eax
 72e:	ff 75 08             	pushl  0x8(%ebp)
 731:	e8 ac fd ff ff       	call   4e2 <write>
 736:	83 c4 0c             	add    $0xc,%esp
 739:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 73c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 73f:	6a 01                	push   $0x1
 741:	50                   	push   %eax
 742:	ff 75 08             	pushl  0x8(%ebp)
 745:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 748:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 74a:	e8 93 fd ff ff       	call   4e2 <write>
  for(i = 0; fmt[i]; i++){
 74f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 753:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 756:	84 db                	test   %bl,%bl
 758:	75 89                	jne    6e3 <printf+0x53>
    }
  }
}
 75a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 75d:	5b                   	pop    %ebx
 75e:	5e                   	pop    %esi
 75f:	5f                   	pop    %edi
 760:	5d                   	pop    %ebp
 761:	c3                   	ret    
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 768:	bf 25 00 00 00       	mov    $0x25,%edi
 76d:	e9 66 ff ff ff       	jmp    6d8 <printf+0x48>
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 778:	83 ec 0c             	sub    $0xc,%esp
 77b:	b9 10 00 00 00       	mov    $0x10,%ecx
 780:	6a 00                	push   $0x0
 782:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 785:	8b 45 08             	mov    0x8(%ebp),%eax
 788:	8b 17                	mov    (%edi),%edx
 78a:	e8 61 fe ff ff       	call   5f0 <printint>
        ap++;
 78f:	89 f8                	mov    %edi,%eax
 791:	83 c4 10             	add    $0x10,%esp
      state = 0;
 794:	31 ff                	xor    %edi,%edi
        ap++;
 796:	83 c0 04             	add    $0x4,%eax
 799:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 79c:	e9 37 ff ff ff       	jmp    6d8 <printf+0x48>
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7ab:	8b 08                	mov    (%eax),%ecx
        ap++;
 7ad:	83 c0 04             	add    $0x4,%eax
 7b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 7b3:	85 c9                	test   %ecx,%ecx
 7b5:	0f 84 8e 00 00 00    	je     849 <printf+0x1b9>
        while(*s != 0){
 7bb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 7be:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 7c0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 7c2:	84 c0                	test   %al,%al
 7c4:	0f 84 0e ff ff ff    	je     6d8 <printf+0x48>
 7ca:	89 75 d0             	mov    %esi,-0x30(%ebp)
 7cd:	89 de                	mov    %ebx,%esi
 7cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7d2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 7d5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7d8:	83 ec 04             	sub    $0x4,%esp
          s++;
 7db:	83 c6 01             	add    $0x1,%esi
 7de:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7e1:	6a 01                	push   $0x1
 7e3:	57                   	push   %edi
 7e4:	53                   	push   %ebx
 7e5:	e8 f8 fc ff ff       	call   4e2 <write>
        while(*s != 0){
 7ea:	0f b6 06             	movzbl (%esi),%eax
 7ed:	83 c4 10             	add    $0x10,%esp
 7f0:	84 c0                	test   %al,%al
 7f2:	75 e4                	jne    7d8 <printf+0x148>
 7f4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 7f7:	31 ff                	xor    %edi,%edi
 7f9:	e9 da fe ff ff       	jmp    6d8 <printf+0x48>
 7fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 800:	83 ec 0c             	sub    $0xc,%esp
 803:	b9 0a 00 00 00       	mov    $0xa,%ecx
 808:	6a 01                	push   $0x1
 80a:	e9 73 ff ff ff       	jmp    782 <printf+0xf2>
 80f:	90                   	nop
  write(fd, &c, 1);
 810:	83 ec 04             	sub    $0x4,%esp
 813:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 816:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 819:	6a 01                	push   $0x1
 81b:	e9 21 ff ff ff       	jmp    741 <printf+0xb1>
        putc(fd, *ap);
 820:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 823:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 826:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 828:	6a 01                	push   $0x1
        ap++;
 82a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 82d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 830:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 833:	50                   	push   %eax
 834:	ff 75 08             	pushl  0x8(%ebp)
 837:	e8 a6 fc ff ff       	call   4e2 <write>
        ap++;
 83c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 83f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 842:	31 ff                	xor    %edi,%edi
 844:	e9 8f fe ff ff       	jmp    6d8 <printf+0x48>
          s = "(null)";
 849:	bb e0 0a 00 00       	mov    $0xae0,%ebx
        while(*s != 0){
 84e:	b8 28 00 00 00       	mov    $0x28,%eax
 853:	e9 72 ff ff ff       	jmp    7ca <printf+0x13a>
 858:	66 90                	xchg   %ax,%ax
 85a:	66 90                	xchg   %ax,%ax
 85c:	66 90                	xchg   %ax,%ax
 85e:	66 90                	xchg   %ax,%ax

00000860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 860:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 861:	a1 98 0d 00 00       	mov    0xd98,%eax
{
 866:	89 e5                	mov    %esp,%ebp
 868:	57                   	push   %edi
 869:	56                   	push   %esi
 86a:	53                   	push   %ebx
 86b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 86e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 878:	39 c8                	cmp    %ecx,%eax
 87a:	8b 10                	mov    (%eax),%edx
 87c:	73 32                	jae    8b0 <free+0x50>
 87e:	39 d1                	cmp    %edx,%ecx
 880:	72 04                	jb     886 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 882:	39 d0                	cmp    %edx,%eax
 884:	72 32                	jb     8b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 886:	8b 73 fc             	mov    -0x4(%ebx),%esi
 889:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 88c:	39 fa                	cmp    %edi,%edx
 88e:	74 30                	je     8c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 890:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 893:	8b 50 04             	mov    0x4(%eax),%edx
 896:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 899:	39 f1                	cmp    %esi,%ecx
 89b:	74 3a                	je     8d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 89d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 89f:	a3 98 0d 00 00       	mov    %eax,0xd98
}
 8a4:	5b                   	pop    %ebx
 8a5:	5e                   	pop    %esi
 8a6:	5f                   	pop    %edi
 8a7:	5d                   	pop    %ebp
 8a8:	c3                   	ret    
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	39 d0                	cmp    %edx,%eax
 8b2:	72 04                	jb     8b8 <free+0x58>
 8b4:	39 d1                	cmp    %edx,%ecx
 8b6:	72 ce                	jb     886 <free+0x26>
{
 8b8:	89 d0                	mov    %edx,%eax
 8ba:	eb bc                	jmp    878 <free+0x18>
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8c0:	03 72 04             	add    0x4(%edx),%esi
 8c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c6:	8b 10                	mov    (%eax),%edx
 8c8:	8b 12                	mov    (%edx),%edx
 8ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8cd:	8b 50 04             	mov    0x4(%eax),%edx
 8d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8d3:	39 f1                	cmp    %esi,%ecx
 8d5:	75 c6                	jne    89d <free+0x3d>
    p->s.size += bp->s.size;
 8d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8da:	a3 98 0d 00 00       	mov    %eax,0xd98
    p->s.size += bp->s.size;
 8df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8e5:	89 10                	mov    %edx,(%eax)
}
 8e7:	5b                   	pop    %ebx
 8e8:	5e                   	pop    %esi
 8e9:	5f                   	pop    %edi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8fc:	8b 15 98 0d 00 00    	mov    0xd98,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 902:	8d 78 07             	lea    0x7(%eax),%edi
 905:	c1 ef 03             	shr    $0x3,%edi
 908:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 90b:	85 d2                	test   %edx,%edx
 90d:	0f 84 9d 00 00 00    	je     9b0 <malloc+0xc0>
 913:	8b 02                	mov    (%edx),%eax
 915:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 918:	39 cf                	cmp    %ecx,%edi
 91a:	76 6c                	jbe    988 <malloc+0x98>
 91c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 922:	bb 00 10 00 00       	mov    $0x1000,%ebx
 927:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 92a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 931:	eb 0e                	jmp    941 <malloc+0x51>
 933:	90                   	nop
 934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 938:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 93a:	8b 48 04             	mov    0x4(%eax),%ecx
 93d:	39 f9                	cmp    %edi,%ecx
 93f:	73 47                	jae    988 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 941:	39 05 98 0d 00 00    	cmp    %eax,0xd98
 947:	89 c2                	mov    %eax,%edx
 949:	75 ed                	jne    938 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 94b:	83 ec 0c             	sub    $0xc,%esp
 94e:	56                   	push   %esi
 94f:	e8 f6 fb ff ff       	call   54a <sbrk>
  if(p == (char*)-1)
 954:	83 c4 10             	add    $0x10,%esp
 957:	83 f8 ff             	cmp    $0xffffffff,%eax
 95a:	74 1c                	je     978 <malloc+0x88>
  hp->s.size = nu;
 95c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 95f:	83 ec 0c             	sub    $0xc,%esp
 962:	83 c0 08             	add    $0x8,%eax
 965:	50                   	push   %eax
 966:	e8 f5 fe ff ff       	call   860 <free>
  return freep;
 96b:	8b 15 98 0d 00 00    	mov    0xd98,%edx
      if((p = morecore(nunits)) == 0)
 971:	83 c4 10             	add    $0x10,%esp
 974:	85 d2                	test   %edx,%edx
 976:	75 c0                	jne    938 <malloc+0x48>
        return 0;
  }
}
 978:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 97b:	31 c0                	xor    %eax,%eax
}
 97d:	5b                   	pop    %ebx
 97e:	5e                   	pop    %esi
 97f:	5f                   	pop    %edi
 980:	5d                   	pop    %ebp
 981:	c3                   	ret    
 982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 988:	39 cf                	cmp    %ecx,%edi
 98a:	74 54                	je     9e0 <malloc+0xf0>
        p->s.size -= nunits;
 98c:	29 f9                	sub    %edi,%ecx
 98e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 991:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 994:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 997:	89 15 98 0d 00 00    	mov    %edx,0xd98
}
 99d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9a0:	83 c0 08             	add    $0x8,%eax
}
 9a3:	5b                   	pop    %ebx
 9a4:	5e                   	pop    %esi
 9a5:	5f                   	pop    %edi
 9a6:	5d                   	pop    %ebp
 9a7:	c3                   	ret    
 9a8:	90                   	nop
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 9b0:	c7 05 98 0d 00 00 9c 	movl   $0xd9c,0xd98
 9b7:	0d 00 00 
 9ba:	c7 05 9c 0d 00 00 9c 	movl   $0xd9c,0xd9c
 9c1:	0d 00 00 
    base.s.size = 0;
 9c4:	b8 9c 0d 00 00       	mov    $0xd9c,%eax
 9c9:	c7 05 a0 0d 00 00 00 	movl   $0x0,0xda0
 9d0:	00 00 00 
 9d3:	e9 44 ff ff ff       	jmp    91c <malloc+0x2c>
 9d8:	90                   	nop
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 9e0:	8b 08                	mov    (%eax),%ecx
 9e2:	89 0a                	mov    %ecx,(%edx)
 9e4:	eb b1                	jmp    997 <malloc+0xa7>
