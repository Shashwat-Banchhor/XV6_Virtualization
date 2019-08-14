
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 24                	jle    41 <main+0x41>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 bb 00 00 00       	call   f0 <ls>
  for(i=1; i<argc; i++)
  35:	83 c4 10             	add    $0x10,%esp
  38:	39 f3                	cmp    %esi,%ebx
  3a:	75 ec                	jne    28 <main+0x28>
  exit();
  3c:	e8 21 06 00 00       	call   662 <exit>
    ls(".");
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 d0 0b 00 00       	push   $0xbd0
  49:	e8 a2 00 00 00       	call   f0 <ls>
    exit();
  4e:	e8 0f 06 00 00       	call   662 <exit>
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	57                   	push   %edi
  64:	56                   	push   %esi
  65:	53                   	push   %ebx
  66:	83 ec 0c             	sub    $0xc,%esp
  69:	8b 55 08             	mov    0x8(%ebp),%edx
  6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  for(p=path+length; p >= path && *p != '/'; p--)
  6f:	89 d0                	mov    %edx,%eax
  71:	01 f0                	add    %esi,%eax
  73:	73 12                	jae    87 <fmtname+0x27>
  75:	eb 15                	jmp    8c <fmtname+0x2c>
  77:	89 f6                	mov    %esi,%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  80:	83 e8 01             	sub    $0x1,%eax
  83:	39 c2                	cmp    %eax,%edx
  85:	77 05                	ja     8c <fmtname+0x2c>
  87:	80 38 2f             	cmpb   $0x2f,(%eax)
  8a:	75 f4                	jne    80 <fmtname+0x20>
  int net_len = strlen(path) - strlen(p);
  8c:	83 ec 0c             	sub    $0xc,%esp
  p++;
  8f:	8d 58 01             	lea    0x1(%eax),%ebx
  int net_len = strlen(path) - strlen(p);
  92:	52                   	push   %edx
  93:	e8 f8 03 00 00       	call   490 <strlen>
  98:	89 c7                	mov    %eax,%edi
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 ee 03 00 00       	call   490 <strlen>
  a2:	29 c7                	sub    %eax,%edi
  if(length >= DIRSIZ)
  a4:	83 c4 10             	add    $0x10,%esp
  length = length - net_len; 
  a7:	29 fe                	sub    %edi,%esi
  if(length >= DIRSIZ)
  a9:	83 fe 0d             	cmp    $0xd,%esi
  ac:	7f 30                	jg     de <fmtname+0x7e>
  memmove(buf, p, length);
  ae:	83 ec 04             	sub    $0x4,%esp
  b1:	56                   	push   %esi
  b2:	53                   	push   %ebx
  return buf;
  b3:	bb 00 0f 00 00       	mov    $0xf00,%ebx
  memmove(buf, p, length);
  b8:	68 00 0f 00 00       	push   $0xf00
  bd:	e8 6e 05 00 00       	call   630 <memmove>
  memset(buf+length, ' ', DIRSIZ-length);
  c2:	b8 0e 00 00 00       	mov    $0xe,%eax
  c7:	83 c4 0c             	add    $0xc,%esp
  ca:	29 f0                	sub    %esi,%eax
  cc:	81 c6 00 0f 00 00    	add    $0xf00,%esi
  d2:	50                   	push   %eax
  d3:	6a 20                	push   $0x20
  d5:	56                   	push   %esi
  d6:	e8 e5 03 00 00       	call   4c0 <memset>
  return buf;
  db:	83 c4 10             	add    $0x10,%esp
}
  de:	8d 65 f4             	lea    -0xc(%ebp),%esp
  e1:	89 d8                	mov    %ebx,%eax
  e3:	5b                   	pop    %ebx
  e4:	5e                   	pop    %esi
  e5:	5f                   	pop    %edi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <ls>:
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	56                   	push   %esi
  f5:	53                   	push   %ebx
  f6:	81 ec 64 02 00 00    	sub    $0x264,%esp
  fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
  ff:	6a 00                	push   $0x0
 101:	57                   	push   %edi
 102:	e8 9b 05 00 00       	call   6a2 <open>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	85 c0                	test   %eax,%eax
 10c:	78 52                	js     160 <ls+0x70>
  if(fstat(fd, &st) < 0){
 10e:	8d b5 cc fd ff ff    	lea    -0x234(%ebp),%esi
 114:	83 ec 08             	sub    $0x8,%esp
 117:	89 c3                	mov    %eax,%ebx
 119:	56                   	push   %esi
 11a:	50                   	push   %eax
 11b:	e8 9a 05 00 00       	call   6ba <fstat>
 120:	83 c4 10             	add    $0x10,%esp
 123:	85 c0                	test   %eax,%eax
 125:	0f 88 cd 00 00 00    	js     1f8 <ls+0x108>
  switch(st.type){
 12b:	0f b7 85 cc fd ff ff 	movzwl -0x234(%ebp),%eax
 132:	66 83 f8 01          	cmp    $0x1,%ax
 136:	0f 84 8c 00 00 00    	je     1c8 <ls+0xd8>
 13c:	66 83 f8 02          	cmp    $0x2,%ax
 140:	74 3e                	je     180 <ls+0x90>
  close(fd);
 142:	83 ec 0c             	sub    $0xc,%esp
 145:	53                   	push   %ebx
 146:	e8 3f 05 00 00       	call   68a <close>
 14b:	83 c4 10             	add    $0x10,%esp
}
 14e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 151:	5b                   	pop    %ebx
 152:	5e                   	pop    %esi
 153:	5f                   	pop    %edi
 154:	5d                   	pop    %ebp
 155:	c3                   	ret    
 156:	8d 76 00             	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot open %s\n", path);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	57                   	push   %edi
 164:	68 88 0b 00 00       	push   $0xb88
 169:	6a 02                	push   $0x2
 16b:	e8 c0 06 00 00       	call   830 <printf>
    return;
 170:	83 c4 10             	add    $0x10,%esp
}
 173:	8d 65 f4             	lea    -0xc(%ebp),%esp
 176:	5b                   	pop    %ebx
 177:	5e                   	pop    %esi
 178:	5f                   	pop    %edi
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path,strlen(path)), st.type, st.ino, st.size);
 180:	83 ec 0c             	sub    $0xc,%esp
 183:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 189:	8b b5 d4 fd ff ff    	mov    -0x22c(%ebp),%esi
 18f:	57                   	push   %edi
 190:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 196:	e8 f5 02 00 00       	call   490 <strlen>
 19b:	59                   	pop    %ecx
 19c:	5a                   	pop    %edx
 19d:	50                   	push   %eax
 19e:	57                   	push   %edi
 19f:	e8 bc fe ff ff       	call   60 <fmtname>
 1a4:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1aa:	59                   	pop    %ecx
 1ab:	5f                   	pop    %edi
 1ac:	52                   	push   %edx
 1ad:	56                   	push   %esi
 1ae:	6a 02                	push   $0x2
 1b0:	50                   	push   %eax
 1b1:	68 b0 0b 00 00       	push   $0xbb0
 1b6:	6a 01                	push   $0x1
 1b8:	e8 73 06 00 00       	call   830 <printf>
    break;
 1bd:	83 c4 20             	add    $0x20,%esp
 1c0:	eb 80                	jmp    142 <ls+0x52>
 1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c8:	83 ec 0c             	sub    $0xc,%esp
 1cb:	57                   	push   %edi
 1cc:	e8 bf 02 00 00       	call   490 <strlen>
 1d1:	83 c0 10             	add    $0x10,%eax
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	3d 00 02 00 00       	cmp    $0x200,%eax
 1dc:	76 42                	jbe    220 <ls+0x130>
      printf(1, "ls: path too long\n");
 1de:	83 ec 08             	sub    $0x8,%esp
 1e1:	68 bd 0b 00 00       	push   $0xbbd
 1e6:	6a 01                	push   $0x1
 1e8:	e8 43 06 00 00       	call   830 <printf>
      break;
 1ed:	83 c4 10             	add    $0x10,%esp
 1f0:	e9 4d ff ff ff       	jmp    142 <ls+0x52>
 1f5:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
 1f8:	83 ec 04             	sub    $0x4,%esp
 1fb:	57                   	push   %edi
 1fc:	68 9c 0b 00 00       	push   $0xb9c
 201:	6a 02                	push   $0x2
 203:	e8 28 06 00 00       	call   830 <printf>
    close(fd);
 208:	89 1c 24             	mov    %ebx,(%esp)
 20b:	e8 7a 04 00 00       	call   68a <close>
    return;
 210:	83 c4 10             	add    $0x10,%esp
}
 213:	8d 65 f4             	lea    -0xc(%ebp),%esp
 216:	5b                   	pop    %ebx
 217:	5e                   	pop    %esi
 218:	5f                   	pop    %edi
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(buf, path);
 220:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 226:	83 ec 08             	sub    $0x8,%esp
 229:	57                   	push   %edi
 22a:	50                   	push   %eax
 22b:	e8 e0 01 00 00       	call   410 <strcpy>
    p = buf+strlen(buf);
 230:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 236:	89 04 24             	mov    %eax,(%esp)
 239:	e8 52 02 00 00       	call   490 <strlen>
 23e:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 244:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 247:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 249:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 24c:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 252:	c6 00 2f             	movb   $0x2f,(%eax)
 255:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 260:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 266:	83 ec 04             	sub    $0x4,%esp
 269:	6a 10                	push   $0x10
 26b:	50                   	push   %eax
 26c:	53                   	push   %ebx
 26d:	e8 08 04 00 00       	call   67a <read>
 272:	83 c4 10             	add    $0x10,%esp
 275:	83 f8 10             	cmp    $0x10,%eax
 278:	0f 85 c4 fe ff ff    	jne    142 <ls+0x52>
      if(de.inum == 0)
 27e:	66 83 bd bc fd ff ff 	cmpw   $0x0,-0x244(%ebp)
 285:	00 
 286:	74 d8                	je     260 <ls+0x170>
      memmove(p, de.name, DIRSIZ);
 288:	8d 85 be fd ff ff    	lea    -0x242(%ebp),%eax
 28e:	83 ec 04             	sub    $0x4,%esp
 291:	6a 0e                	push   $0xe
 293:	50                   	push   %eax
 294:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 29a:	e8 91 03 00 00       	call   630 <memmove>
      p[DIRSIZ] = 0;
 29f:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 2a5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2a9:	58                   	pop    %eax
 2aa:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 2b0:	5a                   	pop    %edx
 2b1:	56                   	push   %esi
 2b2:	50                   	push   %eax
 2b3:	e8 e8 02 00 00       	call   5a0 <stat>
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	0f 88 25 01 00 00    	js     3e8 <ls+0x2f8>
      if (getcid()>0){
 2c3:	e8 92 04 00 00       	call   75a <getcid>
 2c8:	85 c0                	test   %eax,%eax
 2ca:	0f 8e 98 00 00 00    	jle    368 <ls+0x278>
        if (st.cid ==0){
 2d0:	8b 95 e0 fd ff ff    	mov    -0x220(%ebp),%edx
 2d6:	85 d2                	test   %edx,%edx
 2d8:	0f 84 98 00 00 00    	je     376 <ls+0x286>
 2de:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
          if (st.cid == getcid()){
 2e4:	e8 71 04 00 00       	call   75a <getcid>
 2e9:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 2ef:	39 c2                	cmp    %eax,%edx
 2f1:	0f 85 69 ff ff ff    	jne    260 <ls+0x170>
          printf(1, "%s %d %d %d\n", fmtname(buf,st.path_len+strlen(path)+1), st.type, st.ino, st.size);
 2f7:	8b 8d d4 fd ff ff    	mov    -0x22c(%ebp),%ecx
 2fd:	83 ec 0c             	sub    $0xc,%esp
 300:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 306:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
 30c:	57                   	push   %edi
 30d:	89 8d a0 fd ff ff    	mov    %ecx,-0x260(%ebp)
 313:	0f bf 8d cc fd ff ff 	movswl -0x234(%ebp),%ecx
 31a:	89 95 a4 fd ff ff    	mov    %edx,-0x25c(%ebp)
 320:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 326:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 32c:	e8 5f 01 00 00       	call   490 <strlen>
 331:	5a                   	pop    %edx
 332:	8b 95 a4 fd ff ff    	mov    -0x25c(%ebp),%edx
 338:	59                   	pop    %ecx
 339:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
 33d:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 343:	50                   	push   %eax
 344:	52                   	push   %edx
 345:	e8 16 fd ff ff       	call   60 <fmtname>
 34a:	5a                   	pop    %edx
 34b:	59                   	pop    %ecx
 34c:	8b 8d a0 fd ff ff    	mov    -0x260(%ebp),%ecx
 352:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 358:	51                   	push   %ecx
 359:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 35f:	eb 6e                	jmp    3cf <ls+0x2df>
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (st.cid ==0){
 368:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
 36e:	85 c0                	test   %eax,%eax
 370:	0f 85 ea fe ff ff    	jne    260 <ls+0x170>
          printf(1, "%s %d %d %d\n", fmtname(buf,strlen(buf)), st.type, st.ino, st.size);
 376:	8b 8d dc fd ff ff    	mov    -0x224(%ebp),%ecx
 37c:	0f bf 85 cc fd ff ff 	movswl -0x234(%ebp),%eax
 383:	83 ec 0c             	sub    $0xc,%esp
 386:	8b 95 d4 fd ff ff    	mov    -0x22c(%ebp),%edx
 38c:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 392:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 398:	89 95 a8 fd ff ff    	mov    %edx,-0x258(%ebp)
 39e:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 3a4:	51                   	push   %ecx
 3a5:	e8 e6 00 00 00       	call   490 <strlen>
 3aa:	5a                   	pop    %edx
 3ab:	59                   	pop    %ecx
 3ac:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 3b2:	50                   	push   %eax
 3b3:	51                   	push   %ecx
 3b4:	e8 a7 fc ff ff       	call   60 <fmtname>
 3b9:	5a                   	pop    %edx
 3ba:	8b 95 a8 fd ff ff    	mov    -0x258(%ebp),%edx
 3c0:	59                   	pop    %ecx
 3c1:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 3c7:	51                   	push   %ecx
 3c8:	52                   	push   %edx
 3c9:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
          printf(1, "%s %d %d %d\n", fmtname(buf,st.path_len+strlen(path)+1), st.type, st.ino, st.size);
 3cf:	50                   	push   %eax
 3d0:	68 b0 0b 00 00       	push   $0xbb0
 3d5:	6a 01                	push   $0x1
 3d7:	e8 54 04 00 00       	call   830 <printf>
 3dc:	83 c4 20             	add    $0x20,%esp
 3df:	e9 7c fe ff ff       	jmp    260 <ls+0x170>
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 3e8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 3ee:	83 ec 04             	sub    $0x4,%esp
 3f1:	50                   	push   %eax
 3f2:	68 9c 0b 00 00       	push   $0xb9c
 3f7:	6a 01                	push   $0x1
 3f9:	e8 32 04 00 00       	call   830 <printf>
        continue;
 3fe:	83 c4 10             	add    $0x10,%esp
 401:	e9 5a fe ff ff       	jmp    260 <ls+0x170>
 406:	66 90                	xchg   %ax,%ax
 408:	66 90                	xchg   %ax,%ax
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 41a:	89 c2                	mov    %eax,%edx
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	83 c1 01             	add    $0x1,%ecx
 423:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 427:	83 c2 01             	add    $0x1,%edx
 42a:	84 db                	test   %bl,%bl
 42c:	88 5a ff             	mov    %bl,-0x1(%edx)
 42f:	75 ef                	jne    420 <strcpy+0x10>
    ;
  return os;
}
 431:	5b                   	pop    %ebx
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 43a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000440 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	8b 55 08             	mov    0x8(%ebp),%edx
 447:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 44a:	0f b6 02             	movzbl (%edx),%eax
 44d:	0f b6 19             	movzbl (%ecx),%ebx
 450:	84 c0                	test   %al,%al
 452:	75 1c                	jne    470 <strcmp+0x30>
 454:	eb 2a                	jmp    480 <strcmp+0x40>
 456:	8d 76 00             	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 460:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 463:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 466:	83 c1 01             	add    $0x1,%ecx
 469:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 46c:	84 c0                	test   %al,%al
 46e:	74 10                	je     480 <strcmp+0x40>
 470:	38 d8                	cmp    %bl,%al
 472:	74 ec                	je     460 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 474:	29 d8                	sub    %ebx,%eax
}
 476:	5b                   	pop    %ebx
 477:	5d                   	pop    %ebp
 478:	c3                   	ret    
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 480:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 482:	29 d8                	sub    %ebx,%eax
}
 484:	5b                   	pop    %ebx
 485:	5d                   	pop    %ebp
 486:	c3                   	ret    
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <strlen>:

uint
strlen(const char *s)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 496:	80 39 00             	cmpb   $0x0,(%ecx)
 499:	74 15                	je     4b0 <strlen+0x20>
 49b:	31 d2                	xor    %edx,%edx
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	83 c2 01             	add    $0x1,%edx
 4a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4a7:	89 d0                	mov    %edx,%eax
 4a9:	75 f5                	jne    4a0 <strlen+0x10>
    ;
  return n;
}
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 4b0:	31 c0                	xor    %eax,%eax
}
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    
 4b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	89 d7                	mov    %edx,%edi
 4cf:	fc                   	cld    
 4d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	5f                   	pop    %edi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <strchr>:

char*
strchr(const char *s, char c)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 4ea:	0f b6 10             	movzbl (%eax),%edx
 4ed:	84 d2                	test   %dl,%dl
 4ef:	74 1d                	je     50e <strchr+0x2e>
    if(*s == c)
 4f1:	38 d3                	cmp    %dl,%bl
 4f3:	89 d9                	mov    %ebx,%ecx
 4f5:	75 0d                	jne    504 <strchr+0x24>
 4f7:	eb 17                	jmp    510 <strchr+0x30>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 500:	38 ca                	cmp    %cl,%dl
 502:	74 0c                	je     510 <strchr+0x30>
  for(; *s; s++)
 504:	83 c0 01             	add    $0x1,%eax
 507:	0f b6 10             	movzbl (%eax),%edx
 50a:	84 d2                	test   %dl,%dl
 50c:	75 f2                	jne    500 <strchr+0x20>
      return (char*)s;
  return 0;
 50e:	31 c0                	xor    %eax,%eax
}
 510:	5b                   	pop    %ebx
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    
 513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <gets>:

char*
gets(char *buf, int max)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 526:	31 f6                	xor    %esi,%esi
 528:	89 f3                	mov    %esi,%ebx
{
 52a:	83 ec 1c             	sub    $0x1c,%esp
 52d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 530:	eb 2f                	jmp    561 <gets+0x41>
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 538:	8d 45 e7             	lea    -0x19(%ebp),%eax
 53b:	83 ec 04             	sub    $0x4,%esp
 53e:	6a 01                	push   $0x1
 540:	50                   	push   %eax
 541:	6a 00                	push   $0x0
 543:	e8 32 01 00 00       	call   67a <read>
    if(cc < 1)
 548:	83 c4 10             	add    $0x10,%esp
 54b:	85 c0                	test   %eax,%eax
 54d:	7e 1c                	jle    56b <gets+0x4b>
      break;
    buf[i++] = c;
 54f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 553:	83 c7 01             	add    $0x1,%edi
 556:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 559:	3c 0a                	cmp    $0xa,%al
 55b:	74 23                	je     580 <gets+0x60>
 55d:	3c 0d                	cmp    $0xd,%al
 55f:	74 1f                	je     580 <gets+0x60>
  for(i=0; i+1 < max; ){
 561:	83 c3 01             	add    $0x1,%ebx
 564:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 567:	89 fe                	mov    %edi,%esi
 569:	7c cd                	jl     538 <gets+0x18>
 56b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 570:	c6 03 00             	movb   $0x0,(%ebx)
}
 573:	8d 65 f4             	lea    -0xc(%ebp),%esp
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 580:	8b 75 08             	mov    0x8(%ebp),%esi
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	01 de                	add    %ebx,%esi
 588:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 58a:	c6 03 00             	movb   $0x0,(%ebx)
}
 58d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 590:	5b                   	pop    %ebx
 591:	5e                   	pop    %esi
 592:	5f                   	pop    %edi
 593:	5d                   	pop    %ebp
 594:	c3                   	ret    
 595:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	56                   	push   %esi
 5a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5a5:	83 ec 08             	sub    $0x8,%esp
 5a8:	6a 00                	push   $0x0
 5aa:	ff 75 08             	pushl  0x8(%ebp)
 5ad:	e8 f0 00 00 00       	call   6a2 <open>
  if(fd < 0)
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	85 c0                	test   %eax,%eax
 5b7:	78 27                	js     5e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5b9:	83 ec 08             	sub    $0x8,%esp
 5bc:	ff 75 0c             	pushl  0xc(%ebp)
 5bf:	89 c3                	mov    %eax,%ebx
 5c1:	50                   	push   %eax
 5c2:	e8 f3 00 00 00       	call   6ba <fstat>
  /// ADDED

    // st->cid = fd->cid;

  ///
  close(fd);
 5c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5ca:	89 c6                	mov    %eax,%esi
  close(fd);
 5cc:	e8 b9 00 00 00       	call   68a <close>
  return r;
 5d1:	83 c4 10             	add    $0x10,%esp
}
 5d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5d7:	89 f0                	mov    %esi,%eax
 5d9:	5b                   	pop    %ebx
 5da:	5e                   	pop    %esi
 5db:	5d                   	pop    %ebp
 5dc:	c3                   	ret    
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 5e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5e5:	eb ed                	jmp    5d4 <stat+0x34>
 5e7:	89 f6                	mov    %esi,%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <atoi>:

int
atoi(const char *s)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	53                   	push   %ebx
 5f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5f7:	0f be 11             	movsbl (%ecx),%edx
 5fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 5fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 5ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 604:	77 1f                	ja     625 <atoi+0x35>
 606:	8d 76 00             	lea    0x0(%esi),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 610:	8d 04 80             	lea    (%eax,%eax,4),%eax
 613:	83 c1 01             	add    $0x1,%ecx
 616:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 61a:	0f be 11             	movsbl (%ecx),%edx
 61d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 620:	80 fb 09             	cmp    $0x9,%bl
 623:	76 eb                	jbe    610 <atoi+0x20>
  return n;
}
 625:	5b                   	pop    %ebx
 626:	5d                   	pop    %ebp
 627:	c3                   	ret    
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000630 <memmove>:


void*
memmove(void *vdst, const void *vsrc, int n)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
 635:	8b 5d 10             	mov    0x10(%ebp),%ebx
 638:	8b 45 08             	mov    0x8(%ebp),%eax
 63b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 63e:	85 db                	test   %ebx,%ebx
 640:	7e 14                	jle    656 <memmove+0x26>
 642:	31 d2                	xor    %edx,%edx
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 648:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 64c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 64f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 652:	39 d3                	cmp    %edx,%ebx
 654:	75 f2                	jne    648 <memmove+0x18>
  return vdst;
}
 656:	5b                   	pop    %ebx
 657:	5e                   	pop    %esi
 658:	5d                   	pop    %ebp
 659:	c3                   	ret    

0000065a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 65a:	b8 01 00 00 00       	mov    $0x1,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <exit>:
SYSCALL(exit)
 662:	b8 02 00 00 00       	mov    $0x2,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <wait>:
SYSCALL(wait)
 66a:	b8 03 00 00 00       	mov    $0x3,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <pipe>:
SYSCALL(pipe)
 672:	b8 04 00 00 00       	mov    $0x4,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <read>:
SYSCALL(read)
 67a:	b8 05 00 00 00       	mov    $0x5,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <write>:
SYSCALL(write)
 682:	b8 10 00 00 00       	mov    $0x10,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <close>:
SYSCALL(close)
 68a:	b8 15 00 00 00       	mov    $0x15,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <kill>:
SYSCALL(kill)
 692:	b8 06 00 00 00       	mov    $0x6,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <exec>:
SYSCALL(exec)
 69a:	b8 07 00 00 00       	mov    $0x7,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <open>:
SYSCALL(open)
 6a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <mknod>:
SYSCALL(mknod)
 6aa:	b8 11 00 00 00       	mov    $0x11,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <unlink>:
SYSCALL(unlink)
 6b2:	b8 12 00 00 00       	mov    $0x12,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <fstat>:
SYSCALL(fstat)
 6ba:	b8 08 00 00 00       	mov    $0x8,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <link>:
SYSCALL(link)
 6c2:	b8 13 00 00 00       	mov    $0x13,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <mkdir>:
SYSCALL(mkdir)
 6ca:	b8 14 00 00 00       	mov    $0x14,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <chdir>:
SYSCALL(chdir)
 6d2:	b8 09 00 00 00       	mov    $0x9,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <dup>:
SYSCALL(dup)
 6da:	b8 0a 00 00 00       	mov    $0xa,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <getpid>:
SYSCALL(getpid)
 6e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <sbrk>:
SYSCALL(sbrk)
 6ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <sleep>:
SYSCALL(sleep)
 6f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <uptime>:
SYSCALL(uptime)
 6fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <toggle>:
SYSCALL(toggle)
 702:	b8 16 00 00 00       	mov    $0x16,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <add>:
SYSCALL(add)
 70a:	b8 17 00 00 00       	mov    $0x17,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <ps>:
SYSCALL(ps)
 712:	b8 18 00 00 00       	mov    $0x18,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <send>:
SYSCALL(send)
 71a:	b8 19 00 00 00       	mov    $0x19,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <recv>:
SYSCALL(recv)
 722:	b8 1a 00 00 00       	mov    $0x1a,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <send_multi>:
SYSCALL(send_multi)
 72a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <print_count>:
SYSCALL(print_count)
 732:	b8 1c 00 00 00       	mov    $0x1c,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <create_container>:
SYSCALL(create_container)
 73a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <destroy_container>:
SYSCALL(destroy_container)
 742:	b8 1e 00 00 00       	mov    $0x1e,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <join_container>:
SYSCALL(join_container)
 74a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <leave_container>:
SYSCALL(leave_container)
 752:	b8 20 00 00 00       	mov    $0x20,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <getcid>:
SYSCALL(getcid)
 75a:	b8 21 00 00 00       	mov    $0x21,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <p_ctable>:
SYSCALL(p_ctable)
 762:	b8 22 00 00 00       	mov    $0x22,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <sz_ctable>:
SYSCALL(sz_ctable)
 76a:	b8 23 00 00 00       	mov    $0x23,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <scheduler_log_off>:
SYSCALL(scheduler_log_off)
 772:	b8 25 00 00 00       	mov    $0x25,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <scheduler_log_on>:
SYSCALL(scheduler_log_on)
 77a:	b8 24 00 00 00       	mov    $0x24,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    
 782:	66 90                	xchg   %ax,%ax
 784:	66 90                	xchg   %ax,%ax
 786:	66 90                	xchg   %ax,%ax
 788:	66 90                	xchg   %ax,%ax
 78a:	66 90                	xchg   %ax,%ax
 78c:	66 90                	xchg   %ax,%ax
 78e:	66 90                	xchg   %ax,%ax

00000790 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 799:	85 d2                	test   %edx,%edx
{
 79b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 79e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 7a0:	79 76                	jns    818 <printint+0x88>
 7a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7a6:	74 70                	je     818 <printint+0x88>
    x = -xx;
 7a8:	f7 d8                	neg    %eax
    neg = 1;
 7aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 7b1:	31 f6                	xor    %esi,%esi
 7b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 7b6:	eb 0a                	jmp    7c2 <printint+0x32>
 7b8:	90                   	nop
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 7c0:	89 fe                	mov    %edi,%esi
 7c2:	31 d2                	xor    %edx,%edx
 7c4:	8d 7e 01             	lea    0x1(%esi),%edi
 7c7:	f7 f1                	div    %ecx
 7c9:	0f b6 92 dc 0b 00 00 	movzbl 0xbdc(%edx),%edx
  }while((x /= base) != 0);
 7d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7d5:	75 e9                	jne    7c0 <printint+0x30>
  if(neg)
 7d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7da:	85 c0                	test   %eax,%eax
 7dc:	74 08                	je     7e6 <printint+0x56>
    buf[i++] = '-';
 7de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7e3:	8d 7e 02             	lea    0x2(%esi),%edi
 7e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
 7f0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
 7f6:	83 ee 01             	sub    $0x1,%esi
 7f9:	6a 01                	push   $0x1
 7fb:	53                   	push   %ebx
 7fc:	57                   	push   %edi
 7fd:	88 45 d7             	mov    %al,-0x29(%ebp)
 800:	e8 7d fe ff ff       	call   682 <write>

  while(--i >= 0)
 805:	83 c4 10             	add    $0x10,%esp
 808:	39 de                	cmp    %ebx,%esi
 80a:	75 e4                	jne    7f0 <printint+0x60>
    putc(fd, buf[i]);
}
 80c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80f:	5b                   	pop    %ebx
 810:	5e                   	pop    %esi
 811:	5f                   	pop    %edi
 812:	5d                   	pop    %ebp
 813:	c3                   	ret    
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 818:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 81f:	eb 90                	jmp    7b1 <printint+0x21>
 821:	eb 0d                	jmp    830 <printf>
 823:	90                   	nop
 824:	90                   	nop
 825:	90                   	nop
 826:	90                   	nop
 827:	90                   	nop
 828:	90                   	nop
 829:	90                   	nop
 82a:	90                   	nop
 82b:	90                   	nop
 82c:	90                   	nop
 82d:	90                   	nop
 82e:	90                   	nop
 82f:	90                   	nop

00000830 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 839:	8b 75 0c             	mov    0xc(%ebp),%esi
 83c:	0f b6 1e             	movzbl (%esi),%ebx
 83f:	84 db                	test   %bl,%bl
 841:	0f 84 b3 00 00 00    	je     8fa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 847:	8d 45 10             	lea    0x10(%ebp),%eax
 84a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 84d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 84f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 852:	eb 2f                	jmp    883 <printf+0x53>
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 858:	83 f8 25             	cmp    $0x25,%eax
 85b:	0f 84 a7 00 00 00    	je     908 <printf+0xd8>
  write(fd, &c, 1);
 861:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 864:	83 ec 04             	sub    $0x4,%esp
 867:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 86a:	6a 01                	push   $0x1
 86c:	50                   	push   %eax
 86d:	ff 75 08             	pushl  0x8(%ebp)
 870:	e8 0d fe ff ff       	call   682 <write>
 875:	83 c4 10             	add    $0x10,%esp
 878:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 87b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 87f:	84 db                	test   %bl,%bl
 881:	74 77                	je     8fa <printf+0xca>
    if(state == 0){
 883:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 885:	0f be cb             	movsbl %bl,%ecx
 888:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 88b:	74 cb                	je     858 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 88d:	83 ff 25             	cmp    $0x25,%edi
 890:	75 e6                	jne    878 <printf+0x48>
      if(c == 'd'){
 892:	83 f8 64             	cmp    $0x64,%eax
 895:	0f 84 05 01 00 00    	je     9a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 89b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 8a1:	83 f9 70             	cmp    $0x70,%ecx
 8a4:	74 72                	je     918 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 8a6:	83 f8 73             	cmp    $0x73,%eax
 8a9:	0f 84 99 00 00 00    	je     948 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8af:	83 f8 63             	cmp    $0x63,%eax
 8b2:	0f 84 08 01 00 00    	je     9c0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 8b8:	83 f8 25             	cmp    $0x25,%eax
 8bb:	0f 84 ef 00 00 00    	je     9b0 <printf+0x180>
  write(fd, &c, 1);
 8c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8c4:	83 ec 04             	sub    $0x4,%esp
 8c7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8cb:	6a 01                	push   $0x1
 8cd:	50                   	push   %eax
 8ce:	ff 75 08             	pushl  0x8(%ebp)
 8d1:	e8 ac fd ff ff       	call   682 <write>
 8d6:	83 c4 0c             	add    $0xc,%esp
 8d9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8dc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8df:	6a 01                	push   $0x1
 8e1:	50                   	push   %eax
 8e2:	ff 75 08             	pushl  0x8(%ebp)
 8e5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8e8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8ea:	e8 93 fd ff ff       	call   682 <write>
  for(i = 0; fmt[i]; i++){
 8ef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8f6:	84 db                	test   %bl,%bl
 8f8:	75 89                	jne    883 <printf+0x53>
    }
  }
}
 8fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8fd:	5b                   	pop    %ebx
 8fe:	5e                   	pop    %esi
 8ff:	5f                   	pop    %edi
 900:	5d                   	pop    %ebp
 901:	c3                   	ret    
 902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 908:	bf 25 00 00 00       	mov    $0x25,%edi
 90d:	e9 66 ff ff ff       	jmp    878 <printf+0x48>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 918:	83 ec 0c             	sub    $0xc,%esp
 91b:	b9 10 00 00 00       	mov    $0x10,%ecx
 920:	6a 00                	push   $0x0
 922:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 925:	8b 45 08             	mov    0x8(%ebp),%eax
 928:	8b 17                	mov    (%edi),%edx
 92a:	e8 61 fe ff ff       	call   790 <printint>
        ap++;
 92f:	89 f8                	mov    %edi,%eax
 931:	83 c4 10             	add    $0x10,%esp
      state = 0;
 934:	31 ff                	xor    %edi,%edi
        ap++;
 936:	83 c0 04             	add    $0x4,%eax
 939:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 93c:	e9 37 ff ff ff       	jmp    878 <printf+0x48>
 941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 948:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 94b:	8b 08                	mov    (%eax),%ecx
        ap++;
 94d:	83 c0 04             	add    $0x4,%eax
 950:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 953:	85 c9                	test   %ecx,%ecx
 955:	0f 84 8e 00 00 00    	je     9e9 <printf+0x1b9>
        while(*s != 0){
 95b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 95e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 960:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 962:	84 c0                	test   %al,%al
 964:	0f 84 0e ff ff ff    	je     878 <printf+0x48>
 96a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 96d:	89 de                	mov    %ebx,%esi
 96f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 972:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 975:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 978:	83 ec 04             	sub    $0x4,%esp
          s++;
 97b:	83 c6 01             	add    $0x1,%esi
 97e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 981:	6a 01                	push   $0x1
 983:	57                   	push   %edi
 984:	53                   	push   %ebx
 985:	e8 f8 fc ff ff       	call   682 <write>
        while(*s != 0){
 98a:	0f b6 06             	movzbl (%esi),%eax
 98d:	83 c4 10             	add    $0x10,%esp
 990:	84 c0                	test   %al,%al
 992:	75 e4                	jne    978 <printf+0x148>
 994:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 997:	31 ff                	xor    %edi,%edi
 999:	e9 da fe ff ff       	jmp    878 <printf+0x48>
 99e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9a8:	6a 01                	push   $0x1
 9aa:	e9 73 ff ff ff       	jmp    922 <printf+0xf2>
 9af:	90                   	nop
  write(fd, &c, 1);
 9b0:	83 ec 04             	sub    $0x4,%esp
 9b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 9b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 9b9:	6a 01                	push   $0x1
 9bb:	e9 21 ff ff ff       	jmp    8e1 <printf+0xb1>
        putc(fd, *ap);
 9c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 9c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9c6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 9c8:	6a 01                	push   $0x1
        ap++;
 9ca:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 9cd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9d3:	50                   	push   %eax
 9d4:	ff 75 08             	pushl  0x8(%ebp)
 9d7:	e8 a6 fc ff ff       	call   682 <write>
        ap++;
 9dc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9e2:	31 ff                	xor    %edi,%edi
 9e4:	e9 8f fe ff ff       	jmp    878 <printf+0x48>
          s = "(null)";
 9e9:	bb d2 0b 00 00       	mov    $0xbd2,%ebx
        while(*s != 0){
 9ee:	b8 28 00 00 00       	mov    $0x28,%eax
 9f3:	e9 72 ff ff ff       	jmp    96a <printf+0x13a>
 9f8:	66 90                	xchg   %ax,%ax
 9fa:	66 90                	xchg   %ax,%ax
 9fc:	66 90                	xchg   %ax,%ax
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a01:	a1 10 0f 00 00       	mov    0xf10,%eax
{
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a18:	39 c8                	cmp    %ecx,%eax
 a1a:	8b 10                	mov    (%eax),%edx
 a1c:	73 32                	jae    a50 <free+0x50>
 a1e:	39 d1                	cmp    %edx,%ecx
 a20:	72 04                	jb     a26 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	39 d0                	cmp    %edx,%eax
 a24:	72 32                	jb     a58 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a26:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a29:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a2c:	39 fa                	cmp    %edi,%edx
 a2e:	74 30                	je     a60 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a30:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a33:	8b 50 04             	mov    0x4(%eax),%edx
 a36:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a39:	39 f1                	cmp    %esi,%ecx
 a3b:	74 3a                	je     a77 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a3d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a3f:	a3 10 0f 00 00       	mov    %eax,0xf10
}
 a44:	5b                   	pop    %ebx
 a45:	5e                   	pop    %esi
 a46:	5f                   	pop    %edi
 a47:	5d                   	pop    %ebp
 a48:	c3                   	ret    
 a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a50:	39 d0                	cmp    %edx,%eax
 a52:	72 04                	jb     a58 <free+0x58>
 a54:	39 d1                	cmp    %edx,%ecx
 a56:	72 ce                	jb     a26 <free+0x26>
{
 a58:	89 d0                	mov    %edx,%eax
 a5a:	eb bc                	jmp    a18 <free+0x18>
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a60:	03 72 04             	add    0x4(%edx),%esi
 a63:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a66:	8b 10                	mov    (%eax),%edx
 a68:	8b 12                	mov    (%edx),%edx
 a6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a6d:	8b 50 04             	mov    0x4(%eax),%edx
 a70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a73:	39 f1                	cmp    %esi,%ecx
 a75:	75 c6                	jne    a3d <free+0x3d>
    p->s.size += bp->s.size;
 a77:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a7a:	a3 10 0f 00 00       	mov    %eax,0xf10
    p->s.size += bp->s.size;
 a7f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a82:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a85:	89 10                	mov    %edx,(%eax)
}
 a87:	5b                   	pop    %ebx
 a88:	5e                   	pop    %esi
 a89:	5f                   	pop    %edi
 a8a:	5d                   	pop    %ebp
 a8b:	c3                   	ret    
 a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a9c:	8b 15 10 0f 00 00    	mov    0xf10,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa2:	8d 78 07             	lea    0x7(%eax),%edi
 aa5:	c1 ef 03             	shr    $0x3,%edi
 aa8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 aab:	85 d2                	test   %edx,%edx
 aad:	0f 84 9d 00 00 00    	je     b50 <malloc+0xc0>
 ab3:	8b 02                	mov    (%edx),%eax
 ab5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ab8:	39 cf                	cmp    %ecx,%edi
 aba:	76 6c                	jbe    b28 <malloc+0x98>
 abc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ac2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 aca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ad1:	eb 0e                	jmp    ae1 <malloc+0x51>
 ad3:	90                   	nop
 ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f9                	cmp    %edi,%ecx
 adf:	73 47                	jae    b28 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae1:	39 05 10 0f 00 00    	cmp    %eax,0xf10
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	75 ed                	jne    ad8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 aeb:	83 ec 0c             	sub    $0xc,%esp
 aee:	56                   	push   %esi
 aef:	e8 f6 fb ff ff       	call   6ea <sbrk>
  if(p == (char*)-1)
 af4:	83 c4 10             	add    $0x10,%esp
 af7:	83 f8 ff             	cmp    $0xffffffff,%eax
 afa:	74 1c                	je     b18 <malloc+0x88>
  hp->s.size = nu;
 afc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aff:	83 ec 0c             	sub    $0xc,%esp
 b02:	83 c0 08             	add    $0x8,%eax
 b05:	50                   	push   %eax
 b06:	e8 f5 fe ff ff       	call   a00 <free>
  return freep;
 b0b:	8b 15 10 0f 00 00    	mov    0xf10,%edx
      if((p = morecore(nunits)) == 0)
 b11:	83 c4 10             	add    $0x10,%esp
 b14:	85 d2                	test   %edx,%edx
 b16:	75 c0                	jne    ad8 <malloc+0x48>
        return 0;
  }
}
 b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b1b:	31 c0                	xor    %eax,%eax
}
 b1d:	5b                   	pop    %ebx
 b1e:	5e                   	pop    %esi
 b1f:	5f                   	pop    %edi
 b20:	5d                   	pop    %ebp
 b21:	c3                   	ret    
 b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b28:	39 cf                	cmp    %ecx,%edi
 b2a:	74 54                	je     b80 <malloc+0xf0>
        p->s.size -= nunits;
 b2c:	29 f9                	sub    %edi,%ecx
 b2e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b31:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b34:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b37:	89 15 10 0f 00 00    	mov    %edx,0xf10
}
 b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b40:	83 c0 08             	add    $0x8,%eax
}
 b43:	5b                   	pop    %ebx
 b44:	5e                   	pop    %esi
 b45:	5f                   	pop    %edi
 b46:	5d                   	pop    %ebp
 b47:	c3                   	ret    
 b48:	90                   	nop
 b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b50:	c7 05 10 0f 00 00 14 	movl   $0xf14,0xf10
 b57:	0f 00 00 
 b5a:	c7 05 14 0f 00 00 14 	movl   $0xf14,0xf14
 b61:	0f 00 00 
    base.s.size = 0;
 b64:	b8 14 0f 00 00       	mov    $0xf14,%eax
 b69:	c7 05 18 0f 00 00 00 	movl   $0x0,0xf18
 b70:	00 00 00 
 b73:	e9 44 ff ff ff       	jmp    abc <malloc+0x2c>
 b78:	90                   	nop
 b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b1                	jmp    b37 <malloc+0xa7>
