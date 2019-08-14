
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 80 d6 10 80       	mov    $0x8010d680,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 2e 10 80       	mov    $0x80102e10,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb b4 d6 10 80       	mov    $0x8010d6b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 87 10 80       	push   $0x80108740
80100051:	68 80 d6 10 80       	push   $0x8010d680
80100056:	e8 f5 4a 00 00       	call   80104b50 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 cc 1d 11 80 7c 	movl   $0x80111d7c,0x80111dcc
80100062:	1d 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 d0 1d 11 80 7c 	movl   $0x80111d7c,0x80111dd0
8010006c:	1d 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 7c 1d 11 80       	mov    $0x80111d7c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 1d 11 80 	movl   $0x80111d7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 87 10 80       	push   $0x80108747
80100097:	50                   	push   %eax
80100098:	e8 83 49 00 00       	call   80104a20 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 1d 11 80       	mov    0x80111dd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d d0 1d 11 80    	mov    %ebx,0x80111dd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 7c 1d 11 80       	cmp    $0x80111d7c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 80 d6 10 80       	push   $0x8010d680
801000e4:	e8 a7 4b 00 00       	call   80104c90 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 1d 11 80    	mov    0x80111dd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 1d 11 80    	cmp    $0x80111d7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 1d 11 80    	cmp    $0x80111d7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 1d 11 80    	mov    0x80111dcc,%ebx
80100126:	81 fb 7c 1d 11 80    	cmp    $0x80111d7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 1d 11 80    	cmp    $0x80111d7c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 d6 10 80       	push   $0x8010d680
80100162:	e8 e9 4b 00 00       	call   80104d50 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 48 00 00       	call   80104a60 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 1f 00 00       	call   80102090 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 4e 87 10 80       	push   $0x8010874e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 4d 49 00 00       	call   80104b00 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 c7 1e 00 00       	jmp    80102090 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 87 10 80       	push   $0x8010875f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 0c 49 00 00       	call   80104b00 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 48 00 00       	call   80104ac0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 80 d6 10 80 	movl   $0x8010d680,(%esp)
8010020b:	e8 80 4a 00 00       	call   80104c90 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 d0 1d 11 80       	mov    0x80111dd0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 7c 1d 11 80 	movl   $0x80111d7c,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 d0 1d 11 80       	mov    0x80111dd0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d d0 1d 11 80    	mov    %ebx,0x80111dd0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 80 d6 10 80 	movl   $0x8010d680,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ef 4a 00 00       	jmp    80104d50 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 87 10 80       	push   $0x80108766
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 2b 14 00 00       	call   801016b0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 ff 49 00 00       	call   80104c90 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 60 20 11 80    	mov    0x80112060,%edx
801002a7:	39 15 64 20 11 80    	cmp    %edx,0x80112064
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 c5 10 80       	push   $0x8010c520
801002c0:	68 60 20 11 80       	push   $0x80112060
801002c5:	e8 36 3b 00 00       	call   80103e00 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 60 20 11 80    	mov    0x80112060,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 64 20 11 80    	cmp    0x80112064,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 e0 34 00 00       	call   801037c0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 5c 4a 00 00       	call   80104d50 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 d4 12 00 00       	call   801015d0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 60 20 11 80       	mov    %eax,0x80112060
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 e0 1f 11 80 	movsbl -0x7feee020(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 c5 10 80       	push   $0x8010c520
8010034d:	e8 fe 49 00 00       	call   80104d50 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 76 12 00 00       	call   801015d0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 60 20 11 80    	mov    %edx,0x80112060
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 c5 10 80 00 	movl   $0x0,0x8010c554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 f2 22 00 00       	call   801026a0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 87 10 80       	push   $0x8010876d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 87 8d 10 80 	movl   $0x80108d87,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 93 47 00 00       	call   80104b70 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 87 10 80       	push   $0x80108781
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 c5 10 80 01 	movl   $0x1,0x8010c558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 01 6f 00 00       	call   80107340 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 4f 6e 00 00       	call   80107340 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 43 6e 00 00       	call   80107340 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 37 6e 00 00       	call   80107340 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 27 49 00 00       	call   80104e50 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 5a 48 00 00       	call   80104da0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 87 10 80       	push   $0x80108785
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 b0 87 10 80 	movzbl -0x7fef7850(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 9c 10 00 00       	call   801016b0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 70 46 00 00       	call   80104c90 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 c5 10 80       	push   $0x8010c520
80100647:	e8 04 47 00 00       	call   80104d50 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 7b 0f 00 00       	call   801015d0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 c5 10 80       	push   $0x8010c520
8010071f:	e8 2c 46 00 00       	call   80104d50 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 98 87 10 80       	mov    $0x80108798,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 9b 44 00 00       	call   80104c90 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 87 10 80       	push   $0x8010879f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 c5 10 80       	push   $0x8010c520
80100823:	e8 68 44 00 00       	call   80104c90 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 68 20 11 80       	mov    0x80112068,%eax
80100856:	3b 05 64 20 11 80    	cmp    0x80112064,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 68 20 11 80       	mov    %eax,0x80112068
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 c5 10 80       	push   $0x8010c520
80100888:	e8 c3 44 00 00       	call   80104d50 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 68 20 11 80       	mov    0x80112068,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 60 20 11 80    	sub    0x80112060,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 68 20 11 80    	mov    %edx,0x80112068
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 e0 1f 11 80    	mov    %cl,-0x7feee020(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 60 20 11 80       	mov    0x80112060,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 68 20 11 80    	cmp    %eax,0x80112068
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 64 20 11 80       	mov    %eax,0x80112064
          wakeup(&input.r);
80100911:	68 60 20 11 80       	push   $0x80112060
80100916:	e8 a5 36 00 00       	call   80103fc0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 68 20 11 80       	mov    0x80112068,%eax
8010093d:	39 05 64 20 11 80    	cmp    %eax,0x80112064
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 68 20 11 80       	mov    %eax,0x80112068
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 68 20 11 80       	mov    0x80112068,%eax
80100964:	3b 05 64 20 11 80    	cmp    0x80112064,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba e0 1f 11 80 0a 	cmpb   $0xa,-0x7feee020(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 04 37 00 00       	jmp    801040a0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 e0 1f 11 80 0a 	movb   $0xa,-0x7feee020(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 68 20 11 80       	mov    0x80112068,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 a8 87 10 80       	push   $0x801087a8
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 7b 41 00 00       	call   80104b50 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 2c 2a 11 80 00 	movl   $0x80100600,0x80112a2c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 28 2a 11 80 70 	movl   $0x80100270,0x80112a28
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 c5 10 80 01 	movl   $0x1,0x8010c554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 42 18 00 00       	call   80102240 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 9f 2d 00 00       	call   801037c0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 e4 20 00 00       	call   80102b10 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 19 14 00 00       	call   80101e50 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 83 0b 00 00       	call   801015d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 62 0e 00 00       	call   801018c0 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 f1 0d 00 00       	call   80101860 <iunlockput>
    end_op();
80100a6f:	e8 0c 21 00 00       	call   80102b80 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 f7 79 00 00       	call   80108490 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8e 02 00 00    	je     80100d4d <exec+0x33d>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 b5 77 00 00       	call   801082b0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 c3 76 00 00       	call   801081f0 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 63 0d 00 00       	call   801018c0 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 99 78 00 00       	call   80108410 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 c6 0c 00 00       	call   80101860 <iunlockput>
  end_op();
80100b9a:	e8 e1 1f 00 00       	call   80102b80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 01 77 00 00       	call   801082b0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 4a 78 00 00       	call   80108410 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 a8 1f 00 00       	call   80102b80 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 c1 87 10 80       	push   $0x801087c1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 25 79 00 00       	call   80108530 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 82 43 00 00       	call   80104fc0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 6f 43 00 00       	call   80104fc0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 2e 7a 00 00       	call   80108690 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 c4 79 00 00       	call   80108690 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	05 2c 10 00 00       	add    $0x102c,%eax
80100d0b:	50                   	push   %eax
80100d0c:	e8 6f 42 00 00       	call   80104f80 <safestrcpy>
  curproc->pgdir = pgdir;
80100d11:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d17:	89 f9                	mov    %edi,%ecx
80100d19:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1c:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1f:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d21:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d24:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d2a:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2d:	8b 41 18             	mov    0x18(%ecx),%eax
80100d30:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d33:	89 0c 24             	mov    %ecx,(%esp)
80100d36:	e8 25 73 00 00       	call   80108060 <switchuvm>
  freevm(oldpgdir);
80100d3b:	89 3c 24             	mov    %edi,(%esp)
80100d3e:	e8 cd 76 00 00       	call   80108410 <freevm>
  return 0;
80100d43:	83 c4 10             	add    $0x10,%esp
80100d46:	31 c0                	xor    %eax,%eax
80100d48:	e9 2f fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4d:	be 00 20 00 00       	mov    $0x2000,%esi
80100d52:	e9 3a fe ff ff       	jmp    80100b91 <exec+0x181>
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 cd 87 10 80       	push   $0x801087cd
80100d6b:	68 80 20 11 80       	push   $0x80112080
80100d70:	e8 db 3d 00 00       	call   80104b50 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb b4 20 11 80       	mov    $0x801120b4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 80 20 11 80       	push   $0x80112080
80100d91:	e8 fa 3e 00 00       	call   80104c90 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 14 2a 11 80    	cmp    $0x80112a14,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 80 20 11 80       	push   $0x80112080
80100dc1:	e8 8a 3f 00 00       	call   80104d50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 80 20 11 80       	push   $0x80112080
80100dda:	e8 71 3f 00 00       	call   80104d50 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 80 20 11 80       	push   $0x80112080
80100dff:	e8 8c 3e 00 00       	call   80104c90 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 80 20 11 80       	push   $0x80112080
80100e1c:	e8 2f 3f 00 00       	call   80104d50 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 d4 87 10 80       	push   $0x801087d4
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
    begin_op();
    cprintf("In file_close %d",ff.ip->cid);
    iput(ff.ip);
    end_op();
  }
}
80100e43:	5d                   	pop    %ebp
80100e44:	c3                   	ret    
80100e45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e50 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	53                   	push   %ebx
80100e54:	83 ec 04             	sub    $0x4,%esp
80100e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100e5a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100e5d:	75 31                	jne    80100e90 <filestat+0x40>
    ilock(f->ip);
80100e5f:	83 ec 0c             	sub    $0xc,%esp
80100e62:	ff 73 10             	pushl  0x10(%ebx)
80100e65:	e8 66 07 00 00       	call   801015d0 <ilock>
    stati(f->ip, st);
80100e6a:	58                   	pop    %eax
80100e6b:	5a                   	pop    %edx
80100e6c:	ff 75 0c             	pushl  0xc(%ebp)
80100e6f:	ff 73 10             	pushl  0x10(%ebx)
80100e72:	e8 09 0a 00 00       	call   80101880 <stati>
    // ADDED 
    // cprintf("In filestat fcids %d , stcid %d",f->cid,st->cid);
    // st->cid = ip->cid;

    /////////////////////////
    iunlock(f->ip);
80100e77:	59                   	pop    %ecx
80100e78:	ff 73 10             	pushl  0x10(%ebx)
80100e7b:	e8 30 08 00 00       	call   801016b0 <iunlock>


    return 0;
80100e80:	83 c4 10             	add    $0x10,%esp
80100e83:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100e85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e88:	c9                   	leave  
80100e89:	c3                   	ret    
80100e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e95:	eb ee                	jmp    80100e85 <filestat+0x35>
80100e97:	89 f6                	mov    %esi,%esi
80100e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ea0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	57                   	push   %edi
80100ea4:	56                   	push   %esi
80100ea5:	53                   	push   %ebx
80100ea6:	83 ec 0c             	sub    $0xc,%esp
80100ea9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100eac:	8b 75 0c             	mov    0xc(%ebp),%esi
80100eaf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100eb2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100eb6:	74 60                	je     80100f18 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100eb8:	8b 03                	mov    (%ebx),%eax
80100eba:	83 f8 01             	cmp    $0x1,%eax
80100ebd:	74 41                	je     80100f00 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ebf:	83 f8 02             	cmp    $0x2,%eax
80100ec2:	75 5b                	jne    80100f1f <fileread+0x7f>
    ilock(f->ip);
80100ec4:	83 ec 0c             	sub    $0xc,%esp
80100ec7:	ff 73 10             	pushl  0x10(%ebx)
80100eca:	e8 01 07 00 00       	call   801015d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100ecf:	57                   	push   %edi
80100ed0:	ff 73 14             	pushl  0x14(%ebx)
80100ed3:	56                   	push   %esi
80100ed4:	ff 73 10             	pushl  0x10(%ebx)
80100ed7:	e8 e4 09 00 00       	call   801018c0 <readi>
80100edc:	83 c4 20             	add    $0x20,%esp
80100edf:	85 c0                	test   %eax,%eax
80100ee1:	89 c6                	mov    %eax,%esi
80100ee3:	7e 03                	jle    80100ee8 <fileread+0x48>
      f->off += r;
80100ee5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100ee8:	83 ec 0c             	sub    $0xc,%esp
80100eeb:	ff 73 10             	pushl  0x10(%ebx)
80100eee:	e8 bd 07 00 00       	call   801016b0 <iunlock>
    return r;
80100ef3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100ef6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef9:	89 f0                	mov    %esi,%eax
80100efb:	5b                   	pop    %ebx
80100efc:	5e                   	pop    %esi
80100efd:	5f                   	pop    %edi
80100efe:	5d                   	pop    %ebp
80100eff:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100f00:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f03:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100f06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f09:	5b                   	pop    %ebx
80100f0a:	5e                   	pop    %esi
80100f0b:	5f                   	pop    %edi
80100f0c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100f0d:	e9 5e 25 00 00       	jmp    80103470 <piperead>
80100f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100f18:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100f1d:	eb d7                	jmp    80100ef6 <fileread+0x56>
  panic("fileread");
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	68 dc 87 10 80       	push   $0x801087dc
80100f27:	e8 64 f4 ff ff       	call   80100390 <panic>
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f30 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	57                   	push   %edi
80100f34:	56                   	push   %esi
80100f35:	53                   	push   %ebx
80100f36:	83 ec 1c             	sub    $0x1c,%esp
80100f39:	8b 75 08             	mov    0x8(%ebp),%esi
80100f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100f3f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80100f43:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100f46:	8b 45 10             	mov    0x10(%ebp),%eax
80100f49:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80100f4c:	0f 84 aa 00 00 00    	je     80100ffc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100f52:	8b 06                	mov    (%esi),%eax
80100f54:	83 f8 01             	cmp    $0x1,%eax
80100f57:	0f 84 c3 00 00 00    	je     80101020 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5d:	83 f8 02             	cmp    $0x2,%eax
80100f60:	0f 85 d9 00 00 00    	jne    8010103f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80100f69:	31 ff                	xor    %edi,%edi
    while(i < n){
80100f6b:	85 c0                	test   %eax,%eax
80100f6d:	7f 34                	jg     80100fa3 <filewrite+0x73>
80100f6f:	e9 9c 00 00 00       	jmp    80101010 <filewrite+0xe0>
80100f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100f78:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80100f7b:	83 ec 0c             	sub    $0xc,%esp
80100f7e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80100f81:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100f84:	e8 27 07 00 00       	call   801016b0 <iunlock>
      end_op();
80100f89:	e8 f2 1b 00 00       	call   80102b80 <end_op>
80100f8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f91:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80100f94:	39 c3                	cmp    %eax,%ebx
80100f96:	0f 85 96 00 00 00    	jne    80101032 <filewrite+0x102>
        panic("short filewrite");
      i += r;
80100f9c:	01 df                	add    %ebx,%edi
    while(i < n){
80100f9e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80100fa1:	7e 6d                	jle    80101010 <filewrite+0xe0>
      int n1 = n - i;
80100fa3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100fa6:	b8 00 06 00 00       	mov    $0x600,%eax
80100fab:	29 fb                	sub    %edi,%ebx
80100fad:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80100fb3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80100fb6:	e8 55 1b 00 00       	call   80102b10 <begin_op>
      ilock(f->ip);
80100fbb:	83 ec 0c             	sub    $0xc,%esp
80100fbe:	ff 76 10             	pushl  0x10(%esi)
80100fc1:	e8 0a 06 00 00       	call   801015d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100fc6:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100fc9:	53                   	push   %ebx
80100fca:	ff 76 14             	pushl  0x14(%esi)
80100fcd:	01 f8                	add    %edi,%eax
80100fcf:	50                   	push   %eax
80100fd0:	ff 76 10             	pushl  0x10(%esi)
80100fd3:	e8 e8 09 00 00       	call   801019c0 <writei>
80100fd8:	83 c4 20             	add    $0x20,%esp
80100fdb:	85 c0                	test   %eax,%eax
80100fdd:	7f 99                	jg     80100f78 <filewrite+0x48>
      iunlock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 76 10             	pushl  0x10(%esi)
80100fe5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100fe8:	e8 c3 06 00 00       	call   801016b0 <iunlock>
      end_op();
80100fed:	e8 8e 1b 00 00       	call   80102b80 <end_op>
      if(r < 0)
80100ff2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ff5:	83 c4 10             	add    $0x10,%esp
80100ff8:	85 c0                	test   %eax,%eax
80100ffa:	74 98                	je     80100f94 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80100fff:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101004:	89 f8                	mov    %edi,%eax
80101006:	5b                   	pop    %ebx
80101007:	5e                   	pop    %esi
80101008:	5f                   	pop    %edi
80101009:	5d                   	pop    %ebp
8010100a:	c3                   	ret    
8010100b:	90                   	nop
8010100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101010:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101013:	75 e7                	jne    80100ffc <filewrite+0xcc>
}
80101015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101018:	89 f8                	mov    %edi,%eax
8010101a:	5b                   	pop    %ebx
8010101b:	5e                   	pop    %esi
8010101c:	5f                   	pop    %edi
8010101d:	5d                   	pop    %ebp
8010101e:	c3                   	ret    
8010101f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101020:	8b 46 0c             	mov    0xc(%esi),%eax
80101023:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101026:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101029:	5b                   	pop    %ebx
8010102a:	5e                   	pop    %esi
8010102b:	5f                   	pop    %edi
8010102c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010102d:	e9 2e 23 00 00       	jmp    80103360 <pipewrite>
        panic("short filewrite");
80101032:	83 ec 0c             	sub    $0xc,%esp
80101035:	68 e5 87 10 80       	push   $0x801087e5
8010103a:	e8 51 f3 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010103f:	83 ec 0c             	sub    $0xc,%esp
80101042:	68 eb 87 10 80       	push   $0x801087eb
80101047:	e8 44 f3 ff ff       	call   80100390 <panic>
8010104c:	66 90                	xchg   %ax,%ax
8010104e:	66 90                	xchg   %ax,%ax

80101050 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	57                   	push   %edi
80101054:	56                   	push   %esi
80101055:	53                   	push   %ebx
80101056:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101059:	8b 0d 80 2a 11 80    	mov    0x80112a80,%ecx
{
8010105f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101062:	85 c9                	test   %ecx,%ecx
80101064:	0f 84 87 00 00 00    	je     801010f1 <balloc+0xa1>
8010106a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101071:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101074:	83 ec 08             	sub    $0x8,%esp
80101077:	89 f0                	mov    %esi,%eax
80101079:	c1 f8 0c             	sar    $0xc,%eax
8010107c:	03 05 98 2a 11 80    	add    0x80112a98,%eax
80101082:	50                   	push   %eax
80101083:	ff 75 d8             	pushl  -0x28(%ebp)
80101086:	e8 45 f0 ff ff       	call   801000d0 <bread>
8010108b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010108e:	a1 80 2a 11 80       	mov    0x80112a80,%eax
80101093:	83 c4 10             	add    $0x10,%esp
80101096:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101099:	31 c0                	xor    %eax,%eax
8010109b:	eb 2f                	jmp    801010cc <balloc+0x7c>
8010109d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801010a0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801010a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801010a5:	bb 01 00 00 00       	mov    $0x1,%ebx
801010aa:	83 e1 07             	and    $0x7,%ecx
801010ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801010af:	89 c1                	mov    %eax,%ecx
801010b1:	c1 f9 03             	sar    $0x3,%ecx
801010b4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801010b9:	85 df                	test   %ebx,%edi
801010bb:	89 fa                	mov    %edi,%edx
801010bd:	74 41                	je     80101100 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801010bf:	83 c0 01             	add    $0x1,%eax
801010c2:	83 c6 01             	add    $0x1,%esi
801010c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801010ca:	74 05                	je     801010d1 <balloc+0x81>
801010cc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801010cf:	77 cf                	ja     801010a0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801010d1:	83 ec 0c             	sub    $0xc,%esp
801010d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801010d7:	e8 04 f1 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801010dc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801010e3:	83 c4 10             	add    $0x10,%esp
801010e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010e9:	39 05 80 2a 11 80    	cmp    %eax,0x80112a80
801010ef:	77 80                	ja     80101071 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801010f1:	83 ec 0c             	sub    $0xc,%esp
801010f4:	68 f5 87 10 80       	push   $0x801087f5
801010f9:	e8 92 f2 ff ff       	call   80100390 <panic>
801010fe:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101100:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101103:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101106:	09 da                	or     %ebx,%edx
80101108:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010110c:	57                   	push   %edi
8010110d:	e8 ce 1b 00 00       	call   80102ce0 <log_write>
        brelse(bp);
80101112:	89 3c 24             	mov    %edi,(%esp)
80101115:	e8 c6 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010111a:	58                   	pop    %eax
8010111b:	5a                   	pop    %edx
8010111c:	56                   	push   %esi
8010111d:	ff 75 d8             	pushl  -0x28(%ebp)
80101120:	e8 ab ef ff ff       	call   801000d0 <bread>
80101125:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101127:	8d 40 5c             	lea    0x5c(%eax),%eax
8010112a:	83 c4 0c             	add    $0xc,%esp
8010112d:	68 00 02 00 00       	push   $0x200
80101132:	6a 00                	push   $0x0
80101134:	50                   	push   %eax
80101135:	e8 66 3c 00 00       	call   80104da0 <memset>
  log_write(bp);
8010113a:	89 1c 24             	mov    %ebx,(%esp)
8010113d:	e8 9e 1b 00 00       	call   80102ce0 <log_write>
  brelse(bp);
80101142:	89 1c 24             	mov    %ebx,(%esp)
80101145:	e8 96 f0 ff ff       	call   801001e0 <brelse>
}
8010114a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010114d:	89 f0                	mov    %esi,%eax
8010114f:	5b                   	pop    %ebx
80101150:	5e                   	pop    %esi
80101151:	5f                   	pop    %edi
80101152:	5d                   	pop    %ebp
80101153:	c3                   	ret    
80101154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010115a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101160 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	57                   	push   %edi
80101164:	56                   	push   %esi
80101165:	53                   	push   %ebx
80101166:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101168:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010116a:	bb d4 2a 11 80       	mov    $0x80112ad4,%ebx
{
8010116f:	83 ec 28             	sub    $0x28,%esp
80101172:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101175:	68 a0 2a 11 80       	push   $0x80112aa0
8010117a:	e8 11 3b 00 00       	call   80104c90 <acquire>
8010117f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101182:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101185:	eb 17                	jmp    8010119e <iget+0x3e>
80101187:	89 f6                	mov    %esi,%esi
80101189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101190:	81 c3 98 00 00 00    	add    $0x98,%ebx
80101196:	81 fb 84 48 11 80    	cmp    $0x80114884,%ebx
8010119c:	73 22                	jae    801011c0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010119e:	8b 4b 08             	mov    0x8(%ebx),%ecx
801011a1:	85 c9                	test   %ecx,%ecx
801011a3:	7e 04                	jle    801011a9 <iget+0x49>
801011a5:	39 3b                	cmp    %edi,(%ebx)
801011a7:	74 4f                	je     801011f8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801011a9:	85 f6                	test   %esi,%esi
801011ab:	75 e3                	jne    80101190 <iget+0x30>
801011ad:	85 c9                	test   %ecx,%ecx
801011af:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011b2:	81 c3 98 00 00 00    	add    $0x98,%ebx
801011b8:	81 fb 84 48 11 80    	cmp    $0x80114884,%ebx
801011be:	72 de                	jb     8010119e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801011c0:	85 f6                	test   %esi,%esi
801011c2:	74 5b                	je     8010121f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801011c4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801011c7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801011c9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801011cc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801011d3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801011da:	68 a0 2a 11 80       	push   $0x80112aa0
801011df:	e8 6c 3b 00 00       	call   80104d50 <release>

  return ip;
801011e4:	83 c4 10             	add    $0x10,%esp
}
801011e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ea:	89 f0                	mov    %esi,%eax
801011ec:	5b                   	pop    %ebx
801011ed:	5e                   	pop    %esi
801011ee:	5f                   	pop    %edi
801011ef:	5d                   	pop    %ebp
801011f0:	c3                   	ret    
801011f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801011f8:	39 53 04             	cmp    %edx,0x4(%ebx)
801011fb:	75 ac                	jne    801011a9 <iget+0x49>
      release(&icache.lock);
801011fd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101200:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101203:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101205:	68 a0 2a 11 80       	push   $0x80112aa0
      ip->ref++;
8010120a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010120d:	e8 3e 3b 00 00       	call   80104d50 <release>
      return ip;
80101212:	83 c4 10             	add    $0x10,%esp
}
80101215:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101218:	89 f0                	mov    %esi,%eax
8010121a:	5b                   	pop    %ebx
8010121b:	5e                   	pop    %esi
8010121c:	5f                   	pop    %edi
8010121d:	5d                   	pop    %ebp
8010121e:	c3                   	ret    
    panic("iget: no inodes");
8010121f:	83 ec 0c             	sub    $0xc,%esp
80101222:	68 0b 88 10 80       	push   $0x8010880b
80101227:	e8 64 f1 ff ff       	call   80100390 <panic>
8010122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101230 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	57                   	push   %edi
80101234:	56                   	push   %esi
80101235:	53                   	push   %ebx
80101236:	89 c6                	mov    %eax,%esi
80101238:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010123b:	83 fa 0b             	cmp    $0xb,%edx
8010123e:	77 18                	ja     80101258 <bmap+0x28>
80101240:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101243:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101246:	85 db                	test   %ebx,%ebx
80101248:	74 76                	je     801012c0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010124a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010124d:	89 d8                	mov    %ebx,%eax
8010124f:	5b                   	pop    %ebx
80101250:	5e                   	pop    %esi
80101251:	5f                   	pop    %edi
80101252:	5d                   	pop    %ebp
80101253:	c3                   	ret    
80101254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101258:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010125b:	83 fb 7f             	cmp    $0x7f,%ebx
8010125e:	0f 87 90 00 00 00    	ja     801012f4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101264:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010126a:	8b 00                	mov    (%eax),%eax
8010126c:	85 d2                	test   %edx,%edx
8010126e:	74 70                	je     801012e0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101270:	83 ec 08             	sub    $0x8,%esp
80101273:	52                   	push   %edx
80101274:	50                   	push   %eax
80101275:	e8 56 ee ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010127a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010127e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101281:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101283:	8b 1a                	mov    (%edx),%ebx
80101285:	85 db                	test   %ebx,%ebx
80101287:	75 1d                	jne    801012a6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101289:	8b 06                	mov    (%esi),%eax
8010128b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010128e:	e8 bd fd ff ff       	call   80101050 <balloc>
80101293:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101296:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101299:	89 c3                	mov    %eax,%ebx
8010129b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010129d:	57                   	push   %edi
8010129e:	e8 3d 1a 00 00       	call   80102ce0 <log_write>
801012a3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801012a6:	83 ec 0c             	sub    $0xc,%esp
801012a9:	57                   	push   %edi
801012aa:	e8 31 ef ff ff       	call   801001e0 <brelse>
801012af:	83 c4 10             	add    $0x10,%esp
}
801012b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012b5:	89 d8                	mov    %ebx,%eax
801012b7:	5b                   	pop    %ebx
801012b8:	5e                   	pop    %esi
801012b9:	5f                   	pop    %edi
801012ba:	5d                   	pop    %ebp
801012bb:	c3                   	ret    
801012bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801012c0:	8b 00                	mov    (%eax),%eax
801012c2:	e8 89 fd ff ff       	call   80101050 <balloc>
801012c7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801012ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801012cd:	89 c3                	mov    %eax,%ebx
}
801012cf:	89 d8                	mov    %ebx,%eax
801012d1:	5b                   	pop    %ebx
801012d2:	5e                   	pop    %esi
801012d3:	5f                   	pop    %edi
801012d4:	5d                   	pop    %ebp
801012d5:	c3                   	ret    
801012d6:	8d 76 00             	lea    0x0(%esi),%esi
801012d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801012e0:	e8 6b fd ff ff       	call   80101050 <balloc>
801012e5:	89 c2                	mov    %eax,%edx
801012e7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801012ed:	8b 06                	mov    (%esi),%eax
801012ef:	e9 7c ff ff ff       	jmp    80101270 <bmap+0x40>
  panic("bmap: out of range");
801012f4:	83 ec 0c             	sub    $0xc,%esp
801012f7:	68 1b 88 10 80       	push   $0x8010881b
801012fc:	e8 8f f0 ff ff       	call   80100390 <panic>
80101301:	eb 0d                	jmp    80101310 <readsb>
80101303:	90                   	nop
80101304:	90                   	nop
80101305:	90                   	nop
80101306:	90                   	nop
80101307:	90                   	nop
80101308:	90                   	nop
80101309:	90                   	nop
8010130a:	90                   	nop
8010130b:	90                   	nop
8010130c:	90                   	nop
8010130d:	90                   	nop
8010130e:	90                   	nop
8010130f:	90                   	nop

80101310 <readsb>:
{
80101310:	55                   	push   %ebp
80101311:	89 e5                	mov    %esp,%ebp
80101313:	56                   	push   %esi
80101314:	53                   	push   %ebx
80101315:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101318:	83 ec 08             	sub    $0x8,%esp
8010131b:	6a 01                	push   $0x1
8010131d:	ff 75 08             	pushl  0x8(%ebp)
80101320:	e8 ab ed ff ff       	call   801000d0 <bread>
80101325:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101327:	8d 40 5c             	lea    0x5c(%eax),%eax
8010132a:	83 c4 0c             	add    $0xc,%esp
8010132d:	6a 1c                	push   $0x1c
8010132f:	50                   	push   %eax
80101330:	56                   	push   %esi
80101331:	e8 1a 3b 00 00       	call   80104e50 <memmove>
  brelse(bp);
80101336:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101339:	83 c4 10             	add    $0x10,%esp
}
8010133c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010133f:	5b                   	pop    %ebx
80101340:	5e                   	pop    %esi
80101341:	5d                   	pop    %ebp
  brelse(bp);
80101342:	e9 99 ee ff ff       	jmp    801001e0 <brelse>
80101347:	89 f6                	mov    %esi,%esi
80101349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101350 <bfree>:
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	56                   	push   %esi
80101354:	53                   	push   %ebx
80101355:	89 d3                	mov    %edx,%ebx
80101357:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101359:	83 ec 08             	sub    $0x8,%esp
8010135c:	68 80 2a 11 80       	push   $0x80112a80
80101361:	50                   	push   %eax
80101362:	e8 a9 ff ff ff       	call   80101310 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101367:	58                   	pop    %eax
80101368:	5a                   	pop    %edx
80101369:	89 da                	mov    %ebx,%edx
8010136b:	c1 ea 0c             	shr    $0xc,%edx
8010136e:	03 15 98 2a 11 80    	add    0x80112a98,%edx
80101374:	52                   	push   %edx
80101375:	56                   	push   %esi
80101376:	e8 55 ed ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010137b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010137d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101380:	ba 01 00 00 00       	mov    $0x1,%edx
80101385:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101388:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010138e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101391:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101393:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101398:	85 d1                	test   %edx,%ecx
8010139a:	74 25                	je     801013c1 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010139c:	f7 d2                	not    %edx
8010139e:	89 c6                	mov    %eax,%esi
  log_write(bp);
801013a0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801013a3:	21 ca                	and    %ecx,%edx
801013a5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801013a9:	56                   	push   %esi
801013aa:	e8 31 19 00 00       	call   80102ce0 <log_write>
  brelse(bp);
801013af:	89 34 24             	mov    %esi,(%esp)
801013b2:	e8 29 ee ff ff       	call   801001e0 <brelse>
}
801013b7:	83 c4 10             	add    $0x10,%esp
801013ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013bd:	5b                   	pop    %ebx
801013be:	5e                   	pop    %esi
801013bf:	5d                   	pop    %ebp
801013c0:	c3                   	ret    
    panic("freeing free block");
801013c1:	83 ec 0c             	sub    $0xc,%esp
801013c4:	68 2e 88 10 80       	push   $0x8010882e
801013c9:	e8 c2 ef ff ff       	call   80100390 <panic>
801013ce:	66 90                	xchg   %ax,%ax

801013d0 <iinit>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	53                   	push   %ebx
801013d4:	bb e0 2a 11 80       	mov    $0x80112ae0,%ebx
801013d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801013dc:	68 41 88 10 80       	push   $0x80108841
801013e1:	68 a0 2a 11 80       	push   $0x80112aa0
801013e6:	e8 65 37 00 00       	call   80104b50 <initlock>
801013eb:	83 c4 10             	add    $0x10,%esp
801013ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801013f0:	83 ec 08             	sub    $0x8,%esp
801013f3:	68 48 88 10 80       	push   $0x80108848
801013f8:	53                   	push   %ebx
801013f9:	81 c3 98 00 00 00    	add    $0x98,%ebx
801013ff:	e8 1c 36 00 00       	call   80104a20 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101404:	83 c4 10             	add    $0x10,%esp
80101407:	81 fb 90 48 11 80    	cmp    $0x80114890,%ebx
8010140d:	75 e1                	jne    801013f0 <iinit+0x20>
  readsb(dev, &sb);
8010140f:	83 ec 08             	sub    $0x8,%esp
80101412:	68 80 2a 11 80       	push   $0x80112a80
80101417:	ff 75 08             	pushl  0x8(%ebp)
8010141a:	e8 f1 fe ff ff       	call   80101310 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010141f:	ff 35 98 2a 11 80    	pushl  0x80112a98
80101425:	ff 35 94 2a 11 80    	pushl  0x80112a94
8010142b:	ff 35 90 2a 11 80    	pushl  0x80112a90
80101431:	ff 35 8c 2a 11 80    	pushl  0x80112a8c
80101437:	ff 35 88 2a 11 80    	pushl  0x80112a88
8010143d:	ff 35 84 2a 11 80    	pushl  0x80112a84
80101443:	ff 35 80 2a 11 80    	pushl  0x80112a80
80101449:	68 ac 88 10 80       	push   $0x801088ac
8010144e:	e8 0d f2 ff ff       	call   80100660 <cprintf>
}
80101453:	83 c4 30             	add    $0x30,%esp
80101456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101459:	c9                   	leave  
8010145a:	c3                   	ret    
8010145b:	90                   	nop
8010145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101460 <ialloc>:
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	57                   	push   %edi
80101464:	56                   	push   %esi
80101465:	53                   	push   %ebx
80101466:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101469:	83 3d 88 2a 11 80 01 	cmpl   $0x1,0x80112a88
{
80101470:	8b 45 0c             	mov    0xc(%ebp),%eax
80101473:	8b 75 08             	mov    0x8(%ebp),%esi
80101476:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101479:	0f 86 91 00 00 00    	jbe    80101510 <ialloc+0xb0>
8010147f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101484:	eb 21                	jmp    801014a7 <ialloc+0x47>
80101486:	8d 76 00             	lea    0x0(%esi),%esi
80101489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101490:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101493:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101496:	57                   	push   %edi
80101497:	e8 44 ed ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010149c:	83 c4 10             	add    $0x10,%esp
8010149f:	39 1d 88 2a 11 80    	cmp    %ebx,0x80112a88
801014a5:	76 69                	jbe    80101510 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801014a7:	89 d8                	mov    %ebx,%eax
801014a9:	83 ec 08             	sub    $0x8,%esp
801014ac:	c1 e8 03             	shr    $0x3,%eax
801014af:	03 05 94 2a 11 80    	add    0x80112a94,%eax
801014b5:	50                   	push   %eax
801014b6:	56                   	push   %esi
801014b7:	e8 14 ec ff ff       	call   801000d0 <bread>
801014bc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801014be:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801014c0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801014c3:	83 e0 07             	and    $0x7,%eax
801014c6:	c1 e0 06             	shl    $0x6,%eax
801014c9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801014cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801014d1:	75 bd                	jne    80101490 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801014d3:	83 ec 04             	sub    $0x4,%esp
801014d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801014d9:	6a 40                	push   $0x40
801014db:	6a 00                	push   $0x0
801014dd:	51                   	push   %ecx
801014de:	e8 bd 38 00 00       	call   80104da0 <memset>
      dip->type = type;
801014e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801014e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801014ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801014ed:	89 3c 24             	mov    %edi,(%esp)
801014f0:	e8 eb 17 00 00       	call   80102ce0 <log_write>
      brelse(bp);
801014f5:	89 3c 24             	mov    %edi,(%esp)
801014f8:	e8 e3 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801014fd:	83 c4 10             	add    $0x10,%esp
}
80101500:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101503:	89 da                	mov    %ebx,%edx
80101505:	89 f0                	mov    %esi,%eax
}
80101507:	5b                   	pop    %ebx
80101508:	5e                   	pop    %esi
80101509:	5f                   	pop    %edi
8010150a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010150b:	e9 50 fc ff ff       	jmp    80101160 <iget>
  panic("ialloc: no inodes");
80101510:	83 ec 0c             	sub    $0xc,%esp
80101513:	68 4e 88 10 80       	push   $0x8010884e
80101518:	e8 73 ee ff ff       	call   80100390 <panic>
8010151d:	8d 76 00             	lea    0x0(%esi),%esi

80101520 <iupdate>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	56                   	push   %esi
80101524:	53                   	push   %ebx
80101525:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101528:	83 ec 08             	sub    $0x8,%esp
8010152b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010152e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101531:	c1 e8 03             	shr    $0x3,%eax
80101534:	03 05 94 2a 11 80    	add    0x80112a94,%eax
8010153a:	50                   	push   %eax
8010153b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010153e:	e8 8d eb ff ff       	call   801000d0 <bread>
80101543:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101545:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101548:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010154c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010154f:	83 e0 07             	and    $0x7,%eax
80101552:	c1 e0 06             	shl    $0x6,%eax
80101555:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101559:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010155c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101560:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101563:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101567:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010156b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010156f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101573:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101577:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010157a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010157d:	6a 34                	push   $0x34
8010157f:	53                   	push   %ebx
80101580:	50                   	push   %eax
80101581:	e8 ca 38 00 00       	call   80104e50 <memmove>
  log_write(bp);
80101586:	89 34 24             	mov    %esi,(%esp)
80101589:	e8 52 17 00 00       	call   80102ce0 <log_write>
  brelse(bp);
8010158e:	89 75 08             	mov    %esi,0x8(%ebp)
80101591:	83 c4 10             	add    $0x10,%esp
}
80101594:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101597:	5b                   	pop    %ebx
80101598:	5e                   	pop    %esi
80101599:	5d                   	pop    %ebp
  brelse(bp);
8010159a:	e9 41 ec ff ff       	jmp    801001e0 <brelse>
8010159f:	90                   	nop

801015a0 <idup>:
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	53                   	push   %ebx
801015a4:	83 ec 10             	sub    $0x10,%esp
801015a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801015aa:	68 a0 2a 11 80       	push   $0x80112aa0
801015af:	e8 dc 36 00 00       	call   80104c90 <acquire>
  ip->ref++;
801015b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801015b8:	c7 04 24 a0 2a 11 80 	movl   $0x80112aa0,(%esp)
801015bf:	e8 8c 37 00 00       	call   80104d50 <release>
}
801015c4:	89 d8                	mov    %ebx,%eax
801015c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015c9:	c9                   	leave  
801015ca:	c3                   	ret    
801015cb:	90                   	nop
801015cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015d0 <ilock>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801015d8:	85 db                	test   %ebx,%ebx
801015da:	0f 84 b7 00 00 00    	je     80101697 <ilock+0xc7>
801015e0:	8b 53 08             	mov    0x8(%ebx),%edx
801015e3:	85 d2                	test   %edx,%edx
801015e5:	0f 8e ac 00 00 00    	jle    80101697 <ilock+0xc7>
  acquiresleep(&ip->lock);
801015eb:	8d 43 0c             	lea    0xc(%ebx),%eax
801015ee:	83 ec 0c             	sub    $0xc,%esp
801015f1:	50                   	push   %eax
801015f2:	e8 69 34 00 00       	call   80104a60 <acquiresleep>
  if(ip->valid == 0){
801015f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801015fa:	83 c4 10             	add    $0x10,%esp
801015fd:	85 c0                	test   %eax,%eax
801015ff:	74 0f                	je     80101610 <ilock+0x40>
}
80101601:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101604:	5b                   	pop    %ebx
80101605:	5e                   	pop    %esi
80101606:	5d                   	pop    %ebp
80101607:	c3                   	ret    
80101608:	90                   	nop
80101609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101610:	8b 43 04             	mov    0x4(%ebx),%eax
80101613:	83 ec 08             	sub    $0x8,%esp
80101616:	c1 e8 03             	shr    $0x3,%eax
80101619:	03 05 94 2a 11 80    	add    0x80112a94,%eax
8010161f:	50                   	push   %eax
80101620:	ff 33                	pushl  (%ebx)
80101622:	e8 a9 ea ff ff       	call   801000d0 <bread>
80101627:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101629:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010162c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010162f:	83 e0 07             	and    $0x7,%eax
80101632:	c1 e0 06             	shl    $0x6,%eax
80101635:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101639:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010163c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010163f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101643:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101647:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010164b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010164f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101653:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101657:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010165b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010165e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101661:	6a 34                	push   $0x34
80101663:	50                   	push   %eax
80101664:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101667:	50                   	push   %eax
80101668:	e8 e3 37 00 00       	call   80104e50 <memmove>
    brelse(bp);
8010166d:	89 34 24             	mov    %esi,(%esp)
80101670:	e8 6b eb ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101675:	83 c4 10             	add    $0x10,%esp
80101678:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010167d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101684:	0f 85 77 ff ff ff    	jne    80101601 <ilock+0x31>
      panic("ilock: no type");
8010168a:	83 ec 0c             	sub    $0xc,%esp
8010168d:	68 66 88 10 80       	push   $0x80108866
80101692:	e8 f9 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	68 60 88 10 80       	push   $0x80108860
8010169f:	e8 ec ec ff ff       	call   80100390 <panic>
801016a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801016aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801016b0 <iunlock>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801016b8:	85 db                	test   %ebx,%ebx
801016ba:	74 28                	je     801016e4 <iunlock+0x34>
801016bc:	8d 73 0c             	lea    0xc(%ebx),%esi
801016bf:	83 ec 0c             	sub    $0xc,%esp
801016c2:	56                   	push   %esi
801016c3:	e8 38 34 00 00       	call   80104b00 <holdingsleep>
801016c8:	83 c4 10             	add    $0x10,%esp
801016cb:	85 c0                	test   %eax,%eax
801016cd:	74 15                	je     801016e4 <iunlock+0x34>
801016cf:	8b 43 08             	mov    0x8(%ebx),%eax
801016d2:	85 c0                	test   %eax,%eax
801016d4:	7e 0e                	jle    801016e4 <iunlock+0x34>
  releasesleep(&ip->lock);
801016d6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016dc:	5b                   	pop    %ebx
801016dd:	5e                   	pop    %esi
801016de:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801016df:	e9 dc 33 00 00       	jmp    80104ac0 <releasesleep>
    panic("iunlock");
801016e4:	83 ec 0c             	sub    $0xc,%esp
801016e7:	68 75 88 10 80       	push   $0x80108875
801016ec:	e8 9f ec ff ff       	call   80100390 <panic>
801016f1:	eb 0d                	jmp    80101700 <iput>
801016f3:	90                   	nop
801016f4:	90                   	nop
801016f5:	90                   	nop
801016f6:	90                   	nop
801016f7:	90                   	nop
801016f8:	90                   	nop
801016f9:	90                   	nop
801016fa:	90                   	nop
801016fb:	90                   	nop
801016fc:	90                   	nop
801016fd:	90                   	nop
801016fe:	90                   	nop
801016ff:	90                   	nop

80101700 <iput>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	57                   	push   %edi
80101704:	56                   	push   %esi
80101705:	53                   	push   %ebx
80101706:	83 ec 28             	sub    $0x28,%esp
80101709:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010170c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010170f:	57                   	push   %edi
80101710:	e8 4b 33 00 00       	call   80104a60 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101715:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101718:	83 c4 10             	add    $0x10,%esp
8010171b:	85 d2                	test   %edx,%edx
8010171d:	74 07                	je     80101726 <iput+0x26>
8010171f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101724:	74 32                	je     80101758 <iput+0x58>
  releasesleep(&ip->lock);
80101726:	83 ec 0c             	sub    $0xc,%esp
80101729:	57                   	push   %edi
8010172a:	e8 91 33 00 00       	call   80104ac0 <releasesleep>
  acquire(&icache.lock);
8010172f:	c7 04 24 a0 2a 11 80 	movl   $0x80112aa0,(%esp)
80101736:	e8 55 35 00 00       	call   80104c90 <acquire>
  ip->ref--;
8010173b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010173f:	83 c4 10             	add    $0x10,%esp
80101742:	c7 45 08 a0 2a 11 80 	movl   $0x80112aa0,0x8(%ebp)
}
80101749:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010174c:	5b                   	pop    %ebx
8010174d:	5e                   	pop    %esi
8010174e:	5f                   	pop    %edi
8010174f:	5d                   	pop    %ebp
  release(&icache.lock);
80101750:	e9 fb 35 00 00       	jmp    80104d50 <release>
80101755:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101758:	83 ec 0c             	sub    $0xc,%esp
8010175b:	68 a0 2a 11 80       	push   $0x80112aa0
80101760:	e8 2b 35 00 00       	call   80104c90 <acquire>
    int r = ip->ref;
80101765:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101768:	c7 04 24 a0 2a 11 80 	movl   $0x80112aa0,(%esp)
8010176f:	e8 dc 35 00 00       	call   80104d50 <release>
    if(r == 1){
80101774:	83 c4 10             	add    $0x10,%esp
80101777:	83 fe 01             	cmp    $0x1,%esi
8010177a:	75 aa                	jne    80101726 <iput+0x26>
8010177c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101782:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101785:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101788:	89 cf                	mov    %ecx,%edi
8010178a:	eb 0b                	jmp    80101797 <iput+0x97>
8010178c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101790:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101793:	39 fe                	cmp    %edi,%esi
80101795:	74 19                	je     801017b0 <iput+0xb0>
    if(ip->addrs[i]){
80101797:	8b 16                	mov    (%esi),%edx
80101799:	85 d2                	test   %edx,%edx
8010179b:	74 f3                	je     80101790 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010179d:	8b 03                	mov    (%ebx),%eax
8010179f:	e8 ac fb ff ff       	call   80101350 <bfree>
      ip->addrs[i] = 0;
801017a4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801017aa:	eb e4                	jmp    80101790 <iput+0x90>
801017ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801017b0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801017b6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801017b9:	85 c0                	test   %eax,%eax
801017bb:	75 33                	jne    801017f0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801017bd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801017c0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801017c7:	53                   	push   %ebx
801017c8:	e8 53 fd ff ff       	call   80101520 <iupdate>
      ip->type = 0;
801017cd:	31 c0                	xor    %eax,%eax
801017cf:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801017d3:	89 1c 24             	mov    %ebx,(%esp)
801017d6:	e8 45 fd ff ff       	call   80101520 <iupdate>
      ip->valid = 0;
801017db:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801017e2:	83 c4 10             	add    $0x10,%esp
801017e5:	e9 3c ff ff ff       	jmp    80101726 <iput+0x26>
801017ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801017f0:	83 ec 08             	sub    $0x8,%esp
801017f3:	50                   	push   %eax
801017f4:	ff 33                	pushl  (%ebx)
801017f6:	e8 d5 e8 ff ff       	call   801000d0 <bread>
801017fb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101801:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101804:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101807:	8d 70 5c             	lea    0x5c(%eax),%esi
8010180a:	83 c4 10             	add    $0x10,%esp
8010180d:	89 cf                	mov    %ecx,%edi
8010180f:	eb 0e                	jmp    8010181f <iput+0x11f>
80101811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101818:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010181b:	39 fe                	cmp    %edi,%esi
8010181d:	74 0f                	je     8010182e <iput+0x12e>
      if(a[j])
8010181f:	8b 16                	mov    (%esi),%edx
80101821:	85 d2                	test   %edx,%edx
80101823:	74 f3                	je     80101818 <iput+0x118>
        bfree(ip->dev, a[j]);
80101825:	8b 03                	mov    (%ebx),%eax
80101827:	e8 24 fb ff ff       	call   80101350 <bfree>
8010182c:	eb ea                	jmp    80101818 <iput+0x118>
    brelse(bp);
8010182e:	83 ec 0c             	sub    $0xc,%esp
80101831:	ff 75 e4             	pushl  -0x1c(%ebp)
80101834:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101837:	e8 a4 e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010183c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101842:	8b 03                	mov    (%ebx),%eax
80101844:	e8 07 fb ff ff       	call   80101350 <bfree>
    ip->addrs[NDIRECT] = 0;
80101849:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101850:	00 00 00 
80101853:	83 c4 10             	add    $0x10,%esp
80101856:	e9 62 ff ff ff       	jmp    801017bd <iput+0xbd>
8010185b:	90                   	nop
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101860 <iunlockput>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	53                   	push   %ebx
80101864:	83 ec 10             	sub    $0x10,%esp
80101867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010186a:	53                   	push   %ebx
8010186b:	e8 40 fe ff ff       	call   801016b0 <iunlock>
  iput(ip);
80101870:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101873:	83 c4 10             	add    $0x10,%esp
}
80101876:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101879:	c9                   	leave  
  iput(ip);
8010187a:	e9 81 fe ff ff       	jmp    80101700 <iput>
8010187f:	90                   	nop

80101880 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	8b 55 08             	mov    0x8(%ebp),%edx
80101886:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101889:	8b 0a                	mov    (%edx),%ecx
8010188b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010188e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101891:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101894:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101898:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010189b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010189f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801018a3:	8b 4a 58             	mov    0x58(%edx),%ecx
801018a6:	89 48 10             	mov    %ecx,0x10(%eax)
  
  // ADDED 
  st->cid = ip->cid;
801018a9:	8b 8a 90 00 00 00    	mov    0x90(%edx),%ecx
801018af:	89 48 14             	mov    %ecx,0x14(%eax)
  st->path_len = ip->path_len;
801018b2:	8b 92 94 00 00 00    	mov    0x94(%edx),%edx
801018b8:	89 50 18             	mov    %edx,0x18(%eax)
}
801018bb:	5d                   	pop    %ebp
801018bc:	c3                   	ret    
801018bd:	8d 76 00             	lea    0x0(%esi),%esi

801018c0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 1c             	sub    $0x1c,%esp
801018c9:	8b 45 08             	mov    0x8(%ebp),%eax
801018cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801018cf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801018d2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801018d7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801018da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801018dd:	8b 75 10             	mov    0x10(%ebp),%esi
801018e0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801018e3:	0f 84 a7 00 00 00    	je     80101990 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801018e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801018ec:	8b 40 58             	mov    0x58(%eax),%eax
801018ef:	39 c6                	cmp    %eax,%esi
801018f1:	0f 87 ba 00 00 00    	ja     801019b1 <readi+0xf1>
801018f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018fa:	89 f9                	mov    %edi,%ecx
801018fc:	01 f1                	add    %esi,%ecx
801018fe:	0f 82 ad 00 00 00    	jb     801019b1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101904:	89 c2                	mov    %eax,%edx
80101906:	29 f2                	sub    %esi,%edx
80101908:	39 c8                	cmp    %ecx,%eax
8010190a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010190d:	31 ff                	xor    %edi,%edi
8010190f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101911:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101914:	74 6c                	je     80101982 <readi+0xc2>
80101916:	8d 76 00             	lea    0x0(%esi),%esi
80101919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101920:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101923:	89 f2                	mov    %esi,%edx
80101925:	c1 ea 09             	shr    $0x9,%edx
80101928:	89 d8                	mov    %ebx,%eax
8010192a:	e8 01 f9 ff ff       	call   80101230 <bmap>
8010192f:	83 ec 08             	sub    $0x8,%esp
80101932:	50                   	push   %eax
80101933:	ff 33                	pushl  (%ebx)
80101935:	e8 96 e7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010193a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010193d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
8010193f:	89 f0                	mov    %esi,%eax
80101941:	25 ff 01 00 00       	and    $0x1ff,%eax
80101946:	b9 00 02 00 00       	mov    $0x200,%ecx
8010194b:	83 c4 0c             	add    $0xc,%esp
8010194e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101950:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101954:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101957:	29 fb                	sub    %edi,%ebx
80101959:	39 d9                	cmp    %ebx,%ecx
8010195b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010195e:	53                   	push   %ebx
8010195f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101960:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101962:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101965:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101967:	e8 e4 34 00 00       	call   80104e50 <memmove>
    brelse(bp);
8010196c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010196f:	89 14 24             	mov    %edx,(%esp)
80101972:	e8 69 e8 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101977:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010197a:	83 c4 10             	add    $0x10,%esp
8010197d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101980:	77 9e                	ja     80101920 <readi+0x60>
  }
  return n;
80101982:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101985:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101988:	5b                   	pop    %ebx
80101989:	5e                   	pop    %esi
8010198a:	5f                   	pop    %edi
8010198b:	5d                   	pop    %ebp
8010198c:	c3                   	ret    
8010198d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101990:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101994:	66 83 f8 09          	cmp    $0x9,%ax
80101998:	77 17                	ja     801019b1 <readi+0xf1>
8010199a:	8b 04 c5 20 2a 11 80 	mov    -0x7feed5e0(,%eax,8),%eax
801019a1:	85 c0                	test   %eax,%eax
801019a3:	74 0c                	je     801019b1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801019a5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801019a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ab:	5b                   	pop    %ebx
801019ac:	5e                   	pop    %esi
801019ad:	5f                   	pop    %edi
801019ae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801019af:	ff e0                	jmp    *%eax
      return -1;
801019b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801019b6:	eb cd                	jmp    80101985 <readi+0xc5>
801019b8:	90                   	nop
801019b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801019c0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	57                   	push   %edi
801019c4:	56                   	push   %esi
801019c5:	53                   	push   %ebx
801019c6:	83 ec 1c             	sub    $0x1c,%esp
801019c9:	8b 45 08             	mov    0x8(%ebp),%eax
801019cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801019cf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019d2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801019d7:	89 75 dc             	mov    %esi,-0x24(%ebp)
801019da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019dd:	8b 75 10             	mov    0x10(%ebp),%esi
801019e0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
801019e3:	0f 84 b7 00 00 00    	je     80101aa0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801019e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019ec:	39 70 58             	cmp    %esi,0x58(%eax)
801019ef:	0f 82 eb 00 00 00    	jb     80101ae0 <writei+0x120>
801019f5:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019f8:	31 d2                	xor    %edx,%edx
801019fa:	89 f8                	mov    %edi,%eax
801019fc:	01 f0                	add    %esi,%eax
801019fe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a01:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a06:	0f 87 d4 00 00 00    	ja     80101ae0 <writei+0x120>
80101a0c:	85 d2                	test   %edx,%edx
80101a0e:	0f 85 cc 00 00 00    	jne    80101ae0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a14:	85 ff                	test   %edi,%edi
80101a16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a1d:	74 72                	je     80101a91 <writei+0xd1>
80101a1f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a20:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a23:	89 f2                	mov    %esi,%edx
80101a25:	c1 ea 09             	shr    $0x9,%edx
80101a28:	89 f8                	mov    %edi,%eax
80101a2a:	e8 01 f8 ff ff       	call   80101230 <bmap>
80101a2f:	83 ec 08             	sub    $0x8,%esp
80101a32:	50                   	push   %eax
80101a33:	ff 37                	pushl  (%edi)
80101a35:	e8 96 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a3a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101a3d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a40:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a42:	89 f0                	mov    %esi,%eax
80101a44:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a49:	83 c4 0c             	add    $0xc,%esp
80101a4c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a51:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101a53:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a57:	39 d9                	cmp    %ebx,%ecx
80101a59:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101a5c:	53                   	push   %ebx
80101a5d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a60:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101a62:	50                   	push   %eax
80101a63:	e8 e8 33 00 00       	call   80104e50 <memmove>
    log_write(bp);
80101a68:	89 3c 24             	mov    %edi,(%esp)
80101a6b:	e8 70 12 00 00       	call   80102ce0 <log_write>
    brelse(bp);
80101a70:	89 3c 24             	mov    %edi,(%esp)
80101a73:	e8 68 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a78:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a7b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101a7e:	83 c4 10             	add    $0x10,%esp
80101a81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a84:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101a87:	77 97                	ja     80101a20 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	3b 70 58             	cmp    0x58(%eax),%esi
80101a8f:	77 37                	ja     80101ac8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101a91:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101a94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a97:	5b                   	pop    %ebx
80101a98:	5e                   	pop    %esi
80101a99:	5f                   	pop    %edi
80101a9a:	5d                   	pop    %ebp
80101a9b:	c3                   	ret    
80101a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101aa0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101aa4:	66 83 f8 09          	cmp    $0x9,%ax
80101aa8:	77 36                	ja     80101ae0 <writei+0x120>
80101aaa:	8b 04 c5 24 2a 11 80 	mov    -0x7feed5dc(,%eax,8),%eax
80101ab1:	85 c0                	test   %eax,%eax
80101ab3:	74 2b                	je     80101ae0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101ab5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101abb:	5b                   	pop    %ebx
80101abc:	5e                   	pop    %esi
80101abd:	5f                   	pop    %edi
80101abe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101abf:	ff e0                	jmp    *%eax
80101ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ac8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101acb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101ace:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ad1:	50                   	push   %eax
80101ad2:	e8 49 fa ff ff       	call   80101520 <iupdate>
80101ad7:	83 c4 10             	add    $0x10,%esp
80101ada:	eb b5                	jmp    80101a91 <writei+0xd1>
80101adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ae5:	eb ad                	jmp    80101a94 <writei+0xd4>
80101ae7:	89 f6                	mov    %esi,%esi
80101ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101af0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101af6:	6a 0e                	push   $0xe
80101af8:	ff 75 0c             	pushl  0xc(%ebp)
80101afb:	ff 75 08             	pushl  0x8(%ebp)
80101afe:	e8 bd 33 00 00       	call   80104ec0 <strncmp>
}
80101b03:	c9                   	leave  
80101b04:	c3                   	ret    
80101b05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b10 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	57                   	push   %edi
80101b14:	56                   	push   %esi
80101b15:	53                   	push   %ebx
80101b16:	83 ec 1c             	sub    $0x1c,%esp
80101b19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b1c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101b21:	0f 85 85 00 00 00    	jne    80101bac <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b27:	8b 53 58             	mov    0x58(%ebx),%edx
80101b2a:	31 ff                	xor    %edi,%edi
80101b2c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b2f:	85 d2                	test   %edx,%edx
80101b31:	74 3e                	je     80101b71 <dirlookup+0x61>
80101b33:	90                   	nop
80101b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101b38:	6a 10                	push   $0x10
80101b3a:	57                   	push   %edi
80101b3b:	56                   	push   %esi
80101b3c:	53                   	push   %ebx
80101b3d:	e8 7e fd ff ff       	call   801018c0 <readi>
80101b42:	83 c4 10             	add    $0x10,%esp
80101b45:	83 f8 10             	cmp    $0x10,%eax
80101b48:	75 55                	jne    80101b9f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101b4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101b4f:	74 18                	je     80101b69 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101b51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101b54:	83 ec 04             	sub    $0x4,%esp
80101b57:	6a 0e                	push   $0xe
80101b59:	50                   	push   %eax
80101b5a:	ff 75 0c             	pushl  0xc(%ebp)
80101b5d:	e8 5e 33 00 00       	call   80104ec0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101b62:	83 c4 10             	add    $0x10,%esp
80101b65:	85 c0                	test   %eax,%eax
80101b67:	74 17                	je     80101b80 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b69:	83 c7 10             	add    $0x10,%edi
80101b6c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101b6f:	72 c7                	jb     80101b38 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101b71:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101b74:	31 c0                	xor    %eax,%eax
}
80101b76:	5b                   	pop    %ebx
80101b77:	5e                   	pop    %esi
80101b78:	5f                   	pop    %edi
80101b79:	5d                   	pop    %ebp
80101b7a:	c3                   	ret    
80101b7b:	90                   	nop
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101b80:	8b 45 10             	mov    0x10(%ebp),%eax
80101b83:	85 c0                	test   %eax,%eax
80101b85:	74 05                	je     80101b8c <dirlookup+0x7c>
        *poff = off;
80101b87:	8b 45 10             	mov    0x10(%ebp),%eax
80101b8a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101b8c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101b90:	8b 03                	mov    (%ebx),%eax
80101b92:	e8 c9 f5 ff ff       	call   80101160 <iget>
}
80101b97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9a:	5b                   	pop    %ebx
80101b9b:	5e                   	pop    %esi
80101b9c:	5f                   	pop    %edi
80101b9d:	5d                   	pop    %ebp
80101b9e:	c3                   	ret    
      panic("dirlookup read");
80101b9f:	83 ec 0c             	sub    $0xc,%esp
80101ba2:	68 8f 88 10 80       	push   $0x8010888f
80101ba7:	e8 e4 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101bac:	83 ec 0c             	sub    $0xc,%esp
80101baf:	68 7d 88 10 80       	push   $0x8010887d
80101bb4:	e8 d7 e7 ff ff       	call   80100390 <panic>
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bc0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	89 cf                	mov    %ecx,%edi
80101bc8:	89 c3                	mov    %eax,%ebx
80101bca:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101bcd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101bd0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101bd3:	0f 84 77 01 00 00    	je     80101d50 <namex+0x190>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101bd9:	e8 e2 1b 00 00       	call   801037c0 <myproc>
  acquire(&icache.lock);
80101bde:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101be1:	8b b0 28 10 00 00    	mov    0x1028(%eax),%esi
  acquire(&icache.lock);
80101be7:	68 a0 2a 11 80       	push   $0x80112aa0
80101bec:	e8 9f 30 00 00       	call   80104c90 <acquire>
  ip->ref++;
80101bf1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101bf5:	c7 04 24 a0 2a 11 80 	movl   $0x80112aa0,(%esp)
80101bfc:	e8 4f 31 00 00       	call   80104d50 <release>
80101c01:	83 c4 10             	add    $0x10,%esp
80101c04:	eb 0d                	jmp    80101c13 <namex+0x53>
80101c06:	8d 76 00             	lea    0x0(%esi),%esi
80101c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101c10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101c13:	0f b6 03             	movzbl (%ebx),%eax
80101c16:	3c 2f                	cmp    $0x2f,%al
80101c18:	74 f6                	je     80101c10 <namex+0x50>
  if(*path == 0)
80101c1a:	84 c0                	test   %al,%al
80101c1c:	0f 84 f6 00 00 00    	je     80101d18 <namex+0x158>
  while(*path != '/' && *path != 0)
80101c22:	0f b6 03             	movzbl (%ebx),%eax
80101c25:	3c 2f                	cmp    $0x2f,%al
80101c27:	0f 84 bb 00 00 00    	je     80101ce8 <namex+0x128>
80101c2d:	84 c0                	test   %al,%al
80101c2f:	89 da                	mov    %ebx,%edx
80101c31:	75 11                	jne    80101c44 <namex+0x84>
80101c33:	e9 b0 00 00 00       	jmp    80101ce8 <namex+0x128>
80101c38:	90                   	nop
80101c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c40:	84 c0                	test   %al,%al
80101c42:	74 0a                	je     80101c4e <namex+0x8e>
    path++;
80101c44:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101c47:	0f b6 02             	movzbl (%edx),%eax
80101c4a:	3c 2f                	cmp    $0x2f,%al
80101c4c:	75 f2                	jne    80101c40 <namex+0x80>
80101c4e:	89 d1                	mov    %edx,%ecx
80101c50:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101c52:	83 f9 0d             	cmp    $0xd,%ecx
80101c55:	0f 8e 91 00 00 00    	jle    80101cec <namex+0x12c>
    memmove(name, s, DIRSIZ);
80101c5b:	83 ec 04             	sub    $0x4,%esp
80101c5e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101c61:	6a 0e                	push   $0xe
80101c63:	53                   	push   %ebx
80101c64:	57                   	push   %edi
80101c65:	e8 e6 31 00 00       	call   80104e50 <memmove>
    path++;
80101c6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101c6d:	83 c4 10             	add    $0x10,%esp
    path++;
80101c70:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101c72:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101c75:	75 11                	jne    80101c88 <namex+0xc8>
80101c77:	89 f6                	mov    %esi,%esi
80101c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101c80:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101c83:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101c86:	74 f8                	je     80101c80 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101c88:	83 ec 0c             	sub    $0xc,%esp
80101c8b:	56                   	push   %esi
80101c8c:	e8 3f f9 ff ff       	call   801015d0 <ilock>
    if(ip->type != T_DIR){
80101c91:	83 c4 10             	add    $0x10,%esp
80101c94:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101c99:	0f 85 91 00 00 00    	jne    80101d30 <namex+0x170>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101c9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ca2:	85 d2                	test   %edx,%edx
80101ca4:	74 09                	je     80101caf <namex+0xef>
80101ca6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ca9:	0f 84 b7 00 00 00    	je     80101d66 <namex+0x1a6>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101caf:	83 ec 04             	sub    $0x4,%esp
80101cb2:	6a 00                	push   $0x0
80101cb4:	57                   	push   %edi
80101cb5:	56                   	push   %esi
80101cb6:	e8 55 fe ff ff       	call   80101b10 <dirlookup>
80101cbb:	83 c4 10             	add    $0x10,%esp
80101cbe:	85 c0                	test   %eax,%eax
80101cc0:	74 6e                	je     80101d30 <namex+0x170>
  iunlock(ip);
80101cc2:	83 ec 0c             	sub    $0xc,%esp
80101cc5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101cc8:	56                   	push   %esi
80101cc9:	e8 e2 f9 ff ff       	call   801016b0 <iunlock>
  iput(ip);
80101cce:	89 34 24             	mov    %esi,(%esp)
80101cd1:	e8 2a fa ff ff       	call   80101700 <iput>
80101cd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cd9:	83 c4 10             	add    $0x10,%esp
80101cdc:	89 c6                	mov    %eax,%esi
80101cde:	e9 30 ff ff ff       	jmp    80101c13 <namex+0x53>
80101ce3:	90                   	nop
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ce8:	89 da                	mov    %ebx,%edx
80101cea:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101cec:	83 ec 04             	sub    $0x4,%esp
80101cef:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101cf2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101cf5:	51                   	push   %ecx
80101cf6:	53                   	push   %ebx
80101cf7:	57                   	push   %edi
80101cf8:	e8 53 31 00 00       	call   80104e50 <memmove>
    name[len] = 0;
80101cfd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d00:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d03:	83 c4 10             	add    $0x10,%esp
80101d06:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d0a:	89 d3                	mov    %edx,%ebx
80101d0c:	e9 61 ff ff ff       	jmp    80101c72 <namex+0xb2>
80101d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d1b:	85 c0                	test   %eax,%eax
80101d1d:	75 5d                	jne    80101d7c <namex+0x1bc>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d22:	89 f0                	mov    %esi,%eax
80101d24:	5b                   	pop    %ebx
80101d25:	5e                   	pop    %esi
80101d26:	5f                   	pop    %edi
80101d27:	5d                   	pop    %ebp
80101d28:	c3                   	ret    
80101d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101d30:	83 ec 0c             	sub    $0xc,%esp
80101d33:	56                   	push   %esi
80101d34:	e8 77 f9 ff ff       	call   801016b0 <iunlock>
  iput(ip);
80101d39:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101d3c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101d3e:	e8 bd f9 ff ff       	call   80101700 <iput>
      return 0;
80101d43:	83 c4 10             	add    $0x10,%esp
}
80101d46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d49:	89 f0                	mov    %esi,%eax
80101d4b:	5b                   	pop    %ebx
80101d4c:	5e                   	pop    %esi
80101d4d:	5f                   	pop    %edi
80101d4e:	5d                   	pop    %ebp
80101d4f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101d50:	ba 01 00 00 00       	mov    $0x1,%edx
80101d55:	b8 01 00 00 00       	mov    $0x1,%eax
80101d5a:	e8 01 f4 ff ff       	call   80101160 <iget>
80101d5f:	89 c6                	mov    %eax,%esi
80101d61:	e9 ad fe ff ff       	jmp    80101c13 <namex+0x53>
      iunlock(ip);
80101d66:	83 ec 0c             	sub    $0xc,%esp
80101d69:	56                   	push   %esi
80101d6a:	e8 41 f9 ff ff       	call   801016b0 <iunlock>
      return ip;
80101d6f:	83 c4 10             	add    $0x10,%esp
}
80101d72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d75:	89 f0                	mov    %esi,%eax
80101d77:	5b                   	pop    %ebx
80101d78:	5e                   	pop    %esi
80101d79:	5f                   	pop    %edi
80101d7a:	5d                   	pop    %ebp
80101d7b:	c3                   	ret    
    iput(ip);
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	56                   	push   %esi
    return 0;
80101d80:	31 f6                	xor    %esi,%esi
    iput(ip);
80101d82:	e8 79 f9 ff ff       	call   80101700 <iput>
    return 0;
80101d87:	83 c4 10             	add    $0x10,%esp
80101d8a:	eb 93                	jmp    80101d1f <namex+0x15f>
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d90 <dirlink>:
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	83 ec 20             	sub    $0x20,%esp
80101d99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101d9c:	6a 00                	push   $0x0
80101d9e:	ff 75 0c             	pushl  0xc(%ebp)
80101da1:	53                   	push   %ebx
80101da2:	e8 69 fd ff ff       	call   80101b10 <dirlookup>
80101da7:	83 c4 10             	add    $0x10,%esp
80101daa:	85 c0                	test   %eax,%eax
80101dac:	75 67                	jne    80101e15 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dae:	8b 7b 58             	mov    0x58(%ebx),%edi
80101db1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101db4:	85 ff                	test   %edi,%edi
80101db6:	74 29                	je     80101de1 <dirlink+0x51>
80101db8:	31 ff                	xor    %edi,%edi
80101dba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dbd:	eb 09                	jmp    80101dc8 <dirlink+0x38>
80101dbf:	90                   	nop
80101dc0:	83 c7 10             	add    $0x10,%edi
80101dc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101dc6:	73 19                	jae    80101de1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dc8:	6a 10                	push   $0x10
80101dca:	57                   	push   %edi
80101dcb:	56                   	push   %esi
80101dcc:	53                   	push   %ebx
80101dcd:	e8 ee fa ff ff       	call   801018c0 <readi>
80101dd2:	83 c4 10             	add    $0x10,%esp
80101dd5:	83 f8 10             	cmp    $0x10,%eax
80101dd8:	75 4e                	jne    80101e28 <dirlink+0x98>
    if(de.inum == 0)
80101dda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ddf:	75 df                	jne    80101dc0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101de1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101de4:	83 ec 04             	sub    $0x4,%esp
80101de7:	6a 0e                	push   $0xe
80101de9:	ff 75 0c             	pushl  0xc(%ebp)
80101dec:	50                   	push   %eax
80101ded:	e8 2e 31 00 00       	call   80104f20 <strncpy>
  de.inum = inum;
80101df2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101df5:	6a 10                	push   $0x10
80101df7:	57                   	push   %edi
80101df8:	56                   	push   %esi
80101df9:	53                   	push   %ebx
  de.inum = inum;
80101dfa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101dfe:	e8 bd fb ff ff       	call   801019c0 <writei>
80101e03:	83 c4 20             	add    $0x20,%esp
80101e06:	83 f8 10             	cmp    $0x10,%eax
80101e09:	75 2a                	jne    80101e35 <dirlink+0xa5>
  return 0;
80101e0b:	31 c0                	xor    %eax,%eax
}
80101e0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e10:	5b                   	pop    %ebx
80101e11:	5e                   	pop    %esi
80101e12:	5f                   	pop    %edi
80101e13:	5d                   	pop    %ebp
80101e14:	c3                   	ret    
    iput(ip);
80101e15:	83 ec 0c             	sub    $0xc,%esp
80101e18:	50                   	push   %eax
80101e19:	e8 e2 f8 ff ff       	call   80101700 <iput>
    return -1;
80101e1e:	83 c4 10             	add    $0x10,%esp
80101e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e26:	eb e5                	jmp    80101e0d <dirlink+0x7d>
      panic("dirlink read");
80101e28:	83 ec 0c             	sub    $0xc,%esp
80101e2b:	68 9e 88 10 80       	push   $0x8010889e
80101e30:	e8 5b e5 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101e35:	83 ec 0c             	sub    $0xc,%esp
80101e38:	68 1e 90 10 80       	push   $0x8010901e
80101e3d:	e8 4e e5 ff ff       	call   80100390 <panic>
80101e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e50 <namei>:

struct inode*
namei(char *path)
{
80101e50:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e51:	31 d2                	xor    %edx,%edx
{
80101e53:	89 e5                	mov    %esp,%ebp
80101e55:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101e58:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e5e:	e8 5d fd ff ff       	call   80101bc0 <namex>
}
80101e63:	c9                   	leave  
80101e64:	c3                   	ret    
80101e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e70 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101e70:	55                   	push   %ebp
  return namex(path, 1, name);
80101e71:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101e76:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101e78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101e7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101e7e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101e7f:	e9 3c fd ff ff       	jmp    80101bc0 <namex>
80101e84:	66 90                	xchg   %ax,%ax
80101e86:	66 90                	xchg   %ax,%ax
80101e88:	66 90                	xchg   %ax,%ax
80101e8a:	66 90                	xchg   %ax,%ax
80101e8c:	66 90                	xchg   %ax,%ax
80101e8e:	66 90                	xchg   %ax,%ax

80101e90 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101e90:	55                   	push   %ebp
80101e91:	89 e5                	mov    %esp,%ebp
80101e93:	57                   	push   %edi
80101e94:	56                   	push   %esi
80101e95:	53                   	push   %ebx
80101e96:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101e99:	85 c0                	test   %eax,%eax
80101e9b:	0f 84 b4 00 00 00    	je     80101f55 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101ea1:	8b 58 08             	mov    0x8(%eax),%ebx
80101ea4:	89 c6                	mov    %eax,%esi
80101ea6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101eac:	0f 87 96 00 00 00    	ja     80101f48 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101eb2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101eb7:	89 f6                	mov    %esi,%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101ec0:	89 ca                	mov    %ecx,%edx
80101ec2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ec3:	83 e0 c0             	and    $0xffffffc0,%eax
80101ec6:	3c 40                	cmp    $0x40,%al
80101ec8:	75 f6                	jne    80101ec0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101eca:	31 ff                	xor    %edi,%edi
80101ecc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101ed1:	89 f8                	mov    %edi,%eax
80101ed3:	ee                   	out    %al,(%dx)
80101ed4:	b8 01 00 00 00       	mov    $0x1,%eax
80101ed9:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101ede:	ee                   	out    %al,(%dx)
80101edf:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101ee4:	89 d8                	mov    %ebx,%eax
80101ee6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101ee7:	89 d8                	mov    %ebx,%eax
80101ee9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101eee:	c1 f8 08             	sar    $0x8,%eax
80101ef1:	ee                   	out    %al,(%dx)
80101ef2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101ef7:	89 f8                	mov    %edi,%eax
80101ef9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101efa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101efe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f03:	c1 e0 04             	shl    $0x4,%eax
80101f06:	83 e0 10             	and    $0x10,%eax
80101f09:	83 c8 e0             	or     $0xffffffe0,%eax
80101f0c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f0d:	f6 06 04             	testb  $0x4,(%esi)
80101f10:	75 16                	jne    80101f28 <idestart+0x98>
80101f12:	b8 20 00 00 00       	mov    $0x20,%eax
80101f17:	89 ca                	mov    %ecx,%edx
80101f19:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f1d:	5b                   	pop    %ebx
80101f1e:	5e                   	pop    %esi
80101f1f:	5f                   	pop    %edi
80101f20:	5d                   	pop    %ebp
80101f21:	c3                   	ret    
80101f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f28:	b8 30 00 00 00       	mov    $0x30,%eax
80101f2d:	89 ca                	mov    %ecx,%edx
80101f2f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101f30:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101f35:	83 c6 5c             	add    $0x5c,%esi
80101f38:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101f3d:	fc                   	cld    
80101f3e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f43:	5b                   	pop    %ebx
80101f44:	5e                   	pop    %esi
80101f45:	5f                   	pop    %edi
80101f46:	5d                   	pop    %ebp
80101f47:	c3                   	ret    
    panic("incorrect blockno");
80101f48:	83 ec 0c             	sub    $0xc,%esp
80101f4b:	68 08 89 10 80       	push   $0x80108908
80101f50:	e8 3b e4 ff ff       	call   80100390 <panic>
    panic("idestart");
80101f55:	83 ec 0c             	sub    $0xc,%esp
80101f58:	68 ff 88 10 80       	push   $0x801088ff
80101f5d:	e8 2e e4 ff ff       	call   80100390 <panic>
80101f62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f70 <ideinit>:
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101f76:	68 1a 89 10 80       	push   $0x8010891a
80101f7b:	68 80 c5 10 80       	push   $0x8010c580
80101f80:	e8 cb 2b 00 00       	call   80104b50 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101f85:	58                   	pop    %eax
80101f86:	a1 60 4f 11 80       	mov    0x80114f60,%eax
80101f8b:	5a                   	pop    %edx
80101f8c:	83 e8 01             	sub    $0x1,%eax
80101f8f:	50                   	push   %eax
80101f90:	6a 0e                	push   $0xe
80101f92:	e8 a9 02 00 00       	call   80102240 <ioapicenable>
80101f97:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f9a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f9f:	90                   	nop
80101fa0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fa1:	83 e0 c0             	and    $0xffffffc0,%eax
80101fa4:	3c 40                	cmp    $0x40,%al
80101fa6:	75 f8                	jne    80101fa0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fa8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101fad:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb2:	ee                   	out    %al,(%dx)
80101fb3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fb8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fbd:	eb 06                	jmp    80101fc5 <ideinit+0x55>
80101fbf:	90                   	nop
  for(i=0; i<1000; i++){
80101fc0:	83 e9 01             	sub    $0x1,%ecx
80101fc3:	74 0f                	je     80101fd4 <ideinit+0x64>
80101fc5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101fc6:	84 c0                	test   %al,%al
80101fc8:	74 f6                	je     80101fc0 <ideinit+0x50>
      havedisk1 = 1;
80101fca:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80101fd1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fd4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80101fd9:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fde:	ee                   	out    %al,(%dx)
}
80101fdf:	c9                   	leave  
80101fe0:	c3                   	ret    
80101fe1:	eb 0d                	jmp    80101ff0 <ideintr>
80101fe3:	90                   	nop
80101fe4:	90                   	nop
80101fe5:	90                   	nop
80101fe6:	90                   	nop
80101fe7:	90                   	nop
80101fe8:	90                   	nop
80101fe9:	90                   	nop
80101fea:	90                   	nop
80101feb:	90                   	nop
80101fec:	90                   	nop
80101fed:	90                   	nop
80101fee:	90                   	nop
80101fef:	90                   	nop

80101ff0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101ff9:	68 80 c5 10 80       	push   $0x8010c580
80101ffe:	e8 8d 2c 00 00       	call   80104c90 <acquire>

  if((b = idequeue) == 0){
80102003:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102009:	83 c4 10             	add    $0x10,%esp
8010200c:	85 db                	test   %ebx,%ebx
8010200e:	74 67                	je     80102077 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102010:	8b 43 58             	mov    0x58(%ebx),%eax
80102013:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102018:	8b 3b                	mov    (%ebx),%edi
8010201a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102020:	75 31                	jne    80102053 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102022:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102031:	89 c6                	mov    %eax,%esi
80102033:	83 e6 c0             	and    $0xffffffc0,%esi
80102036:	89 f1                	mov    %esi,%ecx
80102038:	80 f9 40             	cmp    $0x40,%cl
8010203b:	75 f3                	jne    80102030 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010203d:	a8 21                	test   $0x21,%al
8010203f:	75 12                	jne    80102053 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102041:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102044:	b9 80 00 00 00       	mov    $0x80,%ecx
80102049:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010204e:	fc                   	cld    
8010204f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102051:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102053:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102056:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102059:	89 f9                	mov    %edi,%ecx
8010205b:	83 c9 02             	or     $0x2,%ecx
8010205e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102060:	53                   	push   %ebx
80102061:	e8 5a 1f 00 00       	call   80103fc0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102066:	a1 64 c5 10 80       	mov    0x8010c564,%eax
8010206b:	83 c4 10             	add    $0x10,%esp
8010206e:	85 c0                	test   %eax,%eax
80102070:	74 05                	je     80102077 <ideintr+0x87>
    idestart(idequeue);
80102072:	e8 19 fe ff ff       	call   80101e90 <idestart>
    release(&idelock);
80102077:	83 ec 0c             	sub    $0xc,%esp
8010207a:	68 80 c5 10 80       	push   $0x8010c580
8010207f:	e8 cc 2c 00 00       	call   80104d50 <release>

  release(&idelock);
}
80102084:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102087:	5b                   	pop    %ebx
80102088:	5e                   	pop    %esi
80102089:	5f                   	pop    %edi
8010208a:	5d                   	pop    %ebp
8010208b:	c3                   	ret    
8010208c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102090 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	53                   	push   %ebx
80102094:	83 ec 10             	sub    $0x10,%esp
80102097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010209a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010209d:	50                   	push   %eax
8010209e:	e8 5d 2a 00 00       	call   80104b00 <holdingsleep>
801020a3:	83 c4 10             	add    $0x10,%esp
801020a6:	85 c0                	test   %eax,%eax
801020a8:	0f 84 c6 00 00 00    	je     80102174 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020ae:	8b 03                	mov    (%ebx),%eax
801020b0:	83 e0 06             	and    $0x6,%eax
801020b3:	83 f8 02             	cmp    $0x2,%eax
801020b6:	0f 84 ab 00 00 00    	je     80102167 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801020bc:	8b 53 04             	mov    0x4(%ebx),%edx
801020bf:	85 d2                	test   %edx,%edx
801020c1:	74 0d                	je     801020d0 <iderw+0x40>
801020c3:	a1 60 c5 10 80       	mov    0x8010c560,%eax
801020c8:	85 c0                	test   %eax,%eax
801020ca:	0f 84 b1 00 00 00    	je     80102181 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801020d0:	83 ec 0c             	sub    $0xc,%esp
801020d3:	68 80 c5 10 80       	push   $0x8010c580
801020d8:	e8 b3 2b 00 00       	call   80104c90 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020dd:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
801020e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801020e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020ed:	85 d2                	test   %edx,%edx
801020ef:	75 09                	jne    801020fa <iderw+0x6a>
801020f1:	eb 6d                	jmp    80102160 <iderw+0xd0>
801020f3:	90                   	nop
801020f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020f8:	89 c2                	mov    %eax,%edx
801020fa:	8b 42 58             	mov    0x58(%edx),%eax
801020fd:	85 c0                	test   %eax,%eax
801020ff:	75 f7                	jne    801020f8 <iderw+0x68>
80102101:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102104:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102106:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
8010210c:	74 42                	je     80102150 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010210e:	8b 03                	mov    (%ebx),%eax
80102110:	83 e0 06             	and    $0x6,%eax
80102113:	83 f8 02             	cmp    $0x2,%eax
80102116:	74 23                	je     8010213b <iderw+0xab>
80102118:	90                   	nop
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102120:	83 ec 08             	sub    $0x8,%esp
80102123:	68 80 c5 10 80       	push   $0x8010c580
80102128:	53                   	push   %ebx
80102129:	e8 d2 1c 00 00       	call   80103e00 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010212e:	8b 03                	mov    (%ebx),%eax
80102130:	83 c4 10             	add    $0x10,%esp
80102133:	83 e0 06             	and    $0x6,%eax
80102136:	83 f8 02             	cmp    $0x2,%eax
80102139:	75 e5                	jne    80102120 <iderw+0x90>
  }


  release(&idelock);
8010213b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102145:	c9                   	leave  
  release(&idelock);
80102146:	e9 05 2c 00 00       	jmp    80104d50 <release>
8010214b:	90                   	nop
8010214c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102150:	89 d8                	mov    %ebx,%eax
80102152:	e8 39 fd ff ff       	call   80101e90 <idestart>
80102157:	eb b5                	jmp    8010210e <iderw+0x7e>
80102159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102160:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102165:	eb 9d                	jmp    80102104 <iderw+0x74>
    panic("iderw: nothing to do");
80102167:	83 ec 0c             	sub    $0xc,%esp
8010216a:	68 34 89 10 80       	push   $0x80108934
8010216f:	e8 1c e2 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102174:	83 ec 0c             	sub    $0xc,%esp
80102177:	68 1e 89 10 80       	push   $0x8010891e
8010217c:	e8 0f e2 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102181:	83 ec 0c             	sub    $0xc,%esp
80102184:	68 49 89 10 80       	push   $0x80108949
80102189:	e8 02 e2 ff ff       	call   80100390 <panic>
8010218e:	66 90                	xchg   %ax,%ax

80102190 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102190:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102191:	c7 05 84 48 11 80 00 	movl   $0xfec00000,0x80114884
80102198:	00 c0 fe 
{
8010219b:	89 e5                	mov    %esp,%ebp
8010219d:	56                   	push   %esi
8010219e:	53                   	push   %ebx
  ioapic->reg = reg;
8010219f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021a6:	00 00 00 
  return ioapic->data;
801021a9:	a1 84 48 11 80       	mov    0x80114884,%eax
801021ae:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801021b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801021b7:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801021bd:	0f b6 15 c0 49 11 80 	movzbl 0x801149c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801021c4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801021c7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801021ca:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801021cd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801021d0:	39 c2                	cmp    %eax,%edx
801021d2:	74 16                	je     801021ea <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801021d4:	83 ec 0c             	sub    $0xc,%esp
801021d7:	68 68 89 10 80       	push   $0x80108968
801021dc:	e8 7f e4 ff ff       	call   80100660 <cprintf>
801021e1:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx
801021e7:	83 c4 10             	add    $0x10,%esp
801021ea:	83 c3 21             	add    $0x21,%ebx
{
801021ed:	ba 10 00 00 00       	mov    $0x10,%edx
801021f2:	b8 20 00 00 00       	mov    $0x20,%eax
801021f7:	89 f6                	mov    %esi,%esi
801021f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102200:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102202:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102208:	89 c6                	mov    %eax,%esi
8010220a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102210:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102213:	89 71 10             	mov    %esi,0x10(%ecx)
80102216:	8d 72 01             	lea    0x1(%edx),%esi
80102219:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010221c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010221e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102220:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx
80102226:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010222d:	75 d1                	jne    80102200 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010222f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102232:	5b                   	pop    %ebx
80102233:	5e                   	pop    %esi
80102234:	5d                   	pop    %ebp
80102235:	c3                   	ret    
80102236:	8d 76 00             	lea    0x0(%esi),%esi
80102239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102240 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102240:	55                   	push   %ebp
  ioapic->reg = reg;
80102241:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx
{
80102247:	89 e5                	mov    %esp,%ebp
80102249:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010224c:	8d 50 20             	lea    0x20(%eax),%edx
8010224f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102253:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102255:	8b 0d 84 48 11 80    	mov    0x80114884,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010225b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010225e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102261:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102264:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102266:	a1 84 48 11 80       	mov    0x80114884,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010226b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010226e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102271:	5d                   	pop    %ebp
80102272:	c3                   	ret    
80102273:	66 90                	xchg   %ax,%ax
80102275:	66 90                	xchg   %ax,%ax
80102277:	66 90                	xchg   %ax,%ax
80102279:	66 90                	xchg   %ax,%ax
8010227b:	66 90                	xchg   %ax,%ax
8010227d:	66 90                	xchg   %ax,%ax
8010227f:	90                   	nop

80102280 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	53                   	push   %ebx
80102284:	83 ec 04             	sub    $0x4,%esp
80102287:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010228a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102290:	75 70                	jne    80102302 <kfree+0x82>
80102292:	81 fb 68 88 1d 80    	cmp    $0x801d8868,%ebx
80102298:	72 68                	jb     80102302 <kfree+0x82>
8010229a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022a5:	77 5b                	ja     80102302 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022a7:	83 ec 04             	sub    $0x4,%esp
801022aa:	68 00 10 00 00       	push   $0x1000
801022af:	6a 01                	push   $0x1
801022b1:	53                   	push   %ebx
801022b2:	e8 e9 2a 00 00       	call   80104da0 <memset>

  if(kmem.use_lock)
801022b7:	8b 15 d4 48 11 80    	mov    0x801148d4,%edx
801022bd:	83 c4 10             	add    $0x10,%esp
801022c0:	85 d2                	test   %edx,%edx
801022c2:	75 2c                	jne    801022f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801022c4:	a1 d8 48 11 80       	mov    0x801148d8,%eax
801022c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801022cb:	a1 d4 48 11 80       	mov    0x801148d4,%eax
  kmem.freelist = r;
801022d0:	89 1d d8 48 11 80    	mov    %ebx,0x801148d8
  if(kmem.use_lock)
801022d6:	85 c0                	test   %eax,%eax
801022d8:	75 06                	jne    801022e0 <kfree+0x60>
    release(&kmem.lock);
}
801022da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022dd:	c9                   	leave  
801022de:	c3                   	ret    
801022df:	90                   	nop
    release(&kmem.lock);
801022e0:	c7 45 08 a0 48 11 80 	movl   $0x801148a0,0x8(%ebp)
}
801022e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022ea:	c9                   	leave  
    release(&kmem.lock);
801022eb:	e9 60 2a 00 00       	jmp    80104d50 <release>
    acquire(&kmem.lock);
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 a0 48 11 80       	push   $0x801148a0
801022f8:	e8 93 29 00 00       	call   80104c90 <acquire>
801022fd:	83 c4 10             	add    $0x10,%esp
80102300:	eb c2                	jmp    801022c4 <kfree+0x44>
    panic("kfree");
80102302:	83 ec 0c             	sub    $0xc,%esp
80102305:	68 9a 89 10 80       	push   $0x8010899a
8010230a:	e8 81 e0 ff ff       	call   80100390 <panic>
8010230f:	90                   	nop

80102310 <freerange>:
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	56                   	push   %esi
80102314:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102315:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102318:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010231b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102321:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102327:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010232d:	39 de                	cmp    %ebx,%esi
8010232f:	72 23                	jb     80102354 <freerange+0x44>
80102331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102338:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010233e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102341:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102347:	50                   	push   %eax
80102348:	e8 33 ff ff ff       	call   80102280 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	39 f3                	cmp    %esi,%ebx
80102352:	76 e4                	jbe    80102338 <freerange+0x28>
}
80102354:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102357:	5b                   	pop    %ebx
80102358:	5e                   	pop    %esi
80102359:	5d                   	pop    %ebp
8010235a:	c3                   	ret    
8010235b:	90                   	nop
8010235c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102360 <kinit1>:
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
80102365:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102368:	83 ec 08             	sub    $0x8,%esp
8010236b:	68 a0 89 10 80       	push   $0x801089a0
80102370:	68 a0 48 11 80       	push   $0x801148a0
80102375:	e8 d6 27 00 00       	call   80104b50 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010237a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010237d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102380:	c7 05 d4 48 11 80 00 	movl   $0x0,0x801148d4
80102387:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010238a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102390:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102396:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010239c:	39 de                	cmp    %ebx,%esi
8010239e:	72 1c                	jb     801023bc <kinit1+0x5c>
    kfree(p);
801023a0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023a6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023af:	50                   	push   %eax
801023b0:	e8 cb fe ff ff       	call   80102280 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023b5:	83 c4 10             	add    $0x10,%esp
801023b8:	39 de                	cmp    %ebx,%esi
801023ba:	73 e4                	jae    801023a0 <kinit1+0x40>
}
801023bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023bf:	5b                   	pop    %ebx
801023c0:	5e                   	pop    %esi
801023c1:	5d                   	pop    %ebp
801023c2:	c3                   	ret    
801023c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023d0 <kinit2>:
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <kinit2+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102407:	50                   	push   %eax
80102408:	e8 73 fe ff ff       	call   80102280 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 de                	cmp    %ebx,%esi
80102412:	73 e4                	jae    801023f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102414:	c7 05 d4 48 11 80 01 	movl   $0x1,0x801148d4
8010241b:	00 00 00 
}
8010241e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102421:	5b                   	pop    %ebx
80102422:	5e                   	pop    %esi
80102423:	5d                   	pop    %ebp
80102424:	c3                   	ret    
80102425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102430:	a1 d4 48 11 80       	mov    0x801148d4,%eax
80102435:	85 c0                	test   %eax,%eax
80102437:	75 1f                	jne    80102458 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102439:	a1 d8 48 11 80       	mov    0x801148d8,%eax
  if(r)
8010243e:	85 c0                	test   %eax,%eax
80102440:	74 0e                	je     80102450 <kalloc+0x20>
    kmem.freelist = r->next;
80102442:	8b 10                	mov    (%eax),%edx
80102444:	89 15 d8 48 11 80    	mov    %edx,0x801148d8
8010244a:	c3                   	ret    
8010244b:	90                   	nop
8010244c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102450:	f3 c3                	repz ret 
80102452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102458:	55                   	push   %ebp
80102459:	89 e5                	mov    %esp,%ebp
8010245b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010245e:	68 a0 48 11 80       	push   $0x801148a0
80102463:	e8 28 28 00 00       	call   80104c90 <acquire>
  r = kmem.freelist;
80102468:	a1 d8 48 11 80       	mov    0x801148d8,%eax
  if(r)
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	8b 15 d4 48 11 80    	mov    0x801148d4,%edx
80102476:	85 c0                	test   %eax,%eax
80102478:	74 08                	je     80102482 <kalloc+0x52>
    kmem.freelist = r->next;
8010247a:	8b 08                	mov    (%eax),%ecx
8010247c:	89 0d d8 48 11 80    	mov    %ecx,0x801148d8
  if(kmem.use_lock)
80102482:	85 d2                	test   %edx,%edx
80102484:	74 16                	je     8010249c <kalloc+0x6c>
    release(&kmem.lock);
80102486:	83 ec 0c             	sub    $0xc,%esp
80102489:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010248c:	68 a0 48 11 80       	push   $0x801148a0
80102491:	e8 ba 28 00 00       	call   80104d50 <release>
  return (char*)r;
80102496:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102499:	83 c4 10             	add    $0x10,%esp
}
8010249c:	c9                   	leave  
8010249d:	c3                   	ret    
8010249e:	66 90                	xchg   %ax,%ax

801024a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024a0:	ba 64 00 00 00       	mov    $0x64,%edx
801024a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024a6:	a8 01                	test   $0x1,%al
801024a8:	0f 84 c2 00 00 00    	je     80102570 <kbdgetc+0xd0>
801024ae:	ba 60 00 00 00       	mov    $0x60,%edx
801024b3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801024b4:	0f b6 d0             	movzbl %al,%edx
801024b7:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
801024bd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801024c3:	0f 84 7f 00 00 00    	je     80102548 <kbdgetc+0xa8>
{
801024c9:	55                   	push   %ebp
801024ca:	89 e5                	mov    %esp,%ebp
801024cc:	53                   	push   %ebx
801024cd:	89 cb                	mov    %ecx,%ebx
801024cf:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801024d2:	84 c0                	test   %al,%al
801024d4:	78 4a                	js     80102520 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801024d6:	85 db                	test   %ebx,%ebx
801024d8:	74 09                	je     801024e3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801024da:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801024dd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801024e0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801024e3:	0f b6 82 e0 8a 10 80 	movzbl -0x7fef7520(%edx),%eax
801024ea:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801024ec:	0f b6 82 e0 89 10 80 	movzbl -0x7fef7620(%edx),%eax
801024f3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801024f5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801024f7:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801024fd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102500:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102503:	8b 04 85 c0 89 10 80 	mov    -0x7fef7640(,%eax,4),%eax
8010250a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010250e:	74 31                	je     80102541 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102510:	8d 50 9f             	lea    -0x61(%eax),%edx
80102513:	83 fa 19             	cmp    $0x19,%edx
80102516:	77 40                	ja     80102558 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102518:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010251b:	5b                   	pop    %ebx
8010251c:	5d                   	pop    %ebp
8010251d:	c3                   	ret    
8010251e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102520:	83 e0 7f             	and    $0x7f,%eax
80102523:	85 db                	test   %ebx,%ebx
80102525:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102528:	0f b6 82 e0 8a 10 80 	movzbl -0x7fef7520(%edx),%eax
8010252f:	83 c8 40             	or     $0x40,%eax
80102532:	0f b6 c0             	movzbl %al,%eax
80102535:	f7 d0                	not    %eax
80102537:	21 c1                	and    %eax,%ecx
    return 0;
80102539:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010253b:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102541:	5b                   	pop    %ebx
80102542:	5d                   	pop    %ebp
80102543:	c3                   	ret    
80102544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102548:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010254b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010254d:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102553:	c3                   	ret    
80102554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102558:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010255b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010255e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010255f:	83 f9 1a             	cmp    $0x1a,%ecx
80102562:	0f 42 c2             	cmovb  %edx,%eax
}
80102565:	5d                   	pop    %ebp
80102566:	c3                   	ret    
80102567:	89 f6                	mov    %esi,%esi
80102569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102575:	c3                   	ret    
80102576:	8d 76 00             	lea    0x0(%esi),%esi
80102579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102580 <kbdintr>:

void
kbdintr(void)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102586:	68 a0 24 10 80       	push   $0x801024a0
8010258b:	e8 80 e2 ff ff       	call   80100810 <consoleintr>
}
80102590:	83 c4 10             	add    $0x10,%esp
80102593:	c9                   	leave  
80102594:	c3                   	ret    
80102595:	66 90                	xchg   %ax,%ax
80102597:	66 90                	xchg   %ax,%ax
80102599:	66 90                	xchg   %ax,%ax
8010259b:	66 90                	xchg   %ax,%ax
8010259d:	66 90                	xchg   %ax,%ax
8010259f:	90                   	nop

801025a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801025a0:	a1 dc 48 11 80       	mov    0x801148dc,%eax
{
801025a5:	55                   	push   %ebp
801025a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025a8:	85 c0                	test   %eax,%eax
801025aa:	0f 84 c8 00 00 00    	je     80102678 <lapicinit+0xd8>
  lapic[index] = value;
801025b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801025c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801025d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801025d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801025de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801025e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801025eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801025f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801025fe:	8b 50 30             	mov    0x30(%eax),%edx
80102601:	c1 ea 10             	shr    $0x10,%edx
80102604:	80 fa 03             	cmp    $0x3,%dl
80102607:	77 77                	ja     80102680 <lapicinit+0xe0>
  lapic[index] = value;
80102609:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102610:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102613:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102616:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010261d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102620:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102623:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010262a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010262d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102630:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102637:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010263a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010263d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102644:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102647:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010264a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102651:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102654:	8b 50 20             	mov    0x20(%eax),%edx
80102657:	89 f6                	mov    %esi,%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102660:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102666:	80 e6 10             	and    $0x10,%dh
80102669:	75 f5                	jne    80102660 <lapicinit+0xc0>
  lapic[index] = value;
8010266b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102672:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102675:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102678:	5d                   	pop    %ebp
80102679:	c3                   	ret    
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102680:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102687:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
8010268d:	e9 77 ff ff ff       	jmp    80102609 <lapicinit+0x69>
80102692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801026a0:	8b 15 dc 48 11 80    	mov    0x801148dc,%edx
{
801026a6:	55                   	push   %ebp
801026a7:	31 c0                	xor    %eax,%eax
801026a9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801026ab:	85 d2                	test   %edx,%edx
801026ad:	74 06                	je     801026b5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
801026af:	8b 42 20             	mov    0x20(%edx),%eax
801026b2:	c1 e8 18             	shr    $0x18,%eax
}
801026b5:	5d                   	pop    %ebp
801026b6:	c3                   	ret    
801026b7:	89 f6                	mov    %esi,%esi
801026b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801026c0:	a1 dc 48 11 80       	mov    0x801148dc,%eax
{
801026c5:	55                   	push   %ebp
801026c6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801026c8:	85 c0                	test   %eax,%eax
801026ca:	74 0d                	je     801026d9 <lapiceoi+0x19>
  lapic[index] = value;
801026cc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801026d9:	5d                   	pop    %ebp
801026da:	c3                   	ret    
801026db:	90                   	nop
801026dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026e0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
}
801026e3:	5d                   	pop    %ebp
801026e4:	c3                   	ret    
801026e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026f0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801026f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801026f6:	ba 70 00 00 00       	mov    $0x70,%edx
801026fb:	89 e5                	mov    %esp,%ebp
801026fd:	53                   	push   %ebx
801026fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102701:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102704:	ee                   	out    %al,(%dx)
80102705:	b8 0a 00 00 00       	mov    $0xa,%eax
8010270a:	ba 71 00 00 00       	mov    $0x71,%edx
8010270f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102710:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102712:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102715:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010271b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010271d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102720:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102723:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102725:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102728:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010272e:	a1 dc 48 11 80       	mov    0x801148dc,%eax
80102733:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102739:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010273c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102743:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102746:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102749:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102750:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102753:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102756:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010275c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010275f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102765:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102768:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010276e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102771:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102777:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010277a:	5b                   	pop    %ebx
8010277b:	5d                   	pop    %ebp
8010277c:	c3                   	ret    
8010277d:	8d 76 00             	lea    0x0(%esi),%esi

80102780 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102780:	55                   	push   %ebp
80102781:	b8 0b 00 00 00       	mov    $0xb,%eax
80102786:	ba 70 00 00 00       	mov    $0x70,%edx
8010278b:	89 e5                	mov    %esp,%ebp
8010278d:	57                   	push   %edi
8010278e:	56                   	push   %esi
8010278f:	53                   	push   %ebx
80102790:	83 ec 4c             	sub    $0x4c,%esp
80102793:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102794:	ba 71 00 00 00       	mov    $0x71,%edx
80102799:	ec                   	in     (%dx),%al
8010279a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010279d:	bb 70 00 00 00       	mov    $0x70,%ebx
801027a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801027a5:	8d 76 00             	lea    0x0(%esi),%esi
801027a8:	31 c0                	xor    %eax,%eax
801027aa:	89 da                	mov    %ebx,%edx
801027ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801027b2:	89 ca                	mov    %ecx,%edx
801027b4:	ec                   	in     (%dx),%al
801027b5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b8:	89 da                	mov    %ebx,%edx
801027ba:	b8 02 00 00 00       	mov    $0x2,%eax
801027bf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027c0:	89 ca                	mov    %ecx,%edx
801027c2:	ec                   	in     (%dx),%al
801027c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027c6:	89 da                	mov    %ebx,%edx
801027c8:	b8 04 00 00 00       	mov    $0x4,%eax
801027cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027ce:	89 ca                	mov    %ecx,%edx
801027d0:	ec                   	in     (%dx),%al
801027d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027d4:	89 da                	mov    %ebx,%edx
801027d6:	b8 07 00 00 00       	mov    $0x7,%eax
801027db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027dc:	89 ca                	mov    %ecx,%edx
801027de:	ec                   	in     (%dx),%al
801027df:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027e2:	89 da                	mov    %ebx,%edx
801027e4:	b8 08 00 00 00       	mov    $0x8,%eax
801027e9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027ea:	89 ca                	mov    %ecx,%edx
801027ec:	ec                   	in     (%dx),%al
801027ed:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027ef:	89 da                	mov    %ebx,%edx
801027f1:	b8 09 00 00 00       	mov    $0x9,%eax
801027f6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f7:	89 ca                	mov    %ecx,%edx
801027f9:	ec                   	in     (%dx),%al
801027fa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027fc:	89 da                	mov    %ebx,%edx
801027fe:	b8 0a 00 00 00       	mov    $0xa,%eax
80102803:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102804:	89 ca                	mov    %ecx,%edx
80102806:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102807:	84 c0                	test   %al,%al
80102809:	78 9d                	js     801027a8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010280b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010280f:	89 fa                	mov    %edi,%edx
80102811:	0f b6 fa             	movzbl %dl,%edi
80102814:	89 f2                	mov    %esi,%edx
80102816:	0f b6 f2             	movzbl %dl,%esi
80102819:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010281c:	89 da                	mov    %ebx,%edx
8010281e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102821:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102824:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102828:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010282b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010282f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102832:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102836:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102839:	31 c0                	xor    %eax,%eax
8010283b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283c:	89 ca                	mov    %ecx,%edx
8010283e:	ec                   	in     (%dx),%al
8010283f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102842:	89 da                	mov    %ebx,%edx
80102844:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102847:	b8 02 00 00 00       	mov    $0x2,%eax
8010284c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284d:	89 ca                	mov    %ecx,%edx
8010284f:	ec                   	in     (%dx),%al
80102850:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102853:	89 da                	mov    %ebx,%edx
80102855:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102858:	b8 04 00 00 00       	mov    $0x4,%eax
8010285d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285e:	89 ca                	mov    %ecx,%edx
80102860:	ec                   	in     (%dx),%al
80102861:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102864:	89 da                	mov    %ebx,%edx
80102866:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102869:	b8 07 00 00 00       	mov    $0x7,%eax
8010286e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286f:	89 ca                	mov    %ecx,%edx
80102871:	ec                   	in     (%dx),%al
80102872:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102875:	89 da                	mov    %ebx,%edx
80102877:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010287a:	b8 08 00 00 00       	mov    $0x8,%eax
8010287f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102880:	89 ca                	mov    %ecx,%edx
80102882:	ec                   	in     (%dx),%al
80102883:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102886:	89 da                	mov    %ebx,%edx
80102888:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010288b:	b8 09 00 00 00       	mov    $0x9,%eax
80102890:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102891:	89 ca                	mov    %ecx,%edx
80102893:	ec                   	in     (%dx),%al
80102894:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102897:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010289a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010289d:	8d 45 d0             	lea    -0x30(%ebp),%eax
801028a0:	6a 18                	push   $0x18
801028a2:	50                   	push   %eax
801028a3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801028a6:	50                   	push   %eax
801028a7:	e8 44 25 00 00       	call   80104df0 <memcmp>
801028ac:	83 c4 10             	add    $0x10,%esp
801028af:	85 c0                	test   %eax,%eax
801028b1:	0f 85 f1 fe ff ff    	jne    801027a8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801028b7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801028bb:	75 78                	jne    80102935 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028bd:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028c0:	89 c2                	mov    %eax,%edx
801028c2:	83 e0 0f             	and    $0xf,%eax
801028c5:	c1 ea 04             	shr    $0x4,%edx
801028c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028d1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028d4:	89 c2                	mov    %eax,%edx
801028d6:	83 e0 0f             	and    $0xf,%eax
801028d9:	c1 ea 04             	shr    $0x4,%edx
801028dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028e2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801028e5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801028e8:	89 c2                	mov    %eax,%edx
801028ea:	83 e0 0f             	and    $0xf,%eax
801028ed:	c1 ea 04             	shr    $0x4,%edx
801028f0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028f6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801028f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801028fc:	89 c2                	mov    %eax,%edx
801028fe:	83 e0 0f             	and    $0xf,%eax
80102901:	c1 ea 04             	shr    $0x4,%edx
80102904:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102907:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010290d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102910:	89 c2                	mov    %eax,%edx
80102912:	83 e0 0f             	and    $0xf,%eax
80102915:	c1 ea 04             	shr    $0x4,%edx
80102918:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010291b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010291e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102921:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102924:	89 c2                	mov    %eax,%edx
80102926:	83 e0 0f             	and    $0xf,%eax
80102929:	c1 ea 04             	shr    $0x4,%edx
8010292c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010292f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102932:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102935:	8b 75 08             	mov    0x8(%ebp),%esi
80102938:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010293b:	89 06                	mov    %eax,(%esi)
8010293d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102940:	89 46 04             	mov    %eax,0x4(%esi)
80102943:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102946:	89 46 08             	mov    %eax,0x8(%esi)
80102949:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010294c:	89 46 0c             	mov    %eax,0xc(%esi)
8010294f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102952:	89 46 10             	mov    %eax,0x10(%esi)
80102955:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102958:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010295b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102962:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102965:	5b                   	pop    %ebx
80102966:	5e                   	pop    %esi
80102967:	5f                   	pop    %edi
80102968:	5d                   	pop    %ebp
80102969:	c3                   	ret    
8010296a:	66 90                	xchg   %ax,%ax
8010296c:	66 90                	xchg   %ax,%ax
8010296e:	66 90                	xchg   %ax,%ax

80102970 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102970:	8b 0d 28 49 11 80    	mov    0x80114928,%ecx
80102976:	85 c9                	test   %ecx,%ecx
80102978:	0f 8e 8a 00 00 00    	jle    80102a08 <install_trans+0x98>
{
8010297e:	55                   	push   %ebp
8010297f:	89 e5                	mov    %esp,%ebp
80102981:	57                   	push   %edi
80102982:	56                   	push   %esi
80102983:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102984:	31 db                	xor    %ebx,%ebx
{
80102986:	83 ec 0c             	sub    $0xc,%esp
80102989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102990:	a1 14 49 11 80       	mov    0x80114914,%eax
80102995:	83 ec 08             	sub    $0x8,%esp
80102998:	01 d8                	add    %ebx,%eax
8010299a:	83 c0 01             	add    $0x1,%eax
8010299d:	50                   	push   %eax
8010299e:	ff 35 24 49 11 80    	pushl  0x80114924
801029a4:	e8 27 d7 ff ff       	call   801000d0 <bread>
801029a9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029ab:	58                   	pop    %eax
801029ac:	5a                   	pop    %edx
801029ad:	ff 34 9d 2c 49 11 80 	pushl  -0x7feeb6d4(,%ebx,4)
801029b4:	ff 35 24 49 11 80    	pushl  0x80114924
  for (tail = 0; tail < log.lh.n; tail++) {
801029ba:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029bd:	e8 0e d7 ff ff       	call   801000d0 <bread>
801029c2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029c4:	8d 47 5c             	lea    0x5c(%edi),%eax
801029c7:	83 c4 0c             	add    $0xc,%esp
801029ca:	68 00 02 00 00       	push   $0x200
801029cf:	50                   	push   %eax
801029d0:	8d 46 5c             	lea    0x5c(%esi),%eax
801029d3:	50                   	push   %eax
801029d4:	e8 77 24 00 00       	call   80104e50 <memmove>
    bwrite(dbuf);  // write dst to disk
801029d9:	89 34 24             	mov    %esi,(%esp)
801029dc:	e8 bf d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
801029e1:	89 3c 24             	mov    %edi,(%esp)
801029e4:	e8 f7 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
801029e9:	89 34 24             	mov    %esi,(%esp)
801029ec:	e8 ef d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801029f1:	83 c4 10             	add    $0x10,%esp
801029f4:	39 1d 28 49 11 80    	cmp    %ebx,0x80114928
801029fa:	7f 94                	jg     80102990 <install_trans+0x20>
  }
}
801029fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029ff:	5b                   	pop    %ebx
80102a00:	5e                   	pop    %esi
80102a01:	5f                   	pop    %edi
80102a02:	5d                   	pop    %ebp
80102a03:	c3                   	ret    
80102a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a08:	f3 c3                	repz ret 
80102a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a10:	55                   	push   %ebp
80102a11:	89 e5                	mov    %esp,%ebp
80102a13:	56                   	push   %esi
80102a14:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102a15:	83 ec 08             	sub    $0x8,%esp
80102a18:	ff 35 14 49 11 80    	pushl  0x80114914
80102a1e:	ff 35 24 49 11 80    	pushl  0x80114924
80102a24:	e8 a7 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a29:	8b 1d 28 49 11 80    	mov    0x80114928,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102a2f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a32:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102a34:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102a36:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a39:	7e 16                	jle    80102a51 <write_head+0x41>
80102a3b:	c1 e3 02             	shl    $0x2,%ebx
80102a3e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102a40:	8b 8a 2c 49 11 80    	mov    -0x7feeb6d4(%edx),%ecx
80102a46:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102a4a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102a4d:	39 da                	cmp    %ebx,%edx
80102a4f:	75 ef                	jne    80102a40 <write_head+0x30>
  }
  bwrite(buf);
80102a51:	83 ec 0c             	sub    $0xc,%esp
80102a54:	56                   	push   %esi
80102a55:	e8 46 d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a5a:	89 34 24             	mov    %esi,(%esp)
80102a5d:	e8 7e d7 ff ff       	call   801001e0 <brelse>
}
80102a62:	83 c4 10             	add    $0x10,%esp
80102a65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a68:	5b                   	pop    %ebx
80102a69:	5e                   	pop    %esi
80102a6a:	5d                   	pop    %ebp
80102a6b:	c3                   	ret    
80102a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a70 <initlog>:
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	53                   	push   %ebx
80102a74:	83 ec 2c             	sub    $0x2c,%esp
80102a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102a7a:	68 e0 8b 10 80       	push   $0x80108be0
80102a7f:	68 e0 48 11 80       	push   $0x801148e0
80102a84:	e8 c7 20 00 00       	call   80104b50 <initlock>
  readsb(dev, &sb);
80102a89:	58                   	pop    %eax
80102a8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102a8d:	5a                   	pop    %edx
80102a8e:	50                   	push   %eax
80102a8f:	53                   	push   %ebx
80102a90:	e8 7b e8 ff ff       	call   80101310 <readsb>
  log.size = sb.nlog;
80102a95:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102a98:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102a9b:	59                   	pop    %ecx
  log.dev = dev;
80102a9c:	89 1d 24 49 11 80    	mov    %ebx,0x80114924
  log.size = sb.nlog;
80102aa2:	89 15 18 49 11 80    	mov    %edx,0x80114918
  log.start = sb.logstart;
80102aa8:	a3 14 49 11 80       	mov    %eax,0x80114914
  struct buf *buf = bread(log.dev, log.start);
80102aad:	5a                   	pop    %edx
80102aae:	50                   	push   %eax
80102aaf:	53                   	push   %ebx
80102ab0:	e8 1b d6 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102ab5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102ab8:	83 c4 10             	add    $0x10,%esp
80102abb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102abd:	89 1d 28 49 11 80    	mov    %ebx,0x80114928
  for (i = 0; i < log.lh.n; i++) {
80102ac3:	7e 1c                	jle    80102ae1 <initlog+0x71>
80102ac5:	c1 e3 02             	shl    $0x2,%ebx
80102ac8:	31 d2                	xor    %edx,%edx
80102aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102ad0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102ad4:	83 c2 04             	add    $0x4,%edx
80102ad7:	89 8a 28 49 11 80    	mov    %ecx,-0x7feeb6d8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102add:	39 d3                	cmp    %edx,%ebx
80102adf:	75 ef                	jne    80102ad0 <initlog+0x60>
  brelse(buf);
80102ae1:	83 ec 0c             	sub    $0xc,%esp
80102ae4:	50                   	push   %eax
80102ae5:	e8 f6 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102aea:	e8 81 fe ff ff       	call   80102970 <install_trans>
  log.lh.n = 0;
80102aef:	c7 05 28 49 11 80 00 	movl   $0x0,0x80114928
80102af6:	00 00 00 
  write_head(); // clear the log
80102af9:	e8 12 ff ff ff       	call   80102a10 <write_head>
}
80102afe:	83 c4 10             	add    $0x10,%esp
80102b01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b04:	c9                   	leave  
80102b05:	c3                   	ret    
80102b06:	8d 76 00             	lea    0x0(%esi),%esi
80102b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b16:	68 e0 48 11 80       	push   $0x801148e0
80102b1b:	e8 70 21 00 00       	call   80104c90 <acquire>
80102b20:	83 c4 10             	add    $0x10,%esp
80102b23:	eb 18                	jmp    80102b3d <begin_op+0x2d>
80102b25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b28:	83 ec 08             	sub    $0x8,%esp
80102b2b:	68 e0 48 11 80       	push   $0x801148e0
80102b30:	68 e0 48 11 80       	push   $0x801148e0
80102b35:	e8 c6 12 00 00       	call   80103e00 <sleep>
80102b3a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102b3d:	a1 20 49 11 80       	mov    0x80114920,%eax
80102b42:	85 c0                	test   %eax,%eax
80102b44:	75 e2                	jne    80102b28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b46:	a1 1c 49 11 80       	mov    0x8011491c,%eax
80102b4b:	8b 15 28 49 11 80    	mov    0x80114928,%edx
80102b51:	83 c0 01             	add    $0x1,%eax
80102b54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b5a:	83 fa 1e             	cmp    $0x1e,%edx
80102b5d:	7f c9                	jg     80102b28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b5f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102b62:	a3 1c 49 11 80       	mov    %eax,0x8011491c
      release(&log.lock);
80102b67:	68 e0 48 11 80       	push   $0x801148e0
80102b6c:	e8 df 21 00 00       	call   80104d50 <release>
      break;
    }
  }
}
80102b71:	83 c4 10             	add    $0x10,%esp
80102b74:	c9                   	leave  
80102b75:	c3                   	ret    
80102b76:	8d 76 00             	lea    0x0(%esi),%esi
80102b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	57                   	push   %edi
80102b84:	56                   	push   %esi
80102b85:	53                   	push   %ebx
80102b86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102b89:	68 e0 48 11 80       	push   $0x801148e0
80102b8e:	e8 fd 20 00 00       	call   80104c90 <acquire>
  log.outstanding -= 1;
80102b93:	a1 1c 49 11 80       	mov    0x8011491c,%eax
  if(log.committing)
80102b98:	8b 35 20 49 11 80    	mov    0x80114920,%esi
80102b9e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102ba1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102ba4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102ba6:	89 1d 1c 49 11 80    	mov    %ebx,0x8011491c
  if(log.committing)
80102bac:	0f 85 1a 01 00 00    	jne    80102ccc <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102bb2:	85 db                	test   %ebx,%ebx
80102bb4:	0f 85 ee 00 00 00    	jne    80102ca8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102bba:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102bbd:	c7 05 20 49 11 80 01 	movl   $0x1,0x80114920
80102bc4:	00 00 00 
  release(&log.lock);
80102bc7:	68 e0 48 11 80       	push   $0x801148e0
80102bcc:	e8 7f 21 00 00       	call   80104d50 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bd1:	8b 0d 28 49 11 80    	mov    0x80114928,%ecx
80102bd7:	83 c4 10             	add    $0x10,%esp
80102bda:	85 c9                	test   %ecx,%ecx
80102bdc:	0f 8e 85 00 00 00    	jle    80102c67 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102be2:	a1 14 49 11 80       	mov    0x80114914,%eax
80102be7:	83 ec 08             	sub    $0x8,%esp
80102bea:	01 d8                	add    %ebx,%eax
80102bec:	83 c0 01             	add    $0x1,%eax
80102bef:	50                   	push   %eax
80102bf0:	ff 35 24 49 11 80    	pushl  0x80114924
80102bf6:	e8 d5 d4 ff ff       	call   801000d0 <bread>
80102bfb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102bfd:	58                   	pop    %eax
80102bfe:	5a                   	pop    %edx
80102bff:	ff 34 9d 2c 49 11 80 	pushl  -0x7feeb6d4(,%ebx,4)
80102c06:	ff 35 24 49 11 80    	pushl  0x80114924
  for (tail = 0; tail < log.lh.n; tail++) {
80102c0c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c0f:	e8 bc d4 ff ff       	call   801000d0 <bread>
80102c14:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c16:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c19:	83 c4 0c             	add    $0xc,%esp
80102c1c:	68 00 02 00 00       	push   $0x200
80102c21:	50                   	push   %eax
80102c22:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c25:	50                   	push   %eax
80102c26:	e8 25 22 00 00       	call   80104e50 <memmove>
    bwrite(to);  // write the log
80102c2b:	89 34 24             	mov    %esi,(%esp)
80102c2e:	e8 6d d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c33:	89 3c 24             	mov    %edi,(%esp)
80102c36:	e8 a5 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c3b:	89 34 24             	mov    %esi,(%esp)
80102c3e:	e8 9d d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c43:	83 c4 10             	add    $0x10,%esp
80102c46:	3b 1d 28 49 11 80    	cmp    0x80114928,%ebx
80102c4c:	7c 94                	jl     80102be2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c4e:	e8 bd fd ff ff       	call   80102a10 <write_head>
    install_trans(); // Now install writes to home locations
80102c53:	e8 18 fd ff ff       	call   80102970 <install_trans>
    log.lh.n = 0;
80102c58:	c7 05 28 49 11 80 00 	movl   $0x0,0x80114928
80102c5f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c62:	e8 a9 fd ff ff       	call   80102a10 <write_head>
    acquire(&log.lock);
80102c67:	83 ec 0c             	sub    $0xc,%esp
80102c6a:	68 e0 48 11 80       	push   $0x801148e0
80102c6f:	e8 1c 20 00 00       	call   80104c90 <acquire>
    wakeup(&log);
80102c74:	c7 04 24 e0 48 11 80 	movl   $0x801148e0,(%esp)
    log.committing = 0;
80102c7b:	c7 05 20 49 11 80 00 	movl   $0x0,0x80114920
80102c82:	00 00 00 
    wakeup(&log);
80102c85:	e8 36 13 00 00       	call   80103fc0 <wakeup>
    release(&log.lock);
80102c8a:	c7 04 24 e0 48 11 80 	movl   $0x801148e0,(%esp)
80102c91:	e8 ba 20 00 00       	call   80104d50 <release>
80102c96:	83 c4 10             	add    $0x10,%esp
}
80102c99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c9c:	5b                   	pop    %ebx
80102c9d:	5e                   	pop    %esi
80102c9e:	5f                   	pop    %edi
80102c9f:	5d                   	pop    %ebp
80102ca0:	c3                   	ret    
80102ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102ca8:	83 ec 0c             	sub    $0xc,%esp
80102cab:	68 e0 48 11 80       	push   $0x801148e0
80102cb0:	e8 0b 13 00 00       	call   80103fc0 <wakeup>
  release(&log.lock);
80102cb5:	c7 04 24 e0 48 11 80 	movl   $0x801148e0,(%esp)
80102cbc:	e8 8f 20 00 00       	call   80104d50 <release>
80102cc1:	83 c4 10             	add    $0x10,%esp
}
80102cc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cc7:	5b                   	pop    %ebx
80102cc8:	5e                   	pop    %esi
80102cc9:	5f                   	pop    %edi
80102cca:	5d                   	pop    %ebp
80102ccb:	c3                   	ret    
    panic("log.committing");
80102ccc:	83 ec 0c             	sub    $0xc,%esp
80102ccf:	68 e4 8b 10 80       	push   $0x80108be4
80102cd4:	e8 b7 d6 ff ff       	call   80100390 <panic>
80102cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ce0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	53                   	push   %ebx
80102ce4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ce7:	8b 15 28 49 11 80    	mov    0x80114928,%edx
{
80102ced:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cf0:	83 fa 1d             	cmp    $0x1d,%edx
80102cf3:	0f 8f 9d 00 00 00    	jg     80102d96 <log_write+0xb6>
80102cf9:	a1 18 49 11 80       	mov    0x80114918,%eax
80102cfe:	83 e8 01             	sub    $0x1,%eax
80102d01:	39 c2                	cmp    %eax,%edx
80102d03:	0f 8d 8d 00 00 00    	jge    80102d96 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d09:	a1 1c 49 11 80       	mov    0x8011491c,%eax
80102d0e:	85 c0                	test   %eax,%eax
80102d10:	0f 8e 8d 00 00 00    	jle    80102da3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d16:	83 ec 0c             	sub    $0xc,%esp
80102d19:	68 e0 48 11 80       	push   $0x801148e0
80102d1e:	e8 6d 1f 00 00       	call   80104c90 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d23:	8b 0d 28 49 11 80    	mov    0x80114928,%ecx
80102d29:	83 c4 10             	add    $0x10,%esp
80102d2c:	83 f9 00             	cmp    $0x0,%ecx
80102d2f:	7e 57                	jle    80102d88 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d31:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102d34:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d36:	3b 15 2c 49 11 80    	cmp    0x8011492c,%edx
80102d3c:	75 0b                	jne    80102d49 <log_write+0x69>
80102d3e:	eb 38                	jmp    80102d78 <log_write+0x98>
80102d40:	39 14 85 2c 49 11 80 	cmp    %edx,-0x7feeb6d4(,%eax,4)
80102d47:	74 2f                	je     80102d78 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102d49:	83 c0 01             	add    $0x1,%eax
80102d4c:	39 c1                	cmp    %eax,%ecx
80102d4e:	75 f0                	jne    80102d40 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102d50:	89 14 85 2c 49 11 80 	mov    %edx,-0x7feeb6d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d57:	83 c0 01             	add    $0x1,%eax
80102d5a:	a3 28 49 11 80       	mov    %eax,0x80114928
  b->flags |= B_DIRTY; // prevent eviction
80102d5f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102d62:	c7 45 08 e0 48 11 80 	movl   $0x801148e0,0x8(%ebp)
}
80102d69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d6c:	c9                   	leave  
  release(&log.lock);
80102d6d:	e9 de 1f 00 00       	jmp    80104d50 <release>
80102d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102d78:	89 14 85 2c 49 11 80 	mov    %edx,-0x7feeb6d4(,%eax,4)
80102d7f:	eb de                	jmp    80102d5f <log_write+0x7f>
80102d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d88:	8b 43 08             	mov    0x8(%ebx),%eax
80102d8b:	a3 2c 49 11 80       	mov    %eax,0x8011492c
  if (i == log.lh.n)
80102d90:	75 cd                	jne    80102d5f <log_write+0x7f>
80102d92:	31 c0                	xor    %eax,%eax
80102d94:	eb c1                	jmp    80102d57 <log_write+0x77>
    panic("too big a transaction");
80102d96:	83 ec 0c             	sub    $0xc,%esp
80102d99:	68 f3 8b 10 80       	push   $0x80108bf3
80102d9e:	e8 ed d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102da3:	83 ec 0c             	sub    $0xc,%esp
80102da6:	68 09 8c 10 80       	push   $0x80108c09
80102dab:	e8 e0 d5 ff ff       	call   80100390 <panic>

80102db0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	53                   	push   %ebx
80102db4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102db7:	e8 e4 09 00 00       	call   801037a0 <cpuid>
80102dbc:	89 c3                	mov    %eax,%ebx
80102dbe:	e8 dd 09 00 00       	call   801037a0 <cpuid>
80102dc3:	83 ec 04             	sub    $0x4,%esp
80102dc6:	53                   	push   %ebx
80102dc7:	50                   	push   %eax
80102dc8:	68 24 8c 10 80       	push   $0x80108c24
80102dcd:	e8 8e d8 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102dd2:	e8 79 41 00 00       	call   80106f50 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102dd7:	e8 44 09 00 00       	call   80103720 <mycpu>
80102ddc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102dde:	b8 01 00 00 00       	mov    $0x1,%eax
80102de3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102dea:	e8 a1 0c 00 00       	call   80103a90 <scheduler>
80102def:	90                   	nop

80102df0 <mpenter>:
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102df6:	e8 45 52 00 00       	call   80108040 <switchkvm>
  seginit();
80102dfb:	e8 b0 51 00 00       	call   80107fb0 <seginit>
  lapicinit();
80102e00:	e8 9b f7 ff ff       	call   801025a0 <lapicinit>
  mpmain();
80102e05:	e8 a6 ff ff ff       	call   80102db0 <mpmain>
80102e0a:	66 90                	xchg   %ax,%ax
80102e0c:	66 90                	xchg   %ax,%ax
80102e0e:	66 90                	xchg   %ax,%ax

80102e10 <main>:
{
80102e10:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e14:	83 e4 f0             	and    $0xfffffff0,%esp
80102e17:	ff 71 fc             	pushl  -0x4(%ecx)
80102e1a:	55                   	push   %ebp
80102e1b:	89 e5                	mov    %esp,%ebp
80102e1d:	53                   	push   %ebx
80102e1e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e1f:	83 ec 08             	sub    $0x8,%esp
80102e22:	68 00 00 40 80       	push   $0x80400000
80102e27:	68 68 88 1d 80       	push   $0x801d8868
80102e2c:	e8 2f f5 ff ff       	call   80102360 <kinit1>
  kvmalloc();      // kernel page table
80102e31:	e8 da 56 00 00       	call   80108510 <kvmalloc>
  mpinit();        // detect other processors
80102e36:	e8 75 01 00 00       	call   80102fb0 <mpinit>
  lapicinit();     // interrupt controller
80102e3b:	e8 60 f7 ff ff       	call   801025a0 <lapicinit>
  seginit();       // segment descriptors
80102e40:	e8 6b 51 00 00       	call   80107fb0 <seginit>
  picinit();       // disable pic
80102e45:	e8 46 03 00 00       	call   80103190 <picinit>
  ioapicinit();    // another interrupt controller
80102e4a:	e8 41 f3 ff ff       	call   80102190 <ioapicinit>
  consoleinit();   // console hardware
80102e4f:	e8 6c db ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102e54:	e8 27 44 00 00       	call   80107280 <uartinit>
  pinit();         // process table
80102e59:	e8 92 08 00 00       	call   801036f0 <pinit>
  tvinit();        // trap vectors
80102e5e:	e8 6d 40 00 00       	call   80106ed0 <tvinit>
  binit();         // buffer cache
80102e63:	e8 d8 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102e68:	e8 f3 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102e6d:	e8 fe f0 ff ff       	call   80101f70 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e72:	83 c4 0c             	add    $0xc,%esp
80102e75:	68 8a 00 00 00       	push   $0x8a
80102e7a:	68 8c c4 10 80       	push   $0x8010c48c
80102e7f:	68 00 70 00 80       	push   $0x80007000
80102e84:	e8 c7 1f 00 00       	call   80104e50 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102e89:	69 05 60 4f 11 80 b0 	imul   $0xb0,0x80114f60,%eax
80102e90:	00 00 00 
80102e93:	83 c4 10             	add    $0x10,%esp
80102e96:	05 e0 49 11 80       	add    $0x801149e0,%eax
80102e9b:	3d e0 49 11 80       	cmp    $0x801149e0,%eax
80102ea0:	76 71                	jbe    80102f13 <main+0x103>
80102ea2:	bb e0 49 11 80       	mov    $0x801149e0,%ebx
80102ea7:	89 f6                	mov    %esi,%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102eb0:	e8 6b 08 00 00       	call   80103720 <mycpu>
80102eb5:	39 d8                	cmp    %ebx,%eax
80102eb7:	74 41                	je     80102efa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102eb9:	e8 72 f5 ff ff       	call   80102430 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ebe:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102ec3:	c7 05 f8 6f 00 80 f0 	movl   $0x80102df0,0x80006ff8
80102eca:	2d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ecd:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80102ed4:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ed7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102edc:	0f b6 03             	movzbl (%ebx),%eax
80102edf:	83 ec 08             	sub    $0x8,%esp
80102ee2:	68 00 70 00 00       	push   $0x7000
80102ee7:	50                   	push   %eax
80102ee8:	e8 03 f8 ff ff       	call   801026f0 <lapicstartap>
80102eed:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ef0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102ef6:	85 c0                	test   %eax,%eax
80102ef8:	74 f6                	je     80102ef0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102efa:	69 05 60 4f 11 80 b0 	imul   $0xb0,0x80114f60,%eax
80102f01:	00 00 00 
80102f04:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f0a:	05 e0 49 11 80       	add    $0x801149e0,%eax
80102f0f:	39 c3                	cmp    %eax,%ebx
80102f11:	72 9d                	jb     80102eb0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f13:	83 ec 08             	sub    $0x8,%esp
80102f16:	68 00 00 00 8e       	push   $0x8e000000
80102f1b:	68 00 00 40 80       	push   $0x80400000
80102f20:	e8 ab f4 ff ff       	call   801023d0 <kinit2>
  userinit();      // first user process
80102f25:	e8 c6 08 00 00       	call   801037f0 <userinit>
  mpmain();        // finish this processor's setup
80102f2a:	e8 81 fe ff ff       	call   80102db0 <mpmain>
80102f2f:	90                   	nop

80102f30 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	57                   	push   %edi
80102f34:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f35:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102f3b:	53                   	push   %ebx
  e = addr+len;
80102f3c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102f3f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102f42:	39 de                	cmp    %ebx,%esi
80102f44:	72 10                	jb     80102f56 <mpsearch1+0x26>
80102f46:	eb 50                	jmp    80102f98 <mpsearch1+0x68>
80102f48:	90                   	nop
80102f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f50:	39 fb                	cmp    %edi,%ebx
80102f52:	89 fe                	mov    %edi,%esi
80102f54:	76 42                	jbe    80102f98 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f56:	83 ec 04             	sub    $0x4,%esp
80102f59:	8d 7e 10             	lea    0x10(%esi),%edi
80102f5c:	6a 04                	push   $0x4
80102f5e:	68 38 8c 10 80       	push   $0x80108c38
80102f63:	56                   	push   %esi
80102f64:	e8 87 1e 00 00       	call   80104df0 <memcmp>
80102f69:	83 c4 10             	add    $0x10,%esp
80102f6c:	85 c0                	test   %eax,%eax
80102f6e:	75 e0                	jne    80102f50 <mpsearch1+0x20>
80102f70:	89 f1                	mov    %esi,%ecx
80102f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80102f78:	0f b6 11             	movzbl (%ecx),%edx
80102f7b:	83 c1 01             	add    $0x1,%ecx
80102f7e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80102f80:	39 f9                	cmp    %edi,%ecx
80102f82:	75 f4                	jne    80102f78 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f84:	84 c0                	test   %al,%al
80102f86:	75 c8                	jne    80102f50 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80102f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f8b:	89 f0                	mov    %esi,%eax
80102f8d:	5b                   	pop    %ebx
80102f8e:	5e                   	pop    %esi
80102f8f:	5f                   	pop    %edi
80102f90:	5d                   	pop    %ebp
80102f91:	c3                   	ret    
80102f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102f9b:	31 f6                	xor    %esi,%esi
}
80102f9d:	89 f0                	mov    %esi,%eax
80102f9f:	5b                   	pop    %ebx
80102fa0:	5e                   	pop    %esi
80102fa1:	5f                   	pop    %edi
80102fa2:	5d                   	pop    %ebp
80102fa3:	c3                   	ret    
80102fa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102faa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102fb0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	57                   	push   %edi
80102fb4:	56                   	push   %esi
80102fb5:	53                   	push   %ebx
80102fb6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102fb9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fc0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fc7:	c1 e0 08             	shl    $0x8,%eax
80102fca:	09 d0                	or     %edx,%eax
80102fcc:	c1 e0 04             	shl    $0x4,%eax
80102fcf:	85 c0                	test   %eax,%eax
80102fd1:	75 1b                	jne    80102fee <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102fd3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fda:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102fe1:	c1 e0 08             	shl    $0x8,%eax
80102fe4:	09 d0                	or     %edx,%eax
80102fe6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102fe9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102fee:	ba 00 04 00 00       	mov    $0x400,%edx
80102ff3:	e8 38 ff ff ff       	call   80102f30 <mpsearch1>
80102ff8:	85 c0                	test   %eax,%eax
80102ffa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102ffd:	0f 84 3d 01 00 00    	je     80103140 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103003:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103006:	8b 58 04             	mov    0x4(%eax),%ebx
80103009:	85 db                	test   %ebx,%ebx
8010300b:	0f 84 4f 01 00 00    	je     80103160 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103011:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103017:	83 ec 04             	sub    $0x4,%esp
8010301a:	6a 04                	push   $0x4
8010301c:	68 55 8c 10 80       	push   $0x80108c55
80103021:	56                   	push   %esi
80103022:	e8 c9 1d 00 00       	call   80104df0 <memcmp>
80103027:	83 c4 10             	add    $0x10,%esp
8010302a:	85 c0                	test   %eax,%eax
8010302c:	0f 85 2e 01 00 00    	jne    80103160 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103032:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103039:	3c 01                	cmp    $0x1,%al
8010303b:	0f 95 c2             	setne  %dl
8010303e:	3c 04                	cmp    $0x4,%al
80103040:	0f 95 c0             	setne  %al
80103043:	20 c2                	and    %al,%dl
80103045:	0f 85 15 01 00 00    	jne    80103160 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010304b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103052:	66 85 ff             	test   %di,%di
80103055:	74 1a                	je     80103071 <mpinit+0xc1>
80103057:	89 f0                	mov    %esi,%eax
80103059:	01 f7                	add    %esi,%edi
  sum = 0;
8010305b:	31 d2                	xor    %edx,%edx
8010305d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103060:	0f b6 08             	movzbl (%eax),%ecx
80103063:	83 c0 01             	add    $0x1,%eax
80103066:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103068:	39 c7                	cmp    %eax,%edi
8010306a:	75 f4                	jne    80103060 <mpinit+0xb0>
8010306c:	84 d2                	test   %dl,%dl
8010306e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103071:	85 f6                	test   %esi,%esi
80103073:	0f 84 e7 00 00 00    	je     80103160 <mpinit+0x1b0>
80103079:	84 d2                	test   %dl,%dl
8010307b:	0f 85 df 00 00 00    	jne    80103160 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103081:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103087:	a3 dc 48 11 80       	mov    %eax,0x801148dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010308c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103093:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103099:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010309e:	01 d6                	add    %edx,%esi
801030a0:	39 c6                	cmp    %eax,%esi
801030a2:	76 23                	jbe    801030c7 <mpinit+0x117>
    switch(*p){
801030a4:	0f b6 10             	movzbl (%eax),%edx
801030a7:	80 fa 04             	cmp    $0x4,%dl
801030aa:	0f 87 ca 00 00 00    	ja     8010317a <mpinit+0x1ca>
801030b0:	ff 24 95 7c 8c 10 80 	jmp    *-0x7fef7384(,%edx,4)
801030b7:	89 f6                	mov    %esi,%esi
801030b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801030c0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030c3:	39 c6                	cmp    %eax,%esi
801030c5:	77 dd                	ja     801030a4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801030c7:	85 db                	test   %ebx,%ebx
801030c9:	0f 84 9e 00 00 00    	je     8010316d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801030cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801030d6:	74 15                	je     801030ed <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030d8:	b8 70 00 00 00       	mov    $0x70,%eax
801030dd:	ba 22 00 00 00       	mov    $0x22,%edx
801030e2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030e3:	ba 23 00 00 00       	mov    $0x23,%edx
801030e8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801030e9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ec:	ee                   	out    %al,(%dx)
  }
}
801030ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030f0:	5b                   	pop    %ebx
801030f1:	5e                   	pop    %esi
801030f2:	5f                   	pop    %edi
801030f3:	5d                   	pop    %ebp
801030f4:	c3                   	ret    
801030f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801030f8:	8b 0d 60 4f 11 80    	mov    0x80114f60,%ecx
801030fe:	83 f9 07             	cmp    $0x7,%ecx
80103101:	7f 19                	jg     8010311c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103103:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103107:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010310d:	83 c1 01             	add    $0x1,%ecx
80103110:	89 0d 60 4f 11 80    	mov    %ecx,0x80114f60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103116:	88 97 e0 49 11 80    	mov    %dl,-0x7feeb620(%edi)
      p += sizeof(struct mpproc);
8010311c:	83 c0 14             	add    $0x14,%eax
      continue;
8010311f:	e9 7c ff ff ff       	jmp    801030a0 <mpinit+0xf0>
80103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103128:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010312c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010312f:	88 15 c0 49 11 80    	mov    %dl,0x801149c0
      continue;
80103135:	e9 66 ff ff ff       	jmp    801030a0 <mpinit+0xf0>
8010313a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103140:	ba 00 00 01 00       	mov    $0x10000,%edx
80103145:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010314a:	e8 e1 fd ff ff       	call   80102f30 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010314f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103151:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103154:	0f 85 a9 fe ff ff    	jne    80103003 <mpinit+0x53>
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103160:	83 ec 0c             	sub    $0xc,%esp
80103163:	68 3d 8c 10 80       	push   $0x80108c3d
80103168:	e8 23 d2 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010316d:	83 ec 0c             	sub    $0xc,%esp
80103170:	68 5c 8c 10 80       	push   $0x80108c5c
80103175:	e8 16 d2 ff ff       	call   80100390 <panic>
      ismp = 0;
8010317a:	31 db                	xor    %ebx,%ebx
8010317c:	e9 26 ff ff ff       	jmp    801030a7 <mpinit+0xf7>
80103181:	66 90                	xchg   %ax,%ax
80103183:	66 90                	xchg   %ax,%ax
80103185:	66 90                	xchg   %ax,%ax
80103187:	66 90                	xchg   %ax,%ax
80103189:	66 90                	xchg   %ax,%ax
8010318b:	66 90                	xchg   %ax,%ax
8010318d:	66 90                	xchg   %ax,%ax
8010318f:	90                   	nop

80103190 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103190:	55                   	push   %ebp
80103191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103196:	ba 21 00 00 00       	mov    $0x21,%edx
8010319b:	89 e5                	mov    %esp,%ebp
8010319d:	ee                   	out    %al,(%dx)
8010319e:	ba a1 00 00 00       	mov    $0xa1,%edx
801031a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801031a4:	5d                   	pop    %ebp
801031a5:	c3                   	ret    
801031a6:	66 90                	xchg   %ax,%ax
801031a8:	66 90                	xchg   %ax,%ax
801031aa:	66 90                	xchg   %ax,%ax
801031ac:	66 90                	xchg   %ax,%ax
801031ae:	66 90                	xchg   %ax,%ax

801031b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	57                   	push   %edi
801031b4:	56                   	push   %esi
801031b5:	53                   	push   %ebx
801031b6:	83 ec 0c             	sub    $0xc,%esp
801031b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801031bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801031bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801031c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801031cb:	e8 b0 db ff ff       	call   80100d80 <filealloc>
801031d0:	85 c0                	test   %eax,%eax
801031d2:	89 03                	mov    %eax,(%ebx)
801031d4:	74 22                	je     801031f8 <pipealloc+0x48>
801031d6:	e8 a5 db ff ff       	call   80100d80 <filealloc>
801031db:	85 c0                	test   %eax,%eax
801031dd:	89 06                	mov    %eax,(%esi)
801031df:	74 3f                	je     80103220 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801031e1:	e8 4a f2 ff ff       	call   80102430 <kalloc>
801031e6:	85 c0                	test   %eax,%eax
801031e8:	89 c7                	mov    %eax,%edi
801031ea:	75 54                	jne    80103240 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801031ec:	8b 03                	mov    (%ebx),%eax
801031ee:	85 c0                	test   %eax,%eax
801031f0:	75 34                	jne    80103226 <pipealloc+0x76>
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801031f8:	8b 06                	mov    (%esi),%eax
801031fa:	85 c0                	test   %eax,%eax
801031fc:	74 0c                	je     8010320a <pipealloc+0x5a>
    fileclose(*f1);
801031fe:	83 ec 0c             	sub    $0xc,%esp
80103201:	50                   	push   %eax
80103202:	e8 39 dc ff ff       	call   80100e40 <fileclose>
80103207:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010320a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010320d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103212:	5b                   	pop    %ebx
80103213:	5e                   	pop    %esi
80103214:	5f                   	pop    %edi
80103215:	5d                   	pop    %ebp
80103216:	c3                   	ret    
80103217:	89 f6                	mov    %esi,%esi
80103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103220:	8b 03                	mov    (%ebx),%eax
80103222:	85 c0                	test   %eax,%eax
80103224:	74 e4                	je     8010320a <pipealloc+0x5a>
    fileclose(*f0);
80103226:	83 ec 0c             	sub    $0xc,%esp
80103229:	50                   	push   %eax
8010322a:	e8 11 dc ff ff       	call   80100e40 <fileclose>
  if(*f1)
8010322f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103231:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103234:	85 c0                	test   %eax,%eax
80103236:	75 c6                	jne    801031fe <pipealloc+0x4e>
80103238:	eb d0                	jmp    8010320a <pipealloc+0x5a>
8010323a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103240:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103243:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010324a:	00 00 00 
  p->writeopen = 1;
8010324d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103254:	00 00 00 
  p->nwrite = 0;
80103257:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010325e:	00 00 00 
  p->nread = 0;
80103261:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103268:	00 00 00 
  initlock(&p->lock, "pipe");
8010326b:	68 90 8c 10 80       	push   $0x80108c90
80103270:	50                   	push   %eax
80103271:	e8 da 18 00 00       	call   80104b50 <initlock>
  (*f0)->type = FD_PIPE;
80103276:	8b 03                	mov    (%ebx),%eax
  return 0;
80103278:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010327b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103281:	8b 03                	mov    (%ebx),%eax
80103283:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103287:	8b 03                	mov    (%ebx),%eax
80103289:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010328d:	8b 03                	mov    (%ebx),%eax
8010328f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103292:	8b 06                	mov    (%esi),%eax
80103294:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010329a:	8b 06                	mov    (%esi),%eax
8010329c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032a0:	8b 06                	mov    (%esi),%eax
801032a2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032a6:	8b 06                	mov    (%esi),%eax
801032a8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801032ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801032ae:	31 c0                	xor    %eax,%eax
}
801032b0:	5b                   	pop    %ebx
801032b1:	5e                   	pop    %esi
801032b2:	5f                   	pop    %edi
801032b3:	5d                   	pop    %ebp
801032b4:	c3                   	ret    
801032b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801032c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801032c0:	55                   	push   %ebp
801032c1:	89 e5                	mov    %esp,%ebp
801032c3:	56                   	push   %esi
801032c4:	53                   	push   %ebx
801032c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801032cb:	83 ec 0c             	sub    $0xc,%esp
801032ce:	53                   	push   %ebx
801032cf:	e8 bc 19 00 00       	call   80104c90 <acquire>
  if(writable){
801032d4:	83 c4 10             	add    $0x10,%esp
801032d7:	85 f6                	test   %esi,%esi
801032d9:	74 45                	je     80103320 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801032db:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801032e1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801032e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801032eb:	00 00 00 
    wakeup(&p->nread);
801032ee:	50                   	push   %eax
801032ef:	e8 cc 0c 00 00       	call   80103fc0 <wakeup>
801032f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801032f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801032fd:	85 d2                	test   %edx,%edx
801032ff:	75 0a                	jne    8010330b <pipeclose+0x4b>
80103301:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103307:	85 c0                	test   %eax,%eax
80103309:	74 35                	je     80103340 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010330b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010330e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103311:	5b                   	pop    %ebx
80103312:	5e                   	pop    %esi
80103313:	5d                   	pop    %ebp
    release(&p->lock);
80103314:	e9 37 1a 00 00       	jmp    80104d50 <release>
80103319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103320:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103326:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103329:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103330:	00 00 00 
    wakeup(&p->nwrite);
80103333:	50                   	push   %eax
80103334:	e8 87 0c 00 00       	call   80103fc0 <wakeup>
80103339:	83 c4 10             	add    $0x10,%esp
8010333c:	eb b9                	jmp    801032f7 <pipeclose+0x37>
8010333e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103340:	83 ec 0c             	sub    $0xc,%esp
80103343:	53                   	push   %ebx
80103344:	e8 07 1a 00 00       	call   80104d50 <release>
    kfree((char*)p);
80103349:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010334c:	83 c4 10             	add    $0x10,%esp
}
8010334f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103352:	5b                   	pop    %ebx
80103353:	5e                   	pop    %esi
80103354:	5d                   	pop    %ebp
    kfree((char*)p);
80103355:	e9 26 ef ff ff       	jmp    80102280 <kfree>
8010335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103360 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	57                   	push   %edi
80103364:	56                   	push   %esi
80103365:	53                   	push   %ebx
80103366:	83 ec 28             	sub    $0x28,%esp
80103369:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010336c:	53                   	push   %ebx
8010336d:	e8 1e 19 00 00       	call   80104c90 <acquire>
  for(i = 0; i < n; i++){
80103372:	8b 45 10             	mov    0x10(%ebp),%eax
80103375:	83 c4 10             	add    $0x10,%esp
80103378:	85 c0                	test   %eax,%eax
8010337a:	0f 8e c9 00 00 00    	jle    80103449 <pipewrite+0xe9>
80103380:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103383:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103389:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010338f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103392:	03 4d 10             	add    0x10(%ebp),%ecx
80103395:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103398:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010339e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033a4:	39 d0                	cmp    %edx,%eax
801033a6:	75 71                	jne    80103419 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801033a8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801033ae:	85 c0                	test   %eax,%eax
801033b0:	74 4e                	je     80103400 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033b2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033b8:	eb 3a                	jmp    801033f4 <pipewrite+0x94>
801033ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	57                   	push   %edi
801033c4:	e8 f7 0b 00 00       	call   80103fc0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033c9:	5a                   	pop    %edx
801033ca:	59                   	pop    %ecx
801033cb:	53                   	push   %ebx
801033cc:	56                   	push   %esi
801033cd:	e8 2e 0a 00 00       	call   80103e00 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033d2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801033d8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801033de:	83 c4 10             	add    $0x10,%esp
801033e1:	05 00 02 00 00       	add    $0x200,%eax
801033e6:	39 c2                	cmp    %eax,%edx
801033e8:	75 36                	jne    80103420 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801033ea:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801033f0:	85 c0                	test   %eax,%eax
801033f2:	74 0c                	je     80103400 <pipewrite+0xa0>
801033f4:	e8 c7 03 00 00       	call   801037c0 <myproc>
801033f9:	8b 40 24             	mov    0x24(%eax),%eax
801033fc:	85 c0                	test   %eax,%eax
801033fe:	74 c0                	je     801033c0 <pipewrite+0x60>
        release(&p->lock);
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	53                   	push   %ebx
80103404:	e8 47 19 00 00       	call   80104d50 <release>
        return -1;
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103411:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103414:	5b                   	pop    %ebx
80103415:	5e                   	pop    %esi
80103416:	5f                   	pop    %edi
80103417:	5d                   	pop    %ebp
80103418:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103419:	89 c2                	mov    %eax,%edx
8010341b:	90                   	nop
8010341c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103420:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103423:	8d 42 01             	lea    0x1(%edx),%eax
80103426:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010342c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103432:	83 c6 01             	add    $0x1,%esi
80103435:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103439:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010343c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010343f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103443:	0f 85 4f ff ff ff    	jne    80103398 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103449:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010344f:	83 ec 0c             	sub    $0xc,%esp
80103452:	50                   	push   %eax
80103453:	e8 68 0b 00 00       	call   80103fc0 <wakeup>
  release(&p->lock);
80103458:	89 1c 24             	mov    %ebx,(%esp)
8010345b:	e8 f0 18 00 00       	call   80104d50 <release>
  return n;
80103460:	83 c4 10             	add    $0x10,%esp
80103463:	8b 45 10             	mov    0x10(%ebp),%eax
80103466:	eb a9                	jmp    80103411 <pipewrite+0xb1>
80103468:	90                   	nop
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103470 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103470:	55                   	push   %ebp
80103471:	89 e5                	mov    %esp,%ebp
80103473:	57                   	push   %edi
80103474:	56                   	push   %esi
80103475:	53                   	push   %ebx
80103476:	83 ec 18             	sub    $0x18,%esp
80103479:	8b 75 08             	mov    0x8(%ebp),%esi
8010347c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010347f:	56                   	push   %esi
80103480:	e8 0b 18 00 00       	call   80104c90 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103485:	83 c4 10             	add    $0x10,%esp
80103488:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010348e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103494:	75 6a                	jne    80103500 <piperead+0x90>
80103496:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010349c:	85 db                	test   %ebx,%ebx
8010349e:	0f 84 c4 00 00 00    	je     80103568 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034a4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801034aa:	eb 2d                	jmp    801034d9 <piperead+0x69>
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034b0:	83 ec 08             	sub    $0x8,%esp
801034b3:	56                   	push   %esi
801034b4:	53                   	push   %ebx
801034b5:	e8 46 09 00 00       	call   80103e00 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034ba:	83 c4 10             	add    $0x10,%esp
801034bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801034c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801034c9:	75 35                	jne    80103500 <piperead+0x90>
801034cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801034d1:	85 d2                	test   %edx,%edx
801034d3:	0f 84 8f 00 00 00    	je     80103568 <piperead+0xf8>
    if(myproc()->killed){
801034d9:	e8 e2 02 00 00       	call   801037c0 <myproc>
801034de:	8b 48 24             	mov    0x24(%eax),%ecx
801034e1:	85 c9                	test   %ecx,%ecx
801034e3:	74 cb                	je     801034b0 <piperead+0x40>
      release(&p->lock);
801034e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801034e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801034ed:	56                   	push   %esi
801034ee:	e8 5d 18 00 00       	call   80104d50 <release>
      return -1;
801034f3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801034f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034f9:	89 d8                	mov    %ebx,%eax
801034fb:	5b                   	pop    %ebx
801034fc:	5e                   	pop    %esi
801034fd:	5f                   	pop    %edi
801034fe:	5d                   	pop    %ebp
801034ff:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103500:	8b 45 10             	mov    0x10(%ebp),%eax
80103503:	85 c0                	test   %eax,%eax
80103505:	7e 61                	jle    80103568 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103507:	31 db                	xor    %ebx,%ebx
80103509:	eb 13                	jmp    8010351e <piperead+0xae>
8010350b:	90                   	nop
8010350c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103510:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103516:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010351c:	74 1f                	je     8010353d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010351e:	8d 41 01             	lea    0x1(%ecx),%eax
80103521:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103527:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010352d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103532:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103535:	83 c3 01             	add    $0x1,%ebx
80103538:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010353b:	75 d3                	jne    80103510 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010353d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103543:	83 ec 0c             	sub    $0xc,%esp
80103546:	50                   	push   %eax
80103547:	e8 74 0a 00 00       	call   80103fc0 <wakeup>
  release(&p->lock);
8010354c:	89 34 24             	mov    %esi,(%esp)
8010354f:	e8 fc 17 00 00       	call   80104d50 <release>
  return i;
80103554:	83 c4 10             	add    $0x10,%esp
}
80103557:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010355a:	89 d8                	mov    %ebx,%eax
8010355c:	5b                   	pop    %ebx
8010355d:	5e                   	pop    %esi
8010355e:	5f                   	pop    %edi
8010355f:	5d                   	pop    %ebp
80103560:	c3                   	ret    
80103561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103568:	31 db                	xor    %ebx,%ebx
8010356a:	eb d1                	jmp    8010353d <piperead+0xcd>
8010356c:	66 90                	xchg   %ax,%ax
8010356e:	66 90                	xchg   %ax,%ax

80103570 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103574:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
{
80103579:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010357c:	68 c0 5f 17 80       	push   $0x80175fc0
80103581:	e8 0a 17 00 00       	call   80104c90 <acquire>
80103586:	83 c4 10             	add    $0x10,%esp
80103589:	eb 17                	jmp    801035a2 <allocproc+0x32>
8010358b:	90                   	nop
8010358c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103590:	81 c3 80 10 00 00    	add    $0x1080,%ebx
80103596:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
8010359c:	0f 83 ce 00 00 00    	jae    80103670 <allocproc+0x100>
    if(p->state == UNUSED)
801035a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801035a5:	85 c0                	test   %eax,%eax
801035a7:	75 e7                	jne    80103590 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801035a9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  for (int i = 0; i < MSGSIZE; ++i)
  {
    p->received_buffer[i] = -1;
  }
  // addition ends here
  release(&ptable.lock);
801035ae:	83 ec 0c             	sub    $0xc,%esp
      p->in_container_id = -1;
801035b1:	c7 83 7c 10 00 00 ff 	movl   $0xffffffff,0x107c(%ebx)
801035b8:	ff ff ff 
  p->state = EMBRYO;
801035bb:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
    p->received_buffer[i] = -1;
801035c2:	c7 83 5c 10 00 00 ff 	movl   $0xffffffff,0x105c(%ebx)
801035c9:	ff ff ff 
801035cc:	c7 83 60 10 00 00 ff 	movl   $0xffffffff,0x1060(%ebx)
801035d3:	ff ff ff 
801035d6:	c7 83 64 10 00 00 ff 	movl   $0xffffffff,0x1064(%ebx)
801035dd:	ff ff ff 
  p->pid = nextpid++;
801035e0:	8d 50 01             	lea    0x1(%eax),%edx
801035e3:	89 43 10             	mov    %eax,0x10(%ebx)
    p->received_buffer[i] = -1;
801035e6:	c7 83 68 10 00 00 ff 	movl   $0xffffffff,0x1068(%ebx)
801035ed:	ff ff ff 
801035f0:	c7 83 6c 10 00 00 ff 	movl   $0xffffffff,0x106c(%ebx)
801035f7:	ff ff ff 
801035fa:	c7 83 70 10 00 00 ff 	movl   $0xffffffff,0x1070(%ebx)
80103601:	ff ff ff 
80103604:	c7 83 74 10 00 00 ff 	movl   $0xffffffff,0x1074(%ebx)
8010360b:	ff ff ff 
8010360e:	c7 83 78 10 00 00 ff 	movl   $0xffffffff,0x1078(%ebx)
80103615:	ff ff ff 
  release(&ptable.lock);
80103618:	68 c0 5f 17 80       	push   $0x80175fc0
  p->pid = nextpid++;
8010361d:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103623:	e8 28 17 00 00       	call   80104d50 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103628:	e8 03 ee ff ff       	call   80102430 <kalloc>
8010362d:	83 c4 10             	add    $0x10,%esp
80103630:	85 c0                	test   %eax,%eax
80103632:	89 43 08             	mov    %eax,0x8(%ebx)
80103635:	74 52                	je     80103689 <allocproc+0x119>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103637:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010363d:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103640:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103645:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103648:	c7 40 14 bb 6e 10 80 	movl   $0x80106ebb,0x14(%eax)
  p->context = (struct context*)sp;
8010364f:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103652:	6a 14                	push   $0x14
80103654:	6a 00                	push   $0x0
80103656:	50                   	push   %eax
80103657:	e8 44 17 00 00       	call   80104da0 <memset>
  p->context->eip = (uint)forkret;
8010365c:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010365f:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103662:	c7 40 10 a0 36 10 80 	movl   $0x801036a0,0x10(%eax)
}
80103669:	89 d8                	mov    %ebx,%eax
8010366b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010366e:	c9                   	leave  
8010366f:	c3                   	ret    
  release(&ptable.lock);
80103670:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103673:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103675:	68 c0 5f 17 80       	push   $0x80175fc0
8010367a:	e8 d1 16 00 00       	call   80104d50 <release>
}
8010367f:	89 d8                	mov    %ebx,%eax
  return 0;
80103681:	83 c4 10             	add    $0x10,%esp
}
80103684:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103687:	c9                   	leave  
80103688:	c3                   	ret    
    p->state = UNUSED;
80103689:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103690:	31 db                	xor    %ebx,%ebx
80103692:	eb d5                	jmp    80103669 <allocproc+0xf9>
80103694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010369a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036a6:	68 c0 5f 17 80       	push   $0x80175fc0
801036ab:	e8 a0 16 00 00       	call   80104d50 <release>

  if (first) {
801036b0:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801036b5:	83 c4 10             	add    $0x10,%esp
801036b8:	85 c0                	test   %eax,%eax
801036ba:	75 04                	jne    801036c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036bc:	c9                   	leave  
801036bd:	c3                   	ret    
801036be:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801036c0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801036c3:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
801036ca:	00 00 00 
    iinit(ROOTDEV);
801036cd:	6a 01                	push   $0x1
801036cf:	e8 fc dc ff ff       	call   801013d0 <iinit>
    initlog(ROOTDEV);
801036d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036db:	e8 90 f3 ff ff       	call   80102a70 <initlog>
801036e0:	83 c4 10             	add    $0x10,%esp
}
801036e3:	c9                   	leave  
801036e4:	c3                   	ret    
801036e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036f0 <pinit>:
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801036f6:	68 95 8c 10 80       	push   $0x80108c95
801036fb:	68 c0 5f 17 80       	push   $0x80175fc0
80103700:	e8 4b 14 00 00       	call   80104b50 <initlock>
  initlock(&container_table.lock, "container_table");
80103705:	58                   	pop    %eax
80103706:	5a                   	pop    %edx
80103707:	68 9c 8c 10 80       	push   $0x80108c9c
8010370c:	68 80 4f 15 80       	push   $0x80154f80
80103711:	e8 3a 14 00 00       	call   80104b50 <initlock>
}
80103716:	83 c4 10             	add    $0x10,%esp
80103719:	c9                   	leave  
8010371a:	c3                   	ret    
8010371b:	90                   	nop
8010371c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103720 <mycpu>:
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103725:	9c                   	pushf  
80103726:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103727:	f6 c4 02             	test   $0x2,%ah
8010372a:	75 5e                	jne    8010378a <mycpu+0x6a>
  apicid = lapicid();
8010372c:	e8 6f ef ff ff       	call   801026a0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103731:	8b 35 60 4f 11 80    	mov    0x80114f60,%esi
80103737:	85 f6                	test   %esi,%esi
80103739:	7e 42                	jle    8010377d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010373b:	0f b6 15 e0 49 11 80 	movzbl 0x801149e0,%edx
80103742:	39 d0                	cmp    %edx,%eax
80103744:	74 30                	je     80103776 <mycpu+0x56>
80103746:	b9 90 4a 11 80       	mov    $0x80114a90,%ecx
  for (i = 0; i < ncpu; ++i) {
8010374b:	31 d2                	xor    %edx,%edx
8010374d:	8d 76 00             	lea    0x0(%esi),%esi
80103750:	83 c2 01             	add    $0x1,%edx
80103753:	39 f2                	cmp    %esi,%edx
80103755:	74 26                	je     8010377d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103757:	0f b6 19             	movzbl (%ecx),%ebx
8010375a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103760:	39 c3                	cmp    %eax,%ebx
80103762:	75 ec                	jne    80103750 <mycpu+0x30>
80103764:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010376a:	05 e0 49 11 80       	add    $0x801149e0,%eax
}
8010376f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103772:	5b                   	pop    %ebx
80103773:	5e                   	pop    %esi
80103774:	5d                   	pop    %ebp
80103775:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103776:	b8 e0 49 11 80       	mov    $0x801149e0,%eax
      return &cpus[i];
8010377b:	eb f2                	jmp    8010376f <mycpu+0x4f>
  panic("unknown apicid\n");
8010377d:	83 ec 0c             	sub    $0xc,%esp
80103780:	68 ac 8c 10 80       	push   $0x80108cac
80103785:	e8 06 cc ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010378a:	83 ec 0c             	sub    $0xc,%esp
8010378d:	68 d0 8d 10 80       	push   $0x80108dd0
80103792:	e8 f9 cb ff ff       	call   80100390 <panic>
80103797:	89 f6                	mov    %esi,%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <cpuid>:
cpuid() {
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037a6:	e8 75 ff ff ff       	call   80103720 <mycpu>
801037ab:	2d e0 49 11 80       	sub    $0x801149e0,%eax
}
801037b0:	c9                   	leave  
  return mycpu()-cpus;
801037b1:	c1 f8 04             	sar    $0x4,%eax
801037b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ba:	c3                   	ret    
801037bb:	90                   	nop
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037c0 <myproc>:
myproc(void) {
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
801037c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801037c7:	e8 f4 13 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
801037cc:	e8 4f ff ff ff       	call   80103720 <mycpu>
  p = c->proc;
801037d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037d7:	e8 24 14 00 00       	call   80104c00 <popcli>
}
801037dc:	83 c4 04             	add    $0x4,%esp
801037df:	89 d8                	mov    %ebx,%eax
801037e1:	5b                   	pop    %ebx
801037e2:	5d                   	pop    %ebp
801037e3:	c3                   	ret    
801037e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037f0 <userinit>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	53                   	push   %ebx
801037f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801037f7:	e8 74 fd ff ff       	call   80103570 <allocproc>
801037fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801037fe:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
  if((p->pgdir = setupkvm()) == 0)
80103803:	e8 88 4c 00 00       	call   80108490 <setupkvm>
80103808:	85 c0                	test   %eax,%eax
8010380a:	89 43 04             	mov    %eax,0x4(%ebx)
8010380d:	0f 84 c3 00 00 00    	je     801038d6 <userinit+0xe6>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103813:	83 ec 04             	sub    $0x4,%esp
80103816:	68 2c 00 00 00       	push   $0x2c
8010381b:	68 60 c4 10 80       	push   $0x8010c460
80103820:	50                   	push   %eax
80103821:	e8 4a 49 00 00       	call   80108170 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103826:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103829:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010382f:	6a 4c                	push   $0x4c
80103831:	6a 00                	push   $0x0
80103833:	ff 73 18             	pushl  0x18(%ebx)
80103836:	e8 65 15 00 00       	call   80104da0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010383b:	8b 43 18             	mov    0x18(%ebx),%eax
8010383e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103843:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103848:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010384b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010384f:	8b 43 18             	mov    0x18(%ebx),%eax
80103852:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103856:	8b 43 18             	mov    0x18(%ebx),%eax
80103859:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010385d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103861:	8b 43 18             	mov    0x18(%ebx),%eax
80103864:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103868:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010386c:	8b 43 18             	mov    0x18(%ebx),%eax
8010386f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103876:	8b 43 18             	mov    0x18(%ebx),%eax
80103879:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103880:	8b 43 18             	mov    0x18(%ebx),%eax
80103883:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010388a:	8d 83 2c 10 00 00    	lea    0x102c(%ebx),%eax
80103890:	6a 10                	push   $0x10
80103892:	68 d5 8c 10 80       	push   $0x80108cd5
80103897:	50                   	push   %eax
80103898:	e8 e3 16 00 00       	call   80104f80 <safestrcpy>
  p->cwd = namei("/");
8010389d:	c7 04 24 de 8c 10 80 	movl   $0x80108cde,(%esp)
801038a4:	e8 a7 e5 ff ff       	call   80101e50 <namei>
801038a9:	89 83 28 10 00 00    	mov    %eax,0x1028(%ebx)
  acquire(&ptable.lock);
801038af:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
801038b6:	e8 d5 13 00 00       	call   80104c90 <acquire>
  p->state = RUNNABLE;
801038bb:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038c2:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
801038c9:	e8 82 14 00 00       	call   80104d50 <release>
}
801038ce:	83 c4 10             	add    $0x10,%esp
801038d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038d4:	c9                   	leave  
801038d5:	c3                   	ret    
    panic("userinit: out of memory?");
801038d6:	83 ec 0c             	sub    $0xc,%esp
801038d9:	68 bc 8c 10 80       	push   $0x80108cbc
801038de:	e8 ad ca ff ff       	call   80100390 <panic>
801038e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038f0 <growproc>:
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	56                   	push   %esi
801038f4:	53                   	push   %ebx
801038f5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801038f8:	e8 c3 12 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
801038fd:	e8 1e fe ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103902:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103908:	e8 f3 12 00 00       	call   80104c00 <popcli>
  if(n > 0){
8010390d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103910:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103912:	7f 1c                	jg     80103930 <growproc+0x40>
  } else if(n < 0){
80103914:	75 3a                	jne    80103950 <growproc+0x60>
  switchuvm(curproc);
80103916:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103919:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010391b:	53                   	push   %ebx
8010391c:	e8 3f 47 00 00       	call   80108060 <switchuvm>
  return 0;
80103921:	83 c4 10             	add    $0x10,%esp
80103924:	31 c0                	xor    %eax,%eax
}
80103926:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103929:	5b                   	pop    %ebx
8010392a:	5e                   	pop    %esi
8010392b:	5d                   	pop    %ebp
8010392c:	c3                   	ret    
8010392d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103930:	83 ec 04             	sub    $0x4,%esp
80103933:	01 c6                	add    %eax,%esi
80103935:	56                   	push   %esi
80103936:	50                   	push   %eax
80103937:	ff 73 04             	pushl  0x4(%ebx)
8010393a:	e8 71 49 00 00       	call   801082b0 <allocuvm>
8010393f:	83 c4 10             	add    $0x10,%esp
80103942:	85 c0                	test   %eax,%eax
80103944:	75 d0                	jne    80103916 <growproc+0x26>
      return -1;
80103946:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010394b:	eb d9                	jmp    80103926 <growproc+0x36>
8010394d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103950:	83 ec 04             	sub    $0x4,%esp
80103953:	01 c6                	add    %eax,%esi
80103955:	56                   	push   %esi
80103956:	50                   	push   %eax
80103957:	ff 73 04             	pushl  0x4(%ebx)
8010395a:	e8 81 4a 00 00       	call   801083e0 <deallocuvm>
8010395f:	83 c4 10             	add    $0x10,%esp
80103962:	85 c0                	test   %eax,%eax
80103964:	75 b0                	jne    80103916 <growproc+0x26>
80103966:	eb de                	jmp    80103946 <growproc+0x56>
80103968:	90                   	nop
80103969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103970 <fork>:
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	57                   	push   %edi
80103974:	56                   	push   %esi
80103975:	53                   	push   %ebx
80103976:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103979:	e8 42 12 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
8010397e:	e8 9d fd ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103983:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103989:	e8 72 12 00 00       	call   80104c00 <popcli>
  if((np = allocproc()) == 0){
8010398e:	e8 dd fb ff ff       	call   80103570 <allocproc>
80103993:	85 c0                	test   %eax,%eax
80103995:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103998:	0f 84 c6 00 00 00    	je     80103a64 <fork+0xf4>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010399e:	83 ec 08             	sub    $0x8,%esp
801039a1:	ff 33                	pushl  (%ebx)
801039a3:	ff 73 04             	pushl  0x4(%ebx)
801039a6:	89 c7                	mov    %eax,%edi
801039a8:	e8 b3 4b 00 00       	call   80108560 <copyuvm>
801039ad:	83 c4 10             	add    $0x10,%esp
801039b0:	85 c0                	test   %eax,%eax
801039b2:	89 47 04             	mov    %eax,0x4(%edi)
801039b5:	0f 84 b0 00 00 00    	je     80103a6b <fork+0xfb>
  np->sz = curproc->sz;
801039bb:	8b 03                	mov    (%ebx),%eax
801039bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039c0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039c2:	89 59 14             	mov    %ebx,0x14(%ecx)
801039c5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039c7:	8b 79 18             	mov    0x18(%ecx),%edi
801039ca:	8b 73 18             	mov    0x18(%ebx),%esi
801039cd:	b9 13 00 00 00       	mov    $0x13,%ecx
801039d2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801039d4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801039d6:	8b 40 18             	mov    0x18(%eax),%eax
801039d9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801039e0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039e4:	85 c0                	test   %eax,%eax
801039e6:	74 13                	je     801039fb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039e8:	83 ec 0c             	sub    $0xc,%esp
801039eb:	50                   	push   %eax
801039ec:	e8 ff d3 ff ff       	call   80100df0 <filedup>
801039f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039f4:	83 c4 10             	add    $0x10,%esp
801039f7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801039fb:	83 c6 01             	add    $0x1,%esi
801039fe:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80103a04:	75 da                	jne    801039e0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a06:	83 ec 0c             	sub    $0xc,%esp
80103a09:	ff b3 28 10 00 00    	pushl  0x1028(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a0f:	81 c3 2c 10 00 00    	add    $0x102c,%ebx
  np->cwd = idup(curproc->cwd);
80103a15:	e8 86 db ff ff       	call   801015a0 <idup>
80103a1a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a1d:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a20:	89 87 28 10 00 00    	mov    %eax,0x1028(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a26:	8d 87 2c 10 00 00    	lea    0x102c(%edi),%eax
80103a2c:	6a 10                	push   $0x10
80103a2e:	53                   	push   %ebx
80103a2f:	50                   	push   %eax
80103a30:	e8 4b 15 00 00       	call   80104f80 <safestrcpy>
  pid = np->pid;
80103a35:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a38:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103a3f:	e8 4c 12 00 00       	call   80104c90 <acquire>
  np->state = RUNNABLE;
80103a44:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a4b:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103a52:	e8 f9 12 00 00       	call   80104d50 <release>
  return pid;
80103a57:	83 c4 10             	add    $0x10,%esp
}
80103a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5d:	89 d8                	mov    %ebx,%eax
80103a5f:	5b                   	pop    %ebx
80103a60:	5e                   	pop    %esi
80103a61:	5f                   	pop    %edi
80103a62:	5d                   	pop    %ebp
80103a63:	c3                   	ret    
    return -1;
80103a64:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a69:	eb ef                	jmp    80103a5a <fork+0xea>
    kfree(np->kstack);
80103a6b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a6e:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103a71:	83 cb ff             	or     $0xffffffff,%ebx
    kfree(np->kstack);
80103a74:	ff 77 08             	pushl  0x8(%edi)
80103a77:	e8 04 e8 ff ff       	call   80102280 <kfree>
    np->kstack = 0;
80103a7c:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103a83:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103a8a:	83 c4 10             	add    $0x10,%esp
80103a8d:	eb cb                	jmp    80103a5a <fork+0xea>
80103a8f:	90                   	nop

80103a90 <scheduler>:
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	57                   	push   %edi
80103a94:	56                   	push   %esi
80103a95:	53                   	push   %ebx
  int counter = 0;
80103a96:	31 ff                	xor    %edi,%edi
  int turn_cid = -1;
80103a98:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
{
80103a9d:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103aa0:	e8 7b fc ff ff       	call   80103720 <mycpu>
  c->proc = 0;
80103aa5:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103aac:	00 00 00 
  struct cpu *c = mycpu();
80103aaf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ab2:	83 c0 04             	add    $0x4,%eax
80103ab5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103ab8:	90                   	nop
80103ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103ac0:	fb                   	sti    
    acquire(&container_table.lock);
80103ac1:	83 ec 0c             	sub    $0xc,%esp
80103ac4:	68 80 4f 15 80       	push   $0x80154f80
80103ac9:	e8 c2 11 00 00       	call   80104c90 <acquire>
      for(ind = counter ; ind< container_table.size ; ind++)
80103ace:	8b 0d b4 5f 15 80    	mov    0x80155fb4,%ecx
80103ad4:	83 c4 10             	add    $0x10,%esp
80103ad7:	39 cf                	cmp    %ecx,%edi
80103ad9:	7d 2b                	jge    80103b06 <scheduler+0x76>
          if(container_table.containers[ind].cid != turn_cid){
80103adb:	8b 14 bd b4 4f 15 80 	mov    -0x7feab04c(,%edi,4),%edx
80103ae2:	39 d3                	cmp    %edx,%ebx
80103ae4:	74 19                	je     80103aff <scheduler+0x6f>
80103ae6:	e9 c5 00 00 00       	jmp    80103bb0 <scheduler+0x120>
80103aeb:	90                   	nop
80103aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103af0:	8b 14 bd b4 4f 15 80 	mov    -0x7feab04c(,%edi,4),%edx
80103af7:	39 da                	cmp    %ebx,%edx
80103af9:	0f 85 b1 00 00 00    	jne    80103bb0 <scheduler+0x120>
      for(ind = counter ; ind< container_table.size ; ind++)
80103aff:	83 c7 01             	add    $0x1,%edi
80103b02:	39 cf                	cmp    %ecx,%edi
80103b04:	75 ea                	jne    80103af0 <scheduler+0x60>
        counter  =0;
80103b06:	31 ff                	xor    %edi,%edi
        turn_cid  = -1;
80103b08:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    release(&container_table.lock);
80103b0d:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b10:	be f4 5f 17 80       	mov    $0x80175ff4,%esi
    release(&container_table.lock);
80103b15:	68 80 4f 15 80       	push   $0x80154f80
80103b1a:	e8 31 12 00 00       	call   80104d50 <release>
    acquire(&ptable.lock);
80103b1f:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103b26:	e8 65 11 00 00       	call   80104c90 <acquire>
80103b2b:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE || p->in_container_id != turn_cid ){
80103b2e:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103b32:	75 64                	jne    80103b98 <scheduler+0x108>
80103b34:	39 9e 7c 10 00 00    	cmp    %ebx,0x107c(%esi)
80103b3a:	75 5c                	jne    80103b98 <scheduler+0x108>
      if (scheduler_log==1){
80103b3c:	83 3d 6c 20 11 80 01 	cmpl   $0x1,0x8011206c
80103b43:	74 7b                	je     80103bc0 <scheduler+0x130>
      c->proc = p;
80103b45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      switchuvm(p);
80103b48:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103b4b:	89 b0 ac 00 00 00    	mov    %esi,0xac(%eax)
      switchuvm(p);
80103b51:	56                   	push   %esi
80103b52:	e8 09 45 00 00       	call   80108060 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103b57:	58                   	pop    %eax
80103b58:	5a                   	pop    %edx
80103b59:	ff 76 1c             	pushl  0x1c(%esi)
80103b5c:	ff 75 e0             	pushl  -0x20(%ebp)
      p->state = RUNNING;
80103b5f:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      swtch(&(c->scheduler), p->context);
80103b66:	e8 70 14 00 00       	call   80104fdb <swtch>
      switchkvm();
80103b6b:	e8 d0 44 00 00       	call   80108040 <switchkvm>
      c->proc = 0;
80103b70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      break;
80103b73:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
80103b76:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b7d:	00 00 00 
    release(&ptable.lock);
80103b80:	83 ec 0c             	sub    $0xc,%esp
80103b83:	68 c0 5f 17 80       	push   $0x80175fc0
80103b88:	e8 c3 11 00 00       	call   80104d50 <release>
  for(;;){
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	e9 2b ff ff ff       	jmp    80103ac0 <scheduler+0x30>
80103b95:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b98:	81 c6 80 10 00 00    	add    $0x1080,%esi
80103b9e:	81 fe f4 7f 1b 80    	cmp    $0x801b7ff4,%esi
80103ba4:	72 88                	jb     80103b2e <scheduler+0x9e>
80103ba6:	eb d8                	jmp    80103b80 <scheduler+0xf0>
80103ba8:	90                   	nop
80103ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          if(container_table.containers[ind].cid != turn_cid){
80103bb0:	89 d3                	mov    %edx,%ebx
80103bb2:	e9 56 ff ff ff       	jmp    80103b0d <scheduler+0x7d>
80103bb7:	89 f6                	mov    %esi,%esi
80103bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        cprintf("Container + %d : Scheduling process + %d\n",p->in_container_id,p->pid);
80103bc0:	83 ec 04             	sub    $0x4,%esp
80103bc3:	ff 76 10             	pushl  0x10(%esi)
80103bc6:	53                   	push   %ebx
80103bc7:	68 f8 8d 10 80       	push   $0x80108df8
80103bcc:	e8 8f ca ff ff       	call   80100660 <cprintf>
80103bd1:	83 c4 10             	add    $0x10,%esp
80103bd4:	e9 6c ff ff ff       	jmp    80103b45 <scheduler+0xb5>
80103bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103be0 <sched>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
  pushcli();
80103be5:	e8 d6 0f 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80103bea:	e8 31 fb ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103bef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bf5:	e8 06 10 00 00       	call   80104c00 <popcli>
  if(!holding(&ptable.lock))
80103bfa:	83 ec 0c             	sub    $0xc,%esp
80103bfd:	68 c0 5f 17 80       	push   $0x80175fc0
80103c02:	e8 59 10 00 00       	call   80104c60 <holding>
80103c07:	83 c4 10             	add    $0x10,%esp
80103c0a:	85 c0                	test   %eax,%eax
80103c0c:	74 4f                	je     80103c5d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c0e:	e8 0d fb ff ff       	call   80103720 <mycpu>
80103c13:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c1a:	75 68                	jne    80103c84 <sched+0xa4>
  if(p->state == RUNNING)
80103c1c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c20:	74 55                	je     80103c77 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c22:	9c                   	pushf  
80103c23:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c24:	f6 c4 02             	test   $0x2,%ah
80103c27:	75 41                	jne    80103c6a <sched+0x8a>
  intena = mycpu()->intena;
80103c29:	e8 f2 fa ff ff       	call   80103720 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c2e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c31:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c37:	e8 e4 fa ff ff       	call   80103720 <mycpu>
80103c3c:	83 ec 08             	sub    $0x8,%esp
80103c3f:	ff 70 04             	pushl  0x4(%eax)
80103c42:	53                   	push   %ebx
80103c43:	e8 93 13 00 00       	call   80104fdb <swtch>
  mycpu()->intena = intena;
80103c48:	e8 d3 fa ff ff       	call   80103720 <mycpu>
}
80103c4d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c50:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c56:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c59:	5b                   	pop    %ebx
80103c5a:	5e                   	pop    %esi
80103c5b:	5d                   	pop    %ebp
80103c5c:	c3                   	ret    
    panic("sched ptable.lock");
80103c5d:	83 ec 0c             	sub    $0xc,%esp
80103c60:	68 e0 8c 10 80       	push   $0x80108ce0
80103c65:	e8 26 c7 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c6a:	83 ec 0c             	sub    $0xc,%esp
80103c6d:	68 0c 8d 10 80       	push   $0x80108d0c
80103c72:	e8 19 c7 ff ff       	call   80100390 <panic>
    panic("sched running");
80103c77:	83 ec 0c             	sub    $0xc,%esp
80103c7a:	68 fe 8c 10 80       	push   $0x80108cfe
80103c7f:	e8 0c c7 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103c84:	83 ec 0c             	sub    $0xc,%esp
80103c87:	68 f2 8c 10 80       	push   $0x80108cf2
80103c8c:	e8 ff c6 ff ff       	call   80100390 <panic>
80103c91:	eb 0d                	jmp    80103ca0 <exit>
80103c93:	90                   	nop
80103c94:	90                   	nop
80103c95:	90                   	nop
80103c96:	90                   	nop
80103c97:	90                   	nop
80103c98:	90                   	nop
80103c99:	90                   	nop
80103c9a:	90                   	nop
80103c9b:	90                   	nop
80103c9c:	90                   	nop
80103c9d:	90                   	nop
80103c9e:	90                   	nop
80103c9f:	90                   	nop

80103ca0 <exit>:
{
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	53                   	push   %ebx
80103ca4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ca7:	e8 14 0f 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80103cac:	e8 6f fa ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103cb1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cb7:	e8 44 0f 00 00       	call   80104c00 <popcli>
  if(curproc == initproc)
80103cbc:	39 1d c0 c5 10 80    	cmp    %ebx,0x8010c5c0
80103cc2:	0f 84 d9 00 00 00    	je     80103da1 <exit+0x101>
  begin_op();
80103cc8:	e8 43 ee ff ff       	call   80102b10 <begin_op>
  iput(curproc->cwd);
80103ccd:	83 ec 0c             	sub    $0xc,%esp
80103cd0:	ff b3 28 10 00 00    	pushl  0x1028(%ebx)
80103cd6:	e8 25 da ff ff       	call   80101700 <iput>
  end_op();
80103cdb:	e8 a0 ee ff ff       	call   80102b80 <end_op>
  curproc->cwd = 0;
80103ce0:	c7 83 28 10 00 00 00 	movl   $0x0,0x1028(%ebx)
80103ce7:	00 00 00 
  acquire(&ptable.lock);
80103cea:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103cf1:	e8 9a 0f 00 00       	call   80104c90 <acquire>
  wakeup1(curproc->parent);
80103cf6:	8b 53 14             	mov    0x14(%ebx),%edx
80103cf9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cfc:	b8 f4 5f 17 80       	mov    $0x80175ff4,%eax
80103d01:	eb 11                	jmp    80103d14 <exit+0x74>
80103d03:	90                   	nop
80103d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d08:	05 80 10 00 00       	add    $0x1080,%eax
80103d0d:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
80103d12:	73 1e                	jae    80103d32 <exit+0x92>
    if(p->state == SLEEPING && p->chan == chan)
80103d14:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d18:	75 ee                	jne    80103d08 <exit+0x68>
80103d1a:	3b 50 20             	cmp    0x20(%eax),%edx
80103d1d:	75 e9                	jne    80103d08 <exit+0x68>
      p->state = RUNNABLE;
80103d1f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d26:	05 80 10 00 00       	add    $0x1080,%eax
80103d2b:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
80103d30:	72 e2                	jb     80103d14 <exit+0x74>
      p->parent = initproc;
80103d32:	8b 0d c0 c5 10 80    	mov    0x8010c5c0,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d38:	ba f4 5f 17 80       	mov    $0x80175ff4,%edx
80103d3d:	eb 0f                	jmp    80103d4e <exit+0xae>
80103d3f:	90                   	nop
80103d40:	81 c2 80 10 00 00    	add    $0x1080,%edx
80103d46:	81 fa f4 7f 1b 80    	cmp    $0x801b7ff4,%edx
80103d4c:	73 3a                	jae    80103d88 <exit+0xe8>
    if(p->parent == curproc){
80103d4e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103d51:	75 ed                	jne    80103d40 <exit+0xa0>
      if(p->state == ZOMBIE)
80103d53:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d57:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d5a:	75 e4                	jne    80103d40 <exit+0xa0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d5c:	b8 f4 5f 17 80       	mov    $0x80175ff4,%eax
80103d61:	eb 11                	jmp    80103d74 <exit+0xd4>
80103d63:	90                   	nop
80103d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d68:	05 80 10 00 00       	add    $0x1080,%eax
80103d6d:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
80103d72:	73 cc                	jae    80103d40 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103d74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d78:	75 ee                	jne    80103d68 <exit+0xc8>
80103d7a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103d7d:	75 e9                	jne    80103d68 <exit+0xc8>
      p->state = RUNNABLE;
80103d7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d86:	eb e0                	jmp    80103d68 <exit+0xc8>
  curproc->state = ZOMBIE;
80103d88:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103d8f:	e8 4c fe ff ff       	call   80103be0 <sched>
  panic("zombie exit");
80103d94:	83 ec 0c             	sub    $0xc,%esp
80103d97:	68 2d 8d 10 80       	push   $0x80108d2d
80103d9c:	e8 ef c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103da1:	83 ec 0c             	sub    $0xc,%esp
80103da4:	68 20 8d 10 80       	push   $0x80108d20
80103da9:	e8 e2 c5 ff ff       	call   80100390 <panic>
80103dae:	66 90                	xchg   %ax,%ax

80103db0 <yield>:
{
80103db0:	55                   	push   %ebp
80103db1:	89 e5                	mov    %esp,%ebp
80103db3:	53                   	push   %ebx
80103db4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103db7:	68 c0 5f 17 80       	push   $0x80175fc0
80103dbc:	e8 cf 0e 00 00       	call   80104c90 <acquire>
  pushcli();
80103dc1:	e8 fa 0d 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80103dc6:	e8 55 f9 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103dcb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd1:	e8 2a 0e 00 00       	call   80104c00 <popcli>
  myproc()->state = RUNNABLE;
80103dd6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ddd:	e8 fe fd ff ff       	call   80103be0 <sched>
  release(&ptable.lock);
80103de2:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103de9:	e8 62 0f 00 00       	call   80104d50 <release>
}
80103dee:	83 c4 10             	add    $0x10,%esp
80103df1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103df4:	c9                   	leave  
80103df5:	c3                   	ret    
80103df6:	8d 76 00             	lea    0x0(%esi),%esi
80103df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e00 <sleep>:
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	57                   	push   %edi
80103e04:	56                   	push   %esi
80103e05:	53                   	push   %ebx
80103e06:	83 ec 0c             	sub    $0xc,%esp
80103e09:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e0f:	e8 ac 0d 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80103e14:	e8 07 f9 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103e19:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e1f:	e8 dc 0d 00 00       	call   80104c00 <popcli>
  if(p == 0)
80103e24:	85 db                	test   %ebx,%ebx
80103e26:	0f 84 87 00 00 00    	je     80103eb3 <sleep+0xb3>
  if(lk == 0)
80103e2c:	85 f6                	test   %esi,%esi
80103e2e:	74 76                	je     80103ea6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e30:	81 fe c0 5f 17 80    	cmp    $0x80175fc0,%esi
80103e36:	74 50                	je     80103e88 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e38:	83 ec 0c             	sub    $0xc,%esp
80103e3b:	68 c0 5f 17 80       	push   $0x80175fc0
80103e40:	e8 4b 0e 00 00       	call   80104c90 <acquire>
    release(lk);
80103e45:	89 34 24             	mov    %esi,(%esp)
80103e48:	e8 03 0f 00 00       	call   80104d50 <release>
  p->chan = chan;
80103e4d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e50:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e57:	e8 84 fd ff ff       	call   80103be0 <sched>
  p->chan = 0;
80103e5c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103e63:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
80103e6a:	e8 e1 0e 00 00       	call   80104d50 <release>
    acquire(lk);
80103e6f:	89 75 08             	mov    %esi,0x8(%ebp)
80103e72:	83 c4 10             	add    $0x10,%esp
}
80103e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e78:	5b                   	pop    %ebx
80103e79:	5e                   	pop    %esi
80103e7a:	5f                   	pop    %edi
80103e7b:	5d                   	pop    %ebp
    acquire(lk);
80103e7c:	e9 0f 0e 00 00       	jmp    80104c90 <acquire>
80103e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103e88:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e8b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e92:	e8 49 fd ff ff       	call   80103be0 <sched>
  p->chan = 0;
80103e97:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ea1:	5b                   	pop    %ebx
80103ea2:	5e                   	pop    %esi
80103ea3:	5f                   	pop    %edi
80103ea4:	5d                   	pop    %ebp
80103ea5:	c3                   	ret    
    panic("sleep without lk");
80103ea6:	83 ec 0c             	sub    $0xc,%esp
80103ea9:	68 3f 8d 10 80       	push   $0x80108d3f
80103eae:	e8 dd c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103eb3:	83 ec 0c             	sub    $0xc,%esp
80103eb6:	68 39 8d 10 80       	push   $0x80108d39
80103ebb:	e8 d0 c4 ff ff       	call   80100390 <panic>

80103ec0 <wait>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	56                   	push   %esi
80103ec4:	53                   	push   %ebx
  pushcli();
80103ec5:	e8 f6 0c 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80103eca:	e8 51 f8 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80103ecf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103ed5:	e8 26 0d 00 00       	call   80104c00 <popcli>
  acquire(&ptable.lock);
80103eda:	83 ec 0c             	sub    $0xc,%esp
80103edd:	68 c0 5f 17 80       	push   $0x80175fc0
80103ee2:	e8 a9 0d 00 00       	call   80104c90 <acquire>
80103ee7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eec:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
80103ef1:	eb 13                	jmp    80103f06 <wait+0x46>
80103ef3:	90                   	nop
80103ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ef8:	81 c3 80 10 00 00    	add    $0x1080,%ebx
80103efe:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
80103f04:	73 1e                	jae    80103f24 <wait+0x64>
      if(p->parent != curproc)
80103f06:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f09:	75 ed                	jne    80103ef8 <wait+0x38>
      if(p->state == ZOMBIE){
80103f0b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f0f:	74 37                	je     80103f48 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f11:	81 c3 80 10 00 00    	add    $0x1080,%ebx
      havekids = 1;
80103f17:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f1c:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
80103f22:	72 e2                	jb     80103f06 <wait+0x46>
    if(!havekids || curproc->killed){
80103f24:	85 c0                	test   %eax,%eax
80103f26:	74 79                	je     80103fa1 <wait+0xe1>
80103f28:	8b 46 24             	mov    0x24(%esi),%eax
80103f2b:	85 c0                	test   %eax,%eax
80103f2d:	75 72                	jne    80103fa1 <wait+0xe1>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f2f:	83 ec 08             	sub    $0x8,%esp
80103f32:	68 c0 5f 17 80       	push   $0x80175fc0
80103f37:	56                   	push   %esi
80103f38:	e8 c3 fe ff ff       	call   80103e00 <sleep>
    havekids = 0;
80103f3d:	83 c4 10             	add    $0x10,%esp
80103f40:	eb a8                	jmp    80103eea <wait+0x2a>
80103f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103f48:	83 ec 0c             	sub    $0xc,%esp
80103f4b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f4e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f51:	e8 2a e3 ff ff       	call   80102280 <kfree>
        freevm(p->pgdir);
80103f56:	5a                   	pop    %edx
80103f57:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f5a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f61:	e8 aa 44 00 00       	call   80108410 <freevm>
        release(&ptable.lock);
80103f66:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
        p->pid = 0;
80103f6d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f74:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f7b:	c6 83 2c 10 00 00 00 	movb   $0x0,0x102c(%ebx)
        p->killed = 0;
80103f82:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f89:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f90:	e8 bb 0d 00 00       	call   80104d50 <release>
        return pid;
80103f95:	83 c4 10             	add    $0x10,%esp
}
80103f98:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f9b:	89 f0                	mov    %esi,%eax
80103f9d:	5b                   	pop    %ebx
80103f9e:	5e                   	pop    %esi
80103f9f:	5d                   	pop    %ebp
80103fa0:	c3                   	ret    
      release(&ptable.lock);
80103fa1:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fa4:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fa9:	68 c0 5f 17 80       	push   $0x80175fc0
80103fae:	e8 9d 0d 00 00       	call   80104d50 <release>
      return -1;
80103fb3:	83 c4 10             	add    $0x10,%esp
80103fb6:	eb e0                	jmp    80103f98 <wait+0xd8>
80103fb8:	90                   	nop
80103fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103fc0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	53                   	push   %ebx
80103fc4:	83 ec 10             	sub    $0x10,%esp
80103fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103fca:	68 c0 5f 17 80       	push   $0x80175fc0
80103fcf:	e8 bc 0c 00 00       	call   80104c90 <acquire>
80103fd4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fd7:	b8 f4 5f 17 80       	mov    $0x80175ff4,%eax
80103fdc:	eb 0e                	jmp    80103fec <wakeup+0x2c>
80103fde:	66 90                	xchg   %ax,%ax
80103fe0:	05 80 10 00 00       	add    $0x1080,%eax
80103fe5:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
80103fea:	73 1e                	jae    8010400a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
80103fec:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ff0:	75 ee                	jne    80103fe0 <wakeup+0x20>
80103ff2:	3b 58 20             	cmp    0x20(%eax),%ebx
80103ff5:	75 e9                	jne    80103fe0 <wakeup+0x20>
      p->state = RUNNABLE;
80103ff7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ffe:	05 80 10 00 00       	add    $0x1080,%eax
80104003:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
80104008:	72 e2                	jb     80103fec <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010400a:	c7 45 08 c0 5f 17 80 	movl   $0x80175fc0,0x8(%ebp)
}
80104011:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104014:	c9                   	leave  
  release(&ptable.lock);
80104015:	e9 36 0d 00 00       	jmp    80104d50 <release>
8010401a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104020 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 10             	sub    $0x10,%esp
80104027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010402a:	68 c0 5f 17 80       	push   $0x80175fc0
8010402f:	e8 5c 0c 00 00       	call   80104c90 <acquire>
80104034:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104037:	b8 f4 5f 17 80       	mov    $0x80175ff4,%eax
8010403c:	eb 0e                	jmp    8010404c <kill+0x2c>
8010403e:	66 90                	xchg   %ax,%ax
80104040:	05 80 10 00 00       	add    $0x1080,%eax
80104045:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
8010404a:	73 34                	jae    80104080 <kill+0x60>
    if(p->pid == pid){
8010404c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010404f:	75 ef                	jne    80104040 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104051:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104055:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010405c:	75 07                	jne    80104065 <kill+0x45>
        p->state = RUNNABLE;
8010405e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104065:	83 ec 0c             	sub    $0xc,%esp
80104068:	68 c0 5f 17 80       	push   $0x80175fc0
8010406d:	e8 de 0c 00 00       	call   80104d50 <release>
      return 0;
80104072:	83 c4 10             	add    $0x10,%esp
80104075:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104077:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010407a:	c9                   	leave  
8010407b:	c3                   	ret    
8010407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104080:	83 ec 0c             	sub    $0xc,%esp
80104083:	68 c0 5f 17 80       	push   $0x80175fc0
80104088:	e8 c3 0c 00 00       	call   80104d50 <release>
  return -1;
8010408d:	83 c4 10             	add    $0x10,%esp
80104090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104095:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104098:	c9                   	leave  
80104099:	c3                   	ret    
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	57                   	push   %edi
801040a4:	56                   	push   %esi
801040a5:	53                   	push   %ebx
801040a6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040a9:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
{
801040ae:	83 ec 3c             	sub    $0x3c,%esp
801040b1:	eb 27                	jmp    801040da <procdump+0x3a>
801040b3:	90                   	nop
801040b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	68 87 8d 10 80       	push   $0x80108d87
801040c0:	e8 9b c5 ff ff       	call   80100660 <cprintf>
801040c5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c8:	81 c3 80 10 00 00    	add    $0x1080,%ebx
801040ce:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
801040d4:	0f 83 96 00 00 00    	jae    80104170 <procdump+0xd0>
    if(p->state == UNUSED)
801040da:	8b 43 0c             	mov    0xc(%ebx),%eax
801040dd:	85 c0                	test   %eax,%eax
801040df:	74 e7                	je     801040c8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040e1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801040e4:	ba 50 8d 10 80       	mov    $0x80108d50,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040e9:	77 11                	ja     801040fc <procdump+0x5c>
801040eb:	8b 14 85 e0 8e 10 80 	mov    -0x7fef7120(,%eax,4),%edx
      state = "???";
801040f2:	b8 50 8d 10 80       	mov    $0x80108d50,%eax
801040f7:	85 d2                	test   %edx,%edx
801040f9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040fc:	8d 83 2c 10 00 00    	lea    0x102c(%ebx),%eax
80104102:	50                   	push   %eax
80104103:	52                   	push   %edx
80104104:	ff 73 10             	pushl  0x10(%ebx)
80104107:	68 54 8d 10 80       	push   $0x80108d54
8010410c:	e8 4f c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104111:	83 c4 10             	add    $0x10,%esp
80104114:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104118:	75 9e                	jne    801040b8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010411a:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010411d:	83 ec 08             	sub    $0x8,%esp
80104120:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104123:	50                   	push   %eax
80104124:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104127:	8b 40 0c             	mov    0xc(%eax),%eax
8010412a:	83 c0 08             	add    $0x8,%eax
8010412d:	50                   	push   %eax
8010412e:	e8 3d 0a 00 00       	call   80104b70 <getcallerpcs>
80104133:	83 c4 10             	add    $0x10,%esp
80104136:	8d 76 00             	lea    0x0(%esi),%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
80104140:	8b 17                	mov    (%edi),%edx
80104142:	85 d2                	test   %edx,%edx
80104144:	0f 84 6e ff ff ff    	je     801040b8 <procdump+0x18>
        cprintf(" %p", pc[i]);
8010414a:	83 ec 08             	sub    $0x8,%esp
8010414d:	83 c7 04             	add    $0x4,%edi
80104150:	52                   	push   %edx
80104151:	68 81 87 10 80       	push   $0x80108781
80104156:	e8 05 c5 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010415b:	83 c4 10             	add    $0x10,%esp
8010415e:	39 fe                	cmp    %edi,%esi
80104160:	75 de                	jne    80104140 <procdump+0xa0>
80104162:	e9 51 ff ff ff       	jmp    801040b8 <procdump+0x18>
80104167:	89 f6                	mov    %esi,%esi
80104169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104170:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104173:	5b                   	pop    %ebx
80104174:	5e                   	pop    %esi
80104175:	5f                   	pop    %edi
80104176:	5d                   	pop    %ebp
80104177:	c3                   	ret    
80104178:	90                   	nop
80104179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104180 <print_ps>:
///////A D D E D//////////////


int
print_ps(void)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	56                   	push   %esi
80104184:	53                   	push   %ebx
  pushcli();
80104185:	e8 36 0a 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
8010418a:	e8 91 f5 ff ff       	call   80103720 <mycpu>
  p = c->proc;
8010418f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104195:	e8 66 0a 00 00       	call   80104c00 <popcli>
  // container_id
  struct proc *p = myproc();
  int my_cid  = p->in_container_id;

  struct proc *listp;
  acquire(&ptable.lock);
8010419a:	83 ec 0c             	sub    $0xc,%esp
  int my_cid  = p->in_container_id;
8010419d:	8b b3 7c 10 00 00    	mov    0x107c(%ebx),%esi
  acquire(&ptable.lock);
801041a3:	68 c0 5f 17 80       	push   $0x80175fc0
  for(listp = ptable.proc; listp < &ptable.proc[NPROC]; listp++){
801041a8:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
  acquire(&ptable.lock);
801041ad:	e8 de 0a 00 00       	call   80104c90 <acquire>
801041b2:	83 c4 10             	add    $0x10,%esp
801041b5:	eb 17                	jmp    801041ce <print_ps+0x4e>
801041b7:	89 f6                	mov    %esi,%esi
801041b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(listp = ptable.proc; listp < &ptable.proc[NPROC]; listp++){
801041c0:	81 c3 80 10 00 00    	add    $0x1080,%ebx
801041c6:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
801041cc:	73 3a                	jae    80104208 <print_ps+0x88>
      if (listp->in_container_id == my_cid){
801041ce:	39 b3 7c 10 00 00    	cmp    %esi,0x107c(%ebx)
801041d4:	75 ea                	jne    801041c0 <print_ps+0x40>
        if(listp->state != UNUSED)
801041d6:	8b 43 0c             	mov    0xc(%ebx),%eax
801041d9:	85 c0                	test   %eax,%eax
801041db:	74 e3                	je     801041c0 <print_ps+0x40>
        {
          cprintf("pid:%d name:%s\n",listp->pid,listp->name);
801041dd:	8d 83 2c 10 00 00    	lea    0x102c(%ebx),%eax
801041e3:	83 ec 04             	sub    $0x4,%esp
  for(listp = ptable.proc; listp < &ptable.proc[NPROC]; listp++){
801041e6:	81 c3 80 10 00 00    	add    $0x1080,%ebx
          cprintf("pid:%d name:%s\n",listp->pid,listp->name);
801041ec:	50                   	push   %eax
801041ed:	ff b3 90 ef ff ff    	pushl  -0x1070(%ebx)
801041f3:	68 5d 8d 10 80       	push   $0x80108d5d
801041f8:	e8 63 c4 ff ff       	call   80100660 <cprintf>
801041fd:	83 c4 10             	add    $0x10,%esp
  for(listp = ptable.proc; listp < &ptable.proc[NPROC]; listp++){
80104200:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
80104206:	72 c6                	jb     801041ce <print_ps+0x4e>
        }
      }
    
  }
  release(&ptable.lock);
80104208:	83 ec 0c             	sub    $0xc,%esp
8010420b:	68 c0 5f 17 80       	push   $0x80175fc0
80104210:	e8 3b 0b 00 00       	call   80104d50 <release>
  return 0;
}
80104215:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104218:	31 c0                	xor    %eax,%eax
8010421a:	5b                   	pop    %ebx
8010421b:	5e                   	pop    %esi
8010421c:	5d                   	pop    %ebp
8010421d:	c3                   	ret    
8010421e:	66 90                	xchg   %ax,%ax

80104220 <send_msg>:



int
send_msg(int sender_id,int recv_id,void * msg)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	57                   	push   %edi
80104224:	56                   	push   %esi
80104225:	53                   	push   %ebx
80104226:	83 ec 1c             	sub    $0x1c,%esp
      // }
      // cprintf("\nMessage_Buffers is filled with the message\n");

  // ////////////////////////////////////////////CHECK IF INITIALIZED//////
  while(1){
    if (init_flag==0){
80104229:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
8010422e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104231:	8b 75 10             	mov    0x10(%ebp),%esi
    if (init_flag==0){
80104234:	85 c0                	test   %eax,%eax
80104236:	74 11                	je     80104249 <send_msg+0x29>
80104238:	90                   	nop
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        Wait_Queue[i] = -1;
        Sender_Queue[i] = -1;
      }
      init_flag =1;
    }
    if (init_flag==1){
80104240:	83 f8 01             	cmp    $0x1,%eax
80104243:	74 49                	je     8010428e <send_msg+0x6e>
    if (init_flag==0){
80104245:	85 c0                	test   %eax,%eax
80104247:	75 f7                	jne    80104240 <send_msg+0x20>
80104249:	31 ff                	xor    %edi,%edi
8010424b:	90                   	nop
8010424c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        Message_Buffers[i] = (char *) kalloc();
80104250:	e8 db e1 ff ff       	call   80102430 <kalloc>
80104255:	83 c7 04             	add    $0x4,%edi
80104258:	89 87 fc 7f 1b 80    	mov    %eax,-0x7fe48004(%edi)
        Receive_Queue[i]= -1;
8010425e:	c7 87 7c 4f 13 80 ff 	movl   $0xffffffff,-0x7fecb084(%edi)
80104265:	ff ff ff 
        Wait_Queue[i] = -1;
80104268:	c7 87 7c 4f 11 80 ff 	movl   $0xffffffff,-0x7feeb084(%edi)
8010426f:	ff ff ff 
        Sender_Queue[i] = -1;
80104272:	c7 87 bc 5f 15 80 ff 	movl   $0xffffffff,-0x7feaa044(%edi)
80104279:	ff ff ff 
      for (int i = 0; i < MSGSIZE*NPROC*NPROC; ++i)
8010427c:	81 ff 00 00 02 00    	cmp    $0x20000,%edi
80104282:	75 cc                	jne    80104250 <send_msg+0x30>
      init_flag =1;
80104284:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
8010428b:	00 00 00 


  char * message = (char *) msg;

  int i;
  int start = recv_id*NPROC*MSGSIZE + sender_id*MSGSIZE;
8010428e:	89 da                	mov    %ebx,%edx
80104290:	c1 e2 06             	shl    $0x6,%edx
80104293:	03 55 08             	add    0x8(%ebp),%edx
80104296:	c1 e2 03             	shl    $0x3,%edx

  for (i = start; i < start + MSGSIZE; ++i)
  {
    if (Receive_Queue[i]==-1){
80104299:	83 3c 95 80 4f 13 80 	cmpl   $0xffffffff,-0x7fecb080(,%edx,4)
801042a0:	ff 
  for (i = start; i < start + MSGSIZE; ++i)
801042a1:	8d 42 07             	lea    0x7(%edx),%eax
801042a4:	89 d7                	mov    %edx,%edi
    if (Receive_Queue[i]==-1){
801042a6:	75 12                	jne    801042ba <send_msg+0x9a>
801042a8:	eb 17                	jmp    801042c1 <send_msg+0xa1>
801042aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042b0:	83 3c bd 80 4f 13 80 	cmpl   $0xffffffff,-0x7fecb080(,%edi,4)
801042b7:	ff 
801042b8:	74 07                	je     801042c1 <send_msg+0xa1>
  for (i = start; i < start + MSGSIZE; ++i)
801042ba:	83 c7 01             	add    $0x1,%edi
801042bd:	39 f8                	cmp    %edi,%eax
801042bf:	7d ef                	jge    801042b0 <send_msg+0x90>
      break;
    }
  }
  if (i==MSGSIZE*NPROC*NPROC){
801042c1:	81 ff 00 80 00 00    	cmp    $0x8000,%edi
801042c7:	0f 84 f1 00 00 00    	je     801043be <send_msg+0x19e>
  for (i = start; i < start + MSGSIZE; ++i)
801042cd:	31 c0                	xor    %eax,%eax
801042cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801042d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("Error Message_Buffer is Overflowing!!!! \n");
  }

  for (int j = 0; j < MSGSIZE; ++j)
  {
    *(Message_Buffers[i]+j) = *(message+j);
801042d8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801042dc:	8b 0c bd 00 80 1b 80 	mov    -0x7fe48000(,%edi,4),%ecx
801042e3:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (int j = 0; j < MSGSIZE; ++j)
801042e6:	83 c0 01             	add    $0x1,%eax
801042e9:	83 f8 08             	cmp    $0x8,%eax
801042ec:	75 ea                	jne    801042d8 <send_msg+0xb8>
  }

  cprintf("Sending message in Message_Buffer[%d] =  %d \n",i,*((int*)Message_Buffers[i]));
801042ee:	8b 04 bd 00 80 1b 80 	mov    -0x7fe48000(,%edi,4),%eax
801042f5:	83 ec 04             	sub    $0x4,%esp
801042f8:	ff 30                	pushl  (%eax)
801042fa:	57                   	push   %edi
801042fb:	68 50 8e 10 80       	push   $0x80108e50
80104300:	e8 5b c3 ff ff       	call   80100660 <cprintf>
  // cprintf("Message_Buffer[i] is : %s \n",Message_Buffers[i]); 
   
  Receive_Queue[i] = recv_id;
  Sender_Queue[i]  = sender_id;

  for (i = start; i < MSGSIZE*NPROC + start; ++i)
80104305:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  {
    if (Wait_Queue[i]==recv_id){
80104308:	83 c4 10             	add    $0x10,%esp
  Sender_Queue[i]  = sender_id;
8010430b:	8b 45 08             	mov    0x8(%ebp),%eax
  Receive_Queue[i] = recv_id;
8010430e:	89 1c bd 80 4f 13 80 	mov    %ebx,-0x7fecb080(,%edi,4)
    if (Wait_Queue[i]==recv_id){
80104315:	39 1c 95 80 4f 11 80 	cmp    %ebx,-0x7feeb080(,%edx,4)
  Sender_Queue[i]  = sender_id;
8010431c:	89 04 bd c0 5f 15 80 	mov    %eax,-0x7feaa040(,%edi,4)
  for (i = start; i < MSGSIZE*NPROC + start; ++i)
80104323:	8d 82 ff 01 00 00    	lea    0x1ff(%edx),%eax
    if (Wait_Queue[i]==recv_id){
80104329:	75 0e                	jne    80104339 <send_msg+0x119>
8010432b:	eb 13                	jmp    80104340 <send_msg+0x120>
8010432d:	8d 76 00             	lea    0x0(%esi),%esi
80104330:	39 1c 95 80 4f 11 80 	cmp    %ebx,-0x7feeb080(,%edx,4)
80104337:	74 07                	je     80104340 <send_msg+0x120>
  for (i = start; i < MSGSIZE*NPROC + start; ++i)
80104339:	83 c2 01             	add    $0x1,%edx
8010433c:	39 d0                	cmp    %edx,%eax
8010433e:	7d f0                	jge    80104330 <send_msg+0x110>
      break;
    }
  }

  struct proc * p ;
  if(i<MSGSIZE*NPROC*NPROC){
80104340:	81 fa ff 7f 00 00    	cmp    $0x7fff,%edx
80104346:	7e 0a                	jle    80104352 <send_msg+0x132>
  
  // cprintf("\nMessage_Buffers is filled with the message\n");
  return 0;


}
80104348:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010434b:	31 c0                	xor    %eax,%eax
8010434d:	5b                   	pop    %ebx
8010434e:	5e                   	pop    %esi
8010434f:	5f                   	pop    %edi
80104350:	5d                   	pop    %ebp
80104351:	c3                   	ret    
    acquire(&ptable.lock);
80104352:	83 ec 0c             	sub    $0xc,%esp
    int wait_pid = Wait_Queue[i];
80104355:	8b 1c 95 80 4f 11 80 	mov    -0x7feeb080(,%edx,4),%ebx
    Wait_Queue[i]=-1;
8010435c:	c7 04 95 80 4f 11 80 	movl   $0xffffffff,-0x7feeb080(,%edx,4)
80104363:	ff ff ff ff 
    acquire(&ptable.lock);
80104367:	68 c0 5f 17 80       	push   $0x80175fc0
8010436c:	e8 1f 09 00 00       	call   80104c90 <acquire>
80104371:	83 c4 10             	add    $0x10,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104374:	b8 f4 5f 17 80       	mov    $0x80175ff4,%eax
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(p->state != UNUSED){  
80104380:	8b 50 0c             	mov    0xc(%eax),%edx
80104383:	85 d2                	test   %edx,%edx
80104385:	74 11                	je     80104398 <send_msg+0x178>
          if(p->pid == wait_pid){
80104387:	39 58 10             	cmp    %ebx,0x10(%eax)
8010438a:	75 0c                	jne    80104398 <send_msg+0x178>
            p->state  = RUNNABLE;
8010438c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104393:	90                   	nop
80104394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104398:	05 80 10 00 00       	add    $0x1080,%eax
8010439d:	3d f4 7f 1b 80       	cmp    $0x801b7ff4,%eax
801043a2:	72 dc                	jb     80104380 <send_msg+0x160>
    release(&ptable.lock);
801043a4:	83 ec 0c             	sub    $0xc,%esp
801043a7:	68 c0 5f 17 80       	push   $0x80175fc0
801043ac:	e8 9f 09 00 00       	call   80104d50 <release>
801043b1:	83 c4 10             	add    $0x10,%esp
}
801043b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043b7:	31 c0                	xor    %eax,%eax
801043b9:	5b                   	pop    %ebx
801043ba:	5e                   	pop    %esi
801043bb:	5f                   	pop    %edi
801043bc:	5d                   	pop    %ebp
801043bd:	c3                   	ret    
    cprintf("Error Message_Buffer is Overflowing!!!! \n");
801043be:	83 ec 0c             	sub    $0xc,%esp
801043c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801043c4:	68 24 8e 10 80       	push   $0x80108e24
801043c9:	e8 92 c2 ff ff       	call   80100660 <cprintf>
801043ce:	83 c4 10             	add    $0x10,%esp
801043d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043d4:	e9 f4 fe ff ff       	jmp    801042cd <send_msg+0xad>
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043e0 <recv_msg>:



char *
recv_msg(int * myid,int * from,void * mesg)
{ 
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	57                   	push   %edi
801043e4:	56                   	push   %esi
801043e5:	53                   	push   %ebx
801043e6:	83 ec 1c             	sub    $0x1c,%esp

  
  // msg is char *
  while(1){
    if (init_flag==0){
801043e9:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
801043ee:	85 c0                	test   %eax,%eax
801043f0:	74 09                	je     801043fb <recv_msg+0x1b>
        Wait_Queue[i] = -1;
        Sender_Queue[i] = -1;
      }
      init_flag =1;
    }
    if (init_flag==1){
801043f2:	83 f8 01             	cmp    $0x1,%eax
801043f5:	74 47                	je     8010443e <recv_msg+0x5e>
    if (init_flag==0){
801043f7:	85 c0                	test   %eax,%eax
801043f9:	75 f7                	jne    801043f2 <recv_msg+0x12>
801043fb:	31 db                	xor    %ebx,%ebx
801043fd:	8d 76 00             	lea    0x0(%esi),%esi
        Message_Buffers[i] = (char *) kalloc();
80104400:	e8 2b e0 ff ff       	call   80102430 <kalloc>
80104405:	83 c3 04             	add    $0x4,%ebx
80104408:	89 83 fc 7f 1b 80    	mov    %eax,-0x7fe48004(%ebx)
        Receive_Queue[i]= -1;
8010440e:	c7 83 7c 4f 13 80 ff 	movl   $0xffffffff,-0x7fecb084(%ebx)
80104415:	ff ff ff 
        Wait_Queue[i] = -1;
80104418:	c7 83 7c 4f 11 80 ff 	movl   $0xffffffff,-0x7feeb084(%ebx)
8010441f:	ff ff ff 
        Sender_Queue[i] = -1;
80104422:	c7 83 bc 5f 15 80 ff 	movl   $0xffffffff,-0x7feaa044(%ebx)
80104429:	ff ff ff 
      for (int i = 0; i < MSGSIZE*NPROC*NPROC; ++i)
8010442c:	81 fb 00 00 02 00    	cmp    $0x20000,%ebx
80104432:	75 cc                	jne    80104400 <recv_msg+0x20>
      init_flag =1;
80104434:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
8010443b:	00 00 00 
  pushcli();
8010443e:	e8 7d 07 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80104443:	e8 d8 f2 ff ff       	call   80103720 <mycpu>
  p = c->proc;
80104448:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010444e:	e8 ad 07 00 00       	call   80104c00 <popcli>
  char * msg = (char *) mesg;
  struct proc * p ;
  p = myproc();
  int pid = p->pid;
  int i;
         cprintf("Receiving message pid[%d] \n",pid);
80104453:	83 ec 08             	sub    $0x8,%esp
  int pid = p->pid;
80104456:	8b 7b 10             	mov    0x10(%ebx),%edi
         cprintf("Receiving message pid[%d] \n",pid);
80104459:	57                   	push   %edi
8010445a:	68 6d 8d 10 80       	push   $0x80108d6d
8010445f:	e8 fc c1 ff ff       	call   80100660 <cprintf>
  // {
  //   // cprintf(" \n INside Recv %d: %s ",Receive_Queue[i], Message_Buffers[i]);
  // }
         // cprintf("Receiving message pid[%d] \n",pid);

    int start = pid*MSGSIZE*NPROC;
80104464:	89 f8                	mov    %edi,%eax
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
80104466:	83 c4 10             	add    $0x10,%esp
    int start = pid*MSGSIZE*NPROC;
80104469:	c1 e0 09             	shl    $0x9,%eax
8010446c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
8010446f:	8d b0 ff 01 00 00    	lea    0x1ff(%eax),%esi
    {

      if (Receive_Queue[i]==pid){
80104475:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104478:	39 3c 85 80 4f 13 80 	cmp    %edi,-0x7fecb080(,%eax,4)
8010447f:	0f 84 d3 00 00 00    	je     80104558 <recv_msg+0x178>
80104485:	8d 76 00             	lea    0x0(%esi),%esi
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
80104488:	89 c3                	mov    %eax,%ebx
8010448a:	eb 11                	jmp    8010449d <recv_msg+0xbd>
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (Receive_Queue[i]==pid){
80104490:	39 3c 9d 80 4f 13 80 	cmp    %edi,-0x7fecb080(,%ebx,4)
80104497:	0f 84 be 00 00 00    	je     8010455b <recv_msg+0x17b>
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
8010449d:	83 c3 01             	add    $0x1,%ebx
801044a0:	39 de                	cmp    %ebx,%esi
801044a2:	7d ec                	jge    80104490 <recv_msg+0xb0>
        break;
      }
    }
    // cprintf("Receiving message in Message_Buffer[%d] \n",i);

    if (i<MSGSIZE*NPROC*NPROC){
801044a4:	81 fb ff 7f 00 00    	cmp    $0x7fff,%ebx
801044aa:	0f 8e c8 00 00 00    	jle    80104578 <recv_msg+0x198>
      break;
    }
    else{
      // BLock the current process

      acquire(&ptable.lock);
801044b0:	83 ec 0c             	sub    $0xc,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044b3:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
      acquire(&ptable.lock);
801044b8:	68 c0 5f 17 80       	push   $0x80175fc0
801044bd:	e8 ce 07 00 00       	call   80104c90 <acquire>
801044c2:	83 c4 10             	add    $0x10,%esp
801044c5:	eb 17                	jmp    801044de <recv_msg+0xfe>
801044c7:	89 f6                	mov    %esi,%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044d0:	81 c3 80 10 00 00    	add    $0x1080,%ebx
801044d6:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
801044dc:	73 5a                	jae    80104538 <recv_msg+0x158>
        if(p->state!= UNUSED){  
801044de:	8b 43 0c             	mov    0xc(%ebx),%eax
801044e1:	85 c0                	test   %eax,%eax
801044e3:	74 eb                	je     801044d0 <recv_msg+0xf0>
          if(p->pid == pid){
801044e5:	39 7b 10             	cmp    %edi,0x10(%ebx)
801044e8:	75 e6                	jne    801044d0 <recv_msg+0xf0>
            p->state  = SLEEPING;
           // Wake process from sleep if necessary.

          for (i = start; i < MSGSIZE*NPROC+start; ++i)
          {
                if (Wait_Queue[i]==-1){
801044ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
            p->state  = SLEEPING;
801044ed:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
                if (Wait_Queue[i]==-1){
801044f4:	83 3c 85 80 4f 11 80 	cmpl   $0xffffffff,-0x7feeb080(,%eax,4)
801044fb:	ff 
801044fc:	75 14                	jne    80104512 <recv_msg+0x132>
801044fe:	e9 ce 00 00 00       	jmp    801045d1 <recv_msg+0x1f1>
80104503:	90                   	nop
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104508:	83 3c 85 80 4f 11 80 	cmpl   $0xffffffff,-0x7feeb080(,%eax,4)
8010450f:	ff 
80104510:	74 07                	je     80104519 <recv_msg+0x139>
          for (i = start; i < MSGSIZE*NPROC+start; ++i)
80104512:	83 c0 01             	add    $0x1,%eax
80104515:	39 c6                	cmp    %eax,%esi
80104517:	7d ef                	jge    80104508 <recv_msg+0x128>
                  break;
                 }
          }
            // Inser the process in the wait queue;
          Wait_Queue[i] = pid;
80104519:	89 3c 85 80 4f 11 80 	mov    %edi,-0x7feeb080(,%eax,4)
          sched();
80104520:	e8 bb f6 ff ff       	call   80103be0 <sched>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104525:	81 c3 80 10 00 00    	add    $0x1080,%ebx
8010452b:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
80104531:	72 ab                	jb     801044de <recv_msg+0xfe>
80104533:	90                   	nop
80104534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
           
          }
        }
  
      }
      release(&ptable.lock);
80104538:	83 ec 0c             	sub    $0xc,%esp
8010453b:	68 c0 5f 17 80       	push   $0x80175fc0
80104540:	e8 0b 08 00 00       	call   80104d50 <release>
      if (Receive_Queue[i]==pid){
80104545:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  while(1){  
80104548:	83 c4 10             	add    $0x10,%esp
      if (Receive_Queue[i]==pid){
8010454b:	39 3c 85 80 4f 13 80 	cmp    %edi,-0x7fecb080(,%eax,4)
80104552:	0f 85 30 ff ff ff    	jne    80104488 <recv_msg+0xa8>
    for (i = start; i < MSGSIZE*NPROC+start; ++i)
80104558:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
         cprintf("Receiving message in Message_Buffer[R %d] \n",i);
8010455b:	83 ec 08             	sub    $0x8,%esp
8010455e:	53                   	push   %ebx
8010455f:	68 80 8e 10 80       	push   $0x80108e80
80104564:	e8 f7 c0 ff ff       	call   80100660 <cprintf>
        break;
80104569:	83 c4 10             	add    $0x10,%esp
    if (i<MSGSIZE*NPROC*NPROC){
8010456c:	81 fb ff 7f 00 00    	cmp    $0x7fff,%ebx
80104572:	0f 8f 38 ff ff ff    	jg     801044b0 <recv_msg+0xd0>
    }
  }
   // cprintf("Received Message before %d:  %s",pid,Message_Buffers[i]);
  // copy the msg 
  for (int j = 0; j < MSGSIZE; ++j)
80104578:	31 c0                	xor    %eax,%eax
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    *(msg+j) = *(Message_Buffers[i]+j);
80104580:	8b 14 9d 00 80 1b 80 	mov    -0x7fe48000(,%ebx,4),%edx
80104587:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010458a:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
8010458e:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (int j = 0; j < MSGSIZE; ++j)
80104591:	83 c0 01             	add    $0x1,%eax
80104594:	83 f8 08             	cmp    $0x8,%eax
80104597:	75 e7                	jne    80104580 <recv_msg+0x1a0>
  }
  // I have received the message clear the the Receive Queue
  *myid = Receive_Queue[i];
80104599:	8b 14 9d 80 4f 13 80 	mov    -0x7fecb080(,%ebx,4),%edx
801045a0:	8b 45 08             	mov    0x8(%ebp),%eax
801045a3:	89 10                	mov    %edx,(%eax)
  *from = Sender_Queue[i];
801045a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801045a8:	8b 14 9d c0 5f 15 80 	mov    -0x7feaa040(,%ebx,4),%edx
801045af:	89 10                	mov    %edx,(%eax)

  Receive_Queue[i] = -1;
801045b1:	c7 04 9d 80 4f 13 80 	movl   $0xffffffff,-0x7fecb080(,%ebx,4)
801045b8:	ff ff ff ff 
  Sender_Queue[i] = -1;
  // cprintf("Received Message %d:  %s",pid,msg);
  return msg;
}
801045bc:	89 c8                	mov    %ecx,%eax
  Sender_Queue[i] = -1;
801045be:	c7 04 9d c0 5f 15 80 	movl   $0xffffffff,-0x7feaa040(,%ebx,4)
801045c5:	ff ff ff ff 
}
801045c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045cc:	5b                   	pop    %ebx
801045cd:	5e                   	pop    %esi
801045ce:	5f                   	pop    %edi
801045cf:	5d                   	pop    %ebp
801045d0:	c3                   	ret    
          for (i = start; i < MSGSIZE*NPROC+start; ++i)
801045d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
          Wait_Queue[i] = pid;
801045d4:	89 3c 85 80 4f 11 80 	mov    %edi,-0x7feeb080(,%eax,4)
          sched();
801045db:	e8 00 f6 ff ff       	call   80103be0 <sched>
801045e0:	e9 40 ff ff ff       	jmp    80104525 <recv_msg+0x145>
801045e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045f0 <multicast_msg>:

void
multicast_msg(char * msg, int * grpid,int grpsiz){
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	57                   	push   %edi
801045f4:	56                   	push   %esi
801045f5:	53                   	push   %ebx

  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f6:	bb f4 5f 17 80       	mov    $0x80175ff4,%ebx
multicast_msg(char * msg, int * grpid,int grpsiz){
801045fb:	83 ec 28             	sub    $0x28,%esp
801045fe:	8b 45 10             	mov    0x10(%ebp),%eax
80104601:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&ptable.lock);
80104604:	68 c0 5f 17 80       	push   $0x80175fc0
multicast_msg(char * msg, int * grpid,int grpsiz){
80104609:	8b 75 0c             	mov    0xc(%ebp),%esi
8010460c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  acquire(&ptable.lock);
8010460f:	e8 7c 06 00 00       	call   80104c90 <acquire>
80104614:	83 c4 10             	add    $0x10,%esp
80104617:	89 f6                	mov    %esi,%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    int i;
    
    // is this process in grpid
    for (i = 0; i < grpsiz; ++i)
80104620:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80104623:	83 f9 00             	cmp    $0x0,%ecx
80104626:	7e 40                	jle    80104668 <multicast_msg+0x78>
      {
        if (grpid[i]==p->pid){
80104628:	8b 53 10             	mov    0x10(%ebx),%edx
8010462b:	39 16                	cmp    %edx,(%esi)
8010462d:	74 41                	je     80104670 <multicast_msg+0x80>
    for (i = 0; i < grpsiz; ++i)
8010462f:	31 c0                	xor    %eax,%eax
80104631:	eb 0a                	jmp    8010463d <multicast_msg+0x4d>
80104633:	90                   	nop
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (grpid[i]==p->pid){
80104638:	39 14 86             	cmp    %edx,(%esi,%eax,4)
8010463b:	74 33                	je     80104670 <multicast_msg+0x80>
    for (i = 0; i < grpsiz; ++i)
8010463d:	83 c0 01             	add    $0x1,%eax
80104640:	39 c1                	cmp    %eax,%ecx
80104642:	75 f4                	jne    80104638 <multicast_msg+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104644:	81 c3 80 10 00 00    	add    $0x1080,%ebx
8010464a:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
80104650:	72 ce                	jb     80104620 <multicast_msg+0x30>
  }



  }
  release(&ptable.lock);
80104652:	c7 45 08 c0 5f 17 80 	movl   $0x80175fc0,0x8(%ebp)

  return ;
} 
80104659:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010465c:	5b                   	pop    %ebx
8010465d:	5e                   	pop    %esi
8010465e:	5f                   	pop    %edi
8010465f:	5d                   	pop    %ebp
  release(&ptable.lock);
80104660:	e9 eb 06 00 00       	jmp    80104d50 <release>
80104665:	8d 76 00             	lea    0x0(%esi),%esi
    if (i==grpsiz){
80104668:	74 da                	je     80104644 <multicast_msg+0x54>
8010466a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if (p->received_buffer[i] == -1){
80104670:	83 bb 5c 10 00 00 ff 	cmpl   $0xffffffff,0x105c(%ebx)
80104677:	74 6c                	je     801046e5 <multicast_msg+0xf5>
    for (i = 0; i < MSGSIZE; ++i)
80104679:	ba 01 00 00 00       	mov    $0x1,%edx
      if (p->received_buffer[i] == -1){
8010467e:	83 bc 93 5c 10 00 00 	cmpl   $0xffffffff,0x105c(%ebx,%edx,4)
80104685:	ff 
80104686:	74 21                	je     801046a9 <multicast_msg+0xb9>
    for (i = 0; i < MSGSIZE; ++i)
80104688:	83 c2 01             	add    $0x1,%edx
8010468b:	83 fa 08             	cmp    $0x8,%edx
8010468e:	75 ee                	jne    8010467e <multicast_msg+0x8e>
      cprintf("The message_buffer of Process %d is overflowing.!!\n",p->pid);
80104690:	83 ec 08             	sub    $0x8,%esp
80104693:	ff 73 10             	pushl  0x10(%ebx)
80104696:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104699:	68 ac 8e 10 80       	push   $0x80108eac
8010469e:	e8 bd bf ff ff       	call   80100660 <cprintf>
801046a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046a6:	83 c4 10             	add    $0x10,%esp
801046a9:	8d 8a 0c 04 00 00    	lea    0x40c(%edx),%ecx
      if (p->received_buffer[i] == -1){
801046af:	31 c0                	xor    %eax,%eax
801046b1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *(p->message_buffer[i]+j) = *(msg+j) ;
801046b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801046bb:	8b 54 8b 0c          	mov    0xc(%ebx,%ecx,4),%edx
801046bf:	0f b6 0c 07          	movzbl (%edi,%eax,1),%ecx
801046c3:	88 0c 02             	mov    %cl,(%edx,%eax,1)
  for (int j = 0; j < MSGSIZE; ++j)
801046c6:	83 c0 01             	add    $0x1,%eax
801046c9:	83 f8 08             	cmp    $0x8,%eax
801046cc:	75 ea                	jne    801046b8 <multicast_msg+0xc8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046ce:	81 c3 80 10 00 00    	add    $0x1080,%ebx
801046d4:	81 fb f4 7f 1b 80    	cmp    $0x801b7ff4,%ebx
801046da:	0f 82 40 ff ff ff    	jb     80104620 <multicast_msg+0x30>
801046e0:	e9 6d ff ff ff       	jmp    80104652 <multicast_msg+0x62>
      if (p->received_buffer[i] == -1){
801046e5:	31 d2                	xor    %edx,%edx
801046e7:	eb c0                	jmp    801046a9 <multicast_msg+0xb9>
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046f0 <getNewCid>:



int
getNewCid(int container_id){
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	53                   	push   %ebx
801046f4:	83 ec 10             	sub    $0x10,%esp
801046f7:	8b 5d 08             	mov    0x8(%ebp),%ebx


  // int cid;
  acquire(&container_table.lock);
801046fa:	68 80 4f 15 80       	push   $0x80154f80
801046ff:	e8 8c 05 00 00       	call   80104c90 <acquire>

    if (!intialized_ctable){
80104704:	8b 15 b8 c5 10 80    	mov    0x8010c5b8,%edx
8010470a:	83 c4 10             	add    $0x10,%esp
8010470d:	b8 b4 4f 15 80       	mov    $0x80154fb4,%eax
80104712:	85 d2                	test   %edx,%edx
80104714:	75 49                	jne    8010475f <getNewCid+0x6f>
80104716:	8d 76 00             	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for (int j = 0;j< MAX_CONTAINERS ; j++){
        container_table.containers[j].cid= -1;
80104720:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
80104726:	83 c0 04             	add    $0x4,%eax
      for (int j = 0;j< MAX_CONTAINERS ; j++){
80104729:	3d b4 5f 15 80       	cmp    $0x80155fb4,%eax
8010472e:	75 f0                	jne    80104720 <getNewCid+0x30>
      }
      container_table.size = 0;
      intialized_ctable = 1;
80104730:	c7 05 b8 c5 10 80 01 	movl   $0x1,0x8010c5b8
80104737:	00 00 00 
8010473a:	b8 01 00 00 00       	mov    $0x1,%eax
    }


    container_table.containers[container_table.size].cid = container_id;
    container_table.size += 1;
  release(&container_table.lock);
8010473f:	83 ec 0c             	sub    $0xc,%esp
    container_table.containers[container_table.size].cid = container_id;
80104742:	89 1c 95 b4 4f 15 80 	mov    %ebx,-0x7feab04c(,%edx,4)
    container_table.size += 1;
80104749:	a3 b4 5f 15 80       	mov    %eax,0x80155fb4
  release(&container_table.lock);
8010474e:	68 80 4f 15 80       	push   $0x80154f80
80104753:	e8 f8 05 00 00       	call   80104d50 <release>

  return container_id;
}
80104758:	89 d8                	mov    %ebx,%eax
8010475a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010475d:	c9                   	leave  
8010475e:	c3                   	ret    
8010475f:	8b 15 b4 5f 15 80    	mov    0x80155fb4,%edx
80104765:	8d 42 01             	lea    0x1(%edx),%eax
80104768:	eb d5                	jmp    8010473f <getNewCid+0x4f>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104770 <destroyCid>:

int
destroyCid(int container_id){
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
80104775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  int flag = 0;
  acquire(&container_table.lock);
80104778:	83 ec 0c             	sub    $0xc,%esp
8010477b:	68 80 4f 15 80       	push   $0x80154f80
80104780:	e8 0b 05 00 00       	call   80104c90 <acquire>
      
      for(int i = 0 ;i< container_table.size ; i++)
80104785:	8b 15 b4 5f 15 80    	mov    0x80155fb4,%edx
8010478b:	83 c4 10             	add    $0x10,%esp
8010478e:	85 d2                	test   %edx,%edx
80104790:	7e 1e                	jle    801047b0 <destroyCid+0x40>
80104792:	31 c0                	xor    %eax,%eax
      {
        if (container_table.containers[i].cid==container_id){
80104794:	3b 1d b4 4f 15 80    	cmp    0x80154fb4,%ebx
8010479a:	75 0d                	jne    801047a9 <destroyCid+0x39>
8010479c:	eb 32                	jmp    801047d0 <destroyCid+0x60>
8010479e:	66 90                	xchg   %ax,%ax
801047a0:	39 1c 85 b4 4f 15 80 	cmp    %ebx,-0x7feab04c(,%eax,4)
801047a7:	74 27                	je     801047d0 <destroyCid+0x60>
      for(int i = 0 ;i< container_table.size ; i++)
801047a9:	83 c0 01             	add    $0x1,%eax
801047ac:	39 d0                	cmp    %edx,%eax
801047ae:	75 f0                	jne    801047a0 <destroyCid+0x30>
            container_table.size -= 1;
            flag =1;
            break;
        } 
      }
  release(&container_table.lock);
801047b0:	83 ec 0c             	sub    $0xc,%esp
801047b3:	68 80 4f 15 80       	push   $0x80154f80
801047b8:	e8 93 05 00 00       	call   80104d50 <release>
801047bd:	83 c4 10             	add    $0x10,%esp


  }

  return container_id;
}
801047c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
801047c3:	31 c0                	xor    %eax,%eax
}
801047c5:	5b                   	pop    %ebx
801047c6:	5e                   	pop    %esi
801047c7:	5d                   	pop    %ebp
801047c8:	c3                   	ret    
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for(int j= i ; j<(container_table.size-1);j++){
801047d0:	8d 4a ff             	lea    -0x1(%edx),%ecx
801047d3:	39 c8                	cmp    %ecx,%eax
801047d5:	7d 1e                	jge    801047f5 <destroyCid+0x85>
801047d7:	8d 04 85 80 4f 15 80 	lea    -0x7feab080(,%eax,4),%eax
801047de:	8d 34 95 7c 4f 15 80 	lea    -0x7feab084(,%edx,4),%esi
801047e5:	8d 76 00             	lea    0x0(%esi),%esi
              container_table.containers[j].cid = container_table.containers[j+1].cid ;
801047e8:	8b 50 38             	mov    0x38(%eax),%edx
801047eb:	83 c0 04             	add    $0x4,%eax
801047ee:	89 50 30             	mov    %edx,0x30(%eax)
            for(int j= i ; j<(container_table.size-1);j++){
801047f1:	39 f0                	cmp    %esi,%eax
801047f3:	75 f3                	jne    801047e8 <destroyCid+0x78>
  release(&container_table.lock);
801047f5:	83 ec 0c             	sub    $0xc,%esp
            container_table.containers[container_table.size-1].cid = -1;
801047f8:	c7 04 8d b4 4f 15 80 	movl   $0xffffffff,-0x7feab04c(,%ecx,4)
801047ff:	ff ff ff ff 
            container_table.size -= 1;
80104803:	89 0d b4 5f 15 80    	mov    %ecx,0x80155fb4
  release(&container_table.lock);
80104809:	68 80 4f 15 80       	push   $0x80154f80
8010480e:	e8 3d 05 00 00       	call   80104d50 <release>
    acquire(&ptable.lock);
80104813:	c7 04 24 c0 5f 17 80 	movl   $0x80175fc0,(%esp)
8010481a:	e8 71 04 00 00       	call   80104c90 <acquire>
8010481f:	83 c4 10             	add    $0x10,%esp
      for (listp=ptable.proc;listp<&ptable.proc[NPROC];listp++){
80104822:	ba f4 5f 17 80       	mov    $0x80175ff4,%edx
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if (listp->in_container_id==container_id){
80104830:	39 9a 7c 10 00 00    	cmp    %ebx,0x107c(%edx)
80104836:	75 0a                	jne    80104842 <destroyCid+0xd2>
          listp->in_container_id = -1;
80104838:	c7 82 7c 10 00 00 ff 	movl   $0xffffffff,0x107c(%edx)
8010483f:	ff ff ff 
      for (listp=ptable.proc;listp<&ptable.proc[NPROC];listp++){
80104842:	81 c2 80 10 00 00    	add    $0x1080,%edx
80104848:	81 fa f4 7f 1b 80    	cmp    $0x801b7ff4,%edx
8010484e:	72 e0                	jb     80104830 <destroyCid+0xc0>
    release(&ptable.lock);
80104850:	83 ec 0c             	sub    $0xc,%esp
80104853:	68 c0 5f 17 80       	push   $0x80175fc0
80104858:	e8 f3 04 00 00       	call   80104d50 <release>
  return container_id;
8010485d:	83 c4 10             	add    $0x10,%esp
}
80104860:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return container_id;
80104863:	89 d8                	mov    %ebx,%eax
}
80104865:	5b                   	pop    %ebx
80104866:	5e                   	pop    %esi
80104867:	5d                   	pop    %ebp
80104868:	c3                   	ret    
80104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104870 <joinCid>:




int
joinCid(int container_id){
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	56                   	push   %esi
80104875:	53                   	push   %ebx
  
  struct proc * currproc = myproc();
  int i ;
  acquire(&container_table.lock);
      
      for(i = 0 ;i< container_table.size ; i++)
80104876:	31 db                	xor    %ebx,%ebx
joinCid(int container_id){
80104878:	83 ec 0c             	sub    $0xc,%esp
8010487b:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010487e:	e8 3d 03 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
80104883:	e8 98 ee ff ff       	call   80103720 <mycpu>
  p = c->proc;
80104888:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010488e:	e8 6d 03 00 00       	call   80104c00 <popcli>
  acquire(&container_table.lock);
80104893:	83 ec 0c             	sub    $0xc,%esp
80104896:	68 80 4f 15 80       	push   $0x80154f80
8010489b:	e8 f0 03 00 00       	call   80104c90 <acquire>
      for(i = 0 ;i< container_table.size ; i++)
801048a0:	a1 b4 5f 15 80       	mov    0x80155fb4,%eax
801048a5:	83 c4 10             	add    $0x10,%esp
801048a8:	85 c0                	test   %eax,%eax
801048aa:	7e 24                	jle    801048d0 <joinCid+0x60>
      {
        if (container_table.containers[i].cid==container_id){
801048ac:	3b 35 b4 4f 15 80    	cmp    0x80154fb4,%esi
801048b2:	75 15                	jne    801048c9 <joinCid+0x59>
801048b4:	eb 4a                	jmp    80104900 <joinCid+0x90>
801048b6:	8d 76 00             	lea    0x0(%esi),%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048c0:	39 34 9d b4 4f 15 80 	cmp    %esi,-0x7feab04c(,%ebx,4)
801048c7:	74 37                	je     80104900 <joinCid+0x90>
      for(i = 0 ;i< container_table.size ; i++)
801048c9:	83 c3 01             	add    $0x1,%ebx
801048cc:	39 d8                	cmp    %ebx,%eax
801048ce:	75 f0                	jne    801048c0 <joinCid+0x50>
            currproc->in_container_id = container_id ; 
            break; 
        }
      }

  release(&container_table.lock);
801048d0:	83 ec 0c             	sub    $0xc,%esp
801048d3:	68 80 4f 15 80       	push   $0x80154f80
801048d8:	e8 73 04 00 00       	call   80104d50 <release>
  if (i==container_table.size){
801048dd:	83 c4 10             	add    $0x10,%esp
801048e0:	39 1d b4 5f 15 80    	cmp    %ebx,0x80155fb4
801048e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048eb:	0f 45 c6             	cmovne %esi,%eax
    return -1;
  }

  return container_id;
}
801048ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048f1:	5b                   	pop    %ebx
801048f2:	5e                   	pop    %esi
801048f3:	5f                   	pop    %edi
801048f4:	5d                   	pop    %ebp
801048f5:	c3                   	ret    
801048f6:	8d 76 00             	lea    0x0(%esi),%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            currproc->in_container_id = container_id ; 
80104900:	89 b7 7c 10 00 00    	mov    %esi,0x107c(%edi)
            break; 
80104906:	eb c8                	jmp    801048d0 <joinCid+0x60>
80104908:	90                   	nop
80104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104910 <leaveCid>:


int
leaveCid(void){
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	53                   	push   %ebx
80104914:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104917:	e8 a4 02 00 00       	call   80104bc0 <pushcli>
  c = mycpu();
8010491c:	e8 ff ed ff ff       	call   80103720 <mycpu>
  p = c->proc;
80104921:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104927:	e8 d4 02 00 00       	call   80104c00 <popcli>
  struct proc * currproc = myproc();
  currproc->in_container_id = -1; 
  
  return 0;
}
8010492c:	31 c0                	xor    %eax,%eax
  currproc->in_container_id = -1; 
8010492e:	c7 83 7c 10 00 00 ff 	movl   $0xffffffff,0x107c(%ebx)
80104935:	ff ff ff 
}
80104938:	83 c4 04             	add    $0x4,%esp
8010493b:	5b                   	pop    %ebx
8010493c:	5d                   	pop    %ebp
8010493d:	c3                   	ret    
8010493e:	66 90                	xchg   %ax,%ax

80104940 <print_ctable>:


int
print_ctable(void){
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 10             	sub    $0x10,%esp
  acquire(&container_table.lock);
80104947:	68 80 4f 15 80       	push   $0x80154f80
8010494c:	e8 3f 03 00 00       	call   80104c90 <acquire>
    int i = 0;
    for(i = 0 ;i< container_table.size ; i++)
80104951:	a1 b4 5f 15 80       	mov    0x80155fb4,%eax
80104956:	83 c4 10             	add    $0x10,%esp
80104959:	85 c0                	test   %eax,%eax
8010495b:	7e 27                	jle    80104984 <print_ctable+0x44>
8010495d:	31 db                	xor    %ebx,%ebx
8010495f:	90                   	nop
      {
        cprintf("%d %d\n",i+1,container_table.containers[i].cid);
80104960:	8b 04 9d b4 4f 15 80 	mov    -0x7feab04c(,%ebx,4),%eax
80104967:	83 ec 04             	sub    $0x4,%esp
8010496a:	83 c3 01             	add    $0x1,%ebx
8010496d:	50                   	push   %eax
8010496e:	53                   	push   %ebx
8010496f:	68 89 8d 10 80       	push   $0x80108d89
80104974:	e8 e7 bc ff ff       	call   80100660 <cprintf>
    for(i = 0 ;i< container_table.size ; i++)
80104979:	83 c4 10             	add    $0x10,%esp
8010497c:	3b 1d b4 5f 15 80    	cmp    0x80155fb4,%ebx
80104982:	7c dc                	jl     80104960 <print_ctable+0x20>
      }

  release(&container_table.lock);
80104984:	83 ec 0c             	sub    $0xc,%esp
80104987:	68 80 4f 15 80       	push   $0x80154f80
8010498c:	e8 bf 03 00 00       	call   80104d50 <release>

  return 0;
}
80104991:	31 c0                	xor    %eax,%eax
80104993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104996:	c9                   	leave  
80104997:	c3                   	ret    
80104998:	90                   	nop
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049a0 <sz_ctable>:

int
sz_ctable(void){
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&container_table.lock);
801049a6:	68 80 4f 15 80       	push   $0x80154f80
801049ab:	e8 e0 02 00 00       	call   80104c90 <acquire>
    
    cprintf("Size of ctable %d\n",container_table.size);
801049b0:	58                   	pop    %eax
801049b1:	5a                   	pop    %edx
801049b2:	ff 35 b4 5f 15 80    	pushl  0x80155fb4
801049b8:	68 90 8d 10 80       	push   $0x80108d90
801049bd:	e8 9e bc ff ff       	call   80100660 <cprintf>
  
  release(&container_table.lock);
801049c2:	c7 04 24 80 4f 15 80 	movl   $0x80154f80,(%esp)
801049c9:	e8 82 03 00 00       	call   80104d50 <release>

  return 0;
}
801049ce:	31 c0                	xor    %eax,%eax
801049d0:	c9                   	leave  
801049d1:	c3                   	ret    
801049d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <log_on>:


int
log_on(void){
801049e0:	55                   	push   %ebp
  scheduler_log = 1;
  return 1;
}
801049e1:	b8 01 00 00 00       	mov    $0x1,%eax
  scheduler_log = 1;
801049e6:	c7 05 6c 20 11 80 01 	movl   $0x1,0x8011206c
801049ed:	00 00 00 
log_on(void){
801049f0:	89 e5                	mov    %esp,%ebp
}
801049f2:	5d                   	pop    %ebp
801049f3:	c3                   	ret    
801049f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a00 <log_off>:

int
log_off(void){
80104a00:	55                   	push   %ebp
  scheduler_log = 0;
  return 1;
}
80104a01:	b8 01 00 00 00       	mov    $0x1,%eax
  scheduler_log = 0;
80104a06:	c7 05 6c 20 11 80 00 	movl   $0x0,0x8011206c
80104a0d:	00 00 00 
log_off(void){
80104a10:	89 e5                	mov    %esp,%ebp
}
80104a12:	5d                   	pop    %ebp
80104a13:	c3                   	ret    
80104a14:	66 90                	xchg   %ax,%ax
80104a16:	66 90                	xchg   %ax,%ax
80104a18:	66 90                	xchg   %ax,%ax
80104a1a:	66 90                	xchg   %ax,%ax
80104a1c:	66 90                	xchg   %ax,%ax
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 0c             	sub    $0xc,%esp
80104a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104a2a:	68 f8 8e 10 80       	push   $0x80108ef8
80104a2f:	8d 43 04             	lea    0x4(%ebx),%eax
80104a32:	50                   	push   %eax
80104a33:	e8 18 01 00 00       	call   80104b50 <initlock>
  lk->name = name;
80104a38:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104a3b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a41:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a44:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a4b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a51:	c9                   	leave  
80104a52:	c3                   	ret    
80104a53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
80104a65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a68:	83 ec 0c             	sub    $0xc,%esp
80104a6b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a6e:	56                   	push   %esi
80104a6f:	e8 1c 02 00 00       	call   80104c90 <acquire>
  while (lk->locked) {
80104a74:	8b 13                	mov    (%ebx),%edx
80104a76:	83 c4 10             	add    $0x10,%esp
80104a79:	85 d2                	test   %edx,%edx
80104a7b:	74 16                	je     80104a93 <acquiresleep+0x33>
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104a80:	83 ec 08             	sub    $0x8,%esp
80104a83:	56                   	push   %esi
80104a84:	53                   	push   %ebx
80104a85:	e8 76 f3 ff ff       	call   80103e00 <sleep>
  while (lk->locked) {
80104a8a:	8b 03                	mov    (%ebx),%eax
80104a8c:	83 c4 10             	add    $0x10,%esp
80104a8f:	85 c0                	test   %eax,%eax
80104a91:	75 ed                	jne    80104a80 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104a93:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a99:	e8 22 ed ff ff       	call   801037c0 <myproc>
80104a9e:	8b 40 10             	mov    0x10(%eax),%eax
80104aa1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104aa4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104aa7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aaa:	5b                   	pop    %ebx
80104aab:	5e                   	pop    %esi
80104aac:	5d                   	pop    %ebp
  release(&lk->lk);
80104aad:	e9 9e 02 00 00       	jmp    80104d50 <release>
80104ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ac0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	53                   	push   %ebx
80104ac5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ac8:	83 ec 0c             	sub    $0xc,%esp
80104acb:	8d 73 04             	lea    0x4(%ebx),%esi
80104ace:	56                   	push   %esi
80104acf:	e8 bc 01 00 00       	call   80104c90 <acquire>
  lk->locked = 0;
80104ad4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104ada:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ae1:	89 1c 24             	mov    %ebx,(%esp)
80104ae4:	e8 d7 f4 ff ff       	call   80103fc0 <wakeup>
  release(&lk->lk);
80104ae9:	89 75 08             	mov    %esi,0x8(%ebp)
80104aec:	83 c4 10             	add    $0x10,%esp
}
80104aef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104af2:	5b                   	pop    %ebx
80104af3:	5e                   	pop    %esi
80104af4:	5d                   	pop    %ebp
  release(&lk->lk);
80104af5:	e9 56 02 00 00       	jmp    80104d50 <release>
80104afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b00 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	57                   	push   %edi
80104b04:	56                   	push   %esi
80104b05:	53                   	push   %ebx
80104b06:	31 ff                	xor    %edi,%edi
80104b08:	83 ec 18             	sub    $0x18,%esp
80104b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104b0e:	8d 73 04             	lea    0x4(%ebx),%esi
80104b11:	56                   	push   %esi
80104b12:	e8 79 01 00 00       	call   80104c90 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104b17:	8b 03                	mov    (%ebx),%eax
80104b19:	83 c4 10             	add    $0x10,%esp
80104b1c:	85 c0                	test   %eax,%eax
80104b1e:	74 13                	je     80104b33 <holdingsleep+0x33>
80104b20:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104b23:	e8 98 ec ff ff       	call   801037c0 <myproc>
80104b28:	39 58 10             	cmp    %ebx,0x10(%eax)
80104b2b:	0f 94 c0             	sete   %al
80104b2e:	0f b6 c0             	movzbl %al,%eax
80104b31:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104b33:	83 ec 0c             	sub    $0xc,%esp
80104b36:	56                   	push   %esi
80104b37:	e8 14 02 00 00       	call   80104d50 <release>
  return r;
}
80104b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b3f:	89 f8                	mov    %edi,%eax
80104b41:	5b                   	pop    %ebx
80104b42:	5e                   	pop    %esi
80104b43:	5f                   	pop    %edi
80104b44:	5d                   	pop    %ebp
80104b45:	c3                   	ret    
80104b46:	66 90                	xchg   %ax,%ax
80104b48:	66 90                	xchg   %ax,%ax
80104b4a:	66 90                	xchg   %ax,%ax
80104b4c:	66 90                	xchg   %ax,%ax
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b56:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b5f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b62:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b69:	5d                   	pop    %ebp
80104b6a:	c3                   	ret    
80104b6b:	90                   	nop
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b70:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b71:	31 d2                	xor    %edx,%edx
{
80104b73:	89 e5                	mov    %esp,%ebp
80104b75:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b76:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b79:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b7c:	83 e8 08             	sub    $0x8,%eax
80104b7f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b80:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b8c:	77 1a                	ja     80104ba8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b8e:	8b 58 04             	mov    0x4(%eax),%ebx
80104b91:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b94:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b97:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b99:	83 fa 0a             	cmp    $0xa,%edx
80104b9c:	75 e2                	jne    80104b80 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b9e:	5b                   	pop    %ebx
80104b9f:	5d                   	pop    %ebp
80104ba0:	c3                   	ret    
80104ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ba8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bab:	83 c1 28             	add    $0x28,%ecx
80104bae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104bb0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104bb6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104bb9:	39 c1                	cmp    %eax,%ecx
80104bbb:	75 f3                	jne    80104bb0 <getcallerpcs+0x40>
}
80104bbd:	5b                   	pop    %ebx
80104bbe:	5d                   	pop    %ebp
80104bbf:	c3                   	ret    

80104bc0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	53                   	push   %ebx
80104bc4:	83 ec 04             	sub    $0x4,%esp
80104bc7:	9c                   	pushf  
80104bc8:	5b                   	pop    %ebx
  asm volatile("cli");
80104bc9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104bca:	e8 51 eb ff ff       	call   80103720 <mycpu>
80104bcf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104bd5:	85 c0                	test   %eax,%eax
80104bd7:	75 11                	jne    80104bea <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104bd9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104bdf:	e8 3c eb ff ff       	call   80103720 <mycpu>
80104be4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104bea:	e8 31 eb ff ff       	call   80103720 <mycpu>
80104bef:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104bf6:	83 c4 04             	add    $0x4,%esp
80104bf9:	5b                   	pop    %ebx
80104bfa:	5d                   	pop    %ebp
80104bfb:	c3                   	ret    
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c00 <popcli>:

void
popcli(void)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c06:	9c                   	pushf  
80104c07:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104c08:	f6 c4 02             	test   $0x2,%ah
80104c0b:	75 35                	jne    80104c42 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104c0d:	e8 0e eb ff ff       	call   80103720 <mycpu>
80104c12:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104c19:	78 34                	js     80104c4f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c1b:	e8 00 eb ff ff       	call   80103720 <mycpu>
80104c20:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c26:	85 d2                	test   %edx,%edx
80104c28:	74 06                	je     80104c30 <popcli+0x30>
    sti();
}
80104c2a:	c9                   	leave  
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c30:	e8 eb ea ff ff       	call   80103720 <mycpu>
80104c35:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c3b:	85 c0                	test   %eax,%eax
80104c3d:	74 eb                	je     80104c2a <popcli+0x2a>
  asm volatile("sti");
80104c3f:	fb                   	sti    
}
80104c40:	c9                   	leave  
80104c41:	c3                   	ret    
    panic("popcli - interruptible");
80104c42:	83 ec 0c             	sub    $0xc,%esp
80104c45:	68 03 8f 10 80       	push   $0x80108f03
80104c4a:	e8 41 b7 ff ff       	call   80100390 <panic>
    panic("popcli");
80104c4f:	83 ec 0c             	sub    $0xc,%esp
80104c52:	68 1a 8f 10 80       	push   $0x80108f1a
80104c57:	e8 34 b7 ff ff       	call   80100390 <panic>
80104c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c60 <holding>:
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
80104c65:	8b 75 08             	mov    0x8(%ebp),%esi
80104c68:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c6a:	e8 51 ff ff ff       	call   80104bc0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c6f:	8b 06                	mov    (%esi),%eax
80104c71:	85 c0                	test   %eax,%eax
80104c73:	74 10                	je     80104c85 <holding+0x25>
80104c75:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c78:	e8 a3 ea ff ff       	call   80103720 <mycpu>
80104c7d:	39 c3                	cmp    %eax,%ebx
80104c7f:	0f 94 c3             	sete   %bl
80104c82:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104c85:	e8 76 ff ff ff       	call   80104c00 <popcli>
}
80104c8a:	89 d8                	mov    %ebx,%eax
80104c8c:	5b                   	pop    %ebx
80104c8d:	5e                   	pop    %esi
80104c8e:	5d                   	pop    %ebp
80104c8f:	c3                   	ret    

80104c90 <acquire>:
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c95:	e8 26 ff ff ff       	call   80104bc0 <pushcli>
  if(holding(lk))
80104c9a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c9d:	83 ec 0c             	sub    $0xc,%esp
80104ca0:	53                   	push   %ebx
80104ca1:	e8 ba ff ff ff       	call   80104c60 <holding>
80104ca6:	83 c4 10             	add    $0x10,%esp
80104ca9:	85 c0                	test   %eax,%eax
80104cab:	0f 85 83 00 00 00    	jne    80104d34 <acquire+0xa4>
80104cb1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104cb3:	ba 01 00 00 00       	mov    $0x1,%edx
80104cb8:	eb 09                	jmp    80104cc3 <acquire+0x33>
80104cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cc0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cc3:	89 d0                	mov    %edx,%eax
80104cc5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104cc8:	85 c0                	test   %eax,%eax
80104cca:	75 f4                	jne    80104cc0 <acquire+0x30>
  __sync_synchronize();
80104ccc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104cd1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cd4:	e8 47 ea ff ff       	call   80103720 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104cd9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104cdc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104cdf:	89 e8                	mov    %ebp,%eax
80104ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ce8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104cee:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104cf4:	77 1a                	ja     80104d10 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cf6:	8b 48 04             	mov    0x4(%eax),%ecx
80104cf9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104cfc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104cff:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104d01:	83 fe 0a             	cmp    $0xa,%esi
80104d04:	75 e2                	jne    80104ce8 <acquire+0x58>
}
80104d06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d09:	5b                   	pop    %ebx
80104d0a:	5e                   	pop    %esi
80104d0b:	5d                   	pop    %ebp
80104d0c:	c3                   	ret    
80104d0d:	8d 76 00             	lea    0x0(%esi),%esi
80104d10:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104d13:	83 c2 28             	add    $0x28,%edx
80104d16:	8d 76 00             	lea    0x0(%esi),%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104d20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d26:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104d29:	39 d0                	cmp    %edx,%eax
80104d2b:	75 f3                	jne    80104d20 <acquire+0x90>
}
80104d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d30:	5b                   	pop    %ebx
80104d31:	5e                   	pop    %esi
80104d32:	5d                   	pop    %ebp
80104d33:	c3                   	ret    
    panic("acquire");
80104d34:	83 ec 0c             	sub    $0xc,%esp
80104d37:	68 21 8f 10 80       	push   $0x80108f21
80104d3c:	e8 4f b6 ff ff       	call   80100390 <panic>
80104d41:	eb 0d                	jmp    80104d50 <release>
80104d43:	90                   	nop
80104d44:	90                   	nop
80104d45:	90                   	nop
80104d46:	90                   	nop
80104d47:	90                   	nop
80104d48:	90                   	nop
80104d49:	90                   	nop
80104d4a:	90                   	nop
80104d4b:	90                   	nop
80104d4c:	90                   	nop
80104d4d:	90                   	nop
80104d4e:	90                   	nop
80104d4f:	90                   	nop

80104d50 <release>:
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	53                   	push   %ebx
80104d54:	83 ec 10             	sub    $0x10,%esp
80104d57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d5a:	53                   	push   %ebx
80104d5b:	e8 00 ff ff ff       	call   80104c60 <holding>
80104d60:	83 c4 10             	add    $0x10,%esp
80104d63:	85 c0                	test   %eax,%eax
80104d65:	74 22                	je     80104d89 <release+0x39>
  lk->pcs[0] = 0;
80104d67:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d6e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d75:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d7a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d83:	c9                   	leave  
  popcli();
80104d84:	e9 77 fe ff ff       	jmp    80104c00 <popcli>
    panic("release");
80104d89:	83 ec 0c             	sub    $0xc,%esp
80104d8c:	68 29 8f 10 80       	push   $0x80108f29
80104d91:	e8 fa b5 ff ff       	call   80100390 <panic>
80104d96:	66 90                	xchg   %ax,%ax
80104d98:	66 90                	xchg   %ax,%ax
80104d9a:	66 90                	xchg   %ax,%ax
80104d9c:	66 90                	xchg   %ax,%ax
80104d9e:	66 90                	xchg   %ax,%ax

80104da0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	57                   	push   %edi
80104da4:	53                   	push   %ebx
80104da5:	8b 55 08             	mov    0x8(%ebp),%edx
80104da8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104dab:	f6 c2 03             	test   $0x3,%dl
80104dae:	75 05                	jne    80104db5 <memset+0x15>
80104db0:	f6 c1 03             	test   $0x3,%cl
80104db3:	74 13                	je     80104dc8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104db5:	89 d7                	mov    %edx,%edi
80104db7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dba:	fc                   	cld    
80104dbb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104dbd:	5b                   	pop    %ebx
80104dbe:	89 d0                	mov    %edx,%eax
80104dc0:	5f                   	pop    %edi
80104dc1:	5d                   	pop    %ebp
80104dc2:	c3                   	ret    
80104dc3:	90                   	nop
80104dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104dc8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104dcc:	c1 e9 02             	shr    $0x2,%ecx
80104dcf:	89 f8                	mov    %edi,%eax
80104dd1:	89 fb                	mov    %edi,%ebx
80104dd3:	c1 e0 18             	shl    $0x18,%eax
80104dd6:	c1 e3 10             	shl    $0x10,%ebx
80104dd9:	09 d8                	or     %ebx,%eax
80104ddb:	09 f8                	or     %edi,%eax
80104ddd:	c1 e7 08             	shl    $0x8,%edi
80104de0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104de2:	89 d7                	mov    %edx,%edi
80104de4:	fc                   	cld    
80104de5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104de7:	5b                   	pop    %ebx
80104de8:	89 d0                	mov    %edx,%eax
80104dea:	5f                   	pop    %edi
80104deb:	5d                   	pop    %ebp
80104dec:	c3                   	ret    
80104ded:	8d 76 00             	lea    0x0(%esi),%esi

80104df0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	57                   	push   %edi
80104df4:	56                   	push   %esi
80104df5:	53                   	push   %ebx
80104df6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104df9:	8b 75 08             	mov    0x8(%ebp),%esi
80104dfc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104dff:	85 db                	test   %ebx,%ebx
80104e01:	74 29                	je     80104e2c <memcmp+0x3c>
    if(*s1 != *s2)
80104e03:	0f b6 16             	movzbl (%esi),%edx
80104e06:	0f b6 0f             	movzbl (%edi),%ecx
80104e09:	38 d1                	cmp    %dl,%cl
80104e0b:	75 2b                	jne    80104e38 <memcmp+0x48>
80104e0d:	b8 01 00 00 00       	mov    $0x1,%eax
80104e12:	eb 14                	jmp    80104e28 <memcmp+0x38>
80104e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e18:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104e1c:	83 c0 01             	add    $0x1,%eax
80104e1f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104e24:	38 ca                	cmp    %cl,%dl
80104e26:	75 10                	jne    80104e38 <memcmp+0x48>
  while(n-- > 0){
80104e28:	39 d8                	cmp    %ebx,%eax
80104e2a:	75 ec                	jne    80104e18 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104e2c:	5b                   	pop    %ebx
  return 0;
80104e2d:	31 c0                	xor    %eax,%eax
}
80104e2f:	5e                   	pop    %esi
80104e30:	5f                   	pop    %edi
80104e31:	5d                   	pop    %ebp
80104e32:	c3                   	ret    
80104e33:	90                   	nop
80104e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104e38:	0f b6 c2             	movzbl %dl,%eax
}
80104e3b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104e3c:	29 c8                	sub    %ecx,%eax
}
80104e3e:	5e                   	pop    %esi
80104e3f:	5f                   	pop    %edi
80104e40:	5d                   	pop    %ebp
80104e41:	c3                   	ret    
80104e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	56                   	push   %esi
80104e54:	53                   	push   %ebx
80104e55:	8b 45 08             	mov    0x8(%ebp),%eax
80104e58:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e5b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e5e:	39 c3                	cmp    %eax,%ebx
80104e60:	73 26                	jae    80104e88 <memmove+0x38>
80104e62:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104e65:	39 c8                	cmp    %ecx,%eax
80104e67:	73 1f                	jae    80104e88 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104e69:	85 f6                	test   %esi,%esi
80104e6b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104e6e:	74 0f                	je     80104e7f <memmove+0x2f>
      *--d = *--s;
80104e70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104e77:	83 ea 01             	sub    $0x1,%edx
80104e7a:	83 fa ff             	cmp    $0xffffffff,%edx
80104e7d:	75 f1                	jne    80104e70 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e7f:	5b                   	pop    %ebx
80104e80:	5e                   	pop    %esi
80104e81:	5d                   	pop    %ebp
80104e82:	c3                   	ret    
80104e83:	90                   	nop
80104e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104e88:	31 d2                	xor    %edx,%edx
80104e8a:	85 f6                	test   %esi,%esi
80104e8c:	74 f1                	je     80104e7f <memmove+0x2f>
80104e8e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104e90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e97:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104e9a:	39 d6                	cmp    %edx,%esi
80104e9c:	75 f2                	jne    80104e90 <memmove+0x40>
}
80104e9e:	5b                   	pop    %ebx
80104e9f:	5e                   	pop    %esi
80104ea0:	5d                   	pop    %ebp
80104ea1:	c3                   	ret    
80104ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104eb0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104eb3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104eb4:	eb 9a                	jmp    80104e50 <memmove>
80104eb6:	8d 76 00             	lea    0x0(%esi),%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104ec8:	53                   	push   %ebx
80104ec9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ecc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104ecf:	85 ff                	test   %edi,%edi
80104ed1:	74 2f                	je     80104f02 <strncmp+0x42>
80104ed3:	0f b6 01             	movzbl (%ecx),%eax
80104ed6:	0f b6 1e             	movzbl (%esi),%ebx
80104ed9:	84 c0                	test   %al,%al
80104edb:	74 37                	je     80104f14 <strncmp+0x54>
80104edd:	38 c3                	cmp    %al,%bl
80104edf:	75 33                	jne    80104f14 <strncmp+0x54>
80104ee1:	01 f7                	add    %esi,%edi
80104ee3:	eb 13                	jmp    80104ef8 <strncmp+0x38>
80104ee5:	8d 76 00             	lea    0x0(%esi),%esi
80104ee8:	0f b6 01             	movzbl (%ecx),%eax
80104eeb:	84 c0                	test   %al,%al
80104eed:	74 21                	je     80104f10 <strncmp+0x50>
80104eef:	0f b6 1a             	movzbl (%edx),%ebx
80104ef2:	89 d6                	mov    %edx,%esi
80104ef4:	38 d8                	cmp    %bl,%al
80104ef6:	75 1c                	jne    80104f14 <strncmp+0x54>
    n--, p++, q++;
80104ef8:	8d 56 01             	lea    0x1(%esi),%edx
80104efb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104efe:	39 fa                	cmp    %edi,%edx
80104f00:	75 e6                	jne    80104ee8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104f02:	5b                   	pop    %ebx
    return 0;
80104f03:	31 c0                	xor    %eax,%eax
}
80104f05:	5e                   	pop    %esi
80104f06:	5f                   	pop    %edi
80104f07:	5d                   	pop    %ebp
80104f08:	c3                   	ret    
80104f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f10:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104f14:	29 d8                	sub    %ebx,%eax
}
80104f16:	5b                   	pop    %ebx
80104f17:	5e                   	pop    %esi
80104f18:	5f                   	pop    %edi
80104f19:	5d                   	pop    %ebp
80104f1a:	c3                   	ret    
80104f1b:	90                   	nop
80104f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f20 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
80104f25:	8b 45 08             	mov    0x8(%ebp),%eax
80104f28:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104f2b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f2e:	89 c2                	mov    %eax,%edx
80104f30:	eb 19                	jmp    80104f4b <strncpy+0x2b>
80104f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f38:	83 c3 01             	add    $0x1,%ebx
80104f3b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104f3f:	83 c2 01             	add    $0x1,%edx
80104f42:	84 c9                	test   %cl,%cl
80104f44:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f47:	74 09                	je     80104f52 <strncpy+0x32>
80104f49:	89 f1                	mov    %esi,%ecx
80104f4b:	85 c9                	test   %ecx,%ecx
80104f4d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f50:	7f e6                	jg     80104f38 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f52:	31 c9                	xor    %ecx,%ecx
80104f54:	85 f6                	test   %esi,%esi
80104f56:	7e 17                	jle    80104f6f <strncpy+0x4f>
80104f58:	90                   	nop
80104f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f60:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f64:	89 f3                	mov    %esi,%ebx
80104f66:	83 c1 01             	add    $0x1,%ecx
80104f69:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104f6b:	85 db                	test   %ebx,%ebx
80104f6d:	7f f1                	jg     80104f60 <strncpy+0x40>
  return os;
}
80104f6f:	5b                   	pop    %ebx
80104f70:	5e                   	pop    %esi
80104f71:	5d                   	pop    %ebp
80104f72:	c3                   	ret    
80104f73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
80104f85:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f88:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f8e:	85 c9                	test   %ecx,%ecx
80104f90:	7e 26                	jle    80104fb8 <safestrcpy+0x38>
80104f92:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f96:	89 c1                	mov    %eax,%ecx
80104f98:	eb 17                	jmp    80104fb1 <safestrcpy+0x31>
80104f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104fa0:	83 c2 01             	add    $0x1,%edx
80104fa3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104fa7:	83 c1 01             	add    $0x1,%ecx
80104faa:	84 db                	test   %bl,%bl
80104fac:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104faf:	74 04                	je     80104fb5 <safestrcpy+0x35>
80104fb1:	39 f2                	cmp    %esi,%edx
80104fb3:	75 eb                	jne    80104fa0 <safestrcpy+0x20>
    ;
  *s = 0;
80104fb5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104fb8:	5b                   	pop    %ebx
80104fb9:	5e                   	pop    %esi
80104fba:	5d                   	pop    %ebp
80104fbb:	c3                   	ret    
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fc0 <strlen>:

int
strlen(const char *s)
{
80104fc0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104fc1:	31 c0                	xor    %eax,%eax
{
80104fc3:	89 e5                	mov    %esp,%ebp
80104fc5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104fc8:	80 3a 00             	cmpb   $0x0,(%edx)
80104fcb:	74 0c                	je     80104fd9 <strlen+0x19>
80104fcd:	8d 76 00             	lea    0x0(%esi),%esi
80104fd0:	83 c0 01             	add    $0x1,%eax
80104fd3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104fd7:	75 f7                	jne    80104fd0 <strlen+0x10>
    ;
  return n;
}
80104fd9:	5d                   	pop    %ebp
80104fda:	c3                   	ret    

80104fdb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104fdb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104fdf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104fe3:	55                   	push   %ebp
  pushl %ebx
80104fe4:	53                   	push   %ebx
  pushl %esi
80104fe5:	56                   	push   %esi
  pushl %edi
80104fe6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104fe7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104fe9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104feb:	5f                   	pop    %edi
  popl %esi
80104fec:	5e                   	pop    %esi
  popl %ebx
80104fed:	5b                   	pop    %ebx
  popl %ebp
80104fee:	5d                   	pop    %ebp
  ret
80104fef:	c3                   	ret    

80104ff0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	53                   	push   %ebx
80104ff4:	83 ec 04             	sub    $0x4,%esp
80104ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104ffa:	e8 c1 e7 ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fff:	8b 00                	mov    (%eax),%eax
80105001:	39 d8                	cmp    %ebx,%eax
80105003:	76 1b                	jbe    80105020 <fetchint+0x30>
80105005:	8d 53 04             	lea    0x4(%ebx),%edx
80105008:	39 d0                	cmp    %edx,%eax
8010500a:	72 14                	jb     80105020 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010500c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010500f:	8b 13                	mov    (%ebx),%edx
80105011:	89 10                	mov    %edx,(%eax)
  return 0;
80105013:	31 c0                	xor    %eax,%eax
}
80105015:	83 c4 04             	add    $0x4,%esp
80105018:	5b                   	pop    %ebx
80105019:	5d                   	pop    %ebp
8010501a:	c3                   	ret    
8010501b:	90                   	nop
8010501c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105025:	eb ee                	jmp    80105015 <fetchint+0x25>
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105030 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
80105034:	83 ec 04             	sub    $0x4,%esp
80105037:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010503a:	e8 81 e7 ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz)
8010503f:	39 18                	cmp    %ebx,(%eax)
80105041:	76 29                	jbe    8010506c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105043:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105046:	89 da                	mov    %ebx,%edx
80105048:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010504a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010504c:	39 c3                	cmp    %eax,%ebx
8010504e:	73 1c                	jae    8010506c <fetchstr+0x3c>
    if(*s == 0)
80105050:	80 3b 00             	cmpb   $0x0,(%ebx)
80105053:	75 10                	jne    80105065 <fetchstr+0x35>
80105055:	eb 39                	jmp    80105090 <fetchstr+0x60>
80105057:	89 f6                	mov    %esi,%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105060:	80 3a 00             	cmpb   $0x0,(%edx)
80105063:	74 1b                	je     80105080 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105065:	83 c2 01             	add    $0x1,%edx
80105068:	39 d0                	cmp    %edx,%eax
8010506a:	77 f4                	ja     80105060 <fetchstr+0x30>
    return -1;
8010506c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105071:	83 c4 04             	add    $0x4,%esp
80105074:	5b                   	pop    %ebx
80105075:	5d                   	pop    %ebp
80105076:	c3                   	ret    
80105077:	89 f6                	mov    %esi,%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105080:	83 c4 04             	add    $0x4,%esp
80105083:	89 d0                	mov    %edx,%eax
80105085:	29 d8                	sub    %ebx,%eax
80105087:	5b                   	pop    %ebx
80105088:	5d                   	pop    %ebp
80105089:	c3                   	ret    
8010508a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105090:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105092:	eb dd                	jmp    80105071 <fetchstr+0x41>
80105094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010509a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050a5:	e8 16 e7 ff ff       	call   801037c0 <myproc>
801050aa:	8b 40 18             	mov    0x18(%eax),%eax
801050ad:	8b 55 08             	mov    0x8(%ebp),%edx
801050b0:	8b 40 44             	mov    0x44(%eax),%eax
801050b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801050b6:	e8 05 e7 ff ff       	call   801037c0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050bb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050bd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050c0:	39 c6                	cmp    %eax,%esi
801050c2:	73 1c                	jae    801050e0 <argint+0x40>
801050c4:	8d 53 08             	lea    0x8(%ebx),%edx
801050c7:	39 d0                	cmp    %edx,%eax
801050c9:	72 15                	jb     801050e0 <argint+0x40>
  *ip = *(int*)(addr);
801050cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ce:	8b 53 04             	mov    0x4(%ebx),%edx
801050d1:	89 10                	mov    %edx,(%eax)
  return 0;
801050d3:	31 c0                	xor    %eax,%eax
}
801050d5:	5b                   	pop    %ebx
801050d6:	5e                   	pop    %esi
801050d7:	5d                   	pop    %ebp
801050d8:	c3                   	ret    
801050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050e5:	eb ee                	jmp    801050d5 <argint+0x35>
801050e7:	89 f6                	mov    %esi,%esi
801050e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050f0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
801050f5:	83 ec 10             	sub    $0x10,%esp
801050f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801050fb:	e8 c0 e6 ff ff       	call   801037c0 <myproc>
80105100:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105102:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105105:	83 ec 08             	sub    $0x8,%esp
80105108:	50                   	push   %eax
80105109:	ff 75 08             	pushl  0x8(%ebp)
8010510c:	e8 8f ff ff ff       	call   801050a0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105111:	83 c4 10             	add    $0x10,%esp
80105114:	85 c0                	test   %eax,%eax
80105116:	78 28                	js     80105140 <argptr+0x50>
80105118:	85 db                	test   %ebx,%ebx
8010511a:	78 24                	js     80105140 <argptr+0x50>
8010511c:	8b 16                	mov    (%esi),%edx
8010511e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105121:	39 c2                	cmp    %eax,%edx
80105123:	76 1b                	jbe    80105140 <argptr+0x50>
80105125:	01 c3                	add    %eax,%ebx
80105127:	39 da                	cmp    %ebx,%edx
80105129:	72 15                	jb     80105140 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010512b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010512e:	89 02                	mov    %eax,(%edx)
  return 0;
80105130:	31 c0                	xor    %eax,%eax
}
80105132:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105135:	5b                   	pop    %ebx
80105136:	5e                   	pop    %esi
80105137:	5d                   	pop    %ebp
80105138:	c3                   	ret    
80105139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105145:	eb eb                	jmp    80105132 <argptr+0x42>
80105147:	89 f6                	mov    %esi,%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105156:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105159:	50                   	push   %eax
8010515a:	ff 75 08             	pushl  0x8(%ebp)
8010515d:	e8 3e ff ff ff       	call   801050a0 <argint>
80105162:	83 c4 10             	add    $0x10,%esp
80105165:	85 c0                	test   %eax,%eax
80105167:	78 17                	js     80105180 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105169:	83 ec 08             	sub    $0x8,%esp
8010516c:	ff 75 0c             	pushl  0xc(%ebp)
8010516f:	ff 75 f4             	pushl  -0xc(%ebp)
80105172:	e8 b9 fe ff ff       	call   80105030 <fetchstr>
80105177:	83 c4 10             	add    $0x10,%esp
}
8010517a:	c9                   	leave  
8010517b:	c3                   	ret    
8010517c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105185:	c9                   	leave  
80105186:	c3                   	ret    
80105187:	89 f6                	mov    %esi,%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <argintptr>:


// Fetch the int-ptr
int
argintptr(int n, int **pp, int size)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	56                   	push   %esi
80105194:	53                   	push   %ebx
80105195:	83 ec 10             	sub    $0x10,%esp
80105198:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010519b:	e8 20 e6 ff ff       	call   801037c0 <myproc>
801051a0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801051a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051a5:	83 ec 08             	sub    $0x8,%esp
801051a8:	50                   	push   %eax
801051a9:	ff 75 08             	pushl  0x8(%ebp)
801051ac:	e8 ef fe ff ff       	call   801050a0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801051b1:	83 c4 10             	add    $0x10,%esp
801051b4:	85 c0                	test   %eax,%eax
801051b6:	78 28                	js     801051e0 <argintptr+0x50>
801051b8:	85 db                	test   %ebx,%ebx
801051ba:	78 24                	js     801051e0 <argintptr+0x50>
801051bc:	8b 16                	mov    (%esi),%edx
801051be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c1:	39 c2                	cmp    %eax,%edx
801051c3:	76 1b                	jbe    801051e0 <argintptr+0x50>
801051c5:	01 c3                	add    %eax,%ebx
801051c7:	39 da                	cmp    %ebx,%edx
801051c9:	72 15                	jb     801051e0 <argintptr+0x50>
    return -1;
  *pp = (int*)i;
801051cb:	8b 55 0c             	mov    0xc(%ebp),%edx
801051ce:	89 02                	mov    %eax,(%edx)
  return 0;
801051d0:	31 c0                	xor    %eax,%eax
}
801051d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051d5:	5b                   	pop    %ebx
801051d6:	5e                   	pop    %esi
801051d7:	5d                   	pop    %ebp
801051d8:	c3                   	ret    
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801051e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e5:	eb eb                	jmp    801051d2 <argintptr+0x42>
801051e7:	89 f6                	mov    %esi,%esi
801051e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051f0 <syscall>:



void
syscall(void)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	53                   	push   %ebx
801051f4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801051f7:	e8 c4 e5 ff ff       	call   801037c0 <myproc>
801051fc:	89 c3                	mov    %eax,%ebx


  // Check if system_treace is initialized ?
  if (system_initialized==0){
801051fe:	a1 78 c6 10 80       	mov    0x8010c678,%eax
80105203:	85 c0                	test   %eax,%eax
80105205:	75 33                	jne    8010523a <syscall+0x4a>
    
    //Default is TRACE_OFF
    system_trace = 0;
80105207:	c7 05 00 80 1d 80 00 	movl   $0x0,0x801d8000
8010520e:	00 00 00 
80105211:	b8 e0 c5 10 80       	mov    $0x8010c5e0,%eax
80105216:	8d 76 00             	lea    0x0(%esi),%esi
80105219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (int i = 0; i < 29; ++i)
    {
      call_count[i]=0;
80105220:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105226:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < 29; ++i)
80105229:	3d 54 c6 10 80       	cmp    $0x8010c654,%eax
8010522e:	75 f0                	jne    80105220 <syscall+0x30>
    
    //Initialize Message_Buffers max size is 8 messages(message = message_buffer);
    // Message_Buffers = new int*[8];

    // System has been initialized now.
    system_initialized = 1;
80105230:	c7 05 78 c6 10 80 01 	movl   $0x1,0x8010c678
80105237:	00 00 00 
  }


  num = curproc->tf->eax;
8010523a:	8b 43 18             	mov    0x18(%ebx),%eax
8010523d:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105240:	8d 50 ff             	lea    -0x1(%eax),%edx
80105243:	83 fa 24             	cmp    $0x24,%edx
80105246:	77 30                	ja     80105278 <syscall+0x88>
80105248:	8b 14 85 60 8f 10 80 	mov    -0x7fef70a0(,%eax,4),%edx
8010524f:	85 d2                	test   %edx,%edx
80105251:	74 25                	je     80105278 <syscall+0x88>
    if (system_trace==1){  
80105253:	83 3d 00 80 1d 80 01 	cmpl   $0x1,0x801d8000
8010525a:	75 08                	jne    80105264 <syscall+0x74>
      call_count[num]+=1;
8010525c:	83 04 85 e0 c5 10 80 	addl   $0x1,-0x7fef3a20(,%eax,4)
80105263:	01 
    }
    curproc->tf->eax = syscalls[num]();
80105264:	ff d2                	call   *%edx
80105266:	8b 53 18             	mov    0x18(%ebx),%edx
80105269:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010526c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010526f:	c9                   	leave  
80105270:	c3                   	ret    
80105271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105278:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105279:	8d 83 2c 10 00 00    	lea    0x102c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010527f:	50                   	push   %eax
80105280:	ff 73 10             	pushl  0x10(%ebx)
80105283:	68 31 8f 10 80       	push   $0x80108f31
80105288:	e8 d3 b3 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
8010528d:	8b 43 18             	mov    0x18(%ebx),%eax
80105290:	83 c4 10             	add    $0x10,%esp
80105293:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010529a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010529d:	c9                   	leave  
8010529e:	c3                   	ret    
8010529f:	90                   	nop

801052a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	57                   	push   %edi
801052a4:	56                   	push   %esi
801052a5:	53                   	push   %ebx
  char name[DIRSIZ];




  if((dp = nameiparent(path, name)) == 0)
801052a6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801052a9:	83 ec 44             	sub    $0x44,%esp
801052ac:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801052af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801052b2:	56                   	push   %esi
801052b3:	50                   	push   %eax
{
801052b4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801052b7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801052ba:	e8 b1 cb ff ff       	call   80101e70 <nameiparent>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	0f 84 46 01 00 00    	je     80105410 <create+0x170>
    return 0;
  ilock(dp);
801052ca:	83 ec 0c             	sub    $0xc,%esp
801052cd:	89 c3                	mov    %eax,%ebx
801052cf:	50                   	push   %eax
801052d0:	e8 fb c2 ff ff       	call   801015d0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801052d5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801052d8:	83 c4 0c             	add    $0xc,%esp
801052db:	50                   	push   %eax
801052dc:	56                   	push   %esi
801052dd:	53                   	push   %ebx
801052de:	e8 2d c8 ff ff       	call   80101b10 <dirlookup>
801052e3:	83 c4 10             	add    $0x10,%esp
801052e6:	85 c0                	test   %eax,%eax
801052e8:	89 c7                	mov    %eax,%edi
801052ea:	74 34                	je     80105320 <create+0x80>
    iunlockput(dp);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	53                   	push   %ebx
801052f0:	e8 6b c5 ff ff       	call   80101860 <iunlockput>
    ilock(ip);
801052f5:	89 3c 24             	mov    %edi,(%esp)
801052f8:	e8 d3 c2 ff ff       	call   801015d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801052fd:	83 c4 10             	add    $0x10,%esp
80105300:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105305:	0f 85 95 00 00 00    	jne    801053a0 <create+0x100>
8010530b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105310:	0f 85 8a 00 00 00    	jne    801053a0 <create+0x100>
  // struct proc *curproc = myproc();
  // ip->cid =  curproc->in_container_id ;
  // cprintf("File cid set %d", ip->cid);

  return ip;
}
80105316:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105319:	89 f8                	mov    %edi,%eax
8010531b:	5b                   	pop    %ebx
8010531c:	5e                   	pop    %esi
8010531d:	5f                   	pop    %edi
8010531e:	5d                   	pop    %ebp
8010531f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105320:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105324:	83 ec 08             	sub    $0x8,%esp
80105327:	50                   	push   %eax
80105328:	ff 33                	pushl  (%ebx)
8010532a:	e8 31 c1 ff ff       	call   80101460 <ialloc>
8010532f:	83 c4 10             	add    $0x10,%esp
80105332:	85 c0                	test   %eax,%eax
80105334:	89 c7                	mov    %eax,%edi
80105336:	0f 84 e8 00 00 00    	je     80105424 <create+0x184>
  ilock(ip);
8010533c:	83 ec 0c             	sub    $0xc,%esp
8010533f:	50                   	push   %eax
80105340:	e8 8b c2 ff ff       	call   801015d0 <ilock>
  ip->major = major;
80105345:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105349:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010534d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105351:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105355:	b8 01 00 00 00       	mov    $0x1,%eax
8010535a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010535e:	89 3c 24             	mov    %edi,(%esp)
80105361:	e8 ba c1 ff ff       	call   80101520 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105366:	83 c4 10             	add    $0x10,%esp
80105369:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010536e:	74 50                	je     801053c0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105370:	83 ec 04             	sub    $0x4,%esp
80105373:	ff 77 04             	pushl  0x4(%edi)
80105376:	56                   	push   %esi
80105377:	53                   	push   %ebx
80105378:	e8 13 ca ff ff       	call   80101d90 <dirlink>
8010537d:	83 c4 10             	add    $0x10,%esp
80105380:	85 c0                	test   %eax,%eax
80105382:	0f 88 8f 00 00 00    	js     80105417 <create+0x177>
  iunlockput(dp);
80105388:	83 ec 0c             	sub    $0xc,%esp
8010538b:	53                   	push   %ebx
8010538c:	e8 cf c4 ff ff       	call   80101860 <iunlockput>
  return ip;
80105391:	83 c4 10             	add    $0x10,%esp
}
80105394:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105397:	89 f8                	mov    %edi,%eax
80105399:	5b                   	pop    %ebx
8010539a:	5e                   	pop    %esi
8010539b:	5f                   	pop    %edi
8010539c:	5d                   	pop    %ebp
8010539d:	c3                   	ret    
8010539e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	57                   	push   %edi
    return 0;
801053a4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801053a6:	e8 b5 c4 ff ff       	call   80101860 <iunlockput>
    return 0;
801053ab:	83 c4 10             	add    $0x10,%esp
}
801053ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053b1:	89 f8                	mov    %edi,%eax
801053b3:	5b                   	pop    %ebx
801053b4:	5e                   	pop    %esi
801053b5:	5f                   	pop    %edi
801053b6:	5d                   	pop    %ebp
801053b7:	c3                   	ret    
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801053c0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801053c5:	83 ec 0c             	sub    $0xc,%esp
801053c8:	53                   	push   %ebx
801053c9:	e8 52 c1 ff ff       	call   80101520 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801053ce:	83 c4 0c             	add    $0xc,%esp
801053d1:	ff 77 04             	pushl  0x4(%edi)
801053d4:	68 14 90 10 80       	push   $0x80109014
801053d9:	57                   	push   %edi
801053da:	e8 b1 c9 ff ff       	call   80101d90 <dirlink>
801053df:	83 c4 10             	add    $0x10,%esp
801053e2:	85 c0                	test   %eax,%eax
801053e4:	78 1c                	js     80105402 <create+0x162>
801053e6:	83 ec 04             	sub    $0x4,%esp
801053e9:	ff 73 04             	pushl  0x4(%ebx)
801053ec:	68 13 90 10 80       	push   $0x80109013
801053f1:	57                   	push   %edi
801053f2:	e8 99 c9 ff ff       	call   80101d90 <dirlink>
801053f7:	83 c4 10             	add    $0x10,%esp
801053fa:	85 c0                	test   %eax,%eax
801053fc:	0f 89 6e ff ff ff    	jns    80105370 <create+0xd0>
      panic("create dots");
80105402:	83 ec 0c             	sub    $0xc,%esp
80105405:	68 07 90 10 80       	push   $0x80109007
8010540a:	e8 81 af ff ff       	call   80100390 <panic>
8010540f:	90                   	nop
    return 0;
80105410:	31 ff                	xor    %edi,%edi
80105412:	e9 ff fe ff ff       	jmp    80105316 <create+0x76>
    panic("create: dirlink");
80105417:	83 ec 0c             	sub    $0xc,%esp
8010541a:	68 16 90 10 80       	push   $0x80109016
8010541f:	e8 6c af ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105424:	83 ec 0c             	sub    $0xc,%esp
80105427:	68 f8 8f 10 80       	push   $0x80108ff8
8010542c:	e8 5f af ff ff       	call   80100390 <panic>
80105431:	eb 0d                	jmp    80105440 <argfd.constprop.0>
80105433:	90                   	nop
80105434:	90                   	nop
80105435:	90                   	nop
80105436:	90                   	nop
80105437:	90                   	nop
80105438:	90                   	nop
80105439:	90                   	nop
8010543a:	90                   	nop
8010543b:	90                   	nop
8010543c:	90                   	nop
8010543d:	90                   	nop
8010543e:	90                   	nop
8010543f:	90                   	nop

80105440 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105446:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80105449:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(n, &fd) < 0)
8010544c:	50                   	push   %eax
8010544d:	6a 00                	push   $0x0
8010544f:	e8 4c fc ff ff       	call   801050a0 <argint>
80105454:	83 c4 10             	add    $0x10,%esp
80105457:	85 c0                	test   %eax,%eax
80105459:	78 25                	js     80105480 <argfd.constprop.0+0x40>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010545b:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80105462:	77 1c                	ja     80105480 <argfd.constprop.0+0x40>
80105464:	e8 57 e3 ff ff       	call   801037c0 <myproc>
80105469:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010546c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105470:	85 c0                	test   %eax,%eax
80105472:	74 0c                	je     80105480 <argfd.constprop.0+0x40>
    *pf = f;
80105474:	89 03                	mov    %eax,(%ebx)
  return 0;
80105476:	31 c0                	xor    %eax,%eax
}
80105478:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010547b:	c9                   	leave  
8010547c:	c3                   	ret    
8010547d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105485:	eb f1                	jmp    80105478 <argfd.constprop.0+0x38>
80105487:	89 f6                	mov    %esi,%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105490 <itoa>:
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	57                   	push   %edi
80105494:	56                   	push   %esi
80105495:	53                   	push   %ebx
80105496:	83 ec 0c             	sub    $0xc,%esp
80105499:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char * s = kalloc();
8010549c:	e8 8f cf ff ff       	call   80102430 <kalloc>
801054a1:	89 c7                	mov    %eax,%edi
  if (n==0){ *(s+k) = '0'; k++; *(s+k) = '\0'; return s;}
801054a3:	83 fb 00             	cmp    $0x0,%ebx
801054a6:	0f 84 14 01 00 00    	je     801055c0 <itoa+0x130>
  int k = 0 ;
801054ac:	be 00 00 00 00       	mov    $0x0,%esi
      int p = n%10;
801054b1:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
  while(n>0){
801054b6:	0f 8e 1c 01 00 00    	jle    801055d8 <itoa+0x148>
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      int p = n%10;
801054c0:	89 d8                	mov    %ebx,%eax
801054c2:	83 c6 01             	add    $0x1,%esi
801054c5:	f7 e1                	mul    %ecx
801054c7:	c1 ea 03             	shr    $0x3,%edx
801054ca:	8d 04 92             	lea    (%edx,%edx,4),%eax
801054cd:	89 da                	mov    %ebx,%edx
801054cf:	01 c0                	add    %eax,%eax
801054d1:	29 c2                	sub    %eax,%edx
      switch(p){
801054d3:	83 fa 09             	cmp    $0x9,%edx
801054d6:	0f 87 c4 00 00 00    	ja     801055a0 <itoa+0x110>
801054dc:	ff 24 95 5c 90 10 80 	jmp    *-0x7fef6fa4(,%edx,4)
801054e3:	90                   	nop
801054e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          *(s+k) = '8';
801054e8:	c6 44 37 ff 38       	movb   $0x38,-0x1(%edi,%esi,1)
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
      n = n/10;
801054f0:	89 d8                	mov    %ebx,%eax
801054f2:	f7 e1                	mul    %ecx
801054f4:	89 d3                	mov    %edx,%ebx
801054f6:	c1 eb 03             	shr    $0x3,%ebx
  while(n>0){
801054f9:	85 db                	test   %ebx,%ebx
801054fb:	75 c3                	jne    801054c0 <itoa+0x30>
  char * to_ret = kalloc() ;
801054fd:	e8 2e cf ff ff       	call   80102430 <kalloc>
80105502:	89 f2                	mov    %esi,%edx
80105504:	89 c3                	mov    %eax,%ebx
80105506:	8d 76 00             	lea    0x0(%esi),%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *(to_ret+q) = *(s+k-1);
80105510:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
80105515:	83 c3 01             	add    $0x1,%ebx
80105518:	88 4b ff             	mov    %cl,-0x1(%ebx)
  while(k>0){
8010551b:	83 ea 01             	sub    $0x1,%edx
8010551e:	75 f0                	jne    80105510 <itoa+0x80>
80105520:	01 c6                	add    %eax,%esi
  char * to_ret = kalloc() ;
80105522:	89 c7                	mov    %eax,%edi
  *(to_ret + q) = '\0';
80105524:	c6 06 00             	movb   $0x0,(%esi)
}
80105527:	83 c4 0c             	add    $0xc,%esp
8010552a:	89 f8                	mov    %edi,%eax
8010552c:	5b                   	pop    %ebx
8010552d:	5e                   	pop    %esi
8010552e:	5f                   	pop    %edi
8010552f:	5d                   	pop    %ebp
80105530:	c3                   	ret    
80105531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          *(s+k) = '7';
80105538:	c6 44 37 ff 37       	movb   $0x37,-0x1(%edi,%esi,1)
          break;
8010553d:	eb b1                	jmp    801054f0 <itoa+0x60>
8010553f:	90                   	nop
          *(s+k) = '6';
80105540:	c6 44 37 ff 36       	movb   $0x36,-0x1(%edi,%esi,1)
          break;
80105545:	eb a9                	jmp    801054f0 <itoa+0x60>
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          *(s+k) = '5';
80105550:	c6 44 37 ff 35       	movb   $0x35,-0x1(%edi,%esi,1)
          break;
80105555:	eb 99                	jmp    801054f0 <itoa+0x60>
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          *(s+k) = '4';
80105560:	c6 44 37 ff 34       	movb   $0x34,-0x1(%edi,%esi,1)
          break;
80105565:	eb 89                	jmp    801054f0 <itoa+0x60>
80105567:	89 f6                	mov    %esi,%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          *(s+k) = '3';
80105570:	c6 44 37 ff 33       	movb   $0x33,-0x1(%edi,%esi,1)
          break;
80105575:	e9 76 ff ff ff       	jmp    801054f0 <itoa+0x60>
8010557a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          *(s+k) = '2';
80105580:	c6 44 37 ff 32       	movb   $0x32,-0x1(%edi,%esi,1)
          break;
80105585:	e9 66 ff ff ff       	jmp    801054f0 <itoa+0x60>
8010558a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          *(s+k) = '1';
80105590:	c6 44 37 ff 31       	movb   $0x31,-0x1(%edi,%esi,1)
          break;
80105595:	e9 56 ff ff ff       	jmp    801054f0 <itoa+0x60>
8010559a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          *(s+k) = '0';
801055a0:	c6 44 37 ff 30       	movb   $0x30,-0x1(%edi,%esi,1)
          break;
801055a5:	e9 46 ff ff ff       	jmp    801054f0 <itoa+0x60>
801055aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          *(s+k) = '9';
801055b0:	c6 44 37 ff 39       	movb   $0x39,-0x1(%edi,%esi,1)
          break;
801055b5:	e9 36 ff ff ff       	jmp    801054f0 <itoa+0x60>
801055ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (n==0){ *(s+k) = '0'; k++; *(s+k) = '\0'; return s;}
801055c0:	b8 30 00 00 00       	mov    $0x30,%eax
801055c5:	66 89 07             	mov    %ax,(%edi)
}
801055c8:	83 c4 0c             	add    $0xc,%esp
801055cb:	89 f8                	mov    %edi,%eax
801055cd:	5b                   	pop    %ebx
801055ce:	5e                   	pop    %esi
801055cf:	5f                   	pop    %edi
801055d0:	5d                   	pop    %ebp
801055d1:	c3                   	ret    
801055d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char * to_ret = kalloc() ;
801055d8:	e8 53 ce ff ff       	call   80102430 <kalloc>
801055dd:	89 c7                	mov    %eax,%edi
801055df:	89 c6                	mov    %eax,%esi
801055e1:	e9 3e ff ff ff       	jmp    80105524 <itoa+0x94>
801055e6:	8d 76 00             	lea    0x0(%esi),%esi
801055e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055f0 <sys_dup>:
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	56                   	push   %esi
801055f4:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801055f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055f8:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801055fb:	e8 40 fe ff ff       	call   80105440 <argfd.constprop.0>
80105600:	85 c0                	test   %eax,%eax
80105602:	78 3c                	js     80105640 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80105604:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105607:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105609:	e8 b2 e1 ff ff       	call   801037c0 <myproc>
8010560e:	eb 0b                	jmp    8010561b <sys_dup+0x2b>
  for(fd = 0; fd < NOFILE; fd++){
80105610:	83 c3 01             	add    $0x1,%ebx
80105613:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80105619:	74 25                	je     80105640 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010561b:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010561f:	85 d2                	test   %edx,%edx
80105621:	75 ed                	jne    80105610 <sys_dup+0x20>
      curproc->ofile[fd] = f;
80105623:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105627:	83 ec 0c             	sub    $0xc,%esp
8010562a:	ff 75 f4             	pushl  -0xc(%ebp)
8010562d:	e8 be b7 ff ff       	call   80100df0 <filedup>
  return fd;
80105632:	83 c4 10             	add    $0x10,%esp
}
80105635:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105638:	89 d8                	mov    %ebx,%eax
8010563a:	5b                   	pop    %ebx
8010563b:	5e                   	pop    %esi
8010563c:	5d                   	pop    %ebp
8010563d:	c3                   	ret    
8010563e:	66 90                	xchg   %ax,%ax
80105640:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105643:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105648:	89 d8                	mov    %ebx,%eax
8010564a:	5b                   	pop    %ebx
8010564b:	5e                   	pop    %esi
8010564c:	5d                   	pop    %ebp
8010564d:	c3                   	ret    
8010564e:	66 90                	xchg   %ax,%ax

80105650 <new_read>:
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	53                   	push   %ebx
80105656:	83 ec 0c             	sub    $0xc,%esp
80105659:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010565c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010565f:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105662:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
80105668:	77 26                	ja     80105690 <new_read+0x40>
8010566a:	e8 51 e1 ff ff       	call   801037c0 <myproc>
8010566f:	8b 44 98 28          	mov    0x28(%eax,%ebx,4),%eax
80105673:	85 c0                	test   %eax,%eax
80105675:	74 19                	je     80105690 <new_read+0x40>
  return fileread(f, p, n);
80105677:	89 7d 10             	mov    %edi,0x10(%ebp)
8010567a:	89 75 0c             	mov    %esi,0xc(%ebp)
8010567d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80105680:	83 c4 0c             	add    $0xc,%esp
80105683:	5b                   	pop    %ebx
80105684:	5e                   	pop    %esi
80105685:	5f                   	pop    %edi
80105686:	5d                   	pop    %ebp
  return fileread(f, p, n);
80105687:	e9 14 b8 ff ff       	jmp    80100ea0 <fileread>
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80105690:	83 c4 0c             	add    $0xc,%esp
80105693:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105698:	5b                   	pop    %ebx
80105699:	5e                   	pop    %esi
8010569a:	5f                   	pop    %edi
8010569b:	5d                   	pop    %ebp
8010569c:	c3                   	ret    
8010569d:	8d 76 00             	lea    0x0(%esi),%esi

801056a0 <sys_read>:
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056a9:	e8 92 fd ff ff       	call   80105440 <argfd.constprop.0>
801056ae:	85 c0                	test   %eax,%eax
801056b0:	78 46                	js     801056f8 <sys_read+0x58>
801056b2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056b5:	83 ec 08             	sub    $0x8,%esp
801056b8:	50                   	push   %eax
801056b9:	6a 02                	push   $0x2
801056bb:	e8 e0 f9 ff ff       	call   801050a0 <argint>
801056c0:	83 c4 10             	add    $0x10,%esp
801056c3:	85 c0                	test   %eax,%eax
801056c5:	78 31                	js     801056f8 <sys_read+0x58>
801056c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ca:	83 ec 04             	sub    $0x4,%esp
801056cd:	ff 75 f0             	pushl  -0x10(%ebp)
801056d0:	50                   	push   %eax
801056d1:	6a 01                	push   $0x1
801056d3:	e8 18 fa ff ff       	call   801050f0 <argptr>
801056d8:	83 c4 10             	add    $0x10,%esp
801056db:	85 c0                	test   %eax,%eax
801056dd:	78 19                	js     801056f8 <sys_read+0x58>
  return fileread(f, p, n);
801056df:	83 ec 04             	sub    $0x4,%esp
801056e2:	ff 75 f0             	pushl  -0x10(%ebp)
801056e5:	ff 75 f4             	pushl  -0xc(%ebp)
801056e8:	ff 75 ec             	pushl  -0x14(%ebp)
801056eb:	e8 b0 b7 ff ff       	call   80100ea0 <fileread>
801056f0:	83 c4 10             	add    $0x10,%esp
}
801056f3:	c9                   	leave  
801056f4:	c3                   	ret    
801056f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801056f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056fd:	c9                   	leave  
801056fe:	c3                   	ret    
801056ff:	90                   	nop

80105700 <new_write>:
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	57                   	push   %edi
80105704:	56                   	push   %esi
80105705:	53                   	push   %ebx
80105706:	83 ec 0c             	sub    $0xc,%esp
80105709:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010570c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010570f:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105712:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
80105718:	77 26                	ja     80105740 <new_write+0x40>
8010571a:	e8 a1 e0 ff ff       	call   801037c0 <myproc>
8010571f:	8b 44 98 28          	mov    0x28(%eax,%ebx,4),%eax
80105723:	85 c0                	test   %eax,%eax
80105725:	74 19                	je     80105740 <new_write+0x40>
  return filewrite(f, p, n);
80105727:	89 7d 10             	mov    %edi,0x10(%ebp)
8010572a:	89 75 0c             	mov    %esi,0xc(%ebp)
8010572d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80105730:	83 c4 0c             	add    $0xc,%esp
80105733:	5b                   	pop    %ebx
80105734:	5e                   	pop    %esi
80105735:	5f                   	pop    %edi
80105736:	5d                   	pop    %ebp
  return filewrite(f, p, n);
80105737:	e9 f4 b7 ff ff       	jmp    80100f30 <filewrite>
8010573c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80105740:	83 c4 0c             	add    $0xc,%esp
80105743:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105748:	5b                   	pop    %ebx
80105749:	5e                   	pop    %esi
8010574a:	5f                   	pop    %edi
8010574b:	5d                   	pop    %ebp
8010574c:	c3                   	ret    
8010574d:	8d 76 00             	lea    0x0(%esi),%esi

80105750 <sys_write>:
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105756:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105759:	e8 e2 fc ff ff       	call   80105440 <argfd.constprop.0>
8010575e:	85 c0                	test   %eax,%eax
80105760:	78 46                	js     801057a8 <sys_write+0x58>
80105762:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105765:	83 ec 08             	sub    $0x8,%esp
80105768:	50                   	push   %eax
80105769:	6a 02                	push   $0x2
8010576b:	e8 30 f9 ff ff       	call   801050a0 <argint>
80105770:	83 c4 10             	add    $0x10,%esp
80105773:	85 c0                	test   %eax,%eax
80105775:	78 31                	js     801057a8 <sys_write+0x58>
80105777:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010577a:	83 ec 04             	sub    $0x4,%esp
8010577d:	ff 75 f0             	pushl  -0x10(%ebp)
80105780:	50                   	push   %eax
80105781:	6a 01                	push   $0x1
80105783:	e8 68 f9 ff ff       	call   801050f0 <argptr>
80105788:	83 c4 10             	add    $0x10,%esp
8010578b:	85 c0                	test   %eax,%eax
8010578d:	78 19                	js     801057a8 <sys_write+0x58>
  return filewrite(f, p, n);
8010578f:	83 ec 04             	sub    $0x4,%esp
80105792:	ff 75 f0             	pushl  -0x10(%ebp)
80105795:	ff 75 f4             	pushl  -0xc(%ebp)
80105798:	ff 75 ec             	pushl  -0x14(%ebp)
8010579b:	e8 90 b7 ff ff       	call   80100f30 <filewrite>
801057a0:	83 c4 10             	add    $0x10,%esp
}
801057a3:	c9                   	leave  
801057a4:	c3                   	ret    
801057a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057ad:	c9                   	leave  
801057ae:	c3                   	ret    
801057af:	90                   	nop

801057b0 <sys_close>:
{
801057b0:	55                   	push   %ebp
}
801057b1:	31 c0                	xor    %eax,%eax
{
801057b3:	89 e5                	mov    %esp,%ebp
}
801057b5:	5d                   	pop    %ebp
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <sys_fstat>:
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057c9:	e8 72 fc ff ff       	call   80105440 <argfd.constprop.0>
801057ce:	85 c0                	test   %eax,%eax
801057d0:	78 2e                	js     80105800 <sys_fstat+0x40>
801057d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d5:	83 ec 04             	sub    $0x4,%esp
801057d8:	6a 1c                	push   $0x1c
801057da:	50                   	push   %eax
801057db:	6a 01                	push   $0x1
801057dd:	e8 0e f9 ff ff       	call   801050f0 <argptr>
801057e2:	83 c4 10             	add    $0x10,%esp
801057e5:	85 c0                	test   %eax,%eax
801057e7:	78 17                	js     80105800 <sys_fstat+0x40>
  return filestat(f, st);
801057e9:	83 ec 08             	sub    $0x8,%esp
801057ec:	ff 75 f4             	pushl  -0xc(%ebp)
801057ef:	ff 75 f0             	pushl  -0x10(%ebp)
801057f2:	e8 59 b6 ff ff       	call   80100e50 <filestat>
801057f7:	83 c4 10             	add    $0x10,%esp
}
801057fa:	c9                   	leave  
801057fb:	c3                   	ret    
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105805:	c9                   	leave  
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_link>:
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	57                   	push   %edi
80105814:	56                   	push   %esi
80105815:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105816:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105819:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010581c:	50                   	push   %eax
8010581d:	6a 00                	push   $0x0
8010581f:	e8 2c f9 ff ff       	call   80105150 <argstr>
80105824:	83 c4 10             	add    $0x10,%esp
80105827:	85 c0                	test   %eax,%eax
80105829:	0f 88 fb 00 00 00    	js     8010592a <sys_link+0x11a>
8010582f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105832:	83 ec 08             	sub    $0x8,%esp
80105835:	50                   	push   %eax
80105836:	6a 01                	push   $0x1
80105838:	e8 13 f9 ff ff       	call   80105150 <argstr>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	85 c0                	test   %eax,%eax
80105842:	0f 88 e2 00 00 00    	js     8010592a <sys_link+0x11a>
  begin_op();
80105848:	e8 c3 d2 ff ff       	call   80102b10 <begin_op>
  if((ip = namei(old)) == 0){
8010584d:	83 ec 0c             	sub    $0xc,%esp
80105850:	ff 75 d4             	pushl  -0x2c(%ebp)
80105853:	e8 f8 c5 ff ff       	call   80101e50 <namei>
80105858:	83 c4 10             	add    $0x10,%esp
8010585b:	85 c0                	test   %eax,%eax
8010585d:	89 c3                	mov    %eax,%ebx
8010585f:	0f 84 ea 00 00 00    	je     8010594f <sys_link+0x13f>
  ilock(ip);
80105865:	83 ec 0c             	sub    $0xc,%esp
80105868:	50                   	push   %eax
80105869:	e8 62 bd ff ff       	call   801015d0 <ilock>
  if(ip->type == T_DIR){
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105876:	0f 84 bb 00 00 00    	je     80105937 <sys_link+0x127>
  ip->nlink++;
8010587c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105881:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105884:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105887:	53                   	push   %ebx
80105888:	e8 93 bc ff ff       	call   80101520 <iupdate>
  iunlock(ip);
8010588d:	89 1c 24             	mov    %ebx,(%esp)
80105890:	e8 1b be ff ff       	call   801016b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105895:	58                   	pop    %eax
80105896:	5a                   	pop    %edx
80105897:	57                   	push   %edi
80105898:	ff 75 d0             	pushl  -0x30(%ebp)
8010589b:	e8 d0 c5 ff ff       	call   80101e70 <nameiparent>
801058a0:	83 c4 10             	add    $0x10,%esp
801058a3:	85 c0                	test   %eax,%eax
801058a5:	89 c6                	mov    %eax,%esi
801058a7:	74 5b                	je     80105904 <sys_link+0xf4>
  ilock(dp);
801058a9:	83 ec 0c             	sub    $0xc,%esp
801058ac:	50                   	push   %eax
801058ad:	e8 1e bd ff ff       	call   801015d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	8b 03                	mov    (%ebx),%eax
801058b7:	39 06                	cmp    %eax,(%esi)
801058b9:	75 3d                	jne    801058f8 <sys_link+0xe8>
801058bb:	83 ec 04             	sub    $0x4,%esp
801058be:	ff 73 04             	pushl  0x4(%ebx)
801058c1:	57                   	push   %edi
801058c2:	56                   	push   %esi
801058c3:	e8 c8 c4 ff ff       	call   80101d90 <dirlink>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	78 29                	js     801058f8 <sys_link+0xe8>
  iunlockput(dp);
801058cf:	83 ec 0c             	sub    $0xc,%esp
801058d2:	56                   	push   %esi
801058d3:	e8 88 bf ff ff       	call   80101860 <iunlockput>
  iput(ip);
801058d8:	89 1c 24             	mov    %ebx,(%esp)
801058db:	e8 20 be ff ff       	call   80101700 <iput>
  end_op();
801058e0:	e8 9b d2 ff ff       	call   80102b80 <end_op>
  return 0;
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	31 c0                	xor    %eax,%eax
}
801058ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058ed:	5b                   	pop    %ebx
801058ee:	5e                   	pop    %esi
801058ef:	5f                   	pop    %edi
801058f0:	5d                   	pop    %ebp
801058f1:	c3                   	ret    
801058f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	56                   	push   %esi
801058fc:	e8 5f bf ff ff       	call   80101860 <iunlockput>
    goto bad;
80105901:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105904:	83 ec 0c             	sub    $0xc,%esp
80105907:	53                   	push   %ebx
80105908:	e8 c3 bc ff ff       	call   801015d0 <ilock>
  ip->nlink--;
8010590d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105912:	89 1c 24             	mov    %ebx,(%esp)
80105915:	e8 06 bc ff ff       	call   80101520 <iupdate>
  iunlockput(ip);
8010591a:	89 1c 24             	mov    %ebx,(%esp)
8010591d:	e8 3e bf ff ff       	call   80101860 <iunlockput>
  end_op();
80105922:	e8 59 d2 ff ff       	call   80102b80 <end_op>
  return -1;
80105927:	83 c4 10             	add    $0x10,%esp
}
8010592a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010592d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105932:	5b                   	pop    %ebx
80105933:	5e                   	pop    %esi
80105934:	5f                   	pop    %edi
80105935:	5d                   	pop    %ebp
80105936:	c3                   	ret    
    iunlockput(ip);
80105937:	83 ec 0c             	sub    $0xc,%esp
8010593a:	53                   	push   %ebx
8010593b:	e8 20 bf ff ff       	call   80101860 <iunlockput>
    end_op();
80105940:	e8 3b d2 ff ff       	call   80102b80 <end_op>
    return -1;
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	eb 9b                	jmp    801058ea <sys_link+0xda>
    end_op();
8010594f:	e8 2c d2 ff ff       	call   80102b80 <end_op>
    return -1;
80105954:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105959:	eb 8f                	jmp    801058ea <sys_link+0xda>
8010595b:	90                   	nop
8010595c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105960 <sys_unlink>:
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	57                   	push   %edi
80105964:	56                   	push   %esi
80105965:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105966:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105969:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010596c:	50                   	push   %eax
8010596d:	6a 00                	push   $0x0
8010596f:	e8 dc f7 ff ff       	call   80105150 <argstr>
80105974:	83 c4 10             	add    $0x10,%esp
80105977:	85 c0                	test   %eax,%eax
80105979:	0f 88 77 01 00 00    	js     80105af6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010597f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105982:	e8 89 d1 ff ff       	call   80102b10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105987:	83 ec 08             	sub    $0x8,%esp
8010598a:	53                   	push   %ebx
8010598b:	ff 75 c0             	pushl  -0x40(%ebp)
8010598e:	e8 dd c4 ff ff       	call   80101e70 <nameiparent>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	89 c6                	mov    %eax,%esi
8010599a:	0f 84 60 01 00 00    	je     80105b00 <sys_unlink+0x1a0>
  ilock(dp);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	50                   	push   %eax
801059a4:	e8 27 bc ff ff       	call   801015d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801059a9:	58                   	pop    %eax
801059aa:	5a                   	pop    %edx
801059ab:	68 14 90 10 80       	push   $0x80109014
801059b0:	53                   	push   %ebx
801059b1:	e8 3a c1 ff ff       	call   80101af0 <namecmp>
801059b6:	83 c4 10             	add    $0x10,%esp
801059b9:	85 c0                	test   %eax,%eax
801059bb:	0f 84 03 01 00 00    	je     80105ac4 <sys_unlink+0x164>
801059c1:	83 ec 08             	sub    $0x8,%esp
801059c4:	68 13 90 10 80       	push   $0x80109013
801059c9:	53                   	push   %ebx
801059ca:	e8 21 c1 ff ff       	call   80101af0 <namecmp>
801059cf:	83 c4 10             	add    $0x10,%esp
801059d2:	85 c0                	test   %eax,%eax
801059d4:	0f 84 ea 00 00 00    	je     80105ac4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801059da:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801059dd:	83 ec 04             	sub    $0x4,%esp
801059e0:	50                   	push   %eax
801059e1:	53                   	push   %ebx
801059e2:	56                   	push   %esi
801059e3:	e8 28 c1 ff ff       	call   80101b10 <dirlookup>
801059e8:	83 c4 10             	add    $0x10,%esp
801059eb:	85 c0                	test   %eax,%eax
801059ed:	89 c3                	mov    %eax,%ebx
801059ef:	0f 84 cf 00 00 00    	je     80105ac4 <sys_unlink+0x164>
  ilock(ip);
801059f5:	83 ec 0c             	sub    $0xc,%esp
801059f8:	50                   	push   %eax
801059f9:	e8 d2 bb ff ff       	call   801015d0 <ilock>
  if(ip->nlink < 1)
801059fe:	83 c4 10             	add    $0x10,%esp
80105a01:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105a06:	0f 8e 10 01 00 00    	jle    80105b1c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a11:	74 6d                	je     80105a80 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105a13:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a16:	83 ec 04             	sub    $0x4,%esp
80105a19:	6a 10                	push   $0x10
80105a1b:	6a 00                	push   $0x0
80105a1d:	50                   	push   %eax
80105a1e:	e8 7d f3 ff ff       	call   80104da0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a23:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a26:	6a 10                	push   $0x10
80105a28:	ff 75 c4             	pushl  -0x3c(%ebp)
80105a2b:	50                   	push   %eax
80105a2c:	56                   	push   %esi
80105a2d:	e8 8e bf ff ff       	call   801019c0 <writei>
80105a32:	83 c4 20             	add    $0x20,%esp
80105a35:	83 f8 10             	cmp    $0x10,%eax
80105a38:	0f 85 eb 00 00 00    	jne    80105b29 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105a3e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a43:	0f 84 97 00 00 00    	je     80105ae0 <sys_unlink+0x180>
  iunlockput(dp);
80105a49:	83 ec 0c             	sub    $0xc,%esp
80105a4c:	56                   	push   %esi
80105a4d:	e8 0e be ff ff       	call   80101860 <iunlockput>
  ip->nlink--;
80105a52:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a57:	89 1c 24             	mov    %ebx,(%esp)
80105a5a:	e8 c1 ba ff ff       	call   80101520 <iupdate>
  iunlockput(ip);
80105a5f:	89 1c 24             	mov    %ebx,(%esp)
80105a62:	e8 f9 bd ff ff       	call   80101860 <iunlockput>
  end_op();
80105a67:	e8 14 d1 ff ff       	call   80102b80 <end_op>
  return 0;
80105a6c:	83 c4 10             	add    $0x10,%esp
80105a6f:	31 c0                	xor    %eax,%eax
}
80105a71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a74:	5b                   	pop    %ebx
80105a75:	5e                   	pop    %esi
80105a76:	5f                   	pop    %edi
80105a77:	5d                   	pop    %ebp
80105a78:	c3                   	ret    
80105a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a80:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105a84:	76 8d                	jbe    80105a13 <sys_unlink+0xb3>
80105a86:	bf 20 00 00 00       	mov    $0x20,%edi
80105a8b:	eb 0f                	jmp    80105a9c <sys_unlink+0x13c>
80105a8d:	8d 76 00             	lea    0x0(%esi),%esi
80105a90:	83 c7 10             	add    $0x10,%edi
80105a93:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105a96:	0f 83 77 ff ff ff    	jae    80105a13 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a9c:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a9f:	6a 10                	push   $0x10
80105aa1:	57                   	push   %edi
80105aa2:	50                   	push   %eax
80105aa3:	53                   	push   %ebx
80105aa4:	e8 17 be ff ff       	call   801018c0 <readi>
80105aa9:	83 c4 10             	add    $0x10,%esp
80105aac:	83 f8 10             	cmp    $0x10,%eax
80105aaf:	75 5e                	jne    80105b0f <sys_unlink+0x1af>
    if(de.inum != 0)
80105ab1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105ab6:	74 d8                	je     80105a90 <sys_unlink+0x130>
    iunlockput(ip);
80105ab8:	83 ec 0c             	sub    $0xc,%esp
80105abb:	53                   	push   %ebx
80105abc:	e8 9f bd ff ff       	call   80101860 <iunlockput>
    goto bad;
80105ac1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105ac4:	83 ec 0c             	sub    $0xc,%esp
80105ac7:	56                   	push   %esi
80105ac8:	e8 93 bd ff ff       	call   80101860 <iunlockput>
  end_op();
80105acd:	e8 ae d0 ff ff       	call   80102b80 <end_op>
  return -1;
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ada:	eb 95                	jmp    80105a71 <sys_unlink+0x111>
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105ae0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105ae5:	83 ec 0c             	sub    $0xc,%esp
80105ae8:	56                   	push   %esi
80105ae9:	e8 32 ba ff ff       	call   80101520 <iupdate>
80105aee:	83 c4 10             	add    $0x10,%esp
80105af1:	e9 53 ff ff ff       	jmp    80105a49 <sys_unlink+0xe9>
    return -1;
80105af6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afb:	e9 71 ff ff ff       	jmp    80105a71 <sys_unlink+0x111>
    end_op();
80105b00:	e8 7b d0 ff ff       	call   80102b80 <end_op>
    return -1;
80105b05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b0a:	e9 62 ff ff ff       	jmp    80105a71 <sys_unlink+0x111>
      panic("isdirempty: readi");
80105b0f:	83 ec 0c             	sub    $0xc,%esp
80105b12:	68 38 90 10 80       	push   $0x80109038
80105b17:	e8 74 a8 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105b1c:	83 ec 0c             	sub    $0xc,%esp
80105b1f:	68 26 90 10 80       	push   $0x80109026
80105b24:	e8 67 a8 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105b29:	83 ec 0c             	sub    $0xc,%esp
80105b2c:	68 4a 90 10 80       	push   $0x8010904a
80105b31:	e8 5a a8 ff ff       	call   80100390 <panic>
80105b36:	8d 76 00             	lea    0x0(%esi),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b40 <new_open>:


int
new_open(char *path, int omode)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	57                   	push   %edi
80105b44:	56                   	push   %esi
80105b45:	53                   	push   %ebx
80105b46:	83 ec 1c             	sub    $0x1c,%esp
80105b49:	8b 7d 08             	mov    0x8(%ebp),%edi

  // if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  //   return -1;

  
  begin_op();
80105b4c:	e8 bf cf ff ff       	call   80102b10 <begin_op>

  if(omode & O_CREATE){
80105b51:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b54:	25 00 02 00 00       	and    $0x200,%eax
80105b59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105b5c:	0f 84 ae 00 00 00    	je     80105c10 <new_open+0xd0>
     int l  = strlen(path);
80105b62:	83 ec 0c             	sub    $0xc,%esp
80105b65:	57                   	push   %edi
80105b66:	e8 55 f4 ff ff       	call   80104fc0 <strlen>
80105b6b:	89 c3                	mov    %eax,%ebx

    if(myproc()->in_container_id > 0 ){
80105b6d:	e8 4e dc ff ff       	call   801037c0 <myproc>
80105b72:	8b 80 7c 10 00 00    	mov    0x107c(%eax),%eax
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	85 c0                	test   %eax,%eax
80105b7d:	0f 8e cd 01 00 00    	jle    80105d50 <new_open+0x210>

      char * new_path = kalloc();
80105b83:	e8 a8 c8 ff ff       	call   80102430 <kalloc>
      int i = 0;
      while(i<l){
80105b88:	85 db                	test   %ebx,%ebx
      char * new_path = kalloc();
80105b8a:	89 c6                	mov    %eax,%esi
      while(i<l){
80105b8c:	7e 10                	jle    80105b9e <new_open+0x5e>
      int i = 0;
80105b8e:	31 c0                	xor    %eax,%eax
        *(new_path + i) = *(path + i );
80105b90:	0f b6 14 07          	movzbl (%edi,%eax,1),%edx
80105b94:	88 14 06             	mov    %dl,(%esi,%eax,1)
        i++;
80105b97:	83 c0 01             	add    $0x1,%eax
      while(i<l){
80105b9a:	39 c3                	cmp    %eax,%ebx
80105b9c:	75 f2                	jne    80105b90 <new_open+0x50>
       }


     char * cid_str = itoa(myproc()->in_container_id);
80105b9e:	e8 1d dc ff ff       	call   801037c0 <myproc>
80105ba3:	83 ec 0c             	sub    $0xc,%esp
80105ba6:	ff b0 7c 10 00 00    	pushl  0x107c(%eax)
80105bac:	e8 df f8 ff ff       	call   80105490 <itoa>
     int c_len = strlen(cid_str);
80105bb1:	89 04 24             	mov    %eax,(%esp)
     char * cid_str = itoa(myproc()->in_container_id);
80105bb4:	89 c7                	mov    %eax,%edi
     int c_len = strlen(cid_str);
80105bb6:	e8 05 f4 ff ff       	call   80104fc0 <strlen>
     i = 0 ;
     while(i<c_len){
80105bbb:	83 c4 10             	add    $0x10,%esp
80105bbe:	85 c0                	test   %eax,%eax
80105bc0:	7e 1f                	jle    80105be1 <new_open+0xa1>
80105bc2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
     i = 0 ;
80105bc5:	31 d2                	xor    %edx,%edx
80105bc7:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80105bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *(new_path+l+ i) = *(cid_str+i);
80105bd0:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
80105bd4:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
      i++;
80105bd7:	83 c2 01             	add    $0x1,%edx
     while(i<c_len){
80105bda:	39 d0                	cmp    %edx,%eax
80105bdc:	75 f2                	jne    80105bd0 <new_open+0x90>
80105bde:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
     }
     // *(path + l+ i )= '\0';
     // cprintf("Path is %s", path);
    ip = create(new_path, T_FILE, 0, 0);
80105be1:	83 ec 0c             	sub    $0xc,%esp
80105be4:	89 f0                	mov    %esi,%eax
80105be6:	31 c9                	xor    %ecx,%ecx
80105be8:	6a 00                	push   $0x0
80105bea:	ba 02 00 00 00       	mov    $0x2,%edx
80105bef:	e8 ac f6 ff ff       	call   801052a0 <create>
80105bf4:	83 c4 10             	add    $0x10,%esp
80105bf7:	89 c6                	mov    %eax,%esi
    else{
      ip = create(path, T_FILE, 0, 0);
    }
    // ADDED /
    flag = 1;
    ip->path_len = l;
80105bf9:	89 9e 94 00 00 00    	mov    %ebx,0x94(%esi)
    flag = 1;
80105bff:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
80105c06:	e9 c7 00 00 00       	jmp    80105cd2 <new_open+0x192>
80105c0b:	90                   	nop
80105c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      end_op();
      return -1;
    }
  } else {

    if (myproc()->in_container_id > 0){
80105c10:	e8 ab db ff ff       	call   801037c0 <myproc>
80105c15:	8b b0 7c 10 00 00    	mov    0x107c(%eax),%esi
80105c1b:	85 f6                	test   %esi,%esi
80105c1d:	0f 8e 4d 01 00 00    	jle    80105d70 <new_open+0x230>

      ip_old  = namei(path);
80105c23:	83 ec 0c             	sub    $0xc,%esp
80105c26:	57                   	push   %edi
80105c27:	e8 24 c2 ff ff       	call   80101e50 <namei>

       int l  = strlen(path);
80105c2c:	89 3c 24             	mov    %edi,(%esp)
      ip_old  = namei(path);
80105c2f:	89 45 e0             	mov    %eax,-0x20(%ebp)
       int l  = strlen(path);
80105c32:	e8 89 f3 ff ff       	call   80104fc0 <strlen>
80105c37:	89 c3                	mov    %eax,%ebx

      char * new_path = kalloc();
80105c39:	e8 f2 c7 ff ff       	call   80102430 <kalloc>
      int i = 0;
      while(i<l){
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	85 db                	test   %ebx,%ebx
      char * new_path = kalloc();
80105c43:	89 c6                	mov    %eax,%esi
      while(i<l){
80105c45:	7e 17                	jle    80105c5e <new_open+0x11e>
      int i = 0;
80105c47:	31 c0                	xor    %eax,%eax
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        *(new_path + i) = *(path + i );
80105c50:	0f b6 14 07          	movzbl (%edi,%eax,1),%edx
80105c54:	88 14 06             	mov    %dl,(%esi,%eax,1)
        i++;
80105c57:	83 c0 01             	add    $0x1,%eax
      while(i<l){
80105c5a:	39 c3                	cmp    %eax,%ebx
80105c5c:	75 f2                	jne    80105c50 <new_open+0x110>
       }

       char * cid_str = itoa(myproc()->in_container_id);
80105c5e:	e8 5d db ff ff       	call   801037c0 <myproc>
80105c63:	83 ec 0c             	sub    $0xc,%esp
80105c66:	ff b0 7c 10 00 00    	pushl  0x107c(%eax)
80105c6c:	e8 1f f8 ff ff       	call   80105490 <itoa>
       int c_len = strlen(cid_str);
80105c71:	89 04 24             	mov    %eax,(%esp)
       char * cid_str = itoa(myproc()->in_container_id);
80105c74:	89 c7                	mov    %eax,%edi
       int c_len = strlen(cid_str);
80105c76:	e8 45 f3 ff ff       	call   80104fc0 <strlen>
       i = 0 ;
       while(i<c_len){
80105c7b:	83 c4 10             	add    $0x10,%esp
80105c7e:	85 c0                	test   %eax,%eax
80105c80:	7e 1c                	jle    80105c9e <new_open+0x15e>
80105c82:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
       i = 0 ;
80105c85:	31 d2                	xor    %edx,%edx
80105c87:	89 f6                	mov    %esi,%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        *(new_path+l+ i) = *(cid_str+i);
80105c90:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
80105c94:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
        i++;
80105c97:	83 c2 01             	add    $0x1,%edx
       while(i<c_len){
80105c9a:	39 d0                	cmp    %edx,%eax
80105c9c:	75 f2                	jne    80105c90 <new_open+0x150>
       }
      if((ip = namei(new_path)) == 0){
80105c9e:	83 ec 0c             	sub    $0xc,%esp
80105ca1:	56                   	push   %esi
80105ca2:	e8 a9 c1 ff ff       	call   80101e50 <namei>
80105ca7:	83 c4 10             	add    $0x10,%esp
80105caa:	85 c0                	test   %eax,%eax
80105cac:	89 c6                	mov    %eax,%esi
80105cae:	0f 84 fa 00 00 00    	je     80105dae <new_open+0x26e>
      if((ip = namei(path)) == 0){
        end_op();
        return -1;
      }
    }
    ilock(ip);
80105cb4:	83 ec 0c             	sub    $0xc,%esp
80105cb7:	56                   	push   %esi
80105cb8:	e8 13 b9 ff ff       	call   801015d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105cbd:	83 c4 10             	add    $0x10,%esp
80105cc0:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105cc5:	75 0b                	jne    80105cd2 <new_open+0x192>
80105cc7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105cca:	85 c9                	test   %ecx,%ecx
80105ccc:	0f 85 fa 00 00 00    	jne    80105dcc <new_open+0x28c>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105cd2:	e8 a9 b0 ff ff       	call   80100d80 <filealloc>
80105cd7:	85 c0                	test   %eax,%eax
80105cd9:	89 c3                	mov    %eax,%ebx
80105cdb:	0f 84 eb 00 00 00    	je     80105dcc <new_open+0x28c>
  struct proc *curproc = myproc();
80105ce1:	e8 da da ff ff       	call   801037c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105ce6:	31 ff                	xor    %edi,%edi
80105ce8:	eb 15                	jmp    80105cff <new_open+0x1bf>
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cf0:	83 c7 01             	add    $0x1,%edi
80105cf3:	81 ff 00 04 00 00    	cmp    $0x400,%edi
80105cf9:	0f 84 c1 00 00 00    	je     80105dc0 <new_open+0x280>
    if(curproc->ofile[fd] == 0){
80105cff:	8b 54 b8 28          	mov    0x28(%eax,%edi,4),%edx
80105d03:	85 d2                	test   %edx,%edx
80105d05:	75 e9                	jne    80105cf0 <new_open+0x1b0>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105d07:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105d0a:	89 5c b8 28          	mov    %ebx,0x28(%eax,%edi,4)
  iunlock(ip);
80105d0e:	56                   	push   %esi
80105d0f:	e8 9c b9 ff ff       	call   801016b0 <iunlock>
  end_op();
80105d14:	e8 67 ce ff ff       	call   80102b80 <end_op>

  //// ADDED
  if(flag==1){
80105d19:	83 c4 10             	add    $0x10,%esp
80105d1c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
80105d20:	74 76                	je     80105d98 <new_open+0x258>
  ///////////////////////

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  f->type = FD_INODE;
80105d25:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80105d2b:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80105d2e:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80105d35:	f7 d0                	not    %eax
80105d37:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d3a:	f6 45 0c 03          	testb  $0x3,0xc(%ebp)
  f->readable = !(omode & O_WRONLY);
80105d3e:	88 43 08             	mov    %al,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d41:	0f 95 43 09          	setne  0x9(%ebx)
  //   new_write(fd2,buffer,f->ip->size);
  //   return fd2;
  // }
  //////////////////////
  return fd;
}
80105d45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d48:	89 f8                	mov    %edi,%eax
80105d4a:	5b                   	pop    %ebx
80105d4b:	5e                   	pop    %esi
80105d4c:	5f                   	pop    %edi
80105d4d:	5d                   	pop    %ebp
80105d4e:	c3                   	ret    
80105d4f:	90                   	nop
      ip = create(path, T_FILE, 0, 0);
80105d50:	83 ec 0c             	sub    $0xc,%esp
80105d53:	31 c9                	xor    %ecx,%ecx
80105d55:	ba 02 00 00 00       	mov    $0x2,%edx
80105d5a:	6a 00                	push   $0x0
80105d5c:	89 f8                	mov    %edi,%eax
80105d5e:	e8 3d f5 ff ff       	call   801052a0 <create>
80105d63:	83 c4 10             	add    $0x10,%esp
80105d66:	89 c6                	mov    %eax,%esi
80105d68:	e9 8c fe ff ff       	jmp    80105bf9 <new_open+0xb9>
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi
      if((ip = namei(path)) == 0){
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	57                   	push   %edi
80105d74:	e8 d7 c0 ff ff       	call   80101e50 <namei>
80105d79:	83 c4 10             	add    $0x10,%esp
80105d7c:	85 c0                	test   %eax,%eax
80105d7e:	89 c6                	mov    %eax,%esi
80105d80:	0f 85 2e ff ff ff    	jne    80105cb4 <new_open+0x174>
          end_op();
80105d86:	e8 f5 cd ff ff       	call   80102b80 <end_op>
          return -1;
80105d8b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80105d90:	eb b3                	jmp    80105d45 <new_open+0x205>
80105d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip->cid = myproc()->in_container_id;
80105d98:	e8 23 da ff ff       	call   801037c0 <myproc>
80105d9d:	8b 80 7c 10 00 00    	mov    0x107c(%eax),%eax
80105da3:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
80105da9:	e9 74 ff ff ff       	jmp    80105d22 <new_open+0x1e2>
        if (ip_old==0){
80105dae:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105db1:	85 db                	test   %ebx,%ebx
80105db3:	74 d1                	je     80105d86 <new_open+0x246>
80105db5:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105db8:	e9 f7 fe ff ff       	jmp    80105cb4 <new_open+0x174>
80105dbd:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80105dc0:	83 ec 0c             	sub    $0xc,%esp
80105dc3:	53                   	push   %ebx
80105dc4:	e8 77 b0 ff ff       	call   80100e40 <fileclose>
80105dc9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105dcc:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80105dcf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    iunlockput(ip);
80105dd4:	56                   	push   %esi
80105dd5:	e8 86 ba ff ff       	call   80101860 <iunlockput>
    end_op();
80105dda:	e8 a1 cd ff ff       	call   80102b80 <end_op>
    return -1;
80105ddf:	83 c4 10             	add    $0x10,%esp
80105de2:	e9 5e ff ff ff       	jmp    80105d45 <new_open+0x205>
80105de7:	89 f6                	mov    %esi,%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105df0 <sys_open>:

int
sys_open(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	57                   	push   %edi
80105df4:	56                   	push   %esi
80105df5:	53                   	push   %ebx
  int flag_read = 0;
  // cprintf("Entered in open");
  //////////////


  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105df6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105df9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dfc:	50                   	push   %eax
80105dfd:	6a 00                	push   $0x0
80105dff:	e8 4c f3 ff ff       	call   80105150 <argstr>
80105e04:	83 c4 10             	add    $0x10,%esp
80105e07:	85 c0                	test   %eax,%eax
80105e09:	0f 88 20 03 00 00    	js     8010612f <sys_open+0x33f>
80105e0f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e12:	83 ec 08             	sub    $0x8,%esp
80105e15:	50                   	push   %eax
80105e16:	6a 01                	push   $0x1
80105e18:	e8 83 f2 ff ff       	call   801050a0 <argint>
80105e1d:	83 c4 10             	add    $0x10,%esp
80105e20:	85 c0                	test   %eax,%eax
80105e22:	0f 88 07 03 00 00    	js     8010612f <sys_open+0x33f>
    return -1;

  
  begin_op();
80105e28:	e8 e3 cc ff ff       	call   80102b10 <begin_op>

  if(omode & O_CREATE){
80105e2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e30:	25 00 02 00 00       	and    $0x200,%eax
80105e35:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105e38:	0f 84 ba 00 00 00    	je     80105ef8 <sys_open+0x108>
     int l  = strlen(path);
80105e3e:	83 ec 0c             	sub    $0xc,%esp
80105e41:	ff 75 e0             	pushl  -0x20(%ebp)
80105e44:	e8 77 f1 ff ff       	call   80104fc0 <strlen>
80105e49:	89 c3                	mov    %eax,%ebx

    if(myproc()->in_container_id > 0 ){
80105e4b:	e8 70 d9 ff ff       	call   801037c0 <myproc>
80105e50:	8b b8 7c 10 00 00    	mov    0x107c(%eax),%edi
80105e56:	83 c4 10             	add    $0x10,%esp
80105e59:	85 ff                	test   %edi,%edi
80105e5b:	0f 8e 6f 02 00 00    	jle    801060d0 <sys_open+0x2e0>

      char * new_path = kalloc();
80105e61:	e8 ca c5 ff ff       	call   80102430 <kalloc>
      int i = 0;
      while(i<l){
80105e66:	85 db                	test   %ebx,%ebx
      char * new_path = kalloc();
80105e68:	89 c6                	mov    %eax,%esi
      while(i<l){
80105e6a:	7e 15                	jle    80105e81 <sys_open+0x91>
      int i = 0;
80105e6c:	31 c0                	xor    %eax,%eax
80105e6e:	66 90                	xchg   %ax,%ax
        *(new_path + i) = *(path + i );
80105e70:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105e73:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
80105e77:	88 14 06             	mov    %dl,(%esi,%eax,1)
        i++;
80105e7a:	83 c0 01             	add    $0x1,%eax
      while(i<l){
80105e7d:	39 c3                	cmp    %eax,%ebx
80105e7f:	75 ef                	jne    80105e70 <sys_open+0x80>
       }


     char * cid_str = itoa(myproc()->in_container_id);
80105e81:	e8 3a d9 ff ff       	call   801037c0 <myproc>
80105e86:	83 ec 0c             	sub    $0xc,%esp
80105e89:	ff b0 7c 10 00 00    	pushl  0x107c(%eax)
80105e8f:	e8 fc f5 ff ff       	call   80105490 <itoa>
     int c_len = strlen(cid_str);
80105e94:	89 04 24             	mov    %eax,(%esp)
     char * cid_str = itoa(myproc()->in_container_id);
80105e97:	89 c7                	mov    %eax,%edi
     int c_len = strlen(cid_str);
80105e99:	e8 22 f1 ff ff       	call   80104fc0 <strlen>
     i = 0 ;
     while(i<c_len){
80105e9e:	83 c4 10             	add    $0x10,%esp
80105ea1:	85 c0                	test   %eax,%eax
80105ea3:	7e 1c                	jle    80105ec1 <sys_open+0xd1>
80105ea5:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
     i = 0 ;
80105ea8:	31 d2                	xor    %edx,%edx
80105eaa:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
80105ead:	8d 76 00             	lea    0x0(%esi),%esi
      *(new_path+l+ i) = *(cid_str+i);
80105eb0:	0f b6 1c 17          	movzbl (%edi,%edx,1),%ebx
80105eb4:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
      i++;
80105eb7:	83 c2 01             	add    $0x1,%edx
     while(i<c_len){
80105eba:	39 d0                	cmp    %edx,%eax
80105ebc:	75 f2                	jne    80105eb0 <sys_open+0xc0>
80105ebe:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     }
     // *(path + l+ i )= '\0';
     // cprintf("Path is %s", path);
    ip = create(new_path, T_FILE, 0, 0);
80105ec1:	83 ec 0c             	sub    $0xc,%esp
80105ec4:	89 f0                	mov    %esi,%eax
80105ec6:	31 c9                	xor    %ecx,%ecx
80105ec8:	6a 00                	push   $0x0
80105eca:	ba 02 00 00 00       	mov    $0x2,%edx
80105ecf:	e8 cc f3 ff ff       	call   801052a0 <create>
80105ed4:	83 c4 10             	add    $0x10,%esp
80105ed7:	89 c6                	mov    %eax,%esi
    else{
      ip = create(path, T_FILE, 0, 0);
    }
    // ADDED /
    flag = 1;
    ip->path_len = l;
80105ed9:	89 9e 94 00 00 00    	mov    %ebx,0x94(%esi)
  int flag_read = 0;
80105edf:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    flag = 1;
80105ee6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
80105eed:	e9 c8 00 00 00       	jmp    80105fba <sys_open+0x1ca>
80105ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      end_op();
      return -1;
    }
  } else {

    if (myproc()->in_container_id > 0){
80105ef8:	e8 c3 d8 ff ff       	call   801037c0 <myproc>
80105efd:	8b b0 7c 10 00 00    	mov    0x107c(%eax),%esi
80105f03:	85 f6                	test   %esi,%esi
80105f05:	0f 8e e5 01 00 00    	jle    801060f0 <sys_open+0x300>

      ip_old  = namei(path);
80105f0b:	83 ec 0c             	sub    $0xc,%esp
80105f0e:	ff 75 e0             	pushl  -0x20(%ebp)
80105f11:	e8 3a bf ff ff       	call   80101e50 <namei>

       int l  = strlen(path);
80105f16:	5b                   	pop    %ebx
80105f17:	ff 75 e0             	pushl  -0x20(%ebp)
      ip_old  = namei(path);
80105f1a:	89 45 cc             	mov    %eax,-0x34(%ebp)
       int l  = strlen(path);
80105f1d:	e8 9e f0 ff ff       	call   80104fc0 <strlen>
80105f22:	89 c7                	mov    %eax,%edi

      char * new_path = kalloc();
80105f24:	e8 07 c5 ff ff       	call   80102430 <kalloc>
      int i = 0;
      while(i<l){
80105f29:	83 c4 10             	add    $0x10,%esp
80105f2c:	85 ff                	test   %edi,%edi
      char * new_path = kalloc();
80105f2e:	89 c6                	mov    %eax,%esi
      while(i<l){
80105f30:	7e 17                	jle    80105f49 <sys_open+0x159>
      int i = 0;
80105f32:	31 c0                	xor    %eax,%eax
80105f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        *(new_path + i) = *(path + i );
80105f38:	8b 55 e0             	mov    -0x20(%ebp),%edx
80105f3b:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
80105f3f:	88 14 06             	mov    %dl,(%esi,%eax,1)
        i++;
80105f42:	83 c0 01             	add    $0x1,%eax
      while(i<l){
80105f45:	39 c7                	cmp    %eax,%edi
80105f47:	75 ef                	jne    80105f38 <sys_open+0x148>
       }

       char * cid_str = itoa(myproc()->in_container_id);
80105f49:	e8 72 d8 ff ff       	call   801037c0 <myproc>
80105f4e:	83 ec 0c             	sub    $0xc,%esp
80105f51:	ff b0 7c 10 00 00    	pushl  0x107c(%eax)
80105f57:	e8 34 f5 ff ff       	call   80105490 <itoa>
       int c_len = strlen(cid_str);
80105f5c:	89 04 24             	mov    %eax,(%esp)
       char * cid_str = itoa(myproc()->in_container_id);
80105f5f:	89 c3                	mov    %eax,%ebx
       int c_len = strlen(cid_str);
80105f61:	e8 5a f0 ff ff       	call   80104fc0 <strlen>
       i = 0 ;
       while(i<c_len){
80105f66:	83 c4 10             	add    $0x10,%esp
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	7e 19                	jle    80105f86 <sys_open+0x196>
       i = 0 ;
80105f6d:	31 d2                	xor    %edx,%edx
80105f6f:	01 f7                	add    %esi,%edi
80105f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        *(new_path+l+ i) = *(cid_str+i);
80105f78:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105f7c:	88 0c 17             	mov    %cl,(%edi,%edx,1)
        i++;
80105f7f:	83 c2 01             	add    $0x1,%edx
       while(i<c_len){
80105f82:	39 d0                	cmp    %edx,%eax
80105f84:	75 f2                	jne    80105f78 <sys_open+0x188>
       }
      if((ip = namei(new_path)) == 0){
80105f86:	83 ec 0c             	sub    $0xc,%esp
80105f89:	56                   	push   %esi
80105f8a:	e8 c1 be ff ff       	call   80101e50 <namei>
80105f8f:	83 c4 10             	add    $0x10,%esp
80105f92:	85 c0                	test   %eax,%eax
80105f94:	89 c6                	mov    %eax,%esi
  int flag_read = 0;
80105f96:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
      if((ip = namei(new_path)) == 0){
80105f9d:	0f 84 96 01 00 00    	je     80106139 <sys_open+0x349>
      if((ip = namei(path)) == 0){
        end_op();
        return -1;
      }
    }
    ilock(ip);
80105fa3:	83 ec 0c             	sub    $0xc,%esp
80105fa6:	56                   	push   %esi
80105fa7:	e8 24 b6 ff ff       	call   801015d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fac:	83 c4 10             	add    $0x10,%esp
80105faf:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105fb4:	0f 84 56 01 00 00    	je     80106110 <sys_open+0x320>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105fba:	e8 c1 ad ff ff       	call   80100d80 <filealloc>
80105fbf:	85 c0                	test   %eax,%eax
80105fc1:	89 c3                	mov    %eax,%ebx
80105fc3:	0f 84 55 01 00 00    	je     8010611e <sys_open+0x32e>
  struct proc *curproc = myproc();
80105fc9:	e8 f2 d7 ff ff       	call   801037c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105fce:	31 ff                	xor    %edi,%edi
80105fd0:	eb 15                	jmp    80105fe7 <sys_open+0x1f7>
80105fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105fd8:	83 c7 01             	add    $0x1,%edi
80105fdb:	81 ff 00 04 00 00    	cmp    $0x400,%edi
80105fe1:	0f 84 89 01 00 00    	je     80106170 <sys_open+0x380>
    if(curproc->ofile[fd] == 0){
80105fe7:	8b 54 b8 28          	mov    0x28(%eax,%edi,4),%edx
80105feb:	85 d2                	test   %edx,%edx
80105fed:	75 e9                	jne    80105fd8 <sys_open+0x1e8>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105fef:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105ff2:	89 5c b8 28          	mov    %ebx,0x28(%eax,%edi,4)
  iunlock(ip);
80105ff6:	56                   	push   %esi
80105ff7:	e8 b4 b6 ff ff       	call   801016b0 <iunlock>
  end_op();
80105ffc:	e8 7f cb ff ff       	call   80102b80 <end_op>

  //// ADDED
  if(flag==1){
80106001:	83 c4 10             	add    $0x10,%esp
80106004:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
80106008:	0f 84 a2 00 00 00    	je     801060b0 <sys_open+0x2c0>
    ip->cid = myproc()->in_container_id;
  }
  
  ///////////////////////

  f->type = FD_INODE;
8010600e:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106014:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
80106017:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
8010601a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80106021:	89 d0                	mov    %edx,%eax
80106023:	f7 d0                	not    %eax
80106025:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106028:	83 e2 03             	and    $0x3,%edx
8010602b:	0f 95 43 09          	setne  0x9(%ebx)
  //   return 0;
  // }

  // cprintf("Path len %d , Path cid %d", ip->path_len,ip->cid);
  
  if (flag_read==1){
8010602f:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
  f->readable = !(omode & O_WRONLY);
80106033:	88 43 08             	mov    %al,0x8(%ebx)
  if (flag_read==1){
80106036:	74 10                	je     80106048 <sys_open+0x258>
    
    return fd2;
  }
  //////////////////////
  return fd;
}
80106038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010603b:	89 f8                	mov    %edi,%eax
8010603d:	5b                   	pop    %ebx
8010603e:	5e                   	pop    %esi
8010603f:	5f                   	pop    %edi
80106040:	5d                   	pop    %ebp
80106041:	c3                   	ret    
80106042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    char * buffer  = kalloc();
80106048:	e8 e3 c3 ff ff       	call   80102430 <kalloc>
8010604d:	89 c6                	mov    %eax,%esi
    new_read(fd,buffer,f->ip->size);
8010604f:	8b 43 10             	mov    0x10(%ebx),%eax
80106052:	83 ec 04             	sub    $0x4,%esp
80106055:	ff 70 58             	pushl  0x58(%eax)
80106058:	56                   	push   %esi
80106059:	57                   	push   %edi
8010605a:	e8 f1 f5 ff ff       	call   80105650 <new_read>
    int fd2 = new_open(path,O_CREATE);
8010605f:	58                   	pop    %eax
80106060:	5a                   	pop    %edx
80106061:	68 00 02 00 00       	push   $0x200
80106066:	ff 75 e0             	pushl  -0x20(%ebp)
80106069:	e8 d2 fa ff ff       	call   80105b40 <new_open>
    fd2 = new_open(path,O_WRONLY);
8010606e:	59                   	pop    %ecx
8010606f:	5f                   	pop    %edi
80106070:	6a 01                	push   $0x1
80106072:	ff 75 e0             	pushl  -0x20(%ebp)
80106075:	e8 c6 fa ff ff       	call   80105b40 <new_open>
8010607a:	89 c7                	mov    %eax,%edi
    new_write(fd2,buffer,f->ip->size);
8010607c:	8b 43 10             	mov    0x10(%ebx),%eax
8010607f:	83 c4 0c             	add    $0xc,%esp
80106082:	ff 70 58             	pushl  0x58(%eax)
80106085:	56                   	push   %esi
80106086:	57                   	push   %edi
80106087:	e8 74 f6 ff ff       	call   80105700 <new_write>
    f->readable = !(old_omode & O_WRONLY);
8010608c:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    f->writable = (old_omode & O_WRONLY) || (old_omode & O_RDWR);
8010608f:	83 c4 10             	add    $0x10,%esp
    f->readable = !(old_omode & O_WRONLY);
80106092:	89 c8                	mov    %ecx,%eax
80106094:	f7 d0                	not    %eax
80106096:	83 e0 01             	and    $0x1,%eax
    f->writable = (old_omode & O_WRONLY) || (old_omode & O_RDWR);
80106099:	83 e1 03             	and    $0x3,%ecx
    f->readable = !(old_omode & O_WRONLY);
8010609c:	88 43 08             	mov    %al,0x8(%ebx)
    f->writable = (old_omode & O_WRONLY) || (old_omode & O_RDWR);
8010609f:	0f 95 43 09          	setne  0x9(%ebx)
}
801060a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060a6:	89 f8                	mov    %edi,%eax
801060a8:	5b                   	pop    %ebx
801060a9:	5e                   	pop    %esi
801060aa:	5f                   	pop    %edi
801060ab:	5d                   	pop    %ebp
801060ac:	c3                   	ret    
801060ad:	8d 76 00             	lea    0x0(%esi),%esi
    ip->cid = myproc()->in_container_id;
801060b0:	e8 0b d7 ff ff       	call   801037c0 <myproc>
801060b5:	8b 80 7c 10 00 00    	mov    0x107c(%eax),%eax
801060bb:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
801060c1:	e9 48 ff ff ff       	jmp    8010600e <sys_open+0x21e>
801060c6:	8d 76 00             	lea    0x0(%esi),%esi
801060c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip = create(path, T_FILE, 0, 0);
801060d0:	83 ec 0c             	sub    $0xc,%esp
801060d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801060d6:	31 c9                	xor    %ecx,%ecx
801060d8:	6a 00                	push   $0x0
801060da:	ba 02 00 00 00       	mov    $0x2,%edx
801060df:	e8 bc f1 ff ff       	call   801052a0 <create>
801060e4:	83 c4 10             	add    $0x10,%esp
801060e7:	89 c6                	mov    %eax,%esi
801060e9:	e9 eb fd ff ff       	jmp    80105ed9 <sys_open+0xe9>
801060ee:	66 90                	xchg   %ax,%ax
      if((ip = namei(path)) == 0){
801060f0:	83 ec 0c             	sub    $0xc,%esp
801060f3:	ff 75 e0             	pushl  -0x20(%ebp)
801060f6:	e8 55 bd ff ff       	call   80101e50 <namei>
801060fb:	83 c4 10             	add    $0x10,%esp
801060fe:	85 c0                	test   %eax,%eax
80106100:	89 c6                	mov    %eax,%esi
80106102:	74 7a                	je     8010617e <sys_open+0x38e>
  int flag_read = 0;
80106104:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010610b:	e9 93 fe ff ff       	jmp    80105fa3 <sys_open+0x1b3>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106113:	85 c0                	test   %eax,%eax
80106115:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80106118:	0f 84 9c fe ff ff    	je     80105fba <sys_open+0x1ca>
    iunlockput(ip);
8010611e:	83 ec 0c             	sub    $0xc,%esp
80106121:	56                   	push   %esi
80106122:	e8 39 b7 ff ff       	call   80101860 <iunlockput>
    end_op();
80106127:	e8 54 ca ff ff       	call   80102b80 <end_op>
    return -1;
8010612c:	83 c4 10             	add    $0x10,%esp
8010612f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106134:	e9 ff fe ff ff       	jmp    80106038 <sys_open+0x248>
        if (ip_old==0){
80106139:	8b 4d cc             	mov    -0x34(%ebp),%ecx
8010613c:	85 c9                	test   %ecx,%ecx
8010613e:	74 3e                	je     8010617e <sys_open+0x38e>
          if ((omode & O_WRONLY) || (omode & O_RDWR))
80106140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106143:	8b 4d cc             	mov    -0x34(%ebp),%ecx
80106146:	a8 03                	test   $0x3,%al
80106148:	89 ce                	mov    %ecx,%esi
8010614a:	0f 84 53 fe ff ff    	je     80105fa3 <sys_open+0x1b3>
                 omode  = O_RDWR;
80106150:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
80106157:	89 45 c8             	mov    %eax,-0x38(%ebp)
                 flag_read = 1;
8010615a:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
80106161:	e9 3d fe ff ff       	jmp    80105fa3 <sys_open+0x1b3>
80106166:	8d 76 00             	lea    0x0(%esi),%esi
80106169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      fileclose(f);
80106170:	83 ec 0c             	sub    $0xc,%esp
80106173:	53                   	push   %ebx
80106174:	e8 c7 ac ff ff       	call   80100e40 <fileclose>
80106179:	83 c4 10             	add    $0x10,%esp
8010617c:	eb a0                	jmp    8010611e <sys_open+0x32e>
          end_op();
8010617e:	e8 fd c9 ff ff       	call   80102b80 <end_op>
          return -1;
80106183:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106188:	e9 ab fe ff ff       	jmp    80106038 <sys_open+0x248>
8010618d:	8d 76 00             	lea    0x0(%esi),%esi

80106190 <sys_mkdir>:



int
sys_mkdir(void)
{
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106196:	e8 75 c9 ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010619b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010619e:	83 ec 08             	sub    $0x8,%esp
801061a1:	50                   	push   %eax
801061a2:	6a 00                	push   $0x0
801061a4:	e8 a7 ef ff ff       	call   80105150 <argstr>
801061a9:	83 c4 10             	add    $0x10,%esp
801061ac:	85 c0                	test   %eax,%eax
801061ae:	78 30                	js     801061e0 <sys_mkdir+0x50>
801061b0:	83 ec 0c             	sub    $0xc,%esp
801061b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061b6:	31 c9                	xor    %ecx,%ecx
801061b8:	6a 00                	push   $0x0
801061ba:	ba 01 00 00 00       	mov    $0x1,%edx
801061bf:	e8 dc f0 ff ff       	call   801052a0 <create>
801061c4:	83 c4 10             	add    $0x10,%esp
801061c7:	85 c0                	test   %eax,%eax
801061c9:	74 15                	je     801061e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801061cb:	83 ec 0c             	sub    $0xc,%esp
801061ce:	50                   	push   %eax
801061cf:	e8 8c b6 ff ff       	call   80101860 <iunlockput>
  end_op();
801061d4:	e8 a7 c9 ff ff       	call   80102b80 <end_op>
  return 0;
801061d9:	83 c4 10             	add    $0x10,%esp
801061dc:	31 c0                	xor    %eax,%eax
}
801061de:	c9                   	leave  
801061df:	c3                   	ret    
    end_op();
801061e0:	e8 9b c9 ff ff       	call   80102b80 <end_op>
    return -1;
801061e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061ea:	c9                   	leave  
801061eb:	c3                   	ret    
801061ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061f0 <sys_mknod>:

int
sys_mknod(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801061f6:	e8 15 c9 ff ff       	call   80102b10 <begin_op>
  if((argstr(0, &path)) < 0 ||
801061fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061fe:	83 ec 08             	sub    $0x8,%esp
80106201:	50                   	push   %eax
80106202:	6a 00                	push   $0x0
80106204:	e8 47 ef ff ff       	call   80105150 <argstr>
80106209:	83 c4 10             	add    $0x10,%esp
8010620c:	85 c0                	test   %eax,%eax
8010620e:	78 60                	js     80106270 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106210:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106213:	83 ec 08             	sub    $0x8,%esp
80106216:	50                   	push   %eax
80106217:	6a 01                	push   $0x1
80106219:	e8 82 ee ff ff       	call   801050a0 <argint>
  if((argstr(0, &path)) < 0 ||
8010621e:	83 c4 10             	add    $0x10,%esp
80106221:	85 c0                	test   %eax,%eax
80106223:	78 4b                	js     80106270 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106225:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106228:	83 ec 08             	sub    $0x8,%esp
8010622b:	50                   	push   %eax
8010622c:	6a 02                	push   $0x2
8010622e:	e8 6d ee ff ff       	call   801050a0 <argint>
     argint(1, &major) < 0 ||
80106233:	83 c4 10             	add    $0x10,%esp
80106236:	85 c0                	test   %eax,%eax
80106238:	78 36                	js     80106270 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010623a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010623e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80106241:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80106245:	ba 03 00 00 00       	mov    $0x3,%edx
8010624a:	50                   	push   %eax
8010624b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010624e:	e8 4d f0 ff ff       	call   801052a0 <create>
80106253:	83 c4 10             	add    $0x10,%esp
80106256:	85 c0                	test   %eax,%eax
80106258:	74 16                	je     80106270 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010625a:	83 ec 0c             	sub    $0xc,%esp
8010625d:	50                   	push   %eax
8010625e:	e8 fd b5 ff ff       	call   80101860 <iunlockput>
  end_op();
80106263:	e8 18 c9 ff ff       	call   80102b80 <end_op>
  return 0;
80106268:	83 c4 10             	add    $0x10,%esp
8010626b:	31 c0                	xor    %eax,%eax
}
8010626d:	c9                   	leave  
8010626e:	c3                   	ret    
8010626f:	90                   	nop
    end_op();
80106270:	e8 0b c9 ff ff       	call   80102b80 <end_op>
    return -1;
80106275:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010627a:	c9                   	leave  
8010627b:	c3                   	ret    
8010627c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106280 <sys_chdir>:

int
sys_chdir(void)
{
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
80106283:	56                   	push   %esi
80106284:	53                   	push   %ebx
80106285:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106288:	e8 33 d5 ff ff       	call   801037c0 <myproc>
8010628d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010628f:	e8 7c c8 ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106294:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106297:	83 ec 08             	sub    $0x8,%esp
8010629a:	50                   	push   %eax
8010629b:	6a 00                	push   $0x0
8010629d:	e8 ae ee ff ff       	call   80105150 <argstr>
801062a2:	83 c4 10             	add    $0x10,%esp
801062a5:	85 c0                	test   %eax,%eax
801062a7:	78 77                	js     80106320 <sys_chdir+0xa0>
801062a9:	83 ec 0c             	sub    $0xc,%esp
801062ac:	ff 75 f4             	pushl  -0xc(%ebp)
801062af:	e8 9c bb ff ff       	call   80101e50 <namei>
801062b4:	83 c4 10             	add    $0x10,%esp
801062b7:	85 c0                	test   %eax,%eax
801062b9:	89 c3                	mov    %eax,%ebx
801062bb:	74 63                	je     80106320 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801062bd:	83 ec 0c             	sub    $0xc,%esp
801062c0:	50                   	push   %eax
801062c1:	e8 0a b3 ff ff       	call   801015d0 <ilock>
  if(ip->type != T_DIR){
801062c6:	83 c4 10             	add    $0x10,%esp
801062c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801062ce:	75 30                	jne    80106300 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801062d0:	83 ec 0c             	sub    $0xc,%esp
801062d3:	53                   	push   %ebx
801062d4:	e8 d7 b3 ff ff       	call   801016b0 <iunlock>
  iput(curproc->cwd);
801062d9:	58                   	pop    %eax
801062da:	ff b6 28 10 00 00    	pushl  0x1028(%esi)
801062e0:	e8 1b b4 ff ff       	call   80101700 <iput>
  end_op();
801062e5:	e8 96 c8 ff ff       	call   80102b80 <end_op>
  curproc->cwd = ip;
801062ea:	89 9e 28 10 00 00    	mov    %ebx,0x1028(%esi)
  return 0;
801062f0:	83 c4 10             	add    $0x10,%esp
801062f3:	31 c0                	xor    %eax,%eax
}
801062f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801062f8:	5b                   	pop    %ebx
801062f9:	5e                   	pop    %esi
801062fa:	5d                   	pop    %ebp
801062fb:	c3                   	ret    
801062fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80106300:	83 ec 0c             	sub    $0xc,%esp
80106303:	53                   	push   %ebx
80106304:	e8 57 b5 ff ff       	call   80101860 <iunlockput>
    end_op();
80106309:	e8 72 c8 ff ff       	call   80102b80 <end_op>
    return -1;
8010630e:	83 c4 10             	add    $0x10,%esp
80106311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106316:	eb dd                	jmp    801062f5 <sys_chdir+0x75>
80106318:	90                   	nop
80106319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106320:	e8 5b c8 ff ff       	call   80102b80 <end_op>
    return -1;
80106325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010632a:	eb c9                	jmp    801062f5 <sys_chdir+0x75>
8010632c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106330 <sys_exec>:

int
sys_exec(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	57                   	push   %edi
80106334:	56                   	push   %esi
80106335:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106336:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010633c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106342:	50                   	push   %eax
80106343:	6a 00                	push   $0x0
80106345:	e8 06 ee ff ff       	call   80105150 <argstr>
8010634a:	83 c4 10             	add    $0x10,%esp
8010634d:	85 c0                	test   %eax,%eax
8010634f:	0f 88 87 00 00 00    	js     801063dc <sys_exec+0xac>
80106355:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010635b:	83 ec 08             	sub    $0x8,%esp
8010635e:	50                   	push   %eax
8010635f:	6a 01                	push   $0x1
80106361:	e8 3a ed ff ff       	call   801050a0 <argint>
80106366:	83 c4 10             	add    $0x10,%esp
80106369:	85 c0                	test   %eax,%eax
8010636b:	78 6f                	js     801063dc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010636d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106373:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106376:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106378:	68 80 00 00 00       	push   $0x80
8010637d:	6a 00                	push   $0x0
8010637f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106385:	50                   	push   %eax
80106386:	e8 15 ea ff ff       	call   80104da0 <memset>
8010638b:	83 c4 10             	add    $0x10,%esp
8010638e:	eb 2c                	jmp    801063bc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106390:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106396:	85 c0                	test   %eax,%eax
80106398:	74 56                	je     801063f0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010639a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801063a0:	83 ec 08             	sub    $0x8,%esp
801063a3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801063a6:	52                   	push   %edx
801063a7:	50                   	push   %eax
801063a8:	e8 83 ec ff ff       	call   80105030 <fetchstr>
801063ad:	83 c4 10             	add    $0x10,%esp
801063b0:	85 c0                	test   %eax,%eax
801063b2:	78 28                	js     801063dc <sys_exec+0xac>
  for(i=0;; i++){
801063b4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801063b7:	83 fb 20             	cmp    $0x20,%ebx
801063ba:	74 20                	je     801063dc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801063bc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801063c2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801063c9:	83 ec 08             	sub    $0x8,%esp
801063cc:	57                   	push   %edi
801063cd:	01 f0                	add    %esi,%eax
801063cf:	50                   	push   %eax
801063d0:	e8 1b ec ff ff       	call   80104ff0 <fetchint>
801063d5:	83 c4 10             	add    $0x10,%esp
801063d8:	85 c0                	test   %eax,%eax
801063da:	79 b4                	jns    80106390 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801063dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801063df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063e4:	5b                   	pop    %ebx
801063e5:	5e                   	pop    %esi
801063e6:	5f                   	pop    %edi
801063e7:	5d                   	pop    %ebp
801063e8:	c3                   	ret    
801063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801063f0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801063f6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801063f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106400:	00 00 00 00 
  return exec(path, argv);
80106404:	50                   	push   %eax
80106405:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010640b:	e8 00 a6 ff ff       	call   80100a10 <exec>
80106410:	83 c4 10             	add    $0x10,%esp
}
80106413:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106416:	5b                   	pop    %ebx
80106417:	5e                   	pop    %esi
80106418:	5f                   	pop    %edi
80106419:	5d                   	pop    %ebp
8010641a:	c3                   	ret    
8010641b:	90                   	nop
8010641c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106420 <sys_pipe>:

int
sys_pipe(void)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	57                   	push   %edi
80106424:	56                   	push   %esi
80106425:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106426:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106429:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010642c:	6a 08                	push   $0x8
8010642e:	50                   	push   %eax
8010642f:	6a 00                	push   $0x0
80106431:	e8 ba ec ff ff       	call   801050f0 <argptr>
80106436:	83 c4 10             	add    $0x10,%esp
80106439:	85 c0                	test   %eax,%eax
8010643b:	0f 88 b6 00 00 00    	js     801064f7 <sys_pipe+0xd7>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106441:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106444:	83 ec 08             	sub    $0x8,%esp
80106447:	50                   	push   %eax
80106448:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010644b:	50                   	push   %eax
8010644c:	e8 5f cd ff ff       	call   801031b0 <pipealloc>
80106451:	83 c4 10             	add    $0x10,%esp
80106454:	85 c0                	test   %eax,%eax
80106456:	0f 88 9b 00 00 00    	js     801064f7 <sys_pipe+0xd7>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010645c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010645f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106461:	e8 5a d3 ff ff       	call   801037c0 <myproc>
80106466:	eb 13                	jmp    8010647b <sys_pipe+0x5b>
80106468:	90                   	nop
80106469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106470:	83 c3 01             	add    $0x1,%ebx
80106473:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106479:	74 65                	je     801064e0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
8010647b:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010647f:	85 f6                	test   %esi,%esi
80106481:	75 ed                	jne    80106470 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106483:	8d 73 08             	lea    0x8(%ebx),%esi
80106486:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010648a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010648d:	e8 2e d3 ff ff       	call   801037c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106492:	31 d2                	xor    %edx,%edx
80106494:	eb 15                	jmp    801064ab <sys_pipe+0x8b>
80106496:	8d 76 00             	lea    0x0(%esi),%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801064a0:	83 c2 01             	add    $0x1,%edx
801064a3:	81 fa 00 04 00 00    	cmp    $0x400,%edx
801064a9:	74 21                	je     801064cc <sys_pipe+0xac>
    if(curproc->ofile[fd] == 0){
801064ab:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801064af:	85 c9                	test   %ecx,%ecx
801064b1:	75 ed                	jne    801064a0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
801064b3:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801064b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801064ba:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801064bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801064bf:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801064c2:	31 c0                	xor    %eax,%eax
}
801064c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064c7:	5b                   	pop    %ebx
801064c8:	5e                   	pop    %esi
801064c9:	5f                   	pop    %edi
801064ca:	5d                   	pop    %ebp
801064cb:	c3                   	ret    
      myproc()->ofile[fd0] = 0;
801064cc:	e8 ef d2 ff ff       	call   801037c0 <myproc>
801064d1:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801064d8:	00 
801064d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
801064e0:	83 ec 0c             	sub    $0xc,%esp
801064e3:	ff 75 e0             	pushl  -0x20(%ebp)
801064e6:	e8 55 a9 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
801064eb:	58                   	pop    %eax
801064ec:	ff 75 e4             	pushl  -0x1c(%ebp)
801064ef:	e8 4c a9 ff ff       	call   80100e40 <fileclose>
    return -1;
801064f4:	83 c4 10             	add    $0x10,%esp
801064f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064fc:	eb c6                	jmp    801064c4 <sys_pipe+0xa4>
801064fe:	66 90                	xchg   %ax,%ax

80106500 <sys_fork>:



int
sys_fork(void)
{
80106500:	55                   	push   %ebp
80106501:	89 e5                	mov    %esp,%ebp
  
  return fork();
}
80106503:	5d                   	pop    %ebp
  return fork();
80106504:	e9 67 d4 ff ff       	jmp    80103970 <fork>
80106509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106510 <sys_exit>:

int
sys_exit(void)
{
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	83 ec 08             	sub    $0x8,%esp
  exit();
80106516:	e8 85 d7 ff ff       	call   80103ca0 <exit>
  return 0;  // not reached
}
8010651b:	31 c0                	xor    %eax,%eax
8010651d:	c9                   	leave  
8010651e:	c3                   	ret    
8010651f:	90                   	nop

80106520 <sys_wait>:

int
sys_wait(void)
{
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106523:	5d                   	pop    %ebp
  return wait();
80106524:	e9 97 d9 ff ff       	jmp    80103ec0 <wait>
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106530 <sys_kill>:

int
sys_kill(void)
{
80106530:	55                   	push   %ebp
80106531:	89 e5                	mov    %esp,%ebp
80106533:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106536:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106539:	50                   	push   %eax
8010653a:	6a 00                	push   $0x0
8010653c:	e8 5f eb ff ff       	call   801050a0 <argint>
80106541:	83 c4 10             	add    $0x10,%esp
80106544:	85 c0                	test   %eax,%eax
80106546:	78 18                	js     80106560 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106548:	83 ec 0c             	sub    $0xc,%esp
8010654b:	ff 75 f4             	pushl  -0xc(%ebp)
8010654e:	e8 cd da ff ff       	call   80104020 <kill>
80106553:	83 c4 10             	add    $0x10,%esp
}
80106556:	c9                   	leave  
80106557:	c3                   	ret    
80106558:	90                   	nop
80106559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106565:	c9                   	leave  
80106566:	c3                   	ret    
80106567:	89 f6                	mov    %esi,%esi
80106569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106570 <sys_getpid>:

int
sys_getpid(void)
{
80106570:	55                   	push   %ebp
80106571:	89 e5                	mov    %esp,%ebp
80106573:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106576:	e8 45 d2 ff ff       	call   801037c0 <myproc>
8010657b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010657e:	c9                   	leave  
8010657f:	c3                   	ret    

80106580 <sys_sbrk>:

int
sys_sbrk(void)
{
80106580:	55                   	push   %ebp
80106581:	89 e5                	mov    %esp,%ebp
80106583:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106584:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106587:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010658a:	50                   	push   %eax
8010658b:	6a 00                	push   $0x0
8010658d:	e8 0e eb ff ff       	call   801050a0 <argint>
80106592:	83 c4 10             	add    $0x10,%esp
80106595:	85 c0                	test   %eax,%eax
80106597:	78 27                	js     801065c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106599:	e8 22 d2 ff ff       	call   801037c0 <myproc>
  if(growproc(n) < 0)
8010659e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801065a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801065a3:	ff 75 f4             	pushl  -0xc(%ebp)
801065a6:	e8 45 d3 ff ff       	call   801038f0 <growproc>
801065ab:	83 c4 10             	add    $0x10,%esp
801065ae:	85 c0                	test   %eax,%eax
801065b0:	78 0e                	js     801065c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801065b2:	89 d8                	mov    %ebx,%eax
801065b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065b7:	c9                   	leave  
801065b8:	c3                   	ret    
801065b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801065c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801065c5:	eb eb                	jmp    801065b2 <sys_sbrk+0x32>
801065c7:	89 f6                	mov    %esi,%esi
801065c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065d0 <sys_sleep>:

int
sys_sleep(void)
{
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
801065d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801065d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801065d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801065da:	50                   	push   %eax
801065db:	6a 00                	push   $0x0
801065dd:	e8 be ea ff ff       	call   801050a0 <argint>
801065e2:	83 c4 10             	add    $0x10,%esp
801065e5:	85 c0                	test   %eax,%eax
801065e7:	0f 88 8a 00 00 00    	js     80106677 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801065ed:	83 ec 0c             	sub    $0xc,%esp
801065f0:	68 20 80 1d 80       	push   $0x801d8020
801065f5:	e8 96 e6 ff ff       	call   80104c90 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801065fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065fd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106600:	8b 1d 60 88 1d 80    	mov    0x801d8860,%ebx
  while(ticks - ticks0 < n){
80106606:	85 d2                	test   %edx,%edx
80106608:	75 27                	jne    80106631 <sys_sleep+0x61>
8010660a:	eb 54                	jmp    80106660 <sys_sleep+0x90>
8010660c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106610:	83 ec 08             	sub    $0x8,%esp
80106613:	68 20 80 1d 80       	push   $0x801d8020
80106618:	68 60 88 1d 80       	push   $0x801d8860
8010661d:	e8 de d7 ff ff       	call   80103e00 <sleep>
  while(ticks - ticks0 < n){
80106622:	a1 60 88 1d 80       	mov    0x801d8860,%eax
80106627:	83 c4 10             	add    $0x10,%esp
8010662a:	29 d8                	sub    %ebx,%eax
8010662c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010662f:	73 2f                	jae    80106660 <sys_sleep+0x90>
    if(myproc()->killed){
80106631:	e8 8a d1 ff ff       	call   801037c0 <myproc>
80106636:	8b 40 24             	mov    0x24(%eax),%eax
80106639:	85 c0                	test   %eax,%eax
8010663b:	74 d3                	je     80106610 <sys_sleep+0x40>
      release(&tickslock);
8010663d:	83 ec 0c             	sub    $0xc,%esp
80106640:	68 20 80 1d 80       	push   $0x801d8020
80106645:	e8 06 e7 ff ff       	call   80104d50 <release>
      return -1;
8010664a:	83 c4 10             	add    $0x10,%esp
8010664d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106652:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106655:	c9                   	leave  
80106656:	c3                   	ret    
80106657:	89 f6                	mov    %esi,%esi
80106659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106660:	83 ec 0c             	sub    $0xc,%esp
80106663:	68 20 80 1d 80       	push   $0x801d8020
80106668:	e8 e3 e6 ff ff       	call   80104d50 <release>
  return 0;
8010666d:	83 c4 10             	add    $0x10,%esp
80106670:	31 c0                	xor    %eax,%eax
}
80106672:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106675:	c9                   	leave  
80106676:	c3                   	ret    
    return -1;
80106677:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010667c:	eb f4                	jmp    80106672 <sys_sleep+0xa2>
8010667e:	66 90                	xchg   %ax,%ax

80106680 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
80106683:	53                   	push   %ebx
80106684:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106687:	68 20 80 1d 80       	push   $0x801d8020
8010668c:	e8 ff e5 ff ff       	call   80104c90 <acquire>
  xticks = ticks;
80106691:	8b 1d 60 88 1d 80    	mov    0x801d8860,%ebx
  release(&tickslock);
80106697:	c7 04 24 20 80 1d 80 	movl   $0x801d8020,(%esp)
8010669e:	e8 ad e6 ff ff       	call   80104d50 <release>
  return xticks;
}
801066a3:	89 d8                	mov    %ebx,%eax
801066a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    
801066aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801066b0 <sys_toggle>:

int
sys_toggle(void){
  if (system_trace==1){
801066b0:	83 3d 00 80 1d 80 01 	cmpl   $0x1,0x801d8000
sys_toggle(void){
801066b7:	55                   	push   %ebp
801066b8:	89 e5                	mov    %esp,%ebp
  if (system_trace==1){
801066ba:	74 2c                	je     801066e8 <sys_toggle+0x38>
    system_trace = 0;
  }
  else{
    system_trace = 1;
801066bc:	c7 05 00 80 1d 80 01 	movl   $0x1,0x801d8000
801066c3:	00 00 00 
801066c6:	b8 e0 c5 10 80       	mov    $0x8010c5e0,%eax
801066cb:	90                   	nop
801066cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < 30; ++i)
    {
      // reinitialize
      call_count[i] =0;
801066d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801066d6:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < 30; ++i)
801066d9:	3d 58 c6 10 80       	cmp    $0x8010c658,%eax
801066de:	75 f0                	jne    801066d0 <sys_toggle+0x20>
    }

  }
  return 0;
}
801066e0:	31 c0                	xor    %eax,%eax
801066e2:	5d                   	pop    %ebp
801066e3:	c3                   	ret    
801066e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801066e8:	31 c0                	xor    %eax,%eax
    system_trace = 0;
801066ea:	c7 05 00 80 1d 80 00 	movl   $0x0,0x801d8000
801066f1:	00 00 00 
}
801066f4:	5d                   	pop    %ebp
801066f5:	c3                   	ret    
801066f6:	8d 76 00             	lea    0x0(%esi),%esi
801066f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106700 <sys_add>:

int
sys_add(void){
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	83 ec 20             	sub    $0x20,%esp
  int a,b;
  if(argint(0,&a)<0)
80106706:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106709:	50                   	push   %eax
8010670a:	6a 00                	push   $0x0
8010670c:	e8 8f e9 ff ff       	call   801050a0 <argint>
80106711:	83 c4 10             	add    $0x10,%esp
80106714:	85 c0                	test   %eax,%eax
80106716:	78 20                	js     80106738 <sys_add+0x38>
   { return -1;}
  if(argint(1,&b)<0)
80106718:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010671b:	83 ec 08             	sub    $0x8,%esp
8010671e:	50                   	push   %eax
8010671f:	6a 01                	push   $0x1
80106721:	e8 7a e9 ff ff       	call   801050a0 <argint>
80106726:	83 c4 10             	add    $0x10,%esp
80106729:	85 c0                	test   %eax,%eax
8010672b:	78 0b                	js     80106738 <sys_add+0x38>
    {return -1;}

  return a+b;
8010672d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106730:	03 45 f0             	add    -0x10(%ebp),%eax
}
80106733:	c9                   	leave  
80106734:	c3                   	ret    
80106735:	8d 76 00             	lea    0x0(%esi),%esi
   { return -1;}
80106738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010673d:	c9                   	leave  
8010673e:	c3                   	ret    
8010673f:	90                   	nop

80106740 <sys_ps>:

int
sys_ps(void){
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	83 ec 08             	sub    $0x8,%esp
  
  
  (void) print_ps();
80106746:	e8 35 da ff ff       	call   80104180 <print_ps>

  return 0;
}
8010674b:	31 c0                	xor    %eax,%eax
8010674d:	c9                   	leave  
8010674e:	c3                   	ret    
8010674f:	90                   	nop

80106750 <sys_send>:

int
sys_send(void){//int sender_pid, int rec_pid, void *msg){
80106750:	55                   	push   %ebp
80106751:	89 e5                	mov    %esp,%ebp
80106753:	83 ec 20             	sub    $0x20,%esp
  

  int sender_pid,rec_pid;
  char * msg;
  if(argint(0,&sender_pid)<0)
80106756:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106759:	50                   	push   %eax
8010675a:	6a 00                	push   $0x0
8010675c:	e8 3f e9 ff ff       	call   801050a0 <argint>
80106761:	83 c4 10             	add    $0x10,%esp
80106764:	85 c0                	test   %eax,%eax
80106766:	78 48                	js     801067b0 <sys_send+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  if(argint(1,&rec_pid)<0)
80106768:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010676b:	83 ec 08             	sub    $0x8,%esp
8010676e:	50                   	push   %eax
8010676f:	6a 01                	push   $0x1
80106771:	e8 2a e9 ff ff       	call   801050a0 <argint>
80106776:	83 c4 10             	add    $0x10,%esp
80106779:	85 c0                	test   %eax,%eax
8010677b:	78 33                	js     801067b0 <sys_send+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  if(argptr(2,&msg,MSGSIZE)<0)
8010677d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106780:	83 ec 04             	sub    $0x4,%esp
80106783:	6a 08                	push   $0x8
80106785:	50                   	push   %eax
80106786:	6a 02                	push   $0x2
80106788:	e8 63 e9 ff ff       	call   801050f0 <argptr>
8010678d:	83 c4 10             	add    $0x10,%esp
80106790:	85 c0                	test   %eax,%eax
80106792:	78 1c                	js     801067b0 <sys_send+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  
  // cprintf ("Going to Send Message : %s \n",msg);
  // put the mesaage int the messagebuffer. 
  send_msg(sender_pid,rec_pid,msg);
80106794:	83 ec 04             	sub    $0x4,%esp
80106797:	ff 75 f4             	pushl  -0xc(%ebp)
8010679a:	ff 75 f0             	pushl  -0x10(%ebp)
8010679d:	ff 75 ec             	pushl  -0x14(%ebp)
801067a0:	e8 7b da ff ff       	call   80104220 <send_msg>
  // cprintf("Message Sent !!! \n");
  
  // success 
  return 0;
801067a5:	83 c4 10             	add    $0x10,%esp
801067a8:	31 c0                	xor    %eax,%eax
}
801067aa:	c9                   	leave  
801067ab:	c3                   	ret    
801067ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {cprintf("Error extracting msg args"); return -1;}
801067b0:	83 ec 0c             	sub    $0xc,%esp
801067b3:	68 84 90 10 80       	push   $0x80109084
801067b8:	e8 a3 9e ff ff       	call   80100660 <cprintf>
801067bd:	83 c4 10             	add    $0x10,%esp
801067c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067c5:	c9                   	leave  
801067c6:	c3                   	ret    
801067c7:	89 f6                	mov    %esi,%esi
801067c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067d0 <sys_recv>:


int
sys_recv(void){//void *msg){
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	83 ec 1c             	sub    $0x1c,%esp
 // cprintf ("Receiving Message \n"); 
  
 char * msg;
 int * myid;
 int  * from;
  if(argintptr(0,(void *) &myid,sizeof(*myid))<0)
801067d6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067d9:	6a 04                	push   $0x4
801067db:	50                   	push   %eax
801067dc:	6a 00                	push   $0x0
801067de:	e8 ad e9 ff ff       	call   80105190 <argintptr>
801067e3:	83 c4 10             	add    $0x10,%esp
801067e6:	85 c0                	test   %eax,%eax
801067e8:	78 46                	js     80106830 <sys_recv+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  if(argintptr(1,(void *) &from,sizeof(*from))<0)
801067ea:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067ed:	83 ec 04             	sub    $0x4,%esp
801067f0:	6a 04                	push   $0x4
801067f2:	50                   	push   %eax
801067f3:	6a 01                	push   $0x1
801067f5:	e8 96 e9 ff ff       	call   80105190 <argintptr>
801067fa:	83 c4 10             	add    $0x10,%esp
801067fd:	85 c0                	test   %eax,%eax
801067ff:	78 2f                	js     80106830 <sys_recv+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  if(argptr(2,&msg,MSGSIZE)<0)
80106801:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106804:	83 ec 04             	sub    $0x4,%esp
80106807:	6a 08                	push   $0x8
80106809:	50                   	push   %eax
8010680a:	6a 02                	push   $0x2
8010680c:	e8 df e8 ff ff       	call   801050f0 <argptr>
80106811:	83 c4 10             	add    $0x10,%esp
80106814:	85 c0                	test   %eax,%eax
80106816:	78 18                	js     80106830 <sys_recv+0x60>
    {cprintf("Error extracting msg args"); return -1;}
  msg = recv_msg(myid,from,msg);
80106818:	83 ec 04             	sub    $0x4,%esp
8010681b:	ff 75 ec             	pushl  -0x14(%ebp)
8010681e:	ff 75 f4             	pushl  -0xc(%ebp)
80106821:	ff 75 f0             	pushl  -0x10(%ebp)
80106824:	e8 b7 db ff ff       	call   801043e0 <recv_msg>
  // cprintf("Messafe Recvievd is %s",msg);
 // success 
  return 0;
80106829:	83 c4 10             	add    $0x10,%esp
8010682c:	31 c0                	xor    %eax,%eax
}
8010682e:	c9                   	leave  
8010682f:	c3                   	ret    
    {cprintf("Error extracting msg args"); return -1;}
80106830:	83 ec 0c             	sub    $0xc,%esp
80106833:	68 84 90 10 80       	push   $0x80109084
80106838:	e8 23 9e ff ff       	call   80100660 <cprintf>
8010683d:	83 c4 10             	add    $0x10,%esp
80106840:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106845:	c9                   	leave  
80106846:	c3                   	ret    
80106847:	89 f6                	mov    %esi,%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106850 <sys_send_multi>:


int 
sys_send_multi(void){
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	53                   	push   %ebx
    int  grpid[MSGSIZE];
    for (int i = 0; i < MSGSIZE; ++i)
    {
      grpid[i] = -1;
    }
    if(argptr(0,&msg,MSGSIZE)<0)
80106854:	8d 45 d0             	lea    -0x30(%ebp),%eax
sys_send_multi(void){
80106857:	83 ec 38             	sub    $0x38,%esp
      grpid[i] = -1;
8010685a:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
80106861:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
    if(argptr(0,&msg,MSGSIZE)<0)
80106868:	6a 08                	push   $0x8
8010686a:	50                   	push   %eax
8010686b:	6a 00                	push   $0x0
      grpid[i] = -1;
8010686d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80106874:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
8010687b:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
80106882:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebp)
80106889:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
80106890:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
    if(argptr(0,&msg,MSGSIZE)<0)
80106897:	e8 54 e8 ff ff       	call   801050f0 <argptr>
8010689c:	83 c4 10             	add    $0x10,%esp
8010689f:	85 c0                	test   %eax,%eax
801068a1:	78 7f                	js     80106922 <sys_send_multi+0xd2>
    {cprintf("Error extracting msg args"); return -1;}
    if(argint(1,&grpsiz)<0)
801068a3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801068a6:	83 ec 08             	sub    $0x8,%esp
801068a9:	50                   	push   %eax
801068aa:	6a 01                	push   $0x1
801068ac:	e8 ef e7 ff ff       	call   801050a0 <argint>
801068b1:	83 c4 10             	add    $0x10,%esp
801068b4:	85 c0                	test   %eax,%eax
801068b6:	78 32                	js     801068ea <sys_send_multi+0x9a>
    {cprintf("Error extracting grpid args"); return -1;}
    for (int i = 0; i < grpsiz; ++i)
801068b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801068bb:	31 db                	xor    %ebx,%ebx
801068bd:	85 c0                	test   %eax,%eax
801068bf:	7f 11                	jg     801068d2 <sys_send_multi+0x82>
801068c1:	eb 45                	jmp    80106908 <sys_send_multi+0xb8>
801068c3:	90                   	nop
801068c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801068cb:	83 c3 01             	add    $0x1,%ebx
801068ce:	39 d8                	cmp    %ebx,%eax
801068d0:	7e 36                	jle    80106908 <sys_send_multi+0xb8>
      {
        if(argint(i+2,&grpid[i])<0)
801068d2:	8d 44 9d d8          	lea    -0x28(%ebp,%ebx,4),%eax
801068d6:	83 ec 08             	sub    $0x8,%esp
801068d9:	50                   	push   %eax
801068da:	8d 43 02             	lea    0x2(%ebx),%eax
801068dd:	50                   	push   %eax
801068de:	e8 bd e7 ff ff       	call   801050a0 <argint>
801068e3:	83 c4 10             	add    $0x10,%esp
801068e6:	85 c0                	test   %eax,%eax
801068e8:	79 de                	jns    801068c8 <sys_send_multi+0x78>
    {cprintf("Error extracting grpid args"); return -1;}
801068ea:	83 ec 0c             	sub    $0xc,%esp
801068ed:	68 9e 90 10 80       	push   $0x8010909e
801068f2:	e8 69 9d ff ff       	call   80100660 <cprintf>
801068f7:	83 c4 10             	add    $0x10,%esp
801068fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      }  
     
    // do the message spread
    multicast_msg(msg,grpid,grpsiz);
    return 0;
}
801068ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106902:	c9                   	leave  
80106903:	c3                   	ret    
80106904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    multicast_msg(msg,grpid,grpsiz);
80106908:	83 ec 04             	sub    $0x4,%esp
8010690b:	50                   	push   %eax
8010690c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010690f:	50                   	push   %eax
80106910:	ff 75 d0             	pushl  -0x30(%ebp)
80106913:	e8 d8 dc ff ff       	call   801045f0 <multicast_msg>
    return 0;
80106918:	83 c4 10             	add    $0x10,%esp
8010691b:	31 c0                	xor    %eax,%eax
}
8010691d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106920:	c9                   	leave  
80106921:	c3                   	ret    
    {cprintf("Error extracting msg args"); return -1;}
80106922:	83 ec 0c             	sub    $0xc,%esp
80106925:	68 84 90 10 80       	push   $0x80109084
8010692a:	e8 31 9d ff ff       	call   80100660 <cprintf>
8010692f:	83 c4 10             	add    $0x10,%esp
80106932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106937:	eb e4                	jmp    8010691d <sys_send_multi+0xcd>
80106939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106940 <sys_create_container>:

int 
sys_create_container(){
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	83 ec 20             	sub    $0x20,%esp
  int container_id;
  if(argint(0,&container_id)<0)
80106946:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106949:	50                   	push   %eax
8010694a:	6a 00                	push   $0x0
8010694c:	e8 4f e7 ff ff       	call   801050a0 <argint>
80106951:	83 c4 10             	add    $0x10,%esp
80106954:	85 c0                	test   %eax,%eax
80106956:	78 18                	js     80106970 <sys_create_container+0x30>
   { return -1;}
  
  return getNewCid(container_id);
80106958:	83 ec 0c             	sub    $0xc,%esp
8010695b:	ff 75 f4             	pushl  -0xc(%ebp)
8010695e:	e8 8d dd ff ff       	call   801046f0 <getNewCid>
80106963:	83 c4 10             	add    $0x10,%esp
}
80106966:	c9                   	leave  
80106967:	c3                   	ret    
80106968:	90                   	nop
80106969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   { return -1;}
80106970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106975:	c9                   	leave  
80106976:	c3                   	ret    
80106977:	89 f6                	mov    %esi,%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <sys_destroy_container>:

int 
sys_destroy_container(void){
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	83 ec 20             	sub    $0x20,%esp
  int container_id;
  if(argint(0,&container_id)<0)
80106986:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106989:	50                   	push   %eax
8010698a:	6a 00                	push   $0x0
8010698c:	e8 0f e7 ff ff       	call   801050a0 <argint>
80106991:	83 c4 10             	add    $0x10,%esp
80106994:	85 c0                	test   %eax,%eax
80106996:	78 18                	js     801069b0 <sys_destroy_container+0x30>
   { return -1;}

  return destroyCid(container_id);
80106998:	83 ec 0c             	sub    $0xc,%esp
8010699b:	ff 75 f4             	pushl  -0xc(%ebp)
8010699e:	e8 cd dd ff ff       	call   80104770 <destroyCid>
801069a3:	83 c4 10             	add    $0x10,%esp
}
801069a6:	c9                   	leave  
801069a7:	c3                   	ret    
801069a8:	90                   	nop
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   { return -1;}
801069b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069b5:	c9                   	leave  
801069b6:	c3                   	ret    
801069b7:	89 f6                	mov    %esi,%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <sys_join_container>:


int sys_join_container(void){
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	83 ec 20             	sub    $0x20,%esp

  int container_id;
  if(argint(0,&container_id)<0)
801069c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069c9:	50                   	push   %eax
801069ca:	6a 00                	push   $0x0
801069cc:	e8 cf e6 ff ff       	call   801050a0 <argint>
801069d1:	83 c4 10             	add    $0x10,%esp
801069d4:	85 c0                	test   %eax,%eax
801069d6:	78 18                	js     801069f0 <sys_join_container+0x30>
   { return -1;}


  return joinCid(container_id);
801069d8:	83 ec 0c             	sub    $0xc,%esp
801069db:	ff 75 f4             	pushl  -0xc(%ebp)
801069de:	e8 8d de ff ff       	call   80104870 <joinCid>
801069e3:	83 c4 10             	add    $0x10,%esp
}
801069e6:	c9                   	leave  
801069e7:	c3                   	ret    
801069e8:	90                   	nop
801069e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   { return -1;}
801069f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069f5:	c9                   	leave  
801069f6:	c3                   	ret    
801069f7:	89 f6                	mov    %esi,%esi
801069f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a00 <sys_leave_container>:

int sys_leave_container(void){
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp

  return leaveCid();
}
80106a03:	5d                   	pop    %ebp
  return leaveCid();
80106a04:	e9 07 df ff ff       	jmp    80104910 <leaveCid>
80106a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a10 <sys_getcid>:


int
sys_getcid(void)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	83 ec 08             	sub    $0x8,%esp
  return myproc()->in_container_id;
80106a16:	e8 a5 cd ff ff       	call   801037c0 <myproc>
80106a1b:	8b 80 7c 10 00 00    	mov    0x107c(%eax),%eax
}
80106a21:	c9                   	leave  
80106a22:	c3                   	ret    
80106a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <sys_p_ctable>:

int
sys_p_ctable(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
  return print_ctable();
}
80106a33:	5d                   	pop    %ebp
  return print_ctable();
80106a34:	e9 07 df ff ff       	jmp    80104940 <print_ctable>
80106a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a40 <sys_sz_ctable>:


int
sys_sz_ctable(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
  return sz_ctable();
}
80106a43:	5d                   	pop    %ebp
  return sz_ctable();
80106a44:	e9 57 df ff ff       	jmp    801049a0 <sz_ctable>
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a50 <sys_scheduler_log_on>:

int
sys_scheduler_log_on(void){
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
  return log_on(); 
}
80106a53:	5d                   	pop    %ebp
  return log_on(); 
80106a54:	e9 87 df ff ff       	jmp    801049e0 <log_on>
80106a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a60 <sys_scheduler_log_off>:

int
sys_scheduler_log_off(void){
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
  return log_off(); 
}
80106a63:	5d                   	pop    %ebp
  return log_off(); 
80106a64:	e9 97 df ff ff       	jmp    80104a00 <log_off>
80106a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a70 <sys_print_count>:


int
sys_print_count(void){
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	53                   	push   %ebx
80106a74:	31 db                	xor    %ebx,%ebx
80106a76:	83 ec 04             	sub    $0x4,%esp
80106a79:	e9 0a 01 00 00       	jmp    80106b88 <sys_print_count+0x118>
80106a7e:	66 90                	xchg   %ax,%ax
  
  for (int i = 0; i < 30; ++i)
  {
    if (call_count[i] > 0){
    if (i==1){
80106a80:	83 fb 01             	cmp    $0x1,%ebx
80106a83:	0f 84 1a 01 00 00    	je     80106ba3 <sys_print_count+0x133>
      cprintf("sys_fork %d \n",call_count[i]);
    }
    if (i==2){
80106a89:	83 fb 02             	cmp    $0x2,%ebx
80106a8c:	0f 84 24 01 00 00    	je     80106bb6 <sys_print_count+0x146>
      cprintf("sys_exit %d \n",call_count[i]);
    }
    if (i==3){
80106a92:	83 fb 03             	cmp    $0x3,%ebx
80106a95:	0f 84 33 01 00 00    	je     80106bce <sys_print_count+0x15e>
      cprintf("sys_wait %d \n",call_count[i]);
    }
    if (i==4){
80106a9b:	83 fb 04             	cmp    $0x4,%ebx
80106a9e:	0f 84 42 01 00 00    	je     80106be6 <sys_print_count+0x176>
      cprintf("sys_pipe %d \n",call_count[i]);
    }
    if (i==5){
80106aa4:	83 fb 05             	cmp    $0x5,%ebx
80106aa7:	0f 84 51 01 00 00    	je     80106bfe <sys_print_count+0x18e>
      cprintf("sys_read %d \n",call_count[i]);
    }
    if (i==6){
80106aad:	83 fb 06             	cmp    $0x6,%ebx
80106ab0:	0f 84 63 01 00 00    	je     80106c19 <sys_print_count+0x1a9>
      cprintf("sys_kill %d \n",call_count[i]);
    }
    if (i==7){
80106ab6:	83 fb 07             	cmp    $0x7,%ebx
80106ab9:	0f 84 75 01 00 00    	je     80106c34 <sys_print_count+0x1c4>
      cprintf("sys_exec %d \n",call_count[i]);
    }
    if (i==8){
80106abf:	83 fb 08             	cmp    $0x8,%ebx
80106ac2:	0f 84 87 01 00 00    	je     80106c4f <sys_print_count+0x1df>
      cprintf("sys_fstat %d \n",call_count[i]);
    }
    if (i==9){
80106ac8:	83 fb 09             	cmp    $0x9,%ebx
80106acb:	0f 84 99 01 00 00    	je     80106c6a <sys_print_count+0x1fa>
      cprintf("sys_chdir %d \n",call_count[i]);
    }
    if (i==10){
80106ad1:	83 fb 0a             	cmp    $0xa,%ebx
80106ad4:	0f 84 ab 01 00 00    	je     80106c85 <sys_print_count+0x215>
      cprintf("sys_dup %d \n",call_count[i]);
    }
    if (i==11){
80106ada:	83 fb 0b             	cmp    $0xb,%ebx
80106add:	0f 84 bd 01 00 00    	je     80106ca0 <sys_print_count+0x230>
      cprintf("sys_getpid %d \n",call_count[i]);
    }
    if (i==12){
80106ae3:	83 fb 0c             	cmp    $0xc,%ebx
80106ae6:	0f 84 cf 01 00 00    	je     80106cbb <sys_print_count+0x24b>
      cprintf("sys_sbrk %d \n",call_count[i]);
    }
    if (i==13){
80106aec:	83 fb 0d             	cmp    $0xd,%ebx
80106aef:	0f 84 e1 01 00 00    	je     80106cd6 <sys_print_count+0x266>
      cprintf("sys_sleep %d \n",call_count[i]);
    }
    if (i==14){
80106af5:	83 fb 0e             	cmp    $0xe,%ebx
80106af8:	0f 84 f3 01 00 00    	je     80106cf1 <sys_print_count+0x281>
      cprintf("sys_uptime %d \n",call_count[i]);
    }
    if (i==15){
80106afe:	83 fb 0f             	cmp    $0xf,%ebx
80106b01:	0f 84 05 02 00 00    	je     80106d0c <sys_print_count+0x29c>
      cprintf("sys_open %d \n",call_count[i]);
    }
    if (i==16){
80106b07:	83 fb 10             	cmp    $0x10,%ebx
80106b0a:	0f 84 17 02 00 00    	je     80106d27 <sys_print_count+0x2b7>
      cprintf("sys_write %d \n",call_count[i]);
    }
    if (i==17){
80106b10:	83 fb 11             	cmp    $0x11,%ebx
80106b13:	0f 84 29 02 00 00    	je     80106d42 <sys_print_count+0x2d2>
      cprintf("sys_mknod %d \n",call_count[i]);
    }
    if (i==18){
80106b19:	83 fb 12             	cmp    $0x12,%ebx
80106b1c:	0f 84 3b 02 00 00    	je     80106d5d <sys_print_count+0x2ed>
      cprintf("sys_unlink %d \n",call_count[i]);
    }
    if (i==19){
80106b22:	83 fb 13             	cmp    $0x13,%ebx
80106b25:	0f 84 4d 02 00 00    	je     80106d78 <sys_print_count+0x308>
      cprintf("sys_link %d \n",call_count[i]);
    }
    if (i==20){
80106b2b:	83 fb 14             	cmp    $0x14,%ebx
80106b2e:	0f 84 5f 02 00 00    	je     80106d93 <sys_print_count+0x323>
      cprintf("sys_mkdir %d \n",call_count[i]);
    }
    if (i==21){
80106b34:	83 fb 15             	cmp    $0x15,%ebx
80106b37:	0f 84 71 02 00 00    	je     80106dae <sys_print_count+0x33e>
      cprintf("sys_close %d \n",call_count[i]);
    }
    if (i==22){
80106b3d:	83 fb 16             	cmp    $0x16,%ebx
80106b40:	0f 84 83 02 00 00    	je     80106dc9 <sys_print_count+0x359>
      cprintf("sys_toggle %d \n",call_count[i]);
    }
    if (i==23){
80106b46:	83 fb 17             	cmp    $0x17,%ebx
80106b49:	0f 84 95 02 00 00    	je     80106de4 <sys_print_count+0x374>
      cprintf("sys_add %d \n",call_count[i]);
    }
    if (i==24){
80106b4f:	83 fb 18             	cmp    $0x18,%ebx
80106b52:	0f 84 a7 02 00 00    	je     80106dff <sys_print_count+0x38f>
      cprintf("sys_ps %d \n",call_count[i]);
    }
    if (i==25){
80106b58:	83 fb 19             	cmp    $0x19,%ebx
80106b5b:	0f 84 b9 02 00 00    	je     80106e1a <sys_print_count+0x3aa>
      cprintf("sys_send %d \n",call_count[i]);
    }
    if (i==26){
80106b61:	83 fb 1a             	cmp    $0x1a,%ebx
80106b64:	0f 84 cb 02 00 00    	je     80106e35 <sys_print_count+0x3c5>
      cprintf("sys_recv %d \n",call_count[i]);
    }
    if (i==27){
80106b6a:	83 fb 1b             	cmp    $0x1b,%ebx
80106b6d:	0f 84 dd 02 00 00    	je     80106e50 <sys_print_count+0x3e0>
      cprintf("sys_send_multi %d \n",call_count[i]);
    }
    if (i==28){
80106b73:	83 fb 1c             	cmp    $0x1c,%ebx
80106b76:	0f 84 ef 02 00 00    	je     80106e6b <sys_print_count+0x3fb>
      cprintf("sys_print_count %d \n",call_count[i]);
    }
    if (i==29){
80106b7c:	83 fb 1d             	cmp    $0x1d,%ebx
80106b7f:	0f 84 01 03 00 00    	je     80106e86 <sys_print_count+0x416>
80106b85:	83 c3 01             	add    $0x1,%ebx
    if (call_count[i] > 0){
80106b88:	8b 04 9d e0 c5 10 80 	mov    -0x7fef3a20(,%ebx,4),%eax
80106b8f:	85 c0                	test   %eax,%eax
80106b91:	0f 8f e9 fe ff ff    	jg     80106a80 <sys_print_count+0x10>
  for (int i = 0; i < 30; ++i)
80106b97:	83 fb 1d             	cmp    $0x1d,%ebx
80106b9a:	75 e9                	jne    80106b85 <sys_print_count+0x115>
  }



  return 0;
80106b9c:	31 c0                	xor    %eax,%eax
80106b9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ba1:	c9                   	leave  
80106ba2:	c3                   	ret    
      cprintf("sys_fork %d \n",call_count[i]);
80106ba3:	83 ec 08             	sub    $0x8,%esp
80106ba6:	50                   	push   %eax
80106ba7:	68 ba 90 10 80       	push   $0x801090ba
80106bac:	e8 af 9a ff ff       	call   80100660 <cprintf>
80106bb1:	83 c4 10             	add    $0x10,%esp
80106bb4:	eb cf                	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_exit %d \n",call_count[i]);
80106bb6:	83 ec 08             	sub    $0x8,%esp
80106bb9:	ff 35 e8 c5 10 80    	pushl  0x8010c5e8
80106bbf:	68 c8 90 10 80       	push   $0x801090c8
80106bc4:	e8 97 9a ff ff       	call   80100660 <cprintf>
80106bc9:	83 c4 10             	add    $0x10,%esp
80106bcc:	eb b7                	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_wait %d \n",call_count[i]);
80106bce:	83 ec 08             	sub    $0x8,%esp
80106bd1:	ff 35 ec c5 10 80    	pushl  0x8010c5ec
80106bd7:	68 d6 90 10 80       	push   $0x801090d6
80106bdc:	e8 7f 9a ff ff       	call   80100660 <cprintf>
80106be1:	83 c4 10             	add    $0x10,%esp
80106be4:	eb 9f                	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_pipe %d \n",call_count[i]);
80106be6:	83 ec 08             	sub    $0x8,%esp
80106be9:	ff 35 f0 c5 10 80    	pushl  0x8010c5f0
80106bef:	68 e4 90 10 80       	push   $0x801090e4
80106bf4:	e8 67 9a ff ff       	call   80100660 <cprintf>
80106bf9:	83 c4 10             	add    $0x10,%esp
80106bfc:	eb 87                	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_read %d \n",call_count[i]);
80106bfe:	83 ec 08             	sub    $0x8,%esp
80106c01:	ff 35 f4 c5 10 80    	pushl  0x8010c5f4
80106c07:	68 f2 90 10 80       	push   $0x801090f2
80106c0c:	e8 4f 9a ff ff       	call   80100660 <cprintf>
80106c11:	83 c4 10             	add    $0x10,%esp
80106c14:	e9 6c ff ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_kill %d \n",call_count[i]);
80106c19:	83 ec 08             	sub    $0x8,%esp
80106c1c:	ff 35 f8 c5 10 80    	pushl  0x8010c5f8
80106c22:	68 00 91 10 80       	push   $0x80109100
80106c27:	e8 34 9a ff ff       	call   80100660 <cprintf>
80106c2c:	83 c4 10             	add    $0x10,%esp
80106c2f:	e9 51 ff ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_exec %d \n",call_count[i]);
80106c34:	83 ec 08             	sub    $0x8,%esp
80106c37:	ff 35 fc c5 10 80    	pushl  0x8010c5fc
80106c3d:	68 0e 91 10 80       	push   $0x8010910e
80106c42:	e8 19 9a ff ff       	call   80100660 <cprintf>
80106c47:	83 c4 10             	add    $0x10,%esp
80106c4a:	e9 36 ff ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_fstat %d \n",call_count[i]);
80106c4f:	83 ec 08             	sub    $0x8,%esp
80106c52:	ff 35 00 c6 10 80    	pushl  0x8010c600
80106c58:	68 1c 91 10 80       	push   $0x8010911c
80106c5d:	e8 fe 99 ff ff       	call   80100660 <cprintf>
80106c62:	83 c4 10             	add    $0x10,%esp
80106c65:	e9 1b ff ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_chdir %d \n",call_count[i]);
80106c6a:	83 ec 08             	sub    $0x8,%esp
80106c6d:	ff 35 04 c6 10 80    	pushl  0x8010c604
80106c73:	68 2b 91 10 80       	push   $0x8010912b
80106c78:	e8 e3 99 ff ff       	call   80100660 <cprintf>
80106c7d:	83 c4 10             	add    $0x10,%esp
80106c80:	e9 00 ff ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_dup %d \n",call_count[i]);
80106c85:	83 ec 08             	sub    $0x8,%esp
80106c88:	ff 35 08 c6 10 80    	pushl  0x8010c608
80106c8e:	68 3a 91 10 80       	push   $0x8010913a
80106c93:	e8 c8 99 ff ff       	call   80100660 <cprintf>
80106c98:	83 c4 10             	add    $0x10,%esp
80106c9b:	e9 e5 fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_getpid %d \n",call_count[i]);
80106ca0:	83 ec 08             	sub    $0x8,%esp
80106ca3:	ff 35 0c c6 10 80    	pushl  0x8010c60c
80106ca9:	68 47 91 10 80       	push   $0x80109147
80106cae:	e8 ad 99 ff ff       	call   80100660 <cprintf>
80106cb3:	83 c4 10             	add    $0x10,%esp
80106cb6:	e9 ca fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_sbrk %d \n",call_count[i]);
80106cbb:	83 ec 08             	sub    $0x8,%esp
80106cbe:	ff 35 10 c6 10 80    	pushl  0x8010c610
80106cc4:	68 57 91 10 80       	push   $0x80109157
80106cc9:	e8 92 99 ff ff       	call   80100660 <cprintf>
80106cce:	83 c4 10             	add    $0x10,%esp
80106cd1:	e9 af fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_sleep %d \n",call_count[i]);
80106cd6:	83 ec 08             	sub    $0x8,%esp
80106cd9:	ff 35 14 c6 10 80    	pushl  0x8010c614
80106cdf:	68 65 91 10 80       	push   $0x80109165
80106ce4:	e8 77 99 ff ff       	call   80100660 <cprintf>
80106ce9:	83 c4 10             	add    $0x10,%esp
80106cec:	e9 94 fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_uptime %d \n",call_count[i]);
80106cf1:	83 ec 08             	sub    $0x8,%esp
80106cf4:	ff 35 18 c6 10 80    	pushl  0x8010c618
80106cfa:	68 74 91 10 80       	push   $0x80109174
80106cff:	e8 5c 99 ff ff       	call   80100660 <cprintf>
80106d04:	83 c4 10             	add    $0x10,%esp
80106d07:	e9 79 fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_open %d \n",call_count[i]);
80106d0c:	83 ec 08             	sub    $0x8,%esp
80106d0f:	ff 35 1c c6 10 80    	pushl  0x8010c61c
80106d15:	68 84 91 10 80       	push   $0x80109184
80106d1a:	e8 41 99 ff ff       	call   80100660 <cprintf>
80106d1f:	83 c4 10             	add    $0x10,%esp
80106d22:	e9 5e fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_write %d \n",call_count[i]);
80106d27:	83 ec 08             	sub    $0x8,%esp
80106d2a:	ff 35 20 c6 10 80    	pushl  0x8010c620
80106d30:	68 92 91 10 80       	push   $0x80109192
80106d35:	e8 26 99 ff ff       	call   80100660 <cprintf>
80106d3a:	83 c4 10             	add    $0x10,%esp
80106d3d:	e9 43 fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_mknod %d \n",call_count[i]);
80106d42:	83 ec 08             	sub    $0x8,%esp
80106d45:	ff 35 24 c6 10 80    	pushl  0x8010c624
80106d4b:	68 a1 91 10 80       	push   $0x801091a1
80106d50:	e8 0b 99 ff ff       	call   80100660 <cprintf>
80106d55:	83 c4 10             	add    $0x10,%esp
80106d58:	e9 28 fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_unlink %d \n",call_count[i]);
80106d5d:	83 ec 08             	sub    $0x8,%esp
80106d60:	ff 35 28 c6 10 80    	pushl  0x8010c628
80106d66:	68 b0 91 10 80       	push   $0x801091b0
80106d6b:	e8 f0 98 ff ff       	call   80100660 <cprintf>
80106d70:	83 c4 10             	add    $0x10,%esp
80106d73:	e9 0d fe ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_link %d \n",call_count[i]);
80106d78:	83 ec 08             	sub    $0x8,%esp
80106d7b:	ff 35 2c c6 10 80    	pushl  0x8010c62c
80106d81:	68 c0 91 10 80       	push   $0x801091c0
80106d86:	e8 d5 98 ff ff       	call   80100660 <cprintf>
80106d8b:	83 c4 10             	add    $0x10,%esp
80106d8e:	e9 f2 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_mkdir %d \n",call_count[i]);
80106d93:	83 ec 08             	sub    $0x8,%esp
80106d96:	ff 35 30 c6 10 80    	pushl  0x8010c630
80106d9c:	68 ce 91 10 80       	push   $0x801091ce
80106da1:	e8 ba 98 ff ff       	call   80100660 <cprintf>
80106da6:	83 c4 10             	add    $0x10,%esp
80106da9:	e9 d7 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_close %d \n",call_count[i]);
80106dae:	83 ec 08             	sub    $0x8,%esp
80106db1:	ff 35 34 c6 10 80    	pushl  0x8010c634
80106db7:	68 dd 91 10 80       	push   $0x801091dd
80106dbc:	e8 9f 98 ff ff       	call   80100660 <cprintf>
80106dc1:	83 c4 10             	add    $0x10,%esp
80106dc4:	e9 bc fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_toggle %d \n",call_count[i]);
80106dc9:	83 ec 08             	sub    $0x8,%esp
80106dcc:	ff 35 38 c6 10 80    	pushl  0x8010c638
80106dd2:	68 ec 91 10 80       	push   $0x801091ec
80106dd7:	e8 84 98 ff ff       	call   80100660 <cprintf>
80106ddc:	83 c4 10             	add    $0x10,%esp
80106ddf:	e9 a1 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_add %d \n",call_count[i]);
80106de4:	83 ec 08             	sub    $0x8,%esp
80106de7:	ff 35 3c c6 10 80    	pushl  0x8010c63c
80106ded:	68 fc 91 10 80       	push   $0x801091fc
80106df2:	e8 69 98 ff ff       	call   80100660 <cprintf>
80106df7:	83 c4 10             	add    $0x10,%esp
80106dfa:	e9 86 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_ps %d \n",call_count[i]);
80106dff:	83 ec 08             	sub    $0x8,%esp
80106e02:	ff 35 40 c6 10 80    	pushl  0x8010c640
80106e08:	68 09 92 10 80       	push   $0x80109209
80106e0d:	e8 4e 98 ff ff       	call   80100660 <cprintf>
80106e12:	83 c4 10             	add    $0x10,%esp
80106e15:	e9 6b fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_send %d \n",call_count[i]);
80106e1a:	83 ec 08             	sub    $0x8,%esp
80106e1d:	ff 35 44 c6 10 80    	pushl  0x8010c644
80106e23:	68 15 92 10 80       	push   $0x80109215
80106e28:	e8 33 98 ff ff       	call   80100660 <cprintf>
80106e2d:	83 c4 10             	add    $0x10,%esp
80106e30:	e9 50 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_recv %d \n",call_count[i]);
80106e35:	83 ec 08             	sub    $0x8,%esp
80106e38:	ff 35 48 c6 10 80    	pushl  0x8010c648
80106e3e:	68 23 92 10 80       	push   $0x80109223
80106e43:	e8 18 98 ff ff       	call   80100660 <cprintf>
80106e48:	83 c4 10             	add    $0x10,%esp
80106e4b:	e9 35 fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_send_multi %d \n",call_count[i]);
80106e50:	83 ec 08             	sub    $0x8,%esp
80106e53:	ff 35 4c c6 10 80    	pushl  0x8010c64c
80106e59:	68 31 92 10 80       	push   $0x80109231
80106e5e:	e8 fd 97 ff ff       	call   80100660 <cprintf>
80106e63:	83 c4 10             	add    $0x10,%esp
80106e66:	e9 1a fd ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_print_count %d \n",call_count[i]);
80106e6b:	83 ec 08             	sub    $0x8,%esp
80106e6e:	ff 35 50 c6 10 80    	pushl  0x8010c650
80106e74:	68 45 92 10 80       	push   $0x80109245
80106e79:	e8 e2 97 ff ff       	call   80100660 <cprintf>
80106e7e:	83 c4 10             	add    $0x10,%esp
80106e81:	e9 ff fc ff ff       	jmp    80106b85 <sys_print_count+0x115>
      cprintf("sys_close %d \n",call_count[i]);
80106e86:	83 ec 08             	sub    $0x8,%esp
80106e89:	ff 35 54 c6 10 80    	pushl  0x8010c654
80106e8f:	68 dd 91 10 80       	push   $0x801091dd
80106e94:	e8 c7 97 ff ff       	call   80100660 <cprintf>
80106e99:	83 c4 10             	add    $0x10,%esp
80106e9c:	31 c0                	xor    %eax,%eax
80106e9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ea1:	c9                   	leave  
80106ea2:	c3                   	ret    

80106ea3 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106ea3:	1e                   	push   %ds
  pushl %es
80106ea4:	06                   	push   %es
  pushl %fs
80106ea5:	0f a0                	push   %fs
  pushl %gs
80106ea7:	0f a8                	push   %gs
  pushal
80106ea9:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106eaa:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106eae:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106eb0:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106eb2:	54                   	push   %esp
  call trap
80106eb3:	e8 c8 00 00 00       	call   80106f80 <trap>
  addl $4, %esp
80106eb8:	83 c4 04             	add    $0x4,%esp

80106ebb <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106ebb:	61                   	popa   
  popl %gs
80106ebc:	0f a9                	pop    %gs
  popl %fs
80106ebe:	0f a1                	pop    %fs
  popl %es
80106ec0:	07                   	pop    %es
  popl %ds
80106ec1:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106ec2:	83 c4 08             	add    $0x8,%esp
  iret
80106ec5:	cf                   	iret   
80106ec6:	66 90                	xchg   %ax,%ax
80106ec8:	66 90                	xchg   %ax,%ax
80106eca:	66 90                	xchg   %ax,%ax
80106ecc:	66 90                	xchg   %ax,%ax
80106ece:	66 90                	xchg   %ax,%ax

80106ed0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106ed0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106ed1:	31 c0                	xor    %eax,%eax
{
80106ed3:	89 e5                	mov    %esp,%ebp
80106ed5:	83 ec 08             	sub    $0x8,%esp
80106ed8:	90                   	nop
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106ee0:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106ee7:	c7 04 c5 62 80 1d 80 	movl   $0x8e000008,-0x7fe27f9e(,%eax,8)
80106eee:	08 00 00 8e 
80106ef2:	66 89 14 c5 60 80 1d 	mov    %dx,-0x7fe27fa0(,%eax,8)
80106ef9:	80 
80106efa:	c1 ea 10             	shr    $0x10,%edx
80106efd:	66 89 14 c5 66 80 1d 	mov    %dx,-0x7fe27f9a(,%eax,8)
80106f04:	80 
  for(i = 0; i < 256; i++)
80106f05:	83 c0 01             	add    $0x1,%eax
80106f08:	3d 00 01 00 00       	cmp    $0x100,%eax
80106f0d:	75 d1                	jne    80106ee0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f0f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106f14:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f17:	c7 05 62 82 1d 80 08 	movl   $0xef000008,0x801d8262
80106f1e:	00 00 ef 
  initlock(&tickslock, "time");
80106f21:	68 5a 92 10 80       	push   $0x8010925a
80106f26:	68 20 80 1d 80       	push   $0x801d8020
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f2b:	66 a3 60 82 1d 80    	mov    %ax,0x801d8260
80106f31:	c1 e8 10             	shr    $0x10,%eax
80106f34:	66 a3 66 82 1d 80    	mov    %ax,0x801d8266
  initlock(&tickslock, "time");
80106f3a:	e8 11 dc ff ff       	call   80104b50 <initlock>
}
80106f3f:	83 c4 10             	add    $0x10,%esp
80106f42:	c9                   	leave  
80106f43:	c3                   	ret    
80106f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f50 <idtinit>:

void
idtinit(void)
{
80106f50:	55                   	push   %ebp
  pd[0] = size-1;
80106f51:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106f56:	89 e5                	mov    %esp,%ebp
80106f58:	83 ec 10             	sub    $0x10,%esp
80106f5b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106f5f:	b8 60 80 1d 80       	mov    $0x801d8060,%eax
80106f64:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106f68:	c1 e8 10             	shr    $0x10,%eax
80106f6b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106f6f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106f72:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106f75:	c9                   	leave  
80106f76:	c3                   	ret    
80106f77:	89 f6                	mov    %esi,%esi
80106f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f80 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
80106f86:	83 ec 1c             	sub    $0x1c,%esp
80106f89:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80106f8c:	8b 47 30             	mov    0x30(%edi),%eax
80106f8f:	83 f8 40             	cmp    $0x40,%eax
80106f92:	0f 84 f0 00 00 00    	je     80107088 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106f98:	83 e8 20             	sub    $0x20,%eax
80106f9b:	83 f8 1f             	cmp    $0x1f,%eax
80106f9e:	77 10                	ja     80106fb0 <trap+0x30>
80106fa0:	ff 24 85 00 93 10 80 	jmp    *-0x7fef6d00(,%eax,4)
80106fa7:	89 f6                	mov    %esi,%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106fb0:	e8 0b c8 ff ff       	call   801037c0 <myproc>
80106fb5:	85 c0                	test   %eax,%eax
80106fb7:	8b 5f 38             	mov    0x38(%edi),%ebx
80106fba:	0f 84 14 02 00 00    	je     801071d4 <trap+0x254>
80106fc0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106fc4:	0f 84 0a 02 00 00    	je     801071d4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106fca:	0f 20 d1             	mov    %cr2,%ecx
80106fcd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fd0:	e8 cb c7 ff ff       	call   801037a0 <cpuid>
80106fd5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106fd8:	8b 47 34             	mov    0x34(%edi),%eax
80106fdb:	8b 77 30             	mov    0x30(%edi),%esi
80106fde:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106fe1:	e8 da c7 ff ff       	call   801037c0 <myproc>
80106fe6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fe9:	e8 d2 c7 ff ff       	call   801037c0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106fee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106ff1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106ff4:	51                   	push   %ecx
80106ff5:	53                   	push   %ebx
80106ff6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106ff7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ffa:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ffd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106ffe:	81 c2 2c 10 00 00    	add    $0x102c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107004:	52                   	push   %edx
80107005:	ff 70 10             	pushl  0x10(%eax)
80107008:	68 bc 92 10 80       	push   $0x801092bc
8010700d:	e8 4e 96 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107012:	83 c4 20             	add    $0x20,%esp
80107015:	e8 a6 c7 ff ff       	call   801037c0 <myproc>
8010701a:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107021:	e8 9a c7 ff ff       	call   801037c0 <myproc>
80107026:	85 c0                	test   %eax,%eax
80107028:	74 1d                	je     80107047 <trap+0xc7>
8010702a:	e8 91 c7 ff ff       	call   801037c0 <myproc>
8010702f:	8b 50 24             	mov    0x24(%eax),%edx
80107032:	85 d2                	test   %edx,%edx
80107034:	74 11                	je     80107047 <trap+0xc7>
80107036:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010703a:	83 e0 03             	and    $0x3,%eax
8010703d:	66 83 f8 03          	cmp    $0x3,%ax
80107041:	0f 84 49 01 00 00    	je     80107190 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107047:	e8 74 c7 ff ff       	call   801037c0 <myproc>
8010704c:	85 c0                	test   %eax,%eax
8010704e:	74 0b                	je     8010705b <trap+0xdb>
80107050:	e8 6b c7 ff ff       	call   801037c0 <myproc>
80107055:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107059:	74 65                	je     801070c0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010705b:	e8 60 c7 ff ff       	call   801037c0 <myproc>
80107060:	85 c0                	test   %eax,%eax
80107062:	74 19                	je     8010707d <trap+0xfd>
80107064:	e8 57 c7 ff ff       	call   801037c0 <myproc>
80107069:	8b 40 24             	mov    0x24(%eax),%eax
8010706c:	85 c0                	test   %eax,%eax
8010706e:	74 0d                	je     8010707d <trap+0xfd>
80107070:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80107074:	83 e0 03             	and    $0x3,%eax
80107077:	66 83 f8 03          	cmp    $0x3,%ax
8010707b:	74 34                	je     801070b1 <trap+0x131>
    exit();
}
8010707d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107080:	5b                   	pop    %ebx
80107081:	5e                   	pop    %esi
80107082:	5f                   	pop    %edi
80107083:	5d                   	pop    %ebp
80107084:	c3                   	ret    
80107085:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
80107088:	e8 33 c7 ff ff       	call   801037c0 <myproc>
8010708d:	8b 58 24             	mov    0x24(%eax),%ebx
80107090:	85 db                	test   %ebx,%ebx
80107092:	0f 85 e8 00 00 00    	jne    80107180 <trap+0x200>
    myproc()->tf = tf;
80107098:	e8 23 c7 ff ff       	call   801037c0 <myproc>
8010709d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801070a0:	e8 4b e1 ff ff       	call   801051f0 <syscall>
    if(myproc()->killed)
801070a5:	e8 16 c7 ff ff       	call   801037c0 <myproc>
801070aa:	8b 48 24             	mov    0x24(%eax),%ecx
801070ad:	85 c9                	test   %ecx,%ecx
801070af:	74 cc                	je     8010707d <trap+0xfd>
}
801070b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070b4:	5b                   	pop    %ebx
801070b5:	5e                   	pop    %esi
801070b6:	5f                   	pop    %edi
801070b7:	5d                   	pop    %ebp
      exit();
801070b8:	e9 e3 cb ff ff       	jmp    80103ca0 <exit>
801070bd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801070c0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801070c4:	75 95                	jne    8010705b <trap+0xdb>
    yield();
801070c6:	e8 e5 cc ff ff       	call   80103db0 <yield>
801070cb:	eb 8e                	jmp    8010705b <trap+0xdb>
801070cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801070d0:	e8 cb c6 ff ff       	call   801037a0 <cpuid>
801070d5:	85 c0                	test   %eax,%eax
801070d7:	0f 84 c3 00 00 00    	je     801071a0 <trap+0x220>
    lapiceoi();
801070dd:	e8 de b5 ff ff       	call   801026c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070e2:	e8 d9 c6 ff ff       	call   801037c0 <myproc>
801070e7:	85 c0                	test   %eax,%eax
801070e9:	0f 85 3b ff ff ff    	jne    8010702a <trap+0xaa>
801070ef:	e9 53 ff ff ff       	jmp    80107047 <trap+0xc7>
801070f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801070f8:	e8 83 b4 ff ff       	call   80102580 <kbdintr>
    lapiceoi();
801070fd:	e8 be b5 ff ff       	call   801026c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107102:	e8 b9 c6 ff ff       	call   801037c0 <myproc>
80107107:	85 c0                	test   %eax,%eax
80107109:	0f 85 1b ff ff ff    	jne    8010702a <trap+0xaa>
8010710f:	e9 33 ff ff ff       	jmp    80107047 <trap+0xc7>
80107114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107118:	e8 53 02 00 00       	call   80107370 <uartintr>
    lapiceoi();
8010711d:	e8 9e b5 ff ff       	call   801026c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107122:	e8 99 c6 ff ff       	call   801037c0 <myproc>
80107127:	85 c0                	test   %eax,%eax
80107129:	0f 85 fb fe ff ff    	jne    8010702a <trap+0xaa>
8010712f:	e9 13 ff ff ff       	jmp    80107047 <trap+0xc7>
80107134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107138:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010713c:	8b 77 38             	mov    0x38(%edi),%esi
8010713f:	e8 5c c6 ff ff       	call   801037a0 <cpuid>
80107144:	56                   	push   %esi
80107145:	53                   	push   %ebx
80107146:	50                   	push   %eax
80107147:	68 64 92 10 80       	push   $0x80109264
8010714c:	e8 0f 95 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80107151:	e8 6a b5 ff ff       	call   801026c0 <lapiceoi>
    break;
80107156:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107159:	e8 62 c6 ff ff       	call   801037c0 <myproc>
8010715e:	85 c0                	test   %eax,%eax
80107160:	0f 85 c4 fe ff ff    	jne    8010702a <trap+0xaa>
80107166:	e9 dc fe ff ff       	jmp    80107047 <trap+0xc7>
8010716b:	90                   	nop
8010716c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107170:	e8 7b ae ff ff       	call   80101ff0 <ideintr>
80107175:	e9 63 ff ff ff       	jmp    801070dd <trap+0x15d>
8010717a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80107180:	e8 1b cb ff ff       	call   80103ca0 <exit>
80107185:	e9 0e ff ff ff       	jmp    80107098 <trap+0x118>
8010718a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80107190:	e8 0b cb ff ff       	call   80103ca0 <exit>
80107195:	e9 ad fe ff ff       	jmp    80107047 <trap+0xc7>
8010719a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801071a0:	83 ec 0c             	sub    $0xc,%esp
801071a3:	68 20 80 1d 80       	push   $0x801d8020
801071a8:	e8 e3 da ff ff       	call   80104c90 <acquire>
      wakeup(&ticks);
801071ad:	c7 04 24 60 88 1d 80 	movl   $0x801d8860,(%esp)
      ticks++;
801071b4:	83 05 60 88 1d 80 01 	addl   $0x1,0x801d8860
      wakeup(&ticks);
801071bb:	e8 00 ce ff ff       	call   80103fc0 <wakeup>
      release(&tickslock);
801071c0:	c7 04 24 20 80 1d 80 	movl   $0x801d8020,(%esp)
801071c7:	e8 84 db ff ff       	call   80104d50 <release>
801071cc:	83 c4 10             	add    $0x10,%esp
801071cf:	e9 09 ff ff ff       	jmp    801070dd <trap+0x15d>
801071d4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801071d7:	e8 c4 c5 ff ff       	call   801037a0 <cpuid>
801071dc:	83 ec 0c             	sub    $0xc,%esp
801071df:	56                   	push   %esi
801071e0:	53                   	push   %ebx
801071e1:	50                   	push   %eax
801071e2:	ff 77 30             	pushl  0x30(%edi)
801071e5:	68 88 92 10 80       	push   $0x80109288
801071ea:	e8 71 94 ff ff       	call   80100660 <cprintf>
      panic("trap");
801071ef:	83 c4 14             	add    $0x14,%esp
801071f2:	68 5f 92 10 80       	push   $0x8010925f
801071f7:	e8 94 91 ff ff       	call   80100390 <panic>
801071fc:	66 90                	xchg   %ax,%ax
801071fe:	66 90                	xchg   %ax,%ax

80107200 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107200:	a1 7c c6 10 80       	mov    0x8010c67c,%eax
{
80107205:	55                   	push   %ebp
80107206:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107208:	85 c0                	test   %eax,%eax
8010720a:	74 1c                	je     80107228 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010720c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107211:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107212:	a8 01                	test   $0x1,%al
80107214:	74 12                	je     80107228 <uartgetc+0x28>
80107216:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010721b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010721c:	0f b6 c0             	movzbl %al,%eax
}
8010721f:	5d                   	pop    %ebp
80107220:	c3                   	ret    
80107221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010722d:	5d                   	pop    %ebp
8010722e:	c3                   	ret    
8010722f:	90                   	nop

80107230 <uartputc.part.0>:
uartputc(int c)
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
80107236:	89 c7                	mov    %eax,%edi
80107238:	bb 80 00 00 00       	mov    $0x80,%ebx
8010723d:	be fd 03 00 00       	mov    $0x3fd,%esi
80107242:	83 ec 0c             	sub    $0xc,%esp
80107245:	eb 1b                	jmp    80107262 <uartputc.part.0+0x32>
80107247:	89 f6                	mov    %esi,%esi
80107249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107250:	83 ec 0c             	sub    $0xc,%esp
80107253:	6a 0a                	push   $0xa
80107255:	e8 86 b4 ff ff       	call   801026e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010725a:	83 c4 10             	add    $0x10,%esp
8010725d:	83 eb 01             	sub    $0x1,%ebx
80107260:	74 07                	je     80107269 <uartputc.part.0+0x39>
80107262:	89 f2                	mov    %esi,%edx
80107264:	ec                   	in     (%dx),%al
80107265:	a8 20                	test   $0x20,%al
80107267:	74 e7                	je     80107250 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107269:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010726e:	89 f8                	mov    %edi,%eax
80107270:	ee                   	out    %al,(%dx)
}
80107271:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107274:	5b                   	pop    %ebx
80107275:	5e                   	pop    %esi
80107276:	5f                   	pop    %edi
80107277:	5d                   	pop    %ebp
80107278:	c3                   	ret    
80107279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107280 <uartinit>:
{
80107280:	55                   	push   %ebp
80107281:	31 c9                	xor    %ecx,%ecx
80107283:	89 c8                	mov    %ecx,%eax
80107285:	89 e5                	mov    %esp,%ebp
80107287:	57                   	push   %edi
80107288:	56                   	push   %esi
80107289:	53                   	push   %ebx
8010728a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010728f:	89 da                	mov    %ebx,%edx
80107291:	83 ec 0c             	sub    $0xc,%esp
80107294:	ee                   	out    %al,(%dx)
80107295:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010729a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010729f:	89 fa                	mov    %edi,%edx
801072a1:	ee                   	out    %al,(%dx)
801072a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801072a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072ac:	ee                   	out    %al,(%dx)
801072ad:	be f9 03 00 00       	mov    $0x3f9,%esi
801072b2:	89 c8                	mov    %ecx,%eax
801072b4:	89 f2                	mov    %esi,%edx
801072b6:	ee                   	out    %al,(%dx)
801072b7:	b8 03 00 00 00       	mov    $0x3,%eax
801072bc:	89 fa                	mov    %edi,%edx
801072be:	ee                   	out    %al,(%dx)
801072bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801072c4:	89 c8                	mov    %ecx,%eax
801072c6:	ee                   	out    %al,(%dx)
801072c7:	b8 01 00 00 00       	mov    $0x1,%eax
801072cc:	89 f2                	mov    %esi,%edx
801072ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801072cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801072d4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801072d5:	3c ff                	cmp    $0xff,%al
801072d7:	74 5a                	je     80107333 <uartinit+0xb3>
  uart = 1;
801072d9:	c7 05 7c c6 10 80 01 	movl   $0x1,0x8010c67c
801072e0:	00 00 00 
801072e3:	89 da                	mov    %ebx,%edx
801072e5:	ec                   	in     (%dx),%al
801072e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072eb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801072ec:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801072ef:	bb 80 93 10 80       	mov    $0x80109380,%ebx
  ioapicenable(IRQ_COM1, 0);
801072f4:	6a 00                	push   $0x0
801072f6:	6a 04                	push   $0x4
801072f8:	e8 43 af ff ff       	call   80102240 <ioapicenable>
801072fd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107300:	b8 78 00 00 00       	mov    $0x78,%eax
80107305:	eb 13                	jmp    8010731a <uartinit+0x9a>
80107307:	89 f6                	mov    %esi,%esi
80107309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107310:	83 c3 01             	add    $0x1,%ebx
80107313:	0f be 03             	movsbl (%ebx),%eax
80107316:	84 c0                	test   %al,%al
80107318:	74 19                	je     80107333 <uartinit+0xb3>
  if(!uart)
8010731a:	8b 15 7c c6 10 80    	mov    0x8010c67c,%edx
80107320:	85 d2                	test   %edx,%edx
80107322:	74 ec                	je     80107310 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80107324:	83 c3 01             	add    $0x1,%ebx
80107327:	e8 04 ff ff ff       	call   80107230 <uartputc.part.0>
8010732c:	0f be 03             	movsbl (%ebx),%eax
8010732f:	84 c0                	test   %al,%al
80107331:	75 e7                	jne    8010731a <uartinit+0x9a>
}
80107333:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107336:	5b                   	pop    %ebx
80107337:	5e                   	pop    %esi
80107338:	5f                   	pop    %edi
80107339:	5d                   	pop    %ebp
8010733a:	c3                   	ret    
8010733b:	90                   	nop
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107340 <uartputc>:
  if(!uart)
80107340:	8b 15 7c c6 10 80    	mov    0x8010c67c,%edx
{
80107346:	55                   	push   %ebp
80107347:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107349:	85 d2                	test   %edx,%edx
{
8010734b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010734e:	74 10                	je     80107360 <uartputc+0x20>
}
80107350:	5d                   	pop    %ebp
80107351:	e9 da fe ff ff       	jmp    80107230 <uartputc.part.0>
80107356:	8d 76 00             	lea    0x0(%esi),%esi
80107359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107360:	5d                   	pop    %ebp
80107361:	c3                   	ret    
80107362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <uartintr>:

void
uartintr(void)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107376:	68 00 72 10 80       	push   $0x80107200
8010737b:	e8 90 94 ff ff       	call   80100810 <consoleintr>
}
80107380:	83 c4 10             	add    $0x10,%esp
80107383:	c9                   	leave  
80107384:	c3                   	ret    

80107385 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107385:	6a 00                	push   $0x0
  pushl $0
80107387:	6a 00                	push   $0x0
  jmp alltraps
80107389:	e9 15 fb ff ff       	jmp    80106ea3 <alltraps>

8010738e <vector1>:
.globl vector1
vector1:
  pushl $0
8010738e:	6a 00                	push   $0x0
  pushl $1
80107390:	6a 01                	push   $0x1
  jmp alltraps
80107392:	e9 0c fb ff ff       	jmp    80106ea3 <alltraps>

80107397 <vector2>:
.globl vector2
vector2:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $2
80107399:	6a 02                	push   $0x2
  jmp alltraps
8010739b:	e9 03 fb ff ff       	jmp    80106ea3 <alltraps>

801073a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801073a0:	6a 00                	push   $0x0
  pushl $3
801073a2:	6a 03                	push   $0x3
  jmp alltraps
801073a4:	e9 fa fa ff ff       	jmp    80106ea3 <alltraps>

801073a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801073a9:	6a 00                	push   $0x0
  pushl $4
801073ab:	6a 04                	push   $0x4
  jmp alltraps
801073ad:	e9 f1 fa ff ff       	jmp    80106ea3 <alltraps>

801073b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801073b2:	6a 00                	push   $0x0
  pushl $5
801073b4:	6a 05                	push   $0x5
  jmp alltraps
801073b6:	e9 e8 fa ff ff       	jmp    80106ea3 <alltraps>

801073bb <vector6>:
.globl vector6
vector6:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $6
801073bd:	6a 06                	push   $0x6
  jmp alltraps
801073bf:	e9 df fa ff ff       	jmp    80106ea3 <alltraps>

801073c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801073c4:	6a 00                	push   $0x0
  pushl $7
801073c6:	6a 07                	push   $0x7
  jmp alltraps
801073c8:	e9 d6 fa ff ff       	jmp    80106ea3 <alltraps>

801073cd <vector8>:
.globl vector8
vector8:
  pushl $8
801073cd:	6a 08                	push   $0x8
  jmp alltraps
801073cf:	e9 cf fa ff ff       	jmp    80106ea3 <alltraps>

801073d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801073d4:	6a 00                	push   $0x0
  pushl $9
801073d6:	6a 09                	push   $0x9
  jmp alltraps
801073d8:	e9 c6 fa ff ff       	jmp    80106ea3 <alltraps>

801073dd <vector10>:
.globl vector10
vector10:
  pushl $10
801073dd:	6a 0a                	push   $0xa
  jmp alltraps
801073df:	e9 bf fa ff ff       	jmp    80106ea3 <alltraps>

801073e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801073e4:	6a 0b                	push   $0xb
  jmp alltraps
801073e6:	e9 b8 fa ff ff       	jmp    80106ea3 <alltraps>

801073eb <vector12>:
.globl vector12
vector12:
  pushl $12
801073eb:	6a 0c                	push   $0xc
  jmp alltraps
801073ed:	e9 b1 fa ff ff       	jmp    80106ea3 <alltraps>

801073f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801073f2:	6a 0d                	push   $0xd
  jmp alltraps
801073f4:	e9 aa fa ff ff       	jmp    80106ea3 <alltraps>

801073f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801073f9:	6a 0e                	push   $0xe
  jmp alltraps
801073fb:	e9 a3 fa ff ff       	jmp    80106ea3 <alltraps>

80107400 <vector15>:
.globl vector15
vector15:
  pushl $0
80107400:	6a 00                	push   $0x0
  pushl $15
80107402:	6a 0f                	push   $0xf
  jmp alltraps
80107404:	e9 9a fa ff ff       	jmp    80106ea3 <alltraps>

80107409 <vector16>:
.globl vector16
vector16:
  pushl $0
80107409:	6a 00                	push   $0x0
  pushl $16
8010740b:	6a 10                	push   $0x10
  jmp alltraps
8010740d:	e9 91 fa ff ff       	jmp    80106ea3 <alltraps>

80107412 <vector17>:
.globl vector17
vector17:
  pushl $17
80107412:	6a 11                	push   $0x11
  jmp alltraps
80107414:	e9 8a fa ff ff       	jmp    80106ea3 <alltraps>

80107419 <vector18>:
.globl vector18
vector18:
  pushl $0
80107419:	6a 00                	push   $0x0
  pushl $18
8010741b:	6a 12                	push   $0x12
  jmp alltraps
8010741d:	e9 81 fa ff ff       	jmp    80106ea3 <alltraps>

80107422 <vector19>:
.globl vector19
vector19:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $19
80107424:	6a 13                	push   $0x13
  jmp alltraps
80107426:	e9 78 fa ff ff       	jmp    80106ea3 <alltraps>

8010742b <vector20>:
.globl vector20
vector20:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $20
8010742d:	6a 14                	push   $0x14
  jmp alltraps
8010742f:	e9 6f fa ff ff       	jmp    80106ea3 <alltraps>

80107434 <vector21>:
.globl vector21
vector21:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $21
80107436:	6a 15                	push   $0x15
  jmp alltraps
80107438:	e9 66 fa ff ff       	jmp    80106ea3 <alltraps>

8010743d <vector22>:
.globl vector22
vector22:
  pushl $0
8010743d:	6a 00                	push   $0x0
  pushl $22
8010743f:	6a 16                	push   $0x16
  jmp alltraps
80107441:	e9 5d fa ff ff       	jmp    80106ea3 <alltraps>

80107446 <vector23>:
.globl vector23
vector23:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $23
80107448:	6a 17                	push   $0x17
  jmp alltraps
8010744a:	e9 54 fa ff ff       	jmp    80106ea3 <alltraps>

8010744f <vector24>:
.globl vector24
vector24:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $24
80107451:	6a 18                	push   $0x18
  jmp alltraps
80107453:	e9 4b fa ff ff       	jmp    80106ea3 <alltraps>

80107458 <vector25>:
.globl vector25
vector25:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $25
8010745a:	6a 19                	push   $0x19
  jmp alltraps
8010745c:	e9 42 fa ff ff       	jmp    80106ea3 <alltraps>

80107461 <vector26>:
.globl vector26
vector26:
  pushl $0
80107461:	6a 00                	push   $0x0
  pushl $26
80107463:	6a 1a                	push   $0x1a
  jmp alltraps
80107465:	e9 39 fa ff ff       	jmp    80106ea3 <alltraps>

8010746a <vector27>:
.globl vector27
vector27:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $27
8010746c:	6a 1b                	push   $0x1b
  jmp alltraps
8010746e:	e9 30 fa ff ff       	jmp    80106ea3 <alltraps>

80107473 <vector28>:
.globl vector28
vector28:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $28
80107475:	6a 1c                	push   $0x1c
  jmp alltraps
80107477:	e9 27 fa ff ff       	jmp    80106ea3 <alltraps>

8010747c <vector29>:
.globl vector29
vector29:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $29
8010747e:	6a 1d                	push   $0x1d
  jmp alltraps
80107480:	e9 1e fa ff ff       	jmp    80106ea3 <alltraps>

80107485 <vector30>:
.globl vector30
vector30:
  pushl $0
80107485:	6a 00                	push   $0x0
  pushl $30
80107487:	6a 1e                	push   $0x1e
  jmp alltraps
80107489:	e9 15 fa ff ff       	jmp    80106ea3 <alltraps>

8010748e <vector31>:
.globl vector31
vector31:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $31
80107490:	6a 1f                	push   $0x1f
  jmp alltraps
80107492:	e9 0c fa ff ff       	jmp    80106ea3 <alltraps>

80107497 <vector32>:
.globl vector32
vector32:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $32
80107499:	6a 20                	push   $0x20
  jmp alltraps
8010749b:	e9 03 fa ff ff       	jmp    80106ea3 <alltraps>

801074a0 <vector33>:
.globl vector33
vector33:
  pushl $0
801074a0:	6a 00                	push   $0x0
  pushl $33
801074a2:	6a 21                	push   $0x21
  jmp alltraps
801074a4:	e9 fa f9 ff ff       	jmp    80106ea3 <alltraps>

801074a9 <vector34>:
.globl vector34
vector34:
  pushl $0
801074a9:	6a 00                	push   $0x0
  pushl $34
801074ab:	6a 22                	push   $0x22
  jmp alltraps
801074ad:	e9 f1 f9 ff ff       	jmp    80106ea3 <alltraps>

801074b2 <vector35>:
.globl vector35
vector35:
  pushl $0
801074b2:	6a 00                	push   $0x0
  pushl $35
801074b4:	6a 23                	push   $0x23
  jmp alltraps
801074b6:	e9 e8 f9 ff ff       	jmp    80106ea3 <alltraps>

801074bb <vector36>:
.globl vector36
vector36:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $36
801074bd:	6a 24                	push   $0x24
  jmp alltraps
801074bf:	e9 df f9 ff ff       	jmp    80106ea3 <alltraps>

801074c4 <vector37>:
.globl vector37
vector37:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $37
801074c6:	6a 25                	push   $0x25
  jmp alltraps
801074c8:	e9 d6 f9 ff ff       	jmp    80106ea3 <alltraps>

801074cd <vector38>:
.globl vector38
vector38:
  pushl $0
801074cd:	6a 00                	push   $0x0
  pushl $38
801074cf:	6a 26                	push   $0x26
  jmp alltraps
801074d1:	e9 cd f9 ff ff       	jmp    80106ea3 <alltraps>

801074d6 <vector39>:
.globl vector39
vector39:
  pushl $0
801074d6:	6a 00                	push   $0x0
  pushl $39
801074d8:	6a 27                	push   $0x27
  jmp alltraps
801074da:	e9 c4 f9 ff ff       	jmp    80106ea3 <alltraps>

801074df <vector40>:
.globl vector40
vector40:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $40
801074e1:	6a 28                	push   $0x28
  jmp alltraps
801074e3:	e9 bb f9 ff ff       	jmp    80106ea3 <alltraps>

801074e8 <vector41>:
.globl vector41
vector41:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $41
801074ea:	6a 29                	push   $0x29
  jmp alltraps
801074ec:	e9 b2 f9 ff ff       	jmp    80106ea3 <alltraps>

801074f1 <vector42>:
.globl vector42
vector42:
  pushl $0
801074f1:	6a 00                	push   $0x0
  pushl $42
801074f3:	6a 2a                	push   $0x2a
  jmp alltraps
801074f5:	e9 a9 f9 ff ff       	jmp    80106ea3 <alltraps>

801074fa <vector43>:
.globl vector43
vector43:
  pushl $0
801074fa:	6a 00                	push   $0x0
  pushl $43
801074fc:	6a 2b                	push   $0x2b
  jmp alltraps
801074fe:	e9 a0 f9 ff ff       	jmp    80106ea3 <alltraps>

80107503 <vector44>:
.globl vector44
vector44:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $44
80107505:	6a 2c                	push   $0x2c
  jmp alltraps
80107507:	e9 97 f9 ff ff       	jmp    80106ea3 <alltraps>

8010750c <vector45>:
.globl vector45
vector45:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $45
8010750e:	6a 2d                	push   $0x2d
  jmp alltraps
80107510:	e9 8e f9 ff ff       	jmp    80106ea3 <alltraps>

80107515 <vector46>:
.globl vector46
vector46:
  pushl $0
80107515:	6a 00                	push   $0x0
  pushl $46
80107517:	6a 2e                	push   $0x2e
  jmp alltraps
80107519:	e9 85 f9 ff ff       	jmp    80106ea3 <alltraps>

8010751e <vector47>:
.globl vector47
vector47:
  pushl $0
8010751e:	6a 00                	push   $0x0
  pushl $47
80107520:	6a 2f                	push   $0x2f
  jmp alltraps
80107522:	e9 7c f9 ff ff       	jmp    80106ea3 <alltraps>

80107527 <vector48>:
.globl vector48
vector48:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $48
80107529:	6a 30                	push   $0x30
  jmp alltraps
8010752b:	e9 73 f9 ff ff       	jmp    80106ea3 <alltraps>

80107530 <vector49>:
.globl vector49
vector49:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $49
80107532:	6a 31                	push   $0x31
  jmp alltraps
80107534:	e9 6a f9 ff ff       	jmp    80106ea3 <alltraps>

80107539 <vector50>:
.globl vector50
vector50:
  pushl $0
80107539:	6a 00                	push   $0x0
  pushl $50
8010753b:	6a 32                	push   $0x32
  jmp alltraps
8010753d:	e9 61 f9 ff ff       	jmp    80106ea3 <alltraps>

80107542 <vector51>:
.globl vector51
vector51:
  pushl $0
80107542:	6a 00                	push   $0x0
  pushl $51
80107544:	6a 33                	push   $0x33
  jmp alltraps
80107546:	e9 58 f9 ff ff       	jmp    80106ea3 <alltraps>

8010754b <vector52>:
.globl vector52
vector52:
  pushl $0
8010754b:	6a 00                	push   $0x0
  pushl $52
8010754d:	6a 34                	push   $0x34
  jmp alltraps
8010754f:	e9 4f f9 ff ff       	jmp    80106ea3 <alltraps>

80107554 <vector53>:
.globl vector53
vector53:
  pushl $0
80107554:	6a 00                	push   $0x0
  pushl $53
80107556:	6a 35                	push   $0x35
  jmp alltraps
80107558:	e9 46 f9 ff ff       	jmp    80106ea3 <alltraps>

8010755d <vector54>:
.globl vector54
vector54:
  pushl $0
8010755d:	6a 00                	push   $0x0
  pushl $54
8010755f:	6a 36                	push   $0x36
  jmp alltraps
80107561:	e9 3d f9 ff ff       	jmp    80106ea3 <alltraps>

80107566 <vector55>:
.globl vector55
vector55:
  pushl $0
80107566:	6a 00                	push   $0x0
  pushl $55
80107568:	6a 37                	push   $0x37
  jmp alltraps
8010756a:	e9 34 f9 ff ff       	jmp    80106ea3 <alltraps>

8010756f <vector56>:
.globl vector56
vector56:
  pushl $0
8010756f:	6a 00                	push   $0x0
  pushl $56
80107571:	6a 38                	push   $0x38
  jmp alltraps
80107573:	e9 2b f9 ff ff       	jmp    80106ea3 <alltraps>

80107578 <vector57>:
.globl vector57
vector57:
  pushl $0
80107578:	6a 00                	push   $0x0
  pushl $57
8010757a:	6a 39                	push   $0x39
  jmp alltraps
8010757c:	e9 22 f9 ff ff       	jmp    80106ea3 <alltraps>

80107581 <vector58>:
.globl vector58
vector58:
  pushl $0
80107581:	6a 00                	push   $0x0
  pushl $58
80107583:	6a 3a                	push   $0x3a
  jmp alltraps
80107585:	e9 19 f9 ff ff       	jmp    80106ea3 <alltraps>

8010758a <vector59>:
.globl vector59
vector59:
  pushl $0
8010758a:	6a 00                	push   $0x0
  pushl $59
8010758c:	6a 3b                	push   $0x3b
  jmp alltraps
8010758e:	e9 10 f9 ff ff       	jmp    80106ea3 <alltraps>

80107593 <vector60>:
.globl vector60
vector60:
  pushl $0
80107593:	6a 00                	push   $0x0
  pushl $60
80107595:	6a 3c                	push   $0x3c
  jmp alltraps
80107597:	e9 07 f9 ff ff       	jmp    80106ea3 <alltraps>

8010759c <vector61>:
.globl vector61
vector61:
  pushl $0
8010759c:	6a 00                	push   $0x0
  pushl $61
8010759e:	6a 3d                	push   $0x3d
  jmp alltraps
801075a0:	e9 fe f8 ff ff       	jmp    80106ea3 <alltraps>

801075a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801075a5:	6a 00                	push   $0x0
  pushl $62
801075a7:	6a 3e                	push   $0x3e
  jmp alltraps
801075a9:	e9 f5 f8 ff ff       	jmp    80106ea3 <alltraps>

801075ae <vector63>:
.globl vector63
vector63:
  pushl $0
801075ae:	6a 00                	push   $0x0
  pushl $63
801075b0:	6a 3f                	push   $0x3f
  jmp alltraps
801075b2:	e9 ec f8 ff ff       	jmp    80106ea3 <alltraps>

801075b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801075b7:	6a 00                	push   $0x0
  pushl $64
801075b9:	6a 40                	push   $0x40
  jmp alltraps
801075bb:	e9 e3 f8 ff ff       	jmp    80106ea3 <alltraps>

801075c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801075c0:	6a 00                	push   $0x0
  pushl $65
801075c2:	6a 41                	push   $0x41
  jmp alltraps
801075c4:	e9 da f8 ff ff       	jmp    80106ea3 <alltraps>

801075c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801075c9:	6a 00                	push   $0x0
  pushl $66
801075cb:	6a 42                	push   $0x42
  jmp alltraps
801075cd:	e9 d1 f8 ff ff       	jmp    80106ea3 <alltraps>

801075d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801075d2:	6a 00                	push   $0x0
  pushl $67
801075d4:	6a 43                	push   $0x43
  jmp alltraps
801075d6:	e9 c8 f8 ff ff       	jmp    80106ea3 <alltraps>

801075db <vector68>:
.globl vector68
vector68:
  pushl $0
801075db:	6a 00                	push   $0x0
  pushl $68
801075dd:	6a 44                	push   $0x44
  jmp alltraps
801075df:	e9 bf f8 ff ff       	jmp    80106ea3 <alltraps>

801075e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801075e4:	6a 00                	push   $0x0
  pushl $69
801075e6:	6a 45                	push   $0x45
  jmp alltraps
801075e8:	e9 b6 f8 ff ff       	jmp    80106ea3 <alltraps>

801075ed <vector70>:
.globl vector70
vector70:
  pushl $0
801075ed:	6a 00                	push   $0x0
  pushl $70
801075ef:	6a 46                	push   $0x46
  jmp alltraps
801075f1:	e9 ad f8 ff ff       	jmp    80106ea3 <alltraps>

801075f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801075f6:	6a 00                	push   $0x0
  pushl $71
801075f8:	6a 47                	push   $0x47
  jmp alltraps
801075fa:	e9 a4 f8 ff ff       	jmp    80106ea3 <alltraps>

801075ff <vector72>:
.globl vector72
vector72:
  pushl $0
801075ff:	6a 00                	push   $0x0
  pushl $72
80107601:	6a 48                	push   $0x48
  jmp alltraps
80107603:	e9 9b f8 ff ff       	jmp    80106ea3 <alltraps>

80107608 <vector73>:
.globl vector73
vector73:
  pushl $0
80107608:	6a 00                	push   $0x0
  pushl $73
8010760a:	6a 49                	push   $0x49
  jmp alltraps
8010760c:	e9 92 f8 ff ff       	jmp    80106ea3 <alltraps>

80107611 <vector74>:
.globl vector74
vector74:
  pushl $0
80107611:	6a 00                	push   $0x0
  pushl $74
80107613:	6a 4a                	push   $0x4a
  jmp alltraps
80107615:	e9 89 f8 ff ff       	jmp    80106ea3 <alltraps>

8010761a <vector75>:
.globl vector75
vector75:
  pushl $0
8010761a:	6a 00                	push   $0x0
  pushl $75
8010761c:	6a 4b                	push   $0x4b
  jmp alltraps
8010761e:	e9 80 f8 ff ff       	jmp    80106ea3 <alltraps>

80107623 <vector76>:
.globl vector76
vector76:
  pushl $0
80107623:	6a 00                	push   $0x0
  pushl $76
80107625:	6a 4c                	push   $0x4c
  jmp alltraps
80107627:	e9 77 f8 ff ff       	jmp    80106ea3 <alltraps>

8010762c <vector77>:
.globl vector77
vector77:
  pushl $0
8010762c:	6a 00                	push   $0x0
  pushl $77
8010762e:	6a 4d                	push   $0x4d
  jmp alltraps
80107630:	e9 6e f8 ff ff       	jmp    80106ea3 <alltraps>

80107635 <vector78>:
.globl vector78
vector78:
  pushl $0
80107635:	6a 00                	push   $0x0
  pushl $78
80107637:	6a 4e                	push   $0x4e
  jmp alltraps
80107639:	e9 65 f8 ff ff       	jmp    80106ea3 <alltraps>

8010763e <vector79>:
.globl vector79
vector79:
  pushl $0
8010763e:	6a 00                	push   $0x0
  pushl $79
80107640:	6a 4f                	push   $0x4f
  jmp alltraps
80107642:	e9 5c f8 ff ff       	jmp    80106ea3 <alltraps>

80107647 <vector80>:
.globl vector80
vector80:
  pushl $0
80107647:	6a 00                	push   $0x0
  pushl $80
80107649:	6a 50                	push   $0x50
  jmp alltraps
8010764b:	e9 53 f8 ff ff       	jmp    80106ea3 <alltraps>

80107650 <vector81>:
.globl vector81
vector81:
  pushl $0
80107650:	6a 00                	push   $0x0
  pushl $81
80107652:	6a 51                	push   $0x51
  jmp alltraps
80107654:	e9 4a f8 ff ff       	jmp    80106ea3 <alltraps>

80107659 <vector82>:
.globl vector82
vector82:
  pushl $0
80107659:	6a 00                	push   $0x0
  pushl $82
8010765b:	6a 52                	push   $0x52
  jmp alltraps
8010765d:	e9 41 f8 ff ff       	jmp    80106ea3 <alltraps>

80107662 <vector83>:
.globl vector83
vector83:
  pushl $0
80107662:	6a 00                	push   $0x0
  pushl $83
80107664:	6a 53                	push   $0x53
  jmp alltraps
80107666:	e9 38 f8 ff ff       	jmp    80106ea3 <alltraps>

8010766b <vector84>:
.globl vector84
vector84:
  pushl $0
8010766b:	6a 00                	push   $0x0
  pushl $84
8010766d:	6a 54                	push   $0x54
  jmp alltraps
8010766f:	e9 2f f8 ff ff       	jmp    80106ea3 <alltraps>

80107674 <vector85>:
.globl vector85
vector85:
  pushl $0
80107674:	6a 00                	push   $0x0
  pushl $85
80107676:	6a 55                	push   $0x55
  jmp alltraps
80107678:	e9 26 f8 ff ff       	jmp    80106ea3 <alltraps>

8010767d <vector86>:
.globl vector86
vector86:
  pushl $0
8010767d:	6a 00                	push   $0x0
  pushl $86
8010767f:	6a 56                	push   $0x56
  jmp alltraps
80107681:	e9 1d f8 ff ff       	jmp    80106ea3 <alltraps>

80107686 <vector87>:
.globl vector87
vector87:
  pushl $0
80107686:	6a 00                	push   $0x0
  pushl $87
80107688:	6a 57                	push   $0x57
  jmp alltraps
8010768a:	e9 14 f8 ff ff       	jmp    80106ea3 <alltraps>

8010768f <vector88>:
.globl vector88
vector88:
  pushl $0
8010768f:	6a 00                	push   $0x0
  pushl $88
80107691:	6a 58                	push   $0x58
  jmp alltraps
80107693:	e9 0b f8 ff ff       	jmp    80106ea3 <alltraps>

80107698 <vector89>:
.globl vector89
vector89:
  pushl $0
80107698:	6a 00                	push   $0x0
  pushl $89
8010769a:	6a 59                	push   $0x59
  jmp alltraps
8010769c:	e9 02 f8 ff ff       	jmp    80106ea3 <alltraps>

801076a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801076a1:	6a 00                	push   $0x0
  pushl $90
801076a3:	6a 5a                	push   $0x5a
  jmp alltraps
801076a5:	e9 f9 f7 ff ff       	jmp    80106ea3 <alltraps>

801076aa <vector91>:
.globl vector91
vector91:
  pushl $0
801076aa:	6a 00                	push   $0x0
  pushl $91
801076ac:	6a 5b                	push   $0x5b
  jmp alltraps
801076ae:	e9 f0 f7 ff ff       	jmp    80106ea3 <alltraps>

801076b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801076b3:	6a 00                	push   $0x0
  pushl $92
801076b5:	6a 5c                	push   $0x5c
  jmp alltraps
801076b7:	e9 e7 f7 ff ff       	jmp    80106ea3 <alltraps>

801076bc <vector93>:
.globl vector93
vector93:
  pushl $0
801076bc:	6a 00                	push   $0x0
  pushl $93
801076be:	6a 5d                	push   $0x5d
  jmp alltraps
801076c0:	e9 de f7 ff ff       	jmp    80106ea3 <alltraps>

801076c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801076c5:	6a 00                	push   $0x0
  pushl $94
801076c7:	6a 5e                	push   $0x5e
  jmp alltraps
801076c9:	e9 d5 f7 ff ff       	jmp    80106ea3 <alltraps>

801076ce <vector95>:
.globl vector95
vector95:
  pushl $0
801076ce:	6a 00                	push   $0x0
  pushl $95
801076d0:	6a 5f                	push   $0x5f
  jmp alltraps
801076d2:	e9 cc f7 ff ff       	jmp    80106ea3 <alltraps>

801076d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801076d7:	6a 00                	push   $0x0
  pushl $96
801076d9:	6a 60                	push   $0x60
  jmp alltraps
801076db:	e9 c3 f7 ff ff       	jmp    80106ea3 <alltraps>

801076e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801076e0:	6a 00                	push   $0x0
  pushl $97
801076e2:	6a 61                	push   $0x61
  jmp alltraps
801076e4:	e9 ba f7 ff ff       	jmp    80106ea3 <alltraps>

801076e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801076e9:	6a 00                	push   $0x0
  pushl $98
801076eb:	6a 62                	push   $0x62
  jmp alltraps
801076ed:	e9 b1 f7 ff ff       	jmp    80106ea3 <alltraps>

801076f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801076f2:	6a 00                	push   $0x0
  pushl $99
801076f4:	6a 63                	push   $0x63
  jmp alltraps
801076f6:	e9 a8 f7 ff ff       	jmp    80106ea3 <alltraps>

801076fb <vector100>:
.globl vector100
vector100:
  pushl $0
801076fb:	6a 00                	push   $0x0
  pushl $100
801076fd:	6a 64                	push   $0x64
  jmp alltraps
801076ff:	e9 9f f7 ff ff       	jmp    80106ea3 <alltraps>

80107704 <vector101>:
.globl vector101
vector101:
  pushl $0
80107704:	6a 00                	push   $0x0
  pushl $101
80107706:	6a 65                	push   $0x65
  jmp alltraps
80107708:	e9 96 f7 ff ff       	jmp    80106ea3 <alltraps>

8010770d <vector102>:
.globl vector102
vector102:
  pushl $0
8010770d:	6a 00                	push   $0x0
  pushl $102
8010770f:	6a 66                	push   $0x66
  jmp alltraps
80107711:	e9 8d f7 ff ff       	jmp    80106ea3 <alltraps>

80107716 <vector103>:
.globl vector103
vector103:
  pushl $0
80107716:	6a 00                	push   $0x0
  pushl $103
80107718:	6a 67                	push   $0x67
  jmp alltraps
8010771a:	e9 84 f7 ff ff       	jmp    80106ea3 <alltraps>

8010771f <vector104>:
.globl vector104
vector104:
  pushl $0
8010771f:	6a 00                	push   $0x0
  pushl $104
80107721:	6a 68                	push   $0x68
  jmp alltraps
80107723:	e9 7b f7 ff ff       	jmp    80106ea3 <alltraps>

80107728 <vector105>:
.globl vector105
vector105:
  pushl $0
80107728:	6a 00                	push   $0x0
  pushl $105
8010772a:	6a 69                	push   $0x69
  jmp alltraps
8010772c:	e9 72 f7 ff ff       	jmp    80106ea3 <alltraps>

80107731 <vector106>:
.globl vector106
vector106:
  pushl $0
80107731:	6a 00                	push   $0x0
  pushl $106
80107733:	6a 6a                	push   $0x6a
  jmp alltraps
80107735:	e9 69 f7 ff ff       	jmp    80106ea3 <alltraps>

8010773a <vector107>:
.globl vector107
vector107:
  pushl $0
8010773a:	6a 00                	push   $0x0
  pushl $107
8010773c:	6a 6b                	push   $0x6b
  jmp alltraps
8010773e:	e9 60 f7 ff ff       	jmp    80106ea3 <alltraps>

80107743 <vector108>:
.globl vector108
vector108:
  pushl $0
80107743:	6a 00                	push   $0x0
  pushl $108
80107745:	6a 6c                	push   $0x6c
  jmp alltraps
80107747:	e9 57 f7 ff ff       	jmp    80106ea3 <alltraps>

8010774c <vector109>:
.globl vector109
vector109:
  pushl $0
8010774c:	6a 00                	push   $0x0
  pushl $109
8010774e:	6a 6d                	push   $0x6d
  jmp alltraps
80107750:	e9 4e f7 ff ff       	jmp    80106ea3 <alltraps>

80107755 <vector110>:
.globl vector110
vector110:
  pushl $0
80107755:	6a 00                	push   $0x0
  pushl $110
80107757:	6a 6e                	push   $0x6e
  jmp alltraps
80107759:	e9 45 f7 ff ff       	jmp    80106ea3 <alltraps>

8010775e <vector111>:
.globl vector111
vector111:
  pushl $0
8010775e:	6a 00                	push   $0x0
  pushl $111
80107760:	6a 6f                	push   $0x6f
  jmp alltraps
80107762:	e9 3c f7 ff ff       	jmp    80106ea3 <alltraps>

80107767 <vector112>:
.globl vector112
vector112:
  pushl $0
80107767:	6a 00                	push   $0x0
  pushl $112
80107769:	6a 70                	push   $0x70
  jmp alltraps
8010776b:	e9 33 f7 ff ff       	jmp    80106ea3 <alltraps>

80107770 <vector113>:
.globl vector113
vector113:
  pushl $0
80107770:	6a 00                	push   $0x0
  pushl $113
80107772:	6a 71                	push   $0x71
  jmp alltraps
80107774:	e9 2a f7 ff ff       	jmp    80106ea3 <alltraps>

80107779 <vector114>:
.globl vector114
vector114:
  pushl $0
80107779:	6a 00                	push   $0x0
  pushl $114
8010777b:	6a 72                	push   $0x72
  jmp alltraps
8010777d:	e9 21 f7 ff ff       	jmp    80106ea3 <alltraps>

80107782 <vector115>:
.globl vector115
vector115:
  pushl $0
80107782:	6a 00                	push   $0x0
  pushl $115
80107784:	6a 73                	push   $0x73
  jmp alltraps
80107786:	e9 18 f7 ff ff       	jmp    80106ea3 <alltraps>

8010778b <vector116>:
.globl vector116
vector116:
  pushl $0
8010778b:	6a 00                	push   $0x0
  pushl $116
8010778d:	6a 74                	push   $0x74
  jmp alltraps
8010778f:	e9 0f f7 ff ff       	jmp    80106ea3 <alltraps>

80107794 <vector117>:
.globl vector117
vector117:
  pushl $0
80107794:	6a 00                	push   $0x0
  pushl $117
80107796:	6a 75                	push   $0x75
  jmp alltraps
80107798:	e9 06 f7 ff ff       	jmp    80106ea3 <alltraps>

8010779d <vector118>:
.globl vector118
vector118:
  pushl $0
8010779d:	6a 00                	push   $0x0
  pushl $118
8010779f:	6a 76                	push   $0x76
  jmp alltraps
801077a1:	e9 fd f6 ff ff       	jmp    80106ea3 <alltraps>

801077a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801077a6:	6a 00                	push   $0x0
  pushl $119
801077a8:	6a 77                	push   $0x77
  jmp alltraps
801077aa:	e9 f4 f6 ff ff       	jmp    80106ea3 <alltraps>

801077af <vector120>:
.globl vector120
vector120:
  pushl $0
801077af:	6a 00                	push   $0x0
  pushl $120
801077b1:	6a 78                	push   $0x78
  jmp alltraps
801077b3:	e9 eb f6 ff ff       	jmp    80106ea3 <alltraps>

801077b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801077b8:	6a 00                	push   $0x0
  pushl $121
801077ba:	6a 79                	push   $0x79
  jmp alltraps
801077bc:	e9 e2 f6 ff ff       	jmp    80106ea3 <alltraps>

801077c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801077c1:	6a 00                	push   $0x0
  pushl $122
801077c3:	6a 7a                	push   $0x7a
  jmp alltraps
801077c5:	e9 d9 f6 ff ff       	jmp    80106ea3 <alltraps>

801077ca <vector123>:
.globl vector123
vector123:
  pushl $0
801077ca:	6a 00                	push   $0x0
  pushl $123
801077cc:	6a 7b                	push   $0x7b
  jmp alltraps
801077ce:	e9 d0 f6 ff ff       	jmp    80106ea3 <alltraps>

801077d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801077d3:	6a 00                	push   $0x0
  pushl $124
801077d5:	6a 7c                	push   $0x7c
  jmp alltraps
801077d7:	e9 c7 f6 ff ff       	jmp    80106ea3 <alltraps>

801077dc <vector125>:
.globl vector125
vector125:
  pushl $0
801077dc:	6a 00                	push   $0x0
  pushl $125
801077de:	6a 7d                	push   $0x7d
  jmp alltraps
801077e0:	e9 be f6 ff ff       	jmp    80106ea3 <alltraps>

801077e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801077e5:	6a 00                	push   $0x0
  pushl $126
801077e7:	6a 7e                	push   $0x7e
  jmp alltraps
801077e9:	e9 b5 f6 ff ff       	jmp    80106ea3 <alltraps>

801077ee <vector127>:
.globl vector127
vector127:
  pushl $0
801077ee:	6a 00                	push   $0x0
  pushl $127
801077f0:	6a 7f                	push   $0x7f
  jmp alltraps
801077f2:	e9 ac f6 ff ff       	jmp    80106ea3 <alltraps>

801077f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801077f7:	6a 00                	push   $0x0
  pushl $128
801077f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801077fe:	e9 a0 f6 ff ff       	jmp    80106ea3 <alltraps>

80107803 <vector129>:
.globl vector129
vector129:
  pushl $0
80107803:	6a 00                	push   $0x0
  pushl $129
80107805:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010780a:	e9 94 f6 ff ff       	jmp    80106ea3 <alltraps>

8010780f <vector130>:
.globl vector130
vector130:
  pushl $0
8010780f:	6a 00                	push   $0x0
  pushl $130
80107811:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107816:	e9 88 f6 ff ff       	jmp    80106ea3 <alltraps>

8010781b <vector131>:
.globl vector131
vector131:
  pushl $0
8010781b:	6a 00                	push   $0x0
  pushl $131
8010781d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107822:	e9 7c f6 ff ff       	jmp    80106ea3 <alltraps>

80107827 <vector132>:
.globl vector132
vector132:
  pushl $0
80107827:	6a 00                	push   $0x0
  pushl $132
80107829:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010782e:	e9 70 f6 ff ff       	jmp    80106ea3 <alltraps>

80107833 <vector133>:
.globl vector133
vector133:
  pushl $0
80107833:	6a 00                	push   $0x0
  pushl $133
80107835:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010783a:	e9 64 f6 ff ff       	jmp    80106ea3 <alltraps>

8010783f <vector134>:
.globl vector134
vector134:
  pushl $0
8010783f:	6a 00                	push   $0x0
  pushl $134
80107841:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107846:	e9 58 f6 ff ff       	jmp    80106ea3 <alltraps>

8010784b <vector135>:
.globl vector135
vector135:
  pushl $0
8010784b:	6a 00                	push   $0x0
  pushl $135
8010784d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107852:	e9 4c f6 ff ff       	jmp    80106ea3 <alltraps>

80107857 <vector136>:
.globl vector136
vector136:
  pushl $0
80107857:	6a 00                	push   $0x0
  pushl $136
80107859:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010785e:	e9 40 f6 ff ff       	jmp    80106ea3 <alltraps>

80107863 <vector137>:
.globl vector137
vector137:
  pushl $0
80107863:	6a 00                	push   $0x0
  pushl $137
80107865:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010786a:	e9 34 f6 ff ff       	jmp    80106ea3 <alltraps>

8010786f <vector138>:
.globl vector138
vector138:
  pushl $0
8010786f:	6a 00                	push   $0x0
  pushl $138
80107871:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107876:	e9 28 f6 ff ff       	jmp    80106ea3 <alltraps>

8010787b <vector139>:
.globl vector139
vector139:
  pushl $0
8010787b:	6a 00                	push   $0x0
  pushl $139
8010787d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107882:	e9 1c f6 ff ff       	jmp    80106ea3 <alltraps>

80107887 <vector140>:
.globl vector140
vector140:
  pushl $0
80107887:	6a 00                	push   $0x0
  pushl $140
80107889:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010788e:	e9 10 f6 ff ff       	jmp    80106ea3 <alltraps>

80107893 <vector141>:
.globl vector141
vector141:
  pushl $0
80107893:	6a 00                	push   $0x0
  pushl $141
80107895:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010789a:	e9 04 f6 ff ff       	jmp    80106ea3 <alltraps>

8010789f <vector142>:
.globl vector142
vector142:
  pushl $0
8010789f:	6a 00                	push   $0x0
  pushl $142
801078a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801078a6:	e9 f8 f5 ff ff       	jmp    80106ea3 <alltraps>

801078ab <vector143>:
.globl vector143
vector143:
  pushl $0
801078ab:	6a 00                	push   $0x0
  pushl $143
801078ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801078b2:	e9 ec f5 ff ff       	jmp    80106ea3 <alltraps>

801078b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801078b7:	6a 00                	push   $0x0
  pushl $144
801078b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801078be:	e9 e0 f5 ff ff       	jmp    80106ea3 <alltraps>

801078c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801078c3:	6a 00                	push   $0x0
  pushl $145
801078c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801078ca:	e9 d4 f5 ff ff       	jmp    80106ea3 <alltraps>

801078cf <vector146>:
.globl vector146
vector146:
  pushl $0
801078cf:	6a 00                	push   $0x0
  pushl $146
801078d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801078d6:	e9 c8 f5 ff ff       	jmp    80106ea3 <alltraps>

801078db <vector147>:
.globl vector147
vector147:
  pushl $0
801078db:	6a 00                	push   $0x0
  pushl $147
801078dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801078e2:	e9 bc f5 ff ff       	jmp    80106ea3 <alltraps>

801078e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801078e7:	6a 00                	push   $0x0
  pushl $148
801078e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801078ee:	e9 b0 f5 ff ff       	jmp    80106ea3 <alltraps>

801078f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801078f3:	6a 00                	push   $0x0
  pushl $149
801078f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801078fa:	e9 a4 f5 ff ff       	jmp    80106ea3 <alltraps>

801078ff <vector150>:
.globl vector150
vector150:
  pushl $0
801078ff:	6a 00                	push   $0x0
  pushl $150
80107901:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107906:	e9 98 f5 ff ff       	jmp    80106ea3 <alltraps>

8010790b <vector151>:
.globl vector151
vector151:
  pushl $0
8010790b:	6a 00                	push   $0x0
  pushl $151
8010790d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107912:	e9 8c f5 ff ff       	jmp    80106ea3 <alltraps>

80107917 <vector152>:
.globl vector152
vector152:
  pushl $0
80107917:	6a 00                	push   $0x0
  pushl $152
80107919:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010791e:	e9 80 f5 ff ff       	jmp    80106ea3 <alltraps>

80107923 <vector153>:
.globl vector153
vector153:
  pushl $0
80107923:	6a 00                	push   $0x0
  pushl $153
80107925:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010792a:	e9 74 f5 ff ff       	jmp    80106ea3 <alltraps>

8010792f <vector154>:
.globl vector154
vector154:
  pushl $0
8010792f:	6a 00                	push   $0x0
  pushl $154
80107931:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107936:	e9 68 f5 ff ff       	jmp    80106ea3 <alltraps>

8010793b <vector155>:
.globl vector155
vector155:
  pushl $0
8010793b:	6a 00                	push   $0x0
  pushl $155
8010793d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107942:	e9 5c f5 ff ff       	jmp    80106ea3 <alltraps>

80107947 <vector156>:
.globl vector156
vector156:
  pushl $0
80107947:	6a 00                	push   $0x0
  pushl $156
80107949:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010794e:	e9 50 f5 ff ff       	jmp    80106ea3 <alltraps>

80107953 <vector157>:
.globl vector157
vector157:
  pushl $0
80107953:	6a 00                	push   $0x0
  pushl $157
80107955:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010795a:	e9 44 f5 ff ff       	jmp    80106ea3 <alltraps>

8010795f <vector158>:
.globl vector158
vector158:
  pushl $0
8010795f:	6a 00                	push   $0x0
  pushl $158
80107961:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107966:	e9 38 f5 ff ff       	jmp    80106ea3 <alltraps>

8010796b <vector159>:
.globl vector159
vector159:
  pushl $0
8010796b:	6a 00                	push   $0x0
  pushl $159
8010796d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107972:	e9 2c f5 ff ff       	jmp    80106ea3 <alltraps>

80107977 <vector160>:
.globl vector160
vector160:
  pushl $0
80107977:	6a 00                	push   $0x0
  pushl $160
80107979:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010797e:	e9 20 f5 ff ff       	jmp    80106ea3 <alltraps>

80107983 <vector161>:
.globl vector161
vector161:
  pushl $0
80107983:	6a 00                	push   $0x0
  pushl $161
80107985:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010798a:	e9 14 f5 ff ff       	jmp    80106ea3 <alltraps>

8010798f <vector162>:
.globl vector162
vector162:
  pushl $0
8010798f:	6a 00                	push   $0x0
  pushl $162
80107991:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107996:	e9 08 f5 ff ff       	jmp    80106ea3 <alltraps>

8010799b <vector163>:
.globl vector163
vector163:
  pushl $0
8010799b:	6a 00                	push   $0x0
  pushl $163
8010799d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801079a2:	e9 fc f4 ff ff       	jmp    80106ea3 <alltraps>

801079a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801079a7:	6a 00                	push   $0x0
  pushl $164
801079a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801079ae:	e9 f0 f4 ff ff       	jmp    80106ea3 <alltraps>

801079b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801079b3:	6a 00                	push   $0x0
  pushl $165
801079b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801079ba:	e9 e4 f4 ff ff       	jmp    80106ea3 <alltraps>

801079bf <vector166>:
.globl vector166
vector166:
  pushl $0
801079bf:	6a 00                	push   $0x0
  pushl $166
801079c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801079c6:	e9 d8 f4 ff ff       	jmp    80106ea3 <alltraps>

801079cb <vector167>:
.globl vector167
vector167:
  pushl $0
801079cb:	6a 00                	push   $0x0
  pushl $167
801079cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801079d2:	e9 cc f4 ff ff       	jmp    80106ea3 <alltraps>

801079d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801079d7:	6a 00                	push   $0x0
  pushl $168
801079d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801079de:	e9 c0 f4 ff ff       	jmp    80106ea3 <alltraps>

801079e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801079e3:	6a 00                	push   $0x0
  pushl $169
801079e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801079ea:	e9 b4 f4 ff ff       	jmp    80106ea3 <alltraps>

801079ef <vector170>:
.globl vector170
vector170:
  pushl $0
801079ef:	6a 00                	push   $0x0
  pushl $170
801079f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801079f6:	e9 a8 f4 ff ff       	jmp    80106ea3 <alltraps>

801079fb <vector171>:
.globl vector171
vector171:
  pushl $0
801079fb:	6a 00                	push   $0x0
  pushl $171
801079fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107a02:	e9 9c f4 ff ff       	jmp    80106ea3 <alltraps>

80107a07 <vector172>:
.globl vector172
vector172:
  pushl $0
80107a07:	6a 00                	push   $0x0
  pushl $172
80107a09:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107a0e:	e9 90 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a13 <vector173>:
.globl vector173
vector173:
  pushl $0
80107a13:	6a 00                	push   $0x0
  pushl $173
80107a15:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107a1a:	e9 84 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a1f <vector174>:
.globl vector174
vector174:
  pushl $0
80107a1f:	6a 00                	push   $0x0
  pushl $174
80107a21:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107a26:	e9 78 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a2b <vector175>:
.globl vector175
vector175:
  pushl $0
80107a2b:	6a 00                	push   $0x0
  pushl $175
80107a2d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107a32:	e9 6c f4 ff ff       	jmp    80106ea3 <alltraps>

80107a37 <vector176>:
.globl vector176
vector176:
  pushl $0
80107a37:	6a 00                	push   $0x0
  pushl $176
80107a39:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107a3e:	e9 60 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a43 <vector177>:
.globl vector177
vector177:
  pushl $0
80107a43:	6a 00                	push   $0x0
  pushl $177
80107a45:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107a4a:	e9 54 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a4f <vector178>:
.globl vector178
vector178:
  pushl $0
80107a4f:	6a 00                	push   $0x0
  pushl $178
80107a51:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107a56:	e9 48 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a5b <vector179>:
.globl vector179
vector179:
  pushl $0
80107a5b:	6a 00                	push   $0x0
  pushl $179
80107a5d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107a62:	e9 3c f4 ff ff       	jmp    80106ea3 <alltraps>

80107a67 <vector180>:
.globl vector180
vector180:
  pushl $0
80107a67:	6a 00                	push   $0x0
  pushl $180
80107a69:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107a6e:	e9 30 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a73 <vector181>:
.globl vector181
vector181:
  pushl $0
80107a73:	6a 00                	push   $0x0
  pushl $181
80107a75:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107a7a:	e9 24 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a7f <vector182>:
.globl vector182
vector182:
  pushl $0
80107a7f:	6a 00                	push   $0x0
  pushl $182
80107a81:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107a86:	e9 18 f4 ff ff       	jmp    80106ea3 <alltraps>

80107a8b <vector183>:
.globl vector183
vector183:
  pushl $0
80107a8b:	6a 00                	push   $0x0
  pushl $183
80107a8d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107a92:	e9 0c f4 ff ff       	jmp    80106ea3 <alltraps>

80107a97 <vector184>:
.globl vector184
vector184:
  pushl $0
80107a97:	6a 00                	push   $0x0
  pushl $184
80107a99:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107a9e:	e9 00 f4 ff ff       	jmp    80106ea3 <alltraps>

80107aa3 <vector185>:
.globl vector185
vector185:
  pushl $0
80107aa3:	6a 00                	push   $0x0
  pushl $185
80107aa5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107aaa:	e9 f4 f3 ff ff       	jmp    80106ea3 <alltraps>

80107aaf <vector186>:
.globl vector186
vector186:
  pushl $0
80107aaf:	6a 00                	push   $0x0
  pushl $186
80107ab1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107ab6:	e9 e8 f3 ff ff       	jmp    80106ea3 <alltraps>

80107abb <vector187>:
.globl vector187
vector187:
  pushl $0
80107abb:	6a 00                	push   $0x0
  pushl $187
80107abd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107ac2:	e9 dc f3 ff ff       	jmp    80106ea3 <alltraps>

80107ac7 <vector188>:
.globl vector188
vector188:
  pushl $0
80107ac7:	6a 00                	push   $0x0
  pushl $188
80107ac9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107ace:	e9 d0 f3 ff ff       	jmp    80106ea3 <alltraps>

80107ad3 <vector189>:
.globl vector189
vector189:
  pushl $0
80107ad3:	6a 00                	push   $0x0
  pushl $189
80107ad5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107ada:	e9 c4 f3 ff ff       	jmp    80106ea3 <alltraps>

80107adf <vector190>:
.globl vector190
vector190:
  pushl $0
80107adf:	6a 00                	push   $0x0
  pushl $190
80107ae1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107ae6:	e9 b8 f3 ff ff       	jmp    80106ea3 <alltraps>

80107aeb <vector191>:
.globl vector191
vector191:
  pushl $0
80107aeb:	6a 00                	push   $0x0
  pushl $191
80107aed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107af2:	e9 ac f3 ff ff       	jmp    80106ea3 <alltraps>

80107af7 <vector192>:
.globl vector192
vector192:
  pushl $0
80107af7:	6a 00                	push   $0x0
  pushl $192
80107af9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107afe:	e9 a0 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b03 <vector193>:
.globl vector193
vector193:
  pushl $0
80107b03:	6a 00                	push   $0x0
  pushl $193
80107b05:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107b0a:	e9 94 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b0f <vector194>:
.globl vector194
vector194:
  pushl $0
80107b0f:	6a 00                	push   $0x0
  pushl $194
80107b11:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107b16:	e9 88 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b1b <vector195>:
.globl vector195
vector195:
  pushl $0
80107b1b:	6a 00                	push   $0x0
  pushl $195
80107b1d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107b22:	e9 7c f3 ff ff       	jmp    80106ea3 <alltraps>

80107b27 <vector196>:
.globl vector196
vector196:
  pushl $0
80107b27:	6a 00                	push   $0x0
  pushl $196
80107b29:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107b2e:	e9 70 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b33 <vector197>:
.globl vector197
vector197:
  pushl $0
80107b33:	6a 00                	push   $0x0
  pushl $197
80107b35:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107b3a:	e9 64 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b3f <vector198>:
.globl vector198
vector198:
  pushl $0
80107b3f:	6a 00                	push   $0x0
  pushl $198
80107b41:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107b46:	e9 58 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b4b <vector199>:
.globl vector199
vector199:
  pushl $0
80107b4b:	6a 00                	push   $0x0
  pushl $199
80107b4d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107b52:	e9 4c f3 ff ff       	jmp    80106ea3 <alltraps>

80107b57 <vector200>:
.globl vector200
vector200:
  pushl $0
80107b57:	6a 00                	push   $0x0
  pushl $200
80107b59:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107b5e:	e9 40 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b63 <vector201>:
.globl vector201
vector201:
  pushl $0
80107b63:	6a 00                	push   $0x0
  pushl $201
80107b65:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107b6a:	e9 34 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b6f <vector202>:
.globl vector202
vector202:
  pushl $0
80107b6f:	6a 00                	push   $0x0
  pushl $202
80107b71:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107b76:	e9 28 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b7b <vector203>:
.globl vector203
vector203:
  pushl $0
80107b7b:	6a 00                	push   $0x0
  pushl $203
80107b7d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107b82:	e9 1c f3 ff ff       	jmp    80106ea3 <alltraps>

80107b87 <vector204>:
.globl vector204
vector204:
  pushl $0
80107b87:	6a 00                	push   $0x0
  pushl $204
80107b89:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107b8e:	e9 10 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b93 <vector205>:
.globl vector205
vector205:
  pushl $0
80107b93:	6a 00                	push   $0x0
  pushl $205
80107b95:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107b9a:	e9 04 f3 ff ff       	jmp    80106ea3 <alltraps>

80107b9f <vector206>:
.globl vector206
vector206:
  pushl $0
80107b9f:	6a 00                	push   $0x0
  pushl $206
80107ba1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107ba6:	e9 f8 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bab <vector207>:
.globl vector207
vector207:
  pushl $0
80107bab:	6a 00                	push   $0x0
  pushl $207
80107bad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107bb2:	e9 ec f2 ff ff       	jmp    80106ea3 <alltraps>

80107bb7 <vector208>:
.globl vector208
vector208:
  pushl $0
80107bb7:	6a 00                	push   $0x0
  pushl $208
80107bb9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107bbe:	e9 e0 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bc3 <vector209>:
.globl vector209
vector209:
  pushl $0
80107bc3:	6a 00                	push   $0x0
  pushl $209
80107bc5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107bca:	e9 d4 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bcf <vector210>:
.globl vector210
vector210:
  pushl $0
80107bcf:	6a 00                	push   $0x0
  pushl $210
80107bd1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107bd6:	e9 c8 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bdb <vector211>:
.globl vector211
vector211:
  pushl $0
80107bdb:	6a 00                	push   $0x0
  pushl $211
80107bdd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107be2:	e9 bc f2 ff ff       	jmp    80106ea3 <alltraps>

80107be7 <vector212>:
.globl vector212
vector212:
  pushl $0
80107be7:	6a 00                	push   $0x0
  pushl $212
80107be9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107bee:	e9 b0 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bf3 <vector213>:
.globl vector213
vector213:
  pushl $0
80107bf3:	6a 00                	push   $0x0
  pushl $213
80107bf5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107bfa:	e9 a4 f2 ff ff       	jmp    80106ea3 <alltraps>

80107bff <vector214>:
.globl vector214
vector214:
  pushl $0
80107bff:	6a 00                	push   $0x0
  pushl $214
80107c01:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107c06:	e9 98 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c0b <vector215>:
.globl vector215
vector215:
  pushl $0
80107c0b:	6a 00                	push   $0x0
  pushl $215
80107c0d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107c12:	e9 8c f2 ff ff       	jmp    80106ea3 <alltraps>

80107c17 <vector216>:
.globl vector216
vector216:
  pushl $0
80107c17:	6a 00                	push   $0x0
  pushl $216
80107c19:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107c1e:	e9 80 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c23 <vector217>:
.globl vector217
vector217:
  pushl $0
80107c23:	6a 00                	push   $0x0
  pushl $217
80107c25:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107c2a:	e9 74 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c2f <vector218>:
.globl vector218
vector218:
  pushl $0
80107c2f:	6a 00                	push   $0x0
  pushl $218
80107c31:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107c36:	e9 68 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c3b <vector219>:
.globl vector219
vector219:
  pushl $0
80107c3b:	6a 00                	push   $0x0
  pushl $219
80107c3d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107c42:	e9 5c f2 ff ff       	jmp    80106ea3 <alltraps>

80107c47 <vector220>:
.globl vector220
vector220:
  pushl $0
80107c47:	6a 00                	push   $0x0
  pushl $220
80107c49:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107c4e:	e9 50 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c53 <vector221>:
.globl vector221
vector221:
  pushl $0
80107c53:	6a 00                	push   $0x0
  pushl $221
80107c55:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107c5a:	e9 44 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c5f <vector222>:
.globl vector222
vector222:
  pushl $0
80107c5f:	6a 00                	push   $0x0
  pushl $222
80107c61:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107c66:	e9 38 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c6b <vector223>:
.globl vector223
vector223:
  pushl $0
80107c6b:	6a 00                	push   $0x0
  pushl $223
80107c6d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107c72:	e9 2c f2 ff ff       	jmp    80106ea3 <alltraps>

80107c77 <vector224>:
.globl vector224
vector224:
  pushl $0
80107c77:	6a 00                	push   $0x0
  pushl $224
80107c79:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107c7e:	e9 20 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c83 <vector225>:
.globl vector225
vector225:
  pushl $0
80107c83:	6a 00                	push   $0x0
  pushl $225
80107c85:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107c8a:	e9 14 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c8f <vector226>:
.globl vector226
vector226:
  pushl $0
80107c8f:	6a 00                	push   $0x0
  pushl $226
80107c91:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107c96:	e9 08 f2 ff ff       	jmp    80106ea3 <alltraps>

80107c9b <vector227>:
.globl vector227
vector227:
  pushl $0
80107c9b:	6a 00                	push   $0x0
  pushl $227
80107c9d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107ca2:	e9 fc f1 ff ff       	jmp    80106ea3 <alltraps>

80107ca7 <vector228>:
.globl vector228
vector228:
  pushl $0
80107ca7:	6a 00                	push   $0x0
  pushl $228
80107ca9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107cae:	e9 f0 f1 ff ff       	jmp    80106ea3 <alltraps>

80107cb3 <vector229>:
.globl vector229
vector229:
  pushl $0
80107cb3:	6a 00                	push   $0x0
  pushl $229
80107cb5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107cba:	e9 e4 f1 ff ff       	jmp    80106ea3 <alltraps>

80107cbf <vector230>:
.globl vector230
vector230:
  pushl $0
80107cbf:	6a 00                	push   $0x0
  pushl $230
80107cc1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107cc6:	e9 d8 f1 ff ff       	jmp    80106ea3 <alltraps>

80107ccb <vector231>:
.globl vector231
vector231:
  pushl $0
80107ccb:	6a 00                	push   $0x0
  pushl $231
80107ccd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107cd2:	e9 cc f1 ff ff       	jmp    80106ea3 <alltraps>

80107cd7 <vector232>:
.globl vector232
vector232:
  pushl $0
80107cd7:	6a 00                	push   $0x0
  pushl $232
80107cd9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107cde:	e9 c0 f1 ff ff       	jmp    80106ea3 <alltraps>

80107ce3 <vector233>:
.globl vector233
vector233:
  pushl $0
80107ce3:	6a 00                	push   $0x0
  pushl $233
80107ce5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107cea:	e9 b4 f1 ff ff       	jmp    80106ea3 <alltraps>

80107cef <vector234>:
.globl vector234
vector234:
  pushl $0
80107cef:	6a 00                	push   $0x0
  pushl $234
80107cf1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107cf6:	e9 a8 f1 ff ff       	jmp    80106ea3 <alltraps>

80107cfb <vector235>:
.globl vector235
vector235:
  pushl $0
80107cfb:	6a 00                	push   $0x0
  pushl $235
80107cfd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107d02:	e9 9c f1 ff ff       	jmp    80106ea3 <alltraps>

80107d07 <vector236>:
.globl vector236
vector236:
  pushl $0
80107d07:	6a 00                	push   $0x0
  pushl $236
80107d09:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107d0e:	e9 90 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d13 <vector237>:
.globl vector237
vector237:
  pushl $0
80107d13:	6a 00                	push   $0x0
  pushl $237
80107d15:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107d1a:	e9 84 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d1f <vector238>:
.globl vector238
vector238:
  pushl $0
80107d1f:	6a 00                	push   $0x0
  pushl $238
80107d21:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107d26:	e9 78 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d2b <vector239>:
.globl vector239
vector239:
  pushl $0
80107d2b:	6a 00                	push   $0x0
  pushl $239
80107d2d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107d32:	e9 6c f1 ff ff       	jmp    80106ea3 <alltraps>

80107d37 <vector240>:
.globl vector240
vector240:
  pushl $0
80107d37:	6a 00                	push   $0x0
  pushl $240
80107d39:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107d3e:	e9 60 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d43 <vector241>:
.globl vector241
vector241:
  pushl $0
80107d43:	6a 00                	push   $0x0
  pushl $241
80107d45:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107d4a:	e9 54 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d4f <vector242>:
.globl vector242
vector242:
  pushl $0
80107d4f:	6a 00                	push   $0x0
  pushl $242
80107d51:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107d56:	e9 48 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d5b <vector243>:
.globl vector243
vector243:
  pushl $0
80107d5b:	6a 00                	push   $0x0
  pushl $243
80107d5d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107d62:	e9 3c f1 ff ff       	jmp    80106ea3 <alltraps>

80107d67 <vector244>:
.globl vector244
vector244:
  pushl $0
80107d67:	6a 00                	push   $0x0
  pushl $244
80107d69:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107d6e:	e9 30 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d73 <vector245>:
.globl vector245
vector245:
  pushl $0
80107d73:	6a 00                	push   $0x0
  pushl $245
80107d75:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107d7a:	e9 24 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d7f <vector246>:
.globl vector246
vector246:
  pushl $0
80107d7f:	6a 00                	push   $0x0
  pushl $246
80107d81:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107d86:	e9 18 f1 ff ff       	jmp    80106ea3 <alltraps>

80107d8b <vector247>:
.globl vector247
vector247:
  pushl $0
80107d8b:	6a 00                	push   $0x0
  pushl $247
80107d8d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107d92:	e9 0c f1 ff ff       	jmp    80106ea3 <alltraps>

80107d97 <vector248>:
.globl vector248
vector248:
  pushl $0
80107d97:	6a 00                	push   $0x0
  pushl $248
80107d99:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107d9e:	e9 00 f1 ff ff       	jmp    80106ea3 <alltraps>

80107da3 <vector249>:
.globl vector249
vector249:
  pushl $0
80107da3:	6a 00                	push   $0x0
  pushl $249
80107da5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107daa:	e9 f4 f0 ff ff       	jmp    80106ea3 <alltraps>

80107daf <vector250>:
.globl vector250
vector250:
  pushl $0
80107daf:	6a 00                	push   $0x0
  pushl $250
80107db1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107db6:	e9 e8 f0 ff ff       	jmp    80106ea3 <alltraps>

80107dbb <vector251>:
.globl vector251
vector251:
  pushl $0
80107dbb:	6a 00                	push   $0x0
  pushl $251
80107dbd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107dc2:	e9 dc f0 ff ff       	jmp    80106ea3 <alltraps>

80107dc7 <vector252>:
.globl vector252
vector252:
  pushl $0
80107dc7:	6a 00                	push   $0x0
  pushl $252
80107dc9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107dce:	e9 d0 f0 ff ff       	jmp    80106ea3 <alltraps>

80107dd3 <vector253>:
.globl vector253
vector253:
  pushl $0
80107dd3:	6a 00                	push   $0x0
  pushl $253
80107dd5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107dda:	e9 c4 f0 ff ff       	jmp    80106ea3 <alltraps>

80107ddf <vector254>:
.globl vector254
vector254:
  pushl $0
80107ddf:	6a 00                	push   $0x0
  pushl $254
80107de1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107de6:	e9 b8 f0 ff ff       	jmp    80106ea3 <alltraps>

80107deb <vector255>:
.globl vector255
vector255:
  pushl $0
80107deb:	6a 00                	push   $0x0
  pushl $255
80107ded:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107df2:	e9 ac f0 ff ff       	jmp    80106ea3 <alltraps>
80107df7:	66 90                	xchg   %ax,%ax
80107df9:	66 90                	xchg   %ax,%ax
80107dfb:	66 90                	xchg   %ax,%ax
80107dfd:	66 90                	xchg   %ax,%ax
80107dff:	90                   	nop

80107e00 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107e00:	55                   	push   %ebp
80107e01:	89 e5                	mov    %esp,%ebp
80107e03:	57                   	push   %edi
80107e04:	56                   	push   %esi
80107e05:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107e06:	89 d3                	mov    %edx,%ebx
{
80107e08:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80107e0a:	c1 eb 16             	shr    $0x16,%ebx
80107e0d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107e10:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107e13:	8b 06                	mov    (%esi),%eax
80107e15:	a8 01                	test   $0x1,%al
80107e17:	74 27                	je     80107e40 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e1e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107e24:	c1 ef 0a             	shr    $0xa,%edi
}
80107e27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107e2a:	89 fa                	mov    %edi,%edx
80107e2c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e32:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107e35:	5b                   	pop    %ebx
80107e36:	5e                   	pop    %esi
80107e37:	5f                   	pop    %edi
80107e38:	5d                   	pop    %ebp
80107e39:	c3                   	ret    
80107e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e40:	85 c9                	test   %ecx,%ecx
80107e42:	74 2c                	je     80107e70 <walkpgdir+0x70>
80107e44:	e8 e7 a5 ff ff       	call   80102430 <kalloc>
80107e49:	85 c0                	test   %eax,%eax
80107e4b:	89 c3                	mov    %eax,%ebx
80107e4d:	74 21                	je     80107e70 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80107e4f:	83 ec 04             	sub    $0x4,%esp
80107e52:	68 00 10 00 00       	push   $0x1000
80107e57:	6a 00                	push   $0x0
80107e59:	50                   	push   %eax
80107e5a:	e8 41 cf ff ff       	call   80104da0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107e5f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107e65:	83 c4 10             	add    $0x10,%esp
80107e68:	83 c8 07             	or     $0x7,%eax
80107e6b:	89 06                	mov    %eax,(%esi)
80107e6d:	eb b5                	jmp    80107e24 <walkpgdir+0x24>
80107e6f:	90                   	nop
}
80107e70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107e73:	31 c0                	xor    %eax,%eax
}
80107e75:	5b                   	pop    %ebx
80107e76:	5e                   	pop    %esi
80107e77:	5f                   	pop    %edi
80107e78:	5d                   	pop    %ebp
80107e79:	c3                   	ret    
80107e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e80 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107e80:	55                   	push   %ebp
80107e81:	89 e5                	mov    %esp,%ebp
80107e83:	57                   	push   %edi
80107e84:	56                   	push   %esi
80107e85:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107e86:	89 d3                	mov    %edx,%ebx
80107e88:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107e8e:	83 ec 1c             	sub    $0x1c,%esp
80107e91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107e94:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107e98:	8b 7d 08             	mov    0x8(%ebp),%edi
80107e9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ea0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107ea3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ea6:	29 df                	sub    %ebx,%edi
80107ea8:	83 c8 01             	or     $0x1,%eax
80107eab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107eae:	eb 15                	jmp    80107ec5 <mappages+0x45>
    if(*pte & PTE_P)
80107eb0:	f6 00 01             	testb  $0x1,(%eax)
80107eb3:	75 45                	jne    80107efa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107eb5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107eb8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107ebb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107ebd:	74 31                	je     80107ef0 <mappages+0x70>
      break;
    a += PGSIZE;
80107ebf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ec5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ec8:	b9 01 00 00 00       	mov    $0x1,%ecx
80107ecd:	89 da                	mov    %ebx,%edx
80107ecf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107ed2:	e8 29 ff ff ff       	call   80107e00 <walkpgdir>
80107ed7:	85 c0                	test   %eax,%eax
80107ed9:	75 d5                	jne    80107eb0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107edb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ede:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ee3:	5b                   	pop    %ebx
80107ee4:	5e                   	pop    %esi
80107ee5:	5f                   	pop    %edi
80107ee6:	5d                   	pop    %ebp
80107ee7:	c3                   	ret    
80107ee8:	90                   	nop
80107ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107ef3:	31 c0                	xor    %eax,%eax
}
80107ef5:	5b                   	pop    %ebx
80107ef6:	5e                   	pop    %esi
80107ef7:	5f                   	pop    %edi
80107ef8:	5d                   	pop    %ebp
80107ef9:	c3                   	ret    
      panic("remap");
80107efa:	83 ec 0c             	sub    $0xc,%esp
80107efd:	68 88 93 10 80       	push   $0x80109388
80107f02:	e8 89 84 ff ff       	call   80100390 <panic>
80107f07:	89 f6                	mov    %esi,%esi
80107f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f10 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f10:	55                   	push   %ebp
80107f11:	89 e5                	mov    %esp,%ebp
80107f13:	57                   	push   %edi
80107f14:	56                   	push   %esi
80107f15:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107f16:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f1c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80107f1e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f24:	83 ec 1c             	sub    $0x1c,%esp
80107f27:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f2a:	39 d3                	cmp    %edx,%ebx
80107f2c:	73 66                	jae    80107f94 <deallocuvm.part.0+0x84>
80107f2e:	89 d6                	mov    %edx,%esi
80107f30:	eb 3d                	jmp    80107f6f <deallocuvm.part.0+0x5f>
80107f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107f38:	8b 10                	mov    (%eax),%edx
80107f3a:	f6 c2 01             	test   $0x1,%dl
80107f3d:	74 26                	je     80107f65 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107f3f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107f45:	74 58                	je     80107f9f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107f47:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107f4a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107f50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107f53:	52                   	push   %edx
80107f54:	e8 27 a3 ff ff       	call   80102280 <kfree>
      *pte = 0;
80107f59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f5c:	83 c4 10             	add    $0x10,%esp
80107f5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107f65:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f6b:	39 f3                	cmp    %esi,%ebx
80107f6d:	73 25                	jae    80107f94 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107f6f:	31 c9                	xor    %ecx,%ecx
80107f71:	89 da                	mov    %ebx,%edx
80107f73:	89 f8                	mov    %edi,%eax
80107f75:	e8 86 fe ff ff       	call   80107e00 <walkpgdir>
    if(!pte)
80107f7a:	85 c0                	test   %eax,%eax
80107f7c:	75 ba                	jne    80107f38 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107f7e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107f84:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107f8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f90:	39 f3                	cmp    %esi,%ebx
80107f92:	72 db                	jb     80107f6f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80107f94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107f97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f9a:	5b                   	pop    %ebx
80107f9b:	5e                   	pop    %esi
80107f9c:	5f                   	pop    %edi
80107f9d:	5d                   	pop    %ebp
80107f9e:	c3                   	ret    
        panic("kfree");
80107f9f:	83 ec 0c             	sub    $0xc,%esp
80107fa2:	68 9a 89 10 80       	push   $0x8010899a
80107fa7:	e8 e4 83 ff ff       	call   80100390 <panic>
80107fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107fb0 <seginit>:
{
80107fb0:	55                   	push   %ebp
80107fb1:	89 e5                	mov    %esp,%ebp
80107fb3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107fb6:	e8 e5 b7 ff ff       	call   801037a0 <cpuid>
80107fbb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107fc1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107fc6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107fca:	c7 80 58 4a 11 80 ff 	movl   $0xffff,-0x7feeb5a8(%eax)
80107fd1:	ff 00 00 
80107fd4:	c7 80 5c 4a 11 80 00 	movl   $0xcf9a00,-0x7feeb5a4(%eax)
80107fdb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107fde:	c7 80 60 4a 11 80 ff 	movl   $0xffff,-0x7feeb5a0(%eax)
80107fe5:	ff 00 00 
80107fe8:	c7 80 64 4a 11 80 00 	movl   $0xcf9200,-0x7feeb59c(%eax)
80107fef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ff2:	c7 80 68 4a 11 80 ff 	movl   $0xffff,-0x7feeb598(%eax)
80107ff9:	ff 00 00 
80107ffc:	c7 80 6c 4a 11 80 00 	movl   $0xcffa00,-0x7feeb594(%eax)
80108003:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108006:	c7 80 70 4a 11 80 ff 	movl   $0xffff,-0x7feeb590(%eax)
8010800d:	ff 00 00 
80108010:	c7 80 74 4a 11 80 00 	movl   $0xcff200,-0x7feeb58c(%eax)
80108017:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010801a:	05 50 4a 11 80       	add    $0x80114a50,%eax
  pd[1] = (uint)p;
8010801f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108023:	c1 e8 10             	shr    $0x10,%eax
80108026:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010802a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010802d:	0f 01 10             	lgdtl  (%eax)
}
80108030:	c9                   	leave  
80108031:	c3                   	ret    
80108032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108040 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108040:	a1 64 88 1d 80       	mov    0x801d8864,%eax
{
80108045:	55                   	push   %ebp
80108046:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108048:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010804d:	0f 22 d8             	mov    %eax,%cr3
}
80108050:	5d                   	pop    %ebp
80108051:	c3                   	ret    
80108052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108060 <switchuvm>:
{
80108060:	55                   	push   %ebp
80108061:	89 e5                	mov    %esp,%ebp
80108063:	57                   	push   %edi
80108064:	56                   	push   %esi
80108065:	53                   	push   %ebx
80108066:	83 ec 1c             	sub    $0x1c,%esp
80108069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010806c:	85 db                	test   %ebx,%ebx
8010806e:	0f 84 cb 00 00 00    	je     8010813f <switchuvm+0xdf>
  if(p->kstack == 0)
80108074:	8b 43 08             	mov    0x8(%ebx),%eax
80108077:	85 c0                	test   %eax,%eax
80108079:	0f 84 da 00 00 00    	je     80108159 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010807f:	8b 43 04             	mov    0x4(%ebx),%eax
80108082:	85 c0                	test   %eax,%eax
80108084:	0f 84 c2 00 00 00    	je     8010814c <switchuvm+0xec>
  pushcli();
8010808a:	e8 31 cb ff ff       	call   80104bc0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010808f:	e8 8c b6 ff ff       	call   80103720 <mycpu>
80108094:	89 c6                	mov    %eax,%esi
80108096:	e8 85 b6 ff ff       	call   80103720 <mycpu>
8010809b:	89 c7                	mov    %eax,%edi
8010809d:	e8 7e b6 ff ff       	call   80103720 <mycpu>
801080a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801080a5:	83 c7 08             	add    $0x8,%edi
801080a8:	e8 73 b6 ff ff       	call   80103720 <mycpu>
801080ad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801080b0:	83 c0 08             	add    $0x8,%eax
801080b3:	ba 67 00 00 00       	mov    $0x67,%edx
801080b8:	c1 e8 18             	shr    $0x18,%eax
801080bb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801080c2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801080c9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801080cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801080d4:	83 c1 08             	add    $0x8,%ecx
801080d7:	c1 e9 10             	shr    $0x10,%ecx
801080da:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801080e0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801080e5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801080ec:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
801080f1:	e8 2a b6 ff ff       	call   80103720 <mycpu>
801080f6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801080fd:	e8 1e b6 ff ff       	call   80103720 <mycpu>
80108102:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108106:	8b 73 08             	mov    0x8(%ebx),%esi
80108109:	e8 12 b6 ff ff       	call   80103720 <mycpu>
8010810e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108114:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108117:	e8 04 b6 ff ff       	call   80103720 <mycpu>
8010811c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108120:	b8 28 00 00 00       	mov    $0x28,%eax
80108125:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108128:	8b 43 04             	mov    0x4(%ebx),%eax
8010812b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108130:	0f 22 d8             	mov    %eax,%cr3
}
80108133:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108136:	5b                   	pop    %ebx
80108137:	5e                   	pop    %esi
80108138:	5f                   	pop    %edi
80108139:	5d                   	pop    %ebp
  popcli();
8010813a:	e9 c1 ca ff ff       	jmp    80104c00 <popcli>
    panic("switchuvm: no process");
8010813f:	83 ec 0c             	sub    $0xc,%esp
80108142:	68 8e 93 10 80       	push   $0x8010938e
80108147:	e8 44 82 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010814c:	83 ec 0c             	sub    $0xc,%esp
8010814f:	68 b9 93 10 80       	push   $0x801093b9
80108154:	e8 37 82 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80108159:	83 ec 0c             	sub    $0xc,%esp
8010815c:	68 a4 93 10 80       	push   $0x801093a4
80108161:	e8 2a 82 ff ff       	call   80100390 <panic>
80108166:	8d 76 00             	lea    0x0(%esi),%esi
80108169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108170 <inituvm>:
{
80108170:	55                   	push   %ebp
80108171:	89 e5                	mov    %esp,%ebp
80108173:	57                   	push   %edi
80108174:	56                   	push   %esi
80108175:	53                   	push   %ebx
80108176:	83 ec 1c             	sub    $0x1c,%esp
80108179:	8b 75 10             	mov    0x10(%ebp),%esi
8010817c:	8b 45 08             	mov    0x8(%ebp),%eax
8010817f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80108182:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80108188:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010818b:	77 49                	ja     801081d6 <inituvm+0x66>
  mem = kalloc();
8010818d:	e8 9e a2 ff ff       	call   80102430 <kalloc>
  memset(mem, 0, PGSIZE);
80108192:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80108195:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108197:	68 00 10 00 00       	push   $0x1000
8010819c:	6a 00                	push   $0x0
8010819e:	50                   	push   %eax
8010819f:	e8 fc cb ff ff       	call   80104da0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801081a4:	58                   	pop    %eax
801081a5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801081ab:	b9 00 10 00 00       	mov    $0x1000,%ecx
801081b0:	5a                   	pop    %edx
801081b1:	6a 06                	push   $0x6
801081b3:	50                   	push   %eax
801081b4:	31 d2                	xor    %edx,%edx
801081b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801081b9:	e8 c2 fc ff ff       	call   80107e80 <mappages>
  memmove(mem, init, sz);
801081be:	89 75 10             	mov    %esi,0x10(%ebp)
801081c1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801081c4:	83 c4 10             	add    $0x10,%esp
801081c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801081ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081cd:	5b                   	pop    %ebx
801081ce:	5e                   	pop    %esi
801081cf:	5f                   	pop    %edi
801081d0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801081d1:	e9 7a cc ff ff       	jmp    80104e50 <memmove>
    panic("inituvm: more than a page");
801081d6:	83 ec 0c             	sub    $0xc,%esp
801081d9:	68 cd 93 10 80       	push   $0x801093cd
801081de:	e8 ad 81 ff ff       	call   80100390 <panic>
801081e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801081e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801081f0 <loaduvm>:
{
801081f0:	55                   	push   %ebp
801081f1:	89 e5                	mov    %esp,%ebp
801081f3:	57                   	push   %edi
801081f4:	56                   	push   %esi
801081f5:	53                   	push   %ebx
801081f6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
801081f9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108200:	0f 85 91 00 00 00    	jne    80108297 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80108206:	8b 75 18             	mov    0x18(%ebp),%esi
80108209:	31 db                	xor    %ebx,%ebx
8010820b:	85 f6                	test   %esi,%esi
8010820d:	75 1a                	jne    80108229 <loaduvm+0x39>
8010820f:	eb 6f                	jmp    80108280 <loaduvm+0x90>
80108211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108218:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010821e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108224:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108227:	76 57                	jbe    80108280 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108229:	8b 55 0c             	mov    0xc(%ebp),%edx
8010822c:	8b 45 08             	mov    0x8(%ebp),%eax
8010822f:	31 c9                	xor    %ecx,%ecx
80108231:	01 da                	add    %ebx,%edx
80108233:	e8 c8 fb ff ff       	call   80107e00 <walkpgdir>
80108238:	85 c0                	test   %eax,%eax
8010823a:	74 4e                	je     8010828a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010823c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010823e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80108241:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80108246:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010824b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108251:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108254:	01 d9                	add    %ebx,%ecx
80108256:	05 00 00 00 80       	add    $0x80000000,%eax
8010825b:	57                   	push   %edi
8010825c:	51                   	push   %ecx
8010825d:	50                   	push   %eax
8010825e:	ff 75 10             	pushl  0x10(%ebp)
80108261:	e8 5a 96 ff ff       	call   801018c0 <readi>
80108266:	83 c4 10             	add    $0x10,%esp
80108269:	39 f8                	cmp    %edi,%eax
8010826b:	74 ab                	je     80108218 <loaduvm+0x28>
}
8010826d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108275:	5b                   	pop    %ebx
80108276:	5e                   	pop    %esi
80108277:	5f                   	pop    %edi
80108278:	5d                   	pop    %ebp
80108279:	c3                   	ret    
8010827a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108280:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108283:	31 c0                	xor    %eax,%eax
}
80108285:	5b                   	pop    %ebx
80108286:	5e                   	pop    %esi
80108287:	5f                   	pop    %edi
80108288:	5d                   	pop    %ebp
80108289:	c3                   	ret    
      panic("loaduvm: address should exist");
8010828a:	83 ec 0c             	sub    $0xc,%esp
8010828d:	68 e7 93 10 80       	push   $0x801093e7
80108292:	e8 f9 80 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80108297:	83 ec 0c             	sub    $0xc,%esp
8010829a:	68 88 94 10 80       	push   $0x80109488
8010829f:	e8 ec 80 ff ff       	call   80100390 <panic>
801082a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801082aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801082b0 <allocuvm>:
{
801082b0:	55                   	push   %ebp
801082b1:	89 e5                	mov    %esp,%ebp
801082b3:	57                   	push   %edi
801082b4:	56                   	push   %esi
801082b5:	53                   	push   %ebx
801082b6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801082b9:	8b 7d 10             	mov    0x10(%ebp),%edi
801082bc:	85 ff                	test   %edi,%edi
801082be:	0f 88 8e 00 00 00    	js     80108352 <allocuvm+0xa2>
  if(newsz < oldsz)
801082c4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801082c7:	0f 82 93 00 00 00    	jb     80108360 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
801082cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801082d0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801082d6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801082dc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801082df:	0f 86 7e 00 00 00    	jbe    80108363 <allocuvm+0xb3>
801082e5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801082e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801082eb:	eb 42                	jmp    8010832f <allocuvm+0x7f>
801082ed:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801082f0:	83 ec 04             	sub    $0x4,%esp
801082f3:	68 00 10 00 00       	push   $0x1000
801082f8:	6a 00                	push   $0x0
801082fa:	50                   	push   %eax
801082fb:	e8 a0 ca ff ff       	call   80104da0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108300:	58                   	pop    %eax
80108301:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108307:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010830c:	5a                   	pop    %edx
8010830d:	6a 06                	push   $0x6
8010830f:	50                   	push   %eax
80108310:	89 da                	mov    %ebx,%edx
80108312:	89 f8                	mov    %edi,%eax
80108314:	e8 67 fb ff ff       	call   80107e80 <mappages>
80108319:	83 c4 10             	add    $0x10,%esp
8010831c:	85 c0                	test   %eax,%eax
8010831e:	78 50                	js     80108370 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80108320:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108326:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108329:	0f 86 81 00 00 00    	jbe    801083b0 <allocuvm+0x100>
    mem = kalloc();
8010832f:	e8 fc a0 ff ff       	call   80102430 <kalloc>
    if(mem == 0){
80108334:	85 c0                	test   %eax,%eax
    mem = kalloc();
80108336:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108338:	75 b6                	jne    801082f0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010833a:	83 ec 0c             	sub    $0xc,%esp
8010833d:	68 05 94 10 80       	push   $0x80109405
80108342:	e8 19 83 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80108347:	83 c4 10             	add    $0x10,%esp
8010834a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010834d:	39 45 10             	cmp    %eax,0x10(%ebp)
80108350:	77 6e                	ja     801083c0 <allocuvm+0x110>
}
80108352:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80108355:	31 ff                	xor    %edi,%edi
}
80108357:	89 f8                	mov    %edi,%eax
80108359:	5b                   	pop    %ebx
8010835a:	5e                   	pop    %esi
8010835b:	5f                   	pop    %edi
8010835c:	5d                   	pop    %ebp
8010835d:	c3                   	ret    
8010835e:	66 90                	xchg   %ax,%ax
    return oldsz;
80108360:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80108363:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108366:	89 f8                	mov    %edi,%eax
80108368:	5b                   	pop    %ebx
80108369:	5e                   	pop    %esi
8010836a:	5f                   	pop    %edi
8010836b:	5d                   	pop    %ebp
8010836c:	c3                   	ret    
8010836d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108370:	83 ec 0c             	sub    $0xc,%esp
80108373:	68 1d 94 10 80       	push   $0x8010941d
80108378:	e8 e3 82 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010837d:	83 c4 10             	add    $0x10,%esp
80108380:	8b 45 0c             	mov    0xc(%ebp),%eax
80108383:	39 45 10             	cmp    %eax,0x10(%ebp)
80108386:	76 0d                	jbe    80108395 <allocuvm+0xe5>
80108388:	89 c1                	mov    %eax,%ecx
8010838a:	8b 55 10             	mov    0x10(%ebp),%edx
8010838d:	8b 45 08             	mov    0x8(%ebp),%eax
80108390:	e8 7b fb ff ff       	call   80107f10 <deallocuvm.part.0>
      kfree(mem);
80108395:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108398:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010839a:	56                   	push   %esi
8010839b:	e8 e0 9e ff ff       	call   80102280 <kfree>
      return 0;
801083a0:	83 c4 10             	add    $0x10,%esp
}
801083a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083a6:	89 f8                	mov    %edi,%eax
801083a8:	5b                   	pop    %ebx
801083a9:	5e                   	pop    %esi
801083aa:	5f                   	pop    %edi
801083ab:	5d                   	pop    %ebp
801083ac:	c3                   	ret    
801083ad:	8d 76 00             	lea    0x0(%esi),%esi
801083b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801083b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083b6:	5b                   	pop    %ebx
801083b7:	89 f8                	mov    %edi,%eax
801083b9:	5e                   	pop    %esi
801083ba:	5f                   	pop    %edi
801083bb:	5d                   	pop    %ebp
801083bc:	c3                   	ret    
801083bd:	8d 76 00             	lea    0x0(%esi),%esi
801083c0:	89 c1                	mov    %eax,%ecx
801083c2:	8b 55 10             	mov    0x10(%ebp),%edx
801083c5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801083c8:	31 ff                	xor    %edi,%edi
801083ca:	e8 41 fb ff ff       	call   80107f10 <deallocuvm.part.0>
801083cf:	eb 92                	jmp    80108363 <allocuvm+0xb3>
801083d1:	eb 0d                	jmp    801083e0 <deallocuvm>
801083d3:	90                   	nop
801083d4:	90                   	nop
801083d5:	90                   	nop
801083d6:	90                   	nop
801083d7:	90                   	nop
801083d8:	90                   	nop
801083d9:	90                   	nop
801083da:	90                   	nop
801083db:	90                   	nop
801083dc:	90                   	nop
801083dd:	90                   	nop
801083de:	90                   	nop
801083df:	90                   	nop

801083e0 <deallocuvm>:
{
801083e0:	55                   	push   %ebp
801083e1:	89 e5                	mov    %esp,%ebp
801083e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801083e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801083e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801083ec:	39 d1                	cmp    %edx,%ecx
801083ee:	73 10                	jae    80108400 <deallocuvm+0x20>
}
801083f0:	5d                   	pop    %ebp
801083f1:	e9 1a fb ff ff       	jmp    80107f10 <deallocuvm.part.0>
801083f6:	8d 76 00             	lea    0x0(%esi),%esi
801083f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108400:	89 d0                	mov    %edx,%eax
80108402:	5d                   	pop    %ebp
80108403:	c3                   	ret    
80108404:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010840a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108410 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108410:	55                   	push   %ebp
80108411:	89 e5                	mov    %esp,%ebp
80108413:	57                   	push   %edi
80108414:	56                   	push   %esi
80108415:	53                   	push   %ebx
80108416:	83 ec 0c             	sub    $0xc,%esp
80108419:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010841c:	85 f6                	test   %esi,%esi
8010841e:	74 59                	je     80108479 <freevm+0x69>
80108420:	31 c9                	xor    %ecx,%ecx
80108422:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108427:	89 f0                	mov    %esi,%eax
80108429:	e8 e2 fa ff ff       	call   80107f10 <deallocuvm.part.0>
8010842e:	89 f3                	mov    %esi,%ebx
80108430:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108436:	eb 0f                	jmp    80108447 <freevm+0x37>
80108438:	90                   	nop
80108439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108440:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108443:	39 fb                	cmp    %edi,%ebx
80108445:	74 23                	je     8010846a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108447:	8b 03                	mov    (%ebx),%eax
80108449:	a8 01                	test   $0x1,%al
8010844b:	74 f3                	je     80108440 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010844d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108452:	83 ec 0c             	sub    $0xc,%esp
80108455:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108458:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010845d:	50                   	push   %eax
8010845e:	e8 1d 9e ff ff       	call   80102280 <kfree>
80108463:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108466:	39 fb                	cmp    %edi,%ebx
80108468:	75 dd                	jne    80108447 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010846a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010846d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108470:	5b                   	pop    %ebx
80108471:	5e                   	pop    %esi
80108472:	5f                   	pop    %edi
80108473:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108474:	e9 07 9e ff ff       	jmp    80102280 <kfree>
    panic("freevm: no pgdir");
80108479:	83 ec 0c             	sub    $0xc,%esp
8010847c:	68 39 94 10 80       	push   $0x80109439
80108481:	e8 0a 7f ff ff       	call   80100390 <panic>
80108486:	8d 76 00             	lea    0x0(%esi),%esi
80108489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108490 <setupkvm>:
{
80108490:	55                   	push   %ebp
80108491:	89 e5                	mov    %esp,%ebp
80108493:	56                   	push   %esi
80108494:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108495:	e8 96 9f ff ff       	call   80102430 <kalloc>
8010849a:	85 c0                	test   %eax,%eax
8010849c:	89 c6                	mov    %eax,%esi
8010849e:	74 42                	je     801084e2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801084a0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801084a3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801084a8:	68 00 10 00 00       	push   $0x1000
801084ad:	6a 00                	push   $0x0
801084af:	50                   	push   %eax
801084b0:	e8 eb c8 ff ff       	call   80104da0 <memset>
801084b5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801084b8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801084bb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801084be:	83 ec 08             	sub    $0x8,%esp
801084c1:	8b 13                	mov    (%ebx),%edx
801084c3:	ff 73 0c             	pushl  0xc(%ebx)
801084c6:	50                   	push   %eax
801084c7:	29 c1                	sub    %eax,%ecx
801084c9:	89 f0                	mov    %esi,%eax
801084cb:	e8 b0 f9 ff ff       	call   80107e80 <mappages>
801084d0:	83 c4 10             	add    $0x10,%esp
801084d3:	85 c0                	test   %eax,%eax
801084d5:	78 19                	js     801084f0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801084d7:	83 c3 10             	add    $0x10,%ebx
801084da:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801084e0:	75 d6                	jne    801084b8 <setupkvm+0x28>
}
801084e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801084e5:	89 f0                	mov    %esi,%eax
801084e7:	5b                   	pop    %ebx
801084e8:	5e                   	pop    %esi
801084e9:	5d                   	pop    %ebp
801084ea:	c3                   	ret    
801084eb:	90                   	nop
801084ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801084f0:	83 ec 0c             	sub    $0xc,%esp
801084f3:	56                   	push   %esi
      return 0;
801084f4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801084f6:	e8 15 ff ff ff       	call   80108410 <freevm>
      return 0;
801084fb:	83 c4 10             	add    $0x10,%esp
}
801084fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108501:	89 f0                	mov    %esi,%eax
80108503:	5b                   	pop    %ebx
80108504:	5e                   	pop    %esi
80108505:	5d                   	pop    %ebp
80108506:	c3                   	ret    
80108507:	89 f6                	mov    %esi,%esi
80108509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108510 <kvmalloc>:
{
80108510:	55                   	push   %ebp
80108511:	89 e5                	mov    %esp,%ebp
80108513:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108516:	e8 75 ff ff ff       	call   80108490 <setupkvm>
8010851b:	a3 64 88 1d 80       	mov    %eax,0x801d8864
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108520:	05 00 00 00 80       	add    $0x80000000,%eax
80108525:	0f 22 d8             	mov    %eax,%cr3
}
80108528:	c9                   	leave  
80108529:	c3                   	ret    
8010852a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108530 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108530:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108531:	31 c9                	xor    %ecx,%ecx
{
80108533:	89 e5                	mov    %esp,%ebp
80108535:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108538:	8b 55 0c             	mov    0xc(%ebp),%edx
8010853b:	8b 45 08             	mov    0x8(%ebp),%eax
8010853e:	e8 bd f8 ff ff       	call   80107e00 <walkpgdir>
  if(pte == 0)
80108543:	85 c0                	test   %eax,%eax
80108545:	74 05                	je     8010854c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108547:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010854a:	c9                   	leave  
8010854b:	c3                   	ret    
    panic("clearpteu");
8010854c:	83 ec 0c             	sub    $0xc,%esp
8010854f:	68 4a 94 10 80       	push   $0x8010944a
80108554:	e8 37 7e ff ff       	call   80100390 <panic>
80108559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108560 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108560:	55                   	push   %ebp
80108561:	89 e5                	mov    %esp,%ebp
80108563:	57                   	push   %edi
80108564:	56                   	push   %esi
80108565:	53                   	push   %ebx
80108566:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108569:	e8 22 ff ff ff       	call   80108490 <setupkvm>
8010856e:	85 c0                	test   %eax,%eax
80108570:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108573:	0f 84 9f 00 00 00    	je     80108618 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108579:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010857c:	85 c9                	test   %ecx,%ecx
8010857e:	0f 84 94 00 00 00    	je     80108618 <copyuvm+0xb8>
80108584:	31 ff                	xor    %edi,%edi
80108586:	eb 4a                	jmp    801085d2 <copyuvm+0x72>
80108588:	90                   	nop
80108589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108590:	83 ec 04             	sub    $0x4,%esp
80108593:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80108599:	68 00 10 00 00       	push   $0x1000
8010859e:	53                   	push   %ebx
8010859f:	50                   	push   %eax
801085a0:	e8 ab c8 ff ff       	call   80104e50 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801085a5:	58                   	pop    %eax
801085a6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801085ac:	b9 00 10 00 00       	mov    $0x1000,%ecx
801085b1:	5a                   	pop    %edx
801085b2:	ff 75 e4             	pushl  -0x1c(%ebp)
801085b5:	50                   	push   %eax
801085b6:	89 fa                	mov    %edi,%edx
801085b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085bb:	e8 c0 f8 ff ff       	call   80107e80 <mappages>
801085c0:	83 c4 10             	add    $0x10,%esp
801085c3:	85 c0                	test   %eax,%eax
801085c5:	78 61                	js     80108628 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801085c7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801085cd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801085d0:	76 46                	jbe    80108618 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801085d2:	8b 45 08             	mov    0x8(%ebp),%eax
801085d5:	31 c9                	xor    %ecx,%ecx
801085d7:	89 fa                	mov    %edi,%edx
801085d9:	e8 22 f8 ff ff       	call   80107e00 <walkpgdir>
801085de:	85 c0                	test   %eax,%eax
801085e0:	74 61                	je     80108643 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801085e2:	8b 00                	mov    (%eax),%eax
801085e4:	a8 01                	test   $0x1,%al
801085e6:	74 4e                	je     80108636 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801085e8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801085ea:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801085ef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801085f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801085f8:	e8 33 9e ff ff       	call   80102430 <kalloc>
801085fd:	85 c0                	test   %eax,%eax
801085ff:	89 c6                	mov    %eax,%esi
80108601:	75 8d                	jne    80108590 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80108603:	83 ec 0c             	sub    $0xc,%esp
80108606:	ff 75 e0             	pushl  -0x20(%ebp)
80108609:	e8 02 fe ff ff       	call   80108410 <freevm>
  return 0;
8010860e:	83 c4 10             	add    $0x10,%esp
80108611:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80108618:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010861b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010861e:	5b                   	pop    %ebx
8010861f:	5e                   	pop    %esi
80108620:	5f                   	pop    %edi
80108621:	5d                   	pop    %ebp
80108622:	c3                   	ret    
80108623:	90                   	nop
80108624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108628:	83 ec 0c             	sub    $0xc,%esp
8010862b:	56                   	push   %esi
8010862c:	e8 4f 9c ff ff       	call   80102280 <kfree>
      goto bad;
80108631:	83 c4 10             	add    $0x10,%esp
80108634:	eb cd                	jmp    80108603 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80108636:	83 ec 0c             	sub    $0xc,%esp
80108639:	68 6e 94 10 80       	push   $0x8010946e
8010863e:	e8 4d 7d ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80108643:	83 ec 0c             	sub    $0xc,%esp
80108646:	68 54 94 10 80       	push   $0x80109454
8010864b:	e8 40 7d ff ff       	call   80100390 <panic>

80108650 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108650:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108651:	31 c9                	xor    %ecx,%ecx
{
80108653:	89 e5                	mov    %esp,%ebp
80108655:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108658:	8b 55 0c             	mov    0xc(%ebp),%edx
8010865b:	8b 45 08             	mov    0x8(%ebp),%eax
8010865e:	e8 9d f7 ff ff       	call   80107e00 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108663:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108665:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80108666:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108668:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010866d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108670:	05 00 00 00 80       	add    $0x80000000,%eax
80108675:	83 fa 05             	cmp    $0x5,%edx
80108678:	ba 00 00 00 00       	mov    $0x0,%edx
8010867d:	0f 45 c2             	cmovne %edx,%eax
}
80108680:	c3                   	ret    
80108681:	eb 0d                	jmp    80108690 <copyout>
80108683:	90                   	nop
80108684:	90                   	nop
80108685:	90                   	nop
80108686:	90                   	nop
80108687:	90                   	nop
80108688:	90                   	nop
80108689:	90                   	nop
8010868a:	90                   	nop
8010868b:	90                   	nop
8010868c:	90                   	nop
8010868d:	90                   	nop
8010868e:	90                   	nop
8010868f:	90                   	nop

80108690 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108690:	55                   	push   %ebp
80108691:	89 e5                	mov    %esp,%ebp
80108693:	57                   	push   %edi
80108694:	56                   	push   %esi
80108695:	53                   	push   %ebx
80108696:	83 ec 1c             	sub    $0x1c,%esp
80108699:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010869c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010869f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801086a2:	85 db                	test   %ebx,%ebx
801086a4:	75 40                	jne    801086e6 <copyout+0x56>
801086a6:	eb 70                	jmp    80108718 <copyout+0x88>
801086a8:	90                   	nop
801086a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801086b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086b3:	89 f1                	mov    %esi,%ecx
801086b5:	29 d1                	sub    %edx,%ecx
801086b7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801086bd:	39 d9                	cmp    %ebx,%ecx
801086bf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801086c2:	29 f2                	sub    %esi,%edx
801086c4:	83 ec 04             	sub    $0x4,%esp
801086c7:	01 d0                	add    %edx,%eax
801086c9:	51                   	push   %ecx
801086ca:	57                   	push   %edi
801086cb:	50                   	push   %eax
801086cc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801086cf:	e8 7c c7 ff ff       	call   80104e50 <memmove>
    len -= n;
    buf += n;
801086d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801086d7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801086da:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801086e0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801086e2:	29 cb                	sub    %ecx,%ebx
801086e4:	74 32                	je     80108718 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801086e6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801086e8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801086eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801086ee:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801086f4:	56                   	push   %esi
801086f5:	ff 75 08             	pushl  0x8(%ebp)
801086f8:	e8 53 ff ff ff       	call   80108650 <uva2ka>
    if(pa0 == 0)
801086fd:	83 c4 10             	add    $0x10,%esp
80108700:	85 c0                	test   %eax,%eax
80108702:	75 ac                	jne    801086b0 <copyout+0x20>
  }
  return 0;
}
80108704:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108707:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010870c:	5b                   	pop    %ebx
8010870d:	5e                   	pop    %esi
8010870e:	5f                   	pop    %edi
8010870f:	5d                   	pop    %ebp
80108710:	c3                   	ret    
80108711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108718:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010871b:	31 c0                	xor    %eax,%eax
}
8010871d:	5b                   	pop    %ebx
8010871e:	5e                   	pop    %esi
8010871f:	5f                   	pop    %edi
80108720:	5d                   	pop    %ebp
80108721:	c3                   	ret    
