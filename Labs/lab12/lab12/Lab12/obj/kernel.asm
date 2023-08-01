
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
ffffffffc0200036:	05e50513          	addi	a0,a0,94 # ffffffffc020e090 <buf>
ffffffffc020003a:	00019617          	auipc	a2,0x19
ffffffffc020003e:	70e60613          	addi	a2,a2,1806 # ffffffffc0219748 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	2bb070ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc020004e:	570000ef          	jal	ra,ffffffffc02005be <cons_init>
ffffffffc0200052:	00008597          	auipc	a1,0x8
ffffffffc0200056:	ee658593          	addi	a1,a1,-282 # ffffffffc0207f38 <etext+0x6>
ffffffffc020005a:	00008517          	auipc	a0,0x8
ffffffffc020005e:	ef650513          	addi	a0,a0,-266 # ffffffffc0207f50 <etext+0x1e>
ffffffffc0200062:	06a000ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200066:	5f5000ef          	jal	ra,ffffffffc0200e5a <pmm_init>
ffffffffc020006a:	5c6000ef          	jal	ra,ffffffffc0200630 <pic_init>
ffffffffc020006e:	5d0000ef          	jal	ra,ffffffffc020063e <idt_init>
ffffffffc0200072:	623010ef          	jal	ra,ffffffffc0201e94 <vmm_init>
ffffffffc0200076:	105040ef          	jal	ra,ffffffffc020497a <sched_init>
ffffffffc020007a:	6f2040ef          	jal	ra,ffffffffc020476c <proc_init>
ffffffffc020007e:	4a2000ef          	jal	ra,ffffffffc0200520 <ide_init>
ffffffffc0200082:	350020ef          	jal	ra,ffffffffc02023d2 <swap_init>
ffffffffc0200086:	4f0000ef          	jal	ra,ffffffffc0200576 <clock_init>
ffffffffc020008a:	5a8000ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020008e:	015040ef          	jal	ra,ffffffffc02048a2 <cpu_idle>

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
ffffffffc02000c0:	2db070ef          	jal	ra,ffffffffc0207b9a <vprintfmt>
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
ffffffffc02000f6:	2a5070ef          	jal	ra,ffffffffc0207b9a <vprintfmt>
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
ffffffffc020016e:	dee50513          	addi	a0,a0,-530 # ffffffffc0207f58 <etext+0x26>
ffffffffc0200172:	f5bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200176:	4481                	li	s1,0
ffffffffc0200178:	497d                	li	s2,31
ffffffffc020017a:	49a1                	li	s3,8
ffffffffc020017c:	4aa9                	li	s5,10
ffffffffc020017e:	4b35                	li	s6,13
ffffffffc0200180:	0000eb97          	auipc	s7,0xe
ffffffffc0200184:	f10b8b93          	addi	s7,s7,-240 # ffffffffc020e090 <buf>
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
ffffffffc02001e0:	eb450513          	addi	a0,a0,-332 # ffffffffc020e090 <buf>
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
ffffffffc020020c:	2b830313          	addi	t1,t1,696 # ffffffffc02194c0 <is_panic>
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
ffffffffc020023a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0207f60 <etext+0x2e>
ffffffffc020023e:	e43e                	sd	a5,8(sp)
ffffffffc0200240:	e8dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200244:	65a2                	ld	a1,8(sp)
ffffffffc0200246:	8522                	mv	a0,s0
ffffffffc0200248:	e65ff0ef          	jal	ra,ffffffffc02000ac <vcprintf>
ffffffffc020024c:	00009517          	auipc	a0,0x9
ffffffffc0200250:	1e450513          	addi	a0,a0,484 # ffffffffc0209430 <default_pmm_manager+0x108>
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
ffffffffc0200284:	d0050513          	addi	a0,a0,-768 # ffffffffc0207f80 <etext+0x4e>
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
ffffffffc02002a0:	00009517          	auipc	a0,0x9
ffffffffc02002a4:	19050513          	addi	a0,a0,400 # ffffffffc0209430 <default_pmm_manager+0x108>
ffffffffc02002a8:	e25ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ac:	60e2                	ld	ra,24(sp)
ffffffffc02002ae:	6442                	ld	s0,16(sp)
ffffffffc02002b0:	6161                	addi	sp,sp,80
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <print_kerninfo>:
ffffffffc02002b4:	1141                	addi	sp,sp,-16
ffffffffc02002b6:	00008517          	auipc	a0,0x8
ffffffffc02002ba:	cea50513          	addi	a0,a0,-790 # ffffffffc0207fa0 <etext+0x6e>
ffffffffc02002be:	e406                	sd	ra,8(sp)
ffffffffc02002c0:	e0dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002c4:	00000597          	auipc	a1,0x0
ffffffffc02002c8:	d6e58593          	addi	a1,a1,-658 # ffffffffc0200032 <kern_init>
ffffffffc02002cc:	00008517          	auipc	a0,0x8
ffffffffc02002d0:	cf450513          	addi	a0,a0,-780 # ffffffffc0207fc0 <etext+0x8e>
ffffffffc02002d4:	df9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002d8:	00008597          	auipc	a1,0x8
ffffffffc02002dc:	c5a58593          	addi	a1,a1,-934 # ffffffffc0207f32 <etext>
ffffffffc02002e0:	00008517          	auipc	a0,0x8
ffffffffc02002e4:	d0050513          	addi	a0,a0,-768 # ffffffffc0207fe0 <etext+0xae>
ffffffffc02002e8:	de5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02002ec:	0000e597          	auipc	a1,0xe
ffffffffc02002f0:	da458593          	addi	a1,a1,-604 # ffffffffc020e090 <buf>
ffffffffc02002f4:	00008517          	auipc	a0,0x8
ffffffffc02002f8:	d0c50513          	addi	a0,a0,-756 # ffffffffc0208000 <etext+0xce>
ffffffffc02002fc:	dd1ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200300:	00019597          	auipc	a1,0x19
ffffffffc0200304:	44858593          	addi	a1,a1,1096 # ffffffffc0219748 <end>
ffffffffc0200308:	00008517          	auipc	a0,0x8
ffffffffc020030c:	d1850513          	addi	a0,a0,-744 # ffffffffc0208020 <etext+0xee>
ffffffffc0200310:	dbdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200314:	0001a597          	auipc	a1,0x1a
ffffffffc0200318:	83358593          	addi	a1,a1,-1997 # ffffffffc0219b47 <end+0x3ff>
ffffffffc020031c:	00000797          	auipc	a5,0x0
ffffffffc0200320:	d1678793          	addi	a5,a5,-746 # ffffffffc0200032 <kern_init>
ffffffffc0200324:	40f587b3          	sub	a5,a1,a5
ffffffffc0200328:	43f7d593          	srai	a1,a5,0x3f
ffffffffc020032c:	60a2                	ld	ra,8(sp)
ffffffffc020032e:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200332:	95be                	add	a1,a1,a5
ffffffffc0200334:	85a9                	srai	a1,a1,0xa
ffffffffc0200336:	00008517          	auipc	a0,0x8
ffffffffc020033a:	d0a50513          	addi	a0,a0,-758 # ffffffffc0208040 <etext+0x10e>
ffffffffc020033e:	0141                	addi	sp,sp,16
ffffffffc0200340:	b371                	j	ffffffffc02000cc <cprintf>

ffffffffc0200342 <print_stackframe>:
ffffffffc0200342:	1141                	addi	sp,sp,-16
ffffffffc0200344:	00008617          	auipc	a2,0x8
ffffffffc0200348:	d2c60613          	addi	a2,a2,-724 # ffffffffc0208070 <etext+0x13e>
ffffffffc020034c:	05b00593          	li	a1,91
ffffffffc0200350:	00008517          	auipc	a0,0x8
ffffffffc0200354:	d3850513          	addi	a0,a0,-712 # ffffffffc0208088 <etext+0x156>
ffffffffc0200358:	e406                	sd	ra,8(sp)
ffffffffc020035a:	eafff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020035e <mon_help>:
ffffffffc020035e:	1141                	addi	sp,sp,-16
ffffffffc0200360:	00008617          	auipc	a2,0x8
ffffffffc0200364:	d4060613          	addi	a2,a2,-704 # ffffffffc02080a0 <etext+0x16e>
ffffffffc0200368:	00008597          	auipc	a1,0x8
ffffffffc020036c:	d5858593          	addi	a1,a1,-680 # ffffffffc02080c0 <etext+0x18e>
ffffffffc0200370:	00008517          	auipc	a0,0x8
ffffffffc0200374:	d5850513          	addi	a0,a0,-680 # ffffffffc02080c8 <etext+0x196>
ffffffffc0200378:	e406                	sd	ra,8(sp)
ffffffffc020037a:	d53ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020037e:	00008617          	auipc	a2,0x8
ffffffffc0200382:	d5a60613          	addi	a2,a2,-678 # ffffffffc02080d8 <etext+0x1a6>
ffffffffc0200386:	00008597          	auipc	a1,0x8
ffffffffc020038a:	d7a58593          	addi	a1,a1,-646 # ffffffffc0208100 <etext+0x1ce>
ffffffffc020038e:	00008517          	auipc	a0,0x8
ffffffffc0200392:	d3a50513          	addi	a0,a0,-710 # ffffffffc02080c8 <etext+0x196>
ffffffffc0200396:	d37ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020039a:	00008617          	auipc	a2,0x8
ffffffffc020039e:	d7660613          	addi	a2,a2,-650 # ffffffffc0208110 <etext+0x1de>
ffffffffc02003a2:	00008597          	auipc	a1,0x8
ffffffffc02003a6:	d8e58593          	addi	a1,a1,-626 # ffffffffc0208130 <etext+0x1fe>
ffffffffc02003aa:	00008517          	auipc	a0,0x8
ffffffffc02003ae:	d1e50513          	addi	a0,a0,-738 # ffffffffc02080c8 <etext+0x196>
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
ffffffffc02003e8:	d5c50513          	addi	a0,a0,-676 # ffffffffc0208140 <etext+0x20e>
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
ffffffffc020040a:	d6250513          	addi	a0,a0,-670 # ffffffffc0208168 <etext+0x236>
ffffffffc020040e:	cbfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200412:	000c0563          	beqz	s8,ffffffffc020041c <kmonitor+0x3e>
ffffffffc0200416:	8562                	mv	a0,s8
ffffffffc0200418:	40e000ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc020041c:	00008c97          	auipc	s9,0x8
ffffffffc0200420:	dbcc8c93          	addi	s9,s9,-580 # ffffffffc02081d8 <commands>
ffffffffc0200424:	00008997          	auipc	s3,0x8
ffffffffc0200428:	d6c98993          	addi	s3,s3,-660 # ffffffffc0208190 <etext+0x25e>
ffffffffc020042c:	00008917          	auipc	s2,0x8
ffffffffc0200430:	d6c90913          	addi	s2,s2,-660 # ffffffffc0208198 <etext+0x266>
ffffffffc0200434:	4a3d                	li	s4,15
ffffffffc0200436:	00008b17          	auipc	s6,0x8
ffffffffc020043a:	d6ab0b13          	addi	s6,s6,-662 # ffffffffc02081a0 <etext+0x26e>
ffffffffc020043e:	00008a97          	auipc	s5,0x8
ffffffffc0200442:	c82a8a93          	addi	s5,s5,-894 # ffffffffc02080c0 <etext+0x18e>
ffffffffc0200446:	4b8d                	li	s7,3
ffffffffc0200448:	854e                	mv	a0,s3
ffffffffc020044a:	d0bff0ef          	jal	ra,ffffffffc0200154 <readline>
ffffffffc020044e:	842a                	mv	s0,a0
ffffffffc0200450:	dd65                	beqz	a0,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200452:	00054583          	lbu	a1,0(a0)
ffffffffc0200456:	4481                	li	s1,0
ffffffffc0200458:	c999                	beqz	a1,ffffffffc020046e <kmonitor+0x90>
ffffffffc020045a:	854a                	mv	a0,s2
ffffffffc020045c:	692070ef          	jal	ra,ffffffffc0207aee <strchr>
ffffffffc0200460:	c925                	beqz	a0,ffffffffc02004d0 <kmonitor+0xf2>
ffffffffc0200462:	00144583          	lbu	a1,1(s0)
ffffffffc0200466:	00040023          	sb	zero,0(s0)
ffffffffc020046a:	0405                	addi	s0,s0,1
ffffffffc020046c:	f5fd                	bnez	a1,ffffffffc020045a <kmonitor+0x7c>
ffffffffc020046e:	dce9                	beqz	s1,ffffffffc0200448 <kmonitor+0x6a>
ffffffffc0200470:	6582                	ld	a1,0(sp)
ffffffffc0200472:	00008d17          	auipc	s10,0x8
ffffffffc0200476:	d66d0d13          	addi	s10,s10,-666 # ffffffffc02081d8 <commands>
ffffffffc020047a:	8556                	mv	a0,s5
ffffffffc020047c:	4401                	li	s0,0
ffffffffc020047e:	0d61                	addi	s10,s10,24
ffffffffc0200480:	650070ef          	jal	ra,ffffffffc0207ad0 <strcmp>
ffffffffc0200484:	c919                	beqz	a0,ffffffffc020049a <kmonitor+0xbc>
ffffffffc0200486:	2405                	addiw	s0,s0,1
ffffffffc0200488:	09740463          	beq	s0,s7,ffffffffc0200510 <kmonitor+0x132>
ffffffffc020048c:	000d3503          	ld	a0,0(s10)
ffffffffc0200490:	6582                	ld	a1,0(sp)
ffffffffc0200492:	0d61                	addi	s10,s10,24
ffffffffc0200494:	63c070ef          	jal	ra,ffffffffc0207ad0 <strcmp>
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
ffffffffc02004fa:	5f4070ef          	jal	ra,ffffffffc0207aee <strchr>
ffffffffc02004fe:	d96d                	beqz	a0,ffffffffc02004f0 <kmonitor+0x112>
ffffffffc0200500:	00044583          	lbu	a1,0(s0)
ffffffffc0200504:	bf91                	j	ffffffffc0200458 <kmonitor+0x7a>
ffffffffc0200506:	45c1                	li	a1,16
ffffffffc0200508:	855a                	mv	a0,s6
ffffffffc020050a:	bc3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020050e:	b7f1                	j	ffffffffc02004da <kmonitor+0xfc>
ffffffffc0200510:	6582                	ld	a1,0(sp)
ffffffffc0200512:	00008517          	auipc	a0,0x8
ffffffffc0200516:	cae50513          	addi	a0,a0,-850 # ffffffffc02081c0 <etext+0x28e>
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
ffffffffc0200532:	f6278793          	addi	a5,a5,-158 # ffffffffc020e490 <ide>
ffffffffc0200536:	0095959b          	slliw	a1,a1,0x9
ffffffffc020053a:	1141                	addi	sp,sp,-16
ffffffffc020053c:	8532                	mv	a0,a2
ffffffffc020053e:	95be                	add	a1,a1,a5
ffffffffc0200540:	00969613          	slli	a2,a3,0x9
ffffffffc0200544:	e406                	sd	ra,8(sp)
ffffffffc0200546:	5d0070ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc020054a:	60a2                	ld	ra,8(sp)
ffffffffc020054c:	4501                	li	a0,0
ffffffffc020054e:	0141                	addi	sp,sp,16
ffffffffc0200550:	8082                	ret

ffffffffc0200552 <ide_write_secs>:
ffffffffc0200552:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200556:	0000e517          	auipc	a0,0xe
ffffffffc020055a:	f3a50513          	addi	a0,a0,-198 # ffffffffc020e490 <ide>
ffffffffc020055e:	1141                	addi	sp,sp,-16
ffffffffc0200560:	85b2                	mv	a1,a2
ffffffffc0200562:	953e                	add	a0,a0,a5
ffffffffc0200564:	00969613          	slli	a2,a3,0x9
ffffffffc0200568:	e406                	sd	ra,8(sp)
ffffffffc020056a:	5ac070ef          	jal	ra,ffffffffc0207b16 <memcpy>
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
ffffffffc0200598:	c8c50513          	addi	a0,a0,-884 # ffffffffc0208220 <commands+0x48>
ffffffffc020059c:	00019797          	auipc	a5,0x19
ffffffffc02005a0:	f807b623          	sd	zero,-116(a5) # ffffffffc0219528 <ticks>
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
ffffffffc0200664:	be050513          	addi	a0,a0,-1056 # ffffffffc0208240 <commands+0x68>
ffffffffc0200668:	e406                	sd	ra,8(sp)
ffffffffc020066a:	a63ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020066e:	640c                	ld	a1,8(s0)
ffffffffc0200670:	00008517          	auipc	a0,0x8
ffffffffc0200674:	be850513          	addi	a0,a0,-1048 # ffffffffc0208258 <commands+0x80>
ffffffffc0200678:	a55ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020067c:	680c                	ld	a1,16(s0)
ffffffffc020067e:	00008517          	auipc	a0,0x8
ffffffffc0200682:	bf250513          	addi	a0,a0,-1038 # ffffffffc0208270 <commands+0x98>
ffffffffc0200686:	a47ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020068a:	6c0c                	ld	a1,24(s0)
ffffffffc020068c:	00008517          	auipc	a0,0x8
ffffffffc0200690:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0208288 <commands+0xb0>
ffffffffc0200694:	a39ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200698:	700c                	ld	a1,32(s0)
ffffffffc020069a:	00008517          	auipc	a0,0x8
ffffffffc020069e:	c0650513          	addi	a0,a0,-1018 # ffffffffc02082a0 <commands+0xc8>
ffffffffc02006a2:	a2bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006a6:	740c                	ld	a1,40(s0)
ffffffffc02006a8:	00008517          	auipc	a0,0x8
ffffffffc02006ac:	c1050513          	addi	a0,a0,-1008 # ffffffffc02082b8 <commands+0xe0>
ffffffffc02006b0:	a1dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006b4:	780c                	ld	a1,48(s0)
ffffffffc02006b6:	00008517          	auipc	a0,0x8
ffffffffc02006ba:	c1a50513          	addi	a0,a0,-998 # ffffffffc02082d0 <commands+0xf8>
ffffffffc02006be:	a0fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006c2:	7c0c                	ld	a1,56(s0)
ffffffffc02006c4:	00008517          	auipc	a0,0x8
ffffffffc02006c8:	c2450513          	addi	a0,a0,-988 # ffffffffc02082e8 <commands+0x110>
ffffffffc02006cc:	a01ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006d0:	602c                	ld	a1,64(s0)
ffffffffc02006d2:	00008517          	auipc	a0,0x8
ffffffffc02006d6:	c2e50513          	addi	a0,a0,-978 # ffffffffc0208300 <commands+0x128>
ffffffffc02006da:	9f3ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006de:	642c                	ld	a1,72(s0)
ffffffffc02006e0:	00008517          	auipc	a0,0x8
ffffffffc02006e4:	c3850513          	addi	a0,a0,-968 # ffffffffc0208318 <commands+0x140>
ffffffffc02006e8:	9e5ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006ec:	682c                	ld	a1,80(s0)
ffffffffc02006ee:	00008517          	auipc	a0,0x8
ffffffffc02006f2:	c4250513          	addi	a0,a0,-958 # ffffffffc0208330 <commands+0x158>
ffffffffc02006f6:	9d7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02006fa:	6c2c                	ld	a1,88(s0)
ffffffffc02006fc:	00008517          	auipc	a0,0x8
ffffffffc0200700:	c4c50513          	addi	a0,a0,-948 # ffffffffc0208348 <commands+0x170>
ffffffffc0200704:	9c9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200708:	702c                	ld	a1,96(s0)
ffffffffc020070a:	00008517          	auipc	a0,0x8
ffffffffc020070e:	c5650513          	addi	a0,a0,-938 # ffffffffc0208360 <commands+0x188>
ffffffffc0200712:	9bbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200716:	742c                	ld	a1,104(s0)
ffffffffc0200718:	00008517          	auipc	a0,0x8
ffffffffc020071c:	c6050513          	addi	a0,a0,-928 # ffffffffc0208378 <commands+0x1a0>
ffffffffc0200720:	9adff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200724:	782c                	ld	a1,112(s0)
ffffffffc0200726:	00008517          	auipc	a0,0x8
ffffffffc020072a:	c6a50513          	addi	a0,a0,-918 # ffffffffc0208390 <commands+0x1b8>
ffffffffc020072e:	99fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200732:	7c2c                	ld	a1,120(s0)
ffffffffc0200734:	00008517          	auipc	a0,0x8
ffffffffc0200738:	c7450513          	addi	a0,a0,-908 # ffffffffc02083a8 <commands+0x1d0>
ffffffffc020073c:	991ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200740:	604c                	ld	a1,128(s0)
ffffffffc0200742:	00008517          	auipc	a0,0x8
ffffffffc0200746:	c7e50513          	addi	a0,a0,-898 # ffffffffc02083c0 <commands+0x1e8>
ffffffffc020074a:	983ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020074e:	644c                	ld	a1,136(s0)
ffffffffc0200750:	00008517          	auipc	a0,0x8
ffffffffc0200754:	c8850513          	addi	a0,a0,-888 # ffffffffc02083d8 <commands+0x200>
ffffffffc0200758:	975ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020075c:	684c                	ld	a1,144(s0)
ffffffffc020075e:	00008517          	auipc	a0,0x8
ffffffffc0200762:	c9250513          	addi	a0,a0,-878 # ffffffffc02083f0 <commands+0x218>
ffffffffc0200766:	967ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020076a:	6c4c                	ld	a1,152(s0)
ffffffffc020076c:	00008517          	auipc	a0,0x8
ffffffffc0200770:	c9c50513          	addi	a0,a0,-868 # ffffffffc0208408 <commands+0x230>
ffffffffc0200774:	959ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200778:	704c                	ld	a1,160(s0)
ffffffffc020077a:	00008517          	auipc	a0,0x8
ffffffffc020077e:	ca650513          	addi	a0,a0,-858 # ffffffffc0208420 <commands+0x248>
ffffffffc0200782:	94bff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200786:	744c                	ld	a1,168(s0)
ffffffffc0200788:	00008517          	auipc	a0,0x8
ffffffffc020078c:	cb050513          	addi	a0,a0,-848 # ffffffffc0208438 <commands+0x260>
ffffffffc0200790:	93dff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200794:	784c                	ld	a1,176(s0)
ffffffffc0200796:	00008517          	auipc	a0,0x8
ffffffffc020079a:	cba50513          	addi	a0,a0,-838 # ffffffffc0208450 <commands+0x278>
ffffffffc020079e:	92fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007a2:	7c4c                	ld	a1,184(s0)
ffffffffc02007a4:	00008517          	auipc	a0,0x8
ffffffffc02007a8:	cc450513          	addi	a0,a0,-828 # ffffffffc0208468 <commands+0x290>
ffffffffc02007ac:	921ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007b0:	606c                	ld	a1,192(s0)
ffffffffc02007b2:	00008517          	auipc	a0,0x8
ffffffffc02007b6:	cce50513          	addi	a0,a0,-818 # ffffffffc0208480 <commands+0x2a8>
ffffffffc02007ba:	913ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007be:	646c                	ld	a1,200(s0)
ffffffffc02007c0:	00008517          	auipc	a0,0x8
ffffffffc02007c4:	cd850513          	addi	a0,a0,-808 # ffffffffc0208498 <commands+0x2c0>
ffffffffc02007c8:	905ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007cc:	686c                	ld	a1,208(s0)
ffffffffc02007ce:	00008517          	auipc	a0,0x8
ffffffffc02007d2:	ce250513          	addi	a0,a0,-798 # ffffffffc02084b0 <commands+0x2d8>
ffffffffc02007d6:	8f7ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007da:	6c6c                	ld	a1,216(s0)
ffffffffc02007dc:	00008517          	auipc	a0,0x8
ffffffffc02007e0:	cec50513          	addi	a0,a0,-788 # ffffffffc02084c8 <commands+0x2f0>
ffffffffc02007e4:	8e9ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007e8:	706c                	ld	a1,224(s0)
ffffffffc02007ea:	00008517          	auipc	a0,0x8
ffffffffc02007ee:	cf650513          	addi	a0,a0,-778 # ffffffffc02084e0 <commands+0x308>
ffffffffc02007f2:	8dbff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02007f6:	746c                	ld	a1,232(s0)
ffffffffc02007f8:	00008517          	auipc	a0,0x8
ffffffffc02007fc:	d0050513          	addi	a0,a0,-768 # ffffffffc02084f8 <commands+0x320>
ffffffffc0200800:	8cdff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200804:	786c                	ld	a1,240(s0)
ffffffffc0200806:	00008517          	auipc	a0,0x8
ffffffffc020080a:	d0a50513          	addi	a0,a0,-758 # ffffffffc0208510 <commands+0x338>
ffffffffc020080e:	8bfff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200812:	7c6c                	ld	a1,248(s0)
ffffffffc0200814:	6402                	ld	s0,0(sp)
ffffffffc0200816:	60a2                	ld	ra,8(sp)
ffffffffc0200818:	00008517          	auipc	a0,0x8
ffffffffc020081c:	d1050513          	addi	a0,a0,-752 # ffffffffc0208528 <commands+0x350>
ffffffffc0200820:	0141                	addi	sp,sp,16
ffffffffc0200822:	8abff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200826 <print_trapframe>:
ffffffffc0200826:	1141                	addi	sp,sp,-16
ffffffffc0200828:	e022                	sd	s0,0(sp)
ffffffffc020082a:	85aa                	mv	a1,a0
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	00008517          	auipc	a0,0x8
ffffffffc0200832:	d1250513          	addi	a0,a0,-750 # ffffffffc0208540 <commands+0x368>
ffffffffc0200836:	e406                	sd	ra,8(sp)
ffffffffc0200838:	895ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020083c:	8522                	mv	a0,s0
ffffffffc020083e:	e1bff0ef          	jal	ra,ffffffffc0200658 <print_regs>
ffffffffc0200842:	10043583          	ld	a1,256(s0)
ffffffffc0200846:	00008517          	auipc	a0,0x8
ffffffffc020084a:	d1250513          	addi	a0,a0,-750 # ffffffffc0208558 <commands+0x380>
ffffffffc020084e:	87fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200852:	10843583          	ld	a1,264(s0)
ffffffffc0200856:	00008517          	auipc	a0,0x8
ffffffffc020085a:	d1a50513          	addi	a0,a0,-742 # ffffffffc0208570 <commands+0x398>
ffffffffc020085e:	86fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200862:	11043583          	ld	a1,272(s0)
ffffffffc0200866:	00008517          	auipc	a0,0x8
ffffffffc020086a:	d2250513          	addi	a0,a0,-734 # ffffffffc0208588 <commands+0x3b0>
ffffffffc020086e:	85fff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200872:	11843583          	ld	a1,280(s0)
ffffffffc0200876:	6402                	ld	s0,0(sp)
ffffffffc0200878:	60a2                	ld	ra,8(sp)
ffffffffc020087a:	00008517          	auipc	a0,0x8
ffffffffc020087e:	d1e50513          	addi	a0,a0,-738 # ffffffffc0208598 <commands+0x3c0>
ffffffffc0200882:	0141                	addi	sp,sp,16
ffffffffc0200884:	849ff06f          	j	ffffffffc02000cc <cprintf>

ffffffffc0200888 <pgfault_handler>:
ffffffffc0200888:	1101                	addi	sp,sp,-32
ffffffffc020088a:	e426                	sd	s1,8(sp)
ffffffffc020088c:	00019497          	auipc	s1,0x19
ffffffffc0200890:	cd448493          	addi	s1,s1,-812 # ffffffffc0219560 <check_mm_struct>
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
ffffffffc02008c6:	cee50513          	addi	a0,a0,-786 # ffffffffc02085b0 <commands+0x3d8>
ffffffffc02008ca:	803ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02008ce:	6088                	ld	a0,0(s1)
ffffffffc02008d0:	cd1d                	beqz	a0,ffffffffc020090e <pgfault_handler+0x86>
ffffffffc02008d2:	00019717          	auipc	a4,0x19
ffffffffc02008d6:	c2673703          	ld	a4,-986(a4) # ffffffffc02194f8 <current>
ffffffffc02008da:	00019797          	auipc	a5,0x19
ffffffffc02008de:	c267b783          	ld	a5,-986(a5) # ffffffffc0219500 <idleproc>
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
ffffffffc0200912:	bea7b783          	ld	a5,-1046(a5) # ffffffffc02194f8 <current>
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
ffffffffc0200932:	ca268693          	addi	a3,a3,-862 # ffffffffc02085d0 <commands+0x3f8>
ffffffffc0200936:	00008617          	auipc	a2,0x8
ffffffffc020093a:	cb260613          	addi	a2,a2,-846 # ffffffffc02085e8 <commands+0x410>
ffffffffc020093e:	06c00593          	li	a1,108
ffffffffc0200942:	00008517          	auipc	a0,0x8
ffffffffc0200946:	cbe50513          	addi	a0,a0,-834 # ffffffffc0208600 <commands+0x428>
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
ffffffffc020097c:	c3850513          	addi	a0,a0,-968 # ffffffffc02085b0 <commands+0x3d8>
ffffffffc0200980:	f4cff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200984:	00008617          	auipc	a2,0x8
ffffffffc0200988:	c9460613          	addi	a2,a2,-876 # ffffffffc0208618 <commands+0x440>
ffffffffc020098c:	07300593          	li	a1,115
ffffffffc0200990:	00008517          	auipc	a0,0x8
ffffffffc0200994:	c7050513          	addi	a0,a0,-912 # ffffffffc0208600 <commands+0x428>
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
ffffffffc02009b4:	d2070713          	addi	a4,a4,-736 # ffffffffc02086d0 <commands+0x4f8>
ffffffffc02009b8:	078a                	slli	a5,a5,0x2
ffffffffc02009ba:	97ba                	add	a5,a5,a4
ffffffffc02009bc:	439c                	lw	a5,0(a5)
ffffffffc02009be:	97ba                	add	a5,a5,a4
ffffffffc02009c0:	8782                	jr	a5
ffffffffc02009c2:	00008517          	auipc	a0,0x8
ffffffffc02009c6:	cce50513          	addi	a0,a0,-818 # ffffffffc0208690 <commands+0x4b8>
ffffffffc02009ca:	f02ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009ce:	00008517          	auipc	a0,0x8
ffffffffc02009d2:	ca250513          	addi	a0,a0,-862 # ffffffffc0208670 <commands+0x498>
ffffffffc02009d6:	ef6ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009da:	00008517          	auipc	a0,0x8
ffffffffc02009de:	c5650513          	addi	a0,a0,-938 # ffffffffc0208630 <commands+0x458>
ffffffffc02009e2:	eeaff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009e6:	00008517          	auipc	a0,0x8
ffffffffc02009ea:	c6a50513          	addi	a0,a0,-918 # ffffffffc0208650 <commands+0x478>
ffffffffc02009ee:	edeff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc02009f2:	1141                	addi	sp,sp,-16
ffffffffc02009f4:	e406                	sd	ra,8(sp)
ffffffffc02009f6:	bb1ff0ef          	jal	ra,ffffffffc02005a6 <clock_set_next_event>
ffffffffc02009fa:	00019717          	auipc	a4,0x19
ffffffffc02009fe:	b2e70713          	addi	a4,a4,-1234 # ffffffffc0219528 <ticks>
ffffffffc0200a02:	631c                	ld	a5,0(a4)
ffffffffc0200a04:	60a2                	ld	ra,8(sp)
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
ffffffffc0200a0a:	0141                	addi	sp,sp,16
ffffffffc0200a0c:	2840406f          	j	ffffffffc0204c90 <run_timer_list>
ffffffffc0200a10:	00008517          	auipc	a0,0x8
ffffffffc0200a14:	ca050513          	addi	a0,a0,-864 # ffffffffc02086b0 <commands+0x4d8>
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
ffffffffc0200a36:	e6670713          	addi	a4,a4,-410 # ffffffffc0208898 <commands+0x6c0>
ffffffffc0200a3a:	078a                	slli	a5,a5,0x2
ffffffffc0200a3c:	97ba                	add	a5,a5,a4
ffffffffc0200a3e:	439c                	lw	a5,0(a5)
ffffffffc0200a40:	97ba                	add	a5,a5,a4
ffffffffc0200a42:	8782                	jr	a5
ffffffffc0200a44:	00008517          	auipc	a0,0x8
ffffffffc0200a48:	dac50513          	addi	a0,a0,-596 # ffffffffc02087f0 <commands+0x618>
ffffffffc0200a4c:	e80ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200a50:	10843783          	ld	a5,264(s0)
ffffffffc0200a54:	60e2                	ld	ra,24(sp)
ffffffffc0200a56:	64a2                	ld	s1,8(sp)
ffffffffc0200a58:	0791                	addi	a5,a5,4
ffffffffc0200a5a:	10f43423          	sd	a5,264(s0)
ffffffffc0200a5e:	6442                	ld	s0,16(sp)
ffffffffc0200a60:	6105                	addi	sp,sp,32
ffffffffc0200a62:	7d10606f          	j	ffffffffc0207a32 <syscall>
ffffffffc0200a66:	00008517          	auipc	a0,0x8
ffffffffc0200a6a:	daa50513          	addi	a0,a0,-598 # ffffffffc0208810 <commands+0x638>
ffffffffc0200a6e:	6442                	ld	s0,16(sp)
ffffffffc0200a70:	60e2                	ld	ra,24(sp)
ffffffffc0200a72:	64a2                	ld	s1,8(sp)
ffffffffc0200a74:	6105                	addi	sp,sp,32
ffffffffc0200a76:	e56ff06f          	j	ffffffffc02000cc <cprintf>
ffffffffc0200a7a:	00008517          	auipc	a0,0x8
ffffffffc0200a7e:	db650513          	addi	a0,a0,-586 # ffffffffc0208830 <commands+0x658>
ffffffffc0200a82:	b7f5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a84:	00008517          	auipc	a0,0x8
ffffffffc0200a88:	dcc50513          	addi	a0,a0,-564 # ffffffffc0208850 <commands+0x678>
ffffffffc0200a8c:	b7cd                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200a8e:	00008517          	auipc	a0,0x8
ffffffffc0200a92:	dda50513          	addi	a0,a0,-550 # ffffffffc0208868 <commands+0x690>
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
ffffffffc0200ab4:	dd050513          	addi	a0,a0,-560 # ffffffffc0208880 <commands+0x6a8>
ffffffffc0200ab8:	e14ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200abc:	8522                	mv	a0,s0
ffffffffc0200abe:	dcbff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200ac2:	84aa                	mv	s1,a0
ffffffffc0200ac4:	d16d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	d5fff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200acc:	86a6                	mv	a3,s1
ffffffffc0200ace:	00008617          	auipc	a2,0x8
ffffffffc0200ad2:	cd260613          	addi	a2,a2,-814 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200ad6:	0f600593          	li	a1,246
ffffffffc0200ada:	00008517          	auipc	a0,0x8
ffffffffc0200ade:	b2650513          	addi	a0,a0,-1242 # ffffffffc0208600 <commands+0x428>
ffffffffc0200ae2:	f26ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200ae6:	00008517          	auipc	a0,0x8
ffffffffc0200aea:	c1a50513          	addi	a0,a0,-998 # ffffffffc0208700 <commands+0x528>
ffffffffc0200aee:	b741                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200af0:	00008517          	auipc	a0,0x8
ffffffffc0200af4:	c3050513          	addi	a0,a0,-976 # ffffffffc0208720 <commands+0x548>
ffffffffc0200af8:	bf9d                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200afa:	00008517          	auipc	a0,0x8
ffffffffc0200afe:	c4650513          	addi	a0,a0,-954 # ffffffffc0208740 <commands+0x568>
ffffffffc0200b02:	b7b5                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b04:	00008517          	auipc	a0,0x8
ffffffffc0200b08:	c5450513          	addi	a0,a0,-940 # ffffffffc0208758 <commands+0x580>
ffffffffc0200b0c:	dc0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b10:	6458                	ld	a4,136(s0)
ffffffffc0200b12:	47a9                	li	a5,10
ffffffffc0200b14:	f8f719e3          	bne	a4,a5,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b18:	bf25                	j	ffffffffc0200a50 <exception_handler+0x32>
ffffffffc0200b1a:	00008517          	auipc	a0,0x8
ffffffffc0200b1e:	c4e50513          	addi	a0,a0,-946 # ffffffffc0208768 <commands+0x590>
ffffffffc0200b22:	b7b1                	j	ffffffffc0200a6e <exception_handler+0x50>
ffffffffc0200b24:	00008517          	auipc	a0,0x8
ffffffffc0200b28:	c6450513          	addi	a0,a0,-924 # ffffffffc0208788 <commands+0x5b0>
ffffffffc0200b2c:	da0ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b30:	8522                	mv	a0,s0
ffffffffc0200b32:	d57ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b36:	84aa                	mv	s1,a0
ffffffffc0200b38:	d53d                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	cebff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b40:	86a6                	mv	a3,s1
ffffffffc0200b42:	00008617          	auipc	a2,0x8
ffffffffc0200b46:	c5e60613          	addi	a2,a2,-930 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200b4a:	0cb00593          	li	a1,203
ffffffffc0200b4e:	00008517          	auipc	a0,0x8
ffffffffc0200b52:	ab250513          	addi	a0,a0,-1358 # ffffffffc0208600 <commands+0x428>
ffffffffc0200b56:	eb2ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b5a:	00008517          	auipc	a0,0x8
ffffffffc0200b5e:	c7e50513          	addi	a0,a0,-898 # ffffffffc02087d8 <commands+0x600>
ffffffffc0200b62:	d6aff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200b66:	8522                	mv	a0,s0
ffffffffc0200b68:	d21ff0ef          	jal	ra,ffffffffc0200888 <pgfault_handler>
ffffffffc0200b6c:	84aa                	mv	s1,a0
ffffffffc0200b6e:	dd05                	beqz	a0,ffffffffc0200aa6 <exception_handler+0x88>
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	cb5ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200b76:	86a6                	mv	a3,s1
ffffffffc0200b78:	00008617          	auipc	a2,0x8
ffffffffc0200b7c:	c2860613          	addi	a2,a2,-984 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200b80:	0d500593          	li	a1,213
ffffffffc0200b84:	00008517          	auipc	a0,0x8
ffffffffc0200b88:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0208600 <commands+0x428>
ffffffffc0200b8c:	e7cff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200b90:	8522                	mv	a0,s0
ffffffffc0200b92:	6442                	ld	s0,16(sp)
ffffffffc0200b94:	60e2                	ld	ra,24(sp)
ffffffffc0200b96:	64a2                	ld	s1,8(sp)
ffffffffc0200b98:	6105                	addi	sp,sp,32
ffffffffc0200b9a:	b171                	j	ffffffffc0200826 <print_trapframe>
ffffffffc0200b9c:	00008617          	auipc	a2,0x8
ffffffffc0200ba0:	c2460613          	addi	a2,a2,-988 # ffffffffc02087c0 <commands+0x5e8>
ffffffffc0200ba4:	0cf00593          	li	a1,207
ffffffffc0200ba8:	00008517          	auipc	a0,0x8
ffffffffc0200bac:	a5850513          	addi	a0,a0,-1448 # ffffffffc0208600 <commands+0x428>
ffffffffc0200bb0:	e58ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	c71ff0ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0200bba:	86a6                	mv	a3,s1
ffffffffc0200bbc:	00008617          	auipc	a2,0x8
ffffffffc0200bc0:	be460613          	addi	a2,a2,-1052 # ffffffffc02087a0 <commands+0x5c8>
ffffffffc0200bc4:	0ef00593          	li	a1,239
ffffffffc0200bc8:	00008517          	auipc	a0,0x8
ffffffffc0200bcc:	a3850513          	addi	a0,a0,-1480 # ffffffffc0208600 <commands+0x428>
ffffffffc0200bd0:	e38ff0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0200bd4 <trap>:
ffffffffc0200bd4:	1101                	addi	sp,sp,-32
ffffffffc0200bd6:	e822                	sd	s0,16(sp)
ffffffffc0200bd8:	00019417          	auipc	s0,0x19
ffffffffc0200bdc:	92040413          	addi	s0,s0,-1760 # ffffffffc02194f8 <current>
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
ffffffffc0200c50:	62f0306f          	j	ffffffffc0204a7e <schedule>
ffffffffc0200c54:	555d                	li	a0,-9
ffffffffc0200c56:	0ae030ef          	jal	ra,ffffffffc0203d04 <do_exit>
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
ffffffffc0200d34:	ba860613          	addi	a2,a2,-1112 # ffffffffc02088d8 <commands+0x700>
ffffffffc0200d38:	06200593          	li	a1,98
ffffffffc0200d3c:	00008517          	auipc	a0,0x8
ffffffffc0200d40:	bbc50513          	addi	a0,a0,-1092 # ffffffffc02088f8 <commands+0x720>
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
ffffffffc0200d62:	7d290913          	addi	s2,s2,2002 # ffffffffc0219530 <pmm_manager>
ffffffffc0200d66:	4a05                	li	s4,1
ffffffffc0200d68:	00018a97          	auipc	s5,0x18
ffffffffc0200d6c:	788a8a93          	addi	s5,s5,1928 # ffffffffc02194f0 <swap_init_ok>
ffffffffc0200d70:	0005099b          	sext.w	s3,a0
ffffffffc0200d74:	00018b17          	auipc	s6,0x18
ffffffffc0200d78:	7ecb0b13          	addi	s6,s6,2028 # ffffffffc0219560 <check_mm_struct>
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
ffffffffc0200de8:	74c7b783          	ld	a5,1868(a5) # ffffffffc0219530 <pmm_manager>
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
ffffffffc0200e06:	72e7b783          	ld	a5,1838(a5) # ffffffffc0219530 <pmm_manager>
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
ffffffffc0200e2a:	70a7b783          	ld	a5,1802(a5) # ffffffffc0219530 <pmm_manager>
ffffffffc0200e2e:	0287b303          	ld	t1,40(a5)
ffffffffc0200e32:	8302                	jr	t1
ffffffffc0200e34:	1141                	addi	sp,sp,-16
ffffffffc0200e36:	e406                	sd	ra,8(sp)
ffffffffc0200e38:	e022                	sd	s0,0(sp)
ffffffffc0200e3a:	ffeff0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0200e3e:	00018797          	auipc	a5,0x18
ffffffffc0200e42:	6f27b783          	ld	a5,1778(a5) # ffffffffc0219530 <pmm_manager>
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
ffffffffc0200e5e:	4ce78793          	addi	a5,a5,1230 # ffffffffc0209328 <default_pmm_manager>
ffffffffc0200e62:	638c                	ld	a1,0(a5)
ffffffffc0200e64:	1101                	addi	sp,sp,-32
ffffffffc0200e66:	e426                	sd	s1,8(sp)
ffffffffc0200e68:	00008517          	auipc	a0,0x8
ffffffffc0200e6c:	aa050513          	addi	a0,a0,-1376 # ffffffffc0208908 <commands+0x730>
ffffffffc0200e70:	00018497          	auipc	s1,0x18
ffffffffc0200e74:	6c048493          	addi	s1,s1,1728 # ffffffffc0219530 <pmm_manager>
ffffffffc0200e78:	ec06                	sd	ra,24(sp)
ffffffffc0200e7a:	e822                	sd	s0,16(sp)
ffffffffc0200e7c:	e09c                	sd	a5,0(s1)
ffffffffc0200e7e:	a4eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200e82:	609c                	ld	a5,0(s1)
ffffffffc0200e84:	00018417          	auipc	s0,0x18
ffffffffc0200e88:	6b440413          	addi	s0,s0,1716 # ffffffffc0219538 <va_pa_offset>
ffffffffc0200e8c:	679c                	ld	a5,8(a5)
ffffffffc0200e8e:	9782                	jalr	a5
ffffffffc0200e90:	57f5                	li	a5,-3
ffffffffc0200e92:	07fa                	slli	a5,a5,0x1e
ffffffffc0200e94:	00008517          	auipc	a0,0x8
ffffffffc0200e98:	a8c50513          	addi	a0,a0,-1396 # ffffffffc0208920 <commands+0x748>
ffffffffc0200e9c:	e01c                	sd	a5,0(s0)
ffffffffc0200e9e:	a2eff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ea2:	44300693          	li	a3,1091
ffffffffc0200ea6:	06d6                	slli	a3,a3,0x15
ffffffffc0200ea8:	40100613          	li	a2,1025
ffffffffc0200eac:	0656                	slli	a2,a2,0x15
ffffffffc0200eae:	088005b7          	lui	a1,0x8800
ffffffffc0200eb2:	16fd                	addi	a3,a3,-1
ffffffffc0200eb4:	00008517          	auipc	a0,0x8
ffffffffc0200eb8:	a8450513          	addi	a0,a0,-1404 # ffffffffc0208938 <commands+0x760>
ffffffffc0200ebc:	a10ff0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0200ec0:	777d                	lui	a4,0xfffff
ffffffffc0200ec2:	0001a797          	auipc	a5,0x1a
ffffffffc0200ec6:	88578793          	addi	a5,a5,-1915 # ffffffffc021a747 <end+0xfff>
ffffffffc0200eca:	8ff9                	and	a5,a5,a4
ffffffffc0200ecc:	00088737          	lui	a4,0x88
ffffffffc0200ed0:	60070713          	addi	a4,a4,1536 # 88600 <kern_entry-0xffffffffc0177a00>
ffffffffc0200ed4:	00018597          	auipc	a1,0x18
ffffffffc0200ed8:	5fc58593          	addi	a1,a1,1532 # ffffffffc02194d0 <npage>
ffffffffc0200edc:	00018617          	auipc	a2,0x18
ffffffffc0200ee0:	66c60613          	addi	a2,a2,1644 # ffffffffc0219548 <pages>
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
ffffffffc0200f58:	56d7ba23          	sd	a3,1396(a5) # ffffffffc02194c8 <boot_pgdir>
ffffffffc0200f5c:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f60:	02f6e963          	bltu	a3,a5,ffffffffc0200f92 <pmm_init+0x138>
ffffffffc0200f64:	601c                	ld	a5,0(s0)
ffffffffc0200f66:	60e2                	ld	ra,24(sp)
ffffffffc0200f68:	6442                	ld	s0,16(sp)
ffffffffc0200f6a:	8e9d                	sub	a3,a3,a5
ffffffffc0200f6c:	00018797          	auipc	a5,0x18
ffffffffc0200f70:	5cd7ba23          	sd	a3,1492(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0200f74:	64a2                	ld	s1,8(sp)
ffffffffc0200f76:	6105                	addi	sp,sp,32
ffffffffc0200f78:	8082                	ret
ffffffffc0200f7a:	00008617          	auipc	a2,0x8
ffffffffc0200f7e:	9e660613          	addi	a2,a2,-1562 # ffffffffc0208960 <commands+0x788>
ffffffffc0200f82:	07f00593          	li	a1,127
ffffffffc0200f86:	00008517          	auipc	a0,0x8
ffffffffc0200f8a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0200f8e:	a7aff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0200f92:	00008617          	auipc	a2,0x8
ffffffffc0200f96:	9ce60613          	addi	a2,a2,-1586 # ffffffffc0208960 <commands+0x788>
ffffffffc0200f9a:	0c100593          	li	a1,193
ffffffffc0200f9e:	00008517          	auipc	a0,0x8
ffffffffc0200fa2:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc0200fdc:	4f8a0a13          	addi	s4,s4,1272 # ffffffffc02194d0 <npage>
ffffffffc0200fe0:	e7b5                	bnez	a5,ffffffffc020104c <get_pte+0x9e>
ffffffffc0200fe2:	12060b63          	beqz	a2,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200fe6:	4505                	li	a0,1
ffffffffc0200fe8:	d63ff0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0200fec:	842a                	mv	s0,a0
ffffffffc0200fee:	12050563          	beqz	a0,ffffffffc0201118 <get_pte+0x16a>
ffffffffc0200ff2:	00018b17          	auipc	s6,0x18
ffffffffc0200ff6:	556b0b13          	addi	s6,s6,1366 # ffffffffc0219548 <pages>
ffffffffc0200ffa:	000b3503          	ld	a0,0(s6)
ffffffffc0200ffe:	00080ab7          	lui	s5,0x80
ffffffffc0201002:	00018a17          	auipc	s4,0x18
ffffffffc0201006:	4cea0a13          	addi	s4,s4,1230 # ffffffffc02194d0 <npage>
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
ffffffffc020102a:	5127b783          	ld	a5,1298(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc020102e:	6605                	lui	a2,0x1
ffffffffc0201030:	4581                	li	a1,0
ffffffffc0201032:	953e                	add	a0,a0,a5
ffffffffc0201034:	2d1060ef          	jal	ra,ffffffffc0207b04 <memset>
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
ffffffffc0201062:	4daa8a93          	addi	s5,s5,1242 # ffffffffc0219538 <va_pa_offset>
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
ffffffffc0201094:	4b8b0b13          	addi	s6,s6,1208 # ffffffffc0219548 <pages>
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
ffffffffc02010c6:	23f060ef          	jal	ra,ffffffffc0207b04 <memset>
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
ffffffffc0201120:	87c60613          	addi	a2,a2,-1924 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201124:	0fe00593          	li	a1,254
ffffffffc0201128:	00008517          	auipc	a0,0x8
ffffffffc020112c:	86050513          	addi	a0,a0,-1952 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201130:	8d8ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201134:	00008617          	auipc	a2,0x8
ffffffffc0201138:	86460613          	addi	a2,a2,-1948 # ffffffffc0208998 <commands+0x7c0>
ffffffffc020113c:	10900593          	li	a1,265
ffffffffc0201140:	00008517          	auipc	a0,0x8
ffffffffc0201144:	84850513          	addi	a0,a0,-1976 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201148:	8c0ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020114c:	86aa                	mv	a3,a0
ffffffffc020114e:	00008617          	auipc	a2,0x8
ffffffffc0201152:	84a60613          	addi	a2,a2,-1974 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201156:	10600593          	li	a1,262
ffffffffc020115a:	00008517          	auipc	a0,0x8
ffffffffc020115e:	82e50513          	addi	a0,a0,-2002 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201162:	8a6ff0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201166:	86aa                	mv	a3,a0
ffffffffc0201168:	00008617          	auipc	a2,0x8
ffffffffc020116c:	83060613          	addi	a2,a2,-2000 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0201170:	0fa00593          	li	a1,250
ffffffffc0201174:	00008517          	auipc	a0,0x8
ffffffffc0201178:	81450513          	addi	a0,a0,-2028 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02011c0:	314c8c93          	addi	s9,s9,788 # ffffffffc02194d0 <npage>
ffffffffc02011c4:	00018c17          	auipc	s8,0x18
ffffffffc02011c8:	384c0c13          	addi	s8,s8,900 # ffffffffc0219548 <pages>
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
ffffffffc0201252:	00007697          	auipc	a3,0x7
ffffffffc0201256:	79e68693          	addi	a3,a3,1950 # ffffffffc02089f0 <commands+0x818>
ffffffffc020125a:	00007617          	auipc	a2,0x7
ffffffffc020125e:	38e60613          	addi	a2,a2,910 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201262:	14100593          	li	a1,321
ffffffffc0201266:	00007517          	auipc	a0,0x7
ffffffffc020126a:	72250513          	addi	a0,a0,1826 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020126e:	f9bfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201272:	00007697          	auipc	a3,0x7
ffffffffc0201276:	74e68693          	addi	a3,a3,1870 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc020127a:	00007617          	auipc	a2,0x7
ffffffffc020127e:	36e60613          	addi	a2,a2,878 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201282:	14000593          	li	a1,320
ffffffffc0201286:	00007517          	auipc	a0,0x7
ffffffffc020128a:	70250513          	addi	a0,a0,1794 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02012d4:	200b0b13          	addi	s6,s6,512 # ffffffffc02194d0 <npage>
ffffffffc02012d8:	00018b97          	auipc	s7,0x18
ffffffffc02012dc:	270b8b93          	addi	s7,s7,624 # ffffffffc0219548 <pages>
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
ffffffffc0201340:	59c60613          	addi	a2,a2,1436 # ffffffffc02088d8 <commands+0x700>
ffffffffc0201344:	06200593          	li	a1,98
ffffffffc0201348:	00007517          	auipc	a0,0x7
ffffffffc020134c:	5b050513          	addi	a0,a0,1456 # ffffffffc02088f8 <commands+0x720>
ffffffffc0201350:	eb9fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201354:	00007697          	auipc	a3,0x7
ffffffffc0201358:	69c68693          	addi	a3,a3,1692 # ffffffffc02089f0 <commands+0x818>
ffffffffc020135c:	00007617          	auipc	a2,0x7
ffffffffc0201360:	28c60613          	addi	a2,a2,652 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201364:	15200593          	li	a1,338
ffffffffc0201368:	00007517          	auipc	a0,0x7
ffffffffc020136c:	62050513          	addi	a0,a0,1568 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201370:	e99fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201374:	00007697          	auipc	a3,0x7
ffffffffc0201378:	64c68693          	addi	a3,a3,1612 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc020137c:	00007617          	auipc	a2,0x7
ffffffffc0201380:	26c60613          	addi	a2,a2,620 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201384:	15100593          	li	a1,337
ffffffffc0201388:	00007517          	auipc	a0,0x7
ffffffffc020138c:	60050513          	addi	a0,a0,1536 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02013c8:	18473703          	ld	a4,388(a4) # ffffffffc0219548 <pages>
ffffffffc02013cc:	8c19                	sub	s0,s0,a4
ffffffffc02013ce:	000807b7          	lui	a5,0x80
ffffffffc02013d2:	8419                	srai	s0,s0,0x6
ffffffffc02013d4:	943e                	add	s0,s0,a5
ffffffffc02013d6:	042a                	slli	s0,s0,0xa
ffffffffc02013d8:	8c45                	or	s0,s0,s1
ffffffffc02013da:	00146413          	ori	s0,s0,1
ffffffffc02013de:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd668b8>
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
ffffffffc0201400:	0d473703          	ld	a4,212(a4) # ffffffffc02194d0 <npage>
ffffffffc0201404:	04e7f463          	bgeu	a5,a4,ffffffffc020144c <page_insert+0xb8>
ffffffffc0201408:	00018a17          	auipc	s4,0x18
ffffffffc020140c:	140a0a13          	addi	s4,s4,320 # ffffffffc0219548 <pages>
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
ffffffffc020149a:	03ac8c93          	addi	s9,s9,58 # ffffffffc02194d0 <npage>
ffffffffc020149e:	00018c17          	auipc	s8,0x18
ffffffffc02014a2:	0aac0c13          	addi	s8,s8,170 # ffffffffc0219548 <pages>
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
ffffffffc0201550:	fec70713          	addi	a4,a4,-20 # ffffffffc0219538 <va_pa_offset>
ffffffffc0201554:	6308                	ld	a0,0(a4)
ffffffffc0201556:	8799                	srai	a5,a5,0x6
ffffffffc0201558:	97de                	add	a5,a5,s7
ffffffffc020155a:	0167f733          	and	a4,a5,s6
ffffffffc020155e:	00a685b3          	add	a1,a3,a0
ffffffffc0201562:	07b2                	slli	a5,a5,0xc
ffffffffc0201564:	04c77963          	bgeu	a4,a2,ffffffffc02015b6 <copy_range+0x166>
ffffffffc0201568:	6605                	lui	a2,0x1
ffffffffc020156a:	953e                	add	a0,a0,a5
ffffffffc020156c:	5aa060ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc0201570:	86a6                	mv	a3,s1
ffffffffc0201572:	8622                	mv	a2,s0
ffffffffc0201574:	85ea                	mv	a1,s10
ffffffffc0201576:	8556                	mv	a0,s5
ffffffffc0201578:	e1dff0ef          	jal	ra,ffffffffc0201394 <page_insert>
ffffffffc020157c:	d139                	beqz	a0,ffffffffc02014c2 <copy_range+0x72>
ffffffffc020157e:	00007697          	auipc	a3,0x7
ffffffffc0201582:	4d268693          	addi	a3,a3,1234 # ffffffffc0208a50 <commands+0x878>
ffffffffc0201586:	00007617          	auipc	a2,0x7
ffffffffc020158a:	06260613          	addi	a2,a2,98 # ffffffffc02085e8 <commands+0x410>
ffffffffc020158e:	19900593          	li	a1,409
ffffffffc0201592:	00007517          	auipc	a0,0x7
ffffffffc0201596:	3f650513          	addi	a0,a0,1014 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02015bc:	3e060613          	addi	a2,a2,992 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02015c0:	06900593          	li	a1,105
ffffffffc02015c4:	00007517          	auipc	a0,0x7
ffffffffc02015c8:	33450513          	addi	a0,a0,820 # ffffffffc02088f8 <commands+0x720>
ffffffffc02015cc:	c3dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015d0:	00007697          	auipc	a3,0x7
ffffffffc02015d4:	46068693          	addi	a3,a3,1120 # ffffffffc0208a30 <commands+0x858>
ffffffffc02015d8:	00007617          	auipc	a2,0x7
ffffffffc02015dc:	01060613          	addi	a2,a2,16 # ffffffffc02085e8 <commands+0x410>
ffffffffc02015e0:	17e00593          	li	a1,382
ffffffffc02015e4:	00007517          	auipc	a0,0x7
ffffffffc02015e8:	3a450513          	addi	a0,a0,932 # ffffffffc0208988 <commands+0x7b0>
ffffffffc02015ec:	c1dfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02015f0:	00007697          	auipc	a3,0x7
ffffffffc02015f4:	40068693          	addi	a3,a3,1024 # ffffffffc02089f0 <commands+0x818>
ffffffffc02015f8:	00007617          	auipc	a2,0x7
ffffffffc02015fc:	ff060613          	addi	a2,a2,-16 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201600:	16a00593          	li	a1,362
ffffffffc0201604:	00007517          	auipc	a0,0x7
ffffffffc0201608:	38450513          	addi	a0,a0,900 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020160c:	bfdfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201610:	00007697          	auipc	a3,0x7
ffffffffc0201614:	43068693          	addi	a3,a3,1072 # ffffffffc0208a40 <commands+0x868>
ffffffffc0201618:	00007617          	auipc	a2,0x7
ffffffffc020161c:	fd060613          	addi	a2,a2,-48 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201620:	17f00593          	li	a1,383
ffffffffc0201624:	00007517          	auipc	a0,0x7
ffffffffc0201628:	36450513          	addi	a0,a0,868 # ffffffffc0208988 <commands+0x7b0>
ffffffffc020162c:	bddfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201630:	00007617          	auipc	a2,0x7
ffffffffc0201634:	2a860613          	addi	a2,a2,680 # ffffffffc02088d8 <commands+0x700>
ffffffffc0201638:	06200593          	li	a1,98
ffffffffc020163c:	00007517          	auipc	a0,0x7
ffffffffc0201640:	2bc50513          	addi	a0,a0,700 # ffffffffc02088f8 <commands+0x720>
ffffffffc0201644:	bc5fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201648:	00007617          	auipc	a2,0x7
ffffffffc020164c:	3c060613          	addi	a2,a2,960 # ffffffffc0208a08 <commands+0x830>
ffffffffc0201650:	07400593          	li	a1,116
ffffffffc0201654:	00007517          	auipc	a0,0x7
ffffffffc0201658:	2a450513          	addi	a0,a0,676 # ffffffffc02088f8 <commands+0x720>
ffffffffc020165c:	badfe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201660:	00007697          	auipc	a3,0x7
ffffffffc0201664:	36068693          	addi	a3,a3,864 # ffffffffc02089c0 <commands+0x7e8>
ffffffffc0201668:	00007617          	auipc	a2,0x7
ffffffffc020166c:	f8060613          	addi	a2,a2,-128 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201670:	16900593          	li	a1,361
ffffffffc0201674:	00007517          	auipc	a0,0x7
ffffffffc0201678:	31450513          	addi	a0,a0,788 # ffffffffc0208988 <commands+0x7b0>
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
ffffffffc02016b4:	e407a783          	lw	a5,-448(a5) # ffffffffc02194f0 <swap_init_ok>
ffffffffc02016b8:	c385                	beqz	a5,ffffffffc02016d8 <pgdir_alloc_page+0x52>
ffffffffc02016ba:	00018517          	auipc	a0,0x18
ffffffffc02016be:	ea653503          	ld	a0,-346(a0) # ffffffffc0219560 <check_mm_struct>
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
ffffffffc02016f8:	36c68693          	addi	a3,a3,876 # ffffffffc0208a60 <commands+0x888>
ffffffffc02016fc:	00007617          	auipc	a2,0x7
ffffffffc0201700:	eec60613          	addi	a2,a2,-276 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201704:	1d800593          	li	a1,472
ffffffffc0201708:	00007517          	auipc	a0,0x7
ffffffffc020170c:	28050513          	addi	a0,a0,640 # ffffffffc0208988 <commands+0x7b0>
ffffffffc0201710:	af9fe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201714 <_fifo_init_mm>:
ffffffffc0201714:	00018797          	auipc	a5,0x18
ffffffffc0201718:	e3c78793          	addi	a5,a5,-452 # ffffffffc0219550 <pra_list_head>
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
ffffffffc020173c:	34050513          	addi	a0,a0,832 # ffffffffc0208a78 <commands+0x8a0>
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
ffffffffc0201764:	d7892903          	lw	s2,-648(s2) # ffffffffc02194d8 <pgfault_num>
ffffffffc0201768:	4791                	li	a5,4
ffffffffc020176a:	14f91e63          	bne	s2,a5,ffffffffc02018c6 <_fifo_check_swap+0x194>
ffffffffc020176e:	00007517          	auipc	a0,0x7
ffffffffc0201772:	35a50513          	addi	a0,a0,858 # ffffffffc0208ac8 <commands+0x8f0>
ffffffffc0201776:	6a85                	lui	s5,0x1
ffffffffc0201778:	4b29                	li	s6,10
ffffffffc020177a:	953fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020177e:	00018417          	auipc	s0,0x18
ffffffffc0201782:	d5a40413          	addi	s0,s0,-678 # ffffffffc02194d8 <pgfault_num>
ffffffffc0201786:	016a8023          	sb	s6,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc020178a:	4004                	lw	s1,0(s0)
ffffffffc020178c:	2481                	sext.w	s1,s1
ffffffffc020178e:	2b249c63          	bne	s1,s2,ffffffffc0201a46 <_fifo_check_swap+0x314>
ffffffffc0201792:	00007517          	auipc	a0,0x7
ffffffffc0201796:	35e50513          	addi	a0,a0,862 # ffffffffc0208af0 <commands+0x918>
ffffffffc020179a:	6b91                	lui	s7,0x4
ffffffffc020179c:	4c35                	li	s8,13
ffffffffc020179e:	92ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017a2:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02017a6:	00042903          	lw	s2,0(s0)
ffffffffc02017aa:	2901                	sext.w	s2,s2
ffffffffc02017ac:	26991d63          	bne	s2,s1,ffffffffc0201a26 <_fifo_check_swap+0x2f4>
ffffffffc02017b0:	00007517          	auipc	a0,0x7
ffffffffc02017b4:	36850513          	addi	a0,a0,872 # ffffffffc0208b18 <commands+0x940>
ffffffffc02017b8:	6c89                	lui	s9,0x2
ffffffffc02017ba:	4d2d                	li	s10,11
ffffffffc02017bc:	911fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017c0:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02017c4:	401c                	lw	a5,0(s0)
ffffffffc02017c6:	2781                	sext.w	a5,a5
ffffffffc02017c8:	23279f63          	bne	a5,s2,ffffffffc0201a06 <_fifo_check_swap+0x2d4>
ffffffffc02017cc:	00007517          	auipc	a0,0x7
ffffffffc02017d0:	37450513          	addi	a0,a0,884 # ffffffffc0208b40 <commands+0x968>
ffffffffc02017d4:	8f9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017d8:	6795                	lui	a5,0x5
ffffffffc02017da:	4739                	li	a4,14
ffffffffc02017dc:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02017e0:	4004                	lw	s1,0(s0)
ffffffffc02017e2:	4795                	li	a5,5
ffffffffc02017e4:	2481                	sext.w	s1,s1
ffffffffc02017e6:	20f49063          	bne	s1,a5,ffffffffc02019e6 <_fifo_check_swap+0x2b4>
ffffffffc02017ea:	00007517          	auipc	a0,0x7
ffffffffc02017ee:	32e50513          	addi	a0,a0,814 # ffffffffc0208b18 <commands+0x940>
ffffffffc02017f2:	8dbfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02017f6:	01ac8023          	sb	s10,0(s9)
ffffffffc02017fa:	401c                	lw	a5,0(s0)
ffffffffc02017fc:	2781                	sext.w	a5,a5
ffffffffc02017fe:	1c979463          	bne	a5,s1,ffffffffc02019c6 <_fifo_check_swap+0x294>
ffffffffc0201802:	00007517          	auipc	a0,0x7
ffffffffc0201806:	2c650513          	addi	a0,a0,710 # ffffffffc0208ac8 <commands+0x8f0>
ffffffffc020180a:	8c3fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020180e:	016a8023          	sb	s6,0(s5)
ffffffffc0201812:	401c                	lw	a5,0(s0)
ffffffffc0201814:	4719                	li	a4,6
ffffffffc0201816:	2781                	sext.w	a5,a5
ffffffffc0201818:	18e79763          	bne	a5,a4,ffffffffc02019a6 <_fifo_check_swap+0x274>
ffffffffc020181c:	00007517          	auipc	a0,0x7
ffffffffc0201820:	2fc50513          	addi	a0,a0,764 # ffffffffc0208b18 <commands+0x940>
ffffffffc0201824:	8a9fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201828:	01ac8023          	sb	s10,0(s9)
ffffffffc020182c:	401c                	lw	a5,0(s0)
ffffffffc020182e:	471d                	li	a4,7
ffffffffc0201830:	2781                	sext.w	a5,a5
ffffffffc0201832:	14e79a63          	bne	a5,a4,ffffffffc0201986 <_fifo_check_swap+0x254>
ffffffffc0201836:	00007517          	auipc	a0,0x7
ffffffffc020183a:	24250513          	addi	a0,a0,578 # ffffffffc0208a78 <commands+0x8a0>
ffffffffc020183e:	88ffe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201842:	01498023          	sb	s4,0(s3)
ffffffffc0201846:	401c                	lw	a5,0(s0)
ffffffffc0201848:	4721                	li	a4,8
ffffffffc020184a:	2781                	sext.w	a5,a5
ffffffffc020184c:	10e79d63          	bne	a5,a4,ffffffffc0201966 <_fifo_check_swap+0x234>
ffffffffc0201850:	00007517          	auipc	a0,0x7
ffffffffc0201854:	2a050513          	addi	a0,a0,672 # ffffffffc0208af0 <commands+0x918>
ffffffffc0201858:	875fe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020185c:	018b8023          	sb	s8,0(s7)
ffffffffc0201860:	401c                	lw	a5,0(s0)
ffffffffc0201862:	4725                	li	a4,9
ffffffffc0201864:	2781                	sext.w	a5,a5
ffffffffc0201866:	0ee79063          	bne	a5,a4,ffffffffc0201946 <_fifo_check_swap+0x214>
ffffffffc020186a:	00007517          	auipc	a0,0x7
ffffffffc020186e:	2d650513          	addi	a0,a0,726 # ffffffffc0208b40 <commands+0x968>
ffffffffc0201872:	85bfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201876:	6795                	lui	a5,0x5
ffffffffc0201878:	4739                	li	a4,14
ffffffffc020187a:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc020187e:	4004                	lw	s1,0(s0)
ffffffffc0201880:	47a9                	li	a5,10
ffffffffc0201882:	2481                	sext.w	s1,s1
ffffffffc0201884:	0af49163          	bne	s1,a5,ffffffffc0201926 <_fifo_check_swap+0x1f4>
ffffffffc0201888:	00007517          	auipc	a0,0x7
ffffffffc020188c:	24050513          	addi	a0,a0,576 # ffffffffc0208ac8 <commands+0x8f0>
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
ffffffffc02018ca:	1da68693          	addi	a3,a3,474 # ffffffffc0208aa0 <commands+0x8c8>
ffffffffc02018ce:	00007617          	auipc	a2,0x7
ffffffffc02018d2:	d1a60613          	addi	a2,a2,-742 # ffffffffc02085e8 <commands+0x410>
ffffffffc02018d6:	05100593          	li	a1,81
ffffffffc02018da:	00007517          	auipc	a0,0x7
ffffffffc02018de:	1d650513          	addi	a0,a0,470 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc02018e2:	927fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02018e6:	00007697          	auipc	a3,0x7
ffffffffc02018ea:	30a68693          	addi	a3,a3,778 # ffffffffc0208bf0 <commands+0xa18>
ffffffffc02018ee:	00007617          	auipc	a2,0x7
ffffffffc02018f2:	cfa60613          	addi	a2,a2,-774 # ffffffffc02085e8 <commands+0x410>
ffffffffc02018f6:	07300593          	li	a1,115
ffffffffc02018fa:	00007517          	auipc	a0,0x7
ffffffffc02018fe:	1b650513          	addi	a0,a0,438 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201902:	907fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201906:	00007697          	auipc	a3,0x7
ffffffffc020190a:	2c268693          	addi	a3,a3,706 # ffffffffc0208bc8 <commands+0x9f0>
ffffffffc020190e:	00007617          	auipc	a2,0x7
ffffffffc0201912:	cda60613          	addi	a2,a2,-806 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201916:	07100593          	li	a1,113
ffffffffc020191a:	00007517          	auipc	a0,0x7
ffffffffc020191e:	19650513          	addi	a0,a0,406 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201922:	8e7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201926:	00007697          	auipc	a3,0x7
ffffffffc020192a:	29268693          	addi	a3,a3,658 # ffffffffc0208bb8 <commands+0x9e0>
ffffffffc020192e:	00007617          	auipc	a2,0x7
ffffffffc0201932:	cba60613          	addi	a2,a2,-838 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201936:	06f00593          	li	a1,111
ffffffffc020193a:	00007517          	auipc	a0,0x7
ffffffffc020193e:	17650513          	addi	a0,a0,374 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201942:	8c7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201946:	00007697          	auipc	a3,0x7
ffffffffc020194a:	26268693          	addi	a3,a3,610 # ffffffffc0208ba8 <commands+0x9d0>
ffffffffc020194e:	00007617          	auipc	a2,0x7
ffffffffc0201952:	c9a60613          	addi	a2,a2,-870 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201956:	06c00593          	li	a1,108
ffffffffc020195a:	00007517          	auipc	a0,0x7
ffffffffc020195e:	15650513          	addi	a0,a0,342 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201962:	8a7fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201966:	00007697          	auipc	a3,0x7
ffffffffc020196a:	23268693          	addi	a3,a3,562 # ffffffffc0208b98 <commands+0x9c0>
ffffffffc020196e:	00007617          	auipc	a2,0x7
ffffffffc0201972:	c7a60613          	addi	a2,a2,-902 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201976:	06900593          	li	a1,105
ffffffffc020197a:	00007517          	auipc	a0,0x7
ffffffffc020197e:	13650513          	addi	a0,a0,310 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201982:	887fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201986:	00007697          	auipc	a3,0x7
ffffffffc020198a:	20268693          	addi	a3,a3,514 # ffffffffc0208b88 <commands+0x9b0>
ffffffffc020198e:	00007617          	auipc	a2,0x7
ffffffffc0201992:	c5a60613          	addi	a2,a2,-934 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201996:	06600593          	li	a1,102
ffffffffc020199a:	00007517          	auipc	a0,0x7
ffffffffc020199e:	11650513          	addi	a0,a0,278 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc02019a2:	867fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019a6:	00007697          	auipc	a3,0x7
ffffffffc02019aa:	1d268693          	addi	a3,a3,466 # ffffffffc0208b78 <commands+0x9a0>
ffffffffc02019ae:	00007617          	auipc	a2,0x7
ffffffffc02019b2:	c3a60613          	addi	a2,a2,-966 # ffffffffc02085e8 <commands+0x410>
ffffffffc02019b6:	06300593          	li	a1,99
ffffffffc02019ba:	00007517          	auipc	a0,0x7
ffffffffc02019be:	0f650513          	addi	a0,a0,246 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc02019c2:	847fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019c6:	00007697          	auipc	a3,0x7
ffffffffc02019ca:	1a268693          	addi	a3,a3,418 # ffffffffc0208b68 <commands+0x990>
ffffffffc02019ce:	00007617          	auipc	a2,0x7
ffffffffc02019d2:	c1a60613          	addi	a2,a2,-998 # ffffffffc02085e8 <commands+0x410>
ffffffffc02019d6:	06000593          	li	a1,96
ffffffffc02019da:	00007517          	auipc	a0,0x7
ffffffffc02019de:	0d650513          	addi	a0,a0,214 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc02019e2:	827fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02019e6:	00007697          	auipc	a3,0x7
ffffffffc02019ea:	18268693          	addi	a3,a3,386 # ffffffffc0208b68 <commands+0x990>
ffffffffc02019ee:	00007617          	auipc	a2,0x7
ffffffffc02019f2:	bfa60613          	addi	a2,a2,-1030 # ffffffffc02085e8 <commands+0x410>
ffffffffc02019f6:	05d00593          	li	a1,93
ffffffffc02019fa:	00007517          	auipc	a0,0x7
ffffffffc02019fe:	0b650513          	addi	a0,a0,182 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201a02:	807fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a06:	00007697          	auipc	a3,0x7
ffffffffc0201a0a:	09a68693          	addi	a3,a3,154 # ffffffffc0208aa0 <commands+0x8c8>
ffffffffc0201a0e:	00007617          	auipc	a2,0x7
ffffffffc0201a12:	bda60613          	addi	a2,a2,-1062 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a16:	05a00593          	li	a1,90
ffffffffc0201a1a:	00007517          	auipc	a0,0x7
ffffffffc0201a1e:	09650513          	addi	a0,a0,150 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201a22:	fe6fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a26:	00007697          	auipc	a3,0x7
ffffffffc0201a2a:	07a68693          	addi	a3,a3,122 # ffffffffc0208aa0 <commands+0x8c8>
ffffffffc0201a2e:	00007617          	auipc	a2,0x7
ffffffffc0201a32:	bba60613          	addi	a2,a2,-1094 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a36:	05700593          	li	a1,87
ffffffffc0201a3a:	00007517          	auipc	a0,0x7
ffffffffc0201a3e:	07650513          	addi	a0,a0,118 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201a42:	fc6fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201a46:	00007697          	auipc	a3,0x7
ffffffffc0201a4a:	05a68693          	addi	a3,a3,90 # ffffffffc0208aa0 <commands+0x8c8>
ffffffffc0201a4e:	00007617          	auipc	a2,0x7
ffffffffc0201a52:	b9a60613          	addi	a2,a2,-1126 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a56:	05400593          	li	a1,84
ffffffffc0201a5a:	00007517          	auipc	a0,0x7
ffffffffc0201a5e:	05650513          	addi	a0,a0,86 # ffffffffc0208ab0 <commands+0x8d8>
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
ffffffffc0201a8c:	17868693          	addi	a3,a3,376 # ffffffffc0208c00 <commands+0xa28>
ffffffffc0201a90:	00007617          	auipc	a2,0x7
ffffffffc0201a94:	b5860613          	addi	a2,a2,-1192 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201a98:	04100593          	li	a1,65
ffffffffc0201a9c:	00007517          	auipc	a0,0x7
ffffffffc0201aa0:	01450513          	addi	a0,a0,20 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201aa4:	f64fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201aa8:	00007697          	auipc	a3,0x7
ffffffffc0201aac:	16868693          	addi	a3,a3,360 # ffffffffc0208c10 <commands+0xa38>
ffffffffc0201ab0:	00007617          	auipc	a2,0x7
ffffffffc0201ab4:	b3860613          	addi	a2,a2,-1224 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201ab8:	04200593          	li	a1,66
ffffffffc0201abc:	00007517          	auipc	a0,0x7
ffffffffc0201ac0:	ff450513          	addi	a0,a0,-12 # ffffffffc0208ab0 <commands+0x8d8>
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
ffffffffc0201ae4:	14068693          	addi	a3,a3,320 # ffffffffc0208c20 <commands+0xa48>
ffffffffc0201ae8:	00007617          	auipc	a2,0x7
ffffffffc0201aec:	b0060613          	addi	a2,a2,-1280 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201af0:	03200593          	li	a1,50
ffffffffc0201af4:	00007517          	auipc	a0,0x7
ffffffffc0201af8:	fbc50513          	addi	a0,a0,-68 # ffffffffc0208ab0 <commands+0x8d8>
ffffffffc0201afc:	e406                	sd	ra,8(sp)
ffffffffc0201afe:	f0afe0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0201b02 <check_vma_overlap.isra.0.part.0>:
ffffffffc0201b02:	1141                	addi	sp,sp,-16
ffffffffc0201b04:	00007697          	auipc	a3,0x7
ffffffffc0201b08:	15468693          	addi	a3,a3,340 # ffffffffc0208c58 <commands+0xa80>
ffffffffc0201b0c:	00007617          	auipc	a2,0x7
ffffffffc0201b10:	adc60613          	addi	a2,a2,-1316 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201b14:	06d00593          	li	a1,109
ffffffffc0201b18:	00007517          	auipc	a0,0x7
ffffffffc0201b1c:	16050513          	addi	a0,a0,352 # ffffffffc0208c78 <commands+0xaa0>
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
ffffffffc0201b4c:	9a87a783          	lw	a5,-1624(a5) # ffffffffc02194f0 <swap_init_ok>
ffffffffc0201b50:	ef99                	bnez	a5,ffffffffc0201b6e <mm_create+0x48>
ffffffffc0201b52:	02053423          	sd	zero,40(a0)
ffffffffc0201b56:	02042823          	sw	zero,48(s0)
ffffffffc0201b5a:	4585                	li	a1,1
ffffffffc0201b5c:	03840513          	addi	a0,s0,56
ffffffffc0201b60:	191010ef          	jal	ra,ffffffffc02034f0 <sem_init>
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
ffffffffc0201c28:	06468693          	addi	a3,a3,100 # ffffffffc0208c88 <commands+0xab0>
ffffffffc0201c2c:	00007617          	auipc	a2,0x7
ffffffffc0201c30:	9bc60613          	addi	a2,a2,-1604 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201c34:	07400593          	li	a1,116
ffffffffc0201c38:	00007517          	auipc	a0,0x7
ffffffffc0201c3c:	04050513          	addi	a0,a0,64 # ffffffffc0208c78 <commands+0xaa0>
ffffffffc0201c40:	dc8fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201c44:	00007697          	auipc	a3,0x7
ffffffffc0201c48:	08468693          	addi	a3,a3,132 # ffffffffc0208cc8 <commands+0xaf0>
ffffffffc0201c4c:	00007617          	auipc	a2,0x7
ffffffffc0201c50:	99c60613          	addi	a2,a2,-1636 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201c54:	06c00593          	li	a1,108
ffffffffc0201c58:	00007517          	auipc	a0,0x7
ffffffffc0201c5c:	02050513          	addi	a0,a0,32 # ffffffffc0208c78 <commands+0xaa0>
ffffffffc0201c60:	da8fe0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0201c64:	00007697          	auipc	a3,0x7
ffffffffc0201c68:	04468693          	addi	a3,a3,68 # ffffffffc0208ca8 <commands+0xad0>
ffffffffc0201c6c:	00007617          	auipc	a2,0x7
ffffffffc0201c70:	97c60613          	addi	a2,a2,-1668 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201c74:	06b00593          	li	a1,107
ffffffffc0201c78:	00007517          	auipc	a0,0x7
ffffffffc0201c7c:	00050513          	mv	a0,a0
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
ffffffffc0201cb8:	03468693          	addi	a3,a3,52 # ffffffffc0208ce8 <commands+0xb10>
ffffffffc0201cbc:	00007617          	auipc	a2,0x7
ffffffffc0201cc0:	92c60613          	addi	a2,a2,-1748 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201cc4:	09400593          	li	a1,148
ffffffffc0201cc8:	00007517          	auipc	a0,0x7
ffffffffc0201ccc:	fb050513          	addi	a0,a0,-80 # ffffffffc0208c78 <commands+0xaa0>
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
ffffffffc0201d68:	f9c68693          	addi	a3,a3,-100 # ffffffffc0208d00 <commands+0xb28>
ffffffffc0201d6c:	00007617          	auipc	a2,0x7
ffffffffc0201d70:	87c60613          	addi	a2,a2,-1924 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201d74:	0a700593          	li	a1,167
ffffffffc0201d78:	00007517          	auipc	a0,0x7
ffffffffc0201d7c:	f0050513          	addi	a0,a0,-256 # ffffffffc0208c78 <commands+0xaa0>
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
ffffffffc0201e02:	f1268693          	addi	a3,a3,-238 # ffffffffc0208d10 <commands+0xb38>
ffffffffc0201e06:	00006617          	auipc	a2,0x6
ffffffffc0201e0a:	7e260613          	addi	a2,a2,2018 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201e0e:	0c000593          	li	a1,192
ffffffffc0201e12:	00007517          	auipc	a0,0x7
ffffffffc0201e16:	e6650513          	addi	a0,a0,-410 # ffffffffc0208c78 <commands+0xaa0>
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
ffffffffc0201e78:	ebc68693          	addi	a3,a3,-324 # ffffffffc0208d30 <commands+0xb58>
ffffffffc0201e7c:	00006617          	auipc	a2,0x6
ffffffffc0201e80:	76c60613          	addi	a2,a2,1900 # ffffffffc02085e8 <commands+0x410>
ffffffffc0201e84:	0d600593          	li	a1,214
ffffffffc0201e88:	00007517          	auipc	a0,0x7
ffffffffc0201e8c:	df050513          	addi	a0,a0,-528 # ffffffffc0208c78 <commands+0xaa0>
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
ffffffffc0201eb0:	62c7a783          	lw	a5,1580(a5) # ffffffffc02194d8 <pgfault_num>
ffffffffc0201eb4:	2785                	addiw	a5,a5,1
ffffffffc0201eb6:	00017717          	auipc	a4,0x17
ffffffffc0201eba:	62f72123          	sw	a5,1570(a4) # ffffffffc02194d8 <pgfault_num>
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
ffffffffc0201ee6:	60e7a783          	lw	a5,1550(a5) # ffffffffc02194f0 <swap_init_ok>
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
ffffffffc0201f30:	e9c50513          	addi	a0,a0,-356 # ffffffffc0208dc8 <commands+0xbf0>
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
ffffffffc0201f5a:	e4a50513          	addi	a0,a0,-438 # ffffffffc0208da0 <commands+0xbc8>
ffffffffc0201f5e:	96efe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f62:	5971                	li	s2,-4
ffffffffc0201f64:	bf55                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f66:	85a2                	mv	a1,s0
ffffffffc0201f68:	00007517          	auipc	a0,0x7
ffffffffc0201f6c:	de850513          	addi	a0,a0,-536 # ffffffffc0208d50 <commands+0xb78>
ffffffffc0201f70:	95cfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f74:	5975                	li	s2,-3
ffffffffc0201f76:	b74d                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f78:	00007517          	auipc	a0,0x7
ffffffffc0201f7c:	e7050513          	addi	a0,a0,-400 # ffffffffc0208de8 <commands+0xc10>
ffffffffc0201f80:	94cfe0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0201f84:	5971                	li	s2,-4
ffffffffc0201f86:	bf49                	j	ffffffffc0201f18 <do_pgfault+0x82>
ffffffffc0201f88:	00007517          	auipc	a0,0x7
ffffffffc0201f8c:	df850513          	addi	a0,a0,-520 # ffffffffc0208d80 <commands+0xba8>
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
ffffffffc02020e2:	46a6b683          	ld	a3,1130(a3) # ffffffffc0219548 <pages>
ffffffffc02020e6:	8d15                	sub	a0,a0,a3
ffffffffc02020e8:	8519                	srai	a0,a0,0x6
ffffffffc02020ea:	00008697          	auipc	a3,0x8
ffffffffc02020ee:	5466b683          	ld	a3,1350(a3) # ffffffffc020a630 <nbase>
ffffffffc02020f2:	9536                	add	a0,a0,a3
ffffffffc02020f4:	00c51793          	slli	a5,a0,0xc
ffffffffc02020f8:	83b1                	srli	a5,a5,0xc
ffffffffc02020fa:	00017717          	auipc	a4,0x17
ffffffffc02020fe:	3d673703          	ld	a4,982(a4) # ffffffffc02194d0 <npage>
ffffffffc0202102:	0532                	slli	a0,a0,0xc
ffffffffc0202104:	00e7fa63          	bgeu	a5,a4,ffffffffc0202118 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc0202108:	00017697          	auipc	a3,0x17
ffffffffc020210c:	4306b683          	ld	a3,1072(a3) # ffffffffc0219538 <va_pa_offset>
ffffffffc0202110:	9536                	add	a0,a0,a3
ffffffffc0202112:	60a2                	ld	ra,8(sp)
ffffffffc0202114:	0141                	addi	sp,sp,16
ffffffffc0202116:	8082                	ret
ffffffffc0202118:	86aa                	mv	a3,a0
ffffffffc020211a:	00007617          	auipc	a2,0x7
ffffffffc020211e:	87e60613          	addi	a2,a2,-1922 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0202122:	06900593          	li	a1,105
ffffffffc0202126:	00006517          	auipc	a0,0x6
ffffffffc020212a:	7d250513          	addi	a0,a0,2002 # ffffffffc02088f8 <commands+0x720>
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
ffffffffc020220c:	c0868693          	addi	a3,a3,-1016 # ffffffffc0208e10 <commands+0xc38>
ffffffffc0202210:	00006617          	auipc	a2,0x6
ffffffffc0202214:	3d860613          	addi	a2,a2,984 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202218:	06400593          	li	a1,100
ffffffffc020221c:	00007517          	auipc	a0,0x7
ffffffffc0202220:	c1450513          	addi	a0,a0,-1004 # ffffffffc0208e30 <commands+0xc58>
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
ffffffffc0202278:	26c78793          	addi	a5,a5,620 # ffffffffc02194e0 <bigblocks>
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
ffffffffc02022b4:	23078793          	addi	a5,a5,560 # ffffffffc02194e0 <bigblocks>
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
ffffffffc02022fa:	1ea7b783          	ld	a5,490(a5) # ffffffffc02194e0 <bigblocks>
ffffffffc02022fe:	4601                	li	a2,0
ffffffffc0202300:	cbbd                	beqz	a5,ffffffffc0202376 <kfree+0x9a>
ffffffffc0202302:	00017697          	auipc	a3,0x17
ffffffffc0202306:	1de68693          	addi	a3,a3,478 # ffffffffc02194e0 <bigblocks>
ffffffffc020230a:	a021                	j	ffffffffc0202312 <kfree+0x36>
ffffffffc020230c:	01048693          	addi	a3,s1,16 # ffffffffffe00010 <end+0x3fbe68c8>
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
ffffffffc020232e:	20e6b683          	ld	a3,526(a3) # ffffffffc0219538 <va_pa_offset>
ffffffffc0202332:	8c15                	sub	s0,s0,a3
ffffffffc0202334:	8031                	srli	s0,s0,0xc
ffffffffc0202336:	00017797          	auipc	a5,0x17
ffffffffc020233a:	19a7b783          	ld	a5,410(a5) # ffffffffc02194d0 <npage>
ffffffffc020233e:	06f47163          	bgeu	s0,a5,ffffffffc02023a0 <kfree+0xc4>
ffffffffc0202342:	00008517          	auipc	a0,0x8
ffffffffc0202346:	2ee53503          	ld	a0,750(a0) # ffffffffc020a630 <nbase>
ffffffffc020234a:	8c09                	sub	s0,s0,a0
ffffffffc020234c:	041a                	slli	s0,s0,0x6
ffffffffc020234e:	00017517          	auipc	a0,0x17
ffffffffc0202352:	1fa53503          	ld	a0,506(a0) # ffffffffc0219548 <pages>
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
ffffffffc020238e:	1567b783          	ld	a5,342(a5) # ffffffffc02194e0 <bigblocks>
ffffffffc0202392:	4605                	li	a2,1
ffffffffc0202394:	f7bd                	bnez	a5,ffffffffc0202302 <kfree+0x26>
ffffffffc0202396:	bff1                	j	ffffffffc0202372 <kfree+0x96>
ffffffffc0202398:	a9afe0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020239c:	b751                	j	ffffffffc0202320 <kfree+0x44>
ffffffffc020239e:	8082                	ret
ffffffffc02023a0:	00006617          	auipc	a2,0x6
ffffffffc02023a4:	53860613          	addi	a2,a2,1336 # ffffffffc02088d8 <commands+0x700>
ffffffffc02023a8:	06200593          	li	a1,98
ffffffffc02023ac:	00006517          	auipc	a0,0x6
ffffffffc02023b0:	54c50513          	addi	a0,a0,1356 # ffffffffc02088f8 <commands+0x720>
ffffffffc02023b4:	e55fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02023b8:	86a2                	mv	a3,s0
ffffffffc02023ba:	00006617          	auipc	a2,0x6
ffffffffc02023be:	5a660613          	addi	a2,a2,1446 # ffffffffc0208960 <commands+0x788>
ffffffffc02023c2:	06e00593          	li	a1,110
ffffffffc02023c6:	00006517          	auipc	a0,0x6
ffffffffc02023ca:	53250513          	addi	a0,a0,1330 # ffffffffc02088f8 <commands+0x720>
ffffffffc02023ce:	e3bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02023d2 <swap_init>:
ffffffffc02023d2:	1101                	addi	sp,sp,-32
ffffffffc02023d4:	ec06                	sd	ra,24(sp)
ffffffffc02023d6:	e822                	sd	s0,16(sp)
ffffffffc02023d8:	e426                	sd	s1,8(sp)
ffffffffc02023da:	152010ef          	jal	ra,ffffffffc020352c <swapfs_init>
ffffffffc02023de:	00017697          	auipc	a3,0x17
ffffffffc02023e2:	2126b683          	ld	a3,530(a3) # ffffffffc02195f0 <max_swap_offset>
ffffffffc02023e6:	010007b7          	lui	a5,0x1000
ffffffffc02023ea:	ff968713          	addi	a4,a3,-7
ffffffffc02023ee:	17e1                	addi	a5,a5,-8
ffffffffc02023f0:	04e7e863          	bltu	a5,a4,ffffffffc0202440 <swap_init+0x6e>
ffffffffc02023f4:	0000c797          	auipc	a5,0xc
ffffffffc02023f8:	c0c78793          	addi	a5,a5,-1012 # ffffffffc020e000 <swap_manager_fifo>
ffffffffc02023fc:	6798                	ld	a4,8(a5)
ffffffffc02023fe:	00017497          	auipc	s1,0x17
ffffffffc0202402:	0ea48493          	addi	s1,s1,234 # ffffffffc02194e8 <sm>
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
ffffffffc0202420:	a5c50513          	addi	a0,a0,-1444 # ffffffffc0208e78 <commands+0xca0>
ffffffffc0202424:	638c                	ld	a1,0(a5)
ffffffffc0202426:	4785                	li	a5,1
ffffffffc0202428:	00017717          	auipc	a4,0x17
ffffffffc020242c:	0cf72423          	sw	a5,200(a4) # ffffffffc02194f0 <swap_init_ok>
ffffffffc0202430:	c9dfd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202434:	60e2                	ld	ra,24(sp)
ffffffffc0202436:	8522                	mv	a0,s0
ffffffffc0202438:	6442                	ld	s0,16(sp)
ffffffffc020243a:	64a2                	ld	s1,8(sp)
ffffffffc020243c:	6105                	addi	sp,sp,32
ffffffffc020243e:	8082                	ret
ffffffffc0202440:	00007617          	auipc	a2,0x7
ffffffffc0202444:	a0860613          	addi	a2,a2,-1528 # ffffffffc0208e48 <commands+0xc70>
ffffffffc0202448:	02800593          	li	a1,40
ffffffffc020244c:	00007517          	auipc	a0,0x7
ffffffffc0202450:	a1c50513          	addi	a0,a0,-1508 # ffffffffc0208e68 <commands+0xc90>
ffffffffc0202454:	db5fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202458 <swap_init_mm>:
ffffffffc0202458:	00017797          	auipc	a5,0x17
ffffffffc020245c:	0907b783          	ld	a5,144(a5) # ffffffffc02194e8 <sm>
ffffffffc0202460:	0107b303          	ld	t1,16(a5)
ffffffffc0202464:	8302                	jr	t1

ffffffffc0202466 <swap_map_swappable>:
ffffffffc0202466:	00017797          	auipc	a5,0x17
ffffffffc020246a:	0827b783          	ld	a5,130(a5) # ffffffffc02194e8 <sm>
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
ffffffffc0202498:	05498993          	addi	s3,s3,84 # ffffffffc02194e8 <sm>
ffffffffc020249c:	00007b17          	auipc	s6,0x7
ffffffffc02024a0:	a54b0b13          	addi	s6,s6,-1452 # ffffffffc0208ef0 <commands+0xd18>
ffffffffc02024a4:	00007b97          	auipc	s7,0x7
ffffffffc02024a8:	a34b8b93          	addi	s7,s7,-1484 # ffffffffc0208ed8 <commands+0xd00>
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
ffffffffc0202518:	0da010ef          	jal	ra,ffffffffc02035f2 <swapfs_write>
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
ffffffffc020255a:	93a50513          	addi	a0,a0,-1734 # ffffffffc0208e90 <commands+0xcb8>
ffffffffc020255e:	b6ffd0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0202562:	bfe1                	j	ffffffffc020253a <swap_out+0xc6>
ffffffffc0202564:	4401                	li	s0,0
ffffffffc0202566:	bfd1                	j	ffffffffc020253a <swap_out+0xc6>
ffffffffc0202568:	00007697          	auipc	a3,0x7
ffffffffc020256c:	95868693          	addi	a3,a3,-1704 # ffffffffc0208ec0 <commands+0xce8>
ffffffffc0202570:	00006617          	auipc	a2,0x6
ffffffffc0202574:	07860613          	addi	a2,a2,120 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202578:	06800593          	li	a1,104
ffffffffc020257c:	00007517          	auipc	a0,0x7
ffffffffc0202580:	8ec50513          	addi	a0,a0,-1812 # ffffffffc0208e68 <commands+0xc90>
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
ffffffffc02025b6:	7af000ef          	jal	ra,ffffffffc0203564 <swapfs_read>
ffffffffc02025ba:	00093583          	ld	a1,0(s2)
ffffffffc02025be:	8626                	mv	a2,s1
ffffffffc02025c0:	00007517          	auipc	a0,0x7
ffffffffc02025c4:	98050513          	addi	a0,a0,-1664 # ffffffffc0208f40 <commands+0xd68>
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
ffffffffc02025e6:	94e68693          	addi	a3,a3,-1714 # ffffffffc0208f30 <commands+0xd58>
ffffffffc02025ea:	00006617          	auipc	a2,0x6
ffffffffc02025ee:	ffe60613          	addi	a2,a2,-2 # ffffffffc02085e8 <commands+0x410>
ffffffffc02025f2:	07e00593          	li	a1,126
ffffffffc02025f6:	00007517          	auipc	a0,0x7
ffffffffc02025fa:	87250513          	addi	a0,a0,-1934 # ffffffffc0208e68 <commands+0xc90>
ffffffffc02025fe:	c0bfd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202602 <default_init>:
ffffffffc0202602:	00017797          	auipc	a5,0x17
ffffffffc0202606:	02e78793          	addi	a5,a5,46 # ffffffffc0219630 <free_area>
ffffffffc020260a:	e79c                	sd	a5,8(a5)
ffffffffc020260c:	e39c                	sd	a5,0(a5)
ffffffffc020260e:	0007a823          	sw	zero,16(a5)
ffffffffc0202612:	8082                	ret

ffffffffc0202614 <default_nr_free_pages>:
ffffffffc0202614:	00017517          	auipc	a0,0x17
ffffffffc0202618:	02c56503          	lwu	a0,44(a0) # ffffffffc0219640 <free_area+0x10>
ffffffffc020261c:	8082                	ret

ffffffffc020261e <default_check>:
ffffffffc020261e:	715d                	addi	sp,sp,-80
ffffffffc0202620:	e0a2                	sd	s0,64(sp)
ffffffffc0202622:	00017417          	auipc	s0,0x17
ffffffffc0202626:	00e40413          	addi	s0,s0,14 # ffffffffc0219630 <free_area>
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
ffffffffc02026b2:	e9a7b783          	ld	a5,-358(a5) # ffffffffc0219548 <pages>
ffffffffc02026b6:	40fa8733          	sub	a4,s5,a5
ffffffffc02026ba:	00008617          	auipc	a2,0x8
ffffffffc02026be:	f7663603          	ld	a2,-138(a2) # ffffffffc020a630 <nbase>
ffffffffc02026c2:	8719                	srai	a4,a4,0x6
ffffffffc02026c4:	9732                	add	a4,a4,a2
ffffffffc02026c6:	00017697          	auipc	a3,0x17
ffffffffc02026ca:	e0a6b683          	ld	a3,-502(a3) # ffffffffc02194d0 <npage>
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
ffffffffc0202708:	f207ae23          	sw	zero,-196(a5) # ffffffffc0219640 <free_area+0x10>
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
ffffffffc02027ea:	e407ad23          	sw	zero,-422(a5) # ffffffffc0219640 <free_area+0x10>
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
ffffffffc0202904:	68068693          	addi	a3,a3,1664 # ffffffffc0208f80 <commands+0xda8>
ffffffffc0202908:	00006617          	auipc	a2,0x6
ffffffffc020290c:	ce060613          	addi	a2,a2,-800 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202910:	0f000593          	li	a1,240
ffffffffc0202914:	00006517          	auipc	a0,0x6
ffffffffc0202918:	67c50513          	addi	a0,a0,1660 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020291c:	8edfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202920:	00006697          	auipc	a3,0x6
ffffffffc0202924:	70868693          	addi	a3,a3,1800 # ffffffffc0209028 <commands+0xe50>
ffffffffc0202928:	00006617          	auipc	a2,0x6
ffffffffc020292c:	cc060613          	addi	a2,a2,-832 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202930:	0bd00593          	li	a1,189
ffffffffc0202934:	00006517          	auipc	a0,0x6
ffffffffc0202938:	65c50513          	addi	a0,a0,1628 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020293c:	8cdfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202940:	00006697          	auipc	a3,0x6
ffffffffc0202944:	71068693          	addi	a3,a3,1808 # ffffffffc0209050 <commands+0xe78>
ffffffffc0202948:	00006617          	auipc	a2,0x6
ffffffffc020294c:	ca060613          	addi	a2,a2,-864 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202950:	0be00593          	li	a1,190
ffffffffc0202954:	00006517          	auipc	a0,0x6
ffffffffc0202958:	63c50513          	addi	a0,a0,1596 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020295c:	8adfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202960:	00006697          	auipc	a3,0x6
ffffffffc0202964:	73068693          	addi	a3,a3,1840 # ffffffffc0209090 <commands+0xeb8>
ffffffffc0202968:	00006617          	auipc	a2,0x6
ffffffffc020296c:	c8060613          	addi	a2,a2,-896 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202970:	0c000593          	li	a1,192
ffffffffc0202974:	00006517          	auipc	a0,0x6
ffffffffc0202978:	61c50513          	addi	a0,a0,1564 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020297c:	88dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202980:	00006697          	auipc	a3,0x6
ffffffffc0202984:	79868693          	addi	a3,a3,1944 # ffffffffc0209118 <commands+0xf40>
ffffffffc0202988:	00006617          	auipc	a2,0x6
ffffffffc020298c:	c6060613          	addi	a2,a2,-928 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202990:	0d900593          	li	a1,217
ffffffffc0202994:	00006517          	auipc	a0,0x6
ffffffffc0202998:	5fc50513          	addi	a0,a0,1532 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc020299c:	86dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029a0:	00006697          	auipc	a3,0x6
ffffffffc02029a4:	62868693          	addi	a3,a3,1576 # ffffffffc0208fc8 <commands+0xdf0>
ffffffffc02029a8:	00006617          	auipc	a2,0x6
ffffffffc02029ac:	c4060613          	addi	a2,a2,-960 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029b0:	0d200593          	li	a1,210
ffffffffc02029b4:	00006517          	auipc	a0,0x6
ffffffffc02029b8:	5dc50513          	addi	a0,a0,1500 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029bc:	84dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029c0:	00006697          	auipc	a3,0x6
ffffffffc02029c4:	74868693          	addi	a3,a3,1864 # ffffffffc0209108 <commands+0xf30>
ffffffffc02029c8:	00006617          	auipc	a2,0x6
ffffffffc02029cc:	c2060613          	addi	a2,a2,-992 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029d0:	0d000593          	li	a1,208
ffffffffc02029d4:	00006517          	auipc	a0,0x6
ffffffffc02029d8:	5bc50513          	addi	a0,a0,1468 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029dc:	82dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02029e0:	00006697          	auipc	a3,0x6
ffffffffc02029e4:	71068693          	addi	a3,a3,1808 # ffffffffc02090f0 <commands+0xf18>
ffffffffc02029e8:	00006617          	auipc	a2,0x6
ffffffffc02029ec:	c0060613          	addi	a2,a2,-1024 # ffffffffc02085e8 <commands+0x410>
ffffffffc02029f0:	0cb00593          	li	a1,203
ffffffffc02029f4:	00006517          	auipc	a0,0x6
ffffffffc02029f8:	59c50513          	addi	a0,a0,1436 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02029fc:	80dfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a00:	00006697          	auipc	a3,0x6
ffffffffc0202a04:	6d068693          	addi	a3,a3,1744 # ffffffffc02090d0 <commands+0xef8>
ffffffffc0202a08:	00006617          	auipc	a2,0x6
ffffffffc0202a0c:	be060613          	addi	a2,a2,-1056 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a10:	0c200593          	li	a1,194
ffffffffc0202a14:	00006517          	auipc	a0,0x6
ffffffffc0202a18:	57c50513          	addi	a0,a0,1404 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a1c:	fecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a20:	00006697          	auipc	a3,0x6
ffffffffc0202a24:	74068693          	addi	a3,a3,1856 # ffffffffc0209160 <commands+0xf88>
ffffffffc0202a28:	00006617          	auipc	a2,0x6
ffffffffc0202a2c:	bc060613          	addi	a2,a2,-1088 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a30:	0f800593          	li	a1,248
ffffffffc0202a34:	00006517          	auipc	a0,0x6
ffffffffc0202a38:	55c50513          	addi	a0,a0,1372 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a3c:	fccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a40:	00006697          	auipc	a3,0x6
ffffffffc0202a44:	71068693          	addi	a3,a3,1808 # ffffffffc0209150 <commands+0xf78>
ffffffffc0202a48:	00006617          	auipc	a2,0x6
ffffffffc0202a4c:	ba060613          	addi	a2,a2,-1120 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a50:	0df00593          	li	a1,223
ffffffffc0202a54:	00006517          	auipc	a0,0x6
ffffffffc0202a58:	53c50513          	addi	a0,a0,1340 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a5c:	facfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a60:	00006697          	auipc	a3,0x6
ffffffffc0202a64:	69068693          	addi	a3,a3,1680 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202a68:	00006617          	auipc	a2,0x6
ffffffffc0202a6c:	b8060613          	addi	a2,a2,-1152 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a70:	0dd00593          	li	a1,221
ffffffffc0202a74:	00006517          	auipc	a0,0x6
ffffffffc0202a78:	51c50513          	addi	a0,a0,1308 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a7c:	f8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202a80:	00006697          	auipc	a3,0x6
ffffffffc0202a84:	6b068693          	addi	a3,a3,1712 # ffffffffc0209130 <commands+0xf58>
ffffffffc0202a88:	00006617          	auipc	a2,0x6
ffffffffc0202a8c:	b6060613          	addi	a2,a2,-1184 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202a90:	0dc00593          	li	a1,220
ffffffffc0202a94:	00006517          	auipc	a0,0x6
ffffffffc0202a98:	4fc50513          	addi	a0,a0,1276 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202a9c:	f6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202aa0:	00006697          	auipc	a3,0x6
ffffffffc0202aa4:	52868693          	addi	a3,a3,1320 # ffffffffc0208fc8 <commands+0xdf0>
ffffffffc0202aa8:	00006617          	auipc	a2,0x6
ffffffffc0202aac:	b4060613          	addi	a2,a2,-1216 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ab0:	0b900593          	li	a1,185
ffffffffc0202ab4:	00006517          	auipc	a0,0x6
ffffffffc0202ab8:	4dc50513          	addi	a0,a0,1244 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202abc:	f4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ac0:	00006697          	auipc	a3,0x6
ffffffffc0202ac4:	63068693          	addi	a3,a3,1584 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202ac8:	00006617          	auipc	a2,0x6
ffffffffc0202acc:	b2060613          	addi	a2,a2,-1248 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ad0:	0d600593          	li	a1,214
ffffffffc0202ad4:	00006517          	auipc	a0,0x6
ffffffffc0202ad8:	4bc50513          	addi	a0,a0,1212 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202adc:	f2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ae0:	00006697          	auipc	a3,0x6
ffffffffc0202ae4:	52868693          	addi	a3,a3,1320 # ffffffffc0209008 <commands+0xe30>
ffffffffc0202ae8:	00006617          	auipc	a2,0x6
ffffffffc0202aec:	b0060613          	addi	a2,a2,-1280 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202af0:	0d400593          	li	a1,212
ffffffffc0202af4:	00006517          	auipc	a0,0x6
ffffffffc0202af8:	49c50513          	addi	a0,a0,1180 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202afc:	f0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b00:	00006697          	auipc	a3,0x6
ffffffffc0202b04:	4e868693          	addi	a3,a3,1256 # ffffffffc0208fe8 <commands+0xe10>
ffffffffc0202b08:	00006617          	auipc	a2,0x6
ffffffffc0202b0c:	ae060613          	addi	a2,a2,-1312 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b10:	0d300593          	li	a1,211
ffffffffc0202b14:	00006517          	auipc	a0,0x6
ffffffffc0202b18:	47c50513          	addi	a0,a0,1148 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b1c:	eecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b20:	00006697          	auipc	a3,0x6
ffffffffc0202b24:	4e868693          	addi	a3,a3,1256 # ffffffffc0209008 <commands+0xe30>
ffffffffc0202b28:	00006617          	auipc	a2,0x6
ffffffffc0202b2c:	ac060613          	addi	a2,a2,-1344 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b30:	0bb00593          	li	a1,187
ffffffffc0202b34:	00006517          	auipc	a0,0x6
ffffffffc0202b38:	45c50513          	addi	a0,a0,1116 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b3c:	eccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b40:	00006697          	auipc	a3,0x6
ffffffffc0202b44:	77068693          	addi	a3,a3,1904 # ffffffffc02092b0 <commands+0x10d8>
ffffffffc0202b48:	00006617          	auipc	a2,0x6
ffffffffc0202b4c:	aa060613          	addi	a2,a2,-1376 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b50:	12500593          	li	a1,293
ffffffffc0202b54:	00006517          	auipc	a0,0x6
ffffffffc0202b58:	43c50513          	addi	a0,a0,1084 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b5c:	eacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b60:	00006697          	auipc	a3,0x6
ffffffffc0202b64:	5f068693          	addi	a3,a3,1520 # ffffffffc0209150 <commands+0xf78>
ffffffffc0202b68:	00006617          	auipc	a2,0x6
ffffffffc0202b6c:	a8060613          	addi	a2,a2,-1408 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b70:	11a00593          	li	a1,282
ffffffffc0202b74:	00006517          	auipc	a0,0x6
ffffffffc0202b78:	41c50513          	addi	a0,a0,1052 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b7c:	e8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202b80:	00006697          	auipc	a3,0x6
ffffffffc0202b84:	57068693          	addi	a3,a3,1392 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202b88:	00006617          	auipc	a2,0x6
ffffffffc0202b8c:	a6060613          	addi	a2,a2,-1440 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202b90:	11800593          	li	a1,280
ffffffffc0202b94:	00006517          	auipc	a0,0x6
ffffffffc0202b98:	3fc50513          	addi	a0,a0,1020 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202b9c:	e6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ba0:	00006697          	auipc	a3,0x6
ffffffffc0202ba4:	51068693          	addi	a3,a3,1296 # ffffffffc02090b0 <commands+0xed8>
ffffffffc0202ba8:	00006617          	auipc	a2,0x6
ffffffffc0202bac:	a4060613          	addi	a2,a2,-1472 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bb0:	0c100593          	li	a1,193
ffffffffc0202bb4:	00006517          	auipc	a0,0x6
ffffffffc0202bb8:	3dc50513          	addi	a0,a0,988 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bbc:	e4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202bc0:	00006697          	auipc	a3,0x6
ffffffffc0202bc4:	6b068693          	addi	a3,a3,1712 # ffffffffc0209270 <commands+0x1098>
ffffffffc0202bc8:	00006617          	auipc	a2,0x6
ffffffffc0202bcc:	a2060613          	addi	a2,a2,-1504 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bd0:	11200593          	li	a1,274
ffffffffc0202bd4:	00006517          	auipc	a0,0x6
ffffffffc0202bd8:	3bc50513          	addi	a0,a0,956 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bdc:	e2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202be0:	00006697          	auipc	a3,0x6
ffffffffc0202be4:	67068693          	addi	a3,a3,1648 # ffffffffc0209250 <commands+0x1078>
ffffffffc0202be8:	00006617          	auipc	a2,0x6
ffffffffc0202bec:	a0060613          	addi	a2,a2,-1536 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202bf0:	11000593          	li	a1,272
ffffffffc0202bf4:	00006517          	auipc	a0,0x6
ffffffffc0202bf8:	39c50513          	addi	a0,a0,924 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202bfc:	e0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c00:	00006697          	auipc	a3,0x6
ffffffffc0202c04:	62868693          	addi	a3,a3,1576 # ffffffffc0209228 <commands+0x1050>
ffffffffc0202c08:	00006617          	auipc	a2,0x6
ffffffffc0202c0c:	9e060613          	addi	a2,a2,-1568 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c10:	10e00593          	li	a1,270
ffffffffc0202c14:	00006517          	auipc	a0,0x6
ffffffffc0202c18:	37c50513          	addi	a0,a0,892 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c1c:	decfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c20:	00006697          	auipc	a3,0x6
ffffffffc0202c24:	5e068693          	addi	a3,a3,1504 # ffffffffc0209200 <commands+0x1028>
ffffffffc0202c28:	00006617          	auipc	a2,0x6
ffffffffc0202c2c:	9c060613          	addi	a2,a2,-1600 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c30:	10d00593          	li	a1,269
ffffffffc0202c34:	00006517          	auipc	a0,0x6
ffffffffc0202c38:	35c50513          	addi	a0,a0,860 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c3c:	dccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c40:	00006697          	auipc	a3,0x6
ffffffffc0202c44:	5b068693          	addi	a3,a3,1456 # ffffffffc02091f0 <commands+0x1018>
ffffffffc0202c48:	00006617          	auipc	a2,0x6
ffffffffc0202c4c:	9a060613          	addi	a2,a2,-1632 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c50:	10800593          	li	a1,264
ffffffffc0202c54:	00006517          	auipc	a0,0x6
ffffffffc0202c58:	33c50513          	addi	a0,a0,828 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c5c:	dacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c60:	00006697          	auipc	a3,0x6
ffffffffc0202c64:	49068693          	addi	a3,a3,1168 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202c68:	00006617          	auipc	a2,0x6
ffffffffc0202c6c:	98060613          	addi	a2,a2,-1664 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c70:	10700593          	li	a1,263
ffffffffc0202c74:	00006517          	auipc	a0,0x6
ffffffffc0202c78:	31c50513          	addi	a0,a0,796 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c7c:	d8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202c80:	00006697          	auipc	a3,0x6
ffffffffc0202c84:	55068693          	addi	a3,a3,1360 # ffffffffc02091d0 <commands+0xff8>
ffffffffc0202c88:	00006617          	auipc	a2,0x6
ffffffffc0202c8c:	96060613          	addi	a2,a2,-1696 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202c90:	10600593          	li	a1,262
ffffffffc0202c94:	00006517          	auipc	a0,0x6
ffffffffc0202c98:	2fc50513          	addi	a0,a0,764 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202c9c:	d6cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ca0:	00006697          	auipc	a3,0x6
ffffffffc0202ca4:	50068693          	addi	a3,a3,1280 # ffffffffc02091a0 <commands+0xfc8>
ffffffffc0202ca8:	00006617          	auipc	a2,0x6
ffffffffc0202cac:	94060613          	addi	a2,a2,-1728 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cb0:	10500593          	li	a1,261
ffffffffc0202cb4:	00006517          	auipc	a0,0x6
ffffffffc0202cb8:	2dc50513          	addi	a0,a0,732 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cbc:	d4cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202cc0:	00006697          	auipc	a3,0x6
ffffffffc0202cc4:	4c868693          	addi	a3,a3,1224 # ffffffffc0209188 <commands+0xfb0>
ffffffffc0202cc8:	00006617          	auipc	a2,0x6
ffffffffc0202ccc:	92060613          	addi	a2,a2,-1760 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cd0:	10400593          	li	a1,260
ffffffffc0202cd4:	00006517          	auipc	a0,0x6
ffffffffc0202cd8:	2bc50513          	addi	a0,a0,700 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cdc:	d2cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ce0:	00006697          	auipc	a3,0x6
ffffffffc0202ce4:	41068693          	addi	a3,a3,1040 # ffffffffc02090f0 <commands+0xf18>
ffffffffc0202ce8:	00006617          	auipc	a2,0x6
ffffffffc0202cec:	90060613          	addi	a2,a2,-1792 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202cf0:	0fe00593          	li	a1,254
ffffffffc0202cf4:	00006517          	auipc	a0,0x6
ffffffffc0202cf8:	29c50513          	addi	a0,a0,668 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202cfc:	d0cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d00:	00006697          	auipc	a3,0x6
ffffffffc0202d04:	47068693          	addi	a3,a3,1136 # ffffffffc0209170 <commands+0xf98>
ffffffffc0202d08:	00006617          	auipc	a2,0x6
ffffffffc0202d0c:	8e060613          	addi	a2,a2,-1824 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d10:	0f900593          	li	a1,249
ffffffffc0202d14:	00006517          	auipc	a0,0x6
ffffffffc0202d18:	27c50513          	addi	a0,a0,636 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d1c:	cecfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d20:	00006697          	auipc	a3,0x6
ffffffffc0202d24:	57068693          	addi	a3,a3,1392 # ffffffffc0209290 <commands+0x10b8>
ffffffffc0202d28:	00006617          	auipc	a2,0x6
ffffffffc0202d2c:	8c060613          	addi	a2,a2,-1856 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d30:	11700593          	li	a1,279
ffffffffc0202d34:	00006517          	auipc	a0,0x6
ffffffffc0202d38:	25c50513          	addi	a0,a0,604 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d3c:	cccfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d40:	00006697          	auipc	a3,0x6
ffffffffc0202d44:	58068693          	addi	a3,a3,1408 # ffffffffc02092c0 <commands+0x10e8>
ffffffffc0202d48:	00006617          	auipc	a2,0x6
ffffffffc0202d4c:	8a060613          	addi	a2,a2,-1888 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d50:	12600593          	li	a1,294
ffffffffc0202d54:	00006517          	auipc	a0,0x6
ffffffffc0202d58:	23c50513          	addi	a0,a0,572 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d5c:	cacfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d60:	00006697          	auipc	a3,0x6
ffffffffc0202d64:	24868693          	addi	a3,a3,584 # ffffffffc0208fa8 <commands+0xdd0>
ffffffffc0202d68:	00006617          	auipc	a2,0x6
ffffffffc0202d6c:	88060613          	addi	a2,a2,-1920 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d70:	0f300593          	li	a1,243
ffffffffc0202d74:	00006517          	auipc	a0,0x6
ffffffffc0202d78:	21c50513          	addi	a0,a0,540 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202d7c:	c8cfd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202d80:	00006697          	auipc	a3,0x6
ffffffffc0202d84:	26868693          	addi	a3,a3,616 # ffffffffc0208fe8 <commands+0xe10>
ffffffffc0202d88:	00006617          	auipc	a2,0x6
ffffffffc0202d8c:	86060613          	addi	a2,a2,-1952 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202d90:	0ba00593          	li	a1,186
ffffffffc0202d94:	00006517          	auipc	a0,0x6
ffffffffc0202d98:	1fc50513          	addi	a0,a0,508 # ffffffffc0208f90 <commands+0xdb8>
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
ffffffffc0202de6:	84e68693          	addi	a3,a3,-1970 # ffffffffc0219630 <free_area>
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
ffffffffc0202ec6:	41668693          	addi	a3,a3,1046 # ffffffffc02092d8 <commands+0x1100>
ffffffffc0202eca:	00005617          	auipc	a2,0x5
ffffffffc0202ece:	71e60613          	addi	a2,a2,1822 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ed2:	08300593          	li	a1,131
ffffffffc0202ed6:	00006517          	auipc	a0,0x6
ffffffffc0202eda:	0ba50513          	addi	a0,a0,186 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202ede:	b2afd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0202ee2:	00006697          	auipc	a3,0x6
ffffffffc0202ee6:	3ee68693          	addi	a3,a3,1006 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc0202eea:	00005617          	auipc	a2,0x5
ffffffffc0202eee:	6fe60613          	addi	a2,a2,1790 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202ef2:	08000593          	li	a1,128
ffffffffc0202ef6:	00006517          	auipc	a0,0x6
ffffffffc0202efa:	09a50513          	addi	a0,a0,154 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0202efe:	b0afd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0202f02 <default_alloc_pages>:
ffffffffc0202f02:	c941                	beqz	a0,ffffffffc0202f92 <default_alloc_pages+0x90>
ffffffffc0202f04:	00016597          	auipc	a1,0x16
ffffffffc0202f08:	72c58593          	addi	a1,a1,1836 # ffffffffc0219630 <free_area>
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
ffffffffc0202f98:	33c68693          	addi	a3,a3,828 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc0202f9c:	00005617          	auipc	a2,0x5
ffffffffc0202fa0:	64c60613          	addi	a2,a2,1612 # ffffffffc02085e8 <commands+0x410>
ffffffffc0202fa4:	06200593          	li	a1,98
ffffffffc0202fa8:	00006517          	auipc	a0,0x6
ffffffffc0202fac:	fe850513          	addi	a0,a0,-24 # ffffffffc0208f90 <commands+0xdb8>
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
ffffffffc0202ff4:	64068693          	addi	a3,a3,1600 # ffffffffc0219630 <free_area>
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
ffffffffc020306a:	29a68693          	addi	a3,a3,666 # ffffffffc0209300 <commands+0x1128>
ffffffffc020306e:	00005617          	auipc	a2,0x5
ffffffffc0203072:	57a60613          	addi	a2,a2,1402 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203076:	04900593          	li	a1,73
ffffffffc020307a:	00006517          	auipc	a0,0x6
ffffffffc020307e:	f1650513          	addi	a0,a0,-234 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc0203082:	986fd0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203086:	00006697          	auipc	a3,0x6
ffffffffc020308a:	24a68693          	addi	a3,a3,586 # ffffffffc02092d0 <commands+0x10f8>
ffffffffc020308e:	00005617          	auipc	a2,0x5
ffffffffc0203092:	55a60613          	addi	a2,a2,1370 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203096:	04600593          	li	a1,70
ffffffffc020309a:	00006517          	auipc	a0,0x6
ffffffffc020309e:	ef650513          	addi	a0,a0,-266 # ffffffffc0208f90 <commands+0xdb8>
ffffffffc02030a2:	966fd0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02030a6 <phi_test_sema>:
ffffffffc02030a6:	00016697          	auipc	a3,0x16
ffffffffc02030aa:	5da68693          	addi	a3,a3,1498 # ffffffffc0219680 <state_sema>
ffffffffc02030ae:	00251793          	slli	a5,a0,0x2
ffffffffc02030b2:	97b6                	add	a5,a5,a3
ffffffffc02030b4:	4390                	lw	a2,0(a5)
ffffffffc02030b6:	4705                	li	a4,1
ffffffffc02030b8:	00e60363          	beq	a2,a4,ffffffffc02030be <phi_test_sema+0x18>
ffffffffc02030bc:	8082                	ret
ffffffffc02030be:	0045071b          	addiw	a4,a0,4
ffffffffc02030c2:	4595                	li	a1,5
ffffffffc02030c4:	02b7673b          	remw	a4,a4,a1
ffffffffc02030c8:	4609                	li	a2,2
ffffffffc02030ca:	070a                	slli	a4,a4,0x2
ffffffffc02030cc:	9736                	add	a4,a4,a3
ffffffffc02030ce:	4318                	lw	a4,0(a4)
ffffffffc02030d0:	fec706e3          	beq	a4,a2,ffffffffc02030bc <phi_test_sema+0x16>
ffffffffc02030d4:	0015071b          	addiw	a4,a0,1
ffffffffc02030d8:	02b7673b          	remw	a4,a4,a1
ffffffffc02030dc:	070a                	slli	a4,a4,0x2
ffffffffc02030de:	96ba                	add	a3,a3,a4
ffffffffc02030e0:	4298                	lw	a4,0(a3)
ffffffffc02030e2:	fcc70de3          	beq	a4,a2,ffffffffc02030bc <phi_test_sema+0x16>
ffffffffc02030e6:	00151713          	slli	a4,a0,0x1
ffffffffc02030ea:	953a                	add	a0,a0,a4
ffffffffc02030ec:	050e                	slli	a0,a0,0x3
ffffffffc02030ee:	00016717          	auipc	a4,0x16
ffffffffc02030f2:	5d270713          	addi	a4,a4,1490 # ffffffffc02196c0 <s>
ffffffffc02030f6:	953a                	add	a0,a0,a4
ffffffffc02030f8:	c390                	sw	a2,0(a5)
ffffffffc02030fa:	aefd                	j	ffffffffc02034f8 <up>

ffffffffc02030fc <phi_take_forks_sema>:
ffffffffc02030fc:	1141                	addi	sp,sp,-16
ffffffffc02030fe:	e022                	sd	s0,0(sp)
ffffffffc0203100:	842a                	mv	s0,a0
ffffffffc0203102:	00016517          	auipc	a0,0x16
ffffffffc0203106:	54e50513          	addi	a0,a0,1358 # ffffffffc0219650 <mutex>
ffffffffc020310a:	e406                	sd	ra,8(sp)
ffffffffc020310c:	3ee000ef          	jal	ra,ffffffffc02034fa <down>
ffffffffc0203110:	00241713          	slli	a4,s0,0x2
ffffffffc0203114:	00016797          	auipc	a5,0x16
ffffffffc0203118:	56c78793          	addi	a5,a5,1388 # ffffffffc0219680 <state_sema>
ffffffffc020311c:	97ba                	add	a5,a5,a4
ffffffffc020311e:	8522                	mv	a0,s0
ffffffffc0203120:	4705                	li	a4,1
ffffffffc0203122:	c398                	sw	a4,0(a5)
ffffffffc0203124:	f83ff0ef          	jal	ra,ffffffffc02030a6 <phi_test_sema>
ffffffffc0203128:	00016517          	auipc	a0,0x16
ffffffffc020312c:	52850513          	addi	a0,a0,1320 # ffffffffc0219650 <mutex>
ffffffffc0203130:	3c8000ef          	jal	ra,ffffffffc02034f8 <up>
ffffffffc0203134:	00141513          	slli	a0,s0,0x1
ffffffffc0203138:	942a                	add	s0,s0,a0
ffffffffc020313a:	040e                	slli	s0,s0,0x3
ffffffffc020313c:	00016517          	auipc	a0,0x16
ffffffffc0203140:	58450513          	addi	a0,a0,1412 # ffffffffc02196c0 <s>
ffffffffc0203144:	9522                	add	a0,a0,s0
ffffffffc0203146:	6402                	ld	s0,0(sp)
ffffffffc0203148:	60a2                	ld	ra,8(sp)
ffffffffc020314a:	0141                	addi	sp,sp,16
ffffffffc020314c:	a67d                	j	ffffffffc02034fa <down>

ffffffffc020314e <phi_put_forks_sema>:
ffffffffc020314e:	1101                	addi	sp,sp,-32
ffffffffc0203150:	e822                	sd	s0,16(sp)
ffffffffc0203152:	842a                	mv	s0,a0
ffffffffc0203154:	00016517          	auipc	a0,0x16
ffffffffc0203158:	4fc50513          	addi	a0,a0,1276 # ffffffffc0219650 <mutex>
ffffffffc020315c:	ec06                	sd	ra,24(sp)
ffffffffc020315e:	e426                	sd	s1,8(sp)
ffffffffc0203160:	39a000ef          	jal	ra,ffffffffc02034fa <down>
ffffffffc0203164:	4495                	li	s1,5
ffffffffc0203166:	0044051b          	addiw	a0,s0,4
ffffffffc020316a:	0295653b          	remw	a0,a0,s1
ffffffffc020316e:	00241713          	slli	a4,s0,0x2
ffffffffc0203172:	00016797          	auipc	a5,0x16
ffffffffc0203176:	50e78793          	addi	a5,a5,1294 # ffffffffc0219680 <state_sema>
ffffffffc020317a:	97ba                	add	a5,a5,a4
ffffffffc020317c:	0007a023          	sw	zero,0(a5)
ffffffffc0203180:	f27ff0ef          	jal	ra,ffffffffc02030a6 <phi_test_sema>
ffffffffc0203184:	0014051b          	addiw	a0,s0,1
ffffffffc0203188:	0295653b          	remw	a0,a0,s1
ffffffffc020318c:	f1bff0ef          	jal	ra,ffffffffc02030a6 <phi_test_sema>
ffffffffc0203190:	6442                	ld	s0,16(sp)
ffffffffc0203192:	60e2                	ld	ra,24(sp)
ffffffffc0203194:	64a2                	ld	s1,8(sp)
ffffffffc0203196:	00016517          	auipc	a0,0x16
ffffffffc020319a:	4ba50513          	addi	a0,a0,1210 # ffffffffc0219650 <mutex>
ffffffffc020319e:	6105                	addi	sp,sp,32
ffffffffc02031a0:	aea1                	j	ffffffffc02034f8 <up>

ffffffffc02031a2 <philosopher_using_semaphore>:
ffffffffc02031a2:	7179                	addi	sp,sp,-48
ffffffffc02031a4:	f022                	sd	s0,32(sp)
ffffffffc02031a6:	0005041b          	sext.w	s0,a0
ffffffffc02031aa:	85a2                	mv	a1,s0
ffffffffc02031ac:	00006517          	auipc	a0,0x6
ffffffffc02031b0:	1b450513          	addi	a0,a0,436 # ffffffffc0209360 <default_pmm_manager+0x38>
ffffffffc02031b4:	ec26                	sd	s1,24(sp)
ffffffffc02031b6:	e84a                	sd	s2,16(sp)
ffffffffc02031b8:	e44e                	sd	s3,8(sp)
ffffffffc02031ba:	e052                	sd	s4,0(sp)
ffffffffc02031bc:	f406                	sd	ra,40(sp)
ffffffffc02031be:	4485                	li	s1,1
ffffffffc02031c0:	f0dfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031c4:	00006a17          	auipc	s4,0x6
ffffffffc02031c8:	1bca0a13          	addi	s4,s4,444 # ffffffffc0209380 <default_pmm_manager+0x58>
ffffffffc02031cc:	00006997          	auipc	s3,0x6
ffffffffc02031d0:	1e498993          	addi	s3,s3,484 # ffffffffc02093b0 <default_pmm_manager+0x88>
ffffffffc02031d4:	4915                	li	s2,5
ffffffffc02031d6:	85a6                	mv	a1,s1
ffffffffc02031d8:	8622                	mv	a2,s0
ffffffffc02031da:	8552                	mv	a0,s4
ffffffffc02031dc:	ef1fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031e0:	4529                	li	a0,10
ffffffffc02031e2:	714010ef          	jal	ra,ffffffffc02048f6 <do_sleep>
ffffffffc02031e6:	8522                	mv	a0,s0
ffffffffc02031e8:	f15ff0ef          	jal	ra,ffffffffc02030fc <phi_take_forks_sema>
ffffffffc02031ec:	85a6                	mv	a1,s1
ffffffffc02031ee:	8622                	mv	a2,s0
ffffffffc02031f0:	854e                	mv	a0,s3
ffffffffc02031f2:	edbfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02031f6:	4529                	li	a0,10
ffffffffc02031f8:	6fe010ef          	jal	ra,ffffffffc02048f6 <do_sleep>
ffffffffc02031fc:	2485                	addiw	s1,s1,1
ffffffffc02031fe:	8522                	mv	a0,s0
ffffffffc0203200:	f4fff0ef          	jal	ra,ffffffffc020314e <phi_put_forks_sema>
ffffffffc0203204:	fd2499e3          	bne	s1,s2,ffffffffc02031d6 <philosopher_using_semaphore+0x34>
ffffffffc0203208:	85a2                	mv	a1,s0
ffffffffc020320a:	00006517          	auipc	a0,0x6
ffffffffc020320e:	1d650513          	addi	a0,a0,470 # ffffffffc02093e0 <default_pmm_manager+0xb8>
ffffffffc0203212:	ebbfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc0203216:	70a2                	ld	ra,40(sp)
ffffffffc0203218:	7402                	ld	s0,32(sp)
ffffffffc020321a:	64e2                	ld	s1,24(sp)
ffffffffc020321c:	6942                	ld	s2,16(sp)
ffffffffc020321e:	69a2                	ld	s3,8(sp)
ffffffffc0203220:	6a02                	ld	s4,0(sp)
ffffffffc0203222:	4501                	li	a0,0
ffffffffc0203224:	6145                	addi	sp,sp,48
ffffffffc0203226:	8082                	ret

ffffffffc0203228 <check_sync>:
ffffffffc0203228:	7139                	addi	sp,sp,-64
ffffffffc020322a:	4585                	li	a1,1
ffffffffc020322c:	00016517          	auipc	a0,0x16
ffffffffc0203230:	42450513          	addi	a0,a0,1060 # ffffffffc0219650 <mutex>
ffffffffc0203234:	f822                	sd	s0,48(sp)
ffffffffc0203236:	f426                	sd	s1,40(sp)
ffffffffc0203238:	f04a                	sd	s2,32(sp)
ffffffffc020323a:	ec4e                	sd	s3,24(sp)
ffffffffc020323c:	e852                	sd	s4,16(sp)
ffffffffc020323e:	e456                	sd	s5,8(sp)
ffffffffc0203240:	fc06                	sd	ra,56(sp)
ffffffffc0203242:	00016917          	auipc	s2,0x16
ffffffffc0203246:	47e90913          	addi	s2,s2,1150 # ffffffffc02196c0 <s>
ffffffffc020324a:	2a6000ef          	jal	ra,ffffffffc02034f0 <sem_init>
ffffffffc020324e:	00016497          	auipc	s1,0x16
ffffffffc0203252:	44a48493          	addi	s1,s1,1098 # ffffffffc0219698 <philosopher_proc_sema>
ffffffffc0203256:	4401                	li	s0,0
ffffffffc0203258:	00000a97          	auipc	s5,0x0
ffffffffc020325c:	f4aa8a93          	addi	s5,s5,-182 # ffffffffc02031a2 <philosopher_using_semaphore>
ffffffffc0203260:	00006a17          	auipc	s4,0x6
ffffffffc0203264:	1f0a0a13          	addi	s4,s4,496 # ffffffffc0209450 <default_pmm_manager+0x128>
ffffffffc0203268:	4995                	li	s3,5
ffffffffc020326a:	4581                	li	a1,0
ffffffffc020326c:	854a                	mv	a0,s2
ffffffffc020326e:	282000ef          	jal	ra,ffffffffc02034f0 <sem_init>
ffffffffc0203272:	4601                	li	a2,0
ffffffffc0203274:	85a2                	mv	a1,s0
ffffffffc0203276:	8556                	mv	a0,s5
ffffffffc0203278:	23d000ef          	jal	ra,ffffffffc0203cb4 <kernel_thread>
ffffffffc020327c:	02a05663          	blez	a0,ffffffffc02032a8 <check_sync+0x80>
ffffffffc0203280:	60a000ef          	jal	ra,ffffffffc020388a <find_proc>
ffffffffc0203284:	85d2                	mv	a1,s4
ffffffffc0203286:	0405                	addi	s0,s0,1
ffffffffc0203288:	e088                	sd	a0,0(s1)
ffffffffc020328a:	0961                	addi	s2,s2,24
ffffffffc020328c:	568000ef          	jal	ra,ffffffffc02037f4 <set_proc_name>
ffffffffc0203290:	04a1                	addi	s1,s1,8
ffffffffc0203292:	fd341ce3          	bne	s0,s3,ffffffffc020326a <check_sync+0x42>
ffffffffc0203296:	70e2                	ld	ra,56(sp)
ffffffffc0203298:	7442                	ld	s0,48(sp)
ffffffffc020329a:	74a2                	ld	s1,40(sp)
ffffffffc020329c:	7902                	ld	s2,32(sp)
ffffffffc020329e:	69e2                	ld	s3,24(sp)
ffffffffc02032a0:	6a42                	ld	s4,16(sp)
ffffffffc02032a2:	6aa2                	ld	s5,8(sp)
ffffffffc02032a4:	6121                	addi	sp,sp,64
ffffffffc02032a6:	8082                	ret
ffffffffc02032a8:	00006617          	auipc	a2,0x6
ffffffffc02032ac:	15860613          	addi	a2,a2,344 # ffffffffc0209400 <default_pmm_manager+0xd8>
ffffffffc02032b0:	06c00593          	li	a1,108
ffffffffc02032b4:	00006517          	auipc	a0,0x6
ffffffffc02032b8:	18450513          	addi	a0,a0,388 # ffffffffc0209438 <default_pmm_manager+0x110>
ffffffffc02032bc:	f4dfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032c0 <wait_queue_del.part.0>:
ffffffffc02032c0:	1141                	addi	sp,sp,-16
ffffffffc02032c2:	00006697          	auipc	a3,0x6
ffffffffc02032c6:	1a668693          	addi	a3,a3,422 # ffffffffc0209468 <default_pmm_manager+0x140>
ffffffffc02032ca:	00005617          	auipc	a2,0x5
ffffffffc02032ce:	31e60613          	addi	a2,a2,798 # ffffffffc02085e8 <commands+0x410>
ffffffffc02032d2:	45f1                	li	a1,28
ffffffffc02032d4:	00006517          	auipc	a0,0x6
ffffffffc02032d8:	1d450513          	addi	a0,a0,468 # ffffffffc02094a8 <default_pmm_manager+0x180>
ffffffffc02032dc:	e406                	sd	ra,8(sp)
ffffffffc02032de:	f2bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02032e2 <wait_queue_init>:
ffffffffc02032e2:	e508                	sd	a0,8(a0)
ffffffffc02032e4:	e108                	sd	a0,0(a0)
ffffffffc02032e6:	8082                	ret

ffffffffc02032e8 <wait_queue_del>:
ffffffffc02032e8:	7198                	ld	a4,32(a1)
ffffffffc02032ea:	01858793          	addi	a5,a1,24
ffffffffc02032ee:	00e78b63          	beq	a5,a4,ffffffffc0203304 <wait_queue_del+0x1c>
ffffffffc02032f2:	6994                	ld	a3,16(a1)
ffffffffc02032f4:	00a69863          	bne	a3,a0,ffffffffc0203304 <wait_queue_del+0x1c>
ffffffffc02032f8:	6d94                	ld	a3,24(a1)
ffffffffc02032fa:	e698                	sd	a4,8(a3)
ffffffffc02032fc:	e314                	sd	a3,0(a4)
ffffffffc02032fe:	f19c                	sd	a5,32(a1)
ffffffffc0203300:	ed9c                	sd	a5,24(a1)
ffffffffc0203302:	8082                	ret
ffffffffc0203304:	1141                	addi	sp,sp,-16
ffffffffc0203306:	e406                	sd	ra,8(sp)
ffffffffc0203308:	fb9ff0ef          	jal	ra,ffffffffc02032c0 <wait_queue_del.part.0>

ffffffffc020330c <wait_queue_first>:
ffffffffc020330c:	651c                	ld	a5,8(a0)
ffffffffc020330e:	00f50563          	beq	a0,a5,ffffffffc0203318 <wait_queue_first+0xc>
ffffffffc0203312:	fe878513          	addi	a0,a5,-24
ffffffffc0203316:	8082                	ret
ffffffffc0203318:	4501                	li	a0,0
ffffffffc020331a:	8082                	ret

ffffffffc020331c <wait_in_queue>:
ffffffffc020331c:	711c                	ld	a5,32(a0)
ffffffffc020331e:	0561                	addi	a0,a0,24
ffffffffc0203320:	40a78533          	sub	a0,a5,a0
ffffffffc0203324:	00a03533          	snez	a0,a0
ffffffffc0203328:	8082                	ret

ffffffffc020332a <wakeup_wait>:
ffffffffc020332a:	ce91                	beqz	a3,ffffffffc0203346 <wakeup_wait+0x1c>
ffffffffc020332c:	7198                	ld	a4,32(a1)
ffffffffc020332e:	01858793          	addi	a5,a1,24
ffffffffc0203332:	00e78e63          	beq	a5,a4,ffffffffc020334e <wakeup_wait+0x24>
ffffffffc0203336:	6994                	ld	a3,16(a1)
ffffffffc0203338:	00d51b63          	bne	a0,a3,ffffffffc020334e <wakeup_wait+0x24>
ffffffffc020333c:	6d94                	ld	a3,24(a1)
ffffffffc020333e:	e698                	sd	a4,8(a3)
ffffffffc0203340:	e314                	sd	a3,0(a4)
ffffffffc0203342:	f19c                	sd	a5,32(a1)
ffffffffc0203344:	ed9c                	sd	a5,24(a1)
ffffffffc0203346:	6188                	ld	a0,0(a1)
ffffffffc0203348:	c590                	sw	a2,8(a1)
ffffffffc020334a:	6820106f          	j	ffffffffc02049cc <wakeup_proc>
ffffffffc020334e:	1141                	addi	sp,sp,-16
ffffffffc0203350:	e406                	sd	ra,8(sp)
ffffffffc0203352:	f6fff0ef          	jal	ra,ffffffffc02032c0 <wait_queue_del.part.0>

ffffffffc0203356 <wait_current_set>:
ffffffffc0203356:	00016797          	auipc	a5,0x16
ffffffffc020335a:	1a27b783          	ld	a5,418(a5) # ffffffffc02194f8 <current>
ffffffffc020335e:	c39d                	beqz	a5,ffffffffc0203384 <wait_current_set+0x2e>
ffffffffc0203360:	01858713          	addi	a4,a1,24
ffffffffc0203364:	800006b7          	lui	a3,0x80000
ffffffffc0203368:	ed98                	sd	a4,24(a1)
ffffffffc020336a:	e19c                	sd	a5,0(a1)
ffffffffc020336c:	c594                	sw	a3,8(a1)
ffffffffc020336e:	4685                	li	a3,1
ffffffffc0203370:	c394                	sw	a3,0(a5)
ffffffffc0203372:	0ec7a623          	sw	a2,236(a5)
ffffffffc0203376:	611c                	ld	a5,0(a0)
ffffffffc0203378:	e988                	sd	a0,16(a1)
ffffffffc020337a:	e118                	sd	a4,0(a0)
ffffffffc020337c:	e798                	sd	a4,8(a5)
ffffffffc020337e:	f188                	sd	a0,32(a1)
ffffffffc0203380:	ed9c                	sd	a5,24(a1)
ffffffffc0203382:	8082                	ret
ffffffffc0203384:	1141                	addi	sp,sp,-16
ffffffffc0203386:	00006697          	auipc	a3,0x6
ffffffffc020338a:	13a68693          	addi	a3,a3,314 # ffffffffc02094c0 <default_pmm_manager+0x198>
ffffffffc020338e:	00005617          	auipc	a2,0x5
ffffffffc0203392:	25a60613          	addi	a2,a2,602 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203396:	07400593          	li	a1,116
ffffffffc020339a:	00006517          	auipc	a0,0x6
ffffffffc020339e:	10e50513          	addi	a0,a0,270 # ffffffffc02094a8 <default_pmm_manager+0x180>
ffffffffc02033a2:	e406                	sd	ra,8(sp)
ffffffffc02033a4:	e65fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02033a8 <__down.constprop.0>:
ffffffffc02033a8:	715d                	addi	sp,sp,-80
ffffffffc02033aa:	e0a2                	sd	s0,64(sp)
ffffffffc02033ac:	e486                	sd	ra,72(sp)
ffffffffc02033ae:	fc26                	sd	s1,56(sp)
ffffffffc02033b0:	842a                	mv	s0,a0
ffffffffc02033b2:	100027f3          	csrr	a5,sstatus
ffffffffc02033b6:	8b89                	andi	a5,a5,2
ffffffffc02033b8:	ebb1                	bnez	a5,ffffffffc020340c <__down.constprop.0+0x64>
ffffffffc02033ba:	411c                	lw	a5,0(a0)
ffffffffc02033bc:	00f05a63          	blez	a5,ffffffffc02033d0 <__down.constprop.0+0x28>
ffffffffc02033c0:	37fd                	addiw	a5,a5,-1
ffffffffc02033c2:	c11c                	sw	a5,0(a0)
ffffffffc02033c4:	4501                	li	a0,0
ffffffffc02033c6:	60a6                	ld	ra,72(sp)
ffffffffc02033c8:	6406                	ld	s0,64(sp)
ffffffffc02033ca:	74e2                	ld	s1,56(sp)
ffffffffc02033cc:	6161                	addi	sp,sp,80
ffffffffc02033ce:	8082                	ret
ffffffffc02033d0:	00850413          	addi	s0,a0,8
ffffffffc02033d4:	0024                	addi	s1,sp,8
ffffffffc02033d6:	10000613          	li	a2,256
ffffffffc02033da:	85a6                	mv	a1,s1
ffffffffc02033dc:	8522                	mv	a0,s0
ffffffffc02033de:	f79ff0ef          	jal	ra,ffffffffc0203356 <wait_current_set>
ffffffffc02033e2:	69c010ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc02033e6:	100027f3          	csrr	a5,sstatus
ffffffffc02033ea:	8b89                	andi	a5,a5,2
ffffffffc02033ec:	efb9                	bnez	a5,ffffffffc020344a <__down.constprop.0+0xa2>
ffffffffc02033ee:	8526                	mv	a0,s1
ffffffffc02033f0:	f2dff0ef          	jal	ra,ffffffffc020331c <wait_in_queue>
ffffffffc02033f4:	e531                	bnez	a0,ffffffffc0203440 <__down.constprop.0+0x98>
ffffffffc02033f6:	4542                	lw	a0,16(sp)
ffffffffc02033f8:	10000793          	li	a5,256
ffffffffc02033fc:	fcf515e3          	bne	a0,a5,ffffffffc02033c6 <__down.constprop.0+0x1e>
ffffffffc0203400:	60a6                	ld	ra,72(sp)
ffffffffc0203402:	6406                	ld	s0,64(sp)
ffffffffc0203404:	74e2                	ld	s1,56(sp)
ffffffffc0203406:	4501                	li	a0,0
ffffffffc0203408:	6161                	addi	sp,sp,80
ffffffffc020340a:	8082                	ret
ffffffffc020340c:	a2cfd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203410:	401c                	lw	a5,0(s0)
ffffffffc0203412:	00f05c63          	blez	a5,ffffffffc020342a <__down.constprop.0+0x82>
ffffffffc0203416:	37fd                	addiw	a5,a5,-1
ffffffffc0203418:	c01c                	sw	a5,0(s0)
ffffffffc020341a:	a18fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020341e:	60a6                	ld	ra,72(sp)
ffffffffc0203420:	6406                	ld	s0,64(sp)
ffffffffc0203422:	74e2                	ld	s1,56(sp)
ffffffffc0203424:	4501                	li	a0,0
ffffffffc0203426:	6161                	addi	sp,sp,80
ffffffffc0203428:	8082                	ret
ffffffffc020342a:	0421                	addi	s0,s0,8
ffffffffc020342c:	0024                	addi	s1,sp,8
ffffffffc020342e:	10000613          	li	a2,256
ffffffffc0203432:	85a6                	mv	a1,s1
ffffffffc0203434:	8522                	mv	a0,s0
ffffffffc0203436:	f21ff0ef          	jal	ra,ffffffffc0203356 <wait_current_set>
ffffffffc020343a:	9f8fd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020343e:	b755                	j	ffffffffc02033e2 <__down.constprop.0+0x3a>
ffffffffc0203440:	85a6                	mv	a1,s1
ffffffffc0203442:	8522                	mv	a0,s0
ffffffffc0203444:	ea5ff0ef          	jal	ra,ffffffffc02032e8 <wait_queue_del>
ffffffffc0203448:	b77d                	j	ffffffffc02033f6 <__down.constprop.0+0x4e>
ffffffffc020344a:	9eefd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020344e:	8526                	mv	a0,s1
ffffffffc0203450:	ecdff0ef          	jal	ra,ffffffffc020331c <wait_in_queue>
ffffffffc0203454:	e501                	bnez	a0,ffffffffc020345c <__down.constprop.0+0xb4>
ffffffffc0203456:	9dcfd0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc020345a:	bf71                	j	ffffffffc02033f6 <__down.constprop.0+0x4e>
ffffffffc020345c:	85a6                	mv	a1,s1
ffffffffc020345e:	8522                	mv	a0,s0
ffffffffc0203460:	e89ff0ef          	jal	ra,ffffffffc02032e8 <wait_queue_del>
ffffffffc0203464:	bfcd                	j	ffffffffc0203456 <__down.constprop.0+0xae>

ffffffffc0203466 <__up.constprop.0>:
ffffffffc0203466:	1101                	addi	sp,sp,-32
ffffffffc0203468:	e822                	sd	s0,16(sp)
ffffffffc020346a:	ec06                	sd	ra,24(sp)
ffffffffc020346c:	e426                	sd	s1,8(sp)
ffffffffc020346e:	e04a                	sd	s2,0(sp)
ffffffffc0203470:	842a                	mv	s0,a0
ffffffffc0203472:	100027f3          	csrr	a5,sstatus
ffffffffc0203476:	8b89                	andi	a5,a5,2
ffffffffc0203478:	4901                	li	s2,0
ffffffffc020347a:	eba1                	bnez	a5,ffffffffc02034ca <__up.constprop.0+0x64>
ffffffffc020347c:	00840493          	addi	s1,s0,8
ffffffffc0203480:	8526                	mv	a0,s1
ffffffffc0203482:	e8bff0ef          	jal	ra,ffffffffc020330c <wait_queue_first>
ffffffffc0203486:	85aa                	mv	a1,a0
ffffffffc0203488:	cd0d                	beqz	a0,ffffffffc02034c2 <__up.constprop.0+0x5c>
ffffffffc020348a:	6118                	ld	a4,0(a0)
ffffffffc020348c:	10000793          	li	a5,256
ffffffffc0203490:	0ec72703          	lw	a4,236(a4)
ffffffffc0203494:	02f71f63          	bne	a4,a5,ffffffffc02034d2 <__up.constprop.0+0x6c>
ffffffffc0203498:	4685                	li	a3,1
ffffffffc020349a:	10000613          	li	a2,256
ffffffffc020349e:	8526                	mv	a0,s1
ffffffffc02034a0:	e8bff0ef          	jal	ra,ffffffffc020332a <wakeup_wait>
ffffffffc02034a4:	00091863          	bnez	s2,ffffffffc02034b4 <__up.constprop.0+0x4e>
ffffffffc02034a8:	60e2                	ld	ra,24(sp)
ffffffffc02034aa:	6442                	ld	s0,16(sp)
ffffffffc02034ac:	64a2                	ld	s1,8(sp)
ffffffffc02034ae:	6902                	ld	s2,0(sp)
ffffffffc02034b0:	6105                	addi	sp,sp,32
ffffffffc02034b2:	8082                	ret
ffffffffc02034b4:	6442                	ld	s0,16(sp)
ffffffffc02034b6:	60e2                	ld	ra,24(sp)
ffffffffc02034b8:	64a2                	ld	s1,8(sp)
ffffffffc02034ba:	6902                	ld	s2,0(sp)
ffffffffc02034bc:	6105                	addi	sp,sp,32
ffffffffc02034be:	974fd06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc02034c2:	401c                	lw	a5,0(s0)
ffffffffc02034c4:	2785                	addiw	a5,a5,1
ffffffffc02034c6:	c01c                	sw	a5,0(s0)
ffffffffc02034c8:	bff1                	j	ffffffffc02034a4 <__up.constprop.0+0x3e>
ffffffffc02034ca:	96efd0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc02034ce:	4905                	li	s2,1
ffffffffc02034d0:	b775                	j	ffffffffc020347c <__up.constprop.0+0x16>
ffffffffc02034d2:	00006697          	auipc	a3,0x6
ffffffffc02034d6:	ffe68693          	addi	a3,a3,-2 # ffffffffc02094d0 <default_pmm_manager+0x1a8>
ffffffffc02034da:	00005617          	auipc	a2,0x5
ffffffffc02034de:	10e60613          	addi	a2,a2,270 # ffffffffc02085e8 <commands+0x410>
ffffffffc02034e2:	45e5                	li	a1,25
ffffffffc02034e4:	00006517          	auipc	a0,0x6
ffffffffc02034e8:	01450513          	addi	a0,a0,20 # ffffffffc02094f8 <default_pmm_manager+0x1d0>
ffffffffc02034ec:	d1dfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02034f0 <sem_init>:
ffffffffc02034f0:	c10c                	sw	a1,0(a0)
ffffffffc02034f2:	0521                	addi	a0,a0,8
ffffffffc02034f4:	defff06f          	j	ffffffffc02032e2 <wait_queue_init>

ffffffffc02034f8 <up>:
ffffffffc02034f8:	b7bd                	j	ffffffffc0203466 <__up.constprop.0>

ffffffffc02034fa <down>:
ffffffffc02034fa:	1141                	addi	sp,sp,-16
ffffffffc02034fc:	e406                	sd	ra,8(sp)
ffffffffc02034fe:	eabff0ef          	jal	ra,ffffffffc02033a8 <__down.constprop.0>
ffffffffc0203502:	2501                	sext.w	a0,a0
ffffffffc0203504:	e501                	bnez	a0,ffffffffc020350c <down+0x12>
ffffffffc0203506:	60a2                	ld	ra,8(sp)
ffffffffc0203508:	0141                	addi	sp,sp,16
ffffffffc020350a:	8082                	ret
ffffffffc020350c:	00006697          	auipc	a3,0x6
ffffffffc0203510:	ffc68693          	addi	a3,a3,-4 # ffffffffc0209508 <default_pmm_manager+0x1e0>
ffffffffc0203514:	00005617          	auipc	a2,0x5
ffffffffc0203518:	0d460613          	addi	a2,a2,212 # ffffffffc02085e8 <commands+0x410>
ffffffffc020351c:	04000593          	li	a1,64
ffffffffc0203520:	00006517          	auipc	a0,0x6
ffffffffc0203524:	fd850513          	addi	a0,a0,-40 # ffffffffc02094f8 <default_pmm_manager+0x1d0>
ffffffffc0203528:	ce1fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020352c <swapfs_init>:
ffffffffc020352c:	1141                	addi	sp,sp,-16
ffffffffc020352e:	4505                	li	a0,1
ffffffffc0203530:	e406                	sd	ra,8(sp)
ffffffffc0203532:	ff1fc0ef          	jal	ra,ffffffffc0200522 <ide_device_valid>
ffffffffc0203536:	cd01                	beqz	a0,ffffffffc020354e <swapfs_init+0x22>
ffffffffc0203538:	4505                	li	a0,1
ffffffffc020353a:	feffc0ef          	jal	ra,ffffffffc0200528 <ide_device_size>
ffffffffc020353e:	60a2                	ld	ra,8(sp)
ffffffffc0203540:	810d                	srli	a0,a0,0x3
ffffffffc0203542:	00016797          	auipc	a5,0x16
ffffffffc0203546:	0aa7b723          	sd	a0,174(a5) # ffffffffc02195f0 <max_swap_offset>
ffffffffc020354a:	0141                	addi	sp,sp,16
ffffffffc020354c:	8082                	ret
ffffffffc020354e:	00006617          	auipc	a2,0x6
ffffffffc0203552:	fca60613          	addi	a2,a2,-54 # ffffffffc0209518 <default_pmm_manager+0x1f0>
ffffffffc0203556:	45b5                	li	a1,13
ffffffffc0203558:	00006517          	auipc	a0,0x6
ffffffffc020355c:	fe050513          	addi	a0,a0,-32 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc0203560:	ca9fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203564 <swapfs_read>:
ffffffffc0203564:	1141                	addi	sp,sp,-16
ffffffffc0203566:	e406                	sd	ra,8(sp)
ffffffffc0203568:	00855793          	srli	a5,a0,0x8
ffffffffc020356c:	cbb1                	beqz	a5,ffffffffc02035c0 <swapfs_read+0x5c>
ffffffffc020356e:	00016717          	auipc	a4,0x16
ffffffffc0203572:	08273703          	ld	a4,130(a4) # ffffffffc02195f0 <max_swap_offset>
ffffffffc0203576:	04e7f563          	bgeu	a5,a4,ffffffffc02035c0 <swapfs_read+0x5c>
ffffffffc020357a:	00016617          	auipc	a2,0x16
ffffffffc020357e:	fce63603          	ld	a2,-50(a2) # ffffffffc0219548 <pages>
ffffffffc0203582:	8d91                	sub	a1,a1,a2
ffffffffc0203584:	4065d613          	srai	a2,a1,0x6
ffffffffc0203588:	00007717          	auipc	a4,0x7
ffffffffc020358c:	0a873703          	ld	a4,168(a4) # ffffffffc020a630 <nbase>
ffffffffc0203590:	963a                	add	a2,a2,a4
ffffffffc0203592:	00c61713          	slli	a4,a2,0xc
ffffffffc0203596:	8331                	srli	a4,a4,0xc
ffffffffc0203598:	00016697          	auipc	a3,0x16
ffffffffc020359c:	f386b683          	ld	a3,-200(a3) # ffffffffc02194d0 <npage>
ffffffffc02035a0:	0037959b          	slliw	a1,a5,0x3
ffffffffc02035a4:	0632                	slli	a2,a2,0xc
ffffffffc02035a6:	02d77963          	bgeu	a4,a3,ffffffffc02035d8 <swapfs_read+0x74>
ffffffffc02035aa:	60a2                	ld	ra,8(sp)
ffffffffc02035ac:	00016797          	auipc	a5,0x16
ffffffffc02035b0:	f8c7b783          	ld	a5,-116(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02035b4:	46a1                	li	a3,8
ffffffffc02035b6:	963e                	add	a2,a2,a5
ffffffffc02035b8:	4505                	li	a0,1
ffffffffc02035ba:	0141                	addi	sp,sp,16
ffffffffc02035bc:	f73fc06f          	j	ffffffffc020052e <ide_read_secs>
ffffffffc02035c0:	86aa                	mv	a3,a0
ffffffffc02035c2:	00006617          	auipc	a2,0x6
ffffffffc02035c6:	f8e60613          	addi	a2,a2,-114 # ffffffffc0209550 <default_pmm_manager+0x228>
ffffffffc02035ca:	45d1                	li	a1,20
ffffffffc02035cc:	00006517          	auipc	a0,0x6
ffffffffc02035d0:	f6c50513          	addi	a0,a0,-148 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc02035d4:	c35fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02035d8:	86b2                	mv	a3,a2
ffffffffc02035da:	06900593          	li	a1,105
ffffffffc02035de:	00005617          	auipc	a2,0x5
ffffffffc02035e2:	3ba60613          	addi	a2,a2,954 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02035e6:	00005517          	auipc	a0,0x5
ffffffffc02035ea:	31250513          	addi	a0,a0,786 # ffffffffc02088f8 <commands+0x720>
ffffffffc02035ee:	c1bfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02035f2 <swapfs_write>:
ffffffffc02035f2:	1141                	addi	sp,sp,-16
ffffffffc02035f4:	e406                	sd	ra,8(sp)
ffffffffc02035f6:	00855793          	srli	a5,a0,0x8
ffffffffc02035fa:	cbb1                	beqz	a5,ffffffffc020364e <swapfs_write+0x5c>
ffffffffc02035fc:	00016717          	auipc	a4,0x16
ffffffffc0203600:	ff473703          	ld	a4,-12(a4) # ffffffffc02195f0 <max_swap_offset>
ffffffffc0203604:	04e7f563          	bgeu	a5,a4,ffffffffc020364e <swapfs_write+0x5c>
ffffffffc0203608:	00016617          	auipc	a2,0x16
ffffffffc020360c:	f4063603          	ld	a2,-192(a2) # ffffffffc0219548 <pages>
ffffffffc0203610:	8d91                	sub	a1,a1,a2
ffffffffc0203612:	4065d613          	srai	a2,a1,0x6
ffffffffc0203616:	00007717          	auipc	a4,0x7
ffffffffc020361a:	01a73703          	ld	a4,26(a4) # ffffffffc020a630 <nbase>
ffffffffc020361e:	963a                	add	a2,a2,a4
ffffffffc0203620:	00c61713          	slli	a4,a2,0xc
ffffffffc0203624:	8331                	srli	a4,a4,0xc
ffffffffc0203626:	00016697          	auipc	a3,0x16
ffffffffc020362a:	eaa6b683          	ld	a3,-342(a3) # ffffffffc02194d0 <npage>
ffffffffc020362e:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203632:	0632                	slli	a2,a2,0xc
ffffffffc0203634:	02d77963          	bgeu	a4,a3,ffffffffc0203666 <swapfs_write+0x74>
ffffffffc0203638:	60a2                	ld	ra,8(sp)
ffffffffc020363a:	00016797          	auipc	a5,0x16
ffffffffc020363e:	efe7b783          	ld	a5,-258(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203642:	46a1                	li	a3,8
ffffffffc0203644:	963e                	add	a2,a2,a5
ffffffffc0203646:	4505                	li	a0,1
ffffffffc0203648:	0141                	addi	sp,sp,16
ffffffffc020364a:	f09fc06f          	j	ffffffffc0200552 <ide_write_secs>
ffffffffc020364e:	86aa                	mv	a3,a0
ffffffffc0203650:	00006617          	auipc	a2,0x6
ffffffffc0203654:	f0060613          	addi	a2,a2,-256 # ffffffffc0209550 <default_pmm_manager+0x228>
ffffffffc0203658:	45e5                	li	a1,25
ffffffffc020365a:	00006517          	auipc	a0,0x6
ffffffffc020365e:	ede50513          	addi	a0,a0,-290 # ffffffffc0209538 <default_pmm_manager+0x210>
ffffffffc0203662:	ba7fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203666:	86b2                	mv	a3,a2
ffffffffc0203668:	06900593          	li	a1,105
ffffffffc020366c:	00005617          	auipc	a2,0x5
ffffffffc0203670:	32c60613          	addi	a2,a2,812 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0203674:	00005517          	auipc	a0,0x5
ffffffffc0203678:	28450513          	addi	a0,a0,644 # ffffffffc02088f8 <commands+0x720>
ffffffffc020367c:	b8dfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203680 <kernel_thread_entry>:
ffffffffc0203680:	8526                	mv	a0,s1
ffffffffc0203682:	9402                	jalr	s0
ffffffffc0203684:	680000ef          	jal	ra,ffffffffc0203d04 <do_exit>

ffffffffc0203688 <switch_to>:
ffffffffc0203688:	00153023          	sd	ra,0(a0)
ffffffffc020368c:	00253423          	sd	sp,8(a0)
ffffffffc0203690:	e900                	sd	s0,16(a0)
ffffffffc0203692:	ed04                	sd	s1,24(a0)
ffffffffc0203694:	03253023          	sd	s2,32(a0)
ffffffffc0203698:	03353423          	sd	s3,40(a0)
ffffffffc020369c:	03453823          	sd	s4,48(a0)
ffffffffc02036a0:	03553c23          	sd	s5,56(a0)
ffffffffc02036a4:	05653023          	sd	s6,64(a0)
ffffffffc02036a8:	05753423          	sd	s7,72(a0)
ffffffffc02036ac:	05853823          	sd	s8,80(a0)
ffffffffc02036b0:	05953c23          	sd	s9,88(a0)
ffffffffc02036b4:	07a53023          	sd	s10,96(a0)
ffffffffc02036b8:	07b53423          	sd	s11,104(a0)
ffffffffc02036bc:	0005b083          	ld	ra,0(a1)
ffffffffc02036c0:	0085b103          	ld	sp,8(a1)
ffffffffc02036c4:	6980                	ld	s0,16(a1)
ffffffffc02036c6:	6d84                	ld	s1,24(a1)
ffffffffc02036c8:	0205b903          	ld	s2,32(a1)
ffffffffc02036cc:	0285b983          	ld	s3,40(a1)
ffffffffc02036d0:	0305ba03          	ld	s4,48(a1)
ffffffffc02036d4:	0385ba83          	ld	s5,56(a1)
ffffffffc02036d8:	0405bb03          	ld	s6,64(a1)
ffffffffc02036dc:	0485bb83          	ld	s7,72(a1)
ffffffffc02036e0:	0505bc03          	ld	s8,80(a1)
ffffffffc02036e4:	0585bc83          	ld	s9,88(a1)
ffffffffc02036e8:	0605bd03          	ld	s10,96(a1)
ffffffffc02036ec:	0685bd83          	ld	s11,104(a1)
ffffffffc02036f0:	8082                	ret

ffffffffc02036f2 <alloc_proc>:
ffffffffc02036f2:	1141                	addi	sp,sp,-16
ffffffffc02036f4:	14800513          	li	a0,328
ffffffffc02036f8:	e022                	sd	s0,0(sp)
ffffffffc02036fa:	e406                	sd	ra,8(sp)
ffffffffc02036fc:	b31fe0ef          	jal	ra,ffffffffc020222c <kmalloc>
ffffffffc0203700:	842a                	mv	s0,a0
ffffffffc0203702:	cd21                	beqz	a0,ffffffffc020375a <alloc_proc+0x68>
ffffffffc0203704:	57fd                	li	a5,-1
ffffffffc0203706:	1782                	slli	a5,a5,0x20
ffffffffc0203708:	e11c                	sd	a5,0(a0)
ffffffffc020370a:	07000613          	li	a2,112
ffffffffc020370e:	4581                	li	a1,0
ffffffffc0203710:	00052423          	sw	zero,8(a0)
ffffffffc0203714:	00053823          	sd	zero,16(a0)
ffffffffc0203718:	00053c23          	sd	zero,24(a0)
ffffffffc020371c:	02053023          	sd	zero,32(a0)
ffffffffc0203720:	02053423          	sd	zero,40(a0)
ffffffffc0203724:	03050513          	addi	a0,a0,48
ffffffffc0203728:	3dc040ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc020372c:	00016797          	auipc	a5,0x16
ffffffffc0203730:	e147b783          	ld	a5,-492(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203734:	0a043023          	sd	zero,160(s0)
ffffffffc0203738:	f45c                	sd	a5,168(s0)
ffffffffc020373a:	0a042823          	sw	zero,176(s0)
ffffffffc020373e:	463d                	li	a2,15
ffffffffc0203740:	4581                	li	a1,0
ffffffffc0203742:	0b440513          	addi	a0,s0,180
ffffffffc0203746:	3be040ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc020374a:	0e042623          	sw	zero,236(s0)
ffffffffc020374e:	0e043c23          	sd	zero,248(s0)
ffffffffc0203752:	10043023          	sd	zero,256(s0)
ffffffffc0203756:	0e043823          	sd	zero,240(s0)
ffffffffc020375a:	60a2                	ld	ra,8(sp)
ffffffffc020375c:	8522                	mv	a0,s0
ffffffffc020375e:	6402                	ld	s0,0(sp)
ffffffffc0203760:	0141                	addi	sp,sp,16
ffffffffc0203762:	8082                	ret

ffffffffc0203764 <forkret>:
ffffffffc0203764:	00016797          	auipc	a5,0x16
ffffffffc0203768:	d947b783          	ld	a5,-620(a5) # ffffffffc02194f8 <current>
ffffffffc020376c:	73c8                	ld	a0,160(a5)
ffffffffc020376e:	dbcfd06f          	j	ffffffffc0200d2a <forkrets>

ffffffffc0203772 <setup_pgdir.isra.0>:
ffffffffc0203772:	1101                	addi	sp,sp,-32
ffffffffc0203774:	e426                	sd	s1,8(sp)
ffffffffc0203776:	84aa                	mv	s1,a0
ffffffffc0203778:	4505                	li	a0,1
ffffffffc020377a:	ec06                	sd	ra,24(sp)
ffffffffc020377c:	e822                	sd	s0,16(sp)
ffffffffc020377e:	dccfd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc0203782:	c939                	beqz	a0,ffffffffc02037d8 <setup_pgdir.isra.0+0x66>
ffffffffc0203784:	00016697          	auipc	a3,0x16
ffffffffc0203788:	dc46b683          	ld	a3,-572(a3) # ffffffffc0219548 <pages>
ffffffffc020378c:	40d506b3          	sub	a3,a0,a3
ffffffffc0203790:	8699                	srai	a3,a3,0x6
ffffffffc0203792:	00007417          	auipc	s0,0x7
ffffffffc0203796:	e9e43403          	ld	s0,-354(s0) # ffffffffc020a630 <nbase>
ffffffffc020379a:	96a2                	add	a3,a3,s0
ffffffffc020379c:	00c69793          	slli	a5,a3,0xc
ffffffffc02037a0:	83b1                	srli	a5,a5,0xc
ffffffffc02037a2:	00016717          	auipc	a4,0x16
ffffffffc02037a6:	d2e73703          	ld	a4,-722(a4) # ffffffffc02194d0 <npage>
ffffffffc02037aa:	06b2                	slli	a3,a3,0xc
ffffffffc02037ac:	02e7f863          	bgeu	a5,a4,ffffffffc02037dc <setup_pgdir.isra.0+0x6a>
ffffffffc02037b0:	00016417          	auipc	s0,0x16
ffffffffc02037b4:	d8843403          	ld	s0,-632(s0) # ffffffffc0219538 <va_pa_offset>
ffffffffc02037b8:	9436                	add	s0,s0,a3
ffffffffc02037ba:	6605                	lui	a2,0x1
ffffffffc02037bc:	00016597          	auipc	a1,0x16
ffffffffc02037c0:	d0c5b583          	ld	a1,-756(a1) # ffffffffc02194c8 <boot_pgdir>
ffffffffc02037c4:	8522                	mv	a0,s0
ffffffffc02037c6:	350040ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc02037ca:	4501                	li	a0,0
ffffffffc02037cc:	e080                	sd	s0,0(s1)
ffffffffc02037ce:	60e2                	ld	ra,24(sp)
ffffffffc02037d0:	6442                	ld	s0,16(sp)
ffffffffc02037d2:	64a2                	ld	s1,8(sp)
ffffffffc02037d4:	6105                	addi	sp,sp,32
ffffffffc02037d6:	8082                	ret
ffffffffc02037d8:	5571                	li	a0,-4
ffffffffc02037da:	bfd5                	j	ffffffffc02037ce <setup_pgdir.isra.0+0x5c>
ffffffffc02037dc:	00005617          	auipc	a2,0x5
ffffffffc02037e0:	1bc60613          	addi	a2,a2,444 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02037e4:	06900593          	li	a1,105
ffffffffc02037e8:	00005517          	auipc	a0,0x5
ffffffffc02037ec:	11050513          	addi	a0,a0,272 # ffffffffc02088f8 <commands+0x720>
ffffffffc02037f0:	a19fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02037f4 <set_proc_name>:
ffffffffc02037f4:	1101                	addi	sp,sp,-32
ffffffffc02037f6:	e822                	sd	s0,16(sp)
ffffffffc02037f8:	0b450413          	addi	s0,a0,180
ffffffffc02037fc:	e426                	sd	s1,8(sp)
ffffffffc02037fe:	4641                	li	a2,16
ffffffffc0203800:	84ae                	mv	s1,a1
ffffffffc0203802:	8522                	mv	a0,s0
ffffffffc0203804:	4581                	li	a1,0
ffffffffc0203806:	ec06                	sd	ra,24(sp)
ffffffffc0203808:	2fc040ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc020380c:	8522                	mv	a0,s0
ffffffffc020380e:	6442                	ld	s0,16(sp)
ffffffffc0203810:	60e2                	ld	ra,24(sp)
ffffffffc0203812:	85a6                	mv	a1,s1
ffffffffc0203814:	64a2                	ld	s1,8(sp)
ffffffffc0203816:	463d                	li	a2,15
ffffffffc0203818:	6105                	addi	sp,sp,32
ffffffffc020381a:	2fc0406f          	j	ffffffffc0207b16 <memcpy>

ffffffffc020381e <proc_run>:
ffffffffc020381e:	7179                	addi	sp,sp,-48
ffffffffc0203820:	ec4a                	sd	s2,24(sp)
ffffffffc0203822:	00016917          	auipc	s2,0x16
ffffffffc0203826:	cd690913          	addi	s2,s2,-810 # ffffffffc02194f8 <current>
ffffffffc020382a:	f026                	sd	s1,32(sp)
ffffffffc020382c:	00093483          	ld	s1,0(s2)
ffffffffc0203830:	f406                	sd	ra,40(sp)
ffffffffc0203832:	e84e                	sd	s3,16(sp)
ffffffffc0203834:	02a48863          	beq	s1,a0,ffffffffc0203864 <proc_run+0x46>
ffffffffc0203838:	100027f3          	csrr	a5,sstatus
ffffffffc020383c:	8b89                	andi	a5,a5,2
ffffffffc020383e:	4981                	li	s3,0
ffffffffc0203840:	ef9d                	bnez	a5,ffffffffc020387e <proc_run+0x60>
ffffffffc0203842:	755c                	ld	a5,168(a0)
ffffffffc0203844:	577d                	li	a4,-1
ffffffffc0203846:	177e                	slli	a4,a4,0x3f
ffffffffc0203848:	83b1                	srli	a5,a5,0xc
ffffffffc020384a:	00a93023          	sd	a0,0(s2)
ffffffffc020384e:	8fd9                	or	a5,a5,a4
ffffffffc0203850:	18079073          	csrw	satp,a5
ffffffffc0203854:	03050593          	addi	a1,a0,48
ffffffffc0203858:	03048513          	addi	a0,s1,48
ffffffffc020385c:	e2dff0ef          	jal	ra,ffffffffc0203688 <switch_to>
ffffffffc0203860:	00099863          	bnez	s3,ffffffffc0203870 <proc_run+0x52>
ffffffffc0203864:	70a2                	ld	ra,40(sp)
ffffffffc0203866:	7482                	ld	s1,32(sp)
ffffffffc0203868:	6962                	ld	s2,24(sp)
ffffffffc020386a:	69c2                	ld	s3,16(sp)
ffffffffc020386c:	6145                	addi	sp,sp,48
ffffffffc020386e:	8082                	ret
ffffffffc0203870:	70a2                	ld	ra,40(sp)
ffffffffc0203872:	7482                	ld	s1,32(sp)
ffffffffc0203874:	6962                	ld	s2,24(sp)
ffffffffc0203876:	69c2                	ld	s3,16(sp)
ffffffffc0203878:	6145                	addi	sp,sp,48
ffffffffc020387a:	db9fc06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc020387e:	e42a                	sd	a0,8(sp)
ffffffffc0203880:	db9fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203884:	6522                	ld	a0,8(sp)
ffffffffc0203886:	4985                	li	s3,1
ffffffffc0203888:	bf6d                	j	ffffffffc0203842 <proc_run+0x24>

ffffffffc020388a <find_proc>:
ffffffffc020388a:	6789                	lui	a5,0x2
ffffffffc020388c:	fff5071b          	addiw	a4,a0,-1
ffffffffc0203890:	17f9                	addi	a5,a5,-2
ffffffffc0203892:	04e7e063          	bltu	a5,a4,ffffffffc02038d2 <find_proc+0x48>
ffffffffc0203896:	1141                	addi	sp,sp,-16
ffffffffc0203898:	e022                	sd	s0,0(sp)
ffffffffc020389a:	45a9                	li	a1,10
ffffffffc020389c:	842a                	mv	s0,a0
ffffffffc020389e:	2501                	sext.w	a0,a0
ffffffffc02038a0:	e406                	sd	ra,8(sp)
ffffffffc02038a2:	67a040ef          	jal	ra,ffffffffc0207f1c <hash32>
ffffffffc02038a6:	02051693          	slli	a3,a0,0x20
ffffffffc02038aa:	00012797          	auipc	a5,0x12
ffffffffc02038ae:	be678793          	addi	a5,a5,-1050 # ffffffffc0215490 <hash_list>
ffffffffc02038b2:	82f1                	srli	a3,a3,0x1c
ffffffffc02038b4:	96be                	add	a3,a3,a5
ffffffffc02038b6:	87b6                	mv	a5,a3
ffffffffc02038b8:	a029                	j	ffffffffc02038c2 <find_proc+0x38>
ffffffffc02038ba:	f2c7a703          	lw	a4,-212(a5)
ffffffffc02038be:	00870c63          	beq	a4,s0,ffffffffc02038d6 <find_proc+0x4c>
ffffffffc02038c2:	679c                	ld	a5,8(a5)
ffffffffc02038c4:	fef69be3          	bne	a3,a5,ffffffffc02038ba <find_proc+0x30>
ffffffffc02038c8:	60a2                	ld	ra,8(sp)
ffffffffc02038ca:	6402                	ld	s0,0(sp)
ffffffffc02038cc:	4501                	li	a0,0
ffffffffc02038ce:	0141                	addi	sp,sp,16
ffffffffc02038d0:	8082                	ret
ffffffffc02038d2:	4501                	li	a0,0
ffffffffc02038d4:	8082                	ret
ffffffffc02038d6:	60a2                	ld	ra,8(sp)
ffffffffc02038d8:	6402                	ld	s0,0(sp)
ffffffffc02038da:	f2878513          	addi	a0,a5,-216
ffffffffc02038de:	0141                	addi	sp,sp,16
ffffffffc02038e0:	8082                	ret

ffffffffc02038e2 <do_fork>:
ffffffffc02038e2:	7159                	addi	sp,sp,-112
ffffffffc02038e4:	e4ce                	sd	s3,72(sp)
ffffffffc02038e6:	00016997          	auipc	s3,0x16
ffffffffc02038ea:	c2a98993          	addi	s3,s3,-982 # ffffffffc0219510 <nr_process>
ffffffffc02038ee:	0009a703          	lw	a4,0(s3)
ffffffffc02038f2:	f486                	sd	ra,104(sp)
ffffffffc02038f4:	f0a2                	sd	s0,96(sp)
ffffffffc02038f6:	eca6                	sd	s1,88(sp)
ffffffffc02038f8:	e8ca                	sd	s2,80(sp)
ffffffffc02038fa:	e0d2                	sd	s4,64(sp)
ffffffffc02038fc:	fc56                	sd	s5,56(sp)
ffffffffc02038fe:	f85a                	sd	s6,48(sp)
ffffffffc0203900:	f45e                	sd	s7,40(sp)
ffffffffc0203902:	f062                	sd	s8,32(sp)
ffffffffc0203904:	ec66                	sd	s9,24(sp)
ffffffffc0203906:	e86a                	sd	s10,16(sp)
ffffffffc0203908:	e46e                	sd	s11,8(sp)
ffffffffc020390a:	6785                	lui	a5,0x1
ffffffffc020390c:	30f75f63          	bge	a4,a5,ffffffffc0203c2a <do_fork+0x348>
ffffffffc0203910:	8a2a                	mv	s4,a0
ffffffffc0203912:	892e                	mv	s2,a1
ffffffffc0203914:	84b2                	mv	s1,a2
ffffffffc0203916:	dddff0ef          	jal	ra,ffffffffc02036f2 <alloc_proc>
ffffffffc020391a:	842a                	mv	s0,a0
ffffffffc020391c:	28050263          	beqz	a0,ffffffffc0203ba0 <do_fork+0x2be>
ffffffffc0203920:	00016b97          	auipc	s7,0x16
ffffffffc0203924:	bd8b8b93          	addi	s7,s7,-1064 # ffffffffc02194f8 <current>
ffffffffc0203928:	000bb783          	ld	a5,0(s7)
ffffffffc020392c:	0ec7a703          	lw	a4,236(a5) # 10ec <kern_entry-0xffffffffc01fef14>
ffffffffc0203930:	f11c                	sd	a5,32(a0)
ffffffffc0203932:	30071c63          	bnez	a4,ffffffffc0203c4a <do_fork+0x368>
ffffffffc0203936:	4509                	li	a0,2
ffffffffc0203938:	c12fd0ef          	jal	ra,ffffffffc0200d4a <alloc_pages>
ffffffffc020393c:	24050f63          	beqz	a0,ffffffffc0203b9a <do_fork+0x2b8>
ffffffffc0203940:	00016c17          	auipc	s8,0x16
ffffffffc0203944:	c08c0c13          	addi	s8,s8,-1016 # ffffffffc0219548 <pages>
ffffffffc0203948:	000c3683          	ld	a3,0(s8)
ffffffffc020394c:	00007a97          	auipc	s5,0x7
ffffffffc0203950:	ce4aba83          	ld	s5,-796(s5) # ffffffffc020a630 <nbase>
ffffffffc0203954:	00016c97          	auipc	s9,0x16
ffffffffc0203958:	b7cc8c93          	addi	s9,s9,-1156 # ffffffffc02194d0 <npage>
ffffffffc020395c:	40d506b3          	sub	a3,a0,a3
ffffffffc0203960:	8699                	srai	a3,a3,0x6
ffffffffc0203962:	96d6                	add	a3,a3,s5
ffffffffc0203964:	000cb703          	ld	a4,0(s9)
ffffffffc0203968:	00c69793          	slli	a5,a3,0xc
ffffffffc020396c:	83b1                	srli	a5,a5,0xc
ffffffffc020396e:	06b2                	slli	a3,a3,0xc
ffffffffc0203970:	2ce7f163          	bgeu	a5,a4,ffffffffc0203c32 <do_fork+0x350>
ffffffffc0203974:	000bb703          	ld	a4,0(s7)
ffffffffc0203978:	00016d17          	auipc	s10,0x16
ffffffffc020397c:	bc0d0d13          	addi	s10,s10,-1088 # ffffffffc0219538 <va_pa_offset>
ffffffffc0203980:	000d3783          	ld	a5,0(s10)
ffffffffc0203984:	02873b03          	ld	s6,40(a4)
ffffffffc0203988:	96be                	add	a3,a3,a5
ffffffffc020398a:	e814                	sd	a3,16(s0)
ffffffffc020398c:	020b0863          	beqz	s6,ffffffffc02039bc <do_fork+0xda>
ffffffffc0203990:	100a7a13          	andi	s4,s4,256
ffffffffc0203994:	1c0a0163          	beqz	s4,ffffffffc0203b56 <do_fork+0x274>
ffffffffc0203998:	030b2703          	lw	a4,48(s6)
ffffffffc020399c:	018b3783          	ld	a5,24(s6)
ffffffffc02039a0:	c02006b7          	lui	a3,0xc0200
ffffffffc02039a4:	2705                	addiw	a4,a4,1
ffffffffc02039a6:	02eb2823          	sw	a4,48(s6)
ffffffffc02039aa:	03643423          	sd	s6,40(s0)
ffffffffc02039ae:	2ad7ee63          	bltu	a5,a3,ffffffffc0203c6a <do_fork+0x388>
ffffffffc02039b2:	000d3703          	ld	a4,0(s10)
ffffffffc02039b6:	6814                	ld	a3,16(s0)
ffffffffc02039b8:	8f99                	sub	a5,a5,a4
ffffffffc02039ba:	f45c                	sd	a5,168(s0)
ffffffffc02039bc:	6789                	lui	a5,0x2
ffffffffc02039be:	ee078793          	addi	a5,a5,-288 # 1ee0 <kern_entry-0xffffffffc01fe120>
ffffffffc02039c2:	97b6                	add	a5,a5,a3
ffffffffc02039c4:	8626                	mv	a2,s1
ffffffffc02039c6:	f05c                	sd	a5,160(s0)
ffffffffc02039c8:	873e                	mv	a4,a5
ffffffffc02039ca:	12048313          	addi	t1,s1,288
ffffffffc02039ce:	00063883          	ld	a7,0(a2)
ffffffffc02039d2:	00863803          	ld	a6,8(a2)
ffffffffc02039d6:	6a08                	ld	a0,16(a2)
ffffffffc02039d8:	6e0c                	ld	a1,24(a2)
ffffffffc02039da:	01173023          	sd	a7,0(a4)
ffffffffc02039de:	01073423          	sd	a6,8(a4)
ffffffffc02039e2:	eb08                	sd	a0,16(a4)
ffffffffc02039e4:	ef0c                	sd	a1,24(a4)
ffffffffc02039e6:	02060613          	addi	a2,a2,32
ffffffffc02039ea:	02070713          	addi	a4,a4,32
ffffffffc02039ee:	fe6610e3          	bne	a2,t1,ffffffffc02039ce <do_fork+0xec>
ffffffffc02039f2:	0407b823          	sd	zero,80(a5)
ffffffffc02039f6:	12090a63          	beqz	s2,ffffffffc0203b2a <do_fork+0x248>
ffffffffc02039fa:	0127b823          	sd	s2,16(a5)
ffffffffc02039fe:	00000717          	auipc	a4,0x0
ffffffffc0203a02:	d6670713          	addi	a4,a4,-666 # ffffffffc0203764 <forkret>
ffffffffc0203a06:	f818                	sd	a4,48(s0)
ffffffffc0203a08:	fc1c                	sd	a5,56(s0)
ffffffffc0203a0a:	100027f3          	csrr	a5,sstatus
ffffffffc0203a0e:	8b89                	andi	a5,a5,2
ffffffffc0203a10:	4901                	li	s2,0
ffffffffc0203a12:	12079e63          	bnez	a5,ffffffffc0203b4e <do_fork+0x26c>
ffffffffc0203a16:	0000a597          	auipc	a1,0xa
ffffffffc0203a1a:	67258593          	addi	a1,a1,1650 # ffffffffc020e088 <last_pid.1812>
ffffffffc0203a1e:	419c                	lw	a5,0(a1)
ffffffffc0203a20:	6709                	lui	a4,0x2
ffffffffc0203a22:	0017851b          	addiw	a0,a5,1
ffffffffc0203a26:	c188                	sw	a0,0(a1)
ffffffffc0203a28:	08e55b63          	bge	a0,a4,ffffffffc0203abe <do_fork+0x1dc>
ffffffffc0203a2c:	0000a897          	auipc	a7,0xa
ffffffffc0203a30:	66088893          	addi	a7,a7,1632 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203a34:	0008a783          	lw	a5,0(a7)
ffffffffc0203a38:	00016497          	auipc	s1,0x16
ffffffffc0203a3c:	d0048493          	addi	s1,s1,-768 # ffffffffc0219738 <proc_list>
ffffffffc0203a40:	08f55663          	bge	a0,a5,ffffffffc0203acc <do_fork+0x1ea>
ffffffffc0203a44:	c048                	sw	a0,4(s0)
ffffffffc0203a46:	45a9                	li	a1,10
ffffffffc0203a48:	2501                	sext.w	a0,a0
ffffffffc0203a4a:	4d2040ef          	jal	ra,ffffffffc0207f1c <hash32>
ffffffffc0203a4e:	1502                	slli	a0,a0,0x20
ffffffffc0203a50:	00012797          	auipc	a5,0x12
ffffffffc0203a54:	a4078793          	addi	a5,a5,-1472 # ffffffffc0215490 <hash_list>
ffffffffc0203a58:	8171                	srli	a0,a0,0x1c
ffffffffc0203a5a:	953e                	add	a0,a0,a5
ffffffffc0203a5c:	650c                	ld	a1,8(a0)
ffffffffc0203a5e:	7014                	ld	a3,32(s0)
ffffffffc0203a60:	0d840793          	addi	a5,s0,216
ffffffffc0203a64:	e19c                	sd	a5,0(a1)
ffffffffc0203a66:	6490                	ld	a2,8(s1)
ffffffffc0203a68:	e51c                	sd	a5,8(a0)
ffffffffc0203a6a:	7af8                	ld	a4,240(a3)
ffffffffc0203a6c:	0c840793          	addi	a5,s0,200
ffffffffc0203a70:	f06c                	sd	a1,224(s0)
ffffffffc0203a72:	ec68                	sd	a0,216(s0)
ffffffffc0203a74:	e21c                	sd	a5,0(a2)
ffffffffc0203a76:	e49c                	sd	a5,8(s1)
ffffffffc0203a78:	e870                	sd	a2,208(s0)
ffffffffc0203a7a:	e464                	sd	s1,200(s0)
ffffffffc0203a7c:	0e043c23          	sd	zero,248(s0)
ffffffffc0203a80:	10e43023          	sd	a4,256(s0)
ffffffffc0203a84:	c311                	beqz	a4,ffffffffc0203a88 <do_fork+0x1a6>
ffffffffc0203a86:	ff60                	sd	s0,248(a4)
ffffffffc0203a88:	0009a783          	lw	a5,0(s3)
ffffffffc0203a8c:	fae0                	sd	s0,240(a3)
ffffffffc0203a8e:	2785                	addiw	a5,a5,1
ffffffffc0203a90:	00f9a023          	sw	a5,0(s3)
ffffffffc0203a94:	10091863          	bnez	s2,ffffffffc0203ba4 <do_fork+0x2c2>
ffffffffc0203a98:	8522                	mv	a0,s0
ffffffffc0203a9a:	733000ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc0203a9e:	4048                	lw	a0,4(s0)
ffffffffc0203aa0:	70a6                	ld	ra,104(sp)
ffffffffc0203aa2:	7406                	ld	s0,96(sp)
ffffffffc0203aa4:	64e6                	ld	s1,88(sp)
ffffffffc0203aa6:	6946                	ld	s2,80(sp)
ffffffffc0203aa8:	69a6                	ld	s3,72(sp)
ffffffffc0203aaa:	6a06                	ld	s4,64(sp)
ffffffffc0203aac:	7ae2                	ld	s5,56(sp)
ffffffffc0203aae:	7b42                	ld	s6,48(sp)
ffffffffc0203ab0:	7ba2                	ld	s7,40(sp)
ffffffffc0203ab2:	7c02                	ld	s8,32(sp)
ffffffffc0203ab4:	6ce2                	ld	s9,24(sp)
ffffffffc0203ab6:	6d42                	ld	s10,16(sp)
ffffffffc0203ab8:	6da2                	ld	s11,8(sp)
ffffffffc0203aba:	6165                	addi	sp,sp,112
ffffffffc0203abc:	8082                	ret
ffffffffc0203abe:	4785                	li	a5,1
ffffffffc0203ac0:	c19c                	sw	a5,0(a1)
ffffffffc0203ac2:	4505                	li	a0,1
ffffffffc0203ac4:	0000a897          	auipc	a7,0xa
ffffffffc0203ac8:	5c888893          	addi	a7,a7,1480 # ffffffffc020e08c <next_safe.1811>
ffffffffc0203acc:	00016497          	auipc	s1,0x16
ffffffffc0203ad0:	c6c48493          	addi	s1,s1,-916 # ffffffffc0219738 <proc_list>
ffffffffc0203ad4:	0084b303          	ld	t1,8(s1)
ffffffffc0203ad8:	6789                	lui	a5,0x2
ffffffffc0203ada:	00f8a023          	sw	a5,0(a7)
ffffffffc0203ade:	4801                	li	a6,0
ffffffffc0203ae0:	87aa                	mv	a5,a0
ffffffffc0203ae2:	6e89                	lui	t4,0x2
ffffffffc0203ae4:	12930e63          	beq	t1,s1,ffffffffc0203c20 <do_fork+0x33e>
ffffffffc0203ae8:	8e42                	mv	t3,a6
ffffffffc0203aea:	869a                	mv	a3,t1
ffffffffc0203aec:	6609                	lui	a2,0x2
ffffffffc0203aee:	a811                	j	ffffffffc0203b02 <do_fork+0x220>
ffffffffc0203af0:	00e7d663          	bge	a5,a4,ffffffffc0203afc <do_fork+0x21a>
ffffffffc0203af4:	00c75463          	bge	a4,a2,ffffffffc0203afc <do_fork+0x21a>
ffffffffc0203af8:	863a                	mv	a2,a4
ffffffffc0203afa:	4e05                	li	t3,1
ffffffffc0203afc:	6694                	ld	a3,8(a3)
ffffffffc0203afe:	00968d63          	beq	a3,s1,ffffffffc0203b18 <do_fork+0x236>
ffffffffc0203b02:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <kern_entry-0xc4>
ffffffffc0203b06:	fef715e3          	bne	a4,a5,ffffffffc0203af0 <do_fork+0x20e>
ffffffffc0203b0a:	2785                	addiw	a5,a5,1
ffffffffc0203b0c:	08c7df63          	bge	a5,a2,ffffffffc0203baa <do_fork+0x2c8>
ffffffffc0203b10:	6694                	ld	a3,8(a3)
ffffffffc0203b12:	4805                	li	a6,1
ffffffffc0203b14:	fe9697e3          	bne	a3,s1,ffffffffc0203b02 <do_fork+0x220>
ffffffffc0203b18:	00080463          	beqz	a6,ffffffffc0203b20 <do_fork+0x23e>
ffffffffc0203b1c:	c19c                	sw	a5,0(a1)
ffffffffc0203b1e:	853e                	mv	a0,a5
ffffffffc0203b20:	f20e02e3          	beqz	t3,ffffffffc0203a44 <do_fork+0x162>
ffffffffc0203b24:	00c8a023          	sw	a2,0(a7)
ffffffffc0203b28:	bf31                	j	ffffffffc0203a44 <do_fork+0x162>
ffffffffc0203b2a:	6909                	lui	s2,0x2
ffffffffc0203b2c:	edc90913          	addi	s2,s2,-292 # 1edc <kern_entry-0xffffffffc01fe124>
ffffffffc0203b30:	9936                	add	s2,s2,a3
ffffffffc0203b32:	0127b823          	sd	s2,16(a5) # 2010 <kern_entry-0xffffffffc01fdff0>
ffffffffc0203b36:	00000717          	auipc	a4,0x0
ffffffffc0203b3a:	c2e70713          	addi	a4,a4,-978 # ffffffffc0203764 <forkret>
ffffffffc0203b3e:	f818                	sd	a4,48(s0)
ffffffffc0203b40:	fc1c                	sd	a5,56(s0)
ffffffffc0203b42:	100027f3          	csrr	a5,sstatus
ffffffffc0203b46:	8b89                	andi	a5,a5,2
ffffffffc0203b48:	4901                	li	s2,0
ffffffffc0203b4a:	ec0786e3          	beqz	a5,ffffffffc0203a16 <do_fork+0x134>
ffffffffc0203b4e:	aebfc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203b52:	4905                	li	s2,1
ffffffffc0203b54:	b5c9                	j	ffffffffc0203a16 <do_fork+0x134>
ffffffffc0203b56:	fd1fd0ef          	jal	ra,ffffffffc0201b26 <mm_create>
ffffffffc0203b5a:	8a2a                	mv	s4,a0
ffffffffc0203b5c:	c901                	beqz	a0,ffffffffc0203b6c <do_fork+0x28a>
ffffffffc0203b5e:	0561                	addi	a0,a0,24
ffffffffc0203b60:	c13ff0ef          	jal	ra,ffffffffc0203772 <setup_pgdir.isra.0>
ffffffffc0203b64:	c921                	beqz	a0,ffffffffc0203bb4 <do_fork+0x2d2>
ffffffffc0203b66:	8552                	mv	a0,s4
ffffffffc0203b68:	91cfe0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203b6c:	6814                	ld	a3,16(s0)
ffffffffc0203b6e:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b72:	12f6e563          	bltu	a3,a5,ffffffffc0203c9c <do_fork+0x3ba>
ffffffffc0203b76:	000d3783          	ld	a5,0(s10)
ffffffffc0203b7a:	000cb703          	ld	a4,0(s9)
ffffffffc0203b7e:	40f687b3          	sub	a5,a3,a5
ffffffffc0203b82:	83b1                	srli	a5,a5,0xc
ffffffffc0203b84:	10e7f063          	bgeu	a5,a4,ffffffffc0203c84 <do_fork+0x3a2>
ffffffffc0203b88:	000c3503          	ld	a0,0(s8)
ffffffffc0203b8c:	415787b3          	sub	a5,a5,s5
ffffffffc0203b90:	079a                	slli	a5,a5,0x6
ffffffffc0203b92:	4589                	li	a1,2
ffffffffc0203b94:	953e                	add	a0,a0,a5
ffffffffc0203b96:	a46fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203b9a:	8522                	mv	a0,s0
ffffffffc0203b9c:	f40fe0ef          	jal	ra,ffffffffc02022dc <kfree>
ffffffffc0203ba0:	5571                	li	a0,-4
ffffffffc0203ba2:	bdfd                	j	ffffffffc0203aa0 <do_fork+0x1be>
ffffffffc0203ba4:	a8ffc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203ba8:	bdc5                	j	ffffffffc0203a98 <do_fork+0x1b6>
ffffffffc0203baa:	01d7c363          	blt	a5,t4,ffffffffc0203bb0 <do_fork+0x2ce>
ffffffffc0203bae:	4785                	li	a5,1
ffffffffc0203bb0:	4805                	li	a6,1
ffffffffc0203bb2:	bf0d                	j	ffffffffc0203ae4 <do_fork+0x202>
ffffffffc0203bb4:	038b0d93          	addi	s11,s6,56
ffffffffc0203bb8:	856e                	mv	a0,s11
ffffffffc0203bba:	941ff0ef          	jal	ra,ffffffffc02034fa <down>
ffffffffc0203bbe:	000bb783          	ld	a5,0(s7)
ffffffffc0203bc2:	c781                	beqz	a5,ffffffffc0203bca <do_fork+0x2e8>
ffffffffc0203bc4:	43dc                	lw	a5,4(a5)
ffffffffc0203bc6:	04fb2823          	sw	a5,80(s6)
ffffffffc0203bca:	85da                	mv	a1,s6
ffffffffc0203bcc:	8552                	mv	a0,s4
ffffffffc0203bce:	9b6fe0ef          	jal	ra,ffffffffc0201d84 <dup_mmap>
ffffffffc0203bd2:	8baa                	mv	s7,a0
ffffffffc0203bd4:	856e                	mv	a0,s11
ffffffffc0203bd6:	923ff0ef          	jal	ra,ffffffffc02034f8 <up>
ffffffffc0203bda:	040b2823          	sw	zero,80(s6)
ffffffffc0203bde:	8b52                	mv	s6,s4
ffffffffc0203be0:	da0b8ce3          	beqz	s7,ffffffffc0203998 <do_fork+0xb6>
ffffffffc0203be4:	8552                	mv	a0,s4
ffffffffc0203be6:	a38fe0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc0203bea:	018a3683          	ld	a3,24(s4)
ffffffffc0203bee:	c02007b7          	lui	a5,0xc0200
ffffffffc0203bf2:	0af6e563          	bltu	a3,a5,ffffffffc0203c9c <do_fork+0x3ba>
ffffffffc0203bf6:	000d3703          	ld	a4,0(s10)
ffffffffc0203bfa:	000cb783          	ld	a5,0(s9)
ffffffffc0203bfe:	8e99                	sub	a3,a3,a4
ffffffffc0203c00:	82b1                	srli	a3,a3,0xc
ffffffffc0203c02:	08f6f163          	bgeu	a3,a5,ffffffffc0203c84 <do_fork+0x3a2>
ffffffffc0203c06:	000c3503          	ld	a0,0(s8)
ffffffffc0203c0a:	415686b3          	sub	a3,a3,s5
ffffffffc0203c0e:	069a                	slli	a3,a3,0x6
ffffffffc0203c10:	9536                	add	a0,a0,a3
ffffffffc0203c12:	4585                	li	a1,1
ffffffffc0203c14:	9c8fd0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203c18:	8552                	mv	a0,s4
ffffffffc0203c1a:	86afe0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203c1e:	b7b9                	j	ffffffffc0203b6c <do_fork+0x28a>
ffffffffc0203c20:	00080763          	beqz	a6,ffffffffc0203c2e <do_fork+0x34c>
ffffffffc0203c24:	c19c                	sw	a5,0(a1)
ffffffffc0203c26:	853e                	mv	a0,a5
ffffffffc0203c28:	bd31                	j	ffffffffc0203a44 <do_fork+0x162>
ffffffffc0203c2a:	556d                	li	a0,-5
ffffffffc0203c2c:	bd95                	j	ffffffffc0203aa0 <do_fork+0x1be>
ffffffffc0203c2e:	4188                	lw	a0,0(a1)
ffffffffc0203c30:	bd11                	j	ffffffffc0203a44 <do_fork+0x162>
ffffffffc0203c32:	00005617          	auipc	a2,0x5
ffffffffc0203c36:	d6660613          	addi	a2,a2,-666 # ffffffffc0208998 <commands+0x7c0>
ffffffffc0203c3a:	06900593          	li	a1,105
ffffffffc0203c3e:	00005517          	auipc	a0,0x5
ffffffffc0203c42:	cba50513          	addi	a0,a0,-838 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203c46:	dc2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c4a:	00006697          	auipc	a3,0x6
ffffffffc0203c4e:	92668693          	addi	a3,a3,-1754 # ffffffffc0209570 <default_pmm_manager+0x248>
ffffffffc0203c52:	00005617          	auipc	a2,0x5
ffffffffc0203c56:	99660613          	addi	a2,a2,-1642 # ffffffffc02085e8 <commands+0x410>
ffffffffc0203c5a:	1a600593          	li	a1,422
ffffffffc0203c5e:	00006517          	auipc	a0,0x6
ffffffffc0203c62:	93250513          	addi	a0,a0,-1742 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203c66:	da2fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c6a:	86be                	mv	a3,a5
ffffffffc0203c6c:	00005617          	auipc	a2,0x5
ffffffffc0203c70:	cf460613          	addi	a2,a2,-780 # ffffffffc0208960 <commands+0x788>
ffffffffc0203c74:	15900593          	li	a1,345
ffffffffc0203c78:	00006517          	auipc	a0,0x6
ffffffffc0203c7c:	91850513          	addi	a0,a0,-1768 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203c80:	d88fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c84:	00005617          	auipc	a2,0x5
ffffffffc0203c88:	c5460613          	addi	a2,a2,-940 # ffffffffc02088d8 <commands+0x700>
ffffffffc0203c8c:	06200593          	li	a1,98
ffffffffc0203c90:	00005517          	auipc	a0,0x5
ffffffffc0203c94:	c6850513          	addi	a0,a0,-920 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203c98:	d70fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203c9c:	00005617          	auipc	a2,0x5
ffffffffc0203ca0:	cc460613          	addi	a2,a2,-828 # ffffffffc0208960 <commands+0x788>
ffffffffc0203ca4:	06e00593          	li	a1,110
ffffffffc0203ca8:	00005517          	auipc	a0,0x5
ffffffffc0203cac:	c5050513          	addi	a0,a0,-944 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203cb0:	d58fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203cb4 <kernel_thread>:
ffffffffc0203cb4:	7129                	addi	sp,sp,-320
ffffffffc0203cb6:	fa22                	sd	s0,304(sp)
ffffffffc0203cb8:	f626                	sd	s1,296(sp)
ffffffffc0203cba:	f24a                	sd	s2,288(sp)
ffffffffc0203cbc:	84ae                	mv	s1,a1
ffffffffc0203cbe:	892a                	mv	s2,a0
ffffffffc0203cc0:	8432                	mv	s0,a2
ffffffffc0203cc2:	4581                	li	a1,0
ffffffffc0203cc4:	12000613          	li	a2,288
ffffffffc0203cc8:	850a                	mv	a0,sp
ffffffffc0203cca:	fe06                	sd	ra,312(sp)
ffffffffc0203ccc:	639030ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc0203cd0:	e0ca                	sd	s2,64(sp)
ffffffffc0203cd2:	e4a6                	sd	s1,72(sp)
ffffffffc0203cd4:	100027f3          	csrr	a5,sstatus
ffffffffc0203cd8:	edd7f793          	andi	a5,a5,-291
ffffffffc0203cdc:	1207e793          	ori	a5,a5,288
ffffffffc0203ce0:	e23e                	sd	a5,256(sp)
ffffffffc0203ce2:	860a                	mv	a2,sp
ffffffffc0203ce4:	10046513          	ori	a0,s0,256
ffffffffc0203ce8:	00000797          	auipc	a5,0x0
ffffffffc0203cec:	99878793          	addi	a5,a5,-1640 # ffffffffc0203680 <kernel_thread_entry>
ffffffffc0203cf0:	4581                	li	a1,0
ffffffffc0203cf2:	e63e                	sd	a5,264(sp)
ffffffffc0203cf4:	befff0ef          	jal	ra,ffffffffc02038e2 <do_fork>
ffffffffc0203cf8:	70f2                	ld	ra,312(sp)
ffffffffc0203cfa:	7452                	ld	s0,304(sp)
ffffffffc0203cfc:	74b2                	ld	s1,296(sp)
ffffffffc0203cfe:	7912                	ld	s2,288(sp)
ffffffffc0203d00:	6131                	addi	sp,sp,320
ffffffffc0203d02:	8082                	ret

ffffffffc0203d04 <do_exit>:
ffffffffc0203d04:	7179                	addi	sp,sp,-48
ffffffffc0203d06:	f022                	sd	s0,32(sp)
ffffffffc0203d08:	00015417          	auipc	s0,0x15
ffffffffc0203d0c:	7f040413          	addi	s0,s0,2032 # ffffffffc02194f8 <current>
ffffffffc0203d10:	601c                	ld	a5,0(s0)
ffffffffc0203d12:	f406                	sd	ra,40(sp)
ffffffffc0203d14:	ec26                	sd	s1,24(sp)
ffffffffc0203d16:	e84a                	sd	s2,16(sp)
ffffffffc0203d18:	e44e                	sd	s3,8(sp)
ffffffffc0203d1a:	e052                	sd	s4,0(sp)
ffffffffc0203d1c:	00015717          	auipc	a4,0x15
ffffffffc0203d20:	7e473703          	ld	a4,2020(a4) # ffffffffc0219500 <idleproc>
ffffffffc0203d24:	0ce78d63          	beq	a5,a4,ffffffffc0203dfe <do_exit+0xfa>
ffffffffc0203d28:	00015497          	auipc	s1,0x15
ffffffffc0203d2c:	7e048493          	addi	s1,s1,2016 # ffffffffc0219508 <initproc>
ffffffffc0203d30:	6098                	ld	a4,0(s1)
ffffffffc0203d32:	12e78963          	beq	a5,a4,ffffffffc0203e64 <do_exit+0x160>
ffffffffc0203d36:	0287b903          	ld	s2,40(a5)
ffffffffc0203d3a:	89aa                	mv	s3,a0
ffffffffc0203d3c:	02090663          	beqz	s2,ffffffffc0203d68 <do_exit+0x64>
ffffffffc0203d40:	00016797          	auipc	a5,0x16
ffffffffc0203d44:	8007b783          	ld	a5,-2048(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc0203d48:	577d                	li	a4,-1
ffffffffc0203d4a:	177e                	slli	a4,a4,0x3f
ffffffffc0203d4c:	83b1                	srli	a5,a5,0xc
ffffffffc0203d4e:	8fd9                	or	a5,a5,a4
ffffffffc0203d50:	18079073          	csrw	satp,a5
ffffffffc0203d54:	03092783          	lw	a5,48(s2)
ffffffffc0203d58:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203d5c:	02e92823          	sw	a4,48(s2)
ffffffffc0203d60:	cb5d                	beqz	a4,ffffffffc0203e16 <do_exit+0x112>
ffffffffc0203d62:	601c                	ld	a5,0(s0)
ffffffffc0203d64:	0207b423          	sd	zero,40(a5)
ffffffffc0203d68:	601c                	ld	a5,0(s0)
ffffffffc0203d6a:	470d                	li	a4,3
ffffffffc0203d6c:	c398                	sw	a4,0(a5)
ffffffffc0203d6e:	0f37a423          	sw	s3,232(a5)
ffffffffc0203d72:	100027f3          	csrr	a5,sstatus
ffffffffc0203d76:	8b89                	andi	a5,a5,2
ffffffffc0203d78:	4a01                	li	s4,0
ffffffffc0203d7a:	10079163          	bnez	a5,ffffffffc0203e7c <do_exit+0x178>
ffffffffc0203d7e:	6018                	ld	a4,0(s0)
ffffffffc0203d80:	800007b7          	lui	a5,0x80000
ffffffffc0203d84:	0785                	addi	a5,a5,1
ffffffffc0203d86:	7308                	ld	a0,32(a4)
ffffffffc0203d88:	0ec52703          	lw	a4,236(a0)
ffffffffc0203d8c:	0ef70c63          	beq	a4,a5,ffffffffc0203e84 <do_exit+0x180>
ffffffffc0203d90:	6018                	ld	a4,0(s0)
ffffffffc0203d92:	7b7c                	ld	a5,240(a4)
ffffffffc0203d94:	c3a1                	beqz	a5,ffffffffc0203dd4 <do_exit+0xd0>
ffffffffc0203d96:	800009b7          	lui	s3,0x80000
ffffffffc0203d9a:	490d                	li	s2,3
ffffffffc0203d9c:	0985                	addi	s3,s3,1
ffffffffc0203d9e:	a021                	j	ffffffffc0203da6 <do_exit+0xa2>
ffffffffc0203da0:	6018                	ld	a4,0(s0)
ffffffffc0203da2:	7b7c                	ld	a5,240(a4)
ffffffffc0203da4:	cb85                	beqz	a5,ffffffffc0203dd4 <do_exit+0xd0>
ffffffffc0203da6:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <kern_entry-0x401fff00>
ffffffffc0203daa:	6088                	ld	a0,0(s1)
ffffffffc0203dac:	fb74                	sd	a3,240(a4)
ffffffffc0203dae:	7978                	ld	a4,240(a0)
ffffffffc0203db0:	0e07bc23          	sd	zero,248(a5)
ffffffffc0203db4:	10e7b023          	sd	a4,256(a5)
ffffffffc0203db8:	c311                	beqz	a4,ffffffffc0203dbc <do_exit+0xb8>
ffffffffc0203dba:	ff7c                	sd	a5,248(a4)
ffffffffc0203dbc:	4398                	lw	a4,0(a5)
ffffffffc0203dbe:	f388                	sd	a0,32(a5)
ffffffffc0203dc0:	f97c                	sd	a5,240(a0)
ffffffffc0203dc2:	fd271fe3          	bne	a4,s2,ffffffffc0203da0 <do_exit+0x9c>
ffffffffc0203dc6:	0ec52783          	lw	a5,236(a0)
ffffffffc0203dca:	fd379be3          	bne	a5,s3,ffffffffc0203da0 <do_exit+0x9c>
ffffffffc0203dce:	3ff000ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc0203dd2:	b7f9                	j	ffffffffc0203da0 <do_exit+0x9c>
ffffffffc0203dd4:	020a1263          	bnez	s4,ffffffffc0203df8 <do_exit+0xf4>
ffffffffc0203dd8:	4a7000ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc0203ddc:	601c                	ld	a5,0(s0)
ffffffffc0203dde:	00005617          	auipc	a2,0x5
ffffffffc0203de2:	7ea60613          	addi	a2,a2,2026 # ffffffffc02095c8 <default_pmm_manager+0x2a0>
ffffffffc0203de6:	1f900593          	li	a1,505
ffffffffc0203dea:	43d4                	lw	a3,4(a5)
ffffffffc0203dec:	00005517          	auipc	a0,0x5
ffffffffc0203df0:	7a450513          	addi	a0,a0,1956 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203df4:	c14fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203df8:	83bfc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203dfc:	bff1                	j	ffffffffc0203dd8 <do_exit+0xd4>
ffffffffc0203dfe:	00005617          	auipc	a2,0x5
ffffffffc0203e02:	7aa60613          	addi	a2,a2,1962 # ffffffffc02095a8 <default_pmm_manager+0x280>
ffffffffc0203e06:	1cd00593          	li	a1,461
ffffffffc0203e0a:	00005517          	auipc	a0,0x5
ffffffffc0203e0e:	78650513          	addi	a0,a0,1926 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203e12:	bf6fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e16:	854a                	mv	a0,s2
ffffffffc0203e18:	806fe0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc0203e1c:	01893683          	ld	a3,24(s2)
ffffffffc0203e20:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e24:	06f6e363          	bltu	a3,a5,ffffffffc0203e8a <do_exit+0x186>
ffffffffc0203e28:	00015797          	auipc	a5,0x15
ffffffffc0203e2c:	7107b783          	ld	a5,1808(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203e30:	8e9d                	sub	a3,a3,a5
ffffffffc0203e32:	82b1                	srli	a3,a3,0xc
ffffffffc0203e34:	00015797          	auipc	a5,0x15
ffffffffc0203e38:	69c7b783          	ld	a5,1692(a5) # ffffffffc02194d0 <npage>
ffffffffc0203e3c:	06f6f363          	bgeu	a3,a5,ffffffffc0203ea2 <do_exit+0x19e>
ffffffffc0203e40:	00006517          	auipc	a0,0x6
ffffffffc0203e44:	7f053503          	ld	a0,2032(a0) # ffffffffc020a630 <nbase>
ffffffffc0203e48:	8e89                	sub	a3,a3,a0
ffffffffc0203e4a:	069a                	slli	a3,a3,0x6
ffffffffc0203e4c:	00015517          	auipc	a0,0x15
ffffffffc0203e50:	6fc53503          	ld	a0,1788(a0) # ffffffffc0219548 <pages>
ffffffffc0203e54:	9536                	add	a0,a0,a3
ffffffffc0203e56:	4585                	li	a1,1
ffffffffc0203e58:	f85fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203e5c:	854a                	mv	a0,s2
ffffffffc0203e5e:	e27fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0203e62:	b701                	j	ffffffffc0203d62 <do_exit+0x5e>
ffffffffc0203e64:	00005617          	auipc	a2,0x5
ffffffffc0203e68:	75460613          	addi	a2,a2,1876 # ffffffffc02095b8 <default_pmm_manager+0x290>
ffffffffc0203e6c:	1d000593          	li	a1,464
ffffffffc0203e70:	00005517          	auipc	a0,0x5
ffffffffc0203e74:	72050513          	addi	a0,a0,1824 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0203e78:	b90fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203e7c:	fbcfc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0203e80:	4a05                	li	s4,1
ffffffffc0203e82:	bdf5                	j	ffffffffc0203d7e <do_exit+0x7a>
ffffffffc0203e84:	349000ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc0203e88:	b721                	j	ffffffffc0203d90 <do_exit+0x8c>
ffffffffc0203e8a:	00005617          	auipc	a2,0x5
ffffffffc0203e8e:	ad660613          	addi	a2,a2,-1322 # ffffffffc0208960 <commands+0x788>
ffffffffc0203e92:	06e00593          	li	a1,110
ffffffffc0203e96:	00005517          	auipc	a0,0x5
ffffffffc0203e9a:	a6250513          	addi	a0,a0,-1438 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203e9e:	b6afc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0203ea2:	00005617          	auipc	a2,0x5
ffffffffc0203ea6:	a3660613          	addi	a2,a2,-1482 # ffffffffc02088d8 <commands+0x700>
ffffffffc0203eaa:	06200593          	li	a1,98
ffffffffc0203eae:	00005517          	auipc	a0,0x5
ffffffffc0203eb2:	a4a50513          	addi	a0,a0,-1462 # ffffffffc02088f8 <commands+0x720>
ffffffffc0203eb6:	b52fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0203eba <do_wait.part.0>:
ffffffffc0203eba:	7139                	addi	sp,sp,-64
ffffffffc0203ebc:	e852                	sd	s4,16(sp)
ffffffffc0203ebe:	80000a37          	lui	s4,0x80000
ffffffffc0203ec2:	f426                	sd	s1,40(sp)
ffffffffc0203ec4:	f04a                	sd	s2,32(sp)
ffffffffc0203ec6:	ec4e                	sd	s3,24(sp)
ffffffffc0203ec8:	e456                	sd	s5,8(sp)
ffffffffc0203eca:	e05a                	sd	s6,0(sp)
ffffffffc0203ecc:	fc06                	sd	ra,56(sp)
ffffffffc0203ece:	f822                	sd	s0,48(sp)
ffffffffc0203ed0:	892a                	mv	s2,a0
ffffffffc0203ed2:	8aae                	mv	s5,a1
ffffffffc0203ed4:	00015997          	auipc	s3,0x15
ffffffffc0203ed8:	62498993          	addi	s3,s3,1572 # ffffffffc02194f8 <current>
ffffffffc0203edc:	448d                	li	s1,3
ffffffffc0203ede:	4b05                	li	s6,1
ffffffffc0203ee0:	2a05                	addiw	s4,s4,1
ffffffffc0203ee2:	02090f63          	beqz	s2,ffffffffc0203f20 <do_wait.part.0+0x66>
ffffffffc0203ee6:	854a                	mv	a0,s2
ffffffffc0203ee8:	9a3ff0ef          	jal	ra,ffffffffc020388a <find_proc>
ffffffffc0203eec:	842a                	mv	s0,a0
ffffffffc0203eee:	10050763          	beqz	a0,ffffffffc0203ffc <do_wait.part.0+0x142>
ffffffffc0203ef2:	0009b703          	ld	a4,0(s3)
ffffffffc0203ef6:	711c                	ld	a5,32(a0)
ffffffffc0203ef8:	10e79263          	bne	a5,a4,ffffffffc0203ffc <do_wait.part.0+0x142>
ffffffffc0203efc:	411c                	lw	a5,0(a0)
ffffffffc0203efe:	02978c63          	beq	a5,s1,ffffffffc0203f36 <do_wait.part.0+0x7c>
ffffffffc0203f02:	01672023          	sw	s6,0(a4)
ffffffffc0203f06:	0f472623          	sw	s4,236(a4)
ffffffffc0203f0a:	375000ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc0203f0e:	0009b783          	ld	a5,0(s3)
ffffffffc0203f12:	0b07a783          	lw	a5,176(a5)
ffffffffc0203f16:	8b85                	andi	a5,a5,1
ffffffffc0203f18:	d7e9                	beqz	a5,ffffffffc0203ee2 <do_wait.part.0+0x28>
ffffffffc0203f1a:	555d                	li	a0,-9
ffffffffc0203f1c:	de9ff0ef          	jal	ra,ffffffffc0203d04 <do_exit>
ffffffffc0203f20:	0009b703          	ld	a4,0(s3)
ffffffffc0203f24:	7b60                	ld	s0,240(a4)
ffffffffc0203f26:	e409                	bnez	s0,ffffffffc0203f30 <do_wait.part.0+0x76>
ffffffffc0203f28:	a8d1                	j	ffffffffc0203ffc <do_wait.part.0+0x142>
ffffffffc0203f2a:	10043403          	ld	s0,256(s0)
ffffffffc0203f2e:	d871                	beqz	s0,ffffffffc0203f02 <do_wait.part.0+0x48>
ffffffffc0203f30:	401c                	lw	a5,0(s0)
ffffffffc0203f32:	fe979ce3          	bne	a5,s1,ffffffffc0203f2a <do_wait.part.0+0x70>
ffffffffc0203f36:	00015797          	auipc	a5,0x15
ffffffffc0203f3a:	5ca7b783          	ld	a5,1482(a5) # ffffffffc0219500 <idleproc>
ffffffffc0203f3e:	0c878563          	beq	a5,s0,ffffffffc0204008 <do_wait.part.0+0x14e>
ffffffffc0203f42:	00015797          	auipc	a5,0x15
ffffffffc0203f46:	5c67b783          	ld	a5,1478(a5) # ffffffffc0219508 <initproc>
ffffffffc0203f4a:	0af40f63          	beq	s0,a5,ffffffffc0204008 <do_wait.part.0+0x14e>
ffffffffc0203f4e:	000a8663          	beqz	s5,ffffffffc0203f5a <do_wait.part.0+0xa0>
ffffffffc0203f52:	0e842783          	lw	a5,232(s0)
ffffffffc0203f56:	00faa023          	sw	a5,0(s5)
ffffffffc0203f5a:	100027f3          	csrr	a5,sstatus
ffffffffc0203f5e:	8b89                	andi	a5,a5,2
ffffffffc0203f60:	4581                	li	a1,0
ffffffffc0203f62:	efd9                	bnez	a5,ffffffffc0204000 <do_wait.part.0+0x146>
ffffffffc0203f64:	6c70                	ld	a2,216(s0)
ffffffffc0203f66:	7074                	ld	a3,224(s0)
ffffffffc0203f68:	10043703          	ld	a4,256(s0)
ffffffffc0203f6c:	7c7c                	ld	a5,248(s0)
ffffffffc0203f6e:	e614                	sd	a3,8(a2)
ffffffffc0203f70:	e290                	sd	a2,0(a3)
ffffffffc0203f72:	6470                	ld	a2,200(s0)
ffffffffc0203f74:	6874                	ld	a3,208(s0)
ffffffffc0203f76:	e614                	sd	a3,8(a2)
ffffffffc0203f78:	e290                	sd	a2,0(a3)
ffffffffc0203f7a:	c319                	beqz	a4,ffffffffc0203f80 <do_wait.part.0+0xc6>
ffffffffc0203f7c:	ff7c                	sd	a5,248(a4)
ffffffffc0203f7e:	7c7c                	ld	a5,248(s0)
ffffffffc0203f80:	cbbd                	beqz	a5,ffffffffc0203ff6 <do_wait.part.0+0x13c>
ffffffffc0203f82:	10e7b023          	sd	a4,256(a5)
ffffffffc0203f86:	00015717          	auipc	a4,0x15
ffffffffc0203f8a:	58a70713          	addi	a4,a4,1418 # ffffffffc0219510 <nr_process>
ffffffffc0203f8e:	431c                	lw	a5,0(a4)
ffffffffc0203f90:	37fd                	addiw	a5,a5,-1
ffffffffc0203f92:	c31c                	sw	a5,0(a4)
ffffffffc0203f94:	edb1                	bnez	a1,ffffffffc0203ff0 <do_wait.part.0+0x136>
ffffffffc0203f96:	6814                	ld	a3,16(s0)
ffffffffc0203f98:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f9c:	08f6ee63          	bltu	a3,a5,ffffffffc0204038 <do_wait.part.0+0x17e>
ffffffffc0203fa0:	00015797          	auipc	a5,0x15
ffffffffc0203fa4:	5987b783          	ld	a5,1432(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc0203fa8:	8e9d                	sub	a3,a3,a5
ffffffffc0203faa:	82b1                	srli	a3,a3,0xc
ffffffffc0203fac:	00015797          	auipc	a5,0x15
ffffffffc0203fb0:	5247b783          	ld	a5,1316(a5) # ffffffffc02194d0 <npage>
ffffffffc0203fb4:	06f6f663          	bgeu	a3,a5,ffffffffc0204020 <do_wait.part.0+0x166>
ffffffffc0203fb8:	00006517          	auipc	a0,0x6
ffffffffc0203fbc:	67853503          	ld	a0,1656(a0) # ffffffffc020a630 <nbase>
ffffffffc0203fc0:	8e89                	sub	a3,a3,a0
ffffffffc0203fc2:	069a                	slli	a3,a3,0x6
ffffffffc0203fc4:	00015517          	auipc	a0,0x15
ffffffffc0203fc8:	58453503          	ld	a0,1412(a0) # ffffffffc0219548 <pages>
ffffffffc0203fcc:	9536                	add	a0,a0,a3
ffffffffc0203fce:	4589                	li	a1,2
ffffffffc0203fd0:	e0dfc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0203fd4:	8522                	mv	a0,s0
ffffffffc0203fd6:	b06fe0ef          	jal	ra,ffffffffc02022dc <kfree>
ffffffffc0203fda:	4501                	li	a0,0
ffffffffc0203fdc:	70e2                	ld	ra,56(sp)
ffffffffc0203fde:	7442                	ld	s0,48(sp)
ffffffffc0203fe0:	74a2                	ld	s1,40(sp)
ffffffffc0203fe2:	7902                	ld	s2,32(sp)
ffffffffc0203fe4:	69e2                	ld	s3,24(sp)
ffffffffc0203fe6:	6a42                	ld	s4,16(sp)
ffffffffc0203fe8:	6aa2                	ld	s5,8(sp)
ffffffffc0203fea:	6b02                	ld	s6,0(sp)
ffffffffc0203fec:	6121                	addi	sp,sp,64
ffffffffc0203fee:	8082                	ret
ffffffffc0203ff0:	e42fc0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0203ff4:	b74d                	j	ffffffffc0203f96 <do_wait.part.0+0xdc>
ffffffffc0203ff6:	701c                	ld	a5,32(s0)
ffffffffc0203ff8:	fbf8                	sd	a4,240(a5)
ffffffffc0203ffa:	b771                	j	ffffffffc0203f86 <do_wait.part.0+0xcc>
ffffffffc0203ffc:	5579                	li	a0,-2
ffffffffc0203ffe:	bff9                	j	ffffffffc0203fdc <do_wait.part.0+0x122>
ffffffffc0204000:	e38fc0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204004:	4585                	li	a1,1
ffffffffc0204006:	bfb9                	j	ffffffffc0203f64 <do_wait.part.0+0xaa>
ffffffffc0204008:	00005617          	auipc	a2,0x5
ffffffffc020400c:	5e060613          	addi	a2,a2,1504 # ffffffffc02095e8 <default_pmm_manager+0x2c0>
ffffffffc0204010:	2f600593          	li	a1,758
ffffffffc0204014:	00005517          	auipc	a0,0x5
ffffffffc0204018:	57c50513          	addi	a0,a0,1404 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020401c:	9ecfc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204020:	00005617          	auipc	a2,0x5
ffffffffc0204024:	8b860613          	addi	a2,a2,-1864 # ffffffffc02088d8 <commands+0x700>
ffffffffc0204028:	06200593          	li	a1,98
ffffffffc020402c:	00005517          	auipc	a0,0x5
ffffffffc0204030:	8cc50513          	addi	a0,a0,-1844 # ffffffffc02088f8 <commands+0x720>
ffffffffc0204034:	9d4fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204038:	00005617          	auipc	a2,0x5
ffffffffc020403c:	92860613          	addi	a2,a2,-1752 # ffffffffc0208960 <commands+0x788>
ffffffffc0204040:	06e00593          	li	a1,110
ffffffffc0204044:	00005517          	auipc	a0,0x5
ffffffffc0204048:	8b450513          	addi	a0,a0,-1868 # ffffffffc02088f8 <commands+0x720>
ffffffffc020404c:	9bcfc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204050 <init_main>:
ffffffffc0204050:	1141                	addi	sp,sp,-16
ffffffffc0204052:	e406                	sd	ra,8(sp)
ffffffffc0204054:	dcbfc0ef          	jal	ra,ffffffffc0200e1e <nr_free_pages>
ffffffffc0204058:	9d0fe0ef          	jal	ra,ffffffffc0202228 <kallocated>
ffffffffc020405c:	9ccff0ef          	jal	ra,ffffffffc0203228 <check_sync>
ffffffffc0204060:	a019                	j	ffffffffc0204066 <init_main+0x16>
ffffffffc0204062:	21d000ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc0204066:	4581                	li	a1,0
ffffffffc0204068:	4501                	li	a0,0
ffffffffc020406a:	e51ff0ef          	jal	ra,ffffffffc0203eba <do_wait.part.0>
ffffffffc020406e:	d975                	beqz	a0,ffffffffc0204062 <init_main+0x12>
ffffffffc0204070:	00005517          	auipc	a0,0x5
ffffffffc0204074:	59850513          	addi	a0,a0,1432 # ffffffffc0209608 <default_pmm_manager+0x2e0>
ffffffffc0204078:	854fc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc020407c:	00015797          	auipc	a5,0x15
ffffffffc0204080:	48c7b783          	ld	a5,1164(a5) # ffffffffc0219508 <initproc>
ffffffffc0204084:	7bf8                	ld	a4,240(a5)
ffffffffc0204086:	e339                	bnez	a4,ffffffffc02040cc <init_main+0x7c>
ffffffffc0204088:	7ff8                	ld	a4,248(a5)
ffffffffc020408a:	e329                	bnez	a4,ffffffffc02040cc <init_main+0x7c>
ffffffffc020408c:	1007b703          	ld	a4,256(a5)
ffffffffc0204090:	ef15                	bnez	a4,ffffffffc02040cc <init_main+0x7c>
ffffffffc0204092:	00015697          	auipc	a3,0x15
ffffffffc0204096:	47e6a683          	lw	a3,1150(a3) # ffffffffc0219510 <nr_process>
ffffffffc020409a:	4709                	li	a4,2
ffffffffc020409c:	08e69863          	bne	a3,a4,ffffffffc020412c <init_main+0xdc>
ffffffffc02040a0:	00015717          	auipc	a4,0x15
ffffffffc02040a4:	69870713          	addi	a4,a4,1688 # ffffffffc0219738 <proc_list>
ffffffffc02040a8:	6714                	ld	a3,8(a4)
ffffffffc02040aa:	0c878793          	addi	a5,a5,200
ffffffffc02040ae:	04d79f63          	bne	a5,a3,ffffffffc020410c <init_main+0xbc>
ffffffffc02040b2:	6318                	ld	a4,0(a4)
ffffffffc02040b4:	02e79c63          	bne	a5,a4,ffffffffc02040ec <init_main+0x9c>
ffffffffc02040b8:	00005517          	auipc	a0,0x5
ffffffffc02040bc:	63850513          	addi	a0,a0,1592 # ffffffffc02096f0 <default_pmm_manager+0x3c8>
ffffffffc02040c0:	80cfc0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02040c4:	60a2                	ld	ra,8(sp)
ffffffffc02040c6:	4501                	li	a0,0
ffffffffc02040c8:	0141                	addi	sp,sp,16
ffffffffc02040ca:	8082                	ret
ffffffffc02040cc:	00005697          	auipc	a3,0x5
ffffffffc02040d0:	56468693          	addi	a3,a3,1380 # ffffffffc0209630 <default_pmm_manager+0x308>
ffffffffc02040d4:	00004617          	auipc	a2,0x4
ffffffffc02040d8:	51460613          	addi	a2,a2,1300 # ffffffffc02085e8 <commands+0x410>
ffffffffc02040dc:	35f00593          	li	a1,863
ffffffffc02040e0:	00005517          	auipc	a0,0x5
ffffffffc02040e4:	4b050513          	addi	a0,a0,1200 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02040e8:	920fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02040ec:	00005697          	auipc	a3,0x5
ffffffffc02040f0:	5d468693          	addi	a3,a3,1492 # ffffffffc02096c0 <default_pmm_manager+0x398>
ffffffffc02040f4:	00004617          	auipc	a2,0x4
ffffffffc02040f8:	4f460613          	addi	a2,a2,1268 # ffffffffc02085e8 <commands+0x410>
ffffffffc02040fc:	36200593          	li	a1,866
ffffffffc0204100:	00005517          	auipc	a0,0x5
ffffffffc0204104:	49050513          	addi	a0,a0,1168 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204108:	900fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020410c:	00005697          	auipc	a3,0x5
ffffffffc0204110:	58468693          	addi	a3,a3,1412 # ffffffffc0209690 <default_pmm_manager+0x368>
ffffffffc0204114:	00004617          	auipc	a2,0x4
ffffffffc0204118:	4d460613          	addi	a2,a2,1236 # ffffffffc02085e8 <commands+0x410>
ffffffffc020411c:	36100593          	li	a1,865
ffffffffc0204120:	00005517          	auipc	a0,0x5
ffffffffc0204124:	47050513          	addi	a0,a0,1136 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204128:	8e0fc0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020412c:	00005697          	auipc	a3,0x5
ffffffffc0204130:	55468693          	addi	a3,a3,1364 # ffffffffc0209680 <default_pmm_manager+0x358>
ffffffffc0204134:	00004617          	auipc	a2,0x4
ffffffffc0204138:	4b460613          	addi	a2,a2,1204 # ffffffffc02085e8 <commands+0x410>
ffffffffc020413c:	36000593          	li	a1,864
ffffffffc0204140:	00005517          	auipc	a0,0x5
ffffffffc0204144:	45050513          	addi	a0,a0,1104 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204148:	8c0fc0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc020414c <do_execve>:
ffffffffc020414c:	7135                	addi	sp,sp,-160
ffffffffc020414e:	f4d6                	sd	s5,104(sp)
ffffffffc0204150:	00015a97          	auipc	s5,0x15
ffffffffc0204154:	3a8a8a93          	addi	s5,s5,936 # ffffffffc02194f8 <current>
ffffffffc0204158:	000ab783          	ld	a5,0(s5)
ffffffffc020415c:	f8d2                	sd	s4,112(sp)
ffffffffc020415e:	e526                	sd	s1,136(sp)
ffffffffc0204160:	0287ba03          	ld	s4,40(a5)
ffffffffc0204164:	e14a                	sd	s2,128(sp)
ffffffffc0204166:	fcce                	sd	s3,120(sp)
ffffffffc0204168:	892a                	mv	s2,a0
ffffffffc020416a:	84ae                	mv	s1,a1
ffffffffc020416c:	89b2                	mv	s3,a2
ffffffffc020416e:	4681                	li	a3,0
ffffffffc0204170:	862e                	mv	a2,a1
ffffffffc0204172:	85aa                	mv	a1,a0
ffffffffc0204174:	8552                	mv	a0,s4
ffffffffc0204176:	ed06                	sd	ra,152(sp)
ffffffffc0204178:	e922                	sd	s0,144(sp)
ffffffffc020417a:	f0da                	sd	s6,96(sp)
ffffffffc020417c:	ecde                	sd	s7,88(sp)
ffffffffc020417e:	e8e2                	sd	s8,80(sp)
ffffffffc0204180:	e4e6                	sd	s9,72(sp)
ffffffffc0204182:	e0ea                	sd	s10,64(sp)
ffffffffc0204184:	fc6e                	sd	s11,56(sp)
ffffffffc0204186:	e13fd0ef          	jal	ra,ffffffffc0201f98 <user_mem_check>
ffffffffc020418a:	46050063          	beqz	a0,ffffffffc02045ea <do_execve+0x49e>
ffffffffc020418e:	4641                	li	a2,16
ffffffffc0204190:	4581                	li	a1,0
ffffffffc0204192:	1008                	addi	a0,sp,32
ffffffffc0204194:	171030ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc0204198:	47bd                	li	a5,15
ffffffffc020419a:	8626                	mv	a2,s1
ffffffffc020419c:	1897ea63          	bltu	a5,s1,ffffffffc0204330 <do_execve+0x1e4>
ffffffffc02041a0:	85ca                	mv	a1,s2
ffffffffc02041a2:	1008                	addi	a0,sp,32
ffffffffc02041a4:	173030ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc02041a8:	180a0b63          	beqz	s4,ffffffffc020433e <do_execve+0x1f2>
ffffffffc02041ac:	00005517          	auipc	a0,0x5
ffffffffc02041b0:	b5450513          	addi	a0,a0,-1196 # ffffffffc0208d00 <commands+0xb28>
ffffffffc02041b4:	f51fb0ef          	jal	ra,ffffffffc0200104 <cputs>
ffffffffc02041b8:	00015797          	auipc	a5,0x15
ffffffffc02041bc:	3887b783          	ld	a5,904(a5) # ffffffffc0219540 <boot_cr3>
ffffffffc02041c0:	577d                	li	a4,-1
ffffffffc02041c2:	177e                	slli	a4,a4,0x3f
ffffffffc02041c4:	83b1                	srli	a5,a5,0xc
ffffffffc02041c6:	8fd9                	or	a5,a5,a4
ffffffffc02041c8:	18079073          	csrw	satp,a5
ffffffffc02041cc:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <kern_entry-0x401fffd0>
ffffffffc02041d0:	fff7871b          	addiw	a4,a5,-1
ffffffffc02041d4:	02ea2823          	sw	a4,48(s4)
ffffffffc02041d8:	2c070163          	beqz	a4,ffffffffc020449a <do_execve+0x34e>
ffffffffc02041dc:	000ab783          	ld	a5,0(s5)
ffffffffc02041e0:	0207b423          	sd	zero,40(a5)
ffffffffc02041e4:	943fd0ef          	jal	ra,ffffffffc0201b26 <mm_create>
ffffffffc02041e8:	84aa                	mv	s1,a0
ffffffffc02041ea:	18050263          	beqz	a0,ffffffffc020436e <do_execve+0x222>
ffffffffc02041ee:	0561                	addi	a0,a0,24
ffffffffc02041f0:	d82ff0ef          	jal	ra,ffffffffc0203772 <setup_pgdir.isra.0>
ffffffffc02041f4:	16051663          	bnez	a0,ffffffffc0204360 <do_execve+0x214>
ffffffffc02041f8:	0009a703          	lw	a4,0(s3)
ffffffffc02041fc:	464c47b7          	lui	a5,0x464c4
ffffffffc0204200:	57f78793          	addi	a5,a5,1407 # 464c457f <kern_entry-0xffffffff79d3ba81>
ffffffffc0204204:	24f71763          	bne	a4,a5,ffffffffc0204452 <do_execve+0x306>
ffffffffc0204208:	0389d703          	lhu	a4,56(s3)
ffffffffc020420c:	0209b903          	ld	s2,32(s3)
ffffffffc0204210:	00371793          	slli	a5,a4,0x3
ffffffffc0204214:	8f99                	sub	a5,a5,a4
ffffffffc0204216:	994e                	add	s2,s2,s3
ffffffffc0204218:	078e                	slli	a5,a5,0x3
ffffffffc020421a:	97ca                	add	a5,a5,s2
ffffffffc020421c:	ec3e                	sd	a5,24(sp)
ffffffffc020421e:	02f97c63          	bgeu	s2,a5,ffffffffc0204256 <do_execve+0x10a>
ffffffffc0204222:	5bfd                	li	s7,-1
ffffffffc0204224:	00cbd793          	srli	a5,s7,0xc
ffffffffc0204228:	00015d97          	auipc	s11,0x15
ffffffffc020422c:	320d8d93          	addi	s11,s11,800 # ffffffffc0219548 <pages>
ffffffffc0204230:	00006d17          	auipc	s10,0x6
ffffffffc0204234:	400d0d13          	addi	s10,s10,1024 # ffffffffc020a630 <nbase>
ffffffffc0204238:	e43e                	sd	a5,8(sp)
ffffffffc020423a:	00015c97          	auipc	s9,0x15
ffffffffc020423e:	296c8c93          	addi	s9,s9,662 # ffffffffc02194d0 <npage>
ffffffffc0204242:	00092703          	lw	a4,0(s2)
ffffffffc0204246:	4785                	li	a5,1
ffffffffc0204248:	12f70563          	beq	a4,a5,ffffffffc0204372 <do_execve+0x226>
ffffffffc020424c:	67e2                	ld	a5,24(sp)
ffffffffc020424e:	03890913          	addi	s2,s2,56
ffffffffc0204252:	fef968e3          	bltu	s2,a5,ffffffffc0204242 <do_execve+0xf6>
ffffffffc0204256:	4701                	li	a4,0
ffffffffc0204258:	46ad                	li	a3,11
ffffffffc020425a:	00100637          	lui	a2,0x100
ffffffffc020425e:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204262:	8526                	mv	a0,s1
ffffffffc0204264:	a71fd0ef          	jal	ra,ffffffffc0201cd4 <mm_map>
ffffffffc0204268:	8a2a                	mv	s4,a0
ffffffffc020426a:	1e051063          	bnez	a0,ffffffffc020444a <do_execve+0x2fe>
ffffffffc020426e:	6c88                	ld	a0,24(s1)
ffffffffc0204270:	467d                	li	a2,31
ffffffffc0204272:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204276:	c10fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020427a:	42050e63          	beqz	a0,ffffffffc02046b6 <do_execve+0x56a>
ffffffffc020427e:	6c88                	ld	a0,24(s1)
ffffffffc0204280:	467d                	li	a2,31
ffffffffc0204282:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204286:	c00fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020428a:	40050663          	beqz	a0,ffffffffc0204696 <do_execve+0x54a>
ffffffffc020428e:	6c88                	ld	a0,24(s1)
ffffffffc0204290:	467d                	li	a2,31
ffffffffc0204292:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204296:	bf0fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc020429a:	3c050e63          	beqz	a0,ffffffffc0204676 <do_execve+0x52a>
ffffffffc020429e:	6c88                	ld	a0,24(s1)
ffffffffc02042a0:	467d                	li	a2,31
ffffffffc02042a2:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02042a6:	be0fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02042aa:	3a050663          	beqz	a0,ffffffffc0204656 <do_execve+0x50a>
ffffffffc02042ae:	589c                	lw	a5,48(s1)
ffffffffc02042b0:	000ab603          	ld	a2,0(s5)
ffffffffc02042b4:	6c94                	ld	a3,24(s1)
ffffffffc02042b6:	2785                	addiw	a5,a5,1
ffffffffc02042b8:	d89c                	sw	a5,48(s1)
ffffffffc02042ba:	f604                	sd	s1,40(a2)
ffffffffc02042bc:	c02007b7          	lui	a5,0xc0200
ffffffffc02042c0:	36f6ef63          	bltu	a3,a5,ffffffffc020463e <do_execve+0x4f2>
ffffffffc02042c4:	00015797          	auipc	a5,0x15
ffffffffc02042c8:	2747b783          	ld	a5,628(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02042cc:	8e9d                	sub	a3,a3,a5
ffffffffc02042ce:	577d                	li	a4,-1
ffffffffc02042d0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02042d4:	177e                	slli	a4,a4,0x3f
ffffffffc02042d6:	f654                	sd	a3,168(a2)
ffffffffc02042d8:	8fd9                	or	a5,a5,a4
ffffffffc02042da:	18079073          	csrw	satp,a5
ffffffffc02042de:	7240                	ld	s0,160(a2)
ffffffffc02042e0:	4581                	li	a1,0
ffffffffc02042e2:	12000613          	li	a2,288
ffffffffc02042e6:	8522                	mv	a0,s0
ffffffffc02042e8:	10043483          	ld	s1,256(s0)
ffffffffc02042ec:	019030ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc02042f0:	0189b703          	ld	a4,24(s3)
ffffffffc02042f4:	4785                	li	a5,1
ffffffffc02042f6:	000ab503          	ld	a0,0(s5)
ffffffffc02042fa:	edf4f493          	andi	s1,s1,-289
ffffffffc02042fe:	07fe                	slli	a5,a5,0x1f
ffffffffc0204300:	e81c                	sd	a5,16(s0)
ffffffffc0204302:	10e43423          	sd	a4,264(s0)
ffffffffc0204306:	10943023          	sd	s1,256(s0)
ffffffffc020430a:	100c                	addi	a1,sp,32
ffffffffc020430c:	ce8ff0ef          	jal	ra,ffffffffc02037f4 <set_proc_name>
ffffffffc0204310:	60ea                	ld	ra,152(sp)
ffffffffc0204312:	644a                	ld	s0,144(sp)
ffffffffc0204314:	64aa                	ld	s1,136(sp)
ffffffffc0204316:	690a                	ld	s2,128(sp)
ffffffffc0204318:	79e6                	ld	s3,120(sp)
ffffffffc020431a:	7aa6                	ld	s5,104(sp)
ffffffffc020431c:	7b06                	ld	s6,96(sp)
ffffffffc020431e:	6be6                	ld	s7,88(sp)
ffffffffc0204320:	6c46                	ld	s8,80(sp)
ffffffffc0204322:	6ca6                	ld	s9,72(sp)
ffffffffc0204324:	6d06                	ld	s10,64(sp)
ffffffffc0204326:	7de2                	ld	s11,56(sp)
ffffffffc0204328:	8552                	mv	a0,s4
ffffffffc020432a:	7a46                	ld	s4,112(sp)
ffffffffc020432c:	610d                	addi	sp,sp,160
ffffffffc020432e:	8082                	ret
ffffffffc0204330:	463d                	li	a2,15
ffffffffc0204332:	85ca                	mv	a1,s2
ffffffffc0204334:	1008                	addi	a0,sp,32
ffffffffc0204336:	7e0030ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc020433a:	e60a19e3          	bnez	s4,ffffffffc02041ac <do_execve+0x60>
ffffffffc020433e:	000ab783          	ld	a5,0(s5)
ffffffffc0204342:	779c                	ld	a5,40(a5)
ffffffffc0204344:	ea0780e3          	beqz	a5,ffffffffc02041e4 <do_execve+0x98>
ffffffffc0204348:	00005617          	auipc	a2,0x5
ffffffffc020434c:	3c860613          	addi	a2,a2,968 # ffffffffc0209710 <default_pmm_manager+0x3e8>
ffffffffc0204350:	20300593          	li	a1,515
ffffffffc0204354:	00005517          	auipc	a0,0x5
ffffffffc0204358:	23c50513          	addi	a0,a0,572 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020435c:	eadfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204360:	8526                	mv	a0,s1
ffffffffc0204362:	923fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0204366:	5a71                	li	s4,-4
ffffffffc0204368:	8552                	mv	a0,s4
ffffffffc020436a:	99bff0ef          	jal	ra,ffffffffc0203d04 <do_exit>
ffffffffc020436e:	5a71                	li	s4,-4
ffffffffc0204370:	bfe5                	j	ffffffffc0204368 <do_execve+0x21c>
ffffffffc0204372:	02893603          	ld	a2,40(s2)
ffffffffc0204376:	02093783          	ld	a5,32(s2)
ffffffffc020437a:	26f66c63          	bltu	a2,a5,ffffffffc02045f2 <do_execve+0x4a6>
ffffffffc020437e:	00492783          	lw	a5,4(s2)
ffffffffc0204382:	0017f693          	andi	a3,a5,1
ffffffffc0204386:	c291                	beqz	a3,ffffffffc020438a <do_execve+0x23e>
ffffffffc0204388:	4691                	li	a3,4
ffffffffc020438a:	0027f713          	andi	a4,a5,2
ffffffffc020438e:	8b91                	andi	a5,a5,4
ffffffffc0204390:	14071c63          	bnez	a4,ffffffffc02044e8 <do_execve+0x39c>
ffffffffc0204394:	4745                	li	a4,17
ffffffffc0204396:	e03a                	sd	a4,0(sp)
ffffffffc0204398:	c789                	beqz	a5,ffffffffc02043a2 <do_execve+0x256>
ffffffffc020439a:	47cd                	li	a5,19
ffffffffc020439c:	0016e693          	ori	a3,a3,1
ffffffffc02043a0:	e03e                	sd	a5,0(sp)
ffffffffc02043a2:	0026f793          	andi	a5,a3,2
ffffffffc02043a6:	14079563          	bnez	a5,ffffffffc02044f0 <do_execve+0x3a4>
ffffffffc02043aa:	0046f793          	andi	a5,a3,4
ffffffffc02043ae:	c789                	beqz	a5,ffffffffc02043b8 <do_execve+0x26c>
ffffffffc02043b0:	6782                	ld	a5,0(sp)
ffffffffc02043b2:	0087e793          	ori	a5,a5,8
ffffffffc02043b6:	e03e                	sd	a5,0(sp)
ffffffffc02043b8:	01093583          	ld	a1,16(s2)
ffffffffc02043bc:	4701                	li	a4,0
ffffffffc02043be:	8526                	mv	a0,s1
ffffffffc02043c0:	915fd0ef          	jal	ra,ffffffffc0201cd4 <mm_map>
ffffffffc02043c4:	8a2a                	mv	s4,a0
ffffffffc02043c6:	e151                	bnez	a0,ffffffffc020444a <do_execve+0x2fe>
ffffffffc02043c8:	01093c03          	ld	s8,16(s2)
ffffffffc02043cc:	02093a03          	ld	s4,32(s2)
ffffffffc02043d0:	00893b03          	ld	s6,8(s2)
ffffffffc02043d4:	77fd                	lui	a5,0xfffff
ffffffffc02043d6:	9a62                	add	s4,s4,s8
ffffffffc02043d8:	9b4e                	add	s6,s6,s3
ffffffffc02043da:	00fc7bb3          	and	s7,s8,a5
ffffffffc02043de:	054c6e63          	bltu	s8,s4,ffffffffc020443a <do_execve+0x2ee>
ffffffffc02043e2:	a431                	j	ffffffffc02045ee <do_execve+0x4a2>
ffffffffc02043e4:	6785                	lui	a5,0x1
ffffffffc02043e6:	417c0533          	sub	a0,s8,s7
ffffffffc02043ea:	9bbe                	add	s7,s7,a5
ffffffffc02043ec:	418b8633          	sub	a2,s7,s8
ffffffffc02043f0:	017a7463          	bgeu	s4,s7,ffffffffc02043f8 <do_execve+0x2ac>
ffffffffc02043f4:	418a0633          	sub	a2,s4,s8
ffffffffc02043f8:	000db683          	ld	a3,0(s11)
ffffffffc02043fc:	000d3803          	ld	a6,0(s10)
ffffffffc0204400:	67a2                	ld	a5,8(sp)
ffffffffc0204402:	40d406b3          	sub	a3,s0,a3
ffffffffc0204406:	8699                	srai	a3,a3,0x6
ffffffffc0204408:	000cb583          	ld	a1,0(s9)
ffffffffc020440c:	96c2                	add	a3,a3,a6
ffffffffc020440e:	00f6f833          	and	a6,a3,a5
ffffffffc0204412:	06b2                	slli	a3,a3,0xc
ffffffffc0204414:	1eb87163          	bgeu	a6,a1,ffffffffc02045f6 <do_execve+0x4aa>
ffffffffc0204418:	00015797          	auipc	a5,0x15
ffffffffc020441c:	12078793          	addi	a5,a5,288 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204420:	0007b803          	ld	a6,0(a5)
ffffffffc0204424:	85da                	mv	a1,s6
ffffffffc0204426:	9c32                	add	s8,s8,a2
ffffffffc0204428:	96c2                	add	a3,a3,a6
ffffffffc020442a:	9536                	add	a0,a0,a3
ffffffffc020442c:	e832                	sd	a2,16(sp)
ffffffffc020442e:	6e8030ef          	jal	ra,ffffffffc0207b16 <memcpy>
ffffffffc0204432:	6642                	ld	a2,16(sp)
ffffffffc0204434:	9b32                	add	s6,s6,a2
ffffffffc0204436:	0d4c7063          	bgeu	s8,s4,ffffffffc02044f6 <do_execve+0x3aa>
ffffffffc020443a:	6c88                	ld	a0,24(s1)
ffffffffc020443c:	6602                	ld	a2,0(sp)
ffffffffc020443e:	85de                	mv	a1,s7
ffffffffc0204440:	a46fd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc0204444:	842a                	mv	s0,a0
ffffffffc0204446:	fd59                	bnez	a0,ffffffffc02043e4 <do_execve+0x298>
ffffffffc0204448:	5a71                	li	s4,-4
ffffffffc020444a:	8526                	mv	a0,s1
ffffffffc020444c:	9d3fd0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc0204450:	a011                	j	ffffffffc0204454 <do_execve+0x308>
ffffffffc0204452:	5a61                	li	s4,-8
ffffffffc0204454:	6c94                	ld	a3,24(s1)
ffffffffc0204456:	c02007b7          	lui	a5,0xc0200
ffffffffc020445a:	1af6ea63          	bltu	a3,a5,ffffffffc020460e <do_execve+0x4c2>
ffffffffc020445e:	00015517          	auipc	a0,0x15
ffffffffc0204462:	0da53503          	ld	a0,218(a0) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204466:	8e89                	sub	a3,a3,a0
ffffffffc0204468:	82b1                	srli	a3,a3,0xc
ffffffffc020446a:	00015797          	auipc	a5,0x15
ffffffffc020446e:	0667b783          	ld	a5,102(a5) # ffffffffc02194d0 <npage>
ffffffffc0204472:	1af6fa63          	bgeu	a3,a5,ffffffffc0204626 <do_execve+0x4da>
ffffffffc0204476:	00006517          	auipc	a0,0x6
ffffffffc020447a:	1ba53503          	ld	a0,442(a0) # ffffffffc020a630 <nbase>
ffffffffc020447e:	8e89                	sub	a3,a3,a0
ffffffffc0204480:	069a                	slli	a3,a3,0x6
ffffffffc0204482:	00015517          	auipc	a0,0x15
ffffffffc0204486:	0c653503          	ld	a0,198(a0) # ffffffffc0219548 <pages>
ffffffffc020448a:	9536                	add	a0,a0,a3
ffffffffc020448c:	4585                	li	a1,1
ffffffffc020448e:	94ffc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc0204492:	8526                	mv	a0,s1
ffffffffc0204494:	ff0fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc0204498:	bdc1                	j	ffffffffc0204368 <do_execve+0x21c>
ffffffffc020449a:	8552                	mv	a0,s4
ffffffffc020449c:	983fd0ef          	jal	ra,ffffffffc0201e1e <exit_mmap>
ffffffffc02044a0:	018a3683          	ld	a3,24(s4)
ffffffffc02044a4:	c02007b7          	lui	a5,0xc0200
ffffffffc02044a8:	16f6e363          	bltu	a3,a5,ffffffffc020460e <do_execve+0x4c2>
ffffffffc02044ac:	00015797          	auipc	a5,0x15
ffffffffc02044b0:	08c7b783          	ld	a5,140(a5) # ffffffffc0219538 <va_pa_offset>
ffffffffc02044b4:	8e9d                	sub	a3,a3,a5
ffffffffc02044b6:	82b1                	srli	a3,a3,0xc
ffffffffc02044b8:	00015797          	auipc	a5,0x15
ffffffffc02044bc:	0187b783          	ld	a5,24(a5) # ffffffffc02194d0 <npage>
ffffffffc02044c0:	16f6f363          	bgeu	a3,a5,ffffffffc0204626 <do_execve+0x4da>
ffffffffc02044c4:	00006517          	auipc	a0,0x6
ffffffffc02044c8:	16c53503          	ld	a0,364(a0) # ffffffffc020a630 <nbase>
ffffffffc02044cc:	8e89                	sub	a3,a3,a0
ffffffffc02044ce:	069a                	slli	a3,a3,0x6
ffffffffc02044d0:	00015517          	auipc	a0,0x15
ffffffffc02044d4:	07853503          	ld	a0,120(a0) # ffffffffc0219548 <pages>
ffffffffc02044d8:	9536                	add	a0,a0,a3
ffffffffc02044da:	4585                	li	a1,1
ffffffffc02044dc:	901fc0ef          	jal	ra,ffffffffc0200ddc <free_pages>
ffffffffc02044e0:	8552                	mv	a0,s4
ffffffffc02044e2:	fa2fd0ef          	jal	ra,ffffffffc0201c84 <mm_destroy>
ffffffffc02044e6:	b9dd                	j	ffffffffc02041dc <do_execve+0x90>
ffffffffc02044e8:	0026e693          	ori	a3,a3,2
ffffffffc02044ec:	ea0797e3          	bnez	a5,ffffffffc020439a <do_execve+0x24e>
ffffffffc02044f0:	47dd                	li	a5,23
ffffffffc02044f2:	e03e                	sd	a5,0(sp)
ffffffffc02044f4:	bd5d                	j	ffffffffc02043aa <do_execve+0x25e>
ffffffffc02044f6:	01093a03          	ld	s4,16(s2)
ffffffffc02044fa:	02893683          	ld	a3,40(s2)
ffffffffc02044fe:	9a36                	add	s4,s4,a3
ffffffffc0204500:	077c7f63          	bgeu	s8,s7,ffffffffc020457e <do_execve+0x432>
ffffffffc0204504:	d58a04e3          	beq	s4,s8,ffffffffc020424c <do_execve+0x100>
ffffffffc0204508:	6505                	lui	a0,0x1
ffffffffc020450a:	9562                	add	a0,a0,s8
ffffffffc020450c:	41750533          	sub	a0,a0,s7
ffffffffc0204510:	418a0b33          	sub	s6,s4,s8
ffffffffc0204514:	0d7a7863          	bgeu	s4,s7,ffffffffc02045e4 <do_execve+0x498>
ffffffffc0204518:	000db683          	ld	a3,0(s11)
ffffffffc020451c:	000d3583          	ld	a1,0(s10)
ffffffffc0204520:	67a2                	ld	a5,8(sp)
ffffffffc0204522:	40d406b3          	sub	a3,s0,a3
ffffffffc0204526:	8699                	srai	a3,a3,0x6
ffffffffc0204528:	000cb603          	ld	a2,0(s9)
ffffffffc020452c:	96ae                	add	a3,a3,a1
ffffffffc020452e:	00f6f5b3          	and	a1,a3,a5
ffffffffc0204532:	06b2                	slli	a3,a3,0xc
ffffffffc0204534:	0cc5f163          	bgeu	a1,a2,ffffffffc02045f6 <do_execve+0x4aa>
ffffffffc0204538:	00015617          	auipc	a2,0x15
ffffffffc020453c:	00063603          	ld	a2,0(a2) # ffffffffc0219538 <va_pa_offset>
ffffffffc0204540:	96b2                	add	a3,a3,a2
ffffffffc0204542:	4581                	li	a1,0
ffffffffc0204544:	865a                	mv	a2,s6
ffffffffc0204546:	9536                	add	a0,a0,a3
ffffffffc0204548:	5bc030ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc020454c:	018b0733          	add	a4,s6,s8
ffffffffc0204550:	037a7463          	bgeu	s4,s7,ffffffffc0204578 <do_execve+0x42c>
ffffffffc0204554:	ceea0ce3          	beq	s4,a4,ffffffffc020424c <do_execve+0x100>
ffffffffc0204558:	00005697          	auipc	a3,0x5
ffffffffc020455c:	1e068693          	addi	a3,a3,480 # ffffffffc0209738 <default_pmm_manager+0x410>
ffffffffc0204560:	00004617          	auipc	a2,0x4
ffffffffc0204564:	08860613          	addi	a2,a2,136 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204568:	25800593          	li	a1,600
ffffffffc020456c:	00005517          	auipc	a0,0x5
ffffffffc0204570:	02450513          	addi	a0,a0,36 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204574:	c95fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204578:	ff7710e3          	bne	a4,s7,ffffffffc0204558 <do_execve+0x40c>
ffffffffc020457c:	8c5e                	mv	s8,s7
ffffffffc020457e:	00015b17          	auipc	s6,0x15
ffffffffc0204582:	fbab0b13          	addi	s6,s6,-70 # ffffffffc0219538 <va_pa_offset>
ffffffffc0204586:	054c6763          	bltu	s8,s4,ffffffffc02045d4 <do_execve+0x488>
ffffffffc020458a:	b1c9                	j	ffffffffc020424c <do_execve+0x100>
ffffffffc020458c:	6785                	lui	a5,0x1
ffffffffc020458e:	417c0533          	sub	a0,s8,s7
ffffffffc0204592:	9bbe                	add	s7,s7,a5
ffffffffc0204594:	418b8633          	sub	a2,s7,s8
ffffffffc0204598:	017a7463          	bgeu	s4,s7,ffffffffc02045a0 <do_execve+0x454>
ffffffffc020459c:	418a0633          	sub	a2,s4,s8
ffffffffc02045a0:	000db683          	ld	a3,0(s11)
ffffffffc02045a4:	000d3803          	ld	a6,0(s10)
ffffffffc02045a8:	67a2                	ld	a5,8(sp)
ffffffffc02045aa:	40d406b3          	sub	a3,s0,a3
ffffffffc02045ae:	8699                	srai	a3,a3,0x6
ffffffffc02045b0:	000cb583          	ld	a1,0(s9)
ffffffffc02045b4:	96c2                	add	a3,a3,a6
ffffffffc02045b6:	00f6f833          	and	a6,a3,a5
ffffffffc02045ba:	06b2                	slli	a3,a3,0xc
ffffffffc02045bc:	02b87d63          	bgeu	a6,a1,ffffffffc02045f6 <do_execve+0x4aa>
ffffffffc02045c0:	000b3803          	ld	a6,0(s6)
ffffffffc02045c4:	9c32                	add	s8,s8,a2
ffffffffc02045c6:	4581                	li	a1,0
ffffffffc02045c8:	96c2                	add	a3,a3,a6
ffffffffc02045ca:	9536                	add	a0,a0,a3
ffffffffc02045cc:	538030ef          	jal	ra,ffffffffc0207b04 <memset>
ffffffffc02045d0:	c74c7ee3          	bgeu	s8,s4,ffffffffc020424c <do_execve+0x100>
ffffffffc02045d4:	6c88                	ld	a0,24(s1)
ffffffffc02045d6:	6602                	ld	a2,0(sp)
ffffffffc02045d8:	85de                	mv	a1,s7
ffffffffc02045da:	8acfd0ef          	jal	ra,ffffffffc0201686 <pgdir_alloc_page>
ffffffffc02045de:	842a                	mv	s0,a0
ffffffffc02045e0:	f555                	bnez	a0,ffffffffc020458c <do_execve+0x440>
ffffffffc02045e2:	b59d                	j	ffffffffc0204448 <do_execve+0x2fc>
ffffffffc02045e4:	418b8b33          	sub	s6,s7,s8
ffffffffc02045e8:	bf05                	j	ffffffffc0204518 <do_execve+0x3cc>
ffffffffc02045ea:	5a75                	li	s4,-3
ffffffffc02045ec:	b315                	j	ffffffffc0204310 <do_execve+0x1c4>
ffffffffc02045ee:	8a62                	mv	s4,s8
ffffffffc02045f0:	b729                	j	ffffffffc02044fa <do_execve+0x3ae>
ffffffffc02045f2:	5a61                	li	s4,-8
ffffffffc02045f4:	bd99                	j	ffffffffc020444a <do_execve+0x2fe>
ffffffffc02045f6:	00004617          	auipc	a2,0x4
ffffffffc02045fa:	3a260613          	addi	a2,a2,930 # ffffffffc0208998 <commands+0x7c0>
ffffffffc02045fe:	06900593          	li	a1,105
ffffffffc0204602:	00004517          	auipc	a0,0x4
ffffffffc0204606:	2f650513          	addi	a0,a0,758 # ffffffffc02088f8 <commands+0x720>
ffffffffc020460a:	bfffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020460e:	00004617          	auipc	a2,0x4
ffffffffc0204612:	35260613          	addi	a2,a2,850 # ffffffffc0208960 <commands+0x788>
ffffffffc0204616:	06e00593          	li	a1,110
ffffffffc020461a:	00004517          	auipc	a0,0x4
ffffffffc020461e:	2de50513          	addi	a0,a0,734 # ffffffffc02088f8 <commands+0x720>
ffffffffc0204622:	be7fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204626:	00004617          	auipc	a2,0x4
ffffffffc020462a:	2b260613          	addi	a2,a2,690 # ffffffffc02088d8 <commands+0x700>
ffffffffc020462e:	06200593          	li	a1,98
ffffffffc0204632:	00004517          	auipc	a0,0x4
ffffffffc0204636:	2c650513          	addi	a0,a0,710 # ffffffffc02088f8 <commands+0x720>
ffffffffc020463a:	bcffb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020463e:	00004617          	auipc	a2,0x4
ffffffffc0204642:	32260613          	addi	a2,a2,802 # ffffffffc0208960 <commands+0x788>
ffffffffc0204646:	27300593          	li	a1,627
ffffffffc020464a:	00005517          	auipc	a0,0x5
ffffffffc020464e:	f4650513          	addi	a0,a0,-186 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204652:	bb7fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204656:	00005697          	auipc	a3,0x5
ffffffffc020465a:	1fa68693          	addi	a3,a3,506 # ffffffffc0209850 <default_pmm_manager+0x528>
ffffffffc020465e:	00004617          	auipc	a2,0x4
ffffffffc0204662:	f8a60613          	addi	a2,a2,-118 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204666:	26e00593          	li	a1,622
ffffffffc020466a:	00005517          	auipc	a0,0x5
ffffffffc020466e:	f2650513          	addi	a0,a0,-218 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204672:	b97fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204676:	00005697          	auipc	a3,0x5
ffffffffc020467a:	19268693          	addi	a3,a3,402 # ffffffffc0209808 <default_pmm_manager+0x4e0>
ffffffffc020467e:	00004617          	auipc	a2,0x4
ffffffffc0204682:	f6a60613          	addi	a2,a2,-150 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204686:	26d00593          	li	a1,621
ffffffffc020468a:	00005517          	auipc	a0,0x5
ffffffffc020468e:	f0650513          	addi	a0,a0,-250 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204692:	b77fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204696:	00005697          	auipc	a3,0x5
ffffffffc020469a:	12a68693          	addi	a3,a3,298 # ffffffffc02097c0 <default_pmm_manager+0x498>
ffffffffc020469e:	00004617          	auipc	a2,0x4
ffffffffc02046a2:	f4a60613          	addi	a2,a2,-182 # ffffffffc02085e8 <commands+0x410>
ffffffffc02046a6:	26c00593          	li	a1,620
ffffffffc02046aa:	00005517          	auipc	a0,0x5
ffffffffc02046ae:	ee650513          	addi	a0,a0,-282 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02046b2:	b57fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc02046b6:	00005697          	auipc	a3,0x5
ffffffffc02046ba:	0c268693          	addi	a3,a3,194 # ffffffffc0209778 <default_pmm_manager+0x450>
ffffffffc02046be:	00004617          	auipc	a2,0x4
ffffffffc02046c2:	f2a60613          	addi	a2,a2,-214 # ffffffffc02085e8 <commands+0x410>
ffffffffc02046c6:	26b00593          	li	a1,619
ffffffffc02046ca:	00005517          	auipc	a0,0x5
ffffffffc02046ce:	ec650513          	addi	a0,a0,-314 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc02046d2:	b37fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02046d6 <do_yield>:
ffffffffc02046d6:	00015797          	auipc	a5,0x15
ffffffffc02046da:	e227b783          	ld	a5,-478(a5) # ffffffffc02194f8 <current>
ffffffffc02046de:	4705                	li	a4,1
ffffffffc02046e0:	ef98                	sd	a4,24(a5)
ffffffffc02046e2:	4501                	li	a0,0
ffffffffc02046e4:	8082                	ret

ffffffffc02046e6 <do_wait>:
ffffffffc02046e6:	1101                	addi	sp,sp,-32
ffffffffc02046e8:	e822                	sd	s0,16(sp)
ffffffffc02046ea:	e426                	sd	s1,8(sp)
ffffffffc02046ec:	ec06                	sd	ra,24(sp)
ffffffffc02046ee:	842e                	mv	s0,a1
ffffffffc02046f0:	84aa                	mv	s1,a0
ffffffffc02046f2:	c999                	beqz	a1,ffffffffc0204708 <do_wait+0x22>
ffffffffc02046f4:	00015797          	auipc	a5,0x15
ffffffffc02046f8:	e047b783          	ld	a5,-508(a5) # ffffffffc02194f8 <current>
ffffffffc02046fc:	7788                	ld	a0,40(a5)
ffffffffc02046fe:	4685                	li	a3,1
ffffffffc0204700:	4611                	li	a2,4
ffffffffc0204702:	897fd0ef          	jal	ra,ffffffffc0201f98 <user_mem_check>
ffffffffc0204706:	c909                	beqz	a0,ffffffffc0204718 <do_wait+0x32>
ffffffffc0204708:	85a2                	mv	a1,s0
ffffffffc020470a:	6442                	ld	s0,16(sp)
ffffffffc020470c:	60e2                	ld	ra,24(sp)
ffffffffc020470e:	8526                	mv	a0,s1
ffffffffc0204710:	64a2                	ld	s1,8(sp)
ffffffffc0204712:	6105                	addi	sp,sp,32
ffffffffc0204714:	fa6ff06f          	j	ffffffffc0203eba <do_wait.part.0>
ffffffffc0204718:	60e2                	ld	ra,24(sp)
ffffffffc020471a:	6442                	ld	s0,16(sp)
ffffffffc020471c:	64a2                	ld	s1,8(sp)
ffffffffc020471e:	5575                	li	a0,-3
ffffffffc0204720:	6105                	addi	sp,sp,32
ffffffffc0204722:	8082                	ret

ffffffffc0204724 <do_kill>:
ffffffffc0204724:	1141                	addi	sp,sp,-16
ffffffffc0204726:	e406                	sd	ra,8(sp)
ffffffffc0204728:	e022                	sd	s0,0(sp)
ffffffffc020472a:	960ff0ef          	jal	ra,ffffffffc020388a <find_proc>
ffffffffc020472e:	cd0d                	beqz	a0,ffffffffc0204768 <do_kill+0x44>
ffffffffc0204730:	0b052703          	lw	a4,176(a0)
ffffffffc0204734:	00177693          	andi	a3,a4,1
ffffffffc0204738:	e695                	bnez	a3,ffffffffc0204764 <do_kill+0x40>
ffffffffc020473a:	0ec52683          	lw	a3,236(a0)
ffffffffc020473e:	00176713          	ori	a4,a4,1
ffffffffc0204742:	0ae52823          	sw	a4,176(a0)
ffffffffc0204746:	4401                	li	s0,0
ffffffffc0204748:	0006c763          	bltz	a3,ffffffffc0204756 <do_kill+0x32>
ffffffffc020474c:	60a2                	ld	ra,8(sp)
ffffffffc020474e:	8522                	mv	a0,s0
ffffffffc0204750:	6402                	ld	s0,0(sp)
ffffffffc0204752:	0141                	addi	sp,sp,16
ffffffffc0204754:	8082                	ret
ffffffffc0204756:	276000ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc020475a:	60a2                	ld	ra,8(sp)
ffffffffc020475c:	8522                	mv	a0,s0
ffffffffc020475e:	6402                	ld	s0,0(sp)
ffffffffc0204760:	0141                	addi	sp,sp,16
ffffffffc0204762:	8082                	ret
ffffffffc0204764:	545d                	li	s0,-9
ffffffffc0204766:	b7dd                	j	ffffffffc020474c <do_kill+0x28>
ffffffffc0204768:	5475                	li	s0,-3
ffffffffc020476a:	b7cd                	j	ffffffffc020474c <do_kill+0x28>

ffffffffc020476c <proc_init>:
ffffffffc020476c:	1101                	addi	sp,sp,-32
ffffffffc020476e:	00015797          	auipc	a5,0x15
ffffffffc0204772:	fca78793          	addi	a5,a5,-54 # ffffffffc0219738 <proc_list>
ffffffffc0204776:	ec06                	sd	ra,24(sp)
ffffffffc0204778:	e822                	sd	s0,16(sp)
ffffffffc020477a:	e426                	sd	s1,8(sp)
ffffffffc020477c:	e04a                	sd	s2,0(sp)
ffffffffc020477e:	e79c                	sd	a5,8(a5)
ffffffffc0204780:	e39c                	sd	a5,0(a5)
ffffffffc0204782:	00015717          	auipc	a4,0x15
ffffffffc0204786:	d0e70713          	addi	a4,a4,-754 # ffffffffc0219490 <__rq>
ffffffffc020478a:	00011797          	auipc	a5,0x11
ffffffffc020478e:	d0678793          	addi	a5,a5,-762 # ffffffffc0215490 <hash_list>
ffffffffc0204792:	e79c                	sd	a5,8(a5)
ffffffffc0204794:	e39c                	sd	a5,0(a5)
ffffffffc0204796:	07c1                	addi	a5,a5,16
ffffffffc0204798:	fef71de3          	bne	a4,a5,ffffffffc0204792 <proc_init+0x26>
ffffffffc020479c:	f57fe0ef          	jal	ra,ffffffffc02036f2 <alloc_proc>
ffffffffc02047a0:	00015417          	auipc	s0,0x15
ffffffffc02047a4:	d6040413          	addi	s0,s0,-672 # ffffffffc0219500 <idleproc>
ffffffffc02047a8:	e008                	sd	a0,0(s0)
ffffffffc02047aa:	c541                	beqz	a0,ffffffffc0204832 <proc_init+0xc6>
ffffffffc02047ac:	4709                	li	a4,2
ffffffffc02047ae:	e118                	sd	a4,0(a0)
ffffffffc02047b0:	4485                	li	s1,1
ffffffffc02047b2:	00007717          	auipc	a4,0x7
ffffffffc02047b6:	84e70713          	addi	a4,a4,-1970 # ffffffffc020b000 <bootstack>
ffffffffc02047ba:	00005597          	auipc	a1,0x5
ffffffffc02047be:	0f658593          	addi	a1,a1,246 # ffffffffc02098b0 <default_pmm_manager+0x588>
ffffffffc02047c2:	e918                	sd	a4,16(a0)
ffffffffc02047c4:	ed04                	sd	s1,24(a0)
ffffffffc02047c6:	82eff0ef          	jal	ra,ffffffffc02037f4 <set_proc_name>
ffffffffc02047ca:	00015717          	auipc	a4,0x15
ffffffffc02047ce:	d4670713          	addi	a4,a4,-698 # ffffffffc0219510 <nr_process>
ffffffffc02047d2:	431c                	lw	a5,0(a4)
ffffffffc02047d4:	6014                	ld	a3,0(s0)
ffffffffc02047d6:	4601                	li	a2,0
ffffffffc02047d8:	2785                	addiw	a5,a5,1
ffffffffc02047da:	4581                	li	a1,0
ffffffffc02047dc:	00000517          	auipc	a0,0x0
ffffffffc02047e0:	87450513          	addi	a0,a0,-1932 # ffffffffc0204050 <init_main>
ffffffffc02047e4:	c31c                	sw	a5,0(a4)
ffffffffc02047e6:	00015797          	auipc	a5,0x15
ffffffffc02047ea:	d0d7b923          	sd	a3,-750(a5) # ffffffffc02194f8 <current>
ffffffffc02047ee:	cc6ff0ef          	jal	ra,ffffffffc0203cb4 <kernel_thread>
ffffffffc02047f2:	08a05c63          	blez	a0,ffffffffc020488a <proc_init+0x11e>
ffffffffc02047f6:	894ff0ef          	jal	ra,ffffffffc020388a <find_proc>
ffffffffc02047fa:	00015917          	auipc	s2,0x15
ffffffffc02047fe:	d0e90913          	addi	s2,s2,-754 # ffffffffc0219508 <initproc>
ffffffffc0204802:	00005597          	auipc	a1,0x5
ffffffffc0204806:	0d658593          	addi	a1,a1,214 # ffffffffc02098d8 <default_pmm_manager+0x5b0>
ffffffffc020480a:	00a93023          	sd	a0,0(s2)
ffffffffc020480e:	fe7fe0ef          	jal	ra,ffffffffc02037f4 <set_proc_name>
ffffffffc0204812:	601c                	ld	a5,0(s0)
ffffffffc0204814:	cbb9                	beqz	a5,ffffffffc020486a <proc_init+0xfe>
ffffffffc0204816:	43dc                	lw	a5,4(a5)
ffffffffc0204818:	eba9                	bnez	a5,ffffffffc020486a <proc_init+0xfe>
ffffffffc020481a:	00093783          	ld	a5,0(s2)
ffffffffc020481e:	c795                	beqz	a5,ffffffffc020484a <proc_init+0xde>
ffffffffc0204820:	43dc                	lw	a5,4(a5)
ffffffffc0204822:	02979463          	bne	a5,s1,ffffffffc020484a <proc_init+0xde>
ffffffffc0204826:	60e2                	ld	ra,24(sp)
ffffffffc0204828:	6442                	ld	s0,16(sp)
ffffffffc020482a:	64a2                	ld	s1,8(sp)
ffffffffc020482c:	6902                	ld	s2,0(sp)
ffffffffc020482e:	6105                	addi	sp,sp,32
ffffffffc0204830:	8082                	ret
ffffffffc0204832:	00005617          	auipc	a2,0x5
ffffffffc0204836:	06660613          	addi	a2,a2,102 # ffffffffc0209898 <default_pmm_manager+0x570>
ffffffffc020483a:	37400593          	li	a1,884
ffffffffc020483e:	00005517          	auipc	a0,0x5
ffffffffc0204842:	d5250513          	addi	a0,a0,-686 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204846:	9c3fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020484a:	00005697          	auipc	a3,0x5
ffffffffc020484e:	0be68693          	addi	a3,a3,190 # ffffffffc0209908 <default_pmm_manager+0x5e0>
ffffffffc0204852:	00004617          	auipc	a2,0x4
ffffffffc0204856:	d9660613          	addi	a2,a2,-618 # ffffffffc02085e8 <commands+0x410>
ffffffffc020485a:	38900593          	li	a1,905
ffffffffc020485e:	00005517          	auipc	a0,0x5
ffffffffc0204862:	d3250513          	addi	a0,a0,-718 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204866:	9a3fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020486a:	00005697          	auipc	a3,0x5
ffffffffc020486e:	07668693          	addi	a3,a3,118 # ffffffffc02098e0 <default_pmm_manager+0x5b8>
ffffffffc0204872:	00004617          	auipc	a2,0x4
ffffffffc0204876:	d7660613          	addi	a2,a2,-650 # ffffffffc02085e8 <commands+0x410>
ffffffffc020487a:	38800593          	li	a1,904
ffffffffc020487e:	00005517          	auipc	a0,0x5
ffffffffc0204882:	d1250513          	addi	a0,a0,-750 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc0204886:	983fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc020488a:	00005617          	auipc	a2,0x5
ffffffffc020488e:	02e60613          	addi	a2,a2,46 # ffffffffc02098b8 <default_pmm_manager+0x590>
ffffffffc0204892:	38200593          	li	a1,898
ffffffffc0204896:	00005517          	auipc	a0,0x5
ffffffffc020489a:	cfa50513          	addi	a0,a0,-774 # ffffffffc0209590 <default_pmm_manager+0x268>
ffffffffc020489e:	96bfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc02048a2 <cpu_idle>:
ffffffffc02048a2:	1141                	addi	sp,sp,-16
ffffffffc02048a4:	e022                	sd	s0,0(sp)
ffffffffc02048a6:	e406                	sd	ra,8(sp)
ffffffffc02048a8:	00015417          	auipc	s0,0x15
ffffffffc02048ac:	c5040413          	addi	s0,s0,-944 # ffffffffc02194f8 <current>
ffffffffc02048b0:	6018                	ld	a4,0(s0)
ffffffffc02048b2:	6f1c                	ld	a5,24(a4)
ffffffffc02048b4:	dffd                	beqz	a5,ffffffffc02048b2 <cpu_idle+0x10>
ffffffffc02048b6:	1c8000ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc02048ba:	bfdd                	j	ffffffffc02048b0 <cpu_idle+0xe>

ffffffffc02048bc <lab6_set_priority>:
ffffffffc02048bc:	1141                	addi	sp,sp,-16
ffffffffc02048be:	e022                	sd	s0,0(sp)
ffffffffc02048c0:	85aa                	mv	a1,a0
ffffffffc02048c2:	842a                	mv	s0,a0
ffffffffc02048c4:	00005517          	auipc	a0,0x5
ffffffffc02048c8:	06c50513          	addi	a0,a0,108 # ffffffffc0209930 <default_pmm_manager+0x608>
ffffffffc02048cc:	e406                	sd	ra,8(sp)
ffffffffc02048ce:	ffefb0ef          	jal	ra,ffffffffc02000cc <cprintf>
ffffffffc02048d2:	00015797          	auipc	a5,0x15
ffffffffc02048d6:	c267b783          	ld	a5,-986(a5) # ffffffffc02194f8 <current>
ffffffffc02048da:	e801                	bnez	s0,ffffffffc02048ea <lab6_set_priority+0x2e>
ffffffffc02048dc:	60a2                	ld	ra,8(sp)
ffffffffc02048de:	6402                	ld	s0,0(sp)
ffffffffc02048e0:	4705                	li	a4,1
ffffffffc02048e2:	14e7a223          	sw	a4,324(a5)
ffffffffc02048e6:	0141                	addi	sp,sp,16
ffffffffc02048e8:	8082                	ret
ffffffffc02048ea:	60a2                	ld	ra,8(sp)
ffffffffc02048ec:	1487a223          	sw	s0,324(a5)
ffffffffc02048f0:	6402                	ld	s0,0(sp)
ffffffffc02048f2:	0141                	addi	sp,sp,16
ffffffffc02048f4:	8082                	ret

ffffffffc02048f6 <do_sleep>:
ffffffffc02048f6:	c539                	beqz	a0,ffffffffc0204944 <do_sleep+0x4e>
ffffffffc02048f8:	7179                	addi	sp,sp,-48
ffffffffc02048fa:	f022                	sd	s0,32(sp)
ffffffffc02048fc:	f406                	sd	ra,40(sp)
ffffffffc02048fe:	842a                	mv	s0,a0
ffffffffc0204900:	100027f3          	csrr	a5,sstatus
ffffffffc0204904:	8b89                	andi	a5,a5,2
ffffffffc0204906:	e3a9                	bnez	a5,ffffffffc0204948 <do_sleep+0x52>
ffffffffc0204908:	00015797          	auipc	a5,0x15
ffffffffc020490c:	bf07b783          	ld	a5,-1040(a5) # ffffffffc02194f8 <current>
ffffffffc0204910:	0818                	addi	a4,sp,16
ffffffffc0204912:	c02a                	sw	a0,0(sp)
ffffffffc0204914:	ec3a                	sd	a4,24(sp)
ffffffffc0204916:	e83a                	sd	a4,16(sp)
ffffffffc0204918:	e43e                	sd	a5,8(sp)
ffffffffc020491a:	4705                	li	a4,1
ffffffffc020491c:	c398                	sw	a4,0(a5)
ffffffffc020491e:	80000737          	lui	a4,0x80000
ffffffffc0204922:	840a                	mv	s0,sp
ffffffffc0204924:	2709                	addiw	a4,a4,2
ffffffffc0204926:	0ee7a623          	sw	a4,236(a5)
ffffffffc020492a:	8522                	mv	a0,s0
ffffffffc020492c:	218000ef          	jal	ra,ffffffffc0204b44 <add_timer>
ffffffffc0204930:	14e000ef          	jal	ra,ffffffffc0204a7e <schedule>
ffffffffc0204934:	8522                	mv	a0,s0
ffffffffc0204936:	2d6000ef          	jal	ra,ffffffffc0204c0c <del_timer>
ffffffffc020493a:	70a2                	ld	ra,40(sp)
ffffffffc020493c:	7402                	ld	s0,32(sp)
ffffffffc020493e:	4501                	li	a0,0
ffffffffc0204940:	6145                	addi	sp,sp,48
ffffffffc0204942:	8082                	ret
ffffffffc0204944:	4501                	li	a0,0
ffffffffc0204946:	8082                	ret
ffffffffc0204948:	cf1fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc020494c:	00015797          	auipc	a5,0x15
ffffffffc0204950:	bac7b783          	ld	a5,-1108(a5) # ffffffffc02194f8 <current>
ffffffffc0204954:	0818                	addi	a4,sp,16
ffffffffc0204956:	c022                	sw	s0,0(sp)
ffffffffc0204958:	e43e                	sd	a5,8(sp)
ffffffffc020495a:	ec3a                	sd	a4,24(sp)
ffffffffc020495c:	e83a                	sd	a4,16(sp)
ffffffffc020495e:	4705                	li	a4,1
ffffffffc0204960:	c398                	sw	a4,0(a5)
ffffffffc0204962:	80000737          	lui	a4,0x80000
ffffffffc0204966:	2709                	addiw	a4,a4,2
ffffffffc0204968:	840a                	mv	s0,sp
ffffffffc020496a:	8522                	mv	a0,s0
ffffffffc020496c:	0ee7a623          	sw	a4,236(a5)
ffffffffc0204970:	1d4000ef          	jal	ra,ffffffffc0204b44 <add_timer>
ffffffffc0204974:	cbffb0ef          	jal	ra,ffffffffc0200632 <intr_enable>
ffffffffc0204978:	bf65                	j	ffffffffc0204930 <do_sleep+0x3a>

ffffffffc020497a <sched_init>:
ffffffffc020497a:	1141                	addi	sp,sp,-16
ffffffffc020497c:	00009717          	auipc	a4,0x9
ffffffffc0204980:	6d470713          	addi	a4,a4,1748 # ffffffffc020e050 <default_sched_class>
ffffffffc0204984:	e022                	sd	s0,0(sp)
ffffffffc0204986:	e406                	sd	ra,8(sp)
ffffffffc0204988:	00015797          	auipc	a5,0x15
ffffffffc020498c:	b2878793          	addi	a5,a5,-1240 # ffffffffc02194b0 <timer_list>
ffffffffc0204990:	6714                	ld	a3,8(a4)
ffffffffc0204992:	00015517          	auipc	a0,0x15
ffffffffc0204996:	afe50513          	addi	a0,a0,-1282 # ffffffffc0219490 <__rq>
ffffffffc020499a:	e79c                	sd	a5,8(a5)
ffffffffc020499c:	e39c                	sd	a5,0(a5)
ffffffffc020499e:	4795                	li	a5,5
ffffffffc02049a0:	c95c                	sw	a5,20(a0)
ffffffffc02049a2:	00015417          	auipc	s0,0x15
ffffffffc02049a6:	b7e40413          	addi	s0,s0,-1154 # ffffffffc0219520 <sched_class>
ffffffffc02049aa:	00015797          	auipc	a5,0x15
ffffffffc02049ae:	b6a7b723          	sd	a0,-1170(a5) # ffffffffc0219518 <rq>
ffffffffc02049b2:	e018                	sd	a4,0(s0)
ffffffffc02049b4:	9682                	jalr	a3
ffffffffc02049b6:	601c                	ld	a5,0(s0)
ffffffffc02049b8:	6402                	ld	s0,0(sp)
ffffffffc02049ba:	60a2                	ld	ra,8(sp)
ffffffffc02049bc:	638c                	ld	a1,0(a5)
ffffffffc02049be:	00005517          	auipc	a0,0x5
ffffffffc02049c2:	f8a50513          	addi	a0,a0,-118 # ffffffffc0209948 <default_pmm_manager+0x620>
ffffffffc02049c6:	0141                	addi	sp,sp,16
ffffffffc02049c8:	f04fb06f          	j	ffffffffc02000cc <cprintf>

ffffffffc02049cc <wakeup_proc>:
ffffffffc02049cc:	4118                	lw	a4,0(a0)
ffffffffc02049ce:	1101                	addi	sp,sp,-32
ffffffffc02049d0:	ec06                	sd	ra,24(sp)
ffffffffc02049d2:	e822                	sd	s0,16(sp)
ffffffffc02049d4:	e426                	sd	s1,8(sp)
ffffffffc02049d6:	478d                	li	a5,3
ffffffffc02049d8:	08f70363          	beq	a4,a5,ffffffffc0204a5e <wakeup_proc+0x92>
ffffffffc02049dc:	842a                	mv	s0,a0
ffffffffc02049de:	100027f3          	csrr	a5,sstatus
ffffffffc02049e2:	8b89                	andi	a5,a5,2
ffffffffc02049e4:	4481                	li	s1,0
ffffffffc02049e6:	e7bd                	bnez	a5,ffffffffc0204a54 <wakeup_proc+0x88>
ffffffffc02049e8:	4789                	li	a5,2
ffffffffc02049ea:	04f70863          	beq	a4,a5,ffffffffc0204a3a <wakeup_proc+0x6e>
ffffffffc02049ee:	c01c                	sw	a5,0(s0)
ffffffffc02049f0:	0e042623          	sw	zero,236(s0)
ffffffffc02049f4:	00015797          	auipc	a5,0x15
ffffffffc02049f8:	b047b783          	ld	a5,-1276(a5) # ffffffffc02194f8 <current>
ffffffffc02049fc:	02878363          	beq	a5,s0,ffffffffc0204a22 <wakeup_proc+0x56>
ffffffffc0204a00:	00015797          	auipc	a5,0x15
ffffffffc0204a04:	b007b783          	ld	a5,-1280(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204a08:	00f40d63          	beq	s0,a5,ffffffffc0204a22 <wakeup_proc+0x56>
ffffffffc0204a0c:	00015797          	auipc	a5,0x15
ffffffffc0204a10:	b147b783          	ld	a5,-1260(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204a14:	6b9c                	ld	a5,16(a5)
ffffffffc0204a16:	85a2                	mv	a1,s0
ffffffffc0204a18:	00015517          	auipc	a0,0x15
ffffffffc0204a1c:	b0053503          	ld	a0,-1280(a0) # ffffffffc0219518 <rq>
ffffffffc0204a20:	9782                	jalr	a5
ffffffffc0204a22:	e491                	bnez	s1,ffffffffc0204a2e <wakeup_proc+0x62>
ffffffffc0204a24:	60e2                	ld	ra,24(sp)
ffffffffc0204a26:	6442                	ld	s0,16(sp)
ffffffffc0204a28:	64a2                	ld	s1,8(sp)
ffffffffc0204a2a:	6105                	addi	sp,sp,32
ffffffffc0204a2c:	8082                	ret
ffffffffc0204a2e:	6442                	ld	s0,16(sp)
ffffffffc0204a30:	60e2                	ld	ra,24(sp)
ffffffffc0204a32:	64a2                	ld	s1,8(sp)
ffffffffc0204a34:	6105                	addi	sp,sp,32
ffffffffc0204a36:	bfdfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204a3a:	00005617          	auipc	a2,0x5
ffffffffc0204a3e:	f5e60613          	addi	a2,a2,-162 # ffffffffc0209998 <default_pmm_manager+0x670>
ffffffffc0204a42:	04800593          	li	a1,72
ffffffffc0204a46:	00005517          	auipc	a0,0x5
ffffffffc0204a4a:	f3a50513          	addi	a0,a0,-198 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204a4e:	823fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204a52:	bfc1                	j	ffffffffc0204a22 <wakeup_proc+0x56>
ffffffffc0204a54:	be5fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204a58:	4018                	lw	a4,0(s0)
ffffffffc0204a5a:	4485                	li	s1,1
ffffffffc0204a5c:	b771                	j	ffffffffc02049e8 <wakeup_proc+0x1c>
ffffffffc0204a5e:	00005697          	auipc	a3,0x5
ffffffffc0204a62:	f0268693          	addi	a3,a3,-254 # ffffffffc0209960 <default_pmm_manager+0x638>
ffffffffc0204a66:	00004617          	auipc	a2,0x4
ffffffffc0204a6a:	b8260613          	addi	a2,a2,-1150 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204a6e:	03c00593          	li	a1,60
ffffffffc0204a72:	00005517          	auipc	a0,0x5
ffffffffc0204a76:	f0e50513          	addi	a0,a0,-242 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204a7a:	f8efb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204a7e <schedule>:
ffffffffc0204a7e:	7179                	addi	sp,sp,-48
ffffffffc0204a80:	f406                	sd	ra,40(sp)
ffffffffc0204a82:	f022                	sd	s0,32(sp)
ffffffffc0204a84:	ec26                	sd	s1,24(sp)
ffffffffc0204a86:	e84a                	sd	s2,16(sp)
ffffffffc0204a88:	e44e                	sd	s3,8(sp)
ffffffffc0204a8a:	e052                	sd	s4,0(sp)
ffffffffc0204a8c:	100027f3          	csrr	a5,sstatus
ffffffffc0204a90:	8b89                	andi	a5,a5,2
ffffffffc0204a92:	4a01                	li	s4,0
ffffffffc0204a94:	e7c5                	bnez	a5,ffffffffc0204b3c <schedule+0xbe>
ffffffffc0204a96:	00015497          	auipc	s1,0x15
ffffffffc0204a9a:	a6248493          	addi	s1,s1,-1438 # ffffffffc02194f8 <current>
ffffffffc0204a9e:	608c                	ld	a1,0(s1)
ffffffffc0204aa0:	00015997          	auipc	s3,0x15
ffffffffc0204aa4:	a8098993          	addi	s3,s3,-1408 # ffffffffc0219520 <sched_class>
ffffffffc0204aa8:	00015917          	auipc	s2,0x15
ffffffffc0204aac:	a7090913          	addi	s2,s2,-1424 # ffffffffc0219518 <rq>
ffffffffc0204ab0:	4194                	lw	a3,0(a1)
ffffffffc0204ab2:	0005bc23          	sd	zero,24(a1)
ffffffffc0204ab6:	4709                	li	a4,2
ffffffffc0204ab8:	0009b783          	ld	a5,0(s3)
ffffffffc0204abc:	00093503          	ld	a0,0(s2)
ffffffffc0204ac0:	04e68063          	beq	a3,a4,ffffffffc0204b00 <schedule+0x82>
ffffffffc0204ac4:	739c                	ld	a5,32(a5)
ffffffffc0204ac6:	9782                	jalr	a5
ffffffffc0204ac8:	842a                	mv	s0,a0
ffffffffc0204aca:	c939                	beqz	a0,ffffffffc0204b20 <schedule+0xa2>
ffffffffc0204acc:	0009b783          	ld	a5,0(s3)
ffffffffc0204ad0:	00093503          	ld	a0,0(s2)
ffffffffc0204ad4:	85a2                	mv	a1,s0
ffffffffc0204ad6:	6f9c                	ld	a5,24(a5)
ffffffffc0204ad8:	9782                	jalr	a5
ffffffffc0204ada:	441c                	lw	a5,8(s0)
ffffffffc0204adc:	6098                	ld	a4,0(s1)
ffffffffc0204ade:	2785                	addiw	a5,a5,1
ffffffffc0204ae0:	c41c                	sw	a5,8(s0)
ffffffffc0204ae2:	00870563          	beq	a4,s0,ffffffffc0204aec <schedule+0x6e>
ffffffffc0204ae6:	8522                	mv	a0,s0
ffffffffc0204ae8:	d37fe0ef          	jal	ra,ffffffffc020381e <proc_run>
ffffffffc0204aec:	020a1f63          	bnez	s4,ffffffffc0204b2a <schedule+0xac>
ffffffffc0204af0:	70a2                	ld	ra,40(sp)
ffffffffc0204af2:	7402                	ld	s0,32(sp)
ffffffffc0204af4:	64e2                	ld	s1,24(sp)
ffffffffc0204af6:	6942                	ld	s2,16(sp)
ffffffffc0204af8:	69a2                	ld	s3,8(sp)
ffffffffc0204afa:	6a02                	ld	s4,0(sp)
ffffffffc0204afc:	6145                	addi	sp,sp,48
ffffffffc0204afe:	8082                	ret
ffffffffc0204b00:	00015717          	auipc	a4,0x15
ffffffffc0204b04:	a0073703          	ld	a4,-1536(a4) # ffffffffc0219500 <idleproc>
ffffffffc0204b08:	fae58ee3          	beq	a1,a4,ffffffffc0204ac4 <schedule+0x46>
ffffffffc0204b0c:	6b9c                	ld	a5,16(a5)
ffffffffc0204b0e:	9782                	jalr	a5
ffffffffc0204b10:	0009b783          	ld	a5,0(s3)
ffffffffc0204b14:	00093503          	ld	a0,0(s2)
ffffffffc0204b18:	739c                	ld	a5,32(a5)
ffffffffc0204b1a:	9782                	jalr	a5
ffffffffc0204b1c:	842a                	mv	s0,a0
ffffffffc0204b1e:	f55d                	bnez	a0,ffffffffc0204acc <schedule+0x4e>
ffffffffc0204b20:	00015417          	auipc	s0,0x15
ffffffffc0204b24:	9e043403          	ld	s0,-1568(s0) # ffffffffc0219500 <idleproc>
ffffffffc0204b28:	bf4d                	j	ffffffffc0204ada <schedule+0x5c>
ffffffffc0204b2a:	7402                	ld	s0,32(sp)
ffffffffc0204b2c:	70a2                	ld	ra,40(sp)
ffffffffc0204b2e:	64e2                	ld	s1,24(sp)
ffffffffc0204b30:	6942                	ld	s2,16(sp)
ffffffffc0204b32:	69a2                	ld	s3,8(sp)
ffffffffc0204b34:	6a02                	ld	s4,0(sp)
ffffffffc0204b36:	6145                	addi	sp,sp,48
ffffffffc0204b38:	afbfb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204b3c:	afdfb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204b40:	4a05                	li	s4,1
ffffffffc0204b42:	bf91                	j	ffffffffc0204a96 <schedule+0x18>

ffffffffc0204b44 <add_timer>:
ffffffffc0204b44:	1141                	addi	sp,sp,-16
ffffffffc0204b46:	e022                	sd	s0,0(sp)
ffffffffc0204b48:	e406                	sd	ra,8(sp)
ffffffffc0204b4a:	842a                	mv	s0,a0
ffffffffc0204b4c:	100027f3          	csrr	a5,sstatus
ffffffffc0204b50:	8b89                	andi	a5,a5,2
ffffffffc0204b52:	4501                	li	a0,0
ffffffffc0204b54:	eba5                	bnez	a5,ffffffffc0204bc4 <add_timer+0x80>
ffffffffc0204b56:	401c                	lw	a5,0(s0)
ffffffffc0204b58:	cbb5                	beqz	a5,ffffffffc0204bcc <add_timer+0x88>
ffffffffc0204b5a:	6418                	ld	a4,8(s0)
ffffffffc0204b5c:	cb25                	beqz	a4,ffffffffc0204bcc <add_timer+0x88>
ffffffffc0204b5e:	6c18                	ld	a4,24(s0)
ffffffffc0204b60:	01040593          	addi	a1,s0,16
ffffffffc0204b64:	08e59463          	bne	a1,a4,ffffffffc0204bec <add_timer+0xa8>
ffffffffc0204b68:	00015617          	auipc	a2,0x15
ffffffffc0204b6c:	94860613          	addi	a2,a2,-1720 # ffffffffc02194b0 <timer_list>
ffffffffc0204b70:	6618                	ld	a4,8(a2)
ffffffffc0204b72:	00c71863          	bne	a4,a2,ffffffffc0204b82 <add_timer+0x3e>
ffffffffc0204b76:	a80d                	j	ffffffffc0204ba8 <add_timer+0x64>
ffffffffc0204b78:	6718                	ld	a4,8(a4)
ffffffffc0204b7a:	9f95                	subw	a5,a5,a3
ffffffffc0204b7c:	c01c                	sw	a5,0(s0)
ffffffffc0204b7e:	02c70563          	beq	a4,a2,ffffffffc0204ba8 <add_timer+0x64>
ffffffffc0204b82:	ff072683          	lw	a3,-16(a4)
ffffffffc0204b86:	fed7f9e3          	bgeu	a5,a3,ffffffffc0204b78 <add_timer+0x34>
ffffffffc0204b8a:	40f687bb          	subw	a5,a3,a5
ffffffffc0204b8e:	fef72823          	sw	a5,-16(a4)
ffffffffc0204b92:	631c                	ld	a5,0(a4)
ffffffffc0204b94:	e30c                	sd	a1,0(a4)
ffffffffc0204b96:	e78c                	sd	a1,8(a5)
ffffffffc0204b98:	ec18                	sd	a4,24(s0)
ffffffffc0204b9a:	e81c                	sd	a5,16(s0)
ffffffffc0204b9c:	c105                	beqz	a0,ffffffffc0204bbc <add_timer+0x78>
ffffffffc0204b9e:	6402                	ld	s0,0(sp)
ffffffffc0204ba0:	60a2                	ld	ra,8(sp)
ffffffffc0204ba2:	0141                	addi	sp,sp,16
ffffffffc0204ba4:	a8ffb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204ba8:	00015717          	auipc	a4,0x15
ffffffffc0204bac:	90870713          	addi	a4,a4,-1784 # ffffffffc02194b0 <timer_list>
ffffffffc0204bb0:	631c                	ld	a5,0(a4)
ffffffffc0204bb2:	e30c                	sd	a1,0(a4)
ffffffffc0204bb4:	e78c                	sd	a1,8(a5)
ffffffffc0204bb6:	ec18                	sd	a4,24(s0)
ffffffffc0204bb8:	e81c                	sd	a5,16(s0)
ffffffffc0204bba:	f175                	bnez	a0,ffffffffc0204b9e <add_timer+0x5a>
ffffffffc0204bbc:	60a2                	ld	ra,8(sp)
ffffffffc0204bbe:	6402                	ld	s0,0(sp)
ffffffffc0204bc0:	0141                	addi	sp,sp,16
ffffffffc0204bc2:	8082                	ret
ffffffffc0204bc4:	a75fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204bc8:	4505                	li	a0,1
ffffffffc0204bca:	b771                	j	ffffffffc0204b56 <add_timer+0x12>
ffffffffc0204bcc:	00005697          	auipc	a3,0x5
ffffffffc0204bd0:	dec68693          	addi	a3,a3,-532 # ffffffffc02099b8 <default_pmm_manager+0x690>
ffffffffc0204bd4:	00004617          	auipc	a2,0x4
ffffffffc0204bd8:	a1460613          	addi	a2,a2,-1516 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204bdc:	06c00593          	li	a1,108
ffffffffc0204be0:	00005517          	auipc	a0,0x5
ffffffffc0204be4:	da050513          	addi	a0,a0,-608 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204be8:	e20fb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204bec:	00005697          	auipc	a3,0x5
ffffffffc0204bf0:	dfc68693          	addi	a3,a3,-516 # ffffffffc02099e8 <default_pmm_manager+0x6c0>
ffffffffc0204bf4:	00004617          	auipc	a2,0x4
ffffffffc0204bf8:	9f460613          	addi	a2,a2,-1548 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204bfc:	06d00593          	li	a1,109
ffffffffc0204c00:	00005517          	auipc	a0,0x5
ffffffffc0204c04:	d8050513          	addi	a0,a0,-640 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204c08:	e00fb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204c0c <del_timer>:
ffffffffc0204c0c:	1101                	addi	sp,sp,-32
ffffffffc0204c0e:	e822                	sd	s0,16(sp)
ffffffffc0204c10:	ec06                	sd	ra,24(sp)
ffffffffc0204c12:	e426                	sd	s1,8(sp)
ffffffffc0204c14:	842a                	mv	s0,a0
ffffffffc0204c16:	100027f3          	csrr	a5,sstatus
ffffffffc0204c1a:	8b89                	andi	a5,a5,2
ffffffffc0204c1c:	01050493          	addi	s1,a0,16
ffffffffc0204c20:	eb9d                	bnez	a5,ffffffffc0204c56 <del_timer+0x4a>
ffffffffc0204c22:	6d1c                	ld	a5,24(a0)
ffffffffc0204c24:	02978463          	beq	a5,s1,ffffffffc0204c4c <del_timer+0x40>
ffffffffc0204c28:	4114                	lw	a3,0(a0)
ffffffffc0204c2a:	6918                	ld	a4,16(a0)
ffffffffc0204c2c:	ce81                	beqz	a3,ffffffffc0204c44 <del_timer+0x38>
ffffffffc0204c2e:	00015617          	auipc	a2,0x15
ffffffffc0204c32:	88260613          	addi	a2,a2,-1918 # ffffffffc02194b0 <timer_list>
ffffffffc0204c36:	00c78763          	beq	a5,a2,ffffffffc0204c44 <del_timer+0x38>
ffffffffc0204c3a:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c3e:	9eb1                	addw	a3,a3,a2
ffffffffc0204c40:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c44:	e71c                	sd	a5,8(a4)
ffffffffc0204c46:	e398                	sd	a4,0(a5)
ffffffffc0204c48:	ec04                	sd	s1,24(s0)
ffffffffc0204c4a:	e804                	sd	s1,16(s0)
ffffffffc0204c4c:	60e2                	ld	ra,24(sp)
ffffffffc0204c4e:	6442                	ld	s0,16(sp)
ffffffffc0204c50:	64a2                	ld	s1,8(sp)
ffffffffc0204c52:	6105                	addi	sp,sp,32
ffffffffc0204c54:	8082                	ret
ffffffffc0204c56:	9e3fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204c5a:	6c1c                	ld	a5,24(s0)
ffffffffc0204c5c:	02978463          	beq	a5,s1,ffffffffc0204c84 <del_timer+0x78>
ffffffffc0204c60:	4014                	lw	a3,0(s0)
ffffffffc0204c62:	6818                	ld	a4,16(s0)
ffffffffc0204c64:	ce81                	beqz	a3,ffffffffc0204c7c <del_timer+0x70>
ffffffffc0204c66:	00015617          	auipc	a2,0x15
ffffffffc0204c6a:	84a60613          	addi	a2,a2,-1974 # ffffffffc02194b0 <timer_list>
ffffffffc0204c6e:	00c78763          	beq	a5,a2,ffffffffc0204c7c <del_timer+0x70>
ffffffffc0204c72:	ff07a603          	lw	a2,-16(a5)
ffffffffc0204c76:	9eb1                	addw	a3,a3,a2
ffffffffc0204c78:	fed7a823          	sw	a3,-16(a5)
ffffffffc0204c7c:	e71c                	sd	a5,8(a4)
ffffffffc0204c7e:	e398                	sd	a4,0(a5)
ffffffffc0204c80:	ec04                	sd	s1,24(s0)
ffffffffc0204c82:	e804                	sd	s1,16(s0)
ffffffffc0204c84:	6442                	ld	s0,16(sp)
ffffffffc0204c86:	60e2                	ld	ra,24(sp)
ffffffffc0204c88:	64a2                	ld	s1,8(sp)
ffffffffc0204c8a:	6105                	addi	sp,sp,32
ffffffffc0204c8c:	9a7fb06f          	j	ffffffffc0200632 <intr_enable>

ffffffffc0204c90 <run_timer_list>:
ffffffffc0204c90:	7139                	addi	sp,sp,-64
ffffffffc0204c92:	fc06                	sd	ra,56(sp)
ffffffffc0204c94:	f822                	sd	s0,48(sp)
ffffffffc0204c96:	f426                	sd	s1,40(sp)
ffffffffc0204c98:	f04a                	sd	s2,32(sp)
ffffffffc0204c9a:	ec4e                	sd	s3,24(sp)
ffffffffc0204c9c:	e852                	sd	s4,16(sp)
ffffffffc0204c9e:	e456                	sd	s5,8(sp)
ffffffffc0204ca0:	e05a                	sd	s6,0(sp)
ffffffffc0204ca2:	100027f3          	csrr	a5,sstatus
ffffffffc0204ca6:	8b89                	andi	a5,a5,2
ffffffffc0204ca8:	4b01                	li	s6,0
ffffffffc0204caa:	eff9                	bnez	a5,ffffffffc0204d88 <run_timer_list+0xf8>
ffffffffc0204cac:	00015997          	auipc	s3,0x15
ffffffffc0204cb0:	80498993          	addi	s3,s3,-2044 # ffffffffc02194b0 <timer_list>
ffffffffc0204cb4:	0089b403          	ld	s0,8(s3)
ffffffffc0204cb8:	07340a63          	beq	s0,s3,ffffffffc0204d2c <run_timer_list+0x9c>
ffffffffc0204cbc:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cc0:	ff040913          	addi	s2,s0,-16
ffffffffc0204cc4:	0e078663          	beqz	a5,ffffffffc0204db0 <run_timer_list+0x120>
ffffffffc0204cc8:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204ccc:	fee42823          	sw	a4,-16(s0)
ffffffffc0204cd0:	ef31                	bnez	a4,ffffffffc0204d2c <run_timer_list+0x9c>
ffffffffc0204cd2:	00005a97          	auipc	s5,0x5
ffffffffc0204cd6:	d7ea8a93          	addi	s5,s5,-642 # ffffffffc0209a50 <default_pmm_manager+0x728>
ffffffffc0204cda:	00005a17          	auipc	s4,0x5
ffffffffc0204cde:	ca6a0a13          	addi	s4,s4,-858 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204ce2:	a005                	j	ffffffffc0204d02 <run_timer_list+0x72>
ffffffffc0204ce4:	0a07d663          	bgez	a5,ffffffffc0204d90 <run_timer_list+0x100>
ffffffffc0204ce8:	8526                	mv	a0,s1
ffffffffc0204cea:	ce3ff0ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc0204cee:	854a                	mv	a0,s2
ffffffffc0204cf0:	f1dff0ef          	jal	ra,ffffffffc0204c0c <del_timer>
ffffffffc0204cf4:	03340c63          	beq	s0,s3,ffffffffc0204d2c <run_timer_list+0x9c>
ffffffffc0204cf8:	ff042783          	lw	a5,-16(s0)
ffffffffc0204cfc:	ff040913          	addi	s2,s0,-16
ffffffffc0204d00:	e795                	bnez	a5,ffffffffc0204d2c <run_timer_list+0x9c>
ffffffffc0204d02:	00893483          	ld	s1,8(s2)
ffffffffc0204d06:	6400                	ld	s0,8(s0)
ffffffffc0204d08:	0ec4a783          	lw	a5,236(s1)
ffffffffc0204d0c:	ffe1                	bnez	a5,ffffffffc0204ce4 <run_timer_list+0x54>
ffffffffc0204d0e:	40d4                	lw	a3,4(s1)
ffffffffc0204d10:	8656                	mv	a2,s5
ffffffffc0204d12:	0a300593          	li	a1,163
ffffffffc0204d16:	8552                	mv	a0,s4
ffffffffc0204d18:	d58fb0ef          	jal	ra,ffffffffc0200270 <__warn>
ffffffffc0204d1c:	8526                	mv	a0,s1
ffffffffc0204d1e:	cafff0ef          	jal	ra,ffffffffc02049cc <wakeup_proc>
ffffffffc0204d22:	854a                	mv	a0,s2
ffffffffc0204d24:	ee9ff0ef          	jal	ra,ffffffffc0204c0c <del_timer>
ffffffffc0204d28:	fd3418e3          	bne	s0,s3,ffffffffc0204cf8 <run_timer_list+0x68>
ffffffffc0204d2c:	00014597          	auipc	a1,0x14
ffffffffc0204d30:	7cc5b583          	ld	a1,1996(a1) # ffffffffc02194f8 <current>
ffffffffc0204d34:	00014797          	auipc	a5,0x14
ffffffffc0204d38:	7cc7b783          	ld	a5,1996(a5) # ffffffffc0219500 <idleproc>
ffffffffc0204d3c:	04f58363          	beq	a1,a5,ffffffffc0204d82 <run_timer_list+0xf2>
ffffffffc0204d40:	00014797          	auipc	a5,0x14
ffffffffc0204d44:	7e07b783          	ld	a5,2016(a5) # ffffffffc0219520 <sched_class>
ffffffffc0204d48:	779c                	ld	a5,40(a5)
ffffffffc0204d4a:	00014517          	auipc	a0,0x14
ffffffffc0204d4e:	7ce53503          	ld	a0,1998(a0) # ffffffffc0219518 <rq>
ffffffffc0204d52:	9782                	jalr	a5
ffffffffc0204d54:	000b1c63          	bnez	s6,ffffffffc0204d6c <run_timer_list+0xdc>
ffffffffc0204d58:	70e2                	ld	ra,56(sp)
ffffffffc0204d5a:	7442                	ld	s0,48(sp)
ffffffffc0204d5c:	74a2                	ld	s1,40(sp)
ffffffffc0204d5e:	7902                	ld	s2,32(sp)
ffffffffc0204d60:	69e2                	ld	s3,24(sp)
ffffffffc0204d62:	6a42                	ld	s4,16(sp)
ffffffffc0204d64:	6aa2                	ld	s5,8(sp)
ffffffffc0204d66:	6b02                	ld	s6,0(sp)
ffffffffc0204d68:	6121                	addi	sp,sp,64
ffffffffc0204d6a:	8082                	ret
ffffffffc0204d6c:	7442                	ld	s0,48(sp)
ffffffffc0204d6e:	70e2                	ld	ra,56(sp)
ffffffffc0204d70:	74a2                	ld	s1,40(sp)
ffffffffc0204d72:	7902                	ld	s2,32(sp)
ffffffffc0204d74:	69e2                	ld	s3,24(sp)
ffffffffc0204d76:	6a42                	ld	s4,16(sp)
ffffffffc0204d78:	6aa2                	ld	s5,8(sp)
ffffffffc0204d7a:	6b02                	ld	s6,0(sp)
ffffffffc0204d7c:	6121                	addi	sp,sp,64
ffffffffc0204d7e:	8b5fb06f          	j	ffffffffc0200632 <intr_enable>
ffffffffc0204d82:	4785                	li	a5,1
ffffffffc0204d84:	ed9c                	sd	a5,24(a1)
ffffffffc0204d86:	b7f9                	j	ffffffffc0204d54 <run_timer_list+0xc4>
ffffffffc0204d88:	8b1fb0ef          	jal	ra,ffffffffc0200638 <intr_disable>
ffffffffc0204d8c:	4b05                	li	s6,1
ffffffffc0204d8e:	bf39                	j	ffffffffc0204cac <run_timer_list+0x1c>
ffffffffc0204d90:	00005697          	auipc	a3,0x5
ffffffffc0204d94:	c9868693          	addi	a3,a3,-872 # ffffffffc0209a28 <default_pmm_manager+0x700>
ffffffffc0204d98:	00004617          	auipc	a2,0x4
ffffffffc0204d9c:	85060613          	addi	a2,a2,-1968 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204da0:	0a000593          	li	a1,160
ffffffffc0204da4:	00005517          	auipc	a0,0x5
ffffffffc0204da8:	bdc50513          	addi	a0,a0,-1060 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204dac:	c5cfb0ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0204db0:	00005697          	auipc	a3,0x5
ffffffffc0204db4:	c6068693          	addi	a3,a3,-928 # ffffffffc0209a10 <default_pmm_manager+0x6e8>
ffffffffc0204db8:	00004617          	auipc	a2,0x4
ffffffffc0204dbc:	83060613          	addi	a2,a2,-2000 # ffffffffc02085e8 <commands+0x410>
ffffffffc0204dc0:	09a00593          	li	a1,154
ffffffffc0204dc4:	00005517          	auipc	a0,0x5
ffffffffc0204dc8:	bbc50513          	addi	a0,a0,-1092 # ffffffffc0209980 <default_pmm_manager+0x658>
ffffffffc0204dcc:	c3cfb0ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0204dd0 <proc_stride_comp_f>:
ffffffffc0204dd0:	4d08                	lw	a0,24(a0)
ffffffffc0204dd2:	4d9c                	lw	a5,24(a1)
ffffffffc0204dd4:	9d1d                	subw	a0,a0,a5
ffffffffc0204dd6:	00a04763          	bgtz	a0,ffffffffc0204de4 <proc_stride_comp_f+0x14>
ffffffffc0204dda:	00a03533          	snez	a0,a0
ffffffffc0204dde:	40a00533          	neg	a0,a0
ffffffffc0204de2:	8082                	ret
ffffffffc0204de4:	4505                	li	a0,1
ffffffffc0204de6:	8082                	ret

ffffffffc0204de8 <stride_init>:
ffffffffc0204de8:	e508                	sd	a0,8(a0)
ffffffffc0204dea:	e108                	sd	a0,0(a0)
ffffffffc0204dec:	00053c23          	sd	zero,24(a0)
ffffffffc0204df0:	00052823          	sw	zero,16(a0)
ffffffffc0204df4:	8082                	ret

ffffffffc0204df6 <stride_pick_next>:
ffffffffc0204df6:	6d1c                	ld	a5,24(a0)
ffffffffc0204df8:	cf89                	beqz	a5,ffffffffc0204e12 <stride_pick_next+0x1c>
ffffffffc0204dfa:	4fd0                	lw	a2,28(a5)
ffffffffc0204dfc:	4f98                	lw	a4,24(a5)
ffffffffc0204dfe:	ed878513          	addi	a0,a5,-296
ffffffffc0204e02:	400006b7          	lui	a3,0x40000
ffffffffc0204e06:	c219                	beqz	a2,ffffffffc0204e0c <stride_pick_next+0x16>
ffffffffc0204e08:	02c6d6bb          	divuw	a3,a3,a2
ffffffffc0204e0c:	9f35                	addw	a4,a4,a3
ffffffffc0204e0e:	cf98                	sw	a4,24(a5)
ffffffffc0204e10:	8082                	ret
ffffffffc0204e12:	4501                	li	a0,0
ffffffffc0204e14:	8082                	ret

ffffffffc0204e16 <stride_proc_tick>:
ffffffffc0204e16:	1205a783          	lw	a5,288(a1)
ffffffffc0204e1a:	00f05563          	blez	a5,ffffffffc0204e24 <stride_proc_tick+0xe>
ffffffffc0204e1e:	37fd                	addiw	a5,a5,-1
ffffffffc0204e20:	12f5a023          	sw	a5,288(a1)
ffffffffc0204e24:	e399                	bnez	a5,ffffffffc0204e2a <stride_proc_tick+0x14>
ffffffffc0204e26:	4785                	li	a5,1
ffffffffc0204e28:	ed9c                	sd	a5,24(a1)
ffffffffc0204e2a:	8082                	ret

ffffffffc0204e2c <skew_heap_merge.constprop.0>:
ffffffffc0204e2c:	1101                	addi	sp,sp,-32
ffffffffc0204e2e:	e822                	sd	s0,16(sp)
ffffffffc0204e30:	ec06                	sd	ra,24(sp)
ffffffffc0204e32:	e426                	sd	s1,8(sp)
ffffffffc0204e34:	e04a                	sd	s2,0(sp)
ffffffffc0204e36:	842e                	mv	s0,a1
ffffffffc0204e38:	c11d                	beqz	a0,ffffffffc0204e5e <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e3a:	84aa                	mv	s1,a0
ffffffffc0204e3c:	c1b9                	beqz	a1,ffffffffc0204e82 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e3e:	f93ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204e42:	57fd                	li	a5,-1
ffffffffc0204e44:	02f50463          	beq	a0,a5,ffffffffc0204e6c <skew_heap_merge.constprop.0+0x40>
ffffffffc0204e48:	680c                	ld	a1,16(s0)
ffffffffc0204e4a:	00843903          	ld	s2,8(s0)
ffffffffc0204e4e:	8526                	mv	a0,s1
ffffffffc0204e50:	fddff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0204e54:	e408                	sd	a0,8(s0)
ffffffffc0204e56:	01243823          	sd	s2,16(s0)
ffffffffc0204e5a:	c111                	beqz	a0,ffffffffc0204e5e <skew_heap_merge.constprop.0+0x32>
ffffffffc0204e5c:	e100                	sd	s0,0(a0)
ffffffffc0204e5e:	60e2                	ld	ra,24(sp)
ffffffffc0204e60:	8522                	mv	a0,s0
ffffffffc0204e62:	6442                	ld	s0,16(sp)
ffffffffc0204e64:	64a2                	ld	s1,8(sp)
ffffffffc0204e66:	6902                	ld	s2,0(sp)
ffffffffc0204e68:	6105                	addi	sp,sp,32
ffffffffc0204e6a:	8082                	ret
ffffffffc0204e6c:	6888                	ld	a0,16(s1)
ffffffffc0204e6e:	0084b903          	ld	s2,8(s1)
ffffffffc0204e72:	85a2                	mv	a1,s0
ffffffffc0204e74:	fb9ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0204e78:	e488                	sd	a0,8(s1)
ffffffffc0204e7a:	0124b823          	sd	s2,16(s1)
ffffffffc0204e7e:	c111                	beqz	a0,ffffffffc0204e82 <skew_heap_merge.constprop.0+0x56>
ffffffffc0204e80:	e104                	sd	s1,0(a0)
ffffffffc0204e82:	60e2                	ld	ra,24(sp)
ffffffffc0204e84:	6442                	ld	s0,16(sp)
ffffffffc0204e86:	6902                	ld	s2,0(sp)
ffffffffc0204e88:	8526                	mv	a0,s1
ffffffffc0204e8a:	64a2                	ld	s1,8(sp)
ffffffffc0204e8c:	6105                	addi	sp,sp,32
ffffffffc0204e8e:	8082                	ret

ffffffffc0204e90 <stride_enqueue>:
ffffffffc0204e90:	7119                	addi	sp,sp,-128
ffffffffc0204e92:	f4a6                	sd	s1,104(sp)
ffffffffc0204e94:	6d04                	ld	s1,24(a0)
ffffffffc0204e96:	f8a2                	sd	s0,112(sp)
ffffffffc0204e98:	f0ca                	sd	s2,96(sp)
ffffffffc0204e9a:	e8d2                	sd	s4,80(sp)
ffffffffc0204e9c:	fc86                	sd	ra,120(sp)
ffffffffc0204e9e:	ecce                	sd	s3,88(sp)
ffffffffc0204ea0:	e4d6                	sd	s5,72(sp)
ffffffffc0204ea2:	e0da                	sd	s6,64(sp)
ffffffffc0204ea4:	fc5e                	sd	s7,56(sp)
ffffffffc0204ea6:	f862                	sd	s8,48(sp)
ffffffffc0204ea8:	f466                	sd	s9,40(sp)
ffffffffc0204eaa:	f06a                	sd	s10,32(sp)
ffffffffc0204eac:	ec6e                	sd	s11,24(sp)
ffffffffc0204eae:	1205b423          	sd	zero,296(a1)
ffffffffc0204eb2:	1205bc23          	sd	zero,312(a1)
ffffffffc0204eb6:	1205b823          	sd	zero,304(a1)
ffffffffc0204eba:	8a2a                	mv	s4,a0
ffffffffc0204ebc:	842e                	mv	s0,a1
ffffffffc0204ebe:	12858913          	addi	s2,a1,296
ffffffffc0204ec2:	cc89                	beqz	s1,ffffffffc0204edc <stride_enqueue+0x4c>
ffffffffc0204ec4:	85ca                	mv	a1,s2
ffffffffc0204ec6:	8526                	mv	a0,s1
ffffffffc0204ec8:	f09ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204ecc:	57fd                	li	a5,-1
ffffffffc0204ece:	89aa                	mv	s3,a0
ffffffffc0204ed0:	04f50763          	beq	a0,a5,ffffffffc0204f1e <stride_enqueue+0x8e>
ffffffffc0204ed4:	12943823          	sd	s1,304(s0)
ffffffffc0204ed8:	0124b023          	sd	s2,0(s1)
ffffffffc0204edc:	12042783          	lw	a5,288(s0)
ffffffffc0204ee0:	012a3c23          	sd	s2,24(s4)
ffffffffc0204ee4:	014a2703          	lw	a4,20(s4)
ffffffffc0204ee8:	c399                	beqz	a5,ffffffffc0204eee <stride_enqueue+0x5e>
ffffffffc0204eea:	00f75463          	bge	a4,a5,ffffffffc0204ef2 <stride_enqueue+0x62>
ffffffffc0204eee:	12e42023          	sw	a4,288(s0)
ffffffffc0204ef2:	010a2783          	lw	a5,16(s4)
ffffffffc0204ef6:	70e6                	ld	ra,120(sp)
ffffffffc0204ef8:	11443423          	sd	s4,264(s0)
ffffffffc0204efc:	7446                	ld	s0,112(sp)
ffffffffc0204efe:	2785                	addiw	a5,a5,1
ffffffffc0204f00:	00fa2823          	sw	a5,16(s4)
ffffffffc0204f04:	74a6                	ld	s1,104(sp)
ffffffffc0204f06:	7906                	ld	s2,96(sp)
ffffffffc0204f08:	69e6                	ld	s3,88(sp)
ffffffffc0204f0a:	6a46                	ld	s4,80(sp)
ffffffffc0204f0c:	6aa6                	ld	s5,72(sp)
ffffffffc0204f0e:	6b06                	ld	s6,64(sp)
ffffffffc0204f10:	7be2                	ld	s7,56(sp)
ffffffffc0204f12:	7c42                	ld	s8,48(sp)
ffffffffc0204f14:	7ca2                	ld	s9,40(sp)
ffffffffc0204f16:	7d02                	ld	s10,32(sp)
ffffffffc0204f18:	6de2                	ld	s11,24(sp)
ffffffffc0204f1a:	6109                	addi	sp,sp,128
ffffffffc0204f1c:	8082                	ret
ffffffffc0204f1e:	0104ba83          	ld	s5,16(s1)
ffffffffc0204f22:	0084bb83          	ld	s7,8(s1)
ffffffffc0204f26:	000a8d63          	beqz	s5,ffffffffc0204f40 <stride_enqueue+0xb0>
ffffffffc0204f2a:	85ca                	mv	a1,s2
ffffffffc0204f2c:	8556                	mv	a0,s5
ffffffffc0204f2e:	ea3ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204f32:	8b2a                	mv	s6,a0
ffffffffc0204f34:	01350e63          	beq	a0,s3,ffffffffc0204f50 <stride_enqueue+0xc0>
ffffffffc0204f38:	13543823          	sd	s5,304(s0)
ffffffffc0204f3c:	012ab023          	sd	s2,0(s5)
ffffffffc0204f40:	0124b423          	sd	s2,8(s1)
ffffffffc0204f44:	0174b823          	sd	s7,16(s1)
ffffffffc0204f48:	00993023          	sd	s1,0(s2)
ffffffffc0204f4c:	8926                	mv	s2,s1
ffffffffc0204f4e:	b779                	j	ffffffffc0204edc <stride_enqueue+0x4c>
ffffffffc0204f50:	010ab983          	ld	s3,16(s5)
ffffffffc0204f54:	008abc83          	ld	s9,8(s5)
ffffffffc0204f58:	00098d63          	beqz	s3,ffffffffc0204f72 <stride_enqueue+0xe2>
ffffffffc0204f5c:	85ca                	mv	a1,s2
ffffffffc0204f5e:	854e                	mv	a0,s3
ffffffffc0204f60:	e71ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204f64:	8c2a                	mv	s8,a0
ffffffffc0204f66:	01650e63          	beq	a0,s6,ffffffffc0204f82 <stride_enqueue+0xf2>
ffffffffc0204f6a:	13343823          	sd	s3,304(s0)
ffffffffc0204f6e:	0129b023          	sd	s2,0(s3)
ffffffffc0204f72:	012ab423          	sd	s2,8(s5)
ffffffffc0204f76:	019ab823          	sd	s9,16(s5)
ffffffffc0204f7a:	01593023          	sd	s5,0(s2)
ffffffffc0204f7e:	8956                	mv	s2,s5
ffffffffc0204f80:	b7c1                	j	ffffffffc0204f40 <stride_enqueue+0xb0>
ffffffffc0204f82:	0109bb03          	ld	s6,16(s3)
ffffffffc0204f86:	0089bd83          	ld	s11,8(s3)
ffffffffc0204f8a:	000b0d63          	beqz	s6,ffffffffc0204fa4 <stride_enqueue+0x114>
ffffffffc0204f8e:	85ca                	mv	a1,s2
ffffffffc0204f90:	855a                	mv	a0,s6
ffffffffc0204f92:	e3fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204f96:	8d2a                	mv	s10,a0
ffffffffc0204f98:	01850e63          	beq	a0,s8,ffffffffc0204fb4 <stride_enqueue+0x124>
ffffffffc0204f9c:	13643823          	sd	s6,304(s0)
ffffffffc0204fa0:	012b3023          	sd	s2,0(s6)
ffffffffc0204fa4:	0129b423          	sd	s2,8(s3)
ffffffffc0204fa8:	01b9b823          	sd	s11,16(s3)
ffffffffc0204fac:	01393023          	sd	s3,0(s2)
ffffffffc0204fb0:	894e                	mv	s2,s3
ffffffffc0204fb2:	b7c1                	j	ffffffffc0204f72 <stride_enqueue+0xe2>
ffffffffc0204fb4:	008b3783          	ld	a5,8(s6)
ffffffffc0204fb8:	010b3c03          	ld	s8,16(s6)
ffffffffc0204fbc:	e43e                	sd	a5,8(sp)
ffffffffc0204fbe:	000c0c63          	beqz	s8,ffffffffc0204fd6 <stride_enqueue+0x146>
ffffffffc0204fc2:	85ca                	mv	a1,s2
ffffffffc0204fc4:	8562                	mv	a0,s8
ffffffffc0204fc6:	e0bff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0204fca:	01a50f63          	beq	a0,s10,ffffffffc0204fe8 <stride_enqueue+0x158>
ffffffffc0204fce:	13843823          	sd	s8,304(s0)
ffffffffc0204fd2:	012c3023          	sd	s2,0(s8)
ffffffffc0204fd6:	67a2                	ld	a5,8(sp)
ffffffffc0204fd8:	012b3423          	sd	s2,8(s6)
ffffffffc0204fdc:	00fb3823          	sd	a5,16(s6)
ffffffffc0204fe0:	01693023          	sd	s6,0(s2)
ffffffffc0204fe4:	895a                	mv	s2,s6
ffffffffc0204fe6:	bf7d                	j	ffffffffc0204fa4 <stride_enqueue+0x114>
ffffffffc0204fe8:	010c3503          	ld	a0,16(s8)
ffffffffc0204fec:	008c3d03          	ld	s10,8(s8)
ffffffffc0204ff0:	85ca                	mv	a1,s2
ffffffffc0204ff2:	e3bff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0204ff6:	00ac3423          	sd	a0,8(s8)
ffffffffc0204ffa:	01ac3823          	sd	s10,16(s8)
ffffffffc0204ffe:	c509                	beqz	a0,ffffffffc0205008 <stride_enqueue+0x178>
ffffffffc0205000:	01853023          	sd	s8,0(a0)
ffffffffc0205004:	8962                	mv	s2,s8
ffffffffc0205006:	bfc1                	j	ffffffffc0204fd6 <stride_enqueue+0x146>
ffffffffc0205008:	8962                	mv	s2,s8
ffffffffc020500a:	b7f1                	j	ffffffffc0204fd6 <stride_enqueue+0x146>

ffffffffc020500c <stride_dequeue>:
ffffffffc020500c:	1085b783          	ld	a5,264(a1)
ffffffffc0205010:	7171                	addi	sp,sp,-176
ffffffffc0205012:	f506                	sd	ra,168(sp)
ffffffffc0205014:	f122                	sd	s0,160(sp)
ffffffffc0205016:	ed26                	sd	s1,152(sp)
ffffffffc0205018:	e94a                	sd	s2,144(sp)
ffffffffc020501a:	e54e                	sd	s3,136(sp)
ffffffffc020501c:	e152                	sd	s4,128(sp)
ffffffffc020501e:	fcd6                	sd	s5,120(sp)
ffffffffc0205020:	f8da                	sd	s6,112(sp)
ffffffffc0205022:	f4de                	sd	s7,104(sp)
ffffffffc0205024:	f0e2                	sd	s8,96(sp)
ffffffffc0205026:	ece6                	sd	s9,88(sp)
ffffffffc0205028:	e8ea                	sd	s10,80(sp)
ffffffffc020502a:	e4ee                	sd	s11,72(sp)
ffffffffc020502c:	00a78463          	beq	a5,a0,ffffffffc0205034 <stride_dequeue+0x28>
ffffffffc0205030:	7870106f          	j	ffffffffc0206fb6 <stride_dequeue+0x1faa>
ffffffffc0205034:	01052983          	lw	s3,16(a0)
ffffffffc0205038:	8c2a                	mv	s8,a0
ffffffffc020503a:	8b4e                	mv	s6,s3
ffffffffc020503c:	00099463          	bnez	s3,ffffffffc0205044 <stride_dequeue+0x38>
ffffffffc0205040:	7770106f          	j	ffffffffc0206fb6 <stride_dequeue+0x1faa>
ffffffffc0205044:	1305b903          	ld	s2,304(a1)
ffffffffc0205048:	01853a83          	ld	s5,24(a0)
ffffffffc020504c:	1285bd03          	ld	s10,296(a1)
ffffffffc0205050:	1385b483          	ld	s1,312(a1)
ffffffffc0205054:	842e                	mv	s0,a1
ffffffffc0205056:	2e090263          	beqz	s2,ffffffffc020533a <stride_dequeue+0x32e>
ffffffffc020505a:	42048263          	beqz	s1,ffffffffc020547e <stride_dequeue+0x472>
ffffffffc020505e:	85a6                	mv	a1,s1
ffffffffc0205060:	854a                	mv	a0,s2
ffffffffc0205062:	d6fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205066:	5cfd                	li	s9,-1
ffffffffc0205068:	8a2a                	mv	s4,a0
ffffffffc020506a:	19950163          	beq	a0,s9,ffffffffc02051ec <stride_dequeue+0x1e0>
ffffffffc020506e:	0104ba03          	ld	s4,16(s1)
ffffffffc0205072:	0084bb83          	ld	s7,8(s1)
ffffffffc0205076:	120a0563          	beqz	s4,ffffffffc02051a0 <stride_dequeue+0x194>
ffffffffc020507a:	85d2                	mv	a1,s4
ffffffffc020507c:	854a                	mv	a0,s2
ffffffffc020507e:	d53ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205082:	2d950563          	beq	a0,s9,ffffffffc020534c <stride_dequeue+0x340>
ffffffffc0205086:	008a3783          	ld	a5,8(s4)
ffffffffc020508a:	010a3d83          	ld	s11,16(s4)
ffffffffc020508e:	e03e                	sd	a5,0(sp)
ffffffffc0205090:	100d8063          	beqz	s11,ffffffffc0205190 <stride_dequeue+0x184>
ffffffffc0205094:	85ee                	mv	a1,s11
ffffffffc0205096:	854a                	mv	a0,s2
ffffffffc0205098:	d39ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020509c:	7f950563          	beq	a0,s9,ffffffffc0205886 <stride_dequeue+0x87a>
ffffffffc02050a0:	008db783          	ld	a5,8(s11)
ffffffffc02050a4:	010dbc83          	ld	s9,16(s11)
ffffffffc02050a8:	e43e                	sd	a5,8(sp)
ffffffffc02050aa:	0c0c8b63          	beqz	s9,ffffffffc0205180 <stride_dequeue+0x174>
ffffffffc02050ae:	85e6                	mv	a1,s9
ffffffffc02050b0:	854a                	mv	a0,s2
ffffffffc02050b2:	d1fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02050b6:	58fd                	li	a7,-1
ffffffffc02050b8:	71150063          	beq	a0,a7,ffffffffc02057b8 <stride_dequeue+0x7ac>
ffffffffc02050bc:	008cb783          	ld	a5,8(s9)
ffffffffc02050c0:	010cb803          	ld	a6,16(s9)
ffffffffc02050c4:	e83e                	sd	a5,16(sp)
ffffffffc02050c6:	0a080563          	beqz	a6,ffffffffc0205170 <stride_dequeue+0x164>
ffffffffc02050ca:	85c2                	mv	a1,a6
ffffffffc02050cc:	854a                	mv	a0,s2
ffffffffc02050ce:	ec42                	sd	a6,24(sp)
ffffffffc02050d0:	d01ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02050d4:	58fd                	li	a7,-1
ffffffffc02050d6:	6862                	ld	a6,24(sp)
ffffffffc02050d8:	41150be3          	beq	a0,a7,ffffffffc0205cee <stride_dequeue+0xce2>
ffffffffc02050dc:	00883703          	ld	a4,8(a6) # fffffffffff80008 <end+0x3fd668c0>
ffffffffc02050e0:	01083783          	ld	a5,16(a6)
ffffffffc02050e4:	ec3a                	sd	a4,24(sp)
ffffffffc02050e6:	cfad                	beqz	a5,ffffffffc0205160 <stride_dequeue+0x154>
ffffffffc02050e8:	85be                	mv	a1,a5
ffffffffc02050ea:	854a                	mv	a0,s2
ffffffffc02050ec:	f442                	sd	a6,40(sp)
ffffffffc02050ee:	f03e                	sd	a5,32(sp)
ffffffffc02050f0:	ce1ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02050f4:	58fd                	li	a7,-1
ffffffffc02050f6:	7782                	ld	a5,32(sp)
ffffffffc02050f8:	7822                	ld	a6,40(sp)
ffffffffc02050fa:	01151463          	bne	a0,a7,ffffffffc0205102 <stride_dequeue+0xf6>
ffffffffc02050fe:	17a0106f          	j	ffffffffc0206278 <stride_dequeue+0x126c>
ffffffffc0205102:	6798                	ld	a4,8(a5)
ffffffffc0205104:	0107bb03          	ld	s6,16(a5)
ffffffffc0205108:	f03a                	sd	a4,32(sp)
ffffffffc020510a:	040b0463          	beqz	s6,ffffffffc0205152 <stride_dequeue+0x146>
ffffffffc020510e:	85da                	mv	a1,s6
ffffffffc0205110:	854a                	mv	a0,s2
ffffffffc0205112:	f83e                	sd	a5,48(sp)
ffffffffc0205114:	f442                	sd	a6,40(sp)
ffffffffc0205116:	cbbff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020511a:	58fd                	li	a7,-1
ffffffffc020511c:	7822                	ld	a6,40(sp)
ffffffffc020511e:	77c2                	ld	a5,48(sp)
ffffffffc0205120:	01151463          	bne	a0,a7,ffffffffc0205128 <stride_dequeue+0x11c>
ffffffffc0205124:	00d0106f          	j	ffffffffc0206930 <stride_dequeue+0x1924>
ffffffffc0205128:	010b3583          	ld	a1,16(s6)
ffffffffc020512c:	008b3983          	ld	s3,8(s6)
ffffffffc0205130:	854a                	mv	a0,s2
ffffffffc0205132:	f83e                	sd	a5,48(sp)
ffffffffc0205134:	f442                	sd	a6,40(sp)
ffffffffc0205136:	cf7ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020513a:	00ab3423          	sd	a0,8(s6)
ffffffffc020513e:	013b3823          	sd	s3,16(s6)
ffffffffc0205142:	7822                	ld	a6,40(sp)
ffffffffc0205144:	77c2                	ld	a5,48(sp)
ffffffffc0205146:	010c2983          	lw	s3,16(s8)
ffffffffc020514a:	c119                	beqz	a0,ffffffffc0205150 <stride_dequeue+0x144>
ffffffffc020514c:	01653023          	sd	s6,0(a0)
ffffffffc0205150:	895a                	mv	s2,s6
ffffffffc0205152:	7702                	ld	a4,32(sp)
ffffffffc0205154:	0127b423          	sd	s2,8(a5)
ffffffffc0205158:	eb98                	sd	a4,16(a5)
ffffffffc020515a:	00f93023          	sd	a5,0(s2)
ffffffffc020515e:	893e                	mv	s2,a5
ffffffffc0205160:	67e2                	ld	a5,24(sp)
ffffffffc0205162:	01283423          	sd	s2,8(a6)
ffffffffc0205166:	00f83823          	sd	a5,16(a6)
ffffffffc020516a:	01093023          	sd	a6,0(s2)
ffffffffc020516e:	8942                	mv	s2,a6
ffffffffc0205170:	67c2                	ld	a5,16(sp)
ffffffffc0205172:	012cb423          	sd	s2,8(s9)
ffffffffc0205176:	00fcb823          	sd	a5,16(s9)
ffffffffc020517a:	01993023          	sd	s9,0(s2)
ffffffffc020517e:	8966                	mv	s2,s9
ffffffffc0205180:	67a2                	ld	a5,8(sp)
ffffffffc0205182:	012db423          	sd	s2,8(s11)
ffffffffc0205186:	00fdb823          	sd	a5,16(s11)
ffffffffc020518a:	01b93023          	sd	s11,0(s2)
ffffffffc020518e:	896e                	mv	s2,s11
ffffffffc0205190:	6782                	ld	a5,0(sp)
ffffffffc0205192:	012a3423          	sd	s2,8(s4)
ffffffffc0205196:	00fa3823          	sd	a5,16(s4)
ffffffffc020519a:	01493023          	sd	s4,0(s2)
ffffffffc020519e:	8952                	mv	s2,s4
ffffffffc02051a0:	0124b423          	sd	s2,8(s1)
ffffffffc02051a4:	0174b823          	sd	s7,16(s1)
ffffffffc02051a8:	00993023          	sd	s1,0(s2)
ffffffffc02051ac:	01a4b023          	sd	s10,0(s1)
ffffffffc02051b0:	180d0963          	beqz	s10,ffffffffc0205342 <stride_dequeue+0x336>
ffffffffc02051b4:	008d3683          	ld	a3,8(s10)
ffffffffc02051b8:	12840413          	addi	s0,s0,296
ffffffffc02051bc:	18868563          	beq	a3,s0,ffffffffc0205346 <stride_dequeue+0x33a>
ffffffffc02051c0:	009d3823          	sd	s1,16(s10)
ffffffffc02051c4:	70aa                	ld	ra,168(sp)
ffffffffc02051c6:	740a                	ld	s0,160(sp)
ffffffffc02051c8:	39fd                	addiw	s3,s3,-1
ffffffffc02051ca:	015c3c23          	sd	s5,24(s8)
ffffffffc02051ce:	013c2823          	sw	s3,16(s8)
ffffffffc02051d2:	64ea                	ld	s1,152(sp)
ffffffffc02051d4:	694a                	ld	s2,144(sp)
ffffffffc02051d6:	69aa                	ld	s3,136(sp)
ffffffffc02051d8:	6a0a                	ld	s4,128(sp)
ffffffffc02051da:	7ae6                	ld	s5,120(sp)
ffffffffc02051dc:	7b46                	ld	s6,112(sp)
ffffffffc02051de:	7ba6                	ld	s7,104(sp)
ffffffffc02051e0:	7c06                	ld	s8,96(sp)
ffffffffc02051e2:	6ce6                	ld	s9,88(sp)
ffffffffc02051e4:	6d46                	ld	s10,80(sp)
ffffffffc02051e6:	6da6                	ld	s11,72(sp)
ffffffffc02051e8:	614d                	addi	sp,sp,176
ffffffffc02051ea:	8082                	ret
ffffffffc02051ec:	01093d83          	ld	s11,16(s2)
ffffffffc02051f0:	00893b83          	ld	s7,8(s2)
ffffffffc02051f4:	120d8963          	beqz	s11,ffffffffc0205326 <stride_dequeue+0x31a>
ffffffffc02051f8:	85a6                	mv	a1,s1
ffffffffc02051fa:	856e                	mv	a0,s11
ffffffffc02051fc:	bd5ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205200:	29450363          	beq	a0,s4,ffffffffc0205486 <stride_dequeue+0x47a>
ffffffffc0205204:	649c                	ld	a5,8(s1)
ffffffffc0205206:	0104bc83          	ld	s9,16(s1)
ffffffffc020520a:	e03e                	sd	a5,0(sp)
ffffffffc020520c:	100c8763          	beqz	s9,ffffffffc020531a <stride_dequeue+0x30e>
ffffffffc0205210:	85e6                	mv	a1,s9
ffffffffc0205212:	856e                	mv	a0,s11
ffffffffc0205214:	bbdff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205218:	4b450263          	beq	a0,s4,ffffffffc02056bc <stride_dequeue+0x6b0>
ffffffffc020521c:	008cb783          	ld	a5,8(s9)
ffffffffc0205220:	010cba03          	ld	s4,16(s9)
ffffffffc0205224:	e43e                	sd	a5,8(sp)
ffffffffc0205226:	0e0a0263          	beqz	s4,ffffffffc020530a <stride_dequeue+0x2fe>
ffffffffc020522a:	85d2                	mv	a1,s4
ffffffffc020522c:	856e                	mv	a0,s11
ffffffffc020522e:	ba3ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205232:	58fd                	li	a7,-1
ffffffffc0205234:	03150fe3          	beq	a0,a7,ffffffffc0205a72 <stride_dequeue+0xa66>
ffffffffc0205238:	008a3783          	ld	a5,8(s4)
ffffffffc020523c:	010a3803          	ld	a6,16(s4)
ffffffffc0205240:	e83e                	sd	a5,16(sp)
ffffffffc0205242:	0a080c63          	beqz	a6,ffffffffc02052fa <stride_dequeue+0x2ee>
ffffffffc0205246:	85c2                	mv	a1,a6
ffffffffc0205248:	856e                	mv	a0,s11
ffffffffc020524a:	ec42                	sd	a6,24(sp)
ffffffffc020524c:	b85ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205250:	58fd                	li	a7,-1
ffffffffc0205252:	6862                	ld	a6,24(sp)
ffffffffc0205254:	01151463          	bne	a0,a7,ffffffffc020525c <stride_dequeue+0x250>
ffffffffc0205258:	6e10006f          	j	ffffffffc0206138 <stride_dequeue+0x112c>
ffffffffc020525c:	00883783          	ld	a5,8(a6)
ffffffffc0205260:	01083303          	ld	t1,16(a6)
ffffffffc0205264:	ec3e                	sd	a5,24(sp)
ffffffffc0205266:	08030263          	beqz	t1,ffffffffc02052ea <stride_dequeue+0x2de>
ffffffffc020526a:	859a                	mv	a1,t1
ffffffffc020526c:	856e                	mv	a0,s11
ffffffffc020526e:	f442                	sd	a6,40(sp)
ffffffffc0205270:	f01a                	sd	t1,32(sp)
ffffffffc0205272:	b5fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205276:	58fd                	li	a7,-1
ffffffffc0205278:	7302                	ld	t1,32(sp)
ffffffffc020527a:	7822                	ld	a6,40(sp)
ffffffffc020527c:	01151463          	bne	a0,a7,ffffffffc0205284 <stride_dequeue+0x278>
ffffffffc0205280:	5ee0106f          	j	ffffffffc020686e <stride_dequeue+0x1862>
ffffffffc0205284:	00833783          	ld	a5,8(t1)
ffffffffc0205288:	01033983          	ld	s3,16(t1)
ffffffffc020528c:	f03e                	sd	a5,32(sp)
ffffffffc020528e:	00099463          	bnez	s3,ffffffffc0205296 <stride_dequeue+0x28a>
ffffffffc0205292:	26f0106f          	j	ffffffffc0206d00 <stride_dequeue+0x1cf4>
ffffffffc0205296:	85ce                	mv	a1,s3
ffffffffc0205298:	856e                	mv	a0,s11
ffffffffc020529a:	f842                	sd	a6,48(sp)
ffffffffc020529c:	f41a                	sd	t1,40(sp)
ffffffffc020529e:	b33ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02052a2:	58fd                	li	a7,-1
ffffffffc02052a4:	7322                	ld	t1,40(sp)
ffffffffc02052a6:	7842                	ld	a6,48(sp)
ffffffffc02052a8:	01151463          	bne	a0,a7,ffffffffc02052b0 <stride_dequeue+0x2a4>
ffffffffc02052ac:	4d30106f          	j	ffffffffc0206f7e <stride_dequeue+0x1f72>
ffffffffc02052b0:	0109b583          	ld	a1,16(s3)
ffffffffc02052b4:	0089bb03          	ld	s6,8(s3)
ffffffffc02052b8:	856e                	mv	a0,s11
ffffffffc02052ba:	f842                	sd	a6,48(sp)
ffffffffc02052bc:	f41a                	sd	t1,40(sp)
ffffffffc02052be:	b6fff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02052c2:	00a9b423          	sd	a0,8(s3)
ffffffffc02052c6:	0169b823          	sd	s6,16(s3)
ffffffffc02052ca:	7322                	ld	t1,40(sp)
ffffffffc02052cc:	7842                	ld	a6,48(sp)
ffffffffc02052ce:	010c2b03          	lw	s6,16(s8)
ffffffffc02052d2:	c119                	beqz	a0,ffffffffc02052d8 <stride_dequeue+0x2cc>
ffffffffc02052d4:	01353023          	sd	s3,0(a0)
ffffffffc02052d8:	7782                	ld	a5,32(sp)
ffffffffc02052da:	01333423          	sd	s3,8(t1)
ffffffffc02052de:	8d9a                	mv	s11,t1
ffffffffc02052e0:	00f33823          	sd	a5,16(t1)
ffffffffc02052e4:	0069b023          	sd	t1,0(s3)
ffffffffc02052e8:	89da                	mv	s3,s6
ffffffffc02052ea:	67e2                	ld	a5,24(sp)
ffffffffc02052ec:	01b83423          	sd	s11,8(a6)
ffffffffc02052f0:	00f83823          	sd	a5,16(a6)
ffffffffc02052f4:	010db023          	sd	a6,0(s11)
ffffffffc02052f8:	8dc2                	mv	s11,a6
ffffffffc02052fa:	67c2                	ld	a5,16(sp)
ffffffffc02052fc:	01ba3423          	sd	s11,8(s4)
ffffffffc0205300:	00fa3823          	sd	a5,16(s4)
ffffffffc0205304:	014db023          	sd	s4,0(s11)
ffffffffc0205308:	8dd2                	mv	s11,s4
ffffffffc020530a:	67a2                	ld	a5,8(sp)
ffffffffc020530c:	01bcb423          	sd	s11,8(s9)
ffffffffc0205310:	00fcb823          	sd	a5,16(s9)
ffffffffc0205314:	019db023          	sd	s9,0(s11)
ffffffffc0205318:	8de6                	mv	s11,s9
ffffffffc020531a:	6782                	ld	a5,0(sp)
ffffffffc020531c:	01b4b423          	sd	s11,8(s1)
ffffffffc0205320:	e89c                	sd	a5,16(s1)
ffffffffc0205322:	009db023          	sd	s1,0(s11)
ffffffffc0205326:	00993423          	sd	s1,8(s2)
ffffffffc020532a:	01793823          	sd	s7,16(s2)
ffffffffc020532e:	0124b023          	sd	s2,0(s1)
ffffffffc0205332:	84ca                	mv	s1,s2
ffffffffc0205334:	01a4b023          	sd	s10,0(s1)
ffffffffc0205338:	bda5                	j	ffffffffc02051b0 <stride_dequeue+0x1a4>
ffffffffc020533a:	e60499e3          	bnez	s1,ffffffffc02051ac <stride_dequeue+0x1a0>
ffffffffc020533e:	e60d1be3          	bnez	s10,ffffffffc02051b4 <stride_dequeue+0x1a8>
ffffffffc0205342:	8aa6                	mv	s5,s1
ffffffffc0205344:	b541                	j	ffffffffc02051c4 <stride_dequeue+0x1b8>
ffffffffc0205346:	009d3423          	sd	s1,8(s10)
ffffffffc020534a:	bdad                	j	ffffffffc02051c4 <stride_dequeue+0x1b8>
ffffffffc020534c:	01093d83          	ld	s11,16(s2)
ffffffffc0205350:	e02a                	sd	a0,0(sp)
ffffffffc0205352:	00893c83          	ld	s9,8(s2)
ffffffffc0205356:	100d8d63          	beqz	s11,ffffffffc0205470 <stride_dequeue+0x464>
ffffffffc020535a:	85d2                	mv	a1,s4
ffffffffc020535c:	856e                	mv	a0,s11
ffffffffc020535e:	a73ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205362:	6782                	ld	a5,0(sp)
ffffffffc0205364:	24f50563          	beq	a0,a5,ffffffffc02055ae <stride_dequeue+0x5a2>
ffffffffc0205368:	008a3783          	ld	a5,8(s4)
ffffffffc020536c:	010a3603          	ld	a2,16(s4)
ffffffffc0205370:	e03e                	sd	a5,0(sp)
ffffffffc0205372:	0e060863          	beqz	a2,ffffffffc0205462 <stride_dequeue+0x456>
ffffffffc0205376:	85b2                	mv	a1,a2
ffffffffc0205378:	856e                	mv	a0,s11
ffffffffc020537a:	e432                	sd	a2,8(sp)
ffffffffc020537c:	a55ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205380:	58fd                	li	a7,-1
ffffffffc0205382:	6622                	ld	a2,8(sp)
ffffffffc0205384:	7b150f63          	beq	a0,a7,ffffffffc0205b42 <stride_dequeue+0xb36>
ffffffffc0205388:	661c                	ld	a5,8(a2)
ffffffffc020538a:	01063803          	ld	a6,16(a2)
ffffffffc020538e:	e43e                	sd	a5,8(sp)
ffffffffc0205390:	0c080263          	beqz	a6,ffffffffc0205454 <stride_dequeue+0x448>
ffffffffc0205394:	85c2                	mv	a1,a6
ffffffffc0205396:	856e                	mv	a0,s11
ffffffffc0205398:	ec32                	sd	a2,24(sp)
ffffffffc020539a:	e842                	sd	a6,16(sp)
ffffffffc020539c:	a35ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02053a0:	58fd                	li	a7,-1
ffffffffc02053a2:	6842                	ld	a6,16(sp)
ffffffffc02053a4:	6662                	ld	a2,24(sp)
ffffffffc02053a6:	631507e3          	beq	a0,a7,ffffffffc02061d4 <stride_dequeue+0x11c8>
ffffffffc02053aa:	00883783          	ld	a5,8(a6)
ffffffffc02053ae:	01083303          	ld	t1,16(a6)
ffffffffc02053b2:	e83e                	sd	a5,16(sp)
ffffffffc02053b4:	08030863          	beqz	t1,ffffffffc0205444 <stride_dequeue+0x438>
ffffffffc02053b8:	859a                	mv	a1,t1
ffffffffc02053ba:	856e                	mv	a0,s11
ffffffffc02053bc:	f442                	sd	a6,40(sp)
ffffffffc02053be:	f032                	sd	a2,32(sp)
ffffffffc02053c0:	ec1a                	sd	t1,24(sp)
ffffffffc02053c2:	a0fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02053c6:	58fd                	li	a7,-1
ffffffffc02053c8:	6362                	ld	t1,24(sp)
ffffffffc02053ca:	7602                	ld	a2,32(sp)
ffffffffc02053cc:	7822                	ld	a6,40(sp)
ffffffffc02053ce:	01151463          	bne	a0,a7,ffffffffc02053d6 <stride_dequeue+0x3ca>
ffffffffc02053d2:	3d00106f          	j	ffffffffc02067a2 <stride_dequeue+0x1796>
ffffffffc02053d6:	00833783          	ld	a5,8(t1)
ffffffffc02053da:	01033983          	ld	s3,16(t1)
ffffffffc02053de:	ec3e                	sd	a5,24(sp)
ffffffffc02053e0:	00099463          	bnez	s3,ffffffffc02053e8 <stride_dequeue+0x3dc>
ffffffffc02053e4:	2af0106f          	j	ffffffffc0206e92 <stride_dequeue+0x1e86>
ffffffffc02053e8:	85ce                	mv	a1,s3
ffffffffc02053ea:	856e                	mv	a0,s11
ffffffffc02053ec:	f81a                	sd	t1,48(sp)
ffffffffc02053ee:	f442                	sd	a6,40(sp)
ffffffffc02053f0:	f032                	sd	a2,32(sp)
ffffffffc02053f2:	9dfff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02053f6:	58fd                	li	a7,-1
ffffffffc02053f8:	7602                	ld	a2,32(sp)
ffffffffc02053fa:	7822                	ld	a6,40(sp)
ffffffffc02053fc:	7342                	ld	t1,48(sp)
ffffffffc02053fe:	01151463          	bne	a0,a7,ffffffffc0205406 <stride_dequeue+0x3fa>
ffffffffc0205402:	3510106f          	j	ffffffffc0206f52 <stride_dequeue+0x1f46>
ffffffffc0205406:	0109b583          	ld	a1,16(s3)
ffffffffc020540a:	0089bb03          	ld	s6,8(s3)
ffffffffc020540e:	856e                	mv	a0,s11
ffffffffc0205410:	f81a                	sd	t1,48(sp)
ffffffffc0205412:	f442                	sd	a6,40(sp)
ffffffffc0205414:	f032                	sd	a2,32(sp)
ffffffffc0205416:	a17ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020541a:	00a9b423          	sd	a0,8(s3)
ffffffffc020541e:	0169b823          	sd	s6,16(s3)
ffffffffc0205422:	7602                	ld	a2,32(sp)
ffffffffc0205424:	7822                	ld	a6,40(sp)
ffffffffc0205426:	7342                	ld	t1,48(sp)
ffffffffc0205428:	010c2b03          	lw	s6,16(s8)
ffffffffc020542c:	c119                	beqz	a0,ffffffffc0205432 <stride_dequeue+0x426>
ffffffffc020542e:	01353023          	sd	s3,0(a0)
ffffffffc0205432:	67e2                	ld	a5,24(sp)
ffffffffc0205434:	01333423          	sd	s3,8(t1)
ffffffffc0205438:	8d9a                	mv	s11,t1
ffffffffc020543a:	00f33823          	sd	a5,16(t1)
ffffffffc020543e:	0069b023          	sd	t1,0(s3)
ffffffffc0205442:	89da                	mv	s3,s6
ffffffffc0205444:	67c2                	ld	a5,16(sp)
ffffffffc0205446:	01b83423          	sd	s11,8(a6)
ffffffffc020544a:	00f83823          	sd	a5,16(a6)
ffffffffc020544e:	010db023          	sd	a6,0(s11)
ffffffffc0205452:	8dc2                	mv	s11,a6
ffffffffc0205454:	67a2                	ld	a5,8(sp)
ffffffffc0205456:	01b63423          	sd	s11,8(a2)
ffffffffc020545a:	ea1c                	sd	a5,16(a2)
ffffffffc020545c:	00cdb023          	sd	a2,0(s11)
ffffffffc0205460:	8db2                	mv	s11,a2
ffffffffc0205462:	6782                	ld	a5,0(sp)
ffffffffc0205464:	01ba3423          	sd	s11,8(s4)
ffffffffc0205468:	00fa3823          	sd	a5,16(s4)
ffffffffc020546c:	014db023          	sd	s4,0(s11)
ffffffffc0205470:	01493423          	sd	s4,8(s2)
ffffffffc0205474:	01993823          	sd	s9,16(s2)
ffffffffc0205478:	012a3023          	sd	s2,0(s4)
ffffffffc020547c:	b315                	j	ffffffffc02051a0 <stride_dequeue+0x194>
ffffffffc020547e:	84ca                	mv	s1,s2
ffffffffc0205480:	01a4b023          	sd	s10,0(s1)
ffffffffc0205484:	b335                	j	ffffffffc02051b0 <stride_dequeue+0x1a4>
ffffffffc0205486:	008db783          	ld	a5,8(s11)
ffffffffc020548a:	010dbc83          	ld	s9,16(s11)
ffffffffc020548e:	e42a                	sd	a0,8(sp)
ffffffffc0205490:	e03e                	sd	a5,0(sp)
ffffffffc0205492:	100c8563          	beqz	s9,ffffffffc020559c <stride_dequeue+0x590>
ffffffffc0205496:	85a6                	mv	a1,s1
ffffffffc0205498:	8566                	mv	a0,s9
ffffffffc020549a:	937ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020549e:	67a2                	ld	a5,8(sp)
ffffffffc02054a0:	4cf50e63          	beq	a0,a5,ffffffffc020597c <stride_dequeue+0x970>
ffffffffc02054a4:	649c                	ld	a5,8(s1)
ffffffffc02054a6:	0104ba03          	ld	s4,16(s1)
ffffffffc02054aa:	e43e                	sd	a5,8(sp)
ffffffffc02054ac:	0e0a0263          	beqz	s4,ffffffffc0205590 <stride_dequeue+0x584>
ffffffffc02054b0:	85d2                	mv	a1,s4
ffffffffc02054b2:	8566                	mv	a0,s9
ffffffffc02054b4:	91dff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02054b8:	58fd                	li	a7,-1
ffffffffc02054ba:	0d1505e3          	beq	a0,a7,ffffffffc0205d84 <stride_dequeue+0xd78>
ffffffffc02054be:	008a3783          	ld	a5,8(s4)
ffffffffc02054c2:	010a3803          	ld	a6,16(s4)
ffffffffc02054c6:	e83e                	sd	a5,16(sp)
ffffffffc02054c8:	0a080c63          	beqz	a6,ffffffffc0205580 <stride_dequeue+0x574>
ffffffffc02054cc:	85c2                	mv	a1,a6
ffffffffc02054ce:	8566                	mv	a0,s9
ffffffffc02054d0:	ec42                	sd	a6,24(sp)
ffffffffc02054d2:	8ffff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02054d6:	58fd                	li	a7,-1
ffffffffc02054d8:	6862                	ld	a6,24(sp)
ffffffffc02054da:	01151463          	bne	a0,a7,ffffffffc02054e2 <stride_dequeue+0x4d6>
ffffffffc02054de:	07c0106f          	j	ffffffffc020655a <stride_dequeue+0x154e>
ffffffffc02054e2:	00883783          	ld	a5,8(a6)
ffffffffc02054e6:	01083983          	ld	s3,16(a6)
ffffffffc02054ea:	ec3e                	sd	a5,24(sp)
ffffffffc02054ec:	00099463          	bnez	s3,ffffffffc02054f4 <stride_dequeue+0x4e8>
ffffffffc02054f0:	2bb0106f          	j	ffffffffc0206faa <stride_dequeue+0x1f9e>
ffffffffc02054f4:	85ce                	mv	a1,s3
ffffffffc02054f6:	8566                	mv	a0,s9
ffffffffc02054f8:	f042                	sd	a6,32(sp)
ffffffffc02054fa:	8d7ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02054fe:	58fd                	li	a7,-1
ffffffffc0205500:	7802                	ld	a6,32(sp)
ffffffffc0205502:	01151463          	bne	a0,a7,ffffffffc020550a <stride_dequeue+0x4fe>
ffffffffc0205506:	05f0106f          	j	ffffffffc0206d64 <stride_dequeue+0x1d58>
ffffffffc020550a:	0089b783          	ld	a5,8(s3)
ffffffffc020550e:	0109be03          	ld	t3,16(s3)
ffffffffc0205512:	f03e                	sd	a5,32(sp)
ffffffffc0205514:	040e0663          	beqz	t3,ffffffffc0205560 <stride_dequeue+0x554>
ffffffffc0205518:	85f2                	mv	a1,t3
ffffffffc020551a:	8566                	mv	a0,s9
ffffffffc020551c:	f842                	sd	a6,48(sp)
ffffffffc020551e:	f472                	sd	t3,40(sp)
ffffffffc0205520:	8b1ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205524:	58fd                	li	a7,-1
ffffffffc0205526:	7e22                	ld	t3,40(sp)
ffffffffc0205528:	7842                	ld	a6,48(sp)
ffffffffc020552a:	01151463          	bne	a0,a7,ffffffffc0205532 <stride_dequeue+0x526>
ffffffffc020552e:	4e70106f          	j	ffffffffc0207214 <stride_dequeue+0x2208>
ffffffffc0205532:	010e3583          	ld	a1,16(t3)
ffffffffc0205536:	8566                	mv	a0,s9
ffffffffc0205538:	008e3b03          	ld	s6,8(t3)
ffffffffc020553c:	f842                	sd	a6,48(sp)
ffffffffc020553e:	f472                	sd	t3,40(sp)
ffffffffc0205540:	8edff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205544:	7e22                	ld	t3,40(sp)
ffffffffc0205546:	7842                	ld	a6,48(sp)
ffffffffc0205548:	016e3823          	sd	s6,16(t3)
ffffffffc020554c:	00ae3423          	sd	a0,8(t3)
ffffffffc0205550:	010c2b03          	lw	s6,16(s8)
ffffffffc0205554:	e119                	bnez	a0,ffffffffc020555a <stride_dequeue+0x54e>
ffffffffc0205556:	7bb0106f          	j	ffffffffc0207510 <stride_dequeue+0x2504>
ffffffffc020555a:	01c53023          	sd	t3,0(a0)
ffffffffc020555e:	8cf2                	mv	s9,t3
ffffffffc0205560:	7782                	ld	a5,32(sp)
ffffffffc0205562:	0199b423          	sd	s9,8(s3)
ffffffffc0205566:	00f9b823          	sd	a5,16(s3)
ffffffffc020556a:	013cb023          	sd	s3,0(s9)
ffffffffc020556e:	67e2                	ld	a5,24(sp)
ffffffffc0205570:	01383423          	sd	s3,8(a6)
ffffffffc0205574:	8cc2                	mv	s9,a6
ffffffffc0205576:	00f83823          	sd	a5,16(a6)
ffffffffc020557a:	0109b023          	sd	a6,0(s3)
ffffffffc020557e:	89da                	mv	s3,s6
ffffffffc0205580:	67c2                	ld	a5,16(sp)
ffffffffc0205582:	019a3423          	sd	s9,8(s4)
ffffffffc0205586:	00fa3823          	sd	a5,16(s4)
ffffffffc020558a:	014cb023          	sd	s4,0(s9)
ffffffffc020558e:	8cd2                	mv	s9,s4
ffffffffc0205590:	67a2                	ld	a5,8(sp)
ffffffffc0205592:	0194b423          	sd	s9,8(s1)
ffffffffc0205596:	e89c                	sd	a5,16(s1)
ffffffffc0205598:	009cb023          	sd	s1,0(s9)
ffffffffc020559c:	6782                	ld	a5,0(sp)
ffffffffc020559e:	009db423          	sd	s1,8(s11)
ffffffffc02055a2:	00fdb823          	sd	a5,16(s11)
ffffffffc02055a6:	01b4b023          	sd	s11,0(s1)
ffffffffc02055aa:	84ee                	mv	s1,s11
ffffffffc02055ac:	bbad                	j	ffffffffc0205326 <stride_dequeue+0x31a>
ffffffffc02055ae:	008db783          	ld	a5,8(s11)
ffffffffc02055b2:	010db603          	ld	a2,16(s11)
ffffffffc02055b6:	e03e                	sd	a5,0(sp)
ffffffffc02055b8:	0e060963          	beqz	a2,ffffffffc02056aa <stride_dequeue+0x69e>
ffffffffc02055bc:	8532                	mv	a0,a2
ffffffffc02055be:	85d2                	mv	a1,s4
ffffffffc02055c0:	e432                	sd	a2,8(sp)
ffffffffc02055c2:	80fff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02055c6:	58fd                	li	a7,-1
ffffffffc02055c8:	6622                	ld	a2,8(sp)
ffffffffc02055ca:	091504e3          	beq	a0,a7,ffffffffc0205e52 <stride_dequeue+0xe46>
ffffffffc02055ce:	008a3783          	ld	a5,8(s4)
ffffffffc02055d2:	010a3803          	ld	a6,16(s4)
ffffffffc02055d6:	e43e                	sd	a5,8(sp)
ffffffffc02055d8:	0c080263          	beqz	a6,ffffffffc020569c <stride_dequeue+0x690>
ffffffffc02055dc:	85c2                	mv	a1,a6
ffffffffc02055de:	8532                	mv	a0,a2
ffffffffc02055e0:	ec42                	sd	a6,24(sp)
ffffffffc02055e2:	e832                	sd	a2,16(sp)
ffffffffc02055e4:	fecff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02055e8:	58fd                	li	a7,-1
ffffffffc02055ea:	6642                	ld	a2,16(sp)
ffffffffc02055ec:	6862                	ld	a6,24(sp)
ffffffffc02055ee:	01151463          	bne	a0,a7,ffffffffc02055f6 <stride_dequeue+0x5ea>
ffffffffc02055f2:	00a0106f          	j	ffffffffc02065fc <stride_dequeue+0x15f0>
ffffffffc02055f6:	00883783          	ld	a5,8(a6)
ffffffffc02055fa:	01083983          	ld	s3,16(a6)
ffffffffc02055fe:	e83e                	sd	a5,16(sp)
ffffffffc0205600:	00099463          	bnez	s3,ffffffffc0205608 <stride_dequeue+0x5fc>
ffffffffc0205604:	1e50106f          	j	ffffffffc0206fe8 <stride_dequeue+0x1fdc>
ffffffffc0205608:	8532                	mv	a0,a2
ffffffffc020560a:	85ce                	mv	a1,s3
ffffffffc020560c:	f042                	sd	a6,32(sp)
ffffffffc020560e:	ec32                	sd	a2,24(sp)
ffffffffc0205610:	fc0ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205614:	58fd                	li	a7,-1
ffffffffc0205616:	6662                	ld	a2,24(sp)
ffffffffc0205618:	7802                	ld	a6,32(sp)
ffffffffc020561a:	01151463          	bne	a0,a7,ffffffffc0205622 <stride_dequeue+0x616>
ffffffffc020561e:	4fc0106f          	j	ffffffffc0206b1a <stride_dequeue+0x1b0e>
ffffffffc0205622:	0089b783          	ld	a5,8(s3)
ffffffffc0205626:	0109be03          	ld	t3,16(s3)
ffffffffc020562a:	ec3e                	sd	a5,24(sp)
ffffffffc020562c:	040e0863          	beqz	t3,ffffffffc020567c <stride_dequeue+0x670>
ffffffffc0205630:	85f2                	mv	a1,t3
ffffffffc0205632:	8532                	mv	a0,a2
ffffffffc0205634:	f842                	sd	a6,48(sp)
ffffffffc0205636:	f472                	sd	t3,40(sp)
ffffffffc0205638:	f032                	sd	a2,32(sp)
ffffffffc020563a:	f96ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020563e:	7842                	ld	a6,48(sp)
ffffffffc0205640:	7e22                	ld	t3,40(sp)
ffffffffc0205642:	58fd                	li	a7,-1
ffffffffc0205644:	f442                	sd	a6,40(sp)
ffffffffc0205646:	7602                	ld	a2,32(sp)
ffffffffc0205648:	01151463          	bne	a0,a7,ffffffffc0205650 <stride_dequeue+0x644>
ffffffffc020564c:	37b0106f          	j	ffffffffc02071c6 <stride_dequeue+0x21ba>
ffffffffc0205650:	010e3583          	ld	a1,16(t3)
ffffffffc0205654:	8532                	mv	a0,a2
ffffffffc0205656:	008e3b03          	ld	s6,8(t3)
ffffffffc020565a:	f072                	sd	t3,32(sp)
ffffffffc020565c:	fd0ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205660:	7e02                	ld	t3,32(sp)
ffffffffc0205662:	7822                	ld	a6,40(sp)
ffffffffc0205664:	016e3823          	sd	s6,16(t3)
ffffffffc0205668:	00ae3423          	sd	a0,8(t3)
ffffffffc020566c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205670:	e119                	bnez	a0,ffffffffc0205676 <stride_dequeue+0x66a>
ffffffffc0205672:	7090106f          	j	ffffffffc020757a <stride_dequeue+0x256e>
ffffffffc0205676:	01c53023          	sd	t3,0(a0)
ffffffffc020567a:	8672                	mv	a2,t3
ffffffffc020567c:	67e2                	ld	a5,24(sp)
ffffffffc020567e:	00c9b423          	sd	a2,8(s3)
ffffffffc0205682:	00f9b823          	sd	a5,16(s3)
ffffffffc0205686:	01363023          	sd	s3,0(a2)
ffffffffc020568a:	67c2                	ld	a5,16(sp)
ffffffffc020568c:	01383423          	sd	s3,8(a6)
ffffffffc0205690:	8642                	mv	a2,a6
ffffffffc0205692:	00f83823          	sd	a5,16(a6)
ffffffffc0205696:	0109b023          	sd	a6,0(s3)
ffffffffc020569a:	89da                	mv	s3,s6
ffffffffc020569c:	67a2                	ld	a5,8(sp)
ffffffffc020569e:	00ca3423          	sd	a2,8(s4)
ffffffffc02056a2:	00fa3823          	sd	a5,16(s4)
ffffffffc02056a6:	01463023          	sd	s4,0(a2)
ffffffffc02056aa:	6782                	ld	a5,0(sp)
ffffffffc02056ac:	014db423          	sd	s4,8(s11)
ffffffffc02056b0:	00fdb823          	sd	a5,16(s11)
ffffffffc02056b4:	01ba3023          	sd	s11,0(s4)
ffffffffc02056b8:	8a6e                	mv	s4,s11
ffffffffc02056ba:	bb5d                	j	ffffffffc0205470 <stride_dequeue+0x464>
ffffffffc02056bc:	008db783          	ld	a5,8(s11)
ffffffffc02056c0:	010dba03          	ld	s4,16(s11)
ffffffffc02056c4:	e43e                	sd	a5,8(sp)
ffffffffc02056c6:	0e0a0163          	beqz	s4,ffffffffc02057a8 <stride_dequeue+0x79c>
ffffffffc02056ca:	85e6                	mv	a1,s9
ffffffffc02056cc:	8552                	mv	a0,s4
ffffffffc02056ce:	f02ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02056d2:	58fd                	li	a7,-1
ffffffffc02056d4:	05150de3          	beq	a0,a7,ffffffffc0205f2e <stride_dequeue+0xf22>
ffffffffc02056d8:	008cb783          	ld	a5,8(s9)
ffffffffc02056dc:	010cb803          	ld	a6,16(s9)
ffffffffc02056e0:	e83e                	sd	a5,16(sp)
ffffffffc02056e2:	0a080c63          	beqz	a6,ffffffffc020579a <stride_dequeue+0x78e>
ffffffffc02056e6:	85c2                	mv	a1,a6
ffffffffc02056e8:	8552                	mv	a0,s4
ffffffffc02056ea:	ec42                	sd	a6,24(sp)
ffffffffc02056ec:	ee4ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02056f0:	58fd                	li	a7,-1
ffffffffc02056f2:	6862                	ld	a6,24(sp)
ffffffffc02056f4:	01151463          	bne	a0,a7,ffffffffc02056fc <stride_dequeue+0x6f0>
ffffffffc02056f8:	7ab0006f          	j	ffffffffc02066a2 <stride_dequeue+0x1696>
ffffffffc02056fc:	00883783          	ld	a5,8(a6)
ffffffffc0205700:	01083983          	ld	s3,16(a6)
ffffffffc0205704:	ec3e                	sd	a5,24(sp)
ffffffffc0205706:	00099463          	bnez	s3,ffffffffc020570e <stride_dequeue+0x702>
ffffffffc020570a:	0cd0106f          	j	ffffffffc0206fd6 <stride_dequeue+0x1fca>
ffffffffc020570e:	85ce                	mv	a1,s3
ffffffffc0205710:	8552                	mv	a0,s4
ffffffffc0205712:	f042                	sd	a6,32(sp)
ffffffffc0205714:	ebcff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205718:	58fd                	li	a7,-1
ffffffffc020571a:	7802                	ld	a6,32(sp)
ffffffffc020571c:	01151463          	bne	a0,a7,ffffffffc0205724 <stride_dequeue+0x718>
ffffffffc0205720:	39c0106f          	j	ffffffffc0206abc <stride_dequeue+0x1ab0>
ffffffffc0205724:	0089b783          	ld	a5,8(s3)
ffffffffc0205728:	0109be03          	ld	t3,16(s3)
ffffffffc020572c:	f03e                	sd	a5,32(sp)
ffffffffc020572e:	040e0663          	beqz	t3,ffffffffc020577a <stride_dequeue+0x76e>
ffffffffc0205732:	85f2                	mv	a1,t3
ffffffffc0205734:	8552                	mv	a0,s4
ffffffffc0205736:	f842                	sd	a6,48(sp)
ffffffffc0205738:	f472                	sd	t3,40(sp)
ffffffffc020573a:	e96ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020573e:	58fd                	li	a7,-1
ffffffffc0205740:	7e22                	ld	t3,40(sp)
ffffffffc0205742:	7842                	ld	a6,48(sp)
ffffffffc0205744:	01151463          	bne	a0,a7,ffffffffc020574c <stride_dequeue+0x740>
ffffffffc0205748:	2f90106f          	j	ffffffffc0207240 <stride_dequeue+0x2234>
ffffffffc020574c:	010e3583          	ld	a1,16(t3)
ffffffffc0205750:	8552                	mv	a0,s4
ffffffffc0205752:	008e3b03          	ld	s6,8(t3)
ffffffffc0205756:	f842                	sd	a6,48(sp)
ffffffffc0205758:	f472                	sd	t3,40(sp)
ffffffffc020575a:	ed2ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020575e:	7e22                	ld	t3,40(sp)
ffffffffc0205760:	7842                	ld	a6,48(sp)
ffffffffc0205762:	016e3823          	sd	s6,16(t3)
ffffffffc0205766:	00ae3423          	sd	a0,8(t3)
ffffffffc020576a:	010c2b03          	lw	s6,16(s8)
ffffffffc020576e:	e119                	bnez	a0,ffffffffc0205774 <stride_dequeue+0x768>
ffffffffc0205770:	5a70106f          	j	ffffffffc0207516 <stride_dequeue+0x250a>
ffffffffc0205774:	01c53023          	sd	t3,0(a0)
ffffffffc0205778:	8a72                	mv	s4,t3
ffffffffc020577a:	7782                	ld	a5,32(sp)
ffffffffc020577c:	0149b423          	sd	s4,8(s3)
ffffffffc0205780:	00f9b823          	sd	a5,16(s3)
ffffffffc0205784:	013a3023          	sd	s3,0(s4)
ffffffffc0205788:	67e2                	ld	a5,24(sp)
ffffffffc020578a:	01383423          	sd	s3,8(a6)
ffffffffc020578e:	8a42                	mv	s4,a6
ffffffffc0205790:	00f83823          	sd	a5,16(a6)
ffffffffc0205794:	0109b023          	sd	a6,0(s3)
ffffffffc0205798:	89da                	mv	s3,s6
ffffffffc020579a:	67c2                	ld	a5,16(sp)
ffffffffc020579c:	014cb423          	sd	s4,8(s9)
ffffffffc02057a0:	00fcb823          	sd	a5,16(s9)
ffffffffc02057a4:	019a3023          	sd	s9,0(s4)
ffffffffc02057a8:	67a2                	ld	a5,8(sp)
ffffffffc02057aa:	019db423          	sd	s9,8(s11)
ffffffffc02057ae:	00fdb823          	sd	a5,16(s11)
ffffffffc02057b2:	01bcb023          	sd	s11,0(s9)
ffffffffc02057b6:	b695                	j	ffffffffc020531a <stride_dequeue+0x30e>
ffffffffc02057b8:	00893783          	ld	a5,8(s2)
ffffffffc02057bc:	01093883          	ld	a7,16(s2)
ffffffffc02057c0:	ec2a                	sd	a0,24(sp)
ffffffffc02057c2:	e83e                	sd	a5,16(sp)
ffffffffc02057c4:	0a088963          	beqz	a7,ffffffffc0205876 <stride_dequeue+0x86a>
ffffffffc02057c8:	8546                	mv	a0,a7
ffffffffc02057ca:	85e6                	mv	a1,s9
ffffffffc02057cc:	f046                	sd	a7,32(sp)
ffffffffc02057ce:	e02ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02057d2:	6862                	ld	a6,24(sp)
ffffffffc02057d4:	7882                	ld	a7,32(sp)
ffffffffc02057d6:	030504e3          	beq	a0,a6,ffffffffc0205ffe <stride_dequeue+0xff2>
ffffffffc02057da:	008cb783          	ld	a5,8(s9)
ffffffffc02057de:	010cb303          	ld	t1,16(s9)
ffffffffc02057e2:	f042                	sd	a6,32(sp)
ffffffffc02057e4:	ec3e                	sd	a5,24(sp)
ffffffffc02057e6:	08030163          	beqz	t1,ffffffffc0205868 <stride_dequeue+0x85c>
ffffffffc02057ea:	859a                	mv	a1,t1
ffffffffc02057ec:	8546                	mv	a0,a7
ffffffffc02057ee:	f81a                	sd	t1,48(sp)
ffffffffc02057f0:	f446                	sd	a7,40(sp)
ffffffffc02057f2:	ddeff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02057f6:	7802                	ld	a6,32(sp)
ffffffffc02057f8:	78a2                	ld	a7,40(sp)
ffffffffc02057fa:	7342                	ld	t1,48(sp)
ffffffffc02057fc:	01051463          	bne	a0,a6,ffffffffc0205804 <stride_dequeue+0x7f8>
ffffffffc0205800:	0d00106f          	j	ffffffffc02068d0 <stride_dequeue+0x18c4>
ffffffffc0205804:	00833783          	ld	a5,8(t1)
ffffffffc0205808:	01033983          	ld	s3,16(t1)
ffffffffc020580c:	f442                	sd	a6,40(sp)
ffffffffc020580e:	f03e                	sd	a5,32(sp)
ffffffffc0205810:	00099463          	bnez	s3,ffffffffc0205818 <stride_dequeue+0x80c>
ffffffffc0205814:	6720106f          	j	ffffffffc0206e86 <stride_dequeue+0x1e7a>
ffffffffc0205818:	8546                	mv	a0,a7
ffffffffc020581a:	85ce                	mv	a1,s3
ffffffffc020581c:	fc1a                	sd	t1,56(sp)
ffffffffc020581e:	f846                	sd	a7,48(sp)
ffffffffc0205820:	db0ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205824:	7822                	ld	a6,40(sp)
ffffffffc0205826:	78c2                	ld	a7,48(sp)
ffffffffc0205828:	7362                	ld	t1,56(sp)
ffffffffc020582a:	01051463          	bne	a0,a6,ffffffffc0205832 <stride_dequeue+0x826>
ffffffffc020582e:	6700106f          	j	ffffffffc0206e9e <stride_dequeue+0x1e92>
ffffffffc0205832:	0109b583          	ld	a1,16(s3)
ffffffffc0205836:	0089bb03          	ld	s6,8(s3)
ffffffffc020583a:	8546                	mv	a0,a7
ffffffffc020583c:	f41a                	sd	t1,40(sp)
ffffffffc020583e:	deeff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205842:	00a9b423          	sd	a0,8(s3)
ffffffffc0205846:	0169b823          	sd	s6,16(s3)
ffffffffc020584a:	7322                	ld	t1,40(sp)
ffffffffc020584c:	010c2b03          	lw	s6,16(s8)
ffffffffc0205850:	c119                	beqz	a0,ffffffffc0205856 <stride_dequeue+0x84a>
ffffffffc0205852:	01353023          	sd	s3,0(a0)
ffffffffc0205856:	7782                	ld	a5,32(sp)
ffffffffc0205858:	01333423          	sd	s3,8(t1)
ffffffffc020585c:	889a                	mv	a7,t1
ffffffffc020585e:	00f33823          	sd	a5,16(t1)
ffffffffc0205862:	0069b023          	sd	t1,0(s3)
ffffffffc0205866:	89da                	mv	s3,s6
ffffffffc0205868:	67e2                	ld	a5,24(sp)
ffffffffc020586a:	011cb423          	sd	a7,8(s9)
ffffffffc020586e:	00fcb823          	sd	a5,16(s9)
ffffffffc0205872:	0198b023          	sd	s9,0(a7)
ffffffffc0205876:	67c2                	ld	a5,16(sp)
ffffffffc0205878:	01993423          	sd	s9,8(s2)
ffffffffc020587c:	00f93823          	sd	a5,16(s2)
ffffffffc0205880:	012cb023          	sd	s2,0(s9)
ffffffffc0205884:	b8f5                	j	ffffffffc0205180 <stride_dequeue+0x174>
ffffffffc0205886:	00893783          	ld	a5,8(s2)
ffffffffc020588a:	01093c83          	ld	s9,16(s2)
ffffffffc020588e:	e43e                	sd	a5,8(sp)
ffffffffc0205890:	0c0c8d63          	beqz	s9,ffffffffc020596a <stride_dequeue+0x95e>
ffffffffc0205894:	85ee                	mv	a1,s11
ffffffffc0205896:	8566                	mv	a0,s9
ffffffffc0205898:	d38ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020589c:	58fd                	li	a7,-1
ffffffffc020589e:	39150063          	beq	a0,a7,ffffffffc0205c1e <stride_dequeue+0xc12>
ffffffffc02058a2:	008db783          	ld	a5,8(s11)
ffffffffc02058a6:	010db803          	ld	a6,16(s11)
ffffffffc02058aa:	e83e                	sd	a5,16(sp)
ffffffffc02058ac:	0a080863          	beqz	a6,ffffffffc020595c <stride_dequeue+0x950>
ffffffffc02058b0:	85c2                	mv	a1,a6
ffffffffc02058b2:	8566                	mv	a0,s9
ffffffffc02058b4:	ec42                	sd	a6,24(sp)
ffffffffc02058b6:	d1aff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02058ba:	58fd                	li	a7,-1
ffffffffc02058bc:	6862                	ld	a6,24(sp)
ffffffffc02058be:	7d150f63          	beq	a0,a7,ffffffffc020609c <stride_dequeue+0x1090>
ffffffffc02058c2:	00883783          	ld	a5,8(a6)
ffffffffc02058c6:	01083303          	ld	t1,16(a6)
ffffffffc02058ca:	ec3e                	sd	a5,24(sp)
ffffffffc02058cc:	08030063          	beqz	t1,ffffffffc020594c <stride_dequeue+0x940>
ffffffffc02058d0:	859a                	mv	a1,t1
ffffffffc02058d2:	8566                	mv	a0,s9
ffffffffc02058d4:	f442                	sd	a6,40(sp)
ffffffffc02058d6:	f01a                	sd	t1,32(sp)
ffffffffc02058d8:	cf8ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02058dc:	58fd                	li	a7,-1
ffffffffc02058de:	7302                	ld	t1,32(sp)
ffffffffc02058e0:	7822                	ld	a6,40(sp)
ffffffffc02058e2:	65150fe3          	beq	a0,a7,ffffffffc0206740 <stride_dequeue+0x1734>
ffffffffc02058e6:	00833783          	ld	a5,8(t1)
ffffffffc02058ea:	01033983          	ld	s3,16(t1)
ffffffffc02058ee:	f03e                	sd	a5,32(sp)
ffffffffc02058f0:	00099463          	bnez	s3,ffffffffc02058f8 <stride_dequeue+0x8ec>
ffffffffc02058f4:	5980106f          	j	ffffffffc0206e8c <stride_dequeue+0x1e80>
ffffffffc02058f8:	85ce                	mv	a1,s3
ffffffffc02058fa:	8566                	mv	a0,s9
ffffffffc02058fc:	f81a                	sd	t1,48(sp)
ffffffffc02058fe:	f442                	sd	a6,40(sp)
ffffffffc0205900:	cd0ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205904:	58fd                	li	a7,-1
ffffffffc0205906:	7822                	ld	a6,40(sp)
ffffffffc0205908:	7342                	ld	t1,48(sp)
ffffffffc020590a:	01151463          	bne	a0,a7,ffffffffc0205912 <stride_dequeue+0x906>
ffffffffc020590e:	5ea0106f          	j	ffffffffc0206ef8 <stride_dequeue+0x1eec>
ffffffffc0205912:	0109b583          	ld	a1,16(s3)
ffffffffc0205916:	0089bb03          	ld	s6,8(s3)
ffffffffc020591a:	8566                	mv	a0,s9
ffffffffc020591c:	f81a                	sd	t1,48(sp)
ffffffffc020591e:	f442                	sd	a6,40(sp)
ffffffffc0205920:	d0cff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205924:	00a9b423          	sd	a0,8(s3)
ffffffffc0205928:	0169b823          	sd	s6,16(s3)
ffffffffc020592c:	7822                	ld	a6,40(sp)
ffffffffc020592e:	7342                	ld	t1,48(sp)
ffffffffc0205930:	010c2b03          	lw	s6,16(s8)
ffffffffc0205934:	c119                	beqz	a0,ffffffffc020593a <stride_dequeue+0x92e>
ffffffffc0205936:	01353023          	sd	s3,0(a0)
ffffffffc020593a:	7782                	ld	a5,32(sp)
ffffffffc020593c:	01333423          	sd	s3,8(t1)
ffffffffc0205940:	8c9a                	mv	s9,t1
ffffffffc0205942:	00f33823          	sd	a5,16(t1)
ffffffffc0205946:	0069b023          	sd	t1,0(s3)
ffffffffc020594a:	89da                	mv	s3,s6
ffffffffc020594c:	67e2                	ld	a5,24(sp)
ffffffffc020594e:	01983423          	sd	s9,8(a6)
ffffffffc0205952:	00f83823          	sd	a5,16(a6)
ffffffffc0205956:	010cb023          	sd	a6,0(s9)
ffffffffc020595a:	8cc2                	mv	s9,a6
ffffffffc020595c:	67c2                	ld	a5,16(sp)
ffffffffc020595e:	019db423          	sd	s9,8(s11)
ffffffffc0205962:	00fdb823          	sd	a5,16(s11)
ffffffffc0205966:	01bcb023          	sd	s11,0(s9)
ffffffffc020596a:	67a2                	ld	a5,8(sp)
ffffffffc020596c:	01b93423          	sd	s11,8(s2)
ffffffffc0205970:	00f93823          	sd	a5,16(s2)
ffffffffc0205974:	012db023          	sd	s2,0(s11)
ffffffffc0205978:	819ff06f          	j	ffffffffc0205190 <stride_dequeue+0x184>
ffffffffc020597c:	008cb783          	ld	a5,8(s9)
ffffffffc0205980:	010cba03          	ld	s4,16(s9)
ffffffffc0205984:	e43e                	sd	a5,8(sp)
ffffffffc0205986:	0c0a0d63          	beqz	s4,ffffffffc0205a60 <stride_dequeue+0xa54>
ffffffffc020598a:	85a6                	mv	a1,s1
ffffffffc020598c:	8552                	mv	a0,s4
ffffffffc020598e:	c42ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205992:	58fd                	li	a7,-1
ffffffffc0205994:	151500e3          	beq	a0,a7,ffffffffc02062d4 <stride_dequeue+0x12c8>
ffffffffc0205998:	649c                	ld	a5,8(s1)
ffffffffc020599a:	0104b983          	ld	s3,16(s1)
ffffffffc020599e:	e83e                	sd	a5,16(sp)
ffffffffc02059a0:	00099463          	bnez	s3,ffffffffc02059a8 <stride_dequeue+0x99c>
ffffffffc02059a4:	4f40106f          	j	ffffffffc0206e98 <stride_dequeue+0x1e8c>
ffffffffc02059a8:	85ce                	mv	a1,s3
ffffffffc02059aa:	8552                	mv	a0,s4
ffffffffc02059ac:	c24ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02059b0:	58fd                	li	a7,-1
ffffffffc02059b2:	01151463          	bne	a0,a7,ffffffffc02059ba <stride_dequeue+0x9ae>
ffffffffc02059b6:	0b00106f          	j	ffffffffc0206a66 <stride_dequeue+0x1a5a>
ffffffffc02059ba:	0089b783          	ld	a5,8(s3)
ffffffffc02059be:	0109b303          	ld	t1,16(s3)
ffffffffc02059c2:	ec3e                	sd	a5,24(sp)
ffffffffc02059c4:	08030063          	beqz	t1,ffffffffc0205a44 <stride_dequeue+0xa38>
ffffffffc02059c8:	859a                	mv	a1,t1
ffffffffc02059ca:	8552                	mv	a0,s4
ffffffffc02059cc:	f01a                	sd	t1,32(sp)
ffffffffc02059ce:	c02ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02059d2:	58fd                	li	a7,-1
ffffffffc02059d4:	7302                	ld	t1,32(sp)
ffffffffc02059d6:	01151463          	bne	a0,a7,ffffffffc02059de <stride_dequeue+0x9d2>
ffffffffc02059da:	0130106f          	j	ffffffffc02071ec <stride_dequeue+0x21e0>
ffffffffc02059de:	00833783          	ld	a5,8(t1)
ffffffffc02059e2:	01033e03          	ld	t3,16(t1)
ffffffffc02059e6:	f03e                	sd	a5,32(sp)
ffffffffc02059e8:	040e0663          	beqz	t3,ffffffffc0205a34 <stride_dequeue+0xa28>
ffffffffc02059ec:	85f2                	mv	a1,t3
ffffffffc02059ee:	8552                	mv	a0,s4
ffffffffc02059f0:	f81a                	sd	t1,48(sp)
ffffffffc02059f2:	f472                	sd	t3,40(sp)
ffffffffc02059f4:	bdcff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02059f8:	58fd                	li	a7,-1
ffffffffc02059fa:	7e22                	ld	t3,40(sp)
ffffffffc02059fc:	7342                	ld	t1,48(sp)
ffffffffc02059fe:	01151463          	bne	a0,a7,ffffffffc0205a06 <stride_dequeue+0x9fa>
ffffffffc0205a02:	53d0106f          	j	ffffffffc020773e <stride_dequeue+0x2732>
ffffffffc0205a06:	010e3583          	ld	a1,16(t3)
ffffffffc0205a0a:	8552                	mv	a0,s4
ffffffffc0205a0c:	008e3b03          	ld	s6,8(t3)
ffffffffc0205a10:	f81a                	sd	t1,48(sp)
ffffffffc0205a12:	f472                	sd	t3,40(sp)
ffffffffc0205a14:	c18ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205a18:	7e22                	ld	t3,40(sp)
ffffffffc0205a1a:	7342                	ld	t1,48(sp)
ffffffffc0205a1c:	016e3823          	sd	s6,16(t3)
ffffffffc0205a20:	00ae3423          	sd	a0,8(t3)
ffffffffc0205a24:	010c2b03          	lw	s6,16(s8)
ffffffffc0205a28:	e119                	bnez	a0,ffffffffc0205a2e <stride_dequeue+0xa22>
ffffffffc0205a2a:	76d0106f          	j	ffffffffc0207996 <stride_dequeue+0x298a>
ffffffffc0205a2e:	01c53023          	sd	t3,0(a0)
ffffffffc0205a32:	8a72                	mv	s4,t3
ffffffffc0205a34:	7782                	ld	a5,32(sp)
ffffffffc0205a36:	01433423          	sd	s4,8(t1)
ffffffffc0205a3a:	00f33823          	sd	a5,16(t1)
ffffffffc0205a3e:	006a3023          	sd	t1,0(s4)
ffffffffc0205a42:	8a1a                	mv	s4,t1
ffffffffc0205a44:	67e2                	ld	a5,24(sp)
ffffffffc0205a46:	0149b423          	sd	s4,8(s3)
ffffffffc0205a4a:	00f9b823          	sd	a5,16(s3)
ffffffffc0205a4e:	013a3023          	sd	s3,0(s4)
ffffffffc0205a52:	67c2                	ld	a5,16(sp)
ffffffffc0205a54:	0134b423          	sd	s3,8(s1)
ffffffffc0205a58:	e89c                	sd	a5,16(s1)
ffffffffc0205a5a:	0099b023          	sd	s1,0(s3)
ffffffffc0205a5e:	89da                	mv	s3,s6
ffffffffc0205a60:	67a2                	ld	a5,8(sp)
ffffffffc0205a62:	009cb423          	sd	s1,8(s9)
ffffffffc0205a66:	00fcb823          	sd	a5,16(s9)
ffffffffc0205a6a:	0194b023          	sd	s9,0(s1)
ffffffffc0205a6e:	84e6                	mv	s1,s9
ffffffffc0205a70:	b635                	j	ffffffffc020559c <stride_dequeue+0x590>
ffffffffc0205a72:	008db783          	ld	a5,8(s11)
ffffffffc0205a76:	010db883          	ld	a7,16(s11)
ffffffffc0205a7a:	ec2a                	sd	a0,24(sp)
ffffffffc0205a7c:	e83e                	sd	a5,16(sp)
ffffffffc0205a7e:	0a088963          	beqz	a7,ffffffffc0205b30 <stride_dequeue+0xb24>
ffffffffc0205a82:	8546                	mv	a0,a7
ffffffffc0205a84:	85d2                	mv	a1,s4
ffffffffc0205a86:	f046                	sd	a7,32(sp)
ffffffffc0205a88:	b48ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205a8c:	6862                	ld	a6,24(sp)
ffffffffc0205a8e:	7882                	ld	a7,32(sp)
ffffffffc0205a90:	0d050ae3          	beq	a0,a6,ffffffffc0206364 <stride_dequeue+0x1358>
ffffffffc0205a94:	008a3783          	ld	a5,8(s4)
ffffffffc0205a98:	010a3983          	ld	s3,16(s4)
ffffffffc0205a9c:	f042                	sd	a6,32(sp)
ffffffffc0205a9e:	ec3e                	sd	a5,24(sp)
ffffffffc0205aa0:	00099463          	bnez	s3,ffffffffc0205aa8 <stride_dequeue+0xa9c>
ffffffffc0205aa4:	53e0106f          	j	ffffffffc0206fe2 <stride_dequeue+0x1fd6>
ffffffffc0205aa8:	8546                	mv	a0,a7
ffffffffc0205aaa:	85ce                	mv	a1,s3
ffffffffc0205aac:	f446                	sd	a7,40(sp)
ffffffffc0205aae:	b22ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205ab2:	7802                	ld	a6,32(sp)
ffffffffc0205ab4:	78a2                	ld	a7,40(sp)
ffffffffc0205ab6:	01051463          	bne	a0,a6,ffffffffc0205abe <stride_dequeue+0xab2>
ffffffffc0205aba:	1260106f          	j	ffffffffc0206be0 <stride_dequeue+0x1bd4>
ffffffffc0205abe:	0089b783          	ld	a5,8(s3)
ffffffffc0205ac2:	0109be03          	ld	t3,16(s3)
ffffffffc0205ac6:	f442                	sd	a6,40(sp)
ffffffffc0205ac8:	f03e                	sd	a5,32(sp)
ffffffffc0205aca:	040e0463          	beqz	t3,ffffffffc0205b12 <stride_dequeue+0xb06>
ffffffffc0205ace:	85f2                	mv	a1,t3
ffffffffc0205ad0:	8546                	mv	a0,a7
ffffffffc0205ad2:	fc72                	sd	t3,56(sp)
ffffffffc0205ad4:	f846                	sd	a7,48(sp)
ffffffffc0205ad6:	afaff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205ada:	7822                	ld	a6,40(sp)
ffffffffc0205adc:	78c2                	ld	a7,48(sp)
ffffffffc0205ade:	7e62                	ld	t3,56(sp)
ffffffffc0205ae0:	01051463          	bne	a0,a6,ffffffffc0205ae8 <stride_dequeue+0xadc>
ffffffffc0205ae4:	0e70106f          	j	ffffffffc02073ca <stride_dequeue+0x23be>
ffffffffc0205ae8:	010e3583          	ld	a1,16(t3)
ffffffffc0205aec:	8546                	mv	a0,a7
ffffffffc0205aee:	008e3b03          	ld	s6,8(t3)
ffffffffc0205af2:	f472                	sd	t3,40(sp)
ffffffffc0205af4:	b38ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205af8:	7e22                	ld	t3,40(sp)
ffffffffc0205afa:	016e3823          	sd	s6,16(t3)
ffffffffc0205afe:	00ae3423          	sd	a0,8(t3)
ffffffffc0205b02:	010c2b03          	lw	s6,16(s8)
ffffffffc0205b06:	e119                	bnez	a0,ffffffffc0205b0c <stride_dequeue+0xb00>
ffffffffc0205b08:	1c10106f          	j	ffffffffc02074c8 <stride_dequeue+0x24bc>
ffffffffc0205b0c:	01c53023          	sd	t3,0(a0)
ffffffffc0205b10:	88f2                	mv	a7,t3
ffffffffc0205b12:	7782                	ld	a5,32(sp)
ffffffffc0205b14:	0119b423          	sd	a7,8(s3)
ffffffffc0205b18:	00f9b823          	sd	a5,16(s3)
ffffffffc0205b1c:	0138b023          	sd	s3,0(a7)
ffffffffc0205b20:	67e2                	ld	a5,24(sp)
ffffffffc0205b22:	013a3423          	sd	s3,8(s4)
ffffffffc0205b26:	00fa3823          	sd	a5,16(s4)
ffffffffc0205b2a:	0149b023          	sd	s4,0(s3)
ffffffffc0205b2e:	89da                	mv	s3,s6
ffffffffc0205b30:	67c2                	ld	a5,16(sp)
ffffffffc0205b32:	014db423          	sd	s4,8(s11)
ffffffffc0205b36:	00fdb823          	sd	a5,16(s11)
ffffffffc0205b3a:	01ba3023          	sd	s11,0(s4)
ffffffffc0205b3e:	fccff06f          	j	ffffffffc020530a <stride_dequeue+0x2fe>
ffffffffc0205b42:	008db783          	ld	a5,8(s11)
ffffffffc0205b46:	010db883          	ld	a7,16(s11)
ffffffffc0205b4a:	e82a                	sd	a0,16(sp)
ffffffffc0205b4c:	e43e                	sd	a5,8(sp)
ffffffffc0205b4e:	0a088f63          	beqz	a7,ffffffffc0205c0c <stride_dequeue+0xc00>
ffffffffc0205b52:	85b2                	mv	a1,a2
ffffffffc0205b54:	8546                	mv	a0,a7
ffffffffc0205b56:	f032                	sd	a2,32(sp)
ffffffffc0205b58:	ec46                	sd	a7,24(sp)
ffffffffc0205b5a:	a76ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205b5e:	6842                	ld	a6,16(sp)
ffffffffc0205b60:	68e2                	ld	a7,24(sp)
ffffffffc0205b62:	7602                	ld	a2,32(sp)
ffffffffc0205b64:	150506e3          	beq	a0,a6,ffffffffc02064b0 <stride_dequeue+0x14a4>
ffffffffc0205b68:	661c                	ld	a5,8(a2)
ffffffffc0205b6a:	01063983          	ld	s3,16(a2)
ffffffffc0205b6e:	ec42                	sd	a6,24(sp)
ffffffffc0205b70:	e83e                	sd	a5,16(sp)
ffffffffc0205b72:	00099463          	bnez	s3,ffffffffc0205b7a <stride_dequeue+0xb6e>
ffffffffc0205b76:	4660106f          	j	ffffffffc0206fdc <stride_dequeue+0x1fd0>
ffffffffc0205b7a:	8546                	mv	a0,a7
ffffffffc0205b7c:	85ce                	mv	a1,s3
ffffffffc0205b7e:	f432                	sd	a2,40(sp)
ffffffffc0205b80:	f046                	sd	a7,32(sp)
ffffffffc0205b82:	a4eff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205b86:	6862                	ld	a6,24(sp)
ffffffffc0205b88:	7882                	ld	a7,32(sp)
ffffffffc0205b8a:	7622                	ld	a2,40(sp)
ffffffffc0205b8c:	01051463          	bne	a0,a6,ffffffffc0205b94 <stride_dequeue+0xb88>
ffffffffc0205b90:	0ae0106f          	j	ffffffffc0206c3e <stride_dequeue+0x1c32>
ffffffffc0205b94:	0089b783          	ld	a5,8(s3)
ffffffffc0205b98:	0109be03          	ld	t3,16(s3)
ffffffffc0205b9c:	f042                	sd	a6,32(sp)
ffffffffc0205b9e:	ec3e                	sd	a5,24(sp)
ffffffffc0205ba0:	040e0863          	beqz	t3,ffffffffc0205bf0 <stride_dequeue+0xbe4>
ffffffffc0205ba4:	85f2                	mv	a1,t3
ffffffffc0205ba6:	8546                	mv	a0,a7
ffffffffc0205ba8:	fc32                	sd	a2,56(sp)
ffffffffc0205baa:	f872                	sd	t3,48(sp)
ffffffffc0205bac:	f446                	sd	a7,40(sp)
ffffffffc0205bae:	a22ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205bb2:	7662                	ld	a2,56(sp)
ffffffffc0205bb4:	7802                	ld	a6,32(sp)
ffffffffc0205bb6:	78a2                	ld	a7,40(sp)
ffffffffc0205bb8:	f432                	sd	a2,40(sp)
ffffffffc0205bba:	7e42                	ld	t3,48(sp)
ffffffffc0205bbc:	01051463          	bne	a0,a6,ffffffffc0205bc4 <stride_dequeue+0xbb8>
ffffffffc0205bc0:	6ac0106f          	j	ffffffffc020726c <stride_dequeue+0x2260>
ffffffffc0205bc4:	010e3583          	ld	a1,16(t3)
ffffffffc0205bc8:	8546                	mv	a0,a7
ffffffffc0205bca:	008e3b03          	ld	s6,8(t3)
ffffffffc0205bce:	f072                	sd	t3,32(sp)
ffffffffc0205bd0:	a5cff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205bd4:	7e02                	ld	t3,32(sp)
ffffffffc0205bd6:	7622                	ld	a2,40(sp)
ffffffffc0205bd8:	016e3823          	sd	s6,16(t3)
ffffffffc0205bdc:	00ae3423          	sd	a0,8(t3)
ffffffffc0205be0:	010c2b03          	lw	s6,16(s8)
ffffffffc0205be4:	e119                	bnez	a0,ffffffffc0205bea <stride_dequeue+0xbde>
ffffffffc0205be6:	1370106f          	j	ffffffffc020751c <stride_dequeue+0x2510>
ffffffffc0205bea:	01c53023          	sd	t3,0(a0)
ffffffffc0205bee:	88f2                	mv	a7,t3
ffffffffc0205bf0:	67e2                	ld	a5,24(sp)
ffffffffc0205bf2:	0119b423          	sd	a7,8(s3)
ffffffffc0205bf6:	00f9b823          	sd	a5,16(s3)
ffffffffc0205bfa:	0138b023          	sd	s3,0(a7)
ffffffffc0205bfe:	67c2                	ld	a5,16(sp)
ffffffffc0205c00:	01363423          	sd	s3,8(a2)
ffffffffc0205c04:	ea1c                	sd	a5,16(a2)
ffffffffc0205c06:	00c9b023          	sd	a2,0(s3)
ffffffffc0205c0a:	89da                	mv	s3,s6
ffffffffc0205c0c:	67a2                	ld	a5,8(sp)
ffffffffc0205c0e:	00cdb423          	sd	a2,8(s11)
ffffffffc0205c12:	00fdb823          	sd	a5,16(s11)
ffffffffc0205c16:	01b63023          	sd	s11,0(a2)
ffffffffc0205c1a:	849ff06f          	j	ffffffffc0205462 <stride_dequeue+0x456>
ffffffffc0205c1e:	008cb783          	ld	a5,8(s9)
ffffffffc0205c22:	010cb883          	ld	a7,16(s9)
ffffffffc0205c26:	ec2a                	sd	a0,24(sp)
ffffffffc0205c28:	e83e                	sd	a5,16(sp)
ffffffffc0205c2a:	0a088963          	beqz	a7,ffffffffc0205cdc <stride_dequeue+0xcd0>
ffffffffc0205c2e:	8546                	mv	a0,a7
ffffffffc0205c30:	85ee                	mv	a1,s11
ffffffffc0205c32:	f046                	sd	a7,32(sp)
ffffffffc0205c34:	99cff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205c38:	6862                	ld	a6,24(sp)
ffffffffc0205c3a:	7882                	ld	a7,32(sp)
ffffffffc0205c3c:	7d050863          	beq	a0,a6,ffffffffc020640c <stride_dequeue+0x1400>
ffffffffc0205c40:	008db783          	ld	a5,8(s11)
ffffffffc0205c44:	010db983          	ld	s3,16(s11)
ffffffffc0205c48:	f042                	sd	a6,32(sp)
ffffffffc0205c4a:	ec3e                	sd	a5,24(sp)
ffffffffc0205c4c:	00099463          	bnez	s3,ffffffffc0205c54 <stride_dequeue+0xc48>
ffffffffc0205c50:	3600106f          	j	ffffffffc0206fb0 <stride_dequeue+0x1fa4>
ffffffffc0205c54:	8546                	mv	a0,a7
ffffffffc0205c56:	85ce                	mv	a1,s3
ffffffffc0205c58:	f446                	sd	a7,40(sp)
ffffffffc0205c5a:	976ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205c5e:	7802                	ld	a6,32(sp)
ffffffffc0205c60:	78a2                	ld	a7,40(sp)
ffffffffc0205c62:	01051463          	bne	a0,a6,ffffffffc0205c6a <stride_dequeue+0xc5e>
ffffffffc0205c66:	71d0006f          	j	ffffffffc0206b82 <stride_dequeue+0x1b76>
ffffffffc0205c6a:	0089b783          	ld	a5,8(s3)
ffffffffc0205c6e:	0109be03          	ld	t3,16(s3)
ffffffffc0205c72:	f442                	sd	a6,40(sp)
ffffffffc0205c74:	f03e                	sd	a5,32(sp)
ffffffffc0205c76:	040e0463          	beqz	t3,ffffffffc0205cbe <stride_dequeue+0xcb2>
ffffffffc0205c7a:	85f2                	mv	a1,t3
ffffffffc0205c7c:	8546                	mv	a0,a7
ffffffffc0205c7e:	fc72                	sd	t3,56(sp)
ffffffffc0205c80:	f846                	sd	a7,48(sp)
ffffffffc0205c82:	94eff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205c86:	7822                	ld	a6,40(sp)
ffffffffc0205c88:	78c2                	ld	a7,48(sp)
ffffffffc0205c8a:	7e62                	ld	t3,56(sp)
ffffffffc0205c8c:	01051463          	bne	a0,a6,ffffffffc0205c94 <stride_dequeue+0xc88>
ffffffffc0205c90:	60a0106f          	j	ffffffffc020729a <stride_dequeue+0x228e>
ffffffffc0205c94:	010e3583          	ld	a1,16(t3)
ffffffffc0205c98:	8546                	mv	a0,a7
ffffffffc0205c9a:	008e3b03          	ld	s6,8(t3)
ffffffffc0205c9e:	f472                	sd	t3,40(sp)
ffffffffc0205ca0:	98cff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205ca4:	7e22                	ld	t3,40(sp)
ffffffffc0205ca6:	016e3823          	sd	s6,16(t3)
ffffffffc0205caa:	00ae3423          	sd	a0,8(t3)
ffffffffc0205cae:	010c2b03          	lw	s6,16(s8)
ffffffffc0205cb2:	e119                	bnez	a0,ffffffffc0205cb8 <stride_dequeue+0xcac>
ffffffffc0205cb4:	0270106f          	j	ffffffffc02074da <stride_dequeue+0x24ce>
ffffffffc0205cb8:	01c53023          	sd	t3,0(a0)
ffffffffc0205cbc:	88f2                	mv	a7,t3
ffffffffc0205cbe:	7782                	ld	a5,32(sp)
ffffffffc0205cc0:	0119b423          	sd	a7,8(s3)
ffffffffc0205cc4:	00f9b823          	sd	a5,16(s3)
ffffffffc0205cc8:	0138b023          	sd	s3,0(a7)
ffffffffc0205ccc:	67e2                	ld	a5,24(sp)
ffffffffc0205cce:	013db423          	sd	s3,8(s11)
ffffffffc0205cd2:	00fdb823          	sd	a5,16(s11)
ffffffffc0205cd6:	01b9b023          	sd	s11,0(s3)
ffffffffc0205cda:	89da                	mv	s3,s6
ffffffffc0205cdc:	67c2                	ld	a5,16(sp)
ffffffffc0205cde:	01bcb423          	sd	s11,8(s9)
ffffffffc0205ce2:	00fcb823          	sd	a5,16(s9)
ffffffffc0205ce6:	019db023          	sd	s9,0(s11)
ffffffffc0205cea:	8de6                	mv	s11,s9
ffffffffc0205cec:	b9bd                	j	ffffffffc020596a <stride_dequeue+0x95e>
ffffffffc0205cee:	00893783          	ld	a5,8(s2)
ffffffffc0205cf2:	01093883          	ld	a7,16(s2)
ffffffffc0205cf6:	f02a                	sd	a0,32(sp)
ffffffffc0205cf8:	ec3e                	sd	a5,24(sp)
ffffffffc0205cfa:	06088c63          	beqz	a7,ffffffffc0205d72 <stride_dequeue+0xd66>
ffffffffc0205cfe:	85c2                	mv	a1,a6
ffffffffc0205d00:	8546                	mv	a0,a7
ffffffffc0205d02:	f842                	sd	a6,48(sp)
ffffffffc0205d04:	f446                	sd	a7,40(sp)
ffffffffc0205d06:	8caff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205d0a:	7302                	ld	t1,32(sp)
ffffffffc0205d0c:	78a2                	ld	a7,40(sp)
ffffffffc0205d0e:	7842                	ld	a6,48(sp)
ffffffffc0205d10:	2e650ee3          	beq	a0,t1,ffffffffc020680c <stride_dequeue+0x1800>
ffffffffc0205d14:	00883783          	ld	a5,8(a6)
ffffffffc0205d18:	01083983          	ld	s3,16(a6)
ffffffffc0205d1c:	f41a                	sd	t1,40(sp)
ffffffffc0205d1e:	f03e                	sd	a5,32(sp)
ffffffffc0205d20:	64098ee3          	beqz	s3,ffffffffc0206b7c <stride_dequeue+0x1b70>
ffffffffc0205d24:	8546                	mv	a0,a7
ffffffffc0205d26:	85ce                	mv	a1,s3
ffffffffc0205d28:	fc42                	sd	a6,56(sp)
ffffffffc0205d2a:	f846                	sd	a7,48(sp)
ffffffffc0205d2c:	8a4ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205d30:	7322                	ld	t1,40(sp)
ffffffffc0205d32:	78c2                	ld	a7,48(sp)
ffffffffc0205d34:	7862                	ld	a6,56(sp)
ffffffffc0205d36:	00651463          	bne	a0,t1,ffffffffc0205d3e <stride_dequeue+0xd32>
ffffffffc0205d3a:	1e80106f          	j	ffffffffc0206f22 <stride_dequeue+0x1f16>
ffffffffc0205d3e:	0109b583          	ld	a1,16(s3)
ffffffffc0205d42:	0089bb03          	ld	s6,8(s3)
ffffffffc0205d46:	8546                	mv	a0,a7
ffffffffc0205d48:	f442                	sd	a6,40(sp)
ffffffffc0205d4a:	8e2ff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205d4e:	00a9b423          	sd	a0,8(s3)
ffffffffc0205d52:	0169b823          	sd	s6,16(s3)
ffffffffc0205d56:	7822                	ld	a6,40(sp)
ffffffffc0205d58:	010c2b03          	lw	s6,16(s8)
ffffffffc0205d5c:	c119                	beqz	a0,ffffffffc0205d62 <stride_dequeue+0xd56>
ffffffffc0205d5e:	01353023          	sd	s3,0(a0)
ffffffffc0205d62:	7782                	ld	a5,32(sp)
ffffffffc0205d64:	01383423          	sd	s3,8(a6)
ffffffffc0205d68:	00f83823          	sd	a5,16(a6)
ffffffffc0205d6c:	0109b023          	sd	a6,0(s3)
ffffffffc0205d70:	89da                	mv	s3,s6
ffffffffc0205d72:	67e2                	ld	a5,24(sp)
ffffffffc0205d74:	01093423          	sd	a6,8(s2)
ffffffffc0205d78:	00f93823          	sd	a5,16(s2)
ffffffffc0205d7c:	01283023          	sd	s2,0(a6)
ffffffffc0205d80:	bf0ff06f          	j	ffffffffc0205170 <stride_dequeue+0x164>
ffffffffc0205d84:	008cb783          	ld	a5,8(s9)
ffffffffc0205d88:	010cb983          	ld	s3,16(s9)
ffffffffc0205d8c:	ec2a                	sd	a0,24(sp)
ffffffffc0205d8e:	e83e                	sd	a5,16(sp)
ffffffffc0205d90:	0a098763          	beqz	s3,ffffffffc0205e3e <stride_dequeue+0xe32>
ffffffffc0205d94:	85d2                	mv	a1,s4
ffffffffc0205d96:	854e                	mv	a0,s3
ffffffffc0205d98:	838ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205d9c:	6862                	ld	a6,24(sp)
ffffffffc0205d9e:	3b050fe3          	beq	a0,a6,ffffffffc020695c <stride_dequeue+0x1950>
ffffffffc0205da2:	008a3783          	ld	a5,8(s4)
ffffffffc0205da6:	010a3303          	ld	t1,16(s4)
ffffffffc0205daa:	f042                	sd	a6,32(sp)
ffffffffc0205dac:	ec3e                	sd	a5,24(sp)
ffffffffc0205dae:	08030163          	beqz	t1,ffffffffc0205e30 <stride_dequeue+0xe24>
ffffffffc0205db2:	859a                	mv	a1,t1
ffffffffc0205db4:	854e                	mv	a0,s3
ffffffffc0205db6:	f41a                	sd	t1,40(sp)
ffffffffc0205db8:	818ff0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205dbc:	7802                	ld	a6,32(sp)
ffffffffc0205dbe:	7322                	ld	t1,40(sp)
ffffffffc0205dc0:	01051463          	bne	a0,a6,ffffffffc0205dc8 <stride_dequeue+0xdbc>
ffffffffc0205dc4:	3da0106f          	j	ffffffffc020719e <stride_dequeue+0x2192>
ffffffffc0205dc8:	00833783          	ld	a5,8(t1)
ffffffffc0205dcc:	01033e03          	ld	t3,16(t1)
ffffffffc0205dd0:	fc42                	sd	a6,56(sp)
ffffffffc0205dd2:	f03e                	sd	a5,32(sp)
ffffffffc0205dd4:	040e0663          	beqz	t3,ffffffffc0205e20 <stride_dequeue+0xe14>
ffffffffc0205dd8:	85f2                	mv	a1,t3
ffffffffc0205dda:	854e                	mv	a0,s3
ffffffffc0205ddc:	f81a                	sd	t1,48(sp)
ffffffffc0205dde:	f472                	sd	t3,40(sp)
ffffffffc0205de0:	ff1fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205de4:	7862                	ld	a6,56(sp)
ffffffffc0205de6:	7e22                	ld	t3,40(sp)
ffffffffc0205de8:	7342                	ld	t1,48(sp)
ffffffffc0205dea:	01051463          	bne	a0,a6,ffffffffc0205df2 <stride_dequeue+0xde6>
ffffffffc0205dee:	0c90106f          	j	ffffffffc02076b6 <stride_dequeue+0x26aa>
ffffffffc0205df2:	010e3583          	ld	a1,16(t3)
ffffffffc0205df6:	854e                	mv	a0,s3
ffffffffc0205df8:	008e3b03          	ld	s6,8(t3)
ffffffffc0205dfc:	f81a                	sd	t1,48(sp)
ffffffffc0205dfe:	f472                	sd	t3,40(sp)
ffffffffc0205e00:	82cff0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205e04:	7e22                	ld	t3,40(sp)
ffffffffc0205e06:	7342                	ld	t1,48(sp)
ffffffffc0205e08:	016e3823          	sd	s6,16(t3)
ffffffffc0205e0c:	00ae3423          	sd	a0,8(t3)
ffffffffc0205e10:	010c2b03          	lw	s6,16(s8)
ffffffffc0205e14:	e119                	bnez	a0,ffffffffc0205e1a <stride_dequeue+0xe0e>
ffffffffc0205e16:	32d0106f          	j	ffffffffc0207942 <stride_dequeue+0x2936>
ffffffffc0205e1a:	01c53023          	sd	t3,0(a0)
ffffffffc0205e1e:	89f2                	mv	s3,t3
ffffffffc0205e20:	7782                	ld	a5,32(sp)
ffffffffc0205e22:	01333423          	sd	s3,8(t1)
ffffffffc0205e26:	00f33823          	sd	a5,16(t1)
ffffffffc0205e2a:	0069b023          	sd	t1,0(s3)
ffffffffc0205e2e:	899a                	mv	s3,t1
ffffffffc0205e30:	67e2                	ld	a5,24(sp)
ffffffffc0205e32:	013a3423          	sd	s3,8(s4)
ffffffffc0205e36:	00fa3823          	sd	a5,16(s4)
ffffffffc0205e3a:	0149b023          	sd	s4,0(s3)
ffffffffc0205e3e:	67c2                	ld	a5,16(sp)
ffffffffc0205e40:	014cb423          	sd	s4,8(s9)
ffffffffc0205e44:	89da                	mv	s3,s6
ffffffffc0205e46:	00fcb823          	sd	a5,16(s9)
ffffffffc0205e4a:	019a3023          	sd	s9,0(s4)
ffffffffc0205e4e:	f42ff06f          	j	ffffffffc0205590 <stride_dequeue+0x584>
ffffffffc0205e52:	661c                	ld	a5,8(a2)
ffffffffc0205e54:	01063983          	ld	s3,16(a2)
ffffffffc0205e58:	e82a                	sd	a0,16(sp)
ffffffffc0205e5a:	e43e                	sd	a5,8(sp)
ffffffffc0205e5c:	0a098f63          	beqz	s3,ffffffffc0205f1a <stride_dequeue+0xf0e>
ffffffffc0205e60:	85d2                	mv	a1,s4
ffffffffc0205e62:	854e                	mv	a0,s3
ffffffffc0205e64:	ec32                	sd	a2,24(sp)
ffffffffc0205e66:	f6bfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205e6a:	6842                	ld	a6,16(sp)
ffffffffc0205e6c:	6662                	ld	a2,24(sp)
ffffffffc0205e6e:	39050de3          	beq	a0,a6,ffffffffc0206a08 <stride_dequeue+0x19fc>
ffffffffc0205e72:	008a3783          	ld	a5,8(s4)
ffffffffc0205e76:	010a3303          	ld	t1,16(s4)
ffffffffc0205e7a:	ec42                	sd	a6,24(sp)
ffffffffc0205e7c:	e83e                	sd	a5,16(sp)
ffffffffc0205e7e:	08030763          	beqz	t1,ffffffffc0205f0c <stride_dequeue+0xf00>
ffffffffc0205e82:	859a                	mv	a1,t1
ffffffffc0205e84:	854e                	mv	a0,s3
ffffffffc0205e86:	f432                	sd	a2,40(sp)
ffffffffc0205e88:	f01a                	sd	t1,32(sp)
ffffffffc0205e8a:	f47fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205e8e:	6862                	ld	a6,24(sp)
ffffffffc0205e90:	7302                	ld	t1,32(sp)
ffffffffc0205e92:	7622                	ld	a2,40(sp)
ffffffffc0205e94:	01051463          	bne	a0,a6,ffffffffc0205e9c <stride_dequeue+0xe90>
ffffffffc0205e98:	5060106f          	j	ffffffffc020739e <stride_dequeue+0x2392>
ffffffffc0205e9c:	00833783          	ld	a5,8(t1)
ffffffffc0205ea0:	01033e03          	ld	t3,16(t1)
ffffffffc0205ea4:	fc42                	sd	a6,56(sp)
ffffffffc0205ea6:	ec3e                	sd	a5,24(sp)
ffffffffc0205ea8:	040e0a63          	beqz	t3,ffffffffc0205efc <stride_dequeue+0xef0>
ffffffffc0205eac:	85f2                	mv	a1,t3
ffffffffc0205eae:	854e                	mv	a0,s3
ffffffffc0205eb0:	f81a                	sd	t1,48(sp)
ffffffffc0205eb2:	f432                	sd	a2,40(sp)
ffffffffc0205eb4:	f072                	sd	t3,32(sp)
ffffffffc0205eb6:	f1bfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205eba:	7862                	ld	a6,56(sp)
ffffffffc0205ebc:	7e02                	ld	t3,32(sp)
ffffffffc0205ebe:	7622                	ld	a2,40(sp)
ffffffffc0205ec0:	7342                	ld	t1,48(sp)
ffffffffc0205ec2:	01051463          	bne	a0,a6,ffffffffc0205eca <stride_dequeue+0xebe>
ffffffffc0205ec6:	1e10106f          	j	ffffffffc02078a6 <stride_dequeue+0x289a>
ffffffffc0205eca:	010e3583          	ld	a1,16(t3)
ffffffffc0205ece:	854e                	mv	a0,s3
ffffffffc0205ed0:	008e3b03          	ld	s6,8(t3)
ffffffffc0205ed4:	f81a                	sd	t1,48(sp)
ffffffffc0205ed6:	f432                	sd	a2,40(sp)
ffffffffc0205ed8:	f072                	sd	t3,32(sp)
ffffffffc0205eda:	f53fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205ede:	7e02                	ld	t3,32(sp)
ffffffffc0205ee0:	7622                	ld	a2,40(sp)
ffffffffc0205ee2:	7342                	ld	t1,48(sp)
ffffffffc0205ee4:	016e3823          	sd	s6,16(t3)
ffffffffc0205ee8:	00ae3423          	sd	a0,8(t3)
ffffffffc0205eec:	010c2b03          	lw	s6,16(s8)
ffffffffc0205ef0:	e119                	bnez	a0,ffffffffc0205ef6 <stride_dequeue+0xeea>
ffffffffc0205ef2:	22d0106f          	j	ffffffffc020791e <stride_dequeue+0x2912>
ffffffffc0205ef6:	01c53023          	sd	t3,0(a0)
ffffffffc0205efa:	89f2                	mv	s3,t3
ffffffffc0205efc:	67e2                	ld	a5,24(sp)
ffffffffc0205efe:	01333423          	sd	s3,8(t1)
ffffffffc0205f02:	00f33823          	sd	a5,16(t1)
ffffffffc0205f06:	0069b023          	sd	t1,0(s3)
ffffffffc0205f0a:	899a                	mv	s3,t1
ffffffffc0205f0c:	67c2                	ld	a5,16(sp)
ffffffffc0205f0e:	013a3423          	sd	s3,8(s4)
ffffffffc0205f12:	00fa3823          	sd	a5,16(s4)
ffffffffc0205f16:	0149b023          	sd	s4,0(s3)
ffffffffc0205f1a:	67a2                	ld	a5,8(sp)
ffffffffc0205f1c:	01463423          	sd	s4,8(a2)
ffffffffc0205f20:	89da                	mv	s3,s6
ffffffffc0205f22:	ea1c                	sd	a5,16(a2)
ffffffffc0205f24:	00ca3023          	sd	a2,0(s4)
ffffffffc0205f28:	8a32                	mv	s4,a2
ffffffffc0205f2a:	f80ff06f          	j	ffffffffc02056aa <stride_dequeue+0x69e>
ffffffffc0205f2e:	008a3783          	ld	a5,8(s4)
ffffffffc0205f32:	010a3983          	ld	s3,16(s4)
ffffffffc0205f36:	ec2a                	sd	a0,24(sp)
ffffffffc0205f38:	e83e                	sd	a5,16(sp)
ffffffffc0205f3a:	0a098763          	beqz	s3,ffffffffc0205fe8 <stride_dequeue+0xfdc>
ffffffffc0205f3e:	85e6                	mv	a1,s9
ffffffffc0205f40:	854e                	mv	a0,s3
ffffffffc0205f42:	e8ffe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205f46:	6862                	ld	a6,24(sp)
ffffffffc0205f48:	270505e3          	beq	a0,a6,ffffffffc02069b2 <stride_dequeue+0x19a6>
ffffffffc0205f4c:	008cb783          	ld	a5,8(s9)
ffffffffc0205f50:	010cb303          	ld	t1,16(s9)
ffffffffc0205f54:	f042                	sd	a6,32(sp)
ffffffffc0205f56:	ec3e                	sd	a5,24(sp)
ffffffffc0205f58:	08030163          	beqz	t1,ffffffffc0205fda <stride_dequeue+0xfce>
ffffffffc0205f5c:	859a                	mv	a1,t1
ffffffffc0205f5e:	854e                	mv	a0,s3
ffffffffc0205f60:	f41a                	sd	t1,40(sp)
ffffffffc0205f62:	e6ffe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205f66:	7802                	ld	a6,32(sp)
ffffffffc0205f68:	7322                	ld	t1,40(sp)
ffffffffc0205f6a:	01051463          	bne	a0,a6,ffffffffc0205f72 <stride_dequeue+0xf66>
ffffffffc0205f6e:	4080106f          	j	ffffffffc0207376 <stride_dequeue+0x236a>
ffffffffc0205f72:	00833783          	ld	a5,8(t1)
ffffffffc0205f76:	01033e03          	ld	t3,16(t1)
ffffffffc0205f7a:	fc42                	sd	a6,56(sp)
ffffffffc0205f7c:	f03e                	sd	a5,32(sp)
ffffffffc0205f7e:	040e0663          	beqz	t3,ffffffffc0205fca <stride_dequeue+0xfbe>
ffffffffc0205f82:	85f2                	mv	a1,t3
ffffffffc0205f84:	854e                	mv	a0,s3
ffffffffc0205f86:	f81a                	sd	t1,48(sp)
ffffffffc0205f88:	f472                	sd	t3,40(sp)
ffffffffc0205f8a:	e47fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0205f8e:	7862                	ld	a6,56(sp)
ffffffffc0205f90:	7e22                	ld	t3,40(sp)
ffffffffc0205f92:	7342                	ld	t1,48(sp)
ffffffffc0205f94:	01051463          	bne	a0,a6,ffffffffc0205f9c <stride_dequeue+0xf90>
ffffffffc0205f98:	6160106f          	j	ffffffffc02075ae <stride_dequeue+0x25a2>
ffffffffc0205f9c:	010e3583          	ld	a1,16(t3)
ffffffffc0205fa0:	854e                	mv	a0,s3
ffffffffc0205fa2:	008e3b03          	ld	s6,8(t3)
ffffffffc0205fa6:	f81a                	sd	t1,48(sp)
ffffffffc0205fa8:	f472                	sd	t3,40(sp)
ffffffffc0205faa:	e83fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0205fae:	7e22                	ld	t3,40(sp)
ffffffffc0205fb0:	7342                	ld	t1,48(sp)
ffffffffc0205fb2:	016e3823          	sd	s6,16(t3)
ffffffffc0205fb6:	00ae3423          	sd	a0,8(t3)
ffffffffc0205fba:	010c2b03          	lw	s6,16(s8)
ffffffffc0205fbe:	e119                	bnez	a0,ffffffffc0205fc4 <stride_dequeue+0xfb8>
ffffffffc0205fc0:	1b30106f          	j	ffffffffc0207972 <stride_dequeue+0x2966>
ffffffffc0205fc4:	01c53023          	sd	t3,0(a0)
ffffffffc0205fc8:	89f2                	mv	s3,t3
ffffffffc0205fca:	7782                	ld	a5,32(sp)
ffffffffc0205fcc:	01333423          	sd	s3,8(t1)
ffffffffc0205fd0:	00f33823          	sd	a5,16(t1)
ffffffffc0205fd4:	0069b023          	sd	t1,0(s3)
ffffffffc0205fd8:	899a                	mv	s3,t1
ffffffffc0205fda:	67e2                	ld	a5,24(sp)
ffffffffc0205fdc:	013cb423          	sd	s3,8(s9)
ffffffffc0205fe0:	00fcb823          	sd	a5,16(s9)
ffffffffc0205fe4:	0199b023          	sd	s9,0(s3)
ffffffffc0205fe8:	67c2                	ld	a5,16(sp)
ffffffffc0205fea:	019a3423          	sd	s9,8(s4)
ffffffffc0205fee:	89da                	mv	s3,s6
ffffffffc0205ff0:	00fa3823          	sd	a5,16(s4)
ffffffffc0205ff4:	014cb023          	sd	s4,0(s9)
ffffffffc0205ff8:	8cd2                	mv	s9,s4
ffffffffc0205ffa:	faeff06f          	j	ffffffffc02057a8 <stride_dequeue+0x79c>
ffffffffc0205ffe:	0088b783          	ld	a5,8(a7)
ffffffffc0206002:	0108b983          	ld	s3,16(a7)
ffffffffc0206006:	f02a                	sd	a0,32(sp)
ffffffffc0206008:	ec3e                	sd	a5,24(sp)
ffffffffc020600a:	06098e63          	beqz	s3,ffffffffc0206086 <stride_dequeue+0x107a>
ffffffffc020600e:	85e6                	mv	a1,s9
ffffffffc0206010:	854e                	mv	a0,s3
ffffffffc0206012:	f446                	sd	a7,40(sp)
ffffffffc0206014:	dbdfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206018:	7302                	ld	t1,32(sp)
ffffffffc020601a:	78a2                	ld	a7,40(sp)
ffffffffc020601c:	486503e3          	beq	a0,t1,ffffffffc0206ca2 <stride_dequeue+0x1c96>
ffffffffc0206020:	008cb783          	ld	a5,8(s9)
ffffffffc0206024:	010cbe03          	ld	t3,16(s9)
ffffffffc0206028:	f41a                	sd	t1,40(sp)
ffffffffc020602a:	f03e                	sd	a5,32(sp)
ffffffffc020602c:	040e0663          	beqz	t3,ffffffffc0206078 <stride_dequeue+0x106c>
ffffffffc0206030:	85f2                	mv	a1,t3
ffffffffc0206032:	854e                	mv	a0,s3
ffffffffc0206034:	fc46                	sd	a7,56(sp)
ffffffffc0206036:	f872                	sd	t3,48(sp)
ffffffffc0206038:	d99fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020603c:	7322                	ld	t1,40(sp)
ffffffffc020603e:	7e42                	ld	t3,48(sp)
ffffffffc0206040:	78e2                	ld	a7,56(sp)
ffffffffc0206042:	00651463          	bne	a0,t1,ffffffffc020604a <stride_dequeue+0x103e>
ffffffffc0206046:	3040106f          	j	ffffffffc020734a <stride_dequeue+0x233e>
ffffffffc020604a:	010e3583          	ld	a1,16(t3)
ffffffffc020604e:	854e                	mv	a0,s3
ffffffffc0206050:	008e3b03          	ld	s6,8(t3)
ffffffffc0206054:	f846                	sd	a7,48(sp)
ffffffffc0206056:	f472                	sd	t3,40(sp)
ffffffffc0206058:	dd5fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020605c:	7e22                	ld	t3,40(sp)
ffffffffc020605e:	78c2                	ld	a7,48(sp)
ffffffffc0206060:	016e3823          	sd	s6,16(t3)
ffffffffc0206064:	00ae3423          	sd	a0,8(t3)
ffffffffc0206068:	010c2b03          	lw	s6,16(s8)
ffffffffc020606c:	e119                	bnez	a0,ffffffffc0206072 <stride_dequeue+0x1066>
ffffffffc020606e:	4540106f          	j	ffffffffc02074c2 <stride_dequeue+0x24b6>
ffffffffc0206072:	01c53023          	sd	t3,0(a0)
ffffffffc0206076:	89f2                	mv	s3,t3
ffffffffc0206078:	7782                	ld	a5,32(sp)
ffffffffc020607a:	013cb423          	sd	s3,8(s9)
ffffffffc020607e:	00fcb823          	sd	a5,16(s9)
ffffffffc0206082:	0199b023          	sd	s9,0(s3)
ffffffffc0206086:	67e2                	ld	a5,24(sp)
ffffffffc0206088:	0198b423          	sd	s9,8(a7)
ffffffffc020608c:	89da                	mv	s3,s6
ffffffffc020608e:	00f8b823          	sd	a5,16(a7)
ffffffffc0206092:	011cb023          	sd	a7,0(s9)
ffffffffc0206096:	8cc6                	mv	s9,a7
ffffffffc0206098:	fdeff06f          	j	ffffffffc0205876 <stride_dequeue+0x86a>
ffffffffc020609c:	008cb783          	ld	a5,8(s9)
ffffffffc02060a0:	010cb983          	ld	s3,16(s9)
ffffffffc02060a4:	f02a                	sd	a0,32(sp)
ffffffffc02060a6:	ec3e                	sd	a5,24(sp)
ffffffffc02060a8:	06098e63          	beqz	s3,ffffffffc0206124 <stride_dequeue+0x1118>
ffffffffc02060ac:	85c2                	mv	a1,a6
ffffffffc02060ae:	854e                	mv	a0,s3
ffffffffc02060b0:	f442                	sd	a6,40(sp)
ffffffffc02060b2:	d1ffe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02060b6:	7302                	ld	t1,32(sp)
ffffffffc02060b8:	7822                	ld	a6,40(sp)
ffffffffc02060ba:	446506e3          	beq	a0,t1,ffffffffc0206d06 <stride_dequeue+0x1cfa>
ffffffffc02060be:	00883783          	ld	a5,8(a6)
ffffffffc02060c2:	01083e03          	ld	t3,16(a6)
ffffffffc02060c6:	f41a                	sd	t1,40(sp)
ffffffffc02060c8:	f03e                	sd	a5,32(sp)
ffffffffc02060ca:	040e0663          	beqz	t3,ffffffffc0206116 <stride_dequeue+0x110a>
ffffffffc02060ce:	85f2                	mv	a1,t3
ffffffffc02060d0:	854e                	mv	a0,s3
ffffffffc02060d2:	fc42                	sd	a6,56(sp)
ffffffffc02060d4:	f872                	sd	t3,48(sp)
ffffffffc02060d6:	cfbfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02060da:	7322                	ld	t1,40(sp)
ffffffffc02060dc:	7e42                	ld	t3,48(sp)
ffffffffc02060de:	7862                	ld	a6,56(sp)
ffffffffc02060e0:	00651463          	bne	a0,t1,ffffffffc02060e8 <stride_dequeue+0x10dc>
ffffffffc02060e4:	20e0106f          	j	ffffffffc02072f2 <stride_dequeue+0x22e6>
ffffffffc02060e8:	010e3583          	ld	a1,16(t3)
ffffffffc02060ec:	854e                	mv	a0,s3
ffffffffc02060ee:	008e3b03          	ld	s6,8(t3)
ffffffffc02060f2:	f842                	sd	a6,48(sp)
ffffffffc02060f4:	f472                	sd	t3,40(sp)
ffffffffc02060f6:	d37fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02060fa:	7e22                	ld	t3,40(sp)
ffffffffc02060fc:	7842                	ld	a6,48(sp)
ffffffffc02060fe:	016e3823          	sd	s6,16(t3)
ffffffffc0206102:	00ae3423          	sd	a0,8(t3)
ffffffffc0206106:	010c2b03          	lw	s6,16(s8)
ffffffffc020610a:	e119                	bnez	a0,ffffffffc0206110 <stride_dequeue+0x1104>
ffffffffc020610c:	3c80106f          	j	ffffffffc02074d4 <stride_dequeue+0x24c8>
ffffffffc0206110:	01c53023          	sd	t3,0(a0)
ffffffffc0206114:	89f2                	mv	s3,t3
ffffffffc0206116:	7782                	ld	a5,32(sp)
ffffffffc0206118:	01383423          	sd	s3,8(a6)
ffffffffc020611c:	00f83823          	sd	a5,16(a6)
ffffffffc0206120:	0109b023          	sd	a6,0(s3)
ffffffffc0206124:	67e2                	ld	a5,24(sp)
ffffffffc0206126:	010cb423          	sd	a6,8(s9)
ffffffffc020612a:	89da                	mv	s3,s6
ffffffffc020612c:	00fcb823          	sd	a5,16(s9)
ffffffffc0206130:	01983023          	sd	s9,0(a6)
ffffffffc0206134:	829ff06f          	j	ffffffffc020595c <stride_dequeue+0x950>
ffffffffc0206138:	008db783          	ld	a5,8(s11)
ffffffffc020613c:	010db983          	ld	s3,16(s11)
ffffffffc0206140:	f02a                	sd	a0,32(sp)
ffffffffc0206142:	ec3e                	sd	a5,24(sp)
ffffffffc0206144:	06098e63          	beqz	s3,ffffffffc02061c0 <stride_dequeue+0x11b4>
ffffffffc0206148:	85c2                	mv	a1,a6
ffffffffc020614a:	854e                	mv	a0,s3
ffffffffc020614c:	f442                	sd	a6,40(sp)
ffffffffc020614e:	c83fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206152:	7302                	ld	t1,32(sp)
ffffffffc0206154:	7822                	ld	a6,40(sp)
ffffffffc0206156:	466506e3          	beq	a0,t1,ffffffffc0206dc2 <stride_dequeue+0x1db6>
ffffffffc020615a:	00883783          	ld	a5,8(a6)
ffffffffc020615e:	01083e03          	ld	t3,16(a6)
ffffffffc0206162:	f41a                	sd	t1,40(sp)
ffffffffc0206164:	f03e                	sd	a5,32(sp)
ffffffffc0206166:	040e0663          	beqz	t3,ffffffffc02061b2 <stride_dequeue+0x11a6>
ffffffffc020616a:	85f2                	mv	a1,t3
ffffffffc020616c:	854e                	mv	a0,s3
ffffffffc020616e:	fc42                	sd	a6,56(sp)
ffffffffc0206170:	f872                	sd	t3,48(sp)
ffffffffc0206172:	c5ffe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206176:	7322                	ld	t1,40(sp)
ffffffffc0206178:	7e42                	ld	t3,48(sp)
ffffffffc020617a:	7862                	ld	a6,56(sp)
ffffffffc020617c:	00651463          	bne	a0,t1,ffffffffc0206184 <stride_dequeue+0x1178>
ffffffffc0206180:	7490006f          	j	ffffffffc02070c8 <stride_dequeue+0x20bc>
ffffffffc0206184:	010e3583          	ld	a1,16(t3)
ffffffffc0206188:	854e                	mv	a0,s3
ffffffffc020618a:	008e3b03          	ld	s6,8(t3)
ffffffffc020618e:	f842                	sd	a6,48(sp)
ffffffffc0206190:	f472                	sd	t3,40(sp)
ffffffffc0206192:	c9bfe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206196:	7e22                	ld	t3,40(sp)
ffffffffc0206198:	7842                	ld	a6,48(sp)
ffffffffc020619a:	016e3823          	sd	s6,16(t3)
ffffffffc020619e:	00ae3423          	sd	a0,8(t3)
ffffffffc02061a2:	010c2b03          	lw	s6,16(s8)
ffffffffc02061a6:	e119                	bnez	a0,ffffffffc02061ac <stride_dequeue+0x11a0>
ffffffffc02061a8:	3260106f          	j	ffffffffc02074ce <stride_dequeue+0x24c2>
ffffffffc02061ac:	01c53023          	sd	t3,0(a0)
ffffffffc02061b0:	89f2                	mv	s3,t3
ffffffffc02061b2:	7782                	ld	a5,32(sp)
ffffffffc02061b4:	01383423          	sd	s3,8(a6)
ffffffffc02061b8:	00f83823          	sd	a5,16(a6)
ffffffffc02061bc:	0109b023          	sd	a6,0(s3)
ffffffffc02061c0:	67e2                	ld	a5,24(sp)
ffffffffc02061c2:	010db423          	sd	a6,8(s11)
ffffffffc02061c6:	89da                	mv	s3,s6
ffffffffc02061c8:	00fdb823          	sd	a5,16(s11)
ffffffffc02061cc:	01b83023          	sd	s11,0(a6)
ffffffffc02061d0:	92aff06f          	j	ffffffffc02052fa <stride_dequeue+0x2ee>
ffffffffc02061d4:	008db783          	ld	a5,8(s11)
ffffffffc02061d8:	010db983          	ld	s3,16(s11)
ffffffffc02061dc:	ec2a                	sd	a0,24(sp)
ffffffffc02061de:	e83e                	sd	a5,16(sp)
ffffffffc02061e0:	08098263          	beqz	s3,ffffffffc0206264 <stride_dequeue+0x1258>
ffffffffc02061e4:	85c2                	mv	a1,a6
ffffffffc02061e6:	854e                	mv	a0,s3
ffffffffc02061e8:	f432                	sd	a2,40(sp)
ffffffffc02061ea:	f042                	sd	a6,32(sp)
ffffffffc02061ec:	be5fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02061f0:	6362                	ld	t1,24(sp)
ffffffffc02061f2:	7802                	ld	a6,32(sp)
ffffffffc02061f4:	7622                	ld	a2,40(sp)
ffffffffc02061f6:	426505e3          	beq	a0,t1,ffffffffc0206e20 <stride_dequeue+0x1e14>
ffffffffc02061fa:	00883783          	ld	a5,8(a6)
ffffffffc02061fe:	01083e03          	ld	t3,16(a6)
ffffffffc0206202:	f01a                	sd	t1,32(sp)
ffffffffc0206204:	ec3e                	sd	a5,24(sp)
ffffffffc0206206:	040e0863          	beqz	t3,ffffffffc0206256 <stride_dequeue+0x124a>
ffffffffc020620a:	85f2                	mv	a1,t3
ffffffffc020620c:	854e                	mv	a0,s3
ffffffffc020620e:	fc42                	sd	a6,56(sp)
ffffffffc0206210:	f832                	sd	a2,48(sp)
ffffffffc0206212:	f472                	sd	t3,40(sp)
ffffffffc0206214:	bbdfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206218:	7302                	ld	t1,32(sp)
ffffffffc020621a:	7e22                	ld	t3,40(sp)
ffffffffc020621c:	7642                	ld	a2,48(sp)
ffffffffc020621e:	7862                	ld	a6,56(sp)
ffffffffc0206220:	60650fe3          	beq	a0,t1,ffffffffc020703e <stride_dequeue+0x2032>
ffffffffc0206224:	010e3583          	ld	a1,16(t3)
ffffffffc0206228:	854e                	mv	a0,s3
ffffffffc020622a:	008e3b03          	ld	s6,8(t3)
ffffffffc020622e:	f842                	sd	a6,48(sp)
ffffffffc0206230:	f432                	sd	a2,40(sp)
ffffffffc0206232:	f072                	sd	t3,32(sp)
ffffffffc0206234:	bf9fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206238:	7e02                	ld	t3,32(sp)
ffffffffc020623a:	7622                	ld	a2,40(sp)
ffffffffc020623c:	7842                	ld	a6,48(sp)
ffffffffc020623e:	016e3823          	sd	s6,16(t3)
ffffffffc0206242:	00ae3423          	sd	a0,8(t3)
ffffffffc0206246:	010c2b03          	lw	s6,16(s8)
ffffffffc020624a:	e119                	bnez	a0,ffffffffc0206250 <stride_dequeue+0x1244>
ffffffffc020624c:	2d60106f          	j	ffffffffc0207522 <stride_dequeue+0x2516>
ffffffffc0206250:	01c53023          	sd	t3,0(a0)
ffffffffc0206254:	89f2                	mv	s3,t3
ffffffffc0206256:	67e2                	ld	a5,24(sp)
ffffffffc0206258:	01383423          	sd	s3,8(a6)
ffffffffc020625c:	00f83823          	sd	a5,16(a6)
ffffffffc0206260:	0109b023          	sd	a6,0(s3)
ffffffffc0206264:	67c2                	ld	a5,16(sp)
ffffffffc0206266:	010db423          	sd	a6,8(s11)
ffffffffc020626a:	89da                	mv	s3,s6
ffffffffc020626c:	00fdb823          	sd	a5,16(s11)
ffffffffc0206270:	01b83023          	sd	s11,0(a6)
ffffffffc0206274:	9e0ff06f          	j	ffffffffc0205454 <stride_dequeue+0x448>
ffffffffc0206278:	00893703          	ld	a4,8(s2)
ffffffffc020627c:	01093983          	ld	s3,16(s2)
ffffffffc0206280:	f42a                	sd	a0,40(sp)
ffffffffc0206282:	f03a                	sd	a4,32(sp)
ffffffffc0206284:	02098e63          	beqz	s3,ffffffffc02062c0 <stride_dequeue+0x12b4>
ffffffffc0206288:	85be                	mv	a1,a5
ffffffffc020628a:	854e                	mv	a0,s3
ffffffffc020628c:	fc42                	sd	a6,56(sp)
ffffffffc020628e:	f83e                	sd	a5,48(sp)
ffffffffc0206290:	b41fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206294:	7e22                	ld	t3,40(sp)
ffffffffc0206296:	77c2                	ld	a5,48(sp)
ffffffffc0206298:	7862                	ld	a6,56(sp)
ffffffffc020629a:	43c509e3          	beq	a0,t3,ffffffffc0206ecc <stride_dequeue+0x1ec0>
ffffffffc020629e:	6b8c                	ld	a1,16(a5)
ffffffffc02062a0:	854e                	mv	a0,s3
ffffffffc02062a2:	0087bb03          	ld	s6,8(a5)
ffffffffc02062a6:	f842                	sd	a6,48(sp)
ffffffffc02062a8:	f43e                	sd	a5,40(sp)
ffffffffc02062aa:	b83fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02062ae:	77a2                	ld	a5,40(sp)
ffffffffc02062b0:	7842                	ld	a6,48(sp)
ffffffffc02062b2:	0167b823          	sd	s6,16(a5)
ffffffffc02062b6:	e788                	sd	a0,8(a5)
ffffffffc02062b8:	010c2b03          	lw	s6,16(s8)
ffffffffc02062bc:	c111                	beqz	a0,ffffffffc02062c0 <stride_dequeue+0x12b4>
ffffffffc02062be:	e11c                	sd	a5,0(a0)
ffffffffc02062c0:	7702                	ld	a4,32(sp)
ffffffffc02062c2:	00f93423          	sd	a5,8(s2)
ffffffffc02062c6:	89da                	mv	s3,s6
ffffffffc02062c8:	00e93823          	sd	a4,16(s2)
ffffffffc02062cc:	0127b023          	sd	s2,0(a5)
ffffffffc02062d0:	e91fe06f          	j	ffffffffc0205160 <stride_dequeue+0x154>
ffffffffc02062d4:	008a3783          	ld	a5,8(s4)
ffffffffc02062d8:	010a3983          	ld	s3,16(s4)
ffffffffc02062dc:	ec2a                	sd	a0,24(sp)
ffffffffc02062de:	e83e                	sd	a5,16(sp)
ffffffffc02062e0:	5a098ce3          	beqz	s3,ffffffffc0207098 <stride_dequeue+0x208c>
ffffffffc02062e4:	85a6                	mv	a1,s1
ffffffffc02062e6:	854e                	mv	a0,s3
ffffffffc02062e8:	ae9fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02062ec:	67e2                	ld	a5,24(sp)
ffffffffc02062ee:	50f500e3          	beq	a0,a5,ffffffffc0206fee <stride_dequeue+0x1fe2>
ffffffffc02062f2:	f43e                	sd	a5,40(sp)
ffffffffc02062f4:	649c                	ld	a5,8(s1)
ffffffffc02062f6:	0104b883          	ld	a7,16(s1)
ffffffffc02062fa:	ec3e                	sd	a5,24(sp)
ffffffffc02062fc:	04088263          	beqz	a7,ffffffffc0206340 <stride_dequeue+0x1334>
ffffffffc0206300:	85c6                	mv	a1,a7
ffffffffc0206302:	854e                	mv	a0,s3
ffffffffc0206304:	f046                	sd	a7,32(sp)
ffffffffc0206306:	acbfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020630a:	77a2                	ld	a5,40(sp)
ffffffffc020630c:	7882                	ld	a7,32(sp)
ffffffffc020630e:	00f51463          	bne	a0,a5,ffffffffc0206316 <stride_dequeue+0x130a>
ffffffffc0206312:	2160106f          	j	ffffffffc0207528 <stride_dequeue+0x251c>
ffffffffc0206316:	0108b583          	ld	a1,16(a7)
ffffffffc020631a:	854e                	mv	a0,s3
ffffffffc020631c:	0088bb03          	ld	s6,8(a7)
ffffffffc0206320:	f046                	sd	a7,32(sp)
ffffffffc0206322:	b0bfe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206326:	7882                	ld	a7,32(sp)
ffffffffc0206328:	0168b823          	sd	s6,16(a7)
ffffffffc020632c:	00a8b423          	sd	a0,8(a7)
ffffffffc0206330:	010c2b03          	lw	s6,16(s8)
ffffffffc0206334:	e119                	bnez	a0,ffffffffc020633a <stride_dequeue+0x132e>
ffffffffc0206336:	56a0106f          	j	ffffffffc02078a0 <stride_dequeue+0x2894>
ffffffffc020633a:	01153023          	sd	a7,0(a0)
ffffffffc020633e:	89c6                	mv	s3,a7
ffffffffc0206340:	67e2                	ld	a5,24(sp)
ffffffffc0206342:	0134b423          	sd	s3,8(s1)
ffffffffc0206346:	e89c                	sd	a5,16(s1)
ffffffffc0206348:	0099b023          	sd	s1,0(s3)
ffffffffc020634c:	89a6                	mv	s3,s1
ffffffffc020634e:	67c2                	ld	a5,16(sp)
ffffffffc0206350:	013a3423          	sd	s3,8(s4)
ffffffffc0206354:	84d2                	mv	s1,s4
ffffffffc0206356:	00fa3823          	sd	a5,16(s4)
ffffffffc020635a:	0149b023          	sd	s4,0(s3)
ffffffffc020635e:	89da                	mv	s3,s6
ffffffffc0206360:	f00ff06f          	j	ffffffffc0205a60 <stride_dequeue+0xa54>
ffffffffc0206364:	0088b783          	ld	a5,8(a7)
ffffffffc0206368:	0108b983          	ld	s3,16(a7)
ffffffffc020636c:	f02a                	sd	a0,32(sp)
ffffffffc020636e:	ec3e                	sd	a5,24(sp)
ffffffffc0206370:	00099463          	bnez	s3,ffffffffc0206378 <stride_dequeue+0x136c>
ffffffffc0206374:	0d40106f          	j	ffffffffc0207448 <stride_dequeue+0x243c>
ffffffffc0206378:	85d2                	mv	a1,s4
ffffffffc020637a:	854e                	mv	a0,s3
ffffffffc020637c:	f446                	sd	a7,40(sp)
ffffffffc020637e:	a53fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206382:	7302                	ld	t1,32(sp)
ffffffffc0206384:	78a2                	ld	a7,40(sp)
ffffffffc0206386:	00651463          	bne	a0,t1,ffffffffc020638e <stride_dequeue+0x1382>
ffffffffc020638a:	06c0106f          	j	ffffffffc02073f6 <stride_dequeue+0x23ea>
ffffffffc020638e:	008a3783          	ld	a5,8(s4)
ffffffffc0206392:	010a3e03          	ld	t3,16(s4)
ffffffffc0206396:	fc1a                	sd	t1,56(sp)
ffffffffc0206398:	f03e                	sd	a5,32(sp)
ffffffffc020639a:	040e0663          	beqz	t3,ffffffffc02063e6 <stride_dequeue+0x13da>
ffffffffc020639e:	85f2                	mv	a1,t3
ffffffffc02063a0:	854e                	mv	a0,s3
ffffffffc02063a2:	f846                	sd	a7,48(sp)
ffffffffc02063a4:	f472                	sd	t3,40(sp)
ffffffffc02063a6:	a2bfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02063aa:	7362                	ld	t1,56(sp)
ffffffffc02063ac:	7e22                	ld	t3,40(sp)
ffffffffc02063ae:	78c2                	ld	a7,48(sp)
ffffffffc02063b0:	00651463          	bne	a0,t1,ffffffffc02063b8 <stride_dequeue+0x13ac>
ffffffffc02063b4:	32e0106f          	j	ffffffffc02076e2 <stride_dequeue+0x26d6>
ffffffffc02063b8:	010e3583          	ld	a1,16(t3)
ffffffffc02063bc:	854e                	mv	a0,s3
ffffffffc02063be:	008e3b03          	ld	s6,8(t3)
ffffffffc02063c2:	f846                	sd	a7,48(sp)
ffffffffc02063c4:	f472                	sd	t3,40(sp)
ffffffffc02063c6:	a67fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02063ca:	7e22                	ld	t3,40(sp)
ffffffffc02063cc:	78c2                	ld	a7,48(sp)
ffffffffc02063ce:	016e3823          	sd	s6,16(t3)
ffffffffc02063d2:	00ae3423          	sd	a0,8(t3)
ffffffffc02063d6:	010c2b03          	lw	s6,16(s8)
ffffffffc02063da:	e119                	bnez	a0,ffffffffc02063e0 <stride_dequeue+0x13d4>
ffffffffc02063dc:	58a0106f          	j	ffffffffc0207966 <stride_dequeue+0x295a>
ffffffffc02063e0:	01c53023          	sd	t3,0(a0)
ffffffffc02063e4:	89f2                	mv	s3,t3
ffffffffc02063e6:	7782                	ld	a5,32(sp)
ffffffffc02063e8:	013a3423          	sd	s3,8(s4)
ffffffffc02063ec:	00fa3823          	sd	a5,16(s4)
ffffffffc02063f0:	0149b023          	sd	s4,0(s3)
ffffffffc02063f4:	89d2                	mv	s3,s4
ffffffffc02063f6:	67e2                	ld	a5,24(sp)
ffffffffc02063f8:	0138b423          	sd	s3,8(a7)
ffffffffc02063fc:	8a46                	mv	s4,a7
ffffffffc02063fe:	00f8b823          	sd	a5,16(a7)
ffffffffc0206402:	0119b023          	sd	a7,0(s3)
ffffffffc0206406:	89da                	mv	s3,s6
ffffffffc0206408:	f28ff06f          	j	ffffffffc0205b30 <stride_dequeue+0xb24>
ffffffffc020640c:	0088b783          	ld	a5,8(a7)
ffffffffc0206410:	0108b983          	ld	s3,16(a7)
ffffffffc0206414:	f02a                	sd	a0,32(sp)
ffffffffc0206416:	ec3e                	sd	a5,24(sp)
ffffffffc0206418:	00099463          	bnez	s3,ffffffffc0206420 <stride_dequeue+0x1414>
ffffffffc020641c:	0320106f          	j	ffffffffc020744e <stride_dequeue+0x2442>
ffffffffc0206420:	85ee                	mv	a1,s11
ffffffffc0206422:	854e                	mv	a0,s3
ffffffffc0206424:	f446                	sd	a7,40(sp)
ffffffffc0206426:	9abfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020642a:	7302                	ld	t1,32(sp)
ffffffffc020642c:	78a2                	ld	a7,40(sp)
ffffffffc020642e:	466508e3          	beq	a0,t1,ffffffffc020709e <stride_dequeue+0x2092>
ffffffffc0206432:	008db783          	ld	a5,8(s11)
ffffffffc0206436:	010dbe03          	ld	t3,16(s11)
ffffffffc020643a:	fc1a                	sd	t1,56(sp)
ffffffffc020643c:	f03e                	sd	a5,32(sp)
ffffffffc020643e:	040e0663          	beqz	t3,ffffffffc020648a <stride_dequeue+0x147e>
ffffffffc0206442:	85f2                	mv	a1,t3
ffffffffc0206444:	854e                	mv	a0,s3
ffffffffc0206446:	f846                	sd	a7,48(sp)
ffffffffc0206448:	f472                	sd	t3,40(sp)
ffffffffc020644a:	987fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020644e:	7362                	ld	t1,56(sp)
ffffffffc0206450:	7e22                	ld	t3,40(sp)
ffffffffc0206452:	78c2                	ld	a7,48(sp)
ffffffffc0206454:	00651463          	bne	a0,t1,ffffffffc020645c <stride_dequeue+0x1450>
ffffffffc0206458:	3120106f          	j	ffffffffc020776a <stride_dequeue+0x275e>
ffffffffc020645c:	010e3583          	ld	a1,16(t3)
ffffffffc0206460:	854e                	mv	a0,s3
ffffffffc0206462:	008e3b03          	ld	s6,8(t3)
ffffffffc0206466:	f846                	sd	a7,48(sp)
ffffffffc0206468:	f472                	sd	t3,40(sp)
ffffffffc020646a:	9c3fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020646e:	7e22                	ld	t3,40(sp)
ffffffffc0206470:	78c2                	ld	a7,48(sp)
ffffffffc0206472:	016e3823          	sd	s6,16(t3)
ffffffffc0206476:	00ae3423          	sd	a0,8(t3)
ffffffffc020647a:	010c2b03          	lw	s6,16(s8)
ffffffffc020647e:	e119                	bnez	a0,ffffffffc0206484 <stride_dequeue+0x1478>
ffffffffc0206480:	51c0106f          	j	ffffffffc020799c <stride_dequeue+0x2990>
ffffffffc0206484:	01c53023          	sd	t3,0(a0)
ffffffffc0206488:	89f2                	mv	s3,t3
ffffffffc020648a:	7782                	ld	a5,32(sp)
ffffffffc020648c:	013db423          	sd	s3,8(s11)
ffffffffc0206490:	00fdb823          	sd	a5,16(s11)
ffffffffc0206494:	01b9b023          	sd	s11,0(s3)
ffffffffc0206498:	89ee                	mv	s3,s11
ffffffffc020649a:	67e2                	ld	a5,24(sp)
ffffffffc020649c:	0138b423          	sd	s3,8(a7)
ffffffffc02064a0:	8dc6                	mv	s11,a7
ffffffffc02064a2:	00f8b823          	sd	a5,16(a7)
ffffffffc02064a6:	0119b023          	sd	a7,0(s3)
ffffffffc02064aa:	89da                	mv	s3,s6
ffffffffc02064ac:	831ff06f          	j	ffffffffc0205cdc <stride_dequeue+0xcd0>
ffffffffc02064b0:	0088b783          	ld	a5,8(a7)
ffffffffc02064b4:	0108b983          	ld	s3,16(a7)
ffffffffc02064b8:	ec2a                	sd	a0,24(sp)
ffffffffc02064ba:	e83e                	sd	a5,16(sp)
ffffffffc02064bc:	00099463          	bnez	s3,ffffffffc02064c4 <stride_dequeue+0x14b8>
ffffffffc02064c0:	7a10006f          	j	ffffffffc0207460 <stride_dequeue+0x2454>
ffffffffc02064c4:	85b2                	mv	a1,a2
ffffffffc02064c6:	854e                	mv	a0,s3
ffffffffc02064c8:	f446                	sd	a7,40(sp)
ffffffffc02064ca:	907fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02064ce:	6362                	ld	t1,24(sp)
ffffffffc02064d0:	7602                	ld	a2,32(sp)
ffffffffc02064d2:	78a2                	ld	a7,40(sp)
ffffffffc02064d4:	426500e3          	beq	a0,t1,ffffffffc02070f4 <stride_dequeue+0x20e8>
ffffffffc02064d8:	661c                	ld	a5,8(a2)
ffffffffc02064da:	01063e03          	ld	t3,16(a2)
ffffffffc02064de:	fc1a                	sd	t1,56(sp)
ffffffffc02064e0:	ec3e                	sd	a5,24(sp)
ffffffffc02064e2:	040e0a63          	beqz	t3,ffffffffc0206536 <stride_dequeue+0x152a>
ffffffffc02064e6:	85f2                	mv	a1,t3
ffffffffc02064e8:	854e                	mv	a0,s3
ffffffffc02064ea:	f846                	sd	a7,48(sp)
ffffffffc02064ec:	f432                	sd	a2,40(sp)
ffffffffc02064ee:	f072                	sd	t3,32(sp)
ffffffffc02064f0:	8e1fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02064f4:	7362                	ld	t1,56(sp)
ffffffffc02064f6:	7e02                	ld	t3,32(sp)
ffffffffc02064f8:	7622                	ld	a2,40(sp)
ffffffffc02064fa:	78c2                	ld	a7,48(sp)
ffffffffc02064fc:	00651463          	bne	a0,t1,ffffffffc0206504 <stride_dequeue+0x14f8>
ffffffffc0206500:	20e0106f          	j	ffffffffc020770e <stride_dequeue+0x2702>
ffffffffc0206504:	010e3583          	ld	a1,16(t3)
ffffffffc0206508:	854e                	mv	a0,s3
ffffffffc020650a:	008e3b03          	ld	s6,8(t3)
ffffffffc020650e:	f846                	sd	a7,48(sp)
ffffffffc0206510:	f432                	sd	a2,40(sp)
ffffffffc0206512:	f072                	sd	t3,32(sp)
ffffffffc0206514:	919fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206518:	7e02                	ld	t3,32(sp)
ffffffffc020651a:	7622                	ld	a2,40(sp)
ffffffffc020651c:	78c2                	ld	a7,48(sp)
ffffffffc020651e:	016e3823          	sd	s6,16(t3)
ffffffffc0206522:	00ae3423          	sd	a0,8(t3)
ffffffffc0206526:	010c2b03          	lw	s6,16(s8)
ffffffffc020652a:	e119                	bnez	a0,ffffffffc0206530 <stride_dequeue+0x1524>
ffffffffc020652c:	4400106f          	j	ffffffffc020796c <stride_dequeue+0x2960>
ffffffffc0206530:	01c53023          	sd	t3,0(a0)
ffffffffc0206534:	89f2                	mv	s3,t3
ffffffffc0206536:	67e2                	ld	a5,24(sp)
ffffffffc0206538:	01363423          	sd	s3,8(a2)
ffffffffc020653c:	ea1c                	sd	a5,16(a2)
ffffffffc020653e:	00c9b023          	sd	a2,0(s3)
ffffffffc0206542:	89b2                	mv	s3,a2
ffffffffc0206544:	67c2                	ld	a5,16(sp)
ffffffffc0206546:	0138b423          	sd	s3,8(a7)
ffffffffc020654a:	8646                	mv	a2,a7
ffffffffc020654c:	00f8b823          	sd	a5,16(a7)
ffffffffc0206550:	0119b023          	sd	a7,0(s3)
ffffffffc0206554:	89da                	mv	s3,s6
ffffffffc0206556:	eb6ff06f          	j	ffffffffc0205c0c <stride_dequeue+0xc00>
ffffffffc020655a:	008cb783          	ld	a5,8(s9)
ffffffffc020655e:	010cb983          	ld	s3,16(s9)
ffffffffc0206562:	f02a                	sd	a0,32(sp)
ffffffffc0206564:	ec3e                	sd	a5,24(sp)
ffffffffc0206566:	00099463          	bnez	s3,ffffffffc020656e <stride_dequeue+0x1562>
ffffffffc020656a:	6eb0006f          	j	ffffffffc0207454 <stride_dequeue+0x2448>
ffffffffc020656e:	85c2                	mv	a1,a6
ffffffffc0206570:	854e                	mv	a0,s3
ffffffffc0206572:	f442                	sd	a6,40(sp)
ffffffffc0206574:	85dfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206578:	7302                	ld	t1,32(sp)
ffffffffc020657a:	7822                	ld	a6,40(sp)
ffffffffc020657c:	3e650ee3          	beq	a0,t1,ffffffffc0207178 <stride_dequeue+0x216c>
ffffffffc0206580:	00883783          	ld	a5,8(a6)
ffffffffc0206584:	01083e03          	ld	t3,16(a6)
ffffffffc0206588:	fc1a                	sd	t1,56(sp)
ffffffffc020658a:	f03e                	sd	a5,32(sp)
ffffffffc020658c:	040e0663          	beqz	t3,ffffffffc02065d8 <stride_dequeue+0x15cc>
ffffffffc0206590:	85f2                	mv	a1,t3
ffffffffc0206592:	854e                	mv	a0,s3
ffffffffc0206594:	f842                	sd	a6,48(sp)
ffffffffc0206596:	f472                	sd	t3,40(sp)
ffffffffc0206598:	839fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020659c:	7362                	ld	t1,56(sp)
ffffffffc020659e:	7e22                	ld	t3,40(sp)
ffffffffc02065a0:	7842                	ld	a6,48(sp)
ffffffffc02065a2:	00651463          	bne	a0,t1,ffffffffc02065aa <stride_dequeue+0x159e>
ffffffffc02065a6:	2a20106f          	j	ffffffffc0207848 <stride_dequeue+0x283c>
ffffffffc02065aa:	010e3583          	ld	a1,16(t3)
ffffffffc02065ae:	854e                	mv	a0,s3
ffffffffc02065b0:	008e3b03          	ld	s6,8(t3)
ffffffffc02065b4:	f842                	sd	a6,48(sp)
ffffffffc02065b6:	f472                	sd	t3,40(sp)
ffffffffc02065b8:	875fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02065bc:	7e22                	ld	t3,40(sp)
ffffffffc02065be:	7842                	ld	a6,48(sp)
ffffffffc02065c0:	016e3823          	sd	s6,16(t3)
ffffffffc02065c4:	00ae3423          	sd	a0,8(t3)
ffffffffc02065c8:	010c2b03          	lw	s6,16(s8)
ffffffffc02065cc:	e119                	bnez	a0,ffffffffc02065d2 <stride_dequeue+0x15c6>
ffffffffc02065ce:	35c0106f          	j	ffffffffc020792a <stride_dequeue+0x291e>
ffffffffc02065d2:	01c53023          	sd	t3,0(a0)
ffffffffc02065d6:	89f2                	mv	s3,t3
ffffffffc02065d8:	7782                	ld	a5,32(sp)
ffffffffc02065da:	01383423          	sd	s3,8(a6)
ffffffffc02065de:	00f83823          	sd	a5,16(a6)
ffffffffc02065e2:	0109b023          	sd	a6,0(s3)
ffffffffc02065e6:	89c2                	mv	s3,a6
ffffffffc02065e8:	67e2                	ld	a5,24(sp)
ffffffffc02065ea:	013cb423          	sd	s3,8(s9)
ffffffffc02065ee:	00fcb823          	sd	a5,16(s9)
ffffffffc02065f2:	0199b023          	sd	s9,0(s3)
ffffffffc02065f6:	89da                	mv	s3,s6
ffffffffc02065f8:	f89fe06f          	j	ffffffffc0205580 <stride_dequeue+0x574>
ffffffffc02065fc:	661c                	ld	a5,8(a2)
ffffffffc02065fe:	01063983          	ld	s3,16(a2)
ffffffffc0206602:	ec2a                	sd	a0,24(sp)
ffffffffc0206604:	e83e                	sd	a5,16(sp)
ffffffffc0206606:	64098ae3          	beqz	s3,ffffffffc020745a <stride_dequeue+0x244e>
ffffffffc020660a:	85c2                	mv	a1,a6
ffffffffc020660c:	854e                	mv	a0,s3
ffffffffc020660e:	f432                	sd	a2,40(sp)
ffffffffc0206610:	f042                	sd	a6,32(sp)
ffffffffc0206612:	fbefe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206616:	6362                	ld	t1,24(sp)
ffffffffc0206618:	7802                	ld	a6,32(sp)
ffffffffc020661a:	7622                	ld	a2,40(sp)
ffffffffc020661c:	326509e3          	beq	a0,t1,ffffffffc020714e <stride_dequeue+0x2142>
ffffffffc0206620:	00883783          	ld	a5,8(a6)
ffffffffc0206624:	01083e03          	ld	t3,16(a6)
ffffffffc0206628:	fc1a                	sd	t1,56(sp)
ffffffffc020662a:	ec3e                	sd	a5,24(sp)
ffffffffc020662c:	040e0a63          	beqz	t3,ffffffffc0206680 <stride_dequeue+0x1674>
ffffffffc0206630:	85f2                	mv	a1,t3
ffffffffc0206632:	854e                	mv	a0,s3
ffffffffc0206634:	f842                	sd	a6,48(sp)
ffffffffc0206636:	f432                	sd	a2,40(sp)
ffffffffc0206638:	f072                	sd	t3,32(sp)
ffffffffc020663a:	f96fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020663e:	7362                	ld	t1,56(sp)
ffffffffc0206640:	7e02                	ld	t3,32(sp)
ffffffffc0206642:	7622                	ld	a2,40(sp)
ffffffffc0206644:	7842                	ld	a6,48(sp)
ffffffffc0206646:	00651463          	bne	a0,t1,ffffffffc020664e <stride_dequeue+0x1642>
ffffffffc020664a:	1760106f          	j	ffffffffc02077c0 <stride_dequeue+0x27b4>
ffffffffc020664e:	010e3583          	ld	a1,16(t3)
ffffffffc0206652:	854e                	mv	a0,s3
ffffffffc0206654:	008e3b03          	ld	s6,8(t3)
ffffffffc0206658:	f842                	sd	a6,48(sp)
ffffffffc020665a:	f432                	sd	a2,40(sp)
ffffffffc020665c:	f072                	sd	t3,32(sp)
ffffffffc020665e:	fcefe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206662:	7e02                	ld	t3,32(sp)
ffffffffc0206664:	7622                	ld	a2,40(sp)
ffffffffc0206666:	7842                	ld	a6,48(sp)
ffffffffc0206668:	016e3823          	sd	s6,16(t3)
ffffffffc020666c:	00ae3423          	sd	a0,8(t3)
ffffffffc0206670:	010c2b03          	lw	s6,16(s8)
ffffffffc0206674:	e119                	bnez	a0,ffffffffc020667a <stride_dequeue+0x166e>
ffffffffc0206676:	32c0106f          	j	ffffffffc02079a2 <stride_dequeue+0x2996>
ffffffffc020667a:	01c53023          	sd	t3,0(a0)
ffffffffc020667e:	89f2                	mv	s3,t3
ffffffffc0206680:	67e2                	ld	a5,24(sp)
ffffffffc0206682:	01383423          	sd	s3,8(a6)
ffffffffc0206686:	00f83823          	sd	a5,16(a6)
ffffffffc020668a:	0109b023          	sd	a6,0(s3)
ffffffffc020668e:	89c2                	mv	s3,a6
ffffffffc0206690:	67c2                	ld	a5,16(sp)
ffffffffc0206692:	01363423          	sd	s3,8(a2)
ffffffffc0206696:	ea1c                	sd	a5,16(a2)
ffffffffc0206698:	00c9b023          	sd	a2,0(s3)
ffffffffc020669c:	89da                	mv	s3,s6
ffffffffc020669e:	ffffe06f          	j	ffffffffc020569c <stride_dequeue+0x690>
ffffffffc02066a2:	008a3783          	ld	a5,8(s4)
ffffffffc02066a6:	010a3983          	ld	s3,16(s4)
ffffffffc02066aa:	f02a                	sd	a0,32(sp)
ffffffffc02066ac:	ec3e                	sd	a5,24(sp)
ffffffffc02066ae:	5a098ce3          	beqz	s3,ffffffffc0207466 <stride_dequeue+0x245a>
ffffffffc02066b2:	85c2                	mv	a1,a6
ffffffffc02066b4:	854e                	mv	a0,s3
ffffffffc02066b6:	f442                	sd	a6,40(sp)
ffffffffc02066b8:	f18fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02066bc:	7302                	ld	t1,32(sp)
ffffffffc02066be:	7822                	ld	a6,40(sp)
ffffffffc02066c0:	566501e3          	beq	a0,t1,ffffffffc0207422 <stride_dequeue+0x2416>
ffffffffc02066c4:	00883783          	ld	a5,8(a6)
ffffffffc02066c8:	01083e03          	ld	t3,16(a6)
ffffffffc02066cc:	fc1a                	sd	t1,56(sp)
ffffffffc02066ce:	f03e                	sd	a5,32(sp)
ffffffffc02066d0:	040e0663          	beqz	t3,ffffffffc020671c <stride_dequeue+0x1710>
ffffffffc02066d4:	85f2                	mv	a1,t3
ffffffffc02066d6:	854e                	mv	a0,s3
ffffffffc02066d8:	f842                	sd	a6,48(sp)
ffffffffc02066da:	f472                	sd	t3,40(sp)
ffffffffc02066dc:	ef4fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02066e0:	7362                	ld	t1,56(sp)
ffffffffc02066e2:	7e22                	ld	t3,40(sp)
ffffffffc02066e4:	7842                	ld	a6,48(sp)
ffffffffc02066e6:	00651463          	bne	a0,t1,ffffffffc02066ee <stride_dequeue+0x16e2>
ffffffffc02066ea:	18a0106f          	j	ffffffffc0207874 <stride_dequeue+0x2868>
ffffffffc02066ee:	010e3583          	ld	a1,16(t3)
ffffffffc02066f2:	854e                	mv	a0,s3
ffffffffc02066f4:	008e3b03          	ld	s6,8(t3)
ffffffffc02066f8:	f842                	sd	a6,48(sp)
ffffffffc02066fa:	f472                	sd	t3,40(sp)
ffffffffc02066fc:	f30fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206700:	7e22                	ld	t3,40(sp)
ffffffffc0206702:	7842                	ld	a6,48(sp)
ffffffffc0206704:	016e3823          	sd	s6,16(t3)
ffffffffc0206708:	00ae3423          	sd	a0,8(t3)
ffffffffc020670c:	010c2b03          	lw	s6,16(s8)
ffffffffc0206710:	e119                	bnez	a0,ffffffffc0206716 <stride_dequeue+0x170a>
ffffffffc0206712:	1ee0106f          	j	ffffffffc0207900 <stride_dequeue+0x28f4>
ffffffffc0206716:	01c53023          	sd	t3,0(a0)
ffffffffc020671a:	89f2                	mv	s3,t3
ffffffffc020671c:	7782                	ld	a5,32(sp)
ffffffffc020671e:	01383423          	sd	s3,8(a6)
ffffffffc0206722:	00f83823          	sd	a5,16(a6)
ffffffffc0206726:	0109b023          	sd	a6,0(s3)
ffffffffc020672a:	89c2                	mv	s3,a6
ffffffffc020672c:	67e2                	ld	a5,24(sp)
ffffffffc020672e:	013a3423          	sd	s3,8(s4)
ffffffffc0206732:	00fa3823          	sd	a5,16(s4)
ffffffffc0206736:	0149b023          	sd	s4,0(s3)
ffffffffc020673a:	89da                	mv	s3,s6
ffffffffc020673c:	85eff06f          	j	ffffffffc020579a <stride_dequeue+0x78e>
ffffffffc0206740:	008cb783          	ld	a5,8(s9)
ffffffffc0206744:	010cb983          	ld	s3,16(s9)
ffffffffc0206748:	f42a                	sd	a0,40(sp)
ffffffffc020674a:	f03e                	sd	a5,32(sp)
ffffffffc020674c:	04098163          	beqz	s3,ffffffffc020678e <stride_dequeue+0x1782>
ffffffffc0206750:	859a                	mv	a1,t1
ffffffffc0206752:	854e                	mv	a0,s3
ffffffffc0206754:	fc42                	sd	a6,56(sp)
ffffffffc0206756:	f81a                	sd	t1,48(sp)
ffffffffc0206758:	e78fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020675c:	7e22                	ld	t3,40(sp)
ffffffffc020675e:	7342                	ld	t1,48(sp)
ffffffffc0206760:	7862                	ld	a6,56(sp)
ffffffffc0206762:	11c505e3          	beq	a0,t3,ffffffffc020706c <stride_dequeue+0x2060>
ffffffffc0206766:	01033583          	ld	a1,16(t1)
ffffffffc020676a:	854e                	mv	a0,s3
ffffffffc020676c:	00833b03          	ld	s6,8(t1)
ffffffffc0206770:	f842                	sd	a6,48(sp)
ffffffffc0206772:	f41a                	sd	t1,40(sp)
ffffffffc0206774:	eb8fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206778:	7322                	ld	t1,40(sp)
ffffffffc020677a:	7842                	ld	a6,48(sp)
ffffffffc020677c:	01633823          	sd	s6,16(t1)
ffffffffc0206780:	00a33423          	sd	a0,8(t1)
ffffffffc0206784:	010c2b03          	lw	s6,16(s8)
ffffffffc0206788:	c119                	beqz	a0,ffffffffc020678e <stride_dequeue+0x1782>
ffffffffc020678a:	00653023          	sd	t1,0(a0)
ffffffffc020678e:	7782                	ld	a5,32(sp)
ffffffffc0206790:	006cb423          	sd	t1,8(s9)
ffffffffc0206794:	89da                	mv	s3,s6
ffffffffc0206796:	00fcb823          	sd	a5,16(s9)
ffffffffc020679a:	01933023          	sd	s9,0(t1)
ffffffffc020679e:	9aeff06f          	j	ffffffffc020594c <stride_dequeue+0x940>
ffffffffc02067a2:	008db783          	ld	a5,8(s11)
ffffffffc02067a6:	010db983          	ld	s3,16(s11)
ffffffffc02067aa:	f02a                	sd	a0,32(sp)
ffffffffc02067ac:	ec3e                	sd	a5,24(sp)
ffffffffc02067ae:	04098563          	beqz	s3,ffffffffc02067f8 <stride_dequeue+0x17ec>
ffffffffc02067b2:	859a                	mv	a1,t1
ffffffffc02067b4:	854e                	mv	a0,s3
ffffffffc02067b6:	fc42                	sd	a6,56(sp)
ffffffffc02067b8:	f832                	sd	a2,48(sp)
ffffffffc02067ba:	f41a                	sd	t1,40(sp)
ffffffffc02067bc:	e14fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02067c0:	7e02                	ld	t3,32(sp)
ffffffffc02067c2:	7322                	ld	t1,40(sp)
ffffffffc02067c4:	7642                	ld	a2,48(sp)
ffffffffc02067c6:	7862                	ld	a6,56(sp)
ffffffffc02067c8:	15c50be3          	beq	a0,t3,ffffffffc020711e <stride_dequeue+0x2112>
ffffffffc02067cc:	01033583          	ld	a1,16(t1)
ffffffffc02067d0:	854e                	mv	a0,s3
ffffffffc02067d2:	00833b03          	ld	s6,8(t1)
ffffffffc02067d6:	f842                	sd	a6,48(sp)
ffffffffc02067d8:	f432                	sd	a2,40(sp)
ffffffffc02067da:	f01a                	sd	t1,32(sp)
ffffffffc02067dc:	e50fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02067e0:	7302                	ld	t1,32(sp)
ffffffffc02067e2:	7622                	ld	a2,40(sp)
ffffffffc02067e4:	7842                	ld	a6,48(sp)
ffffffffc02067e6:	01633823          	sd	s6,16(t1)
ffffffffc02067ea:	00a33423          	sd	a0,8(t1)
ffffffffc02067ee:	010c2b03          	lw	s6,16(s8)
ffffffffc02067f2:	c119                	beqz	a0,ffffffffc02067f8 <stride_dequeue+0x17ec>
ffffffffc02067f4:	00653023          	sd	t1,0(a0)
ffffffffc02067f8:	67e2                	ld	a5,24(sp)
ffffffffc02067fa:	006db423          	sd	t1,8(s11)
ffffffffc02067fe:	89da                	mv	s3,s6
ffffffffc0206800:	00fdb823          	sd	a5,16(s11)
ffffffffc0206804:	01b33023          	sd	s11,0(t1)
ffffffffc0206808:	c3dfe06f          	j	ffffffffc0205444 <stride_dequeue+0x438>
ffffffffc020680c:	0088b783          	ld	a5,8(a7)
ffffffffc0206810:	0108b983          	ld	s3,16(a7)
ffffffffc0206814:	f42a                	sd	a0,40(sp)
ffffffffc0206816:	f03e                	sd	a5,32(sp)
ffffffffc0206818:	04098063          	beqz	s3,ffffffffc0206858 <stride_dequeue+0x184c>
ffffffffc020681c:	85c2                	mv	a1,a6
ffffffffc020681e:	854e                	mv	a0,s3
ffffffffc0206820:	fc46                	sd	a7,56(sp)
ffffffffc0206822:	daefe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206826:	7e22                	ld	t3,40(sp)
ffffffffc0206828:	7842                	ld	a6,48(sp)
ffffffffc020682a:	78e2                	ld	a7,56(sp)
ffffffffc020682c:	29c50de3          	beq	a0,t3,ffffffffc02072c6 <stride_dequeue+0x22ba>
ffffffffc0206830:	01083583          	ld	a1,16(a6)
ffffffffc0206834:	854e                	mv	a0,s3
ffffffffc0206836:	00883b03          	ld	s6,8(a6)
ffffffffc020683a:	f846                	sd	a7,48(sp)
ffffffffc020683c:	f442                	sd	a6,40(sp)
ffffffffc020683e:	deefe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206842:	7822                	ld	a6,40(sp)
ffffffffc0206844:	78c2                	ld	a7,48(sp)
ffffffffc0206846:	01683823          	sd	s6,16(a6)
ffffffffc020684a:	00a83423          	sd	a0,8(a6)
ffffffffc020684e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206852:	c119                	beqz	a0,ffffffffc0206858 <stride_dequeue+0x184c>
ffffffffc0206854:	01053023          	sd	a6,0(a0)
ffffffffc0206858:	7782                	ld	a5,32(sp)
ffffffffc020685a:	0108b423          	sd	a6,8(a7)
ffffffffc020685e:	89da                	mv	s3,s6
ffffffffc0206860:	00f8b823          	sd	a5,16(a7)
ffffffffc0206864:	01183023          	sd	a7,0(a6)
ffffffffc0206868:	8846                	mv	a6,a7
ffffffffc020686a:	d08ff06f          	j	ffffffffc0205d72 <stride_dequeue+0xd66>
ffffffffc020686e:	008db783          	ld	a5,8(s11)
ffffffffc0206872:	010db983          	ld	s3,16(s11)
ffffffffc0206876:	f42a                	sd	a0,40(sp)
ffffffffc0206878:	f03e                	sd	a5,32(sp)
ffffffffc020687a:	04098163          	beqz	s3,ffffffffc02068bc <stride_dequeue+0x18b0>
ffffffffc020687e:	859a                	mv	a1,t1
ffffffffc0206880:	854e                	mv	a0,s3
ffffffffc0206882:	fc42                	sd	a6,56(sp)
ffffffffc0206884:	f81a                	sd	t1,48(sp)
ffffffffc0206886:	d4afe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc020688a:	7e22                	ld	t3,40(sp)
ffffffffc020688c:	7342                	ld	t1,48(sp)
ffffffffc020688e:	7862                	ld	a6,56(sp)
ffffffffc0206890:	29c507e3          	beq	a0,t3,ffffffffc020731e <stride_dequeue+0x2312>
ffffffffc0206894:	01033583          	ld	a1,16(t1)
ffffffffc0206898:	854e                	mv	a0,s3
ffffffffc020689a:	00833b03          	ld	s6,8(t1)
ffffffffc020689e:	f842                	sd	a6,48(sp)
ffffffffc02068a0:	f41a                	sd	t1,40(sp)
ffffffffc02068a2:	d8afe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02068a6:	7322                	ld	t1,40(sp)
ffffffffc02068a8:	7842                	ld	a6,48(sp)
ffffffffc02068aa:	01633823          	sd	s6,16(t1)
ffffffffc02068ae:	00a33423          	sd	a0,8(t1)
ffffffffc02068b2:	010c2b03          	lw	s6,16(s8)
ffffffffc02068b6:	c119                	beqz	a0,ffffffffc02068bc <stride_dequeue+0x18b0>
ffffffffc02068b8:	00653023          	sd	t1,0(a0)
ffffffffc02068bc:	7782                	ld	a5,32(sp)
ffffffffc02068be:	006db423          	sd	t1,8(s11)
ffffffffc02068c2:	89da                	mv	s3,s6
ffffffffc02068c4:	00fdb823          	sd	a5,16(s11)
ffffffffc02068c8:	01b33023          	sd	s11,0(t1)
ffffffffc02068cc:	a1ffe06f          	j	ffffffffc02052ea <stride_dequeue+0x2de>
ffffffffc02068d0:	0088b783          	ld	a5,8(a7)
ffffffffc02068d4:	0108b983          	ld	s3,16(a7)
ffffffffc02068d8:	f42a                	sd	a0,40(sp)
ffffffffc02068da:	f03e                	sd	a5,32(sp)
ffffffffc02068dc:	04098063          	beqz	s3,ffffffffc020691c <stride_dequeue+0x1910>
ffffffffc02068e0:	859a                	mv	a1,t1
ffffffffc02068e2:	854e                	mv	a0,s3
ffffffffc02068e4:	fc46                	sd	a7,56(sp)
ffffffffc02068e6:	ceafe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02068ea:	7e22                	ld	t3,40(sp)
ffffffffc02068ec:	7342                	ld	t1,48(sp)
ffffffffc02068ee:	78e2                	ld	a7,56(sp)
ffffffffc02068f0:	73c50263          	beq	a0,t3,ffffffffc0207014 <stride_dequeue+0x2008>
ffffffffc02068f4:	01033583          	ld	a1,16(t1)
ffffffffc02068f8:	854e                	mv	a0,s3
ffffffffc02068fa:	00833b03          	ld	s6,8(t1)
ffffffffc02068fe:	f846                	sd	a7,48(sp)
ffffffffc0206900:	f41a                	sd	t1,40(sp)
ffffffffc0206902:	d2afe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206906:	7322                	ld	t1,40(sp)
ffffffffc0206908:	78c2                	ld	a7,48(sp)
ffffffffc020690a:	01633823          	sd	s6,16(t1)
ffffffffc020690e:	00a33423          	sd	a0,8(t1)
ffffffffc0206912:	010c2b03          	lw	s6,16(s8)
ffffffffc0206916:	c119                	beqz	a0,ffffffffc020691c <stride_dequeue+0x1910>
ffffffffc0206918:	00653023          	sd	t1,0(a0)
ffffffffc020691c:	7782                	ld	a5,32(sp)
ffffffffc020691e:	0068b423          	sd	t1,8(a7)
ffffffffc0206922:	89da                	mv	s3,s6
ffffffffc0206924:	00f8b823          	sd	a5,16(a7)
ffffffffc0206928:	01133023          	sd	a7,0(t1)
ffffffffc020692c:	f3dfe06f          	j	ffffffffc0205868 <stride_dequeue+0x85c>
ffffffffc0206930:	01093503          	ld	a0,16(s2)
ffffffffc0206934:	00893983          	ld	s3,8(s2)
ffffffffc0206938:	85da                	mv	a1,s6
ffffffffc020693a:	cf2fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020693e:	00a93423          	sd	a0,8(s2)
ffffffffc0206942:	01393823          	sd	s3,16(s2)
ffffffffc0206946:	7822                	ld	a6,40(sp)
ffffffffc0206948:	77c2                	ld	a5,48(sp)
ffffffffc020694a:	010c2983          	lw	s3,16(s8)
ffffffffc020694e:	e119                	bnez	a0,ffffffffc0206954 <stride_dequeue+0x1948>
ffffffffc0206950:	803fe06f          	j	ffffffffc0205152 <stride_dequeue+0x146>
ffffffffc0206954:	01253023          	sd	s2,0(a0)
ffffffffc0206958:	ffafe06f          	j	ffffffffc0205152 <stride_dequeue+0x146>
ffffffffc020695c:	0089b783          	ld	a5,8(s3)
ffffffffc0206960:	0109b803          	ld	a6,16(s3)
ffffffffc0206964:	f42a                	sd	a0,40(sp)
ffffffffc0206966:	ec3e                	sd	a5,24(sp)
ffffffffc0206968:	02080b63          	beqz	a6,ffffffffc020699e <stride_dequeue+0x1992>
ffffffffc020696c:	8542                	mv	a0,a6
ffffffffc020696e:	85d2                	mv	a1,s4
ffffffffc0206970:	f042                	sd	a6,32(sp)
ffffffffc0206972:	c5efe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206976:	77a2                	ld	a5,40(sp)
ffffffffc0206978:	7802                	ld	a6,32(sp)
ffffffffc020697a:	3cf50be3          	beq	a0,a5,ffffffffc0207550 <stride_dequeue+0x2544>
ffffffffc020697e:	010a3583          	ld	a1,16(s4)
ffffffffc0206982:	008a3b03          	ld	s6,8(s4)
ffffffffc0206986:	8542                	mv	a0,a6
ffffffffc0206988:	ca4fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020698c:	00aa3423          	sd	a0,8(s4)
ffffffffc0206990:	016a3823          	sd	s6,16(s4)
ffffffffc0206994:	010c2b03          	lw	s6,16(s8)
ffffffffc0206998:	c119                	beqz	a0,ffffffffc020699e <stride_dequeue+0x1992>
ffffffffc020699a:	01453023          	sd	s4,0(a0)
ffffffffc020699e:	67e2                	ld	a5,24(sp)
ffffffffc02069a0:	0149b423          	sd	s4,8(s3)
ffffffffc02069a4:	00f9b823          	sd	a5,16(s3)
ffffffffc02069a8:	013a3023          	sd	s3,0(s4)
ffffffffc02069ac:	8a4e                	mv	s4,s3
ffffffffc02069ae:	c90ff06f          	j	ffffffffc0205e3e <stride_dequeue+0xe32>
ffffffffc02069b2:	0089b783          	ld	a5,8(s3)
ffffffffc02069b6:	0109b803          	ld	a6,16(s3)
ffffffffc02069ba:	f42a                	sd	a0,40(sp)
ffffffffc02069bc:	ec3e                	sd	a5,24(sp)
ffffffffc02069be:	02080b63          	beqz	a6,ffffffffc02069f4 <stride_dequeue+0x19e8>
ffffffffc02069c2:	8542                	mv	a0,a6
ffffffffc02069c4:	85e6                	mv	a1,s9
ffffffffc02069c6:	f042                	sd	a6,32(sp)
ffffffffc02069c8:	c08fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc02069cc:	77a2                	ld	a5,40(sp)
ffffffffc02069ce:	7802                	ld	a6,32(sp)
ffffffffc02069d0:	28f50ee3          	beq	a0,a5,ffffffffc020746c <stride_dequeue+0x2460>
ffffffffc02069d4:	010cb583          	ld	a1,16(s9)
ffffffffc02069d8:	008cbb03          	ld	s6,8(s9)
ffffffffc02069dc:	8542                	mv	a0,a6
ffffffffc02069de:	c4efe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02069e2:	00acb423          	sd	a0,8(s9)
ffffffffc02069e6:	016cb823          	sd	s6,16(s9)
ffffffffc02069ea:	010c2b03          	lw	s6,16(s8)
ffffffffc02069ee:	c119                	beqz	a0,ffffffffc02069f4 <stride_dequeue+0x19e8>
ffffffffc02069f0:	01953023          	sd	s9,0(a0)
ffffffffc02069f4:	67e2                	ld	a5,24(sp)
ffffffffc02069f6:	0199b423          	sd	s9,8(s3)
ffffffffc02069fa:	00f9b823          	sd	a5,16(s3)
ffffffffc02069fe:	013cb023          	sd	s3,0(s9)
ffffffffc0206a02:	8cce                	mv	s9,s3
ffffffffc0206a04:	de4ff06f          	j	ffffffffc0205fe8 <stride_dequeue+0xfdc>
ffffffffc0206a08:	0089b783          	ld	a5,8(s3)
ffffffffc0206a0c:	0109b803          	ld	a6,16(s3)
ffffffffc0206a10:	f42a                	sd	a0,40(sp)
ffffffffc0206a12:	e83e                	sd	a5,16(sp)
ffffffffc0206a14:	02080f63          	beqz	a6,ffffffffc0206a52 <stride_dequeue+0x1a46>
ffffffffc0206a18:	8542                	mv	a0,a6
ffffffffc0206a1a:	85d2                	mv	a1,s4
ffffffffc0206a1c:	f032                	sd	a2,32(sp)
ffffffffc0206a1e:	ec42                	sd	a6,24(sp)
ffffffffc0206a20:	bb0fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206a24:	77a2                	ld	a5,40(sp)
ffffffffc0206a26:	6862                	ld	a6,24(sp)
ffffffffc0206a28:	7602                	ld	a2,32(sp)
ffffffffc0206a2a:	26f506e3          	beq	a0,a5,ffffffffc0207496 <stride_dequeue+0x248a>
ffffffffc0206a2e:	010a3583          	ld	a1,16(s4)
ffffffffc0206a32:	008a3b03          	ld	s6,8(s4)
ffffffffc0206a36:	8542                	mv	a0,a6
ffffffffc0206a38:	ec32                	sd	a2,24(sp)
ffffffffc0206a3a:	bf2fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206a3e:	00aa3423          	sd	a0,8(s4)
ffffffffc0206a42:	016a3823          	sd	s6,16(s4)
ffffffffc0206a46:	6662                	ld	a2,24(sp)
ffffffffc0206a48:	010c2b03          	lw	s6,16(s8)
ffffffffc0206a4c:	c119                	beqz	a0,ffffffffc0206a52 <stride_dequeue+0x1a46>
ffffffffc0206a4e:	01453023          	sd	s4,0(a0)
ffffffffc0206a52:	67c2                	ld	a5,16(sp)
ffffffffc0206a54:	0149b423          	sd	s4,8(s3)
ffffffffc0206a58:	00f9b823          	sd	a5,16(s3)
ffffffffc0206a5c:	013a3023          	sd	s3,0(s4)
ffffffffc0206a60:	8a4e                	mv	s4,s3
ffffffffc0206a62:	cb8ff06f          	j	ffffffffc0205f1a <stride_dequeue+0xf0e>
ffffffffc0206a66:	008a3783          	ld	a5,8(s4)
ffffffffc0206a6a:	010a3883          	ld	a7,16(s4)
ffffffffc0206a6e:	f42a                	sd	a0,40(sp)
ffffffffc0206a70:	ec3e                	sd	a5,24(sp)
ffffffffc0206a72:	02088b63          	beqz	a7,ffffffffc0206aa8 <stride_dequeue+0x1a9c>
ffffffffc0206a76:	8546                	mv	a0,a7
ffffffffc0206a78:	85ce                	mv	a1,s3
ffffffffc0206a7a:	f046                	sd	a7,32(sp)
ffffffffc0206a7c:	b54fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206a80:	77a2                	ld	a5,40(sp)
ffffffffc0206a82:	7882                	ld	a7,32(sp)
ffffffffc0206a84:	26f501e3          	beq	a0,a5,ffffffffc02074e6 <stride_dequeue+0x24da>
ffffffffc0206a88:	0109b583          	ld	a1,16(s3)
ffffffffc0206a8c:	0089bb03          	ld	s6,8(s3)
ffffffffc0206a90:	8546                	mv	a0,a7
ffffffffc0206a92:	b9afe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206a96:	00a9b423          	sd	a0,8(s3)
ffffffffc0206a9a:	0169b823          	sd	s6,16(s3)
ffffffffc0206a9e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206aa2:	c119                	beqz	a0,ffffffffc0206aa8 <stride_dequeue+0x1a9c>
ffffffffc0206aa4:	01353023          	sd	s3,0(a0)
ffffffffc0206aa8:	67e2                	ld	a5,24(sp)
ffffffffc0206aaa:	013a3423          	sd	s3,8(s4)
ffffffffc0206aae:	00fa3823          	sd	a5,16(s4)
ffffffffc0206ab2:	0149b023          	sd	s4,0(s3)
ffffffffc0206ab6:	89d2                	mv	s3,s4
ffffffffc0206ab8:	f9bfe06f          	j	ffffffffc0205a52 <stride_dequeue+0xa46>
ffffffffc0206abc:	008a3783          	ld	a5,8(s4)
ffffffffc0206ac0:	010a3883          	ld	a7,16(s4)
ffffffffc0206ac4:	fc2a                	sd	a0,56(sp)
ffffffffc0206ac6:	f03e                	sd	a5,32(sp)
ffffffffc0206ac8:	02088f63          	beqz	a7,ffffffffc0206b06 <stride_dequeue+0x1afa>
ffffffffc0206acc:	8546                	mv	a0,a7
ffffffffc0206ace:	85ce                	mv	a1,s3
ffffffffc0206ad0:	f842                	sd	a6,48(sp)
ffffffffc0206ad2:	f446                	sd	a7,40(sp)
ffffffffc0206ad4:	afcfe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206ad8:	7e62                	ld	t3,56(sp)
ffffffffc0206ada:	78a2                	ld	a7,40(sp)
ffffffffc0206adc:	7842                	ld	a6,48(sp)
ffffffffc0206ade:	35c509e3          	beq	a0,t3,ffffffffc0207630 <stride_dequeue+0x2624>
ffffffffc0206ae2:	0109b583          	ld	a1,16(s3)
ffffffffc0206ae6:	0089bb03          	ld	s6,8(s3)
ffffffffc0206aea:	8546                	mv	a0,a7
ffffffffc0206aec:	f442                	sd	a6,40(sp)
ffffffffc0206aee:	b3efe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206af2:	00a9b423          	sd	a0,8(s3)
ffffffffc0206af6:	0169b823          	sd	s6,16(s3)
ffffffffc0206afa:	7822                	ld	a6,40(sp)
ffffffffc0206afc:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b00:	c119                	beqz	a0,ffffffffc0206b06 <stride_dequeue+0x1afa>
ffffffffc0206b02:	01353023          	sd	s3,0(a0)
ffffffffc0206b06:	7782                	ld	a5,32(sp)
ffffffffc0206b08:	013a3423          	sd	s3,8(s4)
ffffffffc0206b0c:	00fa3823          	sd	a5,16(s4)
ffffffffc0206b10:	0149b023          	sd	s4,0(s3)
ffffffffc0206b14:	89d2                	mv	s3,s4
ffffffffc0206b16:	c73fe06f          	j	ffffffffc0205788 <stride_dequeue+0x77c>
ffffffffc0206b1a:	661c                	ld	a5,8(a2)
ffffffffc0206b1c:	01063883          	ld	a7,16(a2)
ffffffffc0206b20:	fc2a                	sd	a0,56(sp)
ffffffffc0206b22:	ec3e                	sd	a5,24(sp)
ffffffffc0206b24:	04088363          	beqz	a7,ffffffffc0206b6a <stride_dequeue+0x1b5e>
ffffffffc0206b28:	8546                	mv	a0,a7
ffffffffc0206b2a:	85ce                	mv	a1,s3
ffffffffc0206b2c:	f842                	sd	a6,48(sp)
ffffffffc0206b2e:	f432                	sd	a2,40(sp)
ffffffffc0206b30:	f046                	sd	a7,32(sp)
ffffffffc0206b32:	a9efe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206b36:	7e62                	ld	t3,56(sp)
ffffffffc0206b38:	7882                	ld	a7,32(sp)
ffffffffc0206b3a:	7622                	ld	a2,40(sp)
ffffffffc0206b3c:	7842                	ld	a6,48(sp)
ffffffffc0206b3e:	25c501e3          	beq	a0,t3,ffffffffc0207580 <stride_dequeue+0x2574>
ffffffffc0206b42:	0109b583          	ld	a1,16(s3)
ffffffffc0206b46:	0089bb03          	ld	s6,8(s3)
ffffffffc0206b4a:	8546                	mv	a0,a7
ffffffffc0206b4c:	f442                	sd	a6,40(sp)
ffffffffc0206b4e:	f032                	sd	a2,32(sp)
ffffffffc0206b50:	adcfe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206b54:	00a9b423          	sd	a0,8(s3)
ffffffffc0206b58:	0169b823          	sd	s6,16(s3)
ffffffffc0206b5c:	7602                	ld	a2,32(sp)
ffffffffc0206b5e:	7822                	ld	a6,40(sp)
ffffffffc0206b60:	010c2b03          	lw	s6,16(s8)
ffffffffc0206b64:	c119                	beqz	a0,ffffffffc0206b6a <stride_dequeue+0x1b5e>
ffffffffc0206b66:	01353023          	sd	s3,0(a0)
ffffffffc0206b6a:	67e2                	ld	a5,24(sp)
ffffffffc0206b6c:	01363423          	sd	s3,8(a2)
ffffffffc0206b70:	ea1c                	sd	a5,16(a2)
ffffffffc0206b72:	00c9b023          	sd	a2,0(s3)
ffffffffc0206b76:	89b2                	mv	s3,a2
ffffffffc0206b78:	b13fe06f          	j	ffffffffc020568a <stride_dequeue+0x67e>
ffffffffc0206b7c:	89c6                	mv	s3,a7
ffffffffc0206b7e:	9e4ff06f          	j	ffffffffc0205d62 <stride_dequeue+0xd56>
ffffffffc0206b82:	0088b783          	ld	a5,8(a7)
ffffffffc0206b86:	0108b803          	ld	a6,16(a7)
ffffffffc0206b8a:	fc2a                	sd	a0,56(sp)
ffffffffc0206b8c:	f03e                	sd	a5,32(sp)
ffffffffc0206b8e:	02080f63          	beqz	a6,ffffffffc0206bcc <stride_dequeue+0x1bc0>
ffffffffc0206b92:	8542                	mv	a0,a6
ffffffffc0206b94:	85ce                	mv	a1,s3
ffffffffc0206b96:	f846                	sd	a7,48(sp)
ffffffffc0206b98:	f442                	sd	a6,40(sp)
ffffffffc0206b9a:	a36fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206b9e:	7e62                	ld	t3,56(sp)
ffffffffc0206ba0:	7822                	ld	a6,40(sp)
ffffffffc0206ba2:	78c2                	ld	a7,48(sp)
ffffffffc0206ba4:	47c50ce3          	beq	a0,t3,ffffffffc020781c <stride_dequeue+0x2810>
ffffffffc0206ba8:	0109b583          	ld	a1,16(s3)
ffffffffc0206bac:	0089bb03          	ld	s6,8(s3)
ffffffffc0206bb0:	8542                	mv	a0,a6
ffffffffc0206bb2:	f446                	sd	a7,40(sp)
ffffffffc0206bb4:	a78fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206bb8:	00a9b423          	sd	a0,8(s3)
ffffffffc0206bbc:	0169b823          	sd	s6,16(s3)
ffffffffc0206bc0:	78a2                	ld	a7,40(sp)
ffffffffc0206bc2:	010c2b03          	lw	s6,16(s8)
ffffffffc0206bc6:	c119                	beqz	a0,ffffffffc0206bcc <stride_dequeue+0x1bc0>
ffffffffc0206bc8:	01353023          	sd	s3,0(a0)
ffffffffc0206bcc:	7782                	ld	a5,32(sp)
ffffffffc0206bce:	0138b423          	sd	s3,8(a7)
ffffffffc0206bd2:	00f8b823          	sd	a5,16(a7)
ffffffffc0206bd6:	0119b023          	sd	a7,0(s3)
ffffffffc0206bda:	89c6                	mv	s3,a7
ffffffffc0206bdc:	8f0ff06f          	j	ffffffffc0205ccc <stride_dequeue+0xcc0>
ffffffffc0206be0:	0088b783          	ld	a5,8(a7)
ffffffffc0206be4:	0108b803          	ld	a6,16(a7)
ffffffffc0206be8:	fc2a                	sd	a0,56(sp)
ffffffffc0206bea:	f03e                	sd	a5,32(sp)
ffffffffc0206bec:	02080f63          	beqz	a6,ffffffffc0206c2a <stride_dequeue+0x1c1e>
ffffffffc0206bf0:	8542                	mv	a0,a6
ffffffffc0206bf2:	85ce                	mv	a1,s3
ffffffffc0206bf4:	f846                	sd	a7,48(sp)
ffffffffc0206bf6:	f442                	sd	a6,40(sp)
ffffffffc0206bf8:	9d8fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206bfc:	7e62                	ld	t3,56(sp)
ffffffffc0206bfe:	7822                	ld	a6,40(sp)
ffffffffc0206c00:	78c2                	ld	a7,48(sp)
ffffffffc0206c02:	25c50de3          	beq	a0,t3,ffffffffc020765c <stride_dequeue+0x2650>
ffffffffc0206c06:	0109b583          	ld	a1,16(s3)
ffffffffc0206c0a:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c0e:	8542                	mv	a0,a6
ffffffffc0206c10:	f446                	sd	a7,40(sp)
ffffffffc0206c12:	a1afe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206c16:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c1a:	0169b823          	sd	s6,16(s3)
ffffffffc0206c1e:	78a2                	ld	a7,40(sp)
ffffffffc0206c20:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c24:	c119                	beqz	a0,ffffffffc0206c2a <stride_dequeue+0x1c1e>
ffffffffc0206c26:	01353023          	sd	s3,0(a0)
ffffffffc0206c2a:	7782                	ld	a5,32(sp)
ffffffffc0206c2c:	0138b423          	sd	s3,8(a7)
ffffffffc0206c30:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c34:	0119b023          	sd	a7,0(s3)
ffffffffc0206c38:	89c6                	mv	s3,a7
ffffffffc0206c3a:	ee7fe06f          	j	ffffffffc0205b20 <stride_dequeue+0xb14>
ffffffffc0206c3e:	0088b783          	ld	a5,8(a7)
ffffffffc0206c42:	0108b803          	ld	a6,16(a7)
ffffffffc0206c46:	fc2a                	sd	a0,56(sp)
ffffffffc0206c48:	ec3e                	sd	a5,24(sp)
ffffffffc0206c4a:	04080263          	beqz	a6,ffffffffc0206c8e <stride_dequeue+0x1c82>
ffffffffc0206c4e:	8542                	mv	a0,a6
ffffffffc0206c50:	85ce                	mv	a1,s3
ffffffffc0206c52:	f846                	sd	a7,48(sp)
ffffffffc0206c54:	f042                	sd	a6,32(sp)
ffffffffc0206c56:	97afe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206c5a:	7e62                	ld	t3,56(sp)
ffffffffc0206c5c:	7802                	ld	a6,32(sp)
ffffffffc0206c5e:	7622                	ld	a2,40(sp)
ffffffffc0206c60:	78c2                	ld	a7,48(sp)
ffffffffc0206c62:	23c503e3          	beq	a0,t3,ffffffffc0207688 <stride_dequeue+0x267c>
ffffffffc0206c66:	0109b583          	ld	a1,16(s3)
ffffffffc0206c6a:	0089bb03          	ld	s6,8(s3)
ffffffffc0206c6e:	8542                	mv	a0,a6
ffffffffc0206c70:	f446                	sd	a7,40(sp)
ffffffffc0206c72:	f032                	sd	a2,32(sp)
ffffffffc0206c74:	9b8fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206c78:	00a9b423          	sd	a0,8(s3)
ffffffffc0206c7c:	0169b823          	sd	s6,16(s3)
ffffffffc0206c80:	7602                	ld	a2,32(sp)
ffffffffc0206c82:	78a2                	ld	a7,40(sp)
ffffffffc0206c84:	010c2b03          	lw	s6,16(s8)
ffffffffc0206c88:	c119                	beqz	a0,ffffffffc0206c8e <stride_dequeue+0x1c82>
ffffffffc0206c8a:	01353023          	sd	s3,0(a0)
ffffffffc0206c8e:	67e2                	ld	a5,24(sp)
ffffffffc0206c90:	0138b423          	sd	s3,8(a7)
ffffffffc0206c94:	00f8b823          	sd	a5,16(a7)
ffffffffc0206c98:	0119b023          	sd	a7,0(s3)
ffffffffc0206c9c:	89c6                	mv	s3,a7
ffffffffc0206c9e:	f61fe06f          	j	ffffffffc0205bfe <stride_dequeue+0xbf2>
ffffffffc0206ca2:	0089b783          	ld	a5,8(s3)
ffffffffc0206ca6:	0109b303          	ld	t1,16(s3)
ffffffffc0206caa:	fc2a                	sd	a0,56(sp)
ffffffffc0206cac:	f03e                	sd	a5,32(sp)
ffffffffc0206cae:	02030f63          	beqz	t1,ffffffffc0206cec <stride_dequeue+0x1ce0>
ffffffffc0206cb2:	851a                	mv	a0,t1
ffffffffc0206cb4:	85e6                	mv	a1,s9
ffffffffc0206cb6:	f846                	sd	a7,48(sp)
ffffffffc0206cb8:	f41a                	sd	t1,40(sp)
ffffffffc0206cba:	916fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206cbe:	7e62                	ld	t3,56(sp)
ffffffffc0206cc0:	7322                	ld	t1,40(sp)
ffffffffc0206cc2:	78c2                	ld	a7,48(sp)
ffffffffc0206cc4:	11c50be3          	beq	a0,t3,ffffffffc02075da <stride_dequeue+0x25ce>
ffffffffc0206cc8:	010cb583          	ld	a1,16(s9)
ffffffffc0206ccc:	008cbb03          	ld	s6,8(s9)
ffffffffc0206cd0:	851a                	mv	a0,t1
ffffffffc0206cd2:	f446                	sd	a7,40(sp)
ffffffffc0206cd4:	958fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206cd8:	00acb423          	sd	a0,8(s9)
ffffffffc0206cdc:	016cb823          	sd	s6,16(s9)
ffffffffc0206ce0:	78a2                	ld	a7,40(sp)
ffffffffc0206ce2:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ce6:	c119                	beqz	a0,ffffffffc0206cec <stride_dequeue+0x1ce0>
ffffffffc0206ce8:	01953023          	sd	s9,0(a0)
ffffffffc0206cec:	7782                	ld	a5,32(sp)
ffffffffc0206cee:	0199b423          	sd	s9,8(s3)
ffffffffc0206cf2:	00f9b823          	sd	a5,16(s3)
ffffffffc0206cf6:	013cb023          	sd	s3,0(s9)
ffffffffc0206cfa:	8cce                	mv	s9,s3
ffffffffc0206cfc:	b8aff06f          	j	ffffffffc0206086 <stride_dequeue+0x107a>
ffffffffc0206d00:	89ee                	mv	s3,s11
ffffffffc0206d02:	dd6fe06f          	j	ffffffffc02052d8 <stride_dequeue+0x2cc>
ffffffffc0206d06:	0089b783          	ld	a5,8(s3)
ffffffffc0206d0a:	0109b303          	ld	t1,16(s3)
ffffffffc0206d0e:	fc2a                	sd	a0,56(sp)
ffffffffc0206d10:	f03e                	sd	a5,32(sp)
ffffffffc0206d12:	02030f63          	beqz	t1,ffffffffc0206d50 <stride_dequeue+0x1d44>
ffffffffc0206d16:	85c2                	mv	a1,a6
ffffffffc0206d18:	851a                	mv	a0,t1
ffffffffc0206d1a:	f842                	sd	a6,48(sp)
ffffffffc0206d1c:	f41a                	sd	t1,40(sp)
ffffffffc0206d1e:	8b2fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206d22:	7e62                	ld	t3,56(sp)
ffffffffc0206d24:	7322                	ld	t1,40(sp)
ffffffffc0206d26:	7842                	ld	a6,48(sp)
ffffffffc0206d28:	0dc50fe3          	beq	a0,t3,ffffffffc0207606 <stride_dequeue+0x25fa>
ffffffffc0206d2c:	01083583          	ld	a1,16(a6)
ffffffffc0206d30:	851a                	mv	a0,t1
ffffffffc0206d32:	00883b03          	ld	s6,8(a6)
ffffffffc0206d36:	f442                	sd	a6,40(sp)
ffffffffc0206d38:	8f4fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206d3c:	7822                	ld	a6,40(sp)
ffffffffc0206d3e:	01683823          	sd	s6,16(a6)
ffffffffc0206d42:	00a83423          	sd	a0,8(a6)
ffffffffc0206d46:	010c2b03          	lw	s6,16(s8)
ffffffffc0206d4a:	c119                	beqz	a0,ffffffffc0206d50 <stride_dequeue+0x1d44>
ffffffffc0206d4c:	01053023          	sd	a6,0(a0)
ffffffffc0206d50:	7782                	ld	a5,32(sp)
ffffffffc0206d52:	0109b423          	sd	a6,8(s3)
ffffffffc0206d56:	00f9b823          	sd	a5,16(s3)
ffffffffc0206d5a:	01383023          	sd	s3,0(a6)
ffffffffc0206d5e:	884e                	mv	a6,s3
ffffffffc0206d60:	bc4ff06f          	j	ffffffffc0206124 <stride_dequeue+0x1118>
ffffffffc0206d64:	008cb783          	ld	a5,8(s9)
ffffffffc0206d68:	010cb883          	ld	a7,16(s9)
ffffffffc0206d6c:	fc2a                	sd	a0,56(sp)
ffffffffc0206d6e:	f03e                	sd	a5,32(sp)
ffffffffc0206d70:	02088f63          	beqz	a7,ffffffffc0206dae <stride_dequeue+0x1da2>
ffffffffc0206d74:	8546                	mv	a0,a7
ffffffffc0206d76:	85ce                	mv	a1,s3
ffffffffc0206d78:	f842                	sd	a6,48(sp)
ffffffffc0206d7a:	f446                	sd	a7,40(sp)
ffffffffc0206d7c:	854fe0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206d80:	7e62                	ld	t3,56(sp)
ffffffffc0206d82:	78a2                	ld	a7,40(sp)
ffffffffc0206d84:	7842                	ld	a6,48(sp)
ffffffffc0206d86:	27c505e3          	beq	a0,t3,ffffffffc02077f0 <stride_dequeue+0x27e4>
ffffffffc0206d8a:	0109b583          	ld	a1,16(s3)
ffffffffc0206d8e:	0089bb03          	ld	s6,8(s3)
ffffffffc0206d92:	8546                	mv	a0,a7
ffffffffc0206d94:	f442                	sd	a6,40(sp)
ffffffffc0206d96:	896fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206d9a:	00a9b423          	sd	a0,8(s3)
ffffffffc0206d9e:	0169b823          	sd	s6,16(s3)
ffffffffc0206da2:	7822                	ld	a6,40(sp)
ffffffffc0206da4:	010c2b03          	lw	s6,16(s8)
ffffffffc0206da8:	c119                	beqz	a0,ffffffffc0206dae <stride_dequeue+0x1da2>
ffffffffc0206daa:	01353023          	sd	s3,0(a0)
ffffffffc0206dae:	7782                	ld	a5,32(sp)
ffffffffc0206db0:	013cb423          	sd	s3,8(s9)
ffffffffc0206db4:	00fcb823          	sd	a5,16(s9)
ffffffffc0206db8:	0199b023          	sd	s9,0(s3)
ffffffffc0206dbc:	89e6                	mv	s3,s9
ffffffffc0206dbe:	fb0fe06f          	j	ffffffffc020556e <stride_dequeue+0x562>
ffffffffc0206dc2:	0089b783          	ld	a5,8(s3)
ffffffffc0206dc6:	0109b303          	ld	t1,16(s3)
ffffffffc0206dca:	fc2a                	sd	a0,56(sp)
ffffffffc0206dcc:	f03e                	sd	a5,32(sp)
ffffffffc0206dce:	02030f63          	beqz	t1,ffffffffc0206e0c <stride_dequeue+0x1e00>
ffffffffc0206dd2:	85c2                	mv	a1,a6
ffffffffc0206dd4:	851a                	mv	a0,t1
ffffffffc0206dd6:	f842                	sd	a6,48(sp)
ffffffffc0206dd8:	f41a                	sd	t1,40(sp)
ffffffffc0206dda:	ff7fd0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206dde:	7e62                	ld	t3,56(sp)
ffffffffc0206de0:	7322                	ld	t1,40(sp)
ffffffffc0206de2:	7842                	ld	a6,48(sp)
ffffffffc0206de4:	1bc509e3          	beq	a0,t3,ffffffffc0207796 <stride_dequeue+0x278a>
ffffffffc0206de8:	01083583          	ld	a1,16(a6)
ffffffffc0206dec:	851a                	mv	a0,t1
ffffffffc0206dee:	00883b03          	ld	s6,8(a6)
ffffffffc0206df2:	f442                	sd	a6,40(sp)
ffffffffc0206df4:	838fe0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206df8:	7822                	ld	a6,40(sp)
ffffffffc0206dfa:	01683823          	sd	s6,16(a6)
ffffffffc0206dfe:	00a83423          	sd	a0,8(a6)
ffffffffc0206e02:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e06:	c119                	beqz	a0,ffffffffc0206e0c <stride_dequeue+0x1e00>
ffffffffc0206e08:	01053023          	sd	a6,0(a0)
ffffffffc0206e0c:	7782                	ld	a5,32(sp)
ffffffffc0206e0e:	0109b423          	sd	a6,8(s3)
ffffffffc0206e12:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e16:	01383023          	sd	s3,0(a6)
ffffffffc0206e1a:	884e                	mv	a6,s3
ffffffffc0206e1c:	ba4ff06f          	j	ffffffffc02061c0 <stride_dequeue+0x11b4>
ffffffffc0206e20:	0089b783          	ld	a5,8(s3)
ffffffffc0206e24:	0109b303          	ld	t1,16(s3)
ffffffffc0206e28:	fc2a                	sd	a0,56(sp)
ffffffffc0206e2a:	ec3e                	sd	a5,24(sp)
ffffffffc0206e2c:	04030363          	beqz	t1,ffffffffc0206e72 <stride_dequeue+0x1e66>
ffffffffc0206e30:	85c2                	mv	a1,a6
ffffffffc0206e32:	851a                	mv	a0,t1
ffffffffc0206e34:	f832                	sd	a2,48(sp)
ffffffffc0206e36:	f442                	sd	a6,40(sp)
ffffffffc0206e38:	f01a                	sd	t1,32(sp)
ffffffffc0206e3a:	f97fd0ef          	jal	ra,ffffffffc0204dd0 <proc_stride_comp_f>
ffffffffc0206e3e:	7642                	ld	a2,48(sp)
ffffffffc0206e40:	7e62                	ld	t3,56(sp)
ffffffffc0206e42:	7822                	ld	a6,40(sp)
ffffffffc0206e44:	f432                	sd	a2,40(sp)
ffffffffc0206e46:	7302                	ld	t1,32(sp)
ffffffffc0206e48:	29c507e3          	beq	a0,t3,ffffffffc02078d6 <stride_dequeue+0x28ca>
ffffffffc0206e4c:	01083583          	ld	a1,16(a6)
ffffffffc0206e50:	851a                	mv	a0,t1
ffffffffc0206e52:	00883b03          	ld	s6,8(a6)
ffffffffc0206e56:	f042                	sd	a6,32(sp)
ffffffffc0206e58:	fd5fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206e5c:	7802                	ld	a6,32(sp)
ffffffffc0206e5e:	7622                	ld	a2,40(sp)
ffffffffc0206e60:	01683823          	sd	s6,16(a6)
ffffffffc0206e64:	00a83423          	sd	a0,8(a6)
ffffffffc0206e68:	010c2b03          	lw	s6,16(s8)
ffffffffc0206e6c:	c119                	beqz	a0,ffffffffc0206e72 <stride_dequeue+0x1e66>
ffffffffc0206e6e:	01053023          	sd	a6,0(a0)
ffffffffc0206e72:	67e2                	ld	a5,24(sp)
ffffffffc0206e74:	0109b423          	sd	a6,8(s3)
ffffffffc0206e78:	00f9b823          	sd	a5,16(s3)
ffffffffc0206e7c:	01383023          	sd	s3,0(a6)
ffffffffc0206e80:	884e                	mv	a6,s3
ffffffffc0206e82:	be2ff06f          	j	ffffffffc0206264 <stride_dequeue+0x1258>
ffffffffc0206e86:	89c6                	mv	s3,a7
ffffffffc0206e88:	9cffe06f          	j	ffffffffc0205856 <stride_dequeue+0x84a>
ffffffffc0206e8c:	89e6                	mv	s3,s9
ffffffffc0206e8e:	aadfe06f          	j	ffffffffc020593a <stride_dequeue+0x92e>
ffffffffc0206e92:	89ee                	mv	s3,s11
ffffffffc0206e94:	d9efe06f          	j	ffffffffc0205432 <stride_dequeue+0x426>
ffffffffc0206e98:	89d2                	mv	s3,s4
ffffffffc0206e9a:	bb9fe06f          	j	ffffffffc0205a52 <stride_dequeue+0xa46>
ffffffffc0206e9e:	0108b503          	ld	a0,16(a7)
ffffffffc0206ea2:	85ce                	mv	a1,s3
ffffffffc0206ea4:	0088bb03          	ld	s6,8(a7)
ffffffffc0206ea8:	f81a                	sd	t1,48(sp)
ffffffffc0206eaa:	f446                	sd	a7,40(sp)
ffffffffc0206eac:	f81fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206eb0:	78a2                	ld	a7,40(sp)
ffffffffc0206eb2:	7342                	ld	t1,48(sp)
ffffffffc0206eb4:	0168b823          	sd	s6,16(a7)
ffffffffc0206eb8:	00a8b423          	sd	a0,8(a7)
ffffffffc0206ebc:	010c2b03          	lw	s6,16(s8)
ffffffffc0206ec0:	d179                	beqz	a0,ffffffffc0206e86 <stride_dequeue+0x1e7a>
ffffffffc0206ec2:	01153023          	sd	a7,0(a0)
ffffffffc0206ec6:	89c6                	mv	s3,a7
ffffffffc0206ec8:	98ffe06f          	j	ffffffffc0205856 <stride_dequeue+0x84a>
ffffffffc0206ecc:	0109b503          	ld	a0,16(s3)
ffffffffc0206ed0:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ed4:	85be                	mv	a1,a5
ffffffffc0206ed6:	f442                	sd	a6,40(sp)
ffffffffc0206ed8:	f55fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206edc:	00a9b423          	sd	a0,8(s3)
ffffffffc0206ee0:	0169b823          	sd	s6,16(s3)
ffffffffc0206ee4:	7822                	ld	a6,40(sp)
ffffffffc0206ee6:	010c2b03          	lw	s6,16(s8)
ffffffffc0206eea:	5e050b63          	beqz	a0,ffffffffc02074e0 <stride_dequeue+0x24d4>
ffffffffc0206eee:	01353023          	sd	s3,0(a0)
ffffffffc0206ef2:	87ce                	mv	a5,s3
ffffffffc0206ef4:	bccff06f          	j	ffffffffc02062c0 <stride_dequeue+0x12b4>
ffffffffc0206ef8:	010cb503          	ld	a0,16(s9)
ffffffffc0206efc:	008cbb03          	ld	s6,8(s9)
ffffffffc0206f00:	85ce                	mv	a1,s3
ffffffffc0206f02:	f2bfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206f06:	00acb423          	sd	a0,8(s9)
ffffffffc0206f0a:	016cb823          	sd	s6,16(s9)
ffffffffc0206f0e:	7822                	ld	a6,40(sp)
ffffffffc0206f10:	7342                	ld	t1,48(sp)
ffffffffc0206f12:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f16:	d93d                	beqz	a0,ffffffffc0206e8c <stride_dequeue+0x1e80>
ffffffffc0206f18:	01953023          	sd	s9,0(a0)
ffffffffc0206f1c:	89e6                	mv	s3,s9
ffffffffc0206f1e:	a1dfe06f          	j	ffffffffc020593a <stride_dequeue+0x92e>
ffffffffc0206f22:	0108b503          	ld	a0,16(a7)
ffffffffc0206f26:	85ce                	mv	a1,s3
ffffffffc0206f28:	0088bb03          	ld	s6,8(a7)
ffffffffc0206f2c:	f842                	sd	a6,48(sp)
ffffffffc0206f2e:	f446                	sd	a7,40(sp)
ffffffffc0206f30:	efdfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206f34:	78a2                	ld	a7,40(sp)
ffffffffc0206f36:	7842                	ld	a6,48(sp)
ffffffffc0206f38:	0168b823          	sd	s6,16(a7)
ffffffffc0206f3c:	00a8b423          	sd	a0,8(a7)
ffffffffc0206f40:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f44:	c2050ce3          	beqz	a0,ffffffffc0206b7c <stride_dequeue+0x1b70>
ffffffffc0206f48:	01153023          	sd	a7,0(a0)
ffffffffc0206f4c:	89c6                	mv	s3,a7
ffffffffc0206f4e:	e15fe06f          	j	ffffffffc0205d62 <stride_dequeue+0xd56>
ffffffffc0206f52:	010db503          	ld	a0,16(s11)
ffffffffc0206f56:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f5a:	85ce                	mv	a1,s3
ffffffffc0206f5c:	ed1fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206f60:	00adb423          	sd	a0,8(s11)
ffffffffc0206f64:	016db823          	sd	s6,16(s11)
ffffffffc0206f68:	7602                	ld	a2,32(sp)
ffffffffc0206f6a:	7822                	ld	a6,40(sp)
ffffffffc0206f6c:	7342                	ld	t1,48(sp)
ffffffffc0206f6e:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f72:	d105                	beqz	a0,ffffffffc0206e92 <stride_dequeue+0x1e86>
ffffffffc0206f74:	01b53023          	sd	s11,0(a0)
ffffffffc0206f78:	89ee                	mv	s3,s11
ffffffffc0206f7a:	cb8fe06f          	j	ffffffffc0205432 <stride_dequeue+0x426>
ffffffffc0206f7e:	010db503          	ld	a0,16(s11)
ffffffffc0206f82:	008dbb03          	ld	s6,8(s11)
ffffffffc0206f86:	85ce                	mv	a1,s3
ffffffffc0206f88:	ea5fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206f8c:	00adb423          	sd	a0,8(s11)
ffffffffc0206f90:	016db823          	sd	s6,16(s11)
ffffffffc0206f94:	7322                	ld	t1,40(sp)
ffffffffc0206f96:	7842                	ld	a6,48(sp)
ffffffffc0206f98:	010c2b03          	lw	s6,16(s8)
ffffffffc0206f9c:	d60502e3          	beqz	a0,ffffffffc0206d00 <stride_dequeue+0x1cf4>
ffffffffc0206fa0:	01b53023          	sd	s11,0(a0)
ffffffffc0206fa4:	89ee                	mv	s3,s11
ffffffffc0206fa6:	b32fe06f          	j	ffffffffc02052d8 <stride_dequeue+0x2cc>
ffffffffc0206faa:	89e6                	mv	s3,s9
ffffffffc0206fac:	dc2fe06f          	j	ffffffffc020556e <stride_dequeue+0x562>
ffffffffc0206fb0:	89c6                	mv	s3,a7
ffffffffc0206fb2:	d1bfe06f          	j	ffffffffc0205ccc <stride_dequeue+0xcc0>
ffffffffc0206fb6:	00003697          	auipc	a3,0x3
ffffffffc0206fba:	aba68693          	addi	a3,a3,-1350 # ffffffffc0209a70 <default_pmm_manager+0x748>
ffffffffc0206fbe:	00001617          	auipc	a2,0x1
ffffffffc0206fc2:	62a60613          	addi	a2,a2,1578 # ffffffffc02085e8 <commands+0x410>
ffffffffc0206fc6:	06300593          	li	a1,99
ffffffffc0206fca:	00003517          	auipc	a0,0x3
ffffffffc0206fce:	ace50513          	addi	a0,a0,-1330 # ffffffffc0209a98 <default_pmm_manager+0x770>
ffffffffc0206fd2:	a36f90ef          	jal	ra,ffffffffc0200208 <__panic>
ffffffffc0206fd6:	89d2                	mv	s3,s4
ffffffffc0206fd8:	fb0fe06f          	j	ffffffffc0205788 <stride_dequeue+0x77c>
ffffffffc0206fdc:	89c6                	mv	s3,a7
ffffffffc0206fde:	c21fe06f          	j	ffffffffc0205bfe <stride_dequeue+0xbf2>
ffffffffc0206fe2:	89c6                	mv	s3,a7
ffffffffc0206fe4:	b3dfe06f          	j	ffffffffc0205b20 <stride_dequeue+0xb14>
ffffffffc0206fe8:	89b2                	mv	s3,a2
ffffffffc0206fea:	ea0fe06f          	j	ffffffffc020568a <stride_dequeue+0x67e>
ffffffffc0206fee:	0109b503          	ld	a0,16(s3)
ffffffffc0206ff2:	0089bb03          	ld	s6,8(s3)
ffffffffc0206ff6:	85a6                	mv	a1,s1
ffffffffc0206ff8:	e35fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0206ffc:	00a9b423          	sd	a0,8(s3)
ffffffffc0207000:	0169b823          	sd	s6,16(s3)
ffffffffc0207004:	010c2b03          	lw	s6,16(s8)
ffffffffc0207008:	b4050363          	beqz	a0,ffffffffc020634e <stride_dequeue+0x1342>
ffffffffc020700c:	01353023          	sd	s3,0(a0)
ffffffffc0207010:	b3eff06f          	j	ffffffffc020634e <stride_dequeue+0x1342>
ffffffffc0207014:	0109b503          	ld	a0,16(s3)
ffffffffc0207018:	0089bb03          	ld	s6,8(s3)
ffffffffc020701c:	859a                	mv	a1,t1
ffffffffc020701e:	f446                	sd	a7,40(sp)
ffffffffc0207020:	e0dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207024:	00a9b423          	sd	a0,8(s3)
ffffffffc0207028:	0169b823          	sd	s6,16(s3)
ffffffffc020702c:	78a2                	ld	a7,40(sp)
ffffffffc020702e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207032:	100505e3          	beqz	a0,ffffffffc020793c <stride_dequeue+0x2930>
ffffffffc0207036:	01353023          	sd	s3,0(a0)
ffffffffc020703a:	834e                	mv	t1,s3
ffffffffc020703c:	b0c5                	j	ffffffffc020691c <stride_dequeue+0x1910>
ffffffffc020703e:	0109b503          	ld	a0,16(s3)
ffffffffc0207042:	0089bb03          	ld	s6,8(s3)
ffffffffc0207046:	85f2                	mv	a1,t3
ffffffffc0207048:	f442                	sd	a6,40(sp)
ffffffffc020704a:	f032                	sd	a2,32(sp)
ffffffffc020704c:	de1fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207050:	00a9b423          	sd	a0,8(s3)
ffffffffc0207054:	0169b823          	sd	s6,16(s3)
ffffffffc0207058:	7602                	ld	a2,32(sp)
ffffffffc020705a:	7822                	ld	a6,40(sp)
ffffffffc020705c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207060:	9e050b63          	beqz	a0,ffffffffc0206256 <stride_dequeue+0x124a>
ffffffffc0207064:	01353023          	sd	s3,0(a0)
ffffffffc0207068:	9eeff06f          	j	ffffffffc0206256 <stride_dequeue+0x124a>
ffffffffc020706c:	0109b503          	ld	a0,16(s3)
ffffffffc0207070:	0089bb03          	ld	s6,8(s3)
ffffffffc0207074:	859a                	mv	a1,t1
ffffffffc0207076:	f442                	sd	a6,40(sp)
ffffffffc0207078:	db5fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020707c:	00a9b423          	sd	a0,8(s3)
ffffffffc0207080:	0169b823          	sd	s6,16(s3)
ffffffffc0207084:	7822                	ld	a6,40(sp)
ffffffffc0207086:	010c2b03          	lw	s6,16(s8)
ffffffffc020708a:	08050de3          	beqz	a0,ffffffffc0207924 <stride_dequeue+0x2918>
ffffffffc020708e:	01353023          	sd	s3,0(a0)
ffffffffc0207092:	834e                	mv	t1,s3
ffffffffc0207094:	efaff06f          	j	ffffffffc020678e <stride_dequeue+0x1782>
ffffffffc0207098:	89a6                	mv	s3,s1
ffffffffc020709a:	ab4ff06f          	j	ffffffffc020634e <stride_dequeue+0x1342>
ffffffffc020709e:	0109b503          	ld	a0,16(s3)
ffffffffc02070a2:	0089bb03          	ld	s6,8(s3)
ffffffffc02070a6:	85ee                	mv	a1,s11
ffffffffc02070a8:	f046                	sd	a7,32(sp)
ffffffffc02070aa:	d83fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02070ae:	00a9b423          	sd	a0,8(s3)
ffffffffc02070b2:	0169b823          	sd	s6,16(s3)
ffffffffc02070b6:	7882                	ld	a7,32(sp)
ffffffffc02070b8:	010c2b03          	lw	s6,16(s8)
ffffffffc02070bc:	bc050f63          	beqz	a0,ffffffffc020649a <stride_dequeue+0x148e>
ffffffffc02070c0:	01353023          	sd	s3,0(a0)
ffffffffc02070c4:	bd6ff06f          	j	ffffffffc020649a <stride_dequeue+0x148e>
ffffffffc02070c8:	0109b503          	ld	a0,16(s3)
ffffffffc02070cc:	0089bb03          	ld	s6,8(s3)
ffffffffc02070d0:	85f2                	mv	a1,t3
ffffffffc02070d2:	f442                	sd	a6,40(sp)
ffffffffc02070d4:	d59fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02070d8:	00a9b423          	sd	a0,8(s3)
ffffffffc02070dc:	0169b823          	sd	s6,16(s3)
ffffffffc02070e0:	7822                	ld	a6,40(sp)
ffffffffc02070e2:	010c2b03          	lw	s6,16(s8)
ffffffffc02070e6:	e119                	bnez	a0,ffffffffc02070ec <stride_dequeue+0x20e0>
ffffffffc02070e8:	8caff06f          	j	ffffffffc02061b2 <stride_dequeue+0x11a6>
ffffffffc02070ec:	01353023          	sd	s3,0(a0)
ffffffffc02070f0:	8c2ff06f          	j	ffffffffc02061b2 <stride_dequeue+0x11a6>
ffffffffc02070f4:	0109b503          	ld	a0,16(s3)
ffffffffc02070f8:	0089bb03          	ld	s6,8(s3)
ffffffffc02070fc:	85b2                	mv	a1,a2
ffffffffc02070fe:	ec46                	sd	a7,24(sp)
ffffffffc0207100:	d2dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207104:	00a9b423          	sd	a0,8(s3)
ffffffffc0207108:	0169b823          	sd	s6,16(s3)
ffffffffc020710c:	68e2                	ld	a7,24(sp)
ffffffffc020710e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207112:	c2050963          	beqz	a0,ffffffffc0206544 <stride_dequeue+0x1538>
ffffffffc0207116:	01353023          	sd	s3,0(a0)
ffffffffc020711a:	c2aff06f          	j	ffffffffc0206544 <stride_dequeue+0x1538>
ffffffffc020711e:	0109b503          	ld	a0,16(s3)
ffffffffc0207122:	0089bb03          	ld	s6,8(s3)
ffffffffc0207126:	859a                	mv	a1,t1
ffffffffc0207128:	f442                	sd	a6,40(sp)
ffffffffc020712a:	f032                	sd	a2,32(sp)
ffffffffc020712c:	d01fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207130:	00a9b423          	sd	a0,8(s3)
ffffffffc0207134:	0169b823          	sd	s6,16(s3)
ffffffffc0207138:	7602                	ld	a2,32(sp)
ffffffffc020713a:	7822                	ld	a6,40(sp)
ffffffffc020713c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207140:	7c050363          	beqz	a0,ffffffffc0207906 <stride_dequeue+0x28fa>
ffffffffc0207144:	01353023          	sd	s3,0(a0)
ffffffffc0207148:	834e                	mv	t1,s3
ffffffffc020714a:	eaeff06f          	j	ffffffffc02067f8 <stride_dequeue+0x17ec>
ffffffffc020714e:	0109b503          	ld	a0,16(s3)
ffffffffc0207152:	0089bb03          	ld	s6,8(s3)
ffffffffc0207156:	85c2                	mv	a1,a6
ffffffffc0207158:	ec32                	sd	a2,24(sp)
ffffffffc020715a:	cd3fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020715e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207162:	0169b823          	sd	s6,16(s3)
ffffffffc0207166:	6662                	ld	a2,24(sp)
ffffffffc0207168:	010c2b03          	lw	s6,16(s8)
ffffffffc020716c:	d2050263          	beqz	a0,ffffffffc0206690 <stride_dequeue+0x1684>
ffffffffc0207170:	01353023          	sd	s3,0(a0)
ffffffffc0207174:	d1cff06f          	j	ffffffffc0206690 <stride_dequeue+0x1684>
ffffffffc0207178:	0109b503          	ld	a0,16(s3)
ffffffffc020717c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207180:	85c2                	mv	a1,a6
ffffffffc0207182:	cabfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207186:	00a9b423          	sd	a0,8(s3)
ffffffffc020718a:	0169b823          	sd	s6,16(s3)
ffffffffc020718e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207192:	c4050b63          	beqz	a0,ffffffffc02065e8 <stride_dequeue+0x15dc>
ffffffffc0207196:	01353023          	sd	s3,0(a0)
ffffffffc020719a:	c4eff06f          	j	ffffffffc02065e8 <stride_dequeue+0x15dc>
ffffffffc020719e:	0109b503          	ld	a0,16(s3)
ffffffffc02071a2:	0089bb03          	ld	s6,8(s3)
ffffffffc02071a6:	859a                	mv	a1,t1
ffffffffc02071a8:	c85fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02071ac:	00a9b423          	sd	a0,8(s3)
ffffffffc02071b0:	0169b823          	sd	s6,16(s3)
ffffffffc02071b4:	010c2b03          	lw	s6,16(s8)
ffffffffc02071b8:	e119                	bnez	a0,ffffffffc02071be <stride_dequeue+0x21b2>
ffffffffc02071ba:	c77fe06f          	j	ffffffffc0205e30 <stride_dequeue+0xe24>
ffffffffc02071be:	01353023          	sd	s3,0(a0)
ffffffffc02071c2:	c6ffe06f          	j	ffffffffc0205e30 <stride_dequeue+0xe24>
ffffffffc02071c6:	6a08                	ld	a0,16(a2)
ffffffffc02071c8:	85f2                	mv	a1,t3
ffffffffc02071ca:	00863b03          	ld	s6,8(a2)
ffffffffc02071ce:	c5ffd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02071d2:	7602                	ld	a2,32(sp)
ffffffffc02071d4:	7822                	ld	a6,40(sp)
ffffffffc02071d6:	01663823          	sd	s6,16(a2)
ffffffffc02071da:	e608                	sd	a0,8(a2)
ffffffffc02071dc:	010c2b03          	lw	s6,16(s8)
ffffffffc02071e0:	e119                	bnez	a0,ffffffffc02071e6 <stride_dequeue+0x21da>
ffffffffc02071e2:	c9afe06f          	j	ffffffffc020567c <stride_dequeue+0x670>
ffffffffc02071e6:	e110                	sd	a2,0(a0)
ffffffffc02071e8:	c94fe06f          	j	ffffffffc020567c <stride_dequeue+0x670>
ffffffffc02071ec:	010a3503          	ld	a0,16(s4)
ffffffffc02071f0:	008a3b03          	ld	s6,8(s4)
ffffffffc02071f4:	859a                	mv	a1,t1
ffffffffc02071f6:	c37fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02071fa:	00aa3423          	sd	a0,8(s4)
ffffffffc02071fe:	016a3823          	sd	s6,16(s4)
ffffffffc0207202:	010c2b03          	lw	s6,16(s8)
ffffffffc0207206:	e119                	bnez	a0,ffffffffc020720c <stride_dequeue+0x2200>
ffffffffc0207208:	83dfe06f          	j	ffffffffc0205a44 <stride_dequeue+0xa38>
ffffffffc020720c:	01453023          	sd	s4,0(a0)
ffffffffc0207210:	835fe06f          	j	ffffffffc0205a44 <stride_dequeue+0xa38>
ffffffffc0207214:	010cb503          	ld	a0,16(s9)
ffffffffc0207218:	008cbb03          	ld	s6,8(s9)
ffffffffc020721c:	85f2                	mv	a1,t3
ffffffffc020721e:	f442                	sd	a6,40(sp)
ffffffffc0207220:	c0dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207224:	00acb423          	sd	a0,8(s9)
ffffffffc0207228:	016cb823          	sd	s6,16(s9)
ffffffffc020722c:	7822                	ld	a6,40(sp)
ffffffffc020722e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207232:	e119                	bnez	a0,ffffffffc0207238 <stride_dequeue+0x222c>
ffffffffc0207234:	b2cfe06f          	j	ffffffffc0205560 <stride_dequeue+0x554>
ffffffffc0207238:	01953023          	sd	s9,0(a0)
ffffffffc020723c:	b24fe06f          	j	ffffffffc0205560 <stride_dequeue+0x554>
ffffffffc0207240:	010a3503          	ld	a0,16(s4)
ffffffffc0207244:	008a3b03          	ld	s6,8(s4)
ffffffffc0207248:	85f2                	mv	a1,t3
ffffffffc020724a:	f442                	sd	a6,40(sp)
ffffffffc020724c:	be1fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207250:	00aa3423          	sd	a0,8(s4)
ffffffffc0207254:	016a3823          	sd	s6,16(s4)
ffffffffc0207258:	7822                	ld	a6,40(sp)
ffffffffc020725a:	010c2b03          	lw	s6,16(s8)
ffffffffc020725e:	e119                	bnez	a0,ffffffffc0207264 <stride_dequeue+0x2258>
ffffffffc0207260:	d1afe06f          	j	ffffffffc020577a <stride_dequeue+0x76e>
ffffffffc0207264:	01453023          	sd	s4,0(a0)
ffffffffc0207268:	d12fe06f          	j	ffffffffc020577a <stride_dequeue+0x76e>
ffffffffc020726c:	0108b503          	ld	a0,16(a7)
ffffffffc0207270:	85f2                	mv	a1,t3
ffffffffc0207272:	0088bb03          	ld	s6,8(a7)
ffffffffc0207276:	f046                	sd	a7,32(sp)
ffffffffc0207278:	bb5fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020727c:	7882                	ld	a7,32(sp)
ffffffffc020727e:	7622                	ld	a2,40(sp)
ffffffffc0207280:	0168b823          	sd	s6,16(a7)
ffffffffc0207284:	00a8b423          	sd	a0,8(a7)
ffffffffc0207288:	010c2b03          	lw	s6,16(s8)
ffffffffc020728c:	e119                	bnez	a0,ffffffffc0207292 <stride_dequeue+0x2286>
ffffffffc020728e:	963fe06f          	j	ffffffffc0205bf0 <stride_dequeue+0xbe4>
ffffffffc0207292:	01153023          	sd	a7,0(a0)
ffffffffc0207296:	95bfe06f          	j	ffffffffc0205bf0 <stride_dequeue+0xbe4>
ffffffffc020729a:	0108b503          	ld	a0,16(a7)
ffffffffc020729e:	85f2                	mv	a1,t3
ffffffffc02072a0:	0088bb03          	ld	s6,8(a7)
ffffffffc02072a4:	f446                	sd	a7,40(sp)
ffffffffc02072a6:	b87fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02072aa:	78a2                	ld	a7,40(sp)
ffffffffc02072ac:	0168b823          	sd	s6,16(a7)
ffffffffc02072b0:	00a8b423          	sd	a0,8(a7)
ffffffffc02072b4:	010c2b03          	lw	s6,16(s8)
ffffffffc02072b8:	e119                	bnez	a0,ffffffffc02072be <stride_dequeue+0x22b2>
ffffffffc02072ba:	a05fe06f          	j	ffffffffc0205cbe <stride_dequeue+0xcb2>
ffffffffc02072be:	01153023          	sd	a7,0(a0)
ffffffffc02072c2:	9fdfe06f          	j	ffffffffc0205cbe <stride_dequeue+0xcb2>
ffffffffc02072c6:	0109b503          	ld	a0,16(s3)
ffffffffc02072ca:	0089bb03          	ld	s6,8(s3)
ffffffffc02072ce:	85c2                	mv	a1,a6
ffffffffc02072d0:	f446                	sd	a7,40(sp)
ffffffffc02072d2:	b5bfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02072d6:	00a9b423          	sd	a0,8(s3)
ffffffffc02072da:	0169b823          	sd	s6,16(s3)
ffffffffc02072de:	78a2                	ld	a7,40(sp)
ffffffffc02072e0:	010c2b03          	lw	s6,16(s8)
ffffffffc02072e4:	66050563          	beqz	a0,ffffffffc020794e <stride_dequeue+0x2942>
ffffffffc02072e8:	01353023          	sd	s3,0(a0)
ffffffffc02072ec:	884e                	mv	a6,s3
ffffffffc02072ee:	d6aff06f          	j	ffffffffc0206858 <stride_dequeue+0x184c>
ffffffffc02072f2:	0109b503          	ld	a0,16(s3)
ffffffffc02072f6:	0089bb03          	ld	s6,8(s3)
ffffffffc02072fa:	85f2                	mv	a1,t3
ffffffffc02072fc:	f442                	sd	a6,40(sp)
ffffffffc02072fe:	b2ffd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207302:	00a9b423          	sd	a0,8(s3)
ffffffffc0207306:	0169b823          	sd	s6,16(s3)
ffffffffc020730a:	7822                	ld	a6,40(sp)
ffffffffc020730c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207310:	e119                	bnez	a0,ffffffffc0207316 <stride_dequeue+0x230a>
ffffffffc0207312:	e05fe06f          	j	ffffffffc0206116 <stride_dequeue+0x110a>
ffffffffc0207316:	01353023          	sd	s3,0(a0)
ffffffffc020731a:	dfdfe06f          	j	ffffffffc0206116 <stride_dequeue+0x110a>
ffffffffc020731e:	0109b503          	ld	a0,16(s3)
ffffffffc0207322:	0089bb03          	ld	s6,8(s3)
ffffffffc0207326:	859a                	mv	a1,t1
ffffffffc0207328:	f442                	sd	a6,40(sp)
ffffffffc020732a:	b03fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020732e:	00a9b423          	sd	a0,8(s3)
ffffffffc0207332:	0169b823          	sd	s6,16(s3)
ffffffffc0207336:	7822                	ld	a6,40(sp)
ffffffffc0207338:	010c2b03          	lw	s6,16(s8)
ffffffffc020733c:	64050163          	beqz	a0,ffffffffc020797e <stride_dequeue+0x2972>
ffffffffc0207340:	01353023          	sd	s3,0(a0)
ffffffffc0207344:	834e                	mv	t1,s3
ffffffffc0207346:	d76ff06f          	j	ffffffffc02068bc <stride_dequeue+0x18b0>
ffffffffc020734a:	0109b503          	ld	a0,16(s3)
ffffffffc020734e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207352:	85f2                	mv	a1,t3
ffffffffc0207354:	f446                	sd	a7,40(sp)
ffffffffc0207356:	ad7fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020735a:	00a9b423          	sd	a0,8(s3)
ffffffffc020735e:	0169b823          	sd	s6,16(s3)
ffffffffc0207362:	78a2                	ld	a7,40(sp)
ffffffffc0207364:	010c2b03          	lw	s6,16(s8)
ffffffffc0207368:	e119                	bnez	a0,ffffffffc020736e <stride_dequeue+0x2362>
ffffffffc020736a:	d0ffe06f          	j	ffffffffc0206078 <stride_dequeue+0x106c>
ffffffffc020736e:	01353023          	sd	s3,0(a0)
ffffffffc0207372:	d07fe06f          	j	ffffffffc0206078 <stride_dequeue+0x106c>
ffffffffc0207376:	0109b503          	ld	a0,16(s3)
ffffffffc020737a:	0089bb03          	ld	s6,8(s3)
ffffffffc020737e:	859a                	mv	a1,t1
ffffffffc0207380:	aadfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207384:	00a9b423          	sd	a0,8(s3)
ffffffffc0207388:	0169b823          	sd	s6,16(s3)
ffffffffc020738c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207390:	e119                	bnez	a0,ffffffffc0207396 <stride_dequeue+0x238a>
ffffffffc0207392:	c49fe06f          	j	ffffffffc0205fda <stride_dequeue+0xfce>
ffffffffc0207396:	01353023          	sd	s3,0(a0)
ffffffffc020739a:	c41fe06f          	j	ffffffffc0205fda <stride_dequeue+0xfce>
ffffffffc020739e:	0109b503          	ld	a0,16(s3)
ffffffffc02073a2:	0089bb03          	ld	s6,8(s3)
ffffffffc02073a6:	859a                	mv	a1,t1
ffffffffc02073a8:	ec32                	sd	a2,24(sp)
ffffffffc02073aa:	a83fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02073ae:	00a9b423          	sd	a0,8(s3)
ffffffffc02073b2:	0169b823          	sd	s6,16(s3)
ffffffffc02073b6:	6662                	ld	a2,24(sp)
ffffffffc02073b8:	010c2b03          	lw	s6,16(s8)
ffffffffc02073bc:	e119                	bnez	a0,ffffffffc02073c2 <stride_dequeue+0x23b6>
ffffffffc02073be:	b4ffe06f          	j	ffffffffc0205f0c <stride_dequeue+0xf00>
ffffffffc02073c2:	01353023          	sd	s3,0(a0)
ffffffffc02073c6:	b47fe06f          	j	ffffffffc0205f0c <stride_dequeue+0xf00>
ffffffffc02073ca:	0108b503          	ld	a0,16(a7)
ffffffffc02073ce:	85f2                	mv	a1,t3
ffffffffc02073d0:	0088bb03          	ld	s6,8(a7)
ffffffffc02073d4:	f446                	sd	a7,40(sp)
ffffffffc02073d6:	a57fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02073da:	78a2                	ld	a7,40(sp)
ffffffffc02073dc:	0168b823          	sd	s6,16(a7)
ffffffffc02073e0:	00a8b423          	sd	a0,8(a7)
ffffffffc02073e4:	010c2b03          	lw	s6,16(s8)
ffffffffc02073e8:	e119                	bnez	a0,ffffffffc02073ee <stride_dequeue+0x23e2>
ffffffffc02073ea:	f28fe06f          	j	ffffffffc0205b12 <stride_dequeue+0xb06>
ffffffffc02073ee:	01153023          	sd	a7,0(a0)
ffffffffc02073f2:	f20fe06f          	j	ffffffffc0205b12 <stride_dequeue+0xb06>
ffffffffc02073f6:	0109b503          	ld	a0,16(s3)
ffffffffc02073fa:	0089bb03          	ld	s6,8(s3)
ffffffffc02073fe:	85d2                	mv	a1,s4
ffffffffc0207400:	f046                	sd	a7,32(sp)
ffffffffc0207402:	a2bfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207406:	00a9b423          	sd	a0,8(s3)
ffffffffc020740a:	0169b823          	sd	s6,16(s3)
ffffffffc020740e:	7882                	ld	a7,32(sp)
ffffffffc0207410:	010c2b03          	lw	s6,16(s8)
ffffffffc0207414:	e119                	bnez	a0,ffffffffc020741a <stride_dequeue+0x240e>
ffffffffc0207416:	fe1fe06f          	j	ffffffffc02063f6 <stride_dequeue+0x13ea>
ffffffffc020741a:	01353023          	sd	s3,0(a0)
ffffffffc020741e:	fd9fe06f          	j	ffffffffc02063f6 <stride_dequeue+0x13ea>
ffffffffc0207422:	0109b503          	ld	a0,16(s3)
ffffffffc0207426:	0089bb03          	ld	s6,8(s3)
ffffffffc020742a:	85c2                	mv	a1,a6
ffffffffc020742c:	a01fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207430:	00a9b423          	sd	a0,8(s3)
ffffffffc0207434:	0169b823          	sd	s6,16(s3)
ffffffffc0207438:	010c2b03          	lw	s6,16(s8)
ffffffffc020743c:	ae050863          	beqz	a0,ffffffffc020672c <stride_dequeue+0x1720>
ffffffffc0207440:	01353023          	sd	s3,0(a0)
ffffffffc0207444:	ae8ff06f          	j	ffffffffc020672c <stride_dequeue+0x1720>
ffffffffc0207448:	89d2                	mv	s3,s4
ffffffffc020744a:	fadfe06f          	j	ffffffffc02063f6 <stride_dequeue+0x13ea>
ffffffffc020744e:	89ee                	mv	s3,s11
ffffffffc0207450:	84aff06f          	j	ffffffffc020649a <stride_dequeue+0x148e>
ffffffffc0207454:	89c2                	mv	s3,a6
ffffffffc0207456:	992ff06f          	j	ffffffffc02065e8 <stride_dequeue+0x15dc>
ffffffffc020745a:	89c2                	mv	s3,a6
ffffffffc020745c:	a34ff06f          	j	ffffffffc0206690 <stride_dequeue+0x1684>
ffffffffc0207460:	89b2                	mv	s3,a2
ffffffffc0207462:	8e2ff06f          	j	ffffffffc0206544 <stride_dequeue+0x1538>
ffffffffc0207466:	89c2                	mv	s3,a6
ffffffffc0207468:	ac4ff06f          	j	ffffffffc020672c <stride_dequeue+0x1720>
ffffffffc020746c:	01083503          	ld	a0,16(a6)
ffffffffc0207470:	85e6                	mv	a1,s9
ffffffffc0207472:	00883b03          	ld	s6,8(a6)
ffffffffc0207476:	9b7fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020747a:	7802                	ld	a6,32(sp)
ffffffffc020747c:	01683823          	sd	s6,16(a6)
ffffffffc0207480:	00a83423          	sd	a0,8(a6)
ffffffffc0207484:	010c2b03          	lw	s6,16(s8)
ffffffffc0207488:	50050163          	beqz	a0,ffffffffc020798a <stride_dequeue+0x297e>
ffffffffc020748c:	01053023          	sd	a6,0(a0)
ffffffffc0207490:	8cc2                	mv	s9,a6
ffffffffc0207492:	d62ff06f          	j	ffffffffc02069f4 <stride_dequeue+0x19e8>
ffffffffc0207496:	01083503          	ld	a0,16(a6)
ffffffffc020749a:	85d2                	mv	a1,s4
ffffffffc020749c:	00883b03          	ld	s6,8(a6)
ffffffffc02074a0:	98dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02074a4:	6862                	ld	a6,24(sp)
ffffffffc02074a6:	7602                	ld	a2,32(sp)
ffffffffc02074a8:	01683823          	sd	s6,16(a6)
ffffffffc02074ac:	00a83423          	sd	a0,8(a6)
ffffffffc02074b0:	010c2b03          	lw	s6,16(s8)
ffffffffc02074b4:	4c050863          	beqz	a0,ffffffffc0207984 <stride_dequeue+0x2978>
ffffffffc02074b8:	01053023          	sd	a6,0(a0)
ffffffffc02074bc:	8a42                	mv	s4,a6
ffffffffc02074be:	d94ff06f          	j	ffffffffc0206a52 <stride_dequeue+0x1a46>
ffffffffc02074c2:	89f2                	mv	s3,t3
ffffffffc02074c4:	bb5fe06f          	j	ffffffffc0206078 <stride_dequeue+0x106c>
ffffffffc02074c8:	88f2                	mv	a7,t3
ffffffffc02074ca:	e48fe06f          	j	ffffffffc0205b12 <stride_dequeue+0xb06>
ffffffffc02074ce:	89f2                	mv	s3,t3
ffffffffc02074d0:	ce3fe06f          	j	ffffffffc02061b2 <stride_dequeue+0x11a6>
ffffffffc02074d4:	89f2                	mv	s3,t3
ffffffffc02074d6:	c41fe06f          	j	ffffffffc0206116 <stride_dequeue+0x110a>
ffffffffc02074da:	88f2                	mv	a7,t3
ffffffffc02074dc:	fe2fe06f          	j	ffffffffc0205cbe <stride_dequeue+0xcb2>
ffffffffc02074e0:	87ce                	mv	a5,s3
ffffffffc02074e2:	ddffe06f          	j	ffffffffc02062c0 <stride_dequeue+0x12b4>
ffffffffc02074e6:	0108b503          	ld	a0,16(a7)
ffffffffc02074ea:	85ce                	mv	a1,s3
ffffffffc02074ec:	0088bb03          	ld	s6,8(a7)
ffffffffc02074f0:	93dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02074f4:	7882                	ld	a7,32(sp)
ffffffffc02074f6:	0168b823          	sd	s6,16(a7)
ffffffffc02074fa:	00a8b423          	sd	a0,8(a7)
ffffffffc02074fe:	010c2b03          	lw	s6,16(s8)
ffffffffc0207502:	42050a63          	beqz	a0,ffffffffc0207936 <stride_dequeue+0x292a>
ffffffffc0207506:	01153023          	sd	a7,0(a0)
ffffffffc020750a:	89c6                	mv	s3,a7
ffffffffc020750c:	d9cff06f          	j	ffffffffc0206aa8 <stride_dequeue+0x1a9c>
ffffffffc0207510:	8cf2                	mv	s9,t3
ffffffffc0207512:	84efe06f          	j	ffffffffc0205560 <stride_dequeue+0x554>
ffffffffc0207516:	8a72                	mv	s4,t3
ffffffffc0207518:	a62fe06f          	j	ffffffffc020577a <stride_dequeue+0x76e>
ffffffffc020751c:	88f2                	mv	a7,t3
ffffffffc020751e:	ed2fe06f          	j	ffffffffc0205bf0 <stride_dequeue+0xbe4>
ffffffffc0207522:	89f2                	mv	s3,t3
ffffffffc0207524:	d33fe06f          	j	ffffffffc0206256 <stride_dequeue+0x124a>
ffffffffc0207528:	0109b503          	ld	a0,16(s3)
ffffffffc020752c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207530:	85c6                	mv	a1,a7
ffffffffc0207532:	8fbfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207536:	00a9b423          	sd	a0,8(s3)
ffffffffc020753a:	0169b823          	sd	s6,16(s3)
ffffffffc020753e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207542:	e119                	bnez	a0,ffffffffc0207548 <stride_dequeue+0x253c>
ffffffffc0207544:	dfdfe06f          	j	ffffffffc0206340 <stride_dequeue+0x1334>
ffffffffc0207548:	01353023          	sd	s3,0(a0)
ffffffffc020754c:	df5fe06f          	j	ffffffffc0206340 <stride_dequeue+0x1334>
ffffffffc0207550:	01083503          	ld	a0,16(a6)
ffffffffc0207554:	85d2                	mv	a1,s4
ffffffffc0207556:	00883b03          	ld	s6,8(a6)
ffffffffc020755a:	8d3fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020755e:	7802                	ld	a6,32(sp)
ffffffffc0207560:	01683823          	sd	s6,16(a6)
ffffffffc0207564:	00a83423          	sd	a0,8(a6)
ffffffffc0207568:	010c2b03          	lw	s6,16(s8)
ffffffffc020756c:	3a050363          	beqz	a0,ffffffffc0207912 <stride_dequeue+0x2906>
ffffffffc0207570:	01053023          	sd	a6,0(a0)
ffffffffc0207574:	8a42                	mv	s4,a6
ffffffffc0207576:	c28ff06f          	j	ffffffffc020699e <stride_dequeue+0x1992>
ffffffffc020757a:	8672                	mv	a2,t3
ffffffffc020757c:	900fe06f          	j	ffffffffc020567c <stride_dequeue+0x670>
ffffffffc0207580:	0108b503          	ld	a0,16(a7)
ffffffffc0207584:	85ce                	mv	a1,s3
ffffffffc0207586:	0088bb03          	ld	s6,8(a7)
ffffffffc020758a:	8a3fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020758e:	7882                	ld	a7,32(sp)
ffffffffc0207590:	7622                	ld	a2,40(sp)
ffffffffc0207592:	7842                	ld	a6,48(sp)
ffffffffc0207594:	0168b823          	sd	s6,16(a7)
ffffffffc0207598:	00a8b423          	sd	a0,8(a7)
ffffffffc020759c:	010c2b03          	lw	s6,16(s8)
ffffffffc02075a0:	3c050c63          	beqz	a0,ffffffffc0207978 <stride_dequeue+0x296c>
ffffffffc02075a4:	01153023          	sd	a7,0(a0)
ffffffffc02075a8:	89c6                	mv	s3,a7
ffffffffc02075aa:	dc0ff06f          	j	ffffffffc0206b6a <stride_dequeue+0x1b5e>
ffffffffc02075ae:	0109b503          	ld	a0,16(s3)
ffffffffc02075b2:	0089bb03          	ld	s6,8(s3)
ffffffffc02075b6:	85f2                	mv	a1,t3
ffffffffc02075b8:	f41a                	sd	t1,40(sp)
ffffffffc02075ba:	873fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02075be:	00a9b423          	sd	a0,8(s3)
ffffffffc02075c2:	0169b823          	sd	s6,16(s3)
ffffffffc02075c6:	7322                	ld	t1,40(sp)
ffffffffc02075c8:	010c2b03          	lw	s6,16(s8)
ffffffffc02075cc:	e119                	bnez	a0,ffffffffc02075d2 <stride_dequeue+0x25c6>
ffffffffc02075ce:	9fdfe06f          	j	ffffffffc0205fca <stride_dequeue+0xfbe>
ffffffffc02075d2:	01353023          	sd	s3,0(a0)
ffffffffc02075d6:	9f5fe06f          	j	ffffffffc0205fca <stride_dequeue+0xfbe>
ffffffffc02075da:	01033503          	ld	a0,16(t1)
ffffffffc02075de:	85e6                	mv	a1,s9
ffffffffc02075e0:	00833b03          	ld	s6,8(t1)
ffffffffc02075e4:	849fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02075e8:	7322                	ld	t1,40(sp)
ffffffffc02075ea:	78c2                	ld	a7,48(sp)
ffffffffc02075ec:	01633823          	sd	s6,16(t1)
ffffffffc02075f0:	00a33423          	sd	a0,8(t1)
ffffffffc02075f4:	010c2b03          	lw	s6,16(s8)
ffffffffc02075f8:	34050e63          	beqz	a0,ffffffffc0207954 <stride_dequeue+0x2948>
ffffffffc02075fc:	00653023          	sd	t1,0(a0)
ffffffffc0207600:	8c9a                	mv	s9,t1
ffffffffc0207602:	eeaff06f          	j	ffffffffc0206cec <stride_dequeue+0x1ce0>
ffffffffc0207606:	01033503          	ld	a0,16(t1)
ffffffffc020760a:	85c2                	mv	a1,a6
ffffffffc020760c:	00833b03          	ld	s6,8(t1)
ffffffffc0207610:	81dfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207614:	7322                	ld	t1,40(sp)
ffffffffc0207616:	01633823          	sd	s6,16(t1)
ffffffffc020761a:	00a33423          	sd	a0,8(t1)
ffffffffc020761e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207622:	32050c63          	beqz	a0,ffffffffc020795a <stride_dequeue+0x294e>
ffffffffc0207626:	00653023          	sd	t1,0(a0)
ffffffffc020762a:	881a                	mv	a6,t1
ffffffffc020762c:	f24ff06f          	j	ffffffffc0206d50 <stride_dequeue+0x1d44>
ffffffffc0207630:	0108b503          	ld	a0,16(a7)
ffffffffc0207634:	85ce                	mv	a1,s3
ffffffffc0207636:	0088bb03          	ld	s6,8(a7)
ffffffffc020763a:	ff2fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020763e:	78a2                	ld	a7,40(sp)
ffffffffc0207640:	7842                	ld	a6,48(sp)
ffffffffc0207642:	0168b823          	sd	s6,16(a7)
ffffffffc0207646:	00a8b423          	sd	a0,8(a7)
ffffffffc020764a:	010c2b03          	lw	s6,16(s8)
ffffffffc020764e:	30050963          	beqz	a0,ffffffffc0207960 <stride_dequeue+0x2954>
ffffffffc0207652:	01153023          	sd	a7,0(a0)
ffffffffc0207656:	89c6                	mv	s3,a7
ffffffffc0207658:	caeff06f          	j	ffffffffc0206b06 <stride_dequeue+0x1afa>
ffffffffc020765c:	01083503          	ld	a0,16(a6)
ffffffffc0207660:	85ce                	mv	a1,s3
ffffffffc0207662:	00883b03          	ld	s6,8(a6)
ffffffffc0207666:	fc6fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020766a:	7822                	ld	a6,40(sp)
ffffffffc020766c:	78c2                	ld	a7,48(sp)
ffffffffc020766e:	01683823          	sd	s6,16(a6)
ffffffffc0207672:	00a83423          	sd	a0,8(a6)
ffffffffc0207676:	010c2b03          	lw	s6,16(s8)
ffffffffc020767a:	30050b63          	beqz	a0,ffffffffc0207990 <stride_dequeue+0x2984>
ffffffffc020767e:	01053023          	sd	a6,0(a0)
ffffffffc0207682:	89c2                	mv	s3,a6
ffffffffc0207684:	da6ff06f          	j	ffffffffc0206c2a <stride_dequeue+0x1c1e>
ffffffffc0207688:	01083503          	ld	a0,16(a6)
ffffffffc020768c:	85ce                	mv	a1,s3
ffffffffc020768e:	00883b03          	ld	s6,8(a6)
ffffffffc0207692:	f9afd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207696:	7802                	ld	a6,32(sp)
ffffffffc0207698:	7622                	ld	a2,40(sp)
ffffffffc020769a:	78c2                	ld	a7,48(sp)
ffffffffc020769c:	01683823          	sd	s6,16(a6)
ffffffffc02076a0:	00a83423          	sd	a0,8(a6)
ffffffffc02076a4:	010c2b03          	lw	s6,16(s8)
ffffffffc02076a8:	2a050063          	beqz	a0,ffffffffc0207948 <stride_dequeue+0x293c>
ffffffffc02076ac:	01053023          	sd	a6,0(a0)
ffffffffc02076b0:	89c2                	mv	s3,a6
ffffffffc02076b2:	ddcff06f          	j	ffffffffc0206c8e <stride_dequeue+0x1c82>
ffffffffc02076b6:	0109b503          	ld	a0,16(s3)
ffffffffc02076ba:	0089bb03          	ld	s6,8(s3)
ffffffffc02076be:	85f2                	mv	a1,t3
ffffffffc02076c0:	f41a                	sd	t1,40(sp)
ffffffffc02076c2:	f6afd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02076c6:	00a9b423          	sd	a0,8(s3)
ffffffffc02076ca:	0169b823          	sd	s6,16(s3)
ffffffffc02076ce:	7322                	ld	t1,40(sp)
ffffffffc02076d0:	010c2b03          	lw	s6,16(s8)
ffffffffc02076d4:	e119                	bnez	a0,ffffffffc02076da <stride_dequeue+0x26ce>
ffffffffc02076d6:	f4afe06f          	j	ffffffffc0205e20 <stride_dequeue+0xe14>
ffffffffc02076da:	01353023          	sd	s3,0(a0)
ffffffffc02076de:	f42fe06f          	j	ffffffffc0205e20 <stride_dequeue+0xe14>
ffffffffc02076e2:	0109b503          	ld	a0,16(s3)
ffffffffc02076e6:	0089bb03          	ld	s6,8(s3)
ffffffffc02076ea:	85f2                	mv	a1,t3
ffffffffc02076ec:	f446                	sd	a7,40(sp)
ffffffffc02076ee:	f3efd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02076f2:	00a9b423          	sd	a0,8(s3)
ffffffffc02076f6:	0169b823          	sd	s6,16(s3)
ffffffffc02076fa:	78a2                	ld	a7,40(sp)
ffffffffc02076fc:	010c2b03          	lw	s6,16(s8)
ffffffffc0207700:	e119                	bnez	a0,ffffffffc0207706 <stride_dequeue+0x26fa>
ffffffffc0207702:	ce5fe06f          	j	ffffffffc02063e6 <stride_dequeue+0x13da>
ffffffffc0207706:	01353023          	sd	s3,0(a0)
ffffffffc020770a:	cddfe06f          	j	ffffffffc02063e6 <stride_dequeue+0x13da>
ffffffffc020770e:	0109b503          	ld	a0,16(s3)
ffffffffc0207712:	0089bb03          	ld	s6,8(s3)
ffffffffc0207716:	85f2                	mv	a1,t3
ffffffffc0207718:	f446                	sd	a7,40(sp)
ffffffffc020771a:	f032                	sd	a2,32(sp)
ffffffffc020771c:	f10fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207720:	00a9b423          	sd	a0,8(s3)
ffffffffc0207724:	0169b823          	sd	s6,16(s3)
ffffffffc0207728:	7602                	ld	a2,32(sp)
ffffffffc020772a:	78a2                	ld	a7,40(sp)
ffffffffc020772c:	010c2b03          	lw	s6,16(s8)
ffffffffc0207730:	e119                	bnez	a0,ffffffffc0207736 <stride_dequeue+0x272a>
ffffffffc0207732:	e05fe06f          	j	ffffffffc0206536 <stride_dequeue+0x152a>
ffffffffc0207736:	01353023          	sd	s3,0(a0)
ffffffffc020773a:	dfdfe06f          	j	ffffffffc0206536 <stride_dequeue+0x152a>
ffffffffc020773e:	010a3503          	ld	a0,16(s4)
ffffffffc0207742:	008a3b03          	ld	s6,8(s4)
ffffffffc0207746:	85f2                	mv	a1,t3
ffffffffc0207748:	f41a                	sd	t1,40(sp)
ffffffffc020774a:	ee2fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020774e:	00aa3423          	sd	a0,8(s4)
ffffffffc0207752:	016a3823          	sd	s6,16(s4)
ffffffffc0207756:	7322                	ld	t1,40(sp)
ffffffffc0207758:	010c2b03          	lw	s6,16(s8)
ffffffffc020775c:	e119                	bnez	a0,ffffffffc0207762 <stride_dequeue+0x2756>
ffffffffc020775e:	ad6fe06f          	j	ffffffffc0205a34 <stride_dequeue+0xa28>
ffffffffc0207762:	01453023          	sd	s4,0(a0)
ffffffffc0207766:	acefe06f          	j	ffffffffc0205a34 <stride_dequeue+0xa28>
ffffffffc020776a:	0109b503          	ld	a0,16(s3)
ffffffffc020776e:	0089bb03          	ld	s6,8(s3)
ffffffffc0207772:	85f2                	mv	a1,t3
ffffffffc0207774:	f446                	sd	a7,40(sp)
ffffffffc0207776:	eb6fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020777a:	00a9b423          	sd	a0,8(s3)
ffffffffc020777e:	0169b823          	sd	s6,16(s3)
ffffffffc0207782:	78a2                	ld	a7,40(sp)
ffffffffc0207784:	010c2b03          	lw	s6,16(s8)
ffffffffc0207788:	e119                	bnez	a0,ffffffffc020778e <stride_dequeue+0x2782>
ffffffffc020778a:	d01fe06f          	j	ffffffffc020648a <stride_dequeue+0x147e>
ffffffffc020778e:	01353023          	sd	s3,0(a0)
ffffffffc0207792:	cf9fe06f          	j	ffffffffc020648a <stride_dequeue+0x147e>
ffffffffc0207796:	01033503          	ld	a0,16(t1)
ffffffffc020779a:	85c2                	mv	a1,a6
ffffffffc020779c:	00833b03          	ld	s6,8(t1)
ffffffffc02077a0:	e8cfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02077a4:	7322                	ld	t1,40(sp)
ffffffffc02077a6:	01633823          	sd	s6,16(t1)
ffffffffc02077aa:	00a33423          	sd	a0,8(t1)
ffffffffc02077ae:	010c2b03          	lw	s6,16(s8)
ffffffffc02077b2:	1e050b63          	beqz	a0,ffffffffc02079a8 <stride_dequeue+0x299c>
ffffffffc02077b6:	00653023          	sd	t1,0(a0)
ffffffffc02077ba:	881a                	mv	a6,t1
ffffffffc02077bc:	e50ff06f          	j	ffffffffc0206e0c <stride_dequeue+0x1e00>
ffffffffc02077c0:	0109b503          	ld	a0,16(s3)
ffffffffc02077c4:	0089bb03          	ld	s6,8(s3)
ffffffffc02077c8:	85f2                	mv	a1,t3
ffffffffc02077ca:	f442                	sd	a6,40(sp)
ffffffffc02077cc:	f032                	sd	a2,32(sp)
ffffffffc02077ce:	e5efd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02077d2:	00a9b423          	sd	a0,8(s3)
ffffffffc02077d6:	0169b823          	sd	s6,16(s3)
ffffffffc02077da:	7602                	ld	a2,32(sp)
ffffffffc02077dc:	7822                	ld	a6,40(sp)
ffffffffc02077de:	010c2b03          	lw	s6,16(s8)
ffffffffc02077e2:	e119                	bnez	a0,ffffffffc02077e8 <stride_dequeue+0x27dc>
ffffffffc02077e4:	e9dfe06f          	j	ffffffffc0206680 <stride_dequeue+0x1674>
ffffffffc02077e8:	01353023          	sd	s3,0(a0)
ffffffffc02077ec:	e95fe06f          	j	ffffffffc0206680 <stride_dequeue+0x1674>
ffffffffc02077f0:	0108b503          	ld	a0,16(a7)
ffffffffc02077f4:	85ce                	mv	a1,s3
ffffffffc02077f6:	0088bb03          	ld	s6,8(a7)
ffffffffc02077fa:	e32fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02077fe:	78a2                	ld	a7,40(sp)
ffffffffc0207800:	7842                	ld	a6,48(sp)
ffffffffc0207802:	0168b823          	sd	s6,16(a7)
ffffffffc0207806:	00a8b423          	sd	a0,8(a7)
ffffffffc020780a:	010c2b03          	lw	s6,16(s8)
ffffffffc020780e:	0e050f63          	beqz	a0,ffffffffc020790c <stride_dequeue+0x2900>
ffffffffc0207812:	01153023          	sd	a7,0(a0)
ffffffffc0207816:	89c6                	mv	s3,a7
ffffffffc0207818:	d96ff06f          	j	ffffffffc0206dae <stride_dequeue+0x1da2>
ffffffffc020781c:	01083503          	ld	a0,16(a6)
ffffffffc0207820:	85ce                	mv	a1,s3
ffffffffc0207822:	00883b03          	ld	s6,8(a6)
ffffffffc0207826:	e06fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc020782a:	7822                	ld	a6,40(sp)
ffffffffc020782c:	78c2                	ld	a7,48(sp)
ffffffffc020782e:	01683823          	sd	s6,16(a6)
ffffffffc0207832:	00a83423          	sd	a0,8(a6)
ffffffffc0207836:	010c2b03          	lw	s6,16(s8)
ffffffffc020783a:	0e050b63          	beqz	a0,ffffffffc0207930 <stride_dequeue+0x2924>
ffffffffc020783e:	01053023          	sd	a6,0(a0)
ffffffffc0207842:	89c2                	mv	s3,a6
ffffffffc0207844:	b88ff06f          	j	ffffffffc0206bcc <stride_dequeue+0x1bc0>
ffffffffc0207848:	0109b503          	ld	a0,16(s3)
ffffffffc020784c:	0089bb03          	ld	s6,8(s3)
ffffffffc0207850:	85f2                	mv	a1,t3
ffffffffc0207852:	f442                	sd	a6,40(sp)
ffffffffc0207854:	dd8fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207858:	00a9b423          	sd	a0,8(s3)
ffffffffc020785c:	0169b823          	sd	s6,16(s3)
ffffffffc0207860:	7822                	ld	a6,40(sp)
ffffffffc0207862:	010c2b03          	lw	s6,16(s8)
ffffffffc0207866:	e119                	bnez	a0,ffffffffc020786c <stride_dequeue+0x2860>
ffffffffc0207868:	d71fe06f          	j	ffffffffc02065d8 <stride_dequeue+0x15cc>
ffffffffc020786c:	01353023          	sd	s3,0(a0)
ffffffffc0207870:	d69fe06f          	j	ffffffffc02065d8 <stride_dequeue+0x15cc>
ffffffffc0207874:	0109b503          	ld	a0,16(s3)
ffffffffc0207878:	0089bb03          	ld	s6,8(s3)
ffffffffc020787c:	85f2                	mv	a1,t3
ffffffffc020787e:	f442                	sd	a6,40(sp)
ffffffffc0207880:	dacfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc0207884:	00a9b423          	sd	a0,8(s3)
ffffffffc0207888:	0169b823          	sd	s6,16(s3)
ffffffffc020788c:	7822                	ld	a6,40(sp)
ffffffffc020788e:	010c2b03          	lw	s6,16(s8)
ffffffffc0207892:	e119                	bnez	a0,ffffffffc0207898 <stride_dequeue+0x288c>
ffffffffc0207894:	e89fe06f          	j	ffffffffc020671c <stride_dequeue+0x1710>
ffffffffc0207898:	01353023          	sd	s3,0(a0)
ffffffffc020789c:	e81fe06f          	j	ffffffffc020671c <stride_dequeue+0x1710>
ffffffffc02078a0:	89c6                	mv	s3,a7
ffffffffc02078a2:	a9ffe06f          	j	ffffffffc0206340 <stride_dequeue+0x1334>
ffffffffc02078a6:	0109b503          	ld	a0,16(s3)
ffffffffc02078aa:	0089bb03          	ld	s6,8(s3)
ffffffffc02078ae:	85f2                	mv	a1,t3
ffffffffc02078b0:	f41a                	sd	t1,40(sp)
ffffffffc02078b2:	f032                	sd	a2,32(sp)
ffffffffc02078b4:	d78fd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02078b8:	00a9b423          	sd	a0,8(s3)
ffffffffc02078bc:	0169b823          	sd	s6,16(s3)
ffffffffc02078c0:	7602                	ld	a2,32(sp)
ffffffffc02078c2:	7322                	ld	t1,40(sp)
ffffffffc02078c4:	010c2b03          	lw	s6,16(s8)
ffffffffc02078c8:	e119                	bnez	a0,ffffffffc02078ce <stride_dequeue+0x28c2>
ffffffffc02078ca:	e32fe06f          	j	ffffffffc0205efc <stride_dequeue+0xef0>
ffffffffc02078ce:	01353023          	sd	s3,0(a0)
ffffffffc02078d2:	e2afe06f          	j	ffffffffc0205efc <stride_dequeue+0xef0>
ffffffffc02078d6:	01033503          	ld	a0,16(t1)
ffffffffc02078da:	85c2                	mv	a1,a6
ffffffffc02078dc:	00833b03          	ld	s6,8(t1)
ffffffffc02078e0:	d4cfd0ef          	jal	ra,ffffffffc0204e2c <skew_heap_merge.constprop.0>
ffffffffc02078e4:	7302                	ld	t1,32(sp)
ffffffffc02078e6:	7622                	ld	a2,40(sp)
ffffffffc02078e8:	01633823          	sd	s6,16(t1)
ffffffffc02078ec:	00a33423          	sd	a0,8(t1)
ffffffffc02078f0:	010c2b03          	lw	s6,16(s8)
ffffffffc02078f4:	c115                	beqz	a0,ffffffffc0207918 <stride_dequeue+0x290c>
ffffffffc02078f6:	00653023          	sd	t1,0(a0)
ffffffffc02078fa:	881a                	mv	a6,t1
ffffffffc02078fc:	d76ff06f          	j	ffffffffc0206e72 <stride_dequeue+0x1e66>
ffffffffc0207900:	89f2                	mv	s3,t3
ffffffffc0207902:	e1bfe06f          	j	ffffffffc020671c <stride_dequeue+0x1710>
ffffffffc0207906:	834e                	mv	t1,s3
ffffffffc0207908:	ef1fe06f          	j	ffffffffc02067f8 <stride_dequeue+0x17ec>
ffffffffc020790c:	89c6                	mv	s3,a7
ffffffffc020790e:	ca0ff06f          	j	ffffffffc0206dae <stride_dequeue+0x1da2>
ffffffffc0207912:	8a42                	mv	s4,a6
ffffffffc0207914:	88aff06f          	j	ffffffffc020699e <stride_dequeue+0x1992>
ffffffffc0207918:	881a                	mv	a6,t1
ffffffffc020791a:	d58ff06f          	j	ffffffffc0206e72 <stride_dequeue+0x1e66>
ffffffffc020791e:	89f2                	mv	s3,t3
ffffffffc0207920:	ddcfe06f          	j	ffffffffc0205efc <stride_dequeue+0xef0>
ffffffffc0207924:	834e                	mv	t1,s3
ffffffffc0207926:	e69fe06f          	j	ffffffffc020678e <stride_dequeue+0x1782>
ffffffffc020792a:	89f2                	mv	s3,t3
ffffffffc020792c:	cadfe06f          	j	ffffffffc02065d8 <stride_dequeue+0x15cc>
ffffffffc0207930:	89c2                	mv	s3,a6
ffffffffc0207932:	a9aff06f          	j	ffffffffc0206bcc <stride_dequeue+0x1bc0>
ffffffffc0207936:	89c6                	mv	s3,a7
ffffffffc0207938:	970ff06f          	j	ffffffffc0206aa8 <stride_dequeue+0x1a9c>
ffffffffc020793c:	834e                	mv	t1,s3
ffffffffc020793e:	fdffe06f          	j	ffffffffc020691c <stride_dequeue+0x1910>
ffffffffc0207942:	89f2                	mv	s3,t3
ffffffffc0207944:	cdcfe06f          	j	ffffffffc0205e20 <stride_dequeue+0xe14>
ffffffffc0207948:	89c2                	mv	s3,a6
ffffffffc020794a:	b44ff06f          	j	ffffffffc0206c8e <stride_dequeue+0x1c82>
ffffffffc020794e:	884e                	mv	a6,s3
ffffffffc0207950:	f09fe06f          	j	ffffffffc0206858 <stride_dequeue+0x184c>
ffffffffc0207954:	8c9a                	mv	s9,t1
ffffffffc0207956:	b96ff06f          	j	ffffffffc0206cec <stride_dequeue+0x1ce0>
ffffffffc020795a:	881a                	mv	a6,t1
ffffffffc020795c:	bf4ff06f          	j	ffffffffc0206d50 <stride_dequeue+0x1d44>
ffffffffc0207960:	89c6                	mv	s3,a7
ffffffffc0207962:	9a4ff06f          	j	ffffffffc0206b06 <stride_dequeue+0x1afa>
ffffffffc0207966:	89f2                	mv	s3,t3
ffffffffc0207968:	a7ffe06f          	j	ffffffffc02063e6 <stride_dequeue+0x13da>
ffffffffc020796c:	89f2                	mv	s3,t3
ffffffffc020796e:	bc9fe06f          	j	ffffffffc0206536 <stride_dequeue+0x152a>
ffffffffc0207972:	89f2                	mv	s3,t3
ffffffffc0207974:	e56fe06f          	j	ffffffffc0205fca <stride_dequeue+0xfbe>
ffffffffc0207978:	89c6                	mv	s3,a7
ffffffffc020797a:	9f0ff06f          	j	ffffffffc0206b6a <stride_dequeue+0x1b5e>
ffffffffc020797e:	834e                	mv	t1,s3
ffffffffc0207980:	f3dfe06f          	j	ffffffffc02068bc <stride_dequeue+0x18b0>
ffffffffc0207984:	8a42                	mv	s4,a6
ffffffffc0207986:	8ccff06f          	j	ffffffffc0206a52 <stride_dequeue+0x1a46>
ffffffffc020798a:	8cc2                	mv	s9,a6
ffffffffc020798c:	868ff06f          	j	ffffffffc02069f4 <stride_dequeue+0x19e8>
ffffffffc0207990:	89c2                	mv	s3,a6
ffffffffc0207992:	a98ff06f          	j	ffffffffc0206c2a <stride_dequeue+0x1c1e>
ffffffffc0207996:	8a72                	mv	s4,t3
ffffffffc0207998:	89cfe06f          	j	ffffffffc0205a34 <stride_dequeue+0xa28>
ffffffffc020799c:	89f2                	mv	s3,t3
ffffffffc020799e:	aedfe06f          	j	ffffffffc020648a <stride_dequeue+0x147e>
ffffffffc02079a2:	89f2                	mv	s3,t3
ffffffffc02079a4:	cddfe06f          	j	ffffffffc0206680 <stride_dequeue+0x1674>
ffffffffc02079a8:	881a                	mv	a6,t1
ffffffffc02079aa:	c62ff06f          	j	ffffffffc0206e0c <stride_dequeue+0x1e00>

ffffffffc02079ae <sys_getpid>:
ffffffffc02079ae:	00012797          	auipc	a5,0x12
ffffffffc02079b2:	b4a7b783          	ld	a5,-1206(a5) # ffffffffc02194f8 <current>
ffffffffc02079b6:	43c8                	lw	a0,4(a5)
ffffffffc02079b8:	8082                	ret

ffffffffc02079ba <sys_pgdir>:
ffffffffc02079ba:	4501                	li	a0,0
ffffffffc02079bc:	8082                	ret

ffffffffc02079be <sys_gettime>:
ffffffffc02079be:	00012797          	auipc	a5,0x12
ffffffffc02079c2:	b6a7b783          	ld	a5,-1174(a5) # ffffffffc0219528 <ticks>
ffffffffc02079c6:	0027951b          	slliw	a0,a5,0x2
ffffffffc02079ca:	9d3d                	addw	a0,a0,a5
ffffffffc02079cc:	0015151b          	slliw	a0,a0,0x1
ffffffffc02079d0:	8082                	ret

ffffffffc02079d2 <sys_lab6_set_priority>:
ffffffffc02079d2:	4108                	lw	a0,0(a0)
ffffffffc02079d4:	1141                	addi	sp,sp,-16
ffffffffc02079d6:	e406                	sd	ra,8(sp)
ffffffffc02079d8:	ee5fc0ef          	jal	ra,ffffffffc02048bc <lab6_set_priority>
ffffffffc02079dc:	60a2                	ld	ra,8(sp)
ffffffffc02079de:	4501                	li	a0,0
ffffffffc02079e0:	0141                	addi	sp,sp,16
ffffffffc02079e2:	8082                	ret

ffffffffc02079e4 <sys_putc>:
ffffffffc02079e4:	4108                	lw	a0,0(a0)
ffffffffc02079e6:	1141                	addi	sp,sp,-16
ffffffffc02079e8:	e406                	sd	ra,8(sp)
ffffffffc02079ea:	f18f80ef          	jal	ra,ffffffffc0200102 <cputchar>
ffffffffc02079ee:	60a2                	ld	ra,8(sp)
ffffffffc02079f0:	4501                	li	a0,0
ffffffffc02079f2:	0141                	addi	sp,sp,16
ffffffffc02079f4:	8082                	ret

ffffffffc02079f6 <sys_kill>:
ffffffffc02079f6:	4108                	lw	a0,0(a0)
ffffffffc02079f8:	d2dfc06f          	j	ffffffffc0204724 <do_kill>

ffffffffc02079fc <sys_sleep>:
ffffffffc02079fc:	4108                	lw	a0,0(a0)
ffffffffc02079fe:	ef9fc06f          	j	ffffffffc02048f6 <do_sleep>

ffffffffc0207a02 <sys_yield>:
ffffffffc0207a02:	cd5fc06f          	j	ffffffffc02046d6 <do_yield>

ffffffffc0207a06 <sys_exec>:
ffffffffc0207a06:	6d14                	ld	a3,24(a0)
ffffffffc0207a08:	6910                	ld	a2,16(a0)
ffffffffc0207a0a:	650c                	ld	a1,8(a0)
ffffffffc0207a0c:	6108                	ld	a0,0(a0)
ffffffffc0207a0e:	f3efc06f          	j	ffffffffc020414c <do_execve>

ffffffffc0207a12 <sys_wait>:
ffffffffc0207a12:	650c                	ld	a1,8(a0)
ffffffffc0207a14:	4108                	lw	a0,0(a0)
ffffffffc0207a16:	cd1fc06f          	j	ffffffffc02046e6 <do_wait>

ffffffffc0207a1a <sys_fork>:
ffffffffc0207a1a:	00012797          	auipc	a5,0x12
ffffffffc0207a1e:	ade7b783          	ld	a5,-1314(a5) # ffffffffc02194f8 <current>
ffffffffc0207a22:	73d0                	ld	a2,160(a5)
ffffffffc0207a24:	4501                	li	a0,0
ffffffffc0207a26:	6a0c                	ld	a1,16(a2)
ffffffffc0207a28:	ebbfb06f          	j	ffffffffc02038e2 <do_fork>

ffffffffc0207a2c <sys_exit>:
ffffffffc0207a2c:	4108                	lw	a0,0(a0)
ffffffffc0207a2e:	ad6fc06f          	j	ffffffffc0203d04 <do_exit>

ffffffffc0207a32 <syscall>:
ffffffffc0207a32:	715d                	addi	sp,sp,-80
ffffffffc0207a34:	fc26                	sd	s1,56(sp)
ffffffffc0207a36:	00012497          	auipc	s1,0x12
ffffffffc0207a3a:	ac248493          	addi	s1,s1,-1342 # ffffffffc02194f8 <current>
ffffffffc0207a3e:	6098                	ld	a4,0(s1)
ffffffffc0207a40:	e0a2                	sd	s0,64(sp)
ffffffffc0207a42:	f84a                	sd	s2,48(sp)
ffffffffc0207a44:	7340                	ld	s0,160(a4)
ffffffffc0207a46:	e486                	sd	ra,72(sp)
ffffffffc0207a48:	0ff00793          	li	a5,255
ffffffffc0207a4c:	05042903          	lw	s2,80(s0)
ffffffffc0207a50:	0327ee63          	bltu	a5,s2,ffffffffc0207a8c <syscall+0x5a>
ffffffffc0207a54:	00391713          	slli	a4,s2,0x3
ffffffffc0207a58:	00002797          	auipc	a5,0x2
ffffffffc0207a5c:	0c878793          	addi	a5,a5,200 # ffffffffc0209b20 <syscalls>
ffffffffc0207a60:	97ba                	add	a5,a5,a4
ffffffffc0207a62:	639c                	ld	a5,0(a5)
ffffffffc0207a64:	c785                	beqz	a5,ffffffffc0207a8c <syscall+0x5a>
ffffffffc0207a66:	6c28                	ld	a0,88(s0)
ffffffffc0207a68:	702c                	ld	a1,96(s0)
ffffffffc0207a6a:	7430                	ld	a2,104(s0)
ffffffffc0207a6c:	7834                	ld	a3,112(s0)
ffffffffc0207a6e:	7c38                	ld	a4,120(s0)
ffffffffc0207a70:	e42a                	sd	a0,8(sp)
ffffffffc0207a72:	e82e                	sd	a1,16(sp)
ffffffffc0207a74:	ec32                	sd	a2,24(sp)
ffffffffc0207a76:	f036                	sd	a3,32(sp)
ffffffffc0207a78:	f43a                	sd	a4,40(sp)
ffffffffc0207a7a:	0028                	addi	a0,sp,8
ffffffffc0207a7c:	9782                	jalr	a5
ffffffffc0207a7e:	60a6                	ld	ra,72(sp)
ffffffffc0207a80:	e828                	sd	a0,80(s0)
ffffffffc0207a82:	6406                	ld	s0,64(sp)
ffffffffc0207a84:	74e2                	ld	s1,56(sp)
ffffffffc0207a86:	7942                	ld	s2,48(sp)
ffffffffc0207a88:	6161                	addi	sp,sp,80
ffffffffc0207a8a:	8082                	ret
ffffffffc0207a8c:	8522                	mv	a0,s0
ffffffffc0207a8e:	d99f80ef          	jal	ra,ffffffffc0200826 <print_trapframe>
ffffffffc0207a92:	609c                	ld	a5,0(s1)
ffffffffc0207a94:	86ca                	mv	a3,s2
ffffffffc0207a96:	00002617          	auipc	a2,0x2
ffffffffc0207a9a:	04260613          	addi	a2,a2,66 # ffffffffc0209ad8 <default_pmm_manager+0x7b0>
ffffffffc0207a9e:	43d8                	lw	a4,4(a5)
ffffffffc0207aa0:	07300593          	li	a1,115
ffffffffc0207aa4:	0b478793          	addi	a5,a5,180
ffffffffc0207aa8:	00002517          	auipc	a0,0x2
ffffffffc0207aac:	06050513          	addi	a0,a0,96 # ffffffffc0209b08 <default_pmm_manager+0x7e0>
ffffffffc0207ab0:	f58f80ef          	jal	ra,ffffffffc0200208 <__panic>

ffffffffc0207ab4 <strnlen>:
ffffffffc0207ab4:	872a                	mv	a4,a0
ffffffffc0207ab6:	4501                	li	a0,0
ffffffffc0207ab8:	e589                	bnez	a1,ffffffffc0207ac2 <strnlen+0xe>
ffffffffc0207aba:	a811                	j	ffffffffc0207ace <strnlen+0x1a>
ffffffffc0207abc:	0505                	addi	a0,a0,1
ffffffffc0207abe:	00a58763          	beq	a1,a0,ffffffffc0207acc <strnlen+0x18>
ffffffffc0207ac2:	00a707b3          	add	a5,a4,a0
ffffffffc0207ac6:	0007c783          	lbu	a5,0(a5)
ffffffffc0207aca:	fbed                	bnez	a5,ffffffffc0207abc <strnlen+0x8>
ffffffffc0207acc:	8082                	ret
ffffffffc0207ace:	8082                	ret

ffffffffc0207ad0 <strcmp>:
ffffffffc0207ad0:	00054783          	lbu	a5,0(a0)
ffffffffc0207ad4:	0005c703          	lbu	a4,0(a1)
ffffffffc0207ad8:	cb89                	beqz	a5,ffffffffc0207aea <strcmp+0x1a>
ffffffffc0207ada:	0505                	addi	a0,a0,1
ffffffffc0207adc:	0585                	addi	a1,a1,1
ffffffffc0207ade:	fee789e3          	beq	a5,a4,ffffffffc0207ad0 <strcmp>
ffffffffc0207ae2:	0007851b          	sext.w	a0,a5
ffffffffc0207ae6:	9d19                	subw	a0,a0,a4
ffffffffc0207ae8:	8082                	ret
ffffffffc0207aea:	4501                	li	a0,0
ffffffffc0207aec:	bfed                	j	ffffffffc0207ae6 <strcmp+0x16>

ffffffffc0207aee <strchr>:
ffffffffc0207aee:	00054783          	lbu	a5,0(a0)
ffffffffc0207af2:	c799                	beqz	a5,ffffffffc0207b00 <strchr+0x12>
ffffffffc0207af4:	00f58763          	beq	a1,a5,ffffffffc0207b02 <strchr+0x14>
ffffffffc0207af8:	00154783          	lbu	a5,1(a0)
ffffffffc0207afc:	0505                	addi	a0,a0,1
ffffffffc0207afe:	fbfd                	bnez	a5,ffffffffc0207af4 <strchr+0x6>
ffffffffc0207b00:	4501                	li	a0,0
ffffffffc0207b02:	8082                	ret

ffffffffc0207b04 <memset>:
ffffffffc0207b04:	ca01                	beqz	a2,ffffffffc0207b14 <memset+0x10>
ffffffffc0207b06:	962a                	add	a2,a2,a0
ffffffffc0207b08:	87aa                	mv	a5,a0
ffffffffc0207b0a:	0785                	addi	a5,a5,1
ffffffffc0207b0c:	feb78fa3          	sb	a1,-1(a5)
ffffffffc0207b10:	fec79de3          	bne	a5,a2,ffffffffc0207b0a <memset+0x6>
ffffffffc0207b14:	8082                	ret

ffffffffc0207b16 <memcpy>:
ffffffffc0207b16:	ca19                	beqz	a2,ffffffffc0207b2c <memcpy+0x16>
ffffffffc0207b18:	962e                	add	a2,a2,a1
ffffffffc0207b1a:	87aa                	mv	a5,a0
ffffffffc0207b1c:	0005c703          	lbu	a4,0(a1)
ffffffffc0207b20:	0585                	addi	a1,a1,1
ffffffffc0207b22:	0785                	addi	a5,a5,1
ffffffffc0207b24:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0207b28:	fec59ae3          	bne	a1,a2,ffffffffc0207b1c <memcpy+0x6>
ffffffffc0207b2c:	8082                	ret

ffffffffc0207b2e <printnum>:
ffffffffc0207b2e:	02069813          	slli	a6,a3,0x20
ffffffffc0207b32:	7179                	addi	sp,sp,-48
ffffffffc0207b34:	02085813          	srli	a6,a6,0x20
ffffffffc0207b38:	e052                	sd	s4,0(sp)
ffffffffc0207b3a:	03067a33          	remu	s4,a2,a6
ffffffffc0207b3e:	f022                	sd	s0,32(sp)
ffffffffc0207b40:	ec26                	sd	s1,24(sp)
ffffffffc0207b42:	e84a                	sd	s2,16(sp)
ffffffffc0207b44:	f406                	sd	ra,40(sp)
ffffffffc0207b46:	e44e                	sd	s3,8(sp)
ffffffffc0207b48:	84aa                	mv	s1,a0
ffffffffc0207b4a:	892e                	mv	s2,a1
ffffffffc0207b4c:	fff7041b          	addiw	s0,a4,-1
ffffffffc0207b50:	2a01                	sext.w	s4,s4
ffffffffc0207b52:	03067e63          	bgeu	a2,a6,ffffffffc0207b8e <printnum+0x60>
ffffffffc0207b56:	89be                	mv	s3,a5
ffffffffc0207b58:	00805763          	blez	s0,ffffffffc0207b66 <printnum+0x38>
ffffffffc0207b5c:	347d                	addiw	s0,s0,-1
ffffffffc0207b5e:	85ca                	mv	a1,s2
ffffffffc0207b60:	854e                	mv	a0,s3
ffffffffc0207b62:	9482                	jalr	s1
ffffffffc0207b64:	fc65                	bnez	s0,ffffffffc0207b5c <printnum+0x2e>
ffffffffc0207b66:	1a02                	slli	s4,s4,0x20
ffffffffc0207b68:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207b6c:	00002797          	auipc	a5,0x2
ffffffffc0207b70:	7b478793          	addi	a5,a5,1972 # ffffffffc020a320 <syscalls+0x800>
ffffffffc0207b74:	7402                	ld	s0,32(sp)
ffffffffc0207b76:	9a3e                	add	s4,s4,a5
ffffffffc0207b78:	000a4503          	lbu	a0,0(s4)
ffffffffc0207b7c:	70a2                	ld	ra,40(sp)
ffffffffc0207b7e:	69a2                	ld	s3,8(sp)
ffffffffc0207b80:	6a02                	ld	s4,0(sp)
ffffffffc0207b82:	85ca                	mv	a1,s2
ffffffffc0207b84:	8326                	mv	t1,s1
ffffffffc0207b86:	6942                	ld	s2,16(sp)
ffffffffc0207b88:	64e2                	ld	s1,24(sp)
ffffffffc0207b8a:	6145                	addi	sp,sp,48
ffffffffc0207b8c:	8302                	jr	t1
ffffffffc0207b8e:	03065633          	divu	a2,a2,a6
ffffffffc0207b92:	8722                	mv	a4,s0
ffffffffc0207b94:	f9bff0ef          	jal	ra,ffffffffc0207b2e <printnum>
ffffffffc0207b98:	b7f9                	j	ffffffffc0207b66 <printnum+0x38>

ffffffffc0207b9a <vprintfmt>:
ffffffffc0207b9a:	7119                	addi	sp,sp,-128
ffffffffc0207b9c:	f4a6                	sd	s1,104(sp)
ffffffffc0207b9e:	f0ca                	sd	s2,96(sp)
ffffffffc0207ba0:	ecce                	sd	s3,88(sp)
ffffffffc0207ba2:	e8d2                	sd	s4,80(sp)
ffffffffc0207ba4:	e4d6                	sd	s5,72(sp)
ffffffffc0207ba6:	e0da                	sd	s6,64(sp)
ffffffffc0207ba8:	fc5e                	sd	s7,56(sp)
ffffffffc0207baa:	f06a                	sd	s10,32(sp)
ffffffffc0207bac:	fc86                	sd	ra,120(sp)
ffffffffc0207bae:	f8a2                	sd	s0,112(sp)
ffffffffc0207bb0:	f862                	sd	s8,48(sp)
ffffffffc0207bb2:	f466                	sd	s9,40(sp)
ffffffffc0207bb4:	ec6e                	sd	s11,24(sp)
ffffffffc0207bb6:	892a                	mv	s2,a0
ffffffffc0207bb8:	84ae                	mv	s1,a1
ffffffffc0207bba:	8d32                	mv	s10,a2
ffffffffc0207bbc:	8a36                	mv	s4,a3
ffffffffc0207bbe:	02500993          	li	s3,37
ffffffffc0207bc2:	5b7d                	li	s6,-1
ffffffffc0207bc4:	00002a97          	auipc	s5,0x2
ffffffffc0207bc8:	788a8a93          	addi	s5,s5,1928 # ffffffffc020a34c <syscalls+0x82c>
ffffffffc0207bcc:	00003b97          	auipc	s7,0x3
ffffffffc0207bd0:	99cb8b93          	addi	s7,s7,-1636 # ffffffffc020a568 <error_string>
ffffffffc0207bd4:	000d4503          	lbu	a0,0(s10)
ffffffffc0207bd8:	001d0413          	addi	s0,s10,1
ffffffffc0207bdc:	01350a63          	beq	a0,s3,ffffffffc0207bf0 <vprintfmt+0x56>
ffffffffc0207be0:	c121                	beqz	a0,ffffffffc0207c20 <vprintfmt+0x86>
ffffffffc0207be2:	85a6                	mv	a1,s1
ffffffffc0207be4:	0405                	addi	s0,s0,1
ffffffffc0207be6:	9902                	jalr	s2
ffffffffc0207be8:	fff44503          	lbu	a0,-1(s0)
ffffffffc0207bec:	ff351ae3          	bne	a0,s3,ffffffffc0207be0 <vprintfmt+0x46>
ffffffffc0207bf0:	00044603          	lbu	a2,0(s0)
ffffffffc0207bf4:	02000793          	li	a5,32
ffffffffc0207bf8:	4c81                	li	s9,0
ffffffffc0207bfa:	4881                	li	a7,0
ffffffffc0207bfc:	5c7d                	li	s8,-1
ffffffffc0207bfe:	5dfd                	li	s11,-1
ffffffffc0207c00:	05500513          	li	a0,85
ffffffffc0207c04:	4825                	li	a6,9
ffffffffc0207c06:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c0a:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c0e:	00140d13          	addi	s10,s0,1
ffffffffc0207c12:	04b56263          	bltu	a0,a1,ffffffffc0207c56 <vprintfmt+0xbc>
ffffffffc0207c16:	058a                	slli	a1,a1,0x2
ffffffffc0207c18:	95d6                	add	a1,a1,s5
ffffffffc0207c1a:	4194                	lw	a3,0(a1)
ffffffffc0207c1c:	96d6                	add	a3,a3,s5
ffffffffc0207c1e:	8682                	jr	a3
ffffffffc0207c20:	70e6                	ld	ra,120(sp)
ffffffffc0207c22:	7446                	ld	s0,112(sp)
ffffffffc0207c24:	74a6                	ld	s1,104(sp)
ffffffffc0207c26:	7906                	ld	s2,96(sp)
ffffffffc0207c28:	69e6                	ld	s3,88(sp)
ffffffffc0207c2a:	6a46                	ld	s4,80(sp)
ffffffffc0207c2c:	6aa6                	ld	s5,72(sp)
ffffffffc0207c2e:	6b06                	ld	s6,64(sp)
ffffffffc0207c30:	7be2                	ld	s7,56(sp)
ffffffffc0207c32:	7c42                	ld	s8,48(sp)
ffffffffc0207c34:	7ca2                	ld	s9,40(sp)
ffffffffc0207c36:	7d02                	ld	s10,32(sp)
ffffffffc0207c38:	6de2                	ld	s11,24(sp)
ffffffffc0207c3a:	6109                	addi	sp,sp,128
ffffffffc0207c3c:	8082                	ret
ffffffffc0207c3e:	87b2                	mv	a5,a2
ffffffffc0207c40:	00144603          	lbu	a2,1(s0)
ffffffffc0207c44:	846a                	mv	s0,s10
ffffffffc0207c46:	00140d13          	addi	s10,s0,1
ffffffffc0207c4a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0207c4e:	0ff5f593          	andi	a1,a1,255
ffffffffc0207c52:	fcb572e3          	bgeu	a0,a1,ffffffffc0207c16 <vprintfmt+0x7c>
ffffffffc0207c56:	85a6                	mv	a1,s1
ffffffffc0207c58:	02500513          	li	a0,37
ffffffffc0207c5c:	9902                	jalr	s2
ffffffffc0207c5e:	fff44783          	lbu	a5,-1(s0)
ffffffffc0207c62:	8d22                	mv	s10,s0
ffffffffc0207c64:	f73788e3          	beq	a5,s3,ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207c68:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0207c6c:	1d7d                	addi	s10,s10,-1
ffffffffc0207c6e:	ff379de3          	bne	a5,s3,ffffffffc0207c68 <vprintfmt+0xce>
ffffffffc0207c72:	b78d                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207c74:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0207c78:	00144603          	lbu	a2,1(s0)
ffffffffc0207c7c:	846a                	mv	s0,s10
ffffffffc0207c7e:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207c82:	0006059b          	sext.w	a1,a2
ffffffffc0207c86:	02d86463          	bltu	a6,a3,ffffffffc0207cae <vprintfmt+0x114>
ffffffffc0207c8a:	00144603          	lbu	a2,1(s0)
ffffffffc0207c8e:	002c169b          	slliw	a3,s8,0x2
ffffffffc0207c92:	0186873b          	addw	a4,a3,s8
ffffffffc0207c96:	0017171b          	slliw	a4,a4,0x1
ffffffffc0207c9a:	9f2d                	addw	a4,a4,a1
ffffffffc0207c9c:	fd06069b          	addiw	a3,a2,-48
ffffffffc0207ca0:	0405                	addi	s0,s0,1
ffffffffc0207ca2:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0207ca6:	0006059b          	sext.w	a1,a2
ffffffffc0207caa:	fed870e3          	bgeu	a6,a3,ffffffffc0207c8a <vprintfmt+0xf0>
ffffffffc0207cae:	f40ddce3          	bgez	s11,ffffffffc0207c06 <vprintfmt+0x6c>
ffffffffc0207cb2:	8de2                	mv	s11,s8
ffffffffc0207cb4:	5c7d                	li	s8,-1
ffffffffc0207cb6:	bf81                	j	ffffffffc0207c06 <vprintfmt+0x6c>
ffffffffc0207cb8:	fffdc693          	not	a3,s11
ffffffffc0207cbc:	96fd                	srai	a3,a3,0x3f
ffffffffc0207cbe:	00ddfdb3          	and	s11,s11,a3
ffffffffc0207cc2:	00144603          	lbu	a2,1(s0)
ffffffffc0207cc6:	2d81                	sext.w	s11,s11
ffffffffc0207cc8:	846a                	mv	s0,s10
ffffffffc0207cca:	bf35                	j	ffffffffc0207c06 <vprintfmt+0x6c>
ffffffffc0207ccc:	000a2c03          	lw	s8,0(s4)
ffffffffc0207cd0:	00144603          	lbu	a2,1(s0)
ffffffffc0207cd4:	0a21                	addi	s4,s4,8
ffffffffc0207cd6:	846a                	mv	s0,s10
ffffffffc0207cd8:	bfd9                	j	ffffffffc0207cae <vprintfmt+0x114>
ffffffffc0207cda:	4705                	li	a4,1
ffffffffc0207cdc:	008a0593          	addi	a1,s4,8
ffffffffc0207ce0:	01174463          	blt	a4,a7,ffffffffc0207ce8 <vprintfmt+0x14e>
ffffffffc0207ce4:	1a088e63          	beqz	a7,ffffffffc0207ea0 <vprintfmt+0x306>
ffffffffc0207ce8:	000a3603          	ld	a2,0(s4)
ffffffffc0207cec:	46c1                	li	a3,16
ffffffffc0207cee:	8a2e                	mv	s4,a1
ffffffffc0207cf0:	2781                	sext.w	a5,a5
ffffffffc0207cf2:	876e                	mv	a4,s11
ffffffffc0207cf4:	85a6                	mv	a1,s1
ffffffffc0207cf6:	854a                	mv	a0,s2
ffffffffc0207cf8:	e37ff0ef          	jal	ra,ffffffffc0207b2e <printnum>
ffffffffc0207cfc:	bde1                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207cfe:	000a2503          	lw	a0,0(s4)
ffffffffc0207d02:	85a6                	mv	a1,s1
ffffffffc0207d04:	0a21                	addi	s4,s4,8
ffffffffc0207d06:	9902                	jalr	s2
ffffffffc0207d08:	b5f1                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207d0a:	4705                	li	a4,1
ffffffffc0207d0c:	008a0593          	addi	a1,s4,8
ffffffffc0207d10:	01174463          	blt	a4,a7,ffffffffc0207d18 <vprintfmt+0x17e>
ffffffffc0207d14:	18088163          	beqz	a7,ffffffffc0207e96 <vprintfmt+0x2fc>
ffffffffc0207d18:	000a3603          	ld	a2,0(s4)
ffffffffc0207d1c:	46a9                	li	a3,10
ffffffffc0207d1e:	8a2e                	mv	s4,a1
ffffffffc0207d20:	bfc1                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207d22:	00144603          	lbu	a2,1(s0)
ffffffffc0207d26:	4c85                	li	s9,1
ffffffffc0207d28:	846a                	mv	s0,s10
ffffffffc0207d2a:	bdf1                	j	ffffffffc0207c06 <vprintfmt+0x6c>
ffffffffc0207d2c:	85a6                	mv	a1,s1
ffffffffc0207d2e:	02500513          	li	a0,37
ffffffffc0207d32:	9902                	jalr	s2
ffffffffc0207d34:	b545                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207d36:	00144603          	lbu	a2,1(s0)
ffffffffc0207d3a:	2885                	addiw	a7,a7,1
ffffffffc0207d3c:	846a                	mv	s0,s10
ffffffffc0207d3e:	b5e1                	j	ffffffffc0207c06 <vprintfmt+0x6c>
ffffffffc0207d40:	4705                	li	a4,1
ffffffffc0207d42:	008a0593          	addi	a1,s4,8
ffffffffc0207d46:	01174463          	blt	a4,a7,ffffffffc0207d4e <vprintfmt+0x1b4>
ffffffffc0207d4a:	14088163          	beqz	a7,ffffffffc0207e8c <vprintfmt+0x2f2>
ffffffffc0207d4e:	000a3603          	ld	a2,0(s4)
ffffffffc0207d52:	46a1                	li	a3,8
ffffffffc0207d54:	8a2e                	mv	s4,a1
ffffffffc0207d56:	bf69                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207d58:	03000513          	li	a0,48
ffffffffc0207d5c:	85a6                	mv	a1,s1
ffffffffc0207d5e:	e03e                	sd	a5,0(sp)
ffffffffc0207d60:	9902                	jalr	s2
ffffffffc0207d62:	85a6                	mv	a1,s1
ffffffffc0207d64:	07800513          	li	a0,120
ffffffffc0207d68:	9902                	jalr	s2
ffffffffc0207d6a:	0a21                	addi	s4,s4,8
ffffffffc0207d6c:	6782                	ld	a5,0(sp)
ffffffffc0207d6e:	46c1                	li	a3,16
ffffffffc0207d70:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0207d74:	bfb5                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207d76:	000a3403          	ld	s0,0(s4)
ffffffffc0207d7a:	008a0713          	addi	a4,s4,8
ffffffffc0207d7e:	e03a                	sd	a4,0(sp)
ffffffffc0207d80:	14040263          	beqz	s0,ffffffffc0207ec4 <vprintfmt+0x32a>
ffffffffc0207d84:	0fb05763          	blez	s11,ffffffffc0207e72 <vprintfmt+0x2d8>
ffffffffc0207d88:	02d00693          	li	a3,45
ffffffffc0207d8c:	0cd79163          	bne	a5,a3,ffffffffc0207e4e <vprintfmt+0x2b4>
ffffffffc0207d90:	00044783          	lbu	a5,0(s0)
ffffffffc0207d94:	0007851b          	sext.w	a0,a5
ffffffffc0207d98:	cf85                	beqz	a5,ffffffffc0207dd0 <vprintfmt+0x236>
ffffffffc0207d9a:	00140a13          	addi	s4,s0,1
ffffffffc0207d9e:	05e00413          	li	s0,94
ffffffffc0207da2:	000c4563          	bltz	s8,ffffffffc0207dac <vprintfmt+0x212>
ffffffffc0207da6:	3c7d                	addiw	s8,s8,-1
ffffffffc0207da8:	036c0263          	beq	s8,s6,ffffffffc0207dcc <vprintfmt+0x232>
ffffffffc0207dac:	85a6                	mv	a1,s1
ffffffffc0207dae:	0e0c8e63          	beqz	s9,ffffffffc0207eaa <vprintfmt+0x310>
ffffffffc0207db2:	3781                	addiw	a5,a5,-32
ffffffffc0207db4:	0ef47b63          	bgeu	s0,a5,ffffffffc0207eaa <vprintfmt+0x310>
ffffffffc0207db8:	03f00513          	li	a0,63
ffffffffc0207dbc:	9902                	jalr	s2
ffffffffc0207dbe:	000a4783          	lbu	a5,0(s4)
ffffffffc0207dc2:	3dfd                	addiw	s11,s11,-1
ffffffffc0207dc4:	0a05                	addi	s4,s4,1
ffffffffc0207dc6:	0007851b          	sext.w	a0,a5
ffffffffc0207dca:	ffe1                	bnez	a5,ffffffffc0207da2 <vprintfmt+0x208>
ffffffffc0207dcc:	01b05963          	blez	s11,ffffffffc0207dde <vprintfmt+0x244>
ffffffffc0207dd0:	3dfd                	addiw	s11,s11,-1
ffffffffc0207dd2:	85a6                	mv	a1,s1
ffffffffc0207dd4:	02000513          	li	a0,32
ffffffffc0207dd8:	9902                	jalr	s2
ffffffffc0207dda:	fe0d9be3          	bnez	s11,ffffffffc0207dd0 <vprintfmt+0x236>
ffffffffc0207dde:	6a02                	ld	s4,0(sp)
ffffffffc0207de0:	bbd5                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207de2:	4705                	li	a4,1
ffffffffc0207de4:	008a0c93          	addi	s9,s4,8
ffffffffc0207de8:	01174463          	blt	a4,a7,ffffffffc0207df0 <vprintfmt+0x256>
ffffffffc0207dec:	08088d63          	beqz	a7,ffffffffc0207e86 <vprintfmt+0x2ec>
ffffffffc0207df0:	000a3403          	ld	s0,0(s4)
ffffffffc0207df4:	0a044d63          	bltz	s0,ffffffffc0207eae <vprintfmt+0x314>
ffffffffc0207df8:	8622                	mv	a2,s0
ffffffffc0207dfa:	8a66                	mv	s4,s9
ffffffffc0207dfc:	46a9                	li	a3,10
ffffffffc0207dfe:	bdcd                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207e00:	000a2783          	lw	a5,0(s4)
ffffffffc0207e04:	4761                	li	a4,24
ffffffffc0207e06:	0a21                	addi	s4,s4,8
ffffffffc0207e08:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0207e0c:	8fb5                	xor	a5,a5,a3
ffffffffc0207e0e:	40d786bb          	subw	a3,a5,a3
ffffffffc0207e12:	02d74163          	blt	a4,a3,ffffffffc0207e34 <vprintfmt+0x29a>
ffffffffc0207e16:	00369793          	slli	a5,a3,0x3
ffffffffc0207e1a:	97de                	add	a5,a5,s7
ffffffffc0207e1c:	639c                	ld	a5,0(a5)
ffffffffc0207e1e:	cb99                	beqz	a5,ffffffffc0207e34 <vprintfmt+0x29a>
ffffffffc0207e20:	86be                	mv	a3,a5
ffffffffc0207e22:	00000617          	auipc	a2,0x0
ffffffffc0207e26:	13660613          	addi	a2,a2,310 # ffffffffc0207f58 <etext+0x26>
ffffffffc0207e2a:	85a6                	mv	a1,s1
ffffffffc0207e2c:	854a                	mv	a0,s2
ffffffffc0207e2e:	0ce000ef          	jal	ra,ffffffffc0207efc <printfmt>
ffffffffc0207e32:	b34d                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207e34:	00002617          	auipc	a2,0x2
ffffffffc0207e38:	50c60613          	addi	a2,a2,1292 # ffffffffc020a340 <syscalls+0x820>
ffffffffc0207e3c:	85a6                	mv	a1,s1
ffffffffc0207e3e:	854a                	mv	a0,s2
ffffffffc0207e40:	0bc000ef          	jal	ra,ffffffffc0207efc <printfmt>
ffffffffc0207e44:	bb41                	j	ffffffffc0207bd4 <vprintfmt+0x3a>
ffffffffc0207e46:	00002417          	auipc	s0,0x2
ffffffffc0207e4a:	4f240413          	addi	s0,s0,1266 # ffffffffc020a338 <syscalls+0x818>
ffffffffc0207e4e:	85e2                	mv	a1,s8
ffffffffc0207e50:	8522                	mv	a0,s0
ffffffffc0207e52:	e43e                	sd	a5,8(sp)
ffffffffc0207e54:	c61ff0ef          	jal	ra,ffffffffc0207ab4 <strnlen>
ffffffffc0207e58:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0207e5c:	01b05b63          	blez	s11,ffffffffc0207e72 <vprintfmt+0x2d8>
ffffffffc0207e60:	67a2                	ld	a5,8(sp)
ffffffffc0207e62:	00078a1b          	sext.w	s4,a5
ffffffffc0207e66:	3dfd                	addiw	s11,s11,-1
ffffffffc0207e68:	85a6                	mv	a1,s1
ffffffffc0207e6a:	8552                	mv	a0,s4
ffffffffc0207e6c:	9902                	jalr	s2
ffffffffc0207e6e:	fe0d9ce3          	bnez	s11,ffffffffc0207e66 <vprintfmt+0x2cc>
ffffffffc0207e72:	00044783          	lbu	a5,0(s0)
ffffffffc0207e76:	00140a13          	addi	s4,s0,1
ffffffffc0207e7a:	0007851b          	sext.w	a0,a5
ffffffffc0207e7e:	d3a5                	beqz	a5,ffffffffc0207dde <vprintfmt+0x244>
ffffffffc0207e80:	05e00413          	li	s0,94
ffffffffc0207e84:	bf39                	j	ffffffffc0207da2 <vprintfmt+0x208>
ffffffffc0207e86:	000a2403          	lw	s0,0(s4)
ffffffffc0207e8a:	b7ad                	j	ffffffffc0207df4 <vprintfmt+0x25a>
ffffffffc0207e8c:	000a6603          	lwu	a2,0(s4)
ffffffffc0207e90:	46a1                	li	a3,8
ffffffffc0207e92:	8a2e                	mv	s4,a1
ffffffffc0207e94:	bdb1                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207e96:	000a6603          	lwu	a2,0(s4)
ffffffffc0207e9a:	46a9                	li	a3,10
ffffffffc0207e9c:	8a2e                	mv	s4,a1
ffffffffc0207e9e:	bd89                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207ea0:	000a6603          	lwu	a2,0(s4)
ffffffffc0207ea4:	46c1                	li	a3,16
ffffffffc0207ea6:	8a2e                	mv	s4,a1
ffffffffc0207ea8:	b5a1                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207eaa:	9902                	jalr	s2
ffffffffc0207eac:	bf09                	j	ffffffffc0207dbe <vprintfmt+0x224>
ffffffffc0207eae:	85a6                	mv	a1,s1
ffffffffc0207eb0:	02d00513          	li	a0,45
ffffffffc0207eb4:	e03e                	sd	a5,0(sp)
ffffffffc0207eb6:	9902                	jalr	s2
ffffffffc0207eb8:	6782                	ld	a5,0(sp)
ffffffffc0207eba:	8a66                	mv	s4,s9
ffffffffc0207ebc:	40800633          	neg	a2,s0
ffffffffc0207ec0:	46a9                	li	a3,10
ffffffffc0207ec2:	b53d                	j	ffffffffc0207cf0 <vprintfmt+0x156>
ffffffffc0207ec4:	03b05163          	blez	s11,ffffffffc0207ee6 <vprintfmt+0x34c>
ffffffffc0207ec8:	02d00693          	li	a3,45
ffffffffc0207ecc:	f6d79de3          	bne	a5,a3,ffffffffc0207e46 <vprintfmt+0x2ac>
ffffffffc0207ed0:	00002417          	auipc	s0,0x2
ffffffffc0207ed4:	46840413          	addi	s0,s0,1128 # ffffffffc020a338 <syscalls+0x818>
ffffffffc0207ed8:	02800793          	li	a5,40
ffffffffc0207edc:	02800513          	li	a0,40
ffffffffc0207ee0:	00140a13          	addi	s4,s0,1
ffffffffc0207ee4:	bd6d                	j	ffffffffc0207d9e <vprintfmt+0x204>
ffffffffc0207ee6:	00002a17          	auipc	s4,0x2
ffffffffc0207eea:	453a0a13          	addi	s4,s4,1107 # ffffffffc020a339 <syscalls+0x819>
ffffffffc0207eee:	02800513          	li	a0,40
ffffffffc0207ef2:	02800793          	li	a5,40
ffffffffc0207ef6:	05e00413          	li	s0,94
ffffffffc0207efa:	b565                	j	ffffffffc0207da2 <vprintfmt+0x208>

ffffffffc0207efc <printfmt>:
ffffffffc0207efc:	715d                	addi	sp,sp,-80
ffffffffc0207efe:	02810313          	addi	t1,sp,40
ffffffffc0207f02:	f436                	sd	a3,40(sp)
ffffffffc0207f04:	869a                	mv	a3,t1
ffffffffc0207f06:	ec06                	sd	ra,24(sp)
ffffffffc0207f08:	f83a                	sd	a4,48(sp)
ffffffffc0207f0a:	fc3e                	sd	a5,56(sp)
ffffffffc0207f0c:	e0c2                	sd	a6,64(sp)
ffffffffc0207f0e:	e4c6                	sd	a7,72(sp)
ffffffffc0207f10:	e41a                	sd	t1,8(sp)
ffffffffc0207f12:	c89ff0ef          	jal	ra,ffffffffc0207b9a <vprintfmt>
ffffffffc0207f16:	60e2                	ld	ra,24(sp)
ffffffffc0207f18:	6161                	addi	sp,sp,80
ffffffffc0207f1a:	8082                	ret

ffffffffc0207f1c <hash32>:
ffffffffc0207f1c:	9e3707b7          	lui	a5,0x9e370
ffffffffc0207f20:	2785                	addiw	a5,a5,1
ffffffffc0207f22:	02a7853b          	mulw	a0,a5,a0
ffffffffc0207f26:	02000793          	li	a5,32
ffffffffc0207f2a:	9f8d                	subw	a5,a5,a1
ffffffffc0207f2c:	00f5553b          	srlw	a0,a0,a5
ffffffffc0207f30:	8082                	ret
