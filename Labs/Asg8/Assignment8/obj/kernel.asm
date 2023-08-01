
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	c020d2b7          	lui	t0,0xc020d
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
ffffffffc020001c:	18029073          	csrw	satp,t0
ffffffffc0200020:	12000073          	sfence.vma
ffffffffc0200024:	c020d137          	lui	sp,0xc020d
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:
ffffffffc0200032:	0000e517          	auipc	a0,0xe
ffffffffc0200036:	06250513          	addi	a0,a0,98 # ffffffffc020e094 <edata>
ffffffffc020003a:	00019617          	auipc	a2,0x19
ffffffffc020003e:	67660613          	addi	a2,a2,1654 # ffffffffc02196b0 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	40f070ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	03658593          	addi	a1,a1,54 # ffffffffc0208088 <etext+0x2>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	04650513          	addi	a0,a0,70 # ffffffffc02080a0 <etext+0x1a>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	5f5000ef          	jal	ra,ffffffffc0200e5a <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	623010ef          	jal	ra,ffffffffc0201e94 <vmm_init>
ffffffffc0200076:	259040ef          	jal	ra,ffffffffc0204ace <sched_init>
ffffffffc020007a:	047040ef          	jal	ra,ffffffffc02048c0 <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	350020ef          	jal	ra,ffffffffc02023d2 <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	169040ef          	jal	ra,ffffffffc02049f6 <cpu_idle>

ffffffffc0200092 <cputch>:
ffffffffc0200092:	1141                	addi	sp,sp,-16
ffffffffc0200094:	e022                	sd	s0,0(sp)
ffffffffc0200096:	e406                	sd	ra,8(sp)
ffffffffc0200098:	842e                	mv	s0,a1
ffffffffc020009a:	526000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020009e:	401c                	lw	a5,0(s0)
ffffffffc02000a0:	60a2                	ld	ra,8(sp)
ffffffffc02000a2:	2785                	addiw	a5,a5,1
ffffffffc02000a4:	c01c                	sw	a5,0(s0)
ffffffffc02000a6:	6402                	ld	s0,0(sp)
ffffffffc02000a8:	0141                	addi	sp,sp,16
ffffffffc02000aa:	8082                	ret

ffffffffc02000ac <vcprintf>:
ffffffffc02000ac:	1101                	addi	sp,sp,-32
ffffffffc02000ae:	862a                	mv	a2,a0
ffffffffc02000b0:	86ae                	mv	a3,a1
ffffffffc02000b2:	00000517          	auipc	a0,0x0
ffffffffc02000b6:	fe050513          	addi	a0,a0,-32 # ffffffffc0200092 <cputch>
ffffffffc02000ba:	006c                	addi	a1,sp,12
ffffffffc02000bc:	ec06                	sd	ra,24(sp)
ffffffffc02000be:	c602                	sw	zero,12(sp)
ffffffffc02000c0:	42f070ef          	jal	ra,ffffffffc0207cee <vprintfmt>
ffffffffc02000c4:	60e2                	ld	ra,24(sp)
ffffffffc02000c6:	4532                	lw	a0,12(sp)
ffffffffc02000c8:	6105                	addi	sp,sp,32
ffffffffc02000ca:	8082                	ret

ffffffffc02000cc <cprintf>:
ffffffffc02000cc:	711d                	addi	sp,sp,-96
ffffffffc02000ce:	02810313          	addi	t1,sp,40 # ffffffffc020d028 <boot_page_table_sv39+0x28>
ffffffffc02000d2:	8e2a                	mv	t3,a0
ffffffffc02000d4:	f42e                	sd	a1,40(sp)
ffffffffc02000d6:	f832                	sd	a2,48(sp)
ffffffffc02000d8:	fc36                	sd	a3,56(sp)
ffffffffc02000da:	00000517          	auipc	a0,0x0
ffffffffc02000de:	fb850513          	addi	a0,a0,-72 # ffffffffc0200092 <cputch>
ffffffffc02000e2:	004c                	addi	a1,sp,4
ffffffffc02000e4:	869a                	mv	a3,t1
ffffffffc02000e6:	8672                	mv	a2,t3
ffffffffc02000e8:	ec06                	sd	ra,24(sp)
ffffffffc02000ea:	e0ba                	sd	a4,64(sp)
ffffffffc02000ec:	e4be                	sd	a5,72(sp)
ffffffffc02000ee:	e8c2                	sd	a6,80(sp)
ffffffffc02000f0:	ecc6                	sd	a7,88(sp)
ffffffffc02000f2:	e41a                	sd	t1,8(sp)
ffffffffc02000f4:	c202                	sw	zero,4(sp)
ffffffffc02000f6:	3f9070ef          	jal	ra,ffffffffc0207cee <vprintfmt>
ffffffffc02000fa:	60e2                	ld	ra,24(sp)
ffffffffc02000fc:	4512                	lw	a0,4(sp)
ffffffffc02000fe:	6125                	addi	sp,sp,96
ffffffffc0200100:	8082                	ret

ffffffffc0200102 <cputchar>:
ffffffffc0200102:	a97d                	j	ffffffffc02005c0 <cons_putc>

ffffffffc0200104 <cputs>:
ffffffffc0200104:	1101                	addi	sp,sp,-32
ffffffffc0200106:	e822                	sd	s0,16(sp)
ffffffffc0200108:	ec06                	sd	ra,24(sp)
ffffffffc020010a:	e426                	sd	s1,8(sp)
ffffffffc020010c:	842a                	mv	s0,a0
ffffffffc020010e:	00054503          	lbu	a0,0(a0)
ffffffffc0200112:	c51d                	beqz	a0,ffffffffc0200140 <cputs+0x3c>
ffffffffc0200114:	0405                	addi	s0,s0,1
ffffffffc0200116:	4485                	li	s1,1
ffffffffc0200118:	9c81                	subw	s1,s1,s0
ffffffffc020011a:	4a6000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc020011e:	00044503          	lbu	a0,0(s0)
ffffffffc0200122:	008487bb          	addw	a5,s1,s0
ffffffffc0200126:	0405                	addi	s0,s0,1
ffffffffc0200128:	f96d                	bnez	a0,ffffffffc020011a <cputs+0x16>
ffffffffc020012a:	0017841b          	addiw	s0,a5,1
ffffffffc020012e:	4529                	li	a0,10
ffffffffc0200130:	490000ef          	jal	ra,ffffffffc02005c0 <cons_putc>
ffffffffc0200134:	60e2                	ld	ra,24(sp)
ffffffffc0200136:	8522                	mv	a0,s0
ffffffffc0200138:	6442                	ld	s0,16(sp)
ffffffffc020013a:	64a2                	ld	s1,8(sp)
ffffffffc020013c:	6105                	addi	sp,sp,32
ffffffffc020013e:	8082                	ret
ffffffffc0200140:	4405                	li	s0,1
ffffffffc0200142:	b7f5                	j	ffffffffc020012e <cputs+0x2a>

ffffffffc0200144 <getchar>:
ffffffffc0200144:	1141                	addi	sp,sp,-16
ffffffffc0200146:	e406                	sd	ra,8(sp)
ffffffffc0200148:	4ac000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020014c:	dd75                	beqz	a0,ffffffffc0200148 <getchar+0x4>
ffffffffc020014e:	60a2                	ld	ra,8(sp)
ffffffffc0200150:	0141                	addi	sp,sp,16
ffffffffc0200152:	8082                	ret

ffffffffc0200154 <readline>:
ffffffffc0200154:	715d                	addi	sp,sp,-80
ffffffffc0200156:	e486                	sd	ra,72(sp)
ffffffffc0200158:	e0a6                	sd	s1,64(sp)
ffffffffc020015a:	fc4a                	sd	s2,56(sp)
ffffffffc020015c:	f84e                	sd	s3,48(sp)
ffffffffc020015e:	f452                	sd	s4,40(sp)
ffffffffc0200160:	f056                	sd	s5,32(sp)
ffffffffc0200162:	ec5a                	sd	s6,24(sp)
ffffffffc0200164:	e85e                	sd	s7,16(sp)
ffffffffc0200166:	c901                	beqz	a0,ffffffffc0200176 <readline+0x22>
ffffffffc0200168:	85aa                	mv	a1,a0
ffffffffc020016a:	00008517          	auipc	a0,0x8
ffffffffc020016e:	f3e50513          	addi	a0,a0,-194 # ffffffffc02080a8 <etext+0x22>
ffffffffc0200172:	f5bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200176:	4481                	li	s1,0
ffffffffc0200178:	497d                	li	s2,31
ffffffffc020017a:	49a1                	li	s3,8
ffffffffc020017c:	4aa9                	li	s5,10
ffffffffc020017e:	4b35                	li	s6,13
ffffffffc0200180:	0000eb97          	auipc	s7,0xe
ffffffffc0200184:	f18b8b93          	addi	s7,s7,-232 # ffffffffc020e098 <buf>
ffffffffc0200188:	3fe00a13          	li	s4,1022
ffffffffc020018c:	fb9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc0200190:	00054a63          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc0200194:	00a95a63          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc0200198:	029a5263          	bge	s4,s1,ffffffffc02001bc <readline+0x68>
ffffffffc020019c:	fa9ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001a0:	fe055ae3          	bgez	a0,ffffffffc0200194 <readline+0x40>
ffffffffc02001a4:	4501                	li	a0,0
ffffffffc02001a6:	a091                	j	ffffffffc02001ea <readline+0x96>
ffffffffc02001a8:	03351463          	bne	a0,s3,ffffffffc02001d0 <readline+0x7c>
ffffffffc02001ac:	e8a9                	bnez	s1,ffffffffc02001fe <readline+0xaa>
ffffffffc02001ae:	f97ff0ef          	jal	ra,ffffffffc0200144 <getchar>
ffffffffc02001b2:	fe0549e3          	bltz	a0,ffffffffc02001a4 <readline+0x50>
ffffffffc02001b6:	fea959e3          	bge	s2,a0,ffffffffc02001a8 <readline+0x54>
ffffffffc02001ba:	4481                	li	s1,0
ffffffffc02001bc:	e42a                	sd	a0,8(sp)
ffffffffc02001be:	f45ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001c2:	6522                	ld	a0,8(sp)
ffffffffc02001c4:	009b87b3          	add	a5,s7,s1
ffffffffc02001c8:	2485                	addiw	s1,s1,1
ffffffffc02001ca:	00a78023          	sb	a0,0(a5)
ffffffffc02001ce:	bf7d                	j	ffffffffc020018c <readline+0x38>
ffffffffc02001d0:	01550463          	beq	a0,s5,ffffffffc02001d8 <readline+0x84>
ffffffffc02001d4:	fb651ce3          	bne	a0,s6,ffffffffc020018c <readline+0x38>
ffffffffc02001d8:	f2bff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02001dc:	0000e517          	auipc	a0,0xe
ffffffffc02001e0:	ebc50513          	addi	a0,a0,-324 # ffffffffc020e098 <buf>
ffffffffc02001e4:	94aa                	add	s1,s1,a0
ffffffffc02001e6:	00048023          	sb	zero,0(s1)
ffffffffc02001ea:	60a6                	ld	ra,72(sp)
ffffffffc02001ec:	6486                	ld	s1,64(sp)
ffffffffc02001ee:	7962                	ld	s2,56(sp)
ffffffffc02001f0:	79c2                	ld	s3,48(sp)
ffffffffc02001f2:	7a22                	ld	s4,40(sp)
ffffffffc02001f4:	7a82                	ld	s5,32(sp)
ffffffffc02001f6:	6b62                	ld	s6,24(sp)
ffffffffc02001f8:	6bc2                	ld	s7,16(sp)
ffffffffc02001fa:	6161                	addi	sp,sp,80
ffffffffc02001fc:	8082                	ret
ffffffffc02001fe:	4521                	li	a0,8
ffffffffc0200200:	f03ff0ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0200204:	34fd                	addiw	s1,s1,-1
ffffffffc0200206:	b759                	j	ffffffffc020018c <readline+0x38>

ffffffffc0200208 <__panic>:
ffffffffc0200208:	00019317          	auipc	t1,0x19
ffffffffc020020c:	2c030313          	addi	t1,t1,704 # ffffffffc02194c8 <is_panic>
ffffffffc0200210:	00033e03          	ld	t3,0(t1)
ffffffffc0200214:	715d                	addi	sp,sp,-80
ffffffffc0200216:	ec06                	sd	ra,24(sp)
ffffffffc0200218:	e822                	sd	s0,16(sp)
ffffffffc020021a:	f436                	sd	a3,40(sp)
ffffffffc020021c:	f83a                	sd	a4,48(sp)
ffffffffc020021e:	fc3e                	sd	a5,56(sp)
ffffffffc0200220:	e0c2                	sd	a6,64(sp)
ffffffffc0200222:	e4c6                	sd	a7,72(sp)
ffffffffc0200224:	020e1a63          	bnez	t3,ffffffffc0200258 <__panic+0x50>
ffffffffc0200228:	4785                	li	a5,1
ffffffffc020022a:	00f33023          	sd	a5,0(t1)
ffffffffc020022e:	8432                	mv	s0,a2
ffffffffc0200230:	103c                	addi	a5,sp,40
ffffffffc0200232:	862e                	mv	a2,a1
ffffffffc0200234:	85aa                	mv	a1,a0
ffffffffc0200236:	00008517          	auipc	a0,0x8
ffffffffc020023a:	e7a50513          	addi	a0,a0,-390 # ffffffffc02080b0 <etext+0x2a>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	0000a517          	auipc	a0,0xa
ffffffffc0200250:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0209b38 <default_pmm_manager+0x6c0>
ffffffffc0200254:	e79ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200258:	4501                	li	a0,0
ffffffffc020025a:	4581                	li	a1,0
ffffffffc020025c:	4601                	li	a2,0
ffffffffc020025e:	48a1                	li	a7,8
ffffffffc0200260:	00000073          	ecall
ffffffffc0200264:	3d4000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200268:	4501                	li	a0,0
ffffffffc020026a:	174000ef          	jal	ra,ffffffffc02003de <kmonitor>
ffffffffc020026e:	bfed                	j	ffffffffc0200268 <__panic+0x60>

ffffffffc0200270 <__warn>:
ffffffffc0200270:	715d                	addi	sp,sp,-80
ffffffffc0200272:	832e                	mv	t1,a1
ffffffffc0200274:	e822                	sd	s0,16(sp)
ffffffffc0200276:	85aa                	mv	a1,a0
ffffffffc0200278:	8432                	mv	s0,a2
ffffffffc020027a:	fc3e                	sd	a5,56(sp)
ffffffffc020027c:	861a                	mv	a2,t1
ffffffffc020027e:	103c                	addi	a5,sp,40
ffffffffc0200280:	00008517          	auipc	a0,0x8
ffffffffc0200284:	e5050513          	addi	a0,a0,-432 # ffffffffc02080d0 <etext+0x4a>
ffffffffc0200288:	ec06                	sd	ra,24(sp)
ffffffffc020028a:	f436                	sd	a3,40(sp)
ffffffffc020028c:	f83a                	sd	a4,48(sp)
ffffffffc020028e:	e0c2                	sd	a6,64(sp)
ffffffffc0200290:	e4c6                	sd	a7,72(sp)
ffffffffc0200292:	e43e                	sd	a5,8(sp)
ffffffffc0200294:	e39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200298:	65a2                	ld	a1,8(sp)
ffffffffc020029a:	8522                	mv	a0,s0
ffffffffc020029c:	e11ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc02002a0:	0000a517          	auipc	a0,0xa
ffffffffc02002a4:	89850513          	addi	a0,a0,-1896 # ffffffffc0209b38 <default_pmm_manager+0x6c0>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	e3a50513          	addi	a0,a0,-454 # ffffffffc02080f0 <etext+0x6a>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	e4450513          	addi	a0,a0,-444 # ffffffffc0208110 <etext+0x8a>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	dae58593          	addi	a1,a1,-594 # ffffffffc0208086 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	e5050513          	addi	a0,a0,-432 # ffffffffc0208130 <etext+0xaa>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da858593          	addi	a1,a1,-600 # ffffffffc020e094 <edata>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	e5c50513          	addi	a0,a0,-420 # ffffffffc0208150 <etext+0xca>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	3b058593          	addi	a1,a1,944 # ffffffffc02196b0 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	e6850513          	addi	a0,a0,-408 # ffffffffc0208170 <etext+0xea>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	00019597          	auipc	a1,0x19
ffffffffc0200318:	79b58593          	addi	a1,a1,1947 # ffffffffc0219aaf <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	e5a50513          	addi	a0,a0,-422 # ffffffffc0208190 <etext+0x10a>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	e7c60613          	addi	a2,a2,-388 # ffffffffc02081c0 <etext+0x13a>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	e8850513          	addi	a0,a0,-376 # ffffffffc02081d8 <etext+0x152>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	e9060613          	addi	a2,a2,-368 # ffffffffc02081f0 <etext+0x16a>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	ea858593          	addi	a1,a1,-344 # ffffffffc0208210 <etext+0x18a>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	ea850513          	addi	a0,a0,-344 # ffffffffc0208218 <etext+0x192>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	eaa60613          	addi	a2,a2,-342 # ffffffffc0208228 <etext+0x1a2>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	eca58593          	addi	a1,a1,-310 # ffffffffc0208250 <etext+0x1ca>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	e8a50513          	addi	a0,a0,-374 # ffffffffc0208218 <etext+0x192>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	ec660613          	addi	a2,a2,-314 # ffffffffc0208260 <etext+0x1da>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	ede58593          	addi	a1,a1,-290 # ffffffffc0208280 <etext+0x1fa>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	e6e50513          	addi	a0,a0,-402 # ffffffffc0208218 <etext+0x192>
ffffffffc02003b2:	d1bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02003b6:	60a2                	ld	ra,8(sp)
ffffffffc02003b8:	4501                	li	a0,0
ffffffffc02003ba:	0141                	addi	sp,sp,16
ffffffffc02003bc:	8082                	ret

ffffffffc02003be <mon_kerninfo>:
ffffffffc02003be:	1141                	addi	sp,sp,-16
ffffffffc02003c0:	e406                	sd	ra,8(sp)
ffffffffc02003c2:	ef3ff0ef          	jal	ra,ffffffffc02002b4 <print_kerninfo>
ffffffffc02003c6:	60a2                	ld	ra,8(sp)
ffffffffc02003c8:	4501                	li	a0,0
ffffffffc02003ca:	0141                	addi	sp,sp,16
ffffffffc02003cc:	8082                	ret

ffffffffc02003ce <mon_backtrace>:
ffffffffc02003ce:	1141                	addi	sp,sp,-16
ffffffffc02003d0:	e406                	sd	ra,8(sp)
ffffffffc02003d2:	f71ff0ef          	jal	ra,ffffffffc0200342 <print_stackframe>
ffffffffc02003d6:	60a2                	ld	ra,8(sp)
ffffffffc02003d8:	4501                	li	a0,0
ffffffffc02003da:	0141                	addi	sp,sp,16
ffffffffc02003dc:	8082                	ret

ffffffffc02003de <kmonitor>:
ffffffffc02003de:	7115                	addi	sp,sp,-224
ffffffffc02003e0:	e962                	sd	s8,144(sp)
ffffffffc02003e2:	8c2a                	mv	s8,a0
ffffffffc02003e4:	00008517          	auipc	a0,0x8
ffffffffc02003e8:	eac50513          	addi	a0,a0,-340 # ffffffffc0208290 <etext+0x20a>
ffffffffc02003ec:	ed86                	sd	ra,216(sp)
ffffffffc02003ee:	e9a2                	sd	s0,208(sp)
ffffffffc02003f0:	e5a6                	sd	s1,200(sp)
ffffffffc02003f2:	e1ca                	sd	s2,192(sp)
ffffffffc02003f4:	fd4e                	sd	s3,184(sp)
ffffffffc02003f6:	f952                	sd	s4,176(sp)
ffffffffc02003f8:	f556                	sd	s5,168(sp)
ffffffffc02003fa:	f15a                	sd	s6,160(sp)
ffffffffc02003fc:	ed5e                	sd	s7,152(sp)
ffffffffc02003fe:	e566                	sd	s9,136(sp)
ffffffffc0200400:	e16a                	sd	s10,128(sp)
ffffffffc0200402:	ccbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200406:	00008517          	auipc	a0,0x8
ffffffffc020040a:	eb250513          	addi	a0,a0,-334 # ffffffffc02082b8 <etext+0x232>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	f0cc8c93          	addi	s9,s9,-244 # ffffffffc0208328 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	ebc98993          	addi	s3,s3,-324 # ffffffffc02082e0 <etext+0x25a>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	ebc90913          	addi	s2,s2,-324 # ffffffffc02082e8 <etext+0x262>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	ebab0b13          	addi	s6,s6,-326 # ffffffffc02082f0 <etext+0x26a>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	dd2a8a93          	addi	s5,s5,-558 # ffffffffc0208210 <etext+0x18a>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	7e6070ef          	jal	ra,ffffffffc0207c42 <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	eb6d0d13          	addi	s10,s10,-330 # ffffffffc0208328 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	7a4070ef          	jal	ra,ffffffffc0207c24 <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	790070ef          	jal	ra,ffffffffc0207c24 <strcmp>
ffffffffc0200498:	f57d                	bnez	a0,ffffffffc0200486 <kmonitor+0xa8>
ffffffffc020049a:	00141793          	slli	a5,s0,0x1
ffffffffc020049e:	97a2                	add	a5,a5,s0
ffffffffc02004a0:	078e                	slli	a5,a5,0x3
ffffffffc02004a2:	97e6                	add	a5,a5,s9
ffffffffc02004a4:	6b9c                	ld	a5,16(a5)
ffffffffc02004a6:	8662                	mv	a2,s8
ffffffffc02004a8:	002c                	addi	a1,sp,8
ffffffffc02004aa:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004ae:	9782                	jalr	a5
ffffffffc02004b0:	f8055ce3          	bgez	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc02004b4:	60ee                	ld	ra,216(sp)
ffffffffc02004b6:	644e                	ld	s0,208(sp)
ffffffffc02004b8:	64ae                	ld	s1,200(sp)
ffffffffc02004ba:	690e                	ld	s2,192(sp)
ffffffffc02004bc:	79ea                	ld	s3,184(sp)
ffffffffc02004be:	7a4a                	ld	s4,176(sp)
ffffffffc02004c0:	7aaa                	ld	s5,168(sp)
ffffffffc02004c2:	7b0a                	ld	s6,160(sp)
ffffffffc02004c4:	6bea                	ld	s7,152(sp)
ffffffffc02004c6:	6c4a                	ld	s8,144(sp)
ffffffffc02004c8:	6caa                	ld	s9,136(sp)
ffffffffc02004ca:	6d0a                	ld	s10,128(sp)
ffffffffc02004cc:	612d                	addi	sp,sp,224
ffffffffc02004ce:	8082                	ret
ffffffffc02004d0:	00044783          	lbu	a5,0(s0)
ffffffffc02004d4:	dfc9                	beqz	a5,ffffffffc020046e <kmonitor+0x90>
ffffffffc02004d6:	03448863          	beq	s1,s4,ffffffffc0200506 <kmonitor+0x128>
ffffffffc02004da:	00349793          	slli	a5,s1,0x3
ffffffffc02004de:	0118                	addi	a4,sp,128
ffffffffc02004e0:	97ba                	add	a5,a5,a4
ffffffffc02004e2:	f887b023          	sd	s0,-128(a5)
ffffffffc02004e6:	00044583          	lbu	a1,0(s0)
ffffffffc02004ea:	2485                	addiw	s1,s1,1
ffffffffc02004ec:	e591                	bnez	a1,ffffffffc02004f8 <kmonitor+0x11a>
ffffffffc02004ee:	b749                	j	ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f0:	00144583          	lbu	a1,1(s0)
ffffffffc02004f4:	0405                	addi	s0,s0,1
ffffffffc02004f6:	ddad                	beqz	a1,ffffffffc0200470 <kmonitor+0x92>
ffffffffc02004f8:	854a                	mv	a0,s2
ffffffffc02004fa:	748070ef          	jal	ra,ffffffffc0207c42 <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	dfe50513          	addi	a0,a0,-514 # ffffffffc0208310 <etext+0x28a>
ffffffffc020051a:	bb3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020051e:	b72d                	j	ffffffffc0200448 <kmonitor+0x6a>

ffffffffc0200520 <ide_init>:
ffffffffc0200520:	8082                	ret

ffffffffc0200522 <ide_device_valid>:
ffffffffc0200522:	00253513          	sltiu	a0,a0,2
ffffffffc0200526:	8082                	ret

ffffffffc0200528 <ide_device_size>:
ffffffffc0200528:	03800513          	li	a0,56
ffffffffc020052c:	8082                	ret

ffffffffc020052e <ide_read_secs>:
ffffffffc020052e:	0000e797          	auipc	a5,0xe
ffffffffc0200532:	f6a78793          	addi	a5,a5,-150 # ffffffffc020e498 <ide>
ffffffffc0200536:	0095959b          	slliw	a1,a1,0x9
ffffffffc020053a:	1141                	addi	sp,sp,-16
ffffffffc020053c:	8532                	mv	a0,a2
ffffffffc020053e:	95be                	add	a1,a1,a5
ffffffffc0200540:	00969613          	slli	a2,a3,0x9
ffffffffc0200544:	e406                	sd	ra,8(sp)
ffffffffc0200546:	724070ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc020054a:	60a2                	ld	ra,8(sp)
ffffffffc020054c:	4501                	li	a0,0
ffffffffc020054e:	0141                	addi	sp,sp,16
ffffffffc0200550:	8082                	ret

ffffffffc0200552 <ide_write_secs>:
ffffffffc0200552:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200556:	0000e517          	auipc	a0,0xe
ffffffffc020055a:	f4250513          	addi	a0,a0,-190 # ffffffffc020e498 <ide>
ffffffffc020055e:	1141                	addi	sp,sp,-16
ffffffffc0200560:	85b2                	mv	a1,a2
ffffffffc0200562:	953e                	add	a0,a0,a5
ffffffffc0200564:	00969613          	slli	a2,a3,0x9
ffffffffc0200568:	e406                	sd	ra,8(sp)
ffffffffc020056a:	700070ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc020056e:	60a2                	ld	ra,8(sp)
ffffffffc0200570:	4501                	li	a0,0
ffffffffc0200572:	0141                	addi	sp,sp,16
ffffffffc0200574:	8082                	ret

ffffffffc0200576 <clock_init>:
ffffffffc0200576:	02000793          	li	a5,32
ffffffffc020057a:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc020057e:	c0102573          	rdtime	a0
ffffffffc0200582:	67e1                	lui	a5,0x18
ffffffffc0200584:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200588:	953e                	add	a0,a0,a5
ffffffffc020058a:	4581                	li	a1,0
ffffffffc020058c:	4601                	li	a2,0
ffffffffc020058e:	4881                	li	a7,0
ffffffffc0200590:	00000073          	ecall
ffffffffc0200594:	00008517          	auipc	a0,0x8
ffffffffc0200598:	ddc50513          	addi	a0,a0,-548 # ffffffffc0208370 <commands+0x48>
ffffffffc020059c:	00019797          	auipc	a5,0x19
ffffffffc02005a0:	f807ba23          	sd	zero,-108(a5) # ffffffffc0219530 <ticks>
ffffffffc02005a4:	b625                	j	ffffffffc02000cc <cprintf>

ffffffffc02005a6 <clock_set_next_event>:
ffffffffc02005a6:	c0102573          	rdtime	a0
ffffffffc02005aa:	67e1                	lui	a5,0x18
ffffffffc02005ac:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc02005b0:	953e                	add	a0,a0,a5
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4881                	li	a7,0
ffffffffc02005b8:	00000073          	ecall
ffffffffc02005bc:	8082                	ret

ffffffffc02005be <cons_init>:
ffffffffc02005be:	8082                	ret

ffffffffc02005c0 <cons_putc>:
ffffffffc02005c0:	100027f3          	csrr	a5,sstatus
ffffffffc02005c4:	8b89                	andi	a5,a5,2
ffffffffc02005c6:	0ff57513          	andi	a0,a0,255
ffffffffc02005ca:	e799                	bnez	a5,ffffffffc02005d8 <cons_putc+0x18>
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4885                	li	a7,1
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	8082                	ret
ffffffffc02005d8:	1101                	addi	sp,sp,-32
ffffffffc02005da:	ec06                	sd	ra,24(sp)
ffffffffc02005dc:	e42a                	sd	a0,8(sp)
ffffffffc02005de:	05a000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02005e2:	6522                	ld	a0,8(sp)
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4885                	li	a7,1
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	60e2                	ld	ra,24(sp)
ffffffffc02005f0:	6105                	addi	sp,sp,32
ffffffffc02005f2:	a081                	j	ffffffffc0200632 <intr_enable>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	100027f3          	csrr	a5,sstatus
ffffffffc02005f8:	8b89                	andi	a5,a5,2
ffffffffc02005fa:	eb89                	bnez	a5,ffffffffc020060c <cons_getc+0x18>
ffffffffc02005fc:	4501                	li	a0,0
ffffffffc02005fe:	4581                	li	a1,0
ffffffffc0200600:	4601                	li	a2,0
ffffffffc0200602:	4889                	li	a7,2
ffffffffc0200604:	00000073          	ecall
ffffffffc0200608:	2501                	sext.w	a0,a0
ffffffffc020060a:	8082                	ret
ffffffffc020060c:	1101                	addi	sp,sp,-32
ffffffffc020060e:	ec06                	sd	ra,24(sp)
ffffffffc0200610:	028000ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200614:	4501                	li	a0,0
ffffffffc0200616:	4581                	li	a1,0
ffffffffc0200618:	4601                	li	a2,0
ffffffffc020061a:	4889                	li	a7,2
ffffffffc020061c:	00000073          	ecall
ffffffffc0200620:	2501                	sext.w	a0,a0
ffffffffc0200622:	e42a                	sd	a0,8(sp)
ffffffffc0200624:	00e000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200628:	60e2                	ld	ra,24(sp)
ffffffffc020062a:	6522                	ld	a0,8(sp)
ffffffffc020062c:	6105                	addi	sp,sp,32
ffffffffc020062e:	8082                	ret

ffffffffc0200630 <pic_init>:
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_enable>:
ffffffffc0200632:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <intr_disable>:
ffffffffc0200638:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020063c:	8082                	ret

ffffffffc020063e <idt_init>:
ffffffffc020063e:	14005073          	csrwi	sscratch,0
ffffffffc0200642:	00000797          	auipc	a5,0x0
ffffffffc0200646:	61e78793          	addi	a5,a5,1566 # ffffffffc0200c60 <__alltraps>
ffffffffc020064a:	10579073          	csrw	stvec,a5
ffffffffc020064e:	000407b7          	lui	a5,0x40
ffffffffc0200652:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200656:	8082                	ret

ffffffffc0200658 <print_regs>:
ffffffffc0200658:	610c                	ld	a1,0(a0)
ffffffffc020065a:	1141                	addi	sp,sp,-16
ffffffffc020065c:	e022                	sd	s0,0(sp)
ffffffffc020065e:	842a                	mv	s0,a0
ffffffffc0200660:	00008517          	auipc	a0,0x8
ffffffffc0200664:	d3050513          	addi	a0,a0,-720 # ffffffffc0208390 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	d3850513          	addi	a0,a0,-712 # ffffffffc02083a8 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	d4250513          	addi	a0,a0,-702 # ffffffffc02083c0 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	d4c50513          	addi	a0,a0,-692 # ffffffffc02083d8 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	d5650513          	addi	a0,a0,-682 # ffffffffc02083f0 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	d6050513          	addi	a0,a0,-672 # ffffffffc0208408 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	d6a50513          	addi	a0,a0,-662 # ffffffffc0208420 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	d7450513          	addi	a0,a0,-652 # ffffffffc0208438 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	d7e50513          	addi	a0,a0,-642 # ffffffffc0208450 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	d8850513          	addi	a0,a0,-632 # ffffffffc0208468 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	d9250513          	addi	a0,a0,-622 # ffffffffc0208480 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	d9c50513          	addi	a0,a0,-612 # ffffffffc0208498 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	da650513          	addi	a0,a0,-602 # ffffffffc02084b0 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	db050513          	addi	a0,a0,-592 # ffffffffc02084c8 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	dba50513          	addi	a0,a0,-582 # ffffffffc02084e0 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	dc450513          	addi	a0,a0,-572 # ffffffffc02084f8 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	dce50513          	addi	a0,a0,-562 # ffffffffc0208510 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	dd850513          	addi	a0,a0,-552 # ffffffffc0208528 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	de250513          	addi	a0,a0,-542 # ffffffffc0208540 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	dec50513          	addi	a0,a0,-532 # ffffffffc0208558 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	df650513          	addi	a0,a0,-522 # ffffffffc0208570 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	e0050513          	addi	a0,a0,-512 # ffffffffc0208588 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	e0a50513          	addi	a0,a0,-502 # ffffffffc02085a0 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	e1450513          	addi	a0,a0,-492 # ffffffffc02085b8 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	e1e50513          	addi	a0,a0,-482 # ffffffffc02085d0 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	e2850513          	addi	a0,a0,-472 # ffffffffc02085e8 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	e3250513          	addi	a0,a0,-462 # ffffffffc0208600 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	e3c50513          	addi	a0,a0,-452 # ffffffffc0208618 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	e4650513          	addi	a0,a0,-442 # ffffffffc0208630 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	e5050513          	addi	a0,a0,-432 # ffffffffc0208648 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	e5a50513          	addi	a0,a0,-422 # ffffffffc0208660 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	e6050513          	addi	a0,a0,-416 # ffffffffc0208678 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	e6250513          	addi	a0,a0,-414 # ffffffffc0208690 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	e6250513          	addi	a0,a0,-414 # ffffffffc02086a8 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	e6a50513          	addi	a0,a0,-406 # ffffffffc02086c0 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	e7250513          	addi	a0,a0,-398 # ffffffffc02086d8 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	e6e50513          	addi	a0,a0,-402 # ffffffffc02086e8 <commands+0x3c0>
ffffffffc0200882:	0141                	addi	sp,sp,16
ffffffffc0200884:	849ff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200888 <pgfault_handler>:
ffffffffc0200888:	1101                	addi	sp,sp,-32
ffffffffc020088a:	e426                	sd	s1,8(sp)
ffffffffc020088c:	00019497          	auipc	s1,0x19
ffffffffc0200890:	cdc48493          	addi	s1,s1,-804 # ffffffffc0219568 <check_mm_struct>
ffffffffc0200894:	609c                	ld	a5,0(s1)
ffffffffc0200896:	e822                	sd	s0,16(sp)
ffffffffc0200898:	ec06                	sd	ra,24(sp)
ffffffffc020089a:	842a                	mv	s0,a0
ffffffffc020089c:	cbad                	beqz	a5,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc020089e:	10053783          	ld	a5,256(a0)
ffffffffc02008a2:	11053583          	ld	a1,272(a0)
ffffffffc02008a6:	04b00613          	li	a2,75
ffffffffc02008aa:	1007f793          	andi	a5,a5,256
ffffffffc02008ae:	c7b1                	beqz	a5,ffffffffc02008fa <pgfault_handler+0x72>
ffffffffc02008b0:	11843703          	ld	a4,280(s0)
ffffffffc02008b4:	47bd                	li	a5,15
ffffffffc02008b6:	05700693          	li	a3,87
ffffffffc02008ba:	00f70463          	beq	a4,a5,ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc02008be:	05200693          	li	a3,82
ffffffffc02008c2:	00008517          	auipc	a0,0x8
ffffffffc02008c6:	e3e50513          	addi	a0,a0,-450 # ffffffffc0208700 <commands+0x3d8>
ffffffffc02008ca:	803ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02008ce:	6088                	ld	a0,0(s1)
ffffffffc02008d0:	cd1d                	beqz	a0,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc02008d2:	00019717          	auipc	a4,0x19
ffffffffc02008d6:	c2e73703          	ld	a4,-978(a4) # ffffffffc0219500 <current>
ffffffffc02008da:	00019797          	auipc	a5,0x19
ffffffffc02008de:	c2e7b783          	ld	a5,-978(a5) # ffffffffc0219508 <idleproc>
ffffffffc02008e2:	04f71663          	bne	a4,a5,ffffffffc020092e <pgfault_handler+0xa6>
ffffffffc02008e6:	11043603          	ld	a2,272(s0)
ffffffffc02008ea:	11843583          	ld	a1,280(s0)
ffffffffc02008ee:	6442                	ld	s0,16(sp)
ffffffffc02008f0:	60e2                	ld	ra,24(sp)
ffffffffc02008f2:	64a2                	ld	s1,8(sp)
ffffffffc02008f4:	6105                	addi	sp,sp,32
ffffffffc02008f6:	5a00106f          	j	ffffffffc0201e96 <do_pgfault>
ffffffffc02008fa:	11843703          	ld	a4,280(s0)
ffffffffc02008fe:	47bd                	li	a5,15
ffffffffc0200900:	05500613          	li	a2,85
ffffffffc0200904:	05700693          	li	a3,87
ffffffffc0200908:	faf71be3          	bne	a4,a5,ffffffffc02008be <pgfault_handler+0x36>
ffffffffc020090c:	bf5d                	j	ffffffffc02008c2 <pgfault_handler+0x3a>
ffffffffc020090e:	00019797          	auipc	a5,0x19
ffffffffc0200912:	bf27b783          	ld	a5,-1038(a5) # ffffffffc0219500 <current>
ffffffffc0200916:	cf85                	beqz	a5,ffffffffc020094e <pgfault_handler+0xc6>
ffffffffc0200918:	11043603          	ld	a2,272(s0)
ffffffffc020091c:	11843583          	ld	a1,280(s0)
ffffffffc0200920:	6442                	ld	s0,16(sp)
ffffffffc0200922:	60e2                	ld	ra,24(sp)
ffffffffc0200924:	64a2                	ld	s1,8(sp)
ffffffffc0200926:	7788                	ld	a0,40(a5)
ffffffffc0200928:	6105                	addi	sp,sp,32
ffffffffc020092a:	56c0106f          	j	ffffffffc0201e96 <do_pgfault>
ffffffffc020092e:	00008697          	auipc	a3,0x8
ffffffffc0200932:	df268693          	addi	a3,a3,-526 # ffffffffc0208720 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	e0260613          	addi	a2,a2,-510 # ffffffffc0208738 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	e0e50513          	addi	a0,a0,-498 # ffffffffc0208750 <commands+0x428>
ffffffffc020094a:	8bfff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020094e:	8522                	mv	a0,s0
ffffffffc0200950:	ed7ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200954:	10043783          	ld	a5,256(s0)
ffffffffc0200958:	11043583          	ld	a1,272(s0)
ffffffffc020095c:	04b00613          	li	a2,75
ffffffffc0200960:	1007f793          	andi	a5,a5,256
ffffffffc0200964:	e399                	bnez	a5,ffffffffc020096a <pgfault_handler+0xe2>
ffffffffc0200966:	05500613          	li	a2,85
ffffffffc020096a:	11843703          	ld	a4,280(s0)
ffffffffc020096e:	47bd                	li	a5,15
ffffffffc0200970:	02f70663          	beq	a4,a5,ffffffffc020099c <pgfault_handler+0x114>
ffffffffc0200974:	05200693          	li	a3,82
ffffffffc0200978:	00008517          	auipc	a0,0x8
ffffffffc020097c:	d8850513          	addi	a0,a0,-632 # ffffffffc0208700 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	de460613          	addi	a2,a2,-540 # ffffffffc0208768 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	dc050513          	addi	a0,a0,-576 # ffffffffc0208750 <commands+0x428>
ffffffffc0200998:	871ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020099c:	05700693          	li	a3,87
ffffffffc02009a0:	bfe1                	j	ffffffffc0200978 <pgfault_handler+0xf0>

ffffffffc02009a2 <interrupt_handler>:
ffffffffc02009a2:	11853783          	ld	a5,280(a0)
ffffffffc02009a6:	472d                	li	a4,11
ffffffffc02009a8:	0786                	slli	a5,a5,0x1
ffffffffc02009aa:	8385                	srli	a5,a5,0x1
ffffffffc02009ac:	06f76863          	bltu	a4,a5,ffffffffc0200a1c <interrupt_handler+0x7a>
ffffffffc02009b0:	00008717          	auipc	a4,0x8
ffffffffc02009b4:	e7070713          	addi	a4,a4,-400 # ffffffffc0208820 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	e1e50513          	addi	a0,a0,-482 # ffffffffc02087e0 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	df250513          	addi	a0,a0,-526 # ffffffffc02087c0 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	da650513          	addi	a0,a0,-602 # ffffffffc0208780 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	dba50513          	addi	a0,a0,-582 # ffffffffc02087a0 <commands+0x478>
ffffffffc02009ee:	edeff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009f2:	1141                	addi	sp,sp,-16
ffffffffc02009f4:	e406                	sd	ra,8(sp)
ffffffffc02009f6:	bb1ff0ef          	jal	ra,ffffffffc02005a6 <clock_set_next_event>
ffffffffc02009fa:	00019717          	auipc	a4,0x19
ffffffffc02009fe:	b3670713          	addi	a4,a4,-1226 # ffffffffc0219530 <ticks>
ffffffffc0200a02:	631c                	ld	a5,0(a4)
ffffffffc0200a04:	60a2                	ld	ra,8(sp)
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
ffffffffc0200a0a:	0141                	addi	sp,sp,16
ffffffffc0200a0c:	3d80406f          	j	ffffffffc0204de4 <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	df050513          	addi	a0,a0,-528 # ffffffffc0208800 <commands+0x4d8>
ffffffffc0200a18:	eb4ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a1c:	b529                	j	ffffffffc0200826 <print_trapframe>

ffffffffc0200a1e <exception_handler>:
ffffffffc0200a1e:	11853783          	ld	a5,280(a0)
ffffffffc0200a22:	1101                	addi	sp,sp,-32
ffffffffc0200a24:	e822                	sd	s0,16(sp)
ffffffffc0200a26:	ec06                	sd	ra,24(sp)
ffffffffc0200a28:	e426                	sd	s1,8(sp)
ffffffffc0200a2a:	473d                	li	a4,15
ffffffffc0200a2c:	842a                	mv	s0,a0
ffffffffc0200a2e:	16f76163          	bltu	a4,a5,ffffffffc0200b90 <exception_handler+0x172>
ffffffffc0200a32:	00008717          	auipc	a4,0x8
ffffffffc0200a36:	fb670713          	addi	a4,a4,-74 # ffffffffc02089e8 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	efc50513          	addi	a0,a0,-260 # ffffffffc0208940 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	1240706f          	j	ffffffffc0207b86 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	efa50513          	addi	a0,a0,-262 # ffffffffc0208960 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	f0650513          	addi	a0,a0,-250 # ffffffffc0208980 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	f1c50513          	addi	a0,a0,-228 # ffffffffc02089a0 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	f2a50513          	addi	a0,a0,-214 # ffffffffc02089b8 <commands+0x690>
ffffffffc0200a96:	e36ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a9a:	8522                	mv	a0,s0
ffffffffc0200a9c:	dedff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200aa0:	84aa                	mv	s1,a0
ffffffffc0200aa2:	10051963          	bnez	a0,ffffffffc0200bb4 <exception_handler+0x196>
ffffffffc0200aa6:	60e2                	ld	ra,24(sp)
ffffffffc0200aa8:	6442                	ld	s0,16(sp)
ffffffffc0200aaa:	64a2                	ld	s1,8(sp)
ffffffffc0200aac:	6105                	addi	sp,sp,32
ffffffffc0200aae:	8082                	ret
ffffffffc0200ab0:	00008517          	auipc	a0,0x8
ffffffffc0200ab4:	f2050513          	addi	a0,a0,-224 # ffffffffc02089d0 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	e2260613          	addi	a2,a2,-478 # ffffffffc02088f0 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	c7650513          	addi	a0,a0,-906 # ffffffffc0208750 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	d6a50513          	addi	a0,a0,-662 # ffffffffc0208850 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	d8050513          	addi	a0,a0,-640 # ffffffffc0208870 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	d9650513          	addi	a0,a0,-618 # ffffffffc0208890 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	da450513          	addi	a0,a0,-604 # ffffffffc02088a8 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	d9e50513          	addi	a0,a0,-610 # ffffffffc02088b8 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	db450513          	addi	a0,a0,-588 # ffffffffc02088d8 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	dae60613          	addi	a2,a2,-594 # ffffffffc02088f0 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	c0250513          	addi	a0,a0,-1022 # ffffffffc0208750 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	dce50513          	addi	a0,a0,-562 # ffffffffc0208928 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	d7860613          	addi	a2,a2,-648 # ffffffffc02088f0 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0208750 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	d7460613          	addi	a2,a2,-652 # ffffffffc0208910 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	ba850513          	addi	a0,a0,-1112 # ffffffffc0208750 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	d3460613          	addi	a2,a2,-716 # ffffffffc02088f0 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	b8850513          	addi	a0,a0,-1144 # ffffffffc0208750 <commands+0x428>
ffffffffc0200bd0:	e38ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200bd4 <trap>:
ffffffffc0200bd4:	1101                	addi	sp,sp,-32
ffffffffc0200bd6:	e822                	sd	s0,16(sp)
ffffffffc0200bd8:	00019417          	auipc	s0,0x19
ffffffffc0200bdc:	92840413          	addi	s0,s0,-1752 # ffffffffc0219500 <current>
ffffffffc0200be0:	6018                	ld	a4,0(s0)
ffffffffc0200be2:	ec06                	sd	ra,24(sp)
ffffffffc0200be4:	e426                	sd	s1,8(sp)
ffffffffc0200be6:	e04a                	sd	s2,0(sp)
ffffffffc0200be8:	11853683          	ld	a3,280(a0)
ffffffffc0200bec:	cf1d                	beqz	a4,ffffffffc0200c2a <trap+0x56>
ffffffffc0200bee:	10053483          	ld	s1,256(a0)
ffffffffc0200bf2:	0a073903          	ld	s2,160(a4)
ffffffffc0200bf6:	f348                	sd	a0,160(a4)
ffffffffc0200bf8:	1004f493          	andi	s1,s1,256
ffffffffc0200bfc:	0206c463          	bltz	a3,ffffffffc0200c24 <trap+0x50>
ffffffffc0200c00:	e1fff0ef          	jal	ra,ffffffffc0200a1e <exception_handler>
ffffffffc0200c04:	601c                	ld	a5,0(s0)
ffffffffc0200c06:	0b27b023          	sd	s2,160(a5)
ffffffffc0200c0a:	e499                	bnez	s1,ffffffffc0200c18 <trap+0x44>
ffffffffc0200c0c:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c10:	8b05                	andi	a4,a4,1
ffffffffc0200c12:	e329                	bnez	a4,ffffffffc0200c54 <trap+0x80>
ffffffffc0200c14:	6f9c                	ld	a5,24(a5)
ffffffffc0200c16:	eb85                	bnez	a5,ffffffffc0200c46 <trap+0x72>
ffffffffc0200c18:	60e2                	ld	ra,24(sp)
ffffffffc0200c1a:	6442                	ld	s0,16(sp)
ffffffffc0200c1c:	64a2                	ld	s1,8(sp)
ffffffffc0200c1e:	6902                	ld	s2,0(sp)
ffffffffc0200c20:	6105                	addi	sp,sp,32
ffffffffc0200c22:	8082                	ret
ffffffffc0200c24:	d7fff0ef          	jal	ra,ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c28:	bff1                	j	ffffffffc0200c04 <trap+0x30>
ffffffffc0200c2a:	0006c863          	bltz	a3,ffffffffc0200c3a <trap+0x66>
ffffffffc0200c2e:	6442                	ld	s0,16(sp)
ffffffffc0200c30:	60e2                	ld	ra,24(sp)
ffffffffc0200c32:	64a2                	ld	s1,8(sp)
ffffffffc0200c34:	6902                	ld	s2,0(sp)
ffffffffc0200c36:	6105                	addi	sp,sp,32
ffffffffc0200c38:	b3dd                	j	ffffffffc0200a1e <exception_handler>
ffffffffc0200c3a:	6442                	ld	s0,16(sp)
ffffffffc0200c3c:	60e2                	ld	ra,24(sp)
ffffffffc0200c3e:	64a2                	ld	s1,8(sp)
ffffffffc0200c40:	6902                	ld	s2,0(sp)
ffffffffc0200c42:	6105                	addi	sp,sp,32
ffffffffc0200c44:	bbb9                	j	ffffffffc02009a2 <interrupt_handler>
ffffffffc0200c46:	6442                	ld	s0,16(sp)
ffffffffc0200c48:	60e2                	ld	ra,24(sp)
ffffffffc0200c4a:	64a2                	ld	s1,8(sp)
ffffffffc0200c4c:	6902                	ld	s2,0(sp)
ffffffffc0200c4e:	6105                	addi	sp,sp,32
ffffffffc0200c50:	7830306f          	j	ffffffffc0204bd2 <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	202030ef          	jal	ra,ffffffffc0203e58 <do_exit>
ffffffffc0200c5a:	601c                	ld	a5,0(s0)
ffffffffc0200c5c:	bf65                	j	ffffffffc0200c14 <trap+0x40>
	...

ffffffffc0200c60 <__alltraps>:
ffffffffc0200c60:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c64:	00011463          	bnez	sp,ffffffffc0200c6c <__alltraps+0xc>
ffffffffc0200c68:	14002173          	csrr	sp,sscratch
ffffffffc0200c6c:	712d                	addi	sp,sp,-288
ffffffffc0200c6e:	e002                	sd	zero,0(sp)
ffffffffc0200c70:	e406                	sd	ra,8(sp)
ffffffffc0200c72:	ec0e                	sd	gp,24(sp)
ffffffffc0200c74:	f012                	sd	tp,32(sp)
ffffffffc0200c76:	f416                	sd	t0,40(sp)
ffffffffc0200c78:	f81a                	sd	t1,48(sp)
ffffffffc0200c7a:	fc1e                	sd	t2,56(sp)
ffffffffc0200c7c:	e0a2                	sd	s0,64(sp)
ffffffffc0200c7e:	e4a6                	sd	s1,72(sp)
ffffffffc0200c80:	e8aa                	sd	a0,80(sp)
ffffffffc0200c82:	ecae                	sd	a1,88(sp)
ffffffffc0200c84:	f0b2                	sd	a2,96(sp)
ffffffffc0200c86:	f4b6                	sd	a3,104(sp)
ffffffffc0200c88:	f8ba                	sd	a4,112(sp)
ffffffffc0200c8a:	fcbe                	sd	a5,120(sp)
ffffffffc0200c8c:	e142                	sd	a6,128(sp)
ffffffffc0200c8e:	e546                	sd	a7,136(sp)
ffffffffc0200c90:	e94a                	sd	s2,144(sp)
ffffffffc0200c92:	ed4e                	sd	s3,152(sp)
ffffffffc0200c94:	f152                	sd	s4,160(sp)
ffffffffc0200c96:	f556                	sd	s5,168(sp)
ffffffffc0200c98:	f95a                	sd	s6,176(sp)
ffffffffc0200c9a:	fd5e                	sd	s7,184(sp)
ffffffffc0200c9c:	e1e2                	sd	s8,192(sp)
ffffffffc0200c9e:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca0:	e9ea                	sd	s10,208(sp)
ffffffffc0200ca2:	edee                	sd	s11,216(sp)
ffffffffc0200ca4:	f1f2                	sd	t3,224(sp)
ffffffffc0200ca6:	f5f6                	sd	t4,232(sp)
ffffffffc0200ca8:	f9fa                	sd	t5,240(sp)
ffffffffc0200caa:	fdfe                	sd	t6,248(sp)
ffffffffc0200cac:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb0:	100024f3          	csrr	s1,sstatus
ffffffffc0200cb4:	14102973          	csrr	s2,sepc
ffffffffc0200cb8:	143029f3          	csrr	s3,stval
ffffffffc0200cbc:	14202a73          	csrr	s4,scause
ffffffffc0200cc0:	e822                	sd	s0,16(sp)
ffffffffc0200cc2:	e226                	sd	s1,256(sp)
ffffffffc0200cc4:	e64a                	sd	s2,264(sp)
ffffffffc0200cc6:	ea4e                	sd	s3,272(sp)
ffffffffc0200cc8:	ee52                	sd	s4,280(sp)
ffffffffc0200cca:	850a                	mv	a0,sp
ffffffffc0200ccc:	f09ff0ef          	jal	ra,ffffffffc0200bd4 <trap>

ffffffffc0200cd0 <__trapret>:
ffffffffc0200cd0:	6492                	ld	s1,256(sp)
ffffffffc0200cd2:	6932                	ld	s2,264(sp)
ffffffffc0200cd4:	1004f413          	andi	s0,s1,256
ffffffffc0200cd8:	e401                	bnez	s0,ffffffffc0200ce0 <__trapret+0x10>
ffffffffc0200cda:	1200                	addi	s0,sp,288
ffffffffc0200cdc:	14041073          	csrw	sscratch,s0
ffffffffc0200ce0:	10049073          	csrw	sstatus,s1
ffffffffc0200ce4:	14191073          	csrw	sepc,s2
ffffffffc0200ce8:	60a2                	ld	ra,8(sp)
ffffffffc0200cea:	61e2                	ld	gp,24(sp)
ffffffffc0200cec:	7202                	ld	tp,32(sp)
ffffffffc0200cee:	72a2                	ld	t0,40(sp)
ffffffffc0200cf0:	7342                	ld	t1,48(sp)
ffffffffc0200cf2:	73e2                	ld	t2,56(sp)
ffffffffc0200cf4:	6406                	ld	s0,64(sp)
ffffffffc0200cf6:	64a6                	ld	s1,72(sp)
ffffffffc0200cf8:	6546                	ld	a0,80(sp)
ffffffffc0200cfa:	65e6                	ld	a1,88(sp)
ffffffffc0200cfc:	7606                	ld	a2,96(sp)
ffffffffc0200cfe:	76a6                	ld	a3,104(sp)
ffffffffc0200d00:	7746                	ld	a4,112(sp)
ffffffffc0200d02:	77e6                	ld	a5,120(sp)
ffffffffc0200d04:	680a                	ld	a6,128(sp)
ffffffffc0200d06:	68aa                	ld	a7,136(sp)
ffffffffc0200d08:	694a                	ld	s2,144(sp)
ffffffffc0200d0a:	69ea                	ld	s3,152(sp)
ffffffffc0200d0c:	7a0a                	ld	s4,160(sp)
ffffffffc0200d0e:	7aaa                	ld	s5,168(sp)
ffffffffc0200d10:	7b4a                	ld	s6,176(sp)
ffffffffc0200d12:	7bea                	ld	s7,184(sp)
ffffffffc0200d14:	6c0e                	ld	s8,192(sp)
ffffffffc0200d16:	6cae                	ld	s9,200(sp)
ffffffffc0200d18:	6d4e                	ld	s10,208(sp)
ffffffffc0200d1a:	6dee                	ld	s11,216(sp)
ffffffffc0200d1c:	7e0e                	ld	t3,224(sp)
ffffffffc0200d1e:	7eae                	ld	t4,232(sp)
ffffffffc0200d20:	7f4e                	ld	t5,240(sp)
ffffffffc0200d22:	7fee                	ld	t6,248(sp)
ffffffffc0200d24:	6142                	ld	sp,16(sp)
ffffffffc0200d26:	10200073          	sret

ffffffffc0200d2a <forkrets>:
ffffffffc0200d2a:	812a                	mv	sp,a0
ffffffffc0200d2c:	b755                	j	ffffffffc0200cd0 <__trapret>

ffffffffc0200d2e <pa2page.part.0>:
ffffffffc0200d2e:	1141                	addi	sp,sp,-16
ffffffffc0200d30:	00008617          	auipc	a2,0x8
ffffffffc0200d34:	cf860613          	addi	a2,a2,-776 # ffffffffc0208a28 <commands+0x700>
ffffffffc0200d38:	06200593          	li	a1,98
ffffffffc0200d3c:	00008517          	auipc	a0,0x8
ffffffffc0200d40:	d0c50513          	addi	a0,a0,-756 # ffffffffc0208a48 <commands+0x720>
ffffffffc0200d44:	e406                	sd	ra,8(sp)
ffffffffc0200d46:	cc2ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200d4a <alloc_pages>:
ffffffffc0200d4a:	7139                	addi	sp,sp,-64
ffffffffc0200d4c:	f426                	sd	s1,40(sp)
ffffffffc0200d4e:	f04a                	sd	s2,32(sp)
ffffffffc0200d50:	ec4e                	sd	s3,24(sp)
ffffffffc0200d52:	e852                	sd	s4,16(sp)
ffffffffc0200d54:	e456                	sd	s5,8(sp)
ffffffffc0200d56:	e05a                	sd	s6,0(sp)
ffffffffc0200d58:	fc06                	sd	ra,56(sp)
ffffffffc0200d5a:	f822                	sd	s0,48(sp)
ffffffffc0200d5c:	84aa                	mv	s1,a0
ffffffffc0200d5e:	00018917          	auipc	s2,0x18
ffffffffc0200d62:	7da90913          	addi	s2,s2,2010 # ffffffffc0219538 <pmm_manager>
ffffffffc0200d66:	4a05                	li	s4,1
ffffffffc0200d68:	00018a97          	auipc	s5,0x18
ffffffffc0200d6c:	790a8a93          	addi	s5,s5,1936 # ffffffffc02194f8 <swap_init_ok>
ffffffffc0200d70:	0005099b          	sext.w	s3,a0
ffffffffc0200d74:	00018b17          	auipc	s6,0x18
ffffffffc0200d78:	7f4b0b13          	addi	s6,s6,2036 # ffffffffc0219568 <check_mm_struct>
ffffffffc0200d7c:	a01d                	j	ffffffffc0200da2 <alloc_pages+0x58>
ffffffffc0200d7e:	00093783          	ld	a5,0(s2)
ffffffffc0200d82:	6f9c                	ld	a5,24(a5)
ffffffffc0200d84:	9782                	jalr	a5
ffffffffc0200d86:	842a                	mv	s0,a0
ffffffffc0200d88:	4601                	li	a2,0
ffffffffc0200d8a:	85ce                	mv	a1,s3
ffffffffc0200d8c:	ec0d                	bnez	s0,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d8e:	029a6c63          	bltu	s4,s1,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d92:	000aa783          	lw	a5,0(s5)
ffffffffc0200d96:	2781                	sext.w	a5,a5
ffffffffc0200d98:	c79d                	beqz	a5,ffffffffc0200dc6 <alloc_pages+0x7c>
ffffffffc0200d9a:	000b3503          	ld	a0,0(s6)
ffffffffc0200d9e:	6d6010ef          	jal	ra,ffffffffc0202474 <swap_out>
ffffffffc0200da2:	100027f3          	csrr	a5,sstatus
ffffffffc0200da6:	8b89                	andi	a5,a5,2
ffffffffc0200da8:	8526                	mv	a0,s1
ffffffffc0200daa:	dbf1                	beqz	a5,ffffffffc0200d7e <alloc_pages+0x34>
ffffffffc0200dac:	88dff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200db0:	00093783          	ld	a5,0(s2)
ffffffffc0200db4:	8526                	mv	a0,s1
ffffffffc0200db6:	6f9c                	ld	a5,24(a5)
ffffffffc0200db8:	9782                	jalr	a5
ffffffffc0200dba:	842a                	mv	s0,a0
ffffffffc0200dbc:	877ff0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200dc0:	4601                	li	a2,0
ffffffffc0200dc2:	85ce                	mv	a1,s3
ffffffffc0200dc4:	d469                	beqz	s0,ffffffffc0200d8e <alloc_pages+0x44>
ffffffffc0200dc6:	70e2                	ld	ra,56(sp)
ffffffffc0200dc8:	8522                	mv	a0,s0
ffffffffc0200dca:	7442                	ld	s0,48(sp)
ffffffffc0200dcc:	74a2                	ld	s1,40(sp)
ffffffffc0200dce:	7902                	ld	s2,32(sp)
ffffffffc0200dd0:	69e2                	ld	s3,24(sp)
ffffffffc0200dd2:	6a42                	ld	s4,16(sp)
ffffffffc0200dd4:	6aa2                	ld	s5,8(sp)
ffffffffc0200dd6:	6b02                	ld	s6,0(sp)
ffffffffc0200dd8:	6121                	addi	sp,sp,64
ffffffffc0200dda:	8082                	ret

ffffffffc0200ddc <free_pages>:
ffffffffc0200ddc:	100027f3          	csrr	a5,sstatus
ffffffffc0200de0:	8b89                	andi	a5,a5,2
ffffffffc0200de2:	eb81                	bnez	a5,ffffffffc0200df2 <free_pages+0x16>
ffffffffc0200de4:	00018797          	auipc	a5,0x18
ffffffffc0200de8:	7547b783          	ld	a5,1876(a5) # ffffffffc0219538 <pmm_manager>
ffffffffc0200dec:	0207b303          	ld	t1,32(a5)
ffffffffc0200df0:	8302                	jr	t1
ffffffffc0200df2:	1101                	addi	sp,sp,-32
ffffffffc0200df4:	ec06                	sd	ra,24(sp)
ffffffffc0200df6:	e822                	sd	s0,16(sp)
ffffffffc0200df8:	e426                	sd	s1,8(sp)
ffffffffc0200dfa:	842a                	mv	s0,a0
ffffffffc0200dfc:	84ae                	mv	s1,a1
ffffffffc0200dfe:	83bff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200e02:	00018797          	auipc	a5,0x18
ffffffffc0200e06:	7367b783          	ld	a5,1846(a5) # ffffffffc0219538 <pmm_manager>
ffffffffc0200e0a:	739c                	ld	a5,32(a5)
ffffffffc0200e0c:	85a6                	mv	a1,s1
ffffffffc0200e0e:	8522                	mv	a0,s0
ffffffffc0200e10:	9782                	jalr	a5
ffffffffc0200e12:	6442                	ld	s0,16(sp)
ffffffffc0200e14:	60e2                	ld	ra,24(sp)
ffffffffc0200e16:	64a2                	ld	s1,8(sp)
ffffffffc0200e18:	6105                	addi	sp,sp,32
ffffffffc0200e1a:	819ff06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0200e1e <nr_free_pages>:
ffffffffc0200e1e:	100027f3          	csrr	a5,sstatus
ffffffffc0200e22:	8b89                	andi	a5,a5,2
ffffffffc0200e24:	eb81                	bnez	a5,ffffffffc0200e34 <nr_free_pages+0x16>
ffffffffc0200e26:	00018797          	auipc	a5,0x18
ffffffffc0200e2a:	7127b783          	ld	a5,1810(a5) # ffffffffc0219538 <pmm_manager>
ffffffffc0200e2e:	0287b303          	ld	t1,40(a5)
ffffffffc0200e32:	8302                	jr	t1
ffffffffc0200e34:	1141                	addi	sp,sp,-16
ffffffffc0200e36:	e406                	sd	ra,8(sp)
ffffffffc0200e38:	e022                	sd	s0,0(sp)
ffffffffc0200e3a:	ffeff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200e3e:	00018797          	auipc	a5,0x18
ffffffffc0200e42:	6fa7b783          	ld	a5,1786(a5) # ffffffffc0219538 <pmm_manager>
ffffffffc0200e46:	779c                	ld	a5,40(a5)
ffffffffc0200e48:	9782                	jalr	a5
ffffffffc0200e4a:	842a                	mv	s0,a0
ffffffffc0200e4c:	fe6ff0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0200e50:	60a2                	ld	ra,8(sp)
ffffffffc0200e52:	8522                	mv	a0,s0
ffffffffc0200e54:	6402                	ld	s0,0(sp)
ffffffffc0200e56:	0141                	addi	sp,sp,16
ffffffffc0200e58:	8082                	ret

ffffffffc0200e5a <pmm_init>:
ffffffffc0200e5a:	00008797          	auipc	a5,0x8
ffffffffc0200e5e:	61e78793          	addi	a5,a5,1566 # ffffffffc0209478 <default_pmm_manager>
ffffffffc0200e62:	638c                	ld	a1,0(a5)
ffffffffc0200e64:	1101                	addi	sp,sp,-32
ffffffffc0200e66:	e426                	sd	s1,8(sp)
ffffffffc0200e68:	00008517          	auipc	a0,0x8
ffffffffc0200e6c:	bf050513          	addi	a0,a0,-1040 # ffffffffc0208a58 <commands+0x730>
ffffffffc0200e70:	00018497          	auipc	s1,0x18
ffffffffc0200e74:	6c848493          	addi	s1,s1,1736 # ffffffffc0219538 <pmm_manager>
ffffffffc0200e78:	ec06                	sd	ra,24(sp)
ffffffffc0200e7a:	e822                	sd	s0,16(sp)
ffffffffc0200e7c:	e09c                	sd	a5,0(s1)
ffffffffc0200e7e:	a4eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200e82:	609c                	ld	a5,0(s1)
ffffffffc0200e84:	00018417          	auipc	s0,0x18
ffffffffc0200e88:	6bc40413          	addi	s0,s0,1724 # ffffffffc0219540 <va_pa_offset>
ffffffffc0200e8c:	679c                	ld	a5,8(a5)
ffffffffc0200e8e:	9782                	jalr	a5
ffffffffc0200e90:	57f5                	li	a5,-3
ffffffffc0200e92:	07fa                	slli	a5,a5,0x1e
ffffffffc0200e94:	00008517          	auipc	a0,0x8
ffffffffc0200e98:	bdc50513          	addi	a0,a0,-1060 # ffffffffc0208a70 <commands+0x748>
ffffffffc0200e9c:	e01c                	sd	a5,0(s0)
ffffffffc0200e9e:	a2eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ea2:	44300693          	li	a3,1091
ffffffffc0200ea6:	06d6                	slli	a3,a3,0x15
ffffffffc0200ea8:	40100613          	li	a2,1025
ffffffffc0200eac:	0656                	slli	a2,a2,0x15
ffffffffc0200eae:	088005b7          	lui	a1,0x8800
ffffffffc0200eb2:	16fd                	addi	a3,a3,-1
ffffffffc0200eb4:	00008517          	auipc	a0,0x8
ffffffffc0200eb8:	bd450513          	addi	a0,a0,-1068 # ffffffffc0208a88 <commands+0x760>
ffffffffc0200ebc:	a10ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ec0:	777d                	lui	a4,0xfffff
ffffffffc0200ec2:	00019797          	auipc	a5,0x19
ffffffffc0200ec6:	7ed78793          	addi	a5,a5,2029 # ffffffffc021a6af <end+0xfff>
ffffffffc0200eca:	8ff9                	and	a5,a5,a4
ffffffffc0200ecc:	00088737          	lui	a4,0x88
ffffffffc0200ed0:	60070713          	addi	a4,a4,1536 # 88600 <kern_entry-0xffffffffc0177a00>
ffffffffc0200ed4:	00018597          	auipc	a1,0x18
ffffffffc0200ed8:	60458593          	addi	a1,a1,1540 # ffffffffc02194d8 <npage>
ffffffffc0200edc:	00018617          	auipc	a2,0x18
ffffffffc0200ee0:	67460613          	addi	a2,a2,1652 # ffffffffc0219550 <pages>
ffffffffc0200ee4:	e198                	sd	a4,0(a1)
ffffffffc0200ee6:	e21c                	sd	a5,0(a2)
ffffffffc0200ee8:	4701                	li	a4,0
ffffffffc0200eea:	4505                	li	a0,1
ffffffffc0200eec:	fff80837          	lui	a6,0xfff80
ffffffffc0200ef0:	a011                	j	ffffffffc0200ef4 <pmm_init+0x9a>
ffffffffc0200ef2:	621c                	ld	a5,0(a2)
ffffffffc0200ef4:	00671693          	slli	a3,a4,0x6
ffffffffc0200ef8:	97b6                	add	a5,a5,a3
ffffffffc0200efa:	07a1                	addi	a5,a5,8
ffffffffc0200efc:	40a7b02f          	amoor.d	zero,a0,(a5)
ffffffffc0200f00:	0005b883          	ld	a7,0(a1)
ffffffffc0200f04:	0705                	addi	a4,a4,1
ffffffffc0200f06:	010886b3          	add	a3,a7,a6
ffffffffc0200f0a:	fed764e3          	bltu	a4,a3,ffffffffc0200ef2 <pmm_init+0x98>
ffffffffc0200f0e:	6208                	ld	a0,0(a2)
ffffffffc0200f10:	069a                	slli	a3,a3,0x6
ffffffffc0200f12:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f16:	96aa                	add	a3,a3,a0
ffffffffc0200f18:	06f6e163          	bltu	a3,a5,ffffffffc0200f7a <pmm_init+0x120>
ffffffffc0200f1c:	601c                	ld	a5,0(s0)
ffffffffc0200f1e:	44300593          	li	a1,1091
ffffffffc0200f22:	05d6                	slli	a1,a1,0x15
ffffffffc0200f24:	8e9d                	sub	a3,a3,a5
ffffffffc0200f26:	02b6f363          	bgeu	a3,a1,ffffffffc0200f4c <pmm_init+0xf2>
ffffffffc0200f2a:	6785                	lui	a5,0x1
ffffffffc0200f2c:	17fd                	addi	a5,a5,-1
ffffffffc0200f2e:	96be                	add	a3,a3,a5
ffffffffc0200f30:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200f34:	0717fb63          	bgeu	a5,a7,ffffffffc0200faa <pmm_init+0x150>
ffffffffc0200f38:	6098                	ld	a4,0(s1)
ffffffffc0200f3a:	767d                	lui	a2,0xfffff
ffffffffc0200f3c:	8ef1                	and	a3,a3,a2
ffffffffc0200f3e:	97c2                	add	a5,a5,a6
ffffffffc0200f40:	6b18                	ld	a4,16(a4)
ffffffffc0200f42:	8d95                	sub	a1,a1,a3
ffffffffc0200f44:	079a                	slli	a5,a5,0x6
ffffffffc0200f46:	81b1                	srli	a1,a1,0xc
ffffffffc0200f48:	953e                	add	a0,a0,a5
ffffffffc0200f4a:	9702                	jalr	a4
ffffffffc0200f4c:	0000c697          	auipc	a3,0xc
ffffffffc0200f50:	0b468693          	addi	a3,a3,180 # ffffffffc020d000 <boot_page_table_sv39>
ffffffffc0200f54:	00018797          	auipc	a5,0x18
ffffffffc0200f58:	56d7be23          	sd	a3,1404(a5) # ffffffffc02194d0 <boot_pgdir>
ffffffffc0200f5c:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f60:	02f6e963          	bltu	a3,a5,ffffffffc0200f92 <pmm_init+0x138>
ffffffffc0200f64:	601c                	ld	a5,0(s0)
ffffffffc0200f66:	60e2                	ld	ra,24(sp)
ffffffffc0200f68:	6442                	ld	s0,16(sp)
ffffffffc0200f6a:	8e9d                	sub	a3,a3,a5
ffffffffc0200f6c:	00018797          	auipc	a5,0x18
ffffffffc0200f70:	5cd7be23          	sd	a3,1500(a5) # ffffffffc0219548 <boot_cr3>
ffffffffc0200f74:	64a2                	ld	s1,8(sp)
ffffffffc0200f76:	6105                	addi	sp,sp,32
ffffffffc0200f78:	8082                	ret
ffffffffc0200f7a:	00008617          	auipc	a2,0x8
ffffffffc0200f7e:	b3660613          	addi	a2,a2,-1226 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0200f82:	07f00593          	li	a1,127
ffffffffc0200f86:	00008517          	auipc	a0,0x8
ffffffffc0200f8a:	b5250513          	addi	a0,a0,-1198 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0200f8e:	a7aff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200f92:	00008617          	auipc	a2,0x8
ffffffffc0200f96:	b1e60613          	addi	a2,a2,-1250 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0200f9a:	0c100593          	li	a1,193
ffffffffc0200f9e:	00008517          	auipc	a0,0x8
ffffffffc0200fa2:	b3a50513          	addi	a0,a0,-1222 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0200fa6:	a62ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200faa:	d85ff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0200fae <get_pte>:
ffffffffc0200fae:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200fb2:	1ff7f793          	andi	a5,a5,511
ffffffffc0200fb6:	7139                	addi	sp,sp,-64
ffffffffc0200fb8:	078e                	slli	a5,a5,0x3
ffffffffc0200fba:	f426                	sd	s1,40(sp)
ffffffffc0200fbc:	00f504b3          	add	s1,a0,a5
ffffffffc0200fc0:	6094                	ld	a3,0(s1)
ffffffffc0200fc2:	f04a                	sd	s2,32(sp)
ffffffffc0200fc4:	ec4e                	sd	s3,24(sp)
ffffffffc0200fc6:	e852                	sd	s4,16(sp)
ffffffffc0200fc8:	fc06                	sd	ra,56(sp)
ffffffffc0200fca:	f822                	sd	s0,48(sp)
ffffffffc0200fcc:	e456                	sd	s5,8(sp)
ffffffffc0200fce:	e05a                	sd	s6,0(sp)
ffffffffc0200fd0:	0016f793          	andi	a5,a3,1
ffffffffc0200fd4:	892e                	mv	s2,a1
ffffffffc0200fd6:	89b2                	mv	s3,a2
ffffffffc0200fd8:	00018a17          	auipc	s4,0x18
ffffffffc0200fdc:	500a0a13          	addi	s4,s4,1280 # ffffffffc02194d8 <npage>
ffffffffc0200fe0:	e7b5                	bnez	a5,ffffffffc020104c <get_pte+0x9e>
ffffffffc0200fe2:	12060b63          	beqz	a2,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200fe6:	4505                	li	a0,1
ffffffffc0200fe8:	d63ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0200fec:	842a                	mv	s0,a0
ffffffffc0200fee:	12050563          	beqz	a0,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200ff2:	00018b17          	auipc	s6,0x18
ffffffffc0200ff6:	55eb0b13          	addi	s6,s6,1374 # ffffffffc0219550 <pages>
ffffffffc0200ffa:	000b3503          	ld	a0,0(s6)
ffffffffc0200ffe:	00080ab7          	lui	s5,0x80
ffffffffc0201002:	00018a17          	auipc	s4,0x18
ffffffffc0201006:	4d6a0a13          	addi	s4,s4,1238 # ffffffffc02194d8 <npage>
ffffffffc020100a:	40a40533          	sub	a0,s0,a0
ffffffffc020100e:	8519                	srai	a0,a0,0x6
ffffffffc0201010:	9556                	add	a0,a0,s5
ffffffffc0201012:	000a3703          	ld	a4,0(s4)
ffffffffc0201016:	00c51793          	slli	a5,a0,0xc
ffffffffc020101a:	4685                	li	a3,1
ffffffffc020101c:	c014                	sw	a3,0(s0)
ffffffffc020101e:	83b1                	srli	a5,a5,0xc
ffffffffc0201020:	0532                	slli	a0,a0,0xc
ffffffffc0201022:	14e7f263          	bgeu	a5,a4,ffffffffc0201166 <get_pte+0x1b8>
ffffffffc0201026:	00018797          	auipc	a5,0x18
ffffffffc020102a:	51a7b783          	ld	a5,1306(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc020102e:	6605                	lui	a2,0x1
ffffffffc0201030:	4581                	li	a1,0
ffffffffc0201032:	953e                	add	a0,a0,a5
ffffffffc0201034:	425060ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0201038:	000b3683          	ld	a3,0(s6)
ffffffffc020103c:	40d406b3          	sub	a3,s0,a3
ffffffffc0201040:	8699                	srai	a3,a3,0x6
ffffffffc0201042:	96d6                	add	a3,a3,s5
ffffffffc0201044:	06aa                	slli	a3,a3,0xa
ffffffffc0201046:	0116e693          	ori	a3,a3,17
ffffffffc020104a:	e094                	sd	a3,0(s1)
ffffffffc020104c:	77fd                	lui	a5,0xfffff
ffffffffc020104e:	068a                	slli	a3,a3,0x2
ffffffffc0201050:	000a3703          	ld	a4,0(s4)
ffffffffc0201054:	8efd                	and	a3,a3,a5
ffffffffc0201056:	00c6d793          	srli	a5,a3,0xc
ffffffffc020105a:	0ce7f163          	bgeu	a5,a4,ffffffffc020111c <get_pte+0x16e>
ffffffffc020105e:	00018a97          	auipc	s5,0x18
ffffffffc0201062:	4e2a8a93          	addi	s5,s5,1250 # ffffffffc0219540 <va_pa_offset>
ffffffffc0201066:	000ab403          	ld	s0,0(s5)
ffffffffc020106a:	01595793          	srli	a5,s2,0x15
ffffffffc020106e:	1ff7f793          	andi	a5,a5,511
ffffffffc0201072:	96a2                	add	a3,a3,s0
ffffffffc0201074:	00379413          	slli	s0,a5,0x3
ffffffffc0201078:	9436                	add	s0,s0,a3
ffffffffc020107a:	6014                	ld	a3,0(s0)
ffffffffc020107c:	0016f793          	andi	a5,a3,1
ffffffffc0201080:	e3ad                	bnez	a5,ffffffffc02010e2 <get_pte+0x134>
ffffffffc0201082:	08098b63          	beqz	s3,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0201086:	4505                	li	a0,1
ffffffffc0201088:	cc3ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020108c:	84aa                	mv	s1,a0
ffffffffc020108e:	c549                	beqz	a0,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0201090:	00018b17          	auipc	s6,0x18
ffffffffc0201094:	4c0b0b13          	addi	s6,s6,1216 # ffffffffc0219550 <pages>
ffffffffc0201098:	000b3503          	ld	a0,0(s6)
ffffffffc020109c:	000809b7          	lui	s3,0x80
ffffffffc02010a0:	000a3703          	ld	a4,0(s4)
ffffffffc02010a4:	40a48533          	sub	a0,s1,a0
ffffffffc02010a8:	8519                	srai	a0,a0,0x6
ffffffffc02010aa:	954e                	add	a0,a0,s3
ffffffffc02010ac:	00c51793          	slli	a5,a0,0xc
ffffffffc02010b0:	4685                	li	a3,1
ffffffffc02010b2:	c094                	sw	a3,0(s1)
ffffffffc02010b4:	83b1                	srli	a5,a5,0xc
ffffffffc02010b6:	0532                	slli	a0,a0,0xc
ffffffffc02010b8:	08e7fa63          	bgeu	a5,a4,ffffffffc020114c <get_pte+0x19e>
ffffffffc02010bc:	000ab783          	ld	a5,0(s5)
ffffffffc02010c0:	6605                	lui	a2,0x1
ffffffffc02010c2:	4581                	li	a1,0
ffffffffc02010c4:	953e                	add	a0,a0,a5
ffffffffc02010c6:	393060ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc02010ca:	000b3683          	ld	a3,0(s6)
ffffffffc02010ce:	40d486b3          	sub	a3,s1,a3
ffffffffc02010d2:	8699                	srai	a3,a3,0x6
ffffffffc02010d4:	96ce                	add	a3,a3,s3
ffffffffc02010d6:	06aa                	slli	a3,a3,0xa
ffffffffc02010d8:	0116e693          	ori	a3,a3,17
ffffffffc02010dc:	e014                	sd	a3,0(s0)
ffffffffc02010de:	000a3703          	ld	a4,0(s4)
ffffffffc02010e2:	068a                	slli	a3,a3,0x2
ffffffffc02010e4:	757d                	lui	a0,0xfffff
ffffffffc02010e6:	8ee9                	and	a3,a3,a0
ffffffffc02010e8:	00c6d793          	srli	a5,a3,0xc
ffffffffc02010ec:	04e7f463          	bgeu	a5,a4,ffffffffc0201134 <get_pte+0x186>
ffffffffc02010f0:	000ab503          	ld	a0,0(s5)
ffffffffc02010f4:	00c95913          	srli	s2,s2,0xc
ffffffffc02010f8:	1ff97913          	andi	s2,s2,511
ffffffffc02010fc:	96aa                	add	a3,a3,a0
ffffffffc02010fe:	00391513          	slli	a0,s2,0x3
ffffffffc0201102:	9536                	add	a0,a0,a3
ffffffffc0201104:	70e2                	ld	ra,56(sp)
ffffffffc0201106:	7442                	ld	s0,48(sp)
ffffffffc0201108:	74a2                	ld	s1,40(sp)
ffffffffc020110a:	7902                	ld	s2,32(sp)
ffffffffc020110c:	69e2                	ld	s3,24(sp)
ffffffffc020110e:	6a42                	ld	s4,16(sp)
ffffffffc0201110:	6aa2                	ld	s5,8(sp)
ffffffffc0201112:	6b02                	ld	s6,0(sp)
ffffffffc0201114:	6121                	addi	sp,sp,64
ffffffffc0201116:	8082                	ret
ffffffffc0201118:	4501                	li	a0,0
ffffffffc020111a:	b7ed                	j	ffffffffc0201104 <get_pte+0x156>
ffffffffc020111c:	00008617          	auipc	a2,0x8
ffffffffc0201120:	9cc60613          	addi	a2,a2,-1588 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0201124:	0fe00593          	li	a1,254
ffffffffc0201128:	00008517          	auipc	a0,0x8
ffffffffc020112c:	9b050513          	addi	a0,a0,-1616 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201130:	8d8ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201134:	00008617          	auipc	a2,0x8
ffffffffc0201138:	9b460613          	addi	a2,a2,-1612 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc020113c:	10900593          	li	a1,265
ffffffffc0201140:	00008517          	auipc	a0,0x8
ffffffffc0201144:	99850513          	addi	a0,a0,-1640 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201148:	8c0ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020114c:	86aa                	mv	a3,a0
ffffffffc020114e:	00008617          	auipc	a2,0x8
ffffffffc0201152:	99a60613          	addi	a2,a2,-1638 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0201156:	10600593          	li	a1,262
ffffffffc020115a:	00008517          	auipc	a0,0x8
ffffffffc020115e:	97e50513          	addi	a0,a0,-1666 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201162:	8a6ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201166:	86aa                	mv	a3,a0
ffffffffc0201168:	00008617          	auipc	a2,0x8
ffffffffc020116c:	98060613          	addi	a2,a2,-1664 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0201170:	0fa00593          	li	a1,250
ffffffffc0201174:	00008517          	auipc	a0,0x8
ffffffffc0201178:	96450513          	addi	a0,a0,-1692 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020117c:	88cff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201180 <unmap_range>:
ffffffffc0201180:	711d                	addi	sp,sp,-96
ffffffffc0201182:	00c5e7b3          	or	a5,a1,a2
ffffffffc0201186:	ec86                	sd	ra,88(sp)
ffffffffc0201188:	e8a2                	sd	s0,80(sp)
ffffffffc020118a:	e4a6                	sd	s1,72(sp)
ffffffffc020118c:	e0ca                	sd	s2,64(sp)
ffffffffc020118e:	fc4e                	sd	s3,56(sp)
ffffffffc0201190:	f852                	sd	s4,48(sp)
ffffffffc0201192:	f456                	sd	s5,40(sp)
ffffffffc0201194:	f05a                	sd	s6,32(sp)
ffffffffc0201196:	ec5e                	sd	s7,24(sp)
ffffffffc0201198:	e862                	sd	s8,16(sp)
ffffffffc020119a:	e466                	sd	s9,8(sp)
ffffffffc020119c:	17d2                	slli	a5,a5,0x34
ffffffffc020119e:	ebf1                	bnez	a5,ffffffffc0201272 <unmap_range+0xf2>
ffffffffc02011a0:	002007b7          	lui	a5,0x200
ffffffffc02011a4:	842e                	mv	s0,a1
ffffffffc02011a6:	0af5e663          	bltu	a1,a5,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011aa:	8932                	mv	s2,a2
ffffffffc02011ac:	0ac5f363          	bgeu	a1,a2,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011b0:	4785                	li	a5,1
ffffffffc02011b2:	07fe                	slli	a5,a5,0x1f
ffffffffc02011b4:	08c7ef63          	bltu	a5,a2,ffffffffc0201252 <unmap_range+0xd2>
ffffffffc02011b8:	89aa                	mv	s3,a0
ffffffffc02011ba:	6a05                	lui	s4,0x1
ffffffffc02011bc:	00018c97          	auipc	s9,0x18
ffffffffc02011c0:	31cc8c93          	addi	s9,s9,796 # ffffffffc02194d8 <npage>
ffffffffc02011c4:	00018c17          	auipc	s8,0x18
ffffffffc02011c8:	38cc0c13          	addi	s8,s8,908 # ffffffffc0219550 <pages>
ffffffffc02011cc:	fff80bb7          	lui	s7,0xfff80
ffffffffc02011d0:	00200b37          	lui	s6,0x200
ffffffffc02011d4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02011d8:	4601                	li	a2,0
ffffffffc02011da:	85a2                	mv	a1,s0
ffffffffc02011dc:	854e                	mv	a0,s3
ffffffffc02011de:	dd1ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02011e2:	84aa                	mv	s1,a0
ffffffffc02011e4:	cd21                	beqz	a0,ffffffffc020123c <unmap_range+0xbc>
ffffffffc02011e6:	611c                	ld	a5,0(a0)
ffffffffc02011e8:	e38d                	bnez	a5,ffffffffc020120a <unmap_range+0x8a>
ffffffffc02011ea:	9452                	add	s0,s0,s4
ffffffffc02011ec:	ff2466e3          	bltu	s0,s2,ffffffffc02011d8 <unmap_range+0x58>
ffffffffc02011f0:	60e6                	ld	ra,88(sp)
ffffffffc02011f2:	6446                	ld	s0,80(sp)
ffffffffc02011f4:	64a6                	ld	s1,72(sp)
ffffffffc02011f6:	6906                	ld	s2,64(sp)
ffffffffc02011f8:	79e2                	ld	s3,56(sp)
ffffffffc02011fa:	7a42                	ld	s4,48(sp)
ffffffffc02011fc:	7aa2                	ld	s5,40(sp)
ffffffffc02011fe:	7b02                	ld	s6,32(sp)
ffffffffc0201200:	6be2                	ld	s7,24(sp)
ffffffffc0201202:	6c42                	ld	s8,16(sp)
ffffffffc0201204:	6ca2                	ld	s9,8(sp)
ffffffffc0201206:	6125                	addi	sp,sp,96
ffffffffc0201208:	8082                	ret
ffffffffc020120a:	0017f713          	andi	a4,a5,1
ffffffffc020120e:	df71                	beqz	a4,ffffffffc02011ea <unmap_range+0x6a>
ffffffffc0201210:	000cb703          	ld	a4,0(s9)
ffffffffc0201214:	078a                	slli	a5,a5,0x2
ffffffffc0201216:	83b1                	srli	a5,a5,0xc
ffffffffc0201218:	06e7fd63          	bgeu	a5,a4,ffffffffc0201292 <unmap_range+0x112>
ffffffffc020121c:	000c3503          	ld	a0,0(s8)
ffffffffc0201220:	97de                	add	a5,a5,s7
ffffffffc0201222:	079a                	slli	a5,a5,0x6
ffffffffc0201224:	953e                	add	a0,a0,a5
ffffffffc0201226:	411c                	lw	a5,0(a0)
ffffffffc0201228:	fff7871b          	addiw	a4,a5,-1
ffffffffc020122c:	c118                	sw	a4,0(a0)
ffffffffc020122e:	cf11                	beqz	a4,ffffffffc020124a <unmap_range+0xca>
ffffffffc0201230:	0004b023          	sd	zero,0(s1)
ffffffffc0201234:	12040073          	sfence.vma	s0
ffffffffc0201238:	9452                	add	s0,s0,s4
ffffffffc020123a:	bf4d                	j	ffffffffc02011ec <unmap_range+0x6c>
ffffffffc020123c:	945a                	add	s0,s0,s6
ffffffffc020123e:	01547433          	and	s0,s0,s5
ffffffffc0201242:	d45d                	beqz	s0,ffffffffc02011f0 <unmap_range+0x70>
ffffffffc0201244:	f9246ae3          	bltu	s0,s2,ffffffffc02011d8 <unmap_range+0x58>
ffffffffc0201248:	b765                	j	ffffffffc02011f0 <unmap_range+0x70>
ffffffffc020124a:	4585                	li	a1,1
ffffffffc020124c:	b91ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0201250:	b7c5                	j	ffffffffc0201230 <unmap_range+0xb0>
ffffffffc0201252:	00008697          	auipc	a3,0x8
ffffffffc0201256:	8ee68693          	addi	a3,a3,-1810 # ffffffffc0208b40 <commands+0x818>
ffffffffc020125a:	00007617          	auipc	a2,0x7
ffffffffc020125e:	4de60613          	addi	a2,a2,1246 # ffffffffc0208738 <commands+0x410>
ffffffffc0201262:	14100593          	li	a1,321
ffffffffc0201266:	00008517          	auipc	a0,0x8
ffffffffc020126a:	87250513          	addi	a0,a0,-1934 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020126e:	f9bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201272:	00008697          	auipc	a3,0x8
ffffffffc0201276:	89e68693          	addi	a3,a3,-1890 # ffffffffc0208b10 <commands+0x7e8>
ffffffffc020127a:	00007617          	auipc	a2,0x7
ffffffffc020127e:	4be60613          	addi	a2,a2,1214 # ffffffffc0208738 <commands+0x410>
ffffffffc0201282:	14000593          	li	a1,320
ffffffffc0201286:	00008517          	auipc	a0,0x8
ffffffffc020128a:	85250513          	addi	a0,a0,-1966 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020128e:	f7bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201292:	a9dff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0201296 <exit_range>:
ffffffffc0201296:	715d                	addi	sp,sp,-80
ffffffffc0201298:	00c5e7b3          	or	a5,a1,a2
ffffffffc020129c:	e486                	sd	ra,72(sp)
ffffffffc020129e:	e0a2                	sd	s0,64(sp)
ffffffffc02012a0:	fc26                	sd	s1,56(sp)
ffffffffc02012a2:	f84a                	sd	s2,48(sp)
ffffffffc02012a4:	f44e                	sd	s3,40(sp)
ffffffffc02012a6:	f052                	sd	s4,32(sp)
ffffffffc02012a8:	ec56                	sd	s5,24(sp)
ffffffffc02012aa:	e85a                	sd	s6,16(sp)
ffffffffc02012ac:	e45e                	sd	s7,8(sp)
ffffffffc02012ae:	17d2                	slli	a5,a5,0x34
ffffffffc02012b0:	e3f1                	bnez	a5,ffffffffc0201374 <exit_range+0xde>
ffffffffc02012b2:	002007b7          	lui	a5,0x200
ffffffffc02012b6:	08f5ef63          	bltu	a1,a5,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012ba:	89b2                	mv	s3,a2
ffffffffc02012bc:	08c5fc63          	bgeu	a1,a2,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012c0:	4785                	li	a5,1
ffffffffc02012c2:	ffe004b7          	lui	s1,0xffe00
ffffffffc02012c6:	07fe                	slli	a5,a5,0x1f
ffffffffc02012c8:	8ced                	and	s1,s1,a1
ffffffffc02012ca:	08c7e563          	bltu	a5,a2,ffffffffc0201354 <exit_range+0xbe>
ffffffffc02012ce:	8a2a                	mv	s4,a0
ffffffffc02012d0:	00018b17          	auipc	s6,0x18
ffffffffc02012d4:	208b0b13          	addi	s6,s6,520 # ffffffffc02194d8 <npage>
ffffffffc02012d8:	00018b97          	auipc	s7,0x18
ffffffffc02012dc:	278b8b93          	addi	s7,s7,632 # ffffffffc0219550 <pages>
ffffffffc02012e0:	fff80937          	lui	s2,0xfff80
ffffffffc02012e4:	00200ab7          	lui	s5,0x200
ffffffffc02012e8:	a019                	j	ffffffffc02012ee <exit_range+0x58>
ffffffffc02012ea:	0334fe63          	bgeu	s1,s3,ffffffffc0201326 <exit_range+0x90>
ffffffffc02012ee:	01e4d413          	srli	s0,s1,0x1e
ffffffffc02012f2:	1ff47413          	andi	s0,s0,511
ffffffffc02012f6:	040e                	slli	s0,s0,0x3
ffffffffc02012f8:	9452                	add	s0,s0,s4
ffffffffc02012fa:	601c                	ld	a5,0(s0)
ffffffffc02012fc:	0017f713          	andi	a4,a5,1
ffffffffc0201300:	c30d                	beqz	a4,ffffffffc0201322 <exit_range+0x8c>
ffffffffc0201302:	000b3703          	ld	a4,0(s6)
ffffffffc0201306:	078a                	slli	a5,a5,0x2
ffffffffc0201308:	83b1                	srli	a5,a5,0xc
ffffffffc020130a:	02e7f963          	bgeu	a5,a4,ffffffffc020133c <exit_range+0xa6>
ffffffffc020130e:	000bb503          	ld	a0,0(s7)
ffffffffc0201312:	97ca                	add	a5,a5,s2
ffffffffc0201314:	079a                	slli	a5,a5,0x6
ffffffffc0201316:	4585                	li	a1,1
ffffffffc0201318:	953e                	add	a0,a0,a5
ffffffffc020131a:	ac3ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020131e:	00043023          	sd	zero,0(s0)
ffffffffc0201322:	94d6                	add	s1,s1,s5
ffffffffc0201324:	f0f9                	bnez	s1,ffffffffc02012ea <exit_range+0x54>
ffffffffc0201326:	60a6                	ld	ra,72(sp)
ffffffffc0201328:	6406                	ld	s0,64(sp)
ffffffffc020132a:	74e2                	ld	s1,56(sp)
ffffffffc020132c:	7942                	ld	s2,48(sp)
ffffffffc020132e:	79a2                	ld	s3,40(sp)
ffffffffc0201330:	7a02                	ld	s4,32(sp)
ffffffffc0201332:	6ae2                	ld	s5,24(sp)
ffffffffc0201334:	6b42                	ld	s6,16(sp)
ffffffffc0201336:	6ba2                	ld	s7,8(sp)
ffffffffc0201338:	6161                	addi	sp,sp,80
ffffffffc020133a:	8082                	ret
ffffffffc020133c:	00007617          	auipc	a2,0x7
ffffffffc0201340:	6ec60613          	addi	a2,a2,1772 # ffffffffc0208a28 <commands+0x700>
ffffffffc0201344:	06200593          	li	a1,98
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	70050513          	addi	a0,a0,1792 # ffffffffc0208a48 <commands+0x720>
ffffffffc0201350:	eb9fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201354:	00007697          	auipc	a3,0x7
ffffffffc0201358:	7ec68693          	addi	a3,a3,2028 # ffffffffc0208b40 <commands+0x818>
ffffffffc020135c:	00007617          	auipc	a2,0x7
ffffffffc0201360:	3dc60613          	addi	a2,a2,988 # ffffffffc0208738 <commands+0x410>
ffffffffc0201364:	15200593          	li	a1,338
ffffffffc0201368:	00007517          	auipc	a0,0x7
ffffffffc020136c:	77050513          	addi	a0,a0,1904 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201370:	e99fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201374:	00007697          	auipc	a3,0x7
ffffffffc0201378:	79c68693          	addi	a3,a3,1948 # ffffffffc0208b10 <commands+0x7e8>
ffffffffc020137c:	00007617          	auipc	a2,0x7
ffffffffc0201380:	3bc60613          	addi	a2,a2,956 # ffffffffc0208738 <commands+0x410>
ffffffffc0201384:	15100593          	li	a1,337
ffffffffc0201388:	00007517          	auipc	a0,0x7
ffffffffc020138c:	75050513          	addi	a0,a0,1872 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201390:	e79fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201394 <page_insert>:
ffffffffc0201394:	7179                	addi	sp,sp,-48
ffffffffc0201396:	e44e                	sd	s3,8(sp)
ffffffffc0201398:	89b2                	mv	s3,a2
ffffffffc020139a:	f022                	sd	s0,32(sp)
ffffffffc020139c:	4605                	li	a2,1
ffffffffc020139e:	842e                	mv	s0,a1
ffffffffc02013a0:	85ce                	mv	a1,s3
ffffffffc02013a2:	ec26                	sd	s1,24(sp)
ffffffffc02013a4:	f406                	sd	ra,40(sp)
ffffffffc02013a6:	e84a                	sd	s2,16(sp)
ffffffffc02013a8:	e052                	sd	s4,0(sp)
ffffffffc02013aa:	84b6                	mv	s1,a3
ffffffffc02013ac:	c03ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02013b0:	cd41                	beqz	a0,ffffffffc0201448 <page_insert+0xb4>
ffffffffc02013b2:	4014                	lw	a3,0(s0)
ffffffffc02013b4:	611c                	ld	a5,0(a0)
ffffffffc02013b6:	892a                	mv	s2,a0
ffffffffc02013b8:	0016871b          	addiw	a4,a3,1
ffffffffc02013bc:	c018                	sw	a4,0(s0)
ffffffffc02013be:	0017f713          	andi	a4,a5,1
ffffffffc02013c2:	eb1d                	bnez	a4,ffffffffc02013f8 <page_insert+0x64>
ffffffffc02013c4:	00018717          	auipc	a4,0x18
ffffffffc02013c8:	18c73703          	ld	a4,396(a4) # ffffffffc0219550 <pages>
ffffffffc02013cc:	8c19                	sub	s0,s0,a4
ffffffffc02013ce:	000807b7          	lui	a5,0x80
ffffffffc02013d2:	8419                	srai	s0,s0,0x6
ffffffffc02013d4:	943e                	add	s0,s0,a5
ffffffffc02013d6:	042a                	slli	s0,s0,0xa
ffffffffc02013d8:	8c45                	or	s0,s0,s1
ffffffffc02013da:	00146413          	ori	s0,s0,1
ffffffffc02013de:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd66950>
ffffffffc02013e2:	12098073          	sfence.vma	s3
ffffffffc02013e6:	4501                	li	a0,0
ffffffffc02013e8:	70a2                	ld	ra,40(sp)
ffffffffc02013ea:	7402                	ld	s0,32(sp)
ffffffffc02013ec:	64e2                	ld	s1,24(sp)
ffffffffc02013ee:	6942                	ld	s2,16(sp)
ffffffffc02013f0:	69a2                	ld	s3,8(sp)
ffffffffc02013f2:	6a02                	ld	s4,0(sp)
ffffffffc02013f4:	6145                	addi	sp,sp,48
ffffffffc02013f6:	8082                	ret
ffffffffc02013f8:	078a                	slli	a5,a5,0x2
ffffffffc02013fa:	83b1                	srli	a5,a5,0xc
ffffffffc02013fc:	00018717          	auipc	a4,0x18
ffffffffc0201400:	0dc73703          	ld	a4,220(a4) # ffffffffc02194d8 <npage>
ffffffffc0201404:	04e7f463          	bgeu	a5,a4,ffffffffc020144c <page_insert+0xb8>
ffffffffc0201408:	00018a17          	auipc	s4,0x18
ffffffffc020140c:	148a0a13          	addi	s4,s4,328 # ffffffffc0219550 <pages>
ffffffffc0201410:	000a3703          	ld	a4,0(s4)
ffffffffc0201414:	fff80537          	lui	a0,0xfff80
ffffffffc0201418:	97aa                	add	a5,a5,a0
ffffffffc020141a:	079a                	slli	a5,a5,0x6
ffffffffc020141c:	97ba                	add	a5,a5,a4
ffffffffc020141e:	00f40a63          	beq	s0,a5,ffffffffc0201432 <page_insert+0x9e>
ffffffffc0201422:	4394                	lw	a3,0(a5)
ffffffffc0201424:	fff6861b          	addiw	a2,a3,-1
ffffffffc0201428:	c390                	sw	a2,0(a5)
ffffffffc020142a:	c611                	beqz	a2,ffffffffc0201436 <page_insert+0xa2>
ffffffffc020142c:	12098073          	sfence.vma	s3
ffffffffc0201430:	bf71                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201432:	c014                	sw	a3,0(s0)
ffffffffc0201434:	bf61                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201436:	4585                	li	a1,1
ffffffffc0201438:	853e                	mv	a0,a5
ffffffffc020143a:	9a3ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020143e:	000a3703          	ld	a4,0(s4)
ffffffffc0201442:	12098073          	sfence.vma	s3
ffffffffc0201446:	b759                	j	ffffffffc02013cc <page_insert+0x38>
ffffffffc0201448:	5571                	li	a0,-4
ffffffffc020144a:	bf79                	j	ffffffffc02013e8 <page_insert+0x54>
ffffffffc020144c:	8e3ff0ef          	jal	ra,ffffffffc0200d2e <pa2page.part.0>

ffffffffc0201450 <copy_range>:
ffffffffc0201450:	7159                	addi	sp,sp,-112
ffffffffc0201452:	00d667b3          	or	a5,a2,a3
ffffffffc0201456:	f486                	sd	ra,104(sp)
ffffffffc0201458:	f0a2                	sd	s0,96(sp)
ffffffffc020145a:	eca6                	sd	s1,88(sp)
ffffffffc020145c:	e8ca                	sd	s2,80(sp)
ffffffffc020145e:	e4ce                	sd	s3,72(sp)
ffffffffc0201460:	e0d2                	sd	s4,64(sp)
ffffffffc0201462:	fc56                	sd	s5,56(sp)
ffffffffc0201464:	f85a                	sd	s6,48(sp)
ffffffffc0201466:	f45e                	sd	s7,40(sp)
ffffffffc0201468:	f062                	sd	s8,32(sp)
ffffffffc020146a:	ec66                	sd	s9,24(sp)
ffffffffc020146c:	e86a                	sd	s10,16(sp)
ffffffffc020146e:	e46e                	sd	s11,8(sp)
ffffffffc0201470:	17d2                	slli	a5,a5,0x34
ffffffffc0201472:	1e079763          	bnez	a5,ffffffffc0201660 <copy_range+0x210>
ffffffffc0201476:	002007b7          	lui	a5,0x200
ffffffffc020147a:	8432                	mv	s0,a2
ffffffffc020147c:	16f66a63          	bltu	a2,a5,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc0201480:	8936                	mv	s2,a3
ffffffffc0201482:	16d67763          	bgeu	a2,a3,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc0201486:	4785                	li	a5,1
ffffffffc0201488:	07fe                	slli	a5,a5,0x1f
ffffffffc020148a:	16d7e363          	bltu	a5,a3,ffffffffc02015f0 <copy_range+0x1a0>
ffffffffc020148e:	5b7d                	li	s6,-1
ffffffffc0201490:	8aaa                	mv	s5,a0
ffffffffc0201492:	89ae                	mv	s3,a1
ffffffffc0201494:	6a05                	lui	s4,0x1
ffffffffc0201496:	00018c97          	auipc	s9,0x18
ffffffffc020149a:	042c8c93          	addi	s9,s9,66 # ffffffffc02194d8 <npage>
ffffffffc020149e:	00018c17          	auipc	s8,0x18
ffffffffc02014a2:	0b2c0c13          	addi	s8,s8,178 # ffffffffc0219550 <pages>
ffffffffc02014a6:	00080bb7          	lui	s7,0x80
ffffffffc02014aa:	00cb5b13          	srli	s6,s6,0xc
ffffffffc02014ae:	4601                	li	a2,0
ffffffffc02014b0:	85a2                	mv	a1,s0
ffffffffc02014b2:	854e                	mv	a0,s3
ffffffffc02014b4:	afbff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02014b8:	84aa                	mv	s1,a0
ffffffffc02014ba:	c175                	beqz	a0,ffffffffc020159e <copy_range+0x14e>
ffffffffc02014bc:	611c                	ld	a5,0(a0)
ffffffffc02014be:	8b85                	andi	a5,a5,1
ffffffffc02014c0:	e785                	bnez	a5,ffffffffc02014e8 <copy_range+0x98>
ffffffffc02014c2:	9452                	add	s0,s0,s4
ffffffffc02014c4:	ff2465e3          	bltu	s0,s2,ffffffffc02014ae <copy_range+0x5e>
ffffffffc02014c8:	4501                	li	a0,0
ffffffffc02014ca:	70a6                	ld	ra,104(sp)
ffffffffc02014cc:	7406                	ld	s0,96(sp)
ffffffffc02014ce:	64e6                	ld	s1,88(sp)
ffffffffc02014d0:	6946                	ld	s2,80(sp)
ffffffffc02014d2:	69a6                	ld	s3,72(sp)
ffffffffc02014d4:	6a06                	ld	s4,64(sp)
ffffffffc02014d6:	7ae2                	ld	s5,56(sp)
ffffffffc02014d8:	7b42                	ld	s6,48(sp)
ffffffffc02014da:	7ba2                	ld	s7,40(sp)
ffffffffc02014dc:	7c02                	ld	s8,32(sp)
ffffffffc02014de:	6ce2                	ld	s9,24(sp)
ffffffffc02014e0:	6d42                	ld	s10,16(sp)
ffffffffc02014e2:	6da2                	ld	s11,8(sp)
ffffffffc02014e4:	6165                	addi	sp,sp,112
ffffffffc02014e6:	8082                	ret
ffffffffc02014e8:	4605                	li	a2,1
ffffffffc02014ea:	85a2                	mv	a1,s0
ffffffffc02014ec:	8556                	mv	a0,s5
ffffffffc02014ee:	ac1ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02014f2:	c161                	beqz	a0,ffffffffc02015b2 <copy_range+0x162>
ffffffffc02014f4:	609c                	ld	a5,0(s1)
ffffffffc02014f6:	0017f713          	andi	a4,a5,1
ffffffffc02014fa:	01f7f493          	andi	s1,a5,31
ffffffffc02014fe:	14070563          	beqz	a4,ffffffffc0201648 <copy_range+0x1f8>
ffffffffc0201502:	000cb683          	ld	a3,0(s9)
ffffffffc0201506:	078a                	slli	a5,a5,0x2
ffffffffc0201508:	00c7d713          	srli	a4,a5,0xc
ffffffffc020150c:	12d77263          	bgeu	a4,a3,ffffffffc0201630 <copy_range+0x1e0>
ffffffffc0201510:	000c3783          	ld	a5,0(s8)
ffffffffc0201514:	fff806b7          	lui	a3,0xfff80
ffffffffc0201518:	9736                	add	a4,a4,a3
ffffffffc020151a:	071a                	slli	a4,a4,0x6
ffffffffc020151c:	4505                	li	a0,1
ffffffffc020151e:	00e78db3          	add	s11,a5,a4
ffffffffc0201522:	829ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0201526:	8d2a                	mv	s10,a0
ffffffffc0201528:	0a0d8463          	beqz	s11,ffffffffc02015d0 <copy_range+0x180>
ffffffffc020152c:	c175                	beqz	a0,ffffffffc0201610 <copy_range+0x1c0>
ffffffffc020152e:	000c3703          	ld	a4,0(s8)
ffffffffc0201532:	000cb603          	ld	a2,0(s9)
ffffffffc0201536:	40ed86b3          	sub	a3,s11,a4
ffffffffc020153a:	8699                	srai	a3,a3,0x6
ffffffffc020153c:	96de                	add	a3,a3,s7
ffffffffc020153e:	0166f7b3          	and	a5,a3,s6
ffffffffc0201542:	06b2                	slli	a3,a3,0xc
ffffffffc0201544:	06c7fa63          	bgeu	a5,a2,ffffffffc02015b8 <copy_range+0x168>
ffffffffc0201548:	40e507b3          	sub	a5,a0,a4
ffffffffc020154c:	00018717          	auipc	a4,0x18
ffffffffc0201550:	ff470713          	addi	a4,a4,-12 # ffffffffc0219540 <va_pa_offset>
ffffffffc0201554:	6308                	ld	a0,0(a4)
ffffffffc0201556:	8799                	srai	a5,a5,0x6
ffffffffc0201558:	97de                	add	a5,a5,s7
ffffffffc020155a:	0167f733          	and	a4,a5,s6
ffffffffc020155e:	00a685b3          	add	a1,a3,a0
ffffffffc0201562:	07b2                	slli	a5,a5,0xc
ffffffffc0201564:	04c77963          	bgeu	a4,a2,ffffffffc02015b6 <copy_range+0x166>
ffffffffc0201568:	6605                	lui	a2,0x1
ffffffffc020156a:	953e                	add	a0,a0,a5
ffffffffc020156c:	6fe060ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc0201570:	86a6                	mv	a3,s1
ffffffffc0201572:	8622                	mv	a2,s0
ffffffffc0201574:	85ea                	mv	a1,s10
ffffffffc0201576:	8556                	mv	a0,s5
ffffffffc0201578:	e1dff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc020157c:	d139                	beqz	a0,ffffffffc02014c2 <copy_range+0x72>
ffffffffc020157e:	00007697          	auipc	a3,0x7
ffffffffc0201582:	62268693          	addi	a3,a3,1570 # ffffffffc0208ba0 <commands+0x878>
ffffffffc0201586:	00007617          	auipc	a2,0x7
ffffffffc020158a:	1b260613          	addi	a2,a2,434 # ffffffffc0208738 <commands+0x410>
ffffffffc020158e:	19900593          	li	a1,409
ffffffffc0201592:	00007517          	auipc	a0,0x7
ffffffffc0201596:	54650513          	addi	a0,a0,1350 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020159a:	c6ffe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020159e:	00200637          	lui	a2,0x200
ffffffffc02015a2:	9432                	add	s0,s0,a2
ffffffffc02015a4:	ffe00637          	lui	a2,0xffe00
ffffffffc02015a8:	8c71                	and	s0,s0,a2
ffffffffc02015aa:	dc19                	beqz	s0,ffffffffc02014c8 <copy_range+0x78>
ffffffffc02015ac:	f12461e3          	bltu	s0,s2,ffffffffc02014ae <copy_range+0x5e>
ffffffffc02015b0:	bf21                	j	ffffffffc02014c8 <copy_range+0x78>
ffffffffc02015b2:	5571                	li	a0,-4
ffffffffc02015b4:	bf19                	j	ffffffffc02014ca <copy_range+0x7a>
ffffffffc02015b6:	86be                	mv	a3,a5
ffffffffc02015b8:	00007617          	auipc	a2,0x7
ffffffffc02015bc:	53060613          	addi	a2,a2,1328 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc02015c0:	06900593          	li	a1,105
ffffffffc02015c4:	00007517          	auipc	a0,0x7
ffffffffc02015c8:	48450513          	addi	a0,a0,1156 # ffffffffc0208a48 <commands+0x720>
ffffffffc02015cc:	c3dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015d0:	00007697          	auipc	a3,0x7
ffffffffc02015d4:	5b068693          	addi	a3,a3,1456 # ffffffffc0208b80 <commands+0x858>
ffffffffc02015d8:	00007617          	auipc	a2,0x7
ffffffffc02015dc:	16060613          	addi	a2,a2,352 # ffffffffc0208738 <commands+0x410>
ffffffffc02015e0:	17e00593          	li	a1,382
ffffffffc02015e4:	00007517          	auipc	a0,0x7
ffffffffc02015e8:	4f450513          	addi	a0,a0,1268 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc02015ec:	c1dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015f0:	00007697          	auipc	a3,0x7
ffffffffc02015f4:	55068693          	addi	a3,a3,1360 # ffffffffc0208b40 <commands+0x818>
ffffffffc02015f8:	00007617          	auipc	a2,0x7
ffffffffc02015fc:	14060613          	addi	a2,a2,320 # ffffffffc0208738 <commands+0x410>
ffffffffc0201600:	16a00593          	li	a1,362
ffffffffc0201604:	00007517          	auipc	a0,0x7
ffffffffc0201608:	4d450513          	addi	a0,a0,1236 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020160c:	bfdfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201610:	00007697          	auipc	a3,0x7
ffffffffc0201614:	58068693          	addi	a3,a3,1408 # ffffffffc0208b90 <commands+0x868>
ffffffffc0201618:	00007617          	auipc	a2,0x7
ffffffffc020161c:	12060613          	addi	a2,a2,288 # ffffffffc0208738 <commands+0x410>
ffffffffc0201620:	17f00593          	li	a1,383
ffffffffc0201624:	00007517          	auipc	a0,0x7
ffffffffc0201628:	4b450513          	addi	a0,a0,1204 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020162c:	bddfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201630:	00007617          	auipc	a2,0x7
ffffffffc0201634:	3f860613          	addi	a2,a2,1016 # ffffffffc0208a28 <commands+0x700>
ffffffffc0201638:	06200593          	li	a1,98
ffffffffc020163c:	00007517          	auipc	a0,0x7
ffffffffc0201640:	40c50513          	addi	a0,a0,1036 # ffffffffc0208a48 <commands+0x720>
ffffffffc0201644:	bc5fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201648:	00007617          	auipc	a2,0x7
ffffffffc020164c:	51060613          	addi	a2,a2,1296 # ffffffffc0208b58 <commands+0x830>
ffffffffc0201650:	07400593          	li	a1,116
ffffffffc0201654:	00007517          	auipc	a0,0x7
ffffffffc0201658:	3f450513          	addi	a0,a0,1012 # ffffffffc0208a48 <commands+0x720>
ffffffffc020165c:	badfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201660:	00007697          	auipc	a3,0x7
ffffffffc0201664:	4b068693          	addi	a3,a3,1200 # ffffffffc0208b10 <commands+0x7e8>
ffffffffc0201668:	00007617          	auipc	a2,0x7
ffffffffc020166c:	0d060613          	addi	a2,a2,208 # ffffffffc0208738 <commands+0x410>
ffffffffc0201670:	16900593          	li	a1,361
ffffffffc0201674:	00007517          	auipc	a0,0x7
ffffffffc0201678:	46450513          	addi	a0,a0,1124 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc020167c:	b8dfe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201680 <tlb_invalidate>:
ffffffffc0201680:	12058073          	sfence.vma	a1
ffffffffc0201684:	8082                	ret

ffffffffc0201686 <pgdir_alloc_page>:
ffffffffc0201686:	7179                	addi	sp,sp,-48
ffffffffc0201688:	e84a                	sd	s2,16(sp)
ffffffffc020168a:	892a                	mv	s2,a0
ffffffffc020168c:	4505                	li	a0,1
ffffffffc020168e:	f022                	sd	s0,32(sp)
ffffffffc0201690:	ec26                	sd	s1,24(sp)
ffffffffc0201692:	e44e                	sd	s3,8(sp)
ffffffffc0201694:	f406                	sd	ra,40(sp)
ffffffffc0201696:	84ae                	mv	s1,a1
ffffffffc0201698:	89b2                	mv	s3,a2
ffffffffc020169a:	eb0ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020169e:	842a                	mv	s0,a0
ffffffffc02016a0:	cd05                	beqz	a0,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016a2:	85aa                	mv	a1,a0
ffffffffc02016a4:	86ce                	mv	a3,s3
ffffffffc02016a6:	8626                	mv	a2,s1
ffffffffc02016a8:	854a                	mv	a0,s2
ffffffffc02016aa:	cebff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc02016ae:	ed0d                	bnez	a0,ffffffffc02016e8 <pgdir_alloc_page+0x62>
ffffffffc02016b0:	00018797          	auipc	a5,0x18
ffffffffc02016b4:	e487a783          	lw	a5,-440(a5) # ffffffffc02194f8 <swap_init_ok>
ffffffffc02016b8:	c385                	beqz	a5,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016ba:	00018517          	auipc	a0,0x18
ffffffffc02016be:	eae53503          	ld	a0,-338(a0) # ffffffffc0219568 <check_mm_struct>
ffffffffc02016c2:	c919                	beqz	a0,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016c4:	4681                	li	a3,0
ffffffffc02016c6:	8622                	mv	a2,s0
ffffffffc02016c8:	85a6                	mv	a1,s1
ffffffffc02016ca:	59d000ef          	jal	ra,ffffffffc0202466 <swap_map_swappable>
ffffffffc02016ce:	4018                	lw	a4,0(s0)
ffffffffc02016d0:	fc04                	sd	s1,56(s0)
ffffffffc02016d2:	4785                	li	a5,1
ffffffffc02016d4:	02f71063          	bne	a4,a5,ffffffffc02016f4 <pgdir_alloc_page+0x6e>
ffffffffc02016d8:	70a2                	ld	ra,40(sp)
ffffffffc02016da:	8522                	mv	a0,s0
ffffffffc02016dc:	7402                	ld	s0,32(sp)
ffffffffc02016de:	64e2                	ld	s1,24(sp)
ffffffffc02016e0:	6942                	ld	s2,16(sp)
ffffffffc02016e2:	69a2                	ld	s3,8(sp)
ffffffffc02016e4:	6145                	addi	sp,sp,48
ffffffffc02016e6:	8082                	ret
ffffffffc02016e8:	8522                	mv	a0,s0
ffffffffc02016ea:	4585                	li	a1,1
ffffffffc02016ec:	ef0ff0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02016f0:	4401                	li	s0,0
ffffffffc02016f2:	b7dd                	j	ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016f4:	00007697          	auipc	a3,0x7
ffffffffc02016f8:	4bc68693          	addi	a3,a3,1212 # ffffffffc0208bb0 <commands+0x888>
ffffffffc02016fc:	00007617          	auipc	a2,0x7
ffffffffc0201700:	03c60613          	addi	a2,a2,60 # ffffffffc0208738 <commands+0x410>
ffffffffc0201704:	1d800593          	li	a1,472
ffffffffc0201708:	00007517          	auipc	a0,0x7
ffffffffc020170c:	3d050513          	addi	a0,a0,976 # ffffffffc0208ad8 <commands+0x7b0>
ffffffffc0201710:	af9fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201714 <_fifo_init_mm>:
ffffffffc0201714:	00018797          	auipc	a5,0x18
ffffffffc0201718:	e4478793          	addi	a5,a5,-444 # ffffffffc0219558 <pra_list_head>
ffffffffc020171c:	f51c                	sd	a5,40(a0)
ffffffffc020171e:	e79c                	sd	a5,8(a5)
ffffffffc0201720:	e39c                	sd	a5,0(a5)
ffffffffc0201722:	4501                	li	a0,0
ffffffffc0201724:	8082                	ret

ffffffffc0201726 <_fifo_init>:
ffffffffc0201726:	4501                	li	a0,0
ffffffffc0201728:	8082                	ret

ffffffffc020172a <_fifo_set_unswappable>:
ffffffffc020172a:	4501                	li	a0,0
ffffffffc020172c:	8082                	ret

ffffffffc020172e <_fifo_tick_event>:
ffffffffc020172e:	4501                	li	a0,0
ffffffffc0201730:	8082                	ret

ffffffffc0201732 <_fifo_check_swap>:
ffffffffc0201732:	711d                	addi	sp,sp,-96
ffffffffc0201734:	fc4e                	sd	s3,56(sp)
ffffffffc0201736:	f852                	sd	s4,48(sp)
ffffffffc0201738:	00007517          	auipc	a0,0x7
ffffffffc020173c:	49050513          	addi	a0,a0,1168 # ffffffffc0208bc8 <commands+0x8a0>
ffffffffc0201740:	698d                	lui	s3,0x3
ffffffffc0201742:	4a31                	li	s4,12
ffffffffc0201744:	e0ca                	sd	s2,64(sp)
ffffffffc0201746:	ec86                	sd	ra,88(sp)
ffffffffc0201748:	e8a2                	sd	s0,80(sp)
ffffffffc020174a:	e4a6                	sd	s1,72(sp)
ffffffffc020174c:	f456                	sd	s5,40(sp)
ffffffffc020174e:	f05a                	sd	s6,32(sp)
ffffffffc0201750:	ec5e                	sd	s7,24(sp)
ffffffffc0201752:	e862                	sd	s8,16(sp)
ffffffffc0201754:	e466                	sd	s9,8(sp)
ffffffffc0201756:	e06a                	sd	s10,0(sp)
ffffffffc0201758:	975fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020175c:	01498023          	sb	s4,0(s3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc0201760:	00018917          	auipc	s2,0x18
ffffffffc0201764:	d8092903          	lw	s2,-640(s2) # ffffffffc02194e0 <pgfault_num>
ffffffffc0201768:	4791                	li	a5,4
ffffffffc020176a:	14f91e63          	bne	s2,a5,ffffffffc02018c6 <_fifo_check_swap+0x194>
ffffffffc020176e:	00007517          	auipc	a0,0x7
ffffffffc0201772:	4aa50513          	addi	a0,a0,1194 # ffffffffc0208c18 <commands+0x8f0>
ffffffffc0201776:	6a85                	lui	s5,0x1
ffffffffc0201778:	4b29                	li	s6,10
ffffffffc020177a:	953fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020177e:	00018417          	auipc	s0,0x18
ffffffffc0201782:	d6240413          	addi	s0,s0,-670 # ffffffffc02194e0 <pgfault_num>
ffffffffc0201786:	016a8023          	sb	s6,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020178a:	4004                	lw	s1,0(s0)
ffffffffc020178c:	2481                	sext.w	s1,s1
ffffffffc020178e:	2b249c63          	bne	s1,s2,ffffffffc0201a46 <_fifo_check_swap+0x314>
ffffffffc0201792:	00007517          	auipc	a0,0x7
ffffffffc0201796:	4ae50513          	addi	a0,a0,1198 # ffffffffc0208c40 <commands+0x918>
ffffffffc020179a:	6b91                	lui	s7,0x4
ffffffffc020179c:	4c35                	li	s8,13
ffffffffc020179e:	92ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017a2:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02017a6:	00042903          	lw	s2,0(s0)
ffffffffc02017aa:	2901                	sext.w	s2,s2
ffffffffc02017ac:	26991d63          	bne	s2,s1,ffffffffc0201a26 <_fifo_check_swap+0x2f4>
ffffffffc02017b0:	00007517          	auipc	a0,0x7
ffffffffc02017b4:	4b850513          	addi	a0,a0,1208 # ffffffffc0208c68 <commands+0x940>
ffffffffc02017b8:	6c89                	lui	s9,0x2
ffffffffc02017ba:	4d2d                	li	s10,11
ffffffffc02017bc:	911fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017c0:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02017c4:	401c                	lw	a5,0(s0)
ffffffffc02017c6:	2781                	sext.w	a5,a5
ffffffffc02017c8:	23279f63          	bne	a5,s2,ffffffffc0201a06 <_fifo_check_swap+0x2d4>
ffffffffc02017cc:	00007517          	auipc	a0,0x7
ffffffffc02017d0:	4c450513          	addi	a0,a0,1220 # ffffffffc0208c90 <commands+0x968>
ffffffffc02017d4:	8f9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017d8:	6795                	lui	a5,0x5
ffffffffc02017da:	4739                	li	a4,14
ffffffffc02017dc:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02017e0:	4004                	lw	s1,0(s0)
ffffffffc02017e2:	4795                	li	a5,5
ffffffffc02017e4:	2481                	sext.w	s1,s1
ffffffffc02017e6:	20f49063          	bne	s1,a5,ffffffffc02019e6 <_fifo_check_swap+0x2b4>
ffffffffc02017ea:	00007517          	auipc	a0,0x7
ffffffffc02017ee:	47e50513          	addi	a0,a0,1150 # ffffffffc0208c68 <commands+0x940>
ffffffffc02017f2:	8dbfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017f6:	01ac8023          	sb	s10,0(s9)
ffffffffc02017fa:	401c                	lw	a5,0(s0)
ffffffffc02017fc:	2781                	sext.w	a5,a5
ffffffffc02017fe:	1c979463          	bne	a5,s1,ffffffffc02019c6 <_fifo_check_swap+0x294>
ffffffffc0201802:	00007517          	auipc	a0,0x7
ffffffffc0201806:	41650513          	addi	a0,a0,1046 # ffffffffc0208c18 <commands+0x8f0>
ffffffffc020180a:	8c3fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020180e:	016a8023          	sb	s6,0(s5)
ffffffffc0201812:	401c                	lw	a5,0(s0)
ffffffffc0201814:	4719                	li	a4,6
ffffffffc0201816:	2781                	sext.w	a5,a5
ffffffffc0201818:	18e79763          	bne	a5,a4,ffffffffc02019a6 <_fifo_check_swap+0x274>
ffffffffc020181c:	00007517          	auipc	a0,0x7
ffffffffc0201820:	44c50513          	addi	a0,a0,1100 # ffffffffc0208c68 <commands+0x940>
ffffffffc0201824:	8a9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201828:	01ac8023          	sb	s10,0(s9)
ffffffffc020182c:	401c                	lw	a5,0(s0)
ffffffffc020182e:	471d                	li	a4,7
ffffffffc0201830:	2781                	sext.w	a5,a5
ffffffffc0201832:	14e79a63          	bne	a5,a4,ffffffffc0201986 <_fifo_check_swap+0x254>
ffffffffc0201836:	00007517          	auipc	a0,0x7
ffffffffc020183a:	39250513          	addi	a0,a0,914 # ffffffffc0208bc8 <commands+0x8a0>
ffffffffc020183e:	88ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201842:	01498023          	sb	s4,0(s3)
ffffffffc0201846:	401c                	lw	a5,0(s0)
ffffffffc0201848:	4721                	li	a4,8
ffffffffc020184a:	2781                	sext.w	a5,a5
ffffffffc020184c:	10e79d63          	bne	a5,a4,ffffffffc0201966 <_fifo_check_swap+0x234>
ffffffffc0201850:	00007517          	auipc	a0,0x7
ffffffffc0201854:	3f050513          	addi	a0,a0,1008 # ffffffffc0208c40 <commands+0x918>
ffffffffc0201858:	875fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020185c:	018b8023          	sb	s8,0(s7)
ffffffffc0201860:	401c                	lw	a5,0(s0)
ffffffffc0201862:	4725                	li	a4,9
ffffffffc0201864:	2781                	sext.w	a5,a5
ffffffffc0201866:	0ee79063          	bne	a5,a4,ffffffffc0201946 <_fifo_check_swap+0x214>
ffffffffc020186a:	00007517          	auipc	a0,0x7
ffffffffc020186e:	42650513          	addi	a0,a0,1062 # ffffffffc0208c90 <commands+0x968>
ffffffffc0201872:	85bfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201876:	6795                	lui	a5,0x5
ffffffffc0201878:	4739                	li	a4,14
ffffffffc020187a:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc020187e:	4004                	lw	s1,0(s0)
ffffffffc0201880:	47a9                	li	a5,10
ffffffffc0201882:	2481                	sext.w	s1,s1
ffffffffc0201884:	0af49163          	bne	s1,a5,ffffffffc0201926 <_fifo_check_swap+0x1f4>
ffffffffc0201888:	00007517          	auipc	a0,0x7
ffffffffc020188c:	39050513          	addi	a0,a0,912 # ffffffffc0208c18 <commands+0x8f0>
ffffffffc0201890:	83dfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201894:	6785                	lui	a5,0x1
ffffffffc0201896:	0007c783          	lbu	a5,0(a5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020189a:	06979663          	bne	a5,s1,ffffffffc0201906 <_fifo_check_swap+0x1d4>
ffffffffc020189e:	401c                	lw	a5,0(s0)
ffffffffc02018a0:	472d                	li	a4,11
ffffffffc02018a2:	2781                	sext.w	a5,a5
ffffffffc02018a4:	04e79163          	bne	a5,a4,ffffffffc02018e6 <_fifo_check_swap+0x1b4>
ffffffffc02018a8:	60e6                	ld	ra,88(sp)
ffffffffc02018aa:	6446                	ld	s0,80(sp)
ffffffffc02018ac:	64a6                	ld	s1,72(sp)
ffffffffc02018ae:	6906                	ld	s2,64(sp)
ffffffffc02018b0:	79e2                	ld	s3,56(sp)
ffffffffc02018b2:	7a42                	ld	s4,48(sp)
ffffffffc02018b4:	7aa2                	ld	s5,40(sp)
ffffffffc02018b6:	7b02                	ld	s6,32(sp)
ffffffffc02018b8:	6be2                	ld	s7,24(sp)
ffffffffc02018ba:	6c42                	ld	s8,16(sp)
ffffffffc02018bc:	6ca2                	ld	s9,8(sp)
ffffffffc02018be:	6d02                	ld	s10,0(sp)
ffffffffc02018c0:	4501                	li	a0,0
ffffffffc02018c2:	6125                	addi	sp,sp,96
ffffffffc02018c4:	8082                	ret
ffffffffc02018c6:	00007697          	auipc	a3,0x7
ffffffffc02018ca:	32a68693          	addi	a3,a3,810 # ffffffffc0208bf0 <commands+0x8c8>
ffffffffc02018ce:	00007617          	auipc	a2,0x7
ffffffffc02018d2:	e6a60613          	addi	a2,a2,-406 # ffffffffc0208738 <commands+0x410>
ffffffffc02018d6:	05100593          	li	a1,81
ffffffffc02018da:	00007517          	auipc	a0,0x7
ffffffffc02018de:	32650513          	addi	a0,a0,806 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc02018e2:	927fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02018e6:	00007697          	auipc	a3,0x7
ffffffffc02018ea:	45a68693          	addi	a3,a3,1114 # ffffffffc0208d40 <commands+0xa18>
ffffffffc02018ee:	00007617          	auipc	a2,0x7
ffffffffc02018f2:	e4a60613          	addi	a2,a2,-438 # ffffffffc0208738 <commands+0x410>
ffffffffc02018f6:	07300593          	li	a1,115
ffffffffc02018fa:	00007517          	auipc	a0,0x7
ffffffffc02018fe:	30650513          	addi	a0,a0,774 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201902:	907fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201906:	00007697          	auipc	a3,0x7
ffffffffc020190a:	41268693          	addi	a3,a3,1042 # ffffffffc0208d18 <commands+0x9f0>
ffffffffc020190e:	00007617          	auipc	a2,0x7
ffffffffc0201912:	e2a60613          	addi	a2,a2,-470 # ffffffffc0208738 <commands+0x410>
ffffffffc0201916:	07100593          	li	a1,113
ffffffffc020191a:	00007517          	auipc	a0,0x7
ffffffffc020191e:	2e650513          	addi	a0,a0,742 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201922:	8e7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201926:	00007697          	auipc	a3,0x7
ffffffffc020192a:	3e268693          	addi	a3,a3,994 # ffffffffc0208d08 <commands+0x9e0>
ffffffffc020192e:	00007617          	auipc	a2,0x7
ffffffffc0201932:	e0a60613          	addi	a2,a2,-502 # ffffffffc0208738 <commands+0x410>
ffffffffc0201936:	06f00593          	li	a1,111
ffffffffc020193a:	00007517          	auipc	a0,0x7
ffffffffc020193e:	2c650513          	addi	a0,a0,710 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201942:	8c7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201946:	00007697          	auipc	a3,0x7
ffffffffc020194a:	3b268693          	addi	a3,a3,946 # ffffffffc0208cf8 <commands+0x9d0>
ffffffffc020194e:	00007617          	auipc	a2,0x7
ffffffffc0201952:	dea60613          	addi	a2,a2,-534 # ffffffffc0208738 <commands+0x410>
ffffffffc0201956:	06c00593          	li	a1,108
ffffffffc020195a:	00007517          	auipc	a0,0x7
ffffffffc020195e:	2a650513          	addi	a0,a0,678 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201962:	8a7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201966:	00007697          	auipc	a3,0x7
ffffffffc020196a:	38268693          	addi	a3,a3,898 # ffffffffc0208ce8 <commands+0x9c0>
ffffffffc020196e:	00007617          	auipc	a2,0x7
ffffffffc0201972:	dca60613          	addi	a2,a2,-566 # ffffffffc0208738 <commands+0x410>
ffffffffc0201976:	06900593          	li	a1,105
ffffffffc020197a:	00007517          	auipc	a0,0x7
ffffffffc020197e:	28650513          	addi	a0,a0,646 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201982:	887fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201986:	00007697          	auipc	a3,0x7
ffffffffc020198a:	35268693          	addi	a3,a3,850 # ffffffffc0208cd8 <commands+0x9b0>
ffffffffc020198e:	00007617          	auipc	a2,0x7
ffffffffc0201992:	daa60613          	addi	a2,a2,-598 # ffffffffc0208738 <commands+0x410>
ffffffffc0201996:	06600593          	li	a1,102
ffffffffc020199a:	00007517          	auipc	a0,0x7
ffffffffc020199e:	26650513          	addi	a0,a0,614 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc02019a2:	867fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019a6:	00007697          	auipc	a3,0x7
ffffffffc02019aa:	32268693          	addi	a3,a3,802 # ffffffffc0208cc8 <commands+0x9a0>
ffffffffc02019ae:	00007617          	auipc	a2,0x7
ffffffffc02019b2:	d8a60613          	addi	a2,a2,-630 # ffffffffc0208738 <commands+0x410>
ffffffffc02019b6:	06300593          	li	a1,99
ffffffffc02019ba:	00007517          	auipc	a0,0x7
ffffffffc02019be:	24650513          	addi	a0,a0,582 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc02019c2:	847fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019c6:	00007697          	auipc	a3,0x7
ffffffffc02019ca:	2f268693          	addi	a3,a3,754 # ffffffffc0208cb8 <commands+0x990>
ffffffffc02019ce:	00007617          	auipc	a2,0x7
ffffffffc02019d2:	d6a60613          	addi	a2,a2,-662 # ffffffffc0208738 <commands+0x410>
ffffffffc02019d6:	06000593          	li	a1,96
ffffffffc02019da:	00007517          	auipc	a0,0x7
ffffffffc02019de:	22650513          	addi	a0,a0,550 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc02019e2:	827fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019e6:	00007697          	auipc	a3,0x7
ffffffffc02019ea:	2d268693          	addi	a3,a3,722 # ffffffffc0208cb8 <commands+0x990>
ffffffffc02019ee:	00007617          	auipc	a2,0x7
ffffffffc02019f2:	d4a60613          	addi	a2,a2,-694 # ffffffffc0208738 <commands+0x410>
ffffffffc02019f6:	05d00593          	li	a1,93
ffffffffc02019fa:	00007517          	auipc	a0,0x7
ffffffffc02019fe:	20650513          	addi	a0,a0,518 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201a02:	807fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a06:	00007697          	auipc	a3,0x7
ffffffffc0201a0a:	1ea68693          	addi	a3,a3,490 # ffffffffc0208bf0 <commands+0x8c8>
ffffffffc0201a0e:	00007617          	auipc	a2,0x7
ffffffffc0201a12:	d2a60613          	addi	a2,a2,-726 # ffffffffc0208738 <commands+0x410>
ffffffffc0201a16:	05a00593          	li	a1,90
ffffffffc0201a1a:	00007517          	auipc	a0,0x7
ffffffffc0201a1e:	1e650513          	addi	a0,a0,486 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201a22:	fe6fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a26:	00007697          	auipc	a3,0x7
ffffffffc0201a2a:	1ca68693          	addi	a3,a3,458 # ffffffffc0208bf0 <commands+0x8c8>
ffffffffc0201a2e:	00007617          	auipc	a2,0x7
ffffffffc0201a32:	d0a60613          	addi	a2,a2,-758 # ffffffffc0208738 <commands+0x410>
ffffffffc0201a36:	05700593          	li	a1,87
ffffffffc0201a3a:	00007517          	auipc	a0,0x7
ffffffffc0201a3e:	1c650513          	addi	a0,a0,454 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201a42:	fc6fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a46:	00007697          	auipc	a3,0x7
ffffffffc0201a4a:	1aa68693          	addi	a3,a3,426 # ffffffffc0208bf0 <commands+0x8c8>
ffffffffc0201a4e:	00007617          	auipc	a2,0x7
ffffffffc0201a52:	cea60613          	addi	a2,a2,-790 # ffffffffc0208738 <commands+0x410>
ffffffffc0201a56:	05400593          	li	a1,84
ffffffffc0201a5a:	00007517          	auipc	a0,0x7
ffffffffc0201a5e:	1a650513          	addi	a0,a0,422 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201a62:	fa6fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201a66 <_fifo_swap_out_victim>:
ffffffffc0201a66:	751c                	ld	a5,40(a0)
ffffffffc0201a68:	1141                	addi	sp,sp,-16
ffffffffc0201a6a:	e406                	sd	ra,8(sp)
ffffffffc0201a6c:	cf91                	beqz	a5,ffffffffc0201a88 <_fifo_swap_out_victim+0x22>
ffffffffc0201a6e:	ee0d                	bnez	a2,ffffffffc0201aa8 <_fifo_swap_out_victim+0x42>
ffffffffc0201a70:	679c                	ld	a5,8(a5)
ffffffffc0201a72:	60a2                	ld	ra,8(sp)
ffffffffc0201a74:	4501                	li	a0,0
ffffffffc0201a76:	6394                	ld	a3,0(a5)
ffffffffc0201a78:	6798                	ld	a4,8(a5)
ffffffffc0201a7a:	fd878793          	addi	a5,a5,-40
ffffffffc0201a7e:	e698                	sd	a4,8(a3)
ffffffffc0201a80:	e314                	sd	a3,0(a4)
ffffffffc0201a82:	e19c                	sd	a5,0(a1)
ffffffffc0201a84:	0141                	addi	sp,sp,16
ffffffffc0201a86:	8082                	ret
ffffffffc0201a88:	00007697          	auipc	a3,0x7
ffffffffc0201a8c:	2c868693          	addi	a3,a3,712 # ffffffffc0208d50 <commands+0xa28>
ffffffffc0201a90:	00007617          	auipc	a2,0x7
ffffffffc0201a94:	ca860613          	addi	a2,a2,-856 # ffffffffc0208738 <commands+0x410>
ffffffffc0201a98:	04100593          	li	a1,65
ffffffffc0201a9c:	00007517          	auipc	a0,0x7
ffffffffc0201aa0:	16450513          	addi	a0,a0,356 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201aa4:	f64fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201aa8:	00007697          	auipc	a3,0x7
ffffffffc0201aac:	2b868693          	addi	a3,a3,696 # ffffffffc0208d60 <commands+0xa38>
ffffffffc0201ab0:	00007617          	auipc	a2,0x7
ffffffffc0201ab4:	c8860613          	addi	a2,a2,-888 # ffffffffc0208738 <commands+0x410>
ffffffffc0201ab8:	04200593          	li	a1,66
ffffffffc0201abc:	00007517          	auipc	a0,0x7
ffffffffc0201ac0:	14450513          	addi	a0,a0,324 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201ac4:	f44fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201ac8 <_fifo_map_swappable>:
ffffffffc0201ac8:	751c                	ld	a5,40(a0)
ffffffffc0201aca:	cb91                	beqz	a5,ffffffffc0201ade <_fifo_map_swappable+0x16>
ffffffffc0201acc:	6394                	ld	a3,0(a5)
ffffffffc0201ace:	02860713          	addi	a4,a2,40
ffffffffc0201ad2:	e398                	sd	a4,0(a5)
ffffffffc0201ad4:	e698                	sd	a4,8(a3)
ffffffffc0201ad6:	4501                	li	a0,0
ffffffffc0201ad8:	fa1c                	sd	a5,48(a2)
ffffffffc0201ada:	f614                	sd	a3,40(a2)
ffffffffc0201adc:	8082                	ret
ffffffffc0201ade:	1141                	addi	sp,sp,-16
ffffffffc0201ae0:	00007697          	auipc	a3,0x7
ffffffffc0201ae4:	29068693          	addi	a3,a3,656 # ffffffffc0208d70 <commands+0xa48>
ffffffffc0201ae8:	00007617          	auipc	a2,0x7
ffffffffc0201aec:	c5060613          	addi	a2,a2,-944 # ffffffffc0208738 <commands+0x410>
ffffffffc0201af0:	03200593          	li	a1,50
ffffffffc0201af4:	00007517          	auipc	a0,0x7
ffffffffc0201af8:	10c50513          	addi	a0,a0,268 # ffffffffc0208c00 <commands+0x8d8>
ffffffffc0201afc:	e406                	sd	ra,8(sp)
ffffffffc0201afe:	f0afe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201b02 <check_vma_overlap.isra.0.part.0>:
ffffffffc0201b02:	1141                	addi	sp,sp,-16
ffffffffc0201b04:	00007697          	auipc	a3,0x7
ffffffffc0201b08:	2a468693          	addi	a3,a3,676 # ffffffffc0208da8 <commands+0xa80>
ffffffffc0201b0c:	00007617          	auipc	a2,0x7
ffffffffc0201b10:	c2c60613          	addi	a2,a2,-980 # ffffffffc0208738 <commands+0x410>
ffffffffc0201b14:	06d00593          	li	a1,109
ffffffffc0201b18:	00007517          	auipc	a0,0x7
ffffffffc0201b1c:	2b050513          	addi	a0,a0,688 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201b20:	e406                	sd	ra,8(sp)
ffffffffc0201b22:	ee6fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201b26 <mm_create>:
ffffffffc0201b26:	1141                	addi	sp,sp,-16
ffffffffc0201b28:	05800513          	li	a0,88
ffffffffc0201b2c:	e022                	sd	s0,0(sp)
ffffffffc0201b2e:	e406                	sd	ra,8(sp)
ffffffffc0201b30:	6fc000ef          	jal	ra,ffffffffc020222c <kmalloc>
ffffffffc0201b34:	842a                	mv	s0,a0
ffffffffc0201b36:	c51d                	beqz	a0,ffffffffc0201b64 <mm_create+0x3e>
ffffffffc0201b38:	e408                	sd	a0,8(s0)
ffffffffc0201b3a:	e008                	sd	a0,0(s0)
ffffffffc0201b3c:	00053823          	sd	zero,16(a0)
ffffffffc0201b40:	00053c23          	sd	zero,24(a0)
ffffffffc0201b44:	02052023          	sw	zero,32(a0)
ffffffffc0201b48:	00018797          	auipc	a5,0x18
ffffffffc0201b4c:	9b07a783          	lw	a5,-1616(a5) # ffffffffc02194f8 <swap_init_ok>
ffffffffc0201b50:	ef99                	bnez	a5,ffffffffc0201b6e <mm_create+0x48>
ffffffffc0201b52:	02053423          	sd	zero,40(a0)
ffffffffc0201b56:	02042823          	sw	zero,48(s0)
ffffffffc0201b5a:	4585                	li	a1,1
ffffffffc0201b5c:	03840513          	addi	a0,s0,56
ffffffffc0201b60:	2bb010ef          	jal	ra,ffffffffc020361a <sem_init>
ffffffffc0201b64:	60a2                	ld	ra,8(sp)
ffffffffc0201b66:	8522                	mv	a0,s0
ffffffffc0201b68:	6402                	ld	s0,0(sp)
ffffffffc0201b6a:	0141                	addi	sp,sp,16
ffffffffc0201b6c:	8082                	ret
ffffffffc0201b6e:	0eb000ef          	jal	ra,ffffffffc0202458 <swap_init_mm>
ffffffffc0201b72:	b7d5                	j	ffffffffc0201b56 <mm_create+0x30>

ffffffffc0201b74 <find_vma>:
ffffffffc0201b74:	86aa                	mv	a3,a0
ffffffffc0201b76:	c505                	beqz	a0,ffffffffc0201b9e <find_vma+0x2a>
ffffffffc0201b78:	6908                	ld	a0,16(a0)
ffffffffc0201b7a:	c501                	beqz	a0,ffffffffc0201b82 <find_vma+0xe>
ffffffffc0201b7c:	651c                	ld	a5,8(a0)
ffffffffc0201b7e:	02f5f263          	bgeu	a1,a5,ffffffffc0201ba2 <find_vma+0x2e>
ffffffffc0201b82:	669c                	ld	a5,8(a3)
ffffffffc0201b84:	00f68d63          	beq	a3,a5,ffffffffc0201b9e <find_vma+0x2a>
ffffffffc0201b88:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201b8c:	00e5e663          	bltu	a1,a4,ffffffffc0201b98 <find_vma+0x24>
ffffffffc0201b90:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201b94:	00e5ec63          	bltu	a1,a4,ffffffffc0201bac <find_vma+0x38>
ffffffffc0201b98:	679c                	ld	a5,8(a5)
ffffffffc0201b9a:	fef697e3          	bne	a3,a5,ffffffffc0201b88 <find_vma+0x14>
ffffffffc0201b9e:	4501                	li	a0,0
ffffffffc0201ba0:	8082                	ret
ffffffffc0201ba2:	691c                	ld	a5,16(a0)
ffffffffc0201ba4:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201b82 <find_vma+0xe>
ffffffffc0201ba8:	ea88                	sd	a0,16(a3)
ffffffffc0201baa:	8082                	ret
ffffffffc0201bac:	fe078513          	addi	a0,a5,-32
ffffffffc0201bb0:	ea88                	sd	a0,16(a3)
ffffffffc0201bb2:	8082                	ret

ffffffffc0201bb4 <insert_vma_struct>:
ffffffffc0201bb4:	6590                	ld	a2,8(a1)
ffffffffc0201bb6:	0105b803          	ld	a6,16(a1)
ffffffffc0201bba:	1141                	addi	sp,sp,-16
ffffffffc0201bbc:	e406                	sd	ra,8(sp)
ffffffffc0201bbe:	87aa                	mv	a5,a0
ffffffffc0201bc0:	01066763          	bltu	a2,a6,ffffffffc0201bce <insert_vma_struct+0x1a>
ffffffffc0201bc4:	a085                	j	ffffffffc0201c24 <insert_vma_struct+0x70>
ffffffffc0201bc6:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201bca:	04e66863          	bltu	a2,a4,ffffffffc0201c1a <insert_vma_struct+0x66>
ffffffffc0201bce:	86be                	mv	a3,a5
ffffffffc0201bd0:	679c                	ld	a5,8(a5)
ffffffffc0201bd2:	fef51ae3          	bne	a0,a5,ffffffffc0201bc6 <insert_vma_struct+0x12>
ffffffffc0201bd6:	02a68463          	beq	a3,a0,ffffffffc0201bfe <insert_vma_struct+0x4a>
ffffffffc0201bda:	ff06b703          	ld	a4,-16(a3)
ffffffffc0201bde:	fe86b883          	ld	a7,-24(a3)
ffffffffc0201be2:	08e8f163          	bgeu	a7,a4,ffffffffc0201c64 <insert_vma_struct+0xb0>
ffffffffc0201be6:	04e66f63          	bltu	a2,a4,ffffffffc0201c44 <insert_vma_struct+0x90>
ffffffffc0201bea:	00f50a63          	beq	a0,a5,ffffffffc0201bfe <insert_vma_struct+0x4a>
ffffffffc0201bee:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201bf2:	05076963          	bltu	a4,a6,ffffffffc0201c44 <insert_vma_struct+0x90>
ffffffffc0201bf6:	ff07b603          	ld	a2,-16(a5)
ffffffffc0201bfa:	02c77363          	bgeu	a4,a2,ffffffffc0201c20 <insert_vma_struct+0x6c>
ffffffffc0201bfe:	5118                	lw	a4,32(a0)
ffffffffc0201c00:	e188                	sd	a0,0(a1)
ffffffffc0201c02:	02058613          	addi	a2,a1,32
ffffffffc0201c06:	e390                	sd	a2,0(a5)
ffffffffc0201c08:	e690                	sd	a2,8(a3)
ffffffffc0201c0a:	60a2                	ld	ra,8(sp)
ffffffffc0201c0c:	f59c                	sd	a5,40(a1)
ffffffffc0201c0e:	f194                	sd	a3,32(a1)
ffffffffc0201c10:	0017079b          	addiw	a5,a4,1
ffffffffc0201c14:	d11c                	sw	a5,32(a0)
ffffffffc0201c16:	0141                	addi	sp,sp,16
ffffffffc0201c18:	8082                	ret
ffffffffc0201c1a:	fca690e3          	bne	a3,a0,ffffffffc0201bda <insert_vma_struct+0x26>
ffffffffc0201c1e:	bfd1                	j	ffffffffc0201bf2 <insert_vma_struct+0x3e>
ffffffffc0201c20:	ee3ff0ef          	jal	ra,ffffffffc0201b02 <check_vma_overlap.isra.0.part.0>
ffffffffc0201c24:	00007697          	auipc	a3,0x7
ffffffffc0201c28:	1b468693          	addi	a3,a3,436 # ffffffffc0208dd8 <commands+0xab0>
ffffffffc0201c2c:	00007617          	auipc	a2,0x7
ffffffffc0201c30:	b0c60613          	addi	a2,a2,-1268 # ffffffffc0208738 <commands+0x410>
ffffffffc0201c34:	07400593          	li	a1,116
ffffffffc0201c38:	00007517          	auipc	a0,0x7
ffffffffc0201c3c:	19050513          	addi	a0,a0,400 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201c40:	dc8fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201c44:	00007697          	auipc	a3,0x7
ffffffffc0201c48:	1d468693          	addi	a3,a3,468 # ffffffffc0208e18 <commands+0xaf0>
ffffffffc0201c4c:	00007617          	auipc	a2,0x7
ffffffffc0201c50:	aec60613          	addi	a2,a2,-1300 # ffffffffc0208738 <commands+0x410>
ffffffffc0201c54:	06c00593          	li	a1,108
ffffffffc0201c58:	00007517          	auipc	a0,0x7
ffffffffc0201c5c:	17050513          	addi	a0,a0,368 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201c60:	da8fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201c64:	00007697          	auipc	a3,0x7
ffffffffc0201c68:	19468693          	addi	a3,a3,404 # ffffffffc0208df8 <commands+0xad0>
ffffffffc0201c6c:	00007617          	auipc	a2,0x7
ffffffffc0201c70:	acc60613          	addi	a2,a2,-1332 # ffffffffc0208738 <commands+0x410>
ffffffffc0201c74:	06b00593          	li	a1,107
ffffffffc0201c78:	00007517          	auipc	a0,0x7
ffffffffc0201c7c:	15050513          	addi	a0,a0,336 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201c80:	d88fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201c84 <mm_destroy>:
ffffffffc0201c84:	591c                	lw	a5,48(a0)
ffffffffc0201c86:	1141                	addi	sp,sp,-16
ffffffffc0201c88:	e406                	sd	ra,8(sp)
ffffffffc0201c8a:	e022                	sd	s0,0(sp)
ffffffffc0201c8c:	e785                	bnez	a5,ffffffffc0201cb4 <mm_destroy+0x30>
ffffffffc0201c8e:	842a                	mv	s0,a0
ffffffffc0201c90:	6508                	ld	a0,8(a0)
ffffffffc0201c92:	00a40c63          	beq	s0,a0,ffffffffc0201caa <mm_destroy+0x26>
ffffffffc0201c96:	6118                	ld	a4,0(a0)
ffffffffc0201c98:	651c                	ld	a5,8(a0)
ffffffffc0201c9a:	1501                	addi	a0,a0,-32
ffffffffc0201c9c:	e71c                	sd	a5,8(a4)
ffffffffc0201c9e:	e398                	sd	a4,0(a5)
ffffffffc0201ca0:	63c000ef          	jal	ra,ffffffffc02022dc <kfree>
ffffffffc0201ca4:	6408                	ld	a0,8(s0)
ffffffffc0201ca6:	fea418e3          	bne	s0,a0,ffffffffc0201c96 <mm_destroy+0x12>
ffffffffc0201caa:	8522                	mv	a0,s0
ffffffffc0201cac:	6402                	ld	s0,0(sp)
ffffffffc0201cae:	60a2                	ld	ra,8(sp)
ffffffffc0201cb0:	0141                	addi	sp,sp,16
ffffffffc0201cb2:	a52d                	j	ffffffffc02022dc <kfree>
ffffffffc0201cb4:	00007697          	auipc	a3,0x7
ffffffffc0201cb8:	18468693          	addi	a3,a3,388 # ffffffffc0208e38 <commands+0xb10>
ffffffffc0201cbc:	00007617          	auipc	a2,0x7
ffffffffc0201cc0:	a7c60613          	addi	a2,a2,-1412 # ffffffffc0208738 <commands+0x410>
ffffffffc0201cc4:	09400593          	li	a1,148
ffffffffc0201cc8:	00007517          	auipc	a0,0x7
ffffffffc0201ccc:	10050513          	addi	a0,a0,256 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201cd0:	d38fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201cd4 <mm_map>:
ffffffffc0201cd4:	7139                	addi	sp,sp,-64
ffffffffc0201cd6:	f822                	sd	s0,48(sp)
ffffffffc0201cd8:	6405                	lui	s0,0x1
ffffffffc0201cda:	147d                	addi	s0,s0,-1
ffffffffc0201cdc:	77fd                	lui	a5,0xfffff
ffffffffc0201cde:	9622                	add	a2,a2,s0
ffffffffc0201ce0:	962e                	add	a2,a2,a1
ffffffffc0201ce2:	f426                	sd	s1,40(sp)
ffffffffc0201ce4:	fc06                	sd	ra,56(sp)
ffffffffc0201ce6:	00f5f4b3          	and	s1,a1,a5
ffffffffc0201cea:	f04a                	sd	s2,32(sp)
ffffffffc0201cec:	ec4e                	sd	s3,24(sp)
ffffffffc0201cee:	e852                	sd	s4,16(sp)
ffffffffc0201cf0:	e456                	sd	s5,8(sp)
ffffffffc0201cf2:	002005b7          	lui	a1,0x200
ffffffffc0201cf6:	00f67433          	and	s0,a2,a5
ffffffffc0201cfa:	06b4e363          	bltu	s1,a1,ffffffffc0201d60 <mm_map+0x8c>
ffffffffc0201cfe:	0684f163          	bgeu	s1,s0,ffffffffc0201d60 <mm_map+0x8c>
ffffffffc0201d02:	4785                	li	a5,1
ffffffffc0201d04:	07fe                	slli	a5,a5,0x1f
ffffffffc0201d06:	0487ed63          	bltu	a5,s0,ffffffffc0201d60 <mm_map+0x8c>
ffffffffc0201d0a:	89aa                	mv	s3,a0
ffffffffc0201d0c:	cd21                	beqz	a0,ffffffffc0201d64 <mm_map+0x90>
ffffffffc0201d0e:	85a6                	mv	a1,s1
ffffffffc0201d10:	8ab6                	mv	s5,a3
ffffffffc0201d12:	8a3a                	mv	s4,a4
ffffffffc0201d14:	e61ff0ef          	jal	ra,ffffffffc0201b74 <find_vma>
ffffffffc0201d18:	c501                	beqz	a0,ffffffffc0201d20 <mm_map+0x4c>
ffffffffc0201d1a:	651c                	ld	a5,8(a0)
ffffffffc0201d1c:	0487e263          	bltu	a5,s0,ffffffffc0201d60 <mm_map+0x8c>
ffffffffc0201d20:	03000513          	li	a0,48
ffffffffc0201d24:	508000ef          	jal	ra,ffffffffc020222c <kmalloc>
ffffffffc0201d28:	892a                	mv	s2,a0
ffffffffc0201d2a:	5571                	li	a0,-4
ffffffffc0201d2c:	02090163          	beqz	s2,ffffffffc0201d4e <mm_map+0x7a>
ffffffffc0201d30:	854e                	mv	a0,s3
ffffffffc0201d32:	00993423          	sd	s1,8(s2)
ffffffffc0201d36:	00893823          	sd	s0,16(s2)
ffffffffc0201d3a:	01592c23          	sw	s5,24(s2)
ffffffffc0201d3e:	85ca                	mv	a1,s2
ffffffffc0201d40:	e75ff0ef          	jal	ra,ffffffffc0201bb4 <insert_vma_struct>
ffffffffc0201d44:	4501                	li	a0,0
ffffffffc0201d46:	000a0463          	beqz	s4,ffffffffc0201d4e <mm_map+0x7a>
ffffffffc0201d4a:	012a3023          	sd	s2,0(s4) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc0201d4e:	70e2                	ld	ra,56(sp)
ffffffffc0201d50:	7442                	ld	s0,48(sp)
ffffffffc0201d52:	74a2                	ld	s1,40(sp)
ffffffffc0201d54:	7902                	ld	s2,32(sp)
ffffffffc0201d56:	69e2                	ld	s3,24(sp)
ffffffffc0201d58:	6a42                	ld	s4,16(sp)
ffffffffc0201d5a:	6aa2                	ld	s5,8(sp)
ffffffffc0201d5c:	6121                	addi	sp,sp,64
ffffffffc0201d5e:	8082                	ret
ffffffffc0201d60:	5575                	li	a0,-3
ffffffffc0201d62:	b7f5                	j	ffffffffc0201d4e <mm_map+0x7a>
ffffffffc0201d64:	00007697          	auipc	a3,0x7
ffffffffc0201d68:	0ec68693          	addi	a3,a3,236 # ffffffffc0208e50 <commands+0xb28>
ffffffffc0201d6c:	00007617          	auipc	a2,0x7
ffffffffc0201d70:	9cc60613          	addi	a2,a2,-1588 # ffffffffc0208738 <commands+0x410>
ffffffffc0201d74:	0a700593          	li	a1,167
ffffffffc0201d78:	00007517          	auipc	a0,0x7
ffffffffc0201d7c:	05050513          	addi	a0,a0,80 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201d80:	c88fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201d84 <dup_mmap>:
ffffffffc0201d84:	7139                	addi	sp,sp,-64
ffffffffc0201d86:	fc06                	sd	ra,56(sp)
ffffffffc0201d88:	f822                	sd	s0,48(sp)
ffffffffc0201d8a:	f426                	sd	s1,40(sp)
ffffffffc0201d8c:	f04a                	sd	s2,32(sp)
ffffffffc0201d8e:	ec4e                	sd	s3,24(sp)
ffffffffc0201d90:	e852                	sd	s4,16(sp)
ffffffffc0201d92:	e456                	sd	s5,8(sp)
ffffffffc0201d94:	c52d                	beqz	a0,ffffffffc0201dfe <dup_mmap+0x7a>
ffffffffc0201d96:	892a                	mv	s2,a0
ffffffffc0201d98:	84ae                	mv	s1,a1
ffffffffc0201d9a:	842e                	mv	s0,a1
ffffffffc0201d9c:	e595                	bnez	a1,ffffffffc0201dc8 <dup_mmap+0x44>
ffffffffc0201d9e:	a085                	j	ffffffffc0201dfe <dup_mmap+0x7a>
ffffffffc0201da0:	854a                	mv	a0,s2
ffffffffc0201da2:	0155b423          	sd	s5,8(a1) # 200008 <kern_entry-0xffffffffbffffff8>
ffffffffc0201da6:	0145b823          	sd	s4,16(a1)
ffffffffc0201daa:	0135ac23          	sw	s3,24(a1)
ffffffffc0201dae:	e07ff0ef          	jal	ra,ffffffffc0201bb4 <insert_vma_struct>
ffffffffc0201db2:	ff043683          	ld	a3,-16(s0) # ff0 <kern_entry-0xffffffffc01ff010>
ffffffffc0201db6:	fe843603          	ld	a2,-24(s0)
ffffffffc0201dba:	6c8c                	ld	a1,24(s1)
ffffffffc0201dbc:	01893503          	ld	a0,24(s2)
ffffffffc0201dc0:	4701                	li	a4,0
ffffffffc0201dc2:	e8eff0ef          	jal	ra,ffffffffc0201450 <copy_range>
ffffffffc0201dc6:	e105                	bnez	a0,ffffffffc0201de6 <dup_mmap+0x62>
ffffffffc0201dc8:	6000                	ld	s0,0(s0)
ffffffffc0201dca:	02848863          	beq	s1,s0,ffffffffc0201dfa <dup_mmap+0x76>
ffffffffc0201dce:	03000513          	li	a0,48
ffffffffc0201dd2:	fe843a83          	ld	s5,-24(s0)
ffffffffc0201dd6:	ff043a03          	ld	s4,-16(s0)
ffffffffc0201dda:	ff842983          	lw	s3,-8(s0)
ffffffffc0201dde:	44e000ef          	jal	ra,ffffffffc020222c <kmalloc>
ffffffffc0201de2:	85aa                	mv	a1,a0
ffffffffc0201de4:	fd55                	bnez	a0,ffffffffc0201da0 <dup_mmap+0x1c>
ffffffffc0201de6:	5571                	li	a0,-4
ffffffffc0201de8:	70e2                	ld	ra,56(sp)
ffffffffc0201dea:	7442                	ld	s0,48(sp)
ffffffffc0201dec:	74a2                	ld	s1,40(sp)
ffffffffc0201dee:	7902                	ld	s2,32(sp)
ffffffffc0201df0:	69e2                	ld	s3,24(sp)
ffffffffc0201df2:	6a42                	ld	s4,16(sp)
ffffffffc0201df4:	6aa2                	ld	s5,8(sp)
ffffffffc0201df6:	6121                	addi	sp,sp,64
ffffffffc0201df8:	8082                	ret
ffffffffc0201dfa:	4501                	li	a0,0
ffffffffc0201dfc:	b7f5                	j	ffffffffc0201de8 <dup_mmap+0x64>
ffffffffc0201dfe:	00007697          	auipc	a3,0x7
ffffffffc0201e02:	06268693          	addi	a3,a3,98 # ffffffffc0208e60 <commands+0xb38>
ffffffffc0201e06:	00007617          	auipc	a2,0x7
ffffffffc0201e0a:	93260613          	addi	a2,a2,-1742 # ffffffffc0208738 <commands+0x410>
ffffffffc0201e0e:	0c000593          	li	a1,192
ffffffffc0201e12:	00007517          	auipc	a0,0x7
ffffffffc0201e16:	fb650513          	addi	a0,a0,-74 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201e1a:	beefe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201e1e <exit_mmap>:
ffffffffc0201e1e:	1101                	addi	sp,sp,-32
ffffffffc0201e20:	ec06                	sd	ra,24(sp)
ffffffffc0201e22:	e822                	sd	s0,16(sp)
ffffffffc0201e24:	e426                	sd	s1,8(sp)
ffffffffc0201e26:	e04a                	sd	s2,0(sp)
ffffffffc0201e28:	c531                	beqz	a0,ffffffffc0201e74 <exit_mmap+0x56>
ffffffffc0201e2a:	591c                	lw	a5,48(a0)
ffffffffc0201e2c:	84aa                	mv	s1,a0
ffffffffc0201e2e:	e3b9                	bnez	a5,ffffffffc0201e74 <exit_mmap+0x56>
ffffffffc0201e30:	6500                	ld	s0,8(a0)
ffffffffc0201e32:	01853903          	ld	s2,24(a0)
ffffffffc0201e36:	02850663          	beq	a0,s0,ffffffffc0201e62 <exit_mmap+0x44>
ffffffffc0201e3a:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e3e:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e42:	854a                	mv	a0,s2
ffffffffc0201e44:	b3cff0ef          	jal	ra,ffffffffc0201180 <unmap_range>
ffffffffc0201e48:	6400                	ld	s0,8(s0)
ffffffffc0201e4a:	fe8498e3          	bne	s1,s0,ffffffffc0201e3a <exit_mmap+0x1c>
ffffffffc0201e4e:	6400                	ld	s0,8(s0)
ffffffffc0201e50:	00848c63          	beq	s1,s0,ffffffffc0201e68 <exit_mmap+0x4a>
ffffffffc0201e54:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e58:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e5c:	854a                	mv	a0,s2
ffffffffc0201e5e:	c38ff0ef          	jal	ra,ffffffffc0201296 <exit_range>
ffffffffc0201e62:	6400                	ld	s0,8(s0)
ffffffffc0201e64:	fe8498e3          	bne	s1,s0,ffffffffc0201e54 <exit_mmap+0x36>
ffffffffc0201e68:	60e2                	ld	ra,24(sp)
ffffffffc0201e6a:	6442                	ld	s0,16(sp)
ffffffffc0201e6c:	64a2                	ld	s1,8(sp)
ffffffffc0201e6e:	6902                	ld	s2,0(sp)
ffffffffc0201e70:	6105                	addi	sp,sp,32
ffffffffc0201e72:	8082                	ret
ffffffffc0201e74:	00007697          	auipc	a3,0x7
ffffffffc0201e78:	00c68693          	addi	a3,a3,12 # ffffffffc0208e80 <commands+0xb58>
ffffffffc0201e7c:	00007617          	auipc	a2,0x7
ffffffffc0201e80:	8bc60613          	addi	a2,a2,-1860 # ffffffffc0208738 <commands+0x410>
ffffffffc0201e84:	0d600593          	li	a1,214
ffffffffc0201e88:	00007517          	auipc	a0,0x7
ffffffffc0201e8c:	f4050513          	addi	a0,a0,-192 # ffffffffc0208dc8 <commands+0xaa0>
ffffffffc0201e90:	b78fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201e94 <vmm_init>:
ffffffffc0201e94:	8082                	ret

ffffffffc0201e96 <do_pgfault>:
ffffffffc0201e96:	7139                	addi	sp,sp,-64
ffffffffc0201e98:	85b2                	mv	a1,a2
ffffffffc0201e9a:	f822                	sd	s0,48(sp)
ffffffffc0201e9c:	f426                	sd	s1,40(sp)
ffffffffc0201e9e:	fc06                	sd	ra,56(sp)
ffffffffc0201ea0:	f04a                	sd	s2,32(sp)
ffffffffc0201ea2:	ec4e                	sd	s3,24(sp)
ffffffffc0201ea4:	8432                	mv	s0,a2
ffffffffc0201ea6:	84aa                	mv	s1,a0
ffffffffc0201ea8:	ccdff0ef          	jal	ra,ffffffffc0201b74 <find_vma>
ffffffffc0201eac:	00017797          	auipc	a5,0x17
ffffffffc0201eb0:	6347a783          	lw	a5,1588(a5) # ffffffffc02194e0 <pgfault_num>
ffffffffc0201eb4:	2785                	addiw	a5,a5,1
ffffffffc0201eb6:	00017717          	auipc	a4,0x17
ffffffffc0201eba:	62f72523          	sw	a5,1578(a4) # ffffffffc02194e0 <pgfault_num>
ffffffffc0201ebe:	c545                	beqz	a0,ffffffffc0201f66 <do_pgfault+0xd0>
ffffffffc0201ec0:	651c                	ld	a5,8(a0)
ffffffffc0201ec2:	0af46263          	bltu	s0,a5,ffffffffc0201f66 <do_pgfault+0xd0>
ffffffffc0201ec6:	4d1c                	lw	a5,24(a0)
ffffffffc0201ec8:	49c1                	li	s3,16
ffffffffc0201eca:	8b89                	andi	a5,a5,2
ffffffffc0201ecc:	efb1                	bnez	a5,ffffffffc0201f28 <do_pgfault+0x92>
ffffffffc0201ece:	75fd                	lui	a1,0xfffff
ffffffffc0201ed0:	6c88                	ld	a0,24(s1)
ffffffffc0201ed2:	8c6d                	and	s0,s0,a1
ffffffffc0201ed4:	4605                	li	a2,1
ffffffffc0201ed6:	85a2                	mv	a1,s0
ffffffffc0201ed8:	8d6ff0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc0201edc:	c555                	beqz	a0,ffffffffc0201f88 <do_pgfault+0xf2>
ffffffffc0201ede:	610c                	ld	a1,0(a0)
ffffffffc0201ee0:	c5a5                	beqz	a1,ffffffffc0201f48 <do_pgfault+0xb2>
ffffffffc0201ee2:	00017797          	auipc	a5,0x17
ffffffffc0201ee6:	6167a783          	lw	a5,1558(a5) # ffffffffc02194f8 <swap_init_ok>
ffffffffc0201eea:	c7d9                	beqz	a5,ffffffffc0201f78 <do_pgfault+0xe2>
ffffffffc0201eec:	0030                	addi	a2,sp,8
ffffffffc0201eee:	85a2                	mv	a1,s0
ffffffffc0201ef0:	8526                	mv	a0,s1
ffffffffc0201ef2:	e402                	sd	zero,8(sp)
ffffffffc0201ef4:	694000ef          	jal	ra,ffffffffc0202588 <swap_in>
ffffffffc0201ef8:	892a                	mv	s2,a0
ffffffffc0201efa:	e90d                	bnez	a0,ffffffffc0201f2c <do_pgfault+0x96>
ffffffffc0201efc:	65a2                	ld	a1,8(sp)
ffffffffc0201efe:	6c88                	ld	a0,24(s1)
ffffffffc0201f00:	86ce                	mv	a3,s3
ffffffffc0201f02:	8622                	mv	a2,s0
ffffffffc0201f04:	c90ff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc0201f08:	6622                	ld	a2,8(sp)
ffffffffc0201f0a:	4685                	li	a3,1
ffffffffc0201f0c:	85a2                	mv	a1,s0
ffffffffc0201f0e:	8526                	mv	a0,s1
ffffffffc0201f10:	556000ef          	jal	ra,ffffffffc0202466 <swap_map_swappable>
ffffffffc0201f14:	67a2                	ld	a5,8(sp)
ffffffffc0201f16:	ff80                	sd	s0,56(a5)
ffffffffc0201f18:	70e2                	ld	ra,56(sp)
ffffffffc0201f1a:	7442                	ld	s0,48(sp)
ffffffffc0201f1c:	74a2                	ld	s1,40(sp)
ffffffffc0201f1e:	69e2                	ld	s3,24(sp)
ffffffffc0201f20:	854a                	mv	a0,s2
ffffffffc0201f22:	7902                	ld	s2,32(sp)
ffffffffc0201f24:	6121                	addi	sp,sp,64
ffffffffc0201f26:	8082                	ret
ffffffffc0201f28:	49dd                	li	s3,23
ffffffffc0201f2a:	b755                	j	ffffffffc0201ece <do_pgfault+0x38>
ffffffffc0201f2c:	00007517          	auipc	a0,0x7
ffffffffc0201f30:	fec50513          	addi	a0,a0,-20 # ffffffffc0208f18 <commands+0xbf0>
ffffffffc0201f34:	998fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f38:	70e2                	ld	ra,56(sp)
ffffffffc0201f3a:	7442                	ld	s0,48(sp)
ffffffffc0201f3c:	74a2                	ld	s1,40(sp)
ffffffffc0201f3e:	69e2                	ld	s3,24(sp)
ffffffffc0201f40:	854a                	mv	a0,s2
ffffffffc0201f42:	7902                	ld	s2,32(sp)
ffffffffc0201f44:	6121                	addi	sp,sp,64
ffffffffc0201f46:	8082                	ret
ffffffffc0201f48:	6c88                	ld	a0,24(s1)
ffffffffc0201f4a:	864e                	mv	a2,s3
ffffffffc0201f4c:	85a2                	mv	a1,s0
ffffffffc0201f4e:	f38ff0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0201f52:	4901                	li	s2,0
ffffffffc0201f54:	f171                	bnez	a0,ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f56:	00007517          	auipc	a0,0x7
ffffffffc0201f5a:	f9a50513          	addi	a0,a0,-102 # ffffffffc0208ef0 <commands+0xbc8>
ffffffffc0201f5e:	96efe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f62:	5971                	li	s2,-4
ffffffffc0201f64:	bf55                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f66:	85a2                	mv	a1,s0
ffffffffc0201f68:	00007517          	auipc	a0,0x7
ffffffffc0201f6c:	f3850513          	addi	a0,a0,-200 # ffffffffc0208ea0 <commands+0xb78>
ffffffffc0201f70:	95cfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f74:	5975                	li	s2,-3
ffffffffc0201f76:	b74d                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f78:	00007517          	auipc	a0,0x7
ffffffffc0201f7c:	fc050513          	addi	a0,a0,-64 # ffffffffc0208f38 <commands+0xc10>
ffffffffc0201f80:	94cfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f84:	5971                	li	s2,-4
ffffffffc0201f86:	bf49                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f88:	00007517          	auipc	a0,0x7
ffffffffc0201f8c:	f4850513          	addi	a0,a0,-184 # ffffffffc0208ed0 <commands+0xba8>
ffffffffc0201f90:	93cfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f94:	5971                	li	s2,-4
ffffffffc0201f96:	b749                	j	ffffffffc0201f18 <do_pgfault+0x82>

ffffffffc0201f98 <user_mem_check>:
ffffffffc0201f98:	7179                	addi	sp,sp,-48
ffffffffc0201f9a:	f022                	sd	s0,32(sp)
ffffffffc0201f9c:	f406                	sd	ra,40(sp)
ffffffffc0201f9e:	ec26                	sd	s1,24(sp)
ffffffffc0201fa0:	e84a                	sd	s2,16(sp)
ffffffffc0201fa2:	e44e                	sd	s3,8(sp)
ffffffffc0201fa4:	e052                	sd	s4,0(sp)
ffffffffc0201fa6:	842e                	mv	s0,a1
ffffffffc0201fa8:	c135                	beqz	a0,ffffffffc020200c <user_mem_check+0x74>
ffffffffc0201faa:	002007b7          	lui	a5,0x200
ffffffffc0201fae:	04f5e663          	bltu	a1,a5,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fb2:	00c584b3          	add	s1,a1,a2
ffffffffc0201fb6:	0495f263          	bgeu	a1,s1,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fba:	4785                	li	a5,1
ffffffffc0201fbc:	07fe                	slli	a5,a5,0x1f
ffffffffc0201fbe:	0297ee63          	bltu	a5,s1,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fc2:	892a                	mv	s2,a0
ffffffffc0201fc4:	89b6                	mv	s3,a3
ffffffffc0201fc6:	6a05                	lui	s4,0x1
ffffffffc0201fc8:	a821                	j	ffffffffc0201fe0 <user_mem_check+0x48>
ffffffffc0201fca:	0027f693          	andi	a3,a5,2
ffffffffc0201fce:	9752                	add	a4,a4,s4
ffffffffc0201fd0:	8ba1                	andi	a5,a5,8
ffffffffc0201fd2:	c685                	beqz	a3,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fd4:	c399                	beqz	a5,ffffffffc0201fda <user_mem_check+0x42>
ffffffffc0201fd6:	02e46263          	bltu	s0,a4,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fda:	6900                	ld	s0,16(a0)
ffffffffc0201fdc:	04947663          	bgeu	s0,s1,ffffffffc0202028 <user_mem_check+0x90>
ffffffffc0201fe0:	85a2                	mv	a1,s0
ffffffffc0201fe2:	854a                	mv	a0,s2
ffffffffc0201fe4:	b91ff0ef          	jal	ra,ffffffffc0201b74 <find_vma>
ffffffffc0201fe8:	c909                	beqz	a0,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201fea:	6518                	ld	a4,8(a0)
ffffffffc0201fec:	00e46763          	bltu	s0,a4,ffffffffc0201ffa <user_mem_check+0x62>
ffffffffc0201ff0:	4d1c                	lw	a5,24(a0)
ffffffffc0201ff2:	fc099ce3          	bnez	s3,ffffffffc0201fca <user_mem_check+0x32>
ffffffffc0201ff6:	8b85                	andi	a5,a5,1
ffffffffc0201ff8:	f3ed                	bnez	a5,ffffffffc0201fda <user_mem_check+0x42>
ffffffffc0201ffa:	4501                	li	a0,0
ffffffffc0201ffc:	70a2                	ld	ra,40(sp)
ffffffffc0201ffe:	7402                	ld	s0,32(sp)
ffffffffc0202000:	64e2                	ld	s1,24(sp)
ffffffffc0202002:	6942                	ld	s2,16(sp)
ffffffffc0202004:	69a2                	ld	s3,8(sp)
ffffffffc0202006:	6a02                	ld	s4,0(sp)
ffffffffc0202008:	6145                	addi	sp,sp,48
ffffffffc020200a:	8082                	ret
ffffffffc020200c:	c02007b7          	lui	a5,0xc0200
ffffffffc0202010:	4501                	li	a0,0
ffffffffc0202012:	fef5e5e3          	bltu	a1,a5,ffffffffc0201ffc <user_mem_check+0x64>
ffffffffc0202016:	962e                	add	a2,a2,a1
ffffffffc0202018:	fec5f2e3          	bgeu	a1,a2,ffffffffc0201ffc <user_mem_check+0x64>
ffffffffc020201c:	c8000537          	lui	a0,0xc8000
ffffffffc0202020:	0505                	addi	a0,a0,1
ffffffffc0202022:	00a63533          	sltu	a0,a2,a0
ffffffffc0202026:	bfd9                	j	ffffffffc0201ffc <user_mem_check+0x64>
ffffffffc0202028:	4505                	li	a0,1
ffffffffc020202a:	bfc9                	j	ffffffffc0201ffc <user_mem_check+0x64>

ffffffffc020202c <slob_free>:
ffffffffc020202c:	c145                	beqz	a0,ffffffffc02020cc <slob_free+0xa0>
ffffffffc020202e:	1141                	addi	sp,sp,-16
ffffffffc0202030:	e022                	sd	s0,0(sp)
ffffffffc0202032:	e406                	sd	ra,8(sp)
ffffffffc0202034:	842a                	mv	s0,a0
ffffffffc0202036:	edb1                	bnez	a1,ffffffffc0202092 <slob_free+0x66>
ffffffffc0202038:	100027f3          	csrr	a5,sstatus
ffffffffc020203c:	8b89                	andi	a5,a5,2
ffffffffc020203e:	4501                	li	a0,0
ffffffffc0202040:	e3ad                	bnez	a5,ffffffffc02020a2 <slob_free+0x76>
ffffffffc0202042:	0000c617          	auipc	a2,0xc
ffffffffc0202046:	03e60613          	addi	a2,a2,62 # ffffffffc020e080 <slobfree>
ffffffffc020204a:	621c                	ld	a5,0(a2)
ffffffffc020204c:	6798                	ld	a4,8(a5)
ffffffffc020204e:	0087fa63          	bgeu	a5,s0,ffffffffc0202062 <slob_free+0x36>
ffffffffc0202052:	00e46c63          	bltu	s0,a4,ffffffffc020206a <slob_free+0x3e>
ffffffffc0202056:	00e7fa63          	bgeu	a5,a4,ffffffffc020206a <slob_free+0x3e>
ffffffffc020205a:	87ba                	mv	a5,a4
ffffffffc020205c:	6798                	ld	a4,8(a5)
ffffffffc020205e:	fe87eae3          	bltu	a5,s0,ffffffffc0202052 <slob_free+0x26>
ffffffffc0202062:	fee7ece3          	bltu	a5,a4,ffffffffc020205a <slob_free+0x2e>
ffffffffc0202066:	fee47ae3          	bgeu	s0,a4,ffffffffc020205a <slob_free+0x2e>
ffffffffc020206a:	400c                	lw	a1,0(s0)
ffffffffc020206c:	00459693          	slli	a3,a1,0x4
ffffffffc0202070:	96a2                	add	a3,a3,s0
ffffffffc0202072:	04d70763          	beq	a4,a3,ffffffffc02020c0 <slob_free+0x94>
ffffffffc0202076:	e418                	sd	a4,8(s0)
ffffffffc0202078:	4394                	lw	a3,0(a5)
ffffffffc020207a:	00469713          	slli	a4,a3,0x4
ffffffffc020207e:	973e                	add	a4,a4,a5
ffffffffc0202080:	02e40a63          	beq	s0,a4,ffffffffc02020b4 <slob_free+0x88>
ffffffffc0202084:	e780                	sd	s0,8(a5)
ffffffffc0202086:	e21c                	sd	a5,0(a2)
ffffffffc0202088:	e10d                	bnez	a0,ffffffffc02020aa <slob_free+0x7e>
ffffffffc020208a:	60a2                	ld	ra,8(sp)
ffffffffc020208c:	6402                	ld	s0,0(sp)
ffffffffc020208e:	0141                	addi	sp,sp,16
ffffffffc0202090:	8082                	ret
ffffffffc0202092:	05bd                	addi	a1,a1,15
ffffffffc0202094:	8191                	srli	a1,a1,0x4
ffffffffc0202096:	c10c                	sw	a1,0(a0)
ffffffffc0202098:	100027f3          	csrr	a5,sstatus
ffffffffc020209c:	8b89                	andi	a5,a5,2
ffffffffc020209e:	4501                	li	a0,0
ffffffffc02020a0:	d3cd                	beqz	a5,ffffffffc0202042 <slob_free+0x16>
ffffffffc02020a2:	d96fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02020a6:	4505                	li	a0,1
ffffffffc02020a8:	bf69                	j	ffffffffc0202042 <slob_free+0x16>
ffffffffc02020aa:	6402                	ld	s0,0(sp)
ffffffffc02020ac:	60a2                	ld	ra,8(sp)
ffffffffc02020ae:	0141                	addi	sp,sp,16
ffffffffc02020b0:	d82fe06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02020b4:	4018                	lw	a4,0(s0)
ffffffffc02020b6:	640c                	ld	a1,8(s0)
ffffffffc02020b8:	9eb9                	addw	a3,a3,a4
ffffffffc02020ba:	c394                	sw	a3,0(a5)
ffffffffc02020bc:	e78c                	sd	a1,8(a5)
ffffffffc02020be:	b7e1                	j	ffffffffc0202086 <slob_free+0x5a>
ffffffffc02020c0:	4314                	lw	a3,0(a4)
ffffffffc02020c2:	6718                	ld	a4,8(a4)
ffffffffc02020c4:	9db5                	addw	a1,a1,a3
ffffffffc02020c6:	c00c                	sw	a1,0(s0)
ffffffffc02020c8:	e418                	sd	a4,8(s0)
ffffffffc02020ca:	b77d                	j	ffffffffc0202078 <slob_free+0x4c>
ffffffffc02020cc:	8082                	ret

ffffffffc02020ce <__slob_get_free_pages.isra.0>:
ffffffffc02020ce:	4785                	li	a5,1
ffffffffc02020d0:	1141                	addi	sp,sp,-16
ffffffffc02020d2:	00a7953b          	sllw	a0,a5,a0
ffffffffc02020d6:	e406                	sd	ra,8(sp)
ffffffffc02020d8:	c73fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02020dc:	c91d                	beqz	a0,ffffffffc0202112 <__slob_get_free_pages.isra.0+0x44>
ffffffffc02020de:	00017697          	auipc	a3,0x17
ffffffffc02020e2:	4726b683          	ld	a3,1138(a3) # ffffffffc0219550 <pages>
ffffffffc02020e6:	8d15                	sub	a0,a0,a3
ffffffffc02020e8:	8519                	srai	a0,a0,0x6
ffffffffc02020ea:	00008697          	auipc	a3,0x8
ffffffffc02020ee:	7ae6b683          	ld	a3,1966(a3) # ffffffffc020a898 <nbase>
ffffffffc02020f2:	9536                	add	a0,a0,a3
ffffffffc02020f4:	00c51793          	slli	a5,a0,0xc
ffffffffc02020f8:	83b1                	srli	a5,a5,0xc
ffffffffc02020fa:	00017717          	auipc	a4,0x17
ffffffffc02020fe:	3de73703          	ld	a4,990(a4) # ffffffffc02194d8 <npage>
ffffffffc0202102:	0532                	slli	a0,a0,0xc
ffffffffc0202104:	00e7fa63          	bgeu	a5,a4,ffffffffc0202118 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0202108:	00017697          	auipc	a3,0x17
ffffffffc020210c:	4386b683          	ld	a3,1080(a3) # ffffffffc0219540 <va_pa_offset>
ffffffffc0202110:	9536                	add	a0,a0,a3
ffffffffc0202112:	60a2                	ld	ra,8(sp)
ffffffffc0202114:	0141                	addi	sp,sp,16
ffffffffc0202116:	8082                	ret
ffffffffc0202118:	86aa                	mv	a3,a0
ffffffffc020211a:	00007617          	auipc	a2,0x7
ffffffffc020211e:	9ce60613          	addi	a2,a2,-1586 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0202122:	06900593          	li	a1,105
ffffffffc0202126:	00007517          	auipc	a0,0x7
ffffffffc020212a:	92250513          	addi	a0,a0,-1758 # ffffffffc0208a48 <commands+0x720>
ffffffffc020212e:	8dafe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202132 <slob_alloc.isra.0.constprop.0>:
ffffffffc0202132:	1101                	addi	sp,sp,-32
ffffffffc0202134:	ec06                	sd	ra,24(sp)
ffffffffc0202136:	e822                	sd	s0,16(sp)
ffffffffc0202138:	e426                	sd	s1,8(sp)
ffffffffc020213a:	e04a                	sd	s2,0(sp)
ffffffffc020213c:	01050713          	addi	a4,a0,16
ffffffffc0202140:	6785                	lui	a5,0x1
ffffffffc0202142:	0cf77363          	bgeu	a4,a5,ffffffffc0202208 <slob_alloc.isra.0.constprop.0+0xd6>
ffffffffc0202146:	00f50493          	addi	s1,a0,15
ffffffffc020214a:	8091                	srli	s1,s1,0x4
ffffffffc020214c:	2481                	sext.w	s1,s1
ffffffffc020214e:	10002673          	csrr	a2,sstatus
ffffffffc0202152:	8a09                	andi	a2,a2,2
ffffffffc0202154:	e25d                	bnez	a2,ffffffffc02021fa <slob_alloc.isra.0.constprop.0+0xc8>
ffffffffc0202156:	0000c917          	auipc	s2,0xc
ffffffffc020215a:	f2a90913          	addi	s2,s2,-214 # ffffffffc020e080 <slobfree>
ffffffffc020215e:	00093683          	ld	a3,0(s2)
ffffffffc0202162:	669c                	ld	a5,8(a3)
ffffffffc0202164:	4398                	lw	a4,0(a5)
ffffffffc0202166:	08975e63          	bge	a4,s1,ffffffffc0202202 <slob_alloc.isra.0.constprop.0+0xd0>
ffffffffc020216a:	00d78b63          	beq	a5,a3,ffffffffc0202180 <slob_alloc.isra.0.constprop.0+0x4e>
ffffffffc020216e:	6780                	ld	s0,8(a5)
ffffffffc0202170:	4018                	lw	a4,0(s0)
ffffffffc0202172:	02975a63          	bge	a4,s1,ffffffffc02021a6 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0202176:	00093683          	ld	a3,0(s2)
ffffffffc020217a:	87a2                	mv	a5,s0
ffffffffc020217c:	fed799e3          	bne	a5,a3,ffffffffc020216e <slob_alloc.isra.0.constprop.0+0x3c>
ffffffffc0202180:	ee31                	bnez	a2,ffffffffc02021dc <slob_alloc.isra.0.constprop.0+0xaa>
ffffffffc0202182:	4501                	li	a0,0
ffffffffc0202184:	f4bff0ef          	jal	ra,ffffffffc02020ce <__slob_get_free_pages.isra.0>
ffffffffc0202188:	842a                	mv	s0,a0
ffffffffc020218a:	cd05                	beqz	a0,ffffffffc02021c2 <slob_alloc.isra.0.constprop.0+0x90>
ffffffffc020218c:	6585                	lui	a1,0x1
ffffffffc020218e:	e9fff0ef          	jal	ra,ffffffffc020202c <slob_free>
ffffffffc0202192:	10002673          	csrr	a2,sstatus
ffffffffc0202196:	8a09                	andi	a2,a2,2
ffffffffc0202198:	ee05                	bnez	a2,ffffffffc02021d0 <slob_alloc.isra.0.constprop.0+0x9e>
ffffffffc020219a:	00093783          	ld	a5,0(s2)
ffffffffc020219e:	6780                	ld	s0,8(a5)
ffffffffc02021a0:	4018                	lw	a4,0(s0)
ffffffffc02021a2:	fc974ae3          	blt	a4,s1,ffffffffc0202176 <slob_alloc.isra.0.constprop.0+0x44>
ffffffffc02021a6:	04e48763          	beq	s1,a4,ffffffffc02021f4 <slob_alloc.isra.0.constprop.0+0xc2>
ffffffffc02021aa:	00449693          	slli	a3,s1,0x4
ffffffffc02021ae:	96a2                	add	a3,a3,s0
ffffffffc02021b0:	e794                	sd	a3,8(a5)
ffffffffc02021b2:	640c                	ld	a1,8(s0)
ffffffffc02021b4:	9f05                	subw	a4,a4,s1
ffffffffc02021b6:	c298                	sw	a4,0(a3)
ffffffffc02021b8:	e68c                	sd	a1,8(a3)
ffffffffc02021ba:	c004                	sw	s1,0(s0)
ffffffffc02021bc:	00f93023          	sd	a5,0(s2)
ffffffffc02021c0:	e20d                	bnez	a2,ffffffffc02021e2 <slob_alloc.isra.0.constprop.0+0xb0>
ffffffffc02021c2:	60e2                	ld	ra,24(sp)
ffffffffc02021c4:	8522                	mv	a0,s0
ffffffffc02021c6:	6442                	ld	s0,16(sp)
ffffffffc02021c8:	64a2                	ld	s1,8(sp)
ffffffffc02021ca:	6902                	ld	s2,0(sp)
ffffffffc02021cc:	6105                	addi	sp,sp,32
ffffffffc02021ce:	8082                	ret
ffffffffc02021d0:	c68fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02021d4:	00093783          	ld	a5,0(s2)
ffffffffc02021d8:	4605                	li	a2,1
ffffffffc02021da:	b7d1                	j	ffffffffc020219e <slob_alloc.isra.0.constprop.0+0x6c>
ffffffffc02021dc:	c56fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02021e0:	b74d                	j	ffffffffc0202182 <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc02021e2:	c50fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02021e6:	60e2                	ld	ra,24(sp)
ffffffffc02021e8:	8522                	mv	a0,s0
ffffffffc02021ea:	6442                	ld	s0,16(sp)
ffffffffc02021ec:	64a2                	ld	s1,8(sp)
ffffffffc02021ee:	6902                	ld	s2,0(sp)
ffffffffc02021f0:	6105                	addi	sp,sp,32
ffffffffc02021f2:	8082                	ret
ffffffffc02021f4:	6418                	ld	a4,8(s0)
ffffffffc02021f6:	e798                	sd	a4,8(a5)
ffffffffc02021f8:	b7d1                	j	ffffffffc02021bc <slob_alloc.isra.0.constprop.0+0x8a>
ffffffffc02021fa:	c3efe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02021fe:	4605                	li	a2,1
ffffffffc0202200:	bf99                	j	ffffffffc0202156 <slob_alloc.isra.0.constprop.0+0x24>
ffffffffc0202202:	843e                	mv	s0,a5
ffffffffc0202204:	87b6                	mv	a5,a3
ffffffffc0202206:	b745                	j	ffffffffc02021a6 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0202208:	00007697          	auipc	a3,0x7
ffffffffc020220c:	d5868693          	addi	a3,a3,-680 # ffffffffc0208f60 <commands+0xc38>
ffffffffc0202210:	00006617          	auipc	a2,0x6
ffffffffc0202214:	52860613          	addi	a2,a2,1320 # ffffffffc0208738 <commands+0x410>
ffffffffc0202218:	06400593          	li	a1,100
ffffffffc020221c:	00007517          	auipc	a0,0x7
ffffffffc0202220:	d6450513          	addi	a0,a0,-668 # ffffffffc0208f80 <commands+0xc58>
ffffffffc0202224:	fe5fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202228 <kallocated>:
ffffffffc0202228:	4501                	li	a0,0
ffffffffc020222a:	8082                	ret

ffffffffc020222c <kmalloc>:
ffffffffc020222c:	1101                	addi	sp,sp,-32
ffffffffc020222e:	e04a                	sd	s2,0(sp)
ffffffffc0202230:	6905                	lui	s2,0x1
ffffffffc0202232:	e822                	sd	s0,16(sp)
ffffffffc0202234:	ec06                	sd	ra,24(sp)
ffffffffc0202236:	e426                	sd	s1,8(sp)
ffffffffc0202238:	fef90793          	addi	a5,s2,-17 # fef <kern_entry-0xffffffffc01ff011>
ffffffffc020223c:	842a                	mv	s0,a0
ffffffffc020223e:	04a7f963          	bgeu	a5,a0,ffffffffc0202290 <kmalloc+0x64>
ffffffffc0202242:	4561                	li	a0,24
ffffffffc0202244:	eefff0ef          	jal	ra,ffffffffc0202132 <slob_alloc.isra.0.constprop.0>
ffffffffc0202248:	84aa                	mv	s1,a0
ffffffffc020224a:	c929                	beqz	a0,ffffffffc020229c <kmalloc+0x70>
ffffffffc020224c:	0004079b          	sext.w	a5,s0
ffffffffc0202250:	4501                	li	a0,0
ffffffffc0202252:	00f95763          	bge	s2,a5,ffffffffc0202260 <kmalloc+0x34>
ffffffffc0202256:	6705                	lui	a4,0x1
ffffffffc0202258:	8785                	srai	a5,a5,0x1
ffffffffc020225a:	2505                	addiw	a0,a0,1
ffffffffc020225c:	fef74ee3          	blt	a4,a5,ffffffffc0202258 <kmalloc+0x2c>
ffffffffc0202260:	c088                	sw	a0,0(s1)
ffffffffc0202262:	e6dff0ef          	jal	ra,ffffffffc02020ce <__slob_get_free_pages.isra.0>
ffffffffc0202266:	e488                	sd	a0,8(s1)
ffffffffc0202268:	842a                	mv	s0,a0
ffffffffc020226a:	c525                	beqz	a0,ffffffffc02022d2 <kmalloc+0xa6>
ffffffffc020226c:	100027f3          	csrr	a5,sstatus
ffffffffc0202270:	8b89                	andi	a5,a5,2
ffffffffc0202272:	ef8d                	bnez	a5,ffffffffc02022ac <kmalloc+0x80>
ffffffffc0202274:	00017797          	auipc	a5,0x17
ffffffffc0202278:	27478793          	addi	a5,a5,628 # ffffffffc02194e8 <bigblocks>
ffffffffc020227c:	6398                	ld	a4,0(a5)
ffffffffc020227e:	e384                	sd	s1,0(a5)
ffffffffc0202280:	e898                	sd	a4,16(s1)
ffffffffc0202282:	60e2                	ld	ra,24(sp)
ffffffffc0202284:	8522                	mv	a0,s0
ffffffffc0202286:	6442                	ld	s0,16(sp)
ffffffffc0202288:	64a2                	ld	s1,8(sp)
ffffffffc020228a:	6902                	ld	s2,0(sp)
ffffffffc020228c:	6105                	addi	sp,sp,32
ffffffffc020228e:	8082                	ret
ffffffffc0202290:	0541                	addi	a0,a0,16
ffffffffc0202292:	ea1ff0ef          	jal	ra,ffffffffc0202132 <slob_alloc.isra.0.constprop.0>
ffffffffc0202296:	01050413          	addi	s0,a0,16
ffffffffc020229a:	f565                	bnez	a0,ffffffffc0202282 <kmalloc+0x56>
ffffffffc020229c:	4401                	li	s0,0
ffffffffc020229e:	60e2                	ld	ra,24(sp)
ffffffffc02022a0:	8522                	mv	a0,s0
ffffffffc02022a2:	6442                	ld	s0,16(sp)
ffffffffc02022a4:	64a2                	ld	s1,8(sp)
ffffffffc02022a6:	6902                	ld	s2,0(sp)
ffffffffc02022a8:	6105                	addi	sp,sp,32
ffffffffc02022aa:	8082                	ret
ffffffffc02022ac:	b8cfe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02022b0:	00017797          	auipc	a5,0x17
ffffffffc02022b4:	23878793          	addi	a5,a5,568 # ffffffffc02194e8 <bigblocks>
ffffffffc02022b8:	6398                	ld	a4,0(a5)
ffffffffc02022ba:	e384                	sd	s1,0(a5)
ffffffffc02022bc:	e898                	sd	a4,16(s1)
ffffffffc02022be:	b74fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc02022c2:	6480                	ld	s0,8(s1)
ffffffffc02022c4:	60e2                	ld	ra,24(sp)
ffffffffc02022c6:	64a2                	ld	s1,8(sp)
ffffffffc02022c8:	8522                	mv	a0,s0
ffffffffc02022ca:	6442                	ld	s0,16(sp)
ffffffffc02022cc:	6902                	ld	s2,0(sp)
ffffffffc02022ce:	6105                	addi	sp,sp,32
ffffffffc02022d0:	8082                	ret
ffffffffc02022d2:	45e1                	li	a1,24
ffffffffc02022d4:	8526                	mv	a0,s1
ffffffffc02022d6:	d57ff0ef          	jal	ra,ffffffffc020202c <slob_free>
ffffffffc02022da:	b765                	j	ffffffffc0202282 <kmalloc+0x56>

ffffffffc02022dc <kfree>:
ffffffffc02022dc:	c169                	beqz	a0,ffffffffc020239e <kfree+0xc2>
ffffffffc02022de:	1101                	addi	sp,sp,-32
ffffffffc02022e0:	e822                	sd	s0,16(sp)
ffffffffc02022e2:	ec06                	sd	ra,24(sp)
ffffffffc02022e4:	e426                	sd	s1,8(sp)
ffffffffc02022e6:	03451793          	slli	a5,a0,0x34
ffffffffc02022ea:	842a                	mv	s0,a0
ffffffffc02022ec:	e7c9                	bnez	a5,ffffffffc0202376 <kfree+0x9a>
ffffffffc02022ee:	100027f3          	csrr	a5,sstatus
ffffffffc02022f2:	8b89                	andi	a5,a5,2
ffffffffc02022f4:	ebc9                	bnez	a5,ffffffffc0202386 <kfree+0xaa>
ffffffffc02022f6:	00017797          	auipc	a5,0x17
ffffffffc02022fa:	1f27b783          	ld	a5,498(a5) # ffffffffc02194e8 <bigblocks>
ffffffffc02022fe:	4601                	li	a2,0
ffffffffc0202300:	cbbd                	beqz	a5,ffffffffc0202376 <kfree+0x9a>
ffffffffc0202302:	00017697          	auipc	a3,0x17
ffffffffc0202306:	1e668693          	addi	a3,a3,486 # ffffffffc02194e8 <bigblocks>
ffffffffc020230a:	a021                	j	ffffffffc0202312 <kfree+0x36>
ffffffffc020230c:	01048693          	addi	a3,s1,16 # ffffffffffe00010 <end+0x3fbe6960>
ffffffffc0202310:	c3a5                	beqz	a5,ffffffffc0202370 <kfree+0x94>
ffffffffc0202312:	6798                	ld	a4,8(a5)
ffffffffc0202314:	84be                	mv	s1,a5
ffffffffc0202316:	6b9c                	ld	a5,16(a5)
ffffffffc0202318:	fe871ae3          	bne	a4,s0,ffffffffc020230c <kfree+0x30>
ffffffffc020231c:	e29c                	sd	a5,0(a3)
ffffffffc020231e:	ee2d                	bnez	a2,ffffffffc0202398 <kfree+0xbc>
ffffffffc0202320:	c02007b7          	lui	a5,0xc0200
ffffffffc0202324:	4098                	lw	a4,0(s1)
ffffffffc0202326:	08f46963          	bltu	s0,a5,ffffffffc02023b8 <kfree+0xdc>
ffffffffc020232a:	00017697          	auipc	a3,0x17
ffffffffc020232e:	2166b683          	ld	a3,534(a3) # ffffffffc0219540 <va_pa_offset>
ffffffffc0202332:	8c15                	sub	s0,s0,a3
ffffffffc0202334:	8031                	srli	s0,s0,0xc
ffffffffc0202336:	00017797          	auipc	a5,0x17
ffffffffc020233a:	1a27b783          	ld	a5,418(a5) # ffffffffc02194d8 <npage>
ffffffffc020233e:	06f47163          	bgeu	s0,a5,ffffffffc02023a0 <kfree+0xc4>
ffffffffc0202342:	00008517          	auipc	a0,0x8
ffffffffc0202346:	55653503          	ld	a0,1366(a0) # ffffffffc020a898 <nbase>
ffffffffc020234a:	8c09                	sub	s0,s0,a0
ffffffffc020234c:	041a                	slli	s0,s0,0x6
ffffffffc020234e:	00017517          	auipc	a0,0x17
ffffffffc0202352:	20253503          	ld	a0,514(a0) # ffffffffc0219550 <pages>
ffffffffc0202356:	4585                	li	a1,1
ffffffffc0202358:	9522                	add	a0,a0,s0
ffffffffc020235a:	00e595bb          	sllw	a1,a1,a4
ffffffffc020235e:	a7ffe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202362:	6442                	ld	s0,16(sp)
ffffffffc0202364:	60e2                	ld	ra,24(sp)
ffffffffc0202366:	8526                	mv	a0,s1
ffffffffc0202368:	64a2                	ld	s1,8(sp)
ffffffffc020236a:	45e1                	li	a1,24
ffffffffc020236c:	6105                	addi	sp,sp,32
ffffffffc020236e:	b97d                	j	ffffffffc020202c <slob_free>
ffffffffc0202370:	c219                	beqz	a2,ffffffffc0202376 <kfree+0x9a>
ffffffffc0202372:	ac0fe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0202376:	ff040513          	addi	a0,s0,-16
ffffffffc020237a:	6442                	ld	s0,16(sp)
ffffffffc020237c:	60e2                	ld	ra,24(sp)
ffffffffc020237e:	64a2                	ld	s1,8(sp)
ffffffffc0202380:	4581                	li	a1,0
ffffffffc0202382:	6105                	addi	sp,sp,32
ffffffffc0202384:	b165                	j	ffffffffc020202c <slob_free>
ffffffffc0202386:	ab2fe0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020238a:	00017797          	auipc	a5,0x17
ffffffffc020238e:	15e7b783          	ld	a5,350(a5) # ffffffffc02194e8 <bigblocks>
ffffffffc0202392:	4605                	li	a2,1
ffffffffc0202394:	f7bd                	bnez	a5,ffffffffc0202302 <kfree+0x26>
ffffffffc0202396:	bff1                	j	ffffffffc0202372 <kfree+0x96>
ffffffffc0202398:	a9afe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020239c:	b751                	j	ffffffffc0202320 <kfree+0x44>
ffffffffc020239e:	8082                	ret
ffffffffc02023a0:	00006617          	auipc	a2,0x6
ffffffffc02023a4:	68860613          	addi	a2,a2,1672 # ffffffffc0208a28 <commands+0x700>
ffffffffc02023a8:	06200593          	li	a1,98
ffffffffc02023ac:	00006517          	auipc	a0,0x6
ffffffffc02023b0:	69c50513          	addi	a0,a0,1692 # ffffffffc0208a48 <commands+0x720>
ffffffffc02023b4:	e55fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02023b8:	86a2                	mv	a3,s0
ffffffffc02023ba:	00006617          	auipc	a2,0x6
ffffffffc02023be:	6f660613          	addi	a2,a2,1782 # ffffffffc0208ab0 <commands+0x788>
ffffffffc02023c2:	06e00593          	li	a1,110
ffffffffc02023c6:	00006517          	auipc	a0,0x6
ffffffffc02023ca:	68250513          	addi	a0,a0,1666 # ffffffffc0208a48 <commands+0x720>
ffffffffc02023ce:	e3bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02023d2 <swap_init>:
ffffffffc02023d2:	1101                	addi	sp,sp,-32
ffffffffc02023d4:	ec06                	sd	ra,24(sp)
ffffffffc02023d6:	e822                	sd	s0,16(sp)
ffffffffc02023d8:	e426                	sd	s1,8(sp)
ffffffffc02023da:	2a6010ef          	jal	ra,ffffffffc0203680 <swapfs_init>
ffffffffc02023de:	00017697          	auipc	a3,0x17
ffffffffc02023e2:	21a6b683          	ld	a3,538(a3) # ffffffffc02195f8 <max_swap_offset>
ffffffffc02023e6:	010007b7          	lui	a5,0x1000
ffffffffc02023ea:	ff968713          	addi	a4,a3,-7
ffffffffc02023ee:	17e1                	addi	a5,a5,-8
ffffffffc02023f0:	04e7e863          	bltu	a5,a4,ffffffffc0202440 <swap_init+0x6e>
ffffffffc02023f4:	0000c797          	auipc	a5,0xc
ffffffffc02023f8:	c0c78793          	addi	a5,a5,-1012 # ffffffffc020e000 <swap_manager_fifo>
ffffffffc02023fc:	6798                	ld	a4,8(a5)
ffffffffc02023fe:	00017497          	auipc	s1,0x17
ffffffffc0202402:	0f248493          	addi	s1,s1,242 # ffffffffc02194f0 <sm>
ffffffffc0202406:	e09c                	sd	a5,0(s1)
ffffffffc0202408:	9702                	jalr	a4
ffffffffc020240a:	842a                	mv	s0,a0
ffffffffc020240c:	c519                	beqz	a0,ffffffffc020241a <swap_init+0x48>
ffffffffc020240e:	60e2                	ld	ra,24(sp)
ffffffffc0202410:	8522                	mv	a0,s0
ffffffffc0202412:	6442                	ld	s0,16(sp)
ffffffffc0202414:	64a2                	ld	s1,8(sp)
ffffffffc0202416:	6105                	addi	sp,sp,32
ffffffffc0202418:	8082                	ret
ffffffffc020241a:	609c                	ld	a5,0(s1)
ffffffffc020241c:	00007517          	auipc	a0,0x7
ffffffffc0202420:	bac50513          	addi	a0,a0,-1108 # ffffffffc0208fc8 <commands+0xca0>
ffffffffc0202424:	638c                	ld	a1,0(a5)
ffffffffc0202426:	4785                	li	a5,1
ffffffffc0202428:	00017717          	auipc	a4,0x17
ffffffffc020242c:	0cf72823          	sw	a5,208(a4) # ffffffffc02194f8 <swap_init_ok>
ffffffffc0202430:	c9dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202434:	60e2                	ld	ra,24(sp)
ffffffffc0202436:	8522                	mv	a0,s0
ffffffffc0202438:	6442                	ld	s0,16(sp)
ffffffffc020243a:	64a2                	ld	s1,8(sp)
ffffffffc020243c:	6105                	addi	sp,sp,32
ffffffffc020243e:	8082                	ret
ffffffffc0202440:	00007617          	auipc	a2,0x7
ffffffffc0202444:	b5860613          	addi	a2,a2,-1192 # ffffffffc0208f98 <commands+0xc70>
ffffffffc0202448:	02800593          	li	a1,40
ffffffffc020244c:	00007517          	auipc	a0,0x7
ffffffffc0202450:	b6c50513          	addi	a0,a0,-1172 # ffffffffc0208fb8 <commands+0xc90>
ffffffffc0202454:	db5fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202458 <swap_init_mm>:
ffffffffc0202458:	00017797          	auipc	a5,0x17
ffffffffc020245c:	0987b783          	ld	a5,152(a5) # ffffffffc02194f0 <sm>
ffffffffc0202460:	0107b303          	ld	t1,16(a5)
ffffffffc0202464:	8302                	jr	t1

ffffffffc0202466 <swap_map_swappable>:
ffffffffc0202466:	00017797          	auipc	a5,0x17
ffffffffc020246a:	08a7b783          	ld	a5,138(a5) # ffffffffc02194f0 <sm>
ffffffffc020246e:	0207b303          	ld	t1,32(a5)
ffffffffc0202472:	8302                	jr	t1

ffffffffc0202474 <swap_out>:
ffffffffc0202474:	711d                	addi	sp,sp,-96
ffffffffc0202476:	ec86                	sd	ra,88(sp)
ffffffffc0202478:	e8a2                	sd	s0,80(sp)
ffffffffc020247a:	e4a6                	sd	s1,72(sp)
ffffffffc020247c:	e0ca                	sd	s2,64(sp)
ffffffffc020247e:	fc4e                	sd	s3,56(sp)
ffffffffc0202480:	f852                	sd	s4,48(sp)
ffffffffc0202482:	f456                	sd	s5,40(sp)
ffffffffc0202484:	f05a                	sd	s6,32(sp)
ffffffffc0202486:	ec5e                	sd	s7,24(sp)
ffffffffc0202488:	e862                	sd	s8,16(sp)
ffffffffc020248a:	cde9                	beqz	a1,ffffffffc0202564 <swap_out+0xf0>
ffffffffc020248c:	8a2e                	mv	s4,a1
ffffffffc020248e:	892a                	mv	s2,a0
ffffffffc0202490:	8ab2                	mv	s5,a2
ffffffffc0202492:	4401                	li	s0,0
ffffffffc0202494:	00017997          	auipc	s3,0x17
ffffffffc0202498:	05c98993          	addi	s3,s3,92 # ffffffffc02194f0 <sm>
ffffffffc020249c:	00007b17          	auipc	s6,0x7
ffffffffc02024a0:	ba4b0b13          	addi	s6,s6,-1116 # ffffffffc0209040 <commands+0xd18>
ffffffffc02024a4:	00007b97          	auipc	s7,0x7
ffffffffc02024a8:	b84b8b93          	addi	s7,s7,-1148 # ffffffffc0209028 <commands+0xd00>
ffffffffc02024ac:	a825                	j	ffffffffc02024e4 <swap_out+0x70>
ffffffffc02024ae:	67a2                	ld	a5,8(sp)
ffffffffc02024b0:	8626                	mv	a2,s1
ffffffffc02024b2:	85a2                	mv	a1,s0
ffffffffc02024b4:	7f94                	ld	a3,56(a5)
ffffffffc02024b6:	855a                	mv	a0,s6
ffffffffc02024b8:	2405                	addiw	s0,s0,1
ffffffffc02024ba:	82b1                	srli	a3,a3,0xc
ffffffffc02024bc:	0685                	addi	a3,a3,1
ffffffffc02024be:	c0ffd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02024c2:	6522                	ld	a0,8(sp)
ffffffffc02024c4:	4585                	li	a1,1
ffffffffc02024c6:	7d1c                	ld	a5,56(a0)
ffffffffc02024c8:	83b1                	srli	a5,a5,0xc
ffffffffc02024ca:	0785                	addi	a5,a5,1
ffffffffc02024cc:	07a2                	slli	a5,a5,0x8
ffffffffc02024ce:	00fc3023          	sd	a5,0(s8)
ffffffffc02024d2:	90bfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02024d6:	01893503          	ld	a0,24(s2)
ffffffffc02024da:	85a6                	mv	a1,s1
ffffffffc02024dc:	9a4ff0ef          	jal	ra,ffffffffc0201680 <tlb_invalidate>
ffffffffc02024e0:	048a0d63          	beq	s4,s0,ffffffffc020253a <swap_out+0xc6>
ffffffffc02024e4:	0009b783          	ld	a5,0(s3)
ffffffffc02024e8:	8656                	mv	a2,s5
ffffffffc02024ea:	002c                	addi	a1,sp,8
ffffffffc02024ec:	7b9c                	ld	a5,48(a5)
ffffffffc02024ee:	854a                	mv	a0,s2
ffffffffc02024f0:	9782                	jalr	a5
ffffffffc02024f2:	e12d                	bnez	a0,ffffffffc0202554 <swap_out+0xe0>
ffffffffc02024f4:	67a2                	ld	a5,8(sp)
ffffffffc02024f6:	01893503          	ld	a0,24(s2)
ffffffffc02024fa:	4601                	li	a2,0
ffffffffc02024fc:	7f84                	ld	s1,56(a5)
ffffffffc02024fe:	85a6                	mv	a1,s1
ffffffffc0202500:	aaffe0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc0202504:	611c                	ld	a5,0(a0)
ffffffffc0202506:	8c2a                	mv	s8,a0
ffffffffc0202508:	8b85                	andi	a5,a5,1
ffffffffc020250a:	cfb9                	beqz	a5,ffffffffc0202568 <swap_out+0xf4>
ffffffffc020250c:	65a2                	ld	a1,8(sp)
ffffffffc020250e:	7d9c                	ld	a5,56(a1)
ffffffffc0202510:	83b1                	srli	a5,a5,0xc
ffffffffc0202512:	0785                	addi	a5,a5,1
ffffffffc0202514:	00879513          	slli	a0,a5,0x8
ffffffffc0202518:	22e010ef          	jal	ra,ffffffffc0203746 <swapfs_write>
ffffffffc020251c:	d949                	beqz	a0,ffffffffc02024ae <swap_out+0x3a>
ffffffffc020251e:	855e                	mv	a0,s7
ffffffffc0202520:	badfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202524:	0009b783          	ld	a5,0(s3)
ffffffffc0202528:	6622                	ld	a2,8(sp)
ffffffffc020252a:	4681                	li	a3,0
ffffffffc020252c:	739c                	ld	a5,32(a5)
ffffffffc020252e:	85a6                	mv	a1,s1
ffffffffc0202530:	854a                	mv	a0,s2
ffffffffc0202532:	2405                	addiw	s0,s0,1
ffffffffc0202534:	9782                	jalr	a5
ffffffffc0202536:	fa8a17e3          	bne	s4,s0,ffffffffc02024e4 <swap_out+0x70>
ffffffffc020253a:	60e6                	ld	ra,88(sp)
ffffffffc020253c:	8522                	mv	a0,s0
ffffffffc020253e:	6446                	ld	s0,80(sp)
ffffffffc0202540:	64a6                	ld	s1,72(sp)
ffffffffc0202542:	6906                	ld	s2,64(sp)
ffffffffc0202544:	79e2                	ld	s3,56(sp)
ffffffffc0202546:	7a42                	ld	s4,48(sp)
ffffffffc0202548:	7aa2                	ld	s5,40(sp)
ffffffffc020254a:	7b02                	ld	s6,32(sp)
ffffffffc020254c:	6be2                	ld	s7,24(sp)
ffffffffc020254e:	6c42                	ld	s8,16(sp)
ffffffffc0202550:	6125                	addi	sp,sp,96
ffffffffc0202552:	8082                	ret
ffffffffc0202554:	85a2                	mv	a1,s0
ffffffffc0202556:	00007517          	auipc	a0,0x7
ffffffffc020255a:	a8a50513          	addi	a0,a0,-1398 # ffffffffc0208fe0 <commands+0xcb8>
ffffffffc020255e:	b6ffd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202562:	bfe1                	j	ffffffffc020253a <swap_out+0xc6>
ffffffffc0202564:	4401                	li	s0,0
ffffffffc0202566:	bfd1                	j	ffffffffc020253a <swap_out+0xc6>
ffffffffc0202568:	00007697          	auipc	a3,0x7
ffffffffc020256c:	aa868693          	addi	a3,a3,-1368 # ffffffffc0209010 <commands+0xce8>
ffffffffc0202570:	00006617          	auipc	a2,0x6
ffffffffc0202574:	1c860613          	addi	a2,a2,456 # ffffffffc0208738 <commands+0x410>
ffffffffc0202578:	06800593          	li	a1,104
ffffffffc020257c:	00007517          	auipc	a0,0x7
ffffffffc0202580:	a3c50513          	addi	a0,a0,-1476 # ffffffffc0208fb8 <commands+0xc90>
ffffffffc0202584:	c85fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202588 <swap_in>:
ffffffffc0202588:	7179                	addi	sp,sp,-48
ffffffffc020258a:	e84a                	sd	s2,16(sp)
ffffffffc020258c:	892a                	mv	s2,a0
ffffffffc020258e:	4505                	li	a0,1
ffffffffc0202590:	ec26                	sd	s1,24(sp)
ffffffffc0202592:	e44e                	sd	s3,8(sp)
ffffffffc0202594:	f406                	sd	ra,40(sp)
ffffffffc0202596:	f022                	sd	s0,32(sp)
ffffffffc0202598:	84ae                	mv	s1,a1
ffffffffc020259a:	89b2                	mv	s3,a2
ffffffffc020259c:	faefe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02025a0:	c129                	beqz	a0,ffffffffc02025e2 <swap_in+0x5a>
ffffffffc02025a2:	842a                	mv	s0,a0
ffffffffc02025a4:	01893503          	ld	a0,24(s2)
ffffffffc02025a8:	4601                	li	a2,0
ffffffffc02025aa:	85a6                	mv	a1,s1
ffffffffc02025ac:	a03fe0ef          	jal	ra,ffffffffc0200fae <get_pte>
ffffffffc02025b0:	892a                	mv	s2,a0
ffffffffc02025b2:	6108                	ld	a0,0(a0)
ffffffffc02025b4:	85a2                	mv	a1,s0
ffffffffc02025b6:	102010ef          	jal	ra,ffffffffc02036b8 <swapfs_read>
ffffffffc02025ba:	00093583          	ld	a1,0(s2)
ffffffffc02025be:	8626                	mv	a2,s1
ffffffffc02025c0:	00007517          	auipc	a0,0x7
ffffffffc02025c4:	ad050513          	addi	a0,a0,-1328 # ffffffffc0209090 <commands+0xd68>
ffffffffc02025c8:	81a1                	srli	a1,a1,0x8
ffffffffc02025ca:	b03fd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02025ce:	70a2                	ld	ra,40(sp)
ffffffffc02025d0:	0089b023          	sd	s0,0(s3)
ffffffffc02025d4:	7402                	ld	s0,32(sp)
ffffffffc02025d6:	64e2                	ld	s1,24(sp)
ffffffffc02025d8:	6942                	ld	s2,16(sp)
ffffffffc02025da:	69a2                	ld	s3,8(sp)
ffffffffc02025dc:	4501                	li	a0,0
ffffffffc02025de:	6145                	addi	sp,sp,48
ffffffffc02025e0:	8082                	ret
ffffffffc02025e2:	00007697          	auipc	a3,0x7
ffffffffc02025e6:	a9e68693          	addi	a3,a3,-1378 # ffffffffc0209080 <commands+0xd58>
ffffffffc02025ea:	00006617          	auipc	a2,0x6
ffffffffc02025ee:	14e60613          	addi	a2,a2,334 # ffffffffc0208738 <commands+0x410>
ffffffffc02025f2:	07e00593          	li	a1,126
ffffffffc02025f6:	00007517          	auipc	a0,0x7
ffffffffc02025fa:	9c250513          	addi	a0,a0,-1598 # ffffffffc0208fb8 <commands+0xc90>
ffffffffc02025fe:	c0bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202602 <default_init>:
ffffffffc0202602:	00017797          	auipc	a5,0x17
ffffffffc0202606:	03678793          	addi	a5,a5,54 # ffffffffc0219638 <free_area>
ffffffffc020260a:	e79c                	sd	a5,8(a5)
ffffffffc020260c:	e39c                	sd	a5,0(a5)
ffffffffc020260e:	0007a823          	sw	zero,16(a5)
ffffffffc0202612:	8082                	ret

ffffffffc0202614 <default_nr_free_pages>:
ffffffffc0202614:	00017517          	auipc	a0,0x17
ffffffffc0202618:	03456503          	lwu	a0,52(a0) # ffffffffc0219648 <free_area+0x10>
ffffffffc020261c:	8082                	ret

ffffffffc020261e <default_check>:
ffffffffc020261e:	715d                	addi	sp,sp,-80
ffffffffc0202620:	e0a2                	sd	s0,64(sp)
ffffffffc0202622:	00017417          	auipc	s0,0x17
ffffffffc0202626:	01640413          	addi	s0,s0,22 # ffffffffc0219638 <free_area>
ffffffffc020262a:	641c                	ld	a5,8(s0)
ffffffffc020262c:	e486                	sd	ra,72(sp)
ffffffffc020262e:	fc26                	sd	s1,56(sp)
ffffffffc0202630:	f84a                	sd	s2,48(sp)
ffffffffc0202632:	f44e                	sd	s3,40(sp)
ffffffffc0202634:	f052                	sd	s4,32(sp)
ffffffffc0202636:	ec56                	sd	s5,24(sp)
ffffffffc0202638:	e85a                	sd	s6,16(sp)
ffffffffc020263a:	e45e                	sd	s7,8(sp)
ffffffffc020263c:	e062                	sd	s8,0(sp)
ffffffffc020263e:	2a878d63          	beq	a5,s0,ffffffffc02028f8 <default_check+0x2da>
ffffffffc0202642:	4481                	li	s1,0
ffffffffc0202644:	4901                	li	s2,0
ffffffffc0202646:	ff07b703          	ld	a4,-16(a5)
ffffffffc020264a:	8b09                	andi	a4,a4,2
ffffffffc020264c:	2a070a63          	beqz	a4,ffffffffc0202900 <default_check+0x2e2>
ffffffffc0202650:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202654:	679c                	ld	a5,8(a5)
ffffffffc0202656:	2905                	addiw	s2,s2,1
ffffffffc0202658:	9cb9                	addw	s1,s1,a4
ffffffffc020265a:	fe8796e3          	bne	a5,s0,ffffffffc0202646 <default_check+0x28>
ffffffffc020265e:	89a6                	mv	s3,s1
ffffffffc0202660:	fbefe0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc0202664:	6f351e63          	bne	a0,s3,ffffffffc0202d60 <default_check+0x742>
ffffffffc0202668:	4505                	li	a0,1
ffffffffc020266a:	ee0fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020266e:	8aaa                	mv	s5,a0
ffffffffc0202670:	42050863          	beqz	a0,ffffffffc0202aa0 <default_check+0x482>
ffffffffc0202674:	4505                	li	a0,1
ffffffffc0202676:	ed4fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020267a:	89aa                	mv	s3,a0
ffffffffc020267c:	70050263          	beqz	a0,ffffffffc0202d80 <default_check+0x762>
ffffffffc0202680:	4505                	li	a0,1
ffffffffc0202682:	ec8fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202686:	8a2a                	mv	s4,a0
ffffffffc0202688:	48050c63          	beqz	a0,ffffffffc0202b20 <default_check+0x502>
ffffffffc020268c:	293a8a63          	beq	s5,s3,ffffffffc0202920 <default_check+0x302>
ffffffffc0202690:	28aa8863          	beq	s5,a0,ffffffffc0202920 <default_check+0x302>
ffffffffc0202694:	28a98663          	beq	s3,a0,ffffffffc0202920 <default_check+0x302>
ffffffffc0202698:	000aa783          	lw	a5,0(s5)
ffffffffc020269c:	2a079263          	bnez	a5,ffffffffc0202940 <default_check+0x322>
ffffffffc02026a0:	0009a783          	lw	a5,0(s3)
ffffffffc02026a4:	28079e63          	bnez	a5,ffffffffc0202940 <default_check+0x322>
ffffffffc02026a8:	411c                	lw	a5,0(a0)
ffffffffc02026aa:	28079b63          	bnez	a5,ffffffffc0202940 <default_check+0x322>
ffffffffc02026ae:	00017797          	auipc	a5,0x17
ffffffffc02026b2:	ea27b783          	ld	a5,-350(a5) # ffffffffc0219550 <pages>
ffffffffc02026b6:	40fa8733          	sub	a4,s5,a5
ffffffffc02026ba:	00008617          	auipc	a2,0x8
ffffffffc02026be:	1de63603          	ld	a2,478(a2) # ffffffffc020a898 <nbase>
ffffffffc02026c2:	8719                	srai	a4,a4,0x6
ffffffffc02026c4:	9732                	add	a4,a4,a2
ffffffffc02026c6:	00017697          	auipc	a3,0x17
ffffffffc02026ca:	e126b683          	ld	a3,-494(a3) # ffffffffc02194d8 <npage>
ffffffffc02026ce:	06b2                	slli	a3,a3,0xc
ffffffffc02026d0:	0732                	slli	a4,a4,0xc
ffffffffc02026d2:	28d77763          	bgeu	a4,a3,ffffffffc0202960 <default_check+0x342>
ffffffffc02026d6:	40f98733          	sub	a4,s3,a5
ffffffffc02026da:	8719                	srai	a4,a4,0x6
ffffffffc02026dc:	9732                	add	a4,a4,a2
ffffffffc02026de:	0732                	slli	a4,a4,0xc
ffffffffc02026e0:	4cd77063          	bgeu	a4,a3,ffffffffc0202ba0 <default_check+0x582>
ffffffffc02026e4:	40f507b3          	sub	a5,a0,a5
ffffffffc02026e8:	8799                	srai	a5,a5,0x6
ffffffffc02026ea:	97b2                	add	a5,a5,a2
ffffffffc02026ec:	07b2                	slli	a5,a5,0xc
ffffffffc02026ee:	30d7f963          	bgeu	a5,a3,ffffffffc0202a00 <default_check+0x3e2>
ffffffffc02026f2:	4505                	li	a0,1
ffffffffc02026f4:	00043c03          	ld	s8,0(s0)
ffffffffc02026f8:	00843b83          	ld	s7,8(s0)
ffffffffc02026fc:	01042b03          	lw	s6,16(s0)
ffffffffc0202700:	e400                	sd	s0,8(s0)
ffffffffc0202702:	e000                	sd	s0,0(s0)
ffffffffc0202704:	00017797          	auipc	a5,0x17
ffffffffc0202708:	f407a223          	sw	zero,-188(a5) # ffffffffc0219648 <free_area+0x10>
ffffffffc020270c:	e3efe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202710:	2c051863          	bnez	a0,ffffffffc02029e0 <default_check+0x3c2>
ffffffffc0202714:	4585                	li	a1,1
ffffffffc0202716:	8556                	mv	a0,s5
ffffffffc0202718:	ec4fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020271c:	4585                	li	a1,1
ffffffffc020271e:	854e                	mv	a0,s3
ffffffffc0202720:	ebcfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202724:	4585                	li	a1,1
ffffffffc0202726:	8552                	mv	a0,s4
ffffffffc0202728:	eb4fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020272c:	4818                	lw	a4,16(s0)
ffffffffc020272e:	478d                	li	a5,3
ffffffffc0202730:	28f71863          	bne	a4,a5,ffffffffc02029c0 <default_check+0x3a2>
ffffffffc0202734:	4505                	li	a0,1
ffffffffc0202736:	e14fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020273a:	89aa                	mv	s3,a0
ffffffffc020273c:	26050263          	beqz	a0,ffffffffc02029a0 <default_check+0x382>
ffffffffc0202740:	4505                	li	a0,1
ffffffffc0202742:	e08fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202746:	8aaa                	mv	s5,a0
ffffffffc0202748:	3a050c63          	beqz	a0,ffffffffc0202b00 <default_check+0x4e2>
ffffffffc020274c:	4505                	li	a0,1
ffffffffc020274e:	dfcfe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202752:	8a2a                	mv	s4,a0
ffffffffc0202754:	38050663          	beqz	a0,ffffffffc0202ae0 <default_check+0x4c2>
ffffffffc0202758:	4505                	li	a0,1
ffffffffc020275a:	df0fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020275e:	36051163          	bnez	a0,ffffffffc0202ac0 <default_check+0x4a2>
ffffffffc0202762:	4585                	li	a1,1
ffffffffc0202764:	854e                	mv	a0,s3
ffffffffc0202766:	e76fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020276a:	641c                	ld	a5,8(s0)
ffffffffc020276c:	20878a63          	beq	a5,s0,ffffffffc0202980 <default_check+0x362>
ffffffffc0202770:	4505                	li	a0,1
ffffffffc0202772:	dd8fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202776:	30a99563          	bne	s3,a0,ffffffffc0202a80 <default_check+0x462>
ffffffffc020277a:	4505                	li	a0,1
ffffffffc020277c:	dcefe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202780:	2e051063          	bnez	a0,ffffffffc0202a60 <default_check+0x442>
ffffffffc0202784:	481c                	lw	a5,16(s0)
ffffffffc0202786:	2a079d63          	bnez	a5,ffffffffc0202a40 <default_check+0x422>
ffffffffc020278a:	854e                	mv	a0,s3
ffffffffc020278c:	4585                	li	a1,1
ffffffffc020278e:	01843023          	sd	s8,0(s0)
ffffffffc0202792:	01743423          	sd	s7,8(s0)
ffffffffc0202796:	01642823          	sw	s6,16(s0)
ffffffffc020279a:	e42fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020279e:	4585                	li	a1,1
ffffffffc02027a0:	8556                	mv	a0,s5
ffffffffc02027a2:	e3afe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027a6:	4585                	li	a1,1
ffffffffc02027a8:	8552                	mv	a0,s4
ffffffffc02027aa:	e32fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027ae:	4515                	li	a0,5
ffffffffc02027b0:	d9afe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027b4:	89aa                	mv	s3,a0
ffffffffc02027b6:	26050563          	beqz	a0,ffffffffc0202a20 <default_check+0x402>
ffffffffc02027ba:	651c                	ld	a5,8(a0)
ffffffffc02027bc:	8385                	srli	a5,a5,0x1
ffffffffc02027be:	8b85                	andi	a5,a5,1
ffffffffc02027c0:	54079063          	bnez	a5,ffffffffc0202d00 <default_check+0x6e2>
ffffffffc02027c4:	4505                	li	a0,1
ffffffffc02027c6:	00043b03          	ld	s6,0(s0)
ffffffffc02027ca:	00843a83          	ld	s5,8(s0)
ffffffffc02027ce:	e000                	sd	s0,0(s0)
ffffffffc02027d0:	e400                	sd	s0,8(s0)
ffffffffc02027d2:	d78fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027d6:	50051563          	bnez	a0,ffffffffc0202ce0 <default_check+0x6c2>
ffffffffc02027da:	08098a13          	addi	s4,s3,128
ffffffffc02027de:	8552                	mv	a0,s4
ffffffffc02027e0:	458d                	li	a1,3
ffffffffc02027e2:	01042b83          	lw	s7,16(s0)
ffffffffc02027e6:	00017797          	auipc	a5,0x17
ffffffffc02027ea:	e607a123          	sw	zero,-414(a5) # ffffffffc0219648 <free_area+0x10>
ffffffffc02027ee:	deefe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02027f2:	4511                	li	a0,4
ffffffffc02027f4:	d56fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02027f8:	4c051463          	bnez	a0,ffffffffc0202cc0 <default_check+0x6a2>
ffffffffc02027fc:	0889b783          	ld	a5,136(s3)
ffffffffc0202800:	8385                	srli	a5,a5,0x1
ffffffffc0202802:	8b85                	andi	a5,a5,1
ffffffffc0202804:	48078e63          	beqz	a5,ffffffffc0202ca0 <default_check+0x682>
ffffffffc0202808:	0909a703          	lw	a4,144(s3)
ffffffffc020280c:	478d                	li	a5,3
ffffffffc020280e:	48f71963          	bne	a4,a5,ffffffffc0202ca0 <default_check+0x682>
ffffffffc0202812:	450d                	li	a0,3
ffffffffc0202814:	d36fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202818:	8c2a                	mv	s8,a0
ffffffffc020281a:	46050363          	beqz	a0,ffffffffc0202c80 <default_check+0x662>
ffffffffc020281e:	4505                	li	a0,1
ffffffffc0202820:	d2afe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202824:	42051e63          	bnez	a0,ffffffffc0202c60 <default_check+0x642>
ffffffffc0202828:	418a1c63          	bne	s4,s8,ffffffffc0202c40 <default_check+0x622>
ffffffffc020282c:	4585                	li	a1,1
ffffffffc020282e:	854e                	mv	a0,s3
ffffffffc0202830:	dacfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202834:	458d                	li	a1,3
ffffffffc0202836:	8552                	mv	a0,s4
ffffffffc0202838:	da4fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020283c:	0089b783          	ld	a5,8(s3)
ffffffffc0202840:	04098c13          	addi	s8,s3,64
ffffffffc0202844:	8385                	srli	a5,a5,0x1
ffffffffc0202846:	8b85                	andi	a5,a5,1
ffffffffc0202848:	3c078c63          	beqz	a5,ffffffffc0202c20 <default_check+0x602>
ffffffffc020284c:	0109a703          	lw	a4,16(s3)
ffffffffc0202850:	4785                	li	a5,1
ffffffffc0202852:	3cf71763          	bne	a4,a5,ffffffffc0202c20 <default_check+0x602>
ffffffffc0202856:	008a3783          	ld	a5,8(s4) # 1008 <kern_entry-0xffffffffc01feff8>
ffffffffc020285a:	8385                	srli	a5,a5,0x1
ffffffffc020285c:	8b85                	andi	a5,a5,1
ffffffffc020285e:	3a078163          	beqz	a5,ffffffffc0202c00 <default_check+0x5e2>
ffffffffc0202862:	010a2703          	lw	a4,16(s4)
ffffffffc0202866:	478d                	li	a5,3
ffffffffc0202868:	38f71c63          	bne	a4,a5,ffffffffc0202c00 <default_check+0x5e2>
ffffffffc020286c:	4505                	li	a0,1
ffffffffc020286e:	cdcfe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202872:	36a99763          	bne	s3,a0,ffffffffc0202be0 <default_check+0x5c2>
ffffffffc0202876:	4585                	li	a1,1
ffffffffc0202878:	d64fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020287c:	4509                	li	a0,2
ffffffffc020287e:	cccfe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0202882:	32aa1f63          	bne	s4,a0,ffffffffc0202bc0 <default_check+0x5a2>
ffffffffc0202886:	4589                	li	a1,2
ffffffffc0202888:	d54fe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc020288c:	4585                	li	a1,1
ffffffffc020288e:	8562                	mv	a0,s8
ffffffffc0202890:	d4cfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0202894:	4515                	li	a0,5
ffffffffc0202896:	cb4fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020289a:	89aa                	mv	s3,a0
ffffffffc020289c:	48050263          	beqz	a0,ffffffffc0202d20 <default_check+0x702>
ffffffffc02028a0:	4505                	li	a0,1
ffffffffc02028a2:	ca8fe0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02028a6:	2c051d63          	bnez	a0,ffffffffc0202b80 <default_check+0x562>
ffffffffc02028aa:	481c                	lw	a5,16(s0)
ffffffffc02028ac:	2a079a63          	bnez	a5,ffffffffc0202b60 <default_check+0x542>
ffffffffc02028b0:	4595                	li	a1,5
ffffffffc02028b2:	854e                	mv	a0,s3
ffffffffc02028b4:	01742823          	sw	s7,16(s0)
ffffffffc02028b8:	01643023          	sd	s6,0(s0)
ffffffffc02028bc:	01543423          	sd	s5,8(s0)
ffffffffc02028c0:	d1cfe0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02028c4:	641c                	ld	a5,8(s0)
ffffffffc02028c6:	00878963          	beq	a5,s0,ffffffffc02028d8 <default_check+0x2ba>
ffffffffc02028ca:	ff87a703          	lw	a4,-8(a5)
ffffffffc02028ce:	679c                	ld	a5,8(a5)
ffffffffc02028d0:	397d                	addiw	s2,s2,-1
ffffffffc02028d2:	9c99                	subw	s1,s1,a4
ffffffffc02028d4:	fe879be3          	bne	a5,s0,ffffffffc02028ca <default_check+0x2ac>
ffffffffc02028d8:	26091463          	bnez	s2,ffffffffc0202b40 <default_check+0x522>
ffffffffc02028dc:	46049263          	bnez	s1,ffffffffc0202d40 <default_check+0x722>
ffffffffc02028e0:	60a6                	ld	ra,72(sp)
ffffffffc02028e2:	6406                	ld	s0,64(sp)
ffffffffc02028e4:	74e2                	ld	s1,56(sp)
ffffffffc02028e6:	7942                	ld	s2,48(sp)
ffffffffc02028e8:	79a2                	ld	s3,40(sp)
ffffffffc02028ea:	7a02                	ld	s4,32(sp)
ffffffffc02028ec:	6ae2                	ld	s5,24(sp)
ffffffffc02028ee:	6b42                	ld	s6,16(sp)
ffffffffc02028f0:	6ba2                	ld	s7,8(sp)
ffffffffc02028f2:	6c02                	ld	s8,0(sp)
ffffffffc02028f4:	6161                	addi	sp,sp,80
ffffffffc02028f6:	8082                	ret
ffffffffc02028f8:	4981                	li	s3,0
ffffffffc02028fa:	4481                	li	s1,0
ffffffffc02028fc:	4901                	li	s2,0
ffffffffc02028fe:	b38d                	j	ffffffffc0202660 <default_check+0x42>
ffffffffc0202900:	00006697          	auipc	a3,0x6
ffffffffc0202904:	7d068693          	addi	a3,a3,2000 # ffffffffc02090d0 <commands+0xda8>
ffffffffc0202908:	00006617          	auipc	a2,0x6
ffffffffc020290c:	e3060613          	addi	a2,a2,-464 # ffffffffc0208738 <commands+0x410>
ffffffffc0202910:	0f000593          	li	a1,240
ffffffffc0202914:	00006517          	auipc	a0,0x6
ffffffffc0202918:	7cc50513          	addi	a0,a0,1996 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc020291c:	8edfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202920:	00007697          	auipc	a3,0x7
ffffffffc0202924:	85868693          	addi	a3,a3,-1960 # ffffffffc0209178 <commands+0xe50>
ffffffffc0202928:	00006617          	auipc	a2,0x6
ffffffffc020292c:	e1060613          	addi	a2,a2,-496 # ffffffffc0208738 <commands+0x410>
ffffffffc0202930:	0bd00593          	li	a1,189
ffffffffc0202934:	00006517          	auipc	a0,0x6
ffffffffc0202938:	7ac50513          	addi	a0,a0,1964 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc020293c:	8cdfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202940:	00007697          	auipc	a3,0x7
ffffffffc0202944:	86068693          	addi	a3,a3,-1952 # ffffffffc02091a0 <commands+0xe78>
ffffffffc0202948:	00006617          	auipc	a2,0x6
ffffffffc020294c:	df060613          	addi	a2,a2,-528 # ffffffffc0208738 <commands+0x410>
ffffffffc0202950:	0be00593          	li	a1,190
ffffffffc0202954:	00006517          	auipc	a0,0x6
ffffffffc0202958:	78c50513          	addi	a0,a0,1932 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc020295c:	8adfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202960:	00007697          	auipc	a3,0x7
ffffffffc0202964:	88068693          	addi	a3,a3,-1920 # ffffffffc02091e0 <commands+0xeb8>
ffffffffc0202968:	00006617          	auipc	a2,0x6
ffffffffc020296c:	dd060613          	addi	a2,a2,-560 # ffffffffc0208738 <commands+0x410>
ffffffffc0202970:	0c000593          	li	a1,192
ffffffffc0202974:	00006517          	auipc	a0,0x6
ffffffffc0202978:	76c50513          	addi	a0,a0,1900 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc020297c:	88dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202980:	00007697          	auipc	a3,0x7
ffffffffc0202984:	8e868693          	addi	a3,a3,-1816 # ffffffffc0209268 <commands+0xf40>
ffffffffc0202988:	00006617          	auipc	a2,0x6
ffffffffc020298c:	db060613          	addi	a2,a2,-592 # ffffffffc0208738 <commands+0x410>
ffffffffc0202990:	0d900593          	li	a1,217
ffffffffc0202994:	00006517          	auipc	a0,0x6
ffffffffc0202998:	74c50513          	addi	a0,a0,1868 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc020299c:	86dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029a0:	00006697          	auipc	a3,0x6
ffffffffc02029a4:	77868693          	addi	a3,a3,1912 # ffffffffc0209118 <commands+0xdf0>
ffffffffc02029a8:	00006617          	auipc	a2,0x6
ffffffffc02029ac:	d9060613          	addi	a2,a2,-624 # ffffffffc0208738 <commands+0x410>
ffffffffc02029b0:	0d200593          	li	a1,210
ffffffffc02029b4:	00006517          	auipc	a0,0x6
ffffffffc02029b8:	72c50513          	addi	a0,a0,1836 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc02029bc:	84dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029c0:	00007697          	auipc	a3,0x7
ffffffffc02029c4:	89868693          	addi	a3,a3,-1896 # ffffffffc0209258 <commands+0xf30>
ffffffffc02029c8:	00006617          	auipc	a2,0x6
ffffffffc02029cc:	d7060613          	addi	a2,a2,-656 # ffffffffc0208738 <commands+0x410>
ffffffffc02029d0:	0d000593          	li	a1,208
ffffffffc02029d4:	00006517          	auipc	a0,0x6
ffffffffc02029d8:	70c50513          	addi	a0,a0,1804 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc02029dc:	82dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029e0:	00007697          	auipc	a3,0x7
ffffffffc02029e4:	86068693          	addi	a3,a3,-1952 # ffffffffc0209240 <commands+0xf18>
ffffffffc02029e8:	00006617          	auipc	a2,0x6
ffffffffc02029ec:	d5060613          	addi	a2,a2,-688 # ffffffffc0208738 <commands+0x410>
ffffffffc02029f0:	0cb00593          	li	a1,203
ffffffffc02029f4:	00006517          	auipc	a0,0x6
ffffffffc02029f8:	6ec50513          	addi	a0,a0,1772 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc02029fc:	80dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a00:	00007697          	auipc	a3,0x7
ffffffffc0202a04:	82068693          	addi	a3,a3,-2016 # ffffffffc0209220 <commands+0xef8>
ffffffffc0202a08:	00006617          	auipc	a2,0x6
ffffffffc0202a0c:	d3060613          	addi	a2,a2,-720 # ffffffffc0208738 <commands+0x410>
ffffffffc0202a10:	0c200593          	li	a1,194
ffffffffc0202a14:	00006517          	auipc	a0,0x6
ffffffffc0202a18:	6cc50513          	addi	a0,a0,1740 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202a1c:	fecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a20:	00007697          	auipc	a3,0x7
ffffffffc0202a24:	89068693          	addi	a3,a3,-1904 # ffffffffc02092b0 <commands+0xf88>
ffffffffc0202a28:	00006617          	auipc	a2,0x6
ffffffffc0202a2c:	d1060613          	addi	a2,a2,-752 # ffffffffc0208738 <commands+0x410>
ffffffffc0202a30:	0f800593          	li	a1,248
ffffffffc0202a34:	00006517          	auipc	a0,0x6
ffffffffc0202a38:	6ac50513          	addi	a0,a0,1708 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202a3c:	fccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a40:	00007697          	auipc	a3,0x7
ffffffffc0202a44:	86068693          	addi	a3,a3,-1952 # ffffffffc02092a0 <commands+0xf78>
ffffffffc0202a48:	00006617          	auipc	a2,0x6
ffffffffc0202a4c:	cf060613          	addi	a2,a2,-784 # ffffffffc0208738 <commands+0x410>
ffffffffc0202a50:	0df00593          	li	a1,223
ffffffffc0202a54:	00006517          	auipc	a0,0x6
ffffffffc0202a58:	68c50513          	addi	a0,a0,1676 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202a5c:	facfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a60:	00006697          	auipc	a3,0x6
ffffffffc0202a64:	7e068693          	addi	a3,a3,2016 # ffffffffc0209240 <commands+0xf18>
ffffffffc0202a68:	00006617          	auipc	a2,0x6
ffffffffc0202a6c:	cd060613          	addi	a2,a2,-816 # ffffffffc0208738 <commands+0x410>
ffffffffc0202a70:	0dd00593          	li	a1,221
ffffffffc0202a74:	00006517          	auipc	a0,0x6
ffffffffc0202a78:	66c50513          	addi	a0,a0,1644 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202a7c:	f8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a80:	00007697          	auipc	a3,0x7
ffffffffc0202a84:	80068693          	addi	a3,a3,-2048 # ffffffffc0209280 <commands+0xf58>
ffffffffc0202a88:	00006617          	auipc	a2,0x6
ffffffffc0202a8c:	cb060613          	addi	a2,a2,-848 # ffffffffc0208738 <commands+0x410>
ffffffffc0202a90:	0dc00593          	li	a1,220
ffffffffc0202a94:	00006517          	auipc	a0,0x6
ffffffffc0202a98:	64c50513          	addi	a0,a0,1612 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202a9c:	f6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202aa0:	00006697          	auipc	a3,0x6
ffffffffc0202aa4:	67868693          	addi	a3,a3,1656 # ffffffffc0209118 <commands+0xdf0>
ffffffffc0202aa8:	00006617          	auipc	a2,0x6
ffffffffc0202aac:	c9060613          	addi	a2,a2,-880 # ffffffffc0208738 <commands+0x410>
ffffffffc0202ab0:	0b900593          	li	a1,185
ffffffffc0202ab4:	00006517          	auipc	a0,0x6
ffffffffc0202ab8:	62c50513          	addi	a0,a0,1580 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202abc:	f4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac0:	00006697          	auipc	a3,0x6
ffffffffc0202ac4:	78068693          	addi	a3,a3,1920 # ffffffffc0209240 <commands+0xf18>
ffffffffc0202ac8:	00006617          	auipc	a2,0x6
ffffffffc0202acc:	c7060613          	addi	a2,a2,-912 # ffffffffc0208738 <commands+0x410>
ffffffffc0202ad0:	0d600593          	li	a1,214
ffffffffc0202ad4:	00006517          	auipc	a0,0x6
ffffffffc0202ad8:	60c50513          	addi	a0,a0,1548 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202adc:	f2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae0:	00006697          	auipc	a3,0x6
ffffffffc0202ae4:	67868693          	addi	a3,a3,1656 # ffffffffc0209158 <commands+0xe30>
ffffffffc0202ae8:	00006617          	auipc	a2,0x6
ffffffffc0202aec:	c5060613          	addi	a2,a2,-944 # ffffffffc0208738 <commands+0x410>
ffffffffc0202af0:	0d400593          	li	a1,212
ffffffffc0202af4:	00006517          	auipc	a0,0x6
ffffffffc0202af8:	5ec50513          	addi	a0,a0,1516 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202afc:	f0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b00:	00006697          	auipc	a3,0x6
ffffffffc0202b04:	63868693          	addi	a3,a3,1592 # ffffffffc0209138 <commands+0xe10>
ffffffffc0202b08:	00006617          	auipc	a2,0x6
ffffffffc0202b0c:	c3060613          	addi	a2,a2,-976 # ffffffffc0208738 <commands+0x410>
ffffffffc0202b10:	0d300593          	li	a1,211
ffffffffc0202b14:	00006517          	auipc	a0,0x6
ffffffffc0202b18:	5cc50513          	addi	a0,a0,1484 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202b1c:	eecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b20:	00006697          	auipc	a3,0x6
ffffffffc0202b24:	63868693          	addi	a3,a3,1592 # ffffffffc0209158 <commands+0xe30>
ffffffffc0202b28:	00006617          	auipc	a2,0x6
ffffffffc0202b2c:	c1060613          	addi	a2,a2,-1008 # ffffffffc0208738 <commands+0x410>
ffffffffc0202b30:	0bb00593          	li	a1,187
ffffffffc0202b34:	00006517          	auipc	a0,0x6
ffffffffc0202b38:	5ac50513          	addi	a0,a0,1452 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202b3c:	eccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b40:	00007697          	auipc	a3,0x7
ffffffffc0202b44:	8c068693          	addi	a3,a3,-1856 # ffffffffc0209400 <commands+0x10d8>
ffffffffc0202b48:	00006617          	auipc	a2,0x6
ffffffffc0202b4c:	bf060613          	addi	a2,a2,-1040 # ffffffffc0208738 <commands+0x410>
ffffffffc0202b50:	12500593          	li	a1,293
ffffffffc0202b54:	00006517          	auipc	a0,0x6
ffffffffc0202b58:	58c50513          	addi	a0,a0,1420 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202b5c:	eacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b60:	00006697          	auipc	a3,0x6
ffffffffc0202b64:	74068693          	addi	a3,a3,1856 # ffffffffc02092a0 <commands+0xf78>
ffffffffc0202b68:	00006617          	auipc	a2,0x6
ffffffffc0202b6c:	bd060613          	addi	a2,a2,-1072 # ffffffffc0208738 <commands+0x410>
ffffffffc0202b70:	11a00593          	li	a1,282
ffffffffc0202b74:	00006517          	auipc	a0,0x6
ffffffffc0202b78:	56c50513          	addi	a0,a0,1388 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202b7c:	e8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b80:	00006697          	auipc	a3,0x6
ffffffffc0202b84:	6c068693          	addi	a3,a3,1728 # ffffffffc0209240 <commands+0xf18>
ffffffffc0202b88:	00006617          	auipc	a2,0x6
ffffffffc0202b8c:	bb060613          	addi	a2,a2,-1104 # ffffffffc0208738 <commands+0x410>
ffffffffc0202b90:	11800593          	li	a1,280
ffffffffc0202b94:	00006517          	auipc	a0,0x6
ffffffffc0202b98:	54c50513          	addi	a0,a0,1356 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202b9c:	e6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ba0:	00006697          	auipc	a3,0x6
ffffffffc0202ba4:	66068693          	addi	a3,a3,1632 # ffffffffc0209200 <commands+0xed8>
ffffffffc0202ba8:	00006617          	auipc	a2,0x6
ffffffffc0202bac:	b9060613          	addi	a2,a2,-1136 # ffffffffc0208738 <commands+0x410>
ffffffffc0202bb0:	0c100593          	li	a1,193
ffffffffc0202bb4:	00006517          	auipc	a0,0x6
ffffffffc0202bb8:	52c50513          	addi	a0,a0,1324 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202bbc:	e4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202bc0:	00007697          	auipc	a3,0x7
ffffffffc0202bc4:	80068693          	addi	a3,a3,-2048 # ffffffffc02093c0 <commands+0x1098>
ffffffffc0202bc8:	00006617          	auipc	a2,0x6
ffffffffc0202bcc:	b7060613          	addi	a2,a2,-1168 # ffffffffc0208738 <commands+0x410>
ffffffffc0202bd0:	11200593          	li	a1,274
ffffffffc0202bd4:	00006517          	auipc	a0,0x6
ffffffffc0202bd8:	50c50513          	addi	a0,a0,1292 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202bdc:	e2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202be0:	00006697          	auipc	a3,0x6
ffffffffc0202be4:	7c068693          	addi	a3,a3,1984 # ffffffffc02093a0 <commands+0x1078>
ffffffffc0202be8:	00006617          	auipc	a2,0x6
ffffffffc0202bec:	b5060613          	addi	a2,a2,-1200 # ffffffffc0208738 <commands+0x410>
ffffffffc0202bf0:	11000593          	li	a1,272
ffffffffc0202bf4:	00006517          	auipc	a0,0x6
ffffffffc0202bf8:	4ec50513          	addi	a0,a0,1260 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202bfc:	e0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c00:	00006697          	auipc	a3,0x6
ffffffffc0202c04:	77868693          	addi	a3,a3,1912 # ffffffffc0209378 <commands+0x1050>
ffffffffc0202c08:	00006617          	auipc	a2,0x6
ffffffffc0202c0c:	b3060613          	addi	a2,a2,-1232 # ffffffffc0208738 <commands+0x410>
ffffffffc0202c10:	10e00593          	li	a1,270
ffffffffc0202c14:	00006517          	auipc	a0,0x6
ffffffffc0202c18:	4cc50513          	addi	a0,a0,1228 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202c1c:	decfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c20:	00006697          	auipc	a3,0x6
ffffffffc0202c24:	73068693          	addi	a3,a3,1840 # ffffffffc0209350 <commands+0x1028>
ffffffffc0202c28:	00006617          	auipc	a2,0x6
ffffffffc0202c2c:	b1060613          	addi	a2,a2,-1264 # ffffffffc0208738 <commands+0x410>
ffffffffc0202c30:	10d00593          	li	a1,269
ffffffffc0202c34:	00006517          	auipc	a0,0x6
ffffffffc0202c38:	4ac50513          	addi	a0,a0,1196 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202c3c:	dccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c40:	00006697          	auipc	a3,0x6
ffffffffc0202c44:	70068693          	addi	a3,a3,1792 # ffffffffc0209340 <commands+0x1018>
ffffffffc0202c48:	00006617          	auipc	a2,0x6
ffffffffc0202c4c:	af060613          	addi	a2,a2,-1296 # ffffffffc0208738 <commands+0x410>
ffffffffc0202c50:	10800593          	li	a1,264
ffffffffc0202c54:	00006517          	auipc	a0,0x6
ffffffffc0202c58:	48c50513          	addi	a0,a0,1164 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202c5c:	dacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c60:	00006697          	auipc	a3,0x6
ffffffffc0202c64:	5e068693          	addi	a3,a3,1504 # ffffffffc0209240 <commands+0xf18>
ffffffffc0202c68:	00006617          	auipc	a2,0x6
ffffffffc0202c6c:	ad060613          	addi	a2,a2,-1328 # ffffffffc0208738 <commands+0x410>
ffffffffc0202c70:	10700593          	li	a1,263
ffffffffc0202c74:	00006517          	auipc	a0,0x6
ffffffffc0202c78:	46c50513          	addi	a0,a0,1132 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202c7c:	d8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c80:	00006697          	auipc	a3,0x6
ffffffffc0202c84:	6a068693          	addi	a3,a3,1696 # ffffffffc0209320 <commands+0xff8>
ffffffffc0202c88:	00006617          	auipc	a2,0x6
ffffffffc0202c8c:	ab060613          	addi	a2,a2,-1360 # ffffffffc0208738 <commands+0x410>
ffffffffc0202c90:	10600593          	li	a1,262
ffffffffc0202c94:	00006517          	auipc	a0,0x6
ffffffffc0202c98:	44c50513          	addi	a0,a0,1100 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202c9c:	d6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ca0:	00006697          	auipc	a3,0x6
ffffffffc0202ca4:	65068693          	addi	a3,a3,1616 # ffffffffc02092f0 <commands+0xfc8>
ffffffffc0202ca8:	00006617          	auipc	a2,0x6
ffffffffc0202cac:	a9060613          	addi	a2,a2,-1392 # ffffffffc0208738 <commands+0x410>
ffffffffc0202cb0:	10500593          	li	a1,261
ffffffffc0202cb4:	00006517          	auipc	a0,0x6
ffffffffc0202cb8:	42c50513          	addi	a0,a0,1068 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202cbc:	d4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202cc0:	00006697          	auipc	a3,0x6
ffffffffc0202cc4:	61868693          	addi	a3,a3,1560 # ffffffffc02092d8 <commands+0xfb0>
ffffffffc0202cc8:	00006617          	auipc	a2,0x6
ffffffffc0202ccc:	a7060613          	addi	a2,a2,-1424 # ffffffffc0208738 <commands+0x410>
ffffffffc0202cd0:	10400593          	li	a1,260
ffffffffc0202cd4:	00006517          	auipc	a0,0x6
ffffffffc0202cd8:	40c50513          	addi	a0,a0,1036 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202cdc:	d2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce0:	00006697          	auipc	a3,0x6
ffffffffc0202ce4:	56068693          	addi	a3,a3,1376 # ffffffffc0209240 <commands+0xf18>
ffffffffc0202ce8:	00006617          	auipc	a2,0x6
ffffffffc0202cec:	a5060613          	addi	a2,a2,-1456 # ffffffffc0208738 <commands+0x410>
ffffffffc0202cf0:	0fe00593          	li	a1,254
ffffffffc0202cf4:	00006517          	auipc	a0,0x6
ffffffffc0202cf8:	3ec50513          	addi	a0,a0,1004 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202cfc:	d0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d00:	00006697          	auipc	a3,0x6
ffffffffc0202d04:	5c068693          	addi	a3,a3,1472 # ffffffffc02092c0 <commands+0xf98>
ffffffffc0202d08:	00006617          	auipc	a2,0x6
ffffffffc0202d0c:	a3060613          	addi	a2,a2,-1488 # ffffffffc0208738 <commands+0x410>
ffffffffc0202d10:	0f900593          	li	a1,249
ffffffffc0202d14:	00006517          	auipc	a0,0x6
ffffffffc0202d18:	3cc50513          	addi	a0,a0,972 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202d1c:	cecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d20:	00006697          	auipc	a3,0x6
ffffffffc0202d24:	6c068693          	addi	a3,a3,1728 # ffffffffc02093e0 <commands+0x10b8>
ffffffffc0202d28:	00006617          	auipc	a2,0x6
ffffffffc0202d2c:	a1060613          	addi	a2,a2,-1520 # ffffffffc0208738 <commands+0x410>
ffffffffc0202d30:	11700593          	li	a1,279
ffffffffc0202d34:	00006517          	auipc	a0,0x6
ffffffffc0202d38:	3ac50513          	addi	a0,a0,940 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202d3c:	cccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d40:	00006697          	auipc	a3,0x6
ffffffffc0202d44:	6d068693          	addi	a3,a3,1744 # ffffffffc0209410 <commands+0x10e8>
ffffffffc0202d48:	00006617          	auipc	a2,0x6
ffffffffc0202d4c:	9f060613          	addi	a2,a2,-1552 # ffffffffc0208738 <commands+0x410>
ffffffffc0202d50:	12600593          	li	a1,294
ffffffffc0202d54:	00006517          	auipc	a0,0x6
ffffffffc0202d58:	38c50513          	addi	a0,a0,908 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202d5c:	cacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d60:	00006697          	auipc	a3,0x6
ffffffffc0202d64:	39868693          	addi	a3,a3,920 # ffffffffc02090f8 <commands+0xdd0>
ffffffffc0202d68:	00006617          	auipc	a2,0x6
ffffffffc0202d6c:	9d060613          	addi	a2,a2,-1584 # ffffffffc0208738 <commands+0x410>
ffffffffc0202d70:	0f300593          	li	a1,243
ffffffffc0202d74:	00006517          	auipc	a0,0x6
ffffffffc0202d78:	36c50513          	addi	a0,a0,876 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202d7c:	c8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d80:	00006697          	auipc	a3,0x6
ffffffffc0202d84:	3b868693          	addi	a3,a3,952 # ffffffffc0209138 <commands+0xe10>
ffffffffc0202d88:	00006617          	auipc	a2,0x6
ffffffffc0202d8c:	9b060613          	addi	a2,a2,-1616 # ffffffffc0208738 <commands+0x410>
ffffffffc0202d90:	0ba00593          	li	a1,186
ffffffffc0202d94:	00006517          	auipc	a0,0x6
ffffffffc0202d98:	34c50513          	addi	a0,a0,844 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202d9c:	c6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202da0 <default_free_pages>:
ffffffffc0202da0:	1141                	addi	sp,sp,-16
ffffffffc0202da2:	e406                	sd	ra,8(sp)
ffffffffc0202da4:	12058f63          	beqz	a1,ffffffffc0202ee2 <default_free_pages+0x142>
ffffffffc0202da8:	00659693          	slli	a3,a1,0x6
ffffffffc0202dac:	96aa                	add	a3,a3,a0
ffffffffc0202dae:	87aa                	mv	a5,a0
ffffffffc0202db0:	02d50263          	beq	a0,a3,ffffffffc0202dd4 <default_free_pages+0x34>
ffffffffc0202db4:	6798                	ld	a4,8(a5)
ffffffffc0202db6:	8b05                	andi	a4,a4,1
ffffffffc0202db8:	10071563          	bnez	a4,ffffffffc0202ec2 <default_free_pages+0x122>
ffffffffc0202dbc:	6798                	ld	a4,8(a5)
ffffffffc0202dbe:	8b09                	andi	a4,a4,2
ffffffffc0202dc0:	10071163          	bnez	a4,ffffffffc0202ec2 <default_free_pages+0x122>
ffffffffc0202dc4:	0007b423          	sd	zero,8(a5)
ffffffffc0202dc8:	0007a023          	sw	zero,0(a5)
ffffffffc0202dcc:	04078793          	addi	a5,a5,64
ffffffffc0202dd0:	fed792e3          	bne	a5,a3,ffffffffc0202db4 <default_free_pages+0x14>
ffffffffc0202dd4:	2581                	sext.w	a1,a1
ffffffffc0202dd6:	c90c                	sw	a1,16(a0)
ffffffffc0202dd8:	00850893          	addi	a7,a0,8
ffffffffc0202ddc:	4789                	li	a5,2
ffffffffc0202dde:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0202de2:	00017697          	auipc	a3,0x17
ffffffffc0202de6:	85668693          	addi	a3,a3,-1962 # ffffffffc0219638 <free_area>
ffffffffc0202dea:	4a98                	lw	a4,16(a3)
ffffffffc0202dec:	669c                	ld	a5,8(a3)
ffffffffc0202dee:	01850613          	addi	a2,a0,24
ffffffffc0202df2:	9db9                	addw	a1,a1,a4
ffffffffc0202df4:	ca8c                	sw	a1,16(a3)
ffffffffc0202df6:	08d78f63          	beq	a5,a3,ffffffffc0202e94 <default_free_pages+0xf4>
ffffffffc0202dfa:	fe878713          	addi	a4,a5,-24
ffffffffc0202dfe:	0006b803          	ld	a6,0(a3)
ffffffffc0202e02:	4581                	li	a1,0
ffffffffc0202e04:	00e56a63          	bltu	a0,a4,ffffffffc0202e18 <default_free_pages+0x78>
ffffffffc0202e08:	6798                	ld	a4,8(a5)
ffffffffc0202e0a:	04d70a63          	beq	a4,a3,ffffffffc0202e5e <default_free_pages+0xbe>
ffffffffc0202e0e:	87ba                	mv	a5,a4
ffffffffc0202e10:	fe878713          	addi	a4,a5,-24
ffffffffc0202e14:	fee57ae3          	bgeu	a0,a4,ffffffffc0202e08 <default_free_pages+0x68>
ffffffffc0202e18:	c199                	beqz	a1,ffffffffc0202e1e <default_free_pages+0x7e>
ffffffffc0202e1a:	0106b023          	sd	a6,0(a3)
ffffffffc0202e1e:	6398                	ld	a4,0(a5)
ffffffffc0202e20:	e390                	sd	a2,0(a5)
ffffffffc0202e22:	e710                	sd	a2,8(a4)
ffffffffc0202e24:	f11c                	sd	a5,32(a0)
ffffffffc0202e26:	ed18                	sd	a4,24(a0)
ffffffffc0202e28:	00d70c63          	beq	a4,a3,ffffffffc0202e40 <default_free_pages+0xa0>
ffffffffc0202e2c:	ff872583          	lw	a1,-8(a4)
ffffffffc0202e30:	fe870613          	addi	a2,a4,-24
ffffffffc0202e34:	02059793          	slli	a5,a1,0x20
ffffffffc0202e38:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e3a:	97b2                	add	a5,a5,a2
ffffffffc0202e3c:	02f50b63          	beq	a0,a5,ffffffffc0202e72 <default_free_pages+0xd2>
ffffffffc0202e40:	7118                	ld	a4,32(a0)
ffffffffc0202e42:	00d70b63          	beq	a4,a3,ffffffffc0202e58 <default_free_pages+0xb8>
ffffffffc0202e46:	4910                	lw	a2,16(a0)
ffffffffc0202e48:	fe870693          	addi	a3,a4,-24
ffffffffc0202e4c:	02061793          	slli	a5,a2,0x20
ffffffffc0202e50:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e52:	97aa                	add	a5,a5,a0
ffffffffc0202e54:	04f68763          	beq	a3,a5,ffffffffc0202ea2 <default_free_pages+0x102>
ffffffffc0202e58:	60a2                	ld	ra,8(sp)
ffffffffc0202e5a:	0141                	addi	sp,sp,16
ffffffffc0202e5c:	8082                	ret
ffffffffc0202e5e:	e790                	sd	a2,8(a5)
ffffffffc0202e60:	f114                	sd	a3,32(a0)
ffffffffc0202e62:	6798                	ld	a4,8(a5)
ffffffffc0202e64:	ed1c                	sd	a5,24(a0)
ffffffffc0202e66:	02d70463          	beq	a4,a3,ffffffffc0202e8e <default_free_pages+0xee>
ffffffffc0202e6a:	8832                	mv	a6,a2
ffffffffc0202e6c:	4585                	li	a1,1
ffffffffc0202e6e:	87ba                	mv	a5,a4
ffffffffc0202e70:	b745                	j	ffffffffc0202e10 <default_free_pages+0x70>
ffffffffc0202e72:	491c                	lw	a5,16(a0)
ffffffffc0202e74:	9dbd                	addw	a1,a1,a5
ffffffffc0202e76:	feb72c23          	sw	a1,-8(a4)
ffffffffc0202e7a:	57f5                	li	a5,-3
ffffffffc0202e7c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0202e80:	6d0c                	ld	a1,24(a0)
ffffffffc0202e82:	711c                	ld	a5,32(a0)
ffffffffc0202e84:	8532                	mv	a0,a2
ffffffffc0202e86:	e59c                	sd	a5,8(a1)
ffffffffc0202e88:	6718                	ld	a4,8(a4)
ffffffffc0202e8a:	e38c                	sd	a1,0(a5)
ffffffffc0202e8c:	bf5d                	j	ffffffffc0202e42 <default_free_pages+0xa2>
ffffffffc0202e8e:	e290                	sd	a2,0(a3)
ffffffffc0202e90:	873e                	mv	a4,a5
ffffffffc0202e92:	bf69                	j	ffffffffc0202e2c <default_free_pages+0x8c>
ffffffffc0202e94:	60a2                	ld	ra,8(sp)
ffffffffc0202e96:	e390                	sd	a2,0(a5)
ffffffffc0202e98:	e790                	sd	a2,8(a5)
ffffffffc0202e9a:	f11c                	sd	a5,32(a0)
ffffffffc0202e9c:	ed1c                	sd	a5,24(a0)
ffffffffc0202e9e:	0141                	addi	sp,sp,16
ffffffffc0202ea0:	8082                	ret
ffffffffc0202ea2:	ff872783          	lw	a5,-8(a4)
ffffffffc0202ea6:	ff070693          	addi	a3,a4,-16
ffffffffc0202eaa:	9e3d                	addw	a2,a2,a5
ffffffffc0202eac:	c910                	sw	a2,16(a0)
ffffffffc0202eae:	57f5                	li	a5,-3
ffffffffc0202eb0:	60f6b02f          	amoand.d	zero,a5,(a3)
ffffffffc0202eb4:	6314                	ld	a3,0(a4)
ffffffffc0202eb6:	671c                	ld	a5,8(a4)
ffffffffc0202eb8:	60a2                	ld	ra,8(sp)
ffffffffc0202eba:	e69c                	sd	a5,8(a3)
ffffffffc0202ebc:	e394                	sd	a3,0(a5)
ffffffffc0202ebe:	0141                	addi	sp,sp,16
ffffffffc0202ec0:	8082                	ret
ffffffffc0202ec2:	00006697          	auipc	a3,0x6
ffffffffc0202ec6:	56668693          	addi	a3,a3,1382 # ffffffffc0209428 <commands+0x1100>
ffffffffc0202eca:	00006617          	auipc	a2,0x6
ffffffffc0202ece:	86e60613          	addi	a2,a2,-1938 # ffffffffc0208738 <commands+0x410>
ffffffffc0202ed2:	08300593          	li	a1,131
ffffffffc0202ed6:	00006517          	auipc	a0,0x6
ffffffffc0202eda:	20a50513          	addi	a0,a0,522 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202ede:	b2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ee2:	00006697          	auipc	a3,0x6
ffffffffc0202ee6:	53e68693          	addi	a3,a3,1342 # ffffffffc0209420 <commands+0x10f8>
ffffffffc0202eea:	00006617          	auipc	a2,0x6
ffffffffc0202eee:	84e60613          	addi	a2,a2,-1970 # ffffffffc0208738 <commands+0x410>
ffffffffc0202ef2:	08000593          	li	a1,128
ffffffffc0202ef6:	00006517          	auipc	a0,0x6
ffffffffc0202efa:	1ea50513          	addi	a0,a0,490 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202efe:	b0afd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202f02 <default_alloc_pages>:
ffffffffc0202f02:	c941                	beqz	a0,ffffffffc0202f92 <default_alloc_pages+0x90>
ffffffffc0202f04:	00016597          	auipc	a1,0x16
ffffffffc0202f08:	73458593          	addi	a1,a1,1844 # ffffffffc0219638 <free_area>
ffffffffc0202f0c:	0105a803          	lw	a6,16(a1)
ffffffffc0202f10:	872a                	mv	a4,a0
ffffffffc0202f12:	02081793          	slli	a5,a6,0x20
ffffffffc0202f16:	9381                	srli	a5,a5,0x20
ffffffffc0202f18:	00a7ee63          	bltu	a5,a0,ffffffffc0202f34 <default_alloc_pages+0x32>
ffffffffc0202f1c:	87ae                	mv	a5,a1
ffffffffc0202f1e:	a801                	j	ffffffffc0202f2e <default_alloc_pages+0x2c>
ffffffffc0202f20:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202f24:	02069613          	slli	a2,a3,0x20
ffffffffc0202f28:	9201                	srli	a2,a2,0x20
ffffffffc0202f2a:	00e67763          	bgeu	a2,a4,ffffffffc0202f38 <default_alloc_pages+0x36>
ffffffffc0202f2e:	679c                	ld	a5,8(a5)
ffffffffc0202f30:	feb798e3          	bne	a5,a1,ffffffffc0202f20 <default_alloc_pages+0x1e>
ffffffffc0202f34:	4501                	li	a0,0
ffffffffc0202f36:	8082                	ret
ffffffffc0202f38:	0007b883          	ld	a7,0(a5)
ffffffffc0202f3c:	0087b303          	ld	t1,8(a5)
ffffffffc0202f40:	fe878513          	addi	a0,a5,-24
ffffffffc0202f44:	00070e1b          	sext.w	t3,a4
ffffffffc0202f48:	0068b423          	sd	t1,8(a7)
ffffffffc0202f4c:	01133023          	sd	a7,0(t1)
ffffffffc0202f50:	02c77863          	bgeu	a4,a2,ffffffffc0202f80 <default_alloc_pages+0x7e>
ffffffffc0202f54:	071a                	slli	a4,a4,0x6
ffffffffc0202f56:	972a                	add	a4,a4,a0
ffffffffc0202f58:	41c686bb          	subw	a3,a3,t3
ffffffffc0202f5c:	cb14                	sw	a3,16(a4)
ffffffffc0202f5e:	00870613          	addi	a2,a4,8
ffffffffc0202f62:	4689                	li	a3,2
ffffffffc0202f64:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0202f68:	0088b683          	ld	a3,8(a7)
ffffffffc0202f6c:	01870613          	addi	a2,a4,24
ffffffffc0202f70:	0105a803          	lw	a6,16(a1)
ffffffffc0202f74:	e290                	sd	a2,0(a3)
ffffffffc0202f76:	00c8b423          	sd	a2,8(a7)
ffffffffc0202f7a:	f314                	sd	a3,32(a4)
ffffffffc0202f7c:	01173c23          	sd	a7,24(a4)
ffffffffc0202f80:	41c8083b          	subw	a6,a6,t3
ffffffffc0202f84:	0105a823          	sw	a6,16(a1)
ffffffffc0202f88:	5775                	li	a4,-3
ffffffffc0202f8a:	17c1                	addi	a5,a5,-16
ffffffffc0202f8c:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0202f90:	8082                	ret
ffffffffc0202f92:	1141                	addi	sp,sp,-16
ffffffffc0202f94:	00006697          	auipc	a3,0x6
ffffffffc0202f98:	48c68693          	addi	a3,a3,1164 # ffffffffc0209420 <commands+0x10f8>
ffffffffc0202f9c:	00005617          	auipc	a2,0x5
ffffffffc0202fa0:	79c60613          	addi	a2,a2,1948 # ffffffffc0208738 <commands+0x410>
ffffffffc0202fa4:	06200593          	li	a1,98
ffffffffc0202fa8:	00006517          	auipc	a0,0x6
ffffffffc0202fac:	13850513          	addi	a0,a0,312 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0202fb0:	e406                	sd	ra,8(sp)
ffffffffc0202fb2:	a56fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202fb6 <default_init_memmap>:
ffffffffc0202fb6:	1141                	addi	sp,sp,-16
ffffffffc0202fb8:	e406                	sd	ra,8(sp)
ffffffffc0202fba:	c5f1                	beqz	a1,ffffffffc0203086 <default_init_memmap+0xd0>
ffffffffc0202fbc:	00659693          	slli	a3,a1,0x6
ffffffffc0202fc0:	96aa                	add	a3,a3,a0
ffffffffc0202fc2:	87aa                	mv	a5,a0
ffffffffc0202fc4:	00d50f63          	beq	a0,a3,ffffffffc0202fe2 <default_init_memmap+0x2c>
ffffffffc0202fc8:	6798                	ld	a4,8(a5)
ffffffffc0202fca:	8b05                	andi	a4,a4,1
ffffffffc0202fcc:	cf49                	beqz	a4,ffffffffc0203066 <default_init_memmap+0xb0>
ffffffffc0202fce:	0007a823          	sw	zero,16(a5)
ffffffffc0202fd2:	0007b423          	sd	zero,8(a5)
ffffffffc0202fd6:	0007a023          	sw	zero,0(a5)
ffffffffc0202fda:	04078793          	addi	a5,a5,64
ffffffffc0202fde:	fed795e3          	bne	a5,a3,ffffffffc0202fc8 <default_init_memmap+0x12>
ffffffffc0202fe2:	2581                	sext.w	a1,a1
ffffffffc0202fe4:	c90c                	sw	a1,16(a0)
ffffffffc0202fe6:	4789                	li	a5,2
ffffffffc0202fe8:	00850713          	addi	a4,a0,8
ffffffffc0202fec:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0202ff0:	00016697          	auipc	a3,0x16
ffffffffc0202ff4:	64868693          	addi	a3,a3,1608 # ffffffffc0219638 <free_area>
ffffffffc0202ff8:	4a98                	lw	a4,16(a3)
ffffffffc0202ffa:	669c                	ld	a5,8(a3)
ffffffffc0202ffc:	01850613          	addi	a2,a0,24
ffffffffc0203000:	9db9                	addw	a1,a1,a4
ffffffffc0203002:	ca8c                	sw	a1,16(a3)
ffffffffc0203004:	04d78a63          	beq	a5,a3,ffffffffc0203058 <default_init_memmap+0xa2>
ffffffffc0203008:	fe878713          	addi	a4,a5,-24
ffffffffc020300c:	0006b803          	ld	a6,0(a3)
ffffffffc0203010:	4581                	li	a1,0
ffffffffc0203012:	00e56a63          	bltu	a0,a4,ffffffffc0203026 <default_init_memmap+0x70>
ffffffffc0203016:	6798                	ld	a4,8(a5)
ffffffffc0203018:	02d70263          	beq	a4,a3,ffffffffc020303c <default_init_memmap+0x86>
ffffffffc020301c:	87ba                	mv	a5,a4
ffffffffc020301e:	fe878713          	addi	a4,a5,-24
ffffffffc0203022:	fee57ae3          	bgeu	a0,a4,ffffffffc0203016 <default_init_memmap+0x60>
ffffffffc0203026:	c199                	beqz	a1,ffffffffc020302c <default_init_memmap+0x76>
ffffffffc0203028:	0106b023          	sd	a6,0(a3)
ffffffffc020302c:	6398                	ld	a4,0(a5)
ffffffffc020302e:	60a2                	ld	ra,8(sp)
ffffffffc0203030:	e390                	sd	a2,0(a5)
ffffffffc0203032:	e710                	sd	a2,8(a4)
ffffffffc0203034:	f11c                	sd	a5,32(a0)
ffffffffc0203036:	ed18                	sd	a4,24(a0)
ffffffffc0203038:	0141                	addi	sp,sp,16
ffffffffc020303a:	8082                	ret
ffffffffc020303c:	e790                	sd	a2,8(a5)
ffffffffc020303e:	f114                	sd	a3,32(a0)
ffffffffc0203040:	6798                	ld	a4,8(a5)
ffffffffc0203042:	ed1c                	sd	a5,24(a0)
ffffffffc0203044:	00d70663          	beq	a4,a3,ffffffffc0203050 <default_init_memmap+0x9a>
ffffffffc0203048:	8832                	mv	a6,a2
ffffffffc020304a:	4585                	li	a1,1
ffffffffc020304c:	87ba                	mv	a5,a4
ffffffffc020304e:	bfc1                	j	ffffffffc020301e <default_init_memmap+0x68>
ffffffffc0203050:	60a2                	ld	ra,8(sp)
ffffffffc0203052:	e290                	sd	a2,0(a3)
ffffffffc0203054:	0141                	addi	sp,sp,16
ffffffffc0203056:	8082                	ret
ffffffffc0203058:	60a2                	ld	ra,8(sp)
ffffffffc020305a:	e390                	sd	a2,0(a5)
ffffffffc020305c:	e790                	sd	a2,8(a5)
ffffffffc020305e:	f11c                	sd	a5,32(a0)
ffffffffc0203060:	ed1c                	sd	a5,24(a0)
ffffffffc0203062:	0141                	addi	sp,sp,16
ffffffffc0203064:	8082                	ret
ffffffffc0203066:	00006697          	auipc	a3,0x6
ffffffffc020306a:	3ea68693          	addi	a3,a3,1002 # ffffffffc0209450 <commands+0x1128>
ffffffffc020306e:	00005617          	auipc	a2,0x5
ffffffffc0203072:	6ca60613          	addi	a2,a2,1738 # ffffffffc0208738 <commands+0x410>
ffffffffc0203076:	04900593          	li	a1,73
ffffffffc020307a:	00006517          	auipc	a0,0x6
ffffffffc020307e:	06650513          	addi	a0,a0,102 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc0203082:	986fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203086:	00006697          	auipc	a3,0x6
ffffffffc020308a:	39a68693          	addi	a3,a3,922 # ffffffffc0209420 <commands+0x10f8>
ffffffffc020308e:	00005617          	auipc	a2,0x5
ffffffffc0203092:	6aa60613          	addi	a2,a2,1706 # ffffffffc0208738 <commands+0x410>
ffffffffc0203096:	04600593          	li	a1,70
ffffffffc020309a:	00006517          	auipc	a0,0x6
ffffffffc020309e:	04650513          	addi	a0,a0,70 # ffffffffc02090e0 <commands+0xdb8>
ffffffffc02030a2:	966fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a6 <mom>:
ffffffffc02030a6:	715d                	addi	sp,sp,-80
ffffffffc02030a8:	e0a2                	sd	s0,64(sp)
ffffffffc02030aa:	fc26                	sd	s1,56(sp)
ffffffffc02030ac:	f84a                	sd	s2,48(sp)
ffffffffc02030ae:	f44e                	sd	s3,40(sp)
ffffffffc02030b0:	f052                	sd	s4,32(sp)
ffffffffc02030b2:	ec56                	sd	s5,24(sp)
ffffffffc02030b4:	e85a                	sd	s6,16(sp)
ffffffffc02030b6:	e45e                	sd	s7,8(sp)
ffffffffc02030b8:	e062                	sd	s8,0(sp)
ffffffffc02030ba:	e486                	sd	ra,72(sp)
ffffffffc02030bc:	0000b417          	auipc	s0,0xb
ffffffffc02030c0:	fcc40413          	addi	s0,s0,-52 # ffffffffc020e088 <milk>
ffffffffc02030c4:	00016497          	auipc	s1,0x16
ffffffffc02030c8:	5ac48493          	addi	s1,s1,1452 # ffffffffc0219670 <mutex>
ffffffffc02030cc:	00006b17          	auipc	s6,0x6
ffffffffc02030d0:	3e4b0b13          	addi	s6,s6,996 # ffffffffc02094b0 <default_pmm_manager+0x38>
ffffffffc02030d4:	00006997          	auipc	s3,0x6
ffffffffc02030d8:	3f498993          	addi	s3,s3,1012 # ffffffffc02094c8 <default_pmm_manager+0x50>
ffffffffc02030dc:	00016917          	auipc	s2,0x16
ffffffffc02030e0:	57c90913          	addi	s2,s2,1404 # ffffffffc0219658 <p1>
ffffffffc02030e4:	00006a97          	auipc	s5,0x6
ffffffffc02030e8:	3f4a8a93          	addi	s5,s5,1012 # ffffffffc02094d8 <default_pmm_manager+0x60>
ffffffffc02030ec:	00006a17          	auipc	s4,0x6
ffffffffc02030f0:	40ca0a13          	addi	s4,s4,1036 # ffffffffc02094f8 <default_pmm_manager+0x80>
ffffffffc02030f4:	00006c17          	auipc	s8,0x6
ffffffffc02030f8:	45cc0c13          	addi	s8,s8,1116 # ffffffffc0209550 <default_pmm_manager+0xd8>
ffffffffc02030fc:	00006b97          	auipc	s7,0x6
ffffffffc0203100:	414b8b93          	addi	s7,s7,1044 # ffffffffc0209510 <default_pmm_manager+0x98>
ffffffffc0203104:	8526                	mv	a0,s1
ffffffffc0203106:	51e000ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc020310a:	855a                	mv	a0,s6
ffffffffc020310c:	fc1fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203110:	401c                	lw	a5,0(s0)
ffffffffc0203112:	00f05c63          	blez	a5,ffffffffc020312a <mom+0x84>
ffffffffc0203116:	854e                	mv	a0,s3
ffffffffc0203118:	fb5fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020311c:	85a6                	mv	a1,s1
ffffffffc020311e:	854a                	mv	a0,s2
ffffffffc0203120:	53c000ef          	jal	ra,ffffffffc020365c <cond_wait>
ffffffffc0203124:	401c                	lw	a5,0(s0)
ffffffffc0203126:	fef048e3          	bgtz	a5,ffffffffc0203116 <mom+0x70>
ffffffffc020312a:	8556                	mv	a0,s5
ffffffffc020312c:	fa1fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203130:	8552                	mv	a0,s4
ffffffffc0203132:	f9bfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203136:	401c                	lw	a5,0(s0)
ffffffffc0203138:	00f05d63          	blez	a5,ffffffffc0203152 <mom+0xac>
ffffffffc020313c:	855e                	mv	a0,s7
ffffffffc020313e:	f8ffc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203142:	8526                	mv	a0,s1
ffffffffc0203144:	4de000ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc0203148:	06400513          	li	a0,100
ffffffffc020314c:	0ff010ef          	jal	ra,ffffffffc0204a4a <do_sleep>
ffffffffc0203150:	bf55                	j	ffffffffc0203104 <mom+0x5e>
ffffffffc0203152:	0647879b          	addiw	a5,a5,100
ffffffffc0203156:	8562                	mv	a0,s8
ffffffffc0203158:	c01c                	sw	a5,0(s0)
ffffffffc020315a:	f73fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020315e:	b7d5                	j	ffffffffc0203142 <mom+0x9c>

ffffffffc0203160 <sister>:
ffffffffc0203160:	715d                	addi	sp,sp,-80
ffffffffc0203162:	e0a2                	sd	s0,64(sp)
ffffffffc0203164:	fc26                	sd	s1,56(sp)
ffffffffc0203166:	f84a                	sd	s2,48(sp)
ffffffffc0203168:	f44e                	sd	s3,40(sp)
ffffffffc020316a:	f052                	sd	s4,32(sp)
ffffffffc020316c:	ec56                	sd	s5,24(sp)
ffffffffc020316e:	e85a                	sd	s6,16(sp)
ffffffffc0203170:	e45e                	sd	s7,8(sp)
ffffffffc0203172:	e062                	sd	s8,0(sp)
ffffffffc0203174:	e486                	sd	ra,72(sp)
ffffffffc0203176:	0000b417          	auipc	s0,0xb
ffffffffc020317a:	f1240413          	addi	s0,s0,-238 # ffffffffc020e088 <milk>
ffffffffc020317e:	00016497          	auipc	s1,0x16
ffffffffc0203182:	4f248493          	addi	s1,s1,1266 # ffffffffc0219670 <mutex>
ffffffffc0203186:	00006b17          	auipc	s6,0x6
ffffffffc020318a:	3f2b0b13          	addi	s6,s6,1010 # ffffffffc0209578 <default_pmm_manager+0x100>
ffffffffc020318e:	00006997          	auipc	s3,0x6
ffffffffc0203192:	40298993          	addi	s3,s3,1026 # ffffffffc0209590 <default_pmm_manager+0x118>
ffffffffc0203196:	00016917          	auipc	s2,0x16
ffffffffc020319a:	4c290913          	addi	s2,s2,1218 # ffffffffc0219658 <p1>
ffffffffc020319e:	00006a97          	auipc	s5,0x6
ffffffffc02031a2:	402a8a93          	addi	s5,s5,1026 # ffffffffc02095a0 <default_pmm_manager+0x128>
ffffffffc02031a6:	00006a17          	auipc	s4,0x6
ffffffffc02031aa:	41aa0a13          	addi	s4,s4,1050 # ffffffffc02095c0 <default_pmm_manager+0x148>
ffffffffc02031ae:	00006c17          	auipc	s8,0x6
ffffffffc02031b2:	42ac0c13          	addi	s8,s8,1066 # ffffffffc02095d8 <default_pmm_manager+0x160>
ffffffffc02031b6:	00006b97          	auipc	s7,0x6
ffffffffc02031ba:	35ab8b93          	addi	s7,s7,858 # ffffffffc0209510 <default_pmm_manager+0x98>
ffffffffc02031be:	8526                	mv	a0,s1
ffffffffc02031c0:	464000ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc02031c4:	855a                	mv	a0,s6
ffffffffc02031c6:	f07fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031ca:	401c                	lw	a5,0(s0)
ffffffffc02031cc:	00f05c63          	blez	a5,ffffffffc02031e4 <sister+0x84>
ffffffffc02031d0:	854e                	mv	a0,s3
ffffffffc02031d2:	efbfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031d6:	85a6                	mv	a1,s1
ffffffffc02031d8:	854a                	mv	a0,s2
ffffffffc02031da:	482000ef          	jal	ra,ffffffffc020365c <cond_wait>
ffffffffc02031de:	401c                	lw	a5,0(s0)
ffffffffc02031e0:	fef048e3          	bgtz	a5,ffffffffc02031d0 <sister+0x70>
ffffffffc02031e4:	8556                	mv	a0,s5
ffffffffc02031e6:	ee7fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031ea:	8552                	mv	a0,s4
ffffffffc02031ec:	ee1fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031f0:	401c                	lw	a5,0(s0)
ffffffffc02031f2:	00f05d63          	blez	a5,ffffffffc020320c <sister+0xac>
ffffffffc02031f6:	855e                	mv	a0,s7
ffffffffc02031f8:	ed5fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031fc:	8526                	mv	a0,s1
ffffffffc02031fe:	424000ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc0203202:	06400513          	li	a0,100
ffffffffc0203206:	045010ef          	jal	ra,ffffffffc0204a4a <do_sleep>
ffffffffc020320a:	bf55                	j	ffffffffc02031be <sister+0x5e>
ffffffffc020320c:	0647879b          	addiw	a5,a5,100
ffffffffc0203210:	8562                	mv	a0,s8
ffffffffc0203212:	c01c                	sw	a5,0(s0)
ffffffffc0203214:	eb9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203218:	b7d5                	j	ffffffffc02031fc <sister+0x9c>

ffffffffc020321a <dad>:
ffffffffc020321a:	7139                	addi	sp,sp,-64
ffffffffc020321c:	f822                	sd	s0,48(sp)
ffffffffc020321e:	f426                	sd	s1,40(sp)
ffffffffc0203220:	f04a                	sd	s2,32(sp)
ffffffffc0203222:	ec4e                	sd	s3,24(sp)
ffffffffc0203224:	e852                	sd	s4,16(sp)
ffffffffc0203226:	e456                	sd	s5,8(sp)
ffffffffc0203228:	fc06                	sd	ra,56(sp)
ffffffffc020322a:	0000b497          	auipc	s1,0xb
ffffffffc020322e:	e5e48493          	addi	s1,s1,-418 # ffffffffc020e088 <milk>
ffffffffc0203232:	00016417          	auipc	s0,0x16
ffffffffc0203236:	43e40413          	addi	s0,s0,1086 # ffffffffc0219670 <mutex>
ffffffffc020323a:	00006997          	auipc	s3,0x6
ffffffffc020323e:	3c698993          	addi	s3,s3,966 # ffffffffc0209600 <default_pmm_manager+0x188>
ffffffffc0203242:	00006a97          	auipc	s5,0x6
ffffffffc0203246:	3fea8a93          	addi	s5,s5,1022 # ffffffffc0209640 <default_pmm_manager+0x1c8>
ffffffffc020324a:	00016917          	auipc	s2,0x16
ffffffffc020324e:	40e90913          	addi	s2,s2,1038 # ffffffffc0219658 <p1>
ffffffffc0203252:	00006a17          	auipc	s4,0x6
ffffffffc0203256:	3c6a0a13          	addi	s4,s4,966 # ffffffffc0209618 <default_pmm_manager+0x1a0>
ffffffffc020325a:	a829                	j	ffffffffc0203274 <dad+0x5a>
ffffffffc020325c:	3fe000ef          	jal	ra,ffffffffc020365a <cond_signal>
ffffffffc0203260:	8552                	mv	a0,s4
ffffffffc0203262:	e6bfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203266:	8522                	mv	a0,s0
ffffffffc0203268:	3ba000ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc020326c:	06400513          	li	a0,100
ffffffffc0203270:	7da010ef          	jal	ra,ffffffffc0204a4a <do_sleep>
ffffffffc0203274:	8522                	mv	a0,s0
ffffffffc0203276:	3ae000ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc020327a:	854e                	mv	a0,s3
ffffffffc020327c:	e51fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203280:	409c                	lw	a5,0(s1)
ffffffffc0203282:	854a                	mv	a0,s2
ffffffffc0203284:	dfe1                	beqz	a5,ffffffffc020325c <dad+0x42>
ffffffffc0203286:	37b1                	addiw	a5,a5,-20
ffffffffc0203288:	8556                	mv	a0,s5
ffffffffc020328a:	c09c                	sw	a5,0(s1)
ffffffffc020328c:	e41fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203290:	bfd9                	j	ffffffffc0203266 <dad+0x4c>

ffffffffc0203292 <you>:
ffffffffc0203292:	7139                	addi	sp,sp,-64
ffffffffc0203294:	f822                	sd	s0,48(sp)
ffffffffc0203296:	f426                	sd	s1,40(sp)
ffffffffc0203298:	f04a                	sd	s2,32(sp)
ffffffffc020329a:	ec4e                	sd	s3,24(sp)
ffffffffc020329c:	e852                	sd	s4,16(sp)
ffffffffc020329e:	e456                	sd	s5,8(sp)
ffffffffc02032a0:	fc06                	sd	ra,56(sp)
ffffffffc02032a2:	0000b497          	auipc	s1,0xb
ffffffffc02032a6:	de648493          	addi	s1,s1,-538 # ffffffffc020e088 <milk>
ffffffffc02032aa:	00016417          	auipc	s0,0x16
ffffffffc02032ae:	3c640413          	addi	s0,s0,966 # ffffffffc0219670 <mutex>
ffffffffc02032b2:	00006997          	auipc	s3,0x6
ffffffffc02032b6:	3a698993          	addi	s3,s3,934 # ffffffffc0209658 <default_pmm_manager+0x1e0>
ffffffffc02032ba:	00006a97          	auipc	s5,0x6
ffffffffc02032be:	3dea8a93          	addi	s5,s5,990 # ffffffffc0209698 <default_pmm_manager+0x220>
ffffffffc02032c2:	00016917          	auipc	s2,0x16
ffffffffc02032c6:	39690913          	addi	s2,s2,918 # ffffffffc0219658 <p1>
ffffffffc02032ca:	00006a17          	auipc	s4,0x6
ffffffffc02032ce:	3a6a0a13          	addi	s4,s4,934 # ffffffffc0209670 <default_pmm_manager+0x1f8>
ffffffffc02032d2:	a829                	j	ffffffffc02032ec <you+0x5a>
ffffffffc02032d4:	386000ef          	jal	ra,ffffffffc020365a <cond_signal>
ffffffffc02032d8:	8552                	mv	a0,s4
ffffffffc02032da:	df3fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02032de:	8522                	mv	a0,s0
ffffffffc02032e0:	342000ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc02032e4:	06400513          	li	a0,100
ffffffffc02032e8:	762010ef          	jal	ra,ffffffffc0204a4a <do_sleep>
ffffffffc02032ec:	8522                	mv	a0,s0
ffffffffc02032ee:	336000ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc02032f2:	854e                	mv	a0,s3
ffffffffc02032f4:	dd9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02032f8:	409c                	lw	a5,0(s1)
ffffffffc02032fa:	854a                	mv	a0,s2
ffffffffc02032fc:	dfe1                	beqz	a5,ffffffffc02032d4 <you+0x42>
ffffffffc02032fe:	37b1                	addiw	a5,a5,-20
ffffffffc0203300:	8556                	mv	a0,s5
ffffffffc0203302:	c09c                	sw	a5,0(s1)
ffffffffc0203304:	dc9fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203308:	bfd9                	j	ffffffffc02032de <you+0x4c>

ffffffffc020330a <check_milk>:
ffffffffc020330a:	7179                	addi	sp,sp,-48
ffffffffc020330c:	4585                	li	a1,1
ffffffffc020330e:	00016517          	auipc	a0,0x16
ffffffffc0203312:	36250513          	addi	a0,a0,866 # ffffffffc0219670 <mutex>
ffffffffc0203316:	f406                	sd	ra,40(sp)
ffffffffc0203318:	f022                	sd	s0,32(sp)
ffffffffc020331a:	ec26                	sd	s1,24(sp)
ffffffffc020331c:	e84a                	sd	s2,16(sp)
ffffffffc020331e:	e44e                	sd	s3,8(sp)
ffffffffc0203320:	2fa000ef          	jal	ra,ffffffffc020361a <sem_init>
ffffffffc0203324:	00016517          	auipc	a0,0x16
ffffffffc0203328:	33450513          	addi	a0,a0,820 # ffffffffc0219658 <p1>
ffffffffc020332c:	32a000ef          	jal	ra,ffffffffc0203656 <cond_init>
ffffffffc0203330:	4601                	li	a2,0
ffffffffc0203332:	4581                	li	a1,0
ffffffffc0203334:	00000517          	auipc	a0,0x0
ffffffffc0203338:	ee650513          	addi	a0,a0,-282 # ffffffffc020321a <dad>
ffffffffc020333c:	2cd000ef          	jal	ra,ffffffffc0203e08 <kernel_thread>
ffffffffc0203340:	89aa                	mv	s3,a0
ffffffffc0203342:	4601                	li	a2,0
ffffffffc0203344:	4581                	li	a1,0
ffffffffc0203346:	00000517          	auipc	a0,0x0
ffffffffc020334a:	d6050513          	addi	a0,a0,-672 # ffffffffc02030a6 <mom>
ffffffffc020334e:	2bb000ef          	jal	ra,ffffffffc0203e08 <kernel_thread>
ffffffffc0203352:	892a                	mv	s2,a0
ffffffffc0203354:	4601                	li	a2,0
ffffffffc0203356:	4581                	li	a1,0
ffffffffc0203358:	00000517          	auipc	a0,0x0
ffffffffc020335c:	e0850513          	addi	a0,a0,-504 # ffffffffc0203160 <sister>
ffffffffc0203360:	2a9000ef          	jal	ra,ffffffffc0203e08 <kernel_thread>
ffffffffc0203364:	4601                	li	a2,0
ffffffffc0203366:	84aa                	mv	s1,a0
ffffffffc0203368:	4581                	li	a1,0
ffffffffc020336a:	00000517          	auipc	a0,0x0
ffffffffc020336e:	f2850513          	addi	a0,a0,-216 # ffffffffc0203292 <you>
ffffffffc0203372:	297000ef          	jal	ra,ffffffffc0203e08 <kernel_thread>
ffffffffc0203376:	842a                	mv	s0,a0
ffffffffc0203378:	854e                	mv	a0,s3
ffffffffc020337a:	664000ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc020337e:	00006597          	auipc	a1,0x6
ffffffffc0203382:	33258593          	addi	a1,a1,818 # ffffffffc02096b0 <default_pmm_manager+0x238>
ffffffffc0203386:	00016797          	auipc	a5,0x16
ffffffffc020338a:	30a7b923          	sd	a0,786(a5) # ffffffffc0219698 <pdad>
ffffffffc020338e:	5ba000ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc0203392:	854a                	mv	a0,s2
ffffffffc0203394:	64a000ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc0203398:	00006597          	auipc	a1,0x6
ffffffffc020339c:	32058593          	addi	a1,a1,800 # ffffffffc02096b8 <default_pmm_manager+0x240>
ffffffffc02033a0:	00016797          	auipc	a5,0x16
ffffffffc02033a4:	2ea7b823          	sd	a0,752(a5) # ffffffffc0219690 <pmom>
ffffffffc02033a8:	5a0000ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc02033ac:	8526                	mv	a0,s1
ffffffffc02033ae:	630000ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc02033b2:	00006597          	auipc	a1,0x6
ffffffffc02033b6:	30e58593          	addi	a1,a1,782 # ffffffffc02096c0 <default_pmm_manager+0x248>
ffffffffc02033ba:	00016797          	auipc	a5,0x16
ffffffffc02033be:	28a7bb23          	sd	a0,662(a5) # ffffffffc0219650 <psister>
ffffffffc02033c2:	586000ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc02033c6:	8522                	mv	a0,s0
ffffffffc02033c8:	616000ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc02033cc:	7402                	ld	s0,32(sp)
ffffffffc02033ce:	70a2                	ld	ra,40(sp)
ffffffffc02033d0:	64e2                	ld	s1,24(sp)
ffffffffc02033d2:	6942                	ld	s2,16(sp)
ffffffffc02033d4:	69a2                	ld	s3,8(sp)
ffffffffc02033d6:	00016797          	auipc	a5,0x16
ffffffffc02033da:	2aa7b923          	sd	a0,690(a5) # ffffffffc0219688 <pyou>
ffffffffc02033de:	00006597          	auipc	a1,0x6
ffffffffc02033e2:	2ea58593          	addi	a1,a1,746 # ffffffffc02096c8 <default_pmm_manager+0x250>
ffffffffc02033e6:	6145                	addi	sp,sp,48
ffffffffc02033e8:	a385                	j	ffffffffc0203948 <set_proc_name>

ffffffffc02033ea <wait_queue_del.part.0>:
ffffffffc02033ea:	1141                	addi	sp,sp,-16
ffffffffc02033ec:	00006697          	auipc	a3,0x6
ffffffffc02033f0:	2e468693          	addi	a3,a3,740 # ffffffffc02096d0 <default_pmm_manager+0x258>
ffffffffc02033f4:	00005617          	auipc	a2,0x5
ffffffffc02033f8:	34460613          	addi	a2,a2,836 # ffffffffc0208738 <commands+0x410>
ffffffffc02033fc:	45f1                	li	a1,28
ffffffffc02033fe:	00006517          	auipc	a0,0x6
ffffffffc0203402:	31250513          	addi	a0,a0,786 # ffffffffc0209710 <default_pmm_manager+0x298>
ffffffffc0203406:	e406                	sd	ra,8(sp)
ffffffffc0203408:	e01fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020340c <wait_queue_init>:
ffffffffc020340c:	e508                	sd	a0,8(a0)
ffffffffc020340e:	e108                	sd	a0,0(a0)
ffffffffc0203410:	8082                	ret

ffffffffc0203412 <wait_queue_del>:
ffffffffc0203412:	7198                	ld	a4,32(a1)
ffffffffc0203414:	01858793          	addi	a5,a1,24
ffffffffc0203418:	00e78b63          	beq	a5,a4,ffffffffc020342e <wait_queue_del+0x1c>
ffffffffc020341c:	6994                	ld	a3,16(a1)
ffffffffc020341e:	00a69863          	bne	a3,a0,ffffffffc020342e <wait_queue_del+0x1c>
ffffffffc0203422:	6d94                	ld	a3,24(a1)
ffffffffc0203424:	e698                	sd	a4,8(a3)
ffffffffc0203426:	e314                	sd	a3,0(a4)
ffffffffc0203428:	f19c                	sd	a5,32(a1)
ffffffffc020342a:	ed9c                	sd	a5,24(a1)
ffffffffc020342c:	8082                	ret
ffffffffc020342e:	1141                	addi	sp,sp,-16
ffffffffc0203430:	e406                	sd	ra,8(sp)
ffffffffc0203432:	fb9ff0ef          	jal	ra,ffffffffc02033ea <wait_queue_del.part.0>

ffffffffc0203436 <wait_queue_first>:
ffffffffc0203436:	651c                	ld	a5,8(a0)
ffffffffc0203438:	00f50563          	beq	a0,a5,ffffffffc0203442 <wait_queue_first+0xc>
ffffffffc020343c:	fe878513          	addi	a0,a5,-24
ffffffffc0203440:	8082                	ret
ffffffffc0203442:	4501                	li	a0,0
ffffffffc0203444:	8082                	ret

ffffffffc0203446 <wait_in_queue>:
ffffffffc0203446:	711c                	ld	a5,32(a0)
ffffffffc0203448:	0561                	addi	a0,a0,24
ffffffffc020344a:	40a78533          	sub	a0,a5,a0
ffffffffc020344e:	00a03533          	snez	a0,a0
ffffffffc0203452:	8082                	ret

ffffffffc0203454 <wakeup_wait>:
ffffffffc0203454:	ce91                	beqz	a3,ffffffffc0203470 <wakeup_wait+0x1c>
ffffffffc0203456:	7198                	ld	a4,32(a1)
ffffffffc0203458:	01858793          	addi	a5,a1,24
ffffffffc020345c:	00e78e63          	beq	a5,a4,ffffffffc0203478 <wakeup_wait+0x24>
ffffffffc0203460:	6994                	ld	a3,16(a1)
ffffffffc0203462:	00d51b63          	bne	a0,a3,ffffffffc0203478 <wakeup_wait+0x24>
ffffffffc0203466:	6d94                	ld	a3,24(a1)
ffffffffc0203468:	e698                	sd	a4,8(a3)
ffffffffc020346a:	e314                	sd	a3,0(a4)
ffffffffc020346c:	f19c                	sd	a5,32(a1)
ffffffffc020346e:	ed9c                	sd	a5,24(a1)
ffffffffc0203470:	6188                	ld	a0,0(a1)
ffffffffc0203472:	c590                	sw	a2,8(a1)
ffffffffc0203474:	6ac0106f          	j	ffffffffc0204b20 <wakeup_proc>
ffffffffc0203478:	1141                	addi	sp,sp,-16
ffffffffc020347a:	e406                	sd	ra,8(sp)
ffffffffc020347c:	f6fff0ef          	jal	ra,ffffffffc02033ea <wait_queue_del.part.0>

ffffffffc0203480 <wait_current_set>:
ffffffffc0203480:	00016797          	auipc	a5,0x16
ffffffffc0203484:	0807b783          	ld	a5,128(a5) # ffffffffc0219500 <current>
ffffffffc0203488:	c39d                	beqz	a5,ffffffffc02034ae <wait_current_set+0x2e>
ffffffffc020348a:	01858713          	addi	a4,a1,24
ffffffffc020348e:	800006b7          	lui	a3,0x80000
ffffffffc0203492:	ed98                	sd	a4,24(a1)
ffffffffc0203494:	e19c                	sd	a5,0(a1)
ffffffffc0203496:	c594                	sw	a3,8(a1)
ffffffffc0203498:	4685                	li	a3,1
ffffffffc020349a:	c394                	sw	a3,0(a5)
ffffffffc020349c:	0ec7a623          	sw	a2,236(a5)
ffffffffc02034a0:	611c                	ld	a5,0(a0)
ffffffffc02034a2:	e988                	sd	a0,16(a1)
ffffffffc02034a4:	e118                	sd	a4,0(a0)
ffffffffc02034a6:	e798                	sd	a4,8(a5)
ffffffffc02034a8:	f188                	sd	a0,32(a1)
ffffffffc02034aa:	ed9c                	sd	a5,24(a1)
ffffffffc02034ac:	8082                	ret
ffffffffc02034ae:	1141                	addi	sp,sp,-16
ffffffffc02034b0:	00006697          	auipc	a3,0x6
ffffffffc02034b4:	27868693          	addi	a3,a3,632 # ffffffffc0209728 <default_pmm_manager+0x2b0>
ffffffffc02034b8:	00005617          	auipc	a2,0x5
ffffffffc02034bc:	28060613          	addi	a2,a2,640 # ffffffffc0208738 <commands+0x410>
ffffffffc02034c0:	07400593          	li	a1,116
ffffffffc02034c4:	00006517          	auipc	a0,0x6
ffffffffc02034c8:	24c50513          	addi	a0,a0,588 # ffffffffc0209710 <default_pmm_manager+0x298>
ffffffffc02034cc:	e406                	sd	ra,8(sp)
ffffffffc02034ce:	d3bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02034d2 <__down.constprop.0>:
ffffffffc02034d2:	715d                	addi	sp,sp,-80
ffffffffc02034d4:	e0a2                	sd	s0,64(sp)
ffffffffc02034d6:	e486                	sd	ra,72(sp)
ffffffffc02034d8:	fc26                	sd	s1,56(sp)
ffffffffc02034da:	842a                	mv	s0,a0
ffffffffc02034dc:	100027f3          	csrr	a5,sstatus
ffffffffc02034e0:	8b89                	andi	a5,a5,2
ffffffffc02034e2:	ebb1                	bnez	a5,ffffffffc0203536 <__down.constprop.0+0x64>
ffffffffc02034e4:	411c                	lw	a5,0(a0)
ffffffffc02034e6:	00f05a63          	blez	a5,ffffffffc02034fa <__down.constprop.0+0x28>
ffffffffc02034ea:	37fd                	addiw	a5,a5,-1
ffffffffc02034ec:	c11c                	sw	a5,0(a0)
ffffffffc02034ee:	4501                	li	a0,0
ffffffffc02034f0:	60a6                	ld	ra,72(sp)
ffffffffc02034f2:	6406                	ld	s0,64(sp)
ffffffffc02034f4:	74e2                	ld	s1,56(sp)
ffffffffc02034f6:	6161                	addi	sp,sp,80
ffffffffc02034f8:	8082                	ret
ffffffffc02034fa:	00850413          	addi	s0,a0,8
ffffffffc02034fe:	0024                	addi	s1,sp,8
ffffffffc0203500:	10000613          	li	a2,256
ffffffffc0203504:	85a6                	mv	a1,s1
ffffffffc0203506:	8522                	mv	a0,s0
ffffffffc0203508:	f79ff0ef          	jal	ra,ffffffffc0203480 <wait_current_set>
ffffffffc020350c:	6c6010ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc0203510:	100027f3          	csrr	a5,sstatus
ffffffffc0203514:	8b89                	andi	a5,a5,2
ffffffffc0203516:	efb9                	bnez	a5,ffffffffc0203574 <__down.constprop.0+0xa2>
ffffffffc0203518:	8526                	mv	a0,s1
ffffffffc020351a:	f2dff0ef          	jal	ra,ffffffffc0203446 <wait_in_queue>
ffffffffc020351e:	e531                	bnez	a0,ffffffffc020356a <__down.constprop.0+0x98>
ffffffffc0203520:	4542                	lw	a0,16(sp)
ffffffffc0203522:	10000793          	li	a5,256
ffffffffc0203526:	fcf515e3          	bne	a0,a5,ffffffffc02034f0 <__down.constprop.0+0x1e>
ffffffffc020352a:	60a6                	ld	ra,72(sp)
ffffffffc020352c:	6406                	ld	s0,64(sp)
ffffffffc020352e:	74e2                	ld	s1,56(sp)
ffffffffc0203530:	4501                	li	a0,0
ffffffffc0203532:	6161                	addi	sp,sp,80
ffffffffc0203534:	8082                	ret
ffffffffc0203536:	902fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020353a:	401c                	lw	a5,0(s0)
ffffffffc020353c:	00f05c63          	blez	a5,ffffffffc0203554 <__down.constprop.0+0x82>
ffffffffc0203540:	37fd                	addiw	a5,a5,-1
ffffffffc0203542:	c01c                	sw	a5,0(s0)
ffffffffc0203544:	8eefd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203548:	60a6                	ld	ra,72(sp)
ffffffffc020354a:	6406                	ld	s0,64(sp)
ffffffffc020354c:	74e2                	ld	s1,56(sp)
ffffffffc020354e:	4501                	li	a0,0
ffffffffc0203550:	6161                	addi	sp,sp,80
ffffffffc0203552:	8082                	ret
ffffffffc0203554:	0421                	addi	s0,s0,8
ffffffffc0203556:	0024                	addi	s1,sp,8
ffffffffc0203558:	10000613          	li	a2,256
ffffffffc020355c:	85a6                	mv	a1,s1
ffffffffc020355e:	8522                	mv	a0,s0
ffffffffc0203560:	f21ff0ef          	jal	ra,ffffffffc0203480 <wait_current_set>
ffffffffc0203564:	8cefd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203568:	b755                	j	ffffffffc020350c <__down.constprop.0+0x3a>
ffffffffc020356a:	85a6                	mv	a1,s1
ffffffffc020356c:	8522                	mv	a0,s0
ffffffffc020356e:	ea5ff0ef          	jal	ra,ffffffffc0203412 <wait_queue_del>
ffffffffc0203572:	b77d                	j	ffffffffc0203520 <__down.constprop.0+0x4e>
ffffffffc0203574:	8c4fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203578:	8526                	mv	a0,s1
ffffffffc020357a:	ecdff0ef          	jal	ra,ffffffffc0203446 <wait_in_queue>
ffffffffc020357e:	e501                	bnez	a0,ffffffffc0203586 <__down.constprop.0+0xb4>
ffffffffc0203580:	8b2fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203584:	bf71                	j	ffffffffc0203520 <__down.constprop.0+0x4e>
ffffffffc0203586:	85a6                	mv	a1,s1
ffffffffc0203588:	8522                	mv	a0,s0
ffffffffc020358a:	e89ff0ef          	jal	ra,ffffffffc0203412 <wait_queue_del>
ffffffffc020358e:	bfcd                	j	ffffffffc0203580 <__down.constprop.0+0xae>

ffffffffc0203590 <__up.constprop.0>:
ffffffffc0203590:	1101                	addi	sp,sp,-32
ffffffffc0203592:	e822                	sd	s0,16(sp)
ffffffffc0203594:	ec06                	sd	ra,24(sp)
ffffffffc0203596:	e426                	sd	s1,8(sp)
ffffffffc0203598:	e04a                	sd	s2,0(sp)
ffffffffc020359a:	842a                	mv	s0,a0
ffffffffc020359c:	100027f3          	csrr	a5,sstatus
ffffffffc02035a0:	8b89                	andi	a5,a5,2
ffffffffc02035a2:	4901                	li	s2,0
ffffffffc02035a4:	eba1                	bnez	a5,ffffffffc02035f4 <__up.constprop.0+0x64>
ffffffffc02035a6:	00840493          	addi	s1,s0,8
ffffffffc02035aa:	8526                	mv	a0,s1
ffffffffc02035ac:	e8bff0ef          	jal	ra,ffffffffc0203436 <wait_queue_first>
ffffffffc02035b0:	85aa                	mv	a1,a0
ffffffffc02035b2:	cd0d                	beqz	a0,ffffffffc02035ec <__up.constprop.0+0x5c>
ffffffffc02035b4:	6118                	ld	a4,0(a0)
ffffffffc02035b6:	10000793          	li	a5,256
ffffffffc02035ba:	0ec72703          	lw	a4,236(a4)
ffffffffc02035be:	02f71f63          	bne	a4,a5,ffffffffc02035fc <__up.constprop.0+0x6c>
ffffffffc02035c2:	4685                	li	a3,1
ffffffffc02035c4:	10000613          	li	a2,256
ffffffffc02035c8:	8526                	mv	a0,s1
ffffffffc02035ca:	e8bff0ef          	jal	ra,ffffffffc0203454 <wakeup_wait>
ffffffffc02035ce:	00091863          	bnez	s2,ffffffffc02035de <__up.constprop.0+0x4e>
ffffffffc02035d2:	60e2                	ld	ra,24(sp)
ffffffffc02035d4:	6442                	ld	s0,16(sp)
ffffffffc02035d6:	64a2                	ld	s1,8(sp)
ffffffffc02035d8:	6902                	ld	s2,0(sp)
ffffffffc02035da:	6105                	addi	sp,sp,32
ffffffffc02035dc:	8082                	ret
ffffffffc02035de:	6442                	ld	s0,16(sp)
ffffffffc02035e0:	60e2                	ld	ra,24(sp)
ffffffffc02035e2:	64a2                	ld	s1,8(sp)
ffffffffc02035e4:	6902                	ld	s2,0(sp)
ffffffffc02035e6:	6105                	addi	sp,sp,32
ffffffffc02035e8:	84afd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02035ec:	401c                	lw	a5,0(s0)
ffffffffc02035ee:	2785                	addiw	a5,a5,1
ffffffffc02035f0:	c01c                	sw	a5,0(s0)
ffffffffc02035f2:	bff1                	j	ffffffffc02035ce <__up.constprop.0+0x3e>
ffffffffc02035f4:	844fd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02035f8:	4905                	li	s2,1
ffffffffc02035fa:	b775                	j	ffffffffc02035a6 <__up.constprop.0+0x16>
ffffffffc02035fc:	00006697          	auipc	a3,0x6
ffffffffc0203600:	13c68693          	addi	a3,a3,316 # ffffffffc0209738 <default_pmm_manager+0x2c0>
ffffffffc0203604:	00005617          	auipc	a2,0x5
ffffffffc0203608:	13460613          	addi	a2,a2,308 # ffffffffc0208738 <commands+0x410>
ffffffffc020360c:	45e5                	li	a1,25
ffffffffc020360e:	00006517          	auipc	a0,0x6
ffffffffc0203612:	15250513          	addi	a0,a0,338 # ffffffffc0209760 <default_pmm_manager+0x2e8>
ffffffffc0203616:	bf3fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020361a <sem_init>:
ffffffffc020361a:	c10c                	sw	a1,0(a0)
ffffffffc020361c:	0521                	addi	a0,a0,8
ffffffffc020361e:	defff06f          	j	ffffffffc020340c <wait_queue_init>

ffffffffc0203622 <up>:
ffffffffc0203622:	b7bd                	j	ffffffffc0203590 <__up.constprop.0>

ffffffffc0203624 <down>:
ffffffffc0203624:	1141                	addi	sp,sp,-16
ffffffffc0203626:	e406                	sd	ra,8(sp)
ffffffffc0203628:	eabff0ef          	jal	ra,ffffffffc02034d2 <__down.constprop.0>
ffffffffc020362c:	2501                	sext.w	a0,a0
ffffffffc020362e:	e501                	bnez	a0,ffffffffc0203636 <down+0x12>
ffffffffc0203630:	60a2                	ld	ra,8(sp)
ffffffffc0203632:	0141                	addi	sp,sp,16
ffffffffc0203634:	8082                	ret
ffffffffc0203636:	00006697          	auipc	a3,0x6
ffffffffc020363a:	13a68693          	addi	a3,a3,314 # ffffffffc0209770 <default_pmm_manager+0x2f8>
ffffffffc020363e:	00005617          	auipc	a2,0x5
ffffffffc0203642:	0fa60613          	addi	a2,a2,250 # ffffffffc0208738 <commands+0x410>
ffffffffc0203646:	04000593          	li	a1,64
ffffffffc020364a:	00006517          	auipc	a0,0x6
ffffffffc020364e:	11650513          	addi	a0,a0,278 # ffffffffc0209760 <default_pmm_manager+0x2e8>
ffffffffc0203652:	bb7fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203656 <cond_init>:
ffffffffc0203656:	4581                	li	a1,0
ffffffffc0203658:	b7c9                	j	ffffffffc020361a <sem_init>

ffffffffc020365a <cond_signal>:
ffffffffc020365a:	b7e1                	j	ffffffffc0203622 <up>

ffffffffc020365c <cond_wait>:
ffffffffc020365c:	1101                	addi	sp,sp,-32
ffffffffc020365e:	e426                	sd	s1,8(sp)
ffffffffc0203660:	84aa                	mv	s1,a0
ffffffffc0203662:	852e                	mv	a0,a1
ffffffffc0203664:	ec06                	sd	ra,24(sp)
ffffffffc0203666:	e822                	sd	s0,16(sp)
ffffffffc0203668:	842e                	mv	s0,a1
ffffffffc020366a:	fb9ff0ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc020366e:	8526                	mv	a0,s1
ffffffffc0203670:	fb5ff0ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc0203674:	8522                	mv	a0,s0
ffffffffc0203676:	6442                	ld	s0,16(sp)
ffffffffc0203678:	60e2                	ld	ra,24(sp)
ffffffffc020367a:	64a2                	ld	s1,8(sp)
ffffffffc020367c:	6105                	addi	sp,sp,32
ffffffffc020367e:	b75d                	j	ffffffffc0203624 <down>

ffffffffc0203680 <swapfs_init>:
ffffffffc0203680:	1141                	addi	sp,sp,-16
ffffffffc0203682:	4505                	li	a0,1
ffffffffc0203684:	e406                	sd	ra,8(sp)
ffffffffc0203686:	e9dfc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc020368a:	cd01                	beqz	a0,ffffffffc02036a2 <swapfs_init+0x22>
ffffffffc020368c:	4505                	li	a0,1
ffffffffc020368e:	e9bfc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc0203692:	60a2                	ld	ra,8(sp)
ffffffffc0203694:	810d                	srli	a0,a0,0x3
ffffffffc0203696:	00016797          	auipc	a5,0x16
ffffffffc020369a:	f6a7b123          	sd	a0,-158(a5) # ffffffffc02195f8 <max_swap_offset>
ffffffffc020369e:	0141                	addi	sp,sp,16
ffffffffc02036a0:	8082                	ret
ffffffffc02036a2:	00006617          	auipc	a2,0x6
ffffffffc02036a6:	0de60613          	addi	a2,a2,222 # ffffffffc0209780 <default_pmm_manager+0x308>
ffffffffc02036aa:	45b5                	li	a1,13
ffffffffc02036ac:	00006517          	auipc	a0,0x6
ffffffffc02036b0:	0f450513          	addi	a0,a0,244 # ffffffffc02097a0 <default_pmm_manager+0x328>
ffffffffc02036b4:	b55fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02036b8 <swapfs_read>:
ffffffffc02036b8:	1141                	addi	sp,sp,-16
ffffffffc02036ba:	e406                	sd	ra,8(sp)
ffffffffc02036bc:	00855793          	srli	a5,a0,0x8
ffffffffc02036c0:	cbb1                	beqz	a5,ffffffffc0203714 <swapfs_read+0x5c>
ffffffffc02036c2:	00016717          	auipc	a4,0x16
ffffffffc02036c6:	f3673703          	ld	a4,-202(a4) # ffffffffc02195f8 <max_swap_offset>
ffffffffc02036ca:	04e7f563          	bgeu	a5,a4,ffffffffc0203714 <swapfs_read+0x5c>
ffffffffc02036ce:	00016617          	auipc	a2,0x16
ffffffffc02036d2:	e8263603          	ld	a2,-382(a2) # ffffffffc0219550 <pages>
ffffffffc02036d6:	8d91                	sub	a1,a1,a2
ffffffffc02036d8:	4065d613          	srai	a2,a1,0x6
ffffffffc02036dc:	00007717          	auipc	a4,0x7
ffffffffc02036e0:	1bc73703          	ld	a4,444(a4) # ffffffffc020a898 <nbase>
ffffffffc02036e4:	963a                	add	a2,a2,a4
ffffffffc02036e6:	00c61713          	slli	a4,a2,0xc
ffffffffc02036ea:	8331                	srli	a4,a4,0xc
ffffffffc02036ec:	00016697          	auipc	a3,0x16
ffffffffc02036f0:	dec6b683          	ld	a3,-532(a3) # ffffffffc02194d8 <npage>
ffffffffc02036f4:	0037959b          	slliw	a1,a5,0x3
ffffffffc02036f8:	0632                	slli	a2,a2,0xc
ffffffffc02036fa:	02d77963          	bgeu	a4,a3,ffffffffc020372c <swapfs_read+0x74>
ffffffffc02036fe:	60a2                	ld	ra,8(sp)
ffffffffc0203700:	00016797          	auipc	a5,0x16
ffffffffc0203704:	e407b783          	ld	a5,-448(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc0203708:	46a1                	li	a3,8
ffffffffc020370a:	963e                	add	a2,a2,a5
ffffffffc020370c:	4505                	li	a0,1
ffffffffc020370e:	0141                	addi	sp,sp,16
ffffffffc0203710:	e1ffc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc0203714:	86aa                	mv	a3,a0
ffffffffc0203716:	00006617          	auipc	a2,0x6
ffffffffc020371a:	0a260613          	addi	a2,a2,162 # ffffffffc02097b8 <default_pmm_manager+0x340>
ffffffffc020371e:	45d1                	li	a1,20
ffffffffc0203720:	00006517          	auipc	a0,0x6
ffffffffc0203724:	08050513          	addi	a0,a0,128 # ffffffffc02097a0 <default_pmm_manager+0x328>
ffffffffc0203728:	ae1fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020372c:	86b2                	mv	a3,a2
ffffffffc020372e:	06900593          	li	a1,105
ffffffffc0203732:	00005617          	auipc	a2,0x5
ffffffffc0203736:	3b660613          	addi	a2,a2,950 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc020373a:	00005517          	auipc	a0,0x5
ffffffffc020373e:	30e50513          	addi	a0,a0,782 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203742:	ac7fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203746 <swapfs_write>:
ffffffffc0203746:	1141                	addi	sp,sp,-16
ffffffffc0203748:	e406                	sd	ra,8(sp)
ffffffffc020374a:	00855793          	srli	a5,a0,0x8
ffffffffc020374e:	cbb1                	beqz	a5,ffffffffc02037a2 <swapfs_write+0x5c>
ffffffffc0203750:	00016717          	auipc	a4,0x16
ffffffffc0203754:	ea873703          	ld	a4,-344(a4) # ffffffffc02195f8 <max_swap_offset>
ffffffffc0203758:	04e7f563          	bgeu	a5,a4,ffffffffc02037a2 <swapfs_write+0x5c>
ffffffffc020375c:	00016617          	auipc	a2,0x16
ffffffffc0203760:	df463603          	ld	a2,-524(a2) # ffffffffc0219550 <pages>
ffffffffc0203764:	8d91                	sub	a1,a1,a2
ffffffffc0203766:	4065d613          	srai	a2,a1,0x6
ffffffffc020376a:	00007717          	auipc	a4,0x7
ffffffffc020376e:	12e73703          	ld	a4,302(a4) # ffffffffc020a898 <nbase>
ffffffffc0203772:	963a                	add	a2,a2,a4
ffffffffc0203774:	00c61713          	slli	a4,a2,0xc
ffffffffc0203778:	8331                	srli	a4,a4,0xc
ffffffffc020377a:	00016697          	auipc	a3,0x16
ffffffffc020377e:	d5e6b683          	ld	a3,-674(a3) # ffffffffc02194d8 <npage>
ffffffffc0203782:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203786:	0632                	slli	a2,a2,0xc
ffffffffc0203788:	02d77963          	bgeu	a4,a3,ffffffffc02037ba <swapfs_write+0x74>
ffffffffc020378c:	60a2                	ld	ra,8(sp)
ffffffffc020378e:	00016797          	auipc	a5,0x16
ffffffffc0203792:	db27b783          	ld	a5,-590(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc0203796:	46a1                	li	a3,8
ffffffffc0203798:	963e                	add	a2,a2,a5
ffffffffc020379a:	4505                	li	a0,1
ffffffffc020379c:	0141                	addi	sp,sp,16
ffffffffc020379e:	db5fc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc02037a2:	86aa                	mv	a3,a0
ffffffffc02037a4:	00006617          	auipc	a2,0x6
ffffffffc02037a8:	01460613          	addi	a2,a2,20 # ffffffffc02097b8 <default_pmm_manager+0x340>
ffffffffc02037ac:	45e5                	li	a1,25
ffffffffc02037ae:	00006517          	auipc	a0,0x6
ffffffffc02037b2:	ff250513          	addi	a0,a0,-14 # ffffffffc02097a0 <default_pmm_manager+0x328>
ffffffffc02037b6:	a53fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02037ba:	86b2                	mv	a3,a2
ffffffffc02037bc:	06900593          	li	a1,105
ffffffffc02037c0:	00005617          	auipc	a2,0x5
ffffffffc02037c4:	32860613          	addi	a2,a2,808 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc02037c8:	00005517          	auipc	a0,0x5
ffffffffc02037cc:	28050513          	addi	a0,a0,640 # ffffffffc0208a48 <commands+0x720>
ffffffffc02037d0:	a39fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02037d4 <kernel_thread_entry>:
ffffffffc02037d4:	8526                	mv	a0,s1
ffffffffc02037d6:	9402                	jalr	s0
ffffffffc02037d8:	680000ef          	jal	ra,ffffffffc0203e58 <do_exit>

ffffffffc02037dc <switch_to>:
ffffffffc02037dc:	00153023          	sd	ra,0(a0)
ffffffffc02037e0:	00253423          	sd	sp,8(a0)
ffffffffc02037e4:	e900                	sd	s0,16(a0)
ffffffffc02037e6:	ed04                	sd	s1,24(a0)
ffffffffc02037e8:	03253023          	sd	s2,32(a0)
ffffffffc02037ec:	03353423          	sd	s3,40(a0)
ffffffffc02037f0:	03453823          	sd	s4,48(a0)
ffffffffc02037f4:	03553c23          	sd	s5,56(a0)
ffffffffc02037f8:	05653023          	sd	s6,64(a0)
ffffffffc02037fc:	05753423          	sd	s7,72(a0)
ffffffffc0203800:	05853823          	sd	s8,80(a0)
ffffffffc0203804:	05953c23          	sd	s9,88(a0)
ffffffffc0203808:	07a53023          	sd	s10,96(a0)
ffffffffc020380c:	07b53423          	sd	s11,104(a0)
ffffffffc0203810:	0005b083          	ld	ra,0(a1)
ffffffffc0203814:	0085b103          	ld	sp,8(a1)
ffffffffc0203818:	6980                	ld	s0,16(a1)
ffffffffc020381a:	6d84                	ld	s1,24(a1)
ffffffffc020381c:	0205b903          	ld	s2,32(a1)
ffffffffc0203820:	0285b983          	ld	s3,40(a1)
ffffffffc0203824:	0305ba03          	ld	s4,48(a1)
ffffffffc0203828:	0385ba83          	ld	s5,56(a1)
ffffffffc020382c:	0405bb03          	ld	s6,64(a1)
ffffffffc0203830:	0485bb83          	ld	s7,72(a1)
ffffffffc0203834:	0505bc03          	ld	s8,80(a1)
ffffffffc0203838:	0585bc83          	ld	s9,88(a1)
ffffffffc020383c:	0605bd03          	ld	s10,96(a1)
ffffffffc0203840:	0685bd83          	ld	s11,104(a1)
ffffffffc0203844:	8082                	ret

ffffffffc0203846 <alloc_proc>:
ffffffffc0203846:	1141                	addi	sp,sp,-16
ffffffffc0203848:	14800513          	li	a0,328
ffffffffc020384c:	e022                	sd	s0,0(sp)
ffffffffc020384e:	e406                	sd	ra,8(sp)
ffffffffc0203850:	9ddfe0ef          	jal	ra,ffffffffc020222c <kmalloc>
ffffffffc0203854:	842a                	mv	s0,a0
ffffffffc0203856:	cd21                	beqz	a0,ffffffffc02038ae <alloc_proc+0x68>
ffffffffc0203858:	57fd                	li	a5,-1
ffffffffc020385a:	1782                	slli	a5,a5,0x20
ffffffffc020385c:	e11c                	sd	a5,0(a0)
ffffffffc020385e:	07000613          	li	a2,112
ffffffffc0203862:	4581                	li	a1,0
ffffffffc0203864:	00052423          	sw	zero,8(a0)
ffffffffc0203868:	00053823          	sd	zero,16(a0)
ffffffffc020386c:	00053c23          	sd	zero,24(a0)
ffffffffc0203870:	02053023          	sd	zero,32(a0)
ffffffffc0203874:	02053423          	sd	zero,40(a0)
ffffffffc0203878:	03050513          	addi	a0,a0,48
ffffffffc020387c:	3dc040ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0203880:	00016797          	auipc	a5,0x16
ffffffffc0203884:	cc87b783          	ld	a5,-824(a5) # ffffffffc0219548 <boot_cr3>
ffffffffc0203888:	0a043023          	sd	zero,160(s0)
ffffffffc020388c:	f45c                	sd	a5,168(s0)
ffffffffc020388e:	0a042823          	sw	zero,176(s0)
ffffffffc0203892:	463d                	li	a2,15
ffffffffc0203894:	4581                	li	a1,0
ffffffffc0203896:	0b440513          	addi	a0,s0,180
ffffffffc020389a:	3be040ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc020389e:	0e042623          	sw	zero,236(s0)
ffffffffc02038a2:	0e043c23          	sd	zero,248(s0)
ffffffffc02038a6:	10043023          	sd	zero,256(s0)
ffffffffc02038aa:	0e043823          	sd	zero,240(s0)
ffffffffc02038ae:	60a2                	ld	ra,8(sp)
ffffffffc02038b0:	8522                	mv	a0,s0
ffffffffc02038b2:	6402                	ld	s0,0(sp)
ffffffffc02038b4:	0141                	addi	sp,sp,16
ffffffffc02038b6:	8082                	ret

ffffffffc02038b8 <forkret>:
ffffffffc02038b8:	00016797          	auipc	a5,0x16
ffffffffc02038bc:	c487b783          	ld	a5,-952(a5) # ffffffffc0219500 <current>
ffffffffc02038c0:	73c8                	ld	a0,160(a5)
ffffffffc02038c2:	c68fd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc02038c6 <setup_pgdir.isra.0>:
ffffffffc02038c6:	1101                	addi	sp,sp,-32
ffffffffc02038c8:	e426                	sd	s1,8(sp)
ffffffffc02038ca:	84aa                	mv	s1,a0
ffffffffc02038cc:	4505                	li	a0,1
ffffffffc02038ce:	ec06                	sd	ra,24(sp)
ffffffffc02038d0:	e822                	sd	s0,16(sp)
ffffffffc02038d2:	c78fd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc02038d6:	c939                	beqz	a0,ffffffffc020392c <setup_pgdir.isra.0+0x66>
ffffffffc02038d8:	00016697          	auipc	a3,0x16
ffffffffc02038dc:	c786b683          	ld	a3,-904(a3) # ffffffffc0219550 <pages>
ffffffffc02038e0:	40d506b3          	sub	a3,a0,a3
ffffffffc02038e4:	8699                	srai	a3,a3,0x6
ffffffffc02038e6:	00007417          	auipc	s0,0x7
ffffffffc02038ea:	fb243403          	ld	s0,-78(s0) # ffffffffc020a898 <nbase>
ffffffffc02038ee:	96a2                	add	a3,a3,s0
ffffffffc02038f0:	00c69793          	slli	a5,a3,0xc
ffffffffc02038f4:	83b1                	srli	a5,a5,0xc
ffffffffc02038f6:	00016717          	auipc	a4,0x16
ffffffffc02038fa:	be273703          	ld	a4,-1054(a4) # ffffffffc02194d8 <npage>
ffffffffc02038fe:	06b2                	slli	a3,a3,0xc
ffffffffc0203900:	02e7f863          	bgeu	a5,a4,ffffffffc0203930 <setup_pgdir.isra.0+0x6a>
ffffffffc0203904:	00016417          	auipc	s0,0x16
ffffffffc0203908:	c3c43403          	ld	s0,-964(s0) # ffffffffc0219540 <va_pa_offset>
ffffffffc020390c:	9436                	add	s0,s0,a3
ffffffffc020390e:	6605                	lui	a2,0x1
ffffffffc0203910:	00016597          	auipc	a1,0x16
ffffffffc0203914:	bc05b583          	ld	a1,-1088(a1) # ffffffffc02194d0 <boot_pgdir>
ffffffffc0203918:	8522                	mv	a0,s0
ffffffffc020391a:	350040ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc020391e:	4501                	li	a0,0
ffffffffc0203920:	e080                	sd	s0,0(s1)
ffffffffc0203922:	60e2                	ld	ra,24(sp)
ffffffffc0203924:	6442                	ld	s0,16(sp)
ffffffffc0203926:	64a2                	ld	s1,8(sp)
ffffffffc0203928:	6105                	addi	sp,sp,32
ffffffffc020392a:	8082                	ret
ffffffffc020392c:	5571                	li	a0,-4
ffffffffc020392e:	bfd5                	j	ffffffffc0203922 <setup_pgdir.isra.0+0x5c>
ffffffffc0203930:	00005617          	auipc	a2,0x5
ffffffffc0203934:	1b860613          	addi	a2,a2,440 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0203938:	06900593          	li	a1,105
ffffffffc020393c:	00005517          	auipc	a0,0x5
ffffffffc0203940:	10c50513          	addi	a0,a0,268 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203944:	8c5fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203948 <set_proc_name>:
ffffffffc0203948:	1101                	addi	sp,sp,-32
ffffffffc020394a:	e822                	sd	s0,16(sp)
ffffffffc020394c:	0b450413          	addi	s0,a0,180
ffffffffc0203950:	e426                	sd	s1,8(sp)
ffffffffc0203952:	4641                	li	a2,16
ffffffffc0203954:	84ae                	mv	s1,a1
ffffffffc0203956:	8522                	mv	a0,s0
ffffffffc0203958:	4581                	li	a1,0
ffffffffc020395a:	ec06                	sd	ra,24(sp)
ffffffffc020395c:	2fc040ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0203960:	8522                	mv	a0,s0
ffffffffc0203962:	6442                	ld	s0,16(sp)
ffffffffc0203964:	60e2                	ld	ra,24(sp)
ffffffffc0203966:	85a6                	mv	a1,s1
ffffffffc0203968:	64a2                	ld	s1,8(sp)
ffffffffc020396a:	463d                	li	a2,15
ffffffffc020396c:	6105                	addi	sp,sp,32
ffffffffc020396e:	2fc0406f          	j	ffffffffc0207c6a <memcpy>

ffffffffc0203972 <proc_run>:
ffffffffc0203972:	7179                	addi	sp,sp,-48
ffffffffc0203974:	ec4a                	sd	s2,24(sp)
ffffffffc0203976:	00016917          	auipc	s2,0x16
ffffffffc020397a:	b8a90913          	addi	s2,s2,-1142 # ffffffffc0219500 <current>
ffffffffc020397e:	f026                	sd	s1,32(sp)
ffffffffc0203980:	00093483          	ld	s1,0(s2)
ffffffffc0203984:	f406                	sd	ra,40(sp)
ffffffffc0203986:	e84e                	sd	s3,16(sp)
ffffffffc0203988:	02a48863          	beq	s1,a0,ffffffffc02039b8 <proc_run+0x46>
ffffffffc020398c:	100027f3          	csrr	a5,sstatus
ffffffffc0203990:	8b89                	andi	a5,a5,2
ffffffffc0203992:	4981                	li	s3,0
ffffffffc0203994:	ef9d                	bnez	a5,ffffffffc02039d2 <proc_run+0x60>
ffffffffc0203996:	755c                	ld	a5,168(a0)
ffffffffc0203998:	577d                	li	a4,-1
ffffffffc020399a:	177e                	slli	a4,a4,0x3f
ffffffffc020399c:	83b1                	srli	a5,a5,0xc
ffffffffc020399e:	00a93023          	sd	a0,0(s2)
ffffffffc02039a2:	8fd9                	or	a5,a5,a4
ffffffffc02039a4:	18079073          	csrw	satp,a5
ffffffffc02039a8:	03050593          	addi	a1,a0,48
ffffffffc02039ac:	03048513          	addi	a0,s1,48
ffffffffc02039b0:	e2dff0ef          	jal	ra,ffffffffc02037dc <switch_to>
ffffffffc02039b4:	00099863          	bnez	s3,ffffffffc02039c4 <proc_run+0x52>
ffffffffc02039b8:	70a2                	ld	ra,40(sp)
ffffffffc02039ba:	7482                	ld	s1,32(sp)
ffffffffc02039bc:	6962                	ld	s2,24(sp)
ffffffffc02039be:	69c2                	ld	s3,16(sp)
ffffffffc02039c0:	6145                	addi	sp,sp,48
ffffffffc02039c2:	8082                	ret
ffffffffc02039c4:	70a2                	ld	ra,40(sp)
ffffffffc02039c6:	7482                	ld	s1,32(sp)
ffffffffc02039c8:	6962                	ld	s2,24(sp)
ffffffffc02039ca:	69c2                	ld	s3,16(sp)
ffffffffc02039cc:	6145                	addi	sp,sp,48
ffffffffc02039ce:	c65fc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02039d2:	e42a                	sd	a0,8(sp)
ffffffffc02039d4:	c65fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02039d8:	6522                	ld	a0,8(sp)
ffffffffc02039da:	4985                	li	s3,1
ffffffffc02039dc:	bf6d                	j	ffffffffc0203996 <proc_run+0x24>

ffffffffc02039de <find_proc>:
ffffffffc02039de:	6789                	lui	a5,0x2
ffffffffc02039e0:	fff5071b          	addiw	a4,a0,-1
ffffffffc02039e4:	17f9                	addi	a5,a5,-2
ffffffffc02039e6:	04e7e063          	bltu	a5,a4,ffffffffc0203a26 <find_proc+0x48>
ffffffffc02039ea:	1141                	addi	sp,sp,-16
ffffffffc02039ec:	e022                	sd	s0,0(sp)
ffffffffc02039ee:	45a9                	li	a1,10
ffffffffc02039f0:	842a                	mv	s0,a0
ffffffffc02039f2:	2501                	sext.w	a0,a0
ffffffffc02039f4:	e406                	sd	ra,8(sp)
ffffffffc02039f6:	67a040ef          	jal	ra,ffffffffc0208070 <hash32>
ffffffffc02039fa:	02051693          	slli	a3,a0,0x20
ffffffffc02039fe:	00012797          	auipc	a5,0x12
ffffffffc0203a02:	a9a78793          	addi	a5,a5,-1382 # ffffffffc0215498 <hash_list>
ffffffffc0203a06:	82f1                	srli	a3,a3,0x1c
ffffffffc0203a08:	96be                	add	a3,a3,a5
ffffffffc0203a0a:	87b6                	mv	a5,a3
ffffffffc0203a0c:	a029                	j	ffffffffc0203a16 <find_proc+0x38>
ffffffffc0203a0e:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0203a12:	00870c63          	beq	a4,s0,ffffffffc0203a2a <find_proc+0x4c>
ffffffffc0203a16:	679c                	ld	a5,8(a5)
ffffffffc0203a18:	fef69be3          	bne	a3,a5,ffffffffc0203a0e <find_proc+0x30>
ffffffffc0203a1c:	60a2                	ld	ra,8(sp)
ffffffffc0203a1e:	6402                	ld	s0,0(sp)
ffffffffc0203a20:	4501                	li	a0,0
ffffffffc0203a22:	0141                	addi	sp,sp,16
ffffffffc0203a24:	8082                	ret
ffffffffc0203a26:	4501                	li	a0,0
ffffffffc0203a28:	8082                	ret
ffffffffc0203a2a:	60a2                	ld	ra,8(sp)
ffffffffc0203a2c:	6402                	ld	s0,0(sp)
ffffffffc0203a2e:	f2878513          	addi	a0,a5,-216
ffffffffc0203a32:	0141                	addi	sp,sp,16
ffffffffc0203a34:	8082                	ret

ffffffffc0203a36 <do_fork>:
ffffffffc0203a36:	7159                	addi	sp,sp,-112
ffffffffc0203a38:	e4ce                	sd	s3,72(sp)
ffffffffc0203a3a:	00016997          	auipc	s3,0x16
ffffffffc0203a3e:	ade98993          	addi	s3,s3,-1314 # ffffffffc0219518 <nr_process>
ffffffffc0203a42:	0009a703          	lw	a4,0(s3)
ffffffffc0203a46:	f486                	sd	ra,104(sp)
ffffffffc0203a48:	f0a2                	sd	s0,96(sp)
ffffffffc0203a4a:	eca6                	sd	s1,88(sp)
ffffffffc0203a4c:	e8ca                	sd	s2,80(sp)
ffffffffc0203a4e:	e0d2                	sd	s4,64(sp)
ffffffffc0203a50:	fc56                	sd	s5,56(sp)
ffffffffc0203a52:	f85a                	sd	s6,48(sp)
ffffffffc0203a54:	f45e                	sd	s7,40(sp)
ffffffffc0203a56:	f062                	sd	s8,32(sp)
ffffffffc0203a58:	ec66                	sd	s9,24(sp)
ffffffffc0203a5a:	e86a                	sd	s10,16(sp)
ffffffffc0203a5c:	e46e                	sd	s11,8(sp)
ffffffffc0203a5e:	6785                	lui	a5,0x1
ffffffffc0203a60:	30f75f63          	bge	a4,a5,ffffffffc0203d7e <do_fork+0x348>
ffffffffc0203a64:	8a2a                	mv	s4,a0
ffffffffc0203a66:	892e                	mv	s2,a1
ffffffffc0203a68:	84b2                	mv	s1,a2
ffffffffc0203a6a:	dddff0ef          	jal	ra,ffffffffc0203846 <alloc_proc>
ffffffffc0203a6e:	842a                	mv	s0,a0
ffffffffc0203a70:	28050263          	beqz	a0,ffffffffc0203cf4 <do_fork+0x2be>
ffffffffc0203a74:	00016b97          	auipc	s7,0x16
ffffffffc0203a78:	a8cb8b93          	addi	s7,s7,-1396 # ffffffffc0219500 <current>
ffffffffc0203a7c:	000bb783          	ld	a5,0(s7)
ffffffffc0203a80:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc0203a84:	f11c                	sd	a5,32(a0)
ffffffffc0203a86:	30071c63          	bnez	a4,ffffffffc0203d9e <do_fork+0x368>
ffffffffc0203a8a:	4509                	li	a0,2
ffffffffc0203a8c:	abefd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0203a90:	24050f63          	beqz	a0,ffffffffc0203cee <do_fork+0x2b8>
ffffffffc0203a94:	00016c17          	auipc	s8,0x16
ffffffffc0203a98:	abcc0c13          	addi	s8,s8,-1348 # ffffffffc0219550 <pages>
ffffffffc0203a9c:	000c3683          	ld	a3,0(s8)
ffffffffc0203aa0:	00007a97          	auipc	s5,0x7
ffffffffc0203aa4:	df8aba83          	ld	s5,-520(s5) # ffffffffc020a898 <nbase>
ffffffffc0203aa8:	00016c97          	auipc	s9,0x16
ffffffffc0203aac:	a30c8c93          	addi	s9,s9,-1488 # ffffffffc02194d8 <npage>
ffffffffc0203ab0:	40d506b3          	sub	a3,a0,a3
ffffffffc0203ab4:	8699                	srai	a3,a3,0x6
ffffffffc0203ab6:	96d6                	add	a3,a3,s5
ffffffffc0203ab8:	000cb703          	ld	a4,0(s9)
ffffffffc0203abc:	00c69793          	slli	a5,a3,0xc
ffffffffc0203ac0:	83b1                	srli	a5,a5,0xc
ffffffffc0203ac2:	06b2                	slli	a3,a3,0xc
ffffffffc0203ac4:	2ce7f163          	bgeu	a5,a4,ffffffffc0203d86 <do_fork+0x350>
ffffffffc0203ac8:	000bb703          	ld	a4,0(s7)
ffffffffc0203acc:	00016d17          	auipc	s10,0x16
ffffffffc0203ad0:	a74d0d13          	addi	s10,s10,-1420 # ffffffffc0219540 <va_pa_offset>
ffffffffc0203ad4:	000d3783          	ld	a5,0(s10)
ffffffffc0203ad8:	02873b03          	ld	s6,40(a4)
ffffffffc0203adc:	96be                	add	a3,a3,a5
ffffffffc0203ade:	e814                	sd	a3,16(s0)
ffffffffc0203ae0:	020b0863          	beqz	s6,ffffffffc0203b10 <do_fork+0xda>
ffffffffc0203ae4:	100a7a13          	andi	s4,s4,256
ffffffffc0203ae8:	1c0a0163          	beqz	s4,ffffffffc0203caa <do_fork+0x274>
ffffffffc0203aec:	030b2703          	lw	a4,48(s6)
ffffffffc0203af0:	018b3783          	ld	a5,24(s6)
ffffffffc0203af4:	c02006b7          	lui	a3,0xc0200
ffffffffc0203af8:	2705                	addiw	a4,a4,1
ffffffffc0203afa:	02eb2823          	sw	a4,48(s6)
ffffffffc0203afe:	03643423          	sd	s6,40(s0)
ffffffffc0203b02:	2ad7ee63          	bltu	a5,a3,ffffffffc0203dbe <do_fork+0x388>
ffffffffc0203b06:	000d3703          	ld	a4,0(s10)
ffffffffc0203b0a:	6814                	ld	a3,16(s0)
ffffffffc0203b0c:	8f99                	sub	a5,a5,a4
ffffffffc0203b0e:	f45c                	sd	a5,168(s0)
ffffffffc0203b10:	6789                	lui	a5,0x2
ffffffffc0203b12:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc0203b16:	97b6                	add	a5,a5,a3
ffffffffc0203b18:	8626                	mv	a2,s1
ffffffffc0203b1a:	f05c                	sd	a5,160(s0)
ffffffffc0203b1c:	873e                	mv	a4,a5
ffffffffc0203b1e:	12048313          	addi	t1,s1,288
ffffffffc0203b22:	00063883          	ld	a7,0(a2)
ffffffffc0203b26:	00863803          	ld	a6,8(a2)
ffffffffc0203b2a:	6a08                	ld	a0,16(a2)
ffffffffc0203b2c:	6e0c                	ld	a1,24(a2)
ffffffffc0203b2e:	01173023          	sd	a7,0(a4)
ffffffffc0203b32:	01073423          	sd	a6,8(a4)
ffffffffc0203b36:	eb08                	sd	a0,16(a4)
ffffffffc0203b38:	ef0c                	sd	a1,24(a4)
ffffffffc0203b3a:	02060613          	addi	a2,a2,32
ffffffffc0203b3e:	02070713          	addi	a4,a4,32
ffffffffc0203b42:	fe6610e3          	bne	a2,t1,ffffffffc0203b22 <do_fork+0xec>
ffffffffc0203b46:	0407b823          	sd	zero,80(a5)
ffffffffc0203b4a:	12090a63          	beqz	s2,ffffffffc0203c7e <do_fork+0x248>
ffffffffc0203b4e:	0127b823          	sd	s2,16(a5)
ffffffffc0203b52:	00000717          	auipc	a4,0x0
ffffffffc0203b56:	d6670713          	addi	a4,a4,-666 # ffffffffc02038b8 <forkret>
ffffffffc0203b5a:	f818                	sd	a4,48(s0)
ffffffffc0203b5c:	fc1c                	sd	a5,56(s0)
ffffffffc0203b5e:	100027f3          	csrr	a5,sstatus
ffffffffc0203b62:	8b89                	andi	a5,a5,2
ffffffffc0203b64:	4901                	li	s2,0
ffffffffc0203b66:	12079e63          	bnez	a5,ffffffffc0203ca2 <do_fork+0x26c>
ffffffffc0203b6a:	0000a597          	auipc	a1,0xa
ffffffffc0203b6e:	52258593          	addi	a1,a1,1314 # ffffffffc020e08c <last_pid.1812>
ffffffffc0203b72:	419c                	lw	a5,0(a1)
ffffffffc0203b74:	6709                	lui	a4,0x2
ffffffffc0203b76:	0017851b          	addiw	a0,a5,1
ffffffffc0203b7a:	c188                	sw	a0,0(a1)
ffffffffc0203b7c:	08e55b63          	bge	a0,a4,ffffffffc0203c12 <do_fork+0x1dc>
ffffffffc0203b80:	0000a897          	auipc	a7,0xa
ffffffffc0203b84:	51088893          	addi	a7,a7,1296 # ffffffffc020e090 <next_safe.1811>
ffffffffc0203b88:	0008a783          	lw	a5,0(a7)
ffffffffc0203b8c:	00016497          	auipc	s1,0x16
ffffffffc0203b90:	b1448493          	addi	s1,s1,-1260 # ffffffffc02196a0 <proc_list>
ffffffffc0203b94:	08f55663          	bge	a0,a5,ffffffffc0203c20 <do_fork+0x1ea>
ffffffffc0203b98:	c048                	sw	a0,4(s0)
ffffffffc0203b9a:	45a9                	li	a1,10
ffffffffc0203b9c:	2501                	sext.w	a0,a0
ffffffffc0203b9e:	4d2040ef          	jal	ra,ffffffffc0208070 <hash32>
ffffffffc0203ba2:	1502                	slli	a0,a0,0x20
ffffffffc0203ba4:	00012797          	auipc	a5,0x12
ffffffffc0203ba8:	8f478793          	addi	a5,a5,-1804 # ffffffffc0215498 <hash_list>
ffffffffc0203bac:	8171                	srli	a0,a0,0x1c
ffffffffc0203bae:	953e                	add	a0,a0,a5
ffffffffc0203bb0:	650c                	ld	a1,8(a0)
ffffffffc0203bb2:	7014                	ld	a3,32(s0)
ffffffffc0203bb4:	0d840793          	addi	a5,s0,216
ffffffffc0203bb8:	e19c                	sd	a5,0(a1)
ffffffffc0203bba:	6490                	ld	a2,8(s1)
ffffffffc0203bbc:	e51c                	sd	a5,8(a0)
ffffffffc0203bbe:	7af8                	ld	a4,240(a3)
ffffffffc0203bc0:	0c840793          	addi	a5,s0,200
ffffffffc0203bc4:	f06c                	sd	a1,224(s0)
ffffffffc0203bc6:	ec68                	sd	a0,216(s0)
ffffffffc0203bc8:	e21c                	sd	a5,0(a2)
ffffffffc0203bca:	e49c                	sd	a5,8(s1)
ffffffffc0203bcc:	e870                	sd	a2,208(s0)
ffffffffc0203bce:	e464                	sd	s1,200(s0)
ffffffffc0203bd0:	0e043c23          	sd	zero,248(s0)
ffffffffc0203bd4:	10e43023          	sd	a4,256(s0)
ffffffffc0203bd8:	c311                	beqz	a4,ffffffffc0203bdc <do_fork+0x1a6>
ffffffffc0203bda:	ff60                	sd	s0,248(a4)
ffffffffc0203bdc:	0009a783          	lw	a5,0(s3)
ffffffffc0203be0:	fae0                	sd	s0,240(a3)
ffffffffc0203be2:	2785                	addiw	a5,a5,1
ffffffffc0203be4:	00f9a023          	sw	a5,0(s3)
ffffffffc0203be8:	10091863          	bnez	s2,ffffffffc0203cf8 <do_fork+0x2c2>
ffffffffc0203bec:	8522                	mv	a0,s0
ffffffffc0203bee:	733000ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc0203bf2:	4048                	lw	a0,4(s0)
ffffffffc0203bf4:	70a6                	ld	ra,104(sp)
ffffffffc0203bf6:	7406                	ld	s0,96(sp)
ffffffffc0203bf8:	64e6                	ld	s1,88(sp)
ffffffffc0203bfa:	6946                	ld	s2,80(sp)
ffffffffc0203bfc:	69a6                	ld	s3,72(sp)
ffffffffc0203bfe:	6a06                	ld	s4,64(sp)
ffffffffc0203c00:	7ae2                	ld	s5,56(sp)
ffffffffc0203c02:	7b42                	ld	s6,48(sp)
ffffffffc0203c04:	7ba2                	ld	s7,40(sp)
ffffffffc0203c06:	7c02                	ld	s8,32(sp)
ffffffffc0203c08:	6ce2                	ld	s9,24(sp)
ffffffffc0203c0a:	6d42                	ld	s10,16(sp)
ffffffffc0203c0c:	6da2                	ld	s11,8(sp)
ffffffffc0203c0e:	6165                	addi	sp,sp,112
ffffffffc0203c10:	8082                	ret
ffffffffc0203c12:	4785                	li	a5,1
ffffffffc0203c14:	c19c                	sw	a5,0(a1)
ffffffffc0203c16:	4505                	li	a0,1
ffffffffc0203c18:	0000a897          	auipc	a7,0xa
ffffffffc0203c1c:	47888893          	addi	a7,a7,1144 # ffffffffc020e090 <next_safe.1811>
ffffffffc0203c20:	00016497          	auipc	s1,0x16
ffffffffc0203c24:	a8048493          	addi	s1,s1,-1408 # ffffffffc02196a0 <proc_list>
ffffffffc0203c28:	0084b303          	ld	t1,8(s1)
ffffffffc0203c2c:	6789                	lui	a5,0x2
ffffffffc0203c2e:	00f8a023          	sw	a5,0(a7)
ffffffffc0203c32:	4801                	li	a6,0
ffffffffc0203c34:	87aa                	mv	a5,a0
ffffffffc0203c36:	6e89                	lui	t4,0x2
ffffffffc0203c38:	12930e63          	beq	t1,s1,ffffffffc0203d74 <do_fork+0x33e>
ffffffffc0203c3c:	8e42                	mv	t3,a6
ffffffffc0203c3e:	869a                	mv	a3,t1
ffffffffc0203c40:	6609                	lui	a2,0x2
ffffffffc0203c42:	a811                	j	ffffffffc0203c56 <do_fork+0x220>
ffffffffc0203c44:	00e7d663          	bge	a5,a4,ffffffffc0203c50 <do_fork+0x21a>
ffffffffc0203c48:	00c75463          	bge	a4,a2,ffffffffc0203c50 <do_fork+0x21a>
ffffffffc0203c4c:	863a                	mv	a2,a4
ffffffffc0203c4e:	4e05                	li	t3,1
ffffffffc0203c50:	6694                	ld	a3,8(a3)
ffffffffc0203c52:	00968d63          	beq	a3,s1,ffffffffc0203c6c <do_fork+0x236>
ffffffffc0203c56:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203c5a:	fef715e3          	bne	a4,a5,ffffffffc0203c44 <do_fork+0x20e>
ffffffffc0203c5e:	2785                	addiw	a5,a5,1
ffffffffc0203c60:	08c7df63          	bge	a5,a2,ffffffffc0203cfe <do_fork+0x2c8>
ffffffffc0203c64:	6694                	ld	a3,8(a3)
ffffffffc0203c66:	4805                	li	a6,1
ffffffffc0203c68:	fe9697e3          	bne	a3,s1,ffffffffc0203c56 <do_fork+0x220>
ffffffffc0203c6c:	00080463          	beqz	a6,ffffffffc0203c74 <do_fork+0x23e>
ffffffffc0203c70:	c19c                	sw	a5,0(a1)
ffffffffc0203c72:	853e                	mv	a0,a5
ffffffffc0203c74:	f20e02e3          	beqz	t3,ffffffffc0203b98 <do_fork+0x162>
ffffffffc0203c78:	00c8a023          	sw	a2,0(a7)
ffffffffc0203c7c:	bf31                	j	ffffffffc0203b98 <do_fork+0x162>
ffffffffc0203c7e:	6909                	lui	s2,0x2
ffffffffc0203c80:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203c84:	9936                	add	s2,s2,a3
ffffffffc0203c86:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203c8a:	00000717          	auipc	a4,0x0
ffffffffc0203c8e:	c2e70713          	addi	a4,a4,-978 # ffffffffc02038b8 <forkret>
ffffffffc0203c92:	f818                	sd	a4,48(s0)
ffffffffc0203c94:	fc1c                	sd	a5,56(s0)
ffffffffc0203c96:	100027f3          	csrr	a5,sstatus
ffffffffc0203c9a:	8b89                	andi	a5,a5,2
ffffffffc0203c9c:	4901                	li	s2,0
ffffffffc0203c9e:	ec0786e3          	beqz	a5,ffffffffc0203b6a <do_fork+0x134>
ffffffffc0203ca2:	997fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203ca6:	4905                	li	s2,1
ffffffffc0203ca8:	b5c9                	j	ffffffffc0203b6a <do_fork+0x134>
ffffffffc0203caa:	e7dfd0ef          	jal	ra,ffffffffc0201b26 <mm_create>
ffffffffc0203cae:	8a2a                	mv	s4,a0
ffffffffc0203cb0:	c901                	beqz	a0,ffffffffc0203cc0 <do_fork+0x28a>
ffffffffc0203cb2:	0561                	addi	a0,a0,24
ffffffffc0203cb4:	c13ff0ef          	jal	ra,ffffffffc02038c6 <setup_pgdir.isra.0>
ffffffffc0203cb8:	c921                	beqz	a0,ffffffffc0203d08 <do_fork+0x2d2>
ffffffffc0203cba:	8552                	mv	a0,s4
ffffffffc0203cbc:	fc9fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203cc0:	6814                	ld	a3,16(s0)
ffffffffc0203cc2:	c02007b7          	lui	a5,0xc0200
ffffffffc0203cc6:	12f6e563          	bltu	a3,a5,ffffffffc0203df0 <do_fork+0x3ba>
ffffffffc0203cca:	000d3783          	ld	a5,0(s10)
ffffffffc0203cce:	000cb703          	ld	a4,0(s9)
ffffffffc0203cd2:	40f687b3          	sub	a5,a3,a5
ffffffffc0203cd6:	83b1                	srli	a5,a5,0xc
ffffffffc0203cd8:	10e7f063          	bgeu	a5,a4,ffffffffc0203dd8 <do_fork+0x3a2>
ffffffffc0203cdc:	000c3503          	ld	a0,0(s8)
ffffffffc0203ce0:	415787b3          	sub	a5,a5,s5
ffffffffc0203ce4:	079a                	slli	a5,a5,0x6
ffffffffc0203ce6:	4589                	li	a1,2
ffffffffc0203ce8:	953e                	add	a0,a0,a5
ffffffffc0203cea:	8f2fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203cee:	8522                	mv	a0,s0
ffffffffc0203cf0:	decfe0ef          	jal	ra,ffffffffc02022dc <kfree>
ffffffffc0203cf4:	5571                	li	a0,-4
ffffffffc0203cf6:	bdfd                	j	ffffffffc0203bf4 <do_fork+0x1be>
ffffffffc0203cf8:	93bfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203cfc:	bdc5                	j	ffffffffc0203bec <do_fork+0x1b6>
ffffffffc0203cfe:	01d7c363          	blt	a5,t4,ffffffffc0203d04 <do_fork+0x2ce>
ffffffffc0203d02:	4785                	li	a5,1
ffffffffc0203d04:	4805                	li	a6,1
ffffffffc0203d06:	bf0d                	j	ffffffffc0203c38 <do_fork+0x202>
ffffffffc0203d08:	038b0d93          	addi	s11,s6,56
ffffffffc0203d0c:	856e                	mv	a0,s11
ffffffffc0203d0e:	917ff0ef          	jal	ra,ffffffffc0203624 <down>
ffffffffc0203d12:	000bb783          	ld	a5,0(s7)
ffffffffc0203d16:	c781                	beqz	a5,ffffffffc0203d1e <do_fork+0x2e8>
ffffffffc0203d18:	43dc                	lw	a5,4(a5)
ffffffffc0203d1a:	04fb2823          	sw	a5,80(s6)
ffffffffc0203d1e:	85da                	mv	a1,s6
ffffffffc0203d20:	8552                	mv	a0,s4
ffffffffc0203d22:	862fe0ef          	jal	ra,ffffffffc0201d84 <dup_mmap>
ffffffffc0203d26:	8baa                	mv	s7,a0
ffffffffc0203d28:	856e                	mv	a0,s11
ffffffffc0203d2a:	8f9ff0ef          	jal	ra,ffffffffc0203622 <up>
ffffffffc0203d2e:	040b2823          	sw	zero,80(s6)
ffffffffc0203d32:	8b52                	mv	s6,s4
ffffffffc0203d34:	da0b8ce3          	beqz	s7,ffffffffc0203aec <do_fork+0xb6>
ffffffffc0203d38:	8552                	mv	a0,s4
ffffffffc0203d3a:	8e4fe0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc0203d3e:	018a3683          	ld	a3,24(s4)
ffffffffc0203d42:	c02007b7          	lui	a5,0xc0200
ffffffffc0203d46:	0af6e563          	bltu	a3,a5,ffffffffc0203df0 <do_fork+0x3ba>
ffffffffc0203d4a:	000d3703          	ld	a4,0(s10)
ffffffffc0203d4e:	000cb783          	ld	a5,0(s9)
ffffffffc0203d52:	8e99                	sub	a3,a3,a4
ffffffffc0203d54:	82b1                	srli	a3,a3,0xc
ffffffffc0203d56:	08f6f163          	bgeu	a3,a5,ffffffffc0203dd8 <do_fork+0x3a2>
ffffffffc0203d5a:	000c3503          	ld	a0,0(s8)
ffffffffc0203d5e:	415686b3          	sub	a3,a3,s5
ffffffffc0203d62:	069a                	slli	a3,a3,0x6
ffffffffc0203d64:	9536                	add	a0,a0,a3
ffffffffc0203d66:	4585                	li	a1,1
ffffffffc0203d68:	874fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203d6c:	8552                	mv	a0,s4
ffffffffc0203d6e:	f17fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203d72:	b7b9                	j	ffffffffc0203cc0 <do_fork+0x28a>
ffffffffc0203d74:	00080763          	beqz	a6,ffffffffc0203d82 <do_fork+0x34c>
ffffffffc0203d78:	c19c                	sw	a5,0(a1)
ffffffffc0203d7a:	853e                	mv	a0,a5
ffffffffc0203d7c:	bd31                	j	ffffffffc0203b98 <do_fork+0x162>
ffffffffc0203d7e:	556d                	li	a0,-5
ffffffffc0203d80:	bd95                	j	ffffffffc0203bf4 <do_fork+0x1be>
ffffffffc0203d82:	4188                	lw	a0,0(a1)
ffffffffc0203d84:	bd11                	j	ffffffffc0203b98 <do_fork+0x162>
ffffffffc0203d86:	00005617          	auipc	a2,0x5
ffffffffc0203d8a:	d6260613          	addi	a2,a2,-670 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0203d8e:	06900593          	li	a1,105
ffffffffc0203d92:	00005517          	auipc	a0,0x5
ffffffffc0203d96:	cb650513          	addi	a0,a0,-842 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203d9a:	c6efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203d9e:	00006697          	auipc	a3,0x6
ffffffffc0203da2:	a3a68693          	addi	a3,a3,-1478 # ffffffffc02097d8 <default_pmm_manager+0x360>
ffffffffc0203da6:	00005617          	auipc	a2,0x5
ffffffffc0203daa:	99260613          	addi	a2,a2,-1646 # ffffffffc0208738 <commands+0x410>
ffffffffc0203dae:	1a600593          	li	a1,422
ffffffffc0203db2:	00006517          	auipc	a0,0x6
ffffffffc0203db6:	a4650513          	addi	a0,a0,-1466 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0203dba:	c4efc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203dbe:	86be                	mv	a3,a5
ffffffffc0203dc0:	00005617          	auipc	a2,0x5
ffffffffc0203dc4:	cf060613          	addi	a2,a2,-784 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0203dc8:	15900593          	li	a1,345
ffffffffc0203dcc:	00006517          	auipc	a0,0x6
ffffffffc0203dd0:	a2c50513          	addi	a0,a0,-1492 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0203dd4:	c34fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203dd8:	00005617          	auipc	a2,0x5
ffffffffc0203ddc:	c5060613          	addi	a2,a2,-944 # ffffffffc0208a28 <commands+0x700>
ffffffffc0203de0:	06200593          	li	a1,98
ffffffffc0203de4:	00005517          	auipc	a0,0x5
ffffffffc0203de8:	c6450513          	addi	a0,a0,-924 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203dec:	c1cfc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203df0:	00005617          	auipc	a2,0x5
ffffffffc0203df4:	cc060613          	addi	a2,a2,-832 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0203df8:	06e00593          	li	a1,110
ffffffffc0203dfc:	00005517          	auipc	a0,0x5
ffffffffc0203e00:	c4c50513          	addi	a0,a0,-948 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203e04:	c04fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203e08 <kernel_thread>:
ffffffffc0203e08:	7129                	addi	sp,sp,-320
ffffffffc0203e0a:	fa22                	sd	s0,304(sp)
ffffffffc0203e0c:	f626                	sd	s1,296(sp)
ffffffffc0203e0e:	f24a                	sd	s2,288(sp)
ffffffffc0203e10:	84ae                	mv	s1,a1
ffffffffc0203e12:	892a                	mv	s2,a0
ffffffffc0203e14:	8432                	mv	s0,a2
ffffffffc0203e16:	4581                	li	a1,0
ffffffffc0203e18:	12000613          	li	a2,288
ffffffffc0203e1c:	850a                	mv	a0,sp
ffffffffc0203e1e:	fe06                	sd	ra,312(sp)
ffffffffc0203e20:	639030ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0203e24:	e0ca                	sd	s2,64(sp)
ffffffffc0203e26:	e4a6                	sd	s1,72(sp)
ffffffffc0203e28:	100027f3          	csrr	a5,sstatus
ffffffffc0203e2c:	edd7f793          	andi	a5,a5,-291
ffffffffc0203e30:	1207e793          	ori	a5,a5,288
ffffffffc0203e34:	e23e                	sd	a5,256(sp)
ffffffffc0203e36:	860a                	mv	a2,sp
ffffffffc0203e38:	10046513          	ori	a0,s0,256
ffffffffc0203e3c:	00000797          	auipc	a5,0x0
ffffffffc0203e40:	99878793          	addi	a5,a5,-1640 # ffffffffc02037d4 <kernel_thread_entry>
ffffffffc0203e44:	4581                	li	a1,0
ffffffffc0203e46:	e63e                	sd	a5,264(sp)
ffffffffc0203e48:	befff0ef          	jal	ra,ffffffffc0203a36 <do_fork>
ffffffffc0203e4c:	70f2                	ld	ra,312(sp)
ffffffffc0203e4e:	7452                	ld	s0,304(sp)
ffffffffc0203e50:	74b2                	ld	s1,296(sp)
ffffffffc0203e52:	7912                	ld	s2,288(sp)
ffffffffc0203e54:	6131                	addi	sp,sp,320
ffffffffc0203e56:	8082                	ret

ffffffffc0203e58 <do_exit>:
ffffffffc0203e58:	7179                	addi	sp,sp,-48
ffffffffc0203e5a:	f022                	sd	s0,32(sp)
ffffffffc0203e5c:	00015417          	auipc	s0,0x15
ffffffffc0203e60:	6a440413          	addi	s0,s0,1700 # ffffffffc0219500 <current>
ffffffffc0203e64:	601c                	ld	a5,0(s0)
ffffffffc0203e66:	f406                	sd	ra,40(sp)
ffffffffc0203e68:	ec26                	sd	s1,24(sp)
ffffffffc0203e6a:	e84a                	sd	s2,16(sp)
ffffffffc0203e6c:	e44e                	sd	s3,8(sp)
ffffffffc0203e6e:	e052                	sd	s4,0(sp)
ffffffffc0203e70:	00015717          	auipc	a4,0x15
ffffffffc0203e74:	69873703          	ld	a4,1688(a4) # ffffffffc0219508 <idleproc>
ffffffffc0203e78:	0ce78d63          	beq	a5,a4,ffffffffc0203f52 <do_exit+0xfa>
ffffffffc0203e7c:	00015497          	auipc	s1,0x15
ffffffffc0203e80:	69448493          	addi	s1,s1,1684 # ffffffffc0219510 <initproc>
ffffffffc0203e84:	6098                	ld	a4,0(s1)
ffffffffc0203e86:	12e78963          	beq	a5,a4,ffffffffc0203fb8 <do_exit+0x160>
ffffffffc0203e8a:	0287b903          	ld	s2,40(a5)
ffffffffc0203e8e:	89aa                	mv	s3,a0
ffffffffc0203e90:	02090663          	beqz	s2,ffffffffc0203ebc <do_exit+0x64>
ffffffffc0203e94:	00015797          	auipc	a5,0x15
ffffffffc0203e98:	6b47b783          	ld	a5,1716(a5) # ffffffffc0219548 <boot_cr3>
ffffffffc0203e9c:	577d                	li	a4,-1
ffffffffc0203e9e:	177e                	slli	a4,a4,0x3f
ffffffffc0203ea0:	83b1                	srli	a5,a5,0xc
ffffffffc0203ea2:	8fd9                	or	a5,a5,a4
ffffffffc0203ea4:	18079073          	csrw	satp,a5
ffffffffc0203ea8:	03092783          	lw	a5,48(s2)
ffffffffc0203eac:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203eb0:	02e92823          	sw	a4,48(s2)
ffffffffc0203eb4:	cb5d                	beqz	a4,ffffffffc0203f6a <do_exit+0x112>
ffffffffc0203eb6:	601c                	ld	a5,0(s0)
ffffffffc0203eb8:	0207b423          	sd	zero,40(a5)
ffffffffc0203ebc:	601c                	ld	a5,0(s0)
ffffffffc0203ebe:	470d                	li	a4,3
ffffffffc0203ec0:	c398                	sw	a4,0(a5)
ffffffffc0203ec2:	0f37a423          	sw	s3,232(a5)
ffffffffc0203ec6:	100027f3          	csrr	a5,sstatus
ffffffffc0203eca:	8b89                	andi	a5,a5,2
ffffffffc0203ecc:	4a01                	li	s4,0
ffffffffc0203ece:	10079163          	bnez	a5,ffffffffc0203fd0 <do_exit+0x178>
ffffffffc0203ed2:	6018                	ld	a4,0(s0)
ffffffffc0203ed4:	800007b7          	lui	a5,0x80000
ffffffffc0203ed8:	0785                	addi	a5,a5,1
ffffffffc0203eda:	7308                	ld	a0,32(a4)
ffffffffc0203edc:	0ec52703          	lw	a4,236(a0)
ffffffffc0203ee0:	0ef70c63          	beq	a4,a5,ffffffffc0203fd8 <do_exit+0x180>
ffffffffc0203ee4:	6018                	ld	a4,0(s0)
ffffffffc0203ee6:	7b7c                	ld	a5,240(a4)
ffffffffc0203ee8:	c3a1                	beqz	a5,ffffffffc0203f28 <do_exit+0xd0>
ffffffffc0203eea:	800009b7          	lui	s3,0x80000
ffffffffc0203eee:	490d                	li	s2,3
ffffffffc0203ef0:	0985                	addi	s3,s3,1
ffffffffc0203ef2:	a021                	j	ffffffffc0203efa <do_exit+0xa2>
ffffffffc0203ef4:	6018                	ld	a4,0(s0)
ffffffffc0203ef6:	7b7c                	ld	a5,240(a4)
ffffffffc0203ef8:	cb85                	beqz	a5,ffffffffc0203f28 <do_exit+0xd0>
ffffffffc0203efa:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203efe:	6088                	ld	a0,0(s1)
ffffffffc0203f00:	fb74                	sd	a3,240(a4)
ffffffffc0203f02:	7978                	ld	a4,240(a0)
ffffffffc0203f04:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203f08:	10e7b023          	sd	a4,256(a5)
ffffffffc0203f0c:	c311                	beqz	a4,ffffffffc0203f10 <do_exit+0xb8>
ffffffffc0203f0e:	ff7c                	sd	a5,248(a4)
ffffffffc0203f10:	4398                	lw	a4,0(a5)
ffffffffc0203f12:	f388                	sd	a0,32(a5)
ffffffffc0203f14:	f97c                	sd	a5,240(a0)
ffffffffc0203f16:	fd271fe3          	bne	a4,s2,ffffffffc0203ef4 <do_exit+0x9c>
ffffffffc0203f1a:	0ec52783          	lw	a5,236(a0)
ffffffffc0203f1e:	fd379be3          	bne	a5,s3,ffffffffc0203ef4 <do_exit+0x9c>
ffffffffc0203f22:	3ff000ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc0203f26:	b7f9                	j	ffffffffc0203ef4 <do_exit+0x9c>
ffffffffc0203f28:	020a1263          	bnez	s4,ffffffffc0203f4c <do_exit+0xf4>
ffffffffc0203f2c:	4a7000ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc0203f30:	601c                	ld	a5,0(s0)
ffffffffc0203f32:	00006617          	auipc	a2,0x6
ffffffffc0203f36:	8fe60613          	addi	a2,a2,-1794 # ffffffffc0209830 <default_pmm_manager+0x3b8>
ffffffffc0203f3a:	1f900593          	li	a1,505
ffffffffc0203f3e:	43d4                	lw	a3,4(a5)
ffffffffc0203f40:	00006517          	auipc	a0,0x6
ffffffffc0203f44:	8b850513          	addi	a0,a0,-1864 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0203f48:	ac0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203f4c:	ee6fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203f50:	bff1                	j	ffffffffc0203f2c <do_exit+0xd4>
ffffffffc0203f52:	00006617          	auipc	a2,0x6
ffffffffc0203f56:	8be60613          	addi	a2,a2,-1858 # ffffffffc0209810 <default_pmm_manager+0x398>
ffffffffc0203f5a:	1cd00593          	li	a1,461
ffffffffc0203f5e:	00006517          	auipc	a0,0x6
ffffffffc0203f62:	89a50513          	addi	a0,a0,-1894 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0203f66:	aa2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203f6a:	854a                	mv	a0,s2
ffffffffc0203f6c:	eb3fd0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc0203f70:	01893683          	ld	a3,24(s2)
ffffffffc0203f74:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f78:	06f6e363          	bltu	a3,a5,ffffffffc0203fde <do_exit+0x186>
ffffffffc0203f7c:	00015797          	auipc	a5,0x15
ffffffffc0203f80:	5c47b783          	ld	a5,1476(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc0203f84:	8e9d                	sub	a3,a3,a5
ffffffffc0203f86:	82b1                	srli	a3,a3,0xc
ffffffffc0203f88:	00015797          	auipc	a5,0x15
ffffffffc0203f8c:	5507b783          	ld	a5,1360(a5) # ffffffffc02194d8 <npage>
ffffffffc0203f90:	06f6f363          	bgeu	a3,a5,ffffffffc0203ff6 <do_exit+0x19e>
ffffffffc0203f94:	00007517          	auipc	a0,0x7
ffffffffc0203f98:	90453503          	ld	a0,-1788(a0) # ffffffffc020a898 <nbase>
ffffffffc0203f9c:	8e89                	sub	a3,a3,a0
ffffffffc0203f9e:	069a                	slli	a3,a3,0x6
ffffffffc0203fa0:	00015517          	auipc	a0,0x15
ffffffffc0203fa4:	5b053503          	ld	a0,1456(a0) # ffffffffc0219550 <pages>
ffffffffc0203fa8:	9536                	add	a0,a0,a3
ffffffffc0203faa:	4585                	li	a1,1
ffffffffc0203fac:	e31fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203fb0:	854a                	mv	a0,s2
ffffffffc0203fb2:	cd3fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203fb6:	b701                	j	ffffffffc0203eb6 <do_exit+0x5e>
ffffffffc0203fb8:	00006617          	auipc	a2,0x6
ffffffffc0203fbc:	86860613          	addi	a2,a2,-1944 # ffffffffc0209820 <default_pmm_manager+0x3a8>
ffffffffc0203fc0:	1d000593          	li	a1,464
ffffffffc0203fc4:	00006517          	auipc	a0,0x6
ffffffffc0203fc8:	83450513          	addi	a0,a0,-1996 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0203fcc:	a3cfc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203fd0:	e68fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203fd4:	4a05                	li	s4,1
ffffffffc0203fd6:	bdf5                	j	ffffffffc0203ed2 <do_exit+0x7a>
ffffffffc0203fd8:	349000ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc0203fdc:	b721                	j	ffffffffc0203ee4 <do_exit+0x8c>
ffffffffc0203fde:	00005617          	auipc	a2,0x5
ffffffffc0203fe2:	ad260613          	addi	a2,a2,-1326 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0203fe6:	06e00593          	li	a1,110
ffffffffc0203fea:	00005517          	auipc	a0,0x5
ffffffffc0203fee:	a5e50513          	addi	a0,a0,-1442 # ffffffffc0208a48 <commands+0x720>
ffffffffc0203ff2:	a16fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ff6:	00005617          	auipc	a2,0x5
ffffffffc0203ffa:	a3260613          	addi	a2,a2,-1486 # ffffffffc0208a28 <commands+0x700>
ffffffffc0203ffe:	06200593          	li	a1,98
ffffffffc0204002:	00005517          	auipc	a0,0x5
ffffffffc0204006:	a4650513          	addi	a0,a0,-1466 # ffffffffc0208a48 <commands+0x720>
ffffffffc020400a:	9fefc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020400e <do_wait.part.0>:
ffffffffc020400e:	7139                	addi	sp,sp,-64
ffffffffc0204010:	e852                	sd	s4,16(sp)
ffffffffc0204012:	80000a37          	lui	s4,0x80000
ffffffffc0204016:	f426                	sd	s1,40(sp)
ffffffffc0204018:	f04a                	sd	s2,32(sp)
ffffffffc020401a:	ec4e                	sd	s3,24(sp)
ffffffffc020401c:	e456                	sd	s5,8(sp)
ffffffffc020401e:	e05a                	sd	s6,0(sp)
ffffffffc0204020:	fc06                	sd	ra,56(sp)
ffffffffc0204022:	f822                	sd	s0,48(sp)
ffffffffc0204024:	892a                	mv	s2,a0
ffffffffc0204026:	8aae                	mv	s5,a1
ffffffffc0204028:	00015997          	auipc	s3,0x15
ffffffffc020402c:	4d898993          	addi	s3,s3,1240 # ffffffffc0219500 <current>
ffffffffc0204030:	448d                	li	s1,3
ffffffffc0204032:	4b05                	li	s6,1
ffffffffc0204034:	2a05                	addiw	s4,s4,1
ffffffffc0204036:	02090f63          	beqz	s2,ffffffffc0204074 <do_wait.part.0+0x66>
ffffffffc020403a:	854a                	mv	a0,s2
ffffffffc020403c:	9a3ff0ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc0204040:	842a                	mv	s0,a0
ffffffffc0204042:	10050763          	beqz	a0,ffffffffc0204150 <do_wait.part.0+0x142>
ffffffffc0204046:	0009b703          	ld	a4,0(s3)
ffffffffc020404a:	711c                	ld	a5,32(a0)
ffffffffc020404c:	10e79263          	bne	a5,a4,ffffffffc0204150 <do_wait.part.0+0x142>
ffffffffc0204050:	411c                	lw	a5,0(a0)
ffffffffc0204052:	02978c63          	beq	a5,s1,ffffffffc020408a <do_wait.part.0+0x7c>
ffffffffc0204056:	01672023          	sw	s6,0(a4)
ffffffffc020405a:	0f472623          	sw	s4,236(a4)
ffffffffc020405e:	375000ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc0204062:	0009b783          	ld	a5,0(s3)
ffffffffc0204066:	0b07a783          	lw	a5,176(a5)
ffffffffc020406a:	8b85                	andi	a5,a5,1
ffffffffc020406c:	d7e9                	beqz	a5,ffffffffc0204036 <do_wait.part.0+0x28>
ffffffffc020406e:	555d                	li	a0,-9
ffffffffc0204070:	de9ff0ef          	jal	ra,ffffffffc0203e58 <do_exit>
ffffffffc0204074:	0009b703          	ld	a4,0(s3)
ffffffffc0204078:	7b60                	ld	s0,240(a4)
ffffffffc020407a:	e409                	bnez	s0,ffffffffc0204084 <do_wait.part.0+0x76>
ffffffffc020407c:	a8d1                	j	ffffffffc0204150 <do_wait.part.0+0x142>
ffffffffc020407e:	10043403          	ld	s0,256(s0)
ffffffffc0204082:	d871                	beqz	s0,ffffffffc0204056 <do_wait.part.0+0x48>
ffffffffc0204084:	401c                	lw	a5,0(s0)
ffffffffc0204086:	fe979ce3          	bne	a5,s1,ffffffffc020407e <do_wait.part.0+0x70>
ffffffffc020408a:	00015797          	auipc	a5,0x15
ffffffffc020408e:	47e7b783          	ld	a5,1150(a5) # ffffffffc0219508 <idleproc>
ffffffffc0204092:	0c878563          	beq	a5,s0,ffffffffc020415c <do_wait.part.0+0x14e>
ffffffffc0204096:	00015797          	auipc	a5,0x15
ffffffffc020409a:	47a7b783          	ld	a5,1146(a5) # ffffffffc0219510 <initproc>
ffffffffc020409e:	0af40f63          	beq	s0,a5,ffffffffc020415c <do_wait.part.0+0x14e>
ffffffffc02040a2:	000a8663          	beqz	s5,ffffffffc02040ae <do_wait.part.0+0xa0>
ffffffffc02040a6:	0e842783          	lw	a5,232(s0)
ffffffffc02040aa:	00faa023          	sw	a5,0(s5)
ffffffffc02040ae:	100027f3          	csrr	a5,sstatus
ffffffffc02040b2:	8b89                	andi	a5,a5,2
ffffffffc02040b4:	4581                	li	a1,0
ffffffffc02040b6:	efd9                	bnez	a5,ffffffffc0204154 <do_wait.part.0+0x146>
ffffffffc02040b8:	6c70                	ld	a2,216(s0)
ffffffffc02040ba:	7074                	ld	a3,224(s0)
ffffffffc02040bc:	10043703          	ld	a4,256(s0)
ffffffffc02040c0:	7c7c                	ld	a5,248(s0)
ffffffffc02040c2:	e614                	sd	a3,8(a2)
ffffffffc02040c4:	e290                	sd	a2,0(a3)
ffffffffc02040c6:	6470                	ld	a2,200(s0)
ffffffffc02040c8:	6874                	ld	a3,208(s0)
ffffffffc02040ca:	e614                	sd	a3,8(a2)
ffffffffc02040cc:	e290                	sd	a2,0(a3)
ffffffffc02040ce:	c319                	beqz	a4,ffffffffc02040d4 <do_wait.part.0+0xc6>
ffffffffc02040d0:	ff7c                	sd	a5,248(a4)
ffffffffc02040d2:	7c7c                	ld	a5,248(s0)
ffffffffc02040d4:	cbbd                	beqz	a5,ffffffffc020414a <do_wait.part.0+0x13c>
ffffffffc02040d6:	10e7b023          	sd	a4,256(a5)
ffffffffc02040da:	00015717          	auipc	a4,0x15
ffffffffc02040de:	43e70713          	addi	a4,a4,1086 # ffffffffc0219518 <nr_process>
ffffffffc02040e2:	431c                	lw	a5,0(a4)
ffffffffc02040e4:	37fd                	addiw	a5,a5,-1
ffffffffc02040e6:	c31c                	sw	a5,0(a4)
ffffffffc02040e8:	edb1                	bnez	a1,ffffffffc0204144 <do_wait.part.0+0x136>
ffffffffc02040ea:	6814                	ld	a3,16(s0)
ffffffffc02040ec:	c02007b7          	lui	a5,0xc0200
ffffffffc02040f0:	08f6ee63          	bltu	a3,a5,ffffffffc020418c <do_wait.part.0+0x17e>
ffffffffc02040f4:	00015797          	auipc	a5,0x15
ffffffffc02040f8:	44c7b783          	ld	a5,1100(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc02040fc:	8e9d                	sub	a3,a3,a5
ffffffffc02040fe:	82b1                	srli	a3,a3,0xc
ffffffffc0204100:	00015797          	auipc	a5,0x15
ffffffffc0204104:	3d87b783          	ld	a5,984(a5) # ffffffffc02194d8 <npage>
ffffffffc0204108:	06f6f663          	bgeu	a3,a5,ffffffffc0204174 <do_wait.part.0+0x166>
ffffffffc020410c:	00006517          	auipc	a0,0x6
ffffffffc0204110:	78c53503          	ld	a0,1932(a0) # ffffffffc020a898 <nbase>
ffffffffc0204114:	8e89                	sub	a3,a3,a0
ffffffffc0204116:	069a                	slli	a3,a3,0x6
ffffffffc0204118:	00015517          	auipc	a0,0x15
ffffffffc020411c:	43853503          	ld	a0,1080(a0) # ffffffffc0219550 <pages>
ffffffffc0204120:	9536                	add	a0,a0,a3
ffffffffc0204122:	4589                	li	a1,2
ffffffffc0204124:	cb9fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0204128:	8522                	mv	a0,s0
ffffffffc020412a:	9b2fe0ef          	jal	ra,ffffffffc02022dc <kfree>
ffffffffc020412e:	4501                	li	a0,0
ffffffffc0204130:	70e2                	ld	ra,56(sp)
ffffffffc0204132:	7442                	ld	s0,48(sp)
ffffffffc0204134:	74a2                	ld	s1,40(sp)
ffffffffc0204136:	7902                	ld	s2,32(sp)
ffffffffc0204138:	69e2                	ld	s3,24(sp)
ffffffffc020413a:	6a42                	ld	s4,16(sp)
ffffffffc020413c:	6aa2                	ld	s5,8(sp)
ffffffffc020413e:	6b02                	ld	s6,0(sp)
ffffffffc0204140:	6121                	addi	sp,sp,64
ffffffffc0204142:	8082                	ret
ffffffffc0204144:	ceefc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204148:	b74d                	j	ffffffffc02040ea <do_wait.part.0+0xdc>
ffffffffc020414a:	701c                	ld	a5,32(s0)
ffffffffc020414c:	fbf8                	sd	a4,240(a5)
ffffffffc020414e:	b771                	j	ffffffffc02040da <do_wait.part.0+0xcc>
ffffffffc0204150:	5579                	li	a0,-2
ffffffffc0204152:	bff9                	j	ffffffffc0204130 <do_wait.part.0+0x122>
ffffffffc0204154:	ce4fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204158:	4585                	li	a1,1
ffffffffc020415a:	bfb9                	j	ffffffffc02040b8 <do_wait.part.0+0xaa>
ffffffffc020415c:	00005617          	auipc	a2,0x5
ffffffffc0204160:	6f460613          	addi	a2,a2,1780 # ffffffffc0209850 <default_pmm_manager+0x3d8>
ffffffffc0204164:	2f600593          	li	a1,758
ffffffffc0204168:	00005517          	auipc	a0,0x5
ffffffffc020416c:	69050513          	addi	a0,a0,1680 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0204170:	898fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204174:	00005617          	auipc	a2,0x5
ffffffffc0204178:	8b460613          	addi	a2,a2,-1868 # ffffffffc0208a28 <commands+0x700>
ffffffffc020417c:	06200593          	li	a1,98
ffffffffc0204180:	00005517          	auipc	a0,0x5
ffffffffc0204184:	8c850513          	addi	a0,a0,-1848 # ffffffffc0208a48 <commands+0x720>
ffffffffc0204188:	880fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020418c:	00005617          	auipc	a2,0x5
ffffffffc0204190:	92460613          	addi	a2,a2,-1756 # ffffffffc0208ab0 <commands+0x788>
ffffffffc0204194:	06e00593          	li	a1,110
ffffffffc0204198:	00005517          	auipc	a0,0x5
ffffffffc020419c:	8b050513          	addi	a0,a0,-1872 # ffffffffc0208a48 <commands+0x720>
ffffffffc02041a0:	868fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02041a4 <init_main>:
ffffffffc02041a4:	1141                	addi	sp,sp,-16
ffffffffc02041a6:	e406                	sd	ra,8(sp)
ffffffffc02041a8:	c77fc0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc02041ac:	87cfe0ef          	jal	ra,ffffffffc0202228 <kallocated>
ffffffffc02041b0:	95aff0ef          	jal	ra,ffffffffc020330a <check_milk>
ffffffffc02041b4:	a019                	j	ffffffffc02041ba <init_main+0x16>
ffffffffc02041b6:	21d000ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc02041ba:	4581                	li	a1,0
ffffffffc02041bc:	4501                	li	a0,0
ffffffffc02041be:	e51ff0ef          	jal	ra,ffffffffc020400e <do_wait.part.0>
ffffffffc02041c2:	d975                	beqz	a0,ffffffffc02041b6 <init_main+0x12>
ffffffffc02041c4:	00005517          	auipc	a0,0x5
ffffffffc02041c8:	6ac50513          	addi	a0,a0,1708 # ffffffffc0209870 <default_pmm_manager+0x3f8>
ffffffffc02041cc:	f01fb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02041d0:	00015797          	auipc	a5,0x15
ffffffffc02041d4:	3407b783          	ld	a5,832(a5) # ffffffffc0219510 <initproc>
ffffffffc02041d8:	7bf8                	ld	a4,240(a5)
ffffffffc02041da:	e339                	bnez	a4,ffffffffc0204220 <init_main+0x7c>
ffffffffc02041dc:	7ff8                	ld	a4,248(a5)
ffffffffc02041de:	e329                	bnez	a4,ffffffffc0204220 <init_main+0x7c>
ffffffffc02041e0:	1007b703          	ld	a4,256(a5)
ffffffffc02041e4:	ef15                	bnez	a4,ffffffffc0204220 <init_main+0x7c>
ffffffffc02041e6:	00015697          	auipc	a3,0x15
ffffffffc02041ea:	3326a683          	lw	a3,818(a3) # ffffffffc0219518 <nr_process>
ffffffffc02041ee:	4709                	li	a4,2
ffffffffc02041f0:	08e69863          	bne	a3,a4,ffffffffc0204280 <init_main+0xdc>
ffffffffc02041f4:	00015717          	auipc	a4,0x15
ffffffffc02041f8:	4ac70713          	addi	a4,a4,1196 # ffffffffc02196a0 <proc_list>
ffffffffc02041fc:	6714                	ld	a3,8(a4)
ffffffffc02041fe:	0c878793          	addi	a5,a5,200
ffffffffc0204202:	04d79f63          	bne	a5,a3,ffffffffc0204260 <init_main+0xbc>
ffffffffc0204206:	6318                	ld	a4,0(a4)
ffffffffc0204208:	02e79c63          	bne	a5,a4,ffffffffc0204240 <init_main+0x9c>
ffffffffc020420c:	00005517          	auipc	a0,0x5
ffffffffc0204210:	74c50513          	addi	a0,a0,1868 # ffffffffc0209958 <default_pmm_manager+0x4e0>
ffffffffc0204214:	eb9fb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0204218:	60a2                	ld	ra,8(sp)
ffffffffc020421a:	4501                	li	a0,0
ffffffffc020421c:	0141                	addi	sp,sp,16
ffffffffc020421e:	8082                	ret
ffffffffc0204220:	00005697          	auipc	a3,0x5
ffffffffc0204224:	67868693          	addi	a3,a3,1656 # ffffffffc0209898 <default_pmm_manager+0x420>
ffffffffc0204228:	00004617          	auipc	a2,0x4
ffffffffc020422c:	51060613          	addi	a2,a2,1296 # ffffffffc0208738 <commands+0x410>
ffffffffc0204230:	36200593          	li	a1,866
ffffffffc0204234:	00005517          	auipc	a0,0x5
ffffffffc0204238:	5c450513          	addi	a0,a0,1476 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc020423c:	fcdfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204240:	00005697          	auipc	a3,0x5
ffffffffc0204244:	6e868693          	addi	a3,a3,1768 # ffffffffc0209928 <default_pmm_manager+0x4b0>
ffffffffc0204248:	00004617          	auipc	a2,0x4
ffffffffc020424c:	4f060613          	addi	a2,a2,1264 # ffffffffc0208738 <commands+0x410>
ffffffffc0204250:	36500593          	li	a1,869
ffffffffc0204254:	00005517          	auipc	a0,0x5
ffffffffc0204258:	5a450513          	addi	a0,a0,1444 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc020425c:	fadfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204260:	00005697          	auipc	a3,0x5
ffffffffc0204264:	69868693          	addi	a3,a3,1688 # ffffffffc02098f8 <default_pmm_manager+0x480>
ffffffffc0204268:	00004617          	auipc	a2,0x4
ffffffffc020426c:	4d060613          	addi	a2,a2,1232 # ffffffffc0208738 <commands+0x410>
ffffffffc0204270:	36400593          	li	a1,868
ffffffffc0204274:	00005517          	auipc	a0,0x5
ffffffffc0204278:	58450513          	addi	a0,a0,1412 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc020427c:	f8dfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204280:	00005697          	auipc	a3,0x5
ffffffffc0204284:	66868693          	addi	a3,a3,1640 # ffffffffc02098e8 <default_pmm_manager+0x470>
ffffffffc0204288:	00004617          	auipc	a2,0x4
ffffffffc020428c:	4b060613          	addi	a2,a2,1200 # ffffffffc0208738 <commands+0x410>
ffffffffc0204290:	36300593          	li	a1,867
ffffffffc0204294:	00005517          	auipc	a0,0x5
ffffffffc0204298:	56450513          	addi	a0,a0,1380 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc020429c:	f6dfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02042a0 <do_execve>:
ffffffffc02042a0:	7135                	addi	sp,sp,-160
ffffffffc02042a2:	f4d6                	sd	s5,104(sp)
ffffffffc02042a4:	00015a97          	auipc	s5,0x15
ffffffffc02042a8:	25ca8a93          	addi	s5,s5,604 # ffffffffc0219500 <current>
ffffffffc02042ac:	000ab783          	ld	a5,0(s5)
ffffffffc02042b0:	f8d2                	sd	s4,112(sp)
ffffffffc02042b2:	e526                	sd	s1,136(sp)
ffffffffc02042b4:	0287ba03          	ld	s4,40(a5)
ffffffffc02042b8:	e14a                	sd	s2,128(sp)
ffffffffc02042ba:	fcce                	sd	s3,120(sp)
ffffffffc02042bc:	892a                	mv	s2,a0
ffffffffc02042be:	84ae                	mv	s1,a1
ffffffffc02042c0:	89b2                	mv	s3,a2
ffffffffc02042c2:	4681                	li	a3,0
ffffffffc02042c4:	862e                	mv	a2,a1
ffffffffc02042c6:	85aa                	mv	a1,a0
ffffffffc02042c8:	8552                	mv	a0,s4
ffffffffc02042ca:	ed06                	sd	ra,152(sp)
ffffffffc02042cc:	e922                	sd	s0,144(sp)
ffffffffc02042ce:	f0da                	sd	s6,96(sp)
ffffffffc02042d0:	ecde                	sd	s7,88(sp)
ffffffffc02042d2:	e8e2                	sd	s8,80(sp)
ffffffffc02042d4:	e4e6                	sd	s9,72(sp)
ffffffffc02042d6:	e0ea                	sd	s10,64(sp)
ffffffffc02042d8:	fc6e                	sd	s11,56(sp)
ffffffffc02042da:	cbffd0ef          	jal	ra,ffffffffc0201f98 <user_mem_check>
ffffffffc02042de:	46050063          	beqz	a0,ffffffffc020473e <do_execve+0x49e>
ffffffffc02042e2:	4641                	li	a2,16
ffffffffc02042e4:	4581                	li	a1,0
ffffffffc02042e6:	1008                	addi	a0,sp,32
ffffffffc02042e8:	171030ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc02042ec:	47bd                	li	a5,15
ffffffffc02042ee:	8626                	mv	a2,s1
ffffffffc02042f0:	1897ea63          	bltu	a5,s1,ffffffffc0204484 <do_execve+0x1e4>
ffffffffc02042f4:	85ca                	mv	a1,s2
ffffffffc02042f6:	1008                	addi	a0,sp,32
ffffffffc02042f8:	173030ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc02042fc:	180a0b63          	beqz	s4,ffffffffc0204492 <do_execve+0x1f2>
ffffffffc0204300:	00005517          	auipc	a0,0x5
ffffffffc0204304:	b5050513          	addi	a0,a0,-1200 # ffffffffc0208e50 <commands+0xb28>
ffffffffc0204308:	dfdfb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc020430c:	00015797          	auipc	a5,0x15
ffffffffc0204310:	23c7b783          	ld	a5,572(a5) # ffffffffc0219548 <boot_cr3>
ffffffffc0204314:	577d                	li	a4,-1
ffffffffc0204316:	177e                	slli	a4,a4,0x3f
ffffffffc0204318:	83b1                	srli	a5,a5,0xc
ffffffffc020431a:	8fd9                	or	a5,a5,a4
ffffffffc020431c:	18079073          	csrw	satp,a5
ffffffffc0204320:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc0204324:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204328:	02ea2823          	sw	a4,48(s4)
ffffffffc020432c:	2c070163          	beqz	a4,ffffffffc02045ee <do_execve+0x34e>
ffffffffc0204330:	000ab783          	ld	a5,0(s5)
ffffffffc0204334:	0207b423          	sd	zero,40(a5)
ffffffffc0204338:	feefd0ef          	jal	ra,ffffffffc0201b26 <mm_create>
ffffffffc020433c:	84aa                	mv	s1,a0
ffffffffc020433e:	18050263          	beqz	a0,ffffffffc02044c2 <do_execve+0x222>
ffffffffc0204342:	0561                	addi	a0,a0,24
ffffffffc0204344:	d82ff0ef          	jal	ra,ffffffffc02038c6 <setup_pgdir.isra.0>
ffffffffc0204348:	16051663          	bnez	a0,ffffffffc02044b4 <do_execve+0x214>
ffffffffc020434c:	0009a703          	lw	a4,0(s3)
ffffffffc0204350:	464c47b7          	lui	a5,0x464c4
ffffffffc0204354:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204358:	24f71763          	bne	a4,a5,ffffffffc02045a6 <do_execve+0x306>
ffffffffc020435c:	0389d703          	lhu	a4,56(s3)
ffffffffc0204360:	0209b903          	ld	s2,32(s3)
ffffffffc0204364:	00371793          	slli	a5,a4,0x3
ffffffffc0204368:	8f99                	sub	a5,a5,a4
ffffffffc020436a:	994e                	add	s2,s2,s3
ffffffffc020436c:	078e                	slli	a5,a5,0x3
ffffffffc020436e:	97ca                	add	a5,a5,s2
ffffffffc0204370:	ec3e                	sd	a5,24(sp)
ffffffffc0204372:	02f97c63          	bgeu	s2,a5,ffffffffc02043aa <do_execve+0x10a>
ffffffffc0204376:	5bfd                	li	s7,-1
ffffffffc0204378:	00cbd793          	srli	a5,s7,0xc
ffffffffc020437c:	00015d97          	auipc	s11,0x15
ffffffffc0204380:	1d4d8d93          	addi	s11,s11,468 # ffffffffc0219550 <pages>
ffffffffc0204384:	00006d17          	auipc	s10,0x6
ffffffffc0204388:	514d0d13          	addi	s10,s10,1300 # ffffffffc020a898 <nbase>
ffffffffc020438c:	e43e                	sd	a5,8(sp)
ffffffffc020438e:	00015c97          	auipc	s9,0x15
ffffffffc0204392:	14ac8c93          	addi	s9,s9,330 # ffffffffc02194d8 <npage>
ffffffffc0204396:	00092703          	lw	a4,0(s2)
ffffffffc020439a:	4785                	li	a5,1
ffffffffc020439c:	12f70563          	beq	a4,a5,ffffffffc02044c6 <do_execve+0x226>
ffffffffc02043a0:	67e2                	ld	a5,24(sp)
ffffffffc02043a2:	03890913          	addi	s2,s2,56
ffffffffc02043a6:	fef968e3          	bltu	s2,a5,ffffffffc0204396 <do_execve+0xf6>
ffffffffc02043aa:	4701                	li	a4,0
ffffffffc02043ac:	46ad                	li	a3,11
ffffffffc02043ae:	00100637          	lui	a2,0x100
ffffffffc02043b2:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02043b6:	8526                	mv	a0,s1
ffffffffc02043b8:	91dfd0ef          	jal	ra,ffffffffc0201cd4 <mm_map>
ffffffffc02043bc:	8a2a                	mv	s4,a0
ffffffffc02043be:	1e051063          	bnez	a0,ffffffffc020459e <do_execve+0x2fe>
ffffffffc02043c2:	6c88                	ld	a0,24(s1)
ffffffffc02043c4:	467d                	li	a2,31
ffffffffc02043c6:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02043ca:	abcfd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02043ce:	42050e63          	beqz	a0,ffffffffc020480a <do_execve+0x56a>
ffffffffc02043d2:	6c88                	ld	a0,24(s1)
ffffffffc02043d4:	467d                	li	a2,31
ffffffffc02043d6:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02043da:	aacfd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02043de:	40050663          	beqz	a0,ffffffffc02047ea <do_execve+0x54a>
ffffffffc02043e2:	6c88                	ld	a0,24(s1)
ffffffffc02043e4:	467d                	li	a2,31
ffffffffc02043e6:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02043ea:	a9cfd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02043ee:	3c050e63          	beqz	a0,ffffffffc02047ca <do_execve+0x52a>
ffffffffc02043f2:	6c88                	ld	a0,24(s1)
ffffffffc02043f4:	467d                	li	a2,31
ffffffffc02043f6:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02043fa:	a8cfd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02043fe:	3a050663          	beqz	a0,ffffffffc02047aa <do_execve+0x50a>
ffffffffc0204402:	589c                	lw	a5,48(s1)
ffffffffc0204404:	000ab603          	ld	a2,0(s5)
ffffffffc0204408:	6c94                	ld	a3,24(s1)
ffffffffc020440a:	2785                	addiw	a5,a5,1
ffffffffc020440c:	d89c                	sw	a5,48(s1)
ffffffffc020440e:	f604                	sd	s1,40(a2)
ffffffffc0204410:	c02007b7          	lui	a5,0xc0200
ffffffffc0204414:	36f6ef63          	bltu	a3,a5,ffffffffc0204792 <do_execve+0x4f2>
ffffffffc0204418:	00015797          	auipc	a5,0x15
ffffffffc020441c:	1287b783          	ld	a5,296(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc0204420:	8e9d                	sub	a3,a3,a5
ffffffffc0204422:	577d                	li	a4,-1
ffffffffc0204424:	00c6d793          	srli	a5,a3,0xc
ffffffffc0204428:	177e                	slli	a4,a4,0x3f
ffffffffc020442a:	f654                	sd	a3,168(a2)
ffffffffc020442c:	8fd9                	or	a5,a5,a4
ffffffffc020442e:	18079073          	csrw	satp,a5
ffffffffc0204432:	7240                	ld	s0,160(a2)
ffffffffc0204434:	4581                	li	a1,0
ffffffffc0204436:	12000613          	li	a2,288
ffffffffc020443a:	8522                	mv	a0,s0
ffffffffc020443c:	10043483          	ld	s1,256(s0)
ffffffffc0204440:	019030ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0204444:	0189b703          	ld	a4,24(s3)
ffffffffc0204448:	4785                	li	a5,1
ffffffffc020444a:	000ab503          	ld	a0,0(s5)
ffffffffc020444e:	edf4f493          	andi	s1,s1,-289
ffffffffc0204452:	07fe                	slli	a5,a5,0x1f
ffffffffc0204454:	e81c                	sd	a5,16(s0)
ffffffffc0204456:	10e43423          	sd	a4,264(s0)
ffffffffc020445a:	10943023          	sd	s1,256(s0)
ffffffffc020445e:	100c                	addi	a1,sp,32
ffffffffc0204460:	ce8ff0ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc0204464:	60ea                	ld	ra,152(sp)
ffffffffc0204466:	644a                	ld	s0,144(sp)
ffffffffc0204468:	64aa                	ld	s1,136(sp)
ffffffffc020446a:	690a                	ld	s2,128(sp)
ffffffffc020446c:	79e6                	ld	s3,120(sp)
ffffffffc020446e:	7aa6                	ld	s5,104(sp)
ffffffffc0204470:	7b06                	ld	s6,96(sp)
ffffffffc0204472:	6be6                	ld	s7,88(sp)
ffffffffc0204474:	6c46                	ld	s8,80(sp)
ffffffffc0204476:	6ca6                	ld	s9,72(sp)
ffffffffc0204478:	6d06                	ld	s10,64(sp)
ffffffffc020447a:	7de2                	ld	s11,56(sp)
ffffffffc020447c:	8552                	mv	a0,s4
ffffffffc020447e:	7a46                	ld	s4,112(sp)
ffffffffc0204480:	610d                	addi	sp,sp,160
ffffffffc0204482:	8082                	ret
ffffffffc0204484:	463d                	li	a2,15
ffffffffc0204486:	85ca                	mv	a1,s2
ffffffffc0204488:	1008                	addi	a0,sp,32
ffffffffc020448a:	7e0030ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc020448e:	e60a19e3          	bnez	s4,ffffffffc0204300 <do_execve+0x60>
ffffffffc0204492:	000ab783          	ld	a5,0(s5)
ffffffffc0204496:	779c                	ld	a5,40(a5)
ffffffffc0204498:	ea0780e3          	beqz	a5,ffffffffc0204338 <do_execve+0x98>
ffffffffc020449c:	00005617          	auipc	a2,0x5
ffffffffc02044a0:	4dc60613          	addi	a2,a2,1244 # ffffffffc0209978 <default_pmm_manager+0x500>
ffffffffc02044a4:	20300593          	li	a1,515
ffffffffc02044a8:	00005517          	auipc	a0,0x5
ffffffffc02044ac:	35050513          	addi	a0,a0,848 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02044b0:	d59fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02044b4:	8526                	mv	a0,s1
ffffffffc02044b6:	fcefd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc02044ba:	5a71                	li	s4,-4
ffffffffc02044bc:	8552                	mv	a0,s4
ffffffffc02044be:	99bff0ef          	jal	ra,ffffffffc0203e58 <do_exit>
ffffffffc02044c2:	5a71                	li	s4,-4
ffffffffc02044c4:	bfe5                	j	ffffffffc02044bc <do_execve+0x21c>
ffffffffc02044c6:	02893603          	ld	a2,40(s2)
ffffffffc02044ca:	02093783          	ld	a5,32(s2)
ffffffffc02044ce:	26f66c63          	bltu	a2,a5,ffffffffc0204746 <do_execve+0x4a6>
ffffffffc02044d2:	00492783          	lw	a5,4(s2)
ffffffffc02044d6:	0017f693          	andi	a3,a5,1
ffffffffc02044da:	c291                	beqz	a3,ffffffffc02044de <do_execve+0x23e>
ffffffffc02044dc:	4691                	li	a3,4
ffffffffc02044de:	0027f713          	andi	a4,a5,2
ffffffffc02044e2:	8b91                	andi	a5,a5,4
ffffffffc02044e4:	14071c63          	bnez	a4,ffffffffc020463c <do_execve+0x39c>
ffffffffc02044e8:	4745                	li	a4,17
ffffffffc02044ea:	e03a                	sd	a4,0(sp)
ffffffffc02044ec:	c789                	beqz	a5,ffffffffc02044f6 <do_execve+0x256>
ffffffffc02044ee:	47cd                	li	a5,19
ffffffffc02044f0:	0016e693          	ori	a3,a3,1
ffffffffc02044f4:	e03e                	sd	a5,0(sp)
ffffffffc02044f6:	0026f793          	andi	a5,a3,2
ffffffffc02044fa:	14079563          	bnez	a5,ffffffffc0204644 <do_execve+0x3a4>
ffffffffc02044fe:	0046f793          	andi	a5,a3,4
ffffffffc0204502:	c789                	beqz	a5,ffffffffc020450c <do_execve+0x26c>
ffffffffc0204504:	6782                	ld	a5,0(sp)
ffffffffc0204506:	0087e793          	ori	a5,a5,8
ffffffffc020450a:	e03e                	sd	a5,0(sp)
ffffffffc020450c:	01093583          	ld	a1,16(s2)
ffffffffc0204510:	4701                	li	a4,0
ffffffffc0204512:	8526                	mv	a0,s1
ffffffffc0204514:	fc0fd0ef          	jal	ra,ffffffffc0201cd4 <mm_map>
ffffffffc0204518:	8a2a                	mv	s4,a0
ffffffffc020451a:	e151                	bnez	a0,ffffffffc020459e <do_execve+0x2fe>
ffffffffc020451c:	01093c03          	ld	s8,16(s2)
ffffffffc0204520:	02093a03          	ld	s4,32(s2)
ffffffffc0204524:	00893b03          	ld	s6,8(s2)
ffffffffc0204528:	77fd                	lui	a5,0xfffff
ffffffffc020452a:	9a62                	add	s4,s4,s8
ffffffffc020452c:	9b4e                	add	s6,s6,s3
ffffffffc020452e:	00fc7bb3          	and	s7,s8,a5
ffffffffc0204532:	054c6e63          	bltu	s8,s4,ffffffffc020458e <do_execve+0x2ee>
ffffffffc0204536:	a431                	j	ffffffffc0204742 <do_execve+0x4a2>
ffffffffc0204538:	6785                	lui	a5,0x1
ffffffffc020453a:	417c0533          	sub	a0,s8,s7
ffffffffc020453e:	9bbe                	add	s7,s7,a5
ffffffffc0204540:	418b8633          	sub	a2,s7,s8
ffffffffc0204544:	017a7463          	bgeu	s4,s7,ffffffffc020454c <do_execve+0x2ac>
ffffffffc0204548:	418a0633          	sub	a2,s4,s8
ffffffffc020454c:	000db683          	ld	a3,0(s11)
ffffffffc0204550:	000d3803          	ld	a6,0(s10)
ffffffffc0204554:	67a2                	ld	a5,8(sp)
ffffffffc0204556:	40d406b3          	sub	a3,s0,a3
ffffffffc020455a:	8699                	srai	a3,a3,0x6
ffffffffc020455c:	000cb583          	ld	a1,0(s9)
ffffffffc0204560:	96c2                	add	a3,a3,a6
ffffffffc0204562:	00f6f833          	and	a6,a3,a5
ffffffffc0204566:	06b2                	slli	a3,a3,0xc
ffffffffc0204568:	1eb87163          	bgeu	a6,a1,ffffffffc020474a <do_execve+0x4aa>
ffffffffc020456c:	00015797          	auipc	a5,0x15
ffffffffc0204570:	fd478793          	addi	a5,a5,-44 # ffffffffc0219540 <va_pa_offset>
ffffffffc0204574:	0007b803          	ld	a6,0(a5)
ffffffffc0204578:	85da                	mv	a1,s6
ffffffffc020457a:	9c32                	add	s8,s8,a2
ffffffffc020457c:	96c2                	add	a3,a3,a6
ffffffffc020457e:	9536                	add	a0,a0,a3
ffffffffc0204580:	e832                	sd	a2,16(sp)
ffffffffc0204582:	6e8030ef          	jal	ra,ffffffffc0207c6a <memcpy>
ffffffffc0204586:	6642                	ld	a2,16(sp)
ffffffffc0204588:	9b32                	add	s6,s6,a2
ffffffffc020458a:	0d4c7063          	bgeu	s8,s4,ffffffffc020464a <do_execve+0x3aa>
ffffffffc020458e:	6c88                	ld	a0,24(s1)
ffffffffc0204590:	6602                	ld	a2,0(sp)
ffffffffc0204592:	85de                	mv	a1,s7
ffffffffc0204594:	8f2fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0204598:	842a                	mv	s0,a0
ffffffffc020459a:	fd59                	bnez	a0,ffffffffc0204538 <do_execve+0x298>
ffffffffc020459c:	5a71                	li	s4,-4
ffffffffc020459e:	8526                	mv	a0,s1
ffffffffc02045a0:	87ffd0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc02045a4:	a011                	j	ffffffffc02045a8 <do_execve+0x308>
ffffffffc02045a6:	5a61                	li	s4,-8
ffffffffc02045a8:	6c94                	ld	a3,24(s1)
ffffffffc02045aa:	c02007b7          	lui	a5,0xc0200
ffffffffc02045ae:	1af6ea63          	bltu	a3,a5,ffffffffc0204762 <do_execve+0x4c2>
ffffffffc02045b2:	00015517          	auipc	a0,0x15
ffffffffc02045b6:	f8e53503          	ld	a0,-114(a0) # ffffffffc0219540 <va_pa_offset>
ffffffffc02045ba:	8e89                	sub	a3,a3,a0
ffffffffc02045bc:	82b1                	srli	a3,a3,0xc
ffffffffc02045be:	00015797          	auipc	a5,0x15
ffffffffc02045c2:	f1a7b783          	ld	a5,-230(a5) # ffffffffc02194d8 <npage>
ffffffffc02045c6:	1af6fa63          	bgeu	a3,a5,ffffffffc020477a <do_execve+0x4da>
ffffffffc02045ca:	00006517          	auipc	a0,0x6
ffffffffc02045ce:	2ce53503          	ld	a0,718(a0) # ffffffffc020a898 <nbase>
ffffffffc02045d2:	8e89                	sub	a3,a3,a0
ffffffffc02045d4:	069a                	slli	a3,a3,0x6
ffffffffc02045d6:	00015517          	auipc	a0,0x15
ffffffffc02045da:	f7a53503          	ld	a0,-134(a0) # ffffffffc0219550 <pages>
ffffffffc02045de:	9536                	add	a0,a0,a3
ffffffffc02045e0:	4585                	li	a1,1
ffffffffc02045e2:	ffafc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02045e6:	8526                	mv	a0,s1
ffffffffc02045e8:	e9cfd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc02045ec:	bdc1                	j	ffffffffc02044bc <do_execve+0x21c>
ffffffffc02045ee:	8552                	mv	a0,s4
ffffffffc02045f0:	82ffd0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc02045f4:	018a3683          	ld	a3,24(s4)
ffffffffc02045f8:	c02007b7          	lui	a5,0xc0200
ffffffffc02045fc:	16f6e363          	bltu	a3,a5,ffffffffc0204762 <do_execve+0x4c2>
ffffffffc0204600:	00015797          	auipc	a5,0x15
ffffffffc0204604:	f407b783          	ld	a5,-192(a5) # ffffffffc0219540 <va_pa_offset>
ffffffffc0204608:	8e9d                	sub	a3,a3,a5
ffffffffc020460a:	82b1                	srli	a3,a3,0xc
ffffffffc020460c:	00015797          	auipc	a5,0x15
ffffffffc0204610:	ecc7b783          	ld	a5,-308(a5) # ffffffffc02194d8 <npage>
ffffffffc0204614:	16f6f363          	bgeu	a3,a5,ffffffffc020477a <do_execve+0x4da>
ffffffffc0204618:	00006517          	auipc	a0,0x6
ffffffffc020461c:	28053503          	ld	a0,640(a0) # ffffffffc020a898 <nbase>
ffffffffc0204620:	8e89                	sub	a3,a3,a0
ffffffffc0204622:	069a                	slli	a3,a3,0x6
ffffffffc0204624:	00015517          	auipc	a0,0x15
ffffffffc0204628:	f2c53503          	ld	a0,-212(a0) # ffffffffc0219550 <pages>
ffffffffc020462c:	9536                	add	a0,a0,a3
ffffffffc020462e:	4585                	li	a1,1
ffffffffc0204630:	facfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0204634:	8552                	mv	a0,s4
ffffffffc0204636:	e4efd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc020463a:	b9dd                	j	ffffffffc0204330 <do_execve+0x90>
ffffffffc020463c:	0026e693          	ori	a3,a3,2
ffffffffc0204640:	ea0797e3          	bnez	a5,ffffffffc02044ee <do_execve+0x24e>
ffffffffc0204644:	47dd                	li	a5,23
ffffffffc0204646:	e03e                	sd	a5,0(sp)
ffffffffc0204648:	bd5d                	j	ffffffffc02044fe <do_execve+0x25e>
ffffffffc020464a:	01093a03          	ld	s4,16(s2)
ffffffffc020464e:	02893683          	ld	a3,40(s2)
ffffffffc0204652:	9a36                	add	s4,s4,a3
ffffffffc0204654:	077c7f63          	bgeu	s8,s7,ffffffffc02046d2 <do_execve+0x432>
ffffffffc0204658:	d58a04e3          	beq	s4,s8,ffffffffc02043a0 <do_execve+0x100>
ffffffffc020465c:	6505                	lui	a0,0x1
ffffffffc020465e:	9562                	add	a0,a0,s8
ffffffffc0204660:	41750533          	sub	a0,a0,s7
ffffffffc0204664:	418a0b33          	sub	s6,s4,s8
ffffffffc0204668:	0d7a7863          	bgeu	s4,s7,ffffffffc0204738 <do_execve+0x498>
ffffffffc020466c:	000db683          	ld	a3,0(s11)
ffffffffc0204670:	000d3583          	ld	a1,0(s10)
ffffffffc0204674:	67a2                	ld	a5,8(sp)
ffffffffc0204676:	40d406b3          	sub	a3,s0,a3
ffffffffc020467a:	8699                	srai	a3,a3,0x6
ffffffffc020467c:	000cb603          	ld	a2,0(s9)
ffffffffc0204680:	96ae                	add	a3,a3,a1
ffffffffc0204682:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204686:	06b2                	slli	a3,a3,0xc
ffffffffc0204688:	0cc5f163          	bgeu	a1,a2,ffffffffc020474a <do_execve+0x4aa>
ffffffffc020468c:	00015617          	auipc	a2,0x15
ffffffffc0204690:	eb463603          	ld	a2,-332(a2) # ffffffffc0219540 <va_pa_offset>
ffffffffc0204694:	96b2                	add	a3,a3,a2
ffffffffc0204696:	4581                	li	a1,0
ffffffffc0204698:	865a                	mv	a2,s6
ffffffffc020469a:	9536                	add	a0,a0,a3
ffffffffc020469c:	5bc030ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc02046a0:	018b0733          	add	a4,s6,s8
ffffffffc02046a4:	037a7463          	bgeu	s4,s7,ffffffffc02046cc <do_execve+0x42c>
ffffffffc02046a8:	ceea0ce3          	beq	s4,a4,ffffffffc02043a0 <do_execve+0x100>
ffffffffc02046ac:	00005697          	auipc	a3,0x5
ffffffffc02046b0:	2f468693          	addi	a3,a3,756 # ffffffffc02099a0 <default_pmm_manager+0x528>
ffffffffc02046b4:	00004617          	auipc	a2,0x4
ffffffffc02046b8:	08460613          	addi	a2,a2,132 # ffffffffc0208738 <commands+0x410>
ffffffffc02046bc:	25800593          	li	a1,600
ffffffffc02046c0:	00005517          	auipc	a0,0x5
ffffffffc02046c4:	13850513          	addi	a0,a0,312 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02046c8:	b41fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046cc:	ff7710e3          	bne	a4,s7,ffffffffc02046ac <do_execve+0x40c>
ffffffffc02046d0:	8c5e                	mv	s8,s7
ffffffffc02046d2:	00015b17          	auipc	s6,0x15
ffffffffc02046d6:	e6eb0b13          	addi	s6,s6,-402 # ffffffffc0219540 <va_pa_offset>
ffffffffc02046da:	054c6763          	bltu	s8,s4,ffffffffc0204728 <do_execve+0x488>
ffffffffc02046de:	b1c9                	j	ffffffffc02043a0 <do_execve+0x100>
ffffffffc02046e0:	6785                	lui	a5,0x1
ffffffffc02046e2:	417c0533          	sub	a0,s8,s7
ffffffffc02046e6:	9bbe                	add	s7,s7,a5
ffffffffc02046e8:	418b8633          	sub	a2,s7,s8
ffffffffc02046ec:	017a7463          	bgeu	s4,s7,ffffffffc02046f4 <do_execve+0x454>
ffffffffc02046f0:	418a0633          	sub	a2,s4,s8
ffffffffc02046f4:	000db683          	ld	a3,0(s11)
ffffffffc02046f8:	000d3803          	ld	a6,0(s10)
ffffffffc02046fc:	67a2                	ld	a5,8(sp)
ffffffffc02046fe:	40d406b3          	sub	a3,s0,a3
ffffffffc0204702:	8699                	srai	a3,a3,0x6
ffffffffc0204704:	000cb583          	ld	a1,0(s9)
ffffffffc0204708:	96c2                	add	a3,a3,a6
ffffffffc020470a:	00f6f833          	and	a6,a3,a5
ffffffffc020470e:	06b2                	slli	a3,a3,0xc
ffffffffc0204710:	02b87d63          	bgeu	a6,a1,ffffffffc020474a <do_execve+0x4aa>
ffffffffc0204714:	000b3803          	ld	a6,0(s6)
ffffffffc0204718:	9c32                	add	s8,s8,a2
ffffffffc020471a:	4581                	li	a1,0
ffffffffc020471c:	96c2                	add	a3,a3,a6
ffffffffc020471e:	9536                	add	a0,a0,a3
ffffffffc0204720:	538030ef          	jal	ra,ffffffffc0207c58 <memset>
ffffffffc0204724:	c74c7ee3          	bgeu	s8,s4,ffffffffc02043a0 <do_execve+0x100>
ffffffffc0204728:	6c88                	ld	a0,24(s1)
ffffffffc020472a:	6602                	ld	a2,0(sp)
ffffffffc020472c:	85de                	mv	a1,s7
ffffffffc020472e:	f59fc0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0204732:	842a                	mv	s0,a0
ffffffffc0204734:	f555                	bnez	a0,ffffffffc02046e0 <do_execve+0x440>
ffffffffc0204736:	b59d                	j	ffffffffc020459c <do_execve+0x2fc>
ffffffffc0204738:	418b8b33          	sub	s6,s7,s8
ffffffffc020473c:	bf05                	j	ffffffffc020466c <do_execve+0x3cc>
ffffffffc020473e:	5a75                	li	s4,-3
ffffffffc0204740:	b315                	j	ffffffffc0204464 <do_execve+0x1c4>
ffffffffc0204742:	8a62                	mv	s4,s8
ffffffffc0204744:	b729                	j	ffffffffc020464e <do_execve+0x3ae>
ffffffffc0204746:	5a61                	li	s4,-8
ffffffffc0204748:	bd99                	j	ffffffffc020459e <do_execve+0x2fe>
ffffffffc020474a:	00004617          	auipc	a2,0x4
ffffffffc020474e:	39e60613          	addi	a2,a2,926 # ffffffffc0208ae8 <commands+0x7c0>
ffffffffc0204752:	06900593          	li	a1,105
ffffffffc0204756:	00004517          	auipc	a0,0x4
ffffffffc020475a:	2f250513          	addi	a0,a0,754 # ffffffffc0208a48 <commands+0x720>
ffffffffc020475e:	aabfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204762:	00004617          	auipc	a2,0x4
ffffffffc0204766:	34e60613          	addi	a2,a2,846 # ffffffffc0208ab0 <commands+0x788>
ffffffffc020476a:	06e00593          	li	a1,110
ffffffffc020476e:	00004517          	auipc	a0,0x4
ffffffffc0204772:	2da50513          	addi	a0,a0,730 # ffffffffc0208a48 <commands+0x720>
ffffffffc0204776:	a93fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020477a:	00004617          	auipc	a2,0x4
ffffffffc020477e:	2ae60613          	addi	a2,a2,686 # ffffffffc0208a28 <commands+0x700>
ffffffffc0204782:	06200593          	li	a1,98
ffffffffc0204786:	00004517          	auipc	a0,0x4
ffffffffc020478a:	2c250513          	addi	a0,a0,706 # ffffffffc0208a48 <commands+0x720>
ffffffffc020478e:	a7bfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204792:	00004617          	auipc	a2,0x4
ffffffffc0204796:	31e60613          	addi	a2,a2,798 # ffffffffc0208ab0 <commands+0x788>
ffffffffc020479a:	27300593          	li	a1,627
ffffffffc020479e:	00005517          	auipc	a0,0x5
ffffffffc02047a2:	05a50513          	addi	a0,a0,90 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02047a6:	a63fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02047aa:	00005697          	auipc	a3,0x5
ffffffffc02047ae:	30e68693          	addi	a3,a3,782 # ffffffffc0209ab8 <default_pmm_manager+0x640>
ffffffffc02047b2:	00004617          	auipc	a2,0x4
ffffffffc02047b6:	f8660613          	addi	a2,a2,-122 # ffffffffc0208738 <commands+0x410>
ffffffffc02047ba:	26e00593          	li	a1,622
ffffffffc02047be:	00005517          	auipc	a0,0x5
ffffffffc02047c2:	03a50513          	addi	a0,a0,58 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02047c6:	a43fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02047ca:	00005697          	auipc	a3,0x5
ffffffffc02047ce:	2a668693          	addi	a3,a3,678 # ffffffffc0209a70 <default_pmm_manager+0x5f8>
ffffffffc02047d2:	00004617          	auipc	a2,0x4
ffffffffc02047d6:	f6660613          	addi	a2,a2,-154 # ffffffffc0208738 <commands+0x410>
ffffffffc02047da:	26d00593          	li	a1,621
ffffffffc02047de:	00005517          	auipc	a0,0x5
ffffffffc02047e2:	01a50513          	addi	a0,a0,26 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02047e6:	a23fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02047ea:	00005697          	auipc	a3,0x5
ffffffffc02047ee:	23e68693          	addi	a3,a3,574 # ffffffffc0209a28 <default_pmm_manager+0x5b0>
ffffffffc02047f2:	00004617          	auipc	a2,0x4
ffffffffc02047f6:	f4660613          	addi	a2,a2,-186 # ffffffffc0208738 <commands+0x410>
ffffffffc02047fa:	26c00593          	li	a1,620
ffffffffc02047fe:	00005517          	auipc	a0,0x5
ffffffffc0204802:	ffa50513          	addi	a0,a0,-6 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0204806:	a03fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020480a:	00005697          	auipc	a3,0x5
ffffffffc020480e:	1d668693          	addi	a3,a3,470 # ffffffffc02099e0 <default_pmm_manager+0x568>
ffffffffc0204812:	00004617          	auipc	a2,0x4
ffffffffc0204816:	f2660613          	addi	a2,a2,-218 # ffffffffc0208738 <commands+0x410>
ffffffffc020481a:	26b00593          	li	a1,619
ffffffffc020481e:	00005517          	auipc	a0,0x5
ffffffffc0204822:	fda50513          	addi	a0,a0,-38 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc0204826:	9e3fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020482a <do_yield>:
ffffffffc020482a:	00015797          	auipc	a5,0x15
ffffffffc020482e:	cd67b783          	ld	a5,-810(a5) # ffffffffc0219500 <current>
ffffffffc0204832:	4705                	li	a4,1
ffffffffc0204834:	ef98                	sd	a4,24(a5)
ffffffffc0204836:	4501                	li	a0,0
ffffffffc0204838:	8082                	ret

ffffffffc020483a <do_wait>:
ffffffffc020483a:	1101                	addi	sp,sp,-32
ffffffffc020483c:	e822                	sd	s0,16(sp)
ffffffffc020483e:	e426                	sd	s1,8(sp)
ffffffffc0204840:	ec06                	sd	ra,24(sp)
ffffffffc0204842:	842e                	mv	s0,a1
ffffffffc0204844:	84aa                	mv	s1,a0
ffffffffc0204846:	c999                	beqz	a1,ffffffffc020485c <do_wait+0x22>
ffffffffc0204848:	00015797          	auipc	a5,0x15
ffffffffc020484c:	cb87b783          	ld	a5,-840(a5) # ffffffffc0219500 <current>
ffffffffc0204850:	7788                	ld	a0,40(a5)
ffffffffc0204852:	4685                	li	a3,1
ffffffffc0204854:	4611                	li	a2,4
ffffffffc0204856:	f42fd0ef          	jal	ra,ffffffffc0201f98 <user_mem_check>
ffffffffc020485a:	c909                	beqz	a0,ffffffffc020486c <do_wait+0x32>
ffffffffc020485c:	85a2                	mv	a1,s0
ffffffffc020485e:	6442                	ld	s0,16(sp)
ffffffffc0204860:	60e2                	ld	ra,24(sp)
ffffffffc0204862:	8526                	mv	a0,s1
ffffffffc0204864:	64a2                	ld	s1,8(sp)
ffffffffc0204866:	6105                	addi	sp,sp,32
ffffffffc0204868:	fa6ff06f          	j	ffffffffc020400e <do_wait.part.0>
ffffffffc020486c:	60e2                	ld	ra,24(sp)
ffffffffc020486e:	6442                	ld	s0,16(sp)
ffffffffc0204870:	64a2                	ld	s1,8(sp)
ffffffffc0204872:	5575                	li	a0,-3
ffffffffc0204874:	6105                	addi	sp,sp,32
ffffffffc0204876:	8082                	ret

ffffffffc0204878 <do_kill>:
ffffffffc0204878:	1141                	addi	sp,sp,-16
ffffffffc020487a:	e406                	sd	ra,8(sp)
ffffffffc020487c:	e022                	sd	s0,0(sp)
ffffffffc020487e:	960ff0ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc0204882:	cd0d                	beqz	a0,ffffffffc02048bc <do_kill+0x44>
ffffffffc0204884:	0b052703          	lw	a4,176(a0)
ffffffffc0204888:	00177693          	andi	a3,a4,1
ffffffffc020488c:	e695                	bnez	a3,ffffffffc02048b8 <do_kill+0x40>
ffffffffc020488e:	0ec52683          	lw	a3,236(a0)
ffffffffc0204892:	00176713          	ori	a4,a4,1
ffffffffc0204896:	0ae52823          	sw	a4,176(a0)
ffffffffc020489a:	4401                	li	s0,0
ffffffffc020489c:	0006c763          	bltz	a3,ffffffffc02048aa <do_kill+0x32>
ffffffffc02048a0:	60a2                	ld	ra,8(sp)
ffffffffc02048a2:	8522                	mv	a0,s0
ffffffffc02048a4:	6402                	ld	s0,0(sp)
ffffffffc02048a6:	0141                	addi	sp,sp,16
ffffffffc02048a8:	8082                	ret
ffffffffc02048aa:	276000ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc02048ae:	60a2                	ld	ra,8(sp)
ffffffffc02048b0:	8522                	mv	a0,s0
ffffffffc02048b2:	6402                	ld	s0,0(sp)
ffffffffc02048b4:	0141                	addi	sp,sp,16
ffffffffc02048b6:	8082                	ret
ffffffffc02048b8:	545d                	li	s0,-9
ffffffffc02048ba:	b7dd                	j	ffffffffc02048a0 <do_kill+0x28>
ffffffffc02048bc:	5475                	li	s0,-3
ffffffffc02048be:	b7cd                	j	ffffffffc02048a0 <do_kill+0x28>

ffffffffc02048c0 <proc_init>:
ffffffffc02048c0:	1101                	addi	sp,sp,-32
ffffffffc02048c2:	00015797          	auipc	a5,0x15
ffffffffc02048c6:	dde78793          	addi	a5,a5,-546 # ffffffffc02196a0 <proc_list>
ffffffffc02048ca:	ec06                	sd	ra,24(sp)
ffffffffc02048cc:	e822                	sd	s0,16(sp)
ffffffffc02048ce:	e426                	sd	s1,8(sp)
ffffffffc02048d0:	e04a                	sd	s2,0(sp)
ffffffffc02048d2:	e79c                	sd	a5,8(a5)
ffffffffc02048d4:	e39c                	sd	a5,0(a5)
ffffffffc02048d6:	00015717          	auipc	a4,0x15
ffffffffc02048da:	bc270713          	addi	a4,a4,-1086 # ffffffffc0219498 <__rq>
ffffffffc02048de:	00011797          	auipc	a5,0x11
ffffffffc02048e2:	bba78793          	addi	a5,a5,-1094 # ffffffffc0215498 <hash_list>
ffffffffc02048e6:	e79c                	sd	a5,8(a5)
ffffffffc02048e8:	e39c                	sd	a5,0(a5)
ffffffffc02048ea:	07c1                	addi	a5,a5,16
ffffffffc02048ec:	fef71de3          	bne	a4,a5,ffffffffc02048e6 <proc_init+0x26>
ffffffffc02048f0:	f57fe0ef          	jal	ra,ffffffffc0203846 <alloc_proc>
ffffffffc02048f4:	00015417          	auipc	s0,0x15
ffffffffc02048f8:	c1440413          	addi	s0,s0,-1004 # ffffffffc0219508 <idleproc>
ffffffffc02048fc:	e008                	sd	a0,0(s0)
ffffffffc02048fe:	c541                	beqz	a0,ffffffffc0204986 <proc_init+0xc6>
ffffffffc0204900:	4709                	li	a4,2
ffffffffc0204902:	e118                	sd	a4,0(a0)
ffffffffc0204904:	4485                	li	s1,1
ffffffffc0204906:	00006717          	auipc	a4,0x6
ffffffffc020490a:	6fa70713          	addi	a4,a4,1786 # ffffffffc020b000 <bootstack>
ffffffffc020490e:	00005597          	auipc	a1,0x5
ffffffffc0204912:	20a58593          	addi	a1,a1,522 # ffffffffc0209b18 <default_pmm_manager+0x6a0>
ffffffffc0204916:	e918                	sd	a4,16(a0)
ffffffffc0204918:	ed04                	sd	s1,24(a0)
ffffffffc020491a:	82eff0ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc020491e:	00015717          	auipc	a4,0x15
ffffffffc0204922:	bfa70713          	addi	a4,a4,-1030 # ffffffffc0219518 <nr_process>
ffffffffc0204926:	431c                	lw	a5,0(a4)
ffffffffc0204928:	6014                	ld	a3,0(s0)
ffffffffc020492a:	4601                	li	a2,0
ffffffffc020492c:	2785                	addiw	a5,a5,1
ffffffffc020492e:	4581                	li	a1,0
ffffffffc0204930:	00000517          	auipc	a0,0x0
ffffffffc0204934:	87450513          	addi	a0,a0,-1932 # ffffffffc02041a4 <init_main>
ffffffffc0204938:	c31c                	sw	a5,0(a4)
ffffffffc020493a:	00015797          	auipc	a5,0x15
ffffffffc020493e:	bcd7b323          	sd	a3,-1082(a5) # ffffffffc0219500 <current>
ffffffffc0204942:	cc6ff0ef          	jal	ra,ffffffffc0203e08 <kernel_thread>
ffffffffc0204946:	08a05c63          	blez	a0,ffffffffc02049de <proc_init+0x11e>
ffffffffc020494a:	894ff0ef          	jal	ra,ffffffffc02039de <find_proc>
ffffffffc020494e:	00015917          	auipc	s2,0x15
ffffffffc0204952:	bc290913          	addi	s2,s2,-1086 # ffffffffc0219510 <initproc>
ffffffffc0204956:	00005597          	auipc	a1,0x5
ffffffffc020495a:	1ea58593          	addi	a1,a1,490 # ffffffffc0209b40 <default_pmm_manager+0x6c8>
ffffffffc020495e:	00a93023          	sd	a0,0(s2)
ffffffffc0204962:	fe7fe0ef          	jal	ra,ffffffffc0203948 <set_proc_name>
ffffffffc0204966:	601c                	ld	a5,0(s0)
ffffffffc0204968:	cbb9                	beqz	a5,ffffffffc02049be <proc_init+0xfe>
ffffffffc020496a:	43dc                	lw	a5,4(a5)
ffffffffc020496c:	eba9                	bnez	a5,ffffffffc02049be <proc_init+0xfe>
ffffffffc020496e:	00093783          	ld	a5,0(s2)
ffffffffc0204972:	c795                	beqz	a5,ffffffffc020499e <proc_init+0xde>
ffffffffc0204974:	43dc                	lw	a5,4(a5)
ffffffffc0204976:	02979463          	bne	a5,s1,ffffffffc020499e <proc_init+0xde>
ffffffffc020497a:	60e2                	ld	ra,24(sp)
ffffffffc020497c:	6442                	ld	s0,16(sp)
ffffffffc020497e:	64a2                	ld	s1,8(sp)
ffffffffc0204980:	6902                	ld	s2,0(sp)
ffffffffc0204982:	6105                	addi	sp,sp,32
ffffffffc0204984:	8082                	ret
ffffffffc0204986:	00005617          	auipc	a2,0x5
ffffffffc020498a:	17a60613          	addi	a2,a2,378 # ffffffffc0209b00 <default_pmm_manager+0x688>
ffffffffc020498e:	37700593          	li	a1,887
ffffffffc0204992:	00005517          	auipc	a0,0x5
ffffffffc0204996:	e6650513          	addi	a0,a0,-410 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc020499a:	86ffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020499e:	00005697          	auipc	a3,0x5
ffffffffc02049a2:	1d268693          	addi	a3,a3,466 # ffffffffc0209b70 <default_pmm_manager+0x6f8>
ffffffffc02049a6:	00004617          	auipc	a2,0x4
ffffffffc02049aa:	d9260613          	addi	a2,a2,-622 # ffffffffc0208738 <commands+0x410>
ffffffffc02049ae:	38c00593          	li	a1,908
ffffffffc02049b2:	00005517          	auipc	a0,0x5
ffffffffc02049b6:	e4650513          	addi	a0,a0,-442 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02049ba:	84ffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02049be:	00005697          	auipc	a3,0x5
ffffffffc02049c2:	18a68693          	addi	a3,a3,394 # ffffffffc0209b48 <default_pmm_manager+0x6d0>
ffffffffc02049c6:	00004617          	auipc	a2,0x4
ffffffffc02049ca:	d7260613          	addi	a2,a2,-654 # ffffffffc0208738 <commands+0x410>
ffffffffc02049ce:	38b00593          	li	a1,907
ffffffffc02049d2:	00005517          	auipc	a0,0x5
ffffffffc02049d6:	e2650513          	addi	a0,a0,-474 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02049da:	82ffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02049de:	00005617          	auipc	a2,0x5
ffffffffc02049e2:	14260613          	addi	a2,a2,322 # ffffffffc0209b20 <default_pmm_manager+0x6a8>
ffffffffc02049e6:	38500593          	li	a1,901
ffffffffc02049ea:	00005517          	auipc	a0,0x5
ffffffffc02049ee:	e0e50513          	addi	a0,a0,-498 # ffffffffc02097f8 <default_pmm_manager+0x380>
ffffffffc02049f2:	817fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02049f6 <cpu_idle>:
ffffffffc02049f6:	1141                	addi	sp,sp,-16
ffffffffc02049f8:	e022                	sd	s0,0(sp)
ffffffffc02049fa:	e406                	sd	ra,8(sp)
ffffffffc02049fc:	00015417          	auipc	s0,0x15
ffffffffc0204a00:	b0440413          	addi	s0,s0,-1276 # ffffffffc0219500 <current>
ffffffffc0204a04:	6018                	ld	a4,0(s0)
ffffffffc0204a06:	6f1c                	ld	a5,24(a4)
ffffffffc0204a08:	dffd                	beqz	a5,ffffffffc0204a06 <cpu_idle+0x10>
ffffffffc0204a0a:	1c8000ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc0204a0e:	bfdd                	j	ffffffffc0204a04 <cpu_idle+0xe>

ffffffffc0204a10 <lab6_set_priority>:
ffffffffc0204a10:	1141                	addi	sp,sp,-16
ffffffffc0204a12:	e022                	sd	s0,0(sp)
ffffffffc0204a14:	85aa                	mv	a1,a0
ffffffffc0204a16:	842a                	mv	s0,a0
ffffffffc0204a18:	00005517          	auipc	a0,0x5
ffffffffc0204a1c:	18050513          	addi	a0,a0,384 # ffffffffc0209b98 <default_pmm_manager+0x720>
ffffffffc0204a20:	e406                	sd	ra,8(sp)
ffffffffc0204a22:	eaafb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0204a26:	00015797          	auipc	a5,0x15
ffffffffc0204a2a:	ada7b783          	ld	a5,-1318(a5) # ffffffffc0219500 <current>
ffffffffc0204a2e:	e801                	bnez	s0,ffffffffc0204a3e <lab6_set_priority+0x2e>
ffffffffc0204a30:	60a2                	ld	ra,8(sp)
ffffffffc0204a32:	6402                	ld	s0,0(sp)
ffffffffc0204a34:	4705                	li	a4,1
ffffffffc0204a36:	14e7a223          	sw	a4,324(a5)
ffffffffc0204a3a:	0141                	addi	sp,sp,16
ffffffffc0204a3c:	8082                	ret
ffffffffc0204a3e:	60a2                	ld	ra,8(sp)
ffffffffc0204a40:	1487a223          	sw	s0,324(a5)
ffffffffc0204a44:	6402                	ld	s0,0(sp)
ffffffffc0204a46:	0141                	addi	sp,sp,16
ffffffffc0204a48:	8082                	ret

ffffffffc0204a4a <do_sleep>:
ffffffffc0204a4a:	c539                	beqz	a0,ffffffffc0204a98 <do_sleep+0x4e>
ffffffffc0204a4c:	7179                	addi	sp,sp,-48
ffffffffc0204a4e:	f022                	sd	s0,32(sp)
ffffffffc0204a50:	f406                	sd	ra,40(sp)
ffffffffc0204a52:	842a                	mv	s0,a0
ffffffffc0204a54:	100027f3          	csrr	a5,sstatus
ffffffffc0204a58:	8b89                	andi	a5,a5,2
ffffffffc0204a5a:	e3a9                	bnez	a5,ffffffffc0204a9c <do_sleep+0x52>
ffffffffc0204a5c:	00015797          	auipc	a5,0x15
ffffffffc0204a60:	aa47b783          	ld	a5,-1372(a5) # ffffffffc0219500 <current>
ffffffffc0204a64:	0818                	addi	a4,sp,16
ffffffffc0204a66:	c02a                	sw	a0,0(sp)
ffffffffc0204a68:	ec3a                	sd	a4,24(sp)
ffffffffc0204a6a:	e83a                	sd	a4,16(sp)
ffffffffc0204a6c:	e43e                	sd	a5,8(sp)
ffffffffc0204a6e:	4705                	li	a4,1
ffffffffc0204a70:	c398                	sw	a4,0(a5)
ffffffffc0204a72:	80000737          	lui	a4,0x80000
ffffffffc0204a76:	840a                	mv	s0,sp
ffffffffc0204a78:	2709                	addiw	a4,a4,2
ffffffffc0204a7a:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204a7e:	8522                	mv	a0,s0
ffffffffc0204a80:	218000ef          	jal	ra,ffffffffc0204c98 <add_timer>
ffffffffc0204a84:	14e000ef          	jal	ra,ffffffffc0204bd2 <schedule>
ffffffffc0204a88:	8522                	mv	a0,s0
ffffffffc0204a8a:	2d6000ef          	jal	ra,ffffffffc0204d60 <del_timer>
ffffffffc0204a8e:	70a2                	ld	ra,40(sp)
ffffffffc0204a90:	7402                	ld	s0,32(sp)
ffffffffc0204a92:	4501                	li	a0,0
ffffffffc0204a94:	6145                	addi	sp,sp,48
ffffffffc0204a96:	8082                	ret
ffffffffc0204a98:	4501                	li	a0,0
ffffffffc0204a9a:	8082                	ret
ffffffffc0204a9c:	b9dfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204aa0:	00015797          	auipc	a5,0x15
ffffffffc0204aa4:	a607b783          	ld	a5,-1440(a5) # ffffffffc0219500 <current>
ffffffffc0204aa8:	0818                	addi	a4,sp,16
ffffffffc0204aaa:	c022                	sw	s0,0(sp)
ffffffffc0204aac:	e43e                	sd	a5,8(sp)
ffffffffc0204aae:	ec3a                	sd	a4,24(sp)
ffffffffc0204ab0:	e83a                	sd	a4,16(sp)
ffffffffc0204ab2:	4705                	li	a4,1
ffffffffc0204ab4:	c398                	sw	a4,0(a5)
ffffffffc0204ab6:	80000737          	lui	a4,0x80000
ffffffffc0204aba:	2709                	addiw	a4,a4,2
ffffffffc0204abc:	840a                	mv	s0,sp
ffffffffc0204abe:	8522                	mv	a0,s0
ffffffffc0204ac0:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204ac4:	1d4000ef          	jal	ra,ffffffffc0204c98 <add_timer>
ffffffffc0204ac8:	b6bfb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204acc:	bf65                	j	ffffffffc0204a84 <do_sleep+0x3a>

ffffffffc0204ace <sched_init>:
ffffffffc0204ace:	1141                	addi	sp,sp,-16
ffffffffc0204ad0:	00009717          	auipc	a4,0x9
ffffffffc0204ad4:	58070713          	addi	a4,a4,1408 # ffffffffc020e050 <default_sched_class>
ffffffffc0204ad8:	e022                	sd	s0,0(sp)
ffffffffc0204ada:	e406                	sd	ra,8(sp)
ffffffffc0204adc:	00015797          	auipc	a5,0x15
ffffffffc0204ae0:	9dc78793          	addi	a5,a5,-1572 # ffffffffc02194b8 <timer_list>
ffffffffc0204ae4:	6714                	ld	a3,8(a4)
ffffffffc0204ae6:	00015517          	auipc	a0,0x15
ffffffffc0204aea:	9b250513          	addi	a0,a0,-1614 # ffffffffc0219498 <__rq>
ffffffffc0204aee:	e79c                	sd	a5,8(a5)
ffffffffc0204af0:	e39c                	sd	a5,0(a5)
ffffffffc0204af2:	4795                	li	a5,5
ffffffffc0204af4:	c95c                	sw	a5,20(a0)
ffffffffc0204af6:	00015417          	auipc	s0,0x15
ffffffffc0204afa:	a3240413          	addi	s0,s0,-1486 # ffffffffc0219528 <sched_class>
ffffffffc0204afe:	00015797          	auipc	a5,0x15
ffffffffc0204b02:	a2a7b123          	sd	a0,-1502(a5) # ffffffffc0219520 <rq>
ffffffffc0204b06:	e018                	sd	a4,0(s0)
ffffffffc0204b08:	9682                	jalr	a3
ffffffffc0204b0a:	601c                	ld	a5,0(s0)
ffffffffc0204b0c:	6402                	ld	s0,0(sp)
ffffffffc0204b0e:	60a2                	ld	ra,8(sp)
ffffffffc0204b10:	638c                	ld	a1,0(a5)
ffffffffc0204b12:	00005517          	auipc	a0,0x5
ffffffffc0204b16:	09e50513          	addi	a0,a0,158 # ffffffffc0209bb0 <default_pmm_manager+0x738>
ffffffffc0204b1a:	0141                	addi	sp,sp,16
ffffffffc0204b1c:	db0fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0204b20 <wakeup_proc>:
ffffffffc0204b20:	4118                	lw	a4,0(a0)
ffffffffc0204b22:	1101                	addi	sp,sp,-32
ffffffffc0204b24:	ec06                	sd	ra,24(sp)
ffffffffc0204b26:	e822                	sd	s0,16(sp)
ffffffffc0204b28:	e426                	sd	s1,8(sp)
ffffffffc0204b2a:	478d                	li	a5,3
ffffffffc0204b2c:	08f70363          	beq	a4,a5,ffffffffc0204bb2 <wakeup_proc+0x92>
ffffffffc0204b30:	842a                	mv	s0,a0
ffffffffc0204b32:	100027f3          	csrr	a5,sstatus
ffffffffc0204b36:	8b89                	andi	a5,a5,2
ffffffffc0204b38:	4481                	li	s1,0
ffffffffc0204b3a:	e7bd                	bnez	a5,ffffffffc0204ba8 <wakeup_proc+0x88>
ffffffffc0204b3c:	4789                	li	a5,2
ffffffffc0204b3e:	04f70863          	beq	a4,a5,ffffffffc0204b8e <wakeup_proc+0x6e>
ffffffffc0204b42:	c01c                	sw	a5,0(s0)
ffffffffc0204b44:	0e042623          	sw	zero,236(s0)
ffffffffc0204b48:	00015797          	auipc	a5,0x15
ffffffffc0204b4c:	9b87b783          	ld	a5,-1608(a5) # ffffffffc0219500 <current>
ffffffffc0204b50:	02878363          	beq	a5,s0,ffffffffc0204b76 <wakeup_proc+0x56>
ffffffffc0204b54:	00015797          	auipc	a5,0x15
ffffffffc0204b58:	9b47b783          	ld	a5,-1612(a5) # ffffffffc0219508 <idleproc>
ffffffffc0204b5c:	00f40d63          	beq	s0,a5,ffffffffc0204b76 <wakeup_proc+0x56>
ffffffffc0204b60:	00015797          	auipc	a5,0x15
ffffffffc0204b64:	9c87b783          	ld	a5,-1592(a5) # ffffffffc0219528 <sched_class>
ffffffffc0204b68:	6b9c                	ld	a5,16(a5)
ffffffffc0204b6a:	85a2                	mv	a1,s0
ffffffffc0204b6c:	00015517          	auipc	a0,0x15
ffffffffc0204b70:	9b453503          	ld	a0,-1612(a0) # ffffffffc0219520 <rq>
ffffffffc0204b74:	9782                	jalr	a5
ffffffffc0204b76:	e491                	bnez	s1,ffffffffc0204b82 <wakeup_proc+0x62>
ffffffffc0204b78:	60e2                	ld	ra,24(sp)
ffffffffc0204b7a:	6442                	ld	s0,16(sp)
ffffffffc0204b7c:	64a2                	ld	s1,8(sp)
ffffffffc0204b7e:	6105                	addi	sp,sp,32
ffffffffc0204b80:	8082                	ret
ffffffffc0204b82:	6442                	ld	s0,16(sp)
ffffffffc0204b84:	60e2                	ld	ra,24(sp)
ffffffffc0204b86:	64a2                	ld	s1,8(sp)
ffffffffc0204b88:	6105                	addi	sp,sp,32
ffffffffc0204b8a:	aa9fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b8e:	00005617          	auipc	a2,0x5
ffffffffc0204b92:	07260613          	addi	a2,a2,114 # ffffffffc0209c00 <default_pmm_manager+0x788>
ffffffffc0204b96:	04800593          	li	a1,72
ffffffffc0204b9a:	00005517          	auipc	a0,0x5
ffffffffc0204b9e:	04e50513          	addi	a0,a0,78 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204ba2:	ecefb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204ba6:	bfc1                	j	ffffffffc0204b76 <wakeup_proc+0x56>
ffffffffc0204ba8:	a91fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204bac:	4018                	lw	a4,0(s0)
ffffffffc0204bae:	4485                	li	s1,1
ffffffffc0204bb0:	b771                	j	ffffffffc0204b3c <wakeup_proc+0x1c>
ffffffffc0204bb2:	00005697          	auipc	a3,0x5
ffffffffc0204bb6:	01668693          	addi	a3,a3,22 # ffffffffc0209bc8 <default_pmm_manager+0x750>
ffffffffc0204bba:	00004617          	auipc	a2,0x4
ffffffffc0204bbe:	b7e60613          	addi	a2,a2,-1154 # ffffffffc0208738 <commands+0x410>
ffffffffc0204bc2:	03c00593          	li	a1,60
ffffffffc0204bc6:	00005517          	auipc	a0,0x5
ffffffffc0204bca:	02250513          	addi	a0,a0,34 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204bce:	e3afb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204bd2 <schedule>:
ffffffffc0204bd2:	7179                	addi	sp,sp,-48
ffffffffc0204bd4:	f406                	sd	ra,40(sp)
ffffffffc0204bd6:	f022                	sd	s0,32(sp)
ffffffffc0204bd8:	ec26                	sd	s1,24(sp)
ffffffffc0204bda:	e84a                	sd	s2,16(sp)
ffffffffc0204bdc:	e44e                	sd	s3,8(sp)
ffffffffc0204bde:	e052                	sd	s4,0(sp)
ffffffffc0204be0:	100027f3          	csrr	a5,sstatus
ffffffffc0204be4:	8b89                	andi	a5,a5,2
ffffffffc0204be6:	4a01                	li	s4,0
ffffffffc0204be8:	e7c5                	bnez	a5,ffffffffc0204c90 <schedule+0xbe>
ffffffffc0204bea:	00015497          	auipc	s1,0x15
ffffffffc0204bee:	91648493          	addi	s1,s1,-1770 # ffffffffc0219500 <current>
ffffffffc0204bf2:	608c                	ld	a1,0(s1)
ffffffffc0204bf4:	00015997          	auipc	s3,0x15
ffffffffc0204bf8:	93498993          	addi	s3,s3,-1740 # ffffffffc0219528 <sched_class>
ffffffffc0204bfc:	00015917          	auipc	s2,0x15
ffffffffc0204c00:	92490913          	addi	s2,s2,-1756 # ffffffffc0219520 <rq>
ffffffffc0204c04:	4194                	lw	a3,0(a1)
ffffffffc0204c06:	0005bc23          	sd	zero,24(a1)
ffffffffc0204c0a:	4709                	li	a4,2
ffffffffc0204c0c:	0009b783          	ld	a5,0(s3)
ffffffffc0204c10:	00093503          	ld	a0,0(s2)
ffffffffc0204c14:	04e68063          	beq	a3,a4,ffffffffc0204c54 <schedule+0x82>
ffffffffc0204c18:	739c                	ld	a5,32(a5)
ffffffffc0204c1a:	9782                	jalr	a5
ffffffffc0204c1c:	842a                	mv	s0,a0
ffffffffc0204c1e:	c939                	beqz	a0,ffffffffc0204c74 <schedule+0xa2>
ffffffffc0204c20:	0009b783          	ld	a5,0(s3)
ffffffffc0204c24:	00093503          	ld	a0,0(s2)
ffffffffc0204c28:	85a2                	mv	a1,s0
ffffffffc0204c2a:	6f9c                	ld	a5,24(a5)
ffffffffc0204c2c:	9782                	jalr	a5
ffffffffc0204c2e:	441c                	lw	a5,8(s0)
ffffffffc0204c30:	6098                	ld	a4,0(s1)
ffffffffc0204c32:	2785                	addiw	a5,a5,1
ffffffffc0204c34:	c41c                	sw	a5,8(s0)
ffffffffc0204c36:	00870563          	beq	a4,s0,ffffffffc0204c40 <schedule+0x6e>
ffffffffc0204c3a:	8522                	mv	a0,s0
ffffffffc0204c3c:	d37fe0ef          	jal	ra,ffffffffc0203972 <proc_run>
ffffffffc0204c40:	020a1f63          	bnez	s4,ffffffffc0204c7e <schedule+0xac>
ffffffffc0204c44:	70a2                	ld	ra,40(sp)
ffffffffc0204c46:	7402                	ld	s0,32(sp)
ffffffffc0204c48:	64e2                	ld	s1,24(sp)
ffffffffc0204c4a:	6942                	ld	s2,16(sp)
ffffffffc0204c4c:	69a2                	ld	s3,8(sp)
ffffffffc0204c4e:	6a02                	ld	s4,0(sp)
ffffffffc0204c50:	6145                	addi	sp,sp,48
ffffffffc0204c52:	8082                	ret
ffffffffc0204c54:	00015717          	auipc	a4,0x15
ffffffffc0204c58:	8b473703          	ld	a4,-1868(a4) # ffffffffc0219508 <idleproc>
ffffffffc0204c5c:	fae58ee3          	beq	a1,a4,ffffffffc0204c18 <schedule+0x46>
ffffffffc0204c60:	6b9c                	ld	a5,16(a5)
ffffffffc0204c62:	9782                	jalr	a5
ffffffffc0204c64:	0009b783          	ld	a5,0(s3)
ffffffffc0204c68:	00093503          	ld	a0,0(s2)
ffffffffc0204c6c:	739c                	ld	a5,32(a5)
ffffffffc0204c6e:	9782                	jalr	a5
ffffffffc0204c70:	842a                	mv	s0,a0
ffffffffc0204c72:	f55d                	bnez	a0,ffffffffc0204c20 <schedule+0x4e>
ffffffffc0204c74:	00015417          	auipc	s0,0x15
ffffffffc0204c78:	89443403          	ld	s0,-1900(s0) # ffffffffc0219508 <idleproc>
ffffffffc0204c7c:	bf4d                	j	ffffffffc0204c2e <schedule+0x5c>
ffffffffc0204c7e:	7402                	ld	s0,32(sp)
ffffffffc0204c80:	70a2                	ld	ra,40(sp)
ffffffffc0204c82:	64e2                	ld	s1,24(sp)
ffffffffc0204c84:	6942                	ld	s2,16(sp)
ffffffffc0204c86:	69a2                	ld	s3,8(sp)
ffffffffc0204c88:	6a02                	ld	s4,0(sp)
ffffffffc0204c8a:	6145                	addi	sp,sp,48
ffffffffc0204c8c:	9a7fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204c90:	9a9fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c94:	4a05                	li	s4,1
ffffffffc0204c96:	bf91                	j	ffffffffc0204bea <schedule+0x18>

ffffffffc0204c98 <add_timer>:
ffffffffc0204c98:	1141                	addi	sp,sp,-16
ffffffffc0204c9a:	e022                	sd	s0,0(sp)
ffffffffc0204c9c:	e406                	sd	ra,8(sp)
ffffffffc0204c9e:	842a                	mv	s0,a0
ffffffffc0204ca0:	100027f3          	csrr	a5,sstatus
ffffffffc0204ca4:	8b89                	andi	a5,a5,2
ffffffffc0204ca6:	4501                	li	a0,0
ffffffffc0204ca8:	eba5                	bnez	a5,ffffffffc0204d18 <add_timer+0x80>
ffffffffc0204caa:	401c                	lw	a5,0(s0)
ffffffffc0204cac:	cbb5                	beqz	a5,ffffffffc0204d20 <add_timer+0x88>
ffffffffc0204cae:	6418                	ld	a4,8(s0)
ffffffffc0204cb0:	cb25                	beqz	a4,ffffffffc0204d20 <add_timer+0x88>
ffffffffc0204cb2:	6c18                	ld	a4,24(s0)
ffffffffc0204cb4:	01040593          	addi	a1,s0,16
ffffffffc0204cb8:	08e59463          	bne	a1,a4,ffffffffc0204d40 <add_timer+0xa8>
ffffffffc0204cbc:	00014617          	auipc	a2,0x14
ffffffffc0204cc0:	7fc60613          	addi	a2,a2,2044 # ffffffffc02194b8 <timer_list>
ffffffffc0204cc4:	6618                	ld	a4,8(a2)
ffffffffc0204cc6:	00c71863          	bne	a4,a2,ffffffffc0204cd6 <add_timer+0x3e>
ffffffffc0204cca:	a80d                	j	ffffffffc0204cfc <add_timer+0x64>
ffffffffc0204ccc:	6718                	ld	a4,8(a4)
ffffffffc0204cce:	9f95                	subw	a5,a5,a3
ffffffffc0204cd0:	c01c                	sw	a5,0(s0)
ffffffffc0204cd2:	02c70563          	beq	a4,a2,ffffffffc0204cfc <add_timer+0x64>
ffffffffc0204cd6:	ff072683          	lw	a3,-16(a4)
ffffffffc0204cda:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204ccc <add_timer+0x34>
ffffffffc0204cde:	40f687bb          	subw	a5,a3,a5
ffffffffc0204ce2:	fef72823          	sw	a5,-16(a4)
ffffffffc0204ce6:	631c                	ld	a5,0(a4)
ffffffffc0204ce8:	e30c                	sd	a1,0(a4)
ffffffffc0204cea:	e78c                	sd	a1,8(a5)
ffffffffc0204cec:	ec18                	sd	a4,24(s0)
ffffffffc0204cee:	e81c                	sd	a5,16(s0)
ffffffffc0204cf0:	c105                	beqz	a0,ffffffffc0204d10 <add_timer+0x78>
ffffffffc0204cf2:	6402                	ld	s0,0(sp)
ffffffffc0204cf4:	60a2                	ld	ra,8(sp)
ffffffffc0204cf6:	0141                	addi	sp,sp,16
ffffffffc0204cf8:	93bfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204cfc:	00014717          	auipc	a4,0x14
ffffffffc0204d00:	7bc70713          	addi	a4,a4,1980 # ffffffffc02194b8 <timer_list>
ffffffffc0204d04:	631c                	ld	a5,0(a4)
ffffffffc0204d06:	e30c                	sd	a1,0(a4)
ffffffffc0204d08:	e78c                	sd	a1,8(a5)
ffffffffc0204d0a:	ec18                	sd	a4,24(s0)
ffffffffc0204d0c:	e81c                	sd	a5,16(s0)
ffffffffc0204d0e:	f175                	bnez	a0,ffffffffc0204cf2 <add_timer+0x5a>
ffffffffc0204d10:	60a2                	ld	ra,8(sp)
ffffffffc0204d12:	6402                	ld	s0,0(sp)
ffffffffc0204d14:	0141                	addi	sp,sp,16
ffffffffc0204d16:	8082                	ret
ffffffffc0204d18:	921fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204d1c:	4505                	li	a0,1
ffffffffc0204d1e:	b771                	j	ffffffffc0204caa <add_timer+0x12>
ffffffffc0204d20:	00005697          	auipc	a3,0x5
ffffffffc0204d24:	f0068693          	addi	a3,a3,-256 # ffffffffc0209c20 <default_pmm_manager+0x7a8>
ffffffffc0204d28:	00004617          	auipc	a2,0x4
ffffffffc0204d2c:	a1060613          	addi	a2,a2,-1520 # ffffffffc0208738 <commands+0x410>
ffffffffc0204d30:	06c00593          	li	a1,108
ffffffffc0204d34:	00005517          	auipc	a0,0x5
ffffffffc0204d38:	eb450513          	addi	a0,a0,-332 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204d3c:	cccfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204d40:	00005697          	auipc	a3,0x5
ffffffffc0204d44:	f1068693          	addi	a3,a3,-240 # ffffffffc0209c50 <default_pmm_manager+0x7d8>
ffffffffc0204d48:	00004617          	auipc	a2,0x4
ffffffffc0204d4c:	9f060613          	addi	a2,a2,-1552 # ffffffffc0208738 <commands+0x410>
ffffffffc0204d50:	06d00593          	li	a1,109
ffffffffc0204d54:	00005517          	auipc	a0,0x5
ffffffffc0204d58:	e9450513          	addi	a0,a0,-364 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204d5c:	cacfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204d60 <del_timer>:
ffffffffc0204d60:	1101                	addi	sp,sp,-32
ffffffffc0204d62:	e822                	sd	s0,16(sp)
ffffffffc0204d64:	ec06                	sd	ra,24(sp)
ffffffffc0204d66:	e426                	sd	s1,8(sp)
ffffffffc0204d68:	842a                	mv	s0,a0
ffffffffc0204d6a:	100027f3          	csrr	a5,sstatus
ffffffffc0204d6e:	8b89                	andi	a5,a5,2
ffffffffc0204d70:	01050493          	addi	s1,a0,16
ffffffffc0204d74:	eb9d                	bnez	a5,ffffffffc0204daa <del_timer+0x4a>
ffffffffc0204d76:	6d1c                	ld	a5,24(a0)
ffffffffc0204d78:	02978463          	beq	a5,s1,ffffffffc0204da0 <del_timer+0x40>
ffffffffc0204d7c:	4114                	lw	a3,0(a0)
ffffffffc0204d7e:	6918                	ld	a4,16(a0)
ffffffffc0204d80:	ce81                	beqz	a3,ffffffffc0204d98 <del_timer+0x38>
ffffffffc0204d82:	00014617          	auipc	a2,0x14
ffffffffc0204d86:	73660613          	addi	a2,a2,1846 # ffffffffc02194b8 <timer_list>
ffffffffc0204d8a:	00c78763          	beq	a5,a2,ffffffffc0204d98 <del_timer+0x38>
ffffffffc0204d8e:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204d92:	9eb1                	addw	a3,a3,a2
ffffffffc0204d94:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204d98:	e71c                	sd	a5,8(a4)
ffffffffc0204d9a:	e398                	sd	a4,0(a5)
ffffffffc0204d9c:	ec04                	sd	s1,24(s0)
ffffffffc0204d9e:	e804                	sd	s1,16(s0)
ffffffffc0204da0:	60e2                	ld	ra,24(sp)
ffffffffc0204da2:	6442                	ld	s0,16(sp)
ffffffffc0204da4:	64a2                	ld	s1,8(sp)
ffffffffc0204da6:	6105                	addi	sp,sp,32
ffffffffc0204da8:	8082                	ret
ffffffffc0204daa:	88ffb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204dae:	6c1c                	ld	a5,24(s0)
ffffffffc0204db0:	02978463          	beq	a5,s1,ffffffffc0204dd8 <del_timer+0x78>
ffffffffc0204db4:	4014                	lw	a3,0(s0)
ffffffffc0204db6:	6818                	ld	a4,16(s0)
ffffffffc0204db8:	ce81                	beqz	a3,ffffffffc0204dd0 <del_timer+0x70>
ffffffffc0204dba:	00014617          	auipc	a2,0x14
ffffffffc0204dbe:	6fe60613          	addi	a2,a2,1790 # ffffffffc02194b8 <timer_list>
ffffffffc0204dc2:	00c78763          	beq	a5,a2,ffffffffc0204dd0 <del_timer+0x70>
ffffffffc0204dc6:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204dca:	9eb1                	addw	a3,a3,a2
ffffffffc0204dcc:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204dd0:	e71c                	sd	a5,8(a4)
ffffffffc0204dd2:	e398                	sd	a4,0(a5)
ffffffffc0204dd4:	ec04                	sd	s1,24(s0)
ffffffffc0204dd6:	e804                	sd	s1,16(s0)
ffffffffc0204dd8:	6442                	ld	s0,16(sp)
ffffffffc0204dda:	60e2                	ld	ra,24(sp)
ffffffffc0204ddc:	64a2                	ld	s1,8(sp)
ffffffffc0204dde:	6105                	addi	sp,sp,32
ffffffffc0204de0:	853fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204de4 <run_timer_list>:
ffffffffc0204de4:	7139                	addi	sp,sp,-64
ffffffffc0204de6:	fc06                	sd	ra,56(sp)
ffffffffc0204de8:	f822                	sd	s0,48(sp)
ffffffffc0204dea:	f426                	sd	s1,40(sp)
ffffffffc0204dec:	f04a                	sd	s2,32(sp)
ffffffffc0204dee:	ec4e                	sd	s3,24(sp)
ffffffffc0204df0:	e852                	sd	s4,16(sp)
ffffffffc0204df2:	e456                	sd	s5,8(sp)
ffffffffc0204df4:	e05a                	sd	s6,0(sp)
ffffffffc0204df6:	100027f3          	csrr	a5,sstatus
ffffffffc0204dfa:	8b89                	andi	a5,a5,2
ffffffffc0204dfc:	4b01                	li	s6,0
ffffffffc0204dfe:	eff9                	bnez	a5,ffffffffc0204edc <run_timer_list+0xf8>
ffffffffc0204e00:	00014997          	auipc	s3,0x14
ffffffffc0204e04:	6b898993          	addi	s3,s3,1720 # ffffffffc02194b8 <timer_list>
ffffffffc0204e08:	0089b403          	ld	s0,8(s3)
ffffffffc0204e0c:	07340a63          	beq	s0,s3,ffffffffc0204e80 <run_timer_list+0x9c>
ffffffffc0204e10:	ff042783          	lw	a5,-16(s0)
ffffffffc0204e14:	ff040913          	addi	s2,s0,-16
ffffffffc0204e18:	0e078663          	beqz	a5,ffffffffc0204f04 <run_timer_list+0x120>
ffffffffc0204e1c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204e20:	fee42823          	sw	a4,-16(s0)
ffffffffc0204e24:	ef31                	bnez	a4,ffffffffc0204e80 <run_timer_list+0x9c>
ffffffffc0204e26:	00005a97          	auipc	s5,0x5
ffffffffc0204e2a:	e92a8a93          	addi	s5,s5,-366 # ffffffffc0209cb8 <default_pmm_manager+0x840>
ffffffffc0204e2e:	00005a17          	auipc	s4,0x5
ffffffffc0204e32:	dbaa0a13          	addi	s4,s4,-582 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204e36:	a005                	j	ffffffffc0204e56 <run_timer_list+0x72>
ffffffffc0204e38:	0a07d663          	bgez	a5,ffffffffc0204ee4 <run_timer_list+0x100>
ffffffffc0204e3c:	8526                	mv	a0,s1
ffffffffc0204e3e:	ce3ff0ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc0204e42:	854a                	mv	a0,s2
ffffffffc0204e44:	f1dff0ef          	jal	ra,ffffffffc0204d60 <del_timer>
ffffffffc0204e48:	03340c63          	beq	s0,s3,ffffffffc0204e80 <run_timer_list+0x9c>
ffffffffc0204e4c:	ff042783          	lw	a5,-16(s0)
ffffffffc0204e50:	ff040913          	addi	s2,s0,-16
ffffffffc0204e54:	e795                	bnez	a5,ffffffffc0204e80 <run_timer_list+0x9c>
ffffffffc0204e56:	00893483          	ld	s1,8(s2)
ffffffffc0204e5a:	6400                	ld	s0,8(s0)
ffffffffc0204e5c:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204e60:	ffe1                	bnez	a5,ffffffffc0204e38 <run_timer_list+0x54>
ffffffffc0204e62:	40d4                	lw	a3,4(s1)
ffffffffc0204e64:	8656                	mv	a2,s5
ffffffffc0204e66:	0a300593          	li	a1,163
ffffffffc0204e6a:	8552                	mv	a0,s4
ffffffffc0204e6c:	c04fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204e70:	8526                	mv	a0,s1
ffffffffc0204e72:	cafff0ef          	jal	ra,ffffffffc0204b20 <wakeup_proc>
ffffffffc0204e76:	854a                	mv	a0,s2
ffffffffc0204e78:	ee9ff0ef          	jal	ra,ffffffffc0204d60 <del_timer>
ffffffffc0204e7c:	fd3418e3          	bne	s0,s3,ffffffffc0204e4c <run_timer_list+0x68>
ffffffffc0204e80:	00014597          	auipc	a1,0x14
ffffffffc0204e84:	6805b583          	ld	a1,1664(a1) # ffffffffc0219500 <current>
ffffffffc0204e88:	00014797          	auipc	a5,0x14
ffffffffc0204e8c:	6807b783          	ld	a5,1664(a5) # ffffffffc0219508 <idleproc>
ffffffffc0204e90:	04f58363          	beq	a1,a5,ffffffffc0204ed6 <run_timer_list+0xf2>
ffffffffc0204e94:	00014797          	auipc	a5,0x14
ffffffffc0204e98:	6947b783          	ld	a5,1684(a5) # ffffffffc0219528 <sched_class>
ffffffffc0204e9c:	779c                	ld	a5,40(a5)
ffffffffc0204e9e:	00014517          	auipc	a0,0x14
ffffffffc0204ea2:	68253503          	ld	a0,1666(a0) # ffffffffc0219520 <rq>
ffffffffc0204ea6:	9782                	jalr	a5
ffffffffc0204ea8:	000b1c63          	bnez	s6,ffffffffc0204ec0 <run_timer_list+0xdc>
ffffffffc0204eac:	70e2                	ld	ra,56(sp)
ffffffffc0204eae:	7442                	ld	s0,48(sp)
ffffffffc0204eb0:	74a2                	ld	s1,40(sp)
ffffffffc0204eb2:	7902                	ld	s2,32(sp)
ffffffffc0204eb4:	69e2                	ld	s3,24(sp)
ffffffffc0204eb6:	6a42                	ld	s4,16(sp)
ffffffffc0204eb8:	6aa2                	ld	s5,8(sp)
ffffffffc0204eba:	6b02                	ld	s6,0(sp)
ffffffffc0204ebc:	6121                	addi	sp,sp,64
ffffffffc0204ebe:	8082                	ret
ffffffffc0204ec0:	7442                	ld	s0,48(sp)
ffffffffc0204ec2:	70e2                	ld	ra,56(sp)
ffffffffc0204ec4:	74a2                	ld	s1,40(sp)
ffffffffc0204ec6:	7902                	ld	s2,32(sp)
ffffffffc0204ec8:	69e2                	ld	s3,24(sp)
ffffffffc0204eca:	6a42                	ld	s4,16(sp)
ffffffffc0204ecc:	6aa2                	ld	s5,8(sp)
ffffffffc0204ece:	6b02                	ld	s6,0(sp)
ffffffffc0204ed0:	6121                	addi	sp,sp,64
ffffffffc0204ed2:	f60fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204ed6:	4785                	li	a5,1
ffffffffc0204ed8:	ed9c                	sd	a5,24(a1)
ffffffffc0204eda:	b7f9                	j	ffffffffc0204ea8 <run_timer_list+0xc4>
ffffffffc0204edc:	f5cfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204ee0:	4b05                	li	s6,1
ffffffffc0204ee2:	bf39                	j	ffffffffc0204e00 <run_timer_list+0x1c>
ffffffffc0204ee4:	00005697          	auipc	a3,0x5
ffffffffc0204ee8:	dac68693          	addi	a3,a3,-596 # ffffffffc0209c90 <default_pmm_manager+0x818>
ffffffffc0204eec:	00004617          	auipc	a2,0x4
ffffffffc0204ef0:	84c60613          	addi	a2,a2,-1972 # ffffffffc0208738 <commands+0x410>
ffffffffc0204ef4:	0a000593          	li	a1,160
ffffffffc0204ef8:	00005517          	auipc	a0,0x5
ffffffffc0204efc:	cf050513          	addi	a0,a0,-784 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204f00:	b08fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204f04:	00005697          	auipc	a3,0x5
ffffffffc0204f08:	d7468693          	addi	a3,a3,-652 # ffffffffc0209c78 <default_pmm_manager+0x800>
ffffffffc0204f0c:	00004617          	auipc	a2,0x4
ffffffffc0204f10:	82c60613          	addi	a2,a2,-2004 # ffffffffc0208738 <commands+0x410>
ffffffffc0204f14:	09a00593          	li	a1,154
ffffffffc0204f18:	00005517          	auipc	a0,0x5
ffffffffc0204f1c:	cd050513          	addi	a0,a0,-816 # ffffffffc0209be8 <default_pmm_manager+0x770>
ffffffffc0204f20:	ae8fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204f24 <proc_stride_comp_f>:
ffffffffc0204f24:	4d08                	lw	a0,24(a0)
ffffffffc0204f26:	4d9c                	lw	a5,24(a1)
ffffffffc0204f28:	9d1d                	subw	a0,a0,a5
ffffffffc0204f2a:	00a04763          	bgtz	a0,ffffffffc0204f38 <proc_stride_comp_f+0x14>
ffffffffc0204f2e:	00a03533          	snez	a0,a0
ffffffffc0204f32:	40a00533          	neg	a0,a0
ffffffffc0204f36:	8082                	ret
ffffffffc0204f38:	4505                	li	a0,1
ffffffffc0204f3a:	8082                	ret

ffffffffc0204f3c <stride_init>:
ffffffffc0204f3c:	e508                	sd	a0,8(a0)
ffffffffc0204f3e:	e108                	sd	a0,0(a0)
ffffffffc0204f40:	00053c23          	sd	zero,24(a0)
ffffffffc0204f44:	00052823          	sw	zero,16(a0)
ffffffffc0204f48:	8082                	ret

ffffffffc0204f4a <stride_pick_next>:
ffffffffc0204f4a:	6d1c                	ld	a5,24(a0)
ffffffffc0204f4c:	cf89                	beqz	a5,ffffffffc0204f66 <stride_pick_next+0x1c>
ffffffffc0204f4e:	4fd0                	lw	a2,28(a5)
ffffffffc0204f50:	4f98                	lw	a4,24(a5)
ffffffffc0204f52:	ed878513          	addi	a0,a5,-296
ffffffffc0204f56:	400006b7          	lui	a3,0x40000
ffffffffc0204f5a:	c219                	beqz	a2,ffffffffc0204f60 <stride_pick_next+0x16>
ffffffffc0204f5c:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204f60:	9f35                	addw	a4,a4,a3
ffffffffc0204f62:	cf98                	sw	a4,24(a5)
ffffffffc0204f64:	8082                	ret
ffffffffc0204f66:	4501                	li	a0,0
ffffffffc0204f68:	8082                	ret

ffffffffc0204f6a <stride_proc_tick>:
ffffffffc0204f6a:	1205a783          	lw	a5,288(a1)
ffffffffc0204f6e:	00f05563          	blez	a5,ffffffffc0204f78 <stride_proc_tick+0xe>
ffffffffc0204f72:	37fd                	addiw	a5,a5,-1
ffffffffc0204f74:	12f5a023          	sw	a5,288(a1)
ffffffffc0204f78:	e399                	bnez	a5,ffffffffc0204f7e <stride_proc_tick+0x14>
ffffffffc0204f7a:	4785                	li	a5,1
ffffffffc0204f7c:	ed9c                	sd	a5,24(a1)
ffffffffc0204f7e:	8082                	ret

ffffffffc0204f80 <skew_heap_merge.constprop.0>:
ffffffffc0204f80:	1101                	addi	sp,sp,-32
ffffffffc0204f82:	e822                	sd	s0,16(sp)
ffffffffc0204f84:	ec06                	sd	ra,24(sp)
ffffffffc0204f86:	e426                	sd	s1,8(sp)
ffffffffc0204f88:	e04a                	sd	s2,0(sp)
ffffffffc0204f8a:	842e                	mv	s0,a1
ffffffffc0204f8c:	c11d                	beqz	a0,ffffffffc0204fb2 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204f8e:	84aa                	mv	s1,a0
ffffffffc0204f90:	c1b9                	beqz	a1,ffffffffc0204fd6 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204f92:	f93ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0204f96:	57fd                	li	a5,-1
ffffffffc0204f98:	02f50463          	beq	a0,a5,ffffffffc0204fc0 <skew_heap_merge.constprop.0+0x40>
ffffffffc0204f9c:	680c                	ld	a1,16(s0)
ffffffffc0204f9e:	00843903          	ld	s2,8(s0)
ffffffffc0204fa2:	8526                	mv	a0,s1
ffffffffc0204fa4:	fddff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0204fa8:	e408                	sd	a0,8(s0)
ffffffffc0204faa:	01243823          	sd	s2,16(s0)
ffffffffc0204fae:	c111                	beqz	a0,ffffffffc0204fb2 <skew_heap_merge.constprop.0+0x32>
ffffffffc0204fb0:	e100                	sd	s0,0(a0)
ffffffffc0204fb2:	60e2                	ld	ra,24(sp)
ffffffffc0204fb4:	8522                	mv	a0,s0
ffffffffc0204fb6:	6442                	ld	s0,16(sp)
ffffffffc0204fb8:	64a2                	ld	s1,8(sp)
ffffffffc0204fba:	6902                	ld	s2,0(sp)
ffffffffc0204fbc:	6105                	addi	sp,sp,32
ffffffffc0204fbe:	8082                	ret
ffffffffc0204fc0:	6888                	ld	a0,16(s1)
ffffffffc0204fc2:	0084b903          	ld	s2,8(s1)
ffffffffc0204fc6:	85a2                	mv	a1,s0
ffffffffc0204fc8:	fb9ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0204fcc:	e488                	sd	a0,8(s1)
ffffffffc0204fce:	0124b823          	sd	s2,16(s1)
ffffffffc0204fd2:	c111                	beqz	a0,ffffffffc0204fd6 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204fd4:	e104                	sd	s1,0(a0)
ffffffffc0204fd6:	60e2                	ld	ra,24(sp)
ffffffffc0204fd8:	6442                	ld	s0,16(sp)
ffffffffc0204fda:	6902                	ld	s2,0(sp)
ffffffffc0204fdc:	8526                	mv	a0,s1
ffffffffc0204fde:	64a2                	ld	s1,8(sp)
ffffffffc0204fe0:	6105                	addi	sp,sp,32
ffffffffc0204fe2:	8082                	ret

ffffffffc0204fe4 <stride_enqueue>:
ffffffffc0204fe4:	7119                	addi	sp,sp,-128
ffffffffc0204fe6:	f4a6                	sd	s1,104(sp)
ffffffffc0204fe8:	6d04                	ld	s1,24(a0)
ffffffffc0204fea:	f8a2                	sd	s0,112(sp)
ffffffffc0204fec:	f0ca                	sd	s2,96(sp)
ffffffffc0204fee:	e8d2                	sd	s4,80(sp)
ffffffffc0204ff0:	fc86                	sd	ra,120(sp)
ffffffffc0204ff2:	ecce                	sd	s3,88(sp)
ffffffffc0204ff4:	e4d6                	sd	s5,72(sp)
ffffffffc0204ff6:	e0da                	sd	s6,64(sp)
ffffffffc0204ff8:	fc5e                	sd	s7,56(sp)
ffffffffc0204ffa:	f862                	sd	s8,48(sp)
ffffffffc0204ffc:	f466                	sd	s9,40(sp)
ffffffffc0204ffe:	f06a                	sd	s10,32(sp)
ffffffffc0205000:	ec6e                	sd	s11,24(sp)
ffffffffc0205002:	1205b423          	sd	zero,296(a1)
ffffffffc0205006:	1205bc23          	sd	zero,312(a1)
ffffffffc020500a:	1205b823          	sd	zero,304(a1)
ffffffffc020500e:	8a2a                	mv	s4,a0
ffffffffc0205010:	842e                	mv	s0,a1
ffffffffc0205012:	12858913          	addi	s2,a1,296
ffffffffc0205016:	cc89                	beqz	s1,ffffffffc0205030 <stride_enqueue+0x4c>
ffffffffc0205018:	85ca                	mv	a1,s2
ffffffffc020501a:	8526                	mv	a0,s1
ffffffffc020501c:	f09ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205020:	57fd                	li	a5,-1
ffffffffc0205022:	89aa                	mv	s3,a0
ffffffffc0205024:	04f50763          	beq	a0,a5,ffffffffc0205072 <stride_enqueue+0x8e>
ffffffffc0205028:	12943823          	sd	s1,304(s0)
ffffffffc020502c:	0124b023          	sd	s2,0(s1)
ffffffffc0205030:	12042783          	lw	a5,288(s0)
ffffffffc0205034:	012a3c23          	sd	s2,24(s4)
ffffffffc0205038:	014a2703          	lw	a4,20(s4)
ffffffffc020503c:	c399                	beqz	a5,ffffffffc0205042 <stride_enqueue+0x5e>
ffffffffc020503e:	00f75463          	bge	a4,a5,ffffffffc0205046 <stride_enqueue+0x62>
ffffffffc0205042:	12e42023          	sw	a4,288(s0)
ffffffffc0205046:	010a2783          	lw	a5,16(s4)
ffffffffc020504a:	70e6                	ld	ra,120(sp)
ffffffffc020504c:	11443423          	sd	s4,264(s0)
ffffffffc0205050:	7446                	ld	s0,112(sp)
ffffffffc0205052:	2785                	addiw	a5,a5,1
ffffffffc0205054:	00fa2823          	sw	a5,16(s4)
ffffffffc0205058:	74a6                	ld	s1,104(sp)
ffffffffc020505a:	7906                	ld	s2,96(sp)
ffffffffc020505c:	69e6                	ld	s3,88(sp)
ffffffffc020505e:	6a46                	ld	s4,80(sp)
ffffffffc0205060:	6aa6                	ld	s5,72(sp)
ffffffffc0205062:	6b06                	ld	s6,64(sp)
ffffffffc0205064:	7be2                	ld	s7,56(sp)
ffffffffc0205066:	7c42                	ld	s8,48(sp)
ffffffffc0205068:	7ca2                	ld	s9,40(sp)
ffffffffc020506a:	7d02                	ld	s10,32(sp)
ffffffffc020506c:	6de2                	ld	s11,24(sp)
ffffffffc020506e:	6109                	addi	sp,sp,128
ffffffffc0205070:	8082                	ret
ffffffffc0205072:	0104ba83          	ld	s5,16(s1)
ffffffffc0205076:	0084bb83          	ld	s7,8(s1)
ffffffffc020507a:	000a8d63          	beqz	s5,ffffffffc0205094 <stride_enqueue+0xb0>
ffffffffc020507e:	85ca                	mv	a1,s2
ffffffffc0205080:	8556                	mv	a0,s5
ffffffffc0205082:	ea3ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205086:	8b2a                	mv	s6,a0
ffffffffc0205088:	01350e63          	beq	a0,s3,ffffffffc02050a4 <stride_enqueue+0xc0>
ffffffffc020508c:	13543823          	sd	s5,304(s0)
ffffffffc0205090:	012ab023          	sd	s2,0(s5)
ffffffffc0205094:	0124b423          	sd	s2,8(s1)
ffffffffc0205098:	0174b823          	sd	s7,16(s1)
ffffffffc020509c:	00993023          	sd	s1,0(s2)
ffffffffc02050a0:	8926                	mv	s2,s1
ffffffffc02050a2:	b779                	j	ffffffffc0205030 <stride_enqueue+0x4c>
ffffffffc02050a4:	010ab983          	ld	s3,16(s5)
ffffffffc02050a8:	008abc83          	ld	s9,8(s5)
ffffffffc02050ac:	00098d63          	beqz	s3,ffffffffc02050c6 <stride_enqueue+0xe2>
ffffffffc02050b0:	85ca                	mv	a1,s2
ffffffffc02050b2:	854e                	mv	a0,s3
ffffffffc02050b4:	e71ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02050b8:	8c2a                	mv	s8,a0
ffffffffc02050ba:	01650e63          	beq	a0,s6,ffffffffc02050d6 <stride_enqueue+0xf2>
ffffffffc02050be:	13343823          	sd	s3,304(s0)
ffffffffc02050c2:	0129b023          	sd	s2,0(s3)
ffffffffc02050c6:	012ab423          	sd	s2,8(s5)
ffffffffc02050ca:	019ab823          	sd	s9,16(s5)
ffffffffc02050ce:	01593023          	sd	s5,0(s2)
ffffffffc02050d2:	8956                	mv	s2,s5
ffffffffc02050d4:	b7c1                	j	ffffffffc0205094 <stride_enqueue+0xb0>
ffffffffc02050d6:	0109bb03          	ld	s6,16(s3)
ffffffffc02050da:	0089bd83          	ld	s11,8(s3)
ffffffffc02050de:	000b0d63          	beqz	s6,ffffffffc02050f8 <stride_enqueue+0x114>
ffffffffc02050e2:	85ca                	mv	a1,s2
ffffffffc02050e4:	855a                	mv	a0,s6
ffffffffc02050e6:	e3fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02050ea:	8d2a                	mv	s10,a0
ffffffffc02050ec:	01850e63          	beq	a0,s8,ffffffffc0205108 <stride_enqueue+0x124>
ffffffffc02050f0:	13643823          	sd	s6,304(s0)
ffffffffc02050f4:	012b3023          	sd	s2,0(s6)
ffffffffc02050f8:	0129b423          	sd	s2,8(s3)
ffffffffc02050fc:	01b9b823          	sd	s11,16(s3)
ffffffffc0205100:	01393023          	sd	s3,0(s2)
ffffffffc0205104:	894e                	mv	s2,s3
ffffffffc0205106:	b7c1                	j	ffffffffc02050c6 <stride_enqueue+0xe2>
ffffffffc0205108:	008b3783          	ld	a5,8(s6)
ffffffffc020510c:	010b3c03          	ld	s8,16(s6)
ffffffffc0205110:	e43e                	sd	a5,8(sp)
ffffffffc0205112:	000c0c63          	beqz	s8,ffffffffc020512a <stride_enqueue+0x146>
ffffffffc0205116:	85ca                	mv	a1,s2
ffffffffc0205118:	8562                	mv	a0,s8
ffffffffc020511a:	e0bff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020511e:	01a50f63          	beq	a0,s10,ffffffffc020513c <stride_enqueue+0x158>
ffffffffc0205122:	13843823          	sd	s8,304(s0)
ffffffffc0205126:	012c3023          	sd	s2,0(s8)
ffffffffc020512a:	67a2                	ld	a5,8(sp)
ffffffffc020512c:	012b3423          	sd	s2,8(s6)
ffffffffc0205130:	00fb3823          	sd	a5,16(s6)
ffffffffc0205134:	01693023          	sd	s6,0(s2)
ffffffffc0205138:	895a                	mv	s2,s6
ffffffffc020513a:	bf7d                	j	ffffffffc02050f8 <stride_enqueue+0x114>
ffffffffc020513c:	010c3503          	ld	a0,16(s8)
ffffffffc0205140:	008c3d03          	ld	s10,8(s8)
ffffffffc0205144:	85ca                	mv	a1,s2
ffffffffc0205146:	e3bff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020514a:	00ac3423          	sd	a0,8(s8)
ffffffffc020514e:	01ac3823          	sd	s10,16(s8)
ffffffffc0205152:	c509                	beqz	a0,ffffffffc020515c <stride_enqueue+0x178>
ffffffffc0205154:	01853023          	sd	s8,0(a0)
ffffffffc0205158:	8962                	mv	s2,s8
ffffffffc020515a:	bfc1                	j	ffffffffc020512a <stride_enqueue+0x146>
ffffffffc020515c:	8962                	mv	s2,s8
ffffffffc020515e:	b7f1                	j	ffffffffc020512a <stride_enqueue+0x146>

ffffffffc0205160 <stride_dequeue>:
ffffffffc0205160:	1085b783          	ld	a5,264(a1)
ffffffffc0205164:	7171                	addi	sp,sp,-176
ffffffffc0205166:	f506                	sd	ra,168(sp)
ffffffffc0205168:	f122                	sd	s0,160(sp)
ffffffffc020516a:	ed26                	sd	s1,152(sp)
ffffffffc020516c:	e94a                	sd	s2,144(sp)
ffffffffc020516e:	e54e                	sd	s3,136(sp)
ffffffffc0205170:	e152                	sd	s4,128(sp)
ffffffffc0205172:	fcd6                	sd	s5,120(sp)
ffffffffc0205174:	f8da                	sd	s6,112(sp)
ffffffffc0205176:	f4de                	sd	s7,104(sp)
ffffffffc0205178:	f0e2                	sd	s8,96(sp)
ffffffffc020517a:	ece6                	sd	s9,88(sp)
ffffffffc020517c:	e8ea                	sd	s10,80(sp)
ffffffffc020517e:	e4ee                	sd	s11,72(sp)
ffffffffc0205180:	00a78463          	beq	a5,a0,ffffffffc0205188 <stride_dequeue+0x28>
ffffffffc0205184:	7870106f          	j	ffffffffc020710a <stride_dequeue+0x1faa>
ffffffffc0205188:	01052983          	lw	s3,16(a0)
ffffffffc020518c:	8c2a                	mv	s8,a0
ffffffffc020518e:	8b4e                	mv	s6,s3
ffffffffc0205190:	00099463          	bnez	s3,ffffffffc0205198 <stride_dequeue+0x38>
ffffffffc0205194:	7770106f          	j	ffffffffc020710a <stride_dequeue+0x1faa>
ffffffffc0205198:	1305b903          	ld	s2,304(a1)
ffffffffc020519c:	01853a83          	ld	s5,24(a0)
ffffffffc02051a0:	1285bd03          	ld	s10,296(a1)
ffffffffc02051a4:	1385b483          	ld	s1,312(a1)
ffffffffc02051a8:	842e                	mv	s0,a1
ffffffffc02051aa:	2e090263          	beqz	s2,ffffffffc020548e <stride_dequeue+0x32e>
ffffffffc02051ae:	42048263          	beqz	s1,ffffffffc02055d2 <stride_dequeue+0x472>
ffffffffc02051b2:	85a6                	mv	a1,s1
ffffffffc02051b4:	854a                	mv	a0,s2
ffffffffc02051b6:	d6fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02051ba:	5cfd                	li	s9,-1
ffffffffc02051bc:	8a2a                	mv	s4,a0
ffffffffc02051be:	19950163          	beq	a0,s9,ffffffffc0205340 <stride_dequeue+0x1e0>
ffffffffc02051c2:	0104ba03          	ld	s4,16(s1)
ffffffffc02051c6:	0084bb83          	ld	s7,8(s1)
ffffffffc02051ca:	120a0563          	beqz	s4,ffffffffc02052f4 <stride_dequeue+0x194>
ffffffffc02051ce:	85d2                	mv	a1,s4
ffffffffc02051d0:	854a                	mv	a0,s2
ffffffffc02051d2:	d53ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02051d6:	2d950563          	beq	a0,s9,ffffffffc02054a0 <stride_dequeue+0x340>
ffffffffc02051da:	008a3783          	ld	a5,8(s4)
ffffffffc02051de:	010a3d83          	ld	s11,16(s4)
ffffffffc02051e2:	e03e                	sd	a5,0(sp)
ffffffffc02051e4:	100d8063          	beqz	s11,ffffffffc02052e4 <stride_dequeue+0x184>
ffffffffc02051e8:	85ee                	mv	a1,s11
ffffffffc02051ea:	854a                	mv	a0,s2
ffffffffc02051ec:	d39ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02051f0:	7f950563          	beq	a0,s9,ffffffffc02059da <stride_dequeue+0x87a>
ffffffffc02051f4:	008db783          	ld	a5,8(s11)
ffffffffc02051f8:	010dbc83          	ld	s9,16(s11)
ffffffffc02051fc:	e43e                	sd	a5,8(sp)
ffffffffc02051fe:	0c0c8b63          	beqz	s9,ffffffffc02052d4 <stride_dequeue+0x174>
ffffffffc0205202:	85e6                	mv	a1,s9
ffffffffc0205204:	854a                	mv	a0,s2
ffffffffc0205206:	d1fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020520a:	58fd                	li	a7,-1
ffffffffc020520c:	71150063          	beq	a0,a7,ffffffffc020590c <stride_dequeue+0x7ac>
ffffffffc0205210:	008cb783          	ld	a5,8(s9)
ffffffffc0205214:	010cb803          	ld	a6,16(s9)
ffffffffc0205218:	e83e                	sd	a5,16(sp)
ffffffffc020521a:	0a080563          	beqz	a6,ffffffffc02052c4 <stride_dequeue+0x164>
ffffffffc020521e:	85c2                	mv	a1,a6
ffffffffc0205220:	854a                	mv	a0,s2
ffffffffc0205222:	ec42                	sd	a6,24(sp)
ffffffffc0205224:	d01ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205228:	58fd                	li	a7,-1
ffffffffc020522a:	6862                	ld	a6,24(sp)
ffffffffc020522c:	41150be3          	beq	a0,a7,ffffffffc0205e42 <stride_dequeue+0xce2>
ffffffffc0205230:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd66958>
ffffffffc0205234:	01083783          	ld	a5,16(a6)
ffffffffc0205238:	ec3a                	sd	a4,24(sp)
ffffffffc020523a:	cfad                	beqz	a5,ffffffffc02052b4 <stride_dequeue+0x154>
ffffffffc020523c:	85be                	mv	a1,a5
ffffffffc020523e:	854a                	mv	a0,s2
ffffffffc0205240:	f442                	sd	a6,40(sp)
ffffffffc0205242:	f03e                	sd	a5,32(sp)
ffffffffc0205244:	ce1ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205248:	58fd                	li	a7,-1
ffffffffc020524a:	7782                	ld	a5,32(sp)
ffffffffc020524c:	7822                	ld	a6,40(sp)
ffffffffc020524e:	01151463          	bne	a0,a7,ffffffffc0205256 <stride_dequeue+0xf6>
ffffffffc0205252:	17a0106f          	j	ffffffffc02063cc <stride_dequeue+0x126c>
ffffffffc0205256:	6798                	ld	a4,8(a5)
ffffffffc0205258:	0107bb03          	ld	s6,16(a5)
ffffffffc020525c:	f03a                	sd	a4,32(sp)
ffffffffc020525e:	040b0463          	beqz	s6,ffffffffc02052a6 <stride_dequeue+0x146>
ffffffffc0205262:	85da                	mv	a1,s6
ffffffffc0205264:	854a                	mv	a0,s2
ffffffffc0205266:	f83e                	sd	a5,48(sp)
ffffffffc0205268:	f442                	sd	a6,40(sp)
ffffffffc020526a:	cbbff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020526e:	58fd                	li	a7,-1
ffffffffc0205270:	7822                	ld	a6,40(sp)
ffffffffc0205272:	77c2                	ld	a5,48(sp)
ffffffffc0205274:	01151463          	bne	a0,a7,ffffffffc020527c <stride_dequeue+0x11c>
ffffffffc0205278:	00d0106f          	j	ffffffffc0206a84 <stride_dequeue+0x1924>
ffffffffc020527c:	010b3583          	ld	a1,16(s6)
ffffffffc0205280:	008b3983          	ld	s3,8(s6)
ffffffffc0205284:	854a                	mv	a0,s2
ffffffffc0205286:	f83e                	sd	a5,48(sp)
ffffffffc0205288:	f442                	sd	a6,40(sp)
ffffffffc020528a:	cf7ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020528e:	00ab3423          	sd	a0,8(s6)
ffffffffc0205292:	013b3823          	sd	s3,16(s6)
ffffffffc0205296:	7822                	ld	a6,40(sp)
ffffffffc0205298:	77c2                	ld	a5,48(sp)
ffffffffc020529a:	010c2983          	lw	s3,16(s8)
ffffffffc020529e:	c119                	beqz	a0,ffffffffc02052a4 <stride_dequeue+0x144>
ffffffffc02052a0:	01653023          	sd	s6,0(a0)
ffffffffc02052a4:	895a                	mv	s2,s6
ffffffffc02052a6:	7702                	ld	a4,32(sp)
ffffffffc02052a8:	0127b423          	sd	s2,8(a5)
ffffffffc02052ac:	eb98                	sd	a4,16(a5)
ffffffffc02052ae:	00f93023          	sd	a5,0(s2)
ffffffffc02052b2:	893e                	mv	s2,a5
ffffffffc02052b4:	67e2                	ld	a5,24(sp)
ffffffffc02052b6:	01283423          	sd	s2,8(a6)
ffffffffc02052ba:	00f83823          	sd	a5,16(a6)
ffffffffc02052be:	01093023          	sd	a6,0(s2)
ffffffffc02052c2:	8942                	mv	s2,a6
ffffffffc02052c4:	67c2                	ld	a5,16(sp)
ffffffffc02052c6:	012cb423          	sd	s2,8(s9)
ffffffffc02052ca:	00fcb823          	sd	a5,16(s9)
ffffffffc02052ce:	01993023          	sd	s9,0(s2)
ffffffffc02052d2:	8966                	mv	s2,s9
ffffffffc02052d4:	67a2                	ld	a5,8(sp)
ffffffffc02052d6:	012db423          	sd	s2,8(s11)
ffffffffc02052da:	00fdb823          	sd	a5,16(s11)
ffffffffc02052de:	01b93023          	sd	s11,0(s2)
ffffffffc02052e2:	896e                	mv	s2,s11
ffffffffc02052e4:	6782                	ld	a5,0(sp)
ffffffffc02052e6:	012a3423          	sd	s2,8(s4)
ffffffffc02052ea:	00fa3823          	sd	a5,16(s4)
ffffffffc02052ee:	01493023          	sd	s4,0(s2)
ffffffffc02052f2:	8952                	mv	s2,s4
ffffffffc02052f4:	0124b423          	sd	s2,8(s1)
ffffffffc02052f8:	0174b823          	sd	s7,16(s1)
ffffffffc02052fc:	00993023          	sd	s1,0(s2)
ffffffffc0205300:	01a4b023          	sd	s10,0(s1)
ffffffffc0205304:	180d0963          	beqz	s10,ffffffffc0205496 <stride_dequeue+0x336>
ffffffffc0205308:	008d3683          	ld	a3,8(s10)
ffffffffc020530c:	12840413          	addi	s0,s0,296
ffffffffc0205310:	18868563          	beq	a3,s0,ffffffffc020549a <stride_dequeue+0x33a>
ffffffffc0205314:	009d3823          	sd	s1,16(s10)
ffffffffc0205318:	70aa                	ld	ra,168(sp)
ffffffffc020531a:	740a                	ld	s0,160(sp)
ffffffffc020531c:	39fd                	addiw	s3,s3,-1
ffffffffc020531e:	015c3c23          	sd	s5,24(s8)
ffffffffc0205322:	013c2823          	sw	s3,16(s8)
ffffffffc0205326:	64ea                	ld	s1,152(sp)
ffffffffc0205328:	694a                	ld	s2,144(sp)
ffffffffc020532a:	69aa                	ld	s3,136(sp)
ffffffffc020532c:	6a0a                	ld	s4,128(sp)
ffffffffc020532e:	7ae6                	ld	s5,120(sp)
ffffffffc0205330:	7b46                	ld	s6,112(sp)
ffffffffc0205332:	7ba6                	ld	s7,104(sp)
ffffffffc0205334:	7c06                	ld	s8,96(sp)
ffffffffc0205336:	6ce6                	ld	s9,88(sp)
ffffffffc0205338:	6d46                	ld	s10,80(sp)
ffffffffc020533a:	6da6                	ld	s11,72(sp)
ffffffffc020533c:	614d                	addi	sp,sp,176
ffffffffc020533e:	8082                	ret
ffffffffc0205340:	01093d83          	ld	s11,16(s2)
ffffffffc0205344:	00893b83          	ld	s7,8(s2)
ffffffffc0205348:	120d8963          	beqz	s11,ffffffffc020547a <stride_dequeue+0x31a>
ffffffffc020534c:	85a6                	mv	a1,s1
ffffffffc020534e:	856e                	mv	a0,s11
ffffffffc0205350:	bd5ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205354:	29450363          	beq	a0,s4,ffffffffc02055da <stride_dequeue+0x47a>
ffffffffc0205358:	649c                	ld	a5,8(s1)
ffffffffc020535a:	0104bc83          	ld	s9,16(s1)
ffffffffc020535e:	e03e                	sd	a5,0(sp)
ffffffffc0205360:	100c8763          	beqz	s9,ffffffffc020546e <stride_dequeue+0x30e>
ffffffffc0205364:	85e6                	mv	a1,s9
ffffffffc0205366:	856e                	mv	a0,s11
ffffffffc0205368:	bbdff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020536c:	4b450263          	beq	a0,s4,ffffffffc0205810 <stride_dequeue+0x6b0>
ffffffffc0205370:	008cb783          	ld	a5,8(s9)
ffffffffc0205374:	010cba03          	ld	s4,16(s9)
ffffffffc0205378:	e43e                	sd	a5,8(sp)
ffffffffc020537a:	0e0a0263          	beqz	s4,ffffffffc020545e <stride_dequeue+0x2fe>
ffffffffc020537e:	85d2                	mv	a1,s4
ffffffffc0205380:	856e                	mv	a0,s11
ffffffffc0205382:	ba3ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205386:	58fd                	li	a7,-1
ffffffffc0205388:	03150fe3          	beq	a0,a7,ffffffffc0205bc6 <stride_dequeue+0xa66>
ffffffffc020538c:	008a3783          	ld	a5,8(s4)
ffffffffc0205390:	010a3803          	ld	a6,16(s4)
ffffffffc0205394:	e83e                	sd	a5,16(sp)
ffffffffc0205396:	0a080c63          	beqz	a6,ffffffffc020544e <stride_dequeue+0x2ee>
ffffffffc020539a:	85c2                	mv	a1,a6
ffffffffc020539c:	856e                	mv	a0,s11
ffffffffc020539e:	ec42                	sd	a6,24(sp)
ffffffffc02053a0:	b85ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02053a4:	58fd                	li	a7,-1
ffffffffc02053a6:	6862                	ld	a6,24(sp)
ffffffffc02053a8:	01151463          	bne	a0,a7,ffffffffc02053b0 <stride_dequeue+0x250>
ffffffffc02053ac:	6e10006f          	j	ffffffffc020628c <stride_dequeue+0x112c>
ffffffffc02053b0:	00883783          	ld	a5,8(a6)
ffffffffc02053b4:	01083303          	ld	t1,16(a6)
ffffffffc02053b8:	ec3e                	sd	a5,24(sp)
ffffffffc02053ba:	08030263          	beqz	t1,ffffffffc020543e <stride_dequeue+0x2de>
ffffffffc02053be:	859a                	mv	a1,t1
ffffffffc02053c0:	856e                	mv	a0,s11
ffffffffc02053c2:	f442                	sd	a6,40(sp)
ffffffffc02053c4:	f01a                	sd	t1,32(sp)
ffffffffc02053c6:	b5fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02053ca:	58fd                	li	a7,-1
ffffffffc02053cc:	7302                	ld	t1,32(sp)
ffffffffc02053ce:	7822                	ld	a6,40(sp)
ffffffffc02053d0:	01151463          	bne	a0,a7,ffffffffc02053d8 <stride_dequeue+0x278>
ffffffffc02053d4:	5ee0106f          	j	ffffffffc02069c2 <stride_dequeue+0x1862>
ffffffffc02053d8:	00833783          	ld	a5,8(t1)
ffffffffc02053dc:	01033983          	ld	s3,16(t1)
ffffffffc02053e0:	f03e                	sd	a5,32(sp)
ffffffffc02053e2:	00099463          	bnez	s3,ffffffffc02053ea <stride_dequeue+0x28a>
ffffffffc02053e6:	26f0106f          	j	ffffffffc0206e54 <stride_dequeue+0x1cf4>
ffffffffc02053ea:	85ce                	mv	a1,s3
ffffffffc02053ec:	856e                	mv	a0,s11
ffffffffc02053ee:	f842                	sd	a6,48(sp)
ffffffffc02053f0:	f41a                	sd	t1,40(sp)
ffffffffc02053f2:	b33ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02053f6:	58fd                	li	a7,-1
ffffffffc02053f8:	7322                	ld	t1,40(sp)
ffffffffc02053fa:	7842                	ld	a6,48(sp)
ffffffffc02053fc:	01151463          	bne	a0,a7,ffffffffc0205404 <stride_dequeue+0x2a4>
ffffffffc0205400:	4d30106f          	j	ffffffffc02070d2 <stride_dequeue+0x1f72>
ffffffffc0205404:	0109b583          	ld	a1,16(s3)
ffffffffc0205408:	0089bb03          	ld	s6,8(s3)
ffffffffc020540c:	856e                	mv	a0,s11
ffffffffc020540e:	f842                	sd	a6,48(sp)
ffffffffc0205410:	f41a                	sd	t1,40(sp)
ffffffffc0205412:	b6fff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205416:	00a9b423          	sd	a0,8(s3)
ffffffffc020541a:	0169b823          	sd	s6,16(s3)
ffffffffc020541e:	7322                	ld	t1,40(sp)
ffffffffc0205420:	7842                	ld	a6,48(sp)
ffffffffc0205422:	010c2b03          	lw	s6,16(s8)
ffffffffc0205426:	c119                	beqz	a0,ffffffffc020542c <stride_dequeue+0x2cc>
ffffffffc0205428:	01353023          	sd	s3,0(a0)
ffffffffc020542c:	7782                	ld	a5,32(sp)
ffffffffc020542e:	01333423          	sd	s3,8(t1)
ffffffffc0205432:	8d9a                	mv	s11,t1
ffffffffc0205434:	00f33823          	sd	a5,16(t1)
ffffffffc0205438:	0069b023          	sd	t1,0(s3)
ffffffffc020543c:	89da                	mv	s3,s6
ffffffffc020543e:	67e2                	ld	a5,24(sp)
ffffffffc0205440:	01b83423          	sd	s11,8(a6)
ffffffffc0205444:	00f83823          	sd	a5,16(a6)
ffffffffc0205448:	010db023          	sd	a6,0(s11)
ffffffffc020544c:	8dc2                	mv	s11,a6
ffffffffc020544e:	67c2                	ld	a5,16(sp)
ffffffffc0205450:	01ba3423          	sd	s11,8(s4)
ffffffffc0205454:	00fa3823          	sd	a5,16(s4)
ffffffffc0205458:	014db023          	sd	s4,0(s11)
ffffffffc020545c:	8dd2                	mv	s11,s4
ffffffffc020545e:	67a2                	ld	a5,8(sp)
ffffffffc0205460:	01bcb423          	sd	s11,8(s9)
ffffffffc0205464:	00fcb823          	sd	a5,16(s9)
ffffffffc0205468:	019db023          	sd	s9,0(s11)
ffffffffc020546c:	8de6                	mv	s11,s9
ffffffffc020546e:	6782                	ld	a5,0(sp)
ffffffffc0205470:	01b4b423          	sd	s11,8(s1)
ffffffffc0205474:	e89c                	sd	a5,16(s1)
ffffffffc0205476:	009db023          	sd	s1,0(s11)
ffffffffc020547a:	00993423          	sd	s1,8(s2)
ffffffffc020547e:	01793823          	sd	s7,16(s2)
ffffffffc0205482:	0124b023          	sd	s2,0(s1)
ffffffffc0205486:	84ca                	mv	s1,s2
ffffffffc0205488:	01a4b023          	sd	s10,0(s1)
ffffffffc020548c:	bda5                	j	ffffffffc0205304 <stride_dequeue+0x1a4>
ffffffffc020548e:	e60499e3          	bnez	s1,ffffffffc0205300 <stride_dequeue+0x1a0>
ffffffffc0205492:	e60d1be3          	bnez	s10,ffffffffc0205308 <stride_dequeue+0x1a8>
ffffffffc0205496:	8aa6                	mv	s5,s1
ffffffffc0205498:	b541                	j	ffffffffc0205318 <stride_dequeue+0x1b8>
ffffffffc020549a:	009d3423          	sd	s1,8(s10)
ffffffffc020549e:	bdad                	j	ffffffffc0205318 <stride_dequeue+0x1b8>
ffffffffc02054a0:	01093d83          	ld	s11,16(s2)
ffffffffc02054a4:	e02a                	sd	a0,0(sp)
ffffffffc02054a6:	00893c83          	ld	s9,8(s2)
ffffffffc02054aa:	100d8d63          	beqz	s11,ffffffffc02055c4 <stride_dequeue+0x464>
ffffffffc02054ae:	85d2                	mv	a1,s4
ffffffffc02054b0:	856e                	mv	a0,s11
ffffffffc02054b2:	a73ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02054b6:	6782                	ld	a5,0(sp)
ffffffffc02054b8:	24f50563          	beq	a0,a5,ffffffffc0205702 <stride_dequeue+0x5a2>
ffffffffc02054bc:	008a3783          	ld	a5,8(s4)
ffffffffc02054c0:	010a3603          	ld	a2,16(s4)
ffffffffc02054c4:	e03e                	sd	a5,0(sp)
ffffffffc02054c6:	0e060863          	beqz	a2,ffffffffc02055b6 <stride_dequeue+0x456>
ffffffffc02054ca:	85b2                	mv	a1,a2
ffffffffc02054cc:	856e                	mv	a0,s11
ffffffffc02054ce:	e432                	sd	a2,8(sp)
ffffffffc02054d0:	a55ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02054d4:	58fd                	li	a7,-1
ffffffffc02054d6:	6622                	ld	a2,8(sp)
ffffffffc02054d8:	7b150f63          	beq	a0,a7,ffffffffc0205c96 <stride_dequeue+0xb36>
ffffffffc02054dc:	661c                	ld	a5,8(a2)
ffffffffc02054de:	01063803          	ld	a6,16(a2)
ffffffffc02054e2:	e43e                	sd	a5,8(sp)
ffffffffc02054e4:	0c080263          	beqz	a6,ffffffffc02055a8 <stride_dequeue+0x448>
ffffffffc02054e8:	85c2                	mv	a1,a6
ffffffffc02054ea:	856e                	mv	a0,s11
ffffffffc02054ec:	ec32                	sd	a2,24(sp)
ffffffffc02054ee:	e842                	sd	a6,16(sp)
ffffffffc02054f0:	a35ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02054f4:	58fd                	li	a7,-1
ffffffffc02054f6:	6842                	ld	a6,16(sp)
ffffffffc02054f8:	6662                	ld	a2,24(sp)
ffffffffc02054fa:	631507e3          	beq	a0,a7,ffffffffc0206328 <stride_dequeue+0x11c8>
ffffffffc02054fe:	00883783          	ld	a5,8(a6)
ffffffffc0205502:	01083303          	ld	t1,16(a6)
ffffffffc0205506:	e83e                	sd	a5,16(sp)
ffffffffc0205508:	08030863          	beqz	t1,ffffffffc0205598 <stride_dequeue+0x438>
ffffffffc020550c:	859a                	mv	a1,t1
ffffffffc020550e:	856e                	mv	a0,s11
ffffffffc0205510:	f442                	sd	a6,40(sp)
ffffffffc0205512:	f032                	sd	a2,32(sp)
ffffffffc0205514:	ec1a                	sd	t1,24(sp)
ffffffffc0205516:	a0fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020551a:	58fd                	li	a7,-1
ffffffffc020551c:	6362                	ld	t1,24(sp)
ffffffffc020551e:	7602                	ld	a2,32(sp)
ffffffffc0205520:	7822                	ld	a6,40(sp)
ffffffffc0205522:	01151463          	bne	a0,a7,ffffffffc020552a <stride_dequeue+0x3ca>
ffffffffc0205526:	3d00106f          	j	ffffffffc02068f6 <stride_dequeue+0x1796>
ffffffffc020552a:	00833783          	ld	a5,8(t1)
ffffffffc020552e:	01033983          	ld	s3,16(t1)
ffffffffc0205532:	ec3e                	sd	a5,24(sp)
ffffffffc0205534:	00099463          	bnez	s3,ffffffffc020553c <stride_dequeue+0x3dc>
ffffffffc0205538:	2af0106f          	j	ffffffffc0206fe6 <stride_dequeue+0x1e86>
ffffffffc020553c:	85ce                	mv	a1,s3
ffffffffc020553e:	856e                	mv	a0,s11
ffffffffc0205540:	f81a                	sd	t1,48(sp)
ffffffffc0205542:	f442                	sd	a6,40(sp)
ffffffffc0205544:	f032                	sd	a2,32(sp)
ffffffffc0205546:	9dfff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020554a:	58fd                	li	a7,-1
ffffffffc020554c:	7602                	ld	a2,32(sp)
ffffffffc020554e:	7822                	ld	a6,40(sp)
ffffffffc0205550:	7342                	ld	t1,48(sp)
ffffffffc0205552:	01151463          	bne	a0,a7,ffffffffc020555a <stride_dequeue+0x3fa>
ffffffffc0205556:	3510106f          	j	ffffffffc02070a6 <stride_dequeue+0x1f46>
ffffffffc020555a:	0109b583          	ld	a1,16(s3)
ffffffffc020555e:	0089bb03          	ld	s6,8(s3)
ffffffffc0205562:	856e                	mv	a0,s11
ffffffffc0205564:	f81a                	sd	t1,48(sp)
ffffffffc0205566:	f442                	sd	a6,40(sp)
ffffffffc0205568:	f032                	sd	a2,32(sp)
ffffffffc020556a:	a17ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020556e:	00a9b423          	sd	a0,8(s3)
ffffffffc0205572:	0169b823          	sd	s6,16(s3)
ffffffffc0205576:	7602                	ld	a2,32(sp)
ffffffffc0205578:	7822                	ld	a6,40(sp)
ffffffffc020557a:	7342                	ld	t1,48(sp)
ffffffffc020557c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205580:	c119                	beqz	a0,ffffffffc0205586 <stride_dequeue+0x426>
ffffffffc0205582:	01353023          	sd	s3,0(a0)
ffffffffc0205586:	67e2                	ld	a5,24(sp)
ffffffffc0205588:	01333423          	sd	s3,8(t1)
ffffffffc020558c:	8d9a                	mv	s11,t1
ffffffffc020558e:	00f33823          	sd	a5,16(t1)
ffffffffc0205592:	0069b023          	sd	t1,0(s3)
ffffffffc0205596:	89da                	mv	s3,s6
ffffffffc0205598:	67c2                	ld	a5,16(sp)
ffffffffc020559a:	01b83423          	sd	s11,8(a6)
ffffffffc020559e:	00f83823          	sd	a5,16(a6)
ffffffffc02055a2:	010db023          	sd	a6,0(s11)
ffffffffc02055a6:	8dc2                	mv	s11,a6
ffffffffc02055a8:	67a2                	ld	a5,8(sp)
ffffffffc02055aa:	01b63423          	sd	s11,8(a2)
ffffffffc02055ae:	ea1c                	sd	a5,16(a2)
ffffffffc02055b0:	00cdb023          	sd	a2,0(s11)
ffffffffc02055b4:	8db2                	mv	s11,a2
ffffffffc02055b6:	6782                	ld	a5,0(sp)
ffffffffc02055b8:	01ba3423          	sd	s11,8(s4)
ffffffffc02055bc:	00fa3823          	sd	a5,16(s4)
ffffffffc02055c0:	014db023          	sd	s4,0(s11)
ffffffffc02055c4:	01493423          	sd	s4,8(s2)
ffffffffc02055c8:	01993823          	sd	s9,16(s2)
ffffffffc02055cc:	012a3023          	sd	s2,0(s4)
ffffffffc02055d0:	b315                	j	ffffffffc02052f4 <stride_dequeue+0x194>
ffffffffc02055d2:	84ca                	mv	s1,s2
ffffffffc02055d4:	01a4b023          	sd	s10,0(s1)
ffffffffc02055d8:	b335                	j	ffffffffc0205304 <stride_dequeue+0x1a4>
ffffffffc02055da:	008db783          	ld	a5,8(s11)
ffffffffc02055de:	010dbc83          	ld	s9,16(s11)
ffffffffc02055e2:	e42a                	sd	a0,8(sp)
ffffffffc02055e4:	e03e                	sd	a5,0(sp)
ffffffffc02055e6:	100c8563          	beqz	s9,ffffffffc02056f0 <stride_dequeue+0x590>
ffffffffc02055ea:	85a6                	mv	a1,s1
ffffffffc02055ec:	8566                	mv	a0,s9
ffffffffc02055ee:	937ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02055f2:	67a2                	ld	a5,8(sp)
ffffffffc02055f4:	4cf50e63          	beq	a0,a5,ffffffffc0205ad0 <stride_dequeue+0x970>
ffffffffc02055f8:	649c                	ld	a5,8(s1)
ffffffffc02055fa:	0104ba03          	ld	s4,16(s1)
ffffffffc02055fe:	e43e                	sd	a5,8(sp)
ffffffffc0205600:	0e0a0263          	beqz	s4,ffffffffc02056e4 <stride_dequeue+0x584>
ffffffffc0205604:	85d2                	mv	a1,s4
ffffffffc0205606:	8566                	mv	a0,s9
ffffffffc0205608:	91dff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020560c:	58fd                	li	a7,-1
ffffffffc020560e:	0d1505e3          	beq	a0,a7,ffffffffc0205ed8 <stride_dequeue+0xd78>
ffffffffc0205612:	008a3783          	ld	a5,8(s4)
ffffffffc0205616:	010a3803          	ld	a6,16(s4)
ffffffffc020561a:	e83e                	sd	a5,16(sp)
ffffffffc020561c:	0a080c63          	beqz	a6,ffffffffc02056d4 <stride_dequeue+0x574>
ffffffffc0205620:	85c2                	mv	a1,a6
ffffffffc0205622:	8566                	mv	a0,s9
ffffffffc0205624:	ec42                	sd	a6,24(sp)
ffffffffc0205626:	8ffff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020562a:	58fd                	li	a7,-1
ffffffffc020562c:	6862                	ld	a6,24(sp)
ffffffffc020562e:	01151463          	bne	a0,a7,ffffffffc0205636 <stride_dequeue+0x4d6>
ffffffffc0205632:	07c0106f          	j	ffffffffc02066ae <stride_dequeue+0x154e>
ffffffffc0205636:	00883783          	ld	a5,8(a6)
ffffffffc020563a:	01083983          	ld	s3,16(a6)
ffffffffc020563e:	ec3e                	sd	a5,24(sp)
ffffffffc0205640:	00099463          	bnez	s3,ffffffffc0205648 <stride_dequeue+0x4e8>
ffffffffc0205644:	2bb0106f          	j	ffffffffc02070fe <stride_dequeue+0x1f9e>
ffffffffc0205648:	85ce                	mv	a1,s3
ffffffffc020564a:	8566                	mv	a0,s9
ffffffffc020564c:	f042                	sd	a6,32(sp)
ffffffffc020564e:	8d7ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205652:	58fd                	li	a7,-1
ffffffffc0205654:	7802                	ld	a6,32(sp)
ffffffffc0205656:	01151463          	bne	a0,a7,ffffffffc020565e <stride_dequeue+0x4fe>
ffffffffc020565a:	05f0106f          	j	ffffffffc0206eb8 <stride_dequeue+0x1d58>
ffffffffc020565e:	0089b783          	ld	a5,8(s3)
ffffffffc0205662:	0109be03          	ld	t3,16(s3)
ffffffffc0205666:	f03e                	sd	a5,32(sp)
ffffffffc0205668:	040e0663          	beqz	t3,ffffffffc02056b4 <stride_dequeue+0x554>
ffffffffc020566c:	85f2                	mv	a1,t3
ffffffffc020566e:	8566                	mv	a0,s9
ffffffffc0205670:	f842                	sd	a6,48(sp)
ffffffffc0205672:	f472                	sd	t3,40(sp)
ffffffffc0205674:	8b1ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205678:	58fd                	li	a7,-1
ffffffffc020567a:	7e22                	ld	t3,40(sp)
ffffffffc020567c:	7842                	ld	a6,48(sp)
ffffffffc020567e:	01151463          	bne	a0,a7,ffffffffc0205686 <stride_dequeue+0x526>
ffffffffc0205682:	4e70106f          	j	ffffffffc0207368 <stride_dequeue+0x2208>
ffffffffc0205686:	010e3583          	ld	a1,16(t3)
ffffffffc020568a:	8566                	mv	a0,s9
ffffffffc020568c:	008e3b03          	ld	s6,8(t3)
ffffffffc0205690:	f842                	sd	a6,48(sp)
ffffffffc0205692:	f472                	sd	t3,40(sp)
ffffffffc0205694:	8edff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205698:	7e22                	ld	t3,40(sp)
ffffffffc020569a:	7842                	ld	a6,48(sp)
ffffffffc020569c:	016e3823          	sd	s6,16(t3)
ffffffffc02056a0:	00ae3423          	sd	a0,8(t3)
ffffffffc02056a4:	010c2b03          	lw	s6,16(s8)
ffffffffc02056a8:	e119                	bnez	a0,ffffffffc02056ae <stride_dequeue+0x54e>
ffffffffc02056aa:	7bb0106f          	j	ffffffffc0207664 <stride_dequeue+0x2504>
ffffffffc02056ae:	01c53023          	sd	t3,0(a0)
ffffffffc02056b2:	8cf2                	mv	s9,t3
ffffffffc02056b4:	7782                	ld	a5,32(sp)
ffffffffc02056b6:	0199b423          	sd	s9,8(s3)
ffffffffc02056ba:	00f9b823          	sd	a5,16(s3)
ffffffffc02056be:	013cb023          	sd	s3,0(s9)
ffffffffc02056c2:	67e2                	ld	a5,24(sp)
ffffffffc02056c4:	01383423          	sd	s3,8(a6)
ffffffffc02056c8:	8cc2                	mv	s9,a6
ffffffffc02056ca:	00f83823          	sd	a5,16(a6)
ffffffffc02056ce:	0109b023          	sd	a6,0(s3)
ffffffffc02056d2:	89da                	mv	s3,s6
ffffffffc02056d4:	67c2                	ld	a5,16(sp)
ffffffffc02056d6:	019a3423          	sd	s9,8(s4)
ffffffffc02056da:	00fa3823          	sd	a5,16(s4)
ffffffffc02056de:	014cb023          	sd	s4,0(s9)
ffffffffc02056e2:	8cd2                	mv	s9,s4
ffffffffc02056e4:	67a2                	ld	a5,8(sp)
ffffffffc02056e6:	0194b423          	sd	s9,8(s1)
ffffffffc02056ea:	e89c                	sd	a5,16(s1)
ffffffffc02056ec:	009cb023          	sd	s1,0(s9)
ffffffffc02056f0:	6782                	ld	a5,0(sp)
ffffffffc02056f2:	009db423          	sd	s1,8(s11)
ffffffffc02056f6:	00fdb823          	sd	a5,16(s11)
ffffffffc02056fa:	01b4b023          	sd	s11,0(s1)
ffffffffc02056fe:	84ee                	mv	s1,s11
ffffffffc0205700:	bbad                	j	ffffffffc020547a <stride_dequeue+0x31a>
ffffffffc0205702:	008db783          	ld	a5,8(s11)
ffffffffc0205706:	010db603          	ld	a2,16(s11)
ffffffffc020570a:	e03e                	sd	a5,0(sp)
ffffffffc020570c:	0e060963          	beqz	a2,ffffffffc02057fe <stride_dequeue+0x69e>
ffffffffc0205710:	8532                	mv	a0,a2
ffffffffc0205712:	85d2                	mv	a1,s4
ffffffffc0205714:	e432                	sd	a2,8(sp)
ffffffffc0205716:	80fff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020571a:	58fd                	li	a7,-1
ffffffffc020571c:	6622                	ld	a2,8(sp)
ffffffffc020571e:	091504e3          	beq	a0,a7,ffffffffc0205fa6 <stride_dequeue+0xe46>
ffffffffc0205722:	008a3783          	ld	a5,8(s4)
ffffffffc0205726:	010a3803          	ld	a6,16(s4)
ffffffffc020572a:	e43e                	sd	a5,8(sp)
ffffffffc020572c:	0c080263          	beqz	a6,ffffffffc02057f0 <stride_dequeue+0x690>
ffffffffc0205730:	85c2                	mv	a1,a6
ffffffffc0205732:	8532                	mv	a0,a2
ffffffffc0205734:	ec42                	sd	a6,24(sp)
ffffffffc0205736:	e832                	sd	a2,16(sp)
ffffffffc0205738:	fecff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020573c:	58fd                	li	a7,-1
ffffffffc020573e:	6642                	ld	a2,16(sp)
ffffffffc0205740:	6862                	ld	a6,24(sp)
ffffffffc0205742:	01151463          	bne	a0,a7,ffffffffc020574a <stride_dequeue+0x5ea>
ffffffffc0205746:	00a0106f          	j	ffffffffc0206750 <stride_dequeue+0x15f0>
ffffffffc020574a:	00883783          	ld	a5,8(a6)
ffffffffc020574e:	01083983          	ld	s3,16(a6)
ffffffffc0205752:	e83e                	sd	a5,16(sp)
ffffffffc0205754:	00099463          	bnez	s3,ffffffffc020575c <stride_dequeue+0x5fc>
ffffffffc0205758:	1e50106f          	j	ffffffffc020713c <stride_dequeue+0x1fdc>
ffffffffc020575c:	8532                	mv	a0,a2
ffffffffc020575e:	85ce                	mv	a1,s3
ffffffffc0205760:	f042                	sd	a6,32(sp)
ffffffffc0205762:	ec32                	sd	a2,24(sp)
ffffffffc0205764:	fc0ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205768:	58fd                	li	a7,-1
ffffffffc020576a:	6662                	ld	a2,24(sp)
ffffffffc020576c:	7802                	ld	a6,32(sp)
ffffffffc020576e:	01151463          	bne	a0,a7,ffffffffc0205776 <stride_dequeue+0x616>
ffffffffc0205772:	4fc0106f          	j	ffffffffc0206c6e <stride_dequeue+0x1b0e>
ffffffffc0205776:	0089b783          	ld	a5,8(s3)
ffffffffc020577a:	0109be03          	ld	t3,16(s3)
ffffffffc020577e:	ec3e                	sd	a5,24(sp)
ffffffffc0205780:	040e0863          	beqz	t3,ffffffffc02057d0 <stride_dequeue+0x670>
ffffffffc0205784:	85f2                	mv	a1,t3
ffffffffc0205786:	8532                	mv	a0,a2
ffffffffc0205788:	f842                	sd	a6,48(sp)
ffffffffc020578a:	f472                	sd	t3,40(sp)
ffffffffc020578c:	f032                	sd	a2,32(sp)
ffffffffc020578e:	f96ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205792:	7842                	ld	a6,48(sp)
ffffffffc0205794:	7e22                	ld	t3,40(sp)
ffffffffc0205796:	58fd                	li	a7,-1
ffffffffc0205798:	f442                	sd	a6,40(sp)
ffffffffc020579a:	7602                	ld	a2,32(sp)
ffffffffc020579c:	01151463          	bne	a0,a7,ffffffffc02057a4 <stride_dequeue+0x644>
ffffffffc02057a0:	37b0106f          	j	ffffffffc020731a <stride_dequeue+0x21ba>
ffffffffc02057a4:	010e3583          	ld	a1,16(t3)
ffffffffc02057a8:	8532                	mv	a0,a2
ffffffffc02057aa:	008e3b03          	ld	s6,8(t3)
ffffffffc02057ae:	f072                	sd	t3,32(sp)
ffffffffc02057b0:	fd0ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02057b4:	7e02                	ld	t3,32(sp)
ffffffffc02057b6:	7822                	ld	a6,40(sp)
ffffffffc02057b8:	016e3823          	sd	s6,16(t3)
ffffffffc02057bc:	00ae3423          	sd	a0,8(t3)
ffffffffc02057c0:	010c2b03          	lw	s6,16(s8)
ffffffffc02057c4:	e119                	bnez	a0,ffffffffc02057ca <stride_dequeue+0x66a>
ffffffffc02057c6:	7090106f          	j	ffffffffc02076ce <stride_dequeue+0x256e>
ffffffffc02057ca:	01c53023          	sd	t3,0(a0)
ffffffffc02057ce:	8672                	mv	a2,t3
ffffffffc02057d0:	67e2                	ld	a5,24(sp)
ffffffffc02057d2:	00c9b423          	sd	a2,8(s3)
ffffffffc02057d6:	00f9b823          	sd	a5,16(s3)
ffffffffc02057da:	01363023          	sd	s3,0(a2)
ffffffffc02057de:	67c2                	ld	a5,16(sp)
ffffffffc02057e0:	01383423          	sd	s3,8(a6)
ffffffffc02057e4:	8642                	mv	a2,a6
ffffffffc02057e6:	00f83823          	sd	a5,16(a6)
ffffffffc02057ea:	0109b023          	sd	a6,0(s3)
ffffffffc02057ee:	89da                	mv	s3,s6
ffffffffc02057f0:	67a2                	ld	a5,8(sp)
ffffffffc02057f2:	00ca3423          	sd	a2,8(s4)
ffffffffc02057f6:	00fa3823          	sd	a5,16(s4)
ffffffffc02057fa:	01463023          	sd	s4,0(a2)
ffffffffc02057fe:	6782                	ld	a5,0(sp)
ffffffffc0205800:	014db423          	sd	s4,8(s11)
ffffffffc0205804:	00fdb823          	sd	a5,16(s11)
ffffffffc0205808:	01ba3023          	sd	s11,0(s4)
ffffffffc020580c:	8a6e                	mv	s4,s11
ffffffffc020580e:	bb5d                	j	ffffffffc02055c4 <stride_dequeue+0x464>
ffffffffc0205810:	008db783          	ld	a5,8(s11)
ffffffffc0205814:	010dba03          	ld	s4,16(s11)
ffffffffc0205818:	e43e                	sd	a5,8(sp)
ffffffffc020581a:	0e0a0163          	beqz	s4,ffffffffc02058fc <stride_dequeue+0x79c>
ffffffffc020581e:	85e6                	mv	a1,s9
ffffffffc0205820:	8552                	mv	a0,s4
ffffffffc0205822:	f02ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205826:	58fd                	li	a7,-1
ffffffffc0205828:	05150de3          	beq	a0,a7,ffffffffc0206082 <stride_dequeue+0xf22>
ffffffffc020582c:	008cb783          	ld	a5,8(s9)
ffffffffc0205830:	010cb803          	ld	a6,16(s9)
ffffffffc0205834:	e83e                	sd	a5,16(sp)
ffffffffc0205836:	0a080c63          	beqz	a6,ffffffffc02058ee <stride_dequeue+0x78e>
ffffffffc020583a:	85c2                	mv	a1,a6
ffffffffc020583c:	8552                	mv	a0,s4
ffffffffc020583e:	ec42                	sd	a6,24(sp)
ffffffffc0205840:	ee4ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205844:	58fd                	li	a7,-1
ffffffffc0205846:	6862                	ld	a6,24(sp)
ffffffffc0205848:	01151463          	bne	a0,a7,ffffffffc0205850 <stride_dequeue+0x6f0>
ffffffffc020584c:	7ab0006f          	j	ffffffffc02067f6 <stride_dequeue+0x1696>
ffffffffc0205850:	00883783          	ld	a5,8(a6)
ffffffffc0205854:	01083983          	ld	s3,16(a6)
ffffffffc0205858:	ec3e                	sd	a5,24(sp)
ffffffffc020585a:	00099463          	bnez	s3,ffffffffc0205862 <stride_dequeue+0x702>
ffffffffc020585e:	0cd0106f          	j	ffffffffc020712a <stride_dequeue+0x1fca>
ffffffffc0205862:	85ce                	mv	a1,s3
ffffffffc0205864:	8552                	mv	a0,s4
ffffffffc0205866:	f042                	sd	a6,32(sp)
ffffffffc0205868:	ebcff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020586c:	58fd                	li	a7,-1
ffffffffc020586e:	7802                	ld	a6,32(sp)
ffffffffc0205870:	01151463          	bne	a0,a7,ffffffffc0205878 <stride_dequeue+0x718>
ffffffffc0205874:	39c0106f          	j	ffffffffc0206c10 <stride_dequeue+0x1ab0>
ffffffffc0205878:	0089b783          	ld	a5,8(s3)
ffffffffc020587c:	0109be03          	ld	t3,16(s3)
ffffffffc0205880:	f03e                	sd	a5,32(sp)
ffffffffc0205882:	040e0663          	beqz	t3,ffffffffc02058ce <stride_dequeue+0x76e>
ffffffffc0205886:	85f2                	mv	a1,t3
ffffffffc0205888:	8552                	mv	a0,s4
ffffffffc020588a:	f842                	sd	a6,48(sp)
ffffffffc020588c:	f472                	sd	t3,40(sp)
ffffffffc020588e:	e96ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205892:	58fd                	li	a7,-1
ffffffffc0205894:	7e22                	ld	t3,40(sp)
ffffffffc0205896:	7842                	ld	a6,48(sp)
ffffffffc0205898:	01151463          	bne	a0,a7,ffffffffc02058a0 <stride_dequeue+0x740>
ffffffffc020589c:	2f90106f          	j	ffffffffc0207394 <stride_dequeue+0x2234>
ffffffffc02058a0:	010e3583          	ld	a1,16(t3)
ffffffffc02058a4:	8552                	mv	a0,s4
ffffffffc02058a6:	008e3b03          	ld	s6,8(t3)
ffffffffc02058aa:	f842                	sd	a6,48(sp)
ffffffffc02058ac:	f472                	sd	t3,40(sp)
ffffffffc02058ae:	ed2ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02058b2:	7e22                	ld	t3,40(sp)
ffffffffc02058b4:	7842                	ld	a6,48(sp)
ffffffffc02058b6:	016e3823          	sd	s6,16(t3)
ffffffffc02058ba:	00ae3423          	sd	a0,8(t3)
ffffffffc02058be:	010c2b03          	lw	s6,16(s8)
ffffffffc02058c2:	e119                	bnez	a0,ffffffffc02058c8 <stride_dequeue+0x768>
ffffffffc02058c4:	5a70106f          	j	ffffffffc020766a <stride_dequeue+0x250a>
ffffffffc02058c8:	01c53023          	sd	t3,0(a0)
ffffffffc02058cc:	8a72                	mv	s4,t3
ffffffffc02058ce:	7782                	ld	a5,32(sp)
ffffffffc02058d0:	0149b423          	sd	s4,8(s3)
ffffffffc02058d4:	00f9b823          	sd	a5,16(s3)
ffffffffc02058d8:	013a3023          	sd	s3,0(s4)
ffffffffc02058dc:	67e2                	ld	a5,24(sp)
ffffffffc02058de:	01383423          	sd	s3,8(a6)
ffffffffc02058e2:	8a42                	mv	s4,a6
ffffffffc02058e4:	00f83823          	sd	a5,16(a6)
ffffffffc02058e8:	0109b023          	sd	a6,0(s3)
ffffffffc02058ec:	89da                	mv	s3,s6
ffffffffc02058ee:	67c2                	ld	a5,16(sp)
ffffffffc02058f0:	014cb423          	sd	s4,8(s9)
ffffffffc02058f4:	00fcb823          	sd	a5,16(s9)
ffffffffc02058f8:	019a3023          	sd	s9,0(s4)
ffffffffc02058fc:	67a2                	ld	a5,8(sp)
ffffffffc02058fe:	019db423          	sd	s9,8(s11)
ffffffffc0205902:	00fdb823          	sd	a5,16(s11)
ffffffffc0205906:	01bcb023          	sd	s11,0(s9)
ffffffffc020590a:	b695                	j	ffffffffc020546e <stride_dequeue+0x30e>
ffffffffc020590c:	00893783          	ld	a5,8(s2)
ffffffffc0205910:	01093883          	ld	a7,16(s2)
ffffffffc0205914:	ec2a                	sd	a0,24(sp)
ffffffffc0205916:	e83e                	sd	a5,16(sp)
ffffffffc0205918:	0a088963          	beqz	a7,ffffffffc02059ca <stride_dequeue+0x86a>
ffffffffc020591c:	8546                	mv	a0,a7
ffffffffc020591e:	85e6                	mv	a1,s9
ffffffffc0205920:	f046                	sd	a7,32(sp)
ffffffffc0205922:	e02ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205926:	6862                	ld	a6,24(sp)
ffffffffc0205928:	7882                	ld	a7,32(sp)
ffffffffc020592a:	030504e3          	beq	a0,a6,ffffffffc0206152 <stride_dequeue+0xff2>
ffffffffc020592e:	008cb783          	ld	a5,8(s9)
ffffffffc0205932:	010cb303          	ld	t1,16(s9)
ffffffffc0205936:	f042                	sd	a6,32(sp)
ffffffffc0205938:	ec3e                	sd	a5,24(sp)
ffffffffc020593a:	08030163          	beqz	t1,ffffffffc02059bc <stride_dequeue+0x85c>
ffffffffc020593e:	859a                	mv	a1,t1
ffffffffc0205940:	8546                	mv	a0,a7
ffffffffc0205942:	f81a                	sd	t1,48(sp)
ffffffffc0205944:	f446                	sd	a7,40(sp)
ffffffffc0205946:	ddeff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020594a:	7802                	ld	a6,32(sp)
ffffffffc020594c:	78a2                	ld	a7,40(sp)
ffffffffc020594e:	7342                	ld	t1,48(sp)
ffffffffc0205950:	01051463          	bne	a0,a6,ffffffffc0205958 <stride_dequeue+0x7f8>
ffffffffc0205954:	0d00106f          	j	ffffffffc0206a24 <stride_dequeue+0x18c4>
ffffffffc0205958:	00833783          	ld	a5,8(t1)
ffffffffc020595c:	01033983          	ld	s3,16(t1)
ffffffffc0205960:	f442                	sd	a6,40(sp)
ffffffffc0205962:	f03e                	sd	a5,32(sp)
ffffffffc0205964:	00099463          	bnez	s3,ffffffffc020596c <stride_dequeue+0x80c>
ffffffffc0205968:	6720106f          	j	ffffffffc0206fda <stride_dequeue+0x1e7a>
ffffffffc020596c:	8546                	mv	a0,a7
ffffffffc020596e:	85ce                	mv	a1,s3
ffffffffc0205970:	fc1a                	sd	t1,56(sp)
ffffffffc0205972:	f846                	sd	a7,48(sp)
ffffffffc0205974:	db0ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205978:	7822                	ld	a6,40(sp)
ffffffffc020597a:	78c2                	ld	a7,48(sp)
ffffffffc020597c:	7362                	ld	t1,56(sp)
ffffffffc020597e:	01051463          	bne	a0,a6,ffffffffc0205986 <stride_dequeue+0x826>
ffffffffc0205982:	6700106f          	j	ffffffffc0206ff2 <stride_dequeue+0x1e92>
ffffffffc0205986:	0109b583          	ld	a1,16(s3)
ffffffffc020598a:	0089bb03          	ld	s6,8(s3)
ffffffffc020598e:	8546                	mv	a0,a7
ffffffffc0205990:	f41a                	sd	t1,40(sp)
ffffffffc0205992:	deeff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205996:	00a9b423          	sd	a0,8(s3)
ffffffffc020599a:	0169b823          	sd	s6,16(s3)
ffffffffc020599e:	7322                	ld	t1,40(sp)
ffffffffc02059a0:	010c2b03          	lw	s6,16(s8)
ffffffffc02059a4:	c119                	beqz	a0,ffffffffc02059aa <stride_dequeue+0x84a>
ffffffffc02059a6:	01353023          	sd	s3,0(a0)
ffffffffc02059aa:	7782                	ld	a5,32(sp)
ffffffffc02059ac:	01333423          	sd	s3,8(t1)
ffffffffc02059b0:	889a                	mv	a7,t1
ffffffffc02059b2:	00f33823          	sd	a5,16(t1)
ffffffffc02059b6:	0069b023          	sd	t1,0(s3)
ffffffffc02059ba:	89da                	mv	s3,s6
ffffffffc02059bc:	67e2                	ld	a5,24(sp)
ffffffffc02059be:	011cb423          	sd	a7,8(s9)
ffffffffc02059c2:	00fcb823          	sd	a5,16(s9)
ffffffffc02059c6:	0198b023          	sd	s9,0(a7)
ffffffffc02059ca:	67c2                	ld	a5,16(sp)
ffffffffc02059cc:	01993423          	sd	s9,8(s2)
ffffffffc02059d0:	00f93823          	sd	a5,16(s2)
ffffffffc02059d4:	012cb023          	sd	s2,0(s9)
ffffffffc02059d8:	b8f5                	j	ffffffffc02052d4 <stride_dequeue+0x174>
ffffffffc02059da:	00893783          	ld	a5,8(s2)
ffffffffc02059de:	01093c83          	ld	s9,16(s2)
ffffffffc02059e2:	e43e                	sd	a5,8(sp)
ffffffffc02059e4:	0c0c8d63          	beqz	s9,ffffffffc0205abe <stride_dequeue+0x95e>
ffffffffc02059e8:	85ee                	mv	a1,s11
ffffffffc02059ea:	8566                	mv	a0,s9
ffffffffc02059ec:	d38ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02059f0:	58fd                	li	a7,-1
ffffffffc02059f2:	39150063          	beq	a0,a7,ffffffffc0205d72 <stride_dequeue+0xc12>
ffffffffc02059f6:	008db783          	ld	a5,8(s11)
ffffffffc02059fa:	010db803          	ld	a6,16(s11)
ffffffffc02059fe:	e83e                	sd	a5,16(sp)
ffffffffc0205a00:	0a080863          	beqz	a6,ffffffffc0205ab0 <stride_dequeue+0x950>
ffffffffc0205a04:	85c2                	mv	a1,a6
ffffffffc0205a06:	8566                	mv	a0,s9
ffffffffc0205a08:	ec42                	sd	a6,24(sp)
ffffffffc0205a0a:	d1aff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205a0e:	58fd                	li	a7,-1
ffffffffc0205a10:	6862                	ld	a6,24(sp)
ffffffffc0205a12:	7d150f63          	beq	a0,a7,ffffffffc02061f0 <stride_dequeue+0x1090>
ffffffffc0205a16:	00883783          	ld	a5,8(a6)
ffffffffc0205a1a:	01083303          	ld	t1,16(a6)
ffffffffc0205a1e:	ec3e                	sd	a5,24(sp)
ffffffffc0205a20:	08030063          	beqz	t1,ffffffffc0205aa0 <stride_dequeue+0x940>
ffffffffc0205a24:	859a                	mv	a1,t1
ffffffffc0205a26:	8566                	mv	a0,s9
ffffffffc0205a28:	f442                	sd	a6,40(sp)
ffffffffc0205a2a:	f01a                	sd	t1,32(sp)
ffffffffc0205a2c:	cf8ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205a30:	58fd                	li	a7,-1
ffffffffc0205a32:	7302                	ld	t1,32(sp)
ffffffffc0205a34:	7822                	ld	a6,40(sp)
ffffffffc0205a36:	65150fe3          	beq	a0,a7,ffffffffc0206894 <stride_dequeue+0x1734>
ffffffffc0205a3a:	00833783          	ld	a5,8(t1)
ffffffffc0205a3e:	01033983          	ld	s3,16(t1)
ffffffffc0205a42:	f03e                	sd	a5,32(sp)
ffffffffc0205a44:	00099463          	bnez	s3,ffffffffc0205a4c <stride_dequeue+0x8ec>
ffffffffc0205a48:	5980106f          	j	ffffffffc0206fe0 <stride_dequeue+0x1e80>
ffffffffc0205a4c:	85ce                	mv	a1,s3
ffffffffc0205a4e:	8566                	mv	a0,s9
ffffffffc0205a50:	f81a                	sd	t1,48(sp)
ffffffffc0205a52:	f442                	sd	a6,40(sp)
ffffffffc0205a54:	cd0ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205a58:	58fd                	li	a7,-1
ffffffffc0205a5a:	7822                	ld	a6,40(sp)
ffffffffc0205a5c:	7342                	ld	t1,48(sp)
ffffffffc0205a5e:	01151463          	bne	a0,a7,ffffffffc0205a66 <stride_dequeue+0x906>
ffffffffc0205a62:	5ea0106f          	j	ffffffffc020704c <stride_dequeue+0x1eec>
ffffffffc0205a66:	0109b583          	ld	a1,16(s3)
ffffffffc0205a6a:	0089bb03          	ld	s6,8(s3)
ffffffffc0205a6e:	8566                	mv	a0,s9
ffffffffc0205a70:	f81a                	sd	t1,48(sp)
ffffffffc0205a72:	f442                	sd	a6,40(sp)
ffffffffc0205a74:	d0cff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205a78:	00a9b423          	sd	a0,8(s3)
ffffffffc0205a7c:	0169b823          	sd	s6,16(s3)
ffffffffc0205a80:	7822                	ld	a6,40(sp)
ffffffffc0205a82:	7342                	ld	t1,48(sp)
ffffffffc0205a84:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a88:	c119                	beqz	a0,ffffffffc0205a8e <stride_dequeue+0x92e>
ffffffffc0205a8a:	01353023          	sd	s3,0(a0)
ffffffffc0205a8e:	7782                	ld	a5,32(sp)
ffffffffc0205a90:	01333423          	sd	s3,8(t1)
ffffffffc0205a94:	8c9a                	mv	s9,t1
ffffffffc0205a96:	00f33823          	sd	a5,16(t1)
ffffffffc0205a9a:	0069b023          	sd	t1,0(s3)
ffffffffc0205a9e:	89da                	mv	s3,s6
ffffffffc0205aa0:	67e2                	ld	a5,24(sp)
ffffffffc0205aa2:	01983423          	sd	s9,8(a6)
ffffffffc0205aa6:	00f83823          	sd	a5,16(a6)
ffffffffc0205aaa:	010cb023          	sd	a6,0(s9)
ffffffffc0205aae:	8cc2                	mv	s9,a6
ffffffffc0205ab0:	67c2                	ld	a5,16(sp)
ffffffffc0205ab2:	019db423          	sd	s9,8(s11)
ffffffffc0205ab6:	00fdb823          	sd	a5,16(s11)
ffffffffc0205aba:	01bcb023          	sd	s11,0(s9)
ffffffffc0205abe:	67a2                	ld	a5,8(sp)
ffffffffc0205ac0:	01b93423          	sd	s11,8(s2)
ffffffffc0205ac4:	00f93823          	sd	a5,16(s2)
ffffffffc0205ac8:	012db023          	sd	s2,0(s11)
ffffffffc0205acc:	819ff06f          	j	ffffffffc02052e4 <stride_dequeue+0x184>
ffffffffc0205ad0:	008cb783          	ld	a5,8(s9)
ffffffffc0205ad4:	010cba03          	ld	s4,16(s9)
ffffffffc0205ad8:	e43e                	sd	a5,8(sp)
ffffffffc0205ada:	0c0a0d63          	beqz	s4,ffffffffc0205bb4 <stride_dequeue+0xa54>
ffffffffc0205ade:	85a6                	mv	a1,s1
ffffffffc0205ae0:	8552                	mv	a0,s4
ffffffffc0205ae2:	c42ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205ae6:	58fd                	li	a7,-1
ffffffffc0205ae8:	151500e3          	beq	a0,a7,ffffffffc0206428 <stride_dequeue+0x12c8>
ffffffffc0205aec:	649c                	ld	a5,8(s1)
ffffffffc0205aee:	0104b983          	ld	s3,16(s1)
ffffffffc0205af2:	e83e                	sd	a5,16(sp)
ffffffffc0205af4:	00099463          	bnez	s3,ffffffffc0205afc <stride_dequeue+0x99c>
ffffffffc0205af8:	4f40106f          	j	ffffffffc0206fec <stride_dequeue+0x1e8c>
ffffffffc0205afc:	85ce                	mv	a1,s3
ffffffffc0205afe:	8552                	mv	a0,s4
ffffffffc0205b00:	c24ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205b04:	58fd                	li	a7,-1
ffffffffc0205b06:	01151463          	bne	a0,a7,ffffffffc0205b0e <stride_dequeue+0x9ae>
ffffffffc0205b0a:	0b00106f          	j	ffffffffc0206bba <stride_dequeue+0x1a5a>
ffffffffc0205b0e:	0089b783          	ld	a5,8(s3)
ffffffffc0205b12:	0109b303          	ld	t1,16(s3)
ffffffffc0205b16:	ec3e                	sd	a5,24(sp)
ffffffffc0205b18:	08030063          	beqz	t1,ffffffffc0205b98 <stride_dequeue+0xa38>
ffffffffc0205b1c:	859a                	mv	a1,t1
ffffffffc0205b1e:	8552                	mv	a0,s4
ffffffffc0205b20:	f01a                	sd	t1,32(sp)
ffffffffc0205b22:	c02ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205b26:	58fd                	li	a7,-1
ffffffffc0205b28:	7302                	ld	t1,32(sp)
ffffffffc0205b2a:	01151463          	bne	a0,a7,ffffffffc0205b32 <stride_dequeue+0x9d2>
ffffffffc0205b2e:	0130106f          	j	ffffffffc0207340 <stride_dequeue+0x21e0>
ffffffffc0205b32:	00833783          	ld	a5,8(t1)
ffffffffc0205b36:	01033e03          	ld	t3,16(t1)
ffffffffc0205b3a:	f03e                	sd	a5,32(sp)
ffffffffc0205b3c:	040e0663          	beqz	t3,ffffffffc0205b88 <stride_dequeue+0xa28>
ffffffffc0205b40:	85f2                	mv	a1,t3
ffffffffc0205b42:	8552                	mv	a0,s4
ffffffffc0205b44:	f81a                	sd	t1,48(sp)
ffffffffc0205b46:	f472                	sd	t3,40(sp)
ffffffffc0205b48:	bdcff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205b4c:	58fd                	li	a7,-1
ffffffffc0205b4e:	7e22                	ld	t3,40(sp)
ffffffffc0205b50:	7342                	ld	t1,48(sp)
ffffffffc0205b52:	01151463          	bne	a0,a7,ffffffffc0205b5a <stride_dequeue+0x9fa>
ffffffffc0205b56:	53d0106f          	j	ffffffffc0207892 <stride_dequeue+0x2732>
ffffffffc0205b5a:	010e3583          	ld	a1,16(t3)
ffffffffc0205b5e:	8552                	mv	a0,s4
ffffffffc0205b60:	008e3b03          	ld	s6,8(t3)
ffffffffc0205b64:	f81a                	sd	t1,48(sp)
ffffffffc0205b66:	f472                	sd	t3,40(sp)
ffffffffc0205b68:	c18ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205b6c:	7e22                	ld	t3,40(sp)
ffffffffc0205b6e:	7342                	ld	t1,48(sp)
ffffffffc0205b70:	016e3823          	sd	s6,16(t3)
ffffffffc0205b74:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b78:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b7c:	e119                	bnez	a0,ffffffffc0205b82 <stride_dequeue+0xa22>
ffffffffc0205b7e:	76d0106f          	j	ffffffffc0207aea <stride_dequeue+0x298a>
ffffffffc0205b82:	01c53023          	sd	t3,0(a0)
ffffffffc0205b86:	8a72                	mv	s4,t3
ffffffffc0205b88:	7782                	ld	a5,32(sp)
ffffffffc0205b8a:	01433423          	sd	s4,8(t1)
ffffffffc0205b8e:	00f33823          	sd	a5,16(t1)
ffffffffc0205b92:	006a3023          	sd	t1,0(s4)
ffffffffc0205b96:	8a1a                	mv	s4,t1
ffffffffc0205b98:	67e2                	ld	a5,24(sp)
ffffffffc0205b9a:	0149b423          	sd	s4,8(s3)
ffffffffc0205b9e:	00f9b823          	sd	a5,16(s3)
ffffffffc0205ba2:	013a3023          	sd	s3,0(s4)
ffffffffc0205ba6:	67c2                	ld	a5,16(sp)
ffffffffc0205ba8:	0134b423          	sd	s3,8(s1)
ffffffffc0205bac:	e89c                	sd	a5,16(s1)
ffffffffc0205bae:	0099b023          	sd	s1,0(s3)
ffffffffc0205bb2:	89da                	mv	s3,s6
ffffffffc0205bb4:	67a2                	ld	a5,8(sp)
ffffffffc0205bb6:	009cb423          	sd	s1,8(s9)
ffffffffc0205bba:	00fcb823          	sd	a5,16(s9)
ffffffffc0205bbe:	0194b023          	sd	s9,0(s1)
ffffffffc0205bc2:	84e6                	mv	s1,s9
ffffffffc0205bc4:	b635                	j	ffffffffc02056f0 <stride_dequeue+0x590>
ffffffffc0205bc6:	008db783          	ld	a5,8(s11)
ffffffffc0205bca:	010db883          	ld	a7,16(s11)
ffffffffc0205bce:	ec2a                	sd	a0,24(sp)
ffffffffc0205bd0:	e83e                	sd	a5,16(sp)
ffffffffc0205bd2:	0a088963          	beqz	a7,ffffffffc0205c84 <stride_dequeue+0xb24>
ffffffffc0205bd6:	8546                	mv	a0,a7
ffffffffc0205bd8:	85d2                	mv	a1,s4
ffffffffc0205bda:	f046                	sd	a7,32(sp)
ffffffffc0205bdc:	b48ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205be0:	6862                	ld	a6,24(sp)
ffffffffc0205be2:	7882                	ld	a7,32(sp)
ffffffffc0205be4:	0d050ae3          	beq	a0,a6,ffffffffc02064b8 <stride_dequeue+0x1358>
ffffffffc0205be8:	008a3783          	ld	a5,8(s4)
ffffffffc0205bec:	010a3983          	ld	s3,16(s4)
ffffffffc0205bf0:	f042                	sd	a6,32(sp)
ffffffffc0205bf2:	ec3e                	sd	a5,24(sp)
ffffffffc0205bf4:	00099463          	bnez	s3,ffffffffc0205bfc <stride_dequeue+0xa9c>
ffffffffc0205bf8:	53e0106f          	j	ffffffffc0207136 <stride_dequeue+0x1fd6>
ffffffffc0205bfc:	8546                	mv	a0,a7
ffffffffc0205bfe:	85ce                	mv	a1,s3
ffffffffc0205c00:	f446                	sd	a7,40(sp)
ffffffffc0205c02:	b22ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205c06:	7802                	ld	a6,32(sp)
ffffffffc0205c08:	78a2                	ld	a7,40(sp)
ffffffffc0205c0a:	01051463          	bne	a0,a6,ffffffffc0205c12 <stride_dequeue+0xab2>
ffffffffc0205c0e:	1260106f          	j	ffffffffc0206d34 <stride_dequeue+0x1bd4>
ffffffffc0205c12:	0089b783          	ld	a5,8(s3)
ffffffffc0205c16:	0109be03          	ld	t3,16(s3)
ffffffffc0205c1a:	f442                	sd	a6,40(sp)
ffffffffc0205c1c:	f03e                	sd	a5,32(sp)
ffffffffc0205c1e:	040e0463          	beqz	t3,ffffffffc0205c66 <stride_dequeue+0xb06>
ffffffffc0205c22:	85f2                	mv	a1,t3
ffffffffc0205c24:	8546                	mv	a0,a7
ffffffffc0205c26:	fc72                	sd	t3,56(sp)
ffffffffc0205c28:	f846                	sd	a7,48(sp)
ffffffffc0205c2a:	afaff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205c2e:	7822                	ld	a6,40(sp)
ffffffffc0205c30:	78c2                	ld	a7,48(sp)
ffffffffc0205c32:	7e62                	ld	t3,56(sp)
ffffffffc0205c34:	01051463          	bne	a0,a6,ffffffffc0205c3c <stride_dequeue+0xadc>
ffffffffc0205c38:	0e70106f          	j	ffffffffc020751e <stride_dequeue+0x23be>
ffffffffc0205c3c:	010e3583          	ld	a1,16(t3)
ffffffffc0205c40:	8546                	mv	a0,a7
ffffffffc0205c42:	008e3b03          	ld	s6,8(t3)
ffffffffc0205c46:	f472                	sd	t3,40(sp)
ffffffffc0205c48:	b38ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205c4c:	7e22                	ld	t3,40(sp)
ffffffffc0205c4e:	016e3823          	sd	s6,16(t3)
ffffffffc0205c52:	00ae3423          	sd	a0,8(t3)
ffffffffc0205c56:	010c2b03          	lw	s6,16(s8)
ffffffffc0205c5a:	e119                	bnez	a0,ffffffffc0205c60 <stride_dequeue+0xb00>
ffffffffc0205c5c:	1c10106f          	j	ffffffffc020761c <stride_dequeue+0x24bc>
ffffffffc0205c60:	01c53023          	sd	t3,0(a0)
ffffffffc0205c64:	88f2                	mv	a7,t3
ffffffffc0205c66:	7782                	ld	a5,32(sp)
ffffffffc0205c68:	0119b423          	sd	a7,8(s3)
ffffffffc0205c6c:	00f9b823          	sd	a5,16(s3)
ffffffffc0205c70:	0138b023          	sd	s3,0(a7)
ffffffffc0205c74:	67e2                	ld	a5,24(sp)
ffffffffc0205c76:	013a3423          	sd	s3,8(s4)
ffffffffc0205c7a:	00fa3823          	sd	a5,16(s4)
ffffffffc0205c7e:	0149b023          	sd	s4,0(s3)
ffffffffc0205c82:	89da                	mv	s3,s6
ffffffffc0205c84:	67c2                	ld	a5,16(sp)
ffffffffc0205c86:	014db423          	sd	s4,8(s11)
ffffffffc0205c8a:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c8e:	01ba3023          	sd	s11,0(s4)
ffffffffc0205c92:	fccff06f          	j	ffffffffc020545e <stride_dequeue+0x2fe>
ffffffffc0205c96:	008db783          	ld	a5,8(s11)
ffffffffc0205c9a:	010db883          	ld	a7,16(s11)
ffffffffc0205c9e:	e82a                	sd	a0,16(sp)
ffffffffc0205ca0:	e43e                	sd	a5,8(sp)
ffffffffc0205ca2:	0a088f63          	beqz	a7,ffffffffc0205d60 <stride_dequeue+0xc00>
ffffffffc0205ca6:	85b2                	mv	a1,a2
ffffffffc0205ca8:	8546                	mv	a0,a7
ffffffffc0205caa:	f032                	sd	a2,32(sp)
ffffffffc0205cac:	ec46                	sd	a7,24(sp)
ffffffffc0205cae:	a76ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205cb2:	6842                	ld	a6,16(sp)
ffffffffc0205cb4:	68e2                	ld	a7,24(sp)
ffffffffc0205cb6:	7602                	ld	a2,32(sp)
ffffffffc0205cb8:	150506e3          	beq	a0,a6,ffffffffc0206604 <stride_dequeue+0x14a4>
ffffffffc0205cbc:	661c                	ld	a5,8(a2)
ffffffffc0205cbe:	01063983          	ld	s3,16(a2)
ffffffffc0205cc2:	ec42                	sd	a6,24(sp)
ffffffffc0205cc4:	e83e                	sd	a5,16(sp)
ffffffffc0205cc6:	00099463          	bnez	s3,ffffffffc0205cce <stride_dequeue+0xb6e>
ffffffffc0205cca:	4660106f          	j	ffffffffc0207130 <stride_dequeue+0x1fd0>
ffffffffc0205cce:	8546                	mv	a0,a7
ffffffffc0205cd0:	85ce                	mv	a1,s3
ffffffffc0205cd2:	f432                	sd	a2,40(sp)
ffffffffc0205cd4:	f046                	sd	a7,32(sp)
ffffffffc0205cd6:	a4eff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205cda:	6862                	ld	a6,24(sp)
ffffffffc0205cdc:	7882                	ld	a7,32(sp)
ffffffffc0205cde:	7622                	ld	a2,40(sp)
ffffffffc0205ce0:	01051463          	bne	a0,a6,ffffffffc0205ce8 <stride_dequeue+0xb88>
ffffffffc0205ce4:	0ae0106f          	j	ffffffffc0206d92 <stride_dequeue+0x1c32>
ffffffffc0205ce8:	0089b783          	ld	a5,8(s3)
ffffffffc0205cec:	0109be03          	ld	t3,16(s3)
ffffffffc0205cf0:	f042                	sd	a6,32(sp)
ffffffffc0205cf2:	ec3e                	sd	a5,24(sp)
ffffffffc0205cf4:	040e0863          	beqz	t3,ffffffffc0205d44 <stride_dequeue+0xbe4>
ffffffffc0205cf8:	85f2                	mv	a1,t3
ffffffffc0205cfa:	8546                	mv	a0,a7
ffffffffc0205cfc:	fc32                	sd	a2,56(sp)
ffffffffc0205cfe:	f872                	sd	t3,48(sp)
ffffffffc0205d00:	f446                	sd	a7,40(sp)
ffffffffc0205d02:	a22ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205d06:	7662                	ld	a2,56(sp)
ffffffffc0205d08:	7802                	ld	a6,32(sp)
ffffffffc0205d0a:	78a2                	ld	a7,40(sp)
ffffffffc0205d0c:	f432                	sd	a2,40(sp)
ffffffffc0205d0e:	7e42                	ld	t3,48(sp)
ffffffffc0205d10:	01051463          	bne	a0,a6,ffffffffc0205d18 <stride_dequeue+0xbb8>
ffffffffc0205d14:	6ac0106f          	j	ffffffffc02073c0 <stride_dequeue+0x2260>
ffffffffc0205d18:	010e3583          	ld	a1,16(t3)
ffffffffc0205d1c:	8546                	mv	a0,a7
ffffffffc0205d1e:	008e3b03          	ld	s6,8(t3)
ffffffffc0205d22:	f072                	sd	t3,32(sp)
ffffffffc0205d24:	a5cff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205d28:	7e02                	ld	t3,32(sp)
ffffffffc0205d2a:	7622                	ld	a2,40(sp)
ffffffffc0205d2c:	016e3823          	sd	s6,16(t3)
ffffffffc0205d30:	00ae3423          	sd	a0,8(t3)
ffffffffc0205d34:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d38:	e119                	bnez	a0,ffffffffc0205d3e <stride_dequeue+0xbde>
ffffffffc0205d3a:	1370106f          	j	ffffffffc0207670 <stride_dequeue+0x2510>
ffffffffc0205d3e:	01c53023          	sd	t3,0(a0)
ffffffffc0205d42:	88f2                	mv	a7,t3
ffffffffc0205d44:	67e2                	ld	a5,24(sp)
ffffffffc0205d46:	0119b423          	sd	a7,8(s3)
ffffffffc0205d4a:	00f9b823          	sd	a5,16(s3)
ffffffffc0205d4e:	0138b023          	sd	s3,0(a7)
ffffffffc0205d52:	67c2                	ld	a5,16(sp)
ffffffffc0205d54:	01363423          	sd	s3,8(a2)
ffffffffc0205d58:	ea1c                	sd	a5,16(a2)
ffffffffc0205d5a:	00c9b023          	sd	a2,0(s3)
ffffffffc0205d5e:	89da                	mv	s3,s6
ffffffffc0205d60:	67a2                	ld	a5,8(sp)
ffffffffc0205d62:	00cdb423          	sd	a2,8(s11)
ffffffffc0205d66:	00fdb823          	sd	a5,16(s11)
ffffffffc0205d6a:	01b63023          	sd	s11,0(a2)
ffffffffc0205d6e:	849ff06f          	j	ffffffffc02055b6 <stride_dequeue+0x456>
ffffffffc0205d72:	008cb783          	ld	a5,8(s9)
ffffffffc0205d76:	010cb883          	ld	a7,16(s9)
ffffffffc0205d7a:	ec2a                	sd	a0,24(sp)
ffffffffc0205d7c:	e83e                	sd	a5,16(sp)
ffffffffc0205d7e:	0a088963          	beqz	a7,ffffffffc0205e30 <stride_dequeue+0xcd0>
ffffffffc0205d82:	8546                	mv	a0,a7
ffffffffc0205d84:	85ee                	mv	a1,s11
ffffffffc0205d86:	f046                	sd	a7,32(sp)
ffffffffc0205d88:	99cff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205d8c:	6862                	ld	a6,24(sp)
ffffffffc0205d8e:	7882                	ld	a7,32(sp)
ffffffffc0205d90:	7d050863          	beq	a0,a6,ffffffffc0206560 <stride_dequeue+0x1400>
ffffffffc0205d94:	008db783          	ld	a5,8(s11)
ffffffffc0205d98:	010db983          	ld	s3,16(s11)
ffffffffc0205d9c:	f042                	sd	a6,32(sp)
ffffffffc0205d9e:	ec3e                	sd	a5,24(sp)
ffffffffc0205da0:	00099463          	bnez	s3,ffffffffc0205da8 <stride_dequeue+0xc48>
ffffffffc0205da4:	3600106f          	j	ffffffffc0207104 <stride_dequeue+0x1fa4>
ffffffffc0205da8:	8546                	mv	a0,a7
ffffffffc0205daa:	85ce                	mv	a1,s3
ffffffffc0205dac:	f446                	sd	a7,40(sp)
ffffffffc0205dae:	976ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205db2:	7802                	ld	a6,32(sp)
ffffffffc0205db4:	78a2                	ld	a7,40(sp)
ffffffffc0205db6:	01051463          	bne	a0,a6,ffffffffc0205dbe <stride_dequeue+0xc5e>
ffffffffc0205dba:	71d0006f          	j	ffffffffc0206cd6 <stride_dequeue+0x1b76>
ffffffffc0205dbe:	0089b783          	ld	a5,8(s3)
ffffffffc0205dc2:	0109be03          	ld	t3,16(s3)
ffffffffc0205dc6:	f442                	sd	a6,40(sp)
ffffffffc0205dc8:	f03e                	sd	a5,32(sp)
ffffffffc0205dca:	040e0463          	beqz	t3,ffffffffc0205e12 <stride_dequeue+0xcb2>
ffffffffc0205dce:	85f2                	mv	a1,t3
ffffffffc0205dd0:	8546                	mv	a0,a7
ffffffffc0205dd2:	fc72                	sd	t3,56(sp)
ffffffffc0205dd4:	f846                	sd	a7,48(sp)
ffffffffc0205dd6:	94eff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205dda:	7822                	ld	a6,40(sp)
ffffffffc0205ddc:	78c2                	ld	a7,48(sp)
ffffffffc0205dde:	7e62                	ld	t3,56(sp)
ffffffffc0205de0:	01051463          	bne	a0,a6,ffffffffc0205de8 <stride_dequeue+0xc88>
ffffffffc0205de4:	60a0106f          	j	ffffffffc02073ee <stride_dequeue+0x228e>
ffffffffc0205de8:	010e3583          	ld	a1,16(t3)
ffffffffc0205dec:	8546                	mv	a0,a7
ffffffffc0205dee:	008e3b03          	ld	s6,8(t3)
ffffffffc0205df2:	f472                	sd	t3,40(sp)
ffffffffc0205df4:	98cff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205df8:	7e22                	ld	t3,40(sp)
ffffffffc0205dfa:	016e3823          	sd	s6,16(t3)
ffffffffc0205dfe:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e02:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e06:	e119                	bnez	a0,ffffffffc0205e0c <stride_dequeue+0xcac>
ffffffffc0205e08:	0270106f          	j	ffffffffc020762e <stride_dequeue+0x24ce>
ffffffffc0205e0c:	01c53023          	sd	t3,0(a0)
ffffffffc0205e10:	88f2                	mv	a7,t3
ffffffffc0205e12:	7782                	ld	a5,32(sp)
ffffffffc0205e14:	0119b423          	sd	a7,8(s3)
ffffffffc0205e18:	00f9b823          	sd	a5,16(s3)
ffffffffc0205e1c:	0138b023          	sd	s3,0(a7)
ffffffffc0205e20:	67e2                	ld	a5,24(sp)
ffffffffc0205e22:	013db423          	sd	s3,8(s11)
ffffffffc0205e26:	00fdb823          	sd	a5,16(s11)
ffffffffc0205e2a:	01b9b023          	sd	s11,0(s3)
ffffffffc0205e2e:	89da                	mv	s3,s6
ffffffffc0205e30:	67c2                	ld	a5,16(sp)
ffffffffc0205e32:	01bcb423          	sd	s11,8(s9)
ffffffffc0205e36:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e3a:	019db023          	sd	s9,0(s11)
ffffffffc0205e3e:	8de6                	mv	s11,s9
ffffffffc0205e40:	b9bd                	j	ffffffffc0205abe <stride_dequeue+0x95e>
ffffffffc0205e42:	00893783          	ld	a5,8(s2)
ffffffffc0205e46:	01093883          	ld	a7,16(s2)
ffffffffc0205e4a:	f02a                	sd	a0,32(sp)
ffffffffc0205e4c:	ec3e                	sd	a5,24(sp)
ffffffffc0205e4e:	06088c63          	beqz	a7,ffffffffc0205ec6 <stride_dequeue+0xd66>
ffffffffc0205e52:	85c2                	mv	a1,a6
ffffffffc0205e54:	8546                	mv	a0,a7
ffffffffc0205e56:	f842                	sd	a6,48(sp)
ffffffffc0205e58:	f446                	sd	a7,40(sp)
ffffffffc0205e5a:	8caff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205e5e:	7302                	ld	t1,32(sp)
ffffffffc0205e60:	78a2                	ld	a7,40(sp)
ffffffffc0205e62:	7842                	ld	a6,48(sp)
ffffffffc0205e64:	2e650ee3          	beq	a0,t1,ffffffffc0206960 <stride_dequeue+0x1800>
ffffffffc0205e68:	00883783          	ld	a5,8(a6)
ffffffffc0205e6c:	01083983          	ld	s3,16(a6)
ffffffffc0205e70:	f41a                	sd	t1,40(sp)
ffffffffc0205e72:	f03e                	sd	a5,32(sp)
ffffffffc0205e74:	64098ee3          	beqz	s3,ffffffffc0206cd0 <stride_dequeue+0x1b70>
ffffffffc0205e78:	8546                	mv	a0,a7
ffffffffc0205e7a:	85ce                	mv	a1,s3
ffffffffc0205e7c:	fc42                	sd	a6,56(sp)
ffffffffc0205e7e:	f846                	sd	a7,48(sp)
ffffffffc0205e80:	8a4ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205e84:	7322                	ld	t1,40(sp)
ffffffffc0205e86:	78c2                	ld	a7,48(sp)
ffffffffc0205e88:	7862                	ld	a6,56(sp)
ffffffffc0205e8a:	00651463          	bne	a0,t1,ffffffffc0205e92 <stride_dequeue+0xd32>
ffffffffc0205e8e:	1e80106f          	j	ffffffffc0207076 <stride_dequeue+0x1f16>
ffffffffc0205e92:	0109b583          	ld	a1,16(s3)
ffffffffc0205e96:	0089bb03          	ld	s6,8(s3)
ffffffffc0205e9a:	8546                	mv	a0,a7
ffffffffc0205e9c:	f442                	sd	a6,40(sp)
ffffffffc0205e9e:	8e2ff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205ea2:	00a9b423          	sd	a0,8(s3)
ffffffffc0205ea6:	0169b823          	sd	s6,16(s3)
ffffffffc0205eaa:	7822                	ld	a6,40(sp)
ffffffffc0205eac:	010c2b03          	lw	s6,16(s8)
ffffffffc0205eb0:	c119                	beqz	a0,ffffffffc0205eb6 <stride_dequeue+0xd56>
ffffffffc0205eb2:	01353023          	sd	s3,0(a0)
ffffffffc0205eb6:	7782                	ld	a5,32(sp)
ffffffffc0205eb8:	01383423          	sd	s3,8(a6)
ffffffffc0205ebc:	00f83823          	sd	a5,16(a6)
ffffffffc0205ec0:	0109b023          	sd	a6,0(s3)
ffffffffc0205ec4:	89da                	mv	s3,s6
ffffffffc0205ec6:	67e2                	ld	a5,24(sp)
ffffffffc0205ec8:	01093423          	sd	a6,8(s2)
ffffffffc0205ecc:	00f93823          	sd	a5,16(s2)
ffffffffc0205ed0:	01283023          	sd	s2,0(a6)
ffffffffc0205ed4:	bf0ff06f          	j	ffffffffc02052c4 <stride_dequeue+0x164>
ffffffffc0205ed8:	008cb783          	ld	a5,8(s9)
ffffffffc0205edc:	010cb983          	ld	s3,16(s9)
ffffffffc0205ee0:	ec2a                	sd	a0,24(sp)
ffffffffc0205ee2:	e83e                	sd	a5,16(sp)
ffffffffc0205ee4:	0a098763          	beqz	s3,ffffffffc0205f92 <stride_dequeue+0xe32>
ffffffffc0205ee8:	85d2                	mv	a1,s4
ffffffffc0205eea:	854e                	mv	a0,s3
ffffffffc0205eec:	838ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205ef0:	6862                	ld	a6,24(sp)
ffffffffc0205ef2:	3b050fe3          	beq	a0,a6,ffffffffc0206ab0 <stride_dequeue+0x1950>
ffffffffc0205ef6:	008a3783          	ld	a5,8(s4)
ffffffffc0205efa:	010a3303          	ld	t1,16(s4)
ffffffffc0205efe:	f042                	sd	a6,32(sp)
ffffffffc0205f00:	ec3e                	sd	a5,24(sp)
ffffffffc0205f02:	08030163          	beqz	t1,ffffffffc0205f84 <stride_dequeue+0xe24>
ffffffffc0205f06:	859a                	mv	a1,t1
ffffffffc0205f08:	854e                	mv	a0,s3
ffffffffc0205f0a:	f41a                	sd	t1,40(sp)
ffffffffc0205f0c:	818ff0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205f10:	7802                	ld	a6,32(sp)
ffffffffc0205f12:	7322                	ld	t1,40(sp)
ffffffffc0205f14:	01051463          	bne	a0,a6,ffffffffc0205f1c <stride_dequeue+0xdbc>
ffffffffc0205f18:	3da0106f          	j	ffffffffc02072f2 <stride_dequeue+0x2192>
ffffffffc0205f1c:	00833783          	ld	a5,8(t1)
ffffffffc0205f20:	01033e03          	ld	t3,16(t1)
ffffffffc0205f24:	fc42                	sd	a6,56(sp)
ffffffffc0205f26:	f03e                	sd	a5,32(sp)
ffffffffc0205f28:	040e0663          	beqz	t3,ffffffffc0205f74 <stride_dequeue+0xe14>
ffffffffc0205f2c:	85f2                	mv	a1,t3
ffffffffc0205f2e:	854e                	mv	a0,s3
ffffffffc0205f30:	f81a                	sd	t1,48(sp)
ffffffffc0205f32:	f472                	sd	t3,40(sp)
ffffffffc0205f34:	ff1fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205f38:	7862                	ld	a6,56(sp)
ffffffffc0205f3a:	7e22                	ld	t3,40(sp)
ffffffffc0205f3c:	7342                	ld	t1,48(sp)
ffffffffc0205f3e:	01051463          	bne	a0,a6,ffffffffc0205f46 <stride_dequeue+0xde6>
ffffffffc0205f42:	0c90106f          	j	ffffffffc020780a <stride_dequeue+0x26aa>
ffffffffc0205f46:	010e3583          	ld	a1,16(t3)
ffffffffc0205f4a:	854e                	mv	a0,s3
ffffffffc0205f4c:	008e3b03          	ld	s6,8(t3)
ffffffffc0205f50:	f81a                	sd	t1,48(sp)
ffffffffc0205f52:	f472                	sd	t3,40(sp)
ffffffffc0205f54:	82cff0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0205f58:	7e22                	ld	t3,40(sp)
ffffffffc0205f5a:	7342                	ld	t1,48(sp)
ffffffffc0205f5c:	016e3823          	sd	s6,16(t3)
ffffffffc0205f60:	00ae3423          	sd	a0,8(t3)
ffffffffc0205f64:	010c2b03          	lw	s6,16(s8)
ffffffffc0205f68:	e119                	bnez	a0,ffffffffc0205f6e <stride_dequeue+0xe0e>
ffffffffc0205f6a:	32d0106f          	j	ffffffffc0207a96 <stride_dequeue+0x2936>
ffffffffc0205f6e:	01c53023          	sd	t3,0(a0)
ffffffffc0205f72:	89f2                	mv	s3,t3
ffffffffc0205f74:	7782                	ld	a5,32(sp)
ffffffffc0205f76:	01333423          	sd	s3,8(t1)
ffffffffc0205f7a:	00f33823          	sd	a5,16(t1)
ffffffffc0205f7e:	0069b023          	sd	t1,0(s3)
ffffffffc0205f82:	899a                	mv	s3,t1
ffffffffc0205f84:	67e2                	ld	a5,24(sp)
ffffffffc0205f86:	013a3423          	sd	s3,8(s4)
ffffffffc0205f8a:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f8e:	0149b023          	sd	s4,0(s3)
ffffffffc0205f92:	67c2                	ld	a5,16(sp)
ffffffffc0205f94:	014cb423          	sd	s4,8(s9)
ffffffffc0205f98:	89da                	mv	s3,s6
ffffffffc0205f9a:	00fcb823          	sd	a5,16(s9)
ffffffffc0205f9e:	019a3023          	sd	s9,0(s4)
ffffffffc0205fa2:	f42ff06f          	j	ffffffffc02056e4 <stride_dequeue+0x584>
ffffffffc0205fa6:	661c                	ld	a5,8(a2)
ffffffffc0205fa8:	01063983          	ld	s3,16(a2)
ffffffffc0205fac:	e82a                	sd	a0,16(sp)
ffffffffc0205fae:	e43e                	sd	a5,8(sp)
ffffffffc0205fb0:	0a098f63          	beqz	s3,ffffffffc020606e <stride_dequeue+0xf0e>
ffffffffc0205fb4:	85d2                	mv	a1,s4
ffffffffc0205fb6:	854e                	mv	a0,s3
ffffffffc0205fb8:	ec32                	sd	a2,24(sp)
ffffffffc0205fba:	f6bfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205fbe:	6842                	ld	a6,16(sp)
ffffffffc0205fc0:	6662                	ld	a2,24(sp)
ffffffffc0205fc2:	39050de3          	beq	a0,a6,ffffffffc0206b5c <stride_dequeue+0x19fc>
ffffffffc0205fc6:	008a3783          	ld	a5,8(s4)
ffffffffc0205fca:	010a3303          	ld	t1,16(s4)
ffffffffc0205fce:	ec42                	sd	a6,24(sp)
ffffffffc0205fd0:	e83e                	sd	a5,16(sp)
ffffffffc0205fd2:	08030763          	beqz	t1,ffffffffc0206060 <stride_dequeue+0xf00>
ffffffffc0205fd6:	859a                	mv	a1,t1
ffffffffc0205fd8:	854e                	mv	a0,s3
ffffffffc0205fda:	f432                	sd	a2,40(sp)
ffffffffc0205fdc:	f01a                	sd	t1,32(sp)
ffffffffc0205fde:	f47fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0205fe2:	6862                	ld	a6,24(sp)
ffffffffc0205fe4:	7302                	ld	t1,32(sp)
ffffffffc0205fe6:	7622                	ld	a2,40(sp)
ffffffffc0205fe8:	01051463          	bne	a0,a6,ffffffffc0205ff0 <stride_dequeue+0xe90>
ffffffffc0205fec:	5060106f          	j	ffffffffc02074f2 <stride_dequeue+0x2392>
ffffffffc0205ff0:	00833783          	ld	a5,8(t1)
ffffffffc0205ff4:	01033e03          	ld	t3,16(t1)
ffffffffc0205ff8:	fc42                	sd	a6,56(sp)
ffffffffc0205ffa:	ec3e                	sd	a5,24(sp)
ffffffffc0205ffc:	040e0a63          	beqz	t3,ffffffffc0206050 <stride_dequeue+0xef0>
ffffffffc0206000:	85f2                	mv	a1,t3
ffffffffc0206002:	854e                	mv	a0,s3
ffffffffc0206004:	f81a                	sd	t1,48(sp)
ffffffffc0206006:	f432                	sd	a2,40(sp)
ffffffffc0206008:	f072                	sd	t3,32(sp)
ffffffffc020600a:	f1bfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020600e:	7862                	ld	a6,56(sp)
ffffffffc0206010:	7e02                	ld	t3,32(sp)
ffffffffc0206012:	7622                	ld	a2,40(sp)
ffffffffc0206014:	7342                	ld	t1,48(sp)
ffffffffc0206016:	01051463          	bne	a0,a6,ffffffffc020601e <stride_dequeue+0xebe>
ffffffffc020601a:	1e10106f          	j	ffffffffc02079fa <stride_dequeue+0x289a>
ffffffffc020601e:	010e3583          	ld	a1,16(t3)
ffffffffc0206022:	854e                	mv	a0,s3
ffffffffc0206024:	008e3b03          	ld	s6,8(t3)
ffffffffc0206028:	f81a                	sd	t1,48(sp)
ffffffffc020602a:	f432                	sd	a2,40(sp)
ffffffffc020602c:	f072                	sd	t3,32(sp)
ffffffffc020602e:	f53fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206032:	7e02                	ld	t3,32(sp)
ffffffffc0206034:	7622                	ld	a2,40(sp)
ffffffffc0206036:	7342                	ld	t1,48(sp)
ffffffffc0206038:	016e3823          	sd	s6,16(t3)
ffffffffc020603c:	00ae3423          	sd	a0,8(t3)
ffffffffc0206040:	010c2b03          	lw	s6,16(s8)
ffffffffc0206044:	e119                	bnez	a0,ffffffffc020604a <stride_dequeue+0xeea>
ffffffffc0206046:	22d0106f          	j	ffffffffc0207a72 <stride_dequeue+0x2912>
ffffffffc020604a:	01c53023          	sd	t3,0(a0)
ffffffffc020604e:	89f2                	mv	s3,t3
ffffffffc0206050:	67e2                	ld	a5,24(sp)
ffffffffc0206052:	01333423          	sd	s3,8(t1)
ffffffffc0206056:	00f33823          	sd	a5,16(t1)
ffffffffc020605a:	0069b023          	sd	t1,0(s3)
ffffffffc020605e:	899a                	mv	s3,t1
ffffffffc0206060:	67c2                	ld	a5,16(sp)
ffffffffc0206062:	013a3423          	sd	s3,8(s4)
ffffffffc0206066:	00fa3823          	sd	a5,16(s4)
ffffffffc020606a:	0149b023          	sd	s4,0(s3)
ffffffffc020606e:	67a2                	ld	a5,8(sp)
ffffffffc0206070:	01463423          	sd	s4,8(a2)
ffffffffc0206074:	89da                	mv	s3,s6
ffffffffc0206076:	ea1c                	sd	a5,16(a2)
ffffffffc0206078:	00ca3023          	sd	a2,0(s4)
ffffffffc020607c:	8a32                	mv	s4,a2
ffffffffc020607e:	f80ff06f          	j	ffffffffc02057fe <stride_dequeue+0x69e>
ffffffffc0206082:	008a3783          	ld	a5,8(s4)
ffffffffc0206086:	010a3983          	ld	s3,16(s4)
ffffffffc020608a:	ec2a                	sd	a0,24(sp)
ffffffffc020608c:	e83e                	sd	a5,16(sp)
ffffffffc020608e:	0a098763          	beqz	s3,ffffffffc020613c <stride_dequeue+0xfdc>
ffffffffc0206092:	85e6                	mv	a1,s9
ffffffffc0206094:	854e                	mv	a0,s3
ffffffffc0206096:	e8ffe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020609a:	6862                	ld	a6,24(sp)
ffffffffc020609c:	270505e3          	beq	a0,a6,ffffffffc0206b06 <stride_dequeue+0x19a6>
ffffffffc02060a0:	008cb783          	ld	a5,8(s9)
ffffffffc02060a4:	010cb303          	ld	t1,16(s9)
ffffffffc02060a8:	f042                	sd	a6,32(sp)
ffffffffc02060aa:	ec3e                	sd	a5,24(sp)
ffffffffc02060ac:	08030163          	beqz	t1,ffffffffc020612e <stride_dequeue+0xfce>
ffffffffc02060b0:	859a                	mv	a1,t1
ffffffffc02060b2:	854e                	mv	a0,s3
ffffffffc02060b4:	f41a                	sd	t1,40(sp)
ffffffffc02060b6:	e6ffe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02060ba:	7802                	ld	a6,32(sp)
ffffffffc02060bc:	7322                	ld	t1,40(sp)
ffffffffc02060be:	01051463          	bne	a0,a6,ffffffffc02060c6 <stride_dequeue+0xf66>
ffffffffc02060c2:	4080106f          	j	ffffffffc02074ca <stride_dequeue+0x236a>
ffffffffc02060c6:	00833783          	ld	a5,8(t1)
ffffffffc02060ca:	01033e03          	ld	t3,16(t1)
ffffffffc02060ce:	fc42                	sd	a6,56(sp)
ffffffffc02060d0:	f03e                	sd	a5,32(sp)
ffffffffc02060d2:	040e0663          	beqz	t3,ffffffffc020611e <stride_dequeue+0xfbe>
ffffffffc02060d6:	85f2                	mv	a1,t3
ffffffffc02060d8:	854e                	mv	a0,s3
ffffffffc02060da:	f81a                	sd	t1,48(sp)
ffffffffc02060dc:	f472                	sd	t3,40(sp)
ffffffffc02060de:	e47fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02060e2:	7862                	ld	a6,56(sp)
ffffffffc02060e4:	7e22                	ld	t3,40(sp)
ffffffffc02060e6:	7342                	ld	t1,48(sp)
ffffffffc02060e8:	01051463          	bne	a0,a6,ffffffffc02060f0 <stride_dequeue+0xf90>
ffffffffc02060ec:	6160106f          	j	ffffffffc0207702 <stride_dequeue+0x25a2>
ffffffffc02060f0:	010e3583          	ld	a1,16(t3)
ffffffffc02060f4:	854e                	mv	a0,s3
ffffffffc02060f6:	008e3b03          	ld	s6,8(t3)
ffffffffc02060fa:	f81a                	sd	t1,48(sp)
ffffffffc02060fc:	f472                	sd	t3,40(sp)
ffffffffc02060fe:	e83fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206102:	7e22                	ld	t3,40(sp)
ffffffffc0206104:	7342                	ld	t1,48(sp)
ffffffffc0206106:	016e3823          	sd	s6,16(t3)
ffffffffc020610a:	00ae3423          	sd	a0,8(t3)
ffffffffc020610e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206112:	e119                	bnez	a0,ffffffffc0206118 <stride_dequeue+0xfb8>
ffffffffc0206114:	1b30106f          	j	ffffffffc0207ac6 <stride_dequeue+0x2966>
ffffffffc0206118:	01c53023          	sd	t3,0(a0)
ffffffffc020611c:	89f2                	mv	s3,t3
ffffffffc020611e:	7782                	ld	a5,32(sp)
ffffffffc0206120:	01333423          	sd	s3,8(t1)
ffffffffc0206124:	00f33823          	sd	a5,16(t1)
ffffffffc0206128:	0069b023          	sd	t1,0(s3)
ffffffffc020612c:	899a                	mv	s3,t1
ffffffffc020612e:	67e2                	ld	a5,24(sp)
ffffffffc0206130:	013cb423          	sd	s3,8(s9)
ffffffffc0206134:	00fcb823          	sd	a5,16(s9)
ffffffffc0206138:	0199b023          	sd	s9,0(s3)
ffffffffc020613c:	67c2                	ld	a5,16(sp)
ffffffffc020613e:	019a3423          	sd	s9,8(s4)
ffffffffc0206142:	89da                	mv	s3,s6
ffffffffc0206144:	00fa3823          	sd	a5,16(s4)
ffffffffc0206148:	014cb023          	sd	s4,0(s9)
ffffffffc020614c:	8cd2                	mv	s9,s4
ffffffffc020614e:	faeff06f          	j	ffffffffc02058fc <stride_dequeue+0x79c>
ffffffffc0206152:	0088b783          	ld	a5,8(a7)
ffffffffc0206156:	0108b983          	ld	s3,16(a7)
ffffffffc020615a:	f02a                	sd	a0,32(sp)
ffffffffc020615c:	ec3e                	sd	a5,24(sp)
ffffffffc020615e:	06098e63          	beqz	s3,ffffffffc02061da <stride_dequeue+0x107a>
ffffffffc0206162:	85e6                	mv	a1,s9
ffffffffc0206164:	854e                	mv	a0,s3
ffffffffc0206166:	f446                	sd	a7,40(sp)
ffffffffc0206168:	dbdfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020616c:	7302                	ld	t1,32(sp)
ffffffffc020616e:	78a2                	ld	a7,40(sp)
ffffffffc0206170:	486503e3          	beq	a0,t1,ffffffffc0206df6 <stride_dequeue+0x1c96>
ffffffffc0206174:	008cb783          	ld	a5,8(s9)
ffffffffc0206178:	010cbe03          	ld	t3,16(s9)
ffffffffc020617c:	f41a                	sd	t1,40(sp)
ffffffffc020617e:	f03e                	sd	a5,32(sp)
ffffffffc0206180:	040e0663          	beqz	t3,ffffffffc02061cc <stride_dequeue+0x106c>
ffffffffc0206184:	85f2                	mv	a1,t3
ffffffffc0206186:	854e                	mv	a0,s3
ffffffffc0206188:	fc46                	sd	a7,56(sp)
ffffffffc020618a:	f872                	sd	t3,48(sp)
ffffffffc020618c:	d99fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206190:	7322                	ld	t1,40(sp)
ffffffffc0206192:	7e42                	ld	t3,48(sp)
ffffffffc0206194:	78e2                	ld	a7,56(sp)
ffffffffc0206196:	00651463          	bne	a0,t1,ffffffffc020619e <stride_dequeue+0x103e>
ffffffffc020619a:	3040106f          	j	ffffffffc020749e <stride_dequeue+0x233e>
ffffffffc020619e:	010e3583          	ld	a1,16(t3)
ffffffffc02061a2:	854e                	mv	a0,s3
ffffffffc02061a4:	008e3b03          	ld	s6,8(t3)
ffffffffc02061a8:	f846                	sd	a7,48(sp)
ffffffffc02061aa:	f472                	sd	t3,40(sp)
ffffffffc02061ac:	dd5fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02061b0:	7e22                	ld	t3,40(sp)
ffffffffc02061b2:	78c2                	ld	a7,48(sp)
ffffffffc02061b4:	016e3823          	sd	s6,16(t3)
ffffffffc02061b8:	00ae3423          	sd	a0,8(t3)
ffffffffc02061bc:	010c2b03          	lw	s6,16(s8)
ffffffffc02061c0:	e119                	bnez	a0,ffffffffc02061c6 <stride_dequeue+0x1066>
ffffffffc02061c2:	4540106f          	j	ffffffffc0207616 <stride_dequeue+0x24b6>
ffffffffc02061c6:	01c53023          	sd	t3,0(a0)
ffffffffc02061ca:	89f2                	mv	s3,t3
ffffffffc02061cc:	7782                	ld	a5,32(sp)
ffffffffc02061ce:	013cb423          	sd	s3,8(s9)
ffffffffc02061d2:	00fcb823          	sd	a5,16(s9)
ffffffffc02061d6:	0199b023          	sd	s9,0(s3)
ffffffffc02061da:	67e2                	ld	a5,24(sp)
ffffffffc02061dc:	0198b423          	sd	s9,8(a7)
ffffffffc02061e0:	89da                	mv	s3,s6
ffffffffc02061e2:	00f8b823          	sd	a5,16(a7)
ffffffffc02061e6:	011cb023          	sd	a7,0(s9)
ffffffffc02061ea:	8cc6                	mv	s9,a7
ffffffffc02061ec:	fdeff06f          	j	ffffffffc02059ca <stride_dequeue+0x86a>
ffffffffc02061f0:	008cb783          	ld	a5,8(s9)
ffffffffc02061f4:	010cb983          	ld	s3,16(s9)
ffffffffc02061f8:	f02a                	sd	a0,32(sp)
ffffffffc02061fa:	ec3e                	sd	a5,24(sp)
ffffffffc02061fc:	06098e63          	beqz	s3,ffffffffc0206278 <stride_dequeue+0x1118>
ffffffffc0206200:	85c2                	mv	a1,a6
ffffffffc0206202:	854e                	mv	a0,s3
ffffffffc0206204:	f442                	sd	a6,40(sp)
ffffffffc0206206:	d1ffe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020620a:	7302                	ld	t1,32(sp)
ffffffffc020620c:	7822                	ld	a6,40(sp)
ffffffffc020620e:	446506e3          	beq	a0,t1,ffffffffc0206e5a <stride_dequeue+0x1cfa>
ffffffffc0206212:	00883783          	ld	a5,8(a6)
ffffffffc0206216:	01083e03          	ld	t3,16(a6)
ffffffffc020621a:	f41a                	sd	t1,40(sp)
ffffffffc020621c:	f03e                	sd	a5,32(sp)
ffffffffc020621e:	040e0663          	beqz	t3,ffffffffc020626a <stride_dequeue+0x110a>
ffffffffc0206222:	85f2                	mv	a1,t3
ffffffffc0206224:	854e                	mv	a0,s3
ffffffffc0206226:	fc42                	sd	a6,56(sp)
ffffffffc0206228:	f872                	sd	t3,48(sp)
ffffffffc020622a:	cfbfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020622e:	7322                	ld	t1,40(sp)
ffffffffc0206230:	7e42                	ld	t3,48(sp)
ffffffffc0206232:	7862                	ld	a6,56(sp)
ffffffffc0206234:	00651463          	bne	a0,t1,ffffffffc020623c <stride_dequeue+0x10dc>
ffffffffc0206238:	20e0106f          	j	ffffffffc0207446 <stride_dequeue+0x22e6>
ffffffffc020623c:	010e3583          	ld	a1,16(t3)
ffffffffc0206240:	854e                	mv	a0,s3
ffffffffc0206242:	008e3b03          	ld	s6,8(t3)
ffffffffc0206246:	f842                	sd	a6,48(sp)
ffffffffc0206248:	f472                	sd	t3,40(sp)
ffffffffc020624a:	d37fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020624e:	7e22                	ld	t3,40(sp)
ffffffffc0206250:	7842                	ld	a6,48(sp)
ffffffffc0206252:	016e3823          	sd	s6,16(t3)
ffffffffc0206256:	00ae3423          	sd	a0,8(t3)
ffffffffc020625a:	010c2b03          	lw	s6,16(s8)
ffffffffc020625e:	e119                	bnez	a0,ffffffffc0206264 <stride_dequeue+0x1104>
ffffffffc0206260:	3c80106f          	j	ffffffffc0207628 <stride_dequeue+0x24c8>
ffffffffc0206264:	01c53023          	sd	t3,0(a0)
ffffffffc0206268:	89f2                	mv	s3,t3
ffffffffc020626a:	7782                	ld	a5,32(sp)
ffffffffc020626c:	01383423          	sd	s3,8(a6)
ffffffffc0206270:	00f83823          	sd	a5,16(a6)
ffffffffc0206274:	0109b023          	sd	a6,0(s3)
ffffffffc0206278:	67e2                	ld	a5,24(sp)
ffffffffc020627a:	010cb423          	sd	a6,8(s9)
ffffffffc020627e:	89da                	mv	s3,s6
ffffffffc0206280:	00fcb823          	sd	a5,16(s9)
ffffffffc0206284:	01983023          	sd	s9,0(a6)
ffffffffc0206288:	829ff06f          	j	ffffffffc0205ab0 <stride_dequeue+0x950>
ffffffffc020628c:	008db783          	ld	a5,8(s11)
ffffffffc0206290:	010db983          	ld	s3,16(s11)
ffffffffc0206294:	f02a                	sd	a0,32(sp)
ffffffffc0206296:	ec3e                	sd	a5,24(sp)
ffffffffc0206298:	06098e63          	beqz	s3,ffffffffc0206314 <stride_dequeue+0x11b4>
ffffffffc020629c:	85c2                	mv	a1,a6
ffffffffc020629e:	854e                	mv	a0,s3
ffffffffc02062a0:	f442                	sd	a6,40(sp)
ffffffffc02062a2:	c83fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02062a6:	7302                	ld	t1,32(sp)
ffffffffc02062a8:	7822                	ld	a6,40(sp)
ffffffffc02062aa:	466506e3          	beq	a0,t1,ffffffffc0206f16 <stride_dequeue+0x1db6>
ffffffffc02062ae:	00883783          	ld	a5,8(a6)
ffffffffc02062b2:	01083e03          	ld	t3,16(a6)
ffffffffc02062b6:	f41a                	sd	t1,40(sp)
ffffffffc02062b8:	f03e                	sd	a5,32(sp)
ffffffffc02062ba:	040e0663          	beqz	t3,ffffffffc0206306 <stride_dequeue+0x11a6>
ffffffffc02062be:	85f2                	mv	a1,t3
ffffffffc02062c0:	854e                	mv	a0,s3
ffffffffc02062c2:	fc42                	sd	a6,56(sp)
ffffffffc02062c4:	f872                	sd	t3,48(sp)
ffffffffc02062c6:	c5ffe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02062ca:	7322                	ld	t1,40(sp)
ffffffffc02062cc:	7e42                	ld	t3,48(sp)
ffffffffc02062ce:	7862                	ld	a6,56(sp)
ffffffffc02062d0:	00651463          	bne	a0,t1,ffffffffc02062d8 <stride_dequeue+0x1178>
ffffffffc02062d4:	7490006f          	j	ffffffffc020721c <stride_dequeue+0x20bc>
ffffffffc02062d8:	010e3583          	ld	a1,16(t3)
ffffffffc02062dc:	854e                	mv	a0,s3
ffffffffc02062de:	008e3b03          	ld	s6,8(t3)
ffffffffc02062e2:	f842                	sd	a6,48(sp)
ffffffffc02062e4:	f472                	sd	t3,40(sp)
ffffffffc02062e6:	c9bfe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02062ea:	7e22                	ld	t3,40(sp)
ffffffffc02062ec:	7842                	ld	a6,48(sp)
ffffffffc02062ee:	016e3823          	sd	s6,16(t3)
ffffffffc02062f2:	00ae3423          	sd	a0,8(t3)
ffffffffc02062f6:	010c2b03          	lw	s6,16(s8)
ffffffffc02062fa:	e119                	bnez	a0,ffffffffc0206300 <stride_dequeue+0x11a0>
ffffffffc02062fc:	3260106f          	j	ffffffffc0207622 <stride_dequeue+0x24c2>
ffffffffc0206300:	01c53023          	sd	t3,0(a0)
ffffffffc0206304:	89f2                	mv	s3,t3
ffffffffc0206306:	7782                	ld	a5,32(sp)
ffffffffc0206308:	01383423          	sd	s3,8(a6)
ffffffffc020630c:	00f83823          	sd	a5,16(a6)
ffffffffc0206310:	0109b023          	sd	a6,0(s3)
ffffffffc0206314:	67e2                	ld	a5,24(sp)
ffffffffc0206316:	010db423          	sd	a6,8(s11)
ffffffffc020631a:	89da                	mv	s3,s6
ffffffffc020631c:	00fdb823          	sd	a5,16(s11)
ffffffffc0206320:	01b83023          	sd	s11,0(a6)
ffffffffc0206324:	92aff06f          	j	ffffffffc020544e <stride_dequeue+0x2ee>
ffffffffc0206328:	008db783          	ld	a5,8(s11)
ffffffffc020632c:	010db983          	ld	s3,16(s11)
ffffffffc0206330:	ec2a                	sd	a0,24(sp)
ffffffffc0206332:	e83e                	sd	a5,16(sp)
ffffffffc0206334:	08098263          	beqz	s3,ffffffffc02063b8 <stride_dequeue+0x1258>
ffffffffc0206338:	85c2                	mv	a1,a6
ffffffffc020633a:	854e                	mv	a0,s3
ffffffffc020633c:	f432                	sd	a2,40(sp)
ffffffffc020633e:	f042                	sd	a6,32(sp)
ffffffffc0206340:	be5fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206344:	6362                	ld	t1,24(sp)
ffffffffc0206346:	7802                	ld	a6,32(sp)
ffffffffc0206348:	7622                	ld	a2,40(sp)
ffffffffc020634a:	426505e3          	beq	a0,t1,ffffffffc0206f74 <stride_dequeue+0x1e14>
ffffffffc020634e:	00883783          	ld	a5,8(a6)
ffffffffc0206352:	01083e03          	ld	t3,16(a6)
ffffffffc0206356:	f01a                	sd	t1,32(sp)
ffffffffc0206358:	ec3e                	sd	a5,24(sp)
ffffffffc020635a:	040e0863          	beqz	t3,ffffffffc02063aa <stride_dequeue+0x124a>
ffffffffc020635e:	85f2                	mv	a1,t3
ffffffffc0206360:	854e                	mv	a0,s3
ffffffffc0206362:	fc42                	sd	a6,56(sp)
ffffffffc0206364:	f832                	sd	a2,48(sp)
ffffffffc0206366:	f472                	sd	t3,40(sp)
ffffffffc0206368:	bbdfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020636c:	7302                	ld	t1,32(sp)
ffffffffc020636e:	7e22                	ld	t3,40(sp)
ffffffffc0206370:	7642                	ld	a2,48(sp)
ffffffffc0206372:	7862                	ld	a6,56(sp)
ffffffffc0206374:	60650fe3          	beq	a0,t1,ffffffffc0207192 <stride_dequeue+0x2032>
ffffffffc0206378:	010e3583          	ld	a1,16(t3)
ffffffffc020637c:	854e                	mv	a0,s3
ffffffffc020637e:	008e3b03          	ld	s6,8(t3)
ffffffffc0206382:	f842                	sd	a6,48(sp)
ffffffffc0206384:	f432                	sd	a2,40(sp)
ffffffffc0206386:	f072                	sd	t3,32(sp)
ffffffffc0206388:	bf9fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020638c:	7e02                	ld	t3,32(sp)
ffffffffc020638e:	7622                	ld	a2,40(sp)
ffffffffc0206390:	7842                	ld	a6,48(sp)
ffffffffc0206392:	016e3823          	sd	s6,16(t3)
ffffffffc0206396:	00ae3423          	sd	a0,8(t3)
ffffffffc020639a:	010c2b03          	lw	s6,16(s8)
ffffffffc020639e:	e119                	bnez	a0,ffffffffc02063a4 <stride_dequeue+0x1244>
ffffffffc02063a0:	2d60106f          	j	ffffffffc0207676 <stride_dequeue+0x2516>
ffffffffc02063a4:	01c53023          	sd	t3,0(a0)
ffffffffc02063a8:	89f2                	mv	s3,t3
ffffffffc02063aa:	67e2                	ld	a5,24(sp)
ffffffffc02063ac:	01383423          	sd	s3,8(a6)
ffffffffc02063b0:	00f83823          	sd	a5,16(a6)
ffffffffc02063b4:	0109b023          	sd	a6,0(s3)
ffffffffc02063b8:	67c2                	ld	a5,16(sp)
ffffffffc02063ba:	010db423          	sd	a6,8(s11)
ffffffffc02063be:	89da                	mv	s3,s6
ffffffffc02063c0:	00fdb823          	sd	a5,16(s11)
ffffffffc02063c4:	01b83023          	sd	s11,0(a6)
ffffffffc02063c8:	9e0ff06f          	j	ffffffffc02055a8 <stride_dequeue+0x448>
ffffffffc02063cc:	00893703          	ld	a4,8(s2)
ffffffffc02063d0:	01093983          	ld	s3,16(s2)
ffffffffc02063d4:	f42a                	sd	a0,40(sp)
ffffffffc02063d6:	f03a                	sd	a4,32(sp)
ffffffffc02063d8:	02098e63          	beqz	s3,ffffffffc0206414 <stride_dequeue+0x12b4>
ffffffffc02063dc:	85be                	mv	a1,a5
ffffffffc02063de:	854e                	mv	a0,s3
ffffffffc02063e0:	fc42                	sd	a6,56(sp)
ffffffffc02063e2:	f83e                	sd	a5,48(sp)
ffffffffc02063e4:	b41fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02063e8:	7e22                	ld	t3,40(sp)
ffffffffc02063ea:	77c2                	ld	a5,48(sp)
ffffffffc02063ec:	7862                	ld	a6,56(sp)
ffffffffc02063ee:	43c509e3          	beq	a0,t3,ffffffffc0207020 <stride_dequeue+0x1ec0>
ffffffffc02063f2:	6b8c                	ld	a1,16(a5)
ffffffffc02063f4:	854e                	mv	a0,s3
ffffffffc02063f6:	0087bb03          	ld	s6,8(a5)
ffffffffc02063fa:	f842                	sd	a6,48(sp)
ffffffffc02063fc:	f43e                	sd	a5,40(sp)
ffffffffc02063fe:	b83fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206402:	77a2                	ld	a5,40(sp)
ffffffffc0206404:	7842                	ld	a6,48(sp)
ffffffffc0206406:	0167b823          	sd	s6,16(a5)
ffffffffc020640a:	e788                	sd	a0,8(a5)
ffffffffc020640c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206410:	c111                	beqz	a0,ffffffffc0206414 <stride_dequeue+0x12b4>
ffffffffc0206412:	e11c                	sd	a5,0(a0)
ffffffffc0206414:	7702                	ld	a4,32(sp)
ffffffffc0206416:	00f93423          	sd	a5,8(s2)
ffffffffc020641a:	89da                	mv	s3,s6
ffffffffc020641c:	00e93823          	sd	a4,16(s2)
ffffffffc0206420:	0127b023          	sd	s2,0(a5)
ffffffffc0206424:	e91fe06f          	j	ffffffffc02052b4 <stride_dequeue+0x154>
ffffffffc0206428:	008a3783          	ld	a5,8(s4)
ffffffffc020642c:	010a3983          	ld	s3,16(s4)
ffffffffc0206430:	ec2a                	sd	a0,24(sp)
ffffffffc0206432:	e83e                	sd	a5,16(sp)
ffffffffc0206434:	5a098ce3          	beqz	s3,ffffffffc02071ec <stride_dequeue+0x208c>
ffffffffc0206438:	85a6                	mv	a1,s1
ffffffffc020643a:	854e                	mv	a0,s3
ffffffffc020643c:	ae9fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206440:	67e2                	ld	a5,24(sp)
ffffffffc0206442:	50f500e3          	beq	a0,a5,ffffffffc0207142 <stride_dequeue+0x1fe2>
ffffffffc0206446:	f43e                	sd	a5,40(sp)
ffffffffc0206448:	649c                	ld	a5,8(s1)
ffffffffc020644a:	0104b883          	ld	a7,16(s1)
ffffffffc020644e:	ec3e                	sd	a5,24(sp)
ffffffffc0206450:	04088263          	beqz	a7,ffffffffc0206494 <stride_dequeue+0x1334>
ffffffffc0206454:	85c6                	mv	a1,a7
ffffffffc0206456:	854e                	mv	a0,s3
ffffffffc0206458:	f046                	sd	a7,32(sp)
ffffffffc020645a:	acbfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020645e:	77a2                	ld	a5,40(sp)
ffffffffc0206460:	7882                	ld	a7,32(sp)
ffffffffc0206462:	00f51463          	bne	a0,a5,ffffffffc020646a <stride_dequeue+0x130a>
ffffffffc0206466:	2160106f          	j	ffffffffc020767c <stride_dequeue+0x251c>
ffffffffc020646a:	0108b583          	ld	a1,16(a7)
ffffffffc020646e:	854e                	mv	a0,s3
ffffffffc0206470:	0088bb03          	ld	s6,8(a7)
ffffffffc0206474:	f046                	sd	a7,32(sp)
ffffffffc0206476:	b0bfe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020647a:	7882                	ld	a7,32(sp)
ffffffffc020647c:	0168b823          	sd	s6,16(a7)
ffffffffc0206480:	00a8b423          	sd	a0,8(a7)
ffffffffc0206484:	010c2b03          	lw	s6,16(s8)
ffffffffc0206488:	e119                	bnez	a0,ffffffffc020648e <stride_dequeue+0x132e>
ffffffffc020648a:	56a0106f          	j	ffffffffc02079f4 <stride_dequeue+0x2894>
ffffffffc020648e:	01153023          	sd	a7,0(a0)
ffffffffc0206492:	89c6                	mv	s3,a7
ffffffffc0206494:	67e2                	ld	a5,24(sp)
ffffffffc0206496:	0134b423          	sd	s3,8(s1)
ffffffffc020649a:	e89c                	sd	a5,16(s1)
ffffffffc020649c:	0099b023          	sd	s1,0(s3)
ffffffffc02064a0:	89a6                	mv	s3,s1
ffffffffc02064a2:	67c2                	ld	a5,16(sp)
ffffffffc02064a4:	013a3423          	sd	s3,8(s4)
ffffffffc02064a8:	84d2                	mv	s1,s4
ffffffffc02064aa:	00fa3823          	sd	a5,16(s4)
ffffffffc02064ae:	0149b023          	sd	s4,0(s3)
ffffffffc02064b2:	89da                	mv	s3,s6
ffffffffc02064b4:	f00ff06f          	j	ffffffffc0205bb4 <stride_dequeue+0xa54>
ffffffffc02064b8:	0088b783          	ld	a5,8(a7)
ffffffffc02064bc:	0108b983          	ld	s3,16(a7)
ffffffffc02064c0:	f02a                	sd	a0,32(sp)
ffffffffc02064c2:	ec3e                	sd	a5,24(sp)
ffffffffc02064c4:	00099463          	bnez	s3,ffffffffc02064cc <stride_dequeue+0x136c>
ffffffffc02064c8:	0d40106f          	j	ffffffffc020759c <stride_dequeue+0x243c>
ffffffffc02064cc:	85d2                	mv	a1,s4
ffffffffc02064ce:	854e                	mv	a0,s3
ffffffffc02064d0:	f446                	sd	a7,40(sp)
ffffffffc02064d2:	a53fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02064d6:	7302                	ld	t1,32(sp)
ffffffffc02064d8:	78a2                	ld	a7,40(sp)
ffffffffc02064da:	00651463          	bne	a0,t1,ffffffffc02064e2 <stride_dequeue+0x1382>
ffffffffc02064de:	06c0106f          	j	ffffffffc020754a <stride_dequeue+0x23ea>
ffffffffc02064e2:	008a3783          	ld	a5,8(s4)
ffffffffc02064e6:	010a3e03          	ld	t3,16(s4)
ffffffffc02064ea:	fc1a                	sd	t1,56(sp)
ffffffffc02064ec:	f03e                	sd	a5,32(sp)
ffffffffc02064ee:	040e0663          	beqz	t3,ffffffffc020653a <stride_dequeue+0x13da>
ffffffffc02064f2:	85f2                	mv	a1,t3
ffffffffc02064f4:	854e                	mv	a0,s3
ffffffffc02064f6:	f846                	sd	a7,48(sp)
ffffffffc02064f8:	f472                	sd	t3,40(sp)
ffffffffc02064fa:	a2bfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02064fe:	7362                	ld	t1,56(sp)
ffffffffc0206500:	7e22                	ld	t3,40(sp)
ffffffffc0206502:	78c2                	ld	a7,48(sp)
ffffffffc0206504:	00651463          	bne	a0,t1,ffffffffc020650c <stride_dequeue+0x13ac>
ffffffffc0206508:	32e0106f          	j	ffffffffc0207836 <stride_dequeue+0x26d6>
ffffffffc020650c:	010e3583          	ld	a1,16(t3)
ffffffffc0206510:	854e                	mv	a0,s3
ffffffffc0206512:	008e3b03          	ld	s6,8(t3)
ffffffffc0206516:	f846                	sd	a7,48(sp)
ffffffffc0206518:	f472                	sd	t3,40(sp)
ffffffffc020651a:	a67fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020651e:	7e22                	ld	t3,40(sp)
ffffffffc0206520:	78c2                	ld	a7,48(sp)
ffffffffc0206522:	016e3823          	sd	s6,16(t3)
ffffffffc0206526:	00ae3423          	sd	a0,8(t3)
ffffffffc020652a:	010c2b03          	lw	s6,16(s8)
ffffffffc020652e:	e119                	bnez	a0,ffffffffc0206534 <stride_dequeue+0x13d4>
ffffffffc0206530:	58a0106f          	j	ffffffffc0207aba <stride_dequeue+0x295a>
ffffffffc0206534:	01c53023          	sd	t3,0(a0)
ffffffffc0206538:	89f2                	mv	s3,t3
ffffffffc020653a:	7782                	ld	a5,32(sp)
ffffffffc020653c:	013a3423          	sd	s3,8(s4)
ffffffffc0206540:	00fa3823          	sd	a5,16(s4)
ffffffffc0206544:	0149b023          	sd	s4,0(s3)
ffffffffc0206548:	89d2                	mv	s3,s4
ffffffffc020654a:	67e2                	ld	a5,24(sp)
ffffffffc020654c:	0138b423          	sd	s3,8(a7)
ffffffffc0206550:	8a46                	mv	s4,a7
ffffffffc0206552:	00f8b823          	sd	a5,16(a7)
ffffffffc0206556:	0119b023          	sd	a7,0(s3)
ffffffffc020655a:	89da                	mv	s3,s6
ffffffffc020655c:	f28ff06f          	j	ffffffffc0205c84 <stride_dequeue+0xb24>
ffffffffc0206560:	0088b783          	ld	a5,8(a7)
ffffffffc0206564:	0108b983          	ld	s3,16(a7)
ffffffffc0206568:	f02a                	sd	a0,32(sp)
ffffffffc020656a:	ec3e                	sd	a5,24(sp)
ffffffffc020656c:	00099463          	bnez	s3,ffffffffc0206574 <stride_dequeue+0x1414>
ffffffffc0206570:	0320106f          	j	ffffffffc02075a2 <stride_dequeue+0x2442>
ffffffffc0206574:	85ee                	mv	a1,s11
ffffffffc0206576:	854e                	mv	a0,s3
ffffffffc0206578:	f446                	sd	a7,40(sp)
ffffffffc020657a:	9abfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020657e:	7302                	ld	t1,32(sp)
ffffffffc0206580:	78a2                	ld	a7,40(sp)
ffffffffc0206582:	466508e3          	beq	a0,t1,ffffffffc02071f2 <stride_dequeue+0x2092>
ffffffffc0206586:	008db783          	ld	a5,8(s11)
ffffffffc020658a:	010dbe03          	ld	t3,16(s11)
ffffffffc020658e:	fc1a                	sd	t1,56(sp)
ffffffffc0206590:	f03e                	sd	a5,32(sp)
ffffffffc0206592:	040e0663          	beqz	t3,ffffffffc02065de <stride_dequeue+0x147e>
ffffffffc0206596:	85f2                	mv	a1,t3
ffffffffc0206598:	854e                	mv	a0,s3
ffffffffc020659a:	f846                	sd	a7,48(sp)
ffffffffc020659c:	f472                	sd	t3,40(sp)
ffffffffc020659e:	987fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02065a2:	7362                	ld	t1,56(sp)
ffffffffc02065a4:	7e22                	ld	t3,40(sp)
ffffffffc02065a6:	78c2                	ld	a7,48(sp)
ffffffffc02065a8:	00651463          	bne	a0,t1,ffffffffc02065b0 <stride_dequeue+0x1450>
ffffffffc02065ac:	3120106f          	j	ffffffffc02078be <stride_dequeue+0x275e>
ffffffffc02065b0:	010e3583          	ld	a1,16(t3)
ffffffffc02065b4:	854e                	mv	a0,s3
ffffffffc02065b6:	008e3b03          	ld	s6,8(t3)
ffffffffc02065ba:	f846                	sd	a7,48(sp)
ffffffffc02065bc:	f472                	sd	t3,40(sp)
ffffffffc02065be:	9c3fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02065c2:	7e22                	ld	t3,40(sp)
ffffffffc02065c4:	78c2                	ld	a7,48(sp)
ffffffffc02065c6:	016e3823          	sd	s6,16(t3)
ffffffffc02065ca:	00ae3423          	sd	a0,8(t3)
ffffffffc02065ce:	010c2b03          	lw	s6,16(s8)
ffffffffc02065d2:	e119                	bnez	a0,ffffffffc02065d8 <stride_dequeue+0x1478>
ffffffffc02065d4:	51c0106f          	j	ffffffffc0207af0 <stride_dequeue+0x2990>
ffffffffc02065d8:	01c53023          	sd	t3,0(a0)
ffffffffc02065dc:	89f2                	mv	s3,t3
ffffffffc02065de:	7782                	ld	a5,32(sp)
ffffffffc02065e0:	013db423          	sd	s3,8(s11)
ffffffffc02065e4:	00fdb823          	sd	a5,16(s11)
ffffffffc02065e8:	01b9b023          	sd	s11,0(s3)
ffffffffc02065ec:	89ee                	mv	s3,s11
ffffffffc02065ee:	67e2                	ld	a5,24(sp)
ffffffffc02065f0:	0138b423          	sd	s3,8(a7)
ffffffffc02065f4:	8dc6                	mv	s11,a7
ffffffffc02065f6:	00f8b823          	sd	a5,16(a7)
ffffffffc02065fa:	0119b023          	sd	a7,0(s3)
ffffffffc02065fe:	89da                	mv	s3,s6
ffffffffc0206600:	831ff06f          	j	ffffffffc0205e30 <stride_dequeue+0xcd0>
ffffffffc0206604:	0088b783          	ld	a5,8(a7)
ffffffffc0206608:	0108b983          	ld	s3,16(a7)
ffffffffc020660c:	ec2a                	sd	a0,24(sp)
ffffffffc020660e:	e83e                	sd	a5,16(sp)
ffffffffc0206610:	00099463          	bnez	s3,ffffffffc0206618 <stride_dequeue+0x14b8>
ffffffffc0206614:	7a10006f          	j	ffffffffc02075b4 <stride_dequeue+0x2454>
ffffffffc0206618:	85b2                	mv	a1,a2
ffffffffc020661a:	854e                	mv	a0,s3
ffffffffc020661c:	f446                	sd	a7,40(sp)
ffffffffc020661e:	907fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206622:	6362                	ld	t1,24(sp)
ffffffffc0206624:	7602                	ld	a2,32(sp)
ffffffffc0206626:	78a2                	ld	a7,40(sp)
ffffffffc0206628:	426500e3          	beq	a0,t1,ffffffffc0207248 <stride_dequeue+0x20e8>
ffffffffc020662c:	661c                	ld	a5,8(a2)
ffffffffc020662e:	01063e03          	ld	t3,16(a2)
ffffffffc0206632:	fc1a                	sd	t1,56(sp)
ffffffffc0206634:	ec3e                	sd	a5,24(sp)
ffffffffc0206636:	040e0a63          	beqz	t3,ffffffffc020668a <stride_dequeue+0x152a>
ffffffffc020663a:	85f2                	mv	a1,t3
ffffffffc020663c:	854e                	mv	a0,s3
ffffffffc020663e:	f846                	sd	a7,48(sp)
ffffffffc0206640:	f432                	sd	a2,40(sp)
ffffffffc0206642:	f072                	sd	t3,32(sp)
ffffffffc0206644:	8e1fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206648:	7362                	ld	t1,56(sp)
ffffffffc020664a:	7e02                	ld	t3,32(sp)
ffffffffc020664c:	7622                	ld	a2,40(sp)
ffffffffc020664e:	78c2                	ld	a7,48(sp)
ffffffffc0206650:	00651463          	bne	a0,t1,ffffffffc0206658 <stride_dequeue+0x14f8>
ffffffffc0206654:	20e0106f          	j	ffffffffc0207862 <stride_dequeue+0x2702>
ffffffffc0206658:	010e3583          	ld	a1,16(t3)
ffffffffc020665c:	854e                	mv	a0,s3
ffffffffc020665e:	008e3b03          	ld	s6,8(t3)
ffffffffc0206662:	f846                	sd	a7,48(sp)
ffffffffc0206664:	f432                	sd	a2,40(sp)
ffffffffc0206666:	f072                	sd	t3,32(sp)
ffffffffc0206668:	919fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020666c:	7e02                	ld	t3,32(sp)
ffffffffc020666e:	7622                	ld	a2,40(sp)
ffffffffc0206670:	78c2                	ld	a7,48(sp)
ffffffffc0206672:	016e3823          	sd	s6,16(t3)
ffffffffc0206676:	00ae3423          	sd	a0,8(t3)
ffffffffc020667a:	010c2b03          	lw	s6,16(s8)
ffffffffc020667e:	e119                	bnez	a0,ffffffffc0206684 <stride_dequeue+0x1524>
ffffffffc0206680:	4400106f          	j	ffffffffc0207ac0 <stride_dequeue+0x2960>
ffffffffc0206684:	01c53023          	sd	t3,0(a0)
ffffffffc0206688:	89f2                	mv	s3,t3
ffffffffc020668a:	67e2                	ld	a5,24(sp)
ffffffffc020668c:	01363423          	sd	s3,8(a2)
ffffffffc0206690:	ea1c                	sd	a5,16(a2)
ffffffffc0206692:	00c9b023          	sd	a2,0(s3)
ffffffffc0206696:	89b2                	mv	s3,a2
ffffffffc0206698:	67c2                	ld	a5,16(sp)
ffffffffc020669a:	0138b423          	sd	s3,8(a7)
ffffffffc020669e:	8646                	mv	a2,a7
ffffffffc02066a0:	00f8b823          	sd	a5,16(a7)
ffffffffc02066a4:	0119b023          	sd	a7,0(s3)
ffffffffc02066a8:	89da                	mv	s3,s6
ffffffffc02066aa:	eb6ff06f          	j	ffffffffc0205d60 <stride_dequeue+0xc00>
ffffffffc02066ae:	008cb783          	ld	a5,8(s9)
ffffffffc02066b2:	010cb983          	ld	s3,16(s9)
ffffffffc02066b6:	f02a                	sd	a0,32(sp)
ffffffffc02066b8:	ec3e                	sd	a5,24(sp)
ffffffffc02066ba:	00099463          	bnez	s3,ffffffffc02066c2 <stride_dequeue+0x1562>
ffffffffc02066be:	6eb0006f          	j	ffffffffc02075a8 <stride_dequeue+0x2448>
ffffffffc02066c2:	85c2                	mv	a1,a6
ffffffffc02066c4:	854e                	mv	a0,s3
ffffffffc02066c6:	f442                	sd	a6,40(sp)
ffffffffc02066c8:	85dfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02066cc:	7302                	ld	t1,32(sp)
ffffffffc02066ce:	7822                	ld	a6,40(sp)
ffffffffc02066d0:	3e650ee3          	beq	a0,t1,ffffffffc02072cc <stride_dequeue+0x216c>
ffffffffc02066d4:	00883783          	ld	a5,8(a6)
ffffffffc02066d8:	01083e03          	ld	t3,16(a6)
ffffffffc02066dc:	fc1a                	sd	t1,56(sp)
ffffffffc02066de:	f03e                	sd	a5,32(sp)
ffffffffc02066e0:	040e0663          	beqz	t3,ffffffffc020672c <stride_dequeue+0x15cc>
ffffffffc02066e4:	85f2                	mv	a1,t3
ffffffffc02066e6:	854e                	mv	a0,s3
ffffffffc02066e8:	f842                	sd	a6,48(sp)
ffffffffc02066ea:	f472                	sd	t3,40(sp)
ffffffffc02066ec:	839fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02066f0:	7362                	ld	t1,56(sp)
ffffffffc02066f2:	7e22                	ld	t3,40(sp)
ffffffffc02066f4:	7842                	ld	a6,48(sp)
ffffffffc02066f6:	00651463          	bne	a0,t1,ffffffffc02066fe <stride_dequeue+0x159e>
ffffffffc02066fa:	2a20106f          	j	ffffffffc020799c <stride_dequeue+0x283c>
ffffffffc02066fe:	010e3583          	ld	a1,16(t3)
ffffffffc0206702:	854e                	mv	a0,s3
ffffffffc0206704:	008e3b03          	ld	s6,8(t3)
ffffffffc0206708:	f842                	sd	a6,48(sp)
ffffffffc020670a:	f472                	sd	t3,40(sp)
ffffffffc020670c:	875fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206710:	7e22                	ld	t3,40(sp)
ffffffffc0206712:	7842                	ld	a6,48(sp)
ffffffffc0206714:	016e3823          	sd	s6,16(t3)
ffffffffc0206718:	00ae3423          	sd	a0,8(t3)
ffffffffc020671c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206720:	e119                	bnez	a0,ffffffffc0206726 <stride_dequeue+0x15c6>
ffffffffc0206722:	35c0106f          	j	ffffffffc0207a7e <stride_dequeue+0x291e>
ffffffffc0206726:	01c53023          	sd	t3,0(a0)
ffffffffc020672a:	89f2                	mv	s3,t3
ffffffffc020672c:	7782                	ld	a5,32(sp)
ffffffffc020672e:	01383423          	sd	s3,8(a6)
ffffffffc0206732:	00f83823          	sd	a5,16(a6)
ffffffffc0206736:	0109b023          	sd	a6,0(s3)
ffffffffc020673a:	89c2                	mv	s3,a6
ffffffffc020673c:	67e2                	ld	a5,24(sp)
ffffffffc020673e:	013cb423          	sd	s3,8(s9)
ffffffffc0206742:	00fcb823          	sd	a5,16(s9)
ffffffffc0206746:	0199b023          	sd	s9,0(s3)
ffffffffc020674a:	89da                	mv	s3,s6
ffffffffc020674c:	f89fe06f          	j	ffffffffc02056d4 <stride_dequeue+0x574>
ffffffffc0206750:	661c                	ld	a5,8(a2)
ffffffffc0206752:	01063983          	ld	s3,16(a2)
ffffffffc0206756:	ec2a                	sd	a0,24(sp)
ffffffffc0206758:	e83e                	sd	a5,16(sp)
ffffffffc020675a:	64098ae3          	beqz	s3,ffffffffc02075ae <stride_dequeue+0x244e>
ffffffffc020675e:	85c2                	mv	a1,a6
ffffffffc0206760:	854e                	mv	a0,s3
ffffffffc0206762:	f432                	sd	a2,40(sp)
ffffffffc0206764:	f042                	sd	a6,32(sp)
ffffffffc0206766:	fbefe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020676a:	6362                	ld	t1,24(sp)
ffffffffc020676c:	7802                	ld	a6,32(sp)
ffffffffc020676e:	7622                	ld	a2,40(sp)
ffffffffc0206770:	326509e3          	beq	a0,t1,ffffffffc02072a2 <stride_dequeue+0x2142>
ffffffffc0206774:	00883783          	ld	a5,8(a6)
ffffffffc0206778:	01083e03          	ld	t3,16(a6)
ffffffffc020677c:	fc1a                	sd	t1,56(sp)
ffffffffc020677e:	ec3e                	sd	a5,24(sp)
ffffffffc0206780:	040e0a63          	beqz	t3,ffffffffc02067d4 <stride_dequeue+0x1674>
ffffffffc0206784:	85f2                	mv	a1,t3
ffffffffc0206786:	854e                	mv	a0,s3
ffffffffc0206788:	f842                	sd	a6,48(sp)
ffffffffc020678a:	f432                	sd	a2,40(sp)
ffffffffc020678c:	f072                	sd	t3,32(sp)
ffffffffc020678e:	f96fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206792:	7362                	ld	t1,56(sp)
ffffffffc0206794:	7e02                	ld	t3,32(sp)
ffffffffc0206796:	7622                	ld	a2,40(sp)
ffffffffc0206798:	7842                	ld	a6,48(sp)
ffffffffc020679a:	00651463          	bne	a0,t1,ffffffffc02067a2 <stride_dequeue+0x1642>
ffffffffc020679e:	1760106f          	j	ffffffffc0207914 <stride_dequeue+0x27b4>
ffffffffc02067a2:	010e3583          	ld	a1,16(t3)
ffffffffc02067a6:	854e                	mv	a0,s3
ffffffffc02067a8:	008e3b03          	ld	s6,8(t3)
ffffffffc02067ac:	f842                	sd	a6,48(sp)
ffffffffc02067ae:	f432                	sd	a2,40(sp)
ffffffffc02067b0:	f072                	sd	t3,32(sp)
ffffffffc02067b2:	fcefe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02067b6:	7e02                	ld	t3,32(sp)
ffffffffc02067b8:	7622                	ld	a2,40(sp)
ffffffffc02067ba:	7842                	ld	a6,48(sp)
ffffffffc02067bc:	016e3823          	sd	s6,16(t3)
ffffffffc02067c0:	00ae3423          	sd	a0,8(t3)
ffffffffc02067c4:	010c2b03          	lw	s6,16(s8)
ffffffffc02067c8:	e119                	bnez	a0,ffffffffc02067ce <stride_dequeue+0x166e>
ffffffffc02067ca:	32c0106f          	j	ffffffffc0207af6 <stride_dequeue+0x2996>
ffffffffc02067ce:	01c53023          	sd	t3,0(a0)
ffffffffc02067d2:	89f2                	mv	s3,t3
ffffffffc02067d4:	67e2                	ld	a5,24(sp)
ffffffffc02067d6:	01383423          	sd	s3,8(a6)
ffffffffc02067da:	00f83823          	sd	a5,16(a6)
ffffffffc02067de:	0109b023          	sd	a6,0(s3)
ffffffffc02067e2:	89c2                	mv	s3,a6
ffffffffc02067e4:	67c2                	ld	a5,16(sp)
ffffffffc02067e6:	01363423          	sd	s3,8(a2)
ffffffffc02067ea:	ea1c                	sd	a5,16(a2)
ffffffffc02067ec:	00c9b023          	sd	a2,0(s3)
ffffffffc02067f0:	89da                	mv	s3,s6
ffffffffc02067f2:	ffffe06f          	j	ffffffffc02057f0 <stride_dequeue+0x690>
ffffffffc02067f6:	008a3783          	ld	a5,8(s4)
ffffffffc02067fa:	010a3983          	ld	s3,16(s4)
ffffffffc02067fe:	f02a                	sd	a0,32(sp)
ffffffffc0206800:	ec3e                	sd	a5,24(sp)
ffffffffc0206802:	5a098ce3          	beqz	s3,ffffffffc02075ba <stride_dequeue+0x245a>
ffffffffc0206806:	85c2                	mv	a1,a6
ffffffffc0206808:	854e                	mv	a0,s3
ffffffffc020680a:	f442                	sd	a6,40(sp)
ffffffffc020680c:	f18fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206810:	7302                	ld	t1,32(sp)
ffffffffc0206812:	7822                	ld	a6,40(sp)
ffffffffc0206814:	566501e3          	beq	a0,t1,ffffffffc0207576 <stride_dequeue+0x2416>
ffffffffc0206818:	00883783          	ld	a5,8(a6)
ffffffffc020681c:	01083e03          	ld	t3,16(a6)
ffffffffc0206820:	fc1a                	sd	t1,56(sp)
ffffffffc0206822:	f03e                	sd	a5,32(sp)
ffffffffc0206824:	040e0663          	beqz	t3,ffffffffc0206870 <stride_dequeue+0x1710>
ffffffffc0206828:	85f2                	mv	a1,t3
ffffffffc020682a:	854e                	mv	a0,s3
ffffffffc020682c:	f842                	sd	a6,48(sp)
ffffffffc020682e:	f472                	sd	t3,40(sp)
ffffffffc0206830:	ef4fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206834:	7362                	ld	t1,56(sp)
ffffffffc0206836:	7e22                	ld	t3,40(sp)
ffffffffc0206838:	7842                	ld	a6,48(sp)
ffffffffc020683a:	00651463          	bne	a0,t1,ffffffffc0206842 <stride_dequeue+0x16e2>
ffffffffc020683e:	18a0106f          	j	ffffffffc02079c8 <stride_dequeue+0x2868>
ffffffffc0206842:	010e3583          	ld	a1,16(t3)
ffffffffc0206846:	854e                	mv	a0,s3
ffffffffc0206848:	008e3b03          	ld	s6,8(t3)
ffffffffc020684c:	f842                	sd	a6,48(sp)
ffffffffc020684e:	f472                	sd	t3,40(sp)
ffffffffc0206850:	f30fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206854:	7e22                	ld	t3,40(sp)
ffffffffc0206856:	7842                	ld	a6,48(sp)
ffffffffc0206858:	016e3823          	sd	s6,16(t3)
ffffffffc020685c:	00ae3423          	sd	a0,8(t3)
ffffffffc0206860:	010c2b03          	lw	s6,16(s8)
ffffffffc0206864:	e119                	bnez	a0,ffffffffc020686a <stride_dequeue+0x170a>
ffffffffc0206866:	1ee0106f          	j	ffffffffc0207a54 <stride_dequeue+0x28f4>
ffffffffc020686a:	01c53023          	sd	t3,0(a0)
ffffffffc020686e:	89f2                	mv	s3,t3
ffffffffc0206870:	7782                	ld	a5,32(sp)
ffffffffc0206872:	01383423          	sd	s3,8(a6)
ffffffffc0206876:	00f83823          	sd	a5,16(a6)
ffffffffc020687a:	0109b023          	sd	a6,0(s3)
ffffffffc020687e:	89c2                	mv	s3,a6
ffffffffc0206880:	67e2                	ld	a5,24(sp)
ffffffffc0206882:	013a3423          	sd	s3,8(s4)
ffffffffc0206886:	00fa3823          	sd	a5,16(s4)
ffffffffc020688a:	0149b023          	sd	s4,0(s3)
ffffffffc020688e:	89da                	mv	s3,s6
ffffffffc0206890:	85eff06f          	j	ffffffffc02058ee <stride_dequeue+0x78e>
ffffffffc0206894:	008cb783          	ld	a5,8(s9)
ffffffffc0206898:	010cb983          	ld	s3,16(s9)
ffffffffc020689c:	f42a                	sd	a0,40(sp)
ffffffffc020689e:	f03e                	sd	a5,32(sp)
ffffffffc02068a0:	04098163          	beqz	s3,ffffffffc02068e2 <stride_dequeue+0x1782>
ffffffffc02068a4:	859a                	mv	a1,t1
ffffffffc02068a6:	854e                	mv	a0,s3
ffffffffc02068a8:	fc42                	sd	a6,56(sp)
ffffffffc02068aa:	f81a                	sd	t1,48(sp)
ffffffffc02068ac:	e78fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02068b0:	7e22                	ld	t3,40(sp)
ffffffffc02068b2:	7342                	ld	t1,48(sp)
ffffffffc02068b4:	7862                	ld	a6,56(sp)
ffffffffc02068b6:	11c505e3          	beq	a0,t3,ffffffffc02071c0 <stride_dequeue+0x2060>
ffffffffc02068ba:	01033583          	ld	a1,16(t1)
ffffffffc02068be:	854e                	mv	a0,s3
ffffffffc02068c0:	00833b03          	ld	s6,8(t1)
ffffffffc02068c4:	f842                	sd	a6,48(sp)
ffffffffc02068c6:	f41a                	sd	t1,40(sp)
ffffffffc02068c8:	eb8fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02068cc:	7322                	ld	t1,40(sp)
ffffffffc02068ce:	7842                	ld	a6,48(sp)
ffffffffc02068d0:	01633823          	sd	s6,16(t1)
ffffffffc02068d4:	00a33423          	sd	a0,8(t1)
ffffffffc02068d8:	010c2b03          	lw	s6,16(s8)
ffffffffc02068dc:	c119                	beqz	a0,ffffffffc02068e2 <stride_dequeue+0x1782>
ffffffffc02068de:	00653023          	sd	t1,0(a0)
ffffffffc02068e2:	7782                	ld	a5,32(sp)
ffffffffc02068e4:	006cb423          	sd	t1,8(s9)
ffffffffc02068e8:	89da                	mv	s3,s6
ffffffffc02068ea:	00fcb823          	sd	a5,16(s9)
ffffffffc02068ee:	01933023          	sd	s9,0(t1)
ffffffffc02068f2:	9aeff06f          	j	ffffffffc0205aa0 <stride_dequeue+0x940>
ffffffffc02068f6:	008db783          	ld	a5,8(s11)
ffffffffc02068fa:	010db983          	ld	s3,16(s11)
ffffffffc02068fe:	f02a                	sd	a0,32(sp)
ffffffffc0206900:	ec3e                	sd	a5,24(sp)
ffffffffc0206902:	04098563          	beqz	s3,ffffffffc020694c <stride_dequeue+0x17ec>
ffffffffc0206906:	859a                	mv	a1,t1
ffffffffc0206908:	854e                	mv	a0,s3
ffffffffc020690a:	fc42                	sd	a6,56(sp)
ffffffffc020690c:	f832                	sd	a2,48(sp)
ffffffffc020690e:	f41a                	sd	t1,40(sp)
ffffffffc0206910:	e14fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206914:	7e02                	ld	t3,32(sp)
ffffffffc0206916:	7322                	ld	t1,40(sp)
ffffffffc0206918:	7642                	ld	a2,48(sp)
ffffffffc020691a:	7862                	ld	a6,56(sp)
ffffffffc020691c:	15c50be3          	beq	a0,t3,ffffffffc0207272 <stride_dequeue+0x2112>
ffffffffc0206920:	01033583          	ld	a1,16(t1)
ffffffffc0206924:	854e                	mv	a0,s3
ffffffffc0206926:	00833b03          	ld	s6,8(t1)
ffffffffc020692a:	f842                	sd	a6,48(sp)
ffffffffc020692c:	f432                	sd	a2,40(sp)
ffffffffc020692e:	f01a                	sd	t1,32(sp)
ffffffffc0206930:	e50fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206934:	7302                	ld	t1,32(sp)
ffffffffc0206936:	7622                	ld	a2,40(sp)
ffffffffc0206938:	7842                	ld	a6,48(sp)
ffffffffc020693a:	01633823          	sd	s6,16(t1)
ffffffffc020693e:	00a33423          	sd	a0,8(t1)
ffffffffc0206942:	010c2b03          	lw	s6,16(s8)
ffffffffc0206946:	c119                	beqz	a0,ffffffffc020694c <stride_dequeue+0x17ec>
ffffffffc0206948:	00653023          	sd	t1,0(a0)
ffffffffc020694c:	67e2                	ld	a5,24(sp)
ffffffffc020694e:	006db423          	sd	t1,8(s11)
ffffffffc0206952:	89da                	mv	s3,s6
ffffffffc0206954:	00fdb823          	sd	a5,16(s11)
ffffffffc0206958:	01b33023          	sd	s11,0(t1)
ffffffffc020695c:	c3dfe06f          	j	ffffffffc0205598 <stride_dequeue+0x438>
ffffffffc0206960:	0088b783          	ld	a5,8(a7)
ffffffffc0206964:	0108b983          	ld	s3,16(a7)
ffffffffc0206968:	f42a                	sd	a0,40(sp)
ffffffffc020696a:	f03e                	sd	a5,32(sp)
ffffffffc020696c:	04098063          	beqz	s3,ffffffffc02069ac <stride_dequeue+0x184c>
ffffffffc0206970:	85c2                	mv	a1,a6
ffffffffc0206972:	854e                	mv	a0,s3
ffffffffc0206974:	fc46                	sd	a7,56(sp)
ffffffffc0206976:	daefe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc020697a:	7e22                	ld	t3,40(sp)
ffffffffc020697c:	7842                	ld	a6,48(sp)
ffffffffc020697e:	78e2                	ld	a7,56(sp)
ffffffffc0206980:	29c50de3          	beq	a0,t3,ffffffffc020741a <stride_dequeue+0x22ba>
ffffffffc0206984:	01083583          	ld	a1,16(a6)
ffffffffc0206988:	854e                	mv	a0,s3
ffffffffc020698a:	00883b03          	ld	s6,8(a6)
ffffffffc020698e:	f846                	sd	a7,48(sp)
ffffffffc0206990:	f442                	sd	a6,40(sp)
ffffffffc0206992:	deefe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206996:	7822                	ld	a6,40(sp)
ffffffffc0206998:	78c2                	ld	a7,48(sp)
ffffffffc020699a:	01683823          	sd	s6,16(a6)
ffffffffc020699e:	00a83423          	sd	a0,8(a6)
ffffffffc02069a2:	010c2b03          	lw	s6,16(s8)
ffffffffc02069a6:	c119                	beqz	a0,ffffffffc02069ac <stride_dequeue+0x184c>
ffffffffc02069a8:	01053023          	sd	a6,0(a0)
ffffffffc02069ac:	7782                	ld	a5,32(sp)
ffffffffc02069ae:	0108b423          	sd	a6,8(a7)
ffffffffc02069b2:	89da                	mv	s3,s6
ffffffffc02069b4:	00f8b823          	sd	a5,16(a7)
ffffffffc02069b8:	01183023          	sd	a7,0(a6)
ffffffffc02069bc:	8846                	mv	a6,a7
ffffffffc02069be:	d08ff06f          	j	ffffffffc0205ec6 <stride_dequeue+0xd66>
ffffffffc02069c2:	008db783          	ld	a5,8(s11)
ffffffffc02069c6:	010db983          	ld	s3,16(s11)
ffffffffc02069ca:	f42a                	sd	a0,40(sp)
ffffffffc02069cc:	f03e                	sd	a5,32(sp)
ffffffffc02069ce:	04098163          	beqz	s3,ffffffffc0206a10 <stride_dequeue+0x18b0>
ffffffffc02069d2:	859a                	mv	a1,t1
ffffffffc02069d4:	854e                	mv	a0,s3
ffffffffc02069d6:	fc42                	sd	a6,56(sp)
ffffffffc02069d8:	f81a                	sd	t1,48(sp)
ffffffffc02069da:	d4afe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc02069de:	7e22                	ld	t3,40(sp)
ffffffffc02069e0:	7342                	ld	t1,48(sp)
ffffffffc02069e2:	7862                	ld	a6,56(sp)
ffffffffc02069e4:	29c507e3          	beq	a0,t3,ffffffffc0207472 <stride_dequeue+0x2312>
ffffffffc02069e8:	01033583          	ld	a1,16(t1)
ffffffffc02069ec:	854e                	mv	a0,s3
ffffffffc02069ee:	00833b03          	ld	s6,8(t1)
ffffffffc02069f2:	f842                	sd	a6,48(sp)
ffffffffc02069f4:	f41a                	sd	t1,40(sp)
ffffffffc02069f6:	d8afe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02069fa:	7322                	ld	t1,40(sp)
ffffffffc02069fc:	7842                	ld	a6,48(sp)
ffffffffc02069fe:	01633823          	sd	s6,16(t1)
ffffffffc0206a02:	00a33423          	sd	a0,8(t1)
ffffffffc0206a06:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a0a:	c119                	beqz	a0,ffffffffc0206a10 <stride_dequeue+0x18b0>
ffffffffc0206a0c:	00653023          	sd	t1,0(a0)
ffffffffc0206a10:	7782                	ld	a5,32(sp)
ffffffffc0206a12:	006db423          	sd	t1,8(s11)
ffffffffc0206a16:	89da                	mv	s3,s6
ffffffffc0206a18:	00fdb823          	sd	a5,16(s11)
ffffffffc0206a1c:	01b33023          	sd	s11,0(t1)
ffffffffc0206a20:	a1ffe06f          	j	ffffffffc020543e <stride_dequeue+0x2de>
ffffffffc0206a24:	0088b783          	ld	a5,8(a7)
ffffffffc0206a28:	0108b983          	ld	s3,16(a7)
ffffffffc0206a2c:	f42a                	sd	a0,40(sp)
ffffffffc0206a2e:	f03e                	sd	a5,32(sp)
ffffffffc0206a30:	04098063          	beqz	s3,ffffffffc0206a70 <stride_dequeue+0x1910>
ffffffffc0206a34:	859a                	mv	a1,t1
ffffffffc0206a36:	854e                	mv	a0,s3
ffffffffc0206a38:	fc46                	sd	a7,56(sp)
ffffffffc0206a3a:	ceafe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206a3e:	7e22                	ld	t3,40(sp)
ffffffffc0206a40:	7342                	ld	t1,48(sp)
ffffffffc0206a42:	78e2                	ld	a7,56(sp)
ffffffffc0206a44:	73c50263          	beq	a0,t3,ffffffffc0207168 <stride_dequeue+0x2008>
ffffffffc0206a48:	01033583          	ld	a1,16(t1)
ffffffffc0206a4c:	854e                	mv	a0,s3
ffffffffc0206a4e:	00833b03          	ld	s6,8(t1)
ffffffffc0206a52:	f846                	sd	a7,48(sp)
ffffffffc0206a54:	f41a                	sd	t1,40(sp)
ffffffffc0206a56:	d2afe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206a5a:	7322                	ld	t1,40(sp)
ffffffffc0206a5c:	78c2                	ld	a7,48(sp)
ffffffffc0206a5e:	01633823          	sd	s6,16(t1)
ffffffffc0206a62:	00a33423          	sd	a0,8(t1)
ffffffffc0206a66:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a6a:	c119                	beqz	a0,ffffffffc0206a70 <stride_dequeue+0x1910>
ffffffffc0206a6c:	00653023          	sd	t1,0(a0)
ffffffffc0206a70:	7782                	ld	a5,32(sp)
ffffffffc0206a72:	0068b423          	sd	t1,8(a7)
ffffffffc0206a76:	89da                	mv	s3,s6
ffffffffc0206a78:	00f8b823          	sd	a5,16(a7)
ffffffffc0206a7c:	01133023          	sd	a7,0(t1)
ffffffffc0206a80:	f3dfe06f          	j	ffffffffc02059bc <stride_dequeue+0x85c>
ffffffffc0206a84:	01093503          	ld	a0,16(s2)
ffffffffc0206a88:	00893983          	ld	s3,8(s2)
ffffffffc0206a8c:	85da                	mv	a1,s6
ffffffffc0206a8e:	cf2fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206a92:	00a93423          	sd	a0,8(s2)
ffffffffc0206a96:	01393823          	sd	s3,16(s2)
ffffffffc0206a9a:	7822                	ld	a6,40(sp)
ffffffffc0206a9c:	77c2                	ld	a5,48(sp)
ffffffffc0206a9e:	010c2983          	lw	s3,16(s8)
ffffffffc0206aa2:	e119                	bnez	a0,ffffffffc0206aa8 <stride_dequeue+0x1948>
ffffffffc0206aa4:	803fe06f          	j	ffffffffc02052a6 <stride_dequeue+0x146>
ffffffffc0206aa8:	01253023          	sd	s2,0(a0)
ffffffffc0206aac:	ffafe06f          	j	ffffffffc02052a6 <stride_dequeue+0x146>
ffffffffc0206ab0:	0089b783          	ld	a5,8(s3)
ffffffffc0206ab4:	0109b803          	ld	a6,16(s3)
ffffffffc0206ab8:	f42a                	sd	a0,40(sp)
ffffffffc0206aba:	ec3e                	sd	a5,24(sp)
ffffffffc0206abc:	02080b63          	beqz	a6,ffffffffc0206af2 <stride_dequeue+0x1992>
ffffffffc0206ac0:	8542                	mv	a0,a6
ffffffffc0206ac2:	85d2                	mv	a1,s4
ffffffffc0206ac4:	f042                	sd	a6,32(sp)
ffffffffc0206ac6:	c5efe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206aca:	77a2                	ld	a5,40(sp)
ffffffffc0206acc:	7802                	ld	a6,32(sp)
ffffffffc0206ace:	3cf50be3          	beq	a0,a5,ffffffffc02076a4 <stride_dequeue+0x2544>
ffffffffc0206ad2:	010a3583          	ld	a1,16(s4)
ffffffffc0206ad6:	008a3b03          	ld	s6,8(s4)
ffffffffc0206ada:	8542                	mv	a0,a6
ffffffffc0206adc:	ca4fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206ae0:	00aa3423          	sd	a0,8(s4)
ffffffffc0206ae4:	016a3823          	sd	s6,16(s4)
ffffffffc0206ae8:	010c2b03          	lw	s6,16(s8)
ffffffffc0206aec:	c119                	beqz	a0,ffffffffc0206af2 <stride_dequeue+0x1992>
ffffffffc0206aee:	01453023          	sd	s4,0(a0)
ffffffffc0206af2:	67e2                	ld	a5,24(sp)
ffffffffc0206af4:	0149b423          	sd	s4,8(s3)
ffffffffc0206af8:	00f9b823          	sd	a5,16(s3)
ffffffffc0206afc:	013a3023          	sd	s3,0(s4)
ffffffffc0206b00:	8a4e                	mv	s4,s3
ffffffffc0206b02:	c90ff06f          	j	ffffffffc0205f92 <stride_dequeue+0xe32>
ffffffffc0206b06:	0089b783          	ld	a5,8(s3)
ffffffffc0206b0a:	0109b803          	ld	a6,16(s3)
ffffffffc0206b0e:	f42a                	sd	a0,40(sp)
ffffffffc0206b10:	ec3e                	sd	a5,24(sp)
ffffffffc0206b12:	02080b63          	beqz	a6,ffffffffc0206b48 <stride_dequeue+0x19e8>
ffffffffc0206b16:	8542                	mv	a0,a6
ffffffffc0206b18:	85e6                	mv	a1,s9
ffffffffc0206b1a:	f042                	sd	a6,32(sp)
ffffffffc0206b1c:	c08fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206b20:	77a2                	ld	a5,40(sp)
ffffffffc0206b22:	7802                	ld	a6,32(sp)
ffffffffc0206b24:	28f50ee3          	beq	a0,a5,ffffffffc02075c0 <stride_dequeue+0x2460>
ffffffffc0206b28:	010cb583          	ld	a1,16(s9)
ffffffffc0206b2c:	008cbb03          	ld	s6,8(s9)
ffffffffc0206b30:	8542                	mv	a0,a6
ffffffffc0206b32:	c4efe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206b36:	00acb423          	sd	a0,8(s9)
ffffffffc0206b3a:	016cb823          	sd	s6,16(s9)
ffffffffc0206b3e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b42:	c119                	beqz	a0,ffffffffc0206b48 <stride_dequeue+0x19e8>
ffffffffc0206b44:	01953023          	sd	s9,0(a0)
ffffffffc0206b48:	67e2                	ld	a5,24(sp)
ffffffffc0206b4a:	0199b423          	sd	s9,8(s3)
ffffffffc0206b4e:	00f9b823          	sd	a5,16(s3)
ffffffffc0206b52:	013cb023          	sd	s3,0(s9)
ffffffffc0206b56:	8cce                	mv	s9,s3
ffffffffc0206b58:	de4ff06f          	j	ffffffffc020613c <stride_dequeue+0xfdc>
ffffffffc0206b5c:	0089b783          	ld	a5,8(s3)
ffffffffc0206b60:	0109b803          	ld	a6,16(s3)
ffffffffc0206b64:	f42a                	sd	a0,40(sp)
ffffffffc0206b66:	e83e                	sd	a5,16(sp)
ffffffffc0206b68:	02080f63          	beqz	a6,ffffffffc0206ba6 <stride_dequeue+0x1a46>
ffffffffc0206b6c:	8542                	mv	a0,a6
ffffffffc0206b6e:	85d2                	mv	a1,s4
ffffffffc0206b70:	f032                	sd	a2,32(sp)
ffffffffc0206b72:	ec42                	sd	a6,24(sp)
ffffffffc0206b74:	bb0fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206b78:	77a2                	ld	a5,40(sp)
ffffffffc0206b7a:	6862                	ld	a6,24(sp)
ffffffffc0206b7c:	7602                	ld	a2,32(sp)
ffffffffc0206b7e:	26f506e3          	beq	a0,a5,ffffffffc02075ea <stride_dequeue+0x248a>
ffffffffc0206b82:	010a3583          	ld	a1,16(s4)
ffffffffc0206b86:	008a3b03          	ld	s6,8(s4)
ffffffffc0206b8a:	8542                	mv	a0,a6
ffffffffc0206b8c:	ec32                	sd	a2,24(sp)
ffffffffc0206b8e:	bf2fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206b92:	00aa3423          	sd	a0,8(s4)
ffffffffc0206b96:	016a3823          	sd	s6,16(s4)
ffffffffc0206b9a:	6662                	ld	a2,24(sp)
ffffffffc0206b9c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ba0:	c119                	beqz	a0,ffffffffc0206ba6 <stride_dequeue+0x1a46>
ffffffffc0206ba2:	01453023          	sd	s4,0(a0)
ffffffffc0206ba6:	67c2                	ld	a5,16(sp)
ffffffffc0206ba8:	0149b423          	sd	s4,8(s3)
ffffffffc0206bac:	00f9b823          	sd	a5,16(s3)
ffffffffc0206bb0:	013a3023          	sd	s3,0(s4)
ffffffffc0206bb4:	8a4e                	mv	s4,s3
ffffffffc0206bb6:	cb8ff06f          	j	ffffffffc020606e <stride_dequeue+0xf0e>
ffffffffc0206bba:	008a3783          	ld	a5,8(s4)
ffffffffc0206bbe:	010a3883          	ld	a7,16(s4)
ffffffffc0206bc2:	f42a                	sd	a0,40(sp)
ffffffffc0206bc4:	ec3e                	sd	a5,24(sp)
ffffffffc0206bc6:	02088b63          	beqz	a7,ffffffffc0206bfc <stride_dequeue+0x1a9c>
ffffffffc0206bca:	8546                	mv	a0,a7
ffffffffc0206bcc:	85ce                	mv	a1,s3
ffffffffc0206bce:	f046                	sd	a7,32(sp)
ffffffffc0206bd0:	b54fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206bd4:	77a2                	ld	a5,40(sp)
ffffffffc0206bd6:	7882                	ld	a7,32(sp)
ffffffffc0206bd8:	26f501e3          	beq	a0,a5,ffffffffc020763a <stride_dequeue+0x24da>
ffffffffc0206bdc:	0109b583          	ld	a1,16(s3)
ffffffffc0206be0:	0089bb03          	ld	s6,8(s3)
ffffffffc0206be4:	8546                	mv	a0,a7
ffffffffc0206be6:	b9afe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206bea:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bee:	0169b823          	sd	s6,16(s3)
ffffffffc0206bf2:	010c2b03          	lw	s6,16(s8)
ffffffffc0206bf6:	c119                	beqz	a0,ffffffffc0206bfc <stride_dequeue+0x1a9c>
ffffffffc0206bf8:	01353023          	sd	s3,0(a0)
ffffffffc0206bfc:	67e2                	ld	a5,24(sp)
ffffffffc0206bfe:	013a3423          	sd	s3,8(s4)
ffffffffc0206c02:	00fa3823          	sd	a5,16(s4)
ffffffffc0206c06:	0149b023          	sd	s4,0(s3)
ffffffffc0206c0a:	89d2                	mv	s3,s4
ffffffffc0206c0c:	f9bfe06f          	j	ffffffffc0205ba6 <stride_dequeue+0xa46>
ffffffffc0206c10:	008a3783          	ld	a5,8(s4)
ffffffffc0206c14:	010a3883          	ld	a7,16(s4)
ffffffffc0206c18:	fc2a                	sd	a0,56(sp)
ffffffffc0206c1a:	f03e                	sd	a5,32(sp)
ffffffffc0206c1c:	02088f63          	beqz	a7,ffffffffc0206c5a <stride_dequeue+0x1afa>
ffffffffc0206c20:	8546                	mv	a0,a7
ffffffffc0206c22:	85ce                	mv	a1,s3
ffffffffc0206c24:	f842                	sd	a6,48(sp)
ffffffffc0206c26:	f446                	sd	a7,40(sp)
ffffffffc0206c28:	afcfe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206c2c:	7e62                	ld	t3,56(sp)
ffffffffc0206c2e:	78a2                	ld	a7,40(sp)
ffffffffc0206c30:	7842                	ld	a6,48(sp)
ffffffffc0206c32:	35c509e3          	beq	a0,t3,ffffffffc0207784 <stride_dequeue+0x2624>
ffffffffc0206c36:	0109b583          	ld	a1,16(s3)
ffffffffc0206c3a:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c3e:	8546                	mv	a0,a7
ffffffffc0206c40:	f442                	sd	a6,40(sp)
ffffffffc0206c42:	b3efe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206c46:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c4a:	0169b823          	sd	s6,16(s3)
ffffffffc0206c4e:	7822                	ld	a6,40(sp)
ffffffffc0206c50:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c54:	c119                	beqz	a0,ffffffffc0206c5a <stride_dequeue+0x1afa>
ffffffffc0206c56:	01353023          	sd	s3,0(a0)
ffffffffc0206c5a:	7782                	ld	a5,32(sp)
ffffffffc0206c5c:	013a3423          	sd	s3,8(s4)
ffffffffc0206c60:	00fa3823          	sd	a5,16(s4)
ffffffffc0206c64:	0149b023          	sd	s4,0(s3)
ffffffffc0206c68:	89d2                	mv	s3,s4
ffffffffc0206c6a:	c73fe06f          	j	ffffffffc02058dc <stride_dequeue+0x77c>
ffffffffc0206c6e:	661c                	ld	a5,8(a2)
ffffffffc0206c70:	01063883          	ld	a7,16(a2)
ffffffffc0206c74:	fc2a                	sd	a0,56(sp)
ffffffffc0206c76:	ec3e                	sd	a5,24(sp)
ffffffffc0206c78:	04088363          	beqz	a7,ffffffffc0206cbe <stride_dequeue+0x1b5e>
ffffffffc0206c7c:	8546                	mv	a0,a7
ffffffffc0206c7e:	85ce                	mv	a1,s3
ffffffffc0206c80:	f842                	sd	a6,48(sp)
ffffffffc0206c82:	f432                	sd	a2,40(sp)
ffffffffc0206c84:	f046                	sd	a7,32(sp)
ffffffffc0206c86:	a9efe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206c8a:	7e62                	ld	t3,56(sp)
ffffffffc0206c8c:	7882                	ld	a7,32(sp)
ffffffffc0206c8e:	7622                	ld	a2,40(sp)
ffffffffc0206c90:	7842                	ld	a6,48(sp)
ffffffffc0206c92:	25c501e3          	beq	a0,t3,ffffffffc02076d4 <stride_dequeue+0x2574>
ffffffffc0206c96:	0109b583          	ld	a1,16(s3)
ffffffffc0206c9a:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c9e:	8546                	mv	a0,a7
ffffffffc0206ca0:	f442                	sd	a6,40(sp)
ffffffffc0206ca2:	f032                	sd	a2,32(sp)
ffffffffc0206ca4:	adcfe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206ca8:	00a9b423          	sd	a0,8(s3)
ffffffffc0206cac:	0169b823          	sd	s6,16(s3)
ffffffffc0206cb0:	7602                	ld	a2,32(sp)
ffffffffc0206cb2:	7822                	ld	a6,40(sp)
ffffffffc0206cb4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206cb8:	c119                	beqz	a0,ffffffffc0206cbe <stride_dequeue+0x1b5e>
ffffffffc0206cba:	01353023          	sd	s3,0(a0)
ffffffffc0206cbe:	67e2                	ld	a5,24(sp)
ffffffffc0206cc0:	01363423          	sd	s3,8(a2)
ffffffffc0206cc4:	ea1c                	sd	a5,16(a2)
ffffffffc0206cc6:	00c9b023          	sd	a2,0(s3)
ffffffffc0206cca:	89b2                	mv	s3,a2
ffffffffc0206ccc:	b13fe06f          	j	ffffffffc02057de <stride_dequeue+0x67e>
ffffffffc0206cd0:	89c6                	mv	s3,a7
ffffffffc0206cd2:	9e4ff06f          	j	ffffffffc0205eb6 <stride_dequeue+0xd56>
ffffffffc0206cd6:	0088b783          	ld	a5,8(a7)
ffffffffc0206cda:	0108b803          	ld	a6,16(a7)
ffffffffc0206cde:	fc2a                	sd	a0,56(sp)
ffffffffc0206ce0:	f03e                	sd	a5,32(sp)
ffffffffc0206ce2:	02080f63          	beqz	a6,ffffffffc0206d20 <stride_dequeue+0x1bc0>
ffffffffc0206ce6:	8542                	mv	a0,a6
ffffffffc0206ce8:	85ce                	mv	a1,s3
ffffffffc0206cea:	f846                	sd	a7,48(sp)
ffffffffc0206cec:	f442                	sd	a6,40(sp)
ffffffffc0206cee:	a36fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206cf2:	7e62                	ld	t3,56(sp)
ffffffffc0206cf4:	7822                	ld	a6,40(sp)
ffffffffc0206cf6:	78c2                	ld	a7,48(sp)
ffffffffc0206cf8:	47c50ce3          	beq	a0,t3,ffffffffc0207970 <stride_dequeue+0x2810>
ffffffffc0206cfc:	0109b583          	ld	a1,16(s3)
ffffffffc0206d00:	0089bb03          	ld	s6,8(s3)
ffffffffc0206d04:	8542                	mv	a0,a6
ffffffffc0206d06:	f446                	sd	a7,40(sp)
ffffffffc0206d08:	a78fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206d0c:	00a9b423          	sd	a0,8(s3)
ffffffffc0206d10:	0169b823          	sd	s6,16(s3)
ffffffffc0206d14:	78a2                	ld	a7,40(sp)
ffffffffc0206d16:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d1a:	c119                	beqz	a0,ffffffffc0206d20 <stride_dequeue+0x1bc0>
ffffffffc0206d1c:	01353023          	sd	s3,0(a0)
ffffffffc0206d20:	7782                	ld	a5,32(sp)
ffffffffc0206d22:	0138b423          	sd	s3,8(a7)
ffffffffc0206d26:	00f8b823          	sd	a5,16(a7)
ffffffffc0206d2a:	0119b023          	sd	a7,0(s3)
ffffffffc0206d2e:	89c6                	mv	s3,a7
ffffffffc0206d30:	8f0ff06f          	j	ffffffffc0205e20 <stride_dequeue+0xcc0>
ffffffffc0206d34:	0088b783          	ld	a5,8(a7)
ffffffffc0206d38:	0108b803          	ld	a6,16(a7)
ffffffffc0206d3c:	fc2a                	sd	a0,56(sp)
ffffffffc0206d3e:	f03e                	sd	a5,32(sp)
ffffffffc0206d40:	02080f63          	beqz	a6,ffffffffc0206d7e <stride_dequeue+0x1c1e>
ffffffffc0206d44:	8542                	mv	a0,a6
ffffffffc0206d46:	85ce                	mv	a1,s3
ffffffffc0206d48:	f846                	sd	a7,48(sp)
ffffffffc0206d4a:	f442                	sd	a6,40(sp)
ffffffffc0206d4c:	9d8fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206d50:	7e62                	ld	t3,56(sp)
ffffffffc0206d52:	7822                	ld	a6,40(sp)
ffffffffc0206d54:	78c2                	ld	a7,48(sp)
ffffffffc0206d56:	25c50de3          	beq	a0,t3,ffffffffc02077b0 <stride_dequeue+0x2650>
ffffffffc0206d5a:	0109b583          	ld	a1,16(s3)
ffffffffc0206d5e:	0089bb03          	ld	s6,8(s3)
ffffffffc0206d62:	8542                	mv	a0,a6
ffffffffc0206d64:	f446                	sd	a7,40(sp)
ffffffffc0206d66:	a1afe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206d6a:	00a9b423          	sd	a0,8(s3)
ffffffffc0206d6e:	0169b823          	sd	s6,16(s3)
ffffffffc0206d72:	78a2                	ld	a7,40(sp)
ffffffffc0206d74:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d78:	c119                	beqz	a0,ffffffffc0206d7e <stride_dequeue+0x1c1e>
ffffffffc0206d7a:	01353023          	sd	s3,0(a0)
ffffffffc0206d7e:	7782                	ld	a5,32(sp)
ffffffffc0206d80:	0138b423          	sd	s3,8(a7)
ffffffffc0206d84:	00f8b823          	sd	a5,16(a7)
ffffffffc0206d88:	0119b023          	sd	a7,0(s3)
ffffffffc0206d8c:	89c6                	mv	s3,a7
ffffffffc0206d8e:	ee7fe06f          	j	ffffffffc0205c74 <stride_dequeue+0xb14>
ffffffffc0206d92:	0088b783          	ld	a5,8(a7)
ffffffffc0206d96:	0108b803          	ld	a6,16(a7)
ffffffffc0206d9a:	fc2a                	sd	a0,56(sp)
ffffffffc0206d9c:	ec3e                	sd	a5,24(sp)
ffffffffc0206d9e:	04080263          	beqz	a6,ffffffffc0206de2 <stride_dequeue+0x1c82>
ffffffffc0206da2:	8542                	mv	a0,a6
ffffffffc0206da4:	85ce                	mv	a1,s3
ffffffffc0206da6:	f846                	sd	a7,48(sp)
ffffffffc0206da8:	f042                	sd	a6,32(sp)
ffffffffc0206daa:	97afe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206dae:	7e62                	ld	t3,56(sp)
ffffffffc0206db0:	7802                	ld	a6,32(sp)
ffffffffc0206db2:	7622                	ld	a2,40(sp)
ffffffffc0206db4:	78c2                	ld	a7,48(sp)
ffffffffc0206db6:	23c503e3          	beq	a0,t3,ffffffffc02077dc <stride_dequeue+0x267c>
ffffffffc0206dba:	0109b583          	ld	a1,16(s3)
ffffffffc0206dbe:	0089bb03          	ld	s6,8(s3)
ffffffffc0206dc2:	8542                	mv	a0,a6
ffffffffc0206dc4:	f446                	sd	a7,40(sp)
ffffffffc0206dc6:	f032                	sd	a2,32(sp)
ffffffffc0206dc8:	9b8fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206dcc:	00a9b423          	sd	a0,8(s3)
ffffffffc0206dd0:	0169b823          	sd	s6,16(s3)
ffffffffc0206dd4:	7602                	ld	a2,32(sp)
ffffffffc0206dd6:	78a2                	ld	a7,40(sp)
ffffffffc0206dd8:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ddc:	c119                	beqz	a0,ffffffffc0206de2 <stride_dequeue+0x1c82>
ffffffffc0206dde:	01353023          	sd	s3,0(a0)
ffffffffc0206de2:	67e2                	ld	a5,24(sp)
ffffffffc0206de4:	0138b423          	sd	s3,8(a7)
ffffffffc0206de8:	00f8b823          	sd	a5,16(a7)
ffffffffc0206dec:	0119b023          	sd	a7,0(s3)
ffffffffc0206df0:	89c6                	mv	s3,a7
ffffffffc0206df2:	f61fe06f          	j	ffffffffc0205d52 <stride_dequeue+0xbf2>
ffffffffc0206df6:	0089b783          	ld	a5,8(s3)
ffffffffc0206dfa:	0109b303          	ld	t1,16(s3)
ffffffffc0206dfe:	fc2a                	sd	a0,56(sp)
ffffffffc0206e00:	f03e                	sd	a5,32(sp)
ffffffffc0206e02:	02030f63          	beqz	t1,ffffffffc0206e40 <stride_dequeue+0x1ce0>
ffffffffc0206e06:	851a                	mv	a0,t1
ffffffffc0206e08:	85e6                	mv	a1,s9
ffffffffc0206e0a:	f846                	sd	a7,48(sp)
ffffffffc0206e0c:	f41a                	sd	t1,40(sp)
ffffffffc0206e0e:	916fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206e12:	7e62                	ld	t3,56(sp)
ffffffffc0206e14:	7322                	ld	t1,40(sp)
ffffffffc0206e16:	78c2                	ld	a7,48(sp)
ffffffffc0206e18:	11c50be3          	beq	a0,t3,ffffffffc020772e <stride_dequeue+0x25ce>
ffffffffc0206e1c:	010cb583          	ld	a1,16(s9)
ffffffffc0206e20:	008cbb03          	ld	s6,8(s9)
ffffffffc0206e24:	851a                	mv	a0,t1
ffffffffc0206e26:	f446                	sd	a7,40(sp)
ffffffffc0206e28:	958fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206e2c:	00acb423          	sd	a0,8(s9)
ffffffffc0206e30:	016cb823          	sd	s6,16(s9)
ffffffffc0206e34:	78a2                	ld	a7,40(sp)
ffffffffc0206e36:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e3a:	c119                	beqz	a0,ffffffffc0206e40 <stride_dequeue+0x1ce0>
ffffffffc0206e3c:	01953023          	sd	s9,0(a0)
ffffffffc0206e40:	7782                	ld	a5,32(sp)
ffffffffc0206e42:	0199b423          	sd	s9,8(s3)
ffffffffc0206e46:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e4a:	013cb023          	sd	s3,0(s9)
ffffffffc0206e4e:	8cce                	mv	s9,s3
ffffffffc0206e50:	b8aff06f          	j	ffffffffc02061da <stride_dequeue+0x107a>
ffffffffc0206e54:	89ee                	mv	s3,s11
ffffffffc0206e56:	dd6fe06f          	j	ffffffffc020542c <stride_dequeue+0x2cc>
ffffffffc0206e5a:	0089b783          	ld	a5,8(s3)
ffffffffc0206e5e:	0109b303          	ld	t1,16(s3)
ffffffffc0206e62:	fc2a                	sd	a0,56(sp)
ffffffffc0206e64:	f03e                	sd	a5,32(sp)
ffffffffc0206e66:	02030f63          	beqz	t1,ffffffffc0206ea4 <stride_dequeue+0x1d44>
ffffffffc0206e6a:	85c2                	mv	a1,a6
ffffffffc0206e6c:	851a                	mv	a0,t1
ffffffffc0206e6e:	f842                	sd	a6,48(sp)
ffffffffc0206e70:	f41a                	sd	t1,40(sp)
ffffffffc0206e72:	8b2fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206e76:	7e62                	ld	t3,56(sp)
ffffffffc0206e78:	7322                	ld	t1,40(sp)
ffffffffc0206e7a:	7842                	ld	a6,48(sp)
ffffffffc0206e7c:	0dc50fe3          	beq	a0,t3,ffffffffc020775a <stride_dequeue+0x25fa>
ffffffffc0206e80:	01083583          	ld	a1,16(a6)
ffffffffc0206e84:	851a                	mv	a0,t1
ffffffffc0206e86:	00883b03          	ld	s6,8(a6)
ffffffffc0206e8a:	f442                	sd	a6,40(sp)
ffffffffc0206e8c:	8f4fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206e90:	7822                	ld	a6,40(sp)
ffffffffc0206e92:	01683823          	sd	s6,16(a6)
ffffffffc0206e96:	00a83423          	sd	a0,8(a6)
ffffffffc0206e9a:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e9e:	c119                	beqz	a0,ffffffffc0206ea4 <stride_dequeue+0x1d44>
ffffffffc0206ea0:	01053023          	sd	a6,0(a0)
ffffffffc0206ea4:	7782                	ld	a5,32(sp)
ffffffffc0206ea6:	0109b423          	sd	a6,8(s3)
ffffffffc0206eaa:	00f9b823          	sd	a5,16(s3)
ffffffffc0206eae:	01383023          	sd	s3,0(a6)
ffffffffc0206eb2:	884e                	mv	a6,s3
ffffffffc0206eb4:	bc4ff06f          	j	ffffffffc0206278 <stride_dequeue+0x1118>
ffffffffc0206eb8:	008cb783          	ld	a5,8(s9)
ffffffffc0206ebc:	010cb883          	ld	a7,16(s9)
ffffffffc0206ec0:	fc2a                	sd	a0,56(sp)
ffffffffc0206ec2:	f03e                	sd	a5,32(sp)
ffffffffc0206ec4:	02088f63          	beqz	a7,ffffffffc0206f02 <stride_dequeue+0x1da2>
ffffffffc0206ec8:	8546                	mv	a0,a7
ffffffffc0206eca:	85ce                	mv	a1,s3
ffffffffc0206ecc:	f842                	sd	a6,48(sp)
ffffffffc0206ece:	f446                	sd	a7,40(sp)
ffffffffc0206ed0:	854fe0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206ed4:	7e62                	ld	t3,56(sp)
ffffffffc0206ed6:	78a2                	ld	a7,40(sp)
ffffffffc0206ed8:	7842                	ld	a6,48(sp)
ffffffffc0206eda:	27c505e3          	beq	a0,t3,ffffffffc0207944 <stride_dequeue+0x27e4>
ffffffffc0206ede:	0109b583          	ld	a1,16(s3)
ffffffffc0206ee2:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ee6:	8546                	mv	a0,a7
ffffffffc0206ee8:	f442                	sd	a6,40(sp)
ffffffffc0206eea:	896fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206eee:	00a9b423          	sd	a0,8(s3)
ffffffffc0206ef2:	0169b823          	sd	s6,16(s3)
ffffffffc0206ef6:	7822                	ld	a6,40(sp)
ffffffffc0206ef8:	010c2b03          	lw	s6,16(s8)
ffffffffc0206efc:	c119                	beqz	a0,ffffffffc0206f02 <stride_dequeue+0x1da2>
ffffffffc0206efe:	01353023          	sd	s3,0(a0)
ffffffffc0206f02:	7782                	ld	a5,32(sp)
ffffffffc0206f04:	013cb423          	sd	s3,8(s9)
ffffffffc0206f08:	00fcb823          	sd	a5,16(s9)
ffffffffc0206f0c:	0199b023          	sd	s9,0(s3)
ffffffffc0206f10:	89e6                	mv	s3,s9
ffffffffc0206f12:	fb0fe06f          	j	ffffffffc02056c2 <stride_dequeue+0x562>
ffffffffc0206f16:	0089b783          	ld	a5,8(s3)
ffffffffc0206f1a:	0109b303          	ld	t1,16(s3)
ffffffffc0206f1e:	fc2a                	sd	a0,56(sp)
ffffffffc0206f20:	f03e                	sd	a5,32(sp)
ffffffffc0206f22:	02030f63          	beqz	t1,ffffffffc0206f60 <stride_dequeue+0x1e00>
ffffffffc0206f26:	85c2                	mv	a1,a6
ffffffffc0206f28:	851a                	mv	a0,t1
ffffffffc0206f2a:	f842                	sd	a6,48(sp)
ffffffffc0206f2c:	f41a                	sd	t1,40(sp)
ffffffffc0206f2e:	ff7fd0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206f32:	7e62                	ld	t3,56(sp)
ffffffffc0206f34:	7322                	ld	t1,40(sp)
ffffffffc0206f36:	7842                	ld	a6,48(sp)
ffffffffc0206f38:	1bc509e3          	beq	a0,t3,ffffffffc02078ea <stride_dequeue+0x278a>
ffffffffc0206f3c:	01083583          	ld	a1,16(a6)
ffffffffc0206f40:	851a                	mv	a0,t1
ffffffffc0206f42:	00883b03          	ld	s6,8(a6)
ffffffffc0206f46:	f442                	sd	a6,40(sp)
ffffffffc0206f48:	838fe0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206f4c:	7822                	ld	a6,40(sp)
ffffffffc0206f4e:	01683823          	sd	s6,16(a6)
ffffffffc0206f52:	00a83423          	sd	a0,8(a6)
ffffffffc0206f56:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f5a:	c119                	beqz	a0,ffffffffc0206f60 <stride_dequeue+0x1e00>
ffffffffc0206f5c:	01053023          	sd	a6,0(a0)
ffffffffc0206f60:	7782                	ld	a5,32(sp)
ffffffffc0206f62:	0109b423          	sd	a6,8(s3)
ffffffffc0206f66:	00f9b823          	sd	a5,16(s3)
ffffffffc0206f6a:	01383023          	sd	s3,0(a6)
ffffffffc0206f6e:	884e                	mv	a6,s3
ffffffffc0206f70:	ba4ff06f          	j	ffffffffc0206314 <stride_dequeue+0x11b4>
ffffffffc0206f74:	0089b783          	ld	a5,8(s3)
ffffffffc0206f78:	0109b303          	ld	t1,16(s3)
ffffffffc0206f7c:	fc2a                	sd	a0,56(sp)
ffffffffc0206f7e:	ec3e                	sd	a5,24(sp)
ffffffffc0206f80:	04030363          	beqz	t1,ffffffffc0206fc6 <stride_dequeue+0x1e66>
ffffffffc0206f84:	85c2                	mv	a1,a6
ffffffffc0206f86:	851a                	mv	a0,t1
ffffffffc0206f88:	f832                	sd	a2,48(sp)
ffffffffc0206f8a:	f442                	sd	a6,40(sp)
ffffffffc0206f8c:	f01a                	sd	t1,32(sp)
ffffffffc0206f8e:	f97fd0ef          	jal	ra,ffffffffc0204f24 <proc_stride_comp_f>
ffffffffc0206f92:	7642                	ld	a2,48(sp)
ffffffffc0206f94:	7e62                	ld	t3,56(sp)
ffffffffc0206f96:	7822                	ld	a6,40(sp)
ffffffffc0206f98:	f432                	sd	a2,40(sp)
ffffffffc0206f9a:	7302                	ld	t1,32(sp)
ffffffffc0206f9c:	29c507e3          	beq	a0,t3,ffffffffc0207a2a <stride_dequeue+0x28ca>
ffffffffc0206fa0:	01083583          	ld	a1,16(a6)
ffffffffc0206fa4:	851a                	mv	a0,t1
ffffffffc0206fa6:	00883b03          	ld	s6,8(a6)
ffffffffc0206faa:	f042                	sd	a6,32(sp)
ffffffffc0206fac:	fd5fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0206fb0:	7802                	ld	a6,32(sp)
ffffffffc0206fb2:	7622                	ld	a2,40(sp)
ffffffffc0206fb4:	01683823          	sd	s6,16(a6)
ffffffffc0206fb8:	00a83423          	sd	a0,8(a6)
ffffffffc0206fbc:	010c2b03          	lw	s6,16(s8)
ffffffffc0206fc0:	c119                	beqz	a0,ffffffffc0206fc6 <stride_dequeue+0x1e66>
ffffffffc0206fc2:	01053023          	sd	a6,0(a0)
ffffffffc0206fc6:	67e2                	ld	a5,24(sp)
ffffffffc0206fc8:	0109b423          	sd	a6,8(s3)
ffffffffc0206fcc:	00f9b823          	sd	a5,16(s3)
ffffffffc0206fd0:	01383023          	sd	s3,0(a6)
ffffffffc0206fd4:	884e                	mv	a6,s3
ffffffffc0206fd6:	be2ff06f          	j	ffffffffc02063b8 <stride_dequeue+0x1258>
ffffffffc0206fda:	89c6                	mv	s3,a7
ffffffffc0206fdc:	9cffe06f          	j	ffffffffc02059aa <stride_dequeue+0x84a>
ffffffffc0206fe0:	89e6                	mv	s3,s9
ffffffffc0206fe2:	aadfe06f          	j	ffffffffc0205a8e <stride_dequeue+0x92e>
ffffffffc0206fe6:	89ee                	mv	s3,s11
ffffffffc0206fe8:	d9efe06f          	j	ffffffffc0205586 <stride_dequeue+0x426>
ffffffffc0206fec:	89d2                	mv	s3,s4
ffffffffc0206fee:	bb9fe06f          	j	ffffffffc0205ba6 <stride_dequeue+0xa46>
ffffffffc0206ff2:	0108b503          	ld	a0,16(a7)
ffffffffc0206ff6:	85ce                	mv	a1,s3
ffffffffc0206ff8:	0088bb03          	ld	s6,8(a7)
ffffffffc0206ffc:	f81a                	sd	t1,48(sp)
ffffffffc0206ffe:	f446                	sd	a7,40(sp)
ffffffffc0207000:	f81fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207004:	78a2                	ld	a7,40(sp)
ffffffffc0207006:	7342                	ld	t1,48(sp)
ffffffffc0207008:	0168b823          	sd	s6,16(a7)
ffffffffc020700c:	00a8b423          	sd	a0,8(a7)
ffffffffc0207010:	010c2b03          	lw	s6,16(s8)
ffffffffc0207014:	d179                	beqz	a0,ffffffffc0206fda <stride_dequeue+0x1e7a>
ffffffffc0207016:	01153023          	sd	a7,0(a0)
ffffffffc020701a:	89c6                	mv	s3,a7
ffffffffc020701c:	98ffe06f          	j	ffffffffc02059aa <stride_dequeue+0x84a>
ffffffffc0207020:	0109b503          	ld	a0,16(s3)
ffffffffc0207024:	0089bb03          	ld	s6,8(s3)
ffffffffc0207028:	85be                	mv	a1,a5
ffffffffc020702a:	f442                	sd	a6,40(sp)
ffffffffc020702c:	f55fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207030:	00a9b423          	sd	a0,8(s3)
ffffffffc0207034:	0169b823          	sd	s6,16(s3)
ffffffffc0207038:	7822                	ld	a6,40(sp)
ffffffffc020703a:	010c2b03          	lw	s6,16(s8)
ffffffffc020703e:	5e050b63          	beqz	a0,ffffffffc0207634 <stride_dequeue+0x24d4>
ffffffffc0207042:	01353023          	sd	s3,0(a0)
ffffffffc0207046:	87ce                	mv	a5,s3
ffffffffc0207048:	bccff06f          	j	ffffffffc0206414 <stride_dequeue+0x12b4>
ffffffffc020704c:	010cb503          	ld	a0,16(s9)
ffffffffc0207050:	008cbb03          	ld	s6,8(s9)
ffffffffc0207054:	85ce                	mv	a1,s3
ffffffffc0207056:	f2bfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020705a:	00acb423          	sd	a0,8(s9)
ffffffffc020705e:	016cb823          	sd	s6,16(s9)
ffffffffc0207062:	7822                	ld	a6,40(sp)
ffffffffc0207064:	7342                	ld	t1,48(sp)
ffffffffc0207066:	010c2b03          	lw	s6,16(s8)
ffffffffc020706a:	d93d                	beqz	a0,ffffffffc0206fe0 <stride_dequeue+0x1e80>
ffffffffc020706c:	01953023          	sd	s9,0(a0)
ffffffffc0207070:	89e6                	mv	s3,s9
ffffffffc0207072:	a1dfe06f          	j	ffffffffc0205a8e <stride_dequeue+0x92e>
ffffffffc0207076:	0108b503          	ld	a0,16(a7)
ffffffffc020707a:	85ce                	mv	a1,s3
ffffffffc020707c:	0088bb03          	ld	s6,8(a7)
ffffffffc0207080:	f842                	sd	a6,48(sp)
ffffffffc0207082:	f446                	sd	a7,40(sp)
ffffffffc0207084:	efdfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207088:	78a2                	ld	a7,40(sp)
ffffffffc020708a:	7842                	ld	a6,48(sp)
ffffffffc020708c:	0168b823          	sd	s6,16(a7)
ffffffffc0207090:	00a8b423          	sd	a0,8(a7)
ffffffffc0207094:	010c2b03          	lw	s6,16(s8)
ffffffffc0207098:	c2050ce3          	beqz	a0,ffffffffc0206cd0 <stride_dequeue+0x1b70>
ffffffffc020709c:	01153023          	sd	a7,0(a0)
ffffffffc02070a0:	89c6                	mv	s3,a7
ffffffffc02070a2:	e15fe06f          	j	ffffffffc0205eb6 <stride_dequeue+0xd56>
ffffffffc02070a6:	010db503          	ld	a0,16(s11)
ffffffffc02070aa:	008dbb03          	ld	s6,8(s11)
ffffffffc02070ae:	85ce                	mv	a1,s3
ffffffffc02070b0:	ed1fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02070b4:	00adb423          	sd	a0,8(s11)
ffffffffc02070b8:	016db823          	sd	s6,16(s11)
ffffffffc02070bc:	7602                	ld	a2,32(sp)
ffffffffc02070be:	7822                	ld	a6,40(sp)
ffffffffc02070c0:	7342                	ld	t1,48(sp)
ffffffffc02070c2:	010c2b03          	lw	s6,16(s8)
ffffffffc02070c6:	d105                	beqz	a0,ffffffffc0206fe6 <stride_dequeue+0x1e86>
ffffffffc02070c8:	01b53023          	sd	s11,0(a0)
ffffffffc02070cc:	89ee                	mv	s3,s11
ffffffffc02070ce:	cb8fe06f          	j	ffffffffc0205586 <stride_dequeue+0x426>
ffffffffc02070d2:	010db503          	ld	a0,16(s11)
ffffffffc02070d6:	008dbb03          	ld	s6,8(s11)
ffffffffc02070da:	85ce                	mv	a1,s3
ffffffffc02070dc:	ea5fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02070e0:	00adb423          	sd	a0,8(s11)
ffffffffc02070e4:	016db823          	sd	s6,16(s11)
ffffffffc02070e8:	7322                	ld	t1,40(sp)
ffffffffc02070ea:	7842                	ld	a6,48(sp)
ffffffffc02070ec:	010c2b03          	lw	s6,16(s8)
ffffffffc02070f0:	d60502e3          	beqz	a0,ffffffffc0206e54 <stride_dequeue+0x1cf4>
ffffffffc02070f4:	01b53023          	sd	s11,0(a0)
ffffffffc02070f8:	89ee                	mv	s3,s11
ffffffffc02070fa:	b32fe06f          	j	ffffffffc020542c <stride_dequeue+0x2cc>
ffffffffc02070fe:	89e6                	mv	s3,s9
ffffffffc0207100:	dc2fe06f          	j	ffffffffc02056c2 <stride_dequeue+0x562>
ffffffffc0207104:	89c6                	mv	s3,a7
ffffffffc0207106:	d1bfe06f          	j	ffffffffc0205e20 <stride_dequeue+0xcc0>
ffffffffc020710a:	00003697          	auipc	a3,0x3
ffffffffc020710e:	bce68693          	addi	a3,a3,-1074 # ffffffffc0209cd8 <default_pmm_manager+0x860>
ffffffffc0207112:	00001617          	auipc	a2,0x1
ffffffffc0207116:	62660613          	addi	a2,a2,1574 # ffffffffc0208738 <commands+0x410>
ffffffffc020711a:	06300593          	li	a1,99
ffffffffc020711e:	00003517          	auipc	a0,0x3
ffffffffc0207122:	be250513          	addi	a0,a0,-1054 # ffffffffc0209d00 <default_pmm_manager+0x888>
ffffffffc0207126:	8e2f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020712a:	89d2                	mv	s3,s4
ffffffffc020712c:	fb0fe06f          	j	ffffffffc02058dc <stride_dequeue+0x77c>
ffffffffc0207130:	89c6                	mv	s3,a7
ffffffffc0207132:	c21fe06f          	j	ffffffffc0205d52 <stride_dequeue+0xbf2>
ffffffffc0207136:	89c6                	mv	s3,a7
ffffffffc0207138:	b3dfe06f          	j	ffffffffc0205c74 <stride_dequeue+0xb14>
ffffffffc020713c:	89b2                	mv	s3,a2
ffffffffc020713e:	ea0fe06f          	j	ffffffffc02057de <stride_dequeue+0x67e>
ffffffffc0207142:	0109b503          	ld	a0,16(s3)
ffffffffc0207146:	0089bb03          	ld	s6,8(s3)
ffffffffc020714a:	85a6                	mv	a1,s1
ffffffffc020714c:	e35fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207150:	00a9b423          	sd	a0,8(s3)
ffffffffc0207154:	0169b823          	sd	s6,16(s3)
ffffffffc0207158:	010c2b03          	lw	s6,16(s8)
ffffffffc020715c:	b4050363          	beqz	a0,ffffffffc02064a2 <stride_dequeue+0x1342>
ffffffffc0207160:	01353023          	sd	s3,0(a0)
ffffffffc0207164:	b3eff06f          	j	ffffffffc02064a2 <stride_dequeue+0x1342>
ffffffffc0207168:	0109b503          	ld	a0,16(s3)
ffffffffc020716c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207170:	859a                	mv	a1,t1
ffffffffc0207172:	f446                	sd	a7,40(sp)
ffffffffc0207174:	e0dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207178:	00a9b423          	sd	a0,8(s3)
ffffffffc020717c:	0169b823          	sd	s6,16(s3)
ffffffffc0207180:	78a2                	ld	a7,40(sp)
ffffffffc0207182:	010c2b03          	lw	s6,16(s8)
ffffffffc0207186:	100505e3          	beqz	a0,ffffffffc0207a90 <stride_dequeue+0x2930>
ffffffffc020718a:	01353023          	sd	s3,0(a0)
ffffffffc020718e:	834e                	mv	t1,s3
ffffffffc0207190:	b0c5                	j	ffffffffc0206a70 <stride_dequeue+0x1910>
ffffffffc0207192:	0109b503          	ld	a0,16(s3)
ffffffffc0207196:	0089bb03          	ld	s6,8(s3)
ffffffffc020719a:	85f2                	mv	a1,t3
ffffffffc020719c:	f442                	sd	a6,40(sp)
ffffffffc020719e:	f032                	sd	a2,32(sp)
ffffffffc02071a0:	de1fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02071a4:	00a9b423          	sd	a0,8(s3)
ffffffffc02071a8:	0169b823          	sd	s6,16(s3)
ffffffffc02071ac:	7602                	ld	a2,32(sp)
ffffffffc02071ae:	7822                	ld	a6,40(sp)
ffffffffc02071b0:	010c2b03          	lw	s6,16(s8)
ffffffffc02071b4:	9e050b63          	beqz	a0,ffffffffc02063aa <stride_dequeue+0x124a>
ffffffffc02071b8:	01353023          	sd	s3,0(a0)
ffffffffc02071bc:	9eeff06f          	j	ffffffffc02063aa <stride_dequeue+0x124a>
ffffffffc02071c0:	0109b503          	ld	a0,16(s3)
ffffffffc02071c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02071c8:	859a                	mv	a1,t1
ffffffffc02071ca:	f442                	sd	a6,40(sp)
ffffffffc02071cc:	db5fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02071d0:	00a9b423          	sd	a0,8(s3)
ffffffffc02071d4:	0169b823          	sd	s6,16(s3)
ffffffffc02071d8:	7822                	ld	a6,40(sp)
ffffffffc02071da:	010c2b03          	lw	s6,16(s8)
ffffffffc02071de:	08050de3          	beqz	a0,ffffffffc0207a78 <stride_dequeue+0x2918>
ffffffffc02071e2:	01353023          	sd	s3,0(a0)
ffffffffc02071e6:	834e                	mv	t1,s3
ffffffffc02071e8:	efaff06f          	j	ffffffffc02068e2 <stride_dequeue+0x1782>
ffffffffc02071ec:	89a6                	mv	s3,s1
ffffffffc02071ee:	ab4ff06f          	j	ffffffffc02064a2 <stride_dequeue+0x1342>
ffffffffc02071f2:	0109b503          	ld	a0,16(s3)
ffffffffc02071f6:	0089bb03          	ld	s6,8(s3)
ffffffffc02071fa:	85ee                	mv	a1,s11
ffffffffc02071fc:	f046                	sd	a7,32(sp)
ffffffffc02071fe:	d83fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207202:	00a9b423          	sd	a0,8(s3)
ffffffffc0207206:	0169b823          	sd	s6,16(s3)
ffffffffc020720a:	7882                	ld	a7,32(sp)
ffffffffc020720c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207210:	bc050f63          	beqz	a0,ffffffffc02065ee <stride_dequeue+0x148e>
ffffffffc0207214:	01353023          	sd	s3,0(a0)
ffffffffc0207218:	bd6ff06f          	j	ffffffffc02065ee <stride_dequeue+0x148e>
ffffffffc020721c:	0109b503          	ld	a0,16(s3)
ffffffffc0207220:	0089bb03          	ld	s6,8(s3)
ffffffffc0207224:	85f2                	mv	a1,t3
ffffffffc0207226:	f442                	sd	a6,40(sp)
ffffffffc0207228:	d59fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020722c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207230:	0169b823          	sd	s6,16(s3)
ffffffffc0207234:	7822                	ld	a6,40(sp)
ffffffffc0207236:	010c2b03          	lw	s6,16(s8)
ffffffffc020723a:	e119                	bnez	a0,ffffffffc0207240 <stride_dequeue+0x20e0>
ffffffffc020723c:	8caff06f          	j	ffffffffc0206306 <stride_dequeue+0x11a6>
ffffffffc0207240:	01353023          	sd	s3,0(a0)
ffffffffc0207244:	8c2ff06f          	j	ffffffffc0206306 <stride_dequeue+0x11a6>
ffffffffc0207248:	0109b503          	ld	a0,16(s3)
ffffffffc020724c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207250:	85b2                	mv	a1,a2
ffffffffc0207252:	ec46                	sd	a7,24(sp)
ffffffffc0207254:	d2dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207258:	00a9b423          	sd	a0,8(s3)
ffffffffc020725c:	0169b823          	sd	s6,16(s3)
ffffffffc0207260:	68e2                	ld	a7,24(sp)
ffffffffc0207262:	010c2b03          	lw	s6,16(s8)
ffffffffc0207266:	c2050963          	beqz	a0,ffffffffc0206698 <stride_dequeue+0x1538>
ffffffffc020726a:	01353023          	sd	s3,0(a0)
ffffffffc020726e:	c2aff06f          	j	ffffffffc0206698 <stride_dequeue+0x1538>
ffffffffc0207272:	0109b503          	ld	a0,16(s3)
ffffffffc0207276:	0089bb03          	ld	s6,8(s3)
ffffffffc020727a:	859a                	mv	a1,t1
ffffffffc020727c:	f442                	sd	a6,40(sp)
ffffffffc020727e:	f032                	sd	a2,32(sp)
ffffffffc0207280:	d01fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207284:	00a9b423          	sd	a0,8(s3)
ffffffffc0207288:	0169b823          	sd	s6,16(s3)
ffffffffc020728c:	7602                	ld	a2,32(sp)
ffffffffc020728e:	7822                	ld	a6,40(sp)
ffffffffc0207290:	010c2b03          	lw	s6,16(s8)
ffffffffc0207294:	7c050363          	beqz	a0,ffffffffc0207a5a <stride_dequeue+0x28fa>
ffffffffc0207298:	01353023          	sd	s3,0(a0)
ffffffffc020729c:	834e                	mv	t1,s3
ffffffffc020729e:	eaeff06f          	j	ffffffffc020694c <stride_dequeue+0x17ec>
ffffffffc02072a2:	0109b503          	ld	a0,16(s3)
ffffffffc02072a6:	0089bb03          	ld	s6,8(s3)
ffffffffc02072aa:	85c2                	mv	a1,a6
ffffffffc02072ac:	ec32                	sd	a2,24(sp)
ffffffffc02072ae:	cd3fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02072b2:	00a9b423          	sd	a0,8(s3)
ffffffffc02072b6:	0169b823          	sd	s6,16(s3)
ffffffffc02072ba:	6662                	ld	a2,24(sp)
ffffffffc02072bc:	010c2b03          	lw	s6,16(s8)
ffffffffc02072c0:	d2050263          	beqz	a0,ffffffffc02067e4 <stride_dequeue+0x1684>
ffffffffc02072c4:	01353023          	sd	s3,0(a0)
ffffffffc02072c8:	d1cff06f          	j	ffffffffc02067e4 <stride_dequeue+0x1684>
ffffffffc02072cc:	0109b503          	ld	a0,16(s3)
ffffffffc02072d0:	0089bb03          	ld	s6,8(s3)
ffffffffc02072d4:	85c2                	mv	a1,a6
ffffffffc02072d6:	cabfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02072da:	00a9b423          	sd	a0,8(s3)
ffffffffc02072de:	0169b823          	sd	s6,16(s3)
ffffffffc02072e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02072e6:	c4050b63          	beqz	a0,ffffffffc020673c <stride_dequeue+0x15dc>
ffffffffc02072ea:	01353023          	sd	s3,0(a0)
ffffffffc02072ee:	c4eff06f          	j	ffffffffc020673c <stride_dequeue+0x15dc>
ffffffffc02072f2:	0109b503          	ld	a0,16(s3)
ffffffffc02072f6:	0089bb03          	ld	s6,8(s3)
ffffffffc02072fa:	859a                	mv	a1,t1
ffffffffc02072fc:	c85fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207300:	00a9b423          	sd	a0,8(s3)
ffffffffc0207304:	0169b823          	sd	s6,16(s3)
ffffffffc0207308:	010c2b03          	lw	s6,16(s8)
ffffffffc020730c:	e119                	bnez	a0,ffffffffc0207312 <stride_dequeue+0x21b2>
ffffffffc020730e:	c77fe06f          	j	ffffffffc0205f84 <stride_dequeue+0xe24>
ffffffffc0207312:	01353023          	sd	s3,0(a0)
ffffffffc0207316:	c6ffe06f          	j	ffffffffc0205f84 <stride_dequeue+0xe24>
ffffffffc020731a:	6a08                	ld	a0,16(a2)
ffffffffc020731c:	85f2                	mv	a1,t3
ffffffffc020731e:	00863b03          	ld	s6,8(a2)
ffffffffc0207322:	c5ffd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207326:	7602                	ld	a2,32(sp)
ffffffffc0207328:	7822                	ld	a6,40(sp)
ffffffffc020732a:	01663823          	sd	s6,16(a2)
ffffffffc020732e:	e608                	sd	a0,8(a2)
ffffffffc0207330:	010c2b03          	lw	s6,16(s8)
ffffffffc0207334:	e119                	bnez	a0,ffffffffc020733a <stride_dequeue+0x21da>
ffffffffc0207336:	c9afe06f          	j	ffffffffc02057d0 <stride_dequeue+0x670>
ffffffffc020733a:	e110                	sd	a2,0(a0)
ffffffffc020733c:	c94fe06f          	j	ffffffffc02057d0 <stride_dequeue+0x670>
ffffffffc0207340:	010a3503          	ld	a0,16(s4)
ffffffffc0207344:	008a3b03          	ld	s6,8(s4)
ffffffffc0207348:	859a                	mv	a1,t1
ffffffffc020734a:	c37fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020734e:	00aa3423          	sd	a0,8(s4)
ffffffffc0207352:	016a3823          	sd	s6,16(s4)
ffffffffc0207356:	010c2b03          	lw	s6,16(s8)
ffffffffc020735a:	e119                	bnez	a0,ffffffffc0207360 <stride_dequeue+0x2200>
ffffffffc020735c:	83dfe06f          	j	ffffffffc0205b98 <stride_dequeue+0xa38>
ffffffffc0207360:	01453023          	sd	s4,0(a0)
ffffffffc0207364:	835fe06f          	j	ffffffffc0205b98 <stride_dequeue+0xa38>
ffffffffc0207368:	010cb503          	ld	a0,16(s9)
ffffffffc020736c:	008cbb03          	ld	s6,8(s9)
ffffffffc0207370:	85f2                	mv	a1,t3
ffffffffc0207372:	f442                	sd	a6,40(sp)
ffffffffc0207374:	c0dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207378:	00acb423          	sd	a0,8(s9)
ffffffffc020737c:	016cb823          	sd	s6,16(s9)
ffffffffc0207380:	7822                	ld	a6,40(sp)
ffffffffc0207382:	010c2b03          	lw	s6,16(s8)
ffffffffc0207386:	e119                	bnez	a0,ffffffffc020738c <stride_dequeue+0x222c>
ffffffffc0207388:	b2cfe06f          	j	ffffffffc02056b4 <stride_dequeue+0x554>
ffffffffc020738c:	01953023          	sd	s9,0(a0)
ffffffffc0207390:	b24fe06f          	j	ffffffffc02056b4 <stride_dequeue+0x554>
ffffffffc0207394:	010a3503          	ld	a0,16(s4)
ffffffffc0207398:	008a3b03          	ld	s6,8(s4)
ffffffffc020739c:	85f2                	mv	a1,t3
ffffffffc020739e:	f442                	sd	a6,40(sp)
ffffffffc02073a0:	be1fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02073a4:	00aa3423          	sd	a0,8(s4)
ffffffffc02073a8:	016a3823          	sd	s6,16(s4)
ffffffffc02073ac:	7822                	ld	a6,40(sp)
ffffffffc02073ae:	010c2b03          	lw	s6,16(s8)
ffffffffc02073b2:	e119                	bnez	a0,ffffffffc02073b8 <stride_dequeue+0x2258>
ffffffffc02073b4:	d1afe06f          	j	ffffffffc02058ce <stride_dequeue+0x76e>
ffffffffc02073b8:	01453023          	sd	s4,0(a0)
ffffffffc02073bc:	d12fe06f          	j	ffffffffc02058ce <stride_dequeue+0x76e>
ffffffffc02073c0:	0108b503          	ld	a0,16(a7)
ffffffffc02073c4:	85f2                	mv	a1,t3
ffffffffc02073c6:	0088bb03          	ld	s6,8(a7)
ffffffffc02073ca:	f046                	sd	a7,32(sp)
ffffffffc02073cc:	bb5fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02073d0:	7882                	ld	a7,32(sp)
ffffffffc02073d2:	7622                	ld	a2,40(sp)
ffffffffc02073d4:	0168b823          	sd	s6,16(a7)
ffffffffc02073d8:	00a8b423          	sd	a0,8(a7)
ffffffffc02073dc:	010c2b03          	lw	s6,16(s8)
ffffffffc02073e0:	e119                	bnez	a0,ffffffffc02073e6 <stride_dequeue+0x2286>
ffffffffc02073e2:	963fe06f          	j	ffffffffc0205d44 <stride_dequeue+0xbe4>
ffffffffc02073e6:	01153023          	sd	a7,0(a0)
ffffffffc02073ea:	95bfe06f          	j	ffffffffc0205d44 <stride_dequeue+0xbe4>
ffffffffc02073ee:	0108b503          	ld	a0,16(a7)
ffffffffc02073f2:	85f2                	mv	a1,t3
ffffffffc02073f4:	0088bb03          	ld	s6,8(a7)
ffffffffc02073f8:	f446                	sd	a7,40(sp)
ffffffffc02073fa:	b87fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02073fe:	78a2                	ld	a7,40(sp)
ffffffffc0207400:	0168b823          	sd	s6,16(a7)
ffffffffc0207404:	00a8b423          	sd	a0,8(a7)
ffffffffc0207408:	010c2b03          	lw	s6,16(s8)
ffffffffc020740c:	e119                	bnez	a0,ffffffffc0207412 <stride_dequeue+0x22b2>
ffffffffc020740e:	a05fe06f          	j	ffffffffc0205e12 <stride_dequeue+0xcb2>
ffffffffc0207412:	01153023          	sd	a7,0(a0)
ffffffffc0207416:	9fdfe06f          	j	ffffffffc0205e12 <stride_dequeue+0xcb2>
ffffffffc020741a:	0109b503          	ld	a0,16(s3)
ffffffffc020741e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207422:	85c2                	mv	a1,a6
ffffffffc0207424:	f446                	sd	a7,40(sp)
ffffffffc0207426:	b5bfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020742a:	00a9b423          	sd	a0,8(s3)
ffffffffc020742e:	0169b823          	sd	s6,16(s3)
ffffffffc0207432:	78a2                	ld	a7,40(sp)
ffffffffc0207434:	010c2b03          	lw	s6,16(s8)
ffffffffc0207438:	66050563          	beqz	a0,ffffffffc0207aa2 <stride_dequeue+0x2942>
ffffffffc020743c:	01353023          	sd	s3,0(a0)
ffffffffc0207440:	884e                	mv	a6,s3
ffffffffc0207442:	d6aff06f          	j	ffffffffc02069ac <stride_dequeue+0x184c>
ffffffffc0207446:	0109b503          	ld	a0,16(s3)
ffffffffc020744a:	0089bb03          	ld	s6,8(s3)
ffffffffc020744e:	85f2                	mv	a1,t3
ffffffffc0207450:	f442                	sd	a6,40(sp)
ffffffffc0207452:	b2ffd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207456:	00a9b423          	sd	a0,8(s3)
ffffffffc020745a:	0169b823          	sd	s6,16(s3)
ffffffffc020745e:	7822                	ld	a6,40(sp)
ffffffffc0207460:	010c2b03          	lw	s6,16(s8)
ffffffffc0207464:	e119                	bnez	a0,ffffffffc020746a <stride_dequeue+0x230a>
ffffffffc0207466:	e05fe06f          	j	ffffffffc020626a <stride_dequeue+0x110a>
ffffffffc020746a:	01353023          	sd	s3,0(a0)
ffffffffc020746e:	dfdfe06f          	j	ffffffffc020626a <stride_dequeue+0x110a>
ffffffffc0207472:	0109b503          	ld	a0,16(s3)
ffffffffc0207476:	0089bb03          	ld	s6,8(s3)
ffffffffc020747a:	859a                	mv	a1,t1
ffffffffc020747c:	f442                	sd	a6,40(sp)
ffffffffc020747e:	b03fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207482:	00a9b423          	sd	a0,8(s3)
ffffffffc0207486:	0169b823          	sd	s6,16(s3)
ffffffffc020748a:	7822                	ld	a6,40(sp)
ffffffffc020748c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207490:	64050163          	beqz	a0,ffffffffc0207ad2 <stride_dequeue+0x2972>
ffffffffc0207494:	01353023          	sd	s3,0(a0)
ffffffffc0207498:	834e                	mv	t1,s3
ffffffffc020749a:	d76ff06f          	j	ffffffffc0206a10 <stride_dequeue+0x18b0>
ffffffffc020749e:	0109b503          	ld	a0,16(s3)
ffffffffc02074a2:	0089bb03          	ld	s6,8(s3)
ffffffffc02074a6:	85f2                	mv	a1,t3
ffffffffc02074a8:	f446                	sd	a7,40(sp)
ffffffffc02074aa:	ad7fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02074ae:	00a9b423          	sd	a0,8(s3)
ffffffffc02074b2:	0169b823          	sd	s6,16(s3)
ffffffffc02074b6:	78a2                	ld	a7,40(sp)
ffffffffc02074b8:	010c2b03          	lw	s6,16(s8)
ffffffffc02074bc:	e119                	bnez	a0,ffffffffc02074c2 <stride_dequeue+0x2362>
ffffffffc02074be:	d0ffe06f          	j	ffffffffc02061cc <stride_dequeue+0x106c>
ffffffffc02074c2:	01353023          	sd	s3,0(a0)
ffffffffc02074c6:	d07fe06f          	j	ffffffffc02061cc <stride_dequeue+0x106c>
ffffffffc02074ca:	0109b503          	ld	a0,16(s3)
ffffffffc02074ce:	0089bb03          	ld	s6,8(s3)
ffffffffc02074d2:	859a                	mv	a1,t1
ffffffffc02074d4:	aadfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02074d8:	00a9b423          	sd	a0,8(s3)
ffffffffc02074dc:	0169b823          	sd	s6,16(s3)
ffffffffc02074e0:	010c2b03          	lw	s6,16(s8)
ffffffffc02074e4:	e119                	bnez	a0,ffffffffc02074ea <stride_dequeue+0x238a>
ffffffffc02074e6:	c49fe06f          	j	ffffffffc020612e <stride_dequeue+0xfce>
ffffffffc02074ea:	01353023          	sd	s3,0(a0)
ffffffffc02074ee:	c41fe06f          	j	ffffffffc020612e <stride_dequeue+0xfce>
ffffffffc02074f2:	0109b503          	ld	a0,16(s3)
ffffffffc02074f6:	0089bb03          	ld	s6,8(s3)
ffffffffc02074fa:	859a                	mv	a1,t1
ffffffffc02074fc:	ec32                	sd	a2,24(sp)
ffffffffc02074fe:	a83fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207502:	00a9b423          	sd	a0,8(s3)
ffffffffc0207506:	0169b823          	sd	s6,16(s3)
ffffffffc020750a:	6662                	ld	a2,24(sp)
ffffffffc020750c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207510:	e119                	bnez	a0,ffffffffc0207516 <stride_dequeue+0x23b6>
ffffffffc0207512:	b4ffe06f          	j	ffffffffc0206060 <stride_dequeue+0xf00>
ffffffffc0207516:	01353023          	sd	s3,0(a0)
ffffffffc020751a:	b47fe06f          	j	ffffffffc0206060 <stride_dequeue+0xf00>
ffffffffc020751e:	0108b503          	ld	a0,16(a7)
ffffffffc0207522:	85f2                	mv	a1,t3
ffffffffc0207524:	0088bb03          	ld	s6,8(a7)
ffffffffc0207528:	f446                	sd	a7,40(sp)
ffffffffc020752a:	a57fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020752e:	78a2                	ld	a7,40(sp)
ffffffffc0207530:	0168b823          	sd	s6,16(a7)
ffffffffc0207534:	00a8b423          	sd	a0,8(a7)
ffffffffc0207538:	010c2b03          	lw	s6,16(s8)
ffffffffc020753c:	e119                	bnez	a0,ffffffffc0207542 <stride_dequeue+0x23e2>
ffffffffc020753e:	f28fe06f          	j	ffffffffc0205c66 <stride_dequeue+0xb06>
ffffffffc0207542:	01153023          	sd	a7,0(a0)
ffffffffc0207546:	f20fe06f          	j	ffffffffc0205c66 <stride_dequeue+0xb06>
ffffffffc020754a:	0109b503          	ld	a0,16(s3)
ffffffffc020754e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207552:	85d2                	mv	a1,s4
ffffffffc0207554:	f046                	sd	a7,32(sp)
ffffffffc0207556:	a2bfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020755a:	00a9b423          	sd	a0,8(s3)
ffffffffc020755e:	0169b823          	sd	s6,16(s3)
ffffffffc0207562:	7882                	ld	a7,32(sp)
ffffffffc0207564:	010c2b03          	lw	s6,16(s8)
ffffffffc0207568:	e119                	bnez	a0,ffffffffc020756e <stride_dequeue+0x240e>
ffffffffc020756a:	fe1fe06f          	j	ffffffffc020654a <stride_dequeue+0x13ea>
ffffffffc020756e:	01353023          	sd	s3,0(a0)
ffffffffc0207572:	fd9fe06f          	j	ffffffffc020654a <stride_dequeue+0x13ea>
ffffffffc0207576:	0109b503          	ld	a0,16(s3)
ffffffffc020757a:	0089bb03          	ld	s6,8(s3)
ffffffffc020757e:	85c2                	mv	a1,a6
ffffffffc0207580:	a01fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207584:	00a9b423          	sd	a0,8(s3)
ffffffffc0207588:	0169b823          	sd	s6,16(s3)
ffffffffc020758c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207590:	ae050863          	beqz	a0,ffffffffc0206880 <stride_dequeue+0x1720>
ffffffffc0207594:	01353023          	sd	s3,0(a0)
ffffffffc0207598:	ae8ff06f          	j	ffffffffc0206880 <stride_dequeue+0x1720>
ffffffffc020759c:	89d2                	mv	s3,s4
ffffffffc020759e:	fadfe06f          	j	ffffffffc020654a <stride_dequeue+0x13ea>
ffffffffc02075a2:	89ee                	mv	s3,s11
ffffffffc02075a4:	84aff06f          	j	ffffffffc02065ee <stride_dequeue+0x148e>
ffffffffc02075a8:	89c2                	mv	s3,a6
ffffffffc02075aa:	992ff06f          	j	ffffffffc020673c <stride_dequeue+0x15dc>
ffffffffc02075ae:	89c2                	mv	s3,a6
ffffffffc02075b0:	a34ff06f          	j	ffffffffc02067e4 <stride_dequeue+0x1684>
ffffffffc02075b4:	89b2                	mv	s3,a2
ffffffffc02075b6:	8e2ff06f          	j	ffffffffc0206698 <stride_dequeue+0x1538>
ffffffffc02075ba:	89c2                	mv	s3,a6
ffffffffc02075bc:	ac4ff06f          	j	ffffffffc0206880 <stride_dequeue+0x1720>
ffffffffc02075c0:	01083503          	ld	a0,16(a6)
ffffffffc02075c4:	85e6                	mv	a1,s9
ffffffffc02075c6:	00883b03          	ld	s6,8(a6)
ffffffffc02075ca:	9b7fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02075ce:	7802                	ld	a6,32(sp)
ffffffffc02075d0:	01683823          	sd	s6,16(a6)
ffffffffc02075d4:	00a83423          	sd	a0,8(a6)
ffffffffc02075d8:	010c2b03          	lw	s6,16(s8)
ffffffffc02075dc:	50050163          	beqz	a0,ffffffffc0207ade <stride_dequeue+0x297e>
ffffffffc02075e0:	01053023          	sd	a6,0(a0)
ffffffffc02075e4:	8cc2                	mv	s9,a6
ffffffffc02075e6:	d62ff06f          	j	ffffffffc0206b48 <stride_dequeue+0x19e8>
ffffffffc02075ea:	01083503          	ld	a0,16(a6)
ffffffffc02075ee:	85d2                	mv	a1,s4
ffffffffc02075f0:	00883b03          	ld	s6,8(a6)
ffffffffc02075f4:	98dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02075f8:	6862                	ld	a6,24(sp)
ffffffffc02075fa:	7602                	ld	a2,32(sp)
ffffffffc02075fc:	01683823          	sd	s6,16(a6)
ffffffffc0207600:	00a83423          	sd	a0,8(a6)
ffffffffc0207604:	010c2b03          	lw	s6,16(s8)
ffffffffc0207608:	4c050863          	beqz	a0,ffffffffc0207ad8 <stride_dequeue+0x2978>
ffffffffc020760c:	01053023          	sd	a6,0(a0)
ffffffffc0207610:	8a42                	mv	s4,a6
ffffffffc0207612:	d94ff06f          	j	ffffffffc0206ba6 <stride_dequeue+0x1a46>
ffffffffc0207616:	89f2                	mv	s3,t3
ffffffffc0207618:	bb5fe06f          	j	ffffffffc02061cc <stride_dequeue+0x106c>
ffffffffc020761c:	88f2                	mv	a7,t3
ffffffffc020761e:	e48fe06f          	j	ffffffffc0205c66 <stride_dequeue+0xb06>
ffffffffc0207622:	89f2                	mv	s3,t3
ffffffffc0207624:	ce3fe06f          	j	ffffffffc0206306 <stride_dequeue+0x11a6>
ffffffffc0207628:	89f2                	mv	s3,t3
ffffffffc020762a:	c41fe06f          	j	ffffffffc020626a <stride_dequeue+0x110a>
ffffffffc020762e:	88f2                	mv	a7,t3
ffffffffc0207630:	fe2fe06f          	j	ffffffffc0205e12 <stride_dequeue+0xcb2>
ffffffffc0207634:	87ce                	mv	a5,s3
ffffffffc0207636:	ddffe06f          	j	ffffffffc0206414 <stride_dequeue+0x12b4>
ffffffffc020763a:	0108b503          	ld	a0,16(a7)
ffffffffc020763e:	85ce                	mv	a1,s3
ffffffffc0207640:	0088bb03          	ld	s6,8(a7)
ffffffffc0207644:	93dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207648:	7882                	ld	a7,32(sp)
ffffffffc020764a:	0168b823          	sd	s6,16(a7)
ffffffffc020764e:	00a8b423          	sd	a0,8(a7)
ffffffffc0207652:	010c2b03          	lw	s6,16(s8)
ffffffffc0207656:	42050a63          	beqz	a0,ffffffffc0207a8a <stride_dequeue+0x292a>
ffffffffc020765a:	01153023          	sd	a7,0(a0)
ffffffffc020765e:	89c6                	mv	s3,a7
ffffffffc0207660:	d9cff06f          	j	ffffffffc0206bfc <stride_dequeue+0x1a9c>
ffffffffc0207664:	8cf2                	mv	s9,t3
ffffffffc0207666:	84efe06f          	j	ffffffffc02056b4 <stride_dequeue+0x554>
ffffffffc020766a:	8a72                	mv	s4,t3
ffffffffc020766c:	a62fe06f          	j	ffffffffc02058ce <stride_dequeue+0x76e>
ffffffffc0207670:	88f2                	mv	a7,t3
ffffffffc0207672:	ed2fe06f          	j	ffffffffc0205d44 <stride_dequeue+0xbe4>
ffffffffc0207676:	89f2                	mv	s3,t3
ffffffffc0207678:	d33fe06f          	j	ffffffffc02063aa <stride_dequeue+0x124a>
ffffffffc020767c:	0109b503          	ld	a0,16(s3)
ffffffffc0207680:	0089bb03          	ld	s6,8(s3)
ffffffffc0207684:	85c6                	mv	a1,a7
ffffffffc0207686:	8fbfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020768a:	00a9b423          	sd	a0,8(s3)
ffffffffc020768e:	0169b823          	sd	s6,16(s3)
ffffffffc0207692:	010c2b03          	lw	s6,16(s8)
ffffffffc0207696:	e119                	bnez	a0,ffffffffc020769c <stride_dequeue+0x253c>
ffffffffc0207698:	dfdfe06f          	j	ffffffffc0206494 <stride_dequeue+0x1334>
ffffffffc020769c:	01353023          	sd	s3,0(a0)
ffffffffc02076a0:	df5fe06f          	j	ffffffffc0206494 <stride_dequeue+0x1334>
ffffffffc02076a4:	01083503          	ld	a0,16(a6)
ffffffffc02076a8:	85d2                	mv	a1,s4
ffffffffc02076aa:	00883b03          	ld	s6,8(a6)
ffffffffc02076ae:	8d3fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02076b2:	7802                	ld	a6,32(sp)
ffffffffc02076b4:	01683823          	sd	s6,16(a6)
ffffffffc02076b8:	00a83423          	sd	a0,8(a6)
ffffffffc02076bc:	010c2b03          	lw	s6,16(s8)
ffffffffc02076c0:	3a050363          	beqz	a0,ffffffffc0207a66 <stride_dequeue+0x2906>
ffffffffc02076c4:	01053023          	sd	a6,0(a0)
ffffffffc02076c8:	8a42                	mv	s4,a6
ffffffffc02076ca:	c28ff06f          	j	ffffffffc0206af2 <stride_dequeue+0x1992>
ffffffffc02076ce:	8672                	mv	a2,t3
ffffffffc02076d0:	900fe06f          	j	ffffffffc02057d0 <stride_dequeue+0x670>
ffffffffc02076d4:	0108b503          	ld	a0,16(a7)
ffffffffc02076d8:	85ce                	mv	a1,s3
ffffffffc02076da:	0088bb03          	ld	s6,8(a7)
ffffffffc02076de:	8a3fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02076e2:	7882                	ld	a7,32(sp)
ffffffffc02076e4:	7622                	ld	a2,40(sp)
ffffffffc02076e6:	7842                	ld	a6,48(sp)
ffffffffc02076e8:	0168b823          	sd	s6,16(a7)
ffffffffc02076ec:	00a8b423          	sd	a0,8(a7)
ffffffffc02076f0:	010c2b03          	lw	s6,16(s8)
ffffffffc02076f4:	3c050c63          	beqz	a0,ffffffffc0207acc <stride_dequeue+0x296c>
ffffffffc02076f8:	01153023          	sd	a7,0(a0)
ffffffffc02076fc:	89c6                	mv	s3,a7
ffffffffc02076fe:	dc0ff06f          	j	ffffffffc0206cbe <stride_dequeue+0x1b5e>
ffffffffc0207702:	0109b503          	ld	a0,16(s3)
ffffffffc0207706:	0089bb03          	ld	s6,8(s3)
ffffffffc020770a:	85f2                	mv	a1,t3
ffffffffc020770c:	f41a                	sd	t1,40(sp)
ffffffffc020770e:	873fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207712:	00a9b423          	sd	a0,8(s3)
ffffffffc0207716:	0169b823          	sd	s6,16(s3)
ffffffffc020771a:	7322                	ld	t1,40(sp)
ffffffffc020771c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207720:	e119                	bnez	a0,ffffffffc0207726 <stride_dequeue+0x25c6>
ffffffffc0207722:	9fdfe06f          	j	ffffffffc020611e <stride_dequeue+0xfbe>
ffffffffc0207726:	01353023          	sd	s3,0(a0)
ffffffffc020772a:	9f5fe06f          	j	ffffffffc020611e <stride_dequeue+0xfbe>
ffffffffc020772e:	01033503          	ld	a0,16(t1)
ffffffffc0207732:	85e6                	mv	a1,s9
ffffffffc0207734:	00833b03          	ld	s6,8(t1)
ffffffffc0207738:	849fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020773c:	7322                	ld	t1,40(sp)
ffffffffc020773e:	78c2                	ld	a7,48(sp)
ffffffffc0207740:	01633823          	sd	s6,16(t1)
ffffffffc0207744:	00a33423          	sd	a0,8(t1)
ffffffffc0207748:	010c2b03          	lw	s6,16(s8)
ffffffffc020774c:	34050e63          	beqz	a0,ffffffffc0207aa8 <stride_dequeue+0x2948>
ffffffffc0207750:	00653023          	sd	t1,0(a0)
ffffffffc0207754:	8c9a                	mv	s9,t1
ffffffffc0207756:	eeaff06f          	j	ffffffffc0206e40 <stride_dequeue+0x1ce0>
ffffffffc020775a:	01033503          	ld	a0,16(t1)
ffffffffc020775e:	85c2                	mv	a1,a6
ffffffffc0207760:	00833b03          	ld	s6,8(t1)
ffffffffc0207764:	81dfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207768:	7322                	ld	t1,40(sp)
ffffffffc020776a:	01633823          	sd	s6,16(t1)
ffffffffc020776e:	00a33423          	sd	a0,8(t1)
ffffffffc0207772:	010c2b03          	lw	s6,16(s8)
ffffffffc0207776:	32050c63          	beqz	a0,ffffffffc0207aae <stride_dequeue+0x294e>
ffffffffc020777a:	00653023          	sd	t1,0(a0)
ffffffffc020777e:	881a                	mv	a6,t1
ffffffffc0207780:	f24ff06f          	j	ffffffffc0206ea4 <stride_dequeue+0x1d44>
ffffffffc0207784:	0108b503          	ld	a0,16(a7)
ffffffffc0207788:	85ce                	mv	a1,s3
ffffffffc020778a:	0088bb03          	ld	s6,8(a7)
ffffffffc020778e:	ff2fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207792:	78a2                	ld	a7,40(sp)
ffffffffc0207794:	7842                	ld	a6,48(sp)
ffffffffc0207796:	0168b823          	sd	s6,16(a7)
ffffffffc020779a:	00a8b423          	sd	a0,8(a7)
ffffffffc020779e:	010c2b03          	lw	s6,16(s8)
ffffffffc02077a2:	30050963          	beqz	a0,ffffffffc0207ab4 <stride_dequeue+0x2954>
ffffffffc02077a6:	01153023          	sd	a7,0(a0)
ffffffffc02077aa:	89c6                	mv	s3,a7
ffffffffc02077ac:	caeff06f          	j	ffffffffc0206c5a <stride_dequeue+0x1afa>
ffffffffc02077b0:	01083503          	ld	a0,16(a6)
ffffffffc02077b4:	85ce                	mv	a1,s3
ffffffffc02077b6:	00883b03          	ld	s6,8(a6)
ffffffffc02077ba:	fc6fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02077be:	7822                	ld	a6,40(sp)
ffffffffc02077c0:	78c2                	ld	a7,48(sp)
ffffffffc02077c2:	01683823          	sd	s6,16(a6)
ffffffffc02077c6:	00a83423          	sd	a0,8(a6)
ffffffffc02077ca:	010c2b03          	lw	s6,16(s8)
ffffffffc02077ce:	30050b63          	beqz	a0,ffffffffc0207ae4 <stride_dequeue+0x2984>
ffffffffc02077d2:	01053023          	sd	a6,0(a0)
ffffffffc02077d6:	89c2                	mv	s3,a6
ffffffffc02077d8:	da6ff06f          	j	ffffffffc0206d7e <stride_dequeue+0x1c1e>
ffffffffc02077dc:	01083503          	ld	a0,16(a6)
ffffffffc02077e0:	85ce                	mv	a1,s3
ffffffffc02077e2:	00883b03          	ld	s6,8(a6)
ffffffffc02077e6:	f9afd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02077ea:	7802                	ld	a6,32(sp)
ffffffffc02077ec:	7622                	ld	a2,40(sp)
ffffffffc02077ee:	78c2                	ld	a7,48(sp)
ffffffffc02077f0:	01683823          	sd	s6,16(a6)
ffffffffc02077f4:	00a83423          	sd	a0,8(a6)
ffffffffc02077f8:	010c2b03          	lw	s6,16(s8)
ffffffffc02077fc:	2a050063          	beqz	a0,ffffffffc0207a9c <stride_dequeue+0x293c>
ffffffffc0207800:	01053023          	sd	a6,0(a0)
ffffffffc0207804:	89c2                	mv	s3,a6
ffffffffc0207806:	ddcff06f          	j	ffffffffc0206de2 <stride_dequeue+0x1c82>
ffffffffc020780a:	0109b503          	ld	a0,16(s3)
ffffffffc020780e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207812:	85f2                	mv	a1,t3
ffffffffc0207814:	f41a                	sd	t1,40(sp)
ffffffffc0207816:	f6afd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020781a:	00a9b423          	sd	a0,8(s3)
ffffffffc020781e:	0169b823          	sd	s6,16(s3)
ffffffffc0207822:	7322                	ld	t1,40(sp)
ffffffffc0207824:	010c2b03          	lw	s6,16(s8)
ffffffffc0207828:	e119                	bnez	a0,ffffffffc020782e <stride_dequeue+0x26ce>
ffffffffc020782a:	f4afe06f          	j	ffffffffc0205f74 <stride_dequeue+0xe14>
ffffffffc020782e:	01353023          	sd	s3,0(a0)
ffffffffc0207832:	f42fe06f          	j	ffffffffc0205f74 <stride_dequeue+0xe14>
ffffffffc0207836:	0109b503          	ld	a0,16(s3)
ffffffffc020783a:	0089bb03          	ld	s6,8(s3)
ffffffffc020783e:	85f2                	mv	a1,t3
ffffffffc0207840:	f446                	sd	a7,40(sp)
ffffffffc0207842:	f3efd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207846:	00a9b423          	sd	a0,8(s3)
ffffffffc020784a:	0169b823          	sd	s6,16(s3)
ffffffffc020784e:	78a2                	ld	a7,40(sp)
ffffffffc0207850:	010c2b03          	lw	s6,16(s8)
ffffffffc0207854:	e119                	bnez	a0,ffffffffc020785a <stride_dequeue+0x26fa>
ffffffffc0207856:	ce5fe06f          	j	ffffffffc020653a <stride_dequeue+0x13da>
ffffffffc020785a:	01353023          	sd	s3,0(a0)
ffffffffc020785e:	cddfe06f          	j	ffffffffc020653a <stride_dequeue+0x13da>
ffffffffc0207862:	0109b503          	ld	a0,16(s3)
ffffffffc0207866:	0089bb03          	ld	s6,8(s3)
ffffffffc020786a:	85f2                	mv	a1,t3
ffffffffc020786c:	f446                	sd	a7,40(sp)
ffffffffc020786e:	f032                	sd	a2,32(sp)
ffffffffc0207870:	f10fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207874:	00a9b423          	sd	a0,8(s3)
ffffffffc0207878:	0169b823          	sd	s6,16(s3)
ffffffffc020787c:	7602                	ld	a2,32(sp)
ffffffffc020787e:	78a2                	ld	a7,40(sp)
ffffffffc0207880:	010c2b03          	lw	s6,16(s8)
ffffffffc0207884:	e119                	bnez	a0,ffffffffc020788a <stride_dequeue+0x272a>
ffffffffc0207886:	e05fe06f          	j	ffffffffc020668a <stride_dequeue+0x152a>
ffffffffc020788a:	01353023          	sd	s3,0(a0)
ffffffffc020788e:	dfdfe06f          	j	ffffffffc020668a <stride_dequeue+0x152a>
ffffffffc0207892:	010a3503          	ld	a0,16(s4)
ffffffffc0207896:	008a3b03          	ld	s6,8(s4)
ffffffffc020789a:	85f2                	mv	a1,t3
ffffffffc020789c:	f41a                	sd	t1,40(sp)
ffffffffc020789e:	ee2fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02078a2:	00aa3423          	sd	a0,8(s4)
ffffffffc02078a6:	016a3823          	sd	s6,16(s4)
ffffffffc02078aa:	7322                	ld	t1,40(sp)
ffffffffc02078ac:	010c2b03          	lw	s6,16(s8)
ffffffffc02078b0:	e119                	bnez	a0,ffffffffc02078b6 <stride_dequeue+0x2756>
ffffffffc02078b2:	ad6fe06f          	j	ffffffffc0205b88 <stride_dequeue+0xa28>
ffffffffc02078b6:	01453023          	sd	s4,0(a0)
ffffffffc02078ba:	acefe06f          	j	ffffffffc0205b88 <stride_dequeue+0xa28>
ffffffffc02078be:	0109b503          	ld	a0,16(s3)
ffffffffc02078c2:	0089bb03          	ld	s6,8(s3)
ffffffffc02078c6:	85f2                	mv	a1,t3
ffffffffc02078c8:	f446                	sd	a7,40(sp)
ffffffffc02078ca:	eb6fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02078ce:	00a9b423          	sd	a0,8(s3)
ffffffffc02078d2:	0169b823          	sd	s6,16(s3)
ffffffffc02078d6:	78a2                	ld	a7,40(sp)
ffffffffc02078d8:	010c2b03          	lw	s6,16(s8)
ffffffffc02078dc:	e119                	bnez	a0,ffffffffc02078e2 <stride_dequeue+0x2782>
ffffffffc02078de:	d01fe06f          	j	ffffffffc02065de <stride_dequeue+0x147e>
ffffffffc02078e2:	01353023          	sd	s3,0(a0)
ffffffffc02078e6:	cf9fe06f          	j	ffffffffc02065de <stride_dequeue+0x147e>
ffffffffc02078ea:	01033503          	ld	a0,16(t1)
ffffffffc02078ee:	85c2                	mv	a1,a6
ffffffffc02078f0:	00833b03          	ld	s6,8(t1)
ffffffffc02078f4:	e8cfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02078f8:	7322                	ld	t1,40(sp)
ffffffffc02078fa:	01633823          	sd	s6,16(t1)
ffffffffc02078fe:	00a33423          	sd	a0,8(t1)
ffffffffc0207902:	010c2b03          	lw	s6,16(s8)
ffffffffc0207906:	1e050b63          	beqz	a0,ffffffffc0207afc <stride_dequeue+0x299c>
ffffffffc020790a:	00653023          	sd	t1,0(a0)
ffffffffc020790e:	881a                	mv	a6,t1
ffffffffc0207910:	e50ff06f          	j	ffffffffc0206f60 <stride_dequeue+0x1e00>
ffffffffc0207914:	0109b503          	ld	a0,16(s3)
ffffffffc0207918:	0089bb03          	ld	s6,8(s3)
ffffffffc020791c:	85f2                	mv	a1,t3
ffffffffc020791e:	f442                	sd	a6,40(sp)
ffffffffc0207920:	f032                	sd	a2,32(sp)
ffffffffc0207922:	e5efd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207926:	00a9b423          	sd	a0,8(s3)
ffffffffc020792a:	0169b823          	sd	s6,16(s3)
ffffffffc020792e:	7602                	ld	a2,32(sp)
ffffffffc0207930:	7822                	ld	a6,40(sp)
ffffffffc0207932:	010c2b03          	lw	s6,16(s8)
ffffffffc0207936:	e119                	bnez	a0,ffffffffc020793c <stride_dequeue+0x27dc>
ffffffffc0207938:	e9dfe06f          	j	ffffffffc02067d4 <stride_dequeue+0x1674>
ffffffffc020793c:	01353023          	sd	s3,0(a0)
ffffffffc0207940:	e95fe06f          	j	ffffffffc02067d4 <stride_dequeue+0x1674>
ffffffffc0207944:	0108b503          	ld	a0,16(a7)
ffffffffc0207948:	85ce                	mv	a1,s3
ffffffffc020794a:	0088bb03          	ld	s6,8(a7)
ffffffffc020794e:	e32fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207952:	78a2                	ld	a7,40(sp)
ffffffffc0207954:	7842                	ld	a6,48(sp)
ffffffffc0207956:	0168b823          	sd	s6,16(a7)
ffffffffc020795a:	00a8b423          	sd	a0,8(a7)
ffffffffc020795e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207962:	0e050f63          	beqz	a0,ffffffffc0207a60 <stride_dequeue+0x2900>
ffffffffc0207966:	01153023          	sd	a7,0(a0)
ffffffffc020796a:	89c6                	mv	s3,a7
ffffffffc020796c:	d96ff06f          	j	ffffffffc0206f02 <stride_dequeue+0x1da2>
ffffffffc0207970:	01083503          	ld	a0,16(a6)
ffffffffc0207974:	85ce                	mv	a1,s3
ffffffffc0207976:	00883b03          	ld	s6,8(a6)
ffffffffc020797a:	e06fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc020797e:	7822                	ld	a6,40(sp)
ffffffffc0207980:	78c2                	ld	a7,48(sp)
ffffffffc0207982:	01683823          	sd	s6,16(a6)
ffffffffc0207986:	00a83423          	sd	a0,8(a6)
ffffffffc020798a:	010c2b03          	lw	s6,16(s8)
ffffffffc020798e:	0e050b63          	beqz	a0,ffffffffc0207a84 <stride_dequeue+0x2924>
ffffffffc0207992:	01053023          	sd	a6,0(a0)
ffffffffc0207996:	89c2                	mv	s3,a6
ffffffffc0207998:	b88ff06f          	j	ffffffffc0206d20 <stride_dequeue+0x1bc0>
ffffffffc020799c:	0109b503          	ld	a0,16(s3)
ffffffffc02079a0:	0089bb03          	ld	s6,8(s3)
ffffffffc02079a4:	85f2                	mv	a1,t3
ffffffffc02079a6:	f442                	sd	a6,40(sp)
ffffffffc02079a8:	dd8fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02079ac:	00a9b423          	sd	a0,8(s3)
ffffffffc02079b0:	0169b823          	sd	s6,16(s3)
ffffffffc02079b4:	7822                	ld	a6,40(sp)
ffffffffc02079b6:	010c2b03          	lw	s6,16(s8)
ffffffffc02079ba:	e119                	bnez	a0,ffffffffc02079c0 <stride_dequeue+0x2860>
ffffffffc02079bc:	d71fe06f          	j	ffffffffc020672c <stride_dequeue+0x15cc>
ffffffffc02079c0:	01353023          	sd	s3,0(a0)
ffffffffc02079c4:	d69fe06f          	j	ffffffffc020672c <stride_dequeue+0x15cc>
ffffffffc02079c8:	0109b503          	ld	a0,16(s3)
ffffffffc02079cc:	0089bb03          	ld	s6,8(s3)
ffffffffc02079d0:	85f2                	mv	a1,t3
ffffffffc02079d2:	f442                	sd	a6,40(sp)
ffffffffc02079d4:	dacfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc02079d8:	00a9b423          	sd	a0,8(s3)
ffffffffc02079dc:	0169b823          	sd	s6,16(s3)
ffffffffc02079e0:	7822                	ld	a6,40(sp)
ffffffffc02079e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02079e6:	e119                	bnez	a0,ffffffffc02079ec <stride_dequeue+0x288c>
ffffffffc02079e8:	e89fe06f          	j	ffffffffc0206870 <stride_dequeue+0x1710>
ffffffffc02079ec:	01353023          	sd	s3,0(a0)
ffffffffc02079f0:	e81fe06f          	j	ffffffffc0206870 <stride_dequeue+0x1710>
ffffffffc02079f4:	89c6                	mv	s3,a7
ffffffffc02079f6:	a9ffe06f          	j	ffffffffc0206494 <stride_dequeue+0x1334>
ffffffffc02079fa:	0109b503          	ld	a0,16(s3)
ffffffffc02079fe:	0089bb03          	ld	s6,8(s3)
ffffffffc0207a02:	85f2                	mv	a1,t3
ffffffffc0207a04:	f41a                	sd	t1,40(sp)
ffffffffc0207a06:	f032                	sd	a2,32(sp)
ffffffffc0207a08:	d78fd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207a0c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207a10:	0169b823          	sd	s6,16(s3)
ffffffffc0207a14:	7602                	ld	a2,32(sp)
ffffffffc0207a16:	7322                	ld	t1,40(sp)
ffffffffc0207a18:	010c2b03          	lw	s6,16(s8)
ffffffffc0207a1c:	e119                	bnez	a0,ffffffffc0207a22 <stride_dequeue+0x28c2>
ffffffffc0207a1e:	e32fe06f          	j	ffffffffc0206050 <stride_dequeue+0xef0>
ffffffffc0207a22:	01353023          	sd	s3,0(a0)
ffffffffc0207a26:	e2afe06f          	j	ffffffffc0206050 <stride_dequeue+0xef0>
ffffffffc0207a2a:	01033503          	ld	a0,16(t1)
ffffffffc0207a2e:	85c2                	mv	a1,a6
ffffffffc0207a30:	00833b03          	ld	s6,8(t1)
ffffffffc0207a34:	d4cfd0ef          	jal	ra,ffffffffc0204f80 <skew_heap_merge.constprop.0>
ffffffffc0207a38:	7302                	ld	t1,32(sp)
ffffffffc0207a3a:	7622                	ld	a2,40(sp)
ffffffffc0207a3c:	01633823          	sd	s6,16(t1)
ffffffffc0207a40:	00a33423          	sd	a0,8(t1)
ffffffffc0207a44:	010c2b03          	lw	s6,16(s8)
ffffffffc0207a48:	c115                	beqz	a0,ffffffffc0207a6c <stride_dequeue+0x290c>
ffffffffc0207a4a:	00653023          	sd	t1,0(a0)
ffffffffc0207a4e:	881a                	mv	a6,t1
ffffffffc0207a50:	d76ff06f          	j	ffffffffc0206fc6 <stride_dequeue+0x1e66>
ffffffffc0207a54:	89f2                	mv	s3,t3
ffffffffc0207a56:	e1bfe06f          	j	ffffffffc0206870 <stride_dequeue+0x1710>
ffffffffc0207a5a:	834e                	mv	t1,s3
ffffffffc0207a5c:	ef1fe06f          	j	ffffffffc020694c <stride_dequeue+0x17ec>
ffffffffc0207a60:	89c6                	mv	s3,a7
ffffffffc0207a62:	ca0ff06f          	j	ffffffffc0206f02 <stride_dequeue+0x1da2>
ffffffffc0207a66:	8a42                	mv	s4,a6
ffffffffc0207a68:	88aff06f          	j	ffffffffc0206af2 <stride_dequeue+0x1992>
ffffffffc0207a6c:	881a                	mv	a6,t1
ffffffffc0207a6e:	d58ff06f          	j	ffffffffc0206fc6 <stride_dequeue+0x1e66>
ffffffffc0207a72:	89f2                	mv	s3,t3
ffffffffc0207a74:	ddcfe06f          	j	ffffffffc0206050 <stride_dequeue+0xef0>
ffffffffc0207a78:	834e                	mv	t1,s3
ffffffffc0207a7a:	e69fe06f          	j	ffffffffc02068e2 <stride_dequeue+0x1782>
ffffffffc0207a7e:	89f2                	mv	s3,t3
ffffffffc0207a80:	cadfe06f          	j	ffffffffc020672c <stride_dequeue+0x15cc>
ffffffffc0207a84:	89c2                	mv	s3,a6
ffffffffc0207a86:	a9aff06f          	j	ffffffffc0206d20 <stride_dequeue+0x1bc0>
ffffffffc0207a8a:	89c6                	mv	s3,a7
ffffffffc0207a8c:	970ff06f          	j	ffffffffc0206bfc <stride_dequeue+0x1a9c>
ffffffffc0207a90:	834e                	mv	t1,s3
ffffffffc0207a92:	fdffe06f          	j	ffffffffc0206a70 <stride_dequeue+0x1910>
ffffffffc0207a96:	89f2                	mv	s3,t3
ffffffffc0207a98:	cdcfe06f          	j	ffffffffc0205f74 <stride_dequeue+0xe14>
ffffffffc0207a9c:	89c2                	mv	s3,a6
ffffffffc0207a9e:	b44ff06f          	j	ffffffffc0206de2 <stride_dequeue+0x1c82>
ffffffffc0207aa2:	884e                	mv	a6,s3
ffffffffc0207aa4:	f09fe06f          	j	ffffffffc02069ac <stride_dequeue+0x184c>
ffffffffc0207aa8:	8c9a                	mv	s9,t1
ffffffffc0207aaa:	b96ff06f          	j	ffffffffc0206e40 <stride_dequeue+0x1ce0>
ffffffffc0207aae:	881a                	mv	a6,t1
ffffffffc0207ab0:	bf4ff06f          	j	ffffffffc0206ea4 <stride_dequeue+0x1d44>
ffffffffc0207ab4:	89c6                	mv	s3,a7
ffffffffc0207ab6:	9a4ff06f          	j	ffffffffc0206c5a <stride_dequeue+0x1afa>
ffffffffc0207aba:	89f2                	mv	s3,t3
ffffffffc0207abc:	a7ffe06f          	j	ffffffffc020653a <stride_dequeue+0x13da>
ffffffffc0207ac0:	89f2                	mv	s3,t3
ffffffffc0207ac2:	bc9fe06f          	j	ffffffffc020668a <stride_dequeue+0x152a>
ffffffffc0207ac6:	89f2                	mv	s3,t3
ffffffffc0207ac8:	e56fe06f          	j	ffffffffc020611e <stride_dequeue+0xfbe>
ffffffffc0207acc:	89c6                	mv	s3,a7
ffffffffc0207ace:	9f0ff06f          	j	ffffffffc0206cbe <stride_dequeue+0x1b5e>
ffffffffc0207ad2:	834e                	mv	t1,s3
ffffffffc0207ad4:	f3dfe06f          	j	ffffffffc0206a10 <stride_dequeue+0x18b0>
ffffffffc0207ad8:	8a42                	mv	s4,a6
ffffffffc0207ada:	8ccff06f          	j	ffffffffc0206ba6 <stride_dequeue+0x1a46>
ffffffffc0207ade:	8cc2                	mv	s9,a6
ffffffffc0207ae0:	868ff06f          	j	ffffffffc0206b48 <stride_dequeue+0x19e8>
ffffffffc0207ae4:	89c2                	mv	s3,a6
ffffffffc0207ae6:	a98ff06f          	j	ffffffffc0206d7e <stride_dequeue+0x1c1e>
ffffffffc0207aea:	8a72                	mv	s4,t3
ffffffffc0207aec:	89cfe06f          	j	ffffffffc0205b88 <stride_dequeue+0xa28>
ffffffffc0207af0:	89f2                	mv	s3,t3
ffffffffc0207af2:	aedfe06f          	j	ffffffffc02065de <stride_dequeue+0x147e>
ffffffffc0207af6:	89f2                	mv	s3,t3
ffffffffc0207af8:	cddfe06f          	j	ffffffffc02067d4 <stride_dequeue+0x1674>
ffffffffc0207afc:	881a                	mv	a6,t1
ffffffffc0207afe:	c62ff06f          	j	ffffffffc0206f60 <stride_dequeue+0x1e00>

ffffffffc0207b02 <sys_getpid>:
ffffffffc0207b02:	00012797          	auipc	a5,0x12
ffffffffc0207b06:	9fe7b783          	ld	a5,-1538(a5) # ffffffffc0219500 <current>
ffffffffc0207b0a:	43c8                	lw	a0,4(a5)
ffffffffc0207b0c:	8082                	ret

ffffffffc0207b0e <sys_pgdir>:
ffffffffc0207b0e:	4501                	li	a0,0
ffffffffc0207b10:	8082                	ret

ffffffffc0207b12 <sys_gettime>:
ffffffffc0207b12:	00012797          	auipc	a5,0x12
ffffffffc0207b16:	a1e7b783          	ld	a5,-1506(a5) # ffffffffc0219530 <ticks>
ffffffffc0207b1a:	0027951b          	slliw	a0,a5,0x2
ffffffffc0207b1e:	9d3d                	addw	a0,a0,a5
ffffffffc0207b20:	0015151b          	slliw	a0,a0,0x1
ffffffffc0207b24:	8082                	ret

ffffffffc0207b26 <sys_lab6_set_priority>:
ffffffffc0207b26:	4108                	lw	a0,0(a0)
ffffffffc0207b28:	1141                	addi	sp,sp,-16
ffffffffc0207b2a:	e406                	sd	ra,8(sp)
ffffffffc0207b2c:	ee5fc0ef          	jal	ra,ffffffffc0204a10 <lab6_set_priority>
ffffffffc0207b30:	60a2                	ld	ra,8(sp)
ffffffffc0207b32:	4501                	li	a0,0
ffffffffc0207b34:	0141                	addi	sp,sp,16
ffffffffc0207b36:	8082                	ret

ffffffffc0207b38 <sys_putc>:
ffffffffc0207b38:	4108                	lw	a0,0(a0)
ffffffffc0207b3a:	1141                	addi	sp,sp,-16
ffffffffc0207b3c:	e406                	sd	ra,8(sp)
ffffffffc0207b3e:	dc4f80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc0207b42:	60a2                	ld	ra,8(sp)
ffffffffc0207b44:	4501                	li	a0,0
ffffffffc0207b46:	0141                	addi	sp,sp,16
ffffffffc0207b48:	8082                	ret

ffffffffc0207b4a <sys_kill>:
ffffffffc0207b4a:	4108                	lw	a0,0(a0)
ffffffffc0207b4c:	d2dfc06f          	j	ffffffffc0204878 <do_kill>

ffffffffc0207b50 <sys_sleep>:
ffffffffc0207b50:	4108                	lw	a0,0(a0)
ffffffffc0207b52:	ef9fc06f          	j	ffffffffc0204a4a <do_sleep>

ffffffffc0207b56 <sys_yield>:
ffffffffc0207b56:	cd5fc06f          	j	ffffffffc020482a <do_yield>

ffffffffc0207b5a <sys_exec>:
ffffffffc0207b5a:	6d14                	ld	a3,24(a0)
ffffffffc0207b5c:	6910                	ld	a2,16(a0)
ffffffffc0207b5e:	650c                	ld	a1,8(a0)
ffffffffc0207b60:	6108                	ld	a0,0(a0)
ffffffffc0207b62:	f3efc06f          	j	ffffffffc02042a0 <do_execve>

ffffffffc0207b66 <sys_wait>:
ffffffffc0207b66:	650c                	ld	a1,8(a0)
ffffffffc0207b68:	4108                	lw	a0,0(a0)
ffffffffc0207b6a:	cd1fc06f          	j	ffffffffc020483a <do_wait>

ffffffffc0207b6e <sys_fork>:
ffffffffc0207b6e:	00012797          	auipc	a5,0x12
ffffffffc0207b72:	9927b783          	ld	a5,-1646(a5) # ffffffffc0219500 <current>
ffffffffc0207b76:	73d0                	ld	a2,160(a5)
ffffffffc0207b78:	4501                	li	a0,0
ffffffffc0207b7a:	6a0c                	ld	a1,16(a2)
ffffffffc0207b7c:	ebbfb06f          	j	ffffffffc0203a36 <do_fork>

ffffffffc0207b80 <sys_exit>:
ffffffffc0207b80:	4108                	lw	a0,0(a0)
ffffffffc0207b82:	ad6fc06f          	j	ffffffffc0203e58 <do_exit>

ffffffffc0207b86 <syscall>:
ffffffffc0207b86:	715d                	addi	sp,sp,-80
ffffffffc0207b88:	fc26                	sd	s1,56(sp)
ffffffffc0207b8a:	00012497          	auipc	s1,0x12
ffffffffc0207b8e:	97648493          	addi	s1,s1,-1674 # ffffffffc0219500 <current>
ffffffffc0207b92:	6098                	ld	a4,0(s1)
ffffffffc0207b94:	e0a2                	sd	s0,64(sp)
ffffffffc0207b96:	f84a                	sd	s2,48(sp)
ffffffffc0207b98:	7340                	ld	s0,160(a4)
ffffffffc0207b9a:	e486                	sd	ra,72(sp)
ffffffffc0207b9c:	0ff00793          	li	a5,255
ffffffffc0207ba0:	05042903          	lw	s2,80(s0)
ffffffffc0207ba4:	0327ee63          	bltu	a5,s2,ffffffffc0207be0 <syscall+0x5a>
ffffffffc0207ba8:	00391713          	slli	a4,s2,0x3
ffffffffc0207bac:	00002797          	auipc	a5,0x2
ffffffffc0207bb0:	1dc78793          	addi	a5,a5,476 # ffffffffc0209d88 <syscalls>
ffffffffc0207bb4:	97ba                	add	a5,a5,a4
ffffffffc0207bb6:	639c                	ld	a5,0(a5)
ffffffffc0207bb8:	c785                	beqz	a5,ffffffffc0207be0 <syscall+0x5a>
ffffffffc0207bba:	6c28                	ld	a0,88(s0)
ffffffffc0207bbc:	702c                	ld	a1,96(s0)
ffffffffc0207bbe:	7430                	ld	a2,104(s0)
ffffffffc0207bc0:	7834                	ld	a3,112(s0)
ffffffffc0207bc2:	7c38                	ld	a4,120(s0)
ffffffffc0207bc4:	e42a                	sd	a0,8(sp)
ffffffffc0207bc6:	e82e                	sd	a1,16(sp)
ffffffffc0207bc8:	ec32                	sd	a2,24(sp)
ffffffffc0207bca:	f036                	sd	a3,32(sp)
ffffffffc0207bcc:	f43a                	sd	a4,40(sp)
ffffffffc0207bce:	0028                	addi	a0,sp,8
ffffffffc0207bd0:	9782                	jalr	a5
ffffffffc0207bd2:	60a6                	ld	ra,72(sp)
ffffffffc0207bd4:	e828                	sd	a0,80(s0)
ffffffffc0207bd6:	6406                	ld	s0,64(sp)
ffffffffc0207bd8:	74e2                	ld	s1,56(sp)
ffffffffc0207bda:	7942                	ld	s2,48(sp)
ffffffffc0207bdc:	6161                	addi	sp,sp,80
ffffffffc0207bde:	8082                	ret
ffffffffc0207be0:	8522                	mv	a0,s0
ffffffffc0207be2:	c45f80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207be6:	609c                	ld	a5,0(s1)
ffffffffc0207be8:	86ca                	mv	a3,s2
ffffffffc0207bea:	00002617          	auipc	a2,0x2
ffffffffc0207bee:	15660613          	addi	a2,a2,342 # ffffffffc0209d40 <default_pmm_manager+0x8c8>
ffffffffc0207bf2:	43d8                	lw	a4,4(a5)
ffffffffc0207bf4:	07300593          	li	a1,115
ffffffffc0207bf8:	0b478793          	addi	a5,a5,180
ffffffffc0207bfc:	00002517          	auipc	a0,0x2
ffffffffc0207c00:	17450513          	addi	a0,a0,372 # ffffffffc0209d70 <default_pmm_manager+0x8f8>
ffffffffc0207c04:	e04f80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207c08 <strnlen>:
ffffffffc0207c08:	872a                	mv	a4,a0
ffffffffc0207c0a:	4501                	li	a0,0
ffffffffc0207c0c:	e589                	bnez	a1,ffffffffc0207c16 <strnlen+0xe>
ffffffffc0207c0e:	a811                	j	ffffffffc0207c22 <strnlen+0x1a>
ffffffffc0207c10:	0505                	addi	a0,a0,1
ffffffffc0207c12:	00a58763          	beq	a1,a0,ffffffffc0207c20 <strnlen+0x18>
ffffffffc0207c16:	00a707b3          	add	a5,a4,a0
ffffffffc0207c1a:	0007c783          	lbu	a5,0(a5)
ffffffffc0207c1e:	fbed                	bnez	a5,ffffffffc0207c10 <strnlen+0x8>
ffffffffc0207c20:	8082                	ret
ffffffffc0207c22:	8082                	ret

ffffffffc0207c24 <strcmp>:
ffffffffc0207c24:	00054783          	lbu	a5,0(a0)
ffffffffc0207c28:	0005c703          	lbu	a4,0(a1)
ffffffffc0207c2c:	cb89                	beqz	a5,ffffffffc0207c3e <strcmp+0x1a>
ffffffffc0207c2e:	0505                	addi	a0,a0,1
ffffffffc0207c30:	0585                	addi	a1,a1,1
ffffffffc0207c32:	fee789e3          	beq	a5,a4,ffffffffc0207c24 <strcmp>
ffffffffc0207c36:	0007851b          	sext.w	a0,a5
ffffffffc0207c3a:	9d19                	subw	a0,a0,a4
ffffffffc0207c3c:	8082                	ret
ffffffffc0207c3e:	4501                	li	a0,0
ffffffffc0207c40:	bfed                	j	ffffffffc0207c3a <strcmp+0x16>

ffffffffc0207c42 <strchr>:
ffffffffc0207c42:	00054783          	lbu	a5,0(a0)
ffffffffc0207c46:	c799                	beqz	a5,ffffffffc0207c54 <strchr+0x12>
ffffffffc0207c48:	00f58763          	beq	a1,a5,ffffffffc0207c56 <strchr+0x14>
ffffffffc0207c4c:	00154783          	lbu	a5,1(a0)
ffffffffc0207c50:	0505                	addi	a0,a0,1
ffffffffc0207c52:	fbfd                	bnez	a5,ffffffffc0207c48 <strchr+0x6>
ffffffffc0207c54:	4501                	li	a0,0
ffffffffc0207c56:	8082                	ret

ffffffffc0207c58 <memset>:
ffffffffc0207c58:	ca01                	beqz	a2,ffffffffc0207c68 <memset+0x10>
ffffffffc0207c5a:	962a                	add	a2,a2,a0
ffffffffc0207c5c:	87aa                	mv	a5,a0
ffffffffc0207c5e:	0785                	addi	a5,a5,1
ffffffffc0207c60:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207c64:	fec79de3          	bne	a5,a2,ffffffffc0207c5e <memset+0x6>
ffffffffc0207c68:	8082                	ret

ffffffffc0207c6a <memcpy>:
ffffffffc0207c6a:	ca19                	beqz	a2,ffffffffc0207c80 <memcpy+0x16>
ffffffffc0207c6c:	962e                	add	a2,a2,a1
ffffffffc0207c6e:	87aa                	mv	a5,a0
ffffffffc0207c70:	0005c703          	lbu	a4,0(a1)
ffffffffc0207c74:	0585                	addi	a1,a1,1
ffffffffc0207c76:	0785                	addi	a5,a5,1
ffffffffc0207c78:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207c7c:	fec59ae3          	bne	a1,a2,ffffffffc0207c70 <memcpy+0x6>
ffffffffc0207c80:	8082                	ret

ffffffffc0207c82 <printnum>:
ffffffffc0207c82:	02069813          	slli	a6,a3,0x20
ffffffffc0207c86:	7179                	addi	sp,sp,-48
ffffffffc0207c88:	02085813          	srli	a6,a6,0x20
ffffffffc0207c8c:	e052                	sd	s4,0(sp)
ffffffffc0207c8e:	03067a33          	remu	s4,a2,a6
ffffffffc0207c92:	f022                	sd	s0,32(sp)
ffffffffc0207c94:	ec26                	sd	s1,24(sp)
ffffffffc0207c96:	e84a                	sd	s2,16(sp)
ffffffffc0207c98:	f406                	sd	ra,40(sp)
ffffffffc0207c9a:	e44e                	sd	s3,8(sp)
ffffffffc0207c9c:	84aa                	mv	s1,a0
ffffffffc0207c9e:	892e                	mv	s2,a1
ffffffffc0207ca0:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207ca4:	2a01                	sext.w	s4,s4
ffffffffc0207ca6:	03067e63          	bgeu	a2,a6,ffffffffc0207ce2 <printnum+0x60>
ffffffffc0207caa:	89be                	mv	s3,a5
ffffffffc0207cac:	00805763          	blez	s0,ffffffffc0207cba <printnum+0x38>
ffffffffc0207cb0:	347d                	addiw	s0,s0,-1
ffffffffc0207cb2:	85ca                	mv	a1,s2
ffffffffc0207cb4:	854e                	mv	a0,s3
ffffffffc0207cb6:	9482                	jalr	s1
ffffffffc0207cb8:	fc65                	bnez	s0,ffffffffc0207cb0 <printnum+0x2e>
ffffffffc0207cba:	1a02                	slli	s4,s4,0x20
ffffffffc0207cbc:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207cc0:	00003797          	auipc	a5,0x3
ffffffffc0207cc4:	8c878793          	addi	a5,a5,-1848 # ffffffffc020a588 <syscalls+0x800>
ffffffffc0207cc8:	7402                	ld	s0,32(sp)
ffffffffc0207cca:	9a3e                	add	s4,s4,a5
ffffffffc0207ccc:	000a4503          	lbu	a0,0(s4)
ffffffffc0207cd0:	70a2                	ld	ra,40(sp)
ffffffffc0207cd2:	69a2                	ld	s3,8(sp)
ffffffffc0207cd4:	6a02                	ld	s4,0(sp)
ffffffffc0207cd6:	85ca                	mv	a1,s2
ffffffffc0207cd8:	8326                	mv	t1,s1
ffffffffc0207cda:	6942                	ld	s2,16(sp)
ffffffffc0207cdc:	64e2                	ld	s1,24(sp)
ffffffffc0207cde:	6145                	addi	sp,sp,48
ffffffffc0207ce0:	8302                	jr	t1
ffffffffc0207ce2:	03065633          	divu	a2,a2,a6
ffffffffc0207ce6:	8722                	mv	a4,s0
ffffffffc0207ce8:	f9bff0ef          	jal	ra,ffffffffc0207c82 <printnum>
ffffffffc0207cec:	b7f9                	j	ffffffffc0207cba <printnum+0x38>

ffffffffc0207cee <vprintfmt>:
ffffffffc0207cee:	7119                	addi	sp,sp,-128
ffffffffc0207cf0:	f4a6                	sd	s1,104(sp)
ffffffffc0207cf2:	f0ca                	sd	s2,96(sp)
ffffffffc0207cf4:	ecce                	sd	s3,88(sp)
ffffffffc0207cf6:	e8d2                	sd	s4,80(sp)
ffffffffc0207cf8:	e4d6                	sd	s5,72(sp)
ffffffffc0207cfa:	e0da                	sd	s6,64(sp)
ffffffffc0207cfc:	fc5e                	sd	s7,56(sp)
ffffffffc0207cfe:	f06a                	sd	s10,32(sp)
ffffffffc0207d00:	fc86                	sd	ra,120(sp)
ffffffffc0207d02:	f8a2                	sd	s0,112(sp)
ffffffffc0207d04:	f862                	sd	s8,48(sp)
ffffffffc0207d06:	f466                	sd	s9,40(sp)
ffffffffc0207d08:	ec6e                	sd	s11,24(sp)
ffffffffc0207d0a:	892a                	mv	s2,a0
ffffffffc0207d0c:	84ae                	mv	s1,a1
ffffffffc0207d0e:	8d32                	mv	s10,a2
ffffffffc0207d10:	8a36                	mv	s4,a3
ffffffffc0207d12:	02500993          	li	s3,37
ffffffffc0207d16:	5b7d                	li	s6,-1
ffffffffc0207d18:	00003a97          	auipc	s5,0x3
ffffffffc0207d1c:	89ca8a93          	addi	s5,s5,-1892 # ffffffffc020a5b4 <syscalls+0x82c>
ffffffffc0207d20:	00003b97          	auipc	s7,0x3
ffffffffc0207d24:	ab0b8b93          	addi	s7,s7,-1360 # ffffffffc020a7d0 <error_string>
ffffffffc0207d28:	000d4503          	lbu	a0,0(s10)
ffffffffc0207d2c:	001d0413          	addi	s0,s10,1
ffffffffc0207d30:	01350a63          	beq	a0,s3,ffffffffc0207d44 <vprintfmt+0x56>
ffffffffc0207d34:	c121                	beqz	a0,ffffffffc0207d74 <vprintfmt+0x86>
ffffffffc0207d36:	85a6                	mv	a1,s1
ffffffffc0207d38:	0405                	addi	s0,s0,1
ffffffffc0207d3a:	9902                	jalr	s2
ffffffffc0207d3c:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207d40:	ff351ae3          	bne	a0,s3,ffffffffc0207d34 <vprintfmt+0x46>
ffffffffc0207d44:	00044603          	lbu	a2,0(s0)
ffffffffc0207d48:	02000793          	li	a5,32
ffffffffc0207d4c:	4c81                	li	s9,0
ffffffffc0207d4e:	4881                	li	a7,0
ffffffffc0207d50:	5c7d                	li	s8,-1
ffffffffc0207d52:	5dfd                	li	s11,-1
ffffffffc0207d54:	05500513          	li	a0,85
ffffffffc0207d58:	4825                	li	a6,9
ffffffffc0207d5a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207d5e:	0ff5f593          	andi	a1,a1,255
ffffffffc0207d62:	00140d13          	addi	s10,s0,1
ffffffffc0207d66:	04b56263          	bltu	a0,a1,ffffffffc0207daa <vprintfmt+0xbc>
ffffffffc0207d6a:	058a                	slli	a1,a1,0x2
ffffffffc0207d6c:	95d6                	add	a1,a1,s5
ffffffffc0207d6e:	4194                	lw	a3,0(a1)
ffffffffc0207d70:	96d6                	add	a3,a3,s5
ffffffffc0207d72:	8682                	jr	a3
ffffffffc0207d74:	70e6                	ld	ra,120(sp)
ffffffffc0207d76:	7446                	ld	s0,112(sp)
ffffffffc0207d78:	74a6                	ld	s1,104(sp)
ffffffffc0207d7a:	7906                	ld	s2,96(sp)
ffffffffc0207d7c:	69e6                	ld	s3,88(sp)
ffffffffc0207d7e:	6a46                	ld	s4,80(sp)
ffffffffc0207d80:	6aa6                	ld	s5,72(sp)
ffffffffc0207d82:	6b06                	ld	s6,64(sp)
ffffffffc0207d84:	7be2                	ld	s7,56(sp)
ffffffffc0207d86:	7c42                	ld	s8,48(sp)
ffffffffc0207d88:	7ca2                	ld	s9,40(sp)
ffffffffc0207d8a:	7d02                	ld	s10,32(sp)
ffffffffc0207d8c:	6de2                	ld	s11,24(sp)
ffffffffc0207d8e:	6109                	addi	sp,sp,128
ffffffffc0207d90:	8082                	ret
ffffffffc0207d92:	87b2                	mv	a5,a2
ffffffffc0207d94:	00144603          	lbu	a2,1(s0)
ffffffffc0207d98:	846a                	mv	s0,s10
ffffffffc0207d9a:	00140d13          	addi	s10,s0,1
ffffffffc0207d9e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207da2:	0ff5f593          	andi	a1,a1,255
ffffffffc0207da6:	fcb572e3          	bgeu	a0,a1,ffffffffc0207d6a <vprintfmt+0x7c>
ffffffffc0207daa:	85a6                	mv	a1,s1
ffffffffc0207dac:	02500513          	li	a0,37
ffffffffc0207db0:	9902                	jalr	s2
ffffffffc0207db2:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207db6:	8d22                	mv	s10,s0
ffffffffc0207db8:	f73788e3          	beq	a5,s3,ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207dbc:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207dc0:	1d7d                	addi	s10,s10,-1
ffffffffc0207dc2:	ff379de3          	bne	a5,s3,ffffffffc0207dbc <vprintfmt+0xce>
ffffffffc0207dc6:	b78d                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207dc8:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207dcc:	00144603          	lbu	a2,1(s0)
ffffffffc0207dd0:	846a                	mv	s0,s10
ffffffffc0207dd2:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207dd6:	0006059b          	sext.w	a1,a2
ffffffffc0207dda:	02d86463          	bltu	a6,a3,ffffffffc0207e02 <vprintfmt+0x114>
ffffffffc0207dde:	00144603          	lbu	a2,1(s0)
ffffffffc0207de2:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207de6:	0186873b          	addw	a4,a3,s8
ffffffffc0207dea:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207dee:	9f2d                	addw	a4,a4,a1
ffffffffc0207df0:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207df4:	0405                	addi	s0,s0,1
ffffffffc0207df6:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207dfa:	0006059b          	sext.w	a1,a2
ffffffffc0207dfe:	fed870e3          	bgeu	a6,a3,ffffffffc0207dde <vprintfmt+0xf0>
ffffffffc0207e02:	f40ddce3          	bgez	s11,ffffffffc0207d5a <vprintfmt+0x6c>
ffffffffc0207e06:	8de2                	mv	s11,s8
ffffffffc0207e08:	5c7d                	li	s8,-1
ffffffffc0207e0a:	bf81                	j	ffffffffc0207d5a <vprintfmt+0x6c>
ffffffffc0207e0c:	fffdc693          	not	a3,s11
ffffffffc0207e10:	96fd                	srai	a3,a3,0x3f
ffffffffc0207e12:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207e16:	00144603          	lbu	a2,1(s0)
ffffffffc0207e1a:	2d81                	sext.w	s11,s11
ffffffffc0207e1c:	846a                	mv	s0,s10
ffffffffc0207e1e:	bf35                	j	ffffffffc0207d5a <vprintfmt+0x6c>
ffffffffc0207e20:	000a2c03          	lw	s8,0(s4)
ffffffffc0207e24:	00144603          	lbu	a2,1(s0)
ffffffffc0207e28:	0a21                	addi	s4,s4,8
ffffffffc0207e2a:	846a                	mv	s0,s10
ffffffffc0207e2c:	bfd9                	j	ffffffffc0207e02 <vprintfmt+0x114>
ffffffffc0207e2e:	4705                	li	a4,1
ffffffffc0207e30:	008a0593          	addi	a1,s4,8
ffffffffc0207e34:	01174463          	blt	a4,a7,ffffffffc0207e3c <vprintfmt+0x14e>
ffffffffc0207e38:	1a088e63          	beqz	a7,ffffffffc0207ff4 <vprintfmt+0x306>
ffffffffc0207e3c:	000a3603          	ld	a2,0(s4)
ffffffffc0207e40:	46c1                	li	a3,16
ffffffffc0207e42:	8a2e                	mv	s4,a1
ffffffffc0207e44:	2781                	sext.w	a5,a5
ffffffffc0207e46:	876e                	mv	a4,s11
ffffffffc0207e48:	85a6                	mv	a1,s1
ffffffffc0207e4a:	854a                	mv	a0,s2
ffffffffc0207e4c:	e37ff0ef          	jal	ra,ffffffffc0207c82 <printnum>
ffffffffc0207e50:	bde1                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207e52:	000a2503          	lw	a0,0(s4)
ffffffffc0207e56:	85a6                	mv	a1,s1
ffffffffc0207e58:	0a21                	addi	s4,s4,8
ffffffffc0207e5a:	9902                	jalr	s2
ffffffffc0207e5c:	b5f1                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207e5e:	4705                	li	a4,1
ffffffffc0207e60:	008a0593          	addi	a1,s4,8
ffffffffc0207e64:	01174463          	blt	a4,a7,ffffffffc0207e6c <vprintfmt+0x17e>
ffffffffc0207e68:	18088163          	beqz	a7,ffffffffc0207fea <vprintfmt+0x2fc>
ffffffffc0207e6c:	000a3603          	ld	a2,0(s4)
ffffffffc0207e70:	46a9                	li	a3,10
ffffffffc0207e72:	8a2e                	mv	s4,a1
ffffffffc0207e74:	bfc1                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207e76:	00144603          	lbu	a2,1(s0)
ffffffffc0207e7a:	4c85                	li	s9,1
ffffffffc0207e7c:	846a                	mv	s0,s10
ffffffffc0207e7e:	bdf1                	j	ffffffffc0207d5a <vprintfmt+0x6c>
ffffffffc0207e80:	85a6                	mv	a1,s1
ffffffffc0207e82:	02500513          	li	a0,37
ffffffffc0207e86:	9902                	jalr	s2
ffffffffc0207e88:	b545                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207e8a:	00144603          	lbu	a2,1(s0)
ffffffffc0207e8e:	2885                	addiw	a7,a7,1
ffffffffc0207e90:	846a                	mv	s0,s10
ffffffffc0207e92:	b5e1                	j	ffffffffc0207d5a <vprintfmt+0x6c>
ffffffffc0207e94:	4705                	li	a4,1
ffffffffc0207e96:	008a0593          	addi	a1,s4,8
ffffffffc0207e9a:	01174463          	blt	a4,a7,ffffffffc0207ea2 <vprintfmt+0x1b4>
ffffffffc0207e9e:	14088163          	beqz	a7,ffffffffc0207fe0 <vprintfmt+0x2f2>
ffffffffc0207ea2:	000a3603          	ld	a2,0(s4)
ffffffffc0207ea6:	46a1                	li	a3,8
ffffffffc0207ea8:	8a2e                	mv	s4,a1
ffffffffc0207eaa:	bf69                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207eac:	03000513          	li	a0,48
ffffffffc0207eb0:	85a6                	mv	a1,s1
ffffffffc0207eb2:	e03e                	sd	a5,0(sp)
ffffffffc0207eb4:	9902                	jalr	s2
ffffffffc0207eb6:	85a6                	mv	a1,s1
ffffffffc0207eb8:	07800513          	li	a0,120
ffffffffc0207ebc:	9902                	jalr	s2
ffffffffc0207ebe:	0a21                	addi	s4,s4,8
ffffffffc0207ec0:	6782                	ld	a5,0(sp)
ffffffffc0207ec2:	46c1                	li	a3,16
ffffffffc0207ec4:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207ec8:	bfb5                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207eca:	000a3403          	ld	s0,0(s4)
ffffffffc0207ece:	008a0713          	addi	a4,s4,8
ffffffffc0207ed2:	e03a                	sd	a4,0(sp)
ffffffffc0207ed4:	14040263          	beqz	s0,ffffffffc0208018 <vprintfmt+0x32a>
ffffffffc0207ed8:	0fb05763          	blez	s11,ffffffffc0207fc6 <vprintfmt+0x2d8>
ffffffffc0207edc:	02d00693          	li	a3,45
ffffffffc0207ee0:	0cd79163          	bne	a5,a3,ffffffffc0207fa2 <vprintfmt+0x2b4>
ffffffffc0207ee4:	00044783          	lbu	a5,0(s0)
ffffffffc0207ee8:	0007851b          	sext.w	a0,a5
ffffffffc0207eec:	cf85                	beqz	a5,ffffffffc0207f24 <vprintfmt+0x236>
ffffffffc0207eee:	00140a13          	addi	s4,s0,1
ffffffffc0207ef2:	05e00413          	li	s0,94
ffffffffc0207ef6:	000c4563          	bltz	s8,ffffffffc0207f00 <vprintfmt+0x212>
ffffffffc0207efa:	3c7d                	addiw	s8,s8,-1
ffffffffc0207efc:	036c0263          	beq	s8,s6,ffffffffc0207f20 <vprintfmt+0x232>
ffffffffc0207f00:	85a6                	mv	a1,s1
ffffffffc0207f02:	0e0c8e63          	beqz	s9,ffffffffc0207ffe <vprintfmt+0x310>
ffffffffc0207f06:	3781                	addiw	a5,a5,-32
ffffffffc0207f08:	0ef47b63          	bgeu	s0,a5,ffffffffc0207ffe <vprintfmt+0x310>
ffffffffc0207f0c:	03f00513          	li	a0,63
ffffffffc0207f10:	9902                	jalr	s2
ffffffffc0207f12:	000a4783          	lbu	a5,0(s4)
ffffffffc0207f16:	3dfd                	addiw	s11,s11,-1
ffffffffc0207f18:	0a05                	addi	s4,s4,1
ffffffffc0207f1a:	0007851b          	sext.w	a0,a5
ffffffffc0207f1e:	ffe1                	bnez	a5,ffffffffc0207ef6 <vprintfmt+0x208>
ffffffffc0207f20:	01b05963          	blez	s11,ffffffffc0207f32 <vprintfmt+0x244>
ffffffffc0207f24:	3dfd                	addiw	s11,s11,-1
ffffffffc0207f26:	85a6                	mv	a1,s1
ffffffffc0207f28:	02000513          	li	a0,32
ffffffffc0207f2c:	9902                	jalr	s2
ffffffffc0207f2e:	fe0d9be3          	bnez	s11,ffffffffc0207f24 <vprintfmt+0x236>
ffffffffc0207f32:	6a02                	ld	s4,0(sp)
ffffffffc0207f34:	bbd5                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207f36:	4705                	li	a4,1
ffffffffc0207f38:	008a0c93          	addi	s9,s4,8
ffffffffc0207f3c:	01174463          	blt	a4,a7,ffffffffc0207f44 <vprintfmt+0x256>
ffffffffc0207f40:	08088d63          	beqz	a7,ffffffffc0207fda <vprintfmt+0x2ec>
ffffffffc0207f44:	000a3403          	ld	s0,0(s4)
ffffffffc0207f48:	0a044d63          	bltz	s0,ffffffffc0208002 <vprintfmt+0x314>
ffffffffc0207f4c:	8622                	mv	a2,s0
ffffffffc0207f4e:	8a66                	mv	s4,s9
ffffffffc0207f50:	46a9                	li	a3,10
ffffffffc0207f52:	bdcd                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207f54:	000a2783          	lw	a5,0(s4)
ffffffffc0207f58:	4761                	li	a4,24
ffffffffc0207f5a:	0a21                	addi	s4,s4,8
ffffffffc0207f5c:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207f60:	8fb5                	xor	a5,a5,a3
ffffffffc0207f62:	40d786bb          	subw	a3,a5,a3
ffffffffc0207f66:	02d74163          	blt	a4,a3,ffffffffc0207f88 <vprintfmt+0x29a>
ffffffffc0207f6a:	00369793          	slli	a5,a3,0x3
ffffffffc0207f6e:	97de                	add	a5,a5,s7
ffffffffc0207f70:	639c                	ld	a5,0(a5)
ffffffffc0207f72:	cb99                	beqz	a5,ffffffffc0207f88 <vprintfmt+0x29a>
ffffffffc0207f74:	86be                	mv	a3,a5
ffffffffc0207f76:	00000617          	auipc	a2,0x0
ffffffffc0207f7a:	13260613          	addi	a2,a2,306 # ffffffffc02080a8 <etext+0x22>
ffffffffc0207f7e:	85a6                	mv	a1,s1
ffffffffc0207f80:	854a                	mv	a0,s2
ffffffffc0207f82:	0ce000ef          	jal	ra,ffffffffc0208050 <printfmt>
ffffffffc0207f86:	b34d                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207f88:	00002617          	auipc	a2,0x2
ffffffffc0207f8c:	62060613          	addi	a2,a2,1568 # ffffffffc020a5a8 <syscalls+0x820>
ffffffffc0207f90:	85a6                	mv	a1,s1
ffffffffc0207f92:	854a                	mv	a0,s2
ffffffffc0207f94:	0bc000ef          	jal	ra,ffffffffc0208050 <printfmt>
ffffffffc0207f98:	bb41                	j	ffffffffc0207d28 <vprintfmt+0x3a>
ffffffffc0207f9a:	00002417          	auipc	s0,0x2
ffffffffc0207f9e:	60640413          	addi	s0,s0,1542 # ffffffffc020a5a0 <syscalls+0x818>
ffffffffc0207fa2:	85e2                	mv	a1,s8
ffffffffc0207fa4:	8522                	mv	a0,s0
ffffffffc0207fa6:	e43e                	sd	a5,8(sp)
ffffffffc0207fa8:	c61ff0ef          	jal	ra,ffffffffc0207c08 <strnlen>
ffffffffc0207fac:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207fb0:	01b05b63          	blez	s11,ffffffffc0207fc6 <vprintfmt+0x2d8>
ffffffffc0207fb4:	67a2                	ld	a5,8(sp)
ffffffffc0207fb6:	00078a1b          	sext.w	s4,a5
ffffffffc0207fba:	3dfd                	addiw	s11,s11,-1
ffffffffc0207fbc:	85a6                	mv	a1,s1
ffffffffc0207fbe:	8552                	mv	a0,s4
ffffffffc0207fc0:	9902                	jalr	s2
ffffffffc0207fc2:	fe0d9ce3          	bnez	s11,ffffffffc0207fba <vprintfmt+0x2cc>
ffffffffc0207fc6:	00044783          	lbu	a5,0(s0)
ffffffffc0207fca:	00140a13          	addi	s4,s0,1
ffffffffc0207fce:	0007851b          	sext.w	a0,a5
ffffffffc0207fd2:	d3a5                	beqz	a5,ffffffffc0207f32 <vprintfmt+0x244>
ffffffffc0207fd4:	05e00413          	li	s0,94
ffffffffc0207fd8:	bf39                	j	ffffffffc0207ef6 <vprintfmt+0x208>
ffffffffc0207fda:	000a2403          	lw	s0,0(s4)
ffffffffc0207fde:	b7ad                	j	ffffffffc0207f48 <vprintfmt+0x25a>
ffffffffc0207fe0:	000a6603          	lwu	a2,0(s4)
ffffffffc0207fe4:	46a1                	li	a3,8
ffffffffc0207fe6:	8a2e                	mv	s4,a1
ffffffffc0207fe8:	bdb1                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207fea:	000a6603          	lwu	a2,0(s4)
ffffffffc0207fee:	46a9                	li	a3,10
ffffffffc0207ff0:	8a2e                	mv	s4,a1
ffffffffc0207ff2:	bd89                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207ff4:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ff8:	46c1                	li	a3,16
ffffffffc0207ffa:	8a2e                	mv	s4,a1
ffffffffc0207ffc:	b5a1                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0207ffe:	9902                	jalr	s2
ffffffffc0208000:	bf09                	j	ffffffffc0207f12 <vprintfmt+0x224>
ffffffffc0208002:	85a6                	mv	a1,s1
ffffffffc0208004:	02d00513          	li	a0,45
ffffffffc0208008:	e03e                	sd	a5,0(sp)
ffffffffc020800a:	9902                	jalr	s2
ffffffffc020800c:	6782                	ld	a5,0(sp)
ffffffffc020800e:	8a66                	mv	s4,s9
ffffffffc0208010:	40800633          	neg	a2,s0
ffffffffc0208014:	46a9                	li	a3,10
ffffffffc0208016:	b53d                	j	ffffffffc0207e44 <vprintfmt+0x156>
ffffffffc0208018:	03b05163          	blez	s11,ffffffffc020803a <vprintfmt+0x34c>
ffffffffc020801c:	02d00693          	li	a3,45
ffffffffc0208020:	f6d79de3          	bne	a5,a3,ffffffffc0207f9a <vprintfmt+0x2ac>
ffffffffc0208024:	00002417          	auipc	s0,0x2
ffffffffc0208028:	57c40413          	addi	s0,s0,1404 # ffffffffc020a5a0 <syscalls+0x818>
ffffffffc020802c:	02800793          	li	a5,40
ffffffffc0208030:	02800513          	li	a0,40
ffffffffc0208034:	00140a13          	addi	s4,s0,1
ffffffffc0208038:	bd6d                	j	ffffffffc0207ef2 <vprintfmt+0x204>
ffffffffc020803a:	00002a17          	auipc	s4,0x2
ffffffffc020803e:	567a0a13          	addi	s4,s4,1383 # ffffffffc020a5a1 <syscalls+0x819>
ffffffffc0208042:	02800513          	li	a0,40
ffffffffc0208046:	02800793          	li	a5,40
ffffffffc020804a:	05e00413          	li	s0,94
ffffffffc020804e:	b565                	j	ffffffffc0207ef6 <vprintfmt+0x208>

ffffffffc0208050 <printfmt>:
ffffffffc0208050:	715d                	addi	sp,sp,-80
ffffffffc0208052:	02810313          	addi	t1,sp,40
ffffffffc0208056:	f436                	sd	a3,40(sp)
ffffffffc0208058:	869a                	mv	a3,t1
ffffffffc020805a:	ec06                	sd	ra,24(sp)
ffffffffc020805c:	f83a                	sd	a4,48(sp)
ffffffffc020805e:	fc3e                	sd	a5,56(sp)
ffffffffc0208060:	e0c2                	sd	a6,64(sp)
ffffffffc0208062:	e4c6                	sd	a7,72(sp)
ffffffffc0208064:	e41a                	sd	t1,8(sp)
ffffffffc0208066:	c89ff0ef          	jal	ra,ffffffffc0207cee <vprintfmt>
ffffffffc020806a:	60e2                	ld	ra,24(sp)
ffffffffc020806c:	6161                	addi	sp,sp,80
ffffffffc020806e:	8082                	ret

ffffffffc0208070 <hash32>:
ffffffffc0208070:	9e3707b7          	lui	a5,0x9e370
ffffffffc0208074:	2785                	addiw	a5,a5,1
ffffffffc0208076:	02a7853b          	mulw	a0,a5,a0
ffffffffc020807a:	02000793          	li	a5,32
ffffffffc020807e:	9f8d                	subw	a5,a5,a1
ffffffffc0208080:	00f5553b          	srlw	a0,a0,a5
ffffffffc0208084:	8082                	ret
