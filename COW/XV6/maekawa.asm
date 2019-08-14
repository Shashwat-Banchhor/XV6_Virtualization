
_maekawa:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:



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
	char c;
	filename = "assig2a.inp";
	int fd = open(filename, 0);
	// printf(1,"123 %d \n",(fd));

	read(fd, &c, 1);
      11:	8d b5 67 ff ff ff    	lea    -0x99(%ebp),%esi
	// printf(1,"%d \n",((c)));

	num_P = 0;
      17:	31 ff                	xor    %edi,%edi
{
      19:	81 ec 14 01 00 00    	sub    $0x114,%esp
	create_container(7);
      1f:	6a 07                	push   $0x7
      21:	e8 b4 22 00 00       	call   22da <create_container>
	create_container(6);
      26:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
      2d:	e8 a8 22 00 00       	call   22da <create_container>
	int fd = open(filename, 0);
      32:	59                   	pop    %ecx
      33:	5b                   	pop    %ebx
      34:	6a 00                	push   $0x0
      36:	68 28 27 00 00       	push   $0x2728
      3b:	e8 02 22 00 00       	call   2242 <open>
	read(fd, &c, 1);
      40:	83 c4 0c             	add    $0xc,%esp
	int fd = open(filename, 0);
      43:	89 c3                	mov    %eax,%ebx
	read(fd, &c, 1);
      45:	6a 01                	push   $0x1
      47:	56                   	push   %esi
      48:	50                   	push   %eax
      49:	e8 cc 21 00 00       	call   221a <read>
	while((c-0)!=10){
      4e:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
      55:	83 c4 10             	add    $0x10,%esp
      58:	3c 0a                	cmp    $0xa,%al
      5a:	74 25                	je     81 <main+0x81>
      5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		num_P = num_P*10 + (c - '0');
		read(fd, &c, 1);
      60:	83 ec 04             	sub    $0x4,%esp
		num_P = num_P*10 + (c - '0');
      63:	8d 14 bf             	lea    (%edi,%edi,4),%edx
		read(fd, &c, 1);
      66:	6a 01                	push   $0x1
      68:	56                   	push   %esi
      69:	53                   	push   %ebx
		num_P = num_P*10 + (c - '0');
      6a:	8d 7c 50 d0          	lea    -0x30(%eax,%edx,2),%edi
		read(fd, &c, 1);
      6e:	e8 a7 21 00 00       	call   221a <read>
	while((c-0)!=10){
      73:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
      7a:	83 c4 10             	add    $0x10,%esp
      7d:	3c 0a                	cmp    $0xa,%al
      7f:	75 df                	jne    60 <main+0x60>
	}

	read(fd, &c, 1);
      81:	83 ec 04             	sub    $0x4,%esp
      84:	6a 01                	push   $0x1
      86:	56                   	push   %esi
      87:	53                   	push   %ebx
      88:	e8 8d 21 00 00       	call   221a <read>
	// printf(1,"%d \n",((c)));

	num_P1 = 0;
	while((c-0)!=10){
      8d:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
      94:	83 c4 10             	add    $0x10,%esp
      97:	3c 0a                	cmp    $0xa,%al
      99:	0f 84 24 05 00 00    	je     5c3 <main+0x5c3>
	num_P1 = 0;
      9f:	31 c9                	xor    %ecx,%ecx
      a1:	89 bd 54 ff ff ff    	mov    %edi,-0xac(%ebp)
      a7:	89 cf                	mov    %ecx,%edi
      a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		num_P1 = num_P1*10 + (c - '0');
		read(fd, &c, 1);
      b0:	83 ec 04             	sub    $0x4,%esp
		num_P1 = num_P1*10 + (c - '0');
      b3:	8d 14 bf             	lea    (%edi,%edi,4),%edx
		read(fd, &c, 1);
      b6:	6a 01                	push   $0x1
      b8:	56                   	push   %esi
      b9:	53                   	push   %ebx
		num_P1 = num_P1*10 + (c - '0');
      ba:	8d 7c 50 d0          	lea    -0x30(%eax,%edx,2),%edi
		read(fd, &c, 1);
      be:	e8 57 21 00 00       	call   221a <read>
	while((c-0)!=10){
      c3:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
      ca:	83 c4 10             	add    $0x10,%esp
      cd:	3c 0a                	cmp    $0xa,%al
      cf:	75 df                	jne    b0 <main+0xb0>
      d1:	89 bd 50 ff ff ff    	mov    %edi,-0xb0(%ebp)
      d7:	8b bd 54 ff ff ff    	mov    -0xac(%ebp),%edi
	}

	read(fd, &c, 1);
      dd:	83 ec 04             	sub    $0x4,%esp
      e0:	6a 01                	push   $0x1
      e2:	56                   	push   %esi
      e3:	53                   	push   %ebx
      e4:	e8 31 21 00 00       	call   221a <read>
	// printf(1,"%d \n",((c)));

	num_P2 = 0;
	while((c-0)!=10){
      e9:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
      f0:	83 c4 10             	add    $0x10,%esp
      f3:	3c 0a                	cmp    $0xa,%al
      f5:	0f 84 d7 04 00 00    	je     5d2 <main+0x5d2>
	num_P2 = 0;
      fb:	31 c9                	xor    %ecx,%ecx
      fd:	89 bd 54 ff ff ff    	mov    %edi,-0xac(%ebp)
     103:	89 cf                	mov    %ecx,%edi
     105:	8d 76 00             	lea    0x0(%esi),%esi
		num_P2 = num_P2*10 + (c - '0');
		read(fd, &c, 1);
     108:	83 ec 04             	sub    $0x4,%esp
		num_P2 = num_P2*10 + (c - '0');
     10b:	8d 14 bf             	lea    (%edi,%edi,4),%edx
		read(fd, &c, 1);
     10e:	6a 01                	push   $0x1
     110:	56                   	push   %esi
     111:	53                   	push   %ebx
		num_P2 = num_P2*10 + (c - '0');
     112:	8d 7c 50 d0          	lea    -0x30(%eax,%edx,2),%edi
		read(fd, &c, 1);
     116:	e8 ff 20 00 00       	call   221a <read>
	while((c-0)!=10){
     11b:	0f be 85 67 ff ff ff 	movsbl -0x99(%ebp),%eax
     122:	83 c4 10             	add    $0x10,%esp
     125:	3c 0a                	cmp    $0xa,%al
     127:	75 df                	jne    108 <main+0x108>
     129:	89 bd 34 ff ff ff    	mov    %edi,-0xcc(%ebp)
     12f:	8b bd 54 ff ff ff    	mov    -0xac(%ebp),%edi
	}

	read(fd, &c, 1);
     135:	83 ec 04             	sub    $0x4,%esp
     138:	6a 01                	push   $0x1
     13a:	56                   	push   %esi
     13b:	53                   	push   %ebx
     13c:	e8 d9 20 00 00       	call   221a <read>
	// printf(1,"%d \n",((c)));

	num_P3 = 0;
	int r;
	while((c-0)!=10){
     141:	83 c4 10             	add    $0x10,%esp
     144:	eb 1d                	jmp    163 <main+0x163>
     146:	8d 76 00             	lea    0x0(%esi),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		num_P3 = num_P3*10 + (c - '0');
		r = read(fd, &c, 1);
     150:	83 ec 04             	sub    $0x4,%esp
     153:	6a 01                	push   $0x1
     155:	56                   	push   %esi
     156:	53                   	push   %ebx
     157:	e8 be 20 00 00       	call   221a <read>
		// printf(1,"%d \n",((r)));		
		if(r == 0){
     15c:	83 c4 10             	add    $0x10,%esp
     15f:	85 c0                	test   %eax,%eax
     161:	74 09                	je     16c <main+0x16c>
	while((c-0)!=10){
     163:	80 bd 67 ff ff ff 0a 	cmpb   $0xa,-0x99(%ebp)
     16a:	75 e4                	jne    150 <main+0x150>
			break;
		}
	}
  	close(fd);
     16c:	83 ec 0c             	sub    $0xc,%esp
     16f:	53                   	push   %ebx
     170:	e8 b5 20 00 00       	call   222a <close>

	int N = 0;
	if(num_P == 4){
     175:	83 c4 10             	add    $0x10,%esp
     178:	83 ff 04             	cmp    $0x4,%edi
     17b:	0f 84 54 01 00 00    	je     2d5 <main+0x2d5>
		N=2;
	}
	else if(num_P == 9){
     181:	83 ff 09             	cmp    $0x9,%edi
     184:	0f 84 1b 01 00 00    	je     2a5 <main+0x2a5>
		N = 3;
	}
	else if(num_P == 16){
     18a:	83 ff 10             	cmp    $0x10,%edi
     18d:	0f 84 4e 04 00 00    	je     5e1 <main+0x5e1>
		N = 4;
	}
	else if(num_P == 25){
     193:	83 ff 19             	cmp    $0x19,%edi
		N = 5;
     196:	c7 85 4c ff ff ff 05 	movl   $0x5,-0xb4(%ebp)
     19d:	00 00 00 
	else if(num_P == 25){
     1a0:	0f 85 f5 1d 00 00    	jne    1f9b <main+0x1f9b>
		printf(1,"Wrong Input\n");
		exit();
	}
	// printf(1,"%d \n",(N));

	int p[N][N][2];
     1a6:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     1ac:	89 bd 54 ff ff ff    	mov    %edi,-0xac(%ebp)
     1b2:	89 c1                	mov    %eax,%ecx
     1b4:	8d 34 c5 00 00 00 00 	lea    0x0(,%eax,8),%esi
     1bb:	0f af c8             	imul   %eax,%ecx
     1be:	89 b5 48 ff ff ff    	mov    %esi,-0xb8(%ebp)

	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++){
			if(pipe(p[i][j])<0){
     1c4:	c1 ee 02             	shr    $0x2,%esi
     1c7:	89 b5 40 ff ff ff    	mov    %esi,-0xc0(%ebp)
	for(int i=0;i<N;i++){
     1cd:	31 f6                	xor    %esi,%esi
	int p[N][N][2];
     1cf:	8d 04 cd 12 00 00 00 	lea    0x12(,%ecx,8),%eax
     1d6:	89 8d 38 ff ff ff    	mov    %ecx,-0xc8(%ebp)
     1dc:	25 f0 03 00 00       	and    $0x3f0,%eax
     1e1:	29 c4                	sub    %eax,%esp
     1e3:	89 e2                	mov    %esp,%edx
     1e5:	89 95 44 ff ff ff    	mov    %edx,-0xbc(%ebp)
     1eb:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
		N = 5;
     1f1:	89 d7                	mov    %edx,%edi
     1f3:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
     1f6:	8d 76 00             	lea    0x0(%esi),%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			if(pipe(p[i][j])<0){
     200:	83 ec 0c             	sub    $0xc,%esp
     203:	57                   	push   %edi
     204:	e8 09 20 00 00       	call   2212 <pipe>
     209:	83 c4 10             	add    $0x10,%esp
     20c:	85 c0                	test   %eax,%eax
     20e:	0f 88 a4 00 00 00    	js     2b8 <main+0x2b8>
     214:	83 c7 08             	add    $0x8,%edi
		for(int j=0;j<N;j++){
     217:	39 df                	cmp    %ebx,%edi
     219:	75 e5                	jne    200 <main+0x200>
	for(int i=0;i<N;i++){
     21b:	83 c6 01             	add    $0x1,%esi
     21e:	39 b5 4c ff ff ff    	cmp    %esi,-0xb4(%ebp)
     224:	89 fa                	mov    %edi,%edx
     226:	75 c3                	jne    1eb <main+0x1eb>
				printf(1,"Pipe Not created\n");
				return(0);
			}
		}
	}
	struct msg mqueue[2*N -1];
     228:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     22e:	8b bd 54 ff ff ff    	mov    -0xac(%ebp),%edi
	int cid;
	// printf("%d\n",N);
	int wp,wb;
	int br =0;
	// int stored_pid[N][N];
	for(wp=0;wp<N;wp++){
     234:	31 db                	xor    %ebx,%ebx
	struct msg mqueue[2*N -1];
     236:	89 c8                	mov    %ecx,%eax
     238:	89 bd 3c ff ff ff    	mov    %edi,-0xc4(%ebp)
     23e:	01 c8                	add    %ecx,%eax
     240:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
     246:	c1 e0 04             	shl    $0x4,%eax
     249:	29 c4                	sub    %eax,%esp
     24b:	89 a5 30 ff ff ff    	mov    %esp,-0xd0(%ebp)
     251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		for(wb=0;wb<N;wb++){
     258:	31 ff                	xor    %edi,%edi
     25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			// printf("in%d\n",N);
			cid = fork();
     260:	e8 95 1f 00 00       	call   21fa <fork>
			if(cid == 0){
     265:	85 c0                	test   %eax,%eax
     267:	74 7b                	je     2e4 <main+0x2e4>
		for(wb=0;wb<N;wb++){
     269:	83 c7 01             	add    $0x1,%edi
     26c:	39 f7                	cmp    %esi,%edi
     26e:	75 f0                	jne    260 <main+0x260>
	for(wp=0;wp<N;wp++){
     270:	83 c3 01             	add    $0x1,%ebx
     273:	39 f3                	cmp    %esi,%ebx
     275:	75 e1                	jne    258 <main+0x258>
				}
			}
		}
	}
	else{
		join_container(6);
     277:	83 ec 0c             	sub    $0xc,%esp
		ps();
		for(int l=0;l<N;l++){
     27a:	31 db                	xor    %ebx,%ebx
		join_container(6);
     27c:	6a 06                	push   $0x6
     27e:	e8 67 20 00 00       	call   22ea <join_container>
		ps();
     283:	e8 2a 20 00 00       	call   22b2 <ps>
     288:	83 c4 10             	add    $0x10,%esp
			for(int m=0;m<N;m++){
     28b:	31 ff                	xor    %edi,%edi
     28d:	83 c7 01             	add    $0x1,%edi
				wait();
     290:	e8 75 1f 00 00       	call   220a <wait>
			for(int m=0;m<N;m++){
     295:	39 f7                	cmp    %esi,%edi
     297:	75 f4                	jne    28d <main+0x28d>
		for(int l=0;l<N;l++){
     299:	83 c3 01             	add    $0x1,%ebx
     29c:	39 f3                	cmp    %esi,%ebx
     29e:	75 eb                	jne    28b <main+0x28b>
     2a0:	e9 07 03 00 00       	jmp    5ac <main+0x5ac>
		N = 3;
     2a5:	c7 85 4c ff ff ff 03 	movl   $0x3,-0xb4(%ebp)
     2ac:	00 00 00 
     2af:	e9 f2 fe ff ff       	jmp    1a6 <main+0x1a6>
     2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				printf(1,"Pipe Not created\n");
     2b8:	83 ec 08             	sub    $0x8,%esp
     2bb:	68 41 27 00 00       	push   $0x2741
     2c0:	6a 01                	push   $0x1
     2c2:	e8 09 21 00 00       	call   23d0 <printf>
		// 	for(int m=0;m<N;m++){
		// 		waitpid(stored_pid[l][m],&returnstatus,0);
		// 	}
		// }
	}
     2c7:	8d 65 f0             	lea    -0x10(%ebp),%esp
     2ca:	31 c0                	xor    %eax,%eax
     2cc:	59                   	pop    %ecx
     2cd:	5b                   	pop    %ebx
     2ce:	5e                   	pop    %esi
     2cf:	5f                   	pop    %edi
     2d0:	5d                   	pop    %ebp
     2d1:	8d 61 fc             	lea    -0x4(%ecx),%esp
     2d4:	c3                   	ret    
		N=2;
     2d5:	c7 85 4c ff ff ff 02 	movl   $0x2,-0xb4(%ebp)
     2dc:	00 00 00 
     2df:	e9 c2 fe ff ff       	jmp    1a6 <main+0x1a6>
     2e4:	89 d9                	mov    %ebx,%ecx
     2e6:	89 bd 54 ff ff ff    	mov    %edi,-0xac(%ebp)
     2ec:	8b bd 3c ff ff ff    	mov    -0xc4(%ebp),%edi
				if (wp%2==0){
     2f2:	80 e1 01             	and    $0x1,%cl
     2f5:	89 9d 3c ff ff ff    	mov    %ebx,-0xc4(%ebp)
     2fb:	89 c3                	mov    %eax,%ebx
     2fd:	0f 85 ae 02 00 00    	jne    5b1 <main+0x5b1>
					join_container(6);
     303:	83 ec 0c             	sub    $0xc,%esp
     306:	6a 06                	push   $0x6
     308:	e8 dd 1f 00 00       	call   22ea <join_container>
     30d:	83 c4 10             	add    $0x10,%esp
		int uid = N*x + y;
     310:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
     316:	0f af c6             	imul   %esi,%eax
     319:	03 85 54 ff ff ff    	add    -0xac(%ebp),%eax
		if(uid < num_P1){
     31f:	3b 85 50 ff ff ff    	cmp    -0xb0(%ebp),%eax
		int uid = N*x + y;
     325:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
		if(uid < num_P1){
     32b:	0f 8d ab 03 00 00    	jge    6dc <main+0x6dc>
			if(num_P == num_P1){
     331:	3b bd 50 ff ff ff    	cmp    -0xb0(%ebp),%edi
     337:	0f 84 6f 02 00 00    	je     5ac <main+0x5ac>
			send_msg.i = x;
     33d:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
			int acq_lock[N][N];
     343:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     349:	89 9d 20 ff ff ff    	mov    %ebx,-0xe0(%ebp)
			for(int l=0;l<N;l++){
     34f:	c7 85 48 ff ff ff 00 	movl   $0x0,-0xb8(%ebp)
     356:	00 00 00 
     359:	89 f3                	mov    %esi,%ebx
						acq_lock[l][m] = 0;
     35b:	c7 85 34 ff ff ff 00 	movl   $0x0,-0xcc(%ebp)
     362:	00 00 00 
			send_msg.i = x;
     365:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
			send_msg.j = y;
     36b:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			int acq_lock[N][N];
     371:	c1 e1 02             	shl    $0x2,%ecx
     374:	89 8d 24 ff ff ff    	mov    %ecx,-0xdc(%ebp)
						acq_lock[l][m] = 0;
     37a:	c1 e9 02             	shr    $0x2,%ecx
     37d:	89 8d 4c ff ff ff    	mov    %ecx,-0xb4(%ebp)
			send_msg.j = y;
     383:	89 45 80             	mov    %eax,-0x80(%ebp)
			send_msg.ts = new_ts;
     386:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
     38c:	89 45 84             	mov    %eax,-0x7c(%ebp)
			int acq_lock[N][N];
     38f:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
     395:	89 b5 38 ff ff ff    	mov    %esi,-0xc8(%ebp)
     39b:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     3a2:	25 f0 01 00 00       	and    $0x1f0,%eax
     3a7:	29 c4                	sub    %eax,%esp
     3a9:	89 e7                	mov    %esp,%edi
			int grant_lock[N][N];
     3ab:	29 c4                	sub    %eax,%esp
     3ad:	89 e2                	mov    %esp,%edx
			int fail[N][N];
     3af:	29 c4                	sub    %eax,%esp
			int grant_lock[N][N];
     3b1:	89 95 10 ff ff ff    	mov    %edx,-0xf0(%ebp)
			int fail[N][N];
     3b7:	89 a5 14 ff ff ff    	mov    %esp,-0xec(%ebp)
     3bd:	89 d6                	mov    %edx,%esi
     3bf:	89 d8                	mov    %ebx,%eax
     3c1:	2b 85 38 ff ff ff    	sub    -0xc8(%ebp),%eax
	for(wp=0;wp<N;wp++){
     3c7:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
     3cd:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
     3d3:	90                   	nop
     3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
						acq_lock[l][m] = 1;
     3d8:	31 c9                	xor    %ecx,%ecx
     3da:	3b 85 50 ff ff ff    	cmp    -0xb0(%ebp),%eax
					grant_lock[l][m] = 0;
     3e0:	c7 04 16 00 00 00 00 	movl   $0x0,(%esi,%edx,1)
						acq_lock[l][m] = 1;
     3e7:	0f 9c c1             	setl   %cl
     3ea:	83 c0 01             	add    $0x1,%eax
     3ed:	89 0c 17             	mov    %ecx,(%edi,%edx,1)
     3f0:	83 c2 04             	add    $0x4,%edx
				for(int m=0;m<N;m++){
     3f3:	39 d8                	cmp    %ebx,%eax
     3f5:	75 e1                	jne    3d8 <main+0x3d8>
			for(int l=0;l<N;l++){
     3f7:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
     3fe:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
     404:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
     40a:	03 9d 2c ff ff ff    	add    -0xd4(%ebp),%ebx
     410:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
     416:	01 95 34 ff ff ff    	add    %edx,-0xcc(%ebp)
     41c:	3b 85 38 ff ff ff    	cmp    -0xc8(%ebp),%eax
     422:	75 9b                	jne    3bf <main+0x3bf>
     424:	8b b5 38 ff ff ff    	mov    -0xc8(%ebp),%esi
     42a:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
						my_break = 0;
     430:	31 d2                	xor    %edx,%edx
     432:	8b 8d 14 ff ff ff    	mov    -0xec(%ebp),%ecx
     438:	8b 9d 20 ff ff ff    	mov    -0xe0(%ebp),%ebx
     43e:	0f af c6             	imul   %esi,%eax
     441:	89 9d 50 ff ff ff    	mov    %ebx,-0xb0(%ebp)
     447:	01 f0                	add    %esi,%eax
     449:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
     450:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
			int my_break = 1;
     456:	b9 01 00 00 00       	mov    $0x1,%ecx
     45b:	0f af 85 3c ff ff ff 	imul   -0xc4(%ebp),%eax
     462:	01 f8                	add    %edi,%eax
     464:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
						my_break = 0;
     46a:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
			for(int l =0;l<N;l++){
     470:	31 c0                	xor    %eax,%eax
						my_break = 0;
     472:	83 3c 83 00          	cmpl   $0x0,(%ebx,%eax,4)
     476:	0f 44 ca             	cmove  %edx,%ecx
			for(int l =0;l<N;l++){
     479:	83 c0 01             	add    $0x1,%eax
     47c:	39 f0                	cmp    %esi,%eax
     47e:	75 f2                	jne    472 <main+0x472>
     480:	8b 9d 50 ff ff ff    	mov    -0xb0(%ebp),%ebx
						my_break = 0;
     486:	31 d2                	xor    %edx,%edx
					if(acq_lock[l][y] == 0){
     488:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     48e:	0f af c3             	imul   %ebx,%eax
     491:	03 85 54 ff ff ff    	add    -0xac(%ebp),%eax
						my_break = 0;
     497:	83 3c 87 00          	cmpl   $0x0,(%edi,%eax,4)
     49b:	0f 44 ca             	cmove  %edx,%ecx
			for(int l =0;l<N;l++){
     49e:	83 c3 01             	add    $0x1,%ebx
     4a1:	39 f3                	cmp    %esi,%ebx
     4a3:	75 e3                	jne    488 <main+0x488>
			if(my_break == 1){
     4a5:	83 f9 01             	cmp    $0x1,%ecx
     4a8:	89 8d 50 ff ff ff    	mov    %ecx,-0xb0(%ebp)
     4ae:	0f 84 f8 00 00 00    	je     5ac <main+0x5ac>
     4b4:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			int grant_send = 0;
     4ba:	89 8d 20 ff ff ff    	mov    %ecx,-0xe0(%ebp)
	int size = 0;
     4c0:	89 8d 38 ff ff ff    	mov    %ecx,-0xc8(%ebp)
			grant_ts = -1;
     4c6:	c7 85 24 ff ff ff ff 	movl   $0xffffffff,-0xdc(%ebp)
     4cd:	ff ff ff 
			grant_y = -1;
     4d0:	c7 85 18 ff ff ff ff 	movl   $0xffffffff,-0xe8(%ebp)
     4d7:	ff ff ff 
			grant_x = -1;
     4da:	c7 85 1c ff ff ff ff 	movl   $0xffffffff,-0xe4(%ebp)
     4e1:	ff ff ff 
     4e4:	8d 1c 00             	lea    (%eax,%eax,1),%ebx
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
     4e7:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
     4ed:	0f af 85 40 ff ff ff 	imul   -0xc0(%ebp),%eax
     4f4:	01 d8                	add    %ebx,%eax
     4f6:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
     4fc:	50                   	push   %eax
     4fd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
     503:	6a 10                	push   $0x10
     505:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
     50b:	50                   	push   %eax
     50c:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
     512:	ff 34 88             	pushl  (%eax,%ecx,4)
     515:	e8 00 1d 00 00       	call   221a <read>
				if(recv_msg.msg_type == 1){
     51a:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
     520:	83 c4 10             	add    $0x10,%esp
     523:	83 f8 01             	cmp    $0x1,%eax
     526:	0f 84 c4 00 00 00    	je     5f0 <main+0x5f0>
				else if(recv_msg.msg_type == 4){
     52c:	83 f8 04             	cmp    $0x4,%eax
     52f:	74 24                	je     555 <main+0x555>
				else if(recv_msg.msg_type == 5){
     531:	83 f8 05             	cmp    $0x5,%eax
     534:	0f 84 45 0d 00 00    	je     127f <main+0x127f>
				else if(recv_msg.msg_type == 7){
     53a:	83 f8 07             	cmp    $0x7,%eax
     53d:	0f 84 99 0c 00 00    	je     11dc <main+0x11dc>
				else if(recv_msg.msg_type == 2){
     543:	83 f8 02             	cmp    $0x2,%eax
     546:	0f 84 e8 0f 00 00    	je     1534 <main+0x1534>
				else if(recv_msg.msg_type == 3){
     54c:	83 f8 03             	cmp    $0x3,%eax
     54f:	0f 84 19 05 00 00    	je     a6e <main+0xa6e>
				for(int l =0;l<N;l++){
     555:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
				int my_break = 1;
     55b:	8b 8d 48 ff ff ff    	mov    -0xb8(%ebp),%ecx
     561:	b8 01 00 00 00       	mov    $0x1,%eax
							my_break = 0;
     566:	8b 1c 91             	mov    (%ecx,%edx,4),%ebx
     569:	85 db                	test   %ebx,%ebx
     56b:	bb 00 00 00 00       	mov    $0x0,%ebx
     570:	0f 44 c3             	cmove  %ebx,%eax
				for(int l =0;l<N;l++){
     573:	83 c2 01             	add    $0x1,%edx
     576:	39 f2                	cmp    %esi,%edx
     578:	75 ec                	jne    566 <main+0x566>
				for(int l =0;l<N;l++){
     57a:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
						if(acq_lock[l][y] == 0){
     580:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     586:	0f af ca             	imul   %edx,%ecx
     589:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
							my_break = 0;
     58f:	8b 0c 8f             	mov    (%edi,%ecx,4),%ecx
     592:	85 c9                	test   %ecx,%ecx
     594:	b9 00 00 00 00       	mov    $0x0,%ecx
     599:	0f 44 c1             	cmove  %ecx,%eax
				for(int l =0;l<N;l++){
     59c:	83 c2 01             	add    $0x1,%edx
     59f:	39 f2                	cmp    %esi,%edx
     5a1:	75 dd                	jne    580 <main+0x580>
				if(my_break == 1){
     5a3:	83 e8 01             	sub    $0x1,%eax
     5a6:	0f 85 50 ff ff ff    	jne    4fc <main+0x4fc>
				exit();
     5ac:	e8 51 1c 00 00       	call   2202 <exit>
					join_container(7);
     5b1:	83 ec 0c             	sub    $0xc,%esp
     5b4:	6a 07                	push   $0x7
     5b6:	e8 2f 1d 00 00       	call   22ea <join_container>
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	e9 4d fd ff ff       	jmp    310 <main+0x310>
	num_P1 = 0;
     5c3:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
     5ca:	00 00 00 
     5cd:	e9 0b fb ff ff       	jmp    dd <main+0xdd>
	num_P2 = 0;
     5d2:	c7 85 34 ff ff ff 00 	movl   $0x0,-0xcc(%ebp)
     5d9:	00 00 00 
     5dc:	e9 54 fb ff ff       	jmp    135 <main+0x135>
		N = 4;
     5e1:	c7 85 4c ff ff ff 04 	movl   $0x4,-0xb4(%ebp)
     5e8:	00 00 00 
     5eb:	e9 b6 fb ff ff       	jmp    1a6 <main+0x1a6>
     5f0:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
					if(grant_send == 0){
     5f6:	83 bd 20 ff ff ff 00 	cmpl   $0x0,-0xe0(%ebp)
     5fd:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
     603:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
     609:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
     60f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     615:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
     61b:	0f 84 f1 0b 00 00    	je     1212 <main+0x1212>
						if(recv_msg.ts > grant_ts){
     621:	8b 9d 34 ff ff ff    	mov    -0xcc(%ebp),%ebx
     627:	39 9d 24 ff ff ff    	cmp    %ebx,-0xdc(%ebp)
							for(int l =0;l<size;l++){
     62d:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
						if(recv_msg.ts > grant_ts){
     633:	0f 8d 19 02 00 00    	jge    852 <main+0x852>
							for(int l =0;l<size;l++){
     639:	89 f3                	mov    %esi,%ebx
     63b:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%ebp)
     641:	8b b5 38 ff ff ff    	mov    -0xc8(%ebp),%esi
     647:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
     64d:	8b bd 34 ff ff ff    	mov    -0xcc(%ebp),%edi
     653:	eb 12                	jmp    667 <main+0x667>
     655:	89 d1                	mov    %edx,%ecx
     657:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
     65a:	39 7c 08 0c          	cmp    %edi,0xc(%eax,%ecx,1)
     65e:	0f 8f 3c 13 00 00    	jg     19a0 <main+0x19a0>
							for(int l =0;l<size;l++){
     664:	83 c2 01             	add    $0x1,%edx
     667:	39 f2                	cmp    %esi,%edx
     669:	75 ea                	jne    655 <main+0x655>
     66b:	89 de                	mov    %ebx,%esi
     66d:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
     673:	8b 8d 2c ff ff ff    	mov    -0xd4(%ebp),%ecx
     679:	8b bd 0c ff ff ff    	mov    -0xf4(%ebp),%edi
     67f:	89 d8                	mov    %ebx,%eax
								size++;								
     681:	83 c3 01             	add    $0x1,%ebx
     684:	c1 e0 04             	shl    $0x4,%eax
     687:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
     68d:	89 9d 38 ff ff ff    	mov    %ebx,-0xc8(%ebp)
								mqueue[size].i = recv_msg.i;
     693:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
     696:	8b 8d 28 ff ff ff    	mov    -0xd8(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
     69c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].j = recv_msg.j;
     6a2:	89 48 08             	mov    %ecx,0x8(%eax)
								mqueue[size].ts = recv_msg.ts;
     6a5:	8b 8d 34 ff ff ff    	mov    -0xcc(%ebp),%ecx
     6ab:	89 48 0c             	mov    %ecx,0xc(%eax)
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
     6ae:	50                   	push   %eax
     6af:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
     6b5:	6a 10                	push   $0x10
     6b7:	8b 95 2c ff ff ff    	mov    -0xd4(%ebp),%edx
									send_msg.msg_type = 3;
     6bd:	c7 85 78 ff ff ff 03 	movl   $0x3,-0x88(%ebp)
     6c4:	00 00 00 
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
     6c7:	50                   	push   %eax
     6c8:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
     6ce:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
     6d5:	01 c0                	add    %eax,%eax
     6d7:	e9 1a 02 00 00       	jmp    8f6 <main+0x8f6>
		else if(uid < (num_P1 + num_P2)){
     6dc:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
     6e2:	03 85 50 ff ff ff    	add    -0xb0(%ebp),%eax
     6e8:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
     6ee:	39 d8                	cmp    %ebx,%eax
     6f0:	0f 8e 1a 02 00 00    	jle    910 <main+0x910>
			request_lock.j = y;
     6f6:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			request_lock.i = x;
     6fc:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
			request_lock.ts = new_ts;
     702:	89 5d 94             	mov    %ebx,-0x6c(%ebp)
			request_lock.msg_type = 1;
     705:	c7 45 88 01 00 00 00 	movl   $0x1,-0x78(%ebp)
			for(int j=0;j<N;j++){
     70c:	31 db                	xor    %ebx,%ebx
			request_lock.j = y;
     70e:	89 45 90             	mov    %eax,-0x70(%ebp)
     711:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
			request_lock.i = x;
     717:	89 4d 8c             	mov    %ecx,-0x74(%ebp)
     71a:	0f af c1             	imul   %ecx,%eax
     71d:	03 85 44 ff ff ff    	add    -0xbc(%ebp),%eax
     723:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
     729:	89 c7                	mov    %eax,%edi
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
     72b:	50                   	push   %eax
     72c:	8d 45 88             	lea    -0x78(%ebp),%eax
     72f:	6a 10                	push   $0x10
     731:	50                   	push   %eax
     732:	ff 74 df 04          	pushl  0x4(%edi,%ebx,8)
			for(int j=0;j<N;j++){
     736:	83 c3 01             	add    $0x1,%ebx
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
     739:	e8 e4 1a 00 00       	call   2222 <write>
			for(int j=0;j<N;j++){
     73e:	83 c4 10             	add    $0x10,%esp
     741:	39 f3                	cmp    %esi,%ebx
     743:	75 e6                	jne    72b <main+0x72b>
     745:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
     74b:	8b bd 44 ff ff ff    	mov    -0xbc(%ebp),%edi
			for(int i=0;i<N;i++){
     751:	31 db                	xor    %ebx,%ebx
     753:	01 c0                	add    %eax,%eax
     755:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
				if(i!= x){
     75b:	3b 9d 3c ff ff ff    	cmp    -0xc4(%ebp),%ebx
     761:	74 25                	je     788 <main+0x788>
					write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
     763:	8d 45 88             	lea    -0x78(%ebp),%eax
     766:	51                   	push   %ecx
     767:	6a 10                	push   $0x10
     769:	8b 8d 34 ff ff ff    	mov    -0xcc(%ebp),%ecx
     76f:	50                   	push   %eax
     770:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
     776:	0f af c3             	imul   %ebx,%eax
     779:	8d 44 08 01          	lea    0x1(%eax,%ecx,1),%eax
     77d:	ff 34 87             	pushl  (%edi,%eax,4)
     780:	e8 9d 1a 00 00       	call   2222 <write>
     785:	83 c4 10             	add    $0x10,%esp
			for(int i=0;i<N;i++){
     788:	83 c3 01             	add    $0x1,%ebx
     78b:	39 f3                	cmp    %esi,%ebx
     78d:	75 cc                	jne    75b <main+0x75b>
			send_msg.i = x;
     78f:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
			int acq_lock[N][N];
     795:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
			for(int l=0;l<N;l++){
     79b:	c7 85 48 ff ff ff 00 	movl   $0x0,-0xb8(%ebp)
     7a2:	00 00 00 
			send_msg.i = x;
     7a5:	89 45 ac             	mov    %eax,-0x54(%ebp)
			send_msg.j = y;
     7a8:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			int acq_lock[N][N];
     7ae:	c1 e1 02             	shl    $0x2,%ecx
     7b1:	89 8d 24 ff ff ff    	mov    %ecx,-0xdc(%ebp)
						acq_lock[l][m] = 0;
     7b7:	c1 e9 02             	shr    $0x2,%ecx
     7ba:	89 8d 4c ff ff ff    	mov    %ecx,-0xb4(%ebp)
			send_msg.j = y;
     7c0:	89 45 b0             	mov    %eax,-0x50(%ebp)
			send_msg.ts = new_ts;
     7c3:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
     7c9:	89 45 b4             	mov    %eax,-0x4c(%ebp)
			int acq_lock[N][N];
     7cc:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
     7d2:	89 b5 38 ff ff ff    	mov    %esi,-0xc8(%ebp)
     7d8:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     7df:	25 f0 01 00 00       	and    $0x1f0,%eax
     7e4:	29 c4                	sub    %eax,%esp
     7e6:	89 e7                	mov    %esp,%edi
			int grant_lock[N][N];
     7e8:	29 c4                	sub    %eax,%esp
     7ea:	89 e3                	mov    %esp,%ebx
			int fail[N][N];
     7ec:	29 c4                	sub    %eax,%esp
			int acq_lock[N][N];
     7ee:	89 bd 28 ff ff ff    	mov    %edi,-0xd8(%ebp)
     7f4:	69 c6 ff ff ff 3f    	imul   $0x3fffffff,%esi,%eax
			int grant_lock[N][N];
     7fa:	89 9d 18 ff ff ff    	mov    %ebx,-0xe8(%ebp)
			int fail[N][N];
     800:	89 a5 08 ff ff ff    	mov    %esp,-0xf8(%ebp)
     806:	01 c8                	add    %ecx,%eax
						acq_lock[l][m] = 0;
     808:	89 f1                	mov    %esi,%ecx
     80a:	8b b5 50 ff ff ff    	mov    -0xb0(%ebp),%esi
     810:	c1 e0 02             	shl    $0x2,%eax
     813:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
     819:	89 c8                	mov    %ecx,%eax
     81b:	2b 85 38 ff ff ff    	sub    -0xc8(%ebp),%eax
			for(int i=0;i<N;i++){
     821:	89 fa                	mov    %edi,%edx
     823:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
     829:	eb 1b                	jmp    846 <main+0x846>
						acq_lock[l][m] = 1;
     82b:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
					grant_lock[l][m] = 0;
     831:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
     838:	83 c0 01             	add    $0x1,%eax
     83b:	83 c2 04             	add    $0x4,%edx
				for(int m=0;m<N;m++){
     83e:	39 c1                	cmp    %eax,%ecx
     840:	0f 84 18 04 00 00    	je     c5e <main+0xc5e>
					if((N*l + m) < num_P1){
     846:	39 f0                	cmp    %esi,%eax
     848:	7c e1                	jl     82b <main+0x82b>
						acq_lock[l][m] = 0;
     84a:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
     850:	eb df                	jmp    831 <main+0x831>
     852:	89 b5 0c ff ff ff    	mov    %esi,-0xf4(%ebp)
     858:	89 bd 08 ff ff ff    	mov    %edi,-0xf8(%ebp)
     85e:	89 df                	mov    %ebx,%edi
     860:	8b b5 38 ff ff ff    	mov    -0xc8(%ebp),%esi
     866:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
     86c:	eb 12                	jmp    880 <main+0x880>
     86e:	89 d1                	mov    %edx,%ecx
     870:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
     873:	39 7c 08 0c          	cmp    %edi,0xc(%eax,%ecx,1)
     877:	0f 8f a3 11 00 00    	jg     1a20 <main+0x1a20>
							for(int l =0;l<size;l++){
     87d:	83 c2 01             	add    $0x1,%edx
     880:	39 f2                	cmp    %esi,%edx
     882:	75 ea                	jne    86e <main+0x86e>
     884:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
     88a:	8b 8d 2c ff ff ff    	mov    -0xd4(%ebp),%ecx
     890:	8b b5 0c ff ff ff    	mov    -0xf4(%ebp),%esi
     896:	8b bd 08 ff ff ff    	mov    -0xf8(%ebp),%edi
     89c:	89 d8                	mov    %ebx,%eax
								size++;								
     89e:	83 c3 01             	add    $0x1,%ebx
     8a1:	c1 e0 04             	shl    $0x4,%eax
     8a4:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
     8aa:	89 9d 38 ff ff ff    	mov    %ebx,-0xc8(%ebp)
								mqueue[size].i = recv_msg.i;
     8b0:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
     8b3:	8b 8d 28 ff ff ff    	mov    -0xd8(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
     8b9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].j = recv_msg.j;
     8bf:	89 48 08             	mov    %ecx,0x8(%eax)
								mqueue[size].ts = recv_msg.ts;
     8c2:	8b 8d 34 ff ff ff    	mov    -0xcc(%ebp),%ecx
     8c8:	89 48 0c             	mov    %ecx,0xc(%eax)
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     8cb:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
     8d1:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
     8d7:	0f af 95 1c ff ff ff 	imul   -0xe4(%ebp),%edx
     8de:	50                   	push   %eax
     8df:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
     8e5:	6a 10                	push   $0x10
									send_msg.msg_type = 4;
     8e7:	c7 85 78 ff ff ff 04 	movl   $0x4,-0x88(%ebp)
     8ee:	00 00 00 
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     8f1:	50                   	push   %eax
     8f2:	89 d8                	mov    %ebx,%eax
     8f4:	01 d8                	add    %ebx,%eax
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
     8f6:	8b 9d 44 ff ff ff    	mov    -0xbc(%ebp),%ebx
     8fc:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
     900:	ff 34 83             	pushl  (%ebx,%eax,4)
     903:	e8 1a 19 00 00       	call   2222 <write>
     908:	83 c4 10             	add    $0x10,%esp
     90b:	e9 45 fc ff ff       	jmp    555 <main+0x555>
			request_lock.j = y;
     910:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			request_lock.i = x;
     916:	8b 9d 3c ff ff ff    	mov    -0xc4(%ebp),%ebx
			request_lock.msg_type = 1;
     91c:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
			request_lock.j = y;
     923:	89 45 c0             	mov    %eax,-0x40(%ebp)
			request_lock.ts = new_ts;
     926:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
			request_lock.i = x;
     92c:	89 5d bc             	mov    %ebx,-0x44(%ebp)
			request_lock.ts = new_ts;
     92f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     932:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
     938:	0f af c3             	imul   %ebx,%eax
     93b:	03 85 44 ff ff ff    	add    -0xbc(%ebp),%eax
			for(int j=0;j<N;j++){
     941:	31 db                	xor    %ebx,%ebx
     943:	89 c7                	mov    %eax,%edi
     945:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
     94b:	50                   	push   %eax
     94c:	8d 45 b8             	lea    -0x48(%ebp),%eax
     94f:	6a 10                	push   $0x10
     951:	50                   	push   %eax
     952:	ff 74 df 04          	pushl  0x4(%edi,%ebx,8)
			for(int j=0;j<N;j++){
     956:	83 c3 01             	add    $0x1,%ebx
					write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
     959:	e8 c4 18 00 00       	call   2222 <write>
			for(int j=0;j<N;j++){
     95e:	83 c4 10             	add    $0x10,%esp
     961:	39 f3                	cmp    %esi,%ebx
     963:	75 e6                	jne    94b <main+0x94b>
     965:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
     96b:	8b bd 44 ff ff ff    	mov    -0xbc(%ebp),%edi
			for(int i=0;i<N;i++){
     971:	31 db                	xor    %ebx,%ebx
     973:	01 c0                	add    %eax,%eax
     975:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
				if(i!= x){
     97b:	39 9d 3c ff ff ff    	cmp    %ebx,-0xc4(%ebp)
     981:	74 25                	je     9a8 <main+0x9a8>
					write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
     983:	8d 45 b8             	lea    -0x48(%ebp),%eax
     986:	51                   	push   %ecx
     987:	6a 10                	push   $0x10
     989:	8b 8d 34 ff ff ff    	mov    -0xcc(%ebp),%ecx
     98f:	50                   	push   %eax
     990:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
     996:	0f af c3             	imul   %ebx,%eax
     999:	8d 44 08 01          	lea    0x1(%eax,%ecx,1),%eax
     99d:	ff 34 87             	pushl  (%edi,%eax,4)
     9a0:	e8 7d 18 00 00       	call   2222 <write>
     9a5:	83 c4 10             	add    $0x10,%esp
			for(int i=0;i<N;i++){
     9a8:	83 c3 01             	add    $0x1,%ebx
     9ab:	39 f3                	cmp    %esi,%ebx
     9ad:	75 cc                	jne    97b <main+0x97b>
			send_msg.i = x;
     9af:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
			int acq_lock[N][N];
     9b5:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
			for(int l=0;l<N;l++){
     9bb:	c7 85 48 ff ff ff 00 	movl   $0x0,-0xb8(%ebp)
     9c2:	00 00 00 
			send_msg.i = x;
     9c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
			send_msg.j = y;
     9c8:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
			int acq_lock[N][N];
     9ce:	c1 e1 02             	shl    $0x2,%ecx
     9d1:	89 8d 24 ff ff ff    	mov    %ecx,-0xdc(%ebp)
						acq_lock[l][m] = 0;
     9d7:	c1 e9 02             	shr    $0x2,%ecx
     9da:	89 8d 4c ff ff ff    	mov    %ecx,-0xb4(%ebp)
			send_msg.j = y;
     9e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			send_msg.ts = new_ts;
     9e3:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
     9e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int acq_lock[N][N];
     9ec:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
     9f2:	89 b5 38 ff ff ff    	mov    %esi,-0xc8(%ebp)
     9f8:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     9ff:	25 f0 01 00 00       	and    $0x1f0,%eax
     a04:	29 c4                	sub    %eax,%esp
     a06:	89 e7                	mov    %esp,%edi
			int grant_lock[N][N];
     a08:	29 c4                	sub    %eax,%esp
     a0a:	89 e3                	mov    %esp,%ebx
			int fail[N][N];
     a0c:	29 c4                	sub    %eax,%esp
			int acq_lock[N][N];
     a0e:	89 bd 28 ff ff ff    	mov    %edi,-0xd8(%ebp)
     a14:	69 c6 ff ff ff 3f    	imul   $0x3fffffff,%esi,%eax
			int grant_lock[N][N];
     a1a:	89 9d 18 ff ff ff    	mov    %ebx,-0xe8(%ebp)
			int fail[N][N];
     a20:	89 a5 08 ff ff ff    	mov    %esp,-0xf8(%ebp)
     a26:	01 c8                	add    %ecx,%eax
						acq_lock[l][m] = 0;
     a28:	89 f1                	mov    %esi,%ecx
     a2a:	8b b5 50 ff ff ff    	mov    -0xb0(%ebp),%esi
     a30:	c1 e0 02             	shl    $0x2,%eax
     a33:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
     a39:	89 c8                	mov    %ecx,%eax
     a3b:	2b 85 38 ff ff ff    	sub    -0xc8(%ebp),%eax
			for(int i=0;i<N;i++){
     a41:	89 fa                	mov    %edi,%edx
     a43:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
     a49:	eb 17                	jmp    a62 <main+0xa62>
						acq_lock[l][m] = 1;
     a4b:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
					grant_lock[l][m] = 0;
     a51:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
     a58:	83 c0 01             	add    $0x1,%eax
     a5b:	83 c2 04             	add    $0x4,%edx
				for(int m=0;m<N;m++){
     a5e:	39 c8                	cmp    %ecx,%eax
     a60:	74 3e                	je     aa0 <main+0xaa0>
					if((N*l + m) < num_P1){
     a62:	39 c6                	cmp    %eax,%esi
     a64:	7f e5                	jg     a4b <main+0xa4b>
						acq_lock[l][m] = 0;
     a66:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
     a6c:	eb e3                	jmp    a51 <main+0xa51>
					fail[recv_msg.i][recv_msg.j] = 1;
     a6e:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     a74:	8b 9d 14 ff ff ff    	mov    -0xec(%ebp),%ebx
     a7a:	0f af 85 6c ff ff ff 	imul   -0x94(%ebp),%eax
     a81:	03 85 70 ff ff ff    	add    -0x90(%ebp),%eax
     a87:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					grant_lock[recv_msg.i][recv_msg.j] = 0;
     a8e:	8b 9d 10 ff ff ff    	mov    -0xf0(%ebp),%ebx
     a94:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
     a9b:	e9 b5 fa ff ff       	jmp    555 <main+0x555>
			for(int l=0;l<N;l++){
     aa0:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
     aa7:	03 9d 20 ff ff ff    	add    -0xe0(%ebp),%ebx
     aad:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
     ab3:	8b 8d 50 ff ff ff    	mov    -0xb0(%ebp),%ecx
     ab9:	03 bd 24 ff ff ff    	add    -0xdc(%ebp),%edi
     abf:	03 8d 2c ff ff ff    	add    -0xd4(%ebp),%ecx
     ac5:	3b 85 38 ff ff ff    	cmp    -0xc8(%ebp),%eax
     acb:	0f 85 68 ff ff ff    	jne    a39 <main+0xa39>
     ad1:	8b b5 38 ff ff ff    	mov    -0xc8(%ebp),%esi
     ad7:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     add:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
     ae3:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
			int entered_cs = 0;
     ae9:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
     af0:	00 00 00 
			int grant_send = 0;
     af3:	c7 85 14 ff ff ff 00 	movl   $0x0,-0xec(%ebp)
     afa:	00 00 00 
     afd:	0f af c6             	imul   %esi,%eax
	int size = 0;
     b00:	c7 85 48 ff ff ff 00 	movl   $0x0,-0xb8(%ebp)
     b07:	00 00 00 
			grant_ts = -1;
     b0a:	c7 85 20 ff ff ff ff 	movl   $0xffffffff,-0xe0(%ebp)
     b11:	ff ff ff 
			grant_y = -1;
     b14:	c7 85 0c ff ff ff ff 	movl   $0xffffffff,-0xf4(%ebp)
     b1b:	ff ff ff 
			grant_x = -1;
     b1e:	c7 85 10 ff ff ff ff 	movl   $0xffffffff,-0xf0(%ebp)
     b25:	ff ff ff 
     b28:	01 f0                	add    %esi,%eax
     b2a:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
     b31:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
     b37:	0f af c1             	imul   %ecx,%eax
     b3a:	01 c3                	add    %eax,%ebx
     b3c:	89 9d f8 fe ff ff    	mov    %ebx,-0x108(%ebp)
     b42:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
     b48:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
     b4b:	03 85 18 ff ff ff    	add    -0xe8(%ebp),%eax
     b51:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%ebp)
     b57:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
     b5d:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
     b63:	0f af c1             	imul   %ecx,%eax
     b66:	03 85 34 ff ff ff    	add    -0xcc(%ebp),%eax
     b6c:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
     b72:	8d 45 c8             	lea    -0x38(%ebp),%eax
     b75:	8b 8d 38 ff ff ff    	mov    -0xc8(%ebp),%ecx
     b7b:	52                   	push   %edx
     b7c:	6a 10                	push   $0x10
     b7e:	50                   	push   %eax
     b7f:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
     b85:	ff 34 88             	pushl  (%eax,%ecx,4)
     b88:	e8 8d 16 00 00       	call   221a <read>
				if(recv_msg.msg_type == 1){
     b8d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b90:	83 c4 10             	add    $0x10,%esp
     b93:	83 f8 01             	cmp    $0x1,%eax
     b96:	0f 84 4c 03 00 00    	je     ee8 <main+0xee8>
				else if(recv_msg.msg_type == 4){
     b9c:	83 f8 04             	cmp    $0x4,%eax
     b9f:	0f 84 01 08 00 00    	je     13a6 <main+0x13a6>
				else if(recv_msg.msg_type == 5){
     ba5:	83 f8 05             	cmp    $0x5,%eax
     ba8:	0f 84 88 0b 00 00    	je     1736 <main+0x1736>
				else if(recv_msg.msg_type == 7){
     bae:	83 f8 07             	cmp    $0x7,%eax
     bb1:	0f 84 b6 08 00 00    	je     146d <main+0x146d>
				else if(recv_msg.msg_type == 2){
     bb7:	83 f8 02             	cmp    $0x2,%eax
     bba:	0f 84 b4 0d 00 00    	je     1974 <main+0x1974>
				else if(recv_msg.msg_type == 3){
     bc0:	83 f8 03             	cmp    $0x3,%eax
     bc3:	75 27                	jne    bec <main+0xbec>
					fail[recv_msg.i][recv_msg.j] = 1;
     bc5:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     bcb:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
     bd1:	0f af 45 cc          	imul   -0x34(%ebp),%eax
     bd5:	03 45 d0             	add    -0x30(%ebp),%eax
     bd8:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					grant_lock[recv_msg.i][recv_msg.j] = 0;
     bdf:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
     be5:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
				int my_break = 1;
     bec:	8b 8d 2c ff ff ff    	mov    -0xd4(%ebp),%ecx
				for(int l =0;l<N;l++){
     bf2:	31 d2                	xor    %edx,%edx
				int my_break = 1;
     bf4:	b8 01 00 00 00       	mov    $0x1,%eax
							my_break = 0;
     bf9:	8b 1c 91             	mov    (%ecx,%edx,4),%ebx
     bfc:	85 db                	test   %ebx,%ebx
     bfe:	bb 00 00 00 00       	mov    $0x0,%ebx
     c03:	0f 44 c3             	cmove  %ebx,%eax
				for(int l =0;l<N;l++){
     c06:	83 c2 01             	add    $0x1,%edx
     c09:	39 f2                	cmp    %esi,%edx
     c0b:	75 ec                	jne    bf9 <main+0xbf9>
				for(int l =0;l<N;l++){
     c0d:	8b bd 28 ff ff ff    	mov    -0xd8(%ebp),%edi
     c13:	31 d2                	xor    %edx,%edx
						if(acq_lock[l][y] == 0){
     c15:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     c1b:	0f af ca             	imul   %edx,%ecx
     c1e:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
							my_break = 0;
     c24:	8b 0c 8f             	mov    (%edi,%ecx,4),%ecx
     c27:	85 c9                	test   %ecx,%ecx
     c29:	b9 00 00 00 00       	mov    $0x0,%ecx
     c2e:	0f 44 c1             	cmove  %ecx,%eax
				for(int l =0;l<N;l++){
     c31:	83 c2 01             	add    $0x1,%edx
     c34:	39 f2                	cmp    %esi,%edx
     c36:	75 dd                	jne    c15 <main+0xc15>
				if(my_break == 1){
     c38:	83 e8 01             	sub    $0x1,%eax
     c3b:	0f 84 6b f9 ff ff    	je     5ac <main+0x5ac>
				if(entered_cs == 0){
     c41:	83 bd 50 ff ff ff 00 	cmpl   $0x0,-0xb0(%ebp)
     c48:	0f 84 84 04 00 00    	je     10d2 <main+0x10d2>
			for(int l=0;l<N;l++){
     c4e:	b8 01 00 00 00       	mov    $0x1,%eax
     c53:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
     c59:	e9 14 ff ff ff       	jmp    b72 <main+0xb72>
			for(int l=0;l<N;l++){
     c5e:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
     c65:	03 9d 20 ff ff ff    	add    -0xe0(%ebp),%ebx
     c6b:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
     c71:	8b 8d 50 ff ff ff    	mov    -0xb0(%ebp),%ecx
     c77:	03 bd 24 ff ff ff    	add    -0xdc(%ebp),%edi
     c7d:	03 8d 2c ff ff ff    	add    -0xd4(%ebp),%ecx
     c83:	3b 85 38 ff ff ff    	cmp    -0xc8(%ebp),%eax
     c89:	0f 85 8a fb ff ff    	jne    819 <main+0x819>
     c8f:	8b b5 38 ff ff ff    	mov    -0xc8(%ebp),%esi
     c95:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     c9b:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
     ca1:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
			int entered_cs = 0;
     ca7:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
     cae:	00 00 00 
			int grant_send = 0;
     cb1:	c7 85 10 ff ff ff 00 	movl   $0x0,-0xf0(%ebp)
     cb8:	00 00 00 
     cbb:	0f af c6             	imul   %esi,%eax
	int size = 0;
     cbe:	c7 85 48 ff ff ff 00 	movl   $0x0,-0xb8(%ebp)
     cc5:	00 00 00 
			grant_ts = -1;
     cc8:	c7 85 20 ff ff ff ff 	movl   $0xffffffff,-0xe0(%ebp)
     ccf:	ff ff ff 
			grant_y = -1;
     cd2:	c7 85 0c ff ff ff ff 	movl   $0xffffffff,-0xf4(%ebp)
     cd9:	ff ff ff 
			grant_x = -1;
     cdc:	c7 85 14 ff ff ff ff 	movl   $0xffffffff,-0xec(%ebp)
     ce3:	ff ff ff 
     ce6:	01 f0                	add    %esi,%eax
     ce8:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
     cef:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
     cf5:	0f af c1             	imul   %ecx,%eax
     cf8:	01 c3                	add    %eax,%ebx
     cfa:	89 9d fc fe ff ff    	mov    %ebx,-0x104(%ebp)
     d00:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
     d06:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
     d09:	03 85 18 ff ff ff    	add    -0xe8(%ebp),%eax
     d0f:	89 bd 2c ff ff ff    	mov    %edi,-0xd4(%ebp)
     d15:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
				read(p[x][y][0],&recv_msg,(sizeof(recv_msg)));
     d1b:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
     d21:	0f af c1             	imul   %ecx,%eax
     d24:	03 85 34 ff ff ff    	add    -0xcc(%ebp),%eax
     d2a:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
     d30:	8d 45 98             	lea    -0x68(%ebp),%eax
     d33:	8b 8d 38 ff ff ff    	mov    -0xc8(%ebp),%ecx
     d39:	52                   	push   %edx
     d3a:	6a 10                	push   $0x10
     d3c:	50                   	push   %eax
     d3d:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
     d43:	ff 34 88             	pushl  (%eax,%ecx,4)
     d46:	e8 cf 14 00 00       	call   221a <read>
				if(recv_msg.msg_type == 1){
     d4b:	8b 45 98             	mov    -0x68(%ebp),%eax
     d4e:	83 c4 10             	add    $0x10,%esp
     d51:	83 f8 01             	cmp    $0x1,%eax
     d54:	0f 84 c2 00 00 00    	je     e1c <main+0xe1c>
				else if(recv_msg.msg_type == 4){
     d5a:	83 f8 04             	cmp    $0x4,%eax
     d5d:	0f 84 40 07 00 00    	je     14a3 <main+0x14a3>
				else if(recv_msg.msg_type == 5){
     d63:	83 f8 05             	cmp    $0x5,%eax
     d66:	0f 84 d3 0a 00 00    	je     183f <main+0x183f>
				else if(recv_msg.msg_type == 7){
     d6c:	83 f8 07             	cmp    $0x7,%eax
     d6f:	0f 84 c2 06 00 00    	je     1437 <main+0x1437>
				else if(recv_msg.msg_type == 2){
     d75:	83 f8 02             	cmp    $0x2,%eax
     d78:	0f 84 ca 0b 00 00    	je     1948 <main+0x1948>
				else if(recv_msg.msg_type == 3){
     d7e:	83 f8 03             	cmp    $0x3,%eax
     d81:	75 27                	jne    daa <main+0xdaa>
					fail[recv_msg.i][recv_msg.j] = 1;
     d83:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
     d89:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
     d8f:	0f af 45 9c          	imul   -0x64(%ebp),%eax
     d93:	03 45 a0             	add    -0x60(%ebp),%eax
     d96:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					grant_lock[recv_msg.i][recv_msg.j] = 0;
     d9d:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
     da3:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
				int my_break = 1;
     daa:	8b 8d 2c ff ff ff    	mov    -0xd4(%ebp),%ecx
				for(int l =0;l<N;l++){
     db0:	31 d2                	xor    %edx,%edx
				int my_break = 1;
     db2:	b8 01 00 00 00       	mov    $0x1,%eax
							my_break = 0;
     db7:	8b 1c 91             	mov    (%ecx,%edx,4),%ebx
     dba:	85 db                	test   %ebx,%ebx
     dbc:	bb 00 00 00 00       	mov    $0x0,%ebx
     dc1:	0f 44 c3             	cmove  %ebx,%eax
				for(int l =0;l<N;l++){
     dc4:	83 c2 01             	add    $0x1,%edx
     dc7:	39 f2                	cmp    %esi,%edx
     dc9:	75 ec                	jne    db7 <main+0xdb7>
				for(int l =0;l<N;l++){
     dcb:	8b bd 28 ff ff ff    	mov    -0xd8(%ebp),%edi
     dd1:	31 d2                	xor    %edx,%edx
						if(acq_lock[l][y] == 0){
     dd3:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     dd9:	0f af ca             	imul   %edx,%ecx
     ddc:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
							my_break = 0;
     de2:	8b 0c 8f             	mov    (%edi,%ecx,4),%ecx
     de5:	85 c9                	test   %ecx,%ecx
     de7:	b9 00 00 00 00       	mov    $0x0,%ecx
     dec:	0f 44 c1             	cmove  %ecx,%eax
				for(int l =0;l<N;l++){
     def:	83 c2 01             	add    $0x1,%edx
     df2:	39 f2                	cmp    %esi,%edx
     df4:	75 dd                	jne    dd3 <main+0xdd3>
				if(my_break == 1){
     df6:	83 e8 01             	sub    $0x1,%eax
     df9:	0f 84 ad f7 ff ff    	je     5ac <main+0x5ac>
				if(entered_cs == 0){
     dff:	83 bd 50 ff ff ff 00 	cmpl   $0x0,-0xb0(%ebp)
     e06:	0f 84 a8 01 00 00    	je     fb4 <main+0xfb4>
			for(int l=0;l<N;l++){
     e0c:	b8 01 00 00 00       	mov    $0x1,%eax
     e11:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
     e17:	e9 14 ff ff ff       	jmp    d30 <main+0xd30>
     e1c:	8b 45 9c             	mov    -0x64(%ebp),%eax
					if(grant_send == 0){
     e1f:	83 bd 10 ff ff ff 00 	cmpl   $0x0,-0xf0(%ebp)
     e26:	8b 7d a4             	mov    -0x5c(%ebp),%edi
     e29:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
     e2f:	8b 45 a0             	mov    -0x60(%ebp),%eax
     e32:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
     e38:	0f 84 af 07 00 00    	je     15ed <main+0x15ed>
						if(recv_msg.ts > grant_ts){
     e3e:	39 bd 20 ff ff ff    	cmp    %edi,-0xe0(%ebp)
     e44:	0f 8c 1c 07 00 00    	jl     1566 <main+0x1566>
     e4a:	89 f3                	mov    %esi,%ebx
							for(int l =0;l<size;l++){
     e4c:	31 d2                	xor    %edx,%edx
     e4e:	8b b5 48 ff ff ff    	mov    -0xb8(%ebp),%esi
     e54:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
     e5a:	eb 12                	jmp    e6e <main+0xe6e>
     e5c:	89 d1                	mov    %edx,%ecx
     e5e:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
     e61:	39 7c 08 0c          	cmp    %edi,0xc(%eax,%ecx,1)
     e65:	0f 8f c0 0c 00 00    	jg     1b2b <main+0x1b2b>
							for(int l =0;l<size;l++){
     e6b:	83 c2 01             	add    $0x1,%edx
     e6e:	39 d6                	cmp    %edx,%esi
     e70:	75 ea                	jne    e5c <main+0xe5c>
     e72:	89 de                	mov    %ebx,%esi
     e74:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
     e7a:	8b 8d 24 ff ff ff    	mov    -0xdc(%ebp),%ecx
     e80:	89 d8                	mov    %ebx,%eax
								size++;								
     e82:	83 c3 01             	add    $0x1,%ebx
     e85:	c1 e0 04             	shl    $0x4,%eax
     e88:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
     e8e:	89 9d 48 ff ff ff    	mov    %ebx,-0xb8(%ebp)
								mqueue[size].i = recv_msg.i;
     e94:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
     e97:	8b 8d 1c ff ff ff    	mov    -0xe4(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
     e9d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].ts = recv_msg.ts;
     ea3:	89 78 0c             	mov    %edi,0xc(%eax)
								mqueue[size].j = recv_msg.j;
     ea6:	89 48 08             	mov    %ecx,0x8(%eax)
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     ea9:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
     eaf:	8b 9d 0c ff ff ff    	mov    -0xf4(%ebp),%ebx
     eb5:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
     ebc:	50                   	push   %eax
     ebd:	8d 45 a8             	lea    -0x58(%ebp),%eax
     ec0:	6a 10                	push   $0x10
									send_msg.msg_type = 4;
     ec2:	c7 45 a8 04 00 00 00 	movl   $0x4,-0x58(%ebp)
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     ec9:	50                   	push   %eax
     eca:	89 d8                	mov    %ebx,%eax
     ecc:	01 d8                	add    %ebx,%eax
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
     ece:	8b 9d 44 ff ff ff    	mov    -0xbc(%ebp),%ebx
     ed4:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
     ed8:	ff 34 83             	pushl  (%ebx,%eax,4)
     edb:	e8 42 13 00 00       	call   2222 <write>
     ee0:	83 c4 10             	add    $0x10,%esp
     ee3:	e9 c2 fe ff ff       	jmp    daa <main+0xdaa>
     ee8:	8b 45 cc             	mov    -0x34(%ebp),%eax
					if(grant_send == 0){
     eeb:	83 bd 14 ff ff ff 00 	cmpl   $0x0,-0xec(%ebp)
     ef2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     ef5:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
     efb:	8b 45 d0             	mov    -0x30(%ebp),%eax
     efe:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
     f04:	0f 84 cb 07 00 00    	je     16d5 <main+0x16d5>
						if(recv_msg.ts > grant_ts){
     f0a:	39 bd 20 ff ff ff    	cmp    %edi,-0xe0(%ebp)
     f10:	0f 8c 38 07 00 00    	jl     164e <main+0x164e>
     f16:	89 f3                	mov    %esi,%ebx
							for(int l =0;l<size;l++){
     f18:	31 d2                	xor    %edx,%edx
     f1a:	8b b5 48 ff ff ff    	mov    -0xb8(%ebp),%esi
     f20:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
     f26:	eb 12                	jmp    f3a <main+0xf3a>
     f28:	89 d1                	mov    %edx,%ecx
     f2a:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
     f2d:	39 7c 08 0c          	cmp    %edi,0xc(%eax,%ecx,1)
     f31:	0f 8f 60 0d 00 00    	jg     1c97 <main+0x1c97>
							for(int l =0;l<size;l++){
     f37:	83 c2 01             	add    $0x1,%edx
     f3a:	39 d6                	cmp    %edx,%esi
     f3c:	75 ea                	jne    f28 <main+0xf28>
     f3e:	89 de                	mov    %ebx,%esi
     f40:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
     f46:	8b 8d 24 ff ff ff    	mov    -0xdc(%ebp),%ecx
     f4c:	89 d8                	mov    %ebx,%eax
								size++;								
     f4e:	83 c3 01             	add    $0x1,%ebx
     f51:	c1 e0 04             	shl    $0x4,%eax
     f54:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
     f5a:	89 9d 48 ff ff ff    	mov    %ebx,-0xb8(%ebp)
								mqueue[size].i = recv_msg.i;
     f60:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
     f63:	8b 8d 1c ff ff ff    	mov    -0xe4(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
     f69:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].ts = recv_msg.ts;
     f6f:	89 78 0c             	mov    %edi,0xc(%eax)
								mqueue[size].j = recv_msg.j;
     f72:	89 48 08             	mov    %ecx,0x8(%eax)
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     f75:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
     f7b:	8b 9d 0c ff ff ff    	mov    -0xf4(%ebp),%ebx
     f81:	0f af 95 10 ff ff ff 	imul   -0xf0(%ebp),%edx
     f88:	50                   	push   %eax
     f89:	8d 45 d8             	lea    -0x28(%ebp),%eax
     f8c:	6a 10                	push   $0x10
									send_msg.msg_type = 4;
     f8e:	c7 45 d8 04 00 00 00 	movl   $0x4,-0x28(%ebp)
									write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));									
     f95:	50                   	push   %eax
     f96:	89 d8                	mov    %ebx,%eax
     f98:	01 d8                	add    %ebx,%eax
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
     f9a:	8b 9d 44 ff ff ff    	mov    -0xbc(%ebp),%ebx
     fa0:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
     fa4:	ff 34 83             	pushl  (%ebx,%eax,4)
     fa7:	e8 76 12 00 00       	call   2222 <write>
     fac:	83 c4 10             	add    $0x10,%esp
     faf:	e9 38 fc ff ff       	jmp    bec <main+0xbec>
					int flag = 1;
     fb4:	8b 8d 04 ff ff ff    	mov    -0xfc(%ebp),%ecx
					for(int l =0;l<N;l++){
     fba:	31 d2                	xor    %edx,%edx
					int flag = 1;
     fbc:	b8 01 00 00 00       	mov    $0x1,%eax
								flag = 0;
     fc1:	83 3c 91 00          	cmpl   $0x0,(%ecx,%edx,4)
     fc5:	bb 00 00 00 00       	mov    $0x0,%ebx
     fca:	0f 44 c3             	cmove  %ebx,%eax
					for(int l =0;l<N;l++){
     fcd:	83 c2 01             	add    $0x1,%edx
     fd0:	39 f2                	cmp    %esi,%edx
     fd2:	75 ed                	jne    fc1 <main+0xfc1>
					for(int l =0;l<N;l++){
     fd4:	8b bd 18 ff ff ff    	mov    -0xe8(%ebp),%edi
     fda:	31 d2                	xor    %edx,%edx
							if(grant_lock[l][y] == 0){
     fdc:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
     fe2:	0f af ca             	imul   %edx,%ecx
     fe5:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
								flag = 0;
     feb:	83 3c 8f 00          	cmpl   $0x0,(%edi,%ecx,4)
     fef:	b9 00 00 00 00       	mov    $0x0,%ecx
     ff4:	0f 44 c1             	cmove  %ecx,%eax
					for(int l =0;l<N;l++){
     ff7:	83 c2 01             	add    $0x1,%edx
     ffa:	39 f2                	cmp    %esi,%edx
     ffc:	75 de                	jne    fdc <main+0xfdc>
					if(flag == 1){
     ffe:	83 f8 01             	cmp    $0x1,%eax
    1001:	0f 85 0a fe ff ff    	jne    e11 <main+0xe11>
						printf(1,"%d acquired the lock at time %d.\n",getpid(),(int)uptime());
    1007:	e8 8e 12 00 00       	call   229a <uptime>
    100c:	89 c7                	mov    %eax,%edi
    100e:	e8 6f 12 00 00       	call   2282 <getpid>
    1013:	57                   	push   %edi
    1014:	50                   	push   %eax
    1015:	68 54 27 00 00       	push   $0x2754
    101a:	6a 01                	push   $0x1
    101c:	e8 af 13 00 00       	call   23d0 <printf>
						sleep(200);
    1021:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
    1028:	e8 65 12 00 00       	call   2292 <sleep>
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
    102d:	e8 68 12 00 00       	call   229a <uptime>
    1032:	89 c7                	mov    %eax,%edi
    1034:	e8 49 12 00 00       	call   2282 <getpid>
    1039:	57                   	push   %edi
    103a:	50                   	push   %eax
						for(int j=0;j<N;j++){
    103b:	31 ff                	xor    %edi,%edi
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
    103d:	68 78 27 00 00       	push   $0x2778
    1042:	6a 01                	push   $0x1
    1044:	e8 87 13 00 00       	call   23d0 <printf>
						request_lock.i = x;
    1049:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
						request_lock.msg_type = 7;
    104f:	c7 45 88 07 00 00 00 	movl   $0x7,-0x78(%ebp)
    1056:	83 c4 20             	add    $0x20,%esp
						request_lock.i = x;
    1059:	89 45 8c             	mov    %eax,-0x74(%ebp)
						request_lock.j = y;
    105c:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
    1062:	89 45 90             	mov    %eax,-0x70(%ebp)
						for(int j=0;j<N;j++){
    1065:	89 f0                	mov    %esi,%eax
    1067:	89 fe                	mov    %edi,%esi
    1069:	89 c7                	mov    %eax,%edi
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
    106b:	50                   	push   %eax
    106c:	8d 45 88             	lea    -0x78(%ebp),%eax
    106f:	6a 10                	push   $0x10
    1071:	50                   	push   %eax
    1072:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
    1078:	ff 74 f0 04          	pushl  0x4(%eax,%esi,8)
						for(int j=0;j<N;j++){
    107c:	83 c6 01             	add    $0x1,%esi
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
    107f:	e8 9e 11 00 00       	call   2222 <write>
						for(int j=0;j<N;j++){
    1084:	83 c4 10             	add    $0x10,%esp
    1087:	39 fe                	cmp    %edi,%esi
    1089:	75 e0                	jne    106b <main+0x106b>
    108b:	89 fe                	mov    %edi,%esi
    108d:	8b bd 50 ff ff ff    	mov    -0xb0(%ebp),%edi
							if(i!= x){
    1093:	39 bd 3c ff ff ff    	cmp    %edi,-0xc4(%ebp)
    1099:	74 2b                	je     10c6 <main+0x10c6>
								write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
    109b:	50                   	push   %eax
    109c:	8d 45 88             	lea    -0x78(%ebp),%eax
    109f:	6a 10                	push   $0x10
    10a1:	8b 9d 34 ff ff ff    	mov    -0xcc(%ebp),%ebx
    10a7:	50                   	push   %eax
    10a8:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
    10ae:	0f af c7             	imul   %edi,%eax
    10b1:	8d 44 18 01          	lea    0x1(%eax,%ebx,1),%eax
    10b5:	8b 9d 44 ff ff ff    	mov    -0xbc(%ebp),%ebx
    10bb:	ff 34 83             	pushl  (%ebx,%eax,4)
    10be:	e8 5f 11 00 00       	call   2222 <write>
    10c3:	83 c4 10             	add    $0x10,%esp
						for(int i=0;i<N;i++){
    10c6:	83 c7 01             	add    $0x1,%edi
    10c9:	39 f7                	cmp    %esi,%edi
    10cb:	75 c6                	jne    1093 <main+0x1093>
    10cd:	e9 3a fd ff ff       	jmp    e0c <main+0xe0c>
					int flag = 1;
    10d2:	8b 8d 04 ff ff ff    	mov    -0xfc(%ebp),%ecx
					for(int l =0;l<N;l++){
    10d8:	31 d2                	xor    %edx,%edx
					int flag = 1;
    10da:	b8 01 00 00 00       	mov    $0x1,%eax
								flag = 0;
    10df:	83 3c 91 00          	cmpl   $0x0,(%ecx,%edx,4)
    10e3:	bb 00 00 00 00       	mov    $0x0,%ebx
    10e8:	0f 44 c3             	cmove  %ebx,%eax
					for(int l =0;l<N;l++){
    10eb:	83 c2 01             	add    $0x1,%edx
    10ee:	39 f2                	cmp    %esi,%edx
    10f0:	75 ed                	jne    10df <main+0x10df>
					for(int l =0;l<N;l++){
    10f2:	8b bd 18 ff ff ff    	mov    -0xe8(%ebp),%edi
    10f8:	31 d2                	xor    %edx,%edx
							if(grant_lock[l][y] == 0){
    10fa:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
    1100:	0f af ca             	imul   %edx,%ecx
    1103:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
								flag = 0;
    1109:	83 3c 8f 00          	cmpl   $0x0,(%edi,%ecx,4)
    110d:	b9 00 00 00 00       	mov    $0x0,%ecx
    1112:	0f 44 c1             	cmove  %ecx,%eax
					for(int l =0;l<N;l++){
    1115:	83 c2 01             	add    $0x1,%edx
    1118:	39 f2                	cmp    %esi,%edx
    111a:	75 de                	jne    10fa <main+0x10fa>
					if(flag == 1){
    111c:	83 f8 01             	cmp    $0x1,%eax
    111f:	0f 85 2e fb ff ff    	jne    c53 <main+0xc53>
						printf(1,"%d acquired the lock at time %d.\n",getpid(),(int)uptime());
    1125:	e8 70 11 00 00       	call   229a <uptime>
    112a:	89 c7                	mov    %eax,%edi
    112c:	e8 51 11 00 00       	call   2282 <getpid>
    1131:	57                   	push   %edi
    1132:	50                   	push   %eax
    1133:	68 54 27 00 00       	push   $0x2754
    1138:	6a 01                	push   $0x1
    113a:	e8 91 12 00 00       	call   23d0 <printf>
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
    113f:	e8 56 11 00 00       	call   229a <uptime>
    1144:	89 c7                	mov    %eax,%edi
    1146:	e8 37 11 00 00       	call   2282 <getpid>
    114b:	57                   	push   %edi
    114c:	50                   	push   %eax
						for(int j=0;j<N;j++){
    114d:	31 ff                	xor    %edi,%edi
						printf(1,"%d released the lock at time %d.\n",getpid(),(int)uptime());
    114f:	68 78 27 00 00       	push   $0x2778
    1154:	6a 01                	push   $0x1
    1156:	e8 75 12 00 00       	call   23d0 <printf>
						request_lock.i = x;
    115b:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
						request_lock.msg_type = 7;
    1161:	c7 45 b8 07 00 00 00 	movl   $0x7,-0x48(%ebp)
    1168:	83 c4 20             	add    $0x20,%esp
						request_lock.i = x;
    116b:	89 45 bc             	mov    %eax,-0x44(%ebp)
						request_lock.j = y;
    116e:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
    1174:	89 45 c0             	mov    %eax,-0x40(%ebp)
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
    1177:	8d 45 b8             	lea    -0x48(%ebp),%eax
    117a:	52                   	push   %edx
    117b:	6a 10                	push   $0x10
    117d:	50                   	push   %eax
    117e:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
    1184:	ff 74 f8 04          	pushl  0x4(%eax,%edi,8)
						for(int j=0;j<N;j++){
    1188:	83 c7 01             	add    $0x1,%edi
								write(p[x][j][1],&request_lock,(sizeof(request_lock)));					
    118b:	e8 92 10 00 00       	call   2222 <write>
						for(int j=0;j<N;j++){
    1190:	83 c4 10             	add    $0x10,%esp
    1193:	39 f7                	cmp    %esi,%edi
    1195:	75 e0                	jne    1177 <main+0x1177>
    1197:	8b bd 50 ff ff ff    	mov    -0xb0(%ebp),%edi
							if(i!= x){
    119d:	39 bd 3c ff ff ff    	cmp    %edi,-0xc4(%ebp)
    11a3:	74 2b                	je     11d0 <main+0x11d0>
								write(p[i][y][1],&request_lock,(sizeof(request_lock)));					
    11a5:	50                   	push   %eax
    11a6:	8d 45 b8             	lea    -0x48(%ebp),%eax
    11a9:	6a 10                	push   $0x10
    11ab:	8b 9d 34 ff ff ff    	mov    -0xcc(%ebp),%ebx
    11b1:	50                   	push   %eax
    11b2:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
    11b8:	0f af c7             	imul   %edi,%eax
    11bb:	8d 44 18 01          	lea    0x1(%eax,%ebx,1),%eax
    11bf:	8b 9d 44 ff ff ff    	mov    -0xbc(%ebp),%ebx
    11c5:	ff 34 83             	pushl  (%ebx,%eax,4)
    11c8:	e8 55 10 00 00       	call   2222 <write>
    11cd:	83 c4 10             	add    $0x10,%esp
						for(int i=0;i<N;i++){
    11d0:	83 c7 01             	add    $0x1,%edi
    11d3:	39 f7                	cmp    %esi,%edi
    11d5:	75 c6                	jne    119d <main+0x119d>
    11d7:	e9 72 fa ff ff       	jmp    c4e <main+0xc4e>
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    11dc:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    11e2:	0f af 85 6c ff ff ff 	imul   -0x94(%ebp),%eax
    11e9:	03 85 70 ff ff ff    	add    -0x90(%ebp),%eax
					if(size <= 0){
    11ef:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%ebp)
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    11f6:	c7 04 87 01 00 00 00 	movl   $0x1,(%edi,%eax,4)
					if(size <= 0){
    11fd:	0f 85 14 0b 00 00    	jne    1d17 <main+0x1d17>
						grant_send = 0;
    1203:	c7 85 20 ff ff ff 00 	movl   $0x0,-0xe0(%ebp)
    120a:	00 00 00 
    120d:	e9 43 f3 ff ff       	jmp    555 <main+0x555>
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1212:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    1218:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
    121e:	0f af 95 2c ff ff ff 	imul   -0xd4(%ebp),%edx
    1225:	50                   	push   %eax
    1226:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
    122c:	6a 10                	push   $0x10
    122e:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
						send_msg.msg_type = 2;
    1234:	c7 85 78 ff ff ff 02 	movl   $0x2,-0x88(%ebp)
    123b:	00 00 00 
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    123e:	50                   	push   %eax
    123f:	89 d8                	mov    %ebx,%eax
    1241:	01 d8                	add    %ebx,%eax
    1243:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1247:	ff 34 81             	pushl  (%ecx,%eax,4)
    124a:	e8 d3 0f 00 00       	call   2222 <write>
    124f:	8b 8d 34 ff ff ff    	mov    -0xcc(%ebp),%ecx
						grant_x = recv_msg.i;
    1255:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
    125b:	83 c4 10             	add    $0x10,%esp
						grant_y = recv_msg.j;
    125e:	89 9d 18 ff ff ff    	mov    %ebx,-0xe8(%ebp)
						grant_send = 1;
    1264:	c7 85 20 ff ff ff 01 	movl   $0x1,-0xe0(%ebp)
    126b:	00 00 00 
    126e:	89 8d 24 ff ff ff    	mov    %ecx,-0xdc(%ebp)
						grant_x = recv_msg.i;
    1274:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
    127a:	e9 d6 f2 ff ff       	jmp    555 <main+0x555>
					grant_x = mqueue[0].i;
    127f:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
					for(int l =0;l<(size - 1);l++){
    1285:	8b 8d 50 ff ff ff    	mov    -0xb0(%ebp),%ecx
					grant_x = mqueue[0].i;
    128b:	8b 58 04             	mov    0x4(%eax),%ebx
    128e:	89 9d 34 ff ff ff    	mov    %ebx,-0xcc(%ebp)
					grant_y = mqueue[0].j;
    1294:	8b 58 08             	mov    0x8(%eax),%ebx
    1297:	89 9d 2c ff ff ff    	mov    %ebx,-0xd4(%ebp)
					grant_ts = mqueue[0].ts;
    129d:	8b 58 0c             	mov    0xc(%eax),%ebx
    12a0:	89 9d 28 ff ff ff    	mov    %ebx,-0xd8(%ebp)
    12a6:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
    12ac:	8d 53 ff             	lea    -0x1(%ebx),%edx
    12af:	89 f3                	mov    %esi,%ebx
					for(int l =0;l<(size - 1);l++){
    12b1:	eb 1a                	jmp    12cd <main+0x12cd>
							mqueue[l].msg_type = mqueue[l+1].msg_type;
    12b3:	8b 30                	mov    (%eax),%esi
    12b5:	83 c1 01             	add    $0x1,%ecx
    12b8:	89 70 f0             	mov    %esi,-0x10(%eax)
							mqueue[l].i = mqueue[l+1].i;
    12bb:	8b 70 04             	mov    0x4(%eax),%esi
    12be:	89 70 f4             	mov    %esi,-0xc(%eax)
							mqueue[l].j = mqueue[l+1].j;
    12c1:	8b 70 08             	mov    0x8(%eax),%esi
    12c4:	89 70 f8             	mov    %esi,-0x8(%eax)
							mqueue[l].ts = mqueue[l+1].ts;
    12c7:	8b 70 0c             	mov    0xc(%eax),%esi
    12ca:	89 70 fc             	mov    %esi,-0x4(%eax)
    12cd:	83 c0 10             	add    $0x10,%eax
					for(int l =0;l<(size - 1);l++){
    12d0:	39 d1                	cmp    %edx,%ecx
    12d2:	7c df                	jl     12b3 <main+0x12b3>
    12d4:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%ebp)
    12da:	89 95 08 ff ff ff    	mov    %edx,-0xf8(%ebp)
					for(int l =0;l<size;l++){
    12e0:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
    12e6:	8b b5 24 ff ff ff    	mov    -0xdc(%ebp),%esi
    12ec:	8b bd 30 ff ff ff    	mov    -0xd0(%ebp),%edi
    12f2:	eb 12                	jmp    1306 <main+0x1306>
    12f4:	89 c1                	mov    %eax,%ecx
    12f6:	c1 e1 04             	shl    $0x4,%ecx
						if(mqueue[l].ts > prev_ts){
    12f9:	39 74 0f 0c          	cmp    %esi,0xc(%edi,%ecx,1)
    12fd:	0f 8f ad 07 00 00    	jg     1ab0 <main+0x1ab0>
					for(int l =0;l<size;l++){
    1303:	83 c0 01             	add    $0x1,%eax
    1306:	39 d0                	cmp    %edx,%eax
    1308:	7c ea                	jl     12f4 <main+0x12f4>
    130a:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
    1310:	89 de                	mov    %ebx,%esi
						mqueue[size].i = prev_x;
    1312:	8b 9d 1c ff ff ff    	mov    -0xe4(%ebp),%ebx
    1318:	8b bd 0c ff ff ff    	mov    -0xf4(%ebp),%edi
    131e:	c1 e0 04             	shl    $0x4,%eax
    1321:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
    1327:	89 58 f4             	mov    %ebx,-0xc(%eax)
						mqueue[size].j = prev_y;
    132a:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
						mqueue[size].msg_type = 1;
    1330:	c7 40 f0 01 00 00 00 	movl   $0x1,-0x10(%eax)
						mqueue[size].j = prev_y;
    1337:	89 58 f8             	mov    %ebx,-0x8(%eax)
						mqueue[size].ts = prev_ts;
    133a:	8b 9d 24 ff ff ff    	mov    -0xdc(%ebp),%ebx
    1340:	89 58 fc             	mov    %ebx,-0x4(%eax)
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1343:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    1349:	8b 9d 2c ff ff ff    	mov    -0xd4(%ebp),%ebx
    134f:	0f af 95 34 ff ff ff 	imul   -0xcc(%ebp),%edx
    1356:	50                   	push   %eax
    1357:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
    135d:	6a 10                	push   $0x10
    135f:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
					send_msg.msg_type = 2;
    1365:	c7 85 78 ff ff ff 02 	movl   $0x2,-0x88(%ebp)
    136c:	00 00 00 
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    136f:	50                   	push   %eax
    1370:	89 d8                	mov    %ebx,%eax
    1372:	01 d8                	add    %ebx,%eax
    1374:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1378:	ff 34 81             	pushl  (%ecx,%eax,4)
    137b:	e8 a2 0e 00 00       	call   2222 <write>
					grant_ts = mqueue[0].ts;
    1380:	8b 8d 28 ff ff ff    	mov    -0xd8(%ebp),%ecx
					grant_x = mqueue[0].i;
    1386:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
    138c:	83 c4 10             	add    $0x10,%esp
					grant_y = mqueue[0].j;
    138f:	89 9d 18 ff ff ff    	mov    %ebx,-0xe8(%ebp)
					grant_ts = mqueue[0].ts;
    1395:	89 8d 24 ff ff ff    	mov    %ecx,-0xdc(%ebp)
					grant_x = mqueue[0].i;
    139b:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
    13a1:	e9 af f1 ff ff       	jmp    555 <main+0x555>
					int flag = 1;
    13a6:	8b 8d f8 fe ff ff    	mov    -0x108(%ebp),%ecx
					for(int l =0;l<N;l++){
    13ac:	31 d2                	xor    %edx,%edx
					int flag = 1;
    13ae:	b8 01 00 00 00       	mov    $0x1,%eax
								flag = 0;
    13b3:	83 3c 91 01          	cmpl   $0x1,(%ecx,%edx,4)
    13b7:	bb 00 00 00 00       	mov    $0x0,%ebx
    13bc:	0f 44 c3             	cmove  %ebx,%eax
					for(int l =0;l<N;l++){
    13bf:	83 c2 01             	add    $0x1,%edx
    13c2:	39 f2                	cmp    %esi,%edx
    13c4:	75 ed                	jne    13b3 <main+0x13b3>
					for(int l =0;l<N;l++){
    13c6:	8b bd 08 ff ff ff    	mov    -0xf8(%ebp),%edi
    13cc:	31 d2                	xor    %edx,%edx
							if(fail[l][y] == 1){
    13ce:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
    13d4:	0f af ca             	imul   %edx,%ecx
    13d7:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
								flag = 0;
    13dd:	83 3c 8f 01          	cmpl   $0x1,(%edi,%ecx,4)
    13e1:	b9 00 00 00 00       	mov    $0x0,%ecx
    13e6:	0f 44 c1             	cmove  %ecx,%eax
					for(int l =0;l<N;l++){
    13e9:	83 c2 01             	add    $0x1,%edx
    13ec:	39 f2                	cmp    %esi,%edx
    13ee:	75 de                	jne    13ce <main+0x13ce>
					if((flag == 0) && (entered_cs == 0)){
    13f0:	0b 85 50 ff ff ff    	or     -0xb0(%ebp),%eax
    13f6:	0f 85 f0 f7 ff ff    	jne    bec <main+0xbec>
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    13fc:	8b 55 cc             	mov    -0x34(%ebp),%edx
    13ff:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    1405:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    1408:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
						send_msg.msg_type = 5;
    140e:	c7 45 d8 05 00 00 00 	movl   $0x5,-0x28(%ebp)
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    1415:	0f af c2             	imul   %edx,%eax
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
    1418:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    141f:	01 c8                	add    %ecx,%eax
    1421:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
    1428:	50                   	push   %eax
    1429:	8d 45 d8             	lea    -0x28(%ebp),%eax
    142c:	6a 10                	push   $0x10
    142e:	50                   	push   %eax
    142f:	8d 04 09             	lea    (%ecx,%ecx,1),%eax
    1432:	e9 63 fb ff ff       	jmp    f9a <main+0xf9a>
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    1437:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    143d:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
    1443:	0f af 45 9c          	imul   -0x64(%ebp),%eax
    1447:	03 45 a0             	add    -0x60(%ebp),%eax
					if(size <= 0){
    144a:	83 bd 48 ff ff ff 00 	cmpl   $0x0,-0xb8(%ebp)
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    1451:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					if(size <= 0){
    1458:	0f 85 25 0a 00 00    	jne    1e83 <main+0x1e83>
						grant_send = 0;
    145e:	c7 85 10 ff ff ff 00 	movl   $0x0,-0xf0(%ebp)
    1465:	00 00 00 
    1468:	e9 3d f9 ff ff       	jmp    daa <main+0xdaa>
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    146d:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    1473:	8b 9d 28 ff ff ff    	mov    -0xd8(%ebp),%ebx
    1479:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    147d:	03 45 d0             	add    -0x30(%ebp),%eax
					if(size <= 0){
    1480:	83 bd 48 ff ff ff 00 	cmpl   $0x0,-0xb8(%ebp)
					acq_lock[recv_msg.i][recv_msg.j] = 1;
    1487:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					if(size <= 0){
    148e:	0f 85 7b 0a 00 00    	jne    1f0f <main+0x1f0f>
						grant_send = 0;
    1494:	c7 85 14 ff ff ff 00 	movl   $0x0,-0xec(%ebp)
    149b:	00 00 00 
    149e:	e9 49 f7 ff ff       	jmp    bec <main+0xbec>
					int flag = 1;
    14a3:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
					for(int l =0;l<N;l++){
    14a9:	31 d2                	xor    %edx,%edx
					int flag = 1;
    14ab:	b8 01 00 00 00       	mov    $0x1,%eax
								flag = 0;
    14b0:	83 3c 91 01          	cmpl   $0x1,(%ecx,%edx,4)
    14b4:	bb 00 00 00 00       	mov    $0x0,%ebx
    14b9:	0f 44 c3             	cmove  %ebx,%eax
					for(int l =0;l<N;l++){
    14bc:	83 c2 01             	add    $0x1,%edx
    14bf:	39 f2                	cmp    %esi,%edx
    14c1:	75 ed                	jne    14b0 <main+0x14b0>
					for(int l =0;l<N;l++){
    14c3:	8b bd 08 ff ff ff    	mov    -0xf8(%ebp),%edi
    14c9:	31 d2                	xor    %edx,%edx
							if(fail[l][y] == 1){
    14cb:	8b 8d 4c ff ff ff    	mov    -0xb4(%ebp),%ecx
    14d1:	0f af ca             	imul   %edx,%ecx
    14d4:	03 8d 54 ff ff ff    	add    -0xac(%ebp),%ecx
								flag = 0;
    14da:	83 3c 8f 01          	cmpl   $0x1,(%edi,%ecx,4)
    14de:	b9 00 00 00 00       	mov    $0x0,%ecx
    14e3:	0f 44 c1             	cmove  %ecx,%eax
					for(int l =0;l<N;l++){
    14e6:	83 c2 01             	add    $0x1,%edx
    14e9:	39 f2                	cmp    %esi,%edx
    14eb:	75 de                	jne    14cb <main+0x14cb>
					if((flag == 0) && (entered_cs == 0)){
    14ed:	0b 85 50 ff ff ff    	or     -0xb0(%ebp),%eax
    14f3:	0f 85 b1 f8 ff ff    	jne    daa <main+0xdaa>
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    14f9:	8b 55 9c             	mov    -0x64(%ebp),%edx
    14fc:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    1502:	8b 4d a0             	mov    -0x60(%ebp),%ecx
    1505:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
						send_msg.msg_type = 5;
    150b:	c7 45 a8 05 00 00 00 	movl   $0x5,-0x58(%ebp)
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    1512:	0f af c2             	imul   %edx,%eax
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
    1515:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
						grant_lock[recv_msg.i][recv_msg.j] = 0;
    151c:	01 c8                	add    %ecx,%eax
    151e:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
						write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));
    1525:	50                   	push   %eax
    1526:	8d 45 a8             	lea    -0x58(%ebp),%eax
    1529:	6a 10                	push   $0x10
    152b:	50                   	push   %eax
    152c:	8d 04 09             	lea    (%ecx,%ecx,1),%eax
    152f:	e9 9a f9 ff ff       	jmp    ece <main+0xece>
					grant_lock[recv_msg.i][recv_msg.j] = 1;
    1534:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    153a:	8b 9d 10 ff ff ff    	mov    -0xf0(%ebp),%ebx
    1540:	0f af 85 6c ff ff ff 	imul   -0x94(%ebp),%eax
    1547:	03 85 70 ff ff ff    	add    -0x90(%ebp),%eax
    154d:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					fail[recv_msg.i][recv_msg.j] = 0;
    1554:	8b 9d 14 ff ff ff    	mov    -0xec(%ebp),%ebx
    155a:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
    1561:	e9 ef ef ff ff       	jmp    555 <main+0x555>
							for(int l =0;l<size;l++){
    1566:	89 f3                	mov    %esi,%ebx
    1568:	31 c0                	xor    %eax,%eax
    156a:	8b b5 48 ff ff ff    	mov    -0xb8(%ebp),%esi
    1570:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
    1576:	eb 12                	jmp    158a <main+0x158a>
    1578:	89 c1                	mov    %eax,%ecx
    157a:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
    157d:	39 7c 0a 0c          	cmp    %edi,0xc(%edx,%ecx,1)
    1581:	0f 8f 9c 06 00 00    	jg     1c23 <main+0x1c23>
							for(int l =0;l<size;l++){
    1587:	83 c0 01             	add    $0x1,%eax
    158a:	39 c6                	cmp    %eax,%esi
    158c:	75 ea                	jne    1578 <main+0x1578>
    158e:	89 de                	mov    %ebx,%esi
    1590:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
    1596:	8b 8d 24 ff ff ff    	mov    -0xdc(%ebp),%ecx
    159c:	89 d8                	mov    %ebx,%eax
								size++;								
    159e:	83 c3 01             	add    $0x1,%ebx
    15a1:	c1 e0 04             	shl    $0x4,%eax
    15a4:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
    15aa:	89 9d 48 ff ff ff    	mov    %ebx,-0xb8(%ebp)
								mqueue[size].i = recv_msg.i;
    15b0:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
    15b3:	8b 8d 1c ff ff ff    	mov    -0xe4(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
    15b9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].ts = recv_msg.ts;
    15bf:	89 78 0c             	mov    %edi,0xc(%eax)
								mqueue[size].j = recv_msg.j;
    15c2:	89 48 08             	mov    %ecx,0x8(%eax)
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
    15c5:	50                   	push   %eax
    15c6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    15c9:	6a 10                	push   $0x10
    15cb:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
									send_msg.msg_type = 3;
    15d1:	c7 45 a8 03 00 00 00 	movl   $0x3,-0x58(%ebp)
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
    15d8:	50                   	push   %eax
    15d9:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
    15df:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
    15e6:	01 c0                	add    %eax,%eax
    15e8:	e9 e1 f8 ff ff       	jmp    ece <main+0xece>
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    15ed:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    15f3:	8b 9d 1c ff ff ff    	mov    -0xe4(%ebp),%ebx
    15f9:	0f af 95 24 ff ff ff 	imul   -0xdc(%ebp),%edx
    1600:	50                   	push   %eax
    1601:	8d 45 a8             	lea    -0x58(%ebp),%eax
    1604:	6a 10                	push   $0x10
    1606:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
						send_msg.msg_type = 2;
    160c:	c7 45 a8 02 00 00 00 	movl   $0x2,-0x58(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1613:	50                   	push   %eax
    1614:	89 d8                	mov    %ebx,%eax
    1616:	01 d8                	add    %ebx,%eax
    1618:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    161c:	ff 34 81             	pushl  (%ecx,%eax,4)
    161f:	e8 fe 0b 00 00       	call   2222 <write>
						grant_x = recv_msg.i;
    1624:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
    162a:	83 c4 10             	add    $0x10,%esp
    162d:	89 bd 20 ff ff ff    	mov    %edi,-0xe0(%ebp)
						grant_y = recv_msg.j;
    1633:	89 9d 0c ff ff ff    	mov    %ebx,-0xf4(%ebp)
						grant_send = 1;
    1639:	c7 85 10 ff ff ff 01 	movl   $0x1,-0xf0(%ebp)
    1640:	00 00 00 
						grant_x = recv_msg.i;
    1643:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
    1649:	e9 5c f7 ff ff       	jmp    daa <main+0xdaa>
							for(int l =0;l<size;l++){
    164e:	89 f3                	mov    %esi,%ebx
    1650:	31 c0                	xor    %eax,%eax
    1652:	8b b5 48 ff ff ff    	mov    -0xb8(%ebp),%esi
    1658:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
    165e:	eb 12                	jmp    1672 <main+0x1672>
    1660:	89 c1                	mov    %eax,%ecx
    1662:	c1 e1 04             	shl    $0x4,%ecx
								if(mqueue[l].ts > recv_msg.ts){
    1665:	39 7c 0a 0c          	cmp    %edi,0xc(%edx,%ecx,1)
    1669:	0f 8f 3c 05 00 00    	jg     1bab <main+0x1bab>
							for(int l =0;l<size;l++){
    166f:	83 c0 01             	add    $0x1,%eax
    1672:	39 c6                	cmp    %eax,%esi
    1674:	75 ea                	jne    1660 <main+0x1660>
    1676:	89 de                	mov    %ebx,%esi
    1678:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
								mqueue[size].i = recv_msg.i;
    167e:	8b 8d 24 ff ff ff    	mov    -0xdc(%ebp),%ecx
    1684:	89 d8                	mov    %ebx,%eax
								size++;								
    1686:	83 c3 01             	add    $0x1,%ebx
    1689:	c1 e0 04             	shl    $0x4,%eax
    168c:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
    1692:	89 9d 48 ff ff ff    	mov    %ebx,-0xb8(%ebp)
								mqueue[size].i = recv_msg.i;
    1698:	89 48 04             	mov    %ecx,0x4(%eax)
								mqueue[size].j = recv_msg.j;
    169b:	8b 8d 1c ff ff ff    	mov    -0xe4(%ebp),%ecx
								mqueue[size].msg_type = recv_msg.msg_type;
    16a1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
								mqueue[size].ts = recv_msg.ts;
    16a7:	89 78 0c             	mov    %edi,0xc(%eax)
								mqueue[size].j = recv_msg.j;
    16aa:	89 48 08             	mov    %ecx,0x8(%eax)
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
    16ad:	50                   	push   %eax
    16ae:	8d 45 d8             	lea    -0x28(%ebp),%eax
    16b1:	6a 10                	push   $0x10
    16b3:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
									send_msg.msg_type = 3;
    16b9:	c7 45 d8 03 00 00 00 	movl   $0x3,-0x28(%ebp)
									write(p[recv_msg.i][recv_msg.j][1],&send_msg,(sizeof(send_msg)));									
    16c0:	50                   	push   %eax
    16c1:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
    16c7:	0f af 95 40 ff ff ff 	imul   -0xc0(%ebp),%edx
    16ce:	01 c0                	add    %eax,%eax
    16d0:	e9 c5 f8 ff ff       	jmp    f9a <main+0xf9a>
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    16d5:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    16db:	8b 9d 1c ff ff ff    	mov    -0xe4(%ebp),%ebx
    16e1:	0f af 95 24 ff ff ff 	imul   -0xdc(%ebp),%edx
    16e8:	50                   	push   %eax
    16e9:	8d 45 d8             	lea    -0x28(%ebp),%eax
    16ec:	6a 10                	push   $0x10
    16ee:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
						send_msg.msg_type = 2;
    16f4:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    16fb:	50                   	push   %eax
    16fc:	89 d8                	mov    %ebx,%eax
    16fe:	01 d8                	add    %ebx,%eax
    1700:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1704:	ff 34 81             	pushl  (%ecx,%eax,4)
    1707:	e8 16 0b 00 00       	call   2222 <write>
						grant_x = recv_msg.i;
    170c:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
    1712:	83 c4 10             	add    $0x10,%esp
    1715:	89 bd 20 ff ff ff    	mov    %edi,-0xe0(%ebp)
						grant_y = recv_msg.j;
    171b:	89 9d 0c ff ff ff    	mov    %ebx,-0xf4(%ebp)
						grant_send = 1;
    1721:	c7 85 14 ff ff ff 01 	movl   $0x1,-0xec(%ebp)
    1728:	00 00 00 
						grant_x = recv_msg.i;
    172b:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
    1731:	e9 b6 f4 ff ff       	jmp    bec <main+0xbec>
					grant_x = mqueue[0].i;
    1736:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
					for(int l =0;l<(size - 1);l++){
    173c:	31 ff                	xor    %edi,%edi
					grant_x = mqueue[0].i;
    173e:	8b 58 04             	mov    0x4(%eax),%ebx
    1741:	89 9d 24 ff ff ff    	mov    %ebx,-0xdc(%ebp)
					grant_y = mqueue[0].j;
    1747:	8b 58 08             	mov    0x8(%eax),%ebx
    174a:	89 9d 1c ff ff ff    	mov    %ebx,-0xe4(%ebp)
					grant_ts = mqueue[0].ts;
    1750:	8b 58 0c             	mov    0xc(%eax),%ebx
    1753:	89 9d fc fe ff ff    	mov    %ebx,-0x104(%ebp)
    1759:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    175f:	8d 53 ff             	lea    -0x1(%ebx),%edx
					for(int l =0;l<(size - 1);l++){
    1762:	eb 1a                	jmp    177e <main+0x177e>
							mqueue[l].msg_type = mqueue[l+1].msg_type;
    1764:	8b 08                	mov    (%eax),%ecx
    1766:	83 c7 01             	add    $0x1,%edi
    1769:	89 48 f0             	mov    %ecx,-0x10(%eax)
							mqueue[l].i = mqueue[l+1].i;
    176c:	8b 48 04             	mov    0x4(%eax),%ecx
    176f:	89 48 f4             	mov    %ecx,-0xc(%eax)
							mqueue[l].j = mqueue[l+1].j;
    1772:	8b 48 08             	mov    0x8(%eax),%ecx
    1775:	89 48 f8             	mov    %ecx,-0x8(%eax)
							mqueue[l].ts = mqueue[l+1].ts;
    1778:	8b 48 0c             	mov    0xc(%eax),%ecx
    177b:	89 48 fc             	mov    %ecx,-0x4(%eax)
    177e:	83 c0 10             	add    $0x10,%eax
					for(int l =0;l<(size - 1);l++){
    1781:	39 fa                	cmp    %edi,%edx
    1783:	7f df                	jg     1764 <main+0x1764>
    1785:	89 f3                	mov    %esi,%ebx
					for(int l =0;l<size;l++){
    1787:	31 c0                	xor    %eax,%eax
    1789:	89 95 f4 fe ff ff    	mov    %edx,-0x10c(%ebp)
    178f:	8b b5 20 ff ff ff    	mov    -0xe0(%ebp),%esi
    1795:	8b 8d 30 ff ff ff    	mov    -0xd0(%ebp),%ecx
    179b:	eb 12                	jmp    17af <main+0x17af>
    179d:	89 c7                	mov    %eax,%edi
    179f:	c1 e7 04             	shl    $0x4,%edi
						if(mqueue[l].ts > prev_ts){
    17a2:	39 74 39 0c          	cmp    %esi,0xc(%ecx,%edi,1)
    17a6:	0f 8f 05 06 00 00    	jg     1db1 <main+0x1db1>
					for(int l =0;l<size;l++){
    17ac:	83 c0 01             	add    $0x1,%eax
    17af:	39 c2                	cmp    %eax,%edx
    17b1:	7f ea                	jg     179d <main+0x179d>
    17b3:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
    17b9:	89 de                	mov    %ebx,%esi
						mqueue[size].i = prev_x;
    17bb:	8b 9d 10 ff ff ff    	mov    -0xf0(%ebp),%ebx
    17c1:	c1 e0 04             	shl    $0x4,%eax
    17c4:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
    17ca:	89 58 f4             	mov    %ebx,-0xc(%eax)
						mqueue[size].j = prev_y;
    17cd:	8b 9d 0c ff ff ff    	mov    -0xf4(%ebp),%ebx
						mqueue[size].msg_type = 1;
    17d3:	c7 40 f0 01 00 00 00 	movl   $0x1,-0x10(%eax)
						mqueue[size].j = prev_y;
    17da:	89 58 f8             	mov    %ebx,-0x8(%eax)
						mqueue[size].ts = prev_ts;
    17dd:	8b 9d 20 ff ff ff    	mov    -0xe0(%ebp),%ebx
    17e3:	89 58 fc             	mov    %ebx,-0x4(%eax)
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    17e6:	8b bd 24 ff ff ff    	mov    -0xdc(%ebp),%edi
    17ec:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    17f2:	8b 9d 1c ff ff ff    	mov    -0xe4(%ebp),%ebx
    17f8:	50                   	push   %eax
    17f9:	8d 45 d8             	lea    -0x28(%ebp),%eax
    17fc:	6a 10                	push   $0x10
    17fe:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
    1804:	0f af d7             	imul   %edi,%edx
    1807:	50                   	push   %eax
					send_msg.msg_type = 2;
    1808:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    180f:	89 d8                	mov    %ebx,%eax
    1811:	01 d8                	add    %ebx,%eax
    1813:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1817:	ff 34 81             	pushl  (%ecx,%eax,4)
    181a:	e8 03 0a 00 00       	call   2222 <write>
					grant_ts = mqueue[0].ts;
    181f:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
    1825:	83 c4 10             	add    $0x10,%esp
					grant_y = mqueue[0].j;
    1828:	89 9d 0c ff ff ff    	mov    %ebx,-0xf4(%ebp)
					grant_x = mqueue[0].i;
    182e:	89 bd 10 ff ff ff    	mov    %edi,-0xf0(%ebp)
					grant_ts = mqueue[0].ts;
    1834:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
    183a:	e9 ad f3 ff ff       	jmp    bec <main+0xbec>
					grant_x = mqueue[0].i;
    183f:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
					for(int l =0;l<(size - 1);l++){
    1845:	31 ff                	xor    %edi,%edi
					grant_x = mqueue[0].i;
    1847:	8b 58 04             	mov    0x4(%eax),%ebx
    184a:	89 9d 24 ff ff ff    	mov    %ebx,-0xdc(%ebp)
					grant_y = mqueue[0].j;
    1850:	8b 58 08             	mov    0x8(%eax),%ebx
    1853:	89 9d 1c ff ff ff    	mov    %ebx,-0xe4(%ebp)
					grant_ts = mqueue[0].ts;
    1859:	8b 58 0c             	mov    0xc(%eax),%ebx
    185c:	89 9d f8 fe ff ff    	mov    %ebx,-0x108(%ebp)
    1862:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    1868:	8d 53 ff             	lea    -0x1(%ebx),%edx
					for(int l =0;l<(size - 1);l++){
    186b:	eb 1a                	jmp    1887 <main+0x1887>
							mqueue[l].msg_type = mqueue[l+1].msg_type;
    186d:	8b 08                	mov    (%eax),%ecx
    186f:	83 c7 01             	add    $0x1,%edi
    1872:	89 48 f0             	mov    %ecx,-0x10(%eax)
							mqueue[l].i = mqueue[l+1].i;
    1875:	8b 48 04             	mov    0x4(%eax),%ecx
    1878:	89 48 f4             	mov    %ecx,-0xc(%eax)
							mqueue[l].j = mqueue[l+1].j;
    187b:	8b 48 08             	mov    0x8(%eax),%ecx
    187e:	89 48 f8             	mov    %ecx,-0x8(%eax)
							mqueue[l].ts = mqueue[l+1].ts;
    1881:	8b 48 0c             	mov    0xc(%eax),%ecx
    1884:	89 48 fc             	mov    %ecx,-0x4(%eax)
    1887:	83 c0 10             	add    $0x10,%eax
					for(int l =0;l<(size - 1);l++){
    188a:	39 fa                	cmp    %edi,%edx
    188c:	7f df                	jg     186d <main+0x186d>
    188e:	89 f3                	mov    %esi,%ebx
					for(int l =0;l<size;l++){
    1890:	31 c0                	xor    %eax,%eax
    1892:	89 95 f4 fe ff ff    	mov    %edx,-0x10c(%ebp)
    1898:	8b b5 20 ff ff ff    	mov    -0xe0(%ebp),%esi
    189e:	8b 8d 30 ff ff ff    	mov    -0xd0(%ebp),%ecx
    18a4:	eb 12                	jmp    18b8 <main+0x18b8>
    18a6:	89 c7                	mov    %eax,%edi
    18a8:	c1 e7 04             	shl    $0x4,%edi
						if(mqueue[l].ts > prev_ts){
    18ab:	39 74 39 0c          	cmp    %esi,0xc(%ecx,%edi,1)
    18af:	0f 8f 65 05 00 00    	jg     1e1a <main+0x1e1a>
					for(int l =0;l<size;l++){
    18b5:	83 c0 01             	add    $0x1,%eax
    18b8:	39 c2                	cmp    %eax,%edx
    18ba:	7f ea                	jg     18a6 <main+0x18a6>
    18bc:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
    18c2:	89 de                	mov    %ebx,%esi
						mqueue[size].i = prev_x;
    18c4:	8b 9d 14 ff ff ff    	mov    -0xec(%ebp),%ebx
    18ca:	c1 e0 04             	shl    $0x4,%eax
    18cd:	03 85 30 ff ff ff    	add    -0xd0(%ebp),%eax
    18d3:	89 58 f4             	mov    %ebx,-0xc(%eax)
						mqueue[size].j = prev_y;
    18d6:	8b 9d 0c ff ff ff    	mov    -0xf4(%ebp),%ebx
						mqueue[size].msg_type = 1;
    18dc:	c7 40 f0 01 00 00 00 	movl   $0x1,-0x10(%eax)
						mqueue[size].j = prev_y;
    18e3:	89 58 f8             	mov    %ebx,-0x8(%eax)
						mqueue[size].ts = prev_ts;
    18e6:	8b 9d 20 ff ff ff    	mov    -0xe0(%ebp),%ebx
    18ec:	89 58 fc             	mov    %ebx,-0x4(%eax)
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    18ef:	8b bd 24 ff ff ff    	mov    -0xdc(%ebp),%edi
    18f5:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    18fb:	8b 9d 1c ff ff ff    	mov    -0xe4(%ebp),%ebx
    1901:	50                   	push   %eax
    1902:	8d 45 a8             	lea    -0x58(%ebp),%eax
    1905:	6a 10                	push   $0x10
    1907:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
    190d:	0f af d7             	imul   %edi,%edx
    1910:	50                   	push   %eax
					send_msg.msg_type = 2;
    1911:	c7 45 a8 02 00 00 00 	movl   $0x2,-0x58(%ebp)
					write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1918:	89 d8                	mov    %ebx,%eax
    191a:	01 d8                	add    %ebx,%eax
    191c:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1920:	ff 34 81             	pushl  (%ecx,%eax,4)
    1923:	e8 fa 08 00 00       	call   2222 <write>
					grant_ts = mqueue[0].ts;
    1928:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
    192e:	83 c4 10             	add    $0x10,%esp
					grant_y = mqueue[0].j;
    1931:	89 9d 0c ff ff ff    	mov    %ebx,-0xf4(%ebp)
					grant_x = mqueue[0].i;
    1937:	89 bd 14 ff ff ff    	mov    %edi,-0xec(%ebp)
					grant_ts = mqueue[0].ts;
    193d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
    1943:	e9 62 f4 ff ff       	jmp    daa <main+0xdaa>
					grant_lock[recv_msg.i][recv_msg.j] = 1;
    1948:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    194e:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
    1954:	0f af 45 9c          	imul   -0x64(%ebp),%eax
    1958:	03 45 a0             	add    -0x60(%ebp),%eax
    195b:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					fail[recv_msg.i][recv_msg.j] = 0;
    1962:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
    1968:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
    196f:	e9 36 f4 ff ff       	jmp    daa <main+0xdaa>
					grant_lock[recv_msg.i][recv_msg.j] = 1;
    1974:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
    197a:	8b 9d 18 ff ff ff    	mov    -0xe8(%ebp),%ebx
    1980:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    1984:	03 45 d0             	add    -0x30(%ebp),%eax
    1987:	c7 04 83 01 00 00 00 	movl   $0x1,(%ebx,%eax,4)
					fail[recv_msg.i][recv_msg.j] = 0;
    198e:	8b 9d 08 ff ff ff    	mov    -0xf8(%ebp),%ebx
    1994:	c7 04 83 00 00 00 00 	movl   $0x0,(%ebx,%eax,4)
    199b:	e9 4c f2 ff ff       	jmp    bec <main+0xbec>
    19a0:	89 de                	mov    %ebx,%esi
    19a2:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
    19a8:	89 8d 08 ff ff ff    	mov    %ecx,-0xf8(%ebp)
    19ae:	8b 8d 30 ff ff ff    	mov    -0xd0(%ebp),%ecx
    19b4:	8b bd 0c ff ff ff    	mov    -0xf4(%ebp),%edi
    19ba:	89 d8                	mov    %ebx,%eax
    19bc:	c1 e0 04             	shl    $0x4,%eax
    19bf:	8d 44 01 f4          	lea    -0xc(%ecx,%eax,1),%eax
								if(mqueue[l].ts > recv_msg.ts){
    19c3:	89 d9                	mov    %ebx,%ecx
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    19c5:	8b 58 fc             	mov    -0x4(%eax),%ebx
    19c8:	83 e9 01             	sub    $0x1,%ecx
    19cb:	83 e8 10             	sub    $0x10,%eax
    19ce:	89 58 1c             	mov    %ebx,0x1c(%eax)
									mqueue[l].i = mqueue[l-1].i;
    19d1:	8b 58 10             	mov    0x10(%eax),%ebx
    19d4:	89 58 20             	mov    %ebx,0x20(%eax)
									mqueue[l].j = mqueue[l-1].j;
    19d7:	8b 58 14             	mov    0x14(%eax),%ebx
    19da:	89 58 24             	mov    %ebx,0x24(%eax)
									mqueue[l].ts = mqueue[l-1].ts;
    19dd:	8b 58 18             	mov    0x18(%eax),%ebx
    19e0:	89 58 28             	mov    %ebx,0x28(%eax)
								for(int l=size;l>ind;l--){
    19e3:	39 ca                	cmp    %ecx,%edx
    19e5:	7c de                	jl     19c5 <main+0x19c5>
    19e7:	8b 8d 08 ff ff ff    	mov    -0xf8(%ebp),%ecx
    19ed:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    19f3:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
								size++;
    19f9:	83 85 38 ff ff ff 01 	addl   $0x1,-0xc8(%ebp)
								mqueue[ind].i = recv_msg.i;
    1a00:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1a03:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1a09:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].j = recv_msg.j;
    1a0f:	89 41 08             	mov    %eax,0x8(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1a12:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
    1a18:	89 41 0c             	mov    %eax,0xc(%ecx)
    1a1b:	e9 8e ec ff ff       	jmp    6ae <main+0x6ae>
    1a20:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
    1a26:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
    1a2c:	8b bd 08 ff ff ff    	mov    -0xf8(%ebp),%edi
    1a32:	8b b5 0c ff ff ff    	mov    -0xf4(%ebp),%esi
								if(mqueue[l].ts > recv_msg.ts){
    1a38:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)
    1a3e:	c1 e0 04             	shl    $0x4,%eax
    1a41:	8d 44 03 f4          	lea    -0xc(%ebx,%eax,1),%eax
    1a45:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
    1a4b:	89 d9                	mov    %ebx,%ecx
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    1a4d:	8b 58 fc             	mov    -0x4(%eax),%ebx
    1a50:	83 e9 01             	sub    $0x1,%ecx
    1a53:	83 e8 10             	sub    $0x10,%eax
    1a56:	89 58 1c             	mov    %ebx,0x1c(%eax)
									mqueue[l].i = mqueue[l-1].i;
    1a59:	8b 58 10             	mov    0x10(%eax),%ebx
    1a5c:	89 58 20             	mov    %ebx,0x20(%eax)
									mqueue[l].j = mqueue[l-1].j;
    1a5f:	8b 58 14             	mov    0x14(%eax),%ebx
    1a62:	89 58 24             	mov    %ebx,0x24(%eax)
									mqueue[l].ts = mqueue[l-1].ts;
    1a65:	8b 58 18             	mov    0x18(%eax),%ebx
    1a68:	89 58 28             	mov    %ebx,0x28(%eax)
								for(int l=size;l>ind;l--){
    1a6b:	39 ca                	cmp    %ecx,%edx
    1a6d:	7c de                	jl     1a4d <main+0x1a4d>
    1a6f:	8b 8d 0c ff ff ff    	mov    -0xf4(%ebp),%ecx
    1a75:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    1a7b:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
								size++;
    1a81:	83 85 38 ff ff ff 01 	addl   $0x1,-0xc8(%ebp)
								if(ind == 0){
    1a88:	85 d2                	test   %edx,%edx
								mqueue[ind].i = recv_msg.i;
    1a8a:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1a8d:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1a93:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].j = recv_msg.j;
    1a99:	89 41 08             	mov    %eax,0x8(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1a9c:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
    1aa2:	89 41 0c             	mov    %eax,0xc(%ecx)
								if(ind == 0){
    1aa5:	0f 85 03 ec ff ff    	jne    6ae <main+0x6ae>
    1aab:	e9 1b ee ff ff       	jmp    8cb <main+0x8cb>
    1ab0:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
    1ab6:	89 de                	mov    %ebx,%esi
    1ab8:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
    1abe:	8b bd 0c ff ff ff    	mov    -0xf4(%ebp),%edi
    1ac4:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)
    1aca:	8b 8d 08 ff ff ff    	mov    -0xf8(%ebp),%ecx
    1ad0:	c1 e2 04             	shl    $0x4,%edx
    1ad3:	8d 54 13 e4          	lea    -0x1c(%ebx,%edx,1),%edx
							mqueue[l].msg_type = mqueue[l-1].msg_type;
    1ad7:	8b 5a fc             	mov    -0x4(%edx),%ebx
    1ada:	83 e9 01             	sub    $0x1,%ecx
    1add:	83 ea 10             	sub    $0x10,%edx
    1ae0:	89 5a 1c             	mov    %ebx,0x1c(%edx)
							mqueue[l].i = mqueue[l-1].i;
    1ae3:	8b 5a 10             	mov    0x10(%edx),%ebx
    1ae6:	89 5a 20             	mov    %ebx,0x20(%edx)
							mqueue[l].j = mqueue[l-1].j;
    1ae9:	8b 5a 14             	mov    0x14(%edx),%ebx
    1aec:	89 5a 24             	mov    %ebx,0x24(%edx)
							mqueue[l].ts = mqueue[l-1].ts;
    1aef:	8b 5a 18             	mov    0x18(%edx),%ebx
    1af2:	89 5a 28             	mov    %ebx,0x28(%edx)
						for(int l=size;l>ind;l--){
    1af5:	39 c8                	cmp    %ecx,%eax
    1af7:	7c de                	jl     1ad7 <main+0x1ad7>
    1af9:	8b 8d 0c ff ff ff    	mov    -0xf4(%ebp),%ecx
    1aff:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
						mqueue[ind].i = prev_x;
    1b05:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
    1b0b:	89 41 04             	mov    %eax,0x4(%ecx)
						mqueue[ind].j = prev_y;
    1b0e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
						mqueue[ind].msg_type = 1;
    1b14:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
						mqueue[ind].j = prev_y;
    1b1a:	89 41 08             	mov    %eax,0x8(%ecx)
						mqueue[ind].ts = prev_ts;
    1b1d:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
    1b23:	89 41 0c             	mov    %eax,0xc(%ecx)
    1b26:	e9 18 f8 ff ff       	jmp    1343 <main+0x1343>
    1b2b:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
    1b31:	89 de                	mov    %ebx,%esi
    1b33:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
								if(mqueue[l].ts > recv_msg.ts){
    1b39:	89 8d f8 fe ff ff    	mov    %ecx,-0x108(%ebp)
    1b3f:	c1 e0 04             	shl    $0x4,%eax
    1b42:	8d 44 03 f4          	lea    -0xc(%ebx,%eax,1),%eax
    1b46:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    1b4c:	89 d9                	mov    %ebx,%ecx
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    1b4e:	8b 58 fc             	mov    -0x4(%eax),%ebx
    1b51:	83 e9 01             	sub    $0x1,%ecx
    1b54:	83 e8 10             	sub    $0x10,%eax
    1b57:	89 58 1c             	mov    %ebx,0x1c(%eax)
									mqueue[l].i = mqueue[l-1].i;
    1b5a:	8b 58 10             	mov    0x10(%eax),%ebx
    1b5d:	89 58 20             	mov    %ebx,0x20(%eax)
									mqueue[l].j = mqueue[l-1].j;
    1b60:	8b 58 14             	mov    0x14(%eax),%ebx
    1b63:	89 58 24             	mov    %ebx,0x24(%eax)
									mqueue[l].ts = mqueue[l-1].ts;
    1b66:	8b 58 18             	mov    0x18(%eax),%ebx
    1b69:	89 58 28             	mov    %ebx,0x28(%eax)
								for(int l=size;l>ind;l--){
    1b6c:	39 d1                	cmp    %edx,%ecx
    1b6e:	7f de                	jg     1b4e <main+0x1b4e>
    1b70:	8b 8d f8 fe ff ff    	mov    -0x108(%ebp),%ecx
    1b76:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    1b7c:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
								size++;
    1b82:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
								if(ind == 0){
    1b89:	85 d2                	test   %edx,%edx
								mqueue[ind].i = recv_msg.i;
    1b8b:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1b8e:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1b94:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1b9a:	89 79 0c             	mov    %edi,0xc(%ecx)
								mqueue[ind].j = recv_msg.j;
    1b9d:	89 41 08             	mov    %eax,0x8(%ecx)
								if(ind == 0){
    1ba0:	0f 85 1f fa ff ff    	jne    15c5 <main+0x15c5>
    1ba6:	e9 fe f2 ff ff       	jmp    ea9 <main+0xea9>
    1bab:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
    1bb1:	89 de                	mov    %ebx,%esi
    1bb3:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
								if(mqueue[l].ts > recv_msg.ts){
    1bb9:	89 bd fc fe ff ff    	mov    %edi,-0x104(%ebp)
    1bbf:	c1 e2 04             	shl    $0x4,%edx
    1bc2:	8d 54 13 f4          	lea    -0xc(%ebx,%edx,1),%edx
    1bc6:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    1bcc:	89 df                	mov    %ebx,%edi
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    1bce:	8b 5a fc             	mov    -0x4(%edx),%ebx
    1bd1:	83 ef 01             	sub    $0x1,%edi
    1bd4:	83 ea 10             	sub    $0x10,%edx
    1bd7:	89 5a 1c             	mov    %ebx,0x1c(%edx)
									mqueue[l].i = mqueue[l-1].i;
    1bda:	8b 5a 10             	mov    0x10(%edx),%ebx
    1bdd:	89 5a 20             	mov    %ebx,0x20(%edx)
									mqueue[l].j = mqueue[l-1].j;
    1be0:	8b 5a 14             	mov    0x14(%edx),%ebx
    1be3:	89 5a 24             	mov    %ebx,0x24(%edx)
									mqueue[l].ts = mqueue[l-1].ts;
    1be6:	8b 5a 18             	mov    0x18(%edx),%ebx
    1be9:	89 5a 28             	mov    %ebx,0x28(%edx)
								for(int l=size;l>ind;l--){
    1bec:	39 c7                	cmp    %eax,%edi
    1bee:	7f de                	jg     1bce <main+0x1bce>
    1bf0:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    1bf6:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
    1bfc:	8b bd fc fe ff ff    	mov    -0x104(%ebp),%edi
								size++;
    1c02:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
								mqueue[ind].i = recv_msg.i;
    1c09:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1c0c:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1c12:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1c18:	89 79 0c             	mov    %edi,0xc(%ecx)
								mqueue[ind].j = recv_msg.j;
    1c1b:	89 41 08             	mov    %eax,0x8(%ecx)
    1c1e:	e9 8a fa ff ff       	jmp    16ad <main+0x16ad>
    1c23:	89 de                	mov    %ebx,%esi
    1c25:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    1c2b:	89 8d f8 fe ff ff    	mov    %ecx,-0x108(%ebp)
    1c31:	8b 8d 30 ff ff ff    	mov    -0xd0(%ebp),%ecx
    1c37:	89 da                	mov    %ebx,%edx
    1c39:	c1 e2 04             	shl    $0x4,%edx
    1c3c:	8d 54 11 f4          	lea    -0xc(%ecx,%edx,1),%edx
								if(mqueue[l].ts > recv_msg.ts){
    1c40:	89 d9                	mov    %ebx,%ecx
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    1c42:	8b 5a fc             	mov    -0x4(%edx),%ebx
    1c45:	83 e9 01             	sub    $0x1,%ecx
    1c48:	83 ea 10             	sub    $0x10,%edx
    1c4b:	89 5a 1c             	mov    %ebx,0x1c(%edx)
									mqueue[l].i = mqueue[l-1].i;
    1c4e:	8b 5a 10             	mov    0x10(%edx),%ebx
    1c51:	89 5a 20             	mov    %ebx,0x20(%edx)
									mqueue[l].j = mqueue[l-1].j;
    1c54:	8b 5a 14             	mov    0x14(%edx),%ebx
    1c57:	89 5a 24             	mov    %ebx,0x24(%edx)
									mqueue[l].ts = mqueue[l-1].ts;
    1c5a:	8b 5a 18             	mov    0x18(%edx),%ebx
    1c5d:	89 5a 28             	mov    %ebx,0x28(%edx)
								for(int l=size;l>ind;l--){
    1c60:	39 c1                	cmp    %eax,%ecx
    1c62:	7f de                	jg     1c42 <main+0x1c42>
    1c64:	8b 8d f8 fe ff ff    	mov    -0x108(%ebp),%ecx
    1c6a:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    1c70:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
								size++;
    1c76:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
								mqueue[ind].i = recv_msg.i;
    1c7d:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1c80:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1c86:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1c8c:	89 79 0c             	mov    %edi,0xc(%ecx)
								mqueue[ind].j = recv_msg.j;
    1c8f:	89 41 08             	mov    %eax,0x8(%ecx)
    1c92:	e9 2e f9 ff ff       	jmp    15c5 <main+0x15c5>
    1c97:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
    1c9d:	89 de                	mov    %ebx,%esi
    1c9f:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
								if(mqueue[l].ts > recv_msg.ts){
    1ca5:	89 bd fc fe ff ff    	mov    %edi,-0x104(%ebp)
    1cab:	c1 e0 04             	shl    $0x4,%eax
    1cae:	8d 44 03 f4          	lea    -0xc(%ebx,%eax,1),%eax
    1cb2:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
    1cb8:	89 df                	mov    %ebx,%edi
									mqueue[l].msg_type = mqueue[l-1].msg_type;
    1cba:	8b 58 fc             	mov    -0x4(%eax),%ebx
    1cbd:	83 ef 01             	sub    $0x1,%edi
    1cc0:	83 e8 10             	sub    $0x10,%eax
    1cc3:	89 58 1c             	mov    %ebx,0x1c(%eax)
									mqueue[l].i = mqueue[l-1].i;
    1cc6:	8b 58 10             	mov    0x10(%eax),%ebx
    1cc9:	89 58 20             	mov    %ebx,0x20(%eax)
									mqueue[l].j = mqueue[l-1].j;
    1ccc:	8b 58 14             	mov    0x14(%eax),%ebx
    1ccf:	89 58 24             	mov    %ebx,0x24(%eax)
									mqueue[l].ts = mqueue[l-1].ts;
    1cd2:	8b 58 18             	mov    0x18(%eax),%ebx
    1cd5:	89 58 28             	mov    %ebx,0x28(%eax)
								for(int l=size;l>ind;l--){
    1cd8:	39 d7                	cmp    %edx,%edi
    1cda:	7f de                	jg     1cba <main+0x1cba>
    1cdc:	03 8d 30 ff ff ff    	add    -0xd0(%ebp),%ecx
								mqueue[ind].i = recv_msg.i;
    1ce2:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
    1ce8:	8b bd fc fe ff ff    	mov    -0x104(%ebp),%edi
								size++;
    1cee:	83 85 48 ff ff ff 01 	addl   $0x1,-0xb8(%ebp)
								if(ind == 0){
    1cf5:	85 d2                	test   %edx,%edx
								mqueue[ind].i = recv_msg.i;
    1cf7:	89 41 04             	mov    %eax,0x4(%ecx)
								mqueue[ind].j = recv_msg.j;
    1cfa:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
								mqueue[ind].msg_type = recv_msg.msg_type;
    1d00:	c7 01 01 00 00 00    	movl   $0x1,(%ecx)
								mqueue[ind].ts = recv_msg.ts;
    1d06:	89 79 0c             	mov    %edi,0xc(%ecx)
								mqueue[ind].j = recv_msg.j;
    1d09:	89 41 08             	mov    %eax,0x8(%ecx)
								if(ind == 0){
    1d0c:	0f 85 9b f9 ff ff    	jne    16ad <main+0x16ad>
    1d12:	e9 5e f2 ff ff       	jmp    f75 <main+0xf75>
						grant_x = mqueue[0].i;
    1d17:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
						send_msg.msg_type = 2;
    1d1d:	c7 85 78 ff ff ff 02 	movl   $0x2,-0x88(%ebp)
    1d24:	00 00 00 
						grant_x = mqueue[0].i;
    1d27:	8b 53 04             	mov    0x4(%ebx),%edx
						grant_ts = mqueue[0].ts;
    1d2a:	8b 43 0c             	mov    0xc(%ebx),%eax
						grant_y = mqueue[0].j;
    1d2d:	8b 4b 08             	mov    0x8(%ebx),%ecx
						grant_x = mqueue[0].i;
    1d30:	89 95 1c ff ff ff    	mov    %edx,-0xe4(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1d36:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
    1d3c:	0f af 95 1c ff ff ff 	imul   -0xe4(%ebp),%edx
						grant_ts = mqueue[0].ts;
    1d43:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1d49:	50                   	push   %eax
    1d4a:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
    1d50:	6a 10                	push   $0x10
						grant_y = mqueue[0].j;
    1d52:	89 8d 18 ff ff ff    	mov    %ecx,-0xe8(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1d58:	50                   	push   %eax
    1d59:	89 c8                	mov    %ecx,%eax
    1d5b:	01 c8                	add    %ecx,%eax
    1d5d:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
    1d63:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1d67:	ff 34 81             	pushl  (%ecx,%eax,4)
    1d6a:	e8 b3 04 00 00       	call   2222 <write>
    1d6f:	89 d8                	mov    %ebx,%eax
    1d71:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
						for(int l =0;l<(size-1);l++){
    1d77:	83 c4 10             	add    $0x10,%esp
    1d7a:	8b 8d 50 ff ff ff    	mov    -0xb0(%ebp),%ecx
    1d80:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1d83:	eb 1a                	jmp    1d9f <main+0x1d9f>
								mqueue[l].msg_type = mqueue[l+1].msg_type;
    1d85:	8b 18                	mov    (%eax),%ebx
    1d87:	83 c1 01             	add    $0x1,%ecx
    1d8a:	89 58 f0             	mov    %ebx,-0x10(%eax)
								mqueue[l].i = mqueue[l+1].i;
    1d8d:	8b 58 04             	mov    0x4(%eax),%ebx
    1d90:	89 58 f4             	mov    %ebx,-0xc(%eax)
								mqueue[l].j = mqueue[l+1].j;
    1d93:	8b 58 08             	mov    0x8(%eax),%ebx
    1d96:	89 58 f8             	mov    %ebx,-0x8(%eax)
								mqueue[l].ts = mqueue[l+1].ts;
    1d99:	8b 58 0c             	mov    0xc(%eax),%ebx
    1d9c:	89 58 fc             	mov    %ebx,-0x4(%eax)
    1d9f:	83 c0 10             	add    $0x10,%eax
						for(int l =0;l<(size-1);l++){
    1da2:	39 d1                	cmp    %edx,%ecx
    1da4:	7c df                	jl     1d85 <main+0x1d85>
    1da6:	89 95 38 ff ff ff    	mov    %edx,-0xc8(%ebp)
    1dac:	e9 a4 e7 ff ff       	jmp    555 <main+0x555>
    1db1:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
    1db7:	89 de                	mov    %ebx,%esi
    1db9:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
    1dbf:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    1dc5:	c1 e2 04             	shl    $0x4,%edx
    1dc8:	8d 54 13 e4          	lea    -0x1c(%ebx,%edx,1),%edx
							mqueue[l].msg_type = mqueue[l-1].msg_type;
    1dcc:	8b 5a fc             	mov    -0x4(%edx),%ebx
    1dcf:	83 e9 01             	sub    $0x1,%ecx
    1dd2:	83 ea 10             	sub    $0x10,%edx
    1dd5:	89 5a 1c             	mov    %ebx,0x1c(%edx)
							mqueue[l].i = mqueue[l-1].i;
    1dd8:	8b 5a 10             	mov    0x10(%edx),%ebx
    1ddb:	89 5a 20             	mov    %ebx,0x20(%edx)
							mqueue[l].j = mqueue[l-1].j;
    1dde:	8b 5a 14             	mov    0x14(%edx),%ebx
    1de1:	89 5a 24             	mov    %ebx,0x24(%edx)
							mqueue[l].ts = mqueue[l-1].ts;
    1de4:	8b 5a 18             	mov    0x18(%edx),%ebx
    1de7:	89 5a 28             	mov    %ebx,0x28(%edx)
						for(int l=size;l>ind;l--){
    1dea:	39 c1                	cmp    %eax,%ecx
    1dec:	7f de                	jg     1dcc <main+0x1dcc>
    1dee:	03 bd 30 ff ff ff    	add    -0xd0(%ebp),%edi
						mqueue[ind].i = prev_x;
    1df4:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
    1dfa:	89 47 04             	mov    %eax,0x4(%edi)
						mqueue[ind].j = prev_y;
    1dfd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
						mqueue[ind].msg_type = 1;
    1e03:	c7 07 01 00 00 00    	movl   $0x1,(%edi)
						mqueue[ind].j = prev_y;
    1e09:	89 47 08             	mov    %eax,0x8(%edi)
						mqueue[ind].ts = prev_ts;
    1e0c:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
    1e12:	89 47 0c             	mov    %eax,0xc(%edi)
    1e15:	e9 cc f9 ff ff       	jmp    17e6 <main+0x17e6>
    1e1a:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
    1e20:	89 de                	mov    %ebx,%esi
    1e22:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
    1e28:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    1e2e:	c1 e2 04             	shl    $0x4,%edx
    1e31:	8d 54 13 e4          	lea    -0x1c(%ebx,%edx,1),%edx
							mqueue[l].msg_type = mqueue[l-1].msg_type;
    1e35:	8b 5a fc             	mov    -0x4(%edx),%ebx
    1e38:	83 e9 01             	sub    $0x1,%ecx
    1e3b:	83 ea 10             	sub    $0x10,%edx
    1e3e:	89 5a 1c             	mov    %ebx,0x1c(%edx)
							mqueue[l].i = mqueue[l-1].i;
    1e41:	8b 5a 10             	mov    0x10(%edx),%ebx
    1e44:	89 5a 20             	mov    %ebx,0x20(%edx)
							mqueue[l].j = mqueue[l-1].j;
    1e47:	8b 5a 14             	mov    0x14(%edx),%ebx
    1e4a:	89 5a 24             	mov    %ebx,0x24(%edx)
							mqueue[l].ts = mqueue[l-1].ts;
    1e4d:	8b 5a 18             	mov    0x18(%edx),%ebx
    1e50:	89 5a 28             	mov    %ebx,0x28(%edx)
						for(int l=size;l>ind;l--){
    1e53:	39 c1                	cmp    %eax,%ecx
    1e55:	7f de                	jg     1e35 <main+0x1e35>
    1e57:	03 bd 30 ff ff ff    	add    -0xd0(%ebp),%edi
						mqueue[ind].i = prev_x;
    1e5d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
    1e63:	89 47 04             	mov    %eax,0x4(%edi)
						mqueue[ind].j = prev_y;
    1e66:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
						mqueue[ind].msg_type = 1;
    1e6c:	c7 07 01 00 00 00    	movl   $0x1,(%edi)
						mqueue[ind].j = prev_y;
    1e72:	89 47 08             	mov    %eax,0x8(%edi)
						mqueue[ind].ts = prev_ts;
    1e75:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
    1e7b:	89 47 0c             	mov    %eax,0xc(%edi)
    1e7e:	e9 6c fa ff ff       	jmp    18ef <main+0x18ef>
						grant_x = mqueue[0].i;
    1e83:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1e89:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
						send_msg.msg_type = 2;
    1e8f:	c7 45 a8 02 00 00 00 	movl   $0x2,-0x58(%ebp)
						grant_ts = mqueue[0].ts;
    1e96:	8b 43 0c             	mov    0xc(%ebx),%eax
						grant_x = mqueue[0].i;
    1e99:	8b 7b 04             	mov    0x4(%ebx),%edi
						grant_y = mqueue[0].j;
    1e9c:	8b 4b 08             	mov    0x8(%ebx),%ecx
						grant_ts = mqueue[0].ts;
    1e9f:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1ea5:	50                   	push   %eax
    1ea6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    1ea9:	0f af d7             	imul   %edi,%edx
    1eac:	6a 10                	push   $0x10
						grant_y = mqueue[0].j;
    1eae:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1eb4:	50                   	push   %eax
    1eb5:	89 c8                	mov    %ecx,%eax
						grant_x = mqueue[0].i;
    1eb7:	89 bd 14 ff ff ff    	mov    %edi,-0xec(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1ebd:	01 c8                	add    %ecx,%eax
    1ebf:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
    1ec5:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1ec9:	ff 34 81             	pushl  (%ecx,%eax,4)
    1ecc:	e8 51 03 00 00       	call   2222 <write>
    1ed1:	89 d8                	mov    %ebx,%eax
    1ed3:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
						for(int l =0;l<(size-1);l++){
    1ed9:	83 c4 10             	add    $0x10,%esp
    1edc:	31 c9                	xor    %ecx,%ecx
    1ede:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1ee1:	eb 1a                	jmp    1efd <main+0x1efd>
								mqueue[l].msg_type = mqueue[l+1].msg_type;
    1ee3:	8b 38                	mov    (%eax),%edi
    1ee5:	83 c1 01             	add    $0x1,%ecx
    1ee8:	89 78 f0             	mov    %edi,-0x10(%eax)
								mqueue[l].i = mqueue[l+1].i;
    1eeb:	8b 78 04             	mov    0x4(%eax),%edi
    1eee:	89 78 f4             	mov    %edi,-0xc(%eax)
								mqueue[l].j = mqueue[l+1].j;
    1ef1:	8b 78 08             	mov    0x8(%eax),%edi
    1ef4:	89 78 f8             	mov    %edi,-0x8(%eax)
								mqueue[l].ts = mqueue[l+1].ts;
    1ef7:	8b 78 0c             	mov    0xc(%eax),%edi
    1efa:	89 78 fc             	mov    %edi,-0x4(%eax)
    1efd:	83 c0 10             	add    $0x10,%eax
						for(int l =0;l<(size-1);l++){
    1f00:	39 ca                	cmp    %ecx,%edx
    1f02:	7f df                	jg     1ee3 <main+0x1ee3>
    1f04:	89 95 48 ff ff ff    	mov    %edx,-0xb8(%ebp)
    1f0a:	e9 9b ee ff ff       	jmp    daa <main+0xdaa>
						grant_x = mqueue[0].i;
    1f0f:	8b 9d 30 ff ff ff    	mov    -0xd0(%ebp),%ebx
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1f15:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
						send_msg.msg_type = 2;
    1f1b:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
						grant_ts = mqueue[0].ts;
    1f22:	8b 43 0c             	mov    0xc(%ebx),%eax
						grant_x = mqueue[0].i;
    1f25:	8b 7b 04             	mov    0x4(%ebx),%edi
						grant_y = mqueue[0].j;
    1f28:	8b 4b 08             	mov    0x8(%ebx),%ecx
						grant_ts = mqueue[0].ts;
    1f2b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1f31:	50                   	push   %eax
    1f32:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1f35:	0f af d7             	imul   %edi,%edx
    1f38:	6a 10                	push   $0x10
						grant_y = mqueue[0].j;
    1f3a:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1f40:	50                   	push   %eax
    1f41:	89 c8                	mov    %ecx,%eax
						grant_x = mqueue[0].i;
    1f43:	89 bd 10 ff ff ff    	mov    %edi,-0xf0(%ebp)
						write(p[grant_x][grant_y][1],&send_msg,(sizeof(send_msg)));
    1f49:	01 c8                	add    %ecx,%eax
    1f4b:	8b 8d 44 ff ff ff    	mov    -0xbc(%ebp),%ecx
    1f51:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
    1f55:	ff 34 81             	pushl  (%ecx,%eax,4)
    1f58:	e8 c5 02 00 00       	call   2222 <write>
    1f5d:	89 d8                	mov    %ebx,%eax
    1f5f:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
						for(int l =0;l<(size-1);l++){
    1f65:	83 c4 10             	add    $0x10,%esp
    1f68:	31 c9                	xor    %ecx,%ecx
    1f6a:	8d 53 ff             	lea    -0x1(%ebx),%edx
    1f6d:	eb 1a                	jmp    1f89 <main+0x1f89>
								mqueue[l].msg_type = mqueue[l+1].msg_type;
    1f6f:	8b 38                	mov    (%eax),%edi
    1f71:	83 c1 01             	add    $0x1,%ecx
    1f74:	89 78 f0             	mov    %edi,-0x10(%eax)
								mqueue[l].i = mqueue[l+1].i;
    1f77:	8b 78 04             	mov    0x4(%eax),%edi
    1f7a:	89 78 f4             	mov    %edi,-0xc(%eax)
								mqueue[l].j = mqueue[l+1].j;
    1f7d:	8b 78 08             	mov    0x8(%eax),%edi
    1f80:	89 78 f8             	mov    %edi,-0x8(%eax)
								mqueue[l].ts = mqueue[l+1].ts;
    1f83:	8b 78 0c             	mov    0xc(%eax),%edi
    1f86:	89 78 fc             	mov    %edi,-0x4(%eax)
    1f89:	83 c0 10             	add    $0x10,%eax
						for(int l =0;l<(size-1);l++){
    1f8c:	39 ca                	cmp    %ecx,%edx
    1f8e:	7f df                	jg     1f6f <main+0x1f6f>
    1f90:	89 95 48 ff ff ff    	mov    %edx,-0xb8(%ebp)
    1f96:	e9 51 ec ff ff       	jmp    bec <main+0xbec>
		printf(1,"Wrong Input\n");
    1f9b:	52                   	push   %edx
    1f9c:	52                   	push   %edx
    1f9d:	68 34 27 00 00       	push   $0x2734
    1fa2:	6a 01                	push   $0x1
    1fa4:	e8 27 04 00 00       	call   23d0 <printf>
		exit();
    1fa9:	e8 54 02 00 00       	call   2202 <exit>
    1fae:	66 90                	xchg   %ax,%ax

00001fb0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1fb0:	55                   	push   %ebp
    1fb1:	89 e5                	mov    %esp,%ebp
    1fb3:	53                   	push   %ebx
    1fb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1fba:	89 c2                	mov    %eax,%edx
    1fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1fc0:	83 c1 01             	add    $0x1,%ecx
    1fc3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1fc7:	83 c2 01             	add    $0x1,%edx
    1fca:	84 db                	test   %bl,%bl
    1fcc:	88 5a ff             	mov    %bl,-0x1(%edx)
    1fcf:	75 ef                	jne    1fc0 <strcpy+0x10>
    ;
  return os;
}
    1fd1:	5b                   	pop    %ebx
    1fd2:	5d                   	pop    %ebp
    1fd3:	c3                   	ret    
    1fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001fe0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1fe0:	55                   	push   %ebp
    1fe1:	89 e5                	mov    %esp,%ebp
    1fe3:	53                   	push   %ebx
    1fe4:	8b 55 08             	mov    0x8(%ebp),%edx
    1fe7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    1fea:	0f b6 02             	movzbl (%edx),%eax
    1fed:	0f b6 19             	movzbl (%ecx),%ebx
    1ff0:	84 c0                	test   %al,%al
    1ff2:	75 1c                	jne    2010 <strcmp+0x30>
    1ff4:	eb 2a                	jmp    2020 <strcmp+0x40>
    1ff6:	8d 76 00             	lea    0x0(%esi),%esi
    1ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    2000:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    2003:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    2006:	83 c1 01             	add    $0x1,%ecx
    2009:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    200c:	84 c0                	test   %al,%al
    200e:	74 10                	je     2020 <strcmp+0x40>
    2010:	38 d8                	cmp    %bl,%al
    2012:	74 ec                	je     2000 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    2014:	29 d8                	sub    %ebx,%eax
}
    2016:	5b                   	pop    %ebx
    2017:	5d                   	pop    %ebp
    2018:	c3                   	ret    
    2019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2020:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    2022:	29 d8                	sub    %ebx,%eax
}
    2024:	5b                   	pop    %ebx
    2025:	5d                   	pop    %ebp
    2026:	c3                   	ret    
    2027:	89 f6                	mov    %esi,%esi
    2029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002030 <strlen>:

uint
strlen(const char *s)
{
    2030:	55                   	push   %ebp
    2031:	89 e5                	mov    %esp,%ebp
    2033:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    2036:	80 39 00             	cmpb   $0x0,(%ecx)
    2039:	74 15                	je     2050 <strlen+0x20>
    203b:	31 d2                	xor    %edx,%edx
    203d:	8d 76 00             	lea    0x0(%esi),%esi
    2040:	83 c2 01             	add    $0x1,%edx
    2043:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    2047:	89 d0                	mov    %edx,%eax
    2049:	75 f5                	jne    2040 <strlen+0x10>
    ;
  return n;
}
    204b:	5d                   	pop    %ebp
    204c:	c3                   	ret    
    204d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    2050:	31 c0                	xor    %eax,%eax
}
    2052:	5d                   	pop    %ebp
    2053:	c3                   	ret    
    2054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    205a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002060 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2060:	55                   	push   %ebp
    2061:	89 e5                	mov    %esp,%ebp
    2063:	57                   	push   %edi
    2064:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    2067:	8b 4d 10             	mov    0x10(%ebp),%ecx
    206a:	8b 45 0c             	mov    0xc(%ebp),%eax
    206d:	89 d7                	mov    %edx,%edi
    206f:	fc                   	cld    
    2070:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    2072:	89 d0                	mov    %edx,%eax
    2074:	5f                   	pop    %edi
    2075:	5d                   	pop    %ebp
    2076:	c3                   	ret    
    2077:	89 f6                	mov    %esi,%esi
    2079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002080 <strchr>:

char*
strchr(const char *s, char c)
{
    2080:	55                   	push   %ebp
    2081:	89 e5                	mov    %esp,%ebp
    2083:	53                   	push   %ebx
    2084:	8b 45 08             	mov    0x8(%ebp),%eax
    2087:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    208a:	0f b6 10             	movzbl (%eax),%edx
    208d:	84 d2                	test   %dl,%dl
    208f:	74 1d                	je     20ae <strchr+0x2e>
    if(*s == c)
    2091:	38 d3                	cmp    %dl,%bl
    2093:	89 d9                	mov    %ebx,%ecx
    2095:	75 0d                	jne    20a4 <strchr+0x24>
    2097:	eb 17                	jmp    20b0 <strchr+0x30>
    2099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    20a0:	38 ca                	cmp    %cl,%dl
    20a2:	74 0c                	je     20b0 <strchr+0x30>
  for(; *s; s++)
    20a4:	83 c0 01             	add    $0x1,%eax
    20a7:	0f b6 10             	movzbl (%eax),%edx
    20aa:	84 d2                	test   %dl,%dl
    20ac:	75 f2                	jne    20a0 <strchr+0x20>
      return (char*)s;
  return 0;
    20ae:	31 c0                	xor    %eax,%eax
}
    20b0:	5b                   	pop    %ebx
    20b1:	5d                   	pop    %ebp
    20b2:	c3                   	ret    
    20b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    20b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000020c0 <gets>:

char*
gets(char *buf, int max)
{
    20c0:	55                   	push   %ebp
    20c1:	89 e5                	mov    %esp,%ebp
    20c3:	57                   	push   %edi
    20c4:	56                   	push   %esi
    20c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    20c6:	31 f6                	xor    %esi,%esi
    20c8:	89 f3                	mov    %esi,%ebx
{
    20ca:	83 ec 1c             	sub    $0x1c,%esp
    20cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    20d0:	eb 2f                	jmp    2101 <gets+0x41>
    20d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    20d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    20db:	83 ec 04             	sub    $0x4,%esp
    20de:	6a 01                	push   $0x1
    20e0:	50                   	push   %eax
    20e1:	6a 00                	push   $0x0
    20e3:	e8 32 01 00 00       	call   221a <read>
    if(cc < 1)
    20e8:	83 c4 10             	add    $0x10,%esp
    20eb:	85 c0                	test   %eax,%eax
    20ed:	7e 1c                	jle    210b <gets+0x4b>
      break;
    buf[i++] = c;
    20ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    20f3:	83 c7 01             	add    $0x1,%edi
    20f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    20f9:	3c 0a                	cmp    $0xa,%al
    20fb:	74 23                	je     2120 <gets+0x60>
    20fd:	3c 0d                	cmp    $0xd,%al
    20ff:	74 1f                	je     2120 <gets+0x60>
  for(i=0; i+1 < max; ){
    2101:	83 c3 01             	add    $0x1,%ebx
    2104:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    2107:	89 fe                	mov    %edi,%esi
    2109:	7c cd                	jl     20d8 <gets+0x18>
    210b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    210d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    2110:	c6 03 00             	movb   $0x0,(%ebx)
}
    2113:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2116:	5b                   	pop    %ebx
    2117:	5e                   	pop    %esi
    2118:	5f                   	pop    %edi
    2119:	5d                   	pop    %ebp
    211a:	c3                   	ret    
    211b:	90                   	nop
    211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2120:	8b 75 08             	mov    0x8(%ebp),%esi
    2123:	8b 45 08             	mov    0x8(%ebp),%eax
    2126:	01 de                	add    %ebx,%esi
    2128:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    212a:	c6 03 00             	movb   $0x0,(%ebx)
}
    212d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2130:	5b                   	pop    %ebx
    2131:	5e                   	pop    %esi
    2132:	5f                   	pop    %edi
    2133:	5d                   	pop    %ebp
    2134:	c3                   	ret    
    2135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002140 <stat>:

int
stat(const char *n, struct stat *st)
{
    2140:	55                   	push   %ebp
    2141:	89 e5                	mov    %esp,%ebp
    2143:	56                   	push   %esi
    2144:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2145:	83 ec 08             	sub    $0x8,%esp
    2148:	6a 00                	push   $0x0
    214a:	ff 75 08             	pushl  0x8(%ebp)
    214d:	e8 f0 00 00 00       	call   2242 <open>
  if(fd < 0)
    2152:	83 c4 10             	add    $0x10,%esp
    2155:	85 c0                	test   %eax,%eax
    2157:	78 27                	js     2180 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    2159:	83 ec 08             	sub    $0x8,%esp
    215c:	ff 75 0c             	pushl  0xc(%ebp)
    215f:	89 c3                	mov    %eax,%ebx
    2161:	50                   	push   %eax
    2162:	e8 f3 00 00 00       	call   225a <fstat>
  /// ADDED

    // st->cid = fd->cid;

  ///
  close(fd);
    2167:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    216a:	89 c6                	mov    %eax,%esi
  close(fd);
    216c:	e8 b9 00 00 00       	call   222a <close>
  return r;
    2171:	83 c4 10             	add    $0x10,%esp
}
    2174:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2177:	89 f0                	mov    %esi,%eax
    2179:	5b                   	pop    %ebx
    217a:	5e                   	pop    %esi
    217b:	5d                   	pop    %ebp
    217c:	c3                   	ret    
    217d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    2180:	be ff ff ff ff       	mov    $0xffffffff,%esi
    2185:	eb ed                	jmp    2174 <stat+0x34>
    2187:	89 f6                	mov    %esi,%esi
    2189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002190 <atoi>:

int
atoi(const char *s)
{
    2190:	55                   	push   %ebp
    2191:	89 e5                	mov    %esp,%ebp
    2193:	53                   	push   %ebx
    2194:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2197:	0f be 11             	movsbl (%ecx),%edx
    219a:	8d 42 d0             	lea    -0x30(%edx),%eax
    219d:	3c 09                	cmp    $0x9,%al
  n = 0;
    219f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    21a4:	77 1f                	ja     21c5 <atoi+0x35>
    21a6:	8d 76 00             	lea    0x0(%esi),%esi
    21a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    21b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    21b3:	83 c1 01             	add    $0x1,%ecx
    21b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    21ba:	0f be 11             	movsbl (%ecx),%edx
    21bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    21c0:	80 fb 09             	cmp    $0x9,%bl
    21c3:	76 eb                	jbe    21b0 <atoi+0x20>
  return n;
}
    21c5:	5b                   	pop    %ebx
    21c6:	5d                   	pop    %ebp
    21c7:	c3                   	ret    
    21c8:	90                   	nop
    21c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000021d0 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
    21d0:	55                   	push   %ebp
    21d1:	89 e5                	mov    %esp,%ebp
    21d3:	56                   	push   %esi
    21d4:	53                   	push   %ebx
    21d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    21d8:	8b 45 08             	mov    0x8(%ebp),%eax
    21db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    21de:	85 db                	test   %ebx,%ebx
    21e0:	7e 14                	jle    21f6 <memmove+0x26>
    21e2:	31 d2                	xor    %edx,%edx
    21e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    21e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    21ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    21ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    21f2:	39 d3                	cmp    %edx,%ebx
    21f4:	75 f2                	jne    21e8 <memmove+0x18>
  return vdst;
}
    21f6:	5b                   	pop    %ebx
    21f7:	5e                   	pop    %esi
    21f8:	5d                   	pop    %ebp
    21f9:	c3                   	ret    

000021fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    21fa:	b8 01 00 00 00       	mov    $0x1,%eax
    21ff:	cd 40                	int    $0x40
    2201:	c3                   	ret    

00002202 <exit>:
SYSCALL(exit)
    2202:	b8 02 00 00 00       	mov    $0x2,%eax
    2207:	cd 40                	int    $0x40
    2209:	c3                   	ret    

0000220a <wait>:
SYSCALL(wait)
    220a:	b8 03 00 00 00       	mov    $0x3,%eax
    220f:	cd 40                	int    $0x40
    2211:	c3                   	ret    

00002212 <pipe>:
SYSCALL(pipe)
    2212:	b8 04 00 00 00       	mov    $0x4,%eax
    2217:	cd 40                	int    $0x40
    2219:	c3                   	ret    

0000221a <read>:
SYSCALL(read)
    221a:	b8 05 00 00 00       	mov    $0x5,%eax
    221f:	cd 40                	int    $0x40
    2221:	c3                   	ret    

00002222 <write>:
SYSCALL(write)
    2222:	b8 10 00 00 00       	mov    $0x10,%eax
    2227:	cd 40                	int    $0x40
    2229:	c3                   	ret    

0000222a <close>:
SYSCALL(close)
    222a:	b8 15 00 00 00       	mov    $0x15,%eax
    222f:	cd 40                	int    $0x40
    2231:	c3                   	ret    

00002232 <kill>:
SYSCALL(kill)
    2232:	b8 06 00 00 00       	mov    $0x6,%eax
    2237:	cd 40                	int    $0x40
    2239:	c3                   	ret    

0000223a <exec>:
SYSCALL(exec)
    223a:	b8 07 00 00 00       	mov    $0x7,%eax
    223f:	cd 40                	int    $0x40
    2241:	c3                   	ret    

00002242 <open>:
SYSCALL(open)
    2242:	b8 0f 00 00 00       	mov    $0xf,%eax
    2247:	cd 40                	int    $0x40
    2249:	c3                   	ret    

0000224a <mknod>:
SYSCALL(mknod)
    224a:	b8 11 00 00 00       	mov    $0x11,%eax
    224f:	cd 40                	int    $0x40
    2251:	c3                   	ret    

00002252 <unlink>:
SYSCALL(unlink)
    2252:	b8 12 00 00 00       	mov    $0x12,%eax
    2257:	cd 40                	int    $0x40
    2259:	c3                   	ret    

0000225a <fstat>:
SYSCALL(fstat)
    225a:	b8 08 00 00 00       	mov    $0x8,%eax
    225f:	cd 40                	int    $0x40
    2261:	c3                   	ret    

00002262 <link>:
SYSCALL(link)
    2262:	b8 13 00 00 00       	mov    $0x13,%eax
    2267:	cd 40                	int    $0x40
    2269:	c3                   	ret    

0000226a <mkdir>:
SYSCALL(mkdir)
    226a:	b8 14 00 00 00       	mov    $0x14,%eax
    226f:	cd 40                	int    $0x40
    2271:	c3                   	ret    

00002272 <chdir>:
SYSCALL(chdir)
    2272:	b8 09 00 00 00       	mov    $0x9,%eax
    2277:	cd 40                	int    $0x40
    2279:	c3                   	ret    

0000227a <dup>:
SYSCALL(dup)
    227a:	b8 0a 00 00 00       	mov    $0xa,%eax
    227f:	cd 40                	int    $0x40
    2281:	c3                   	ret    

00002282 <getpid>:
SYSCALL(getpid)
    2282:	b8 0b 00 00 00       	mov    $0xb,%eax
    2287:	cd 40                	int    $0x40
    2289:	c3                   	ret    

0000228a <sbrk>:
SYSCALL(sbrk)
    228a:	b8 0c 00 00 00       	mov    $0xc,%eax
    228f:	cd 40                	int    $0x40
    2291:	c3                   	ret    

00002292 <sleep>:
SYSCALL(sleep)
    2292:	b8 0d 00 00 00       	mov    $0xd,%eax
    2297:	cd 40                	int    $0x40
    2299:	c3                   	ret    

0000229a <uptime>:
SYSCALL(uptime)
    229a:	b8 0e 00 00 00       	mov    $0xe,%eax
    229f:	cd 40                	int    $0x40
    22a1:	c3                   	ret    

000022a2 <toggle>:
SYSCALL(toggle)
    22a2:	b8 16 00 00 00       	mov    $0x16,%eax
    22a7:	cd 40                	int    $0x40
    22a9:	c3                   	ret    

000022aa <add>:
SYSCALL(add)
    22aa:	b8 17 00 00 00       	mov    $0x17,%eax
    22af:	cd 40                	int    $0x40
    22b1:	c3                   	ret    

000022b2 <ps>:
SYSCALL(ps)
    22b2:	b8 18 00 00 00       	mov    $0x18,%eax
    22b7:	cd 40                	int    $0x40
    22b9:	c3                   	ret    

000022ba <send>:
SYSCALL(send)
    22ba:	b8 19 00 00 00       	mov    $0x19,%eax
    22bf:	cd 40                	int    $0x40
    22c1:	c3                   	ret    

000022c2 <recv>:
SYSCALL(recv)
    22c2:	b8 1a 00 00 00       	mov    $0x1a,%eax
    22c7:	cd 40                	int    $0x40
    22c9:	c3                   	ret    

000022ca <send_multi>:
SYSCALL(send_multi)
    22ca:	b8 1b 00 00 00       	mov    $0x1b,%eax
    22cf:	cd 40                	int    $0x40
    22d1:	c3                   	ret    

000022d2 <print_count>:
SYSCALL(print_count)
    22d2:	b8 1c 00 00 00       	mov    $0x1c,%eax
    22d7:	cd 40                	int    $0x40
    22d9:	c3                   	ret    

000022da <create_container>:
SYSCALL(create_container)
    22da:	b8 1d 00 00 00       	mov    $0x1d,%eax
    22df:	cd 40                	int    $0x40
    22e1:	c3                   	ret    

000022e2 <destroy_container>:
SYSCALL(destroy_container)
    22e2:	b8 1e 00 00 00       	mov    $0x1e,%eax
    22e7:	cd 40                	int    $0x40
    22e9:	c3                   	ret    

000022ea <join_container>:
SYSCALL(join_container)
    22ea:	b8 1f 00 00 00       	mov    $0x1f,%eax
    22ef:	cd 40                	int    $0x40
    22f1:	c3                   	ret    

000022f2 <leave_container>:
SYSCALL(leave_container)
    22f2:	b8 20 00 00 00       	mov    $0x20,%eax
    22f7:	cd 40                	int    $0x40
    22f9:	c3                   	ret    

000022fa <getcid>:
SYSCALL(getcid)
    22fa:	b8 21 00 00 00       	mov    $0x21,%eax
    22ff:	cd 40                	int    $0x40
    2301:	c3                   	ret    

00002302 <p_ctable>:
SYSCALL(p_ctable)
    2302:	b8 22 00 00 00       	mov    $0x22,%eax
    2307:	cd 40                	int    $0x40
    2309:	c3                   	ret    

0000230a <sz_ctable>:
SYSCALL(sz_ctable)
    230a:	b8 23 00 00 00       	mov    $0x23,%eax
    230f:	cd 40                	int    $0x40
    2311:	c3                   	ret    

00002312 <scheduler_log_off>:
SYSCALL(scheduler_log_off)
    2312:	b8 25 00 00 00       	mov    $0x25,%eax
    2317:	cd 40                	int    $0x40
    2319:	c3                   	ret    

0000231a <scheduler_log_on>:
SYSCALL(scheduler_log_on)
    231a:	b8 24 00 00 00       	mov    $0x24,%eax
    231f:	cd 40                	int    $0x40
    2321:	c3                   	ret    
    2322:	66 90                	xchg   %ax,%ax
    2324:	66 90                	xchg   %ax,%ax
    2326:	66 90                	xchg   %ax,%ax
    2328:	66 90                	xchg   %ax,%ax
    232a:	66 90                	xchg   %ax,%ax
    232c:	66 90                	xchg   %ax,%ax
    232e:	66 90                	xchg   %ax,%ax

00002330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    2330:	55                   	push   %ebp
    2331:	89 e5                	mov    %esp,%ebp
    2333:	57                   	push   %edi
    2334:	56                   	push   %esi
    2335:	53                   	push   %ebx
    2336:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    2339:	85 d2                	test   %edx,%edx
{
    233b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    233e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    2340:	79 76                	jns    23b8 <printint+0x88>
    2342:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    2346:	74 70                	je     23b8 <printint+0x88>
    x = -xx;
    2348:	f7 d8                	neg    %eax
    neg = 1;
    234a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    2351:	31 f6                	xor    %esi,%esi
    2353:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    2356:	eb 0a                	jmp    2362 <printint+0x32>
    2358:	90                   	nop
    2359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    2360:	89 fe                	mov    %edi,%esi
    2362:	31 d2                	xor    %edx,%edx
    2364:	8d 7e 01             	lea    0x1(%esi),%edi
    2367:	f7 f1                	div    %ecx
    2369:	0f b6 92 a4 27 00 00 	movzbl 0x27a4(%edx),%edx
  }while((x /= base) != 0);
    2370:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    2372:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    2375:	75 e9                	jne    2360 <printint+0x30>
  if(neg)
    2377:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    237a:	85 c0                	test   %eax,%eax
    237c:	74 08                	je     2386 <printint+0x56>
    buf[i++] = '-';
    237e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    2383:	8d 7e 02             	lea    0x2(%esi),%edi
    2386:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    238a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    238d:	8d 76 00             	lea    0x0(%esi),%esi
    2390:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    2393:	83 ec 04             	sub    $0x4,%esp
    2396:	83 ee 01             	sub    $0x1,%esi
    2399:	6a 01                	push   $0x1
    239b:	53                   	push   %ebx
    239c:	57                   	push   %edi
    239d:	88 45 d7             	mov    %al,-0x29(%ebp)
    23a0:	e8 7d fe ff ff       	call   2222 <write>

  while(--i >= 0)
    23a5:	83 c4 10             	add    $0x10,%esp
    23a8:	39 de                	cmp    %ebx,%esi
    23aa:	75 e4                	jne    2390 <printint+0x60>
    putc(fd, buf[i]);
}
    23ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    23af:	5b                   	pop    %ebx
    23b0:	5e                   	pop    %esi
    23b1:	5f                   	pop    %edi
    23b2:	5d                   	pop    %ebp
    23b3:	c3                   	ret    
    23b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    23b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    23bf:	eb 90                	jmp    2351 <printint+0x21>
    23c1:	eb 0d                	jmp    23d0 <printf>
    23c3:	90                   	nop
    23c4:	90                   	nop
    23c5:	90                   	nop
    23c6:	90                   	nop
    23c7:	90                   	nop
    23c8:	90                   	nop
    23c9:	90                   	nop
    23ca:	90                   	nop
    23cb:	90                   	nop
    23cc:	90                   	nop
    23cd:	90                   	nop
    23ce:	90                   	nop
    23cf:	90                   	nop

000023d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    23d0:	55                   	push   %ebp
    23d1:	89 e5                	mov    %esp,%ebp
    23d3:	57                   	push   %edi
    23d4:	56                   	push   %esi
    23d5:	53                   	push   %ebx
    23d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    23d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    23dc:	0f b6 1e             	movzbl (%esi),%ebx
    23df:	84 db                	test   %bl,%bl
    23e1:	0f 84 b3 00 00 00    	je     249a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    23e7:	8d 45 10             	lea    0x10(%ebp),%eax
    23ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
    23ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    23ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    23f2:	eb 2f                	jmp    2423 <printf+0x53>
    23f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    23f8:	83 f8 25             	cmp    $0x25,%eax
    23fb:	0f 84 a7 00 00 00    	je     24a8 <printf+0xd8>
  write(fd, &c, 1);
    2401:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    2404:	83 ec 04             	sub    $0x4,%esp
    2407:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    240a:	6a 01                	push   $0x1
    240c:	50                   	push   %eax
    240d:	ff 75 08             	pushl  0x8(%ebp)
    2410:	e8 0d fe ff ff       	call   2222 <write>
    2415:	83 c4 10             	add    $0x10,%esp
    2418:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    241b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    241f:	84 db                	test   %bl,%bl
    2421:	74 77                	je     249a <printf+0xca>
    if(state == 0){
    2423:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    2425:	0f be cb             	movsbl %bl,%ecx
    2428:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    242b:	74 cb                	je     23f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    242d:	83 ff 25             	cmp    $0x25,%edi
    2430:	75 e6                	jne    2418 <printf+0x48>
      if(c == 'd'){
    2432:	83 f8 64             	cmp    $0x64,%eax
    2435:	0f 84 05 01 00 00    	je     2540 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    243b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    2441:	83 f9 70             	cmp    $0x70,%ecx
    2444:	74 72                	je     24b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2446:	83 f8 73             	cmp    $0x73,%eax
    2449:	0f 84 99 00 00 00    	je     24e8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    244f:	83 f8 63             	cmp    $0x63,%eax
    2452:	0f 84 08 01 00 00    	je     2560 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    2458:	83 f8 25             	cmp    $0x25,%eax
    245b:	0f 84 ef 00 00 00    	je     2550 <printf+0x180>
  write(fd, &c, 1);
    2461:	8d 45 e7             	lea    -0x19(%ebp),%eax
    2464:	83 ec 04             	sub    $0x4,%esp
    2467:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    246b:	6a 01                	push   $0x1
    246d:	50                   	push   %eax
    246e:	ff 75 08             	pushl  0x8(%ebp)
    2471:	e8 ac fd ff ff       	call   2222 <write>
    2476:	83 c4 0c             	add    $0xc,%esp
    2479:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    247c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    247f:	6a 01                	push   $0x1
    2481:	50                   	push   %eax
    2482:	ff 75 08             	pushl  0x8(%ebp)
    2485:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2488:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    248a:	e8 93 fd ff ff       	call   2222 <write>
  for(i = 0; fmt[i]; i++){
    248f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    2493:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    2496:	84 db                	test   %bl,%bl
    2498:	75 89                	jne    2423 <printf+0x53>
    }
  }
}
    249a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    249d:	5b                   	pop    %ebx
    249e:	5e                   	pop    %esi
    249f:	5f                   	pop    %edi
    24a0:	5d                   	pop    %ebp
    24a1:	c3                   	ret    
    24a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    24a8:	bf 25 00 00 00       	mov    $0x25,%edi
    24ad:	e9 66 ff ff ff       	jmp    2418 <printf+0x48>
    24b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    24b8:	83 ec 0c             	sub    $0xc,%esp
    24bb:	b9 10 00 00 00       	mov    $0x10,%ecx
    24c0:	6a 00                	push   $0x0
    24c2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    24c5:	8b 45 08             	mov    0x8(%ebp),%eax
    24c8:	8b 17                	mov    (%edi),%edx
    24ca:	e8 61 fe ff ff       	call   2330 <printint>
        ap++;
    24cf:	89 f8                	mov    %edi,%eax
    24d1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    24d4:	31 ff                	xor    %edi,%edi
        ap++;
    24d6:	83 c0 04             	add    $0x4,%eax
    24d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    24dc:	e9 37 ff ff ff       	jmp    2418 <printf+0x48>
    24e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    24e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    24eb:	8b 08                	mov    (%eax),%ecx
        ap++;
    24ed:	83 c0 04             	add    $0x4,%eax
    24f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    24f3:	85 c9                	test   %ecx,%ecx
    24f5:	0f 84 8e 00 00 00    	je     2589 <printf+0x1b9>
        while(*s != 0){
    24fb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    24fe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    2500:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    2502:	84 c0                	test   %al,%al
    2504:	0f 84 0e ff ff ff    	je     2418 <printf+0x48>
    250a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    250d:	89 de                	mov    %ebx,%esi
    250f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2512:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    2515:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    2518:	83 ec 04             	sub    $0x4,%esp
          s++;
    251b:	83 c6 01             	add    $0x1,%esi
    251e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    2521:	6a 01                	push   $0x1
    2523:	57                   	push   %edi
    2524:	53                   	push   %ebx
    2525:	e8 f8 fc ff ff       	call   2222 <write>
        while(*s != 0){
    252a:	0f b6 06             	movzbl (%esi),%eax
    252d:	83 c4 10             	add    $0x10,%esp
    2530:	84 c0                	test   %al,%al
    2532:	75 e4                	jne    2518 <printf+0x148>
    2534:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    2537:	31 ff                	xor    %edi,%edi
    2539:	e9 da fe ff ff       	jmp    2418 <printf+0x48>
    253e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    2540:	83 ec 0c             	sub    $0xc,%esp
    2543:	b9 0a 00 00 00       	mov    $0xa,%ecx
    2548:	6a 01                	push   $0x1
    254a:	e9 73 ff ff ff       	jmp    24c2 <printf+0xf2>
    254f:	90                   	nop
  write(fd, &c, 1);
    2550:	83 ec 04             	sub    $0x4,%esp
    2553:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    2556:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    2559:	6a 01                	push   $0x1
    255b:	e9 21 ff ff ff       	jmp    2481 <printf+0xb1>
        putc(fd, *ap);
    2560:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    2563:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    2566:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    2568:	6a 01                	push   $0x1
        ap++;
    256a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    256d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    2570:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    2573:	50                   	push   %eax
    2574:	ff 75 08             	pushl  0x8(%ebp)
    2577:	e8 a6 fc ff ff       	call   2222 <write>
        ap++;
    257c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    257f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    2582:	31 ff                	xor    %edi,%edi
    2584:	e9 8f fe ff ff       	jmp    2418 <printf+0x48>
          s = "(null)";
    2589:	bb 9c 27 00 00       	mov    $0x279c,%ebx
        while(*s != 0){
    258e:	b8 28 00 00 00       	mov    $0x28,%eax
    2593:	e9 72 ff ff ff       	jmp    250a <printf+0x13a>
    2598:	66 90                	xchg   %ax,%ax
    259a:	66 90                	xchg   %ax,%ax
    259c:	66 90                	xchg   %ax,%ax
    259e:	66 90                	xchg   %ax,%ax

000025a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    25a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    25a1:	a1 6c 2a 00 00       	mov    0x2a6c,%eax
{
    25a6:	89 e5                	mov    %esp,%ebp
    25a8:	57                   	push   %edi
    25a9:	56                   	push   %esi
    25aa:	53                   	push   %ebx
    25ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    25ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    25b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    25b8:	39 c8                	cmp    %ecx,%eax
    25ba:	8b 10                	mov    (%eax),%edx
    25bc:	73 32                	jae    25f0 <free+0x50>
    25be:	39 d1                	cmp    %edx,%ecx
    25c0:	72 04                	jb     25c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    25c2:	39 d0                	cmp    %edx,%eax
    25c4:	72 32                	jb     25f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    25c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    25c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    25cc:	39 fa                	cmp    %edi,%edx
    25ce:	74 30                	je     2600 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    25d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    25d3:	8b 50 04             	mov    0x4(%eax),%edx
    25d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    25d9:	39 f1                	cmp    %esi,%ecx
    25db:	74 3a                	je     2617 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    25dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    25df:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
}
    25e4:	5b                   	pop    %ebx
    25e5:	5e                   	pop    %esi
    25e6:	5f                   	pop    %edi
    25e7:	5d                   	pop    %ebp
    25e8:	c3                   	ret    
    25e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    25f0:	39 d0                	cmp    %edx,%eax
    25f2:	72 04                	jb     25f8 <free+0x58>
    25f4:	39 d1                	cmp    %edx,%ecx
    25f6:	72 ce                	jb     25c6 <free+0x26>
{
    25f8:	89 d0                	mov    %edx,%eax
    25fa:	eb bc                	jmp    25b8 <free+0x18>
    25fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    2600:	03 72 04             	add    0x4(%edx),%esi
    2603:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    2606:	8b 10                	mov    (%eax),%edx
    2608:	8b 12                	mov    (%edx),%edx
    260a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    260d:	8b 50 04             	mov    0x4(%eax),%edx
    2610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    2613:	39 f1                	cmp    %esi,%ecx
    2615:	75 c6                	jne    25dd <free+0x3d>
    p->s.size += bp->s.size;
    2617:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    261a:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
    p->s.size += bp->s.size;
    261f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2622:	8b 53 f8             	mov    -0x8(%ebx),%edx
    2625:	89 10                	mov    %edx,(%eax)
}
    2627:	5b                   	pop    %ebx
    2628:	5e                   	pop    %esi
    2629:	5f                   	pop    %edi
    262a:	5d                   	pop    %ebp
    262b:	c3                   	ret    
    262c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    2630:	55                   	push   %ebp
    2631:	89 e5                	mov    %esp,%ebp
    2633:	57                   	push   %edi
    2634:	56                   	push   %esi
    2635:	53                   	push   %ebx
    2636:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2639:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    263c:	8b 15 6c 2a 00 00    	mov    0x2a6c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2642:	8d 78 07             	lea    0x7(%eax),%edi
    2645:	c1 ef 03             	shr    $0x3,%edi
    2648:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    264b:	85 d2                	test   %edx,%edx
    264d:	0f 84 9d 00 00 00    	je     26f0 <malloc+0xc0>
    2653:	8b 02                	mov    (%edx),%eax
    2655:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    2658:	39 cf                	cmp    %ecx,%edi
    265a:	76 6c                	jbe    26c8 <malloc+0x98>
    265c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    2662:	bb 00 10 00 00       	mov    $0x1000,%ebx
    2667:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    266a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    2671:	eb 0e                	jmp    2681 <malloc+0x51>
    2673:	90                   	nop
    2674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    267a:	8b 48 04             	mov    0x4(%eax),%ecx
    267d:	39 f9                	cmp    %edi,%ecx
    267f:	73 47                	jae    26c8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    2681:	39 05 6c 2a 00 00    	cmp    %eax,0x2a6c
    2687:	89 c2                	mov    %eax,%edx
    2689:	75 ed                	jne    2678 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    268b:	83 ec 0c             	sub    $0xc,%esp
    268e:	56                   	push   %esi
    268f:	e8 f6 fb ff ff       	call   228a <sbrk>
  if(p == (char*)-1)
    2694:	83 c4 10             	add    $0x10,%esp
    2697:	83 f8 ff             	cmp    $0xffffffff,%eax
    269a:	74 1c                	je     26b8 <malloc+0x88>
  hp->s.size = nu;
    269c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    269f:	83 ec 0c             	sub    $0xc,%esp
    26a2:	83 c0 08             	add    $0x8,%eax
    26a5:	50                   	push   %eax
    26a6:	e8 f5 fe ff ff       	call   25a0 <free>
  return freep;
    26ab:	8b 15 6c 2a 00 00    	mov    0x2a6c,%edx
      if((p = morecore(nunits)) == 0)
    26b1:	83 c4 10             	add    $0x10,%esp
    26b4:	85 d2                	test   %edx,%edx
    26b6:	75 c0                	jne    2678 <malloc+0x48>
        return 0;
  }
}
    26b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    26bb:	31 c0                	xor    %eax,%eax
}
    26bd:	5b                   	pop    %ebx
    26be:	5e                   	pop    %esi
    26bf:	5f                   	pop    %edi
    26c0:	5d                   	pop    %ebp
    26c1:	c3                   	ret    
    26c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    26c8:	39 cf                	cmp    %ecx,%edi
    26ca:	74 54                	je     2720 <malloc+0xf0>
        p->s.size -= nunits;
    26cc:	29 f9                	sub    %edi,%ecx
    26ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    26d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    26d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    26d7:	89 15 6c 2a 00 00    	mov    %edx,0x2a6c
}
    26dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    26e0:	83 c0 08             	add    $0x8,%eax
}
    26e3:	5b                   	pop    %ebx
    26e4:	5e                   	pop    %esi
    26e5:	5f                   	pop    %edi
    26e6:	5d                   	pop    %ebp
    26e7:	c3                   	ret    
    26e8:	90                   	nop
    26e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    26f0:	c7 05 6c 2a 00 00 70 	movl   $0x2a70,0x2a6c
    26f7:	2a 00 00 
    26fa:	c7 05 70 2a 00 00 70 	movl   $0x2a70,0x2a70
    2701:	2a 00 00 
    base.s.size = 0;
    2704:	b8 70 2a 00 00       	mov    $0x2a70,%eax
    2709:	c7 05 74 2a 00 00 00 	movl   $0x0,0x2a74
    2710:	00 00 00 
    2713:	e9 44 ff ff ff       	jmp    265c <malloc+0x2c>
    2718:	90                   	nop
    2719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    2720:	8b 08                	mov    (%eax),%ecx
    2722:	89 0a                	mov    %ecx,(%edx)
    2724:	eb b1                	jmp    26d7 <malloc+0xa7>
