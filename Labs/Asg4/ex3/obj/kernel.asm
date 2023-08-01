
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200000:	c020a2b7          	lui	t0,0xc020a
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc0200004:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200008:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc020000a:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc020000e:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc0200012:	fff0031b          	addiw	t1,zero,-1
ffffffffc0200016:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200018:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc020001c:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200020:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc0200024:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200028:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020002c:	03228293          	addi	t0,t0,50 # ffffffffc0200032 <kern_init>
    jr t0
ffffffffc0200030:	8282                	jr	t0

ffffffffc0200032 <kern_init>:

int kern_init(void) __attribute__((noreturn));
int
kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc0200032:	00048517          	auipc	a0,0x48
ffffffffc0200036:	00650513          	addi	a0,a0,6 # ffffffffc0248038 <buf>
ffffffffc020003a:	00053617          	auipc	a2,0x53
ffffffffc020003e:	5c660613          	addi	a2,a2,1478 # ffffffffc0253600 <end>
kern_init(void) {
ffffffffc0200042:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
kern_init(void) {
ffffffffc0200048:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004a:	00d040ef          	jal	ra,ffffffffc0204856 <memset>
    cons_init();                // init the console
ffffffffc020004e:	538000ef          	jal	ra,ffffffffc0200586 <cons_init>

    const char *message = "OS is loading ...";
    cprintf("%s\n\n", message);
ffffffffc0200052:	00005597          	auipc	a1,0x5
ffffffffc0200056:	c3658593          	addi	a1,a1,-970 # ffffffffc0204c88 <etext+0x4>
ffffffffc020005a:	00005517          	auipc	a0,0x5
ffffffffc020005e:	c4650513          	addi	a0,a0,-954 # ffffffffc0204ca0 <etext+0x1c>
ffffffffc0200062:	062000ef          	jal	ra,ffffffffc02000c4 <cprintf>

    pmm_init();                 // init physical memory management
ffffffffc0200066:	5c9000ef          	jal	ra,ffffffffc0200e2e <pmm_init>

    idt_init();                 // init interrupt descriptor table
ffffffffc020006a:	59a000ef          	jal	ra,ffffffffc0200604 <idt_init>

    vmm_init();                 // init virtual memory management
ffffffffc020006e:	5f7010ef          	jal	ra,ffffffffc0201e64 <vmm_init>
    sched_init();
ffffffffc0200072:	3ce040ef          	jal	ra,ffffffffc0204440 <sched_init>
    proc_init();                // init process table
ffffffffc0200076:	250040ef          	jal	ra,ffffffffc02042c6 <proc_init>
    
    ide_init();                 // init ide devices
ffffffffc020007a:	49e000ef          	jal	ra,ffffffffc0200518 <ide_init>
    swap_init();                // init swap
ffffffffc020007e:	326020ef          	jal	ra,ffffffffc02023a4 <swap_init>

    //clock_init();               // init clock interrupt
    intr_enable();              // enable irq interrupt
ffffffffc0200082:	576000ef          	jal	ra,ffffffffc02005f8 <intr_enable>
    
    cpu_idle();                 // run idle process
ffffffffc0200086:	376040ef          	jal	ra,ffffffffc02043fc <cpu_idle>

ffffffffc020008a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020008a:	1141                	addi	sp,sp,-16
ffffffffc020008c:	e022                	sd	s0,0(sp)
ffffffffc020008e:	e406                	sd	ra,8(sp)
ffffffffc0200090:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200092:	4f6000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    (*cnt) ++;
ffffffffc0200096:	401c                	lw	a5,0(s0)
}
ffffffffc0200098:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020009a:	2785                	addiw	a5,a5,1
ffffffffc020009c:	c01c                	sw	a5,0(s0)
}
ffffffffc020009e:	6402                	ld	s0,0(sp)
ffffffffc02000a0:	0141                	addi	sp,sp,16
ffffffffc02000a2:	8082                	ret

ffffffffc02000a4 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000a4:	1101                	addi	sp,sp,-32
ffffffffc02000a6:	862a                	mv	a2,a0
ffffffffc02000a8:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000aa:	00000517          	auipc	a0,0x0
ffffffffc02000ae:	fe050513          	addi	a0,a0,-32 # ffffffffc020008a <cputch>
ffffffffc02000b2:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b4:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000b6:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000b8:	035040ef          	jal	ra,ffffffffc02048ec <vprintfmt>
    return cnt;
}
ffffffffc02000bc:	60e2                	ld	ra,24(sp)
ffffffffc02000be:	4532                	lw	a0,12(sp)
ffffffffc02000c0:	6105                	addi	sp,sp,32
ffffffffc02000c2:	8082                	ret

ffffffffc02000c4 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000c4:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000c6:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000ca:	8e2a                	mv	t3,a0
ffffffffc02000cc:	f42e                	sd	a1,40(sp)
ffffffffc02000ce:	f832                	sd	a2,48(sp)
ffffffffc02000d0:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d2:	00000517          	auipc	a0,0x0
ffffffffc02000d6:	fb850513          	addi	a0,a0,-72 # ffffffffc020008a <cputch>
ffffffffc02000da:	004c                	addi	a1,sp,4
ffffffffc02000dc:	869a                	mv	a3,t1
ffffffffc02000de:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000e0:	ec06                	sd	ra,24(sp)
ffffffffc02000e2:	e0ba                	sd	a4,64(sp)
ffffffffc02000e4:	e4be                	sd	a5,72(sp)
ffffffffc02000e6:	e8c2                	sd	a6,80(sp)
ffffffffc02000e8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000ea:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000ec:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ee:	7fe040ef          	jal	ra,ffffffffc02048ec <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000f2:	60e2                	ld	ra,24(sp)
ffffffffc02000f4:	4512                	lw	a0,4(sp)
ffffffffc02000f6:	6125                	addi	sp,sp,96
ffffffffc02000f8:	8082                	ret

ffffffffc02000fa <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000fa:	a179                	j	ffffffffc0200588 <cons_putc>

ffffffffc02000fc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc02000fc:	1101                	addi	sp,sp,-32
ffffffffc02000fe:	e822                	sd	s0,16(sp)
ffffffffc0200100:	ec06                	sd	ra,24(sp)
ffffffffc0200102:	e426                	sd	s1,8(sp)
ffffffffc0200104:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200106:	00054503          	lbu	a0,0(a0)
ffffffffc020010a:	c51d                	beqz	a0,ffffffffc0200138 <cputs+0x3c>
ffffffffc020010c:	0405                	addi	s0,s0,1
ffffffffc020010e:	4485                	li	s1,1
ffffffffc0200110:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200112:	476000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200116:	00044503          	lbu	a0,0(s0)
ffffffffc020011a:	008487bb          	addw	a5,s1,s0
ffffffffc020011e:	0405                	addi	s0,s0,1
ffffffffc0200120:	f96d                	bnez	a0,ffffffffc0200112 <cputs+0x16>
ffffffffc0200122:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200126:	4529                	li	a0,10
ffffffffc0200128:	460000ef          	jal	ra,ffffffffc0200588 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc020012c:	60e2                	ld	ra,24(sp)
ffffffffc020012e:	8522                	mv	a0,s0
ffffffffc0200130:	6442                	ld	s0,16(sp)
ffffffffc0200132:	64a2                	ld	s1,8(sp)
ffffffffc0200134:	6105                	addi	sp,sp,32
ffffffffc0200136:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200138:	4405                	li	s0,1
ffffffffc020013a:	b7f5                	j	ffffffffc0200126 <cputs+0x2a>

ffffffffc020013c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc020013c:	1141                	addi	sp,sp,-16
ffffffffc020013e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200140:	47c000ef          	jal	ra,ffffffffc02005bc <cons_getc>
ffffffffc0200144:	dd75                	beqz	a0,ffffffffc0200140 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200146:	60a2                	ld	ra,8(sp)
ffffffffc0200148:	0141                	addi	sp,sp,16
ffffffffc020014a:	8082                	ret

ffffffffc020014c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc020014c:	715d                	addi	sp,sp,-80
ffffffffc020014e:	e486                	sd	ra,72(sp)
ffffffffc0200150:	e0a6                	sd	s1,64(sp)
ffffffffc0200152:	fc4a                	sd	s2,56(sp)
ffffffffc0200154:	f84e                	sd	s3,48(sp)
ffffffffc0200156:	f452                	sd	s4,40(sp)
ffffffffc0200158:	f056                	sd	s5,32(sp)
ffffffffc020015a:	ec5a                	sd	s6,24(sp)
ffffffffc020015c:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc020015e:	c901                	beqz	a0,ffffffffc020016e <readline+0x22>
ffffffffc0200160:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200162:	00005517          	auipc	a0,0x5
ffffffffc0200166:	b4650513          	addi	a0,a0,-1210 # ffffffffc0204ca8 <etext+0x24>
ffffffffc020016a:	f5bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
readline(const char *prompt) {
ffffffffc020016e:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200170:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200172:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200174:	4aa9                	li	s5,10
ffffffffc0200176:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0200178:	00048b97          	auipc	s7,0x48
ffffffffc020017c:	ec0b8b93          	addi	s7,s7,-320 # ffffffffc0248038 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200180:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0200184:	fb9ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc0200188:	00054a63          	bltz	a0,ffffffffc020019c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020018c:	00a95a63          	bge	s2,a0,ffffffffc02001a0 <readline+0x54>
ffffffffc0200190:	029a5263          	bge	s4,s1,ffffffffc02001b4 <readline+0x68>
        c = getchar();
ffffffffc0200194:	fa9ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc0200198:	fe055ae3          	bgez	a0,ffffffffc020018c <readline+0x40>
            return NULL;
ffffffffc020019c:	4501                	li	a0,0
ffffffffc020019e:	a091                	j	ffffffffc02001e2 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001a0:	03351463          	bne	a0,s3,ffffffffc02001c8 <readline+0x7c>
ffffffffc02001a4:	e8a9                	bnez	s1,ffffffffc02001f6 <readline+0xaa>
        c = getchar();
ffffffffc02001a6:	f97ff0ef          	jal	ra,ffffffffc020013c <getchar>
        if (c < 0) {
ffffffffc02001aa:	fe0549e3          	bltz	a0,ffffffffc020019c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001ae:	fea959e3          	bge	s2,a0,ffffffffc02001a0 <readline+0x54>
ffffffffc02001b2:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001b4:	e42a                	sd	a0,8(sp)
ffffffffc02001b6:	f45ff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            buf[i ++] = c;
ffffffffc02001ba:	6522                	ld	a0,8(sp)
ffffffffc02001bc:	009b87b3          	add	a5,s7,s1
ffffffffc02001c0:	2485                	addiw	s1,s1,1
ffffffffc02001c2:	00a78023          	sb	a0,0(a5)
ffffffffc02001c6:	bf7d                	j	ffffffffc0200184 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001c8:	01550463          	beq	a0,s5,ffffffffc02001d0 <readline+0x84>
ffffffffc02001cc:	fb651ce3          	bne	a0,s6,ffffffffc0200184 <readline+0x38>
            cputchar(c);
ffffffffc02001d0:	f2bff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            buf[i] = '\0';
ffffffffc02001d4:	00048517          	auipc	a0,0x48
ffffffffc02001d8:	e6450513          	addi	a0,a0,-412 # ffffffffc0248038 <buf>
ffffffffc02001dc:	94aa                	add	s1,s1,a0
ffffffffc02001de:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc02001e2:	60a6                	ld	ra,72(sp)
ffffffffc02001e4:	6486                	ld	s1,64(sp)
ffffffffc02001e6:	7962                	ld	s2,56(sp)
ffffffffc02001e8:	79c2                	ld	s3,48(sp)
ffffffffc02001ea:	7a22                	ld	s4,40(sp)
ffffffffc02001ec:	7a82                	ld	s5,32(sp)
ffffffffc02001ee:	6b62                	ld	s6,24(sp)
ffffffffc02001f0:	6bc2                	ld	s7,16(sp)
ffffffffc02001f2:	6161                	addi	sp,sp,80
ffffffffc02001f4:	8082                	ret
            cputchar(c);
ffffffffc02001f6:	4521                	li	a0,8
ffffffffc02001f8:	f03ff0ef          	jal	ra,ffffffffc02000fa <cputchar>
            i --;
ffffffffc02001fc:	34fd                	addiw	s1,s1,-1
ffffffffc02001fe:	b759                	j	ffffffffc0200184 <readline+0x38>

ffffffffc0200200 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200200:	00053317          	auipc	t1,0x53
ffffffffc0200204:	26830313          	addi	t1,t1,616 # ffffffffc0253468 <is_panic>
ffffffffc0200208:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020020c:	715d                	addi	sp,sp,-80
ffffffffc020020e:	ec06                	sd	ra,24(sp)
ffffffffc0200210:	e822                	sd	s0,16(sp)
ffffffffc0200212:	f436                	sd	a3,40(sp)
ffffffffc0200214:	f83a                	sd	a4,48(sp)
ffffffffc0200216:	fc3e                	sd	a5,56(sp)
ffffffffc0200218:	e0c2                	sd	a6,64(sp)
ffffffffc020021a:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc020021c:	020e1a63          	bnez	t3,ffffffffc0200250 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200220:	4785                	li	a5,1
ffffffffc0200222:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc0200226:	8432                	mv	s0,a2
ffffffffc0200228:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020022a:	862e                	mv	a2,a1
ffffffffc020022c:	85aa                	mv	a1,a0
ffffffffc020022e:	00005517          	auipc	a0,0x5
ffffffffc0200232:	a8250513          	addi	a0,a0,-1406 # ffffffffc0204cb0 <etext+0x2c>
    va_start(ap, fmt);
ffffffffc0200236:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200238:	e8dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020023c:	65a2                	ld	a1,8(sp)
ffffffffc020023e:	8522                	mv	a0,s0
ffffffffc0200240:	e65ff0ef          	jal	ra,ffffffffc02000a4 <vcprintf>
    cprintf("\n");
ffffffffc0200244:	00006517          	auipc	a0,0x6
ffffffffc0200248:	efc50513          	addi	a0,a0,-260 # ffffffffc0206140 <default_pmm_manager+0xe8>
ffffffffc020024c:	e79ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200250:	4501                	li	a0,0
ffffffffc0200252:	4581                	li	a1,0
ffffffffc0200254:	4601                	li	a2,0
ffffffffc0200256:	48a1                	li	a7,8
ffffffffc0200258:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc020025c:	3a2000ef          	jal	ra,ffffffffc02005fe <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200260:	4501                	li	a0,0
ffffffffc0200262:	174000ef          	jal	ra,ffffffffc02003d6 <kmonitor>
    while (1) {
ffffffffc0200266:	bfed                	j	ffffffffc0200260 <__panic+0x60>

ffffffffc0200268 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200268:	715d                	addi	sp,sp,-80
ffffffffc020026a:	832e                	mv	t1,a1
ffffffffc020026c:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020026e:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200270:	8432                	mv	s0,a2
ffffffffc0200272:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200274:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200276:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200278:	00005517          	auipc	a0,0x5
ffffffffc020027c:	a5850513          	addi	a0,a0,-1448 # ffffffffc0204cd0 <etext+0x4c>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200280:	ec06                	sd	ra,24(sp)
ffffffffc0200282:	f436                	sd	a3,40(sp)
ffffffffc0200284:	f83a                	sd	a4,48(sp)
ffffffffc0200286:	e0c2                	sd	a6,64(sp)
ffffffffc0200288:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020028a:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020028c:	e39ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200290:	65a2                	ld	a1,8(sp)
ffffffffc0200292:	8522                	mv	a0,s0
ffffffffc0200294:	e11ff0ef          	jal	ra,ffffffffc02000a4 <vcprintf>
    cprintf("\n");
ffffffffc0200298:	00006517          	auipc	a0,0x6
ffffffffc020029c:	ea850513          	addi	a0,a0,-344 # ffffffffc0206140 <default_pmm_manager+0xe8>
ffffffffc02002a0:	e25ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    va_end(ap);
}
ffffffffc02002a4:	60e2                	ld	ra,24(sp)
ffffffffc02002a6:	6442                	ld	s0,16(sp)
ffffffffc02002a8:	6161                	addi	sp,sp,80
ffffffffc02002aa:	8082                	ret

ffffffffc02002ac <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc02002ac:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002ae:	00005517          	auipc	a0,0x5
ffffffffc02002b2:	a4250513          	addi	a0,a0,-1470 # ffffffffc0204cf0 <etext+0x6c>
void print_kerninfo(void) {
ffffffffc02002b6:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002b8:	e0dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002bc:	00000597          	auipc	a1,0x0
ffffffffc02002c0:	d7658593          	addi	a1,a1,-650 # ffffffffc0200032 <kern_init>
ffffffffc02002c4:	00005517          	auipc	a0,0x5
ffffffffc02002c8:	a4c50513          	addi	a0,a0,-1460 # ffffffffc0204d10 <etext+0x8c>
ffffffffc02002cc:	df9ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	9b458593          	addi	a1,a1,-1612 # ffffffffc0204c84 <etext>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	a5850513          	addi	a0,a0,-1448 # ffffffffc0204d30 <etext+0xac>
ffffffffc02002e0:	de5ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc02002e4:	00048597          	auipc	a1,0x48
ffffffffc02002e8:	d5458593          	addi	a1,a1,-684 # ffffffffc0248038 <buf>
ffffffffc02002ec:	00005517          	auipc	a0,0x5
ffffffffc02002f0:	a6450513          	addi	a0,a0,-1436 # ffffffffc0204d50 <etext+0xcc>
ffffffffc02002f4:	dd1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc02002f8:	00053597          	auipc	a1,0x53
ffffffffc02002fc:	30858593          	addi	a1,a1,776 # ffffffffc0253600 <end>
ffffffffc0200300:	00005517          	auipc	a0,0x5
ffffffffc0200304:	a7050513          	addi	a0,a0,-1424 # ffffffffc0204d70 <etext+0xec>
ffffffffc0200308:	dbdff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020030c:	00053597          	auipc	a1,0x53
ffffffffc0200310:	6f358593          	addi	a1,a1,1779 # ffffffffc02539ff <end+0x3ff>
ffffffffc0200314:	00000797          	auipc	a5,0x0
ffffffffc0200318:	d1e78793          	addi	a5,a5,-738 # ffffffffc0200032 <kern_init>
ffffffffc020031c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200320:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200324:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200326:	3ff5f593          	andi	a1,a1,1023
ffffffffc020032a:	95be                	add	a1,a1,a5
ffffffffc020032c:	85a9                	srai	a1,a1,0xa
ffffffffc020032e:	00005517          	auipc	a0,0x5
ffffffffc0200332:	a6250513          	addi	a0,a0,-1438 # ffffffffc0204d90 <etext+0x10c>
}
ffffffffc0200336:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200338:	b371                	j	ffffffffc02000c4 <cprintf>

ffffffffc020033a <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020033a:	1141                	addi	sp,sp,-16
     * and line number, etc.
     *    (3.5) popup a calling stackframe
     *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
     *                   the calling funciton's ebp = ss:[ebp]
     */
    panic("Not Implemented!");
ffffffffc020033c:	00005617          	auipc	a2,0x5
ffffffffc0200340:	a8460613          	addi	a2,a2,-1404 # ffffffffc0204dc0 <etext+0x13c>
ffffffffc0200344:	05b00593          	li	a1,91
ffffffffc0200348:	00005517          	auipc	a0,0x5
ffffffffc020034c:	a9050513          	addi	a0,a0,-1392 # ffffffffc0204dd8 <etext+0x154>
void print_stackframe(void) {
ffffffffc0200350:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200352:	eafff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200356 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200356:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200358:	00005617          	auipc	a2,0x5
ffffffffc020035c:	a9860613          	addi	a2,a2,-1384 # ffffffffc0204df0 <etext+0x16c>
ffffffffc0200360:	00005597          	auipc	a1,0x5
ffffffffc0200364:	ab058593          	addi	a1,a1,-1360 # ffffffffc0204e10 <etext+0x18c>
ffffffffc0200368:	00005517          	auipc	a0,0x5
ffffffffc020036c:	ab050513          	addi	a0,a0,-1360 # ffffffffc0204e18 <etext+0x194>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200370:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200372:	d53ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200376:	00005617          	auipc	a2,0x5
ffffffffc020037a:	ab260613          	addi	a2,a2,-1358 # ffffffffc0204e28 <etext+0x1a4>
ffffffffc020037e:	00005597          	auipc	a1,0x5
ffffffffc0200382:	ad258593          	addi	a1,a1,-1326 # ffffffffc0204e50 <etext+0x1cc>
ffffffffc0200386:	00005517          	auipc	a0,0x5
ffffffffc020038a:	a9250513          	addi	a0,a0,-1390 # ffffffffc0204e18 <etext+0x194>
ffffffffc020038e:	d37ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200392:	00005617          	auipc	a2,0x5
ffffffffc0200396:	ace60613          	addi	a2,a2,-1330 # ffffffffc0204e60 <etext+0x1dc>
ffffffffc020039a:	00005597          	auipc	a1,0x5
ffffffffc020039e:	ae658593          	addi	a1,a1,-1306 # ffffffffc0204e80 <etext+0x1fc>
ffffffffc02003a2:	00005517          	auipc	a0,0x5
ffffffffc02003a6:	a7650513          	addi	a0,a0,-1418 # ffffffffc0204e18 <etext+0x194>
ffffffffc02003aa:	d1bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    }
    return 0;
}
ffffffffc02003ae:	60a2                	ld	ra,8(sp)
ffffffffc02003b0:	4501                	li	a0,0
ffffffffc02003b2:	0141                	addi	sp,sp,16
ffffffffc02003b4:	8082                	ret

ffffffffc02003b6 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003b6:	1141                	addi	sp,sp,-16
ffffffffc02003b8:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003ba:	ef3ff0ef          	jal	ra,ffffffffc02002ac <print_kerninfo>
    return 0;
}
ffffffffc02003be:	60a2                	ld	ra,8(sp)
ffffffffc02003c0:	4501                	li	a0,0
ffffffffc02003c2:	0141                	addi	sp,sp,16
ffffffffc02003c4:	8082                	ret

ffffffffc02003c6 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003c6:	1141                	addi	sp,sp,-16
ffffffffc02003c8:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003ca:	f71ff0ef          	jal	ra,ffffffffc020033a <print_stackframe>
    return 0;
}
ffffffffc02003ce:	60a2                	ld	ra,8(sp)
ffffffffc02003d0:	4501                	li	a0,0
ffffffffc02003d2:	0141                	addi	sp,sp,16
ffffffffc02003d4:	8082                	ret

ffffffffc02003d6 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02003d6:	7115                	addi	sp,sp,-224
ffffffffc02003d8:	e962                	sd	s8,144(sp)
ffffffffc02003da:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003dc:	00005517          	auipc	a0,0x5
ffffffffc02003e0:	ab450513          	addi	a0,a0,-1356 # ffffffffc0204e90 <etext+0x20c>
kmonitor(struct trapframe *tf) {
ffffffffc02003e4:	ed86                	sd	ra,216(sp)
ffffffffc02003e6:	e9a2                	sd	s0,208(sp)
ffffffffc02003e8:	e5a6                	sd	s1,200(sp)
ffffffffc02003ea:	e1ca                	sd	s2,192(sp)
ffffffffc02003ec:	fd4e                	sd	s3,184(sp)
ffffffffc02003ee:	f952                	sd	s4,176(sp)
ffffffffc02003f0:	f556                	sd	s5,168(sp)
ffffffffc02003f2:	f15a                	sd	s6,160(sp)
ffffffffc02003f4:	ed5e                	sd	s7,152(sp)
ffffffffc02003f6:	e566                	sd	s9,136(sp)
ffffffffc02003f8:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fa:	ccbff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02003fe:	00005517          	auipc	a0,0x5
ffffffffc0200402:	aba50513          	addi	a0,a0,-1350 # ffffffffc0204eb8 <etext+0x234>
ffffffffc0200406:	cbfff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    if (tf != NULL) {
ffffffffc020040a:	000c0563          	beqz	s8,ffffffffc0200414 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020040e:	8562                	mv	a0,s8
ffffffffc0200410:	3dc000ef          	jal	ra,ffffffffc02007ec <print_trapframe>
ffffffffc0200414:	00005c97          	auipc	s9,0x5
ffffffffc0200418:	b14c8c93          	addi	s9,s9,-1260 # ffffffffc0204f28 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc020041c:	00005997          	auipc	s3,0x5
ffffffffc0200420:	ac498993          	addi	s3,s3,-1340 # ffffffffc0204ee0 <etext+0x25c>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200424:	00005917          	auipc	s2,0x5
ffffffffc0200428:	ac490913          	addi	s2,s2,-1340 # ffffffffc0204ee8 <etext+0x264>
        if (argc == MAXARGS - 1) {
ffffffffc020042c:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020042e:	00005b17          	auipc	s6,0x5
ffffffffc0200432:	ac2b0b13          	addi	s6,s6,-1342 # ffffffffc0204ef0 <etext+0x26c>
ffffffffc0200436:	00005a97          	auipc	s5,0x5
ffffffffc020043a:	9daa8a93          	addi	s5,s5,-1574 # ffffffffc0204e10 <etext+0x18c>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020043e:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200440:	854e                	mv	a0,s3
ffffffffc0200442:	d0bff0ef          	jal	ra,ffffffffc020014c <readline>
ffffffffc0200446:	842a                	mv	s0,a0
ffffffffc0200448:	dd65                	beqz	a0,ffffffffc0200440 <kmonitor+0x6a>
ffffffffc020044a:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc020044e:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200450:	c999                	beqz	a1,ffffffffc0200466 <kmonitor+0x90>
ffffffffc0200452:	854a                	mv	a0,s2
ffffffffc0200454:	3ec040ef          	jal	ra,ffffffffc0204840 <strchr>
ffffffffc0200458:	c925                	beqz	a0,ffffffffc02004c8 <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc020045a:	00144583          	lbu	a1,1(s0)
ffffffffc020045e:	00040023          	sb	zero,0(s0)
ffffffffc0200462:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200464:	f5fd                	bnez	a1,ffffffffc0200452 <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc0200466:	dce9                	beqz	s1,ffffffffc0200440 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200468:	6582                	ld	a1,0(sp)
ffffffffc020046a:	00005d17          	auipc	s10,0x5
ffffffffc020046e:	abed0d13          	addi	s10,s10,-1346 # ffffffffc0204f28 <commands>
ffffffffc0200472:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200474:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200476:	0d61                	addi	s10,s10,24
ffffffffc0200478:	3aa040ef          	jal	ra,ffffffffc0204822 <strcmp>
ffffffffc020047c:	c919                	beqz	a0,ffffffffc0200492 <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020047e:	2405                	addiw	s0,s0,1
ffffffffc0200480:	09740463          	beq	s0,s7,ffffffffc0200508 <kmonitor+0x132>
ffffffffc0200484:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200488:	6582                	ld	a1,0(sp)
ffffffffc020048a:	0d61                	addi	s10,s10,24
ffffffffc020048c:	396040ef          	jal	ra,ffffffffc0204822 <strcmp>
ffffffffc0200490:	f57d                	bnez	a0,ffffffffc020047e <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200492:	00141793          	slli	a5,s0,0x1
ffffffffc0200496:	97a2                	add	a5,a5,s0
ffffffffc0200498:	078e                	slli	a5,a5,0x3
ffffffffc020049a:	97e6                	add	a5,a5,s9
ffffffffc020049c:	6b9c                	ld	a5,16(a5)
ffffffffc020049e:	8662                	mv	a2,s8
ffffffffc02004a0:	002c                	addi	a1,sp,8
ffffffffc02004a2:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004a6:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc02004a8:	f8055ce3          	bgez	a0,ffffffffc0200440 <kmonitor+0x6a>
}
ffffffffc02004ac:	60ee                	ld	ra,216(sp)
ffffffffc02004ae:	644e                	ld	s0,208(sp)
ffffffffc02004b0:	64ae                	ld	s1,200(sp)
ffffffffc02004b2:	690e                	ld	s2,192(sp)
ffffffffc02004b4:	79ea                	ld	s3,184(sp)
ffffffffc02004b6:	7a4a                	ld	s4,176(sp)
ffffffffc02004b8:	7aaa                	ld	s5,168(sp)
ffffffffc02004ba:	7b0a                	ld	s6,160(sp)
ffffffffc02004bc:	6bea                	ld	s7,152(sp)
ffffffffc02004be:	6c4a                	ld	s8,144(sp)
ffffffffc02004c0:	6caa                	ld	s9,136(sp)
ffffffffc02004c2:	6d0a                	ld	s10,128(sp)
ffffffffc02004c4:	612d                	addi	sp,sp,224
ffffffffc02004c6:	8082                	ret
        if (*buf == '\0') {
ffffffffc02004c8:	00044783          	lbu	a5,0(s0)
ffffffffc02004cc:	dfc9                	beqz	a5,ffffffffc0200466 <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc02004ce:	03448863          	beq	s1,s4,ffffffffc02004fe <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc02004d2:	00349793          	slli	a5,s1,0x3
ffffffffc02004d6:	0118                	addi	a4,sp,128
ffffffffc02004d8:	97ba                	add	a5,a5,a4
ffffffffc02004da:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004de:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02004e2:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e4:	e591                	bnez	a1,ffffffffc02004f0 <kmonitor+0x11a>
ffffffffc02004e6:	b749                	j	ffffffffc0200468 <kmonitor+0x92>
ffffffffc02004e8:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02004ec:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004ee:	ddad                	beqz	a1,ffffffffc0200468 <kmonitor+0x92>
ffffffffc02004f0:	854a                	mv	a0,s2
ffffffffc02004f2:	34e040ef          	jal	ra,ffffffffc0204840 <strchr>
ffffffffc02004f6:	d96d                	beqz	a0,ffffffffc02004e8 <kmonitor+0x112>
ffffffffc02004f8:	00044583          	lbu	a1,0(s0)
ffffffffc02004fc:	bf91                	j	ffffffffc0200450 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02004fe:	45c1                	li	a1,16
ffffffffc0200500:	855a                	mv	a0,s6
ffffffffc0200502:	bc3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0200506:	b7f1                	j	ffffffffc02004d2 <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc0200508:	6582                	ld	a1,0(sp)
ffffffffc020050a:	00005517          	auipc	a0,0x5
ffffffffc020050e:	a0650513          	addi	a0,a0,-1530 # ffffffffc0204f10 <etext+0x28c>
ffffffffc0200512:	bb3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    return 0;
ffffffffc0200516:	b72d                	j	ffffffffc0200440 <kmonitor+0x6a>

ffffffffc0200518 <ide_init>:
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <riscv.h>

void ide_init(void) {}
ffffffffc0200518:	8082                	ret

ffffffffc020051a <ide_device_valid>:

#define MAX_IDE 2
#define MAX_DISK_NSECS 56
static char ide[MAX_DISK_NSECS * SECTSIZE];

bool ide_device_valid(unsigned short ideno) { return ideno < MAX_IDE; }
ffffffffc020051a:	00253513          	sltiu	a0,a0,2
ffffffffc020051e:	8082                	ret

ffffffffc0200520 <ide_device_size>:

size_t ide_device_size(unsigned short ideno) { return MAX_DISK_NSECS; }
ffffffffc0200520:	03800513          	li	a0,56
ffffffffc0200524:	8082                	ret

ffffffffc0200526 <ide_read_secs>:

int ide_read_secs(unsigned short ideno, uint32_t secno, void *dst,
                  size_t nsecs) {
    int iobase = secno * SECTSIZE;
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200526:	00048797          	auipc	a5,0x48
ffffffffc020052a:	f1278793          	addi	a5,a5,-238 # ffffffffc0248438 <ide>
    int iobase = secno * SECTSIZE;
ffffffffc020052e:	0095959b          	slliw	a1,a1,0x9
                  size_t nsecs) {
ffffffffc0200532:	1141                	addi	sp,sp,-16
ffffffffc0200534:	8532                	mv	a0,a2
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200536:	95be                	add	a1,a1,a5
ffffffffc0200538:	00969613          	slli	a2,a3,0x9
                  size_t nsecs) {
ffffffffc020053c:	e406                	sd	ra,8(sp)
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020053e:	32a040ef          	jal	ra,ffffffffc0204868 <memcpy>
    return 0;
}
ffffffffc0200542:	60a2                	ld	ra,8(sp)
ffffffffc0200544:	4501                	li	a0,0
ffffffffc0200546:	0141                	addi	sp,sp,16
ffffffffc0200548:	8082                	ret

ffffffffc020054a <ide_write_secs>:

int ide_write_secs(unsigned short ideno, uint32_t secno, const void *src,
                   size_t nsecs) {
    int iobase = secno * SECTSIZE;
ffffffffc020054a:	0095979b          	slliw	a5,a1,0x9
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020054e:	00048517          	auipc	a0,0x48
ffffffffc0200552:	eea50513          	addi	a0,a0,-278 # ffffffffc0248438 <ide>
                   size_t nsecs) {
ffffffffc0200556:	1141                	addi	sp,sp,-16
ffffffffc0200558:	85b2                	mv	a1,a2
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020055a:	953e                	add	a0,a0,a5
ffffffffc020055c:	00969613          	slli	a2,a3,0x9
                   size_t nsecs) {
ffffffffc0200560:	e406                	sd	ra,8(sp)
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200562:	306040ef          	jal	ra,ffffffffc0204868 <memcpy>
    return 0;
}
ffffffffc0200566:	60a2                	ld	ra,8(sp)
ffffffffc0200568:	4501                	li	a0,0
ffffffffc020056a:	0141                	addi	sp,sp,16
ffffffffc020056c:	8082                	ret

ffffffffc020056e <clock_set_next_event>:
volatile size_t ticks;

static inline uint64_t get_cycles(void) {
#if __riscv_xlen == 64
    uint64_t n;
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020056e:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200572:	67e1                	lui	a5,0x18
ffffffffc0200574:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_ex3_out_size+0xd9a0>
ffffffffc0200578:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020057a:	4581                	li	a1,0
ffffffffc020057c:	4601                	li	a2,0
ffffffffc020057e:	4881                	li	a7,0
ffffffffc0200580:	00000073          	ecall
ffffffffc0200584:	8082                	ret

ffffffffc0200586 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200586:	8082                	ret

ffffffffc0200588 <cons_putc>:
#include <riscv.h>
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200588:	100027f3          	csrr	a5,sstatus
ffffffffc020058c:	8b89                	andi	a5,a5,2
ffffffffc020058e:	0ff57513          	andi	a0,a0,255
ffffffffc0200592:	e799                	bnez	a5,ffffffffc02005a0 <cons_putc+0x18>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4885                	li	a7,1
ffffffffc020059a:	00000073          	ecall
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
ffffffffc020059e:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005a6:	058000ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc02005aa:	6522                	ld	a0,8(sp)
ffffffffc02005ac:	4581                	li	a1,0
ffffffffc02005ae:	4601                	li	a2,0
ffffffffc02005b0:	4885                	li	a7,1
ffffffffc02005b2:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005b6:	60e2                	ld	ra,24(sp)
ffffffffc02005b8:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02005ba:	a83d                	j	ffffffffc02005f8 <intr_enable>

ffffffffc02005bc <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	eb89                	bnez	a5,ffffffffc02005d4 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005c4:	4501                	li	a0,0
ffffffffc02005c6:	4581                	li	a1,0
ffffffffc02005c8:	4601                	li	a2,0
ffffffffc02005ca:	4889                	li	a7,2
ffffffffc02005cc:	00000073          	ecall
ffffffffc02005d0:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d2:	8082                	ret
int cons_getc(void) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005d8:	026000ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc02005dc:	4501                	li	a0,0
ffffffffc02005de:	4581                	li	a1,0
ffffffffc02005e0:	4601                	li	a2,0
ffffffffc02005e2:	4889                	li	a7,2
ffffffffc02005e4:	00000073          	ecall
ffffffffc02005e8:	2501                	sext.w	a0,a0
ffffffffc02005ea:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005ec:	00c000ef          	jal	ra,ffffffffc02005f8 <intr_enable>
}
ffffffffc02005f0:	60e2                	ld	ra,24(sp)
ffffffffc02005f2:	6522                	ld	a0,8(sp)
ffffffffc02005f4:	6105                	addi	sp,sp,32
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02005f8:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02005fe:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200602:	8082                	ret

ffffffffc0200604 <idt_init>:
void
idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200604:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200608:	00000797          	auipc	a5,0x0
ffffffffc020060c:	62c78793          	addi	a5,a5,1580 # ffffffffc0200c34 <__alltraps>
ffffffffc0200610:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc0200614:	000407b7          	lui	a5,0x40
ffffffffc0200618:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc020061c:	8082                	ret

ffffffffc020061e <print_regs>:
    cprintf("  tval 0x%08x\n", tf->tval);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020061e:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc0200620:	1141                	addi	sp,sp,-16
ffffffffc0200622:	e022                	sd	s0,0(sp)
ffffffffc0200624:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200626:	00005517          	auipc	a0,0x5
ffffffffc020062a:	94a50513          	addi	a0,a0,-1718 # ffffffffc0204f70 <commands+0x48>
void print_regs(struct pushregs* gpr) {
ffffffffc020062e:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200630:	a95ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200634:	640c                	ld	a1,8(s0)
ffffffffc0200636:	00005517          	auipc	a0,0x5
ffffffffc020063a:	95250513          	addi	a0,a0,-1710 # ffffffffc0204f88 <commands+0x60>
ffffffffc020063e:	a87ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200642:	680c                	ld	a1,16(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	95c50513          	addi	a0,a0,-1700 # ffffffffc0204fa0 <commands+0x78>
ffffffffc020064c:	a79ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200650:	6c0c                	ld	a1,24(s0)
ffffffffc0200652:	00005517          	auipc	a0,0x5
ffffffffc0200656:	96650513          	addi	a0,a0,-1690 # ffffffffc0204fb8 <commands+0x90>
ffffffffc020065a:	a6bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc020065e:	700c                	ld	a1,32(s0)
ffffffffc0200660:	00005517          	auipc	a0,0x5
ffffffffc0200664:	97050513          	addi	a0,a0,-1680 # ffffffffc0204fd0 <commands+0xa8>
ffffffffc0200668:	a5dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc020066c:	740c                	ld	a1,40(s0)
ffffffffc020066e:	00005517          	auipc	a0,0x5
ffffffffc0200672:	97a50513          	addi	a0,a0,-1670 # ffffffffc0204fe8 <commands+0xc0>
ffffffffc0200676:	a4fff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc020067a:	780c                	ld	a1,48(s0)
ffffffffc020067c:	00005517          	auipc	a0,0x5
ffffffffc0200680:	98450513          	addi	a0,a0,-1660 # ffffffffc0205000 <commands+0xd8>
ffffffffc0200684:	a41ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200688:	7c0c                	ld	a1,56(s0)
ffffffffc020068a:	00005517          	auipc	a0,0x5
ffffffffc020068e:	98e50513          	addi	a0,a0,-1650 # ffffffffc0205018 <commands+0xf0>
ffffffffc0200692:	a33ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200696:	602c                	ld	a1,64(s0)
ffffffffc0200698:	00005517          	auipc	a0,0x5
ffffffffc020069c:	99850513          	addi	a0,a0,-1640 # ffffffffc0205030 <commands+0x108>
ffffffffc02006a0:	a25ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02006a4:	642c                	ld	a1,72(s0)
ffffffffc02006a6:	00005517          	auipc	a0,0x5
ffffffffc02006aa:	9a250513          	addi	a0,a0,-1630 # ffffffffc0205048 <commands+0x120>
ffffffffc02006ae:	a17ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02006b2:	682c                	ld	a1,80(s0)
ffffffffc02006b4:	00005517          	auipc	a0,0x5
ffffffffc02006b8:	9ac50513          	addi	a0,a0,-1620 # ffffffffc0205060 <commands+0x138>
ffffffffc02006bc:	a09ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02006c0:	6c2c                	ld	a1,88(s0)
ffffffffc02006c2:	00005517          	auipc	a0,0x5
ffffffffc02006c6:	9b650513          	addi	a0,a0,-1610 # ffffffffc0205078 <commands+0x150>
ffffffffc02006ca:	9fbff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc02006ce:	702c                	ld	a1,96(s0)
ffffffffc02006d0:	00005517          	auipc	a0,0x5
ffffffffc02006d4:	9c050513          	addi	a0,a0,-1600 # ffffffffc0205090 <commands+0x168>
ffffffffc02006d8:	9edff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc02006dc:	742c                	ld	a1,104(s0)
ffffffffc02006de:	00005517          	auipc	a0,0x5
ffffffffc02006e2:	9ca50513          	addi	a0,a0,-1590 # ffffffffc02050a8 <commands+0x180>
ffffffffc02006e6:	9dfff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc02006ea:	782c                	ld	a1,112(s0)
ffffffffc02006ec:	00005517          	auipc	a0,0x5
ffffffffc02006f0:	9d450513          	addi	a0,a0,-1580 # ffffffffc02050c0 <commands+0x198>
ffffffffc02006f4:	9d1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc02006f8:	7c2c                	ld	a1,120(s0)
ffffffffc02006fa:	00005517          	auipc	a0,0x5
ffffffffc02006fe:	9de50513          	addi	a0,a0,-1570 # ffffffffc02050d8 <commands+0x1b0>
ffffffffc0200702:	9c3ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200706:	604c                	ld	a1,128(s0)
ffffffffc0200708:	00005517          	auipc	a0,0x5
ffffffffc020070c:	9e850513          	addi	a0,a0,-1560 # ffffffffc02050f0 <commands+0x1c8>
ffffffffc0200710:	9b5ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200714:	644c                	ld	a1,136(s0)
ffffffffc0200716:	00005517          	auipc	a0,0x5
ffffffffc020071a:	9f250513          	addi	a0,a0,-1550 # ffffffffc0205108 <commands+0x1e0>
ffffffffc020071e:	9a7ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200722:	684c                	ld	a1,144(s0)
ffffffffc0200724:	00005517          	auipc	a0,0x5
ffffffffc0200728:	9fc50513          	addi	a0,a0,-1540 # ffffffffc0205120 <commands+0x1f8>
ffffffffc020072c:	999ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200730:	6c4c                	ld	a1,152(s0)
ffffffffc0200732:	00005517          	auipc	a0,0x5
ffffffffc0200736:	a0650513          	addi	a0,a0,-1530 # ffffffffc0205138 <commands+0x210>
ffffffffc020073a:	98bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc020073e:	704c                	ld	a1,160(s0)
ffffffffc0200740:	00005517          	auipc	a0,0x5
ffffffffc0200744:	a1050513          	addi	a0,a0,-1520 # ffffffffc0205150 <commands+0x228>
ffffffffc0200748:	97dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc020074c:	744c                	ld	a1,168(s0)
ffffffffc020074e:	00005517          	auipc	a0,0x5
ffffffffc0200752:	a1a50513          	addi	a0,a0,-1510 # ffffffffc0205168 <commands+0x240>
ffffffffc0200756:	96fff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020075a:	784c                	ld	a1,176(s0)
ffffffffc020075c:	00005517          	auipc	a0,0x5
ffffffffc0200760:	a2450513          	addi	a0,a0,-1500 # ffffffffc0205180 <commands+0x258>
ffffffffc0200764:	961ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200768:	7c4c                	ld	a1,184(s0)
ffffffffc020076a:	00005517          	auipc	a0,0x5
ffffffffc020076e:	a2e50513          	addi	a0,a0,-1490 # ffffffffc0205198 <commands+0x270>
ffffffffc0200772:	953ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200776:	606c                	ld	a1,192(s0)
ffffffffc0200778:	00005517          	auipc	a0,0x5
ffffffffc020077c:	a3850513          	addi	a0,a0,-1480 # ffffffffc02051b0 <commands+0x288>
ffffffffc0200780:	945ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200784:	646c                	ld	a1,200(s0)
ffffffffc0200786:	00005517          	auipc	a0,0x5
ffffffffc020078a:	a4250513          	addi	a0,a0,-1470 # ffffffffc02051c8 <commands+0x2a0>
ffffffffc020078e:	937ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200792:	686c                	ld	a1,208(s0)
ffffffffc0200794:	00005517          	auipc	a0,0x5
ffffffffc0200798:	a4c50513          	addi	a0,a0,-1460 # ffffffffc02051e0 <commands+0x2b8>
ffffffffc020079c:	929ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02007a0:	6c6c                	ld	a1,216(s0)
ffffffffc02007a2:	00005517          	auipc	a0,0x5
ffffffffc02007a6:	a5650513          	addi	a0,a0,-1450 # ffffffffc02051f8 <commands+0x2d0>
ffffffffc02007aa:	91bff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02007ae:	706c                	ld	a1,224(s0)
ffffffffc02007b0:	00005517          	auipc	a0,0x5
ffffffffc02007b4:	a6050513          	addi	a0,a0,-1440 # ffffffffc0205210 <commands+0x2e8>
ffffffffc02007b8:	90dff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02007bc:	746c                	ld	a1,232(s0)
ffffffffc02007be:	00005517          	auipc	a0,0x5
ffffffffc02007c2:	a6a50513          	addi	a0,a0,-1430 # ffffffffc0205228 <commands+0x300>
ffffffffc02007c6:	8ffff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02007ca:	786c                	ld	a1,240(s0)
ffffffffc02007cc:	00005517          	auipc	a0,0x5
ffffffffc02007d0:	a7450513          	addi	a0,a0,-1420 # ffffffffc0205240 <commands+0x318>
ffffffffc02007d4:	8f1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007d8:	7c6c                	ld	a1,248(s0)
}
ffffffffc02007da:	6402                	ld	s0,0(sp)
ffffffffc02007dc:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007de:	00005517          	auipc	a0,0x5
ffffffffc02007e2:	a7a50513          	addi	a0,a0,-1414 # ffffffffc0205258 <commands+0x330>
}
ffffffffc02007e6:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc02007e8:	8ddff06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc02007ec <print_trapframe>:
print_trapframe(struct trapframe *tf) {
ffffffffc02007ec:	1141                	addi	sp,sp,-16
ffffffffc02007ee:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc02007f0:	85aa                	mv	a1,a0
print_trapframe(struct trapframe *tf) {
ffffffffc02007f2:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc02007f4:	00005517          	auipc	a0,0x5
ffffffffc02007f8:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0205270 <commands+0x348>
print_trapframe(struct trapframe *tf) {
ffffffffc02007fc:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc02007fe:	8c7ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200802:	8522                	mv	a0,s0
ffffffffc0200804:	e1bff0ef          	jal	ra,ffffffffc020061e <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200808:	10043583          	ld	a1,256(s0)
ffffffffc020080c:	00005517          	auipc	a0,0x5
ffffffffc0200810:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0205288 <commands+0x360>
ffffffffc0200814:	8b1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200818:	10843583          	ld	a1,264(s0)
ffffffffc020081c:	00005517          	auipc	a0,0x5
ffffffffc0200820:	a8450513          	addi	a0,a0,-1404 # ffffffffc02052a0 <commands+0x378>
ffffffffc0200824:	8a1ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200828:	11043583          	ld	a1,272(s0)
ffffffffc020082c:	00005517          	auipc	a0,0x5
ffffffffc0200830:	a8c50513          	addi	a0,a0,-1396 # ffffffffc02052b8 <commands+0x390>
ffffffffc0200834:	891ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200838:	11843583          	ld	a1,280(s0)
}
ffffffffc020083c:	6402                	ld	s0,0(sp)
ffffffffc020083e:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200840:	00005517          	auipc	a0,0x5
ffffffffc0200844:	a8850513          	addi	a0,a0,-1400 # ffffffffc02052c8 <commands+0x3a0>
}
ffffffffc0200848:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020084a:	87bff06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc020084e <pgfault_handler>:
            trap_in_kernel(tf) ? 'K' : 'U',
            tf->cause == CAUSE_STORE_PAGE_FAULT ? 'W' : 'R');
}

static int
pgfault_handler(struct trapframe *tf) {
ffffffffc020084e:	1101                	addi	sp,sp,-32
ffffffffc0200850:	e426                	sd	s1,8(sp)
    extern struct mm_struct *check_mm_struct;
    if(check_mm_struct !=NULL) { 
ffffffffc0200852:	00053497          	auipc	s1,0x53
ffffffffc0200856:	cb648493          	addi	s1,s1,-842 # ffffffffc0253508 <check_mm_struct>
ffffffffc020085a:	609c                	ld	a5,0(s1)
pgfault_handler(struct trapframe *tf) {
ffffffffc020085c:	e822                	sd	s0,16(sp)
ffffffffc020085e:	ec06                	sd	ra,24(sp)
ffffffffc0200860:	842a                	mv	s0,a0
    if(check_mm_struct !=NULL) { 
ffffffffc0200862:	cbad                	beqz	a5,ffffffffc02008d4 <pgfault_handler+0x86>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200864:	10053783          	ld	a5,256(a0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200868:	11053583          	ld	a1,272(a0)
ffffffffc020086c:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200870:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200874:	c7b1                	beqz	a5,ffffffffc02008c0 <pgfault_handler+0x72>
ffffffffc0200876:	11843703          	ld	a4,280(s0)
ffffffffc020087a:	47bd                	li	a5,15
ffffffffc020087c:	05700693          	li	a3,87
ffffffffc0200880:	00f70463          	beq	a4,a5,ffffffffc0200888 <pgfault_handler+0x3a>
ffffffffc0200884:	05200693          	li	a3,82
ffffffffc0200888:	00005517          	auipc	a0,0x5
ffffffffc020088c:	a5850513          	addi	a0,a0,-1448 # ffffffffc02052e0 <commands+0x3b8>
ffffffffc0200890:	835ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            print_pgfault(tf);
        }
    struct mm_struct *mm;
    if (check_mm_struct != NULL) {
ffffffffc0200894:	6088                	ld	a0,0(s1)
ffffffffc0200896:	cd1d                	beqz	a0,ffffffffc02008d4 <pgfault_handler+0x86>
        assert(current == idleproc);
ffffffffc0200898:	00053717          	auipc	a4,0x53
ffffffffc020089c:	c0873703          	ld	a4,-1016(a4) # ffffffffc02534a0 <current>
ffffffffc02008a0:	00053797          	auipc	a5,0x53
ffffffffc02008a4:	c087b783          	ld	a5,-1016(a5) # ffffffffc02534a8 <idleproc>
ffffffffc02008a8:	04f71663          	bne	a4,a5,ffffffffc02008f4 <pgfault_handler+0xa6>
            print_pgfault(tf);
            panic("unhandled page fault.\n");
        }
        mm = current->mm;
    }
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008ac:	11043603          	ld	a2,272(s0)
ffffffffc02008b0:	11843583          	ld	a1,280(s0)
}
ffffffffc02008b4:	6442                	ld	s0,16(sp)
ffffffffc02008b6:	60e2                	ld	ra,24(sp)
ffffffffc02008b8:	64a2                	ld	s1,8(sp)
ffffffffc02008ba:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008bc:	5aa0106f          	j	ffffffffc0201e66 <do_pgfault>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008c0:	11843703          	ld	a4,280(s0)
ffffffffc02008c4:	47bd                	li	a5,15
ffffffffc02008c6:	05500613          	li	a2,85
ffffffffc02008ca:	05700693          	li	a3,87
ffffffffc02008ce:	faf71be3          	bne	a4,a5,ffffffffc0200884 <pgfault_handler+0x36>
ffffffffc02008d2:	bf5d                	j	ffffffffc0200888 <pgfault_handler+0x3a>
        if (current == NULL) {
ffffffffc02008d4:	00053797          	auipc	a5,0x53
ffffffffc02008d8:	bcc7b783          	ld	a5,-1076(a5) # ffffffffc02534a0 <current>
ffffffffc02008dc:	cf85                	beqz	a5,ffffffffc0200914 <pgfault_handler+0xc6>
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008de:	11043603          	ld	a2,272(s0)
ffffffffc02008e2:	11843583          	ld	a1,280(s0)
}
ffffffffc02008e6:	6442                	ld	s0,16(sp)
ffffffffc02008e8:	60e2                	ld	ra,24(sp)
ffffffffc02008ea:	64a2                	ld	s1,8(sp)
        mm = current->mm;
ffffffffc02008ec:	7788                	ld	a0,40(a5)
}
ffffffffc02008ee:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008f0:	5760106f          	j	ffffffffc0201e66 <do_pgfault>
        assert(current == idleproc);
ffffffffc02008f4:	00005697          	auipc	a3,0x5
ffffffffc02008f8:	a0c68693          	addi	a3,a3,-1524 # ffffffffc0205300 <commands+0x3d8>
ffffffffc02008fc:	00005617          	auipc	a2,0x5
ffffffffc0200900:	a1c60613          	addi	a2,a2,-1508 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0200904:	06800593          	li	a1,104
ffffffffc0200908:	00005517          	auipc	a0,0x5
ffffffffc020090c:	a2850513          	addi	a0,a0,-1496 # ffffffffc0205330 <commands+0x408>
ffffffffc0200910:	8f1ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            print_trapframe(tf);
ffffffffc0200914:	8522                	mv	a0,s0
ffffffffc0200916:	ed7ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020091a:	10043783          	ld	a5,256(s0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020091e:	11043583          	ld	a1,272(s0)
ffffffffc0200922:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200926:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020092a:	e399                	bnez	a5,ffffffffc0200930 <pgfault_handler+0xe2>
ffffffffc020092c:	05500613          	li	a2,85
ffffffffc0200930:	11843703          	ld	a4,280(s0)
ffffffffc0200934:	47bd                	li	a5,15
ffffffffc0200936:	02f70663          	beq	a4,a5,ffffffffc0200962 <pgfault_handler+0x114>
ffffffffc020093a:	05200693          	li	a3,82
ffffffffc020093e:	00005517          	auipc	a0,0x5
ffffffffc0200942:	9a250513          	addi	a0,a0,-1630 # ffffffffc02052e0 <commands+0x3b8>
ffffffffc0200946:	f7eff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            panic("unhandled page fault.\n");
ffffffffc020094a:	00005617          	auipc	a2,0x5
ffffffffc020094e:	9fe60613          	addi	a2,a2,-1538 # ffffffffc0205348 <commands+0x420>
ffffffffc0200952:	06f00593          	li	a1,111
ffffffffc0200956:	00005517          	auipc	a0,0x5
ffffffffc020095a:	9da50513          	addi	a0,a0,-1574 # ffffffffc0205330 <commands+0x408>
ffffffffc020095e:	8a3ff0ef          	jal	ra,ffffffffc0200200 <__panic>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200962:	05700693          	li	a3,87
ffffffffc0200966:	bfe1                	j	ffffffffc020093e <pgfault_handler+0xf0>

ffffffffc0200968 <interrupt_handler>:

static volatile int in_swap_tick_event = 0;
extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200968:	11853783          	ld	a5,280(a0)
ffffffffc020096c:	472d                	li	a4,11
ffffffffc020096e:	0786                	slli	a5,a5,0x1
ffffffffc0200970:	8385                	srli	a5,a5,0x1
ffffffffc0200972:	06f76d63          	bltu	a4,a5,ffffffffc02009ec <interrupt_handler+0x84>
ffffffffc0200976:	00005717          	auipc	a4,0x5
ffffffffc020097a:	a8a70713          	addi	a4,a4,-1398 # ffffffffc0205400 <commands+0x4d8>
ffffffffc020097e:	078a                	slli	a5,a5,0x2
ffffffffc0200980:	97ba                	add	a5,a5,a4
ffffffffc0200982:	439c                	lw	a5,0(a5)
ffffffffc0200984:	97ba                	add	a5,a5,a4
ffffffffc0200986:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc0200988:	00005517          	auipc	a0,0x5
ffffffffc020098c:	a3850513          	addi	a0,a0,-1480 # ffffffffc02053c0 <commands+0x498>
ffffffffc0200990:	f34ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc0200994:	00005517          	auipc	a0,0x5
ffffffffc0200998:	a0c50513          	addi	a0,a0,-1524 # ffffffffc02053a0 <commands+0x478>
ffffffffc020099c:	f28ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02009a0:	00005517          	auipc	a0,0x5
ffffffffc02009a4:	9c050513          	addi	a0,a0,-1600 # ffffffffc0205360 <commands+0x438>
ffffffffc02009a8:	f1cff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc02009ac:	00005517          	auipc	a0,0x5
ffffffffc02009b0:	9d450513          	addi	a0,a0,-1580 # ffffffffc0205380 <commands+0x458>
ffffffffc02009b4:	f10ff06f          	j	ffffffffc02000c4 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc02009b8:	1141                	addi	sp,sp,-16
ffffffffc02009ba:	e406                	sd	ra,8(sp)
            break;
        case IRQ_U_TIMER:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_TIMER:
            clock_set_next_event();
ffffffffc02009bc:	bb3ff0ef          	jal	ra,ffffffffc020056e <clock_set_next_event>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009c0:	00053717          	auipc	a4,0x53
ffffffffc02009c4:	b1070713          	addi	a4,a4,-1264 # ffffffffc02534d0 <ticks>
ffffffffc02009c8:	631c                	ld	a5,0(a4)
                //print_ticks()
            }
            if (current){
ffffffffc02009ca:	00053517          	auipc	a0,0x53
ffffffffc02009ce:	ad653503          	ld	a0,-1322(a0) # ffffffffc02534a0 <current>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009d2:	0785                	addi	a5,a5,1
ffffffffc02009d4:	e31c                	sd	a5,0(a4)
            if (current){
ffffffffc02009d6:	cd01                	beqz	a0,ffffffffc02009ee <interrupt_handler+0x86>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc02009d8:	60a2                	ld	ra,8(sp)
ffffffffc02009da:	0141                	addi	sp,sp,16
                sched_class_proc_tick(current); 
ffffffffc02009dc:	23b0306f          	j	ffffffffc0204416 <sched_class_proc_tick>
            cprintf("Supervisor external interrupt\n");
ffffffffc02009e0:	00005517          	auipc	a0,0x5
ffffffffc02009e4:	a0050513          	addi	a0,a0,-1536 # ffffffffc02053e0 <commands+0x4b8>
ffffffffc02009e8:	edcff06f          	j	ffffffffc02000c4 <cprintf>
            print_trapframe(tf);
ffffffffc02009ec:	b501                	j	ffffffffc02007ec <print_trapframe>
}
ffffffffc02009ee:	60a2                	ld	ra,8(sp)
ffffffffc02009f0:	0141                	addi	sp,sp,16
ffffffffc02009f2:	8082                	ret

ffffffffc02009f4 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    int ret;
    switch (tf->cause) {
ffffffffc02009f4:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc02009f8:	1101                	addi	sp,sp,-32
ffffffffc02009fa:	e822                	sd	s0,16(sp)
ffffffffc02009fc:	ec06                	sd	ra,24(sp)
ffffffffc02009fe:	e426                	sd	s1,8(sp)
ffffffffc0200a00:	473d                	li	a4,15
ffffffffc0200a02:	842a                	mv	s0,a0
ffffffffc0200a04:	16f76163          	bltu	a4,a5,ffffffffc0200b66 <exception_handler+0x172>
ffffffffc0200a08:	00005717          	auipc	a4,0x5
ffffffffc0200a0c:	bc070713          	addi	a4,a4,-1088 # ffffffffc02055c8 <commands+0x6a0>
ffffffffc0200a10:	078a                	slli	a5,a5,0x2
ffffffffc0200a12:	97ba                	add	a5,a5,a4
ffffffffc0200a14:	439c                	lw	a5,0(a5)
ffffffffc0200a16:	97ba                	add	a5,a5,a4
ffffffffc0200a18:	8782                	jr	a5
            //cprintf("Environment call from U-mode\n");
            tf->epc += 4;
            syscall();
            break;
        case CAUSE_SUPERVISOR_ECALL:
            cprintf("Environment call from S-mode\n");
ffffffffc0200a1a:	00005517          	auipc	a0,0x5
ffffffffc0200a1e:	b0650513          	addi	a0,a0,-1274 # ffffffffc0205520 <commands+0x5f8>
ffffffffc0200a22:	ea2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            tf->epc += 4;
ffffffffc0200a26:	10843783          	ld	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a2a:	60e2                	ld	ra,24(sp)
ffffffffc0200a2c:	64a2                	ld	s1,8(sp)
            tf->epc += 4;
ffffffffc0200a2e:	0791                	addi	a5,a5,4
ffffffffc0200a30:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200a34:	6442                	ld	s0,16(sp)
ffffffffc0200a36:	6105                	addi	sp,sp,32
            syscall();
ffffffffc0200a38:	5330306f          	j	ffffffffc020476a <syscall>
            cprintf("Environment call from H-mode\n");
ffffffffc0200a3c:	00005517          	auipc	a0,0x5
ffffffffc0200a40:	b0450513          	addi	a0,a0,-1276 # ffffffffc0205540 <commands+0x618>
}
ffffffffc0200a44:	6442                	ld	s0,16(sp)
ffffffffc0200a46:	60e2                	ld	ra,24(sp)
ffffffffc0200a48:	64a2                	ld	s1,8(sp)
ffffffffc0200a4a:	6105                	addi	sp,sp,32
            cprintf("Instruction access fault\n");
ffffffffc0200a4c:	e78ff06f          	j	ffffffffc02000c4 <cprintf>
            cprintf("Environment call from M-mode\n");
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	b1050513          	addi	a0,a0,-1264 # ffffffffc0205560 <commands+0x638>
ffffffffc0200a58:	b7f5                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Instruction page fault\n");
ffffffffc0200a5a:	00005517          	auipc	a0,0x5
ffffffffc0200a5e:	b2650513          	addi	a0,a0,-1242 # ffffffffc0205580 <commands+0x658>
ffffffffc0200a62:	b7cd                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Load page fault\n");
ffffffffc0200a64:	00005517          	auipc	a0,0x5
ffffffffc0200a68:	b3450513          	addi	a0,a0,-1228 # ffffffffc0205598 <commands+0x670>
ffffffffc0200a6c:	e58ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200a70:	8522                	mv	a0,s0
ffffffffc0200a72:	dddff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200a76:	84aa                	mv	s1,a0
ffffffffc0200a78:	10051963          	bnez	a0,ffffffffc0200b8a <exception_handler+0x196>
}
ffffffffc0200a7c:	60e2                	ld	ra,24(sp)
ffffffffc0200a7e:	6442                	ld	s0,16(sp)
ffffffffc0200a80:	64a2                	ld	s1,8(sp)
ffffffffc0200a82:	6105                	addi	sp,sp,32
ffffffffc0200a84:	8082                	ret
            cprintf("Store/AMO page fault\n");
ffffffffc0200a86:	00005517          	auipc	a0,0x5
ffffffffc0200a8a:	b2a50513          	addi	a0,a0,-1238 # ffffffffc02055b0 <commands+0x688>
ffffffffc0200a8e:	e36ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200a92:	8522                	mv	a0,s0
ffffffffc0200a94:	dbbff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200a98:	84aa                	mv	s1,a0
ffffffffc0200a9a:	d16d                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200a9c:	8522                	mv	a0,s0
ffffffffc0200a9e:	d4fff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200aa2:	86a6                	mv	a3,s1
ffffffffc0200aa4:	00005617          	auipc	a2,0x5
ffffffffc0200aa8:	a2c60613          	addi	a2,a2,-1492 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200aac:	0f100593          	li	a1,241
ffffffffc0200ab0:	00005517          	auipc	a0,0x5
ffffffffc0200ab4:	88050513          	addi	a0,a0,-1920 # ffffffffc0205330 <commands+0x408>
ffffffffc0200ab8:	f48ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            cprintf("Instruction address misaligned\n");
ffffffffc0200abc:	00005517          	auipc	a0,0x5
ffffffffc0200ac0:	97450513          	addi	a0,a0,-1676 # ffffffffc0205430 <commands+0x508>
ffffffffc0200ac4:	b741                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Instruction access fault\n");
ffffffffc0200ac6:	00005517          	auipc	a0,0x5
ffffffffc0200aca:	98a50513          	addi	a0,a0,-1654 # ffffffffc0205450 <commands+0x528>
ffffffffc0200ace:	bf9d                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Illegal instruction\n");
ffffffffc0200ad0:	00005517          	auipc	a0,0x5
ffffffffc0200ad4:	9a050513          	addi	a0,a0,-1632 # ffffffffc0205470 <commands+0x548>
ffffffffc0200ad8:	b7b5                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Breakpoint\n");
ffffffffc0200ada:	00005517          	auipc	a0,0x5
ffffffffc0200ade:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0205488 <commands+0x560>
ffffffffc0200ae2:	de2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if(tf->gpr.a7 == 10){
ffffffffc0200ae6:	6458                	ld	a4,136(s0)
ffffffffc0200ae8:	47a9                	li	a5,10
ffffffffc0200aea:	f8f719e3          	bne	a4,a5,ffffffffc0200a7c <exception_handler+0x88>
ffffffffc0200aee:	bf25                	j	ffffffffc0200a26 <exception_handler+0x32>
            cprintf("Load address misaligned\n");
ffffffffc0200af0:	00005517          	auipc	a0,0x5
ffffffffc0200af4:	9a850513          	addi	a0,a0,-1624 # ffffffffc0205498 <commands+0x570>
ffffffffc0200af8:	b7b1                	j	ffffffffc0200a44 <exception_handler+0x50>
            cprintf("Load access fault\n");
ffffffffc0200afa:	00005517          	auipc	a0,0x5
ffffffffc0200afe:	9be50513          	addi	a0,a0,-1602 # ffffffffc02054b8 <commands+0x590>
ffffffffc0200b02:	dc2ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b06:	8522                	mv	a0,s0
ffffffffc0200b08:	d47ff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200b0c:	84aa                	mv	s1,a0
ffffffffc0200b0e:	d53d                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b10:	8522                	mv	a0,s0
ffffffffc0200b12:	cdbff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b16:	86a6                	mv	a3,s1
ffffffffc0200b18:	00005617          	auipc	a2,0x5
ffffffffc0200b1c:	9b860613          	addi	a2,a2,-1608 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b20:	0c600593          	li	a1,198
ffffffffc0200b24:	00005517          	auipc	a0,0x5
ffffffffc0200b28:	80c50513          	addi	a0,a0,-2036 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b2c:	ed4ff0ef          	jal	ra,ffffffffc0200200 <__panic>
            cprintf("Store/AMO access fault\n");
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	9d850513          	addi	a0,a0,-1576 # ffffffffc0205508 <commands+0x5e0>
ffffffffc0200b38:	d8cff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b3c:	8522                	mv	a0,s0
ffffffffc0200b3e:	d11ff0ef          	jal	ra,ffffffffc020084e <pgfault_handler>
ffffffffc0200b42:	84aa                	mv	s1,a0
ffffffffc0200b44:	dd05                	beqz	a0,ffffffffc0200a7c <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b46:	8522                	mv	a0,s0
ffffffffc0200b48:	ca5ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b4c:	86a6                	mv	a3,s1
ffffffffc0200b4e:	00005617          	auipc	a2,0x5
ffffffffc0200b52:	98260613          	addi	a2,a2,-1662 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b56:	0d000593          	li	a1,208
ffffffffc0200b5a:	00004517          	auipc	a0,0x4
ffffffffc0200b5e:	7d650513          	addi	a0,a0,2006 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b62:	e9eff0ef          	jal	ra,ffffffffc0200200 <__panic>
            print_trapframe(tf);
ffffffffc0200b66:	8522                	mv	a0,s0
}
ffffffffc0200b68:	6442                	ld	s0,16(sp)
ffffffffc0200b6a:	60e2                	ld	ra,24(sp)
ffffffffc0200b6c:	64a2                	ld	s1,8(sp)
ffffffffc0200b6e:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200b70:	b9b5                	j	ffffffffc02007ec <print_trapframe>
            panic("AMO address misaligned\n");
ffffffffc0200b72:	00005617          	auipc	a2,0x5
ffffffffc0200b76:	97e60613          	addi	a2,a2,-1666 # ffffffffc02054f0 <commands+0x5c8>
ffffffffc0200b7a:	0ca00593          	li	a1,202
ffffffffc0200b7e:	00004517          	auipc	a0,0x4
ffffffffc0200b82:	7b250513          	addi	a0,a0,1970 # ffffffffc0205330 <commands+0x408>
ffffffffc0200b86:	e7aff0ef          	jal	ra,ffffffffc0200200 <__panic>
                print_trapframe(tf);
ffffffffc0200b8a:	8522                	mv	a0,s0
ffffffffc0200b8c:	c61ff0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b90:	86a6                	mv	a3,s1
ffffffffc0200b92:	00005617          	auipc	a2,0x5
ffffffffc0200b96:	93e60613          	addi	a2,a2,-1730 # ffffffffc02054d0 <commands+0x5a8>
ffffffffc0200b9a:	0ea00593          	li	a1,234
ffffffffc0200b9e:	00004517          	auipc	a0,0x4
ffffffffc0200ba2:	79250513          	addi	a0,a0,1938 # ffffffffc0205330 <commands+0x408>
ffffffffc0200ba6:	e5aff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200baa <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
ffffffffc0200baa:	1101                	addi	sp,sp,-32
ffffffffc0200bac:	e822                	sd	s0,16(sp)

    if (current == NULL) {
ffffffffc0200bae:	00053417          	auipc	s0,0x53
ffffffffc0200bb2:	8f240413          	addi	s0,s0,-1806 # ffffffffc02534a0 <current>
ffffffffc0200bb6:	6018                	ld	a4,0(s0)
trap(struct trapframe *tf) {
ffffffffc0200bb8:	ec06                	sd	ra,24(sp)
ffffffffc0200bba:	e426                	sd	s1,8(sp)
ffffffffc0200bbc:	e04a                	sd	s2,0(sp)
ffffffffc0200bbe:	11853683          	ld	a3,280(a0)
    if (current == NULL) {
ffffffffc0200bc2:	cf1d                	beqz	a4,ffffffffc0200c00 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bc4:	10053483          	ld	s1,256(a0)
        trap_dispatch(tf);
    } else {
        struct trapframe *otf = current->tf;
ffffffffc0200bc8:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200bcc:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bce:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200bd2:	0206c463          	bltz	a3,ffffffffc0200bfa <trap+0x50>
        exception_handler(tf);
ffffffffc0200bd6:	e1fff0ef          	jal	ra,ffffffffc02009f4 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200bda:	601c                	ld	a5,0(s0)
ffffffffc0200bdc:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel) {
ffffffffc0200be0:	e499                	bnez	s1,ffffffffc0200bee <trap+0x44>
            if (current->flags & PF_EXITING) {
ffffffffc0200be2:	0b07a703          	lw	a4,176(a5)
ffffffffc0200be6:	8b05                	andi	a4,a4,1
ffffffffc0200be8:	e329                	bnez	a4,ffffffffc0200c2a <trap+0x80>
                do_exit(-E_KILLED);
            }
            if (current->need_resched) {
ffffffffc0200bea:	6f9c                	ld	a5,24(a5)
ffffffffc0200bec:	eb85                	bnez	a5,ffffffffc0200c1c <trap+0x72>
                schedule();
            }
        }
    }
}
ffffffffc0200bee:	60e2                	ld	ra,24(sp)
ffffffffc0200bf0:	6442                	ld	s0,16(sp)
ffffffffc0200bf2:	64a2                	ld	s1,8(sp)
ffffffffc0200bf4:	6902                	ld	s2,0(sp)
ffffffffc0200bf6:	6105                	addi	sp,sp,32
ffffffffc0200bf8:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200bfa:	d6fff0ef          	jal	ra,ffffffffc0200968 <interrupt_handler>
ffffffffc0200bfe:	bff1                	j	ffffffffc0200bda <trap+0x30>
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c00:	0006c863          	bltz	a3,ffffffffc0200c10 <trap+0x66>
}
ffffffffc0200c04:	6442                	ld	s0,16(sp)
ffffffffc0200c06:	60e2                	ld	ra,24(sp)
ffffffffc0200c08:	64a2                	ld	s1,8(sp)
ffffffffc0200c0a:	6902                	ld	s2,0(sp)
ffffffffc0200c0c:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200c0e:	b3dd                	j	ffffffffc02009f4 <exception_handler>
}
ffffffffc0200c10:	6442                	ld	s0,16(sp)
ffffffffc0200c12:	60e2                	ld	ra,24(sp)
ffffffffc0200c14:	64a2                	ld	s1,8(sp)
ffffffffc0200c16:	6902                	ld	s2,0(sp)
ffffffffc0200c18:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200c1a:	b3b9                	j	ffffffffc0200968 <interrupt_handler>
}
ffffffffc0200c1c:	6442                	ld	s0,16(sp)
ffffffffc0200c1e:	60e2                	ld	ra,24(sp)
ffffffffc0200c20:	64a2                	ld	s1,8(sp)
ffffffffc0200c22:	6902                	ld	s2,0(sp)
ffffffffc0200c24:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200c26:	11f0306f          	j	ffffffffc0204544 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200c2a:	555d                	li	a0,-9
ffffffffc0200c2c:	519020ef          	jal	ra,ffffffffc0203944 <do_exit>
ffffffffc0200c30:	601c                	ld	a5,0(s0)
ffffffffc0200c32:	bf65                	j	ffffffffc0200bea <trap+0x40>

ffffffffc0200c34 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200c34:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c38:	00011463          	bnez	sp,ffffffffc0200c40 <__alltraps+0xc>
ffffffffc0200c3c:	14002173          	csrr	sp,sscratch
ffffffffc0200c40:	712d                	addi	sp,sp,-288
ffffffffc0200c42:	e002                	sd	zero,0(sp)
ffffffffc0200c44:	e406                	sd	ra,8(sp)
ffffffffc0200c46:	ec0e                	sd	gp,24(sp)
ffffffffc0200c48:	f012                	sd	tp,32(sp)
ffffffffc0200c4a:	f416                	sd	t0,40(sp)
ffffffffc0200c4c:	f81a                	sd	t1,48(sp)
ffffffffc0200c4e:	fc1e                	sd	t2,56(sp)
ffffffffc0200c50:	e0a2                	sd	s0,64(sp)
ffffffffc0200c52:	e4a6                	sd	s1,72(sp)
ffffffffc0200c54:	e8aa                	sd	a0,80(sp)
ffffffffc0200c56:	ecae                	sd	a1,88(sp)
ffffffffc0200c58:	f0b2                	sd	a2,96(sp)
ffffffffc0200c5a:	f4b6                	sd	a3,104(sp)
ffffffffc0200c5c:	f8ba                	sd	a4,112(sp)
ffffffffc0200c5e:	fcbe                	sd	a5,120(sp)
ffffffffc0200c60:	e142                	sd	a6,128(sp)
ffffffffc0200c62:	e546                	sd	a7,136(sp)
ffffffffc0200c64:	e94a                	sd	s2,144(sp)
ffffffffc0200c66:	ed4e                	sd	s3,152(sp)
ffffffffc0200c68:	f152                	sd	s4,160(sp)
ffffffffc0200c6a:	f556                	sd	s5,168(sp)
ffffffffc0200c6c:	f95a                	sd	s6,176(sp)
ffffffffc0200c6e:	fd5e                	sd	s7,184(sp)
ffffffffc0200c70:	e1e2                	sd	s8,192(sp)
ffffffffc0200c72:	e5e6                	sd	s9,200(sp)
ffffffffc0200c74:	e9ea                	sd	s10,208(sp)
ffffffffc0200c76:	edee                	sd	s11,216(sp)
ffffffffc0200c78:	f1f2                	sd	t3,224(sp)
ffffffffc0200c7a:	f5f6                	sd	t4,232(sp)
ffffffffc0200c7c:	f9fa                	sd	t5,240(sp)
ffffffffc0200c7e:	fdfe                	sd	t6,248(sp)
ffffffffc0200c80:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c84:	100024f3          	csrr	s1,sstatus
ffffffffc0200c88:	14102973          	csrr	s2,sepc
ffffffffc0200c8c:	143029f3          	csrr	s3,stval
ffffffffc0200c90:	14202a73          	csrr	s4,scause
ffffffffc0200c94:	e822                	sd	s0,16(sp)
ffffffffc0200c96:	e226                	sd	s1,256(sp)
ffffffffc0200c98:	e64a                	sd	s2,264(sp)
ffffffffc0200c9a:	ea4e                	sd	s3,272(sp)
ffffffffc0200c9c:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c9e:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ca0:	f0bff0ef          	jal	ra,ffffffffc0200baa <trap>

ffffffffc0200ca4 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200ca4:	6492                	ld	s1,256(sp)
ffffffffc0200ca6:	6932                	ld	s2,264(sp)
ffffffffc0200ca8:	1004f413          	andi	s0,s1,256
ffffffffc0200cac:	e401                	bnez	s0,ffffffffc0200cb4 <__trapret+0x10>
ffffffffc0200cae:	1200                	addi	s0,sp,288
ffffffffc0200cb0:	14041073          	csrw	sscratch,s0
ffffffffc0200cb4:	10049073          	csrw	sstatus,s1
ffffffffc0200cb8:	14191073          	csrw	sepc,s2
ffffffffc0200cbc:	60a2                	ld	ra,8(sp)
ffffffffc0200cbe:	61e2                	ld	gp,24(sp)
ffffffffc0200cc0:	7202                	ld	tp,32(sp)
ffffffffc0200cc2:	72a2                	ld	t0,40(sp)
ffffffffc0200cc4:	7342                	ld	t1,48(sp)
ffffffffc0200cc6:	73e2                	ld	t2,56(sp)
ffffffffc0200cc8:	6406                	ld	s0,64(sp)
ffffffffc0200cca:	64a6                	ld	s1,72(sp)
ffffffffc0200ccc:	6546                	ld	a0,80(sp)
ffffffffc0200cce:	65e6                	ld	a1,88(sp)
ffffffffc0200cd0:	7606                	ld	a2,96(sp)
ffffffffc0200cd2:	76a6                	ld	a3,104(sp)
ffffffffc0200cd4:	7746                	ld	a4,112(sp)
ffffffffc0200cd6:	77e6                	ld	a5,120(sp)
ffffffffc0200cd8:	680a                	ld	a6,128(sp)
ffffffffc0200cda:	68aa                	ld	a7,136(sp)
ffffffffc0200cdc:	694a                	ld	s2,144(sp)
ffffffffc0200cde:	69ea                	ld	s3,152(sp)
ffffffffc0200ce0:	7a0a                	ld	s4,160(sp)
ffffffffc0200ce2:	7aaa                	ld	s5,168(sp)
ffffffffc0200ce4:	7b4a                	ld	s6,176(sp)
ffffffffc0200ce6:	7bea                	ld	s7,184(sp)
ffffffffc0200ce8:	6c0e                	ld	s8,192(sp)
ffffffffc0200cea:	6cae                	ld	s9,200(sp)
ffffffffc0200cec:	6d4e                	ld	s10,208(sp)
ffffffffc0200cee:	6dee                	ld	s11,216(sp)
ffffffffc0200cf0:	7e0e                	ld	t3,224(sp)
ffffffffc0200cf2:	7eae                	ld	t4,232(sp)
ffffffffc0200cf4:	7f4e                	ld	t5,240(sp)
ffffffffc0200cf6:	7fee                	ld	t6,248(sp)
ffffffffc0200cf8:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200cfa:	10200073          	sret

ffffffffc0200cfe <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200cfe:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200d00:	b755                	j	ffffffffc0200ca4 <__trapret>

ffffffffc0200d02 <pa2page.part.0>:
page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
}

static inline struct Page *
pa2page(uintptr_t pa) {
ffffffffc0200d02:	1141                	addi	sp,sp,-16
    if (PPN(pa) >= npage) {
        panic("pa2page called with invalid pa");
ffffffffc0200d04:	00005617          	auipc	a2,0x5
ffffffffc0200d08:	90460613          	addi	a2,a2,-1788 # ffffffffc0205608 <commands+0x6e0>
ffffffffc0200d0c:	06200593          	li	a1,98
ffffffffc0200d10:	00005517          	auipc	a0,0x5
ffffffffc0200d14:	91850513          	addi	a0,a0,-1768 # ffffffffc0205628 <commands+0x700>
pa2page(uintptr_t pa) {
ffffffffc0200d18:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0200d1a:	ce6ff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0200d1e <alloc_pages>:
    pmm_manager->init_memmap(base, n);
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
ffffffffc0200d1e:	7139                	addi	sp,sp,-64
ffffffffc0200d20:	f426                	sd	s1,40(sp)
ffffffffc0200d22:	f04a                	sd	s2,32(sp)
ffffffffc0200d24:	ec4e                	sd	s3,24(sp)
ffffffffc0200d26:	e852                	sd	s4,16(sp)
ffffffffc0200d28:	e456                	sd	s5,8(sp)
ffffffffc0200d2a:	e05a                	sd	s6,0(sp)
ffffffffc0200d2c:	fc06                	sd	ra,56(sp)
ffffffffc0200d2e:	f822                	sd	s0,48(sp)
ffffffffc0200d30:	84aa                	mv	s1,a0
ffffffffc0200d32:	00052917          	auipc	s2,0x52
ffffffffc0200d36:	7a690913          	addi	s2,s2,1958 # ffffffffc02534d8 <pmm_manager>
        {
            page = pmm_manager->alloc_pages(n);
        }
        local_intr_restore(intr_flag);

        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d3a:	4a05                	li	s4,1
ffffffffc0200d3c:	00052a97          	auipc	s5,0x52
ffffffffc0200d40:	75ca8a93          	addi	s5,s5,1884 # ffffffffc0253498 <swap_init_ok>

        extern struct mm_struct *check_mm_struct;
        // cprintf("page %x, call swap_out in alloc_pages %d\n",page, n);
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d44:	0005099b          	sext.w	s3,a0
ffffffffc0200d48:	00052b17          	auipc	s6,0x52
ffffffffc0200d4c:	7c0b0b13          	addi	s6,s6,1984 # ffffffffc0253508 <check_mm_struct>
ffffffffc0200d50:	a01d                	j	ffffffffc0200d76 <alloc_pages+0x58>
            page = pmm_manager->alloc_pages(n);
ffffffffc0200d52:	00093783          	ld	a5,0(s2)
ffffffffc0200d56:	6f9c                	ld	a5,24(a5)
ffffffffc0200d58:	9782                	jalr	a5
ffffffffc0200d5a:	842a                	mv	s0,a0
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d5c:	4601                	li	a2,0
ffffffffc0200d5e:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d60:	ec0d                	bnez	s0,ffffffffc0200d9a <alloc_pages+0x7c>
ffffffffc0200d62:	029a6c63          	bltu	s4,s1,ffffffffc0200d9a <alloc_pages+0x7c>
ffffffffc0200d66:	000aa783          	lw	a5,0(s5)
ffffffffc0200d6a:	2781                	sext.w	a5,a5
ffffffffc0200d6c:	c79d                	beqz	a5,ffffffffc0200d9a <alloc_pages+0x7c>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d6e:	000b3503          	ld	a0,0(s6)
ffffffffc0200d72:	6d4010ef          	jal	ra,ffffffffc0202446 <swap_out>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200d76:	100027f3          	csrr	a5,sstatus
ffffffffc0200d7a:	8b89                	andi	a5,a5,2
            page = pmm_manager->alloc_pages(n);
ffffffffc0200d7c:	8526                	mv	a0,s1
ffffffffc0200d7e:	dbf1                	beqz	a5,ffffffffc0200d52 <alloc_pages+0x34>
        intr_disable();
ffffffffc0200d80:	87fff0ef          	jal	ra,ffffffffc02005fe <intr_disable>
ffffffffc0200d84:	00093783          	ld	a5,0(s2)
ffffffffc0200d88:	8526                	mv	a0,s1
ffffffffc0200d8a:	6f9c                	ld	a5,24(a5)
ffffffffc0200d8c:	9782                	jalr	a5
ffffffffc0200d8e:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200d90:	869ff0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d94:	4601                	li	a2,0
ffffffffc0200d96:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d98:	d469                	beqz	s0,ffffffffc0200d62 <alloc_pages+0x44>
    }
    // cprintf("n %d,get page %x, No %d in alloc_pages\n",n,page,(page-pages));
    return page;
}
ffffffffc0200d9a:	70e2                	ld	ra,56(sp)
ffffffffc0200d9c:	8522                	mv	a0,s0
ffffffffc0200d9e:	7442                	ld	s0,48(sp)
ffffffffc0200da0:	74a2                	ld	s1,40(sp)
ffffffffc0200da2:	7902                	ld	s2,32(sp)
ffffffffc0200da4:	69e2                	ld	s3,24(sp)
ffffffffc0200da6:	6a42                	ld	s4,16(sp)
ffffffffc0200da8:	6aa2                	ld	s5,8(sp)
ffffffffc0200daa:	6b02                	ld	s6,0(sp)
ffffffffc0200dac:	6121                	addi	sp,sp,64
ffffffffc0200dae:	8082                	ret

ffffffffc0200db0 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200db0:	100027f3          	csrr	a5,sstatus
ffffffffc0200db4:	8b89                	andi	a5,a5,2
ffffffffc0200db6:	eb81                	bnez	a5,ffffffffc0200dc6 <free_pages+0x16>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0200db8:	00052797          	auipc	a5,0x52
ffffffffc0200dbc:	7207b783          	ld	a5,1824(a5) # ffffffffc02534d8 <pmm_manager>
ffffffffc0200dc0:	0207b303          	ld	t1,32(a5)
ffffffffc0200dc4:	8302                	jr	t1
void free_pages(struct Page *base, size_t n) {
ffffffffc0200dc6:	1101                	addi	sp,sp,-32
ffffffffc0200dc8:	ec06                	sd	ra,24(sp)
ffffffffc0200dca:	e822                	sd	s0,16(sp)
ffffffffc0200dcc:	e426                	sd	s1,8(sp)
ffffffffc0200dce:	842a                	mv	s0,a0
ffffffffc0200dd0:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0200dd2:	82dff0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0200dd6:	00052797          	auipc	a5,0x52
ffffffffc0200dda:	7027b783          	ld	a5,1794(a5) # ffffffffc02534d8 <pmm_manager>
ffffffffc0200dde:	739c                	ld	a5,32(a5)
ffffffffc0200de0:	85a6                	mv	a1,s1
ffffffffc0200de2:	8522                	mv	a0,s0
ffffffffc0200de4:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0200de6:	6442                	ld	s0,16(sp)
ffffffffc0200de8:	60e2                	ld	ra,24(sp)
ffffffffc0200dea:	64a2                	ld	s1,8(sp)
ffffffffc0200dec:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0200dee:	80bff06f          	j	ffffffffc02005f8 <intr_enable>

ffffffffc0200df2 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200df2:	100027f3          	csrr	a5,sstatus
ffffffffc0200df6:	8b89                	andi	a5,a5,2
ffffffffc0200df8:	eb81                	bnez	a5,ffffffffc0200e08 <nr_free_pages+0x16>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0200dfa:	00052797          	auipc	a5,0x52
ffffffffc0200dfe:	6de7b783          	ld	a5,1758(a5) # ffffffffc02534d8 <pmm_manager>
ffffffffc0200e02:	0287b303          	ld	t1,40(a5)
ffffffffc0200e06:	8302                	jr	t1
size_t nr_free_pages(void) {
ffffffffc0200e08:	1141                	addi	sp,sp,-16
ffffffffc0200e0a:	e406                	sd	ra,8(sp)
ffffffffc0200e0c:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0200e0e:	ff0ff0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0200e12:	00052797          	auipc	a5,0x52
ffffffffc0200e16:	6c67b783          	ld	a5,1734(a5) # ffffffffc02534d8 <pmm_manager>
ffffffffc0200e1a:	779c                	ld	a5,40(a5)
ffffffffc0200e1c:	9782                	jalr	a5
ffffffffc0200e1e:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200e20:	fd8ff0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0200e24:	60a2                	ld	ra,8(sp)
ffffffffc0200e26:	8522                	mv	a0,s0
ffffffffc0200e28:	6402                	ld	s0,0(sp)
ffffffffc0200e2a:	0141                	addi	sp,sp,16
ffffffffc0200e2c:	8082                	ret

ffffffffc0200e2e <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0200e2e:	00005797          	auipc	a5,0x5
ffffffffc0200e32:	22a78793          	addi	a5,a5,554 # ffffffffc0206058 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e36:	638c                	ld	a1,0(a5)
}

// pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup
// paging mechanism
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void pmm_init(void) {
ffffffffc0200e38:	1101                	addi	sp,sp,-32
ffffffffc0200e3a:	e426                	sd	s1,8(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e3c:	00004517          	auipc	a0,0x4
ffffffffc0200e40:	7fc50513          	addi	a0,a0,2044 # ffffffffc0205638 <commands+0x710>
    pmm_manager = &default_pmm_manager;
ffffffffc0200e44:	00052497          	auipc	s1,0x52
ffffffffc0200e48:	69448493          	addi	s1,s1,1684 # ffffffffc02534d8 <pmm_manager>
void pmm_init(void) {
ffffffffc0200e4c:	ec06                	sd	ra,24(sp)
ffffffffc0200e4e:	e822                	sd	s0,16(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0200e50:	e09c                	sd	a5,0(s1)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e52:	a72ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    pmm_manager->init();
ffffffffc0200e56:	609c                	ld	a5,0(s1)
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e58:	00052417          	auipc	s0,0x52
ffffffffc0200e5c:	68840413          	addi	s0,s0,1672 # ffffffffc02534e0 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200e60:	679c                	ld	a5,8(a5)
ffffffffc0200e62:	9782                	jalr	a5
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e64:	57f5                	li	a5,-3
ffffffffc0200e66:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc0200e68:	00004517          	auipc	a0,0x4
ffffffffc0200e6c:	7e850513          	addi	a0,a0,2024 # ffffffffc0205650 <commands+0x728>
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e70:	e01c                	sd	a5,0(s0)
    cprintf("physcial memory map:\n");
ffffffffc0200e72:	a52ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0200e76:	44300693          	li	a3,1091
ffffffffc0200e7a:	06d6                	slli	a3,a3,0x15
ffffffffc0200e7c:	40100613          	li	a2,1025
ffffffffc0200e80:	0656                	slli	a2,a2,0x15
ffffffffc0200e82:	088005b7          	lui	a1,0x8800
ffffffffc0200e86:	16fd                	addi	a3,a3,-1
ffffffffc0200e88:	00004517          	auipc	a0,0x4
ffffffffc0200e8c:	7e050513          	addi	a0,a0,2016 # ffffffffc0205668 <commands+0x740>
ffffffffc0200e90:	a34ff0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200e94:	777d                	lui	a4,0xfffff
ffffffffc0200e96:	00053797          	auipc	a5,0x53
ffffffffc0200e9a:	76978793          	addi	a5,a5,1897 # ffffffffc02545ff <end+0xfff>
ffffffffc0200e9e:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc0200ea0:	00088737          	lui	a4,0x88
ffffffffc0200ea4:	60070713          	addi	a4,a4,1536 # 88600 <_binary_obj___user_ex3_out_size+0x7d900>
ffffffffc0200ea8:	00052597          	auipc	a1,0x52
ffffffffc0200eac:	5d058593          	addi	a1,a1,1488 # ffffffffc0253478 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200eb0:	00052617          	auipc	a2,0x52
ffffffffc0200eb4:	64060613          	addi	a2,a2,1600 # ffffffffc02534f0 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0200eb8:	e198                	sd	a4,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200eba:	e21c                	sd	a5,0(a2)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200ebc:	4701                	li	a4,0
 *
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void set_bit(int nr, volatile void *addr) {
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0200ebe:	4505                	li	a0,1
ffffffffc0200ec0:	fff80837          	lui	a6,0xfff80
ffffffffc0200ec4:	a011                	j	ffffffffc0200ec8 <pmm_init+0x9a>
ffffffffc0200ec6:	621c                	ld	a5,0(a2)
        SetPageReserved(pages + i);
ffffffffc0200ec8:	00671693          	slli	a3,a4,0x6
ffffffffc0200ecc:	97b6                	add	a5,a5,a3
ffffffffc0200ece:	07a1                	addi	a5,a5,8
ffffffffc0200ed0:	40a7b02f          	amoor.d	zero,a0,(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200ed4:	0005b883          	ld	a7,0(a1)
ffffffffc0200ed8:	0705                	addi	a4,a4,1
ffffffffc0200eda:	010886b3          	add	a3,a7,a6
ffffffffc0200ede:	fed764e3          	bltu	a4,a3,ffffffffc0200ec6 <pmm_init+0x98>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200ee2:	6208                	ld	a0,0(a2)
ffffffffc0200ee4:	069a                	slli	a3,a3,0x6
ffffffffc0200ee6:	c02007b7          	lui	a5,0xc0200
ffffffffc0200eea:	96aa                	add	a3,a3,a0
ffffffffc0200eec:	06f6e263          	bltu	a3,a5,ffffffffc0200f50 <pmm_init+0x122>
ffffffffc0200ef0:	601c                	ld	a5,0(s0)
    if (freemem < mem_end) {
ffffffffc0200ef2:	44300593          	li	a1,1091
ffffffffc0200ef6:	05d6                	slli	a1,a1,0x15
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200ef8:	8e9d                	sub	a3,a3,a5
    if (freemem < mem_end) {
ffffffffc0200efa:	02b6f363          	bgeu	a3,a1,ffffffffc0200f20 <pmm_init+0xf2>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200efe:	6785                	lui	a5,0x1
ffffffffc0200f00:	17fd                	addi	a5,a5,-1
ffffffffc0200f02:	96be                	add	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200f04:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200f08:	0717fc63          	bgeu	a5,a7,ffffffffc0200f80 <pmm_init+0x152>
    pmm_manager->init_memmap(base, n);
ffffffffc0200f0c:	6098                	ld	a4,0(s1)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f0e:	767d                	lui	a2,0xfffff
ffffffffc0200f10:	8ef1                	and	a3,a3,a2
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200f12:	97c2                	add	a5,a5,a6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f14:	6b18                	ld	a4,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f16:	8d95                	sub	a1,a1,a3
ffffffffc0200f18:	079a                	slli	a5,a5,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f1a:	81b1                	srli	a1,a1,0xc
ffffffffc0200f1c:	953e                	add	a0,a0,a5
ffffffffc0200f1e:	9702                	jalr	a4
    // pmm
    //check_alloc_page();

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    extern char boot_page_table_sv39[];
    boot_pgdir = (pte_t*)boot_page_table_sv39;
ffffffffc0200f20:	00009697          	auipc	a3,0x9
ffffffffc0200f24:	0e068693          	addi	a3,a3,224 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc0200f28:	00052797          	auipc	a5,0x52
ffffffffc0200f2c:	54d7b423          	sd	a3,1352(a5) # ffffffffc0253470 <boot_pgdir>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f30:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f34:	02f6ea63          	bltu	a3,a5,ffffffffc0200f68 <pmm_init+0x13a>
ffffffffc0200f38:	601c                	ld	a5,0(s0)
    // check the correctness of the basic virtual memory map.
    //check_boot_pgdir();


    kmalloc_init();
}
ffffffffc0200f3a:	6442                	ld	s0,16(sp)
ffffffffc0200f3c:	60e2                	ld	ra,24(sp)
ffffffffc0200f3e:	64a2                	ld	s1,8(sp)
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f40:	8e9d                	sub	a3,a3,a5
ffffffffc0200f42:	00052797          	auipc	a5,0x52
ffffffffc0200f46:	5ad7b323          	sd	a3,1446(a5) # ffffffffc02534e8 <boot_cr3>
}
ffffffffc0200f4a:	6105                	addi	sp,sp,32
    kmalloc_init();
ffffffffc0200f4c:	2ac0106f          	j	ffffffffc02021f8 <kmalloc_init>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f50:	00004617          	auipc	a2,0x4
ffffffffc0200f54:	74060613          	addi	a2,a2,1856 # ffffffffc0205690 <commands+0x768>
ffffffffc0200f58:	07f00593          	li	a1,127
ffffffffc0200f5c:	00004517          	auipc	a0,0x4
ffffffffc0200f60:	75c50513          	addi	a0,a0,1884 # ffffffffc02056b8 <commands+0x790>
ffffffffc0200f64:	a9cff0ef          	jal	ra,ffffffffc0200200 <__panic>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f68:	00004617          	auipc	a2,0x4
ffffffffc0200f6c:	72860613          	addi	a2,a2,1832 # ffffffffc0205690 <commands+0x768>
ffffffffc0200f70:	0c100593          	li	a1,193
ffffffffc0200f74:	00004517          	auipc	a0,0x4
ffffffffc0200f78:	74450513          	addi	a0,a0,1860 # ffffffffc02056b8 <commands+0x790>
ffffffffc0200f7c:	a84ff0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0200f80:	d83ff0ef          	jal	ra,ffffffffc0200d02 <pa2page.part.0>

ffffffffc0200f84 <get_pte>:
     *   PTE_W           0x002                   // page table/directory entry
     * flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry
     * flags bit : User can access
     */
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200f84:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200f88:	1ff7f793          	andi	a5,a5,511
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200f8c:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200f8e:	078e                	slli	a5,a5,0x3
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200f90:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200f92:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200f96:	6094                	ld	a3,0(s1)
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200f98:	f04a                	sd	s2,32(sp)
ffffffffc0200f9a:	ec4e                	sd	s3,24(sp)
ffffffffc0200f9c:	e852                	sd	s4,16(sp)
ffffffffc0200f9e:	fc06                	sd	ra,56(sp)
ffffffffc0200fa0:	f822                	sd	s0,48(sp)
ffffffffc0200fa2:	e456                	sd	s5,8(sp)
ffffffffc0200fa4:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fa6:	0016f793          	andi	a5,a3,1
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200faa:	892e                	mv	s2,a1
ffffffffc0200fac:	89b2                	mv	s3,a2
ffffffffc0200fae:	00052a17          	auipc	s4,0x52
ffffffffc0200fb2:	4caa0a13          	addi	s4,s4,1226 # ffffffffc0253478 <npage>
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fb6:	e7b5                	bnez	a5,ffffffffc0201022 <get_pte+0x9e>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0200fb8:	12060b63          	beqz	a2,ffffffffc02010ee <get_pte+0x16a>
ffffffffc0200fbc:	4505                	li	a0,1
ffffffffc0200fbe:	d61ff0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0200fc2:	842a                	mv	s0,a0
ffffffffc0200fc4:	12050563          	beqz	a0,ffffffffc02010ee <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0200fc8:	00052b17          	auipc	s6,0x52
ffffffffc0200fcc:	528b0b13          	addi	s6,s6,1320 # ffffffffc02534f0 <pages>
ffffffffc0200fd0:	000b3503          	ld	a0,0(s6)
ffffffffc0200fd4:	00080ab7          	lui	s5,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0200fd8:	00052a17          	auipc	s4,0x52
ffffffffc0200fdc:	4a0a0a13          	addi	s4,s4,1184 # ffffffffc0253478 <npage>
ffffffffc0200fe0:	40a40533          	sub	a0,s0,a0
ffffffffc0200fe4:	8519                	srai	a0,a0,0x6
ffffffffc0200fe6:	9556                	add	a0,a0,s5
ffffffffc0200fe8:	000a3703          	ld	a4,0(s4)
ffffffffc0200fec:	00c51793          	slli	a5,a0,0xc
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
ffffffffc0200ff0:	4685                	li	a3,1
ffffffffc0200ff2:	c014                	sw	a3,0(s0)
ffffffffc0200ff4:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0200ff6:	0532                	slli	a0,a0,0xc
ffffffffc0200ff8:	14e7f263          	bgeu	a5,a4,ffffffffc020113c <get_pte+0x1b8>
ffffffffc0200ffc:	00052797          	auipc	a5,0x52
ffffffffc0201000:	4e47b783          	ld	a5,1252(a5) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0201004:	6605                	lui	a2,0x1
ffffffffc0201006:	4581                	li	a1,0
ffffffffc0201008:	953e                	add	a0,a0,a5
ffffffffc020100a:	04d030ef          	jal	ra,ffffffffc0204856 <memset>
    return page - pages + nbase;
ffffffffc020100e:	000b3683          	ld	a3,0(s6)
ffffffffc0201012:	40d406b3          	sub	a3,s0,a3
ffffffffc0201016:	8699                	srai	a3,a3,0x6
ffffffffc0201018:	96d6                	add	a3,a3,s5
  asm volatile("sfence.vm");
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type) {
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020101a:	06aa                	slli	a3,a3,0xa
ffffffffc020101c:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201020:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201022:	77fd                	lui	a5,0xfffff
ffffffffc0201024:	068a                	slli	a3,a3,0x2
ffffffffc0201026:	000a3703          	ld	a4,0(s4)
ffffffffc020102a:	8efd                	and	a3,a3,a5
ffffffffc020102c:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201030:	0ce7f163          	bgeu	a5,a4,ffffffffc02010f2 <get_pte+0x16e>
ffffffffc0201034:	00052a97          	auipc	s5,0x52
ffffffffc0201038:	4aca8a93          	addi	s5,s5,1196 # ffffffffc02534e0 <va_pa_offset>
ffffffffc020103c:	000ab403          	ld	s0,0(s5)
ffffffffc0201040:	01595793          	srli	a5,s2,0x15
ffffffffc0201044:	1ff7f793          	andi	a5,a5,511
ffffffffc0201048:	96a2                	add	a3,a3,s0
ffffffffc020104a:	00379413          	slli	s0,a5,0x3
ffffffffc020104e:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V)) {
ffffffffc0201050:	6014                	ld	a3,0(s0)
ffffffffc0201052:	0016f793          	andi	a5,a3,1
ffffffffc0201056:	e3ad                	bnez	a5,ffffffffc02010b8 <get_pte+0x134>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0201058:	08098b63          	beqz	s3,ffffffffc02010ee <get_pte+0x16a>
ffffffffc020105c:	4505                	li	a0,1
ffffffffc020105e:	cc1ff0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0201062:	84aa                	mv	s1,a0
ffffffffc0201064:	c549                	beqz	a0,ffffffffc02010ee <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0201066:	00052b17          	auipc	s6,0x52
ffffffffc020106a:	48ab0b13          	addi	s6,s6,1162 # ffffffffc02534f0 <pages>
ffffffffc020106e:	000b3503          	ld	a0,0(s6)
ffffffffc0201072:	000809b7          	lui	s3,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201076:	000a3703          	ld	a4,0(s4)
ffffffffc020107a:	40a48533          	sub	a0,s1,a0
ffffffffc020107e:	8519                	srai	a0,a0,0x6
ffffffffc0201080:	954e                	add	a0,a0,s3
ffffffffc0201082:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201086:	4685                	li	a3,1
ffffffffc0201088:	c094                	sw	a3,0(s1)
ffffffffc020108a:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020108c:	0532                	slli	a0,a0,0xc
ffffffffc020108e:	08e7fa63          	bgeu	a5,a4,ffffffffc0201122 <get_pte+0x19e>
ffffffffc0201092:	000ab783          	ld	a5,0(s5)
ffffffffc0201096:	6605                	lui	a2,0x1
ffffffffc0201098:	4581                	li	a1,0
ffffffffc020109a:	953e                	add	a0,a0,a5
ffffffffc020109c:	7ba030ef          	jal	ra,ffffffffc0204856 <memset>
    return page - pages + nbase;
ffffffffc02010a0:	000b3683          	ld	a3,0(s6)
ffffffffc02010a4:	40d486b3          	sub	a3,s1,a3
ffffffffc02010a8:	8699                	srai	a3,a3,0x6
ffffffffc02010aa:	96ce                	add	a3,a3,s3
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02010ac:	06aa                	slli	a3,a3,0xa
ffffffffc02010ae:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02010b2:	e014                	sd	a3,0(s0)
ffffffffc02010b4:	000a3703          	ld	a4,0(s4)
        }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02010b8:	068a                	slli	a3,a3,0x2
ffffffffc02010ba:	757d                	lui	a0,0xfffff
ffffffffc02010bc:	8ee9                	and	a3,a3,a0
ffffffffc02010be:	00c6d793          	srli	a5,a3,0xc
ffffffffc02010c2:	04e7f463          	bgeu	a5,a4,ffffffffc020110a <get_pte+0x186>
ffffffffc02010c6:	000ab503          	ld	a0,0(s5)
ffffffffc02010ca:	00c95913          	srli	s2,s2,0xc
ffffffffc02010ce:	1ff97913          	andi	s2,s2,511
ffffffffc02010d2:	96aa                	add	a3,a3,a0
ffffffffc02010d4:	00391513          	slli	a0,s2,0x3
ffffffffc02010d8:	9536                	add	a0,a0,a3
}
ffffffffc02010da:	70e2                	ld	ra,56(sp)
ffffffffc02010dc:	7442                	ld	s0,48(sp)
ffffffffc02010de:	74a2                	ld	s1,40(sp)
ffffffffc02010e0:	7902                	ld	s2,32(sp)
ffffffffc02010e2:	69e2                	ld	s3,24(sp)
ffffffffc02010e4:	6a42                	ld	s4,16(sp)
ffffffffc02010e6:	6aa2                	ld	s5,8(sp)
ffffffffc02010e8:	6b02                	ld	s6,0(sp)
ffffffffc02010ea:	6121                	addi	sp,sp,64
ffffffffc02010ec:	8082                	ret
            return NULL;
ffffffffc02010ee:	4501                	li	a0,0
ffffffffc02010f0:	b7ed                	j	ffffffffc02010da <get_pte+0x156>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc02010f2:	00004617          	auipc	a2,0x4
ffffffffc02010f6:	5d660613          	addi	a2,a2,1494 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc02010fa:	0fe00593          	li	a1,254
ffffffffc02010fe:	00004517          	auipc	a0,0x4
ffffffffc0201102:	5ba50513          	addi	a0,a0,1466 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201106:	8faff0ef          	jal	ra,ffffffffc0200200 <__panic>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020110a:	00004617          	auipc	a2,0x4
ffffffffc020110e:	5be60613          	addi	a2,a2,1470 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0201112:	10900593          	li	a1,265
ffffffffc0201116:	00004517          	auipc	a0,0x4
ffffffffc020111a:	5a250513          	addi	a0,a0,1442 # ffffffffc02056b8 <commands+0x790>
ffffffffc020111e:	8e2ff0ef          	jal	ra,ffffffffc0200200 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201122:	86aa                	mv	a3,a0
ffffffffc0201124:	00004617          	auipc	a2,0x4
ffffffffc0201128:	5a460613          	addi	a2,a2,1444 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc020112c:	10600593          	li	a1,262
ffffffffc0201130:	00004517          	auipc	a0,0x4
ffffffffc0201134:	58850513          	addi	a0,a0,1416 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201138:	8c8ff0ef          	jal	ra,ffffffffc0200200 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020113c:	86aa                	mv	a3,a0
ffffffffc020113e:	00004617          	auipc	a2,0x4
ffffffffc0201142:	58a60613          	addi	a2,a2,1418 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0201146:	0fa00593          	li	a1,250
ffffffffc020114a:	00004517          	auipc	a0,0x4
ffffffffc020114e:	56e50513          	addi	a0,a0,1390 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201152:	8aeff0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201156 <unmap_range>:
        *ptep = 0;                  //(5) clear second page table entry
        tlb_invalidate(pgdir, la);  //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0201156:	711d                	addi	sp,sp,-96
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201158:	00c5e7b3          	or	a5,a1,a2
void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc020115c:	ec86                	sd	ra,88(sp)
ffffffffc020115e:	e8a2                	sd	s0,80(sp)
ffffffffc0201160:	e4a6                	sd	s1,72(sp)
ffffffffc0201162:	e0ca                	sd	s2,64(sp)
ffffffffc0201164:	fc4e                	sd	s3,56(sp)
ffffffffc0201166:	f852                	sd	s4,48(sp)
ffffffffc0201168:	f456                	sd	s5,40(sp)
ffffffffc020116a:	f05a                	sd	s6,32(sp)
ffffffffc020116c:	ec5e                	sd	s7,24(sp)
ffffffffc020116e:	e862                	sd	s8,16(sp)
ffffffffc0201170:	e466                	sd	s9,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201172:	17d2                	slli	a5,a5,0x34
ffffffffc0201174:	ebf1                	bnez	a5,ffffffffc0201248 <unmap_range+0xf2>
    assert(USER_ACCESS(start, end));
ffffffffc0201176:	002007b7          	lui	a5,0x200
ffffffffc020117a:	842e                	mv	s0,a1
ffffffffc020117c:	0af5e663          	bltu	a1,a5,ffffffffc0201228 <unmap_range+0xd2>
ffffffffc0201180:	8932                	mv	s2,a2
ffffffffc0201182:	0ac5f363          	bgeu	a1,a2,ffffffffc0201228 <unmap_range+0xd2>
ffffffffc0201186:	4785                	li	a5,1
ffffffffc0201188:	07fe                	slli	a5,a5,0x1f
ffffffffc020118a:	08c7ef63          	bltu	a5,a2,ffffffffc0201228 <unmap_range+0xd2>
ffffffffc020118e:	89aa                	mv	s3,a0
            continue;
        }
        if (*ptep != 0) {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0201190:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc0201192:	00052c97          	auipc	s9,0x52
ffffffffc0201196:	2e6c8c93          	addi	s9,s9,742 # ffffffffc0253478 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc020119a:	00052c17          	auipc	s8,0x52
ffffffffc020119e:	356c0c13          	addi	s8,s8,854 # ffffffffc02534f0 <pages>
ffffffffc02011a2:	fff80bb7          	lui	s7,0xfff80
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02011a6:	00200b37          	lui	s6,0x200
ffffffffc02011aa:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc02011ae:	4601                	li	a2,0
ffffffffc02011b0:	85a2                	mv	a1,s0
ffffffffc02011b2:	854e                	mv	a0,s3
ffffffffc02011b4:	dd1ff0ef          	jal	ra,ffffffffc0200f84 <get_pte>
ffffffffc02011b8:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc02011ba:	cd21                	beqz	a0,ffffffffc0201212 <unmap_range+0xbc>
        if (*ptep != 0) {
ffffffffc02011bc:	611c                	ld	a5,0(a0)
ffffffffc02011be:	e38d                	bnez	a5,ffffffffc02011e0 <unmap_range+0x8a>
        start += PGSIZE;
ffffffffc02011c0:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02011c2:	ff2466e3          	bltu	s0,s2,ffffffffc02011ae <unmap_range+0x58>
}
ffffffffc02011c6:	60e6                	ld	ra,88(sp)
ffffffffc02011c8:	6446                	ld	s0,80(sp)
ffffffffc02011ca:	64a6                	ld	s1,72(sp)
ffffffffc02011cc:	6906                	ld	s2,64(sp)
ffffffffc02011ce:	79e2                	ld	s3,56(sp)
ffffffffc02011d0:	7a42                	ld	s4,48(sp)
ffffffffc02011d2:	7aa2                	ld	s5,40(sp)
ffffffffc02011d4:	7b02                	ld	s6,32(sp)
ffffffffc02011d6:	6be2                	ld	s7,24(sp)
ffffffffc02011d8:	6c42                	ld	s8,16(sp)
ffffffffc02011da:	6ca2                	ld	s9,8(sp)
ffffffffc02011dc:	6125                	addi	sp,sp,96
ffffffffc02011de:	8082                	ret
    if (*ptep & PTE_V) {  //(1) check if this page table entry is
ffffffffc02011e0:	0017f713          	andi	a4,a5,1
ffffffffc02011e4:	df71                	beqz	a4,ffffffffc02011c0 <unmap_range+0x6a>
    if (PPN(pa) >= npage) {
ffffffffc02011e6:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc02011ea:	078a                	slli	a5,a5,0x2
ffffffffc02011ec:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc02011ee:	06e7fd63          	bgeu	a5,a4,ffffffffc0201268 <unmap_range+0x112>
    return &pages[PPN(pa) - nbase];
ffffffffc02011f2:	000c3503          	ld	a0,0(s8)
ffffffffc02011f6:	97de                	add	a5,a5,s7
ffffffffc02011f8:	079a                	slli	a5,a5,0x6
ffffffffc02011fa:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02011fc:	411c                	lw	a5,0(a0)
ffffffffc02011fe:	fff7871b          	addiw	a4,a5,-1
ffffffffc0201202:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0201204:	cf11                	beqz	a4,ffffffffc0201220 <unmap_range+0xca>
        *ptep = 0;                  //(5) clear second page table entry
ffffffffc0201206:	0004b023          	sd	zero,0(s1)
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020120a:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc020120e:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0201210:	bf4d                	j	ffffffffc02011c2 <unmap_range+0x6c>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0201212:	945a                	add	s0,s0,s6
ffffffffc0201214:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc0201218:	d45d                	beqz	s0,ffffffffc02011c6 <unmap_range+0x70>
ffffffffc020121a:	f9246ae3          	bltu	s0,s2,ffffffffc02011ae <unmap_range+0x58>
ffffffffc020121e:	b765                	j	ffffffffc02011c6 <unmap_range+0x70>
            free_page(page);
ffffffffc0201220:	4585                	li	a1,1
ffffffffc0201222:	b8fff0ef          	jal	ra,ffffffffc0200db0 <free_pages>
ffffffffc0201226:	b7c5                	j	ffffffffc0201206 <unmap_range+0xb0>
    assert(USER_ACCESS(start, end));
ffffffffc0201228:	00004697          	auipc	a3,0x4
ffffffffc020122c:	4f868693          	addi	a3,a3,1272 # ffffffffc0205720 <commands+0x7f8>
ffffffffc0201230:	00004617          	auipc	a2,0x4
ffffffffc0201234:	0e860613          	addi	a2,a2,232 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201238:	14100593          	li	a1,321
ffffffffc020123c:	00004517          	auipc	a0,0x4
ffffffffc0201240:	47c50513          	addi	a0,a0,1148 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201244:	fbdfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201248:	00004697          	auipc	a3,0x4
ffffffffc020124c:	4a868693          	addi	a3,a3,1192 # ffffffffc02056f0 <commands+0x7c8>
ffffffffc0201250:	00004617          	auipc	a2,0x4
ffffffffc0201254:	0c860613          	addi	a2,a2,200 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201258:	14000593          	li	a1,320
ffffffffc020125c:	00004517          	auipc	a0,0x4
ffffffffc0201260:	45c50513          	addi	a0,a0,1116 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201264:	f9dfe0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0201268:	a9bff0ef          	jal	ra,ffffffffc0200d02 <pa2page.part.0>

ffffffffc020126c <exit_range>:
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc020126c:	715d                	addi	sp,sp,-80
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020126e:	00c5e7b3          	or	a5,a1,a2
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0201272:	e486                	sd	ra,72(sp)
ffffffffc0201274:	e0a2                	sd	s0,64(sp)
ffffffffc0201276:	fc26                	sd	s1,56(sp)
ffffffffc0201278:	f84a                	sd	s2,48(sp)
ffffffffc020127a:	f44e                	sd	s3,40(sp)
ffffffffc020127c:	f052                	sd	s4,32(sp)
ffffffffc020127e:	ec56                	sd	s5,24(sp)
ffffffffc0201280:	e85a                	sd	s6,16(sp)
ffffffffc0201282:	e45e                	sd	s7,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201284:	17d2                	slli	a5,a5,0x34
ffffffffc0201286:	e3f1                	bnez	a5,ffffffffc020134a <exit_range+0xde>
    assert(USER_ACCESS(start, end));
ffffffffc0201288:	002007b7          	lui	a5,0x200
ffffffffc020128c:	08f5ef63          	bltu	a1,a5,ffffffffc020132a <exit_range+0xbe>
ffffffffc0201290:	89b2                	mv	s3,a2
ffffffffc0201292:	08c5fc63          	bgeu	a1,a2,ffffffffc020132a <exit_range+0xbe>
ffffffffc0201296:	4785                	li	a5,1
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc0201298:	ffe004b7          	lui	s1,0xffe00
    assert(USER_ACCESS(start, end));
ffffffffc020129c:	07fe                	slli	a5,a5,0x1f
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc020129e:	8ced                	and	s1,s1,a1
    assert(USER_ACCESS(start, end));
ffffffffc02012a0:	08c7e563          	bltu	a5,a2,ffffffffc020132a <exit_range+0xbe>
ffffffffc02012a4:	8a2a                	mv	s4,a0
    if (PPN(pa) >= npage) {
ffffffffc02012a6:	00052b17          	auipc	s6,0x52
ffffffffc02012aa:	1d2b0b13          	addi	s6,s6,466 # ffffffffc0253478 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02012ae:	00052b97          	auipc	s7,0x52
ffffffffc02012b2:	242b8b93          	addi	s7,s7,578 # ffffffffc02534f0 <pages>
ffffffffc02012b6:	fff80937          	lui	s2,0xfff80
        start += PTSIZE;
ffffffffc02012ba:	00200ab7          	lui	s5,0x200
ffffffffc02012be:	a019                	j	ffffffffc02012c4 <exit_range+0x58>
    } while (start != 0 && start < end);
ffffffffc02012c0:	0334fe63          	bgeu	s1,s3,ffffffffc02012fc <exit_range+0x90>
        int pde_idx = PDX1(start);
ffffffffc02012c4:	01e4d413          	srli	s0,s1,0x1e
        if (pgdir[pde_idx] & PTE_V) {
ffffffffc02012c8:	1ff47413          	andi	s0,s0,511
ffffffffc02012cc:	040e                	slli	s0,s0,0x3
ffffffffc02012ce:	9452                	add	s0,s0,s4
ffffffffc02012d0:	601c                	ld	a5,0(s0)
ffffffffc02012d2:	0017f713          	andi	a4,a5,1
ffffffffc02012d6:	c30d                	beqz	a4,ffffffffc02012f8 <exit_range+0x8c>
    if (PPN(pa) >= npage) {
ffffffffc02012d8:	000b3703          	ld	a4,0(s6)
    return pa2page(PDE_ADDR(pde));
ffffffffc02012dc:	078a                	slli	a5,a5,0x2
ffffffffc02012de:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc02012e0:	02e7f963          	bgeu	a5,a4,ffffffffc0201312 <exit_range+0xa6>
    return &pages[PPN(pa) - nbase];
ffffffffc02012e4:	000bb503          	ld	a0,0(s7)
ffffffffc02012e8:	97ca                	add	a5,a5,s2
ffffffffc02012ea:	079a                	slli	a5,a5,0x6
            free_page(pde2page(pgdir[pde_idx]));
ffffffffc02012ec:	4585                	li	a1,1
ffffffffc02012ee:	953e                	add	a0,a0,a5
ffffffffc02012f0:	ac1ff0ef          	jal	ra,ffffffffc0200db0 <free_pages>
            pgdir[pde_idx] = 0;
ffffffffc02012f4:	00043023          	sd	zero,0(s0)
        start += PTSIZE;
ffffffffc02012f8:	94d6                	add	s1,s1,s5
    } while (start != 0 && start < end);
ffffffffc02012fa:	f0f9                	bnez	s1,ffffffffc02012c0 <exit_range+0x54>
}
ffffffffc02012fc:	60a6                	ld	ra,72(sp)
ffffffffc02012fe:	6406                	ld	s0,64(sp)
ffffffffc0201300:	74e2                	ld	s1,56(sp)
ffffffffc0201302:	7942                	ld	s2,48(sp)
ffffffffc0201304:	79a2                	ld	s3,40(sp)
ffffffffc0201306:	7a02                	ld	s4,32(sp)
ffffffffc0201308:	6ae2                	ld	s5,24(sp)
ffffffffc020130a:	6b42                	ld	s6,16(sp)
ffffffffc020130c:	6ba2                	ld	s7,8(sp)
ffffffffc020130e:	6161                	addi	sp,sp,80
ffffffffc0201310:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201312:	00004617          	auipc	a2,0x4
ffffffffc0201316:	2f660613          	addi	a2,a2,758 # ffffffffc0205608 <commands+0x6e0>
ffffffffc020131a:	06200593          	li	a1,98
ffffffffc020131e:	00004517          	auipc	a0,0x4
ffffffffc0201322:	30a50513          	addi	a0,a0,778 # ffffffffc0205628 <commands+0x700>
ffffffffc0201326:	edbfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020132a:	00004697          	auipc	a3,0x4
ffffffffc020132e:	3f668693          	addi	a3,a3,1014 # ffffffffc0205720 <commands+0x7f8>
ffffffffc0201332:	00004617          	auipc	a2,0x4
ffffffffc0201336:	fe660613          	addi	a2,a2,-26 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020133a:	15200593          	li	a1,338
ffffffffc020133e:	00004517          	auipc	a0,0x4
ffffffffc0201342:	37a50513          	addi	a0,a0,890 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201346:	ebbfe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020134a:	00004697          	auipc	a3,0x4
ffffffffc020134e:	3a668693          	addi	a3,a3,934 # ffffffffc02056f0 <commands+0x7c8>
ffffffffc0201352:	00004617          	auipc	a2,0x4
ffffffffc0201356:	fc660613          	addi	a2,a2,-58 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020135a:	15100593          	li	a1,337
ffffffffc020135e:	00004517          	auipc	a0,0x4
ffffffffc0201362:	35a50513          	addi	a0,a0,858 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201366:	e9bfe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020136a <page_insert>:
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc020136a:	7179                	addi	sp,sp,-48
ffffffffc020136c:	e44e                	sd	s3,8(sp)
ffffffffc020136e:	89b2                	mv	s3,a2
ffffffffc0201370:	f022                	sd	s0,32(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0201372:	4605                	li	a2,1
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0201374:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0201376:	85ce                	mv	a1,s3
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc0201378:	ec26                	sd	s1,24(sp)
ffffffffc020137a:	f406                	sd	ra,40(sp)
ffffffffc020137c:	e84a                	sd	s2,16(sp)
ffffffffc020137e:	e052                	sd	s4,0(sp)
ffffffffc0201380:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0201382:	c03ff0ef          	jal	ra,ffffffffc0200f84 <get_pte>
    if (ptep == NULL) {
ffffffffc0201386:	cd41                	beqz	a0,ffffffffc020141e <page_insert+0xb4>
    page->ref += 1;
ffffffffc0201388:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V) {
ffffffffc020138a:	611c                	ld	a5,0(a0)
ffffffffc020138c:	892a                	mv	s2,a0
ffffffffc020138e:	0016871b          	addiw	a4,a3,1
ffffffffc0201392:	c018                	sw	a4,0(s0)
ffffffffc0201394:	0017f713          	andi	a4,a5,1
ffffffffc0201398:	eb1d                	bnez	a4,ffffffffc02013ce <page_insert+0x64>
ffffffffc020139a:	00052717          	auipc	a4,0x52
ffffffffc020139e:	15673703          	ld	a4,342(a4) # ffffffffc02534f0 <pages>
    return page - pages + nbase;
ffffffffc02013a2:	8c19                	sub	s0,s0,a4
ffffffffc02013a4:	000807b7          	lui	a5,0x80
ffffffffc02013a8:	8419                	srai	s0,s0,0x6
ffffffffc02013aa:	943e                	add	s0,s0,a5
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02013ac:	042a                	slli	s0,s0,0xa
ffffffffc02013ae:	8c45                	or	s0,s0,s1
ffffffffc02013b0:	00146413          	ori	s0,s0,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02013b4:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd2ca00>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02013b8:	12098073          	sfence.vma	s3
    return 0;
ffffffffc02013bc:	4501                	li	a0,0
}
ffffffffc02013be:	70a2                	ld	ra,40(sp)
ffffffffc02013c0:	7402                	ld	s0,32(sp)
ffffffffc02013c2:	64e2                	ld	s1,24(sp)
ffffffffc02013c4:	6942                	ld	s2,16(sp)
ffffffffc02013c6:	69a2                	ld	s3,8(sp)
ffffffffc02013c8:	6a02                	ld	s4,0(sp)
ffffffffc02013ca:	6145                	addi	sp,sp,48
ffffffffc02013cc:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02013ce:	078a                	slli	a5,a5,0x2
ffffffffc02013d0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc02013d2:	00052717          	auipc	a4,0x52
ffffffffc02013d6:	0a673703          	ld	a4,166(a4) # ffffffffc0253478 <npage>
ffffffffc02013da:	04e7f463          	bgeu	a5,a4,ffffffffc0201422 <page_insert+0xb8>
    return &pages[PPN(pa) - nbase];
ffffffffc02013de:	00052a17          	auipc	s4,0x52
ffffffffc02013e2:	112a0a13          	addi	s4,s4,274 # ffffffffc02534f0 <pages>
ffffffffc02013e6:	000a3703          	ld	a4,0(s4)
ffffffffc02013ea:	fff80537          	lui	a0,0xfff80
ffffffffc02013ee:	97aa                	add	a5,a5,a0
ffffffffc02013f0:	079a                	slli	a5,a5,0x6
ffffffffc02013f2:	97ba                	add	a5,a5,a4
        if (p == page) {
ffffffffc02013f4:	00f40a63          	beq	s0,a5,ffffffffc0201408 <page_insert+0x9e>
    page->ref -= 1;
ffffffffc02013f8:	4394                	lw	a3,0(a5)
ffffffffc02013fa:	fff6861b          	addiw	a2,a3,-1
ffffffffc02013fe:	c390                	sw	a2,0(a5)
        if (page_ref(page) ==
ffffffffc0201400:	c611                	beqz	a2,ffffffffc020140c <page_insert+0xa2>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0201402:	12098073          	sfence.vma	s3
}
ffffffffc0201406:	bf71                	j	ffffffffc02013a2 <page_insert+0x38>
ffffffffc0201408:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc020140a:	bf61                	j	ffffffffc02013a2 <page_insert+0x38>
            free_page(page);
ffffffffc020140c:	4585                	li	a1,1
ffffffffc020140e:	853e                	mv	a0,a5
ffffffffc0201410:	9a1ff0ef          	jal	ra,ffffffffc0200db0 <free_pages>
ffffffffc0201414:	000a3703          	ld	a4,0(s4)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0201418:	12098073          	sfence.vma	s3
ffffffffc020141c:	b759                	j	ffffffffc02013a2 <page_insert+0x38>
        return -E_NO_MEM;
ffffffffc020141e:	5571                	li	a0,-4
ffffffffc0201420:	bf79                	j	ffffffffc02013be <page_insert+0x54>
ffffffffc0201422:	8e1ff0ef          	jal	ra,ffffffffc0200d02 <pa2page.part.0>

ffffffffc0201426 <copy_range>:
               bool share) {
ffffffffc0201426:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201428:	00d667b3          	or	a5,a2,a3
               bool share) {
ffffffffc020142c:	f486                	sd	ra,104(sp)
ffffffffc020142e:	f0a2                	sd	s0,96(sp)
ffffffffc0201430:	eca6                	sd	s1,88(sp)
ffffffffc0201432:	e8ca                	sd	s2,80(sp)
ffffffffc0201434:	e4ce                	sd	s3,72(sp)
ffffffffc0201436:	e0d2                	sd	s4,64(sp)
ffffffffc0201438:	fc56                	sd	s5,56(sp)
ffffffffc020143a:	f85a                	sd	s6,48(sp)
ffffffffc020143c:	f45e                	sd	s7,40(sp)
ffffffffc020143e:	f062                	sd	s8,32(sp)
ffffffffc0201440:	ec66                	sd	s9,24(sp)
ffffffffc0201442:	e86a                	sd	s10,16(sp)
ffffffffc0201444:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201446:	17d2                	slli	a5,a5,0x34
ffffffffc0201448:	1e079763          	bnez	a5,ffffffffc0201636 <copy_range+0x210>
    assert(USER_ACCESS(start, end));
ffffffffc020144c:	002007b7          	lui	a5,0x200
ffffffffc0201450:	8432                	mv	s0,a2
ffffffffc0201452:	16f66a63          	bltu	a2,a5,ffffffffc02015c6 <copy_range+0x1a0>
ffffffffc0201456:	8936                	mv	s2,a3
ffffffffc0201458:	16d67763          	bgeu	a2,a3,ffffffffc02015c6 <copy_range+0x1a0>
ffffffffc020145c:	4785                	li	a5,1
ffffffffc020145e:	07fe                	slli	a5,a5,0x1f
ffffffffc0201460:	16d7e363          	bltu	a5,a3,ffffffffc02015c6 <copy_range+0x1a0>
    return KADDR(page2pa(page));
ffffffffc0201464:	5b7d                	li	s6,-1
ffffffffc0201466:	8aaa                	mv	s5,a0
ffffffffc0201468:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc020146a:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc020146c:	00052c97          	auipc	s9,0x52
ffffffffc0201470:	00cc8c93          	addi	s9,s9,12 # ffffffffc0253478 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc0201474:	00052c17          	auipc	s8,0x52
ffffffffc0201478:	07cc0c13          	addi	s8,s8,124 # ffffffffc02534f0 <pages>
    return page - pages + nbase;
ffffffffc020147c:	00080bb7          	lui	s7,0x80
    return KADDR(page2pa(page));
ffffffffc0201480:	00cb5b13          	srli	s6,s6,0xc
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc0201484:	4601                	li	a2,0
ffffffffc0201486:	85a2                	mv	a1,s0
ffffffffc0201488:	854e                	mv	a0,s3
ffffffffc020148a:	afbff0ef          	jal	ra,ffffffffc0200f84 <get_pte>
ffffffffc020148e:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc0201490:	c175                	beqz	a0,ffffffffc0201574 <copy_range+0x14e>
        if (*ptep & PTE_V) {
ffffffffc0201492:	611c                	ld	a5,0(a0)
ffffffffc0201494:	8b85                	andi	a5,a5,1
ffffffffc0201496:	e785                	bnez	a5,ffffffffc02014be <copy_range+0x98>
        start += PGSIZE;
ffffffffc0201498:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020149a:	ff2465e3          	bltu	s0,s2,ffffffffc0201484 <copy_range+0x5e>
    return 0;
ffffffffc020149e:	4501                	li	a0,0
}
ffffffffc02014a0:	70a6                	ld	ra,104(sp)
ffffffffc02014a2:	7406                	ld	s0,96(sp)
ffffffffc02014a4:	64e6                	ld	s1,88(sp)
ffffffffc02014a6:	6946                	ld	s2,80(sp)
ffffffffc02014a8:	69a6                	ld	s3,72(sp)
ffffffffc02014aa:	6a06                	ld	s4,64(sp)
ffffffffc02014ac:	7ae2                	ld	s5,56(sp)
ffffffffc02014ae:	7b42                	ld	s6,48(sp)
ffffffffc02014b0:	7ba2                	ld	s7,40(sp)
ffffffffc02014b2:	7c02                	ld	s8,32(sp)
ffffffffc02014b4:	6ce2                	ld	s9,24(sp)
ffffffffc02014b6:	6d42                	ld	s10,16(sp)
ffffffffc02014b8:	6da2                	ld	s11,8(sp)
ffffffffc02014ba:	6165                	addi	sp,sp,112
ffffffffc02014bc:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL) {
ffffffffc02014be:	4605                	li	a2,1
ffffffffc02014c0:	85a2                	mv	a1,s0
ffffffffc02014c2:	8556                	mv	a0,s5
ffffffffc02014c4:	ac1ff0ef          	jal	ra,ffffffffc0200f84 <get_pte>
ffffffffc02014c8:	c161                	beqz	a0,ffffffffc0201588 <copy_range+0x162>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc02014ca:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V)) {
ffffffffc02014cc:	0017f713          	andi	a4,a5,1
ffffffffc02014d0:	01f7f493          	andi	s1,a5,31
ffffffffc02014d4:	14070563          	beqz	a4,ffffffffc020161e <copy_range+0x1f8>
    if (PPN(pa) >= npage) {
ffffffffc02014d8:	000cb683          	ld	a3,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc02014dc:	078a                	slli	a5,a5,0x2
ffffffffc02014de:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc02014e2:	12d77263          	bgeu	a4,a3,ffffffffc0201606 <copy_range+0x1e0>
    return &pages[PPN(pa) - nbase];
ffffffffc02014e6:	000c3783          	ld	a5,0(s8)
ffffffffc02014ea:	fff806b7          	lui	a3,0xfff80
ffffffffc02014ee:	9736                	add	a4,a4,a3
ffffffffc02014f0:	071a                	slli	a4,a4,0x6
            struct Page *npage = alloc_page();
ffffffffc02014f2:	4505                	li	a0,1
ffffffffc02014f4:	00e78db3          	add	s11,a5,a4
ffffffffc02014f8:	827ff0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02014fc:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc02014fe:	0a0d8463          	beqz	s11,ffffffffc02015a6 <copy_range+0x180>
            assert(npage != NULL);
ffffffffc0201502:	c175                	beqz	a0,ffffffffc02015e6 <copy_range+0x1c0>
    return page - pages + nbase;
ffffffffc0201504:	000c3703          	ld	a4,0(s8)
    return KADDR(page2pa(page));
ffffffffc0201508:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc020150c:	40ed86b3          	sub	a3,s11,a4
ffffffffc0201510:	8699                	srai	a3,a3,0x6
ffffffffc0201512:	96de                	add	a3,a3,s7
    return KADDR(page2pa(page));
ffffffffc0201514:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0201518:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020151a:	06c7fa63          	bgeu	a5,a2,ffffffffc020158e <copy_range+0x168>
    return page - pages + nbase;
ffffffffc020151e:	40e507b3          	sub	a5,a0,a4
    return KADDR(page2pa(page));
ffffffffc0201522:	00052717          	auipc	a4,0x52
ffffffffc0201526:	fbe70713          	addi	a4,a4,-66 # ffffffffc02534e0 <va_pa_offset>
ffffffffc020152a:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc020152c:	8799                	srai	a5,a5,0x6
ffffffffc020152e:	97de                	add	a5,a5,s7
    return KADDR(page2pa(page));
ffffffffc0201530:	0167f733          	and	a4,a5,s6
ffffffffc0201534:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc0201538:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc020153a:	04c77963          	bgeu	a4,a2,ffffffffc020158c <copy_range+0x166>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc020153e:	6605                	lui	a2,0x1
ffffffffc0201540:	953e                	add	a0,a0,a5
ffffffffc0201542:	326030ef          	jal	ra,ffffffffc0204868 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc0201546:	86a6                	mv	a3,s1
ffffffffc0201548:	8622                	mv	a2,s0
ffffffffc020154a:	85ea                	mv	a1,s10
ffffffffc020154c:	8556                	mv	a0,s5
ffffffffc020154e:	e1dff0ef          	jal	ra,ffffffffc020136a <page_insert>
            assert(ret == 0);
ffffffffc0201552:	d139                	beqz	a0,ffffffffc0201498 <copy_range+0x72>
ffffffffc0201554:	00004697          	auipc	a3,0x4
ffffffffc0201558:	22c68693          	addi	a3,a3,556 # ffffffffc0205780 <commands+0x858>
ffffffffc020155c:	00004617          	auipc	a2,0x4
ffffffffc0201560:	dbc60613          	addi	a2,a2,-580 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201564:	19900593          	li	a1,409
ffffffffc0201568:	00004517          	auipc	a0,0x4
ffffffffc020156c:	15050513          	addi	a0,a0,336 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201570:	c91fe0ef          	jal	ra,ffffffffc0200200 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0201574:	00200637          	lui	a2,0x200
ffffffffc0201578:	9432                	add	s0,s0,a2
ffffffffc020157a:	ffe00637          	lui	a2,0xffe00
ffffffffc020157e:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc0201580:	dc19                	beqz	s0,ffffffffc020149e <copy_range+0x78>
ffffffffc0201582:	f12461e3          	bltu	s0,s2,ffffffffc0201484 <copy_range+0x5e>
ffffffffc0201586:	bf21                	j	ffffffffc020149e <copy_range+0x78>
                return -E_NO_MEM;
ffffffffc0201588:	5571                	li	a0,-4
ffffffffc020158a:	bf19                	j	ffffffffc02014a0 <copy_range+0x7a>
ffffffffc020158c:	86be                	mv	a3,a5
ffffffffc020158e:	00004617          	auipc	a2,0x4
ffffffffc0201592:	13a60613          	addi	a2,a2,314 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0201596:	06900593          	li	a1,105
ffffffffc020159a:	00004517          	auipc	a0,0x4
ffffffffc020159e:	08e50513          	addi	a0,a0,142 # ffffffffc0205628 <commands+0x700>
ffffffffc02015a2:	c5ffe0ef          	jal	ra,ffffffffc0200200 <__panic>
            assert(page != NULL);
ffffffffc02015a6:	00004697          	auipc	a3,0x4
ffffffffc02015aa:	1ba68693          	addi	a3,a3,442 # ffffffffc0205760 <commands+0x838>
ffffffffc02015ae:	00004617          	auipc	a2,0x4
ffffffffc02015b2:	d6a60613          	addi	a2,a2,-662 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02015b6:	17e00593          	li	a1,382
ffffffffc02015ba:	00004517          	auipc	a0,0x4
ffffffffc02015be:	0fe50513          	addi	a0,a0,254 # ffffffffc02056b8 <commands+0x790>
ffffffffc02015c2:	c3ffe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02015c6:	00004697          	auipc	a3,0x4
ffffffffc02015ca:	15a68693          	addi	a3,a3,346 # ffffffffc0205720 <commands+0x7f8>
ffffffffc02015ce:	00004617          	auipc	a2,0x4
ffffffffc02015d2:	d4a60613          	addi	a2,a2,-694 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02015d6:	16a00593          	li	a1,362
ffffffffc02015da:	00004517          	auipc	a0,0x4
ffffffffc02015de:	0de50513          	addi	a0,a0,222 # ffffffffc02056b8 <commands+0x790>
ffffffffc02015e2:	c1ffe0ef          	jal	ra,ffffffffc0200200 <__panic>
            assert(npage != NULL);
ffffffffc02015e6:	00004697          	auipc	a3,0x4
ffffffffc02015ea:	18a68693          	addi	a3,a3,394 # ffffffffc0205770 <commands+0x848>
ffffffffc02015ee:	00004617          	auipc	a2,0x4
ffffffffc02015f2:	d2a60613          	addi	a2,a2,-726 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02015f6:	17f00593          	li	a1,383
ffffffffc02015fa:	00004517          	auipc	a0,0x4
ffffffffc02015fe:	0be50513          	addi	a0,a0,190 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201602:	bfffe0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0201606:	00004617          	auipc	a2,0x4
ffffffffc020160a:	00260613          	addi	a2,a2,2 # ffffffffc0205608 <commands+0x6e0>
ffffffffc020160e:	06200593          	li	a1,98
ffffffffc0201612:	00004517          	auipc	a0,0x4
ffffffffc0201616:	01650513          	addi	a0,a0,22 # ffffffffc0205628 <commands+0x700>
ffffffffc020161a:	be7fe0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc020161e:	00004617          	auipc	a2,0x4
ffffffffc0201622:	11a60613          	addi	a2,a2,282 # ffffffffc0205738 <commands+0x810>
ffffffffc0201626:	07400593          	li	a1,116
ffffffffc020162a:	00004517          	auipc	a0,0x4
ffffffffc020162e:	ffe50513          	addi	a0,a0,-2 # ffffffffc0205628 <commands+0x700>
ffffffffc0201632:	bcffe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0201636:	00004697          	auipc	a3,0x4
ffffffffc020163a:	0ba68693          	addi	a3,a3,186 # ffffffffc02056f0 <commands+0x7c8>
ffffffffc020163e:	00004617          	auipc	a2,0x4
ffffffffc0201642:	cda60613          	addi	a2,a2,-806 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201646:	16900593          	li	a1,361
ffffffffc020164a:	00004517          	auipc	a0,0x4
ffffffffc020164e:	06e50513          	addi	a0,a0,110 # ffffffffc02056b8 <commands+0x790>
ffffffffc0201652:	baffe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201656 <tlb_invalidate>:
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0201656:	12058073          	sfence.vma	a1
}
ffffffffc020165a:	8082                	ret

ffffffffc020165c <pgdir_alloc_page>:

// pgdir_alloc_page - call alloc_page & page_insert functions to
//                  - allocate a page size memory & setup an addr map
//                  - pa<->la with linear address la and the PDT pgdir
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc020165c:	7179                	addi	sp,sp,-48
ffffffffc020165e:	e84a                	sd	s2,16(sp)
ffffffffc0201660:	892a                	mv	s2,a0
    struct Page *page = alloc_page();
ffffffffc0201662:	4505                	li	a0,1
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0201664:	f022                	sd	s0,32(sp)
ffffffffc0201666:	ec26                	sd	s1,24(sp)
ffffffffc0201668:	e44e                	sd	s3,8(sp)
ffffffffc020166a:	f406                	sd	ra,40(sp)
ffffffffc020166c:	84ae                	mv	s1,a1
ffffffffc020166e:	89b2                	mv	s3,a2
    struct Page *page = alloc_page();
ffffffffc0201670:	eaeff0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0201674:	842a                	mv	s0,a0
    if (page != NULL) {
ffffffffc0201676:	cd05                	beqz	a0,ffffffffc02016ae <pgdir_alloc_page+0x52>
        if (page_insert(pgdir, page, la, perm) != 0) {
ffffffffc0201678:	85aa                	mv	a1,a0
ffffffffc020167a:	86ce                	mv	a3,s3
ffffffffc020167c:	8626                	mv	a2,s1
ffffffffc020167e:	854a                	mv	a0,s2
ffffffffc0201680:	cebff0ef          	jal	ra,ffffffffc020136a <page_insert>
ffffffffc0201684:	ed0d                	bnez	a0,ffffffffc02016be <pgdir_alloc_page+0x62>
            free_page(page);
            return NULL;
        }
        if (swap_init_ok) {
ffffffffc0201686:	00052797          	auipc	a5,0x52
ffffffffc020168a:	e127a783          	lw	a5,-494(a5) # ffffffffc0253498 <swap_init_ok>
ffffffffc020168e:	c385                	beqz	a5,ffffffffc02016ae <pgdir_alloc_page+0x52>
            if (check_mm_struct != NULL) {
ffffffffc0201690:	00052517          	auipc	a0,0x52
ffffffffc0201694:	e7853503          	ld	a0,-392(a0) # ffffffffc0253508 <check_mm_struct>
ffffffffc0201698:	c919                	beqz	a0,ffffffffc02016ae <pgdir_alloc_page+0x52>
                swap_map_swappable(check_mm_struct, la, page, 0);
ffffffffc020169a:	4681                	li	a3,0
ffffffffc020169c:	8622                	mv	a2,s0
ffffffffc020169e:	85a6                	mv	a1,s1
ffffffffc02016a0:	599000ef          	jal	ra,ffffffffc0202438 <swap_map_swappable>
                page->pra_vaddr = la;
                assert(page_ref(page) == 1);
ffffffffc02016a4:	4018                	lw	a4,0(s0)
                page->pra_vaddr = la;
ffffffffc02016a6:	fc04                	sd	s1,56(s0)
                assert(page_ref(page) == 1);
ffffffffc02016a8:	4785                	li	a5,1
ffffffffc02016aa:	02f71063          	bne	a4,a5,ffffffffc02016ca <pgdir_alloc_page+0x6e>
            }
        }
    }

    return page;
}
ffffffffc02016ae:	70a2                	ld	ra,40(sp)
ffffffffc02016b0:	8522                	mv	a0,s0
ffffffffc02016b2:	7402                	ld	s0,32(sp)
ffffffffc02016b4:	64e2                	ld	s1,24(sp)
ffffffffc02016b6:	6942                	ld	s2,16(sp)
ffffffffc02016b8:	69a2                	ld	s3,8(sp)
ffffffffc02016ba:	6145                	addi	sp,sp,48
ffffffffc02016bc:	8082                	ret
            free_page(page);
ffffffffc02016be:	8522                	mv	a0,s0
ffffffffc02016c0:	4585                	li	a1,1
ffffffffc02016c2:	eeeff0ef          	jal	ra,ffffffffc0200db0 <free_pages>
            return NULL;
ffffffffc02016c6:	4401                	li	s0,0
ffffffffc02016c8:	b7dd                	j	ffffffffc02016ae <pgdir_alloc_page+0x52>
                assert(page_ref(page) == 1);
ffffffffc02016ca:	00004697          	auipc	a3,0x4
ffffffffc02016ce:	0c668693          	addi	a3,a3,198 # ffffffffc0205790 <commands+0x868>
ffffffffc02016d2:	00004617          	auipc	a2,0x4
ffffffffc02016d6:	c4660613          	addi	a2,a2,-954 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02016da:	1d800593          	li	a1,472
ffffffffc02016de:	00004517          	auipc	a0,0x4
ffffffffc02016e2:	fda50513          	addi	a0,a0,-38 # ffffffffc02056b8 <commands+0x790>
ffffffffc02016e6:	b1bfe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02016ea <_fifo_init_mm>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc02016ea:	00052797          	auipc	a5,0x52
ffffffffc02016ee:	e0e78793          	addi	a5,a5,-498 # ffffffffc02534f8 <pra_list_head>
 */
static int
_fifo_init_mm(struct mm_struct *mm)
{     
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
ffffffffc02016f2:	f51c                	sd	a5,40(a0)
ffffffffc02016f4:	e79c                	sd	a5,8(a5)
ffffffffc02016f6:	e39c                	sd	a5,0(a5)
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}
ffffffffc02016f8:	4501                	li	a0,0
ffffffffc02016fa:	8082                	ret

ffffffffc02016fc <_fifo_init>:

static int
_fifo_init(void)
{
    return 0;
}
ffffffffc02016fc:	4501                	li	a0,0
ffffffffc02016fe:	8082                	ret

ffffffffc0201700 <_fifo_set_unswappable>:

static int
_fifo_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}
ffffffffc0201700:	4501                	li	a0,0
ffffffffc0201702:	8082                	ret

ffffffffc0201704 <_fifo_tick_event>:

static int
_fifo_tick_event(struct mm_struct *mm)
{ return 0; }
ffffffffc0201704:	4501                	li	a0,0
ffffffffc0201706:	8082                	ret

ffffffffc0201708 <_fifo_check_swap>:
_fifo_check_swap(void) {
ffffffffc0201708:	711d                	addi	sp,sp,-96
ffffffffc020170a:	fc4e                	sd	s3,56(sp)
ffffffffc020170c:	f852                	sd	s4,48(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020170e:	00004517          	auipc	a0,0x4
ffffffffc0201712:	09a50513          	addi	a0,a0,154 # ffffffffc02057a8 <commands+0x880>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201716:	698d                	lui	s3,0x3
ffffffffc0201718:	4a31                	li	s4,12
_fifo_check_swap(void) {
ffffffffc020171a:	e0ca                	sd	s2,64(sp)
ffffffffc020171c:	ec86                	sd	ra,88(sp)
ffffffffc020171e:	e8a2                	sd	s0,80(sp)
ffffffffc0201720:	e4a6                	sd	s1,72(sp)
ffffffffc0201722:	f456                	sd	s5,40(sp)
ffffffffc0201724:	f05a                	sd	s6,32(sp)
ffffffffc0201726:	ec5e                	sd	s7,24(sp)
ffffffffc0201728:	e862                	sd	s8,16(sp)
ffffffffc020172a:	e466                	sd	s9,8(sp)
ffffffffc020172c:	e06a                	sd	s10,0(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020172e:	997fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201732:	01498023          	sb	s4,0(s3) # 3000 <_binary_obj___user_ex1_out_size-0x6958>
    assert(pgfault_num==4);
ffffffffc0201736:	00052917          	auipc	s2,0x52
ffffffffc020173a:	d4a92903          	lw	s2,-694(s2) # ffffffffc0253480 <pgfault_num>
ffffffffc020173e:	4791                	li	a5,4
ffffffffc0201740:	14f91e63          	bne	s2,a5,ffffffffc020189c <_fifo_check_swap+0x194>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201744:	00004517          	auipc	a0,0x4
ffffffffc0201748:	0b450513          	addi	a0,a0,180 # ffffffffc02057f8 <commands+0x8d0>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020174c:	6a85                	lui	s5,0x1
ffffffffc020174e:	4b29                	li	s6,10
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201750:	975fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc0201754:	00052417          	auipc	s0,0x52
ffffffffc0201758:	d2c40413          	addi	s0,s0,-724 # ffffffffc0253480 <pgfault_num>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc020175c:	016a8023          	sb	s6,0(s5) # 1000 <_binary_obj___user_ex1_out_size-0x8958>
    assert(pgfault_num==4);
ffffffffc0201760:	4004                	lw	s1,0(s0)
ffffffffc0201762:	2481                	sext.w	s1,s1
ffffffffc0201764:	2b249c63          	bne	s1,s2,ffffffffc0201a1c <_fifo_check_swap+0x314>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0201768:	00004517          	auipc	a0,0x4
ffffffffc020176c:	0b850513          	addi	a0,a0,184 # ffffffffc0205820 <commands+0x8f8>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0201770:	6b91                	lui	s7,0x4
ffffffffc0201772:	4c35                	li	s8,13
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0201774:	951fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0201778:	018b8023          	sb	s8,0(s7) # 4000 <_binary_obj___user_ex1_out_size-0x5958>
    assert(pgfault_num==4);
ffffffffc020177c:	00042903          	lw	s2,0(s0)
ffffffffc0201780:	2901                	sext.w	s2,s2
ffffffffc0201782:	26991d63          	bne	s2,s1,ffffffffc02019fc <_fifo_check_swap+0x2f4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201786:	00004517          	auipc	a0,0x4
ffffffffc020178a:	0c250513          	addi	a0,a0,194 # ffffffffc0205848 <commands+0x920>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc020178e:	6c89                	lui	s9,0x2
ffffffffc0201790:	4d2d                	li	s10,11
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201792:	933fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201796:	01ac8023          	sb	s10,0(s9) # 2000 <_binary_obj___user_ex1_out_size-0x7958>
    assert(pgfault_num==4);
ffffffffc020179a:	401c                	lw	a5,0(s0)
ffffffffc020179c:	2781                	sext.w	a5,a5
ffffffffc020179e:	23279f63          	bne	a5,s2,ffffffffc02019dc <_fifo_check_swap+0x2d4>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc02017a2:	00004517          	auipc	a0,0x4
ffffffffc02017a6:	0ce50513          	addi	a0,a0,206 # ffffffffc0205870 <commands+0x948>
ffffffffc02017aa:	91bfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc02017ae:	6795                	lui	a5,0x5
ffffffffc02017b0:	4739                	li	a4,14
ffffffffc02017b2:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex1_out_size-0x4958>
    assert(pgfault_num==5);
ffffffffc02017b6:	4004                	lw	s1,0(s0)
ffffffffc02017b8:	4795                	li	a5,5
ffffffffc02017ba:	2481                	sext.w	s1,s1
ffffffffc02017bc:	20f49063          	bne	s1,a5,ffffffffc02019bc <_fifo_check_swap+0x2b4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02017c0:	00004517          	auipc	a0,0x4
ffffffffc02017c4:	08850513          	addi	a0,a0,136 # ffffffffc0205848 <commands+0x920>
ffffffffc02017c8:	8fdfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02017cc:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==5);
ffffffffc02017d0:	401c                	lw	a5,0(s0)
ffffffffc02017d2:	2781                	sext.w	a5,a5
ffffffffc02017d4:	1c979463          	bne	a5,s1,ffffffffc020199c <_fifo_check_swap+0x294>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc02017d8:	00004517          	auipc	a0,0x4
ffffffffc02017dc:	02050513          	addi	a0,a0,32 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc02017e0:	8e5fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc02017e4:	016a8023          	sb	s6,0(s5)
    assert(pgfault_num==6);
ffffffffc02017e8:	401c                	lw	a5,0(s0)
ffffffffc02017ea:	4719                	li	a4,6
ffffffffc02017ec:	2781                	sext.w	a5,a5
ffffffffc02017ee:	18e79763          	bne	a5,a4,ffffffffc020197c <_fifo_check_swap+0x274>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02017f2:	00004517          	auipc	a0,0x4
ffffffffc02017f6:	05650513          	addi	a0,a0,86 # ffffffffc0205848 <commands+0x920>
ffffffffc02017fa:	8cbfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02017fe:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==7);
ffffffffc0201802:	401c                	lw	a5,0(s0)
ffffffffc0201804:	471d                	li	a4,7
ffffffffc0201806:	2781                	sext.w	a5,a5
ffffffffc0201808:	14e79a63          	bne	a5,a4,ffffffffc020195c <_fifo_check_swap+0x254>
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc020180c:	00004517          	auipc	a0,0x4
ffffffffc0201810:	f9c50513          	addi	a0,a0,-100 # ffffffffc02057a8 <commands+0x880>
ffffffffc0201814:	8b1fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201818:	01498023          	sb	s4,0(s3)
    assert(pgfault_num==8);
ffffffffc020181c:	401c                	lw	a5,0(s0)
ffffffffc020181e:	4721                	li	a4,8
ffffffffc0201820:	2781                	sext.w	a5,a5
ffffffffc0201822:	10e79d63          	bne	a5,a4,ffffffffc020193c <_fifo_check_swap+0x234>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc0201826:	00004517          	auipc	a0,0x4
ffffffffc020182a:	ffa50513          	addi	a0,a0,-6 # ffffffffc0205820 <commands+0x8f8>
ffffffffc020182e:	897fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0201832:	018b8023          	sb	s8,0(s7)
    assert(pgfault_num==9);
ffffffffc0201836:	401c                	lw	a5,0(s0)
ffffffffc0201838:	4725                	li	a4,9
ffffffffc020183a:	2781                	sext.w	a5,a5
ffffffffc020183c:	0ee79063          	bne	a5,a4,ffffffffc020191c <_fifo_check_swap+0x214>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc0201840:	00004517          	auipc	a0,0x4
ffffffffc0201844:	03050513          	addi	a0,a0,48 # ffffffffc0205870 <commands+0x948>
ffffffffc0201848:	87dfe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc020184c:	6795                	lui	a5,0x5
ffffffffc020184e:	4739                	li	a4,14
ffffffffc0201850:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_ex1_out_size-0x4958>
    assert(pgfault_num==10);
ffffffffc0201854:	4004                	lw	s1,0(s0)
ffffffffc0201856:	47a9                	li	a5,10
ffffffffc0201858:	2481                	sext.w	s1,s1
ffffffffc020185a:	0af49163          	bne	s1,a5,ffffffffc02018fc <_fifo_check_swap+0x1f4>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020185e:	00004517          	auipc	a0,0x4
ffffffffc0201862:	f9a50513          	addi	a0,a0,-102 # ffffffffc02057f8 <commands+0x8d0>
ffffffffc0201866:	85ffe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020186a:	6785                	lui	a5,0x1
ffffffffc020186c:	0007c783          	lbu	a5,0(a5) # 1000 <_binary_obj___user_ex1_out_size-0x8958>
ffffffffc0201870:	06979663          	bne	a5,s1,ffffffffc02018dc <_fifo_check_swap+0x1d4>
    assert(pgfault_num==11);
ffffffffc0201874:	401c                	lw	a5,0(s0)
ffffffffc0201876:	472d                	li	a4,11
ffffffffc0201878:	2781                	sext.w	a5,a5
ffffffffc020187a:	04e79163          	bne	a5,a4,ffffffffc02018bc <_fifo_check_swap+0x1b4>
}
ffffffffc020187e:	60e6                	ld	ra,88(sp)
ffffffffc0201880:	6446                	ld	s0,80(sp)
ffffffffc0201882:	64a6                	ld	s1,72(sp)
ffffffffc0201884:	6906                	ld	s2,64(sp)
ffffffffc0201886:	79e2                	ld	s3,56(sp)
ffffffffc0201888:	7a42                	ld	s4,48(sp)
ffffffffc020188a:	7aa2                	ld	s5,40(sp)
ffffffffc020188c:	7b02                	ld	s6,32(sp)
ffffffffc020188e:	6be2                	ld	s7,24(sp)
ffffffffc0201890:	6c42                	ld	s8,16(sp)
ffffffffc0201892:	6ca2                	ld	s9,8(sp)
ffffffffc0201894:	6d02                	ld	s10,0(sp)
ffffffffc0201896:	4501                	li	a0,0
ffffffffc0201898:	6125                	addi	sp,sp,96
ffffffffc020189a:	8082                	ret
    assert(pgfault_num==4);
ffffffffc020189c:	00004697          	auipc	a3,0x4
ffffffffc02018a0:	f3468693          	addi	a3,a3,-204 # ffffffffc02057d0 <commands+0x8a8>
ffffffffc02018a4:	00004617          	auipc	a2,0x4
ffffffffc02018a8:	a7460613          	addi	a2,a2,-1420 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02018ac:	05100593          	li	a1,81
ffffffffc02018b0:	00004517          	auipc	a0,0x4
ffffffffc02018b4:	f3050513          	addi	a0,a0,-208 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02018b8:	949fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==11);
ffffffffc02018bc:	00004697          	auipc	a3,0x4
ffffffffc02018c0:	06468693          	addi	a3,a3,100 # ffffffffc0205920 <commands+0x9f8>
ffffffffc02018c4:	00004617          	auipc	a2,0x4
ffffffffc02018c8:	a5460613          	addi	a2,a2,-1452 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02018cc:	07300593          	li	a1,115
ffffffffc02018d0:	00004517          	auipc	a0,0x4
ffffffffc02018d4:	f1050513          	addi	a0,a0,-240 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02018d8:	929fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc02018dc:	00004697          	auipc	a3,0x4
ffffffffc02018e0:	01c68693          	addi	a3,a3,28 # ffffffffc02058f8 <commands+0x9d0>
ffffffffc02018e4:	00004617          	auipc	a2,0x4
ffffffffc02018e8:	a3460613          	addi	a2,a2,-1484 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02018ec:	07100593          	li	a1,113
ffffffffc02018f0:	00004517          	auipc	a0,0x4
ffffffffc02018f4:	ef050513          	addi	a0,a0,-272 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02018f8:	909fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==10);
ffffffffc02018fc:	00004697          	auipc	a3,0x4
ffffffffc0201900:	fec68693          	addi	a3,a3,-20 # ffffffffc02058e8 <commands+0x9c0>
ffffffffc0201904:	00004617          	auipc	a2,0x4
ffffffffc0201908:	a1460613          	addi	a2,a2,-1516 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020190c:	06f00593          	li	a1,111
ffffffffc0201910:	00004517          	auipc	a0,0x4
ffffffffc0201914:	ed050513          	addi	a0,a0,-304 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201918:	8e9fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==9);
ffffffffc020191c:	00004697          	auipc	a3,0x4
ffffffffc0201920:	fbc68693          	addi	a3,a3,-68 # ffffffffc02058d8 <commands+0x9b0>
ffffffffc0201924:	00004617          	auipc	a2,0x4
ffffffffc0201928:	9f460613          	addi	a2,a2,-1548 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020192c:	06c00593          	li	a1,108
ffffffffc0201930:	00004517          	auipc	a0,0x4
ffffffffc0201934:	eb050513          	addi	a0,a0,-336 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201938:	8c9fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==8);
ffffffffc020193c:	00004697          	auipc	a3,0x4
ffffffffc0201940:	f8c68693          	addi	a3,a3,-116 # ffffffffc02058c8 <commands+0x9a0>
ffffffffc0201944:	00004617          	auipc	a2,0x4
ffffffffc0201948:	9d460613          	addi	a2,a2,-1580 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020194c:	06900593          	li	a1,105
ffffffffc0201950:	00004517          	auipc	a0,0x4
ffffffffc0201954:	e9050513          	addi	a0,a0,-368 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201958:	8a9fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==7);
ffffffffc020195c:	00004697          	auipc	a3,0x4
ffffffffc0201960:	f5c68693          	addi	a3,a3,-164 # ffffffffc02058b8 <commands+0x990>
ffffffffc0201964:	00004617          	auipc	a2,0x4
ffffffffc0201968:	9b460613          	addi	a2,a2,-1612 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020196c:	06600593          	li	a1,102
ffffffffc0201970:	00004517          	auipc	a0,0x4
ffffffffc0201974:	e7050513          	addi	a0,a0,-400 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201978:	889fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==6);
ffffffffc020197c:	00004697          	auipc	a3,0x4
ffffffffc0201980:	f2c68693          	addi	a3,a3,-212 # ffffffffc02058a8 <commands+0x980>
ffffffffc0201984:	00004617          	auipc	a2,0x4
ffffffffc0201988:	99460613          	addi	a2,a2,-1644 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020198c:	06300593          	li	a1,99
ffffffffc0201990:	00004517          	auipc	a0,0x4
ffffffffc0201994:	e5050513          	addi	a0,a0,-432 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201998:	869fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==5);
ffffffffc020199c:	00004697          	auipc	a3,0x4
ffffffffc02019a0:	efc68693          	addi	a3,a3,-260 # ffffffffc0205898 <commands+0x970>
ffffffffc02019a4:	00004617          	auipc	a2,0x4
ffffffffc02019a8:	97460613          	addi	a2,a2,-1676 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02019ac:	06000593          	li	a1,96
ffffffffc02019b0:	00004517          	auipc	a0,0x4
ffffffffc02019b4:	e3050513          	addi	a0,a0,-464 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02019b8:	849fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==5);
ffffffffc02019bc:	00004697          	auipc	a3,0x4
ffffffffc02019c0:	edc68693          	addi	a3,a3,-292 # ffffffffc0205898 <commands+0x970>
ffffffffc02019c4:	00004617          	auipc	a2,0x4
ffffffffc02019c8:	95460613          	addi	a2,a2,-1708 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02019cc:	05d00593          	li	a1,93
ffffffffc02019d0:	00004517          	auipc	a0,0x4
ffffffffc02019d4:	e1050513          	addi	a0,a0,-496 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02019d8:	829fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc02019dc:	00004697          	auipc	a3,0x4
ffffffffc02019e0:	df468693          	addi	a3,a3,-524 # ffffffffc02057d0 <commands+0x8a8>
ffffffffc02019e4:	00004617          	auipc	a2,0x4
ffffffffc02019e8:	93460613          	addi	a2,a2,-1740 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02019ec:	05a00593          	li	a1,90
ffffffffc02019f0:	00004517          	auipc	a0,0x4
ffffffffc02019f4:	df050513          	addi	a0,a0,-528 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc02019f8:	809fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc02019fc:	00004697          	auipc	a3,0x4
ffffffffc0201a00:	dd468693          	addi	a3,a3,-556 # ffffffffc02057d0 <commands+0x8a8>
ffffffffc0201a04:	00004617          	auipc	a2,0x4
ffffffffc0201a08:	91460613          	addi	a2,a2,-1772 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201a0c:	05700593          	li	a1,87
ffffffffc0201a10:	00004517          	auipc	a0,0x4
ffffffffc0201a14:	dd050513          	addi	a0,a0,-560 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201a18:	fe8fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgfault_num==4);
ffffffffc0201a1c:	00004697          	auipc	a3,0x4
ffffffffc0201a20:	db468693          	addi	a3,a3,-588 # ffffffffc02057d0 <commands+0x8a8>
ffffffffc0201a24:	00004617          	auipc	a2,0x4
ffffffffc0201a28:	8f460613          	addi	a2,a2,-1804 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201a2c:	05400593          	li	a1,84
ffffffffc0201a30:	00004517          	auipc	a0,0x4
ffffffffc0201a34:	db050513          	addi	a0,a0,-592 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201a38:	fc8fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201a3c <_fifo_swap_out_victim>:
     list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc0201a3c:	751c                	ld	a5,40(a0)
{
ffffffffc0201a3e:	1141                	addi	sp,sp,-16
ffffffffc0201a40:	e406                	sd	ra,8(sp)
         assert(head != NULL);
ffffffffc0201a42:	cf91                	beqz	a5,ffffffffc0201a5e <_fifo_swap_out_victim+0x22>
     assert(in_tick==0);
ffffffffc0201a44:	ee0d                	bnez	a2,ffffffffc0201a7e <_fifo_swap_out_victim+0x42>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0201a46:	679c                	ld	a5,8(a5)
}
ffffffffc0201a48:	60a2                	ld	ra,8(sp)
ffffffffc0201a4a:	4501                	li	a0,0
    __list_del(listelm->prev, listelm->next);
ffffffffc0201a4c:	6394                	ld	a3,0(a5)
ffffffffc0201a4e:	6798                	ld	a4,8(a5)
    *ptr_page = le2page(entry, pra_page_link);
ffffffffc0201a50:	fd878793          	addi	a5,a5,-40
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201a54:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc0201a56:	e314                	sd	a3,0(a4)
ffffffffc0201a58:	e19c                	sd	a5,0(a1)
}
ffffffffc0201a5a:	0141                	addi	sp,sp,16
ffffffffc0201a5c:	8082                	ret
         assert(head != NULL);
ffffffffc0201a5e:	00004697          	auipc	a3,0x4
ffffffffc0201a62:	ed268693          	addi	a3,a3,-302 # ffffffffc0205930 <commands+0xa08>
ffffffffc0201a66:	00004617          	auipc	a2,0x4
ffffffffc0201a6a:	8b260613          	addi	a2,a2,-1870 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201a6e:	04100593          	li	a1,65
ffffffffc0201a72:	00004517          	auipc	a0,0x4
ffffffffc0201a76:	d6e50513          	addi	a0,a0,-658 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201a7a:	f86fe0ef          	jal	ra,ffffffffc0200200 <__panic>
     assert(in_tick==0);
ffffffffc0201a7e:	00004697          	auipc	a3,0x4
ffffffffc0201a82:	ec268693          	addi	a3,a3,-318 # ffffffffc0205940 <commands+0xa18>
ffffffffc0201a86:	00004617          	auipc	a2,0x4
ffffffffc0201a8a:	89260613          	addi	a2,a2,-1902 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201a8e:	04200593          	li	a1,66
ffffffffc0201a92:	00004517          	auipc	a0,0x4
ffffffffc0201a96:	d4e50513          	addi	a0,a0,-690 # ffffffffc02057e0 <commands+0x8b8>
ffffffffc0201a9a:	f66fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201a9e <_fifo_map_swappable>:
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc0201a9e:	751c                	ld	a5,40(a0)
    assert(entry != NULL && head != NULL);
ffffffffc0201aa0:	cb91                	beqz	a5,ffffffffc0201ab4 <_fifo_map_swappable+0x16>
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201aa2:	6394                	ld	a3,0(a5)
ffffffffc0201aa4:	02860713          	addi	a4,a2,40
    prev->next = next->prev = elm;
ffffffffc0201aa8:	e398                	sd	a4,0(a5)
ffffffffc0201aaa:	e698                	sd	a4,8(a3)
}
ffffffffc0201aac:	4501                	li	a0,0
    elm->next = next;
ffffffffc0201aae:	fa1c                	sd	a5,48(a2)
    elm->prev = prev;
ffffffffc0201ab0:	f614                	sd	a3,40(a2)
ffffffffc0201ab2:	8082                	ret
{
ffffffffc0201ab4:	1141                	addi	sp,sp,-16
    assert(entry != NULL && head != NULL);
ffffffffc0201ab6:	00004697          	auipc	a3,0x4
ffffffffc0201aba:	e9a68693          	addi	a3,a3,-358 # ffffffffc0205950 <commands+0xa28>
ffffffffc0201abe:	00004617          	auipc	a2,0x4
ffffffffc0201ac2:	85a60613          	addi	a2,a2,-1958 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201ac6:	03200593          	li	a1,50
ffffffffc0201aca:	00004517          	auipc	a0,0x4
ffffffffc0201ace:	d1650513          	addi	a0,a0,-746 # ffffffffc02057e0 <commands+0x8b8>
{
ffffffffc0201ad2:	e406                	sd	ra,8(sp)
    assert(entry != NULL && head != NULL);
ffffffffc0201ad4:	f2cfe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201ad8 <check_vma_overlap.isra.0.part.0>:
}


// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0201ad8:	1141                	addi	sp,sp,-16
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0201ada:	00004697          	auipc	a3,0x4
ffffffffc0201ade:	eae68693          	addi	a3,a3,-338 # ffffffffc0205988 <commands+0xa60>
ffffffffc0201ae2:	00004617          	auipc	a2,0x4
ffffffffc0201ae6:	83660613          	addi	a2,a2,-1994 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201aea:	06d00593          	li	a1,109
ffffffffc0201aee:	00004517          	auipc	a0,0x4
ffffffffc0201af2:	eba50513          	addi	a0,a0,-326 # ffffffffc02059a8 <commands+0xa80>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0201af6:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc0201af8:	f08fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201afc <mm_create>:
mm_create(void) {
ffffffffc0201afc:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201afe:	04000513          	li	a0,64
mm_create(void) {
ffffffffc0201b02:	e022                	sd	s0,0(sp)
ffffffffc0201b04:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201b06:	6f8000ef          	jal	ra,ffffffffc02021fe <kmalloc>
ffffffffc0201b0a:	842a                	mv	s0,a0
    if (mm != NULL) {
ffffffffc0201b0c:	c505                	beqz	a0,ffffffffc0201b34 <mm_create+0x38>
    elm->prev = elm->next = elm;
ffffffffc0201b0e:	e408                	sd	a0,8(s0)
ffffffffc0201b10:	e008                	sd	a0,0(s0)
        mm->mmap_cache = NULL;
ffffffffc0201b12:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0201b16:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0201b1a:	02052023          	sw	zero,32(a0)
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201b1e:	00052797          	auipc	a5,0x52
ffffffffc0201b22:	97a7a783          	lw	a5,-1670(a5) # ffffffffc0253498 <swap_init_ok>
ffffffffc0201b26:	ef81                	bnez	a5,ffffffffc0201b3e <mm_create+0x42>
        else mm->sm_priv = NULL;
ffffffffc0201b28:	02053423          	sd	zero,40(a0)
    return mm->mm_count;
}

static inline void
set_mm_count(struct mm_struct *mm, int val) {
    mm->mm_count = val;
ffffffffc0201b2c:	02042823          	sw	zero,48(s0)

typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock) {
    *lock = 0;
ffffffffc0201b30:	02043c23          	sd	zero,56(s0)
}
ffffffffc0201b34:	60a2                	ld	ra,8(sp)
ffffffffc0201b36:	8522                	mv	a0,s0
ffffffffc0201b38:	6402                	ld	s0,0(sp)
ffffffffc0201b3a:	0141                	addi	sp,sp,16
ffffffffc0201b3c:	8082                	ret
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201b3e:	0ed000ef          	jal	ra,ffffffffc020242a <swap_init_mm>
ffffffffc0201b42:	b7ed                	j	ffffffffc0201b2c <mm_create+0x30>

ffffffffc0201b44 <find_vma>:
find_vma(struct mm_struct *mm, uintptr_t addr) {
ffffffffc0201b44:	86aa                	mv	a3,a0
    if (mm != NULL) {
ffffffffc0201b46:	c505                	beqz	a0,ffffffffc0201b6e <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0201b48:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0201b4a:	c501                	beqz	a0,ffffffffc0201b52 <find_vma+0xe>
ffffffffc0201b4c:	651c                	ld	a5,8(a0)
ffffffffc0201b4e:	02f5f263          	bgeu	a1,a5,ffffffffc0201b72 <find_vma+0x2e>
    return listelm->next;
ffffffffc0201b52:	669c                	ld	a5,8(a3)
                while ((le = list_next(le)) != list) {
ffffffffc0201b54:	00f68d63          	beq	a3,a5,ffffffffc0201b6e <find_vma+0x2a>
                    if (vma->vm_start<=addr && addr < vma->vm_end) {
ffffffffc0201b58:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201b5c:	00e5e663          	bltu	a1,a4,ffffffffc0201b68 <find_vma+0x24>
ffffffffc0201b60:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201b64:	00e5ec63          	bltu	a1,a4,ffffffffc0201b7c <find_vma+0x38>
ffffffffc0201b68:	679c                	ld	a5,8(a5)
                while ((le = list_next(le)) != list) {
ffffffffc0201b6a:	fef697e3          	bne	a3,a5,ffffffffc0201b58 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0201b6e:	4501                	li	a0,0
}
ffffffffc0201b70:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0201b72:	691c                	ld	a5,16(a0)
ffffffffc0201b74:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201b52 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0201b78:	ea88                	sd	a0,16(a3)
ffffffffc0201b7a:	8082                	ret
                    vma = le2vma(le, list_link);
ffffffffc0201b7c:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0201b80:	ea88                	sd	a0,16(a3)
ffffffffc0201b82:	8082                	ret

ffffffffc0201b84 <insert_vma_struct>:


// insert_vma_struct -insert vma in mm's list link
void
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201b84:	6590                	ld	a2,8(a1)
ffffffffc0201b86:	0105b803          	ld	a6,16(a1)
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
ffffffffc0201b8a:	1141                	addi	sp,sp,-16
ffffffffc0201b8c:	e406                	sd	ra,8(sp)
ffffffffc0201b8e:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201b90:	01066763          	bltu	a2,a6,ffffffffc0201b9e <insert_vma_struct+0x1a>
ffffffffc0201b94:	a085                	j	ffffffffc0201bf4 <insert_vma_struct+0x70>
    list_entry_t *le_prev = list, *le_next;

        list_entry_t *le = list;
        while ((le = list_next(le)) != list) {
            struct vma_struct *mmap_prev = le2vma(le, list_link);
            if (mmap_prev->vm_start > vma->vm_start) {
ffffffffc0201b96:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201b9a:	04e66863          	bltu	a2,a4,ffffffffc0201bea <insert_vma_struct+0x66>
ffffffffc0201b9e:	86be                	mv	a3,a5
ffffffffc0201ba0:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0201ba2:	fef51ae3          	bne	a0,a5,ffffffffc0201b96 <insert_vma_struct+0x12>
        }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list) {
ffffffffc0201ba6:	02a68463          	beq	a3,a0,ffffffffc0201bce <insert_vma_struct+0x4a>
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0201baa:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0201bae:	fe86b883          	ld	a7,-24(a3)
ffffffffc0201bb2:	08e8f163          	bgeu	a7,a4,ffffffffc0201c34 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201bb6:	04e66f63          	bltu	a2,a4,ffffffffc0201c14 <insert_vma_struct+0x90>
    }
    if (le_next != list) {
ffffffffc0201bba:	00f50a63          	beq	a0,a5,ffffffffc0201bce <insert_vma_struct+0x4a>
ffffffffc0201bbe:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201bc2:	05076963          	bltu	a4,a6,ffffffffc0201c14 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0201bc6:	ff07b603          	ld	a2,-16(a5)
ffffffffc0201bca:	02c77363          	bgeu	a4,a2,ffffffffc0201bf0 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count ++;
ffffffffc0201bce:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0201bd0:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0201bd2:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0201bd6:	e390                	sd	a2,0(a5)
ffffffffc0201bd8:	e690                	sd	a2,8(a3)
}
ffffffffc0201bda:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0201bdc:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0201bde:	f194                	sd	a3,32(a1)
    mm->map_count ++;
ffffffffc0201be0:	0017079b          	addiw	a5,a4,1
ffffffffc0201be4:	d11c                	sw	a5,32(a0)
}
ffffffffc0201be6:	0141                	addi	sp,sp,16
ffffffffc0201be8:	8082                	ret
    if (le_prev != list) {
ffffffffc0201bea:	fca690e3          	bne	a3,a0,ffffffffc0201baa <insert_vma_struct+0x26>
ffffffffc0201bee:	bfd1                	j	ffffffffc0201bc2 <insert_vma_struct+0x3e>
ffffffffc0201bf0:	ee9ff0ef          	jal	ra,ffffffffc0201ad8 <check_vma_overlap.isra.0.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201bf4:	00004697          	auipc	a3,0x4
ffffffffc0201bf8:	dc468693          	addi	a3,a3,-572 # ffffffffc02059b8 <commands+0xa90>
ffffffffc0201bfc:	00003617          	auipc	a2,0x3
ffffffffc0201c00:	71c60613          	addi	a2,a2,1820 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201c04:	07400593          	li	a1,116
ffffffffc0201c08:	00004517          	auipc	a0,0x4
ffffffffc0201c0c:	da050513          	addi	a0,a0,-608 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201c10:	df0fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201c14:	00004697          	auipc	a3,0x4
ffffffffc0201c18:	de468693          	addi	a3,a3,-540 # ffffffffc02059f8 <commands+0xad0>
ffffffffc0201c1c:	00003617          	auipc	a2,0x3
ffffffffc0201c20:	6fc60613          	addi	a2,a2,1788 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201c24:	06c00593          	li	a1,108
ffffffffc0201c28:	00004517          	auipc	a0,0x4
ffffffffc0201c2c:	d8050513          	addi	a0,a0,-640 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201c30:	dd0fe0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc0201c34:	00004697          	auipc	a3,0x4
ffffffffc0201c38:	da468693          	addi	a3,a3,-604 # ffffffffc02059d8 <commands+0xab0>
ffffffffc0201c3c:	00003617          	auipc	a2,0x3
ffffffffc0201c40:	6dc60613          	addi	a2,a2,1756 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201c44:	06b00593          	li	a1,107
ffffffffc0201c48:	00004517          	auipc	a0,0x4
ffffffffc0201c4c:	d6050513          	addi	a0,a0,-672 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201c50:	db0fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201c54 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void
mm_destroy(struct mm_struct *mm) {
    assert(mm_count(mm) == 0);
ffffffffc0201c54:	591c                	lw	a5,48(a0)
mm_destroy(struct mm_struct *mm) {
ffffffffc0201c56:	1141                	addi	sp,sp,-16
ffffffffc0201c58:	e406                	sd	ra,8(sp)
ffffffffc0201c5a:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0201c5c:	e785                	bnez	a5,ffffffffc0201c84 <mm_destroy+0x30>
ffffffffc0201c5e:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0201c60:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list) {
ffffffffc0201c62:	00a40c63          	beq	s0,a0,ffffffffc0201c7a <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0201c66:	6118                	ld	a4,0(a0)
ffffffffc0201c68:	651c                	ld	a5,8(a0)
        list_del(le);
        kfree(le2vma(le, list_link));  //kfree vma        
ffffffffc0201c6a:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0201c6c:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0201c6e:	e398                	sd	a4,0(a5)
ffffffffc0201c70:	63e000ef          	jal	ra,ffffffffc02022ae <kfree>
    return listelm->next;
ffffffffc0201c74:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list) {
ffffffffc0201c76:	fea418e3          	bne	s0,a0,ffffffffc0201c66 <mm_destroy+0x12>
    }
    kfree(mm); //kfree mm
ffffffffc0201c7a:	8522                	mv	a0,s0
    mm=NULL;
}
ffffffffc0201c7c:	6402                	ld	s0,0(sp)
ffffffffc0201c7e:	60a2                	ld	ra,8(sp)
ffffffffc0201c80:	0141                	addi	sp,sp,16
    kfree(mm); //kfree mm
ffffffffc0201c82:	a535                	j	ffffffffc02022ae <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0201c84:	00004697          	auipc	a3,0x4
ffffffffc0201c88:	d9468693          	addi	a3,a3,-620 # ffffffffc0205a18 <commands+0xaf0>
ffffffffc0201c8c:	00003617          	auipc	a2,0x3
ffffffffc0201c90:	68c60613          	addi	a2,a2,1676 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201c94:	09400593          	li	a1,148
ffffffffc0201c98:	00004517          	auipc	a0,0x4
ffffffffc0201c9c:	d1050513          	addi	a0,a0,-752 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201ca0:	d60fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201ca4 <mm_map>:

int
mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
       struct vma_struct **vma_store) {
ffffffffc0201ca4:	7139                	addi	sp,sp,-64
ffffffffc0201ca6:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0201ca8:	6405                	lui	s0,0x1
ffffffffc0201caa:	147d                	addi	s0,s0,-1
ffffffffc0201cac:	77fd                	lui	a5,0xfffff
ffffffffc0201cae:	9622                	add	a2,a2,s0
ffffffffc0201cb0:	962e                	add	a2,a2,a1
       struct vma_struct **vma_store) {
ffffffffc0201cb2:	f426                	sd	s1,40(sp)
ffffffffc0201cb4:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0201cb6:	00f5f4b3          	and	s1,a1,a5
       struct vma_struct **vma_store) {
ffffffffc0201cba:	f04a                	sd	s2,32(sp)
ffffffffc0201cbc:	ec4e                	sd	s3,24(sp)
ffffffffc0201cbe:	e852                	sd	s4,16(sp)
ffffffffc0201cc0:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end)) {
ffffffffc0201cc2:	002005b7          	lui	a1,0x200
ffffffffc0201cc6:	00f67433          	and	s0,a2,a5
ffffffffc0201cca:	06b4e363          	bltu	s1,a1,ffffffffc0201d30 <mm_map+0x8c>
ffffffffc0201cce:	0684f163          	bgeu	s1,s0,ffffffffc0201d30 <mm_map+0x8c>
ffffffffc0201cd2:	4785                	li	a5,1
ffffffffc0201cd4:	07fe                	slli	a5,a5,0x1f
ffffffffc0201cd6:	0487ed63          	bltu	a5,s0,ffffffffc0201d30 <mm_map+0x8c>
ffffffffc0201cda:	89aa                	mv	s3,a0
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0201cdc:	cd21                	beqz	a0,ffffffffc0201d34 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start) {
ffffffffc0201cde:	85a6                	mv	a1,s1
ffffffffc0201ce0:	8ab6                	mv	s5,a3
ffffffffc0201ce2:	8a3a                	mv	s4,a4
ffffffffc0201ce4:	e61ff0ef          	jal	ra,ffffffffc0201b44 <find_vma>
ffffffffc0201ce8:	c501                	beqz	a0,ffffffffc0201cf0 <mm_map+0x4c>
ffffffffc0201cea:	651c                	ld	a5,8(a0)
ffffffffc0201cec:	0487e263          	bltu	a5,s0,ffffffffc0201d30 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201cf0:	03000513          	li	a0,48
ffffffffc0201cf4:	50a000ef          	jal	ra,ffffffffc02021fe <kmalloc>
ffffffffc0201cf8:	892a                	mv	s2,a0
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0201cfa:	5571                	li	a0,-4
    if (vma != NULL) {
ffffffffc0201cfc:	02090163          	beqz	s2,ffffffffc0201d1e <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL) {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0201d00:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0201d02:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0201d06:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0201d0a:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0201d0e:	85ca                	mv	a1,s2
ffffffffc0201d10:	e75ff0ef          	jal	ra,ffffffffc0201b84 <insert_vma_struct>
    if (vma_store != NULL) {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0201d14:	4501                	li	a0,0
    if (vma_store != NULL) {
ffffffffc0201d16:	000a0463          	beqz	s4,ffffffffc0201d1e <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0201d1a:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_ex1_out_size-0x8958>

out:
    return ret;
}
ffffffffc0201d1e:	70e2                	ld	ra,56(sp)
ffffffffc0201d20:	7442                	ld	s0,48(sp)
ffffffffc0201d22:	74a2                	ld	s1,40(sp)
ffffffffc0201d24:	7902                	ld	s2,32(sp)
ffffffffc0201d26:	69e2                	ld	s3,24(sp)
ffffffffc0201d28:	6a42                	ld	s4,16(sp)
ffffffffc0201d2a:	6aa2                	ld	s5,8(sp)
ffffffffc0201d2c:	6121                	addi	sp,sp,64
ffffffffc0201d2e:	8082                	ret
        return -E_INVAL;
ffffffffc0201d30:	5575                	li	a0,-3
ffffffffc0201d32:	b7f5                	j	ffffffffc0201d1e <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0201d34:	00004697          	auipc	a3,0x4
ffffffffc0201d38:	cfc68693          	addi	a3,a3,-772 # ffffffffc0205a30 <commands+0xb08>
ffffffffc0201d3c:	00003617          	auipc	a2,0x3
ffffffffc0201d40:	5dc60613          	addi	a2,a2,1500 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201d44:	0a700593          	li	a1,167
ffffffffc0201d48:	00004517          	auipc	a0,0x4
ffffffffc0201d4c:	c6050513          	addi	a0,a0,-928 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201d50:	cb0fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201d54 <dup_mmap>:

int
dup_mmap(struct mm_struct *to, struct mm_struct *from) {
ffffffffc0201d54:	7139                	addi	sp,sp,-64
ffffffffc0201d56:	fc06                	sd	ra,56(sp)
ffffffffc0201d58:	f822                	sd	s0,48(sp)
ffffffffc0201d5a:	f426                	sd	s1,40(sp)
ffffffffc0201d5c:	f04a                	sd	s2,32(sp)
ffffffffc0201d5e:	ec4e                	sd	s3,24(sp)
ffffffffc0201d60:	e852                	sd	s4,16(sp)
ffffffffc0201d62:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0201d64:	c52d                	beqz	a0,ffffffffc0201dce <dup_mmap+0x7a>
ffffffffc0201d66:	892a                	mv	s2,a0
ffffffffc0201d68:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0201d6a:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0201d6c:	e595                	bnez	a1,ffffffffc0201d98 <dup_mmap+0x44>
ffffffffc0201d6e:	a085                	j	ffffffffc0201dce <dup_mmap+0x7a>
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
        if (nvma == NULL) {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0201d70:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0201d72:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_ex3_out_size+0x1f5308>
        vma->vm_end = vm_end;
ffffffffc0201d76:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0201d7a:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0201d7e:	e07ff0ef          	jal	ra,ffffffffc0201b84 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0) {
ffffffffc0201d82:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_ex1_out_size-0x8968>
ffffffffc0201d86:	fe843603          	ld	a2,-24(s0)
ffffffffc0201d8a:	6c8c                	ld	a1,24(s1)
ffffffffc0201d8c:	01893503          	ld	a0,24(s2)
ffffffffc0201d90:	4701                	li	a4,0
ffffffffc0201d92:	e94ff0ef          	jal	ra,ffffffffc0201426 <copy_range>
ffffffffc0201d96:	e105                	bnez	a0,ffffffffc0201db6 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0201d98:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list) {
ffffffffc0201d9a:	02848863          	beq	s1,s0,ffffffffc0201dca <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201d9e:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0201da2:	fe843a83          	ld	s5,-24(s0)
ffffffffc0201da6:	ff043a03          	ld	s4,-16(s0)
ffffffffc0201daa:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201dae:	450000ef          	jal	ra,ffffffffc02021fe <kmalloc>
ffffffffc0201db2:	85aa                	mv	a1,a0
    if (vma != NULL) {
ffffffffc0201db4:	fd55                	bnez	a0,ffffffffc0201d70 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0201db6:	5571                	li	a0,-4
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0201db8:	70e2                	ld	ra,56(sp)
ffffffffc0201dba:	7442                	ld	s0,48(sp)
ffffffffc0201dbc:	74a2                	ld	s1,40(sp)
ffffffffc0201dbe:	7902                	ld	s2,32(sp)
ffffffffc0201dc0:	69e2                	ld	s3,24(sp)
ffffffffc0201dc2:	6a42                	ld	s4,16(sp)
ffffffffc0201dc4:	6aa2                	ld	s5,8(sp)
ffffffffc0201dc6:	6121                	addi	sp,sp,64
ffffffffc0201dc8:	8082                	ret
    return 0;
ffffffffc0201dca:	4501                	li	a0,0
ffffffffc0201dcc:	b7f5                	j	ffffffffc0201db8 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0201dce:	00004697          	auipc	a3,0x4
ffffffffc0201dd2:	c7268693          	addi	a3,a3,-910 # ffffffffc0205a40 <commands+0xb18>
ffffffffc0201dd6:	00003617          	auipc	a2,0x3
ffffffffc0201dda:	54260613          	addi	a2,a2,1346 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201dde:	0c000593          	li	a1,192
ffffffffc0201de2:	00004517          	auipc	a0,0x4
ffffffffc0201de6:	bc650513          	addi	a0,a0,-1082 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201dea:	c16fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201dee <exit_mmap>:

void
exit_mmap(struct mm_struct *mm) {
ffffffffc0201dee:	1101                	addi	sp,sp,-32
ffffffffc0201df0:	ec06                	sd	ra,24(sp)
ffffffffc0201df2:	e822                	sd	s0,16(sp)
ffffffffc0201df4:	e426                	sd	s1,8(sp)
ffffffffc0201df6:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201df8:	c531                	beqz	a0,ffffffffc0201e44 <exit_mmap+0x56>
ffffffffc0201dfa:	591c                	lw	a5,48(a0)
ffffffffc0201dfc:	84aa                	mv	s1,a0
ffffffffc0201dfe:	e3b9                	bnez	a5,ffffffffc0201e44 <exit_mmap+0x56>
    return listelm->next;
ffffffffc0201e00:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0201e02:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list) {
ffffffffc0201e06:	02850663          	beq	a0,s0,ffffffffc0201e32 <exit_mmap+0x44>
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201e0a:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e0e:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e12:	854a                	mv	a0,s2
ffffffffc0201e14:	b42ff0ef          	jal	ra,ffffffffc0201156 <unmap_range>
ffffffffc0201e18:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201e1a:	fe8498e3          	bne	s1,s0,ffffffffc0201e0a <exit_mmap+0x1c>
ffffffffc0201e1e:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list) {
ffffffffc0201e20:	00848c63          	beq	s1,s0,ffffffffc0201e38 <exit_mmap+0x4a>
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201e24:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e28:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e2c:	854a                	mv	a0,s2
ffffffffc0201e2e:	c3eff0ef          	jal	ra,ffffffffc020126c <exit_range>
ffffffffc0201e32:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201e34:	fe8498e3          	bne	s1,s0,ffffffffc0201e24 <exit_mmap+0x36>
    }
}
ffffffffc0201e38:	60e2                	ld	ra,24(sp)
ffffffffc0201e3a:	6442                	ld	s0,16(sp)
ffffffffc0201e3c:	64a2                	ld	s1,8(sp)
ffffffffc0201e3e:	6902                	ld	s2,0(sp)
ffffffffc0201e40:	6105                	addi	sp,sp,32
ffffffffc0201e42:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201e44:	00004697          	auipc	a3,0x4
ffffffffc0201e48:	c1c68693          	addi	a3,a3,-996 # ffffffffc0205a60 <commands+0xb38>
ffffffffc0201e4c:	00003617          	auipc	a2,0x3
ffffffffc0201e50:	4cc60613          	addi	a2,a2,1228 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0201e54:	0d600593          	li	a1,214
ffffffffc0201e58:	00004517          	auipc	a0,0x4
ffffffffc0201e5c:	b5050513          	addi	a0,a0,-1200 # ffffffffc02059a8 <commands+0xa80>
ffffffffc0201e60:	ba0fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0201e64 <vmm_init>:
// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void
vmm_init(void) {
    //check_vmm();
}
ffffffffc0201e64:	8082                	ret

ffffffffc0201e66 <do_pgfault>:
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
int
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201e66:	7139                	addi	sp,sp,-64
    int ret = -E_INVAL;
    //try to find a vma which include addr
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201e68:	85b2                	mv	a1,a2
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201e6a:	f822                	sd	s0,48(sp)
ffffffffc0201e6c:	f426                	sd	s1,40(sp)
ffffffffc0201e6e:	fc06                	sd	ra,56(sp)
ffffffffc0201e70:	f04a                	sd	s2,32(sp)
ffffffffc0201e72:	ec4e                	sd	s3,24(sp)
ffffffffc0201e74:	8432                	mv	s0,a2
ffffffffc0201e76:	84aa                	mv	s1,a0
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201e78:	ccdff0ef          	jal	ra,ffffffffc0201b44 <find_vma>

    pgfault_num++;
ffffffffc0201e7c:	00051797          	auipc	a5,0x51
ffffffffc0201e80:	6047a783          	lw	a5,1540(a5) # ffffffffc0253480 <pgfault_num>
ffffffffc0201e84:	2785                	addiw	a5,a5,1
ffffffffc0201e86:	00051717          	auipc	a4,0x51
ffffffffc0201e8a:	5ef72d23          	sw	a5,1530(a4) # ffffffffc0253480 <pgfault_num>
    //If the addr is in the range of a mm's vma?
    if (vma == NULL || vma->vm_start > addr) {
ffffffffc0201e8e:	c545                	beqz	a0,ffffffffc0201f36 <do_pgfault+0xd0>
ffffffffc0201e90:	651c                	ld	a5,8(a0)
ffffffffc0201e92:	0af46263          	bltu	s0,a5,ffffffffc0201f36 <do_pgfault+0xd0>
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201e96:	4d1c                	lw	a5,24(a0)
    uint32_t perm = PTE_U;
ffffffffc0201e98:	49c1                	li	s3,16
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201e9a:	8b89                	andi	a5,a5,2
ffffffffc0201e9c:	efb1                	bnez	a5,ffffffffc0201ef8 <do_pgfault+0x92>
        perm |= READ_WRITE;
    }
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201e9e:	75fd                	lui	a1,0xfffff
    *   mm->pgdir : the PDT of these vma
    *
    */
    // try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.
    // (notice the 3th parameter '1')
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201ea0:	6c88                	ld	a0,24(s1)
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201ea2:	8c6d                	and	s0,s0,a1
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201ea4:	4605                	li	a2,1
ffffffffc0201ea6:	85a2                	mv	a1,s0
ffffffffc0201ea8:	8dcff0ef          	jal	ra,ffffffffc0200f84 <get_pte>
ffffffffc0201eac:	c555                	beqz	a0,ffffffffc0201f58 <do_pgfault+0xf2>
        cprintf("get_pte in do_pgfault failed\n");
        goto failed;
    }
    
    if (*ptep == 0) { // if the phy addr isn't exist, then alloc a page & map the phy addr with logical addr
ffffffffc0201eae:	610c                	ld	a1,0(a0)
ffffffffc0201eb0:	c5a5                	beqz	a1,ffffffffc0201f18 <do_pgfault+0xb2>
            goto failed;
        }
    }
    else { // if this pte is a swap entry, then load data from disk to a page with phy addr
           // and call page_insert to map the phy addr with logical addr
        if(swap_init_ok) {
ffffffffc0201eb2:	00051797          	auipc	a5,0x51
ffffffffc0201eb6:	5e67a783          	lw	a5,1510(a5) # ffffffffc0253498 <swap_init_ok>
ffffffffc0201eba:	c7d9                	beqz	a5,ffffffffc0201f48 <do_pgfault+0xe2>
            struct Page *page=NULL;
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201ebc:	0030                	addi	a2,sp,8
ffffffffc0201ebe:	85a2                	mv	a1,s0
ffffffffc0201ec0:	8526                	mv	a0,s1
            struct Page *page=NULL;
ffffffffc0201ec2:	e402                	sd	zero,8(sp)
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201ec4:	696000ef          	jal	ra,ffffffffc020255a <swap_in>
ffffffffc0201ec8:	892a                	mv	s2,a0
ffffffffc0201eca:	e90d                	bnez	a0,ffffffffc0201efc <do_pgfault+0x96>
                cprintf("swap_in in do_pgfault failed\n");
                goto failed;
            }    
            page_insert(mm->pgdir, page, addr, perm);
ffffffffc0201ecc:	65a2                	ld	a1,8(sp)
ffffffffc0201ece:	6c88                	ld	a0,24(s1)
ffffffffc0201ed0:	86ce                	mv	a3,s3
ffffffffc0201ed2:	8622                	mv	a2,s0
ffffffffc0201ed4:	c96ff0ef          	jal	ra,ffffffffc020136a <page_insert>
            swap_map_swappable(mm, addr, page, 1);
ffffffffc0201ed8:	6622                	ld	a2,8(sp)
ffffffffc0201eda:	4685                	li	a3,1
ffffffffc0201edc:	85a2                	mv	a1,s0
ffffffffc0201ede:	8526                	mv	a0,s1
ffffffffc0201ee0:	558000ef          	jal	ra,ffffffffc0202438 <swap_map_swappable>
            page->pra_vaddr = addr;
ffffffffc0201ee4:	67a2                	ld	a5,8(sp)
ffffffffc0201ee6:	ff80                	sd	s0,56(a5)
        }
   }
   ret = 0;
failed:
    return ret;
}
ffffffffc0201ee8:	70e2                	ld	ra,56(sp)
ffffffffc0201eea:	7442                	ld	s0,48(sp)
ffffffffc0201eec:	74a2                	ld	s1,40(sp)
ffffffffc0201eee:	69e2                	ld	s3,24(sp)
ffffffffc0201ef0:	854a                	mv	a0,s2
ffffffffc0201ef2:	7902                	ld	s2,32(sp)
ffffffffc0201ef4:	6121                	addi	sp,sp,64
ffffffffc0201ef6:	8082                	ret
        perm |= READ_WRITE;
ffffffffc0201ef8:	49dd                	li	s3,23
ffffffffc0201efa:	b755                	j	ffffffffc0201e9e <do_pgfault+0x38>
                cprintf("swap_in in do_pgfault failed\n");
ffffffffc0201efc:	00004517          	auipc	a0,0x4
ffffffffc0201f00:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0205af8 <commands+0xbd0>
ffffffffc0201f04:	9c0fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
}
ffffffffc0201f08:	70e2                	ld	ra,56(sp)
ffffffffc0201f0a:	7442                	ld	s0,48(sp)
ffffffffc0201f0c:	74a2                	ld	s1,40(sp)
ffffffffc0201f0e:	69e2                	ld	s3,24(sp)
ffffffffc0201f10:	854a                	mv	a0,s2
ffffffffc0201f12:	7902                	ld	s2,32(sp)
ffffffffc0201f14:	6121                	addi	sp,sp,64
ffffffffc0201f16:	8082                	ret
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201f18:	6c88                	ld	a0,24(s1)
ffffffffc0201f1a:	864e                	mv	a2,s3
ffffffffc0201f1c:	85a2                	mv	a1,s0
ffffffffc0201f1e:	f3eff0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
   ret = 0;
ffffffffc0201f22:	4901                	li	s2,0
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201f24:	f171                	bnez	a0,ffffffffc0201ee8 <do_pgfault+0x82>
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
ffffffffc0201f26:	00004517          	auipc	a0,0x4
ffffffffc0201f2a:	baa50513          	addi	a0,a0,-1110 # ffffffffc0205ad0 <commands+0xba8>
ffffffffc0201f2e:	996fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f32:	5971                	li	s2,-4
            goto failed;
ffffffffc0201f34:	bf55                	j	ffffffffc0201ee8 <do_pgfault+0x82>
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
ffffffffc0201f36:	85a2                	mv	a1,s0
ffffffffc0201f38:	00004517          	auipc	a0,0x4
ffffffffc0201f3c:	b4850513          	addi	a0,a0,-1208 # ffffffffc0205a80 <commands+0xb58>
ffffffffc0201f40:	984fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    int ret = -E_INVAL;
ffffffffc0201f44:	5975                	li	s2,-3
        goto failed;
ffffffffc0201f46:	b74d                	j	ffffffffc0201ee8 <do_pgfault+0x82>
            cprintf("no swap_init_ok but ptep is %x, failed\n",*ptep);
ffffffffc0201f48:	00004517          	auipc	a0,0x4
ffffffffc0201f4c:	bd050513          	addi	a0,a0,-1072 # ffffffffc0205b18 <commands+0xbf0>
ffffffffc0201f50:	974fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f54:	5971                	li	s2,-4
            goto failed;
ffffffffc0201f56:	bf49                	j	ffffffffc0201ee8 <do_pgfault+0x82>
        cprintf("get_pte in do_pgfault failed\n");
ffffffffc0201f58:	00004517          	auipc	a0,0x4
ffffffffc0201f5c:	b5850513          	addi	a0,a0,-1192 # ffffffffc0205ab0 <commands+0xb88>
ffffffffc0201f60:	964fe0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f64:	5971                	li	s2,-4
        goto failed;
ffffffffc0201f66:	b749                	j	ffffffffc0201ee8 <do_pgfault+0x82>

ffffffffc0201f68 <user_mem_check>:

bool
user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write) {
ffffffffc0201f68:	7179                	addi	sp,sp,-48
ffffffffc0201f6a:	f022                	sd	s0,32(sp)
ffffffffc0201f6c:	f406                	sd	ra,40(sp)
ffffffffc0201f6e:	ec26                	sd	s1,24(sp)
ffffffffc0201f70:	e84a                	sd	s2,16(sp)
ffffffffc0201f72:	e44e                	sd	s3,8(sp)
ffffffffc0201f74:	e052                	sd	s4,0(sp)
ffffffffc0201f76:	842e                	mv	s0,a1
    if (mm != NULL) {
ffffffffc0201f78:	c135                	beqz	a0,ffffffffc0201fdc <user_mem_check+0x74>
        if (!USER_ACCESS(addr, addr + len)) {
ffffffffc0201f7a:	002007b7          	lui	a5,0x200
ffffffffc0201f7e:	04f5e663          	bltu	a1,a5,ffffffffc0201fca <user_mem_check+0x62>
ffffffffc0201f82:	00c584b3          	add	s1,a1,a2
ffffffffc0201f86:	0495f263          	bgeu	a1,s1,ffffffffc0201fca <user_mem_check+0x62>
ffffffffc0201f8a:	4785                	li	a5,1
ffffffffc0201f8c:	07fe                	slli	a5,a5,0x1f
ffffffffc0201f8e:	0297ee63          	bltu	a5,s1,ffffffffc0201fca <user_mem_check+0x62>
ffffffffc0201f92:	892a                	mv	s2,a0
ffffffffc0201f94:	89b6                	mv	s3,a3
            }
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK)) {
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201f96:	6a05                	lui	s4,0x1
ffffffffc0201f98:	a821                	j	ffffffffc0201fb0 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201f9a:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201f9e:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201fa0:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201fa2:	c685                	beqz	a3,ffffffffc0201fca <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201fa4:	c399                	beqz	a5,ffffffffc0201faa <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201fa6:	02e46263          	bltu	s0,a4,ffffffffc0201fca <user_mem_check+0x62>
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0201faa:	6900                	ld	s0,16(a0)
        while (start < end) {
ffffffffc0201fac:	04947663          	bgeu	s0,s1,ffffffffc0201ff8 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start) {
ffffffffc0201fb0:	85a2                	mv	a1,s0
ffffffffc0201fb2:	854a                	mv	a0,s2
ffffffffc0201fb4:	b91ff0ef          	jal	ra,ffffffffc0201b44 <find_vma>
ffffffffc0201fb8:	c909                	beqz	a0,ffffffffc0201fca <user_mem_check+0x62>
ffffffffc0201fba:	6518                	ld	a4,8(a0)
ffffffffc0201fbc:	00e46763          	bltu	s0,a4,ffffffffc0201fca <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201fc0:	4d1c                	lw	a5,24(a0)
ffffffffc0201fc2:	fc099ce3          	bnez	s3,ffffffffc0201f9a <user_mem_check+0x32>
ffffffffc0201fc6:	8b85                	andi	a5,a5,1
ffffffffc0201fc8:	f3ed                	bnez	a5,ffffffffc0201faa <user_mem_check+0x42>
            return 0;
ffffffffc0201fca:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0201fcc:	70a2                	ld	ra,40(sp)
ffffffffc0201fce:	7402                	ld	s0,32(sp)
ffffffffc0201fd0:	64e2                	ld	s1,24(sp)
ffffffffc0201fd2:	6942                	ld	s2,16(sp)
ffffffffc0201fd4:	69a2                	ld	s3,8(sp)
ffffffffc0201fd6:	6a02                	ld	s4,0(sp)
ffffffffc0201fd8:	6145                	addi	sp,sp,48
ffffffffc0201fda:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0201fdc:	c02007b7          	lui	a5,0xc0200
ffffffffc0201fe0:	4501                	li	a0,0
ffffffffc0201fe2:	fef5e5e3          	bltu	a1,a5,ffffffffc0201fcc <user_mem_check+0x64>
ffffffffc0201fe6:	962e                	add	a2,a2,a1
ffffffffc0201fe8:	fec5f2e3          	bgeu	a1,a2,ffffffffc0201fcc <user_mem_check+0x64>
ffffffffc0201fec:	c8000537          	lui	a0,0xc8000
ffffffffc0201ff0:	0505                	addi	a0,a0,1
ffffffffc0201ff2:	00a63533          	sltu	a0,a2,a0
ffffffffc0201ff6:	bfd9                	j	ffffffffc0201fcc <user_mem_check+0x64>
        return 1;
ffffffffc0201ff8:	4505                	li	a0,1
ffffffffc0201ffa:	bfc9                	j	ffffffffc0201fcc <user_mem_check+0x64>

ffffffffc0201ffc <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201ffc:	c145                	beqz	a0,ffffffffc020209c <slob_free+0xa0>
{
ffffffffc0201ffe:	1141                	addi	sp,sp,-16
ffffffffc0202000:	e022                	sd	s0,0(sp)
ffffffffc0202002:	e406                	sd	ra,8(sp)
ffffffffc0202004:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0202006:	edb1                	bnez	a1,ffffffffc0202062 <slob_free+0x66>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202008:	100027f3          	csrr	a5,sstatus
ffffffffc020200c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020200e:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202010:	e3ad                	bnez	a5,ffffffffc0202072 <slob_free+0x76>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0202012:	00046617          	auipc	a2,0x46
ffffffffc0202016:	01660613          	addi	a2,a2,22 # ffffffffc0248028 <slobfree>
ffffffffc020201a:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020201c:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020201e:	0087fa63          	bgeu	a5,s0,ffffffffc0202032 <slob_free+0x36>
ffffffffc0202022:	00e46c63          	bltu	s0,a4,ffffffffc020203a <slob_free+0x3e>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0202026:	00e7fa63          	bgeu	a5,a4,ffffffffc020203a <slob_free+0x3e>
    return 0;
ffffffffc020202a:	87ba                	mv	a5,a4
ffffffffc020202c:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc020202e:	fe87eae3          	bltu	a5,s0,ffffffffc0202022 <slob_free+0x26>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0202032:	fee7ece3          	bltu	a5,a4,ffffffffc020202a <slob_free+0x2e>
ffffffffc0202036:	fee47ae3          	bgeu	s0,a4,ffffffffc020202a <slob_free+0x2e>
			break;

	if (b + b->units == cur->next) {
ffffffffc020203a:	400c                	lw	a1,0(s0)
ffffffffc020203c:	00459693          	slli	a3,a1,0x4
ffffffffc0202040:	96a2                	add	a3,a3,s0
ffffffffc0202042:	04d70763          	beq	a4,a3,ffffffffc0202090 <slob_free+0x94>
		b->units += cur->next->units;
		b->next = cur->next->next;
	} else
		b->next = cur->next;
ffffffffc0202046:	e418                	sd	a4,8(s0)

	if (cur + cur->units == b) {
ffffffffc0202048:	4394                	lw	a3,0(a5)
ffffffffc020204a:	00469713          	slli	a4,a3,0x4
ffffffffc020204e:	973e                	add	a4,a4,a5
ffffffffc0202050:	02e40a63          	beq	s0,a4,ffffffffc0202084 <slob_free+0x88>
		cur->units += b->units;
		cur->next = b->next;
	} else
		cur->next = b;
ffffffffc0202054:	e780                	sd	s0,8(a5)

	slobfree = cur;
ffffffffc0202056:	e21c                	sd	a5,0(a2)
    if (flag) {
ffffffffc0202058:	e10d                	bnez	a0,ffffffffc020207a <slob_free+0x7e>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc020205a:	60a2                	ld	ra,8(sp)
ffffffffc020205c:	6402                	ld	s0,0(sp)
ffffffffc020205e:	0141                	addi	sp,sp,16
ffffffffc0202060:	8082                	ret
		b->units = SLOB_UNITS(size);
ffffffffc0202062:	05bd                	addi	a1,a1,15
ffffffffc0202064:	8191                	srli	a1,a1,0x4
ffffffffc0202066:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202068:	100027f3          	csrr	a5,sstatus
ffffffffc020206c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020206e:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202070:	d3cd                	beqz	a5,ffffffffc0202012 <slob_free+0x16>
        intr_disable();
ffffffffc0202072:	d8cfe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0202076:	4505                	li	a0,1
ffffffffc0202078:	bf69                	j	ffffffffc0202012 <slob_free+0x16>
}
ffffffffc020207a:	6402                	ld	s0,0(sp)
ffffffffc020207c:	60a2                	ld	ra,8(sp)
ffffffffc020207e:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0202080:	d78fe06f          	j	ffffffffc02005f8 <intr_enable>
		cur->units += b->units;
ffffffffc0202084:	4018                	lw	a4,0(s0)
		cur->next = b->next;
ffffffffc0202086:	640c                	ld	a1,8(s0)
		cur->units += b->units;
ffffffffc0202088:	9eb9                	addw	a3,a3,a4
ffffffffc020208a:	c394                	sw	a3,0(a5)
		cur->next = b->next;
ffffffffc020208c:	e78c                	sd	a1,8(a5)
ffffffffc020208e:	b7e1                	j	ffffffffc0202056 <slob_free+0x5a>
		b->units += cur->next->units;
ffffffffc0202090:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0202092:	6718                	ld	a4,8(a4)
		b->units += cur->next->units;
ffffffffc0202094:	9db5                	addw	a1,a1,a3
ffffffffc0202096:	c00c                	sw	a1,0(s0)
		b->next = cur->next->next;
ffffffffc0202098:	e418                	sd	a4,8(s0)
ffffffffc020209a:	b77d                	j	ffffffffc0202048 <slob_free+0x4c>
ffffffffc020209c:	8082                	ret

ffffffffc020209e <__slob_get_free_pages.isra.0>:
  struct Page * page = alloc_pages(1 << order);
ffffffffc020209e:	4785                	li	a5,1
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02020a0:	1141                	addi	sp,sp,-16
  struct Page * page = alloc_pages(1 << order);
ffffffffc02020a2:	00a7953b          	sllw	a0,a5,a0
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02020a6:	e406                	sd	ra,8(sp)
  struct Page * page = alloc_pages(1 << order);
ffffffffc02020a8:	c77fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
  if(!page)
ffffffffc02020ac:	c91d                	beqz	a0,ffffffffc02020e2 <__slob_get_free_pages.isra.0+0x44>
    return page - pages + nbase;
ffffffffc02020ae:	00051697          	auipc	a3,0x51
ffffffffc02020b2:	4426b683          	ld	a3,1090(a3) # ffffffffc02534f0 <pages>
ffffffffc02020b6:	8d15                	sub	a0,a0,a3
ffffffffc02020b8:	8519                	srai	a0,a0,0x6
ffffffffc02020ba:	00005697          	auipc	a3,0x5
ffffffffc02020be:	0d66b683          	ld	a3,214(a3) # ffffffffc0207190 <nbase>
ffffffffc02020c2:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc02020c4:	00c51793          	slli	a5,a0,0xc
ffffffffc02020c8:	83b1                	srli	a5,a5,0xc
ffffffffc02020ca:	00051717          	auipc	a4,0x51
ffffffffc02020ce:	3ae73703          	ld	a4,942(a4) # ffffffffc0253478 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc02020d2:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc02020d4:	00e7fa63          	bgeu	a5,a4,ffffffffc02020e8 <__slob_get_free_pages.isra.0+0x4a>
ffffffffc02020d8:	00051697          	auipc	a3,0x51
ffffffffc02020dc:	4086b683          	ld	a3,1032(a3) # ffffffffc02534e0 <va_pa_offset>
ffffffffc02020e0:	9536                	add	a0,a0,a3
}
ffffffffc02020e2:	60a2                	ld	ra,8(sp)
ffffffffc02020e4:	0141                	addi	sp,sp,16
ffffffffc02020e6:	8082                	ret
ffffffffc02020e8:	86aa                	mv	a3,a0
ffffffffc02020ea:	00003617          	auipc	a2,0x3
ffffffffc02020ee:	5de60613          	addi	a2,a2,1502 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc02020f2:	06900593          	li	a1,105
ffffffffc02020f6:	00003517          	auipc	a0,0x3
ffffffffc02020fa:	53250513          	addi	a0,a0,1330 # ffffffffc0205628 <commands+0x700>
ffffffffc02020fe:	902fe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202102 <slob_alloc.isra.0.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0202102:	1101                	addi	sp,sp,-32
ffffffffc0202104:	ec06                	sd	ra,24(sp)
ffffffffc0202106:	e822                	sd	s0,16(sp)
ffffffffc0202108:	e426                	sd	s1,8(sp)
ffffffffc020210a:	e04a                	sd	s2,0(sp)
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc020210c:	01050713          	addi	a4,a0,16
ffffffffc0202110:	6785                	lui	a5,0x1
ffffffffc0202112:	0cf77363          	bgeu	a4,a5,ffffffffc02021d8 <slob_alloc.isra.0.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0202116:	00f50493          	addi	s1,a0,15
ffffffffc020211a:	8091                	srli	s1,s1,0x4
ffffffffc020211c:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020211e:	10002673          	csrr	a2,sstatus
ffffffffc0202122:	8a09                	andi	a2,a2,2
ffffffffc0202124:	e25d                	bnez	a2,ffffffffc02021ca <slob_alloc.isra.0.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0202126:	00046917          	auipc	s2,0x46
ffffffffc020212a:	f0290913          	addi	s2,s2,-254 # ffffffffc0248028 <slobfree>
ffffffffc020212e:	00093683          	ld	a3,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0202132:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202134:	4398                	lw	a4,0(a5)
ffffffffc0202136:	08975e63          	bge	a4,s1,ffffffffc02021d2 <slob_alloc.isra.0.constprop.0+0xd0>
		if (cur == slobfree) {
ffffffffc020213a:	00d78b63          	beq	a5,a3,ffffffffc0202150 <slob_alloc.isra.0.constprop.0+0x4e>
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc020213e:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202140:	4018                	lw	a4,0(s0)
ffffffffc0202142:	02975a63          	bge	a4,s1,ffffffffc0202176 <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc0202146:	00093683          	ld	a3,0(s2)
ffffffffc020214a:	87a2                	mv	a5,s0
		if (cur == slobfree) {
ffffffffc020214c:	fed799e3          	bne	a5,a3,ffffffffc020213e <slob_alloc.isra.0.constprop.0+0x3c>
    if (flag) {
ffffffffc0202150:	ee31                	bnez	a2,ffffffffc02021ac <slob_alloc.isra.0.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0202152:	4501                	li	a0,0
ffffffffc0202154:	f4bff0ef          	jal	ra,ffffffffc020209e <__slob_get_free_pages.isra.0>
ffffffffc0202158:	842a                	mv	s0,a0
			if (!cur)
ffffffffc020215a:	cd05                	beqz	a0,ffffffffc0202192 <slob_alloc.isra.0.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc020215c:	6585                	lui	a1,0x1
ffffffffc020215e:	e9fff0ef          	jal	ra,ffffffffc0201ffc <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202162:	10002673          	csrr	a2,sstatus
ffffffffc0202166:	8a09                	andi	a2,a2,2
ffffffffc0202168:	ee05                	bnez	a2,ffffffffc02021a0 <slob_alloc.isra.0.constprop.0+0x9e>
			cur = slobfree;
ffffffffc020216a:	00093783          	ld	a5,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc020216e:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202170:	4018                	lw	a4,0(s0)
ffffffffc0202172:	fc974ae3          	blt	a4,s1,ffffffffc0202146 <slob_alloc.isra.0.constprop.0+0x44>
			if (cur->units == units) /* exact fit? */
ffffffffc0202176:	04e48763          	beq	s1,a4,ffffffffc02021c4 <slob_alloc.isra.0.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc020217a:	00449693          	slli	a3,s1,0x4
ffffffffc020217e:	96a2                	add	a3,a3,s0
ffffffffc0202180:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0202182:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0202184:	9f05                	subw	a4,a4,s1
ffffffffc0202186:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0202188:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc020218a:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc020218c:	00f93023          	sd	a5,0(s2)
    if (flag) {
ffffffffc0202190:	e20d                	bnez	a2,ffffffffc02021b2 <slob_alloc.isra.0.constprop.0+0xb0>
}
ffffffffc0202192:	60e2                	ld	ra,24(sp)
ffffffffc0202194:	8522                	mv	a0,s0
ffffffffc0202196:	6442                	ld	s0,16(sp)
ffffffffc0202198:	64a2                	ld	s1,8(sp)
ffffffffc020219a:	6902                	ld	s2,0(sp)
ffffffffc020219c:	6105                	addi	sp,sp,32
ffffffffc020219e:	8082                	ret
        intr_disable();
ffffffffc02021a0:	c5efe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
			cur = slobfree;
ffffffffc02021a4:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc02021a8:	4605                	li	a2,1
ffffffffc02021aa:	b7d1                	j	ffffffffc020216e <slob_alloc.isra.0.constprop.0+0x6c>
        intr_enable();
ffffffffc02021ac:	c4cfe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc02021b0:	b74d                	j	ffffffffc0202152 <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc02021b2:	c46fe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
}
ffffffffc02021b6:	60e2                	ld	ra,24(sp)
ffffffffc02021b8:	8522                	mv	a0,s0
ffffffffc02021ba:	6442                	ld	s0,16(sp)
ffffffffc02021bc:	64a2                	ld	s1,8(sp)
ffffffffc02021be:	6902                	ld	s2,0(sp)
ffffffffc02021c0:	6105                	addi	sp,sp,32
ffffffffc02021c2:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc02021c4:	6418                	ld	a4,8(s0)
ffffffffc02021c6:	e798                	sd	a4,8(a5)
ffffffffc02021c8:	b7d1                	j	ffffffffc020218c <slob_alloc.isra.0.constprop.0+0x8a>
        intr_disable();
ffffffffc02021ca:	c34fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc02021ce:	4605                	li	a2,1
ffffffffc02021d0:	bf99                	j	ffffffffc0202126 <slob_alloc.isra.0.constprop.0+0x24>
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc02021d2:	843e                	mv	s0,a5
ffffffffc02021d4:	87b6                	mv	a5,a3
ffffffffc02021d6:	b745                	j	ffffffffc0202176 <slob_alloc.isra.0.constprop.0+0x74>
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc02021d8:	00004697          	auipc	a3,0x4
ffffffffc02021dc:	96868693          	addi	a3,a3,-1688 # ffffffffc0205b40 <commands+0xc18>
ffffffffc02021e0:	00003617          	auipc	a2,0x3
ffffffffc02021e4:	13860613          	addi	a2,a2,312 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02021e8:	06400593          	li	a1,100
ffffffffc02021ec:	00004517          	auipc	a0,0x4
ffffffffc02021f0:	97450513          	addi	a0,a0,-1676 # ffffffffc0205b60 <commands+0xc38>
ffffffffc02021f4:	80cfe0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02021f8 <kmalloc_init>:

inline void 
kmalloc_init(void) {
    slob_init();
    //cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc02021f8:	8082                	ret

ffffffffc02021fa <kallocated>:
}

size_t
kallocated(void) {
   return slob_allocated();
}
ffffffffc02021fa:	4501                	li	a0,0
ffffffffc02021fc:	8082                	ret

ffffffffc02021fe <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc02021fe:	1101                	addi	sp,sp,-32
ffffffffc0202200:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202202:	6905                	lui	s2,0x1
{
ffffffffc0202204:	e822                	sd	s0,16(sp)
ffffffffc0202206:	ec06                	sd	ra,24(sp)
ffffffffc0202208:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020220a:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_ex1_out_size-0x8969>
{
ffffffffc020220e:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202210:	04a7f963          	bgeu	a5,a0,ffffffffc0202262 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0202214:	4561                	li	a0,24
ffffffffc0202216:	eedff0ef          	jal	ra,ffffffffc0202102 <slob_alloc.isra.0.constprop.0>
ffffffffc020221a:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc020221c:	c929                	beqz	a0,ffffffffc020226e <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc020221e:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0202222:	4501                	li	a0,0
	for ( ; size > 4096 ; size >>=1)
ffffffffc0202224:	00f95763          	bge	s2,a5,ffffffffc0202232 <kmalloc+0x34>
ffffffffc0202228:	6705                	lui	a4,0x1
ffffffffc020222a:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc020222c:	2505                	addiw	a0,a0,1
	for ( ; size > 4096 ; size >>=1)
ffffffffc020222e:	fef74ee3          	blt	a4,a5,ffffffffc020222a <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0202232:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0202234:	e6bff0ef          	jal	ra,ffffffffc020209e <__slob_get_free_pages.isra.0>
ffffffffc0202238:	e488                	sd	a0,8(s1)
ffffffffc020223a:	842a                	mv	s0,a0
	if (bb->pages) {
ffffffffc020223c:	c525                	beqz	a0,ffffffffc02022a4 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020223e:	100027f3          	csrr	a5,sstatus
ffffffffc0202242:	8b89                	andi	a5,a5,2
ffffffffc0202244:	ef8d                	bnez	a5,ffffffffc020227e <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0202246:	00051797          	auipc	a5,0x51
ffffffffc020224a:	24278793          	addi	a5,a5,578 # ffffffffc0253488 <bigblocks>
ffffffffc020224e:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0202250:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0202252:	e898                	sd	a4,16(s1)
  return __kmalloc(size, 0);
}
ffffffffc0202254:	60e2                	ld	ra,24(sp)
ffffffffc0202256:	8522                	mv	a0,s0
ffffffffc0202258:	6442                	ld	s0,16(sp)
ffffffffc020225a:	64a2                	ld	s1,8(sp)
ffffffffc020225c:	6902                	ld	s2,0(sp)
ffffffffc020225e:	6105                	addi	sp,sp,32
ffffffffc0202260:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0202262:	0541                	addi	a0,a0,16
ffffffffc0202264:	e9fff0ef          	jal	ra,ffffffffc0202102 <slob_alloc.isra.0.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0202268:	01050413          	addi	s0,a0,16
ffffffffc020226c:	f565                	bnez	a0,ffffffffc0202254 <kmalloc+0x56>
ffffffffc020226e:	4401                	li	s0,0
}
ffffffffc0202270:	60e2                	ld	ra,24(sp)
ffffffffc0202272:	8522                	mv	a0,s0
ffffffffc0202274:	6442                	ld	s0,16(sp)
ffffffffc0202276:	64a2                	ld	s1,8(sp)
ffffffffc0202278:	6902                	ld	s2,0(sp)
ffffffffc020227a:	6105                	addi	sp,sp,32
ffffffffc020227c:	8082                	ret
        intr_disable();
ffffffffc020227e:	b80fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
		bb->next = bigblocks;
ffffffffc0202282:	00051797          	auipc	a5,0x51
ffffffffc0202286:	20678793          	addi	a5,a5,518 # ffffffffc0253488 <bigblocks>
ffffffffc020228a:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc020228c:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc020228e:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0202290:	b68fe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0202294:	6480                	ld	s0,8(s1)
}
ffffffffc0202296:	60e2                	ld	ra,24(sp)
ffffffffc0202298:	64a2                	ld	s1,8(sp)
ffffffffc020229a:	8522                	mv	a0,s0
ffffffffc020229c:	6442                	ld	s0,16(sp)
ffffffffc020229e:	6902                	ld	s2,0(sp)
ffffffffc02022a0:	6105                	addi	sp,sp,32
ffffffffc02022a2:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc02022a4:	45e1                	li	a1,24
ffffffffc02022a6:	8526                	mv	a0,s1
ffffffffc02022a8:	d55ff0ef          	jal	ra,ffffffffc0201ffc <slob_free>
  return __kmalloc(size, 0);
ffffffffc02022ac:	b765                	j	ffffffffc0202254 <kmalloc+0x56>

ffffffffc02022ae <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc02022ae:	c169                	beqz	a0,ffffffffc0202370 <kfree+0xc2>
{
ffffffffc02022b0:	1101                	addi	sp,sp,-32
ffffffffc02022b2:	e822                	sd	s0,16(sp)
ffffffffc02022b4:	ec06                	sd	ra,24(sp)
ffffffffc02022b6:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE-1))) {
ffffffffc02022b8:	03451793          	slli	a5,a0,0x34
ffffffffc02022bc:	842a                	mv	s0,a0
ffffffffc02022be:	e7c9                	bnez	a5,ffffffffc0202348 <kfree+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02022c0:	100027f3          	csrr	a5,sstatus
ffffffffc02022c4:	8b89                	andi	a5,a5,2
ffffffffc02022c6:	ebc9                	bnez	a5,ffffffffc0202358 <kfree+0xaa>
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02022c8:	00051797          	auipc	a5,0x51
ffffffffc02022cc:	1c07b783          	ld	a5,448(a5) # ffffffffc0253488 <bigblocks>
    return 0;
ffffffffc02022d0:	4601                	li	a2,0
ffffffffc02022d2:	cbbd                	beqz	a5,ffffffffc0202348 <kfree+0x9a>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc02022d4:	00051697          	auipc	a3,0x51
ffffffffc02022d8:	1b468693          	addi	a3,a3,436 # ffffffffc0253488 <bigblocks>
ffffffffc02022dc:	a021                	j	ffffffffc02022e4 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02022de:	01048693          	addi	a3,s1,16 # ffffffffffe00010 <end+0x3fbaca10>
ffffffffc02022e2:	c3a5                	beqz	a5,ffffffffc0202342 <kfree+0x94>
			if (bb->pages == block) {
ffffffffc02022e4:	6798                	ld	a4,8(a5)
ffffffffc02022e6:	84be                	mv	s1,a5
ffffffffc02022e8:	6b9c                	ld	a5,16(a5)
ffffffffc02022ea:	fe871ae3          	bne	a4,s0,ffffffffc02022de <kfree+0x30>
				*last = bb->next;
ffffffffc02022ee:	e29c                	sd	a5,0(a3)
    if (flag) {
ffffffffc02022f0:	ee2d                	bnez	a2,ffffffffc020236a <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc02022f2:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc02022f6:	4098                	lw	a4,0(s1)
ffffffffc02022f8:	08f46963          	bltu	s0,a5,ffffffffc020238a <kfree+0xdc>
ffffffffc02022fc:	00051697          	auipc	a3,0x51
ffffffffc0202300:	1e46b683          	ld	a3,484(a3) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0202304:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage) {
ffffffffc0202306:	8031                	srli	s0,s0,0xc
ffffffffc0202308:	00051797          	auipc	a5,0x51
ffffffffc020230c:	1707b783          	ld	a5,368(a5) # ffffffffc0253478 <npage>
ffffffffc0202310:	06f47163          	bgeu	s0,a5,ffffffffc0202372 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0202314:	00005517          	auipc	a0,0x5
ffffffffc0202318:	e7c53503          	ld	a0,-388(a0) # ffffffffc0207190 <nbase>
ffffffffc020231c:	8c09                	sub	s0,s0,a0
ffffffffc020231e:	041a                	slli	s0,s0,0x6
  free_pages(kva2page(kva), 1 << order);
ffffffffc0202320:	00051517          	auipc	a0,0x51
ffffffffc0202324:	1d053503          	ld	a0,464(a0) # ffffffffc02534f0 <pages>
ffffffffc0202328:	4585                	li	a1,1
ffffffffc020232a:	9522                	add	a0,a0,s0
ffffffffc020232c:	00e595bb          	sllw	a1,a1,a4
ffffffffc0202330:	a81fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0202334:	6442                	ld	s0,16(sp)
ffffffffc0202336:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0202338:	8526                	mv	a0,s1
}
ffffffffc020233a:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc020233c:	45e1                	li	a1,24
}
ffffffffc020233e:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0202340:	b975                	j	ffffffffc0201ffc <slob_free>
ffffffffc0202342:	c219                	beqz	a2,ffffffffc0202348 <kfree+0x9a>
        intr_enable();
ffffffffc0202344:	ab4fe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0202348:	ff040513          	addi	a0,s0,-16
}
ffffffffc020234c:	6442                	ld	s0,16(sp)
ffffffffc020234e:	60e2                	ld	ra,24(sp)
ffffffffc0202350:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0202352:	4581                	li	a1,0
}
ffffffffc0202354:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0202356:	b15d                	j	ffffffffc0201ffc <slob_free>
        intr_disable();
ffffffffc0202358:	aa6fe0ef          	jal	ra,ffffffffc02005fe <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc020235c:	00051797          	auipc	a5,0x51
ffffffffc0202360:	12c7b783          	ld	a5,300(a5) # ffffffffc0253488 <bigblocks>
        return 1;
ffffffffc0202364:	4605                	li	a2,1
ffffffffc0202366:	f7bd                	bnez	a5,ffffffffc02022d4 <kfree+0x26>
ffffffffc0202368:	bff1                	j	ffffffffc0202344 <kfree+0x96>
        intr_enable();
ffffffffc020236a:	a8efe0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc020236e:	b751                	j	ffffffffc02022f2 <kfree+0x44>
ffffffffc0202370:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0202372:	00003617          	auipc	a2,0x3
ffffffffc0202376:	29660613          	addi	a2,a2,662 # ffffffffc0205608 <commands+0x6e0>
ffffffffc020237a:	06200593          	li	a1,98
ffffffffc020237e:	00003517          	auipc	a0,0x3
ffffffffc0202382:	2aa50513          	addi	a0,a0,682 # ffffffffc0205628 <commands+0x700>
ffffffffc0202386:	e7bfd0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc020238a:	86a2                	mv	a3,s0
ffffffffc020238c:	00003617          	auipc	a2,0x3
ffffffffc0202390:	30460613          	addi	a2,a2,772 # ffffffffc0205690 <commands+0x768>
ffffffffc0202394:	06e00593          	li	a1,110
ffffffffc0202398:	00003517          	auipc	a0,0x3
ffffffffc020239c:	29050513          	addi	a0,a0,656 # ffffffffc0205628 <commands+0x700>
ffffffffc02023a0:	e61fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02023a4 <swap_init>:

static void check_swap(void);

int
swap_init(void)
{
ffffffffc02023a4:	1101                	addi	sp,sp,-32
ffffffffc02023a6:	ec06                	sd	ra,24(sp)
ffffffffc02023a8:	e822                	sd	s0,16(sp)
ffffffffc02023aa:	e426                	sd	s1,8(sp)
     swapfs_init();
ffffffffc02023ac:	4cd000ef          	jal	ra,ffffffffc0203078 <swapfs_init>

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     if (!(7 <= max_swap_offset &&
ffffffffc02023b0:	00051697          	auipc	a3,0x51
ffffffffc02023b4:	1e86b683          	ld	a3,488(a3) # ffffffffc0253598 <max_swap_offset>
ffffffffc02023b8:	010007b7          	lui	a5,0x1000
ffffffffc02023bc:	ff968713          	addi	a4,a3,-7
ffffffffc02023c0:	17e1                	addi	a5,a5,-8
ffffffffc02023c2:	04e7e863          	bltu	a5,a4,ffffffffc0202412 <swap_init+0x6e>
        max_swap_offset < MAX_SWAP_OFFSET_LIMIT)) {
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }
     

     sm = &swap_manager_fifo;
ffffffffc02023c6:	00046797          	auipc	a5,0x46
ffffffffc02023ca:	be278793          	addi	a5,a5,-1054 # ffffffffc0247fa8 <swap_manager_fifo>
     int r = sm->init();
ffffffffc02023ce:	6798                	ld	a4,8(a5)
     sm = &swap_manager_fifo;
ffffffffc02023d0:	00051497          	auipc	s1,0x51
ffffffffc02023d4:	0c048493          	addi	s1,s1,192 # ffffffffc0253490 <sm>
ffffffffc02023d8:	e09c                	sd	a5,0(s1)
     int r = sm->init();
ffffffffc02023da:	9702                	jalr	a4
ffffffffc02023dc:	842a                	mv	s0,a0
     
     if (r == 0)
ffffffffc02023de:	c519                	beqz	a0,ffffffffc02023ec <swap_init+0x48>
          cprintf("SWAP: manager = %s\n", sm->name);
          //check_swap();
     }

     return r;
}
ffffffffc02023e0:	60e2                	ld	ra,24(sp)
ffffffffc02023e2:	8522                	mv	a0,s0
ffffffffc02023e4:	6442                	ld	s0,16(sp)
ffffffffc02023e6:	64a2                	ld	s1,8(sp)
ffffffffc02023e8:	6105                	addi	sp,sp,32
ffffffffc02023ea:	8082                	ret
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc02023ec:	609c                	ld	a5,0(s1)
ffffffffc02023ee:	00003517          	auipc	a0,0x3
ffffffffc02023f2:	7ba50513          	addi	a0,a0,1978 # ffffffffc0205ba8 <commands+0xc80>
ffffffffc02023f6:	638c                	ld	a1,0(a5)
          swap_init_ok = 1;
ffffffffc02023f8:	4785                	li	a5,1
ffffffffc02023fa:	00051717          	auipc	a4,0x51
ffffffffc02023fe:	08f72f23          	sw	a5,158(a4) # ffffffffc0253498 <swap_init_ok>
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0202402:	cc3fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
}
ffffffffc0202406:	60e2                	ld	ra,24(sp)
ffffffffc0202408:	8522                	mv	a0,s0
ffffffffc020240a:	6442                	ld	s0,16(sp)
ffffffffc020240c:	64a2                	ld	s1,8(sp)
ffffffffc020240e:	6105                	addi	sp,sp,32
ffffffffc0202410:	8082                	ret
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
ffffffffc0202412:	00003617          	auipc	a2,0x3
ffffffffc0202416:	76660613          	addi	a2,a2,1894 # ffffffffc0205b78 <commands+0xc50>
ffffffffc020241a:	02800593          	li	a1,40
ffffffffc020241e:	00003517          	auipc	a0,0x3
ffffffffc0202422:	77a50513          	addi	a0,a0,1914 # ffffffffc0205b98 <commands+0xc70>
ffffffffc0202426:	ddbfd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020242a <swap_init_mm>:

int
swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
ffffffffc020242a:	00051797          	auipc	a5,0x51
ffffffffc020242e:	0667b783          	ld	a5,102(a5) # ffffffffc0253490 <sm>
ffffffffc0202432:	0107b303          	ld	t1,16(a5)
ffffffffc0202436:	8302                	jr	t1

ffffffffc0202438 <swap_map_swappable>:
}

int
swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
ffffffffc0202438:	00051797          	auipc	a5,0x51
ffffffffc020243c:	0587b783          	ld	a5,88(a5) # ffffffffc0253490 <sm>
ffffffffc0202440:	0207b303          	ld	t1,32(a5)
ffffffffc0202444:	8302                	jr	t1

ffffffffc0202446 <swap_out>:

volatile unsigned int swap_out_num=0;

int
swap_out(struct mm_struct *mm, int n, int in_tick)
{
ffffffffc0202446:	711d                	addi	sp,sp,-96
ffffffffc0202448:	ec86                	sd	ra,88(sp)
ffffffffc020244a:	e8a2                	sd	s0,80(sp)
ffffffffc020244c:	e4a6                	sd	s1,72(sp)
ffffffffc020244e:	e0ca                	sd	s2,64(sp)
ffffffffc0202450:	fc4e                	sd	s3,56(sp)
ffffffffc0202452:	f852                	sd	s4,48(sp)
ffffffffc0202454:	f456                	sd	s5,40(sp)
ffffffffc0202456:	f05a                	sd	s6,32(sp)
ffffffffc0202458:	ec5e                	sd	s7,24(sp)
ffffffffc020245a:	e862                	sd	s8,16(sp)
     int i;
     for (i = 0; i != n; ++ i)
ffffffffc020245c:	cde9                	beqz	a1,ffffffffc0202536 <swap_out+0xf0>
ffffffffc020245e:	8a2e                	mv	s4,a1
ffffffffc0202460:	892a                	mv	s2,a0
ffffffffc0202462:	8ab2                	mv	s5,a2
ffffffffc0202464:	4401                	li	s0,0
ffffffffc0202466:	00051997          	auipc	s3,0x51
ffffffffc020246a:	02a98993          	addi	s3,s3,42 # ffffffffc0253490 <sm>
                    cprintf("SWAP: failed to save\n");
                    sm->map_swappable(mm, v, page, 0);
                    continue;
          }
          else {
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc020246e:	00003b17          	auipc	s6,0x3
ffffffffc0202472:	7b2b0b13          	addi	s6,s6,1970 # ffffffffc0205c20 <commands+0xcf8>
                    cprintf("SWAP: failed to save\n");
ffffffffc0202476:	00003b97          	auipc	s7,0x3
ffffffffc020247a:	792b8b93          	addi	s7,s7,1938 # ffffffffc0205c08 <commands+0xce0>
ffffffffc020247e:	a825                	j	ffffffffc02024b6 <swap_out+0x70>
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc0202480:	67a2                	ld	a5,8(sp)
ffffffffc0202482:	8626                	mv	a2,s1
ffffffffc0202484:	85a2                	mv	a1,s0
ffffffffc0202486:	7f94                	ld	a3,56(a5)
ffffffffc0202488:	855a                	mv	a0,s6
     for (i = 0; i != n; ++ i)
ffffffffc020248a:	2405                	addiw	s0,s0,1
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc020248c:	82b1                	srli	a3,a3,0xc
ffffffffc020248e:	0685                	addi	a3,a3,1
ffffffffc0202490:	c35fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0202494:	6522                	ld	a0,8(sp)
                    free_page(page);
ffffffffc0202496:	4585                	li	a1,1
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc0202498:	7d1c                	ld	a5,56(a0)
ffffffffc020249a:	83b1                	srli	a5,a5,0xc
ffffffffc020249c:	0785                	addi	a5,a5,1
ffffffffc020249e:	07a2                	slli	a5,a5,0x8
ffffffffc02024a0:	00fc3023          	sd	a5,0(s8)
                    free_page(page);
ffffffffc02024a4:	90dfe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
          }
          
          tlb_invalidate(mm->pgdir, v);
ffffffffc02024a8:	01893503          	ld	a0,24(s2)
ffffffffc02024ac:	85a6                	mv	a1,s1
ffffffffc02024ae:	9a8ff0ef          	jal	ra,ffffffffc0201656 <tlb_invalidate>
     for (i = 0; i != n; ++ i)
ffffffffc02024b2:	048a0d63          	beq	s4,s0,ffffffffc020250c <swap_out+0xc6>
          int r = sm->swap_out_victim(mm, &page, in_tick);
ffffffffc02024b6:	0009b783          	ld	a5,0(s3)
ffffffffc02024ba:	8656                	mv	a2,s5
ffffffffc02024bc:	002c                	addi	a1,sp,8
ffffffffc02024be:	7b9c                	ld	a5,48(a5)
ffffffffc02024c0:	854a                	mv	a0,s2
ffffffffc02024c2:	9782                	jalr	a5
          if (r != 0) {
ffffffffc02024c4:	e12d                	bnez	a0,ffffffffc0202526 <swap_out+0xe0>
          v=page->pra_vaddr; 
ffffffffc02024c6:	67a2                	ld	a5,8(sp)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc02024c8:	01893503          	ld	a0,24(s2)
ffffffffc02024cc:	4601                	li	a2,0
          v=page->pra_vaddr; 
ffffffffc02024ce:	7f84                	ld	s1,56(a5)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc02024d0:	85a6                	mv	a1,s1
ffffffffc02024d2:	ab3fe0ef          	jal	ra,ffffffffc0200f84 <get_pte>
          assert((*ptep & PTE_V) != 0);
ffffffffc02024d6:	611c                	ld	a5,0(a0)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc02024d8:	8c2a                	mv	s8,a0
          assert((*ptep & PTE_V) != 0);
ffffffffc02024da:	8b85                	andi	a5,a5,1
ffffffffc02024dc:	cfb9                	beqz	a5,ffffffffc020253a <swap_out+0xf4>
          if (swapfs_write( (page->pra_vaddr/PGSIZE+1)<<8, page) != 0) {
ffffffffc02024de:	65a2                	ld	a1,8(sp)
ffffffffc02024e0:	7d9c                	ld	a5,56(a1)
ffffffffc02024e2:	83b1                	srli	a5,a5,0xc
ffffffffc02024e4:	0785                	addi	a5,a5,1
ffffffffc02024e6:	00879513          	slli	a0,a5,0x8
ffffffffc02024ea:	455000ef          	jal	ra,ffffffffc020313e <swapfs_write>
ffffffffc02024ee:	d949                	beqz	a0,ffffffffc0202480 <swap_out+0x3a>
                    cprintf("SWAP: failed to save\n");
ffffffffc02024f0:	855e                	mv	a0,s7
ffffffffc02024f2:	bd3fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                    sm->map_swappable(mm, v, page, 0);
ffffffffc02024f6:	0009b783          	ld	a5,0(s3)
ffffffffc02024fa:	6622                	ld	a2,8(sp)
ffffffffc02024fc:	4681                	li	a3,0
ffffffffc02024fe:	739c                	ld	a5,32(a5)
ffffffffc0202500:	85a6                	mv	a1,s1
ffffffffc0202502:	854a                	mv	a0,s2
     for (i = 0; i != n; ++ i)
ffffffffc0202504:	2405                	addiw	s0,s0,1
                    sm->map_swappable(mm, v, page, 0);
ffffffffc0202506:	9782                	jalr	a5
     for (i = 0; i != n; ++ i)
ffffffffc0202508:	fa8a17e3          	bne	s4,s0,ffffffffc02024b6 <swap_out+0x70>
     }
     return i;
}
ffffffffc020250c:	60e6                	ld	ra,88(sp)
ffffffffc020250e:	8522                	mv	a0,s0
ffffffffc0202510:	6446                	ld	s0,80(sp)
ffffffffc0202512:	64a6                	ld	s1,72(sp)
ffffffffc0202514:	6906                	ld	s2,64(sp)
ffffffffc0202516:	79e2                	ld	s3,56(sp)
ffffffffc0202518:	7a42                	ld	s4,48(sp)
ffffffffc020251a:	7aa2                	ld	s5,40(sp)
ffffffffc020251c:	7b02                	ld	s6,32(sp)
ffffffffc020251e:	6be2                	ld	s7,24(sp)
ffffffffc0202520:	6c42                	ld	s8,16(sp)
ffffffffc0202522:	6125                	addi	sp,sp,96
ffffffffc0202524:	8082                	ret
                    cprintf("i %d, swap_out: call swap_out_victim failed\n",i);
ffffffffc0202526:	85a2                	mv	a1,s0
ffffffffc0202528:	00003517          	auipc	a0,0x3
ffffffffc020252c:	69850513          	addi	a0,a0,1688 # ffffffffc0205bc0 <commands+0xc98>
ffffffffc0202530:	b95fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
                  break;
ffffffffc0202534:	bfe1                	j	ffffffffc020250c <swap_out+0xc6>
     for (i = 0; i != n; ++ i)
ffffffffc0202536:	4401                	li	s0,0
ffffffffc0202538:	bfd1                	j	ffffffffc020250c <swap_out+0xc6>
          assert((*ptep & PTE_V) != 0);
ffffffffc020253a:	00003697          	auipc	a3,0x3
ffffffffc020253e:	6b668693          	addi	a3,a3,1718 # ffffffffc0205bf0 <commands+0xcc8>
ffffffffc0202542:	00003617          	auipc	a2,0x3
ffffffffc0202546:	dd660613          	addi	a2,a2,-554 # ffffffffc0205318 <commands+0x3f0>
ffffffffc020254a:	06800593          	li	a1,104
ffffffffc020254e:	00003517          	auipc	a0,0x3
ffffffffc0202552:	64a50513          	addi	a0,a0,1610 # ffffffffc0205b98 <commands+0xc70>
ffffffffc0202556:	cabfd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020255a <swap_in>:

int
swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
ffffffffc020255a:	7179                	addi	sp,sp,-48
ffffffffc020255c:	e84a                	sd	s2,16(sp)
ffffffffc020255e:	892a                	mv	s2,a0
     struct Page *result = alloc_page();
ffffffffc0202560:	4505                	li	a0,1
{
ffffffffc0202562:	ec26                	sd	s1,24(sp)
ffffffffc0202564:	e44e                	sd	s3,8(sp)
ffffffffc0202566:	f406                	sd	ra,40(sp)
ffffffffc0202568:	f022                	sd	s0,32(sp)
ffffffffc020256a:	84ae                	mv	s1,a1
ffffffffc020256c:	89b2                	mv	s3,a2
     struct Page *result = alloc_page();
ffffffffc020256e:	fb0fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
     assert(result!=NULL);
ffffffffc0202572:	c129                	beqz	a0,ffffffffc02025b4 <swap_in+0x5a>

     pte_t *ptep = get_pte(mm->pgdir, addr, 0);
ffffffffc0202574:	842a                	mv	s0,a0
ffffffffc0202576:	01893503          	ld	a0,24(s2)
ffffffffc020257a:	4601                	li	a2,0
ffffffffc020257c:	85a6                	mv	a1,s1
ffffffffc020257e:	a07fe0ef          	jal	ra,ffffffffc0200f84 <get_pte>
ffffffffc0202582:	892a                	mv	s2,a0
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));
    
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0)
ffffffffc0202584:	6108                	ld	a0,0(a0)
ffffffffc0202586:	85a2                	mv	a1,s0
ffffffffc0202588:	329000ef          	jal	ra,ffffffffc02030b0 <swapfs_read>
     {
        assert(r!=0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep)>>8, addr);
ffffffffc020258c:	00093583          	ld	a1,0(s2)
ffffffffc0202590:	8626                	mv	a2,s1
ffffffffc0202592:	00003517          	auipc	a0,0x3
ffffffffc0202596:	6de50513          	addi	a0,a0,1758 # ffffffffc0205c70 <commands+0xd48>
ffffffffc020259a:	81a1                	srli	a1,a1,0x8
ffffffffc020259c:	b29fd0ef          	jal	ra,ffffffffc02000c4 <cprintf>
     *ptr_result=result;
     return 0;
}
ffffffffc02025a0:	70a2                	ld	ra,40(sp)
     *ptr_result=result;
ffffffffc02025a2:	0089b023          	sd	s0,0(s3)
}
ffffffffc02025a6:	7402                	ld	s0,32(sp)
ffffffffc02025a8:	64e2                	ld	s1,24(sp)
ffffffffc02025aa:	6942                	ld	s2,16(sp)
ffffffffc02025ac:	69a2                	ld	s3,8(sp)
ffffffffc02025ae:	4501                	li	a0,0
ffffffffc02025b0:	6145                	addi	sp,sp,48
ffffffffc02025b2:	8082                	ret
     assert(result!=NULL);
ffffffffc02025b4:	00003697          	auipc	a3,0x3
ffffffffc02025b8:	6ac68693          	addi	a3,a3,1708 # ffffffffc0205c60 <commands+0xd38>
ffffffffc02025bc:	00003617          	auipc	a2,0x3
ffffffffc02025c0:	d5c60613          	addi	a2,a2,-676 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02025c4:	07e00593          	li	a1,126
ffffffffc02025c8:	00003517          	auipc	a0,0x3
ffffffffc02025cc:	5d050513          	addi	a0,a0,1488 # ffffffffc0205b98 <commands+0xc70>
ffffffffc02025d0:	c31fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02025d4 <default_init>:
    elm->prev = elm->next = elm;
ffffffffc02025d4:	00051797          	auipc	a5,0x51
ffffffffc02025d8:	00478793          	addi	a5,a5,4 # ffffffffc02535d8 <free_area>
ffffffffc02025dc:	e79c                	sd	a5,8(a5)
ffffffffc02025de:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc02025e0:	0007a823          	sw	zero,16(a5)
}
ffffffffc02025e4:	8082                	ret

ffffffffc02025e6 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc02025e6:	00051517          	auipc	a0,0x51
ffffffffc02025ea:	00256503          	lwu	a0,2(a0) # ffffffffc02535e8 <free_area+0x10>
ffffffffc02025ee:	8082                	ret

ffffffffc02025f0 <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc02025f0:	715d                	addi	sp,sp,-80
ffffffffc02025f2:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc02025f4:	00051417          	auipc	s0,0x51
ffffffffc02025f8:	fe440413          	addi	s0,s0,-28 # ffffffffc02535d8 <free_area>
ffffffffc02025fc:	641c                	ld	a5,8(s0)
ffffffffc02025fe:	e486                	sd	ra,72(sp)
ffffffffc0202600:	fc26                	sd	s1,56(sp)
ffffffffc0202602:	f84a                	sd	s2,48(sp)
ffffffffc0202604:	f44e                	sd	s3,40(sp)
ffffffffc0202606:	f052                	sd	s4,32(sp)
ffffffffc0202608:	ec56                	sd	s5,24(sp)
ffffffffc020260a:	e85a                	sd	s6,16(sp)
ffffffffc020260c:	e45e                	sd	s7,8(sp)
ffffffffc020260e:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202610:	2a878d63          	beq	a5,s0,ffffffffc02028ca <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0202614:	4481                	li	s1,0
ffffffffc0202616:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0202618:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc020261c:	8b09                	andi	a4,a4,2
ffffffffc020261e:	2a070a63          	beqz	a4,ffffffffc02028d2 <default_check+0x2e2>
        count ++, total += p->property;
ffffffffc0202622:	ff87a703          	lw	a4,-8(a5)
ffffffffc0202626:	679c                	ld	a5,8(a5)
ffffffffc0202628:	2905                	addiw	s2,s2,1
ffffffffc020262a:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc020262c:	fe8796e3          	bne	a5,s0,ffffffffc0202618 <default_check+0x28>
ffffffffc0202630:	89a6                	mv	s3,s1
    }
    assert(total == nr_free_pages());
ffffffffc0202632:	fc0fe0ef          	jal	ra,ffffffffc0200df2 <nr_free_pages>
ffffffffc0202636:	6f351e63          	bne	a0,s3,ffffffffc0202d32 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020263a:	4505                	li	a0,1
ffffffffc020263c:	ee2fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202640:	8aaa                	mv	s5,a0
ffffffffc0202642:	42050863          	beqz	a0,ffffffffc0202a72 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202646:	4505                	li	a0,1
ffffffffc0202648:	ed6fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc020264c:	89aa                	mv	s3,a0
ffffffffc020264e:	70050263          	beqz	a0,ffffffffc0202d52 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202652:	4505                	li	a0,1
ffffffffc0202654:	ecafe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202658:	8a2a                	mv	s4,a0
ffffffffc020265a:	48050c63          	beqz	a0,ffffffffc0202af2 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc020265e:	293a8a63          	beq	s5,s3,ffffffffc02028f2 <default_check+0x302>
ffffffffc0202662:	28aa8863          	beq	s5,a0,ffffffffc02028f2 <default_check+0x302>
ffffffffc0202666:	28a98663          	beq	s3,a0,ffffffffc02028f2 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc020266a:	000aa783          	lw	a5,0(s5)
ffffffffc020266e:	2a079263          	bnez	a5,ffffffffc0202912 <default_check+0x322>
ffffffffc0202672:	0009a783          	lw	a5,0(s3)
ffffffffc0202676:	28079e63          	bnez	a5,ffffffffc0202912 <default_check+0x322>
ffffffffc020267a:	411c                	lw	a5,0(a0)
ffffffffc020267c:	28079b63          	bnez	a5,ffffffffc0202912 <default_check+0x322>
    return page - pages + nbase;
ffffffffc0202680:	00051797          	auipc	a5,0x51
ffffffffc0202684:	e707b783          	ld	a5,-400(a5) # ffffffffc02534f0 <pages>
ffffffffc0202688:	40fa8733          	sub	a4,s5,a5
ffffffffc020268c:	00005617          	auipc	a2,0x5
ffffffffc0202690:	b0463603          	ld	a2,-1276(a2) # ffffffffc0207190 <nbase>
ffffffffc0202694:	8719                	srai	a4,a4,0x6
ffffffffc0202696:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0202698:	00051697          	auipc	a3,0x51
ffffffffc020269c:	de06b683          	ld	a3,-544(a3) # ffffffffc0253478 <npage>
ffffffffc02026a0:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02026a2:	0732                	slli	a4,a4,0xc
ffffffffc02026a4:	28d77763          	bgeu	a4,a3,ffffffffc0202932 <default_check+0x342>
    return page - pages + nbase;
ffffffffc02026a8:	40f98733          	sub	a4,s3,a5
ffffffffc02026ac:	8719                	srai	a4,a4,0x6
ffffffffc02026ae:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026b0:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02026b2:	4cd77063          	bgeu	a4,a3,ffffffffc0202b72 <default_check+0x582>
    return page - pages + nbase;
ffffffffc02026b6:	40f507b3          	sub	a5,a0,a5
ffffffffc02026ba:	8799                	srai	a5,a5,0x6
ffffffffc02026bc:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026be:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02026c0:	30d7f963          	bgeu	a5,a3,ffffffffc02029d2 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02026c4:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02026c6:	00043c03          	ld	s8,0(s0)
ffffffffc02026ca:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc02026ce:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc02026d2:	e400                	sd	s0,8(s0)
ffffffffc02026d4:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc02026d6:	00051797          	auipc	a5,0x51
ffffffffc02026da:	f007a923          	sw	zero,-238(a5) # ffffffffc02535e8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc02026de:	e40fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02026e2:	2c051863          	bnez	a0,ffffffffc02029b2 <default_check+0x3c2>
    free_page(p0);
ffffffffc02026e6:	4585                	li	a1,1
ffffffffc02026e8:	8556                	mv	a0,s5
ffffffffc02026ea:	ec6fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_page(p1);
ffffffffc02026ee:	4585                	li	a1,1
ffffffffc02026f0:	854e                	mv	a0,s3
ffffffffc02026f2:	ebefe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_page(p2);
ffffffffc02026f6:	4585                	li	a1,1
ffffffffc02026f8:	8552                	mv	a0,s4
ffffffffc02026fa:	eb6fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    assert(nr_free == 3);
ffffffffc02026fe:	4818                	lw	a4,16(s0)
ffffffffc0202700:	478d                	li	a5,3
ffffffffc0202702:	28f71863          	bne	a4,a5,ffffffffc0202992 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202706:	4505                	li	a0,1
ffffffffc0202708:	e16fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc020270c:	89aa                	mv	s3,a0
ffffffffc020270e:	26050263          	beqz	a0,ffffffffc0202972 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202712:	4505                	li	a0,1
ffffffffc0202714:	e0afe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202718:	8aaa                	mv	s5,a0
ffffffffc020271a:	3a050c63          	beqz	a0,ffffffffc0202ad2 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020271e:	4505                	li	a0,1
ffffffffc0202720:	dfefe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202724:	8a2a                	mv	s4,a0
ffffffffc0202726:	38050663          	beqz	a0,ffffffffc0202ab2 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc020272a:	4505                	li	a0,1
ffffffffc020272c:	df2fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202730:	36051163          	bnez	a0,ffffffffc0202a92 <default_check+0x4a2>
    free_page(p0);
ffffffffc0202734:	4585                	li	a1,1
ffffffffc0202736:	854e                	mv	a0,s3
ffffffffc0202738:	e78fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc020273c:	641c                	ld	a5,8(s0)
ffffffffc020273e:	20878a63          	beq	a5,s0,ffffffffc0202952 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0202742:	4505                	li	a0,1
ffffffffc0202744:	ddafe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202748:	30a99563          	bne	s3,a0,ffffffffc0202a52 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc020274c:	4505                	li	a0,1
ffffffffc020274e:	dd0fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202752:	2e051063          	bnez	a0,ffffffffc0202a32 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0202756:	481c                	lw	a5,16(s0)
ffffffffc0202758:	2a079d63          	bnez	a5,ffffffffc0202a12 <default_check+0x422>
    free_page(p);
ffffffffc020275c:	854e                	mv	a0,s3
ffffffffc020275e:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0202760:	01843023          	sd	s8,0(s0)
ffffffffc0202764:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0202768:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc020276c:	e44fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_page(p1);
ffffffffc0202770:	4585                	li	a1,1
ffffffffc0202772:	8556                	mv	a0,s5
ffffffffc0202774:	e3cfe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_page(p2);
ffffffffc0202778:	4585                	li	a1,1
ffffffffc020277a:	8552                	mv	a0,s4
ffffffffc020277c:	e34fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0202780:	4515                	li	a0,5
ffffffffc0202782:	d9cfe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202786:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0202788:	26050563          	beqz	a0,ffffffffc02029f2 <default_check+0x402>
ffffffffc020278c:	651c                	ld	a5,8(a0)
ffffffffc020278e:	8385                	srli	a5,a5,0x1
ffffffffc0202790:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0202792:	54079063          	bnez	a5,ffffffffc0202cd2 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0202796:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0202798:	00043b03          	ld	s6,0(s0)
ffffffffc020279c:	00843a83          	ld	s5,8(s0)
ffffffffc02027a0:	e000                	sd	s0,0(s0)
ffffffffc02027a2:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02027a4:	d7afe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02027a8:	50051563          	bnez	a0,ffffffffc0202cb2 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02027ac:	08098a13          	addi	s4,s3,128
ffffffffc02027b0:	8552                	mv	a0,s4
ffffffffc02027b2:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02027b4:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02027b8:	00051797          	auipc	a5,0x51
ffffffffc02027bc:	e207a823          	sw	zero,-464(a5) # ffffffffc02535e8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02027c0:	df0fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02027c4:	4511                	li	a0,4
ffffffffc02027c6:	d58fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02027ca:	4c051463          	bnez	a0,ffffffffc0202c92 <default_check+0x6a2>
ffffffffc02027ce:	0889b783          	ld	a5,136(s3)
ffffffffc02027d2:	8385                	srli	a5,a5,0x1
ffffffffc02027d4:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02027d6:	48078e63          	beqz	a5,ffffffffc0202c72 <default_check+0x682>
ffffffffc02027da:	0909a703          	lw	a4,144(s3)
ffffffffc02027de:	478d                	li	a5,3
ffffffffc02027e0:	48f71963          	bne	a4,a5,ffffffffc0202c72 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02027e4:	450d                	li	a0,3
ffffffffc02027e6:	d38fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02027ea:	8c2a                	mv	s8,a0
ffffffffc02027ec:	46050363          	beqz	a0,ffffffffc0202c52 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc02027f0:	4505                	li	a0,1
ffffffffc02027f2:	d2cfe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02027f6:	42051e63          	bnez	a0,ffffffffc0202c32 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc02027fa:	418a1c63          	bne	s4,s8,ffffffffc0202c12 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc02027fe:	4585                	li	a1,1
ffffffffc0202800:	854e                	mv	a0,s3
ffffffffc0202802:	daefe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_pages(p1, 3);
ffffffffc0202806:	458d                	li	a1,3
ffffffffc0202808:	8552                	mv	a0,s4
ffffffffc020280a:	da6fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
ffffffffc020280e:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0202812:	04098c13          	addi	s8,s3,64
ffffffffc0202816:	8385                	srli	a5,a5,0x1
ffffffffc0202818:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc020281a:	3c078c63          	beqz	a5,ffffffffc0202bf2 <default_check+0x602>
ffffffffc020281e:	0109a703          	lw	a4,16(s3)
ffffffffc0202822:	4785                	li	a5,1
ffffffffc0202824:	3cf71763          	bne	a4,a5,ffffffffc0202bf2 <default_check+0x602>
ffffffffc0202828:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_ex1_out_size-0x8950>
ffffffffc020282c:	8385                	srli	a5,a5,0x1
ffffffffc020282e:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202830:	3a078163          	beqz	a5,ffffffffc0202bd2 <default_check+0x5e2>
ffffffffc0202834:	010a2703          	lw	a4,16(s4)
ffffffffc0202838:	478d                	li	a5,3
ffffffffc020283a:	38f71c63          	bne	a4,a5,ffffffffc0202bd2 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc020283e:	4505                	li	a0,1
ffffffffc0202840:	cdefe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202844:	36a99763          	bne	s3,a0,ffffffffc0202bb2 <default_check+0x5c2>
    free_page(p0);
ffffffffc0202848:	4585                	li	a1,1
ffffffffc020284a:	d66fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc020284e:	4509                	li	a0,2
ffffffffc0202850:	ccefe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202854:	32aa1f63          	bne	s4,a0,ffffffffc0202b92 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0202858:	4589                	li	a1,2
ffffffffc020285a:	d56fe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    free_page(p2);
ffffffffc020285e:	4585                	li	a1,1
ffffffffc0202860:	8562                	mv	a0,s8
ffffffffc0202862:	d4efe0ef          	jal	ra,ffffffffc0200db0 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202866:	4515                	li	a0,5
ffffffffc0202868:	cb6fe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc020286c:	89aa                	mv	s3,a0
ffffffffc020286e:	48050263          	beqz	a0,ffffffffc0202cf2 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0202872:	4505                	li	a0,1
ffffffffc0202874:	caafe0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc0202878:	2c051d63          	bnez	a0,ffffffffc0202b52 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc020287c:	481c                	lw	a5,16(s0)
ffffffffc020287e:	2a079a63          	bnez	a5,ffffffffc0202b32 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0202882:	4595                	li	a1,5
ffffffffc0202884:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0202886:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc020288a:	01643023          	sd	s6,0(s0)
ffffffffc020288e:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0202892:	d1efe0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    return listelm->next;
ffffffffc0202896:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202898:	00878963          	beq	a5,s0,ffffffffc02028aa <default_check+0x2ba>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc020289c:	ff87a703          	lw	a4,-8(a5)
ffffffffc02028a0:	679c                	ld	a5,8(a5)
ffffffffc02028a2:	397d                	addiw	s2,s2,-1
ffffffffc02028a4:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028a6:	fe879be3          	bne	a5,s0,ffffffffc020289c <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02028aa:	26091463          	bnez	s2,ffffffffc0202b12 <default_check+0x522>
    assert(total == 0);
ffffffffc02028ae:	46049263          	bnez	s1,ffffffffc0202d12 <default_check+0x722>
}
ffffffffc02028b2:	60a6                	ld	ra,72(sp)
ffffffffc02028b4:	6406                	ld	s0,64(sp)
ffffffffc02028b6:	74e2                	ld	s1,56(sp)
ffffffffc02028b8:	7942                	ld	s2,48(sp)
ffffffffc02028ba:	79a2                	ld	s3,40(sp)
ffffffffc02028bc:	7a02                	ld	s4,32(sp)
ffffffffc02028be:	6ae2                	ld	s5,24(sp)
ffffffffc02028c0:	6b42                	ld	s6,16(sp)
ffffffffc02028c2:	6ba2                	ld	s7,8(sp)
ffffffffc02028c4:	6c02                	ld	s8,0(sp)
ffffffffc02028c6:	6161                	addi	sp,sp,80
ffffffffc02028c8:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028ca:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02028cc:	4481                	li	s1,0
ffffffffc02028ce:	4901                	li	s2,0
ffffffffc02028d0:	b38d                	j	ffffffffc0202632 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02028d2:	00003697          	auipc	a3,0x3
ffffffffc02028d6:	3de68693          	addi	a3,a3,990 # ffffffffc0205cb0 <commands+0xd88>
ffffffffc02028da:	00003617          	auipc	a2,0x3
ffffffffc02028de:	a3e60613          	addi	a2,a2,-1474 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02028e2:	0f000593          	li	a1,240
ffffffffc02028e6:	00003517          	auipc	a0,0x3
ffffffffc02028ea:	3da50513          	addi	a0,a0,986 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc02028ee:	913fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc02028f2:	00003697          	auipc	a3,0x3
ffffffffc02028f6:	46668693          	addi	a3,a3,1126 # ffffffffc0205d58 <commands+0xe30>
ffffffffc02028fa:	00003617          	auipc	a2,0x3
ffffffffc02028fe:	a1e60613          	addi	a2,a2,-1506 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202902:	0bd00593          	li	a1,189
ffffffffc0202906:	00003517          	auipc	a0,0x3
ffffffffc020290a:	3ba50513          	addi	a0,a0,954 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc020290e:	8f3fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0202912:	00003697          	auipc	a3,0x3
ffffffffc0202916:	46e68693          	addi	a3,a3,1134 # ffffffffc0205d80 <commands+0xe58>
ffffffffc020291a:	00003617          	auipc	a2,0x3
ffffffffc020291e:	9fe60613          	addi	a2,a2,-1538 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202922:	0be00593          	li	a1,190
ffffffffc0202926:	00003517          	auipc	a0,0x3
ffffffffc020292a:	39a50513          	addi	a0,a0,922 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc020292e:	8d3fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0202932:	00003697          	auipc	a3,0x3
ffffffffc0202936:	48e68693          	addi	a3,a3,1166 # ffffffffc0205dc0 <commands+0xe98>
ffffffffc020293a:	00003617          	auipc	a2,0x3
ffffffffc020293e:	9de60613          	addi	a2,a2,-1570 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202942:	0c000593          	li	a1,192
ffffffffc0202946:	00003517          	auipc	a0,0x3
ffffffffc020294a:	37a50513          	addi	a0,a0,890 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc020294e:	8b3fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0202952:	00003697          	auipc	a3,0x3
ffffffffc0202956:	4f668693          	addi	a3,a3,1270 # ffffffffc0205e48 <commands+0xf20>
ffffffffc020295a:	00003617          	auipc	a2,0x3
ffffffffc020295e:	9be60613          	addi	a2,a2,-1602 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202962:	0d900593          	li	a1,217
ffffffffc0202966:	00003517          	auipc	a0,0x3
ffffffffc020296a:	35a50513          	addi	a0,a0,858 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc020296e:	893fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202972:	00003697          	auipc	a3,0x3
ffffffffc0202976:	38668693          	addi	a3,a3,902 # ffffffffc0205cf8 <commands+0xdd0>
ffffffffc020297a:	00003617          	auipc	a2,0x3
ffffffffc020297e:	99e60613          	addi	a2,a2,-1634 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202982:	0d200593          	li	a1,210
ffffffffc0202986:	00003517          	auipc	a0,0x3
ffffffffc020298a:	33a50513          	addi	a0,a0,826 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc020298e:	873fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 3);
ffffffffc0202992:	00003697          	auipc	a3,0x3
ffffffffc0202996:	4a668693          	addi	a3,a3,1190 # ffffffffc0205e38 <commands+0xf10>
ffffffffc020299a:	00003617          	auipc	a2,0x3
ffffffffc020299e:	97e60613          	addi	a2,a2,-1666 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02029a2:	0d000593          	li	a1,208
ffffffffc02029a6:	00003517          	auipc	a0,0x3
ffffffffc02029aa:	31a50513          	addi	a0,a0,794 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc02029ae:	853fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02029b2:	00003697          	auipc	a3,0x3
ffffffffc02029b6:	46e68693          	addi	a3,a3,1134 # ffffffffc0205e20 <commands+0xef8>
ffffffffc02029ba:	00003617          	auipc	a2,0x3
ffffffffc02029be:	95e60613          	addi	a2,a2,-1698 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02029c2:	0cb00593          	li	a1,203
ffffffffc02029c6:	00003517          	auipc	a0,0x3
ffffffffc02029ca:	2fa50513          	addi	a0,a0,762 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc02029ce:	833fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02029d2:	00003697          	auipc	a3,0x3
ffffffffc02029d6:	42e68693          	addi	a3,a3,1070 # ffffffffc0205e00 <commands+0xed8>
ffffffffc02029da:	00003617          	auipc	a2,0x3
ffffffffc02029de:	93e60613          	addi	a2,a2,-1730 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02029e2:	0c200593          	li	a1,194
ffffffffc02029e6:	00003517          	auipc	a0,0x3
ffffffffc02029ea:	2da50513          	addi	a0,a0,730 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc02029ee:	813fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 != NULL);
ffffffffc02029f2:	00003697          	auipc	a3,0x3
ffffffffc02029f6:	49e68693          	addi	a3,a3,1182 # ffffffffc0205e90 <commands+0xf68>
ffffffffc02029fa:	00003617          	auipc	a2,0x3
ffffffffc02029fe:	91e60613          	addi	a2,a2,-1762 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202a02:	0f800593          	li	a1,248
ffffffffc0202a06:	00003517          	auipc	a0,0x3
ffffffffc0202a0a:	2ba50513          	addi	a0,a0,698 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202a0e:	ff2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 0);
ffffffffc0202a12:	00003697          	auipc	a3,0x3
ffffffffc0202a16:	46e68693          	addi	a3,a3,1134 # ffffffffc0205e80 <commands+0xf58>
ffffffffc0202a1a:	00003617          	auipc	a2,0x3
ffffffffc0202a1e:	8fe60613          	addi	a2,a2,-1794 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202a22:	0df00593          	li	a1,223
ffffffffc0202a26:	00003517          	auipc	a0,0x3
ffffffffc0202a2a:	29a50513          	addi	a0,a0,666 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202a2e:	fd2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202a32:	00003697          	auipc	a3,0x3
ffffffffc0202a36:	3ee68693          	addi	a3,a3,1006 # ffffffffc0205e20 <commands+0xef8>
ffffffffc0202a3a:	00003617          	auipc	a2,0x3
ffffffffc0202a3e:	8de60613          	addi	a2,a2,-1826 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202a42:	0dd00593          	li	a1,221
ffffffffc0202a46:	00003517          	auipc	a0,0x3
ffffffffc0202a4a:	27a50513          	addi	a0,a0,634 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202a4e:	fb2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0202a52:	00003697          	auipc	a3,0x3
ffffffffc0202a56:	40e68693          	addi	a3,a3,1038 # ffffffffc0205e60 <commands+0xf38>
ffffffffc0202a5a:	00003617          	auipc	a2,0x3
ffffffffc0202a5e:	8be60613          	addi	a2,a2,-1858 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202a62:	0dc00593          	li	a1,220
ffffffffc0202a66:	00003517          	auipc	a0,0x3
ffffffffc0202a6a:	25a50513          	addi	a0,a0,602 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202a6e:	f92fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202a72:	00003697          	auipc	a3,0x3
ffffffffc0202a76:	28668693          	addi	a3,a3,646 # ffffffffc0205cf8 <commands+0xdd0>
ffffffffc0202a7a:	00003617          	auipc	a2,0x3
ffffffffc0202a7e:	89e60613          	addi	a2,a2,-1890 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202a82:	0b900593          	li	a1,185
ffffffffc0202a86:	00003517          	auipc	a0,0x3
ffffffffc0202a8a:	23a50513          	addi	a0,a0,570 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202a8e:	f72fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202a92:	00003697          	auipc	a3,0x3
ffffffffc0202a96:	38e68693          	addi	a3,a3,910 # ffffffffc0205e20 <commands+0xef8>
ffffffffc0202a9a:	00003617          	auipc	a2,0x3
ffffffffc0202a9e:	87e60613          	addi	a2,a2,-1922 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202aa2:	0d600593          	li	a1,214
ffffffffc0202aa6:	00003517          	auipc	a0,0x3
ffffffffc0202aaa:	21a50513          	addi	a0,a0,538 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202aae:	f52fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202ab2:	00003697          	auipc	a3,0x3
ffffffffc0202ab6:	28668693          	addi	a3,a3,646 # ffffffffc0205d38 <commands+0xe10>
ffffffffc0202aba:	00003617          	auipc	a2,0x3
ffffffffc0202abe:	85e60613          	addi	a2,a2,-1954 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ac2:	0d400593          	li	a1,212
ffffffffc0202ac6:	00003517          	auipc	a0,0x3
ffffffffc0202aca:	1fa50513          	addi	a0,a0,506 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202ace:	f32fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202ad2:	00003697          	auipc	a3,0x3
ffffffffc0202ad6:	24668693          	addi	a3,a3,582 # ffffffffc0205d18 <commands+0xdf0>
ffffffffc0202ada:	00003617          	auipc	a2,0x3
ffffffffc0202ade:	83e60613          	addi	a2,a2,-1986 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ae2:	0d300593          	li	a1,211
ffffffffc0202ae6:	00003517          	auipc	a0,0x3
ffffffffc0202aea:	1da50513          	addi	a0,a0,474 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202aee:	f12fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202af2:	00003697          	auipc	a3,0x3
ffffffffc0202af6:	24668693          	addi	a3,a3,582 # ffffffffc0205d38 <commands+0xe10>
ffffffffc0202afa:	00003617          	auipc	a2,0x3
ffffffffc0202afe:	81e60613          	addi	a2,a2,-2018 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202b02:	0bb00593          	li	a1,187
ffffffffc0202b06:	00003517          	auipc	a0,0x3
ffffffffc0202b0a:	1ba50513          	addi	a0,a0,442 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202b0e:	ef2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(count == 0);
ffffffffc0202b12:	00003697          	auipc	a3,0x3
ffffffffc0202b16:	4ce68693          	addi	a3,a3,1230 # ffffffffc0205fe0 <commands+0x10b8>
ffffffffc0202b1a:	00002617          	auipc	a2,0x2
ffffffffc0202b1e:	7fe60613          	addi	a2,a2,2046 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202b22:	12500593          	li	a1,293
ffffffffc0202b26:	00003517          	auipc	a0,0x3
ffffffffc0202b2a:	19a50513          	addi	a0,a0,410 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202b2e:	ed2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_free == 0);
ffffffffc0202b32:	00003697          	auipc	a3,0x3
ffffffffc0202b36:	34e68693          	addi	a3,a3,846 # ffffffffc0205e80 <commands+0xf58>
ffffffffc0202b3a:	00002617          	auipc	a2,0x2
ffffffffc0202b3e:	7de60613          	addi	a2,a2,2014 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202b42:	11a00593          	li	a1,282
ffffffffc0202b46:	00003517          	auipc	a0,0x3
ffffffffc0202b4a:	17a50513          	addi	a0,a0,378 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202b4e:	eb2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202b52:	00003697          	auipc	a3,0x3
ffffffffc0202b56:	2ce68693          	addi	a3,a3,718 # ffffffffc0205e20 <commands+0xef8>
ffffffffc0202b5a:	00002617          	auipc	a2,0x2
ffffffffc0202b5e:	7be60613          	addi	a2,a2,1982 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202b62:	11800593          	li	a1,280
ffffffffc0202b66:	00003517          	auipc	a0,0x3
ffffffffc0202b6a:	15a50513          	addi	a0,a0,346 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202b6e:	e92fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0202b72:	00003697          	auipc	a3,0x3
ffffffffc0202b76:	26e68693          	addi	a3,a3,622 # ffffffffc0205de0 <commands+0xeb8>
ffffffffc0202b7a:	00002617          	auipc	a2,0x2
ffffffffc0202b7e:	79e60613          	addi	a2,a2,1950 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202b82:	0c100593          	li	a1,193
ffffffffc0202b86:	00003517          	auipc	a0,0x3
ffffffffc0202b8a:	13a50513          	addi	a0,a0,314 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202b8e:	e72fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0202b92:	00003697          	auipc	a3,0x3
ffffffffc0202b96:	40e68693          	addi	a3,a3,1038 # ffffffffc0205fa0 <commands+0x1078>
ffffffffc0202b9a:	00002617          	auipc	a2,0x2
ffffffffc0202b9e:	77e60613          	addi	a2,a2,1918 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ba2:	11200593          	li	a1,274
ffffffffc0202ba6:	00003517          	auipc	a0,0x3
ffffffffc0202baa:	11a50513          	addi	a0,a0,282 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202bae:	e52fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202bb2:	00003697          	auipc	a3,0x3
ffffffffc0202bb6:	3ce68693          	addi	a3,a3,974 # ffffffffc0205f80 <commands+0x1058>
ffffffffc0202bba:	00002617          	auipc	a2,0x2
ffffffffc0202bbe:	75e60613          	addi	a2,a2,1886 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202bc2:	11000593          	li	a1,272
ffffffffc0202bc6:	00003517          	auipc	a0,0x3
ffffffffc0202bca:	0fa50513          	addi	a0,a0,250 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202bce:	e32fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202bd2:	00003697          	auipc	a3,0x3
ffffffffc0202bd6:	38668693          	addi	a3,a3,902 # ffffffffc0205f58 <commands+0x1030>
ffffffffc0202bda:	00002617          	auipc	a2,0x2
ffffffffc0202bde:	73e60613          	addi	a2,a2,1854 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202be2:	10e00593          	li	a1,270
ffffffffc0202be6:	00003517          	auipc	a0,0x3
ffffffffc0202bea:	0da50513          	addi	a0,a0,218 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202bee:	e12fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202bf2:	00003697          	auipc	a3,0x3
ffffffffc0202bf6:	33e68693          	addi	a3,a3,830 # ffffffffc0205f30 <commands+0x1008>
ffffffffc0202bfa:	00002617          	auipc	a2,0x2
ffffffffc0202bfe:	71e60613          	addi	a2,a2,1822 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202c02:	10d00593          	li	a1,269
ffffffffc0202c06:	00003517          	auipc	a0,0x3
ffffffffc0202c0a:	0ba50513          	addi	a0,a0,186 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202c0e:	df2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0202c12:	00003697          	auipc	a3,0x3
ffffffffc0202c16:	30e68693          	addi	a3,a3,782 # ffffffffc0205f20 <commands+0xff8>
ffffffffc0202c1a:	00002617          	auipc	a2,0x2
ffffffffc0202c1e:	6fe60613          	addi	a2,a2,1790 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202c22:	10800593          	li	a1,264
ffffffffc0202c26:	00003517          	auipc	a0,0x3
ffffffffc0202c2a:	09a50513          	addi	a0,a0,154 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202c2e:	dd2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202c32:	00003697          	auipc	a3,0x3
ffffffffc0202c36:	1ee68693          	addi	a3,a3,494 # ffffffffc0205e20 <commands+0xef8>
ffffffffc0202c3a:	00002617          	auipc	a2,0x2
ffffffffc0202c3e:	6de60613          	addi	a2,a2,1758 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202c42:	10700593          	li	a1,263
ffffffffc0202c46:	00003517          	auipc	a0,0x3
ffffffffc0202c4a:	07a50513          	addi	a0,a0,122 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202c4e:	db2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0202c52:	00003697          	auipc	a3,0x3
ffffffffc0202c56:	2ae68693          	addi	a3,a3,686 # ffffffffc0205f00 <commands+0xfd8>
ffffffffc0202c5a:	00002617          	auipc	a2,0x2
ffffffffc0202c5e:	6be60613          	addi	a2,a2,1726 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202c62:	10600593          	li	a1,262
ffffffffc0202c66:	00003517          	auipc	a0,0x3
ffffffffc0202c6a:	05a50513          	addi	a0,a0,90 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202c6e:	d92fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0202c72:	00003697          	auipc	a3,0x3
ffffffffc0202c76:	25e68693          	addi	a3,a3,606 # ffffffffc0205ed0 <commands+0xfa8>
ffffffffc0202c7a:	00002617          	auipc	a2,0x2
ffffffffc0202c7e:	69e60613          	addi	a2,a2,1694 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202c82:	10500593          	li	a1,261
ffffffffc0202c86:	00003517          	auipc	a0,0x3
ffffffffc0202c8a:	03a50513          	addi	a0,a0,58 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202c8e:	d72fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0202c92:	00003697          	auipc	a3,0x3
ffffffffc0202c96:	22668693          	addi	a3,a3,550 # ffffffffc0205eb8 <commands+0xf90>
ffffffffc0202c9a:	00002617          	auipc	a2,0x2
ffffffffc0202c9e:	67e60613          	addi	a2,a2,1662 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ca2:	10400593          	li	a1,260
ffffffffc0202ca6:	00003517          	auipc	a0,0x3
ffffffffc0202caa:	01a50513          	addi	a0,a0,26 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202cae:	d52fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202cb2:	00003697          	auipc	a3,0x3
ffffffffc0202cb6:	16e68693          	addi	a3,a3,366 # ffffffffc0205e20 <commands+0xef8>
ffffffffc0202cba:	00002617          	auipc	a2,0x2
ffffffffc0202cbe:	65e60613          	addi	a2,a2,1630 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202cc2:	0fe00593          	li	a1,254
ffffffffc0202cc6:	00003517          	auipc	a0,0x3
ffffffffc0202cca:	ffa50513          	addi	a0,a0,-6 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202cce:	d32fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(!PageProperty(p0));
ffffffffc0202cd2:	00003697          	auipc	a3,0x3
ffffffffc0202cd6:	1ce68693          	addi	a3,a3,462 # ffffffffc0205ea0 <commands+0xf78>
ffffffffc0202cda:	00002617          	auipc	a2,0x2
ffffffffc0202cde:	63e60613          	addi	a2,a2,1598 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ce2:	0f900593          	li	a1,249
ffffffffc0202ce6:	00003517          	auipc	a0,0x3
ffffffffc0202cea:	fda50513          	addi	a0,a0,-38 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202cee:	d12fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202cf2:	00003697          	auipc	a3,0x3
ffffffffc0202cf6:	2ce68693          	addi	a3,a3,718 # ffffffffc0205fc0 <commands+0x1098>
ffffffffc0202cfa:	00002617          	auipc	a2,0x2
ffffffffc0202cfe:	61e60613          	addi	a2,a2,1566 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202d02:	11700593          	li	a1,279
ffffffffc0202d06:	00003517          	auipc	a0,0x3
ffffffffc0202d0a:	fba50513          	addi	a0,a0,-70 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202d0e:	cf2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(total == 0);
ffffffffc0202d12:	00003697          	auipc	a3,0x3
ffffffffc0202d16:	2de68693          	addi	a3,a3,734 # ffffffffc0205ff0 <commands+0x10c8>
ffffffffc0202d1a:	00002617          	auipc	a2,0x2
ffffffffc0202d1e:	5fe60613          	addi	a2,a2,1534 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202d22:	12600593          	li	a1,294
ffffffffc0202d26:	00003517          	auipc	a0,0x3
ffffffffc0202d2a:	f9a50513          	addi	a0,a0,-102 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202d2e:	cd2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(total == nr_free_pages());
ffffffffc0202d32:	00003697          	auipc	a3,0x3
ffffffffc0202d36:	fa668693          	addi	a3,a3,-90 # ffffffffc0205cd8 <commands+0xdb0>
ffffffffc0202d3a:	00002617          	auipc	a2,0x2
ffffffffc0202d3e:	5de60613          	addi	a2,a2,1502 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202d42:	0f300593          	li	a1,243
ffffffffc0202d46:	00003517          	auipc	a0,0x3
ffffffffc0202d4a:	f7a50513          	addi	a0,a0,-134 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202d4e:	cb2fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202d52:	00003697          	auipc	a3,0x3
ffffffffc0202d56:	fc668693          	addi	a3,a3,-58 # ffffffffc0205d18 <commands+0xdf0>
ffffffffc0202d5a:	00002617          	auipc	a2,0x2
ffffffffc0202d5e:	5be60613          	addi	a2,a2,1470 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202d62:	0ba00593          	li	a1,186
ffffffffc0202d66:	00003517          	auipc	a0,0x3
ffffffffc0202d6a:	f5a50513          	addi	a0,a0,-166 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202d6e:	c92fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202d72 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0202d72:	1141                	addi	sp,sp,-16
ffffffffc0202d74:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202d76:	12058f63          	beqz	a1,ffffffffc0202eb4 <default_free_pages+0x142>
    for (; p != base + n; p ++) {
ffffffffc0202d7a:	00659693          	slli	a3,a1,0x6
ffffffffc0202d7e:	96aa                	add	a3,a3,a0
ffffffffc0202d80:	87aa                	mv	a5,a0
ffffffffc0202d82:	02d50263          	beq	a0,a3,ffffffffc0202da6 <default_free_pages+0x34>
ffffffffc0202d86:	6798                	ld	a4,8(a5)
ffffffffc0202d88:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202d8a:	10071563          	bnez	a4,ffffffffc0202e94 <default_free_pages+0x122>
ffffffffc0202d8e:	6798                	ld	a4,8(a5)
ffffffffc0202d90:	8b09                	andi	a4,a4,2
ffffffffc0202d92:	10071163          	bnez	a4,ffffffffc0202e94 <default_free_pages+0x122>
        p->flags = 0;
ffffffffc0202d96:	0007b423          	sd	zero,8(a5)
    page->ref = val;
ffffffffc0202d9a:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202d9e:	04078793          	addi	a5,a5,64
ffffffffc0202da2:	fed792e3          	bne	a5,a3,ffffffffc0202d86 <default_free_pages+0x14>
    base->property = n;
ffffffffc0202da6:	2581                	sext.w	a1,a1
ffffffffc0202da8:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc0202daa:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202dae:	4789                	li	a5,2
ffffffffc0202db0:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0202db4:	00051697          	auipc	a3,0x51
ffffffffc0202db8:	82468693          	addi	a3,a3,-2012 # ffffffffc02535d8 <free_area>
ffffffffc0202dbc:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0202dbe:	669c                	ld	a5,8(a3)
ffffffffc0202dc0:	01850613          	addi	a2,a0,24
ffffffffc0202dc4:	9db9                	addw	a1,a1,a4
ffffffffc0202dc6:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202dc8:	08d78f63          	beq	a5,a3,ffffffffc0202e66 <default_free_pages+0xf4>
            struct Page* page = le2page(le, page_link);
ffffffffc0202dcc:	fe878713          	addi	a4,a5,-24
ffffffffc0202dd0:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0202dd4:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202dd6:	00e56a63          	bltu	a0,a4,ffffffffc0202dea <default_free_pages+0x78>
    return listelm->next;
ffffffffc0202dda:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202ddc:	04d70a63          	beq	a4,a3,ffffffffc0202e30 <default_free_pages+0xbe>
    for (; p != base + n; p ++) {
ffffffffc0202de0:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0202de2:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202de6:	fee57ae3          	bgeu	a0,a4,ffffffffc0202dda <default_free_pages+0x68>
ffffffffc0202dea:	c199                	beqz	a1,ffffffffc0202df0 <default_free_pages+0x7e>
ffffffffc0202dec:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202df0:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc0202df2:	e390                	sd	a2,0(a5)
ffffffffc0202df4:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202df6:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202df8:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0202dfa:	00d70c63          	beq	a4,a3,ffffffffc0202e12 <default_free_pages+0xa0>
        if (p + p->property == base) {
ffffffffc0202dfe:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0202e02:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base) {
ffffffffc0202e06:	02059793          	slli	a5,a1,0x20
ffffffffc0202e0a:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e0c:	97b2                	add	a5,a5,a2
ffffffffc0202e0e:	02f50b63          	beq	a0,a5,ffffffffc0202e44 <default_free_pages+0xd2>
ffffffffc0202e12:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0202e14:	00d70b63          	beq	a4,a3,ffffffffc0202e2a <default_free_pages+0xb8>
        if (base + base->property == p) {
ffffffffc0202e18:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0202e1a:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0202e1e:	02061793          	slli	a5,a2,0x20
ffffffffc0202e22:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e24:	97aa                	add	a5,a5,a0
ffffffffc0202e26:	04f68763          	beq	a3,a5,ffffffffc0202e74 <default_free_pages+0x102>
}
ffffffffc0202e2a:	60a2                	ld	ra,8(sp)
ffffffffc0202e2c:	0141                	addi	sp,sp,16
ffffffffc0202e2e:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202e30:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202e32:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202e34:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202e36:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e38:	02d70463          	beq	a4,a3,ffffffffc0202e60 <default_free_pages+0xee>
    prev->next = next->prev = elm;
ffffffffc0202e3c:	8832                	mv	a6,a2
ffffffffc0202e3e:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0202e40:	87ba                	mv	a5,a4
ffffffffc0202e42:	b745                	j	ffffffffc0202de2 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0202e44:	491c                	lw	a5,16(a0)
ffffffffc0202e46:	9dbd                	addw	a1,a1,a5
ffffffffc0202e48:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202e4c:	57f5                	li	a5,-3
ffffffffc0202e4e:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202e52:	6d0c                	ld	a1,24(a0)
ffffffffc0202e54:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0202e56:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc0202e58:	e59c                	sd	a5,8(a1)
    next->prev = prev;
ffffffffc0202e5a:	6718                	ld	a4,8(a4)
ffffffffc0202e5c:	e38c                	sd	a1,0(a5)
ffffffffc0202e5e:	bf5d                	j	ffffffffc0202e14 <default_free_pages+0xa2>
ffffffffc0202e60:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e62:	873e                	mv	a4,a5
ffffffffc0202e64:	bf69                	j	ffffffffc0202dfe <default_free_pages+0x8c>
}
ffffffffc0202e66:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0202e68:	e390                	sd	a2,0(a5)
ffffffffc0202e6a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202e6c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202e6e:	ed1c                	sd	a5,24(a0)
ffffffffc0202e70:	0141                	addi	sp,sp,16
ffffffffc0202e72:	8082                	ret
            base->property += p->property;
ffffffffc0202e74:	ff872783          	lw	a5,-8(a4)
ffffffffc0202e78:	ff070693          	addi	a3,a4,-16
ffffffffc0202e7c:	9e3d                	addw	a2,a2,a5
ffffffffc0202e7e:	c910                	sw	a2,16(a0)
ffffffffc0202e80:	57f5                	li	a5,-3
ffffffffc0202e82:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202e86:	6314                	ld	a3,0(a4)
ffffffffc0202e88:	671c                	ld	a5,8(a4)
}
ffffffffc0202e8a:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0202e8c:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc0202e8e:	e394                	sd	a3,0(a5)
ffffffffc0202e90:	0141                	addi	sp,sp,16
ffffffffc0202e92:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202e94:	00003697          	auipc	a3,0x3
ffffffffc0202e98:	17468693          	addi	a3,a3,372 # ffffffffc0206008 <commands+0x10e0>
ffffffffc0202e9c:	00002617          	auipc	a2,0x2
ffffffffc0202ea0:	47c60613          	addi	a2,a2,1148 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ea4:	08300593          	li	a1,131
ffffffffc0202ea8:	00003517          	auipc	a0,0x3
ffffffffc0202eac:	e1850513          	addi	a0,a0,-488 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202eb0:	b50fd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(n > 0);
ffffffffc0202eb4:	00003697          	auipc	a3,0x3
ffffffffc0202eb8:	14c68693          	addi	a3,a3,332 # ffffffffc0206000 <commands+0x10d8>
ffffffffc0202ebc:	00002617          	auipc	a2,0x2
ffffffffc0202ec0:	45c60613          	addi	a2,a2,1116 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202ec4:	08000593          	li	a1,128
ffffffffc0202ec8:	00003517          	auipc	a0,0x3
ffffffffc0202ecc:	df850513          	addi	a0,a0,-520 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0202ed0:	b30fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202ed4 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0202ed4:	c941                	beqz	a0,ffffffffc0202f64 <default_alloc_pages+0x90>
    if (n > nr_free) {
ffffffffc0202ed6:	00050597          	auipc	a1,0x50
ffffffffc0202eda:	70258593          	addi	a1,a1,1794 # ffffffffc02535d8 <free_area>
ffffffffc0202ede:	0105a803          	lw	a6,16(a1)
ffffffffc0202ee2:	872a                	mv	a4,a0
ffffffffc0202ee4:	02081793          	slli	a5,a6,0x20
ffffffffc0202ee8:	9381                	srli	a5,a5,0x20
ffffffffc0202eea:	00a7ee63          	bltu	a5,a0,ffffffffc0202f06 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0202eee:	87ae                	mv	a5,a1
ffffffffc0202ef0:	a801                	j	ffffffffc0202f00 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc0202ef2:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202ef6:	02069613          	slli	a2,a3,0x20
ffffffffc0202efa:	9201                	srli	a2,a2,0x20
ffffffffc0202efc:	00e67763          	bgeu	a2,a4,ffffffffc0202f0a <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0202f00:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202f02:	feb798e3          	bne	a5,a1,ffffffffc0202ef2 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202f06:	4501                	li	a0,0
}
ffffffffc0202f08:	8082                	ret
    return listelm->prev;
ffffffffc0202f0a:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202f0e:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0202f12:	fe878513          	addi	a0,a5,-24
    prev->next = next;
ffffffffc0202f16:	00070e1b          	sext.w	t3,a4
ffffffffc0202f1a:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0202f1e:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc0202f22:	02c77863          	bgeu	a4,a2,ffffffffc0202f52 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202f26:	071a                	slli	a4,a4,0x6
ffffffffc0202f28:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202f2a:	41c686bb          	subw	a3,a3,t3
ffffffffc0202f2e:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202f30:	00870613          	addi	a2,a4,8
ffffffffc0202f34:	4689                	li	a3,2
ffffffffc0202f36:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202f3a:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0202f3e:	01870613          	addi	a2,a4,24
    prev->next = next->prev = elm;
ffffffffc0202f42:	0105a803          	lw	a6,16(a1)
ffffffffc0202f46:	e290                	sd	a2,0(a3)
ffffffffc0202f48:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0202f4c:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0202f4e:	01173c23          	sd	a7,24(a4)
        nr_free -= n;
ffffffffc0202f52:	41c8083b          	subw	a6,a6,t3
ffffffffc0202f56:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202f5a:	5775                	li	a4,-3
ffffffffc0202f5c:	17c1                	addi	a5,a5,-16
ffffffffc0202f5e:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0202f62:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc0202f64:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0202f66:	00003697          	auipc	a3,0x3
ffffffffc0202f6a:	09a68693          	addi	a3,a3,154 # ffffffffc0206000 <commands+0x10d8>
ffffffffc0202f6e:	00002617          	auipc	a2,0x2
ffffffffc0202f72:	3aa60613          	addi	a2,a2,938 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0202f76:	06200593          	li	a1,98
ffffffffc0202f7a:	00003517          	auipc	a0,0x3
ffffffffc0202f7e:	d4650513          	addi	a0,a0,-698 # ffffffffc0205cc0 <commands+0xd98>
default_alloc_pages(size_t n) {
ffffffffc0202f82:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202f84:	a7cfd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0202f88 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc0202f88:	1141                	addi	sp,sp,-16
ffffffffc0202f8a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202f8c:	c5f1                	beqz	a1,ffffffffc0203058 <default_init_memmap+0xd0>
    for (; p != base + n; p ++) {
ffffffffc0202f8e:	00659693          	slli	a3,a1,0x6
ffffffffc0202f92:	96aa                	add	a3,a3,a0
ffffffffc0202f94:	87aa                	mv	a5,a0
ffffffffc0202f96:	00d50f63          	beq	a0,a3,ffffffffc0202fb4 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0202f9a:	6798                	ld	a4,8(a5)
ffffffffc0202f9c:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc0202f9e:	cf49                	beqz	a4,ffffffffc0203038 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc0202fa0:	0007a823          	sw	zero,16(a5)
ffffffffc0202fa4:	0007b423          	sd	zero,8(a5)
ffffffffc0202fa8:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202fac:	04078793          	addi	a5,a5,64
ffffffffc0202fb0:	fed795e3          	bne	a5,a3,ffffffffc0202f9a <default_init_memmap+0x12>
    base->property = n;
ffffffffc0202fb4:	2581                	sext.w	a1,a1
ffffffffc0202fb6:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202fb8:	4789                	li	a5,2
ffffffffc0202fba:	00850713          	addi	a4,a0,8
ffffffffc0202fbe:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0202fc2:	00050697          	auipc	a3,0x50
ffffffffc0202fc6:	61668693          	addi	a3,a3,1558 # ffffffffc02535d8 <free_area>
ffffffffc0202fca:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0202fcc:	669c                	ld	a5,8(a3)
ffffffffc0202fce:	01850613          	addi	a2,a0,24
ffffffffc0202fd2:	9db9                	addw	a1,a1,a4
ffffffffc0202fd4:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202fd6:	04d78a63          	beq	a5,a3,ffffffffc020302a <default_init_memmap+0xa2>
            struct Page* page = le2page(le, page_link);
ffffffffc0202fda:	fe878713          	addi	a4,a5,-24
ffffffffc0202fde:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0202fe2:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202fe4:	00e56a63          	bltu	a0,a4,ffffffffc0202ff8 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0202fe8:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202fea:	02d70263          	beq	a4,a3,ffffffffc020300e <default_init_memmap+0x86>
    for (; p != base + n; p ++) {
ffffffffc0202fee:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0202ff0:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202ff4:	fee57ae3          	bgeu	a0,a4,ffffffffc0202fe8 <default_init_memmap+0x60>
ffffffffc0202ff8:	c199                	beqz	a1,ffffffffc0202ffe <default_init_memmap+0x76>
ffffffffc0202ffa:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202ffe:	6398                	ld	a4,0(a5)
}
ffffffffc0203000:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0203002:	e390                	sd	a2,0(a5)
ffffffffc0203004:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0203006:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0203008:	ed18                	sd	a4,24(a0)
ffffffffc020300a:	0141                	addi	sp,sp,16
ffffffffc020300c:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020300e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203010:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0203012:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0203014:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0203016:	00d70663          	beq	a4,a3,ffffffffc0203022 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc020301a:	8832                	mv	a6,a2
ffffffffc020301c:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020301e:	87ba                	mv	a5,a4
ffffffffc0203020:	bfc1                	j	ffffffffc0202ff0 <default_init_memmap+0x68>
}
ffffffffc0203022:	60a2                	ld	ra,8(sp)
ffffffffc0203024:	e290                	sd	a2,0(a3)
ffffffffc0203026:	0141                	addi	sp,sp,16
ffffffffc0203028:	8082                	ret
ffffffffc020302a:	60a2                	ld	ra,8(sp)
ffffffffc020302c:	e390                	sd	a2,0(a5)
ffffffffc020302e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203030:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0203032:	ed1c                	sd	a5,24(a0)
ffffffffc0203034:	0141                	addi	sp,sp,16
ffffffffc0203036:	8082                	ret
        assert(PageReserved(p));
ffffffffc0203038:	00003697          	auipc	a3,0x3
ffffffffc020303c:	ff868693          	addi	a3,a3,-8 # ffffffffc0206030 <commands+0x1108>
ffffffffc0203040:	00002617          	auipc	a2,0x2
ffffffffc0203044:	2d860613          	addi	a2,a2,728 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203048:	04900593          	li	a1,73
ffffffffc020304c:	00003517          	auipc	a0,0x3
ffffffffc0203050:	c7450513          	addi	a0,a0,-908 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0203054:	9acfd0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(n > 0);
ffffffffc0203058:	00003697          	auipc	a3,0x3
ffffffffc020305c:	fa868693          	addi	a3,a3,-88 # ffffffffc0206000 <commands+0x10d8>
ffffffffc0203060:	00002617          	auipc	a2,0x2
ffffffffc0203064:	2b860613          	addi	a2,a2,696 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203068:	04600593          	li	a1,70
ffffffffc020306c:	00003517          	auipc	a0,0x3
ffffffffc0203070:	c5450513          	addi	a0,a0,-940 # ffffffffc0205cc0 <commands+0xd98>
ffffffffc0203074:	98cfd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203078 <swapfs_init>:
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void
swapfs_init(void) {
ffffffffc0203078:	1141                	addi	sp,sp,-16
    static_assert((PGSIZE % SECTSIZE) == 0);
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc020307a:	4505                	li	a0,1
swapfs_init(void) {
ffffffffc020307c:	e406                	sd	ra,8(sp)
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc020307e:	c9cfd0ef          	jal	ra,ffffffffc020051a <ide_device_valid>
ffffffffc0203082:	cd01                	beqz	a0,ffffffffc020309a <swapfs_init+0x22>
        panic("swap fs isn't available.\n");
    }
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc0203084:	4505                	li	a0,1
ffffffffc0203086:	c9afd0ef          	jal	ra,ffffffffc0200520 <ide_device_size>
}
ffffffffc020308a:	60a2                	ld	ra,8(sp)
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc020308c:	810d                	srli	a0,a0,0x3
ffffffffc020308e:	00050797          	auipc	a5,0x50
ffffffffc0203092:	50a7b523          	sd	a0,1290(a5) # ffffffffc0253598 <max_swap_offset>
}
ffffffffc0203096:	0141                	addi	sp,sp,16
ffffffffc0203098:	8082                	ret
        panic("swap fs isn't available.\n");
ffffffffc020309a:	00003617          	auipc	a2,0x3
ffffffffc020309e:	ff660613          	addi	a2,a2,-10 # ffffffffc0206090 <default_pmm_manager+0x38>
ffffffffc02030a2:	45b5                	li	a1,13
ffffffffc02030a4:	00003517          	auipc	a0,0x3
ffffffffc02030a8:	00c50513          	addi	a0,a0,12 # ffffffffc02060b0 <default_pmm_manager+0x58>
ffffffffc02030ac:	954fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02030b0 <swapfs_read>:

int
swapfs_read(swap_entry_t entry, struct Page *page) {
ffffffffc02030b0:	1141                	addi	sp,sp,-16
ffffffffc02030b2:	e406                	sd	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030b4:	00855793          	srli	a5,a0,0x8
ffffffffc02030b8:	cbb1                	beqz	a5,ffffffffc020310c <swapfs_read+0x5c>
ffffffffc02030ba:	00050717          	auipc	a4,0x50
ffffffffc02030be:	4de73703          	ld	a4,1246(a4) # ffffffffc0253598 <max_swap_offset>
ffffffffc02030c2:	04e7f563          	bgeu	a5,a4,ffffffffc020310c <swapfs_read+0x5c>
    return page - pages + nbase;
ffffffffc02030c6:	00050617          	auipc	a2,0x50
ffffffffc02030ca:	42a63603          	ld	a2,1066(a2) # ffffffffc02534f0 <pages>
ffffffffc02030ce:	8d91                	sub	a1,a1,a2
ffffffffc02030d0:	4065d613          	srai	a2,a1,0x6
ffffffffc02030d4:	00004717          	auipc	a4,0x4
ffffffffc02030d8:	0bc73703          	ld	a4,188(a4) # ffffffffc0207190 <nbase>
ffffffffc02030dc:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc02030de:	00c61713          	slli	a4,a2,0xc
ffffffffc02030e2:	8331                	srli	a4,a4,0xc
ffffffffc02030e4:	00050697          	auipc	a3,0x50
ffffffffc02030e8:	3946b683          	ld	a3,916(a3) # ffffffffc0253478 <npage>
ffffffffc02030ec:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc02030f0:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc02030f2:	02d77963          	bgeu	a4,a3,ffffffffc0203124 <swapfs_read+0x74>
}
ffffffffc02030f6:	60a2                	ld	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030f8:	00050797          	auipc	a5,0x50
ffffffffc02030fc:	3e87b783          	ld	a5,1000(a5) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0203100:	46a1                	li	a3,8
ffffffffc0203102:	963e                	add	a2,a2,a5
ffffffffc0203104:	4505                	li	a0,1
}
ffffffffc0203106:	0141                	addi	sp,sp,16
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203108:	c1efd06f          	j	ffffffffc0200526 <ide_read_secs>
ffffffffc020310c:	86aa                	mv	a3,a0
ffffffffc020310e:	00003617          	auipc	a2,0x3
ffffffffc0203112:	fba60613          	addi	a2,a2,-70 # ffffffffc02060c8 <default_pmm_manager+0x70>
ffffffffc0203116:	45d1                	li	a1,20
ffffffffc0203118:	00003517          	auipc	a0,0x3
ffffffffc020311c:	f9850513          	addi	a0,a0,-104 # ffffffffc02060b0 <default_pmm_manager+0x58>
ffffffffc0203120:	8e0fd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0203124:	86b2                	mv	a3,a2
ffffffffc0203126:	06900593          	li	a1,105
ffffffffc020312a:	00002617          	auipc	a2,0x2
ffffffffc020312e:	59e60613          	addi	a2,a2,1438 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0203132:	00002517          	auipc	a0,0x2
ffffffffc0203136:	4f650513          	addi	a0,a0,1270 # ffffffffc0205628 <commands+0x700>
ffffffffc020313a:	8c6fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020313e <swapfs_write>:

int
swapfs_write(swap_entry_t entry, struct Page *page) {
ffffffffc020313e:	1141                	addi	sp,sp,-16
ffffffffc0203140:	e406                	sd	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203142:	00855793          	srli	a5,a0,0x8
ffffffffc0203146:	cbb1                	beqz	a5,ffffffffc020319a <swapfs_write+0x5c>
ffffffffc0203148:	00050717          	auipc	a4,0x50
ffffffffc020314c:	45073703          	ld	a4,1104(a4) # ffffffffc0253598 <max_swap_offset>
ffffffffc0203150:	04e7f563          	bgeu	a5,a4,ffffffffc020319a <swapfs_write+0x5c>
    return page - pages + nbase;
ffffffffc0203154:	00050617          	auipc	a2,0x50
ffffffffc0203158:	39c63603          	ld	a2,924(a2) # ffffffffc02534f0 <pages>
ffffffffc020315c:	8d91                	sub	a1,a1,a2
ffffffffc020315e:	4065d613          	srai	a2,a1,0x6
ffffffffc0203162:	00004717          	auipc	a4,0x4
ffffffffc0203166:	02e73703          	ld	a4,46(a4) # ffffffffc0207190 <nbase>
ffffffffc020316a:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc020316c:	00c61713          	slli	a4,a2,0xc
ffffffffc0203170:	8331                	srli	a4,a4,0xc
ffffffffc0203172:	00050697          	auipc	a3,0x50
ffffffffc0203176:	3066b683          	ld	a3,774(a3) # ffffffffc0253478 <npage>
ffffffffc020317a:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc020317e:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc0203180:	02d77963          	bgeu	a4,a3,ffffffffc02031b2 <swapfs_write+0x74>
}
ffffffffc0203184:	60a2                	ld	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203186:	00050797          	auipc	a5,0x50
ffffffffc020318a:	35a7b783          	ld	a5,858(a5) # ffffffffc02534e0 <va_pa_offset>
ffffffffc020318e:	46a1                	li	a3,8
ffffffffc0203190:	963e                	add	a2,a2,a5
ffffffffc0203192:	4505                	li	a0,1
}
ffffffffc0203194:	0141                	addi	sp,sp,16
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203196:	bb4fd06f          	j	ffffffffc020054a <ide_write_secs>
ffffffffc020319a:	86aa                	mv	a3,a0
ffffffffc020319c:	00003617          	auipc	a2,0x3
ffffffffc02031a0:	f2c60613          	addi	a2,a2,-212 # ffffffffc02060c8 <default_pmm_manager+0x70>
ffffffffc02031a4:	45e5                	li	a1,25
ffffffffc02031a6:	00003517          	auipc	a0,0x3
ffffffffc02031aa:	f0a50513          	addi	a0,a0,-246 # ffffffffc02060b0 <default_pmm_manager+0x58>
ffffffffc02031ae:	852fd0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc02031b2:	86b2                	mv	a3,a2
ffffffffc02031b4:	06900593          	li	a1,105
ffffffffc02031b8:	00002617          	auipc	a2,0x2
ffffffffc02031bc:	51060613          	addi	a2,a2,1296 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc02031c0:	00002517          	auipc	a0,0x2
ffffffffc02031c4:	46850513          	addi	a0,a0,1128 # ffffffffc0205628 <commands+0x700>
ffffffffc02031c8:	838fd0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02031cc <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc02031cc:	8526                	mv	a0,s1
	jalr s0
ffffffffc02031ce:	9402                	jalr	s0

	jal do_exit
ffffffffc02031d0:	774000ef          	jal	ra,ffffffffc0203944 <do_exit>

ffffffffc02031d4 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc02031d4:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc02031d8:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc02031dc:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc02031de:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc02031e0:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc02031e4:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc02031e8:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc02031ec:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc02031f0:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc02031f4:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc02031f8:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc02031fc:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0203200:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0203204:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0203208:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc020320c:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0203210:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0203212:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0203214:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0203218:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc020321c:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0203220:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0203224:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0203228:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc020322c:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0203230:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0203234:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0203238:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc020323c:	8082                	ret

ffffffffc020323e <alloc_proc>:
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
ffffffffc020323e:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203240:	13000513          	li	a0,304
alloc_proc(void) {
ffffffffc0203244:	e022                	sd	s0,0(sp)
ffffffffc0203246:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203248:	fb7fe0ef          	jal	ra,ffffffffc02021fe <kmalloc>
ffffffffc020324c:	842a                	mv	s0,a0
    if (proc != NULL) {
ffffffffc020324e:	c13d                	beqz	a0,ffffffffc02032b4 <alloc_proc+0x76>
        proc->state = PROC_UNINIT;
ffffffffc0203250:	57fd                	li	a5,-1
ffffffffc0203252:	1782                	slli	a5,a5,0x20
ffffffffc0203254:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203256:	07000613          	li	a2,112
ffffffffc020325a:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc020325c:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203260:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203264:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203268:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc020326c:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203270:	03050513          	addi	a0,a0,48
ffffffffc0203274:	5e2010ef          	jal	ra,ffffffffc0204856 <memset>
        proc->tf = NULL;
        proc->cr3 = boot_cr3;
ffffffffc0203278:	00050797          	auipc	a5,0x50
ffffffffc020327c:	2707b783          	ld	a5,624(a5) # ffffffffc02534e8 <boot_cr3>
ffffffffc0203280:	f45c                	sd	a5,168(s0)
        proc->tf = NULL;
ffffffffc0203282:	0a043023          	sd	zero,160(s0)
        proc->flags = 0;
ffffffffc0203286:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc020328a:	463d                	li	a2,15
ffffffffc020328c:	4581                	li	a1,0
ffffffffc020328e:	0b440513          	addi	a0,s0,180
ffffffffc0203292:	5c4010ef          	jal	ra,ffffffffc0204856 <memset>
        proc->wait_state = 0;
        proc->cptr = proc->optr = proc->yptr = NULL;
        proc->time_slice = 0;
ffffffffc0203296:	4785                	li	a5,1
ffffffffc0203298:	1782                	slli	a5,a5,0x20
ffffffffc020329a:	12f43023          	sd	a5,288(s0)
        proc->labschedule_priority = 1;
        proc->labschedule_good = 6;
ffffffffc020329e:	4799                	li	a5,6
        proc->wait_state = 0;
ffffffffc02032a0:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->optr = proc->yptr = NULL;
ffffffffc02032a4:	0e043c23          	sd	zero,248(s0)
ffffffffc02032a8:	10043023          	sd	zero,256(s0)
ffffffffc02032ac:	0e043823          	sd	zero,240(s0)
        proc->labschedule_good = 6;
ffffffffc02032b0:	12f42423          	sw	a5,296(s0)
    }
    return proc;
}
ffffffffc02032b4:	60a2                	ld	ra,8(sp)
ffffffffc02032b6:	8522                	mv	a0,s0
ffffffffc02032b8:	6402                	ld	s0,0(sp)
ffffffffc02032ba:	0141                	addi	sp,sp,16
ffffffffc02032bc:	8082                	ret

ffffffffc02032be <forkret>:
// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
ffffffffc02032be:	00050797          	auipc	a5,0x50
ffffffffc02032c2:	1e27b783          	ld	a5,482(a5) # ffffffffc02534a0 <current>
ffffffffc02032c6:	73c8                	ld	a0,160(a5)
ffffffffc02032c8:	a37fd06f          	j	ffffffffc0200cfe <forkrets>

ffffffffc02032cc <user_main>:
static int
user_main(void *arg) {
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(ex3);
ffffffffc02032cc:	00050797          	auipc	a5,0x50
ffffffffc02032d0:	1d47b783          	ld	a5,468(a5) # ffffffffc02534a0 <current>
ffffffffc02032d4:	43cc                	lw	a1,4(a5)
user_main(void *arg) {
ffffffffc02032d6:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(ex3);
ffffffffc02032d8:	00003617          	auipc	a2,0x3
ffffffffc02032dc:	e1060613          	addi	a2,a2,-496 # ffffffffc02060e8 <default_pmm_manager+0x90>
ffffffffc02032e0:	00003517          	auipc	a0,0x3
ffffffffc02032e4:	e1050513          	addi	a0,a0,-496 # ffffffffc02060f0 <default_pmm_manager+0x98>
user_main(void *arg) {
ffffffffc02032e8:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(ex3);
ffffffffc02032ea:	ddbfc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
ffffffffc02032ee:	3fe08797          	auipc	a5,0x3fe08
ffffffffc02032f2:	a1278793          	addi	a5,a5,-1518 # ad00 <_binary_obj___user_ex3_out_size>
ffffffffc02032f6:	e43e                	sd	a5,8(sp)
ffffffffc02032f8:	00003517          	auipc	a0,0x3
ffffffffc02032fc:	df050513          	addi	a0,a0,-528 # ffffffffc02060e8 <default_pmm_manager+0x90>
ffffffffc0203300:	0003a797          	auipc	a5,0x3a
ffffffffc0203304:	fa878793          	addi	a5,a5,-88 # ffffffffc023d2a8 <_binary_obj___user_ex3_out_start>
ffffffffc0203308:	f03e                	sd	a5,32(sp)
ffffffffc020330a:	f42a                	sd	a0,40(sp)
    int64_t ret=0, len = strlen(name);
ffffffffc020330c:	e802                	sd	zero,16(sp)
ffffffffc020330e:	4de010ef          	jal	ra,ffffffffc02047ec <strlen>
ffffffffc0203312:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203314:	4511                	li	a0,4
ffffffffc0203316:	55a2                	lw	a1,40(sp)
ffffffffc0203318:	4662                	lw	a2,24(sp)
ffffffffc020331a:	5682                	lw	a3,32(sp)
ffffffffc020331c:	4722                	lw	a4,8(sp)
ffffffffc020331e:	48a9                	li	a7,10
ffffffffc0203320:	9002                	ebreak
ffffffffc0203322:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203324:	65c2                	ld	a1,16(sp)
ffffffffc0203326:	00003517          	auipc	a0,0x3
ffffffffc020332a:	df250513          	addi	a0,a0,-526 # ffffffffc0206118 <default_pmm_manager+0xc0>
ffffffffc020332e:	d97fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc0203332:	00003617          	auipc	a2,0x3
ffffffffc0203336:	df660613          	addi	a2,a2,-522 # ffffffffc0206128 <default_pmm_manager+0xd0>
ffffffffc020333a:	30600593          	li	a1,774
ffffffffc020333e:	00003517          	auipc	a0,0x3
ffffffffc0203342:	e0a50513          	addi	a0,a0,-502 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203346:	ebbfc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc020334a <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc020334a:	6d14                	ld	a3,24(a0)
put_pgdir(struct mm_struct *mm) {
ffffffffc020334c:	1141                	addi	sp,sp,-16
ffffffffc020334e:	e406                	sd	ra,8(sp)
ffffffffc0203350:	c02007b7          	lui	a5,0xc0200
ffffffffc0203354:	02f6ee63          	bltu	a3,a5,ffffffffc0203390 <put_pgdir+0x46>
ffffffffc0203358:	00050517          	auipc	a0,0x50
ffffffffc020335c:	18853503          	ld	a0,392(a0) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0203360:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage) {
ffffffffc0203362:	82b1                	srli	a3,a3,0xc
ffffffffc0203364:	00050797          	auipc	a5,0x50
ffffffffc0203368:	1147b783          	ld	a5,276(a5) # ffffffffc0253478 <npage>
ffffffffc020336c:	02f6fe63          	bgeu	a3,a5,ffffffffc02033a8 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203370:	00004517          	auipc	a0,0x4
ffffffffc0203374:	e2053503          	ld	a0,-480(a0) # ffffffffc0207190 <nbase>
}
ffffffffc0203378:	60a2                	ld	ra,8(sp)
ffffffffc020337a:	8e89                	sub	a3,a3,a0
ffffffffc020337c:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc020337e:	00050517          	auipc	a0,0x50
ffffffffc0203382:	17253503          	ld	a0,370(a0) # ffffffffc02534f0 <pages>
ffffffffc0203386:	4585                	li	a1,1
ffffffffc0203388:	9536                	add	a0,a0,a3
}
ffffffffc020338a:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc020338c:	a25fd06f          	j	ffffffffc0200db0 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203390:	00002617          	auipc	a2,0x2
ffffffffc0203394:	30060613          	addi	a2,a2,768 # ffffffffc0205690 <commands+0x768>
ffffffffc0203398:	06e00593          	li	a1,110
ffffffffc020339c:	00002517          	auipc	a0,0x2
ffffffffc02033a0:	28c50513          	addi	a0,a0,652 # ffffffffc0205628 <commands+0x700>
ffffffffc02033a4:	e5dfc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02033a8:	00002617          	auipc	a2,0x2
ffffffffc02033ac:	26060613          	addi	a2,a2,608 # ffffffffc0205608 <commands+0x6e0>
ffffffffc02033b0:	06200593          	li	a1,98
ffffffffc02033b4:	00002517          	auipc	a0,0x2
ffffffffc02033b8:	27450513          	addi	a0,a0,628 # ffffffffc0205628 <commands+0x700>
ffffffffc02033bc:	e45fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02033c0 <setup_pgdir>:
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033c0:	1101                	addi	sp,sp,-32
ffffffffc02033c2:	e426                	sd	s1,8(sp)
ffffffffc02033c4:	84aa                	mv	s1,a0
    if ((page = alloc_page()) == NULL) {
ffffffffc02033c6:	4505                	li	a0,1
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033c8:	ec06                	sd	ra,24(sp)
ffffffffc02033ca:	e822                	sd	s0,16(sp)
    if ((page = alloc_page()) == NULL) {
ffffffffc02033cc:	953fd0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
ffffffffc02033d0:	c939                	beqz	a0,ffffffffc0203426 <setup_pgdir+0x66>
    return page - pages + nbase;
ffffffffc02033d2:	00050697          	auipc	a3,0x50
ffffffffc02033d6:	11e6b683          	ld	a3,286(a3) # ffffffffc02534f0 <pages>
ffffffffc02033da:	40d506b3          	sub	a3,a0,a3
ffffffffc02033de:	8699                	srai	a3,a3,0x6
ffffffffc02033e0:	00004417          	auipc	s0,0x4
ffffffffc02033e4:	db043403          	ld	s0,-592(s0) # ffffffffc0207190 <nbase>
ffffffffc02033e8:	96a2                	add	a3,a3,s0
    return KADDR(page2pa(page));
ffffffffc02033ea:	00c69793          	slli	a5,a3,0xc
ffffffffc02033ee:	83b1                	srli	a5,a5,0xc
ffffffffc02033f0:	00050717          	auipc	a4,0x50
ffffffffc02033f4:	08873703          	ld	a4,136(a4) # ffffffffc0253478 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc02033f8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02033fa:	02e7f863          	bgeu	a5,a4,ffffffffc020342a <setup_pgdir+0x6a>
ffffffffc02033fe:	00050417          	auipc	s0,0x50
ffffffffc0203402:	0e243403          	ld	s0,226(s0) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0203406:	9436                	add	s0,s0,a3
    memcpy(pgdir, boot_pgdir, PGSIZE);
ffffffffc0203408:	6605                	lui	a2,0x1
ffffffffc020340a:	00050597          	auipc	a1,0x50
ffffffffc020340e:	0665b583          	ld	a1,102(a1) # ffffffffc0253470 <boot_pgdir>
ffffffffc0203412:	8522                	mv	a0,s0
ffffffffc0203414:	454010ef          	jal	ra,ffffffffc0204868 <memcpy>
    return 0;
ffffffffc0203418:	4501                	li	a0,0
    mm->pgdir = pgdir;
ffffffffc020341a:	ec80                	sd	s0,24(s1)
}
ffffffffc020341c:	60e2                	ld	ra,24(sp)
ffffffffc020341e:	6442                	ld	s0,16(sp)
ffffffffc0203420:	64a2                	ld	s1,8(sp)
ffffffffc0203422:	6105                	addi	sp,sp,32
ffffffffc0203424:	8082                	ret
        return -E_NO_MEM;
ffffffffc0203426:	5571                	li	a0,-4
ffffffffc0203428:	bfd5                	j	ffffffffc020341c <setup_pgdir+0x5c>
ffffffffc020342a:	00002617          	auipc	a2,0x2
ffffffffc020342e:	29e60613          	addi	a2,a2,670 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0203432:	06900593          	li	a1,105
ffffffffc0203436:	00002517          	auipc	a0,0x2
ffffffffc020343a:	1f250513          	addi	a0,a0,498 # ffffffffc0205628 <commands+0x700>
ffffffffc020343e:	dc3fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203442 <set_proc_name>:
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203442:	1101                	addi	sp,sp,-32
ffffffffc0203444:	e822                	sd	s0,16(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203446:	0b450413          	addi	s0,a0,180
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020344a:	e426                	sd	s1,8(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020344c:	4641                	li	a2,16
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020344e:	84ae                	mv	s1,a1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203450:	8522                	mv	a0,s0
ffffffffc0203452:	4581                	li	a1,0
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203454:	ec06                	sd	ra,24(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203456:	400010ef          	jal	ra,ffffffffc0204856 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020345a:	8522                	mv	a0,s0
}
ffffffffc020345c:	6442                	ld	s0,16(sp)
ffffffffc020345e:	60e2                	ld	ra,24(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203460:	85a6                	mv	a1,s1
}
ffffffffc0203462:	64a2                	ld	s1,8(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203464:	463d                	li	a2,15
}
ffffffffc0203466:	6105                	addi	sp,sp,32
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203468:	4000106f          	j	ffffffffc0204868 <memcpy>

ffffffffc020346c <proc_run>:
proc_run(struct proc_struct *proc) {
ffffffffc020346c:	7179                	addi	sp,sp,-48
ffffffffc020346e:	ec4a                	sd	s2,24(sp)
    if (proc != current) {
ffffffffc0203470:	00050917          	auipc	s2,0x50
ffffffffc0203474:	03090913          	addi	s2,s2,48 # ffffffffc02534a0 <current>
proc_run(struct proc_struct *proc) {
ffffffffc0203478:	f026                	sd	s1,32(sp)
    if (proc != current) {
ffffffffc020347a:	00093483          	ld	s1,0(s2)
proc_run(struct proc_struct *proc) {
ffffffffc020347e:	f406                	sd	ra,40(sp)
ffffffffc0203480:	e84e                	sd	s3,16(sp)
    if (proc != current) {
ffffffffc0203482:	02a48863          	beq	s1,a0,ffffffffc02034b2 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203486:	100027f3          	csrr	a5,sstatus
ffffffffc020348a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020348c:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020348e:	ef9d                	bnez	a5,ffffffffc02034cc <proc_run+0x60>

#define barrier() __asm__ __volatile__ ("fence" ::: "memory")

static inline void
lcr3(unsigned long cr3) {
    write_csr(satp, 0x8000000000000000 | (cr3 >> RISCV_PGSHIFT));
ffffffffc0203490:	755c                	ld	a5,168(a0)
ffffffffc0203492:	577d                	li	a4,-1
ffffffffc0203494:	177e                	slli	a4,a4,0x3f
ffffffffc0203496:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc0203498:	00a93023          	sd	a0,0(s2)
ffffffffc020349c:	8fd9                	or	a5,a5,a4
ffffffffc020349e:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context));
ffffffffc02034a2:	03050593          	addi	a1,a0,48
ffffffffc02034a6:	03048513          	addi	a0,s1,48
ffffffffc02034aa:	d2bff0ef          	jal	ra,ffffffffc02031d4 <switch_to>
    if (flag) {
ffffffffc02034ae:	00099863          	bnez	s3,ffffffffc02034be <proc_run+0x52>
}
ffffffffc02034b2:	70a2                	ld	ra,40(sp)
ffffffffc02034b4:	7482                	ld	s1,32(sp)
ffffffffc02034b6:	6962                	ld	s2,24(sp)
ffffffffc02034b8:	69c2                	ld	s3,16(sp)
ffffffffc02034ba:	6145                	addi	sp,sp,48
ffffffffc02034bc:	8082                	ret
ffffffffc02034be:	70a2                	ld	ra,40(sp)
ffffffffc02034c0:	7482                	ld	s1,32(sp)
ffffffffc02034c2:	6962                	ld	s2,24(sp)
ffffffffc02034c4:	69c2                	ld	s3,16(sp)
ffffffffc02034c6:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc02034c8:	930fd06f          	j	ffffffffc02005f8 <intr_enable>
ffffffffc02034cc:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02034ce:	930fd0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc02034d2:	6522                	ld	a0,8(sp)
ffffffffc02034d4:	4985                	li	s3,1
ffffffffc02034d6:	bf6d                	j	ffffffffc0203490 <proc_run+0x24>

ffffffffc02034d8 <find_proc>:
    if (0 < pid && pid < MAX_PID) {
ffffffffc02034d8:	6789                	lui	a5,0x2
ffffffffc02034da:	fff5071b          	addiw	a4,a0,-1
ffffffffc02034de:	17f9                	addi	a5,a5,-2
ffffffffc02034e0:	04e7e063          	bltu	a5,a4,ffffffffc0203520 <find_proc+0x48>
find_proc(int pid) {
ffffffffc02034e4:	1141                	addi	sp,sp,-16
ffffffffc02034e6:	e022                	sd	s0,0(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc02034e8:	45a9                	li	a1,10
ffffffffc02034ea:	842a                	mv	s0,a0
ffffffffc02034ec:	2501                	sext.w	a0,a0
find_proc(int pid) {
ffffffffc02034ee:	e406                	sd	ra,8(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc02034f0:	77e010ef          	jal	ra,ffffffffc0204c6e <hash32>
ffffffffc02034f4:	02051693          	slli	a3,a0,0x20
ffffffffc02034f8:	0004c797          	auipc	a5,0x4c
ffffffffc02034fc:	f4078793          	addi	a5,a5,-192 # ffffffffc024f438 <hash_list>
ffffffffc0203500:	82f1                	srli	a3,a3,0x1c
ffffffffc0203502:	96be                	add	a3,a3,a5
ffffffffc0203504:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list) {
ffffffffc0203506:	a029                	j	ffffffffc0203510 <find_proc+0x38>
            if (proc->pid == pid) {
ffffffffc0203508:	f2c7a703          	lw	a4,-212(a5)
ffffffffc020350c:	00870c63          	beq	a4,s0,ffffffffc0203524 <find_proc+0x4c>
    return listelm->next;
ffffffffc0203510:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0203512:	fef69be3          	bne	a3,a5,ffffffffc0203508 <find_proc+0x30>
}
ffffffffc0203516:	60a2                	ld	ra,8(sp)
ffffffffc0203518:	6402                	ld	s0,0(sp)
    return NULL;
ffffffffc020351a:	4501                	li	a0,0
}
ffffffffc020351c:	0141                	addi	sp,sp,16
ffffffffc020351e:	8082                	ret
    return NULL;
ffffffffc0203520:	4501                	li	a0,0
}
ffffffffc0203522:	8082                	ret
ffffffffc0203524:	60a2                	ld	ra,8(sp)
ffffffffc0203526:	6402                	ld	s0,0(sp)
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0203528:	f2878513          	addi	a0,a5,-216
}
ffffffffc020352c:	0141                	addi	sp,sp,16
ffffffffc020352e:	8082                	ret

ffffffffc0203530 <do_fork>:
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203530:	7159                	addi	sp,sp,-112
ffffffffc0203532:	e0d2                	sd	s4,64(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203534:	00050a17          	auipc	s4,0x50
ffffffffc0203538:	f84a0a13          	addi	s4,s4,-124 # ffffffffc02534b8 <nr_process>
ffffffffc020353c:	000a2703          	lw	a4,0(s4)
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc0203540:	f486                	sd	ra,104(sp)
ffffffffc0203542:	f0a2                	sd	s0,96(sp)
ffffffffc0203544:	eca6                	sd	s1,88(sp)
ffffffffc0203546:	e8ca                	sd	s2,80(sp)
ffffffffc0203548:	e4ce                	sd	s3,72(sp)
ffffffffc020354a:	fc56                	sd	s5,56(sp)
ffffffffc020354c:	f85a                	sd	s6,48(sp)
ffffffffc020354e:	f45e                	sd	s7,40(sp)
ffffffffc0203550:	f062                	sd	s8,32(sp)
ffffffffc0203552:	ec66                	sd	s9,24(sp)
ffffffffc0203554:	e86a                	sd	s10,16(sp)
ffffffffc0203556:	e46e                	sd	s11,8(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203558:	6785                	lui	a5,0x1
ffffffffc020355a:	2ef75c63          	bge	a4,a5,ffffffffc0203852 <do_fork+0x322>
ffffffffc020355e:	89aa                	mv	s3,a0
ffffffffc0203560:	892e                	mv	s2,a1
ffffffffc0203562:	84b2                	mv	s1,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203564:	cdbff0ef          	jal	ra,ffffffffc020323e <alloc_proc>
ffffffffc0203568:	842a                	mv	s0,a0
ffffffffc020356a:	2c050163          	beqz	a0,ffffffffc020382c <do_fork+0x2fc>
    proc->parent = current;
ffffffffc020356e:	00050c17          	auipc	s8,0x50
ffffffffc0203572:	f32c0c13          	addi	s8,s8,-206 # ffffffffc02534a0 <current>
ffffffffc0203576:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);
ffffffffc020357a:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_ex1_out_size-0x886c>
    proc->parent = current;
ffffffffc020357e:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);
ffffffffc0203580:	2e071963          	bnez	a4,ffffffffc0203872 <do_fork+0x342>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203584:	4509                	li	a0,2
ffffffffc0203586:	f98fd0ef          	jal	ra,ffffffffc0200d1e <alloc_pages>
    if (page != NULL) {
ffffffffc020358a:	28050e63          	beqz	a0,ffffffffc0203826 <do_fork+0x2f6>
    return page - pages + nbase;
ffffffffc020358e:	00050a97          	auipc	s5,0x50
ffffffffc0203592:	f62a8a93          	addi	s5,s5,-158 # ffffffffc02534f0 <pages>
ffffffffc0203596:	000ab683          	ld	a3,0(s5)
ffffffffc020359a:	00004b17          	auipc	s6,0x4
ffffffffc020359e:	bf6b0b13          	addi	s6,s6,-1034 # ffffffffc0207190 <nbase>
ffffffffc02035a2:	000b3783          	ld	a5,0(s6)
ffffffffc02035a6:	40d506b3          	sub	a3,a0,a3
ffffffffc02035aa:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02035ac:	00050b97          	auipc	s7,0x50
ffffffffc02035b0:	eccb8b93          	addi	s7,s7,-308 # ffffffffc0253478 <npage>
    return page - pages + nbase;
ffffffffc02035b4:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02035b6:	000bb703          	ld	a4,0(s7)
ffffffffc02035ba:	00c69793          	slli	a5,a3,0xc
ffffffffc02035be:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02035c0:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02035c2:	28e7fc63          	bgeu	a5,a4,ffffffffc020385a <do_fork+0x32a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc02035c6:	000c3703          	ld	a4,0(s8)
ffffffffc02035ca:	00050c97          	auipc	s9,0x50
ffffffffc02035ce:	f16c8c93          	addi	s9,s9,-234 # ffffffffc02534e0 <va_pa_offset>
ffffffffc02035d2:	000cb783          	ld	a5,0(s9)
ffffffffc02035d6:	02873c03          	ld	s8,40(a4)
ffffffffc02035da:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc02035dc:	e814                	sd	a3,16(s0)
    if (oldmm == NULL) {
ffffffffc02035de:	020c0863          	beqz	s8,ffffffffc020360e <do_fork+0xde>
    if (clone_flags & CLONE_VM) {
ffffffffc02035e2:	1009f993          	andi	s3,s3,256
ffffffffc02035e6:	1a098e63          	beqz	s3,ffffffffc02037a2 <do_fork+0x272>
}

static inline int
mm_count_inc(struct mm_struct *mm) {
    mm->mm_count += 1;
ffffffffc02035ea:	030c2703          	lw	a4,48(s8)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc02035ee:	018c3783          	ld	a5,24(s8)
ffffffffc02035f2:	c02006b7          	lui	a3,0xc0200
ffffffffc02035f6:	2705                	addiw	a4,a4,1
ffffffffc02035f8:	02ec2823          	sw	a4,48(s8)
    proc->mm = mm;
ffffffffc02035fc:	03843423          	sd	s8,40(s0)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203600:	28d7e963          	bltu	a5,a3,ffffffffc0203892 <do_fork+0x362>
ffffffffc0203604:	000cb703          	ld	a4,0(s9)
ffffffffc0203608:	6814                	ld	a3,16(s0)
ffffffffc020360a:	8f99                	sub	a5,a5,a4
ffffffffc020360c:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc020360e:	6789                	lui	a5,0x2
ffffffffc0203610:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_ex1_out_size-0x7a78>
ffffffffc0203614:	97b6                	add	a5,a5,a3
ffffffffc0203616:	f05c                	sd	a5,160(s0)
    *(proc->tf) = *tf;
ffffffffc0203618:	873e                	mv	a4,a5
ffffffffc020361a:	12048893          	addi	a7,s1,288
ffffffffc020361e:	0004b803          	ld	a6,0(s1)
ffffffffc0203622:	6488                	ld	a0,8(s1)
ffffffffc0203624:	688c                	ld	a1,16(s1)
ffffffffc0203626:	6c90                	ld	a2,24(s1)
ffffffffc0203628:	01073023          	sd	a6,0(a4)
ffffffffc020362c:	e708                	sd	a0,8(a4)
ffffffffc020362e:	eb0c                	sd	a1,16(a4)
ffffffffc0203630:	ef10                	sd	a2,24(a4)
ffffffffc0203632:	02048493          	addi	s1,s1,32
ffffffffc0203636:	02070713          	addi	a4,a4,32
ffffffffc020363a:	ff1492e3          	bne	s1,a7,ffffffffc020361e <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc020363e:	0407b823          	sd	zero,80(a5)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc0203642:	12090a63          	beqz	s2,ffffffffc0203776 <do_fork+0x246>
ffffffffc0203646:	0127b823          	sd	s2,16(a5)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc020364a:	00000717          	auipc	a4,0x0
ffffffffc020364e:	c7470713          	addi	a4,a4,-908 # ffffffffc02032be <forkret>
ffffffffc0203652:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0203654:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203656:	100027f3          	csrr	a5,sstatus
ffffffffc020365a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020365c:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020365e:	12079e63          	bnez	a5,ffffffffc020379a <do_fork+0x26a>
    if (++ last_pid >= MAX_PID) {
ffffffffc0203662:	00045597          	auipc	a1,0x45
ffffffffc0203666:	9ce58593          	addi	a1,a1,-1586 # ffffffffc0248030 <last_pid.1746>
ffffffffc020366a:	419c                	lw	a5,0(a1)
ffffffffc020366c:	6709                	lui	a4,0x2
ffffffffc020366e:	0017851b          	addiw	a0,a5,1
ffffffffc0203672:	c188                	sw	a0,0(a1)
ffffffffc0203674:	08e55b63          	bge	a0,a4,ffffffffc020370a <do_fork+0x1da>
    if (last_pid >= next_safe) {
ffffffffc0203678:	00045897          	auipc	a7,0x45
ffffffffc020367c:	9bc88893          	addi	a7,a7,-1604 # ffffffffc0248034 <next_safe.1745>
ffffffffc0203680:	0008a783          	lw	a5,0(a7)
ffffffffc0203684:	00050497          	auipc	s1,0x50
ffffffffc0203688:	f6c48493          	addi	s1,s1,-148 # ffffffffc02535f0 <proc_list>
ffffffffc020368c:	08f55663          	bge	a0,a5,ffffffffc0203718 <do_fork+0x1e8>
        proc->pid = get_pid();
ffffffffc0203690:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0203692:	45a9                	li	a1,10
ffffffffc0203694:	2501                	sext.w	a0,a0
ffffffffc0203696:	5d8010ef          	jal	ra,ffffffffc0204c6e <hash32>
ffffffffc020369a:	1502                	slli	a0,a0,0x20
ffffffffc020369c:	0004c797          	auipc	a5,0x4c
ffffffffc02036a0:	d9c78793          	addi	a5,a5,-612 # ffffffffc024f438 <hash_list>
ffffffffc02036a4:	8171                	srli	a0,a0,0x1c
ffffffffc02036a6:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02036a8:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036aa:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036ac:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02036b0:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02036b2:	6490                	ld	a2,8(s1)
    prev->next = next->prev = elm;
ffffffffc02036b4:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036b6:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02036b8:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02036bc:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02036be:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02036c0:	e21c                	sd	a5,0(a2)
ffffffffc02036c2:	e49c                	sd	a5,8(s1)
    elm->next = next;
ffffffffc02036c4:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc02036c6:	e464                	sd	s1,200(s0)
    proc->yptr = NULL;
ffffffffc02036c8:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036cc:	10e43023          	sd	a4,256(s0)
ffffffffc02036d0:	c311                	beqz	a4,ffffffffc02036d4 <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc02036d2:	ff60                	sd	s0,248(a4)
    nr_process ++;
ffffffffc02036d4:	000a2783          	lw	a5,0(s4)
    proc->parent->cptr = proc;
ffffffffc02036d8:	fae0                	sd	s0,240(a3)
    nr_process ++;
ffffffffc02036da:	2785                	addiw	a5,a5,1
ffffffffc02036dc:	00fa2023          	sw	a5,0(s4)
    if (flag) {
ffffffffc02036e0:	14091863          	bnez	s2,ffffffffc0203830 <do_fork+0x300>
    wakeup_proc(proc);
ffffffffc02036e4:	8522                	mv	a0,s0
ffffffffc02036e6:	5ad000ef          	jal	ra,ffffffffc0204492 <wakeup_proc>
    ret = proc->pid;
ffffffffc02036ea:	4048                	lw	a0,4(s0)
}
ffffffffc02036ec:	70a6                	ld	ra,104(sp)
ffffffffc02036ee:	7406                	ld	s0,96(sp)
ffffffffc02036f0:	64e6                	ld	s1,88(sp)
ffffffffc02036f2:	6946                	ld	s2,80(sp)
ffffffffc02036f4:	69a6                	ld	s3,72(sp)
ffffffffc02036f6:	6a06                	ld	s4,64(sp)
ffffffffc02036f8:	7ae2                	ld	s5,56(sp)
ffffffffc02036fa:	7b42                	ld	s6,48(sp)
ffffffffc02036fc:	7ba2                	ld	s7,40(sp)
ffffffffc02036fe:	7c02                	ld	s8,32(sp)
ffffffffc0203700:	6ce2                	ld	s9,24(sp)
ffffffffc0203702:	6d42                	ld	s10,16(sp)
ffffffffc0203704:	6da2                	ld	s11,8(sp)
ffffffffc0203706:	6165                	addi	sp,sp,112
ffffffffc0203708:	8082                	ret
        last_pid = 1;
ffffffffc020370a:	4785                	li	a5,1
ffffffffc020370c:	c19c                	sw	a5,0(a1)
        goto inside;
ffffffffc020370e:	4505                	li	a0,1
ffffffffc0203710:	00045897          	auipc	a7,0x45
ffffffffc0203714:	92488893          	addi	a7,a7,-1756 # ffffffffc0248034 <next_safe.1745>
    return listelm->next;
ffffffffc0203718:	00050497          	auipc	s1,0x50
ffffffffc020371c:	ed848493          	addi	s1,s1,-296 # ffffffffc02535f0 <proc_list>
ffffffffc0203720:	0084b303          	ld	t1,8(s1)
        next_safe = MAX_PID;
ffffffffc0203724:	6789                	lui	a5,0x2
ffffffffc0203726:	00f8a023          	sw	a5,0(a7)
ffffffffc020372a:	4801                	li	a6,0
ffffffffc020372c:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list) {
ffffffffc020372e:	6e89                	lui	t4,0x2
ffffffffc0203730:	10930c63          	beq	t1,s1,ffffffffc0203848 <do_fork+0x318>
ffffffffc0203734:	8e42                	mv	t3,a6
ffffffffc0203736:	869a                	mv	a3,t1
ffffffffc0203738:	6609                	lui	a2,0x2
ffffffffc020373a:	a811                	j	ffffffffc020374e <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid) {
ffffffffc020373c:	00e7d663          	bge	a5,a4,ffffffffc0203748 <do_fork+0x218>
ffffffffc0203740:	00c75463          	bge	a4,a2,ffffffffc0203748 <do_fork+0x218>
ffffffffc0203744:	863a                	mv	a2,a4
ffffffffc0203746:	4e05                	li	t3,1
ffffffffc0203748:	6694                	ld	a3,8(a3)
        while ((le = list_next(le)) != list) {
ffffffffc020374a:	00968d63          	beq	a3,s1,ffffffffc0203764 <do_fork+0x234>
            if (proc->pid == last_pid) {
ffffffffc020374e:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <_binary_obj___user_ex3_out_size+0xffffffffc01f523c>
ffffffffc0203752:	fee795e3          	bne	a5,a4,ffffffffc020373c <do_fork+0x20c>
                if (++ last_pid >= next_safe) {
ffffffffc0203756:	2785                	addiw	a5,a5,1
ffffffffc0203758:	0cc7df63          	bge	a5,a2,ffffffffc0203836 <do_fork+0x306>
ffffffffc020375c:	6694                	ld	a3,8(a3)
ffffffffc020375e:	4805                	li	a6,1
        while ((le = list_next(le)) != list) {
ffffffffc0203760:	fe9697e3          	bne	a3,s1,ffffffffc020374e <do_fork+0x21e>
ffffffffc0203764:	00080463          	beqz	a6,ffffffffc020376c <do_fork+0x23c>
ffffffffc0203768:	c19c                	sw	a5,0(a1)
ffffffffc020376a:	853e                	mv	a0,a5
ffffffffc020376c:	f20e02e3          	beqz	t3,ffffffffc0203690 <do_fork+0x160>
ffffffffc0203770:	00c8a023          	sw	a2,0(a7)
ffffffffc0203774:	bf31                	j	ffffffffc0203690 <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc0203776:	6909                	lui	s2,0x2
ffffffffc0203778:	edc90913          	addi	s2,s2,-292 # 1edc <_binary_obj___user_ex1_out_size-0x7a7c>
ffffffffc020377c:	9936                	add	s2,s2,a3
ffffffffc020377e:	0127b823          	sd	s2,16(a5) # 2010 <_binary_obj___user_ex1_out_size-0x7948>
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203782:	00000717          	auipc	a4,0x0
ffffffffc0203786:	b3c70713          	addi	a4,a4,-1220 # ffffffffc02032be <forkret>
ffffffffc020378a:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc020378c:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020378e:	100027f3          	csrr	a5,sstatus
ffffffffc0203792:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203794:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203796:	ec0786e3          	beqz	a5,ffffffffc0203662 <do_fork+0x132>
        intr_disable();
ffffffffc020379a:	e65fc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc020379e:	4905                	li	s2,1
ffffffffc02037a0:	b5c9                	j	ffffffffc0203662 <do_fork+0x132>
    if ((mm = mm_create()) == NULL) {
ffffffffc02037a2:	b5afe0ef          	jal	ra,ffffffffc0201afc <mm_create>
ffffffffc02037a6:	89aa                	mv	s3,a0
ffffffffc02037a8:	c539                	beqz	a0,ffffffffc02037f6 <do_fork+0x2c6>
    if (setup_pgdir(mm) != 0) {
ffffffffc02037aa:	c17ff0ef          	jal	ra,ffffffffc02033c0 <setup_pgdir>
ffffffffc02037ae:	e949                	bnez	a0,ffffffffc0203840 <do_fork+0x310>
}

static inline void
lock_mm(struct mm_struct *mm) {
    if (mm != NULL) {
        lock(&(mm->mm_lock));
ffffffffc02037b0:	038c0d93          	addi	s11,s8,56
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02037b4:	4785                	li	a5,1
ffffffffc02037b6:	40fdb7af          	amoor.d	a5,a5,(s11)
    return !test_and_set_bit(0, lock);
}

static inline void
lock(lock_t *lock) {
    while (!try_lock(lock)) {
ffffffffc02037ba:	8b85                	andi	a5,a5,1
ffffffffc02037bc:	4d05                	li	s10,1
ffffffffc02037be:	c799                	beqz	a5,ffffffffc02037cc <do_fork+0x29c>
        schedule();
ffffffffc02037c0:	585000ef          	jal	ra,ffffffffc0204544 <schedule>
ffffffffc02037c4:	41adb7af          	amoor.d	a5,s10,(s11)
    while (!try_lock(lock)) {
ffffffffc02037c8:	8b85                	andi	a5,a5,1
ffffffffc02037ca:	fbfd                	bnez	a5,ffffffffc02037c0 <do_fork+0x290>
        ret = dup_mmap(mm, oldmm);
ffffffffc02037cc:	85e2                	mv	a1,s8
ffffffffc02037ce:	854e                	mv	a0,s3
ffffffffc02037d0:	d84fe0ef          	jal	ra,ffffffffc0201d54 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc02037d4:	57f9                	li	a5,-2
ffffffffc02037d6:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc02037da:	8b85                	andi	a5,a5,1
    }
}

static inline void
unlock(lock_t *lock) {
    if (!test_and_clear_bit(0, lock)) {
ffffffffc02037dc:	cbe1                	beqz	a5,ffffffffc02038ac <do_fork+0x37c>
good_mm:
ffffffffc02037de:	8c4e                	mv	s8,s3
    if (ret != 0) {
ffffffffc02037e0:	e00505e3          	beqz	a0,ffffffffc02035ea <do_fork+0xba>
    exit_mmap(mm);
ffffffffc02037e4:	854e                	mv	a0,s3
ffffffffc02037e6:	e08fe0ef          	jal	ra,ffffffffc0201dee <exit_mmap>
    put_pgdir(mm);
ffffffffc02037ea:	854e                	mv	a0,s3
ffffffffc02037ec:	b5fff0ef          	jal	ra,ffffffffc020334a <put_pgdir>
    mm_destroy(mm);
ffffffffc02037f0:	854e                	mv	a0,s3
ffffffffc02037f2:	c62fe0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc02037f6:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc02037f8:	c02007b7          	lui	a5,0xc0200
ffffffffc02037fc:	0ef6e063          	bltu	a3,a5,ffffffffc02038dc <do_fork+0x3ac>
ffffffffc0203800:	000cb783          	ld	a5,0(s9)
    if (PPN(pa) >= npage) {
ffffffffc0203804:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc0203808:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc020380c:	83b1                	srli	a5,a5,0xc
ffffffffc020380e:	0ae7fb63          	bgeu	a5,a4,ffffffffc02038c4 <do_fork+0x394>
    return &pages[PPN(pa) - nbase];
ffffffffc0203812:	000b3703          	ld	a4,0(s6)
ffffffffc0203816:	000ab503          	ld	a0,0(s5)
ffffffffc020381a:	4589                	li	a1,2
ffffffffc020381c:	8f99                	sub	a5,a5,a4
ffffffffc020381e:	079a                	slli	a5,a5,0x6
ffffffffc0203820:	953e                	add	a0,a0,a5
ffffffffc0203822:	d8efd0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    kfree(proc);
ffffffffc0203826:	8522                	mv	a0,s0
ffffffffc0203828:	a87fe0ef          	jal	ra,ffffffffc02022ae <kfree>
    ret = -E_NO_MEM;
ffffffffc020382c:	5571                	li	a0,-4
    return ret;
ffffffffc020382e:	bd7d                	j	ffffffffc02036ec <do_fork+0x1bc>
        intr_enable();
ffffffffc0203830:	dc9fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203834:	bd45                	j	ffffffffc02036e4 <do_fork+0x1b4>
                    if (last_pid >= MAX_PID) {
ffffffffc0203836:	01d7c363          	blt	a5,t4,ffffffffc020383c <do_fork+0x30c>
                        last_pid = 1;
ffffffffc020383a:	4785                	li	a5,1
                    goto repeat;
ffffffffc020383c:	4805                	li	a6,1
ffffffffc020383e:	bdcd                	j	ffffffffc0203730 <do_fork+0x200>
    mm_destroy(mm);
ffffffffc0203840:	854e                	mv	a0,s3
ffffffffc0203842:	c12fe0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
ffffffffc0203846:	bf45                	j	ffffffffc02037f6 <do_fork+0x2c6>
ffffffffc0203848:	00080763          	beqz	a6,ffffffffc0203856 <do_fork+0x326>
ffffffffc020384c:	c19c                	sw	a5,0(a1)
ffffffffc020384e:	853e                	mv	a0,a5
ffffffffc0203850:	b581                	j	ffffffffc0203690 <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc0203852:	556d                	li	a0,-5
ffffffffc0203854:	bd61                	j	ffffffffc02036ec <do_fork+0x1bc>
ffffffffc0203856:	4188                	lw	a0,0(a1)
ffffffffc0203858:	bd25                	j	ffffffffc0203690 <do_fork+0x160>
    return KADDR(page2pa(page));
ffffffffc020385a:	00002617          	auipc	a2,0x2
ffffffffc020385e:	e6e60613          	addi	a2,a2,-402 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0203862:	06900593          	li	a1,105
ffffffffc0203866:	00002517          	auipc	a0,0x2
ffffffffc020386a:	dc250513          	addi	a0,a0,-574 # ffffffffc0205628 <commands+0x700>
ffffffffc020386e:	993fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(current->wait_state == 0);
ffffffffc0203872:	00003697          	auipc	a3,0x3
ffffffffc0203876:	8ee68693          	addi	a3,a3,-1810 # ffffffffc0206160 <default_pmm_manager+0x108>
ffffffffc020387a:	00002617          	auipc	a2,0x2
ffffffffc020387e:	a9e60613          	addi	a2,a2,-1378 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203882:	17300593          	li	a1,371
ffffffffc0203886:	00003517          	auipc	a0,0x3
ffffffffc020388a:	8c250513          	addi	a0,a0,-1854 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc020388e:	973fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203892:	86be                	mv	a3,a5
ffffffffc0203894:	00002617          	auipc	a2,0x2
ffffffffc0203898:	dfc60613          	addi	a2,a2,-516 # ffffffffc0205690 <commands+0x768>
ffffffffc020389c:	14600593          	li	a1,326
ffffffffc02038a0:	00003517          	auipc	a0,0x3
ffffffffc02038a4:	8a850513          	addi	a0,a0,-1880 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02038a8:	959fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("Unlock failed.\n");
ffffffffc02038ac:	00003617          	auipc	a2,0x3
ffffffffc02038b0:	8d460613          	addi	a2,a2,-1836 # ffffffffc0206180 <default_pmm_manager+0x128>
ffffffffc02038b4:	03200593          	li	a1,50
ffffffffc02038b8:	00003517          	auipc	a0,0x3
ffffffffc02038bc:	8d850513          	addi	a0,a0,-1832 # ffffffffc0206190 <default_pmm_manager+0x138>
ffffffffc02038c0:	941fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02038c4:	00002617          	auipc	a2,0x2
ffffffffc02038c8:	d4460613          	addi	a2,a2,-700 # ffffffffc0205608 <commands+0x6e0>
ffffffffc02038cc:	06200593          	li	a1,98
ffffffffc02038d0:	00002517          	auipc	a0,0x2
ffffffffc02038d4:	d5850513          	addi	a0,a0,-680 # ffffffffc0205628 <commands+0x700>
ffffffffc02038d8:	929fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02038dc:	00002617          	auipc	a2,0x2
ffffffffc02038e0:	db460613          	addi	a2,a2,-588 # ffffffffc0205690 <commands+0x768>
ffffffffc02038e4:	06e00593          	li	a1,110
ffffffffc02038e8:	00002517          	auipc	a0,0x2
ffffffffc02038ec:	d4050513          	addi	a0,a0,-704 # ffffffffc0205628 <commands+0x700>
ffffffffc02038f0:	911fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02038f4 <kernel_thread>:
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc02038f4:	7129                	addi	sp,sp,-320
ffffffffc02038f6:	fa22                	sd	s0,304(sp)
ffffffffc02038f8:	f626                	sd	s1,296(sp)
ffffffffc02038fa:	f24a                	sd	s2,288(sp)
ffffffffc02038fc:	84ae                	mv	s1,a1
ffffffffc02038fe:	892a                	mv	s2,a0
ffffffffc0203900:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203902:	4581                	li	a1,0
ffffffffc0203904:	12000613          	li	a2,288
ffffffffc0203908:	850a                	mv	a0,sp
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc020390a:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020390c:	74b000ef          	jal	ra,ffffffffc0204856 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0203910:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc0203912:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0203914:	100027f3          	csrr	a5,sstatus
ffffffffc0203918:	edd7f793          	andi	a5,a5,-291
ffffffffc020391c:	1207e793          	ori	a5,a5,288
ffffffffc0203920:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203922:	860a                	mv	a2,sp
ffffffffc0203924:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203928:	00000797          	auipc	a5,0x0
ffffffffc020392c:	8a478793          	addi	a5,a5,-1884 # ffffffffc02031cc <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203930:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203932:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0203934:	bfdff0ef          	jal	ra,ffffffffc0203530 <do_fork>
}
ffffffffc0203938:	70f2                	ld	ra,312(sp)
ffffffffc020393a:	7452                	ld	s0,304(sp)
ffffffffc020393c:	74b2                	ld	s1,296(sp)
ffffffffc020393e:	7912                	ld	s2,288(sp)
ffffffffc0203940:	6131                	addi	sp,sp,320
ffffffffc0203942:	8082                	ret

ffffffffc0203944 <do_exit>:
do_exit(int error_code) {
ffffffffc0203944:	7179                	addi	sp,sp,-48
ffffffffc0203946:	f022                	sd	s0,32(sp)
    if (current == idleproc) {
ffffffffc0203948:	00050417          	auipc	s0,0x50
ffffffffc020394c:	b5840413          	addi	s0,s0,-1192 # ffffffffc02534a0 <current>
ffffffffc0203950:	601c                	ld	a5,0(s0)
do_exit(int error_code) {
ffffffffc0203952:	f406                	sd	ra,40(sp)
ffffffffc0203954:	ec26                	sd	s1,24(sp)
ffffffffc0203956:	e84a                	sd	s2,16(sp)
ffffffffc0203958:	e44e                	sd	s3,8(sp)
ffffffffc020395a:	e052                	sd	s4,0(sp)
    if (current == idleproc) {
ffffffffc020395c:	00050717          	auipc	a4,0x50
ffffffffc0203960:	b4c73703          	ld	a4,-1204(a4) # ffffffffc02534a8 <idleproc>
ffffffffc0203964:	0ce78c63          	beq	a5,a4,ffffffffc0203a3c <do_exit+0xf8>
    if (current == initproc) {
ffffffffc0203968:	00050497          	auipc	s1,0x50
ffffffffc020396c:	b4848493          	addi	s1,s1,-1208 # ffffffffc02534b0 <initproc>
ffffffffc0203970:	6098                	ld	a4,0(s1)
ffffffffc0203972:	0ee78b63          	beq	a5,a4,ffffffffc0203a68 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc0203976:	0287b983          	ld	s3,40(a5)
ffffffffc020397a:	892a                	mv	s2,a0
    if (mm != NULL) {
ffffffffc020397c:	02098663          	beqz	s3,ffffffffc02039a8 <do_exit+0x64>
ffffffffc0203980:	00050797          	auipc	a5,0x50
ffffffffc0203984:	b687b783          	ld	a5,-1176(a5) # ffffffffc02534e8 <boot_cr3>
ffffffffc0203988:	577d                	li	a4,-1
ffffffffc020398a:	177e                	slli	a4,a4,0x3f
ffffffffc020398c:	83b1                	srli	a5,a5,0xc
ffffffffc020398e:	8fd9                	or	a5,a5,a4
ffffffffc0203990:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0203994:	0309a783          	lw	a5,48(s3)
ffffffffc0203998:	fff7871b          	addiw	a4,a5,-1
ffffffffc020399c:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0) {
ffffffffc02039a0:	cb55                	beqz	a4,ffffffffc0203a54 <do_exit+0x110>
        current->mm = NULL;
ffffffffc02039a2:	601c                	ld	a5,0(s0)
ffffffffc02039a4:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02039a8:	601c                	ld	a5,0(s0)
ffffffffc02039aa:	470d                	li	a4,3
ffffffffc02039ac:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02039ae:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039b2:	100027f3          	csrr	a5,sstatus
ffffffffc02039b6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02039b8:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039ba:	e3f9                	bnez	a5,ffffffffc0203a80 <do_exit+0x13c>
        proc = current->parent;
ffffffffc02039bc:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039be:	800007b7          	lui	a5,0x80000
ffffffffc02039c2:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc02039c4:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039c6:	0ec52703          	lw	a4,236(a0)
ffffffffc02039ca:	0af70f63          	beq	a4,a5,ffffffffc0203a88 <do_exit+0x144>
        while (current->cptr != NULL) {
ffffffffc02039ce:	6018                	ld	a4,0(s0)
ffffffffc02039d0:	7b7c                	ld	a5,240(a4)
ffffffffc02039d2:	c3a1                	beqz	a5,ffffffffc0203a12 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc02039d4:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE) {
ffffffffc02039d8:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD) {
ffffffffc02039da:	0985                	addi	s3,s3,1
ffffffffc02039dc:	a021                	j	ffffffffc02039e4 <do_exit+0xa0>
        while (current->cptr != NULL) {
ffffffffc02039de:	6018                	ld	a4,0(s0)
ffffffffc02039e0:	7b7c                	ld	a5,240(a4)
ffffffffc02039e2:	cb85                	beqz	a5,ffffffffc0203a12 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc02039e4:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_ex3_out_size+0xffffffff7fff5400>
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039e8:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc02039ea:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039ec:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc02039ee:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc02039f2:	10e7b023          	sd	a4,256(a5)
ffffffffc02039f6:	c311                	beqz	a4,ffffffffc02039fa <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc02039f8:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc02039fa:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc02039fc:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc02039fe:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a00:	fd271fe3          	bne	a4,s2,ffffffffc02039de <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a04:	0ec52783          	lw	a5,236(a0)
ffffffffc0203a08:	fd379be3          	bne	a5,s3,ffffffffc02039de <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0203a0c:	287000ef          	jal	ra,ffffffffc0204492 <wakeup_proc>
ffffffffc0203a10:	b7f9                	j	ffffffffc02039de <do_exit+0x9a>
    if (flag) {
ffffffffc0203a12:	020a1263          	bnez	s4,ffffffffc0203a36 <do_exit+0xf2>
    schedule();
ffffffffc0203a16:	32f000ef          	jal	ra,ffffffffc0204544 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0203a1a:	601c                	ld	a5,0(s0)
ffffffffc0203a1c:	00002617          	auipc	a2,0x2
ffffffffc0203a20:	7ac60613          	addi	a2,a2,1964 # ffffffffc02061c8 <default_pmm_manager+0x170>
ffffffffc0203a24:	1c600593          	li	a1,454
ffffffffc0203a28:	43d4                	lw	a3,4(a5)
ffffffffc0203a2a:	00002517          	auipc	a0,0x2
ffffffffc0203a2e:	71e50513          	addi	a0,a0,1822 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203a32:	fcefc0ef          	jal	ra,ffffffffc0200200 <__panic>
        intr_enable();
ffffffffc0203a36:	bc3fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203a3a:	bff1                	j	ffffffffc0203a16 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0203a3c:	00002617          	auipc	a2,0x2
ffffffffc0203a40:	76c60613          	addi	a2,a2,1900 # ffffffffc02061a8 <default_pmm_manager+0x150>
ffffffffc0203a44:	19a00593          	li	a1,410
ffffffffc0203a48:	00002517          	auipc	a0,0x2
ffffffffc0203a4c:	70050513          	addi	a0,a0,1792 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203a50:	fb0fc0ef          	jal	ra,ffffffffc0200200 <__panic>
            exit_mmap(mm);
ffffffffc0203a54:	854e                	mv	a0,s3
ffffffffc0203a56:	b98fe0ef          	jal	ra,ffffffffc0201dee <exit_mmap>
            put_pgdir(mm);
ffffffffc0203a5a:	854e                	mv	a0,s3
ffffffffc0203a5c:	8efff0ef          	jal	ra,ffffffffc020334a <put_pgdir>
            mm_destroy(mm);
ffffffffc0203a60:	854e                	mv	a0,s3
ffffffffc0203a62:	9f2fe0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
ffffffffc0203a66:	bf35                	j	ffffffffc02039a2 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0203a68:	00002617          	auipc	a2,0x2
ffffffffc0203a6c:	75060613          	addi	a2,a2,1872 # ffffffffc02061b8 <default_pmm_manager+0x160>
ffffffffc0203a70:	19d00593          	li	a1,413
ffffffffc0203a74:	00002517          	auipc	a0,0x2
ffffffffc0203a78:	6d450513          	addi	a0,a0,1748 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203a7c:	f84fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        intr_disable();
ffffffffc0203a80:	b7ffc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0203a84:	4a05                	li	s4,1
ffffffffc0203a86:	bf1d                	j	ffffffffc02039bc <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0203a88:	20b000ef          	jal	ra,ffffffffc0204492 <wakeup_proc>
ffffffffc0203a8c:	b789                	j	ffffffffc02039ce <do_exit+0x8a>

ffffffffc0203a8e <do_wait.part.0>:
do_wait(int pid, int *code_store) {
ffffffffc0203a8e:	7139                	addi	sp,sp,-64
ffffffffc0203a90:	e852                	sd	s4,16(sp)
        current->wait_state = WT_CHILD;
ffffffffc0203a92:	80000a37          	lui	s4,0x80000
do_wait(int pid, int *code_store) {
ffffffffc0203a96:	f426                	sd	s1,40(sp)
ffffffffc0203a98:	f04a                	sd	s2,32(sp)
ffffffffc0203a9a:	ec4e                	sd	s3,24(sp)
ffffffffc0203a9c:	e456                	sd	s5,8(sp)
ffffffffc0203a9e:	e05a                	sd	s6,0(sp)
ffffffffc0203aa0:	fc06                	sd	ra,56(sp)
ffffffffc0203aa2:	f822                	sd	s0,48(sp)
ffffffffc0203aa4:	892a                	mv	s2,a0
ffffffffc0203aa6:	8aae                	mv	s5,a1
        proc = current->cptr;
ffffffffc0203aa8:	00050997          	auipc	s3,0x50
ffffffffc0203aac:	9f898993          	addi	s3,s3,-1544 # ffffffffc02534a0 <current>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203ab0:	448d                	li	s1,3
        current->state = PROC_SLEEPING;
ffffffffc0203ab2:	4b05                	li	s6,1
        current->wait_state = WT_CHILD;
ffffffffc0203ab4:	2a05                	addiw	s4,s4,1
    if (pid != 0) {
ffffffffc0203ab6:	02090f63          	beqz	s2,ffffffffc0203af4 <do_wait.part.0+0x66>
        proc = find_proc(pid);
ffffffffc0203aba:	854a                	mv	a0,s2
ffffffffc0203abc:	a1dff0ef          	jal	ra,ffffffffc02034d8 <find_proc>
ffffffffc0203ac0:	842a                	mv	s0,a0
        if (proc != NULL && proc->parent == current) {
ffffffffc0203ac2:	10050763          	beqz	a0,ffffffffc0203bd0 <do_wait.part.0+0x142>
ffffffffc0203ac6:	0009b703          	ld	a4,0(s3)
ffffffffc0203aca:	711c                	ld	a5,32(a0)
ffffffffc0203acc:	10e79263          	bne	a5,a4,ffffffffc0203bd0 <do_wait.part.0+0x142>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203ad0:	411c                	lw	a5,0(a0)
ffffffffc0203ad2:	02978c63          	beq	a5,s1,ffffffffc0203b0a <do_wait.part.0+0x7c>
        current->state = PROC_SLEEPING;
ffffffffc0203ad6:	01672023          	sw	s6,0(a4)
        current->wait_state = WT_CHILD;
ffffffffc0203ada:	0f472623          	sw	s4,236(a4)
        schedule();
ffffffffc0203ade:	267000ef          	jal	ra,ffffffffc0204544 <schedule>
        if (current->flags & PF_EXITING) {
ffffffffc0203ae2:	0009b783          	ld	a5,0(s3)
ffffffffc0203ae6:	0b07a783          	lw	a5,176(a5)
ffffffffc0203aea:	8b85                	andi	a5,a5,1
ffffffffc0203aec:	d7e9                	beqz	a5,ffffffffc0203ab6 <do_wait.part.0+0x28>
            do_exit(-E_KILLED);
ffffffffc0203aee:	555d                	li	a0,-9
ffffffffc0203af0:	e55ff0ef          	jal	ra,ffffffffc0203944 <do_exit>
        proc = current->cptr;
ffffffffc0203af4:	0009b703          	ld	a4,0(s3)
ffffffffc0203af8:	7b60                	ld	s0,240(a4)
        for (; proc != NULL; proc = proc->optr) {
ffffffffc0203afa:	e409                	bnez	s0,ffffffffc0203b04 <do_wait.part.0+0x76>
ffffffffc0203afc:	a8d1                	j	ffffffffc0203bd0 <do_wait.part.0+0x142>
ffffffffc0203afe:	10043403          	ld	s0,256(s0)
ffffffffc0203b02:	d871                	beqz	s0,ffffffffc0203ad6 <do_wait.part.0+0x48>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b04:	401c                	lw	a5,0(s0)
ffffffffc0203b06:	fe979ce3          	bne	a5,s1,ffffffffc0203afe <do_wait.part.0+0x70>
    if (proc == idleproc || proc == initproc) {
ffffffffc0203b0a:	00050797          	auipc	a5,0x50
ffffffffc0203b0e:	99e7b783          	ld	a5,-1634(a5) # ffffffffc02534a8 <idleproc>
ffffffffc0203b12:	0c878563          	beq	a5,s0,ffffffffc0203bdc <do_wait.part.0+0x14e>
ffffffffc0203b16:	00050797          	auipc	a5,0x50
ffffffffc0203b1a:	99a7b783          	ld	a5,-1638(a5) # ffffffffc02534b0 <initproc>
ffffffffc0203b1e:	0af40f63          	beq	s0,a5,ffffffffc0203bdc <do_wait.part.0+0x14e>
    if (code_store != NULL) {
ffffffffc0203b22:	000a8663          	beqz	s5,ffffffffc0203b2e <do_wait.part.0+0xa0>
        *code_store = proc->exit_code;
ffffffffc0203b26:	0e842783          	lw	a5,232(s0)
ffffffffc0203b2a:	00faa023          	sw	a5,0(s5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b2e:	100027f3          	csrr	a5,sstatus
ffffffffc0203b32:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203b34:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b36:	efd9                	bnez	a5,ffffffffc0203bd4 <do_wait.part.0+0x146>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b38:	6c70                	ld	a2,216(s0)
ffffffffc0203b3a:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL) {
ffffffffc0203b3c:	10043703          	ld	a4,256(s0)
ffffffffc0203b40:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0203b42:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b44:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b46:	6470                	ld	a2,200(s0)
ffffffffc0203b48:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0203b4a:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b4c:	e290                	sd	a2,0(a3)
ffffffffc0203b4e:	c319                	beqz	a4,ffffffffc0203b54 <do_wait.part.0+0xc6>
        proc->optr->yptr = proc->yptr;
ffffffffc0203b50:	ff7c                	sd	a5,248(a4)
ffffffffc0203b52:	7c7c                	ld	a5,248(s0)
    if (proc->yptr != NULL) {
ffffffffc0203b54:	cbbd                	beqz	a5,ffffffffc0203bca <do_wait.part.0+0x13c>
        proc->yptr->optr = proc->optr;
ffffffffc0203b56:	10e7b023          	sd	a4,256(a5)
    nr_process --;
ffffffffc0203b5a:	00050717          	auipc	a4,0x50
ffffffffc0203b5e:	95e70713          	addi	a4,a4,-1698 # ffffffffc02534b8 <nr_process>
ffffffffc0203b62:	431c                	lw	a5,0(a4)
ffffffffc0203b64:	37fd                	addiw	a5,a5,-1
ffffffffc0203b66:	c31c                	sw	a5,0(a4)
    if (flag) {
ffffffffc0203b68:	edb1                	bnez	a1,ffffffffc0203bc4 <do_wait.part.0+0x136>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203b6a:	6814                	ld	a3,16(s0)
ffffffffc0203b6c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203b70:	08f6ee63          	bltu	a3,a5,ffffffffc0203c0c <do_wait.part.0+0x17e>
ffffffffc0203b74:	00050797          	auipc	a5,0x50
ffffffffc0203b78:	96c7b783          	ld	a5,-1684(a5) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0203b7c:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203b7e:	82b1                	srli	a3,a3,0xc
ffffffffc0203b80:	00050797          	auipc	a5,0x50
ffffffffc0203b84:	8f87b783          	ld	a5,-1800(a5) # ffffffffc0253478 <npage>
ffffffffc0203b88:	06f6f663          	bgeu	a3,a5,ffffffffc0203bf4 <do_wait.part.0+0x166>
    return &pages[PPN(pa) - nbase];
ffffffffc0203b8c:	00003517          	auipc	a0,0x3
ffffffffc0203b90:	60453503          	ld	a0,1540(a0) # ffffffffc0207190 <nbase>
ffffffffc0203b94:	8e89                	sub	a3,a3,a0
ffffffffc0203b96:	069a                	slli	a3,a3,0x6
ffffffffc0203b98:	00050517          	auipc	a0,0x50
ffffffffc0203b9c:	95853503          	ld	a0,-1704(a0) # ffffffffc02534f0 <pages>
ffffffffc0203ba0:	9536                	add	a0,a0,a3
ffffffffc0203ba2:	4589                	li	a1,2
ffffffffc0203ba4:	a0cfd0ef          	jal	ra,ffffffffc0200db0 <free_pages>
    kfree(proc);
ffffffffc0203ba8:	8522                	mv	a0,s0
ffffffffc0203baa:	f04fe0ef          	jal	ra,ffffffffc02022ae <kfree>
    return 0;
ffffffffc0203bae:	4501                	li	a0,0
}
ffffffffc0203bb0:	70e2                	ld	ra,56(sp)
ffffffffc0203bb2:	7442                	ld	s0,48(sp)
ffffffffc0203bb4:	74a2                	ld	s1,40(sp)
ffffffffc0203bb6:	7902                	ld	s2,32(sp)
ffffffffc0203bb8:	69e2                	ld	s3,24(sp)
ffffffffc0203bba:	6a42                	ld	s4,16(sp)
ffffffffc0203bbc:	6aa2                	ld	s5,8(sp)
ffffffffc0203bbe:	6b02                	ld	s6,0(sp)
ffffffffc0203bc0:	6121                	addi	sp,sp,64
ffffffffc0203bc2:	8082                	ret
        intr_enable();
ffffffffc0203bc4:	a35fc0ef          	jal	ra,ffffffffc02005f8 <intr_enable>
ffffffffc0203bc8:	b74d                	j	ffffffffc0203b6a <do_wait.part.0+0xdc>
       proc->parent->cptr = proc->optr;
ffffffffc0203bca:	701c                	ld	a5,32(s0)
ffffffffc0203bcc:	fbf8                	sd	a4,240(a5)
ffffffffc0203bce:	b771                	j	ffffffffc0203b5a <do_wait.part.0+0xcc>
    return -E_BAD_PROC;
ffffffffc0203bd0:	5579                	li	a0,-2
ffffffffc0203bd2:	bff9                	j	ffffffffc0203bb0 <do_wait.part.0+0x122>
        intr_disable();
ffffffffc0203bd4:	a2bfc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0203bd8:	4585                	li	a1,1
ffffffffc0203bda:	bfb9                	j	ffffffffc0203b38 <do_wait.part.0+0xaa>
        panic("wait idleproc or initproc.\n");
ffffffffc0203bdc:	00002617          	auipc	a2,0x2
ffffffffc0203be0:	60c60613          	addi	a2,a2,1548 # ffffffffc02061e8 <default_pmm_manager+0x190>
ffffffffc0203be4:	2b500593          	li	a1,693
ffffffffc0203be8:	00002517          	auipc	a0,0x2
ffffffffc0203bec:	56050513          	addi	a0,a0,1376 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203bf0:	e10fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203bf4:	00002617          	auipc	a2,0x2
ffffffffc0203bf8:	a1460613          	addi	a2,a2,-1516 # ffffffffc0205608 <commands+0x6e0>
ffffffffc0203bfc:	06200593          	li	a1,98
ffffffffc0203c00:	00002517          	auipc	a0,0x2
ffffffffc0203c04:	a2850513          	addi	a0,a0,-1496 # ffffffffc0205628 <commands+0x700>
ffffffffc0203c08:	df8fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203c0c:	00002617          	auipc	a2,0x2
ffffffffc0203c10:	a8460613          	addi	a2,a2,-1404 # ffffffffc0205690 <commands+0x768>
ffffffffc0203c14:	06e00593          	li	a1,110
ffffffffc0203c18:	00002517          	auipc	a0,0x2
ffffffffc0203c1c:	a1050513          	addi	a0,a0,-1520 # ffffffffc0205628 <commands+0x700>
ffffffffc0203c20:	de0fc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203c24 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
ffffffffc0203c24:	1141                	addi	sp,sp,-16
ffffffffc0203c26:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0203c28:	9cafd0ef          	jal	ra,ffffffffc0200df2 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0203c2c:	dcefe0ef          	jal	ra,ffffffffc02021fa <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0203c30:	4601                	li	a2,0
ffffffffc0203c32:	4581                	li	a1,0
ffffffffc0203c34:	fffff517          	auipc	a0,0xfffff
ffffffffc0203c38:	69850513          	addi	a0,a0,1688 # ffffffffc02032cc <user_main>
ffffffffc0203c3c:	cb9ff0ef          	jal	ra,ffffffffc02038f4 <kernel_thread>
    if (pid <= 0) {
ffffffffc0203c40:	00a04563          	bgtz	a0,ffffffffc0203c4a <init_main+0x26>
ffffffffc0203c44:	a071                	j	ffffffffc0203cd0 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0) {
        schedule();
ffffffffc0203c46:	0ff000ef          	jal	ra,ffffffffc0204544 <schedule>
    if (code_store != NULL) {
ffffffffc0203c4a:	4581                	li	a1,0
ffffffffc0203c4c:	4501                	li	a0,0
ffffffffc0203c4e:	e41ff0ef          	jal	ra,ffffffffc0203a8e <do_wait.part.0>
    while (do_wait(0, NULL) == 0) {
ffffffffc0203c52:	d975                	beqz	a0,ffffffffc0203c46 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0203c54:	00002517          	auipc	a0,0x2
ffffffffc0203c58:	5d450513          	addi	a0,a0,1492 # ffffffffc0206228 <default_pmm_manager+0x1d0>
ffffffffc0203c5c:	c68fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203c60:	00050797          	auipc	a5,0x50
ffffffffc0203c64:	8507b783          	ld	a5,-1968(a5) # ffffffffc02534b0 <initproc>
ffffffffc0203c68:	7bf8                	ld	a4,240(a5)
ffffffffc0203c6a:	e339                	bnez	a4,ffffffffc0203cb0 <init_main+0x8c>
ffffffffc0203c6c:	7ff8                	ld	a4,248(a5)
ffffffffc0203c6e:	e329                	bnez	a4,ffffffffc0203cb0 <init_main+0x8c>
ffffffffc0203c70:	1007b703          	ld	a4,256(a5)
ffffffffc0203c74:	ef15                	bnez	a4,ffffffffc0203cb0 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0203c76:	00050697          	auipc	a3,0x50
ffffffffc0203c7a:	8426a683          	lw	a3,-1982(a3) # ffffffffc02534b8 <nr_process>
ffffffffc0203c7e:	4709                	li	a4,2
ffffffffc0203c80:	0ae69463          	bne	a3,a4,ffffffffc0203d28 <init_main+0x104>
    return listelm->next;
ffffffffc0203c84:	00050697          	auipc	a3,0x50
ffffffffc0203c88:	96c68693          	addi	a3,a3,-1684 # ffffffffc02535f0 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203c8c:	6698                	ld	a4,8(a3)
ffffffffc0203c8e:	0c878793          	addi	a5,a5,200
ffffffffc0203c92:	06f71b63          	bne	a4,a5,ffffffffc0203d08 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203c96:	629c                	ld	a5,0(a3)
ffffffffc0203c98:	04f71863          	bne	a4,a5,ffffffffc0203ce8 <init_main+0xc4>

    //cprintf("init check memory pass.\n");
    cprintf("The end of init_main\n");
ffffffffc0203c9c:	00002517          	auipc	a0,0x2
ffffffffc0203ca0:	67450513          	addi	a0,a0,1652 # ffffffffc0206310 <default_pmm_manager+0x2b8>
ffffffffc0203ca4:	c20fc0ef          	jal	ra,ffffffffc02000c4 <cprintf>
    return 0;
}
ffffffffc0203ca8:	60a2                	ld	ra,8(sp)
ffffffffc0203caa:	4501                	li	a0,0
ffffffffc0203cac:	0141                	addi	sp,sp,16
ffffffffc0203cae:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203cb0:	00002697          	auipc	a3,0x2
ffffffffc0203cb4:	5a068693          	addi	a3,a3,1440 # ffffffffc0206250 <default_pmm_manager+0x1f8>
ffffffffc0203cb8:	00001617          	auipc	a2,0x1
ffffffffc0203cbc:	66060613          	addi	a2,a2,1632 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203cc0:	31900593          	li	a1,793
ffffffffc0203cc4:	00002517          	auipc	a0,0x2
ffffffffc0203cc8:	48450513          	addi	a0,a0,1156 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203ccc:	d34fc0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("create user_main failed.\n");
ffffffffc0203cd0:	00002617          	auipc	a2,0x2
ffffffffc0203cd4:	53860613          	addi	a2,a2,1336 # ffffffffc0206208 <default_pmm_manager+0x1b0>
ffffffffc0203cd8:	31100593          	li	a1,785
ffffffffc0203cdc:	00002517          	auipc	a0,0x2
ffffffffc0203ce0:	46c50513          	addi	a0,a0,1132 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203ce4:	d1cfc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203ce8:	00002697          	auipc	a3,0x2
ffffffffc0203cec:	5f868693          	addi	a3,a3,1528 # ffffffffc02062e0 <default_pmm_manager+0x288>
ffffffffc0203cf0:	00001617          	auipc	a2,0x1
ffffffffc0203cf4:	62860613          	addi	a2,a2,1576 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203cf8:	31c00593          	li	a1,796
ffffffffc0203cfc:	00002517          	auipc	a0,0x2
ffffffffc0203d00:	44c50513          	addi	a0,a0,1100 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203d04:	cfcfc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203d08:	00002697          	auipc	a3,0x2
ffffffffc0203d0c:	5a868693          	addi	a3,a3,1448 # ffffffffc02062b0 <default_pmm_manager+0x258>
ffffffffc0203d10:	00001617          	auipc	a2,0x1
ffffffffc0203d14:	60860613          	addi	a2,a2,1544 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203d18:	31b00593          	li	a1,795
ffffffffc0203d1c:	00002517          	auipc	a0,0x2
ffffffffc0203d20:	42c50513          	addi	a0,a0,1068 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203d24:	cdcfc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(nr_process == 2);
ffffffffc0203d28:	00002697          	auipc	a3,0x2
ffffffffc0203d2c:	57868693          	addi	a3,a3,1400 # ffffffffc02062a0 <default_pmm_manager+0x248>
ffffffffc0203d30:	00001617          	auipc	a2,0x1
ffffffffc0203d34:	5e860613          	addi	a2,a2,1512 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0203d38:	31a00593          	li	a1,794
ffffffffc0203d3c:	00002517          	auipc	a0,0x2
ffffffffc0203d40:	40c50513          	addi	a0,a0,1036 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203d44:	cbcfc0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0203d48 <do_execve>:
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d48:	7135                	addi	sp,sp,-160
ffffffffc0203d4a:	f4d6                	sd	s5,104(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d4c:	0004fa97          	auipc	s5,0x4f
ffffffffc0203d50:	754a8a93          	addi	s5,s5,1876 # ffffffffc02534a0 <current>
ffffffffc0203d54:	000ab783          	ld	a5,0(s5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d58:	f8d2                	sd	s4,112(sp)
ffffffffc0203d5a:	e526                	sd	s1,136(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d5c:	0287ba03          	ld	s4,40(a5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d60:	e14a                	sd	s2,128(sp)
ffffffffc0203d62:	fcce                	sd	s3,120(sp)
ffffffffc0203d64:	892a                	mv	s2,a0
ffffffffc0203d66:	84ae                	mv	s1,a1
ffffffffc0203d68:	89b2                	mv	s3,a2
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203d6a:	4681                	li	a3,0
ffffffffc0203d6c:	862e                	mv	a2,a1
ffffffffc0203d6e:	85aa                	mv	a1,a0
ffffffffc0203d70:	8552                	mv	a0,s4
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d72:	ed06                	sd	ra,152(sp)
ffffffffc0203d74:	e922                	sd	s0,144(sp)
ffffffffc0203d76:	f0da                	sd	s6,96(sp)
ffffffffc0203d78:	ecde                	sd	s7,88(sp)
ffffffffc0203d7a:	e8e2                	sd	s8,80(sp)
ffffffffc0203d7c:	e4e6                	sd	s9,72(sp)
ffffffffc0203d7e:	e0ea                	sd	s10,64(sp)
ffffffffc0203d80:	fc6e                	sd	s11,56(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203d82:	9e6fe0ef          	jal	ra,ffffffffc0201f68 <user_mem_check>
ffffffffc0203d86:	3e050763          	beqz	a0,ffffffffc0204174 <do_execve+0x42c>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0203d8a:	4641                	li	a2,16
ffffffffc0203d8c:	4581                	li	a1,0
ffffffffc0203d8e:	1008                	addi	a0,sp,32
ffffffffc0203d90:	2c7000ef          	jal	ra,ffffffffc0204856 <memset>
    memcpy(local_name, name, len);
ffffffffc0203d94:	47bd                	li	a5,15
ffffffffc0203d96:	8626                	mv	a2,s1
ffffffffc0203d98:	0697ed63          	bltu	a5,s1,ffffffffc0203e12 <do_execve+0xca>
ffffffffc0203d9c:	85ca                	mv	a1,s2
ffffffffc0203d9e:	1008                	addi	a0,sp,32
ffffffffc0203da0:	2c9000ef          	jal	ra,ffffffffc0204868 <memcpy>
    if (mm != NULL) {
ffffffffc0203da4:	060a0e63          	beqz	s4,ffffffffc0203e20 <do_execve+0xd8>
        cputs("mm != NULL");
ffffffffc0203da8:	00002517          	auipc	a0,0x2
ffffffffc0203dac:	c8850513          	addi	a0,a0,-888 # ffffffffc0205a30 <commands+0xb08>
ffffffffc0203db0:	b4cfc0ef          	jal	ra,ffffffffc02000fc <cputs>
ffffffffc0203db4:	0004f797          	auipc	a5,0x4f
ffffffffc0203db8:	7347b783          	ld	a5,1844(a5) # ffffffffc02534e8 <boot_cr3>
ffffffffc0203dbc:	577d                	li	a4,-1
ffffffffc0203dbe:	177e                	slli	a4,a4,0x3f
ffffffffc0203dc0:	83b1                	srli	a5,a5,0xc
ffffffffc0203dc2:	8fd9                	or	a5,a5,a4
ffffffffc0203dc4:	18079073          	csrw	satp,a5
ffffffffc0203dc8:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <_binary_obj___user_ex3_out_size+0xffffffff7fff5330>
ffffffffc0203dcc:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203dd0:	02ea2823          	sw	a4,48(s4)
        if (mm_count_dec(mm) == 0) {
ffffffffc0203dd4:	28070663          	beqz	a4,ffffffffc0204060 <do_execve+0x318>
        current->mm = NULL;
ffffffffc0203dd8:	000ab783          	ld	a5,0(s5)
ffffffffc0203ddc:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL) {
ffffffffc0203de0:	d1dfd0ef          	jal	ra,ffffffffc0201afc <mm_create>
ffffffffc0203de4:	84aa                	mv	s1,a0
ffffffffc0203de6:	c135                	beqz	a0,ffffffffc0203e4a <do_execve+0x102>
    if (setup_pgdir(mm) != 0) {
ffffffffc0203de8:	dd8ff0ef          	jal	ra,ffffffffc02033c0 <setup_pgdir>
ffffffffc0203dec:	e931                	bnez	a0,ffffffffc0203e40 <do_execve+0xf8>
    if (elf->e_magic != ELF_MAGIC) {
ffffffffc0203dee:	0009a703          	lw	a4,0(s3)
ffffffffc0203df2:	464c47b7          	lui	a5,0x464c4
ffffffffc0203df6:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_ex3_out_size+0x464b987f>
ffffffffc0203dfa:	04f70a63          	beq	a4,a5,ffffffffc0203e4e <do_execve+0x106>
    put_pgdir(mm);
ffffffffc0203dfe:	8526                	mv	a0,s1
ffffffffc0203e00:	d4aff0ef          	jal	ra,ffffffffc020334a <put_pgdir>
    mm_destroy(mm);
ffffffffc0203e04:	8526                	mv	a0,s1
ffffffffc0203e06:	e4ffd0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0203e0a:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0203e0c:	8552                	mv	a0,s4
ffffffffc0203e0e:	b37ff0ef          	jal	ra,ffffffffc0203944 <do_exit>
    memcpy(local_name, name, len);
ffffffffc0203e12:	463d                	li	a2,15
ffffffffc0203e14:	85ca                	mv	a1,s2
ffffffffc0203e16:	1008                	addi	a0,sp,32
ffffffffc0203e18:	251000ef          	jal	ra,ffffffffc0204868 <memcpy>
    if (mm != NULL) {
ffffffffc0203e1c:	f80a16e3          	bnez	s4,ffffffffc0203da8 <do_execve+0x60>
    if (current->mm != NULL) {
ffffffffc0203e20:	000ab783          	ld	a5,0(s5)
ffffffffc0203e24:	779c                	ld	a5,40(a5)
ffffffffc0203e26:	dfcd                	beqz	a5,ffffffffc0203de0 <do_execve+0x98>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0203e28:	00002617          	auipc	a2,0x2
ffffffffc0203e2c:	50060613          	addi	a2,a2,1280 # ffffffffc0206328 <default_pmm_manager+0x2d0>
ffffffffc0203e30:	1d000593          	li	a1,464
ffffffffc0203e34:	00002517          	auipc	a0,0x2
ffffffffc0203e38:	31450513          	addi	a0,a0,788 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc0203e3c:	bc4fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    mm_destroy(mm);
ffffffffc0203e40:	8526                	mv	a0,s1
ffffffffc0203e42:	e13fd0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0203e46:	5a71                	li	s4,-4
ffffffffc0203e48:	b7d1                	j	ffffffffc0203e0c <do_execve+0xc4>
ffffffffc0203e4a:	5a71                	li	s4,-4
ffffffffc0203e4c:	b7c1                	j	ffffffffc0203e0c <do_execve+0xc4>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e4e:	0389d703          	lhu	a4,56(s3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e52:	0209b903          	ld	s2,32(s3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e56:	00371793          	slli	a5,a4,0x3
ffffffffc0203e5a:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e5c:	994e                	add	s2,s2,s3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e5e:	078e                	slli	a5,a5,0x3
ffffffffc0203e60:	97ca                	add	a5,a5,s2
ffffffffc0203e62:	ec3e                	sd	a5,24(sp)
    for (; ph < ph_end; ph ++) {
ffffffffc0203e64:	02f97c63          	bgeu	s2,a5,ffffffffc0203e9c <do_execve+0x154>
    return KADDR(page2pa(page));
ffffffffc0203e68:	5bfd                	li	s7,-1
ffffffffc0203e6a:	00cbd793          	srli	a5,s7,0xc
    return page - pages + nbase;
ffffffffc0203e6e:	0004fd97          	auipc	s11,0x4f
ffffffffc0203e72:	682d8d93          	addi	s11,s11,1666 # ffffffffc02534f0 <pages>
ffffffffc0203e76:	00003d17          	auipc	s10,0x3
ffffffffc0203e7a:	31ad0d13          	addi	s10,s10,794 # ffffffffc0207190 <nbase>
    return KADDR(page2pa(page));
ffffffffc0203e7e:	e43e                	sd	a5,8(sp)
ffffffffc0203e80:	0004fc97          	auipc	s9,0x4f
ffffffffc0203e84:	5f8c8c93          	addi	s9,s9,1528 # ffffffffc0253478 <npage>
        if (ph->p_type != ELF_PT_LOAD) {
ffffffffc0203e88:	00092703          	lw	a4,0(s2)
ffffffffc0203e8c:	4785                	li	a5,1
ffffffffc0203e8e:	0ef70463          	beq	a4,a5,ffffffffc0203f76 <do_execve+0x22e>
    for (; ph < ph_end; ph ++) {
ffffffffc0203e92:	67e2                	ld	a5,24(sp)
ffffffffc0203e94:	03890913          	addi	s2,s2,56
ffffffffc0203e98:	fef968e3          	bltu	s2,a5,ffffffffc0203e88 <do_execve+0x140>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
ffffffffc0203e9c:	4701                	li	a4,0
ffffffffc0203e9e:	46ad                	li	a3,11
ffffffffc0203ea0:	00100637          	lui	a2,0x100
ffffffffc0203ea4:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0203ea8:	8526                	mv	a0,s1
ffffffffc0203eaa:	dfbfd0ef          	jal	ra,ffffffffc0201ca4 <mm_map>
ffffffffc0203eae:	8a2a                	mv	s4,a0
ffffffffc0203eb0:	18051e63          	bnez	a0,ffffffffc020404c <do_execve+0x304>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0203eb4:	6c88                	ld	a0,24(s1)
ffffffffc0203eb6:	467d                	li	a2,31
ffffffffc0203eb8:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0203ebc:	fa0fd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0203ec0:	34050863          	beqz	a0,ffffffffc0204210 <do_execve+0x4c8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ec4:	6c88                	ld	a0,24(s1)
ffffffffc0203ec6:	467d                	li	a2,31
ffffffffc0203ec8:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0203ecc:	f90fd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0203ed0:	32050063          	beqz	a0,ffffffffc02041f0 <do_execve+0x4a8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ed4:	6c88                	ld	a0,24(s1)
ffffffffc0203ed6:	467d                	li	a2,31
ffffffffc0203ed8:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0203edc:	f80fd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0203ee0:	2e050863          	beqz	a0,ffffffffc02041d0 <do_execve+0x488>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc0203ee4:	6c88                	ld	a0,24(s1)
ffffffffc0203ee6:	467d                	li	a2,31
ffffffffc0203ee8:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0203eec:	f70fd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0203ef0:	2c050063          	beqz	a0,ffffffffc02041b0 <do_execve+0x468>
    mm->mm_count += 1;
ffffffffc0203ef4:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0203ef6:	000ab603          	ld	a2,0(s5)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203efa:	6c94                	ld	a3,24(s1)
ffffffffc0203efc:	2785                	addiw	a5,a5,1
ffffffffc0203efe:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f00:	f604                	sd	s1,40(a2)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f02:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f06:	28f6e963          	bltu	a3,a5,ffffffffc0204198 <do_execve+0x450>
ffffffffc0203f0a:	0004f797          	auipc	a5,0x4f
ffffffffc0203f0e:	5d67b783          	ld	a5,1494(a5) # ffffffffc02534e0 <va_pa_offset>
ffffffffc0203f12:	8e9d                	sub	a3,a3,a5
ffffffffc0203f14:	577d                	li	a4,-1
ffffffffc0203f16:	00c6d793          	srli	a5,a3,0xc
ffffffffc0203f1a:	177e                	slli	a4,a4,0x3f
ffffffffc0203f1c:	f654                	sd	a3,168(a2)
ffffffffc0203f1e:	8fd9                	or	a5,a5,a4
ffffffffc0203f20:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0203f24:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f26:	4581                	li	a1,0
ffffffffc0203f28:	12000613          	li	a2,288
ffffffffc0203f2c:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0203f2e:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f32:	125000ef          	jal	ra,ffffffffc0204856 <memset>
    tf->epc = elf->e_entry;
ffffffffc0203f36:	0189b703          	ld	a4,24(s3)
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f3a:	4785                	li	a5,1
    set_proc_name(current, local_name);
ffffffffc0203f3c:	000ab503          	ld	a0,0(s5)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f40:	edf4f493          	andi	s1,s1,-289
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f44:	07fe                	slli	a5,a5,0x1f
ffffffffc0203f46:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0203f48:	10e43423          	sd	a4,264(s0)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f4c:	10943023          	sd	s1,256(s0)
    set_proc_name(current, local_name);
ffffffffc0203f50:	100c                	addi	a1,sp,32
ffffffffc0203f52:	cf0ff0ef          	jal	ra,ffffffffc0203442 <set_proc_name>
}
ffffffffc0203f56:	60ea                	ld	ra,152(sp)
ffffffffc0203f58:	644a                	ld	s0,144(sp)
ffffffffc0203f5a:	64aa                	ld	s1,136(sp)
ffffffffc0203f5c:	690a                	ld	s2,128(sp)
ffffffffc0203f5e:	79e6                	ld	s3,120(sp)
ffffffffc0203f60:	7aa6                	ld	s5,104(sp)
ffffffffc0203f62:	7b06                	ld	s6,96(sp)
ffffffffc0203f64:	6be6                	ld	s7,88(sp)
ffffffffc0203f66:	6c46                	ld	s8,80(sp)
ffffffffc0203f68:	6ca6                	ld	s9,72(sp)
ffffffffc0203f6a:	6d06                	ld	s10,64(sp)
ffffffffc0203f6c:	7de2                	ld	s11,56(sp)
ffffffffc0203f6e:	8552                	mv	a0,s4
ffffffffc0203f70:	7a46                	ld	s4,112(sp)
ffffffffc0203f72:	610d                	addi	sp,sp,160
ffffffffc0203f74:	8082                	ret
        if (ph->p_filesz > ph->p_memsz) {
ffffffffc0203f76:	02893603          	ld	a2,40(s2)
ffffffffc0203f7a:	02093783          	ld	a5,32(s2)
ffffffffc0203f7e:	1ef66f63          	bltu	a2,a5,ffffffffc020417c <do_execve+0x434>
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
ffffffffc0203f82:	00492783          	lw	a5,4(s2)
ffffffffc0203f86:	0017f693          	andi	a3,a5,1
ffffffffc0203f8a:	c291                	beqz	a3,ffffffffc0203f8e <do_execve+0x246>
ffffffffc0203f8c:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203f8e:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203f92:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203f94:	0e071063          	bnez	a4,ffffffffc0204074 <do_execve+0x32c>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0203f98:	4745                	li	a4,17
ffffffffc0203f9a:	e03a                	sd	a4,0(sp)
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203f9c:	c789                	beqz	a5,ffffffffc0203fa6 <do_execve+0x25e>
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203f9e:	47cd                	li	a5,19
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fa0:	0016e693          	ori	a3,a3,1
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fa4:	e03e                	sd	a5,0(sp)
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc0203fa6:	0026f793          	andi	a5,a3,2
ffffffffc0203faa:	ebe1                	bnez	a5,ffffffffc020407a <do_execve+0x332>
        if (vm_flags & VM_EXEC) perm |= PTE_X;
ffffffffc0203fac:	0046f793          	andi	a5,a3,4
ffffffffc0203fb0:	c789                	beqz	a5,ffffffffc0203fba <do_execve+0x272>
ffffffffc0203fb2:	6782                	ld	a5,0(sp)
ffffffffc0203fb4:	0087e793          	ori	a5,a5,8
ffffffffc0203fb8:	e03e                	sd	a5,0(sp)
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
ffffffffc0203fba:	01093583          	ld	a1,16(s2)
ffffffffc0203fbe:	4701                	li	a4,0
ffffffffc0203fc0:	8526                	mv	a0,s1
ffffffffc0203fc2:	ce3fd0ef          	jal	ra,ffffffffc0201ca4 <mm_map>
ffffffffc0203fc6:	8a2a                	mv	s4,a0
ffffffffc0203fc8:	e151                	bnez	a0,ffffffffc020404c <do_execve+0x304>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fca:	01093c03          	ld	s8,16(s2)
        end = ph->p_va + ph->p_filesz;
ffffffffc0203fce:	02093a03          	ld	s4,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0203fd2:	00893b03          	ld	s6,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fd6:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0203fd8:	9a62                	add	s4,s4,s8
        unsigned char *from = binary + ph->p_offset;
ffffffffc0203fda:	9b4e                	add	s6,s6,s3
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0203fdc:	00fc7bb3          	and	s7,s8,a5
        while (start < end) {
ffffffffc0203fe0:	054c6e63          	bltu	s8,s4,ffffffffc020403c <do_execve+0x2f4>
ffffffffc0203fe4:	aa51                	j	ffffffffc0204178 <do_execve+0x430>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0203fe6:	6785                	lui	a5,0x1
ffffffffc0203fe8:	417c0533          	sub	a0,s8,s7
ffffffffc0203fec:	9bbe                	add	s7,s7,a5
ffffffffc0203fee:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0203ff2:	017a7463          	bgeu	s4,s7,ffffffffc0203ffa <do_execve+0x2b2>
                size -= la - end;
ffffffffc0203ff6:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0203ffa:	000db683          	ld	a3,0(s11)
ffffffffc0203ffe:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204002:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204004:	40d406b3          	sub	a3,s0,a3
ffffffffc0204008:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc020400a:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc020400e:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204010:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204014:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204016:	16b87563          	bgeu	a6,a1,ffffffffc0204180 <do_execve+0x438>
ffffffffc020401a:	0004f797          	auipc	a5,0x4f
ffffffffc020401e:	4c678793          	addi	a5,a5,1222 # ffffffffc02534e0 <va_pa_offset>
ffffffffc0204022:	0007b803          	ld	a6,0(a5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204026:	85da                	mv	a1,s6
            start += size, from += size;
ffffffffc0204028:	9c32                	add	s8,s8,a2
ffffffffc020402a:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc020402c:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc020402e:	e832                	sd	a2,16(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204030:	039000ef          	jal	ra,ffffffffc0204868 <memcpy>
            start += size, from += size;
ffffffffc0204034:	6642                	ld	a2,16(sp)
ffffffffc0204036:	9b32                	add	s6,s6,a2
        while (start < end) {
ffffffffc0204038:	054c7463          	bgeu	s8,s4,ffffffffc0204080 <do_execve+0x338>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc020403c:	6c88                	ld	a0,24(s1)
ffffffffc020403e:	6602                	ld	a2,0(sp)
ffffffffc0204040:	85de                	mv	a1,s7
ffffffffc0204042:	e1afd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0204046:	842a                	mv	s0,a0
ffffffffc0204048:	fd59                	bnez	a0,ffffffffc0203fe6 <do_execve+0x29e>
        ret = -E_NO_MEM;
ffffffffc020404a:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc020404c:	8526                	mv	a0,s1
ffffffffc020404e:	da1fd0ef          	jal	ra,ffffffffc0201dee <exit_mmap>
    put_pgdir(mm);
ffffffffc0204052:	8526                	mv	a0,s1
ffffffffc0204054:	af6ff0ef          	jal	ra,ffffffffc020334a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204058:	8526                	mv	a0,s1
ffffffffc020405a:	bfbfd0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
    return ret;
ffffffffc020405e:	b37d                	j	ffffffffc0203e0c <do_execve+0xc4>
            exit_mmap(mm);
ffffffffc0204060:	8552                	mv	a0,s4
ffffffffc0204062:	d8dfd0ef          	jal	ra,ffffffffc0201dee <exit_mmap>
            put_pgdir(mm);
ffffffffc0204066:	8552                	mv	a0,s4
ffffffffc0204068:	ae2ff0ef          	jal	ra,ffffffffc020334a <put_pgdir>
            mm_destroy(mm);
ffffffffc020406c:	8552                	mv	a0,s4
ffffffffc020406e:	be7fd0ef          	jal	ra,ffffffffc0201c54 <mm_destroy>
ffffffffc0204072:	b39d                	j	ffffffffc0203dd8 <do_execve+0x90>
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0204074:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0204078:	f39d                	bnez	a5,ffffffffc0203f9e <do_execve+0x256>
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc020407a:	47dd                	li	a5,23
ffffffffc020407c:	e03e                	sd	a5,0(sp)
ffffffffc020407e:	b73d                	j	ffffffffc0203fac <do_execve+0x264>
ffffffffc0204080:	01093a03          	ld	s4,16(s2)
        end = ph->p_va + ph->p_memsz;
ffffffffc0204084:	02893683          	ld	a3,40(s2)
ffffffffc0204088:	9a36                	add	s4,s4,a3
        if (start < la) {
ffffffffc020408a:	077c7f63          	bgeu	s8,s7,ffffffffc0204108 <do_execve+0x3c0>
            if (start == end) {
ffffffffc020408e:	e18a02e3          	beq	s4,s8,ffffffffc0203e92 <do_execve+0x14a>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204092:	6505                	lui	a0,0x1
ffffffffc0204094:	9562                	add	a0,a0,s8
ffffffffc0204096:	41750533          	sub	a0,a0,s7
                size -= la - end;
ffffffffc020409a:	418a0b33          	sub	s6,s4,s8
            if (end < la) {
ffffffffc020409e:	0d7a7863          	bgeu	s4,s7,ffffffffc020416e <do_execve+0x426>
    return page - pages + nbase;
ffffffffc02040a2:	000db683          	ld	a3,0(s11)
ffffffffc02040a6:	000d3583          	ld	a1,0(s10)
    return KADDR(page2pa(page));
ffffffffc02040aa:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02040ac:	40d406b3          	sub	a3,s0,a3
ffffffffc02040b0:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040b2:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc02040b6:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc02040b8:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02040bc:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040be:	0cc5f163          	bgeu	a1,a2,ffffffffc0204180 <do_execve+0x438>
ffffffffc02040c2:	0004f617          	auipc	a2,0x4f
ffffffffc02040c6:	41e63603          	ld	a2,1054(a2) # ffffffffc02534e0 <va_pa_offset>
ffffffffc02040ca:	96b2                	add	a3,a3,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc02040cc:	4581                	li	a1,0
ffffffffc02040ce:	865a                	mv	a2,s6
ffffffffc02040d0:	9536                	add	a0,a0,a3
ffffffffc02040d2:	784000ef          	jal	ra,ffffffffc0204856 <memset>
            start += size;
ffffffffc02040d6:	018b0733          	add	a4,s6,s8
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc02040da:	037a7463          	bgeu	s4,s7,ffffffffc0204102 <do_execve+0x3ba>
ffffffffc02040de:	daea0ae3          	beq	s4,a4,ffffffffc0203e92 <do_execve+0x14a>
ffffffffc02040e2:	00002697          	auipc	a3,0x2
ffffffffc02040e6:	26e68693          	addi	a3,a3,622 # ffffffffc0206350 <default_pmm_manager+0x2f8>
ffffffffc02040ea:	00001617          	auipc	a2,0x1
ffffffffc02040ee:	22e60613          	addi	a2,a2,558 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02040f2:	22500593          	li	a1,549
ffffffffc02040f6:	00002517          	auipc	a0,0x2
ffffffffc02040fa:	05250513          	addi	a0,a0,82 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02040fe:	902fc0ef          	jal	ra,ffffffffc0200200 <__panic>
ffffffffc0204102:	ff7710e3          	bne	a4,s7,ffffffffc02040e2 <do_execve+0x39a>
ffffffffc0204106:	8c5e                	mv	s8,s7
ffffffffc0204108:	0004fb17          	auipc	s6,0x4f
ffffffffc020410c:	3d8b0b13          	addi	s6,s6,984 # ffffffffc02534e0 <va_pa_offset>
        while (start < end) {
ffffffffc0204110:	054c6763          	bltu	s8,s4,ffffffffc020415e <do_execve+0x416>
ffffffffc0204114:	bbbd                	j	ffffffffc0203e92 <do_execve+0x14a>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204116:	6785                	lui	a5,0x1
ffffffffc0204118:	417c0533          	sub	a0,s8,s7
ffffffffc020411c:	9bbe                	add	s7,s7,a5
ffffffffc020411e:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc0204122:	017a7463          	bgeu	s4,s7,ffffffffc020412a <do_execve+0x3e2>
                size -= la - end;
ffffffffc0204126:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc020412a:	000db683          	ld	a3,0(s11)
ffffffffc020412e:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc0204132:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc0204134:	40d406b3          	sub	a3,s0,a3
ffffffffc0204138:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc020413a:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc020413e:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc0204140:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204144:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204146:	02b87d63          	bgeu	a6,a1,ffffffffc0204180 <do_execve+0x438>
ffffffffc020414a:	000b3803          	ld	a6,0(s6)
            start += size;
ffffffffc020414e:	9c32                	add	s8,s8,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204150:	4581                	li	a1,0
ffffffffc0204152:	96c2                	add	a3,a3,a6
ffffffffc0204154:	9536                	add	a0,a0,a3
ffffffffc0204156:	700000ef          	jal	ra,ffffffffc0204856 <memset>
        while (start < end) {
ffffffffc020415a:	d34c7ce3          	bgeu	s8,s4,ffffffffc0203e92 <do_execve+0x14a>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc020415e:	6c88                	ld	a0,24(s1)
ffffffffc0204160:	6602                	ld	a2,0(sp)
ffffffffc0204162:	85de                	mv	a1,s7
ffffffffc0204164:	cf8fd0ef          	jal	ra,ffffffffc020165c <pgdir_alloc_page>
ffffffffc0204168:	842a                	mv	s0,a0
ffffffffc020416a:	f555                	bnez	a0,ffffffffc0204116 <do_execve+0x3ce>
ffffffffc020416c:	bdf9                	j	ffffffffc020404a <do_execve+0x302>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc020416e:	418b8b33          	sub	s6,s7,s8
ffffffffc0204172:	bf05                	j	ffffffffc02040a2 <do_execve+0x35a>
        return -E_INVAL;
ffffffffc0204174:	5a75                	li	s4,-3
ffffffffc0204176:	b3c5                	j	ffffffffc0203f56 <do_execve+0x20e>
        while (start < end) {
ffffffffc0204178:	8a62                	mv	s4,s8
ffffffffc020417a:	b729                	j	ffffffffc0204084 <do_execve+0x33c>
            ret = -E_INVAL_ELF;
ffffffffc020417c:	5a61                	li	s4,-8
ffffffffc020417e:	b5f9                	j	ffffffffc020404c <do_execve+0x304>
ffffffffc0204180:	00001617          	auipc	a2,0x1
ffffffffc0204184:	54860613          	addi	a2,a2,1352 # ffffffffc02056c8 <commands+0x7a0>
ffffffffc0204188:	06900593          	li	a1,105
ffffffffc020418c:	00001517          	auipc	a0,0x1
ffffffffc0204190:	49c50513          	addi	a0,a0,1180 # ffffffffc0205628 <commands+0x700>
ffffffffc0204194:	86cfc0ef          	jal	ra,ffffffffc0200200 <__panic>
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0204198:	00001617          	auipc	a2,0x1
ffffffffc020419c:	4f860613          	addi	a2,a2,1272 # ffffffffc0205690 <commands+0x768>
ffffffffc02041a0:	24000593          	li	a1,576
ffffffffc02041a4:	00002517          	auipc	a0,0x2
ffffffffc02041a8:	fa450513          	addi	a0,a0,-92 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02041ac:	854fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc02041b0:	00002697          	auipc	a3,0x2
ffffffffc02041b4:	2b868693          	addi	a3,a3,696 # ffffffffc0206468 <default_pmm_manager+0x410>
ffffffffc02041b8:	00001617          	auipc	a2,0x1
ffffffffc02041bc:	16060613          	addi	a2,a2,352 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02041c0:	23b00593          	li	a1,571
ffffffffc02041c4:	00002517          	auipc	a0,0x2
ffffffffc02041c8:	f8450513          	addi	a0,a0,-124 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02041cc:	834fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc02041d0:	00002697          	auipc	a3,0x2
ffffffffc02041d4:	25068693          	addi	a3,a3,592 # ffffffffc0206420 <default_pmm_manager+0x3c8>
ffffffffc02041d8:	00001617          	auipc	a2,0x1
ffffffffc02041dc:	14060613          	addi	a2,a2,320 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02041e0:	23a00593          	li	a1,570
ffffffffc02041e4:	00002517          	auipc	a0,0x2
ffffffffc02041e8:	f6450513          	addi	a0,a0,-156 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02041ec:	814fc0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc02041f0:	00002697          	auipc	a3,0x2
ffffffffc02041f4:	1e868693          	addi	a3,a3,488 # ffffffffc02063d8 <default_pmm_manager+0x380>
ffffffffc02041f8:	00001617          	auipc	a2,0x1
ffffffffc02041fc:	12060613          	addi	a2,a2,288 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204200:	23900593          	li	a1,569
ffffffffc0204204:	00002517          	auipc	a0,0x2
ffffffffc0204208:	f4450513          	addi	a0,a0,-188 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc020420c:	ff5fb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0204210:	00002697          	auipc	a3,0x2
ffffffffc0204214:	18068693          	addi	a3,a3,384 # ffffffffc0206390 <default_pmm_manager+0x338>
ffffffffc0204218:	00001617          	auipc	a2,0x1
ffffffffc020421c:	10060613          	addi	a2,a2,256 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204220:	23800593          	li	a1,568
ffffffffc0204224:	00002517          	auipc	a0,0x2
ffffffffc0204228:	f2450513          	addi	a0,a0,-220 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc020422c:	fd5fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0204230 <do_yield>:
    current->need_resched = 1;
ffffffffc0204230:	0004f797          	auipc	a5,0x4f
ffffffffc0204234:	2707b783          	ld	a5,624(a5) # ffffffffc02534a0 <current>
ffffffffc0204238:	4705                	li	a4,1
ffffffffc020423a:	ef98                	sd	a4,24(a5)
}
ffffffffc020423c:	4501                	li	a0,0
ffffffffc020423e:	8082                	ret

ffffffffc0204240 <do_wait>:
do_wait(int pid, int *code_store) {
ffffffffc0204240:	1101                	addi	sp,sp,-32
ffffffffc0204242:	e822                	sd	s0,16(sp)
ffffffffc0204244:	e426                	sd	s1,8(sp)
ffffffffc0204246:	ec06                	sd	ra,24(sp)
ffffffffc0204248:	842e                	mv	s0,a1
ffffffffc020424a:	84aa                	mv	s1,a0
    if (code_store != NULL) {
ffffffffc020424c:	c999                	beqz	a1,ffffffffc0204262 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc020424e:	0004f797          	auipc	a5,0x4f
ffffffffc0204252:	2527b783          	ld	a5,594(a5) # ffffffffc02534a0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1)) {
ffffffffc0204256:	7788                	ld	a0,40(a5)
ffffffffc0204258:	4685                	li	a3,1
ffffffffc020425a:	4611                	li	a2,4
ffffffffc020425c:	d0dfd0ef          	jal	ra,ffffffffc0201f68 <user_mem_check>
ffffffffc0204260:	c909                	beqz	a0,ffffffffc0204272 <do_wait+0x32>
ffffffffc0204262:	85a2                	mv	a1,s0
}
ffffffffc0204264:	6442                	ld	s0,16(sp)
ffffffffc0204266:	60e2                	ld	ra,24(sp)
ffffffffc0204268:	8526                	mv	a0,s1
ffffffffc020426a:	64a2                	ld	s1,8(sp)
ffffffffc020426c:	6105                	addi	sp,sp,32
ffffffffc020426e:	821ff06f          	j	ffffffffc0203a8e <do_wait.part.0>
ffffffffc0204272:	60e2                	ld	ra,24(sp)
ffffffffc0204274:	6442                	ld	s0,16(sp)
ffffffffc0204276:	64a2                	ld	s1,8(sp)
ffffffffc0204278:	5575                	li	a0,-3
ffffffffc020427a:	6105                	addi	sp,sp,32
ffffffffc020427c:	8082                	ret

ffffffffc020427e <do_kill>:
do_kill(int pid) {
ffffffffc020427e:	1141                	addi	sp,sp,-16
ffffffffc0204280:	e406                	sd	ra,8(sp)
ffffffffc0204282:	e022                	sd	s0,0(sp)
    if ((proc = find_proc(pid)) != NULL) {
ffffffffc0204284:	a54ff0ef          	jal	ra,ffffffffc02034d8 <find_proc>
ffffffffc0204288:	cd0d                	beqz	a0,ffffffffc02042c2 <do_kill+0x44>
        if (!(proc->flags & PF_EXITING)) {
ffffffffc020428a:	0b052703          	lw	a4,176(a0)
ffffffffc020428e:	00177693          	andi	a3,a4,1
ffffffffc0204292:	e695                	bnez	a3,ffffffffc02042be <do_kill+0x40>
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc0204294:	0ec52683          	lw	a3,236(a0)
            proc->flags |= PF_EXITING;
ffffffffc0204298:	00176713          	ori	a4,a4,1
ffffffffc020429c:	0ae52823          	sw	a4,176(a0)
            return 0;
ffffffffc02042a0:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042a2:	0006c763          	bltz	a3,ffffffffc02042b0 <do_kill+0x32>
}
ffffffffc02042a6:	60a2                	ld	ra,8(sp)
ffffffffc02042a8:	8522                	mv	a0,s0
ffffffffc02042aa:	6402                	ld	s0,0(sp)
ffffffffc02042ac:	0141                	addi	sp,sp,16
ffffffffc02042ae:	8082                	ret
                wakeup_proc(proc);
ffffffffc02042b0:	1e2000ef          	jal	ra,ffffffffc0204492 <wakeup_proc>
}
ffffffffc02042b4:	60a2                	ld	ra,8(sp)
ffffffffc02042b6:	8522                	mv	a0,s0
ffffffffc02042b8:	6402                	ld	s0,0(sp)
ffffffffc02042ba:	0141                	addi	sp,sp,16
ffffffffc02042bc:	8082                	ret
        return -E_KILLED;
ffffffffc02042be:	545d                	li	s0,-9
ffffffffc02042c0:	b7dd                	j	ffffffffc02042a6 <do_kill+0x28>
    return -E_INVAL;
ffffffffc02042c2:	5475                	li	s0,-3
ffffffffc02042c4:	b7cd                	j	ffffffffc02042a6 <do_kill+0x28>

ffffffffc02042c6 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
void
proc_init(void) {
ffffffffc02042c6:	1101                	addi	sp,sp,-32
    elm->prev = elm->next = elm;
ffffffffc02042c8:	0004f797          	auipc	a5,0x4f
ffffffffc02042cc:	32878793          	addi	a5,a5,808 # ffffffffc02535f0 <proc_list>
ffffffffc02042d0:	ec06                	sd	ra,24(sp)
ffffffffc02042d2:	e822                	sd	s0,16(sp)
ffffffffc02042d4:	e426                	sd	s1,8(sp)
ffffffffc02042d6:	e04a                	sd	s2,0(sp)
ffffffffc02042d8:	e79c                	sd	a5,8(a5)
ffffffffc02042da:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
ffffffffc02042dc:	0004f717          	auipc	a4,0x4f
ffffffffc02042e0:	15c70713          	addi	a4,a4,348 # ffffffffc0253438 <__rq>
ffffffffc02042e4:	0004b797          	auipc	a5,0x4b
ffffffffc02042e8:	15478793          	addi	a5,a5,340 # ffffffffc024f438 <hash_list>
ffffffffc02042ec:	e79c                	sd	a5,8(a5)
ffffffffc02042ee:	e39c                	sd	a5,0(a5)
ffffffffc02042f0:	07c1                	addi	a5,a5,16
ffffffffc02042f2:	fef71de3          	bne	a4,a5,ffffffffc02042ec <proc_init+0x26>
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL) {
ffffffffc02042f6:	f49fe0ef          	jal	ra,ffffffffc020323e <alloc_proc>
ffffffffc02042fa:	0004f417          	auipc	s0,0x4f
ffffffffc02042fe:	1ae40413          	addi	s0,s0,430 # ffffffffc02534a8 <idleproc>
ffffffffc0204302:	e008                	sd	a0,0(s0)
ffffffffc0204304:	c541                	beqz	a0,ffffffffc020438c <proc_init+0xc6>
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204306:	4709                	li	a4,2
ffffffffc0204308:	e118                	sd	a4,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
ffffffffc020430a:	4485                	li	s1,1
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc020430c:	00004717          	auipc	a4,0x4
ffffffffc0204310:	cf470713          	addi	a4,a4,-780 # ffffffffc0208000 <bootstack>
    set_proc_name(idleproc, "idle");
ffffffffc0204314:	00002597          	auipc	a1,0x2
ffffffffc0204318:	1b458593          	addi	a1,a1,436 # ffffffffc02064c8 <default_pmm_manager+0x470>
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc020431c:	e918                	sd	a4,16(a0)
    idleproc->need_resched = 1;
ffffffffc020431e:	ed04                	sd	s1,24(a0)
    set_proc_name(idleproc, "idle");
ffffffffc0204320:	922ff0ef          	jal	ra,ffffffffc0203442 <set_proc_name>
    nr_process ++;
ffffffffc0204324:	0004f717          	auipc	a4,0x4f
ffffffffc0204328:	19470713          	addi	a4,a4,404 # ffffffffc02534b8 <nr_process>
ffffffffc020432c:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc020432e:	6014                	ld	a3,0(s0)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204330:	4601                	li	a2,0
    nr_process ++;
ffffffffc0204332:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204334:	4581                	li	a1,0
ffffffffc0204336:	00000517          	auipc	a0,0x0
ffffffffc020433a:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0203c24 <init_main>
    nr_process ++;
ffffffffc020433e:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204340:	0004f797          	auipc	a5,0x4f
ffffffffc0204344:	16d7b023          	sd	a3,352(a5) # ffffffffc02534a0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204348:	dacff0ef          	jal	ra,ffffffffc02038f4 <kernel_thread>
    if (pid <= 0) {
ffffffffc020434c:	08a05c63          	blez	a0,ffffffffc02043e4 <proc_init+0x11e>
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204350:	988ff0ef          	jal	ra,ffffffffc02034d8 <find_proc>
ffffffffc0204354:	0004f917          	auipc	s2,0x4f
ffffffffc0204358:	15c90913          	addi	s2,s2,348 # ffffffffc02534b0 <initproc>
    set_proc_name(initproc, "init");
ffffffffc020435c:	00002597          	auipc	a1,0x2
ffffffffc0204360:	19458593          	addi	a1,a1,404 # ffffffffc02064f0 <default_pmm_manager+0x498>
    initproc = find_proc(pid);
ffffffffc0204364:	00a93023          	sd	a0,0(s2)
    set_proc_name(initproc, "init");
ffffffffc0204368:	8daff0ef          	jal	ra,ffffffffc0203442 <set_proc_name>

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc020436c:	601c                	ld	a5,0(s0)
ffffffffc020436e:	cbb9                	beqz	a5,ffffffffc02043c4 <proc_init+0xfe>
ffffffffc0204370:	43dc                	lw	a5,4(a5)
ffffffffc0204372:	eba9                	bnez	a5,ffffffffc02043c4 <proc_init+0xfe>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204374:	00093783          	ld	a5,0(s2)
ffffffffc0204378:	c795                	beqz	a5,ffffffffc02043a4 <proc_init+0xde>
ffffffffc020437a:	43dc                	lw	a5,4(a5)
ffffffffc020437c:	02979463          	bne	a5,s1,ffffffffc02043a4 <proc_init+0xde>
}
ffffffffc0204380:	60e2                	ld	ra,24(sp)
ffffffffc0204382:	6442                	ld	s0,16(sp)
ffffffffc0204384:	64a2                	ld	s1,8(sp)
ffffffffc0204386:	6902                	ld	s2,0(sp)
ffffffffc0204388:	6105                	addi	sp,sp,32
ffffffffc020438a:	8082                	ret
        panic("cannot alloc idleproc.\n");
ffffffffc020438c:	00002617          	auipc	a2,0x2
ffffffffc0204390:	12460613          	addi	a2,a2,292 # ffffffffc02064b0 <default_pmm_manager+0x458>
ffffffffc0204394:	32f00593          	li	a1,815
ffffffffc0204398:	00002517          	auipc	a0,0x2
ffffffffc020439c:	db050513          	addi	a0,a0,-592 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02043a0:	e61fb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043a4:	00002697          	auipc	a3,0x2
ffffffffc02043a8:	17c68693          	addi	a3,a3,380 # ffffffffc0206520 <default_pmm_manager+0x4c8>
ffffffffc02043ac:	00001617          	auipc	a2,0x1
ffffffffc02043b0:	f6c60613          	addi	a2,a2,-148 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02043b4:	34400593          	li	a1,836
ffffffffc02043b8:	00002517          	auipc	a0,0x2
ffffffffc02043bc:	d9050513          	addi	a0,a0,-624 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02043c0:	e41fb0ef          	jal	ra,ffffffffc0200200 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043c4:	00002697          	auipc	a3,0x2
ffffffffc02043c8:	13468693          	addi	a3,a3,308 # ffffffffc02064f8 <default_pmm_manager+0x4a0>
ffffffffc02043cc:	00001617          	auipc	a2,0x1
ffffffffc02043d0:	f4c60613          	addi	a2,a2,-180 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02043d4:	34300593          	li	a1,835
ffffffffc02043d8:	00002517          	auipc	a0,0x2
ffffffffc02043dc:	d7050513          	addi	a0,a0,-656 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02043e0:	e21fb0ef          	jal	ra,ffffffffc0200200 <__panic>
        panic("create init_main failed.\n");
ffffffffc02043e4:	00002617          	auipc	a2,0x2
ffffffffc02043e8:	0ec60613          	addi	a2,a2,236 # ffffffffc02064d0 <default_pmm_manager+0x478>
ffffffffc02043ec:	33d00593          	li	a1,829
ffffffffc02043f0:	00002517          	auipc	a0,0x2
ffffffffc02043f4:	d5850513          	addi	a0,a0,-680 # ffffffffc0206148 <default_pmm_manager+0xf0>
ffffffffc02043f8:	e09fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02043fc <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
ffffffffc02043fc:	1141                	addi	sp,sp,-16
ffffffffc02043fe:	e022                	sd	s0,0(sp)
ffffffffc0204400:	e406                	sd	ra,8(sp)
ffffffffc0204402:	0004f417          	auipc	s0,0x4f
ffffffffc0204406:	09e40413          	addi	s0,s0,158 # ffffffffc02534a0 <current>
    while (1) {
        if (current->need_resched) {
ffffffffc020440a:	6018                	ld	a4,0(s0)
ffffffffc020440c:	6f1c                	ld	a5,24(a4)
ffffffffc020440e:	dffd                	beqz	a5,ffffffffc020440c <cpu_idle+0x10>
            schedule();
ffffffffc0204410:	134000ef          	jal	ra,ffffffffc0204544 <schedule>
ffffffffc0204414:	bfdd                	j	ffffffffc020440a <cpu_idle+0xe>

ffffffffc0204416 <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void
sched_class_proc_tick(struct proc_struct *proc) {
    if (proc != idleproc) {
ffffffffc0204416:	0004f797          	auipc	a5,0x4f
ffffffffc020441a:	0927b783          	ld	a5,146(a5) # ffffffffc02534a8 <idleproc>
sched_class_proc_tick(struct proc_struct *proc) {
ffffffffc020441e:	85aa                	mv	a1,a0
    if (proc != idleproc) {
ffffffffc0204420:	00a78d63          	beq	a5,a0,ffffffffc020443a <sched_class_proc_tick+0x24>
        sched_class->proc_tick(rq, proc);
ffffffffc0204424:	0004f797          	auipc	a5,0x4f
ffffffffc0204428:	0a47b783          	ld	a5,164(a5) # ffffffffc02534c8 <sched_class>
ffffffffc020442c:	0287b303          	ld	t1,40(a5)
ffffffffc0204430:	0004f517          	auipc	a0,0x4f
ffffffffc0204434:	09053503          	ld	a0,144(a0) # ffffffffc02534c0 <rq>
ffffffffc0204438:	8302                	jr	t1
    }
    else {
        proc->need_resched = 1;
ffffffffc020443a:	4705                	li	a4,1
ffffffffc020443c:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc020443e:	8082                	ret

ffffffffc0204440 <sched_init>:

static struct run_queue __rq;

void
sched_init(void) {
ffffffffc0204440:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc0204442:	00044717          	auipc	a4,0x44
ffffffffc0204446:	bb670713          	addi	a4,a4,-1098 # ffffffffc0247ff8 <default_sched_class>
sched_init(void) {
ffffffffc020444a:	e022                	sd	s0,0(sp)
ffffffffc020444c:	e406                	sd	ra,8(sp)
ffffffffc020444e:	0004f797          	auipc	a5,0x4f
ffffffffc0204452:	00a78793          	addi	a5,a5,10 # ffffffffc0253458 <timer_list>
    //sched_class = &stride_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0204456:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc0204458:	0004f517          	auipc	a0,0x4f
ffffffffc020445c:	fe050513          	addi	a0,a0,-32 # ffffffffc0253438 <__rq>
ffffffffc0204460:	e79c                	sd	a5,8(a5)
ffffffffc0204462:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc0204464:	4795                	li	a5,5
ffffffffc0204466:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc0204468:	0004f417          	auipc	s0,0x4f
ffffffffc020446c:	06040413          	addi	s0,s0,96 # ffffffffc02534c8 <sched_class>
    rq = &__rq;
ffffffffc0204470:	0004f797          	auipc	a5,0x4f
ffffffffc0204474:	04a7b823          	sd	a0,80(a5) # ffffffffc02534c0 <rq>
    sched_class = &default_sched_class;
ffffffffc0204478:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc020447a:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020447c:	601c                	ld	a5,0(s0)
}
ffffffffc020447e:	6402                	ld	s0,0(sp)
ffffffffc0204480:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0204482:	638c                	ld	a1,0(a5)
ffffffffc0204484:	00002517          	auipc	a0,0x2
ffffffffc0204488:	0c450513          	addi	a0,a0,196 # ffffffffc0206548 <default_pmm_manager+0x4f0>
}
ffffffffc020448c:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020448e:	c37fb06f          	j	ffffffffc02000c4 <cprintf>

ffffffffc0204492 <wakeup_proc>:

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204492:	4118                	lw	a4,0(a0)
wakeup_proc(struct proc_struct *proc) {
ffffffffc0204494:	1101                	addi	sp,sp,-32
ffffffffc0204496:	ec06                	sd	ra,24(sp)
ffffffffc0204498:	e822                	sd	s0,16(sp)
ffffffffc020449a:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020449c:	478d                	li	a5,3
ffffffffc020449e:	08f70363          	beq	a4,a5,ffffffffc0204524 <wakeup_proc+0x92>
ffffffffc02044a2:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044a4:	100027f3          	csrr	a5,sstatus
ffffffffc02044a8:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044aa:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044ac:	e7bd                	bnez	a5,ffffffffc020451a <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE) {
ffffffffc02044ae:	4789                	li	a5,2
ffffffffc02044b0:	04f70863          	beq	a4,a5,ffffffffc0204500 <wakeup_proc+0x6e>
            proc->state = PROC_RUNNABLE;
ffffffffc02044b4:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc02044b6:	0e042623          	sw	zero,236(s0)
            if (proc != current) {
ffffffffc02044ba:	0004f797          	auipc	a5,0x4f
ffffffffc02044be:	fe67b783          	ld	a5,-26(a5) # ffffffffc02534a0 <current>
ffffffffc02044c2:	02878363          	beq	a5,s0,ffffffffc02044e8 <wakeup_proc+0x56>
    if (proc != idleproc) {
ffffffffc02044c6:	0004f797          	auipc	a5,0x4f
ffffffffc02044ca:	fe27b783          	ld	a5,-30(a5) # ffffffffc02534a8 <idleproc>
ffffffffc02044ce:	00f40d63          	beq	s0,a5,ffffffffc02044e8 <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc02044d2:	0004f797          	auipc	a5,0x4f
ffffffffc02044d6:	ff67b783          	ld	a5,-10(a5) # ffffffffc02534c8 <sched_class>
ffffffffc02044da:	6b9c                	ld	a5,16(a5)
ffffffffc02044dc:	85a2                	mv	a1,s0
ffffffffc02044de:	0004f517          	auipc	a0,0x4f
ffffffffc02044e2:	fe253503          	ld	a0,-30(a0) # ffffffffc02534c0 <rq>
ffffffffc02044e6:	9782                	jalr	a5
    if (flag) {
ffffffffc02044e8:	e491                	bnez	s1,ffffffffc02044f4 <wakeup_proc+0x62>
        else {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02044ea:	60e2                	ld	ra,24(sp)
ffffffffc02044ec:	6442                	ld	s0,16(sp)
ffffffffc02044ee:	64a2                	ld	s1,8(sp)
ffffffffc02044f0:	6105                	addi	sp,sp,32
ffffffffc02044f2:	8082                	ret
ffffffffc02044f4:	6442                	ld	s0,16(sp)
ffffffffc02044f6:	60e2                	ld	ra,24(sp)
ffffffffc02044f8:	64a2                	ld	s1,8(sp)
ffffffffc02044fa:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02044fc:	8fcfc06f          	j	ffffffffc02005f8 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0204500:	00002617          	auipc	a2,0x2
ffffffffc0204504:	09860613          	addi	a2,a2,152 # ffffffffc0206598 <default_pmm_manager+0x540>
ffffffffc0204508:	04900593          	li	a1,73
ffffffffc020450c:	00002517          	auipc	a0,0x2
ffffffffc0204510:	07450513          	addi	a0,a0,116 # ffffffffc0206580 <default_pmm_manager+0x528>
ffffffffc0204514:	d55fb0ef          	jal	ra,ffffffffc0200268 <__warn>
ffffffffc0204518:	bfc1                	j	ffffffffc02044e8 <wakeup_proc+0x56>
        intr_disable();
ffffffffc020451a:	8e4fc0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc020451e:	4018                	lw	a4,0(s0)
ffffffffc0204520:	4485                	li	s1,1
ffffffffc0204522:	b771                	j	ffffffffc02044ae <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204524:	00002697          	auipc	a3,0x2
ffffffffc0204528:	03c68693          	addi	a3,a3,60 # ffffffffc0206560 <default_pmm_manager+0x508>
ffffffffc020452c:	00001617          	auipc	a2,0x1
ffffffffc0204530:	dec60613          	addi	a2,a2,-532 # ffffffffc0205318 <commands+0x3f0>
ffffffffc0204534:	03d00593          	li	a1,61
ffffffffc0204538:	00002517          	auipc	a0,0x2
ffffffffc020453c:	04850513          	addi	a0,a0,72 # ffffffffc0206580 <default_pmm_manager+0x528>
ffffffffc0204540:	cc1fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc0204544 <schedule>:

void
schedule(void) {
ffffffffc0204544:	7179                	addi	sp,sp,-48
ffffffffc0204546:	f406                	sd	ra,40(sp)
ffffffffc0204548:	f022                	sd	s0,32(sp)
ffffffffc020454a:	ec26                	sd	s1,24(sp)
ffffffffc020454c:	e84a                	sd	s2,16(sp)
ffffffffc020454e:	e44e                	sd	s3,8(sp)
ffffffffc0204550:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0204552:	100027f3          	csrr	a5,sstatus
ffffffffc0204556:	8b89                	andi	a5,a5,2
ffffffffc0204558:	4a01                	li	s4,0
ffffffffc020455a:	ebdd                	bnez	a5,ffffffffc0204610 <schedule+0xcc>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc020455c:	0004f497          	auipc	s1,0x4f
ffffffffc0204560:	f4448493          	addi	s1,s1,-188 # ffffffffc02534a0 <current>
ffffffffc0204564:	608c                	ld	a1,0(s1)
ffffffffc0204566:	0004f997          	auipc	s3,0x4f
ffffffffc020456a:	f6298993          	addi	s3,s3,-158 # ffffffffc02534c8 <sched_class>
ffffffffc020456e:	0004f917          	auipc	s2,0x4f
ffffffffc0204572:	f5290913          	addi	s2,s2,-174 # ffffffffc02534c0 <rq>
        if (current->state == PROC_RUNNABLE) {
ffffffffc0204576:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc0204578:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE) {
ffffffffc020457c:	4709                	li	a4,2
ffffffffc020457e:	0009b783          	ld	a5,0(s3)
ffffffffc0204582:	00093503          	ld	a0,0(s2)
ffffffffc0204586:	04e68763          	beq	a3,a4,ffffffffc02045d4 <schedule+0x90>
    return sched_class->pick_next(rq);
ffffffffc020458a:	739c                	ld	a5,32(a5)
ffffffffc020458c:	9782                	jalr	a5
ffffffffc020458e:	842a                	mv	s0,a0
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc0204590:	c135                	beqz	a0,ffffffffc02045f4 <schedule+0xb0>
    sched_class->dequeue(rq, proc);
ffffffffc0204592:	0009b783          	ld	a5,0(s3)
ffffffffc0204596:	00093503          	ld	a0,0(s2)
ffffffffc020459a:	85a2                	mv	a1,s0
ffffffffc020459c:	6f9c                	ld	a5,24(a5)
ffffffffc020459e:	9782                	jalr	a5
            sched_class_dequeue(next);
        }
        if (next == NULL) {
            next = idleproc;
        }
        next->runs ++;
ffffffffc02045a0:	441c                	lw	a5,8(s0)
        if (next != current) {
ffffffffc02045a2:	6098                	ld	a4,0(s1)
        next->runs ++;
ffffffffc02045a4:	2785                	addiw	a5,a5,1
ffffffffc02045a6:	c41c                	sw	a5,8(s0)
        if (next != current) {
ffffffffc02045a8:	00870c63          	beq	a4,s0,ffffffffc02045c0 <schedule+0x7c>
            cprintf("The next proc is pid:%d\n",next->pid);
ffffffffc02045ac:	404c                	lw	a1,4(s0)
ffffffffc02045ae:	00002517          	auipc	a0,0x2
ffffffffc02045b2:	00a50513          	addi	a0,a0,10 # ffffffffc02065b8 <default_pmm_manager+0x560>
ffffffffc02045b6:	b0ffb0ef          	jal	ra,ffffffffc02000c4 <cprintf>
            proc_run(next);
ffffffffc02045ba:	8522                	mv	a0,s0
ffffffffc02045bc:	eb1fe0ef          	jal	ra,ffffffffc020346c <proc_run>
    if (flag) {
ffffffffc02045c0:	020a1f63          	bnez	s4,ffffffffc02045fe <schedule+0xba>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02045c4:	70a2                	ld	ra,40(sp)
ffffffffc02045c6:	7402                	ld	s0,32(sp)
ffffffffc02045c8:	64e2                	ld	s1,24(sp)
ffffffffc02045ca:	6942                	ld	s2,16(sp)
ffffffffc02045cc:	69a2                	ld	s3,8(sp)
ffffffffc02045ce:	6a02                	ld	s4,0(sp)
ffffffffc02045d0:	6145                	addi	sp,sp,48
ffffffffc02045d2:	8082                	ret
    if (proc != idleproc) {
ffffffffc02045d4:	0004f717          	auipc	a4,0x4f
ffffffffc02045d8:	ed473703          	ld	a4,-300(a4) # ffffffffc02534a8 <idleproc>
ffffffffc02045dc:	fae587e3          	beq	a1,a4,ffffffffc020458a <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc02045e0:	6b9c                	ld	a5,16(a5)
ffffffffc02045e2:	9782                	jalr	a5
ffffffffc02045e4:	0009b783          	ld	a5,0(s3)
ffffffffc02045e8:	00093503          	ld	a0,0(s2)
    return sched_class->pick_next(rq);
ffffffffc02045ec:	739c                	ld	a5,32(a5)
ffffffffc02045ee:	9782                	jalr	a5
ffffffffc02045f0:	842a                	mv	s0,a0
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc02045f2:	f145                	bnez	a0,ffffffffc0204592 <schedule+0x4e>
            next = idleproc;
ffffffffc02045f4:	0004f417          	auipc	s0,0x4f
ffffffffc02045f8:	eb443403          	ld	s0,-332(s0) # ffffffffc02534a8 <idleproc>
ffffffffc02045fc:	b755                	j	ffffffffc02045a0 <schedule+0x5c>
}
ffffffffc02045fe:	7402                	ld	s0,32(sp)
ffffffffc0204600:	70a2                	ld	ra,40(sp)
ffffffffc0204602:	64e2                	ld	s1,24(sp)
ffffffffc0204604:	6942                	ld	s2,16(sp)
ffffffffc0204606:	69a2                	ld	s3,8(sp)
ffffffffc0204608:	6a02                	ld	s4,0(sp)
ffffffffc020460a:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc020460c:	fedfb06f          	j	ffffffffc02005f8 <intr_enable>
        intr_disable();
ffffffffc0204610:	feffb0ef          	jal	ra,ffffffffc02005fe <intr_disable>
        return 1;
ffffffffc0204614:	4a05                	li	s4,1
ffffffffc0204616:	b799                	j	ffffffffc020455c <schedule+0x18>

ffffffffc0204618 <RR_init>:
ffffffffc0204618:	e508                	sd	a0,8(a0)
ffffffffc020461a:	e108                	sd	a0,0(a0)
#include <default_sched.h>

static void
RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc020461c:	00052823          	sw	zero,16(a0)
}
ffffffffc0204620:	8082                	ret

ffffffffc0204622 <RR_enqueue>:
    __list_add(elm, listelm->prev, listelm);
ffffffffc0204622:	611c                	ld	a5,0(a0)

static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {


    list_add_before(&(rq->run_list), &(proc->run_link));
ffffffffc0204624:	11058713          	addi	a4,a1,272
    prev->next = next->prev = elm;
ffffffffc0204628:	e118                	sd	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc020462a:	1205a683          	lw	a3,288(a1)
ffffffffc020462e:	e798                	sd	a4,8(a5)
    elm->prev = prev;
ffffffffc0204630:	10f5b823          	sd	a5,272(a1)
    elm->next = next;
ffffffffc0204634:	10a5bc23          	sd	a0,280(a1)
ffffffffc0204638:	495c                	lw	a5,20(a0)
ffffffffc020463a:	c299                	beqz	a3,ffffffffc0204640 <RR_enqueue+0x1e>
ffffffffc020463c:	00d7d463          	bge	a5,a3,ffffffffc0204644 <RR_enqueue+0x22>
        proc->time_slice = rq->max_time_slice;
ffffffffc0204640:	12f5a023          	sw	a5,288(a1)
    }
    proc->rq = rq;
    rq->proc_num ++;
ffffffffc0204644:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0204646:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc020464a:	2785                	addiw	a5,a5,1
ffffffffc020464c:	c91c                	sw	a5,16(a0)
}
ffffffffc020464e:	8082                	ret

ffffffffc0204650 <RR_pick_next>:
    return listelm->next;
ffffffffc0204650:	6510                	ld	a2,8(a0)
RR_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));
    
    list_entry_t * res = le;
    int current_max = 0;
    while (le != &(rq->run_list)) {
ffffffffc0204652:	02a60163          	beq	a2,a0,ffffffffc0204674 <RR_pick_next+0x24>
ffffffffc0204656:	87b2                	mv	a5,a2
    int current_max = 0;
ffffffffc0204658:	4681                	li	a3,0
    	int tmp = le2proc(le, run_link) -> labschedule_good;
ffffffffc020465a:	4f98                	lw	a4,24(a5)
    	if (tmp > current_max){
ffffffffc020465c:	00e6d463          	bge	a3,a4,ffffffffc0204664 <RR_pick_next+0x14>
ffffffffc0204660:	863e                	mv	a2,a5
ffffffffc0204662:	86ba                	mv	a3,a4
ffffffffc0204664:	679c                	ld	a5,8(a5)
    while (le != &(rq->run_list)) {
ffffffffc0204666:	fea79ae3          	bne	a5,a0,ffffffffc020465a <RR_pick_next+0xa>
            current_max = tmp;
            res = le;  	
    	}
        le = list_next(le);
    }
    if (res != &(rq->run_list)) {
ffffffffc020466a:	00f60563          	beq	a2,a5,ffffffffc0204674 <RR_pick_next+0x24>
        return le2proc(res, run_link);
ffffffffc020466e:	ef060513          	addi	a0,a2,-272
ffffffffc0204672:	8082                	ret
    }
    return NULL;
ffffffffc0204674:	4501                	li	a0,0
}
ffffffffc0204676:	8082                	ret

ffffffffc0204678 <RR_proc_tick>:

static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
ffffffffc0204678:	1205a783          	lw	a5,288(a1)
ffffffffc020467c:	00f05563          	blez	a5,ffffffffc0204686 <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc0204680:	37fd                	addiw	a5,a5,-1
ffffffffc0204682:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc0204686:	e399                	bnez	a5,ffffffffc020468c <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc0204688:	4785                	li	a5,1
ffffffffc020468a:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc020468c:	8082                	ret

ffffffffc020468e <RR_dequeue>:
    return list->next == list;
ffffffffc020468e:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0204692:	11058793          	addi	a5,a1,272
ffffffffc0204696:	02e78363          	beq	a5,a4,ffffffffc02046bc <RR_dequeue+0x2e>
ffffffffc020469a:	1085b683          	ld	a3,264(a1)
ffffffffc020469e:	00a69f63          	bne	a3,a0,ffffffffc02046bc <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc02046a2:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc02046a6:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc02046a8:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02046aa:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc02046ac:	10f5bc23          	sd	a5,280(a1)
ffffffffc02046b0:	10f5b823          	sd	a5,272(a1)
ffffffffc02046b4:	fff6079b          	addiw	a5,a2,-1
ffffffffc02046b8:	ca9c                	sw	a5,16(a3)
ffffffffc02046ba:	8082                	ret
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046bc:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046be:	00002697          	auipc	a3,0x2
ffffffffc02046c2:	f1a68693          	addi	a3,a3,-230 # ffffffffc02065d8 <default_pmm_manager+0x580>
ffffffffc02046c6:	00001617          	auipc	a2,0x1
ffffffffc02046ca:	c5260613          	addi	a2,a2,-942 # ffffffffc0205318 <commands+0x3f0>
ffffffffc02046ce:	45ed                	li	a1,27
ffffffffc02046d0:	00002517          	auipc	a0,0x2
ffffffffc02046d4:	f4050513          	addi	a0,a0,-192 # ffffffffc0206610 <default_pmm_manager+0x5b8>
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046d8:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046da:	b27fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02046de <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc02046de:	0004f797          	auipc	a5,0x4f
ffffffffc02046e2:	dc27b783          	ld	a5,-574(a5) # ffffffffc02534a0 <current>
}
ffffffffc02046e6:	43c8                	lw	a0,4(a5)
ffffffffc02046e8:	8082                	ret

ffffffffc02046ea <sys_gettime>:
    cputchar(c);
    return 0;
}

static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc02046ea:	0004f797          	auipc	a5,0x4f
ffffffffc02046ee:	de67b783          	ld	a5,-538(a5) # ffffffffc02534d0 <ticks>
ffffffffc02046f2:	0027951b          	slliw	a0,a5,0x2
ffffffffc02046f6:	9d3d                	addw	a0,a0,a5
}
ffffffffc02046f8:	0015151b          	slliw	a0,a0,0x1
ffffffffc02046fc:	8082                	ret

ffffffffc02046fe <sys_setgood>:

static int sys_setgood(uint64_t arg[]){
    current -> labschedule_good = arg[0];
ffffffffc02046fe:	6118                	ld	a4,0(a0)
static int sys_setgood(uint64_t arg[]){
ffffffffc0204700:	1141                	addi	sp,sp,-16
ffffffffc0204702:	e022                	sd	s0,0(sp)
ffffffffc0204704:	e406                	sd	ra,8(sp)
    current -> labschedule_good = arg[0];
ffffffffc0204706:	0004f797          	auipc	a5,0x4f
ffffffffc020470a:	d9a7b783          	ld	a5,-614(a5) # ffffffffc02534a0 <current>
ffffffffc020470e:	12e7a423          	sw	a4,296(a5)
static int sys_setgood(uint64_t arg[]){
ffffffffc0204712:	842a                	mv	s0,a0
    schedule();
ffffffffc0204714:	e31ff0ef          	jal	ra,ffffffffc0204544 <schedule>
    return arg[0];
}
ffffffffc0204718:	4008                	lw	a0,0(s0)
ffffffffc020471a:	60a2                	ld	ra,8(sp)
ffffffffc020471c:	6402                	ld	s0,0(sp)
ffffffffc020471e:	0141                	addi	sp,sp,16
ffffffffc0204720:	8082                	ret

ffffffffc0204722 <sys_putc>:
    cputchar(c);
ffffffffc0204722:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0204724:	1141                	addi	sp,sp,-16
ffffffffc0204726:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0204728:	9d3fb0ef          	jal	ra,ffffffffc02000fa <cputchar>
}
ffffffffc020472c:	60a2                	ld	ra,8(sp)
ffffffffc020472e:	4501                	li	a0,0
ffffffffc0204730:	0141                	addi	sp,sp,16
ffffffffc0204732:	8082                	ret

ffffffffc0204734 <sys_kill>:
    return do_kill(pid);
ffffffffc0204734:	4108                	lw	a0,0(a0)
ffffffffc0204736:	b49ff06f          	j	ffffffffc020427e <do_kill>

ffffffffc020473a <sys_yield>:
    return do_yield();
ffffffffc020473a:	af7ff06f          	j	ffffffffc0204230 <do_yield>

ffffffffc020473e <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc020473e:	6d14                	ld	a3,24(a0)
ffffffffc0204740:	6910                	ld	a2,16(a0)
ffffffffc0204742:	650c                	ld	a1,8(a0)
ffffffffc0204744:	6108                	ld	a0,0(a0)
ffffffffc0204746:	e02ff06f          	j	ffffffffc0203d48 <do_execve>

ffffffffc020474a <sys_wait>:
    return do_wait(pid, store);
ffffffffc020474a:	650c                	ld	a1,8(a0)
ffffffffc020474c:	4108                	lw	a0,0(a0)
ffffffffc020474e:	af3ff06f          	j	ffffffffc0204240 <do_wait>

ffffffffc0204752 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0204752:	0004f797          	auipc	a5,0x4f
ffffffffc0204756:	d4e7b783          	ld	a5,-690(a5) # ffffffffc02534a0 <current>
ffffffffc020475a:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc020475c:	4501                	li	a0,0
ffffffffc020475e:	6a0c                	ld	a1,16(a2)
ffffffffc0204760:	dd1fe06f          	j	ffffffffc0203530 <do_fork>

ffffffffc0204764 <sys_exit>:
    return do_exit(error_code);
ffffffffc0204764:	4108                	lw	a0,0(a0)
ffffffffc0204766:	9deff06f          	j	ffffffffc0203944 <do_exit>

ffffffffc020476a <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020476a:	715d                	addi	sp,sp,-80
ffffffffc020476c:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc020476e:	0004f497          	auipc	s1,0x4f
ffffffffc0204772:	d3248493          	addi	s1,s1,-718 # ffffffffc02534a0 <current>
ffffffffc0204776:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0204778:	e0a2                	sd	s0,64(sp)
ffffffffc020477a:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc020477c:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc020477e:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204780:	0fe00793          	li	a5,254
    int num = tf->gpr.a0;
ffffffffc0204784:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204788:	0327ee63          	bltu	a5,s2,ffffffffc02047c4 <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc020478c:	00391713          	slli	a4,s2,0x3
ffffffffc0204790:	00002797          	auipc	a5,0x2
ffffffffc0204794:	ef878793          	addi	a5,a5,-264 # ffffffffc0206688 <syscalls>
ffffffffc0204798:	97ba                	add	a5,a5,a4
ffffffffc020479a:	639c                	ld	a5,0(a5)
ffffffffc020479c:	c785                	beqz	a5,ffffffffc02047c4 <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc020479e:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc02047a0:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02047a2:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02047a4:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02047a6:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02047a8:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02047aa:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02047ac:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02047ae:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02047b0:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b2:	0028                	addi	a0,sp,8
ffffffffc02047b4:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02047b6:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b8:	e828                	sd	a0,80(s0)
}
ffffffffc02047ba:	6406                	ld	s0,64(sp)
ffffffffc02047bc:	74e2                	ld	s1,56(sp)
ffffffffc02047be:	7942                	ld	s2,48(sp)
ffffffffc02047c0:	6161                	addi	sp,sp,80
ffffffffc02047c2:	8082                	ret
    print_trapframe(tf);
ffffffffc02047c4:	8522                	mv	a0,s0
ffffffffc02047c6:	826fc0ef          	jal	ra,ffffffffc02007ec <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02047ca:	609c                	ld	a5,0(s1)
ffffffffc02047cc:	86ca                	mv	a3,s2
ffffffffc02047ce:	00002617          	auipc	a2,0x2
ffffffffc02047d2:	e7260613          	addi	a2,a2,-398 # ffffffffc0206640 <default_pmm_manager+0x5e8>
ffffffffc02047d6:	43d8                	lw	a4,4(a5)
ffffffffc02047d8:	06800593          	li	a1,104
ffffffffc02047dc:	0b478793          	addi	a5,a5,180
ffffffffc02047e0:	00002517          	auipc	a0,0x2
ffffffffc02047e4:	e9050513          	addi	a0,a0,-368 # ffffffffc0206670 <default_pmm_manager+0x618>
ffffffffc02047e8:	a19fb0ef          	jal	ra,ffffffffc0200200 <__panic>

ffffffffc02047ec <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02047ec:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02047f0:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02047f2:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02047f4:	cb81                	beqz	a5,ffffffffc0204804 <strlen+0x18>
        cnt ++;
ffffffffc02047f6:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02047f8:	00a707b3          	add	a5,a4,a0
ffffffffc02047fc:	0007c783          	lbu	a5,0(a5)
ffffffffc0204800:	fbfd                	bnez	a5,ffffffffc02047f6 <strlen+0xa>
ffffffffc0204802:	8082                	ret
    }
    return cnt;
}
ffffffffc0204804:	8082                	ret

ffffffffc0204806 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
ffffffffc0204806:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0204808:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020480a:	e589                	bnez	a1,ffffffffc0204814 <strnlen+0xe>
ffffffffc020480c:	a811                	j	ffffffffc0204820 <strnlen+0x1a>
        cnt ++;
ffffffffc020480e:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0204810:	00a58763          	beq	a1,a0,ffffffffc020481e <strnlen+0x18>
ffffffffc0204814:	00a707b3          	add	a5,a4,a0
ffffffffc0204818:	0007c783          	lbu	a5,0(a5)
ffffffffc020481c:	fbed                	bnez	a5,ffffffffc020480e <strnlen+0x8>
    }
    return cnt;
}
ffffffffc020481e:	8082                	ret
ffffffffc0204820:	8082                	ret

ffffffffc0204822 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0204822:	00054783          	lbu	a5,0(a0)
ffffffffc0204826:	0005c703          	lbu	a4,0(a1)
ffffffffc020482a:	cb89                	beqz	a5,ffffffffc020483c <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc020482c:	0505                	addi	a0,a0,1
ffffffffc020482e:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0204830:	fee789e3          	beq	a5,a4,ffffffffc0204822 <strcmp>
ffffffffc0204834:	0007851b          	sext.w	a0,a5
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0204838:	9d19                	subw	a0,a0,a4
ffffffffc020483a:	8082                	ret
ffffffffc020483c:	4501                	li	a0,0
ffffffffc020483e:	bfed                	j	ffffffffc0204838 <strcmp+0x16>

ffffffffc0204840 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0204840:	00054783          	lbu	a5,0(a0)
ffffffffc0204844:	c799                	beqz	a5,ffffffffc0204852 <strchr+0x12>
        if (*s == c) {
ffffffffc0204846:	00f58763          	beq	a1,a5,ffffffffc0204854 <strchr+0x14>
    while (*s != '\0') {
ffffffffc020484a:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020484e:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0204850:	fbfd                	bnez	a5,ffffffffc0204846 <strchr+0x6>
    }
    return NULL;
ffffffffc0204852:	4501                	li	a0,0
}
ffffffffc0204854:	8082                	ret

ffffffffc0204856 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0204856:	ca01                	beqz	a2,ffffffffc0204866 <memset+0x10>
ffffffffc0204858:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020485a:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020485c:	0785                	addi	a5,a5,1
ffffffffc020485e:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0204862:	fec79de3          	bne	a5,a2,ffffffffc020485c <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0204866:	8082                	ret

ffffffffc0204868 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0204868:	ca19                	beqz	a2,ffffffffc020487e <memcpy+0x16>
ffffffffc020486a:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020486c:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc020486e:	0005c703          	lbu	a4,0(a1)
ffffffffc0204872:	0585                	addi	a1,a1,1
ffffffffc0204874:	0785                	addi	a5,a5,1
ffffffffc0204876:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc020487a:	fec59ae3          	bne	a1,a2,ffffffffc020486e <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc020487e:	8082                	ret

ffffffffc0204880 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0204880:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204884:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0204886:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020488a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc020488c:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204890:	f022                	sd	s0,32(sp)
ffffffffc0204892:	ec26                	sd	s1,24(sp)
ffffffffc0204894:	e84a                	sd	s2,16(sp)
ffffffffc0204896:	f406                	sd	ra,40(sp)
ffffffffc0204898:	e44e                	sd	s3,8(sp)
ffffffffc020489a:	84aa                	mv	s1,a0
ffffffffc020489c:	892e                	mv	s2,a1
ffffffffc020489e:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02048a2:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc02048a4:	03067e63          	bgeu	a2,a6,ffffffffc02048e0 <printnum+0x60>
ffffffffc02048a8:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02048aa:	00805763          	blez	s0,ffffffffc02048b8 <printnum+0x38>
ffffffffc02048ae:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02048b0:	85ca                	mv	a1,s2
ffffffffc02048b2:	854e                	mv	a0,s3
ffffffffc02048b4:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02048b6:	fc65                	bnez	s0,ffffffffc02048ae <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048b8:	1a02                	slli	s4,s4,0x20
ffffffffc02048ba:	020a5a13          	srli	s4,s4,0x20
ffffffffc02048be:	00002797          	auipc	a5,0x2
ffffffffc02048c2:	5c278793          	addi	a5,a5,1474 # ffffffffc0206e80 <syscalls+0x7f8>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02048c6:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048c8:	9a3e                	add	s4,s4,a5
ffffffffc02048ca:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02048ce:	70a2                	ld	ra,40(sp)
ffffffffc02048d0:	69a2                	ld	s3,8(sp)
ffffffffc02048d2:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048d4:	85ca                	mv	a1,s2
ffffffffc02048d6:	8326                	mv	t1,s1
}
ffffffffc02048d8:	6942                	ld	s2,16(sp)
ffffffffc02048da:	64e2                	ld	s1,24(sp)
ffffffffc02048dc:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048de:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02048e0:	03065633          	divu	a2,a2,a6
ffffffffc02048e4:	8722                	mv	a4,s0
ffffffffc02048e6:	f9bff0ef          	jal	ra,ffffffffc0204880 <printnum>
ffffffffc02048ea:	b7f9                	j	ffffffffc02048b8 <printnum+0x38>

ffffffffc02048ec <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02048ec:	7119                	addi	sp,sp,-128
ffffffffc02048ee:	f4a6                	sd	s1,104(sp)
ffffffffc02048f0:	f0ca                	sd	s2,96(sp)
ffffffffc02048f2:	ecce                	sd	s3,88(sp)
ffffffffc02048f4:	e8d2                	sd	s4,80(sp)
ffffffffc02048f6:	e4d6                	sd	s5,72(sp)
ffffffffc02048f8:	e0da                	sd	s6,64(sp)
ffffffffc02048fa:	fc5e                	sd	s7,56(sp)
ffffffffc02048fc:	f06a                	sd	s10,32(sp)
ffffffffc02048fe:	fc86                	sd	ra,120(sp)
ffffffffc0204900:	f8a2                	sd	s0,112(sp)
ffffffffc0204902:	f862                	sd	s8,48(sp)
ffffffffc0204904:	f466                	sd	s9,40(sp)
ffffffffc0204906:	ec6e                	sd	s11,24(sp)
ffffffffc0204908:	892a                	mv	s2,a0
ffffffffc020490a:	84ae                	mv	s1,a1
ffffffffc020490c:	8d32                	mv	s10,a2
ffffffffc020490e:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204910:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0204914:	5b7d                	li	s6,-1
ffffffffc0204916:	00002a97          	auipc	s5,0x2
ffffffffc020491a:	596a8a93          	addi	s5,s5,1430 # ffffffffc0206eac <syscalls+0x824>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020491e:	00002b97          	auipc	s7,0x2
ffffffffc0204922:	7aab8b93          	addi	s7,s7,1962 # ffffffffc02070c8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204926:	000d4503          	lbu	a0,0(s10)
ffffffffc020492a:	001d0413          	addi	s0,s10,1
ffffffffc020492e:	01350a63          	beq	a0,s3,ffffffffc0204942 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0204932:	c121                	beqz	a0,ffffffffc0204972 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0204934:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204936:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0204938:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020493a:	fff44503          	lbu	a0,-1(s0)
ffffffffc020493e:	ff351ae3          	bne	a0,s3,ffffffffc0204932 <vprintfmt+0x46>
ffffffffc0204942:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0204946:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc020494a:	4c81                	li	s9,0
ffffffffc020494c:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020494e:	5c7d                	li	s8,-1
ffffffffc0204950:	5dfd                	li	s11,-1
ffffffffc0204952:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0204956:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204958:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020495c:	0ff5f593          	andi	a1,a1,255
ffffffffc0204960:	00140d13          	addi	s10,s0,1
ffffffffc0204964:	04b56263          	bltu	a0,a1,ffffffffc02049a8 <vprintfmt+0xbc>
ffffffffc0204968:	058a                	slli	a1,a1,0x2
ffffffffc020496a:	95d6                	add	a1,a1,s5
ffffffffc020496c:	4194                	lw	a3,0(a1)
ffffffffc020496e:	96d6                	add	a3,a3,s5
ffffffffc0204970:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0204972:	70e6                	ld	ra,120(sp)
ffffffffc0204974:	7446                	ld	s0,112(sp)
ffffffffc0204976:	74a6                	ld	s1,104(sp)
ffffffffc0204978:	7906                	ld	s2,96(sp)
ffffffffc020497a:	69e6                	ld	s3,88(sp)
ffffffffc020497c:	6a46                	ld	s4,80(sp)
ffffffffc020497e:	6aa6                	ld	s5,72(sp)
ffffffffc0204980:	6b06                	ld	s6,64(sp)
ffffffffc0204982:	7be2                	ld	s7,56(sp)
ffffffffc0204984:	7c42                	ld	s8,48(sp)
ffffffffc0204986:	7ca2                	ld	s9,40(sp)
ffffffffc0204988:	7d02                	ld	s10,32(sp)
ffffffffc020498a:	6de2                	ld	s11,24(sp)
ffffffffc020498c:	6109                	addi	sp,sp,128
ffffffffc020498e:	8082                	ret
            padc = '0';
ffffffffc0204990:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0204992:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204996:	846a                	mv	s0,s10
ffffffffc0204998:	00140d13          	addi	s10,s0,1
ffffffffc020499c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02049a0:	0ff5f593          	andi	a1,a1,255
ffffffffc02049a4:	fcb572e3          	bgeu	a0,a1,ffffffffc0204968 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02049a8:	85a6                	mv	a1,s1
ffffffffc02049aa:	02500513          	li	a0,37
ffffffffc02049ae:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02049b0:	fff44783          	lbu	a5,-1(s0)
ffffffffc02049b4:	8d22                	mv	s10,s0
ffffffffc02049b6:	f73788e3          	beq	a5,s3,ffffffffc0204926 <vprintfmt+0x3a>
ffffffffc02049ba:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02049be:	1d7d                	addi	s10,s10,-1
ffffffffc02049c0:	ff379de3          	bne	a5,s3,ffffffffc02049ba <vprintfmt+0xce>
ffffffffc02049c4:	b78d                	j	ffffffffc0204926 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02049c6:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02049ca:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049ce:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02049d0:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02049d4:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049d8:	02d86463          	bltu	a6,a3,ffffffffc0204a00 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02049dc:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02049e0:	002c169b          	slliw	a3,s8,0x2
ffffffffc02049e4:	0186873b          	addw	a4,a3,s8
ffffffffc02049e8:	0017171b          	slliw	a4,a4,0x1
ffffffffc02049ec:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02049ee:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02049f2:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02049f4:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02049f8:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049fc:	fed870e3          	bgeu	a6,a3,ffffffffc02049dc <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0204a00:	f40ddce3          	bgez	s11,ffffffffc0204958 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0204a04:	8de2                	mv	s11,s8
ffffffffc0204a06:	5c7d                	li	s8,-1
ffffffffc0204a08:	bf81                	j	ffffffffc0204958 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0204a0a:	fffdc693          	not	a3,s11
ffffffffc0204a0e:	96fd                	srai	a3,a3,0x3f
ffffffffc0204a10:	00ddfdb3          	and	s11,s11,a3
ffffffffc0204a14:	00144603          	lbu	a2,1(s0)
ffffffffc0204a18:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a1a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a1c:	bf35                	j	ffffffffc0204958 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0204a1e:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
ffffffffc0204a22:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0204a26:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a28:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0204a2a:	bfd9                	j	ffffffffc0204a00 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0204a2c:	4705                	li	a4,1
ffffffffc0204a2e:	008a0593          	addi	a1,s4,8
ffffffffc0204a32:	01174463          	blt	a4,a7,ffffffffc0204a3a <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0204a36:	1a088e63          	beqz	a7,ffffffffc0204bf2 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0204a3a:	000a3603          	ld	a2,0(s4)
ffffffffc0204a3e:	46c1                	li	a3,16
ffffffffc0204a40:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0204a42:	2781                	sext.w	a5,a5
ffffffffc0204a44:	876e                	mv	a4,s11
ffffffffc0204a46:	85a6                	mv	a1,s1
ffffffffc0204a48:	854a                	mv	a0,s2
ffffffffc0204a4a:	e37ff0ef          	jal	ra,ffffffffc0204880 <printnum>
            break;
ffffffffc0204a4e:	bde1                	j	ffffffffc0204926 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0204a50:	000a2503          	lw	a0,0(s4)
ffffffffc0204a54:	85a6                	mv	a1,s1
ffffffffc0204a56:	0a21                	addi	s4,s4,8
ffffffffc0204a58:	9902                	jalr	s2
            break;
ffffffffc0204a5a:	b5f1                	j	ffffffffc0204926 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204a5c:	4705                	li	a4,1
ffffffffc0204a5e:	008a0593          	addi	a1,s4,8
ffffffffc0204a62:	01174463          	blt	a4,a7,ffffffffc0204a6a <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0204a66:	18088163          	beqz	a7,ffffffffc0204be8 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0204a6a:	000a3603          	ld	a2,0(s4)
ffffffffc0204a6e:	46a9                	li	a3,10
ffffffffc0204a70:	8a2e                	mv	s4,a1
ffffffffc0204a72:	bfc1                	j	ffffffffc0204a42 <vprintfmt+0x156>
            goto reswitch;
ffffffffc0204a74:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0204a78:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a7a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a7c:	bdf1                	j	ffffffffc0204958 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0204a7e:	85a6                	mv	a1,s1
ffffffffc0204a80:	02500513          	li	a0,37
ffffffffc0204a84:	9902                	jalr	s2
            break;
ffffffffc0204a86:	b545                	j	ffffffffc0204926 <vprintfmt+0x3a>
            lflag ++;
ffffffffc0204a88:	00144603          	lbu	a2,1(s0)
ffffffffc0204a8c:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a8e:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a90:	b5e1                	j	ffffffffc0204958 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0204a92:	4705                	li	a4,1
ffffffffc0204a94:	008a0593          	addi	a1,s4,8
ffffffffc0204a98:	01174463          	blt	a4,a7,ffffffffc0204aa0 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0204a9c:	14088163          	beqz	a7,ffffffffc0204bde <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0204aa0:	000a3603          	ld	a2,0(s4)
ffffffffc0204aa4:	46a1                	li	a3,8
ffffffffc0204aa6:	8a2e                	mv	s4,a1
ffffffffc0204aa8:	bf69                	j	ffffffffc0204a42 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0204aaa:	03000513          	li	a0,48
ffffffffc0204aae:	85a6                	mv	a1,s1
ffffffffc0204ab0:	e03e                	sd	a5,0(sp)
ffffffffc0204ab2:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0204ab4:	85a6                	mv	a1,s1
ffffffffc0204ab6:	07800513          	li	a0,120
ffffffffc0204aba:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204abc:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0204abe:	6782                	ld	a5,0(sp)
ffffffffc0204ac0:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204ac2:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0204ac6:	bfb5                	j	ffffffffc0204a42 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204ac8:	000a3403          	ld	s0,0(s4)
ffffffffc0204acc:	008a0713          	addi	a4,s4,8
ffffffffc0204ad0:	e03a                	sd	a4,0(sp)
ffffffffc0204ad2:	14040263          	beqz	s0,ffffffffc0204c16 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0204ad6:	0fb05763          	blez	s11,ffffffffc0204bc4 <vprintfmt+0x2d8>
ffffffffc0204ada:	02d00693          	li	a3,45
ffffffffc0204ade:	0cd79163          	bne	a5,a3,ffffffffc0204ba0 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204ae2:	00044783          	lbu	a5,0(s0)
ffffffffc0204ae6:	0007851b          	sext.w	a0,a5
ffffffffc0204aea:	cf85                	beqz	a5,ffffffffc0204b22 <vprintfmt+0x236>
ffffffffc0204aec:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204af0:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204af4:	000c4563          	bltz	s8,ffffffffc0204afe <vprintfmt+0x212>
ffffffffc0204af8:	3c7d                	addiw	s8,s8,-1
ffffffffc0204afa:	036c0263          	beq	s8,s6,ffffffffc0204b1e <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0204afe:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204b00:	0e0c8e63          	beqz	s9,ffffffffc0204bfc <vprintfmt+0x310>
ffffffffc0204b04:	3781                	addiw	a5,a5,-32
ffffffffc0204b06:	0ef47b63          	bgeu	s0,a5,ffffffffc0204bfc <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0204b0a:	03f00513          	li	a0,63
ffffffffc0204b0e:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b10:	000a4783          	lbu	a5,0(s4)
ffffffffc0204b14:	3dfd                	addiw	s11,s11,-1
ffffffffc0204b16:	0a05                	addi	s4,s4,1
ffffffffc0204b18:	0007851b          	sext.w	a0,a5
ffffffffc0204b1c:	ffe1                	bnez	a5,ffffffffc0204af4 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0204b1e:	01b05963          	blez	s11,ffffffffc0204b30 <vprintfmt+0x244>
ffffffffc0204b22:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0204b24:	85a6                	mv	a1,s1
ffffffffc0204b26:	02000513          	li	a0,32
ffffffffc0204b2a:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0204b2c:	fe0d9be3          	bnez	s11,ffffffffc0204b22 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204b30:	6a02                	ld	s4,0(sp)
ffffffffc0204b32:	bbd5                	j	ffffffffc0204926 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204b34:	4705                	li	a4,1
ffffffffc0204b36:	008a0c93          	addi	s9,s4,8
ffffffffc0204b3a:	01174463          	blt	a4,a7,ffffffffc0204b42 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0204b3e:	08088d63          	beqz	a7,ffffffffc0204bd8 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0204b42:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0204b46:	0a044d63          	bltz	s0,ffffffffc0204c00 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0204b4a:	8622                	mv	a2,s0
ffffffffc0204b4c:	8a66                	mv	s4,s9
ffffffffc0204b4e:	46a9                	li	a3,10
ffffffffc0204b50:	bdcd                	j	ffffffffc0204a42 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0204b52:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b56:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0204b58:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0204b5a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0204b5e:	8fb5                	xor	a5,a5,a3
ffffffffc0204b60:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b64:	02d74163          	blt	a4,a3,ffffffffc0204b86 <vprintfmt+0x29a>
ffffffffc0204b68:	00369793          	slli	a5,a3,0x3
ffffffffc0204b6c:	97de                	add	a5,a5,s7
ffffffffc0204b6e:	639c                	ld	a5,0(a5)
ffffffffc0204b70:	cb99                	beqz	a5,ffffffffc0204b86 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0204b72:	86be                	mv	a3,a5
ffffffffc0204b74:	00000617          	auipc	a2,0x0
ffffffffc0204b78:	13460613          	addi	a2,a2,308 # ffffffffc0204ca8 <etext+0x24>
ffffffffc0204b7c:	85a6                	mv	a1,s1
ffffffffc0204b7e:	854a                	mv	a0,s2
ffffffffc0204b80:	0ce000ef          	jal	ra,ffffffffc0204c4e <printfmt>
ffffffffc0204b84:	b34d                	j	ffffffffc0204926 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0204b86:	00002617          	auipc	a2,0x2
ffffffffc0204b8a:	31a60613          	addi	a2,a2,794 # ffffffffc0206ea0 <syscalls+0x818>
ffffffffc0204b8e:	85a6                	mv	a1,s1
ffffffffc0204b90:	854a                	mv	a0,s2
ffffffffc0204b92:	0bc000ef          	jal	ra,ffffffffc0204c4e <printfmt>
ffffffffc0204b96:	bb41                	j	ffffffffc0204926 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0204b98:	00002417          	auipc	s0,0x2
ffffffffc0204b9c:	30040413          	addi	s0,s0,768 # ffffffffc0206e98 <syscalls+0x810>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204ba0:	85e2                	mv	a1,s8
ffffffffc0204ba2:	8522                	mv	a0,s0
ffffffffc0204ba4:	e43e                	sd	a5,8(sp)
ffffffffc0204ba6:	c61ff0ef          	jal	ra,ffffffffc0204806 <strnlen>
ffffffffc0204baa:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0204bae:	01b05b63          	blez	s11,ffffffffc0204bc4 <vprintfmt+0x2d8>
ffffffffc0204bb2:	67a2                	ld	a5,8(sp)
ffffffffc0204bb4:	00078a1b          	sext.w	s4,a5
ffffffffc0204bb8:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0204bba:	85a6                	mv	a1,s1
ffffffffc0204bbc:	8552                	mv	a0,s4
ffffffffc0204bbe:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bc0:	fe0d9ce3          	bnez	s11,ffffffffc0204bb8 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204bc4:	00044783          	lbu	a5,0(s0)
ffffffffc0204bc8:	00140a13          	addi	s4,s0,1
ffffffffc0204bcc:	0007851b          	sext.w	a0,a5
ffffffffc0204bd0:	d3a5                	beqz	a5,ffffffffc0204b30 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204bd2:	05e00413          	li	s0,94
ffffffffc0204bd6:	bf39                	j	ffffffffc0204af4 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0204bd8:	000a2403          	lw	s0,0(s4)
ffffffffc0204bdc:	b7ad                	j	ffffffffc0204b46 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0204bde:	000a6603          	lwu	a2,0(s4)
ffffffffc0204be2:	46a1                	li	a3,8
ffffffffc0204be4:	8a2e                	mv	s4,a1
ffffffffc0204be6:	bdb1                	j	ffffffffc0204a42 <vprintfmt+0x156>
ffffffffc0204be8:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bec:	46a9                	li	a3,10
ffffffffc0204bee:	8a2e                	mv	s4,a1
ffffffffc0204bf0:	bd89                	j	ffffffffc0204a42 <vprintfmt+0x156>
ffffffffc0204bf2:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bf6:	46c1                	li	a3,16
ffffffffc0204bf8:	8a2e                	mv	s4,a1
ffffffffc0204bfa:	b5a1                	j	ffffffffc0204a42 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0204bfc:	9902                	jalr	s2
ffffffffc0204bfe:	bf09                	j	ffffffffc0204b10 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0204c00:	85a6                	mv	a1,s1
ffffffffc0204c02:	02d00513          	li	a0,45
ffffffffc0204c06:	e03e                	sd	a5,0(sp)
ffffffffc0204c08:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0204c0a:	6782                	ld	a5,0(sp)
ffffffffc0204c0c:	8a66                	mv	s4,s9
ffffffffc0204c0e:	40800633          	neg	a2,s0
ffffffffc0204c12:	46a9                	li	a3,10
ffffffffc0204c14:	b53d                	j	ffffffffc0204a42 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0204c16:	03b05163          	blez	s11,ffffffffc0204c38 <vprintfmt+0x34c>
ffffffffc0204c1a:	02d00693          	li	a3,45
ffffffffc0204c1e:	f6d79de3          	bne	a5,a3,ffffffffc0204b98 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0204c22:	00002417          	auipc	s0,0x2
ffffffffc0204c26:	27640413          	addi	s0,s0,630 # ffffffffc0206e98 <syscalls+0x810>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204c2a:	02800793          	li	a5,40
ffffffffc0204c2e:	02800513          	li	a0,40
ffffffffc0204c32:	00140a13          	addi	s4,s0,1
ffffffffc0204c36:	bd6d                	j	ffffffffc0204af0 <vprintfmt+0x204>
ffffffffc0204c38:	00002a17          	auipc	s4,0x2
ffffffffc0204c3c:	261a0a13          	addi	s4,s4,609 # ffffffffc0206e99 <syscalls+0x811>
ffffffffc0204c40:	02800513          	li	a0,40
ffffffffc0204c44:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204c48:	05e00413          	li	s0,94
ffffffffc0204c4c:	b565                	j	ffffffffc0204af4 <vprintfmt+0x208>

ffffffffc0204c4e <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c4e:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0204c50:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c54:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c56:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c58:	ec06                	sd	ra,24(sp)
ffffffffc0204c5a:	f83a                	sd	a4,48(sp)
ffffffffc0204c5c:	fc3e                	sd	a5,56(sp)
ffffffffc0204c5e:	e0c2                	sd	a6,64(sp)
ffffffffc0204c60:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0204c62:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c64:	c89ff0ef          	jal	ra,ffffffffc02048ec <vprintfmt>
}
ffffffffc0204c68:	60e2                	ld	ra,24(sp)
ffffffffc0204c6a:	6161                	addi	sp,sp,80
ffffffffc0204c6c:	8082                	ret

ffffffffc0204c6e <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0204c6e:	9e3707b7          	lui	a5,0x9e370
ffffffffc0204c72:	2785                	addiw	a5,a5,1
ffffffffc0204c74:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0204c78:	02000793          	li	a5,32
ffffffffc0204c7c:	9f8d                	subw	a5,a5,a1
}
ffffffffc0204c7e:	00f5553b          	srlw	a0,a0,a5
ffffffffc0204c82:	8082                	ret
