
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200000:	c02092b7          	lui	t0,0xc0209
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
ffffffffc0200024:	c0209137          	lui	sp,0xc0209

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
ffffffffc0200032:	00029517          	auipc	a0,0x29
ffffffffc0200036:	81650513          	addi	a0,a0,-2026 # ffffffffc0228848 <buf>
ffffffffc020003a:	00034617          	auipc	a2,0x34
ffffffffc020003e:	dd660613          	addi	a2,a2,-554 # ffffffffc0233e10 <end>
kern_init(void) {
ffffffffc0200042:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200044:	8e09                	sub	a2,a2,a0
ffffffffc0200046:	4581                	li	a1,0
kern_init(void) {
ffffffffc0200048:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020004a:	009040ef          	jal	ra,ffffffffc0204852 <memset>
    cons_init();                // init the console
ffffffffc020004e:	56c000ef          	jal	ra,ffffffffc02005ba <cons_init>

    const char *message = "OS is loading ...";
    cprintf("%s\n\n", message);
ffffffffc0200052:	00005597          	auipc	a1,0x5
ffffffffc0200056:	c2e58593          	addi	a1,a1,-978 # ffffffffc0204c80 <etext>
ffffffffc020005a:	00005517          	auipc	a0,0x5
ffffffffc020005e:	c3e50513          	addi	a0,a0,-962 # ffffffffc0204c98 <etext+0x18>
ffffffffc0200062:	066000ef          	jal	ra,ffffffffc02000c8 <cprintf>

    pmm_init();                 // init physical memory management
ffffffffc0200066:	5fd000ef          	jal	ra,ffffffffc0200e62 <pmm_init>

    idt_init();                 // init interrupt descriptor table
ffffffffc020006a:	5ce000ef          	jal	ra,ffffffffc0200638 <idt_init>

    vmm_init();                 // init virtual memory management
ffffffffc020006e:	62b010ef          	jal	ra,ffffffffc0201e98 <vmm_init>
    sched_init();
ffffffffc0200072:	408040ef          	jal	ra,ffffffffc020447a <sched_init>
    proc_init();                // init process table
ffffffffc0200076:	28a040ef          	jal	ra,ffffffffc0204300 <proc_init>
    
    ide_init();                 // init ide devices
ffffffffc020007a:	4a2000ef          	jal	ra,ffffffffc020051c <ide_init>
    swap_init();                // init swap
ffffffffc020007e:	35a020ef          	jal	ra,ffffffffc02023d8 <swap_init>

    clock_init();               // init clock interrupt
ffffffffc0200082:	4f0000ef          	jal	ra,ffffffffc0200572 <clock_init>
    intr_enable();              // enable irq interrupt
ffffffffc0200086:	5a6000ef          	jal	ra,ffffffffc020062c <intr_enable>
    
    cpu_idle();                 // run idle process
ffffffffc020008a:	3ac040ef          	jal	ra,ffffffffc0204436 <cpu_idle>

ffffffffc020008e <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020008e:	1141                	addi	sp,sp,-16
ffffffffc0200090:	e022                	sd	s0,0(sp)
ffffffffc0200092:	e406                	sd	ra,8(sp)
ffffffffc0200094:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200096:	526000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    (*cnt) ++;
ffffffffc020009a:	401c                	lw	a5,0(s0)
}
ffffffffc020009c:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020009e:	2785                	addiw	a5,a5,1
ffffffffc02000a0:	c01c                	sw	a5,0(s0)
}
ffffffffc02000a2:	6402                	ld	s0,0(sp)
ffffffffc02000a4:	0141                	addi	sp,sp,16
ffffffffc02000a6:	8082                	ret

ffffffffc02000a8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000a8:	1101                	addi	sp,sp,-32
ffffffffc02000aa:	862a                	mv	a2,a0
ffffffffc02000ac:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ae:	00000517          	auipc	a0,0x0
ffffffffc02000b2:	fe050513          	addi	a0,a0,-32 # ffffffffc020008e <cputch>
ffffffffc02000b6:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b8:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000ba:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000bc:	02d040ef          	jal	ra,ffffffffc02048e8 <vprintfmt>
    return cnt;
}
ffffffffc02000c0:	60e2                	ld	ra,24(sp)
ffffffffc02000c2:	4532                	lw	a0,12(sp)
ffffffffc02000c4:	6105                	addi	sp,sp,32
ffffffffc02000c6:	8082                	ret

ffffffffc02000c8 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000c8:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000ca:	02810313          	addi	t1,sp,40 # ffffffffc0209028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000ce:	8e2a                	mv	t3,a0
ffffffffc02000d0:	f42e                	sd	a1,40(sp)
ffffffffc02000d2:	f832                	sd	a2,48(sp)
ffffffffc02000d4:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d6:	00000517          	auipc	a0,0x0
ffffffffc02000da:	fb850513          	addi	a0,a0,-72 # ffffffffc020008e <cputch>
ffffffffc02000de:	004c                	addi	a1,sp,4
ffffffffc02000e0:	869a                	mv	a3,t1
ffffffffc02000e2:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000e4:	ec06                	sd	ra,24(sp)
ffffffffc02000e6:	e0ba                	sd	a4,64(sp)
ffffffffc02000e8:	e4be                	sd	a5,72(sp)
ffffffffc02000ea:	e8c2                	sd	a6,80(sp)
ffffffffc02000ec:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000ee:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02000f0:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f2:	7f6040ef          	jal	ra,ffffffffc02048e8 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02000f6:	60e2                	ld	ra,24(sp)
ffffffffc02000f8:	4512                	lw	a0,4(sp)
ffffffffc02000fa:	6125                	addi	sp,sp,96
ffffffffc02000fc:	8082                	ret

ffffffffc02000fe <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc02000fe:	a97d                	j	ffffffffc02005bc <cons_putc>

ffffffffc0200100 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200100:	1101                	addi	sp,sp,-32
ffffffffc0200102:	e822                	sd	s0,16(sp)
ffffffffc0200104:	ec06                	sd	ra,24(sp)
ffffffffc0200106:	e426                	sd	s1,8(sp)
ffffffffc0200108:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020010a:	00054503          	lbu	a0,0(a0)
ffffffffc020010e:	c51d                	beqz	a0,ffffffffc020013c <cputs+0x3c>
ffffffffc0200110:	0405                	addi	s0,s0,1
ffffffffc0200112:	4485                	li	s1,1
ffffffffc0200114:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200116:	4a6000ef          	jal	ra,ffffffffc02005bc <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020011a:	00044503          	lbu	a0,0(s0)
ffffffffc020011e:	008487bb          	addw	a5,s1,s0
ffffffffc0200122:	0405                	addi	s0,s0,1
ffffffffc0200124:	f96d                	bnez	a0,ffffffffc0200116 <cputs+0x16>
ffffffffc0200126:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc020012a:	4529                	li	a0,10
ffffffffc020012c:	490000ef          	jal	ra,ffffffffc02005bc <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200130:	60e2                	ld	ra,24(sp)
ffffffffc0200132:	8522                	mv	a0,s0
ffffffffc0200134:	6442                	ld	s0,16(sp)
ffffffffc0200136:	64a2                	ld	s1,8(sp)
ffffffffc0200138:	6105                	addi	sp,sp,32
ffffffffc020013a:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc020013c:	4405                	li	s0,1
ffffffffc020013e:	b7f5                	j	ffffffffc020012a <cputs+0x2a>

ffffffffc0200140 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200140:	1141                	addi	sp,sp,-16
ffffffffc0200142:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200144:	4ac000ef          	jal	ra,ffffffffc02005f0 <cons_getc>
ffffffffc0200148:	dd75                	beqz	a0,ffffffffc0200144 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020014a:	60a2                	ld	ra,8(sp)
ffffffffc020014c:	0141                	addi	sp,sp,16
ffffffffc020014e:	8082                	ret

ffffffffc0200150 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0200150:	715d                	addi	sp,sp,-80
ffffffffc0200152:	e486                	sd	ra,72(sp)
ffffffffc0200154:	e0a6                	sd	s1,64(sp)
ffffffffc0200156:	fc4a                	sd	s2,56(sp)
ffffffffc0200158:	f84e                	sd	s3,48(sp)
ffffffffc020015a:	f452                	sd	s4,40(sp)
ffffffffc020015c:	f056                	sd	s5,32(sp)
ffffffffc020015e:	ec5a                	sd	s6,24(sp)
ffffffffc0200160:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0200162:	c901                	beqz	a0,ffffffffc0200172 <readline+0x22>
ffffffffc0200164:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0200166:	00005517          	auipc	a0,0x5
ffffffffc020016a:	b3a50513          	addi	a0,a0,-1222 # ffffffffc0204ca0 <etext+0x20>
ffffffffc020016e:	f5bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
readline(const char *prompt) {
ffffffffc0200172:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200174:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0200176:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0200178:	4aa9                	li	s5,10
ffffffffc020017a:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc020017c:	00028b97          	auipc	s7,0x28
ffffffffc0200180:	6ccb8b93          	addi	s7,s7,1740 # ffffffffc0228848 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200184:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0200188:	fb9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020018c:	00054a63          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200190:	00a95a63          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc0200194:	029a5263          	bge	s4,s1,ffffffffc02001b8 <readline+0x68>
        c = getchar();
ffffffffc0200198:	fa9ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc020019c:	fe055ae3          	bgez	a0,ffffffffc0200190 <readline+0x40>
            return NULL;
ffffffffc02001a0:	4501                	li	a0,0
ffffffffc02001a2:	a091                	j	ffffffffc02001e6 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02001a4:	03351463          	bne	a0,s3,ffffffffc02001cc <readline+0x7c>
ffffffffc02001a8:	e8a9                	bnez	s1,ffffffffc02001fa <readline+0xaa>
        c = getchar();
ffffffffc02001aa:	f97ff0ef          	jal	ra,ffffffffc0200140 <getchar>
        if (c < 0) {
ffffffffc02001ae:	fe0549e3          	bltz	a0,ffffffffc02001a0 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02001b2:	fea959e3          	bge	s2,a0,ffffffffc02001a4 <readline+0x54>
ffffffffc02001b6:	4481                	li	s1,0
            cputchar(c);
ffffffffc02001b8:	e42a                	sd	a0,8(sp)
ffffffffc02001ba:	f45ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i ++] = c;
ffffffffc02001be:	6522                	ld	a0,8(sp)
ffffffffc02001c0:	009b87b3          	add	a5,s7,s1
ffffffffc02001c4:	2485                	addiw	s1,s1,1
ffffffffc02001c6:	00a78023          	sb	a0,0(a5)
ffffffffc02001ca:	bf7d                	j	ffffffffc0200188 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc02001cc:	01550463          	beq	a0,s5,ffffffffc02001d4 <readline+0x84>
ffffffffc02001d0:	fb651ce3          	bne	a0,s6,ffffffffc0200188 <readline+0x38>
            cputchar(c);
ffffffffc02001d4:	f2bff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            buf[i] = '\0';
ffffffffc02001d8:	00028517          	auipc	a0,0x28
ffffffffc02001dc:	67050513          	addi	a0,a0,1648 # ffffffffc0228848 <buf>
ffffffffc02001e0:	94aa                	add	s1,s1,a0
ffffffffc02001e2:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc02001e6:	60a6                	ld	ra,72(sp)
ffffffffc02001e8:	6486                	ld	s1,64(sp)
ffffffffc02001ea:	7962                	ld	s2,56(sp)
ffffffffc02001ec:	79c2                	ld	s3,48(sp)
ffffffffc02001ee:	7a22                	ld	s4,40(sp)
ffffffffc02001f0:	7a82                	ld	s5,32(sp)
ffffffffc02001f2:	6b62                	ld	s6,24(sp)
ffffffffc02001f4:	6bc2                	ld	s7,16(sp)
ffffffffc02001f6:	6161                	addi	sp,sp,80
ffffffffc02001f8:	8082                	ret
            cputchar(c);
ffffffffc02001fa:	4521                	li	a0,8
ffffffffc02001fc:	f03ff0ef          	jal	ra,ffffffffc02000fe <cputchar>
            i --;
ffffffffc0200200:	34fd                	addiw	s1,s1,-1
ffffffffc0200202:	b759                	j	ffffffffc0200188 <readline+0x38>

ffffffffc0200204 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200204:	00034317          	auipc	t1,0x34
ffffffffc0200208:	a7430313          	addi	t1,t1,-1420 # ffffffffc0233c78 <is_panic>
ffffffffc020020c:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200210:	715d                	addi	sp,sp,-80
ffffffffc0200212:	ec06                	sd	ra,24(sp)
ffffffffc0200214:	e822                	sd	s0,16(sp)
ffffffffc0200216:	f436                	sd	a3,40(sp)
ffffffffc0200218:	f83a                	sd	a4,48(sp)
ffffffffc020021a:	fc3e                	sd	a5,56(sp)
ffffffffc020021c:	e0c2                	sd	a6,64(sp)
ffffffffc020021e:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200220:	020e1a63          	bnez	t3,ffffffffc0200254 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc0200224:	4785                	li	a5,1
ffffffffc0200226:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc020022a:	8432                	mv	s0,a2
ffffffffc020022c:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020022e:	862e                	mv	a2,a1
ffffffffc0200230:	85aa                	mv	a1,a0
ffffffffc0200232:	00005517          	auipc	a0,0x5
ffffffffc0200236:	a7650513          	addi	a0,a0,-1418 # ffffffffc0204ca8 <etext+0x28>
    va_start(ap, fmt);
ffffffffc020023a:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020023c:	e8dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200240:	65a2                	ld	a1,8(sp)
ffffffffc0200242:	8522                	mv	a0,s0
ffffffffc0200244:	e65ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc0200248:	00006517          	auipc	a0,0x6
ffffffffc020024c:	f0850513          	addi	a0,a0,-248 # ffffffffc0206150 <default_pmm_manager+0xe8>
ffffffffc0200250:	e79ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200254:	4501                	li	a0,0
ffffffffc0200256:	4581                	li	a1,0
ffffffffc0200258:	4601                	li	a2,0
ffffffffc020025a:	48a1                	li	a7,8
ffffffffc020025c:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc0200260:	3d2000ef          	jal	ra,ffffffffc0200632 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200264:	4501                	li	a0,0
ffffffffc0200266:	174000ef          	jal	ra,ffffffffc02003da <kmonitor>
    while (1) {
ffffffffc020026a:	bfed                	j	ffffffffc0200264 <__panic+0x60>

ffffffffc020026c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc020026c:	715d                	addi	sp,sp,-80
ffffffffc020026e:	832e                	mv	t1,a1
ffffffffc0200270:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200272:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200274:	8432                	mv	s0,a2
ffffffffc0200276:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200278:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc020027a:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020027c:	00005517          	auipc	a0,0x5
ffffffffc0200280:	a4c50513          	addi	a0,a0,-1460 # ffffffffc0204cc8 <etext+0x48>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200284:	ec06                	sd	ra,24(sp)
ffffffffc0200286:	f436                	sd	a3,40(sp)
ffffffffc0200288:	f83a                	sd	a4,48(sp)
ffffffffc020028a:	e0c2                	sd	a6,64(sp)
ffffffffc020028c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020028e:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200290:	e39ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200294:	65a2                	ld	a1,8(sp)
ffffffffc0200296:	8522                	mv	a0,s0
ffffffffc0200298:	e11ff0ef          	jal	ra,ffffffffc02000a8 <vcprintf>
    cprintf("\n");
ffffffffc020029c:	00006517          	auipc	a0,0x6
ffffffffc02002a0:	eb450513          	addi	a0,a0,-332 # ffffffffc0206150 <default_pmm_manager+0xe8>
ffffffffc02002a4:	e25ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    va_end(ap);
}
ffffffffc02002a8:	60e2                	ld	ra,24(sp)
ffffffffc02002aa:	6442                	ld	s0,16(sp)
ffffffffc02002ac:	6161                	addi	sp,sp,80
ffffffffc02002ae:	8082                	ret

ffffffffc02002b0 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc02002b0:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc02002b2:	00005517          	auipc	a0,0x5
ffffffffc02002b6:	a3650513          	addi	a0,a0,-1482 # ffffffffc0204ce8 <etext+0x68>
void print_kerninfo(void) {
ffffffffc02002ba:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc02002bc:	e0dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc02002c0:	00000597          	auipc	a1,0x0
ffffffffc02002c4:	d7258593          	addi	a1,a1,-654 # ffffffffc0200032 <kern_init>
ffffffffc02002c8:	00005517          	auipc	a0,0x5
ffffffffc02002cc:	a4050513          	addi	a0,a0,-1472 # ffffffffc0204d08 <etext+0x88>
ffffffffc02002d0:	df9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc02002d4:	00005597          	auipc	a1,0x5
ffffffffc02002d8:	9ac58593          	addi	a1,a1,-1620 # ffffffffc0204c80 <etext>
ffffffffc02002dc:	00005517          	auipc	a0,0x5
ffffffffc02002e0:	a4c50513          	addi	a0,a0,-1460 # ffffffffc0204d28 <etext+0xa8>
ffffffffc02002e4:	de5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc02002e8:	00028597          	auipc	a1,0x28
ffffffffc02002ec:	56058593          	addi	a1,a1,1376 # ffffffffc0228848 <buf>
ffffffffc02002f0:	00005517          	auipc	a0,0x5
ffffffffc02002f4:	a5850513          	addi	a0,a0,-1448 # ffffffffc0204d48 <etext+0xc8>
ffffffffc02002f8:	dd1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc02002fc:	00034597          	auipc	a1,0x34
ffffffffc0200300:	b1458593          	addi	a1,a1,-1260 # ffffffffc0233e10 <end>
ffffffffc0200304:	00005517          	auipc	a0,0x5
ffffffffc0200308:	a6450513          	addi	a0,a0,-1436 # ffffffffc0204d68 <etext+0xe8>
ffffffffc020030c:	dbdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200310:	00034597          	auipc	a1,0x34
ffffffffc0200314:	eff58593          	addi	a1,a1,-257 # ffffffffc023420f <end+0x3ff>
ffffffffc0200318:	00000797          	auipc	a5,0x0
ffffffffc020031c:	d1a78793          	addi	a5,a5,-742 # ffffffffc0200032 <kern_init>
ffffffffc0200320:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200324:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200328:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020032a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020032e:	95be                	add	a1,a1,a5
ffffffffc0200330:	85a9                	srai	a1,a1,0xa
ffffffffc0200332:	00005517          	auipc	a0,0x5
ffffffffc0200336:	a5650513          	addi	a0,a0,-1450 # ffffffffc0204d88 <etext+0x108>
}
ffffffffc020033a:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020033c:	b371                	j	ffffffffc02000c8 <cprintf>

ffffffffc020033e <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020033e:	1141                	addi	sp,sp,-16
     * and line number, etc.
     *    (3.5) popup a calling stackframe
     *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
     *                   the calling funciton's ebp = ss:[ebp]
     */
    panic("Not Implemented!");
ffffffffc0200340:	00005617          	auipc	a2,0x5
ffffffffc0200344:	a7860613          	addi	a2,a2,-1416 # ffffffffc0204db8 <etext+0x138>
ffffffffc0200348:	05b00593          	li	a1,91
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	a8450513          	addi	a0,a0,-1404 # ffffffffc0204dd0 <etext+0x150>
void print_stackframe(void) {
ffffffffc0200354:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200356:	eafff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020035a <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020035a:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020035c:	00005617          	auipc	a2,0x5
ffffffffc0200360:	a8c60613          	addi	a2,a2,-1396 # ffffffffc0204de8 <etext+0x168>
ffffffffc0200364:	00005597          	auipc	a1,0x5
ffffffffc0200368:	aa458593          	addi	a1,a1,-1372 # ffffffffc0204e08 <etext+0x188>
ffffffffc020036c:	00005517          	auipc	a0,0x5
ffffffffc0200370:	aa450513          	addi	a0,a0,-1372 # ffffffffc0204e10 <etext+0x190>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200374:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200376:	d53ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020037a:	00005617          	auipc	a2,0x5
ffffffffc020037e:	aa660613          	addi	a2,a2,-1370 # ffffffffc0204e20 <etext+0x1a0>
ffffffffc0200382:	00005597          	auipc	a1,0x5
ffffffffc0200386:	ac658593          	addi	a1,a1,-1338 # ffffffffc0204e48 <etext+0x1c8>
ffffffffc020038a:	00005517          	auipc	a0,0x5
ffffffffc020038e:	a8650513          	addi	a0,a0,-1402 # ffffffffc0204e10 <etext+0x190>
ffffffffc0200392:	d37ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0200396:	00005617          	auipc	a2,0x5
ffffffffc020039a:	ac260613          	addi	a2,a2,-1342 # ffffffffc0204e58 <etext+0x1d8>
ffffffffc020039e:	00005597          	auipc	a1,0x5
ffffffffc02003a2:	ada58593          	addi	a1,a1,-1318 # ffffffffc0204e78 <etext+0x1f8>
ffffffffc02003a6:	00005517          	auipc	a0,0x5
ffffffffc02003aa:	a6a50513          	addi	a0,a0,-1430 # ffffffffc0204e10 <etext+0x190>
ffffffffc02003ae:	d1bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    }
    return 0;
}
ffffffffc02003b2:	60a2                	ld	ra,8(sp)
ffffffffc02003b4:	4501                	li	a0,0
ffffffffc02003b6:	0141                	addi	sp,sp,16
ffffffffc02003b8:	8082                	ret

ffffffffc02003ba <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ba:	1141                	addi	sp,sp,-16
ffffffffc02003bc:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc02003be:	ef3ff0ef          	jal	ra,ffffffffc02002b0 <print_kerninfo>
    return 0;
}
ffffffffc02003c2:	60a2                	ld	ra,8(sp)
ffffffffc02003c4:	4501                	li	a0,0
ffffffffc02003c6:	0141                	addi	sp,sp,16
ffffffffc02003c8:	8082                	ret

ffffffffc02003ca <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02003ca:	1141                	addi	sp,sp,-16
ffffffffc02003cc:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02003ce:	f71ff0ef          	jal	ra,ffffffffc020033e <print_stackframe>
    return 0;
}
ffffffffc02003d2:	60a2                	ld	ra,8(sp)
ffffffffc02003d4:	4501                	li	a0,0
ffffffffc02003d6:	0141                	addi	sp,sp,16
ffffffffc02003d8:	8082                	ret

ffffffffc02003da <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02003da:	7115                	addi	sp,sp,-224
ffffffffc02003dc:	e962                	sd	s8,144(sp)
ffffffffc02003de:	8c2a                	mv	s8,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003e0:	00005517          	auipc	a0,0x5
ffffffffc02003e4:	aa850513          	addi	a0,a0,-1368 # ffffffffc0204e88 <etext+0x208>
kmonitor(struct trapframe *tf) {
ffffffffc02003e8:	ed86                	sd	ra,216(sp)
ffffffffc02003ea:	e9a2                	sd	s0,208(sp)
ffffffffc02003ec:	e5a6                	sd	s1,200(sp)
ffffffffc02003ee:	e1ca                	sd	s2,192(sp)
ffffffffc02003f0:	fd4e                	sd	s3,184(sp)
ffffffffc02003f2:	f952                	sd	s4,176(sp)
ffffffffc02003f4:	f556                	sd	s5,168(sp)
ffffffffc02003f6:	f15a                	sd	s6,160(sp)
ffffffffc02003f8:	ed5e                	sd	s7,152(sp)
ffffffffc02003fa:	e566                	sd	s9,136(sp)
ffffffffc02003fc:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02003fe:	ccbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200402:	00005517          	auipc	a0,0x5
ffffffffc0200406:	aae50513          	addi	a0,a0,-1362 # ffffffffc0204eb0 <etext+0x230>
ffffffffc020040a:	cbfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    if (tf != NULL) {
ffffffffc020040e:	000c0563          	beqz	s8,ffffffffc0200418 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200412:	8562                	mv	a0,s8
ffffffffc0200414:	40c000ef          	jal	ra,ffffffffc0200820 <print_trapframe>
ffffffffc0200418:	00005c97          	auipc	s9,0x5
ffffffffc020041c:	b08c8c93          	addi	s9,s9,-1272 # ffffffffc0204f20 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200420:	00005997          	auipc	s3,0x5
ffffffffc0200424:	ab898993          	addi	s3,s3,-1352 # ffffffffc0204ed8 <etext+0x258>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200428:	00005917          	auipc	s2,0x5
ffffffffc020042c:	ab890913          	addi	s2,s2,-1352 # ffffffffc0204ee0 <etext+0x260>
        if (argc == MAXARGS - 1) {
ffffffffc0200430:	4a3d                	li	s4,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200432:	00005b17          	auipc	s6,0x5
ffffffffc0200436:	ab6b0b13          	addi	s6,s6,-1354 # ffffffffc0204ee8 <etext+0x268>
ffffffffc020043a:	00005a97          	auipc	s5,0x5
ffffffffc020043e:	9cea8a93          	addi	s5,s5,-1586 # ffffffffc0204e08 <etext+0x188>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200442:	4b8d                	li	s7,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200444:	854e                	mv	a0,s3
ffffffffc0200446:	d0bff0ef          	jal	ra,ffffffffc0200150 <readline>
ffffffffc020044a:	842a                	mv	s0,a0
ffffffffc020044c:	dd65                	beqz	a0,ffffffffc0200444 <kmonitor+0x6a>
ffffffffc020044e:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200452:	4481                	li	s1,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200454:	c999                	beqz	a1,ffffffffc020046a <kmonitor+0x90>
ffffffffc0200456:	854a                	mv	a0,s2
ffffffffc0200458:	3e4040ef          	jal	ra,ffffffffc020483c <strchr>
ffffffffc020045c:	c925                	beqz	a0,ffffffffc02004cc <kmonitor+0xf2>
            *buf ++ = '\0';
ffffffffc020045e:	00144583          	lbu	a1,1(s0)
ffffffffc0200462:	00040023          	sb	zero,0(s0)
ffffffffc0200466:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200468:	f5fd                	bnez	a1,ffffffffc0200456 <kmonitor+0x7c>
    if (argc == 0) {
ffffffffc020046a:	dce9                	beqz	s1,ffffffffc0200444 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020046c:	6582                	ld	a1,0(sp)
ffffffffc020046e:	00005d17          	auipc	s10,0x5
ffffffffc0200472:	ab2d0d13          	addi	s10,s10,-1358 # ffffffffc0204f20 <commands>
ffffffffc0200476:	8556                	mv	a0,s5
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200478:	4401                	li	s0,0
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020047a:	0d61                	addi	s10,s10,24
ffffffffc020047c:	3a2040ef          	jal	ra,ffffffffc020481e <strcmp>
ffffffffc0200480:	c919                	beqz	a0,ffffffffc0200496 <kmonitor+0xbc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200482:	2405                	addiw	s0,s0,1
ffffffffc0200484:	09740463          	beq	s0,s7,ffffffffc020050c <kmonitor+0x132>
ffffffffc0200488:	000d3503          	ld	a0,0(s10)
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020048c:	6582                	ld	a1,0(sp)
ffffffffc020048e:	0d61                	addi	s10,s10,24
ffffffffc0200490:	38e040ef          	jal	ra,ffffffffc020481e <strcmp>
ffffffffc0200494:	f57d                	bnez	a0,ffffffffc0200482 <kmonitor+0xa8>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200496:	00141793          	slli	a5,s0,0x1
ffffffffc020049a:	97a2                	add	a5,a5,s0
ffffffffc020049c:	078e                	slli	a5,a5,0x3
ffffffffc020049e:	97e6                	add	a5,a5,s9
ffffffffc02004a0:	6b9c                	ld	a5,16(a5)
ffffffffc02004a2:	8662                	mv	a2,s8
ffffffffc02004a4:	002c                	addi	a1,sp,8
ffffffffc02004a6:	fff4851b          	addiw	a0,s1,-1
ffffffffc02004aa:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc02004ac:	f8055ce3          	bgez	a0,ffffffffc0200444 <kmonitor+0x6a>
}
ffffffffc02004b0:	60ee                	ld	ra,216(sp)
ffffffffc02004b2:	644e                	ld	s0,208(sp)
ffffffffc02004b4:	64ae                	ld	s1,200(sp)
ffffffffc02004b6:	690e                	ld	s2,192(sp)
ffffffffc02004b8:	79ea                	ld	s3,184(sp)
ffffffffc02004ba:	7a4a                	ld	s4,176(sp)
ffffffffc02004bc:	7aaa                	ld	s5,168(sp)
ffffffffc02004be:	7b0a                	ld	s6,160(sp)
ffffffffc02004c0:	6bea                	ld	s7,152(sp)
ffffffffc02004c2:	6c4a                	ld	s8,144(sp)
ffffffffc02004c4:	6caa                	ld	s9,136(sp)
ffffffffc02004c6:	6d0a                	ld	s10,128(sp)
ffffffffc02004c8:	612d                	addi	sp,sp,224
ffffffffc02004ca:	8082                	ret
        if (*buf == '\0') {
ffffffffc02004cc:	00044783          	lbu	a5,0(s0)
ffffffffc02004d0:	dfc9                	beqz	a5,ffffffffc020046a <kmonitor+0x90>
        if (argc == MAXARGS - 1) {
ffffffffc02004d2:	03448863          	beq	s1,s4,ffffffffc0200502 <kmonitor+0x128>
        argv[argc ++] = buf;
ffffffffc02004d6:	00349793          	slli	a5,s1,0x3
ffffffffc02004da:	0118                	addi	a4,sp,128
ffffffffc02004dc:	97ba                	add	a5,a5,a4
ffffffffc02004de:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e2:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02004e6:	2485                	addiw	s1,s1,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004e8:	e591                	bnez	a1,ffffffffc02004f4 <kmonitor+0x11a>
ffffffffc02004ea:	b749                	j	ffffffffc020046c <kmonitor+0x92>
ffffffffc02004ec:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02004f0:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02004f2:	ddad                	beqz	a1,ffffffffc020046c <kmonitor+0x92>
ffffffffc02004f4:	854a                	mv	a0,s2
ffffffffc02004f6:	346040ef          	jal	ra,ffffffffc020483c <strchr>
ffffffffc02004fa:	d96d                	beqz	a0,ffffffffc02004ec <kmonitor+0x112>
ffffffffc02004fc:	00044583          	lbu	a1,0(s0)
ffffffffc0200500:	bf91                	j	ffffffffc0200454 <kmonitor+0x7a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200502:	45c1                	li	a1,16
ffffffffc0200504:	855a                	mv	a0,s6
ffffffffc0200506:	bc3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc020050a:	b7f1                	j	ffffffffc02004d6 <kmonitor+0xfc>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020050c:	6582                	ld	a1,0(sp)
ffffffffc020050e:	00005517          	auipc	a0,0x5
ffffffffc0200512:	9fa50513          	addi	a0,a0,-1542 # ffffffffc0204f08 <etext+0x288>
ffffffffc0200516:	bb3ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
ffffffffc020051a:	b72d                	j	ffffffffc0200444 <kmonitor+0x6a>

ffffffffc020051c <ide_init>:
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <riscv.h>

void ide_init(void) {}
ffffffffc020051c:	8082                	ret

ffffffffc020051e <ide_device_valid>:

#define MAX_IDE 2
#define MAX_DISK_NSECS 56
static char ide[MAX_DISK_NSECS * SECTSIZE];

bool ide_device_valid(unsigned short ideno) { return ideno < MAX_IDE; }
ffffffffc020051e:	00253513          	sltiu	a0,a0,2
ffffffffc0200522:	8082                	ret

ffffffffc0200524 <ide_device_size>:

size_t ide_device_size(unsigned short ideno) { return MAX_DISK_NSECS; }
ffffffffc0200524:	03800513          	li	a0,56
ffffffffc0200528:	8082                	ret

ffffffffc020052a <ide_read_secs>:

int ide_read_secs(unsigned short ideno, uint32_t secno, void *dst,
                  size_t nsecs) {
    int iobase = secno * SECTSIZE;
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020052a:	00028797          	auipc	a5,0x28
ffffffffc020052e:	71e78793          	addi	a5,a5,1822 # ffffffffc0228c48 <ide>
    int iobase = secno * SECTSIZE;
ffffffffc0200532:	0095959b          	slliw	a1,a1,0x9
                  size_t nsecs) {
ffffffffc0200536:	1141                	addi	sp,sp,-16
ffffffffc0200538:	8532                	mv	a0,a2
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc020053a:	95be                	add	a1,a1,a5
ffffffffc020053c:	00969613          	slli	a2,a3,0x9
                  size_t nsecs) {
ffffffffc0200540:	e406                	sd	ra,8(sp)
    memcpy(dst, &ide[iobase], nsecs * SECTSIZE);
ffffffffc0200542:	322040ef          	jal	ra,ffffffffc0204864 <memcpy>
    return 0;
}
ffffffffc0200546:	60a2                	ld	ra,8(sp)
ffffffffc0200548:	4501                	li	a0,0
ffffffffc020054a:	0141                	addi	sp,sp,16
ffffffffc020054c:	8082                	ret

ffffffffc020054e <ide_write_secs>:

int ide_write_secs(unsigned short ideno, uint32_t secno, const void *src,
                   size_t nsecs) {
    int iobase = secno * SECTSIZE;
ffffffffc020054e:	0095979b          	slliw	a5,a1,0x9
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200552:	00028517          	auipc	a0,0x28
ffffffffc0200556:	6f650513          	addi	a0,a0,1782 # ffffffffc0228c48 <ide>
                   size_t nsecs) {
ffffffffc020055a:	1141                	addi	sp,sp,-16
ffffffffc020055c:	85b2                	mv	a1,a2
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc020055e:	953e                	add	a0,a0,a5
ffffffffc0200560:	00969613          	slli	a2,a3,0x9
                   size_t nsecs) {
ffffffffc0200564:	e406                	sd	ra,8(sp)
    memcpy(&ide[iobase], src, nsecs * SECTSIZE);
ffffffffc0200566:	2fe040ef          	jal	ra,ffffffffc0204864 <memcpy>
    return 0;
}
ffffffffc020056a:	60a2                	ld	ra,8(sp)
ffffffffc020056c:	4501                	li	a0,0
ffffffffc020056e:	0141                	addi	sp,sp,16
ffffffffc0200570:	8082                	ret

ffffffffc0200572 <clock_init>:

static uint64_t timebase = 100000;


void clock_init(void) {
    set_csr(sie, MIP_STIP);
ffffffffc0200572:	02000793          	li	a5,32
ffffffffc0200576:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020057a:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_rr_out_size+0xdca0>
ffffffffc0200584:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
    cprintf("setup timer interrupts\n");
ffffffffc0200590:	00005517          	auipc	a0,0x5
ffffffffc0200594:	9d850513          	addi	a0,a0,-1576 # ffffffffc0204f68 <commands+0x48>
    ticks = 0;
ffffffffc0200598:	00033797          	auipc	a5,0x33
ffffffffc020059c:	7407b423          	sd	zero,1864(a5) # ffffffffc0233ce0 <ticks>
    cprintf("setup timer interrupts\n");
ffffffffc02005a0:	b625                	j	ffffffffc02000c8 <cprintf>

ffffffffc02005a2 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc02005a2:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc02005a6:	67e1                	lui	a5,0x18
ffffffffc02005a8:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_rr_out_size+0xdca0>
ffffffffc02005ac:	953e                	add	a0,a0,a5
ffffffffc02005ae:	4581                	li	a1,0
ffffffffc02005b0:	4601                	li	a2,0
ffffffffc02005b2:	4881                	li	a7,0
ffffffffc02005b4:	00000073          	ecall
ffffffffc02005b8:	8082                	ret

ffffffffc02005ba <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc02005ba:	8082                	ret

ffffffffc02005bc <cons_putc>:
#include <riscv.h>
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	0ff57513          	andi	a0,a0,255
ffffffffc02005c6:	e799                	bnez	a5,ffffffffc02005d4 <cons_putc+0x18>
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
ffffffffc02005d2:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
ffffffffc02005d8:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005da:	058000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc02005de:	6522                	ld	a0,8(sp)
ffffffffc02005e0:	4581                	li	a1,0
ffffffffc02005e2:	4601                	li	a2,0
ffffffffc02005e4:	4885                	li	a7,1
ffffffffc02005e6:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005ea:	60e2                	ld	ra,24(sp)
ffffffffc02005ec:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02005ee:	a83d                	j	ffffffffc020062c <intr_enable>

ffffffffc02005f0 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02005f0:	100027f3          	csrr	a5,sstatus
ffffffffc02005f4:	8b89                	andi	a5,a5,2
ffffffffc02005f6:	eb89                	bnez	a5,ffffffffc0200608 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005f8:	4501                	li	a0,0
ffffffffc02005fa:	4581                	li	a1,0
ffffffffc02005fc:	4601                	li	a2,0
ffffffffc02005fe:	4889                	li	a7,2
ffffffffc0200600:	00000073          	ecall
ffffffffc0200604:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc0200606:	8082                	ret
int cons_getc(void) {
ffffffffc0200608:	1101                	addi	sp,sp,-32
ffffffffc020060a:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc020060c:	026000ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0200610:	4501                	li	a0,0
ffffffffc0200612:	4581                	li	a1,0
ffffffffc0200614:	4601                	li	a2,0
ffffffffc0200616:	4889                	li	a7,2
ffffffffc0200618:	00000073          	ecall
ffffffffc020061c:	2501                	sext.w	a0,a0
ffffffffc020061e:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc0200620:	00c000ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc0200624:	60e2                	ld	ra,24(sp)
ffffffffc0200626:	6522                	ld	a0,8(sp)
ffffffffc0200628:	6105                	addi	sp,sp,32
ffffffffc020062a:	8082                	ret

ffffffffc020062c <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc020062c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200630:	8082                	ret

ffffffffc0200632 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200632:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200636:	8082                	ret

ffffffffc0200638 <idt_init>:
void
idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200638:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc020063c:	00000797          	auipc	a5,0x0
ffffffffc0200640:	62c78793          	addi	a5,a5,1580 # ffffffffc0200c68 <__alltraps>
ffffffffc0200644:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc0200648:	000407b7          	lui	a5,0x40
ffffffffc020064c:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc0200650:	8082                	ret

ffffffffc0200652 <print_regs>:
    cprintf("  tval 0x%08x\n", tf->tval);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200652:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc0200654:	1141                	addi	sp,sp,-16
ffffffffc0200656:	e022                	sd	s0,0(sp)
ffffffffc0200658:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020065a:	00005517          	auipc	a0,0x5
ffffffffc020065e:	92650513          	addi	a0,a0,-1754 # ffffffffc0204f80 <commands+0x60>
void print_regs(struct pushregs* gpr) {
ffffffffc0200662:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200664:	a65ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200668:	640c                	ld	a1,8(s0)
ffffffffc020066a:	00005517          	auipc	a0,0x5
ffffffffc020066e:	92e50513          	addi	a0,a0,-1746 # ffffffffc0204f98 <commands+0x78>
ffffffffc0200672:	a57ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200676:	680c                	ld	a1,16(s0)
ffffffffc0200678:	00005517          	auipc	a0,0x5
ffffffffc020067c:	93850513          	addi	a0,a0,-1736 # ffffffffc0204fb0 <commands+0x90>
ffffffffc0200680:	a49ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200684:	6c0c                	ld	a1,24(s0)
ffffffffc0200686:	00005517          	auipc	a0,0x5
ffffffffc020068a:	94250513          	addi	a0,a0,-1726 # ffffffffc0204fc8 <commands+0xa8>
ffffffffc020068e:	a3bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200692:	700c                	ld	a1,32(s0)
ffffffffc0200694:	00005517          	auipc	a0,0x5
ffffffffc0200698:	94c50513          	addi	a0,a0,-1716 # ffffffffc0204fe0 <commands+0xc0>
ffffffffc020069c:	a2dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02006a0:	740c                	ld	a1,40(s0)
ffffffffc02006a2:	00005517          	auipc	a0,0x5
ffffffffc02006a6:	95650513          	addi	a0,a0,-1706 # ffffffffc0204ff8 <commands+0xd8>
ffffffffc02006aa:	a1fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02006ae:	780c                	ld	a1,48(s0)
ffffffffc02006b0:	00005517          	auipc	a0,0x5
ffffffffc02006b4:	96050513          	addi	a0,a0,-1696 # ffffffffc0205010 <commands+0xf0>
ffffffffc02006b8:	a11ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02006bc:	7c0c                	ld	a1,56(s0)
ffffffffc02006be:	00005517          	auipc	a0,0x5
ffffffffc02006c2:	96a50513          	addi	a0,a0,-1686 # ffffffffc0205028 <commands+0x108>
ffffffffc02006c6:	a03ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02006ca:	602c                	ld	a1,64(s0)
ffffffffc02006cc:	00005517          	auipc	a0,0x5
ffffffffc02006d0:	97450513          	addi	a0,a0,-1676 # ffffffffc0205040 <commands+0x120>
ffffffffc02006d4:	9f5ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02006d8:	642c                	ld	a1,72(s0)
ffffffffc02006da:	00005517          	auipc	a0,0x5
ffffffffc02006de:	97e50513          	addi	a0,a0,-1666 # ffffffffc0205058 <commands+0x138>
ffffffffc02006e2:	9e7ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02006e6:	682c                	ld	a1,80(s0)
ffffffffc02006e8:	00005517          	auipc	a0,0x5
ffffffffc02006ec:	98850513          	addi	a0,a0,-1656 # ffffffffc0205070 <commands+0x150>
ffffffffc02006f0:	9d9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02006f4:	6c2c                	ld	a1,88(s0)
ffffffffc02006f6:	00005517          	auipc	a0,0x5
ffffffffc02006fa:	99250513          	addi	a0,a0,-1646 # ffffffffc0205088 <commands+0x168>
ffffffffc02006fe:	9cbff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200702:	702c                	ld	a1,96(s0)
ffffffffc0200704:	00005517          	auipc	a0,0x5
ffffffffc0200708:	99c50513          	addi	a0,a0,-1636 # ffffffffc02050a0 <commands+0x180>
ffffffffc020070c:	9bdff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200710:	742c                	ld	a1,104(s0)
ffffffffc0200712:	00005517          	auipc	a0,0x5
ffffffffc0200716:	9a650513          	addi	a0,a0,-1626 # ffffffffc02050b8 <commands+0x198>
ffffffffc020071a:	9afff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020071e:	782c                	ld	a1,112(s0)
ffffffffc0200720:	00005517          	auipc	a0,0x5
ffffffffc0200724:	9b050513          	addi	a0,a0,-1616 # ffffffffc02050d0 <commands+0x1b0>
ffffffffc0200728:	9a1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020072c:	7c2c                	ld	a1,120(s0)
ffffffffc020072e:	00005517          	auipc	a0,0x5
ffffffffc0200732:	9ba50513          	addi	a0,a0,-1606 # ffffffffc02050e8 <commands+0x1c8>
ffffffffc0200736:	993ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020073a:	604c                	ld	a1,128(s0)
ffffffffc020073c:	00005517          	auipc	a0,0x5
ffffffffc0200740:	9c450513          	addi	a0,a0,-1596 # ffffffffc0205100 <commands+0x1e0>
ffffffffc0200744:	985ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200748:	644c                	ld	a1,136(s0)
ffffffffc020074a:	00005517          	auipc	a0,0x5
ffffffffc020074e:	9ce50513          	addi	a0,a0,-1586 # ffffffffc0205118 <commands+0x1f8>
ffffffffc0200752:	977ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200756:	684c                	ld	a1,144(s0)
ffffffffc0200758:	00005517          	auipc	a0,0x5
ffffffffc020075c:	9d850513          	addi	a0,a0,-1576 # ffffffffc0205130 <commands+0x210>
ffffffffc0200760:	969ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200764:	6c4c                	ld	a1,152(s0)
ffffffffc0200766:	00005517          	auipc	a0,0x5
ffffffffc020076a:	9e250513          	addi	a0,a0,-1566 # ffffffffc0205148 <commands+0x228>
ffffffffc020076e:	95bff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200772:	704c                	ld	a1,160(s0)
ffffffffc0200774:	00005517          	auipc	a0,0x5
ffffffffc0200778:	9ec50513          	addi	a0,a0,-1556 # ffffffffc0205160 <commands+0x240>
ffffffffc020077c:	94dff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200780:	744c                	ld	a1,168(s0)
ffffffffc0200782:	00005517          	auipc	a0,0x5
ffffffffc0200786:	9f650513          	addi	a0,a0,-1546 # ffffffffc0205178 <commands+0x258>
ffffffffc020078a:	93fff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020078e:	784c                	ld	a1,176(s0)
ffffffffc0200790:	00005517          	auipc	a0,0x5
ffffffffc0200794:	a0050513          	addi	a0,a0,-1536 # ffffffffc0205190 <commands+0x270>
ffffffffc0200798:	931ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc020079c:	7c4c                	ld	a1,184(s0)
ffffffffc020079e:	00005517          	auipc	a0,0x5
ffffffffc02007a2:	a0a50513          	addi	a0,a0,-1526 # ffffffffc02051a8 <commands+0x288>
ffffffffc02007a6:	923ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02007aa:	606c                	ld	a1,192(s0)
ffffffffc02007ac:	00005517          	auipc	a0,0x5
ffffffffc02007b0:	a1450513          	addi	a0,a0,-1516 # ffffffffc02051c0 <commands+0x2a0>
ffffffffc02007b4:	915ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02007b8:	646c                	ld	a1,200(s0)
ffffffffc02007ba:	00005517          	auipc	a0,0x5
ffffffffc02007be:	a1e50513          	addi	a0,a0,-1506 # ffffffffc02051d8 <commands+0x2b8>
ffffffffc02007c2:	907ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02007c6:	686c                	ld	a1,208(s0)
ffffffffc02007c8:	00005517          	auipc	a0,0x5
ffffffffc02007cc:	a2850513          	addi	a0,a0,-1496 # ffffffffc02051f0 <commands+0x2d0>
ffffffffc02007d0:	8f9ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02007d4:	6c6c                	ld	a1,216(s0)
ffffffffc02007d6:	00005517          	auipc	a0,0x5
ffffffffc02007da:	a3250513          	addi	a0,a0,-1486 # ffffffffc0205208 <commands+0x2e8>
ffffffffc02007de:	8ebff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02007e2:	706c                	ld	a1,224(s0)
ffffffffc02007e4:	00005517          	auipc	a0,0x5
ffffffffc02007e8:	a3c50513          	addi	a0,a0,-1476 # ffffffffc0205220 <commands+0x300>
ffffffffc02007ec:	8ddff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02007f0:	746c                	ld	a1,232(s0)
ffffffffc02007f2:	00005517          	auipc	a0,0x5
ffffffffc02007f6:	a4650513          	addi	a0,a0,-1466 # ffffffffc0205238 <commands+0x318>
ffffffffc02007fa:	8cfff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02007fe:	786c                	ld	a1,240(s0)
ffffffffc0200800:	00005517          	auipc	a0,0x5
ffffffffc0200804:	a5050513          	addi	a0,a0,-1456 # ffffffffc0205250 <commands+0x330>
ffffffffc0200808:	8c1ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020080c:	7c6c                	ld	a1,248(s0)
}
ffffffffc020080e:	6402                	ld	s0,0(sp)
ffffffffc0200810:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200812:	00005517          	auipc	a0,0x5
ffffffffc0200816:	a5650513          	addi	a0,a0,-1450 # ffffffffc0205268 <commands+0x348>
}
ffffffffc020081a:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc020081c:	8adff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200820 <print_trapframe>:
print_trapframe(struct trapframe *tf) {
ffffffffc0200820:	1141                	addi	sp,sp,-16
ffffffffc0200822:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200824:	85aa                	mv	a1,a0
print_trapframe(struct trapframe *tf) {
ffffffffc0200826:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200828:	00005517          	auipc	a0,0x5
ffffffffc020082c:	a5850513          	addi	a0,a0,-1448 # ffffffffc0205280 <commands+0x360>
print_trapframe(struct trapframe *tf) {
ffffffffc0200830:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200832:	897ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200836:	8522                	mv	a0,s0
ffffffffc0200838:	e1bff0ef          	jal	ra,ffffffffc0200652 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc020083c:	10043583          	ld	a1,256(s0)
ffffffffc0200840:	00005517          	auipc	a0,0x5
ffffffffc0200844:	a5850513          	addi	a0,a0,-1448 # ffffffffc0205298 <commands+0x378>
ffffffffc0200848:	881ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc020084c:	10843583          	ld	a1,264(s0)
ffffffffc0200850:	00005517          	auipc	a0,0x5
ffffffffc0200854:	a6050513          	addi	a0,a0,-1440 # ffffffffc02052b0 <commands+0x390>
ffffffffc0200858:	871ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc020085c:	11043583          	ld	a1,272(s0)
ffffffffc0200860:	00005517          	auipc	a0,0x5
ffffffffc0200864:	a6850513          	addi	a0,a0,-1432 # ffffffffc02052c8 <commands+0x3a8>
ffffffffc0200868:	861ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020086c:	11843583          	ld	a1,280(s0)
}
ffffffffc0200870:	6402                	ld	s0,0(sp)
ffffffffc0200872:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200874:	00005517          	auipc	a0,0x5
ffffffffc0200878:	a6450513          	addi	a0,a0,-1436 # ffffffffc02052d8 <commands+0x3b8>
}
ffffffffc020087c:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc020087e:	84bff06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc0200882 <pgfault_handler>:
            trap_in_kernel(tf) ? 'K' : 'U',
            tf->cause == CAUSE_STORE_PAGE_FAULT ? 'W' : 'R');
}

static int
pgfault_handler(struct trapframe *tf) {
ffffffffc0200882:	1101                	addi	sp,sp,-32
ffffffffc0200884:	e426                	sd	s1,8(sp)
    extern struct mm_struct *check_mm_struct;
    if(check_mm_struct !=NULL) { 
ffffffffc0200886:	00033497          	auipc	s1,0x33
ffffffffc020088a:	49248493          	addi	s1,s1,1170 # ffffffffc0233d18 <check_mm_struct>
ffffffffc020088e:	609c                	ld	a5,0(s1)
pgfault_handler(struct trapframe *tf) {
ffffffffc0200890:	e822                	sd	s0,16(sp)
ffffffffc0200892:	ec06                	sd	ra,24(sp)
ffffffffc0200894:	842a                	mv	s0,a0
    if(check_mm_struct !=NULL) { 
ffffffffc0200896:	cbad                	beqz	a5,ffffffffc0200908 <pgfault_handler+0x86>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200898:	10053783          	ld	a5,256(a0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020089c:	11053583          	ld	a1,272(a0)
ffffffffc02008a0:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc02008a4:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008a8:	c7b1                	beqz	a5,ffffffffc02008f4 <pgfault_handler+0x72>
ffffffffc02008aa:	11843703          	ld	a4,280(s0)
ffffffffc02008ae:	47bd                	li	a5,15
ffffffffc02008b0:	05700693          	li	a3,87
ffffffffc02008b4:	00f70463          	beq	a4,a5,ffffffffc02008bc <pgfault_handler+0x3a>
ffffffffc02008b8:	05200693          	li	a3,82
ffffffffc02008bc:	00005517          	auipc	a0,0x5
ffffffffc02008c0:	a3450513          	addi	a0,a0,-1484 # ffffffffc02052f0 <commands+0x3d0>
ffffffffc02008c4:	805ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            print_pgfault(tf);
        }
    struct mm_struct *mm;
    if (check_mm_struct != NULL) {
ffffffffc02008c8:	6088                	ld	a0,0(s1)
ffffffffc02008ca:	cd1d                	beqz	a0,ffffffffc0200908 <pgfault_handler+0x86>
        assert(current == idleproc);
ffffffffc02008cc:	00033717          	auipc	a4,0x33
ffffffffc02008d0:	3e473703          	ld	a4,996(a4) # ffffffffc0233cb0 <current>
ffffffffc02008d4:	00033797          	auipc	a5,0x33
ffffffffc02008d8:	3e47b783          	ld	a5,996(a5) # ffffffffc0233cb8 <idleproc>
ffffffffc02008dc:	04f71663          	bne	a4,a5,ffffffffc0200928 <pgfault_handler+0xa6>
            print_pgfault(tf);
            panic("unhandled page fault.\n");
        }
        mm = current->mm;
    }
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008e0:	11043603          	ld	a2,272(s0)
ffffffffc02008e4:	11843583          	ld	a1,280(s0)
}
ffffffffc02008e8:	6442                	ld	s0,16(sp)
ffffffffc02008ea:	60e2                	ld	ra,24(sp)
ffffffffc02008ec:	64a2                	ld	s1,8(sp)
ffffffffc02008ee:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc02008f0:	5aa0106f          	j	ffffffffc0201e9a <do_pgfault>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc02008f4:	11843703          	ld	a4,280(s0)
ffffffffc02008f8:	47bd                	li	a5,15
ffffffffc02008fa:	05500613          	li	a2,85
ffffffffc02008fe:	05700693          	li	a3,87
ffffffffc0200902:	faf71be3          	bne	a4,a5,ffffffffc02008b8 <pgfault_handler+0x36>
ffffffffc0200906:	bf5d                	j	ffffffffc02008bc <pgfault_handler+0x3a>
        if (current == NULL) {
ffffffffc0200908:	00033797          	auipc	a5,0x33
ffffffffc020090c:	3a87b783          	ld	a5,936(a5) # ffffffffc0233cb0 <current>
ffffffffc0200910:	cf85                	beqz	a5,ffffffffc0200948 <pgfault_handler+0xc6>
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200912:	11043603          	ld	a2,272(s0)
ffffffffc0200916:	11843583          	ld	a1,280(s0)
}
ffffffffc020091a:	6442                	ld	s0,16(sp)
ffffffffc020091c:	60e2                	ld	ra,24(sp)
ffffffffc020091e:	64a2                	ld	s1,8(sp)
        mm = current->mm;
ffffffffc0200920:	7788                	ld	a0,40(a5)
}
ffffffffc0200922:	6105                	addi	sp,sp,32
    return do_pgfault(mm, tf->cause, tf->tval);
ffffffffc0200924:	5760106f          	j	ffffffffc0201e9a <do_pgfault>
        assert(current == idleproc);
ffffffffc0200928:	00005697          	auipc	a3,0x5
ffffffffc020092c:	9e868693          	addi	a3,a3,-1560 # ffffffffc0205310 <commands+0x3f0>
ffffffffc0200930:	00005617          	auipc	a2,0x5
ffffffffc0200934:	9f860613          	addi	a2,a2,-1544 # ffffffffc0205328 <commands+0x408>
ffffffffc0200938:	06800593          	li	a1,104
ffffffffc020093c:	00005517          	auipc	a0,0x5
ffffffffc0200940:	a0450513          	addi	a0,a0,-1532 # ffffffffc0205340 <commands+0x420>
ffffffffc0200944:	8c1ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200948:	8522                	mv	a0,s0
ffffffffc020094a:	ed7ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020094e:	10043783          	ld	a5,256(s0)
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200952:	11043583          	ld	a1,272(s0)
ffffffffc0200956:	04b00613          	li	a2,75
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc020095a:	1007f793          	andi	a5,a5,256
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc020095e:	e399                	bnez	a5,ffffffffc0200964 <pgfault_handler+0xe2>
ffffffffc0200960:	05500613          	li	a2,85
ffffffffc0200964:	11843703          	ld	a4,280(s0)
ffffffffc0200968:	47bd                	li	a5,15
ffffffffc020096a:	02f70663          	beq	a4,a5,ffffffffc0200996 <pgfault_handler+0x114>
ffffffffc020096e:	05200693          	li	a3,82
ffffffffc0200972:	00005517          	auipc	a0,0x5
ffffffffc0200976:	97e50513          	addi	a0,a0,-1666 # ffffffffc02052f0 <commands+0x3d0>
ffffffffc020097a:	f4eff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            panic("unhandled page fault.\n");
ffffffffc020097e:	00005617          	auipc	a2,0x5
ffffffffc0200982:	9da60613          	addi	a2,a2,-1574 # ffffffffc0205358 <commands+0x438>
ffffffffc0200986:	06f00593          	li	a1,111
ffffffffc020098a:	00005517          	auipc	a0,0x5
ffffffffc020098e:	9b650513          	addi	a0,a0,-1610 # ffffffffc0205340 <commands+0x420>
ffffffffc0200992:	873ff0ef          	jal	ra,ffffffffc0200204 <__panic>
    cprintf("page falut at 0x%08x: %c/%c\n", tf->tval,
ffffffffc0200996:	05700693          	li	a3,87
ffffffffc020099a:	bfe1                	j	ffffffffc0200972 <pgfault_handler+0xf0>

ffffffffc020099c <interrupt_handler>:

static volatile int in_swap_tick_event = 0;
extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc020099c:	11853783          	ld	a5,280(a0)
ffffffffc02009a0:	472d                	li	a4,11
ffffffffc02009a2:	0786                	slli	a5,a5,0x1
ffffffffc02009a4:	8385                	srli	a5,a5,0x1
ffffffffc02009a6:	06f76d63          	bltu	a4,a5,ffffffffc0200a20 <interrupt_handler+0x84>
ffffffffc02009aa:	00005717          	auipc	a4,0x5
ffffffffc02009ae:	a6670713          	addi	a4,a4,-1434 # ffffffffc0205410 <commands+0x4f0>
ffffffffc02009b2:	078a                	slli	a5,a5,0x2
ffffffffc02009b4:	97ba                	add	a5,a5,a4
ffffffffc02009b6:	439c                	lw	a5,0(a5)
ffffffffc02009b8:	97ba                	add	a5,a5,a4
ffffffffc02009ba:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc02009bc:	00005517          	auipc	a0,0x5
ffffffffc02009c0:	a1450513          	addi	a0,a0,-1516 # ffffffffc02053d0 <commands+0x4b0>
ffffffffc02009c4:	f04ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc02009c8:	00005517          	auipc	a0,0x5
ffffffffc02009cc:	9e850513          	addi	a0,a0,-1560 # ffffffffc02053b0 <commands+0x490>
ffffffffc02009d0:	ef8ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc02009d4:	00005517          	auipc	a0,0x5
ffffffffc02009d8:	99c50513          	addi	a0,a0,-1636 # ffffffffc0205370 <commands+0x450>
ffffffffc02009dc:	eecff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc02009e0:	00005517          	auipc	a0,0x5
ffffffffc02009e4:	9b050513          	addi	a0,a0,-1616 # ffffffffc0205390 <commands+0x470>
ffffffffc02009e8:	ee0ff06f          	j	ffffffffc02000c8 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc02009ec:	1141                	addi	sp,sp,-16
ffffffffc02009ee:	e406                	sd	ra,8(sp)
            break;
        case IRQ_U_TIMER:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_TIMER:
            clock_set_next_event();
ffffffffc02009f0:	bb3ff0ef          	jal	ra,ffffffffc02005a2 <clock_set_next_event>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc02009f4:	00033717          	auipc	a4,0x33
ffffffffc02009f8:	2ec70713          	addi	a4,a4,748 # ffffffffc0233ce0 <ticks>
ffffffffc02009fc:	631c                	ld	a5,0(a4)
                //print_ticks()
            }
            if (current){
ffffffffc02009fe:	00033517          	auipc	a0,0x33
ffffffffc0200a02:	2b253503          	ld	a0,690(a0) # ffffffffc0233cb0 <current>
            if (++ticks % TICK_NUM == 0 ) {
ffffffffc0200a06:	0785                	addi	a5,a5,1
ffffffffc0200a08:	e31c                	sd	a5,0(a4)
            if (current){
ffffffffc0200a0a:	cd01                	beqz	a0,ffffffffc0200a22 <interrupt_handler+0x86>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a0c:	60a2                	ld	ra,8(sp)
ffffffffc0200a0e:	0141                	addi	sp,sp,16
                sched_class_proc_tick(current); 
ffffffffc0200a10:	2410306f          	j	ffffffffc0204450 <sched_class_proc_tick>
            cprintf("Supervisor external interrupt\n");
ffffffffc0200a14:	00005517          	auipc	a0,0x5
ffffffffc0200a18:	9dc50513          	addi	a0,a0,-1572 # ffffffffc02053f0 <commands+0x4d0>
ffffffffc0200a1c:	eacff06f          	j	ffffffffc02000c8 <cprintf>
            print_trapframe(tf);
ffffffffc0200a20:	b501                	j	ffffffffc0200820 <print_trapframe>
}
ffffffffc0200a22:	60a2                	ld	ra,8(sp)
ffffffffc0200a24:	0141                	addi	sp,sp,16
ffffffffc0200a26:	8082                	ret

ffffffffc0200a28 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    int ret;
    switch (tf->cause) {
ffffffffc0200a28:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200a2c:	1101                	addi	sp,sp,-32
ffffffffc0200a2e:	e822                	sd	s0,16(sp)
ffffffffc0200a30:	ec06                	sd	ra,24(sp)
ffffffffc0200a32:	e426                	sd	s1,8(sp)
ffffffffc0200a34:	473d                	li	a4,15
ffffffffc0200a36:	842a                	mv	s0,a0
ffffffffc0200a38:	16f76163          	bltu	a4,a5,ffffffffc0200b9a <exception_handler+0x172>
ffffffffc0200a3c:	00005717          	auipc	a4,0x5
ffffffffc0200a40:	b9c70713          	addi	a4,a4,-1124 # ffffffffc02055d8 <commands+0x6b8>
ffffffffc0200a44:	078a                	slli	a5,a5,0x2
ffffffffc0200a46:	97ba                	add	a5,a5,a4
ffffffffc0200a48:	439c                	lw	a5,0(a5)
ffffffffc0200a4a:	97ba                	add	a5,a5,a4
ffffffffc0200a4c:	8782                	jr	a5
            //cprintf("Environment call from U-mode\n");
            tf->epc += 4;
            syscall();
            break;
        case CAUSE_SUPERVISOR_ECALL:
            cprintf("Environment call from S-mode\n");
ffffffffc0200a4e:	00005517          	auipc	a0,0x5
ffffffffc0200a52:	ae250513          	addi	a0,a0,-1310 # ffffffffc0205530 <commands+0x610>
ffffffffc0200a56:	e72ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            tf->epc += 4;
ffffffffc0200a5a:	10843783          	ld	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200a5e:	60e2                	ld	ra,24(sp)
ffffffffc0200a60:	64a2                	ld	s1,8(sp)
            tf->epc += 4;
ffffffffc0200a62:	0791                	addi	a5,a5,4
ffffffffc0200a64:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200a68:	6442                	ld	s0,16(sp)
ffffffffc0200a6a:	6105                	addi	sp,sp,32
            syscall();
ffffffffc0200a6c:	4fd0306f          	j	ffffffffc0204768 <syscall>
            cprintf("Environment call from H-mode\n");
ffffffffc0200a70:	00005517          	auipc	a0,0x5
ffffffffc0200a74:	ae050513          	addi	a0,a0,-1312 # ffffffffc0205550 <commands+0x630>
}
ffffffffc0200a78:	6442                	ld	s0,16(sp)
ffffffffc0200a7a:	60e2                	ld	ra,24(sp)
ffffffffc0200a7c:	64a2                	ld	s1,8(sp)
ffffffffc0200a7e:	6105                	addi	sp,sp,32
            cprintf("Instruction access fault\n");
ffffffffc0200a80:	e48ff06f          	j	ffffffffc02000c8 <cprintf>
            cprintf("Environment call from M-mode\n");
ffffffffc0200a84:	00005517          	auipc	a0,0x5
ffffffffc0200a88:	aec50513          	addi	a0,a0,-1300 # ffffffffc0205570 <commands+0x650>
ffffffffc0200a8c:	b7f5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction page fault\n");
ffffffffc0200a8e:	00005517          	auipc	a0,0x5
ffffffffc0200a92:	b0250513          	addi	a0,a0,-1278 # ffffffffc0205590 <commands+0x670>
ffffffffc0200a96:	b7cd                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load page fault\n");
ffffffffc0200a98:	00005517          	auipc	a0,0x5
ffffffffc0200a9c:	b1050513          	addi	a0,a0,-1264 # ffffffffc02055a8 <commands+0x688>
ffffffffc0200aa0:	e28ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200aa4:	8522                	mv	a0,s0
ffffffffc0200aa6:	dddff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200aaa:	84aa                	mv	s1,a0
ffffffffc0200aac:	10051963          	bnez	a0,ffffffffc0200bbe <exception_handler+0x196>
}
ffffffffc0200ab0:	60e2                	ld	ra,24(sp)
ffffffffc0200ab2:	6442                	ld	s0,16(sp)
ffffffffc0200ab4:	64a2                	ld	s1,8(sp)
ffffffffc0200ab6:	6105                	addi	sp,sp,32
ffffffffc0200ab8:	8082                	ret
            cprintf("Store/AMO page fault\n");
ffffffffc0200aba:	00005517          	auipc	a0,0x5
ffffffffc0200abe:	b0650513          	addi	a0,a0,-1274 # ffffffffc02055c0 <commands+0x6a0>
ffffffffc0200ac2:	e06ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200ac6:	8522                	mv	a0,s0
ffffffffc0200ac8:	dbbff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200acc:	84aa                	mv	s1,a0
ffffffffc0200ace:	d16d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200ad0:	8522                	mv	a0,s0
ffffffffc0200ad2:	d4fff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200ad6:	86a6                	mv	a3,s1
ffffffffc0200ad8:	00005617          	auipc	a2,0x5
ffffffffc0200adc:	a0860613          	addi	a2,a2,-1528 # ffffffffc02054e0 <commands+0x5c0>
ffffffffc0200ae0:	0f100593          	li	a1,241
ffffffffc0200ae4:	00005517          	auipc	a0,0x5
ffffffffc0200ae8:	85c50513          	addi	a0,a0,-1956 # ffffffffc0205340 <commands+0x420>
ffffffffc0200aec:	f18ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Instruction address misaligned\n");
ffffffffc0200af0:	00005517          	auipc	a0,0x5
ffffffffc0200af4:	95050513          	addi	a0,a0,-1712 # ffffffffc0205440 <commands+0x520>
ffffffffc0200af8:	b741                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Instruction access fault\n");
ffffffffc0200afa:	00005517          	auipc	a0,0x5
ffffffffc0200afe:	96650513          	addi	a0,a0,-1690 # ffffffffc0205460 <commands+0x540>
ffffffffc0200b02:	bf9d                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Illegal instruction\n");
ffffffffc0200b04:	00005517          	auipc	a0,0x5
ffffffffc0200b08:	97c50513          	addi	a0,a0,-1668 # ffffffffc0205480 <commands+0x560>
ffffffffc0200b0c:	b7b5                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Breakpoint\n");
ffffffffc0200b0e:	00005517          	auipc	a0,0x5
ffffffffc0200b12:	98a50513          	addi	a0,a0,-1654 # ffffffffc0205498 <commands+0x578>
ffffffffc0200b16:	db2ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if(tf->gpr.a7 == 10){
ffffffffc0200b1a:	6458                	ld	a4,136(s0)
ffffffffc0200b1c:	47a9                	li	a5,10
ffffffffc0200b1e:	f8f719e3          	bne	a4,a5,ffffffffc0200ab0 <exception_handler+0x88>
ffffffffc0200b22:	bf25                	j	ffffffffc0200a5a <exception_handler+0x32>
            cprintf("Load address misaligned\n");
ffffffffc0200b24:	00005517          	auipc	a0,0x5
ffffffffc0200b28:	98450513          	addi	a0,a0,-1660 # ffffffffc02054a8 <commands+0x588>
ffffffffc0200b2c:	b7b1                	j	ffffffffc0200a78 <exception_handler+0x50>
            cprintf("Load access fault\n");
ffffffffc0200b2e:	00005517          	auipc	a0,0x5
ffffffffc0200b32:	99a50513          	addi	a0,a0,-1638 # ffffffffc02054c8 <commands+0x5a8>
ffffffffc0200b36:	d92ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b3a:	8522                	mv	a0,s0
ffffffffc0200b3c:	d47ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b40:	84aa                	mv	s1,a0
ffffffffc0200b42:	d53d                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b44:	8522                	mv	a0,s0
ffffffffc0200b46:	cdbff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b4a:	86a6                	mv	a3,s1
ffffffffc0200b4c:	00005617          	auipc	a2,0x5
ffffffffc0200b50:	99460613          	addi	a2,a2,-1644 # ffffffffc02054e0 <commands+0x5c0>
ffffffffc0200b54:	0c600593          	li	a1,198
ffffffffc0200b58:	00004517          	auipc	a0,0x4
ffffffffc0200b5c:	7e850513          	addi	a0,a0,2024 # ffffffffc0205340 <commands+0x420>
ffffffffc0200b60:	ea4ff0ef          	jal	ra,ffffffffc0200204 <__panic>
            cprintf("Store/AMO access fault\n");
ffffffffc0200b64:	00005517          	auipc	a0,0x5
ffffffffc0200b68:	9b450513          	addi	a0,a0,-1612 # ffffffffc0205518 <commands+0x5f8>
ffffffffc0200b6c:	d5cff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            if ((ret = pgfault_handler(tf)) != 0) {
ffffffffc0200b70:	8522                	mv	a0,s0
ffffffffc0200b72:	d11ff0ef          	jal	ra,ffffffffc0200882 <pgfault_handler>
ffffffffc0200b76:	84aa                	mv	s1,a0
ffffffffc0200b78:	dd05                	beqz	a0,ffffffffc0200ab0 <exception_handler+0x88>
                print_trapframe(tf);
ffffffffc0200b7a:	8522                	mv	a0,s0
ffffffffc0200b7c:	ca5ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200b80:	86a6                	mv	a3,s1
ffffffffc0200b82:	00005617          	auipc	a2,0x5
ffffffffc0200b86:	95e60613          	addi	a2,a2,-1698 # ffffffffc02054e0 <commands+0x5c0>
ffffffffc0200b8a:	0d000593          	li	a1,208
ffffffffc0200b8e:	00004517          	auipc	a0,0x4
ffffffffc0200b92:	7b250513          	addi	a0,a0,1970 # ffffffffc0205340 <commands+0x420>
ffffffffc0200b96:	e6eff0ef          	jal	ra,ffffffffc0200204 <__panic>
            print_trapframe(tf);
ffffffffc0200b9a:	8522                	mv	a0,s0
}
ffffffffc0200b9c:	6442                	ld	s0,16(sp)
ffffffffc0200b9e:	60e2                	ld	ra,24(sp)
ffffffffc0200ba0:	64a2                	ld	s1,8(sp)
ffffffffc0200ba2:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200ba4:	b9b5                	j	ffffffffc0200820 <print_trapframe>
            panic("AMO address misaligned\n");
ffffffffc0200ba6:	00005617          	auipc	a2,0x5
ffffffffc0200baa:	95a60613          	addi	a2,a2,-1702 # ffffffffc0205500 <commands+0x5e0>
ffffffffc0200bae:	0ca00593          	li	a1,202
ffffffffc0200bb2:	00004517          	auipc	a0,0x4
ffffffffc0200bb6:	78e50513          	addi	a0,a0,1934 # ffffffffc0205340 <commands+0x420>
ffffffffc0200bba:	e4aff0ef          	jal	ra,ffffffffc0200204 <__panic>
                print_trapframe(tf);
ffffffffc0200bbe:	8522                	mv	a0,s0
ffffffffc0200bc0:	c61ff0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
                panic("handle pgfault failed. %e\n", ret);
ffffffffc0200bc4:	86a6                	mv	a3,s1
ffffffffc0200bc6:	00005617          	auipc	a2,0x5
ffffffffc0200bca:	91a60613          	addi	a2,a2,-1766 # ffffffffc02054e0 <commands+0x5c0>
ffffffffc0200bce:	0ea00593          	li	a1,234
ffffffffc0200bd2:	00004517          	auipc	a0,0x4
ffffffffc0200bd6:	76e50513          	addi	a0,a0,1902 # ffffffffc0205340 <commands+0x420>
ffffffffc0200bda:	e2aff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200bde <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
ffffffffc0200bde:	1101                	addi	sp,sp,-32
ffffffffc0200be0:	e822                	sd	s0,16(sp)

    if (current == NULL) {
ffffffffc0200be2:	00033417          	auipc	s0,0x33
ffffffffc0200be6:	0ce40413          	addi	s0,s0,206 # ffffffffc0233cb0 <current>
ffffffffc0200bea:	6018                	ld	a4,0(s0)
trap(struct trapframe *tf) {
ffffffffc0200bec:	ec06                	sd	ra,24(sp)
ffffffffc0200bee:	e426                	sd	s1,8(sp)
ffffffffc0200bf0:	e04a                	sd	s2,0(sp)
ffffffffc0200bf2:	11853683          	ld	a3,280(a0)
    if (current == NULL) {
ffffffffc0200bf6:	cf1d                	beqz	a4,ffffffffc0200c34 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200bf8:	10053483          	ld	s1,256(a0)
        trap_dispatch(tf);
    } else {
        struct trapframe *otf = current->tf;
ffffffffc0200bfc:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200c00:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200c02:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c06:	0206c463          	bltz	a3,ffffffffc0200c2e <trap+0x50>
        exception_handler(tf);
ffffffffc0200c0a:	e1fff0ef          	jal	ra,ffffffffc0200a28 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200c0e:	601c                	ld	a5,0(s0)
ffffffffc0200c10:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel) {
ffffffffc0200c14:	e499                	bnez	s1,ffffffffc0200c22 <trap+0x44>
            if (current->flags & PF_EXITING) {
ffffffffc0200c16:	0b07a703          	lw	a4,176(a5)
ffffffffc0200c1a:	8b05                	andi	a4,a4,1
ffffffffc0200c1c:	e329                	bnez	a4,ffffffffc0200c5e <trap+0x80>
                do_exit(-E_KILLED);
            }
            if (current->need_resched) {
ffffffffc0200c1e:	6f9c                	ld	a5,24(a5)
ffffffffc0200c20:	eb85                	bnez	a5,ffffffffc0200c50 <trap+0x72>
                schedule();
            }
        }
    }
}
ffffffffc0200c22:	60e2                	ld	ra,24(sp)
ffffffffc0200c24:	6442                	ld	s0,16(sp)
ffffffffc0200c26:	64a2                	ld	s1,8(sp)
ffffffffc0200c28:	6902                	ld	s2,0(sp)
ffffffffc0200c2a:	6105                	addi	sp,sp,32
ffffffffc0200c2c:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200c2e:	d6fff0ef          	jal	ra,ffffffffc020099c <interrupt_handler>
ffffffffc0200c32:	bff1                	j	ffffffffc0200c0e <trap+0x30>
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c34:	0006c863          	bltz	a3,ffffffffc0200c44 <trap+0x66>
}
ffffffffc0200c38:	6442                	ld	s0,16(sp)
ffffffffc0200c3a:	60e2                	ld	ra,24(sp)
ffffffffc0200c3c:	64a2                	ld	s1,8(sp)
ffffffffc0200c3e:	6902                	ld	s2,0(sp)
ffffffffc0200c40:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200c42:	b3dd                	j	ffffffffc0200a28 <exception_handler>
}
ffffffffc0200c44:	6442                	ld	s0,16(sp)
ffffffffc0200c46:	60e2                	ld	ra,24(sp)
ffffffffc0200c48:	64a2                	ld	s1,8(sp)
ffffffffc0200c4a:	6902                	ld	s2,0(sp)
ffffffffc0200c4c:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200c4e:	b3b9                	j	ffffffffc020099c <interrupt_handler>
}
ffffffffc0200c50:	6442                	ld	s0,16(sp)
ffffffffc0200c52:	60e2                	ld	ra,24(sp)
ffffffffc0200c54:	64a2                	ld	s1,8(sp)
ffffffffc0200c56:	6902                	ld	s2,0(sp)
ffffffffc0200c58:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200c5a:	1250306f          	j	ffffffffc020457e <schedule>
                do_exit(-E_KILLED);
ffffffffc0200c5e:	555d                	li	a0,-9
ffffffffc0200c60:	51f020ef          	jal	ra,ffffffffc020397e <do_exit>
ffffffffc0200c64:	601c                	ld	a5,0(s0)
ffffffffc0200c66:	bf65                	j	ffffffffc0200c1e <trap+0x40>

ffffffffc0200c68 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200c68:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200c6c:	00011463          	bnez	sp,ffffffffc0200c74 <__alltraps+0xc>
ffffffffc0200c70:	14002173          	csrr	sp,sscratch
ffffffffc0200c74:	712d                	addi	sp,sp,-288
ffffffffc0200c76:	e002                	sd	zero,0(sp)
ffffffffc0200c78:	e406                	sd	ra,8(sp)
ffffffffc0200c7a:	ec0e                	sd	gp,24(sp)
ffffffffc0200c7c:	f012                	sd	tp,32(sp)
ffffffffc0200c7e:	f416                	sd	t0,40(sp)
ffffffffc0200c80:	f81a                	sd	t1,48(sp)
ffffffffc0200c82:	fc1e                	sd	t2,56(sp)
ffffffffc0200c84:	e0a2                	sd	s0,64(sp)
ffffffffc0200c86:	e4a6                	sd	s1,72(sp)
ffffffffc0200c88:	e8aa                	sd	a0,80(sp)
ffffffffc0200c8a:	ecae                	sd	a1,88(sp)
ffffffffc0200c8c:	f0b2                	sd	a2,96(sp)
ffffffffc0200c8e:	f4b6                	sd	a3,104(sp)
ffffffffc0200c90:	f8ba                	sd	a4,112(sp)
ffffffffc0200c92:	fcbe                	sd	a5,120(sp)
ffffffffc0200c94:	e142                	sd	a6,128(sp)
ffffffffc0200c96:	e546                	sd	a7,136(sp)
ffffffffc0200c98:	e94a                	sd	s2,144(sp)
ffffffffc0200c9a:	ed4e                	sd	s3,152(sp)
ffffffffc0200c9c:	f152                	sd	s4,160(sp)
ffffffffc0200c9e:	f556                	sd	s5,168(sp)
ffffffffc0200ca0:	f95a                	sd	s6,176(sp)
ffffffffc0200ca2:	fd5e                	sd	s7,184(sp)
ffffffffc0200ca4:	e1e2                	sd	s8,192(sp)
ffffffffc0200ca6:	e5e6                	sd	s9,200(sp)
ffffffffc0200ca8:	e9ea                	sd	s10,208(sp)
ffffffffc0200caa:	edee                	sd	s11,216(sp)
ffffffffc0200cac:	f1f2                	sd	t3,224(sp)
ffffffffc0200cae:	f5f6                	sd	t4,232(sp)
ffffffffc0200cb0:	f9fa                	sd	t5,240(sp)
ffffffffc0200cb2:	fdfe                	sd	t6,248(sp)
ffffffffc0200cb4:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200cb8:	100024f3          	csrr	s1,sstatus
ffffffffc0200cbc:	14102973          	csrr	s2,sepc
ffffffffc0200cc0:	143029f3          	csrr	s3,stval
ffffffffc0200cc4:	14202a73          	csrr	s4,scause
ffffffffc0200cc8:	e822                	sd	s0,16(sp)
ffffffffc0200cca:	e226                	sd	s1,256(sp)
ffffffffc0200ccc:	e64a                	sd	s2,264(sp)
ffffffffc0200cce:	ea4e                	sd	s3,272(sp)
ffffffffc0200cd0:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200cd2:	850a                	mv	a0,sp
    jal trap
ffffffffc0200cd4:	f0bff0ef          	jal	ra,ffffffffc0200bde <trap>

ffffffffc0200cd8 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200cd8:	6492                	ld	s1,256(sp)
ffffffffc0200cda:	6932                	ld	s2,264(sp)
ffffffffc0200cdc:	1004f413          	andi	s0,s1,256
ffffffffc0200ce0:	e401                	bnez	s0,ffffffffc0200ce8 <__trapret+0x10>
ffffffffc0200ce2:	1200                	addi	s0,sp,288
ffffffffc0200ce4:	14041073          	csrw	sscratch,s0
ffffffffc0200ce8:	10049073          	csrw	sstatus,s1
ffffffffc0200cec:	14191073          	csrw	sepc,s2
ffffffffc0200cf0:	60a2                	ld	ra,8(sp)
ffffffffc0200cf2:	61e2                	ld	gp,24(sp)
ffffffffc0200cf4:	7202                	ld	tp,32(sp)
ffffffffc0200cf6:	72a2                	ld	t0,40(sp)
ffffffffc0200cf8:	7342                	ld	t1,48(sp)
ffffffffc0200cfa:	73e2                	ld	t2,56(sp)
ffffffffc0200cfc:	6406                	ld	s0,64(sp)
ffffffffc0200cfe:	64a6                	ld	s1,72(sp)
ffffffffc0200d00:	6546                	ld	a0,80(sp)
ffffffffc0200d02:	65e6                	ld	a1,88(sp)
ffffffffc0200d04:	7606                	ld	a2,96(sp)
ffffffffc0200d06:	76a6                	ld	a3,104(sp)
ffffffffc0200d08:	7746                	ld	a4,112(sp)
ffffffffc0200d0a:	77e6                	ld	a5,120(sp)
ffffffffc0200d0c:	680a                	ld	a6,128(sp)
ffffffffc0200d0e:	68aa                	ld	a7,136(sp)
ffffffffc0200d10:	694a                	ld	s2,144(sp)
ffffffffc0200d12:	69ea                	ld	s3,152(sp)
ffffffffc0200d14:	7a0a                	ld	s4,160(sp)
ffffffffc0200d16:	7aaa                	ld	s5,168(sp)
ffffffffc0200d18:	7b4a                	ld	s6,176(sp)
ffffffffc0200d1a:	7bea                	ld	s7,184(sp)
ffffffffc0200d1c:	6c0e                	ld	s8,192(sp)
ffffffffc0200d1e:	6cae                	ld	s9,200(sp)
ffffffffc0200d20:	6d4e                	ld	s10,208(sp)
ffffffffc0200d22:	6dee                	ld	s11,216(sp)
ffffffffc0200d24:	7e0e                	ld	t3,224(sp)
ffffffffc0200d26:	7eae                	ld	t4,232(sp)
ffffffffc0200d28:	7f4e                	ld	t5,240(sp)
ffffffffc0200d2a:	7fee                	ld	t6,248(sp)
ffffffffc0200d2c:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200d2e:	10200073          	sret

ffffffffc0200d32 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200d32:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200d34:	b755                	j	ffffffffc0200cd8 <__trapret>

ffffffffc0200d36 <pa2page.part.0>:
page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
}

static inline struct Page *
pa2page(uintptr_t pa) {
ffffffffc0200d36:	1141                	addi	sp,sp,-16
    if (PPN(pa) >= npage) {
        panic("pa2page called with invalid pa");
ffffffffc0200d38:	00005617          	auipc	a2,0x5
ffffffffc0200d3c:	8e060613          	addi	a2,a2,-1824 # ffffffffc0205618 <commands+0x6f8>
ffffffffc0200d40:	06200593          	li	a1,98
ffffffffc0200d44:	00005517          	auipc	a0,0x5
ffffffffc0200d48:	8f450513          	addi	a0,a0,-1804 # ffffffffc0205638 <commands+0x718>
pa2page(uintptr_t pa) {
ffffffffc0200d4c:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0200d4e:	cb6ff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0200d52 <alloc_pages>:
    pmm_manager->init_memmap(base, n);
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
ffffffffc0200d52:	7139                	addi	sp,sp,-64
ffffffffc0200d54:	f426                	sd	s1,40(sp)
ffffffffc0200d56:	f04a                	sd	s2,32(sp)
ffffffffc0200d58:	ec4e                	sd	s3,24(sp)
ffffffffc0200d5a:	e852                	sd	s4,16(sp)
ffffffffc0200d5c:	e456                	sd	s5,8(sp)
ffffffffc0200d5e:	e05a                	sd	s6,0(sp)
ffffffffc0200d60:	fc06                	sd	ra,56(sp)
ffffffffc0200d62:	f822                	sd	s0,48(sp)
ffffffffc0200d64:	84aa                	mv	s1,a0
ffffffffc0200d66:	00033917          	auipc	s2,0x33
ffffffffc0200d6a:	f8290913          	addi	s2,s2,-126 # ffffffffc0233ce8 <pmm_manager>
        {
            page = pmm_manager->alloc_pages(n);
        }
        local_intr_restore(intr_flag);

        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d6e:	4a05                	li	s4,1
ffffffffc0200d70:	00033a97          	auipc	s5,0x33
ffffffffc0200d74:	f38a8a93          	addi	s5,s5,-200 # ffffffffc0233ca8 <swap_init_ok>

        extern struct mm_struct *check_mm_struct;
        // cprintf("page %x, call swap_out in alloc_pages %d\n",page, n);
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d78:	0005099b          	sext.w	s3,a0
ffffffffc0200d7c:	00033b17          	auipc	s6,0x33
ffffffffc0200d80:	f9cb0b13          	addi	s6,s6,-100 # ffffffffc0233d18 <check_mm_struct>
ffffffffc0200d84:	a01d                	j	ffffffffc0200daa <alloc_pages+0x58>
            page = pmm_manager->alloc_pages(n);
ffffffffc0200d86:	00093783          	ld	a5,0(s2)
ffffffffc0200d8a:	6f9c                	ld	a5,24(a5)
ffffffffc0200d8c:	9782                	jalr	a5
ffffffffc0200d8e:	842a                	mv	s0,a0
        swap_out(check_mm_struct, n, 0);
ffffffffc0200d90:	4601                	li	a2,0
ffffffffc0200d92:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200d94:	ec0d                	bnez	s0,ffffffffc0200dce <alloc_pages+0x7c>
ffffffffc0200d96:	029a6c63          	bltu	s4,s1,ffffffffc0200dce <alloc_pages+0x7c>
ffffffffc0200d9a:	000aa783          	lw	a5,0(s5)
ffffffffc0200d9e:	2781                	sext.w	a5,a5
ffffffffc0200da0:	c79d                	beqz	a5,ffffffffc0200dce <alloc_pages+0x7c>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200da2:	000b3503          	ld	a0,0(s6)
ffffffffc0200da6:	6d4010ef          	jal	ra,ffffffffc020247a <swap_out>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200daa:	100027f3          	csrr	a5,sstatus
ffffffffc0200dae:	8b89                	andi	a5,a5,2
            page = pmm_manager->alloc_pages(n);
ffffffffc0200db0:	8526                	mv	a0,s1
ffffffffc0200db2:	dbf1                	beqz	a5,ffffffffc0200d86 <alloc_pages+0x34>
        intr_disable();
ffffffffc0200db4:	87fff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
ffffffffc0200db8:	00093783          	ld	a5,0(s2)
ffffffffc0200dbc:	8526                	mv	a0,s1
ffffffffc0200dbe:	6f9c                	ld	a5,24(a5)
ffffffffc0200dc0:	9782                	jalr	a5
ffffffffc0200dc2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200dc4:	869ff0ef          	jal	ra,ffffffffc020062c <intr_enable>
        swap_out(check_mm_struct, n, 0);
ffffffffc0200dc8:	4601                	li	a2,0
ffffffffc0200dca:	85ce                	mv	a1,s3
        if (page != NULL || n > 1 || swap_init_ok == 0) break;
ffffffffc0200dcc:	d469                	beqz	s0,ffffffffc0200d96 <alloc_pages+0x44>
    }
    // cprintf("n %d,get page %x, No %d in alloc_pages\n",n,page,(page-pages));
    return page;
}
ffffffffc0200dce:	70e2                	ld	ra,56(sp)
ffffffffc0200dd0:	8522                	mv	a0,s0
ffffffffc0200dd2:	7442                	ld	s0,48(sp)
ffffffffc0200dd4:	74a2                	ld	s1,40(sp)
ffffffffc0200dd6:	7902                	ld	s2,32(sp)
ffffffffc0200dd8:	69e2                	ld	s3,24(sp)
ffffffffc0200dda:	6a42                	ld	s4,16(sp)
ffffffffc0200ddc:	6aa2                	ld	s5,8(sp)
ffffffffc0200dde:	6b02                	ld	s6,0(sp)
ffffffffc0200de0:	6121                	addi	sp,sp,64
ffffffffc0200de2:	8082                	ret

ffffffffc0200de4 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200de4:	100027f3          	csrr	a5,sstatus
ffffffffc0200de8:	8b89                	andi	a5,a5,2
ffffffffc0200dea:	eb81                	bnez	a5,ffffffffc0200dfa <free_pages+0x16>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0200dec:	00033797          	auipc	a5,0x33
ffffffffc0200df0:	efc7b783          	ld	a5,-260(a5) # ffffffffc0233ce8 <pmm_manager>
ffffffffc0200df4:	0207b303          	ld	t1,32(a5)
ffffffffc0200df8:	8302                	jr	t1
void free_pages(struct Page *base, size_t n) {
ffffffffc0200dfa:	1101                	addi	sp,sp,-32
ffffffffc0200dfc:	ec06                	sd	ra,24(sp)
ffffffffc0200dfe:	e822                	sd	s0,16(sp)
ffffffffc0200e00:	e426                	sd	s1,8(sp)
ffffffffc0200e02:	842a                	mv	s0,a0
ffffffffc0200e04:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0200e06:	82dff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0200e0a:	00033797          	auipc	a5,0x33
ffffffffc0200e0e:	ede7b783          	ld	a5,-290(a5) # ffffffffc0233ce8 <pmm_manager>
ffffffffc0200e12:	739c                	ld	a5,32(a5)
ffffffffc0200e14:	85a6                	mv	a1,s1
ffffffffc0200e16:	8522                	mv	a0,s0
ffffffffc0200e18:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0200e1a:	6442                	ld	s0,16(sp)
ffffffffc0200e1c:	60e2                	ld	ra,24(sp)
ffffffffc0200e1e:	64a2                	ld	s1,8(sp)
ffffffffc0200e20:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0200e22:	80bff06f          	j	ffffffffc020062c <intr_enable>

ffffffffc0200e26 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0200e26:	100027f3          	csrr	a5,sstatus
ffffffffc0200e2a:	8b89                	andi	a5,a5,2
ffffffffc0200e2c:	eb81                	bnez	a5,ffffffffc0200e3c <nr_free_pages+0x16>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0200e2e:	00033797          	auipc	a5,0x33
ffffffffc0200e32:	eba7b783          	ld	a5,-326(a5) # ffffffffc0233ce8 <pmm_manager>
ffffffffc0200e36:	0287b303          	ld	t1,40(a5)
ffffffffc0200e3a:	8302                	jr	t1
size_t nr_free_pages(void) {
ffffffffc0200e3c:	1141                	addi	sp,sp,-16
ffffffffc0200e3e:	e406                	sd	ra,8(sp)
ffffffffc0200e40:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0200e42:	ff0ff0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0200e46:	00033797          	auipc	a5,0x33
ffffffffc0200e4a:	ea27b783          	ld	a5,-350(a5) # ffffffffc0233ce8 <pmm_manager>
ffffffffc0200e4e:	779c                	ld	a5,40(a5)
ffffffffc0200e50:	9782                	jalr	a5
ffffffffc0200e52:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0200e54:	fd8ff0ef          	jal	ra,ffffffffc020062c <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0200e58:	60a2                	ld	ra,8(sp)
ffffffffc0200e5a:	8522                	mv	a0,s0
ffffffffc0200e5c:	6402                	ld	s0,0(sp)
ffffffffc0200e5e:	0141                	addi	sp,sp,16
ffffffffc0200e60:	8082                	ret

ffffffffc0200e62 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0200e62:	00005797          	auipc	a5,0x5
ffffffffc0200e66:	20678793          	addi	a5,a5,518 # ffffffffc0206068 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e6a:	638c                	ld	a1,0(a5)
}

// pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup
// paging mechanism
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void pmm_init(void) {
ffffffffc0200e6c:	1101                	addi	sp,sp,-32
ffffffffc0200e6e:	e426                	sd	s1,8(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e70:	00004517          	auipc	a0,0x4
ffffffffc0200e74:	7d850513          	addi	a0,a0,2008 # ffffffffc0205648 <commands+0x728>
    pmm_manager = &default_pmm_manager;
ffffffffc0200e78:	00033497          	auipc	s1,0x33
ffffffffc0200e7c:	e7048493          	addi	s1,s1,-400 # ffffffffc0233ce8 <pmm_manager>
void pmm_init(void) {
ffffffffc0200e80:	ec06                	sd	ra,24(sp)
ffffffffc0200e82:	e822                	sd	s0,16(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0200e84:	e09c                	sd	a5,0(s1)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0200e86:	a42ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pmm_manager->init();
ffffffffc0200e8a:	609c                	ld	a5,0(s1)
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e8c:	00033417          	auipc	s0,0x33
ffffffffc0200e90:	e6440413          	addi	s0,s0,-412 # ffffffffc0233cf0 <va_pa_offset>
    pmm_manager->init();
ffffffffc0200e94:	679c                	ld	a5,8(a5)
ffffffffc0200e96:	9782                	jalr	a5
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200e98:	57f5                	li	a5,-3
ffffffffc0200e9a:	07fa                	slli	a5,a5,0x1e
    cprintf("physcial memory map:\n");
ffffffffc0200e9c:	00004517          	auipc	a0,0x4
ffffffffc0200ea0:	7c450513          	addi	a0,a0,1988 # ffffffffc0205660 <commands+0x740>
    va_pa_offset = KERNBASE - 0x80200000;
ffffffffc0200ea4:	e01c                	sd	a5,0(s0)
    cprintf("physcial memory map:\n");
ffffffffc0200ea6:	a22ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0200eaa:	44300693          	li	a3,1091
ffffffffc0200eae:	06d6                	slli	a3,a3,0x15
ffffffffc0200eb0:	40100613          	li	a2,1025
ffffffffc0200eb4:	0656                	slli	a2,a2,0x15
ffffffffc0200eb6:	088005b7          	lui	a1,0x8800
ffffffffc0200eba:	16fd                	addi	a3,a3,-1
ffffffffc0200ebc:	00004517          	auipc	a0,0x4
ffffffffc0200ec0:	7bc50513          	addi	a0,a0,1980 # ffffffffc0205678 <commands+0x758>
ffffffffc0200ec4:	a04ff0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200ec8:	777d                	lui	a4,0xfffff
ffffffffc0200eca:	00034797          	auipc	a5,0x34
ffffffffc0200ece:	f4578793          	addi	a5,a5,-187 # ffffffffc0234e0f <end+0xfff>
ffffffffc0200ed2:	8ff9                	and	a5,a5,a4
    npage = maxpa / PGSIZE;
ffffffffc0200ed4:	00088737          	lui	a4,0x88
ffffffffc0200ed8:	60070713          	addi	a4,a4,1536 # 88600 <_binary_obj___user_rr_out_size+0x7dc00>
ffffffffc0200edc:	00033597          	auipc	a1,0x33
ffffffffc0200ee0:	dac58593          	addi	a1,a1,-596 # ffffffffc0233c88 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200ee4:	00033617          	auipc	a2,0x33
ffffffffc0200ee8:	e1c60613          	addi	a2,a2,-484 # ffffffffc0233d00 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0200eec:	e198                	sd	a4,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0200eee:	e21c                	sd	a5,0(a2)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200ef0:	4701                	li	a4,0
 *
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void set_bit(int nr, volatile void *addr) {
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0200ef2:	4505                	li	a0,1
ffffffffc0200ef4:	fff80837          	lui	a6,0xfff80
ffffffffc0200ef8:	a011                	j	ffffffffc0200efc <pmm_init+0x9a>
ffffffffc0200efa:	621c                	ld	a5,0(a2)
        SetPageReserved(pages + i);
ffffffffc0200efc:	00671693          	slli	a3,a4,0x6
ffffffffc0200f00:	97b6                	add	a5,a5,a3
ffffffffc0200f02:	07a1                	addi	a5,a5,8
ffffffffc0200f04:	40a7b02f          	amoor.d	zero,a0,(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0200f08:	0005b883          	ld	a7,0(a1)
ffffffffc0200f0c:	0705                	addi	a4,a4,1
ffffffffc0200f0e:	010886b3          	add	a3,a7,a6
ffffffffc0200f12:	fed764e3          	bltu	a4,a3,ffffffffc0200efa <pmm_init+0x98>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f16:	6208                	ld	a0,0(a2)
ffffffffc0200f18:	069a                	slli	a3,a3,0x6
ffffffffc0200f1a:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f1e:	96aa                	add	a3,a3,a0
ffffffffc0200f20:	06f6e263          	bltu	a3,a5,ffffffffc0200f84 <pmm_init+0x122>
ffffffffc0200f24:	601c                	ld	a5,0(s0)
    if (freemem < mem_end) {
ffffffffc0200f26:	44300593          	li	a1,1091
ffffffffc0200f2a:	05d6                	slli	a1,a1,0x15
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f2c:	8e9d                	sub	a3,a3,a5
    if (freemem < mem_end) {
ffffffffc0200f2e:	02b6f363          	bgeu	a3,a1,ffffffffc0200f54 <pmm_init+0xf2>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0200f32:	6785                	lui	a5,0x1
ffffffffc0200f34:	17fd                	addi	a5,a5,-1
ffffffffc0200f36:	96be                	add	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0200f38:	00c6d793          	srli	a5,a3,0xc
ffffffffc0200f3c:	0717fc63          	bgeu	a5,a7,ffffffffc0200fb4 <pmm_init+0x152>
    pmm_manager->init_memmap(base, n);
ffffffffc0200f40:	6098                	ld	a4,0(s1)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f42:	767d                	lui	a2,0xfffff
ffffffffc0200f44:	8ef1                	and	a3,a3,a2
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200f46:	97c2                	add	a5,a5,a6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f48:	6b18                	ld	a4,16(a4)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0200f4a:	8d95                	sub	a1,a1,a3
ffffffffc0200f4c:	079a                	slli	a5,a5,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0200f4e:	81b1                	srli	a1,a1,0xc
ffffffffc0200f50:	953e                	add	a0,a0,a5
ffffffffc0200f52:	9702                	jalr	a4
    // pmm
    //check_alloc_page();

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    extern char boot_page_table_sv39[];
    boot_pgdir = (pte_t*)boot_page_table_sv39;
ffffffffc0200f54:	00008697          	auipc	a3,0x8
ffffffffc0200f58:	0ac68693          	addi	a3,a3,172 # ffffffffc0209000 <boot_page_table_sv39>
ffffffffc0200f5c:	00033797          	auipc	a5,0x33
ffffffffc0200f60:	d2d7b223          	sd	a3,-732(a5) # ffffffffc0233c80 <boot_pgdir>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f64:	c02007b7          	lui	a5,0xc0200
ffffffffc0200f68:	02f6ea63          	bltu	a3,a5,ffffffffc0200f9c <pmm_init+0x13a>
ffffffffc0200f6c:	601c                	ld	a5,0(s0)
    // check the correctness of the basic virtual memory map.
    //check_boot_pgdir();


    kmalloc_init();
}
ffffffffc0200f6e:	6442                	ld	s0,16(sp)
ffffffffc0200f70:	60e2                	ld	ra,24(sp)
ffffffffc0200f72:	64a2                	ld	s1,8(sp)
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f74:	8e9d                	sub	a3,a3,a5
ffffffffc0200f76:	00033797          	auipc	a5,0x33
ffffffffc0200f7a:	d8d7b123          	sd	a3,-638(a5) # ffffffffc0233cf8 <boot_cr3>
}
ffffffffc0200f7e:	6105                	addi	sp,sp,32
    kmalloc_init();
ffffffffc0200f80:	2ac0106f          	j	ffffffffc020222c <kmalloc_init>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0200f84:	00004617          	auipc	a2,0x4
ffffffffc0200f88:	71c60613          	addi	a2,a2,1820 # ffffffffc02056a0 <commands+0x780>
ffffffffc0200f8c:	07f00593          	li	a1,127
ffffffffc0200f90:	00004517          	auipc	a0,0x4
ffffffffc0200f94:	73850513          	addi	a0,a0,1848 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0200f98:	a6cff0ef          	jal	ra,ffffffffc0200204 <__panic>
    boot_cr3 = PADDR(boot_pgdir);
ffffffffc0200f9c:	00004617          	auipc	a2,0x4
ffffffffc0200fa0:	70460613          	addi	a2,a2,1796 # ffffffffc02056a0 <commands+0x780>
ffffffffc0200fa4:	0c100593          	li	a1,193
ffffffffc0200fa8:	00004517          	auipc	a0,0x4
ffffffffc0200fac:	72050513          	addi	a0,a0,1824 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0200fb0:	a54ff0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0200fb4:	d83ff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc0200fb8 <get_pte>:
     *   PTE_W           0x002                   // page table/directory entry
     * flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry
     * flags bit : User can access
     */
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fb8:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200fbc:	1ff7f793          	andi	a5,a5,511
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fc0:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fc2:	078e                	slli	a5,a5,0x3
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fc4:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0200fc6:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fca:	6094                	ld	a3,0(s1)
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fcc:	f04a                	sd	s2,32(sp)
ffffffffc0200fce:	ec4e                	sd	s3,24(sp)
ffffffffc0200fd0:	e852                	sd	s4,16(sp)
ffffffffc0200fd2:	fc06                	sd	ra,56(sp)
ffffffffc0200fd4:	f822                	sd	s0,48(sp)
ffffffffc0200fd6:	e456                	sd	s5,8(sp)
ffffffffc0200fd8:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fda:	0016f793          	andi	a5,a3,1
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create) {
ffffffffc0200fde:	892e                	mv	s2,a1
ffffffffc0200fe0:	89b2                	mv	s3,a2
ffffffffc0200fe2:	00033a17          	auipc	s4,0x33
ffffffffc0200fe6:	ca6a0a13          	addi	s4,s4,-858 # ffffffffc0233c88 <npage>
    if (!(*pdep1 & PTE_V)) {
ffffffffc0200fea:	e7b5                	bnez	a5,ffffffffc0201056 <get_pte+0x9e>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc0200fec:	12060b63          	beqz	a2,ffffffffc0201122 <get_pte+0x16a>
ffffffffc0200ff0:	4505                	li	a0,1
ffffffffc0200ff2:	d61ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0200ff6:	842a                	mv	s0,a0
ffffffffc0200ff8:	12050563          	beqz	a0,ffffffffc0201122 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc0200ffc:	00033b17          	auipc	s6,0x33
ffffffffc0201000:	d04b0b13          	addi	s6,s6,-764 # ffffffffc0233d00 <pages>
ffffffffc0201004:	000b3503          	ld	a0,0(s6)
ffffffffc0201008:	00080ab7          	lui	s5,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020100c:	00033a17          	auipc	s4,0x33
ffffffffc0201010:	c7ca0a13          	addi	s4,s4,-900 # ffffffffc0233c88 <npage>
ffffffffc0201014:	40a40533          	sub	a0,s0,a0
ffffffffc0201018:	8519                	srai	a0,a0,0x6
ffffffffc020101a:	9556                	add	a0,a0,s5
ffffffffc020101c:	000a3703          	ld	a4,0(s4)
ffffffffc0201020:	00c51793          	slli	a5,a0,0xc
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
ffffffffc0201024:	4685                	li	a3,1
ffffffffc0201026:	c014                	sw	a3,0(s0)
ffffffffc0201028:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020102a:	0532                	slli	a0,a0,0xc
ffffffffc020102c:	14e7f263          	bgeu	a5,a4,ffffffffc0201170 <get_pte+0x1b8>
ffffffffc0201030:	00033797          	auipc	a5,0x33
ffffffffc0201034:	cc07b783          	ld	a5,-832(a5) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0201038:	6605                	lui	a2,0x1
ffffffffc020103a:	4581                	li	a1,0
ffffffffc020103c:	953e                	add	a0,a0,a5
ffffffffc020103e:	015030ef          	jal	ra,ffffffffc0204852 <memset>
    return page - pages + nbase;
ffffffffc0201042:	000b3683          	ld	a3,0(s6)
ffffffffc0201046:	40d406b3          	sub	a3,s0,a3
ffffffffc020104a:	8699                	srai	a3,a3,0x6
ffffffffc020104c:	96d6                	add	a3,a3,s5
  asm volatile("sfence.vm");
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type) {
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020104e:	06aa                	slli	a3,a3,0xa
ffffffffc0201050:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201054:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201056:	77fd                	lui	a5,0xfffff
ffffffffc0201058:	068a                	slli	a3,a3,0x2
ffffffffc020105a:	000a3703          	ld	a4,0(s4)
ffffffffc020105e:	8efd                	and	a3,a3,a5
ffffffffc0201060:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201064:	0ce7f163          	bgeu	a5,a4,ffffffffc0201126 <get_pte+0x16e>
ffffffffc0201068:	00033a97          	auipc	s5,0x33
ffffffffc020106c:	c88a8a93          	addi	s5,s5,-888 # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0201070:	000ab403          	ld	s0,0(s5)
ffffffffc0201074:	01595793          	srli	a5,s2,0x15
ffffffffc0201078:	1ff7f793          	andi	a5,a5,511
ffffffffc020107c:	96a2                	add	a3,a3,s0
ffffffffc020107e:	00379413          	slli	s0,a5,0x3
ffffffffc0201082:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V)) {
ffffffffc0201084:	6014                	ld	a3,0(s0)
ffffffffc0201086:	0016f793          	andi	a5,a3,1
ffffffffc020108a:	e3ad                	bnez	a5,ffffffffc02010ec <get_pte+0x134>
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
ffffffffc020108c:	08098b63          	beqz	s3,ffffffffc0201122 <get_pte+0x16a>
ffffffffc0201090:	4505                	li	a0,1
ffffffffc0201092:	cc1ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0201096:	84aa                	mv	s1,a0
ffffffffc0201098:	c549                	beqz	a0,ffffffffc0201122 <get_pte+0x16a>
    return page - pages + nbase;
ffffffffc020109a:	00033b17          	auipc	s6,0x33
ffffffffc020109e:	c66b0b13          	addi	s6,s6,-922 # ffffffffc0233d00 <pages>
ffffffffc02010a2:	000b3503          	ld	a0,0(s6)
ffffffffc02010a6:	000809b7          	lui	s3,0x80
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc02010aa:	000a3703          	ld	a4,0(s4)
ffffffffc02010ae:	40a48533          	sub	a0,s1,a0
ffffffffc02010b2:	8519                	srai	a0,a0,0x6
ffffffffc02010b4:	954e                	add	a0,a0,s3
ffffffffc02010b6:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc02010ba:	4685                	li	a3,1
ffffffffc02010bc:	c094                	sw	a3,0(s1)
ffffffffc02010be:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02010c0:	0532                	slli	a0,a0,0xc
ffffffffc02010c2:	08e7fa63          	bgeu	a5,a4,ffffffffc0201156 <get_pte+0x19e>
ffffffffc02010c6:	000ab783          	ld	a5,0(s5)
ffffffffc02010ca:	6605                	lui	a2,0x1
ffffffffc02010cc:	4581                	li	a1,0
ffffffffc02010ce:	953e                	add	a0,a0,a5
ffffffffc02010d0:	782030ef          	jal	ra,ffffffffc0204852 <memset>
    return page - pages + nbase;
ffffffffc02010d4:	000b3683          	ld	a3,0(s6)
ffffffffc02010d8:	40d486b3          	sub	a3,s1,a3
ffffffffc02010dc:	8699                	srai	a3,a3,0x6
ffffffffc02010de:	96ce                	add	a3,a3,s3
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02010e0:	06aa                	slli	a3,a3,0xa
ffffffffc02010e2:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02010e6:	e014                	sd	a3,0(s0)
ffffffffc02010e8:	000a3703          	ld	a4,0(s4)
        }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02010ec:	068a                	slli	a3,a3,0x2
ffffffffc02010ee:	757d                	lui	a0,0xfffff
ffffffffc02010f0:	8ee9                	and	a3,a3,a0
ffffffffc02010f2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02010f6:	04e7f463          	bgeu	a5,a4,ffffffffc020113e <get_pte+0x186>
ffffffffc02010fa:	000ab503          	ld	a0,0(s5)
ffffffffc02010fe:	00c95913          	srli	s2,s2,0xc
ffffffffc0201102:	1ff97913          	andi	s2,s2,511
ffffffffc0201106:	96aa                	add	a3,a3,a0
ffffffffc0201108:	00391513          	slli	a0,s2,0x3
ffffffffc020110c:	9536                	add	a0,a0,a3
}
ffffffffc020110e:	70e2                	ld	ra,56(sp)
ffffffffc0201110:	7442                	ld	s0,48(sp)
ffffffffc0201112:	74a2                	ld	s1,40(sp)
ffffffffc0201114:	7902                	ld	s2,32(sp)
ffffffffc0201116:	69e2                	ld	s3,24(sp)
ffffffffc0201118:	6a42                	ld	s4,16(sp)
ffffffffc020111a:	6aa2                	ld	s5,8(sp)
ffffffffc020111c:	6b02                	ld	s6,0(sp)
ffffffffc020111e:	6121                	addi	sp,sp,64
ffffffffc0201120:	8082                	ret
            return NULL;
ffffffffc0201122:	4501                	li	a0,0
ffffffffc0201124:	b7ed                	j	ffffffffc020110e <get_pte+0x156>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201126:	00004617          	auipc	a2,0x4
ffffffffc020112a:	5b260613          	addi	a2,a2,1458 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc020112e:	0fe00593          	li	a1,254
ffffffffc0201132:	00004517          	auipc	a0,0x4
ffffffffc0201136:	59650513          	addi	a0,a0,1430 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc020113a:	8caff0ef          	jal	ra,ffffffffc0200204 <__panic>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020113e:	00004617          	auipc	a2,0x4
ffffffffc0201142:	59a60613          	addi	a2,a2,1434 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc0201146:	10900593          	li	a1,265
ffffffffc020114a:	00004517          	auipc	a0,0x4
ffffffffc020114e:	57e50513          	addi	a0,a0,1406 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201152:	8b2ff0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201156:	86aa                	mv	a3,a0
ffffffffc0201158:	00004617          	auipc	a2,0x4
ffffffffc020115c:	58060613          	addi	a2,a2,1408 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc0201160:	10600593          	li	a1,262
ffffffffc0201164:	00004517          	auipc	a0,0x4
ffffffffc0201168:	56450513          	addi	a0,a0,1380 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc020116c:	898ff0ef          	jal	ra,ffffffffc0200204 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201170:	86aa                	mv	a3,a0
ffffffffc0201172:	00004617          	auipc	a2,0x4
ffffffffc0201176:	56660613          	addi	a2,a2,1382 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc020117a:	0fa00593          	li	a1,250
ffffffffc020117e:	00004517          	auipc	a0,0x4
ffffffffc0201182:	54a50513          	addi	a0,a0,1354 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201186:	87eff0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020118a <unmap_range>:
        *ptep = 0;                  //(5) clear second page table entry
        tlb_invalidate(pgdir, la);  //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc020118a:	711d                	addi	sp,sp,-96
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020118c:	00c5e7b3          	or	a5,a1,a2
void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc0201190:	ec86                	sd	ra,88(sp)
ffffffffc0201192:	e8a2                	sd	s0,80(sp)
ffffffffc0201194:	e4a6                	sd	s1,72(sp)
ffffffffc0201196:	e0ca                	sd	s2,64(sp)
ffffffffc0201198:	fc4e                	sd	s3,56(sp)
ffffffffc020119a:	f852                	sd	s4,48(sp)
ffffffffc020119c:	f456                	sd	s5,40(sp)
ffffffffc020119e:	f05a                	sd	s6,32(sp)
ffffffffc02011a0:	ec5e                	sd	s7,24(sp)
ffffffffc02011a2:	e862                	sd	s8,16(sp)
ffffffffc02011a4:	e466                	sd	s9,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02011a6:	17d2                	slli	a5,a5,0x34
ffffffffc02011a8:	ebf1                	bnez	a5,ffffffffc020127c <unmap_range+0xf2>
    assert(USER_ACCESS(start, end));
ffffffffc02011aa:	002007b7          	lui	a5,0x200
ffffffffc02011ae:	842e                	mv	s0,a1
ffffffffc02011b0:	0af5e663          	bltu	a1,a5,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011b4:	8932                	mv	s2,a2
ffffffffc02011b6:	0ac5f363          	bgeu	a1,a2,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011ba:	4785                	li	a5,1
ffffffffc02011bc:	07fe                	slli	a5,a5,0x1f
ffffffffc02011be:	08c7ef63          	bltu	a5,a2,ffffffffc020125c <unmap_range+0xd2>
ffffffffc02011c2:	89aa                	mv	s3,a0
            continue;
        }
        if (*ptep != 0) {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc02011c4:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc02011c6:	00033c97          	auipc	s9,0x33
ffffffffc02011ca:	ac2c8c93          	addi	s9,s9,-1342 # ffffffffc0233c88 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02011ce:	00033c17          	auipc	s8,0x33
ffffffffc02011d2:	b32c0c13          	addi	s8,s8,-1230 # ffffffffc0233d00 <pages>
ffffffffc02011d6:	fff80bb7          	lui	s7,0xfff80
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02011da:	00200b37          	lui	s6,0x200
ffffffffc02011de:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc02011e2:	4601                	li	a2,0
ffffffffc02011e4:	85a2                	mv	a1,s0
ffffffffc02011e6:	854e                	mv	a0,s3
ffffffffc02011e8:	dd1ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02011ec:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc02011ee:	cd21                	beqz	a0,ffffffffc0201246 <unmap_range+0xbc>
        if (*ptep != 0) {
ffffffffc02011f0:	611c                	ld	a5,0(a0)
ffffffffc02011f2:	e38d                	bnez	a5,ffffffffc0201214 <unmap_range+0x8a>
        start += PGSIZE;
ffffffffc02011f4:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02011f6:	ff2466e3          	bltu	s0,s2,ffffffffc02011e2 <unmap_range+0x58>
}
ffffffffc02011fa:	60e6                	ld	ra,88(sp)
ffffffffc02011fc:	6446                	ld	s0,80(sp)
ffffffffc02011fe:	64a6                	ld	s1,72(sp)
ffffffffc0201200:	6906                	ld	s2,64(sp)
ffffffffc0201202:	79e2                	ld	s3,56(sp)
ffffffffc0201204:	7a42                	ld	s4,48(sp)
ffffffffc0201206:	7aa2                	ld	s5,40(sp)
ffffffffc0201208:	7b02                	ld	s6,32(sp)
ffffffffc020120a:	6be2                	ld	s7,24(sp)
ffffffffc020120c:	6c42                	ld	s8,16(sp)
ffffffffc020120e:	6ca2                	ld	s9,8(sp)
ffffffffc0201210:	6125                	addi	sp,sp,96
ffffffffc0201212:	8082                	ret
    if (*ptep & PTE_V) {  //(1) check if this page table entry is
ffffffffc0201214:	0017f713          	andi	a4,a5,1
ffffffffc0201218:	df71                	beqz	a4,ffffffffc02011f4 <unmap_range+0x6a>
    if (PPN(pa) >= npage) {
ffffffffc020121a:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc020121e:	078a                	slli	a5,a5,0x2
ffffffffc0201220:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201222:	06e7fd63          	bgeu	a5,a4,ffffffffc020129c <unmap_range+0x112>
    return &pages[PPN(pa) - nbase];
ffffffffc0201226:	000c3503          	ld	a0,0(s8)
ffffffffc020122a:	97de                	add	a5,a5,s7
ffffffffc020122c:	079a                	slli	a5,a5,0x6
ffffffffc020122e:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0201230:	411c                	lw	a5,0(a0)
ffffffffc0201232:	fff7871b          	addiw	a4,a5,-1
ffffffffc0201236:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc0201238:	cf11                	beqz	a4,ffffffffc0201254 <unmap_range+0xca>
        *ptep = 0;                  //(5) clear second page table entry
ffffffffc020123a:	0004b023          	sd	zero,0(s1)
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020123e:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0201242:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0201244:	bf4d                	j	ffffffffc02011f6 <unmap_range+0x6c>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0201246:	945a                	add	s0,s0,s6
ffffffffc0201248:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc020124c:	d45d                	beqz	s0,ffffffffc02011fa <unmap_range+0x70>
ffffffffc020124e:	f9246ae3          	bltu	s0,s2,ffffffffc02011e2 <unmap_range+0x58>
ffffffffc0201252:	b765                	j	ffffffffc02011fa <unmap_range+0x70>
            free_page(page);
ffffffffc0201254:	4585                	li	a1,1
ffffffffc0201256:	b8fff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc020125a:	b7c5                	j	ffffffffc020123a <unmap_range+0xb0>
    assert(USER_ACCESS(start, end));
ffffffffc020125c:	00004697          	auipc	a3,0x4
ffffffffc0201260:	4d468693          	addi	a3,a3,1236 # ffffffffc0205730 <commands+0x810>
ffffffffc0201264:	00004617          	auipc	a2,0x4
ffffffffc0201268:	0c460613          	addi	a2,a2,196 # ffffffffc0205328 <commands+0x408>
ffffffffc020126c:	14100593          	li	a1,321
ffffffffc0201270:	00004517          	auipc	a0,0x4
ffffffffc0201274:	45850513          	addi	a0,a0,1112 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201278:	f8dfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020127c:	00004697          	auipc	a3,0x4
ffffffffc0201280:	48468693          	addi	a3,a3,1156 # ffffffffc0205700 <commands+0x7e0>
ffffffffc0201284:	00004617          	auipc	a2,0x4
ffffffffc0201288:	0a460613          	addi	a2,a2,164 # ffffffffc0205328 <commands+0x408>
ffffffffc020128c:	14000593          	li	a1,320
ffffffffc0201290:	00004517          	auipc	a0,0x4
ffffffffc0201294:	43850513          	addi	a0,a0,1080 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201298:	f6dfe0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020129c:	a9bff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc02012a0 <exit_range>:
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc02012a0:	715d                	addi	sp,sp,-80
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02012a2:	00c5e7b3          	or	a5,a1,a2
void exit_range(pde_t *pgdir, uintptr_t start, uintptr_t end) {
ffffffffc02012a6:	e486                	sd	ra,72(sp)
ffffffffc02012a8:	e0a2                	sd	s0,64(sp)
ffffffffc02012aa:	fc26                	sd	s1,56(sp)
ffffffffc02012ac:	f84a                	sd	s2,48(sp)
ffffffffc02012ae:	f44e                	sd	s3,40(sp)
ffffffffc02012b0:	f052                	sd	s4,32(sp)
ffffffffc02012b2:	ec56                	sd	s5,24(sp)
ffffffffc02012b4:	e85a                	sd	s6,16(sp)
ffffffffc02012b6:	e45e                	sd	s7,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02012b8:	17d2                	slli	a5,a5,0x34
ffffffffc02012ba:	e3f1                	bnez	a5,ffffffffc020137e <exit_range+0xde>
    assert(USER_ACCESS(start, end));
ffffffffc02012bc:	002007b7          	lui	a5,0x200
ffffffffc02012c0:	08f5ef63          	bltu	a1,a5,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012c4:	89b2                	mv	s3,a2
ffffffffc02012c6:	08c5fc63          	bgeu	a1,a2,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012ca:	4785                	li	a5,1
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc02012cc:	ffe004b7          	lui	s1,0xffe00
    assert(USER_ACCESS(start, end));
ffffffffc02012d0:	07fe                	slli	a5,a5,0x1f
    start = ROUNDDOWN(start, PTSIZE);
ffffffffc02012d2:	8ced                	and	s1,s1,a1
    assert(USER_ACCESS(start, end));
ffffffffc02012d4:	08c7e563          	bltu	a5,a2,ffffffffc020135e <exit_range+0xbe>
ffffffffc02012d8:	8a2a                	mv	s4,a0
    if (PPN(pa) >= npage) {
ffffffffc02012da:	00033b17          	auipc	s6,0x33
ffffffffc02012de:	9aeb0b13          	addi	s6,s6,-1618 # ffffffffc0233c88 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02012e2:	00033b97          	auipc	s7,0x33
ffffffffc02012e6:	a1eb8b93          	addi	s7,s7,-1506 # ffffffffc0233d00 <pages>
ffffffffc02012ea:	fff80937          	lui	s2,0xfff80
        start += PTSIZE;
ffffffffc02012ee:	00200ab7          	lui	s5,0x200
ffffffffc02012f2:	a019                	j	ffffffffc02012f8 <exit_range+0x58>
    } while (start != 0 && start < end);
ffffffffc02012f4:	0334fe63          	bgeu	s1,s3,ffffffffc0201330 <exit_range+0x90>
        int pde_idx = PDX1(start);
ffffffffc02012f8:	01e4d413          	srli	s0,s1,0x1e
        if (pgdir[pde_idx] & PTE_V) {
ffffffffc02012fc:	1ff47413          	andi	s0,s0,511
ffffffffc0201300:	040e                	slli	s0,s0,0x3
ffffffffc0201302:	9452                	add	s0,s0,s4
ffffffffc0201304:	601c                	ld	a5,0(s0)
ffffffffc0201306:	0017f713          	andi	a4,a5,1
ffffffffc020130a:	c30d                	beqz	a4,ffffffffc020132c <exit_range+0x8c>
    if (PPN(pa) >= npage) {
ffffffffc020130c:	000b3703          	ld	a4,0(s6)
    return pa2page(PDE_ADDR(pde));
ffffffffc0201310:	078a                	slli	a5,a5,0x2
ffffffffc0201312:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201314:	02e7f963          	bgeu	a5,a4,ffffffffc0201346 <exit_range+0xa6>
    return &pages[PPN(pa) - nbase];
ffffffffc0201318:	000bb503          	ld	a0,0(s7)
ffffffffc020131c:	97ca                	add	a5,a5,s2
ffffffffc020131e:	079a                	slli	a5,a5,0x6
            free_page(pde2page(pgdir[pde_idx]));
ffffffffc0201320:	4585                	li	a1,1
ffffffffc0201322:	953e                	add	a0,a0,a5
ffffffffc0201324:	ac1ff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
            pgdir[pde_idx] = 0;
ffffffffc0201328:	00043023          	sd	zero,0(s0)
        start += PTSIZE;
ffffffffc020132c:	94d6                	add	s1,s1,s5
    } while (start != 0 && start < end);
ffffffffc020132e:	f0f9                	bnez	s1,ffffffffc02012f4 <exit_range+0x54>
}
ffffffffc0201330:	60a6                	ld	ra,72(sp)
ffffffffc0201332:	6406                	ld	s0,64(sp)
ffffffffc0201334:	74e2                	ld	s1,56(sp)
ffffffffc0201336:	7942                	ld	s2,48(sp)
ffffffffc0201338:	79a2                	ld	s3,40(sp)
ffffffffc020133a:	7a02                	ld	s4,32(sp)
ffffffffc020133c:	6ae2                	ld	s5,24(sp)
ffffffffc020133e:	6b42                	ld	s6,16(sp)
ffffffffc0201340:	6ba2                	ld	s7,8(sp)
ffffffffc0201342:	6161                	addi	sp,sp,80
ffffffffc0201344:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201346:	00004617          	auipc	a2,0x4
ffffffffc020134a:	2d260613          	addi	a2,a2,722 # ffffffffc0205618 <commands+0x6f8>
ffffffffc020134e:	06200593          	li	a1,98
ffffffffc0201352:	00004517          	auipc	a0,0x4
ffffffffc0201356:	2e650513          	addi	a0,a0,742 # ffffffffc0205638 <commands+0x718>
ffffffffc020135a:	eabfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020135e:	00004697          	auipc	a3,0x4
ffffffffc0201362:	3d268693          	addi	a3,a3,978 # ffffffffc0205730 <commands+0x810>
ffffffffc0201366:	00004617          	auipc	a2,0x4
ffffffffc020136a:	fc260613          	addi	a2,a2,-62 # ffffffffc0205328 <commands+0x408>
ffffffffc020136e:	15200593          	li	a1,338
ffffffffc0201372:	00004517          	auipc	a0,0x4
ffffffffc0201376:	35650513          	addi	a0,a0,854 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc020137a:	e8bfe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020137e:	00004697          	auipc	a3,0x4
ffffffffc0201382:	38268693          	addi	a3,a3,898 # ffffffffc0205700 <commands+0x7e0>
ffffffffc0201386:	00004617          	auipc	a2,0x4
ffffffffc020138a:	fa260613          	addi	a2,a2,-94 # ffffffffc0205328 <commands+0x408>
ffffffffc020138e:	15100593          	li	a1,337
ffffffffc0201392:	00004517          	auipc	a0,0x4
ffffffffc0201396:	33650513          	addi	a0,a0,822 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc020139a:	e6bfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020139e <page_insert>:
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc020139e:	7179                	addi	sp,sp,-48
ffffffffc02013a0:	e44e                	sd	s3,8(sp)
ffffffffc02013a2:	89b2                	mv	s3,a2
ffffffffc02013a4:	f022                	sd	s0,32(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013a6:	4605                	li	a2,1
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc02013a8:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013aa:	85ce                	mv	a1,s3
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
ffffffffc02013ac:	ec26                	sd	s1,24(sp)
ffffffffc02013ae:	f406                	sd	ra,40(sp)
ffffffffc02013b0:	e84a                	sd	s2,16(sp)
ffffffffc02013b2:	e052                	sd	s4,0(sp)
ffffffffc02013b4:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc02013b6:	c03ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
    if (ptep == NULL) {
ffffffffc02013ba:	cd41                	beqz	a0,ffffffffc0201452 <page_insert+0xb4>
    page->ref += 1;
ffffffffc02013bc:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V) {
ffffffffc02013be:	611c                	ld	a5,0(a0)
ffffffffc02013c0:	892a                	mv	s2,a0
ffffffffc02013c2:	0016871b          	addiw	a4,a3,1
ffffffffc02013c6:	c018                	sw	a4,0(s0)
ffffffffc02013c8:	0017f713          	andi	a4,a5,1
ffffffffc02013cc:	eb1d                	bnez	a4,ffffffffc0201402 <page_insert+0x64>
ffffffffc02013ce:	00033717          	auipc	a4,0x33
ffffffffc02013d2:	93273703          	ld	a4,-1742(a4) # ffffffffc0233d00 <pages>
    return page - pages + nbase;
ffffffffc02013d6:	8c19                	sub	s0,s0,a4
ffffffffc02013d8:	000807b7          	lui	a5,0x80
ffffffffc02013dc:	8419                	srai	s0,s0,0x6
ffffffffc02013de:	943e                	add	s0,s0,a5
  return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02013e0:	042a                	slli	s0,s0,0xa
ffffffffc02013e2:	8c45                	or	s0,s0,s1
ffffffffc02013e4:	00146413          	ori	s0,s0,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02013e8:	00893023          	sd	s0,0(s2) # fffffffffff80000 <end+0x3fd4c1f0>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02013ec:	12098073          	sfence.vma	s3
    return 0;
ffffffffc02013f0:	4501                	li	a0,0
}
ffffffffc02013f2:	70a2                	ld	ra,40(sp)
ffffffffc02013f4:	7402                	ld	s0,32(sp)
ffffffffc02013f6:	64e2                	ld	s1,24(sp)
ffffffffc02013f8:	6942                	ld	s2,16(sp)
ffffffffc02013fa:	69a2                	ld	s3,8(sp)
ffffffffc02013fc:	6a02                	ld	s4,0(sp)
ffffffffc02013fe:	6145                	addi	sp,sp,48
ffffffffc0201400:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0201402:	078a                	slli	a5,a5,0x2
ffffffffc0201404:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201406:	00033717          	auipc	a4,0x33
ffffffffc020140a:	88273703          	ld	a4,-1918(a4) # ffffffffc0233c88 <npage>
ffffffffc020140e:	04e7f463          	bgeu	a5,a4,ffffffffc0201456 <page_insert+0xb8>
    return &pages[PPN(pa) - nbase];
ffffffffc0201412:	00033a17          	auipc	s4,0x33
ffffffffc0201416:	8eea0a13          	addi	s4,s4,-1810 # ffffffffc0233d00 <pages>
ffffffffc020141a:	000a3703          	ld	a4,0(s4)
ffffffffc020141e:	fff80537          	lui	a0,0xfff80
ffffffffc0201422:	97aa                	add	a5,a5,a0
ffffffffc0201424:	079a                	slli	a5,a5,0x6
ffffffffc0201426:	97ba                	add	a5,a5,a4
        if (p == page) {
ffffffffc0201428:	00f40a63          	beq	s0,a5,ffffffffc020143c <page_insert+0x9e>
    page->ref -= 1;
ffffffffc020142c:	4394                	lw	a3,0(a5)
ffffffffc020142e:	fff6861b          	addiw	a2,a3,-1
ffffffffc0201432:	c390                	sw	a2,0(a5)
        if (page_ref(page) ==
ffffffffc0201434:	c611                	beqz	a2,ffffffffc0201440 <page_insert+0xa2>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0201436:	12098073          	sfence.vma	s3
}
ffffffffc020143a:	bf71                	j	ffffffffc02013d6 <page_insert+0x38>
ffffffffc020143c:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc020143e:	bf61                	j	ffffffffc02013d6 <page_insert+0x38>
            free_page(page);
ffffffffc0201440:	4585                	li	a1,1
ffffffffc0201442:	853e                	mv	a0,a5
ffffffffc0201444:	9a1ff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc0201448:	000a3703          	ld	a4,0(s4)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020144c:	12098073          	sfence.vma	s3
ffffffffc0201450:	b759                	j	ffffffffc02013d6 <page_insert+0x38>
        return -E_NO_MEM;
ffffffffc0201452:	5571                	li	a0,-4
ffffffffc0201454:	bf79                	j	ffffffffc02013f2 <page_insert+0x54>
ffffffffc0201456:	8e1ff0ef          	jal	ra,ffffffffc0200d36 <pa2page.part.0>

ffffffffc020145a <copy_range>:
               bool share) {
ffffffffc020145a:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020145c:	00d667b3          	or	a5,a2,a3
               bool share) {
ffffffffc0201460:	f486                	sd	ra,104(sp)
ffffffffc0201462:	f0a2                	sd	s0,96(sp)
ffffffffc0201464:	eca6                	sd	s1,88(sp)
ffffffffc0201466:	e8ca                	sd	s2,80(sp)
ffffffffc0201468:	e4ce                	sd	s3,72(sp)
ffffffffc020146a:	e0d2                	sd	s4,64(sp)
ffffffffc020146c:	fc56                	sd	s5,56(sp)
ffffffffc020146e:	f85a                	sd	s6,48(sp)
ffffffffc0201470:	f45e                	sd	s7,40(sp)
ffffffffc0201472:	f062                	sd	s8,32(sp)
ffffffffc0201474:	ec66                	sd	s9,24(sp)
ffffffffc0201476:	e86a                	sd	s10,16(sp)
ffffffffc0201478:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020147a:	17d2                	slli	a5,a5,0x34
ffffffffc020147c:	1e079763          	bnez	a5,ffffffffc020166a <copy_range+0x210>
    assert(USER_ACCESS(start, end));
ffffffffc0201480:	002007b7          	lui	a5,0x200
ffffffffc0201484:	8432                	mv	s0,a2
ffffffffc0201486:	16f66a63          	bltu	a2,a5,ffffffffc02015fa <copy_range+0x1a0>
ffffffffc020148a:	8936                	mv	s2,a3
ffffffffc020148c:	16d67763          	bgeu	a2,a3,ffffffffc02015fa <copy_range+0x1a0>
ffffffffc0201490:	4785                	li	a5,1
ffffffffc0201492:	07fe                	slli	a5,a5,0x1f
ffffffffc0201494:	16d7e363          	bltu	a5,a3,ffffffffc02015fa <copy_range+0x1a0>
    return KADDR(page2pa(page));
ffffffffc0201498:	5b7d                	li	s6,-1
ffffffffc020149a:	8aaa                	mv	s5,a0
ffffffffc020149c:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc020149e:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage) {
ffffffffc02014a0:	00032c97          	auipc	s9,0x32
ffffffffc02014a4:	7e8c8c93          	addi	s9,s9,2024 # ffffffffc0233c88 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02014a8:	00033c17          	auipc	s8,0x33
ffffffffc02014ac:	858c0c13          	addi	s8,s8,-1960 # ffffffffc0233d00 <pages>
    return page - pages + nbase;
ffffffffc02014b0:	00080bb7          	lui	s7,0x80
    return KADDR(page2pa(page));
ffffffffc02014b4:	00cb5b13          	srli	s6,s6,0xc
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02014b8:	4601                	li	a2,0
ffffffffc02014ba:	85a2                	mv	a1,s0
ffffffffc02014bc:	854e                	mv	a0,s3
ffffffffc02014be:	afbff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02014c2:	84aa                	mv	s1,a0
        if (ptep == NULL) {
ffffffffc02014c4:	c175                	beqz	a0,ffffffffc02015a8 <copy_range+0x14e>
        if (*ptep & PTE_V) {
ffffffffc02014c6:	611c                	ld	a5,0(a0)
ffffffffc02014c8:	8b85                	andi	a5,a5,1
ffffffffc02014ca:	e785                	bnez	a5,ffffffffc02014f2 <copy_range+0x98>
        start += PGSIZE;
ffffffffc02014cc:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02014ce:	ff2465e3          	bltu	s0,s2,ffffffffc02014b8 <copy_range+0x5e>
    return 0;
ffffffffc02014d2:	4501                	li	a0,0
}
ffffffffc02014d4:	70a6                	ld	ra,104(sp)
ffffffffc02014d6:	7406                	ld	s0,96(sp)
ffffffffc02014d8:	64e6                	ld	s1,88(sp)
ffffffffc02014da:	6946                	ld	s2,80(sp)
ffffffffc02014dc:	69a6                	ld	s3,72(sp)
ffffffffc02014de:	6a06                	ld	s4,64(sp)
ffffffffc02014e0:	7ae2                	ld	s5,56(sp)
ffffffffc02014e2:	7b42                	ld	s6,48(sp)
ffffffffc02014e4:	7ba2                	ld	s7,40(sp)
ffffffffc02014e6:	7c02                	ld	s8,32(sp)
ffffffffc02014e8:	6ce2                	ld	s9,24(sp)
ffffffffc02014ea:	6d42                	ld	s10,16(sp)
ffffffffc02014ec:	6da2                	ld	s11,8(sp)
ffffffffc02014ee:	6165                	addi	sp,sp,112
ffffffffc02014f0:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL) {
ffffffffc02014f2:	4605                	li	a2,1
ffffffffc02014f4:	85a2                	mv	a1,s0
ffffffffc02014f6:	8556                	mv	a0,s5
ffffffffc02014f8:	ac1ff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02014fc:	c161                	beqz	a0,ffffffffc02015bc <copy_range+0x162>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc02014fe:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V)) {
ffffffffc0201500:	0017f713          	andi	a4,a5,1
ffffffffc0201504:	01f7f493          	andi	s1,a5,31
ffffffffc0201508:	14070563          	beqz	a4,ffffffffc0201652 <copy_range+0x1f8>
    if (PPN(pa) >= npage) {
ffffffffc020150c:	000cb683          	ld	a3,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0201510:	078a                	slli	a5,a5,0x2
ffffffffc0201512:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0201516:	12d77263          	bgeu	a4,a3,ffffffffc020163a <copy_range+0x1e0>
    return &pages[PPN(pa) - nbase];
ffffffffc020151a:	000c3783          	ld	a5,0(s8)
ffffffffc020151e:	fff806b7          	lui	a3,0xfff80
ffffffffc0201522:	9736                	add	a4,a4,a3
ffffffffc0201524:	071a                	slli	a4,a4,0x6
            struct Page *npage = alloc_page();
ffffffffc0201526:	4505                	li	a0,1
ffffffffc0201528:	00e78db3          	add	s11,a5,a4
ffffffffc020152c:	827ff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0201530:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0201532:	0a0d8463          	beqz	s11,ffffffffc02015da <copy_range+0x180>
            assert(npage != NULL);
ffffffffc0201536:	c175                	beqz	a0,ffffffffc020161a <copy_range+0x1c0>
    return page - pages + nbase;
ffffffffc0201538:	000c3703          	ld	a4,0(s8)
    return KADDR(page2pa(page));
ffffffffc020153c:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc0201540:	40ed86b3          	sub	a3,s11,a4
ffffffffc0201544:	8699                	srai	a3,a3,0x6
ffffffffc0201546:	96de                	add	a3,a3,s7
    return KADDR(page2pa(page));
ffffffffc0201548:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc020154c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020154e:	06c7fa63          	bgeu	a5,a2,ffffffffc02015c2 <copy_range+0x168>
    return page - pages + nbase;
ffffffffc0201552:	40e507b3          	sub	a5,a0,a4
    return KADDR(page2pa(page));
ffffffffc0201556:	00032717          	auipc	a4,0x32
ffffffffc020155a:	79a70713          	addi	a4,a4,1946 # ffffffffc0233cf0 <va_pa_offset>
ffffffffc020155e:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc0201560:	8799                	srai	a5,a5,0x6
ffffffffc0201562:	97de                	add	a5,a5,s7
    return KADDR(page2pa(page));
ffffffffc0201564:	0167f733          	and	a4,a5,s6
ffffffffc0201568:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc020156c:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc020156e:	04c77963          	bgeu	a4,a2,ffffffffc02015c0 <copy_range+0x166>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc0201572:	6605                	lui	a2,0x1
ffffffffc0201574:	953e                	add	a0,a0,a5
ffffffffc0201576:	2ee030ef          	jal	ra,ffffffffc0204864 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc020157a:	86a6                	mv	a3,s1
ffffffffc020157c:	8622                	mv	a2,s0
ffffffffc020157e:	85ea                	mv	a1,s10
ffffffffc0201580:	8556                	mv	a0,s5
ffffffffc0201582:	e1dff0ef          	jal	ra,ffffffffc020139e <page_insert>
            assert(ret == 0);
ffffffffc0201586:	d139                	beqz	a0,ffffffffc02014cc <copy_range+0x72>
ffffffffc0201588:	00004697          	auipc	a3,0x4
ffffffffc020158c:	20868693          	addi	a3,a3,520 # ffffffffc0205790 <commands+0x870>
ffffffffc0201590:	00004617          	auipc	a2,0x4
ffffffffc0201594:	d9860613          	addi	a2,a2,-616 # ffffffffc0205328 <commands+0x408>
ffffffffc0201598:	19900593          	li	a1,409
ffffffffc020159c:	00004517          	auipc	a0,0x4
ffffffffc02015a0:	12c50513          	addi	a0,a0,300 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc02015a4:	c61fe0ef          	jal	ra,ffffffffc0200204 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02015a8:	00200637          	lui	a2,0x200
ffffffffc02015ac:	9432                	add	s0,s0,a2
ffffffffc02015ae:	ffe00637          	lui	a2,0xffe00
ffffffffc02015b2:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc02015b4:	dc19                	beqz	s0,ffffffffc02014d2 <copy_range+0x78>
ffffffffc02015b6:	f12461e3          	bltu	s0,s2,ffffffffc02014b8 <copy_range+0x5e>
ffffffffc02015ba:	bf21                	j	ffffffffc02014d2 <copy_range+0x78>
                return -E_NO_MEM;
ffffffffc02015bc:	5571                	li	a0,-4
ffffffffc02015be:	bf19                	j	ffffffffc02014d4 <copy_range+0x7a>
ffffffffc02015c0:	86be                	mv	a3,a5
ffffffffc02015c2:	00004617          	auipc	a2,0x4
ffffffffc02015c6:	11660613          	addi	a2,a2,278 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc02015ca:	06900593          	li	a1,105
ffffffffc02015ce:	00004517          	auipc	a0,0x4
ffffffffc02015d2:	06a50513          	addi	a0,a0,106 # ffffffffc0205638 <commands+0x718>
ffffffffc02015d6:	c2ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(page != NULL);
ffffffffc02015da:	00004697          	auipc	a3,0x4
ffffffffc02015de:	19668693          	addi	a3,a3,406 # ffffffffc0205770 <commands+0x850>
ffffffffc02015e2:	00004617          	auipc	a2,0x4
ffffffffc02015e6:	d4660613          	addi	a2,a2,-698 # ffffffffc0205328 <commands+0x408>
ffffffffc02015ea:	17e00593          	li	a1,382
ffffffffc02015ee:	00004517          	auipc	a0,0x4
ffffffffc02015f2:	0da50513          	addi	a0,a0,218 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc02015f6:	c0ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02015fa:	00004697          	auipc	a3,0x4
ffffffffc02015fe:	13668693          	addi	a3,a3,310 # ffffffffc0205730 <commands+0x810>
ffffffffc0201602:	00004617          	auipc	a2,0x4
ffffffffc0201606:	d2660613          	addi	a2,a2,-730 # ffffffffc0205328 <commands+0x408>
ffffffffc020160a:	16a00593          	li	a1,362
ffffffffc020160e:	00004517          	auipc	a0,0x4
ffffffffc0201612:	0ba50513          	addi	a0,a0,186 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201616:	beffe0ef          	jal	ra,ffffffffc0200204 <__panic>
            assert(npage != NULL);
ffffffffc020161a:	00004697          	auipc	a3,0x4
ffffffffc020161e:	16668693          	addi	a3,a3,358 # ffffffffc0205780 <commands+0x860>
ffffffffc0201622:	00004617          	auipc	a2,0x4
ffffffffc0201626:	d0660613          	addi	a2,a2,-762 # ffffffffc0205328 <commands+0x408>
ffffffffc020162a:	17f00593          	li	a1,383
ffffffffc020162e:	00004517          	auipc	a0,0x4
ffffffffc0201632:	09a50513          	addi	a0,a0,154 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201636:	bcffe0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020163a:	00004617          	auipc	a2,0x4
ffffffffc020163e:	fde60613          	addi	a2,a2,-34 # ffffffffc0205618 <commands+0x6f8>
ffffffffc0201642:	06200593          	li	a1,98
ffffffffc0201646:	00004517          	auipc	a0,0x4
ffffffffc020164a:	ff250513          	addi	a0,a0,-14 # ffffffffc0205638 <commands+0x718>
ffffffffc020164e:	bb7fe0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0201652:	00004617          	auipc	a2,0x4
ffffffffc0201656:	0f660613          	addi	a2,a2,246 # ffffffffc0205748 <commands+0x828>
ffffffffc020165a:	07400593          	li	a1,116
ffffffffc020165e:	00004517          	auipc	a0,0x4
ffffffffc0201662:	fda50513          	addi	a0,a0,-38 # ffffffffc0205638 <commands+0x718>
ffffffffc0201666:	b9ffe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020166a:	00004697          	auipc	a3,0x4
ffffffffc020166e:	09668693          	addi	a3,a3,150 # ffffffffc0205700 <commands+0x7e0>
ffffffffc0201672:	00004617          	auipc	a2,0x4
ffffffffc0201676:	cb660613          	addi	a2,a2,-842 # ffffffffc0205328 <commands+0x408>
ffffffffc020167a:	16900593          	li	a1,361
ffffffffc020167e:	00004517          	auipc	a0,0x4
ffffffffc0201682:	04a50513          	addi	a0,a0,74 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc0201686:	b7ffe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020168a <tlb_invalidate>:
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020168a:	12058073          	sfence.vma	a1
}
ffffffffc020168e:	8082                	ret

ffffffffc0201690 <pgdir_alloc_page>:

// pgdir_alloc_page - call alloc_page & page_insert functions to
//                  - allocate a page size memory & setup an addr map
//                  - pa<->la with linear address la and the PDT pgdir
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0201690:	7179                	addi	sp,sp,-48
ffffffffc0201692:	e84a                	sd	s2,16(sp)
ffffffffc0201694:	892a                	mv	s2,a0
    struct Page *page = alloc_page();
ffffffffc0201696:	4505                	li	a0,1
struct Page *pgdir_alloc_page(pde_t *pgdir, uintptr_t la, uint32_t perm) {
ffffffffc0201698:	f022                	sd	s0,32(sp)
ffffffffc020169a:	ec26                	sd	s1,24(sp)
ffffffffc020169c:	e44e                	sd	s3,8(sp)
ffffffffc020169e:	f406                	sd	ra,40(sp)
ffffffffc02016a0:	84ae                	mv	s1,a1
ffffffffc02016a2:	89b2                	mv	s3,a2
    struct Page *page = alloc_page();
ffffffffc02016a4:	eaeff0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02016a8:	842a                	mv	s0,a0
    if (page != NULL) {
ffffffffc02016aa:	cd05                	beqz	a0,ffffffffc02016e2 <pgdir_alloc_page+0x52>
        if (page_insert(pgdir, page, la, perm) != 0) {
ffffffffc02016ac:	85aa                	mv	a1,a0
ffffffffc02016ae:	86ce                	mv	a3,s3
ffffffffc02016b0:	8626                	mv	a2,s1
ffffffffc02016b2:	854a                	mv	a0,s2
ffffffffc02016b4:	cebff0ef          	jal	ra,ffffffffc020139e <page_insert>
ffffffffc02016b8:	ed0d                	bnez	a0,ffffffffc02016f2 <pgdir_alloc_page+0x62>
            free_page(page);
            return NULL;
        }
        if (swap_init_ok) {
ffffffffc02016ba:	00032797          	auipc	a5,0x32
ffffffffc02016be:	5ee7a783          	lw	a5,1518(a5) # ffffffffc0233ca8 <swap_init_ok>
ffffffffc02016c2:	c385                	beqz	a5,ffffffffc02016e2 <pgdir_alloc_page+0x52>
            if (check_mm_struct != NULL) {
ffffffffc02016c4:	00032517          	auipc	a0,0x32
ffffffffc02016c8:	65453503          	ld	a0,1620(a0) # ffffffffc0233d18 <check_mm_struct>
ffffffffc02016cc:	c919                	beqz	a0,ffffffffc02016e2 <pgdir_alloc_page+0x52>
                swap_map_swappable(check_mm_struct, la, page, 0);
ffffffffc02016ce:	4681                	li	a3,0
ffffffffc02016d0:	8622                	mv	a2,s0
ffffffffc02016d2:	85a6                	mv	a1,s1
ffffffffc02016d4:	599000ef          	jal	ra,ffffffffc020246c <swap_map_swappable>
                page->pra_vaddr = la;
                assert(page_ref(page) == 1);
ffffffffc02016d8:	4018                	lw	a4,0(s0)
                page->pra_vaddr = la;
ffffffffc02016da:	fc04                	sd	s1,56(s0)
                assert(page_ref(page) == 1);
ffffffffc02016dc:	4785                	li	a5,1
ffffffffc02016de:	02f71063          	bne	a4,a5,ffffffffc02016fe <pgdir_alloc_page+0x6e>
            }
        }
    }

    return page;
}
ffffffffc02016e2:	70a2                	ld	ra,40(sp)
ffffffffc02016e4:	8522                	mv	a0,s0
ffffffffc02016e6:	7402                	ld	s0,32(sp)
ffffffffc02016e8:	64e2                	ld	s1,24(sp)
ffffffffc02016ea:	6942                	ld	s2,16(sp)
ffffffffc02016ec:	69a2                	ld	s3,8(sp)
ffffffffc02016ee:	6145                	addi	sp,sp,48
ffffffffc02016f0:	8082                	ret
            free_page(page);
ffffffffc02016f2:	8522                	mv	a0,s0
ffffffffc02016f4:	4585                	li	a1,1
ffffffffc02016f6:	eeeff0ef          	jal	ra,ffffffffc0200de4 <free_pages>
            return NULL;
ffffffffc02016fa:	4401                	li	s0,0
ffffffffc02016fc:	b7dd                	j	ffffffffc02016e2 <pgdir_alloc_page+0x52>
                assert(page_ref(page) == 1);
ffffffffc02016fe:	00004697          	auipc	a3,0x4
ffffffffc0201702:	0a268693          	addi	a3,a3,162 # ffffffffc02057a0 <commands+0x880>
ffffffffc0201706:	00004617          	auipc	a2,0x4
ffffffffc020170a:	c2260613          	addi	a2,a2,-990 # ffffffffc0205328 <commands+0x408>
ffffffffc020170e:	1d800593          	li	a1,472
ffffffffc0201712:	00004517          	auipc	a0,0x4
ffffffffc0201716:	fb650513          	addi	a0,a0,-74 # ffffffffc02056c8 <commands+0x7a8>
ffffffffc020171a:	aebfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020171e <_fifo_init_mm>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc020171e:	00032797          	auipc	a5,0x32
ffffffffc0201722:	5ea78793          	addi	a5,a5,1514 # ffffffffc0233d08 <pra_list_head>
 */
static int
_fifo_init_mm(struct mm_struct *mm)
{     
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
ffffffffc0201726:	f51c                	sd	a5,40(a0)
ffffffffc0201728:	e79c                	sd	a5,8(a5)
ffffffffc020172a:	e39c                	sd	a5,0(a5)
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}
ffffffffc020172c:	4501                	li	a0,0
ffffffffc020172e:	8082                	ret

ffffffffc0201730 <_fifo_init>:

static int
_fifo_init(void)
{
    return 0;
}
ffffffffc0201730:	4501                	li	a0,0
ffffffffc0201732:	8082                	ret

ffffffffc0201734 <_fifo_set_unswappable>:

static int
_fifo_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}
ffffffffc0201734:	4501                	li	a0,0
ffffffffc0201736:	8082                	ret

ffffffffc0201738 <_fifo_tick_event>:

static int
_fifo_tick_event(struct mm_struct *mm)
{ return 0; }
ffffffffc0201738:	4501                	li	a0,0
ffffffffc020173a:	8082                	ret

ffffffffc020173c <_fifo_check_swap>:
_fifo_check_swap(void) {
ffffffffc020173c:	711d                	addi	sp,sp,-96
ffffffffc020173e:	fc4e                	sd	s3,56(sp)
ffffffffc0201740:	f852                	sd	s4,48(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0201742:	00004517          	auipc	a0,0x4
ffffffffc0201746:	07650513          	addi	a0,a0,118 # ffffffffc02057b8 <commands+0x898>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc020174a:	698d                	lui	s3,0x3
ffffffffc020174c:	4a31                	li	s4,12
_fifo_check_swap(void) {
ffffffffc020174e:	e0ca                	sd	s2,64(sp)
ffffffffc0201750:	ec86                	sd	ra,88(sp)
ffffffffc0201752:	e8a2                	sd	s0,80(sp)
ffffffffc0201754:	e4a6                	sd	s1,72(sp)
ffffffffc0201756:	f456                	sd	s5,40(sp)
ffffffffc0201758:	f05a                	sd	s6,32(sp)
ffffffffc020175a:	ec5e                	sd	s7,24(sp)
ffffffffc020175c:	e862                	sd	s8,16(sp)
ffffffffc020175e:	e466                	sd	s9,8(sp)
ffffffffc0201760:	e06a                	sd	s10,0(sp)
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0201762:	967fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc0201766:	01498023          	sb	s4,0(s3) # 3000 <_binary_obj___user_hello_out_size-0x68a8>
    assert(pgfault_num==4);
ffffffffc020176a:	00032917          	auipc	s2,0x32
ffffffffc020176e:	52692903          	lw	s2,1318(s2) # ffffffffc0233c90 <pgfault_num>
ffffffffc0201772:	4791                	li	a5,4
ffffffffc0201774:	14f91e63          	bne	s2,a5,ffffffffc02018d0 <_fifo_check_swap+0x194>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201778:	00004517          	auipc	a0,0x4
ffffffffc020177c:	09050513          	addi	a0,a0,144 # ffffffffc0205808 <commands+0x8e8>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0201780:	6a85                	lui	s5,0x1
ffffffffc0201782:	4b29                	li	s6,10
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201784:	945fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0201788:	00032417          	auipc	s0,0x32
ffffffffc020178c:	50840413          	addi	s0,s0,1288 # ffffffffc0233c90 <pgfault_num>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0201790:	016a8023          	sb	s6,0(s5) # 1000 <_binary_obj___user_hello_out_size-0x88a8>
    assert(pgfault_num==4);
ffffffffc0201794:	4004                	lw	s1,0(s0)
ffffffffc0201796:	2481                	sext.w	s1,s1
ffffffffc0201798:	2b249c63          	bne	s1,s2,ffffffffc0201a50 <_fifo_check_swap+0x314>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc020179c:	00004517          	auipc	a0,0x4
ffffffffc02017a0:	09450513          	addi	a0,a0,148 # ffffffffc0205830 <commands+0x910>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02017a4:	6b91                	lui	s7,0x4
ffffffffc02017a6:	4c35                	li	s8,13
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc02017a8:	921fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc02017ac:	018b8023          	sb	s8,0(s7) # 4000 <_binary_obj___user_hello_out_size-0x58a8>
    assert(pgfault_num==4);
ffffffffc02017b0:	00042903          	lw	s2,0(s0)
ffffffffc02017b4:	2901                	sext.w	s2,s2
ffffffffc02017b6:	26991d63          	bne	s2,s1,ffffffffc0201a30 <_fifo_check_swap+0x2f4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02017ba:	00004517          	auipc	a0,0x4
ffffffffc02017be:	09e50513          	addi	a0,a0,158 # ffffffffc0205858 <commands+0x938>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02017c2:	6c89                	lui	s9,0x2
ffffffffc02017c4:	4d2d                	li	s10,11
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02017c6:	903fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc02017ca:	01ac8023          	sb	s10,0(s9) # 2000 <_binary_obj___user_hello_out_size-0x78a8>
    assert(pgfault_num==4);
ffffffffc02017ce:	401c                	lw	a5,0(s0)
ffffffffc02017d0:	2781                	sext.w	a5,a5
ffffffffc02017d2:	23279f63          	bne	a5,s2,ffffffffc0201a10 <_fifo_check_swap+0x2d4>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc02017d6:	00004517          	auipc	a0,0x4
ffffffffc02017da:	0aa50513          	addi	a0,a0,170 # ffffffffc0205880 <commands+0x960>
ffffffffc02017de:	8ebfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc02017e2:	6795                	lui	a5,0x5
ffffffffc02017e4:	4739                	li	a4,14
ffffffffc02017e6:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_hello_out_size-0x48a8>
    assert(pgfault_num==5);
ffffffffc02017ea:	4004                	lw	s1,0(s0)
ffffffffc02017ec:	4795                	li	a5,5
ffffffffc02017ee:	2481                	sext.w	s1,s1
ffffffffc02017f0:	20f49063          	bne	s1,a5,ffffffffc02019f0 <_fifo_check_swap+0x2b4>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc02017f4:	00004517          	auipc	a0,0x4
ffffffffc02017f8:	06450513          	addi	a0,a0,100 # ffffffffc0205858 <commands+0x938>
ffffffffc02017fc:	8cdfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201800:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==5);
ffffffffc0201804:	401c                	lw	a5,0(s0)
ffffffffc0201806:	2781                	sext.w	a5,a5
ffffffffc0201808:	1c979463          	bne	a5,s1,ffffffffc02019d0 <_fifo_check_swap+0x294>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc020180c:	00004517          	auipc	a0,0x4
ffffffffc0201810:	ffc50513          	addi	a0,a0,-4 # ffffffffc0205808 <commands+0x8e8>
ffffffffc0201814:	8b5fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x1000 = 0x0a;
ffffffffc0201818:	016a8023          	sb	s6,0(s5)
    assert(pgfault_num==6);
ffffffffc020181c:	401c                	lw	a5,0(s0)
ffffffffc020181e:	4719                	li	a4,6
ffffffffc0201820:	2781                	sext.w	a5,a5
ffffffffc0201822:	18e79763          	bne	a5,a4,ffffffffc02019b0 <_fifo_check_swap+0x274>
    cprintf("write Virt Page b in fifo_check_swap\n");
ffffffffc0201826:	00004517          	auipc	a0,0x4
ffffffffc020182a:	03250513          	addi	a0,a0,50 # ffffffffc0205858 <commands+0x938>
ffffffffc020182e:	89bfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x2000 = 0x0b;
ffffffffc0201832:	01ac8023          	sb	s10,0(s9)
    assert(pgfault_num==7);
ffffffffc0201836:	401c                	lw	a5,0(s0)
ffffffffc0201838:	471d                	li	a4,7
ffffffffc020183a:	2781                	sext.w	a5,a5
ffffffffc020183c:	14e79a63          	bne	a5,a4,ffffffffc0201990 <_fifo_check_swap+0x254>
    cprintf("write Virt Page c in fifo_check_swap\n");
ffffffffc0201840:	00004517          	auipc	a0,0x4
ffffffffc0201844:	f7850513          	addi	a0,a0,-136 # ffffffffc02057b8 <commands+0x898>
ffffffffc0201848:	881fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x3000 = 0x0c;
ffffffffc020184c:	01498023          	sb	s4,0(s3)
    assert(pgfault_num==8);
ffffffffc0201850:	401c                	lw	a5,0(s0)
ffffffffc0201852:	4721                	li	a4,8
ffffffffc0201854:	2781                	sext.w	a5,a5
ffffffffc0201856:	10e79d63          	bne	a5,a4,ffffffffc0201970 <_fifo_check_swap+0x234>
    cprintf("write Virt Page d in fifo_check_swap\n");
ffffffffc020185a:	00004517          	auipc	a0,0x4
ffffffffc020185e:	fd650513          	addi	a0,a0,-42 # ffffffffc0205830 <commands+0x910>
ffffffffc0201862:	867fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x4000 = 0x0d;
ffffffffc0201866:	018b8023          	sb	s8,0(s7)
    assert(pgfault_num==9);
ffffffffc020186a:	401c                	lw	a5,0(s0)
ffffffffc020186c:	4725                	li	a4,9
ffffffffc020186e:	2781                	sext.w	a5,a5
ffffffffc0201870:	0ee79063          	bne	a5,a4,ffffffffc0201950 <_fifo_check_swap+0x214>
    cprintf("write Virt Page e in fifo_check_swap\n");
ffffffffc0201874:	00004517          	auipc	a0,0x4
ffffffffc0201878:	00c50513          	addi	a0,a0,12 # ffffffffc0205880 <commands+0x960>
ffffffffc020187c:	84dfe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    *(unsigned char *)0x5000 = 0x0e;
ffffffffc0201880:	6795                	lui	a5,0x5
ffffffffc0201882:	4739                	li	a4,14
ffffffffc0201884:	00e78023          	sb	a4,0(a5) # 5000 <_binary_obj___user_hello_out_size-0x48a8>
    assert(pgfault_num==10);
ffffffffc0201888:	4004                	lw	s1,0(s0)
ffffffffc020188a:	47a9                	li	a5,10
ffffffffc020188c:	2481                	sext.w	s1,s1
ffffffffc020188e:	0af49163          	bne	s1,a5,ffffffffc0201930 <_fifo_check_swap+0x1f4>
    cprintf("write Virt Page a in fifo_check_swap\n");
ffffffffc0201892:	00004517          	auipc	a0,0x4
ffffffffc0201896:	f7650513          	addi	a0,a0,-138 # ffffffffc0205808 <commands+0x8e8>
ffffffffc020189a:	82ffe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc020189e:	6785                	lui	a5,0x1
ffffffffc02018a0:	0007c783          	lbu	a5,0(a5) # 1000 <_binary_obj___user_hello_out_size-0x88a8>
ffffffffc02018a4:	06979663          	bne	a5,s1,ffffffffc0201910 <_fifo_check_swap+0x1d4>
    assert(pgfault_num==11);
ffffffffc02018a8:	401c                	lw	a5,0(s0)
ffffffffc02018aa:	472d                	li	a4,11
ffffffffc02018ac:	2781                	sext.w	a5,a5
ffffffffc02018ae:	04e79163          	bne	a5,a4,ffffffffc02018f0 <_fifo_check_swap+0x1b4>
}
ffffffffc02018b2:	60e6                	ld	ra,88(sp)
ffffffffc02018b4:	6446                	ld	s0,80(sp)
ffffffffc02018b6:	64a6                	ld	s1,72(sp)
ffffffffc02018b8:	6906                	ld	s2,64(sp)
ffffffffc02018ba:	79e2                	ld	s3,56(sp)
ffffffffc02018bc:	7a42                	ld	s4,48(sp)
ffffffffc02018be:	7aa2                	ld	s5,40(sp)
ffffffffc02018c0:	7b02                	ld	s6,32(sp)
ffffffffc02018c2:	6be2                	ld	s7,24(sp)
ffffffffc02018c4:	6c42                	ld	s8,16(sp)
ffffffffc02018c6:	6ca2                	ld	s9,8(sp)
ffffffffc02018c8:	6d02                	ld	s10,0(sp)
ffffffffc02018ca:	4501                	li	a0,0
ffffffffc02018cc:	6125                	addi	sp,sp,96
ffffffffc02018ce:	8082                	ret
    assert(pgfault_num==4);
ffffffffc02018d0:	00004697          	auipc	a3,0x4
ffffffffc02018d4:	f1068693          	addi	a3,a3,-240 # ffffffffc02057e0 <commands+0x8c0>
ffffffffc02018d8:	00004617          	auipc	a2,0x4
ffffffffc02018dc:	a5060613          	addi	a2,a2,-1456 # ffffffffc0205328 <commands+0x408>
ffffffffc02018e0:	05100593          	li	a1,81
ffffffffc02018e4:	00004517          	auipc	a0,0x4
ffffffffc02018e8:	f0c50513          	addi	a0,a0,-244 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc02018ec:	919fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==11);
ffffffffc02018f0:	00004697          	auipc	a3,0x4
ffffffffc02018f4:	04068693          	addi	a3,a3,64 # ffffffffc0205930 <commands+0xa10>
ffffffffc02018f8:	00004617          	auipc	a2,0x4
ffffffffc02018fc:	a3060613          	addi	a2,a2,-1488 # ffffffffc0205328 <commands+0x408>
ffffffffc0201900:	07300593          	li	a1,115
ffffffffc0201904:	00004517          	auipc	a0,0x4
ffffffffc0201908:	eec50513          	addi	a0,a0,-276 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc020190c:	8f9fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(*(unsigned char *)0x1000 == 0x0a);
ffffffffc0201910:	00004697          	auipc	a3,0x4
ffffffffc0201914:	ff868693          	addi	a3,a3,-8 # ffffffffc0205908 <commands+0x9e8>
ffffffffc0201918:	00004617          	auipc	a2,0x4
ffffffffc020191c:	a1060613          	addi	a2,a2,-1520 # ffffffffc0205328 <commands+0x408>
ffffffffc0201920:	07100593          	li	a1,113
ffffffffc0201924:	00004517          	auipc	a0,0x4
ffffffffc0201928:	ecc50513          	addi	a0,a0,-308 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc020192c:	8d9fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==10);
ffffffffc0201930:	00004697          	auipc	a3,0x4
ffffffffc0201934:	fc868693          	addi	a3,a3,-56 # ffffffffc02058f8 <commands+0x9d8>
ffffffffc0201938:	00004617          	auipc	a2,0x4
ffffffffc020193c:	9f060613          	addi	a2,a2,-1552 # ffffffffc0205328 <commands+0x408>
ffffffffc0201940:	06f00593          	li	a1,111
ffffffffc0201944:	00004517          	auipc	a0,0x4
ffffffffc0201948:	eac50513          	addi	a0,a0,-340 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc020194c:	8b9fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==9);
ffffffffc0201950:	00004697          	auipc	a3,0x4
ffffffffc0201954:	f9868693          	addi	a3,a3,-104 # ffffffffc02058e8 <commands+0x9c8>
ffffffffc0201958:	00004617          	auipc	a2,0x4
ffffffffc020195c:	9d060613          	addi	a2,a2,-1584 # ffffffffc0205328 <commands+0x408>
ffffffffc0201960:	06c00593          	li	a1,108
ffffffffc0201964:	00004517          	auipc	a0,0x4
ffffffffc0201968:	e8c50513          	addi	a0,a0,-372 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc020196c:	899fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==8);
ffffffffc0201970:	00004697          	auipc	a3,0x4
ffffffffc0201974:	f6868693          	addi	a3,a3,-152 # ffffffffc02058d8 <commands+0x9b8>
ffffffffc0201978:	00004617          	auipc	a2,0x4
ffffffffc020197c:	9b060613          	addi	a2,a2,-1616 # ffffffffc0205328 <commands+0x408>
ffffffffc0201980:	06900593          	li	a1,105
ffffffffc0201984:	00004517          	auipc	a0,0x4
ffffffffc0201988:	e6c50513          	addi	a0,a0,-404 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc020198c:	879fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==7);
ffffffffc0201990:	00004697          	auipc	a3,0x4
ffffffffc0201994:	f3868693          	addi	a3,a3,-200 # ffffffffc02058c8 <commands+0x9a8>
ffffffffc0201998:	00004617          	auipc	a2,0x4
ffffffffc020199c:	99060613          	addi	a2,a2,-1648 # ffffffffc0205328 <commands+0x408>
ffffffffc02019a0:	06600593          	li	a1,102
ffffffffc02019a4:	00004517          	auipc	a0,0x4
ffffffffc02019a8:	e4c50513          	addi	a0,a0,-436 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc02019ac:	859fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==6);
ffffffffc02019b0:	00004697          	auipc	a3,0x4
ffffffffc02019b4:	f0868693          	addi	a3,a3,-248 # ffffffffc02058b8 <commands+0x998>
ffffffffc02019b8:	00004617          	auipc	a2,0x4
ffffffffc02019bc:	97060613          	addi	a2,a2,-1680 # ffffffffc0205328 <commands+0x408>
ffffffffc02019c0:	06300593          	li	a1,99
ffffffffc02019c4:	00004517          	auipc	a0,0x4
ffffffffc02019c8:	e2c50513          	addi	a0,a0,-468 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc02019cc:	839fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc02019d0:	00004697          	auipc	a3,0x4
ffffffffc02019d4:	ed868693          	addi	a3,a3,-296 # ffffffffc02058a8 <commands+0x988>
ffffffffc02019d8:	00004617          	auipc	a2,0x4
ffffffffc02019dc:	95060613          	addi	a2,a2,-1712 # ffffffffc0205328 <commands+0x408>
ffffffffc02019e0:	06000593          	li	a1,96
ffffffffc02019e4:	00004517          	auipc	a0,0x4
ffffffffc02019e8:	e0c50513          	addi	a0,a0,-500 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc02019ec:	819fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==5);
ffffffffc02019f0:	00004697          	auipc	a3,0x4
ffffffffc02019f4:	eb868693          	addi	a3,a3,-328 # ffffffffc02058a8 <commands+0x988>
ffffffffc02019f8:	00004617          	auipc	a2,0x4
ffffffffc02019fc:	93060613          	addi	a2,a2,-1744 # ffffffffc0205328 <commands+0x408>
ffffffffc0201a00:	05d00593          	li	a1,93
ffffffffc0201a04:	00004517          	auipc	a0,0x4
ffffffffc0201a08:	dec50513          	addi	a0,a0,-532 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201a0c:	ff8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc0201a10:	00004697          	auipc	a3,0x4
ffffffffc0201a14:	dd068693          	addi	a3,a3,-560 # ffffffffc02057e0 <commands+0x8c0>
ffffffffc0201a18:	00004617          	auipc	a2,0x4
ffffffffc0201a1c:	91060613          	addi	a2,a2,-1776 # ffffffffc0205328 <commands+0x408>
ffffffffc0201a20:	05a00593          	li	a1,90
ffffffffc0201a24:	00004517          	auipc	a0,0x4
ffffffffc0201a28:	dcc50513          	addi	a0,a0,-564 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201a2c:	fd8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc0201a30:	00004697          	auipc	a3,0x4
ffffffffc0201a34:	db068693          	addi	a3,a3,-592 # ffffffffc02057e0 <commands+0x8c0>
ffffffffc0201a38:	00004617          	auipc	a2,0x4
ffffffffc0201a3c:	8f060613          	addi	a2,a2,-1808 # ffffffffc0205328 <commands+0x408>
ffffffffc0201a40:	05700593          	li	a1,87
ffffffffc0201a44:	00004517          	auipc	a0,0x4
ffffffffc0201a48:	dac50513          	addi	a0,a0,-596 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201a4c:	fb8fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgfault_num==4);
ffffffffc0201a50:	00004697          	auipc	a3,0x4
ffffffffc0201a54:	d9068693          	addi	a3,a3,-624 # ffffffffc02057e0 <commands+0x8c0>
ffffffffc0201a58:	00004617          	auipc	a2,0x4
ffffffffc0201a5c:	8d060613          	addi	a2,a2,-1840 # ffffffffc0205328 <commands+0x408>
ffffffffc0201a60:	05400593          	li	a1,84
ffffffffc0201a64:	00004517          	auipc	a0,0x4
ffffffffc0201a68:	d8c50513          	addi	a0,a0,-628 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201a6c:	f98fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201a70 <_fifo_swap_out_victim>:
     list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc0201a70:	751c                	ld	a5,40(a0)
{
ffffffffc0201a72:	1141                	addi	sp,sp,-16
ffffffffc0201a74:	e406                	sd	ra,8(sp)
         assert(head != NULL);
ffffffffc0201a76:	cf91                	beqz	a5,ffffffffc0201a92 <_fifo_swap_out_victim+0x22>
     assert(in_tick==0);
ffffffffc0201a78:	ee0d                	bnez	a2,ffffffffc0201ab2 <_fifo_swap_out_victim+0x42>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0201a7a:	679c                	ld	a5,8(a5)
}
ffffffffc0201a7c:	60a2                	ld	ra,8(sp)
ffffffffc0201a7e:	4501                	li	a0,0
    __list_del(listelm->prev, listelm->next);
ffffffffc0201a80:	6394                	ld	a3,0(a5)
ffffffffc0201a82:	6798                	ld	a4,8(a5)
    *ptr_page = le2page(entry, pra_page_link);
ffffffffc0201a84:	fd878793          	addi	a5,a5,-40
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201a88:	e698                	sd	a4,8(a3)
    next->prev = prev;
ffffffffc0201a8a:	e314                	sd	a3,0(a4)
ffffffffc0201a8c:	e19c                	sd	a5,0(a1)
}
ffffffffc0201a8e:	0141                	addi	sp,sp,16
ffffffffc0201a90:	8082                	ret
         assert(head != NULL);
ffffffffc0201a92:	00004697          	auipc	a3,0x4
ffffffffc0201a96:	eae68693          	addi	a3,a3,-338 # ffffffffc0205940 <commands+0xa20>
ffffffffc0201a9a:	00004617          	auipc	a2,0x4
ffffffffc0201a9e:	88e60613          	addi	a2,a2,-1906 # ffffffffc0205328 <commands+0x408>
ffffffffc0201aa2:	04100593          	li	a1,65
ffffffffc0201aa6:	00004517          	auipc	a0,0x4
ffffffffc0201aaa:	d4a50513          	addi	a0,a0,-694 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201aae:	f56fe0ef          	jal	ra,ffffffffc0200204 <__panic>
     assert(in_tick==0);
ffffffffc0201ab2:	00004697          	auipc	a3,0x4
ffffffffc0201ab6:	e9e68693          	addi	a3,a3,-354 # ffffffffc0205950 <commands+0xa30>
ffffffffc0201aba:	00004617          	auipc	a2,0x4
ffffffffc0201abe:	86e60613          	addi	a2,a2,-1938 # ffffffffc0205328 <commands+0x408>
ffffffffc0201ac2:	04200593          	li	a1,66
ffffffffc0201ac6:	00004517          	auipc	a0,0x4
ffffffffc0201aca:	d2a50513          	addi	a0,a0,-726 # ffffffffc02057f0 <commands+0x8d0>
ffffffffc0201ace:	f36fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201ad2 <_fifo_map_swappable>:
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
ffffffffc0201ad2:	751c                	ld	a5,40(a0)
    assert(entry != NULL && head != NULL);
ffffffffc0201ad4:	cb91                	beqz	a5,ffffffffc0201ae8 <_fifo_map_swappable+0x16>
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201ad6:	6394                	ld	a3,0(a5)
ffffffffc0201ad8:	02860713          	addi	a4,a2,40
    prev->next = next->prev = elm;
ffffffffc0201adc:	e398                	sd	a4,0(a5)
ffffffffc0201ade:	e698                	sd	a4,8(a3)
}
ffffffffc0201ae0:	4501                	li	a0,0
    elm->next = next;
ffffffffc0201ae2:	fa1c                	sd	a5,48(a2)
    elm->prev = prev;
ffffffffc0201ae4:	f614                	sd	a3,40(a2)
ffffffffc0201ae6:	8082                	ret
{
ffffffffc0201ae8:	1141                	addi	sp,sp,-16
    assert(entry != NULL && head != NULL);
ffffffffc0201aea:	00004697          	auipc	a3,0x4
ffffffffc0201aee:	e7668693          	addi	a3,a3,-394 # ffffffffc0205960 <commands+0xa40>
ffffffffc0201af2:	00004617          	auipc	a2,0x4
ffffffffc0201af6:	83660613          	addi	a2,a2,-1994 # ffffffffc0205328 <commands+0x408>
ffffffffc0201afa:	03200593          	li	a1,50
ffffffffc0201afe:	00004517          	auipc	a0,0x4
ffffffffc0201b02:	cf250513          	addi	a0,a0,-782 # ffffffffc02057f0 <commands+0x8d0>
{
ffffffffc0201b06:	e406                	sd	ra,8(sp)
    assert(entry != NULL && head != NULL);
ffffffffc0201b08:	efcfe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201b0c <check_vma_overlap.isra.0.part.0>:
}


// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0201b0c:	1141                	addi	sp,sp,-16
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0201b0e:	00004697          	auipc	a3,0x4
ffffffffc0201b12:	e8a68693          	addi	a3,a3,-374 # ffffffffc0205998 <commands+0xa78>
ffffffffc0201b16:	00004617          	auipc	a2,0x4
ffffffffc0201b1a:	81260613          	addi	a2,a2,-2030 # ffffffffc0205328 <commands+0x408>
ffffffffc0201b1e:	06d00593          	li	a1,109
ffffffffc0201b22:	00004517          	auipc	a0,0x4
ffffffffc0201b26:	e9650513          	addi	a0,a0,-362 # ffffffffc02059b8 <commands+0xa98>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next) {
ffffffffc0201b2a:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc0201b2c:	ed8fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201b30 <mm_create>:
mm_create(void) {
ffffffffc0201b30:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201b32:	04000513          	li	a0,64
mm_create(void) {
ffffffffc0201b36:	e022                	sd	s0,0(sp)
ffffffffc0201b38:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0201b3a:	6f8000ef          	jal	ra,ffffffffc0202232 <kmalloc>
ffffffffc0201b3e:	842a                	mv	s0,a0
    if (mm != NULL) {
ffffffffc0201b40:	c505                	beqz	a0,ffffffffc0201b68 <mm_create+0x38>
    elm->prev = elm->next = elm;
ffffffffc0201b42:	e408                	sd	a0,8(s0)
ffffffffc0201b44:	e008                	sd	a0,0(s0)
        mm->mmap_cache = NULL;
ffffffffc0201b46:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0201b4a:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0201b4e:	02052023          	sw	zero,32(a0)
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201b52:	00032797          	auipc	a5,0x32
ffffffffc0201b56:	1567a783          	lw	a5,342(a5) # ffffffffc0233ca8 <swap_init_ok>
ffffffffc0201b5a:	ef81                	bnez	a5,ffffffffc0201b72 <mm_create+0x42>
        else mm->sm_priv = NULL;
ffffffffc0201b5c:	02053423          	sd	zero,40(a0)
    return mm->mm_count;
}

static inline void
set_mm_count(struct mm_struct *mm, int val) {
    mm->mm_count = val;
ffffffffc0201b60:	02042823          	sw	zero,48(s0)

typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock) {
    *lock = 0;
ffffffffc0201b64:	02043c23          	sd	zero,56(s0)
}
ffffffffc0201b68:	60a2                	ld	ra,8(sp)
ffffffffc0201b6a:	8522                	mv	a0,s0
ffffffffc0201b6c:	6402                	ld	s0,0(sp)
ffffffffc0201b6e:	0141                	addi	sp,sp,16
ffffffffc0201b70:	8082                	ret
        if (swap_init_ok) swap_init_mm(mm);
ffffffffc0201b72:	0ed000ef          	jal	ra,ffffffffc020245e <swap_init_mm>
ffffffffc0201b76:	b7ed                	j	ffffffffc0201b60 <mm_create+0x30>

ffffffffc0201b78 <find_vma>:
find_vma(struct mm_struct *mm, uintptr_t addr) {
ffffffffc0201b78:	86aa                	mv	a3,a0
    if (mm != NULL) {
ffffffffc0201b7a:	c505                	beqz	a0,ffffffffc0201ba2 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0201b7c:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0201b7e:	c501                	beqz	a0,ffffffffc0201b86 <find_vma+0xe>
ffffffffc0201b80:	651c                	ld	a5,8(a0)
ffffffffc0201b82:	02f5f263          	bgeu	a1,a5,ffffffffc0201ba6 <find_vma+0x2e>
    return listelm->next;
ffffffffc0201b86:	669c                	ld	a5,8(a3)
                while ((le = list_next(le)) != list) {
ffffffffc0201b88:	00f68d63          	beq	a3,a5,ffffffffc0201ba2 <find_vma+0x2a>
                    if (vma->vm_start<=addr && addr < vma->vm_end) {
ffffffffc0201b8c:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201b90:	00e5e663          	bltu	a1,a4,ffffffffc0201b9c <find_vma+0x24>
ffffffffc0201b94:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201b98:	00e5ec63          	bltu	a1,a4,ffffffffc0201bb0 <find_vma+0x38>
ffffffffc0201b9c:	679c                	ld	a5,8(a5)
                while ((le = list_next(le)) != list) {
ffffffffc0201b9e:	fef697e3          	bne	a3,a5,ffffffffc0201b8c <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0201ba2:	4501                	li	a0,0
}
ffffffffc0201ba4:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr)) {
ffffffffc0201ba6:	691c                	ld	a5,16(a0)
ffffffffc0201ba8:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0201b86 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0201bac:	ea88                	sd	a0,16(a3)
ffffffffc0201bae:	8082                	ret
                    vma = le2vma(le, list_link);
ffffffffc0201bb0:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0201bb4:	ea88                	sd	a0,16(a3)
ffffffffc0201bb6:	8082                	ret

ffffffffc0201bb8 <insert_vma_struct>:


// insert_vma_struct -insert vma in mm's list link
void
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201bb8:	6590                	ld	a2,8(a1)
ffffffffc0201bba:	0105b803          	ld	a6,16(a1)
insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma) {
ffffffffc0201bbe:	1141                	addi	sp,sp,-16
ffffffffc0201bc0:	e406                	sd	ra,8(sp)
ffffffffc0201bc2:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201bc4:	01066763          	bltu	a2,a6,ffffffffc0201bd2 <insert_vma_struct+0x1a>
ffffffffc0201bc8:	a085                	j	ffffffffc0201c28 <insert_vma_struct+0x70>
    list_entry_t *le_prev = list, *le_next;

        list_entry_t *le = list;
        while ((le = list_next(le)) != list) {
            struct vma_struct *mmap_prev = le2vma(le, list_link);
            if (mmap_prev->vm_start > vma->vm_start) {
ffffffffc0201bca:	fe87b703          	ld	a4,-24(a5)
ffffffffc0201bce:	04e66863          	bltu	a2,a4,ffffffffc0201c1e <insert_vma_struct+0x66>
ffffffffc0201bd2:	86be                	mv	a3,a5
ffffffffc0201bd4:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc0201bd6:	fef51ae3          	bne	a0,a5,ffffffffc0201bca <insert_vma_struct+0x12>
        }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list) {
ffffffffc0201bda:	02a68463          	beq	a3,a0,ffffffffc0201c02 <insert_vma_struct+0x4a>
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0201bde:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0201be2:	fe86b883          	ld	a7,-24(a3)
ffffffffc0201be6:	08e8f163          	bgeu	a7,a4,ffffffffc0201c68 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201bea:	04e66f63          	bltu	a2,a4,ffffffffc0201c48 <insert_vma_struct+0x90>
    }
    if (le_next != list) {
ffffffffc0201bee:	00f50a63          	beq	a0,a5,ffffffffc0201c02 <insert_vma_struct+0x4a>
ffffffffc0201bf2:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201bf6:	05076963          	bltu	a4,a6,ffffffffc0201c48 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0201bfa:	ff07b603          	ld	a2,-16(a5)
ffffffffc0201bfe:	02c77363          	bgeu	a4,a2,ffffffffc0201c24 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count ++;
ffffffffc0201c02:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0201c04:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0201c06:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0201c0a:	e390                	sd	a2,0(a5)
ffffffffc0201c0c:	e690                	sd	a2,8(a3)
}
ffffffffc0201c0e:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0201c10:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0201c12:	f194                	sd	a3,32(a1)
    mm->map_count ++;
ffffffffc0201c14:	0017079b          	addiw	a5,a4,1
ffffffffc0201c18:	d11c                	sw	a5,32(a0)
}
ffffffffc0201c1a:	0141                	addi	sp,sp,16
ffffffffc0201c1c:	8082                	ret
    if (le_prev != list) {
ffffffffc0201c1e:	fca690e3          	bne	a3,a0,ffffffffc0201bde <insert_vma_struct+0x26>
ffffffffc0201c22:	bfd1                	j	ffffffffc0201bf6 <insert_vma_struct+0x3e>
ffffffffc0201c24:	ee9ff0ef          	jal	ra,ffffffffc0201b0c <check_vma_overlap.isra.0.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0201c28:	00004697          	auipc	a3,0x4
ffffffffc0201c2c:	da068693          	addi	a3,a3,-608 # ffffffffc02059c8 <commands+0xaa8>
ffffffffc0201c30:	00003617          	auipc	a2,0x3
ffffffffc0201c34:	6f860613          	addi	a2,a2,1784 # ffffffffc0205328 <commands+0x408>
ffffffffc0201c38:	07400593          	li	a1,116
ffffffffc0201c3c:	00004517          	auipc	a0,0x4
ffffffffc0201c40:	d7c50513          	addi	a0,a0,-644 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201c44:	dc0fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0201c48:	00004697          	auipc	a3,0x4
ffffffffc0201c4c:	dc068693          	addi	a3,a3,-576 # ffffffffc0205a08 <commands+0xae8>
ffffffffc0201c50:	00003617          	auipc	a2,0x3
ffffffffc0201c54:	6d860613          	addi	a2,a2,1752 # ffffffffc0205328 <commands+0x408>
ffffffffc0201c58:	06c00593          	li	a1,108
ffffffffc0201c5c:	00004517          	auipc	a0,0x4
ffffffffc0201c60:	d5c50513          	addi	a0,a0,-676 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201c64:	da0fe0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc0201c68:	00004697          	auipc	a3,0x4
ffffffffc0201c6c:	d8068693          	addi	a3,a3,-640 # ffffffffc02059e8 <commands+0xac8>
ffffffffc0201c70:	00003617          	auipc	a2,0x3
ffffffffc0201c74:	6b860613          	addi	a2,a2,1720 # ffffffffc0205328 <commands+0x408>
ffffffffc0201c78:	06b00593          	li	a1,107
ffffffffc0201c7c:	00004517          	auipc	a0,0x4
ffffffffc0201c80:	d3c50513          	addi	a0,a0,-708 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201c84:	d80fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201c88 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void
mm_destroy(struct mm_struct *mm) {
    assert(mm_count(mm) == 0);
ffffffffc0201c88:	591c                	lw	a5,48(a0)
mm_destroy(struct mm_struct *mm) {
ffffffffc0201c8a:	1141                	addi	sp,sp,-16
ffffffffc0201c8c:	e406                	sd	ra,8(sp)
ffffffffc0201c8e:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0201c90:	e785                	bnez	a5,ffffffffc0201cb8 <mm_destroy+0x30>
ffffffffc0201c92:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0201c94:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list) {
ffffffffc0201c96:	00a40c63          	beq	s0,a0,ffffffffc0201cae <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0201c9a:	6118                	ld	a4,0(a0)
ffffffffc0201c9c:	651c                	ld	a5,8(a0)
        list_del(le);
        kfree(le2vma(le, list_link));  //kfree vma        
ffffffffc0201c9e:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0201ca0:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0201ca2:	e398                	sd	a4,0(a5)
ffffffffc0201ca4:	63e000ef          	jal	ra,ffffffffc02022e2 <kfree>
    return listelm->next;
ffffffffc0201ca8:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list) {
ffffffffc0201caa:	fea418e3          	bne	s0,a0,ffffffffc0201c9a <mm_destroy+0x12>
    }
    kfree(mm); //kfree mm
ffffffffc0201cae:	8522                	mv	a0,s0
    mm=NULL;
}
ffffffffc0201cb0:	6402                	ld	s0,0(sp)
ffffffffc0201cb2:	60a2                	ld	ra,8(sp)
ffffffffc0201cb4:	0141                	addi	sp,sp,16
    kfree(mm); //kfree mm
ffffffffc0201cb6:	a535                	j	ffffffffc02022e2 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0201cb8:	00004697          	auipc	a3,0x4
ffffffffc0201cbc:	d7068693          	addi	a3,a3,-656 # ffffffffc0205a28 <commands+0xb08>
ffffffffc0201cc0:	00003617          	auipc	a2,0x3
ffffffffc0201cc4:	66860613          	addi	a2,a2,1640 # ffffffffc0205328 <commands+0x408>
ffffffffc0201cc8:	09400593          	li	a1,148
ffffffffc0201ccc:	00004517          	auipc	a0,0x4
ffffffffc0201cd0:	cec50513          	addi	a0,a0,-788 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201cd4:	d30fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201cd8 <mm_map>:

int
mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
       struct vma_struct **vma_store) {
ffffffffc0201cd8:	7139                	addi	sp,sp,-64
ffffffffc0201cda:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0201cdc:	6405                	lui	s0,0x1
ffffffffc0201cde:	147d                	addi	s0,s0,-1
ffffffffc0201ce0:	77fd                	lui	a5,0xfffff
ffffffffc0201ce2:	9622                	add	a2,a2,s0
ffffffffc0201ce4:	962e                	add	a2,a2,a1
       struct vma_struct **vma_store) {
ffffffffc0201ce6:	f426                	sd	s1,40(sp)
ffffffffc0201ce8:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0201cea:	00f5f4b3          	and	s1,a1,a5
       struct vma_struct **vma_store) {
ffffffffc0201cee:	f04a                	sd	s2,32(sp)
ffffffffc0201cf0:	ec4e                	sd	s3,24(sp)
ffffffffc0201cf2:	e852                	sd	s4,16(sp)
ffffffffc0201cf4:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end)) {
ffffffffc0201cf6:	002005b7          	lui	a1,0x200
ffffffffc0201cfa:	00f67433          	and	s0,a2,a5
ffffffffc0201cfe:	06b4e363          	bltu	s1,a1,ffffffffc0201d64 <mm_map+0x8c>
ffffffffc0201d02:	0684f163          	bgeu	s1,s0,ffffffffc0201d64 <mm_map+0x8c>
ffffffffc0201d06:	4785                	li	a5,1
ffffffffc0201d08:	07fe                	slli	a5,a5,0x1f
ffffffffc0201d0a:	0487ed63          	bltu	a5,s0,ffffffffc0201d64 <mm_map+0x8c>
ffffffffc0201d0e:	89aa                	mv	s3,a0
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0201d10:	cd21                	beqz	a0,ffffffffc0201d68 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start) {
ffffffffc0201d12:	85a6                	mv	a1,s1
ffffffffc0201d14:	8ab6                	mv	s5,a3
ffffffffc0201d16:	8a3a                	mv	s4,a4
ffffffffc0201d18:	e61ff0ef          	jal	ra,ffffffffc0201b78 <find_vma>
ffffffffc0201d1c:	c501                	beqz	a0,ffffffffc0201d24 <mm_map+0x4c>
ffffffffc0201d1e:	651c                	ld	a5,8(a0)
ffffffffc0201d20:	0487e263          	bltu	a5,s0,ffffffffc0201d64 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201d24:	03000513          	li	a0,48
ffffffffc0201d28:	50a000ef          	jal	ra,ffffffffc0202232 <kmalloc>
ffffffffc0201d2c:	892a                	mv	s2,a0
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0201d2e:	5571                	li	a0,-4
    if (vma != NULL) {
ffffffffc0201d30:	02090163          	beqz	s2,ffffffffc0201d52 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL) {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0201d34:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0201d36:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0201d3a:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0201d3e:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0201d42:	85ca                	mv	a1,s2
ffffffffc0201d44:	e75ff0ef          	jal	ra,ffffffffc0201bb8 <insert_vma_struct>
    if (vma_store != NULL) {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0201d48:	4501                	li	a0,0
    if (vma_store != NULL) {
ffffffffc0201d4a:	000a0463          	beqz	s4,ffffffffc0201d52 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0201d4e:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_hello_out_size-0x88a8>

out:
    return ret;
}
ffffffffc0201d52:	70e2                	ld	ra,56(sp)
ffffffffc0201d54:	7442                	ld	s0,48(sp)
ffffffffc0201d56:	74a2                	ld	s1,40(sp)
ffffffffc0201d58:	7902                	ld	s2,32(sp)
ffffffffc0201d5a:	69e2                	ld	s3,24(sp)
ffffffffc0201d5c:	6a42                	ld	s4,16(sp)
ffffffffc0201d5e:	6aa2                	ld	s5,8(sp)
ffffffffc0201d60:	6121                	addi	sp,sp,64
ffffffffc0201d62:	8082                	ret
        return -E_INVAL;
ffffffffc0201d64:	5575                	li	a0,-3
ffffffffc0201d66:	b7f5                	j	ffffffffc0201d52 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0201d68:	00004697          	auipc	a3,0x4
ffffffffc0201d6c:	cd868693          	addi	a3,a3,-808 # ffffffffc0205a40 <commands+0xb20>
ffffffffc0201d70:	00003617          	auipc	a2,0x3
ffffffffc0201d74:	5b860613          	addi	a2,a2,1464 # ffffffffc0205328 <commands+0x408>
ffffffffc0201d78:	0a700593          	li	a1,167
ffffffffc0201d7c:	00004517          	auipc	a0,0x4
ffffffffc0201d80:	c3c50513          	addi	a0,a0,-964 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201d84:	c80fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201d88 <dup_mmap>:

int
dup_mmap(struct mm_struct *to, struct mm_struct *from) {
ffffffffc0201d88:	7139                	addi	sp,sp,-64
ffffffffc0201d8a:	fc06                	sd	ra,56(sp)
ffffffffc0201d8c:	f822                	sd	s0,48(sp)
ffffffffc0201d8e:	f426                	sd	s1,40(sp)
ffffffffc0201d90:	f04a                	sd	s2,32(sp)
ffffffffc0201d92:	ec4e                	sd	s3,24(sp)
ffffffffc0201d94:	e852                	sd	s4,16(sp)
ffffffffc0201d96:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0201d98:	c52d                	beqz	a0,ffffffffc0201e02 <dup_mmap+0x7a>
ffffffffc0201d9a:	892a                	mv	s2,a0
ffffffffc0201d9c:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0201d9e:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0201da0:	e595                	bnez	a1,ffffffffc0201dcc <dup_mmap+0x44>
ffffffffc0201da2:	a085                	j	ffffffffc0201e02 <dup_mmap+0x7a>
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
        if (nvma == NULL) {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0201da4:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0201da6:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_rr_out_size+0x1f5608>
        vma->vm_end = vm_end;
ffffffffc0201daa:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0201dae:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0201db2:	e07ff0ef          	jal	ra,ffffffffc0201bb8 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0) {
ffffffffc0201db6:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_hello_out_size-0x88b8>
ffffffffc0201dba:	fe843603          	ld	a2,-24(s0)
ffffffffc0201dbe:	6c8c                	ld	a1,24(s1)
ffffffffc0201dc0:	01893503          	ld	a0,24(s2)
ffffffffc0201dc4:	4701                	li	a4,0
ffffffffc0201dc6:	e94ff0ef          	jal	ra,ffffffffc020145a <copy_range>
ffffffffc0201dca:	e105                	bnez	a0,ffffffffc0201dea <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0201dcc:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list) {
ffffffffc0201dce:	02848863          	beq	s1,s0,ffffffffc0201dfe <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201dd2:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0201dd6:	fe843a83          	ld	s5,-24(s0)
ffffffffc0201dda:	ff043a03          	ld	s4,-16(s0)
ffffffffc0201dde:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0201de2:	450000ef          	jal	ra,ffffffffc0202232 <kmalloc>
ffffffffc0201de6:	85aa                	mv	a1,a0
    if (vma != NULL) {
ffffffffc0201de8:	fd55                	bnez	a0,ffffffffc0201da4 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0201dea:	5571                	li	a0,-4
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0201dec:	70e2                	ld	ra,56(sp)
ffffffffc0201dee:	7442                	ld	s0,48(sp)
ffffffffc0201df0:	74a2                	ld	s1,40(sp)
ffffffffc0201df2:	7902                	ld	s2,32(sp)
ffffffffc0201df4:	69e2                	ld	s3,24(sp)
ffffffffc0201df6:	6a42                	ld	s4,16(sp)
ffffffffc0201df8:	6aa2                	ld	s5,8(sp)
ffffffffc0201dfa:	6121                	addi	sp,sp,64
ffffffffc0201dfc:	8082                	ret
    return 0;
ffffffffc0201dfe:	4501                	li	a0,0
ffffffffc0201e00:	b7f5                	j	ffffffffc0201dec <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0201e02:	00004697          	auipc	a3,0x4
ffffffffc0201e06:	c4e68693          	addi	a3,a3,-946 # ffffffffc0205a50 <commands+0xb30>
ffffffffc0201e0a:	00003617          	auipc	a2,0x3
ffffffffc0201e0e:	51e60613          	addi	a2,a2,1310 # ffffffffc0205328 <commands+0x408>
ffffffffc0201e12:	0c000593          	li	a1,192
ffffffffc0201e16:	00004517          	auipc	a0,0x4
ffffffffc0201e1a:	ba250513          	addi	a0,a0,-1118 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201e1e:	be6fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201e22 <exit_mmap>:

void
exit_mmap(struct mm_struct *mm) {
ffffffffc0201e22:	1101                	addi	sp,sp,-32
ffffffffc0201e24:	ec06                	sd	ra,24(sp)
ffffffffc0201e26:	e822                	sd	s0,16(sp)
ffffffffc0201e28:	e426                	sd	s1,8(sp)
ffffffffc0201e2a:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201e2c:	c531                	beqz	a0,ffffffffc0201e78 <exit_mmap+0x56>
ffffffffc0201e2e:	591c                	lw	a5,48(a0)
ffffffffc0201e30:	84aa                	mv	s1,a0
ffffffffc0201e32:	e3b9                	bnez	a5,ffffffffc0201e78 <exit_mmap+0x56>
    return listelm->next;
ffffffffc0201e34:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0201e36:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list) {
ffffffffc0201e3a:	02850663          	beq	a0,s0,ffffffffc0201e66 <exit_mmap+0x44>
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201e3e:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e42:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e46:	854a                	mv	a0,s2
ffffffffc0201e48:	b42ff0ef          	jal	ra,ffffffffc020118a <unmap_range>
ffffffffc0201e4c:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201e4e:	fe8498e3          	bne	s1,s0,ffffffffc0201e3e <exit_mmap+0x1c>
ffffffffc0201e52:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list) {
ffffffffc0201e54:	00848c63          	beq	s1,s0,ffffffffc0201e6c <exit_mmap+0x4a>
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0201e58:	ff043603          	ld	a2,-16(s0)
ffffffffc0201e5c:	fe843583          	ld	a1,-24(s0)
ffffffffc0201e60:	854a                	mv	a0,s2
ffffffffc0201e62:	c3eff0ef          	jal	ra,ffffffffc02012a0 <exit_range>
ffffffffc0201e66:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list) {
ffffffffc0201e68:	fe8498e3          	bne	s1,s0,ffffffffc0201e58 <exit_mmap+0x36>
    }
}
ffffffffc0201e6c:	60e2                	ld	ra,24(sp)
ffffffffc0201e6e:	6442                	ld	s0,16(sp)
ffffffffc0201e70:	64a2                	ld	s1,8(sp)
ffffffffc0201e72:	6902                	ld	s2,0(sp)
ffffffffc0201e74:	6105                	addi	sp,sp,32
ffffffffc0201e76:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0201e78:	00004697          	auipc	a3,0x4
ffffffffc0201e7c:	bf868693          	addi	a3,a3,-1032 # ffffffffc0205a70 <commands+0xb50>
ffffffffc0201e80:	00003617          	auipc	a2,0x3
ffffffffc0201e84:	4a860613          	addi	a2,a2,1192 # ffffffffc0205328 <commands+0x408>
ffffffffc0201e88:	0d600593          	li	a1,214
ffffffffc0201e8c:	00004517          	auipc	a0,0x4
ffffffffc0201e90:	b2c50513          	addi	a0,a0,-1236 # ffffffffc02059b8 <commands+0xa98>
ffffffffc0201e94:	b70fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0201e98 <vmm_init>:
// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void
vmm_init(void) {
    //check_vmm();
}
ffffffffc0201e98:	8082                	ret

ffffffffc0201e9a <do_pgfault>:
 *            was a read (0) or write (1).
 *         -- The U/S flag (bit 2) indicates whether the processor was executing at user mode (1)
 *            or supervisor mode (0) at the time of the exception.
 */
int
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201e9a:	7139                	addi	sp,sp,-64
    int ret = -E_INVAL;
    //try to find a vma which include addr
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201e9c:	85b2                	mv	a1,a2
do_pgfault(struct mm_struct *mm, uint_t error_code, uintptr_t addr) {
ffffffffc0201e9e:	f822                	sd	s0,48(sp)
ffffffffc0201ea0:	f426                	sd	s1,40(sp)
ffffffffc0201ea2:	fc06                	sd	ra,56(sp)
ffffffffc0201ea4:	f04a                	sd	s2,32(sp)
ffffffffc0201ea6:	ec4e                	sd	s3,24(sp)
ffffffffc0201ea8:	8432                	mv	s0,a2
ffffffffc0201eaa:	84aa                	mv	s1,a0
    struct vma_struct *vma = find_vma(mm, addr);
ffffffffc0201eac:	ccdff0ef          	jal	ra,ffffffffc0201b78 <find_vma>

    pgfault_num++;
ffffffffc0201eb0:	00032797          	auipc	a5,0x32
ffffffffc0201eb4:	de07a783          	lw	a5,-544(a5) # ffffffffc0233c90 <pgfault_num>
ffffffffc0201eb8:	2785                	addiw	a5,a5,1
ffffffffc0201eba:	00032717          	auipc	a4,0x32
ffffffffc0201ebe:	dcf72b23          	sw	a5,-554(a4) # ffffffffc0233c90 <pgfault_num>
    //If the addr is in the range of a mm's vma?
    if (vma == NULL || vma->vm_start > addr) {
ffffffffc0201ec2:	c545                	beqz	a0,ffffffffc0201f6a <do_pgfault+0xd0>
ffffffffc0201ec4:	651c                	ld	a5,8(a0)
ffffffffc0201ec6:	0af46263          	bltu	s0,a5,ffffffffc0201f6a <do_pgfault+0xd0>
     *    (read  an non_existed addr && addr is readable)
     * THEN
     *    continue process
     */
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201eca:	4d1c                	lw	a5,24(a0)
    uint32_t perm = PTE_U;
ffffffffc0201ecc:	49c1                	li	s3,16
    if (vma->vm_flags & VM_WRITE) {
ffffffffc0201ece:	8b89                	andi	a5,a5,2
ffffffffc0201ed0:	efb1                	bnez	a5,ffffffffc0201f2c <do_pgfault+0x92>
        perm |= READ_WRITE;
    }
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201ed2:	75fd                	lui	a1,0xfffff
    *   mm->pgdir : the PDT of these vma
    *
    */
    // try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.
    // (notice the 3th parameter '1')
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201ed4:	6c88                	ld	a0,24(s1)
    addr = ROUNDDOWN(addr, PGSIZE);
ffffffffc0201ed6:	8c6d                	and	s0,s0,a1
    if ((ptep = get_pte(mm->pgdir, addr, 1)) == NULL) {
ffffffffc0201ed8:	4605                	li	a2,1
ffffffffc0201eda:	85a2                	mv	a1,s0
ffffffffc0201edc:	8dcff0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc0201ee0:	c555                	beqz	a0,ffffffffc0201f8c <do_pgfault+0xf2>
        cprintf("get_pte in do_pgfault failed\n");
        goto failed;
    }
    
    if (*ptep == 0) { // if the phy addr isn't exist, then alloc a page & map the phy addr with logical addr
ffffffffc0201ee2:	610c                	ld	a1,0(a0)
ffffffffc0201ee4:	c5a5                	beqz	a1,ffffffffc0201f4c <do_pgfault+0xb2>
            goto failed;
        }
    }
    else { // if this pte is a swap entry, then load data from disk to a page with phy addr
           // and call page_insert to map the phy addr with logical addr
        if(swap_init_ok) {
ffffffffc0201ee6:	00032797          	auipc	a5,0x32
ffffffffc0201eea:	dc27a783          	lw	a5,-574(a5) # ffffffffc0233ca8 <swap_init_ok>
ffffffffc0201eee:	c7d9                	beqz	a5,ffffffffc0201f7c <do_pgfault+0xe2>
            struct Page *page=NULL;
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201ef0:	0030                	addi	a2,sp,8
ffffffffc0201ef2:	85a2                	mv	a1,s0
ffffffffc0201ef4:	8526                	mv	a0,s1
            struct Page *page=NULL;
ffffffffc0201ef6:	e402                	sd	zero,8(sp)
            if ((ret = swap_in(mm, addr, &page)) != 0) {
ffffffffc0201ef8:	696000ef          	jal	ra,ffffffffc020258e <swap_in>
ffffffffc0201efc:	892a                	mv	s2,a0
ffffffffc0201efe:	e90d                	bnez	a0,ffffffffc0201f30 <do_pgfault+0x96>
                cprintf("swap_in in do_pgfault failed\n");
                goto failed;
            }    
            page_insert(mm->pgdir, page, addr, perm);
ffffffffc0201f00:	65a2                	ld	a1,8(sp)
ffffffffc0201f02:	6c88                	ld	a0,24(s1)
ffffffffc0201f04:	86ce                	mv	a3,s3
ffffffffc0201f06:	8622                	mv	a2,s0
ffffffffc0201f08:	c96ff0ef          	jal	ra,ffffffffc020139e <page_insert>
            swap_map_swappable(mm, addr, page, 1);
ffffffffc0201f0c:	6622                	ld	a2,8(sp)
ffffffffc0201f0e:	4685                	li	a3,1
ffffffffc0201f10:	85a2                	mv	a1,s0
ffffffffc0201f12:	8526                	mv	a0,s1
ffffffffc0201f14:	558000ef          	jal	ra,ffffffffc020246c <swap_map_swappable>
            page->pra_vaddr = addr;
ffffffffc0201f18:	67a2                	ld	a5,8(sp)
ffffffffc0201f1a:	ff80                	sd	s0,56(a5)
        }
   }
   ret = 0;
failed:
    return ret;
}
ffffffffc0201f1c:	70e2                	ld	ra,56(sp)
ffffffffc0201f1e:	7442                	ld	s0,48(sp)
ffffffffc0201f20:	74a2                	ld	s1,40(sp)
ffffffffc0201f22:	69e2                	ld	s3,24(sp)
ffffffffc0201f24:	854a                	mv	a0,s2
ffffffffc0201f26:	7902                	ld	s2,32(sp)
ffffffffc0201f28:	6121                	addi	sp,sp,64
ffffffffc0201f2a:	8082                	ret
        perm |= READ_WRITE;
ffffffffc0201f2c:	49dd                	li	s3,23
ffffffffc0201f2e:	b755                	j	ffffffffc0201ed2 <do_pgfault+0x38>
                cprintf("swap_in in do_pgfault failed\n");
ffffffffc0201f30:	00004517          	auipc	a0,0x4
ffffffffc0201f34:	bd850513          	addi	a0,a0,-1064 # ffffffffc0205b08 <commands+0xbe8>
ffffffffc0201f38:	990fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc0201f3c:	70e2                	ld	ra,56(sp)
ffffffffc0201f3e:	7442                	ld	s0,48(sp)
ffffffffc0201f40:	74a2                	ld	s1,40(sp)
ffffffffc0201f42:	69e2                	ld	s3,24(sp)
ffffffffc0201f44:	854a                	mv	a0,s2
ffffffffc0201f46:	7902                	ld	s2,32(sp)
ffffffffc0201f48:	6121                	addi	sp,sp,64
ffffffffc0201f4a:	8082                	ret
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201f4c:	6c88                	ld	a0,24(s1)
ffffffffc0201f4e:	864e                	mv	a2,s3
ffffffffc0201f50:	85a2                	mv	a1,s0
ffffffffc0201f52:	f3eff0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
   ret = 0;
ffffffffc0201f56:	4901                	li	s2,0
        if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
ffffffffc0201f58:	f171                	bnez	a0,ffffffffc0201f1c <do_pgfault+0x82>
            cprintf("pgdir_alloc_page in do_pgfault failed\n");
ffffffffc0201f5a:	00004517          	auipc	a0,0x4
ffffffffc0201f5e:	b8650513          	addi	a0,a0,-1146 # ffffffffc0205ae0 <commands+0xbc0>
ffffffffc0201f62:	966fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f66:	5971                	li	s2,-4
            goto failed;
ffffffffc0201f68:	bf55                	j	ffffffffc0201f1c <do_pgfault+0x82>
        cprintf("not valid addr %x, and  can not find it in vma\n", addr);
ffffffffc0201f6a:	85a2                	mv	a1,s0
ffffffffc0201f6c:	00004517          	auipc	a0,0x4
ffffffffc0201f70:	b2450513          	addi	a0,a0,-1244 # ffffffffc0205a90 <commands+0xb70>
ffffffffc0201f74:	954fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    int ret = -E_INVAL;
ffffffffc0201f78:	5975                	li	s2,-3
        goto failed;
ffffffffc0201f7a:	b74d                	j	ffffffffc0201f1c <do_pgfault+0x82>
            cprintf("no swap_init_ok but ptep is %x, failed\n",*ptep);
ffffffffc0201f7c:	00004517          	auipc	a0,0x4
ffffffffc0201f80:	bac50513          	addi	a0,a0,-1108 # ffffffffc0205b28 <commands+0xc08>
ffffffffc0201f84:	944fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f88:	5971                	li	s2,-4
            goto failed;
ffffffffc0201f8a:	bf49                	j	ffffffffc0201f1c <do_pgfault+0x82>
        cprintf("get_pte in do_pgfault failed\n");
ffffffffc0201f8c:	00004517          	auipc	a0,0x4
ffffffffc0201f90:	b3450513          	addi	a0,a0,-1228 # ffffffffc0205ac0 <commands+0xba0>
ffffffffc0201f94:	934fe0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    ret = -E_NO_MEM;
ffffffffc0201f98:	5971                	li	s2,-4
        goto failed;
ffffffffc0201f9a:	b749                	j	ffffffffc0201f1c <do_pgfault+0x82>

ffffffffc0201f9c <user_mem_check>:

bool
user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write) {
ffffffffc0201f9c:	7179                	addi	sp,sp,-48
ffffffffc0201f9e:	f022                	sd	s0,32(sp)
ffffffffc0201fa0:	f406                	sd	ra,40(sp)
ffffffffc0201fa2:	ec26                	sd	s1,24(sp)
ffffffffc0201fa4:	e84a                	sd	s2,16(sp)
ffffffffc0201fa6:	e44e                	sd	s3,8(sp)
ffffffffc0201fa8:	e052                	sd	s4,0(sp)
ffffffffc0201faa:	842e                	mv	s0,a1
    if (mm != NULL) {
ffffffffc0201fac:	c135                	beqz	a0,ffffffffc0202010 <user_mem_check+0x74>
        if (!USER_ACCESS(addr, addr + len)) {
ffffffffc0201fae:	002007b7          	lui	a5,0x200
ffffffffc0201fb2:	04f5e663          	bltu	a1,a5,ffffffffc0201ffe <user_mem_check+0x62>
ffffffffc0201fb6:	00c584b3          	add	s1,a1,a2
ffffffffc0201fba:	0495f263          	bgeu	a1,s1,ffffffffc0201ffe <user_mem_check+0x62>
ffffffffc0201fbe:	4785                	li	a5,1
ffffffffc0201fc0:	07fe                	slli	a5,a5,0x1f
ffffffffc0201fc2:	0297ee63          	bltu	a5,s1,ffffffffc0201ffe <user_mem_check+0x62>
ffffffffc0201fc6:	892a                	mv	s2,a0
ffffffffc0201fc8:	89b6                	mv	s3,a3
            }
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK)) {
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201fca:	6a05                	lui	s4,0x1
ffffffffc0201fcc:	a821                	j	ffffffffc0201fe4 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201fce:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201fd2:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201fd4:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201fd6:	c685                	beqz	a3,ffffffffc0201ffe <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK)) {
ffffffffc0201fd8:	c399                	beqz	a5,ffffffffc0201fde <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE) { //check stack start & size
ffffffffc0201fda:	02e46263          	bltu	s0,a4,ffffffffc0201ffe <user_mem_check+0x62>
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0201fde:	6900                	ld	s0,16(a0)
        while (start < end) {
ffffffffc0201fe0:	04947663          	bgeu	s0,s1,ffffffffc020202c <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start) {
ffffffffc0201fe4:	85a2                	mv	a1,s0
ffffffffc0201fe6:	854a                	mv	a0,s2
ffffffffc0201fe8:	b91ff0ef          	jal	ra,ffffffffc0201b78 <find_vma>
ffffffffc0201fec:	c909                	beqz	a0,ffffffffc0201ffe <user_mem_check+0x62>
ffffffffc0201fee:	6518                	ld	a4,8(a0)
ffffffffc0201ff0:	00e46763          	bltu	s0,a4,ffffffffc0201ffe <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ))) {
ffffffffc0201ff4:	4d1c                	lw	a5,24(a0)
ffffffffc0201ff6:	fc099ce3          	bnez	s3,ffffffffc0201fce <user_mem_check+0x32>
ffffffffc0201ffa:	8b85                	andi	a5,a5,1
ffffffffc0201ffc:	f3ed                	bnez	a5,ffffffffc0201fde <user_mem_check+0x42>
            return 0;
ffffffffc0201ffe:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0202000:	70a2                	ld	ra,40(sp)
ffffffffc0202002:	7402                	ld	s0,32(sp)
ffffffffc0202004:	64e2                	ld	s1,24(sp)
ffffffffc0202006:	6942                	ld	s2,16(sp)
ffffffffc0202008:	69a2                	ld	s3,8(sp)
ffffffffc020200a:	6a02                	ld	s4,0(sp)
ffffffffc020200c:	6145                	addi	sp,sp,48
ffffffffc020200e:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0202010:	c02007b7          	lui	a5,0xc0200
ffffffffc0202014:	4501                	li	a0,0
ffffffffc0202016:	fef5e5e3          	bltu	a1,a5,ffffffffc0202000 <user_mem_check+0x64>
ffffffffc020201a:	962e                	add	a2,a2,a1
ffffffffc020201c:	fec5f2e3          	bgeu	a1,a2,ffffffffc0202000 <user_mem_check+0x64>
ffffffffc0202020:	c8000537          	lui	a0,0xc8000
ffffffffc0202024:	0505                	addi	a0,a0,1
ffffffffc0202026:	00a63533          	sltu	a0,a2,a0
ffffffffc020202a:	bfd9                	j	ffffffffc0202000 <user_mem_check+0x64>
        return 1;
ffffffffc020202c:	4505                	li	a0,1
ffffffffc020202e:	bfc9                	j	ffffffffc0202000 <user_mem_check+0x64>

ffffffffc0202030 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0202030:	c145                	beqz	a0,ffffffffc02020d0 <slob_free+0xa0>
{
ffffffffc0202032:	1141                	addi	sp,sp,-16
ffffffffc0202034:	e022                	sd	s0,0(sp)
ffffffffc0202036:	e406                	sd	ra,8(sp)
ffffffffc0202038:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc020203a:	edb1                	bnez	a1,ffffffffc0202096 <slob_free+0x66>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020203c:	100027f3          	csrr	a5,sstatus
ffffffffc0202040:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0202042:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202044:	e3ad                	bnez	a5,ffffffffc02020a6 <slob_free+0x76>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0202046:	00026617          	auipc	a2,0x26
ffffffffc020204a:	7f260613          	addi	a2,a2,2034 # ffffffffc0228838 <slobfree>
ffffffffc020204e:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0202050:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0202052:	0087fa63          	bgeu	a5,s0,ffffffffc0202066 <slob_free+0x36>
ffffffffc0202056:	00e46c63          	bltu	s0,a4,ffffffffc020206e <slob_free+0x3e>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020205a:	00e7fa63          	bgeu	a5,a4,ffffffffc020206e <slob_free+0x3e>
    return 0;
ffffffffc020205e:	87ba                	mv	a5,a4
ffffffffc0202060:	6798                	ld	a4,8(a5)
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0202062:	fe87eae3          	bltu	a5,s0,ffffffffc0202056 <slob_free+0x26>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0202066:	fee7ece3          	bltu	a5,a4,ffffffffc020205e <slob_free+0x2e>
ffffffffc020206a:	fee47ae3          	bgeu	s0,a4,ffffffffc020205e <slob_free+0x2e>
			break;

	if (b + b->units == cur->next) {
ffffffffc020206e:	400c                	lw	a1,0(s0)
ffffffffc0202070:	00459693          	slli	a3,a1,0x4
ffffffffc0202074:	96a2                	add	a3,a3,s0
ffffffffc0202076:	04d70763          	beq	a4,a3,ffffffffc02020c4 <slob_free+0x94>
		b->units += cur->next->units;
		b->next = cur->next->next;
	} else
		b->next = cur->next;
ffffffffc020207a:	e418                	sd	a4,8(s0)

	if (cur + cur->units == b) {
ffffffffc020207c:	4394                	lw	a3,0(a5)
ffffffffc020207e:	00469713          	slli	a4,a3,0x4
ffffffffc0202082:	973e                	add	a4,a4,a5
ffffffffc0202084:	02e40a63          	beq	s0,a4,ffffffffc02020b8 <slob_free+0x88>
		cur->units += b->units;
		cur->next = b->next;
	} else
		cur->next = b;
ffffffffc0202088:	e780                	sd	s0,8(a5)

	slobfree = cur;
ffffffffc020208a:	e21c                	sd	a5,0(a2)
    if (flag) {
ffffffffc020208c:	e10d                	bnez	a0,ffffffffc02020ae <slob_free+0x7e>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc020208e:	60a2                	ld	ra,8(sp)
ffffffffc0202090:	6402                	ld	s0,0(sp)
ffffffffc0202092:	0141                	addi	sp,sp,16
ffffffffc0202094:	8082                	ret
		b->units = SLOB_UNITS(size);
ffffffffc0202096:	05bd                	addi	a1,a1,15
ffffffffc0202098:	8191                	srli	a1,a1,0x4
ffffffffc020209a:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020209c:	100027f3          	csrr	a5,sstatus
ffffffffc02020a0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02020a2:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02020a4:	d3cd                	beqz	a5,ffffffffc0202046 <slob_free+0x16>
        intr_disable();
ffffffffc02020a6:	d8cfe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc02020aa:	4505                	li	a0,1
ffffffffc02020ac:	bf69                	j	ffffffffc0202046 <slob_free+0x16>
}
ffffffffc02020ae:	6402                	ld	s0,0(sp)
ffffffffc02020b0:	60a2                	ld	ra,8(sp)
ffffffffc02020b2:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc02020b4:	d78fe06f          	j	ffffffffc020062c <intr_enable>
		cur->units += b->units;
ffffffffc02020b8:	4018                	lw	a4,0(s0)
		cur->next = b->next;
ffffffffc02020ba:	640c                	ld	a1,8(s0)
		cur->units += b->units;
ffffffffc02020bc:	9eb9                	addw	a3,a3,a4
ffffffffc02020be:	c394                	sw	a3,0(a5)
		cur->next = b->next;
ffffffffc02020c0:	e78c                	sd	a1,8(a5)
ffffffffc02020c2:	b7e1                	j	ffffffffc020208a <slob_free+0x5a>
		b->units += cur->next->units;
ffffffffc02020c4:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc02020c6:	6718                	ld	a4,8(a4)
		b->units += cur->next->units;
ffffffffc02020c8:	9db5                	addw	a1,a1,a3
ffffffffc02020ca:	c00c                	sw	a1,0(s0)
		b->next = cur->next->next;
ffffffffc02020cc:	e418                	sd	a4,8(s0)
ffffffffc02020ce:	b77d                	j	ffffffffc020207c <slob_free+0x4c>
ffffffffc02020d0:	8082                	ret

ffffffffc02020d2 <__slob_get_free_pages.isra.0>:
  struct Page * page = alloc_pages(1 << order);
ffffffffc02020d2:	4785                	li	a5,1
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02020d4:	1141                	addi	sp,sp,-16
  struct Page * page = alloc_pages(1 << order);
ffffffffc02020d6:	00a7953b          	sllw	a0,a5,a0
static void* __slob_get_free_pages(gfp_t gfp, int order)
ffffffffc02020da:	e406                	sd	ra,8(sp)
  struct Page * page = alloc_pages(1 << order);
ffffffffc02020dc:	c77fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
  if(!page)
ffffffffc02020e0:	c91d                	beqz	a0,ffffffffc0202116 <__slob_get_free_pages.isra.0+0x44>
    return page - pages + nbase;
ffffffffc02020e2:	00032697          	auipc	a3,0x32
ffffffffc02020e6:	c1e6b683          	ld	a3,-994(a3) # ffffffffc0233d00 <pages>
ffffffffc02020ea:	8d15                	sub	a0,a0,a3
ffffffffc02020ec:	8519                	srai	a0,a0,0x6
ffffffffc02020ee:	00005697          	auipc	a3,0x5
ffffffffc02020f2:	9b26b683          	ld	a3,-1614(a3) # ffffffffc0206aa0 <nbase>
ffffffffc02020f6:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc02020f8:	00c51793          	slli	a5,a0,0xc
ffffffffc02020fc:	83b1                	srli	a5,a5,0xc
ffffffffc02020fe:	00032717          	auipc	a4,0x32
ffffffffc0202102:	b8a73703          	ld	a4,-1142(a4) # ffffffffc0233c88 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0202106:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0202108:	00e7fa63          	bgeu	a5,a4,ffffffffc020211c <__slob_get_free_pages.isra.0+0x4a>
ffffffffc020210c:	00032697          	auipc	a3,0x32
ffffffffc0202110:	be46b683          	ld	a3,-1052(a3) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0202114:	9536                	add	a0,a0,a3
}
ffffffffc0202116:	60a2                	ld	ra,8(sp)
ffffffffc0202118:	0141                	addi	sp,sp,16
ffffffffc020211a:	8082                	ret
ffffffffc020211c:	86aa                	mv	a3,a0
ffffffffc020211e:	00003617          	auipc	a2,0x3
ffffffffc0202122:	5ba60613          	addi	a2,a2,1466 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc0202126:	06900593          	li	a1,105
ffffffffc020212a:	00003517          	auipc	a0,0x3
ffffffffc020212e:	50e50513          	addi	a0,a0,1294 # ffffffffc0205638 <commands+0x718>
ffffffffc0202132:	8d2fe0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202136 <slob_alloc.isra.0.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0202136:	1101                	addi	sp,sp,-32
ffffffffc0202138:	ec06                	sd	ra,24(sp)
ffffffffc020213a:	e822                	sd	s0,16(sp)
ffffffffc020213c:	e426                	sd	s1,8(sp)
ffffffffc020213e:	e04a                	sd	s2,0(sp)
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc0202140:	01050713          	addi	a4,a0,16
ffffffffc0202144:	6785                	lui	a5,0x1
ffffffffc0202146:	0cf77363          	bgeu	a4,a5,ffffffffc020220c <slob_alloc.isra.0.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc020214a:	00f50493          	addi	s1,a0,15
ffffffffc020214e:	8091                	srli	s1,s1,0x4
ffffffffc0202150:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202152:	10002673          	csrr	a2,sstatus
ffffffffc0202156:	8a09                	andi	a2,a2,2
ffffffffc0202158:	e25d                	bnez	a2,ffffffffc02021fe <slob_alloc.isra.0.constprop.0+0xc8>
	prev = slobfree;
ffffffffc020215a:	00026917          	auipc	s2,0x26
ffffffffc020215e:	6de90913          	addi	s2,s2,1758 # ffffffffc0228838 <slobfree>
ffffffffc0202162:	00093683          	ld	a3,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0202166:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202168:	4398                	lw	a4,0(a5)
ffffffffc020216a:	08975e63          	bge	a4,s1,ffffffffc0202206 <slob_alloc.isra.0.constprop.0+0xd0>
		if (cur == slobfree) {
ffffffffc020216e:	00d78b63          	beq	a5,a3,ffffffffc0202184 <slob_alloc.isra.0.constprop.0+0x4e>
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc0202172:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202174:	4018                	lw	a4,0(s0)
ffffffffc0202176:	02975a63          	bge	a4,s1,ffffffffc02021aa <slob_alloc.isra.0.constprop.0+0x74>
ffffffffc020217a:	00093683          	ld	a3,0(s2)
ffffffffc020217e:	87a2                	mv	a5,s0
		if (cur == slobfree) {
ffffffffc0202180:	fed799e3          	bne	a5,a3,ffffffffc0202172 <slob_alloc.isra.0.constprop.0+0x3c>
    if (flag) {
ffffffffc0202184:	ee31                	bnez	a2,ffffffffc02021e0 <slob_alloc.isra.0.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0202186:	4501                	li	a0,0
ffffffffc0202188:	f4bff0ef          	jal	ra,ffffffffc02020d2 <__slob_get_free_pages.isra.0>
ffffffffc020218c:	842a                	mv	s0,a0
			if (!cur)
ffffffffc020218e:	cd05                	beqz	a0,ffffffffc02021c6 <slob_alloc.isra.0.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0202190:	6585                	lui	a1,0x1
ffffffffc0202192:	e9fff0ef          	jal	ra,ffffffffc0202030 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202196:	10002673          	csrr	a2,sstatus
ffffffffc020219a:	8a09                	andi	a2,a2,2
ffffffffc020219c:	ee05                	bnez	a2,ffffffffc02021d4 <slob_alloc.isra.0.constprop.0+0x9e>
			cur = slobfree;
ffffffffc020219e:	00093783          	ld	a5,0(s2)
	for (cur = prev->next; ; prev = cur, cur = cur->next) {
ffffffffc02021a2:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc02021a4:	4018                	lw	a4,0(s0)
ffffffffc02021a6:	fc974ae3          	blt	a4,s1,ffffffffc020217a <slob_alloc.isra.0.constprop.0+0x44>
			if (cur->units == units) /* exact fit? */
ffffffffc02021aa:	04e48763          	beq	s1,a4,ffffffffc02021f8 <slob_alloc.isra.0.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc02021ae:	00449693          	slli	a3,s1,0x4
ffffffffc02021b2:	96a2                	add	a3,a3,s0
ffffffffc02021b4:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc02021b6:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc02021b8:	9f05                	subw	a4,a4,s1
ffffffffc02021ba:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc02021bc:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc02021be:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc02021c0:	00f93023          	sd	a5,0(s2)
    if (flag) {
ffffffffc02021c4:	e20d                	bnez	a2,ffffffffc02021e6 <slob_alloc.isra.0.constprop.0+0xb0>
}
ffffffffc02021c6:	60e2                	ld	ra,24(sp)
ffffffffc02021c8:	8522                	mv	a0,s0
ffffffffc02021ca:	6442                	ld	s0,16(sp)
ffffffffc02021cc:	64a2                	ld	s1,8(sp)
ffffffffc02021ce:	6902                	ld	s2,0(sp)
ffffffffc02021d0:	6105                	addi	sp,sp,32
ffffffffc02021d2:	8082                	ret
        intr_disable();
ffffffffc02021d4:	c5efe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
			cur = slobfree;
ffffffffc02021d8:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc02021dc:	4605                	li	a2,1
ffffffffc02021de:	b7d1                	j	ffffffffc02021a2 <slob_alloc.isra.0.constprop.0+0x6c>
        intr_enable();
ffffffffc02021e0:	c4cfe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02021e4:	b74d                	j	ffffffffc0202186 <slob_alloc.isra.0.constprop.0+0x50>
ffffffffc02021e6:	c46fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
}
ffffffffc02021ea:	60e2                	ld	ra,24(sp)
ffffffffc02021ec:	8522                	mv	a0,s0
ffffffffc02021ee:	6442                	ld	s0,16(sp)
ffffffffc02021f0:	64a2                	ld	s1,8(sp)
ffffffffc02021f2:	6902                	ld	s2,0(sp)
ffffffffc02021f4:	6105                	addi	sp,sp,32
ffffffffc02021f6:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc02021f8:	6418                	ld	a4,8(s0)
ffffffffc02021fa:	e798                	sd	a4,8(a5)
ffffffffc02021fc:	b7d1                	j	ffffffffc02021c0 <slob_alloc.isra.0.constprop.0+0x8a>
        intr_disable();
ffffffffc02021fe:	c34fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0202202:	4605                	li	a2,1
ffffffffc0202204:	bf99                	j	ffffffffc020215a <slob_alloc.isra.0.constprop.0+0x24>
		if (cur->units >= units + delta) { /* room enough? */
ffffffffc0202206:	843e                	mv	s0,a5
ffffffffc0202208:	87b6                	mv	a5,a3
ffffffffc020220a:	b745                	j	ffffffffc02021aa <slob_alloc.isra.0.constprop.0+0x74>
  assert( (size + SLOB_UNIT) < PAGE_SIZE );
ffffffffc020220c:	00004697          	auipc	a3,0x4
ffffffffc0202210:	94468693          	addi	a3,a3,-1724 # ffffffffc0205b50 <commands+0xc30>
ffffffffc0202214:	00003617          	auipc	a2,0x3
ffffffffc0202218:	11460613          	addi	a2,a2,276 # ffffffffc0205328 <commands+0x408>
ffffffffc020221c:	06400593          	li	a1,100
ffffffffc0202220:	00004517          	auipc	a0,0x4
ffffffffc0202224:	95050513          	addi	a0,a0,-1712 # ffffffffc0205b70 <commands+0xc50>
ffffffffc0202228:	fddfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020222c <kmalloc_init>:

inline void 
kmalloc_init(void) {
    slob_init();
    //cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc020222c:	8082                	ret

ffffffffc020222e <kallocated>:
}

size_t
kallocated(void) {
   return slob_allocated();
}
ffffffffc020222e:	4501                	li	a0,0
ffffffffc0202230:	8082                	ret

ffffffffc0202232 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0202232:	1101                	addi	sp,sp,-32
ffffffffc0202234:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202236:	6905                	lui	s2,0x1
{
ffffffffc0202238:	e822                	sd	s0,16(sp)
ffffffffc020223a:	ec06                	sd	ra,24(sp)
ffffffffc020223c:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc020223e:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_hello_out_size-0x88b9>
{
ffffffffc0202242:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT) {
ffffffffc0202244:	04a7f963          	bgeu	a5,a0,ffffffffc0202296 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0202248:	4561                	li	a0,24
ffffffffc020224a:	eedff0ef          	jal	ra,ffffffffc0202136 <slob_alloc.isra.0.constprop.0>
ffffffffc020224e:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0202250:	c929                	beqz	a0,ffffffffc02022a2 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0202252:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0202256:	4501                	li	a0,0
	for ( ; size > 4096 ; size >>=1)
ffffffffc0202258:	00f95763          	bge	s2,a5,ffffffffc0202266 <kmalloc+0x34>
ffffffffc020225c:	6705                	lui	a4,0x1
ffffffffc020225e:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0202260:	2505                	addiw	a0,a0,1
	for ( ; size > 4096 ; size >>=1)
ffffffffc0202262:	fef74ee3          	blt	a4,a5,ffffffffc020225e <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0202266:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0202268:	e6bff0ef          	jal	ra,ffffffffc02020d2 <__slob_get_free_pages.isra.0>
ffffffffc020226c:	e488                	sd	a0,8(s1)
ffffffffc020226e:	842a                	mv	s0,a0
	if (bb->pages) {
ffffffffc0202270:	c525                	beqz	a0,ffffffffc02022d8 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0202272:	100027f3          	csrr	a5,sstatus
ffffffffc0202276:	8b89                	andi	a5,a5,2
ffffffffc0202278:	ef8d                	bnez	a5,ffffffffc02022b2 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc020227a:	00032797          	auipc	a5,0x32
ffffffffc020227e:	a1e78793          	addi	a5,a5,-1506 # ffffffffc0233c98 <bigblocks>
ffffffffc0202282:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0202284:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0202286:	e898                	sd	a4,16(s1)
  return __kmalloc(size, 0);
}
ffffffffc0202288:	60e2                	ld	ra,24(sp)
ffffffffc020228a:	8522                	mv	a0,s0
ffffffffc020228c:	6442                	ld	s0,16(sp)
ffffffffc020228e:	64a2                	ld	s1,8(sp)
ffffffffc0202290:	6902                	ld	s2,0(sp)
ffffffffc0202292:	6105                	addi	sp,sp,32
ffffffffc0202294:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0202296:	0541                	addi	a0,a0,16
ffffffffc0202298:	e9fff0ef          	jal	ra,ffffffffc0202136 <slob_alloc.isra.0.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc020229c:	01050413          	addi	s0,a0,16
ffffffffc02022a0:	f565                	bnez	a0,ffffffffc0202288 <kmalloc+0x56>
ffffffffc02022a2:	4401                	li	s0,0
}
ffffffffc02022a4:	60e2                	ld	ra,24(sp)
ffffffffc02022a6:	8522                	mv	a0,s0
ffffffffc02022a8:	6442                	ld	s0,16(sp)
ffffffffc02022aa:	64a2                	ld	s1,8(sp)
ffffffffc02022ac:	6902                	ld	s2,0(sp)
ffffffffc02022ae:	6105                	addi	sp,sp,32
ffffffffc02022b0:	8082                	ret
        intr_disable();
ffffffffc02022b2:	b80fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		bb->next = bigblocks;
ffffffffc02022b6:	00032797          	auipc	a5,0x32
ffffffffc02022ba:	9e278793          	addi	a5,a5,-1566 # ffffffffc0233c98 <bigblocks>
ffffffffc02022be:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc02022c0:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc02022c2:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc02022c4:	b68fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02022c8:	6480                	ld	s0,8(s1)
}
ffffffffc02022ca:	60e2                	ld	ra,24(sp)
ffffffffc02022cc:	64a2                	ld	s1,8(sp)
ffffffffc02022ce:	8522                	mv	a0,s0
ffffffffc02022d0:	6442                	ld	s0,16(sp)
ffffffffc02022d2:	6902                	ld	s2,0(sp)
ffffffffc02022d4:	6105                	addi	sp,sp,32
ffffffffc02022d6:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc02022d8:	45e1                	li	a1,24
ffffffffc02022da:	8526                	mv	a0,s1
ffffffffc02022dc:	d55ff0ef          	jal	ra,ffffffffc0202030 <slob_free>
  return __kmalloc(size, 0);
ffffffffc02022e0:	b765                	j	ffffffffc0202288 <kmalloc+0x56>

ffffffffc02022e2 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc02022e2:	c169                	beqz	a0,ffffffffc02023a4 <kfree+0xc2>
{
ffffffffc02022e4:	1101                	addi	sp,sp,-32
ffffffffc02022e6:	e822                	sd	s0,16(sp)
ffffffffc02022e8:	ec06                	sd	ra,24(sp)
ffffffffc02022ea:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE-1))) {
ffffffffc02022ec:	03451793          	slli	a5,a0,0x34
ffffffffc02022f0:	842a                	mv	s0,a0
ffffffffc02022f2:	e7c9                	bnez	a5,ffffffffc020237c <kfree+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02022f4:	100027f3          	csrr	a5,sstatus
ffffffffc02022f8:	8b89                	andi	a5,a5,2
ffffffffc02022fa:	ebc9                	bnez	a5,ffffffffc020238c <kfree+0xaa>
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc02022fc:	00032797          	auipc	a5,0x32
ffffffffc0202300:	99c7b783          	ld	a5,-1636(a5) # ffffffffc0233c98 <bigblocks>
    return 0;
ffffffffc0202304:	4601                	li	a2,0
ffffffffc0202306:	cbbd                	beqz	a5,ffffffffc020237c <kfree+0x9a>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0202308:	00032697          	auipc	a3,0x32
ffffffffc020230c:	99068693          	addi	a3,a3,-1648 # ffffffffc0233c98 <bigblocks>
ffffffffc0202310:	a021                	j	ffffffffc0202318 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0202312:	01048693          	addi	a3,s1,16 # ffffffffffe00010 <end+0x3fbcc200>
ffffffffc0202316:	c3a5                	beqz	a5,ffffffffc0202376 <kfree+0x94>
			if (bb->pages == block) {
ffffffffc0202318:	6798                	ld	a4,8(a5)
ffffffffc020231a:	84be                	mv	s1,a5
ffffffffc020231c:	6b9c                	ld	a5,16(a5)
ffffffffc020231e:	fe871ae3          	bne	a4,s0,ffffffffc0202312 <kfree+0x30>
				*last = bb->next;
ffffffffc0202322:	e29c                	sd	a5,0(a3)
    if (flag) {
ffffffffc0202324:	ee2d                	bnez	a2,ffffffffc020239e <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0202326:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc020232a:	4098                	lw	a4,0(s1)
ffffffffc020232c:	08f46963          	bltu	s0,a5,ffffffffc02023be <kfree+0xdc>
ffffffffc0202330:	00032697          	auipc	a3,0x32
ffffffffc0202334:	9c06b683          	ld	a3,-1600(a3) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0202338:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage) {
ffffffffc020233a:	8031                	srli	s0,s0,0xc
ffffffffc020233c:	00032797          	auipc	a5,0x32
ffffffffc0202340:	94c7b783          	ld	a5,-1716(a5) # ffffffffc0233c88 <npage>
ffffffffc0202344:	06f47163          	bgeu	s0,a5,ffffffffc02023a6 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0202348:	00004517          	auipc	a0,0x4
ffffffffc020234c:	75853503          	ld	a0,1880(a0) # ffffffffc0206aa0 <nbase>
ffffffffc0202350:	8c09                	sub	s0,s0,a0
ffffffffc0202352:	041a                	slli	s0,s0,0x6
  free_pages(kva2page(kva), 1 << order);
ffffffffc0202354:	00032517          	auipc	a0,0x32
ffffffffc0202358:	9ac53503          	ld	a0,-1620(a0) # ffffffffc0233d00 <pages>
ffffffffc020235c:	4585                	li	a1,1
ffffffffc020235e:	9522                	add	a0,a0,s0
ffffffffc0202360:	00e595bb          	sllw	a1,a1,a4
ffffffffc0202364:	a81fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0202368:	6442                	ld	s0,16(sp)
ffffffffc020236a:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc020236c:	8526                	mv	a0,s1
}
ffffffffc020236e:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0202370:	45e1                	li	a1,24
}
ffffffffc0202372:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0202374:	b975                	j	ffffffffc0202030 <slob_free>
ffffffffc0202376:	c219                	beqz	a2,ffffffffc020237c <kfree+0x9a>
        intr_enable();
ffffffffc0202378:	ab4fe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc020237c:	ff040513          	addi	a0,s0,-16
}
ffffffffc0202380:	6442                	ld	s0,16(sp)
ffffffffc0202382:	60e2                	ld	ra,24(sp)
ffffffffc0202384:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0202386:	4581                	li	a1,0
}
ffffffffc0202388:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc020238a:	b15d                	j	ffffffffc0202030 <slob_free>
        intr_disable();
ffffffffc020238c:	aa6fe0ef          	jal	ra,ffffffffc0200632 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
ffffffffc0202390:	00032797          	auipc	a5,0x32
ffffffffc0202394:	9087b783          	ld	a5,-1784(a5) # ffffffffc0233c98 <bigblocks>
        return 1;
ffffffffc0202398:	4605                	li	a2,1
ffffffffc020239a:	f7bd                	bnez	a5,ffffffffc0202308 <kfree+0x26>
ffffffffc020239c:	bff1                	j	ffffffffc0202378 <kfree+0x96>
        intr_enable();
ffffffffc020239e:	a8efe0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc02023a2:	b751                	j	ffffffffc0202326 <kfree+0x44>
ffffffffc02023a4:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc02023a6:	00003617          	auipc	a2,0x3
ffffffffc02023aa:	27260613          	addi	a2,a2,626 # ffffffffc0205618 <commands+0x6f8>
ffffffffc02023ae:	06200593          	li	a1,98
ffffffffc02023b2:	00003517          	auipc	a0,0x3
ffffffffc02023b6:	28650513          	addi	a0,a0,646 # ffffffffc0205638 <commands+0x718>
ffffffffc02023ba:	e4bfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc02023be:	86a2                	mv	a3,s0
ffffffffc02023c0:	00003617          	auipc	a2,0x3
ffffffffc02023c4:	2e060613          	addi	a2,a2,736 # ffffffffc02056a0 <commands+0x780>
ffffffffc02023c8:	06e00593          	li	a1,110
ffffffffc02023cc:	00003517          	auipc	a0,0x3
ffffffffc02023d0:	26c50513          	addi	a0,a0,620 # ffffffffc0205638 <commands+0x718>
ffffffffc02023d4:	e31fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02023d8 <swap_init>:

static void check_swap(void);

int
swap_init(void)
{
ffffffffc02023d8:	1101                	addi	sp,sp,-32
ffffffffc02023da:	ec06                	sd	ra,24(sp)
ffffffffc02023dc:	e822                	sd	s0,16(sp)
ffffffffc02023de:	e426                	sd	s1,8(sp)
     swapfs_init();
ffffffffc02023e0:	4cd000ef          	jal	ra,ffffffffc02030ac <swapfs_init>

     // Since the IDE is faked, it can only store 7 pages at most to pass the test
     if (!(7 <= max_swap_offset &&
ffffffffc02023e4:	00032697          	auipc	a3,0x32
ffffffffc02023e8:	9c46b683          	ld	a3,-1596(a3) # ffffffffc0233da8 <max_swap_offset>
ffffffffc02023ec:	010007b7          	lui	a5,0x1000
ffffffffc02023f0:	ff968713          	addi	a4,a3,-7
ffffffffc02023f4:	17e1                	addi	a5,a5,-8
ffffffffc02023f6:	04e7e863          	bltu	a5,a4,ffffffffc0202446 <swap_init+0x6e>
        max_swap_offset < MAX_SWAP_OFFSET_LIMIT)) {
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
     }
     

     sm = &swap_manager_fifo;
ffffffffc02023fa:	00026797          	auipc	a5,0x26
ffffffffc02023fe:	3be78793          	addi	a5,a5,958 # ffffffffc02287b8 <swap_manager_fifo>
     int r = sm->init();
ffffffffc0202402:	6798                	ld	a4,8(a5)
     sm = &swap_manager_fifo;
ffffffffc0202404:	00032497          	auipc	s1,0x32
ffffffffc0202408:	89c48493          	addi	s1,s1,-1892 # ffffffffc0233ca0 <sm>
ffffffffc020240c:	e09c                	sd	a5,0(s1)
     int r = sm->init();
ffffffffc020240e:	9702                	jalr	a4
ffffffffc0202410:	842a                	mv	s0,a0
     
     if (r == 0)
ffffffffc0202412:	c519                	beqz	a0,ffffffffc0202420 <swap_init+0x48>
          cprintf("SWAP: manager = %s\n", sm->name);
          //check_swap();
     }

     return r;
}
ffffffffc0202414:	60e2                	ld	ra,24(sp)
ffffffffc0202416:	8522                	mv	a0,s0
ffffffffc0202418:	6442                	ld	s0,16(sp)
ffffffffc020241a:	64a2                	ld	s1,8(sp)
ffffffffc020241c:	6105                	addi	sp,sp,32
ffffffffc020241e:	8082                	ret
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0202420:	609c                	ld	a5,0(s1)
ffffffffc0202422:	00003517          	auipc	a0,0x3
ffffffffc0202426:	79650513          	addi	a0,a0,1942 # ffffffffc0205bb8 <commands+0xc98>
ffffffffc020242a:	638c                	ld	a1,0(a5)
          swap_init_ok = 1;
ffffffffc020242c:	4785                	li	a5,1
ffffffffc020242e:	00032717          	auipc	a4,0x32
ffffffffc0202432:	86f72d23          	sw	a5,-1926(a4) # ffffffffc0233ca8 <swap_init_ok>
          cprintf("SWAP: manager = %s\n", sm->name);
ffffffffc0202436:	c93fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
}
ffffffffc020243a:	60e2                	ld	ra,24(sp)
ffffffffc020243c:	8522                	mv	a0,s0
ffffffffc020243e:	6442                	ld	s0,16(sp)
ffffffffc0202440:	64a2                	ld	s1,8(sp)
ffffffffc0202442:	6105                	addi	sp,sp,32
ffffffffc0202444:	8082                	ret
        panic("bad max_swap_offset %08x.\n", max_swap_offset);
ffffffffc0202446:	00003617          	auipc	a2,0x3
ffffffffc020244a:	74260613          	addi	a2,a2,1858 # ffffffffc0205b88 <commands+0xc68>
ffffffffc020244e:	02800593          	li	a1,40
ffffffffc0202452:	00003517          	auipc	a0,0x3
ffffffffc0202456:	75650513          	addi	a0,a0,1878 # ffffffffc0205ba8 <commands+0xc88>
ffffffffc020245a:	dabfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020245e <swap_init_mm>:

int
swap_init_mm(struct mm_struct *mm)
{
     return sm->init_mm(mm);
ffffffffc020245e:	00032797          	auipc	a5,0x32
ffffffffc0202462:	8427b783          	ld	a5,-1982(a5) # ffffffffc0233ca0 <sm>
ffffffffc0202466:	0107b303          	ld	t1,16(a5)
ffffffffc020246a:	8302                	jr	t1

ffffffffc020246c <swap_map_swappable>:
}

int
swap_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
     return sm->map_swappable(mm, addr, page, swap_in);
ffffffffc020246c:	00032797          	auipc	a5,0x32
ffffffffc0202470:	8347b783          	ld	a5,-1996(a5) # ffffffffc0233ca0 <sm>
ffffffffc0202474:	0207b303          	ld	t1,32(a5)
ffffffffc0202478:	8302                	jr	t1

ffffffffc020247a <swap_out>:

volatile unsigned int swap_out_num=0;

int
swap_out(struct mm_struct *mm, int n, int in_tick)
{
ffffffffc020247a:	711d                	addi	sp,sp,-96
ffffffffc020247c:	ec86                	sd	ra,88(sp)
ffffffffc020247e:	e8a2                	sd	s0,80(sp)
ffffffffc0202480:	e4a6                	sd	s1,72(sp)
ffffffffc0202482:	e0ca                	sd	s2,64(sp)
ffffffffc0202484:	fc4e                	sd	s3,56(sp)
ffffffffc0202486:	f852                	sd	s4,48(sp)
ffffffffc0202488:	f456                	sd	s5,40(sp)
ffffffffc020248a:	f05a                	sd	s6,32(sp)
ffffffffc020248c:	ec5e                	sd	s7,24(sp)
ffffffffc020248e:	e862                	sd	s8,16(sp)
     int i;
     for (i = 0; i != n; ++ i)
ffffffffc0202490:	cde9                	beqz	a1,ffffffffc020256a <swap_out+0xf0>
ffffffffc0202492:	8a2e                	mv	s4,a1
ffffffffc0202494:	892a                	mv	s2,a0
ffffffffc0202496:	8ab2                	mv	s5,a2
ffffffffc0202498:	4401                	li	s0,0
ffffffffc020249a:	00032997          	auipc	s3,0x32
ffffffffc020249e:	80698993          	addi	s3,s3,-2042 # ffffffffc0233ca0 <sm>
                    cprintf("SWAP: failed to save\n");
                    sm->map_swappable(mm, v, page, 0);
                    continue;
          }
          else {
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc02024a2:	00003b17          	auipc	s6,0x3
ffffffffc02024a6:	78eb0b13          	addi	s6,s6,1934 # ffffffffc0205c30 <commands+0xd10>
                    cprintf("SWAP: failed to save\n");
ffffffffc02024aa:	00003b97          	auipc	s7,0x3
ffffffffc02024ae:	76eb8b93          	addi	s7,s7,1902 # ffffffffc0205c18 <commands+0xcf8>
ffffffffc02024b2:	a825                	j	ffffffffc02024ea <swap_out+0x70>
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc02024b4:	67a2                	ld	a5,8(sp)
ffffffffc02024b6:	8626                	mv	a2,s1
ffffffffc02024b8:	85a2                	mv	a1,s0
ffffffffc02024ba:	7f94                	ld	a3,56(a5)
ffffffffc02024bc:	855a                	mv	a0,s6
     for (i = 0; i != n; ++ i)
ffffffffc02024be:	2405                	addiw	s0,s0,1
                    cprintf("swap_out: i %d, store page in vaddr 0x%x to disk swap entry %d\n", i, v, page->pra_vaddr/PGSIZE+1);
ffffffffc02024c0:	82b1                	srli	a3,a3,0xc
ffffffffc02024c2:	0685                	addi	a3,a3,1
ffffffffc02024c4:	c05fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc02024c8:	6522                	ld	a0,8(sp)
                    free_page(page);
ffffffffc02024ca:	4585                	li	a1,1
                    *ptep = (page->pra_vaddr/PGSIZE+1)<<8;
ffffffffc02024cc:	7d1c                	ld	a5,56(a0)
ffffffffc02024ce:	83b1                	srli	a5,a5,0xc
ffffffffc02024d0:	0785                	addi	a5,a5,1
ffffffffc02024d2:	07a2                	slli	a5,a5,0x8
ffffffffc02024d4:	00fc3023          	sd	a5,0(s8)
                    free_page(page);
ffffffffc02024d8:	90dfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
          }
          
          tlb_invalidate(mm->pgdir, v);
ffffffffc02024dc:	01893503          	ld	a0,24(s2)
ffffffffc02024e0:	85a6                	mv	a1,s1
ffffffffc02024e2:	9a8ff0ef          	jal	ra,ffffffffc020168a <tlb_invalidate>
     for (i = 0; i != n; ++ i)
ffffffffc02024e6:	048a0d63          	beq	s4,s0,ffffffffc0202540 <swap_out+0xc6>
          int r = sm->swap_out_victim(mm, &page, in_tick);
ffffffffc02024ea:	0009b783          	ld	a5,0(s3)
ffffffffc02024ee:	8656                	mv	a2,s5
ffffffffc02024f0:	002c                	addi	a1,sp,8
ffffffffc02024f2:	7b9c                	ld	a5,48(a5)
ffffffffc02024f4:	854a                	mv	a0,s2
ffffffffc02024f6:	9782                	jalr	a5
          if (r != 0) {
ffffffffc02024f8:	e12d                	bnez	a0,ffffffffc020255a <swap_out+0xe0>
          v=page->pra_vaddr; 
ffffffffc02024fa:	67a2                	ld	a5,8(sp)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc02024fc:	01893503          	ld	a0,24(s2)
ffffffffc0202500:	4601                	li	a2,0
          v=page->pra_vaddr; 
ffffffffc0202502:	7f84                	ld	s1,56(a5)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc0202504:	85a6                	mv	a1,s1
ffffffffc0202506:	ab3fe0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
          assert((*ptep & PTE_V) != 0);
ffffffffc020250a:	611c                	ld	a5,0(a0)
          pte_t *ptep = get_pte(mm->pgdir, v, 0);
ffffffffc020250c:	8c2a                	mv	s8,a0
          assert((*ptep & PTE_V) != 0);
ffffffffc020250e:	8b85                	andi	a5,a5,1
ffffffffc0202510:	cfb9                	beqz	a5,ffffffffc020256e <swap_out+0xf4>
          if (swapfs_write( (page->pra_vaddr/PGSIZE+1)<<8, page) != 0) {
ffffffffc0202512:	65a2                	ld	a1,8(sp)
ffffffffc0202514:	7d9c                	ld	a5,56(a1)
ffffffffc0202516:	83b1                	srli	a5,a5,0xc
ffffffffc0202518:	0785                	addi	a5,a5,1
ffffffffc020251a:	00879513          	slli	a0,a5,0x8
ffffffffc020251e:	455000ef          	jal	ra,ffffffffc0203172 <swapfs_write>
ffffffffc0202522:	d949                	beqz	a0,ffffffffc02024b4 <swap_out+0x3a>
                    cprintf("SWAP: failed to save\n");
ffffffffc0202524:	855e                	mv	a0,s7
ffffffffc0202526:	ba3fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                    sm->map_swappable(mm, v, page, 0);
ffffffffc020252a:	0009b783          	ld	a5,0(s3)
ffffffffc020252e:	6622                	ld	a2,8(sp)
ffffffffc0202530:	4681                	li	a3,0
ffffffffc0202532:	739c                	ld	a5,32(a5)
ffffffffc0202534:	85a6                	mv	a1,s1
ffffffffc0202536:	854a                	mv	a0,s2
     for (i = 0; i != n; ++ i)
ffffffffc0202538:	2405                	addiw	s0,s0,1
                    sm->map_swappable(mm, v, page, 0);
ffffffffc020253a:	9782                	jalr	a5
     for (i = 0; i != n; ++ i)
ffffffffc020253c:	fa8a17e3          	bne	s4,s0,ffffffffc02024ea <swap_out+0x70>
     }
     return i;
}
ffffffffc0202540:	60e6                	ld	ra,88(sp)
ffffffffc0202542:	8522                	mv	a0,s0
ffffffffc0202544:	6446                	ld	s0,80(sp)
ffffffffc0202546:	64a6                	ld	s1,72(sp)
ffffffffc0202548:	6906                	ld	s2,64(sp)
ffffffffc020254a:	79e2                	ld	s3,56(sp)
ffffffffc020254c:	7a42                	ld	s4,48(sp)
ffffffffc020254e:	7aa2                	ld	s5,40(sp)
ffffffffc0202550:	7b02                	ld	s6,32(sp)
ffffffffc0202552:	6be2                	ld	s7,24(sp)
ffffffffc0202554:	6c42                	ld	s8,16(sp)
ffffffffc0202556:	6125                	addi	sp,sp,96
ffffffffc0202558:	8082                	ret
                    cprintf("i %d, swap_out: call swap_out_victim failed\n",i);
ffffffffc020255a:	85a2                	mv	a1,s0
ffffffffc020255c:	00003517          	auipc	a0,0x3
ffffffffc0202560:	67450513          	addi	a0,a0,1652 # ffffffffc0205bd0 <commands+0xcb0>
ffffffffc0202564:	b65fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
                  break;
ffffffffc0202568:	bfe1                	j	ffffffffc0202540 <swap_out+0xc6>
     for (i = 0; i != n; ++ i)
ffffffffc020256a:	4401                	li	s0,0
ffffffffc020256c:	bfd1                	j	ffffffffc0202540 <swap_out+0xc6>
          assert((*ptep & PTE_V) != 0);
ffffffffc020256e:	00003697          	auipc	a3,0x3
ffffffffc0202572:	69268693          	addi	a3,a3,1682 # ffffffffc0205c00 <commands+0xce0>
ffffffffc0202576:	00003617          	auipc	a2,0x3
ffffffffc020257a:	db260613          	addi	a2,a2,-590 # ffffffffc0205328 <commands+0x408>
ffffffffc020257e:	06800593          	li	a1,104
ffffffffc0202582:	00003517          	auipc	a0,0x3
ffffffffc0202586:	62650513          	addi	a0,a0,1574 # ffffffffc0205ba8 <commands+0xc88>
ffffffffc020258a:	c7bfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020258e <swap_in>:

int
swap_in(struct mm_struct *mm, uintptr_t addr, struct Page **ptr_result)
{
ffffffffc020258e:	7179                	addi	sp,sp,-48
ffffffffc0202590:	e84a                	sd	s2,16(sp)
ffffffffc0202592:	892a                	mv	s2,a0
     struct Page *result = alloc_page();
ffffffffc0202594:	4505                	li	a0,1
{
ffffffffc0202596:	ec26                	sd	s1,24(sp)
ffffffffc0202598:	e44e                	sd	s3,8(sp)
ffffffffc020259a:	f406                	sd	ra,40(sp)
ffffffffc020259c:	f022                	sd	s0,32(sp)
ffffffffc020259e:	84ae                	mv	s1,a1
ffffffffc02025a0:	89b2                	mv	s3,a2
     struct Page *result = alloc_page();
ffffffffc02025a2:	fb0fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
     assert(result!=NULL);
ffffffffc02025a6:	c129                	beqz	a0,ffffffffc02025e8 <swap_in+0x5a>

     pte_t *ptep = get_pte(mm->pgdir, addr, 0);
ffffffffc02025a8:	842a                	mv	s0,a0
ffffffffc02025aa:	01893503          	ld	a0,24(s2)
ffffffffc02025ae:	4601                	li	a2,0
ffffffffc02025b0:	85a6                	mv	a1,s1
ffffffffc02025b2:	a07fe0ef          	jal	ra,ffffffffc0200fb8 <get_pte>
ffffffffc02025b6:	892a                	mv	s2,a0
     // cprintf("SWAP: load ptep %x swap entry %d to vaddr 0x%08x, page %x, No %d\n", ptep, (*ptep)>>8, addr, result, (result-pages));
    
     int r;
     if ((r = swapfs_read((*ptep), result)) != 0)
ffffffffc02025b8:	6108                	ld	a0,0(a0)
ffffffffc02025ba:	85a2                	mv	a1,s0
ffffffffc02025bc:	329000ef          	jal	ra,ffffffffc02030e4 <swapfs_read>
     {
        assert(r!=0);
     }
     cprintf("swap_in: load disk swap entry %d with swap_page in vadr 0x%x\n", (*ptep)>>8, addr);
ffffffffc02025c0:	00093583          	ld	a1,0(s2)
ffffffffc02025c4:	8626                	mv	a2,s1
ffffffffc02025c6:	00003517          	auipc	a0,0x3
ffffffffc02025ca:	6ba50513          	addi	a0,a0,1722 # ffffffffc0205c80 <commands+0xd60>
ffffffffc02025ce:	81a1                	srli	a1,a1,0x8
ffffffffc02025d0:	af9fd0ef          	jal	ra,ffffffffc02000c8 <cprintf>
     *ptr_result=result;
     return 0;
}
ffffffffc02025d4:	70a2                	ld	ra,40(sp)
     *ptr_result=result;
ffffffffc02025d6:	0089b023          	sd	s0,0(s3)
}
ffffffffc02025da:	7402                	ld	s0,32(sp)
ffffffffc02025dc:	64e2                	ld	s1,24(sp)
ffffffffc02025de:	6942                	ld	s2,16(sp)
ffffffffc02025e0:	69a2                	ld	s3,8(sp)
ffffffffc02025e2:	4501                	li	a0,0
ffffffffc02025e4:	6145                	addi	sp,sp,48
ffffffffc02025e6:	8082                	ret
     assert(result!=NULL);
ffffffffc02025e8:	00003697          	auipc	a3,0x3
ffffffffc02025ec:	68868693          	addi	a3,a3,1672 # ffffffffc0205c70 <commands+0xd50>
ffffffffc02025f0:	00003617          	auipc	a2,0x3
ffffffffc02025f4:	d3860613          	addi	a2,a2,-712 # ffffffffc0205328 <commands+0x408>
ffffffffc02025f8:	07e00593          	li	a1,126
ffffffffc02025fc:	00003517          	auipc	a0,0x3
ffffffffc0202600:	5ac50513          	addi	a0,a0,1452 # ffffffffc0205ba8 <commands+0xc88>
ffffffffc0202604:	c01fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202608 <default_init>:
    elm->prev = elm->next = elm;
ffffffffc0202608:	00031797          	auipc	a5,0x31
ffffffffc020260c:	7e078793          	addi	a5,a5,2016 # ffffffffc0233de8 <free_area>
ffffffffc0202610:	e79c                	sd	a5,8(a5)
ffffffffc0202612:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0202614:	0007a823          	sw	zero,16(a5)
}
ffffffffc0202618:	8082                	ret

ffffffffc020261a <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc020261a:	00031517          	auipc	a0,0x31
ffffffffc020261e:	7de56503          	lwu	a0,2014(a0) # ffffffffc0233df8 <free_area+0x10>
ffffffffc0202622:	8082                	ret

ffffffffc0202624 <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0202624:	715d                	addi	sp,sp,-80
ffffffffc0202626:	e0a2                	sd	s0,64(sp)
    return listelm->next;
ffffffffc0202628:	00031417          	auipc	s0,0x31
ffffffffc020262c:	7c040413          	addi	s0,s0,1984 # ffffffffc0233de8 <free_area>
ffffffffc0202630:	641c                	ld	a5,8(s0)
ffffffffc0202632:	e486                	sd	ra,72(sp)
ffffffffc0202634:	fc26                	sd	s1,56(sp)
ffffffffc0202636:	f84a                	sd	s2,48(sp)
ffffffffc0202638:	f44e                	sd	s3,40(sp)
ffffffffc020263a:	f052                	sd	s4,32(sp)
ffffffffc020263c:	ec56                	sd	s5,24(sp)
ffffffffc020263e:	e85a                	sd	s6,16(sp)
ffffffffc0202640:	e45e                	sd	s7,8(sp)
ffffffffc0202642:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202644:	2a878d63          	beq	a5,s0,ffffffffc02028fe <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0202648:	4481                	li	s1,0
ffffffffc020264a:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc020264c:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0202650:	8b09                	andi	a4,a4,2
ffffffffc0202652:	2a070a63          	beqz	a4,ffffffffc0202906 <default_check+0x2e2>
        count ++, total += p->property;
ffffffffc0202656:	ff87a703          	lw	a4,-8(a5)
ffffffffc020265a:	679c                	ld	a5,8(a5)
ffffffffc020265c:	2905                	addiw	s2,s2,1
ffffffffc020265e:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202660:	fe8796e3          	bne	a5,s0,ffffffffc020264c <default_check+0x28>
ffffffffc0202664:	89a6                	mv	s3,s1
    }
    assert(total == nr_free_pages());
ffffffffc0202666:	fc0fe0ef          	jal	ra,ffffffffc0200e26 <nr_free_pages>
ffffffffc020266a:	6f351e63          	bne	a0,s3,ffffffffc0202d66 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020266e:	4505                	li	a0,1
ffffffffc0202670:	ee2fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202674:	8aaa                	mv	s5,a0
ffffffffc0202676:	42050863          	beqz	a0,ffffffffc0202aa6 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020267a:	4505                	li	a0,1
ffffffffc020267c:	ed6fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202680:	89aa                	mv	s3,a0
ffffffffc0202682:	70050263          	beqz	a0,ffffffffc0202d86 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202686:	4505                	li	a0,1
ffffffffc0202688:	ecafe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020268c:	8a2a                	mv	s4,a0
ffffffffc020268e:	48050c63          	beqz	a0,ffffffffc0202b26 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0202692:	293a8a63          	beq	s5,s3,ffffffffc0202926 <default_check+0x302>
ffffffffc0202696:	28aa8863          	beq	s5,a0,ffffffffc0202926 <default_check+0x302>
ffffffffc020269a:	28a98663          	beq	s3,a0,ffffffffc0202926 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc020269e:	000aa783          	lw	a5,0(s5)
ffffffffc02026a2:	2a079263          	bnez	a5,ffffffffc0202946 <default_check+0x322>
ffffffffc02026a6:	0009a783          	lw	a5,0(s3)
ffffffffc02026aa:	28079e63          	bnez	a5,ffffffffc0202946 <default_check+0x322>
ffffffffc02026ae:	411c                	lw	a5,0(a0)
ffffffffc02026b0:	28079b63          	bnez	a5,ffffffffc0202946 <default_check+0x322>
    return page - pages + nbase;
ffffffffc02026b4:	00031797          	auipc	a5,0x31
ffffffffc02026b8:	64c7b783          	ld	a5,1612(a5) # ffffffffc0233d00 <pages>
ffffffffc02026bc:	40fa8733          	sub	a4,s5,a5
ffffffffc02026c0:	00004617          	auipc	a2,0x4
ffffffffc02026c4:	3e063603          	ld	a2,992(a2) # ffffffffc0206aa0 <nbase>
ffffffffc02026c8:	8719                	srai	a4,a4,0x6
ffffffffc02026ca:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc02026cc:	00031697          	auipc	a3,0x31
ffffffffc02026d0:	5bc6b683          	ld	a3,1468(a3) # ffffffffc0233c88 <npage>
ffffffffc02026d4:	06b2                	slli	a3,a3,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02026d6:	0732                	slli	a4,a4,0xc
ffffffffc02026d8:	28d77763          	bgeu	a4,a3,ffffffffc0202966 <default_check+0x342>
    return page - pages + nbase;
ffffffffc02026dc:	40f98733          	sub	a4,s3,a5
ffffffffc02026e0:	8719                	srai	a4,a4,0x6
ffffffffc02026e2:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026e4:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02026e6:	4cd77063          	bgeu	a4,a3,ffffffffc0202ba6 <default_check+0x582>
    return page - pages + nbase;
ffffffffc02026ea:	40f507b3          	sub	a5,a0,a5
ffffffffc02026ee:	8799                	srai	a5,a5,0x6
ffffffffc02026f0:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02026f2:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02026f4:	30d7f963          	bgeu	a5,a3,ffffffffc0202a06 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02026f8:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02026fa:	00043c03          	ld	s8,0(s0)
ffffffffc02026fe:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0202702:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0202706:	e400                	sd	s0,8(s0)
ffffffffc0202708:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc020270a:	00031797          	auipc	a5,0x31
ffffffffc020270e:	6e07a723          	sw	zero,1774(a5) # ffffffffc0233df8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0202712:	e40fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202716:	2c051863          	bnez	a0,ffffffffc02029e6 <default_check+0x3c2>
    free_page(p0);
ffffffffc020271a:	4585                	li	a1,1
ffffffffc020271c:	8556                	mv	a0,s5
ffffffffc020271e:	ec6fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p1);
ffffffffc0202722:	4585                	li	a1,1
ffffffffc0202724:	854e                	mv	a0,s3
ffffffffc0202726:	ebefe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc020272a:	4585                	li	a1,1
ffffffffc020272c:	8552                	mv	a0,s4
ffffffffc020272e:	eb6fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(nr_free == 3);
ffffffffc0202732:	4818                	lw	a4,16(s0)
ffffffffc0202734:	478d                	li	a5,3
ffffffffc0202736:	28f71863          	bne	a4,a5,ffffffffc02029c6 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020273a:	4505                	li	a0,1
ffffffffc020273c:	e16fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202740:	89aa                	mv	s3,a0
ffffffffc0202742:	26050263          	beqz	a0,ffffffffc02029a6 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202746:	4505                	li	a0,1
ffffffffc0202748:	e0afe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020274c:	8aaa                	mv	s5,a0
ffffffffc020274e:	3a050c63          	beqz	a0,ffffffffc0202b06 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202752:	4505                	li	a0,1
ffffffffc0202754:	dfefe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202758:	8a2a                	mv	s4,a0
ffffffffc020275a:	38050663          	beqz	a0,ffffffffc0202ae6 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc020275e:	4505                	li	a0,1
ffffffffc0202760:	df2fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202764:	36051163          	bnez	a0,ffffffffc0202ac6 <default_check+0x4a2>
    free_page(p0);
ffffffffc0202768:	4585                	li	a1,1
ffffffffc020276a:	854e                	mv	a0,s3
ffffffffc020276c:	e78fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0202770:	641c                	ld	a5,8(s0)
ffffffffc0202772:	20878a63          	beq	a5,s0,ffffffffc0202986 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0202776:	4505                	li	a0,1
ffffffffc0202778:	ddafe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020277c:	30a99563          	bne	s3,a0,ffffffffc0202a86 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0202780:	4505                	li	a0,1
ffffffffc0202782:	dd0fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202786:	2e051063          	bnez	a0,ffffffffc0202a66 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc020278a:	481c                	lw	a5,16(s0)
ffffffffc020278c:	2a079d63          	bnez	a5,ffffffffc0202a46 <default_check+0x422>
    free_page(p);
ffffffffc0202790:	854e                	mv	a0,s3
ffffffffc0202792:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0202794:	01843023          	sd	s8,0(s0)
ffffffffc0202798:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc020279c:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc02027a0:	e44fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p1);
ffffffffc02027a4:	4585                	li	a1,1
ffffffffc02027a6:	8556                	mv	a0,s5
ffffffffc02027a8:	e3cfe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc02027ac:	4585                	li	a1,1
ffffffffc02027ae:	8552                	mv	a0,s4
ffffffffc02027b0:	e34fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc02027b4:	4515                	li	a0,5
ffffffffc02027b6:	d9cfe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02027ba:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc02027bc:	26050563          	beqz	a0,ffffffffc0202a26 <default_check+0x402>
ffffffffc02027c0:	651c                	ld	a5,8(a0)
ffffffffc02027c2:	8385                	srli	a5,a5,0x1
ffffffffc02027c4:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02027c6:	54079063          	bnez	a5,ffffffffc0202d06 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02027ca:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02027cc:	00043b03          	ld	s6,0(s0)
ffffffffc02027d0:	00843a83          	ld	s5,8(s0)
ffffffffc02027d4:	e000                	sd	s0,0(s0)
ffffffffc02027d6:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02027d8:	d7afe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02027dc:	50051563          	bnez	a0,ffffffffc0202ce6 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02027e0:	08098a13          	addi	s4,s3,128
ffffffffc02027e4:	8552                	mv	a0,s4
ffffffffc02027e6:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02027e8:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02027ec:	00031797          	auipc	a5,0x31
ffffffffc02027f0:	6007a623          	sw	zero,1548(a5) # ffffffffc0233df8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02027f4:	df0fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02027f8:	4511                	li	a0,4
ffffffffc02027fa:	d58fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02027fe:	4c051463          	bnez	a0,ffffffffc0202cc6 <default_check+0x6a2>
ffffffffc0202802:	0889b783          	ld	a5,136(s3)
ffffffffc0202806:	8385                	srli	a5,a5,0x1
ffffffffc0202808:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc020280a:	48078e63          	beqz	a5,ffffffffc0202ca6 <default_check+0x682>
ffffffffc020280e:	0909a703          	lw	a4,144(s3)
ffffffffc0202812:	478d                	li	a5,3
ffffffffc0202814:	48f71963          	bne	a4,a5,ffffffffc0202ca6 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0202818:	450d                	li	a0,3
ffffffffc020281a:	d38fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020281e:	8c2a                	mv	s8,a0
ffffffffc0202820:	46050363          	beqz	a0,ffffffffc0202c86 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc0202824:	4505                	li	a0,1
ffffffffc0202826:	d2cfe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020282a:	42051e63          	bnez	a0,ffffffffc0202c66 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc020282e:	418a1c63          	bne	s4,s8,ffffffffc0202c46 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0202832:	4585                	li	a1,1
ffffffffc0202834:	854e                	mv	a0,s3
ffffffffc0202836:	daefe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_pages(p1, 3);
ffffffffc020283a:	458d                	li	a1,3
ffffffffc020283c:	8552                	mv	a0,s4
ffffffffc020283e:	da6fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
ffffffffc0202842:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0202846:	04098c13          	addi	s8,s3,64
ffffffffc020284a:	8385                	srli	a5,a5,0x1
ffffffffc020284c:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc020284e:	3c078c63          	beqz	a5,ffffffffc0202c26 <default_check+0x602>
ffffffffc0202852:	0109a703          	lw	a4,16(s3)
ffffffffc0202856:	4785                	li	a5,1
ffffffffc0202858:	3cf71763          	bne	a4,a5,ffffffffc0202c26 <default_check+0x602>
ffffffffc020285c:	008a3783          	ld	a5,8(s4) # 1008 <_binary_obj___user_hello_out_size-0x88a0>
ffffffffc0202860:	8385                	srli	a5,a5,0x1
ffffffffc0202862:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202864:	3a078163          	beqz	a5,ffffffffc0202c06 <default_check+0x5e2>
ffffffffc0202868:	010a2703          	lw	a4,16(s4)
ffffffffc020286c:	478d                	li	a5,3
ffffffffc020286e:	38f71c63          	bne	a4,a5,ffffffffc0202c06 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202872:	4505                	li	a0,1
ffffffffc0202874:	cdefe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202878:	36a99763          	bne	s3,a0,ffffffffc0202be6 <default_check+0x5c2>
    free_page(p0);
ffffffffc020287c:	4585                	li	a1,1
ffffffffc020287e:	d66fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0202882:	4509                	li	a0,2
ffffffffc0202884:	ccefe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc0202888:	32aa1f63          	bne	s4,a0,ffffffffc0202bc6 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc020288c:	4589                	li	a1,2
ffffffffc020288e:	d56fe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    free_page(p2);
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	8562                	mv	a0,s8
ffffffffc0202896:	d4efe0ef          	jal	ra,ffffffffc0200de4 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020289a:	4515                	li	a0,5
ffffffffc020289c:	cb6fe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02028a0:	89aa                	mv	s3,a0
ffffffffc02028a2:	48050263          	beqz	a0,ffffffffc0202d26 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc02028a6:	4505                	li	a0,1
ffffffffc02028a8:	caafe0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc02028ac:	2c051d63          	bnez	a0,ffffffffc0202b86 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc02028b0:	481c                	lw	a5,16(s0)
ffffffffc02028b2:	2a079a63          	bnez	a5,ffffffffc0202b66 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc02028b6:	4595                	li	a1,5
ffffffffc02028b8:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc02028ba:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc02028be:	01643023          	sd	s6,0(s0)
ffffffffc02028c2:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02028c6:	d1efe0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    return listelm->next;
ffffffffc02028ca:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028cc:	00878963          	beq	a5,s0,ffffffffc02028de <default_check+0x2ba>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc02028d0:	ff87a703          	lw	a4,-8(a5)
ffffffffc02028d4:	679c                	ld	a5,8(a5)
ffffffffc02028d6:	397d                	addiw	s2,s2,-1
ffffffffc02028d8:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028da:	fe879be3          	bne	a5,s0,ffffffffc02028d0 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02028de:	26091463          	bnez	s2,ffffffffc0202b46 <default_check+0x522>
    assert(total == 0);
ffffffffc02028e2:	46049263          	bnez	s1,ffffffffc0202d46 <default_check+0x722>
}
ffffffffc02028e6:	60a6                	ld	ra,72(sp)
ffffffffc02028e8:	6406                	ld	s0,64(sp)
ffffffffc02028ea:	74e2                	ld	s1,56(sp)
ffffffffc02028ec:	7942                	ld	s2,48(sp)
ffffffffc02028ee:	79a2                	ld	s3,40(sp)
ffffffffc02028f0:	7a02                	ld	s4,32(sp)
ffffffffc02028f2:	6ae2                	ld	s5,24(sp)
ffffffffc02028f4:	6b42                	ld	s6,16(sp)
ffffffffc02028f6:	6ba2                	ld	s7,8(sp)
ffffffffc02028f8:	6c02                	ld	s8,0(sp)
ffffffffc02028fa:	6161                	addi	sp,sp,80
ffffffffc02028fc:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc02028fe:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0202900:	4481                	li	s1,0
ffffffffc0202902:	4901                	li	s2,0
ffffffffc0202904:	b38d                	j	ffffffffc0202666 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0202906:	00003697          	auipc	a3,0x3
ffffffffc020290a:	3ba68693          	addi	a3,a3,954 # ffffffffc0205cc0 <commands+0xda0>
ffffffffc020290e:	00003617          	auipc	a2,0x3
ffffffffc0202912:	a1a60613          	addi	a2,a2,-1510 # ffffffffc0205328 <commands+0x408>
ffffffffc0202916:	0f000593          	li	a1,240
ffffffffc020291a:	00003517          	auipc	a0,0x3
ffffffffc020291e:	3b650513          	addi	a0,a0,950 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202922:	8e3fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0202926:	00003697          	auipc	a3,0x3
ffffffffc020292a:	44268693          	addi	a3,a3,1090 # ffffffffc0205d68 <commands+0xe48>
ffffffffc020292e:	00003617          	auipc	a2,0x3
ffffffffc0202932:	9fa60613          	addi	a2,a2,-1542 # ffffffffc0205328 <commands+0x408>
ffffffffc0202936:	0bd00593          	li	a1,189
ffffffffc020293a:	00003517          	auipc	a0,0x3
ffffffffc020293e:	39650513          	addi	a0,a0,918 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202942:	8c3fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0202946:	00003697          	auipc	a3,0x3
ffffffffc020294a:	44a68693          	addi	a3,a3,1098 # ffffffffc0205d90 <commands+0xe70>
ffffffffc020294e:	00003617          	auipc	a2,0x3
ffffffffc0202952:	9da60613          	addi	a2,a2,-1574 # ffffffffc0205328 <commands+0x408>
ffffffffc0202956:	0be00593          	li	a1,190
ffffffffc020295a:	00003517          	auipc	a0,0x3
ffffffffc020295e:	37650513          	addi	a0,a0,886 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202962:	8a3fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0202966:	00003697          	auipc	a3,0x3
ffffffffc020296a:	46a68693          	addi	a3,a3,1130 # ffffffffc0205dd0 <commands+0xeb0>
ffffffffc020296e:	00003617          	auipc	a2,0x3
ffffffffc0202972:	9ba60613          	addi	a2,a2,-1606 # ffffffffc0205328 <commands+0x408>
ffffffffc0202976:	0c000593          	li	a1,192
ffffffffc020297a:	00003517          	auipc	a0,0x3
ffffffffc020297e:	35650513          	addi	a0,a0,854 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202982:	883fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0202986:	00003697          	auipc	a3,0x3
ffffffffc020298a:	4d268693          	addi	a3,a3,1234 # ffffffffc0205e58 <commands+0xf38>
ffffffffc020298e:	00003617          	auipc	a2,0x3
ffffffffc0202992:	99a60613          	addi	a2,a2,-1638 # ffffffffc0205328 <commands+0x408>
ffffffffc0202996:	0d900593          	li	a1,217
ffffffffc020299a:	00003517          	auipc	a0,0x3
ffffffffc020299e:	33650513          	addi	a0,a0,822 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc02029a2:	863fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02029a6:	00003697          	auipc	a3,0x3
ffffffffc02029aa:	36268693          	addi	a3,a3,866 # ffffffffc0205d08 <commands+0xde8>
ffffffffc02029ae:	00003617          	auipc	a2,0x3
ffffffffc02029b2:	97a60613          	addi	a2,a2,-1670 # ffffffffc0205328 <commands+0x408>
ffffffffc02029b6:	0d200593          	li	a1,210
ffffffffc02029ba:	00003517          	auipc	a0,0x3
ffffffffc02029be:	31650513          	addi	a0,a0,790 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc02029c2:	843fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 3);
ffffffffc02029c6:	00003697          	auipc	a3,0x3
ffffffffc02029ca:	48268693          	addi	a3,a3,1154 # ffffffffc0205e48 <commands+0xf28>
ffffffffc02029ce:	00003617          	auipc	a2,0x3
ffffffffc02029d2:	95a60613          	addi	a2,a2,-1702 # ffffffffc0205328 <commands+0x408>
ffffffffc02029d6:	0d000593          	li	a1,208
ffffffffc02029da:	00003517          	auipc	a0,0x3
ffffffffc02029de:	2f650513          	addi	a0,a0,758 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc02029e2:	823fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02029e6:	00003697          	auipc	a3,0x3
ffffffffc02029ea:	44a68693          	addi	a3,a3,1098 # ffffffffc0205e30 <commands+0xf10>
ffffffffc02029ee:	00003617          	auipc	a2,0x3
ffffffffc02029f2:	93a60613          	addi	a2,a2,-1734 # ffffffffc0205328 <commands+0x408>
ffffffffc02029f6:	0cb00593          	li	a1,203
ffffffffc02029fa:	00003517          	auipc	a0,0x3
ffffffffc02029fe:	2d650513          	addi	a0,a0,726 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202a02:	803fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0202a06:	00003697          	auipc	a3,0x3
ffffffffc0202a0a:	40a68693          	addi	a3,a3,1034 # ffffffffc0205e10 <commands+0xef0>
ffffffffc0202a0e:	00003617          	auipc	a2,0x3
ffffffffc0202a12:	91a60613          	addi	a2,a2,-1766 # ffffffffc0205328 <commands+0x408>
ffffffffc0202a16:	0c200593          	li	a1,194
ffffffffc0202a1a:	00003517          	auipc	a0,0x3
ffffffffc0202a1e:	2b650513          	addi	a0,a0,694 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202a22:	fe2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 != NULL);
ffffffffc0202a26:	00003697          	auipc	a3,0x3
ffffffffc0202a2a:	47a68693          	addi	a3,a3,1146 # ffffffffc0205ea0 <commands+0xf80>
ffffffffc0202a2e:	00003617          	auipc	a2,0x3
ffffffffc0202a32:	8fa60613          	addi	a2,a2,-1798 # ffffffffc0205328 <commands+0x408>
ffffffffc0202a36:	0f800593          	li	a1,248
ffffffffc0202a3a:	00003517          	auipc	a0,0x3
ffffffffc0202a3e:	29650513          	addi	a0,a0,662 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202a42:	fc2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202a46:	00003697          	auipc	a3,0x3
ffffffffc0202a4a:	44a68693          	addi	a3,a3,1098 # ffffffffc0205e90 <commands+0xf70>
ffffffffc0202a4e:	00003617          	auipc	a2,0x3
ffffffffc0202a52:	8da60613          	addi	a2,a2,-1830 # ffffffffc0205328 <commands+0x408>
ffffffffc0202a56:	0df00593          	li	a1,223
ffffffffc0202a5a:	00003517          	auipc	a0,0x3
ffffffffc0202a5e:	27650513          	addi	a0,a0,630 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202a62:	fa2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202a66:	00003697          	auipc	a3,0x3
ffffffffc0202a6a:	3ca68693          	addi	a3,a3,970 # ffffffffc0205e30 <commands+0xf10>
ffffffffc0202a6e:	00003617          	auipc	a2,0x3
ffffffffc0202a72:	8ba60613          	addi	a2,a2,-1862 # ffffffffc0205328 <commands+0x408>
ffffffffc0202a76:	0dd00593          	li	a1,221
ffffffffc0202a7a:	00003517          	auipc	a0,0x3
ffffffffc0202a7e:	25650513          	addi	a0,a0,598 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202a82:	f82fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0202a86:	00003697          	auipc	a3,0x3
ffffffffc0202a8a:	3ea68693          	addi	a3,a3,1002 # ffffffffc0205e70 <commands+0xf50>
ffffffffc0202a8e:	00003617          	auipc	a2,0x3
ffffffffc0202a92:	89a60613          	addi	a2,a2,-1894 # ffffffffc0205328 <commands+0x408>
ffffffffc0202a96:	0dc00593          	li	a1,220
ffffffffc0202a9a:	00003517          	auipc	a0,0x3
ffffffffc0202a9e:	23650513          	addi	a0,a0,566 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202aa2:	f62fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0202aa6:	00003697          	auipc	a3,0x3
ffffffffc0202aaa:	26268693          	addi	a3,a3,610 # ffffffffc0205d08 <commands+0xde8>
ffffffffc0202aae:	00003617          	auipc	a2,0x3
ffffffffc0202ab2:	87a60613          	addi	a2,a2,-1926 # ffffffffc0205328 <commands+0x408>
ffffffffc0202ab6:	0b900593          	li	a1,185
ffffffffc0202aba:	00003517          	auipc	a0,0x3
ffffffffc0202abe:	21650513          	addi	a0,a0,534 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ac2:	f42fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202ac6:	00003697          	auipc	a3,0x3
ffffffffc0202aca:	36a68693          	addi	a3,a3,874 # ffffffffc0205e30 <commands+0xf10>
ffffffffc0202ace:	00003617          	auipc	a2,0x3
ffffffffc0202ad2:	85a60613          	addi	a2,a2,-1958 # ffffffffc0205328 <commands+0x408>
ffffffffc0202ad6:	0d600593          	li	a1,214
ffffffffc0202ada:	00003517          	auipc	a0,0x3
ffffffffc0202ade:	1f650513          	addi	a0,a0,502 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ae2:	f22fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202ae6:	00003697          	auipc	a3,0x3
ffffffffc0202aea:	26268693          	addi	a3,a3,610 # ffffffffc0205d48 <commands+0xe28>
ffffffffc0202aee:	00003617          	auipc	a2,0x3
ffffffffc0202af2:	83a60613          	addi	a2,a2,-1990 # ffffffffc0205328 <commands+0x408>
ffffffffc0202af6:	0d400593          	li	a1,212
ffffffffc0202afa:	00003517          	auipc	a0,0x3
ffffffffc0202afe:	1d650513          	addi	a0,a0,470 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202b02:	f02fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202b06:	00003697          	auipc	a3,0x3
ffffffffc0202b0a:	22268693          	addi	a3,a3,546 # ffffffffc0205d28 <commands+0xe08>
ffffffffc0202b0e:	00003617          	auipc	a2,0x3
ffffffffc0202b12:	81a60613          	addi	a2,a2,-2022 # ffffffffc0205328 <commands+0x408>
ffffffffc0202b16:	0d300593          	li	a1,211
ffffffffc0202b1a:	00003517          	auipc	a0,0x3
ffffffffc0202b1e:	1b650513          	addi	a0,a0,438 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202b22:	ee2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0202b26:	00003697          	auipc	a3,0x3
ffffffffc0202b2a:	22268693          	addi	a3,a3,546 # ffffffffc0205d48 <commands+0xe28>
ffffffffc0202b2e:	00002617          	auipc	a2,0x2
ffffffffc0202b32:	7fa60613          	addi	a2,a2,2042 # ffffffffc0205328 <commands+0x408>
ffffffffc0202b36:	0bb00593          	li	a1,187
ffffffffc0202b3a:	00003517          	auipc	a0,0x3
ffffffffc0202b3e:	19650513          	addi	a0,a0,406 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202b42:	ec2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(count == 0);
ffffffffc0202b46:	00003697          	auipc	a3,0x3
ffffffffc0202b4a:	4aa68693          	addi	a3,a3,1194 # ffffffffc0205ff0 <commands+0x10d0>
ffffffffc0202b4e:	00002617          	auipc	a2,0x2
ffffffffc0202b52:	7da60613          	addi	a2,a2,2010 # ffffffffc0205328 <commands+0x408>
ffffffffc0202b56:	12500593          	li	a1,293
ffffffffc0202b5a:	00003517          	auipc	a0,0x3
ffffffffc0202b5e:	17650513          	addi	a0,a0,374 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202b62:	ea2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_free == 0);
ffffffffc0202b66:	00003697          	auipc	a3,0x3
ffffffffc0202b6a:	32a68693          	addi	a3,a3,810 # ffffffffc0205e90 <commands+0xf70>
ffffffffc0202b6e:	00002617          	auipc	a2,0x2
ffffffffc0202b72:	7ba60613          	addi	a2,a2,1978 # ffffffffc0205328 <commands+0x408>
ffffffffc0202b76:	11a00593          	li	a1,282
ffffffffc0202b7a:	00003517          	auipc	a0,0x3
ffffffffc0202b7e:	15650513          	addi	a0,a0,342 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202b82:	e82fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202b86:	00003697          	auipc	a3,0x3
ffffffffc0202b8a:	2aa68693          	addi	a3,a3,682 # ffffffffc0205e30 <commands+0xf10>
ffffffffc0202b8e:	00002617          	auipc	a2,0x2
ffffffffc0202b92:	79a60613          	addi	a2,a2,1946 # ffffffffc0205328 <commands+0x408>
ffffffffc0202b96:	11800593          	li	a1,280
ffffffffc0202b9a:	00003517          	auipc	a0,0x3
ffffffffc0202b9e:	13650513          	addi	a0,a0,310 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ba2:	e62fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0202ba6:	00003697          	auipc	a3,0x3
ffffffffc0202baa:	24a68693          	addi	a3,a3,586 # ffffffffc0205df0 <commands+0xed0>
ffffffffc0202bae:	00002617          	auipc	a2,0x2
ffffffffc0202bb2:	77a60613          	addi	a2,a2,1914 # ffffffffc0205328 <commands+0x408>
ffffffffc0202bb6:	0c100593          	li	a1,193
ffffffffc0202bba:	00003517          	auipc	a0,0x3
ffffffffc0202bbe:	11650513          	addi	a0,a0,278 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202bc2:	e42fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0202bc6:	00003697          	auipc	a3,0x3
ffffffffc0202bca:	3ea68693          	addi	a3,a3,1002 # ffffffffc0205fb0 <commands+0x1090>
ffffffffc0202bce:	00002617          	auipc	a2,0x2
ffffffffc0202bd2:	75a60613          	addi	a2,a2,1882 # ffffffffc0205328 <commands+0x408>
ffffffffc0202bd6:	11200593          	li	a1,274
ffffffffc0202bda:	00003517          	auipc	a0,0x3
ffffffffc0202bde:	0f650513          	addi	a0,a0,246 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202be2:	e22fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0202be6:	00003697          	auipc	a3,0x3
ffffffffc0202bea:	3aa68693          	addi	a3,a3,938 # ffffffffc0205f90 <commands+0x1070>
ffffffffc0202bee:	00002617          	auipc	a2,0x2
ffffffffc0202bf2:	73a60613          	addi	a2,a2,1850 # ffffffffc0205328 <commands+0x408>
ffffffffc0202bf6:	11000593          	li	a1,272
ffffffffc0202bfa:	00003517          	auipc	a0,0x3
ffffffffc0202bfe:	0d650513          	addi	a0,a0,214 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202c02:	e02fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0202c06:	00003697          	auipc	a3,0x3
ffffffffc0202c0a:	36268693          	addi	a3,a3,866 # ffffffffc0205f68 <commands+0x1048>
ffffffffc0202c0e:	00002617          	auipc	a2,0x2
ffffffffc0202c12:	71a60613          	addi	a2,a2,1818 # ffffffffc0205328 <commands+0x408>
ffffffffc0202c16:	10e00593          	li	a1,270
ffffffffc0202c1a:	00003517          	auipc	a0,0x3
ffffffffc0202c1e:	0b650513          	addi	a0,a0,182 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202c22:	de2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0202c26:	00003697          	auipc	a3,0x3
ffffffffc0202c2a:	31a68693          	addi	a3,a3,794 # ffffffffc0205f40 <commands+0x1020>
ffffffffc0202c2e:	00002617          	auipc	a2,0x2
ffffffffc0202c32:	6fa60613          	addi	a2,a2,1786 # ffffffffc0205328 <commands+0x408>
ffffffffc0202c36:	10d00593          	li	a1,269
ffffffffc0202c3a:	00003517          	auipc	a0,0x3
ffffffffc0202c3e:	09650513          	addi	a0,a0,150 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202c42:	dc2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0202c46:	00003697          	auipc	a3,0x3
ffffffffc0202c4a:	2ea68693          	addi	a3,a3,746 # ffffffffc0205f30 <commands+0x1010>
ffffffffc0202c4e:	00002617          	auipc	a2,0x2
ffffffffc0202c52:	6da60613          	addi	a2,a2,1754 # ffffffffc0205328 <commands+0x408>
ffffffffc0202c56:	10800593          	li	a1,264
ffffffffc0202c5a:	00003517          	auipc	a0,0x3
ffffffffc0202c5e:	07650513          	addi	a0,a0,118 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202c62:	da2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202c66:	00003697          	auipc	a3,0x3
ffffffffc0202c6a:	1ca68693          	addi	a3,a3,458 # ffffffffc0205e30 <commands+0xf10>
ffffffffc0202c6e:	00002617          	auipc	a2,0x2
ffffffffc0202c72:	6ba60613          	addi	a2,a2,1722 # ffffffffc0205328 <commands+0x408>
ffffffffc0202c76:	10700593          	li	a1,263
ffffffffc0202c7a:	00003517          	auipc	a0,0x3
ffffffffc0202c7e:	05650513          	addi	a0,a0,86 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202c82:	d82fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0202c86:	00003697          	auipc	a3,0x3
ffffffffc0202c8a:	28a68693          	addi	a3,a3,650 # ffffffffc0205f10 <commands+0xff0>
ffffffffc0202c8e:	00002617          	auipc	a2,0x2
ffffffffc0202c92:	69a60613          	addi	a2,a2,1690 # ffffffffc0205328 <commands+0x408>
ffffffffc0202c96:	10600593          	li	a1,262
ffffffffc0202c9a:	00003517          	auipc	a0,0x3
ffffffffc0202c9e:	03650513          	addi	a0,a0,54 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ca2:	d62fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0202ca6:	00003697          	auipc	a3,0x3
ffffffffc0202caa:	23a68693          	addi	a3,a3,570 # ffffffffc0205ee0 <commands+0xfc0>
ffffffffc0202cae:	00002617          	auipc	a2,0x2
ffffffffc0202cb2:	67a60613          	addi	a2,a2,1658 # ffffffffc0205328 <commands+0x408>
ffffffffc0202cb6:	10500593          	li	a1,261
ffffffffc0202cba:	00003517          	auipc	a0,0x3
ffffffffc0202cbe:	01650513          	addi	a0,a0,22 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202cc2:	d42fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0202cc6:	00003697          	auipc	a3,0x3
ffffffffc0202cca:	20268693          	addi	a3,a3,514 # ffffffffc0205ec8 <commands+0xfa8>
ffffffffc0202cce:	00002617          	auipc	a2,0x2
ffffffffc0202cd2:	65a60613          	addi	a2,a2,1626 # ffffffffc0205328 <commands+0x408>
ffffffffc0202cd6:	10400593          	li	a1,260
ffffffffc0202cda:	00003517          	auipc	a0,0x3
ffffffffc0202cde:	ff650513          	addi	a0,a0,-10 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ce2:	d22fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0202ce6:	00003697          	auipc	a3,0x3
ffffffffc0202cea:	14a68693          	addi	a3,a3,330 # ffffffffc0205e30 <commands+0xf10>
ffffffffc0202cee:	00002617          	auipc	a2,0x2
ffffffffc0202cf2:	63a60613          	addi	a2,a2,1594 # ffffffffc0205328 <commands+0x408>
ffffffffc0202cf6:	0fe00593          	li	a1,254
ffffffffc0202cfa:	00003517          	auipc	a0,0x3
ffffffffc0202cfe:	fd650513          	addi	a0,a0,-42 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202d02:	d02fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(!PageProperty(p0));
ffffffffc0202d06:	00003697          	auipc	a3,0x3
ffffffffc0202d0a:	1aa68693          	addi	a3,a3,426 # ffffffffc0205eb0 <commands+0xf90>
ffffffffc0202d0e:	00002617          	auipc	a2,0x2
ffffffffc0202d12:	61a60613          	addi	a2,a2,1562 # ffffffffc0205328 <commands+0x408>
ffffffffc0202d16:	0f900593          	li	a1,249
ffffffffc0202d1a:	00003517          	auipc	a0,0x3
ffffffffc0202d1e:	fb650513          	addi	a0,a0,-74 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202d22:	ce2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0202d26:	00003697          	auipc	a3,0x3
ffffffffc0202d2a:	2aa68693          	addi	a3,a3,682 # ffffffffc0205fd0 <commands+0x10b0>
ffffffffc0202d2e:	00002617          	auipc	a2,0x2
ffffffffc0202d32:	5fa60613          	addi	a2,a2,1530 # ffffffffc0205328 <commands+0x408>
ffffffffc0202d36:	11700593          	li	a1,279
ffffffffc0202d3a:	00003517          	auipc	a0,0x3
ffffffffc0202d3e:	f9650513          	addi	a0,a0,-106 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202d42:	cc2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == 0);
ffffffffc0202d46:	00003697          	auipc	a3,0x3
ffffffffc0202d4a:	2ba68693          	addi	a3,a3,698 # ffffffffc0206000 <commands+0x10e0>
ffffffffc0202d4e:	00002617          	auipc	a2,0x2
ffffffffc0202d52:	5da60613          	addi	a2,a2,1498 # ffffffffc0205328 <commands+0x408>
ffffffffc0202d56:	12600593          	li	a1,294
ffffffffc0202d5a:	00003517          	auipc	a0,0x3
ffffffffc0202d5e:	f7650513          	addi	a0,a0,-138 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202d62:	ca2fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(total == nr_free_pages());
ffffffffc0202d66:	00003697          	auipc	a3,0x3
ffffffffc0202d6a:	f8268693          	addi	a3,a3,-126 # ffffffffc0205ce8 <commands+0xdc8>
ffffffffc0202d6e:	00002617          	auipc	a2,0x2
ffffffffc0202d72:	5ba60613          	addi	a2,a2,1466 # ffffffffc0205328 <commands+0x408>
ffffffffc0202d76:	0f300593          	li	a1,243
ffffffffc0202d7a:	00003517          	auipc	a0,0x3
ffffffffc0202d7e:	f5650513          	addi	a0,a0,-170 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202d82:	c82fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0202d86:	00003697          	auipc	a3,0x3
ffffffffc0202d8a:	fa268693          	addi	a3,a3,-94 # ffffffffc0205d28 <commands+0xe08>
ffffffffc0202d8e:	00002617          	auipc	a2,0x2
ffffffffc0202d92:	59a60613          	addi	a2,a2,1434 # ffffffffc0205328 <commands+0x408>
ffffffffc0202d96:	0ba00593          	li	a1,186
ffffffffc0202d9a:	00003517          	auipc	a0,0x3
ffffffffc0202d9e:	f3650513          	addi	a0,a0,-202 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202da2:	c62fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202da6 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0202da6:	1141                	addi	sp,sp,-16
ffffffffc0202da8:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202daa:	12058f63          	beqz	a1,ffffffffc0202ee8 <default_free_pages+0x142>
    for (; p != base + n; p ++) {
ffffffffc0202dae:	00659693          	slli	a3,a1,0x6
ffffffffc0202db2:	96aa                	add	a3,a3,a0
ffffffffc0202db4:	87aa                	mv	a5,a0
ffffffffc0202db6:	02d50263          	beq	a0,a3,ffffffffc0202dda <default_free_pages+0x34>
ffffffffc0202dba:	6798                	ld	a4,8(a5)
ffffffffc0202dbc:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202dbe:	10071563          	bnez	a4,ffffffffc0202ec8 <default_free_pages+0x122>
ffffffffc0202dc2:	6798                	ld	a4,8(a5)
ffffffffc0202dc4:	8b09                	andi	a4,a4,2
ffffffffc0202dc6:	10071163          	bnez	a4,ffffffffc0202ec8 <default_free_pages+0x122>
        p->flags = 0;
ffffffffc0202dca:	0007b423          	sd	zero,8(a5)
    page->ref = val;
ffffffffc0202dce:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202dd2:	04078793          	addi	a5,a5,64
ffffffffc0202dd6:	fed792e3          	bne	a5,a3,ffffffffc0202dba <default_free_pages+0x14>
    base->property = n;
ffffffffc0202dda:	2581                	sext.w	a1,a1
ffffffffc0202ddc:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc0202dde:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202de2:	4789                	li	a5,2
ffffffffc0202de4:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0202de8:	00031697          	auipc	a3,0x31
ffffffffc0202dec:	00068693          	mv	a3,a3
ffffffffc0202df0:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0202df2:	669c                	ld	a5,8(a3)
ffffffffc0202df4:	01850613          	addi	a2,a0,24
ffffffffc0202df8:	9db9                	addw	a1,a1,a4
ffffffffc0202dfa:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc0202dfc:	08d78f63          	beq	a5,a3,ffffffffc0202e9a <default_free_pages+0xf4>
            struct Page* page = le2page(le, page_link);
ffffffffc0202e00:	fe878713          	addi	a4,a5,-24
ffffffffc0202e04:	0006b803          	ld	a6,0(a3) # ffffffffc0233de8 <free_area>
    if (list_empty(&free_list)) {
ffffffffc0202e08:	4581                	li	a1,0
            if (base < page) {
ffffffffc0202e0a:	00e56a63          	bltu	a0,a4,ffffffffc0202e1e <default_free_pages+0x78>
    return listelm->next;
ffffffffc0202e0e:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0202e10:	04d70a63          	beq	a4,a3,ffffffffc0202e64 <default_free_pages+0xbe>
    for (; p != base + n; p ++) {
ffffffffc0202e14:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0202e16:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0202e1a:	fee57ae3          	bgeu	a0,a4,ffffffffc0202e0e <default_free_pages+0x68>
ffffffffc0202e1e:	c199                	beqz	a1,ffffffffc0202e24 <default_free_pages+0x7e>
ffffffffc0202e20:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0202e24:	6398                	ld	a4,0(a5)
    prev->next = next->prev = elm;
ffffffffc0202e26:	e390                	sd	a2,0(a5)
ffffffffc0202e28:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0202e2a:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202e2c:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0202e2e:	00d70c63          	beq	a4,a3,ffffffffc0202e46 <default_free_pages+0xa0>
        if (p + p->property == base) {
ffffffffc0202e32:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0202e36:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base) {
ffffffffc0202e3a:	02059793          	slli	a5,a1,0x20
ffffffffc0202e3e:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e40:	97b2                	add	a5,a5,a2
ffffffffc0202e42:	02f50b63          	beq	a0,a5,ffffffffc0202e78 <default_free_pages+0xd2>
ffffffffc0202e46:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0202e48:	00d70b63          	beq	a4,a3,ffffffffc0202e5e <default_free_pages+0xb8>
        if (base + base->property == p) {
ffffffffc0202e4c:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0202e4e:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0202e52:	02061793          	slli	a5,a2,0x20
ffffffffc0202e56:	83e9                	srli	a5,a5,0x1a
ffffffffc0202e58:	97aa                	add	a5,a5,a0
ffffffffc0202e5a:	04f68763          	beq	a3,a5,ffffffffc0202ea8 <default_free_pages+0x102>
}
ffffffffc0202e5e:	60a2                	ld	ra,8(sp)
ffffffffc0202e60:	0141                	addi	sp,sp,16
ffffffffc0202e62:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0202e64:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202e66:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0202e68:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0202e6a:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e6c:	02d70463          	beq	a4,a3,ffffffffc0202e94 <default_free_pages+0xee>
    prev->next = next->prev = elm;
ffffffffc0202e70:	8832                	mv	a6,a2
ffffffffc0202e72:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0202e74:	87ba                	mv	a5,a4
ffffffffc0202e76:	b745                	j	ffffffffc0202e16 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0202e78:	491c                	lw	a5,16(a0)
ffffffffc0202e7a:	9dbd                	addw	a1,a1,a5
ffffffffc0202e7c:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202e80:	57f5                	li	a5,-3
ffffffffc0202e82:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202e86:	6d0c                	ld	a1,24(a0)
ffffffffc0202e88:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0202e8a:	8532                	mv	a0,a2
    prev->next = next;
ffffffffc0202e8c:	e59c                	sd	a5,8(a1)
    next->prev = prev;
ffffffffc0202e8e:	6718                	ld	a4,8(a4)
ffffffffc0202e90:	e38c                	sd	a1,0(a5)
ffffffffc0202e92:	bf5d                	j	ffffffffc0202e48 <default_free_pages+0xa2>
ffffffffc0202e94:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0202e96:	873e                	mv	a4,a5
ffffffffc0202e98:	bf69                	j	ffffffffc0202e32 <default_free_pages+0x8c>
}
ffffffffc0202e9a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0202e9c:	e390                	sd	a2,0(a5)
ffffffffc0202e9e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0202ea0:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0202ea2:	ed1c                	sd	a5,24(a0)
ffffffffc0202ea4:	0141                	addi	sp,sp,16
ffffffffc0202ea6:	8082                	ret
            base->property += p->property;
ffffffffc0202ea8:	ff872783          	lw	a5,-8(a4)
ffffffffc0202eac:	ff070693          	addi	a3,a4,-16
ffffffffc0202eb0:	9e3d                	addw	a2,a2,a5
ffffffffc0202eb2:	c910                	sw	a2,16(a0)
ffffffffc0202eb4:	57f5                	li	a5,-3
ffffffffc0202eb6:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202eba:	6314                	ld	a3,0(a4)
ffffffffc0202ebc:	671c                	ld	a5,8(a4)
}
ffffffffc0202ebe:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0202ec0:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc0202ec2:	e394                	sd	a3,0(a5)
ffffffffc0202ec4:	0141                	addi	sp,sp,16
ffffffffc0202ec6:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0202ec8:	00003697          	auipc	a3,0x3
ffffffffc0202ecc:	15068693          	addi	a3,a3,336 # ffffffffc0206018 <commands+0x10f8>
ffffffffc0202ed0:	00002617          	auipc	a2,0x2
ffffffffc0202ed4:	45860613          	addi	a2,a2,1112 # ffffffffc0205328 <commands+0x408>
ffffffffc0202ed8:	08300593          	li	a1,131
ffffffffc0202edc:	00003517          	auipc	a0,0x3
ffffffffc0202ee0:	df450513          	addi	a0,a0,-524 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202ee4:	b20fd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc0202ee8:	00003697          	auipc	a3,0x3
ffffffffc0202eec:	12868693          	addi	a3,a3,296 # ffffffffc0206010 <commands+0x10f0>
ffffffffc0202ef0:	00002617          	auipc	a2,0x2
ffffffffc0202ef4:	43860613          	addi	a2,a2,1080 # ffffffffc0205328 <commands+0x408>
ffffffffc0202ef8:	08000593          	li	a1,128
ffffffffc0202efc:	00003517          	auipc	a0,0x3
ffffffffc0202f00:	dd450513          	addi	a0,a0,-556 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0202f04:	b00fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202f08 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0202f08:	c941                	beqz	a0,ffffffffc0202f98 <default_alloc_pages+0x90>
    if (n > nr_free) {
ffffffffc0202f0a:	00031597          	auipc	a1,0x31
ffffffffc0202f0e:	ede58593          	addi	a1,a1,-290 # ffffffffc0233de8 <free_area>
ffffffffc0202f12:	0105a803          	lw	a6,16(a1)
ffffffffc0202f16:	872a                	mv	a4,a0
ffffffffc0202f18:	02081793          	slli	a5,a6,0x20
ffffffffc0202f1c:	9381                	srli	a5,a5,0x20
ffffffffc0202f1e:	00a7ee63          	bltu	a5,a0,ffffffffc0202f3a <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0202f22:	87ae                	mv	a5,a1
ffffffffc0202f24:	a801                	j	ffffffffc0202f34 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc0202f26:	ff87a683          	lw	a3,-8(a5)
ffffffffc0202f2a:	02069613          	slli	a2,a3,0x20
ffffffffc0202f2e:	9201                	srli	a2,a2,0x20
ffffffffc0202f30:	00e67763          	bgeu	a2,a4,ffffffffc0202f3e <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0202f34:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc0202f36:	feb798e3          	bne	a5,a1,ffffffffc0202f26 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0202f3a:	4501                	li	a0,0
}
ffffffffc0202f3c:	8082                	ret
    return listelm->prev;
ffffffffc0202f3e:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0202f42:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0202f46:	fe878513          	addi	a0,a5,-24
    prev->next = next;
ffffffffc0202f4a:	00070e1b          	sext.w	t3,a4
ffffffffc0202f4e:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0202f52:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc0202f56:	02c77863          	bgeu	a4,a2,ffffffffc0202f86 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0202f5a:	071a                	slli	a4,a4,0x6
ffffffffc0202f5c:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0202f5e:	41c686bb          	subw	a3,a3,t3
ffffffffc0202f62:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202f64:	00870613          	addi	a2,a4,8
ffffffffc0202f68:	4689                	li	a3,2
ffffffffc0202f6a:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0202f6e:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0202f72:	01870613          	addi	a2,a4,24
    prev->next = next->prev = elm;
ffffffffc0202f76:	0105a803          	lw	a6,16(a1)
ffffffffc0202f7a:	e290                	sd	a2,0(a3)
ffffffffc0202f7c:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0202f80:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0202f82:	01173c23          	sd	a7,24(a4)
        nr_free -= n;
ffffffffc0202f86:	41c8083b          	subw	a6,a6,t3
ffffffffc0202f8a:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0202f8e:	5775                	li	a4,-3
ffffffffc0202f90:	17c1                	addi	a5,a5,-16
ffffffffc0202f92:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0202f96:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc0202f98:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0202f9a:	00003697          	auipc	a3,0x3
ffffffffc0202f9e:	07668693          	addi	a3,a3,118 # ffffffffc0206010 <commands+0x10f0>
ffffffffc0202fa2:	00002617          	auipc	a2,0x2
ffffffffc0202fa6:	38660613          	addi	a2,a2,902 # ffffffffc0205328 <commands+0x408>
ffffffffc0202faa:	06200593          	li	a1,98
ffffffffc0202fae:	00003517          	auipc	a0,0x3
ffffffffc0202fb2:	d2250513          	addi	a0,a0,-734 # ffffffffc0205cd0 <commands+0xdb0>
default_alloc_pages(size_t n) {
ffffffffc0202fb6:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202fb8:	a4cfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0202fbc <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc0202fbc:	1141                	addi	sp,sp,-16
ffffffffc0202fbe:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0202fc0:	c5f1                	beqz	a1,ffffffffc020308c <default_init_memmap+0xd0>
    for (; p != base + n; p ++) {
ffffffffc0202fc2:	00659693          	slli	a3,a1,0x6
ffffffffc0202fc6:	96aa                	add	a3,a3,a0
ffffffffc0202fc8:	87aa                	mv	a5,a0
ffffffffc0202fca:	00d50f63          	beq	a0,a3,ffffffffc0202fe8 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0202fce:	6798                	ld	a4,8(a5)
ffffffffc0202fd0:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc0202fd2:	cf49                	beqz	a4,ffffffffc020306c <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc0202fd4:	0007a823          	sw	zero,16(a5)
ffffffffc0202fd8:	0007b423          	sd	zero,8(a5)
ffffffffc0202fdc:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0202fe0:	04078793          	addi	a5,a5,64
ffffffffc0202fe4:	fed795e3          	bne	a5,a3,ffffffffc0202fce <default_init_memmap+0x12>
    base->property = n;
ffffffffc0202fe8:	2581                	sext.w	a1,a1
ffffffffc0202fea:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0202fec:	4789                	li	a5,2
ffffffffc0202fee:	00850713          	addi	a4,a0,8
ffffffffc0202ff2:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0202ff6:	00031697          	auipc	a3,0x31
ffffffffc0202ffa:	df268693          	addi	a3,a3,-526 # ffffffffc0233de8 <free_area>
ffffffffc0202ffe:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0203000:	669c                	ld	a5,8(a3)
ffffffffc0203002:	01850613          	addi	a2,a0,24
ffffffffc0203006:	9db9                	addw	a1,a1,a4
ffffffffc0203008:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020300a:	04d78a63          	beq	a5,a3,ffffffffc020305e <default_init_memmap+0xa2>
            struct Page* page = le2page(le, page_link);
ffffffffc020300e:	fe878713          	addi	a4,a5,-24
ffffffffc0203012:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0203016:	4581                	li	a1,0
            if (base < page) {
ffffffffc0203018:	00e56a63          	bltu	a0,a4,ffffffffc020302c <default_init_memmap+0x70>
    return listelm->next;
ffffffffc020301c:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc020301e:	02d70263          	beq	a4,a3,ffffffffc0203042 <default_init_memmap+0x86>
    for (; p != base + n; p ++) {
ffffffffc0203022:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0203024:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0203028:	fee57ae3          	bgeu	a0,a4,ffffffffc020301c <default_init_memmap+0x60>
ffffffffc020302c:	c199                	beqz	a1,ffffffffc0203032 <default_init_memmap+0x76>
ffffffffc020302e:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0203032:	6398                	ld	a4,0(a5)
}
ffffffffc0203034:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0203036:	e390                	sd	a2,0(a5)
ffffffffc0203038:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020303a:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020303c:	ed18                	sd	a4,24(a0)
ffffffffc020303e:	0141                	addi	sp,sp,16
ffffffffc0203040:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0203042:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203044:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0203046:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0203048:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020304a:	00d70663          	beq	a4,a3,ffffffffc0203056 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc020304e:	8832                	mv	a6,a2
ffffffffc0203050:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0203052:	87ba                	mv	a5,a4
ffffffffc0203054:	bfc1                	j	ffffffffc0203024 <default_init_memmap+0x68>
}
ffffffffc0203056:	60a2                	ld	ra,8(sp)
ffffffffc0203058:	e290                	sd	a2,0(a3)
ffffffffc020305a:	0141                	addi	sp,sp,16
ffffffffc020305c:	8082                	ret
ffffffffc020305e:	60a2                	ld	ra,8(sp)
ffffffffc0203060:	e390                	sd	a2,0(a5)
ffffffffc0203062:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0203064:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0203066:	ed1c                	sd	a5,24(a0)
ffffffffc0203068:	0141                	addi	sp,sp,16
ffffffffc020306a:	8082                	ret
        assert(PageReserved(p));
ffffffffc020306c:	00003697          	auipc	a3,0x3
ffffffffc0203070:	fd468693          	addi	a3,a3,-44 # ffffffffc0206040 <commands+0x1120>
ffffffffc0203074:	00002617          	auipc	a2,0x2
ffffffffc0203078:	2b460613          	addi	a2,a2,692 # ffffffffc0205328 <commands+0x408>
ffffffffc020307c:	04900593          	li	a1,73
ffffffffc0203080:	00003517          	auipc	a0,0x3
ffffffffc0203084:	c5050513          	addi	a0,a0,-944 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc0203088:	97cfd0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(n > 0);
ffffffffc020308c:	00003697          	auipc	a3,0x3
ffffffffc0203090:	f8468693          	addi	a3,a3,-124 # ffffffffc0206010 <commands+0x10f0>
ffffffffc0203094:	00002617          	auipc	a2,0x2
ffffffffc0203098:	29460613          	addi	a2,a2,660 # ffffffffc0205328 <commands+0x408>
ffffffffc020309c:	04600593          	li	a1,70
ffffffffc02030a0:	00003517          	auipc	a0,0x3
ffffffffc02030a4:	c3050513          	addi	a0,a0,-976 # ffffffffc0205cd0 <commands+0xdb0>
ffffffffc02030a8:	95cfd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030ac <swapfs_init>:
#include <ide.h>
#include <pmm.h>
#include <assert.h>

void
swapfs_init(void) {
ffffffffc02030ac:	1141                	addi	sp,sp,-16
    static_assert((PGSIZE % SECTSIZE) == 0);
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030ae:	4505                	li	a0,1
swapfs_init(void) {
ffffffffc02030b0:	e406                	sd	ra,8(sp)
    if (!ide_device_valid(SWAP_DEV_NO)) {
ffffffffc02030b2:	c6cfd0ef          	jal	ra,ffffffffc020051e <ide_device_valid>
ffffffffc02030b6:	cd01                	beqz	a0,ffffffffc02030ce <swapfs_init+0x22>
        panic("swap fs isn't available.\n");
    }
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030b8:	4505                	li	a0,1
ffffffffc02030ba:	c6afd0ef          	jal	ra,ffffffffc0200524 <ide_device_size>
}
ffffffffc02030be:	60a2                	ld	ra,8(sp)
    max_swap_offset = ide_device_size(SWAP_DEV_NO) / (PGSIZE / SECTSIZE);
ffffffffc02030c0:	810d                	srli	a0,a0,0x3
ffffffffc02030c2:	00031797          	auipc	a5,0x31
ffffffffc02030c6:	cea7b323          	sd	a0,-794(a5) # ffffffffc0233da8 <max_swap_offset>
}
ffffffffc02030ca:	0141                	addi	sp,sp,16
ffffffffc02030cc:	8082                	ret
        panic("swap fs isn't available.\n");
ffffffffc02030ce:	00003617          	auipc	a2,0x3
ffffffffc02030d2:	fd260613          	addi	a2,a2,-46 # ffffffffc02060a0 <default_pmm_manager+0x38>
ffffffffc02030d6:	45b5                	li	a1,13
ffffffffc02030d8:	00003517          	auipc	a0,0x3
ffffffffc02030dc:	fe850513          	addi	a0,a0,-24 # ffffffffc02060c0 <default_pmm_manager+0x58>
ffffffffc02030e0:	924fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02030e4 <swapfs_read>:

int
swapfs_read(swap_entry_t entry, struct Page *page) {
ffffffffc02030e4:	1141                	addi	sp,sp,-16
ffffffffc02030e6:	e406                	sd	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02030e8:	00855793          	srli	a5,a0,0x8
ffffffffc02030ec:	cbb1                	beqz	a5,ffffffffc0203140 <swapfs_read+0x5c>
ffffffffc02030ee:	00031717          	auipc	a4,0x31
ffffffffc02030f2:	cba73703          	ld	a4,-838(a4) # ffffffffc0233da8 <max_swap_offset>
ffffffffc02030f6:	04e7f563          	bgeu	a5,a4,ffffffffc0203140 <swapfs_read+0x5c>
    return page - pages + nbase;
ffffffffc02030fa:	00031617          	auipc	a2,0x31
ffffffffc02030fe:	c0663603          	ld	a2,-1018(a2) # ffffffffc0233d00 <pages>
ffffffffc0203102:	8d91                	sub	a1,a1,a2
ffffffffc0203104:	4065d613          	srai	a2,a1,0x6
ffffffffc0203108:	00004717          	auipc	a4,0x4
ffffffffc020310c:	99873703          	ld	a4,-1640(a4) # ffffffffc0206aa0 <nbase>
ffffffffc0203110:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc0203112:	00c61713          	slli	a4,a2,0xc
ffffffffc0203116:	8331                	srli	a4,a4,0xc
ffffffffc0203118:	00031697          	auipc	a3,0x31
ffffffffc020311c:	b706b683          	ld	a3,-1168(a3) # ffffffffc0233c88 <npage>
ffffffffc0203120:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc0203124:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc0203126:	02d77963          	bgeu	a4,a3,ffffffffc0203158 <swapfs_read+0x74>
}
ffffffffc020312a:	60a2                	ld	ra,8(sp)
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020312c:	00031797          	auipc	a5,0x31
ffffffffc0203130:	bc47b783          	ld	a5,-1084(a5) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0203134:	46a1                	li	a3,8
ffffffffc0203136:	963e                	add	a2,a2,a5
ffffffffc0203138:	4505                	li	a0,1
}
ffffffffc020313a:	0141                	addi	sp,sp,16
    return ide_read_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc020313c:	beefd06f          	j	ffffffffc020052a <ide_read_secs>
ffffffffc0203140:	86aa                	mv	a3,a0
ffffffffc0203142:	00003617          	auipc	a2,0x3
ffffffffc0203146:	f9660613          	addi	a2,a2,-106 # ffffffffc02060d8 <default_pmm_manager+0x70>
ffffffffc020314a:	45d1                	li	a1,20
ffffffffc020314c:	00003517          	auipc	a0,0x3
ffffffffc0203150:	f7450513          	addi	a0,a0,-140 # ffffffffc02060c0 <default_pmm_manager+0x58>
ffffffffc0203154:	8b0fd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc0203158:	86b2                	mv	a3,a2
ffffffffc020315a:	06900593          	li	a1,105
ffffffffc020315e:	00002617          	auipc	a2,0x2
ffffffffc0203162:	57a60613          	addi	a2,a2,1402 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc0203166:	00002517          	auipc	a0,0x2
ffffffffc020316a:	4d250513          	addi	a0,a0,1234 # ffffffffc0205638 <commands+0x718>
ffffffffc020316e:	896fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203172 <swapfs_write>:

int
swapfs_write(swap_entry_t entry, struct Page *page) {
ffffffffc0203172:	1141                	addi	sp,sp,-16
ffffffffc0203174:	e406                	sd	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc0203176:	00855793          	srli	a5,a0,0x8
ffffffffc020317a:	cbb1                	beqz	a5,ffffffffc02031ce <swapfs_write+0x5c>
ffffffffc020317c:	00031717          	auipc	a4,0x31
ffffffffc0203180:	c2c73703          	ld	a4,-980(a4) # ffffffffc0233da8 <max_swap_offset>
ffffffffc0203184:	04e7f563          	bgeu	a5,a4,ffffffffc02031ce <swapfs_write+0x5c>
    return page - pages + nbase;
ffffffffc0203188:	00031617          	auipc	a2,0x31
ffffffffc020318c:	b7863603          	ld	a2,-1160(a2) # ffffffffc0233d00 <pages>
ffffffffc0203190:	8d91                	sub	a1,a1,a2
ffffffffc0203192:	4065d613          	srai	a2,a1,0x6
ffffffffc0203196:	00004717          	auipc	a4,0x4
ffffffffc020319a:	90a73703          	ld	a4,-1782(a4) # ffffffffc0206aa0 <nbase>
ffffffffc020319e:	963a                	add	a2,a2,a4
    return KADDR(page2pa(page));
ffffffffc02031a0:	00c61713          	slli	a4,a2,0xc
ffffffffc02031a4:	8331                	srli	a4,a4,0xc
ffffffffc02031a6:	00031697          	auipc	a3,0x31
ffffffffc02031aa:	ae26b683          	ld	a3,-1310(a3) # ffffffffc0233c88 <npage>
ffffffffc02031ae:	0037959b          	slliw	a1,a5,0x3
    return page2ppn(page) << PGSHIFT;
ffffffffc02031b2:	0632                	slli	a2,a2,0xc
    return KADDR(page2pa(page));
ffffffffc02031b4:	02d77963          	bgeu	a4,a3,ffffffffc02031e6 <swapfs_write+0x74>
}
ffffffffc02031b8:	60a2                	ld	ra,8(sp)
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031ba:	00031797          	auipc	a5,0x31
ffffffffc02031be:	b367b783          	ld	a5,-1226(a5) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc02031c2:	46a1                	li	a3,8
ffffffffc02031c4:	963e                	add	a2,a2,a5
ffffffffc02031c6:	4505                	li	a0,1
}
ffffffffc02031c8:	0141                	addi	sp,sp,16
    return ide_write_secs(SWAP_DEV_NO, swap_offset(entry) * PAGE_NSECT, page2kva(page), PAGE_NSECT);
ffffffffc02031ca:	b84fd06f          	j	ffffffffc020054e <ide_write_secs>
ffffffffc02031ce:	86aa                	mv	a3,a0
ffffffffc02031d0:	00003617          	auipc	a2,0x3
ffffffffc02031d4:	f0860613          	addi	a2,a2,-248 # ffffffffc02060d8 <default_pmm_manager+0x70>
ffffffffc02031d8:	45e5                	li	a1,25
ffffffffc02031da:	00003517          	auipc	a0,0x3
ffffffffc02031de:	ee650513          	addi	a0,a0,-282 # ffffffffc02060c0 <default_pmm_manager+0x58>
ffffffffc02031e2:	822fd0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc02031e6:	86b2                	mv	a3,a2
ffffffffc02031e8:	06900593          	li	a1,105
ffffffffc02031ec:	00002617          	auipc	a2,0x2
ffffffffc02031f0:	4ec60613          	addi	a2,a2,1260 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc02031f4:	00002517          	auipc	a0,0x2
ffffffffc02031f8:	44450513          	addi	a0,a0,1092 # ffffffffc0205638 <commands+0x718>
ffffffffc02031fc:	808fd0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203200 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203200:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203202:	9402                	jalr	s0

	jal do_exit
ffffffffc0203204:	77a000ef          	jal	ra,ffffffffc020397e <do_exit>

ffffffffc0203208 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0203208:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc020320c:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0203210:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0203212:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0203214:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0203218:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc020321c:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0203220:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0203224:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0203228:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc020322c:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0203230:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0203234:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0203238:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc020323c:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0203240:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0203244:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0203246:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0203248:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc020324c:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0203250:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0203254:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0203258:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc020325c:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0203260:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0203264:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0203268:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc020326c:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0203270:	8082                	ret

ffffffffc0203272 <alloc_proc>:
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
ffffffffc0203272:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203274:	14800513          	li	a0,328
alloc_proc(void) {
ffffffffc0203278:	e022                	sd	s0,0(sp)
ffffffffc020327a:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc020327c:	fb7fe0ef          	jal	ra,ffffffffc0202232 <kmalloc>
ffffffffc0203280:	842a                	mv	s0,a0
    if (proc != NULL) {
ffffffffc0203282:	c535                	beqz	a0,ffffffffc02032ee <alloc_proc+0x7c>
        proc->state = PROC_UNINIT;
ffffffffc0203284:	57fd                	li	a5,-1
ffffffffc0203286:	1782                	slli	a5,a5,0x20
ffffffffc0203288:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc020328a:	07000613          	li	a2,112
ffffffffc020328e:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203290:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203294:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203298:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc020329c:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc02032a0:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc02032a4:	03050513          	addi	a0,a0,48
ffffffffc02032a8:	5aa010ef          	jal	ra,ffffffffc0204852 <memset>
        proc->tf = NULL;
        proc->cr3 = boot_cr3;
ffffffffc02032ac:	00031797          	auipc	a5,0x31
ffffffffc02032b0:	a4c7b783          	ld	a5,-1460(a5) # ffffffffc0233cf8 <boot_cr3>
        proc->tf = NULL;
ffffffffc02032b4:	0a043023          	sd	zero,160(s0)
        proc->cr3 = boot_cr3;
ffffffffc02032b8:	f45c                	sd	a5,168(s0)
        proc->flags = 0;
ffffffffc02032ba:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc02032be:	463d                	li	a2,15
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	0b440513          	addi	a0,s0,180
ffffffffc02032c6:	58c010ef          	jal	ra,ffffffffc0204852 <memset>
        proc->wait_state = 0;
ffffffffc02032ca:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->optr = proc->yptr = NULL;
ffffffffc02032ce:	0e043c23          	sd	zero,248(s0)
ffffffffc02032d2:	10043023          	sd	zero,256(s0)
ffffffffc02032d6:	0e043823          	sd	zero,240(s0)
        proc->time_slice = 0;
ffffffffc02032da:	12042023          	sw	zero,288(s0)
        proc->labschedule_run_pool.left = proc->labschedule_run_pool.right = proc->labschedule_run_pool.parent = NULL;
ffffffffc02032de:	12043423          	sd	zero,296(s0)
ffffffffc02032e2:	12043823          	sd	zero,304(s0)
ffffffffc02032e6:	12043c23          	sd	zero,312(s0)
        proc->labschedule_stride = 0;
ffffffffc02032ea:	14043023          	sd	zero,320(s0)
        proc->labschedule_priority = 0;
    }
    return proc;
}
ffffffffc02032ee:	60a2                	ld	ra,8(sp)
ffffffffc02032f0:	8522                	mv	a0,s0
ffffffffc02032f2:	6402                	ld	s0,0(sp)
ffffffffc02032f4:	0141                	addi	sp,sp,16
ffffffffc02032f6:	8082                	ret

ffffffffc02032f8 <forkret>:
// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
ffffffffc02032f8:	00031797          	auipc	a5,0x31
ffffffffc02032fc:	9b87b783          	ld	a5,-1608(a5) # ffffffffc0233cb0 <current>
ffffffffc0203300:	73c8                	ld	a0,160(a5)
ffffffffc0203302:	a31fd06f          	j	ffffffffc0200d32 <forkrets>

ffffffffc0203306 <user_main>:
static int
user_main(void *arg) {
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(rr);
ffffffffc0203306:	00031797          	auipc	a5,0x31
ffffffffc020330a:	9aa7b783          	ld	a5,-1622(a5) # ffffffffc0233cb0 <current>
ffffffffc020330e:	43cc                	lw	a1,4(a5)
user_main(void *arg) {
ffffffffc0203310:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(rr);
ffffffffc0203312:	00003617          	auipc	a2,0x3
ffffffffc0203316:	de660613          	addi	a2,a2,-538 # ffffffffc02060f8 <default_pmm_manager+0x90>
ffffffffc020331a:	00003517          	auipc	a0,0x3
ffffffffc020331e:	de650513          	addi	a0,a0,-538 # ffffffffc0206100 <default_pmm_manager+0x98>
user_main(void *arg) {
ffffffffc0203322:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(rr);
ffffffffc0203324:	da5fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
ffffffffc0203328:	3fe07797          	auipc	a5,0x3fe07
ffffffffc020332c:	6d878793          	addi	a5,a5,1752 # aa00 <_binary_obj___user_rr_out_size>
ffffffffc0203330:	e43e                	sd	a5,8(sp)
ffffffffc0203332:	00003517          	auipc	a0,0x3
ffffffffc0203336:	dc650513          	addi	a0,a0,-570 # ffffffffc02060f8 <default_pmm_manager+0x90>
ffffffffc020333a:	00010797          	auipc	a5,0x10
ffffffffc020333e:	56e78793          	addi	a5,a5,1390 # ffffffffc02138a8 <_binary_obj___user_rr_out_start>
ffffffffc0203342:	f03e                	sd	a5,32(sp)
ffffffffc0203344:	f42a                	sd	a0,40(sp)
    int64_t ret=0, len = strlen(name);
ffffffffc0203346:	e802                	sd	zero,16(sp)
ffffffffc0203348:	4a0010ef          	jal	ra,ffffffffc02047e8 <strlen>
ffffffffc020334c:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc020334e:	4511                	li	a0,4
ffffffffc0203350:	55a2                	lw	a1,40(sp)
ffffffffc0203352:	4662                	lw	a2,24(sp)
ffffffffc0203354:	5682                	lw	a3,32(sp)
ffffffffc0203356:	4722                	lw	a4,8(sp)
ffffffffc0203358:	48a9                	li	a7,10
ffffffffc020335a:	9002                	ebreak
ffffffffc020335c:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc020335e:	65c2                	ld	a1,16(sp)
ffffffffc0203360:	00003517          	auipc	a0,0x3
ffffffffc0203364:	dc850513          	addi	a0,a0,-568 # ffffffffc0206128 <default_pmm_manager+0xc0>
ffffffffc0203368:	d61fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc020336c:	00003617          	auipc	a2,0x3
ffffffffc0203370:	dcc60613          	addi	a2,a2,-564 # ffffffffc0206138 <default_pmm_manager+0xd0>
ffffffffc0203374:	30700593          	li	a1,775
ffffffffc0203378:	00003517          	auipc	a0,0x3
ffffffffc020337c:	de050513          	addi	a0,a0,-544 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203380:	e85fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203384 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203384:	6d14                	ld	a3,24(a0)
put_pgdir(struct mm_struct *mm) {
ffffffffc0203386:	1141                	addi	sp,sp,-16
ffffffffc0203388:	e406                	sd	ra,8(sp)
ffffffffc020338a:	c02007b7          	lui	a5,0xc0200
ffffffffc020338e:	02f6ee63          	bltu	a3,a5,ffffffffc02033ca <put_pgdir+0x46>
ffffffffc0203392:	00031517          	auipc	a0,0x31
ffffffffc0203396:	95e53503          	ld	a0,-1698(a0) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc020339a:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage) {
ffffffffc020339c:	82b1                	srli	a3,a3,0xc
ffffffffc020339e:	00031797          	auipc	a5,0x31
ffffffffc02033a2:	8ea7b783          	ld	a5,-1814(a5) # ffffffffc0233c88 <npage>
ffffffffc02033a6:	02f6fe63          	bgeu	a3,a5,ffffffffc02033e2 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc02033aa:	00003517          	auipc	a0,0x3
ffffffffc02033ae:	6f653503          	ld	a0,1782(a0) # ffffffffc0206aa0 <nbase>
}
ffffffffc02033b2:	60a2                	ld	ra,8(sp)
ffffffffc02033b4:	8e89                	sub	a3,a3,a0
ffffffffc02033b6:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc02033b8:	00031517          	auipc	a0,0x31
ffffffffc02033bc:	94853503          	ld	a0,-1720(a0) # ffffffffc0233d00 <pages>
ffffffffc02033c0:	4585                	li	a1,1
ffffffffc02033c2:	9536                	add	a0,a0,a3
}
ffffffffc02033c4:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc02033c6:	a1ffd06f          	j	ffffffffc0200de4 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc02033ca:	00002617          	auipc	a2,0x2
ffffffffc02033ce:	2d660613          	addi	a2,a2,726 # ffffffffc02056a0 <commands+0x780>
ffffffffc02033d2:	06e00593          	li	a1,110
ffffffffc02033d6:	00002517          	auipc	a0,0x2
ffffffffc02033da:	26250513          	addi	a0,a0,610 # ffffffffc0205638 <commands+0x718>
ffffffffc02033de:	e27fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02033e2:	00002617          	auipc	a2,0x2
ffffffffc02033e6:	23660613          	addi	a2,a2,566 # ffffffffc0205618 <commands+0x6f8>
ffffffffc02033ea:	06200593          	li	a1,98
ffffffffc02033ee:	00002517          	auipc	a0,0x2
ffffffffc02033f2:	24a50513          	addi	a0,a0,586 # ffffffffc0205638 <commands+0x718>
ffffffffc02033f6:	e0ffc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02033fa <setup_pgdir>:
setup_pgdir(struct mm_struct *mm) {
ffffffffc02033fa:	1101                	addi	sp,sp,-32
ffffffffc02033fc:	e426                	sd	s1,8(sp)
ffffffffc02033fe:	84aa                	mv	s1,a0
    if ((page = alloc_page()) == NULL) {
ffffffffc0203400:	4505                	li	a0,1
setup_pgdir(struct mm_struct *mm) {
ffffffffc0203402:	ec06                	sd	ra,24(sp)
ffffffffc0203404:	e822                	sd	s0,16(sp)
    if ((page = alloc_page()) == NULL) {
ffffffffc0203406:	94dfd0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
ffffffffc020340a:	c939                	beqz	a0,ffffffffc0203460 <setup_pgdir+0x66>
    return page - pages + nbase;
ffffffffc020340c:	00031697          	auipc	a3,0x31
ffffffffc0203410:	8f46b683          	ld	a3,-1804(a3) # ffffffffc0233d00 <pages>
ffffffffc0203414:	40d506b3          	sub	a3,a0,a3
ffffffffc0203418:	8699                	srai	a3,a3,0x6
ffffffffc020341a:	00003417          	auipc	s0,0x3
ffffffffc020341e:	68643403          	ld	s0,1670(s0) # ffffffffc0206aa0 <nbase>
ffffffffc0203422:	96a2                	add	a3,a3,s0
    return KADDR(page2pa(page));
ffffffffc0203424:	00c69793          	slli	a5,a3,0xc
ffffffffc0203428:	83b1                	srli	a5,a5,0xc
ffffffffc020342a:	00031717          	auipc	a4,0x31
ffffffffc020342e:	85e73703          	ld	a4,-1954(a4) # ffffffffc0233c88 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0203432:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203434:	02e7f863          	bgeu	a5,a4,ffffffffc0203464 <setup_pgdir+0x6a>
ffffffffc0203438:	00031417          	auipc	s0,0x31
ffffffffc020343c:	8b843403          	ld	s0,-1864(s0) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0203440:	9436                	add	s0,s0,a3
    memcpy(pgdir, boot_pgdir, PGSIZE);
ffffffffc0203442:	6605                	lui	a2,0x1
ffffffffc0203444:	00031597          	auipc	a1,0x31
ffffffffc0203448:	83c5b583          	ld	a1,-1988(a1) # ffffffffc0233c80 <boot_pgdir>
ffffffffc020344c:	8522                	mv	a0,s0
ffffffffc020344e:	416010ef          	jal	ra,ffffffffc0204864 <memcpy>
    return 0;
ffffffffc0203452:	4501                	li	a0,0
    mm->pgdir = pgdir;
ffffffffc0203454:	ec80                	sd	s0,24(s1)
}
ffffffffc0203456:	60e2                	ld	ra,24(sp)
ffffffffc0203458:	6442                	ld	s0,16(sp)
ffffffffc020345a:	64a2                	ld	s1,8(sp)
ffffffffc020345c:	6105                	addi	sp,sp,32
ffffffffc020345e:	8082                	ret
        return -E_NO_MEM;
ffffffffc0203460:	5571                	li	a0,-4
ffffffffc0203462:	bfd5                	j	ffffffffc0203456 <setup_pgdir+0x5c>
ffffffffc0203464:	00002617          	auipc	a2,0x2
ffffffffc0203468:	27460613          	addi	a2,a2,628 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc020346c:	06900593          	li	a1,105
ffffffffc0203470:	00002517          	auipc	a0,0x2
ffffffffc0203474:	1c850513          	addi	a0,a0,456 # ffffffffc0205638 <commands+0x718>
ffffffffc0203478:	d8dfc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020347c <set_proc_name>:
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020347c:	1101                	addi	sp,sp,-32
ffffffffc020347e:	e822                	sd	s0,16(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203480:	0b450413          	addi	s0,a0,180
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203484:	e426                	sd	s1,8(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203486:	4641                	li	a2,16
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc0203488:	84ae                	mv	s1,a1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc020348a:	8522                	mv	a0,s0
ffffffffc020348c:	4581                	li	a1,0
set_proc_name(struct proc_struct *proc, const char *name) {
ffffffffc020348e:	ec06                	sd	ra,24(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0203490:	3c2010ef          	jal	ra,ffffffffc0204852 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0203494:	8522                	mv	a0,s0
}
ffffffffc0203496:	6442                	ld	s0,16(sp)
ffffffffc0203498:	60e2                	ld	ra,24(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020349a:	85a6                	mv	a1,s1
}
ffffffffc020349c:	64a2                	ld	s1,8(sp)
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc020349e:	463d                	li	a2,15
}
ffffffffc02034a0:	6105                	addi	sp,sp,32
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02034a2:	3c20106f          	j	ffffffffc0204864 <memcpy>

ffffffffc02034a6 <proc_run>:
proc_run(struct proc_struct *proc) {
ffffffffc02034a6:	7179                	addi	sp,sp,-48
ffffffffc02034a8:	ec4a                	sd	s2,24(sp)
    if (proc != current) {
ffffffffc02034aa:	00031917          	auipc	s2,0x31
ffffffffc02034ae:	80690913          	addi	s2,s2,-2042 # ffffffffc0233cb0 <current>
proc_run(struct proc_struct *proc) {
ffffffffc02034b2:	f026                	sd	s1,32(sp)
    if (proc != current) {
ffffffffc02034b4:	00093483          	ld	s1,0(s2)
proc_run(struct proc_struct *proc) {
ffffffffc02034b8:	f406                	sd	ra,40(sp)
ffffffffc02034ba:	e84e                	sd	s3,16(sp)
    if (proc != current) {
ffffffffc02034bc:	02a48863          	beq	s1,a0,ffffffffc02034ec <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034c0:	100027f3          	csrr	a5,sstatus
ffffffffc02034c4:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02034c6:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02034c8:	ef9d                	bnez	a5,ffffffffc0203506 <proc_run+0x60>

#define barrier() __asm__ __volatile__ ("fence" ::: "memory")

static inline void
lcr3(unsigned long cr3) {
    write_csr(satp, 0x8000000000000000 | (cr3 >> RISCV_PGSHIFT));
ffffffffc02034ca:	755c                	ld	a5,168(a0)
ffffffffc02034cc:	577d                	li	a4,-1
ffffffffc02034ce:	177e                	slli	a4,a4,0x3f
ffffffffc02034d0:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc02034d2:	00a93023          	sd	a0,0(s2)
ffffffffc02034d6:	8fd9                	or	a5,a5,a4
ffffffffc02034d8:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context));
ffffffffc02034dc:	03050593          	addi	a1,a0,48
ffffffffc02034e0:	03048513          	addi	a0,s1,48
ffffffffc02034e4:	d25ff0ef          	jal	ra,ffffffffc0203208 <switch_to>
    if (flag) {
ffffffffc02034e8:	00099863          	bnez	s3,ffffffffc02034f8 <proc_run+0x52>
}
ffffffffc02034ec:	70a2                	ld	ra,40(sp)
ffffffffc02034ee:	7482                	ld	s1,32(sp)
ffffffffc02034f0:	6962                	ld	s2,24(sp)
ffffffffc02034f2:	69c2                	ld	s3,16(sp)
ffffffffc02034f4:	6145                	addi	sp,sp,48
ffffffffc02034f6:	8082                	ret
ffffffffc02034f8:	70a2                	ld	ra,40(sp)
ffffffffc02034fa:	7482                	ld	s1,32(sp)
ffffffffc02034fc:	6962                	ld	s2,24(sp)
ffffffffc02034fe:	69c2                	ld	s3,16(sp)
ffffffffc0203500:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203502:	92afd06f          	j	ffffffffc020062c <intr_enable>
ffffffffc0203506:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203508:	92afd0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020350c:	6522                	ld	a0,8(sp)
ffffffffc020350e:	4985                	li	s3,1
ffffffffc0203510:	bf6d                	j	ffffffffc02034ca <proc_run+0x24>

ffffffffc0203512 <find_proc>:
    if (0 < pid && pid < MAX_PID) {
ffffffffc0203512:	6789                	lui	a5,0x2
ffffffffc0203514:	fff5071b          	addiw	a4,a0,-1
ffffffffc0203518:	17f9                	addi	a5,a5,-2
ffffffffc020351a:	04e7e063          	bltu	a5,a4,ffffffffc020355a <find_proc+0x48>
find_proc(int pid) {
ffffffffc020351e:	1141                	addi	sp,sp,-16
ffffffffc0203520:	e022                	sd	s0,0(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0203522:	45a9                	li	a1,10
ffffffffc0203524:	842a                	mv	s0,a0
ffffffffc0203526:	2501                	sext.w	a0,a0
find_proc(int pid) {
ffffffffc0203528:	e406                	sd	ra,8(sp)
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020352a:	740010ef          	jal	ra,ffffffffc0204c6a <hash32>
ffffffffc020352e:	02051693          	slli	a3,a0,0x20
ffffffffc0203532:	0002c797          	auipc	a5,0x2c
ffffffffc0203536:	71678793          	addi	a5,a5,1814 # ffffffffc022fc48 <hash_list>
ffffffffc020353a:	82f1                	srli	a3,a3,0x1c
ffffffffc020353c:	96be                	add	a3,a3,a5
ffffffffc020353e:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list) {
ffffffffc0203540:	a029                	j	ffffffffc020354a <find_proc+0x38>
            if (proc->pid == pid) {
ffffffffc0203542:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0203546:	00870c63          	beq	a4,s0,ffffffffc020355e <find_proc+0x4c>
    return listelm->next;
ffffffffc020354a:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list) {
ffffffffc020354c:	fef69be3          	bne	a3,a5,ffffffffc0203542 <find_proc+0x30>
}
ffffffffc0203550:	60a2                	ld	ra,8(sp)
ffffffffc0203552:	6402                	ld	s0,0(sp)
    return NULL;
ffffffffc0203554:	4501                	li	a0,0
}
ffffffffc0203556:	0141                	addi	sp,sp,16
ffffffffc0203558:	8082                	ret
    return NULL;
ffffffffc020355a:	4501                	li	a0,0
}
ffffffffc020355c:	8082                	ret
ffffffffc020355e:	60a2                	ld	ra,8(sp)
ffffffffc0203560:	6402                	ld	s0,0(sp)
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0203562:	f2878513          	addi	a0,a5,-216
}
ffffffffc0203566:	0141                	addi	sp,sp,16
ffffffffc0203568:	8082                	ret

ffffffffc020356a <do_fork>:
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc020356a:	7159                	addi	sp,sp,-112
ffffffffc020356c:	e0d2                	sd	s4,64(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc020356e:	00030a17          	auipc	s4,0x30
ffffffffc0203572:	75aa0a13          	addi	s4,s4,1882 # ffffffffc0233cc8 <nr_process>
ffffffffc0203576:	000a2703          	lw	a4,0(s4)
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
ffffffffc020357a:	f486                	sd	ra,104(sp)
ffffffffc020357c:	f0a2                	sd	s0,96(sp)
ffffffffc020357e:	eca6                	sd	s1,88(sp)
ffffffffc0203580:	e8ca                	sd	s2,80(sp)
ffffffffc0203582:	e4ce                	sd	s3,72(sp)
ffffffffc0203584:	fc56                	sd	s5,56(sp)
ffffffffc0203586:	f85a                	sd	s6,48(sp)
ffffffffc0203588:	f45e                	sd	s7,40(sp)
ffffffffc020358a:	f062                	sd	s8,32(sp)
ffffffffc020358c:	ec66                	sd	s9,24(sp)
ffffffffc020358e:	e86a                	sd	s10,16(sp)
ffffffffc0203590:	e46e                	sd	s11,8(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203592:	6785                	lui	a5,0x1
ffffffffc0203594:	2ef75c63          	bge	a4,a5,ffffffffc020388c <do_fork+0x322>
ffffffffc0203598:	89aa                	mv	s3,a0
ffffffffc020359a:	892e                	mv	s2,a1
ffffffffc020359c:	84b2                	mv	s1,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc020359e:	cd5ff0ef          	jal	ra,ffffffffc0203272 <alloc_proc>
ffffffffc02035a2:	842a                	mv	s0,a0
ffffffffc02035a4:	2c050163          	beqz	a0,ffffffffc0203866 <do_fork+0x2fc>
    proc->parent = current;
ffffffffc02035a8:	00030c17          	auipc	s8,0x30
ffffffffc02035ac:	708c0c13          	addi	s8,s8,1800 # ffffffffc0233cb0 <current>
ffffffffc02035b0:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);
ffffffffc02035b4:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_hello_out_size-0x87bc>
    proc->parent = current;
ffffffffc02035b8:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);
ffffffffc02035ba:	2e071963          	bnez	a4,ffffffffc02038ac <do_fork+0x342>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc02035be:	4509                	li	a0,2
ffffffffc02035c0:	f92fd0ef          	jal	ra,ffffffffc0200d52 <alloc_pages>
    if (page != NULL) {
ffffffffc02035c4:	28050e63          	beqz	a0,ffffffffc0203860 <do_fork+0x2f6>
    return page - pages + nbase;
ffffffffc02035c8:	00030a97          	auipc	s5,0x30
ffffffffc02035cc:	738a8a93          	addi	s5,s5,1848 # ffffffffc0233d00 <pages>
ffffffffc02035d0:	000ab683          	ld	a3,0(s5)
ffffffffc02035d4:	00003b17          	auipc	s6,0x3
ffffffffc02035d8:	4ccb0b13          	addi	s6,s6,1228 # ffffffffc0206aa0 <nbase>
ffffffffc02035dc:	000b3783          	ld	a5,0(s6)
ffffffffc02035e0:	40d506b3          	sub	a3,a0,a3
ffffffffc02035e4:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02035e6:	00030b97          	auipc	s7,0x30
ffffffffc02035ea:	6a2b8b93          	addi	s7,s7,1698 # ffffffffc0233c88 <npage>
    return page - pages + nbase;
ffffffffc02035ee:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02035f0:	000bb703          	ld	a4,0(s7)
ffffffffc02035f4:	00c69793          	slli	a5,a3,0xc
ffffffffc02035f8:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc02035fa:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02035fc:	28e7fc63          	bgeu	a5,a4,ffffffffc0203894 <do_fork+0x32a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc0203600:	000c3703          	ld	a4,0(s8)
ffffffffc0203604:	00030c97          	auipc	s9,0x30
ffffffffc0203608:	6ecc8c93          	addi	s9,s9,1772 # ffffffffc0233cf0 <va_pa_offset>
ffffffffc020360c:	000cb783          	ld	a5,0(s9)
ffffffffc0203610:	02873c03          	ld	s8,40(a4)
ffffffffc0203614:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203616:	e814                	sd	a3,16(s0)
    if (oldmm == NULL) {
ffffffffc0203618:	020c0863          	beqz	s8,ffffffffc0203648 <do_fork+0xde>
    if (clone_flags & CLONE_VM) {
ffffffffc020361c:	1009f993          	andi	s3,s3,256
ffffffffc0203620:	1a098e63          	beqz	s3,ffffffffc02037dc <do_fork+0x272>
}

static inline int
mm_count_inc(struct mm_struct *mm) {
    mm->mm_count += 1;
ffffffffc0203624:	030c2703          	lw	a4,48(s8)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc0203628:	018c3783          	ld	a5,24(s8)
ffffffffc020362c:	c02006b7          	lui	a3,0xc0200
ffffffffc0203630:	2705                	addiw	a4,a4,1
ffffffffc0203632:	02ec2823          	sw	a4,48(s8)
    proc->mm = mm;
ffffffffc0203636:	03843423          	sd	s8,40(s0)
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc020363a:	28d7e963          	bltu	a5,a3,ffffffffc02038cc <do_fork+0x362>
ffffffffc020363e:	000cb703          	ld	a4,0(s9)
ffffffffc0203642:	6814                	ld	a3,16(s0)
ffffffffc0203644:	8f99                	sub	a5,a5,a4
ffffffffc0203646:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203648:	6789                	lui	a5,0x2
ffffffffc020364a:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_hello_out_size-0x79c8>
ffffffffc020364e:	97b6                	add	a5,a5,a3
ffffffffc0203650:	f05c                	sd	a5,160(s0)
    *(proc->tf) = *tf;
ffffffffc0203652:	873e                	mv	a4,a5
ffffffffc0203654:	12048893          	addi	a7,s1,288
ffffffffc0203658:	0004b803          	ld	a6,0(s1)
ffffffffc020365c:	6488                	ld	a0,8(s1)
ffffffffc020365e:	688c                	ld	a1,16(s1)
ffffffffc0203660:	6c90                	ld	a2,24(s1)
ffffffffc0203662:	01073023          	sd	a6,0(a4)
ffffffffc0203666:	e708                	sd	a0,8(a4)
ffffffffc0203668:	eb0c                	sd	a1,16(a4)
ffffffffc020366a:	ef10                	sd	a2,24(a4)
ffffffffc020366c:	02048493          	addi	s1,s1,32
ffffffffc0203670:	02070713          	addi	a4,a4,32
ffffffffc0203674:	ff1492e3          	bne	s1,a7,ffffffffc0203658 <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc0203678:	0407b823          	sd	zero,80(a5)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc020367c:	12090a63          	beqz	s2,ffffffffc02037b0 <do_fork+0x246>
ffffffffc0203680:	0127b823          	sd	s2,16(a5)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203684:	00000717          	auipc	a4,0x0
ffffffffc0203688:	c7470713          	addi	a4,a4,-908 # ffffffffc02032f8 <forkret>
ffffffffc020368c:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc020368e:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203690:	100027f3          	csrr	a5,sstatus
ffffffffc0203694:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203696:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203698:	12079e63          	bnez	a5,ffffffffc02037d4 <do_fork+0x26a>
    if (++ last_pid >= MAX_PID) {
ffffffffc020369c:	00025597          	auipc	a1,0x25
ffffffffc02036a0:	1a458593          	addi	a1,a1,420 # ffffffffc0228840 <last_pid.1747>
ffffffffc02036a4:	419c                	lw	a5,0(a1)
ffffffffc02036a6:	6709                	lui	a4,0x2
ffffffffc02036a8:	0017851b          	addiw	a0,a5,1
ffffffffc02036ac:	c188                	sw	a0,0(a1)
ffffffffc02036ae:	08e55b63          	bge	a0,a4,ffffffffc0203744 <do_fork+0x1da>
    if (last_pid >= next_safe) {
ffffffffc02036b2:	00025897          	auipc	a7,0x25
ffffffffc02036b6:	19288893          	addi	a7,a7,402 # ffffffffc0228844 <next_safe.1746>
ffffffffc02036ba:	0008a783          	lw	a5,0(a7)
ffffffffc02036be:	00030497          	auipc	s1,0x30
ffffffffc02036c2:	74248493          	addi	s1,s1,1858 # ffffffffc0233e00 <proc_list>
ffffffffc02036c6:	08f55663          	bge	a0,a5,ffffffffc0203752 <do_fork+0x1e8>
        proc->pid = get_pid();
ffffffffc02036ca:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036cc:	45a9                	li	a1,10
ffffffffc02036ce:	2501                	sext.w	a0,a0
ffffffffc02036d0:	59a010ef          	jal	ra,ffffffffc0204c6a <hash32>
ffffffffc02036d4:	1502                	slli	a0,a0,0x20
ffffffffc02036d6:	0002c797          	auipc	a5,0x2c
ffffffffc02036da:	57278793          	addi	a5,a5,1394 # ffffffffc022fc48 <hash_list>
ffffffffc02036de:	8171                	srli	a0,a0,0x1c
ffffffffc02036e0:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc02036e2:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036e4:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02036e6:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc02036ea:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc02036ec:	6490                	ld	a2,8(s1)
    prev->next = next->prev = elm;
ffffffffc02036ee:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc02036f0:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc02036f2:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc02036f6:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc02036f8:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc02036fa:	e21c                	sd	a5,0(a2)
ffffffffc02036fc:	e49c                	sd	a5,8(s1)
    elm->next = next;
ffffffffc02036fe:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc0203700:	e464                	sd	s1,200(s0)
    proc->yptr = NULL;
ffffffffc0203702:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL) {
ffffffffc0203706:	10e43023          	sd	a4,256(s0)
ffffffffc020370a:	c311                	beqz	a4,ffffffffc020370e <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc020370c:	ff60                	sd	s0,248(a4)
    nr_process ++;
ffffffffc020370e:	000a2783          	lw	a5,0(s4)
    proc->parent->cptr = proc;
ffffffffc0203712:	fae0                	sd	s0,240(a3)
    nr_process ++;
ffffffffc0203714:	2785                	addiw	a5,a5,1
ffffffffc0203716:	00fa2023          	sw	a5,0(s4)
    if (flag) {
ffffffffc020371a:	14091863          	bnez	s2,ffffffffc020386a <do_fork+0x300>
    wakeup_proc(proc);
ffffffffc020371e:	8522                	mv	a0,s0
ffffffffc0203720:	5ad000ef          	jal	ra,ffffffffc02044cc <wakeup_proc>
    ret = proc->pid;
ffffffffc0203724:	4048                	lw	a0,4(s0)
}
ffffffffc0203726:	70a6                	ld	ra,104(sp)
ffffffffc0203728:	7406                	ld	s0,96(sp)
ffffffffc020372a:	64e6                	ld	s1,88(sp)
ffffffffc020372c:	6946                	ld	s2,80(sp)
ffffffffc020372e:	69a6                	ld	s3,72(sp)
ffffffffc0203730:	6a06                	ld	s4,64(sp)
ffffffffc0203732:	7ae2                	ld	s5,56(sp)
ffffffffc0203734:	7b42                	ld	s6,48(sp)
ffffffffc0203736:	7ba2                	ld	s7,40(sp)
ffffffffc0203738:	7c02                	ld	s8,32(sp)
ffffffffc020373a:	6ce2                	ld	s9,24(sp)
ffffffffc020373c:	6d42                	ld	s10,16(sp)
ffffffffc020373e:	6da2                	ld	s11,8(sp)
ffffffffc0203740:	6165                	addi	sp,sp,112
ffffffffc0203742:	8082                	ret
        last_pid = 1;
ffffffffc0203744:	4785                	li	a5,1
ffffffffc0203746:	c19c                	sw	a5,0(a1)
        goto inside;
ffffffffc0203748:	4505                	li	a0,1
ffffffffc020374a:	00025897          	auipc	a7,0x25
ffffffffc020374e:	0fa88893          	addi	a7,a7,250 # ffffffffc0228844 <next_safe.1746>
    return listelm->next;
ffffffffc0203752:	00030497          	auipc	s1,0x30
ffffffffc0203756:	6ae48493          	addi	s1,s1,1710 # ffffffffc0233e00 <proc_list>
ffffffffc020375a:	0084b303          	ld	t1,8(s1)
        next_safe = MAX_PID;
ffffffffc020375e:	6789                	lui	a5,0x2
ffffffffc0203760:	00f8a023          	sw	a5,0(a7)
ffffffffc0203764:	4801                	li	a6,0
ffffffffc0203766:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list) {
ffffffffc0203768:	6e89                	lui	t4,0x2
ffffffffc020376a:	10930c63          	beq	t1,s1,ffffffffc0203882 <do_fork+0x318>
ffffffffc020376e:	8e42                	mv	t3,a6
ffffffffc0203770:	869a                	mv	a3,t1
ffffffffc0203772:	6609                	lui	a2,0x2
ffffffffc0203774:	a811                	j	ffffffffc0203788 <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid) {
ffffffffc0203776:	00e7d663          	bge	a5,a4,ffffffffc0203782 <do_fork+0x218>
ffffffffc020377a:	00c75463          	bge	a4,a2,ffffffffc0203782 <do_fork+0x218>
ffffffffc020377e:	863a                	mv	a2,a4
ffffffffc0203780:	4e05                	li	t3,1
ffffffffc0203782:	6694                	ld	a3,8(a3)
        while ((le = list_next(le)) != list) {
ffffffffc0203784:	00968d63          	beq	a3,s1,ffffffffc020379e <do_fork+0x234>
            if (proc->pid == last_pid) {
ffffffffc0203788:	f3c6a703          	lw	a4,-196(a3) # ffffffffc01fff3c <_binary_obj___user_rr_out_size+0xffffffffc01f553c>
ffffffffc020378c:	fee795e3          	bne	a5,a4,ffffffffc0203776 <do_fork+0x20c>
                if (++ last_pid >= next_safe) {
ffffffffc0203790:	2785                	addiw	a5,a5,1
ffffffffc0203792:	0cc7df63          	bge	a5,a2,ffffffffc0203870 <do_fork+0x306>
ffffffffc0203796:	6694                	ld	a3,8(a3)
ffffffffc0203798:	4805                	li	a6,1
        while ((le = list_next(le)) != list) {
ffffffffc020379a:	fe9697e3          	bne	a3,s1,ffffffffc0203788 <do_fork+0x21e>
ffffffffc020379e:	00080463          	beqz	a6,ffffffffc02037a6 <do_fork+0x23c>
ffffffffc02037a2:	c19c                	sw	a5,0(a1)
ffffffffc02037a4:	853e                	mv	a0,a5
ffffffffc02037a6:	f20e02e3          	beqz	t3,ffffffffc02036ca <do_fork+0x160>
ffffffffc02037aa:	00c8a023          	sw	a2,0(a7)
ffffffffc02037ae:	bf31                	j	ffffffffc02036ca <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf - 4 : esp;
ffffffffc02037b0:	6909                	lui	s2,0x2
ffffffffc02037b2:	edc90913          	addi	s2,s2,-292 # 1edc <_binary_obj___user_hello_out_size-0x79cc>
ffffffffc02037b6:	9936                	add	s2,s2,a3
ffffffffc02037b8:	0127b823          	sd	s2,16(a5) # 2010 <_binary_obj___user_hello_out_size-0x7898>
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02037bc:	00000717          	auipc	a4,0x0
ffffffffc02037c0:	b3c70713          	addi	a4,a4,-1220 # ffffffffc02032f8 <forkret>
ffffffffc02037c4:	f818                	sd	a4,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02037c6:	fc1c                	sd	a5,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037c8:	100027f3          	csrr	a5,sstatus
ffffffffc02037cc:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02037ce:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02037d0:	ec0786e3          	beqz	a5,ffffffffc020369c <do_fork+0x132>
        intr_disable();
ffffffffc02037d4:	e5ffc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc02037d8:	4905                	li	s2,1
ffffffffc02037da:	b5c9                	j	ffffffffc020369c <do_fork+0x132>
    if ((mm = mm_create()) == NULL) {
ffffffffc02037dc:	b54fe0ef          	jal	ra,ffffffffc0201b30 <mm_create>
ffffffffc02037e0:	89aa                	mv	s3,a0
ffffffffc02037e2:	c539                	beqz	a0,ffffffffc0203830 <do_fork+0x2c6>
    if (setup_pgdir(mm) != 0) {
ffffffffc02037e4:	c17ff0ef          	jal	ra,ffffffffc02033fa <setup_pgdir>
ffffffffc02037e8:	e949                	bnez	a0,ffffffffc020387a <do_fork+0x310>
}

static inline void
lock_mm(struct mm_struct *mm) {
    if (mm != NULL) {
        lock(&(mm->mm_lock));
ffffffffc02037ea:	038c0d93          	addi	s11,s8,56
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02037ee:	4785                	li	a5,1
ffffffffc02037f0:	40fdb7af          	amoor.d	a5,a5,(s11)
    return !test_and_set_bit(0, lock);
}

static inline void
lock(lock_t *lock) {
    while (!try_lock(lock)) {
ffffffffc02037f4:	8b85                	andi	a5,a5,1
ffffffffc02037f6:	4d05                	li	s10,1
ffffffffc02037f8:	c799                	beqz	a5,ffffffffc0203806 <do_fork+0x29c>
        schedule();
ffffffffc02037fa:	585000ef          	jal	ra,ffffffffc020457e <schedule>
ffffffffc02037fe:	41adb7af          	amoor.d	a5,s10,(s11)
    while (!try_lock(lock)) {
ffffffffc0203802:	8b85                	andi	a5,a5,1
ffffffffc0203804:	fbfd                	bnez	a5,ffffffffc02037fa <do_fork+0x290>
        ret = dup_mmap(mm, oldmm);
ffffffffc0203806:	85e2                	mv	a1,s8
ffffffffc0203808:	854e                	mv	a0,s3
ffffffffc020380a:	d7efe0ef          	jal	ra,ffffffffc0201d88 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020380e:	57f9                	li	a5,-2
ffffffffc0203810:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc0203814:	8b85                	andi	a5,a5,1
    }
}

static inline void
unlock(lock_t *lock) {
    if (!test_and_clear_bit(0, lock)) {
ffffffffc0203816:	cbe1                	beqz	a5,ffffffffc02038e6 <do_fork+0x37c>
good_mm:
ffffffffc0203818:	8c4e                	mv	s8,s3
    if (ret != 0) {
ffffffffc020381a:	e00505e3          	beqz	a0,ffffffffc0203624 <do_fork+0xba>
    exit_mmap(mm);
ffffffffc020381e:	854e                	mv	a0,s3
ffffffffc0203820:	e02fe0ef          	jal	ra,ffffffffc0201e22 <exit_mmap>
    put_pgdir(mm);
ffffffffc0203824:	854e                	mv	a0,s3
ffffffffc0203826:	b5fff0ef          	jal	ra,ffffffffc0203384 <put_pgdir>
    mm_destroy(mm);
ffffffffc020382a:	854e                	mv	a0,s3
ffffffffc020382c:	c5cfe0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203830:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc0203832:	c02007b7          	lui	a5,0xc0200
ffffffffc0203836:	0ef6e063          	bltu	a3,a5,ffffffffc0203916 <do_fork+0x3ac>
ffffffffc020383a:	000cb783          	ld	a5,0(s9)
    if (PPN(pa) >= npage) {
ffffffffc020383e:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc0203842:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203846:	83b1                	srli	a5,a5,0xc
ffffffffc0203848:	0ae7fb63          	bgeu	a5,a4,ffffffffc02038fe <do_fork+0x394>
    return &pages[PPN(pa) - nbase];
ffffffffc020384c:	000b3703          	ld	a4,0(s6)
ffffffffc0203850:	000ab503          	ld	a0,0(s5)
ffffffffc0203854:	4589                	li	a1,2
ffffffffc0203856:	8f99                	sub	a5,a5,a4
ffffffffc0203858:	079a                	slli	a5,a5,0x6
ffffffffc020385a:	953e                	add	a0,a0,a5
ffffffffc020385c:	d88fd0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    kfree(proc);
ffffffffc0203860:	8522                	mv	a0,s0
ffffffffc0203862:	a81fe0ef          	jal	ra,ffffffffc02022e2 <kfree>
    ret = -E_NO_MEM;
ffffffffc0203866:	5571                	li	a0,-4
    return ret;
ffffffffc0203868:	bd7d                	j	ffffffffc0203726 <do_fork+0x1bc>
        intr_enable();
ffffffffc020386a:	dc3fc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc020386e:	bd45                	j	ffffffffc020371e <do_fork+0x1b4>
                    if (last_pid >= MAX_PID) {
ffffffffc0203870:	01d7c363          	blt	a5,t4,ffffffffc0203876 <do_fork+0x30c>
                        last_pid = 1;
ffffffffc0203874:	4785                	li	a5,1
                    goto repeat;
ffffffffc0203876:	4805                	li	a6,1
ffffffffc0203878:	bdcd                	j	ffffffffc020376a <do_fork+0x200>
    mm_destroy(mm);
ffffffffc020387a:	854e                	mv	a0,s3
ffffffffc020387c:	c0cfe0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
ffffffffc0203880:	bf45                	j	ffffffffc0203830 <do_fork+0x2c6>
ffffffffc0203882:	00080763          	beqz	a6,ffffffffc0203890 <do_fork+0x326>
ffffffffc0203886:	c19c                	sw	a5,0(a1)
ffffffffc0203888:	853e                	mv	a0,a5
ffffffffc020388a:	b581                	j	ffffffffc02036ca <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc020388c:	556d                	li	a0,-5
ffffffffc020388e:	bd61                	j	ffffffffc0203726 <do_fork+0x1bc>
ffffffffc0203890:	4188                	lw	a0,0(a1)
ffffffffc0203892:	bd25                	j	ffffffffc02036ca <do_fork+0x160>
    return KADDR(page2pa(page));
ffffffffc0203894:	00002617          	auipc	a2,0x2
ffffffffc0203898:	e4460613          	addi	a2,a2,-444 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc020389c:	06900593          	li	a1,105
ffffffffc02038a0:	00002517          	auipc	a0,0x2
ffffffffc02038a4:	d9850513          	addi	a0,a0,-616 # ffffffffc0205638 <commands+0x718>
ffffffffc02038a8:	95dfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(current->wait_state == 0);
ffffffffc02038ac:	00003697          	auipc	a3,0x3
ffffffffc02038b0:	8c468693          	addi	a3,a3,-1852 # ffffffffc0206170 <default_pmm_manager+0x108>
ffffffffc02038b4:	00002617          	auipc	a2,0x2
ffffffffc02038b8:	a7460613          	addi	a2,a2,-1420 # ffffffffc0205328 <commands+0x408>
ffffffffc02038bc:	17400593          	li	a1,372
ffffffffc02038c0:	00003517          	auipc	a0,0x3
ffffffffc02038c4:	89850513          	addi	a0,a0,-1896 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc02038c8:	93dfc0ef          	jal	ra,ffffffffc0200204 <__panic>
    proc->cr3 = PADDR(mm->pgdir);
ffffffffc02038cc:	86be                	mv	a3,a5
ffffffffc02038ce:	00002617          	auipc	a2,0x2
ffffffffc02038d2:	dd260613          	addi	a2,a2,-558 # ffffffffc02056a0 <commands+0x780>
ffffffffc02038d6:	14700593          	li	a1,327
ffffffffc02038da:	00003517          	auipc	a0,0x3
ffffffffc02038de:	87e50513          	addi	a0,a0,-1922 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc02038e2:	923fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("Unlock failed.\n");
ffffffffc02038e6:	00003617          	auipc	a2,0x3
ffffffffc02038ea:	8aa60613          	addi	a2,a2,-1878 # ffffffffc0206190 <default_pmm_manager+0x128>
ffffffffc02038ee:	03200593          	li	a1,50
ffffffffc02038f2:	00003517          	auipc	a0,0x3
ffffffffc02038f6:	8ae50513          	addi	a0,a0,-1874 # ffffffffc02061a0 <default_pmm_manager+0x138>
ffffffffc02038fa:	90bfc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02038fe:	00002617          	auipc	a2,0x2
ffffffffc0203902:	d1a60613          	addi	a2,a2,-742 # ffffffffc0205618 <commands+0x6f8>
ffffffffc0203906:	06200593          	li	a1,98
ffffffffc020390a:	00002517          	auipc	a0,0x2
ffffffffc020390e:	d2e50513          	addi	a0,a0,-722 # ffffffffc0205638 <commands+0x718>
ffffffffc0203912:	8f3fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203916:	00002617          	auipc	a2,0x2
ffffffffc020391a:	d8a60613          	addi	a2,a2,-630 # ffffffffc02056a0 <commands+0x780>
ffffffffc020391e:	06e00593          	li	a1,110
ffffffffc0203922:	00002517          	auipc	a0,0x2
ffffffffc0203926:	d1650513          	addi	a0,a0,-746 # ffffffffc0205638 <commands+0x718>
ffffffffc020392a:	8dbfc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020392e <kernel_thread>:
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc020392e:	7129                	addi	sp,sp,-320
ffffffffc0203930:	fa22                	sd	s0,304(sp)
ffffffffc0203932:	f626                	sd	s1,296(sp)
ffffffffc0203934:	f24a                	sd	s2,288(sp)
ffffffffc0203936:	84ae                	mv	s1,a1
ffffffffc0203938:	892a                	mv	s2,a0
ffffffffc020393a:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020393c:	4581                	li	a1,0
ffffffffc020393e:	12000613          	li	a2,288
ffffffffc0203942:	850a                	mv	a0,sp
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
ffffffffc0203944:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0203946:	70d000ef          	jal	ra,ffffffffc0204852 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc020394a:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc020394c:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc020394e:	100027f3          	csrr	a5,sstatus
ffffffffc0203952:	edd7f793          	andi	a5,a5,-291
ffffffffc0203956:	1207e793          	ori	a5,a5,288
ffffffffc020395a:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020395c:	860a                	mv	a2,sp
ffffffffc020395e:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0203962:	00000797          	auipc	a5,0x0
ffffffffc0203966:	89e78793          	addi	a5,a5,-1890 # ffffffffc0203200 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020396a:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020396c:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020396e:	bfdff0ef          	jal	ra,ffffffffc020356a <do_fork>
}
ffffffffc0203972:	70f2                	ld	ra,312(sp)
ffffffffc0203974:	7452                	ld	s0,304(sp)
ffffffffc0203976:	74b2                	ld	s1,296(sp)
ffffffffc0203978:	7912                	ld	s2,288(sp)
ffffffffc020397a:	6131                	addi	sp,sp,320
ffffffffc020397c:	8082                	ret

ffffffffc020397e <do_exit>:
do_exit(int error_code) {
ffffffffc020397e:	7179                	addi	sp,sp,-48
ffffffffc0203980:	f022                	sd	s0,32(sp)
    if (current == idleproc) {
ffffffffc0203982:	00030417          	auipc	s0,0x30
ffffffffc0203986:	32e40413          	addi	s0,s0,814 # ffffffffc0233cb0 <current>
ffffffffc020398a:	601c                	ld	a5,0(s0)
do_exit(int error_code) {
ffffffffc020398c:	f406                	sd	ra,40(sp)
ffffffffc020398e:	ec26                	sd	s1,24(sp)
ffffffffc0203990:	e84a                	sd	s2,16(sp)
ffffffffc0203992:	e44e                	sd	s3,8(sp)
ffffffffc0203994:	e052                	sd	s4,0(sp)
    if (current == idleproc) {
ffffffffc0203996:	00030717          	auipc	a4,0x30
ffffffffc020399a:	32273703          	ld	a4,802(a4) # ffffffffc0233cb8 <idleproc>
ffffffffc020399e:	0ce78c63          	beq	a5,a4,ffffffffc0203a76 <do_exit+0xf8>
    if (current == initproc) {
ffffffffc02039a2:	00030497          	auipc	s1,0x30
ffffffffc02039a6:	31e48493          	addi	s1,s1,798 # ffffffffc0233cc0 <initproc>
ffffffffc02039aa:	6098                	ld	a4,0(s1)
ffffffffc02039ac:	0ee78b63          	beq	a5,a4,ffffffffc0203aa2 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc02039b0:	0287b983          	ld	s3,40(a5)
ffffffffc02039b4:	892a                	mv	s2,a0
    if (mm != NULL) {
ffffffffc02039b6:	02098663          	beqz	s3,ffffffffc02039e2 <do_exit+0x64>
ffffffffc02039ba:	00030797          	auipc	a5,0x30
ffffffffc02039be:	33e7b783          	ld	a5,830(a5) # ffffffffc0233cf8 <boot_cr3>
ffffffffc02039c2:	577d                	li	a4,-1
ffffffffc02039c4:	177e                	slli	a4,a4,0x3f
ffffffffc02039c6:	83b1                	srli	a5,a5,0xc
ffffffffc02039c8:	8fd9                	or	a5,a5,a4
ffffffffc02039ca:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc02039ce:	0309a783          	lw	a5,48(s3)
ffffffffc02039d2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02039d6:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0) {
ffffffffc02039da:	cb55                	beqz	a4,ffffffffc0203a8e <do_exit+0x110>
        current->mm = NULL;
ffffffffc02039dc:	601c                	ld	a5,0(s0)
ffffffffc02039de:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc02039e2:	601c                	ld	a5,0(s0)
ffffffffc02039e4:	470d                	li	a4,3
ffffffffc02039e6:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc02039e8:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039ec:	100027f3          	csrr	a5,sstatus
ffffffffc02039f0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02039f2:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02039f4:	e3f9                	bnez	a5,ffffffffc0203aba <do_exit+0x13c>
        proc = current->parent;
ffffffffc02039f6:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD) {
ffffffffc02039f8:	800007b7          	lui	a5,0x80000
ffffffffc02039fc:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc02039fe:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD) {
ffffffffc0203a00:	0ec52703          	lw	a4,236(a0)
ffffffffc0203a04:	0af70f63          	beq	a4,a5,ffffffffc0203ac2 <do_exit+0x144>
        while (current->cptr != NULL) {
ffffffffc0203a08:	6018                	ld	a4,0(s0)
ffffffffc0203a0a:	7b7c                	ld	a5,240(a4)
ffffffffc0203a0c:	c3a1                	beqz	a5,ffffffffc0203a4c <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a0e:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a12:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a14:	0985                	addi	s3,s3,1
ffffffffc0203a16:	a021                	j	ffffffffc0203a1e <do_exit+0xa0>
        while (current->cptr != NULL) {
ffffffffc0203a18:	6018                	ld	a4,0(s0)
ffffffffc0203a1a:	7b7c                	ld	a5,240(a4)
ffffffffc0203a1c:	cb85                	beqz	a5,ffffffffc0203a4c <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0203a1e:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_rr_out_size+0xffffffff7fff5700>
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a22:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0203a24:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a26:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0203a28:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL) {
ffffffffc0203a2c:	10e7b023          	sd	a4,256(a5)
ffffffffc0203a30:	c311                	beqz	a4,ffffffffc0203a34 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0203a32:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a34:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0203a36:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0203a38:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203a3a:	fd271fe3          	bne	a4,s2,ffffffffc0203a18 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD) {
ffffffffc0203a3e:	0ec52783          	lw	a5,236(a0)
ffffffffc0203a42:	fd379be3          	bne	a5,s3,ffffffffc0203a18 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0203a46:	287000ef          	jal	ra,ffffffffc02044cc <wakeup_proc>
ffffffffc0203a4a:	b7f9                	j	ffffffffc0203a18 <do_exit+0x9a>
    if (flag) {
ffffffffc0203a4c:	020a1263          	bnez	s4,ffffffffc0203a70 <do_exit+0xf2>
    schedule();
ffffffffc0203a50:	32f000ef          	jal	ra,ffffffffc020457e <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0203a54:	601c                	ld	a5,0(s0)
ffffffffc0203a56:	00002617          	auipc	a2,0x2
ffffffffc0203a5a:	78260613          	addi	a2,a2,1922 # ffffffffc02061d8 <default_pmm_manager+0x170>
ffffffffc0203a5e:	1c700593          	li	a1,455
ffffffffc0203a62:	43d4                	lw	a3,4(a5)
ffffffffc0203a64:	00002517          	auipc	a0,0x2
ffffffffc0203a68:	6f450513          	addi	a0,a0,1780 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203a6c:	f98fc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_enable();
ffffffffc0203a70:	bbdfc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203a74:	bff1                	j	ffffffffc0203a50 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc0203a76:	00002617          	auipc	a2,0x2
ffffffffc0203a7a:	74260613          	addi	a2,a2,1858 # ffffffffc02061b8 <default_pmm_manager+0x150>
ffffffffc0203a7e:	19b00593          	li	a1,411
ffffffffc0203a82:	00002517          	auipc	a0,0x2
ffffffffc0203a86:	6d650513          	addi	a0,a0,1750 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203a8a:	f7afc0ef          	jal	ra,ffffffffc0200204 <__panic>
            exit_mmap(mm);
ffffffffc0203a8e:	854e                	mv	a0,s3
ffffffffc0203a90:	b92fe0ef          	jal	ra,ffffffffc0201e22 <exit_mmap>
            put_pgdir(mm);
ffffffffc0203a94:	854e                	mv	a0,s3
ffffffffc0203a96:	8efff0ef          	jal	ra,ffffffffc0203384 <put_pgdir>
            mm_destroy(mm);
ffffffffc0203a9a:	854e                	mv	a0,s3
ffffffffc0203a9c:	9ecfe0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
ffffffffc0203aa0:	bf35                	j	ffffffffc02039dc <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc0203aa2:	00002617          	auipc	a2,0x2
ffffffffc0203aa6:	72660613          	addi	a2,a2,1830 # ffffffffc02061c8 <default_pmm_manager+0x160>
ffffffffc0203aaa:	19e00593          	li	a1,414
ffffffffc0203aae:	00002517          	auipc	a0,0x2
ffffffffc0203ab2:	6aa50513          	addi	a0,a0,1706 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203ab6:	f4efc0ef          	jal	ra,ffffffffc0200204 <__panic>
        intr_disable();
ffffffffc0203aba:	b79fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203abe:	4a05                	li	s4,1
ffffffffc0203ac0:	bf1d                	j	ffffffffc02039f6 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc0203ac2:	20b000ef          	jal	ra,ffffffffc02044cc <wakeup_proc>
ffffffffc0203ac6:	b789                	j	ffffffffc0203a08 <do_exit+0x8a>

ffffffffc0203ac8 <do_wait.part.0>:
do_wait(int pid, int *code_store) {
ffffffffc0203ac8:	7139                	addi	sp,sp,-64
ffffffffc0203aca:	e852                	sd	s4,16(sp)
        current->wait_state = WT_CHILD;
ffffffffc0203acc:	80000a37          	lui	s4,0x80000
do_wait(int pid, int *code_store) {
ffffffffc0203ad0:	f426                	sd	s1,40(sp)
ffffffffc0203ad2:	f04a                	sd	s2,32(sp)
ffffffffc0203ad4:	ec4e                	sd	s3,24(sp)
ffffffffc0203ad6:	e456                	sd	s5,8(sp)
ffffffffc0203ad8:	e05a                	sd	s6,0(sp)
ffffffffc0203ada:	fc06                	sd	ra,56(sp)
ffffffffc0203adc:	f822                	sd	s0,48(sp)
ffffffffc0203ade:	892a                	mv	s2,a0
ffffffffc0203ae0:	8aae                	mv	s5,a1
        proc = current->cptr;
ffffffffc0203ae2:	00030997          	auipc	s3,0x30
ffffffffc0203ae6:	1ce98993          	addi	s3,s3,462 # ffffffffc0233cb0 <current>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203aea:	448d                	li	s1,3
        current->state = PROC_SLEEPING;
ffffffffc0203aec:	4b05                	li	s6,1
        current->wait_state = WT_CHILD;
ffffffffc0203aee:	2a05                	addiw	s4,s4,1
    if (pid != 0) {
ffffffffc0203af0:	02090f63          	beqz	s2,ffffffffc0203b2e <do_wait.part.0+0x66>
        proc = find_proc(pid);
ffffffffc0203af4:	854a                	mv	a0,s2
ffffffffc0203af6:	a1dff0ef          	jal	ra,ffffffffc0203512 <find_proc>
ffffffffc0203afa:	842a                	mv	s0,a0
        if (proc != NULL && proc->parent == current) {
ffffffffc0203afc:	10050763          	beqz	a0,ffffffffc0203c0a <do_wait.part.0+0x142>
ffffffffc0203b00:	0009b703          	ld	a4,0(s3)
ffffffffc0203b04:	711c                	ld	a5,32(a0)
ffffffffc0203b06:	10e79263          	bne	a5,a4,ffffffffc0203c0a <do_wait.part.0+0x142>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b0a:	411c                	lw	a5,0(a0)
ffffffffc0203b0c:	02978c63          	beq	a5,s1,ffffffffc0203b44 <do_wait.part.0+0x7c>
        current->state = PROC_SLEEPING;
ffffffffc0203b10:	01672023          	sw	s6,0(a4)
        current->wait_state = WT_CHILD;
ffffffffc0203b14:	0f472623          	sw	s4,236(a4)
        schedule();
ffffffffc0203b18:	267000ef          	jal	ra,ffffffffc020457e <schedule>
        if (current->flags & PF_EXITING) {
ffffffffc0203b1c:	0009b783          	ld	a5,0(s3)
ffffffffc0203b20:	0b07a783          	lw	a5,176(a5)
ffffffffc0203b24:	8b85                	andi	a5,a5,1
ffffffffc0203b26:	d7e9                	beqz	a5,ffffffffc0203af0 <do_wait.part.0+0x28>
            do_exit(-E_KILLED);
ffffffffc0203b28:	555d                	li	a0,-9
ffffffffc0203b2a:	e55ff0ef          	jal	ra,ffffffffc020397e <do_exit>
        proc = current->cptr;
ffffffffc0203b2e:	0009b703          	ld	a4,0(s3)
ffffffffc0203b32:	7b60                	ld	s0,240(a4)
        for (; proc != NULL; proc = proc->optr) {
ffffffffc0203b34:	e409                	bnez	s0,ffffffffc0203b3e <do_wait.part.0+0x76>
ffffffffc0203b36:	a8d1                	j	ffffffffc0203c0a <do_wait.part.0+0x142>
ffffffffc0203b38:	10043403          	ld	s0,256(s0)
ffffffffc0203b3c:	d871                	beqz	s0,ffffffffc0203b10 <do_wait.part.0+0x48>
            if (proc->state == PROC_ZOMBIE) {
ffffffffc0203b3e:	401c                	lw	a5,0(s0)
ffffffffc0203b40:	fe979ce3          	bne	a5,s1,ffffffffc0203b38 <do_wait.part.0+0x70>
    if (proc == idleproc || proc == initproc) {
ffffffffc0203b44:	00030797          	auipc	a5,0x30
ffffffffc0203b48:	1747b783          	ld	a5,372(a5) # ffffffffc0233cb8 <idleproc>
ffffffffc0203b4c:	0c878563          	beq	a5,s0,ffffffffc0203c16 <do_wait.part.0+0x14e>
ffffffffc0203b50:	00030797          	auipc	a5,0x30
ffffffffc0203b54:	1707b783          	ld	a5,368(a5) # ffffffffc0233cc0 <initproc>
ffffffffc0203b58:	0af40f63          	beq	s0,a5,ffffffffc0203c16 <do_wait.part.0+0x14e>
    if (code_store != NULL) {
ffffffffc0203b5c:	000a8663          	beqz	s5,ffffffffc0203b68 <do_wait.part.0+0xa0>
        *code_store = proc->exit_code;
ffffffffc0203b60:	0e842783          	lw	a5,232(s0)
ffffffffc0203b64:	00faa023          	sw	a5,0(s5)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b68:	100027f3          	csrr	a5,sstatus
ffffffffc0203b6c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203b6e:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0203b70:	efd9                	bnez	a5,ffffffffc0203c0e <do_wait.part.0+0x146>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b72:	6c70                	ld	a2,216(s0)
ffffffffc0203b74:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL) {
ffffffffc0203b76:	10043703          	ld	a4,256(s0)
ffffffffc0203b7a:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0203b7c:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b7e:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0203b80:	6470                	ld	a2,200(s0)
ffffffffc0203b82:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0203b84:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0203b86:	e290                	sd	a2,0(a3)
ffffffffc0203b88:	c319                	beqz	a4,ffffffffc0203b8e <do_wait.part.0+0xc6>
        proc->optr->yptr = proc->yptr;
ffffffffc0203b8a:	ff7c                	sd	a5,248(a4)
ffffffffc0203b8c:	7c7c                	ld	a5,248(s0)
    if (proc->yptr != NULL) {
ffffffffc0203b8e:	cbbd                	beqz	a5,ffffffffc0203c04 <do_wait.part.0+0x13c>
        proc->yptr->optr = proc->optr;
ffffffffc0203b90:	10e7b023          	sd	a4,256(a5)
    nr_process --;
ffffffffc0203b94:	00030717          	auipc	a4,0x30
ffffffffc0203b98:	13470713          	addi	a4,a4,308 # ffffffffc0233cc8 <nr_process>
ffffffffc0203b9c:	431c                	lw	a5,0(a4)
ffffffffc0203b9e:	37fd                	addiw	a5,a5,-1
ffffffffc0203ba0:	c31c                	sw	a5,0(a4)
    if (flag) {
ffffffffc0203ba2:	edb1                	bnez	a1,ffffffffc0203bfe <do_wait.part.0+0x136>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0203ba4:	6814                	ld	a3,16(s0)
ffffffffc0203ba6:	c02007b7          	lui	a5,0xc0200
ffffffffc0203baa:	08f6ee63          	bltu	a3,a5,ffffffffc0203c46 <do_wait.part.0+0x17e>
ffffffffc0203bae:	00030797          	auipc	a5,0x30
ffffffffc0203bb2:	1427b783          	ld	a5,322(a5) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0203bb6:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc0203bb8:	82b1                	srli	a3,a3,0xc
ffffffffc0203bba:	00030797          	auipc	a5,0x30
ffffffffc0203bbe:	0ce7b783          	ld	a5,206(a5) # ffffffffc0233c88 <npage>
ffffffffc0203bc2:	06f6f663          	bgeu	a3,a5,ffffffffc0203c2e <do_wait.part.0+0x166>
    return &pages[PPN(pa) - nbase];
ffffffffc0203bc6:	00003517          	auipc	a0,0x3
ffffffffc0203bca:	eda53503          	ld	a0,-294(a0) # ffffffffc0206aa0 <nbase>
ffffffffc0203bce:	8e89                	sub	a3,a3,a0
ffffffffc0203bd0:	069a                	slli	a3,a3,0x6
ffffffffc0203bd2:	00030517          	auipc	a0,0x30
ffffffffc0203bd6:	12e53503          	ld	a0,302(a0) # ffffffffc0233d00 <pages>
ffffffffc0203bda:	9536                	add	a0,a0,a3
ffffffffc0203bdc:	4589                	li	a1,2
ffffffffc0203bde:	a06fd0ef          	jal	ra,ffffffffc0200de4 <free_pages>
    kfree(proc);
ffffffffc0203be2:	8522                	mv	a0,s0
ffffffffc0203be4:	efefe0ef          	jal	ra,ffffffffc02022e2 <kfree>
    return 0;
ffffffffc0203be8:	4501                	li	a0,0
}
ffffffffc0203bea:	70e2                	ld	ra,56(sp)
ffffffffc0203bec:	7442                	ld	s0,48(sp)
ffffffffc0203bee:	74a2                	ld	s1,40(sp)
ffffffffc0203bf0:	7902                	ld	s2,32(sp)
ffffffffc0203bf2:	69e2                	ld	s3,24(sp)
ffffffffc0203bf4:	6a42                	ld	s4,16(sp)
ffffffffc0203bf6:	6aa2                	ld	s5,8(sp)
ffffffffc0203bf8:	6b02                	ld	s6,0(sp)
ffffffffc0203bfa:	6121                	addi	sp,sp,64
ffffffffc0203bfc:	8082                	ret
        intr_enable();
ffffffffc0203bfe:	a2ffc0ef          	jal	ra,ffffffffc020062c <intr_enable>
ffffffffc0203c02:	b74d                	j	ffffffffc0203ba4 <do_wait.part.0+0xdc>
       proc->parent->cptr = proc->optr;
ffffffffc0203c04:	701c                	ld	a5,32(s0)
ffffffffc0203c06:	fbf8                	sd	a4,240(a5)
ffffffffc0203c08:	b771                	j	ffffffffc0203b94 <do_wait.part.0+0xcc>
    return -E_BAD_PROC;
ffffffffc0203c0a:	5579                	li	a0,-2
ffffffffc0203c0c:	bff9                	j	ffffffffc0203bea <do_wait.part.0+0x122>
        intr_disable();
ffffffffc0203c0e:	a25fc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0203c12:	4585                	li	a1,1
ffffffffc0203c14:	bfb9                	j	ffffffffc0203b72 <do_wait.part.0+0xaa>
        panic("wait idleproc or initproc.\n");
ffffffffc0203c16:	00002617          	auipc	a2,0x2
ffffffffc0203c1a:	5e260613          	addi	a2,a2,1506 # ffffffffc02061f8 <default_pmm_manager+0x190>
ffffffffc0203c1e:	2b600593          	li	a1,694
ffffffffc0203c22:	00002517          	auipc	a0,0x2
ffffffffc0203c26:	53650513          	addi	a0,a0,1334 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203c2a:	ddafc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203c2e:	00002617          	auipc	a2,0x2
ffffffffc0203c32:	9ea60613          	addi	a2,a2,-1558 # ffffffffc0205618 <commands+0x6f8>
ffffffffc0203c36:	06200593          	li	a1,98
ffffffffc0203c3a:	00002517          	auipc	a0,0x2
ffffffffc0203c3e:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0205638 <commands+0x718>
ffffffffc0203c42:	dc2fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0203c46:	00002617          	auipc	a2,0x2
ffffffffc0203c4a:	a5a60613          	addi	a2,a2,-1446 # ffffffffc02056a0 <commands+0x780>
ffffffffc0203c4e:	06e00593          	li	a1,110
ffffffffc0203c52:	00002517          	auipc	a0,0x2
ffffffffc0203c56:	9e650513          	addi	a0,a0,-1562 # ffffffffc0205638 <commands+0x718>
ffffffffc0203c5a:	daafc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203c5e <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
ffffffffc0203c5e:	1141                	addi	sp,sp,-16
ffffffffc0203c60:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc0203c62:	9c4fd0ef          	jal	ra,ffffffffc0200e26 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc0203c66:	dc8fe0ef          	jal	ra,ffffffffc020222e <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0203c6a:	4601                	li	a2,0
ffffffffc0203c6c:	4581                	li	a1,0
ffffffffc0203c6e:	fffff517          	auipc	a0,0xfffff
ffffffffc0203c72:	69850513          	addi	a0,a0,1688 # ffffffffc0203306 <user_main>
ffffffffc0203c76:	cb9ff0ef          	jal	ra,ffffffffc020392e <kernel_thread>
    if (pid <= 0) {
ffffffffc0203c7a:	00a04563          	bgtz	a0,ffffffffc0203c84 <init_main+0x26>
ffffffffc0203c7e:	a071                	j	ffffffffc0203d0a <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0) {
        schedule();
ffffffffc0203c80:	0ff000ef          	jal	ra,ffffffffc020457e <schedule>
    if (code_store != NULL) {
ffffffffc0203c84:	4581                	li	a1,0
ffffffffc0203c86:	4501                	li	a0,0
ffffffffc0203c88:	e41ff0ef          	jal	ra,ffffffffc0203ac8 <do_wait.part.0>
    while (do_wait(0, NULL) == 0) {
ffffffffc0203c8c:	d975                	beqz	a0,ffffffffc0203c80 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0203c8e:	00002517          	auipc	a0,0x2
ffffffffc0203c92:	5aa50513          	addi	a0,a0,1450 # ffffffffc0206238 <default_pmm_manager+0x1d0>
ffffffffc0203c96:	c32fc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203c9a:	00030797          	auipc	a5,0x30
ffffffffc0203c9e:	0267b783          	ld	a5,38(a5) # ffffffffc0233cc0 <initproc>
ffffffffc0203ca2:	7bf8                	ld	a4,240(a5)
ffffffffc0203ca4:	e339                	bnez	a4,ffffffffc0203cea <init_main+0x8c>
ffffffffc0203ca6:	7ff8                	ld	a4,248(a5)
ffffffffc0203ca8:	e329                	bnez	a4,ffffffffc0203cea <init_main+0x8c>
ffffffffc0203caa:	1007b703          	ld	a4,256(a5)
ffffffffc0203cae:	ef15                	bnez	a4,ffffffffc0203cea <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0203cb0:	00030697          	auipc	a3,0x30
ffffffffc0203cb4:	0186a683          	lw	a3,24(a3) # ffffffffc0233cc8 <nr_process>
ffffffffc0203cb8:	4709                	li	a4,2
ffffffffc0203cba:	0ae69463          	bne	a3,a4,ffffffffc0203d62 <init_main+0x104>
    return listelm->next;
ffffffffc0203cbe:	00030697          	auipc	a3,0x30
ffffffffc0203cc2:	14268693          	addi	a3,a3,322 # ffffffffc0233e00 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203cc6:	6698                	ld	a4,8(a3)
ffffffffc0203cc8:	0c878793          	addi	a5,a5,200
ffffffffc0203ccc:	06f71b63          	bne	a4,a5,ffffffffc0203d42 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203cd0:	629c                	ld	a5,0(a3)
ffffffffc0203cd2:	04f71863          	bne	a4,a5,ffffffffc0203d22 <init_main+0xc4>

    //cprintf("init check memory pass.\n");
    cprintf("The end of init_main\n");
ffffffffc0203cd6:	00002517          	auipc	a0,0x2
ffffffffc0203cda:	64a50513          	addi	a0,a0,1610 # ffffffffc0206320 <default_pmm_manager+0x2b8>
ffffffffc0203cde:	beafc0ef          	jal	ra,ffffffffc02000c8 <cprintf>
    return 0;
}
ffffffffc0203ce2:	60a2                	ld	ra,8(sp)
ffffffffc0203ce4:	4501                	li	a0,0
ffffffffc0203ce6:	0141                	addi	sp,sp,16
ffffffffc0203ce8:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0203cea:	00002697          	auipc	a3,0x2
ffffffffc0203cee:	57668693          	addi	a3,a3,1398 # ffffffffc0206260 <default_pmm_manager+0x1f8>
ffffffffc0203cf2:	00001617          	auipc	a2,0x1
ffffffffc0203cf6:	63660613          	addi	a2,a2,1590 # ffffffffc0205328 <commands+0x408>
ffffffffc0203cfa:	31a00593          	li	a1,794
ffffffffc0203cfe:	00002517          	auipc	a0,0x2
ffffffffc0203d02:	45a50513          	addi	a0,a0,1114 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203d06:	cfefc0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create user_main failed.\n");
ffffffffc0203d0a:	00002617          	auipc	a2,0x2
ffffffffc0203d0e:	50e60613          	addi	a2,a2,1294 # ffffffffc0206218 <default_pmm_manager+0x1b0>
ffffffffc0203d12:	31200593          	li	a1,786
ffffffffc0203d16:	00002517          	auipc	a0,0x2
ffffffffc0203d1a:	44250513          	addi	a0,a0,1090 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203d1e:	ce6fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0203d22:	00002697          	auipc	a3,0x2
ffffffffc0203d26:	5ce68693          	addi	a3,a3,1486 # ffffffffc02062f0 <default_pmm_manager+0x288>
ffffffffc0203d2a:	00001617          	auipc	a2,0x1
ffffffffc0203d2e:	5fe60613          	addi	a2,a2,1534 # ffffffffc0205328 <commands+0x408>
ffffffffc0203d32:	31d00593          	li	a1,797
ffffffffc0203d36:	00002517          	auipc	a0,0x2
ffffffffc0203d3a:	42250513          	addi	a0,a0,1058 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203d3e:	cc6fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0203d42:	00002697          	auipc	a3,0x2
ffffffffc0203d46:	57e68693          	addi	a3,a3,1406 # ffffffffc02062c0 <default_pmm_manager+0x258>
ffffffffc0203d4a:	00001617          	auipc	a2,0x1
ffffffffc0203d4e:	5de60613          	addi	a2,a2,1502 # ffffffffc0205328 <commands+0x408>
ffffffffc0203d52:	31c00593          	li	a1,796
ffffffffc0203d56:	00002517          	auipc	a0,0x2
ffffffffc0203d5a:	40250513          	addi	a0,a0,1026 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203d5e:	ca6fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(nr_process == 2);
ffffffffc0203d62:	00002697          	auipc	a3,0x2
ffffffffc0203d66:	54e68693          	addi	a3,a3,1358 # ffffffffc02062b0 <default_pmm_manager+0x248>
ffffffffc0203d6a:	00001617          	auipc	a2,0x1
ffffffffc0203d6e:	5be60613          	addi	a2,a2,1470 # ffffffffc0205328 <commands+0x408>
ffffffffc0203d72:	31b00593          	li	a1,795
ffffffffc0203d76:	00002517          	auipc	a0,0x2
ffffffffc0203d7a:	3e250513          	addi	a0,a0,994 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203d7e:	c86fc0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0203d82 <do_execve>:
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d82:	7135                	addi	sp,sp,-160
ffffffffc0203d84:	f4d6                	sd	s5,104(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d86:	00030a97          	auipc	s5,0x30
ffffffffc0203d8a:	f2aa8a93          	addi	s5,s5,-214 # ffffffffc0233cb0 <current>
ffffffffc0203d8e:	000ab783          	ld	a5,0(s5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d92:	f8d2                	sd	s4,112(sp)
ffffffffc0203d94:	e526                	sd	s1,136(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0203d96:	0287ba03          	ld	s4,40(a5)
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203d9a:	e14a                	sd	s2,128(sp)
ffffffffc0203d9c:	fcce                	sd	s3,120(sp)
ffffffffc0203d9e:	892a                	mv	s2,a0
ffffffffc0203da0:	84ae                	mv	s1,a1
ffffffffc0203da2:	89b2                	mv	s3,a2
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203da4:	4681                	li	a3,0
ffffffffc0203da6:	862e                	mv	a2,a1
ffffffffc0203da8:	85aa                	mv	a1,a0
ffffffffc0203daa:	8552                	mv	a0,s4
do_execve(const char *name, size_t len, unsigned char *binary, size_t size) {
ffffffffc0203dac:	ed06                	sd	ra,152(sp)
ffffffffc0203dae:	e922                	sd	s0,144(sp)
ffffffffc0203db0:	f0da                	sd	s6,96(sp)
ffffffffc0203db2:	ecde                	sd	s7,88(sp)
ffffffffc0203db4:	e8e2                	sd	s8,80(sp)
ffffffffc0203db6:	e4e6                	sd	s9,72(sp)
ffffffffc0203db8:	e0ea                	sd	s10,64(sp)
ffffffffc0203dba:	fc6e                	sd	s11,56(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) {
ffffffffc0203dbc:	9e0fe0ef          	jal	ra,ffffffffc0201f9c <user_mem_check>
ffffffffc0203dc0:	3e050763          	beqz	a0,ffffffffc02041ae <do_execve+0x42c>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0203dc4:	4641                	li	a2,16
ffffffffc0203dc6:	4581                	li	a1,0
ffffffffc0203dc8:	1008                	addi	a0,sp,32
ffffffffc0203dca:	289000ef          	jal	ra,ffffffffc0204852 <memset>
    memcpy(local_name, name, len);
ffffffffc0203dce:	47bd                	li	a5,15
ffffffffc0203dd0:	8626                	mv	a2,s1
ffffffffc0203dd2:	0697ed63          	bltu	a5,s1,ffffffffc0203e4c <do_execve+0xca>
ffffffffc0203dd6:	85ca                	mv	a1,s2
ffffffffc0203dd8:	1008                	addi	a0,sp,32
ffffffffc0203dda:	28b000ef          	jal	ra,ffffffffc0204864 <memcpy>
    if (mm != NULL) {
ffffffffc0203dde:	060a0e63          	beqz	s4,ffffffffc0203e5a <do_execve+0xd8>
        cputs("mm != NULL");
ffffffffc0203de2:	00002517          	auipc	a0,0x2
ffffffffc0203de6:	c5e50513          	addi	a0,a0,-930 # ffffffffc0205a40 <commands+0xb20>
ffffffffc0203dea:	b16fc0ef          	jal	ra,ffffffffc0200100 <cputs>
ffffffffc0203dee:	00030797          	auipc	a5,0x30
ffffffffc0203df2:	f0a7b783          	ld	a5,-246(a5) # ffffffffc0233cf8 <boot_cr3>
ffffffffc0203df6:	577d                	li	a4,-1
ffffffffc0203df8:	177e                	slli	a4,a4,0x3f
ffffffffc0203dfa:	83b1                	srli	a5,a5,0xc
ffffffffc0203dfc:	8fd9                	or	a5,a5,a4
ffffffffc0203dfe:	18079073          	csrw	satp,a5
ffffffffc0203e02:	030a2783          	lw	a5,48(s4) # ffffffff80000030 <_binary_obj___user_rr_out_size+0xffffffff7fff5630>
ffffffffc0203e06:	fff7871b          	addiw	a4,a5,-1
ffffffffc0203e0a:	02ea2823          	sw	a4,48(s4)
        if (mm_count_dec(mm) == 0) {
ffffffffc0203e0e:	28070663          	beqz	a4,ffffffffc020409a <do_execve+0x318>
        current->mm = NULL;
ffffffffc0203e12:	000ab783          	ld	a5,0(s5)
ffffffffc0203e16:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL) {
ffffffffc0203e1a:	d17fd0ef          	jal	ra,ffffffffc0201b30 <mm_create>
ffffffffc0203e1e:	84aa                	mv	s1,a0
ffffffffc0203e20:	c135                	beqz	a0,ffffffffc0203e84 <do_execve+0x102>
    if (setup_pgdir(mm) != 0) {
ffffffffc0203e22:	dd8ff0ef          	jal	ra,ffffffffc02033fa <setup_pgdir>
ffffffffc0203e26:	e931                	bnez	a0,ffffffffc0203e7a <do_execve+0xf8>
    if (elf->e_magic != ELF_MAGIC) {
ffffffffc0203e28:	0009a703          	lw	a4,0(s3)
ffffffffc0203e2c:	464c47b7          	lui	a5,0x464c4
ffffffffc0203e30:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_rr_out_size+0x464b9b7f>
ffffffffc0203e34:	04f70a63          	beq	a4,a5,ffffffffc0203e88 <do_execve+0x106>
    put_pgdir(mm);
ffffffffc0203e38:	8526                	mv	a0,s1
ffffffffc0203e3a:	d4aff0ef          	jal	ra,ffffffffc0203384 <put_pgdir>
    mm_destroy(mm);
ffffffffc0203e3e:	8526                	mv	a0,s1
ffffffffc0203e40:	e49fd0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0203e44:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0203e46:	8552                	mv	a0,s4
ffffffffc0203e48:	b37ff0ef          	jal	ra,ffffffffc020397e <do_exit>
    memcpy(local_name, name, len);
ffffffffc0203e4c:	463d                	li	a2,15
ffffffffc0203e4e:	85ca                	mv	a1,s2
ffffffffc0203e50:	1008                	addi	a0,sp,32
ffffffffc0203e52:	213000ef          	jal	ra,ffffffffc0204864 <memcpy>
    if (mm != NULL) {
ffffffffc0203e56:	f80a16e3          	bnez	s4,ffffffffc0203de2 <do_execve+0x60>
    if (current->mm != NULL) {
ffffffffc0203e5a:	000ab783          	ld	a5,0(s5)
ffffffffc0203e5e:	779c                	ld	a5,40(a5)
ffffffffc0203e60:	dfcd                	beqz	a5,ffffffffc0203e1a <do_execve+0x98>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0203e62:	00002617          	auipc	a2,0x2
ffffffffc0203e66:	4d660613          	addi	a2,a2,1238 # ffffffffc0206338 <default_pmm_manager+0x2d0>
ffffffffc0203e6a:	1d100593          	li	a1,465
ffffffffc0203e6e:	00002517          	auipc	a0,0x2
ffffffffc0203e72:	2ea50513          	addi	a0,a0,746 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0203e76:	b8efc0ef          	jal	ra,ffffffffc0200204 <__panic>
    mm_destroy(mm);
ffffffffc0203e7a:	8526                	mv	a0,s1
ffffffffc0203e7c:	e0dfd0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0203e80:	5a71                	li	s4,-4
ffffffffc0203e82:	b7d1                	j	ffffffffc0203e46 <do_execve+0xc4>
ffffffffc0203e84:	5a71                	li	s4,-4
ffffffffc0203e86:	b7c1                	j	ffffffffc0203e46 <do_execve+0xc4>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e88:	0389d703          	lhu	a4,56(s3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e8c:	0209b903          	ld	s2,32(s3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e90:	00371793          	slli	a5,a4,0x3
ffffffffc0203e94:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0203e96:	994e                	add	s2,s2,s3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0203e98:	078e                	slli	a5,a5,0x3
ffffffffc0203e9a:	97ca                	add	a5,a5,s2
ffffffffc0203e9c:	ec3e                	sd	a5,24(sp)
    for (; ph < ph_end; ph ++) {
ffffffffc0203e9e:	02f97c63          	bgeu	s2,a5,ffffffffc0203ed6 <do_execve+0x154>
    return KADDR(page2pa(page));
ffffffffc0203ea2:	5bfd                	li	s7,-1
ffffffffc0203ea4:	00cbd793          	srli	a5,s7,0xc
    return page - pages + nbase;
ffffffffc0203ea8:	00030d97          	auipc	s11,0x30
ffffffffc0203eac:	e58d8d93          	addi	s11,s11,-424 # ffffffffc0233d00 <pages>
ffffffffc0203eb0:	00003d17          	auipc	s10,0x3
ffffffffc0203eb4:	bf0d0d13          	addi	s10,s10,-1040 # ffffffffc0206aa0 <nbase>
    return KADDR(page2pa(page));
ffffffffc0203eb8:	e43e                	sd	a5,8(sp)
ffffffffc0203eba:	00030c97          	auipc	s9,0x30
ffffffffc0203ebe:	dcec8c93          	addi	s9,s9,-562 # ffffffffc0233c88 <npage>
        if (ph->p_type != ELF_PT_LOAD) {
ffffffffc0203ec2:	00092703          	lw	a4,0(s2)
ffffffffc0203ec6:	4785                	li	a5,1
ffffffffc0203ec8:	0ef70463          	beq	a4,a5,ffffffffc0203fb0 <do_execve+0x22e>
    for (; ph < ph_end; ph ++) {
ffffffffc0203ecc:	67e2                	ld	a5,24(sp)
ffffffffc0203ece:	03890913          	addi	s2,s2,56
ffffffffc0203ed2:	fef968e3          	bltu	s2,a5,ffffffffc0203ec2 <do_execve+0x140>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0) {
ffffffffc0203ed6:	4701                	li	a4,0
ffffffffc0203ed8:	46ad                	li	a3,11
ffffffffc0203eda:	00100637          	lui	a2,0x100
ffffffffc0203ede:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0203ee2:	8526                	mv	a0,s1
ffffffffc0203ee4:	df5fd0ef          	jal	ra,ffffffffc0201cd8 <mm_map>
ffffffffc0203ee8:	8a2a                	mv	s4,a0
ffffffffc0203eea:	18051e63          	bnez	a0,ffffffffc0204086 <do_execve+0x304>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc0203eee:	6c88                	ld	a0,24(s1)
ffffffffc0203ef0:	467d                	li	a2,31
ffffffffc0203ef2:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0203ef6:	f9afd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203efa:	34050863          	beqz	a0,ffffffffc020424a <do_execve+0x4c8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc0203efe:	6c88                	ld	a0,24(s1)
ffffffffc0203f00:	467d                	li	a2,31
ffffffffc0203f02:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0203f06:	f8afd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f0a:	32050063          	beqz	a0,ffffffffc020422a <do_execve+0x4a8>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f0e:	6c88                	ld	a0,24(s1)
ffffffffc0203f10:	467d                	li	a2,31
ffffffffc0203f12:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0203f16:	f7afd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f1a:	2e050863          	beqz	a0,ffffffffc020420a <do_execve+0x488>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc0203f1e:	6c88                	ld	a0,24(s1)
ffffffffc0203f20:	467d                	li	a2,31
ffffffffc0203f22:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0203f26:	f6afd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0203f2a:	2c050063          	beqz	a0,ffffffffc02041ea <do_execve+0x468>
    mm->mm_count += 1;
ffffffffc0203f2e:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f30:	000ab603          	ld	a2,0(s5)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f34:	6c94                	ld	a3,24(s1)
ffffffffc0203f36:	2785                	addiw	a5,a5,1
ffffffffc0203f38:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc0203f3a:	f604                	sd	s1,40(a2)
    current->cr3 = PADDR(mm->pgdir);
ffffffffc0203f3c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203f40:	28f6e963          	bltu	a3,a5,ffffffffc02041d2 <do_execve+0x450>
ffffffffc0203f44:	00030797          	auipc	a5,0x30
ffffffffc0203f48:	dac7b783          	ld	a5,-596(a5) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0203f4c:	8e9d                	sub	a3,a3,a5
ffffffffc0203f4e:	577d                	li	a4,-1
ffffffffc0203f50:	00c6d793          	srli	a5,a3,0xc
ffffffffc0203f54:	177e                	slli	a4,a4,0x3f
ffffffffc0203f56:	f654                	sd	a3,168(a2)
ffffffffc0203f58:	8fd9                	or	a5,a5,a4
ffffffffc0203f5a:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc0203f5e:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f60:	4581                	li	a1,0
ffffffffc0203f62:	12000613          	li	a2,288
ffffffffc0203f66:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc0203f68:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc0203f6c:	0e7000ef          	jal	ra,ffffffffc0204852 <memset>
    tf->epc = elf->e_entry;
ffffffffc0203f70:	0189b703          	ld	a4,24(s3)
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f74:	4785                	li	a5,1
    set_proc_name(current, local_name);
ffffffffc0203f76:	000ab503          	ld	a0,0(s5)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f7a:	edf4f493          	andi	s1,s1,-289
    tf->gpr.sp = USTACKTOP;
ffffffffc0203f7e:	07fe                	slli	a5,a5,0x1f
ffffffffc0203f80:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc0203f82:	10e43423          	sd	a4,264(s0)
    tf->status = sstatus & ~(SSTATUS_SPP | SSTATUS_SPIE);
ffffffffc0203f86:	10943023          	sd	s1,256(s0)
    set_proc_name(current, local_name);
ffffffffc0203f8a:	100c                	addi	a1,sp,32
ffffffffc0203f8c:	cf0ff0ef          	jal	ra,ffffffffc020347c <set_proc_name>
}
ffffffffc0203f90:	60ea                	ld	ra,152(sp)
ffffffffc0203f92:	644a                	ld	s0,144(sp)
ffffffffc0203f94:	64aa                	ld	s1,136(sp)
ffffffffc0203f96:	690a                	ld	s2,128(sp)
ffffffffc0203f98:	79e6                	ld	s3,120(sp)
ffffffffc0203f9a:	7aa6                	ld	s5,104(sp)
ffffffffc0203f9c:	7b06                	ld	s6,96(sp)
ffffffffc0203f9e:	6be6                	ld	s7,88(sp)
ffffffffc0203fa0:	6c46                	ld	s8,80(sp)
ffffffffc0203fa2:	6ca6                	ld	s9,72(sp)
ffffffffc0203fa4:	6d06                	ld	s10,64(sp)
ffffffffc0203fa6:	7de2                	ld	s11,56(sp)
ffffffffc0203fa8:	8552                	mv	a0,s4
ffffffffc0203faa:	7a46                	ld	s4,112(sp)
ffffffffc0203fac:	610d                	addi	sp,sp,160
ffffffffc0203fae:	8082                	ret
        if (ph->p_filesz > ph->p_memsz) {
ffffffffc0203fb0:	02893603          	ld	a2,40(s2)
ffffffffc0203fb4:	02093783          	ld	a5,32(s2)
ffffffffc0203fb8:	1ef66f63          	bltu	a2,a5,ffffffffc02041b6 <do_execve+0x434>
        if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
ffffffffc0203fbc:	00492783          	lw	a5,4(s2)
ffffffffc0203fc0:	0017f693          	andi	a3,a5,1
ffffffffc0203fc4:	c291                	beqz	a3,ffffffffc0203fc8 <do_execve+0x246>
ffffffffc0203fc6:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fc8:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fcc:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc0203fce:	0e071063          	bnez	a4,ffffffffc02040ae <do_execve+0x32c>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0203fd2:	4745                	li	a4,17
ffffffffc0203fd4:	e03a                	sd	a4,0(sp)
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fd6:	c789                	beqz	a5,ffffffffc0203fe0 <do_execve+0x25e>
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fd8:	47cd                	li	a5,19
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc0203fda:	0016e693          	ori	a3,a3,1
        if (vm_flags & VM_READ) perm |= PTE_R;
ffffffffc0203fde:	e03e                	sd	a5,0(sp)
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc0203fe0:	0026f793          	andi	a5,a3,2
ffffffffc0203fe4:	ebe1                	bnez	a5,ffffffffc02040b4 <do_execve+0x332>
        if (vm_flags & VM_EXEC) perm |= PTE_X;
ffffffffc0203fe6:	0046f793          	andi	a5,a3,4
ffffffffc0203fea:	c789                	beqz	a5,ffffffffc0203ff4 <do_execve+0x272>
ffffffffc0203fec:	6782                	ld	a5,0(sp)
ffffffffc0203fee:	0087e793          	ori	a5,a5,8
ffffffffc0203ff2:	e03e                	sd	a5,0(sp)
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
ffffffffc0203ff4:	01093583          	ld	a1,16(s2)
ffffffffc0203ff8:	4701                	li	a4,0
ffffffffc0203ffa:	8526                	mv	a0,s1
ffffffffc0203ffc:	cddfd0ef          	jal	ra,ffffffffc0201cd8 <mm_map>
ffffffffc0204000:	8a2a                	mv	s4,a0
ffffffffc0204002:	e151                	bnez	a0,ffffffffc0204086 <do_execve+0x304>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204004:	01093c03          	ld	s8,16(s2)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204008:	02093a03          	ld	s4,32(s2)
        unsigned char *from = binary + ph->p_offset;
ffffffffc020400c:	00893b03          	ld	s6,8(s2)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204010:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204012:	9a62                	add	s4,s4,s8
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204014:	9b4e                	add	s6,s6,s3
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204016:	00fc7bb3          	and	s7,s8,a5
        while (start < end) {
ffffffffc020401a:	054c6e63          	bltu	s8,s4,ffffffffc0204076 <do_execve+0x2f4>
ffffffffc020401e:	aa51                	j	ffffffffc02041b2 <do_execve+0x430>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204020:	6785                	lui	a5,0x1
ffffffffc0204022:	417c0533          	sub	a0,s8,s7
ffffffffc0204026:	9bbe                	add	s7,s7,a5
ffffffffc0204028:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc020402c:	017a7463          	bgeu	s4,s7,ffffffffc0204034 <do_execve+0x2b2>
                size -= la - end;
ffffffffc0204030:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204034:	000db683          	ld	a3,0(s11)
ffffffffc0204038:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc020403c:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc020403e:	40d406b3          	sub	a3,s0,a3
ffffffffc0204042:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204044:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204048:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc020404a:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc020404e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204050:	16b87563          	bgeu	a6,a1,ffffffffc02041ba <do_execve+0x438>
ffffffffc0204054:	00030797          	auipc	a5,0x30
ffffffffc0204058:	c9c78793          	addi	a5,a5,-868 # ffffffffc0233cf0 <va_pa_offset>
ffffffffc020405c:	0007b803          	ld	a6,0(a5)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204060:	85da                	mv	a1,s6
            start += size, from += size;
ffffffffc0204062:	9c32                	add	s8,s8,a2
ffffffffc0204064:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204066:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204068:	e832                	sd	a2,16(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc020406a:	7fa000ef          	jal	ra,ffffffffc0204864 <memcpy>
            start += size, from += size;
ffffffffc020406e:	6642                	ld	a2,16(sp)
ffffffffc0204070:	9b32                	add	s6,s6,a2
        while (start < end) {
ffffffffc0204072:	054c7463          	bgeu	s8,s4,ffffffffc02040ba <do_execve+0x338>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204076:	6c88                	ld	a0,24(s1)
ffffffffc0204078:	6602                	ld	a2,0(sp)
ffffffffc020407a:	85de                	mv	a1,s7
ffffffffc020407c:	e14fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc0204080:	842a                	mv	s0,a0
ffffffffc0204082:	fd59                	bnez	a0,ffffffffc0204020 <do_execve+0x29e>
        ret = -E_NO_MEM;
ffffffffc0204084:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204086:	8526                	mv	a0,s1
ffffffffc0204088:	d9bfd0ef          	jal	ra,ffffffffc0201e22 <exit_mmap>
    put_pgdir(mm);
ffffffffc020408c:	8526                	mv	a0,s1
ffffffffc020408e:	af6ff0ef          	jal	ra,ffffffffc0203384 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204092:	8526                	mv	a0,s1
ffffffffc0204094:	bf5fd0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
    return ret;
ffffffffc0204098:	b37d                	j	ffffffffc0203e46 <do_execve+0xc4>
            exit_mmap(mm);
ffffffffc020409a:	8552                	mv	a0,s4
ffffffffc020409c:	d87fd0ef          	jal	ra,ffffffffc0201e22 <exit_mmap>
            put_pgdir(mm);
ffffffffc02040a0:	8552                	mv	a0,s4
ffffffffc02040a2:	ae2ff0ef          	jal	ra,ffffffffc0203384 <put_pgdir>
            mm_destroy(mm);
ffffffffc02040a6:	8552                	mv	a0,s4
ffffffffc02040a8:	be1fd0ef          	jal	ra,ffffffffc0201c88 <mm_destroy>
ffffffffc02040ac:	b39d                	j	ffffffffc0203e12 <do_execve+0x90>
        if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
ffffffffc02040ae:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
ffffffffc02040b2:	f39d                	bnez	a5,ffffffffc0203fd8 <do_execve+0x256>
        if (vm_flags & VM_WRITE) perm |= (PTE_W | PTE_R);
ffffffffc02040b4:	47dd                	li	a5,23
ffffffffc02040b6:	e03e                	sd	a5,0(sp)
ffffffffc02040b8:	b73d                	j	ffffffffc0203fe6 <do_execve+0x264>
ffffffffc02040ba:	01093a03          	ld	s4,16(s2)
        end = ph->p_va + ph->p_memsz;
ffffffffc02040be:	02893683          	ld	a3,40(s2)
ffffffffc02040c2:	9a36                	add	s4,s4,a3
        if (start < la) {
ffffffffc02040c4:	077c7f63          	bgeu	s8,s7,ffffffffc0204142 <do_execve+0x3c0>
            if (start == end) {
ffffffffc02040c8:	e18a02e3          	beq	s4,s8,ffffffffc0203ecc <do_execve+0x14a>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02040cc:	6505                	lui	a0,0x1
ffffffffc02040ce:	9562                	add	a0,a0,s8
ffffffffc02040d0:	41750533          	sub	a0,a0,s7
                size -= la - end;
ffffffffc02040d4:	418a0b33          	sub	s6,s4,s8
            if (end < la) {
ffffffffc02040d8:	0d7a7863          	bgeu	s4,s7,ffffffffc02041a8 <do_execve+0x426>
    return page - pages + nbase;
ffffffffc02040dc:	000db683          	ld	a3,0(s11)
ffffffffc02040e0:	000d3583          	ld	a1,0(s10)
    return KADDR(page2pa(page));
ffffffffc02040e4:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc02040e6:	40d406b3          	sub	a3,s0,a3
ffffffffc02040ea:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02040ec:	000cb603          	ld	a2,0(s9)
    return page - pages + nbase;
ffffffffc02040f0:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc02040f2:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02040f6:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02040f8:	0cc5f163          	bgeu	a1,a2,ffffffffc02041ba <do_execve+0x438>
ffffffffc02040fc:	00030617          	auipc	a2,0x30
ffffffffc0204100:	bf463603          	ld	a2,-1036(a2) # ffffffffc0233cf0 <va_pa_offset>
ffffffffc0204104:	96b2                	add	a3,a3,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc0204106:	4581                	li	a1,0
ffffffffc0204108:	865a                	mv	a2,s6
ffffffffc020410a:	9536                	add	a0,a0,a3
ffffffffc020410c:	746000ef          	jal	ra,ffffffffc0204852 <memset>
            start += size;
ffffffffc0204110:	018b0733          	add	a4,s6,s8
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204114:	037a7463          	bgeu	s4,s7,ffffffffc020413c <do_execve+0x3ba>
ffffffffc0204118:	daea0ae3          	beq	s4,a4,ffffffffc0203ecc <do_execve+0x14a>
ffffffffc020411c:	00002697          	auipc	a3,0x2
ffffffffc0204120:	24468693          	addi	a3,a3,580 # ffffffffc0206360 <default_pmm_manager+0x2f8>
ffffffffc0204124:	00001617          	auipc	a2,0x1
ffffffffc0204128:	20460613          	addi	a2,a2,516 # ffffffffc0205328 <commands+0x408>
ffffffffc020412c:	22600593          	li	a1,550
ffffffffc0204130:	00002517          	auipc	a0,0x2
ffffffffc0204134:	02850513          	addi	a0,a0,40 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204138:	8ccfc0ef          	jal	ra,ffffffffc0200204 <__panic>
ffffffffc020413c:	ff7710e3          	bne	a4,s7,ffffffffc020411c <do_execve+0x39a>
ffffffffc0204140:	8c5e                	mv	s8,s7
ffffffffc0204142:	00030b17          	auipc	s6,0x30
ffffffffc0204146:	baeb0b13          	addi	s6,s6,-1106 # ffffffffc0233cf0 <va_pa_offset>
        while (start < end) {
ffffffffc020414a:	054c6763          	bltu	s8,s4,ffffffffc0204198 <do_execve+0x416>
ffffffffc020414e:	bbbd                	j	ffffffffc0203ecc <do_execve+0x14a>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204150:	6785                	lui	a5,0x1
ffffffffc0204152:	417c0533          	sub	a0,s8,s7
ffffffffc0204156:	9bbe                	add	s7,s7,a5
ffffffffc0204158:	418b8633          	sub	a2,s7,s8
            if (end < la) {
ffffffffc020415c:	017a7463          	bgeu	s4,s7,ffffffffc0204164 <do_execve+0x3e2>
                size -= la - end;
ffffffffc0204160:	418a0633          	sub	a2,s4,s8
    return page - pages + nbase;
ffffffffc0204164:	000db683          	ld	a3,0(s11)
ffffffffc0204168:	000d3803          	ld	a6,0(s10)
    return KADDR(page2pa(page));
ffffffffc020416c:	67a2                	ld	a5,8(sp)
    return page - pages + nbase;
ffffffffc020416e:	40d406b3          	sub	a3,s0,a3
ffffffffc0204172:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204174:	000cb583          	ld	a1,0(s9)
    return page - pages + nbase;
ffffffffc0204178:	96c2                	add	a3,a3,a6
    return KADDR(page2pa(page));
ffffffffc020417a:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc020417e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204180:	02b87d63          	bgeu	a6,a1,ffffffffc02041ba <do_execve+0x438>
ffffffffc0204184:	000b3803          	ld	a6,0(s6)
            start += size;
ffffffffc0204188:	9c32                	add	s8,s8,a2
            memset(page2kva(page) + off, 0, size);
ffffffffc020418a:	4581                	li	a1,0
ffffffffc020418c:	96c2                	add	a3,a3,a6
ffffffffc020418e:	9536                	add	a0,a0,a3
ffffffffc0204190:	6c2000ef          	jal	ra,ffffffffc0204852 <memset>
        while (start < end) {
ffffffffc0204194:	d34c7ce3          	bgeu	s8,s4,ffffffffc0203ecc <do_execve+0x14a>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
ffffffffc0204198:	6c88                	ld	a0,24(s1)
ffffffffc020419a:	6602                	ld	a2,0(sp)
ffffffffc020419c:	85de                	mv	a1,s7
ffffffffc020419e:	cf2fd0ef          	jal	ra,ffffffffc0201690 <pgdir_alloc_page>
ffffffffc02041a2:	842a                	mv	s0,a0
ffffffffc02041a4:	f555                	bnez	a0,ffffffffc0204150 <do_execve+0x3ce>
ffffffffc02041a6:	bdf9                	j	ffffffffc0204084 <do_execve+0x302>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc02041a8:	418b8b33          	sub	s6,s7,s8
ffffffffc02041ac:	bf05                	j	ffffffffc02040dc <do_execve+0x35a>
        return -E_INVAL;
ffffffffc02041ae:	5a75                	li	s4,-3
ffffffffc02041b0:	b3c5                	j	ffffffffc0203f90 <do_execve+0x20e>
        while (start < end) {
ffffffffc02041b2:	8a62                	mv	s4,s8
ffffffffc02041b4:	b729                	j	ffffffffc02040be <do_execve+0x33c>
            ret = -E_INVAL_ELF;
ffffffffc02041b6:	5a61                	li	s4,-8
ffffffffc02041b8:	b5f9                	j	ffffffffc0204086 <do_execve+0x304>
ffffffffc02041ba:	00001617          	auipc	a2,0x1
ffffffffc02041be:	51e60613          	addi	a2,a2,1310 # ffffffffc02056d8 <commands+0x7b8>
ffffffffc02041c2:	06900593          	li	a1,105
ffffffffc02041c6:	00001517          	auipc	a0,0x1
ffffffffc02041ca:	47250513          	addi	a0,a0,1138 # ffffffffc0205638 <commands+0x718>
ffffffffc02041ce:	836fc0ef          	jal	ra,ffffffffc0200204 <__panic>
    current->cr3 = PADDR(mm->pgdir);
ffffffffc02041d2:	00001617          	auipc	a2,0x1
ffffffffc02041d6:	4ce60613          	addi	a2,a2,1230 # ffffffffc02056a0 <commands+0x780>
ffffffffc02041da:	24100593          	li	a1,577
ffffffffc02041de:	00002517          	auipc	a0,0x2
ffffffffc02041e2:	f7a50513          	addi	a0,a0,-134 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc02041e6:	81efc0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
ffffffffc02041ea:	00002697          	auipc	a3,0x2
ffffffffc02041ee:	28e68693          	addi	a3,a3,654 # ffffffffc0206478 <default_pmm_manager+0x410>
ffffffffc02041f2:	00001617          	auipc	a2,0x1
ffffffffc02041f6:	13660613          	addi	a2,a2,310 # ffffffffc0205328 <commands+0x408>
ffffffffc02041fa:	23c00593          	li	a1,572
ffffffffc02041fe:	00002517          	auipc	a0,0x2
ffffffffc0204202:	f5a50513          	addi	a0,a0,-166 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204206:	ffffb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
ffffffffc020420a:	00002697          	auipc	a3,0x2
ffffffffc020420e:	22668693          	addi	a3,a3,550 # ffffffffc0206430 <default_pmm_manager+0x3c8>
ffffffffc0204212:	00001617          	auipc	a2,0x1
ffffffffc0204216:	11660613          	addi	a2,a2,278 # ffffffffc0205328 <commands+0x408>
ffffffffc020421a:	23b00593          	li	a1,571
ffffffffc020421e:	00002517          	auipc	a0,0x2
ffffffffc0204222:	f3a50513          	addi	a0,a0,-198 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204226:	fdffb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
ffffffffc020422a:	00002697          	auipc	a3,0x2
ffffffffc020422e:	1be68693          	addi	a3,a3,446 # ffffffffc02063e8 <default_pmm_manager+0x380>
ffffffffc0204232:	00001617          	auipc	a2,0x1
ffffffffc0204236:	0f660613          	addi	a2,a2,246 # ffffffffc0205328 <commands+0x408>
ffffffffc020423a:	23a00593          	li	a1,570
ffffffffc020423e:	00002517          	auipc	a0,0x2
ffffffffc0204242:	f1a50513          	addi	a0,a0,-230 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204246:	fbffb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
ffffffffc020424a:	00002697          	auipc	a3,0x2
ffffffffc020424e:	15668693          	addi	a3,a3,342 # ffffffffc02063a0 <default_pmm_manager+0x338>
ffffffffc0204252:	00001617          	auipc	a2,0x1
ffffffffc0204256:	0d660613          	addi	a2,a2,214 # ffffffffc0205328 <commands+0x408>
ffffffffc020425a:	23900593          	li	a1,569
ffffffffc020425e:	00002517          	auipc	a0,0x2
ffffffffc0204262:	efa50513          	addi	a0,a0,-262 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204266:	f9ffb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020426a <do_yield>:
    current->need_resched = 1;
ffffffffc020426a:	00030797          	auipc	a5,0x30
ffffffffc020426e:	a467b783          	ld	a5,-1466(a5) # ffffffffc0233cb0 <current>
ffffffffc0204272:	4705                	li	a4,1
ffffffffc0204274:	ef98                	sd	a4,24(a5)
}
ffffffffc0204276:	4501                	li	a0,0
ffffffffc0204278:	8082                	ret

ffffffffc020427a <do_wait>:
do_wait(int pid, int *code_store) {
ffffffffc020427a:	1101                	addi	sp,sp,-32
ffffffffc020427c:	e822                	sd	s0,16(sp)
ffffffffc020427e:	e426                	sd	s1,8(sp)
ffffffffc0204280:	ec06                	sd	ra,24(sp)
ffffffffc0204282:	842e                	mv	s0,a1
ffffffffc0204284:	84aa                	mv	s1,a0
    if (code_store != NULL) {
ffffffffc0204286:	c999                	beqz	a1,ffffffffc020429c <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204288:	00030797          	auipc	a5,0x30
ffffffffc020428c:	a287b783          	ld	a5,-1496(a5) # ffffffffc0233cb0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1)) {
ffffffffc0204290:	7788                	ld	a0,40(a5)
ffffffffc0204292:	4685                	li	a3,1
ffffffffc0204294:	4611                	li	a2,4
ffffffffc0204296:	d07fd0ef          	jal	ra,ffffffffc0201f9c <user_mem_check>
ffffffffc020429a:	c909                	beqz	a0,ffffffffc02042ac <do_wait+0x32>
ffffffffc020429c:	85a2                	mv	a1,s0
}
ffffffffc020429e:	6442                	ld	s0,16(sp)
ffffffffc02042a0:	60e2                	ld	ra,24(sp)
ffffffffc02042a2:	8526                	mv	a0,s1
ffffffffc02042a4:	64a2                	ld	s1,8(sp)
ffffffffc02042a6:	6105                	addi	sp,sp,32
ffffffffc02042a8:	821ff06f          	j	ffffffffc0203ac8 <do_wait.part.0>
ffffffffc02042ac:	60e2                	ld	ra,24(sp)
ffffffffc02042ae:	6442                	ld	s0,16(sp)
ffffffffc02042b0:	64a2                	ld	s1,8(sp)
ffffffffc02042b2:	5575                	li	a0,-3
ffffffffc02042b4:	6105                	addi	sp,sp,32
ffffffffc02042b6:	8082                	ret

ffffffffc02042b8 <do_kill>:
do_kill(int pid) {
ffffffffc02042b8:	1141                	addi	sp,sp,-16
ffffffffc02042ba:	e406                	sd	ra,8(sp)
ffffffffc02042bc:	e022                	sd	s0,0(sp)
    if ((proc = find_proc(pid)) != NULL) {
ffffffffc02042be:	a54ff0ef          	jal	ra,ffffffffc0203512 <find_proc>
ffffffffc02042c2:	cd0d                	beqz	a0,ffffffffc02042fc <do_kill+0x44>
        if (!(proc->flags & PF_EXITING)) {
ffffffffc02042c4:	0b052703          	lw	a4,176(a0)
ffffffffc02042c8:	00177693          	andi	a3,a4,1
ffffffffc02042cc:	e695                	bnez	a3,ffffffffc02042f8 <do_kill+0x40>
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042ce:	0ec52683          	lw	a3,236(a0)
            proc->flags |= PF_EXITING;
ffffffffc02042d2:	00176713          	ori	a4,a4,1
ffffffffc02042d6:	0ae52823          	sw	a4,176(a0)
            return 0;
ffffffffc02042da:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED) {
ffffffffc02042dc:	0006c763          	bltz	a3,ffffffffc02042ea <do_kill+0x32>
}
ffffffffc02042e0:	60a2                	ld	ra,8(sp)
ffffffffc02042e2:	8522                	mv	a0,s0
ffffffffc02042e4:	6402                	ld	s0,0(sp)
ffffffffc02042e6:	0141                	addi	sp,sp,16
ffffffffc02042e8:	8082                	ret
                wakeup_proc(proc);
ffffffffc02042ea:	1e2000ef          	jal	ra,ffffffffc02044cc <wakeup_proc>
}
ffffffffc02042ee:	60a2                	ld	ra,8(sp)
ffffffffc02042f0:	8522                	mv	a0,s0
ffffffffc02042f2:	6402                	ld	s0,0(sp)
ffffffffc02042f4:	0141                	addi	sp,sp,16
ffffffffc02042f6:	8082                	ret
        return -E_KILLED;
ffffffffc02042f8:	545d                	li	s0,-9
ffffffffc02042fa:	b7dd                	j	ffffffffc02042e0 <do_kill+0x28>
    return -E_INVAL;
ffffffffc02042fc:	5475                	li	s0,-3
ffffffffc02042fe:	b7cd                	j	ffffffffc02042e0 <do_kill+0x28>

ffffffffc0204300 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
void
proc_init(void) {
ffffffffc0204300:	1101                	addi	sp,sp,-32
    elm->prev = elm->next = elm;
ffffffffc0204302:	00030797          	auipc	a5,0x30
ffffffffc0204306:	afe78793          	addi	a5,a5,-1282 # ffffffffc0233e00 <proc_list>
ffffffffc020430a:	ec06                	sd	ra,24(sp)
ffffffffc020430c:	e822                	sd	s0,16(sp)
ffffffffc020430e:	e426                	sd	s1,8(sp)
ffffffffc0204310:	e04a                	sd	s2,0(sp)
ffffffffc0204312:	e79c                	sd	a5,8(a5)
ffffffffc0204314:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
ffffffffc0204316:	00030717          	auipc	a4,0x30
ffffffffc020431a:	93270713          	addi	a4,a4,-1742 # ffffffffc0233c48 <__rq>
ffffffffc020431e:	0002c797          	auipc	a5,0x2c
ffffffffc0204322:	92a78793          	addi	a5,a5,-1750 # ffffffffc022fc48 <hash_list>
ffffffffc0204326:	e79c                	sd	a5,8(a5)
ffffffffc0204328:	e39c                	sd	a5,0(a5)
ffffffffc020432a:	07c1                	addi	a5,a5,16
ffffffffc020432c:	fef71de3          	bne	a4,a5,ffffffffc0204326 <proc_init+0x26>
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL) {
ffffffffc0204330:	f43fe0ef          	jal	ra,ffffffffc0203272 <alloc_proc>
ffffffffc0204334:	00030417          	auipc	s0,0x30
ffffffffc0204338:	98440413          	addi	s0,s0,-1660 # ffffffffc0233cb8 <idleproc>
ffffffffc020433c:	e008                	sd	a0,0(s0)
ffffffffc020433e:	c541                	beqz	a0,ffffffffc02043c6 <proc_init+0xc6>
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204340:	4709                	li	a4,2
ffffffffc0204342:	e118                	sd	a4,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
    idleproc->need_resched = 1;
ffffffffc0204344:	4485                	li	s1,1
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204346:	00003717          	auipc	a4,0x3
ffffffffc020434a:	cba70713          	addi	a4,a4,-838 # ffffffffc0207000 <bootstack>
    set_proc_name(idleproc, "idle");
ffffffffc020434e:	00002597          	auipc	a1,0x2
ffffffffc0204352:	18a58593          	addi	a1,a1,394 # ffffffffc02064d8 <default_pmm_manager+0x470>
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204356:	e918                	sd	a4,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204358:	ed04                	sd	s1,24(a0)
    set_proc_name(idleproc, "idle");
ffffffffc020435a:	922ff0ef          	jal	ra,ffffffffc020347c <set_proc_name>
    nr_process ++;
ffffffffc020435e:	00030717          	auipc	a4,0x30
ffffffffc0204362:	96a70713          	addi	a4,a4,-1686 # ffffffffc0233cc8 <nr_process>
ffffffffc0204366:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204368:	6014                	ld	a3,0(s0)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020436a:	4601                	li	a2,0
    nr_process ++;
ffffffffc020436c:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc020436e:	4581                	li	a1,0
ffffffffc0204370:	00000517          	auipc	a0,0x0
ffffffffc0204374:	8ee50513          	addi	a0,a0,-1810 # ffffffffc0203c5e <init_main>
    nr_process ++;
ffffffffc0204378:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc020437a:	00030797          	auipc	a5,0x30
ffffffffc020437e:	92d7bb23          	sd	a3,-1738(a5) # ffffffffc0233cb0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204382:	dacff0ef          	jal	ra,ffffffffc020392e <kernel_thread>
    if (pid <= 0) {
ffffffffc0204386:	08a05c63          	blez	a0,ffffffffc020441e <proc_init+0x11e>
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc020438a:	988ff0ef          	jal	ra,ffffffffc0203512 <find_proc>
ffffffffc020438e:	00030917          	auipc	s2,0x30
ffffffffc0204392:	93290913          	addi	s2,s2,-1742 # ffffffffc0233cc0 <initproc>
    set_proc_name(initproc, "init");
ffffffffc0204396:	00002597          	auipc	a1,0x2
ffffffffc020439a:	16a58593          	addi	a1,a1,362 # ffffffffc0206500 <default_pmm_manager+0x498>
    initproc = find_proc(pid);
ffffffffc020439e:	00a93023          	sd	a0,0(s2)
    set_proc_name(initproc, "init");
ffffffffc02043a2:	8daff0ef          	jal	ra,ffffffffc020347c <set_proc_name>

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043a6:	601c                	ld	a5,0(s0)
ffffffffc02043a8:	cbb9                	beqz	a5,ffffffffc02043fe <proc_init+0xfe>
ffffffffc02043aa:	43dc                	lw	a5,4(a5)
ffffffffc02043ac:	eba9                	bnez	a5,ffffffffc02043fe <proc_init+0xfe>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043ae:	00093783          	ld	a5,0(s2)
ffffffffc02043b2:	c795                	beqz	a5,ffffffffc02043de <proc_init+0xde>
ffffffffc02043b4:	43dc                	lw	a5,4(a5)
ffffffffc02043b6:	02979463          	bne	a5,s1,ffffffffc02043de <proc_init+0xde>
}
ffffffffc02043ba:	60e2                	ld	ra,24(sp)
ffffffffc02043bc:	6442                	ld	s0,16(sp)
ffffffffc02043be:	64a2                	ld	s1,8(sp)
ffffffffc02043c0:	6902                	ld	s2,0(sp)
ffffffffc02043c2:	6105                	addi	sp,sp,32
ffffffffc02043c4:	8082                	ret
        panic("cannot alloc idleproc.\n");
ffffffffc02043c6:	00002617          	auipc	a2,0x2
ffffffffc02043ca:	0fa60613          	addi	a2,a2,250 # ffffffffc02064c0 <default_pmm_manager+0x458>
ffffffffc02043ce:	33000593          	li	a1,816
ffffffffc02043d2:	00002517          	auipc	a0,0x2
ffffffffc02043d6:	d8650513          	addi	a0,a0,-634 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc02043da:	e2bfb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc02043de:	00002697          	auipc	a3,0x2
ffffffffc02043e2:	15268693          	addi	a3,a3,338 # ffffffffc0206530 <default_pmm_manager+0x4c8>
ffffffffc02043e6:	00001617          	auipc	a2,0x1
ffffffffc02043ea:	f4260613          	addi	a2,a2,-190 # ffffffffc0205328 <commands+0x408>
ffffffffc02043ee:	34500593          	li	a1,837
ffffffffc02043f2:	00002517          	auipc	a0,0x2
ffffffffc02043f6:	d6650513          	addi	a0,a0,-666 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc02043fa:	e0bfb0ef          	jal	ra,ffffffffc0200204 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc02043fe:	00002697          	auipc	a3,0x2
ffffffffc0204402:	10a68693          	addi	a3,a3,266 # ffffffffc0206508 <default_pmm_manager+0x4a0>
ffffffffc0204406:	00001617          	auipc	a2,0x1
ffffffffc020440a:	f2260613          	addi	a2,a2,-222 # ffffffffc0205328 <commands+0x408>
ffffffffc020440e:	34400593          	li	a1,836
ffffffffc0204412:	00002517          	auipc	a0,0x2
ffffffffc0204416:	d4650513          	addi	a0,a0,-698 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc020441a:	debfb0ef          	jal	ra,ffffffffc0200204 <__panic>
        panic("create init_main failed.\n");
ffffffffc020441e:	00002617          	auipc	a2,0x2
ffffffffc0204422:	0c260613          	addi	a2,a2,194 # ffffffffc02064e0 <default_pmm_manager+0x478>
ffffffffc0204426:	33e00593          	li	a1,830
ffffffffc020442a:	00002517          	auipc	a0,0x2
ffffffffc020442e:	d2e50513          	addi	a0,a0,-722 # ffffffffc0206158 <default_pmm_manager+0xf0>
ffffffffc0204432:	dd3fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204436 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
ffffffffc0204436:	1141                	addi	sp,sp,-16
ffffffffc0204438:	e022                	sd	s0,0(sp)
ffffffffc020443a:	e406                	sd	ra,8(sp)
ffffffffc020443c:	00030417          	auipc	s0,0x30
ffffffffc0204440:	87440413          	addi	s0,s0,-1932 # ffffffffc0233cb0 <current>
    while (1) {
        if (current->need_resched) {
ffffffffc0204444:	6018                	ld	a4,0(s0)
ffffffffc0204446:	6f1c                	ld	a5,24(a4)
ffffffffc0204448:	dffd                	beqz	a5,ffffffffc0204446 <cpu_idle+0x10>
            schedule();
ffffffffc020444a:	134000ef          	jal	ra,ffffffffc020457e <schedule>
ffffffffc020444e:	bfdd                	j	ffffffffc0204444 <cpu_idle+0xe>

ffffffffc0204450 <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void
sched_class_proc_tick(struct proc_struct *proc) {
    if (proc != idleproc) {
ffffffffc0204450:	00030797          	auipc	a5,0x30
ffffffffc0204454:	8687b783          	ld	a5,-1944(a5) # ffffffffc0233cb8 <idleproc>
sched_class_proc_tick(struct proc_struct *proc) {
ffffffffc0204458:	85aa                	mv	a1,a0
    if (proc != idleproc) {
ffffffffc020445a:	00a78d63          	beq	a5,a0,ffffffffc0204474 <sched_class_proc_tick+0x24>
        sched_class->proc_tick(rq, proc);
ffffffffc020445e:	00030797          	auipc	a5,0x30
ffffffffc0204462:	87a7b783          	ld	a5,-1926(a5) # ffffffffc0233cd8 <sched_class>
ffffffffc0204466:	0287b303          	ld	t1,40(a5)
ffffffffc020446a:	00030517          	auipc	a0,0x30
ffffffffc020446e:	86653503          	ld	a0,-1946(a0) # ffffffffc0233cd0 <rq>
ffffffffc0204472:	8302                	jr	t1
    }
    else {
        proc->need_resched = 1;
ffffffffc0204474:	4705                	li	a4,1
ffffffffc0204476:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc0204478:	8082                	ret

ffffffffc020447a <sched_init>:

static struct run_queue __rq;

void
sched_init(void) {
ffffffffc020447a:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc020447c:	00024717          	auipc	a4,0x24
ffffffffc0204480:	38c70713          	addi	a4,a4,908 # ffffffffc0228808 <default_sched_class>
sched_init(void) {
ffffffffc0204484:	e022                	sd	s0,0(sp)
ffffffffc0204486:	e406                	sd	ra,8(sp)
ffffffffc0204488:	0002f797          	auipc	a5,0x2f
ffffffffc020448c:	7e078793          	addi	a5,a5,2016 # ffffffffc0233c68 <timer_list>
    //sched_class = &stride_sched_class;

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0204490:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc0204492:	0002f517          	auipc	a0,0x2f
ffffffffc0204496:	7b650513          	addi	a0,a0,1974 # ffffffffc0233c48 <__rq>
ffffffffc020449a:	e79c                	sd	a5,8(a5)
ffffffffc020449c:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc020449e:	4795                	li	a5,5
ffffffffc02044a0:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc02044a2:	00030417          	auipc	s0,0x30
ffffffffc02044a6:	83640413          	addi	s0,s0,-1994 # ffffffffc0233cd8 <sched_class>
    rq = &__rq;
ffffffffc02044aa:	00030797          	auipc	a5,0x30
ffffffffc02044ae:	82a7b323          	sd	a0,-2010(a5) # ffffffffc0233cd0 <rq>
    sched_class = &default_sched_class;
ffffffffc02044b2:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc02044b4:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044b6:	601c                	ld	a5,0(s0)
}
ffffffffc02044b8:	6402                	ld	s0,0(sp)
ffffffffc02044ba:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044bc:	638c                	ld	a1,0(a5)
ffffffffc02044be:	00002517          	auipc	a0,0x2
ffffffffc02044c2:	09a50513          	addi	a0,a0,154 # ffffffffc0206558 <default_pmm_manager+0x4f0>
}
ffffffffc02044c6:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc02044c8:	c01fb06f          	j	ffffffffc02000c8 <cprintf>

ffffffffc02044cc <wakeup_proc>:

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044cc:	4118                	lw	a4,0(a0)
wakeup_proc(struct proc_struct *proc) {
ffffffffc02044ce:	1101                	addi	sp,sp,-32
ffffffffc02044d0:	ec06                	sd	ra,24(sp)
ffffffffc02044d2:	e822                	sd	s0,16(sp)
ffffffffc02044d4:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02044d6:	478d                	li	a5,3
ffffffffc02044d8:	08f70363          	beq	a4,a5,ffffffffc020455e <wakeup_proc+0x92>
ffffffffc02044dc:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044de:	100027f3          	csrr	a5,sstatus
ffffffffc02044e2:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044e4:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02044e6:	e7bd                	bnez	a5,ffffffffc0204554 <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE) {
ffffffffc02044e8:	4789                	li	a5,2
ffffffffc02044ea:	04f70863          	beq	a4,a5,ffffffffc020453a <wakeup_proc+0x6e>
            proc->state = PROC_RUNNABLE;
ffffffffc02044ee:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc02044f0:	0e042623          	sw	zero,236(s0)
            if (proc != current) {
ffffffffc02044f4:	0002f797          	auipc	a5,0x2f
ffffffffc02044f8:	7bc7b783          	ld	a5,1980(a5) # ffffffffc0233cb0 <current>
ffffffffc02044fc:	02878363          	beq	a5,s0,ffffffffc0204522 <wakeup_proc+0x56>
    if (proc != idleproc) {
ffffffffc0204500:	0002f797          	auipc	a5,0x2f
ffffffffc0204504:	7b87b783          	ld	a5,1976(a5) # ffffffffc0233cb8 <idleproc>
ffffffffc0204508:	00f40d63          	beq	s0,a5,ffffffffc0204522 <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc020450c:	0002f797          	auipc	a5,0x2f
ffffffffc0204510:	7cc7b783          	ld	a5,1996(a5) # ffffffffc0233cd8 <sched_class>
ffffffffc0204514:	6b9c                	ld	a5,16(a5)
ffffffffc0204516:	85a2                	mv	a1,s0
ffffffffc0204518:	0002f517          	auipc	a0,0x2f
ffffffffc020451c:	7b853503          	ld	a0,1976(a0) # ffffffffc0233cd0 <rq>
ffffffffc0204520:	9782                	jalr	a5
    if (flag) {
ffffffffc0204522:	e491                	bnez	s1,ffffffffc020452e <wakeup_proc+0x62>
        else {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0204524:	60e2                	ld	ra,24(sp)
ffffffffc0204526:	6442                	ld	s0,16(sp)
ffffffffc0204528:	64a2                	ld	s1,8(sp)
ffffffffc020452a:	6105                	addi	sp,sp,32
ffffffffc020452c:	8082                	ret
ffffffffc020452e:	6442                	ld	s0,16(sp)
ffffffffc0204530:	60e2                	ld	ra,24(sp)
ffffffffc0204532:	64a2                	ld	s1,8(sp)
ffffffffc0204534:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0204536:	8f6fc06f          	j	ffffffffc020062c <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc020453a:	00002617          	auipc	a2,0x2
ffffffffc020453e:	06e60613          	addi	a2,a2,110 # ffffffffc02065a8 <default_pmm_manager+0x540>
ffffffffc0204542:	04900593          	li	a1,73
ffffffffc0204546:	00002517          	auipc	a0,0x2
ffffffffc020454a:	04a50513          	addi	a0,a0,74 # ffffffffc0206590 <default_pmm_manager+0x528>
ffffffffc020454e:	d1ffb0ef          	jal	ra,ffffffffc020026c <__warn>
ffffffffc0204552:	bfc1                	j	ffffffffc0204522 <wakeup_proc+0x56>
        intr_disable();
ffffffffc0204554:	8defc0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc0204558:	4018                	lw	a4,0(s0)
ffffffffc020455a:	4485                	li	s1,1
ffffffffc020455c:	b771                	j	ffffffffc02044e8 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020455e:	00002697          	auipc	a3,0x2
ffffffffc0204562:	01268693          	addi	a3,a3,18 # ffffffffc0206570 <default_pmm_manager+0x508>
ffffffffc0204566:	00001617          	auipc	a2,0x1
ffffffffc020456a:	dc260613          	addi	a2,a2,-574 # ffffffffc0205328 <commands+0x408>
ffffffffc020456e:	03d00593          	li	a1,61
ffffffffc0204572:	00002517          	auipc	a0,0x2
ffffffffc0204576:	01e50513          	addi	a0,a0,30 # ffffffffc0206590 <default_pmm_manager+0x528>
ffffffffc020457a:	c8bfb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc020457e <schedule>:

void
schedule(void) {
ffffffffc020457e:	7179                	addi	sp,sp,-48
ffffffffc0204580:	f406                	sd	ra,40(sp)
ffffffffc0204582:	f022                	sd	s0,32(sp)
ffffffffc0204584:	ec26                	sd	s1,24(sp)
ffffffffc0204586:	e84a                	sd	s2,16(sp)
ffffffffc0204588:	e44e                	sd	s3,8(sp)
ffffffffc020458a:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020458c:	100027f3          	csrr	a5,sstatus
ffffffffc0204590:	8b89                	andi	a5,a5,2
ffffffffc0204592:	4a01                	li	s4,0
ffffffffc0204594:	ebdd                	bnez	a5,ffffffffc020464a <schedule+0xcc>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc0204596:	0002f497          	auipc	s1,0x2f
ffffffffc020459a:	71a48493          	addi	s1,s1,1818 # ffffffffc0233cb0 <current>
ffffffffc020459e:	608c                	ld	a1,0(s1)
ffffffffc02045a0:	0002f997          	auipc	s3,0x2f
ffffffffc02045a4:	73898993          	addi	s3,s3,1848 # ffffffffc0233cd8 <sched_class>
ffffffffc02045a8:	0002f917          	auipc	s2,0x2f
ffffffffc02045ac:	72890913          	addi	s2,s2,1832 # ffffffffc0233cd0 <rq>
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045b0:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc02045b2:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE) {
ffffffffc02045b6:	4709                	li	a4,2
ffffffffc02045b8:	0009b783          	ld	a5,0(s3)
ffffffffc02045bc:	00093503          	ld	a0,0(s2)
ffffffffc02045c0:	04e68763          	beq	a3,a4,ffffffffc020460e <schedule+0x90>
    return sched_class->pick_next(rq);
ffffffffc02045c4:	739c                	ld	a5,32(a5)
ffffffffc02045c6:	9782                	jalr	a5
ffffffffc02045c8:	842a                	mv	s0,a0
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc02045ca:	c135                	beqz	a0,ffffffffc020462e <schedule+0xb0>
    sched_class->dequeue(rq, proc);
ffffffffc02045cc:	0009b783          	ld	a5,0(s3)
ffffffffc02045d0:	00093503          	ld	a0,0(s2)
ffffffffc02045d4:	85a2                	mv	a1,s0
ffffffffc02045d6:	6f9c                	ld	a5,24(a5)
ffffffffc02045d8:	9782                	jalr	a5
            sched_class_dequeue(next);
        }
        if (next == NULL) {
            next = idleproc;
        }
        next->runs ++;
ffffffffc02045da:	441c                	lw	a5,8(s0)
        if (next != current) {
ffffffffc02045dc:	6098                	ld	a4,0(s1)
        next->runs ++;
ffffffffc02045de:	2785                	addiw	a5,a5,1
ffffffffc02045e0:	c41c                	sw	a5,8(s0)
        if (next != current) {
ffffffffc02045e2:	00870c63          	beq	a4,s0,ffffffffc02045fa <schedule+0x7c>
            cprintf("The next proc is pid:%d\n",next->pid);
ffffffffc02045e6:	404c                	lw	a1,4(s0)
ffffffffc02045e8:	00002517          	auipc	a0,0x2
ffffffffc02045ec:	fe050513          	addi	a0,a0,-32 # ffffffffc02065c8 <default_pmm_manager+0x560>
ffffffffc02045f0:	ad9fb0ef          	jal	ra,ffffffffc02000c8 <cprintf>
            proc_run(next);
ffffffffc02045f4:	8522                	mv	a0,s0
ffffffffc02045f6:	eb1fe0ef          	jal	ra,ffffffffc02034a6 <proc_run>
    if (flag) {
ffffffffc02045fa:	020a1f63          	bnez	s4,ffffffffc0204638 <schedule+0xba>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02045fe:	70a2                	ld	ra,40(sp)
ffffffffc0204600:	7402                	ld	s0,32(sp)
ffffffffc0204602:	64e2                	ld	s1,24(sp)
ffffffffc0204604:	6942                	ld	s2,16(sp)
ffffffffc0204606:	69a2                	ld	s3,8(sp)
ffffffffc0204608:	6a02                	ld	s4,0(sp)
ffffffffc020460a:	6145                	addi	sp,sp,48
ffffffffc020460c:	8082                	ret
    if (proc != idleproc) {
ffffffffc020460e:	0002f717          	auipc	a4,0x2f
ffffffffc0204612:	6aa73703          	ld	a4,1706(a4) # ffffffffc0233cb8 <idleproc>
ffffffffc0204616:	fae587e3          	beq	a1,a4,ffffffffc02045c4 <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc020461a:	6b9c                	ld	a5,16(a5)
ffffffffc020461c:	9782                	jalr	a5
ffffffffc020461e:	0009b783          	ld	a5,0(s3)
ffffffffc0204622:	00093503          	ld	a0,0(s2)
    return sched_class->pick_next(rq);
ffffffffc0204626:	739c                	ld	a5,32(a5)
ffffffffc0204628:	9782                	jalr	a5
ffffffffc020462a:	842a                	mv	s0,a0
        if ((next = sched_class_pick_next()) != NULL) {
ffffffffc020462c:	f145                	bnez	a0,ffffffffc02045cc <schedule+0x4e>
            next = idleproc;
ffffffffc020462e:	0002f417          	auipc	s0,0x2f
ffffffffc0204632:	68a43403          	ld	s0,1674(s0) # ffffffffc0233cb8 <idleproc>
ffffffffc0204636:	b755                	j	ffffffffc02045da <schedule+0x5c>
}
ffffffffc0204638:	7402                	ld	s0,32(sp)
ffffffffc020463a:	70a2                	ld	ra,40(sp)
ffffffffc020463c:	64e2                	ld	s1,24(sp)
ffffffffc020463e:	6942                	ld	s2,16(sp)
ffffffffc0204640:	69a2                	ld	s3,8(sp)
ffffffffc0204642:	6a02                	ld	s4,0(sp)
ffffffffc0204644:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0204646:	fe7fb06f          	j	ffffffffc020062c <intr_enable>
        intr_disable();
ffffffffc020464a:	fe9fb0ef          	jal	ra,ffffffffc0200632 <intr_disable>
        return 1;
ffffffffc020464e:	4a05                	li	s4,1
ffffffffc0204650:	b799                	j	ffffffffc0204596 <schedule+0x18>

ffffffffc0204652 <RR_init>:
ffffffffc0204652:	e508                	sd	a0,8(a0)
ffffffffc0204654:	e108                	sd	a0,0(a0)
#include <default_sched.h>

static void
RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc0204656:	00052823          	sw	zero,16(a0)
}
ffffffffc020465a:	8082                	ret

ffffffffc020465c <RR_enqueue>:
    __list_add(elm, listelm->prev, listelm);
ffffffffc020465c:	611c                	ld	a5,0(a0)

static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    list_add_before(&(rq->run_list), &(proc->run_link));
ffffffffc020465e:	11058713          	addi	a4,a1,272
    prev->next = next->prev = elm;
ffffffffc0204662:	e118                	sd	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc0204664:	1205a683          	lw	a3,288(a1)
ffffffffc0204668:	e798                	sd	a4,8(a5)
    elm->prev = prev;
ffffffffc020466a:	10f5b823          	sd	a5,272(a1)
    elm->next = next;
ffffffffc020466e:	10a5bc23          	sd	a0,280(a1)
ffffffffc0204672:	495c                	lw	a5,20(a0)
ffffffffc0204674:	c299                	beqz	a3,ffffffffc020467a <RR_enqueue+0x1e>
ffffffffc0204676:	00d7d463          	bge	a5,a3,ffffffffc020467e <RR_enqueue+0x22>
        proc->time_slice = rq->max_time_slice;
ffffffffc020467a:	12f5a023          	sw	a5,288(a1)
    }
    proc->rq = rq;
    rq->proc_num ++;
ffffffffc020467e:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0204680:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc0204684:	2785                	addiw	a5,a5,1
ffffffffc0204686:	c91c                	sw	a5,16(a0)
}
ffffffffc0204688:	8082                	ret

ffffffffc020468a <RR_pick_next>:
    return listelm->next;
ffffffffc020468a:	651c                	ld	a5,8(a0)
}

static struct proc_struct *
RR_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
ffffffffc020468c:	00f50563          	beq	a0,a5,ffffffffc0204696 <RR_pick_next+0xc>
        return le2proc(le, run_link);
ffffffffc0204690:	ef078513          	addi	a0,a5,-272
ffffffffc0204694:	8082                	ret
    }
    return NULL;
ffffffffc0204696:	4501                	li	a0,0
}
ffffffffc0204698:	8082                	ret

ffffffffc020469a <RR_proc_tick>:

static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
ffffffffc020469a:	1205a783          	lw	a5,288(a1)
ffffffffc020469e:	00f05563          	blez	a5,ffffffffc02046a8 <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc02046a2:	37fd                	addiw	a5,a5,-1
ffffffffc02046a4:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc02046a8:	e399                	bnez	a5,ffffffffc02046ae <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc02046aa:	4785                	li	a5,1
ffffffffc02046ac:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc02046ae:	8082                	ret

ffffffffc02046b0 <RR_dequeue>:
    return list->next == list;
ffffffffc02046b0:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046b4:	11058793          	addi	a5,a1,272
ffffffffc02046b8:	02e78363          	beq	a5,a4,ffffffffc02046de <RR_dequeue+0x2e>
ffffffffc02046bc:	1085b683          	ld	a3,264(a1)
ffffffffc02046c0:	00a69f63          	bne	a3,a0,ffffffffc02046de <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc02046c4:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc02046c8:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc02046ca:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc02046cc:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc02046ce:	10f5bc23          	sd	a5,280(a1)
ffffffffc02046d2:	10f5b823          	sd	a5,272(a1)
ffffffffc02046d6:	fff6079b          	addiw	a5,a2,-1
ffffffffc02046da:	ca9c                	sw	a5,16(a3)
ffffffffc02046dc:	8082                	ret
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046de:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046e0:	00002697          	auipc	a3,0x2
ffffffffc02046e4:	f0868693          	addi	a3,a3,-248 # ffffffffc02065e8 <default_pmm_manager+0x580>
ffffffffc02046e8:	00001617          	auipc	a2,0x1
ffffffffc02046ec:	c4060613          	addi	a2,a2,-960 # ffffffffc0205328 <commands+0x408>
ffffffffc02046f0:	45e5                	li	a1,25
ffffffffc02046f2:	00002517          	auipc	a0,0x2
ffffffffc02046f6:	f2e50513          	addi	a0,a0,-210 # ffffffffc0206620 <default_pmm_manager+0x5b8>
RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
ffffffffc02046fa:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02046fc:	b09fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc0204700 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc0204700:	0002f797          	auipc	a5,0x2f
ffffffffc0204704:	5b07b783          	ld	a5,1456(a5) # ffffffffc0233cb0 <current>
}
ffffffffc0204708:	43c8                	lw	a0,4(a5)
ffffffffc020470a:	8082                	ret

ffffffffc020470c <sys_gettime>:
    cputchar(c);
    return 0;
}

static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc020470c:	0002f797          	auipc	a5,0x2f
ffffffffc0204710:	5d47b783          	ld	a5,1492(a5) # ffffffffc0233ce0 <ticks>
ffffffffc0204714:	0027951b          	slliw	a0,a5,0x2
ffffffffc0204718:	9d3d                	addw	a0,a0,a5
}
ffffffffc020471a:	0015151b          	slliw	a0,a0,0x1
ffffffffc020471e:	8082                	ret

ffffffffc0204720 <sys_putc>:
    cputchar(c);
ffffffffc0204720:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0204722:	1141                	addi	sp,sp,-16
ffffffffc0204724:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0204726:	9d9fb0ef          	jal	ra,ffffffffc02000fe <cputchar>
}
ffffffffc020472a:	60a2                	ld	ra,8(sp)
ffffffffc020472c:	4501                	li	a0,0
ffffffffc020472e:	0141                	addi	sp,sp,16
ffffffffc0204730:	8082                	ret

ffffffffc0204732 <sys_kill>:
    return do_kill(pid);
ffffffffc0204732:	4108                	lw	a0,0(a0)
ffffffffc0204734:	b85ff06f          	j	ffffffffc02042b8 <do_kill>

ffffffffc0204738 <sys_yield>:
    return do_yield();
ffffffffc0204738:	b33ff06f          	j	ffffffffc020426a <do_yield>

ffffffffc020473c <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc020473c:	6d14                	ld	a3,24(a0)
ffffffffc020473e:	6910                	ld	a2,16(a0)
ffffffffc0204740:	650c                	ld	a1,8(a0)
ffffffffc0204742:	6108                	ld	a0,0(a0)
ffffffffc0204744:	e3eff06f          	j	ffffffffc0203d82 <do_execve>

ffffffffc0204748 <sys_wait>:
    return do_wait(pid, store);
ffffffffc0204748:	650c                	ld	a1,8(a0)
ffffffffc020474a:	4108                	lw	a0,0(a0)
ffffffffc020474c:	b2fff06f          	j	ffffffffc020427a <do_wait>

ffffffffc0204750 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0204750:	0002f797          	auipc	a5,0x2f
ffffffffc0204754:	5607b783          	ld	a5,1376(a5) # ffffffffc0233cb0 <current>
ffffffffc0204758:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc020475a:	4501                	li	a0,0
ffffffffc020475c:	6a0c                	ld	a1,16(a2)
ffffffffc020475e:	e0dfe06f          	j	ffffffffc020356a <do_fork>

ffffffffc0204762 <sys_exit>:
    return do_exit(error_code);
ffffffffc0204762:	4108                	lw	a0,0(a0)
ffffffffc0204764:	a1aff06f          	j	ffffffffc020397e <do_exit>

ffffffffc0204768 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc0204768:	715d                	addi	sp,sp,-80
ffffffffc020476a:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc020476c:	0002f497          	auipc	s1,0x2f
ffffffffc0204770:	54448493          	addi	s1,s1,1348 # ffffffffc0233cb0 <current>
ffffffffc0204774:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0204776:	e0a2                	sd	s0,64(sp)
ffffffffc0204778:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc020477a:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc020477c:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020477e:	47f9                	li	a5,30
    int num = tf->gpr.a0;
ffffffffc0204780:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0204784:	0327ee63          	bltu	a5,s2,ffffffffc02047c0 <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc0204788:	00391713          	slli	a4,s2,0x3
ffffffffc020478c:	00002797          	auipc	a5,0x2
ffffffffc0204790:	f0c78793          	addi	a5,a5,-244 # ffffffffc0206698 <syscalls>
ffffffffc0204794:	97ba                	add	a5,a5,a4
ffffffffc0204796:	639c                	ld	a5,0(a5)
ffffffffc0204798:	c785                	beqz	a5,ffffffffc02047c0 <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc020479a:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc020479c:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc020479e:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02047a0:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02047a2:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02047a4:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02047a6:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02047a8:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02047aa:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02047ac:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047ae:	0028                	addi	a0,sp,8
ffffffffc02047b0:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02047b2:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02047b4:	e828                	sd	a0,80(s0)
}
ffffffffc02047b6:	6406                	ld	s0,64(sp)
ffffffffc02047b8:	74e2                	ld	s1,56(sp)
ffffffffc02047ba:	7942                	ld	s2,48(sp)
ffffffffc02047bc:	6161                	addi	sp,sp,80
ffffffffc02047be:	8082                	ret
    print_trapframe(tf);
ffffffffc02047c0:	8522                	mv	a0,s0
ffffffffc02047c2:	85efc0ef          	jal	ra,ffffffffc0200820 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02047c6:	609c                	ld	a5,0(s1)
ffffffffc02047c8:	86ca                	mv	a3,s2
ffffffffc02047ca:	00002617          	auipc	a2,0x2
ffffffffc02047ce:	e8660613          	addi	a2,a2,-378 # ffffffffc0206650 <default_pmm_manager+0x5e8>
ffffffffc02047d2:	43d8                	lw	a4,4(a5)
ffffffffc02047d4:	06100593          	li	a1,97
ffffffffc02047d8:	0b478793          	addi	a5,a5,180
ffffffffc02047dc:	00002517          	auipc	a0,0x2
ffffffffc02047e0:	ea450513          	addi	a0,a0,-348 # ffffffffc0206680 <default_pmm_manager+0x618>
ffffffffc02047e4:	a21fb0ef          	jal	ra,ffffffffc0200204 <__panic>

ffffffffc02047e8 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02047e8:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02047ec:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02047ee:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02047f0:	cb81                	beqz	a5,ffffffffc0204800 <strlen+0x18>
        cnt ++;
ffffffffc02047f2:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02047f4:	00a707b3          	add	a5,a4,a0
ffffffffc02047f8:	0007c783          	lbu	a5,0(a5)
ffffffffc02047fc:	fbfd                	bnez	a5,ffffffffc02047f2 <strlen+0xa>
ffffffffc02047fe:	8082                	ret
    }
    return cnt;
}
ffffffffc0204800:	8082                	ret

ffffffffc0204802 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
ffffffffc0204802:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0204804:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0204806:	e589                	bnez	a1,ffffffffc0204810 <strnlen+0xe>
ffffffffc0204808:	a811                	j	ffffffffc020481c <strnlen+0x1a>
        cnt ++;
ffffffffc020480a:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc020480c:	00a58763          	beq	a1,a0,ffffffffc020481a <strnlen+0x18>
ffffffffc0204810:	00a707b3          	add	a5,a4,a0
ffffffffc0204814:	0007c783          	lbu	a5,0(a5)
ffffffffc0204818:	fbed                	bnez	a5,ffffffffc020480a <strnlen+0x8>
    }
    return cnt;
}
ffffffffc020481a:	8082                	ret
ffffffffc020481c:	8082                	ret

ffffffffc020481e <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020481e:	00054783          	lbu	a5,0(a0)
ffffffffc0204822:	0005c703          	lbu	a4,0(a1)
ffffffffc0204826:	cb89                	beqz	a5,ffffffffc0204838 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0204828:	0505                	addi	a0,a0,1
ffffffffc020482a:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020482c:	fee789e3          	beq	a5,a4,ffffffffc020481e <strcmp>
ffffffffc0204830:	0007851b          	sext.w	a0,a5
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0204834:	9d19                	subw	a0,a0,a4
ffffffffc0204836:	8082                	ret
ffffffffc0204838:	4501                	li	a0,0
ffffffffc020483a:	bfed                	j	ffffffffc0204834 <strcmp+0x16>

ffffffffc020483c <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020483c:	00054783          	lbu	a5,0(a0)
ffffffffc0204840:	c799                	beqz	a5,ffffffffc020484e <strchr+0x12>
        if (*s == c) {
ffffffffc0204842:	00f58763          	beq	a1,a5,ffffffffc0204850 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0204846:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020484a:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020484c:	fbfd                	bnez	a5,ffffffffc0204842 <strchr+0x6>
    }
    return NULL;
ffffffffc020484e:	4501                	li	a0,0
}
ffffffffc0204850:	8082                	ret

ffffffffc0204852 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0204852:	ca01                	beqz	a2,ffffffffc0204862 <memset+0x10>
ffffffffc0204854:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0204856:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0204858:	0785                	addi	a5,a5,1
ffffffffc020485a:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc020485e:	fec79de3          	bne	a5,a2,ffffffffc0204858 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0204862:	8082                	ret

ffffffffc0204864 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0204864:	ca19                	beqz	a2,ffffffffc020487a <memcpy+0x16>
ffffffffc0204866:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0204868:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc020486a:	0005c703          	lbu	a4,0(a1)
ffffffffc020486e:	0585                	addi	a1,a1,1
ffffffffc0204870:	0785                	addi	a5,a5,1
ffffffffc0204872:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc0204876:	fec59ae3          	bne	a1,a2,ffffffffc020486a <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc020487a:	8082                	ret

ffffffffc020487c <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc020487c:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204880:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0204882:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0204886:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0204888:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020488c:	f022                	sd	s0,32(sp)
ffffffffc020488e:	ec26                	sd	s1,24(sp)
ffffffffc0204890:	e84a                	sd	s2,16(sp)
ffffffffc0204892:	f406                	sd	ra,40(sp)
ffffffffc0204894:	e44e                	sd	s3,8(sp)
ffffffffc0204896:	84aa                	mv	s1,a0
ffffffffc0204898:	892e                	mv	s2,a1
ffffffffc020489a:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc020489e:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
ffffffffc02048a0:	03067e63          	bgeu	a2,a6,ffffffffc02048dc <printnum+0x60>
ffffffffc02048a4:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02048a6:	00805763          	blez	s0,ffffffffc02048b4 <printnum+0x38>
ffffffffc02048aa:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02048ac:	85ca                	mv	a1,s2
ffffffffc02048ae:	854e                	mv	a0,s3
ffffffffc02048b0:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02048b2:	fc65                	bnez	s0,ffffffffc02048aa <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048b4:	1a02                	slli	s4,s4,0x20
ffffffffc02048b6:	020a5a13          	srli	s4,s4,0x20
ffffffffc02048ba:	00002797          	auipc	a5,0x2
ffffffffc02048be:	ed678793          	addi	a5,a5,-298 # ffffffffc0206790 <syscalls+0xf8>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02048c2:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048c4:	9a3e                	add	s4,s4,a5
ffffffffc02048c6:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02048ca:	70a2                	ld	ra,40(sp)
ffffffffc02048cc:	69a2                	ld	s3,8(sp)
ffffffffc02048ce:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048d0:	85ca                	mv	a1,s2
ffffffffc02048d2:	8326                	mv	t1,s1
}
ffffffffc02048d4:	6942                	ld	s2,16(sp)
ffffffffc02048d6:	64e2                	ld	s1,24(sp)
ffffffffc02048d8:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02048da:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc02048dc:	03065633          	divu	a2,a2,a6
ffffffffc02048e0:	8722                	mv	a4,s0
ffffffffc02048e2:	f9bff0ef          	jal	ra,ffffffffc020487c <printnum>
ffffffffc02048e6:	b7f9                	j	ffffffffc02048b4 <printnum+0x38>

ffffffffc02048e8 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc02048e8:	7119                	addi	sp,sp,-128
ffffffffc02048ea:	f4a6                	sd	s1,104(sp)
ffffffffc02048ec:	f0ca                	sd	s2,96(sp)
ffffffffc02048ee:	ecce                	sd	s3,88(sp)
ffffffffc02048f0:	e8d2                	sd	s4,80(sp)
ffffffffc02048f2:	e4d6                	sd	s5,72(sp)
ffffffffc02048f4:	e0da                	sd	s6,64(sp)
ffffffffc02048f6:	fc5e                	sd	s7,56(sp)
ffffffffc02048f8:	f06a                	sd	s10,32(sp)
ffffffffc02048fa:	fc86                	sd	ra,120(sp)
ffffffffc02048fc:	f8a2                	sd	s0,112(sp)
ffffffffc02048fe:	f862                	sd	s8,48(sp)
ffffffffc0204900:	f466                	sd	s9,40(sp)
ffffffffc0204902:	ec6e                	sd	s11,24(sp)
ffffffffc0204904:	892a                	mv	s2,a0
ffffffffc0204906:	84ae                	mv	s1,a1
ffffffffc0204908:	8d32                	mv	s10,a2
ffffffffc020490a:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020490c:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0204910:	5b7d                	li	s6,-1
ffffffffc0204912:	00002a97          	auipc	s5,0x2
ffffffffc0204916:	eaaa8a93          	addi	s5,s5,-342 # ffffffffc02067bc <syscalls+0x124>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020491a:	00002b97          	auipc	s7,0x2
ffffffffc020491e:	0beb8b93          	addi	s7,s7,190 # ffffffffc02069d8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204922:	000d4503          	lbu	a0,0(s10)
ffffffffc0204926:	001d0413          	addi	s0,s10,1
ffffffffc020492a:	01350a63          	beq	a0,s3,ffffffffc020493e <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc020492e:	c121                	beqz	a0,ffffffffc020496e <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0204930:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204932:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0204934:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0204936:	fff44503          	lbu	a0,-1(s0)
ffffffffc020493a:	ff351ae3          	bne	a0,s3,ffffffffc020492e <vprintfmt+0x46>
ffffffffc020493e:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0204942:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0204946:	4c81                	li	s9,0
ffffffffc0204948:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020494a:	5c7d                	li	s8,-1
ffffffffc020494c:	5dfd                	li	s11,-1
ffffffffc020494e:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0204952:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204954:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0204958:	0ff5f593          	andi	a1,a1,255
ffffffffc020495c:	00140d13          	addi	s10,s0,1
ffffffffc0204960:	04b56263          	bltu	a0,a1,ffffffffc02049a4 <vprintfmt+0xbc>
ffffffffc0204964:	058a                	slli	a1,a1,0x2
ffffffffc0204966:	95d6                	add	a1,a1,s5
ffffffffc0204968:	4194                	lw	a3,0(a1)
ffffffffc020496a:	96d6                	add	a3,a3,s5
ffffffffc020496c:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc020496e:	70e6                	ld	ra,120(sp)
ffffffffc0204970:	7446                	ld	s0,112(sp)
ffffffffc0204972:	74a6                	ld	s1,104(sp)
ffffffffc0204974:	7906                	ld	s2,96(sp)
ffffffffc0204976:	69e6                	ld	s3,88(sp)
ffffffffc0204978:	6a46                	ld	s4,80(sp)
ffffffffc020497a:	6aa6                	ld	s5,72(sp)
ffffffffc020497c:	6b06                	ld	s6,64(sp)
ffffffffc020497e:	7be2                	ld	s7,56(sp)
ffffffffc0204980:	7c42                	ld	s8,48(sp)
ffffffffc0204982:	7ca2                	ld	s9,40(sp)
ffffffffc0204984:	7d02                	ld	s10,32(sp)
ffffffffc0204986:	6de2                	ld	s11,24(sp)
ffffffffc0204988:	6109                	addi	sp,sp,128
ffffffffc020498a:	8082                	ret
            padc = '0';
ffffffffc020498c:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc020498e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204992:	846a                	mv	s0,s10
ffffffffc0204994:	00140d13          	addi	s10,s0,1
ffffffffc0204998:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020499c:	0ff5f593          	andi	a1,a1,255
ffffffffc02049a0:	fcb572e3          	bgeu	a0,a1,ffffffffc0204964 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02049a4:	85a6                	mv	a1,s1
ffffffffc02049a6:	02500513          	li	a0,37
ffffffffc02049aa:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02049ac:	fff44783          	lbu	a5,-1(s0)
ffffffffc02049b0:	8d22                	mv	s10,s0
ffffffffc02049b2:	f73788e3          	beq	a5,s3,ffffffffc0204922 <vprintfmt+0x3a>
ffffffffc02049b6:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02049ba:	1d7d                	addi	s10,s10,-1
ffffffffc02049bc:	ff379de3          	bne	a5,s3,ffffffffc02049b6 <vprintfmt+0xce>
ffffffffc02049c0:	b78d                	j	ffffffffc0204922 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02049c2:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02049c6:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02049ca:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02049cc:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02049d0:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049d4:	02d86463          	bltu	a6,a3,ffffffffc02049fc <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02049d8:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc02049dc:	002c169b          	slliw	a3,s8,0x2
ffffffffc02049e0:	0186873b          	addw	a4,a3,s8
ffffffffc02049e4:	0017171b          	slliw	a4,a4,0x1
ffffffffc02049e8:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc02049ea:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc02049ee:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc02049f0:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc02049f4:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02049f8:	fed870e3          	bgeu	a6,a3,ffffffffc02049d8 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc02049fc:	f40ddce3          	bgez	s11,ffffffffc0204954 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0204a00:	8de2                	mv	s11,s8
ffffffffc0204a02:	5c7d                	li	s8,-1
ffffffffc0204a04:	bf81                	j	ffffffffc0204954 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0204a06:	fffdc693          	not	a3,s11
ffffffffc0204a0a:	96fd                	srai	a3,a3,0x3f
ffffffffc0204a0c:	00ddfdb3          	and	s11,s11,a3
ffffffffc0204a10:	00144603          	lbu	a2,1(s0)
ffffffffc0204a14:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a16:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a18:	bf35                	j	ffffffffc0204954 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0204a1a:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
ffffffffc0204a1e:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0204a22:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a24:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0204a26:	bfd9                	j	ffffffffc02049fc <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0204a28:	4705                	li	a4,1
ffffffffc0204a2a:	008a0593          	addi	a1,s4,8
ffffffffc0204a2e:	01174463          	blt	a4,a7,ffffffffc0204a36 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0204a32:	1a088e63          	beqz	a7,ffffffffc0204bee <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0204a36:	000a3603          	ld	a2,0(s4)
ffffffffc0204a3a:	46c1                	li	a3,16
ffffffffc0204a3c:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0204a3e:	2781                	sext.w	a5,a5
ffffffffc0204a40:	876e                	mv	a4,s11
ffffffffc0204a42:	85a6                	mv	a1,s1
ffffffffc0204a44:	854a                	mv	a0,s2
ffffffffc0204a46:	e37ff0ef          	jal	ra,ffffffffc020487c <printnum>
            break;
ffffffffc0204a4a:	bde1                	j	ffffffffc0204922 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0204a4c:	000a2503          	lw	a0,0(s4)
ffffffffc0204a50:	85a6                	mv	a1,s1
ffffffffc0204a52:	0a21                	addi	s4,s4,8
ffffffffc0204a54:	9902                	jalr	s2
            break;
ffffffffc0204a56:	b5f1                	j	ffffffffc0204922 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204a58:	4705                	li	a4,1
ffffffffc0204a5a:	008a0593          	addi	a1,s4,8
ffffffffc0204a5e:	01174463          	blt	a4,a7,ffffffffc0204a66 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0204a62:	18088163          	beqz	a7,ffffffffc0204be4 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0204a66:	000a3603          	ld	a2,0(s4)
ffffffffc0204a6a:	46a9                	li	a3,10
ffffffffc0204a6c:	8a2e                	mv	s4,a1
ffffffffc0204a6e:	bfc1                	j	ffffffffc0204a3e <vprintfmt+0x156>
            goto reswitch;
ffffffffc0204a70:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0204a74:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a76:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a78:	bdf1                	j	ffffffffc0204954 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0204a7a:	85a6                	mv	a1,s1
ffffffffc0204a7c:	02500513          	li	a0,37
ffffffffc0204a80:	9902                	jalr	s2
            break;
ffffffffc0204a82:	b545                	j	ffffffffc0204922 <vprintfmt+0x3a>
            lflag ++;
ffffffffc0204a84:	00144603          	lbu	a2,1(s0)
ffffffffc0204a88:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0204a8a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0204a8c:	b5e1                	j	ffffffffc0204954 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0204a8e:	4705                	li	a4,1
ffffffffc0204a90:	008a0593          	addi	a1,s4,8
ffffffffc0204a94:	01174463          	blt	a4,a7,ffffffffc0204a9c <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0204a98:	14088163          	beqz	a7,ffffffffc0204bda <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0204a9c:	000a3603          	ld	a2,0(s4)
ffffffffc0204aa0:	46a1                	li	a3,8
ffffffffc0204aa2:	8a2e                	mv	s4,a1
ffffffffc0204aa4:	bf69                	j	ffffffffc0204a3e <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0204aa6:	03000513          	li	a0,48
ffffffffc0204aaa:	85a6                	mv	a1,s1
ffffffffc0204aac:	e03e                	sd	a5,0(sp)
ffffffffc0204aae:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0204ab0:	85a6                	mv	a1,s1
ffffffffc0204ab2:	07800513          	li	a0,120
ffffffffc0204ab6:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204ab8:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0204aba:	6782                	ld	a5,0(sp)
ffffffffc0204abc:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0204abe:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0204ac2:	bfb5                	j	ffffffffc0204a3e <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204ac4:	000a3403          	ld	s0,0(s4)
ffffffffc0204ac8:	008a0713          	addi	a4,s4,8
ffffffffc0204acc:	e03a                	sd	a4,0(sp)
ffffffffc0204ace:	14040263          	beqz	s0,ffffffffc0204c12 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0204ad2:	0fb05763          	blez	s11,ffffffffc0204bc0 <vprintfmt+0x2d8>
ffffffffc0204ad6:	02d00693          	li	a3,45
ffffffffc0204ada:	0cd79163          	bne	a5,a3,ffffffffc0204b9c <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204ade:	00044783          	lbu	a5,0(s0)
ffffffffc0204ae2:	0007851b          	sext.w	a0,a5
ffffffffc0204ae6:	cf85                	beqz	a5,ffffffffc0204b1e <vprintfmt+0x236>
ffffffffc0204ae8:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204aec:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204af0:	000c4563          	bltz	s8,ffffffffc0204afa <vprintfmt+0x212>
ffffffffc0204af4:	3c7d                	addiw	s8,s8,-1
ffffffffc0204af6:	036c0263          	beq	s8,s6,ffffffffc0204b1a <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0204afa:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204afc:	0e0c8e63          	beqz	s9,ffffffffc0204bf8 <vprintfmt+0x310>
ffffffffc0204b00:	3781                	addiw	a5,a5,-32
ffffffffc0204b02:	0ef47b63          	bgeu	s0,a5,ffffffffc0204bf8 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0204b06:	03f00513          	li	a0,63
ffffffffc0204b0a:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204b0c:	000a4783          	lbu	a5,0(s4)
ffffffffc0204b10:	3dfd                	addiw	s11,s11,-1
ffffffffc0204b12:	0a05                	addi	s4,s4,1
ffffffffc0204b14:	0007851b          	sext.w	a0,a5
ffffffffc0204b18:	ffe1                	bnez	a5,ffffffffc0204af0 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0204b1a:	01b05963          	blez	s11,ffffffffc0204b2c <vprintfmt+0x244>
ffffffffc0204b1e:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0204b20:	85a6                	mv	a1,s1
ffffffffc0204b22:	02000513          	li	a0,32
ffffffffc0204b26:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0204b28:	fe0d9be3          	bnez	s11,ffffffffc0204b1e <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0204b2c:	6a02                	ld	s4,0(sp)
ffffffffc0204b2e:	bbd5                	j	ffffffffc0204922 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0204b30:	4705                	li	a4,1
ffffffffc0204b32:	008a0c93          	addi	s9,s4,8
ffffffffc0204b36:	01174463          	blt	a4,a7,ffffffffc0204b3e <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0204b3a:	08088d63          	beqz	a7,ffffffffc0204bd4 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0204b3e:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0204b42:	0a044d63          	bltz	s0,ffffffffc0204bfc <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0204b46:	8622                	mv	a2,s0
ffffffffc0204b48:	8a66                	mv	s4,s9
ffffffffc0204b4a:	46a9                	li	a3,10
ffffffffc0204b4c:	bdcd                	j	ffffffffc0204a3e <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0204b4e:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b52:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0204b54:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0204b56:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0204b5a:	8fb5                	xor	a5,a5,a3
ffffffffc0204b5c:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0204b60:	02d74163          	blt	a4,a3,ffffffffc0204b82 <vprintfmt+0x29a>
ffffffffc0204b64:	00369793          	slli	a5,a3,0x3
ffffffffc0204b68:	97de                	add	a5,a5,s7
ffffffffc0204b6a:	639c                	ld	a5,0(a5)
ffffffffc0204b6c:	cb99                	beqz	a5,ffffffffc0204b82 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0204b6e:	86be                	mv	a3,a5
ffffffffc0204b70:	00000617          	auipc	a2,0x0
ffffffffc0204b74:	13060613          	addi	a2,a2,304 # ffffffffc0204ca0 <etext+0x20>
ffffffffc0204b78:	85a6                	mv	a1,s1
ffffffffc0204b7a:	854a                	mv	a0,s2
ffffffffc0204b7c:	0ce000ef          	jal	ra,ffffffffc0204c4a <printfmt>
ffffffffc0204b80:	b34d                	j	ffffffffc0204922 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0204b82:	00002617          	auipc	a2,0x2
ffffffffc0204b86:	c2e60613          	addi	a2,a2,-978 # ffffffffc02067b0 <syscalls+0x118>
ffffffffc0204b8a:	85a6                	mv	a1,s1
ffffffffc0204b8c:	854a                	mv	a0,s2
ffffffffc0204b8e:	0bc000ef          	jal	ra,ffffffffc0204c4a <printfmt>
ffffffffc0204b92:	bb41                	j	ffffffffc0204922 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0204b94:	00002417          	auipc	s0,0x2
ffffffffc0204b98:	c1440413          	addi	s0,s0,-1004 # ffffffffc02067a8 <syscalls+0x110>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204b9c:	85e2                	mv	a1,s8
ffffffffc0204b9e:	8522                	mv	a0,s0
ffffffffc0204ba0:	e43e                	sd	a5,8(sp)
ffffffffc0204ba2:	c61ff0ef          	jal	ra,ffffffffc0204802 <strnlen>
ffffffffc0204ba6:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0204baa:	01b05b63          	blez	s11,ffffffffc0204bc0 <vprintfmt+0x2d8>
ffffffffc0204bae:	67a2                	ld	a5,8(sp)
ffffffffc0204bb0:	00078a1b          	sext.w	s4,a5
ffffffffc0204bb4:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0204bb6:	85a6                	mv	a1,s1
ffffffffc0204bb8:	8552                	mv	a0,s4
ffffffffc0204bba:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0204bbc:	fe0d9ce3          	bnez	s11,ffffffffc0204bb4 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204bc0:	00044783          	lbu	a5,0(s0)
ffffffffc0204bc4:	00140a13          	addi	s4,s0,1
ffffffffc0204bc8:	0007851b          	sext.w	a0,a5
ffffffffc0204bcc:	d3a5                	beqz	a5,ffffffffc0204b2c <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204bce:	05e00413          	li	s0,94
ffffffffc0204bd2:	bf39                	j	ffffffffc0204af0 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0204bd4:	000a2403          	lw	s0,0(s4)
ffffffffc0204bd8:	b7ad                	j	ffffffffc0204b42 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0204bda:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bde:	46a1                	li	a3,8
ffffffffc0204be0:	8a2e                	mv	s4,a1
ffffffffc0204be2:	bdb1                	j	ffffffffc0204a3e <vprintfmt+0x156>
ffffffffc0204be4:	000a6603          	lwu	a2,0(s4)
ffffffffc0204be8:	46a9                	li	a3,10
ffffffffc0204bea:	8a2e                	mv	s4,a1
ffffffffc0204bec:	bd89                	j	ffffffffc0204a3e <vprintfmt+0x156>
ffffffffc0204bee:	000a6603          	lwu	a2,0(s4)
ffffffffc0204bf2:	46c1                	li	a3,16
ffffffffc0204bf4:	8a2e                	mv	s4,a1
ffffffffc0204bf6:	b5a1                	j	ffffffffc0204a3e <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0204bf8:	9902                	jalr	s2
ffffffffc0204bfa:	bf09                	j	ffffffffc0204b0c <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0204bfc:	85a6                	mv	a1,s1
ffffffffc0204bfe:	02d00513          	li	a0,45
ffffffffc0204c02:	e03e                	sd	a5,0(sp)
ffffffffc0204c04:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0204c06:	6782                	ld	a5,0(sp)
ffffffffc0204c08:	8a66                	mv	s4,s9
ffffffffc0204c0a:	40800633          	neg	a2,s0
ffffffffc0204c0e:	46a9                	li	a3,10
ffffffffc0204c10:	b53d                	j	ffffffffc0204a3e <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0204c12:	03b05163          	blez	s11,ffffffffc0204c34 <vprintfmt+0x34c>
ffffffffc0204c16:	02d00693          	li	a3,45
ffffffffc0204c1a:	f6d79de3          	bne	a5,a3,ffffffffc0204b94 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0204c1e:	00002417          	auipc	s0,0x2
ffffffffc0204c22:	b8a40413          	addi	s0,s0,-1142 # ffffffffc02067a8 <syscalls+0x110>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0204c26:	02800793          	li	a5,40
ffffffffc0204c2a:	02800513          	li	a0,40
ffffffffc0204c2e:	00140a13          	addi	s4,s0,1
ffffffffc0204c32:	bd6d                	j	ffffffffc0204aec <vprintfmt+0x204>
ffffffffc0204c34:	00002a17          	auipc	s4,0x2
ffffffffc0204c38:	b75a0a13          	addi	s4,s4,-1163 # ffffffffc02067a9 <syscalls+0x111>
ffffffffc0204c3c:	02800513          	li	a0,40
ffffffffc0204c40:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0204c44:	05e00413          	li	s0,94
ffffffffc0204c48:	b565                	j	ffffffffc0204af0 <vprintfmt+0x208>

ffffffffc0204c4a <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c4a:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0204c4c:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c50:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c52:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0204c54:	ec06                	sd	ra,24(sp)
ffffffffc0204c56:	f83a                	sd	a4,48(sp)
ffffffffc0204c58:	fc3e                	sd	a5,56(sp)
ffffffffc0204c5a:	e0c2                	sd	a6,64(sp)
ffffffffc0204c5c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0204c5e:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0204c60:	c89ff0ef          	jal	ra,ffffffffc02048e8 <vprintfmt>
}
ffffffffc0204c64:	60e2                	ld	ra,24(sp)
ffffffffc0204c66:	6161                	addi	sp,sp,80
ffffffffc0204c68:	8082                	ret

ffffffffc0204c6a <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc0204c6a:	9e3707b7          	lui	a5,0x9e370
ffffffffc0204c6e:	2785                	addiw	a5,a5,1
ffffffffc0204c70:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0204c74:	02000793          	li	a5,32
ffffffffc0204c78:	9f8d                	subw	a5,a5,a1
}
ffffffffc0204c7a:	00f5553b          	srlw	a0,a0,a5
ffffffffc0204c7e:	8082                	ret
