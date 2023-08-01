
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	c02082b7          	lui	t0,0xc0208
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
ffffffffc020001c:	18029073          	csrw	satp,t0
ffffffffc0200020:	12000073          	sfence.vma
ffffffffc0200024:	c0208137          	lui	sp,0xc0208
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:
ffffffffc0200032:	00009517          	auipc	a0,0x9
ffffffffc0200036:	00e50513          	addi	a0,a0,14 # ffffffffc0209040 <ide>
ffffffffc020003a:	00010617          	auipc	a2,0x10
ffffffffc020003e:	16660613          	addi	a2,a2,358 # ffffffffc02101a0 <end>
ffffffffc0200042:	1141                	addi	sp,sp,-16
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
ffffffffc0200048:	e406                	sd	ra,8(sp)
ffffffffc020004a:	08b030ef          	jal	ra,ffffffffc02038d4 <memset>
ffffffffc020004e:	00004597          	auipc	a1,0x4
ffffffffc0200052:	ca258593          	addi	a1,a1,-862 # ffffffffc0203cf0 <etext+0x4>
ffffffffc0200056:	00004517          	auipc	a0,0x4
ffffffffc020005a:	cb250513          	addi	a0,a0,-846 # ffffffffc0203d08 <etext+0x1c>
ffffffffc020005e:	058000ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200062:	3f5000ef          	jal	ra,ffffffffc0200c56 <pmm_init>
ffffffffc0200066:	204000ef          	jal	ra,ffffffffc020026a <idt_init>
ffffffffc020006a:	14d010ef          	jal	ra,ffffffffc02019b6 <vmm_init>
ffffffffc020006e:	0dc000ef          	jal	ra,ffffffffc020014a <ide_init>
ffffffffc0200072:	17c000ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc0200076:	747010ef          	jal	ra,ffffffffc0201fbc <swap_init>
ffffffffc020007a:	a001                	j	ffffffffc020007a <kern_init+0x48>

ffffffffc020007c <cputch>:
ffffffffc020007c:	1141                	addi	sp,sp,-16
ffffffffc020007e:	e022                	sd	s0,0(sp)
ffffffffc0200080:	e406                	sd	ra,8(sp)
ffffffffc0200082:	842e                	mv	s0,a1
ffffffffc0200084:	136000ef          	jal	ra,ffffffffc02001ba <cons_putc>
ffffffffc0200088:	401c                	lw	a5,0(s0)
ffffffffc020008a:	60a2                	ld	ra,8(sp)
ffffffffc020008c:	2785                	addiw	a5,a5,1
ffffffffc020008e:	c01c                	sw	a5,0(s0)
ffffffffc0200090:	6402                	ld	s0,0(sp)
ffffffffc0200092:	0141                	addi	sp,sp,16
ffffffffc0200094:	8082                	ret

ffffffffc0200096 <vcprintf>:
ffffffffc0200096:	1101                	addi	sp,sp,-32
ffffffffc0200098:	862a                	mv	a2,a0
ffffffffc020009a:	86ae                	mv	a3,a1
ffffffffc020009c:	00000517          	auipc	a0,0x0
ffffffffc02000a0:	fe050513          	addi	a0,a0,-32 # ffffffffc020007c <cputch>
ffffffffc02000a4:	006c                	addi	a1,sp,12
ffffffffc02000a6:	ec06                	sd	ra,24(sp)
ffffffffc02000a8:	c602                	sw	zero,12(sp)
ffffffffc02000aa:	0c1030ef          	jal	ra,ffffffffc020396a <vprintfmt>
ffffffffc02000ae:	60e2                	ld	ra,24(sp)
ffffffffc02000b0:	4532                	lw	a0,12(sp)
ffffffffc02000b2:	6105                	addi	sp,sp,32
ffffffffc02000b4:	8082                	ret

ffffffffc02000b6 <cprintf>:
ffffffffc02000b6:	711d                	addi	sp,sp,-96
ffffffffc02000b8:	02810313          	addi	t1,sp,40 # ffffffffc0208028 <boot_page_table_sv39+0x28>
ffffffffc02000bc:	8e2a                	mv	t3,a0
ffffffffc02000be:	f42e                	sd	a1,40(sp)
ffffffffc02000c0:	f832                	sd	a2,48(sp)
ffffffffc02000c2:	fc36                	sd	a3,56(sp)
ffffffffc02000c4:	00000517          	auipc	a0,0x0
ffffffffc02000c8:	fb850513          	addi	a0,a0,-72 # ffffffffc020007c <cputch>
ffffffffc02000cc:	004c                	addi	a1,sp,4
ffffffffc02000ce:	869a                	mv	a3,t1
ffffffffc02000d0:	8672                	mv	a2,t3
ffffffffc02000d2:	ec06                	sd	ra,24(sp)
ffffffffc02000d4:	e0ba                	sd	a4,64(sp)
ffffffffc02000d6:	e4be                	sd	a5,72(sp)
ffffffffc02000d8:	e8c2                	sd	a6,80(sp)
ffffffffc02000da:	ecc6                	sd	a7,88(sp)
ffffffffc02000dc:	e41a                	sd	t1,8(sp)
ffffffffc02000de:	c202                	sw	zero,4(sp)
ffffffffc02000e0:	08b030ef          	jal	ra,ffffffffc020396a <vprintfmt>
ffffffffc02000e4:	60e2                	ld	ra,24(sp)
ffffffffc02000e6:	4512                	lw	a0,4(sp)
ffffffffc02000e8:	6125                	addi	sp,sp,96
ffffffffc02000ea:	8082                	ret

ffffffffc02000ec <__panic>:
ffffffffc02000ec:	00010317          	auipc	t1,0x10
ffffffffc02000f0:	f5430313          	addi	t1,t1,-172 # ffffffffc0210040 <is_panic>
ffffffffc02000f4:	00032e03          	lw	t3,0(t1)
ffffffffc02000f8:	715d                	addi	sp,sp,-80
ffffffffc02000fa:	ec06                	sd	ra,24(sp)
ffffffffc02000fc:	e822                	sd	s0,16(sp)
ffffffffc02000fe:	f436                	sd	a3,40(sp)
ffffffffc0200100:	f83a                	sd	a4,48(sp)
ffffffffc0200102:	fc3e                	sd	a5,56(sp)
ffffffffc0200104:	e0c2                	sd	a6,64(sp)
ffffffffc0200106:	e4c6                	sd	a7,72(sp)
ffffffffc0200108:	020e1a63          	bnez	t3,ffffffffc020013c <__panic+0x50>
ffffffffc020010c:	4785                	li	a5,1
ffffffffc020010e:	00f32023          	sw	a5,0(t1)
ffffffffc0200112:	8432                	mv	s0,a2
ffffffffc0200114:	103c                	addi	a5,sp,40
ffffffffc0200116:	862e                	mv	a2,a1
ffffffffc0200118:	85aa                	mv	a1,a0
ffffffffc020011a:	00004517          	auipc	a0,0x4
ffffffffc020011e:	bf650513          	addi	a0,a0,-1034 # ffffffffc0203d10 <etext+0x24>
ffffffffc0200122:	e43e                	sd	a5,8(sp)
ffffffffc0200124:	f93ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200128:	65a2                	ld	a1,8(sp)
ffffffffc020012a:	8522                	mv	a0,s0
ffffffffc020012c:	f6bff0ef          	jal	ra,ffffffffc0200096 <vcprintf>
ffffffffc0200130:	00004517          	auipc	a0,0x4
ffffffffc0200134:	6d850513          	addi	a0,a0,1752 # ffffffffc0204808 <etext+0xb1c>
ffffffffc0200138:	f7fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020013c:	0b8000ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200140:	4501                	li	a0,0
ffffffffc0200142:	006000ef          	jal	ra,ffffffffc0200148 <kmonitor>
ffffffffc0200146:	bfed                	j	ffffffffc0200140 <__panic+0x54>

ffffffffc0200148 <kmonitor>:
ffffffffc0200148:	a001                	j	ffffffffc0200148 <kmonitor>

ffffffffc020014a <ide_init>:
ffffffffc020014a:	8082                	ret

ffffffffc020014c <ide_device_valid>:
ffffffffc020014c:	00253513          	sltiu	a0,a0,2
ffffffffc0200150:	8082                	ret

ffffffffc0200152 <ide_device_size>:
ffffffffc0200152:	03800513          	li	a0,56
ffffffffc0200156:	8082                	ret

ffffffffc0200158 <ide_read_secs>:
ffffffffc0200158:	00009797          	auipc	a5,0x9
ffffffffc020015c:	ee878793          	addi	a5,a5,-280 # ffffffffc0209040 <ide>
ffffffffc0200160:	0095959b          	slliw	a1,a1,0x9
ffffffffc0200164:	1141                	addi	sp,sp,-16
ffffffffc0200166:	8532                	mv	a0,a2
ffffffffc0200168:	95be                	add	a1,a1,a5
ffffffffc020016a:	00969613          	slli	a2,a3,0x9
ffffffffc020016e:	e406                	sd	ra,8(sp)
ffffffffc0200170:	776030ef          	jal	ra,ffffffffc02038e6 <memcpy>
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	4501                	li	a0,0
ffffffffc0200178:	0141                	addi	sp,sp,16
ffffffffc020017a:	8082                	ret

ffffffffc020017c <ide_write_secs>:
ffffffffc020017c:	0095979b          	slliw	a5,a1,0x9
ffffffffc0200180:	00009517          	auipc	a0,0x9
ffffffffc0200184:	ec050513          	addi	a0,a0,-320 # ffffffffc0209040 <ide>
ffffffffc0200188:	1141                	addi	sp,sp,-16
ffffffffc020018a:	85b2                	mv	a1,a2
ffffffffc020018c:	953e                	add	a0,a0,a5
ffffffffc020018e:	00969613          	slli	a2,a3,0x9
ffffffffc0200192:	e406                	sd	ra,8(sp)
ffffffffc0200194:	752030ef          	jal	ra,ffffffffc02038e6 <memcpy>
ffffffffc0200198:	60a2                	ld	ra,8(sp)
ffffffffc020019a:	4501                	li	a0,0
ffffffffc020019c:	0141                	addi	sp,sp,16
ffffffffc020019e:	8082                	ret

ffffffffc02001a0 <clock_set_next_event>:
ffffffffc02001a0:	c0102573          	rdtime	a0
ffffffffc02001a4:	00010797          	auipc	a5,0x10
ffffffffc02001a8:	ea47b783          	ld	a5,-348(a5) # ffffffffc0210048 <timebase>
ffffffffc02001ac:	953e                	add	a0,a0,a5
ffffffffc02001ae:	4581                	li	a1,0
ffffffffc02001b0:	4601                	li	a2,0
ffffffffc02001b2:	4881                	li	a7,0
ffffffffc02001b4:	00000073          	ecall
ffffffffc02001b8:	8082                	ret

ffffffffc02001ba <cons_putc>:
ffffffffc02001ba:	100027f3          	csrr	a5,sstatus
ffffffffc02001be:	8b89                	andi	a5,a5,2
ffffffffc02001c0:	0ff57513          	andi	a0,a0,255
ffffffffc02001c4:	e799                	bnez	a5,ffffffffc02001d2 <cons_putc+0x18>
ffffffffc02001c6:	4581                	li	a1,0
ffffffffc02001c8:	4601                	li	a2,0
ffffffffc02001ca:	4885                	li	a7,1
ffffffffc02001cc:	00000073          	ecall
ffffffffc02001d0:	8082                	ret
ffffffffc02001d2:	1101                	addi	sp,sp,-32
ffffffffc02001d4:	ec06                	sd	ra,24(sp)
ffffffffc02001d6:	e42a                	sd	a0,8(sp)
ffffffffc02001d8:	01c000ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc02001dc:	6522                	ld	a0,8(sp)
ffffffffc02001de:	4581                	li	a1,0
ffffffffc02001e0:	4601                	li	a2,0
ffffffffc02001e2:	4885                	li	a7,1
ffffffffc02001e4:	00000073          	ecall
ffffffffc02001e8:	60e2                	ld	ra,24(sp)
ffffffffc02001ea:	6105                	addi	sp,sp,32
ffffffffc02001ec:	a009                	j	ffffffffc02001ee <intr_enable>

ffffffffc02001ee <intr_enable>:
ffffffffc02001ee:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <intr_disable>:
ffffffffc02001f4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02001f8:	8082                	ret

ffffffffc02001fa <pgfault_handler>:
ffffffffc02001fa:	10053783          	ld	a5,256(a0)
ffffffffc02001fe:	1141                	addi	sp,sp,-16
ffffffffc0200200:	e022                	sd	s0,0(sp)
ffffffffc0200202:	e406                	sd	ra,8(sp)
ffffffffc0200204:	1007f793          	andi	a5,a5,256
ffffffffc0200208:	11053583          	ld	a1,272(a0)
ffffffffc020020c:	842a                	mv	s0,a0
ffffffffc020020e:	05500613          	li	a2,85
ffffffffc0200212:	c399                	beqz	a5,ffffffffc0200218 <pgfault_handler+0x1e>
ffffffffc0200214:	04b00613          	li	a2,75
ffffffffc0200218:	11843703          	ld	a4,280(s0)
ffffffffc020021c:	47bd                	li	a5,15
ffffffffc020021e:	05700693          	li	a3,87
ffffffffc0200222:	00f70463          	beq	a4,a5,ffffffffc020022a <pgfault_handler+0x30>
ffffffffc0200226:	05200693          	li	a3,82
ffffffffc020022a:	00004517          	auipc	a0,0x4
ffffffffc020022e:	b0650513          	addi	a0,a0,-1274 # ffffffffc0203d30 <etext+0x44>
ffffffffc0200232:	e85ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200236:	00010517          	auipc	a0,0x10
ffffffffc020023a:	e8253503          	ld	a0,-382(a0) # ffffffffc02100b8 <check_mm_struct>
ffffffffc020023e:	c911                	beqz	a0,ffffffffc0200252 <pgfault_handler+0x58>
ffffffffc0200240:	11043603          	ld	a2,272(s0)
ffffffffc0200244:	11843583          	ld	a1,280(s0)
ffffffffc0200248:	6402                	ld	s0,0(sp)
ffffffffc020024a:	60a2                	ld	ra,8(sp)
ffffffffc020024c:	0141                	addi	sp,sp,16
ffffffffc020024e:	4a10106f          	j	ffffffffc0201eee <do_pgfault>
ffffffffc0200252:	00004617          	auipc	a2,0x4
ffffffffc0200256:	afe60613          	addi	a2,a2,-1282 # ffffffffc0203d50 <etext+0x64>
ffffffffc020025a:	06300593          	li	a1,99
ffffffffc020025e:	00004517          	auipc	a0,0x4
ffffffffc0200262:	b0a50513          	addi	a0,a0,-1270 # ffffffffc0203d68 <etext+0x7c>
ffffffffc0200266:	e87ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc020026a <idt_init>:
ffffffffc020026a:	14005073          	csrwi	sscratch,0
ffffffffc020026e:	00000797          	auipc	a5,0x0
ffffffffc0200272:	47278793          	addi	a5,a5,1138 # ffffffffc02006e0 <__alltraps>
ffffffffc0200276:	10579073          	csrw	stvec,a5
ffffffffc020027a:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc020027e:	000407b7          	lui	a5,0x40
ffffffffc0200282:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200286:	8082                	ret

ffffffffc0200288 <print_regs>:
ffffffffc0200288:	610c                	ld	a1,0(a0)
ffffffffc020028a:	1141                	addi	sp,sp,-16
ffffffffc020028c:	e022                	sd	s0,0(sp)
ffffffffc020028e:	842a                	mv	s0,a0
ffffffffc0200290:	00004517          	auipc	a0,0x4
ffffffffc0200294:	af050513          	addi	a0,a0,-1296 # ffffffffc0203d80 <etext+0x94>
ffffffffc0200298:	e406                	sd	ra,8(sp)
ffffffffc020029a:	e1dff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020029e:	640c                	ld	a1,8(s0)
ffffffffc02002a0:	00004517          	auipc	a0,0x4
ffffffffc02002a4:	af850513          	addi	a0,a0,-1288 # ffffffffc0203d98 <etext+0xac>
ffffffffc02002a8:	e0fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002ac:	680c                	ld	a1,16(s0)
ffffffffc02002ae:	00004517          	auipc	a0,0x4
ffffffffc02002b2:	b0250513          	addi	a0,a0,-1278 # ffffffffc0203db0 <etext+0xc4>
ffffffffc02002b6:	e01ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002ba:	6c0c                	ld	a1,24(s0)
ffffffffc02002bc:	00004517          	auipc	a0,0x4
ffffffffc02002c0:	b0c50513          	addi	a0,a0,-1268 # ffffffffc0203dc8 <etext+0xdc>
ffffffffc02002c4:	df3ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002c8:	700c                	ld	a1,32(s0)
ffffffffc02002ca:	00004517          	auipc	a0,0x4
ffffffffc02002ce:	b1650513          	addi	a0,a0,-1258 # ffffffffc0203de0 <etext+0xf4>
ffffffffc02002d2:	de5ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002d6:	740c                	ld	a1,40(s0)
ffffffffc02002d8:	00004517          	auipc	a0,0x4
ffffffffc02002dc:	b2050513          	addi	a0,a0,-1248 # ffffffffc0203df8 <etext+0x10c>
ffffffffc02002e0:	dd7ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002e4:	780c                	ld	a1,48(s0)
ffffffffc02002e6:	00004517          	auipc	a0,0x4
ffffffffc02002ea:	b2a50513          	addi	a0,a0,-1238 # ffffffffc0203e10 <etext+0x124>
ffffffffc02002ee:	dc9ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02002f2:	7c0c                	ld	a1,56(s0)
ffffffffc02002f4:	00004517          	auipc	a0,0x4
ffffffffc02002f8:	b3450513          	addi	a0,a0,-1228 # ffffffffc0203e28 <etext+0x13c>
ffffffffc02002fc:	dbbff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200300:	602c                	ld	a1,64(s0)
ffffffffc0200302:	00004517          	auipc	a0,0x4
ffffffffc0200306:	b3e50513          	addi	a0,a0,-1218 # ffffffffc0203e40 <etext+0x154>
ffffffffc020030a:	dadff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020030e:	642c                	ld	a1,72(s0)
ffffffffc0200310:	00004517          	auipc	a0,0x4
ffffffffc0200314:	b4850513          	addi	a0,a0,-1208 # ffffffffc0203e58 <etext+0x16c>
ffffffffc0200318:	d9fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020031c:	682c                	ld	a1,80(s0)
ffffffffc020031e:	00004517          	auipc	a0,0x4
ffffffffc0200322:	b5250513          	addi	a0,a0,-1198 # ffffffffc0203e70 <etext+0x184>
ffffffffc0200326:	d91ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020032a:	6c2c                	ld	a1,88(s0)
ffffffffc020032c:	00004517          	auipc	a0,0x4
ffffffffc0200330:	b5c50513          	addi	a0,a0,-1188 # ffffffffc0203e88 <etext+0x19c>
ffffffffc0200334:	d83ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200338:	702c                	ld	a1,96(s0)
ffffffffc020033a:	00004517          	auipc	a0,0x4
ffffffffc020033e:	b6650513          	addi	a0,a0,-1178 # ffffffffc0203ea0 <etext+0x1b4>
ffffffffc0200342:	d75ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200346:	742c                	ld	a1,104(s0)
ffffffffc0200348:	00004517          	auipc	a0,0x4
ffffffffc020034c:	b7050513          	addi	a0,a0,-1168 # ffffffffc0203eb8 <etext+0x1cc>
ffffffffc0200350:	d67ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200354:	782c                	ld	a1,112(s0)
ffffffffc0200356:	00004517          	auipc	a0,0x4
ffffffffc020035a:	b7a50513          	addi	a0,a0,-1158 # ffffffffc0203ed0 <etext+0x1e4>
ffffffffc020035e:	d59ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200362:	7c2c                	ld	a1,120(s0)
ffffffffc0200364:	00004517          	auipc	a0,0x4
ffffffffc0200368:	b8450513          	addi	a0,a0,-1148 # ffffffffc0203ee8 <etext+0x1fc>
ffffffffc020036c:	d4bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200370:	604c                	ld	a1,128(s0)
ffffffffc0200372:	00004517          	auipc	a0,0x4
ffffffffc0200376:	b8e50513          	addi	a0,a0,-1138 # ffffffffc0203f00 <etext+0x214>
ffffffffc020037a:	d3dff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020037e:	644c                	ld	a1,136(s0)
ffffffffc0200380:	00004517          	auipc	a0,0x4
ffffffffc0200384:	b9850513          	addi	a0,a0,-1128 # ffffffffc0203f18 <etext+0x22c>
ffffffffc0200388:	d2fff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020038c:	684c                	ld	a1,144(s0)
ffffffffc020038e:	00004517          	auipc	a0,0x4
ffffffffc0200392:	ba250513          	addi	a0,a0,-1118 # ffffffffc0203f30 <etext+0x244>
ffffffffc0200396:	d21ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020039a:	6c4c                	ld	a1,152(s0)
ffffffffc020039c:	00004517          	auipc	a0,0x4
ffffffffc02003a0:	bac50513          	addi	a0,a0,-1108 # ffffffffc0203f48 <etext+0x25c>
ffffffffc02003a4:	d13ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003a8:	704c                	ld	a1,160(s0)
ffffffffc02003aa:	00004517          	auipc	a0,0x4
ffffffffc02003ae:	bb650513          	addi	a0,a0,-1098 # ffffffffc0203f60 <etext+0x274>
ffffffffc02003b2:	d05ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003b6:	744c                	ld	a1,168(s0)
ffffffffc02003b8:	00004517          	auipc	a0,0x4
ffffffffc02003bc:	bc050513          	addi	a0,a0,-1088 # ffffffffc0203f78 <etext+0x28c>
ffffffffc02003c0:	cf7ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003c4:	784c                	ld	a1,176(s0)
ffffffffc02003c6:	00004517          	auipc	a0,0x4
ffffffffc02003ca:	bca50513          	addi	a0,a0,-1078 # ffffffffc0203f90 <etext+0x2a4>
ffffffffc02003ce:	ce9ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003d2:	7c4c                	ld	a1,184(s0)
ffffffffc02003d4:	00004517          	auipc	a0,0x4
ffffffffc02003d8:	bd450513          	addi	a0,a0,-1068 # ffffffffc0203fa8 <etext+0x2bc>
ffffffffc02003dc:	cdbff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003e0:	606c                	ld	a1,192(s0)
ffffffffc02003e2:	00004517          	auipc	a0,0x4
ffffffffc02003e6:	bde50513          	addi	a0,a0,-1058 # ffffffffc0203fc0 <etext+0x2d4>
ffffffffc02003ea:	ccdff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003ee:	646c                	ld	a1,200(s0)
ffffffffc02003f0:	00004517          	auipc	a0,0x4
ffffffffc02003f4:	be850513          	addi	a0,a0,-1048 # ffffffffc0203fd8 <etext+0x2ec>
ffffffffc02003f8:	cbfff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02003fc:	686c                	ld	a1,208(s0)
ffffffffc02003fe:	00004517          	auipc	a0,0x4
ffffffffc0200402:	bf250513          	addi	a0,a0,-1038 # ffffffffc0203ff0 <etext+0x304>
ffffffffc0200406:	cb1ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020040a:	6c6c                	ld	a1,216(s0)
ffffffffc020040c:	00004517          	auipc	a0,0x4
ffffffffc0200410:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0204008 <etext+0x31c>
ffffffffc0200414:	ca3ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200418:	706c                	ld	a1,224(s0)
ffffffffc020041a:	00004517          	auipc	a0,0x4
ffffffffc020041e:	c0650513          	addi	a0,a0,-1018 # ffffffffc0204020 <etext+0x334>
ffffffffc0200422:	c95ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200426:	746c                	ld	a1,232(s0)
ffffffffc0200428:	00004517          	auipc	a0,0x4
ffffffffc020042c:	c1050513          	addi	a0,a0,-1008 # ffffffffc0204038 <etext+0x34c>
ffffffffc0200430:	c87ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200434:	786c                	ld	a1,240(s0)
ffffffffc0200436:	00004517          	auipc	a0,0x4
ffffffffc020043a:	c1a50513          	addi	a0,a0,-998 # ffffffffc0204050 <etext+0x364>
ffffffffc020043e:	c79ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200442:	7c6c                	ld	a1,248(s0)
ffffffffc0200444:	6402                	ld	s0,0(sp)
ffffffffc0200446:	60a2                	ld	ra,8(sp)
ffffffffc0200448:	00004517          	auipc	a0,0x4
ffffffffc020044c:	c2050513          	addi	a0,a0,-992 # ffffffffc0204068 <etext+0x37c>
ffffffffc0200450:	0141                	addi	sp,sp,16
ffffffffc0200452:	b195                	j	ffffffffc02000b6 <cprintf>

ffffffffc0200454 <print_trapframe>:
ffffffffc0200454:	1141                	addi	sp,sp,-16
ffffffffc0200456:	e022                	sd	s0,0(sp)
ffffffffc0200458:	85aa                	mv	a1,a0
ffffffffc020045a:	842a                	mv	s0,a0
ffffffffc020045c:	00004517          	auipc	a0,0x4
ffffffffc0200460:	c2450513          	addi	a0,a0,-988 # ffffffffc0204080 <etext+0x394>
ffffffffc0200464:	e406                	sd	ra,8(sp)
ffffffffc0200466:	c51ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020046a:	8522                	mv	a0,s0
ffffffffc020046c:	e1dff0ef          	jal	ra,ffffffffc0200288 <print_regs>
ffffffffc0200470:	10043583          	ld	a1,256(s0)
ffffffffc0200474:	00004517          	auipc	a0,0x4
ffffffffc0200478:	c2450513          	addi	a0,a0,-988 # ffffffffc0204098 <etext+0x3ac>
ffffffffc020047c:	c3bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200480:	10843583          	ld	a1,264(s0)
ffffffffc0200484:	00004517          	auipc	a0,0x4
ffffffffc0200488:	c2c50513          	addi	a0,a0,-980 # ffffffffc02040b0 <etext+0x3c4>
ffffffffc020048c:	c2bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200490:	11043583          	ld	a1,272(s0)
ffffffffc0200494:	00004517          	auipc	a0,0x4
ffffffffc0200498:	c3450513          	addi	a0,a0,-972 # ffffffffc02040c8 <etext+0x3dc>
ffffffffc020049c:	c1bff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02004a0:	11843583          	ld	a1,280(s0)
ffffffffc02004a4:	6402                	ld	s0,0(sp)
ffffffffc02004a6:	60a2                	ld	ra,8(sp)
ffffffffc02004a8:	00004517          	auipc	a0,0x4
ffffffffc02004ac:	c3850513          	addi	a0,a0,-968 # ffffffffc02040e0 <etext+0x3f4>
ffffffffc02004b0:	0141                	addi	sp,sp,16
ffffffffc02004b2:	b111                	j	ffffffffc02000b6 <cprintf>

ffffffffc02004b4 <interrupt_handler>:
ffffffffc02004b4:	11853783          	ld	a5,280(a0)
ffffffffc02004b8:	472d                	li	a4,11
ffffffffc02004ba:	0786                	slli	a5,a5,0x1
ffffffffc02004bc:	8385                	srli	a5,a5,0x1
ffffffffc02004be:	06f76763          	bltu	a4,a5,ffffffffc020052c <interrupt_handler+0x78>
ffffffffc02004c2:	00004717          	auipc	a4,0x4
ffffffffc02004c6:	ce670713          	addi	a4,a4,-794 # ffffffffc02041a8 <etext+0x4bc>
ffffffffc02004ca:	078a                	slli	a5,a5,0x2
ffffffffc02004cc:	97ba                	add	a5,a5,a4
ffffffffc02004ce:	439c                	lw	a5,0(a5)
ffffffffc02004d0:	97ba                	add	a5,a5,a4
ffffffffc02004d2:	8782                	jr	a5
ffffffffc02004d4:	00004517          	auipc	a0,0x4
ffffffffc02004d8:	c8450513          	addi	a0,a0,-892 # ffffffffc0204158 <etext+0x46c>
ffffffffc02004dc:	bee9                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004de:	00004517          	auipc	a0,0x4
ffffffffc02004e2:	c5a50513          	addi	a0,a0,-934 # ffffffffc0204138 <etext+0x44c>
ffffffffc02004e6:	bec1                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004e8:	00004517          	auipc	a0,0x4
ffffffffc02004ec:	c1050513          	addi	a0,a0,-1008 # ffffffffc02040f8 <etext+0x40c>
ffffffffc02004f0:	b6d9                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004f2:	00004517          	auipc	a0,0x4
ffffffffc02004f6:	c2650513          	addi	a0,a0,-986 # ffffffffc0204118 <etext+0x42c>
ffffffffc02004fa:	be75                	j	ffffffffc02000b6 <cprintf>
ffffffffc02004fc:	1141                	addi	sp,sp,-16
ffffffffc02004fe:	e406                	sd	ra,8(sp)
ffffffffc0200500:	ca1ff0ef          	jal	ra,ffffffffc02001a0 <clock_set_next_event>
ffffffffc0200504:	00010697          	auipc	a3,0x10
ffffffffc0200508:	b7468693          	addi	a3,a3,-1164 # ffffffffc0210078 <ticks>
ffffffffc020050c:	629c                	ld	a5,0(a3)
ffffffffc020050e:	06400713          	li	a4,100
ffffffffc0200512:	0785                	addi	a5,a5,1
ffffffffc0200514:	02e7f733          	remu	a4,a5,a4
ffffffffc0200518:	e29c                	sd	a5,0(a3)
ffffffffc020051a:	cb11                	beqz	a4,ffffffffc020052e <interrupt_handler+0x7a>
ffffffffc020051c:	60a2                	ld	ra,8(sp)
ffffffffc020051e:	0141                	addi	sp,sp,16
ffffffffc0200520:	8082                	ret
ffffffffc0200522:	00004517          	auipc	a0,0x4
ffffffffc0200526:	c6650513          	addi	a0,a0,-922 # ffffffffc0204188 <etext+0x49c>
ffffffffc020052a:	b671                	j	ffffffffc02000b6 <cprintf>
ffffffffc020052c:	b725                	j	ffffffffc0200454 <print_trapframe>
ffffffffc020052e:	60a2                	ld	ra,8(sp)
ffffffffc0200530:	06400593          	li	a1,100
ffffffffc0200534:	00004517          	auipc	a0,0x4
ffffffffc0200538:	c4450513          	addi	a0,a0,-956 # ffffffffc0204178 <etext+0x48c>
ffffffffc020053c:	0141                	addi	sp,sp,16
ffffffffc020053e:	bea5                	j	ffffffffc02000b6 <cprintf>

ffffffffc0200540 <exception_handler>:
ffffffffc0200540:	11853783          	ld	a5,280(a0)
ffffffffc0200544:	1101                	addi	sp,sp,-32
ffffffffc0200546:	e822                	sd	s0,16(sp)
ffffffffc0200548:	ec06                	sd	ra,24(sp)
ffffffffc020054a:	e426                	sd	s1,8(sp)
ffffffffc020054c:	473d                	li	a4,15
ffffffffc020054e:	842a                	mv	s0,a0
ffffffffc0200550:	14f76963          	bltu	a4,a5,ffffffffc02006a2 <exception_handler+0x162>
ffffffffc0200554:	00004717          	auipc	a4,0x4
ffffffffc0200558:	e3c70713          	addi	a4,a4,-452 # ffffffffc0204390 <etext+0x6a4>
ffffffffc020055c:	078a                	slli	a5,a5,0x2
ffffffffc020055e:	97ba                	add	a5,a5,a4
ffffffffc0200560:	439c                	lw	a5,0(a5)
ffffffffc0200562:	97ba                	add	a5,a5,a4
ffffffffc0200564:	8782                	jr	a5
ffffffffc0200566:	00004517          	auipc	a0,0x4
ffffffffc020056a:	e1250513          	addi	a0,a0,-494 # ffffffffc0204378 <etext+0x68c>
ffffffffc020056e:	b49ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200572:	8522                	mv	a0,s0
ffffffffc0200574:	c87ff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc0200578:	84aa                	mv	s1,a0
ffffffffc020057a:	12051a63          	bnez	a0,ffffffffc02006ae <exception_handler+0x16e>
ffffffffc020057e:	60e2                	ld	ra,24(sp)
ffffffffc0200580:	6442                	ld	s0,16(sp)
ffffffffc0200582:	64a2                	ld	s1,8(sp)
ffffffffc0200584:	6105                	addi	sp,sp,32
ffffffffc0200586:	8082                	ret
ffffffffc0200588:	00004517          	auipc	a0,0x4
ffffffffc020058c:	c5050513          	addi	a0,a0,-944 # ffffffffc02041d8 <etext+0x4ec>
ffffffffc0200590:	6442                	ld	s0,16(sp)
ffffffffc0200592:	60e2                	ld	ra,24(sp)
ffffffffc0200594:	64a2                	ld	s1,8(sp)
ffffffffc0200596:	6105                	addi	sp,sp,32
ffffffffc0200598:	be39                	j	ffffffffc02000b6 <cprintf>
ffffffffc020059a:	00004517          	auipc	a0,0x4
ffffffffc020059e:	c5e50513          	addi	a0,a0,-930 # ffffffffc02041f8 <etext+0x50c>
ffffffffc02005a2:	b7fd                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005a4:	00004517          	auipc	a0,0x4
ffffffffc02005a8:	c7450513          	addi	a0,a0,-908 # ffffffffc0204218 <etext+0x52c>
ffffffffc02005ac:	b7d5                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005ae:	00004517          	auipc	a0,0x4
ffffffffc02005b2:	c8250513          	addi	a0,a0,-894 # ffffffffc0204230 <etext+0x544>
ffffffffc02005b6:	bfe9                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005b8:	00004517          	auipc	a0,0x4
ffffffffc02005bc:	c8850513          	addi	a0,a0,-888 # ffffffffc0204240 <etext+0x554>
ffffffffc02005c0:	bfc1                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc02005c2:	00004517          	auipc	a0,0x4
ffffffffc02005c6:	c9e50513          	addi	a0,a0,-866 # ffffffffc0204260 <etext+0x574>
ffffffffc02005ca:	aedff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02005ce:	8522                	mv	a0,s0
ffffffffc02005d0:	c2bff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc02005d4:	84aa                	mv	s1,a0
ffffffffc02005d6:	d545                	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc02005d8:	8522                	mv	a0,s0
ffffffffc02005da:	e7bff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc02005de:	86a6                	mv	a3,s1
ffffffffc02005e0:	00004617          	auipc	a2,0x4
ffffffffc02005e4:	c9860613          	addi	a2,a2,-872 # ffffffffc0204278 <etext+0x58c>
ffffffffc02005e8:	0af00593          	li	a1,175
ffffffffc02005ec:	00003517          	auipc	a0,0x3
ffffffffc02005f0:	77c50513          	addi	a0,a0,1916 # ffffffffc0203d68 <etext+0x7c>
ffffffffc02005f4:	af9ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02005f8:	00004517          	auipc	a0,0x4
ffffffffc02005fc:	ca050513          	addi	a0,a0,-864 # ffffffffc0204298 <etext+0x5ac>
ffffffffc0200600:	bf41                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200602:	00004517          	auipc	a0,0x4
ffffffffc0200606:	cae50513          	addi	a0,a0,-850 # ffffffffc02042b0 <etext+0x5c4>
ffffffffc020060a:	aadff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020060e:	8522                	mv	a0,s0
ffffffffc0200610:	bebff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc0200614:	84aa                	mv	s1,a0
ffffffffc0200616:	d525                	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc0200618:	8522                	mv	a0,s0
ffffffffc020061a:	e3bff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc020061e:	86a6                	mv	a3,s1
ffffffffc0200620:	00004617          	auipc	a2,0x4
ffffffffc0200624:	c5860613          	addi	a2,a2,-936 # ffffffffc0204278 <etext+0x58c>
ffffffffc0200628:	0b900593          	li	a1,185
ffffffffc020062c:	00003517          	auipc	a0,0x3
ffffffffc0200630:	73c50513          	addi	a0,a0,1852 # ffffffffc0203d68 <etext+0x7c>
ffffffffc0200634:	ab9ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200638:	00004517          	auipc	a0,0x4
ffffffffc020063c:	c9050513          	addi	a0,a0,-880 # ffffffffc02042c8 <etext+0x5dc>
ffffffffc0200640:	bf81                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200642:	00004517          	auipc	a0,0x4
ffffffffc0200646:	ca650513          	addi	a0,a0,-858 # ffffffffc02042e8 <etext+0x5fc>
ffffffffc020064a:	b799                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc020064c:	00004517          	auipc	a0,0x4
ffffffffc0200650:	cbc50513          	addi	a0,a0,-836 # ffffffffc0204308 <etext+0x61c>
ffffffffc0200654:	bf35                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200656:	00004517          	auipc	a0,0x4
ffffffffc020065a:	cd250513          	addi	a0,a0,-814 # ffffffffc0204328 <etext+0x63c>
ffffffffc020065e:	bf0d                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc0200660:	00004517          	auipc	a0,0x4
ffffffffc0200664:	ce850513          	addi	a0,a0,-792 # ffffffffc0204348 <etext+0x65c>
ffffffffc0200668:	b725                	j	ffffffffc0200590 <exception_handler+0x50>
ffffffffc020066a:	00004517          	auipc	a0,0x4
ffffffffc020066e:	cf650513          	addi	a0,a0,-778 # ffffffffc0204360 <etext+0x674>
ffffffffc0200672:	a45ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200676:	8522                	mv	a0,s0
ffffffffc0200678:	b83ff0ef          	jal	ra,ffffffffc02001fa <pgfault_handler>
ffffffffc020067c:	84aa                	mv	s1,a0
ffffffffc020067e:	f00500e3          	beqz	a0,ffffffffc020057e <exception_handler+0x3e>
ffffffffc0200682:	8522                	mv	a0,s0
ffffffffc0200684:	dd1ff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc0200688:	86a6                	mv	a3,s1
ffffffffc020068a:	00004617          	auipc	a2,0x4
ffffffffc020068e:	bee60613          	addi	a2,a2,-1042 # ffffffffc0204278 <etext+0x58c>
ffffffffc0200692:	0cf00593          	li	a1,207
ffffffffc0200696:	00003517          	auipc	a0,0x3
ffffffffc020069a:	6d250513          	addi	a0,a0,1746 # ffffffffc0203d68 <etext+0x7c>
ffffffffc020069e:	a4fff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02006a2:	8522                	mv	a0,s0
ffffffffc02006a4:	6442                	ld	s0,16(sp)
ffffffffc02006a6:	60e2                	ld	ra,24(sp)
ffffffffc02006a8:	64a2                	ld	s1,8(sp)
ffffffffc02006aa:	6105                	addi	sp,sp,32
ffffffffc02006ac:	b365                	j	ffffffffc0200454 <print_trapframe>
ffffffffc02006ae:	8522                	mv	a0,s0
ffffffffc02006b0:	da5ff0ef          	jal	ra,ffffffffc0200454 <print_trapframe>
ffffffffc02006b4:	86a6                	mv	a3,s1
ffffffffc02006b6:	00004617          	auipc	a2,0x4
ffffffffc02006ba:	bc260613          	addi	a2,a2,-1086 # ffffffffc0204278 <etext+0x58c>
ffffffffc02006be:	0d600593          	li	a1,214
ffffffffc02006c2:	00003517          	auipc	a0,0x3
ffffffffc02006c6:	6a650513          	addi	a0,a0,1702 # ffffffffc0203d68 <etext+0x7c>
ffffffffc02006ca:	a23ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02006ce <trap>:
ffffffffc02006ce:	11853783          	ld	a5,280(a0)
ffffffffc02006d2:	0007c363          	bltz	a5,ffffffffc02006d8 <trap+0xa>
ffffffffc02006d6:	b5ad                	j	ffffffffc0200540 <exception_handler>
ffffffffc02006d8:	bbf1                	j	ffffffffc02004b4 <interrupt_handler>
ffffffffc02006da:	0000                	unimp
ffffffffc02006dc:	0000                	unimp
	...

ffffffffc02006e0 <__alltraps>:
ffffffffc02006e0:	14011073          	csrw	sscratch,sp
ffffffffc02006e4:	712d                	addi	sp,sp,-288
ffffffffc02006e6:	e406                	sd	ra,8(sp)
ffffffffc02006e8:	ec0e                	sd	gp,24(sp)
ffffffffc02006ea:	f012                	sd	tp,32(sp)
ffffffffc02006ec:	f416                	sd	t0,40(sp)
ffffffffc02006ee:	f81a                	sd	t1,48(sp)
ffffffffc02006f0:	fc1e                	sd	t2,56(sp)
ffffffffc02006f2:	e0a2                	sd	s0,64(sp)
ffffffffc02006f4:	e4a6                	sd	s1,72(sp)
ffffffffc02006f6:	e8aa                	sd	a0,80(sp)
ffffffffc02006f8:	ecae                	sd	a1,88(sp)
ffffffffc02006fa:	f0b2                	sd	a2,96(sp)
ffffffffc02006fc:	f4b6                	sd	a3,104(sp)
ffffffffc02006fe:	f8ba                	sd	a4,112(sp)
ffffffffc0200700:	fcbe                	sd	a5,120(sp)
ffffffffc0200702:	e142                	sd	a6,128(sp)
ffffffffc0200704:	e546                	sd	a7,136(sp)
ffffffffc0200706:	e94a                	sd	s2,144(sp)
ffffffffc0200708:	ed4e                	sd	s3,152(sp)
ffffffffc020070a:	f152                	sd	s4,160(sp)
ffffffffc020070c:	f556                	sd	s5,168(sp)
ffffffffc020070e:	f95a                	sd	s6,176(sp)
ffffffffc0200710:	fd5e                	sd	s7,184(sp)
ffffffffc0200712:	e1e2                	sd	s8,192(sp)
ffffffffc0200714:	e5e6                	sd	s9,200(sp)
ffffffffc0200716:	e9ea                	sd	s10,208(sp)
ffffffffc0200718:	edee                	sd	s11,216(sp)
ffffffffc020071a:	f1f2                	sd	t3,224(sp)
ffffffffc020071c:	f5f6                	sd	t4,232(sp)
ffffffffc020071e:	f9fa                	sd	t5,240(sp)
ffffffffc0200720:	fdfe                	sd	t6,248(sp)
ffffffffc0200722:	14002473          	csrr	s0,sscratch
ffffffffc0200726:	100024f3          	csrr	s1,sstatus
ffffffffc020072a:	14102973          	csrr	s2,sepc
ffffffffc020072e:	143029f3          	csrr	s3,stval
ffffffffc0200732:	14202a73          	csrr	s4,scause
ffffffffc0200736:	e822                	sd	s0,16(sp)
ffffffffc0200738:	e226                	sd	s1,256(sp)
ffffffffc020073a:	e64a                	sd	s2,264(sp)
ffffffffc020073c:	ea4e                	sd	s3,272(sp)
ffffffffc020073e:	ee52                	sd	s4,280(sp)
ffffffffc0200740:	850a                	mv	a0,sp
ffffffffc0200742:	f8dff0ef          	jal	ra,ffffffffc02006ce <trap>

ffffffffc0200746 <__trapret>:
ffffffffc0200746:	6492                	ld	s1,256(sp)
ffffffffc0200748:	6932                	ld	s2,264(sp)
ffffffffc020074a:	10049073          	csrw	sstatus,s1
ffffffffc020074e:	14191073          	csrw	sepc,s2
ffffffffc0200752:	60a2                	ld	ra,8(sp)
ffffffffc0200754:	61e2                	ld	gp,24(sp)
ffffffffc0200756:	7202                	ld	tp,32(sp)
ffffffffc0200758:	72a2                	ld	t0,40(sp)
ffffffffc020075a:	7342                	ld	t1,48(sp)
ffffffffc020075c:	73e2                	ld	t2,56(sp)
ffffffffc020075e:	6406                	ld	s0,64(sp)
ffffffffc0200760:	64a6                	ld	s1,72(sp)
ffffffffc0200762:	6546                	ld	a0,80(sp)
ffffffffc0200764:	65e6                	ld	a1,88(sp)
ffffffffc0200766:	7606                	ld	a2,96(sp)
ffffffffc0200768:	76a6                	ld	a3,104(sp)
ffffffffc020076a:	7746                	ld	a4,112(sp)
ffffffffc020076c:	77e6                	ld	a5,120(sp)
ffffffffc020076e:	680a                	ld	a6,128(sp)
ffffffffc0200770:	68aa                	ld	a7,136(sp)
ffffffffc0200772:	694a                	ld	s2,144(sp)
ffffffffc0200774:	69ea                	ld	s3,152(sp)
ffffffffc0200776:	7a0a                	ld	s4,160(sp)
ffffffffc0200778:	7aaa                	ld	s5,168(sp)
ffffffffc020077a:	7b4a                	ld	s6,176(sp)
ffffffffc020077c:	7bea                	ld	s7,184(sp)
ffffffffc020077e:	6c0e                	ld	s8,192(sp)
ffffffffc0200780:	6cae                	ld	s9,200(sp)
ffffffffc0200782:	6d4e                	ld	s10,208(sp)
ffffffffc0200784:	6dee                	ld	s11,216(sp)
ffffffffc0200786:	7e0e                	ld	t3,224(sp)
ffffffffc0200788:	7eae                	ld	t4,232(sp)
ffffffffc020078a:	7f4e                	ld	t5,240(sp)
ffffffffc020078c:	7fee                	ld	t6,248(sp)
ffffffffc020078e:	6142                	ld	sp,16(sp)
ffffffffc0200790:	10200073          	sret
	...

ffffffffc02007a0 <pa2page.part.0>:
ffffffffc02007a0:	1141                	addi	sp,sp,-16
ffffffffc02007a2:	00004617          	auipc	a2,0x4
ffffffffc02007a6:	c2e60613          	addi	a2,a2,-978 # ffffffffc02043d0 <etext+0x6e4>
ffffffffc02007aa:	06500593          	li	a1,101
ffffffffc02007ae:	00004517          	auipc	a0,0x4
ffffffffc02007b2:	c4250513          	addi	a0,a0,-958 # ffffffffc02043f0 <etext+0x704>
ffffffffc02007b6:	e406                	sd	ra,8(sp)
ffffffffc02007b8:	935ff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02007bc <alloc_pages>:
ffffffffc02007bc:	7139                	addi	sp,sp,-64
ffffffffc02007be:	f426                	sd	s1,40(sp)
ffffffffc02007c0:	f04a                	sd	s2,32(sp)
ffffffffc02007c2:	ec4e                	sd	s3,24(sp)
ffffffffc02007c4:	e852                	sd	s4,16(sp)
ffffffffc02007c6:	e456                	sd	s5,8(sp)
ffffffffc02007c8:	e05a                	sd	s6,0(sp)
ffffffffc02007ca:	fc06                	sd	ra,56(sp)
ffffffffc02007cc:	f822                	sd	s0,48(sp)
ffffffffc02007ce:	84aa                	mv	s1,a0
ffffffffc02007d0:	00010917          	auipc	s2,0x10
ffffffffc02007d4:	8c890913          	addi	s2,s2,-1848 # ffffffffc0210098 <pmm_manager>
ffffffffc02007d8:	4a05                	li	s4,1
ffffffffc02007da:	00010a97          	auipc	s5,0x10
ffffffffc02007de:	896a8a93          	addi	s5,s5,-1898 # ffffffffc0210070 <swap_init_ok>
ffffffffc02007e2:	0005099b          	sext.w	s3,a0
ffffffffc02007e6:	00010b17          	auipc	s6,0x10
ffffffffc02007ea:	8d2b0b13          	addi	s6,s6,-1838 # ffffffffc02100b8 <check_mm_struct>
ffffffffc02007ee:	a01d                	j	ffffffffc0200814 <alloc_pages+0x58>
ffffffffc02007f0:	00093783          	ld	a5,0(s2)
ffffffffc02007f4:	6f9c                	ld	a5,24(a5)
ffffffffc02007f6:	9782                	jalr	a5
ffffffffc02007f8:	842a                	mv	s0,a0
ffffffffc02007fa:	4601                	li	a2,0
ffffffffc02007fc:	85ce                	mv	a1,s3
ffffffffc02007fe:	ec0d                	bnez	s0,ffffffffc0200838 <alloc_pages+0x7c>
ffffffffc0200800:	029a6c63          	bltu	s4,s1,ffffffffc0200838 <alloc_pages+0x7c>
ffffffffc0200804:	000aa783          	lw	a5,0(s5)
ffffffffc0200808:	2781                	sext.w	a5,a5
ffffffffc020080a:	c79d                	beqz	a5,ffffffffc0200838 <alloc_pages+0x7c>
ffffffffc020080c:	000b3503          	ld	a0,0(s6)
ffffffffc0200810:	607010ef          	jal	ra,ffffffffc0202616 <swap_out>
ffffffffc0200814:	100027f3          	csrr	a5,sstatus
ffffffffc0200818:	8b89                	andi	a5,a5,2
ffffffffc020081a:	8526                	mv	a0,s1
ffffffffc020081c:	dbf1                	beqz	a5,ffffffffc02007f0 <alloc_pages+0x34>
ffffffffc020081e:	9d7ff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200822:	00093783          	ld	a5,0(s2)
ffffffffc0200826:	8526                	mv	a0,s1
ffffffffc0200828:	6f9c                	ld	a5,24(a5)
ffffffffc020082a:	9782                	jalr	a5
ffffffffc020082c:	842a                	mv	s0,a0
ffffffffc020082e:	9c1ff0ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc0200832:	4601                	li	a2,0
ffffffffc0200834:	85ce                	mv	a1,s3
ffffffffc0200836:	d469                	beqz	s0,ffffffffc0200800 <alloc_pages+0x44>
ffffffffc0200838:	70e2                	ld	ra,56(sp)
ffffffffc020083a:	8522                	mv	a0,s0
ffffffffc020083c:	7442                	ld	s0,48(sp)
ffffffffc020083e:	74a2                	ld	s1,40(sp)
ffffffffc0200840:	7902                	ld	s2,32(sp)
ffffffffc0200842:	69e2                	ld	s3,24(sp)
ffffffffc0200844:	6a42                	ld	s4,16(sp)
ffffffffc0200846:	6aa2                	ld	s5,8(sp)
ffffffffc0200848:	6b02                	ld	s6,0(sp)
ffffffffc020084a:	6121                	addi	sp,sp,64
ffffffffc020084c:	8082                	ret

ffffffffc020084e <free_pages>:
ffffffffc020084e:	100027f3          	csrr	a5,sstatus
ffffffffc0200852:	8b89                	andi	a5,a5,2
ffffffffc0200854:	eb81                	bnez	a5,ffffffffc0200864 <free_pages+0x16>
ffffffffc0200856:	00010797          	auipc	a5,0x10
ffffffffc020085a:	8427b783          	ld	a5,-1982(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc020085e:	0207b303          	ld	t1,32(a5)
ffffffffc0200862:	8302                	jr	t1
ffffffffc0200864:	1101                	addi	sp,sp,-32
ffffffffc0200866:	ec06                	sd	ra,24(sp)
ffffffffc0200868:	e822                	sd	s0,16(sp)
ffffffffc020086a:	e426                	sd	s1,8(sp)
ffffffffc020086c:	842a                	mv	s0,a0
ffffffffc020086e:	84ae                	mv	s1,a1
ffffffffc0200870:	985ff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc0200874:	00010797          	auipc	a5,0x10
ffffffffc0200878:	8247b783          	ld	a5,-2012(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc020087c:	739c                	ld	a5,32(a5)
ffffffffc020087e:	85a6                	mv	a1,s1
ffffffffc0200880:	8522                	mv	a0,s0
ffffffffc0200882:	9782                	jalr	a5
ffffffffc0200884:	6442                	ld	s0,16(sp)
ffffffffc0200886:	60e2                	ld	ra,24(sp)
ffffffffc0200888:	64a2                	ld	s1,8(sp)
ffffffffc020088a:	6105                	addi	sp,sp,32
ffffffffc020088c:	963ff06f          	j	ffffffffc02001ee <intr_enable>

ffffffffc0200890 <nr_free_pages>:
ffffffffc0200890:	100027f3          	csrr	a5,sstatus
ffffffffc0200894:	8b89                	andi	a5,a5,2
ffffffffc0200896:	eb81                	bnez	a5,ffffffffc02008a6 <nr_free_pages+0x16>
ffffffffc0200898:	00010797          	auipc	a5,0x10
ffffffffc020089c:	8007b783          	ld	a5,-2048(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc02008a0:	0287b303          	ld	t1,40(a5)
ffffffffc02008a4:	8302                	jr	t1
ffffffffc02008a6:	1141                	addi	sp,sp,-16
ffffffffc02008a8:	e406                	sd	ra,8(sp)
ffffffffc02008aa:	e022                	sd	s0,0(sp)
ffffffffc02008ac:	949ff0ef          	jal	ra,ffffffffc02001f4 <intr_disable>
ffffffffc02008b0:	0000f797          	auipc	a5,0xf
ffffffffc02008b4:	7e87b783          	ld	a5,2024(a5) # ffffffffc0210098 <pmm_manager>
ffffffffc02008b8:	779c                	ld	a5,40(a5)
ffffffffc02008ba:	9782                	jalr	a5
ffffffffc02008bc:	842a                	mv	s0,a0
ffffffffc02008be:	931ff0ef          	jal	ra,ffffffffc02001ee <intr_enable>
ffffffffc02008c2:	60a2                	ld	ra,8(sp)
ffffffffc02008c4:	8522                	mv	a0,s0
ffffffffc02008c6:	6402                	ld	s0,0(sp)
ffffffffc02008c8:	0141                	addi	sp,sp,16
ffffffffc02008ca:	8082                	ret

ffffffffc02008cc <get_pte>:
ffffffffc02008cc:	01e5d793          	srli	a5,a1,0x1e
ffffffffc02008d0:	1ff7f793          	andi	a5,a5,511
ffffffffc02008d4:	715d                	addi	sp,sp,-80
ffffffffc02008d6:	078e                	slli	a5,a5,0x3
ffffffffc02008d8:	fc26                	sd	s1,56(sp)
ffffffffc02008da:	00f504b3          	add	s1,a0,a5
ffffffffc02008de:	6094                	ld	a3,0(s1)
ffffffffc02008e0:	f84a                	sd	s2,48(sp)
ffffffffc02008e2:	f44e                	sd	s3,40(sp)
ffffffffc02008e4:	f052                	sd	s4,32(sp)
ffffffffc02008e6:	e486                	sd	ra,72(sp)
ffffffffc02008e8:	e0a2                	sd	s0,64(sp)
ffffffffc02008ea:	ec56                	sd	s5,24(sp)
ffffffffc02008ec:	e85a                	sd	s6,16(sp)
ffffffffc02008ee:	e45e                	sd	s7,8(sp)
ffffffffc02008f0:	0016f793          	andi	a5,a3,1
ffffffffc02008f4:	892e                	mv	s2,a1
ffffffffc02008f6:	8a32                	mv	s4,a2
ffffffffc02008f8:	0000f997          	auipc	s3,0xf
ffffffffc02008fc:	76098993          	addi	s3,s3,1888 # ffffffffc0210058 <npage>
ffffffffc0200900:	efb5                	bnez	a5,ffffffffc020097c <get_pte+0xb0>
ffffffffc0200902:	14060c63          	beqz	a2,ffffffffc0200a5a <get_pte+0x18e>
ffffffffc0200906:	4505                	li	a0,1
ffffffffc0200908:	eb5ff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc020090c:	842a                	mv	s0,a0
ffffffffc020090e:	14050663          	beqz	a0,ffffffffc0200a5a <get_pte+0x18e>
ffffffffc0200912:	0000fb97          	auipc	s7,0xf
ffffffffc0200916:	79eb8b93          	addi	s7,s7,1950 # ffffffffc02100b0 <pages>
ffffffffc020091a:	000bb503          	ld	a0,0(s7)
ffffffffc020091e:	00005b17          	auipc	s6,0x5
ffffffffc0200922:	fcab3b03          	ld	s6,-54(s6) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0200926:	00080ab7          	lui	s5,0x80
ffffffffc020092a:	40a40533          	sub	a0,s0,a0
ffffffffc020092e:	850d                	srai	a0,a0,0x3
ffffffffc0200930:	03650533          	mul	a0,a0,s6
ffffffffc0200934:	0000f997          	auipc	s3,0xf
ffffffffc0200938:	72498993          	addi	s3,s3,1828 # ffffffffc0210058 <npage>
ffffffffc020093c:	4785                	li	a5,1
ffffffffc020093e:	0009b703          	ld	a4,0(s3)
ffffffffc0200942:	c01c                	sw	a5,0(s0)
ffffffffc0200944:	9556                	add	a0,a0,s5
ffffffffc0200946:	00c51793          	slli	a5,a0,0xc
ffffffffc020094a:	83b1                	srli	a5,a5,0xc
ffffffffc020094c:	0532                	slli	a0,a0,0xc
ffffffffc020094e:	14e7fd63          	bgeu	a5,a4,ffffffffc0200aa8 <get_pte+0x1dc>
ffffffffc0200952:	0000f797          	auipc	a5,0xf
ffffffffc0200956:	7567b783          	ld	a5,1878(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc020095a:	6605                	lui	a2,0x1
ffffffffc020095c:	4581                	li	a1,0
ffffffffc020095e:	953e                	add	a0,a0,a5
ffffffffc0200960:	775020ef          	jal	ra,ffffffffc02038d4 <memset>
ffffffffc0200964:	000bb683          	ld	a3,0(s7)
ffffffffc0200968:	40d406b3          	sub	a3,s0,a3
ffffffffc020096c:	868d                	srai	a3,a3,0x3
ffffffffc020096e:	036686b3          	mul	a3,a3,s6
ffffffffc0200972:	96d6                	add	a3,a3,s5
ffffffffc0200974:	06aa                	slli	a3,a3,0xa
ffffffffc0200976:	0116e693          	ori	a3,a3,17
ffffffffc020097a:	e094                	sd	a3,0(s1)
ffffffffc020097c:	77fd                	lui	a5,0xfffff
ffffffffc020097e:	068a                	slli	a3,a3,0x2
ffffffffc0200980:	0009b703          	ld	a4,0(s3)
ffffffffc0200984:	8efd                	and	a3,a3,a5
ffffffffc0200986:	00c6d793          	srli	a5,a3,0xc
ffffffffc020098a:	0ce7fa63          	bgeu	a5,a4,ffffffffc0200a5e <get_pte+0x192>
ffffffffc020098e:	0000fa97          	auipc	s5,0xf
ffffffffc0200992:	71aa8a93          	addi	s5,s5,1818 # ffffffffc02100a8 <va_pa_offset>
ffffffffc0200996:	000ab403          	ld	s0,0(s5)
ffffffffc020099a:	01595793          	srli	a5,s2,0x15
ffffffffc020099e:	1ff7f793          	andi	a5,a5,511
ffffffffc02009a2:	96a2                	add	a3,a3,s0
ffffffffc02009a4:	00379413          	slli	s0,a5,0x3
ffffffffc02009a8:	9436                	add	s0,s0,a3
ffffffffc02009aa:	6014                	ld	a3,0(s0)
ffffffffc02009ac:	0016f793          	andi	a5,a3,1
ffffffffc02009b0:	ebad                	bnez	a5,ffffffffc0200a22 <get_pte+0x156>
ffffffffc02009b2:	0a0a0463          	beqz	s4,ffffffffc0200a5a <get_pte+0x18e>
ffffffffc02009b6:	4505                	li	a0,1
ffffffffc02009b8:	e05ff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02009bc:	84aa                	mv	s1,a0
ffffffffc02009be:	cd51                	beqz	a0,ffffffffc0200a5a <get_pte+0x18e>
ffffffffc02009c0:	0000fb97          	auipc	s7,0xf
ffffffffc02009c4:	6f0b8b93          	addi	s7,s7,1776 # ffffffffc02100b0 <pages>
ffffffffc02009c8:	000bb503          	ld	a0,0(s7)
ffffffffc02009cc:	00005b17          	auipc	s6,0x5
ffffffffc02009d0:	f1cb3b03          	ld	s6,-228(s6) # ffffffffc02058e8 <error_string+0x38>
ffffffffc02009d4:	00080a37          	lui	s4,0x80
ffffffffc02009d8:	40a48533          	sub	a0,s1,a0
ffffffffc02009dc:	850d                	srai	a0,a0,0x3
ffffffffc02009de:	03650533          	mul	a0,a0,s6
ffffffffc02009e2:	4785                	li	a5,1
ffffffffc02009e4:	0009b703          	ld	a4,0(s3)
ffffffffc02009e8:	c09c                	sw	a5,0(s1)
ffffffffc02009ea:	9552                	add	a0,a0,s4
ffffffffc02009ec:	00c51793          	slli	a5,a0,0xc
ffffffffc02009f0:	83b1                	srli	a5,a5,0xc
ffffffffc02009f2:	0532                	slli	a0,a0,0xc
ffffffffc02009f4:	08e7fd63          	bgeu	a5,a4,ffffffffc0200a8e <get_pte+0x1c2>
ffffffffc02009f8:	000ab783          	ld	a5,0(s5)
ffffffffc02009fc:	6605                	lui	a2,0x1
ffffffffc02009fe:	4581                	li	a1,0
ffffffffc0200a00:	953e                	add	a0,a0,a5
ffffffffc0200a02:	6d3020ef          	jal	ra,ffffffffc02038d4 <memset>
ffffffffc0200a06:	000bb683          	ld	a3,0(s7)
ffffffffc0200a0a:	40d486b3          	sub	a3,s1,a3
ffffffffc0200a0e:	868d                	srai	a3,a3,0x3
ffffffffc0200a10:	036686b3          	mul	a3,a3,s6
ffffffffc0200a14:	96d2                	add	a3,a3,s4
ffffffffc0200a16:	06aa                	slli	a3,a3,0xa
ffffffffc0200a18:	0116e693          	ori	a3,a3,17
ffffffffc0200a1c:	e014                	sd	a3,0(s0)
ffffffffc0200a1e:	0009b703          	ld	a4,0(s3)
ffffffffc0200a22:	068a                	slli	a3,a3,0x2
ffffffffc0200a24:	757d                	lui	a0,0xfffff
ffffffffc0200a26:	8ee9                	and	a3,a3,a0
ffffffffc0200a28:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200a2c:	04e7f563          	bgeu	a5,a4,ffffffffc0200a76 <get_pte+0x1aa>
ffffffffc0200a30:	000ab503          	ld	a0,0(s5)
ffffffffc0200a34:	00c95913          	srli	s2,s2,0xc
ffffffffc0200a38:	1ff97913          	andi	s2,s2,511
ffffffffc0200a3c:	96aa                	add	a3,a3,a0
ffffffffc0200a3e:	00391513          	slli	a0,s2,0x3
ffffffffc0200a42:	9536                	add	a0,a0,a3
ffffffffc0200a44:	60a6                	ld	ra,72(sp)
ffffffffc0200a46:	6406                	ld	s0,64(sp)
ffffffffc0200a48:	74e2                	ld	s1,56(sp)
ffffffffc0200a4a:	7942                	ld	s2,48(sp)
ffffffffc0200a4c:	79a2                	ld	s3,40(sp)
ffffffffc0200a4e:	7a02                	ld	s4,32(sp)
ffffffffc0200a50:	6ae2                	ld	s5,24(sp)
ffffffffc0200a52:	6b42                	ld	s6,16(sp)
ffffffffc0200a54:	6ba2                	ld	s7,8(sp)
ffffffffc0200a56:	6161                	addi	sp,sp,80
ffffffffc0200a58:	8082                	ret
ffffffffc0200a5a:	4501                	li	a0,0
ffffffffc0200a5c:	b7e5                	j	ffffffffc0200a44 <get_pte+0x178>
ffffffffc0200a5e:	00004617          	auipc	a2,0x4
ffffffffc0200a62:	9a260613          	addi	a2,a2,-1630 # ffffffffc0204400 <etext+0x714>
ffffffffc0200a66:	0e800593          	li	a1,232
ffffffffc0200a6a:	00004517          	auipc	a0,0x4
ffffffffc0200a6e:	9be50513          	addi	a0,a0,-1602 # ffffffffc0204428 <etext+0x73c>
ffffffffc0200a72:	e7aff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a76:	00004617          	auipc	a2,0x4
ffffffffc0200a7a:	98a60613          	addi	a2,a2,-1654 # ffffffffc0204400 <etext+0x714>
ffffffffc0200a7e:	0f300593          	li	a1,243
ffffffffc0200a82:	00004517          	auipc	a0,0x4
ffffffffc0200a86:	9a650513          	addi	a0,a0,-1626 # ffffffffc0204428 <etext+0x73c>
ffffffffc0200a8a:	e62ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200a8e:	86aa                	mv	a3,a0
ffffffffc0200a90:	00004617          	auipc	a2,0x4
ffffffffc0200a94:	97060613          	addi	a2,a2,-1680 # ffffffffc0204400 <etext+0x714>
ffffffffc0200a98:	0f000593          	li	a1,240
ffffffffc0200a9c:	00004517          	auipc	a0,0x4
ffffffffc0200aa0:	98c50513          	addi	a0,a0,-1652 # ffffffffc0204428 <etext+0x73c>
ffffffffc0200aa4:	e48ff0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0200aa8:	86aa                	mv	a3,a0
ffffffffc0200aaa:	00004617          	auipc	a2,0x4
ffffffffc0200aae:	95660613          	addi	a2,a2,-1706 # ffffffffc0204400 <etext+0x714>
ffffffffc0200ab2:	0e500593          	li	a1,229
ffffffffc0200ab6:	00004517          	auipc	a0,0x4
ffffffffc0200aba:	97250513          	addi	a0,a0,-1678 # ffffffffc0204428 <etext+0x73c>
ffffffffc0200abe:	e2eff0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0200ac2 <get_page>:
ffffffffc0200ac2:	1141                	addi	sp,sp,-16
ffffffffc0200ac4:	e022                	sd	s0,0(sp)
ffffffffc0200ac6:	8432                	mv	s0,a2
ffffffffc0200ac8:	4601                	li	a2,0
ffffffffc0200aca:	e406                	sd	ra,8(sp)
ffffffffc0200acc:	e01ff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200ad0:	c011                	beqz	s0,ffffffffc0200ad4 <get_page+0x12>
ffffffffc0200ad2:	e008                	sd	a0,0(s0)
ffffffffc0200ad4:	c511                	beqz	a0,ffffffffc0200ae0 <get_page+0x1e>
ffffffffc0200ad6:	611c                	ld	a5,0(a0)
ffffffffc0200ad8:	4501                	li	a0,0
ffffffffc0200ada:	0017f713          	andi	a4,a5,1
ffffffffc0200ade:	e709                	bnez	a4,ffffffffc0200ae8 <get_page+0x26>
ffffffffc0200ae0:	60a2                	ld	ra,8(sp)
ffffffffc0200ae2:	6402                	ld	s0,0(sp)
ffffffffc0200ae4:	0141                	addi	sp,sp,16
ffffffffc0200ae6:	8082                	ret
ffffffffc0200ae8:	078a                	slli	a5,a5,0x2
ffffffffc0200aea:	83b1                	srli	a5,a5,0xc
ffffffffc0200aec:	0000f717          	auipc	a4,0xf
ffffffffc0200af0:	56c73703          	ld	a4,1388(a4) # ffffffffc0210058 <npage>
ffffffffc0200af4:	02e7f263          	bgeu	a5,a4,ffffffffc0200b18 <get_page+0x56>
ffffffffc0200af8:	fff80537          	lui	a0,0xfff80
ffffffffc0200afc:	97aa                	add	a5,a5,a0
ffffffffc0200afe:	60a2                	ld	ra,8(sp)
ffffffffc0200b00:	6402                	ld	s0,0(sp)
ffffffffc0200b02:	00379513          	slli	a0,a5,0x3
ffffffffc0200b06:	97aa                	add	a5,a5,a0
ffffffffc0200b08:	078e                	slli	a5,a5,0x3
ffffffffc0200b0a:	0000f517          	auipc	a0,0xf
ffffffffc0200b0e:	5a653503          	ld	a0,1446(a0) # ffffffffc02100b0 <pages>
ffffffffc0200b12:	953e                	add	a0,a0,a5
ffffffffc0200b14:	0141                	addi	sp,sp,16
ffffffffc0200b16:	8082                	ret
ffffffffc0200b18:	c89ff0ef          	jal	ra,ffffffffc02007a0 <pa2page.part.0>

ffffffffc0200b1c <page_remove>:
ffffffffc0200b1c:	1141                	addi	sp,sp,-16
ffffffffc0200b1e:	4601                	li	a2,0
ffffffffc0200b20:	e406                	sd	ra,8(sp)
ffffffffc0200b22:	e022                	sd	s0,0(sp)
ffffffffc0200b24:	da9ff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200b28:	c511                	beqz	a0,ffffffffc0200b34 <page_remove+0x18>
ffffffffc0200b2a:	611c                	ld	a5,0(a0)
ffffffffc0200b2c:	842a                	mv	s0,a0
ffffffffc0200b2e:	0017f713          	andi	a4,a5,1
ffffffffc0200b32:	e709                	bnez	a4,ffffffffc0200b3c <page_remove+0x20>
ffffffffc0200b34:	60a2                	ld	ra,8(sp)
ffffffffc0200b36:	6402                	ld	s0,0(sp)
ffffffffc0200b38:	0141                	addi	sp,sp,16
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	078a                	slli	a5,a5,0x2
ffffffffc0200b3e:	83b1                	srli	a5,a5,0xc
ffffffffc0200b40:	0000f717          	auipc	a4,0xf
ffffffffc0200b44:	51873703          	ld	a4,1304(a4) # ffffffffc0210058 <npage>
ffffffffc0200b48:	02e7ff63          	bgeu	a5,a4,ffffffffc0200b86 <page_remove+0x6a>
ffffffffc0200b4c:	fff80737          	lui	a4,0xfff80
ffffffffc0200b50:	97ba                	add	a5,a5,a4
ffffffffc0200b52:	00379513          	slli	a0,a5,0x3
ffffffffc0200b56:	97aa                	add	a5,a5,a0
ffffffffc0200b58:	078e                	slli	a5,a5,0x3
ffffffffc0200b5a:	0000f517          	auipc	a0,0xf
ffffffffc0200b5e:	55653503          	ld	a0,1366(a0) # ffffffffc02100b0 <pages>
ffffffffc0200b62:	953e                	add	a0,a0,a5
ffffffffc0200b64:	411c                	lw	a5,0(a0)
ffffffffc0200b66:	fff7871b          	addiw	a4,a5,-1
ffffffffc0200b6a:	c118                	sw	a4,0(a0)
ffffffffc0200b6c:	cb09                	beqz	a4,ffffffffc0200b7e <page_remove+0x62>
ffffffffc0200b6e:	00043023          	sd	zero,0(s0)
ffffffffc0200b72:	12000073          	sfence.vma
ffffffffc0200b76:	60a2                	ld	ra,8(sp)
ffffffffc0200b78:	6402                	ld	s0,0(sp)
ffffffffc0200b7a:	0141                	addi	sp,sp,16
ffffffffc0200b7c:	8082                	ret
ffffffffc0200b7e:	4585                	li	a1,1
ffffffffc0200b80:	ccfff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0200b84:	b7ed                	j	ffffffffc0200b6e <page_remove+0x52>
ffffffffc0200b86:	c1bff0ef          	jal	ra,ffffffffc02007a0 <pa2page.part.0>

ffffffffc0200b8a <page_insert>:
ffffffffc0200b8a:	7179                	addi	sp,sp,-48
ffffffffc0200b8c:	87b2                	mv	a5,a2
ffffffffc0200b8e:	f022                	sd	s0,32(sp)
ffffffffc0200b90:	4605                	li	a2,1
ffffffffc0200b92:	842e                	mv	s0,a1
ffffffffc0200b94:	85be                	mv	a1,a5
ffffffffc0200b96:	ec26                	sd	s1,24(sp)
ffffffffc0200b98:	f406                	sd	ra,40(sp)
ffffffffc0200b9a:	e84a                	sd	s2,16(sp)
ffffffffc0200b9c:	e44e                	sd	s3,8(sp)
ffffffffc0200b9e:	84b6                	mv	s1,a3
ffffffffc0200ba0:	d2dff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200ba4:	c54d                	beqz	a0,ffffffffc0200c4e <page_insert+0xc4>
ffffffffc0200ba6:	4014                	lw	a3,0(s0)
ffffffffc0200ba8:	611c                	ld	a5,0(a0)
ffffffffc0200baa:	892a                	mv	s2,a0
ffffffffc0200bac:	0016871b          	addiw	a4,a3,1
ffffffffc0200bb0:	c018                	sw	a4,0(s0)
ffffffffc0200bb2:	0017f713          	andi	a4,a5,1
ffffffffc0200bb6:	e329                	bnez	a4,ffffffffc0200bf8 <page_insert+0x6e>
ffffffffc0200bb8:	0000f797          	auipc	a5,0xf
ffffffffc0200bbc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02100b0 <pages>
ffffffffc0200bc0:	40f407b3          	sub	a5,s0,a5
ffffffffc0200bc4:	878d                	srai	a5,a5,0x3
ffffffffc0200bc6:	00005417          	auipc	s0,0x5
ffffffffc0200bca:	d2243403          	ld	s0,-734(s0) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0200bce:	028787b3          	mul	a5,a5,s0
ffffffffc0200bd2:	00080437          	lui	s0,0x80
ffffffffc0200bd6:	97a2                	add	a5,a5,s0
ffffffffc0200bd8:	07aa                	slli	a5,a5,0xa
ffffffffc0200bda:	8fc5                	or	a5,a5,s1
ffffffffc0200bdc:	0017e793          	ori	a5,a5,1
ffffffffc0200be0:	00f93023          	sd	a5,0(s2)
ffffffffc0200be4:	12000073          	sfence.vma
ffffffffc0200be8:	4501                	li	a0,0
ffffffffc0200bea:	70a2                	ld	ra,40(sp)
ffffffffc0200bec:	7402                	ld	s0,32(sp)
ffffffffc0200bee:	64e2                	ld	s1,24(sp)
ffffffffc0200bf0:	6942                	ld	s2,16(sp)
ffffffffc0200bf2:	69a2                	ld	s3,8(sp)
ffffffffc0200bf4:	6145                	addi	sp,sp,48
ffffffffc0200bf6:	8082                	ret
ffffffffc0200bf8:	00279513          	slli	a0,a5,0x2
ffffffffc0200bfc:	8131                	srli	a0,a0,0xc
ffffffffc0200bfe:	0000f797          	auipc	a5,0xf
ffffffffc0200c02:	45a7b783          	ld	a5,1114(a5) # ffffffffc0210058 <npage>
ffffffffc0200c06:	04f57663          	bgeu	a0,a5,ffffffffc0200c52 <page_insert+0xc8>
ffffffffc0200c0a:	fff807b7          	lui	a5,0xfff80
ffffffffc0200c0e:	953e                	add	a0,a0,a5
ffffffffc0200c10:	0000f997          	auipc	s3,0xf
ffffffffc0200c14:	4a098993          	addi	s3,s3,1184 # ffffffffc02100b0 <pages>
ffffffffc0200c18:	0009b783          	ld	a5,0(s3)
ffffffffc0200c1c:	00351713          	slli	a4,a0,0x3
ffffffffc0200c20:	953a                	add	a0,a0,a4
ffffffffc0200c22:	050e                	slli	a0,a0,0x3
ffffffffc0200c24:	953e                	add	a0,a0,a5
ffffffffc0200c26:	00a40e63          	beq	s0,a0,ffffffffc0200c42 <page_insert+0xb8>
ffffffffc0200c2a:	411c                	lw	a5,0(a0)
ffffffffc0200c2c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0200c30:	c118                	sw	a4,0(a0)
ffffffffc0200c32:	cb11                	beqz	a4,ffffffffc0200c46 <page_insert+0xbc>
ffffffffc0200c34:	00093023          	sd	zero,0(s2)
ffffffffc0200c38:	12000073          	sfence.vma
ffffffffc0200c3c:	0009b783          	ld	a5,0(s3)
ffffffffc0200c40:	b741                	j	ffffffffc0200bc0 <page_insert+0x36>
ffffffffc0200c42:	c014                	sw	a3,0(s0)
ffffffffc0200c44:	bfb5                	j	ffffffffc0200bc0 <page_insert+0x36>
ffffffffc0200c46:	4585                	li	a1,1
ffffffffc0200c48:	c07ff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0200c4c:	b7e5                	j	ffffffffc0200c34 <page_insert+0xaa>
ffffffffc0200c4e:	5571                	li	a0,-4
ffffffffc0200c50:	bf69                	j	ffffffffc0200bea <page_insert+0x60>
ffffffffc0200c52:	b4fff0ef          	jal	ra,ffffffffc02007a0 <pa2page.part.0>

ffffffffc0200c56 <pmm_init>:
ffffffffc0200c56:	00004797          	auipc	a5,0x4
ffffffffc0200c5a:	7fa78793          	addi	a5,a5,2042 # ffffffffc0205450 <default_pmm_manager>
ffffffffc0200c5e:	638c                	ld	a1,0(a5)
ffffffffc0200c60:	7139                	addi	sp,sp,-64
ffffffffc0200c62:	fc06                	sd	ra,56(sp)
ffffffffc0200c64:	f822                	sd	s0,48(sp)
ffffffffc0200c66:	f426                	sd	s1,40(sp)
ffffffffc0200c68:	f04a                	sd	s2,32(sp)
ffffffffc0200c6a:	ec4e                	sd	s3,24(sp)
ffffffffc0200c6c:	e852                	sd	s4,16(sp)
ffffffffc0200c6e:	e456                	sd	s5,8(sp)
ffffffffc0200c70:	e05a                	sd	s6,0(sp)
ffffffffc0200c72:	0000fa17          	auipc	s4,0xf
ffffffffc0200c76:	426a0a13          	addi	s4,s4,1062 # ffffffffc0210098 <pmm_manager>
ffffffffc0200c7a:	00003517          	auipc	a0,0x3
ffffffffc0200c7e:	7be50513          	addi	a0,a0,1982 # ffffffffc0204438 <etext+0x74c>
ffffffffc0200c82:	00fa3023          	sd	a5,0(s4)
ffffffffc0200c86:	c30ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200c8a:	000a3783          	ld	a5,0(s4)
ffffffffc0200c8e:	40100913          	li	s2,1025
ffffffffc0200c92:	4445                	li	s0,17
ffffffffc0200c94:	679c                	ld	a5,8(a5)
ffffffffc0200c96:	0000f997          	auipc	s3,0xf
ffffffffc0200c9a:	41298993          	addi	s3,s3,1042 # ffffffffc02100a8 <va_pa_offset>
ffffffffc0200c9e:	0000f497          	auipc	s1,0xf
ffffffffc0200ca2:	3ba48493          	addi	s1,s1,954 # ffffffffc0210058 <npage>
ffffffffc0200ca6:	9782                	jalr	a5
ffffffffc0200ca8:	57f5                	li	a5,-3
ffffffffc0200caa:	07fa                	slli	a5,a5,0x1e
ffffffffc0200cac:	01591593          	slli	a1,s2,0x15
ffffffffc0200cb0:	07e006b7          	lui	a3,0x7e00
ffffffffc0200cb4:	01b41613          	slli	a2,s0,0x1b
ffffffffc0200cb8:	00003517          	auipc	a0,0x3
ffffffffc0200cbc:	79850513          	addi	a0,a0,1944 # ffffffffc0204450 <etext+0x764>
ffffffffc0200cc0:	00f9b023          	sd	a5,0(s3)
ffffffffc0200cc4:	bf2ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200cc8:	00003517          	auipc	a0,0x3
ffffffffc0200ccc:	7b850513          	addi	a0,a0,1976 # ffffffffc0204480 <etext+0x794>
ffffffffc0200cd0:	be6ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200cd4:	01b41693          	slli	a3,s0,0x1b
ffffffffc0200cd8:	01591613          	slli	a2,s2,0x15
ffffffffc0200cdc:	16fd                	addi	a3,a3,-1
ffffffffc0200cde:	07e005b7          	lui	a1,0x7e00
ffffffffc0200ce2:	00003517          	auipc	a0,0x3
ffffffffc0200ce6:	7b650513          	addi	a0,a0,1974 # ffffffffc0204498 <etext+0x7ac>
ffffffffc0200cea:	bccff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200cee:	777d                	lui	a4,0xfffff
ffffffffc0200cf0:	00010797          	auipc	a5,0x10
ffffffffc0200cf4:	4af78793          	addi	a5,a5,1199 # ffffffffc021119f <end+0xfff>
ffffffffc0200cf8:	8ff9                	and	a5,a5,a4
ffffffffc0200cfa:	0000f917          	auipc	s2,0xf
ffffffffc0200cfe:	3b690913          	addi	s2,s2,950 # ffffffffc02100b0 <pages>
ffffffffc0200d02:	00088737          	lui	a4,0x88
ffffffffc0200d06:	e098                	sd	a4,0(s1)
ffffffffc0200d08:	00f93023          	sd	a5,0(s2)
ffffffffc0200d0c:	4681                	li	a3,0
ffffffffc0200d0e:	4701                	li	a4,0
ffffffffc0200d10:	4585                	li	a1,1
ffffffffc0200d12:	fff80637          	lui	a2,0xfff80
ffffffffc0200d16:	a019                	j	ffffffffc0200d1c <pmm_init+0xc6>
ffffffffc0200d18:	00093783          	ld	a5,0(s2)
ffffffffc0200d1c:	97b6                	add	a5,a5,a3
ffffffffc0200d1e:	07a1                	addi	a5,a5,8
ffffffffc0200d20:	40b7b02f          	amoor.d	zero,a1,(a5)
ffffffffc0200d24:	609c                	ld	a5,0(s1)
ffffffffc0200d26:	0705                	addi	a4,a4,1
ffffffffc0200d28:	04868693          	addi	a3,a3,72 # 7e00048 <kern_entry-0xffffffffb83fffb8>
ffffffffc0200d2c:	00c78533          	add	a0,a5,a2
ffffffffc0200d30:	fea764e3          	bltu	a4,a0,ffffffffc0200d18 <pmm_init+0xc2>
ffffffffc0200d34:	00093503          	ld	a0,0(s2)
ffffffffc0200d38:	00379693          	slli	a3,a5,0x3
ffffffffc0200d3c:	96be                	add	a3,a3,a5
ffffffffc0200d3e:	fdc00737          	lui	a4,0xfdc00
ffffffffc0200d42:	972a                	add	a4,a4,a0
ffffffffc0200d44:	068e                	slli	a3,a3,0x3
ffffffffc0200d46:	96ba                	add	a3,a3,a4
ffffffffc0200d48:	c0200737          	lui	a4,0xc0200
ffffffffc0200d4c:	68e6ef63          	bltu	a3,a4,ffffffffc02013ea <pmm_init+0x794>
ffffffffc0200d50:	0009b703          	ld	a4,0(s3)
ffffffffc0200d54:	45c5                	li	a1,17
ffffffffc0200d56:	05ee                	slli	a1,a1,0x1b
ffffffffc0200d58:	8e99                	sub	a3,a3,a4
ffffffffc0200d5a:	34b6ec63          	bltu	a3,a1,ffffffffc02010b2 <pmm_init+0x45c>
ffffffffc0200d5e:	000a3783          	ld	a5,0(s4)
ffffffffc0200d62:	0000f417          	auipc	s0,0xf
ffffffffc0200d66:	2ee40413          	addi	s0,s0,750 # ffffffffc0210050 <boot_pgdir>
ffffffffc0200d6a:	7b9c                	ld	a5,48(a5)
ffffffffc0200d6c:	9782                	jalr	a5
ffffffffc0200d6e:	00003517          	auipc	a0,0x3
ffffffffc0200d72:	77a50513          	addi	a0,a0,1914 # ffffffffc02044e8 <etext+0x7fc>
ffffffffc0200d76:	b40ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200d7a:	00007517          	auipc	a0,0x7
ffffffffc0200d7e:	28650513          	addi	a0,a0,646 # ffffffffc0208000 <boot_page_table_sv39>
ffffffffc0200d82:	e008                	sd	a0,0(s0)
ffffffffc0200d84:	c02007b7          	lui	a5,0xc0200
ffffffffc0200d88:	7af56963          	bltu	a0,a5,ffffffffc020153a <pmm_init+0x8e4>
ffffffffc0200d8c:	0009b783          	ld	a5,0(s3)
ffffffffc0200d90:	6098                	ld	a4,0(s1)
ffffffffc0200d92:	40f507b3          	sub	a5,a0,a5
ffffffffc0200d96:	0000f697          	auipc	a3,0xf
ffffffffc0200d9a:	30f6b523          	sd	a5,778(a3) # ffffffffc02100a0 <boot_satp>
ffffffffc0200d9e:	c80007b7          	lui	a5,0xc8000
ffffffffc0200da2:	83b1                	srli	a5,a5,0xc
ffffffffc0200da4:	76e7eb63          	bltu	a5,a4,ffffffffc020151a <pmm_init+0x8c4>
ffffffffc0200da8:	03451793          	slli	a5,a0,0x34
ffffffffc0200dac:	3a079563          	bnez	a5,ffffffffc0201156 <pmm_init+0x500>
ffffffffc0200db0:	4601                	li	a2,0
ffffffffc0200db2:	4581                	li	a1,0
ffffffffc0200db4:	d0fff0ef          	jal	ra,ffffffffc0200ac2 <get_page>
ffffffffc0200db8:	74051163          	bnez	a0,ffffffffc02014fa <pmm_init+0x8a4>
ffffffffc0200dbc:	4505                	li	a0,1
ffffffffc0200dbe:	9ffff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0200dc2:	8a2a                	mv	s4,a0
ffffffffc0200dc4:	6008                	ld	a0,0(s0)
ffffffffc0200dc6:	4681                	li	a3,0
ffffffffc0200dc8:	4601                	li	a2,0
ffffffffc0200dca:	85d2                	mv	a1,s4
ffffffffc0200dcc:	dbfff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0200dd0:	3a051363          	bnez	a0,ffffffffc0201176 <pmm_init+0x520>
ffffffffc0200dd4:	6008                	ld	a0,0(s0)
ffffffffc0200dd6:	4601                	li	a2,0
ffffffffc0200dd8:	4581                	li	a1,0
ffffffffc0200dda:	af3ff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200dde:	7a050b63          	beqz	a0,ffffffffc0201594 <pmm_init+0x93e>
ffffffffc0200de2:	611c                	ld	a5,0(a0)
ffffffffc0200de4:	0017f713          	andi	a4,a5,1
ffffffffc0200de8:	34070b63          	beqz	a4,ffffffffc020113e <pmm_init+0x4e8>
ffffffffc0200dec:	6090                	ld	a2,0(s1)
ffffffffc0200dee:	078a                	slli	a5,a5,0x2
ffffffffc0200df0:	83b1                	srli	a5,a5,0xc
ffffffffc0200df2:	34c7f463          	bgeu	a5,a2,ffffffffc020113a <pmm_init+0x4e4>
ffffffffc0200df6:	fff80737          	lui	a4,0xfff80
ffffffffc0200dfa:	97ba                	add	a5,a5,a4
ffffffffc0200dfc:	00093683          	ld	a3,0(s2)
ffffffffc0200e00:	00379713          	slli	a4,a5,0x3
ffffffffc0200e04:	97ba                	add	a5,a5,a4
ffffffffc0200e06:	078e                	slli	a5,a5,0x3
ffffffffc0200e08:	97b6                	add	a5,a5,a3
ffffffffc0200e0a:	4cfa1063          	bne	s4,a5,ffffffffc02012ca <pmm_init+0x674>
ffffffffc0200e0e:	000a2703          	lw	a4,0(s4)
ffffffffc0200e12:	4785                	li	a5,1
ffffffffc0200e14:	48f71b63          	bne	a4,a5,ffffffffc02012aa <pmm_init+0x654>
ffffffffc0200e18:	6008                	ld	a0,0(s0)
ffffffffc0200e1a:	76fd                	lui	a3,0xfffff
ffffffffc0200e1c:	611c                	ld	a5,0(a0)
ffffffffc0200e1e:	078a                	slli	a5,a5,0x2
ffffffffc0200e20:	8ff5                	and	a5,a5,a3
ffffffffc0200e22:	00c7d713          	srli	a4,a5,0xc
ffffffffc0200e26:	46c77563          	bgeu	a4,a2,ffffffffc0201290 <pmm_init+0x63a>
ffffffffc0200e2a:	0009bb03          	ld	s6,0(s3)
ffffffffc0200e2e:	97da                	add	a5,a5,s6
ffffffffc0200e30:	0007ba83          	ld	s5,0(a5) # ffffffffc8000000 <end+0x7defe60>
ffffffffc0200e34:	0a8a                	slli	s5,s5,0x2
ffffffffc0200e36:	00dafab3          	and	s5,s5,a3
ffffffffc0200e3a:	00cad793          	srli	a5,s5,0xc
ffffffffc0200e3e:	42c7fc63          	bgeu	a5,a2,ffffffffc0201276 <pmm_init+0x620>
ffffffffc0200e42:	4601                	li	a2,0
ffffffffc0200e44:	6585                	lui	a1,0x1
ffffffffc0200e46:	9ada                	add	s5,s5,s6
ffffffffc0200e48:	a85ff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200e4c:	0aa1                	addi	s5,s5,8
ffffffffc0200e4e:	41551463          	bne	a0,s5,ffffffffc0201256 <pmm_init+0x600>
ffffffffc0200e52:	4505                	li	a0,1
ffffffffc0200e54:	969ff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0200e58:	8aaa                	mv	s5,a0
ffffffffc0200e5a:	6008                	ld	a0,0(s0)
ffffffffc0200e5c:	46d1                	li	a3,20
ffffffffc0200e5e:	6605                	lui	a2,0x1
ffffffffc0200e60:	85d6                	mv	a1,s5
ffffffffc0200e62:	d29ff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0200e66:	3c051863          	bnez	a0,ffffffffc0201236 <pmm_init+0x5e0>
ffffffffc0200e6a:	6008                	ld	a0,0(s0)
ffffffffc0200e6c:	4601                	li	a2,0
ffffffffc0200e6e:	6585                	lui	a1,0x1
ffffffffc0200e70:	a5dff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200e74:	3a050163          	beqz	a0,ffffffffc0201216 <pmm_init+0x5c0>
ffffffffc0200e78:	611c                	ld	a5,0(a0)
ffffffffc0200e7a:	0107f713          	andi	a4,a5,16
ffffffffc0200e7e:	36070c63          	beqz	a4,ffffffffc02011f6 <pmm_init+0x5a0>
ffffffffc0200e82:	8b91                	andi	a5,a5,4
ffffffffc0200e84:	30078963          	beqz	a5,ffffffffc0201196 <pmm_init+0x540>
ffffffffc0200e88:	6008                	ld	a0,0(s0)
ffffffffc0200e8a:	611c                	ld	a5,0(a0)
ffffffffc0200e8c:	8bc1                	andi	a5,a5,16
ffffffffc0200e8e:	50078e63          	beqz	a5,ffffffffc02013aa <pmm_init+0x754>
ffffffffc0200e92:	000aa703          	lw	a4,0(s5)
ffffffffc0200e96:	4785                	li	a5,1
ffffffffc0200e98:	4ef71963          	bne	a4,a5,ffffffffc020138a <pmm_init+0x734>
ffffffffc0200e9c:	4681                	li	a3,0
ffffffffc0200e9e:	6605                	lui	a2,0x1
ffffffffc0200ea0:	85d2                	mv	a1,s4
ffffffffc0200ea2:	ce9ff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0200ea6:	4c051263          	bnez	a0,ffffffffc020136a <pmm_init+0x714>
ffffffffc0200eaa:	000a2703          	lw	a4,0(s4)
ffffffffc0200eae:	4789                	li	a5,2
ffffffffc0200eb0:	48f71d63          	bne	a4,a5,ffffffffc020134a <pmm_init+0x6f4>
ffffffffc0200eb4:	000aa783          	lw	a5,0(s5)
ffffffffc0200eb8:	46079963          	bnez	a5,ffffffffc020132a <pmm_init+0x6d4>
ffffffffc0200ebc:	6008                	ld	a0,0(s0)
ffffffffc0200ebe:	4601                	li	a2,0
ffffffffc0200ec0:	6585                	lui	a1,0x1
ffffffffc0200ec2:	a0bff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200ec6:	44050263          	beqz	a0,ffffffffc020130a <pmm_init+0x6b4>
ffffffffc0200eca:	6114                	ld	a3,0(a0)
ffffffffc0200ecc:	0016f793          	andi	a5,a3,1
ffffffffc0200ed0:	26078763          	beqz	a5,ffffffffc020113e <pmm_init+0x4e8>
ffffffffc0200ed4:	6098                	ld	a4,0(s1)
ffffffffc0200ed6:	00269793          	slli	a5,a3,0x2
ffffffffc0200eda:	83b1                	srli	a5,a5,0xc
ffffffffc0200edc:	24e7ff63          	bgeu	a5,a4,ffffffffc020113a <pmm_init+0x4e4>
ffffffffc0200ee0:	fff80737          	lui	a4,0xfff80
ffffffffc0200ee4:	97ba                	add	a5,a5,a4
ffffffffc0200ee6:	00093603          	ld	a2,0(s2)
ffffffffc0200eea:	00379713          	slli	a4,a5,0x3
ffffffffc0200eee:	97ba                	add	a5,a5,a4
ffffffffc0200ef0:	078e                	slli	a5,a5,0x3
ffffffffc0200ef2:	97b2                	add	a5,a5,a2
ffffffffc0200ef4:	3efa1b63          	bne	s4,a5,ffffffffc02012ea <pmm_init+0x694>
ffffffffc0200ef8:	8ac1                	andi	a3,a3,16
ffffffffc0200efa:	5c069063          	bnez	a3,ffffffffc02014ba <pmm_init+0x864>
ffffffffc0200efe:	6008                	ld	a0,0(s0)
ffffffffc0200f00:	4581                	li	a1,0
ffffffffc0200f02:	c1bff0ef          	jal	ra,ffffffffc0200b1c <page_remove>
ffffffffc0200f06:	000a2703          	lw	a4,0(s4)
ffffffffc0200f0a:	4785                	li	a5,1
ffffffffc0200f0c:	2af71563          	bne	a4,a5,ffffffffc02011b6 <pmm_init+0x560>
ffffffffc0200f10:	000aa783          	lw	a5,0(s5)
ffffffffc0200f14:	4a079b63          	bnez	a5,ffffffffc02013ca <pmm_init+0x774>
ffffffffc0200f18:	6008                	ld	a0,0(s0)
ffffffffc0200f1a:	6585                	lui	a1,0x1
ffffffffc0200f1c:	c01ff0ef          	jal	ra,ffffffffc0200b1c <page_remove>
ffffffffc0200f20:	000a2783          	lw	a5,0(s4)
ffffffffc0200f24:	2a079963          	bnez	a5,ffffffffc02011d6 <pmm_init+0x580>
ffffffffc0200f28:	000aa783          	lw	a5,0(s5)
ffffffffc0200f2c:	64079463          	bnez	a5,ffffffffc0201574 <pmm_init+0x91e>
ffffffffc0200f30:	601c                	ld	a5,0(s0)
ffffffffc0200f32:	6098                	ld	a4,0(s1)
ffffffffc0200f34:	639c                	ld	a5,0(a5)
ffffffffc0200f36:	078a                	slli	a5,a5,0x2
ffffffffc0200f38:	83b1                	srli	a5,a5,0xc
ffffffffc0200f3a:	20e7f063          	bgeu	a5,a4,ffffffffc020113a <pmm_init+0x4e4>
ffffffffc0200f3e:	fff80537          	lui	a0,0xfff80
ffffffffc0200f42:	97aa                	add	a5,a5,a0
ffffffffc0200f44:	00379713          	slli	a4,a5,0x3
ffffffffc0200f48:	00093503          	ld	a0,0(s2)
ffffffffc0200f4c:	97ba                	add	a5,a5,a4
ffffffffc0200f4e:	078e                	slli	a5,a5,0x3
ffffffffc0200f50:	953e                	add	a0,a0,a5
ffffffffc0200f52:	4118                	lw	a4,0(a0)
ffffffffc0200f54:	4785                	li	a5,1
ffffffffc0200f56:	5ef71f63          	bne	a4,a5,ffffffffc0201554 <pmm_init+0x8fe>
ffffffffc0200f5a:	4585                	li	a1,1
ffffffffc0200f5c:	8f3ff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0200f60:	601c                	ld	a5,0(s0)
ffffffffc0200f62:	00004517          	auipc	a0,0x4
ffffffffc0200f66:	88e50513          	addi	a0,a0,-1906 # ffffffffc02047f0 <etext+0xb04>
ffffffffc0200f6a:	c0200a37          	lui	s4,0xc0200
ffffffffc0200f6e:	0007b023          	sd	zero,0(a5)
ffffffffc0200f72:	944ff0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0200f76:	609c                	ld	a5,0(s1)
ffffffffc0200f78:	7b7d                	lui	s6,0xfffff
ffffffffc0200f7a:	6a85                	lui	s5,0x1
ffffffffc0200f7c:	00c79713          	slli	a4,a5,0xc
ffffffffc0200f80:	02ea7b63          	bgeu	s4,a4,ffffffffc0200fb6 <pmm_init+0x360>
ffffffffc0200f84:	00ca5713          	srli	a4,s4,0xc
ffffffffc0200f88:	6008                	ld	a0,0(s0)
ffffffffc0200f8a:	18f77b63          	bgeu	a4,a5,ffffffffc0201120 <pmm_init+0x4ca>
ffffffffc0200f8e:	0009b583          	ld	a1,0(s3)
ffffffffc0200f92:	4601                	li	a2,0
ffffffffc0200f94:	95d2                	add	a1,a1,s4
ffffffffc0200f96:	937ff0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0200f9a:	16050363          	beqz	a0,ffffffffc0201100 <pmm_init+0x4aa>
ffffffffc0200f9e:	611c                	ld	a5,0(a0)
ffffffffc0200fa0:	078a                	slli	a5,a5,0x2
ffffffffc0200fa2:	0167f7b3          	and	a5,a5,s6
ffffffffc0200fa6:	13479d63          	bne	a5,s4,ffffffffc02010e0 <pmm_init+0x48a>
ffffffffc0200faa:	609c                	ld	a5,0(s1)
ffffffffc0200fac:	9a56                	add	s4,s4,s5
ffffffffc0200fae:	00c79713          	slli	a4,a5,0xc
ffffffffc0200fb2:	fcea69e3          	bltu	s4,a4,ffffffffc0200f84 <pmm_init+0x32e>
ffffffffc0200fb6:	601c                	ld	a5,0(s0)
ffffffffc0200fb8:	639c                	ld	a5,0(a5)
ffffffffc0200fba:	52079063          	bnez	a5,ffffffffc02014da <pmm_init+0x884>
ffffffffc0200fbe:	4505                	li	a0,1
ffffffffc0200fc0:	ffcff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0200fc4:	8aaa                	mv	s5,a0
ffffffffc0200fc6:	6008                	ld	a0,0(s0)
ffffffffc0200fc8:	4699                	li	a3,6
ffffffffc0200fca:	10000613          	li	a2,256
ffffffffc0200fce:	85d6                	mv	a1,s5
ffffffffc0200fd0:	bbbff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0200fd4:	46051763          	bnez	a0,ffffffffc0201442 <pmm_init+0x7ec>
ffffffffc0200fd8:	000aa703          	lw	a4,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc0200fdc:	4785                	li	a5,1
ffffffffc0200fde:	44f71263          	bne	a4,a5,ffffffffc0201422 <pmm_init+0x7cc>
ffffffffc0200fe2:	6008                	ld	a0,0(s0)
ffffffffc0200fe4:	6a05                	lui	s4,0x1
ffffffffc0200fe6:	4699                	li	a3,6
ffffffffc0200fe8:	100a0613          	addi	a2,s4,256 # 1100 <kern_entry-0xffffffffc01fef00>
ffffffffc0200fec:	85d6                	mv	a1,s5
ffffffffc0200fee:	b9dff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0200ff2:	5c051163          	bnez	a0,ffffffffc02015b4 <pmm_init+0x95e>
ffffffffc0200ff6:	000aa703          	lw	a4,0(s5)
ffffffffc0200ffa:	4789                	li	a5,2
ffffffffc0200ffc:	48f71f63          	bne	a4,a5,ffffffffc020149a <pmm_init+0x844>
ffffffffc0201000:	00004597          	auipc	a1,0x4
ffffffffc0201004:	92858593          	addi	a1,a1,-1752 # ffffffffc0204928 <etext+0xc3c>
ffffffffc0201008:	10000513          	li	a0,256
ffffffffc020100c:	099020ef          	jal	ra,ffffffffc02038a4 <strcpy>
ffffffffc0201010:	100a0593          	addi	a1,s4,256
ffffffffc0201014:	10000513          	li	a0,256
ffffffffc0201018:	09f020ef          	jal	ra,ffffffffc02038b6 <strcmp>
ffffffffc020101c:	44051f63          	bnez	a0,ffffffffc020147a <pmm_init+0x824>
ffffffffc0201020:	00093683          	ld	a3,0(s2)
ffffffffc0201024:	00005797          	auipc	a5,0x5
ffffffffc0201028:	8c47b783          	ld	a5,-1852(a5) # ffffffffc02058e8 <error_string+0x38>
ffffffffc020102c:	00080a37          	lui	s4,0x80
ffffffffc0201030:	40da86b3          	sub	a3,s5,a3
ffffffffc0201034:	868d                	srai	a3,a3,0x3
ffffffffc0201036:	02f686b3          	mul	a3,a3,a5
ffffffffc020103a:	6098                	ld	a4,0(s1)
ffffffffc020103c:	96d2                	add	a3,a3,s4
ffffffffc020103e:	00c69793          	slli	a5,a3,0xc
ffffffffc0201042:	83b1                	srli	a5,a5,0xc
ffffffffc0201044:	06b2                	slli	a3,a3,0xc
ffffffffc0201046:	40e7fe63          	bgeu	a5,a4,ffffffffc0201462 <pmm_init+0x80c>
ffffffffc020104a:	0009b783          	ld	a5,0(s3)
ffffffffc020104e:	10000513          	li	a0,256
ffffffffc0201052:	96be                	add	a3,a3,a5
ffffffffc0201054:	10068023          	sb	zero,256(a3) # fffffffffffff100 <end+0x3fdeef60>
ffffffffc0201058:	017020ef          	jal	ra,ffffffffc020386e <strlen>
ffffffffc020105c:	3a051363          	bnez	a0,ffffffffc0201402 <pmm_init+0x7ac>
ffffffffc0201060:	4585                	li	a1,1
ffffffffc0201062:	8556                	mv	a0,s5
ffffffffc0201064:	feaff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0201068:	601c                	ld	a5,0(s0)
ffffffffc020106a:	6098                	ld	a4,0(s1)
ffffffffc020106c:	639c                	ld	a5,0(a5)
ffffffffc020106e:	078a                	slli	a5,a5,0x2
ffffffffc0201070:	83b1                	srli	a5,a5,0xc
ffffffffc0201072:	0ce7f463          	bgeu	a5,a4,ffffffffc020113a <pmm_init+0x4e4>
ffffffffc0201076:	414787b3          	sub	a5,a5,s4
ffffffffc020107a:	00093503          	ld	a0,0(s2)
ffffffffc020107e:	00379713          	slli	a4,a5,0x3
ffffffffc0201082:	97ba                	add	a5,a5,a4
ffffffffc0201084:	078e                	slli	a5,a5,0x3
ffffffffc0201086:	953e                	add	a0,a0,a5
ffffffffc0201088:	4585                	li	a1,1
ffffffffc020108a:	fc4ff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc020108e:	601c                	ld	a5,0(s0)
ffffffffc0201090:	7442                	ld	s0,48(sp)
ffffffffc0201092:	70e2                	ld	ra,56(sp)
ffffffffc0201094:	74a2                	ld	s1,40(sp)
ffffffffc0201096:	7902                	ld	s2,32(sp)
ffffffffc0201098:	69e2                	ld	s3,24(sp)
ffffffffc020109a:	6a42                	ld	s4,16(sp)
ffffffffc020109c:	6aa2                	ld	s5,8(sp)
ffffffffc020109e:	6b02                	ld	s6,0(sp)
ffffffffc02010a0:	0007b023          	sd	zero,0(a5)
ffffffffc02010a4:	00004517          	auipc	a0,0x4
ffffffffc02010a8:	8fc50513          	addi	a0,a0,-1796 # ffffffffc02049a0 <etext+0xcb4>
ffffffffc02010ac:	6121                	addi	sp,sp,64
ffffffffc02010ae:	808ff06f          	j	ffffffffc02000b6 <cprintf>
ffffffffc02010b2:	6705                	lui	a4,0x1
ffffffffc02010b4:	177d                	addi	a4,a4,-1
ffffffffc02010b6:	96ba                	add	a3,a3,a4
ffffffffc02010b8:	00c6d713          	srli	a4,a3,0xc
ffffffffc02010bc:	06f77f63          	bgeu	a4,a5,ffffffffc020113a <pmm_init+0x4e4>
ffffffffc02010c0:	000a3803          	ld	a6,0(s4) # 80000 <kern_entry-0xffffffffc0180000>
ffffffffc02010c4:	9732                	add	a4,a4,a2
ffffffffc02010c6:	00371793          	slli	a5,a4,0x3
ffffffffc02010ca:	767d                	lui	a2,0xfffff
ffffffffc02010cc:	8ef1                	and	a3,a3,a2
ffffffffc02010ce:	97ba                	add	a5,a5,a4
ffffffffc02010d0:	01083703          	ld	a4,16(a6)
ffffffffc02010d4:	8d95                	sub	a1,a1,a3
ffffffffc02010d6:	078e                	slli	a5,a5,0x3
ffffffffc02010d8:	81b1                	srli	a1,a1,0xc
ffffffffc02010da:	953e                	add	a0,a0,a5
ffffffffc02010dc:	9702                	jalr	a4
ffffffffc02010de:	b141                	j	ffffffffc0200d5e <pmm_init+0x108>
ffffffffc02010e0:	00003697          	auipc	a3,0x3
ffffffffc02010e4:	77068693          	addi	a3,a3,1904 # ffffffffc0204850 <etext+0xb64>
ffffffffc02010e8:	00003617          	auipc	a2,0x3
ffffffffc02010ec:	44060613          	addi	a2,a2,1088 # ffffffffc0204528 <etext+0x83c>
ffffffffc02010f0:	18b00593          	li	a1,395
ffffffffc02010f4:	00003517          	auipc	a0,0x3
ffffffffc02010f8:	33450513          	addi	a0,a0,820 # ffffffffc0204428 <etext+0x73c>
ffffffffc02010fc:	ff1fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201100:	00003697          	auipc	a3,0x3
ffffffffc0201104:	71068693          	addi	a3,a3,1808 # ffffffffc0204810 <etext+0xb24>
ffffffffc0201108:	00003617          	auipc	a2,0x3
ffffffffc020110c:	42060613          	addi	a2,a2,1056 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201110:	18a00593          	li	a1,394
ffffffffc0201114:	00003517          	auipc	a0,0x3
ffffffffc0201118:	31450513          	addi	a0,a0,788 # ffffffffc0204428 <etext+0x73c>
ffffffffc020111c:	fd1fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201120:	86d2                	mv	a3,s4
ffffffffc0201122:	00003617          	auipc	a2,0x3
ffffffffc0201126:	2de60613          	addi	a2,a2,734 # ffffffffc0204400 <etext+0x714>
ffffffffc020112a:	18a00593          	li	a1,394
ffffffffc020112e:	00003517          	auipc	a0,0x3
ffffffffc0201132:	2fa50513          	addi	a0,a0,762 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201136:	fb7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020113a:	e66ff0ef          	jal	ra,ffffffffc02007a0 <pa2page.part.0>
ffffffffc020113e:	00003617          	auipc	a2,0x3
ffffffffc0201142:	4c260613          	addi	a2,a2,1218 # ffffffffc0204600 <etext+0x914>
ffffffffc0201146:	07000593          	li	a1,112
ffffffffc020114a:	00003517          	auipc	a0,0x3
ffffffffc020114e:	2a650513          	addi	a0,a0,678 # ffffffffc02043f0 <etext+0x704>
ffffffffc0201152:	f9bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201156:	00003697          	auipc	a3,0x3
ffffffffc020115a:	3ea68693          	addi	a3,a3,1002 # ffffffffc0204540 <etext+0x854>
ffffffffc020115e:	00003617          	auipc	a2,0x3
ffffffffc0201162:	3ca60613          	addi	a2,a2,970 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201166:	15900593          	li	a1,345
ffffffffc020116a:	00003517          	auipc	a0,0x3
ffffffffc020116e:	2be50513          	addi	a0,a0,702 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201172:	f7bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201176:	00003697          	auipc	a3,0x3
ffffffffc020117a:	42a68693          	addi	a3,a3,1066 # ffffffffc02045a0 <etext+0x8b4>
ffffffffc020117e:	00003617          	auipc	a2,0x3
ffffffffc0201182:	3aa60613          	addi	a2,a2,938 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201186:	15e00593          	li	a1,350
ffffffffc020118a:	00003517          	auipc	a0,0x3
ffffffffc020118e:	29e50513          	addi	a0,a0,670 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201192:	f5bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201196:	00003697          	auipc	a3,0x3
ffffffffc020119a:	56268693          	addi	a3,a3,1378 # ffffffffc02046f8 <etext+0xa0c>
ffffffffc020119e:	00003617          	auipc	a2,0x3
ffffffffc02011a2:	38a60613          	addi	a2,a2,906 # ffffffffc0204528 <etext+0x83c>
ffffffffc02011a6:	16c00593          	li	a1,364
ffffffffc02011aa:	00003517          	auipc	a0,0x3
ffffffffc02011ae:	27e50513          	addi	a0,a0,638 # ffffffffc0204428 <etext+0x73c>
ffffffffc02011b2:	f3bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02011b6:	00003697          	auipc	a3,0x3
ffffffffc02011ba:	48a68693          	addi	a3,a3,1162 # ffffffffc0204640 <etext+0x954>
ffffffffc02011be:	00003617          	auipc	a2,0x3
ffffffffc02011c2:	36a60613          	addi	a2,a2,874 # ffffffffc0204528 <etext+0x83c>
ffffffffc02011c6:	17800593          	li	a1,376
ffffffffc02011ca:	00003517          	auipc	a0,0x3
ffffffffc02011ce:	25e50513          	addi	a0,a0,606 # ffffffffc0204428 <etext+0x73c>
ffffffffc02011d2:	f1bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02011d6:	00003697          	auipc	a3,0x3
ffffffffc02011da:	5da68693          	addi	a3,a3,1498 # ffffffffc02047b0 <etext+0xac4>
ffffffffc02011de:	00003617          	auipc	a2,0x3
ffffffffc02011e2:	34a60613          	addi	a2,a2,842 # ffffffffc0204528 <etext+0x83c>
ffffffffc02011e6:	17c00593          	li	a1,380
ffffffffc02011ea:	00003517          	auipc	a0,0x3
ffffffffc02011ee:	23e50513          	addi	a0,a0,574 # ffffffffc0204428 <etext+0x73c>
ffffffffc02011f2:	efbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02011f6:	00003697          	auipc	a3,0x3
ffffffffc02011fa:	4f268693          	addi	a3,a3,1266 # ffffffffc02046e8 <etext+0x9fc>
ffffffffc02011fe:	00003617          	auipc	a2,0x3
ffffffffc0201202:	32a60613          	addi	a2,a2,810 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201206:	16b00593          	li	a1,363
ffffffffc020120a:	00003517          	auipc	a0,0x3
ffffffffc020120e:	21e50513          	addi	a0,a0,542 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201212:	edbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201216:	00003697          	auipc	a3,0x3
ffffffffc020121a:	4a268693          	addi	a3,a3,1186 # ffffffffc02046b8 <etext+0x9cc>
ffffffffc020121e:	00003617          	auipc	a2,0x3
ffffffffc0201222:	30a60613          	addi	a2,a2,778 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201226:	16a00593          	li	a1,362
ffffffffc020122a:	00003517          	auipc	a0,0x3
ffffffffc020122e:	1fe50513          	addi	a0,a0,510 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201232:	ebbfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201236:	00003697          	auipc	a3,0x3
ffffffffc020123a:	44a68693          	addi	a3,a3,1098 # ffffffffc0204680 <etext+0x994>
ffffffffc020123e:	00003617          	auipc	a2,0x3
ffffffffc0201242:	2ea60613          	addi	a2,a2,746 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201246:	16900593          	li	a1,361
ffffffffc020124a:	00003517          	auipc	a0,0x3
ffffffffc020124e:	1de50513          	addi	a0,a0,478 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201252:	e9bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201256:	00003697          	auipc	a3,0x3
ffffffffc020125a:	40268693          	addi	a3,a3,1026 # ffffffffc0204658 <etext+0x96c>
ffffffffc020125e:	00003617          	auipc	a2,0x3
ffffffffc0201262:	2ca60613          	addi	a2,a2,714 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201266:	16600593          	li	a1,358
ffffffffc020126a:	00003517          	auipc	a0,0x3
ffffffffc020126e:	1be50513          	addi	a0,a0,446 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201272:	e7bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201276:	86d6                	mv	a3,s5
ffffffffc0201278:	00003617          	auipc	a2,0x3
ffffffffc020127c:	18860613          	addi	a2,a2,392 # ffffffffc0204400 <etext+0x714>
ffffffffc0201280:	16500593          	li	a1,357
ffffffffc0201284:	00003517          	auipc	a0,0x3
ffffffffc0201288:	1a450513          	addi	a0,a0,420 # ffffffffc0204428 <etext+0x73c>
ffffffffc020128c:	e61fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201290:	86be                	mv	a3,a5
ffffffffc0201292:	00003617          	auipc	a2,0x3
ffffffffc0201296:	16e60613          	addi	a2,a2,366 # ffffffffc0204400 <etext+0x714>
ffffffffc020129a:	16400593          	li	a1,356
ffffffffc020129e:	00003517          	auipc	a0,0x3
ffffffffc02012a2:	18a50513          	addi	a0,a0,394 # ffffffffc0204428 <etext+0x73c>
ffffffffc02012a6:	e47fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02012aa:	00003697          	auipc	a3,0x3
ffffffffc02012ae:	39668693          	addi	a3,a3,918 # ffffffffc0204640 <etext+0x954>
ffffffffc02012b2:	00003617          	auipc	a2,0x3
ffffffffc02012b6:	27660613          	addi	a2,a2,630 # ffffffffc0204528 <etext+0x83c>
ffffffffc02012ba:	16200593          	li	a1,354
ffffffffc02012be:	00003517          	auipc	a0,0x3
ffffffffc02012c2:	16a50513          	addi	a0,a0,362 # ffffffffc0204428 <etext+0x73c>
ffffffffc02012c6:	e27fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02012ca:	00003697          	auipc	a3,0x3
ffffffffc02012ce:	35e68693          	addi	a3,a3,862 # ffffffffc0204628 <etext+0x93c>
ffffffffc02012d2:	00003617          	auipc	a2,0x3
ffffffffc02012d6:	25660613          	addi	a2,a2,598 # ffffffffc0204528 <etext+0x83c>
ffffffffc02012da:	16100593          	li	a1,353
ffffffffc02012de:	00003517          	auipc	a0,0x3
ffffffffc02012e2:	14a50513          	addi	a0,a0,330 # ffffffffc0204428 <etext+0x73c>
ffffffffc02012e6:	e07fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02012ea:	00003697          	auipc	a3,0x3
ffffffffc02012ee:	33e68693          	addi	a3,a3,830 # ffffffffc0204628 <etext+0x93c>
ffffffffc02012f2:	00003617          	auipc	a2,0x3
ffffffffc02012f6:	23660613          	addi	a2,a2,566 # ffffffffc0204528 <etext+0x83c>
ffffffffc02012fa:	17400593          	li	a1,372
ffffffffc02012fe:	00003517          	auipc	a0,0x3
ffffffffc0201302:	12a50513          	addi	a0,a0,298 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201306:	de7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020130a:	00003697          	auipc	a3,0x3
ffffffffc020130e:	3ae68693          	addi	a3,a3,942 # ffffffffc02046b8 <etext+0x9cc>
ffffffffc0201312:	00003617          	auipc	a2,0x3
ffffffffc0201316:	21660613          	addi	a2,a2,534 # ffffffffc0204528 <etext+0x83c>
ffffffffc020131a:	17300593          	li	a1,371
ffffffffc020131e:	00003517          	auipc	a0,0x3
ffffffffc0201322:	10a50513          	addi	a0,a0,266 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201326:	dc7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020132a:	00003697          	auipc	a3,0x3
ffffffffc020132e:	45668693          	addi	a3,a3,1110 # ffffffffc0204780 <etext+0xa94>
ffffffffc0201332:	00003617          	auipc	a2,0x3
ffffffffc0201336:	1f660613          	addi	a2,a2,502 # ffffffffc0204528 <etext+0x83c>
ffffffffc020133a:	17200593          	li	a1,370
ffffffffc020133e:	00003517          	auipc	a0,0x3
ffffffffc0201342:	0ea50513          	addi	a0,a0,234 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201346:	da7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020134a:	00003697          	auipc	a3,0x3
ffffffffc020134e:	41e68693          	addi	a3,a3,1054 # ffffffffc0204768 <etext+0xa7c>
ffffffffc0201352:	00003617          	auipc	a2,0x3
ffffffffc0201356:	1d660613          	addi	a2,a2,470 # ffffffffc0204528 <etext+0x83c>
ffffffffc020135a:	17100593          	li	a1,369
ffffffffc020135e:	00003517          	auipc	a0,0x3
ffffffffc0201362:	0ca50513          	addi	a0,a0,202 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201366:	d87fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020136a:	00003697          	auipc	a3,0x3
ffffffffc020136e:	3ce68693          	addi	a3,a3,974 # ffffffffc0204738 <etext+0xa4c>
ffffffffc0201372:	00003617          	auipc	a2,0x3
ffffffffc0201376:	1b660613          	addi	a2,a2,438 # ffffffffc0204528 <etext+0x83c>
ffffffffc020137a:	17000593          	li	a1,368
ffffffffc020137e:	00003517          	auipc	a0,0x3
ffffffffc0201382:	0aa50513          	addi	a0,a0,170 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201386:	d67fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020138a:	00003697          	auipc	a3,0x3
ffffffffc020138e:	39668693          	addi	a3,a3,918 # ffffffffc0204720 <etext+0xa34>
ffffffffc0201392:	00003617          	auipc	a2,0x3
ffffffffc0201396:	19660613          	addi	a2,a2,406 # ffffffffc0204528 <etext+0x83c>
ffffffffc020139a:	16e00593          	li	a1,366
ffffffffc020139e:	00003517          	auipc	a0,0x3
ffffffffc02013a2:	08a50513          	addi	a0,a0,138 # ffffffffc0204428 <etext+0x73c>
ffffffffc02013a6:	d47fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02013aa:	00003697          	auipc	a3,0x3
ffffffffc02013ae:	35e68693          	addi	a3,a3,862 # ffffffffc0204708 <etext+0xa1c>
ffffffffc02013b2:	00003617          	auipc	a2,0x3
ffffffffc02013b6:	17660613          	addi	a2,a2,374 # ffffffffc0204528 <etext+0x83c>
ffffffffc02013ba:	16d00593          	li	a1,365
ffffffffc02013be:	00003517          	auipc	a0,0x3
ffffffffc02013c2:	06a50513          	addi	a0,a0,106 # ffffffffc0204428 <etext+0x73c>
ffffffffc02013c6:	d27fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02013ca:	00003697          	auipc	a3,0x3
ffffffffc02013ce:	3b668693          	addi	a3,a3,950 # ffffffffc0204780 <etext+0xa94>
ffffffffc02013d2:	00003617          	auipc	a2,0x3
ffffffffc02013d6:	15660613          	addi	a2,a2,342 # ffffffffc0204528 <etext+0x83c>
ffffffffc02013da:	17900593          	li	a1,377
ffffffffc02013de:	00003517          	auipc	a0,0x3
ffffffffc02013e2:	04a50513          	addi	a0,a0,74 # ffffffffc0204428 <etext+0x73c>
ffffffffc02013e6:	d07fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02013ea:	00003617          	auipc	a2,0x3
ffffffffc02013ee:	0d660613          	addi	a2,a2,214 # ffffffffc02044c0 <etext+0x7d4>
ffffffffc02013f2:	07700593          	li	a1,119
ffffffffc02013f6:	00003517          	auipc	a0,0x3
ffffffffc02013fa:	03250513          	addi	a0,a0,50 # ffffffffc0204428 <etext+0x73c>
ffffffffc02013fe:	ceffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201402:	00003697          	auipc	a3,0x3
ffffffffc0201406:	57668693          	addi	a3,a3,1398 # ffffffffc0204978 <etext+0xc8c>
ffffffffc020140a:	00003617          	auipc	a2,0x3
ffffffffc020140e:	11e60613          	addi	a2,a2,286 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201412:	19d00593          	li	a1,413
ffffffffc0201416:	00003517          	auipc	a0,0x3
ffffffffc020141a:	01250513          	addi	a0,a0,18 # ffffffffc0204428 <etext+0x73c>
ffffffffc020141e:	ccffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201422:	00003697          	auipc	a3,0x3
ffffffffc0201426:	49668693          	addi	a3,a3,1174 # ffffffffc02048b8 <etext+0xbcc>
ffffffffc020142a:	00003617          	auipc	a2,0x3
ffffffffc020142e:	0fe60613          	addi	a2,a2,254 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201432:	19400593          	li	a1,404
ffffffffc0201436:	00003517          	auipc	a0,0x3
ffffffffc020143a:	ff250513          	addi	a0,a0,-14 # ffffffffc0204428 <etext+0x73c>
ffffffffc020143e:	caffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201442:	00003697          	auipc	a3,0x3
ffffffffc0201446:	43e68693          	addi	a3,a3,1086 # ffffffffc0204880 <etext+0xb94>
ffffffffc020144a:	00003617          	auipc	a2,0x3
ffffffffc020144e:	0de60613          	addi	a2,a2,222 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201452:	19300593          	li	a1,403
ffffffffc0201456:	00003517          	auipc	a0,0x3
ffffffffc020145a:	fd250513          	addi	a0,a0,-46 # ffffffffc0204428 <etext+0x73c>
ffffffffc020145e:	c8ffe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201462:	00003617          	auipc	a2,0x3
ffffffffc0201466:	f9e60613          	addi	a2,a2,-98 # ffffffffc0204400 <etext+0x714>
ffffffffc020146a:	06a00593          	li	a1,106
ffffffffc020146e:	00003517          	auipc	a0,0x3
ffffffffc0201472:	f8250513          	addi	a0,a0,-126 # ffffffffc02043f0 <etext+0x704>
ffffffffc0201476:	c77fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020147a:	00003697          	auipc	a3,0x3
ffffffffc020147e:	4c668693          	addi	a3,a3,1222 # ffffffffc0204940 <etext+0xc54>
ffffffffc0201482:	00003617          	auipc	a2,0x3
ffffffffc0201486:	0a660613          	addi	a2,a2,166 # ffffffffc0204528 <etext+0x83c>
ffffffffc020148a:	19a00593          	li	a1,410
ffffffffc020148e:	00003517          	auipc	a0,0x3
ffffffffc0201492:	f9a50513          	addi	a0,a0,-102 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201496:	c57fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020149a:	00003697          	auipc	a3,0x3
ffffffffc020149e:	47668693          	addi	a3,a3,1142 # ffffffffc0204910 <etext+0xc24>
ffffffffc02014a2:	00003617          	auipc	a2,0x3
ffffffffc02014a6:	08660613          	addi	a2,a2,134 # ffffffffc0204528 <etext+0x83c>
ffffffffc02014aa:	19600593          	li	a1,406
ffffffffc02014ae:	00003517          	auipc	a0,0x3
ffffffffc02014b2:	f7a50513          	addi	a0,a0,-134 # ffffffffc0204428 <etext+0x73c>
ffffffffc02014b6:	c37fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02014ba:	00003697          	auipc	a3,0x3
ffffffffc02014be:	2de68693          	addi	a3,a3,734 # ffffffffc0204798 <etext+0xaac>
ffffffffc02014c2:	00003617          	auipc	a2,0x3
ffffffffc02014c6:	06660613          	addi	a2,a2,102 # ffffffffc0204528 <etext+0x83c>
ffffffffc02014ca:	17500593          	li	a1,373
ffffffffc02014ce:	00003517          	auipc	a0,0x3
ffffffffc02014d2:	f5a50513          	addi	a0,a0,-166 # ffffffffc0204428 <etext+0x73c>
ffffffffc02014d6:	c17fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02014da:	00003697          	auipc	a3,0x3
ffffffffc02014de:	38e68693          	addi	a3,a3,910 # ffffffffc0204868 <etext+0xb7c>
ffffffffc02014e2:	00003617          	auipc	a2,0x3
ffffffffc02014e6:	04660613          	addi	a2,a2,70 # ffffffffc0204528 <etext+0x83c>
ffffffffc02014ea:	18f00593          	li	a1,399
ffffffffc02014ee:	00003517          	auipc	a0,0x3
ffffffffc02014f2:	f3a50513          	addi	a0,a0,-198 # ffffffffc0204428 <etext+0x73c>
ffffffffc02014f6:	bf7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02014fa:	00003697          	auipc	a3,0x3
ffffffffc02014fe:	07e68693          	addi	a3,a3,126 # ffffffffc0204578 <etext+0x88c>
ffffffffc0201502:	00003617          	auipc	a2,0x3
ffffffffc0201506:	02660613          	addi	a2,a2,38 # ffffffffc0204528 <etext+0x83c>
ffffffffc020150a:	15a00593          	li	a1,346
ffffffffc020150e:	00003517          	auipc	a0,0x3
ffffffffc0201512:	f1a50513          	addi	a0,a0,-230 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201516:	bd7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020151a:	00003697          	auipc	a3,0x3
ffffffffc020151e:	fee68693          	addi	a3,a3,-18 # ffffffffc0204508 <etext+0x81c>
ffffffffc0201522:	00003617          	auipc	a2,0x3
ffffffffc0201526:	00660613          	addi	a2,a2,6 # ffffffffc0204528 <etext+0x83c>
ffffffffc020152a:	15800593          	li	a1,344
ffffffffc020152e:	00003517          	auipc	a0,0x3
ffffffffc0201532:	efa50513          	addi	a0,a0,-262 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201536:	bb7fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020153a:	86aa                	mv	a3,a0
ffffffffc020153c:	00003617          	auipc	a2,0x3
ffffffffc0201540:	f8460613          	addi	a2,a2,-124 # ffffffffc02044c0 <etext+0x7d4>
ffffffffc0201544:	0bd00593          	li	a1,189
ffffffffc0201548:	00003517          	auipc	a0,0x3
ffffffffc020154c:	ee050513          	addi	a0,a0,-288 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201550:	b9dfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201554:	00003697          	auipc	a3,0x3
ffffffffc0201558:	27468693          	addi	a3,a3,628 # ffffffffc02047c8 <etext+0xadc>
ffffffffc020155c:	00003617          	auipc	a2,0x3
ffffffffc0201560:	fcc60613          	addi	a2,a2,-52 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201564:	17f00593          	li	a1,383
ffffffffc0201568:	00003517          	auipc	a0,0x3
ffffffffc020156c:	ec050513          	addi	a0,a0,-320 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201570:	b7dfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201574:	00003697          	auipc	a3,0x3
ffffffffc0201578:	20c68693          	addi	a3,a3,524 # ffffffffc0204780 <etext+0xa94>
ffffffffc020157c:	00003617          	auipc	a2,0x3
ffffffffc0201580:	fac60613          	addi	a2,a2,-84 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201584:	17d00593          	li	a1,381
ffffffffc0201588:	00003517          	auipc	a0,0x3
ffffffffc020158c:	ea050513          	addi	a0,a0,-352 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201590:	b5dfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201594:	00003697          	auipc	a3,0x3
ffffffffc0201598:	03c68693          	addi	a3,a3,60 # ffffffffc02045d0 <etext+0x8e4>
ffffffffc020159c:	00003617          	auipc	a2,0x3
ffffffffc02015a0:	f8c60613          	addi	a2,a2,-116 # ffffffffc0204528 <etext+0x83c>
ffffffffc02015a4:	16000593          	li	a1,352
ffffffffc02015a8:	00003517          	auipc	a0,0x3
ffffffffc02015ac:	e8050513          	addi	a0,a0,-384 # ffffffffc0204428 <etext+0x73c>
ffffffffc02015b0:	b3dfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02015b4:	00003697          	auipc	a3,0x3
ffffffffc02015b8:	31c68693          	addi	a3,a3,796 # ffffffffc02048d0 <etext+0xbe4>
ffffffffc02015bc:	00003617          	auipc	a2,0x3
ffffffffc02015c0:	f6c60613          	addi	a2,a2,-148 # ffffffffc0204528 <etext+0x83c>
ffffffffc02015c4:	19500593          	li	a1,405
ffffffffc02015c8:	00003517          	auipc	a0,0x3
ffffffffc02015cc:	e6050513          	addi	a0,a0,-416 # ffffffffc0204428 <etext+0x73c>
ffffffffc02015d0:	b1dfe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02015d4 <tlb_invalidate>:
ffffffffc02015d4:	12000073          	sfence.vma
ffffffffc02015d8:	8082                	ret

ffffffffc02015da <pgdir_alloc_page>:
ffffffffc02015da:	7179                	addi	sp,sp,-48
ffffffffc02015dc:	e84a                	sd	s2,16(sp)
ffffffffc02015de:	892a                	mv	s2,a0
ffffffffc02015e0:	4505                	li	a0,1
ffffffffc02015e2:	f022                	sd	s0,32(sp)
ffffffffc02015e4:	ec26                	sd	s1,24(sp)
ffffffffc02015e6:	e44e                	sd	s3,8(sp)
ffffffffc02015e8:	f406                	sd	ra,40(sp)
ffffffffc02015ea:	84ae                	mv	s1,a1
ffffffffc02015ec:	89b2                	mv	s3,a2
ffffffffc02015ee:	9ceff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02015f2:	842a                	mv	s0,a0
ffffffffc02015f4:	cd09                	beqz	a0,ffffffffc020160e <pgdir_alloc_page+0x34>
ffffffffc02015f6:	85aa                	mv	a1,a0
ffffffffc02015f8:	86ce                	mv	a3,s3
ffffffffc02015fa:	8626                	mv	a2,s1
ffffffffc02015fc:	854a                	mv	a0,s2
ffffffffc02015fe:	d8cff0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0201602:	ed21                	bnez	a0,ffffffffc020165a <pgdir_alloc_page+0x80>
ffffffffc0201604:	0000f797          	auipc	a5,0xf
ffffffffc0201608:	a6c7a783          	lw	a5,-1428(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc020160c:	eb89                	bnez	a5,ffffffffc020161e <pgdir_alloc_page+0x44>
ffffffffc020160e:	70a2                	ld	ra,40(sp)
ffffffffc0201610:	8522                	mv	a0,s0
ffffffffc0201612:	7402                	ld	s0,32(sp)
ffffffffc0201614:	64e2                	ld	s1,24(sp)
ffffffffc0201616:	6942                	ld	s2,16(sp)
ffffffffc0201618:	69a2                	ld	s3,8(sp)
ffffffffc020161a:	6145                	addi	sp,sp,48
ffffffffc020161c:	8082                	ret
ffffffffc020161e:	4681                	li	a3,0
ffffffffc0201620:	8622                	mv	a2,s0
ffffffffc0201622:	85a6                	mv	a1,s1
ffffffffc0201624:	0000f517          	auipc	a0,0xf
ffffffffc0201628:	a9453503          	ld	a0,-1388(a0) # ffffffffc02100b8 <check_mm_struct>
ffffffffc020162c:	7dd000ef          	jal	ra,ffffffffc0202608 <swap_map_swappable>
ffffffffc0201630:	4018                	lw	a4,0(s0)
ffffffffc0201632:	e024                	sd	s1,64(s0)
ffffffffc0201634:	4785                	li	a5,1
ffffffffc0201636:	fcf70ce3          	beq	a4,a5,ffffffffc020160e <pgdir_alloc_page+0x34>
ffffffffc020163a:	00003697          	auipc	a3,0x3
ffffffffc020163e:	38668693          	addi	a3,a3,902 # ffffffffc02049c0 <etext+0xcd4>
ffffffffc0201642:	00003617          	auipc	a2,0x3
ffffffffc0201646:	ee660613          	addi	a2,a2,-282 # ffffffffc0204528 <etext+0x83c>
ffffffffc020164a:	14800593          	li	a1,328
ffffffffc020164e:	00003517          	auipc	a0,0x3
ffffffffc0201652:	dda50513          	addi	a0,a0,-550 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201656:	a97fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020165a:	8522                	mv	a0,s0
ffffffffc020165c:	4585                	li	a1,1
ffffffffc020165e:	9f0ff0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0201662:	4401                	li	s0,0
ffffffffc0201664:	b76d                	j	ffffffffc020160e <pgdir_alloc_page+0x34>

ffffffffc0201666 <kmalloc>:
ffffffffc0201666:	1141                	addi	sp,sp,-16
ffffffffc0201668:	67d5                	lui	a5,0x15
ffffffffc020166a:	e406                	sd	ra,8(sp)
ffffffffc020166c:	fff50713          	addi	a4,a0,-1
ffffffffc0201670:	17f9                	addi	a5,a5,-2
ffffffffc0201672:	04e7ea63          	bltu	a5,a4,ffffffffc02016c6 <kmalloc+0x60>
ffffffffc0201676:	6785                	lui	a5,0x1
ffffffffc0201678:	17fd                	addi	a5,a5,-1
ffffffffc020167a:	953e                	add	a0,a0,a5
ffffffffc020167c:	8131                	srli	a0,a0,0xc
ffffffffc020167e:	93eff0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0201682:	cd3d                	beqz	a0,ffffffffc0201700 <kmalloc+0x9a>
ffffffffc0201684:	0000f797          	auipc	a5,0xf
ffffffffc0201688:	a2c7b783          	ld	a5,-1492(a5) # ffffffffc02100b0 <pages>
ffffffffc020168c:	8d1d                	sub	a0,a0,a5
ffffffffc020168e:	00004697          	auipc	a3,0x4
ffffffffc0201692:	25a6b683          	ld	a3,602(a3) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0201696:	850d                	srai	a0,a0,0x3
ffffffffc0201698:	02d50533          	mul	a0,a0,a3
ffffffffc020169c:	000806b7          	lui	a3,0x80
ffffffffc02016a0:	0000f717          	auipc	a4,0xf
ffffffffc02016a4:	9b873703          	ld	a4,-1608(a4) # ffffffffc0210058 <npage>
ffffffffc02016a8:	9536                	add	a0,a0,a3
ffffffffc02016aa:	00c51793          	slli	a5,a0,0xc
ffffffffc02016ae:	83b1                	srli	a5,a5,0xc
ffffffffc02016b0:	0532                	slli	a0,a0,0xc
ffffffffc02016b2:	02e7fa63          	bgeu	a5,a4,ffffffffc02016e6 <kmalloc+0x80>
ffffffffc02016b6:	60a2                	ld	ra,8(sp)
ffffffffc02016b8:	0000f797          	auipc	a5,0xf
ffffffffc02016bc:	9f07b783          	ld	a5,-1552(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc02016c0:	953e                	add	a0,a0,a5
ffffffffc02016c2:	0141                	addi	sp,sp,16
ffffffffc02016c4:	8082                	ret
ffffffffc02016c6:	00003697          	auipc	a3,0x3
ffffffffc02016ca:	31268693          	addi	a3,a3,786 # ffffffffc02049d8 <etext+0xcec>
ffffffffc02016ce:	00003617          	auipc	a2,0x3
ffffffffc02016d2:	e5a60613          	addi	a2,a2,-422 # ffffffffc0204528 <etext+0x83c>
ffffffffc02016d6:	1a900593          	li	a1,425
ffffffffc02016da:	00003517          	auipc	a0,0x3
ffffffffc02016de:	d4e50513          	addi	a0,a0,-690 # ffffffffc0204428 <etext+0x73c>
ffffffffc02016e2:	a0bfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02016e6:	86aa                	mv	a3,a0
ffffffffc02016e8:	00003617          	auipc	a2,0x3
ffffffffc02016ec:	d1860613          	addi	a2,a2,-744 # ffffffffc0204400 <etext+0x714>
ffffffffc02016f0:	06a00593          	li	a1,106
ffffffffc02016f4:	00003517          	auipc	a0,0x3
ffffffffc02016f8:	cfc50513          	addi	a0,a0,-772 # ffffffffc02043f0 <etext+0x704>
ffffffffc02016fc:	9f1fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201700:	00003697          	auipc	a3,0x3
ffffffffc0201704:	2f868693          	addi	a3,a3,760 # ffffffffc02049f8 <etext+0xd0c>
ffffffffc0201708:	00003617          	auipc	a2,0x3
ffffffffc020170c:	e2060613          	addi	a2,a2,-480 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201710:	1ac00593          	li	a1,428
ffffffffc0201714:	00003517          	auipc	a0,0x3
ffffffffc0201718:	d1450513          	addi	a0,a0,-748 # ffffffffc0204428 <etext+0x73c>
ffffffffc020171c:	9d1fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201720 <kfree>:
ffffffffc0201720:	1141                	addi	sp,sp,-16
ffffffffc0201722:	67d5                	lui	a5,0x15
ffffffffc0201724:	e406                	sd	ra,8(sp)
ffffffffc0201726:	fff58713          	addi	a4,a1,-1
ffffffffc020172a:	17f9                	addi	a5,a5,-2
ffffffffc020172c:	04e7e763          	bltu	a5,a4,ffffffffc020177a <kfree+0x5a>
ffffffffc0201730:	c541                	beqz	a0,ffffffffc02017b8 <kfree+0x98>
ffffffffc0201732:	6785                	lui	a5,0x1
ffffffffc0201734:	17fd                	addi	a5,a5,-1
ffffffffc0201736:	95be                	add	a1,a1,a5
ffffffffc0201738:	c02007b7          	lui	a5,0xc0200
ffffffffc020173c:	81b1                	srli	a1,a1,0xc
ffffffffc020173e:	06f56063          	bltu	a0,a5,ffffffffc020179e <kfree+0x7e>
ffffffffc0201742:	0000f697          	auipc	a3,0xf
ffffffffc0201746:	9666b683          	ld	a3,-1690(a3) # ffffffffc02100a8 <va_pa_offset>
ffffffffc020174a:	8d15                	sub	a0,a0,a3
ffffffffc020174c:	8131                	srli	a0,a0,0xc
ffffffffc020174e:	0000f797          	auipc	a5,0xf
ffffffffc0201752:	90a7b783          	ld	a5,-1782(a5) # ffffffffc0210058 <npage>
ffffffffc0201756:	04f57263          	bgeu	a0,a5,ffffffffc020179a <kfree+0x7a>
ffffffffc020175a:	fff806b7          	lui	a3,0xfff80
ffffffffc020175e:	9536                	add	a0,a0,a3
ffffffffc0201760:	00351793          	slli	a5,a0,0x3
ffffffffc0201764:	60a2                	ld	ra,8(sp)
ffffffffc0201766:	953e                	add	a0,a0,a5
ffffffffc0201768:	050e                	slli	a0,a0,0x3
ffffffffc020176a:	0000f797          	auipc	a5,0xf
ffffffffc020176e:	9467b783          	ld	a5,-1722(a5) # ffffffffc02100b0 <pages>
ffffffffc0201772:	953e                	add	a0,a0,a5
ffffffffc0201774:	0141                	addi	sp,sp,16
ffffffffc0201776:	8d8ff06f          	j	ffffffffc020084e <free_pages>
ffffffffc020177a:	00003697          	auipc	a3,0x3
ffffffffc020177e:	25e68693          	addi	a3,a3,606 # ffffffffc02049d8 <etext+0xcec>
ffffffffc0201782:	00003617          	auipc	a2,0x3
ffffffffc0201786:	da660613          	addi	a2,a2,-602 # ffffffffc0204528 <etext+0x83c>
ffffffffc020178a:	1b200593          	li	a1,434
ffffffffc020178e:	00003517          	auipc	a0,0x3
ffffffffc0201792:	c9a50513          	addi	a0,a0,-870 # ffffffffc0204428 <etext+0x73c>
ffffffffc0201796:	957fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020179a:	806ff0ef          	jal	ra,ffffffffc02007a0 <pa2page.part.0>
ffffffffc020179e:	86aa                	mv	a3,a0
ffffffffc02017a0:	00003617          	auipc	a2,0x3
ffffffffc02017a4:	d2060613          	addi	a2,a2,-736 # ffffffffc02044c0 <etext+0x7d4>
ffffffffc02017a8:	06c00593          	li	a1,108
ffffffffc02017ac:	00003517          	auipc	a0,0x3
ffffffffc02017b0:	c4450513          	addi	a0,a0,-956 # ffffffffc02043f0 <etext+0x704>
ffffffffc02017b4:	939fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02017b8:	00003697          	auipc	a3,0x3
ffffffffc02017bc:	25068693          	addi	a3,a3,592 # ffffffffc0204a08 <etext+0xd1c>
ffffffffc02017c0:	00003617          	auipc	a2,0x3
ffffffffc02017c4:	d6860613          	addi	a2,a2,-664 # ffffffffc0204528 <etext+0x83c>
ffffffffc02017c8:	1b300593          	li	a1,435
ffffffffc02017cc:	00003517          	auipc	a0,0x3
ffffffffc02017d0:	c5c50513          	addi	a0,a0,-932 # ffffffffc0204428 <etext+0x73c>
ffffffffc02017d4:	919fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02017d8 <check_vma_overlap.isra.0.part.0>:
ffffffffc02017d8:	1141                	addi	sp,sp,-16
ffffffffc02017da:	00003697          	auipc	a3,0x3
ffffffffc02017de:	23e68693          	addi	a3,a3,574 # ffffffffc0204a18 <etext+0xd2c>
ffffffffc02017e2:	00003617          	auipc	a2,0x3
ffffffffc02017e6:	d4660613          	addi	a2,a2,-698 # ffffffffc0204528 <etext+0x83c>
ffffffffc02017ea:	07c00593          	li	a1,124
ffffffffc02017ee:	00003517          	auipc	a0,0x3
ffffffffc02017f2:	24a50513          	addi	a0,a0,586 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc02017f6:	e406                	sd	ra,8(sp)
ffffffffc02017f8:	8f5fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02017fc <mm_create>:
ffffffffc02017fc:	1141                	addi	sp,sp,-16
ffffffffc02017fe:	03000513          	li	a0,48
ffffffffc0201802:	e022                	sd	s0,0(sp)
ffffffffc0201804:	e406                	sd	ra,8(sp)
ffffffffc0201806:	e61ff0ef          	jal	ra,ffffffffc0201666 <kmalloc>
ffffffffc020180a:	842a                	mv	s0,a0
ffffffffc020180c:	c105                	beqz	a0,ffffffffc020182c <mm_create+0x30>
ffffffffc020180e:	e408                	sd	a0,8(s0)
ffffffffc0201810:	e008                	sd	a0,0(s0)
ffffffffc0201812:	00053823          	sd	zero,16(a0)
ffffffffc0201816:	00053c23          	sd	zero,24(a0)
ffffffffc020181a:	02052023          	sw	zero,32(a0)
ffffffffc020181e:	0000f797          	auipc	a5,0xf
ffffffffc0201822:	8527a783          	lw	a5,-1966(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc0201826:	eb81                	bnez	a5,ffffffffc0201836 <mm_create+0x3a>
ffffffffc0201828:	02053423          	sd	zero,40(a0)
ffffffffc020182c:	60a2                	ld	ra,8(sp)
ffffffffc020182e:	8522                	mv	a0,s0
ffffffffc0201830:	6402                	ld	s0,0(sp)
ffffffffc0201832:	0141                	addi	sp,sp,16
ffffffffc0201834:	8082                	ret
ffffffffc0201836:	5c5000ef          	jal	ra,ffffffffc02025fa <swap_init_mm>
ffffffffc020183a:	60a2                	ld	ra,8(sp)
ffffffffc020183c:	8522                	mv	a0,s0
ffffffffc020183e:	6402                	ld	s0,0(sp)
ffffffffc0201840:	0141                	addi	sp,sp,16
ffffffffc0201842:	8082                	ret

ffffffffc0201844 <vma_create>:
ffffffffc0201844:	1101                	addi	sp,sp,-32
ffffffffc0201846:	e04a                	sd	s2,0(sp)
ffffffffc0201848:	892a                	mv	s2,a0
ffffffffc020184a:	03000513          	li	a0,48
ffffffffc020184e:	e822                	sd	s0,16(sp)
ffffffffc0201850:	e426                	sd	s1,8(sp)
ffffffffc0201852:	ec06                	sd	ra,24(sp)
ffffffffc0201854:	84ae                	mv	s1,a1
ffffffffc0201856:	8432                	mv	s0,a2
ffffffffc0201858:	e0fff0ef          	jal	ra,ffffffffc0201666 <kmalloc>
ffffffffc020185c:	c509                	beqz	a0,ffffffffc0201866 <vma_create+0x22>
ffffffffc020185e:	01253423          	sd	s2,8(a0)
ffffffffc0201862:	e904                	sd	s1,16(a0)
ffffffffc0201864:	ed00                	sd	s0,24(a0)
ffffffffc0201866:	60e2                	ld	ra,24(sp)
ffffffffc0201868:	6442                	ld	s0,16(sp)
ffffffffc020186a:	64a2                	ld	s1,8(sp)
ffffffffc020186c:	6902                	ld	s2,0(sp)
ffffffffc020186e:	6105                	addi	sp,sp,32
ffffffffc0201870:	8082                	ret

ffffffffc0201872 <find_vma>:
ffffffffc0201872:	86aa                	mv	a3,a0
ffffffffc0201874:	c505                	beqz	a0,ffffffffc020189c <find_vma+0x2a>
ffffffffc0201876:	6908                	ld	a0,16(a0)
ffffffffc0201878:	c501                	beqz	a0,ffffffffc0201880 <find_vma+0xe>
ffffffffc020187a:	651c                	ld	a5,8(a0)
ffffffffc020187c:	02f5f263          	bgeu	a1,a5,ffffffffc02018a0 <find_vma+0x2e>
ffffffffc0201880:	669c                	ld	a5,8(a3)
ffffffffc0201882:	00f68d63          	beq	a3,a5,ffffffffc020189c <find_vma+0x2a>
ffffffffc0201886:	fe87b703          	ld	a4,-24(a5)
ffffffffc020188a:	00e5e663          	bltu	a1,a4,ffffffffc0201896 <find_vma+0x24>
ffffffffc020188e:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201892:	00e5ec63          	bltu	a1,a4,ffffffffc02018aa <find_vma+0x38>
ffffffffc0201896:	679c                	ld	a5,8(a5)
ffffffffc0201898:	fef697e3          	bne	a3,a5,ffffffffc0201886 <find_vma+0x14>
ffffffffc020189c:	4501                	li	a0,0
ffffffffc020189e:	8082                	ret
ffffffffc02018a0:	691c                	ld	a5,16(a0)
ffffffffc02018a2:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201880 <find_vma+0xe>
ffffffffc02018a6:	ea88                	sd	a0,16(a3)
ffffffffc02018a8:	8082                	ret
ffffffffc02018aa:	fe078513          	addi	a0,a5,-32
ffffffffc02018ae:	ea88                	sd	a0,16(a3)
ffffffffc02018b0:	8082                	ret

ffffffffc02018b2 <insert_vma_struct>:
ffffffffc02018b2:	6590                	ld	a2,8(a1)
ffffffffc02018b4:	0105b803          	ld	a6,16(a1)
ffffffffc02018b8:	1141                	addi	sp,sp,-16
ffffffffc02018ba:	e406                	sd	ra,8(sp)
ffffffffc02018bc:	87aa                	mv	a5,a0
ffffffffc02018be:	01066763          	bltu	a2,a6,ffffffffc02018cc <insert_vma_struct+0x1a>
ffffffffc02018c2:	a085                	j	ffffffffc0201922 <insert_vma_struct+0x70>
ffffffffc02018c4:	fe87b703          	ld	a4,-24(a5)
ffffffffc02018c8:	04e66863          	bltu	a2,a4,ffffffffc0201918 <insert_vma_struct+0x66>
ffffffffc02018cc:	86be                	mv	a3,a5
ffffffffc02018ce:	679c                	ld	a5,8(a5)
ffffffffc02018d0:	fef51ae3          	bne	a0,a5,ffffffffc02018c4 <insert_vma_struct+0x12>
ffffffffc02018d4:	02a68463          	beq	a3,a0,ffffffffc02018fc <insert_vma_struct+0x4a>
ffffffffc02018d8:	ff06b703          	ld	a4,-16(a3)
ffffffffc02018dc:	fe86b883          	ld	a7,-24(a3)
ffffffffc02018e0:	08e8f163          	bgeu	a7,a4,ffffffffc0201962 <insert_vma_struct+0xb0>
ffffffffc02018e4:	04e66f63          	bltu	a2,a4,ffffffffc0201942 <insert_vma_struct+0x90>
ffffffffc02018e8:	00f50a63          	beq	a0,a5,ffffffffc02018fc <insert_vma_struct+0x4a>
ffffffffc02018ec:	fe87b703          	ld	a4,-24(a5)
ffffffffc02018f0:	05076963          	bltu	a4,a6,ffffffffc0201942 <insert_vma_struct+0x90>
ffffffffc02018f4:	ff07b603          	ld	a2,-16(a5)
ffffffffc02018f8:	02c77363          	bgeu	a4,a2,ffffffffc020191e <insert_vma_struct+0x6c>
ffffffffc02018fc:	5118                	lw	a4,32(a0)
ffffffffc02018fe:	e188                	sd	a0,0(a1)
ffffffffc0201900:	02058613          	addi	a2,a1,32
ffffffffc0201904:	e390                	sd	a2,0(a5)
ffffffffc0201906:	e690                	sd	a2,8(a3)
ffffffffc0201908:	60a2                	ld	ra,8(sp)
ffffffffc020190a:	f59c                	sd	a5,40(a1)
ffffffffc020190c:	f194                	sd	a3,32(a1)
ffffffffc020190e:	0017079b          	addiw	a5,a4,1
ffffffffc0201912:	d11c                	sw	a5,32(a0)
ffffffffc0201914:	0141                	addi	sp,sp,16
ffffffffc0201916:	8082                	ret
ffffffffc0201918:	fca690e3          	bne	a3,a0,ffffffffc02018d8 <insert_vma_struct+0x26>
ffffffffc020191c:	bfd1                	j	ffffffffc02018f0 <insert_vma_struct+0x3e>
ffffffffc020191e:	ebbff0ef          	jal	ra,ffffffffc02017d8 <check_vma_overlap.isra.0.part.0>
ffffffffc0201922:	00003697          	auipc	a3,0x3
ffffffffc0201926:	12668693          	addi	a3,a3,294 # ffffffffc0204a48 <etext+0xd5c>
ffffffffc020192a:	00003617          	auipc	a2,0x3
ffffffffc020192e:	bfe60613          	addi	a2,a2,-1026 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201932:	08300593          	li	a1,131
ffffffffc0201936:	00003517          	auipc	a0,0x3
ffffffffc020193a:	10250513          	addi	a0,a0,258 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc020193e:	faefe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201942:	00003697          	auipc	a3,0x3
ffffffffc0201946:	14668693          	addi	a3,a3,326 # ffffffffc0204a88 <etext+0xd9c>
ffffffffc020194a:	00003617          	auipc	a2,0x3
ffffffffc020194e:	bde60613          	addi	a2,a2,-1058 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201952:	07b00593          	li	a1,123
ffffffffc0201956:	00003517          	auipc	a0,0x3
ffffffffc020195a:	0e250513          	addi	a0,a0,226 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc020195e:	f8efe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201962:	00003697          	auipc	a3,0x3
ffffffffc0201966:	10668693          	addi	a3,a3,262 # ffffffffc0204a68 <etext+0xd7c>
ffffffffc020196a:	00003617          	auipc	a2,0x3
ffffffffc020196e:	bbe60613          	addi	a2,a2,-1090 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201972:	07a00593          	li	a1,122
ffffffffc0201976:	00003517          	auipc	a0,0x3
ffffffffc020197a:	0c250513          	addi	a0,a0,194 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc020197e:	f6efe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201982 <mm_destroy>:
ffffffffc0201982:	1141                	addi	sp,sp,-16
ffffffffc0201984:	e022                	sd	s0,0(sp)
ffffffffc0201986:	842a                	mv	s0,a0
ffffffffc0201988:	6508                	ld	a0,8(a0)
ffffffffc020198a:	e406                	sd	ra,8(sp)
ffffffffc020198c:	00a40e63          	beq	s0,a0,ffffffffc02019a8 <mm_destroy+0x26>
ffffffffc0201990:	6118                	ld	a4,0(a0)
ffffffffc0201992:	651c                	ld	a5,8(a0)
ffffffffc0201994:	03000593          	li	a1,48
ffffffffc0201998:	1501                	addi	a0,a0,-32
ffffffffc020199a:	e71c                	sd	a5,8(a4)
ffffffffc020199c:	e398                	sd	a4,0(a5)
ffffffffc020199e:	d83ff0ef          	jal	ra,ffffffffc0201720 <kfree>
ffffffffc02019a2:	6408                	ld	a0,8(s0)
ffffffffc02019a4:	fea416e3          	bne	s0,a0,ffffffffc0201990 <mm_destroy+0xe>
ffffffffc02019a8:	8522                	mv	a0,s0
ffffffffc02019aa:	6402                	ld	s0,0(sp)
ffffffffc02019ac:	60a2                	ld	ra,8(sp)
ffffffffc02019ae:	03000593          	li	a1,48
ffffffffc02019b2:	0141                	addi	sp,sp,16
ffffffffc02019b4:	b3b5                	j	ffffffffc0201720 <kfree>

ffffffffc02019b6 <vmm_init>:
ffffffffc02019b6:	715d                	addi	sp,sp,-80
ffffffffc02019b8:	e486                	sd	ra,72(sp)
ffffffffc02019ba:	e0a2                	sd	s0,64(sp)
ffffffffc02019bc:	fc26                	sd	s1,56(sp)
ffffffffc02019be:	f84a                	sd	s2,48(sp)
ffffffffc02019c0:	f052                	sd	s4,32(sp)
ffffffffc02019c2:	f44e                	sd	s3,40(sp)
ffffffffc02019c4:	ec56                	sd	s5,24(sp)
ffffffffc02019c6:	e85a                	sd	s6,16(sp)
ffffffffc02019c8:	e45e                	sd	s7,8(sp)
ffffffffc02019ca:	ec7fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc02019ce:	892a                	mv	s2,a0
ffffffffc02019d0:	ec1fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc02019d4:	8a2a                	mv	s4,a0
ffffffffc02019d6:	e27ff0ef          	jal	ra,ffffffffc02017fc <mm_create>
ffffffffc02019da:	842a                	mv	s0,a0
ffffffffc02019dc:	03200493          	li	s1,50
ffffffffc02019e0:	e919                	bnez	a0,ffffffffc02019f6 <vmm_init+0x40>
ffffffffc02019e2:	aed5                	j	ffffffffc0201dd6 <vmm_init+0x420>
ffffffffc02019e4:	e504                	sd	s1,8(a0)
ffffffffc02019e6:	e91c                	sd	a5,16(a0)
ffffffffc02019e8:	00053c23          	sd	zero,24(a0)
ffffffffc02019ec:	14ed                	addi	s1,s1,-5
ffffffffc02019ee:	8522                	mv	a0,s0
ffffffffc02019f0:	ec3ff0ef          	jal	ra,ffffffffc02018b2 <insert_vma_struct>
ffffffffc02019f4:	c88d                	beqz	s1,ffffffffc0201a26 <vmm_init+0x70>
ffffffffc02019f6:	03000513          	li	a0,48
ffffffffc02019fa:	c6dff0ef          	jal	ra,ffffffffc0201666 <kmalloc>
ffffffffc02019fe:	85aa                	mv	a1,a0
ffffffffc0201a00:	00248793          	addi	a5,s1,2
ffffffffc0201a04:	f165                	bnez	a0,ffffffffc02019e4 <vmm_init+0x2e>
ffffffffc0201a06:	00003697          	auipc	a3,0x3
ffffffffc0201a0a:	2ca68693          	addi	a3,a3,714 # ffffffffc0204cd0 <etext+0xfe4>
ffffffffc0201a0e:	00003617          	auipc	a2,0x3
ffffffffc0201a12:	b1a60613          	addi	a2,a2,-1254 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201a16:	0cd00593          	li	a1,205
ffffffffc0201a1a:	00003517          	auipc	a0,0x3
ffffffffc0201a1e:	01e50513          	addi	a0,a0,30 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201a22:	ecafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201a26:	03700493          	li	s1,55
ffffffffc0201a2a:	1f900993          	li	s3,505
ffffffffc0201a2e:	a819                	j	ffffffffc0201a44 <vmm_init+0x8e>
ffffffffc0201a30:	e504                	sd	s1,8(a0)
ffffffffc0201a32:	e91c                	sd	a5,16(a0)
ffffffffc0201a34:	00053c23          	sd	zero,24(a0)
ffffffffc0201a38:	0495                	addi	s1,s1,5
ffffffffc0201a3a:	8522                	mv	a0,s0
ffffffffc0201a3c:	e77ff0ef          	jal	ra,ffffffffc02018b2 <insert_vma_struct>
ffffffffc0201a40:	03348a63          	beq	s1,s3,ffffffffc0201a74 <vmm_init+0xbe>
ffffffffc0201a44:	03000513          	li	a0,48
ffffffffc0201a48:	c1fff0ef          	jal	ra,ffffffffc0201666 <kmalloc>
ffffffffc0201a4c:	85aa                	mv	a1,a0
ffffffffc0201a4e:	00248793          	addi	a5,s1,2
ffffffffc0201a52:	fd79                	bnez	a0,ffffffffc0201a30 <vmm_init+0x7a>
ffffffffc0201a54:	00003697          	auipc	a3,0x3
ffffffffc0201a58:	27c68693          	addi	a3,a3,636 # ffffffffc0204cd0 <etext+0xfe4>
ffffffffc0201a5c:	00003617          	auipc	a2,0x3
ffffffffc0201a60:	acc60613          	addi	a2,a2,-1332 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201a64:	0d300593          	li	a1,211
ffffffffc0201a68:	00003517          	auipc	a0,0x3
ffffffffc0201a6c:	fd050513          	addi	a0,a0,-48 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201a70:	e7cfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201a74:	6418                	ld	a4,8(s0)
ffffffffc0201a76:	479d                	li	a5,7
ffffffffc0201a78:	1fb00593          	li	a1,507
ffffffffc0201a7c:	28e40d63          	beq	s0,a4,ffffffffc0201d16 <vmm_init+0x360>
ffffffffc0201a80:	fe873683          	ld	a3,-24(a4)
ffffffffc0201a84:	ffe78613          	addi	a2,a5,-2
ffffffffc0201a88:	20d61763          	bne	a2,a3,ffffffffc0201c96 <vmm_init+0x2e0>
ffffffffc0201a8c:	ff073683          	ld	a3,-16(a4)
ffffffffc0201a90:	20d79363          	bne	a5,a3,ffffffffc0201c96 <vmm_init+0x2e0>
ffffffffc0201a94:	0795                	addi	a5,a5,5
ffffffffc0201a96:	6718                	ld	a4,8(a4)
ffffffffc0201a98:	feb792e3          	bne	a5,a1,ffffffffc0201a7c <vmm_init+0xc6>
ffffffffc0201a9c:	4b1d                	li	s6,7
ffffffffc0201a9e:	4495                	li	s1,5
ffffffffc0201aa0:	1f900b93          	li	s7,505
ffffffffc0201aa4:	85a6                	mv	a1,s1
ffffffffc0201aa6:	8522                	mv	a0,s0
ffffffffc0201aa8:	dcbff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201aac:	8aaa                	mv	s5,a0
ffffffffc0201aae:	2e050463          	beqz	a0,ffffffffc0201d96 <vmm_init+0x3e0>
ffffffffc0201ab2:	00148593          	addi	a1,s1,1
ffffffffc0201ab6:	8522                	mv	a0,s0
ffffffffc0201ab8:	dbbff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201abc:	89aa                	mv	s3,a0
ffffffffc0201abe:	2a050c63          	beqz	a0,ffffffffc0201d76 <vmm_init+0x3c0>
ffffffffc0201ac2:	85da                	mv	a1,s6
ffffffffc0201ac4:	8522                	mv	a0,s0
ffffffffc0201ac6:	dadff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201aca:	28051663          	bnez	a0,ffffffffc0201d56 <vmm_init+0x3a0>
ffffffffc0201ace:	00348593          	addi	a1,s1,3
ffffffffc0201ad2:	8522                	mv	a0,s0
ffffffffc0201ad4:	d9fff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201ad8:	24051f63          	bnez	a0,ffffffffc0201d36 <vmm_init+0x380>
ffffffffc0201adc:	00448593          	addi	a1,s1,4
ffffffffc0201ae0:	8522                	mv	a0,s0
ffffffffc0201ae2:	d91ff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201ae6:	2c051863          	bnez	a0,ffffffffc0201db6 <vmm_init+0x400>
ffffffffc0201aea:	008ab783          	ld	a5,8(s5)
ffffffffc0201aee:	1c979463          	bne	a5,s1,ffffffffc0201cb6 <vmm_init+0x300>
ffffffffc0201af2:	010ab783          	ld	a5,16(s5)
ffffffffc0201af6:	1d679063          	bne	a5,s6,ffffffffc0201cb6 <vmm_init+0x300>
ffffffffc0201afa:	0089b783          	ld	a5,8(s3)
ffffffffc0201afe:	1c979c63          	bne	a5,s1,ffffffffc0201cd6 <vmm_init+0x320>
ffffffffc0201b02:	0109b783          	ld	a5,16(s3)
ffffffffc0201b06:	1d679863          	bne	a5,s6,ffffffffc0201cd6 <vmm_init+0x320>
ffffffffc0201b0a:	0495                	addi	s1,s1,5
ffffffffc0201b0c:	0b15                	addi	s6,s6,5
ffffffffc0201b0e:	f9749be3          	bne	s1,s7,ffffffffc0201aa4 <vmm_init+0xee>
ffffffffc0201b12:	4491                	li	s1,4
ffffffffc0201b14:	59fd                	li	s3,-1
ffffffffc0201b16:	85a6                	mv	a1,s1
ffffffffc0201b18:	8522                	mv	a0,s0
ffffffffc0201b1a:	d59ff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201b1e:	0004859b          	sext.w	a1,s1
ffffffffc0201b22:	c90d                	beqz	a0,ffffffffc0201b54 <vmm_init+0x19e>
ffffffffc0201b24:	6914                	ld	a3,16(a0)
ffffffffc0201b26:	6510                	ld	a2,8(a0)
ffffffffc0201b28:	00003517          	auipc	a0,0x3
ffffffffc0201b2c:	09050513          	addi	a0,a0,144 # ffffffffc0204bb8 <etext+0xecc>
ffffffffc0201b30:	d86fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201b34:	00003697          	auipc	a3,0x3
ffffffffc0201b38:	0ac68693          	addi	a3,a3,172 # ffffffffc0204be0 <etext+0xef4>
ffffffffc0201b3c:	00003617          	auipc	a2,0x3
ffffffffc0201b40:	9ec60613          	addi	a2,a2,-1556 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201b44:	0f500593          	li	a1,245
ffffffffc0201b48:	00003517          	auipc	a0,0x3
ffffffffc0201b4c:	ef050513          	addi	a0,a0,-272 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201b50:	d9cfe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201b54:	14fd                	addi	s1,s1,-1
ffffffffc0201b56:	fd3490e3          	bne	s1,s3,ffffffffc0201b16 <vmm_init+0x160>
ffffffffc0201b5a:	8522                	mv	a0,s0
ffffffffc0201b5c:	e27ff0ef          	jal	ra,ffffffffc0201982 <mm_destroy>
ffffffffc0201b60:	d31fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc0201b64:	28aa1963          	bne	s4,a0,ffffffffc0201df6 <vmm_init+0x440>
ffffffffc0201b68:	00003517          	auipc	a0,0x3
ffffffffc0201b6c:	0b850513          	addi	a0,a0,184 # ffffffffc0204c20 <etext+0xf34>
ffffffffc0201b70:	d46fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201b74:	d1dfe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc0201b78:	89aa                	mv	s3,a0
ffffffffc0201b7a:	c83ff0ef          	jal	ra,ffffffffc02017fc <mm_create>
ffffffffc0201b7e:	0000e797          	auipc	a5,0xe
ffffffffc0201b82:	52a7bd23          	sd	a0,1338(a5) # ffffffffc02100b8 <check_mm_struct>
ffffffffc0201b86:	842a                	mv	s0,a0
ffffffffc0201b88:	2a050763          	beqz	a0,ffffffffc0201e36 <vmm_init+0x480>
ffffffffc0201b8c:	0000ea17          	auipc	s4,0xe
ffffffffc0201b90:	4c4a3a03          	ld	s4,1220(s4) # ffffffffc0210050 <boot_pgdir>
ffffffffc0201b94:	000a3783          	ld	a5,0(s4)
ffffffffc0201b98:	01453c23          	sd	s4,24(a0)
ffffffffc0201b9c:	32079963          	bnez	a5,ffffffffc0201ece <vmm_init+0x518>
ffffffffc0201ba0:	03000513          	li	a0,48
ffffffffc0201ba4:	ac3ff0ef          	jal	ra,ffffffffc0201666 <kmalloc>
ffffffffc0201ba8:	84aa                	mv	s1,a0
ffffffffc0201baa:	14050663          	beqz	a0,ffffffffc0201cf6 <vmm_init+0x340>
ffffffffc0201bae:	002007b7          	lui	a5,0x200
ffffffffc0201bb2:	e89c                	sd	a5,16(s1)
ffffffffc0201bb4:	4789                	li	a5,2
ffffffffc0201bb6:	85aa                	mv	a1,a0
ffffffffc0201bb8:	ec9c                	sd	a5,24(s1)
ffffffffc0201bba:	8522                	mv	a0,s0
ffffffffc0201bbc:	0004b423          	sd	zero,8(s1)
ffffffffc0201bc0:	cf3ff0ef          	jal	ra,ffffffffc02018b2 <insert_vma_struct>
ffffffffc0201bc4:	10000593          	li	a1,256
ffffffffc0201bc8:	8522                	mv	a0,s0
ffffffffc0201bca:	ca9ff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201bce:	10000793          	li	a5,256
ffffffffc0201bd2:	16400713          	li	a4,356
ffffffffc0201bd6:	2aa49063          	bne	s1,a0,ffffffffc0201e76 <vmm_init+0x4c0>
ffffffffc0201bda:	00f78023          	sb	a5,0(a5) # 200000 <kern_entry-0xffffffffc0000000>
ffffffffc0201bde:	0785                	addi	a5,a5,1
ffffffffc0201be0:	fee79de3          	bne	a5,a4,ffffffffc0201bda <vmm_init+0x224>
ffffffffc0201be4:	6705                	lui	a4,0x1
ffffffffc0201be6:	10000793          	li	a5,256
ffffffffc0201bea:	35670713          	addi	a4,a4,854 # 1356 <kern_entry-0xffffffffc01fecaa>
ffffffffc0201bee:	16400613          	li	a2,356
ffffffffc0201bf2:	0007c683          	lbu	a3,0(a5)
ffffffffc0201bf6:	0785                	addi	a5,a5,1
ffffffffc0201bf8:	9f15                	subw	a4,a4,a3
ffffffffc0201bfa:	fec79ce3          	bne	a5,a2,ffffffffc0201bf2 <vmm_init+0x23c>
ffffffffc0201bfe:	2a071863          	bnez	a4,ffffffffc0201eae <vmm_init+0x4f8>
ffffffffc0201c02:	4581                	li	a1,0
ffffffffc0201c04:	8552                	mv	a0,s4
ffffffffc0201c06:	f17fe0ef          	jal	ra,ffffffffc0200b1c <page_remove>
ffffffffc0201c0a:	000a3783          	ld	a5,0(s4)
ffffffffc0201c0e:	0000e717          	auipc	a4,0xe
ffffffffc0201c12:	44a73703          	ld	a4,1098(a4) # ffffffffc0210058 <npage>
ffffffffc0201c16:	078a                	slli	a5,a5,0x2
ffffffffc0201c18:	83b1                	srli	a5,a5,0xc
ffffffffc0201c1a:	26e7fe63          	bgeu	a5,a4,ffffffffc0201e96 <vmm_init+0x4e0>
ffffffffc0201c1e:	00004517          	auipc	a0,0x4
ffffffffc0201c22:	cd253503          	ld	a0,-814(a0) # ffffffffc02058f0 <nbase>
ffffffffc0201c26:	8f89                	sub	a5,a5,a0
ffffffffc0201c28:	00379513          	slli	a0,a5,0x3
ffffffffc0201c2c:	97aa                	add	a5,a5,a0
ffffffffc0201c2e:	078e                	slli	a5,a5,0x3
ffffffffc0201c30:	0000e517          	auipc	a0,0xe
ffffffffc0201c34:	48053503          	ld	a0,1152(a0) # ffffffffc02100b0 <pages>
ffffffffc0201c38:	953e                	add	a0,a0,a5
ffffffffc0201c3a:	4585                	li	a1,1
ffffffffc0201c3c:	c13fe0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0201c40:	000a3023          	sd	zero,0(s4)
ffffffffc0201c44:	8522                	mv	a0,s0
ffffffffc0201c46:	00043c23          	sd	zero,24(s0)
ffffffffc0201c4a:	d39ff0ef          	jal	ra,ffffffffc0201982 <mm_destroy>
ffffffffc0201c4e:	19fd                	addi	s3,s3,-1
ffffffffc0201c50:	0000e797          	auipc	a5,0xe
ffffffffc0201c54:	4607b423          	sd	zero,1128(a5) # ffffffffc02100b8 <check_mm_struct>
ffffffffc0201c58:	c39fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc0201c5c:	1aa99d63          	bne	s3,a0,ffffffffc0201e16 <vmm_init+0x460>
ffffffffc0201c60:	00003517          	auipc	a0,0x3
ffffffffc0201c64:	03850513          	addi	a0,a0,56 # ffffffffc0204c98 <etext+0xfac>
ffffffffc0201c68:	c4efe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201c6c:	c25fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc0201c70:	197d                	addi	s2,s2,-1
ffffffffc0201c72:	1ea91263          	bne	s2,a0,ffffffffc0201e56 <vmm_init+0x4a0>
ffffffffc0201c76:	6406                	ld	s0,64(sp)
ffffffffc0201c78:	60a6                	ld	ra,72(sp)
ffffffffc0201c7a:	74e2                	ld	s1,56(sp)
ffffffffc0201c7c:	7942                	ld	s2,48(sp)
ffffffffc0201c7e:	79a2                	ld	s3,40(sp)
ffffffffc0201c80:	7a02                	ld	s4,32(sp)
ffffffffc0201c82:	6ae2                	ld	s5,24(sp)
ffffffffc0201c84:	6b42                	ld	s6,16(sp)
ffffffffc0201c86:	6ba2                	ld	s7,8(sp)
ffffffffc0201c88:	00003517          	auipc	a0,0x3
ffffffffc0201c8c:	03050513          	addi	a0,a0,48 # ffffffffc0204cb8 <etext+0xfcc>
ffffffffc0201c90:	6161                	addi	sp,sp,80
ffffffffc0201c92:	c24fe06f          	j	ffffffffc02000b6 <cprintf>
ffffffffc0201c96:	00003697          	auipc	a3,0x3
ffffffffc0201c9a:	e3a68693          	addi	a3,a3,-454 # ffffffffc0204ad0 <etext+0xde4>
ffffffffc0201c9e:	00003617          	auipc	a2,0x3
ffffffffc0201ca2:	88a60613          	addi	a2,a2,-1910 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201ca6:	0dc00593          	li	a1,220
ffffffffc0201caa:	00003517          	auipc	a0,0x3
ffffffffc0201cae:	d8e50513          	addi	a0,a0,-626 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201cb2:	c3afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201cb6:	00003697          	auipc	a3,0x3
ffffffffc0201cba:	ea268693          	addi	a3,a3,-350 # ffffffffc0204b58 <etext+0xe6c>
ffffffffc0201cbe:	00003617          	auipc	a2,0x3
ffffffffc0201cc2:	86a60613          	addi	a2,a2,-1942 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201cc6:	0ec00593          	li	a1,236
ffffffffc0201cca:	00003517          	auipc	a0,0x3
ffffffffc0201cce:	d6e50513          	addi	a0,a0,-658 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201cd2:	c1afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201cd6:	00003697          	auipc	a3,0x3
ffffffffc0201cda:	eb268693          	addi	a3,a3,-334 # ffffffffc0204b88 <etext+0xe9c>
ffffffffc0201cde:	00003617          	auipc	a2,0x3
ffffffffc0201ce2:	84a60613          	addi	a2,a2,-1974 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201ce6:	0ed00593          	li	a1,237
ffffffffc0201cea:	00003517          	auipc	a0,0x3
ffffffffc0201cee:	d4e50513          	addi	a0,a0,-690 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201cf2:	bfafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201cf6:	00003697          	auipc	a3,0x3
ffffffffc0201cfa:	fda68693          	addi	a3,a3,-38 # ffffffffc0204cd0 <etext+0xfe4>
ffffffffc0201cfe:	00003617          	auipc	a2,0x3
ffffffffc0201d02:	82a60613          	addi	a2,a2,-2006 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201d06:	11000593          	li	a1,272
ffffffffc0201d0a:	00003517          	auipc	a0,0x3
ffffffffc0201d0e:	d2e50513          	addi	a0,a0,-722 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201d12:	bdafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d16:	00003697          	auipc	a3,0x3
ffffffffc0201d1a:	da268693          	addi	a3,a3,-606 # ffffffffc0204ab8 <etext+0xdcc>
ffffffffc0201d1e:	00003617          	auipc	a2,0x3
ffffffffc0201d22:	80a60613          	addi	a2,a2,-2038 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201d26:	0da00593          	li	a1,218
ffffffffc0201d2a:	00003517          	auipc	a0,0x3
ffffffffc0201d2e:	d0e50513          	addi	a0,a0,-754 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201d32:	bbafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d36:	00003697          	auipc	a3,0x3
ffffffffc0201d3a:	e0268693          	addi	a3,a3,-510 # ffffffffc0204b38 <etext+0xe4c>
ffffffffc0201d3e:	00002617          	auipc	a2,0x2
ffffffffc0201d42:	7ea60613          	addi	a2,a2,2026 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201d46:	0e800593          	li	a1,232
ffffffffc0201d4a:	00003517          	auipc	a0,0x3
ffffffffc0201d4e:	cee50513          	addi	a0,a0,-786 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201d52:	b9afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d56:	00003697          	auipc	a3,0x3
ffffffffc0201d5a:	dd268693          	addi	a3,a3,-558 # ffffffffc0204b28 <etext+0xe3c>
ffffffffc0201d5e:	00002617          	auipc	a2,0x2
ffffffffc0201d62:	7ca60613          	addi	a2,a2,1994 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201d66:	0e600593          	li	a1,230
ffffffffc0201d6a:	00003517          	auipc	a0,0x3
ffffffffc0201d6e:	cce50513          	addi	a0,a0,-818 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201d72:	b7afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d76:	00003697          	auipc	a3,0x3
ffffffffc0201d7a:	da268693          	addi	a3,a3,-606 # ffffffffc0204b18 <etext+0xe2c>
ffffffffc0201d7e:	00002617          	auipc	a2,0x2
ffffffffc0201d82:	7aa60613          	addi	a2,a2,1962 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201d86:	0e400593          	li	a1,228
ffffffffc0201d8a:	00003517          	auipc	a0,0x3
ffffffffc0201d8e:	cae50513          	addi	a0,a0,-850 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201d92:	b5afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201d96:	00003697          	auipc	a3,0x3
ffffffffc0201d9a:	d7268693          	addi	a3,a3,-654 # ffffffffc0204b08 <etext+0xe1c>
ffffffffc0201d9e:	00002617          	auipc	a2,0x2
ffffffffc0201da2:	78a60613          	addi	a2,a2,1930 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201da6:	0e200593          	li	a1,226
ffffffffc0201daa:	00003517          	auipc	a0,0x3
ffffffffc0201dae:	c8e50513          	addi	a0,a0,-882 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201db2:	b3afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201db6:	00003697          	auipc	a3,0x3
ffffffffc0201dba:	d9268693          	addi	a3,a3,-622 # ffffffffc0204b48 <etext+0xe5c>
ffffffffc0201dbe:	00002617          	auipc	a2,0x2
ffffffffc0201dc2:	76a60613          	addi	a2,a2,1898 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201dc6:	0ea00593          	li	a1,234
ffffffffc0201dca:	00003517          	auipc	a0,0x3
ffffffffc0201dce:	c6e50513          	addi	a0,a0,-914 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201dd2:	b1afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201dd6:	00003697          	auipc	a3,0x3
ffffffffc0201dda:	cd268693          	addi	a3,a3,-814 # ffffffffc0204aa8 <etext+0xdbc>
ffffffffc0201dde:	00002617          	auipc	a2,0x2
ffffffffc0201de2:	74a60613          	addi	a2,a2,1866 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201de6:	0c600593          	li	a1,198
ffffffffc0201dea:	00003517          	auipc	a0,0x3
ffffffffc0201dee:	c4e50513          	addi	a0,a0,-946 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201df2:	afafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201df6:	00003697          	auipc	a3,0x3
ffffffffc0201dfa:	e0268693          	addi	a3,a3,-510 # ffffffffc0204bf8 <etext+0xf0c>
ffffffffc0201dfe:	00002617          	auipc	a2,0x2
ffffffffc0201e02:	72a60613          	addi	a2,a2,1834 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201e06:	0fa00593          	li	a1,250
ffffffffc0201e0a:	00003517          	auipc	a0,0x3
ffffffffc0201e0e:	c2e50513          	addi	a0,a0,-978 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201e12:	adafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e16:	00003697          	auipc	a3,0x3
ffffffffc0201e1a:	de268693          	addi	a3,a3,-542 # ffffffffc0204bf8 <etext+0xf0c>
ffffffffc0201e1e:	00002617          	auipc	a2,0x2
ffffffffc0201e22:	70a60613          	addi	a2,a2,1802 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201e26:	12c00593          	li	a1,300
ffffffffc0201e2a:	00003517          	auipc	a0,0x3
ffffffffc0201e2e:	c0e50513          	addi	a0,a0,-1010 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201e32:	abafe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e36:	00003697          	auipc	a3,0x3
ffffffffc0201e3a:	e0a68693          	addi	a3,a3,-502 # ffffffffc0204c40 <etext+0xf54>
ffffffffc0201e3e:	00002617          	auipc	a2,0x2
ffffffffc0201e42:	6ea60613          	addi	a2,a2,1770 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201e46:	10900593          	li	a1,265
ffffffffc0201e4a:	00003517          	auipc	a0,0x3
ffffffffc0201e4e:	bee50513          	addi	a0,a0,-1042 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201e52:	a9afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e56:	00003697          	auipc	a3,0x3
ffffffffc0201e5a:	da268693          	addi	a3,a3,-606 # ffffffffc0204bf8 <etext+0xf0c>
ffffffffc0201e5e:	00002617          	auipc	a2,0x2
ffffffffc0201e62:	6ca60613          	addi	a2,a2,1738 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201e66:	0bc00593          	li	a1,188
ffffffffc0201e6a:	00003517          	auipc	a0,0x3
ffffffffc0201e6e:	bce50513          	addi	a0,a0,-1074 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201e72:	a7afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e76:	00003697          	auipc	a3,0x3
ffffffffc0201e7a:	df268693          	addi	a3,a3,-526 # ffffffffc0204c68 <etext+0xf7c>
ffffffffc0201e7e:	00002617          	auipc	a2,0x2
ffffffffc0201e82:	6aa60613          	addi	a2,a2,1706 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201e86:	11500593          	li	a1,277
ffffffffc0201e8a:	00003517          	auipc	a0,0x3
ffffffffc0201e8e:	bae50513          	addi	a0,a0,-1106 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201e92:	a5afe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201e96:	00002617          	auipc	a2,0x2
ffffffffc0201e9a:	53a60613          	addi	a2,a2,1338 # ffffffffc02043d0 <etext+0x6e4>
ffffffffc0201e9e:	06500593          	li	a1,101
ffffffffc0201ea2:	00002517          	auipc	a0,0x2
ffffffffc0201ea6:	54e50513          	addi	a0,a0,1358 # ffffffffc02043f0 <etext+0x704>
ffffffffc0201eaa:	a42fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201eae:	00003697          	auipc	a3,0x3
ffffffffc0201eb2:	dda68693          	addi	a3,a3,-550 # ffffffffc0204c88 <etext+0xf9c>
ffffffffc0201eb6:	00002617          	auipc	a2,0x2
ffffffffc0201eba:	67260613          	addi	a2,a2,1650 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201ebe:	11f00593          	li	a1,287
ffffffffc0201ec2:	00003517          	auipc	a0,0x3
ffffffffc0201ec6:	b7650513          	addi	a0,a0,-1162 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201eca:	a22fe0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0201ece:	00003697          	auipc	a3,0x3
ffffffffc0201ed2:	d8a68693          	addi	a3,a3,-630 # ffffffffc0204c58 <etext+0xf6c>
ffffffffc0201ed6:	00002617          	auipc	a2,0x2
ffffffffc0201eda:	65260613          	addi	a2,a2,1618 # ffffffffc0204528 <etext+0x83c>
ffffffffc0201ede:	10c00593          	li	a1,268
ffffffffc0201ee2:	00003517          	auipc	a0,0x3
ffffffffc0201ee6:	b5650513          	addi	a0,a0,-1194 # ffffffffc0204a38 <etext+0xd4c>
ffffffffc0201eea:	a02fe0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0201eee <do_pgfault>:
ffffffffc0201eee:	7179                	addi	sp,sp,-48
ffffffffc0201ef0:	85b2                	mv	a1,a2
ffffffffc0201ef2:	f022                	sd	s0,32(sp)
ffffffffc0201ef4:	ec26                	sd	s1,24(sp)
ffffffffc0201ef6:	f406                	sd	ra,40(sp)
ffffffffc0201ef8:	e84a                	sd	s2,16(sp)
ffffffffc0201efa:	8432                	mv	s0,a2
ffffffffc0201efc:	84aa                	mv	s1,a0
ffffffffc0201efe:	975ff0ef          	jal	ra,ffffffffc0201872 <find_vma>
ffffffffc0201f02:	0000e797          	auipc	a5,0xe
ffffffffc0201f06:	15e7a783          	lw	a5,350(a5) # ffffffffc0210060 <pgfault_num>
ffffffffc0201f0a:	2785                	addiw	a5,a5,1
ffffffffc0201f0c:	0000e717          	auipc	a4,0xe
ffffffffc0201f10:	14f72a23          	sw	a5,340(a4) # ffffffffc0210060 <pgfault_num>
ffffffffc0201f14:	c159                	beqz	a0,ffffffffc0201f9a <do_pgfault+0xac>
ffffffffc0201f16:	651c                	ld	a5,8(a0)
ffffffffc0201f18:	08f46163          	bltu	s0,a5,ffffffffc0201f9a <do_pgfault+0xac>
ffffffffc0201f1c:	6d1c                	ld	a5,24(a0)
ffffffffc0201f1e:	4941                	li	s2,16
ffffffffc0201f20:	8b89                	andi	a5,a5,2
ffffffffc0201f22:	ebb1                	bnez	a5,ffffffffc0201f76 <do_pgfault+0x88>
ffffffffc0201f24:	75fd                	lui	a1,0xfffff
ffffffffc0201f26:	6c88                	ld	a0,24(s1)
ffffffffc0201f28:	8c6d                	and	s0,s0,a1
ffffffffc0201f2a:	85a2                	mv	a1,s0
ffffffffc0201f2c:	4605                	li	a2,1
ffffffffc0201f2e:	99ffe0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0201f32:	610c                	ld	a1,0(a0)
ffffffffc0201f34:	c1b9                	beqz	a1,ffffffffc0201f7a <do_pgfault+0x8c>
ffffffffc0201f36:	0000e797          	auipc	a5,0xe
ffffffffc0201f3a:	13a7a783          	lw	a5,314(a5) # ffffffffc0210070 <swap_init_ok>
ffffffffc0201f3e:	c7bd                	beqz	a5,ffffffffc0201fac <do_pgfault+0xbe>
ffffffffc0201f40:	85a2                	mv	a1,s0
ffffffffc0201f42:	0030                	addi	a2,sp,8
ffffffffc0201f44:	8526                	mv	a0,s1
ffffffffc0201f46:	e402                	sd	zero,8(sp)
ffffffffc0201f48:	7e2000ef          	jal	ra,ffffffffc020272a <swap_in>
ffffffffc0201f4c:	65a2                	ld	a1,8(sp)
ffffffffc0201f4e:	6c88                	ld	a0,24(s1)
ffffffffc0201f50:	86ca                	mv	a3,s2
ffffffffc0201f52:	8622                	mv	a2,s0
ffffffffc0201f54:	c37fe0ef          	jal	ra,ffffffffc0200b8a <page_insert>
ffffffffc0201f58:	6622                	ld	a2,8(sp)
ffffffffc0201f5a:	4685                	li	a3,1
ffffffffc0201f5c:	85a2                	mv	a1,s0
ffffffffc0201f5e:	8526                	mv	a0,s1
ffffffffc0201f60:	6a8000ef          	jal	ra,ffffffffc0202608 <swap_map_swappable>
ffffffffc0201f64:	67a2                	ld	a5,8(sp)
ffffffffc0201f66:	4501                	li	a0,0
ffffffffc0201f68:	e3a0                	sd	s0,64(a5)
ffffffffc0201f6a:	70a2                	ld	ra,40(sp)
ffffffffc0201f6c:	7402                	ld	s0,32(sp)
ffffffffc0201f6e:	64e2                	ld	s1,24(sp)
ffffffffc0201f70:	6942                	ld	s2,16(sp)
ffffffffc0201f72:	6145                	addi	sp,sp,48
ffffffffc0201f74:	8082                	ret
ffffffffc0201f76:	4959                	li	s2,22
ffffffffc0201f78:	b775                	j	ffffffffc0201f24 <do_pgfault+0x36>
ffffffffc0201f7a:	6c88                	ld	a0,24(s1)
ffffffffc0201f7c:	864a                	mv	a2,s2
ffffffffc0201f7e:	85a2                	mv	a1,s0
ffffffffc0201f80:	e5aff0ef          	jal	ra,ffffffffc02015da <pgdir_alloc_page>
ffffffffc0201f84:	87aa                	mv	a5,a0
ffffffffc0201f86:	4501                	li	a0,0
ffffffffc0201f88:	f3ed                	bnez	a5,ffffffffc0201f6a <do_pgfault+0x7c>
ffffffffc0201f8a:	00003517          	auipc	a0,0x3
ffffffffc0201f8e:	d8650513          	addi	a0,a0,-634 # ffffffffc0204d10 <etext+0x1024>
ffffffffc0201f92:	924fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201f96:	5571                	li	a0,-4
ffffffffc0201f98:	bfc9                	j	ffffffffc0201f6a <do_pgfault+0x7c>
ffffffffc0201f9a:	85a2                	mv	a1,s0
ffffffffc0201f9c:	00003517          	auipc	a0,0x3
ffffffffc0201fa0:	d4450513          	addi	a0,a0,-700 # ffffffffc0204ce0 <etext+0xff4>
ffffffffc0201fa4:	912fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201fa8:	5575                	li	a0,-3
ffffffffc0201faa:	b7c1                	j	ffffffffc0201f6a <do_pgfault+0x7c>
ffffffffc0201fac:	00003517          	auipc	a0,0x3
ffffffffc0201fb0:	d8c50513          	addi	a0,a0,-628 # ffffffffc0204d38 <etext+0x104c>
ffffffffc0201fb4:	902fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0201fb8:	5571                	li	a0,-4
ffffffffc0201fba:	bf45                	j	ffffffffc0201f6a <do_pgfault+0x7c>

ffffffffc0201fbc <swap_init>:
ffffffffc0201fbc:	7175                	addi	sp,sp,-144
ffffffffc0201fbe:	e506                	sd	ra,136(sp)
ffffffffc0201fc0:	e122                	sd	s0,128(sp)
ffffffffc0201fc2:	fca6                	sd	s1,120(sp)
ffffffffc0201fc4:	f8ca                	sd	s2,112(sp)
ffffffffc0201fc6:	f4ce                	sd	s3,104(sp)
ffffffffc0201fc8:	f0d2                	sd	s4,96(sp)
ffffffffc0201fca:	ecd6                	sd	s5,88(sp)
ffffffffc0201fcc:	e8da                	sd	s6,80(sp)
ffffffffc0201fce:	e4de                	sd	s7,72(sp)
ffffffffc0201fd0:	e0e2                	sd	s8,64(sp)
ffffffffc0201fd2:	fc66                	sd	s9,56(sp)
ffffffffc0201fd4:	f86a                	sd	s10,48(sp)
ffffffffc0201fd6:	f46e                	sd	s11,40(sp)
ffffffffc0201fd8:	72a010ef          	jal	ra,ffffffffc0203702 <swapfs_init>
ffffffffc0201fdc:	0000e697          	auipc	a3,0xe
ffffffffc0201fe0:	16c6b683          	ld	a3,364(a3) # ffffffffc0210148 <max_swap_offset>
ffffffffc0201fe4:	010007b7          	lui	a5,0x1000
ffffffffc0201fe8:	ff968713          	addi	a4,a3,-7
ffffffffc0201fec:	17e1                	addi	a5,a5,-8
ffffffffc0201fee:	3ce7ea63          	bltu	a5,a4,ffffffffc02023c2 <swap_init+0x406>
ffffffffc0201ff2:	00007797          	auipc	a5,0x7
ffffffffc0201ff6:	00e78793          	addi	a5,a5,14 # ffffffffc0209000 <swap_manager_clock>
ffffffffc0201ffa:	6798                	ld	a4,8(a5)
ffffffffc0201ffc:	0000ea97          	auipc	s5,0xe
ffffffffc0202000:	06ca8a93          	addi	s5,s5,108 # ffffffffc0210068 <sm>
ffffffffc0202004:	00fab023          	sd	a5,0(s5)
ffffffffc0202008:	9702                	jalr	a4
ffffffffc020200a:	84aa                	mv	s1,a0
ffffffffc020200c:	c10d                	beqz	a0,ffffffffc020202e <swap_init+0x72>
ffffffffc020200e:	60aa                	ld	ra,136(sp)
ffffffffc0202010:	640a                	ld	s0,128(sp)
ffffffffc0202012:	7946                	ld	s2,112(sp)
ffffffffc0202014:	79a6                	ld	s3,104(sp)
ffffffffc0202016:	7a06                	ld	s4,96(sp)
ffffffffc0202018:	6ae6                	ld	s5,88(sp)
ffffffffc020201a:	6b46                	ld	s6,80(sp)
ffffffffc020201c:	6ba6                	ld	s7,72(sp)
ffffffffc020201e:	6c06                	ld	s8,64(sp)
ffffffffc0202020:	7ce2                	ld	s9,56(sp)
ffffffffc0202022:	7d42                	ld	s10,48(sp)
ffffffffc0202024:	7da2                	ld	s11,40(sp)
ffffffffc0202026:	8526                	mv	a0,s1
ffffffffc0202028:	74e6                	ld	s1,120(sp)
ffffffffc020202a:	6149                	addi	sp,sp,144
ffffffffc020202c:	8082                	ret
ffffffffc020202e:	000ab783          	ld	a5,0(s5)
ffffffffc0202032:	00003517          	auipc	a0,0x3
ffffffffc0202036:	d5e50513          	addi	a0,a0,-674 # ffffffffc0204d90 <etext+0x10a4>
ffffffffc020203a:	0000e417          	auipc	s0,0xe
ffffffffc020203e:	14e40413          	addi	s0,s0,334 # ffffffffc0210188 <free_area>
ffffffffc0202042:	638c                	ld	a1,0(a5)
ffffffffc0202044:	4785                	li	a5,1
ffffffffc0202046:	0000e717          	auipc	a4,0xe
ffffffffc020204a:	02f72523          	sw	a5,42(a4) # ffffffffc0210070 <swap_init_ok>
ffffffffc020204e:	868fe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202052:	641c                	ld	a5,8(s0)
ffffffffc0202054:	4901                	li	s2,0
ffffffffc0202056:	4981                	li	s3,0
ffffffffc0202058:	28878b63          	beq	a5,s0,ffffffffc02022ee <swap_init+0x332>
ffffffffc020205c:	fe87b703          	ld	a4,-24(a5)
ffffffffc0202060:	8b09                	andi	a4,a4,2
ffffffffc0202062:	28070863          	beqz	a4,ffffffffc02022f2 <swap_init+0x336>
ffffffffc0202066:	ff87a703          	lw	a4,-8(a5)
ffffffffc020206a:	679c                	ld	a5,8(a5)
ffffffffc020206c:	2985                	addiw	s3,s3,1
ffffffffc020206e:	0127093b          	addw	s2,a4,s2
ffffffffc0202072:	fe8795e3          	bne	a5,s0,ffffffffc020205c <swap_init+0xa0>
ffffffffc0202076:	8a4a                	mv	s4,s2
ffffffffc0202078:	819fe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc020207c:	55451f63          	bne	a0,s4,ffffffffc02025da <swap_init+0x61e>
ffffffffc0202080:	864a                	mv	a2,s2
ffffffffc0202082:	85ce                	mv	a1,s3
ffffffffc0202084:	00003517          	auipc	a0,0x3
ffffffffc0202088:	d5450513          	addi	a0,a0,-684 # ffffffffc0204dd8 <etext+0x10ec>
ffffffffc020208c:	82afe0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202090:	f6cff0ef          	jal	ra,ffffffffc02017fc <mm_create>
ffffffffc0202094:	8a2a                	mv	s4,a0
ffffffffc0202096:	4c050263          	beqz	a0,ffffffffc020255a <swap_init+0x59e>
ffffffffc020209a:	0000e797          	auipc	a5,0xe
ffffffffc020209e:	01e78793          	addi	a5,a5,30 # ffffffffc02100b8 <check_mm_struct>
ffffffffc02020a2:	6398                	ld	a4,0(a5)
ffffffffc02020a4:	4c071b63          	bnez	a4,ffffffffc020257a <swap_init+0x5be>
ffffffffc02020a8:	0000eb17          	auipc	s6,0xe
ffffffffc02020ac:	fa8b3b03          	ld	s6,-88(s6) # ffffffffc0210050 <boot_pgdir>
ffffffffc02020b0:	000b3703          	ld	a4,0(s6)
ffffffffc02020b4:	e388                	sd	a0,0(a5)
ffffffffc02020b6:	01653c23          	sd	s6,24(a0)
ffffffffc02020ba:	4e071063          	bnez	a4,ffffffffc020259a <swap_init+0x5de>
ffffffffc02020be:	6599                	lui	a1,0x6
ffffffffc02020c0:	460d                	li	a2,3
ffffffffc02020c2:	6505                	lui	a0,0x1
ffffffffc02020c4:	f80ff0ef          	jal	ra,ffffffffc0201844 <vma_create>
ffffffffc02020c8:	85aa                	mv	a1,a0
ffffffffc02020ca:	4e050863          	beqz	a0,ffffffffc02025ba <swap_init+0x5fe>
ffffffffc02020ce:	8552                	mv	a0,s4
ffffffffc02020d0:	fe2ff0ef          	jal	ra,ffffffffc02018b2 <insert_vma_struct>
ffffffffc02020d4:	00003517          	auipc	a0,0x3
ffffffffc02020d8:	d4450513          	addi	a0,a0,-700 # ffffffffc0204e18 <etext+0x112c>
ffffffffc02020dc:	fdbfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02020e0:	018a3503          	ld	a0,24(s4)
ffffffffc02020e4:	4605                	li	a2,1
ffffffffc02020e6:	6585                	lui	a1,0x1
ffffffffc02020e8:	fe4fe0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc02020ec:	3c050763          	beqz	a0,ffffffffc02024ba <swap_init+0x4fe>
ffffffffc02020f0:	00003517          	auipc	a0,0x3
ffffffffc02020f4:	d7850513          	addi	a0,a0,-648 # ffffffffc0204e68 <etext+0x117c>
ffffffffc02020f8:	0000e917          	auipc	s2,0xe
ffffffffc02020fc:	fc890913          	addi	s2,s2,-56 # ffffffffc02100c0 <check_rp>
ffffffffc0202100:	fb7fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202104:	0000e997          	auipc	s3,0xe
ffffffffc0202108:	fdc98993          	addi	s3,s3,-36 # ffffffffc02100e0 <swap_in_seq_no>
ffffffffc020210c:	8bca                	mv	s7,s2
ffffffffc020210e:	4505                	li	a0,1
ffffffffc0202110:	eacfe0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202114:	00abb023          	sd	a0,0(s7)
ffffffffc0202118:	26050563          	beqz	a0,ffffffffc0202382 <swap_init+0x3c6>
ffffffffc020211c:	651c                	ld	a5,8(a0)
ffffffffc020211e:	8b89                	andi	a5,a5,2
ffffffffc0202120:	24079163          	bnez	a5,ffffffffc0202362 <swap_init+0x3a6>
ffffffffc0202124:	0ba1                	addi	s7,s7,8
ffffffffc0202126:	ff3b94e3          	bne	s7,s3,ffffffffc020210e <swap_init+0x152>
ffffffffc020212a:	601c                	ld	a5,0(s0)
ffffffffc020212c:	0000eb97          	auipc	s7,0xe
ffffffffc0202130:	f94b8b93          	addi	s7,s7,-108 # ffffffffc02100c0 <check_rp>
ffffffffc0202134:	e000                	sd	s0,0(s0)
ffffffffc0202136:	e43e                	sd	a5,8(sp)
ffffffffc0202138:	641c                	ld	a5,8(s0)
ffffffffc020213a:	e400                	sd	s0,8(s0)
ffffffffc020213c:	e83e                	sd	a5,16(sp)
ffffffffc020213e:	481c                	lw	a5,16(s0)
ffffffffc0202140:	ec3e                	sd	a5,24(sp)
ffffffffc0202142:	0000e797          	auipc	a5,0xe
ffffffffc0202146:	0407ab23          	sw	zero,86(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc020214a:	000bb503          	ld	a0,0(s7)
ffffffffc020214e:	4585                	li	a1,1
ffffffffc0202150:	0ba1                	addi	s7,s7,8
ffffffffc0202152:	efcfe0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202156:	ff3b9ae3          	bne	s7,s3,ffffffffc020214a <swap_init+0x18e>
ffffffffc020215a:	01042b83          	lw	s7,16(s0)
ffffffffc020215e:	4791                	li	a5,4
ffffffffc0202160:	32fb9d63          	bne	s7,a5,ffffffffc020249a <swap_init+0x4de>
ffffffffc0202164:	00003517          	auipc	a0,0x3
ffffffffc0202168:	d8c50513          	addi	a0,a0,-628 # ffffffffc0204ef0 <etext+0x1204>
ffffffffc020216c:	f4bfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202170:	6705                	lui	a4,0x1
ffffffffc0202172:	0000e797          	auipc	a5,0xe
ffffffffc0202176:	ee07a723          	sw	zero,-274(a5) # ffffffffc0210060 <pgfault_num>
ffffffffc020217a:	4629                	li	a2,10
ffffffffc020217c:	00c70023          	sb	a2,0(a4) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc0202180:	0000e697          	auipc	a3,0xe
ffffffffc0202184:	ee06a683          	lw	a3,-288(a3) # ffffffffc0210060 <pgfault_num>
ffffffffc0202188:	4585                	li	a1,1
ffffffffc020218a:	0000e797          	auipc	a5,0xe
ffffffffc020218e:	ed678793          	addi	a5,a5,-298 # ffffffffc0210060 <pgfault_num>
ffffffffc0202192:	2cb69463          	bne	a3,a1,ffffffffc020245a <swap_init+0x49e>
ffffffffc0202196:	00c70823          	sb	a2,16(a4)
ffffffffc020219a:	4398                	lw	a4,0(a5)
ffffffffc020219c:	2701                	sext.w	a4,a4
ffffffffc020219e:	2cd71e63          	bne	a4,a3,ffffffffc020247a <swap_init+0x4be>
ffffffffc02021a2:	6689                	lui	a3,0x2
ffffffffc02021a4:	462d                	li	a2,11
ffffffffc02021a6:	00c68023          	sb	a2,0(a3) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc02021aa:	4398                	lw	a4,0(a5)
ffffffffc02021ac:	4589                	li	a1,2
ffffffffc02021ae:	2701                	sext.w	a4,a4
ffffffffc02021b0:	22b71563          	bne	a4,a1,ffffffffc02023da <swap_init+0x41e>
ffffffffc02021b4:	00c68823          	sb	a2,16(a3)
ffffffffc02021b8:	4394                	lw	a3,0(a5)
ffffffffc02021ba:	2681                	sext.w	a3,a3
ffffffffc02021bc:	22e69f63          	bne	a3,a4,ffffffffc02023fa <swap_init+0x43e>
ffffffffc02021c0:	668d                	lui	a3,0x3
ffffffffc02021c2:	4631                	li	a2,12
ffffffffc02021c4:	00c68023          	sb	a2,0(a3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc02021c8:	4398                	lw	a4,0(a5)
ffffffffc02021ca:	458d                	li	a1,3
ffffffffc02021cc:	2701                	sext.w	a4,a4
ffffffffc02021ce:	24b71663          	bne	a4,a1,ffffffffc020241a <swap_init+0x45e>
ffffffffc02021d2:	00c68823          	sb	a2,16(a3)
ffffffffc02021d6:	4394                	lw	a3,0(a5)
ffffffffc02021d8:	2681                	sext.w	a3,a3
ffffffffc02021da:	26e69063          	bne	a3,a4,ffffffffc020243a <swap_init+0x47e>
ffffffffc02021de:	6691                	lui	a3,0x4
ffffffffc02021e0:	4635                	li	a2,13
ffffffffc02021e2:	00c68023          	sb	a2,0(a3) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc02021e6:	4398                	lw	a4,0(a5)
ffffffffc02021e8:	2701                	sext.w	a4,a4
ffffffffc02021ea:	2f771863          	bne	a4,s7,ffffffffc02024da <swap_init+0x51e>
ffffffffc02021ee:	00c68823          	sb	a2,16(a3)
ffffffffc02021f2:	439c                	lw	a5,0(a5)
ffffffffc02021f4:	2781                	sext.w	a5,a5
ffffffffc02021f6:	30e79263          	bne	a5,a4,ffffffffc02024fa <swap_init+0x53e>
ffffffffc02021fa:	481c                	lw	a5,16(s0)
ffffffffc02021fc:	30079f63          	bnez	a5,ffffffffc020251a <swap_init+0x55e>
ffffffffc0202200:	0000e797          	auipc	a5,0xe
ffffffffc0202204:	ee078793          	addi	a5,a5,-288 # ffffffffc02100e0 <swap_in_seq_no>
ffffffffc0202208:	0000e717          	auipc	a4,0xe
ffffffffc020220c:	f0070713          	addi	a4,a4,-256 # ffffffffc0210108 <swap_out_seq_no>
ffffffffc0202210:	0000e617          	auipc	a2,0xe
ffffffffc0202214:	ef860613          	addi	a2,a2,-264 # ffffffffc0210108 <swap_out_seq_no>
ffffffffc0202218:	56fd                	li	a3,-1
ffffffffc020221a:	c394                	sw	a3,0(a5)
ffffffffc020221c:	c314                	sw	a3,0(a4)
ffffffffc020221e:	0791                	addi	a5,a5,4
ffffffffc0202220:	0711                	addi	a4,a4,4
ffffffffc0202222:	fef61ce3          	bne	a2,a5,ffffffffc020221a <swap_init+0x25e>
ffffffffc0202226:	0000e697          	auipc	a3,0xe
ffffffffc020222a:	f4268693          	addi	a3,a3,-190 # ffffffffc0210168 <check_ptep>
ffffffffc020222e:	0000ec17          	auipc	s8,0xe
ffffffffc0202232:	e92c0c13          	addi	s8,s8,-366 # ffffffffc02100c0 <check_rp>
ffffffffc0202236:	6b85                	lui	s7,0x1
ffffffffc0202238:	0000ed97          	auipc	s11,0xe
ffffffffc020223c:	e20d8d93          	addi	s11,s11,-480 # ffffffffc0210058 <npage>
ffffffffc0202240:	0000ed17          	auipc	s10,0xe
ffffffffc0202244:	e70d0d13          	addi	s10,s10,-400 # ffffffffc02100b0 <pages>
ffffffffc0202248:	00003c97          	auipc	s9,0x3
ffffffffc020224c:	6a8c8c93          	addi	s9,s9,1704 # ffffffffc02058f0 <nbase>
ffffffffc0202250:	0006b023          	sd	zero,0(a3)
ffffffffc0202254:	4601                	li	a2,0
ffffffffc0202256:	85de                	mv	a1,s7
ffffffffc0202258:	855a                	mv	a0,s6
ffffffffc020225a:	e036                	sd	a3,0(sp)
ffffffffc020225c:	e70fe0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0202260:	6682                	ld	a3,0(sp)
ffffffffc0202262:	e288                	sd	a0,0(a3)
ffffffffc0202264:	12050f63          	beqz	a0,ffffffffc02023a2 <swap_init+0x3e6>
ffffffffc0202268:	611c                	ld	a5,0(a0)
ffffffffc020226a:	0017f713          	andi	a4,a5,1
ffffffffc020226e:	c371                	beqz	a4,ffffffffc0202332 <swap_init+0x376>
ffffffffc0202270:	000db703          	ld	a4,0(s11)
ffffffffc0202274:	078a                	slli	a5,a5,0x2
ffffffffc0202276:	83b1                	srli	a5,a5,0xc
ffffffffc0202278:	0ce7f963          	bgeu	a5,a4,ffffffffc020234a <swap_init+0x38e>
ffffffffc020227c:	000cb703          	ld	a4,0(s9)
ffffffffc0202280:	000d3603          	ld	a2,0(s10)
ffffffffc0202284:	000c3503          	ld	a0,0(s8)
ffffffffc0202288:	8f99                	sub	a5,a5,a4
ffffffffc020228a:	00379713          	slli	a4,a5,0x3
ffffffffc020228e:	97ba                	add	a5,a5,a4
ffffffffc0202290:	078e                	slli	a5,a5,0x3
ffffffffc0202292:	97b2                	add	a5,a5,a2
ffffffffc0202294:	06f51f63          	bne	a0,a5,ffffffffc0202312 <swap_init+0x356>
ffffffffc0202298:	6785                	lui	a5,0x1
ffffffffc020229a:	9bbe                	add	s7,s7,a5
ffffffffc020229c:	6795                	lui	a5,0x5
ffffffffc020229e:	06a1                	addi	a3,a3,8
ffffffffc02022a0:	0c21                	addi	s8,s8,8
ffffffffc02022a2:	fafb97e3          	bne	s7,a5,ffffffffc0202250 <swap_init+0x294>
ffffffffc02022a6:	00003517          	auipc	a0,0x3
ffffffffc02022aa:	d0250513          	addi	a0,a0,-766 # ffffffffc0204fa8 <etext+0x12bc>
ffffffffc02022ae:	e09fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02022b2:	000ab783          	ld	a5,0(s5)
ffffffffc02022b6:	7f9c                	ld	a5,56(a5)
ffffffffc02022b8:	9782                	jalr	a5
ffffffffc02022ba:	28051063          	bnez	a0,ffffffffc020253a <swap_init+0x57e>
ffffffffc02022be:	00093503          	ld	a0,0(s2)
ffffffffc02022c2:	4585                	li	a1,1
ffffffffc02022c4:	0921                	addi	s2,s2,8
ffffffffc02022c6:	d88fe0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02022ca:	ff391ae3          	bne	s2,s3,ffffffffc02022be <swap_init+0x302>
ffffffffc02022ce:	8552                	mv	a0,s4
ffffffffc02022d0:	eb2ff0ef          	jal	ra,ffffffffc0201982 <mm_destroy>
ffffffffc02022d4:	67e2                	ld	a5,24(sp)
ffffffffc02022d6:	00003517          	auipc	a0,0x3
ffffffffc02022da:	d0250513          	addi	a0,a0,-766 # ffffffffc0204fd8 <etext+0x12ec>
ffffffffc02022de:	c81c                	sw	a5,16(s0)
ffffffffc02022e0:	67a2                	ld	a5,8(sp)
ffffffffc02022e2:	e01c                	sd	a5,0(s0)
ffffffffc02022e4:	67c2                	ld	a5,16(sp)
ffffffffc02022e6:	e41c                	sd	a5,8(s0)
ffffffffc02022e8:	dcffd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02022ec:	b30d                	j	ffffffffc020200e <swap_init+0x52>
ffffffffc02022ee:	4a01                	li	s4,0
ffffffffc02022f0:	b361                	j	ffffffffc0202078 <swap_init+0xbc>
ffffffffc02022f2:	00003697          	auipc	a3,0x3
ffffffffc02022f6:	ab668693          	addi	a3,a3,-1354 # ffffffffc0204da8 <etext+0x10bc>
ffffffffc02022fa:	00002617          	auipc	a2,0x2
ffffffffc02022fe:	22e60613          	addi	a2,a2,558 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202302:	0c500593          	li	a1,197
ffffffffc0202306:	00003517          	auipc	a0,0x3
ffffffffc020230a:	a7a50513          	addi	a0,a0,-1414 # ffffffffc0204d80 <etext+0x1094>
ffffffffc020230e:	ddffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202312:	00003697          	auipc	a3,0x3
ffffffffc0202316:	c6e68693          	addi	a3,a3,-914 # ffffffffc0204f80 <etext+0x1294>
ffffffffc020231a:	00002617          	auipc	a2,0x2
ffffffffc020231e:	20e60613          	addi	a2,a2,526 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202322:	10400593          	li	a1,260
ffffffffc0202326:	00003517          	auipc	a0,0x3
ffffffffc020232a:	a5a50513          	addi	a0,a0,-1446 # ffffffffc0204d80 <etext+0x1094>
ffffffffc020232e:	dbffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202332:	00002617          	auipc	a2,0x2
ffffffffc0202336:	2ce60613          	addi	a2,a2,718 # ffffffffc0204600 <etext+0x914>
ffffffffc020233a:	07000593          	li	a1,112
ffffffffc020233e:	00002517          	auipc	a0,0x2
ffffffffc0202342:	0b250513          	addi	a0,a0,178 # ffffffffc02043f0 <etext+0x704>
ffffffffc0202346:	da7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020234a:	00002617          	auipc	a2,0x2
ffffffffc020234e:	08660613          	addi	a2,a2,134 # ffffffffc02043d0 <etext+0x6e4>
ffffffffc0202352:	06500593          	li	a1,101
ffffffffc0202356:	00002517          	auipc	a0,0x2
ffffffffc020235a:	09a50513          	addi	a0,a0,154 # ffffffffc02043f0 <etext+0x704>
ffffffffc020235e:	d8ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202362:	00003697          	auipc	a3,0x3
ffffffffc0202366:	b4668693          	addi	a3,a3,-1210 # ffffffffc0204ea8 <etext+0x11bc>
ffffffffc020236a:	00002617          	auipc	a2,0x2
ffffffffc020236e:	1be60613          	addi	a2,a2,446 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202372:	0e600593          	li	a1,230
ffffffffc0202376:	00003517          	auipc	a0,0x3
ffffffffc020237a:	a0a50513          	addi	a0,a0,-1526 # ffffffffc0204d80 <etext+0x1094>
ffffffffc020237e:	d6ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202382:	00003697          	auipc	a3,0x3
ffffffffc0202386:	b0e68693          	addi	a3,a3,-1266 # ffffffffc0204e90 <etext+0x11a4>
ffffffffc020238a:	00002617          	auipc	a2,0x2
ffffffffc020238e:	19e60613          	addi	a2,a2,414 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202392:	0e500593          	li	a1,229
ffffffffc0202396:	00003517          	auipc	a0,0x3
ffffffffc020239a:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0204d80 <etext+0x1094>
ffffffffc020239e:	d4ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02023a2:	00003697          	auipc	a3,0x3
ffffffffc02023a6:	bc668693          	addi	a3,a3,-1082 # ffffffffc0204f68 <etext+0x127c>
ffffffffc02023aa:	00002617          	auipc	a2,0x2
ffffffffc02023ae:	17e60613          	addi	a2,a2,382 # ffffffffc0204528 <etext+0x83c>
ffffffffc02023b2:	10300593          	li	a1,259
ffffffffc02023b6:	00003517          	auipc	a0,0x3
ffffffffc02023ba:	9ca50513          	addi	a0,a0,-1590 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02023be:	d2ffd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02023c2:	00003617          	auipc	a2,0x3
ffffffffc02023c6:	99e60613          	addi	a2,a2,-1634 # ffffffffc0204d60 <etext+0x1074>
ffffffffc02023ca:	02800593          	li	a1,40
ffffffffc02023ce:	00003517          	auipc	a0,0x3
ffffffffc02023d2:	9b250513          	addi	a0,a0,-1614 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02023d6:	d17fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02023da:	00003697          	auipc	a3,0x3
ffffffffc02023de:	b4e68693          	addi	a3,a3,-1202 # ffffffffc0204f28 <etext+0x123c>
ffffffffc02023e2:	00002617          	auipc	a2,0x2
ffffffffc02023e6:	14660613          	addi	a2,a2,326 # ffffffffc0204528 <etext+0x83c>
ffffffffc02023ea:	0a000593          	li	a1,160
ffffffffc02023ee:	00003517          	auipc	a0,0x3
ffffffffc02023f2:	99250513          	addi	a0,a0,-1646 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02023f6:	cf7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02023fa:	00003697          	auipc	a3,0x3
ffffffffc02023fe:	b2e68693          	addi	a3,a3,-1234 # ffffffffc0204f28 <etext+0x123c>
ffffffffc0202402:	00002617          	auipc	a2,0x2
ffffffffc0202406:	12660613          	addi	a2,a2,294 # ffffffffc0204528 <etext+0x83c>
ffffffffc020240a:	0a200593          	li	a1,162
ffffffffc020240e:	00003517          	auipc	a0,0x3
ffffffffc0202412:	97250513          	addi	a0,a0,-1678 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202416:	cd7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020241a:	00003697          	auipc	a3,0x3
ffffffffc020241e:	b1e68693          	addi	a3,a3,-1250 # ffffffffc0204f38 <etext+0x124c>
ffffffffc0202422:	00002617          	auipc	a2,0x2
ffffffffc0202426:	10660613          	addi	a2,a2,262 # ffffffffc0204528 <etext+0x83c>
ffffffffc020242a:	0a400593          	li	a1,164
ffffffffc020242e:	00003517          	auipc	a0,0x3
ffffffffc0202432:	95250513          	addi	a0,a0,-1710 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202436:	cb7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020243a:	00003697          	auipc	a3,0x3
ffffffffc020243e:	afe68693          	addi	a3,a3,-1282 # ffffffffc0204f38 <etext+0x124c>
ffffffffc0202442:	00002617          	auipc	a2,0x2
ffffffffc0202446:	0e660613          	addi	a2,a2,230 # ffffffffc0204528 <etext+0x83c>
ffffffffc020244a:	0a600593          	li	a1,166
ffffffffc020244e:	00003517          	auipc	a0,0x3
ffffffffc0202452:	93250513          	addi	a0,a0,-1742 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202456:	c97fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020245a:	00003697          	auipc	a3,0x3
ffffffffc020245e:	abe68693          	addi	a3,a3,-1346 # ffffffffc0204f18 <etext+0x122c>
ffffffffc0202462:	00002617          	auipc	a2,0x2
ffffffffc0202466:	0c660613          	addi	a2,a2,198 # ffffffffc0204528 <etext+0x83c>
ffffffffc020246a:	09c00593          	li	a1,156
ffffffffc020246e:	00003517          	auipc	a0,0x3
ffffffffc0202472:	91250513          	addi	a0,a0,-1774 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202476:	c77fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020247a:	00003697          	auipc	a3,0x3
ffffffffc020247e:	a9e68693          	addi	a3,a3,-1378 # ffffffffc0204f18 <etext+0x122c>
ffffffffc0202482:	00002617          	auipc	a2,0x2
ffffffffc0202486:	0a660613          	addi	a2,a2,166 # ffffffffc0204528 <etext+0x83c>
ffffffffc020248a:	09e00593          	li	a1,158
ffffffffc020248e:	00003517          	auipc	a0,0x3
ffffffffc0202492:	8f250513          	addi	a0,a0,-1806 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202496:	c57fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020249a:	00003697          	auipc	a3,0x3
ffffffffc020249e:	a2e68693          	addi	a3,a3,-1490 # ffffffffc0204ec8 <etext+0x11dc>
ffffffffc02024a2:	00002617          	auipc	a2,0x2
ffffffffc02024a6:	08660613          	addi	a2,a2,134 # ffffffffc0204528 <etext+0x83c>
ffffffffc02024aa:	0f300593          	li	a1,243
ffffffffc02024ae:	00003517          	auipc	a0,0x3
ffffffffc02024b2:	8d250513          	addi	a0,a0,-1838 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02024b6:	c37fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02024ba:	00003697          	auipc	a3,0x3
ffffffffc02024be:	99668693          	addi	a3,a3,-1642 # ffffffffc0204e50 <etext+0x1164>
ffffffffc02024c2:	00002617          	auipc	a2,0x2
ffffffffc02024c6:	06660613          	addi	a2,a2,102 # ffffffffc0204528 <etext+0x83c>
ffffffffc02024ca:	0e000593          	li	a1,224
ffffffffc02024ce:	00003517          	auipc	a0,0x3
ffffffffc02024d2:	8b250513          	addi	a0,a0,-1870 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02024d6:	c17fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02024da:	00003697          	auipc	a3,0x3
ffffffffc02024de:	a6e68693          	addi	a3,a3,-1426 # ffffffffc0204f48 <etext+0x125c>
ffffffffc02024e2:	00002617          	auipc	a2,0x2
ffffffffc02024e6:	04660613          	addi	a2,a2,70 # ffffffffc0204528 <etext+0x83c>
ffffffffc02024ea:	0a800593          	li	a1,168
ffffffffc02024ee:	00003517          	auipc	a0,0x3
ffffffffc02024f2:	89250513          	addi	a0,a0,-1902 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02024f6:	bf7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02024fa:	00003697          	auipc	a3,0x3
ffffffffc02024fe:	a4e68693          	addi	a3,a3,-1458 # ffffffffc0204f48 <etext+0x125c>
ffffffffc0202502:	00002617          	auipc	a2,0x2
ffffffffc0202506:	02660613          	addi	a2,a2,38 # ffffffffc0204528 <etext+0x83c>
ffffffffc020250a:	0aa00593          	li	a1,170
ffffffffc020250e:	00003517          	auipc	a0,0x3
ffffffffc0202512:	87250513          	addi	a0,a0,-1934 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202516:	bd7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020251a:	00003697          	auipc	a3,0x3
ffffffffc020251e:	a3e68693          	addi	a3,a3,-1474 # ffffffffc0204f58 <etext+0x126c>
ffffffffc0202522:	00002617          	auipc	a2,0x2
ffffffffc0202526:	00660613          	addi	a2,a2,6 # ffffffffc0204528 <etext+0x83c>
ffffffffc020252a:	0fc00593          	li	a1,252
ffffffffc020252e:	00003517          	auipc	a0,0x3
ffffffffc0202532:	85250513          	addi	a0,a0,-1966 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202536:	bb7fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020253a:	00003697          	auipc	a3,0x3
ffffffffc020253e:	a9668693          	addi	a3,a3,-1386 # ffffffffc0204fd0 <etext+0x12e4>
ffffffffc0202542:	00002617          	auipc	a2,0x2
ffffffffc0202546:	fe660613          	addi	a2,a2,-26 # ffffffffc0204528 <etext+0x83c>
ffffffffc020254a:	10b00593          	li	a1,267
ffffffffc020254e:	00003517          	auipc	a0,0x3
ffffffffc0202552:	83250513          	addi	a0,a0,-1998 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202556:	b97fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020255a:	00002697          	auipc	a3,0x2
ffffffffc020255e:	54e68693          	addi	a3,a3,1358 # ffffffffc0204aa8 <etext+0xdbc>
ffffffffc0202562:	00002617          	auipc	a2,0x2
ffffffffc0202566:	fc660613          	addi	a2,a2,-58 # ffffffffc0204528 <etext+0x83c>
ffffffffc020256a:	0cd00593          	li	a1,205
ffffffffc020256e:	00003517          	auipc	a0,0x3
ffffffffc0202572:	81250513          	addi	a0,a0,-2030 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202576:	b77fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020257a:	00003697          	auipc	a3,0x3
ffffffffc020257e:	88668693          	addi	a3,a3,-1914 # ffffffffc0204e00 <etext+0x1114>
ffffffffc0202582:	00002617          	auipc	a2,0x2
ffffffffc0202586:	fa660613          	addi	a2,a2,-90 # ffffffffc0204528 <etext+0x83c>
ffffffffc020258a:	0d000593          	li	a1,208
ffffffffc020258e:	00002517          	auipc	a0,0x2
ffffffffc0202592:	7f250513          	addi	a0,a0,2034 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202596:	b57fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020259a:	00002697          	auipc	a3,0x2
ffffffffc020259e:	6be68693          	addi	a3,a3,1726 # ffffffffc0204c58 <etext+0xf6c>
ffffffffc02025a2:	00002617          	auipc	a2,0x2
ffffffffc02025a6:	f8660613          	addi	a2,a2,-122 # ffffffffc0204528 <etext+0x83c>
ffffffffc02025aa:	0d500593          	li	a1,213
ffffffffc02025ae:	00002517          	auipc	a0,0x2
ffffffffc02025b2:	7d250513          	addi	a0,a0,2002 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02025b6:	b37fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02025ba:	00002697          	auipc	a3,0x2
ffffffffc02025be:	71668693          	addi	a3,a3,1814 # ffffffffc0204cd0 <etext+0xfe4>
ffffffffc02025c2:	00002617          	auipc	a2,0x2
ffffffffc02025c6:	f6660613          	addi	a2,a2,-154 # ffffffffc0204528 <etext+0x83c>
ffffffffc02025ca:	0d800593          	li	a1,216
ffffffffc02025ce:	00002517          	auipc	a0,0x2
ffffffffc02025d2:	7b250513          	addi	a0,a0,1970 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02025d6:	b17fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02025da:	00002697          	auipc	a3,0x2
ffffffffc02025de:	7de68693          	addi	a3,a3,2014 # ffffffffc0204db8 <etext+0x10cc>
ffffffffc02025e2:	00002617          	auipc	a2,0x2
ffffffffc02025e6:	f4660613          	addi	a2,a2,-186 # ffffffffc0204528 <etext+0x83c>
ffffffffc02025ea:	0c800593          	li	a1,200
ffffffffc02025ee:	00002517          	auipc	a0,0x2
ffffffffc02025f2:	79250513          	addi	a0,a0,1938 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02025f6:	af7fd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02025fa <swap_init_mm>:
ffffffffc02025fa:	0000e797          	auipc	a5,0xe
ffffffffc02025fe:	a6e7b783          	ld	a5,-1426(a5) # ffffffffc0210068 <sm>
ffffffffc0202602:	0107b303          	ld	t1,16(a5)
ffffffffc0202606:	8302                	jr	t1

ffffffffc0202608 <swap_map_swappable>:
ffffffffc0202608:	0000e797          	auipc	a5,0xe
ffffffffc020260c:	a607b783          	ld	a5,-1440(a5) # ffffffffc0210068 <sm>
ffffffffc0202610:	0207b303          	ld	t1,32(a5)
ffffffffc0202614:	8302                	jr	t1

ffffffffc0202616 <swap_out>:
ffffffffc0202616:	711d                	addi	sp,sp,-96
ffffffffc0202618:	ec86                	sd	ra,88(sp)
ffffffffc020261a:	e8a2                	sd	s0,80(sp)
ffffffffc020261c:	e4a6                	sd	s1,72(sp)
ffffffffc020261e:	e0ca                	sd	s2,64(sp)
ffffffffc0202620:	fc4e                	sd	s3,56(sp)
ffffffffc0202622:	f852                	sd	s4,48(sp)
ffffffffc0202624:	f456                	sd	s5,40(sp)
ffffffffc0202626:	f05a                	sd	s6,32(sp)
ffffffffc0202628:	ec5e                	sd	s7,24(sp)
ffffffffc020262a:	e862                	sd	s8,16(sp)
ffffffffc020262c:	cde9                	beqz	a1,ffffffffc0202706 <swap_out+0xf0>
ffffffffc020262e:	8a2e                	mv	s4,a1
ffffffffc0202630:	892a                	mv	s2,a0
ffffffffc0202632:	8ab2                	mv	s5,a2
ffffffffc0202634:	4401                	li	s0,0
ffffffffc0202636:	0000e997          	auipc	s3,0xe
ffffffffc020263a:	a3298993          	addi	s3,s3,-1486 # ffffffffc0210068 <sm>
ffffffffc020263e:	00003b17          	auipc	s6,0x3
ffffffffc0202642:	a1ab0b13          	addi	s6,s6,-1510 # ffffffffc0205058 <etext+0x136c>
ffffffffc0202646:	00003b97          	auipc	s7,0x3
ffffffffc020264a:	9fab8b93          	addi	s7,s7,-1542 # ffffffffc0205040 <etext+0x1354>
ffffffffc020264e:	a825                	j	ffffffffc0202686 <swap_out+0x70>
ffffffffc0202650:	67a2                	ld	a5,8(sp)
ffffffffc0202652:	8626                	mv	a2,s1
ffffffffc0202654:	85a2                	mv	a1,s0
ffffffffc0202656:	63b4                	ld	a3,64(a5)
ffffffffc0202658:	855a                	mv	a0,s6
ffffffffc020265a:	2405                	addiw	s0,s0,1
ffffffffc020265c:	82b1                	srli	a3,a3,0xc
ffffffffc020265e:	0685                	addi	a3,a3,1
ffffffffc0202660:	a57fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202664:	6522                	ld	a0,8(sp)
ffffffffc0202666:	4585                	li	a1,1
ffffffffc0202668:	613c                	ld	a5,64(a0)
ffffffffc020266a:	83b1                	srli	a5,a5,0xc
ffffffffc020266c:	0785                	addi	a5,a5,1
ffffffffc020266e:	07a2                	slli	a5,a5,0x8
ffffffffc0202670:	00fc3023          	sd	a5,0(s8)
ffffffffc0202674:	9dafe0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202678:	01893503          	ld	a0,24(s2)
ffffffffc020267c:	85a6                	mv	a1,s1
ffffffffc020267e:	f57fe0ef          	jal	ra,ffffffffc02015d4 <tlb_invalidate>
ffffffffc0202682:	048a0d63          	beq	s4,s0,ffffffffc02026dc <swap_out+0xc6>
ffffffffc0202686:	0009b783          	ld	a5,0(s3)
ffffffffc020268a:	8656                	mv	a2,s5
ffffffffc020268c:	002c                	addi	a1,sp,8
ffffffffc020268e:	7b9c                	ld	a5,48(a5)
ffffffffc0202690:	854a                	mv	a0,s2
ffffffffc0202692:	9782                	jalr	a5
ffffffffc0202694:	e12d                	bnez	a0,ffffffffc02026f6 <swap_out+0xe0>
ffffffffc0202696:	67a2                	ld	a5,8(sp)
ffffffffc0202698:	01893503          	ld	a0,24(s2)
ffffffffc020269c:	4601                	li	a2,0
ffffffffc020269e:	63a4                	ld	s1,64(a5)
ffffffffc02026a0:	85a6                	mv	a1,s1
ffffffffc02026a2:	a2afe0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc02026a6:	611c                	ld	a5,0(a0)
ffffffffc02026a8:	8c2a                	mv	s8,a0
ffffffffc02026aa:	8b85                	andi	a5,a5,1
ffffffffc02026ac:	cfb9                	beqz	a5,ffffffffc020270a <swap_out+0xf4>
ffffffffc02026ae:	65a2                	ld	a1,8(sp)
ffffffffc02026b0:	61bc                	ld	a5,64(a1)
ffffffffc02026b2:	83b1                	srli	a5,a5,0xc
ffffffffc02026b4:	0785                	addi	a5,a5,1
ffffffffc02026b6:	00879513          	slli	a0,a5,0x8
ffffffffc02026ba:	11a010ef          	jal	ra,ffffffffc02037d4 <swapfs_write>
ffffffffc02026be:	d949                	beqz	a0,ffffffffc0202650 <swap_out+0x3a>
ffffffffc02026c0:	855e                	mv	a0,s7
ffffffffc02026c2:	9f5fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02026c6:	0009b783          	ld	a5,0(s3)
ffffffffc02026ca:	6622                	ld	a2,8(sp)
ffffffffc02026cc:	4681                	li	a3,0
ffffffffc02026ce:	739c                	ld	a5,32(a5)
ffffffffc02026d0:	85a6                	mv	a1,s1
ffffffffc02026d2:	854a                	mv	a0,s2
ffffffffc02026d4:	2405                	addiw	s0,s0,1
ffffffffc02026d6:	9782                	jalr	a5
ffffffffc02026d8:	fa8a17e3          	bne	s4,s0,ffffffffc0202686 <swap_out+0x70>
ffffffffc02026dc:	60e6                	ld	ra,88(sp)
ffffffffc02026de:	8522                	mv	a0,s0
ffffffffc02026e0:	6446                	ld	s0,80(sp)
ffffffffc02026e2:	64a6                	ld	s1,72(sp)
ffffffffc02026e4:	6906                	ld	s2,64(sp)
ffffffffc02026e6:	79e2                	ld	s3,56(sp)
ffffffffc02026e8:	7a42                	ld	s4,48(sp)
ffffffffc02026ea:	7aa2                	ld	s5,40(sp)
ffffffffc02026ec:	7b02                	ld	s6,32(sp)
ffffffffc02026ee:	6be2                	ld	s7,24(sp)
ffffffffc02026f0:	6c42                	ld	s8,16(sp)
ffffffffc02026f2:	6125                	addi	sp,sp,96
ffffffffc02026f4:	8082                	ret
ffffffffc02026f6:	85a2                	mv	a1,s0
ffffffffc02026f8:	00003517          	auipc	a0,0x3
ffffffffc02026fc:	90050513          	addi	a0,a0,-1792 # ffffffffc0204ff8 <etext+0x130c>
ffffffffc0202700:	9b7fd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202704:	bfe1                	j	ffffffffc02026dc <swap_out+0xc6>
ffffffffc0202706:	4401                	li	s0,0
ffffffffc0202708:	bfd1                	j	ffffffffc02026dc <swap_out+0xc6>
ffffffffc020270a:	00003697          	auipc	a3,0x3
ffffffffc020270e:	91e68693          	addi	a3,a3,-1762 # ffffffffc0205028 <etext+0x133c>
ffffffffc0202712:	00002617          	auipc	a2,0x2
ffffffffc0202716:	e1660613          	addi	a2,a2,-490 # ffffffffc0204528 <etext+0x83c>
ffffffffc020271a:	07200593          	li	a1,114
ffffffffc020271e:	00002517          	auipc	a0,0x2
ffffffffc0202722:	66250513          	addi	a0,a0,1634 # ffffffffc0204d80 <etext+0x1094>
ffffffffc0202726:	9c7fd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc020272a <swap_in>:
ffffffffc020272a:	7179                	addi	sp,sp,-48
ffffffffc020272c:	e84a                	sd	s2,16(sp)
ffffffffc020272e:	892a                	mv	s2,a0
ffffffffc0202730:	4505                	li	a0,1
ffffffffc0202732:	ec26                	sd	s1,24(sp)
ffffffffc0202734:	e44e                	sd	s3,8(sp)
ffffffffc0202736:	f406                	sd	ra,40(sp)
ffffffffc0202738:	f022                	sd	s0,32(sp)
ffffffffc020273a:	84ae                	mv	s1,a1
ffffffffc020273c:	89b2                	mv	s3,a2
ffffffffc020273e:	87efe0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202742:	c129                	beqz	a0,ffffffffc0202784 <swap_in+0x5a>
ffffffffc0202744:	842a                	mv	s0,a0
ffffffffc0202746:	01893503          	ld	a0,24(s2)
ffffffffc020274a:	4601                	li	a2,0
ffffffffc020274c:	85a6                	mv	a1,s1
ffffffffc020274e:	97efe0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0202752:	892a                	mv	s2,a0
ffffffffc0202754:	6108                	ld	a0,0(a0)
ffffffffc0202756:	85a2                	mv	a1,s0
ffffffffc0202758:	7e3000ef          	jal	ra,ffffffffc020373a <swapfs_read>
ffffffffc020275c:	00093583          	ld	a1,0(s2)
ffffffffc0202760:	8626                	mv	a2,s1
ffffffffc0202762:	00003517          	auipc	a0,0x3
ffffffffc0202766:	94650513          	addi	a0,a0,-1722 # ffffffffc02050a8 <etext+0x13bc>
ffffffffc020276a:	81a1                	srli	a1,a1,0x8
ffffffffc020276c:	94bfd0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0202770:	70a2                	ld	ra,40(sp)
ffffffffc0202772:	0089b023          	sd	s0,0(s3)
ffffffffc0202776:	7402                	ld	s0,32(sp)
ffffffffc0202778:	64e2                	ld	s1,24(sp)
ffffffffc020277a:	6942                	ld	s2,16(sp)
ffffffffc020277c:	69a2                	ld	s3,8(sp)
ffffffffc020277e:	4501                	li	a0,0
ffffffffc0202780:	6145                	addi	sp,sp,48
ffffffffc0202782:	8082                	ret
ffffffffc0202784:	00003697          	auipc	a3,0x3
ffffffffc0202788:	91468693          	addi	a3,a3,-1772 # ffffffffc0205098 <etext+0x13ac>
ffffffffc020278c:	00002617          	auipc	a2,0x2
ffffffffc0202790:	d9c60613          	addi	a2,a2,-612 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202794:	08800593          	li	a1,136
ffffffffc0202798:	00002517          	auipc	a0,0x2
ffffffffc020279c:	5e850513          	addi	a0,a0,1512 # ffffffffc0204d80 <etext+0x1094>
ffffffffc02027a0:	94dfd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02027a4 <default_init>:
ffffffffc02027a4:	0000e797          	auipc	a5,0xe
ffffffffc02027a8:	9e478793          	addi	a5,a5,-1564 # ffffffffc0210188 <free_area>
ffffffffc02027ac:	e79c                	sd	a5,8(a5)
ffffffffc02027ae:	e39c                	sd	a5,0(a5)
ffffffffc02027b0:	0007a823          	sw	zero,16(a5)
ffffffffc02027b4:	8082                	ret

ffffffffc02027b6 <default_nr_free_pages>:
ffffffffc02027b6:	0000e517          	auipc	a0,0xe
ffffffffc02027ba:	9e256503          	lwu	a0,-1566(a0) # ffffffffc0210198 <free_area+0x10>
ffffffffc02027be:	8082                	ret

ffffffffc02027c0 <default_check>:
ffffffffc02027c0:	715d                	addi	sp,sp,-80
ffffffffc02027c2:	e0a2                	sd	s0,64(sp)
ffffffffc02027c4:	0000e417          	auipc	s0,0xe
ffffffffc02027c8:	9c440413          	addi	s0,s0,-1596 # ffffffffc0210188 <free_area>
ffffffffc02027cc:	641c                	ld	a5,8(s0)
ffffffffc02027ce:	e486                	sd	ra,72(sp)
ffffffffc02027d0:	fc26                	sd	s1,56(sp)
ffffffffc02027d2:	f84a                	sd	s2,48(sp)
ffffffffc02027d4:	f44e                	sd	s3,40(sp)
ffffffffc02027d6:	f052                	sd	s4,32(sp)
ffffffffc02027d8:	ec56                	sd	s5,24(sp)
ffffffffc02027da:	e85a                	sd	s6,16(sp)
ffffffffc02027dc:	e45e                	sd	s7,8(sp)
ffffffffc02027de:	e062                	sd	s8,0(sp)
ffffffffc02027e0:	2c878763          	beq	a5,s0,ffffffffc0202aae <default_check+0x2ee>
ffffffffc02027e4:	4481                	li	s1,0
ffffffffc02027e6:	4901                	li	s2,0
ffffffffc02027e8:	fe87b703          	ld	a4,-24(a5)
ffffffffc02027ec:	8b09                	andi	a4,a4,2
ffffffffc02027ee:	2c070463          	beqz	a4,ffffffffc0202ab6 <default_check+0x2f6>
ffffffffc02027f2:	ff87a703          	lw	a4,-8(a5)
ffffffffc02027f6:	679c                	ld	a5,8(a5)
ffffffffc02027f8:	2905                	addiw	s2,s2,1
ffffffffc02027fa:	9cb9                	addw	s1,s1,a4
ffffffffc02027fc:	fe8796e3          	bne	a5,s0,ffffffffc02027e8 <default_check+0x28>
ffffffffc0202800:	89a6                	mv	s3,s1
ffffffffc0202802:	88efe0ef          	jal	ra,ffffffffc0200890 <nr_free_pages>
ffffffffc0202806:	71351863          	bne	a0,s3,ffffffffc0202f16 <default_check+0x756>
ffffffffc020280a:	4505                	li	a0,1
ffffffffc020280c:	fb1fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202810:	8a2a                	mv	s4,a0
ffffffffc0202812:	44050263          	beqz	a0,ffffffffc0202c56 <default_check+0x496>
ffffffffc0202816:	4505                	li	a0,1
ffffffffc0202818:	fa5fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc020281c:	89aa                	mv	s3,a0
ffffffffc020281e:	70050c63          	beqz	a0,ffffffffc0202f36 <default_check+0x776>
ffffffffc0202822:	4505                	li	a0,1
ffffffffc0202824:	f99fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202828:	8aaa                	mv	s5,a0
ffffffffc020282a:	4a050663          	beqz	a0,ffffffffc0202cd6 <default_check+0x516>
ffffffffc020282e:	2b3a0463          	beq	s4,s3,ffffffffc0202ad6 <default_check+0x316>
ffffffffc0202832:	2aaa0263          	beq	s4,a0,ffffffffc0202ad6 <default_check+0x316>
ffffffffc0202836:	2aa98063          	beq	s3,a0,ffffffffc0202ad6 <default_check+0x316>
ffffffffc020283a:	000a2783          	lw	a5,0(s4)
ffffffffc020283e:	2a079c63          	bnez	a5,ffffffffc0202af6 <default_check+0x336>
ffffffffc0202842:	0009a783          	lw	a5,0(s3)
ffffffffc0202846:	2a079863          	bnez	a5,ffffffffc0202af6 <default_check+0x336>
ffffffffc020284a:	411c                	lw	a5,0(a0)
ffffffffc020284c:	2a079563          	bnez	a5,ffffffffc0202af6 <default_check+0x336>
ffffffffc0202850:	0000e797          	auipc	a5,0xe
ffffffffc0202854:	8607b783          	ld	a5,-1952(a5) # ffffffffc02100b0 <pages>
ffffffffc0202858:	40fa0733          	sub	a4,s4,a5
ffffffffc020285c:	870d                	srai	a4,a4,0x3
ffffffffc020285e:	00003597          	auipc	a1,0x3
ffffffffc0202862:	08a5b583          	ld	a1,138(a1) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0202866:	02b70733          	mul	a4,a4,a1
ffffffffc020286a:	00003617          	auipc	a2,0x3
ffffffffc020286e:	08663603          	ld	a2,134(a2) # ffffffffc02058f0 <nbase>
ffffffffc0202872:	0000d697          	auipc	a3,0xd
ffffffffc0202876:	7e66b683          	ld	a3,2022(a3) # ffffffffc0210058 <npage>
ffffffffc020287a:	06b2                	slli	a3,a3,0xc
ffffffffc020287c:	9732                	add	a4,a4,a2
ffffffffc020287e:	0732                	slli	a4,a4,0xc
ffffffffc0202880:	28d77b63          	bgeu	a4,a3,ffffffffc0202b16 <default_check+0x356>
ffffffffc0202884:	40f98733          	sub	a4,s3,a5
ffffffffc0202888:	870d                	srai	a4,a4,0x3
ffffffffc020288a:	02b70733          	mul	a4,a4,a1
ffffffffc020288e:	9732                	add	a4,a4,a2
ffffffffc0202890:	0732                	slli	a4,a4,0xc
ffffffffc0202892:	4cd77263          	bgeu	a4,a3,ffffffffc0202d56 <default_check+0x596>
ffffffffc0202896:	40f507b3          	sub	a5,a0,a5
ffffffffc020289a:	878d                	srai	a5,a5,0x3
ffffffffc020289c:	02b787b3          	mul	a5,a5,a1
ffffffffc02028a0:	97b2                	add	a5,a5,a2
ffffffffc02028a2:	07b2                	slli	a5,a5,0xc
ffffffffc02028a4:	30d7f963          	bgeu	a5,a3,ffffffffc0202bb6 <default_check+0x3f6>
ffffffffc02028a8:	4505                	li	a0,1
ffffffffc02028aa:	00043c03          	ld	s8,0(s0)
ffffffffc02028ae:	00843b83          	ld	s7,8(s0)
ffffffffc02028b2:	01042b03          	lw	s6,16(s0)
ffffffffc02028b6:	e400                	sd	s0,8(s0)
ffffffffc02028b8:	e000                	sd	s0,0(s0)
ffffffffc02028ba:	0000e797          	auipc	a5,0xe
ffffffffc02028be:	8c07af23          	sw	zero,-1826(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc02028c2:	efbfd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02028c6:	2c051863          	bnez	a0,ffffffffc0202b96 <default_check+0x3d6>
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	8552                	mv	a0,s4
ffffffffc02028ce:	f81fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02028d2:	4585                	li	a1,1
ffffffffc02028d4:	854e                	mv	a0,s3
ffffffffc02028d6:	f79fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02028da:	4585                	li	a1,1
ffffffffc02028dc:	8556                	mv	a0,s5
ffffffffc02028de:	f71fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02028e2:	4818                	lw	a4,16(s0)
ffffffffc02028e4:	478d                	li	a5,3
ffffffffc02028e6:	28f71863          	bne	a4,a5,ffffffffc0202b76 <default_check+0x3b6>
ffffffffc02028ea:	4505                	li	a0,1
ffffffffc02028ec:	ed1fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02028f0:	89aa                	mv	s3,a0
ffffffffc02028f2:	26050263          	beqz	a0,ffffffffc0202b56 <default_check+0x396>
ffffffffc02028f6:	4505                	li	a0,1
ffffffffc02028f8:	ec5fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02028fc:	8aaa                	mv	s5,a0
ffffffffc02028fe:	3a050c63          	beqz	a0,ffffffffc0202cb6 <default_check+0x4f6>
ffffffffc0202902:	4505                	li	a0,1
ffffffffc0202904:	eb9fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202908:	8a2a                	mv	s4,a0
ffffffffc020290a:	38050663          	beqz	a0,ffffffffc0202c96 <default_check+0x4d6>
ffffffffc020290e:	4505                	li	a0,1
ffffffffc0202910:	eadfd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202914:	36051163          	bnez	a0,ffffffffc0202c76 <default_check+0x4b6>
ffffffffc0202918:	4585                	li	a1,1
ffffffffc020291a:	854e                	mv	a0,s3
ffffffffc020291c:	f33fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202920:	641c                	ld	a5,8(s0)
ffffffffc0202922:	20878a63          	beq	a5,s0,ffffffffc0202b36 <default_check+0x376>
ffffffffc0202926:	4505                	li	a0,1
ffffffffc0202928:	e95fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc020292c:	30a99563          	bne	s3,a0,ffffffffc0202c36 <default_check+0x476>
ffffffffc0202930:	4505                	li	a0,1
ffffffffc0202932:	e8bfd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202936:	2e051063          	bnez	a0,ffffffffc0202c16 <default_check+0x456>
ffffffffc020293a:	481c                	lw	a5,16(s0)
ffffffffc020293c:	2a079d63          	bnez	a5,ffffffffc0202bf6 <default_check+0x436>
ffffffffc0202940:	854e                	mv	a0,s3
ffffffffc0202942:	4585                	li	a1,1
ffffffffc0202944:	01843023          	sd	s8,0(s0)
ffffffffc0202948:	01743423          	sd	s7,8(s0)
ffffffffc020294c:	01642823          	sw	s6,16(s0)
ffffffffc0202950:	efffd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202954:	4585                	li	a1,1
ffffffffc0202956:	8556                	mv	a0,s5
ffffffffc0202958:	ef7fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc020295c:	4585                	li	a1,1
ffffffffc020295e:	8552                	mv	a0,s4
ffffffffc0202960:	eeffd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202964:	4515                	li	a0,5
ffffffffc0202966:	e57fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc020296a:	89aa                	mv	s3,a0
ffffffffc020296c:	26050563          	beqz	a0,ffffffffc0202bd6 <default_check+0x416>
ffffffffc0202970:	651c                	ld	a5,8(a0)
ffffffffc0202972:	8385                	srli	a5,a5,0x1
ffffffffc0202974:	8b85                	andi	a5,a5,1
ffffffffc0202976:	54079063          	bnez	a5,ffffffffc0202eb6 <default_check+0x6f6>
ffffffffc020297a:	4505                	li	a0,1
ffffffffc020297c:	00043b03          	ld	s6,0(s0)
ffffffffc0202980:	00843a83          	ld	s5,8(s0)
ffffffffc0202984:	e000                	sd	s0,0(s0)
ffffffffc0202986:	e400                	sd	s0,8(s0)
ffffffffc0202988:	e35fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc020298c:	50051563          	bnez	a0,ffffffffc0202e96 <default_check+0x6d6>
ffffffffc0202990:	09098a13          	addi	s4,s3,144
ffffffffc0202994:	8552                	mv	a0,s4
ffffffffc0202996:	458d                	li	a1,3
ffffffffc0202998:	01042b83          	lw	s7,16(s0)
ffffffffc020299c:	0000d797          	auipc	a5,0xd
ffffffffc02029a0:	7e07ae23          	sw	zero,2044(a5) # ffffffffc0210198 <free_area+0x10>
ffffffffc02029a4:	eabfd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02029a8:	4511                	li	a0,4
ffffffffc02029aa:	e13fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02029ae:	4c051463          	bnez	a0,ffffffffc0202e76 <default_check+0x6b6>
ffffffffc02029b2:	0989b783          	ld	a5,152(s3)
ffffffffc02029b6:	8385                	srli	a5,a5,0x1
ffffffffc02029b8:	8b85                	andi	a5,a5,1
ffffffffc02029ba:	48078e63          	beqz	a5,ffffffffc0202e56 <default_check+0x696>
ffffffffc02029be:	0a89a703          	lw	a4,168(s3)
ffffffffc02029c2:	478d                	li	a5,3
ffffffffc02029c4:	48f71963          	bne	a4,a5,ffffffffc0202e56 <default_check+0x696>
ffffffffc02029c8:	450d                	li	a0,3
ffffffffc02029ca:	df3fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02029ce:	8c2a                	mv	s8,a0
ffffffffc02029d0:	46050363          	beqz	a0,ffffffffc0202e36 <default_check+0x676>
ffffffffc02029d4:	4505                	li	a0,1
ffffffffc02029d6:	de7fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc02029da:	42051e63          	bnez	a0,ffffffffc0202e16 <default_check+0x656>
ffffffffc02029de:	418a1c63          	bne	s4,s8,ffffffffc0202df6 <default_check+0x636>
ffffffffc02029e2:	4585                	li	a1,1
ffffffffc02029e4:	854e                	mv	a0,s3
ffffffffc02029e6:	e69fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02029ea:	458d                	li	a1,3
ffffffffc02029ec:	8552                	mv	a0,s4
ffffffffc02029ee:	e61fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc02029f2:	0089b783          	ld	a5,8(s3)
ffffffffc02029f6:	04898c13          	addi	s8,s3,72
ffffffffc02029fa:	8385                	srli	a5,a5,0x1
ffffffffc02029fc:	8b85                	andi	a5,a5,1
ffffffffc02029fe:	3c078c63          	beqz	a5,ffffffffc0202dd6 <default_check+0x616>
ffffffffc0202a02:	0189a703          	lw	a4,24(s3)
ffffffffc0202a06:	4785                	li	a5,1
ffffffffc0202a08:	3cf71763          	bne	a4,a5,ffffffffc0202dd6 <default_check+0x616>
ffffffffc0202a0c:	008a3783          	ld	a5,8(s4)
ffffffffc0202a10:	8385                	srli	a5,a5,0x1
ffffffffc0202a12:	8b85                	andi	a5,a5,1
ffffffffc0202a14:	3a078163          	beqz	a5,ffffffffc0202db6 <default_check+0x5f6>
ffffffffc0202a18:	018a2703          	lw	a4,24(s4)
ffffffffc0202a1c:	478d                	li	a5,3
ffffffffc0202a1e:	38f71c63          	bne	a4,a5,ffffffffc0202db6 <default_check+0x5f6>
ffffffffc0202a22:	4505                	li	a0,1
ffffffffc0202a24:	d99fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202a28:	36a99763          	bne	s3,a0,ffffffffc0202d96 <default_check+0x5d6>
ffffffffc0202a2c:	4585                	li	a1,1
ffffffffc0202a2e:	e21fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202a32:	4509                	li	a0,2
ffffffffc0202a34:	d89fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202a38:	32aa1f63          	bne	s4,a0,ffffffffc0202d76 <default_check+0x5b6>
ffffffffc0202a3c:	4589                	li	a1,2
ffffffffc0202a3e:	e11fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202a42:	4585                	li	a1,1
ffffffffc0202a44:	8562                	mv	a0,s8
ffffffffc0202a46:	e09fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202a4a:	4515                	li	a0,5
ffffffffc0202a4c:	d71fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202a50:	89aa                	mv	s3,a0
ffffffffc0202a52:	48050263          	beqz	a0,ffffffffc0202ed6 <default_check+0x716>
ffffffffc0202a56:	4505                	li	a0,1
ffffffffc0202a58:	d65fd0ef          	jal	ra,ffffffffc02007bc <alloc_pages>
ffffffffc0202a5c:	2c051d63          	bnez	a0,ffffffffc0202d36 <default_check+0x576>
ffffffffc0202a60:	481c                	lw	a5,16(s0)
ffffffffc0202a62:	2a079a63          	bnez	a5,ffffffffc0202d16 <default_check+0x556>
ffffffffc0202a66:	4595                	li	a1,5
ffffffffc0202a68:	854e                	mv	a0,s3
ffffffffc0202a6a:	01742823          	sw	s7,16(s0)
ffffffffc0202a6e:	01643023          	sd	s6,0(s0)
ffffffffc0202a72:	01543423          	sd	s5,8(s0)
ffffffffc0202a76:	dd9fd0ef          	jal	ra,ffffffffc020084e <free_pages>
ffffffffc0202a7a:	641c                	ld	a5,8(s0)
ffffffffc0202a7c:	00878963          	beq	a5,s0,ffffffffc0202a8e <default_check+0x2ce>
ffffffffc0202a80:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202a84:	679c                	ld	a5,8(a5)
ffffffffc0202a86:	397d                	addiw	s2,s2,-1
ffffffffc0202a88:	9c99                	subw	s1,s1,a4
ffffffffc0202a8a:	fe879be3          	bne	a5,s0,ffffffffc0202a80 <default_check+0x2c0>
ffffffffc0202a8e:	26091463          	bnez	s2,ffffffffc0202cf6 <default_check+0x536>
ffffffffc0202a92:	46049263          	bnez	s1,ffffffffc0202ef6 <default_check+0x736>
ffffffffc0202a96:	60a6                	ld	ra,72(sp)
ffffffffc0202a98:	6406                	ld	s0,64(sp)
ffffffffc0202a9a:	74e2                	ld	s1,56(sp)
ffffffffc0202a9c:	7942                	ld	s2,48(sp)
ffffffffc0202a9e:	79a2                	ld	s3,40(sp)
ffffffffc0202aa0:	7a02                	ld	s4,32(sp)
ffffffffc0202aa2:	6ae2                	ld	s5,24(sp)
ffffffffc0202aa4:	6b42                	ld	s6,16(sp)
ffffffffc0202aa6:	6ba2                	ld	s7,8(sp)
ffffffffc0202aa8:	6c02                	ld	s8,0(sp)
ffffffffc0202aaa:	6161                	addi	sp,sp,80
ffffffffc0202aac:	8082                	ret
ffffffffc0202aae:	4981                	li	s3,0
ffffffffc0202ab0:	4481                	li	s1,0
ffffffffc0202ab2:	4901                	li	s2,0
ffffffffc0202ab4:	b3b9                	j	ffffffffc0202802 <default_check+0x42>
ffffffffc0202ab6:	00002697          	auipc	a3,0x2
ffffffffc0202aba:	2f268693          	addi	a3,a3,754 # ffffffffc0204da8 <etext+0x10bc>
ffffffffc0202abe:	00002617          	auipc	a2,0x2
ffffffffc0202ac2:	a6a60613          	addi	a2,a2,-1430 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ac6:	0bd00593          	li	a1,189
ffffffffc0202aca:	00002517          	auipc	a0,0x2
ffffffffc0202ace:	61e50513          	addi	a0,a0,1566 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202ad2:	e1afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202ad6:	00002697          	auipc	a3,0x2
ffffffffc0202ada:	68a68693          	addi	a3,a3,1674 # ffffffffc0205160 <etext+0x1474>
ffffffffc0202ade:	00002617          	auipc	a2,0x2
ffffffffc0202ae2:	a4a60613          	addi	a2,a2,-1462 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ae6:	08a00593          	li	a1,138
ffffffffc0202aea:	00002517          	auipc	a0,0x2
ffffffffc0202aee:	5fe50513          	addi	a0,a0,1534 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202af2:	dfafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202af6:	00002697          	auipc	a3,0x2
ffffffffc0202afa:	69268693          	addi	a3,a3,1682 # ffffffffc0205188 <etext+0x149c>
ffffffffc0202afe:	00002617          	auipc	a2,0x2
ffffffffc0202b02:	a2a60613          	addi	a2,a2,-1494 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202b06:	08b00593          	li	a1,139
ffffffffc0202b0a:	00002517          	auipc	a0,0x2
ffffffffc0202b0e:	5de50513          	addi	a0,a0,1502 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202b12:	ddafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202b16:	00002697          	auipc	a3,0x2
ffffffffc0202b1a:	6b268693          	addi	a3,a3,1714 # ffffffffc02051c8 <etext+0x14dc>
ffffffffc0202b1e:	00002617          	auipc	a2,0x2
ffffffffc0202b22:	a0a60613          	addi	a2,a2,-1526 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202b26:	08d00593          	li	a1,141
ffffffffc0202b2a:	00002517          	auipc	a0,0x2
ffffffffc0202b2e:	5be50513          	addi	a0,a0,1470 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202b32:	dbafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202b36:	00002697          	auipc	a3,0x2
ffffffffc0202b3a:	71a68693          	addi	a3,a3,1818 # ffffffffc0205250 <etext+0x1564>
ffffffffc0202b3e:	00002617          	auipc	a2,0x2
ffffffffc0202b42:	9ea60613          	addi	a2,a2,-1558 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202b46:	0a600593          	li	a1,166
ffffffffc0202b4a:	00002517          	auipc	a0,0x2
ffffffffc0202b4e:	59e50513          	addi	a0,a0,1438 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202b52:	d9afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202b56:	00002697          	auipc	a3,0x2
ffffffffc0202b5a:	5aa68693          	addi	a3,a3,1450 # ffffffffc0205100 <etext+0x1414>
ffffffffc0202b5e:	00002617          	auipc	a2,0x2
ffffffffc0202b62:	9ca60613          	addi	a2,a2,-1590 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202b66:	09f00593          	li	a1,159
ffffffffc0202b6a:	00002517          	auipc	a0,0x2
ffffffffc0202b6e:	57e50513          	addi	a0,a0,1406 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202b72:	d7afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202b76:	00002697          	auipc	a3,0x2
ffffffffc0202b7a:	6ca68693          	addi	a3,a3,1738 # ffffffffc0205240 <etext+0x1554>
ffffffffc0202b7e:	00002617          	auipc	a2,0x2
ffffffffc0202b82:	9aa60613          	addi	a2,a2,-1622 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202b86:	09d00593          	li	a1,157
ffffffffc0202b8a:	00002517          	auipc	a0,0x2
ffffffffc0202b8e:	55e50513          	addi	a0,a0,1374 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202b92:	d5afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202b96:	00002697          	auipc	a3,0x2
ffffffffc0202b9a:	69268693          	addi	a3,a3,1682 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202b9e:	00002617          	auipc	a2,0x2
ffffffffc0202ba2:	98a60613          	addi	a2,a2,-1654 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ba6:	09800593          	li	a1,152
ffffffffc0202baa:	00002517          	auipc	a0,0x2
ffffffffc0202bae:	53e50513          	addi	a0,a0,1342 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202bb2:	d3afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202bb6:	00002697          	auipc	a3,0x2
ffffffffc0202bba:	65268693          	addi	a3,a3,1618 # ffffffffc0205208 <etext+0x151c>
ffffffffc0202bbe:	00002617          	auipc	a2,0x2
ffffffffc0202bc2:	96a60613          	addi	a2,a2,-1686 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202bc6:	08f00593          	li	a1,143
ffffffffc0202bca:	00002517          	auipc	a0,0x2
ffffffffc0202bce:	51e50513          	addi	a0,a0,1310 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202bd2:	d1afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202bd6:	00002697          	auipc	a3,0x2
ffffffffc0202bda:	6b268693          	addi	a3,a3,1714 # ffffffffc0205288 <etext+0x159c>
ffffffffc0202bde:	00002617          	auipc	a2,0x2
ffffffffc0202be2:	94a60613          	addi	a2,a2,-1718 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202be6:	0c500593          	li	a1,197
ffffffffc0202bea:	00002517          	auipc	a0,0x2
ffffffffc0202bee:	4fe50513          	addi	a0,a0,1278 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202bf2:	cfafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202bf6:	00002697          	auipc	a3,0x2
ffffffffc0202bfa:	36268693          	addi	a3,a3,866 # ffffffffc0204f58 <etext+0x126c>
ffffffffc0202bfe:	00002617          	auipc	a2,0x2
ffffffffc0202c02:	92a60613          	addi	a2,a2,-1750 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202c06:	0ac00593          	li	a1,172
ffffffffc0202c0a:	00002517          	auipc	a0,0x2
ffffffffc0202c0e:	4de50513          	addi	a0,a0,1246 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202c12:	cdafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202c16:	00002697          	auipc	a3,0x2
ffffffffc0202c1a:	61268693          	addi	a3,a3,1554 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202c1e:	00002617          	auipc	a2,0x2
ffffffffc0202c22:	90a60613          	addi	a2,a2,-1782 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202c26:	0aa00593          	li	a1,170
ffffffffc0202c2a:	00002517          	auipc	a0,0x2
ffffffffc0202c2e:	4be50513          	addi	a0,a0,1214 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202c32:	cbafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202c36:	00002697          	auipc	a3,0x2
ffffffffc0202c3a:	63268693          	addi	a3,a3,1586 # ffffffffc0205268 <etext+0x157c>
ffffffffc0202c3e:	00002617          	auipc	a2,0x2
ffffffffc0202c42:	8ea60613          	addi	a2,a2,-1814 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202c46:	0a900593          	li	a1,169
ffffffffc0202c4a:	00002517          	auipc	a0,0x2
ffffffffc0202c4e:	49e50513          	addi	a0,a0,1182 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202c52:	c9afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202c56:	00002697          	auipc	a3,0x2
ffffffffc0202c5a:	4aa68693          	addi	a3,a3,1194 # ffffffffc0205100 <etext+0x1414>
ffffffffc0202c5e:	00002617          	auipc	a2,0x2
ffffffffc0202c62:	8ca60613          	addi	a2,a2,-1846 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202c66:	08600593          	li	a1,134
ffffffffc0202c6a:	00002517          	auipc	a0,0x2
ffffffffc0202c6e:	47e50513          	addi	a0,a0,1150 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202c72:	c7afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202c76:	00002697          	auipc	a3,0x2
ffffffffc0202c7a:	5b268693          	addi	a3,a3,1458 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202c7e:	00002617          	auipc	a2,0x2
ffffffffc0202c82:	8aa60613          	addi	a2,a2,-1878 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202c86:	0a300593          	li	a1,163
ffffffffc0202c8a:	00002517          	auipc	a0,0x2
ffffffffc0202c8e:	45e50513          	addi	a0,a0,1118 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202c92:	c5afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202c96:	00002697          	auipc	a3,0x2
ffffffffc0202c9a:	4aa68693          	addi	a3,a3,1194 # ffffffffc0205140 <etext+0x1454>
ffffffffc0202c9e:	00002617          	auipc	a2,0x2
ffffffffc0202ca2:	88a60613          	addi	a2,a2,-1910 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ca6:	0a100593          	li	a1,161
ffffffffc0202caa:	00002517          	auipc	a0,0x2
ffffffffc0202cae:	43e50513          	addi	a0,a0,1086 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202cb2:	c3afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202cb6:	00002697          	auipc	a3,0x2
ffffffffc0202cba:	46a68693          	addi	a3,a3,1130 # ffffffffc0205120 <etext+0x1434>
ffffffffc0202cbe:	00002617          	auipc	a2,0x2
ffffffffc0202cc2:	86a60613          	addi	a2,a2,-1942 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202cc6:	0a000593          	li	a1,160
ffffffffc0202cca:	00002517          	auipc	a0,0x2
ffffffffc0202cce:	41e50513          	addi	a0,a0,1054 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202cd2:	c1afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202cd6:	00002697          	auipc	a3,0x2
ffffffffc0202cda:	46a68693          	addi	a3,a3,1130 # ffffffffc0205140 <etext+0x1454>
ffffffffc0202cde:	00002617          	auipc	a2,0x2
ffffffffc0202ce2:	84a60613          	addi	a2,a2,-1974 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ce6:	08800593          	li	a1,136
ffffffffc0202cea:	00002517          	auipc	a0,0x2
ffffffffc0202cee:	3fe50513          	addi	a0,a0,1022 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202cf2:	bfafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202cf6:	00002697          	auipc	a3,0x2
ffffffffc0202cfa:	6e268693          	addi	a3,a3,1762 # ffffffffc02053d8 <etext+0x16ec>
ffffffffc0202cfe:	00002617          	auipc	a2,0x2
ffffffffc0202d02:	82a60613          	addi	a2,a2,-2006 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202d06:	0f200593          	li	a1,242
ffffffffc0202d0a:	00002517          	auipc	a0,0x2
ffffffffc0202d0e:	3de50513          	addi	a0,a0,990 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202d12:	bdafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202d16:	00002697          	auipc	a3,0x2
ffffffffc0202d1a:	24268693          	addi	a3,a3,578 # ffffffffc0204f58 <etext+0x126c>
ffffffffc0202d1e:	00002617          	auipc	a2,0x2
ffffffffc0202d22:	80a60613          	addi	a2,a2,-2038 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202d26:	0e700593          	li	a1,231
ffffffffc0202d2a:	00002517          	auipc	a0,0x2
ffffffffc0202d2e:	3be50513          	addi	a0,a0,958 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202d32:	bbafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202d36:	00002697          	auipc	a3,0x2
ffffffffc0202d3a:	4f268693          	addi	a3,a3,1266 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202d3e:	00001617          	auipc	a2,0x1
ffffffffc0202d42:	7ea60613          	addi	a2,a2,2026 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202d46:	0e500593          	li	a1,229
ffffffffc0202d4a:	00002517          	auipc	a0,0x2
ffffffffc0202d4e:	39e50513          	addi	a0,a0,926 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202d52:	b9afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202d56:	00002697          	auipc	a3,0x2
ffffffffc0202d5a:	49268693          	addi	a3,a3,1170 # ffffffffc02051e8 <etext+0x14fc>
ffffffffc0202d5e:	00001617          	auipc	a2,0x1
ffffffffc0202d62:	7ca60613          	addi	a2,a2,1994 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202d66:	08e00593          	li	a1,142
ffffffffc0202d6a:	00002517          	auipc	a0,0x2
ffffffffc0202d6e:	37e50513          	addi	a0,a0,894 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202d72:	b7afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202d76:	00002697          	auipc	a3,0x2
ffffffffc0202d7a:	62268693          	addi	a3,a3,1570 # ffffffffc0205398 <etext+0x16ac>
ffffffffc0202d7e:	00001617          	auipc	a2,0x1
ffffffffc0202d82:	7aa60613          	addi	a2,a2,1962 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202d86:	0df00593          	li	a1,223
ffffffffc0202d8a:	00002517          	auipc	a0,0x2
ffffffffc0202d8e:	35e50513          	addi	a0,a0,862 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202d92:	b5afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202d96:	00002697          	auipc	a3,0x2
ffffffffc0202d9a:	5e268693          	addi	a3,a3,1506 # ffffffffc0205378 <etext+0x168c>
ffffffffc0202d9e:	00001617          	auipc	a2,0x1
ffffffffc0202da2:	78a60613          	addi	a2,a2,1930 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202da6:	0dd00593          	li	a1,221
ffffffffc0202daa:	00002517          	auipc	a0,0x2
ffffffffc0202dae:	33e50513          	addi	a0,a0,830 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202db2:	b3afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202db6:	00002697          	auipc	a3,0x2
ffffffffc0202dba:	59a68693          	addi	a3,a3,1434 # ffffffffc0205350 <etext+0x1664>
ffffffffc0202dbe:	00001617          	auipc	a2,0x1
ffffffffc0202dc2:	76a60613          	addi	a2,a2,1898 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202dc6:	0db00593          	li	a1,219
ffffffffc0202dca:	00002517          	auipc	a0,0x2
ffffffffc0202dce:	31e50513          	addi	a0,a0,798 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202dd2:	b1afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202dd6:	00002697          	auipc	a3,0x2
ffffffffc0202dda:	55268693          	addi	a3,a3,1362 # ffffffffc0205328 <etext+0x163c>
ffffffffc0202dde:	00001617          	auipc	a2,0x1
ffffffffc0202de2:	74a60613          	addi	a2,a2,1866 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202de6:	0da00593          	li	a1,218
ffffffffc0202dea:	00002517          	auipc	a0,0x2
ffffffffc0202dee:	2fe50513          	addi	a0,a0,766 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202df2:	afafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202df6:	00002697          	auipc	a3,0x2
ffffffffc0202dfa:	52268693          	addi	a3,a3,1314 # ffffffffc0205318 <etext+0x162c>
ffffffffc0202dfe:	00001617          	auipc	a2,0x1
ffffffffc0202e02:	72a60613          	addi	a2,a2,1834 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202e06:	0d500593          	li	a1,213
ffffffffc0202e0a:	00002517          	auipc	a0,0x2
ffffffffc0202e0e:	2de50513          	addi	a0,a0,734 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202e12:	adafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202e16:	00002697          	auipc	a3,0x2
ffffffffc0202e1a:	41268693          	addi	a3,a3,1042 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202e1e:	00001617          	auipc	a2,0x1
ffffffffc0202e22:	70a60613          	addi	a2,a2,1802 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202e26:	0d400593          	li	a1,212
ffffffffc0202e2a:	00002517          	auipc	a0,0x2
ffffffffc0202e2e:	2be50513          	addi	a0,a0,702 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202e32:	abafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202e36:	00002697          	auipc	a3,0x2
ffffffffc0202e3a:	4c268693          	addi	a3,a3,1218 # ffffffffc02052f8 <etext+0x160c>
ffffffffc0202e3e:	00001617          	auipc	a2,0x1
ffffffffc0202e42:	6ea60613          	addi	a2,a2,1770 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202e46:	0d300593          	li	a1,211
ffffffffc0202e4a:	00002517          	auipc	a0,0x2
ffffffffc0202e4e:	29e50513          	addi	a0,a0,670 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202e52:	a9afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202e56:	00002697          	auipc	a3,0x2
ffffffffc0202e5a:	47268693          	addi	a3,a3,1138 # ffffffffc02052c8 <etext+0x15dc>
ffffffffc0202e5e:	00001617          	auipc	a2,0x1
ffffffffc0202e62:	6ca60613          	addi	a2,a2,1738 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202e66:	0d200593          	li	a1,210
ffffffffc0202e6a:	00002517          	auipc	a0,0x2
ffffffffc0202e6e:	27e50513          	addi	a0,a0,638 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202e72:	a7afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202e76:	00002697          	auipc	a3,0x2
ffffffffc0202e7a:	43a68693          	addi	a3,a3,1082 # ffffffffc02052b0 <etext+0x15c4>
ffffffffc0202e7e:	00001617          	auipc	a2,0x1
ffffffffc0202e82:	6aa60613          	addi	a2,a2,1706 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202e86:	0d100593          	li	a1,209
ffffffffc0202e8a:	00002517          	auipc	a0,0x2
ffffffffc0202e8e:	25e50513          	addi	a0,a0,606 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202e92:	a5afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202e96:	00002697          	auipc	a3,0x2
ffffffffc0202e9a:	39268693          	addi	a3,a3,914 # ffffffffc0205228 <etext+0x153c>
ffffffffc0202e9e:	00001617          	auipc	a2,0x1
ffffffffc0202ea2:	68a60613          	addi	a2,a2,1674 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ea6:	0cb00593          	li	a1,203
ffffffffc0202eaa:	00002517          	auipc	a0,0x2
ffffffffc0202eae:	23e50513          	addi	a0,a0,574 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202eb2:	a3afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202eb6:	00002697          	auipc	a3,0x2
ffffffffc0202eba:	3e268693          	addi	a3,a3,994 # ffffffffc0205298 <etext+0x15ac>
ffffffffc0202ebe:	00001617          	auipc	a2,0x1
ffffffffc0202ec2:	66a60613          	addi	a2,a2,1642 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ec6:	0c600593          	li	a1,198
ffffffffc0202eca:	00002517          	auipc	a0,0x2
ffffffffc0202ece:	21e50513          	addi	a0,a0,542 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202ed2:	a1afd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202ed6:	00002697          	auipc	a3,0x2
ffffffffc0202eda:	4e268693          	addi	a3,a3,1250 # ffffffffc02053b8 <etext+0x16cc>
ffffffffc0202ede:	00001617          	auipc	a2,0x1
ffffffffc0202ee2:	64a60613          	addi	a2,a2,1610 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202ee6:	0e400593          	li	a1,228
ffffffffc0202eea:	00002517          	auipc	a0,0x2
ffffffffc0202eee:	1fe50513          	addi	a0,a0,510 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202ef2:	9fafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202ef6:	00002697          	auipc	a3,0x2
ffffffffc0202efa:	4f268693          	addi	a3,a3,1266 # ffffffffc02053e8 <etext+0x16fc>
ffffffffc0202efe:	00001617          	auipc	a2,0x1
ffffffffc0202f02:	62a60613          	addi	a2,a2,1578 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202f06:	0f300593          	li	a1,243
ffffffffc0202f0a:	00002517          	auipc	a0,0x2
ffffffffc0202f0e:	1de50513          	addi	a0,a0,478 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202f12:	9dafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f16:	00002697          	auipc	a3,0x2
ffffffffc0202f1a:	ea268693          	addi	a3,a3,-350 # ffffffffc0204db8 <etext+0x10cc>
ffffffffc0202f1e:	00001617          	auipc	a2,0x1
ffffffffc0202f22:	60a60613          	addi	a2,a2,1546 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202f26:	0c000593          	li	a1,192
ffffffffc0202f2a:	00002517          	auipc	a0,0x2
ffffffffc0202f2e:	1be50513          	addi	a0,a0,446 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202f32:	9bafd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0202f36:	00002697          	auipc	a3,0x2
ffffffffc0202f3a:	1ea68693          	addi	a3,a3,490 # ffffffffc0205120 <etext+0x1434>
ffffffffc0202f3e:	00001617          	auipc	a2,0x1
ffffffffc0202f42:	5ea60613          	addi	a2,a2,1514 # ffffffffc0204528 <etext+0x83c>
ffffffffc0202f46:	08700593          	li	a1,135
ffffffffc0202f4a:	00002517          	auipc	a0,0x2
ffffffffc0202f4e:	19e50513          	addi	a0,a0,414 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0202f52:	99afd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0202f56 <default_free_pages>:
ffffffffc0202f56:	1141                	addi	sp,sp,-16
ffffffffc0202f58:	e406                	sd	ra,8(sp)
ffffffffc0202f5a:	14058a63          	beqz	a1,ffffffffc02030ae <default_free_pages+0x158>
ffffffffc0202f5e:	00359693          	slli	a3,a1,0x3
ffffffffc0202f62:	96ae                	add	a3,a3,a1
ffffffffc0202f64:	068e                	slli	a3,a3,0x3
ffffffffc0202f66:	96aa                	add	a3,a3,a0
ffffffffc0202f68:	87aa                	mv	a5,a0
ffffffffc0202f6a:	02d50263          	beq	a0,a3,ffffffffc0202f8e <default_free_pages+0x38>
ffffffffc0202f6e:	6798                	ld	a4,8(a5)
ffffffffc0202f70:	8b05                	andi	a4,a4,1
ffffffffc0202f72:	10071e63          	bnez	a4,ffffffffc020308e <default_free_pages+0x138>
ffffffffc0202f76:	6798                	ld	a4,8(a5)
ffffffffc0202f78:	8b09                	andi	a4,a4,2
ffffffffc0202f7a:	10071a63          	bnez	a4,ffffffffc020308e <default_free_pages+0x138>
ffffffffc0202f7e:	0007b423          	sd	zero,8(a5)
ffffffffc0202f82:	0007a023          	sw	zero,0(a5)
ffffffffc0202f86:	04878793          	addi	a5,a5,72
ffffffffc0202f8a:	fed792e3          	bne	a5,a3,ffffffffc0202f6e <default_free_pages+0x18>
ffffffffc0202f8e:	2581                	sext.w	a1,a1
ffffffffc0202f90:	cd0c                	sw	a1,24(a0)
ffffffffc0202f92:	00850893          	addi	a7,a0,8
ffffffffc0202f96:	4789                	li	a5,2
ffffffffc0202f98:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0202f9c:	0000d697          	auipc	a3,0xd
ffffffffc0202fa0:	1ec68693          	addi	a3,a3,492 # ffffffffc0210188 <free_area>
ffffffffc0202fa4:	4a98                	lw	a4,16(a3)
ffffffffc0202fa6:	669c                	ld	a5,8(a3)
ffffffffc0202fa8:	02050613          	addi	a2,a0,32
ffffffffc0202fac:	9db9                	addw	a1,a1,a4
ffffffffc0202fae:	ca8c                	sw	a1,16(a3)
ffffffffc0202fb0:	0ad78863          	beq	a5,a3,ffffffffc0203060 <default_free_pages+0x10a>
ffffffffc0202fb4:	fe078713          	addi	a4,a5,-32
ffffffffc0202fb8:	0006b803          	ld	a6,0(a3)
ffffffffc0202fbc:	4581                	li	a1,0
ffffffffc0202fbe:	00e56a63          	bltu	a0,a4,ffffffffc0202fd2 <default_free_pages+0x7c>
ffffffffc0202fc2:	6798                	ld	a4,8(a5)
ffffffffc0202fc4:	06d70263          	beq	a4,a3,ffffffffc0203028 <default_free_pages+0xd2>
ffffffffc0202fc8:	87ba                	mv	a5,a4
ffffffffc0202fca:	fe078713          	addi	a4,a5,-32
ffffffffc0202fce:	fee57ae3          	bgeu	a0,a4,ffffffffc0202fc2 <default_free_pages+0x6c>
ffffffffc0202fd2:	c199                	beqz	a1,ffffffffc0202fd8 <default_free_pages+0x82>
ffffffffc0202fd4:	0106b023          	sd	a6,0(a3)
ffffffffc0202fd8:	6398                	ld	a4,0(a5)
ffffffffc0202fda:	e390                	sd	a2,0(a5)
ffffffffc0202fdc:	e710                	sd	a2,8(a4)
ffffffffc0202fde:	f51c                	sd	a5,40(a0)
ffffffffc0202fe0:	f118                	sd	a4,32(a0)
ffffffffc0202fe2:	02d70063          	beq	a4,a3,ffffffffc0203002 <default_free_pages+0xac>
ffffffffc0202fe6:	ff872803          	lw	a6,-8(a4)
ffffffffc0202fea:	fe070593          	addi	a1,a4,-32
ffffffffc0202fee:	02081613          	slli	a2,a6,0x20
ffffffffc0202ff2:	9201                	srli	a2,a2,0x20
ffffffffc0202ff4:	00361793          	slli	a5,a2,0x3
ffffffffc0202ff8:	97b2                	add	a5,a5,a2
ffffffffc0202ffa:	078e                	slli	a5,a5,0x3
ffffffffc0202ffc:	97ae                	add	a5,a5,a1
ffffffffc0202ffe:	02f50f63          	beq	a0,a5,ffffffffc020303c <default_free_pages+0xe6>
ffffffffc0203002:	7518                	ld	a4,40(a0)
ffffffffc0203004:	00d70f63          	beq	a4,a3,ffffffffc0203022 <default_free_pages+0xcc>
ffffffffc0203008:	4d0c                	lw	a1,24(a0)
ffffffffc020300a:	fe070693          	addi	a3,a4,-32
ffffffffc020300e:	02059613          	slli	a2,a1,0x20
ffffffffc0203012:	9201                	srli	a2,a2,0x20
ffffffffc0203014:	00361793          	slli	a5,a2,0x3
ffffffffc0203018:	97b2                	add	a5,a5,a2
ffffffffc020301a:	078e                	slli	a5,a5,0x3
ffffffffc020301c:	97aa                	add	a5,a5,a0
ffffffffc020301e:	04f68863          	beq	a3,a5,ffffffffc020306e <default_free_pages+0x118>
ffffffffc0203022:	60a2                	ld	ra,8(sp)
ffffffffc0203024:	0141                	addi	sp,sp,16
ffffffffc0203026:	8082                	ret
ffffffffc0203028:	e790                	sd	a2,8(a5)
ffffffffc020302a:	f514                	sd	a3,40(a0)
ffffffffc020302c:	6798                	ld	a4,8(a5)
ffffffffc020302e:	f11c                	sd	a5,32(a0)
ffffffffc0203030:	02d70563          	beq	a4,a3,ffffffffc020305a <default_free_pages+0x104>
ffffffffc0203034:	8832                	mv	a6,a2
ffffffffc0203036:	4585                	li	a1,1
ffffffffc0203038:	87ba                	mv	a5,a4
ffffffffc020303a:	bf41                	j	ffffffffc0202fca <default_free_pages+0x74>
ffffffffc020303c:	4d1c                	lw	a5,24(a0)
ffffffffc020303e:	0107883b          	addw	a6,a5,a6
ffffffffc0203042:	ff072c23          	sw	a6,-8(a4)
ffffffffc0203046:	57f5                	li	a5,-3
ffffffffc0203048:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc020304c:	7110                	ld	a2,32(a0)
ffffffffc020304e:	751c                	ld	a5,40(a0)
ffffffffc0203050:	852e                	mv	a0,a1
ffffffffc0203052:	e61c                	sd	a5,8(a2)
ffffffffc0203054:	6718                	ld	a4,8(a4)
ffffffffc0203056:	e390                	sd	a2,0(a5)
ffffffffc0203058:	b775                	j	ffffffffc0203004 <default_free_pages+0xae>
ffffffffc020305a:	e290                	sd	a2,0(a3)
ffffffffc020305c:	873e                	mv	a4,a5
ffffffffc020305e:	b761                	j	ffffffffc0202fe6 <default_free_pages+0x90>
ffffffffc0203060:	60a2                	ld	ra,8(sp)
ffffffffc0203062:	e390                	sd	a2,0(a5)
ffffffffc0203064:	e790                	sd	a2,8(a5)
ffffffffc0203066:	f51c                	sd	a5,40(a0)
ffffffffc0203068:	f11c                	sd	a5,32(a0)
ffffffffc020306a:	0141                	addi	sp,sp,16
ffffffffc020306c:	8082                	ret
ffffffffc020306e:	ff872783          	lw	a5,-8(a4)
ffffffffc0203072:	fe870693          	addi	a3,a4,-24
ffffffffc0203076:	9dbd                	addw	a1,a1,a5
ffffffffc0203078:	cd0c                	sw	a1,24(a0)
ffffffffc020307a:	57f5                	li	a5,-3
ffffffffc020307c:	60f6b02f          	amoand.d	zero,a5,(a3)
ffffffffc0203080:	6314                	ld	a3,0(a4)
ffffffffc0203082:	671c                	ld	a5,8(a4)
ffffffffc0203084:	60a2                	ld	ra,8(sp)
ffffffffc0203086:	e69c                	sd	a5,8(a3)
ffffffffc0203088:	e394                	sd	a3,0(a5)
ffffffffc020308a:	0141                	addi	sp,sp,16
ffffffffc020308c:	8082                	ret
ffffffffc020308e:	00002697          	auipc	a3,0x2
ffffffffc0203092:	37268693          	addi	a3,a3,882 # ffffffffc0205400 <etext+0x1714>
ffffffffc0203096:	00001617          	auipc	a2,0x1
ffffffffc020309a:	49260613          	addi	a2,a2,1170 # ffffffffc0204528 <etext+0x83c>
ffffffffc020309e:	05000593          	li	a1,80
ffffffffc02030a2:	00002517          	auipc	a0,0x2
ffffffffc02030a6:	04650513          	addi	a0,a0,70 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc02030aa:	842fd0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02030ae:	00002697          	auipc	a3,0x2
ffffffffc02030b2:	34a68693          	addi	a3,a3,842 # ffffffffc02053f8 <etext+0x170c>
ffffffffc02030b6:	00001617          	auipc	a2,0x1
ffffffffc02030ba:	47260613          	addi	a2,a2,1138 # ffffffffc0204528 <etext+0x83c>
ffffffffc02030be:	04d00593          	li	a1,77
ffffffffc02030c2:	00002517          	auipc	a0,0x2
ffffffffc02030c6:	02650513          	addi	a0,a0,38 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc02030ca:	822fd0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02030ce <default_alloc_pages>:
ffffffffc02030ce:	c959                	beqz	a0,ffffffffc0203164 <default_alloc_pages+0x96>
ffffffffc02030d0:	0000d597          	auipc	a1,0xd
ffffffffc02030d4:	0b858593          	addi	a1,a1,184 # ffffffffc0210188 <free_area>
ffffffffc02030d8:	0105a803          	lw	a6,16(a1)
ffffffffc02030dc:	862a                	mv	a2,a0
ffffffffc02030de:	02081793          	slli	a5,a6,0x20
ffffffffc02030e2:	9381                	srli	a5,a5,0x20
ffffffffc02030e4:	00a7ee63          	bltu	a5,a0,ffffffffc0203100 <default_alloc_pages+0x32>
ffffffffc02030e8:	87ae                	mv	a5,a1
ffffffffc02030ea:	a801                	j	ffffffffc02030fa <default_alloc_pages+0x2c>
ffffffffc02030ec:	ff87a703          	lw	a4,-8(a5)
ffffffffc02030f0:	02071693          	slli	a3,a4,0x20
ffffffffc02030f4:	9281                	srli	a3,a3,0x20
ffffffffc02030f6:	00c6f763          	bgeu	a3,a2,ffffffffc0203104 <default_alloc_pages+0x36>
ffffffffc02030fa:	679c                	ld	a5,8(a5)
ffffffffc02030fc:	feb798e3          	bne	a5,a1,ffffffffc02030ec <default_alloc_pages+0x1e>
ffffffffc0203100:	4501                	li	a0,0
ffffffffc0203102:	8082                	ret
ffffffffc0203104:	0007b883          	ld	a7,0(a5)
ffffffffc0203108:	0087b303          	ld	t1,8(a5)
ffffffffc020310c:	fe078513          	addi	a0,a5,-32
ffffffffc0203110:	00060e1b          	sext.w	t3,a2
ffffffffc0203114:	0068b423          	sd	t1,8(a7)
ffffffffc0203118:	01133023          	sd	a7,0(t1)
ffffffffc020311c:	02d67b63          	bgeu	a2,a3,ffffffffc0203152 <default_alloc_pages+0x84>
ffffffffc0203120:	00361693          	slli	a3,a2,0x3
ffffffffc0203124:	96b2                	add	a3,a3,a2
ffffffffc0203126:	068e                	slli	a3,a3,0x3
ffffffffc0203128:	96aa                	add	a3,a3,a0
ffffffffc020312a:	41c7073b          	subw	a4,a4,t3
ffffffffc020312e:	ce98                	sw	a4,24(a3)
ffffffffc0203130:	00868613          	addi	a2,a3,8
ffffffffc0203134:	4709                	li	a4,2
ffffffffc0203136:	40e6302f          	amoor.d	zero,a4,(a2)
ffffffffc020313a:	0088b703          	ld	a4,8(a7)
ffffffffc020313e:	02068613          	addi	a2,a3,32
ffffffffc0203142:	0105a803          	lw	a6,16(a1)
ffffffffc0203146:	e310                	sd	a2,0(a4)
ffffffffc0203148:	00c8b423          	sd	a2,8(a7)
ffffffffc020314c:	f698                	sd	a4,40(a3)
ffffffffc020314e:	0316b023          	sd	a7,32(a3)
ffffffffc0203152:	41c8083b          	subw	a6,a6,t3
ffffffffc0203156:	0105a823          	sw	a6,16(a1)
ffffffffc020315a:	5775                	li	a4,-3
ffffffffc020315c:	17a1                	addi	a5,a5,-24
ffffffffc020315e:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0203162:	8082                	ret
ffffffffc0203164:	1141                	addi	sp,sp,-16
ffffffffc0203166:	00002697          	auipc	a3,0x2
ffffffffc020316a:	29268693          	addi	a3,a3,658 # ffffffffc02053f8 <etext+0x170c>
ffffffffc020316e:	00001617          	auipc	a2,0x1
ffffffffc0203172:	3ba60613          	addi	a2,a2,954 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203176:	02f00593          	li	a1,47
ffffffffc020317a:	00002517          	auipc	a0,0x2
ffffffffc020317e:	f6e50513          	addi	a0,a0,-146 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0203182:	e406                	sd	ra,8(sp)
ffffffffc0203184:	f69fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203188 <default_init_memmap>:
ffffffffc0203188:	1141                	addi	sp,sp,-16
ffffffffc020318a:	e406                	sd	ra,8(sp)
ffffffffc020318c:	c5f9                	beqz	a1,ffffffffc020325a <default_init_memmap+0xd2>
ffffffffc020318e:	00359693          	slli	a3,a1,0x3
ffffffffc0203192:	96ae                	add	a3,a3,a1
ffffffffc0203194:	068e                	slli	a3,a3,0x3
ffffffffc0203196:	96aa                	add	a3,a3,a0
ffffffffc0203198:	87aa                	mv	a5,a0
ffffffffc020319a:	00d50f63          	beq	a0,a3,ffffffffc02031b8 <default_init_memmap+0x30>
ffffffffc020319e:	6798                	ld	a4,8(a5)
ffffffffc02031a0:	8b05                	andi	a4,a4,1
ffffffffc02031a2:	cf49                	beqz	a4,ffffffffc020323c <default_init_memmap+0xb4>
ffffffffc02031a4:	0007ac23          	sw	zero,24(a5)
ffffffffc02031a8:	0007b423          	sd	zero,8(a5)
ffffffffc02031ac:	0007a023          	sw	zero,0(a5)
ffffffffc02031b0:	04878793          	addi	a5,a5,72
ffffffffc02031b4:	fed795e3          	bne	a5,a3,ffffffffc020319e <default_init_memmap+0x16>
ffffffffc02031b8:	2581                	sext.w	a1,a1
ffffffffc02031ba:	cd0c                	sw	a1,24(a0)
ffffffffc02031bc:	4789                	li	a5,2
ffffffffc02031be:	00850713          	addi	a4,a0,8
ffffffffc02031c2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc02031c6:	0000d697          	auipc	a3,0xd
ffffffffc02031ca:	fc268693          	addi	a3,a3,-62 # ffffffffc0210188 <free_area>
ffffffffc02031ce:	4a98                	lw	a4,16(a3)
ffffffffc02031d0:	669c                	ld	a5,8(a3)
ffffffffc02031d2:	02050613          	addi	a2,a0,32
ffffffffc02031d6:	9db9                	addw	a1,a1,a4
ffffffffc02031d8:	ca8c                	sw	a1,16(a3)
ffffffffc02031da:	04d78a63          	beq	a5,a3,ffffffffc020322e <default_init_memmap+0xa6>
ffffffffc02031de:	fe078713          	addi	a4,a5,-32
ffffffffc02031e2:	0006b803          	ld	a6,0(a3)
ffffffffc02031e6:	4581                	li	a1,0
ffffffffc02031e8:	00e56a63          	bltu	a0,a4,ffffffffc02031fc <default_init_memmap+0x74>
ffffffffc02031ec:	6798                	ld	a4,8(a5)
ffffffffc02031ee:	02d70263          	beq	a4,a3,ffffffffc0203212 <default_init_memmap+0x8a>
ffffffffc02031f2:	87ba                	mv	a5,a4
ffffffffc02031f4:	fe078713          	addi	a4,a5,-32
ffffffffc02031f8:	fee57ae3          	bgeu	a0,a4,ffffffffc02031ec <default_init_memmap+0x64>
ffffffffc02031fc:	c199                	beqz	a1,ffffffffc0203202 <default_init_memmap+0x7a>
ffffffffc02031fe:	0106b023          	sd	a6,0(a3)
ffffffffc0203202:	6398                	ld	a4,0(a5)
ffffffffc0203204:	60a2                	ld	ra,8(sp)
ffffffffc0203206:	e390                	sd	a2,0(a5)
ffffffffc0203208:	e710                	sd	a2,8(a4)
ffffffffc020320a:	f51c                	sd	a5,40(a0)
ffffffffc020320c:	f118                	sd	a4,32(a0)
ffffffffc020320e:	0141                	addi	sp,sp,16
ffffffffc0203210:	8082                	ret
ffffffffc0203212:	e790                	sd	a2,8(a5)
ffffffffc0203214:	f514                	sd	a3,40(a0)
ffffffffc0203216:	6798                	ld	a4,8(a5)
ffffffffc0203218:	f11c                	sd	a5,32(a0)
ffffffffc020321a:	00d70663          	beq	a4,a3,ffffffffc0203226 <default_init_memmap+0x9e>
ffffffffc020321e:	8832                	mv	a6,a2
ffffffffc0203220:	4585                	li	a1,1
ffffffffc0203222:	87ba                	mv	a5,a4
ffffffffc0203224:	bfc1                	j	ffffffffc02031f4 <default_init_memmap+0x6c>
ffffffffc0203226:	60a2                	ld	ra,8(sp)
ffffffffc0203228:	e290                	sd	a2,0(a3)
ffffffffc020322a:	0141                	addi	sp,sp,16
ffffffffc020322c:	8082                	ret
ffffffffc020322e:	60a2                	ld	ra,8(sp)
ffffffffc0203230:	e390                	sd	a2,0(a5)
ffffffffc0203232:	e790                	sd	a2,8(a5)
ffffffffc0203234:	f51c                	sd	a5,40(a0)
ffffffffc0203236:	f11c                	sd	a5,32(a0)
ffffffffc0203238:	0141                	addi	sp,sp,16
ffffffffc020323a:	8082                	ret
ffffffffc020323c:	00002697          	auipc	a3,0x2
ffffffffc0203240:	1ec68693          	addi	a3,a3,492 # ffffffffc0205428 <etext+0x173c>
ffffffffc0203244:	00001617          	auipc	a2,0x1
ffffffffc0203248:	2e460613          	addi	a2,a2,740 # ffffffffc0204528 <etext+0x83c>
ffffffffc020324c:	45d9                	li	a1,22
ffffffffc020324e:	00002517          	auipc	a0,0x2
ffffffffc0203252:	e9a50513          	addi	a0,a0,-358 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0203256:	e97fc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc020325a:	00002697          	auipc	a3,0x2
ffffffffc020325e:	19e68693          	addi	a3,a3,414 # ffffffffc02053f8 <etext+0x170c>
ffffffffc0203262:	00001617          	auipc	a2,0x1
ffffffffc0203266:	2c660613          	addi	a2,a2,710 # ffffffffc0204528 <etext+0x83c>
ffffffffc020326a:	45cd                	li	a1,19
ffffffffc020326c:	00002517          	auipc	a0,0x2
ffffffffc0203270:	e7c50513          	addi	a0,a0,-388 # ffffffffc02050e8 <etext+0x13fc>
ffffffffc0203274:	e79fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc0203278 <_clock_init_mm>:
ffffffffc0203278:	02053423          	sd	zero,40(a0)
ffffffffc020327c:	4501                	li	a0,0
ffffffffc020327e:	8082                	ret

ffffffffc0203280 <_clock_init>:
ffffffffc0203280:	4501                	li	a0,0
ffffffffc0203282:	8082                	ret

ffffffffc0203284 <_clock_set_unswappable>:
ffffffffc0203284:	4501                	li	a0,0
ffffffffc0203286:	8082                	ret

ffffffffc0203288 <_clock_tick_event>:
ffffffffc0203288:	4501                	li	a0,0
ffffffffc020328a:	8082                	ret

ffffffffc020328c <_clock_check_swap>:
ffffffffc020328c:	711d                	addi	sp,sp,-96
ffffffffc020328e:	00002517          	auipc	a0,0x2
ffffffffc0203292:	1fa50513          	addi	a0,a0,506 # ffffffffc0205488 <default_pmm_manager+0x38>
ffffffffc0203296:	ec86                	sd	ra,88(sp)
ffffffffc0203298:	e0ca                	sd	s2,64(sp)
ffffffffc020329a:	fc4e                	sd	s3,56(sp)
ffffffffc020329c:	f852                	sd	s4,48(sp)
ffffffffc020329e:	e8a2                	sd	s0,80(sp)
ffffffffc02032a0:	e4a6                	sd	s1,72(sp)
ffffffffc02032a2:	f456                	sd	s5,40(sp)
ffffffffc02032a4:	f05a                	sd	s6,32(sp)
ffffffffc02032a6:	ec5e                	sd	s7,24(sp)
ffffffffc02032a8:	e862                	sd	s8,16(sp)
ffffffffc02032aa:	e466                	sd	s9,8(sp)
ffffffffc02032ac:	e06a                	sd	s10,0(sp)
ffffffffc02032ae:	e09fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02032b2:	00002517          	auipc	a0,0x2
ffffffffc02032b6:	1fe50513          	addi	a0,a0,510 # ffffffffc02054b0 <default_pmm_manager+0x60>
ffffffffc02032ba:	698d                	lui	s3,0x3
ffffffffc02032bc:	4a31                	li	s4,12
ffffffffc02032be:	df9fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02032c2:	01498023          	sb	s4,0(s3) # 3000 <kern_entry-0xffffffffc01fd000>
ffffffffc02032c6:	0000d917          	auipc	s2,0xd
ffffffffc02032ca:	d9a92903          	lw	s2,-614(s2) # ffffffffc0210060 <pgfault_num>
ffffffffc02032ce:	4791                	li	a5,4
ffffffffc02032d0:	16f91363          	bne	s2,a5,ffffffffc0203436 <_clock_check_swap+0x1aa>
ffffffffc02032d4:	00002517          	auipc	a0,0x2
ffffffffc02032d8:	21c50513          	addi	a0,a0,540 # ffffffffc02054f0 <default_pmm_manager+0xa0>
ffffffffc02032dc:	6a85                	lui	s5,0x1
ffffffffc02032de:	4b29                	li	s6,10
ffffffffc02032e0:	dd7fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02032e4:	0000d417          	auipc	s0,0xd
ffffffffc02032e8:	d7c40413          	addi	s0,s0,-644 # ffffffffc0210060 <pgfault_num>
ffffffffc02032ec:	016a8023          	sb	s6,0(s5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc02032f0:	4004                	lw	s1,0(s0)
ffffffffc02032f2:	2481                	sext.w	s1,s1
ffffffffc02032f4:	2d249163          	bne	s1,s2,ffffffffc02035b6 <_clock_check_swap+0x32a>
ffffffffc02032f8:	00002517          	auipc	a0,0x2
ffffffffc02032fc:	22050513          	addi	a0,a0,544 # ffffffffc0205518 <default_pmm_manager+0xc8>
ffffffffc0203300:	6b91                	lui	s7,0x4
ffffffffc0203302:	4c35                	li	s8,13
ffffffffc0203304:	db3fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0203308:	018b8023          	sb	s8,0(s7) # 4000 <kern_entry-0xffffffffc01fc000>
ffffffffc020330c:	00042903          	lw	s2,0(s0)
ffffffffc0203310:	2901                	sext.w	s2,s2
ffffffffc0203312:	28991263          	bne	s2,s1,ffffffffc0203596 <_clock_check_swap+0x30a>
ffffffffc0203316:	00002517          	auipc	a0,0x2
ffffffffc020331a:	22a50513          	addi	a0,a0,554 # ffffffffc0205540 <default_pmm_manager+0xf0>
ffffffffc020331e:	6c89                	lui	s9,0x2
ffffffffc0203320:	4d2d                	li	s10,11
ffffffffc0203322:	d95fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0203326:	01ac8023          	sb	s10,0(s9) # 2000 <kern_entry-0xffffffffc01fe000>
ffffffffc020332a:	401c                	lw	a5,0(s0)
ffffffffc020332c:	2781                	sext.w	a5,a5
ffffffffc020332e:	25279463          	bne	a5,s2,ffffffffc0203576 <_clock_check_swap+0x2ea>
ffffffffc0203332:	00002517          	auipc	a0,0x2
ffffffffc0203336:	23650513          	addi	a0,a0,566 # ffffffffc0205568 <default_pmm_manager+0x118>
ffffffffc020333a:	d7dfc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020333e:	6795                	lui	a5,0x5
ffffffffc0203340:	4739                	li	a4,14
ffffffffc0203342:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc0203346:	4004                	lw	s1,0(s0)
ffffffffc0203348:	4795                	li	a5,5
ffffffffc020334a:	2481                	sext.w	s1,s1
ffffffffc020334c:	20f49563          	bne	s1,a5,ffffffffc0203556 <_clock_check_swap+0x2ca>
ffffffffc0203350:	00002517          	auipc	a0,0x2
ffffffffc0203354:	1f050513          	addi	a0,a0,496 # ffffffffc0205540 <default_pmm_manager+0xf0>
ffffffffc0203358:	d5ffc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020335c:	01ac8023          	sb	s10,0(s9)
ffffffffc0203360:	401c                	lw	a5,0(s0)
ffffffffc0203362:	2781                	sext.w	a5,a5
ffffffffc0203364:	1c979963          	bne	a5,s1,ffffffffc0203536 <_clock_check_swap+0x2aa>
ffffffffc0203368:	00002517          	auipc	a0,0x2
ffffffffc020336c:	18850513          	addi	a0,a0,392 # ffffffffc02054f0 <default_pmm_manager+0xa0>
ffffffffc0203370:	d47fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0203374:	016a8023          	sb	s6,0(s5)
ffffffffc0203378:	4004                	lw	s1,0(s0)
ffffffffc020337a:	4799                	li	a5,6
ffffffffc020337c:	2481                	sext.w	s1,s1
ffffffffc020337e:	18f49c63          	bne	s1,a5,ffffffffc0203516 <_clock_check_swap+0x28a>
ffffffffc0203382:	00002517          	auipc	a0,0x2
ffffffffc0203386:	1be50513          	addi	a0,a0,446 # ffffffffc0205540 <default_pmm_manager+0xf0>
ffffffffc020338a:	d2dfc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc020338e:	01ac8023          	sb	s10,0(s9)
ffffffffc0203392:	401c                	lw	a5,0(s0)
ffffffffc0203394:	2781                	sext.w	a5,a5
ffffffffc0203396:	16979063          	bne	a5,s1,ffffffffc02034f6 <_clock_check_swap+0x26a>
ffffffffc020339a:	00002517          	auipc	a0,0x2
ffffffffc020339e:	11650513          	addi	a0,a0,278 # ffffffffc02054b0 <default_pmm_manager+0x60>
ffffffffc02033a2:	d15fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02033a6:	01498023          	sb	s4,0(s3)
ffffffffc02033aa:	401c                	lw	a5,0(s0)
ffffffffc02033ac:	471d                	li	a4,7
ffffffffc02033ae:	2781                	sext.w	a5,a5
ffffffffc02033b0:	12e79363          	bne	a5,a4,ffffffffc02034d6 <_clock_check_swap+0x24a>
ffffffffc02033b4:	00002517          	auipc	a0,0x2
ffffffffc02033b8:	16450513          	addi	a0,a0,356 # ffffffffc0205518 <default_pmm_manager+0xc8>
ffffffffc02033bc:	cfbfc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02033c0:	018b8023          	sb	s8,0(s7)
ffffffffc02033c4:	401c                	lw	a5,0(s0)
ffffffffc02033c6:	4721                	li	a4,8
ffffffffc02033c8:	2781                	sext.w	a5,a5
ffffffffc02033ca:	0ee79663          	bne	a5,a4,ffffffffc02034b6 <_clock_check_swap+0x22a>
ffffffffc02033ce:	00002517          	auipc	a0,0x2
ffffffffc02033d2:	19a50513          	addi	a0,a0,410 # ffffffffc0205568 <default_pmm_manager+0x118>
ffffffffc02033d6:	ce1fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02033da:	6795                	lui	a5,0x5
ffffffffc02033dc:	4739                	li	a4,14
ffffffffc02033de:	00e78023          	sb	a4,0(a5) # 5000 <kern_entry-0xffffffffc01fb000>
ffffffffc02033e2:	4004                	lw	s1,0(s0)
ffffffffc02033e4:	47a5                	li	a5,9
ffffffffc02033e6:	2481                	sext.w	s1,s1
ffffffffc02033e8:	0af49763          	bne	s1,a5,ffffffffc0203496 <_clock_check_swap+0x20a>
ffffffffc02033ec:	00002517          	auipc	a0,0x2
ffffffffc02033f0:	10450513          	addi	a0,a0,260 # ffffffffc02054f0 <default_pmm_manager+0xa0>
ffffffffc02033f4:	cc3fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc02033f8:	6785                	lui	a5,0x1
ffffffffc02033fa:	0007c703          	lbu	a4,0(a5) # 1000 <kern_entry-0xffffffffc01ff000>
ffffffffc02033fe:	47a9                	li	a5,10
ffffffffc0203400:	06f71b63          	bne	a4,a5,ffffffffc0203476 <_clock_check_swap+0x1ea>
ffffffffc0203404:	401c                	lw	a5,0(s0)
ffffffffc0203406:	2781                	sext.w	a5,a5
ffffffffc0203408:	04979763          	bne	a5,s1,ffffffffc0203456 <_clock_check_swap+0x1ca>
ffffffffc020340c:	00002517          	auipc	a0,0x2
ffffffffc0203410:	1fc50513          	addi	a0,a0,508 # ffffffffc0205608 <default_pmm_manager+0x1b8>
ffffffffc0203414:	ca3fc0ef          	jal	ra,ffffffffc02000b6 <cprintf>
ffffffffc0203418:	60e6                	ld	ra,88(sp)
ffffffffc020341a:	6446                	ld	s0,80(sp)
ffffffffc020341c:	64a6                	ld	s1,72(sp)
ffffffffc020341e:	6906                	ld	s2,64(sp)
ffffffffc0203420:	79e2                	ld	s3,56(sp)
ffffffffc0203422:	7a42                	ld	s4,48(sp)
ffffffffc0203424:	7aa2                	ld	s5,40(sp)
ffffffffc0203426:	7b02                	ld	s6,32(sp)
ffffffffc0203428:	6be2                	ld	s7,24(sp)
ffffffffc020342a:	6c42                	ld	s8,16(sp)
ffffffffc020342c:	6ca2                	ld	s9,8(sp)
ffffffffc020342e:	6d02                	ld	s10,0(sp)
ffffffffc0203430:	4501                	li	a0,0
ffffffffc0203432:	6125                	addi	sp,sp,96
ffffffffc0203434:	8082                	ret
ffffffffc0203436:	00002697          	auipc	a3,0x2
ffffffffc020343a:	b1268693          	addi	a3,a3,-1262 # ffffffffc0204f48 <etext+0x125c>
ffffffffc020343e:	00001617          	auipc	a2,0x1
ffffffffc0203442:	0ea60613          	addi	a2,a2,234 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203446:	05b00593          	li	a1,91
ffffffffc020344a:	00002517          	auipc	a0,0x2
ffffffffc020344e:	08e50513          	addi	a0,a0,142 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203452:	c9bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203456:	00002697          	auipc	a3,0x2
ffffffffc020345a:	17a68693          	addi	a3,a3,378 # ffffffffc02055d0 <default_pmm_manager+0x180>
ffffffffc020345e:	00001617          	auipc	a2,0x1
ffffffffc0203462:	0ca60613          	addi	a2,a2,202 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203466:	07d00593          	li	a1,125
ffffffffc020346a:	00002517          	auipc	a0,0x2
ffffffffc020346e:	06e50513          	addi	a0,a0,110 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203472:	c7bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203476:	00002697          	auipc	a3,0x2
ffffffffc020347a:	16a68693          	addi	a3,a3,362 # ffffffffc02055e0 <default_pmm_manager+0x190>
ffffffffc020347e:	00001617          	auipc	a2,0x1
ffffffffc0203482:	0aa60613          	addi	a2,a2,170 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203486:	07b00593          	li	a1,123
ffffffffc020348a:	00002517          	auipc	a0,0x2
ffffffffc020348e:	04e50513          	addi	a0,a0,78 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203492:	c5bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203496:	00002697          	auipc	a3,0x2
ffffffffc020349a:	13a68693          	addi	a3,a3,314 # ffffffffc02055d0 <default_pmm_manager+0x180>
ffffffffc020349e:	00001617          	auipc	a2,0x1
ffffffffc02034a2:	08a60613          	addi	a2,a2,138 # ffffffffc0204528 <etext+0x83c>
ffffffffc02034a6:	07900593          	li	a1,121
ffffffffc02034aa:	00002517          	auipc	a0,0x2
ffffffffc02034ae:	02e50513          	addi	a0,a0,46 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02034b2:	c3bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02034b6:	00002697          	auipc	a3,0x2
ffffffffc02034ba:	10a68693          	addi	a3,a3,266 # ffffffffc02055c0 <default_pmm_manager+0x170>
ffffffffc02034be:	00001617          	auipc	a2,0x1
ffffffffc02034c2:	06a60613          	addi	a2,a2,106 # ffffffffc0204528 <etext+0x83c>
ffffffffc02034c6:	07600593          	li	a1,118
ffffffffc02034ca:	00002517          	auipc	a0,0x2
ffffffffc02034ce:	00e50513          	addi	a0,a0,14 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02034d2:	c1bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02034d6:	00002697          	auipc	a3,0x2
ffffffffc02034da:	0da68693          	addi	a3,a3,218 # ffffffffc02055b0 <default_pmm_manager+0x160>
ffffffffc02034de:	00001617          	auipc	a2,0x1
ffffffffc02034e2:	04a60613          	addi	a2,a2,74 # ffffffffc0204528 <etext+0x83c>
ffffffffc02034e6:	07300593          	li	a1,115
ffffffffc02034ea:	00002517          	auipc	a0,0x2
ffffffffc02034ee:	fee50513          	addi	a0,a0,-18 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02034f2:	bfbfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02034f6:	00002697          	auipc	a3,0x2
ffffffffc02034fa:	0aa68693          	addi	a3,a3,170 # ffffffffc02055a0 <default_pmm_manager+0x150>
ffffffffc02034fe:	00001617          	auipc	a2,0x1
ffffffffc0203502:	02a60613          	addi	a2,a2,42 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203506:	07000593          	li	a1,112
ffffffffc020350a:	00002517          	auipc	a0,0x2
ffffffffc020350e:	fce50513          	addi	a0,a0,-50 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203512:	bdbfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203516:	00002697          	auipc	a3,0x2
ffffffffc020351a:	08a68693          	addi	a3,a3,138 # ffffffffc02055a0 <default_pmm_manager+0x150>
ffffffffc020351e:	00001617          	auipc	a2,0x1
ffffffffc0203522:	00a60613          	addi	a2,a2,10 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203526:	06d00593          	li	a1,109
ffffffffc020352a:	00002517          	auipc	a0,0x2
ffffffffc020352e:	fae50513          	addi	a0,a0,-82 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203532:	bbbfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203536:	00002697          	auipc	a3,0x2
ffffffffc020353a:	05a68693          	addi	a3,a3,90 # ffffffffc0205590 <default_pmm_manager+0x140>
ffffffffc020353e:	00001617          	auipc	a2,0x1
ffffffffc0203542:	fea60613          	addi	a2,a2,-22 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203546:	06a00593          	li	a1,106
ffffffffc020354a:	00002517          	auipc	a0,0x2
ffffffffc020354e:	f8e50513          	addi	a0,a0,-114 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203552:	b9bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203556:	00002697          	auipc	a3,0x2
ffffffffc020355a:	03a68693          	addi	a3,a3,58 # ffffffffc0205590 <default_pmm_manager+0x140>
ffffffffc020355e:	00001617          	auipc	a2,0x1
ffffffffc0203562:	fca60613          	addi	a2,a2,-54 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203566:	06700593          	li	a1,103
ffffffffc020356a:	00002517          	auipc	a0,0x2
ffffffffc020356e:	f6e50513          	addi	a0,a0,-146 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203572:	b7bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203576:	00002697          	auipc	a3,0x2
ffffffffc020357a:	9d268693          	addi	a3,a3,-1582 # ffffffffc0204f48 <etext+0x125c>
ffffffffc020357e:	00001617          	auipc	a2,0x1
ffffffffc0203582:	faa60613          	addi	a2,a2,-86 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203586:	06400593          	li	a1,100
ffffffffc020358a:	00002517          	auipc	a0,0x2
ffffffffc020358e:	f4e50513          	addi	a0,a0,-178 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc0203592:	b5bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203596:	00002697          	auipc	a3,0x2
ffffffffc020359a:	9b268693          	addi	a3,a3,-1614 # ffffffffc0204f48 <etext+0x125c>
ffffffffc020359e:	00001617          	auipc	a2,0x1
ffffffffc02035a2:	f8a60613          	addi	a2,a2,-118 # ffffffffc0204528 <etext+0x83c>
ffffffffc02035a6:	06100593          	li	a1,97
ffffffffc02035aa:	00002517          	auipc	a0,0x2
ffffffffc02035ae:	f2e50513          	addi	a0,a0,-210 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02035b2:	b3bfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02035b6:	00002697          	auipc	a3,0x2
ffffffffc02035ba:	99268693          	addi	a3,a3,-1646 # ffffffffc0204f48 <etext+0x125c>
ffffffffc02035be:	00001617          	auipc	a2,0x1
ffffffffc02035c2:	f6a60613          	addi	a2,a2,-150 # ffffffffc0204528 <etext+0x83c>
ffffffffc02035c6:	05e00593          	li	a1,94
ffffffffc02035ca:	00002517          	auipc	a0,0x2
ffffffffc02035ce:	f0e50513          	addi	a0,a0,-242 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02035d2:	b1bfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02035d6 <_clock_swap_out_victim>:
ffffffffc02035d6:	7179                	addi	sp,sp,-48
ffffffffc02035d8:	e84a                	sd	s2,16(sp)
ffffffffc02035da:	02853903          	ld	s2,40(a0)
ffffffffc02035de:	f406                	sd	ra,40(sp)
ffffffffc02035e0:	f022                	sd	s0,32(sp)
ffffffffc02035e2:	ec26                	sd	s1,24(sp)
ffffffffc02035e4:	e44e                	sd	s3,8(sp)
ffffffffc02035e6:	e052                	sd	s4,0(sp)
ffffffffc02035e8:	08090f63          	beqz	s2,ffffffffc0203686 <_clock_swap_out_victim+0xb0>
ffffffffc02035ec:	0000d797          	auipc	a5,0xd
ffffffffc02035f0:	aa07b223          	sd	zero,-1372(a5) # ffffffffc0210090 <curr_ptr>
ffffffffc02035f4:	89aa                	mv	s3,a0
ffffffffc02035f6:	8a2e                	mv	s4,a1
ffffffffc02035f8:	4781                	li	a5,0
ffffffffc02035fa:	0000d417          	auipc	s0,0xd
ffffffffc02035fe:	a9640413          	addi	s0,s0,-1386 # ffffffffc0210090 <curr_ptr>
ffffffffc0203602:	cba9                	beqz	a5,ffffffffc0203654 <_clock_swap_out_victim+0x7e>
ffffffffc0203604:	6004                	ld	s1,0(s0)
ffffffffc0203606:	0189b503          	ld	a0,24(s3)
ffffffffc020360a:	4601                	li	a2,0
ffffffffc020360c:	688c                	ld	a1,16(s1)
ffffffffc020360e:	abefd0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0203612:	611c                	ld	a5,0(a0)
ffffffffc0203614:	0407f713          	andi	a4,a5,64
ffffffffc0203618:	cb39                	beqz	a4,ffffffffc020366e <_clock_swap_out_victim+0x98>
ffffffffc020361a:	6018                	ld	a4,0(s0)
ffffffffc020361c:	fbf7f793          	andi	a5,a5,-65
ffffffffc0203620:	e11c                	sd	a5,0(a0)
ffffffffc0203622:	671c                	ld	a5,8(a4)
ffffffffc0203624:	e01c                	sd	a5,0(s0)
ffffffffc0203626:	fcf91ee3          	bne	s2,a5,ffffffffc0203602 <_clock_swap_out_victim+0x2c>
ffffffffc020362a:	00893783          	ld	a5,8(s2)
ffffffffc020362e:	00093703          	ld	a4,0(s2)
ffffffffc0203632:	fd090913          	addi	s2,s2,-48
ffffffffc0203636:	012a3023          	sd	s2,0(s4)
ffffffffc020363a:	02f9b423          	sd	a5,40(s3)
ffffffffc020363e:	e71c                	sd	a5,8(a4)
ffffffffc0203640:	e398                	sd	a4,0(a5)
ffffffffc0203642:	70a2                	ld	ra,40(sp)
ffffffffc0203644:	7402                	ld	s0,32(sp)
ffffffffc0203646:	64e2                	ld	s1,24(sp)
ffffffffc0203648:	6942                	ld	s2,16(sp)
ffffffffc020364a:	69a2                	ld	s3,8(sp)
ffffffffc020364c:	6a02                	ld	s4,0(sp)
ffffffffc020364e:	4501                	li	a0,0
ffffffffc0203650:	6145                	addi	sp,sp,48
ffffffffc0203652:	8082                	ret
ffffffffc0203654:	84ca                	mv	s1,s2
ffffffffc0203656:	688c                	ld	a1,16(s1)
ffffffffc0203658:	0189b503          	ld	a0,24(s3)
ffffffffc020365c:	4601                	li	a2,0
ffffffffc020365e:	01243023          	sd	s2,0(s0)
ffffffffc0203662:	a6afd0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc0203666:	611c                	ld	a5,0(a0)
ffffffffc0203668:	0407f713          	andi	a4,a5,64
ffffffffc020366c:	f75d                	bnez	a4,ffffffffc020361a <_clock_swap_out_victim+0x44>
ffffffffc020366e:	6018                	ld	a4,0(s0)
ffffffffc0203670:	fd048493          	addi	s1,s1,-48
ffffffffc0203674:	009a3023          	sd	s1,0(s4)
ffffffffc0203678:	671c                	ld	a5,8(a4)
ffffffffc020367a:	6318                	ld	a4,0(a4)
ffffffffc020367c:	02f9b423          	sd	a5,40(s3)
ffffffffc0203680:	e71c                	sd	a5,8(a4)
ffffffffc0203682:	e398                	sd	a4,0(a5)
ffffffffc0203684:	bf7d                	j	ffffffffc0203642 <_clock_swap_out_victim+0x6c>
ffffffffc0203686:	00002697          	auipc	a3,0x2
ffffffffc020368a:	f9a68693          	addi	a3,a3,-102 # ffffffffc0205620 <default_pmm_manager+0x1d0>
ffffffffc020368e:	00001617          	auipc	a2,0x1
ffffffffc0203692:	e9a60613          	addi	a2,a2,-358 # ffffffffc0204528 <etext+0x83c>
ffffffffc0203696:	03100593          	li	a1,49
ffffffffc020369a:	00002517          	auipc	a0,0x2
ffffffffc020369e:	e3e50513          	addi	a0,a0,-450 # ffffffffc02054d8 <default_pmm_manager+0x88>
ffffffffc02036a2:	a4bfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02036a6 <_clock_map_swappable>:
ffffffffc02036a6:	1101                	addi	sp,sp,-32
ffffffffc02036a8:	622c                	ld	a1,64(a2)
ffffffffc02036aa:	e426                	sd	s1,8(sp)
ffffffffc02036ac:	84aa                	mv	s1,a0
ffffffffc02036ae:	6d08                	ld	a0,24(a0)
ffffffffc02036b0:	e822                	sd	s0,16(sp)
ffffffffc02036b2:	8432                	mv	s0,a2
ffffffffc02036b4:	4601                	li	a2,0
ffffffffc02036b6:	e04a                	sd	s2,0(sp)
ffffffffc02036b8:	ec06                	sd	ra,24(sp)
ffffffffc02036ba:	0284b903          	ld	s2,40(s1)
ffffffffc02036be:	a0efd0ef          	jal	ra,ffffffffc02008cc <get_pte>
ffffffffc02036c2:	611c                	ld	a5,0(a0)
ffffffffc02036c4:	03040713          	addi	a4,s0,48
ffffffffc02036c8:	0407f793          	andi	a5,a5,64
ffffffffc02036cc:	e11c                	sd	a5,0(a0)
ffffffffc02036ce:	02090063          	beqz	s2,ffffffffc02036ee <_clock_map_swappable+0x48>
ffffffffc02036d2:	00093783          	ld	a5,0(s2)
ffffffffc02036d6:	60e2                	ld	ra,24(sp)
ffffffffc02036d8:	64a2                	ld	s1,8(sp)
ffffffffc02036da:	6794                	ld	a3,8(a5)
ffffffffc02036dc:	6902                	ld	s2,0(sp)
ffffffffc02036de:	4501                	li	a0,0
ffffffffc02036e0:	e298                	sd	a4,0(a3)
ffffffffc02036e2:	e798                	sd	a4,8(a5)
ffffffffc02036e4:	fc14                	sd	a3,56(s0)
ffffffffc02036e6:	f81c                	sd	a5,48(s0)
ffffffffc02036e8:	6442                	ld	s0,16(sp)
ffffffffc02036ea:	6105                	addi	sp,sp,32
ffffffffc02036ec:	8082                	ret
ffffffffc02036ee:	fc18                	sd	a4,56(s0)
ffffffffc02036f0:	f818                	sd	a4,48(s0)
ffffffffc02036f2:	60e2                	ld	ra,24(sp)
ffffffffc02036f4:	6442                	ld	s0,16(sp)
ffffffffc02036f6:	f498                	sd	a4,40(s1)
ffffffffc02036f8:	6902                	ld	s2,0(sp)
ffffffffc02036fa:	64a2                	ld	s1,8(sp)
ffffffffc02036fc:	4501                	li	a0,0
ffffffffc02036fe:	6105                	addi	sp,sp,32
ffffffffc0203700:	8082                	ret

ffffffffc0203702 <swapfs_init>:
ffffffffc0203702:	1141                	addi	sp,sp,-16
ffffffffc0203704:	4505                	li	a0,1
ffffffffc0203706:	e406                	sd	ra,8(sp)
ffffffffc0203708:	a45fc0ef          	jal	ra,ffffffffc020014c <ide_device_valid>
ffffffffc020370c:	cd01                	beqz	a0,ffffffffc0203724 <swapfs_init+0x22>
ffffffffc020370e:	4505                	li	a0,1
ffffffffc0203710:	a43fc0ef          	jal	ra,ffffffffc0200152 <ide_device_size>
ffffffffc0203714:	60a2                	ld	ra,8(sp)
ffffffffc0203716:	810d                	srli	a0,a0,0x3
ffffffffc0203718:	0000d797          	auipc	a5,0xd
ffffffffc020371c:	a2a7b823          	sd	a0,-1488(a5) # ffffffffc0210148 <max_swap_offset>
ffffffffc0203720:	0141                	addi	sp,sp,16
ffffffffc0203722:	8082                	ret
ffffffffc0203724:	00002617          	auipc	a2,0x2
ffffffffc0203728:	f2460613          	addi	a2,a2,-220 # ffffffffc0205648 <default_pmm_manager+0x1f8>
ffffffffc020372c:	45b5                	li	a1,13
ffffffffc020372e:	00002517          	auipc	a0,0x2
ffffffffc0203732:	f3a50513          	addi	a0,a0,-198 # ffffffffc0205668 <default_pmm_manager+0x218>
ffffffffc0203736:	9b7fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc020373a <swapfs_read>:
ffffffffc020373a:	1141                	addi	sp,sp,-16
ffffffffc020373c:	e406                	sd	ra,8(sp)
ffffffffc020373e:	00855793          	srli	a5,a0,0x8
ffffffffc0203742:	c3a5                	beqz	a5,ffffffffc02037a2 <swapfs_read+0x68>
ffffffffc0203744:	0000d717          	auipc	a4,0xd
ffffffffc0203748:	a0473703          	ld	a4,-1532(a4) # ffffffffc0210148 <max_swap_offset>
ffffffffc020374c:	04e7fb63          	bgeu	a5,a4,ffffffffc02037a2 <swapfs_read+0x68>
ffffffffc0203750:	0000d617          	auipc	a2,0xd
ffffffffc0203754:	96063603          	ld	a2,-1696(a2) # ffffffffc02100b0 <pages>
ffffffffc0203758:	8d91                	sub	a1,a1,a2
ffffffffc020375a:	4035d613          	srai	a2,a1,0x3
ffffffffc020375e:	00002597          	auipc	a1,0x2
ffffffffc0203762:	18a5b583          	ld	a1,394(a1) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0203766:	02b60633          	mul	a2,a2,a1
ffffffffc020376a:	0037959b          	slliw	a1,a5,0x3
ffffffffc020376e:	00002797          	auipc	a5,0x2
ffffffffc0203772:	1827b783          	ld	a5,386(a5) # ffffffffc02058f0 <nbase>
ffffffffc0203776:	0000d717          	auipc	a4,0xd
ffffffffc020377a:	8e273703          	ld	a4,-1822(a4) # ffffffffc0210058 <npage>
ffffffffc020377e:	963e                	add	a2,a2,a5
ffffffffc0203780:	00c61793          	slli	a5,a2,0xc
ffffffffc0203784:	83b1                	srli	a5,a5,0xc
ffffffffc0203786:	0632                	slli	a2,a2,0xc
ffffffffc0203788:	02e7f963          	bgeu	a5,a4,ffffffffc02037ba <swapfs_read+0x80>
ffffffffc020378c:	60a2                	ld	ra,8(sp)
ffffffffc020378e:	0000d797          	auipc	a5,0xd
ffffffffc0203792:	91a7b783          	ld	a5,-1766(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0203796:	46a1                	li	a3,8
ffffffffc0203798:	963e                	add	a2,a2,a5
ffffffffc020379a:	4505                	li	a0,1
ffffffffc020379c:	0141                	addi	sp,sp,16
ffffffffc020379e:	9bbfc06f          	j	ffffffffc0200158 <ide_read_secs>
ffffffffc02037a2:	86aa                	mv	a3,a0
ffffffffc02037a4:	00002617          	auipc	a2,0x2
ffffffffc02037a8:	edc60613          	addi	a2,a2,-292 # ffffffffc0205680 <default_pmm_manager+0x230>
ffffffffc02037ac:	45d1                	li	a1,20
ffffffffc02037ae:	00002517          	auipc	a0,0x2
ffffffffc02037b2:	eba50513          	addi	a0,a0,-326 # ffffffffc0205668 <default_pmm_manager+0x218>
ffffffffc02037b6:	937fc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc02037ba:	86b2                	mv	a3,a2
ffffffffc02037bc:	06a00593          	li	a1,106
ffffffffc02037c0:	00001617          	auipc	a2,0x1
ffffffffc02037c4:	c4060613          	addi	a2,a2,-960 # ffffffffc0204400 <etext+0x714>
ffffffffc02037c8:	00001517          	auipc	a0,0x1
ffffffffc02037cc:	c2850513          	addi	a0,a0,-984 # ffffffffc02043f0 <etext+0x704>
ffffffffc02037d0:	91dfc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc02037d4 <swapfs_write>:
ffffffffc02037d4:	1141                	addi	sp,sp,-16
ffffffffc02037d6:	e406                	sd	ra,8(sp)
ffffffffc02037d8:	00855793          	srli	a5,a0,0x8
ffffffffc02037dc:	c3a5                	beqz	a5,ffffffffc020383c <swapfs_write+0x68>
ffffffffc02037de:	0000d717          	auipc	a4,0xd
ffffffffc02037e2:	96a73703          	ld	a4,-1686(a4) # ffffffffc0210148 <max_swap_offset>
ffffffffc02037e6:	04e7fb63          	bgeu	a5,a4,ffffffffc020383c <swapfs_write+0x68>
ffffffffc02037ea:	0000d617          	auipc	a2,0xd
ffffffffc02037ee:	8c663603          	ld	a2,-1850(a2) # ffffffffc02100b0 <pages>
ffffffffc02037f2:	8d91                	sub	a1,a1,a2
ffffffffc02037f4:	4035d613          	srai	a2,a1,0x3
ffffffffc02037f8:	00002597          	auipc	a1,0x2
ffffffffc02037fc:	0f05b583          	ld	a1,240(a1) # ffffffffc02058e8 <error_string+0x38>
ffffffffc0203800:	02b60633          	mul	a2,a2,a1
ffffffffc0203804:	0037959b          	slliw	a1,a5,0x3
ffffffffc0203808:	00002797          	auipc	a5,0x2
ffffffffc020380c:	0e87b783          	ld	a5,232(a5) # ffffffffc02058f0 <nbase>
ffffffffc0203810:	0000d717          	auipc	a4,0xd
ffffffffc0203814:	84873703          	ld	a4,-1976(a4) # ffffffffc0210058 <npage>
ffffffffc0203818:	963e                	add	a2,a2,a5
ffffffffc020381a:	00c61793          	slli	a5,a2,0xc
ffffffffc020381e:	83b1                	srli	a5,a5,0xc
ffffffffc0203820:	0632                	slli	a2,a2,0xc
ffffffffc0203822:	02e7f963          	bgeu	a5,a4,ffffffffc0203854 <swapfs_write+0x80>
ffffffffc0203826:	60a2                	ld	ra,8(sp)
ffffffffc0203828:	0000d797          	auipc	a5,0xd
ffffffffc020382c:	8807b783          	ld	a5,-1920(a5) # ffffffffc02100a8 <va_pa_offset>
ffffffffc0203830:	46a1                	li	a3,8
ffffffffc0203832:	963e                	add	a2,a2,a5
ffffffffc0203834:	4505                	li	a0,1
ffffffffc0203836:	0141                	addi	sp,sp,16
ffffffffc0203838:	945fc06f          	j	ffffffffc020017c <ide_write_secs>
ffffffffc020383c:	86aa                	mv	a3,a0
ffffffffc020383e:	00002617          	auipc	a2,0x2
ffffffffc0203842:	e4260613          	addi	a2,a2,-446 # ffffffffc0205680 <default_pmm_manager+0x230>
ffffffffc0203846:	45e5                	li	a1,25
ffffffffc0203848:	00002517          	auipc	a0,0x2
ffffffffc020384c:	e2050513          	addi	a0,a0,-480 # ffffffffc0205668 <default_pmm_manager+0x218>
ffffffffc0203850:	89dfc0ef          	jal	ra,ffffffffc02000ec <__panic>
ffffffffc0203854:	86b2                	mv	a3,a2
ffffffffc0203856:	06a00593          	li	a1,106
ffffffffc020385a:	00001617          	auipc	a2,0x1
ffffffffc020385e:	ba660613          	addi	a2,a2,-1114 # ffffffffc0204400 <etext+0x714>
ffffffffc0203862:	00001517          	auipc	a0,0x1
ffffffffc0203866:	b8e50513          	addi	a0,a0,-1138 # ffffffffc02043f0 <etext+0x704>
ffffffffc020386a:	883fc0ef          	jal	ra,ffffffffc02000ec <__panic>

ffffffffc020386e <strlen>:
ffffffffc020386e:	00054783          	lbu	a5,0(a0)
ffffffffc0203872:	872a                	mv	a4,a0
ffffffffc0203874:	4501                	li	a0,0
ffffffffc0203876:	cb81                	beqz	a5,ffffffffc0203886 <strlen+0x18>
ffffffffc0203878:	0505                	addi	a0,a0,1
ffffffffc020387a:	00a707b3          	add	a5,a4,a0
ffffffffc020387e:	0007c783          	lbu	a5,0(a5)
ffffffffc0203882:	fbfd                	bnez	a5,ffffffffc0203878 <strlen+0xa>
ffffffffc0203884:	8082                	ret
ffffffffc0203886:	8082                	ret

ffffffffc0203888 <strnlen>:
ffffffffc0203888:	872a                	mv	a4,a0
ffffffffc020388a:	4501                	li	a0,0
ffffffffc020388c:	e589                	bnez	a1,ffffffffc0203896 <strnlen+0xe>
ffffffffc020388e:	a811                	j	ffffffffc02038a2 <strnlen+0x1a>
ffffffffc0203890:	0505                	addi	a0,a0,1
ffffffffc0203892:	00a58763          	beq	a1,a0,ffffffffc02038a0 <strnlen+0x18>
ffffffffc0203896:	00a707b3          	add	a5,a4,a0
ffffffffc020389a:	0007c783          	lbu	a5,0(a5)
ffffffffc020389e:	fbed                	bnez	a5,ffffffffc0203890 <strnlen+0x8>
ffffffffc02038a0:	8082                	ret
ffffffffc02038a2:	8082                	ret

ffffffffc02038a4 <strcpy>:
ffffffffc02038a4:	87aa                	mv	a5,a0
ffffffffc02038a6:	0005c703          	lbu	a4,0(a1)
ffffffffc02038aa:	0785                	addi	a5,a5,1
ffffffffc02038ac:	0585                	addi	a1,a1,1
ffffffffc02038ae:	fee78fa3          	sb	a4,-1(a5)
ffffffffc02038b2:	fb75                	bnez	a4,ffffffffc02038a6 <strcpy+0x2>
ffffffffc02038b4:	8082                	ret

ffffffffc02038b6 <strcmp>:
ffffffffc02038b6:	00054783          	lbu	a5,0(a0)
ffffffffc02038ba:	0005c703          	lbu	a4,0(a1)
ffffffffc02038be:	cb89                	beqz	a5,ffffffffc02038d0 <strcmp+0x1a>
ffffffffc02038c0:	0505                	addi	a0,a0,1
ffffffffc02038c2:	0585                	addi	a1,a1,1
ffffffffc02038c4:	fee789e3          	beq	a5,a4,ffffffffc02038b6 <strcmp>
ffffffffc02038c8:	0007851b          	sext.w	a0,a5
ffffffffc02038cc:	9d19                	subw	a0,a0,a4
ffffffffc02038ce:	8082                	ret
ffffffffc02038d0:	4501                	li	a0,0
ffffffffc02038d2:	bfed                	j	ffffffffc02038cc <strcmp+0x16>

ffffffffc02038d4 <memset>:
ffffffffc02038d4:	ca01                	beqz	a2,ffffffffc02038e4 <memset+0x10>
ffffffffc02038d6:	962a                	add	a2,a2,a0
ffffffffc02038d8:	87aa                	mv	a5,a0
ffffffffc02038da:	0785                	addi	a5,a5,1
ffffffffc02038dc:	feb78fa3          	sb	a1,-1(a5)
ffffffffc02038e0:	fec79de3          	bne	a5,a2,ffffffffc02038da <memset+0x6>
ffffffffc02038e4:	8082                	ret

ffffffffc02038e6 <memcpy>:
ffffffffc02038e6:	ca19                	beqz	a2,ffffffffc02038fc <memcpy+0x16>
ffffffffc02038e8:	962e                	add	a2,a2,a1
ffffffffc02038ea:	87aa                	mv	a5,a0
ffffffffc02038ec:	0005c703          	lbu	a4,0(a1)
ffffffffc02038f0:	0585                	addi	a1,a1,1
ffffffffc02038f2:	0785                	addi	a5,a5,1
ffffffffc02038f4:	fee78fa3          	sb	a4,-1(a5)
ffffffffc02038f8:	fec59ae3          	bne	a1,a2,ffffffffc02038ec <memcpy+0x6>
ffffffffc02038fc:	8082                	ret

ffffffffc02038fe <printnum>:
ffffffffc02038fe:	02069813          	slli	a6,a3,0x20
ffffffffc0203902:	7179                	addi	sp,sp,-48
ffffffffc0203904:	02085813          	srli	a6,a6,0x20
ffffffffc0203908:	e052                	sd	s4,0(sp)
ffffffffc020390a:	03067a33          	remu	s4,a2,a6
ffffffffc020390e:	f022                	sd	s0,32(sp)
ffffffffc0203910:	ec26                	sd	s1,24(sp)
ffffffffc0203912:	e84a                	sd	s2,16(sp)
ffffffffc0203914:	f406                	sd	ra,40(sp)
ffffffffc0203916:	e44e                	sd	s3,8(sp)
ffffffffc0203918:	84aa                	mv	s1,a0
ffffffffc020391a:	892e                	mv	s2,a1
ffffffffc020391c:	fff7041b          	addiw	s0,a4,-1
ffffffffc0203920:	2a01                	sext.w	s4,s4
ffffffffc0203922:	03067e63          	bgeu	a2,a6,ffffffffc020395e <printnum+0x60>
ffffffffc0203926:	89be                	mv	s3,a5
ffffffffc0203928:	00805763          	blez	s0,ffffffffc0203936 <printnum+0x38>
ffffffffc020392c:	347d                	addiw	s0,s0,-1
ffffffffc020392e:	85ca                	mv	a1,s2
ffffffffc0203930:	854e                	mv	a0,s3
ffffffffc0203932:	9482                	jalr	s1
ffffffffc0203934:	fc65                	bnez	s0,ffffffffc020392c <printnum+0x2e>
ffffffffc0203936:	1a02                	slli	s4,s4,0x20
ffffffffc0203938:	020a5a13          	srli	s4,s4,0x20
ffffffffc020393c:	00002797          	auipc	a5,0x2
ffffffffc0203940:	d6478793          	addi	a5,a5,-668 # ffffffffc02056a0 <default_pmm_manager+0x250>
ffffffffc0203944:	7402                	ld	s0,32(sp)
ffffffffc0203946:	9a3e                	add	s4,s4,a5
ffffffffc0203948:	000a4503          	lbu	a0,0(s4)
ffffffffc020394c:	70a2                	ld	ra,40(sp)
ffffffffc020394e:	69a2                	ld	s3,8(sp)
ffffffffc0203950:	6a02                	ld	s4,0(sp)
ffffffffc0203952:	85ca                	mv	a1,s2
ffffffffc0203954:	8326                	mv	t1,s1
ffffffffc0203956:	6942                	ld	s2,16(sp)
ffffffffc0203958:	64e2                	ld	s1,24(sp)
ffffffffc020395a:	6145                	addi	sp,sp,48
ffffffffc020395c:	8302                	jr	t1
ffffffffc020395e:	03065633          	divu	a2,a2,a6
ffffffffc0203962:	8722                	mv	a4,s0
ffffffffc0203964:	f9bff0ef          	jal	ra,ffffffffc02038fe <printnum>
ffffffffc0203968:	b7f9                	j	ffffffffc0203936 <printnum+0x38>

ffffffffc020396a <vprintfmt>:
ffffffffc020396a:	7119                	addi	sp,sp,-128
ffffffffc020396c:	f4a6                	sd	s1,104(sp)
ffffffffc020396e:	f0ca                	sd	s2,96(sp)
ffffffffc0203970:	ecce                	sd	s3,88(sp)
ffffffffc0203972:	e8d2                	sd	s4,80(sp)
ffffffffc0203974:	e4d6                	sd	s5,72(sp)
ffffffffc0203976:	e0da                	sd	s6,64(sp)
ffffffffc0203978:	fc5e                	sd	s7,56(sp)
ffffffffc020397a:	f06a                	sd	s10,32(sp)
ffffffffc020397c:	fc86                	sd	ra,120(sp)
ffffffffc020397e:	f8a2                	sd	s0,112(sp)
ffffffffc0203980:	f862                	sd	s8,48(sp)
ffffffffc0203982:	f466                	sd	s9,40(sp)
ffffffffc0203984:	ec6e                	sd	s11,24(sp)
ffffffffc0203986:	892a                	mv	s2,a0
ffffffffc0203988:	84ae                	mv	s1,a1
ffffffffc020398a:	8d32                	mv	s10,a2
ffffffffc020398c:	8a36                	mv	s4,a3
ffffffffc020398e:	02500993          	li	s3,37
ffffffffc0203992:	5b7d                	li	s6,-1
ffffffffc0203994:	00002a97          	auipc	s5,0x2
ffffffffc0203998:	d40a8a93          	addi	s5,s5,-704 # ffffffffc02056d4 <default_pmm_manager+0x284>
ffffffffc020399c:	00002b97          	auipc	s7,0x2
ffffffffc02039a0:	f14b8b93          	addi	s7,s7,-236 # ffffffffc02058b0 <error_string>
ffffffffc02039a4:	000d4503          	lbu	a0,0(s10)
ffffffffc02039a8:	001d0413          	addi	s0,s10,1
ffffffffc02039ac:	01350a63          	beq	a0,s3,ffffffffc02039c0 <vprintfmt+0x56>
ffffffffc02039b0:	c121                	beqz	a0,ffffffffc02039f0 <vprintfmt+0x86>
ffffffffc02039b2:	85a6                	mv	a1,s1
ffffffffc02039b4:	0405                	addi	s0,s0,1
ffffffffc02039b6:	9902                	jalr	s2
ffffffffc02039b8:	fff44503          	lbu	a0,-1(s0)
ffffffffc02039bc:	ff351ae3          	bne	a0,s3,ffffffffc02039b0 <vprintfmt+0x46>
ffffffffc02039c0:	00044603          	lbu	a2,0(s0)
ffffffffc02039c4:	02000793          	li	a5,32
ffffffffc02039c8:	4c81                	li	s9,0
ffffffffc02039ca:	4881                	li	a7,0
ffffffffc02039cc:	5c7d                	li	s8,-1
ffffffffc02039ce:	5dfd                	li	s11,-1
ffffffffc02039d0:	05500513          	li	a0,85
ffffffffc02039d4:	4825                	li	a6,9
ffffffffc02039d6:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02039da:	0ff5f593          	andi	a1,a1,255
ffffffffc02039de:	00140d13          	addi	s10,s0,1
ffffffffc02039e2:	04b56263          	bltu	a0,a1,ffffffffc0203a26 <vprintfmt+0xbc>
ffffffffc02039e6:	058a                	slli	a1,a1,0x2
ffffffffc02039e8:	95d6                	add	a1,a1,s5
ffffffffc02039ea:	4194                	lw	a3,0(a1)
ffffffffc02039ec:	96d6                	add	a3,a3,s5
ffffffffc02039ee:	8682                	jr	a3
ffffffffc02039f0:	70e6                	ld	ra,120(sp)
ffffffffc02039f2:	7446                	ld	s0,112(sp)
ffffffffc02039f4:	74a6                	ld	s1,104(sp)
ffffffffc02039f6:	7906                	ld	s2,96(sp)
ffffffffc02039f8:	69e6                	ld	s3,88(sp)
ffffffffc02039fa:	6a46                	ld	s4,80(sp)
ffffffffc02039fc:	6aa6                	ld	s5,72(sp)
ffffffffc02039fe:	6b06                	ld	s6,64(sp)
ffffffffc0203a00:	7be2                	ld	s7,56(sp)
ffffffffc0203a02:	7c42                	ld	s8,48(sp)
ffffffffc0203a04:	7ca2                	ld	s9,40(sp)
ffffffffc0203a06:	7d02                	ld	s10,32(sp)
ffffffffc0203a08:	6de2                	ld	s11,24(sp)
ffffffffc0203a0a:	6109                	addi	sp,sp,128
ffffffffc0203a0c:	8082                	ret
ffffffffc0203a0e:	87b2                	mv	a5,a2
ffffffffc0203a10:	00144603          	lbu	a2,1(s0)
ffffffffc0203a14:	846a                	mv	s0,s10
ffffffffc0203a16:	00140d13          	addi	s10,s0,1
ffffffffc0203a1a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0203a1e:	0ff5f593          	andi	a1,a1,255
ffffffffc0203a22:	fcb572e3          	bgeu	a0,a1,ffffffffc02039e6 <vprintfmt+0x7c>
ffffffffc0203a26:	85a6                	mv	a1,s1
ffffffffc0203a28:	02500513          	li	a0,37
ffffffffc0203a2c:	9902                	jalr	s2
ffffffffc0203a2e:	fff44783          	lbu	a5,-1(s0)
ffffffffc0203a32:	8d22                	mv	s10,s0
ffffffffc0203a34:	f73788e3          	beq	a5,s3,ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203a38:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0203a3c:	1d7d                	addi	s10,s10,-1
ffffffffc0203a3e:	ff379de3          	bne	a5,s3,ffffffffc0203a38 <vprintfmt+0xce>
ffffffffc0203a42:	b78d                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203a44:	fd060c1b          	addiw	s8,a2,-48
ffffffffc0203a48:	00144603          	lbu	a2,1(s0)
ffffffffc0203a4c:	846a                	mv	s0,s10
ffffffffc0203a4e:	fd06069b          	addiw	a3,a2,-48
ffffffffc0203a52:	0006059b          	sext.w	a1,a2
ffffffffc0203a56:	02d86463          	bltu	a6,a3,ffffffffc0203a7e <vprintfmt+0x114>
ffffffffc0203a5a:	00144603          	lbu	a2,1(s0)
ffffffffc0203a5e:	002c169b          	slliw	a3,s8,0x2
ffffffffc0203a62:	0186873b          	addw	a4,a3,s8
ffffffffc0203a66:	0017171b          	slliw	a4,a4,0x1
ffffffffc0203a6a:	9f2d                	addw	a4,a4,a1
ffffffffc0203a6c:	fd06069b          	addiw	a3,a2,-48
ffffffffc0203a70:	0405                	addi	s0,s0,1
ffffffffc0203a72:	fd070c1b          	addiw	s8,a4,-48
ffffffffc0203a76:	0006059b          	sext.w	a1,a2
ffffffffc0203a7a:	fed870e3          	bgeu	a6,a3,ffffffffc0203a5a <vprintfmt+0xf0>
ffffffffc0203a7e:	f40ddce3          	bgez	s11,ffffffffc02039d6 <vprintfmt+0x6c>
ffffffffc0203a82:	8de2                	mv	s11,s8
ffffffffc0203a84:	5c7d                	li	s8,-1
ffffffffc0203a86:	bf81                	j	ffffffffc02039d6 <vprintfmt+0x6c>
ffffffffc0203a88:	fffdc693          	not	a3,s11
ffffffffc0203a8c:	96fd                	srai	a3,a3,0x3f
ffffffffc0203a8e:	00ddfdb3          	and	s11,s11,a3
ffffffffc0203a92:	00144603          	lbu	a2,1(s0)
ffffffffc0203a96:	2d81                	sext.w	s11,s11
ffffffffc0203a98:	846a                	mv	s0,s10
ffffffffc0203a9a:	bf35                	j	ffffffffc02039d6 <vprintfmt+0x6c>
ffffffffc0203a9c:	000a2c03          	lw	s8,0(s4)
ffffffffc0203aa0:	00144603          	lbu	a2,1(s0)
ffffffffc0203aa4:	0a21                	addi	s4,s4,8
ffffffffc0203aa6:	846a                	mv	s0,s10
ffffffffc0203aa8:	bfd9                	j	ffffffffc0203a7e <vprintfmt+0x114>
ffffffffc0203aaa:	4705                	li	a4,1
ffffffffc0203aac:	008a0593          	addi	a1,s4,8
ffffffffc0203ab0:	01174463          	blt	a4,a7,ffffffffc0203ab8 <vprintfmt+0x14e>
ffffffffc0203ab4:	1a088e63          	beqz	a7,ffffffffc0203c70 <vprintfmt+0x306>
ffffffffc0203ab8:	000a3603          	ld	a2,0(s4)
ffffffffc0203abc:	46c1                	li	a3,16
ffffffffc0203abe:	8a2e                	mv	s4,a1
ffffffffc0203ac0:	2781                	sext.w	a5,a5
ffffffffc0203ac2:	876e                	mv	a4,s11
ffffffffc0203ac4:	85a6                	mv	a1,s1
ffffffffc0203ac6:	854a                	mv	a0,s2
ffffffffc0203ac8:	e37ff0ef          	jal	ra,ffffffffc02038fe <printnum>
ffffffffc0203acc:	bde1                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203ace:	000a2503          	lw	a0,0(s4)
ffffffffc0203ad2:	85a6                	mv	a1,s1
ffffffffc0203ad4:	0a21                	addi	s4,s4,8
ffffffffc0203ad6:	9902                	jalr	s2
ffffffffc0203ad8:	b5f1                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203ada:	4705                	li	a4,1
ffffffffc0203adc:	008a0593          	addi	a1,s4,8
ffffffffc0203ae0:	01174463          	blt	a4,a7,ffffffffc0203ae8 <vprintfmt+0x17e>
ffffffffc0203ae4:	18088163          	beqz	a7,ffffffffc0203c66 <vprintfmt+0x2fc>
ffffffffc0203ae8:	000a3603          	ld	a2,0(s4)
ffffffffc0203aec:	46a9                	li	a3,10
ffffffffc0203aee:	8a2e                	mv	s4,a1
ffffffffc0203af0:	bfc1                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203af2:	00144603          	lbu	a2,1(s0)
ffffffffc0203af6:	4c85                	li	s9,1
ffffffffc0203af8:	846a                	mv	s0,s10
ffffffffc0203afa:	bdf1                	j	ffffffffc02039d6 <vprintfmt+0x6c>
ffffffffc0203afc:	85a6                	mv	a1,s1
ffffffffc0203afe:	02500513          	li	a0,37
ffffffffc0203b02:	9902                	jalr	s2
ffffffffc0203b04:	b545                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203b06:	00144603          	lbu	a2,1(s0)
ffffffffc0203b0a:	2885                	addiw	a7,a7,1
ffffffffc0203b0c:	846a                	mv	s0,s10
ffffffffc0203b0e:	b5e1                	j	ffffffffc02039d6 <vprintfmt+0x6c>
ffffffffc0203b10:	4705                	li	a4,1
ffffffffc0203b12:	008a0593          	addi	a1,s4,8
ffffffffc0203b16:	01174463          	blt	a4,a7,ffffffffc0203b1e <vprintfmt+0x1b4>
ffffffffc0203b1a:	14088163          	beqz	a7,ffffffffc0203c5c <vprintfmt+0x2f2>
ffffffffc0203b1e:	000a3603          	ld	a2,0(s4)
ffffffffc0203b22:	46a1                	li	a3,8
ffffffffc0203b24:	8a2e                	mv	s4,a1
ffffffffc0203b26:	bf69                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203b28:	03000513          	li	a0,48
ffffffffc0203b2c:	85a6                	mv	a1,s1
ffffffffc0203b2e:	e03e                	sd	a5,0(sp)
ffffffffc0203b30:	9902                	jalr	s2
ffffffffc0203b32:	85a6                	mv	a1,s1
ffffffffc0203b34:	07800513          	li	a0,120
ffffffffc0203b38:	9902                	jalr	s2
ffffffffc0203b3a:	0a21                	addi	s4,s4,8
ffffffffc0203b3c:	6782                	ld	a5,0(sp)
ffffffffc0203b3e:	46c1                	li	a3,16
ffffffffc0203b40:	ff8a3603          	ld	a2,-8(s4)
ffffffffc0203b44:	bfb5                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203b46:	000a3403          	ld	s0,0(s4)
ffffffffc0203b4a:	008a0713          	addi	a4,s4,8
ffffffffc0203b4e:	e03a                	sd	a4,0(sp)
ffffffffc0203b50:	14040263          	beqz	s0,ffffffffc0203c94 <vprintfmt+0x32a>
ffffffffc0203b54:	0fb05763          	blez	s11,ffffffffc0203c42 <vprintfmt+0x2d8>
ffffffffc0203b58:	02d00693          	li	a3,45
ffffffffc0203b5c:	0cd79163          	bne	a5,a3,ffffffffc0203c1e <vprintfmt+0x2b4>
ffffffffc0203b60:	00044783          	lbu	a5,0(s0)
ffffffffc0203b64:	0007851b          	sext.w	a0,a5
ffffffffc0203b68:	cf85                	beqz	a5,ffffffffc0203ba0 <vprintfmt+0x236>
ffffffffc0203b6a:	00140a13          	addi	s4,s0,1
ffffffffc0203b6e:	05e00413          	li	s0,94
ffffffffc0203b72:	000c4563          	bltz	s8,ffffffffc0203b7c <vprintfmt+0x212>
ffffffffc0203b76:	3c7d                	addiw	s8,s8,-1
ffffffffc0203b78:	036c0263          	beq	s8,s6,ffffffffc0203b9c <vprintfmt+0x232>
ffffffffc0203b7c:	85a6                	mv	a1,s1
ffffffffc0203b7e:	0e0c8e63          	beqz	s9,ffffffffc0203c7a <vprintfmt+0x310>
ffffffffc0203b82:	3781                	addiw	a5,a5,-32
ffffffffc0203b84:	0ef47b63          	bgeu	s0,a5,ffffffffc0203c7a <vprintfmt+0x310>
ffffffffc0203b88:	03f00513          	li	a0,63
ffffffffc0203b8c:	9902                	jalr	s2
ffffffffc0203b8e:	000a4783          	lbu	a5,0(s4)
ffffffffc0203b92:	3dfd                	addiw	s11,s11,-1
ffffffffc0203b94:	0a05                	addi	s4,s4,1
ffffffffc0203b96:	0007851b          	sext.w	a0,a5
ffffffffc0203b9a:	ffe1                	bnez	a5,ffffffffc0203b72 <vprintfmt+0x208>
ffffffffc0203b9c:	01b05963          	blez	s11,ffffffffc0203bae <vprintfmt+0x244>
ffffffffc0203ba0:	3dfd                	addiw	s11,s11,-1
ffffffffc0203ba2:	85a6                	mv	a1,s1
ffffffffc0203ba4:	02000513          	li	a0,32
ffffffffc0203ba8:	9902                	jalr	s2
ffffffffc0203baa:	fe0d9be3          	bnez	s11,ffffffffc0203ba0 <vprintfmt+0x236>
ffffffffc0203bae:	6a02                	ld	s4,0(sp)
ffffffffc0203bb0:	bbd5                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203bb2:	4705                	li	a4,1
ffffffffc0203bb4:	008a0c93          	addi	s9,s4,8
ffffffffc0203bb8:	01174463          	blt	a4,a7,ffffffffc0203bc0 <vprintfmt+0x256>
ffffffffc0203bbc:	08088d63          	beqz	a7,ffffffffc0203c56 <vprintfmt+0x2ec>
ffffffffc0203bc0:	000a3403          	ld	s0,0(s4)
ffffffffc0203bc4:	0a044d63          	bltz	s0,ffffffffc0203c7e <vprintfmt+0x314>
ffffffffc0203bc8:	8622                	mv	a2,s0
ffffffffc0203bca:	8a66                	mv	s4,s9
ffffffffc0203bcc:	46a9                	li	a3,10
ffffffffc0203bce:	bdcd                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203bd0:	000a2783          	lw	a5,0(s4)
ffffffffc0203bd4:	4719                	li	a4,6
ffffffffc0203bd6:	0a21                	addi	s4,s4,8
ffffffffc0203bd8:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0203bdc:	8fb5                	xor	a5,a5,a3
ffffffffc0203bde:	40d786bb          	subw	a3,a5,a3
ffffffffc0203be2:	02d74163          	blt	a4,a3,ffffffffc0203c04 <vprintfmt+0x29a>
ffffffffc0203be6:	00369793          	slli	a5,a3,0x3
ffffffffc0203bea:	97de                	add	a5,a5,s7
ffffffffc0203bec:	639c                	ld	a5,0(a5)
ffffffffc0203bee:	cb99                	beqz	a5,ffffffffc0203c04 <vprintfmt+0x29a>
ffffffffc0203bf0:	86be                	mv	a3,a5
ffffffffc0203bf2:	00002617          	auipc	a2,0x2
ffffffffc0203bf6:	ade60613          	addi	a2,a2,-1314 # ffffffffc02056d0 <default_pmm_manager+0x280>
ffffffffc0203bfa:	85a6                	mv	a1,s1
ffffffffc0203bfc:	854a                	mv	a0,s2
ffffffffc0203bfe:	0ce000ef          	jal	ra,ffffffffc0203ccc <printfmt>
ffffffffc0203c02:	b34d                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203c04:	00002617          	auipc	a2,0x2
ffffffffc0203c08:	abc60613          	addi	a2,a2,-1348 # ffffffffc02056c0 <default_pmm_manager+0x270>
ffffffffc0203c0c:	85a6                	mv	a1,s1
ffffffffc0203c0e:	854a                	mv	a0,s2
ffffffffc0203c10:	0bc000ef          	jal	ra,ffffffffc0203ccc <printfmt>
ffffffffc0203c14:	bb41                	j	ffffffffc02039a4 <vprintfmt+0x3a>
ffffffffc0203c16:	00002417          	auipc	s0,0x2
ffffffffc0203c1a:	aa240413          	addi	s0,s0,-1374 # ffffffffc02056b8 <default_pmm_manager+0x268>
ffffffffc0203c1e:	85e2                	mv	a1,s8
ffffffffc0203c20:	8522                	mv	a0,s0
ffffffffc0203c22:	e43e                	sd	a5,8(sp)
ffffffffc0203c24:	c65ff0ef          	jal	ra,ffffffffc0203888 <strnlen>
ffffffffc0203c28:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0203c2c:	01b05b63          	blez	s11,ffffffffc0203c42 <vprintfmt+0x2d8>
ffffffffc0203c30:	67a2                	ld	a5,8(sp)
ffffffffc0203c32:	00078a1b          	sext.w	s4,a5
ffffffffc0203c36:	3dfd                	addiw	s11,s11,-1
ffffffffc0203c38:	85a6                	mv	a1,s1
ffffffffc0203c3a:	8552                	mv	a0,s4
ffffffffc0203c3c:	9902                	jalr	s2
ffffffffc0203c3e:	fe0d9ce3          	bnez	s11,ffffffffc0203c36 <vprintfmt+0x2cc>
ffffffffc0203c42:	00044783          	lbu	a5,0(s0)
ffffffffc0203c46:	00140a13          	addi	s4,s0,1
ffffffffc0203c4a:	0007851b          	sext.w	a0,a5
ffffffffc0203c4e:	d3a5                	beqz	a5,ffffffffc0203bae <vprintfmt+0x244>
ffffffffc0203c50:	05e00413          	li	s0,94
ffffffffc0203c54:	bf39                	j	ffffffffc0203b72 <vprintfmt+0x208>
ffffffffc0203c56:	000a2403          	lw	s0,0(s4)
ffffffffc0203c5a:	b7ad                	j	ffffffffc0203bc4 <vprintfmt+0x25a>
ffffffffc0203c5c:	000a6603          	lwu	a2,0(s4)
ffffffffc0203c60:	46a1                	li	a3,8
ffffffffc0203c62:	8a2e                	mv	s4,a1
ffffffffc0203c64:	bdb1                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203c66:	000a6603          	lwu	a2,0(s4)
ffffffffc0203c6a:	46a9                	li	a3,10
ffffffffc0203c6c:	8a2e                	mv	s4,a1
ffffffffc0203c6e:	bd89                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203c70:	000a6603          	lwu	a2,0(s4)
ffffffffc0203c74:	46c1                	li	a3,16
ffffffffc0203c76:	8a2e                	mv	s4,a1
ffffffffc0203c78:	b5a1                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203c7a:	9902                	jalr	s2
ffffffffc0203c7c:	bf09                	j	ffffffffc0203b8e <vprintfmt+0x224>
ffffffffc0203c7e:	85a6                	mv	a1,s1
ffffffffc0203c80:	02d00513          	li	a0,45
ffffffffc0203c84:	e03e                	sd	a5,0(sp)
ffffffffc0203c86:	9902                	jalr	s2
ffffffffc0203c88:	6782                	ld	a5,0(sp)
ffffffffc0203c8a:	8a66                	mv	s4,s9
ffffffffc0203c8c:	40800633          	neg	a2,s0
ffffffffc0203c90:	46a9                	li	a3,10
ffffffffc0203c92:	b53d                	j	ffffffffc0203ac0 <vprintfmt+0x156>
ffffffffc0203c94:	03b05163          	blez	s11,ffffffffc0203cb6 <vprintfmt+0x34c>
ffffffffc0203c98:	02d00693          	li	a3,45
ffffffffc0203c9c:	f6d79de3          	bne	a5,a3,ffffffffc0203c16 <vprintfmt+0x2ac>
ffffffffc0203ca0:	00002417          	auipc	s0,0x2
ffffffffc0203ca4:	a1840413          	addi	s0,s0,-1512 # ffffffffc02056b8 <default_pmm_manager+0x268>
ffffffffc0203ca8:	02800793          	li	a5,40
ffffffffc0203cac:	02800513          	li	a0,40
ffffffffc0203cb0:	00140a13          	addi	s4,s0,1
ffffffffc0203cb4:	bd6d                	j	ffffffffc0203b6e <vprintfmt+0x204>
ffffffffc0203cb6:	00002a17          	auipc	s4,0x2
ffffffffc0203cba:	a03a0a13          	addi	s4,s4,-1533 # ffffffffc02056b9 <default_pmm_manager+0x269>
ffffffffc0203cbe:	02800513          	li	a0,40
ffffffffc0203cc2:	02800793          	li	a5,40
ffffffffc0203cc6:	05e00413          	li	s0,94
ffffffffc0203cca:	b565                	j	ffffffffc0203b72 <vprintfmt+0x208>

ffffffffc0203ccc <printfmt>:
ffffffffc0203ccc:	715d                	addi	sp,sp,-80
ffffffffc0203cce:	02810313          	addi	t1,sp,40
ffffffffc0203cd2:	f436                	sd	a3,40(sp)
ffffffffc0203cd4:	869a                	mv	a3,t1
ffffffffc0203cd6:	ec06                	sd	ra,24(sp)
ffffffffc0203cd8:	f83a                	sd	a4,48(sp)
ffffffffc0203cda:	fc3e                	sd	a5,56(sp)
ffffffffc0203cdc:	e0c2                	sd	a6,64(sp)
ffffffffc0203cde:	e4c6                	sd	a7,72(sp)
ffffffffc0203ce0:	e41a                	sd	t1,8(sp)
ffffffffc0203ce2:	c89ff0ef          	jal	ra,ffffffffc020396a <vprintfmt>
ffffffffc0203ce6:	60e2                	ld	ra,24(sp)
ffffffffc0203ce8:	6161                	addi	sp,sp,80
ffffffffc0203cea:	8082                	ret
