
_jacob:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return a>b?b:a;
}


int main(int argc, char *argv[])
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
      11:	81 ec a8 02 00 00    	sub    $0x2a8,%esp
	
	
/// READ THE FILE 

    if(argc< 1){
      17:	8b 11                	mov    (%ecx),%edx
{
      19:	8b 41 04             	mov    0x4(%ecx),%eax
    if(argc< 1){
      1c:	85 d2                	test   %edx,%edx
      1e:	0f 8e 34 0a 00 00    	jle    a58 <main+0xa58>
	int NN=0, PP=0,TT=0,LL=0;
	float EE = 0.00001;
	// short arr[50];
	char c;
	int before_dot = 0;//, after_dot = 0;
	char * current  = (char *) malloc(20*sizeof(char));
      24:	83 ec 0c             	sub    $0xc,%esp
	filename=argv[1];
      27:	8b 58 04             	mov    0x4(%eax),%ebx
	char * current  = (char *) malloc(20*sizeof(char));
      2a:	6a 14                	push   $0x14
      2c:	e8 2f 11 00 00       	call   1160 <malloc>
	int k =0;
	int fd = open(filename, 0);
      31:	5e                   	pop    %esi
	char * current  = (char *) malloc(20*sizeof(char));
      32:	89 c7                	mov    %eax,%edi
	int NN=0, PP=0,TT=0,LL=0;
      34:	31 f6                	xor    %esi,%esi
	int fd = open(filename, 0);
      36:	58                   	pop    %eax
      37:	6a 00                	push   $0x0
      39:	53                   	push   %ebx
	int lct = 0;
      3a:	31 db                	xor    %ebx,%ebx
	int fd = open(filename, 0);
      3c:	e8 31 0d 00 00       	call   d72 <open>
	float EE = 0.00001;
      41:	d9 05 a0 12 00 00    	flds   0x12a0
	int fd = open(filename, 0);
      47:	89 85 88 fd ff ff    	mov    %eax,-0x278(%ebp)
      4d:	83 c4 10             	add    $0x10,%esp
      50:	c7 85 84 fd ff ff 32 	movl   $0x32,-0x27c(%ebp)
      57:	00 00 00 
	int NN=0, PP=0,TT=0,LL=0;
      5a:	c7 85 90 fd ff ff 00 	movl   $0x0,-0x270(%ebp)
      61:	00 00 00 
	int k =0;
      64:	31 c9                	xor    %ecx,%ecx
	int NN=0, PP=0,TT=0,LL=0;
      66:	c7 85 8c fd ff ff 00 	movl   $0x0,-0x274(%ebp)
      6d:	00 00 00 
	float EE = 0.00001;
      70:	d9 9d 6c fd ff ff    	fstps  -0x294(%ebp)
	int before_dot = 0;//, after_dot = 0;
      76:	c7 85 94 fd ff ff 00 	movl   $0x0,-0x26c(%ebp)
      7d:	00 00 00 
      80:	89 b5 98 fd ff ff    	mov    %esi,-0x268(%ebp)
      86:	eb 1b                	jmp    a3 <main+0xa3>
			}
			k = 0;
			continue;
		}	

		if (c== '.'){
      88:	80 fa 2e             	cmp    $0x2e,%dl
      8b:	0f 84 f7 02 00 00    	je     388 <main+0x388>
			continue;

		}	
		// arr[i]=c-'0';
		// printf(1,"%c ",c );
		current[k] = c ; 
      91:	88 10                	mov    %dl,(%eax)
		k++;
      93:	83 c1 01             	add    $0x1,%ecx
	for(int i=0; i<50; i++){
      96:	83 ad 84 fd ff ff 01 	subl   $0x1,-0x27c(%ebp)
      9d:	0f 84 09 03 00 00    	je     3ac <main+0x3ac>
		read(fd, &c, 1);
      a3:	8d 85 b3 fd ff ff    	lea    -0x24d(%ebp),%eax
      a9:	83 ec 04             	sub    $0x4,%esp
      ac:	89 8d 80 fd ff ff    	mov    %ecx,-0x280(%ebp)
      b2:	6a 01                	push   $0x1
      b4:	50                   	push   %eax
      b5:	ff b5 88 fd ff ff    	pushl  -0x278(%ebp)
      bb:	e8 8a 0c 00 00       	call   d4a <read>
		if (c=='\n' ){
      c0:	0f b6 95 b3 fd ff ff 	movzbl -0x24d(%ebp),%edx
      c7:	8b 8d 80 fd ff ff    	mov    -0x280(%ebp),%ecx
      cd:	83 c4 10             	add    $0x10,%esp
      d0:	8d 04 0f             	lea    (%edi,%ecx,1),%eax
      d3:	80 fa 0a             	cmp    $0xa,%dl
      d6:	75 b0                	jne    88 <main+0x88>
			int n = atoi(current);
      d8:	83 ec 0c             	sub    $0xc,%esp
			current[k] = '\0';
      db:	c6 00 00             	movb   $0x0,(%eax)
			lct += 1;
      de:	83 c3 01             	add    $0x1,%ebx
			int n = atoi(current);
      e1:	57                   	push   %edi
      e2:	e8 d9 0b 00 00       	call   cc0 <atoi>
			if (lct==1){
      e7:	83 c4 10             	add    $0x10,%esp
      ea:	83 fb 01             	cmp    $0x1,%ebx
      ed:	0f 84 44 03 00 00    	je     437 <main+0x437>
			if (lct==2){
      f3:	83 fb 02             	cmp    $0x2,%ebx
      f6:	0f 84 e6 02 00 00    	je     3e2 <main+0x3e2>
			if (lct==3){
      fc:	83 fb 03             	cmp    $0x3,%ebx
      ff:	0f 84 d0 02 00 00    	je     3d5 <main+0x3d5>
			if (lct==4){
     105:	83 fb 04             	cmp    $0x4,%ebx
     108:	0f 84 ba 02 00 00    	je     3c8 <main+0x3c8>
			if (lct == 5){
     10e:	83 fb 05             	cmp    $0x5,%ebx
     111:	0f 85 b7 02 00 00    	jne    3ce <main+0x3ce>
     117:	8b b5 98 fd ff ff    	mov    -0x268(%ebp),%esi
     11d:	89 85 58 fd ff ff    	mov    %eax,-0x2a8(%ebp)

		// read(fd, &c, 1);
	}	
  	close(fd);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	ff b5 88 fd ff ff    	pushl  -0x278(%ebp)
     12c:	e8 29 0c 00 00       	call   d5a <close>
     131:	8b bd 90 fd ff ff    	mov    -0x270(%ebp),%edi
     137:	83 c4 10             	add    $0x10,%esp
     13a:	39 f7                	cmp    %esi,%edi
     13c:	0f 4f fe             	cmovg  %esi,%edi





	int CommunicationPipes[(P+1)][2];
     13f:	8d 04 fd 1a 00 00 00 	lea    0x1a(,%edi,8),%eax
     146:	89 bd 50 fd ff ff    	mov    %edi,-0x2b0(%ebp)
     14c:	83 e0 f0             	and    $0xfffffff0,%eax
     14f:	29 c4                	sub    %eax,%esp
     151:	89 e3                	mov    %esp,%ebx
    
    int DifferencePipes[P+1][2];
     153:	29 c4                	sub    %eax,%esp
    int returnstatus;
    // printf(1," P is %d\n", P);
    // MAKE PIPES 
    for (int i = 0; i < P+1; ++i)
     155:	85 ff                	test   %edi,%edi
    int DifferencePipes[P+1][2];
     157:	89 e0                	mov    %esp,%eax
	int CommunicationPipes[(P+1)][2];
     159:	89 9d 70 fd ff ff    	mov    %ebx,-0x290(%ebp)
    int DifferencePipes[P+1][2];
     15f:	89 85 64 fd ff ff    	mov    %eax,-0x29c(%ebp)
    for (int i = 0; i < P+1; ++i)
     165:	78 4c                	js     1b3 <main+0x1b3>
     167:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
     16d:	31 ff                	xor    %edi,%edi
    {
      returnstatus = pipe(CommunicationPipes[i]);
     16f:	83 ec 0c             	sub    $0xc,%esp
     172:	53                   	push   %ebx
     173:	e8 ca 0b 00 00       	call   d42 <pipe>
      if (returnstatus == -1) {
     178:	83 c4 10             	add    $0x10,%esp
     17b:	83 f8 ff             	cmp    $0xffffffff,%eax
     17e:	0f 84 f8 08 00 00    	je     a7c <main+0xa7c>
      // if (returnstatus == -1) {
      //   printf(1,"Unable to create Communicator %d \n" ,i);
      //   return 1;
      // }
      
      returnstatus = pipe(DifferencePipes[i]);
     184:	83 ec 0c             	sub    $0xc,%esp
     187:	ff b5 98 fd ff ff    	pushl  -0x268(%ebp)
     18d:	e8 b0 0b 00 00       	call   d42 <pipe>
      if (returnstatus == -1) {
     192:	83 c4 10             	add    $0x10,%esp
     195:	83 f8 ff             	cmp    $0xffffffff,%eax
     198:	0f 84 cd 08 00 00    	je     a6b <main+0xa6b>
    for (int i = 0; i < P+1; ++i)
     19e:	83 c7 01             	add    $0x1,%edi
     1a1:	83 c3 08             	add    $0x8,%ebx
     1a4:	83 85 98 fd ff ff 08 	addl   $0x8,-0x268(%ebp)
     1ab:	39 bd 50 fd ff ff    	cmp    %edi,-0x2b0(%ebp)
     1b1:	7d bc                	jge    16f <main+0x16f>


	float diff;
	int i,j;
	float mean;
	float u[N][N];
     1b3:	89 f0                	mov    %esi,%eax
     1b5:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
     1bc:	8d 7e ff             	lea    -0x1(%esi),%edi
     1bf:	0f af c6             	imul   %esi,%eax
     1c2:	89 9d 90 fd ff ff    	mov    %ebx,-0x270(%ebp)
     1c8:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     1cf:	83 e0 f0             	and    $0xfffffff0,%eax
     1d2:	29 c4                	sub    %eax,%esp
     1d4:	89 e1                	mov    %esp,%ecx
	float w[N][N];
     1d6:	29 c4                	sub    %eax,%esp
     1d8:	89 d8                	mov    %ebx,%eax
     1da:	c1 eb 02             	shr    $0x2,%ebx

	int count=0;
	mean = 0.0;
	for (i = 0; i < N; i++){
     1dd:	85 f6                	test   %esi,%esi
	float u[N][N];
     1df:	89 8d 54 fd ff ff    	mov    %ecx,-0x2ac(%ebp)
	float w[N][N];
     1e5:	89 a5 48 fd ff ff    	mov    %esp,-0x2b8(%ebp)
	for (i = 0; i < N; i++){
     1eb:	0f 8e 6a 02 00 00    	jle    45b <main+0x45b>
     1f1:	83 e8 04             	sub    $0x4,%eax
     1f4:	db 85 8c fd ff ff    	fildl  -0x274(%ebp)
     1fa:	89 9d 94 fd ff ff    	mov    %ebx,-0x26c(%ebp)
     200:	0f af c3             	imul   %ebx,%eax
	mean = 0.0;
     203:	d9 ee                	fldz   
     205:	d9 c9                	fxch   %st(1)
     207:	01 c8                	add    %ecx,%eax
	for (i = 0; i < N; i++){
     209:	31 c9                	xor    %ecx,%ecx
     20b:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
		u[i][0] = u[i][N-1] = u[0][i] = T;
     211:	8b 85 94 fd ff ff    	mov    -0x26c(%ebp),%eax
     217:	8b 95 54 fd ff ff    	mov    -0x2ac(%ebp),%edx
     21d:	0f af c1             	imul   %ecx,%eax
     220:	d9 14 8a             	fsts   (%edx,%ecx,4)
     223:	89 c3                	mov    %eax,%ebx
     225:	8d 04 38             	lea    (%eax,%edi,1),%eax
     228:	d9 14 82             	fsts   (%edx,%eax,4)
     22b:	8d 14 9a             	lea    (%edx,%ebx,4),%edx
		u[N-1][i] = 0.0;
     22e:	8b 9d 98 fd ff ff    	mov    -0x268(%ebp),%ebx
		u[i][0] = u[i][N-1] = u[0][i] = T;
     234:	d9 12                	fsts   (%edx)
		u[N-1][i] = 0.0;
     236:	d9 ee                	fldz   
     238:	d9 14 8b             	fsts   (%ebx,%ecx,4)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     23b:	d9 02                	flds   (%edx)
     23d:	8b 95 54 fd ff ff    	mov    -0x2ac(%ebp),%edx
     243:	d8 04 82             	fadds  (%edx,%eax,4)
     246:	d8 04 8a             	fadds  (%edx,%ecx,4)
	for (i = 0; i < N; i++){
     249:	83 c1 01             	add    $0x1,%ecx
     24c:	39 ce                	cmp    %ecx,%esi
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     24e:	de c1                	faddp  %st,%st(1)
     250:	de c2                	faddp  %st,%st(2)
	for (i = 0; i < N; i++){
     252:	75 bd                	jne    211 <main+0x211>
     254:	dd d8                	fstp   %st(0)
	}
	mean /= (4.0 * N);
     256:	89 b5 98 fd ff ff    	mov    %esi,-0x268(%ebp)

	// INITIALIZE 
	// for (i = 1; i < N-1; i++ )
	// 	for ( j= 1; j < N-1; j++) u[i][j] = mean;

	float f = (float) P; 
     25c:	8b 9d 50 fd ff ff    	mov    -0x2b0(%ebp),%ebx
	float sf = N/f;
	int share = (int) (sf + 0.999);
     262:	d9 bd a2 fd ff ff    	fnstcw -0x25e(%ebp)
	mean /= (4.0 * N);
     268:	db 85 98 fd ff ff    	fildl  -0x268(%ebp)
	int share = (int) (sf + 0.999);
     26e:	0f b7 85 a2 fd ff ff 	movzwl -0x25e(%ebp),%eax
	mean /= (4.0 * N);
     275:	d8 0d a8 12 00 00    	fmuls  0x12a8
	float f = (float) P; 
     27b:	89 9d 98 fd ff ff    	mov    %ebx,-0x268(%ebp)
	int share = (int) (sf + 0.999);
     281:	80 cc 0c             	or     $0xc,%ah

	for (int proc = 0 ; proc < P; proc++){
     284:	85 db                	test   %ebx,%ebx
	int share = (int) (sf + 0.999);
     286:	66 89 85 a0 fd ff ff 	mov    %ax,-0x260(%ebp)
	mean /= (4.0 * N);
     28d:	de f9                	fdivrp %st,%st(1)
     28f:	d9 9d a4 fd ff ff    	fstps  -0x25c(%ebp)
     295:	d9 85 a4 fd ff ff    	flds   -0x25c(%ebp)
	float f = (float) P; 
     29b:	db 85 98 fd ff ff    	fildl  -0x268(%ebp)
	float sf = N/f;
     2a1:	89 b5 98 fd ff ff    	mov    %esi,-0x268(%ebp)
     2a7:	db 85 98 fd ff ff    	fildl  -0x268(%ebp)
     2ad:	de f1                	fdivp  %st,%st(1)
	int share = (int) (sf + 0.999);
     2af:	dd 05 b0 12 00 00    	fldl   0x12b0
     2b5:	de c1                	faddp  %st,%st(1)
     2b7:	d9 ad a0 fd ff ff    	fldcw  -0x260(%ebp)
     2bd:	db 9d 80 fd ff ff    	fistpl -0x280(%ebp)
     2c3:	d9 ad a2 fd ff ff    	fldcw  -0x25e(%ebp)
	for (int proc = 0 ; proc < P; proc++){
     2c9:	0f 8e aa 02 00 00    	jle    579 <main+0x579>
     2cf:	31 db                	xor    %ebx,%ebx
     2d1:	eb 14                	jmp    2e7 <main+0x2e7>
     2d3:	90                   	nop
     2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     2d8:	83 c3 01             	add    $0x1,%ebx
     2db:	39 9d 50 fd ff ff    	cmp    %ebx,-0x2b0(%ebp)
     2e1:	0f 84 7b 01 00 00    	je     462 <main+0x462>
     2e7:	d9 9d 98 fd ff ff    	fstps  -0x268(%ebp)
		
		int pid = fork();
     2ed:	e8 38 0a 00 00       	call   d2a <fork>
		if (pid==0){
     2f2:	85 c0                	test   %eax,%eax
     2f4:	d9 85 98 fd ff ff    	flds   -0x268(%ebp)
     2fa:	75 dc                	jne    2d8 <main+0x2d8>
			
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     2fc:	8b 8d 80 fd ff ff    	mov    -0x280(%ebp),%ecx
     302:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     308:	89 9d 94 fd ff ff    	mov    %ebx,-0x26c(%ebp)
     30e:	0f af cb             	imul   %ebx,%ecx
     311:	0f af c1             	imul   %ecx,%eax
     314:	03 85 54 fd ff ff    	add    -0x2ac(%ebp),%eax
     31a:	89 cb                	mov    %ecx,%ebx
     31c:	89 85 8c fd ff ff    	mov    %eax,-0x274(%ebp)
     322:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
     328:	89 f0                	mov    %esi,%eax
     32a:	29 c8                	sub    %ecx,%eax
     32c:	89 85 88 fd ff ff    	mov    %eax,-0x278(%ebp)
    return a>b?b:a;
     332:	8b 95 88 fd ff ff    	mov    -0x278(%ebp),%edx
     338:	8b 85 80 fd ff ff    	mov    -0x280(%ebp),%eax
     33e:	39 c2                	cmp    %eax,%edx
     340:	0f 4e c2             	cmovle %edx,%eax
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     343:	8d 14 08             	lea    (%eax,%ecx,1),%edx
     346:	39 da                	cmp    %ebx,%edx
     348:	0f 8e 03 05 00 00    	jle    851 <main+0x851>
	        {
	            for (int j = 0; j < N; ++j)
     34e:	31 c0                	xor    %eax,%eax
     350:	89 8d 84 fd ff ff    	mov    %ecx,-0x27c(%ebp)
     356:	39 c6                	cmp    %eax,%esi
     358:	0f 8e d9 04 00 00    	jle    837 <main+0x837>
	            {
	                if (i>0 && j>0 && i < N-1 && j< N-1){
     35e:	39 df                	cmp    %ebx,%edi
     360:	0f 9f c1             	setg   %cl
     363:	85 db                	test   %ebx,%ebx
     365:	0f 9f c2             	setg   %dl
     368:	21 ca                	and    %ecx,%edx
     36a:	85 c0                	test   %eax,%eax
     36c:	0f 9f c1             	setg   %cl
     36f:	84 ca                	test   %cl,%dl
     371:	74 0d                	je     380 <main+0x380>
     373:	39 c7                	cmp    %eax,%edi
     375:	7e 09                	jle    380 <main+0x380>
	                    u[i][j] = mean;
     377:	8b 8d 98 fd ff ff    	mov    -0x268(%ebp),%ecx
     37d:	d9 14 81             	fsts   (%ecx,%eax,4)
	            for (int j = 0; j < N; ++j)
     380:	83 c0 01             	add    $0x1,%eax
     383:	eb d1                	jmp    356 <main+0x356>
     385:	8d 76 00             	lea    0x0(%esi),%esi
			before_dot = atoi(current);
     388:	83 ec 0c             	sub    $0xc,%esp
			current[k] = '\0';
     38b:	c6 00 00             	movb   $0x0,(%eax)
			before_dot = atoi(current);
     38e:	57                   	push   %edi
     38f:	e8 2c 09 00 00       	call   cc0 <atoi>
			continue;
     394:	83 c4 10             	add    $0x10,%esp
			k = 0;
     397:	31 c9                	xor    %ecx,%ecx
	for(int i=0; i<50; i++){
     399:	83 ad 84 fd ff ff 01 	subl   $0x1,-0x27c(%ebp)
			before_dot = atoi(current);
     3a0:	89 85 94 fd ff ff    	mov    %eax,-0x26c(%ebp)
	for(int i=0; i<50; i++){
     3a6:	0f 85 f7 fc ff ff    	jne    a3 <main+0xa3>
     3ac:	8b b5 98 fd ff ff    	mov    -0x268(%ebp),%esi
	int NN=0, PP=0,TT=0,LL=0;
     3b2:	c7 85 58 fd ff ff 00 	movl   $0x0,-0x2a8(%ebp)
     3b9:	00 00 00 
     3bc:	e9 62 fd ff ff       	jmp    123 <main+0x123>
     3c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
				TT = n;
     3c8:	89 85 8c fd ff ff    	mov    %eax,-0x274(%ebp)
			k = 0;
     3ce:	31 c9                	xor    %ecx,%ecx
     3d0:	e9 c1 fc ff ff       	jmp    96 <main+0x96>
				PP= n;
     3d5:	89 85 90 fd ff ff    	mov    %eax,-0x270(%ebp)
			k = 0;
     3db:	31 c9                	xor    %ecx,%ecx
     3dd:	e9 b4 fc ff ff       	jmp    96 <main+0x96>
				while(current[p]!= '\0' ){
     3e2:	0f be 07             	movsbl (%edi),%eax
     3e5:	84 c0                	test   %al,%al
     3e7:	74 5b                	je     444 <main+0x444>
				float after = 0.0 ;
     3e9:	d9 ee                	fldz   
				int p = 0;
     3eb:	31 f6                	xor    %esi,%esi
					int den = 10;
     3ed:	b9 0a 00 00 00       	mov    $0xa,%ecx
					after = after/10 + (((int) (current[p]-'0'))/(float) den);
     3f2:	d8 35 a4 12 00 00    	fdivs  0x12a4
     3f8:	83 e8 30             	sub    $0x30,%eax
					p+=1;
     3fb:	83 c6 01             	add    $0x1,%esi
					after = after/10 + (((int) (current[p]-'0'))/(float) den);
     3fe:	89 85 80 fd ff ff    	mov    %eax,-0x280(%ebp)
				while(current[p]!= '\0' ){
     404:	0f be 04 37          	movsbl (%edi,%esi,1),%eax
     408:	84 c0                	test   %al,%al
					after = after/10 + (((int) (current[p]-'0'))/(float) den);
     40a:	db 85 80 fd ff ff    	fildl  -0x280(%ebp)
     410:	89 8d 80 fd ff ff    	mov    %ecx,-0x280(%ebp)
     416:	db 85 80 fd ff ff    	fildl  -0x280(%ebp)
     41c:	de f9                	fdivrp %st,%st(1)
     41e:	de c1                	faddp  %st,%st(1)
				while(current[p]!= '\0' ){
     420:	74 24                	je     446 <main+0x446>
					for (int i = 0; i < p; ++i)
     422:	31 d2                	xor    %edx,%edx
					int den = 10;
     424:	b9 0a 00 00 00       	mov    $0xa,%ecx
						den = den * 10;
     429:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
					for (int i = 0; i < p; ++i)
     42c:	83 c2 01             	add    $0x1,%edx
						den = den * 10;
     42f:	01 c9                	add    %ecx,%ecx
					for (int i = 0; i < p; ++i)
     431:	39 d6                	cmp    %edx,%esi
     433:	75 f4                	jne    429 <main+0x429>
     435:	eb bb                	jmp    3f2 <main+0x3f2>
				NN = n ;
     437:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
			k = 0;
     43d:	31 c9                	xor    %ecx,%ecx
     43f:	e9 52 fc ff ff       	jmp    96 <main+0x96>
				float after = 0.0 ;
     444:	d9 ee                	fldz   
				EE = before_dot + after ;
     446:	db 85 94 fd ff ff    	fildl  -0x26c(%ebp)
			k = 0;
     44c:	31 c9                	xor    %ecx,%ecx
				EE = before_dot + after ;
     44e:	de c1                	faddp  %st,%st(1)
     450:	d9 9d 6c fd ff ff    	fstps  -0x294(%ebp)
     456:	e9 3b fc ff ff       	jmp    96 <main+0x96>
	mean = 0.0;
     45b:	d9 ee                	fldz   
     45d:	e9 f4 fd ff ff       	jmp    256 <main+0x256>
     462:	dd d8                	fstp   %st(0)
     464:	89 9d 94 fd ff ff    	mov    %ebx,-0x26c(%ebp)
	        exit();
		}

	}
	
	for (int i = 0; i < P; ++i){wait();}
     46a:	31 db                	xor    %ebx,%ebx
     46c:	e8 c9 08 00 00       	call   d3a <wait>
     471:	83 c3 01             	add    $0x1,%ebx
     474:	3b 9d 94 fd ff ff    	cmp    -0x26c(%ebp),%ebx
     47a:	75 f0                	jne    46c <main+0x46c>
     47c:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     482:	89 b5 8c fd ff ff    	mov    %esi,-0x274(%ebp)
     488:	31 db                	xor    %ebx,%ebx
     48a:	0f af 85 80 fd ff ff 	imul   -0x280(%ebp),%eax
     491:	c7 85 98 fd ff ff 00 	movl   $0x0,-0x268(%ebp)
     498:	00 00 00 
     49b:	89 bd 78 fd ff ff    	mov    %edi,-0x288(%ebp)
     4a1:	89 85 7c fd ff ff    	mov    %eax,-0x284(%ebp)
     4a7:	8b 85 54 fd ff ff    	mov    -0x2ac(%ebp),%eax
     4ad:	89 85 88 fd ff ff    	mov    %eax,-0x278(%ebp)
    return a>b?b:a;
     4b3:	8b 85 8c fd ff ff    	mov    -0x274(%ebp),%eax
     4b9:	8b 95 80 fd ff ff    	mov    -0x280(%ebp),%edx

	for (int proc = 0 ; proc < P; proc++){
		char * rd_msg[140];
		read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
     4bf:	89 df                	mov    %ebx,%edi
     4c1:	8b 8d 98 fd ff ff    	mov    -0x268(%ebp),%ecx
    return a>b?b:a;
     4c7:	39 d0                	cmp    %edx,%eax
     4c9:	0f 4e d0             	cmovle %eax,%edx
		read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
     4cc:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     4d2:	83 ec 04             	sub    $0x4,%esp
     4d5:	89 95 84 fd ff ff    	mov    %edx,-0x27c(%ebp)
     4db:	0f af c2             	imul   %edx,%eax
     4de:	50                   	push   %eax
     4df:	8d 85 b8 fd ff ff    	lea    -0x248(%ebp),%eax
     4e5:	50                   	push   %eax
     4e6:	8b 85 70 fd ff ff    	mov    -0x290(%ebp),%eax
     4ec:	ff 34 c8             	pushl  (%eax,%ecx,8)
     4ef:	e8 56 08 00 00       	call   d4a <read>
		float  * arr = (float *)rd_msg;
		for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     4f4:	8b 95 84 fd ff ff    	mov    -0x27c(%ebp),%edx
     4fa:	83 c4 10             	add    $0x10,%esp
     4fd:	8d 04 13             	lea    (%ebx,%edx,1),%eax
     500:	39 c3                	cmp    %eax,%ebx
     502:	89 85 84 fd ff ff    	mov    %eax,-0x27c(%ebp)
     508:	7d 34                	jge    53e <main+0x53e>
     50a:	8b 95 88 fd ff ff    	mov    -0x278(%ebp),%edx
     510:	8d 8d b8 fd ff ff    	lea    -0x248(%ebp),%ecx
        {
            for (int j = 0; j < N; ++j)
     516:	31 c0                	xor    %eax,%eax
     518:	85 f6                	test   %esi,%esi
     51a:	7e 0d                	jle    529 <main+0x529>
            {
                // if (i>0 && j>0 && i < N-1 && j< N-1){	
                	u[i][j] = arr[(i-proc*share)*N+j];
     51c:	d9 04 81             	flds   (%ecx,%eax,4)
     51f:	d9 1c 82             	fstps  (%edx,%eax,4)
            for (int j = 0; j < N; ++j)
     522:	83 c0 01             	add    $0x1,%eax
     525:	39 c6                	cmp    %eax,%esi
     527:	75 f3                	jne    51c <main+0x51c>
     529:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
		for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     52f:	83 c7 01             	add    $0x1,%edi
     532:	01 c1                	add    %eax,%ecx
     534:	01 c2                	add    %eax,%edx
     536:	3b bd 84 fd ff ff    	cmp    -0x27c(%ebp),%edi
     53c:	75 d8                	jne    516 <main+0x516>
     53e:	8b 8d 80 fd ff ff    	mov    -0x280(%ebp),%ecx
	for (int proc = 0 ; proc < P; proc++){
     544:	83 85 98 fd ff ff 01 	addl   $0x1,-0x268(%ebp)
     54b:	29 8d 8c fd ff ff    	sub    %ecx,-0x274(%ebp)
     551:	8b 85 98 fd ff ff    	mov    -0x268(%ebp),%eax
     557:	01 cb                	add    %ecx,%ebx
     559:	8b 8d 7c fd ff ff    	mov    -0x284(%ebp),%ecx
     55f:	01 8d 88 fd ff ff    	add    %ecx,-0x278(%ebp)
     565:	3b 85 94 fd ff ff    	cmp    -0x26c(%ebp),%eax
     56b:	0f 85 42 ff ff ff    	jne    4b3 <main+0x4b3>
     571:	8b bd 78 fd ff ff    	mov    -0x288(%ebp),%edi
     577:	eb 02                	jmp    57b <main+0x57b>
     579:	dd d8                	fstp   %st(0)
     57b:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     581:	89 bd 4c fd ff ff    	mov    %edi,-0x2b4(%ebp)
     587:	89 f7                	mov    %esi,%edi
     589:	0f af 85 80 fd ff ff 	imul   -0x280(%ebp),%eax
	int count=0;
     590:	c7 85 5c fd ff ff 00 	movl   $0x0,-0x2a4(%ebp)
     597:	00 00 00 
     59a:	89 85 60 fd ff ff    	mov    %eax,-0x2a0(%ebp)
	// 		for (j =1; j< N-1; j++) u[i][j] = w[i][j];
	// }
	for(;;){
		
		diff = 0.0;
		for (int proc = 0 ; proc < P; proc++){
     5a0:	8b 9d 50 fd ff ff    	mov    -0x2b0(%ebp),%ebx
		diff = 0.0;
     5a6:	c7 85 b4 fd ff ff 00 	movl   $0x0,-0x24c(%ebp)
     5ad:	00 00 00 
		for (int proc = 0 ; proc < P; proc++){
     5b0:	85 db                	test   %ebx,%ebx
     5b2:	0f 8e c8 02 00 00    	jle    880 <main+0x880>
     5b8:	31 f6                	xor    %esi,%esi
     5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			// printf(1,"Proc %d\n",proc );
			int pid = fork();
     5c0:	e8 65 07 00 00       	call   d2a <fork>
			if (pid==0){
     5c5:	85 c0                	test   %eax,%eax
     5c7:	0f 84 c2 02 00 00    	je     88f <main+0x88f>
		for (int proc = 0 ; proc < P; proc++){
     5cd:	83 c6 01             	add    $0x1,%esi
     5d0:	39 f3                	cmp    %esi,%ebx
     5d2:	75 ec                	jne    5c0 <main+0x5c0>
     5d4:	89 f0                	mov    %esi,%eax

		        exit();
			}
		}

		for (int i = 0; i < P; ++i)
     5d6:	31 db                	xor    %ebx,%ebx
     5d8:	89 b5 74 fd ff ff    	mov    %esi,-0x28c(%ebp)
     5de:	89 de                	mov    %ebx,%esi
     5e0:	89 c3                	mov    %eax,%ebx
     5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5e8:	83 c6 01             	add    $0x1,%esi
		{
			wait();
     5eb:	e8 4a 07 00 00       	call   d3a <wait>
		for (int i = 0; i < P; ++i)
     5f0:	39 de                	cmp    %ebx,%esi
     5f2:	75 f4                	jne    5e8 <main+0x5e8>
     5f4:	8b 85 54 fd ff ff    	mov    -0x2ac(%ebp),%eax
     5fa:	8b b5 4c fd ff ff    	mov    -0x2b4(%ebp),%esi
     600:	89 bd 7c fd ff ff    	mov    %edi,-0x284(%ebp)
     606:	c7 85 84 fd ff ff 00 	movl   $0x0,-0x27c(%ebp)
     60d:	00 00 00 
     610:	c7 85 88 fd ff ff 00 	movl   $0x0,-0x278(%ebp)
     617:	00 00 00 
     61a:	c7 85 68 fd ff ff 00 	movl   $0x0,-0x298(%ebp)
     621:	00 00 00 
     624:	89 85 78 fd ff ff    	mov    %eax,-0x288(%ebp)
     62a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return a>b?b:a;
     630:	8b 8d 7c fd ff ff    	mov    -0x284(%ebp),%ecx
     636:	8b 95 80 fd ff ff    	mov    -0x280(%ebp),%edx

		int diff_count = 0;
	    // Parent Does Co-Ordination
		for (int proc = 0 ; proc < P; proc++){
			char * rd_msg[140];
			read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
     63c:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     642:	8b 9d 84 fd ff ff    	mov    -0x27c(%ebp),%ebx
    return a>b?b:a;
     648:	39 d1                	cmp    %edx,%ecx
     64a:	0f 4e d1             	cmovle %ecx,%edx
			read(CommunicationPipes[proc][0],rd_msg,sizeof(float)*N*min(share,N-proc*share));
     64d:	83 ec 04             	sub    $0x4,%esp
     650:	8b 8d 88 fd ff ff    	mov    -0x278(%ebp),%ecx
     656:	0f af c2             	imul   %edx,%eax
     659:	89 95 98 fd ff ff    	mov    %edx,-0x268(%ebp)
     65f:	8d 95 b8 fd ff ff    	lea    -0x248(%ebp),%edx
     665:	50                   	push   %eax
     666:	52                   	push   %edx
     667:	8b 95 70 fd ff ff    	mov    -0x290(%ebp),%edx
     66d:	ff 34 ca             	pushl  (%edx,%ecx,8)
     670:	e8 d5 06 00 00       	call   d4a <read>
			float  * arr = (float *)rd_msg;
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     675:	8b 85 84 fd ff ff    	mov    -0x27c(%ebp),%eax
     67b:	8b 95 98 fd ff ff    	mov    -0x268(%ebp),%edx
     681:	83 c4 10             	add    $0x10,%esp
     684:	01 c2                	add    %eax,%edx
     686:	39 c2                	cmp    %eax,%edx
     688:	89 95 8c fd ff ff    	mov    %edx,-0x274(%ebp)
     68e:	7e 7f                	jle    70f <main+0x70f>
     690:	8d 85 b8 fd ff ff    	lea    -0x248(%ebp),%eax
     696:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
     69c:	8b 85 78 fd ff ff    	mov    -0x288(%ebp),%eax
     6a2:	89 85 94 fd ff ff    	mov    %eax,-0x26c(%ebp)
     6a8:	90                   	nop
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	        {
	            for (int j = 0; j < N; ++j)
     6b0:	31 c0                	xor    %eax,%eax
     6b2:	85 ff                	test   %edi,%edi
     6b4:	7e 3c                	jle    6f2 <main+0x6f2>
     6b6:	8d 76 00             	lea    0x0(%esi),%esi
     6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     6c0:	83 c0 01             	add    $0x1,%eax
     6c3:	39 c7                	cmp    %eax,%edi
     6c5:	74 2b                	je     6f2 <main+0x6f2>
	            {
	                if (i>0 && j>0 && i < N-1 && j< N-1){	
     6c7:	39 c6                	cmp    %eax,%esi
     6c9:	0f 9f c1             	setg   %cl
     6cc:	85 db                	test   %ebx,%ebx
     6ce:	0f 9f c2             	setg   %dl
     6d1:	84 d1                	test   %dl,%cl
     6d3:	74 eb                	je     6c0 <main+0x6c0>
     6d5:	39 de                	cmp    %ebx,%esi
     6d7:	7e e7                	jle    6c0 <main+0x6c0>
	                	u[i][j] = arr[(i-proc*share)*N+j];
     6d9:	8b 95 98 fd ff ff    	mov    -0x268(%ebp),%edx
     6df:	d9 04 82             	flds   (%edx,%eax,4)
     6e2:	8b 95 94 fd ff ff    	mov    -0x26c(%ebp),%edx
     6e8:	d9 1c 82             	fstps  (%edx,%eax,4)
	            for (int j = 0; j < N; ++j)
     6eb:	83 c0 01             	add    $0x1,%eax
     6ee:	39 c7                	cmp    %eax,%edi
     6f0:	75 d5                	jne    6c7 <main+0x6c7>
     6f2:	8b 8d 90 fd ff ff    	mov    -0x270(%ebp),%ecx
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     6f8:	83 c3 01             	add    $0x1,%ebx
     6fb:	01 8d 98 fd ff ff    	add    %ecx,-0x268(%ebp)
     701:	01 8d 94 fd ff ff    	add    %ecx,-0x26c(%ebp)
     707:	39 9d 8c fd ff ff    	cmp    %ebx,-0x274(%ebp)
     70d:	75 a1                	jne    6b0 <main+0x6b0>
	                }
	                
	            }
	        }

	        read(DifferencePipes[proc][0],rd_msg,sizeof(float));
     70f:	8d 85 b8 fd ff ff    	lea    -0x248(%ebp),%eax
     715:	83 ec 04             	sub    $0x4,%esp
     718:	8b 9d 88 fd ff ff    	mov    -0x278(%ebp),%ebx
     71e:	6a 04                	push   $0x4
     720:	50                   	push   %eax
     721:	8b 85 64 fd ff ff    	mov    -0x29c(%ebp),%eax
     727:	ff 34 d8             	pushl  (%eax,%ebx,8)
     72a:	e8 1b 06 00 00       	call   d4a <read>
			float  * darr = (float *)rd_msg;
			if (darr[0] <= E || count >L){
     72f:	d9 85 b8 fd ff ff    	flds   -0x248(%ebp)
     735:	83 c4 10             	add    $0x10,%esp
     738:	d9 85 6c fd ff ff    	flds   -0x294(%ebp)
     73e:	df e9                	fucomip %st(1),%st
     740:	dd d8                	fstp   %st(0)
     742:	73 0e                	jae    752 <main+0x752>
     744:	8b 9d 5c fd ff ff    	mov    -0x2a4(%ebp),%ebx
     74a:	39 9d 58 fd ff ff    	cmp    %ebx,-0x2a8(%ebp)
     750:	7d 07                	jge    759 <main+0x759>
	         		diff_count ++;
     752:	83 85 68 fd ff ff 01 	addl   $0x1,-0x298(%ebp)
		for (int proc = 0 ; proc < P; proc++){
     759:	83 85 88 fd ff ff 01 	addl   $0x1,-0x278(%ebp)
     760:	8b 8d 80 fd ff ff    	mov    -0x280(%ebp),%ecx
     766:	8b 85 88 fd ff ff    	mov    -0x278(%ebp),%eax
     76c:	29 8d 7c fd ff ff    	sub    %ecx,-0x284(%ebp)
     772:	01 8d 84 fd ff ff    	add    %ecx,-0x27c(%ebp)
     778:	8b 95 60 fd ff ff    	mov    -0x2a0(%ebp),%edx
     77e:	01 95 78 fd ff ff    	add    %edx,-0x288(%ebp)
     784:	3b 85 74 fd ff ff    	cmp    -0x28c(%ebp),%eax
     78a:	0f 85 a0 fe ff ff    	jne    630 <main+0x630>
	        }
	       

		}

	    count++;
     790:	83 85 5c fd ff ff 01 	addl   $0x1,-0x2a4(%ebp)
	     

		if(diff_count==P){//(diff<= E || count > L){ 
     797:	8b b5 68 fd ff ff    	mov    -0x298(%ebp),%esi
     79d:	39 b5 50 fd ff ff    	cmp    %esi,-0x2b0(%ebp)
     7a3:	0f 85 f7 fd ff ff    	jne    5a0 <main+0x5a0>
     7a9:	89 fe                	mov    %edi,%esi
     7ab:	8b bd 54 fd ff ff    	mov    -0x2ac(%ebp),%edi
		}
	
	}


	for(i =0; i <N; i++){
     7b1:	31 db                	xor    %ebx,%ebx
     7b3:	89 b5 98 fd ff ff    	mov    %esi,-0x268(%ebp)
     7b9:	89 fe                	mov    %edi,%esi
     7bb:	89 df                	mov    %ebx,%edi
     7bd:	39 bd 98 fd ff ff    	cmp    %edi,-0x268(%ebp)
     7c3:	0f 8e c4 02 00 00    	jle    a8d <main+0xa8d>
		for(j = 0; j<N; j++)
     7c9:	31 db                	xor    %ebx,%ebx
			printf(1,"%d ",((int)u[i][j]));
     7cb:	d9 04 9e             	flds   (%esi,%ebx,4)
     7ce:	d9 bd a2 fd ff ff    	fnstcw -0x25e(%ebp)
     7d4:	0f b7 85 a2 fd ff ff 	movzwl -0x25e(%ebp),%eax
     7db:	83 ec 04             	sub    $0x4,%esp
		for(j = 0; j<N; j++)
     7de:	83 c3 01             	add    $0x1,%ebx
			printf(1,"%d ",((int)u[i][j]));
     7e1:	80 cc 0c             	or     $0xc,%ah
     7e4:	66 89 85 a0 fd ff ff 	mov    %ax,-0x260(%ebp)
     7eb:	d9 ad a0 fd ff ff    	fldcw  -0x260(%ebp)
     7f1:	db 9d 9c fd ff ff    	fistpl -0x264(%ebp)
     7f7:	d9 ad a2 fd ff ff    	fldcw  -0x25e(%ebp)
     7fd:	8b 85 9c fd ff ff    	mov    -0x264(%ebp),%eax
     803:	50                   	push   %eax
     804:	68 76 12 00 00       	push   $0x1276
     809:	6a 01                	push   $0x1
     80b:	e8 f0 06 00 00       	call   f00 <printf>
		for(j = 0; j<N; j++)
     810:	83 c4 10             	add    $0x10,%esp
     813:	39 9d 98 fd ff ff    	cmp    %ebx,-0x268(%ebp)
     819:	75 b0                	jne    7cb <main+0x7cb>
		printf(1,"\n");
     81b:	50                   	push   %eax
     81c:	50                   	push   %eax
	for(i =0; i <N; i++){
     81d:	83 c7 01             	add    $0x1,%edi
		printf(1,"\n");
     820:	68 74 12 00 00       	push   $0x1274
     825:	6a 01                	push   $0x1
     827:	e8 d4 06 00 00       	call   f00 <printf>
     82c:	03 b5 90 fd ff ff    	add    -0x270(%ebp),%esi
     832:	83 c4 10             	add    $0x10,%esp
     835:	eb 86                	jmp    7bd <main+0x7bd>
     837:	8b 95 90 fd ff ff    	mov    -0x270(%ebp),%edx
     83d:	8b 8d 84 fd ff ff    	mov    -0x27c(%ebp),%ecx
			for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     843:	83 c3 01             	add    $0x1,%ebx
     846:	01 95 98 fd ff ff    	add    %edx,-0x268(%ebp)
     84c:	e9 e1 fa ff ff       	jmp    332 <main+0x332>
     851:	dd d8                	fstp   %st(0)
	        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
     853:	0f af 85 90 fd ff ff 	imul   -0x270(%ebp),%eax
     85a:	8b bd 94 fd ff ff    	mov    -0x26c(%ebp),%edi
     860:	52                   	push   %edx
     861:	50                   	push   %eax
     862:	8b 85 70 fd ff ff    	mov    -0x290(%ebp),%eax
     868:	ff b5 8c fd ff ff    	pushl  -0x274(%ebp)
     86e:	ff 74 f8 04          	pushl  0x4(%eax,%edi,8)
     872:	e8 db 04 00 00       	call   d52 <write>
	        exit();
     877:	e8 b6 04 00 00       	call   d32 <exit>
     87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		int diff_count = 0;
     880:	c7 85 68 fd ff ff 00 	movl   $0x0,-0x298(%ebp)
     887:	00 00 00 
     88a:	e9 01 ff ff ff       	jmp    790 <main+0x790>
				for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     88f:	8b 8d 80 fd ff ff    	mov    -0x280(%ebp),%ecx
     895:	89 f0                	mov    %esi,%eax
     897:	89 b5 74 fd ff ff    	mov    %esi,-0x28c(%ebp)
     89d:	89 fe                	mov    %edi,%esi
     89f:	8b bd 4c fd ff ff    	mov    -0x2b4(%ebp),%edi
     8a5:	89 cb                	mov    %ecx,%ebx
     8a7:	0f af d8             	imul   %eax,%ebx
     8aa:	89 f0                	mov    %esi,%eax
     8ac:	29 d8                	sub    %ebx,%eax
     8ae:	89 9d 78 fd ff ff    	mov    %ebx,-0x288(%ebp)
    return a>b?b:a;
     8b4:	39 c8                	cmp    %ecx,%eax
     8b6:	0f 4f c1             	cmovg  %ecx,%eax
     8b9:	89 85 7c fd ff ff    	mov    %eax,-0x284(%ebp)
				for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     8bf:	01 d8                	add    %ebx,%eax
     8c1:	39 d8                	cmp    %ebx,%eax
     8c3:	89 85 80 fd ff ff    	mov    %eax,-0x280(%ebp)
     8c9:	0f 8e 26 01 00 00    	jle    9f5 <main+0x9f5>
     8cf:	8b 8d 90 fd ff ff    	mov    -0x270(%ebp),%ecx
     8d5:	8d 83 ff ff ff 3f    	lea    0x3fffffff(%ebx),%eax
     8db:	89 da                	mov    %ebx,%edx
     8dd:	d9 85 b4 fd ff ff    	flds   -0x24c(%ebp)
     8e3:	c6 85 88 fd ff ff 00 	movb   $0x0,-0x278(%ebp)
     8ea:	0f af c1             	imul   %ecx,%eax
     8ed:	03 85 54 fd ff ff    	add    -0x2ac(%ebp),%eax
     8f3:	89 85 84 fd ff ff    	mov    %eax,-0x27c(%ebp)
     8f9:	89 c8                	mov    %ecx,%eax
     8fb:	89 f9                	mov    %edi,%ecx
     8fd:	0f af c3             	imul   %ebx,%eax
     900:	8b 9d 54 fd ff ff    	mov    -0x2ac(%ebp),%ebx
     906:	01 c3                	add    %eax,%ebx
     908:	03 85 48 fd ff ff    	add    -0x2b8(%ebp),%eax
     90e:	89 85 8c fd ff ff    	mov    %eax,-0x274(%ebp)
		            for (int j = 0; j < N; ++j)
     914:	85 f6                	test   %esi,%esi
     916:	8b 85 90 fd ff ff    	mov    -0x270(%ebp),%eax
     91c:	0f 8e 29 01 00 00    	jle    a4b <main+0xa4b>
     922:	01 d8                	add    %ebx,%eax
     924:	31 ff                	xor    %edi,%edi
     926:	89 95 94 fd ff ff    	mov    %edx,-0x26c(%ebp)
     92c:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
     932:	eb 02                	jmp    936 <main+0x936>
     934:	dd d8                	fstp   %st(0)
     936:	83 c7 01             	add    $0x1,%edi
     939:	39 fe                	cmp    %edi,%esi
     93b:	74 7c                	je     9b9 <main+0x9b9>
		                if (i>0 && j>0 && i < N-1 && j< N-1){
     93d:	39 f9                	cmp    %edi,%ecx
     93f:	8b 85 94 fd ff ff    	mov    -0x26c(%ebp),%eax
     945:	0f 9f 85 6c fd ff ff 	setg   -0x294(%ebp)
     94c:	0f b6 95 6c fd ff ff 	movzbl -0x294(%ebp),%edx
     953:	85 c0                	test   %eax,%eax
     955:	0f 9f c0             	setg   %al
     958:	21 d0                	and    %edx,%eax
     95a:	3b 8d 94 fd ff ff    	cmp    -0x26c(%ebp),%ecx
     960:	0f 9f 85 6c fd ff ff 	setg   -0x294(%ebp)
     967:	0f b6 95 6c fd ff ff 	movzbl -0x294(%ebp),%edx
     96e:	20 d0                	and    %dl,%al
     970:	74 c4                	je     936 <main+0x936>
	                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     972:	8b 95 84 fd ff ff    	mov    -0x27c(%ebp),%edx
     978:	d9 04 ba             	flds   (%edx,%edi,4)
     97b:	8b 95 98 fd ff ff    	mov    -0x268(%ebp),%edx
     981:	d8 04 ba             	fadds  (%edx,%edi,4)
     984:	8b 95 8c fd ff ff    	mov    -0x274(%ebp),%edx
     98a:	d8 44 bb fc          	fadds  -0x4(%ebx,%edi,4)
		                        u[i][j-1] + u[i][j+1])/4.0;
     98e:	d8 44 bb 04          	fadds  0x4(%ebx,%edi,4)
	                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     992:	d8 0d ac 12 00 00    	fmuls  0x12ac
     998:	d9 14 ba             	fsts   (%edx,%edi,4)
			                if( fabsm(w[i][j] - u[i][j]) > diff )
     99b:	d8 24 bb             	fsubs  (%ebx,%edi,4)
	if(a<0)
     99e:	d9 ee                	fldz   
     9a0:	df e9                	fucomip %st(1),%st
     9a2:	76 02                	jbe    9a6 <main+0x9a6>
	return -1*a;
     9a4:	d9 e0                	fchs   
			                if( fabsm(w[i][j] - u[i][j]) > diff )
     9a6:	db e9                	fucomi %st(1),%st
     9a8:	76 8a                	jbe    934 <main+0x934>
     9aa:	dd d9                	fstp   %st(1)
		            for (int j = 0; j < N; ++j)
     9ac:	83 c7 01             	add    $0x1,%edi
     9af:	88 85 88 fd ff ff    	mov    %al,-0x278(%ebp)
     9b5:	39 fe                	cmp    %edi,%esi
     9b7:	75 84                	jne    93d <main+0x93d>
     9b9:	8b 95 94 fd ff ff    	mov    -0x26c(%ebp),%edx
     9bf:	8b bd 90 fd ff ff    	mov    -0x270(%ebp),%edi
     9c5:	83 c2 01             	add    $0x1,%edx
     9c8:	01 bd 84 fd ff ff    	add    %edi,-0x27c(%ebp)
     9ce:	01 bd 8c fd ff ff    	add    %edi,-0x274(%ebp)
				for (int i = proc*share  ; i<min(share,N-proc*share)+proc*share; ++i)
     9d4:	3b 95 80 fd ff ff    	cmp    -0x280(%ebp),%edx
     9da:	8b 9d 98 fd ff ff    	mov    -0x268(%ebp),%ebx
     9e0:	0f 85 2e ff ff ff    	jne    914 <main+0x914>
     9e6:	80 bd 88 fd ff ff 00 	cmpb   $0x0,-0x278(%ebp)
     9ed:	0f 85 9f 00 00 00    	jne    a92 <main+0xa92>
     9f3:	dd d8                	fstp   %st(0)
		        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
     9f5:	8b b5 90 fd ff ff    	mov    -0x270(%ebp),%esi
		        send_msg = (char *) w[proc*share];
     9fb:	8b bd 78 fd ff ff    	mov    -0x288(%ebp),%edi
		        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
     a01:	8b 85 7c fd ff ff    	mov    -0x284(%ebp),%eax
     a07:	52                   	push   %edx
		        send_msg = (char *) w[proc*share];
     a08:	0f af fe             	imul   %esi,%edi
     a0b:	03 bd 48 fd ff ff    	add    -0x2b8(%ebp),%edi
		        write(CommunicationPipes[proc][1],send_msg, sizeof(float)*N*min(share,N-proc*share));
     a11:	0f af c6             	imul   %esi,%eax
     a14:	50                   	push   %eax
     a15:	8b 85 70 fd ff ff    	mov    -0x290(%ebp),%eax
     a1b:	57                   	push   %edi
     a1c:	8b bd 74 fd ff ff    	mov    -0x28c(%ebp),%edi
     a22:	ff 74 f8 04          	pushl  0x4(%eax,%edi,8)
     a26:	e8 27 03 00 00       	call   d52 <write>
		        write(DifferencePipes[proc][1],send_msg, sizeof(float));
     a2b:	8d 85 b4 fd ff ff    	lea    -0x24c(%ebp),%eax
     a31:	83 c4 0c             	add    $0xc,%esp
     a34:	6a 04                	push   $0x4
     a36:	50                   	push   %eax
     a37:	8b 85 64 fd ff ff    	mov    -0x29c(%ebp),%eax
     a3d:	ff 74 f8 04          	pushl  0x4(%eax,%edi,8)
     a41:	e8 0c 03 00 00       	call   d52 <write>
		        exit();
     a46:	e8 e7 02 00 00       	call   d32 <exit>
     a4b:	01 d8                	add    %ebx,%eax
     a4d:	89 85 98 fd ff ff    	mov    %eax,-0x268(%ebp)
     a53:	e9 67 ff ff ff       	jmp    9bf <main+0x9bf>
		printf(1,"Need type and input filename\n");
     a58:	50                   	push   %eax
     a59:	50                   	push   %eax
     a5a:	68 58 12 00 00       	push   $0x1258
     a5f:	6a 01                	push   $0x1
     a61:	e8 9a 04 00 00       	call   f00 <printf>
		exit();
     a66:	e8 c7 02 00 00       	call   d32 <exit>
        printf(1,"Unable to create Communicator %d \n" ,i);
     a6b:	51                   	push   %ecx
     a6c:	57                   	push   %edi
     a6d:	68 7c 12 00 00       	push   $0x127c
     a72:	6a 01                	push   $0x1
     a74:	e8 87 04 00 00       	call   f00 <printf>
        return 1;
     a79:	83 c4 10             	add    $0x10,%esp
	}
	exit();

}
     a7c:	8d 65 f0             	lea    -0x10(%ebp),%esp
     a7f:	b8 01 00 00 00       	mov    $0x1,%eax
     a84:	59                   	pop    %ecx
     a85:	5b                   	pop    %ebx
     a86:	5e                   	pop    %esi
     a87:	5f                   	pop    %edi
     a88:	5d                   	pop    %ebp
     a89:	8d 61 fc             	lea    -0x4(%ecx),%esp
     a8c:	c3                   	ret    
	exit();
     a8d:	e8 a0 02 00 00       	call   d32 <exit>
     a92:	d9 9d b4 fd ff ff    	fstps  -0x24c(%ebp)
     a98:	e9 58 ff ff ff       	jmp    9f5 <main+0x9f5>
     a9d:	66 90                	xchg   %ax,%ax
     a9f:	90                   	nop

00000aa0 <fabsm>:
float fabsm(float a){
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	d9 45 08             	flds   0x8(%ebp)
	if(a<0)
     aa6:	d9 ee                	fldz   
     aa8:	df e9                	fucomip %st(1),%st
     aaa:	77 04                	ja     ab0 <fabsm+0x10>
}
     aac:	5d                   	pop    %ebp
     aad:	c3                   	ret    
     aae:	66 90                	xchg   %ax,%ax
	return -1*a;
     ab0:	d9 e0                	fchs   
}
     ab2:	5d                   	pop    %ebp
     ab3:	c3                   	ret    
     ab4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ac0 <max>:
int max(int a,int b){
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	8b 55 08             	mov    0x8(%ebp),%edx
     ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
}
     ac9:	5d                   	pop    %ebp
    return a>b?a:b;
     aca:	39 d0                	cmp    %edx,%eax
     acc:	0f 4c c2             	cmovl  %edx,%eax
}
     acf:	c3                   	ret    

00000ad0 <min>:
int min(int a,int b){
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	8b 45 08             	mov    0x8(%ebp),%eax
     ad6:	8b 55 0c             	mov    0xc(%ebp),%edx
}
     ad9:	5d                   	pop    %ebp
    return a>b?b:a;
     ada:	39 d0                	cmp    %edx,%eax
     adc:	0f 4f c2             	cmovg  %edx,%eax
}
     adf:	c3                   	ret    

00000ae0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	53                   	push   %ebx
     ae4:	8b 45 08             	mov    0x8(%ebp),%eax
     ae7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aea:	89 c2                	mov    %eax,%edx
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     af0:	83 c1 01             	add    $0x1,%ecx
     af3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     af7:	83 c2 01             	add    $0x1,%edx
     afa:	84 db                	test   %bl,%bl
     afc:	88 5a ff             	mov    %bl,-0x1(%edx)
     aff:	75 ef                	jne    af0 <strcpy+0x10>
    ;
  return os;
}
     b01:	5b                   	pop    %ebx
     b02:	5d                   	pop    %ebp
     b03:	c3                   	ret    
     b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	53                   	push   %ebx
     b14:	8b 55 08             	mov    0x8(%ebp),%edx
     b17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b1a:	0f b6 02             	movzbl (%edx),%eax
     b1d:	0f b6 19             	movzbl (%ecx),%ebx
     b20:	84 c0                	test   %al,%al
     b22:	75 1c                	jne    b40 <strcmp+0x30>
     b24:	eb 2a                	jmp    b50 <strcmp+0x40>
     b26:	8d 76 00             	lea    0x0(%esi),%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b30:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b33:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b36:	83 c1 01             	add    $0x1,%ecx
     b39:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b3c:	84 c0                	test   %al,%al
     b3e:	74 10                	je     b50 <strcmp+0x40>
     b40:	38 d8                	cmp    %bl,%al
     b42:	74 ec                	je     b30 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b44:	29 d8                	sub    %ebx,%eax
}
     b46:	5b                   	pop    %ebx
     b47:	5d                   	pop    %ebp
     b48:	c3                   	ret    
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b50:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b52:	29 d8                	sub    %ebx,%eax
}
     b54:	5b                   	pop    %ebx
     b55:	5d                   	pop    %ebp
     b56:	c3                   	ret    
     b57:	89 f6                	mov    %esi,%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b60 <strlen>:

uint
strlen(const char *s)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b66:	80 39 00             	cmpb   $0x0,(%ecx)
     b69:	74 15                	je     b80 <strlen+0x20>
     b6b:	31 d2                	xor    %edx,%edx
     b6d:	8d 76 00             	lea    0x0(%esi),%esi
     b70:	83 c2 01             	add    $0x1,%edx
     b73:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b77:	89 d0                	mov    %edx,%eax
     b79:	75 f5                	jne    b70 <strlen+0x10>
    ;
  return n;
}
     b7b:	5d                   	pop    %ebp
     b7c:	c3                   	ret    
     b7d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b80:	31 c0                	xor    %eax,%eax
}
     b82:	5d                   	pop    %ebp
     b83:	c3                   	ret    
     b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	57                   	push   %edi
     b94:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b97:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9d:	89 d7                	mov    %edx,%edi
     b9f:	fc                   	cld    
     ba0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ba2:	89 d0                	mov    %edx,%eax
     ba4:	5f                   	pop    %edi
     ba5:	5d                   	pop    %ebp
     ba6:	c3                   	ret    
     ba7:	89 f6                	mov    %esi,%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <strchr>:

char*
strchr(const char *s, char c)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     bba:	0f b6 10             	movzbl (%eax),%edx
     bbd:	84 d2                	test   %dl,%dl
     bbf:	74 1d                	je     bde <strchr+0x2e>
    if(*s == c)
     bc1:	38 d3                	cmp    %dl,%bl
     bc3:	89 d9                	mov    %ebx,%ecx
     bc5:	75 0d                	jne    bd4 <strchr+0x24>
     bc7:	eb 17                	jmp    be0 <strchr+0x30>
     bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bd0:	38 ca                	cmp    %cl,%dl
     bd2:	74 0c                	je     be0 <strchr+0x30>
  for(; *s; s++)
     bd4:	83 c0 01             	add    $0x1,%eax
     bd7:	0f b6 10             	movzbl (%eax),%edx
     bda:	84 d2                	test   %dl,%dl
     bdc:	75 f2                	jne    bd0 <strchr+0x20>
      return (char*)s;
  return 0;
     bde:	31 c0                	xor    %eax,%eax
}
     be0:	5b                   	pop    %ebx
     be1:	5d                   	pop    %ebp
     be2:	c3                   	ret    
     be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <gets>:

char*
gets(char *buf, int max)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	57                   	push   %edi
     bf4:	56                   	push   %esi
     bf5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bf6:	31 f6                	xor    %esi,%esi
     bf8:	89 f3                	mov    %esi,%ebx
{
     bfa:	83 ec 1c             	sub    $0x1c,%esp
     bfd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c00:	eb 2f                	jmp    c31 <gets+0x41>
     c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c08:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c0b:	83 ec 04             	sub    $0x4,%esp
     c0e:	6a 01                	push   $0x1
     c10:	50                   	push   %eax
     c11:	6a 00                	push   $0x0
     c13:	e8 32 01 00 00       	call   d4a <read>
    if(cc < 1)
     c18:	83 c4 10             	add    $0x10,%esp
     c1b:	85 c0                	test   %eax,%eax
     c1d:	7e 1c                	jle    c3b <gets+0x4b>
      break;
    buf[i++] = c;
     c1f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c23:	83 c7 01             	add    $0x1,%edi
     c26:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c29:	3c 0a                	cmp    $0xa,%al
     c2b:	74 23                	je     c50 <gets+0x60>
     c2d:	3c 0d                	cmp    $0xd,%al
     c2f:	74 1f                	je     c50 <gets+0x60>
  for(i=0; i+1 < max; ){
     c31:	83 c3 01             	add    $0x1,%ebx
     c34:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c37:	89 fe                	mov    %edi,%esi
     c39:	7c cd                	jl     c08 <gets+0x18>
     c3b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c40:	c6 03 00             	movb   $0x0,(%ebx)
}
     c43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c46:	5b                   	pop    %ebx
     c47:	5e                   	pop    %esi
     c48:	5f                   	pop    %edi
     c49:	5d                   	pop    %ebp
     c4a:	c3                   	ret    
     c4b:	90                   	nop
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c50:	8b 75 08             	mov    0x8(%ebp),%esi
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	01 de                	add    %ebx,%esi
     c58:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c5a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c60:	5b                   	pop    %ebx
     c61:	5e                   	pop    %esi
     c62:	5f                   	pop    %edi
     c63:	5d                   	pop    %ebp
     c64:	c3                   	ret    
     c65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c70 <stat>:

int
stat(const char *n, struct stat *st)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c75:	83 ec 08             	sub    $0x8,%esp
     c78:	6a 00                	push   $0x0
     c7a:	ff 75 08             	pushl  0x8(%ebp)
     c7d:	e8 f0 00 00 00       	call   d72 <open>
  if(fd < 0)
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	85 c0                	test   %eax,%eax
     c87:	78 27                	js     cb0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c89:	83 ec 08             	sub    $0x8,%esp
     c8c:	ff 75 0c             	pushl  0xc(%ebp)
     c8f:	89 c3                	mov    %eax,%ebx
     c91:	50                   	push   %eax
     c92:	e8 f3 00 00 00       	call   d8a <fstat>
  /// ADDED

    // st->cid = fd->cid;

  ///
  close(fd);
     c97:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c9a:	89 c6                	mov    %eax,%esi
  close(fd);
     c9c:	e8 b9 00 00 00       	call   d5a <close>
  return r;
     ca1:	83 c4 10             	add    $0x10,%esp
}
     ca4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ca7:	89 f0                	mov    %esi,%eax
     ca9:	5b                   	pop    %ebx
     caa:	5e                   	pop    %esi
     cab:	5d                   	pop    %ebp
     cac:	c3                   	ret    
     cad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     cb0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     cb5:	eb ed                	jmp    ca4 <stat+0x34>
     cb7:	89 f6                	mov    %esi,%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <atoi>:

int
atoi(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	53                   	push   %ebx
     cc4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cc7:	0f be 11             	movsbl (%ecx),%edx
     cca:	8d 42 d0             	lea    -0x30(%edx),%eax
     ccd:	3c 09                	cmp    $0x9,%al
  n = 0;
     ccf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cd4:	77 1f                	ja     cf5 <atoi+0x35>
     cd6:	8d 76 00             	lea    0x0(%esi),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     ce0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     ce3:	83 c1 01             	add    $0x1,%ecx
     ce6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cea:	0f be 11             	movsbl (%ecx),%edx
     ced:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cf0:	80 fb 09             	cmp    $0x9,%bl
     cf3:	76 eb                	jbe    ce0 <atoi+0x20>
  return n;
}
     cf5:	5b                   	pop    %ebx
     cf6:	5d                   	pop    %ebp
     cf7:	c3                   	ret    
     cf8:	90                   	nop
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	56                   	push   %esi
     d04:	53                   	push   %ebx
     d05:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d08:	8b 45 08             	mov    0x8(%ebp),%eax
     d0b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d0e:	85 db                	test   %ebx,%ebx
     d10:	7e 14                	jle    d26 <memmove+0x26>
     d12:	31 d2                	xor    %edx,%edx
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d18:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d1c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d1f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d22:	39 d3                	cmp    %edx,%ebx
     d24:	75 f2                	jne    d18 <memmove+0x18>
  return vdst;
}
     d26:	5b                   	pop    %ebx
     d27:	5e                   	pop    %esi
     d28:	5d                   	pop    %ebp
     d29:	c3                   	ret    

00000d2a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d2a:	b8 01 00 00 00       	mov    $0x1,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <exit>:
SYSCALL(exit)
     d32:	b8 02 00 00 00       	mov    $0x2,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <wait>:
SYSCALL(wait)
     d3a:	b8 03 00 00 00       	mov    $0x3,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <pipe>:
SYSCALL(pipe)
     d42:	b8 04 00 00 00       	mov    $0x4,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <read>:
SYSCALL(read)
     d4a:	b8 05 00 00 00       	mov    $0x5,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <write>:
SYSCALL(write)
     d52:	b8 10 00 00 00       	mov    $0x10,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <close>:
SYSCALL(close)
     d5a:	b8 15 00 00 00       	mov    $0x15,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <kill>:
SYSCALL(kill)
     d62:	b8 06 00 00 00       	mov    $0x6,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <exec>:
SYSCALL(exec)
     d6a:	b8 07 00 00 00       	mov    $0x7,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <open>:
SYSCALL(open)
     d72:	b8 0f 00 00 00       	mov    $0xf,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <mknod>:
SYSCALL(mknod)
     d7a:	b8 11 00 00 00       	mov    $0x11,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <unlink>:
SYSCALL(unlink)
     d82:	b8 12 00 00 00       	mov    $0x12,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <fstat>:
SYSCALL(fstat)
     d8a:	b8 08 00 00 00       	mov    $0x8,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <link>:
SYSCALL(link)
     d92:	b8 13 00 00 00       	mov    $0x13,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <mkdir>:
SYSCALL(mkdir)
     d9a:	b8 14 00 00 00       	mov    $0x14,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <chdir>:
SYSCALL(chdir)
     da2:	b8 09 00 00 00       	mov    $0x9,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <dup>:
SYSCALL(dup)
     daa:	b8 0a 00 00 00       	mov    $0xa,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <getpid>:
SYSCALL(getpid)
     db2:	b8 0b 00 00 00       	mov    $0xb,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <sbrk>:
SYSCALL(sbrk)
     dba:	b8 0c 00 00 00       	mov    $0xc,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <sleep>:
SYSCALL(sleep)
     dc2:	b8 0d 00 00 00       	mov    $0xd,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <uptime>:
SYSCALL(uptime)
     dca:	b8 0e 00 00 00       	mov    $0xe,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <toggle>:
SYSCALL(toggle)
     dd2:	b8 16 00 00 00       	mov    $0x16,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <add>:
SYSCALL(add)
     dda:	b8 17 00 00 00       	mov    $0x17,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <ps>:
SYSCALL(ps)
     de2:	b8 18 00 00 00       	mov    $0x18,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <send>:
SYSCALL(send)
     dea:	b8 19 00 00 00       	mov    $0x19,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <recv>:
SYSCALL(recv)
     df2:	b8 1a 00 00 00       	mov    $0x1a,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    

00000dfa <send_multi>:
SYSCALL(send_multi)
     dfa:	b8 1b 00 00 00       	mov    $0x1b,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <print_count>:
SYSCALL(print_count)
     e02:	b8 1c 00 00 00       	mov    $0x1c,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <create_container>:
SYSCALL(create_container)
     e0a:	b8 1d 00 00 00       	mov    $0x1d,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <destroy_container>:
SYSCALL(destroy_container)
     e12:	b8 1e 00 00 00       	mov    $0x1e,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <join_container>:
SYSCALL(join_container)
     e1a:	b8 1f 00 00 00       	mov    $0x1f,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <leave_container>:
SYSCALL(leave_container)
     e22:	b8 20 00 00 00       	mov    $0x20,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <getcid>:
SYSCALL(getcid)
     e2a:	b8 21 00 00 00       	mov    $0x21,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <p_ctable>:
SYSCALL(p_ctable)
     e32:	b8 22 00 00 00       	mov    $0x22,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <sz_ctable>:
SYSCALL(sz_ctable)
     e3a:	b8 23 00 00 00       	mov    $0x23,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <scheduler_log_off>:
SYSCALL(scheduler_log_off)
     e42:	b8 25 00 00 00       	mov    $0x25,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <scheduler_log_on>:
SYSCALL(scheduler_log_on)
     e4a:	b8 24 00 00 00       	mov    $0x24,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    
     e52:	66 90                	xchg   %ax,%ax
     e54:	66 90                	xchg   %ax,%ax
     e56:	66 90                	xchg   %ax,%ax
     e58:	66 90                	xchg   %ax,%ax
     e5a:	66 90                	xchg   %ax,%ax
     e5c:	66 90                	xchg   %ax,%ax
     e5e:	66 90                	xchg   %ax,%ax

00000e60 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e69:	85 d2                	test   %edx,%edx
{
     e6b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     e6e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     e70:	79 76                	jns    ee8 <printint+0x88>
     e72:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e76:	74 70                	je     ee8 <printint+0x88>
    x = -xx;
     e78:	f7 d8                	neg    %eax
    neg = 1;
     e7a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     e81:	31 f6                	xor    %esi,%esi
     e83:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     e86:	eb 0a                	jmp    e92 <printint+0x32>
     e88:	90                   	nop
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     e90:	89 fe                	mov    %edi,%esi
     e92:	31 d2                	xor    %edx,%edx
     e94:	8d 7e 01             	lea    0x1(%esi),%edi
     e97:	f7 f1                	div    %ecx
     e99:	0f b6 92 c0 12 00 00 	movzbl 0x12c0(%edx),%edx
  }while((x /= base) != 0);
     ea0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     ea2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     ea5:	75 e9                	jne    e90 <printint+0x30>
  if(neg)
     ea7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     eaa:	85 c0                	test   %eax,%eax
     eac:	74 08                	je     eb6 <printint+0x56>
    buf[i++] = '-';
     eae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     eb3:	8d 7e 02             	lea    0x2(%esi),%edi
     eb6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     eba:	8b 7d c0             	mov    -0x40(%ebp),%edi
     ebd:	8d 76 00             	lea    0x0(%esi),%esi
     ec0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     ec3:	83 ec 04             	sub    $0x4,%esp
     ec6:	83 ee 01             	sub    $0x1,%esi
     ec9:	6a 01                	push   $0x1
     ecb:	53                   	push   %ebx
     ecc:	57                   	push   %edi
     ecd:	88 45 d7             	mov    %al,-0x29(%ebp)
     ed0:	e8 7d fe ff ff       	call   d52 <write>

  while(--i >= 0)
     ed5:	83 c4 10             	add    $0x10,%esp
     ed8:	39 de                	cmp    %ebx,%esi
     eda:	75 e4                	jne    ec0 <printint+0x60>
    putc(fd, buf[i]);
}
     edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     edf:	5b                   	pop    %ebx
     ee0:	5e                   	pop    %esi
     ee1:	5f                   	pop    %edi
     ee2:	5d                   	pop    %ebp
     ee3:	c3                   	ret    
     ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ee8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     eef:	eb 90                	jmp    e81 <printint+0x21>
     ef1:	eb 0d                	jmp    f00 <printf>
     ef3:	90                   	nop
     ef4:	90                   	nop
     ef5:	90                   	nop
     ef6:	90                   	nop
     ef7:	90                   	nop
     ef8:	90                   	nop
     ef9:	90                   	nop
     efa:	90                   	nop
     efb:	90                   	nop
     efc:	90                   	nop
     efd:	90                   	nop
     efe:	90                   	nop
     eff:	90                   	nop

00000f00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	57                   	push   %edi
     f04:	56                   	push   %esi
     f05:	53                   	push   %ebx
     f06:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f09:	8b 75 0c             	mov    0xc(%ebp),%esi
     f0c:	0f b6 1e             	movzbl (%esi),%ebx
     f0f:	84 db                	test   %bl,%bl
     f11:	0f 84 b3 00 00 00    	je     fca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     f17:	8d 45 10             	lea    0x10(%ebp),%eax
     f1a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     f1d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     f1f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f22:	eb 2f                	jmp    f53 <printf+0x53>
     f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f28:	83 f8 25             	cmp    $0x25,%eax
     f2b:	0f 84 a7 00 00 00    	je     fd8 <printf+0xd8>
  write(fd, &c, 1);
     f31:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f34:	83 ec 04             	sub    $0x4,%esp
     f37:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     f3a:	6a 01                	push   $0x1
     f3c:	50                   	push   %eax
     f3d:	ff 75 08             	pushl  0x8(%ebp)
     f40:	e8 0d fe ff ff       	call   d52 <write>
     f45:	83 c4 10             	add    $0x10,%esp
     f48:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     f4b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f4f:	84 db                	test   %bl,%bl
     f51:	74 77                	je     fca <printf+0xca>
    if(state == 0){
     f53:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     f55:	0f be cb             	movsbl %bl,%ecx
     f58:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f5b:	74 cb                	je     f28 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f5d:	83 ff 25             	cmp    $0x25,%edi
     f60:	75 e6                	jne    f48 <printf+0x48>
      if(c == 'd'){
     f62:	83 f8 64             	cmp    $0x64,%eax
     f65:	0f 84 05 01 00 00    	je     1070 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f6b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f71:	83 f9 70             	cmp    $0x70,%ecx
     f74:	74 72                	je     fe8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f76:	83 f8 73             	cmp    $0x73,%eax
     f79:	0f 84 99 00 00 00    	je     1018 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f7f:	83 f8 63             	cmp    $0x63,%eax
     f82:	0f 84 08 01 00 00    	je     1090 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f88:	83 f8 25             	cmp    $0x25,%eax
     f8b:	0f 84 ef 00 00 00    	je     1080 <printf+0x180>
  write(fd, &c, 1);
     f91:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f94:	83 ec 04             	sub    $0x4,%esp
     f97:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f9b:	6a 01                	push   $0x1
     f9d:	50                   	push   %eax
     f9e:	ff 75 08             	pushl  0x8(%ebp)
     fa1:	e8 ac fd ff ff       	call   d52 <write>
     fa6:	83 c4 0c             	add    $0xc,%esp
     fa9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     fac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     faf:	6a 01                	push   $0x1
     fb1:	50                   	push   %eax
     fb2:	ff 75 08             	pushl  0x8(%ebp)
     fb5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fb8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     fba:	e8 93 fd ff ff       	call   d52 <write>
  for(i = 0; fmt[i]; i++){
     fbf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     fc3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     fc6:	84 db                	test   %bl,%bl
     fc8:	75 89                	jne    f53 <printf+0x53>
    }
  }
}
     fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fcd:	5b                   	pop    %ebx
     fce:	5e                   	pop    %esi
     fcf:	5f                   	pop    %edi
     fd0:	5d                   	pop    %ebp
     fd1:	c3                   	ret    
     fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     fd8:	bf 25 00 00 00       	mov    $0x25,%edi
     fdd:	e9 66 ff ff ff       	jmp    f48 <printf+0x48>
     fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     fe8:	83 ec 0c             	sub    $0xc,%esp
     feb:	b9 10 00 00 00       	mov    $0x10,%ecx
     ff0:	6a 00                	push   $0x0
     ff2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     ff5:	8b 45 08             	mov    0x8(%ebp),%eax
     ff8:	8b 17                	mov    (%edi),%edx
     ffa:	e8 61 fe ff ff       	call   e60 <printint>
        ap++;
     fff:	89 f8                	mov    %edi,%eax
    1001:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1004:	31 ff                	xor    %edi,%edi
        ap++;
    1006:	83 c0 04             	add    $0x4,%eax
    1009:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    100c:	e9 37 ff ff ff       	jmp    f48 <printf+0x48>
    1011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1018:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    101b:	8b 08                	mov    (%eax),%ecx
        ap++;
    101d:	83 c0 04             	add    $0x4,%eax
    1020:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1023:	85 c9                	test   %ecx,%ecx
    1025:	0f 84 8e 00 00 00    	je     10b9 <printf+0x1b9>
        while(*s != 0){
    102b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    102e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1030:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1032:	84 c0                	test   %al,%al
    1034:	0f 84 0e ff ff ff    	je     f48 <printf+0x48>
    103a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    103d:	89 de                	mov    %ebx,%esi
    103f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1042:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1045:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1048:	83 ec 04             	sub    $0x4,%esp
          s++;
    104b:	83 c6 01             	add    $0x1,%esi
    104e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1051:	6a 01                	push   $0x1
    1053:	57                   	push   %edi
    1054:	53                   	push   %ebx
    1055:	e8 f8 fc ff ff       	call   d52 <write>
        while(*s != 0){
    105a:	0f b6 06             	movzbl (%esi),%eax
    105d:	83 c4 10             	add    $0x10,%esp
    1060:	84 c0                	test   %al,%al
    1062:	75 e4                	jne    1048 <printf+0x148>
    1064:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1067:	31 ff                	xor    %edi,%edi
    1069:	e9 da fe ff ff       	jmp    f48 <printf+0x48>
    106e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1070:	83 ec 0c             	sub    $0xc,%esp
    1073:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1078:	6a 01                	push   $0x1
    107a:	e9 73 ff ff ff       	jmp    ff2 <printf+0xf2>
    107f:	90                   	nop
  write(fd, &c, 1);
    1080:	83 ec 04             	sub    $0x4,%esp
    1083:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1086:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1089:	6a 01                	push   $0x1
    108b:	e9 21 ff ff ff       	jmp    fb1 <printf+0xb1>
        putc(fd, *ap);
    1090:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1093:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1096:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1098:	6a 01                	push   $0x1
        ap++;
    109a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    109d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    10a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    10a3:	50                   	push   %eax
    10a4:	ff 75 08             	pushl  0x8(%ebp)
    10a7:	e8 a6 fc ff ff       	call   d52 <write>
        ap++;
    10ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    10af:	83 c4 10             	add    $0x10,%esp
      state = 0;
    10b2:	31 ff                	xor    %edi,%edi
    10b4:	e9 8f fe ff ff       	jmp    f48 <printf+0x48>
          s = "(null)";
    10b9:	bb b8 12 00 00       	mov    $0x12b8,%ebx
        while(*s != 0){
    10be:	b8 28 00 00 00       	mov    $0x28,%eax
    10c3:	e9 72 ff ff ff       	jmp    103a <printf+0x13a>
    10c8:	66 90                	xchg   %ax,%ax
    10ca:	66 90                	xchg   %ax,%ax
    10cc:	66 90                	xchg   %ax,%ax
    10ce:	66 90                	xchg   %ax,%ax

000010d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d1:	a1 f0 15 00 00       	mov    0x15f0,%eax
{
    10d6:	89 e5                	mov    %esp,%ebp
    10d8:	57                   	push   %edi
    10d9:	56                   	push   %esi
    10da:	53                   	push   %ebx
    10db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    10de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    10e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10e8:	39 c8                	cmp    %ecx,%eax
    10ea:	8b 10                	mov    (%eax),%edx
    10ec:	73 32                	jae    1120 <free+0x50>
    10ee:	39 d1                	cmp    %edx,%ecx
    10f0:	72 04                	jb     10f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10f2:	39 d0                	cmp    %edx,%eax
    10f4:	72 32                	jb     1128 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10fc:	39 fa                	cmp    %edi,%edx
    10fe:	74 30                	je     1130 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1100:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1103:	8b 50 04             	mov    0x4(%eax),%edx
    1106:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1109:	39 f1                	cmp    %esi,%ecx
    110b:	74 3a                	je     1147 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    110d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    110f:	a3 f0 15 00 00       	mov    %eax,0x15f0
}
    1114:	5b                   	pop    %ebx
    1115:	5e                   	pop    %esi
    1116:	5f                   	pop    %edi
    1117:	5d                   	pop    %ebp
    1118:	c3                   	ret    
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1120:	39 d0                	cmp    %edx,%eax
    1122:	72 04                	jb     1128 <free+0x58>
    1124:	39 d1                	cmp    %edx,%ecx
    1126:	72 ce                	jb     10f6 <free+0x26>
{
    1128:	89 d0                	mov    %edx,%eax
    112a:	eb bc                	jmp    10e8 <free+0x18>
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1130:	03 72 04             	add    0x4(%edx),%esi
    1133:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1136:	8b 10                	mov    (%eax),%edx
    1138:	8b 12                	mov    (%edx),%edx
    113a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    113d:	8b 50 04             	mov    0x4(%eax),%edx
    1140:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1143:	39 f1                	cmp    %esi,%ecx
    1145:	75 c6                	jne    110d <free+0x3d>
    p->s.size += bp->s.size;
    1147:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    114a:	a3 f0 15 00 00       	mov    %eax,0x15f0
    p->s.size += bp->s.size;
    114f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1152:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1155:	89 10                	mov    %edx,(%eax)
}
    1157:	5b                   	pop    %ebx
    1158:	5e                   	pop    %esi
    1159:	5f                   	pop    %edi
    115a:	5d                   	pop    %ebp
    115b:	c3                   	ret    
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001160 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	56                   	push   %esi
    1165:	53                   	push   %ebx
    1166:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    116c:	8b 15 f0 15 00 00    	mov    0x15f0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1172:	8d 78 07             	lea    0x7(%eax),%edi
    1175:	c1 ef 03             	shr    $0x3,%edi
    1178:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    117b:	85 d2                	test   %edx,%edx
    117d:	0f 84 9d 00 00 00    	je     1220 <malloc+0xc0>
    1183:	8b 02                	mov    (%edx),%eax
    1185:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1188:	39 cf                	cmp    %ecx,%edi
    118a:	76 6c                	jbe    11f8 <malloc+0x98>
    118c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1192:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1197:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    119a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    11a1:	eb 0e                	jmp    11b1 <malloc+0x51>
    11a3:	90                   	nop
    11a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    11aa:	8b 48 04             	mov    0x4(%eax),%ecx
    11ad:	39 f9                	cmp    %edi,%ecx
    11af:	73 47                	jae    11f8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11b1:	39 05 f0 15 00 00    	cmp    %eax,0x15f0
    11b7:	89 c2                	mov    %eax,%edx
    11b9:	75 ed                	jne    11a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    11bb:	83 ec 0c             	sub    $0xc,%esp
    11be:	56                   	push   %esi
    11bf:	e8 f6 fb ff ff       	call   dba <sbrk>
  if(p == (char*)-1)
    11c4:	83 c4 10             	add    $0x10,%esp
    11c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    11ca:	74 1c                	je     11e8 <malloc+0x88>
  hp->s.size = nu;
    11cc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    11cf:	83 ec 0c             	sub    $0xc,%esp
    11d2:	83 c0 08             	add    $0x8,%eax
    11d5:	50                   	push   %eax
    11d6:	e8 f5 fe ff ff       	call   10d0 <free>
  return freep;
    11db:	8b 15 f0 15 00 00    	mov    0x15f0,%edx
      if((p = morecore(nunits)) == 0)
    11e1:	83 c4 10             	add    $0x10,%esp
    11e4:	85 d2                	test   %edx,%edx
    11e6:	75 c0                	jne    11a8 <malloc+0x48>
        return 0;
  }
}
    11e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    11eb:	31 c0                	xor    %eax,%eax
}
    11ed:	5b                   	pop    %ebx
    11ee:	5e                   	pop    %esi
    11ef:	5f                   	pop    %edi
    11f0:	5d                   	pop    %ebp
    11f1:	c3                   	ret    
    11f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    11f8:	39 cf                	cmp    %ecx,%edi
    11fa:	74 54                	je     1250 <malloc+0xf0>
        p->s.size -= nunits;
    11fc:	29 f9                	sub    %edi,%ecx
    11fe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1201:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1204:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1207:	89 15 f0 15 00 00    	mov    %edx,0x15f0
}
    120d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1210:	83 c0 08             	add    $0x8,%eax
}
    1213:	5b                   	pop    %ebx
    1214:	5e                   	pop    %esi
    1215:	5f                   	pop    %edi
    1216:	5d                   	pop    %ebp
    1217:	c3                   	ret    
    1218:	90                   	nop
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1220:	c7 05 f0 15 00 00 f4 	movl   $0x15f4,0x15f0
    1227:	15 00 00 
    122a:	c7 05 f4 15 00 00 f4 	movl   $0x15f4,0x15f4
    1231:	15 00 00 
    base.s.size = 0;
    1234:	b8 f4 15 00 00       	mov    $0x15f4,%eax
    1239:	c7 05 f8 15 00 00 00 	movl   $0x0,0x15f8
    1240:	00 00 00 
    1243:	e9 44 ff ff ff       	jmp    118c <malloc+0x2c>
    1248:	90                   	nop
    1249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1250:	8b 08                	mov    (%eax),%ecx
    1252:	89 0a                	mov    %ecx,(%edx)
    1254:	eb b1                	jmp    1207 <malloc+0xa7>
