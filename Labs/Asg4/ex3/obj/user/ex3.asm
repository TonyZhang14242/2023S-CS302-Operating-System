
obj/__user_ex3.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800020:	715d                	addi	sp,sp,-80
  800022:	8e2e                	mv	t3,a1
  800024:	e822                	sd	s0,16(sp)
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
    cprintf("user panic at %s:%d:\n    ", file, line);
  800026:	85aa                	mv	a1,a0
__panic(const char *file, int line, const char *fmt, ...) {
  800028:	8432                	mv	s0,a2
  80002a:	fc3e                	sd	a5,56(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  80002c:	8672                	mv	a2,t3
    va_start(ap, fmt);
  80002e:	103c                	addi	a5,sp,40
    cprintf("user panic at %s:%d:\n    ", file, line);
  800030:	00000517          	auipc	a0,0x0
  800034:	6c050513          	addi	a0,a0,1728 # 8006f0 <main+0x150>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	0fe000ef          	jal	ra,800142 <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0d6000ef          	jal	ra,800122 <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	6c050513          	addi	a0,a0,1728 # 800710 <main+0x170>
  800058:	0ea000ef          	jal	ra,800142 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	066000ef          	jal	ra,8000c4 <exit>

0000000000800062 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800062:	7175                	addi	sp,sp,-144
  800064:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  800066:	e0ba                	sd	a4,64(sp)
  800068:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80006a:	e42a                	sd	a0,8(sp)
  80006c:	ecae                	sd	a1,88(sp)
  80006e:	f0b2                	sd	a2,96(sp)
  800070:	f4b6                	sd	a3,104(sp)
  800072:	fcbe                	sd	a5,120(sp)
  800074:	e142                	sd	a6,128(sp)
  800076:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  800078:	f42e                	sd	a1,40(sp)
  80007a:	f832                	sd	a2,48(sp)
  80007c:	fc36                	sd	a3,56(sp)
  80007e:	f03a                	sd	a4,32(sp)
  800080:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800082:	4522                	lw	a0,8(sp)
  800084:	55a2                	lw	a1,40(sp)
  800086:	5642                	lw	a2,48(sp)
  800088:	56e2                	lw	a3,56(sp)
  80008a:	4706                	lw	a4,64(sp)
  80008c:	47a6                	lw	a5,72(sp)
  80008e:	00000073          	ecall
  800092:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  800094:	4572                	lw	a0,28(sp)
  800096:	6149                	addi	sp,sp,144
  800098:	8082                	ret

000000000080009a <sys_exit>:

int
sys_exit(int64_t error_code) {
  80009a:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  80009c:	4505                	li	a0,1
  80009e:	b7d1                	j	800062 <syscall>

00000000008000a0 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000a0:	4509                	li	a0,2
  8000a2:	b7c1                	j	800062 <syscall>

00000000008000a4 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000a4:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000a6:	85aa                	mv	a1,a0
  8000a8:	450d                	li	a0,3
  8000aa:	bf65                	j	800062 <syscall>

00000000008000ac <sys_kill>:
sys_yield(void) {
    return syscall(SYS_yield);
}

int
sys_kill(int64_t pid) {
  8000ac:	85aa                	mv	a1,a0
    return syscall(SYS_kill, pid);
  8000ae:	4531                	li	a0,12
  8000b0:	bf4d                	j	800062 <syscall>

00000000008000b2 <sys_getpid>:
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000b2:	4549                	li	a0,18
  8000b4:	b77d                	j	800062 <syscall>

00000000008000b6 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000b6:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000b8:	4579                	li	a0,30
  8000ba:	b765                	j	800062 <syscall>

00000000008000bc <sys_setgood>:
int
sys_gettime(void) {
    return syscall(SYS_gettime);
}

int sys_setgood(int64_t good){
  8000bc:	85aa                	mv	a1,a0
    return syscall(SYS_labschedule_set_good, good);
  8000be:	0fe00513          	li	a0,254
  8000c2:	b745                	j	800062 <syscall>

00000000008000c4 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c4:	1141                	addi	sp,sp,-16
  8000c6:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000c8:	fd3ff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000cc:	00000517          	auipc	a0,0x0
  8000d0:	64c50513          	addi	a0,a0,1612 # 800718 <main+0x178>
  8000d4:	06e000ef          	jal	ra,800142 <cprintf>
    while (1);
  8000d8:	a001                	j	8000d8 <exit+0x14>

00000000008000da <fork>:
}

int
fork(void) {
    return sys_fork();
  8000da:	b7d9                	j	8000a0 <sys_fork>

00000000008000dc <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000dc:	b7e1                	j	8000a4 <sys_wait>

00000000008000de <kill>:
    sys_yield();
}

int
kill(int pid) {
    return sys_kill(pid);
  8000de:	b7f9                	j	8000ac <sys_kill>

00000000008000e0 <getpid>:
}

int
getpid(void) {
    return sys_getpid();
  8000e0:	bfc9                	j	8000b2 <sys_getpid>

00000000008000e2 <set_good>:
unsigned int
gettime_msec(void) {
    return (unsigned int)sys_gettime();
}

unsigned int set_good(int good){
  8000e2:	1141                	addi	sp,sp,-16
  8000e4:	e022                	sd	s0,0(sp)
    cprintf("set good to %d\n", good);
  8000e6:	85aa                	mv	a1,a0
unsigned int set_good(int good){
  8000e8:	842a                	mv	s0,a0
    cprintf("set good to %d\n", good);
  8000ea:	00000517          	auipc	a0,0x0
  8000ee:	64650513          	addi	a0,a0,1606 # 800730 <main+0x190>
unsigned int set_good(int good){
  8000f2:	e406                	sd	ra,8(sp)
    cprintf("set good to %d\n", good);
  8000f4:	04e000ef          	jal	ra,800142 <cprintf>
    return (unsigned int) sys_setgood(good);
  8000f8:	8522                	mv	a0,s0
}
  8000fa:	6402                	ld	s0,0(sp)
  8000fc:	60a2                	ld	ra,8(sp)
  8000fe:	0141                	addi	sp,sp,16
    return (unsigned int) sys_setgood(good);
  800100:	bf75                	j	8000bc <sys_setgood>

0000000000800102 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800102:	076000ef          	jal	ra,800178 <umain>
1:  j 1b
  800106:	a001                	j	800106 <_start+0x4>

0000000000800108 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800108:	1141                	addi	sp,sp,-16
  80010a:	e022                	sd	s0,0(sp)
  80010c:	e406                	sd	ra,8(sp)
  80010e:	842e                	mv	s0,a1
    sys_putc(c);
  800110:	fa7ff0ef          	jal	ra,8000b6 <sys_putc>
    (*cnt) ++;
  800114:	401c                	lw	a5,0(s0)
}
  800116:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800118:	2785                	addiw	a5,a5,1
  80011a:	c01c                	sw	a5,0(s0)
}
  80011c:	6402                	ld	s0,0(sp)
  80011e:	0141                	addi	sp,sp,16
  800120:	8082                	ret

0000000000800122 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800122:	1101                	addi	sp,sp,-32
  800124:	862a                	mv	a2,a0
  800126:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800128:	00000517          	auipc	a0,0x0
  80012c:	fe050513          	addi	a0,a0,-32 # 800108 <cputch>
  800130:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800132:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  800134:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800136:	0e8000ef          	jal	ra,80021e <vprintfmt>
    return cnt;
}
  80013a:	60e2                	ld	ra,24(sp)
  80013c:	4532                	lw	a0,12(sp)
  80013e:	6105                	addi	sp,sp,32
  800140:	8082                	ret

0000000000800142 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800142:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800144:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800148:	8e2a                	mv	t3,a0
  80014a:	f42e                	sd	a1,40(sp)
  80014c:	f832                	sd	a2,48(sp)
  80014e:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800150:	00000517          	auipc	a0,0x0
  800154:	fb850513          	addi	a0,a0,-72 # 800108 <cputch>
  800158:	004c                	addi	a1,sp,4
  80015a:	869a                	mv	a3,t1
  80015c:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80015e:	ec06                	sd	ra,24(sp)
  800160:	e0ba                	sd	a4,64(sp)
  800162:	e4be                	sd	a5,72(sp)
  800164:	e8c2                	sd	a6,80(sp)
  800166:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800168:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  80016a:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80016c:	0b2000ef          	jal	ra,80021e <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  800170:	60e2                	ld	ra,24(sp)
  800172:	4512                	lw	a0,4(sp)
  800174:	6125                	addi	sp,sp,96
  800176:	8082                	ret

0000000000800178 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  800178:	1141                	addi	sp,sp,-16
  80017a:	e406                	sd	ra,8(sp)
    int ret = main();
  80017c:	424000ef          	jal	ra,8005a0 <main>
    exit(ret);
  800180:	f45ff0ef          	jal	ra,8000c4 <exit>

0000000000800184 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  800184:	872a                	mv	a4,a0
    size_t cnt = 0;
  800186:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  800188:	e589                	bnez	a1,800192 <strnlen+0xe>
  80018a:	a811                	j	80019e <strnlen+0x1a>
        cnt ++;
  80018c:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  80018e:	00a58763          	beq	a1,a0,80019c <strnlen+0x18>
  800192:	00a707b3          	add	a5,a4,a0
  800196:	0007c783          	lbu	a5,0(a5)
  80019a:	fbed                	bnez	a5,80018c <strnlen+0x8>
    }
    return cnt;
}
  80019c:	8082                	ret
  80019e:	8082                	ret

00000000008001a0 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  8001a0:	ca01                	beqz	a2,8001b0 <memset+0x10>
  8001a2:	962a                	add	a2,a2,a0
    char *p = s;
  8001a4:	87aa                	mv	a5,a0
        *p ++ = c;
  8001a6:	0785                	addi	a5,a5,1
  8001a8:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
  8001ac:	fec79de3          	bne	a5,a2,8001a6 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  8001b0:	8082                	ret

00000000008001b2 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8001b2:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8001b6:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  8001b8:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8001bc:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  8001be:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  8001c2:	f022                	sd	s0,32(sp)
  8001c4:	ec26                	sd	s1,24(sp)
  8001c6:	e84a                	sd	s2,16(sp)
  8001c8:	f406                	sd	ra,40(sp)
  8001ca:	e44e                	sd	s3,8(sp)
  8001cc:	84aa                	mv	s1,a0
  8001ce:	892e                	mv	s2,a1
  8001d0:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  8001d4:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  8001d6:	03067e63          	bgeu	a2,a6,800212 <printnum+0x60>
  8001da:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8001dc:	00805763          	blez	s0,8001ea <printnum+0x38>
  8001e0:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  8001e2:	85ca                	mv	a1,s2
  8001e4:	854e                	mv	a0,s3
  8001e6:	9482                	jalr	s1
        while (-- width > 0)
  8001e8:	fc65                	bnez	s0,8001e0 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001ea:	1a02                	slli	s4,s4,0x20
  8001ec:	020a5a13          	srli	s4,s4,0x20
  8001f0:	00000797          	auipc	a5,0x0
  8001f4:	55078793          	addi	a5,a5,1360 # 800740 <main+0x1a0>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001f8:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001fa:	9a3e                	add	s4,s4,a5
  8001fc:	000a4503          	lbu	a0,0(s4)
}
  800200:	70a2                	ld	ra,40(sp)
  800202:	69a2                	ld	s3,8(sp)
  800204:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800206:	85ca                	mv	a1,s2
  800208:	8326                	mv	t1,s1
}
  80020a:	6942                	ld	s2,16(sp)
  80020c:	64e2                	ld	s1,24(sp)
  80020e:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  800210:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  800212:	03065633          	divu	a2,a2,a6
  800216:	8722                	mv	a4,s0
  800218:	f9bff0ef          	jal	ra,8001b2 <printnum>
  80021c:	b7f9                	j	8001ea <printnum+0x38>

000000000080021e <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  80021e:	7119                	addi	sp,sp,-128
  800220:	f4a6                	sd	s1,104(sp)
  800222:	f0ca                	sd	s2,96(sp)
  800224:	ecce                	sd	s3,88(sp)
  800226:	e8d2                	sd	s4,80(sp)
  800228:	e4d6                	sd	s5,72(sp)
  80022a:	e0da                	sd	s6,64(sp)
  80022c:	fc5e                	sd	s7,56(sp)
  80022e:	f06a                	sd	s10,32(sp)
  800230:	fc86                	sd	ra,120(sp)
  800232:	f8a2                	sd	s0,112(sp)
  800234:	f862                	sd	s8,48(sp)
  800236:	f466                	sd	s9,40(sp)
  800238:	ec6e                	sd	s11,24(sp)
  80023a:	892a                	mv	s2,a0
  80023c:	84ae                	mv	s1,a1
  80023e:	8d32                	mv	s10,a2
  800240:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800242:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800246:	5b7d                	li	s6,-1
  800248:	00000a97          	auipc	s5,0x0
  80024c:	52ca8a93          	addi	s5,s5,1324 # 800774 <main+0x1d4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800250:	00000b97          	auipc	s7,0x0
  800254:	740b8b93          	addi	s7,s7,1856 # 800990 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800258:	000d4503          	lbu	a0,0(s10)
  80025c:	001d0413          	addi	s0,s10,1
  800260:	01350a63          	beq	a0,s3,800274 <vprintfmt+0x56>
            if (ch == '\0') {
  800264:	c121                	beqz	a0,8002a4 <vprintfmt+0x86>
            putch(ch, putdat);
  800266:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800268:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  80026a:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80026c:	fff44503          	lbu	a0,-1(s0)
  800270:	ff351ae3          	bne	a0,s3,800264 <vprintfmt+0x46>
  800274:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  800278:	02000793          	li	a5,32
        lflag = altflag = 0;
  80027c:	4c81                	li	s9,0
  80027e:	4881                	li	a7,0
        width = precision = -1;
  800280:	5c7d                	li	s8,-1
  800282:	5dfd                	li	s11,-1
  800284:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  800288:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  80028a:	fdd6059b          	addiw	a1,a2,-35
  80028e:	0ff5f593          	andi	a1,a1,255
  800292:	00140d13          	addi	s10,s0,1
  800296:	04b56263          	bltu	a0,a1,8002da <vprintfmt+0xbc>
  80029a:	058a                	slli	a1,a1,0x2
  80029c:	95d6                	add	a1,a1,s5
  80029e:	4194                	lw	a3,0(a1)
  8002a0:	96d6                	add	a3,a3,s5
  8002a2:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8002a4:	70e6                	ld	ra,120(sp)
  8002a6:	7446                	ld	s0,112(sp)
  8002a8:	74a6                	ld	s1,104(sp)
  8002aa:	7906                	ld	s2,96(sp)
  8002ac:	69e6                	ld	s3,88(sp)
  8002ae:	6a46                	ld	s4,80(sp)
  8002b0:	6aa6                	ld	s5,72(sp)
  8002b2:	6b06                	ld	s6,64(sp)
  8002b4:	7be2                	ld	s7,56(sp)
  8002b6:	7c42                	ld	s8,48(sp)
  8002b8:	7ca2                	ld	s9,40(sp)
  8002ba:	7d02                	ld	s10,32(sp)
  8002bc:	6de2                	ld	s11,24(sp)
  8002be:	6109                	addi	sp,sp,128
  8002c0:	8082                	ret
            padc = '0';
  8002c2:	87b2                	mv	a5,a2
            goto reswitch;
  8002c4:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002c8:	846a                	mv	s0,s10
  8002ca:	00140d13          	addi	s10,s0,1
  8002ce:	fdd6059b          	addiw	a1,a2,-35
  8002d2:	0ff5f593          	andi	a1,a1,255
  8002d6:	fcb572e3          	bgeu	a0,a1,80029a <vprintfmt+0x7c>
            putch('%', putdat);
  8002da:	85a6                	mv	a1,s1
  8002dc:	02500513          	li	a0,37
  8002e0:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  8002e2:	fff44783          	lbu	a5,-1(s0)
  8002e6:	8d22                	mv	s10,s0
  8002e8:	f73788e3          	beq	a5,s3,800258 <vprintfmt+0x3a>
  8002ec:	ffed4783          	lbu	a5,-2(s10)
  8002f0:	1d7d                	addi	s10,s10,-1
  8002f2:	ff379de3          	bne	a5,s3,8002ec <vprintfmt+0xce>
  8002f6:	b78d                	j	800258 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002f8:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002fc:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800300:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800302:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800306:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80030a:	02d86463          	bltu	a6,a3,800332 <vprintfmt+0x114>
                ch = *fmt;
  80030e:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800312:	002c169b          	slliw	a3,s8,0x2
  800316:	0186873b          	addw	a4,a3,s8
  80031a:	0017171b          	slliw	a4,a4,0x1
  80031e:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800320:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800324:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800326:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  80032a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80032e:	fed870e3          	bgeu	a6,a3,80030e <vprintfmt+0xf0>
            if (width < 0)
  800332:	f40ddce3          	bgez	s11,80028a <vprintfmt+0x6c>
                width = precision, precision = -1;
  800336:	8de2                	mv	s11,s8
  800338:	5c7d                	li	s8,-1
  80033a:	bf81                	j	80028a <vprintfmt+0x6c>
            if (width < 0)
  80033c:	fffdc693          	not	a3,s11
  800340:	96fd                	srai	a3,a3,0x3f
  800342:	00ddfdb3          	and	s11,s11,a3
  800346:	00144603          	lbu	a2,1(s0)
  80034a:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  80034c:	846a                	mv	s0,s10
            goto reswitch;
  80034e:	bf35                	j	80028a <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800350:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  800354:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  800358:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  80035a:	846a                	mv	s0,s10
            goto process_precision;
  80035c:	bfd9                	j	800332 <vprintfmt+0x114>
    if (lflag >= 2) {
  80035e:	4705                	li	a4,1
  800360:	008a0593          	addi	a1,s4,8
  800364:	01174463          	blt	a4,a7,80036c <vprintfmt+0x14e>
    else if (lflag) {
  800368:	1a088e63          	beqz	a7,800524 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  80036c:	000a3603          	ld	a2,0(s4)
  800370:	46c1                	li	a3,16
  800372:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  800374:	2781                	sext.w	a5,a5
  800376:	876e                	mv	a4,s11
  800378:	85a6                	mv	a1,s1
  80037a:	854a                	mv	a0,s2
  80037c:	e37ff0ef          	jal	ra,8001b2 <printnum>
            break;
  800380:	bde1                	j	800258 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800382:	000a2503          	lw	a0,0(s4)
  800386:	85a6                	mv	a1,s1
  800388:	0a21                	addi	s4,s4,8
  80038a:	9902                	jalr	s2
            break;
  80038c:	b5f1                	j	800258 <vprintfmt+0x3a>
    if (lflag >= 2) {
  80038e:	4705                	li	a4,1
  800390:	008a0593          	addi	a1,s4,8
  800394:	01174463          	blt	a4,a7,80039c <vprintfmt+0x17e>
    else if (lflag) {
  800398:	18088163          	beqz	a7,80051a <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  80039c:	000a3603          	ld	a2,0(s4)
  8003a0:	46a9                	li	a3,10
  8003a2:	8a2e                	mv	s4,a1
  8003a4:	bfc1                	j	800374 <vprintfmt+0x156>
            goto reswitch;
  8003a6:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8003aa:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003ac:	846a                	mv	s0,s10
            goto reswitch;
  8003ae:	bdf1                	j	80028a <vprintfmt+0x6c>
            putch(ch, putdat);
  8003b0:	85a6                	mv	a1,s1
  8003b2:	02500513          	li	a0,37
  8003b6:	9902                	jalr	s2
            break;
  8003b8:	b545                	j	800258 <vprintfmt+0x3a>
            lflag ++;
  8003ba:	00144603          	lbu	a2,1(s0)
  8003be:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  8003c0:	846a                	mv	s0,s10
            goto reswitch;
  8003c2:	b5e1                	j	80028a <vprintfmt+0x6c>
    if (lflag >= 2) {
  8003c4:	4705                	li	a4,1
  8003c6:	008a0593          	addi	a1,s4,8
  8003ca:	01174463          	blt	a4,a7,8003d2 <vprintfmt+0x1b4>
    else if (lflag) {
  8003ce:	14088163          	beqz	a7,800510 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  8003d2:	000a3603          	ld	a2,0(s4)
  8003d6:	46a1                	li	a3,8
  8003d8:	8a2e                	mv	s4,a1
  8003da:	bf69                	j	800374 <vprintfmt+0x156>
            putch('0', putdat);
  8003dc:	03000513          	li	a0,48
  8003e0:	85a6                	mv	a1,s1
  8003e2:	e03e                	sd	a5,0(sp)
  8003e4:	9902                	jalr	s2
            putch('x', putdat);
  8003e6:	85a6                	mv	a1,s1
  8003e8:	07800513          	li	a0,120
  8003ec:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003ee:	0a21                	addi	s4,s4,8
            goto number;
  8003f0:	6782                	ld	a5,0(sp)
  8003f2:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003f4:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003f8:	bfb5                	j	800374 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003fa:	000a3403          	ld	s0,0(s4)
  8003fe:	008a0713          	addi	a4,s4,8
  800402:	e03a                	sd	a4,0(sp)
  800404:	14040263          	beqz	s0,800548 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800408:	0fb05763          	blez	s11,8004f6 <vprintfmt+0x2d8>
  80040c:	02d00693          	li	a3,45
  800410:	0cd79163          	bne	a5,a3,8004d2 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800414:	00044783          	lbu	a5,0(s0)
  800418:	0007851b          	sext.w	a0,a5
  80041c:	cf85                	beqz	a5,800454 <vprintfmt+0x236>
  80041e:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800422:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800426:	000c4563          	bltz	s8,800430 <vprintfmt+0x212>
  80042a:	3c7d                	addiw	s8,s8,-1
  80042c:	036c0263          	beq	s8,s6,800450 <vprintfmt+0x232>
                    putch('?', putdat);
  800430:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800432:	0e0c8e63          	beqz	s9,80052e <vprintfmt+0x310>
  800436:	3781                	addiw	a5,a5,-32
  800438:	0ef47b63          	bgeu	s0,a5,80052e <vprintfmt+0x310>
                    putch('?', putdat);
  80043c:	03f00513          	li	a0,63
  800440:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800442:	000a4783          	lbu	a5,0(s4)
  800446:	3dfd                	addiw	s11,s11,-1
  800448:	0a05                	addi	s4,s4,1
  80044a:	0007851b          	sext.w	a0,a5
  80044e:	ffe1                	bnez	a5,800426 <vprintfmt+0x208>
            for (; width > 0; width --) {
  800450:	01b05963          	blez	s11,800462 <vprintfmt+0x244>
  800454:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  800456:	85a6                	mv	a1,s1
  800458:	02000513          	li	a0,32
  80045c:	9902                	jalr	s2
            for (; width > 0; width --) {
  80045e:	fe0d9be3          	bnez	s11,800454 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800462:	6a02                	ld	s4,0(sp)
  800464:	bbd5                	j	800258 <vprintfmt+0x3a>
    if (lflag >= 2) {
  800466:	4705                	li	a4,1
  800468:	008a0c93          	addi	s9,s4,8
  80046c:	01174463          	blt	a4,a7,800474 <vprintfmt+0x256>
    else if (lflag) {
  800470:	08088d63          	beqz	a7,80050a <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  800474:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  800478:	0a044d63          	bltz	s0,800532 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  80047c:	8622                	mv	a2,s0
  80047e:	8a66                	mv	s4,s9
  800480:	46a9                	li	a3,10
  800482:	bdcd                	j	800374 <vprintfmt+0x156>
            err = va_arg(ap, int);
  800484:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800488:	4761                	li	a4,24
            err = va_arg(ap, int);
  80048a:	0a21                	addi	s4,s4,8
            if (err < 0) {
  80048c:	41f7d69b          	sraiw	a3,a5,0x1f
  800490:	8fb5                	xor	a5,a5,a3
  800492:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800496:	02d74163          	blt	a4,a3,8004b8 <vprintfmt+0x29a>
  80049a:	00369793          	slli	a5,a3,0x3
  80049e:	97de                	add	a5,a5,s7
  8004a0:	639c                	ld	a5,0(a5)
  8004a2:	cb99                	beqz	a5,8004b8 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8004a4:	86be                	mv	a3,a5
  8004a6:	00000617          	auipc	a2,0x0
  8004aa:	2ca60613          	addi	a2,a2,714 # 800770 <main+0x1d0>
  8004ae:	85a6                	mv	a1,s1
  8004b0:	854a                	mv	a0,s2
  8004b2:	0ce000ef          	jal	ra,800580 <printfmt>
  8004b6:	b34d                	j	800258 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  8004b8:	00000617          	auipc	a2,0x0
  8004bc:	2a860613          	addi	a2,a2,680 # 800760 <main+0x1c0>
  8004c0:	85a6                	mv	a1,s1
  8004c2:	854a                	mv	a0,s2
  8004c4:	0bc000ef          	jal	ra,800580 <printfmt>
  8004c8:	bb41                	j	800258 <vprintfmt+0x3a>
                p = "(null)";
  8004ca:	00000417          	auipc	s0,0x0
  8004ce:	28e40413          	addi	s0,s0,654 # 800758 <main+0x1b8>
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004d2:	85e2                	mv	a1,s8
  8004d4:	8522                	mv	a0,s0
  8004d6:	e43e                	sd	a5,8(sp)
  8004d8:	cadff0ef          	jal	ra,800184 <strnlen>
  8004dc:	40ad8dbb          	subw	s11,s11,a0
  8004e0:	01b05b63          	blez	s11,8004f6 <vprintfmt+0x2d8>
  8004e4:	67a2                	ld	a5,8(sp)
  8004e6:	00078a1b          	sext.w	s4,a5
  8004ea:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004ec:	85a6                	mv	a1,s1
  8004ee:	8552                	mv	a0,s4
  8004f0:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004f2:	fe0d9ce3          	bnez	s11,8004ea <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004f6:	00044783          	lbu	a5,0(s0)
  8004fa:	00140a13          	addi	s4,s0,1
  8004fe:	0007851b          	sext.w	a0,a5
  800502:	d3a5                	beqz	a5,800462 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800504:	05e00413          	li	s0,94
  800508:	bf39                	j	800426 <vprintfmt+0x208>
        return va_arg(*ap, int);
  80050a:	000a2403          	lw	s0,0(s4)
  80050e:	b7ad                	j	800478 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  800510:	000a6603          	lwu	a2,0(s4)
  800514:	46a1                	li	a3,8
  800516:	8a2e                	mv	s4,a1
  800518:	bdb1                	j	800374 <vprintfmt+0x156>
  80051a:	000a6603          	lwu	a2,0(s4)
  80051e:	46a9                	li	a3,10
  800520:	8a2e                	mv	s4,a1
  800522:	bd89                	j	800374 <vprintfmt+0x156>
  800524:	000a6603          	lwu	a2,0(s4)
  800528:	46c1                	li	a3,16
  80052a:	8a2e                	mv	s4,a1
  80052c:	b5a1                	j	800374 <vprintfmt+0x156>
                    putch(ch, putdat);
  80052e:	9902                	jalr	s2
  800530:	bf09                	j	800442 <vprintfmt+0x224>
                putch('-', putdat);
  800532:	85a6                	mv	a1,s1
  800534:	02d00513          	li	a0,45
  800538:	e03e                	sd	a5,0(sp)
  80053a:	9902                	jalr	s2
                num = -(long long)num;
  80053c:	6782                	ld	a5,0(sp)
  80053e:	8a66                	mv	s4,s9
  800540:	40800633          	neg	a2,s0
  800544:	46a9                	li	a3,10
  800546:	b53d                	j	800374 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800548:	03b05163          	blez	s11,80056a <vprintfmt+0x34c>
  80054c:	02d00693          	li	a3,45
  800550:	f6d79de3          	bne	a5,a3,8004ca <vprintfmt+0x2ac>
                p = "(null)";
  800554:	00000417          	auipc	s0,0x0
  800558:	20440413          	addi	s0,s0,516 # 800758 <main+0x1b8>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80055c:	02800793          	li	a5,40
  800560:	02800513          	li	a0,40
  800564:	00140a13          	addi	s4,s0,1
  800568:	bd6d                	j	800422 <vprintfmt+0x204>
  80056a:	00000a17          	auipc	s4,0x0
  80056e:	1efa0a13          	addi	s4,s4,495 # 800759 <main+0x1b9>
  800572:	02800513          	li	a0,40
  800576:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  80057a:	05e00413          	li	s0,94
  80057e:	b565                	j	800426 <vprintfmt+0x208>

0000000000800580 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800580:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800582:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800586:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800588:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80058a:	ec06                	sd	ra,24(sp)
  80058c:	f83a                	sd	a4,48(sp)
  80058e:	fc3e                	sd	a5,56(sp)
  800590:	e0c2                	sd	a6,64(sp)
  800592:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800594:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800596:	c89ff0ef          	jal	ra,80021e <vprintfmt>
}
  80059a:	60e2                	ld	ra,24(sp)
  80059c:	6161                	addi	sp,sp,80
  80059e:	8082                	ret

00000000008005a0 <main>:
          j = !j;
     }
}

int
main(void) {
  8005a0:	711d                	addi	sp,sp,-96
     //open this
     
     int i,time;
     memset(pids, 0, sizeof(pids));
  8005a2:	4651                	li	a2,20
  8005a4:	4581                	li	a1,0
  8005a6:	00001517          	auipc	a0,0x1
  8005aa:	a8a50513          	addi	a0,a0,-1398 # 801030 <pids>
main(void) {
  8005ae:	e8a2                	sd	s0,80(sp)
  8005b0:	e4a6                	sd	s1,72(sp)
  8005b2:	e0ca                	sd	s2,64(sp)
  8005b4:	fc4e                	sd	s3,56(sp)
  8005b6:	f852                	sd	s4,48(sp)
  8005b8:	f456                	sd	s5,40(sp)
  8005ba:	ec86                	sd	ra,88(sp)
     memset(pids, 0, sizeof(pids));
  8005bc:	be5ff0ef          	jal	ra,8001a0 <memset>
     int goods[TOTAL]= {3,1,4,5,2};
  8005c0:	4795                	li	a5,5
  8005c2:	4705                	li	a4,1
  8005c4:	1782                	slli	a5,a5,0x20
  8005c6:	0791                	addi	a5,a5,4
  8005c8:	1702                	slli	a4,a4,0x20
  8005ca:	00001a17          	auipc	s4,0x1
  8005ce:	a36a0a13          	addi	s4,s4,-1482 # 801000 <acc>
  8005d2:	00001497          	auipc	s1,0x1
  8005d6:	a5e48493          	addi	s1,s1,-1442 # 801030 <pids>
  8005da:	070d                	addi	a4,a4,3
  8005dc:	e83e                	sd	a5,16(sp)
  8005de:	4789                	li	a5,2
  8005e0:	e43a                	sd	a4,8(sp)
  8005e2:	cc3e                	sw	a5,24(sp)
     for (i = 0; i < TOTAL; i ++) {
  8005e4:	89d2                	mv	s3,s4
     int goods[TOTAL]= {3,1,4,5,2};
  8005e6:	8926                	mv	s2,s1
     for (i = 0; i < TOTAL; i ++) {
  8005e8:	4401                	li	s0,0
  8005ea:	4a95                	li	s5,5
          acc[i]=0;
  8005ec:	0009a023          	sw	zero,0(s3)
          if ((pids[i] = fork()) == 0) {
  8005f0:	aebff0ef          	jal	ra,8000da <fork>
  8005f4:	00a92023          	sw	a0,0(s2)
  8005f8:	c125                	beqz	a0,800658 <main+0xb8>
                         exit(acc[i]);
                    }

               }
          }
          if (pids[i] < 0) {
  8005fa:	0c054263          	bltz	a0,8006be <main+0x11e>
     for (i = 0; i < TOTAL; i ++) {
  8005fe:	2405                	addiw	s0,s0,1
  800600:	0991                	addi	s3,s3,4
  800602:	0911                	addi	s2,s2,4
  800604:	ff5414e3          	bne	s0,s5,8005ec <main+0x4c>
               goto failed;
          }
     }
     cprintf("main: fork ok,now need to wait pids.\n");
  800608:	00000517          	auipc	a0,0x0
  80060c:	46850513          	addi	a0,a0,1128 # 800a70 <error_string+0xe0>
  800610:	b33ff0ef          	jal	ra,800142 <cprintf>

     for (i = 0; i < TOTAL; i ++) {
  800614:	00001417          	auipc	s0,0x1
  800618:	a0440413          	addi	s0,s0,-1532 # 801018 <status>
  80061c:	00001917          	auipc	s2,0x1
  800620:	a1090913          	addi	s2,s2,-1520 # 80102c <status+0x14>
         status[i]=0;
         waitpid(pids[i],&status[i]);
  800624:	4088                	lw	a0,0(s1)
         status[i]=0;
  800626:	00042023          	sw	zero,0(s0)
         waitpid(pids[i],&status[i]);
  80062a:	85a2                	mv	a1,s0
  80062c:	0411                	addi	s0,s0,4
  80062e:	aafff0ef          	jal	ra,8000dc <waitpid>
     for (i = 0; i < TOTAL; i ++) {
  800632:	0491                	addi	s1,s1,4
  800634:	ff2418e3          	bne	s0,s2,800624 <main+0x84>
     }
     cprintf("main: wait pids over\n");
  800638:	00000517          	auipc	a0,0x0
  80063c:	46050513          	addi	a0,a0,1120 # 800a98 <error_string+0x108>
  800640:	b03ff0ef          	jal	ra,800142 <cprintf>
               kill(pids[i]);
          }
     }
     panic("FAIL: T.T\n");
     
}
  800644:	60e6                	ld	ra,88(sp)
  800646:	6446                	ld	s0,80(sp)
  800648:	64a6                	ld	s1,72(sp)
  80064a:	6906                	ld	s2,64(sp)
  80064c:	79e2                	ld	s3,56(sp)
  80064e:	7a42                	ld	s4,48(sp)
  800650:	7aa2                	ld	s5,40(sp)
  800652:	4501                	li	a0,0
  800654:	6125                	addi	sp,sp,96
  800656:	8082                	ret
               acc[i] = 0;
  800658:	040a                	slli	s0,s0,0x2
  80065a:	008a04b3          	add	s1,s4,s0
                    if(acc[i]==200000){
  80065e:	000319b7          	lui	s3,0x31
                         set_good(goods[i]);
  800662:	101c                	addi	a5,sp,32
                    if(acc[i]>4000000) {
  800664:	003d1937          	lui	s2,0x3d1
               acc[i] = 0;
  800668:	0004a023          	sw	zero,0(s1)
                    if(acc[i]==200000){
  80066c:	d4098993          	addi	s3,s3,-704 # 30d40 <__panic-0x7cf2e0>
                         set_good(goods[i]);
  800670:	943e                	add	s0,s0,a5
                    if(acc[i]>4000000) {
  800672:	90090913          	addi	s2,s2,-1792 # 3d0900 <__panic-0x42f720>
     for (i = 0; i < TOTAL; i ++) {
  800676:	0c800713          	li	a4,200
          j = !j;
  80067a:	4792                	lw	a5,4(sp)
  80067c:	377d                	addiw	a4,a4,-1
  80067e:	2781                	sext.w	a5,a5
  800680:	0017b793          	seqz	a5,a5
  800684:	c23e                	sw	a5,4(sp)
     for (i = 0; i != 200; ++ i)
  800686:	fb75                	bnez	a4,80067a <main+0xda>
                    ++ acc[i];
  800688:	409c                	lw	a5,0(s1)
  80068a:	0017871b          	addiw	a4,a5,1
  80068e:	c098                	sw	a4,0(s1)
                    if(acc[i]==200000){
  800690:	03370263          	beq	a4,s3,8006b4 <main+0x114>
                    if(acc[i]>4000000) {
  800694:	409c                	lw	a5,0(s1)
  800696:	fef970e3          	bgeu	s2,a5,800676 <main+0xd6>
                         cprintf("child pid %d, acc %d\n",getpid(),acc[i]);
  80069a:	a47ff0ef          	jal	ra,8000e0 <getpid>
  80069e:	4090                	lw	a2,0(s1)
  8006a0:	85aa                	mv	a1,a0
  8006a2:	00000517          	auipc	a0,0x0
  8006a6:	3b650513          	addi	a0,a0,950 # 800a58 <error_string+0xc8>
  8006aa:	a99ff0ef          	jal	ra,800142 <cprintf>
                         exit(acc[i]);
  8006ae:	4088                	lw	a0,0(s1)
  8006b0:	a15ff0ef          	jal	ra,8000c4 <exit>
                         set_good(goods[i]);
  8006b4:	fe842503          	lw	a0,-24(s0)
  8006b8:	a2bff0ef          	jal	ra,8000e2 <set_good>
  8006bc:	bfe1                	j	800694 <main+0xf4>
  8006be:	00001417          	auipc	s0,0x1
  8006c2:	98640413          	addi	s0,s0,-1658 # 801044 <pids+0x14>
          if (pids[i] > 0) {
  8006c6:	4088                	lw	a0,0(s1)
  8006c8:	00a05463          	blez	a0,8006d0 <main+0x130>
               kill(pids[i]);
  8006cc:	a13ff0ef          	jal	ra,8000de <kill>
     for (i = 0; i < TOTAL; i ++) {
  8006d0:	0491                	addi	s1,s1,4
  8006d2:	fe849ae3          	bne	s1,s0,8006c6 <main+0x126>
     panic("FAIL: T.T\n");
  8006d6:	00000617          	auipc	a2,0x0
  8006da:	3da60613          	addi	a2,a2,986 # 800ab0 <error_string+0x120>
  8006de:	04600593          	li	a1,70
  8006e2:	00000517          	auipc	a0,0x0
  8006e6:	3de50513          	addi	a0,a0,990 # 800ac0 <error_string+0x130>
  8006ea:	937ff0ef          	jal	ra,800020 <__panic>
