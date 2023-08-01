
obj/__user_rr.out:     file format elf64-littleriscv


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
  800034:	68050513          	addi	a0,a0,1664 # 8006b0 <main+0x132>
__panic(const char *file, int line, const char *fmt, ...) {
  800038:	ec06                	sd	ra,24(sp)
  80003a:	f436                	sd	a3,40(sp)
  80003c:	f83a                	sd	a4,48(sp)
  80003e:	e0c2                	sd	a6,64(sp)
  800040:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800042:	e43e                	sd	a5,8(sp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800044:	0dc000ef          	jal	ra,800120 <cprintf>
    vcprintf(fmt, ap);
  800048:	65a2                	ld	a1,8(sp)
  80004a:	8522                	mv	a0,s0
  80004c:	0b4000ef          	jal	ra,800100 <vcprintf>
    cprintf("\n");
  800050:	00000517          	auipc	a0,0x0
  800054:	68050513          	addi	a0,a0,1664 # 8006d0 <main+0x152>
  800058:	0c8000ef          	jal	ra,800120 <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  80005c:	5559                	li	a0,-10
  80005e:	062000ef          	jal	ra,8000c0 <exit>

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

00000000008000bc <sys_gettime>:
}

int
sys_gettime(void) {
    return syscall(SYS_gettime);
  8000bc:	4545                	li	a0,17
  8000be:	b755                	j	800062 <syscall>

00000000008000c0 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c0:	1141                	addi	sp,sp,-16
  8000c2:	e406                	sd	ra,8(sp)
    //cprintf("eee\n");
    sys_exit(error_code);
  8000c4:	fd7ff0ef          	jal	ra,80009a <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000c8:	00000517          	auipc	a0,0x0
  8000cc:	61050513          	addi	a0,a0,1552 # 8006d8 <main+0x15a>
  8000d0:	050000ef          	jal	ra,800120 <cprintf>
    while (1);
  8000d4:	a001                	j	8000d4 <exit+0x14>

00000000008000d6 <fork>:
}

int
fork(void) {
    return sys_fork();
  8000d6:	b7e9                	j	8000a0 <sys_fork>

00000000008000d8 <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000d8:	b7f1                	j	8000a4 <sys_wait>

00000000008000da <kill>:
    sys_yield();
}

int
kill(int pid) {
    return sys_kill(pid);
  8000da:	bfc9                	j	8000ac <sys_kill>

00000000008000dc <getpid>:
}

int
getpid(void) {
    return sys_getpid();
  8000dc:	bfd9                	j	8000b2 <sys_getpid>

00000000008000de <gettime_msec>:
}

unsigned int
gettime_msec(void) {
    return (unsigned int)sys_gettime();
  8000de:	bff9                	j	8000bc <sys_gettime>

00000000008000e0 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  8000e0:	076000ef          	jal	ra,800156 <umain>
1:  j 1b
  8000e4:	a001                	j	8000e4 <_start+0x4>

00000000008000e6 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  8000e6:	1141                	addi	sp,sp,-16
  8000e8:	e022                	sd	s0,0(sp)
  8000ea:	e406                	sd	ra,8(sp)
  8000ec:	842e                	mv	s0,a1
    sys_putc(c);
  8000ee:	fc9ff0ef          	jal	ra,8000b6 <sys_putc>
    (*cnt) ++;
  8000f2:	401c                	lw	a5,0(s0)
}
  8000f4:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  8000f6:	2785                	addiw	a5,a5,1
  8000f8:	c01c                	sw	a5,0(s0)
}
  8000fa:	6402                	ld	s0,0(sp)
  8000fc:	0141                	addi	sp,sp,16
  8000fe:	8082                	ret

0000000000800100 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800100:	1101                	addi	sp,sp,-32
  800102:	862a                	mv	a2,a0
  800104:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800106:	00000517          	auipc	a0,0x0
  80010a:	fe050513          	addi	a0,a0,-32 # 8000e6 <cputch>
  80010e:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
  800110:	ec06                	sd	ra,24(sp)
    int cnt = 0;
  800112:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  800114:	0e8000ef          	jal	ra,8001fc <vprintfmt>
    return cnt;
}
  800118:	60e2                	ld	ra,24(sp)
  80011a:	4532                	lw	a0,12(sp)
  80011c:	6105                	addi	sp,sp,32
  80011e:	8082                	ret

0000000000800120 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800120:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800122:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800126:	8e2a                	mv	t3,a0
  800128:	f42e                	sd	a1,40(sp)
  80012a:	f832                	sd	a2,48(sp)
  80012c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80012e:	00000517          	auipc	a0,0x0
  800132:	fb850513          	addi	a0,a0,-72 # 8000e6 <cputch>
  800136:	004c                	addi	a1,sp,4
  800138:	869a                	mv	a3,t1
  80013a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80013c:	ec06                	sd	ra,24(sp)
  80013e:	e0ba                	sd	a4,64(sp)
  800140:	e4be                	sd	a5,72(sp)
  800142:	e8c2                	sd	a6,80(sp)
  800144:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800146:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800148:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80014a:	0b2000ef          	jal	ra,8001fc <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80014e:	60e2                	ld	ra,24(sp)
  800150:	4512                	lw	a0,4(sp)
  800152:	6125                	addi	sp,sp,96
  800154:	8082                	ret

0000000000800156 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  800156:	1141                	addi	sp,sp,-16
  800158:	e406                	sd	ra,8(sp)
    int ret = main();
  80015a:	424000ef          	jal	ra,80057e <main>
    exit(ret);
  80015e:	f63ff0ef          	jal	ra,8000c0 <exit>

0000000000800162 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  800162:	872a                	mv	a4,a0
    size_t cnt = 0;
  800164:	4501                	li	a0,0
    while (cnt < len && *s ++ != '\0') {
  800166:	e589                	bnez	a1,800170 <strnlen+0xe>
  800168:	a811                	j	80017c <strnlen+0x1a>
        cnt ++;
  80016a:	0505                	addi	a0,a0,1
    while (cnt < len && *s ++ != '\0') {
  80016c:	00a58763          	beq	a1,a0,80017a <strnlen+0x18>
  800170:	00a707b3          	add	a5,a4,a0
  800174:	0007c783          	lbu	a5,0(a5)
  800178:	fbed                	bnez	a5,80016a <strnlen+0x8>
    }
    return cnt;
}
  80017a:	8082                	ret
  80017c:	8082                	ret

000000000080017e <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  80017e:	ca01                	beqz	a2,80018e <memset+0x10>
  800180:	962a                	add	a2,a2,a0
    char *p = s;
  800182:	87aa                	mv	a5,a0
        *p ++ = c;
  800184:	0785                	addi	a5,a5,1
  800186:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
  80018a:	fec79de3          	bne	a5,a2,800184 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  80018e:	8082                	ret

0000000000800190 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800190:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800194:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800196:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80019a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  80019c:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  8001a0:	f022                	sd	s0,32(sp)
  8001a2:	ec26                	sd	s1,24(sp)
  8001a4:	e84a                	sd	s2,16(sp)
  8001a6:	f406                	sd	ra,40(sp)
  8001a8:	e44e                	sd	s3,8(sp)
  8001aa:	84aa                	mv	s1,a0
  8001ac:	892e                	mv	s2,a1
  8001ae:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  8001b2:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  8001b4:	03067e63          	bgeu	a2,a6,8001f0 <printnum+0x60>
  8001b8:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8001ba:	00805763          	blez	s0,8001c8 <printnum+0x38>
  8001be:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  8001c0:	85ca                	mv	a1,s2
  8001c2:	854e                	mv	a0,s3
  8001c4:	9482                	jalr	s1
        while (-- width > 0)
  8001c6:	fc65                	bnez	s0,8001be <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8001c8:	1a02                	slli	s4,s4,0x20
  8001ca:	020a5a13          	srli	s4,s4,0x20
  8001ce:	00000797          	auipc	a5,0x0
  8001d2:	52278793          	addi	a5,a5,1314 # 8006f0 <main+0x172>
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  8001d6:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001d8:	9a3e                	add	s4,s4,a5
  8001da:	000a4503          	lbu	a0,0(s4)
}
  8001de:	70a2                	ld	ra,40(sp)
  8001e0:	69a2                	ld	s3,8(sp)
  8001e2:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  8001e4:	85ca                	mv	a1,s2
  8001e6:	8326                	mv	t1,s1
}
  8001e8:	6942                	ld	s2,16(sp)
  8001ea:	64e2                	ld	s1,24(sp)
  8001ec:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  8001ee:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
  8001f0:	03065633          	divu	a2,a2,a6
  8001f4:	8722                	mv	a4,s0
  8001f6:	f9bff0ef          	jal	ra,800190 <printnum>
  8001fa:	b7f9                	j	8001c8 <printnum+0x38>

00000000008001fc <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  8001fc:	7119                	addi	sp,sp,-128
  8001fe:	f4a6                	sd	s1,104(sp)
  800200:	f0ca                	sd	s2,96(sp)
  800202:	ecce                	sd	s3,88(sp)
  800204:	e8d2                	sd	s4,80(sp)
  800206:	e4d6                	sd	s5,72(sp)
  800208:	e0da                	sd	s6,64(sp)
  80020a:	fc5e                	sd	s7,56(sp)
  80020c:	f06a                	sd	s10,32(sp)
  80020e:	fc86                	sd	ra,120(sp)
  800210:	f8a2                	sd	s0,112(sp)
  800212:	f862                	sd	s8,48(sp)
  800214:	f466                	sd	s9,40(sp)
  800216:	ec6e                	sd	s11,24(sp)
  800218:	892a                	mv	s2,a0
  80021a:	84ae                	mv	s1,a1
  80021c:	8d32                	mv	s10,a2
  80021e:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800220:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800224:	5b7d                	li	s6,-1
  800226:	00000a97          	auipc	s5,0x0
  80022a:	4fea8a93          	addi	s5,s5,1278 # 800724 <main+0x1a6>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80022e:	00000b97          	auipc	s7,0x0
  800232:	712b8b93          	addi	s7,s7,1810 # 800940 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800236:	000d4503          	lbu	a0,0(s10)
  80023a:	001d0413          	addi	s0,s10,1
  80023e:	01350a63          	beq	a0,s3,800252 <vprintfmt+0x56>
            if (ch == '\0') {
  800242:	c121                	beqz	a0,800282 <vprintfmt+0x86>
            putch(ch, putdat);
  800244:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800246:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  800248:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80024a:	fff44503          	lbu	a0,-1(s0)
  80024e:	ff351ae3          	bne	a0,s3,800242 <vprintfmt+0x46>
  800252:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  800256:	02000793          	li	a5,32
        lflag = altflag = 0;
  80025a:	4c81                	li	s9,0
  80025c:	4881                	li	a7,0
        width = precision = -1;
  80025e:	5c7d                	li	s8,-1
  800260:	5dfd                	li	s11,-1
  800262:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  800266:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  800268:	fdd6059b          	addiw	a1,a2,-35
  80026c:	0ff5f593          	andi	a1,a1,255
  800270:	00140d13          	addi	s10,s0,1
  800274:	04b56263          	bltu	a0,a1,8002b8 <vprintfmt+0xbc>
  800278:	058a                	slli	a1,a1,0x2
  80027a:	95d6                	add	a1,a1,s5
  80027c:	4194                	lw	a3,0(a1)
  80027e:	96d6                	add	a3,a3,s5
  800280:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800282:	70e6                	ld	ra,120(sp)
  800284:	7446                	ld	s0,112(sp)
  800286:	74a6                	ld	s1,104(sp)
  800288:	7906                	ld	s2,96(sp)
  80028a:	69e6                	ld	s3,88(sp)
  80028c:	6a46                	ld	s4,80(sp)
  80028e:	6aa6                	ld	s5,72(sp)
  800290:	6b06                	ld	s6,64(sp)
  800292:	7be2                	ld	s7,56(sp)
  800294:	7c42                	ld	s8,48(sp)
  800296:	7ca2                	ld	s9,40(sp)
  800298:	7d02                	ld	s10,32(sp)
  80029a:	6de2                	ld	s11,24(sp)
  80029c:	6109                	addi	sp,sp,128
  80029e:	8082                	ret
            padc = '0';
  8002a0:	87b2                	mv	a5,a2
            goto reswitch;
  8002a2:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002a6:	846a                	mv	s0,s10
  8002a8:	00140d13          	addi	s10,s0,1
  8002ac:	fdd6059b          	addiw	a1,a2,-35
  8002b0:	0ff5f593          	andi	a1,a1,255
  8002b4:	fcb572e3          	bgeu	a0,a1,800278 <vprintfmt+0x7c>
            putch('%', putdat);
  8002b8:	85a6                	mv	a1,s1
  8002ba:	02500513          	li	a0,37
  8002be:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  8002c0:	fff44783          	lbu	a5,-1(s0)
  8002c4:	8d22                	mv	s10,s0
  8002c6:	f73788e3          	beq	a5,s3,800236 <vprintfmt+0x3a>
  8002ca:	ffed4783          	lbu	a5,-2(s10)
  8002ce:	1d7d                	addi	s10,s10,-1
  8002d0:	ff379de3          	bne	a5,s3,8002ca <vprintfmt+0xce>
  8002d4:	b78d                	j	800236 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  8002d6:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  8002da:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  8002de:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  8002e0:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  8002e4:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  8002e8:	02d86463          	bltu	a6,a3,800310 <vprintfmt+0x114>
                ch = *fmt;
  8002ec:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  8002f0:	002c169b          	slliw	a3,s8,0x2
  8002f4:	0186873b          	addw	a4,a3,s8
  8002f8:	0017171b          	slliw	a4,a4,0x1
  8002fc:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  8002fe:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800302:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800304:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800308:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80030c:	fed870e3          	bgeu	a6,a3,8002ec <vprintfmt+0xf0>
            if (width < 0)
  800310:	f40ddce3          	bgez	s11,800268 <vprintfmt+0x6c>
                width = precision, precision = -1;
  800314:	8de2                	mv	s11,s8
  800316:	5c7d                	li	s8,-1
  800318:	bf81                	j	800268 <vprintfmt+0x6c>
            if (width < 0)
  80031a:	fffdc693          	not	a3,s11
  80031e:	96fd                	srai	a3,a3,0x3f
  800320:	00ddfdb3          	and	s11,s11,a3
  800324:	00144603          	lbu	a2,1(s0)
  800328:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
  80032a:	846a                	mv	s0,s10
            goto reswitch;
  80032c:	bf35                	j	800268 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  80032e:	000a2c03          	lw	s8,0(s4)
            goto process_precision;
  800332:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  800336:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800338:	846a                	mv	s0,s10
            goto process_precision;
  80033a:	bfd9                	j	800310 <vprintfmt+0x114>
    if (lflag >= 2) {
  80033c:	4705                	li	a4,1
  80033e:	008a0593          	addi	a1,s4,8
  800342:	01174463          	blt	a4,a7,80034a <vprintfmt+0x14e>
    else if (lflag) {
  800346:	1a088e63          	beqz	a7,800502 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  80034a:	000a3603          	ld	a2,0(s4)
  80034e:	46c1                	li	a3,16
  800350:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  800352:	2781                	sext.w	a5,a5
  800354:	876e                	mv	a4,s11
  800356:	85a6                	mv	a1,s1
  800358:	854a                	mv	a0,s2
  80035a:	e37ff0ef          	jal	ra,800190 <printnum>
            break;
  80035e:	bde1                	j	800236 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  800360:	000a2503          	lw	a0,0(s4)
  800364:	85a6                	mv	a1,s1
  800366:	0a21                	addi	s4,s4,8
  800368:	9902                	jalr	s2
            break;
  80036a:	b5f1                	j	800236 <vprintfmt+0x3a>
    if (lflag >= 2) {
  80036c:	4705                	li	a4,1
  80036e:	008a0593          	addi	a1,s4,8
  800372:	01174463          	blt	a4,a7,80037a <vprintfmt+0x17e>
    else if (lflag) {
  800376:	18088163          	beqz	a7,8004f8 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  80037a:	000a3603          	ld	a2,0(s4)
  80037e:	46a9                	li	a3,10
  800380:	8a2e                	mv	s4,a1
  800382:	bfc1                	j	800352 <vprintfmt+0x156>
            goto reswitch;
  800384:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  800388:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  80038a:	846a                	mv	s0,s10
            goto reswitch;
  80038c:	bdf1                	j	800268 <vprintfmt+0x6c>
            putch(ch, putdat);
  80038e:	85a6                	mv	a1,s1
  800390:	02500513          	li	a0,37
  800394:	9902                	jalr	s2
            break;
  800396:	b545                	j	800236 <vprintfmt+0x3a>
            lflag ++;
  800398:	00144603          	lbu	a2,1(s0)
  80039c:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  80039e:	846a                	mv	s0,s10
            goto reswitch;
  8003a0:	b5e1                	j	800268 <vprintfmt+0x6c>
    if (lflag >= 2) {
  8003a2:	4705                	li	a4,1
  8003a4:	008a0593          	addi	a1,s4,8
  8003a8:	01174463          	blt	a4,a7,8003b0 <vprintfmt+0x1b4>
    else if (lflag) {
  8003ac:	14088163          	beqz	a7,8004ee <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  8003b0:	000a3603          	ld	a2,0(s4)
  8003b4:	46a1                	li	a3,8
  8003b6:	8a2e                	mv	s4,a1
  8003b8:	bf69                	j	800352 <vprintfmt+0x156>
            putch('0', putdat);
  8003ba:	03000513          	li	a0,48
  8003be:	85a6                	mv	a1,s1
  8003c0:	e03e                	sd	a5,0(sp)
  8003c2:	9902                	jalr	s2
            putch('x', putdat);
  8003c4:	85a6                	mv	a1,s1
  8003c6:	07800513          	li	a0,120
  8003ca:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003cc:	0a21                	addi	s4,s4,8
            goto number;
  8003ce:	6782                	ld	a5,0(sp)
  8003d0:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  8003d2:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  8003d6:	bfb5                	j	800352 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003d8:	000a3403          	ld	s0,0(s4)
  8003dc:	008a0713          	addi	a4,s4,8
  8003e0:	e03a                	sd	a4,0(sp)
  8003e2:	14040263          	beqz	s0,800526 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  8003e6:	0fb05763          	blez	s11,8004d4 <vprintfmt+0x2d8>
  8003ea:	02d00693          	li	a3,45
  8003ee:	0cd79163          	bne	a5,a3,8004b0 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8003f2:	00044783          	lbu	a5,0(s0)
  8003f6:	0007851b          	sext.w	a0,a5
  8003fa:	cf85                	beqz	a5,800432 <vprintfmt+0x236>
  8003fc:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800400:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800404:	000c4563          	bltz	s8,80040e <vprintfmt+0x212>
  800408:	3c7d                	addiw	s8,s8,-1
  80040a:	036c0263          	beq	s8,s6,80042e <vprintfmt+0x232>
                    putch('?', putdat);
  80040e:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800410:	0e0c8e63          	beqz	s9,80050c <vprintfmt+0x310>
  800414:	3781                	addiw	a5,a5,-32
  800416:	0ef47b63          	bgeu	s0,a5,80050c <vprintfmt+0x310>
                    putch('?', putdat);
  80041a:	03f00513          	li	a0,63
  80041e:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800420:	000a4783          	lbu	a5,0(s4)
  800424:	3dfd                	addiw	s11,s11,-1
  800426:	0a05                	addi	s4,s4,1
  800428:	0007851b          	sext.w	a0,a5
  80042c:	ffe1                	bnez	a5,800404 <vprintfmt+0x208>
            for (; width > 0; width --) {
  80042e:	01b05963          	blez	s11,800440 <vprintfmt+0x244>
  800432:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  800434:	85a6                	mv	a1,s1
  800436:	02000513          	li	a0,32
  80043a:	9902                	jalr	s2
            for (; width > 0; width --) {
  80043c:	fe0d9be3          	bnez	s11,800432 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  800440:	6a02                	ld	s4,0(sp)
  800442:	bbd5                	j	800236 <vprintfmt+0x3a>
    if (lflag >= 2) {
  800444:	4705                	li	a4,1
  800446:	008a0c93          	addi	s9,s4,8
  80044a:	01174463          	blt	a4,a7,800452 <vprintfmt+0x256>
    else if (lflag) {
  80044e:	08088d63          	beqz	a7,8004e8 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  800452:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  800456:	0a044d63          	bltz	s0,800510 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  80045a:	8622                	mv	a2,s0
  80045c:	8a66                	mv	s4,s9
  80045e:	46a9                	li	a3,10
  800460:	bdcd                	j	800352 <vprintfmt+0x156>
            err = va_arg(ap, int);
  800462:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800466:	4761                	li	a4,24
            err = va_arg(ap, int);
  800468:	0a21                	addi	s4,s4,8
            if (err < 0) {
  80046a:	41f7d69b          	sraiw	a3,a5,0x1f
  80046e:	8fb5                	xor	a5,a5,a3
  800470:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800474:	02d74163          	blt	a4,a3,800496 <vprintfmt+0x29a>
  800478:	00369793          	slli	a5,a3,0x3
  80047c:	97de                	add	a5,a5,s7
  80047e:	639c                	ld	a5,0(a5)
  800480:	cb99                	beqz	a5,800496 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  800482:	86be                	mv	a3,a5
  800484:	00000617          	auipc	a2,0x0
  800488:	29c60613          	addi	a2,a2,668 # 800720 <main+0x1a2>
  80048c:	85a6                	mv	a1,s1
  80048e:	854a                	mv	a0,s2
  800490:	0ce000ef          	jal	ra,80055e <printfmt>
  800494:	b34d                	j	800236 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800496:	00000617          	auipc	a2,0x0
  80049a:	27a60613          	addi	a2,a2,634 # 800710 <main+0x192>
  80049e:	85a6                	mv	a1,s1
  8004a0:	854a                	mv	a0,s2
  8004a2:	0bc000ef          	jal	ra,80055e <printfmt>
  8004a6:	bb41                	j	800236 <vprintfmt+0x3a>
                p = "(null)";
  8004a8:	00000417          	auipc	s0,0x0
  8004ac:	26040413          	addi	s0,s0,608 # 800708 <main+0x18a>
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004b0:	85e2                	mv	a1,s8
  8004b2:	8522                	mv	a0,s0
  8004b4:	e43e                	sd	a5,8(sp)
  8004b6:	cadff0ef          	jal	ra,800162 <strnlen>
  8004ba:	40ad8dbb          	subw	s11,s11,a0
  8004be:	01b05b63          	blez	s11,8004d4 <vprintfmt+0x2d8>
  8004c2:	67a2                	ld	a5,8(sp)
  8004c4:	00078a1b          	sext.w	s4,a5
  8004c8:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  8004ca:	85a6                	mv	a1,s1
  8004cc:	8552                	mv	a0,s4
  8004ce:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  8004d0:	fe0d9ce3          	bnez	s11,8004c8 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004d4:	00044783          	lbu	a5,0(s0)
  8004d8:	00140a13          	addi	s4,s0,1
  8004dc:	0007851b          	sext.w	a0,a5
  8004e0:	d3a5                	beqz	a5,800440 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  8004e2:	05e00413          	li	s0,94
  8004e6:	bf39                	j	800404 <vprintfmt+0x208>
        return va_arg(*ap, int);
  8004e8:	000a2403          	lw	s0,0(s4)
  8004ec:	b7ad                	j	800456 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  8004ee:	000a6603          	lwu	a2,0(s4)
  8004f2:	46a1                	li	a3,8
  8004f4:	8a2e                	mv	s4,a1
  8004f6:	bdb1                	j	800352 <vprintfmt+0x156>
  8004f8:	000a6603          	lwu	a2,0(s4)
  8004fc:	46a9                	li	a3,10
  8004fe:	8a2e                	mv	s4,a1
  800500:	bd89                	j	800352 <vprintfmt+0x156>
  800502:	000a6603          	lwu	a2,0(s4)
  800506:	46c1                	li	a3,16
  800508:	8a2e                	mv	s4,a1
  80050a:	b5a1                	j	800352 <vprintfmt+0x156>
                    putch(ch, putdat);
  80050c:	9902                	jalr	s2
  80050e:	bf09                	j	800420 <vprintfmt+0x224>
                putch('-', putdat);
  800510:	85a6                	mv	a1,s1
  800512:	02d00513          	li	a0,45
  800516:	e03e                	sd	a5,0(sp)
  800518:	9902                	jalr	s2
                num = -(long long)num;
  80051a:	6782                	ld	a5,0(sp)
  80051c:	8a66                	mv	s4,s9
  80051e:	40800633          	neg	a2,s0
  800522:	46a9                	li	a3,10
  800524:	b53d                	j	800352 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800526:	03b05163          	blez	s11,800548 <vprintfmt+0x34c>
  80052a:	02d00693          	li	a3,45
  80052e:	f6d79de3          	bne	a5,a3,8004a8 <vprintfmt+0x2ac>
                p = "(null)";
  800532:	00000417          	auipc	s0,0x0
  800536:	1d640413          	addi	s0,s0,470 # 800708 <main+0x18a>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80053a:	02800793          	li	a5,40
  80053e:	02800513          	li	a0,40
  800542:	00140a13          	addi	s4,s0,1
  800546:	bd6d                	j	800400 <vprintfmt+0x204>
  800548:	00000a17          	auipc	s4,0x0
  80054c:	1c1a0a13          	addi	s4,s4,449 # 800709 <main+0x18b>
  800550:	02800513          	li	a0,40
  800554:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  800558:	05e00413          	li	s0,94
  80055c:	b565                	j	800404 <vprintfmt+0x208>

000000000080055e <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  80055e:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  800560:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800564:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800566:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  800568:	ec06                	sd	ra,24(sp)
  80056a:	f83a                	sd	a4,48(sp)
  80056c:	fc3e                	sd	a5,56(sp)
  80056e:	e0c2                	sd	a6,64(sp)
  800570:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  800572:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  800574:	c89ff0ef          	jal	ra,8001fc <vprintfmt>
}
  800578:	60e2                	ld	ra,24(sp)
  80057a:	6161                	addi	sp,sp,80
  80057c:	8082                	ret

000000000080057e <main>:
          j = !j;
     }
}

int
main(void) {
  80057e:	715d                	addi	sp,sp,-80
     int i,time;
     memset(pids, 0, sizeof(pids));
  800580:	00001517          	auipc	a0,0x1
  800584:	ab050513          	addi	a0,a0,-1360 # 801030 <pids>
main(void) {
  800588:	fc26                	sd	s1,56(sp)
  80058a:	ec56                	sd	s5,24(sp)
  80058c:	84aa                	mv	s1,a0
     memset(pids, 0, sizeof(pids));
  80058e:	4651                	li	a2,20
  800590:	4581                	li	a1,0
  800592:	00001a97          	auipc	s5,0x1
  800596:	a6ea8a93          	addi	s5,s5,-1426 # 801000 <acc>
main(void) {
  80059a:	e0a2                	sd	s0,64(sp)
  80059c:	f84a                	sd	s2,48(sp)
  80059e:	f44e                	sd	s3,40(sp)
  8005a0:	f052                	sd	s4,32(sp)
  8005a2:	e486                	sd	ra,72(sp)
  8005a4:	89d6                	mv	s3,s5
     memset(pids, 0, sizeof(pids));
  8005a6:	bd9ff0ef          	jal	ra,80017e <memset>
  8005aa:	8926                	mv	s2,s1

     for (i = 0; i < TOTAL; i ++) {
  8005ac:	4401                	li	s0,0
  8005ae:	4a15                	li	s4,5
          acc[i]=0;
  8005b0:	0009a023          	sw	zero,0(s3)
          if ((pids[i] = fork()) == 0) {
  8005b4:	b23ff0ef          	jal	ra,8000d6 <fork>
  8005b8:	00a92023          	sw	a0,0(s2)
  8005bc:	c125                	beqz	a0,80061c <main+0x9e>
                            exit(acc[i]);
                        }
                    }
               }
          }
          if (pids[i] < 0) {
  8005be:	0c054063          	bltz	a0,80067e <main+0x100>
     for (i = 0; i < TOTAL; i ++) {
  8005c2:	2405                	addiw	s0,s0,1
  8005c4:	0991                	addi	s3,s3,4
  8005c6:	0911                	addi	s2,s2,4
  8005c8:	ff4414e3          	bne	s0,s4,8005b0 <main+0x32>
               goto failed;
          }
     }

     cprintf("main: fork ok,now need to wait pids.\n");
  8005cc:	00000517          	auipc	a0,0x0
  8005d0:	45c50513          	addi	a0,a0,1116 # 800a28 <error_string+0xe8>
  8005d4:	b4dff0ef          	jal	ra,800120 <cprintf>

     for (i = 0; i < TOTAL; i ++) {
  8005d8:	00001417          	auipc	s0,0x1
  8005dc:	a4040413          	addi	s0,s0,-1472 # 801018 <status>
  8005e0:	00001917          	auipc	s2,0x1
  8005e4:	a4c90913          	addi	s2,s2,-1460 # 80102c <status+0x14>
         status[i]=0;
         waitpid(pids[i],&status[i]);
  8005e8:	4088                	lw	a0,0(s1)
         status[i]=0;
  8005ea:	00042023          	sw	zero,0(s0)
         waitpid(pids[i],&status[i]);
  8005ee:	85a2                	mv	a1,s0
  8005f0:	0411                	addi	s0,s0,4
  8005f2:	ae7ff0ef          	jal	ra,8000d8 <waitpid>
     for (i = 0; i < TOTAL; i ++) {
  8005f6:	0491                	addi	s1,s1,4
  8005f8:	ff2418e3          	bne	s0,s2,8005e8 <main+0x6a>
       
     }
     cprintf("main: wait pids over\n");
  8005fc:	00000517          	auipc	a0,0x0
  800600:	45450513          	addi	a0,a0,1108 # 800a50 <error_string+0x110>
  800604:	b1dff0ef          	jal	ra,800120 <cprintf>
          if (pids[i] > 0) {
               kill(pids[i]);
          }
     }
     panic("FAIL: T.T\n");
}
  800608:	60a6                	ld	ra,72(sp)
  80060a:	6406                	ld	s0,64(sp)
  80060c:	74e2                	ld	s1,56(sp)
  80060e:	7942                	ld	s2,48(sp)
  800610:	79a2                	ld	s3,40(sp)
  800612:	7a02                	ld	s4,32(sp)
  800614:	6ae2                	ld	s5,24(sp)
  800616:	4501                	li	a0,0
  800618:	6161                	addi	sp,sp,80
  80061a:	8082                	ret
               acc[i] = 0;
  80061c:	040a                	slli	s0,s0,0x2
  80061e:	9456                	add	s0,s0,s5
  800620:	6485                	lui	s1,0x1
                        if((time=gettime_msec())>MAX_TIME) {
  800622:	6989                	lui	s3,0x2
               acc[i] = 0;
  800624:	00042023          	sw	zero,0(s0)
  800628:	fa04849b          	addiw	s1,s1,-96
                        if((time=gettime_msec())>MAX_TIME) {
  80062c:	71098993          	addi	s3,s3,1808 # 2710 <__panic-0x7fd910>
  800630:	4014                	lw	a3,0(s0)
  800632:	2685                	addiw	a3,a3,1
     for (i = 0; i != 200; ++ i)
  800634:	0c800713          	li	a4,200
          j = !j;
  800638:	47b2                	lw	a5,12(sp)
  80063a:	377d                	addiw	a4,a4,-1
  80063c:	2781                	sext.w	a5,a5
  80063e:	0017b793          	seqz	a5,a5
  800642:	c63e                	sw	a5,12(sp)
     for (i = 0; i != 200; ++ i)
  800644:	fb75                	bnez	a4,800638 <main+0xba>
                    if(acc[i]%4000==0) {
  800646:	0296f7bb          	remuw	a5,a3,s1
  80064a:	0016871b          	addiw	a4,a3,1
  80064e:	c399                	beqz	a5,800654 <main+0xd6>
  800650:	86ba                	mv	a3,a4
  800652:	b7cd                	j	800634 <main+0xb6>
  800654:	c014                	sw	a3,0(s0)
                        if((time=gettime_msec())>MAX_TIME) {
  800656:	a89ff0ef          	jal	ra,8000de <gettime_msec>
  80065a:	0005091b          	sext.w	s2,a0
  80065e:	fd29d9e3          	bge	s3,s2,800630 <main+0xb2>
                            cprintf("child pid %d, acc %d, time %d\n",getpid(),acc[i],time);
  800662:	a7bff0ef          	jal	ra,8000dc <getpid>
  800666:	4010                	lw	a2,0(s0)
  800668:	85aa                	mv	a1,a0
  80066a:	86ca                	mv	a3,s2
  80066c:	00000517          	auipc	a0,0x0
  800670:	39c50513          	addi	a0,a0,924 # 800a08 <error_string+0xc8>
  800674:	aadff0ef          	jal	ra,800120 <cprintf>
                            exit(acc[i]);
  800678:	4008                	lw	a0,0(s0)
  80067a:	a47ff0ef          	jal	ra,8000c0 <exit>
  80067e:	00001417          	auipc	s0,0x1
  800682:	9c640413          	addi	s0,s0,-1594 # 801044 <pids+0x14>
          if (pids[i] > 0) {
  800686:	4088                	lw	a0,0(s1)
  800688:	00a05463          	blez	a0,800690 <main+0x112>
               kill(pids[i]);
  80068c:	a4fff0ef          	jal	ra,8000da <kill>
     for (i = 0; i < TOTAL; i ++) {
  800690:	0491                	addi	s1,s1,4
  800692:	fe849ae3          	bne	s1,s0,800686 <main+0x108>
     panic("FAIL: T.T\n");
  800696:	00000617          	auipc	a2,0x0
  80069a:	3d260613          	addi	a2,a2,978 # 800a68 <error_string+0x128>
  80069e:	04100593          	li	a1,65
  8006a2:	00000517          	auipc	a0,0x0
  8006a6:	3d650513          	addi	a0,a0,982 # 800a78 <error_string+0x138>
  8006aa:	977ff0ef          	jal	ra,800020 <__panic>
