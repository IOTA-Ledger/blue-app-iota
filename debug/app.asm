
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00002:	af03      	add	r7, sp, #12
c0d00004:	b08f      	sub	sp, #60	; 0x3c
    // exit critical section
    __asm volatile("cpsie i");
c0d00006:	b662      	cpsie	i

    hashTainted = 1;
c0d00008:	4821      	ldr	r0, [pc, #132]	; (c0d00090 <main+0x90>)
c0d0000a:	2601      	movs	r6, #1
c0d0000c:	7006      	strb	r6, [r0, #0]

    UX_INIT();
c0d0000e:	4821      	ldr	r0, [pc, #132]	; (c0d00094 <main+0x94>)
c0d00010:	2100      	movs	r1, #0
c0d00012:	22b0      	movs	r2, #176	; 0xb0
c0d00014:	f000 fe8a 	bl	c0d00d2c <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fdd6 	bl	c0d00bc8 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f931 	bl	c0d0328c <setjmp>
c0d0002a:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0002c:	602c      	str	r4, [r5, #0]
c0d0002e:	491b      	ldr	r1, [pc, #108]	; (c0d0009c <main+0x9c>)
c0d00030:	4208      	tst	r0, r1
c0d00032:	d005      	beq.n	c0d00040 <main+0x40>
c0d00034:	a803      	add	r0, sp, #12

            ui_idle();

            IOTA_main();
        }
        CATCH_OTHER(e) {
c0d00036:	2100      	movs	r1, #0
c0d00038:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d0003a:	980d      	ldr	r0, [sp, #52]	; 0x34
        }
        FINALLY {
c0d0003c:	6028      	str	r0, [r5, #0]
c0d0003e:	e022      	b.n	c0d00086 <main+0x86>
    // ensure exception will work as planned
    os_boot();

    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();
c0d00040:	f001 f81a 	bl	c0d01078 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fcfb 	bl	c0d01a40 <pic>
c0d0004a:	7800      	ldrb	r0, [r0, #0]
c0d0004c:	2801      	cmp	r0, #1
c0d0004e:	d00a      	beq.n	c0d00066 <main+0x66>
c0d00050:	ac01      	add	r4, sp, #4
                internalStorage_t storage;
                storage.initialized = 0x01;
c0d00052:	7026      	strb	r6, [r4, #0]
                storage.seed_key = 55;
c0d00054:	2037      	movs	r0, #55	; 0x37
c0d00056:	9002      	str	r0, [sp, #8]

                nvm_write(&N_storage, (void *)&storage,
c0d00058:	4811      	ldr	r0, [pc, #68]	; (c0d000a0 <main+0xa0>)
c0d0005a:	f001 fcf1 	bl	c0d01a40 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fd3f 	bl	c0d01ae4 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fe46 	bl	c0d02cf8 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fe43 	bl	c0d02cf8 <USB_power>

            ui_idle();
c0d00072:	f001 ffd7 	bl	c0d02024 <ui_idle>

            IOTA_main();
c0d00076:	f000 fc3f 	bl	c0d008f8 <IOTA_main>
c0d0007a:	a803      	add	r0, sp, #12
c0d0007c:	8d81      	ldrh	r1, [r0, #44]	; 0x2c
c0d0007e:	980d      	ldr	r0, [sp, #52]	; 0x34
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
c0d00080:	6028      	str	r0, [r5, #0]
        }
    }
    END_TRY;
c0d00082:	2900      	cmp	r1, #0
c0d00084:	d102      	bne.n	c0d0008c <main+0x8c>
}
c0d00086:	2000      	movs	r0, #0
c0d00088:	b00f      	add	sp, #60	; 0x3c
c0d0008a:	bdf0      	pop	{r4, r5, r6, r7, pc}
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
c0d0008c:	f003 f90a 	bl	c0d032a4 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d037c0 	.word	0xc0d037c0

c0d000a4 <write_debug>:

char debug_str[64];

//write_debug(&words, sizeof(words), TYPE_STR);
//write_debug(&int_val, sizeof(int_val), TYPE_INT);
void write_debug(void* o, unsigned int sz, uint8_t t) {
c0d000a4:	b580      	push	{r7, lr}
c0d000a6:	af00      	add	r7, sp, #0
c0d000a8:	4603      	mov	r3, r0

    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
c0d000aa:	2a03      	cmp	r2, #3
c0d000ac:	d007      	beq.n	c0d000be <write_debug+0x1a>
c0d000ae:	2a02      	cmp	r2, #2
c0d000b0:	d008      	beq.n	c0d000c4 <write_debug+0x20>
c0d000b2:	2a01      	cmp	r2, #1
c0d000b4:	d10b      	bne.n	c0d000ce <write_debug+0x2a>
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
c0d000b6:	681b      	ldr	r3, [r3, #0]
c0d000b8:	4805      	ldr	r0, [pc, #20]	; (c0d000d0 <write_debug+0x2c>)
c0d000ba:	a208      	add	r2, pc, #32	; (adr r2, c0d000dc <write_debug+0x38>)
c0d000bc:	e005      	b.n	c0d000ca <write_debug+0x26>
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
c0d000be:	4804      	ldr	r0, [pc, #16]	; (c0d000d0 <write_debug+0x2c>)
c0d000c0:	a204      	add	r2, pc, #16	; (adr r2, c0d000d4 <write_debug+0x30>)
c0d000c2:	e002      	b.n	c0d000ca <write_debug+0x26>
    //uint32_t/int(half this) [0, 4,294,967,295] - ledger does not support long - USE %d not %i!
    if(t == TYPE_INT) {
            snprintf(&debug_str[0], sz, "%d", *(int32_t *) o);
    }
    else if(t == TYPE_UINT) {
            snprintf(&debug_str[0], sz, "%u", *(uint32_t *) o);
c0d000c4:	681b      	ldr	r3, [r3, #0]
c0d000c6:	4802      	ldr	r0, [pc, #8]	; (c0d000d0 <write_debug+0x2c>)
c0d000c8:	a203      	add	r2, pc, #12	; (adr r2, c0d000d8 <write_debug+0x34>)
c0d000ca:	f001 fa69 	bl	c0d015a0 <snprintf>
    }
    else if(t == TYPE_STR) {
            snprintf(&debug_str[0], sz, "%s", (char *) o);
    }
}
c0d000ce:	bd80      	pop	{r7, pc}
c0d000d0:	20001800 	.word	0x20001800
c0d000d4:	00007325 	.word	0x00007325
c0d000d8:	00007525 	.word	0x00007525
c0d000dc:	00006425 	.word	0x00006425

c0d000e0 <specific_243trits_to_49trints>:

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
c0d000e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000e2:	af03      	add	r7, sp, #12
c0d000e4:	b086      	sub	sp, #24
c0d000e6:	2500      	movs	r5, #0
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d000e8:	43eb      	mvns	r3, r5
c0d000ea:	2205      	movs	r2, #5
c0d000ec:	9201      	str	r2, [sp, #4]
c0d000ee:	43d6      	mvns	r6, r2
c0d000f0:	1f80      	subs	r0, r0, #6
}

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
    uint8_t send = 0, count = 0;
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
c0d000f2:	1d00      	adds	r0, r0, #4
c0d000f4:	9000      	str	r0, [sp, #0]
c0d000f6:	462a      	mov	r2, r5
c0d000f8:	9102      	str	r1, [sp, #8]
c0d000fa:	9605      	str	r6, [sp, #20]
        send = ((243 - i) < 5) ? 243 - i : 5;
c0d000fc:	20f3      	movs	r0, #243	; 0xf3
c0d000fe:	9204      	str	r2, [sp, #16]
c0d00100:	1a80      	subs	r0, r0, r2
c0d00102:	2805      	cmp	r0, #5
c0d00104:	db00      	blt.n	c0d00108 <specific_243trits_to_49trints+0x28>
c0d00106:	9801      	ldr	r0, [sp, #4]
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00108:	b2c0      	uxtb	r0, r0
c0d0010a:	30ff      	adds	r0, #255	; 0xff
c0d0010c:	b242      	sxtb	r2, r0
c0d0010e:	2400      	movs	r4, #0
c0d00110:	429a      	cmp	r2, r3
c0d00112:	9a04      	ldr	r2, [sp, #16]
c0d00114:	dd1f      	ble.n	c0d00156 <specific_243trits_to_49trints+0x76>
c0d00116:	9503      	str	r5, [sp, #12]
c0d00118:	2105      	movs	r1, #5
c0d0011a:	43cc      	mvns	r4, r1
c0d0011c:	4611      	mov	r1, r2
c0d0011e:	39f4      	subs	r1, #244	; 0xf4
c0d00120:	42a1      	cmp	r1, r4
c0d00122:	dc00      	bgt.n	c0d00126 <specific_243trits_to_49trints+0x46>
c0d00124:	4631      	mov	r1, r6
c0d00126:	1a51      	subs	r1, r2, r1
c0d00128:	9a00      	ldr	r2, [sp, #0]
c0d0012a:	1856      	adds	r6, r2, r1
c0d0012c:	2101      	movs	r1, #1
c0d0012e:	2400      	movs	r4, #0
    {
        ret += trits[i]*pow3_val;
c0d00130:	b24a      	sxtb	r2, r1
        pow3_val *= 3;
c0d00132:	2103      	movs	r1, #3
c0d00134:	4351      	muls	r1, r2
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d00136:	7835      	ldrb	r5, [r6, #0]
c0d00138:	b26d      	sxtb	r5, r5
c0d0013a:	4355      	muls	r5, r2
c0d0013c:	b2e2      	uxtb	r2, r4
c0d0013e:	18ac      	adds	r4, r5, r2
c0d00140:	9a05      	ldr	r2, [sp, #20]
c0d00142:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d00144:	1d56      	adds	r6, r2, #5
c0d00146:	1e40      	subs	r0, r0, #1
c0d00148:	b240      	sxtb	r0, r0
c0d0014a:	4298      	cmp	r0, r3
c0d0014c:	dcf0      	bgt.n	c0d00130 <specific_243trits_to_49trints+0x50>
c0d0014e:	9902      	ldr	r1, [sp, #8]
c0d00150:	9d03      	ldr	r5, [sp, #12]
c0d00152:	9e05      	ldr	r6, [sp, #20]
c0d00154:	9a04      	ldr	r2, [sp, #16]
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
        send = ((243 - i) < 5) ? 243 - i : 5;

        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
c0d00156:	554c      	strb	r4, [r1, r5]
c0d00158:	1c6d      	adds	r5, r5, #1
}

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r) {
    uint8_t send = 0, count = 0;
    //send all trits in groups of 5 (last one just 3)
    for(uint8_t i = 0; i < 243; i += 5) {
c0d0015a:	1d50      	adds	r0, r2, #5
c0d0015c:	b2c2      	uxtb	r2, r0
c0d0015e:	2d31      	cmp	r5, #49	; 0x31
c0d00160:	d1cc      	bne.n	c0d000fc <specific_243trits_to_49trints+0x1c>
        send = ((243 - i) < 5) ? 243 - i : 5;

        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}
c0d00162:	b006      	add	sp, #24
c0d00164:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00168 <trint_to_trits>:
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00168:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0016a:	af03      	add	r7, sp, #12
c0d0016c:	b083      	sub	sp, #12
c0d0016e:	9100      	str	r1, [sp, #0]
c0d00170:	4603      	mov	r3, r0
c0d00172:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00174:	2a01      	cmp	r2, #1
c0d00176:	db2b      	blt.n	c0d001d0 <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d00178:	2009      	movs	r0, #9
c0d0017a:	2151      	movs	r1, #81	; 0x51
c0d0017c:	9a01      	ldr	r2, [sp, #4]
c0d0017e:	2a03      	cmp	r2, #3
c0d00180:	d000      	beq.n	c0d00184 <trint_to_trits+0x1c>
c0d00182:	4608      	mov	r0, r1
c0d00184:	2500      	movs	r5, #0
c0d00186:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00188:	b2c4      	uxtb	r4, r0
c0d0018a:	b258      	sxtb	r0, r3
c0d0018c:	9002      	str	r0, [sp, #8]
c0d0018e:	0040      	lsls	r0, r0, #1
c0d00190:	4621      	mov	r1, r4
c0d00192:	f002 fef9 	bl	c0d02f88 <__aeabi_idiv>
c0d00196:	9900      	ldr	r1, [sp, #0]
c0d00198:	5548      	strb	r0, [r1, r5]
c0d0019a:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d0019c:	0603      	lsls	r3, r0, #24
c0d0019e:	2101      	movs	r1, #1
c0d001a0:	060d      	lsls	r5, r1, #24
c0d001a2:	42ab      	cmp	r3, r5
c0d001a4:	dc03      	bgt.n	c0d001ae <trint_to_trits+0x46>
c0d001a6:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d001a8:	4d0a      	ldr	r5, [pc, #40]	; (c0d001d4 <trint_to_trits+0x6c>)
c0d001aa:	42ab      	cmp	r3, r5
c0d001ac:	dc01      	bgt.n	c0d001b2 <trint_to_trits+0x4a>
c0d001ae:	7011      	strb	r1, [r2, #0]
c0d001b0:	e000      	b.n	c0d001b4 <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d001b2:	4601      	mov	r1, r0
c0d001b4:	9a02      	ldr	r2, [sp, #8]
c0d001b6:	b248      	sxtb	r0, r1
c0d001b8:	4360      	muls	r0, r4
c0d001ba:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d001bc:	2103      	movs	r1, #3
c0d001be:	4620      	mov	r0, r4
c0d001c0:	f002 fe58 	bl	c0d02e74 <__aeabi_uidiv>
c0d001c4:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d001c6:	1c76      	adds	r6, r6, #1
c0d001c8:	b2f5      	uxtb	r5, r6
c0d001ca:	9901      	ldr	r1, [sp, #4]
c0d001cc:	428d      	cmp	r5, r1
c0d001ce:	dbdb      	blt.n	c0d00188 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d001d0:	b003      	add	sp, #12
c0d001d2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d001d4:	feffffff 	.word	0xfeffffff

c0d001d8 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d001d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d001da:	af03      	add	r7, sp, #12
c0d001dc:	b0e3      	sub	sp, #396	; 0x18c
c0d001de:	9203      	str	r2, [sp, #12]
c0d001e0:	460e      	mov	r6, r1
c0d001e2:	4605      	mov	r5, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d001e4:	9502      	str	r5, [sp, #8]
c0d001e6:	f000 f9d3 	bl	c0d00590 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001ea:	f000 f9d1 	bl	c0d00590 <kerl_initialize>
c0d001ee:	ac04      	add	r4, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001f0:	4620      	mov	r0, r4
c0d001f2:	4629      	mov	r1, r5
c0d001f4:	4632      	mov	r2, r6
c0d001f6:	f002 ffb9 	bl	c0d0316c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001fa:	19a0      	adds	r0, r4, r6
c0d001fc:	2530      	movs	r5, #48	; 0x30
c0d001fe:	1baa      	subs	r2, r5, r6
c0d00200:	9902      	ldr	r1, [sp, #8]
c0d00202:	f002 ffb3 	bl	c0d0316c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00206:	4620      	mov	r0, r4
c0d00208:	4629      	mov	r1, r5
c0d0020a:	f000 f9cd 	bl	c0d005a8 <kerl_absorb_bytes>
c0d0020e:	ae41      	add	r6, sp, #260	; 0x104
c0d00210:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00212:	4630      	mov	r0, r6
c0d00214:	4629      	mov	r1, r5
c0d00216:	f002 ffa3 	bl	c0d03160 <__aeabi_memclr>
c0d0021a:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021c:	4919      	ldr	r1, [pc, #100]	; (c0d00284 <get_seed+0xac>)
c0d0021e:	4479      	add	r1, pc
c0d00220:	2252      	movs	r2, #82	; 0x52
c0d00222:	4620      	mov	r0, r4
c0d00224:	f002 ffa2 	bl	c0d0316c <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d00228:	4620      	mov	r0, r4
c0d0022a:	4631      	mov	r1, r6
c0d0022c:	462a      	mov	r2, r5
c0d0022e:	f000 f8f7 	bl	c0d00420 <chars_to_trytes>
c0d00232:	ac04      	add	r4, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00234:	21f3      	movs	r1, #243	; 0xf3
c0d00236:	4620      	mov	r0, r4
c0d00238:	f002 ff92 	bl	c0d03160 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0023c:	4630      	mov	r0, r6
c0d0023e:	4621      	mov	r1, r4
c0d00240:	462a      	mov	r2, r5
c0d00242:	f000 f8cf 	bl	c0d003e4 <trytes_to_trits>
c0d00246:	ae56      	add	r6, sp, #344	; 0x158
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d00248:	4620      	mov	r0, r4
c0d0024a:	4631      	mov	r1, r6
c0d0024c:	f7ff ff48 	bl	c0d000e0 <specific_243trits_to_49trints>
c0d00250:	a904      	add	r1, sp, #16
      //   kerl_squeeze_trints(seed_trints, 49);
      // }
      {
        // Print result of trints_to_words
        int32_t words[12];
        trints_to_words(seed_trints, words);
c0d00252:	4630      	mov	r0, r6
c0d00254:	f000 f8fa 	bl	c0d0044c <trints_to_words>
        snprintf(msg, 81, "%u %u %u", words[0], words[1], words[2]);
c0d00258:	9b04      	ldr	r3, [sp, #16]
c0d0025a:	9805      	ldr	r0, [sp, #20]
c0d0025c:	9906      	ldr	r1, [sp, #24]
c0d0025e:	466a      	mov	r2, sp
c0d00260:	c203      	stmia	r2!, {r0, r1}
c0d00262:	a205      	add	r2, pc, #20	; (adr r2, c0d00278 <get_seed+0xa0>)
c0d00264:	9c03      	ldr	r4, [sp, #12]
c0d00266:	4620      	mov	r0, r4
c0d00268:	4629      	mov	r1, r5
c0d0026a:	f001 f999 	bl	c0d015a0 <snprintf>
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d0026e:	2000      	movs	r0, #0
      //   specific_49trints_to_243trits(seed_trints, seed_trits);
      //   trits_to_trytes(seed_trits, seed_trytes, 243);
      //   trytes_to_chars(seed_trytes, msg, 81);
      // }
      {
        msg[81] = '\0';
c0d00270:	5560      	strb	r0, [r4, r5]
    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
}
c0d00272:	b063      	add	sp, #396	; 0x18c
c0d00274:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00276:	46c0      	nop			; (mov r8, r8)
c0d00278:	25207525 	.word	0x25207525
c0d0027c:	75252075 	.word	0x75252075
c0d00280:	00000000 	.word	0x00000000
c0d00284:	00003106 	.word	0x00003106

c0d00288 <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d00288:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0028a:	af03      	add	r7, sp, #12
c0d0028c:	b087      	sub	sp, #28
c0d0028e:	9105      	str	r1, [sp, #20]
c0d00290:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00292:	2b00      	cmp	r3, #0
c0d00294:	d03a      	beq.n	c0d0030c <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00296:	2100      	movs	r1, #0
c0d00298:	43cc      	mvns	r4, r1
c0d0029a:	9400      	str	r4, [sp, #0]
c0d0029c:	460e      	mov	r6, r1
c0d0029e:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d002a0:	9101      	str	r1, [sp, #4]
c0d002a2:	9302      	str	r3, [sp, #8]
c0d002a4:	9203      	str	r2, [sp, #12]
c0d002a6:	9b00      	ldr	r3, [sp, #0]
c0d002a8:	460a      	mov	r2, r1
c0d002aa:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d002ac:	cd01      	ldmia	r5!, {r0}
c0d002ae:	9504      	str	r5, [sp, #16]
c0d002b0:	9905      	ldr	r1, [sp, #20]
c0d002b2:	1841      	adds	r1, r0, r1
c0d002b4:	4156      	adcs	r6, r2
c0d002b6:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d002b8:	4019      	ands	r1, r3
c0d002ba:	1c49      	adds	r1, r1, #1
c0d002bc:	4615      	mov	r5, r2
c0d002be:	416d      	adcs	r5, r5
c0d002c0:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d002c2:	4004      	ands	r4, r0
c0d002c4:	4622      	mov	r2, r4
c0d002c6:	2c00      	cmp	r4, #0
c0d002c8:	d100      	bne.n	c0d002cc <bigint_add_int+0x44>
c0d002ca:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002cc:	4299      	cmp	r1, r3
c0d002ce:	9006      	str	r0, [sp, #24]
c0d002d0:	d800      	bhi.n	c0d002d4 <bigint_add_int+0x4c>
c0d002d2:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d002d4:	2a00      	cmp	r2, #0
c0d002d6:	4632      	mov	r2, r6
c0d002d8:	d100      	bne.n	c0d002dc <bigint_add_int+0x54>
c0d002da:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002dc:	2d00      	cmp	r5, #0
c0d002de:	9e06      	ldr	r6, [sp, #24]
c0d002e0:	d100      	bne.n	c0d002e4 <bigint_add_int+0x5c>
c0d002e2:	462e      	mov	r6, r5
c0d002e4:	2d00      	cmp	r5, #0
c0d002e6:	d000      	beq.n	c0d002ea <bigint_add_int+0x62>
c0d002e8:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d002ea:	4310      	orrs	r0, r2
c0d002ec:	b2c0      	uxtb	r0, r0
c0d002ee:	2800      	cmp	r0, #0
c0d002f0:	9b02      	ldr	r3, [sp, #8]
c0d002f2:	9a03      	ldr	r2, [sp, #12]
c0d002f4:	9c01      	ldr	r4, [sp, #4]
c0d002f6:	d100      	bne.n	c0d002fa <bigint_add_int+0x72>
c0d002f8:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d002fa:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d002fc:	1e5b      	subs	r3, r3, #1
c0d002fe:	9405      	str	r4, [sp, #20]
c0d00300:	4626      	mov	r6, r4
c0d00302:	9d06      	ldr	r5, [sp, #24]
c0d00304:	4621      	mov	r1, r4
c0d00306:	462c      	mov	r4, r5
c0d00308:	9804      	ldr	r0, [sp, #16]
c0d0030a:	d1ca      	bne.n	c0d002a2 <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d0030c:	4268      	negs	r0, r5
    }
    return 0;
}
c0d0030e:	b007      	add	sp, #28
c0d00310:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00312 <bigint_sub_bigint>:
    }
    return 0;
}

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d00312:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00314:	af03      	add	r7, sp, #12
c0d00316:	b087      	sub	sp, #28
c0d00318:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0031a:	2d00      	cmp	r5, #0
c0d0031c:	d037      	beq.n	c0d0038e <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0031e:	2400      	movs	r4, #0
c0d00320:	9402      	str	r4, [sp, #8]
c0d00322:	43e3      	mvns	r3, r4
c0d00324:	9301      	str	r3, [sp, #4]
c0d00326:	2601      	movs	r6, #1
c0d00328:	9600      	str	r6, [sp, #0]
c0d0032a:	9203      	str	r2, [sp, #12]
c0d0032c:	9504      	str	r5, [sp, #16]
c0d0032e:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00330:	cc01      	ldmia	r4!, {r0}
c0d00332:	9405      	str	r4, [sp, #20]
c0d00334:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00336:	cc02      	ldmia	r4!, {r1}
c0d00338:	9406      	str	r4, [sp, #24]
c0d0033a:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0033c:	180a      	adds	r2, r1, r0
c0d0033e:	9902      	ldr	r1, [sp, #8]
c0d00340:	460c      	mov	r4, r1
c0d00342:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00344:	4610      	mov	r0, r2
c0d00346:	9d01      	ldr	r5, [sp, #4]
c0d00348:	4028      	ands	r0, r5
c0d0034a:	1c43      	adds	r3, r0, #1
c0d0034c:	4608      	mov	r0, r1
c0d0034e:	4140      	adcs	r0, r0
c0d00350:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00352:	400e      	ands	r6, r1
c0d00354:	2e00      	cmp	r6, #0
c0d00356:	d100      	bne.n	c0d0035a <bigint_sub_bigint+0x48>
c0d00358:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0035a:	42ab      	cmp	r3, r5
c0d0035c:	460d      	mov	r5, r1
c0d0035e:	d800      	bhi.n	c0d00362 <bigint_sub_bigint+0x50>
c0d00360:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00362:	2e00      	cmp	r6, #0
c0d00364:	9a03      	ldr	r2, [sp, #12]
c0d00366:	d100      	bne.n	c0d0036a <bigint_sub_bigint+0x58>
c0d00368:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0036a:	2800      	cmp	r0, #0
c0d0036c:	460e      	mov	r6, r1
c0d0036e:	d100      	bne.n	c0d00372 <bigint_sub_bigint+0x60>
c0d00370:	4606      	mov	r6, r0
c0d00372:	2800      	cmp	r0, #0
c0d00374:	d000      	beq.n	c0d00378 <bigint_sub_bigint+0x66>
c0d00376:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00378:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0037a:	2d00      	cmp	r5, #0
c0d0037c:	460e      	mov	r6, r1
c0d0037e:	9805      	ldr	r0, [sp, #20]
c0d00380:	d100      	bne.n	c0d00384 <bigint_sub_bigint+0x72>
c0d00382:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00384:	c208      	stmia	r2!, {r3}
c0d00386:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00388:	1e6d      	subs	r5, r5, #1
c0d0038a:	9906      	ldr	r1, [sp, #24]
c0d0038c:	d1cd      	bne.n	c0d0032a <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d0038e:	2000      	movs	r0, #0
c0d00390:	b007      	add	sp, #28
c0d00392:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00394 <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d00394:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00396:	af03      	add	r7, sp, #12
c0d00398:	b081      	sub	sp, #4
c0d0039a:	2400      	movs	r4, #0
c0d0039c:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d0039e:	32ff      	adds	r2, #255	; 0xff
c0d003a0:	b253      	sxtb	r3, r2
c0d003a2:	2b00      	cmp	r3, #0
c0d003a4:	db0f      	blt.n	c0d003c6 <bigint_cmp_bigint+0x32>
c0d003a6:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d003a8:	009b      	lsls	r3, r3, #2
c0d003aa:	58ce      	ldr	r6, [r1, r3]
c0d003ac:	58c4      	ldr	r4, [r0, r3]
c0d003ae:	2301      	movs	r3, #1
c0d003b0:	42b4      	cmp	r4, r6
c0d003b2:	dc0b      	bgt.n	c0d003cc <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d003b4:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d003b6:	42b4      	cmp	r4, r6
c0d003b8:	db07      	blt.n	c0d003ca <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d003ba:	b253      	sxtb	r3, r2
c0d003bc:	42ab      	cmp	r3, r5
c0d003be:	461a      	mov	r2, r3
c0d003c0:	dcf2      	bgt.n	c0d003a8 <bigint_cmp_bigint+0x14>
c0d003c2:	9b00      	ldr	r3, [sp, #0]
c0d003c4:	e002      	b.n	c0d003cc <bigint_cmp_bigint+0x38>
c0d003c6:	4623      	mov	r3, r4
c0d003c8:	e000      	b.n	c0d003cc <bigint_cmp_bigint+0x38>
c0d003ca:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d003cc:	4618      	mov	r0, r3
c0d003ce:	b001      	add	sp, #4
c0d003d0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003d2 <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d003d2:	2900      	cmp	r1, #0
c0d003d4:	d004      	beq.n	c0d003e0 <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d003d6:	6802      	ldr	r2, [r0, #0]
c0d003d8:	43d2      	mvns	r2, r2
c0d003da:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d003dc:	1e49      	subs	r1, r1, #1
c0d003de:	d1fa      	bne.n	c0d003d6 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d003e0:	2000      	movs	r0, #0
c0d003e2:	4770      	bx	lr

c0d003e4 <trytes_to_trits>:
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d003e4:	b5b0      	push	{r4, r5, r7, lr}
c0d003e6:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d003e8:	2a00      	cmp	r2, #0
c0d003ea:	d015      	beq.n	c0d00418 <trytes_to_trits+0x34>
c0d003ec:	4b0b      	ldr	r3, [pc, #44]	; (c0d0041c <trytes_to_trits+0x38>)
c0d003ee:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d003f0:	240d      	movs	r4, #13
c0d003f2:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d003f4:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d003f6:	062d      	lsls	r5, r5, #24
c0d003f8:	192c      	adds	r4, r5, r4
c0d003fa:	1624      	asrs	r4, r4, #24
c0d003fc:	2503      	movs	r5, #3
c0d003fe:	4365      	muls	r5, r4
c0d00400:	5d5c      	ldrb	r4, [r3, r5]
c0d00402:	700c      	strb	r4, [r1, #0]
c0d00404:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00406:	7865      	ldrb	r5, [r4, #1]
c0d00408:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0040a:	78a4      	ldrb	r4, [r4, #2]
c0d0040c:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0040e:	1e52      	subs	r2, r2, #1
c0d00410:	1cc9      	adds	r1, r1, #3
c0d00412:	1c40      	adds	r0, r0, #1
c0d00414:	2a00      	cmp	r2, #0
c0d00416:	d1eb      	bne.n	c0d003f0 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00418:	2000      	movs	r0, #0
c0d0041a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0041c:	00002f8a 	.word	0x00002f8a

c0d00420 <chars_to_trytes>:
    }
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00420:	b5d0      	push	{r4, r6, r7, lr}
c0d00422:	af02      	add	r7, sp, #8
c0d00424:	e00e      	b.n	c0d00444 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00426:	7803      	ldrb	r3, [r0, #0]
c0d00428:	b25b      	sxtb	r3, r3
c0d0042a:	2400      	movs	r4, #0
c0d0042c:	2b39      	cmp	r3, #57	; 0x39
c0d0042e:	d005      	beq.n	c0d0043c <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00430:	2b4e      	cmp	r3, #78	; 0x4e
c0d00432:	db01      	blt.n	c0d00438 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00434:	33a5      	adds	r3, #165	; 0xa5
c0d00436:	e000      	b.n	c0d0043a <chars_to_trytes+0x1a>
c0d00438:	33c0      	adds	r3, #192	; 0xc0
c0d0043a:	461c      	mov	r4, r3
c0d0043c:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0043e:	1e52      	subs	r2, r2, #1
c0d00440:	1c40      	adds	r0, r0, #1
c0d00442:	1c49      	adds	r1, r1, #1
c0d00444:	2a00      	cmp	r2, #0
c0d00446:	d1ee      	bne.n	c0d00426 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d00448:	2000      	movs	r0, #0
c0d0044a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0044c <trints_to_words>:
    return 0;
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d0044c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0044e:	af03      	add	r7, sp, #12
c0d00450:	b0a1      	sub	sp, #132	; 0x84
c0d00452:	9101      	str	r1, [sp, #4]
c0d00454:	9002      	str	r0, [sp, #8]
c0d00456:	a815      	add	r0, sp, #84	; 0x54
c0d00458:	2430      	movs	r4, #48	; 0x30
    int32_t size = 12;
    int32_t base[12] = {0};
c0d0045a:	4621      	mov	r1, r4
c0d0045c:	f002 fe80 	bl	c0d03160 <__aeabi_memclr>
c0d00460:	4621      	mov	r1, r4
c0d00462:	250c      	movs	r5, #12

    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00464:	2403      	movs	r4, #3
c0d00466:	2005      	movs	r0, #5
c0d00468:	2930      	cmp	r1, #48	; 0x30
c0d0046a:	d000      	beq.n	c0d0046e <trints_to_words+0x22>
c0d0046c:	4604      	mov	r4, r0
        trint_to_trits(trints_in[x], trits, get);
c0d0046e:	9802      	ldr	r0, [sp, #8]
c0d00470:	9103      	str	r1, [sp, #12]
c0d00472:	5640      	ldrsb	r0, [r0, r1]
c0d00474:	a913      	add	r1, sp, #76	; 0x4c
c0d00476:	4622      	mov	r2, r4
c0d00478:	f7ff fe76 	bl	c0d00168 <trint_to_trits>

        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0047c:	4840      	ldr	r0, [pc, #256]	; (c0d00580 <trints_to_words+0x134>)
c0d0047e:	1820      	adds	r0, r4, r0
c0d00480:	2306      	movs	r3, #6
c0d00482:	4003      	ands	r3, r0
c0d00484:	9005      	str	r0, [sp, #20]
c0d00486:	1e64      	subs	r4, r4, #1
            // multiply
            int32_t sz = size;
            {
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
c0d00488:	2d01      	cmp	r5, #1
c0d0048a:	462a      	mov	r2, r5
c0d0048c:	9406      	str	r4, [sp, #24]
c0d0048e:	db16      	blt.n	c0d004be <trints_to_words+0x72>
c0d00490:	9304      	str	r3, [sp, #16]
c0d00492:	2200      	movs	r2, #0
c0d00494:	4611      	mov	r1, r2
                  int64_t v = base[j] * RADIX + carry;// * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
c0d00496:	0093      	lsls	r3, r2, #2
c0d00498:	ac15      	add	r4, sp, #84	; 0x54
c0d0049a:	58e6      	ldr	r6, [r4, r3]
c0d0049c:	2003      	movs	r0, #3
c0d0049e:	4370      	muls	r0, r6
c0d004a0:	1840      	adds	r0, r0, r1
                  carry = (int32_t)((v >> 32));
                  base[j] = (int32_t) (v & 0xFFFFFFFF);
c0d004a2:	50e0      	str	r0, [r4, r3]
            int32_t sz = size;
            {
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
                  int64_t v = base[j] * RADIX + carry;// * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
c0d004a4:	17c1      	asrs	r1, r0, #31
            // multiply
            int32_t sz = size;
            {
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
c0d004a6:	1c52      	adds	r2, r2, #1
c0d004a8:	4295      	cmp	r5, r2
c0d004aa:	d1f4      	bne.n	c0d00496 <trints_to_words+0x4a>
                  int64_t v = base[j] * RADIX + carry;// * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
                  carry = (int32_t)((v >> 32));
                  base[j] = (int32_t) (v & 0xFFFFFFFF);
                }

                if (carry > 0) {
c0d004ac:	2900      	cmp	r1, #0
c0d004ae:	462a      	mov	r2, r5
c0d004b0:	9c06      	ldr	r4, [sp, #24]
c0d004b2:	9b04      	ldr	r3, [sp, #16]
c0d004b4:	dd03      	ble.n	c0d004be <trints_to_words+0x72>
                  base[sz] = carry;
c0d004b6:	00a8      	lsls	r0, r5, #2
c0d004b8:	aa15      	add	r2, sp, #84	; 0x54
c0d004ba:	5011      	str	r1, [r2, r0]
                  size++;
c0d004bc:	1c6a      	adds	r2, r5, #1

            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 && i == 2) {
c0d004be:	9803      	ldr	r0, [sp, #12]
c0d004c0:	2830      	cmp	r0, #48	; 0x30
c0d004c2:	9204      	str	r2, [sp, #16]
c0d004c4:	d105      	bne.n	c0d004d2 <trints_to_words+0x86>
c0d004c6:	b2a0      	uxth	r0, r4
c0d004c8:	2802      	cmp	r0, #2
c0d004ca:	d102      	bne.n	c0d004d2 <trints_to_words+0x86>
c0d004cc:	a815      	add	r0, sp, #84	; 0x54
                    bigint_add_int(base, 1, tmp, 12);
c0d004ce:	2101      	movs	r1, #1
c0d004d0:	e003      	b.n	c0d004da <trints_to_words+0x8e>
c0d004d2:	a813      	add	r0, sp, #76	; 0x4c
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 12);
c0d004d4:	56c0      	ldrsb	r0, [r0, r3]
c0d004d6:	1c41      	adds	r1, r0, #1
c0d004d8:	a815      	add	r0, sp, #84	; 0x54
c0d004da:	aa07      	add	r2, sp, #28
c0d004dc:	230c      	movs	r3, #12
c0d004de:	f7ff fed3 	bl	c0d00288 <bigint_add_int>
c0d004e2:	a807      	add	r0, sp, #28
c0d004e4:	a915      	add	r1, sp, #84	; 0x54
                }
                // bigint_add_int(base, trits[i]+1, tmp, 12);
                memcpy(base, tmp, 48);
c0d004e6:	c85c      	ldmia	r0!, {r2, r3, r4, r6}
c0d004e8:	c15c      	stmia	r1!, {r2, r3, r4, r6}
c0d004ea:	c85c      	ldmia	r0!, {r2, r3, r4, r6}
c0d004ec:	c15c      	stmia	r1!, {r2, r3, r4, r6}
c0d004ee:	c85c      	ldmia	r0!, {r2, r3, r4, r6}
c0d004f0:	c15c      	stmia	r1!, {r2, r3, r4, r6}
c0d004f2:	9804      	ldr	r0, [sp, #16]
                if (sz > size) {
c0d004f4:	4285      	cmp	r5, r0
c0d004f6:	dc00      	bgt.n	c0d004fa <trints_to_words+0xae>
c0d004f8:	4605      	mov	r5, r0
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], trits, get);

        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d004fa:	9805      	ldr	r0, [sp, #20]
c0d004fc:	1e40      	subs	r0, r0, #1
c0d004fe:	b203      	sxth	r3, r0
c0d00500:	2b00      	cmp	r3, #0
c0d00502:	4618      	mov	r0, r3
c0d00504:	9c06      	ldr	r4, [sp, #24]
c0d00506:	dabd      	bge.n	c0d00484 <trints_to_words+0x38>
c0d00508:	9903      	ldr	r1, [sp, #12]
    int32_t base[12] = {0};
    trit_t trits[5]; // on final call only left 3 trits matter

    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d0050a:	1e48      	subs	r0, r1, #1
c0d0050c:	2900      	cmp	r1, #0
c0d0050e:	4601      	mov	r1, r0
c0d00510:	dca8      	bgt.n	c0d00464 <trints_to_words+0x18>
                }
            }
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 12) <= 0 ) {
c0d00512:	481c      	ldr	r0, [pc, #112]	; (c0d00584 <trints_to_words+0x138>)
c0d00514:	4478      	add	r0, pc
c0d00516:	a915      	add	r1, sp, #84	; 0x54
c0d00518:	220c      	movs	r2, #12
c0d0051a:	f7ff ff3b 	bl	c0d00394 <bigint_cmp_bigint>
c0d0051e:	2801      	cmp	r0, #1
c0d00520:	db14      	blt.n	c0d0054c <trints_to_words+0x100>
        int32_t tmp[12];
        bigint_sub_bigint(base, HALF_3, tmp, 12);
        memcpy(base, tmp, 48);
    } else {
        int32_t tmp[12];
        bigint_sub_bigint(HALF_3, base, tmp, 12);
c0d00522:	481a      	ldr	r0, [pc, #104]	; (c0d0058c <trints_to_words+0x140>)
c0d00524:	4478      	add	r0, pc
c0d00526:	ac15      	add	r4, sp, #84	; 0x54
c0d00528:	ae07      	add	r6, sp, #28
c0d0052a:	250c      	movs	r5, #12
c0d0052c:	4621      	mov	r1, r4
c0d0052e:	4632      	mov	r2, r6
c0d00530:	462b      	mov	r3, r5
c0d00532:	f7ff feee 	bl	c0d00312 <bigint_sub_bigint>
        bigint_not(tmp, 12);
c0d00536:	4630      	mov	r0, r6
c0d00538:	4629      	mov	r1, r5
c0d0053a:	f7ff ff4a 	bl	c0d003d2 <bigint_not>
        bigint_add_int(tmp, 1, base, 12);
c0d0053e:	2101      	movs	r1, #1
c0d00540:	4630      	mov	r0, r6
c0d00542:	4622      	mov	r2, r4
c0d00544:	462b      	mov	r3, r5
c0d00546:	f7ff fe9f 	bl	c0d00288 <bigint_add_int>
c0d0054a:	e00e      	b.n	c0d0056a <trints_to_words+0x11e>
c0d0054c:	ac15      	add	r4, sp, #84	; 0x54
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 12) <= 0 ) {
        int32_t tmp[12];
        bigint_sub_bigint(base, HALF_3, tmp, 12);
c0d0054e:	490e      	ldr	r1, [pc, #56]	; (c0d00588 <trints_to_words+0x13c>)
c0d00550:	4479      	add	r1, pc
c0d00552:	ad07      	add	r5, sp, #28
c0d00554:	230c      	movs	r3, #12
c0d00556:	4620      	mov	r0, r4
c0d00558:	462a      	mov	r2, r5
c0d0055a:	f7ff feda 	bl	c0d00312 <bigint_sub_bigint>
        memcpy(base, tmp, 48);
c0d0055e:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00560:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d00562:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00564:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d00566:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00568:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d0056a:	a815      	add	r0, sp, #84	; 0x54
c0d0056c:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 12);
        bigint_add_int(tmp, 1, base, 12);
    }


    memcpy(words_out, base, 48);
c0d0056e:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00570:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00572:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00574:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00576:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00578:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d0057a:	2000      	movs	r0, #0
c0d0057c:	b021      	add	sp, #132	; 0x84
c0d0057e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00580:	0000ffff 	.word	0x0000ffff
c0d00584:	00002eb8 	.word	0x00002eb8
c0d00588:	00002e7c 	.word	0x00002e7c
c0d0058c:	00002ea8 	.word	0x00002ea8

c0d00590 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00590:	b580      	push	{r7, lr}
c0d00592:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00594:	2003      	movs	r0, #3
c0d00596:	01c1      	lsls	r1, r0, #7
c0d00598:	4802      	ldr	r0, [pc, #8]	; (c0d005a4 <kerl_initialize+0x14>)
c0d0059a:	f001 fafd 	bl	c0d01b98 <cx_keccak_init>
    return 0;
c0d0059e:	2000      	movs	r0, #0
c0d005a0:	bd80      	pop	{r7, pc}
c0d005a2:	46c0      	nop			; (mov r8, r8)
c0d005a4:	20001840 	.word	0x20001840

c0d005a8 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d005a8:	b580      	push	{r7, lr}
c0d005aa:	af00      	add	r7, sp, #0
c0d005ac:	b082      	sub	sp, #8
c0d005ae:	460b      	mov	r3, r1
c0d005b0:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d005b2:	4805      	ldr	r0, [pc, #20]	; (c0d005c8 <kerl_absorb_bytes+0x20>)
c0d005b4:	4669      	mov	r1, sp
c0d005b6:	6008      	str	r0, [r1, #0]
c0d005b8:	4804      	ldr	r0, [pc, #16]	; (c0d005cc <kerl_absorb_bytes+0x24>)
c0d005ba:	2101      	movs	r1, #1
c0d005bc:	f001 fb0a 	bl	c0d01bd4 <cx_hash>
c0d005c0:	2000      	movs	r0, #0
    return 0;
c0d005c2:	b002      	add	sp, #8
c0d005c4:	bd80      	pop	{r7, pc}
c0d005c6:	46c0      	nop			; (mov r8, r8)
c0d005c8:	200019e8 	.word	0x200019e8
c0d005cc:	20001840 	.word	0x20001840

c0d005d0 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d005d0:	b580      	push	{r7, lr}
c0d005d2:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d005d4:	4804      	ldr	r0, [pc, #16]	; (c0d005e8 <nvram_is_init+0x18>)
c0d005d6:	f001 fa33 	bl	c0d01a40 <pic>
c0d005da:	7801      	ldrb	r1, [r0, #0]
c0d005dc:	2000      	movs	r0, #0
c0d005de:	2901      	cmp	r1, #1
c0d005e0:	d100      	bne.n	c0d005e4 <nvram_is_init+0x14>
c0d005e2:	4608      	mov	r0, r1
    else return true;
}
c0d005e4:	bd80      	pop	{r7, pc}
c0d005e6:	46c0      	nop			; (mov r8, r8)
c0d005e8:	c0d037c0 	.word	0xc0d037c0

c0d005ec <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d005ec:	b5b0      	push	{r4, r5, r7, lr}
c0d005ee:	af02      	add	r7, sp, #8
c0d005f0:	4605      	mov	r5, r0
c0d005f2:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d005f4:	4028      	ands	r0, r5
c0d005f6:	2400      	movs	r4, #0
c0d005f8:	2801      	cmp	r0, #1
c0d005fa:	d013      	beq.n	c0d00624 <io_exchange_al+0x38>
c0d005fc:	2802      	cmp	r0, #2
c0d005fe:	d113      	bne.n	c0d00628 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00600:	2900      	cmp	r1, #0
c0d00602:	d008      	beq.n	c0d00616 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00604:	480b      	ldr	r0, [pc, #44]	; (c0d00634 <io_exchange_al+0x48>)
c0d00606:	f001 fbd7 	bl	c0d01db8 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d0060a:	b268      	sxtb	r0, r5
c0d0060c:	2800      	cmp	r0, #0
c0d0060e:	da09      	bge.n	c0d00624 <io_exchange_al+0x38>
                reset();
c0d00610:	f001 fa4c 	bl	c0d01aac <reset>
c0d00614:	e006      	b.n	c0d00624 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00616:	2041      	movs	r0, #65	; 0x41
c0d00618:	0081      	lsls	r1, r0, #2
c0d0061a:	4806      	ldr	r0, [pc, #24]	; (c0d00634 <io_exchange_al+0x48>)
c0d0061c:	2200      	movs	r2, #0
c0d0061e:	f001 fc05 	bl	c0d01e2c <io_seproxyhal_spi_recv>
c0d00622:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00624:	4620      	mov	r0, r4
c0d00626:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00628:	4803      	ldr	r0, [pc, #12]	; (c0d00638 <io_exchange_al+0x4c>)
c0d0062a:	6800      	ldr	r0, [r0, #0]
c0d0062c:	2102      	movs	r1, #2
c0d0062e:	f002 fe39 	bl	c0d032a4 <longjmp>
c0d00632:	46c0      	nop			; (mov r8, r8)
c0d00634:	20001c08 	.word	0x20001c08
c0d00638:	20001bb8 	.word	0x20001bb8

c0d0063c <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d0063c:	b580      	push	{r7, lr}
c0d0063e:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00640:	f000 fe8e 	bl	c0d01360 <io_seproxyhal_display_default>
}
c0d00644:	bd80      	pop	{r7, pc}
	...

c0d00648 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00648:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0064a:	af03      	add	r7, sp, #12
c0d0064c:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0064e:	48a6      	ldr	r0, [pc, #664]	; (c0d008e8 <io_event+0x2a0>)
c0d00650:	7800      	ldrb	r0, [r0, #0]
c0d00652:	2805      	cmp	r0, #5
c0d00654:	d02e      	beq.n	c0d006b4 <io_event+0x6c>
c0d00656:	280d      	cmp	r0, #13
c0d00658:	d04e      	beq.n	c0d006f8 <io_event+0xb0>
c0d0065a:	280c      	cmp	r0, #12
c0d0065c:	d000      	beq.n	c0d00660 <io_event+0x18>
c0d0065e:	e13a      	b.n	c0d008d6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00660:	4ea2      	ldr	r6, [pc, #648]	; (c0d008ec <io_event+0x2a4>)
c0d00662:	2001      	movs	r0, #1
c0d00664:	7630      	strb	r0, [r6, #24]
c0d00666:	2500      	movs	r5, #0
c0d00668:	61f5      	str	r5, [r6, #28]
c0d0066a:	4634      	mov	r4, r6
c0d0066c:	3418      	adds	r4, #24
c0d0066e:	4620      	mov	r0, r4
c0d00670:	f001 fb68 	bl	c0d01d44 <os_ux>
c0d00674:	61f0      	str	r0, [r6, #28]
c0d00676:	499e      	ldr	r1, [pc, #632]	; (c0d008f0 <io_event+0x2a8>)
c0d00678:	4288      	cmp	r0, r1
c0d0067a:	d100      	bne.n	c0d0067e <io_event+0x36>
c0d0067c:	e12b      	b.n	c0d008d6 <io_event+0x28e>
c0d0067e:	2800      	cmp	r0, #0
c0d00680:	d100      	bne.n	c0d00684 <io_event+0x3c>
c0d00682:	e128      	b.n	c0d008d6 <io_event+0x28e>
c0d00684:	499b      	ldr	r1, [pc, #620]	; (c0d008f4 <io_event+0x2ac>)
c0d00686:	4288      	cmp	r0, r1
c0d00688:	d000      	beq.n	c0d0068c <io_event+0x44>
c0d0068a:	e0ac      	b.n	c0d007e6 <io_event+0x19e>
c0d0068c:	2003      	movs	r0, #3
c0d0068e:	7630      	strb	r0, [r6, #24]
c0d00690:	61f5      	str	r5, [r6, #28]
c0d00692:	4620      	mov	r0, r4
c0d00694:	f001 fb56 	bl	c0d01d44 <os_ux>
c0d00698:	61f0      	str	r0, [r6, #28]
c0d0069a:	f000 fd17 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d0069e:	60b5      	str	r5, [r6, #8]
c0d006a0:	6830      	ldr	r0, [r6, #0]
c0d006a2:	2800      	cmp	r0, #0
c0d006a4:	d100      	bne.n	c0d006a8 <io_event+0x60>
c0d006a6:	e116      	b.n	c0d008d6 <io_event+0x28e>
c0d006a8:	69f0      	ldr	r0, [r6, #28]
c0d006aa:	4991      	ldr	r1, [pc, #580]	; (c0d008f0 <io_event+0x2a8>)
c0d006ac:	4288      	cmp	r0, r1
c0d006ae:	d000      	beq.n	c0d006b2 <io_event+0x6a>
c0d006b0:	e096      	b.n	c0d007e0 <io_event+0x198>
c0d006b2:	e110      	b.n	c0d008d6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d006b4:	4d8d      	ldr	r5, [pc, #564]	; (c0d008ec <io_event+0x2a4>)
c0d006b6:	2001      	movs	r0, #1
c0d006b8:	7628      	strb	r0, [r5, #24]
c0d006ba:	2600      	movs	r6, #0
c0d006bc:	61ee      	str	r6, [r5, #28]
c0d006be:	462c      	mov	r4, r5
c0d006c0:	3418      	adds	r4, #24
c0d006c2:	4620      	mov	r0, r4
c0d006c4:	f001 fb3e 	bl	c0d01d44 <os_ux>
c0d006c8:	4601      	mov	r1, r0
c0d006ca:	61e9      	str	r1, [r5, #28]
c0d006cc:	4889      	ldr	r0, [pc, #548]	; (c0d008f4 <io_event+0x2ac>)
c0d006ce:	4281      	cmp	r1, r0
c0d006d0:	d15d      	bne.n	c0d0078e <io_event+0x146>
c0d006d2:	2003      	movs	r0, #3
c0d006d4:	7628      	strb	r0, [r5, #24]
c0d006d6:	61ee      	str	r6, [r5, #28]
c0d006d8:	4620      	mov	r0, r4
c0d006da:	f001 fb33 	bl	c0d01d44 <os_ux>
c0d006de:	61e8      	str	r0, [r5, #28]
c0d006e0:	f000 fcf4 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d006e4:	60ae      	str	r6, [r5, #8]
c0d006e6:	6828      	ldr	r0, [r5, #0]
c0d006e8:	2800      	cmp	r0, #0
c0d006ea:	d100      	bne.n	c0d006ee <io_event+0xa6>
c0d006ec:	e0f3      	b.n	c0d008d6 <io_event+0x28e>
c0d006ee:	69e8      	ldr	r0, [r5, #28]
c0d006f0:	497f      	ldr	r1, [pc, #508]	; (c0d008f0 <io_event+0x2a8>)
c0d006f2:	4288      	cmp	r0, r1
c0d006f4:	d148      	bne.n	c0d00788 <io_event+0x140>
c0d006f6:	e0ee      	b.n	c0d008d6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d006f8:	4d7c      	ldr	r5, [pc, #496]	; (c0d008ec <io_event+0x2a4>)
c0d006fa:	6868      	ldr	r0, [r5, #4]
c0d006fc:	68a9      	ldr	r1, [r5, #8]
c0d006fe:	4281      	cmp	r1, r0
c0d00700:	d300      	bcc.n	c0d00704 <io_event+0xbc>
c0d00702:	e0e8      	b.n	c0d008d6 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00704:	2001      	movs	r0, #1
c0d00706:	7628      	strb	r0, [r5, #24]
c0d00708:	2600      	movs	r6, #0
c0d0070a:	61ee      	str	r6, [r5, #28]
c0d0070c:	462c      	mov	r4, r5
c0d0070e:	3418      	adds	r4, #24
c0d00710:	4620      	mov	r0, r4
c0d00712:	f001 fb17 	bl	c0d01d44 <os_ux>
c0d00716:	61e8      	str	r0, [r5, #28]
c0d00718:	4975      	ldr	r1, [pc, #468]	; (c0d008f0 <io_event+0x2a8>)
c0d0071a:	4288      	cmp	r0, r1
c0d0071c:	d100      	bne.n	c0d00720 <io_event+0xd8>
c0d0071e:	e0da      	b.n	c0d008d6 <io_event+0x28e>
c0d00720:	2800      	cmp	r0, #0
c0d00722:	d100      	bne.n	c0d00726 <io_event+0xde>
c0d00724:	e0d7      	b.n	c0d008d6 <io_event+0x28e>
c0d00726:	4973      	ldr	r1, [pc, #460]	; (c0d008f4 <io_event+0x2ac>)
c0d00728:	4288      	cmp	r0, r1
c0d0072a:	d000      	beq.n	c0d0072e <io_event+0xe6>
c0d0072c:	e08d      	b.n	c0d0084a <io_event+0x202>
c0d0072e:	2003      	movs	r0, #3
c0d00730:	7628      	strb	r0, [r5, #24]
c0d00732:	61ee      	str	r6, [r5, #28]
c0d00734:	4620      	mov	r0, r4
c0d00736:	f001 fb05 	bl	c0d01d44 <os_ux>
c0d0073a:	61e8      	str	r0, [r5, #28]
c0d0073c:	f000 fcc6 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d00740:	60ae      	str	r6, [r5, #8]
c0d00742:	6828      	ldr	r0, [r5, #0]
c0d00744:	2800      	cmp	r0, #0
c0d00746:	d100      	bne.n	c0d0074a <io_event+0x102>
c0d00748:	e0c5      	b.n	c0d008d6 <io_event+0x28e>
c0d0074a:	69e8      	ldr	r0, [r5, #28]
c0d0074c:	4968      	ldr	r1, [pc, #416]	; (c0d008f0 <io_event+0x2a8>)
c0d0074e:	4288      	cmp	r0, r1
c0d00750:	d178      	bne.n	c0d00844 <io_event+0x1fc>
c0d00752:	e0c0      	b.n	c0d008d6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00754:	6868      	ldr	r0, [r5, #4]
c0d00756:	4286      	cmp	r6, r0
c0d00758:	d300      	bcc.n	c0d0075c <io_event+0x114>
c0d0075a:	e0bc      	b.n	c0d008d6 <io_event+0x28e>
c0d0075c:	f001 fb4a 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d00760:	2800      	cmp	r0, #0
c0d00762:	d000      	beq.n	c0d00766 <io_event+0x11e>
c0d00764:	e0b7      	b.n	c0d008d6 <io_event+0x28e>
c0d00766:	68a8      	ldr	r0, [r5, #8]
c0d00768:	68e9      	ldr	r1, [r5, #12]
c0d0076a:	2438      	movs	r4, #56	; 0x38
c0d0076c:	4360      	muls	r0, r4
c0d0076e:	682a      	ldr	r2, [r5, #0]
c0d00770:	1810      	adds	r0, r2, r0
c0d00772:	2900      	cmp	r1, #0
c0d00774:	d100      	bne.n	c0d00778 <io_event+0x130>
c0d00776:	e085      	b.n	c0d00884 <io_event+0x23c>
c0d00778:	4788      	blx	r1
c0d0077a:	2800      	cmp	r0, #0
c0d0077c:	d000      	beq.n	c0d00780 <io_event+0x138>
c0d0077e:	e081      	b.n	c0d00884 <io_event+0x23c>
c0d00780:	68a8      	ldr	r0, [r5, #8]
c0d00782:	1c46      	adds	r6, r0, #1
c0d00784:	60ae      	str	r6, [r5, #8]
c0d00786:	6828      	ldr	r0, [r5, #0]
c0d00788:	2800      	cmp	r0, #0
c0d0078a:	d1e3      	bne.n	c0d00754 <io_event+0x10c>
c0d0078c:	e0a3      	b.n	c0d008d6 <io_event+0x28e>
c0d0078e:	6928      	ldr	r0, [r5, #16]
c0d00790:	2800      	cmp	r0, #0
c0d00792:	d100      	bne.n	c0d00796 <io_event+0x14e>
c0d00794:	e09f      	b.n	c0d008d6 <io_event+0x28e>
c0d00796:	4a56      	ldr	r2, [pc, #344]	; (c0d008f0 <io_event+0x2a8>)
c0d00798:	4291      	cmp	r1, r2
c0d0079a:	d100      	bne.n	c0d0079e <io_event+0x156>
c0d0079c:	e09b      	b.n	c0d008d6 <io_event+0x28e>
c0d0079e:	2900      	cmp	r1, #0
c0d007a0:	d100      	bne.n	c0d007a4 <io_event+0x15c>
c0d007a2:	e098      	b.n	c0d008d6 <io_event+0x28e>
c0d007a4:	4950      	ldr	r1, [pc, #320]	; (c0d008e8 <io_event+0x2a0>)
c0d007a6:	78c9      	ldrb	r1, [r1, #3]
c0d007a8:	0849      	lsrs	r1, r1, #1
c0d007aa:	f000 fe1b 	bl	c0d013e4 <io_seproxyhal_button_push>
c0d007ae:	e092      	b.n	c0d008d6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d007b0:	6870      	ldr	r0, [r6, #4]
c0d007b2:	4285      	cmp	r5, r0
c0d007b4:	d300      	bcc.n	c0d007b8 <io_event+0x170>
c0d007b6:	e08e      	b.n	c0d008d6 <io_event+0x28e>
c0d007b8:	f001 fb1c 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d007bc:	2800      	cmp	r0, #0
c0d007be:	d000      	beq.n	c0d007c2 <io_event+0x17a>
c0d007c0:	e089      	b.n	c0d008d6 <io_event+0x28e>
c0d007c2:	68b0      	ldr	r0, [r6, #8]
c0d007c4:	68f1      	ldr	r1, [r6, #12]
c0d007c6:	2438      	movs	r4, #56	; 0x38
c0d007c8:	4360      	muls	r0, r4
c0d007ca:	6832      	ldr	r2, [r6, #0]
c0d007cc:	1810      	adds	r0, r2, r0
c0d007ce:	2900      	cmp	r1, #0
c0d007d0:	d076      	beq.n	c0d008c0 <io_event+0x278>
c0d007d2:	4788      	blx	r1
c0d007d4:	2800      	cmp	r0, #0
c0d007d6:	d173      	bne.n	c0d008c0 <io_event+0x278>
c0d007d8:	68b0      	ldr	r0, [r6, #8]
c0d007da:	1c45      	adds	r5, r0, #1
c0d007dc:	60b5      	str	r5, [r6, #8]
c0d007de:	6830      	ldr	r0, [r6, #0]
c0d007e0:	2800      	cmp	r0, #0
c0d007e2:	d1e5      	bne.n	c0d007b0 <io_event+0x168>
c0d007e4:	e077      	b.n	c0d008d6 <io_event+0x28e>
c0d007e6:	88b0      	ldrh	r0, [r6, #4]
c0d007e8:	9004      	str	r0, [sp, #16]
c0d007ea:	6830      	ldr	r0, [r6, #0]
c0d007ec:	9003      	str	r0, [sp, #12]
c0d007ee:	483e      	ldr	r0, [pc, #248]	; (c0d008e8 <io_event+0x2a0>)
c0d007f0:	4601      	mov	r1, r0
c0d007f2:	79cc      	ldrb	r4, [r1, #7]
c0d007f4:	798b      	ldrb	r3, [r1, #6]
c0d007f6:	794d      	ldrb	r5, [r1, #5]
c0d007f8:	790a      	ldrb	r2, [r1, #4]
c0d007fa:	4630      	mov	r0, r6
c0d007fc:	78ce      	ldrb	r6, [r1, #3]
c0d007fe:	68c1      	ldr	r1, [r0, #12]
c0d00800:	4668      	mov	r0, sp
c0d00802:	6006      	str	r6, [r0, #0]
c0d00804:	6041      	str	r1, [r0, #4]
c0d00806:	0212      	lsls	r2, r2, #8
c0d00808:	432a      	orrs	r2, r5
c0d0080a:	021b      	lsls	r3, r3, #8
c0d0080c:	4323      	orrs	r3, r4
c0d0080e:	9803      	ldr	r0, [sp, #12]
c0d00810:	9904      	ldr	r1, [sp, #16]
c0d00812:	f000 fcd5 	bl	c0d011c0 <io_seproxyhal_touch_element_callback>
c0d00816:	e05e      	b.n	c0d008d6 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00818:	6868      	ldr	r0, [r5, #4]
c0d0081a:	4286      	cmp	r6, r0
c0d0081c:	d25b      	bcs.n	c0d008d6 <io_event+0x28e>
c0d0081e:	f001 fae9 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d00822:	2800      	cmp	r0, #0
c0d00824:	d157      	bne.n	c0d008d6 <io_event+0x28e>
c0d00826:	68a8      	ldr	r0, [r5, #8]
c0d00828:	68e9      	ldr	r1, [r5, #12]
c0d0082a:	2438      	movs	r4, #56	; 0x38
c0d0082c:	4360      	muls	r0, r4
c0d0082e:	682a      	ldr	r2, [r5, #0]
c0d00830:	1810      	adds	r0, r2, r0
c0d00832:	2900      	cmp	r1, #0
c0d00834:	d026      	beq.n	c0d00884 <io_event+0x23c>
c0d00836:	4788      	blx	r1
c0d00838:	2800      	cmp	r0, #0
c0d0083a:	d123      	bne.n	c0d00884 <io_event+0x23c>
c0d0083c:	68a8      	ldr	r0, [r5, #8]
c0d0083e:	1c46      	adds	r6, r0, #1
c0d00840:	60ae      	str	r6, [r5, #8]
c0d00842:	6828      	ldr	r0, [r5, #0]
c0d00844:	2800      	cmp	r0, #0
c0d00846:	d1e7      	bne.n	c0d00818 <io_event+0x1d0>
c0d00848:	e045      	b.n	c0d008d6 <io_event+0x28e>
c0d0084a:	6828      	ldr	r0, [r5, #0]
c0d0084c:	2800      	cmp	r0, #0
c0d0084e:	d030      	beq.n	c0d008b2 <io_event+0x26a>
c0d00850:	68a8      	ldr	r0, [r5, #8]
c0d00852:	6869      	ldr	r1, [r5, #4]
c0d00854:	4288      	cmp	r0, r1
c0d00856:	d22c      	bcs.n	c0d008b2 <io_event+0x26a>
c0d00858:	f001 facc 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d0085c:	2800      	cmp	r0, #0
c0d0085e:	d128      	bne.n	c0d008b2 <io_event+0x26a>
c0d00860:	68a8      	ldr	r0, [r5, #8]
c0d00862:	68e9      	ldr	r1, [r5, #12]
c0d00864:	2438      	movs	r4, #56	; 0x38
c0d00866:	4360      	muls	r0, r4
c0d00868:	682a      	ldr	r2, [r5, #0]
c0d0086a:	1810      	adds	r0, r2, r0
c0d0086c:	2900      	cmp	r1, #0
c0d0086e:	d015      	beq.n	c0d0089c <io_event+0x254>
c0d00870:	4788      	blx	r1
c0d00872:	2800      	cmp	r0, #0
c0d00874:	d112      	bne.n	c0d0089c <io_event+0x254>
c0d00876:	68a8      	ldr	r0, [r5, #8]
c0d00878:	1c40      	adds	r0, r0, #1
c0d0087a:	60a8      	str	r0, [r5, #8]
c0d0087c:	6829      	ldr	r1, [r5, #0]
c0d0087e:	2900      	cmp	r1, #0
c0d00880:	d1e7      	bne.n	c0d00852 <io_event+0x20a>
c0d00882:	e016      	b.n	c0d008b2 <io_event+0x26a>
c0d00884:	2801      	cmp	r0, #1
c0d00886:	d103      	bne.n	c0d00890 <io_event+0x248>
c0d00888:	68a8      	ldr	r0, [r5, #8]
c0d0088a:	4344      	muls	r4, r0
c0d0088c:	6828      	ldr	r0, [r5, #0]
c0d0088e:	1900      	adds	r0, r0, r4
c0d00890:	f000 fd66 	bl	c0d01360 <io_seproxyhal_display_default>
c0d00894:	68a8      	ldr	r0, [r5, #8]
c0d00896:	1c40      	adds	r0, r0, #1
c0d00898:	60a8      	str	r0, [r5, #8]
c0d0089a:	e01c      	b.n	c0d008d6 <io_event+0x28e>
c0d0089c:	2801      	cmp	r0, #1
c0d0089e:	d103      	bne.n	c0d008a8 <io_event+0x260>
c0d008a0:	68a8      	ldr	r0, [r5, #8]
c0d008a2:	4344      	muls	r4, r0
c0d008a4:	6828      	ldr	r0, [r5, #0]
c0d008a6:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d008a8:	f000 fd5a 	bl	c0d01360 <io_seproxyhal_display_default>
c0d008ac:	68a8      	ldr	r0, [r5, #8]
c0d008ae:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d008b0:	60a8      	str	r0, [r5, #8]
c0d008b2:	6868      	ldr	r0, [r5, #4]
c0d008b4:	68a9      	ldr	r1, [r5, #8]
c0d008b6:	4281      	cmp	r1, r0
c0d008b8:	d30d      	bcc.n	c0d008d6 <io_event+0x28e>
c0d008ba:	f001 fa9b 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d008be:	e00a      	b.n	c0d008d6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d008c0:	2801      	cmp	r0, #1
c0d008c2:	d103      	bne.n	c0d008cc <io_event+0x284>
c0d008c4:	68b0      	ldr	r0, [r6, #8]
c0d008c6:	4344      	muls	r4, r0
c0d008c8:	6830      	ldr	r0, [r6, #0]
c0d008ca:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d008cc:	f000 fd48 	bl	c0d01360 <io_seproxyhal_display_default>
c0d008d0:	68b0      	ldr	r0, [r6, #8]
c0d008d2:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d008d4:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d008d6:	f001 fa8d 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d008da:	2800      	cmp	r0, #0
c0d008dc:	d101      	bne.n	c0d008e2 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d008de:	f000 fac9 	bl	c0d00e74 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d008e2:	2001      	movs	r0, #1
c0d008e4:	b005      	add	sp, #20
c0d008e6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008e8:	20001a18 	.word	0x20001a18
c0d008ec:	20001a98 	.word	0x20001a98
c0d008f0:	b0105044 	.word	0xb0105044
c0d008f4:	b0105055 	.word	0xb0105055

c0d008f8 <IOTA_main>:





static void IOTA_main(void) {
c0d008f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008fa:	af03      	add	r7, sp, #12
c0d008fc:	b0dd      	sub	sp, #372	; 0x174
c0d008fe:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00900:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00902:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00904:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00906:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00b8c <IOTA_main+0x294>)
c0d00908:	2110      	movs	r1, #16
c0d0090a:	2203      	movs	r2, #3
c0d0090c:	9109      	str	r1, [sp, #36]	; 0x24
c0d0090e:	9208      	str	r2, [sp, #32]
c0d00910:	f7ff fbc8 	bl	c0d000a4 <write_debug>
c0d00914:	a80e      	add	r0, sp, #56	; 0x38
c0d00916:	304d      	adds	r0, #77	; 0x4d
c0d00918:	9007      	str	r0, [sp, #28]
c0d0091a:	a80b      	add	r0, sp, #44	; 0x2c
c0d0091c:	1dc1      	adds	r1, r0, #7
c0d0091e:	9106      	str	r1, [sp, #24]
c0d00920:	1d00      	adds	r0, r0, #4
c0d00922:	9005      	str	r0, [sp, #20]
c0d00924:	4e9d      	ldr	r6, [pc, #628]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00926:	6830      	ldr	r0, [r6, #0]
c0d00928:	e08d      	b.n	c0d00a46 <IOTA_main+0x14e>
c0d0092a:	489f      	ldr	r0, [pc, #636]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d0092c:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d0092e:	4330      	orrs	r0, r6
c0d00930:	2880      	cmp	r0, #128	; 0x80
c0d00932:	d000      	beq.n	c0d00936 <IOTA_main+0x3e>
c0d00934:	e11e      	b.n	c0d00b74 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00936:	7810      	ldrb	r0, [r2, #0]
c0d00938:	2800      	cmp	r0, #0
c0d0093a:	4e98      	ldr	r6, [pc, #608]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d0093c:	d004      	beq.n	c0d00948 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d0093e:	489c      	ldr	r0, [pc, #624]	; (c0d00bb0 <IOTA_main+0x2b8>)
c0d00940:	f001 f90c 	bl	c0d01b5c <cx_sha256_init>
                        hashTainted = 0;
c0d00944:	4899      	ldr	r0, [pc, #612]	; (c0d00bac <IOTA_main+0x2b4>)
c0d00946:	7004      	strb	r4, [r0, #0]
c0d00948:	4897      	ldr	r0, [pc, #604]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d0094a:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d0094c:	7908      	ldrb	r0, [r1, #4]
c0d0094e:	1808      	adds	r0, r1, r0
c0d00950:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00952:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00954:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00956:	4308      	orrs	r0, r1
c0d00958:	905a      	str	r0, [sp, #360]	; 0x168
c0d0095a:	e0e5      	b.n	c0d00b28 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d0095c:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d0095e:	2818      	cmp	r0, #24
c0d00960:	d800      	bhi.n	c0d00964 <IOTA_main+0x6c>
c0d00962:	e10c      	b.n	c0d00b7e <IOTA_main+0x286>
c0d00964:	950a      	str	r5, [sp, #40]	; 0x28
c0d00966:	4d90      	ldr	r5, [pc, #576]	; (c0d00ba8 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00968:	00a0      	lsls	r0, r4, #2
c0d0096a:	1829      	adds	r1, r5, r0
c0d0096c:	794a      	ldrb	r2, [r1, #5]
c0d0096e:	0612      	lsls	r2, r2, #24
c0d00970:	798b      	ldrb	r3, [r1, #6]
c0d00972:	041b      	lsls	r3, r3, #16
c0d00974:	4313      	orrs	r3, r2
c0d00976:	79ca      	ldrb	r2, [r1, #7]
c0d00978:	0212      	lsls	r2, r2, #8
c0d0097a:	431a      	orrs	r2, r3
c0d0097c:	7a09      	ldrb	r1, [r1, #8]
c0d0097e:	4311      	orrs	r1, r2
c0d00980:	aa2b      	add	r2, sp, #172	; 0xac
c0d00982:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00984:	1c64      	adds	r4, r4, #1
c0d00986:	2c05      	cmp	r4, #5
c0d00988:	d1ee      	bne.n	c0d00968 <IOTA_main+0x70>
c0d0098a:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d0098c:	9103      	str	r1, [sp, #12]
c0d0098e:	4668      	mov	r0, sp
c0d00990:	6001      	str	r1, [r0, #0]
c0d00992:	2421      	movs	r4, #33	; 0x21
c0d00994:	a92b      	add	r1, sp, #172	; 0xac
c0d00996:	2205      	movs	r2, #5
c0d00998:	ad23      	add	r5, sp, #140	; 0x8c
c0d0099a:	9502      	str	r5, [sp, #8]
c0d0099c:	4620      	mov	r0, r4
c0d0099e:	462b      	mov	r3, r5
c0d009a0:	f001 f992 	bl	c0d01cc8 <os_perso_derive_node_bip32>
c0d009a4:	2220      	movs	r2, #32
c0d009a6:	9204      	str	r2, [sp, #16]
c0d009a8:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d009aa:	9301      	str	r3, [sp, #4]
c0d009ac:	4620      	mov	r0, r4
c0d009ae:	4629      	mov	r1, r5
c0d009b0:	f001 f94e 	bl	c0d01c50 <cx_ecfp_init_private_key>
c0d009b4:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d009b6:	4620      	mov	r0, r4
c0d009b8:	9903      	ldr	r1, [sp, #12]
c0d009ba:	460a      	mov	r2, r1
c0d009bc:	462b      	mov	r3, r5
c0d009be:	f001 f929 	bl	c0d01c14 <cx_ecfp_init_public_key>
c0d009c2:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d009c4:	4620      	mov	r0, r4
c0d009c6:	4629      	mov	r1, r5
c0d009c8:	9a01      	ldr	r2, [sp, #4]
c0d009ca:	f001 f95f 	bl	c0d01c8c <cx_ecfp_generate_pair>
c0d009ce:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d009d0:	9802      	ldr	r0, [sp, #8]
c0d009d2:	9904      	ldr	r1, [sp, #16]
c0d009d4:	4622      	mov	r2, r4
c0d009d6:	f7ff fbff 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d009da:	2552      	movs	r5, #82	; 0x52
c0d009dc:	4872      	ldr	r0, [pc, #456]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d009de:	4621      	mov	r1, r4
c0d009e0:	462a      	mov	r2, r5
c0d009e2:	f000 f9ad 	bl	c0d00d40 <os_memmove>
                    tx = 82;
c0d009e6:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d009e8:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009ea:	1c41      	adds	r1, r0, #1
c0d009ec:	915b      	str	r1, [sp, #364]	; 0x16c
c0d009ee:	3610      	adds	r6, #16
c0d009f0:	4a6d      	ldr	r2, [pc, #436]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d009f2:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d009f4:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009f6:	1c41      	adds	r1, r0, #1
c0d009f8:	915b      	str	r1, [sp, #364]	; 0x16c
c0d009fa:	9903      	ldr	r1, [sp, #12]
c0d009fc:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d009fe:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a00:	b281      	uxth	r1, r0
c0d00a02:	9804      	ldr	r0, [sp, #16]
c0d00a04:	f000 fd2a 	bl	c0d0145c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00a08:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00a0a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00a0c:	4308      	orrs	r0, r1
c0d00a0e:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00a10:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00a12:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00a14:	202e      	movs	r0, #46	; 0x2e
c0d00a16:	9905      	ldr	r1, [sp, #20]
c0d00a18:	7048      	strb	r0, [r1, #1]
c0d00a1a:	7008      	strb	r0, [r1, #0]
c0d00a1c:	7088      	strb	r0, [r1, #2]
c0d00a1e:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00a20:	78c8      	ldrb	r0, [r1, #3]
c0d00a22:	9a06      	ldr	r2, [sp, #24]
c0d00a24:	70d0      	strb	r0, [r2, #3]
c0d00a26:	7888      	ldrb	r0, [r1, #2]
c0d00a28:	7090      	strb	r0, [r2, #2]
c0d00a2a:	7848      	ldrb	r0, [r1, #1]
c0d00a2c:	7050      	strb	r0, [r2, #1]
c0d00a2e:	7808      	ldrb	r0, [r1, #0]
c0d00a30:	7010      	strb	r0, [r2, #0]
c0d00a32:	7908      	ldrb	r0, [r1, #4]
c0d00a34:	7110      	strb	r0, [r2, #4]
c0d00a36:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00a38:	2140      	movs	r1, #64	; 0x40
c0d00a3a:	2203      	movs	r2, #3
c0d00a3c:	f001 fa8a 	bl	c0d01f54 <ui_display_debug>
c0d00a40:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00a42:	4e56      	ldr	r6, [pc, #344]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00a44:	e070      	b.n	c0d00b28 <IOTA_main+0x230>
c0d00a46:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00a48:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00a4a:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00a4c:	ac4d      	add	r4, sp, #308	; 0x134
c0d00a4e:	4620      	mov	r0, r4
c0d00a50:	f002 fc1c 	bl	c0d0328c <setjmp>
c0d00a54:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00a56:	6034      	str	r4, [r6, #0]
c0d00a58:	4951      	ldr	r1, [pc, #324]	; (c0d00ba0 <IOTA_main+0x2a8>)
c0d00a5a:	4208      	tst	r0, r1
c0d00a5c:	d011      	beq.n	c0d00a82 <IOTA_main+0x18a>
c0d00a5e:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00a60:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00a62:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00a64:	6031      	str	r1, [r6, #0]
c0d00a66:	210f      	movs	r1, #15
c0d00a68:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00a6a:	4001      	ands	r1, r0
c0d00a6c:	2209      	movs	r2, #9
c0d00a6e:	0312      	lsls	r2, r2, #12
c0d00a70:	4291      	cmp	r1, r2
c0d00a72:	d003      	beq.n	c0d00a7c <IOTA_main+0x184>
c0d00a74:	9a08      	ldr	r2, [sp, #32]
c0d00a76:	0352      	lsls	r2, r2, #13
c0d00a78:	4291      	cmp	r1, r2
c0d00a7a:	d142      	bne.n	c0d00b02 <IOTA_main+0x20a>
c0d00a7c:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00a7e:	8008      	strh	r0, [r1, #0]
c0d00a80:	e046      	b.n	c0d00b10 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00a82:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a84:	905c      	str	r0, [sp, #368]	; 0x170
c0d00a86:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00a88:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00a8a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00a8c:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00a8e:	b2c0      	uxtb	r0, r0
c0d00a90:	b289      	uxth	r1, r1
c0d00a92:	f000 fce3 	bl	c0d0145c <io_exchange>
c0d00a96:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00a98:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00a9a:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00a9c:	2800      	cmp	r0, #0
c0d00a9e:	d053      	beq.n	c0d00b48 <IOTA_main+0x250>
c0d00aa0:	4941      	ldr	r1, [pc, #260]	; (c0d00ba8 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00aa2:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00aa4:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00aa6:	2880      	cmp	r0, #128	; 0x80
c0d00aa8:	4a40      	ldr	r2, [pc, #256]	; (c0d00bac <IOTA_main+0x2b4>)
c0d00aaa:	d155      	bne.n	c0d00b58 <IOTA_main+0x260>
c0d00aac:	7848      	ldrb	r0, [r1, #1]
c0d00aae:	216d      	movs	r1, #109	; 0x6d
c0d00ab0:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00ab2:	2807      	cmp	r0, #7
c0d00ab4:	dc3f      	bgt.n	c0d00b36 <IOTA_main+0x23e>
c0d00ab6:	2802      	cmp	r0, #2
c0d00ab8:	d100      	bne.n	c0d00abc <IOTA_main+0x1c4>
c0d00aba:	e74f      	b.n	c0d0095c <IOTA_main+0x64>
c0d00abc:	2804      	cmp	r0, #4
c0d00abe:	d153      	bne.n	c0d00b68 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00ac0:	210b      	movs	r1, #11
c0d00ac2:	2203      	movs	r2, #3
c0d00ac4:	a03c      	add	r0, pc, #240	; (adr r0, c0d00bb8 <IOTA_main+0x2c0>)
c0d00ac6:	f7ff faed 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00aca:	2048      	movs	r0, #72	; 0x48
c0d00acc:	4936      	ldr	r1, [pc, #216]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d00ace:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00ad0:	2049      	movs	r0, #73	; 0x49
c0d00ad2:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00ad4:	2021      	movs	r0, #33	; 0x21
c0d00ad6:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00ad8:	3610      	adds	r6, #16
c0d00ada:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00adc:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00ade:	2005      	movs	r0, #5
c0d00ae0:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00ae2:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ae4:	b281      	uxth	r1, r0
c0d00ae6:	2020      	movs	r0, #32
c0d00ae8:	f000 fcb8 	bl	c0d0145c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00aec:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00aee:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00af0:	4308      	orrs	r0, r1
c0d00af2:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00af4:	4620      	mov	r0, r4
c0d00af6:	4621      	mov	r1, r4
c0d00af8:	4622      	mov	r2, r4
c0d00afa:	f001 fa2b 	bl	c0d01f54 <ui_display_debug>
c0d00afe:	4e27      	ldr	r6, [pc, #156]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b00:	e012      	b.n	c0d00b28 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00b02:	4928      	ldr	r1, [pc, #160]	; (c0d00ba4 <IOTA_main+0x2ac>)
c0d00b04:	4008      	ands	r0, r1
c0d00b06:	210d      	movs	r1, #13
c0d00b08:	02c9      	lsls	r1, r1, #11
c0d00b0a:	4301      	orrs	r1, r0
c0d00b0c:	a859      	add	r0, sp, #356	; 0x164
c0d00b0e:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00b10:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00b12:	0a00      	lsrs	r0, r0, #8
c0d00b14:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00b16:	4a24      	ldr	r2, [pc, #144]	; (c0d00ba8 <IOTA_main+0x2b0>)
c0d00b18:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00b1a:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00b1c:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00b1e:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00b20:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00b22:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b24:	1c80      	adds	r0, r0, #2
c0d00b26:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00b28:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00b2a:	6030      	str	r0, [r6, #0]
c0d00b2c:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00b2e:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00b30:	2900      	cmp	r1, #0
c0d00b32:	d088      	beq.n	c0d00a46 <IOTA_main+0x14e>
c0d00b34:	e006      	b.n	c0d00b44 <IOTA_main+0x24c>
c0d00b36:	2808      	cmp	r0, #8
c0d00b38:	d100      	bne.n	c0d00b3c <IOTA_main+0x244>
c0d00b3a:	e6f6      	b.n	c0d0092a <IOTA_main+0x32>
c0d00b3c:	28ff      	cmp	r0, #255	; 0xff
c0d00b3e:	d113      	bne.n	c0d00b68 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00b40:	b05d      	add	sp, #372	; 0x174
c0d00b42:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00b44:	f002 fbae 	bl	c0d032a4 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00b48:	2001      	movs	r0, #1
c0d00b4a:	4918      	ldr	r1, [pc, #96]	; (c0d00bac <IOTA_main+0x2b4>)
c0d00b4c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00b4e:	4813      	ldr	r0, [pc, #76]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b50:	6800      	ldr	r0, [r0, #0]
c0d00b52:	491c      	ldr	r1, [pc, #112]	; (c0d00bc4 <IOTA_main+0x2cc>)
c0d00b54:	f002 fba6 	bl	c0d032a4 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00b58:	2001      	movs	r0, #1
c0d00b5a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00b5c:	480f      	ldr	r0, [pc, #60]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b5e:	6800      	ldr	r0, [r0, #0]
c0d00b60:	2137      	movs	r1, #55	; 0x37
c0d00b62:	0249      	lsls	r1, r1, #9
c0d00b64:	f002 fb9e 	bl	c0d032a4 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00b68:	2001      	movs	r0, #1
c0d00b6a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00b6c:	480b      	ldr	r0, [pc, #44]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b6e:	6800      	ldr	r0, [r0, #0]
c0d00b70:	f002 fb98 	bl	c0d032a4 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00b74:	4809      	ldr	r0, [pc, #36]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b76:	6800      	ldr	r0, [r0, #0]
c0d00b78:	490e      	ldr	r1, [pc, #56]	; (c0d00bb4 <IOTA_main+0x2bc>)
c0d00b7a:	f002 fb93 	bl	c0d032a4 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00b7e:	2001      	movs	r0, #1
c0d00b80:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00b82:	4806      	ldr	r0, [pc, #24]	; (c0d00b9c <IOTA_main+0x2a4>)
c0d00b84:	6800      	ldr	r0, [r0, #0]
c0d00b86:	3109      	adds	r1, #9
c0d00b88:	f002 fb8c 	bl	c0d032a4 <longjmp>
c0d00b8c:	74696157 	.word	0x74696157
c0d00b90:	20676e69 	.word	0x20676e69
c0d00b94:	20726f66 	.word	0x20726f66
c0d00b98:	0067736d 	.word	0x0067736d
c0d00b9c:	20001bb8 	.word	0x20001bb8
c0d00ba0:	0000ffff 	.word	0x0000ffff
c0d00ba4:	000007ff 	.word	0x000007ff
c0d00ba8:	20001c08 	.word	0x20001c08
c0d00bac:	20001b48 	.word	0x20001b48
c0d00bb0:	20001b4c 	.word	0x20001b4c
c0d00bb4:	00006a86 	.word	0x00006a86
c0d00bb8:	20646142 	.word	0x20646142
c0d00bbc:	6b627550 	.word	0x6b627550
c0d00bc0:	00007965 	.word	0x00007965
c0d00bc4:	00006982 	.word	0x00006982

c0d00bc8 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00bc8:	4801      	ldr	r0, [pc, #4]	; (c0d00bd0 <os_boot+0x8>)
c0d00bca:	2100      	movs	r1, #0
c0d00bcc:	6001      	str	r1, [r0, #0]
}
c0d00bce:	4770      	bx	lr
c0d00bd0:	20001bb8 	.word	0x20001bb8

c0d00bd4 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00bd4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bd6:	af03      	add	r7, sp, #12
c0d00bd8:	b083      	sub	sp, #12
c0d00bda:	9202      	str	r2, [sp, #8]
c0d00bdc:	460c      	mov	r4, r1
c0d00bde:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00be0:	4d4a      	ldr	r5, [pc, #296]	; (c0d00d0c <io_usb_hid_receive+0x138>)
c0d00be2:	42ac      	cmp	r4, r5
c0d00be4:	d00f      	beq.n	c0d00c06 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00be6:	4e49      	ldr	r6, [pc, #292]	; (c0d00d0c <io_usb_hid_receive+0x138>)
c0d00be8:	2540      	movs	r5, #64	; 0x40
c0d00bea:	4630      	mov	r0, r6
c0d00bec:	4629      	mov	r1, r5
c0d00bee:	f002 fab7 	bl	c0d03160 <__aeabi_memclr>
c0d00bf2:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00bf4:	2840      	cmp	r0, #64	; 0x40
c0d00bf6:	4602      	mov	r2, r0
c0d00bf8:	d300      	bcc.n	c0d00bfc <io_usb_hid_receive+0x28>
c0d00bfa:	462a      	mov	r2, r5
c0d00bfc:	4630      	mov	r0, r6
c0d00bfe:	4621      	mov	r1, r4
c0d00c00:	f000 f89e 	bl	c0d00d40 <os_memmove>
c0d00c04:	4d41      	ldr	r5, [pc, #260]	; (c0d00d0c <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00c06:	78a8      	ldrb	r0, [r5, #2]
c0d00c08:	2805      	cmp	r0, #5
c0d00c0a:	d900      	bls.n	c0d00c0e <io_usb_hid_receive+0x3a>
c0d00c0c:	e076      	b.n	c0d00cfc <io_usb_hid_receive+0x128>
c0d00c0e:	46c0      	nop			; (mov r8, r8)
c0d00c10:	4478      	add	r0, pc
c0d00c12:	7900      	ldrb	r0, [r0, #4]
c0d00c14:	0040      	lsls	r0, r0, #1
c0d00c16:	4487      	add	pc, r0
c0d00c18:	71130c02 	.word	0x71130c02
c0d00c1c:	1f71      	.short	0x1f71
c0d00c1e:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00c20:	71ae      	strb	r6, [r5, #6]
c0d00c22:	716e      	strb	r6, [r5, #5]
c0d00c24:	712e      	strb	r6, [r5, #4]
c0d00c26:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c28:	2140      	movs	r1, #64	; 0x40
c0d00c2a:	4628      	mov	r0, r5
c0d00c2c:	9a01      	ldr	r2, [sp, #4]
c0d00c2e:	4790      	blx	r2
c0d00c30:	e00b      	b.n	c0d00c4a <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00c32:	1ce8      	adds	r0, r5, #3
c0d00c34:	2104      	movs	r1, #4
c0d00c36:	f000 ff73 	bl	c0d01b20 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c3a:	2140      	movs	r1, #64	; 0x40
c0d00c3c:	4628      	mov	r0, r5
c0d00c3e:	e001      	b.n	c0d00c44 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c40:	4832      	ldr	r0, [pc, #200]	; (c0d00d0c <io_usb_hid_receive+0x138>)
c0d00c42:	2140      	movs	r1, #64	; 0x40
c0d00c44:	9a01      	ldr	r2, [sp, #4]
c0d00c46:	4790      	blx	r2
c0d00c48:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00c4a:	4831      	ldr	r0, [pc, #196]	; (c0d00d10 <io_usb_hid_receive+0x13c>)
c0d00c4c:	2100      	movs	r1, #0
c0d00c4e:	6001      	str	r1, [r0, #0]
c0d00c50:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00c52:	b2c0      	uxtb	r0, r0
c0d00c54:	b003      	add	sp, #12
c0d00c56:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00c58:	78e8      	ldrb	r0, [r5, #3]
c0d00c5a:	4c2d      	ldr	r4, [pc, #180]	; (c0d00d10 <io_usb_hid_receive+0x13c>)
c0d00c5c:	6821      	ldr	r1, [r4, #0]
c0d00c5e:	0a09      	lsrs	r1, r1, #8
c0d00c60:	2600      	movs	r6, #0
c0d00c62:	4288      	cmp	r0, r1
c0d00c64:	d1f1      	bne.n	c0d00c4a <io_usb_hid_receive+0x76>
c0d00c66:	7928      	ldrb	r0, [r5, #4]
c0d00c68:	6821      	ldr	r1, [r4, #0]
c0d00c6a:	b2c9      	uxtb	r1, r1
c0d00c6c:	4288      	cmp	r0, r1
c0d00c6e:	d1ec      	bne.n	c0d00c4a <io_usb_hid_receive+0x76>
c0d00c70:	4b28      	ldr	r3, [pc, #160]	; (c0d00d14 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00c72:	9802      	ldr	r0, [sp, #8]
c0d00c74:	18c0      	adds	r0, r0, r3
c0d00c76:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00c78:	6820      	ldr	r0, [r4, #0]
c0d00c7a:	2800      	cmp	r0, #0
c0d00c7c:	d00e      	beq.n	c0d00c9c <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00c7e:	4629      	mov	r1, r5
c0d00c80:	4019      	ands	r1, r3
c0d00c82:	4825      	ldr	r0, [pc, #148]	; (c0d00d18 <io_usb_hid_receive+0x144>)
c0d00c84:	6802      	ldr	r2, [r0, #0]
c0d00c86:	4291      	cmp	r1, r2
c0d00c88:	461e      	mov	r6, r3
c0d00c8a:	d900      	bls.n	c0d00c8e <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00c8c:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00c8e:	462a      	mov	r2, r5
c0d00c90:	4032      	ands	r2, r6
c0d00c92:	4822      	ldr	r0, [pc, #136]	; (c0d00d1c <io_usb_hid_receive+0x148>)
c0d00c94:	6800      	ldr	r0, [r0, #0]
c0d00c96:	491d      	ldr	r1, [pc, #116]	; (c0d00d0c <io_usb_hid_receive+0x138>)
c0d00c98:	1d49      	adds	r1, r1, #5
c0d00c9a:	e021      	b.n	c0d00ce0 <io_usb_hid_receive+0x10c>
c0d00c9c:	9301      	str	r3, [sp, #4]
c0d00c9e:	491b      	ldr	r1, [pc, #108]	; (c0d00d0c <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00ca0:	7988      	ldrb	r0, [r1, #6]
c0d00ca2:	7949      	ldrb	r1, [r1, #5]
c0d00ca4:	0209      	lsls	r1, r1, #8
c0d00ca6:	4301      	orrs	r1, r0
c0d00ca8:	481d      	ldr	r0, [pc, #116]	; (c0d00d20 <io_usb_hid_receive+0x14c>)
c0d00caa:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00cac:	6801      	ldr	r1, [r0, #0]
c0d00cae:	2241      	movs	r2, #65	; 0x41
c0d00cb0:	0092      	lsls	r2, r2, #2
c0d00cb2:	4291      	cmp	r1, r2
c0d00cb4:	d8c9      	bhi.n	c0d00c4a <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00cb6:	6801      	ldr	r1, [r0, #0]
c0d00cb8:	4817      	ldr	r0, [pc, #92]	; (c0d00d18 <io_usb_hid_receive+0x144>)
c0d00cba:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00cbc:	4917      	ldr	r1, [pc, #92]	; (c0d00d1c <io_usb_hid_receive+0x148>)
c0d00cbe:	4a19      	ldr	r2, [pc, #100]	; (c0d00d24 <io_usb_hid_receive+0x150>)
c0d00cc0:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00cc2:	4919      	ldr	r1, [pc, #100]	; (c0d00d28 <io_usb_hid_receive+0x154>)
c0d00cc4:	9a02      	ldr	r2, [sp, #8]
c0d00cc6:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00cc8:	4629      	mov	r1, r5
c0d00cca:	9e01      	ldr	r6, [sp, #4]
c0d00ccc:	4031      	ands	r1, r6
c0d00cce:	6802      	ldr	r2, [r0, #0]
c0d00cd0:	4291      	cmp	r1, r2
c0d00cd2:	d900      	bls.n	c0d00cd6 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00cd4:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00cd6:	462a      	mov	r2, r5
c0d00cd8:	4032      	ands	r2, r6
c0d00cda:	480c      	ldr	r0, [pc, #48]	; (c0d00d0c <io_usb_hid_receive+0x138>)
c0d00cdc:	1dc1      	adds	r1, r0, #7
c0d00cde:	4811      	ldr	r0, [pc, #68]	; (c0d00d24 <io_usb_hid_receive+0x150>)
c0d00ce0:	f000 f82e 	bl	c0d00d40 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00ce4:	4035      	ands	r5, r6
c0d00ce6:	480d      	ldr	r0, [pc, #52]	; (c0d00d1c <io_usb_hid_receive+0x148>)
c0d00ce8:	6801      	ldr	r1, [r0, #0]
c0d00cea:	1949      	adds	r1, r1, r5
c0d00cec:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00cee:	480a      	ldr	r0, [pc, #40]	; (c0d00d18 <io_usb_hid_receive+0x144>)
c0d00cf0:	6801      	ldr	r1, [r0, #0]
c0d00cf2:	1b49      	subs	r1, r1, r5
c0d00cf4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00cf6:	6820      	ldr	r0, [r4, #0]
c0d00cf8:	1c40      	adds	r0, r0, #1
c0d00cfa:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00cfc:	4806      	ldr	r0, [pc, #24]	; (c0d00d18 <io_usb_hid_receive+0x144>)
c0d00cfe:	6801      	ldr	r1, [r0, #0]
c0d00d00:	2001      	movs	r0, #1
c0d00d02:	2602      	movs	r6, #2
c0d00d04:	2900      	cmp	r1, #0
c0d00d06:	d1a4      	bne.n	c0d00c52 <io_usb_hid_receive+0x7e>
c0d00d08:	e79f      	b.n	c0d00c4a <io_usb_hid_receive+0x76>
c0d00d0a:	46c0      	nop			; (mov r8, r8)
c0d00d0c:	20001bbc 	.word	0x20001bbc
c0d00d10:	20001bfc 	.word	0x20001bfc
c0d00d14:	0000ffff 	.word	0x0000ffff
c0d00d18:	20001c04 	.word	0x20001c04
c0d00d1c:	20001d0c 	.word	0x20001d0c
c0d00d20:	20001c00 	.word	0x20001c00
c0d00d24:	20001c08 	.word	0x20001c08
c0d00d28:	0001fff9 	.word	0x0001fff9

c0d00d2c <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00d2c:	b580      	push	{r7, lr}
c0d00d2e:	af00      	add	r7, sp, #0
c0d00d30:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00d32:	2a00      	cmp	r2, #0
c0d00d34:	d003      	beq.n	c0d00d3e <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00d36:	4611      	mov	r1, r2
c0d00d38:	461a      	mov	r2, r3
c0d00d3a:	f002 fa1b 	bl	c0d03174 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00d3e:	bd80      	pop	{r7, pc}

c0d00d40 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00d40:	b5b0      	push	{r4, r5, r7, lr}
c0d00d42:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00d44:	4288      	cmp	r0, r1
c0d00d46:	d90d      	bls.n	c0d00d64 <os_memmove+0x24>
    while(length--) {
c0d00d48:	2a00      	cmp	r2, #0
c0d00d4a:	d014      	beq.n	c0d00d76 <os_memmove+0x36>
c0d00d4c:	1e49      	subs	r1, r1, #1
c0d00d4e:	4252      	negs	r2, r2
c0d00d50:	1e40      	subs	r0, r0, #1
c0d00d52:	2300      	movs	r3, #0
c0d00d54:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00d56:	461c      	mov	r4, r3
c0d00d58:	4354      	muls	r4, r2
c0d00d5a:	5d0d      	ldrb	r5, [r1, r4]
c0d00d5c:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00d5e:	1c52      	adds	r2, r2, #1
c0d00d60:	d1f9      	bne.n	c0d00d56 <os_memmove+0x16>
c0d00d62:	e008      	b.n	c0d00d76 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00d64:	2a00      	cmp	r2, #0
c0d00d66:	d006      	beq.n	c0d00d76 <os_memmove+0x36>
c0d00d68:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00d6a:	b29c      	uxth	r4, r3
c0d00d6c:	5d0d      	ldrb	r5, [r1, r4]
c0d00d6e:	5505      	strb	r5, [r0, r4]
      l++;
c0d00d70:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00d72:	1e52      	subs	r2, r2, #1
c0d00d74:	d1f9      	bne.n	c0d00d6a <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00d76:	bdb0      	pop	{r4, r5, r7, pc}

c0d00d78 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00d78:	4801      	ldr	r0, [pc, #4]	; (c0d00d80 <io_usb_hid_init+0x8>)
c0d00d7a:	2100      	movs	r1, #0
c0d00d7c:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00d7e:	4770      	bx	lr
c0d00d80:	20001bfc 	.word	0x20001bfc

c0d00d84 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00d84:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d86:	af03      	add	r7, sp, #12
c0d00d88:	b087      	sub	sp, #28
c0d00d8a:	9301      	str	r3, [sp, #4]
c0d00d8c:	9203      	str	r2, [sp, #12]
c0d00d8e:	460e      	mov	r6, r1
c0d00d90:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00d92:	2e00      	cmp	r6, #0
c0d00d94:	d042      	beq.n	c0d00e1c <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00d96:	4d31      	ldr	r5, [pc, #196]	; (c0d00e5c <io_usb_hid_exchange+0xd8>)
c0d00d98:	2000      	movs	r0, #0
c0d00d9a:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00d9c:	4930      	ldr	r1, [pc, #192]	; (c0d00e60 <io_usb_hid_exchange+0xdc>)
c0d00d9e:	4831      	ldr	r0, [pc, #196]	; (c0d00e64 <io_usb_hid_exchange+0xe0>)
c0d00da0:	6008      	str	r0, [r1, #0]
c0d00da2:	4c31      	ldr	r4, [pc, #196]	; (c0d00e68 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00da4:	1d60      	adds	r0, r4, #5
c0d00da6:	213b      	movs	r1, #59	; 0x3b
c0d00da8:	9005      	str	r0, [sp, #20]
c0d00daa:	9102      	str	r1, [sp, #8]
c0d00dac:	f002 f9d8 	bl	c0d03160 <__aeabi_memclr>
c0d00db0:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00db2:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00db4:	6828      	ldr	r0, [r5, #0]
c0d00db6:	0a00      	lsrs	r0, r0, #8
c0d00db8:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00dba:	6828      	ldr	r0, [r5, #0]
c0d00dbc:	7120      	strb	r0, [r4, #4]
c0d00dbe:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00dc0:	6828      	ldr	r0, [r5, #0]
c0d00dc2:	2800      	cmp	r0, #0
c0d00dc4:	9106      	str	r1, [sp, #24]
c0d00dc6:	d009      	beq.n	c0d00ddc <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00dc8:	293b      	cmp	r1, #59	; 0x3b
c0d00dca:	460a      	mov	r2, r1
c0d00dcc:	d300      	bcc.n	c0d00dd0 <io_usb_hid_exchange+0x4c>
c0d00dce:	9a02      	ldr	r2, [sp, #8]
c0d00dd0:	4823      	ldr	r0, [pc, #140]	; (c0d00e60 <io_usb_hid_exchange+0xdc>)
c0d00dd2:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00dd4:	6819      	ldr	r1, [r3, #0]
c0d00dd6:	9805      	ldr	r0, [sp, #20]
c0d00dd8:	461e      	mov	r6, r3
c0d00dda:	e00a      	b.n	c0d00df2 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00ddc:	0a30      	lsrs	r0, r6, #8
c0d00dde:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00de0:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00de2:	2039      	movs	r0, #57	; 0x39
c0d00de4:	2939      	cmp	r1, #57	; 0x39
c0d00de6:	460a      	mov	r2, r1
c0d00de8:	d300      	bcc.n	c0d00dec <io_usb_hid_exchange+0x68>
c0d00dea:	4602      	mov	r2, r0
c0d00dec:	4e1c      	ldr	r6, [pc, #112]	; (c0d00e60 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00dee:	6831      	ldr	r1, [r6, #0]
c0d00df0:	1de0      	adds	r0, r4, #7
c0d00df2:	9205      	str	r2, [sp, #20]
c0d00df4:	f7ff ffa4 	bl	c0d00d40 <os_memmove>
c0d00df8:	4d18      	ldr	r5, [pc, #96]	; (c0d00e5c <io_usb_hid_exchange+0xd8>)
c0d00dfa:	6830      	ldr	r0, [r6, #0]
c0d00dfc:	4631      	mov	r1, r6
c0d00dfe:	9e05      	ldr	r6, [sp, #20]
c0d00e00:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00e02:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00e04:	6828      	ldr	r0, [r5, #0]
c0d00e06:	1c40      	adds	r0, r0, #1
c0d00e08:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00e0a:	2140      	movs	r1, #64	; 0x40
c0d00e0c:	4620      	mov	r0, r4
c0d00e0e:	9a04      	ldr	r2, [sp, #16]
c0d00e10:	4790      	blx	r2
c0d00e12:	9806      	ldr	r0, [sp, #24]
c0d00e14:	1b86      	subs	r6, r0, r6
c0d00e16:	4815      	ldr	r0, [pc, #84]	; (c0d00e6c <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00e18:	4206      	tst	r6, r0
c0d00e1a:	d1c3      	bne.n	c0d00da4 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00e1c:	480f      	ldr	r0, [pc, #60]	; (c0d00e5c <io_usb_hid_exchange+0xd8>)
c0d00e1e:	2400      	movs	r4, #0
c0d00e20:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00e22:	2080      	movs	r0, #128	; 0x80
c0d00e24:	9901      	ldr	r1, [sp, #4]
c0d00e26:	4201      	tst	r1, r0
c0d00e28:	d001      	beq.n	c0d00e2e <io_usb_hid_exchange+0xaa>
    reset();
c0d00e2a:	f000 fe3f 	bl	c0d01aac <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00e2e:	9801      	ldr	r0, [sp, #4]
c0d00e30:	0680      	lsls	r0, r0, #26
c0d00e32:	d40f      	bmi.n	c0d00e54 <io_usb_hid_exchange+0xd0>
c0d00e34:	4c0c      	ldr	r4, [pc, #48]	; (c0d00e68 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00e36:	2140      	movs	r1, #64	; 0x40
c0d00e38:	4620      	mov	r0, r4
c0d00e3a:	9a03      	ldr	r2, [sp, #12]
c0d00e3c:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00e3e:	b2c2      	uxtb	r2, r0
c0d00e40:	2a40      	cmp	r2, #64	; 0x40
c0d00e42:	d8f8      	bhi.n	c0d00e36 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00e44:	9804      	ldr	r0, [sp, #16]
c0d00e46:	4621      	mov	r1, r4
c0d00e48:	f7ff fec4 	bl	c0d00bd4 <io_usb_hid_receive>
c0d00e4c:	2802      	cmp	r0, #2
c0d00e4e:	d1f2      	bne.n	c0d00e36 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00e50:	4807      	ldr	r0, [pc, #28]	; (c0d00e70 <io_usb_hid_exchange+0xec>)
c0d00e52:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00e54:	b2a0      	uxth	r0, r4
c0d00e56:	b007      	add	sp, #28
c0d00e58:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e5a:	46c0      	nop			; (mov r8, r8)
c0d00e5c:	20001bfc 	.word	0x20001bfc
c0d00e60:	20001d0c 	.word	0x20001d0c
c0d00e64:	20001c08 	.word	0x20001c08
c0d00e68:	20001bbc 	.word	0x20001bbc
c0d00e6c:	0000ffff 	.word	0x0000ffff
c0d00e70:	20001c00 	.word	0x20001c00

c0d00e74 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00e74:	b580      	push	{r7, lr}
c0d00e76:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00e78:	f000 ffbc 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d00e7c:	2800      	cmp	r0, #0
c0d00e7e:	d10b      	bne.n	c0d00e98 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00e80:	4806      	ldr	r0, [pc, #24]	; (c0d00e9c <io_seproxyhal_general_status+0x28>)
c0d00e82:	2160      	movs	r1, #96	; 0x60
c0d00e84:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00e86:	2100      	movs	r1, #0
c0d00e88:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00e8a:	2202      	movs	r2, #2
c0d00e8c:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00e8e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00e90:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00e92:	2105      	movs	r1, #5
c0d00e94:	f000 ff90 	bl	c0d01db8 <io_seproxyhal_spi_send>
}
c0d00e98:	bd80      	pop	{r7, pc}
c0d00e9a:	46c0      	nop			; (mov r8, r8)
c0d00e9c:	20001a18 	.word	0x20001a18

c0d00ea0 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00ea0:	b5d0      	push	{r4, r6, r7, lr}
c0d00ea2:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00ea4:	4815      	ldr	r0, [pc, #84]	; (c0d00efc <io_seproxyhal_handle_usb_event+0x5c>)
c0d00ea6:	78c0      	ldrb	r0, [r0, #3]
c0d00ea8:	1e40      	subs	r0, r0, #1
c0d00eaa:	2807      	cmp	r0, #7
c0d00eac:	d824      	bhi.n	c0d00ef8 <io_seproxyhal_handle_usb_event+0x58>
c0d00eae:	46c0      	nop			; (mov r8, r8)
c0d00eb0:	4478      	add	r0, pc
c0d00eb2:	7900      	ldrb	r0, [r0, #4]
c0d00eb4:	0040      	lsls	r0, r0, #1
c0d00eb6:	4487      	add	pc, r0
c0d00eb8:	141f1803 	.word	0x141f1803
c0d00ebc:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00ec0:	4c0f      	ldr	r4, [pc, #60]	; (c0d00f00 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ec2:	2101      	movs	r1, #1
c0d00ec4:	4620      	mov	r0, r4
c0d00ec6:	f001 fbd5 	bl	c0d02674 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00eca:	4620      	mov	r0, r4
c0d00ecc:	f001 fbba 	bl	c0d02644 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00ed0:	480c      	ldr	r0, [pc, #48]	; (c0d00f04 <io_seproxyhal_handle_usb_event+0x64>)
c0d00ed2:	7800      	ldrb	r0, [r0, #0]
c0d00ed4:	2801      	cmp	r0, #1
c0d00ed6:	d10f      	bne.n	c0d00ef8 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00ed8:	480b      	ldr	r0, [pc, #44]	; (c0d00f08 <io_seproxyhal_handle_usb_event+0x68>)
c0d00eda:	6800      	ldr	r0, [r0, #0]
c0d00edc:	2110      	movs	r1, #16
c0d00ede:	f002 f9e1 	bl	c0d032a4 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00ee2:	4807      	ldr	r0, [pc, #28]	; (c0d00f00 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ee4:	f001 fbc9 	bl	c0d0267a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00ee8:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00eea:	4805      	ldr	r0, [pc, #20]	; (c0d00f00 <io_seproxyhal_handle_usb_event+0x60>)
c0d00eec:	f001 fbc9 	bl	c0d02682 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00ef0:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00ef2:	4803      	ldr	r0, [pc, #12]	; (c0d00f00 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ef4:	f001 fbc3 	bl	c0d0267e <USBD_LL_Resume>
      break;
  }
}
c0d00ef8:	bdd0      	pop	{r4, r6, r7, pc}
c0d00efa:	46c0      	nop			; (mov r8, r8)
c0d00efc:	20001a18 	.word	0x20001a18
c0d00f00:	20001d34 	.word	0x20001d34
c0d00f04:	20001d10 	.word	0x20001d10
c0d00f08:	20001bb8 	.word	0x20001bb8

c0d00f0c <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00f0c:	217f      	movs	r1, #127	; 0x7f
c0d00f0e:	4001      	ands	r1, r0
c0d00f10:	4801      	ldr	r0, [pc, #4]	; (c0d00f18 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00f12:	5c40      	ldrb	r0, [r0, r1]
c0d00f14:	4770      	bx	lr
c0d00f16:	46c0      	nop			; (mov r8, r8)
c0d00f18:	20001d11 	.word	0x20001d11

c0d00f1c <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00f1c:	b580      	push	{r7, lr}
c0d00f1e:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00f20:	480f      	ldr	r0, [pc, #60]	; (c0d00f60 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00f22:	7901      	ldrb	r1, [r0, #4]
c0d00f24:	2904      	cmp	r1, #4
c0d00f26:	d008      	beq.n	c0d00f3a <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00f28:	2902      	cmp	r1, #2
c0d00f2a:	d011      	beq.n	c0d00f50 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00f2c:	2901      	cmp	r1, #1
c0d00f2e:	d10e      	bne.n	c0d00f4e <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00f30:	1d81      	adds	r1, r0, #6
c0d00f32:	480d      	ldr	r0, [pc, #52]	; (c0d00f68 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f34:	f001 faaa 	bl	c0d0248c <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00f38:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00f3a:	78c2      	ldrb	r2, [r0, #3]
c0d00f3c:	217f      	movs	r1, #127	; 0x7f
c0d00f3e:	4011      	ands	r1, r2
c0d00f40:	7942      	ldrb	r2, [r0, #5]
c0d00f42:	4b08      	ldr	r3, [pc, #32]	; (c0d00f64 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00f44:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00f46:	1d82      	adds	r2, r0, #6
c0d00f48:	4807      	ldr	r0, [pc, #28]	; (c0d00f68 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f4a:	f001 fad1 	bl	c0d024f0 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00f4e:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00f50:	78c2      	ldrb	r2, [r0, #3]
c0d00f52:	217f      	movs	r1, #127	; 0x7f
c0d00f54:	4011      	ands	r1, r2
c0d00f56:	1d82      	adds	r2, r0, #6
c0d00f58:	4803      	ldr	r0, [pc, #12]	; (c0d00f68 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f5a:	f001 fb0f 	bl	c0d0257c <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00f5e:	bd80      	pop	{r7, pc}
c0d00f60:	20001a18 	.word	0x20001a18
c0d00f64:	20001d11 	.word	0x20001d11
c0d00f68:	20001d34 	.word	0x20001d34

c0d00f6c <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00f6c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f6e:	af03      	add	r7, sp, #12
c0d00f70:	b083      	sub	sp, #12
c0d00f72:	9201      	str	r2, [sp, #4]
c0d00f74:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00f76:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00f78:	2b00      	cmp	r3, #0
c0d00f7a:	d100      	bne.n	c0d00f7e <io_usb_send_ep+0x12>
c0d00f7c:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00f7e:	9801      	ldr	r0, [sp, #4]
c0d00f80:	28ff      	cmp	r0, #255	; 0xff
c0d00f82:	d843      	bhi.n	c0d0100c <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00f84:	4e25      	ldr	r6, [pc, #148]	; (c0d0101c <io_usb_send_ep+0xb0>)
c0d00f86:	2050      	movs	r0, #80	; 0x50
c0d00f88:	7030      	strb	r0, [r6, #0]
c0d00f8a:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00f8c:	1ce0      	adds	r0, r4, #3
c0d00f8e:	9100      	str	r1, [sp, #0]
c0d00f90:	0a01      	lsrs	r1, r0, #8
c0d00f92:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00f94:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00f96:	2080      	movs	r0, #128	; 0x80
c0d00f98:	4302      	orrs	r2, r0
c0d00f9a:	9202      	str	r2, [sp, #8]
c0d00f9c:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00f9e:	2020      	movs	r0, #32
c0d00fa0:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00fa2:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00fa4:	2106      	movs	r1, #6
c0d00fa6:	4630      	mov	r0, r6
c0d00fa8:	f000 ff06 	bl	c0d01db8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00fac:	9800      	ldr	r0, [sp, #0]
c0d00fae:	4621      	mov	r1, r4
c0d00fb0:	f000 ff02 	bl	c0d01db8 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00fb4:	2d00      	cmp	r5, #0
c0d00fb6:	d10d      	bne.n	c0d00fd4 <io_usb_send_ep+0x68>
c0d00fb8:	e028      	b.n	c0d0100c <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00fba:	2d00      	cmp	r5, #0
c0d00fbc:	d002      	beq.n	c0d00fc4 <io_usb_send_ep+0x58>
c0d00fbe:	1e6c      	subs	r4, r5, #1
c0d00fc0:	2d01      	cmp	r5, #1
c0d00fc2:	d025      	beq.n	c0d01010 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00fc4:	2915      	cmp	r1, #21
c0d00fc6:	d102      	bne.n	c0d00fce <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00fc8:	79b0      	ldrb	r0, [r6, #6]
c0d00fca:	0700      	lsls	r0, r0, #28
c0d00fcc:	d520      	bpl.n	c0d01010 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00fce:	f000 f829 	bl	c0d01024 <io_seproxyhal_handle_event>
c0d00fd2:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00fd4:	f000 ff0e 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d00fd8:	2800      	cmp	r0, #0
c0d00fda:	d101      	bne.n	c0d00fe0 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00fdc:	f7ff ff4a 	bl	c0d00e74 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00fe0:	2180      	movs	r1, #128	; 0x80
c0d00fe2:	2400      	movs	r4, #0
c0d00fe4:	4630      	mov	r0, r6
c0d00fe6:	4622      	mov	r2, r4
c0d00fe8:	f000 ff20 	bl	c0d01e2c <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00fec:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00fee:	2806      	cmp	r0, #6
c0d00ff0:	d1e3      	bne.n	c0d00fba <io_usb_send_ep+0x4e>
c0d00ff2:	2910      	cmp	r1, #16
c0d00ff4:	d1e1      	bne.n	c0d00fba <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00ff6:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00ff8:	9a02      	ldr	r2, [sp, #8]
c0d00ffa:	4290      	cmp	r0, r2
c0d00ffc:	d1dd      	bne.n	c0d00fba <io_usb_send_ep+0x4e>
c0d00ffe:	7930      	ldrb	r0, [r6, #4]
c0d01000:	2802      	cmp	r0, #2
c0d01002:	d1da      	bne.n	c0d00fba <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d01004:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01006:	9a01      	ldr	r2, [sp, #4]
c0d01008:	4290      	cmp	r0, r2
c0d0100a:	d1d6      	bne.n	c0d00fba <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d0100c:	b003      	add	sp, #12
c0d0100e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01010:	4803      	ldr	r0, [pc, #12]	; (c0d01020 <io_usb_send_ep+0xb4>)
c0d01012:	6800      	ldr	r0, [r0, #0]
c0d01014:	2110      	movs	r1, #16
c0d01016:	f002 f945 	bl	c0d032a4 <longjmp>
c0d0101a:	46c0      	nop			; (mov r8, r8)
c0d0101c:	20001a18 	.word	0x20001a18
c0d01020:	20001bb8 	.word	0x20001bb8

c0d01024 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d01024:	b580      	push	{r7, lr}
c0d01026:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01028:	480d      	ldr	r0, [pc, #52]	; (c0d01060 <io_seproxyhal_handle_event+0x3c>)
c0d0102a:	7882      	ldrb	r2, [r0, #2]
c0d0102c:	7841      	ldrb	r1, [r0, #1]
c0d0102e:	0209      	lsls	r1, r1, #8
c0d01030:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01032:	7800      	ldrb	r0, [r0, #0]
c0d01034:	2810      	cmp	r0, #16
c0d01036:	d008      	beq.n	c0d0104a <io_seproxyhal_handle_event+0x26>
c0d01038:	280f      	cmp	r0, #15
c0d0103a:	d10d      	bne.n	c0d01058 <io_seproxyhal_handle_event+0x34>
c0d0103c:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d0103e:	2904      	cmp	r1, #4
c0d01040:	d10d      	bne.n	c0d0105e <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01042:	f7ff ff2d 	bl	c0d00ea0 <io_seproxyhal_handle_usb_event>
c0d01046:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01048:	bd80      	pop	{r7, pc}
c0d0104a:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d0104c:	2906      	cmp	r1, #6
c0d0104e:	d306      	bcc.n	c0d0105e <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01050:	f7ff ff64 	bl	c0d00f1c <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01054:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01056:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01058:	2002      	movs	r0, #2
c0d0105a:	f7ff faf5 	bl	c0d00648 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0105e:	bd80      	pop	{r7, pc}
c0d01060:	20001a18 	.word	0x20001a18

c0d01064 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01064:	b580      	push	{r7, lr}
c0d01066:	af00      	add	r7, sp, #0
c0d01068:	460a      	mov	r2, r1
c0d0106a:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d0106c:	2082      	movs	r0, #130	; 0x82
c0d0106e:	2314      	movs	r3, #20
c0d01070:	f7ff ff7c 	bl	c0d00f6c <io_usb_send_ep>
}
c0d01074:	bd80      	pop	{r7, pc}
	...

c0d01078 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01078:	b5d0      	push	{r4, r6, r7, lr}
c0d0107a:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0107c:	2007      	movs	r0, #7
c0d0107e:	f000 fcf7 	bl	c0d01a70 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01082:	480a      	ldr	r0, [pc, #40]	; (c0d010ac <io_seproxyhal_init+0x34>)
c0d01084:	2400      	movs	r4, #0
c0d01086:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01088:	4809      	ldr	r0, [pc, #36]	; (c0d010b0 <io_seproxyhal_init+0x38>)
c0d0108a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d0108c:	4809      	ldr	r0, [pc, #36]	; (c0d010b4 <io_seproxyhal_init+0x3c>)
c0d0108e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01090:	4809      	ldr	r0, [pc, #36]	; (c0d010b8 <io_seproxyhal_init+0x40>)
c0d01092:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01094:	4809      	ldr	r0, [pc, #36]	; (c0d010bc <io_seproxyhal_init+0x44>)
c0d01096:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01098:	f7ff fe6e 	bl	c0d00d78 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0109c:	4808      	ldr	r0, [pc, #32]	; (c0d010c0 <io_seproxyhal_init+0x48>)
c0d0109e:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d010a0:	4808      	ldr	r0, [pc, #32]	; (c0d010c4 <io_seproxyhal_init+0x4c>)
c0d010a2:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d010a4:	4808      	ldr	r0, [pc, #32]	; (c0d010c8 <io_seproxyhal_init+0x50>)
c0d010a6:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d010a8:	bdd0      	pop	{r4, r6, r7, pc}
c0d010aa:	46c0      	nop			; (mov r8, r8)
c0d010ac:	20001d18 	.word	0x20001d18
c0d010b0:	20001d1a 	.word	0x20001d1a
c0d010b4:	20001d1c 	.word	0x20001d1c
c0d010b8:	20001d1e 	.word	0x20001d1e
c0d010bc:	20001d10 	.word	0x20001d10
c0d010c0:	20001d20 	.word	0x20001d20
c0d010c4:	20001d24 	.word	0x20001d24
c0d010c8:	20001d28 	.word	0x20001d28

c0d010cc <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d010cc:	4801      	ldr	r0, [pc, #4]	; (c0d010d4 <io_seproxyhal_init_ux+0x8>)
c0d010ce:	2100      	movs	r1, #0
c0d010d0:	6001      	str	r1, [r0, #0]

}
c0d010d2:	4770      	bx	lr
c0d010d4:	20001d20 	.word	0x20001d20

c0d010d8 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d010d8:	b5b0      	push	{r4, r5, r7, lr}
c0d010da:	af02      	add	r7, sp, #8
c0d010dc:	460d      	mov	r5, r1
c0d010de:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d010e0:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d010e2:	2800      	cmp	r0, #0
c0d010e4:	d00c      	beq.n	c0d01100 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d010e6:	f000 fcab 	bl	c0d01a40 <pic>
c0d010ea:	4601      	mov	r1, r0
c0d010ec:	4620      	mov	r0, r4
c0d010ee:	4788      	blx	r1
c0d010f0:	f000 fca6 	bl	c0d01a40 <pic>
c0d010f4:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d010f6:	2800      	cmp	r0, #0
c0d010f8:	d010      	beq.n	c0d0111c <io_seproxyhal_touch_out+0x44>
c0d010fa:	2801      	cmp	r0, #1
c0d010fc:	d000      	beq.n	c0d01100 <io_seproxyhal_touch_out+0x28>
c0d010fe:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01100:	2d00      	cmp	r5, #0
c0d01102:	d007      	beq.n	c0d01114 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d01104:	4620      	mov	r0, r4
c0d01106:	47a8      	blx	r5
c0d01108:	2100      	movs	r1, #0
    if (!el) {
c0d0110a:	2800      	cmp	r0, #0
c0d0110c:	d006      	beq.n	c0d0111c <io_seproxyhal_touch_out+0x44>
c0d0110e:	2801      	cmp	r0, #1
c0d01110:	d000      	beq.n	c0d01114 <io_seproxyhal_touch_out+0x3c>
c0d01112:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01114:	4620      	mov	r0, r4
c0d01116:	f7ff fa91 	bl	c0d0063c <io_seproxyhal_display>
c0d0111a:	2101      	movs	r1, #1
  return 1;
}
c0d0111c:	4608      	mov	r0, r1
c0d0111e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01120 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01120:	b5b0      	push	{r4, r5, r7, lr}
c0d01122:	af02      	add	r7, sp, #8
c0d01124:	b08e      	sub	sp, #56	; 0x38
c0d01126:	460c      	mov	r4, r1
c0d01128:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0112a:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d0112c:	2800      	cmp	r0, #0
c0d0112e:	d00c      	beq.n	c0d0114a <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01130:	f000 fc86 	bl	c0d01a40 <pic>
c0d01134:	4601      	mov	r1, r0
c0d01136:	4628      	mov	r0, r5
c0d01138:	4788      	blx	r1
c0d0113a:	f000 fc81 	bl	c0d01a40 <pic>
c0d0113e:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01140:	2800      	cmp	r0, #0
c0d01142:	d016      	beq.n	c0d01172 <io_seproxyhal_touch_over+0x52>
c0d01144:	2801      	cmp	r0, #1
c0d01146:	d000      	beq.n	c0d0114a <io_seproxyhal_touch_over+0x2a>
c0d01148:	4605      	mov	r5, r0
c0d0114a:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d0114c:	2238      	movs	r2, #56	; 0x38
c0d0114e:	4629      	mov	r1, r5
c0d01150:	f7ff fdf6 	bl	c0d00d40 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01154:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01156:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01158:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0115a:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d0115c:	2c00      	cmp	r4, #0
c0d0115e:	d004      	beq.n	c0d0116a <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01160:	4628      	mov	r0, r5
c0d01162:	47a0      	blx	r4
c0d01164:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01166:	2800      	cmp	r0, #0
c0d01168:	d003      	beq.n	c0d01172 <io_seproxyhal_touch_over+0x52>
c0d0116a:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d0116c:	f7ff fa66 	bl	c0d0063c <io_seproxyhal_display>
c0d01170:	2101      	movs	r1, #1
  return 1;
}
c0d01172:	4608      	mov	r0, r1
c0d01174:	b00e      	add	sp, #56	; 0x38
c0d01176:	bdb0      	pop	{r4, r5, r7, pc}

c0d01178 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01178:	b5b0      	push	{r4, r5, r7, lr}
c0d0117a:	af02      	add	r7, sp, #8
c0d0117c:	460d      	mov	r5, r1
c0d0117e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01180:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01182:	2800      	cmp	r0, #0
c0d01184:	d00c      	beq.n	c0d011a0 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01186:	f000 fc5b 	bl	c0d01a40 <pic>
c0d0118a:	4601      	mov	r1, r0
c0d0118c:	4620      	mov	r0, r4
c0d0118e:	4788      	blx	r1
c0d01190:	f000 fc56 	bl	c0d01a40 <pic>
c0d01194:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01196:	2800      	cmp	r0, #0
c0d01198:	d010      	beq.n	c0d011bc <io_seproxyhal_touch_tap+0x44>
c0d0119a:	2801      	cmp	r0, #1
c0d0119c:	d000      	beq.n	c0d011a0 <io_seproxyhal_touch_tap+0x28>
c0d0119e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d011a0:	2d00      	cmp	r5, #0
c0d011a2:	d007      	beq.n	c0d011b4 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d011a4:	4620      	mov	r0, r4
c0d011a6:	47a8      	blx	r5
c0d011a8:	2100      	movs	r1, #0
    if (!el) {
c0d011aa:	2800      	cmp	r0, #0
c0d011ac:	d006      	beq.n	c0d011bc <io_seproxyhal_touch_tap+0x44>
c0d011ae:	2801      	cmp	r0, #1
c0d011b0:	d000      	beq.n	c0d011b4 <io_seproxyhal_touch_tap+0x3c>
c0d011b2:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d011b4:	4620      	mov	r0, r4
c0d011b6:	f7ff fa41 	bl	c0d0063c <io_seproxyhal_display>
c0d011ba:	2101      	movs	r1, #1
  return 1;
}
c0d011bc:	4608      	mov	r0, r1
c0d011be:	bdb0      	pop	{r4, r5, r7, pc}

c0d011c0 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d011c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011c2:	af03      	add	r7, sp, #12
c0d011c4:	b087      	sub	sp, #28
c0d011c6:	9302      	str	r3, [sp, #8]
c0d011c8:	9203      	str	r2, [sp, #12]
c0d011ca:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d011cc:	2900      	cmp	r1, #0
c0d011ce:	d076      	beq.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
c0d011d0:	9004      	str	r0, [sp, #16]
c0d011d2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d011d4:	9001      	str	r0, [sp, #4]
c0d011d6:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d011d8:	9000      	str	r0, [sp, #0]
c0d011da:	2600      	movs	r6, #0
c0d011dc:	9606      	str	r6, [sp, #24]
c0d011de:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d011e0:	f000 fe08 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d011e4:	2800      	cmp	r0, #0
c0d011e6:	d155      	bne.n	c0d01294 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d011e8:	2038      	movs	r0, #56	; 0x38
c0d011ea:	4370      	muls	r0, r6
c0d011ec:	9d04      	ldr	r5, [sp, #16]
c0d011ee:	182e      	adds	r6, r5, r0
c0d011f0:	4b36      	ldr	r3, [pc, #216]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d011f2:	681a      	ldr	r2, [r3, #0]
c0d011f4:	2101      	movs	r1, #1
c0d011f6:	4296      	cmp	r6, r2
c0d011f8:	d000      	beq.n	c0d011fc <io_seproxyhal_touch_element_callback+0x3c>
c0d011fa:	9906      	ldr	r1, [sp, #24]
c0d011fc:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d011fe:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01200:	2800      	cmp	r0, #0
c0d01202:	da41      	bge.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
c0d01204:	2020      	movs	r0, #32
c0d01206:	5c35      	ldrb	r5, [r6, r0]
c0d01208:	2102      	movs	r1, #2
c0d0120a:	5e71      	ldrsh	r1, [r6, r1]
c0d0120c:	1b4a      	subs	r2, r1, r5
c0d0120e:	9803      	ldr	r0, [sp, #12]
c0d01210:	4282      	cmp	r2, r0
c0d01212:	dc39      	bgt.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
c0d01214:	1869      	adds	r1, r5, r1
c0d01216:	88f2      	ldrh	r2, [r6, #6]
c0d01218:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d0121a:	9803      	ldr	r0, [sp, #12]
c0d0121c:	4288      	cmp	r0, r1
c0d0121e:	da33      	bge.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
c0d01220:	2104      	movs	r1, #4
c0d01222:	5e70      	ldrsh	r0, [r6, r1]
c0d01224:	1b42      	subs	r2, r0, r5
c0d01226:	9902      	ldr	r1, [sp, #8]
c0d01228:	428a      	cmp	r2, r1
c0d0122a:	dc2d      	bgt.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
c0d0122c:	1940      	adds	r0, r0, r5
c0d0122e:	8931      	ldrh	r1, [r6, #8]
c0d01230:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01232:	9902      	ldr	r1, [sp, #8]
c0d01234:	4281      	cmp	r1, r0
c0d01236:	da27      	bge.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01238:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d0123a:	4286      	cmp	r6, r0
c0d0123c:	d010      	beq.n	c0d01260 <io_seproxyhal_touch_element_callback+0xa0>
c0d0123e:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01240:	2800      	cmp	r0, #0
c0d01242:	d00d      	beq.n	c0d01260 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01244:	9801      	ldr	r0, [sp, #4]
c0d01246:	2800      	cmp	r0, #0
c0d01248:	d005      	beq.n	c0d01256 <io_seproxyhal_touch_element_callback+0x96>
c0d0124a:	4630      	mov	r0, r6
c0d0124c:	9901      	ldr	r1, [sp, #4]
c0d0124e:	4788      	blx	r1
c0d01250:	4b1e      	ldr	r3, [pc, #120]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01252:	2800      	cmp	r0, #0
c0d01254:	d018      	beq.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01256:	6818      	ldr	r0, [r3, #0]
c0d01258:	9901      	ldr	r1, [sp, #4]
c0d0125a:	f7ff ff3d 	bl	c0d010d8 <io_seproxyhal_touch_out>
c0d0125e:	e008      	b.n	c0d01272 <io_seproxyhal_touch_element_callback+0xb2>
c0d01260:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01262:	2801      	cmp	r0, #1
c0d01264:	d009      	beq.n	c0d0127a <io_seproxyhal_touch_element_callback+0xba>
c0d01266:	2802      	cmp	r0, #2
c0d01268:	d10e      	bne.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0126a:	4630      	mov	r0, r6
c0d0126c:	9901      	ldr	r1, [sp, #4]
c0d0126e:	f7ff ff83 	bl	c0d01178 <io_seproxyhal_touch_tap>
c0d01272:	4b16      	ldr	r3, [pc, #88]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01274:	2800      	cmp	r0, #0
c0d01276:	d007      	beq.n	c0d01288 <io_seproxyhal_touch_element_callback+0xc8>
c0d01278:	e023      	b.n	c0d012c2 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0127a:	4630      	mov	r0, r6
c0d0127c:	9901      	ldr	r1, [sp, #4]
c0d0127e:	f7ff ff4f 	bl	c0d01120 <io_seproxyhal_touch_over>
c0d01282:	4b12      	ldr	r3, [pc, #72]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01284:	2800      	cmp	r0, #0
c0d01286:	d11f      	bne.n	c0d012c8 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01288:	1c64      	adds	r4, r4, #1
c0d0128a:	b2e6      	uxtb	r6, r4
c0d0128c:	9805      	ldr	r0, [sp, #20]
c0d0128e:	4286      	cmp	r6, r0
c0d01290:	d3a6      	bcc.n	c0d011e0 <io_seproxyhal_touch_element_callback+0x20>
c0d01292:	e000      	b.n	c0d01296 <io_seproxyhal_touch_element_callback+0xd6>
c0d01294:	4b0d      	ldr	r3, [pc, #52]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01296:	9806      	ldr	r0, [sp, #24]
c0d01298:	0600      	lsls	r0, r0, #24
c0d0129a:	d010      	beq.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
c0d0129c:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0129e:	2800      	cmp	r0, #0
c0d012a0:	d00d      	beq.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d012a2:	f000 fda7 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d012a6:	4909      	ldr	r1, [pc, #36]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d012a8:	2800      	cmp	r0, #0
c0d012aa:	d108      	bne.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d012ac:	6808      	ldr	r0, [r1, #0]
c0d012ae:	9901      	ldr	r1, [sp, #4]
c0d012b0:	f7ff ff12 	bl	c0d010d8 <io_seproxyhal_touch_out>
c0d012b4:	4d05      	ldr	r5, [pc, #20]	; (c0d012cc <io_seproxyhal_touch_element_callback+0x10c>)
c0d012b6:	2800      	cmp	r0, #0
c0d012b8:	d001      	beq.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d012ba:	2000      	movs	r0, #0
c0d012bc:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d012be:	b007      	add	sp, #28
c0d012c0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d012c2:	2000      	movs	r0, #0
c0d012c4:	6018      	str	r0, [r3, #0]
c0d012c6:	e7fa      	b.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d012c8:	601e      	str	r6, [r3, #0]
c0d012ca:	e7f8      	b.n	c0d012be <io_seproxyhal_touch_element_callback+0xfe>
c0d012cc:	20001d20 	.word	0x20001d20

c0d012d0 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d012d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012d2:	af03      	add	r7, sp, #12
c0d012d4:	b08b      	sub	sp, #44	; 0x2c
c0d012d6:	460c      	mov	r4, r1
c0d012d8:	4601      	mov	r1, r0
c0d012da:	ad04      	add	r5, sp, #16
c0d012dc:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d012de:	4628      	mov	r0, r5
c0d012e0:	9203      	str	r2, [sp, #12]
c0d012e2:	f7ff fd2d 	bl	c0d00d40 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d012e6:	6821      	ldr	r1, [r4, #0]
c0d012e8:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d012ea:	6862      	ldr	r2, [r4, #4]
c0d012ec:	9502      	str	r5, [sp, #8]
c0d012ee:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d012f0:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d012f2:	4e1a      	ldr	r6, [pc, #104]	; (c0d0135c <io_seproxyhal_display_icon+0x8c>)
c0d012f4:	2365      	movs	r3, #101	; 0x65
c0d012f6:	4635      	mov	r5, r6
c0d012f8:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d012fa:	b292      	uxth	r2, r2
c0d012fc:	4342      	muls	r2, r0
c0d012fe:	b28b      	uxth	r3, r1
c0d01300:	4353      	muls	r3, r2
c0d01302:	08d9      	lsrs	r1, r3, #3
c0d01304:	1c4e      	adds	r6, r1, #1
c0d01306:	2207      	movs	r2, #7
c0d01308:	4213      	tst	r3, r2
c0d0130a:	d100      	bne.n	c0d0130e <io_seproxyhal_display_icon+0x3e>
c0d0130c:	460e      	mov	r6, r1
c0d0130e:	4631      	mov	r1, r6
c0d01310:	9101      	str	r1, [sp, #4]
c0d01312:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01314:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01316:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01318:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0131a:	0a01      	lsrs	r1, r0, #8
c0d0131c:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d0131e:	70a8      	strb	r0, [r5, #2]
c0d01320:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01322:	4628      	mov	r0, r5
c0d01324:	f000 fd48 	bl	c0d01db8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01328:	9802      	ldr	r0, [sp, #8]
c0d0132a:	9903      	ldr	r1, [sp, #12]
c0d0132c:	f000 fd44 	bl	c0d01db8 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01330:	68a0      	ldr	r0, [r4, #8]
c0d01332:	7028      	strb	r0, [r5, #0]
c0d01334:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01336:	4628      	mov	r0, r5
c0d01338:	f000 fd3e 	bl	c0d01db8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0133c:	68e0      	ldr	r0, [r4, #12]
c0d0133e:	f000 fb7f 	bl	c0d01a40 <pic>
c0d01342:	b2b1      	uxth	r1, r6
c0d01344:	f000 fd38 	bl	c0d01db8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01348:	9801      	ldr	r0, [sp, #4]
c0d0134a:	b285      	uxth	r5, r0
c0d0134c:	6920      	ldr	r0, [r4, #16]
c0d0134e:	f000 fb77 	bl	c0d01a40 <pic>
c0d01352:	4629      	mov	r1, r5
c0d01354:	f000 fd30 	bl	c0d01db8 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01358:	b00b      	add	sp, #44	; 0x2c
c0d0135a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0135c:	20001a18 	.word	0x20001a18

c0d01360 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01360:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01362:	af03      	add	r7, sp, #12
c0d01364:	b081      	sub	sp, #4
c0d01366:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01368:	7820      	ldrb	r0, [r4, #0]
c0d0136a:	267f      	movs	r6, #127	; 0x7f
c0d0136c:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d0136e:	2e00      	cmp	r6, #0
c0d01370:	d02e      	beq.n	c0d013d0 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01372:	69e0      	ldr	r0, [r4, #28]
c0d01374:	2800      	cmp	r0, #0
c0d01376:	d01d      	beq.n	c0d013b4 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01378:	f000 fb62 	bl	c0d01a40 <pic>
c0d0137c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0137e:	2e05      	cmp	r6, #5
c0d01380:	d102      	bne.n	c0d01388 <io_seproxyhal_display_default+0x28>
c0d01382:	7ea0      	ldrb	r0, [r4, #26]
c0d01384:	2800      	cmp	r0, #0
c0d01386:	d025      	beq.n	c0d013d4 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01388:	4628      	mov	r0, r5
c0d0138a:	f001 ff99 	bl	c0d032c0 <strlen>
c0d0138e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01390:	4813      	ldr	r0, [pc, #76]	; (c0d013e0 <io_seproxyhal_display_default+0x80>)
c0d01392:	2165      	movs	r1, #101	; 0x65
c0d01394:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01396:	4631      	mov	r1, r6
c0d01398:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0139a:	0a0a      	lsrs	r2, r1, #8
c0d0139c:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0139e:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d013a0:	2103      	movs	r1, #3
c0d013a2:	f000 fd09 	bl	c0d01db8 <io_seproxyhal_spi_send>
c0d013a6:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d013a8:	4620      	mov	r0, r4
c0d013aa:	f000 fd05 	bl	c0d01db8 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d013ae:	b2b1      	uxth	r1, r6
c0d013b0:	4628      	mov	r0, r5
c0d013b2:	e00b      	b.n	c0d013cc <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d013b4:	480a      	ldr	r0, [pc, #40]	; (c0d013e0 <io_seproxyhal_display_default+0x80>)
c0d013b6:	2165      	movs	r1, #101	; 0x65
c0d013b8:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d013ba:	2100      	movs	r1, #0
c0d013bc:	7041      	strb	r1, [r0, #1]
c0d013be:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d013c0:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d013c2:	2103      	movs	r1, #3
c0d013c4:	f000 fcf8 	bl	c0d01db8 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d013c8:	4620      	mov	r0, r4
c0d013ca:	4629      	mov	r1, r5
c0d013cc:	f000 fcf4 	bl	c0d01db8 <io_seproxyhal_spi_send>
    }
  }
}
c0d013d0:	b001      	add	sp, #4
c0d013d2:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d013d4:	4620      	mov	r0, r4
c0d013d6:	4629      	mov	r1, r5
c0d013d8:	f7ff ff7a 	bl	c0d012d0 <io_seproxyhal_display_icon>
c0d013dc:	e7f8      	b.n	c0d013d0 <io_seproxyhal_display_default+0x70>
c0d013de:	46c0      	nop			; (mov r8, r8)
c0d013e0:	20001a18 	.word	0x20001a18

c0d013e4 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d013e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013e6:	af03      	add	r7, sp, #12
c0d013e8:	b081      	sub	sp, #4
c0d013ea:	4604      	mov	r4, r0
  if (button_callback) {
c0d013ec:	2c00      	cmp	r4, #0
c0d013ee:	d02e      	beq.n	c0d0144e <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d013f0:	4818      	ldr	r0, [pc, #96]	; (c0d01454 <io_seproxyhal_button_push+0x70>)
c0d013f2:	6802      	ldr	r2, [r0, #0]
c0d013f4:	428a      	cmp	r2, r1
c0d013f6:	d103      	bne.n	c0d01400 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d013f8:	4a17      	ldr	r2, [pc, #92]	; (c0d01458 <io_seproxyhal_button_push+0x74>)
c0d013fa:	6813      	ldr	r3, [r2, #0]
c0d013fc:	1c5b      	adds	r3, r3, #1
c0d013fe:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01400:	6806      	ldr	r6, [r0, #0]
c0d01402:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01404:	4a14      	ldr	r2, [pc, #80]	; (c0d01458 <io_seproxyhal_button_push+0x74>)
c0d01406:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01408:	2900      	cmp	r1, #0
c0d0140a:	d001      	beq.n	c0d01410 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d0140c:	6006      	str	r6, [r0, #0]
c0d0140e:	e005      	b.n	c0d0141c <io_seproxyhal_button_push+0x38>
c0d01410:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01412:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01414:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01416:	2301      	movs	r3, #1
c0d01418:	07db      	lsls	r3, r3, #31
c0d0141a:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d0141c:	6800      	ldr	r0, [r0, #0]
c0d0141e:	4288      	cmp	r0, r1
c0d01420:	d001      	beq.n	c0d01426 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01422:	2000      	movs	r0, #0
c0d01424:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01426:	2d08      	cmp	r5, #8
c0d01428:	d30e      	bcc.n	c0d01448 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0142a:	2103      	movs	r1, #3
c0d0142c:	4628      	mov	r0, r5
c0d0142e:	f001 fda7 	bl	c0d02f80 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01432:	2001      	movs	r0, #1
c0d01434:	0780      	lsls	r0, r0, #30
c0d01436:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01438:	2900      	cmp	r1, #0
c0d0143a:	4601      	mov	r1, r0
c0d0143c:	d000      	beq.n	c0d01440 <io_seproxyhal_button_push+0x5c>
c0d0143e:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01440:	2900      	cmp	r1, #0
c0d01442:	db02      	blt.n	c0d0144a <io_seproxyhal_button_push+0x66>
c0d01444:	4608      	mov	r0, r1
c0d01446:	e000      	b.n	c0d0144a <io_seproxyhal_button_push+0x66>
c0d01448:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0144a:	4629      	mov	r1, r5
c0d0144c:	47a0      	blx	r4
  }
}
c0d0144e:	b001      	add	sp, #4
c0d01450:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01452:	46c0      	nop			; (mov r8, r8)
c0d01454:	20001d24 	.word	0x20001d24
c0d01458:	20001d28 	.word	0x20001d28

c0d0145c <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d0145c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0145e:	af03      	add	r7, sp, #12
c0d01460:	b081      	sub	sp, #4
c0d01462:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01464:	200f      	movs	r0, #15
c0d01466:	4204      	tst	r4, r0
c0d01468:	d006      	beq.n	c0d01478 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d0146a:	4620      	mov	r0, r4
c0d0146c:	f7ff f8be 	bl	c0d005ec <io_exchange_al>
c0d01470:	4605      	mov	r5, r0
  }
}
c0d01472:	b2a8      	uxth	r0, r5
c0d01474:	b001      	add	sp, #4
c0d01476:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01478:	2610      	movs	r6, #16
c0d0147a:	4026      	ands	r6, r4
c0d0147c:	2900      	cmp	r1, #0
c0d0147e:	d02a      	beq.n	c0d014d6 <io_exchange+0x7a>
c0d01480:	2e00      	cmp	r6, #0
c0d01482:	d128      	bne.n	c0d014d6 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01484:	483d      	ldr	r0, [pc, #244]	; (c0d0157c <io_exchange+0x120>)
c0d01486:	7800      	ldrb	r0, [r0, #0]
c0d01488:	2807      	cmp	r0, #7
c0d0148a:	d00b      	beq.n	c0d014a4 <io_exchange+0x48>
c0d0148c:	2800      	cmp	r0, #0
c0d0148e:	d004      	beq.n	c0d0149a <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01490:	4620      	mov	r0, r4
c0d01492:	f7ff f8ab 	bl	c0d005ec <io_exchange_al>
c0d01496:	2800      	cmp	r0, #0
c0d01498:	d00a      	beq.n	c0d014b0 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d0149a:	4839      	ldr	r0, [pc, #228]	; (c0d01580 <io_exchange+0x124>)
c0d0149c:	6800      	ldr	r0, [r0, #0]
c0d0149e:	2109      	movs	r1, #9
c0d014a0:	f001 ff00 	bl	c0d032a4 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d014a4:	483d      	ldr	r0, [pc, #244]	; (c0d0159c <io_exchange+0x140>)
c0d014a6:	4478      	add	r0, pc
c0d014a8:	2200      	movs	r2, #0
c0d014aa:	2320      	movs	r3, #32
c0d014ac:	f7ff fc6a 	bl	c0d00d84 <io_usb_hid_exchange>
c0d014b0:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d014b2:	4832      	ldr	r0, [pc, #200]	; (c0d0157c <io_exchange+0x120>)
c0d014b4:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d014b6:	4833      	ldr	r0, [pc, #204]	; (c0d01584 <io_exchange+0x128>)
c0d014b8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d014ba:	4833      	ldr	r0, [pc, #204]	; (c0d01588 <io_exchange+0x12c>)
c0d014bc:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d014be:	4833      	ldr	r0, [pc, #204]	; (c0d0158c <io_exchange+0x130>)
c0d014c0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d014c2:	4833      	ldr	r0, [pc, #204]	; (c0d01590 <io_exchange+0x134>)
c0d014c4:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d014c6:	06a0      	lsls	r0, r4, #26
c0d014c8:	d4d3      	bmi.n	c0d01472 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d014ca:	f7ff fcd3 	bl	c0d00e74 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d014ce:	0620      	lsls	r0, r4, #24
c0d014d0:	d501      	bpl.n	c0d014d6 <io_exchange+0x7a>
        reset();
c0d014d2:	f000 faeb 	bl	c0d01aac <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d014d6:	2e00      	cmp	r6, #0
c0d014d8:	d10c      	bne.n	c0d014f4 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d014da:	0660      	lsls	r0, r4, #25
c0d014dc:	d448      	bmi.n	c0d01570 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d014de:	4827      	ldr	r0, [pc, #156]	; (c0d0157c <io_exchange+0x120>)
c0d014e0:	2100      	movs	r1, #0
c0d014e2:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d014e4:	4827      	ldr	r0, [pc, #156]	; (c0d01584 <io_exchange+0x128>)
c0d014e6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d014e8:	4827      	ldr	r0, [pc, #156]	; (c0d01588 <io_exchange+0x12c>)
c0d014ea:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d014ec:	4827      	ldr	r0, [pc, #156]	; (c0d0158c <io_exchange+0x130>)
c0d014ee:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d014f0:	4827      	ldr	r0, [pc, #156]	; (c0d01590 <io_exchange+0x134>)
c0d014f2:	7001      	strb	r1, [r0, #0]
c0d014f4:	4c28      	ldr	r4, [pc, #160]	; (c0d01598 <io_exchange+0x13c>)
c0d014f6:	4e24      	ldr	r6, [pc, #144]	; (c0d01588 <io_exchange+0x12c>)
c0d014f8:	e008      	b.n	c0d0150c <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d014fa:	f7ff fd0f 	bl	c0d00f1c <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d014fe:	8830      	ldrh	r0, [r6, #0]
c0d01500:	2800      	cmp	r0, #0
c0d01502:	d003      	beq.n	c0d0150c <io_exchange+0xb0>
c0d01504:	e032      	b.n	c0d0156c <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01506:	2002      	movs	r0, #2
c0d01508:	f7ff f89e 	bl	c0d00648 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d0150c:	f000 fc72 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d01510:	2800      	cmp	r0, #0
c0d01512:	d101      	bne.n	c0d01518 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01514:	f7ff fcae 	bl	c0d00e74 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01518:	2180      	movs	r1, #128	; 0x80
c0d0151a:	2500      	movs	r5, #0
c0d0151c:	4620      	mov	r0, r4
c0d0151e:	462a      	mov	r2, r5
c0d01520:	f000 fc84 	bl	c0d01e2c <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01524:	1ec1      	subs	r1, r0, #3
c0d01526:	78a2      	ldrb	r2, [r4, #2]
c0d01528:	7863      	ldrb	r3, [r4, #1]
c0d0152a:	021b      	lsls	r3, r3, #8
c0d0152c:	4313      	orrs	r3, r2
c0d0152e:	4299      	cmp	r1, r3
c0d01530:	d110      	bne.n	c0d01554 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01532:	4917      	ldr	r1, [pc, #92]	; (c0d01590 <io_exchange+0x134>)
c0d01534:	7809      	ldrb	r1, [r1, #0]
c0d01536:	2900      	cmp	r1, #0
c0d01538:	d002      	beq.n	c0d01540 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d0153a:	f7ff fd73 	bl	c0d01024 <io_seproxyhal_handle_event>
c0d0153e:	e7e5      	b.n	c0d0150c <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01540:	7821      	ldrb	r1, [r4, #0]
c0d01542:	2910      	cmp	r1, #16
c0d01544:	d00f      	beq.n	c0d01566 <io_exchange+0x10a>
c0d01546:	290f      	cmp	r1, #15
c0d01548:	d1dd      	bne.n	c0d01506 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d0154a:	2804      	cmp	r0, #4
c0d0154c:	d102      	bne.n	c0d01554 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d0154e:	f7ff fca7 	bl	c0d00ea0 <io_seproxyhal_handle_usb_event>
c0d01552:	e7db      	b.n	c0d0150c <io_exchange+0xb0>
c0d01554:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01556:	4909      	ldr	r1, [pc, #36]	; (c0d0157c <io_exchange+0x120>)
c0d01558:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d0155a:	490a      	ldr	r1, [pc, #40]	; (c0d01584 <io_exchange+0x128>)
c0d0155c:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d0155e:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01560:	490a      	ldr	r1, [pc, #40]	; (c0d0158c <io_exchange+0x130>)
c0d01562:	8008      	strh	r0, [r1, #0]
c0d01564:	e7d2      	b.n	c0d0150c <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01566:	2806      	cmp	r0, #6
c0d01568:	d2c7      	bcs.n	c0d014fa <io_exchange+0x9e>
c0d0156a:	e782      	b.n	c0d01472 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d0156c:	8835      	ldrh	r5, [r6, #0]
c0d0156e:	e780      	b.n	c0d01472 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01570:	4805      	ldr	r0, [pc, #20]	; (c0d01588 <io_exchange+0x12c>)
c0d01572:	8800      	ldrh	r0, [r0, #0]
c0d01574:	4907      	ldr	r1, [pc, #28]	; (c0d01594 <io_exchange+0x138>)
c0d01576:	1845      	adds	r5, r0, r1
c0d01578:	e77b      	b.n	c0d01472 <io_exchange+0x16>
c0d0157a:	46c0      	nop			; (mov r8, r8)
c0d0157c:	20001d18 	.word	0x20001d18
c0d01580:	20001bb8 	.word	0x20001bb8
c0d01584:	20001d1a 	.word	0x20001d1a
c0d01588:	20001d1c 	.word	0x20001d1c
c0d0158c:	20001d1e 	.word	0x20001d1e
c0d01590:	20001d10 	.word	0x20001d10
c0d01594:	0000fffb 	.word	0x0000fffb
c0d01598:	20001a18 	.word	0x20001a18
c0d0159c:	fffffbbb 	.word	0xfffffbbb

c0d015a0 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d015a0:	b081      	sub	sp, #4
c0d015a2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d015a4:	af03      	add	r7, sp, #12
c0d015a6:	b094      	sub	sp, #80	; 0x50
c0d015a8:	4616      	mov	r6, r2
c0d015aa:	460d      	mov	r5, r1
c0d015ac:	900e      	str	r0, [sp, #56]	; 0x38
c0d015ae:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d015b0:	2d02      	cmp	r5, #2
c0d015b2:	d200      	bcs.n	c0d015b6 <snprintf+0x16>
c0d015b4:	e22a      	b.n	c0d01a0c <snprintf+0x46c>
c0d015b6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d015b8:	2800      	cmp	r0, #0
c0d015ba:	d100      	bne.n	c0d015be <snprintf+0x1e>
c0d015bc:	e226      	b.n	c0d01a0c <snprintf+0x46c>
c0d015be:	2e00      	cmp	r6, #0
c0d015c0:	d100      	bne.n	c0d015c4 <snprintf+0x24>
c0d015c2:	e223      	b.n	c0d01a0c <snprintf+0x46c>
c0d015c4:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d015c6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d015c8:	9109      	str	r1, [sp, #36]	; 0x24
c0d015ca:	462a      	mov	r2, r5
c0d015cc:	f7ff fbae 	bl	c0d00d2c <os_memset>
c0d015d0:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d015d2:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d015d4:	7830      	ldrb	r0, [r6, #0]
c0d015d6:	2800      	cmp	r0, #0
c0d015d8:	d100      	bne.n	c0d015dc <snprintf+0x3c>
c0d015da:	e217      	b.n	c0d01a0c <snprintf+0x46c>
c0d015dc:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d015de:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d015e0:	1e6b      	subs	r3, r5, #1
c0d015e2:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d015e4:	460a      	mov	r2, r1
c0d015e6:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d015e8:	e003      	b.n	c0d015f2 <snprintf+0x52>
c0d015ea:	1970      	adds	r0, r6, r5
c0d015ec:	7840      	ldrb	r0, [r0, #1]
c0d015ee:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d015f0:	1c6d      	adds	r5, r5, #1
c0d015f2:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d015f4:	2800      	cmp	r0, #0
c0d015f6:	d001      	beq.n	c0d015fc <snprintf+0x5c>
c0d015f8:	2825      	cmp	r0, #37	; 0x25
c0d015fa:	d1f6      	bne.n	c0d015ea <snprintf+0x4a>
c0d015fc:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d015fe:	429d      	cmp	r5, r3
c0d01600:	d300      	bcc.n	c0d01604 <snprintf+0x64>
c0d01602:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01604:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01606:	4631      	mov	r1, r6
c0d01608:	462a      	mov	r2, r5
c0d0160a:	461c      	mov	r4, r3
c0d0160c:	f7ff fb98 	bl	c0d00d40 <os_memmove>
c0d01610:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01612:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01614:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01616:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01618:	2b00      	cmp	r3, #0
c0d0161a:	d100      	bne.n	c0d0161e <snprintf+0x7e>
c0d0161c:	e1f6      	b.n	c0d01a0c <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d0161e:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01620:	5d71      	ldrb	r1, [r6, r5]
c0d01622:	2925      	cmp	r1, #37	; 0x25
c0d01624:	d000      	beq.n	c0d01628 <snprintf+0x88>
c0d01626:	e0ab      	b.n	c0d01780 <snprintf+0x1e0>
c0d01628:	9304      	str	r3, [sp, #16]
c0d0162a:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d0162c:	1c40      	adds	r0, r0, #1
c0d0162e:	2100      	movs	r1, #0
c0d01630:	2220      	movs	r2, #32
c0d01632:	920a      	str	r2, [sp, #40]	; 0x28
c0d01634:	220a      	movs	r2, #10
c0d01636:	9203      	str	r2, [sp, #12]
c0d01638:	9102      	str	r1, [sp, #8]
c0d0163a:	9106      	str	r1, [sp, #24]
c0d0163c:	910d      	str	r1, [sp, #52]	; 0x34
c0d0163e:	460b      	mov	r3, r1
c0d01640:	2102      	movs	r1, #2
c0d01642:	910c      	str	r1, [sp, #48]	; 0x30
c0d01644:	4606      	mov	r6, r0
c0d01646:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01648:	7831      	ldrb	r1, [r6, #0]
c0d0164a:	1c76      	adds	r6, r6, #1
c0d0164c:	2300      	movs	r3, #0
c0d0164e:	2962      	cmp	r1, #98	; 0x62
c0d01650:	dc41      	bgt.n	c0d016d6 <snprintf+0x136>
c0d01652:	4608      	mov	r0, r1
c0d01654:	3825      	subs	r0, #37	; 0x25
c0d01656:	2823      	cmp	r0, #35	; 0x23
c0d01658:	d900      	bls.n	c0d0165c <snprintf+0xbc>
c0d0165a:	e094      	b.n	c0d01786 <snprintf+0x1e6>
c0d0165c:	0040      	lsls	r0, r0, #1
c0d0165e:	46c0      	nop			; (mov r8, r8)
c0d01660:	4478      	add	r0, pc
c0d01662:	8880      	ldrh	r0, [r0, #4]
c0d01664:	0040      	lsls	r0, r0, #1
c0d01666:	4487      	add	pc, r0
c0d01668:	0186012d 	.word	0x0186012d
c0d0166c:	01860186 	.word	0x01860186
c0d01670:	00510186 	.word	0x00510186
c0d01674:	01860186 	.word	0x01860186
c0d01678:	00580023 	.word	0x00580023
c0d0167c:	00240186 	.word	0x00240186
c0d01680:	00240024 	.word	0x00240024
c0d01684:	00240024 	.word	0x00240024
c0d01688:	00240024 	.word	0x00240024
c0d0168c:	00240024 	.word	0x00240024
c0d01690:	01860024 	.word	0x01860024
c0d01694:	01860186 	.word	0x01860186
c0d01698:	01860186 	.word	0x01860186
c0d0169c:	01860186 	.word	0x01860186
c0d016a0:	01860186 	.word	0x01860186
c0d016a4:	01860186 	.word	0x01860186
c0d016a8:	01860186 	.word	0x01860186
c0d016ac:	006c0186 	.word	0x006c0186
c0d016b0:	e7c9      	b.n	c0d01646 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d016b2:	2930      	cmp	r1, #48	; 0x30
c0d016b4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d016b6:	4603      	mov	r3, r0
c0d016b8:	d100      	bne.n	c0d016bc <snprintf+0x11c>
c0d016ba:	460b      	mov	r3, r1
c0d016bc:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d016be:	2c00      	cmp	r4, #0
c0d016c0:	d000      	beq.n	c0d016c4 <snprintf+0x124>
c0d016c2:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d016c4:	200a      	movs	r0, #10
c0d016c6:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d016c8:	1840      	adds	r0, r0, r1
c0d016ca:	3830      	subs	r0, #48	; 0x30
c0d016cc:	900d      	str	r0, [sp, #52]	; 0x34
c0d016ce:	4630      	mov	r0, r6
c0d016d0:	930a      	str	r3, [sp, #40]	; 0x28
c0d016d2:	4613      	mov	r3, r2
c0d016d4:	e7b4      	b.n	c0d01640 <snprintf+0xa0>
c0d016d6:	296f      	cmp	r1, #111	; 0x6f
c0d016d8:	dd11      	ble.n	c0d016fe <snprintf+0x15e>
c0d016da:	3970      	subs	r1, #112	; 0x70
c0d016dc:	2908      	cmp	r1, #8
c0d016de:	d900      	bls.n	c0d016e2 <snprintf+0x142>
c0d016e0:	e149      	b.n	c0d01976 <snprintf+0x3d6>
c0d016e2:	0049      	lsls	r1, r1, #1
c0d016e4:	4479      	add	r1, pc
c0d016e6:	8889      	ldrh	r1, [r1, #4]
c0d016e8:	0049      	lsls	r1, r1, #1
c0d016ea:	448f      	add	pc, r1
c0d016ec:	01440051 	.word	0x01440051
c0d016f0:	002e0144 	.word	0x002e0144
c0d016f4:	00590144 	.word	0x00590144
c0d016f8:	01440144 	.word	0x01440144
c0d016fc:	0051      	.short	0x0051
c0d016fe:	2963      	cmp	r1, #99	; 0x63
c0d01700:	d054      	beq.n	c0d017ac <snprintf+0x20c>
c0d01702:	2964      	cmp	r1, #100	; 0x64
c0d01704:	d057      	beq.n	c0d017b6 <snprintf+0x216>
c0d01706:	2968      	cmp	r1, #104	; 0x68
c0d01708:	d01d      	beq.n	c0d01746 <snprintf+0x1a6>
c0d0170a:	e134      	b.n	c0d01976 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d0170c:	7830      	ldrb	r0, [r6, #0]
c0d0170e:	2873      	cmp	r0, #115	; 0x73
c0d01710:	d000      	beq.n	c0d01714 <snprintf+0x174>
c0d01712:	e130      	b.n	c0d01976 <snprintf+0x3d6>
c0d01714:	4630      	mov	r0, r6
c0d01716:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01718:	e00d      	b.n	c0d01736 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d0171a:	7830      	ldrb	r0, [r6, #0]
c0d0171c:	282a      	cmp	r0, #42	; 0x2a
c0d0171e:	d000      	beq.n	c0d01722 <snprintf+0x182>
c0d01720:	e129      	b.n	c0d01976 <snprintf+0x3d6>
c0d01722:	7871      	ldrb	r1, [r6, #1]
c0d01724:	1c70      	adds	r0, r6, #1
c0d01726:	2301      	movs	r3, #1
c0d01728:	2948      	cmp	r1, #72	; 0x48
c0d0172a:	d004      	beq.n	c0d01736 <snprintf+0x196>
c0d0172c:	2968      	cmp	r1, #104	; 0x68
c0d0172e:	d002      	beq.n	c0d01736 <snprintf+0x196>
c0d01730:	2973      	cmp	r1, #115	; 0x73
c0d01732:	d000      	beq.n	c0d01736 <snprintf+0x196>
c0d01734:	e11f      	b.n	c0d01976 <snprintf+0x3d6>
c0d01736:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01738:	1d0a      	adds	r2, r1, #4
c0d0173a:	920f      	str	r2, [sp, #60]	; 0x3c
c0d0173c:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d0173e:	9102      	str	r1, [sp, #8]
c0d01740:	e77e      	b.n	c0d01640 <snprintf+0xa0>
c0d01742:	2001      	movs	r0, #1
c0d01744:	9006      	str	r0, [sp, #24]
c0d01746:	2010      	movs	r0, #16
c0d01748:	9003      	str	r0, [sp, #12]
c0d0174a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d0174c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0174e:	1d01      	adds	r1, r0, #4
c0d01750:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01752:	2103      	movs	r1, #3
c0d01754:	400a      	ands	r2, r1
c0d01756:	1c5b      	adds	r3, r3, #1
c0d01758:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d0175a:	2a01      	cmp	r2, #1
c0d0175c:	d100      	bne.n	c0d01760 <snprintf+0x1c0>
c0d0175e:	e0b8      	b.n	c0d018d2 <snprintf+0x332>
c0d01760:	2a02      	cmp	r2, #2
c0d01762:	d100      	bne.n	c0d01766 <snprintf+0x1c6>
c0d01764:	e104      	b.n	c0d01970 <snprintf+0x3d0>
c0d01766:	2a03      	cmp	r2, #3
c0d01768:	4630      	mov	r0, r6
c0d0176a:	d100      	bne.n	c0d0176e <snprintf+0x1ce>
c0d0176c:	e768      	b.n	c0d01640 <snprintf+0xa0>
c0d0176e:	9c08      	ldr	r4, [sp, #32]
c0d01770:	4625      	mov	r5, r4
c0d01772:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01774:	1948      	adds	r0, r1, r5
c0d01776:	7840      	ldrb	r0, [r0, #1]
c0d01778:	1c6d      	adds	r5, r5, #1
c0d0177a:	2800      	cmp	r0, #0
c0d0177c:	d1fa      	bne.n	c0d01774 <snprintf+0x1d4>
c0d0177e:	e0ab      	b.n	c0d018d8 <snprintf+0x338>
c0d01780:	4606      	mov	r6, r0
c0d01782:	920e      	str	r2, [sp, #56]	; 0x38
c0d01784:	e109      	b.n	c0d0199a <snprintf+0x3fa>
c0d01786:	2958      	cmp	r1, #88	; 0x58
c0d01788:	d000      	beq.n	c0d0178c <snprintf+0x1ec>
c0d0178a:	e0f4      	b.n	c0d01976 <snprintf+0x3d6>
c0d0178c:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d0178e:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01790:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01792:	1d01      	adds	r1, r0, #4
c0d01794:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01796:	6802      	ldr	r2, [r0, #0]
c0d01798:	2000      	movs	r0, #0
c0d0179a:	9005      	str	r0, [sp, #20]
c0d0179c:	2510      	movs	r5, #16
c0d0179e:	e014      	b.n	c0d017ca <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d017a0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d017a2:	1d01      	adds	r1, r0, #4
c0d017a4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d017a6:	6802      	ldr	r2, [r0, #0]
c0d017a8:	2000      	movs	r0, #0
c0d017aa:	e00c      	b.n	c0d017c6 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d017ac:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d017ae:	1d01      	adds	r1, r0, #4
c0d017b0:	910f      	str	r1, [sp, #60]	; 0x3c
c0d017b2:	6800      	ldr	r0, [r0, #0]
c0d017b4:	e087      	b.n	c0d018c6 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d017b6:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d017b8:	1d01      	adds	r1, r0, #4
c0d017ba:	910f      	str	r1, [sp, #60]	; 0x3c
c0d017bc:	6800      	ldr	r0, [r0, #0]
c0d017be:	17c1      	asrs	r1, r0, #31
c0d017c0:	1842      	adds	r2, r0, r1
c0d017c2:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d017c4:	0fc0      	lsrs	r0, r0, #31
c0d017c6:	9005      	str	r0, [sp, #20]
c0d017c8:	250a      	movs	r5, #10
c0d017ca:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017cc:	4295      	cmp	r5, r2
c0d017ce:	920e      	str	r2, [sp, #56]	; 0x38
c0d017d0:	d814      	bhi.n	c0d017fc <snprintf+0x25c>
c0d017d2:	2201      	movs	r2, #1
c0d017d4:	4628      	mov	r0, r5
c0d017d6:	920b      	str	r2, [sp, #44]	; 0x2c
c0d017d8:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d017da:	4629      	mov	r1, r5
c0d017dc:	f001 fb4a 	bl	c0d02e74 <__aeabi_uidiv>
c0d017e0:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d017e2:	4288      	cmp	r0, r1
c0d017e4:	d109      	bne.n	c0d017fa <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017e6:	4628      	mov	r0, r5
c0d017e8:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d017ea:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d017ec:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017ee:	910d      	str	r1, [sp, #52]	; 0x34
c0d017f0:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d017f2:	4288      	cmp	r0, r1
c0d017f4:	4622      	mov	r2, r4
c0d017f6:	d9ee      	bls.n	c0d017d6 <snprintf+0x236>
c0d017f8:	e000      	b.n	c0d017fc <snprintf+0x25c>
c0d017fa:	460c      	mov	r4, r1
c0d017fc:	950c      	str	r5, [sp, #48]	; 0x30
c0d017fe:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01800:	2000      	movs	r0, #0
c0d01802:	4603      	mov	r3, r0
c0d01804:	43c1      	mvns	r1, r0
c0d01806:	9c05      	ldr	r4, [sp, #20]
c0d01808:	2c00      	cmp	r4, #0
c0d0180a:	d100      	bne.n	c0d0180e <snprintf+0x26e>
c0d0180c:	4621      	mov	r1, r4
c0d0180e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01810:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01812:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01814:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01816:	b2ca      	uxtb	r2, r1
c0d01818:	2a30      	cmp	r2, #48	; 0x30
c0d0181a:	d106      	bne.n	c0d0182a <snprintf+0x28a>
c0d0181c:	2c00      	cmp	r4, #0
c0d0181e:	d004      	beq.n	c0d0182a <snprintf+0x28a>
c0d01820:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01822:	232d      	movs	r3, #45	; 0x2d
c0d01824:	700b      	strb	r3, [r1, #0]
c0d01826:	2400      	movs	r4, #0
c0d01828:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d0182a:	1e81      	subs	r1, r0, #2
c0d0182c:	290d      	cmp	r1, #13
c0d0182e:	d80d      	bhi.n	c0d0184c <snprintf+0x2ac>
c0d01830:	1e41      	subs	r1, r0, #1
c0d01832:	d00b      	beq.n	c0d0184c <snprintf+0x2ac>
c0d01834:	a810      	add	r0, sp, #64	; 0x40
c0d01836:	9405      	str	r4, [sp, #20]
c0d01838:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d0183a:	4320      	orrs	r0, r4
c0d0183c:	f001 fc9a 	bl	c0d03174 <__aeabi_memset>
c0d01840:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01842:	1900      	adds	r0, r0, r4
c0d01844:	9c05      	ldr	r4, [sp, #20]
c0d01846:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01848:	1840      	adds	r0, r0, r1
c0d0184a:	1e43      	subs	r3, r0, #1
c0d0184c:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0184e:	2c00      	cmp	r4, #0
c0d01850:	9601      	str	r6, [sp, #4]
c0d01852:	d003      	beq.n	c0d0185c <snprintf+0x2bc>
c0d01854:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01856:	222d      	movs	r2, #45	; 0x2d
c0d01858:	54c2      	strb	r2, [r0, r3]
c0d0185a:	1c5b      	adds	r3, r3, #1
c0d0185c:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d0185e:	2900      	cmp	r1, #0
c0d01860:	d003      	beq.n	c0d0186a <snprintf+0x2ca>
c0d01862:	2800      	cmp	r0, #0
c0d01864:	d003      	beq.n	c0d0186e <snprintf+0x2ce>
c0d01866:	a06c      	add	r0, pc, #432	; (adr r0, c0d01a18 <g_pcHex_cap>)
c0d01868:	e002      	b.n	c0d01870 <snprintf+0x2d0>
c0d0186a:	461c      	mov	r4, r3
c0d0186c:	e016      	b.n	c0d0189c <snprintf+0x2fc>
c0d0186e:	a06e      	add	r0, pc, #440	; (adr r0, c0d01a28 <g_pcHex>)
c0d01870:	900d      	str	r0, [sp, #52]	; 0x34
c0d01872:	461c      	mov	r4, r3
c0d01874:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01876:	460e      	mov	r6, r1
c0d01878:	f001 fafc 	bl	c0d02e74 <__aeabi_uidiv>
c0d0187c:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d0187e:	4629      	mov	r1, r5
c0d01880:	f001 fb7e 	bl	c0d02f80 <__aeabi_uidivmod>
c0d01884:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01886:	5c40      	ldrb	r0, [r0, r1]
c0d01888:	a910      	add	r1, sp, #64	; 0x40
c0d0188a:	5508      	strb	r0, [r1, r4]
c0d0188c:	4630      	mov	r0, r6
c0d0188e:	4629      	mov	r1, r5
c0d01890:	f001 faf0 	bl	c0d02e74 <__aeabi_uidiv>
c0d01894:	1c64      	adds	r4, r4, #1
c0d01896:	42b5      	cmp	r5, r6
c0d01898:	4601      	mov	r1, r0
c0d0189a:	d9eb      	bls.n	c0d01874 <snprintf+0x2d4>
c0d0189c:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d0189e:	429c      	cmp	r4, r3
c0d018a0:	4625      	mov	r5, r4
c0d018a2:	d300      	bcc.n	c0d018a6 <snprintf+0x306>
c0d018a4:	461d      	mov	r5, r3
c0d018a6:	a910      	add	r1, sp, #64	; 0x40
c0d018a8:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d018aa:	4620      	mov	r0, r4
c0d018ac:	462a      	mov	r2, r5
c0d018ae:	461e      	mov	r6, r3
c0d018b0:	f7ff fa46 	bl	c0d00d40 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d018b4:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d018b6:	1961      	adds	r1, r4, r5
c0d018b8:	910e      	str	r1, [sp, #56]	; 0x38
c0d018ba:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d018bc:	2800      	cmp	r0, #0
c0d018be:	9e01      	ldr	r6, [sp, #4]
c0d018c0:	d16b      	bne.n	c0d0199a <snprintf+0x3fa>
c0d018c2:	e0a3      	b.n	c0d01a0c <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d018c4:	2025      	movs	r0, #37	; 0x25
c0d018c6:	9907      	ldr	r1, [sp, #28]
c0d018c8:	7008      	strb	r0, [r1, #0]
c0d018ca:	9804      	ldr	r0, [sp, #16]
c0d018cc:	1e40      	subs	r0, r0, #1
c0d018ce:	1c49      	adds	r1, r1, #1
c0d018d0:	e05f      	b.n	c0d01992 <snprintf+0x3f2>
c0d018d2:	9d02      	ldr	r5, [sp, #8]
c0d018d4:	9c08      	ldr	r4, [sp, #32]
c0d018d6:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d018d8:	9803      	ldr	r0, [sp, #12]
c0d018da:	2810      	cmp	r0, #16
c0d018dc:	9807      	ldr	r0, [sp, #28]
c0d018de:	d161      	bne.n	c0d019a4 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d018e0:	2d00      	cmp	r5, #0
c0d018e2:	d06a      	beq.n	c0d019ba <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d018e4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d018e6:	1900      	adds	r0, r0, r4
c0d018e8:	900e      	str	r0, [sp, #56]	; 0x38
c0d018ea:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d018ec:	1aa0      	subs	r0, r4, r2
c0d018ee:	9b05      	ldr	r3, [sp, #20]
c0d018f0:	4283      	cmp	r3, r0
c0d018f2:	d800      	bhi.n	c0d018f6 <snprintf+0x356>
c0d018f4:	4603      	mov	r3, r0
c0d018f6:	930c      	str	r3, [sp, #48]	; 0x30
c0d018f8:	435c      	muls	r4, r3
c0d018fa:	940a      	str	r4, [sp, #40]	; 0x28
c0d018fc:	1c60      	adds	r0, r4, #1
c0d018fe:	9007      	str	r0, [sp, #28]
c0d01900:	2000      	movs	r0, #0
c0d01902:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01904:	9100      	str	r1, [sp, #0]
c0d01906:	940e      	str	r4, [sp, #56]	; 0x38
c0d01908:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0190a:	18e3      	adds	r3, r4, r3
c0d0190c:	900d      	str	r0, [sp, #52]	; 0x34
c0d0190e:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01910:	200f      	movs	r0, #15
c0d01912:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01914:	0909      	lsrs	r1, r1, #4
c0d01916:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01918:	18a4      	adds	r4, r4, r2
c0d0191a:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d0191c:	2c02      	cmp	r4, #2
c0d0191e:	d375      	bcc.n	c0d01a0c <snprintf+0x46c>
c0d01920:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01922:	2c01      	cmp	r4, #1
c0d01924:	d003      	beq.n	c0d0192e <snprintf+0x38e>
c0d01926:	2c00      	cmp	r4, #0
c0d01928:	d108      	bne.n	c0d0193c <snprintf+0x39c>
c0d0192a:	a43f      	add	r4, pc, #252	; (adr r4, c0d01a28 <g_pcHex>)
c0d0192c:	e000      	b.n	c0d01930 <snprintf+0x390>
c0d0192e:	a43a      	add	r4, pc, #232	; (adr r4, c0d01a18 <g_pcHex_cap>)
c0d01930:	b2c9      	uxtb	r1, r1
c0d01932:	5c61      	ldrb	r1, [r4, r1]
c0d01934:	7019      	strb	r1, [r3, #0]
c0d01936:	b2c0      	uxtb	r0, r0
c0d01938:	5c20      	ldrb	r0, [r4, r0]
c0d0193a:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d0193c:	9807      	ldr	r0, [sp, #28]
c0d0193e:	4290      	cmp	r0, r2
c0d01940:	d064      	beq.n	c0d01a0c <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01942:	1e92      	subs	r2, r2, #2
c0d01944:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01946:	1ca4      	adds	r4, r4, #2
c0d01948:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0194a:	1c40      	adds	r0, r0, #1
c0d0194c:	42a8      	cmp	r0, r5
c0d0194e:	9900      	ldr	r1, [sp, #0]
c0d01950:	d3d9      	bcc.n	c0d01906 <snprintf+0x366>
c0d01952:	900d      	str	r0, [sp, #52]	; 0x34
c0d01954:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01956:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01958:	1a08      	subs	r0, r1, r0
c0d0195a:	9b05      	ldr	r3, [sp, #20]
c0d0195c:	4283      	cmp	r3, r0
c0d0195e:	d800      	bhi.n	c0d01962 <snprintf+0x3c2>
c0d01960:	4603      	mov	r3, r0
c0d01962:	4608      	mov	r0, r1
c0d01964:	4358      	muls	r0, r3
c0d01966:	1820      	adds	r0, r4, r0
c0d01968:	900e      	str	r0, [sp, #56]	; 0x38
c0d0196a:	1898      	adds	r0, r3, r2
c0d0196c:	1c43      	adds	r3, r0, #1
c0d0196e:	e038      	b.n	c0d019e2 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01970:	7808      	ldrb	r0, [r1, #0]
c0d01972:	2800      	cmp	r0, #0
c0d01974:	d023      	beq.n	c0d019be <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01976:	2005      	movs	r0, #5
c0d01978:	9d04      	ldr	r5, [sp, #16]
c0d0197a:	2d05      	cmp	r5, #5
c0d0197c:	462c      	mov	r4, r5
c0d0197e:	d300      	bcc.n	c0d01982 <snprintf+0x3e2>
c0d01980:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01982:	9807      	ldr	r0, [sp, #28]
c0d01984:	a12c      	add	r1, pc, #176	; (adr r1, c0d01a38 <g_pcHex+0x10>)
c0d01986:	4622      	mov	r2, r4
c0d01988:	f7ff f9da 	bl	c0d00d40 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d0198c:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d0198e:	9907      	ldr	r1, [sp, #28]
c0d01990:	1909      	adds	r1, r1, r4
c0d01992:	910e      	str	r1, [sp, #56]	; 0x38
c0d01994:	4603      	mov	r3, r0
c0d01996:	2800      	cmp	r0, #0
c0d01998:	d038      	beq.n	c0d01a0c <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0199a:	7830      	ldrb	r0, [r6, #0]
c0d0199c:	2800      	cmp	r0, #0
c0d0199e:	9908      	ldr	r1, [sp, #32]
c0d019a0:	d034      	beq.n	c0d01a0c <snprintf+0x46c>
c0d019a2:	e61f      	b.n	c0d015e4 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d019a4:	429d      	cmp	r5, r3
c0d019a6:	d300      	bcc.n	c0d019aa <snprintf+0x40a>
c0d019a8:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d019aa:	462a      	mov	r2, r5
c0d019ac:	461c      	mov	r4, r3
c0d019ae:	f7ff f9c7 	bl	c0d00d40 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d019b2:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d019b4:	9907      	ldr	r1, [sp, #28]
c0d019b6:	1949      	adds	r1, r1, r5
c0d019b8:	e00f      	b.n	c0d019da <snprintf+0x43a>
c0d019ba:	900e      	str	r0, [sp, #56]	; 0x38
c0d019bc:	e7ed      	b.n	c0d0199a <snprintf+0x3fa>
c0d019be:	9b04      	ldr	r3, [sp, #16]
c0d019c0:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d019c2:	429c      	cmp	r4, r3
c0d019c4:	d300      	bcc.n	c0d019c8 <snprintf+0x428>
c0d019c6:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d019c8:	2120      	movs	r1, #32
c0d019ca:	9807      	ldr	r0, [sp, #28]
c0d019cc:	4622      	mov	r2, r4
c0d019ce:	f7ff f9ad 	bl	c0d00d2c <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d019d2:	9804      	ldr	r0, [sp, #16]
c0d019d4:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d019d6:	9907      	ldr	r1, [sp, #28]
c0d019d8:	1909      	adds	r1, r1, r4
c0d019da:	910e      	str	r1, [sp, #56]	; 0x38
c0d019dc:	4603      	mov	r3, r0
c0d019de:	2800      	cmp	r0, #0
c0d019e0:	d014      	beq.n	c0d01a0c <snprintf+0x46c>
c0d019e2:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d019e4:	42a8      	cmp	r0, r5
c0d019e6:	d9d8      	bls.n	c0d0199a <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d019e8:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d019ea:	429a      	cmp	r2, r3
c0d019ec:	d300      	bcc.n	c0d019f0 <snprintf+0x450>
c0d019ee:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d019f0:	2120      	movs	r1, #32
c0d019f2:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d019f4:	4628      	mov	r0, r5
c0d019f6:	920d      	str	r2, [sp, #52]	; 0x34
c0d019f8:	461c      	mov	r4, r3
c0d019fa:	f7ff f997 	bl	c0d00d2c <os_memset>
c0d019fe:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01a00:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01a02:	182d      	adds	r5, r5, r0
c0d01a04:	950e      	str	r5, [sp, #56]	; 0x38
c0d01a06:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01a08:	2c00      	cmp	r4, #0
c0d01a0a:	d1c6      	bne.n	c0d0199a <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01a0c:	2000      	movs	r0, #0
c0d01a0e:	b014      	add	sp, #80	; 0x50
c0d01a10:	bcf0      	pop	{r4, r5, r6, r7}
c0d01a12:	bc02      	pop	{r1}
c0d01a14:	b001      	add	sp, #4
c0d01a16:	4708      	bx	r1

c0d01a18 <g_pcHex_cap>:
c0d01a18:	33323130 	.word	0x33323130
c0d01a1c:	37363534 	.word	0x37363534
c0d01a20:	42413938 	.word	0x42413938
c0d01a24:	46454443 	.word	0x46454443

c0d01a28 <g_pcHex>:
c0d01a28:	33323130 	.word	0x33323130
c0d01a2c:	37363534 	.word	0x37363534
c0d01a30:	62613938 	.word	0x62613938
c0d01a34:	66656463 	.word	0x66656463
c0d01a38:	4f525245 	.word	0x4f525245
c0d01a3c:	00000052 	.word	0x00000052

c0d01a40 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01a40:	b580      	push	{r7, lr}
c0d01a42:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01a44:	4904      	ldr	r1, [pc, #16]	; (c0d01a58 <pic+0x18>)
c0d01a46:	4288      	cmp	r0, r1
c0d01a48:	d304      	bcc.n	c0d01a54 <pic+0x14>
c0d01a4a:	4904      	ldr	r1, [pc, #16]	; (c0d01a5c <pic+0x1c>)
c0d01a4c:	4288      	cmp	r0, r1
c0d01a4e:	d201      	bcs.n	c0d01a54 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01a50:	f000 f806 	bl	c0d01a60 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01a54:	bd80      	pop	{r7, pc}
c0d01a56:	46c0      	nop			; (mov r8, r8)
c0d01a58:	c0d00000 	.word	0xc0d00000
c0d01a5c:	c0d03800 	.word	0xc0d03800

c0d01a60 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01a60:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01a62:	4902      	ldr	r1, [pc, #8]	; (c0d01a6c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01a64:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01a66:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01a68:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01a6a:	4770      	bx	lr
c0d01a6c:	c0d01a61 	.word	0xc0d01a61

c0d01a70 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01a70:	b580      	push	{r7, lr}
c0d01a72:	af00      	add	r7, sp, #0
c0d01a74:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01a76:	490a      	ldr	r1, [pc, #40]	; (c0d01aa0 <check_api_level+0x30>)
c0d01a78:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a7a:	490a      	ldr	r1, [pc, #40]	; (c0d01aa4 <check_api_level+0x34>)
c0d01a7c:	680a      	ldr	r2, [r1, #0]
c0d01a7e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01a80:	9003      	str	r0, [sp, #12]
c0d01a82:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a84:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a86:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a88:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01a8a:	4807      	ldr	r0, [pc, #28]	; (c0d01aa8 <check_api_level+0x38>)
c0d01a8c:	9a01      	ldr	r2, [sp, #4]
c0d01a8e:	4282      	cmp	r2, r0
c0d01a90:	d101      	bne.n	c0d01a96 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01a92:	b004      	add	sp, #16
c0d01a94:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a96:	6808      	ldr	r0, [r1, #0]
c0d01a98:	2104      	movs	r1, #4
c0d01a9a:	f001 fc03 	bl	c0d032a4 <longjmp>
c0d01a9e:	46c0      	nop			; (mov r8, r8)
c0d01aa0:	60000137 	.word	0x60000137
c0d01aa4:	20001bb8 	.word	0x20001bb8
c0d01aa8:	900001c6 	.word	0x900001c6

c0d01aac <reset>:
  }
}

void reset ( void ) 
{
c0d01aac:	b580      	push	{r7, lr}
c0d01aae:	af00      	add	r7, sp, #0
c0d01ab0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01ab2:	4809      	ldr	r0, [pc, #36]	; (c0d01ad8 <reset+0x2c>)
c0d01ab4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ab6:	4809      	ldr	r0, [pc, #36]	; (c0d01adc <reset+0x30>)
c0d01ab8:	6801      	ldr	r1, [r0, #0]
c0d01aba:	9101      	str	r1, [sp, #4]
c0d01abc:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01abe:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01ac0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ac2:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01ac4:	4906      	ldr	r1, [pc, #24]	; (c0d01ae0 <reset+0x34>)
c0d01ac6:	9a00      	ldr	r2, [sp, #0]
c0d01ac8:	428a      	cmp	r2, r1
c0d01aca:	d101      	bne.n	c0d01ad0 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01acc:	b002      	add	sp, #8
c0d01ace:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ad0:	6800      	ldr	r0, [r0, #0]
c0d01ad2:	2104      	movs	r1, #4
c0d01ad4:	f001 fbe6 	bl	c0d032a4 <longjmp>
c0d01ad8:	60000200 	.word	0x60000200
c0d01adc:	20001bb8 	.word	0x20001bb8
c0d01ae0:	900002f1 	.word	0x900002f1

c0d01ae4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01ae4:	b5d0      	push	{r4, r6, r7, lr}
c0d01ae6:	af02      	add	r7, sp, #8
c0d01ae8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01aea:	4b0a      	ldr	r3, [pc, #40]	; (c0d01b14 <nvm_write+0x30>)
c0d01aec:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01aee:	4b0a      	ldr	r3, [pc, #40]	; (c0d01b18 <nvm_write+0x34>)
c0d01af0:	681c      	ldr	r4, [r3, #0]
c0d01af2:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01af4:	ac03      	add	r4, sp, #12
c0d01af6:	c407      	stmia	r4!, {r0, r1, r2}
c0d01af8:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01afa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01afc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01afe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01b00:	4806      	ldr	r0, [pc, #24]	; (c0d01b1c <nvm_write+0x38>)
c0d01b02:	9901      	ldr	r1, [sp, #4]
c0d01b04:	4281      	cmp	r1, r0
c0d01b06:	d101      	bne.n	c0d01b0c <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01b08:	b006      	add	sp, #24
c0d01b0a:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b0c:	6818      	ldr	r0, [r3, #0]
c0d01b0e:	2104      	movs	r1, #4
c0d01b10:	f001 fbc8 	bl	c0d032a4 <longjmp>
c0d01b14:	6000037f 	.word	0x6000037f
c0d01b18:	20001bb8 	.word	0x20001bb8
c0d01b1c:	900003bc 	.word	0x900003bc

c0d01b20 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01b20:	b580      	push	{r7, lr}
c0d01b22:	af00      	add	r7, sp, #0
c0d01b24:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01b26:	4a0a      	ldr	r2, [pc, #40]	; (c0d01b50 <cx_rng+0x30>)
c0d01b28:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b2a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01b54 <cx_rng+0x34>)
c0d01b2c:	6813      	ldr	r3, [r2, #0]
c0d01b2e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01b30:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01b32:	9103      	str	r1, [sp, #12]
c0d01b34:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b36:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b38:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b3a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01b3c:	4906      	ldr	r1, [pc, #24]	; (c0d01b58 <cx_rng+0x38>)
c0d01b3e:	9b00      	ldr	r3, [sp, #0]
c0d01b40:	428b      	cmp	r3, r1
c0d01b42:	d101      	bne.n	c0d01b48 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01b44:	b004      	add	sp, #16
c0d01b46:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b48:	6810      	ldr	r0, [r2, #0]
c0d01b4a:	2104      	movs	r1, #4
c0d01b4c:	f001 fbaa 	bl	c0d032a4 <longjmp>
c0d01b50:	6000052c 	.word	0x6000052c
c0d01b54:	20001bb8 	.word	0x20001bb8
c0d01b58:	90000567 	.word	0x90000567

c0d01b5c <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01b5c:	b580      	push	{r7, lr}
c0d01b5e:	af00      	add	r7, sp, #0
c0d01b60:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01b62:	490a      	ldr	r1, [pc, #40]	; (c0d01b8c <cx_sha256_init+0x30>)
c0d01b64:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b66:	490a      	ldr	r1, [pc, #40]	; (c0d01b90 <cx_sha256_init+0x34>)
c0d01b68:	680a      	ldr	r2, [r1, #0]
c0d01b6a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01b6c:	9003      	str	r0, [sp, #12]
c0d01b6e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b70:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b72:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b74:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01b76:	4a07      	ldr	r2, [pc, #28]	; (c0d01b94 <cx_sha256_init+0x38>)
c0d01b78:	9b01      	ldr	r3, [sp, #4]
c0d01b7a:	4293      	cmp	r3, r2
c0d01b7c:	d101      	bne.n	c0d01b82 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b7e:	b004      	add	sp, #16
c0d01b80:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b82:	6808      	ldr	r0, [r1, #0]
c0d01b84:	2104      	movs	r1, #4
c0d01b86:	f001 fb8d 	bl	c0d032a4 <longjmp>
c0d01b8a:	46c0      	nop			; (mov r8, r8)
c0d01b8c:	600008db 	.word	0x600008db
c0d01b90:	20001bb8 	.word	0x20001bb8
c0d01b94:	90000864 	.word	0x90000864

c0d01b98 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01b98:	b580      	push	{r7, lr}
c0d01b9a:	af00      	add	r7, sp, #0
c0d01b9c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01b9e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01bc8 <cx_keccak_init+0x30>)
c0d01ba0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ba2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01bcc <cx_keccak_init+0x34>)
c0d01ba4:	6813      	ldr	r3, [r2, #0]
c0d01ba6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01ba8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01baa:	9103      	str	r1, [sp, #12]
c0d01bac:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bae:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bb0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bb2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01bb4:	4906      	ldr	r1, [pc, #24]	; (c0d01bd0 <cx_keccak_init+0x38>)
c0d01bb6:	9b00      	ldr	r3, [sp, #0]
c0d01bb8:	428b      	cmp	r3, r1
c0d01bba:	d101      	bne.n	c0d01bc0 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01bbc:	b004      	add	sp, #16
c0d01bbe:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bc0:	6810      	ldr	r0, [r2, #0]
c0d01bc2:	2104      	movs	r1, #4
c0d01bc4:	f001 fb6e 	bl	c0d032a4 <longjmp>
c0d01bc8:	60000c3c 	.word	0x60000c3c
c0d01bcc:	20001bb8 	.word	0x20001bb8
c0d01bd0:	90000c39 	.word	0x90000c39

c0d01bd4 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01bd4:	b5b0      	push	{r4, r5, r7, lr}
c0d01bd6:	af02      	add	r7, sp, #8
c0d01bd8:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01bda:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c08 <cx_hash+0x34>)
c0d01bdc:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bde:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c0c <cx_hash+0x38>)
c0d01be0:	6825      	ldr	r5, [r4, #0]
c0d01be2:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01be4:	ad03      	add	r5, sp, #12
c0d01be6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01be8:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01bea:	9007      	str	r0, [sp, #28]
c0d01bec:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bee:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bf0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bf2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01bf4:	4906      	ldr	r1, [pc, #24]	; (c0d01c10 <cx_hash+0x3c>)
c0d01bf6:	9a01      	ldr	r2, [sp, #4]
c0d01bf8:	428a      	cmp	r2, r1
c0d01bfa:	d101      	bne.n	c0d01c00 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01bfc:	b008      	add	sp, #32
c0d01bfe:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c00:	6820      	ldr	r0, [r4, #0]
c0d01c02:	2104      	movs	r1, #4
c0d01c04:	f001 fb4e 	bl	c0d032a4 <longjmp>
c0d01c08:	60000ea6 	.word	0x60000ea6
c0d01c0c:	20001bb8 	.word	0x20001bb8
c0d01c10:	90000e46 	.word	0x90000e46

c0d01c14 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01c14:	b5b0      	push	{r4, r5, r7, lr}
c0d01c16:	af02      	add	r7, sp, #8
c0d01c18:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01c1a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c44 <cx_ecfp_init_public_key+0x30>)
c0d01c1c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c1e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c48 <cx_ecfp_init_public_key+0x34>)
c0d01c20:	6825      	ldr	r5, [r4, #0]
c0d01c22:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c24:	ad02      	add	r5, sp, #8
c0d01c26:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c28:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c2a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c2c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c2e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01c30:	4906      	ldr	r1, [pc, #24]	; (c0d01c4c <cx_ecfp_init_public_key+0x38>)
c0d01c32:	9a00      	ldr	r2, [sp, #0]
c0d01c34:	428a      	cmp	r2, r1
c0d01c36:	d101      	bne.n	c0d01c3c <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c38:	b006      	add	sp, #24
c0d01c3a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c3c:	6820      	ldr	r0, [r4, #0]
c0d01c3e:	2104      	movs	r1, #4
c0d01c40:	f001 fb30 	bl	c0d032a4 <longjmp>
c0d01c44:	60002835 	.word	0x60002835
c0d01c48:	20001bb8 	.word	0x20001bb8
c0d01c4c:	900028f0 	.word	0x900028f0

c0d01c50 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01c50:	b5b0      	push	{r4, r5, r7, lr}
c0d01c52:	af02      	add	r7, sp, #8
c0d01c54:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01c56:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c80 <cx_ecfp_init_private_key+0x30>)
c0d01c58:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c5a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c84 <cx_ecfp_init_private_key+0x34>)
c0d01c5c:	6825      	ldr	r5, [r4, #0]
c0d01c5e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c60:	ad02      	add	r5, sp, #8
c0d01c62:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c64:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c66:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c68:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c6a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01c6c:	4906      	ldr	r1, [pc, #24]	; (c0d01c88 <cx_ecfp_init_private_key+0x38>)
c0d01c6e:	9a00      	ldr	r2, [sp, #0]
c0d01c70:	428a      	cmp	r2, r1
c0d01c72:	d101      	bne.n	c0d01c78 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c74:	b006      	add	sp, #24
c0d01c76:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c78:	6820      	ldr	r0, [r4, #0]
c0d01c7a:	2104      	movs	r1, #4
c0d01c7c:	f001 fb12 	bl	c0d032a4 <longjmp>
c0d01c80:	600029ed 	.word	0x600029ed
c0d01c84:	20001bb8 	.word	0x20001bb8
c0d01c88:	900029ae 	.word	0x900029ae

c0d01c8c <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01c8c:	b5b0      	push	{r4, r5, r7, lr}
c0d01c8e:	af02      	add	r7, sp, #8
c0d01c90:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01c92:	4c0a      	ldr	r4, [pc, #40]	; (c0d01cbc <cx_ecfp_generate_pair+0x30>)
c0d01c94:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c96:	4c0a      	ldr	r4, [pc, #40]	; (c0d01cc0 <cx_ecfp_generate_pair+0x34>)
c0d01c98:	6825      	ldr	r5, [r4, #0]
c0d01c9a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c9c:	ad02      	add	r5, sp, #8
c0d01c9e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01ca0:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ca2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ca4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ca6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01ca8:	4906      	ldr	r1, [pc, #24]	; (c0d01cc4 <cx_ecfp_generate_pair+0x38>)
c0d01caa:	9a00      	ldr	r2, [sp, #0]
c0d01cac:	428a      	cmp	r2, r1
c0d01cae:	d101      	bne.n	c0d01cb4 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01cb0:	b006      	add	sp, #24
c0d01cb2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cb4:	6820      	ldr	r0, [r4, #0]
c0d01cb6:	2104      	movs	r1, #4
c0d01cb8:	f001 faf4 	bl	c0d032a4 <longjmp>
c0d01cbc:	60002a2e 	.word	0x60002a2e
c0d01cc0:	20001bb8 	.word	0x20001bb8
c0d01cc4:	90002a74 	.word	0x90002a74

c0d01cc8 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01cc8:	b5b0      	push	{r4, r5, r7, lr}
c0d01cca:	af02      	add	r7, sp, #8
c0d01ccc:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01cce:	4c0b      	ldr	r4, [pc, #44]	; (c0d01cfc <os_perso_derive_node_bip32+0x34>)
c0d01cd0:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cd2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01d00 <os_perso_derive_node_bip32+0x38>)
c0d01cd4:	6825      	ldr	r5, [r4, #0]
c0d01cd6:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01cd8:	ad03      	add	r5, sp, #12
c0d01cda:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01cdc:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01cde:	9007      	str	r0, [sp, #28]
c0d01ce0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ce2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ce4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ce6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01ce8:	4806      	ldr	r0, [pc, #24]	; (c0d01d04 <os_perso_derive_node_bip32+0x3c>)
c0d01cea:	9901      	ldr	r1, [sp, #4]
c0d01cec:	4281      	cmp	r1, r0
c0d01cee:	d101      	bne.n	c0d01cf4 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01cf0:	b008      	add	sp, #32
c0d01cf2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cf4:	6820      	ldr	r0, [r4, #0]
c0d01cf6:	2104      	movs	r1, #4
c0d01cf8:	f001 fad4 	bl	c0d032a4 <longjmp>
c0d01cfc:	6000512b 	.word	0x6000512b
c0d01d00:	20001bb8 	.word	0x20001bb8
c0d01d04:	9000517f 	.word	0x9000517f

c0d01d08 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01d08:	b580      	push	{r7, lr}
c0d01d0a:	af00      	add	r7, sp, #0
c0d01d0c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01d0e:	490a      	ldr	r1, [pc, #40]	; (c0d01d38 <os_sched_exit+0x30>)
c0d01d10:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d12:	490a      	ldr	r1, [pc, #40]	; (c0d01d3c <os_sched_exit+0x34>)
c0d01d14:	680a      	ldr	r2, [r1, #0]
c0d01d16:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01d18:	9003      	str	r0, [sp, #12]
c0d01d1a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d1c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d1e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d20:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01d22:	4807      	ldr	r0, [pc, #28]	; (c0d01d40 <os_sched_exit+0x38>)
c0d01d24:	9a01      	ldr	r2, [sp, #4]
c0d01d26:	4282      	cmp	r2, r0
c0d01d28:	d101      	bne.n	c0d01d2e <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01d2a:	b004      	add	sp, #16
c0d01d2c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d2e:	6808      	ldr	r0, [r1, #0]
c0d01d30:	2104      	movs	r1, #4
c0d01d32:	f001 fab7 	bl	c0d032a4 <longjmp>
c0d01d36:	46c0      	nop			; (mov r8, r8)
c0d01d38:	60005fe1 	.word	0x60005fe1
c0d01d3c:	20001bb8 	.word	0x20001bb8
c0d01d40:	90005f6f 	.word	0x90005f6f

c0d01d44 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01d44:	b580      	push	{r7, lr}
c0d01d46:	af00      	add	r7, sp, #0
c0d01d48:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01d4a:	490a      	ldr	r1, [pc, #40]	; (c0d01d74 <os_ux+0x30>)
c0d01d4c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d4e:	490a      	ldr	r1, [pc, #40]	; (c0d01d78 <os_ux+0x34>)
c0d01d50:	680a      	ldr	r2, [r1, #0]
c0d01d52:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01d54:	9003      	str	r0, [sp, #12]
c0d01d56:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d58:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d5a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d5c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01d5e:	4a07      	ldr	r2, [pc, #28]	; (c0d01d7c <os_ux+0x38>)
c0d01d60:	9b01      	ldr	r3, [sp, #4]
c0d01d62:	4293      	cmp	r3, r2
c0d01d64:	d101      	bne.n	c0d01d6a <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01d66:	b004      	add	sp, #16
c0d01d68:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d6a:	6808      	ldr	r0, [r1, #0]
c0d01d6c:	2104      	movs	r1, #4
c0d01d6e:	f001 fa99 	bl	c0d032a4 <longjmp>
c0d01d72:	46c0      	nop			; (mov r8, r8)
c0d01d74:	60006158 	.word	0x60006158
c0d01d78:	20001bb8 	.word	0x20001bb8
c0d01d7c:	9000611f 	.word	0x9000611f

c0d01d80 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01d80:	b580      	push	{r7, lr}
c0d01d82:	af00      	add	r7, sp, #0
c0d01d84:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01d86:	4809      	ldr	r0, [pc, #36]	; (c0d01dac <os_seph_features+0x2c>)
c0d01d88:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d8a:	4909      	ldr	r1, [pc, #36]	; (c0d01db0 <os_seph_features+0x30>)
c0d01d8c:	6808      	ldr	r0, [r1, #0]
c0d01d8e:	9001      	str	r0, [sp, #4]
c0d01d90:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d92:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d94:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d96:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01d98:	4a06      	ldr	r2, [pc, #24]	; (c0d01db4 <os_seph_features+0x34>)
c0d01d9a:	9b00      	ldr	r3, [sp, #0]
c0d01d9c:	4293      	cmp	r3, r2
c0d01d9e:	d101      	bne.n	c0d01da4 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01da0:	b002      	add	sp, #8
c0d01da2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01da4:	6808      	ldr	r0, [r1, #0]
c0d01da6:	2104      	movs	r1, #4
c0d01da8:	f001 fa7c 	bl	c0d032a4 <longjmp>
c0d01dac:	600064d6 	.word	0x600064d6
c0d01db0:	20001bb8 	.word	0x20001bb8
c0d01db4:	90006444 	.word	0x90006444

c0d01db8 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01db8:	b580      	push	{r7, lr}
c0d01dba:	af00      	add	r7, sp, #0
c0d01dbc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01dbe:	4a0a      	ldr	r2, [pc, #40]	; (c0d01de8 <io_seproxyhal_spi_send+0x30>)
c0d01dc0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01dc2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01dec <io_seproxyhal_spi_send+0x34>)
c0d01dc4:	6813      	ldr	r3, [r2, #0]
c0d01dc6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01dc8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01dca:	9103      	str	r1, [sp, #12]
c0d01dcc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dce:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01dd0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01dd2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01dd4:	4806      	ldr	r0, [pc, #24]	; (c0d01df0 <io_seproxyhal_spi_send+0x38>)
c0d01dd6:	9900      	ldr	r1, [sp, #0]
c0d01dd8:	4281      	cmp	r1, r0
c0d01dda:	d101      	bne.n	c0d01de0 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ddc:	b004      	add	sp, #16
c0d01dde:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01de0:	6810      	ldr	r0, [r2, #0]
c0d01de2:	2104      	movs	r1, #4
c0d01de4:	f001 fa5e 	bl	c0d032a4 <longjmp>
c0d01de8:	60006a1c 	.word	0x60006a1c
c0d01dec:	20001bb8 	.word	0x20001bb8
c0d01df0:	90006af3 	.word	0x90006af3

c0d01df4 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01df4:	b580      	push	{r7, lr}
c0d01df6:	af00      	add	r7, sp, #0
c0d01df8:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01dfa:	4809      	ldr	r0, [pc, #36]	; (c0d01e20 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01dfc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01dfe:	4909      	ldr	r1, [pc, #36]	; (c0d01e24 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01e00:	6808      	ldr	r0, [r1, #0]
c0d01e02:	9001      	str	r0, [sp, #4]
c0d01e04:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e06:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e08:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e0a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01e0c:	4a06      	ldr	r2, [pc, #24]	; (c0d01e28 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01e0e:	9b00      	ldr	r3, [sp, #0]
c0d01e10:	4293      	cmp	r3, r2
c0d01e12:	d101      	bne.n	c0d01e18 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01e14:	b002      	add	sp, #8
c0d01e16:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e18:	6808      	ldr	r0, [r1, #0]
c0d01e1a:	2104      	movs	r1, #4
c0d01e1c:	f001 fa42 	bl	c0d032a4 <longjmp>
c0d01e20:	60006bcf 	.word	0x60006bcf
c0d01e24:	20001bb8 	.word	0x20001bb8
c0d01e28:	90006b7f 	.word	0x90006b7f

c0d01e2c <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01e2c:	b5d0      	push	{r4, r6, r7, lr}
c0d01e2e:	af02      	add	r7, sp, #8
c0d01e30:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01e32:	4b0b      	ldr	r3, [pc, #44]	; (c0d01e60 <io_seproxyhal_spi_recv+0x34>)
c0d01e34:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e36:	4b0b      	ldr	r3, [pc, #44]	; (c0d01e64 <io_seproxyhal_spi_recv+0x38>)
c0d01e38:	681c      	ldr	r4, [r3, #0]
c0d01e3a:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01e3c:	ac03      	add	r4, sp, #12
c0d01e3e:	c407      	stmia	r4!, {r0, r1, r2}
c0d01e40:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e42:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e44:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e46:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01e48:	4907      	ldr	r1, [pc, #28]	; (c0d01e68 <io_seproxyhal_spi_recv+0x3c>)
c0d01e4a:	9a01      	ldr	r2, [sp, #4]
c0d01e4c:	428a      	cmp	r2, r1
c0d01e4e:	d102      	bne.n	c0d01e56 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01e50:	b280      	uxth	r0, r0
c0d01e52:	b006      	add	sp, #24
c0d01e54:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e56:	6818      	ldr	r0, [r3, #0]
c0d01e58:	2104      	movs	r1, #4
c0d01e5a:	f001 fa23 	bl	c0d032a4 <longjmp>
c0d01e5e:	46c0      	nop			; (mov r8, r8)
c0d01e60:	60006cd1 	.word	0x60006cd1
c0d01e64:	20001bb8 	.word	0x20001bb8
c0d01e68:	90006c2b 	.word	0x90006c2b

c0d01e6c <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01e6c:	b5b0      	push	{r4, r5, r7, lr}
c0d01e6e:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01e70:	492c      	ldr	r1, [pc, #176]	; (c0d01f24 <bagl_ui_nanos_screen1_button+0xb8>)
c0d01e72:	4288      	cmp	r0, r1
c0d01e74:	d006      	beq.n	c0d01e84 <bagl_ui_nanos_screen1_button+0x18>
c0d01e76:	492c      	ldr	r1, [pc, #176]	; (c0d01f28 <bagl_ui_nanos_screen1_button+0xbc>)
c0d01e78:	4288      	cmp	r0, r1
c0d01e7a:	d151      	bne.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01e7c:	2000      	movs	r0, #0
c0d01e7e:	f7ff ff43 	bl	c0d01d08 <os_sched_exit>
c0d01e82:	e04d      	b.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01e84:	f7fe fba4 	bl	c0d005d0 <nvram_is_init>
c0d01e88:	2801      	cmp	r0, #1
c0d01e8a:	d102      	bne.n	c0d01e92 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01e8c:	a029      	add	r0, pc, #164	; (adr r0, c0d01f34 <bagl_ui_nanos_screen1_button+0xc8>)
c0d01e8e:	210d      	movs	r1, #13
c0d01e90:	e001      	b.n	c0d01e96 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01e92:	a026      	add	r0, pc, #152	; (adr r0, c0d01f2c <bagl_ui_nanos_screen1_button+0xc0>)
c0d01e94:	2105      	movs	r1, #5
c0d01e96:	2203      	movs	r2, #3
c0d01e98:	f7fe f904 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01e9c:	4c29      	ldr	r4, [pc, #164]	; (c0d01f44 <bagl_ui_nanos_screen1_button+0xd8>)
c0d01e9e:	482b      	ldr	r0, [pc, #172]	; (c0d01f4c <bagl_ui_nanos_screen1_button+0xe0>)
c0d01ea0:	4478      	add	r0, pc
c0d01ea2:	6020      	str	r0, [r4, #0]
c0d01ea4:	2004      	movs	r0, #4
c0d01ea6:	6060      	str	r0, [r4, #4]
c0d01ea8:	4829      	ldr	r0, [pc, #164]	; (c0d01f50 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01eaa:	4478      	add	r0, pc
c0d01eac:	6120      	str	r0, [r4, #16]
c0d01eae:	2500      	movs	r5, #0
c0d01eb0:	60e5      	str	r5, [r4, #12]
c0d01eb2:	2003      	movs	r0, #3
c0d01eb4:	7620      	strb	r0, [r4, #24]
c0d01eb6:	61e5      	str	r5, [r4, #28]
c0d01eb8:	4620      	mov	r0, r4
c0d01eba:	3018      	adds	r0, #24
c0d01ebc:	f7ff ff42 	bl	c0d01d44 <os_ux>
c0d01ec0:	61e0      	str	r0, [r4, #28]
c0d01ec2:	f7ff f903 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d01ec6:	60a5      	str	r5, [r4, #8]
c0d01ec8:	6820      	ldr	r0, [r4, #0]
c0d01eca:	2800      	cmp	r0, #0
c0d01ecc:	d028      	beq.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ece:	69e0      	ldr	r0, [r4, #28]
c0d01ed0:	491d      	ldr	r1, [pc, #116]	; (c0d01f48 <bagl_ui_nanos_screen1_button+0xdc>)
c0d01ed2:	4288      	cmp	r0, r1
c0d01ed4:	d116      	bne.n	c0d01f04 <bagl_ui_nanos_screen1_button+0x98>
c0d01ed6:	e023      	b.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ed8:	6860      	ldr	r0, [r4, #4]
c0d01eda:	4285      	cmp	r5, r0
c0d01edc:	d220      	bcs.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ede:	f7ff ff89 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d01ee2:	2800      	cmp	r0, #0
c0d01ee4:	d11c      	bne.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ee6:	68a0      	ldr	r0, [r4, #8]
c0d01ee8:	68e1      	ldr	r1, [r4, #12]
c0d01eea:	2538      	movs	r5, #56	; 0x38
c0d01eec:	4368      	muls	r0, r5
c0d01eee:	6822      	ldr	r2, [r4, #0]
c0d01ef0:	1810      	adds	r0, r2, r0
c0d01ef2:	2900      	cmp	r1, #0
c0d01ef4:	d009      	beq.n	c0d01f0a <bagl_ui_nanos_screen1_button+0x9e>
c0d01ef6:	4788      	blx	r1
c0d01ef8:	2800      	cmp	r0, #0
c0d01efa:	d106      	bne.n	c0d01f0a <bagl_ui_nanos_screen1_button+0x9e>
c0d01efc:	68a0      	ldr	r0, [r4, #8]
c0d01efe:	1c45      	adds	r5, r0, #1
c0d01f00:	60a5      	str	r5, [r4, #8]
c0d01f02:	6820      	ldr	r0, [r4, #0]
c0d01f04:	2800      	cmp	r0, #0
c0d01f06:	d1e7      	bne.n	c0d01ed8 <bagl_ui_nanos_screen1_button+0x6c>
c0d01f08:	e00a      	b.n	c0d01f20 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f0a:	2801      	cmp	r0, #1
c0d01f0c:	d103      	bne.n	c0d01f16 <bagl_ui_nanos_screen1_button+0xaa>
c0d01f0e:	68a0      	ldr	r0, [r4, #8]
c0d01f10:	4345      	muls	r5, r0
c0d01f12:	6820      	ldr	r0, [r4, #0]
c0d01f14:	1940      	adds	r0, r0, r5
c0d01f16:	f7fe fb91 	bl	c0d0063c <io_seproxyhal_display>
c0d01f1a:	68a0      	ldr	r0, [r4, #8]
c0d01f1c:	1c40      	adds	r0, r0, #1
c0d01f1e:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01f20:	2000      	movs	r0, #0
c0d01f22:	bdb0      	pop	{r4, r5, r7, pc}
c0d01f24:	80000002 	.word	0x80000002
c0d01f28:	80000001 	.word	0x80000001
c0d01f2c:	54494e49 	.word	0x54494e49
c0d01f30:	00000000 	.word	0x00000000
c0d01f34:	6c697453 	.word	0x6c697453
c0d01f38:	6e75206c 	.word	0x6e75206c
c0d01f3c:	74696e69 	.word	0x74696e69
c0d01f40:	00000000 	.word	0x00000000
c0d01f44:	20001a98 	.word	0x20001a98
c0d01f48:	b0105044 	.word	0xb0105044
c0d01f4c:	0000163c 	.word	0x0000163c
c0d01f50:	00000153 	.word	0x00000153

c0d01f54 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01f54:	b5b0      	push	{r4, r5, r7, lr}
c0d01f56:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01f58:	2800      	cmp	r0, #0
c0d01f5a:	d005      	beq.n	c0d01f68 <ui_display_debug+0x14>
c0d01f5c:	2900      	cmp	r1, #0
c0d01f5e:	d003      	beq.n	c0d01f68 <ui_display_debug+0x14>
c0d01f60:	2a00      	cmp	r2, #0
c0d01f62:	d001      	beq.n	c0d01f68 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01f64:	f7fe f89e 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01f68:	4c21      	ldr	r4, [pc, #132]	; (c0d01ff0 <ui_display_debug+0x9c>)
c0d01f6a:	4823      	ldr	r0, [pc, #140]	; (c0d01ff8 <ui_display_debug+0xa4>)
c0d01f6c:	4478      	add	r0, pc
c0d01f6e:	6020      	str	r0, [r4, #0]
c0d01f70:	2004      	movs	r0, #4
c0d01f72:	6060      	str	r0, [r4, #4]
c0d01f74:	4821      	ldr	r0, [pc, #132]	; (c0d01ffc <ui_display_debug+0xa8>)
c0d01f76:	4478      	add	r0, pc
c0d01f78:	6120      	str	r0, [r4, #16]
c0d01f7a:	2500      	movs	r5, #0
c0d01f7c:	60e5      	str	r5, [r4, #12]
c0d01f7e:	2003      	movs	r0, #3
c0d01f80:	7620      	strb	r0, [r4, #24]
c0d01f82:	61e5      	str	r5, [r4, #28]
c0d01f84:	4620      	mov	r0, r4
c0d01f86:	3018      	adds	r0, #24
c0d01f88:	f7ff fedc 	bl	c0d01d44 <os_ux>
c0d01f8c:	61e0      	str	r0, [r4, #28]
c0d01f8e:	f7ff f89d 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d01f92:	60a5      	str	r5, [r4, #8]
c0d01f94:	6820      	ldr	r0, [r4, #0]
c0d01f96:	2800      	cmp	r0, #0
c0d01f98:	d028      	beq.n	c0d01fec <ui_display_debug+0x98>
c0d01f9a:	69e0      	ldr	r0, [r4, #28]
c0d01f9c:	4915      	ldr	r1, [pc, #84]	; (c0d01ff4 <ui_display_debug+0xa0>)
c0d01f9e:	4288      	cmp	r0, r1
c0d01fa0:	d116      	bne.n	c0d01fd0 <ui_display_debug+0x7c>
c0d01fa2:	e023      	b.n	c0d01fec <ui_display_debug+0x98>
c0d01fa4:	6860      	ldr	r0, [r4, #4]
c0d01fa6:	4285      	cmp	r5, r0
c0d01fa8:	d220      	bcs.n	c0d01fec <ui_display_debug+0x98>
c0d01faa:	f7ff ff23 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d01fae:	2800      	cmp	r0, #0
c0d01fb0:	d11c      	bne.n	c0d01fec <ui_display_debug+0x98>
c0d01fb2:	68a0      	ldr	r0, [r4, #8]
c0d01fb4:	68e1      	ldr	r1, [r4, #12]
c0d01fb6:	2538      	movs	r5, #56	; 0x38
c0d01fb8:	4368      	muls	r0, r5
c0d01fba:	6822      	ldr	r2, [r4, #0]
c0d01fbc:	1810      	adds	r0, r2, r0
c0d01fbe:	2900      	cmp	r1, #0
c0d01fc0:	d009      	beq.n	c0d01fd6 <ui_display_debug+0x82>
c0d01fc2:	4788      	blx	r1
c0d01fc4:	2800      	cmp	r0, #0
c0d01fc6:	d106      	bne.n	c0d01fd6 <ui_display_debug+0x82>
c0d01fc8:	68a0      	ldr	r0, [r4, #8]
c0d01fca:	1c45      	adds	r5, r0, #1
c0d01fcc:	60a5      	str	r5, [r4, #8]
c0d01fce:	6820      	ldr	r0, [r4, #0]
c0d01fd0:	2800      	cmp	r0, #0
c0d01fd2:	d1e7      	bne.n	c0d01fa4 <ui_display_debug+0x50>
c0d01fd4:	e00a      	b.n	c0d01fec <ui_display_debug+0x98>
c0d01fd6:	2801      	cmp	r0, #1
c0d01fd8:	d103      	bne.n	c0d01fe2 <ui_display_debug+0x8e>
c0d01fda:	68a0      	ldr	r0, [r4, #8]
c0d01fdc:	4345      	muls	r5, r0
c0d01fde:	6820      	ldr	r0, [r4, #0]
c0d01fe0:	1940      	adds	r0, r0, r5
c0d01fe2:	f7fe fb2b 	bl	c0d0063c <io_seproxyhal_display>
c0d01fe6:	68a0      	ldr	r0, [r4, #8]
c0d01fe8:	1c40      	adds	r0, r0, #1
c0d01fea:	60a0      	str	r0, [r4, #8]
}
c0d01fec:	bdb0      	pop	{r4, r5, r7, pc}
c0d01fee:	46c0      	nop			; (mov r8, r8)
c0d01ff0:	20001a98 	.word	0x20001a98
c0d01ff4:	b0105044 	.word	0xb0105044
c0d01ff8:	00001570 	.word	0x00001570
c0d01ffc:	00000087 	.word	0x00000087

c0d02000 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02000:	b580      	push	{r7, lr}
c0d02002:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d02004:	4905      	ldr	r1, [pc, #20]	; (c0d0201c <bagl_ui_nanos_screen2_button+0x1c>)
c0d02006:	4288      	cmp	r0, r1
c0d02008:	d002      	beq.n	c0d02010 <bagl_ui_nanos_screen2_button+0x10>
c0d0200a:	4905      	ldr	r1, [pc, #20]	; (c0d02020 <bagl_ui_nanos_screen2_button+0x20>)
c0d0200c:	4288      	cmp	r0, r1
c0d0200e:	d102      	bne.n	c0d02016 <bagl_ui_nanos_screen2_button+0x16>
c0d02010:	2000      	movs	r0, #0
c0d02012:	f7ff fe79 	bl	c0d01d08 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d02016:	2000      	movs	r0, #0
c0d02018:	bd80      	pop	{r7, pc}
c0d0201a:	46c0      	nop			; (mov r8, r8)
c0d0201c:	80000002 	.word	0x80000002
c0d02020:	80000001 	.word	0x80000001

c0d02024 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d02024:	b5b0      	push	{r4, r5, r7, lr}
c0d02026:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02028:	2001      	movs	r0, #1
c0d0202a:	0204      	lsls	r4, r0, #8
c0d0202c:	f7ff fea8 	bl	c0d01d80 <os_seph_features>
c0d02030:	4220      	tst	r0, r4
c0d02032:	d136      	bne.n	c0d020a2 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02034:	4c3c      	ldr	r4, [pc, #240]	; (c0d02128 <ui_idle+0x104>)
c0d02036:	4840      	ldr	r0, [pc, #256]	; (c0d02138 <ui_idle+0x114>)
c0d02038:	4478      	add	r0, pc
c0d0203a:	6020      	str	r0, [r4, #0]
c0d0203c:	2004      	movs	r0, #4
c0d0203e:	6060      	str	r0, [r4, #4]
c0d02040:	483e      	ldr	r0, [pc, #248]	; (c0d0213c <ui_idle+0x118>)
c0d02042:	4478      	add	r0, pc
c0d02044:	6120      	str	r0, [r4, #16]
c0d02046:	2500      	movs	r5, #0
c0d02048:	60e5      	str	r5, [r4, #12]
c0d0204a:	2003      	movs	r0, #3
c0d0204c:	7620      	strb	r0, [r4, #24]
c0d0204e:	61e5      	str	r5, [r4, #28]
c0d02050:	4620      	mov	r0, r4
c0d02052:	3018      	adds	r0, #24
c0d02054:	f7ff fe76 	bl	c0d01d44 <os_ux>
c0d02058:	61e0      	str	r0, [r4, #28]
c0d0205a:	f7ff f837 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d0205e:	60a5      	str	r5, [r4, #8]
c0d02060:	6820      	ldr	r0, [r4, #0]
c0d02062:	2800      	cmp	r0, #0
c0d02064:	d05f      	beq.n	c0d02126 <ui_idle+0x102>
c0d02066:	69e0      	ldr	r0, [r4, #28]
c0d02068:	4930      	ldr	r1, [pc, #192]	; (c0d0212c <ui_idle+0x108>)
c0d0206a:	4288      	cmp	r0, r1
c0d0206c:	d116      	bne.n	c0d0209c <ui_idle+0x78>
c0d0206e:	e05a      	b.n	c0d02126 <ui_idle+0x102>
c0d02070:	6860      	ldr	r0, [r4, #4]
c0d02072:	4285      	cmp	r5, r0
c0d02074:	d257      	bcs.n	c0d02126 <ui_idle+0x102>
c0d02076:	f7ff febd 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d0207a:	2800      	cmp	r0, #0
c0d0207c:	d153      	bne.n	c0d02126 <ui_idle+0x102>
c0d0207e:	68a0      	ldr	r0, [r4, #8]
c0d02080:	68e1      	ldr	r1, [r4, #12]
c0d02082:	2538      	movs	r5, #56	; 0x38
c0d02084:	4368      	muls	r0, r5
c0d02086:	6822      	ldr	r2, [r4, #0]
c0d02088:	1810      	adds	r0, r2, r0
c0d0208a:	2900      	cmp	r1, #0
c0d0208c:	d040      	beq.n	c0d02110 <ui_idle+0xec>
c0d0208e:	4788      	blx	r1
c0d02090:	2800      	cmp	r0, #0
c0d02092:	d13d      	bne.n	c0d02110 <ui_idle+0xec>
c0d02094:	68a0      	ldr	r0, [r4, #8]
c0d02096:	1c45      	adds	r5, r0, #1
c0d02098:	60a5      	str	r5, [r4, #8]
c0d0209a:	6820      	ldr	r0, [r4, #0]
c0d0209c:	2800      	cmp	r0, #0
c0d0209e:	d1e7      	bne.n	c0d02070 <ui_idle+0x4c>
c0d020a0:	e041      	b.n	c0d02126 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d020a2:	4c21      	ldr	r4, [pc, #132]	; (c0d02128 <ui_idle+0x104>)
c0d020a4:	4822      	ldr	r0, [pc, #136]	; (c0d02130 <ui_idle+0x10c>)
c0d020a6:	4478      	add	r0, pc
c0d020a8:	6020      	str	r0, [r4, #0]
c0d020aa:	2004      	movs	r0, #4
c0d020ac:	6060      	str	r0, [r4, #4]
c0d020ae:	4821      	ldr	r0, [pc, #132]	; (c0d02134 <ui_idle+0x110>)
c0d020b0:	4478      	add	r0, pc
c0d020b2:	6120      	str	r0, [r4, #16]
c0d020b4:	2500      	movs	r5, #0
c0d020b6:	60e5      	str	r5, [r4, #12]
c0d020b8:	2003      	movs	r0, #3
c0d020ba:	7620      	strb	r0, [r4, #24]
c0d020bc:	61e5      	str	r5, [r4, #28]
c0d020be:	4620      	mov	r0, r4
c0d020c0:	3018      	adds	r0, #24
c0d020c2:	f7ff fe3f 	bl	c0d01d44 <os_ux>
c0d020c6:	61e0      	str	r0, [r4, #28]
c0d020c8:	f7ff f800 	bl	c0d010cc <io_seproxyhal_init_ux>
c0d020cc:	60a5      	str	r5, [r4, #8]
c0d020ce:	6820      	ldr	r0, [r4, #0]
c0d020d0:	2800      	cmp	r0, #0
c0d020d2:	d028      	beq.n	c0d02126 <ui_idle+0x102>
c0d020d4:	69e0      	ldr	r0, [r4, #28]
c0d020d6:	4915      	ldr	r1, [pc, #84]	; (c0d0212c <ui_idle+0x108>)
c0d020d8:	4288      	cmp	r0, r1
c0d020da:	d116      	bne.n	c0d0210a <ui_idle+0xe6>
c0d020dc:	e023      	b.n	c0d02126 <ui_idle+0x102>
c0d020de:	6860      	ldr	r0, [r4, #4]
c0d020e0:	4285      	cmp	r5, r0
c0d020e2:	d220      	bcs.n	c0d02126 <ui_idle+0x102>
c0d020e4:	f7ff fe86 	bl	c0d01df4 <io_seproxyhal_spi_is_status_sent>
c0d020e8:	2800      	cmp	r0, #0
c0d020ea:	d11c      	bne.n	c0d02126 <ui_idle+0x102>
c0d020ec:	68a0      	ldr	r0, [r4, #8]
c0d020ee:	68e1      	ldr	r1, [r4, #12]
c0d020f0:	2538      	movs	r5, #56	; 0x38
c0d020f2:	4368      	muls	r0, r5
c0d020f4:	6822      	ldr	r2, [r4, #0]
c0d020f6:	1810      	adds	r0, r2, r0
c0d020f8:	2900      	cmp	r1, #0
c0d020fa:	d009      	beq.n	c0d02110 <ui_idle+0xec>
c0d020fc:	4788      	blx	r1
c0d020fe:	2800      	cmp	r0, #0
c0d02100:	d106      	bne.n	c0d02110 <ui_idle+0xec>
c0d02102:	68a0      	ldr	r0, [r4, #8]
c0d02104:	1c45      	adds	r5, r0, #1
c0d02106:	60a5      	str	r5, [r4, #8]
c0d02108:	6820      	ldr	r0, [r4, #0]
c0d0210a:	2800      	cmp	r0, #0
c0d0210c:	d1e7      	bne.n	c0d020de <ui_idle+0xba>
c0d0210e:	e00a      	b.n	c0d02126 <ui_idle+0x102>
c0d02110:	2801      	cmp	r0, #1
c0d02112:	d103      	bne.n	c0d0211c <ui_idle+0xf8>
c0d02114:	68a0      	ldr	r0, [r4, #8]
c0d02116:	4345      	muls	r5, r0
c0d02118:	6820      	ldr	r0, [r4, #0]
c0d0211a:	1940      	adds	r0, r0, r5
c0d0211c:	f7fe fa8e 	bl	c0d0063c <io_seproxyhal_display>
c0d02120:	68a0      	ldr	r0, [r4, #8]
c0d02122:	1c40      	adds	r0, r0, #1
c0d02124:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d02126:	bdb0      	pop	{r4, r5, r7, pc}
c0d02128:	20001a98 	.word	0x20001a98
c0d0212c:	b0105044 	.word	0xb0105044
c0d02130:	00001516 	.word	0x00001516
c0d02134:	0000008d 	.word	0x0000008d
c0d02138:	000013c4 	.word	0x000013c4
c0d0213c:	fffffe27 	.word	0xfffffe27

c0d02140 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02140:	2000      	movs	r0, #0
c0d02142:	4770      	bx	lr

c0d02144 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02144:	b5d0      	push	{r4, r6, r7, lr}
c0d02146:	af02      	add	r7, sp, #8
c0d02148:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0214a:	4620      	mov	r0, r4
c0d0214c:	f7ff fddc 	bl	c0d01d08 <os_sched_exit>
    return NULL;
c0d02150:	4620      	mov	r0, r4
c0d02152:	bdd0      	pop	{r4, r6, r7, pc}

c0d02154 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02154:	4902      	ldr	r1, [pc, #8]	; (c0d02160 <USBD_LL_Init+0xc>)
c0d02156:	2000      	movs	r0, #0
c0d02158:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0215a:	4902      	ldr	r1, [pc, #8]	; (c0d02164 <USBD_LL_Init+0x10>)
c0d0215c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0215e:	4770      	bx	lr
c0d02160:	20001d2c 	.word	0x20001d2c
c0d02164:	20001d30 	.word	0x20001d30

c0d02168 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02168:	b5d0      	push	{r4, r6, r7, lr}
c0d0216a:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0216c:	4806      	ldr	r0, [pc, #24]	; (c0d02188 <USBD_LL_DeInit+0x20>)
c0d0216e:	214f      	movs	r1, #79	; 0x4f
c0d02170:	7001      	strb	r1, [r0, #0]
c0d02172:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02174:	7044      	strb	r4, [r0, #1]
c0d02176:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02178:	7081      	strb	r1, [r0, #2]
c0d0217a:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0217c:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0217e:	2104      	movs	r1, #4
c0d02180:	f7ff fe1a 	bl	c0d01db8 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02184:	4620      	mov	r0, r4
c0d02186:	bdd0      	pop	{r4, r6, r7, pc}
c0d02188:	20001a18 	.word	0x20001a18

c0d0218c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0218c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0218e:	af03      	add	r7, sp, #12
c0d02190:	b083      	sub	sp, #12
c0d02192:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02194:	264f      	movs	r6, #79	; 0x4f
c0d02196:	702e      	strb	r6, [r5, #0]
c0d02198:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0219a:	706c      	strb	r4, [r5, #1]
c0d0219c:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0219e:	70a8      	strb	r0, [r5, #2]
c0d021a0:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d021a2:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d021a4:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d021a6:	2105      	movs	r1, #5
c0d021a8:	4628      	mov	r0, r5
c0d021aa:	f7ff fe05 	bl	c0d01db8 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021ae:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d021b0:	706c      	strb	r4, [r5, #1]
c0d021b2:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d021b4:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d021b6:	70e8      	strb	r0, [r5, #3]
c0d021b8:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d021ba:	4628      	mov	r0, r5
c0d021bc:	f7ff fdfc 	bl	c0d01db8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d021c0:	4620      	mov	r0, r4
c0d021c2:	b003      	add	sp, #12
c0d021c4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d021c6 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d021c6:	b5d0      	push	{r4, r6, r7, lr}
c0d021c8:	af02      	add	r7, sp, #8
c0d021ca:	b082      	sub	sp, #8
c0d021cc:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021ce:	214f      	movs	r1, #79	; 0x4f
c0d021d0:	7001      	strb	r1, [r0, #0]
c0d021d2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d021d4:	7044      	strb	r4, [r0, #1]
c0d021d6:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d021d8:	7081      	strb	r1, [r0, #2]
c0d021da:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d021dc:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d021de:	2104      	movs	r1, #4
c0d021e0:	f7ff fdea 	bl	c0d01db8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d021e4:	4620      	mov	r0, r4
c0d021e6:	b002      	add	sp, #8
c0d021e8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d021ec <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d021ec:	b5b0      	push	{r4, r5, r7, lr}
c0d021ee:	af02      	add	r7, sp, #8
c0d021f0:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d021f2:	480f      	ldr	r0, [pc, #60]	; (c0d02230 <USBD_LL_OpenEP+0x44>)
c0d021f4:	2400      	movs	r4, #0
c0d021f6:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d021f8:	480e      	ldr	r0, [pc, #56]	; (c0d02234 <USBD_LL_OpenEP+0x48>)
c0d021fa:	6004      	str	r4, [r0, #0]
c0d021fc:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021fe:	254f      	movs	r5, #79	; 0x4f
c0d02200:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d02202:	7044      	strb	r4, [r0, #1]
c0d02204:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d02206:	7085      	strb	r5, [r0, #2]
c0d02208:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0220a:	70c5      	strb	r5, [r0, #3]
c0d0220c:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d0220e:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02210:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d02212:	2a03      	cmp	r2, #3
c0d02214:	d802      	bhi.n	c0d0221c <USBD_LL_OpenEP+0x30>
c0d02216:	00d0      	lsls	r0, r2, #3
c0d02218:	4c07      	ldr	r4, [pc, #28]	; (c0d02238 <USBD_LL_OpenEP+0x4c>)
c0d0221a:	40c4      	lsrs	r4, r0
c0d0221c:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d0221e:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02220:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02222:	2108      	movs	r1, #8
c0d02224:	f7ff fdc8 	bl	c0d01db8 <io_seproxyhal_spi_send>
c0d02228:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0222a:	b002      	add	sp, #8
c0d0222c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0222e:	46c0      	nop			; (mov r8, r8)
c0d02230:	20001d2c 	.word	0x20001d2c
c0d02234:	20001d30 	.word	0x20001d30
c0d02238:	02030401 	.word	0x02030401

c0d0223c <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0223c:	b5d0      	push	{r4, r6, r7, lr}
c0d0223e:	af02      	add	r7, sp, #8
c0d02240:	b082      	sub	sp, #8
c0d02242:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02244:	224f      	movs	r2, #79	; 0x4f
c0d02246:	7002      	strb	r2, [r0, #0]
c0d02248:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0224a:	7044      	strb	r4, [r0, #1]
c0d0224c:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0224e:	7082      	strb	r2, [r0, #2]
c0d02250:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02252:	70c2      	strb	r2, [r0, #3]
c0d02254:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02256:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02258:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d0225a:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d0225c:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0225e:	2108      	movs	r1, #8
c0d02260:	f7ff fdaa 	bl	c0d01db8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02264:	4620      	mov	r0, r4
c0d02266:	b002      	add	sp, #8
c0d02268:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0226c <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d0226c:	b5b0      	push	{r4, r5, r7, lr}
c0d0226e:	af02      	add	r7, sp, #8
c0d02270:	b082      	sub	sp, #8
c0d02272:	460d      	mov	r5, r1
c0d02274:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02276:	2150      	movs	r1, #80	; 0x50
c0d02278:	7001      	strb	r1, [r0, #0]
c0d0227a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0227c:	7044      	strb	r4, [r0, #1]
c0d0227e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02280:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02282:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02284:	2140      	movs	r1, #64	; 0x40
c0d02286:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02288:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0228a:	2106      	movs	r1, #6
c0d0228c:	f7ff fd94 	bl	c0d01db8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02290:	2080      	movs	r0, #128	; 0x80
c0d02292:	4205      	tst	r5, r0
c0d02294:	d101      	bne.n	c0d0229a <USBD_LL_StallEP+0x2e>
c0d02296:	4807      	ldr	r0, [pc, #28]	; (c0d022b4 <USBD_LL_StallEP+0x48>)
c0d02298:	e000      	b.n	c0d0229c <USBD_LL_StallEP+0x30>
c0d0229a:	4805      	ldr	r0, [pc, #20]	; (c0d022b0 <USBD_LL_StallEP+0x44>)
c0d0229c:	6801      	ldr	r1, [r0, #0]
c0d0229e:	227f      	movs	r2, #127	; 0x7f
c0d022a0:	4015      	ands	r5, r2
c0d022a2:	2201      	movs	r2, #1
c0d022a4:	40aa      	lsls	r2, r5
c0d022a6:	430a      	orrs	r2, r1
c0d022a8:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d022aa:	4620      	mov	r0, r4
c0d022ac:	b002      	add	sp, #8
c0d022ae:	bdb0      	pop	{r4, r5, r7, pc}
c0d022b0:	20001d2c 	.word	0x20001d2c
c0d022b4:	20001d30 	.word	0x20001d30

c0d022b8 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d022b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d022ba:	af03      	add	r7, sp, #12
c0d022bc:	b083      	sub	sp, #12
c0d022be:	460d      	mov	r5, r1
c0d022c0:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d022c2:	2150      	movs	r1, #80	; 0x50
c0d022c4:	7001      	strb	r1, [r0, #0]
c0d022c6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022c8:	7044      	strb	r4, [r0, #1]
c0d022ca:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d022cc:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d022ce:	70c5      	strb	r5, [r0, #3]
c0d022d0:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d022d2:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d022d4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d022d6:	2106      	movs	r1, #6
c0d022d8:	f7ff fd6e 	bl	c0d01db8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d022dc:	4235      	tst	r5, r6
c0d022de:	d101      	bne.n	c0d022e4 <USBD_LL_ClearStallEP+0x2c>
c0d022e0:	4807      	ldr	r0, [pc, #28]	; (c0d02300 <USBD_LL_ClearStallEP+0x48>)
c0d022e2:	e000      	b.n	c0d022e6 <USBD_LL_ClearStallEP+0x2e>
c0d022e4:	4805      	ldr	r0, [pc, #20]	; (c0d022fc <USBD_LL_ClearStallEP+0x44>)
c0d022e6:	6801      	ldr	r1, [r0, #0]
c0d022e8:	227f      	movs	r2, #127	; 0x7f
c0d022ea:	4015      	ands	r5, r2
c0d022ec:	2201      	movs	r2, #1
c0d022ee:	40aa      	lsls	r2, r5
c0d022f0:	4391      	bics	r1, r2
c0d022f2:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d022f4:	4620      	mov	r0, r4
c0d022f6:	b003      	add	sp, #12
c0d022f8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d022fa:	46c0      	nop			; (mov r8, r8)
c0d022fc:	20001d2c 	.word	0x20001d2c
c0d02300:	20001d30 	.word	0x20001d30

c0d02304 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02304:	2080      	movs	r0, #128	; 0x80
c0d02306:	4201      	tst	r1, r0
c0d02308:	d001      	beq.n	c0d0230e <USBD_LL_IsStallEP+0xa>
c0d0230a:	4806      	ldr	r0, [pc, #24]	; (c0d02324 <USBD_LL_IsStallEP+0x20>)
c0d0230c:	e000      	b.n	c0d02310 <USBD_LL_IsStallEP+0xc>
c0d0230e:	4804      	ldr	r0, [pc, #16]	; (c0d02320 <USBD_LL_IsStallEP+0x1c>)
c0d02310:	6800      	ldr	r0, [r0, #0]
c0d02312:	227f      	movs	r2, #127	; 0x7f
c0d02314:	4011      	ands	r1, r2
c0d02316:	2201      	movs	r2, #1
c0d02318:	408a      	lsls	r2, r1
c0d0231a:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d0231c:	b2d0      	uxtb	r0, r2
c0d0231e:	4770      	bx	lr
c0d02320:	20001d30 	.word	0x20001d30
c0d02324:	20001d2c 	.word	0x20001d2c

c0d02328 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02328:	b5d0      	push	{r4, r6, r7, lr}
c0d0232a:	af02      	add	r7, sp, #8
c0d0232c:	b082      	sub	sp, #8
c0d0232e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02330:	224f      	movs	r2, #79	; 0x4f
c0d02332:	7002      	strb	r2, [r0, #0]
c0d02334:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02336:	7044      	strb	r4, [r0, #1]
c0d02338:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0233a:	7082      	strb	r2, [r0, #2]
c0d0233c:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0233e:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02340:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02342:	2105      	movs	r1, #5
c0d02344:	f7ff fd38 	bl	c0d01db8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02348:	4620      	mov	r0, r4
c0d0234a:	b002      	add	sp, #8
c0d0234c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0234e <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d0234e:	b5b0      	push	{r4, r5, r7, lr}
c0d02350:	af02      	add	r7, sp, #8
c0d02352:	b082      	sub	sp, #8
c0d02354:	461c      	mov	r4, r3
c0d02356:	4615      	mov	r5, r2
c0d02358:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0235a:	2250      	movs	r2, #80	; 0x50
c0d0235c:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0235e:	1ce2      	adds	r2, r4, #3
c0d02360:	0a13      	lsrs	r3, r2, #8
c0d02362:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02364:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02366:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02368:	2120      	movs	r1, #32
c0d0236a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d0236c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0236e:	2106      	movs	r1, #6
c0d02370:	f7ff fd22 	bl	c0d01db8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02374:	4628      	mov	r0, r5
c0d02376:	4621      	mov	r1, r4
c0d02378:	f7ff fd1e 	bl	c0d01db8 <io_seproxyhal_spi_send>
c0d0237c:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0237e:	b002      	add	sp, #8
c0d02380:	bdb0      	pop	{r4, r5, r7, pc}

c0d02382 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02382:	b5d0      	push	{r4, r6, r7, lr}
c0d02384:	af02      	add	r7, sp, #8
c0d02386:	b082      	sub	sp, #8
c0d02388:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0238a:	2350      	movs	r3, #80	; 0x50
c0d0238c:	7003      	strb	r3, [r0, #0]
c0d0238e:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02390:	7044      	strb	r4, [r0, #1]
c0d02392:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02394:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02396:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02398:	2130      	movs	r1, #48	; 0x30
c0d0239a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d0239c:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0239e:	2106      	movs	r1, #6
c0d023a0:	f7ff fd0a 	bl	c0d01db8 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d023a4:	4620      	mov	r0, r4
c0d023a6:	b002      	add	sp, #8
c0d023a8:	bdd0      	pop	{r4, r6, r7, pc}

c0d023aa <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d023aa:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d023ac:	af03      	add	r7, sp, #12
c0d023ae:	b081      	sub	sp, #4
c0d023b0:	4615      	mov	r5, r2
c0d023b2:	460e      	mov	r6, r1
c0d023b4:	4604      	mov	r4, r0
c0d023b6:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d023b8:	2c00      	cmp	r4, #0
c0d023ba:	d011      	beq.n	c0d023e0 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d023bc:	2049      	movs	r0, #73	; 0x49
c0d023be:	0081      	lsls	r1, r0, #2
c0d023c0:	4620      	mov	r0, r4
c0d023c2:	f000 fecd 	bl	c0d03160 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d023c6:	2e00      	cmp	r6, #0
c0d023c8:	d002      	beq.n	c0d023d0 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d023ca:	2011      	movs	r0, #17
c0d023cc:	0100      	lsls	r0, r0, #4
c0d023ce:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d023d0:	20fc      	movs	r0, #252	; 0xfc
c0d023d2:	2101      	movs	r1, #1
c0d023d4:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d023d6:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d023d8:	4620      	mov	r0, r4
c0d023da:	f7ff febb 	bl	c0d02154 <USBD_LL_Init>
c0d023de:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d023e0:	b2c0      	uxtb	r0, r0
c0d023e2:	b001      	add	sp, #4
c0d023e4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d023e6 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d023e6:	b5d0      	push	{r4, r6, r7, lr}
c0d023e8:	af02      	add	r7, sp, #8
c0d023ea:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d023ec:	20fc      	movs	r0, #252	; 0xfc
c0d023ee:	2101      	movs	r1, #1
c0d023f0:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d023f2:	2045      	movs	r0, #69	; 0x45
c0d023f4:	0080      	lsls	r0, r0, #2
c0d023f6:	5820      	ldr	r0, [r4, r0]
c0d023f8:	2800      	cmp	r0, #0
c0d023fa:	d006      	beq.n	c0d0240a <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d023fc:	6840      	ldr	r0, [r0, #4]
c0d023fe:	f7ff fb1f 	bl	c0d01a40 <pic>
c0d02402:	4602      	mov	r2, r0
c0d02404:	7921      	ldrb	r1, [r4, #4]
c0d02406:	4620      	mov	r0, r4
c0d02408:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0240a:	4620      	mov	r0, r4
c0d0240c:	f7ff fedb 	bl	c0d021c6 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02410:	4620      	mov	r0, r4
c0d02412:	f7ff fea9 	bl	c0d02168 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02416:	2000      	movs	r0, #0
c0d02418:	bdd0      	pop	{r4, r6, r7, pc}

c0d0241a <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0241a:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d0241c:	2900      	cmp	r1, #0
c0d0241e:	d003      	beq.n	c0d02428 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02420:	2245      	movs	r2, #69	; 0x45
c0d02422:	0092      	lsls	r2, r2, #2
c0d02424:	5081      	str	r1, [r0, r2]
c0d02426:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02428:	b2d0      	uxtb	r0, r2
c0d0242a:	4770      	bx	lr

c0d0242c <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d0242c:	b580      	push	{r7, lr}
c0d0242e:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02430:	f7ff feac 	bl	c0d0218c <USBD_LL_Start>
  
  return USBD_OK;  
c0d02434:	2000      	movs	r0, #0
c0d02436:	bd80      	pop	{r7, pc}

c0d02438 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02438:	b5b0      	push	{r4, r5, r7, lr}
c0d0243a:	af02      	add	r7, sp, #8
c0d0243c:	460c      	mov	r4, r1
c0d0243e:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02440:	2045      	movs	r0, #69	; 0x45
c0d02442:	0080      	lsls	r0, r0, #2
c0d02444:	5828      	ldr	r0, [r5, r0]
c0d02446:	2800      	cmp	r0, #0
c0d02448:	d00c      	beq.n	c0d02464 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d0244a:	6800      	ldr	r0, [r0, #0]
c0d0244c:	f7ff faf8 	bl	c0d01a40 <pic>
c0d02450:	4602      	mov	r2, r0
c0d02452:	4628      	mov	r0, r5
c0d02454:	4621      	mov	r1, r4
c0d02456:	4790      	blx	r2
c0d02458:	4601      	mov	r1, r0
c0d0245a:	2002      	movs	r0, #2
c0d0245c:	2900      	cmp	r1, #0
c0d0245e:	d100      	bne.n	c0d02462 <USBD_SetClassConfig+0x2a>
c0d02460:	4608      	mov	r0, r1
c0d02462:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02464:	2002      	movs	r0, #2
c0d02466:	bdb0      	pop	{r4, r5, r7, pc}

c0d02468 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02468:	b5b0      	push	{r4, r5, r7, lr}
c0d0246a:	af02      	add	r7, sp, #8
c0d0246c:	460c      	mov	r4, r1
c0d0246e:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02470:	2045      	movs	r0, #69	; 0x45
c0d02472:	0080      	lsls	r0, r0, #2
c0d02474:	5828      	ldr	r0, [r5, r0]
c0d02476:	2800      	cmp	r0, #0
c0d02478:	d006      	beq.n	c0d02488 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0247a:	6840      	ldr	r0, [r0, #4]
c0d0247c:	f7ff fae0 	bl	c0d01a40 <pic>
c0d02480:	4602      	mov	r2, r0
c0d02482:	4628      	mov	r0, r5
c0d02484:	4621      	mov	r1, r4
c0d02486:	4790      	blx	r2
  }
  return USBD_OK;
c0d02488:	2000      	movs	r0, #0
c0d0248a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0248c <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d0248c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0248e:	af03      	add	r7, sp, #12
c0d02490:	b081      	sub	sp, #4
c0d02492:	4604      	mov	r4, r0
c0d02494:	2021      	movs	r0, #33	; 0x21
c0d02496:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02498:	19a5      	adds	r5, r4, r6
c0d0249a:	4628      	mov	r0, r5
c0d0249c:	f000 fb69 	bl	c0d02b72 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d024a0:	20f4      	movs	r0, #244	; 0xf4
c0d024a2:	2101      	movs	r1, #1
c0d024a4:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d024a6:	2087      	movs	r0, #135	; 0x87
c0d024a8:	0040      	lsls	r0, r0, #1
c0d024aa:	5a20      	ldrh	r0, [r4, r0]
c0d024ac:	21f8      	movs	r1, #248	; 0xf8
c0d024ae:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d024b0:	5da1      	ldrb	r1, [r4, r6]
c0d024b2:	201f      	movs	r0, #31
c0d024b4:	4008      	ands	r0, r1
c0d024b6:	2802      	cmp	r0, #2
c0d024b8:	d008      	beq.n	c0d024cc <USBD_LL_SetupStage+0x40>
c0d024ba:	2801      	cmp	r0, #1
c0d024bc:	d00b      	beq.n	c0d024d6 <USBD_LL_SetupStage+0x4a>
c0d024be:	2800      	cmp	r0, #0
c0d024c0:	d10e      	bne.n	c0d024e0 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d024c2:	4620      	mov	r0, r4
c0d024c4:	4629      	mov	r1, r5
c0d024c6:	f000 f8f1 	bl	c0d026ac <USBD_StdDevReq>
c0d024ca:	e00e      	b.n	c0d024ea <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d024cc:	4620      	mov	r0, r4
c0d024ce:	4629      	mov	r1, r5
c0d024d0:	f000 fad3 	bl	c0d02a7a <USBD_StdEPReq>
c0d024d4:	e009      	b.n	c0d024ea <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d024d6:	4620      	mov	r0, r4
c0d024d8:	4629      	mov	r1, r5
c0d024da:	f000 faa6 	bl	c0d02a2a <USBD_StdItfReq>
c0d024de:	e004      	b.n	c0d024ea <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d024e0:	2080      	movs	r0, #128	; 0x80
c0d024e2:	4001      	ands	r1, r0
c0d024e4:	4620      	mov	r0, r4
c0d024e6:	f7ff fec1 	bl	c0d0226c <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d024ea:	2000      	movs	r0, #0
c0d024ec:	b001      	add	sp, #4
c0d024ee:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024f0 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d024f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d024f2:	af03      	add	r7, sp, #12
c0d024f4:	b081      	sub	sp, #4
c0d024f6:	4615      	mov	r5, r2
c0d024f8:	460e      	mov	r6, r1
c0d024fa:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d024fc:	2e00      	cmp	r6, #0
c0d024fe:	d011      	beq.n	c0d02524 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02500:	2045      	movs	r0, #69	; 0x45
c0d02502:	0080      	lsls	r0, r0, #2
c0d02504:	5820      	ldr	r0, [r4, r0]
c0d02506:	6980      	ldr	r0, [r0, #24]
c0d02508:	2800      	cmp	r0, #0
c0d0250a:	d034      	beq.n	c0d02576 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0250c:	21fc      	movs	r1, #252	; 0xfc
c0d0250e:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02510:	2903      	cmp	r1, #3
c0d02512:	d130      	bne.n	c0d02576 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02514:	f7ff fa94 	bl	c0d01a40 <pic>
c0d02518:	4603      	mov	r3, r0
c0d0251a:	4620      	mov	r0, r4
c0d0251c:	4631      	mov	r1, r6
c0d0251e:	462a      	mov	r2, r5
c0d02520:	4798      	blx	r3
c0d02522:	e028      	b.n	c0d02576 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02524:	20f4      	movs	r0, #244	; 0xf4
c0d02526:	5820      	ldr	r0, [r4, r0]
c0d02528:	2803      	cmp	r0, #3
c0d0252a:	d124      	bne.n	c0d02576 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d0252c:	2090      	movs	r0, #144	; 0x90
c0d0252e:	5820      	ldr	r0, [r4, r0]
c0d02530:	218c      	movs	r1, #140	; 0x8c
c0d02532:	5861      	ldr	r1, [r4, r1]
c0d02534:	4622      	mov	r2, r4
c0d02536:	328c      	adds	r2, #140	; 0x8c
c0d02538:	4281      	cmp	r1, r0
c0d0253a:	d90a      	bls.n	c0d02552 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d0253c:	1a09      	subs	r1, r1, r0
c0d0253e:	6011      	str	r1, [r2, #0]
c0d02540:	4281      	cmp	r1, r0
c0d02542:	d300      	bcc.n	c0d02546 <USBD_LL_DataOutStage+0x56>
c0d02544:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02546:	b28a      	uxth	r2, r1
c0d02548:	4620      	mov	r0, r4
c0d0254a:	4629      	mov	r1, r5
c0d0254c:	f000 fc70 	bl	c0d02e30 <USBD_CtlContinueRx>
c0d02550:	e011      	b.n	c0d02576 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02552:	2045      	movs	r0, #69	; 0x45
c0d02554:	0080      	lsls	r0, r0, #2
c0d02556:	5820      	ldr	r0, [r4, r0]
c0d02558:	6900      	ldr	r0, [r0, #16]
c0d0255a:	2800      	cmp	r0, #0
c0d0255c:	d008      	beq.n	c0d02570 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0255e:	21fc      	movs	r1, #252	; 0xfc
c0d02560:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02562:	2903      	cmp	r1, #3
c0d02564:	d104      	bne.n	c0d02570 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02566:	f7ff fa6b 	bl	c0d01a40 <pic>
c0d0256a:	4601      	mov	r1, r0
c0d0256c:	4620      	mov	r0, r4
c0d0256e:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02570:	4620      	mov	r0, r4
c0d02572:	f000 fc65 	bl	c0d02e40 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02576:	2000      	movs	r0, #0
c0d02578:	b001      	add	sp, #4
c0d0257a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0257c <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d0257c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0257e:	af03      	add	r7, sp, #12
c0d02580:	b081      	sub	sp, #4
c0d02582:	460d      	mov	r5, r1
c0d02584:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02586:	2d00      	cmp	r5, #0
c0d02588:	d012      	beq.n	c0d025b0 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0258a:	2045      	movs	r0, #69	; 0x45
c0d0258c:	0080      	lsls	r0, r0, #2
c0d0258e:	5820      	ldr	r0, [r4, r0]
c0d02590:	2800      	cmp	r0, #0
c0d02592:	d054      	beq.n	c0d0263e <USBD_LL_DataInStage+0xc2>
c0d02594:	6940      	ldr	r0, [r0, #20]
c0d02596:	2800      	cmp	r0, #0
c0d02598:	d051      	beq.n	c0d0263e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0259a:	21fc      	movs	r1, #252	; 0xfc
c0d0259c:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0259e:	2903      	cmp	r1, #3
c0d025a0:	d14d      	bne.n	c0d0263e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d025a2:	f7ff fa4d 	bl	c0d01a40 <pic>
c0d025a6:	4602      	mov	r2, r0
c0d025a8:	4620      	mov	r0, r4
c0d025aa:	4629      	mov	r1, r5
c0d025ac:	4790      	blx	r2
c0d025ae:	e046      	b.n	c0d0263e <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d025b0:	20f4      	movs	r0, #244	; 0xf4
c0d025b2:	5820      	ldr	r0, [r4, r0]
c0d025b4:	2802      	cmp	r0, #2
c0d025b6:	d13a      	bne.n	c0d0262e <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d025b8:	69e0      	ldr	r0, [r4, #28]
c0d025ba:	6a25      	ldr	r5, [r4, #32]
c0d025bc:	42a8      	cmp	r0, r5
c0d025be:	d90b      	bls.n	c0d025d8 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d025c0:	1b40      	subs	r0, r0, r5
c0d025c2:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d025c4:	2109      	movs	r1, #9
c0d025c6:	014a      	lsls	r2, r1, #5
c0d025c8:	58a1      	ldr	r1, [r4, r2]
c0d025ca:	1949      	adds	r1, r1, r5
c0d025cc:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d025ce:	b282      	uxth	r2, r0
c0d025d0:	4620      	mov	r0, r4
c0d025d2:	f000 fc1e 	bl	c0d02e12 <USBD_CtlContinueSendData>
c0d025d6:	e02a      	b.n	c0d0262e <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d025d8:	69a6      	ldr	r6, [r4, #24]
c0d025da:	4630      	mov	r0, r6
c0d025dc:	4629      	mov	r1, r5
c0d025de:	f000 fccf 	bl	c0d02f80 <__aeabi_uidivmod>
c0d025e2:	42ae      	cmp	r6, r5
c0d025e4:	d30f      	bcc.n	c0d02606 <USBD_LL_DataInStage+0x8a>
c0d025e6:	2900      	cmp	r1, #0
c0d025e8:	d10d      	bne.n	c0d02606 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d025ea:	20f8      	movs	r0, #248	; 0xf8
c0d025ec:	5820      	ldr	r0, [r4, r0]
c0d025ee:	4625      	mov	r5, r4
c0d025f0:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d025f2:	4286      	cmp	r6, r0
c0d025f4:	d207      	bcs.n	c0d02606 <USBD_LL_DataInStage+0x8a>
c0d025f6:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d025f8:	4620      	mov	r0, r4
c0d025fa:	4631      	mov	r1, r6
c0d025fc:	4632      	mov	r2, r6
c0d025fe:	f000 fc08 	bl	c0d02e12 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02602:	602e      	str	r6, [r5, #0]
c0d02604:	e013      	b.n	c0d0262e <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02606:	2045      	movs	r0, #69	; 0x45
c0d02608:	0080      	lsls	r0, r0, #2
c0d0260a:	5820      	ldr	r0, [r4, r0]
c0d0260c:	2800      	cmp	r0, #0
c0d0260e:	d00b      	beq.n	c0d02628 <USBD_LL_DataInStage+0xac>
c0d02610:	68c0      	ldr	r0, [r0, #12]
c0d02612:	2800      	cmp	r0, #0
c0d02614:	d008      	beq.n	c0d02628 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02616:	21fc      	movs	r1, #252	; 0xfc
c0d02618:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0261a:	2903      	cmp	r1, #3
c0d0261c:	d104      	bne.n	c0d02628 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d0261e:	f7ff fa0f 	bl	c0d01a40 <pic>
c0d02622:	4601      	mov	r1, r0
c0d02624:	4620      	mov	r0, r4
c0d02626:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02628:	4620      	mov	r0, r4
c0d0262a:	f000 fc16 	bl	c0d02e5a <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d0262e:	2001      	movs	r0, #1
c0d02630:	0201      	lsls	r1, r0, #8
c0d02632:	1860      	adds	r0, r4, r1
c0d02634:	5c61      	ldrb	r1, [r4, r1]
c0d02636:	2901      	cmp	r1, #1
c0d02638:	d101      	bne.n	c0d0263e <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d0263a:	2100      	movs	r1, #0
c0d0263c:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d0263e:	2000      	movs	r0, #0
c0d02640:	b001      	add	sp, #4
c0d02642:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02644 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02644:	b5d0      	push	{r4, r6, r7, lr}
c0d02646:	af02      	add	r7, sp, #8
c0d02648:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d0264a:	2090      	movs	r0, #144	; 0x90
c0d0264c:	2140      	movs	r1, #64	; 0x40
c0d0264e:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02650:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02652:	20fc      	movs	r0, #252	; 0xfc
c0d02654:	2101      	movs	r1, #1
c0d02656:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02658:	2045      	movs	r0, #69	; 0x45
c0d0265a:	0080      	lsls	r0, r0, #2
c0d0265c:	5820      	ldr	r0, [r4, r0]
c0d0265e:	2800      	cmp	r0, #0
c0d02660:	d006      	beq.n	c0d02670 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02662:	6840      	ldr	r0, [r0, #4]
c0d02664:	f7ff f9ec 	bl	c0d01a40 <pic>
c0d02668:	4602      	mov	r2, r0
c0d0266a:	7921      	ldrb	r1, [r4, #4]
c0d0266c:	4620      	mov	r0, r4
c0d0266e:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02670:	2000      	movs	r0, #0
c0d02672:	bdd0      	pop	{r4, r6, r7, pc}

c0d02674 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02674:	7401      	strb	r1, [r0, #16]
c0d02676:	2000      	movs	r0, #0
  return USBD_OK;
c0d02678:	4770      	bx	lr

c0d0267a <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0267a:	2000      	movs	r0, #0
c0d0267c:	4770      	bx	lr

c0d0267e <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d0267e:	2000      	movs	r0, #0
c0d02680:	4770      	bx	lr

c0d02682 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02682:	b5d0      	push	{r4, r6, r7, lr}
c0d02684:	af02      	add	r7, sp, #8
c0d02686:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02688:	20fc      	movs	r0, #252	; 0xfc
c0d0268a:	5c20      	ldrb	r0, [r4, r0]
c0d0268c:	2803      	cmp	r0, #3
c0d0268e:	d10a      	bne.n	c0d026a6 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02690:	2045      	movs	r0, #69	; 0x45
c0d02692:	0080      	lsls	r0, r0, #2
c0d02694:	5820      	ldr	r0, [r4, r0]
c0d02696:	69c0      	ldr	r0, [r0, #28]
c0d02698:	2800      	cmp	r0, #0
c0d0269a:	d004      	beq.n	c0d026a6 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d0269c:	f7ff f9d0 	bl	c0d01a40 <pic>
c0d026a0:	4601      	mov	r1, r0
c0d026a2:	4620      	mov	r0, r4
c0d026a4:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d026a6:	2000      	movs	r0, #0
c0d026a8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d026ac <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d026ac:	b5d0      	push	{r4, r6, r7, lr}
c0d026ae:	af02      	add	r7, sp, #8
c0d026b0:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d026b2:	7848      	ldrb	r0, [r1, #1]
c0d026b4:	2809      	cmp	r0, #9
c0d026b6:	d810      	bhi.n	c0d026da <USBD_StdDevReq+0x2e>
c0d026b8:	4478      	add	r0, pc
c0d026ba:	7900      	ldrb	r0, [r0, #4]
c0d026bc:	0040      	lsls	r0, r0, #1
c0d026be:	4487      	add	pc, r0
c0d026c0:	150c0804 	.word	0x150c0804
c0d026c4:	0c25190c 	.word	0x0c25190c
c0d026c8:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d026ca:	4620      	mov	r0, r4
c0d026cc:	f000 f938 	bl	c0d02940 <USBD_GetStatus>
c0d026d0:	e01f      	b.n	c0d02712 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d026d2:	4620      	mov	r0, r4
c0d026d4:	f000 f976 	bl	c0d029c4 <USBD_ClrFeature>
c0d026d8:	e01b      	b.n	c0d02712 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d026da:	2180      	movs	r1, #128	; 0x80
c0d026dc:	4620      	mov	r0, r4
c0d026de:	f7ff fdc5 	bl	c0d0226c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d026e2:	2100      	movs	r1, #0
c0d026e4:	4620      	mov	r0, r4
c0d026e6:	f7ff fdc1 	bl	c0d0226c <USBD_LL_StallEP>
c0d026ea:	e012      	b.n	c0d02712 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d026ec:	4620      	mov	r0, r4
c0d026ee:	f000 f950 	bl	c0d02992 <USBD_SetFeature>
c0d026f2:	e00e      	b.n	c0d02712 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d026f4:	4620      	mov	r0, r4
c0d026f6:	f000 f897 	bl	c0d02828 <USBD_SetAddress>
c0d026fa:	e00a      	b.n	c0d02712 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d026fc:	4620      	mov	r0, r4
c0d026fe:	f000 f8ff 	bl	c0d02900 <USBD_GetConfig>
c0d02702:	e006      	b.n	c0d02712 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02704:	4620      	mov	r0, r4
c0d02706:	f000 f8bd 	bl	c0d02884 <USBD_SetConfig>
c0d0270a:	e002      	b.n	c0d02712 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d0270c:	4620      	mov	r0, r4
c0d0270e:	f000 f803 	bl	c0d02718 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02712:	2000      	movs	r0, #0
c0d02714:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02718 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02718:	b5b0      	push	{r4, r5, r7, lr}
c0d0271a:	af02      	add	r7, sp, #8
c0d0271c:	b082      	sub	sp, #8
c0d0271e:	460d      	mov	r5, r1
c0d02720:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02722:	8868      	ldrh	r0, [r5, #2]
c0d02724:	0a01      	lsrs	r1, r0, #8
c0d02726:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02728:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d0272a:	2a0e      	cmp	r2, #14
c0d0272c:	d83e      	bhi.n	c0d027ac <USBD_GetDescriptor+0x94>
c0d0272e:	46c0      	nop			; (mov r8, r8)
c0d02730:	447a      	add	r2, pc
c0d02732:	7912      	ldrb	r2, [r2, #4]
c0d02734:	0052      	lsls	r2, r2, #1
c0d02736:	4497      	add	pc, r2
c0d02738:	390c2607 	.word	0x390c2607
c0d0273c:	39362e39 	.word	0x39362e39
c0d02740:	39393939 	.word	0x39393939
c0d02744:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02748:	2011      	movs	r0, #17
c0d0274a:	0100      	lsls	r0, r0, #4
c0d0274c:	5820      	ldr	r0, [r4, r0]
c0d0274e:	6800      	ldr	r0, [r0, #0]
c0d02750:	e012      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02752:	b2c0      	uxtb	r0, r0
c0d02754:	2805      	cmp	r0, #5
c0d02756:	d829      	bhi.n	c0d027ac <USBD_GetDescriptor+0x94>
c0d02758:	4478      	add	r0, pc
c0d0275a:	7900      	ldrb	r0, [r0, #4]
c0d0275c:	0040      	lsls	r0, r0, #1
c0d0275e:	4487      	add	pc, r0
c0d02760:	544f4a02 	.word	0x544f4a02
c0d02764:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02766:	2011      	movs	r0, #17
c0d02768:	0100      	lsls	r0, r0, #4
c0d0276a:	5820      	ldr	r0, [r4, r0]
c0d0276c:	6840      	ldr	r0, [r0, #4]
c0d0276e:	e003      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02770:	2011      	movs	r0, #17
c0d02772:	0100      	lsls	r0, r0, #4
c0d02774:	5820      	ldr	r0, [r4, r0]
c0d02776:	69c0      	ldr	r0, [r0, #28]
c0d02778:	f7ff f962 	bl	c0d01a40 <pic>
c0d0277c:	4602      	mov	r2, r0
c0d0277e:	7c20      	ldrb	r0, [r4, #16]
c0d02780:	a901      	add	r1, sp, #4
c0d02782:	4790      	blx	r2
c0d02784:	e025      	b.n	c0d027d2 <USBD_GetDescriptor+0xba>
c0d02786:	2045      	movs	r0, #69	; 0x45
c0d02788:	0080      	lsls	r0, r0, #2
c0d0278a:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d0278c:	7c21      	ldrb	r1, [r4, #16]
c0d0278e:	2900      	cmp	r1, #0
c0d02790:	d014      	beq.n	c0d027bc <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02792:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02794:	e018      	b.n	c0d027c8 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02796:	7c20      	ldrb	r0, [r4, #16]
c0d02798:	2800      	cmp	r0, #0
c0d0279a:	d107      	bne.n	c0d027ac <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d0279c:	2045      	movs	r0, #69	; 0x45
c0d0279e:	0080      	lsls	r0, r0, #2
c0d027a0:	5820      	ldr	r0, [r4, r0]
c0d027a2:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d027a4:	e010      	b.n	c0d027c8 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d027a6:	7c20      	ldrb	r0, [r4, #16]
c0d027a8:	2800      	cmp	r0, #0
c0d027aa:	d009      	beq.n	c0d027c0 <USBD_GetDescriptor+0xa8>
c0d027ac:	4620      	mov	r0, r4
c0d027ae:	f7ff fd5d 	bl	c0d0226c <USBD_LL_StallEP>
c0d027b2:	2100      	movs	r1, #0
c0d027b4:	4620      	mov	r0, r4
c0d027b6:	f7ff fd59 	bl	c0d0226c <USBD_LL_StallEP>
c0d027ba:	e01a      	b.n	c0d027f2 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d027bc:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d027be:	e003      	b.n	c0d027c8 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d027c0:	2045      	movs	r0, #69	; 0x45
c0d027c2:	0080      	lsls	r0, r0, #2
c0d027c4:	5820      	ldr	r0, [r4, r0]
c0d027c6:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d027c8:	f7ff f93a 	bl	c0d01a40 <pic>
c0d027cc:	4601      	mov	r1, r0
c0d027ce:	a801      	add	r0, sp, #4
c0d027d0:	4788      	blx	r1
c0d027d2:	4601      	mov	r1, r0
c0d027d4:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d027d6:	8802      	ldrh	r2, [r0, #0]
c0d027d8:	2a00      	cmp	r2, #0
c0d027da:	d00a      	beq.n	c0d027f2 <USBD_GetDescriptor+0xda>
c0d027dc:	88e8      	ldrh	r0, [r5, #6]
c0d027de:	2800      	cmp	r0, #0
c0d027e0:	d007      	beq.n	c0d027f2 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d027e2:	4282      	cmp	r2, r0
c0d027e4:	d300      	bcc.n	c0d027e8 <USBD_GetDescriptor+0xd0>
c0d027e6:	4602      	mov	r2, r0
c0d027e8:	a801      	add	r0, sp, #4
c0d027ea:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d027ec:	4620      	mov	r0, r4
c0d027ee:	f000 faf9 	bl	c0d02de4 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d027f2:	b002      	add	sp, #8
c0d027f4:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d027f6:	2011      	movs	r0, #17
c0d027f8:	0100      	lsls	r0, r0, #4
c0d027fa:	5820      	ldr	r0, [r4, r0]
c0d027fc:	6880      	ldr	r0, [r0, #8]
c0d027fe:	e7bb      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02800:	2011      	movs	r0, #17
c0d02802:	0100      	lsls	r0, r0, #4
c0d02804:	5820      	ldr	r0, [r4, r0]
c0d02806:	68c0      	ldr	r0, [r0, #12]
c0d02808:	e7b6      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d0280a:	2011      	movs	r0, #17
c0d0280c:	0100      	lsls	r0, r0, #4
c0d0280e:	5820      	ldr	r0, [r4, r0]
c0d02810:	6900      	ldr	r0, [r0, #16]
c0d02812:	e7b1      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02814:	2011      	movs	r0, #17
c0d02816:	0100      	lsls	r0, r0, #4
c0d02818:	5820      	ldr	r0, [r4, r0]
c0d0281a:	6940      	ldr	r0, [r0, #20]
c0d0281c:	e7ac      	b.n	c0d02778 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d0281e:	2011      	movs	r0, #17
c0d02820:	0100      	lsls	r0, r0, #4
c0d02822:	5820      	ldr	r0, [r4, r0]
c0d02824:	6980      	ldr	r0, [r0, #24]
c0d02826:	e7a7      	b.n	c0d02778 <USBD_GetDescriptor+0x60>

c0d02828 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02828:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0282a:	af03      	add	r7, sp, #12
c0d0282c:	b081      	sub	sp, #4
c0d0282e:	460a      	mov	r2, r1
c0d02830:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02832:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02834:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02836:	2800      	cmp	r0, #0
c0d02838:	d10b      	bne.n	c0d02852 <USBD_SetAddress+0x2a>
c0d0283a:	88d0      	ldrh	r0, [r2, #6]
c0d0283c:	2800      	cmp	r0, #0
c0d0283e:	d108      	bne.n	c0d02852 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02840:	8850      	ldrh	r0, [r2, #2]
c0d02842:	267f      	movs	r6, #127	; 0x7f
c0d02844:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02846:	20fc      	movs	r0, #252	; 0xfc
c0d02848:	5c20      	ldrb	r0, [r4, r0]
c0d0284a:	4625      	mov	r5, r4
c0d0284c:	35fc      	adds	r5, #252	; 0xfc
c0d0284e:	2803      	cmp	r0, #3
c0d02850:	d108      	bne.n	c0d02864 <USBD_SetAddress+0x3c>
c0d02852:	4620      	mov	r0, r4
c0d02854:	f7ff fd0a 	bl	c0d0226c <USBD_LL_StallEP>
c0d02858:	2100      	movs	r1, #0
c0d0285a:	4620      	mov	r0, r4
c0d0285c:	f7ff fd06 	bl	c0d0226c <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02860:	b001      	add	sp, #4
c0d02862:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02864:	20fe      	movs	r0, #254	; 0xfe
c0d02866:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02868:	b2f1      	uxtb	r1, r6
c0d0286a:	4620      	mov	r0, r4
c0d0286c:	f7ff fd5c 	bl	c0d02328 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02870:	4620      	mov	r0, r4
c0d02872:	f000 fae5 	bl	c0d02e40 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02876:	2002      	movs	r0, #2
c0d02878:	2101      	movs	r1, #1
c0d0287a:	2e00      	cmp	r6, #0
c0d0287c:	d100      	bne.n	c0d02880 <USBD_SetAddress+0x58>
c0d0287e:	4608      	mov	r0, r1
c0d02880:	7028      	strb	r0, [r5, #0]
c0d02882:	e7ed      	b.n	c0d02860 <USBD_SetAddress+0x38>

c0d02884 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02884:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02886:	af03      	add	r7, sp, #12
c0d02888:	b081      	sub	sp, #4
c0d0288a:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d0288c:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0288e:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02890:	2e02      	cmp	r6, #2
c0d02892:	d21d      	bcs.n	c0d028d0 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02894:	20fc      	movs	r0, #252	; 0xfc
c0d02896:	5c21      	ldrb	r1, [r4, r0]
c0d02898:	4620      	mov	r0, r4
c0d0289a:	30fc      	adds	r0, #252	; 0xfc
c0d0289c:	2903      	cmp	r1, #3
c0d0289e:	d007      	beq.n	c0d028b0 <USBD_SetConfig+0x2c>
c0d028a0:	2902      	cmp	r1, #2
c0d028a2:	d115      	bne.n	c0d028d0 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d028a4:	2e00      	cmp	r6, #0
c0d028a6:	d026      	beq.n	c0d028f6 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d028a8:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d028aa:	2103      	movs	r1, #3
c0d028ac:	7001      	strb	r1, [r0, #0]
c0d028ae:	e009      	b.n	c0d028c4 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d028b0:	2e00      	cmp	r6, #0
c0d028b2:	d016      	beq.n	c0d028e2 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d028b4:	6860      	ldr	r0, [r4, #4]
c0d028b6:	4286      	cmp	r6, r0
c0d028b8:	d01d      	beq.n	c0d028f6 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d028ba:	b2c1      	uxtb	r1, r0
c0d028bc:	4620      	mov	r0, r4
c0d028be:	f7ff fdd3 	bl	c0d02468 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d028c2:	6066      	str	r6, [r4, #4]
c0d028c4:	4620      	mov	r0, r4
c0d028c6:	4631      	mov	r1, r6
c0d028c8:	f7ff fdb6 	bl	c0d02438 <USBD_SetClassConfig>
c0d028cc:	2802      	cmp	r0, #2
c0d028ce:	d112      	bne.n	c0d028f6 <USBD_SetConfig+0x72>
c0d028d0:	4620      	mov	r0, r4
c0d028d2:	4629      	mov	r1, r5
c0d028d4:	f7ff fcca 	bl	c0d0226c <USBD_LL_StallEP>
c0d028d8:	2100      	movs	r1, #0
c0d028da:	4620      	mov	r0, r4
c0d028dc:	f7ff fcc6 	bl	c0d0226c <USBD_LL_StallEP>
c0d028e0:	e00c      	b.n	c0d028fc <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d028e2:	2102      	movs	r1, #2
c0d028e4:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d028e6:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d028e8:	4620      	mov	r0, r4
c0d028ea:	4631      	mov	r1, r6
c0d028ec:	f7ff fdbc 	bl	c0d02468 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d028f0:	4620      	mov	r0, r4
c0d028f2:	f000 faa5 	bl	c0d02e40 <USBD_CtlSendStatus>
c0d028f6:	4620      	mov	r0, r4
c0d028f8:	f000 faa2 	bl	c0d02e40 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d028fc:	b001      	add	sp, #4
c0d028fe:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02900 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02900:	b5d0      	push	{r4, r6, r7, lr}
c0d02902:	af02      	add	r7, sp, #8
c0d02904:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02906:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02908:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d0290a:	2801      	cmp	r0, #1
c0d0290c:	d10a      	bne.n	c0d02924 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d0290e:	20fc      	movs	r0, #252	; 0xfc
c0d02910:	5c20      	ldrb	r0, [r4, r0]
c0d02912:	2803      	cmp	r0, #3
c0d02914:	d00e      	beq.n	c0d02934 <USBD_GetConfig+0x34>
c0d02916:	2802      	cmp	r0, #2
c0d02918:	d104      	bne.n	c0d02924 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d0291a:	2000      	movs	r0, #0
c0d0291c:	60a0      	str	r0, [r4, #8]
c0d0291e:	4621      	mov	r1, r4
c0d02920:	3108      	adds	r1, #8
c0d02922:	e008      	b.n	c0d02936 <USBD_GetConfig+0x36>
c0d02924:	4620      	mov	r0, r4
c0d02926:	f7ff fca1 	bl	c0d0226c <USBD_LL_StallEP>
c0d0292a:	2100      	movs	r1, #0
c0d0292c:	4620      	mov	r0, r4
c0d0292e:	f7ff fc9d 	bl	c0d0226c <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02932:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02934:	1d21      	adds	r1, r4, #4
c0d02936:	2201      	movs	r2, #1
c0d02938:	4620      	mov	r0, r4
c0d0293a:	f000 fa53 	bl	c0d02de4 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0293e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02940 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02940:	b5b0      	push	{r4, r5, r7, lr}
c0d02942:	af02      	add	r7, sp, #8
c0d02944:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02946:	20fc      	movs	r0, #252	; 0xfc
c0d02948:	5c20      	ldrb	r0, [r4, r0]
c0d0294a:	21fe      	movs	r1, #254	; 0xfe
c0d0294c:	4001      	ands	r1, r0
c0d0294e:	2902      	cmp	r1, #2
c0d02950:	d116      	bne.n	c0d02980 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02952:	2001      	movs	r0, #1
c0d02954:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02956:	2041      	movs	r0, #65	; 0x41
c0d02958:	0080      	lsls	r0, r0, #2
c0d0295a:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0295c:	4625      	mov	r5, r4
c0d0295e:	350c      	adds	r5, #12
c0d02960:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02962:	2900      	cmp	r1, #0
c0d02964:	d005      	beq.n	c0d02972 <USBD_GetStatus+0x32>
c0d02966:	4620      	mov	r0, r4
c0d02968:	f000 fa77 	bl	c0d02e5a <USBD_CtlReceiveStatus>
c0d0296c:	68e1      	ldr	r1, [r4, #12]
c0d0296e:	2002      	movs	r0, #2
c0d02970:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02972:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02974:	2202      	movs	r2, #2
c0d02976:	4620      	mov	r0, r4
c0d02978:	4629      	mov	r1, r5
c0d0297a:	f000 fa33 	bl	c0d02de4 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d0297e:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02980:	2180      	movs	r1, #128	; 0x80
c0d02982:	4620      	mov	r0, r4
c0d02984:	f7ff fc72 	bl	c0d0226c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02988:	2100      	movs	r1, #0
c0d0298a:	4620      	mov	r0, r4
c0d0298c:	f7ff fc6e 	bl	c0d0226c <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02990:	bdb0      	pop	{r4, r5, r7, pc}

c0d02992 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02992:	b5b0      	push	{r4, r5, r7, lr}
c0d02994:	af02      	add	r7, sp, #8
c0d02996:	460d      	mov	r5, r1
c0d02998:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d0299a:	8868      	ldrh	r0, [r5, #2]
c0d0299c:	2801      	cmp	r0, #1
c0d0299e:	d110      	bne.n	c0d029c2 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d029a0:	2041      	movs	r0, #65	; 0x41
c0d029a2:	0080      	lsls	r0, r0, #2
c0d029a4:	2101      	movs	r1, #1
c0d029a6:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d029a8:	2045      	movs	r0, #69	; 0x45
c0d029aa:	0080      	lsls	r0, r0, #2
c0d029ac:	5820      	ldr	r0, [r4, r0]
c0d029ae:	6880      	ldr	r0, [r0, #8]
c0d029b0:	f7ff f846 	bl	c0d01a40 <pic>
c0d029b4:	4602      	mov	r2, r0
c0d029b6:	4620      	mov	r0, r4
c0d029b8:	4629      	mov	r1, r5
c0d029ba:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d029bc:	4620      	mov	r0, r4
c0d029be:	f000 fa3f 	bl	c0d02e40 <USBD_CtlSendStatus>
  }

}
c0d029c2:	bdb0      	pop	{r4, r5, r7, pc}

c0d029c4 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d029c4:	b5b0      	push	{r4, r5, r7, lr}
c0d029c6:	af02      	add	r7, sp, #8
c0d029c8:	460d      	mov	r5, r1
c0d029ca:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d029cc:	20fc      	movs	r0, #252	; 0xfc
c0d029ce:	5c20      	ldrb	r0, [r4, r0]
c0d029d0:	21fe      	movs	r1, #254	; 0xfe
c0d029d2:	4001      	ands	r1, r0
c0d029d4:	2902      	cmp	r1, #2
c0d029d6:	d114      	bne.n	c0d02a02 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d029d8:	8868      	ldrh	r0, [r5, #2]
c0d029da:	2801      	cmp	r0, #1
c0d029dc:	d119      	bne.n	c0d02a12 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d029de:	2041      	movs	r0, #65	; 0x41
c0d029e0:	0080      	lsls	r0, r0, #2
c0d029e2:	2100      	movs	r1, #0
c0d029e4:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d029e6:	2045      	movs	r0, #69	; 0x45
c0d029e8:	0080      	lsls	r0, r0, #2
c0d029ea:	5820      	ldr	r0, [r4, r0]
c0d029ec:	6880      	ldr	r0, [r0, #8]
c0d029ee:	f7ff f827 	bl	c0d01a40 <pic>
c0d029f2:	4602      	mov	r2, r0
c0d029f4:	4620      	mov	r0, r4
c0d029f6:	4629      	mov	r1, r5
c0d029f8:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d029fa:	4620      	mov	r0, r4
c0d029fc:	f000 fa20 	bl	c0d02e40 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02a00:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a02:	2180      	movs	r1, #128	; 0x80
c0d02a04:	4620      	mov	r0, r4
c0d02a06:	f7ff fc31 	bl	c0d0226c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02a0a:	2100      	movs	r1, #0
c0d02a0c:	4620      	mov	r0, r4
c0d02a0e:	f7ff fc2d 	bl	c0d0226c <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02a12:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a14 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02a14:	b5d0      	push	{r4, r6, r7, lr}
c0d02a16:	af02      	add	r7, sp, #8
c0d02a18:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a1a:	2180      	movs	r1, #128	; 0x80
c0d02a1c:	f7ff fc26 	bl	c0d0226c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02a20:	2100      	movs	r1, #0
c0d02a22:	4620      	mov	r0, r4
c0d02a24:	f7ff fc22 	bl	c0d0226c <USBD_LL_StallEP>
}
c0d02a28:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a2a <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02a2a:	b5b0      	push	{r4, r5, r7, lr}
c0d02a2c:	af02      	add	r7, sp, #8
c0d02a2e:	460d      	mov	r5, r1
c0d02a30:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02a32:	20fc      	movs	r0, #252	; 0xfc
c0d02a34:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a36:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02a38:	2803      	cmp	r0, #3
c0d02a3a:	d115      	bne.n	c0d02a68 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02a3c:	88a8      	ldrh	r0, [r5, #4]
c0d02a3e:	22fe      	movs	r2, #254	; 0xfe
c0d02a40:	4002      	ands	r2, r0
c0d02a42:	2a01      	cmp	r2, #1
c0d02a44:	d810      	bhi.n	c0d02a68 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02a46:	2045      	movs	r0, #69	; 0x45
c0d02a48:	0080      	lsls	r0, r0, #2
c0d02a4a:	5820      	ldr	r0, [r4, r0]
c0d02a4c:	6880      	ldr	r0, [r0, #8]
c0d02a4e:	f7fe fff7 	bl	c0d01a40 <pic>
c0d02a52:	4602      	mov	r2, r0
c0d02a54:	4620      	mov	r0, r4
c0d02a56:	4629      	mov	r1, r5
c0d02a58:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02a5a:	88e8      	ldrh	r0, [r5, #6]
c0d02a5c:	2800      	cmp	r0, #0
c0d02a5e:	d10a      	bne.n	c0d02a76 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02a60:	4620      	mov	r0, r4
c0d02a62:	f000 f9ed 	bl	c0d02e40 <USBD_CtlSendStatus>
c0d02a66:	e006      	b.n	c0d02a76 <USBD_StdItfReq+0x4c>
c0d02a68:	4620      	mov	r0, r4
c0d02a6a:	f7ff fbff 	bl	c0d0226c <USBD_LL_StallEP>
c0d02a6e:	2100      	movs	r1, #0
c0d02a70:	4620      	mov	r0, r4
c0d02a72:	f7ff fbfb 	bl	c0d0226c <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02a76:	2000      	movs	r0, #0
c0d02a78:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a7a <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02a7a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a7c:	af03      	add	r7, sp, #12
c0d02a7e:	b081      	sub	sp, #4
c0d02a80:	460e      	mov	r6, r1
c0d02a82:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02a84:	7830      	ldrb	r0, [r6, #0]
c0d02a86:	2160      	movs	r1, #96	; 0x60
c0d02a88:	4001      	ands	r1, r0
c0d02a8a:	2920      	cmp	r1, #32
c0d02a8c:	d10a      	bne.n	c0d02aa4 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02a8e:	2045      	movs	r0, #69	; 0x45
c0d02a90:	0080      	lsls	r0, r0, #2
c0d02a92:	5820      	ldr	r0, [r4, r0]
c0d02a94:	6880      	ldr	r0, [r0, #8]
c0d02a96:	f7fe ffd3 	bl	c0d01a40 <pic>
c0d02a9a:	4602      	mov	r2, r0
c0d02a9c:	4620      	mov	r0, r4
c0d02a9e:	4631      	mov	r1, r6
c0d02aa0:	4790      	blx	r2
c0d02aa2:	e063      	b.n	c0d02b6c <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02aa4:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02aa6:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02aa8:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02aaa:	2800      	cmp	r0, #0
c0d02aac:	d012      	beq.n	c0d02ad4 <USBD_StdEPReq+0x5a>
c0d02aae:	2801      	cmp	r0, #1
c0d02ab0:	d019      	beq.n	c0d02ae6 <USBD_StdEPReq+0x6c>
c0d02ab2:	2803      	cmp	r0, #3
c0d02ab4:	d15a      	bne.n	c0d02b6c <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02ab6:	20fc      	movs	r0, #252	; 0xfc
c0d02ab8:	5c20      	ldrb	r0, [r4, r0]
c0d02aba:	2803      	cmp	r0, #3
c0d02abc:	d117      	bne.n	c0d02aee <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02abe:	8870      	ldrh	r0, [r6, #2]
c0d02ac0:	2800      	cmp	r0, #0
c0d02ac2:	d12d      	bne.n	c0d02b20 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02ac4:	4329      	orrs	r1, r5
c0d02ac6:	2980      	cmp	r1, #128	; 0x80
c0d02ac8:	d02a      	beq.n	c0d02b20 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02aca:	4620      	mov	r0, r4
c0d02acc:	4629      	mov	r1, r5
c0d02ace:	f7ff fbcd 	bl	c0d0226c <USBD_LL_StallEP>
c0d02ad2:	e025      	b.n	c0d02b20 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02ad4:	20fc      	movs	r0, #252	; 0xfc
c0d02ad6:	5c20      	ldrb	r0, [r4, r0]
c0d02ad8:	2803      	cmp	r0, #3
c0d02ada:	d02f      	beq.n	c0d02b3c <USBD_StdEPReq+0xc2>
c0d02adc:	2802      	cmp	r0, #2
c0d02ade:	d10e      	bne.n	c0d02afe <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02ae0:	0668      	lsls	r0, r5, #25
c0d02ae2:	d109      	bne.n	c0d02af8 <USBD_StdEPReq+0x7e>
c0d02ae4:	e042      	b.n	c0d02b6c <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02ae6:	20fc      	movs	r0, #252	; 0xfc
c0d02ae8:	5c20      	ldrb	r0, [r4, r0]
c0d02aea:	2803      	cmp	r0, #3
c0d02aec:	d00f      	beq.n	c0d02b0e <USBD_StdEPReq+0x94>
c0d02aee:	2802      	cmp	r0, #2
c0d02af0:	d105      	bne.n	c0d02afe <USBD_StdEPReq+0x84>
c0d02af2:	4329      	orrs	r1, r5
c0d02af4:	2980      	cmp	r1, #128	; 0x80
c0d02af6:	d039      	beq.n	c0d02b6c <USBD_StdEPReq+0xf2>
c0d02af8:	4620      	mov	r0, r4
c0d02afa:	4629      	mov	r1, r5
c0d02afc:	e004      	b.n	c0d02b08 <USBD_StdEPReq+0x8e>
c0d02afe:	4620      	mov	r0, r4
c0d02b00:	f7ff fbb4 	bl	c0d0226c <USBD_LL_StallEP>
c0d02b04:	2100      	movs	r1, #0
c0d02b06:	4620      	mov	r0, r4
c0d02b08:	f7ff fbb0 	bl	c0d0226c <USBD_LL_StallEP>
c0d02b0c:	e02e      	b.n	c0d02b6c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02b0e:	8870      	ldrh	r0, [r6, #2]
c0d02b10:	2800      	cmp	r0, #0
c0d02b12:	d12b      	bne.n	c0d02b6c <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02b14:	0668      	lsls	r0, r5, #25
c0d02b16:	d00d      	beq.n	c0d02b34 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02b18:	4620      	mov	r0, r4
c0d02b1a:	4629      	mov	r1, r5
c0d02b1c:	f7ff fbcc 	bl	c0d022b8 <USBD_LL_ClearStallEP>
c0d02b20:	2045      	movs	r0, #69	; 0x45
c0d02b22:	0080      	lsls	r0, r0, #2
c0d02b24:	5820      	ldr	r0, [r4, r0]
c0d02b26:	6880      	ldr	r0, [r0, #8]
c0d02b28:	f7fe ff8a 	bl	c0d01a40 <pic>
c0d02b2c:	4602      	mov	r2, r0
c0d02b2e:	4620      	mov	r0, r4
c0d02b30:	4631      	mov	r1, r6
c0d02b32:	4790      	blx	r2
c0d02b34:	4620      	mov	r0, r4
c0d02b36:	f000 f983 	bl	c0d02e40 <USBD_CtlSendStatus>
c0d02b3a:	e017      	b.n	c0d02b6c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02b3c:	4626      	mov	r6, r4
c0d02b3e:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02b40:	4620      	mov	r0, r4
c0d02b42:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02b44:	420d      	tst	r5, r1
c0d02b46:	d100      	bne.n	c0d02b4a <USBD_StdEPReq+0xd0>
c0d02b48:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02b4a:	4620      	mov	r0, r4
c0d02b4c:	4629      	mov	r1, r5
c0d02b4e:	f7ff fbd9 	bl	c0d02304 <USBD_LL_IsStallEP>
c0d02b52:	2101      	movs	r1, #1
c0d02b54:	2800      	cmp	r0, #0
c0d02b56:	d100      	bne.n	c0d02b5a <USBD_StdEPReq+0xe0>
c0d02b58:	4601      	mov	r1, r0
c0d02b5a:	207f      	movs	r0, #127	; 0x7f
c0d02b5c:	4005      	ands	r5, r0
c0d02b5e:	0128      	lsls	r0, r5, #4
c0d02b60:	5031      	str	r1, [r6, r0]
c0d02b62:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02b64:	2202      	movs	r2, #2
c0d02b66:	4620      	mov	r0, r4
c0d02b68:	f000 f93c 	bl	c0d02de4 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02b6c:	2000      	movs	r0, #0
c0d02b6e:	b001      	add	sp, #4
c0d02b70:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b72 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02b72:	780a      	ldrb	r2, [r1, #0]
c0d02b74:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02b76:	784a      	ldrb	r2, [r1, #1]
c0d02b78:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02b7a:	788a      	ldrb	r2, [r1, #2]
c0d02b7c:	78cb      	ldrb	r3, [r1, #3]
c0d02b7e:	021b      	lsls	r3, r3, #8
c0d02b80:	4313      	orrs	r3, r2
c0d02b82:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02b84:	790a      	ldrb	r2, [r1, #4]
c0d02b86:	794b      	ldrb	r3, [r1, #5]
c0d02b88:	021b      	lsls	r3, r3, #8
c0d02b8a:	4313      	orrs	r3, r2
c0d02b8c:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02b8e:	798a      	ldrb	r2, [r1, #6]
c0d02b90:	79c9      	ldrb	r1, [r1, #7]
c0d02b92:	0209      	lsls	r1, r1, #8
c0d02b94:	4311      	orrs	r1, r2
c0d02b96:	80c1      	strh	r1, [r0, #6]

}
c0d02b98:	4770      	bx	lr

c0d02b9a <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02b9a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b9c:	af03      	add	r7, sp, #12
c0d02b9e:	b083      	sub	sp, #12
c0d02ba0:	460d      	mov	r5, r1
c0d02ba2:	4604      	mov	r4, r0
c0d02ba4:	a802      	add	r0, sp, #8
c0d02ba6:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02ba8:	8006      	strh	r6, [r0, #0]
c0d02baa:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02bac:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02bae:	7829      	ldrb	r1, [r5, #0]
c0d02bb0:	2060      	movs	r0, #96	; 0x60
c0d02bb2:	4008      	ands	r0, r1
c0d02bb4:	2800      	cmp	r0, #0
c0d02bb6:	d010      	beq.n	c0d02bda <USBD_HID_Setup+0x40>
c0d02bb8:	2820      	cmp	r0, #32
c0d02bba:	d139      	bne.n	c0d02c30 <USBD_HID_Setup+0x96>
c0d02bbc:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02bbe:	4601      	mov	r1, r0
c0d02bc0:	390a      	subs	r1, #10
c0d02bc2:	2902      	cmp	r1, #2
c0d02bc4:	d334      	bcc.n	c0d02c30 <USBD_HID_Setup+0x96>
c0d02bc6:	2802      	cmp	r0, #2
c0d02bc8:	d01c      	beq.n	c0d02c04 <USBD_HID_Setup+0x6a>
c0d02bca:	2803      	cmp	r0, #3
c0d02bcc:	d01a      	beq.n	c0d02c04 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02bce:	4620      	mov	r0, r4
c0d02bd0:	4629      	mov	r1, r5
c0d02bd2:	f7ff ff1f 	bl	c0d02a14 <USBD_CtlError>
c0d02bd6:	2602      	movs	r6, #2
c0d02bd8:	e02a      	b.n	c0d02c30 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02bda:	7868      	ldrb	r0, [r5, #1]
c0d02bdc:	280b      	cmp	r0, #11
c0d02bde:	d014      	beq.n	c0d02c0a <USBD_HID_Setup+0x70>
c0d02be0:	280a      	cmp	r0, #10
c0d02be2:	d00f      	beq.n	c0d02c04 <USBD_HID_Setup+0x6a>
c0d02be4:	2806      	cmp	r0, #6
c0d02be6:	d123      	bne.n	c0d02c30 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02be8:	8868      	ldrh	r0, [r5, #2]
c0d02bea:	0a00      	lsrs	r0, r0, #8
c0d02bec:	2600      	movs	r6, #0
c0d02bee:	2821      	cmp	r0, #33	; 0x21
c0d02bf0:	d00f      	beq.n	c0d02c12 <USBD_HID_Setup+0x78>
c0d02bf2:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02bf4:	4632      	mov	r2, r6
c0d02bf6:	4631      	mov	r1, r6
c0d02bf8:	d117      	bne.n	c0d02c2a <USBD_HID_Setup+0x90>
c0d02bfa:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02bfc:	9000      	str	r0, [sp, #0]
c0d02bfe:	f000 f847 	bl	c0d02c90 <USBD_HID_GetReportDescriptor_impl>
c0d02c02:	e00a      	b.n	c0d02c1a <USBD_HID_Setup+0x80>
c0d02c04:	a901      	add	r1, sp, #4
c0d02c06:	2201      	movs	r2, #1
c0d02c08:	e00f      	b.n	c0d02c2a <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02c0a:	4620      	mov	r0, r4
c0d02c0c:	f000 f918 	bl	c0d02e40 <USBD_CtlSendStatus>
c0d02c10:	e00e      	b.n	c0d02c30 <USBD_HID_Setup+0x96>
c0d02c12:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02c14:	9000      	str	r0, [sp, #0]
c0d02c16:	f000 f833 	bl	c0d02c80 <USBD_HID_GetHidDescriptor_impl>
c0d02c1a:	9b00      	ldr	r3, [sp, #0]
c0d02c1c:	4601      	mov	r1, r0
c0d02c1e:	881a      	ldrh	r2, [r3, #0]
c0d02c20:	88e8      	ldrh	r0, [r5, #6]
c0d02c22:	4282      	cmp	r2, r0
c0d02c24:	d300      	bcc.n	c0d02c28 <USBD_HID_Setup+0x8e>
c0d02c26:	4602      	mov	r2, r0
c0d02c28:	801a      	strh	r2, [r3, #0]
c0d02c2a:	4620      	mov	r0, r4
c0d02c2c:	f000 f8da 	bl	c0d02de4 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02c30:	b2f0      	uxtb	r0, r6
c0d02c32:	b003      	add	sp, #12
c0d02c34:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c36 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02c36:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c38:	af03      	add	r7, sp, #12
c0d02c3a:	b081      	sub	sp, #4
c0d02c3c:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02c3e:	2182      	movs	r1, #130	; 0x82
c0d02c40:	2502      	movs	r5, #2
c0d02c42:	2640      	movs	r6, #64	; 0x40
c0d02c44:	462a      	mov	r2, r5
c0d02c46:	4633      	mov	r3, r6
c0d02c48:	f7ff fad0 	bl	c0d021ec <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02c4c:	4620      	mov	r0, r4
c0d02c4e:	4629      	mov	r1, r5
c0d02c50:	462a      	mov	r2, r5
c0d02c52:	4633      	mov	r3, r6
c0d02c54:	f7ff faca 	bl	c0d021ec <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02c58:	4620      	mov	r0, r4
c0d02c5a:	4629      	mov	r1, r5
c0d02c5c:	4632      	mov	r2, r6
c0d02c5e:	f7ff fb90 	bl	c0d02382 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02c62:	2000      	movs	r0, #0
c0d02c64:	b001      	add	sp, #4
c0d02c66:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c68 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02c68:	b5d0      	push	{r4, r6, r7, lr}
c0d02c6a:	af02      	add	r7, sp, #8
c0d02c6c:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02c6e:	2182      	movs	r1, #130	; 0x82
c0d02c70:	f7ff fae4 	bl	c0d0223c <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02c74:	2102      	movs	r1, #2
c0d02c76:	4620      	mov	r0, r4
c0d02c78:	f7ff fae0 	bl	c0d0223c <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02c7c:	2000      	movs	r0, #0
c0d02c7e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02c80 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02c80:	2109      	movs	r1, #9
c0d02c82:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02c84:	4801      	ldr	r0, [pc, #4]	; (c0d02c8c <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02c86:	4478      	add	r0, pc
c0d02c88:	4770      	bx	lr
c0d02c8a:	46c0      	nop			; (mov r8, r8)
c0d02c8c:	00000a5a 	.word	0x00000a5a

c0d02c90 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02c90:	2122      	movs	r1, #34	; 0x22
c0d02c92:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02c94:	4801      	ldr	r0, [pc, #4]	; (c0d02c9c <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02c96:	4478      	add	r0, pc
c0d02c98:	4770      	bx	lr
c0d02c9a:	46c0      	nop			; (mov r8, r8)
c0d02c9c:	00000a25 	.word	0x00000a25

c0d02ca0 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02ca0:	b5b0      	push	{r4, r5, r7, lr}
c0d02ca2:	af02      	add	r7, sp, #8
c0d02ca4:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02ca6:	2102      	movs	r1, #2
c0d02ca8:	2240      	movs	r2, #64	; 0x40
c0d02caa:	f7ff fb6a 	bl	c0d02382 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02cae:	4d0d      	ldr	r5, [pc, #52]	; (c0d02ce4 <USBD_HID_DataOut_impl+0x44>)
c0d02cb0:	7828      	ldrb	r0, [r5, #0]
c0d02cb2:	2800      	cmp	r0, #0
c0d02cb4:	d113      	bne.n	c0d02cde <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02cb6:	2002      	movs	r0, #2
c0d02cb8:	f7fe f928 	bl	c0d00f0c <io_seproxyhal_get_ep_rx_size>
c0d02cbc:	4602      	mov	r2, r0
c0d02cbe:	480d      	ldr	r0, [pc, #52]	; (c0d02cf4 <USBD_HID_DataOut_impl+0x54>)
c0d02cc0:	4478      	add	r0, pc
c0d02cc2:	4621      	mov	r1, r4
c0d02cc4:	f7fd ff86 	bl	c0d00bd4 <io_usb_hid_receive>
c0d02cc8:	2802      	cmp	r0, #2
c0d02cca:	d108      	bne.n	c0d02cde <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02ccc:	2001      	movs	r0, #1
c0d02cce:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02cd0:	4805      	ldr	r0, [pc, #20]	; (c0d02ce8 <USBD_HID_DataOut_impl+0x48>)
c0d02cd2:	2107      	movs	r1, #7
c0d02cd4:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02cd6:	4805      	ldr	r0, [pc, #20]	; (c0d02cec <USBD_HID_DataOut_impl+0x4c>)
c0d02cd8:	6800      	ldr	r0, [r0, #0]
c0d02cda:	4905      	ldr	r1, [pc, #20]	; (c0d02cf0 <USBD_HID_DataOut_impl+0x50>)
c0d02cdc:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02cde:	2000      	movs	r0, #0
c0d02ce0:	bdb0      	pop	{r4, r5, r7, pc}
c0d02ce2:	46c0      	nop			; (mov r8, r8)
c0d02ce4:	20001d10 	.word	0x20001d10
c0d02ce8:	20001d18 	.word	0x20001d18
c0d02cec:	20001c00 	.word	0x20001c00
c0d02cf0:	20001d1c 	.word	0x20001d1c
c0d02cf4:	ffffe3a1 	.word	0xffffe3a1

c0d02cf8 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02cf8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02cfa:	af03      	add	r7, sp, #12
c0d02cfc:	b081      	sub	sp, #4
c0d02cfe:	4604      	mov	r4, r0
c0d02d00:	2049      	movs	r0, #73	; 0x49
c0d02d02:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02d04:	4810      	ldr	r0, [pc, #64]	; (c0d02d48 <USB_power+0x50>)
c0d02d06:	2100      	movs	r1, #0
c0d02d08:	462a      	mov	r2, r5
c0d02d0a:	f7fe f80f 	bl	c0d00d2c <os_memset>

  if (enabled) {
c0d02d0e:	2c00      	cmp	r4, #0
c0d02d10:	d015      	beq.n	c0d02d3e <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02d12:	4c0d      	ldr	r4, [pc, #52]	; (c0d02d48 <USB_power+0x50>)
c0d02d14:	2600      	movs	r6, #0
c0d02d16:	4620      	mov	r0, r4
c0d02d18:	4631      	mov	r1, r6
c0d02d1a:	462a      	mov	r2, r5
c0d02d1c:	f7fe f806 	bl	c0d00d2c <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02d20:	490a      	ldr	r1, [pc, #40]	; (c0d02d4c <USB_power+0x54>)
c0d02d22:	4479      	add	r1, pc
c0d02d24:	4620      	mov	r0, r4
c0d02d26:	4632      	mov	r2, r6
c0d02d28:	f7ff fb3f 	bl	c0d023aa <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02d2c:	4908      	ldr	r1, [pc, #32]	; (c0d02d50 <USB_power+0x58>)
c0d02d2e:	4479      	add	r1, pc
c0d02d30:	4620      	mov	r0, r4
c0d02d32:	f7ff fb72 	bl	c0d0241a <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02d36:	4620      	mov	r0, r4
c0d02d38:	f7ff fb78 	bl	c0d0242c <USBD_Start>
c0d02d3c:	e002      	b.n	c0d02d44 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02d3e:	4802      	ldr	r0, [pc, #8]	; (c0d02d48 <USB_power+0x50>)
c0d02d40:	f7ff fb51 	bl	c0d023e6 <USBD_DeInit>
  }
}
c0d02d44:	b001      	add	sp, #4
c0d02d46:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02d48:	20001d34 	.word	0x20001d34
c0d02d4c:	000009da 	.word	0x000009da
c0d02d50:	00000a0a 	.word	0x00000a0a

c0d02d54 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02d54:	2012      	movs	r0, #18
c0d02d56:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02d58:	4801      	ldr	r0, [pc, #4]	; (c0d02d60 <USBD_DeviceDescriptor+0xc>)
c0d02d5a:	4478      	add	r0, pc
c0d02d5c:	4770      	bx	lr
c0d02d5e:	46c0      	nop			; (mov r8, r8)
c0d02d60:	0000098f 	.word	0x0000098f

c0d02d64 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02d64:	2004      	movs	r0, #4
c0d02d66:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02d68:	4801      	ldr	r0, [pc, #4]	; (c0d02d70 <USBD_LangIDStrDescriptor+0xc>)
c0d02d6a:	4478      	add	r0, pc
c0d02d6c:	4770      	bx	lr
c0d02d6e:	46c0      	nop			; (mov r8, r8)
c0d02d70:	000009b2 	.word	0x000009b2

c0d02d74 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02d74:	200e      	movs	r0, #14
c0d02d76:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02d78:	4801      	ldr	r0, [pc, #4]	; (c0d02d80 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02d7a:	4478      	add	r0, pc
c0d02d7c:	4770      	bx	lr
c0d02d7e:	46c0      	nop			; (mov r8, r8)
c0d02d80:	000009a6 	.word	0x000009a6

c0d02d84 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02d84:	200e      	movs	r0, #14
c0d02d86:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02d88:	4801      	ldr	r0, [pc, #4]	; (c0d02d90 <USBD_ProductStrDescriptor+0xc>)
c0d02d8a:	4478      	add	r0, pc
c0d02d8c:	4770      	bx	lr
c0d02d8e:	46c0      	nop			; (mov r8, r8)
c0d02d90:	00000923 	.word	0x00000923

c0d02d94 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02d94:	200a      	movs	r0, #10
c0d02d96:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02d98:	4801      	ldr	r0, [pc, #4]	; (c0d02da0 <USBD_SerialStrDescriptor+0xc>)
c0d02d9a:	4478      	add	r0, pc
c0d02d9c:	4770      	bx	lr
c0d02d9e:	46c0      	nop			; (mov r8, r8)
c0d02da0:	00000994 	.word	0x00000994

c0d02da4 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02da4:	200e      	movs	r0, #14
c0d02da6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02da8:	4801      	ldr	r0, [pc, #4]	; (c0d02db0 <USBD_ConfigStrDescriptor+0xc>)
c0d02daa:	4478      	add	r0, pc
c0d02dac:	4770      	bx	lr
c0d02dae:	46c0      	nop			; (mov r8, r8)
c0d02db0:	00000903 	.word	0x00000903

c0d02db4 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02db4:	200e      	movs	r0, #14
c0d02db6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02db8:	4801      	ldr	r0, [pc, #4]	; (c0d02dc0 <USBD_InterfaceStrDescriptor+0xc>)
c0d02dba:	4478      	add	r0, pc
c0d02dbc:	4770      	bx	lr
c0d02dbe:	46c0      	nop			; (mov r8, r8)
c0d02dc0:	000008f3 	.word	0x000008f3

c0d02dc4 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02dc4:	2129      	movs	r1, #41	; 0x29
c0d02dc6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02dc8:	4801      	ldr	r0, [pc, #4]	; (c0d02dd0 <USBD_GetCfgDesc_impl+0xc>)
c0d02dca:	4478      	add	r0, pc
c0d02dcc:	4770      	bx	lr
c0d02dce:	46c0      	nop			; (mov r8, r8)
c0d02dd0:	000009a6 	.word	0x000009a6

c0d02dd4 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02dd4:	210a      	movs	r1, #10
c0d02dd6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02dd8:	4801      	ldr	r0, [pc, #4]	; (c0d02de0 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02dda:	4478      	add	r0, pc
c0d02ddc:	4770      	bx	lr
c0d02dde:	46c0      	nop			; (mov r8, r8)
c0d02de0:	000009c2 	.word	0x000009c2

c0d02de4 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02de4:	b5b0      	push	{r4, r5, r7, lr}
c0d02de6:	af02      	add	r7, sp, #8
c0d02de8:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02dea:	21f4      	movs	r1, #244	; 0xf4
c0d02dec:	2302      	movs	r3, #2
c0d02dee:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02df0:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02df2:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02df4:	2109      	movs	r1, #9
c0d02df6:	0149      	lsls	r1, r1, #5
c0d02df8:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02dfa:	6a01      	ldr	r1, [r0, #32]
c0d02dfc:	428a      	cmp	r2, r1
c0d02dfe:	d300      	bcc.n	c0d02e02 <USBD_CtlSendData+0x1e>
c0d02e00:	460a      	mov	r2, r1
c0d02e02:	b293      	uxth	r3, r2
c0d02e04:	2500      	movs	r5, #0
c0d02e06:	4629      	mov	r1, r5
c0d02e08:	4622      	mov	r2, r4
c0d02e0a:	f7ff faa0 	bl	c0d0234e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02e0e:	4628      	mov	r0, r5
c0d02e10:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e12 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02e12:	b5b0      	push	{r4, r5, r7, lr}
c0d02e14:	af02      	add	r7, sp, #8
c0d02e16:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02e18:	6a01      	ldr	r1, [r0, #32]
c0d02e1a:	428a      	cmp	r2, r1
c0d02e1c:	d300      	bcc.n	c0d02e20 <USBD_CtlContinueSendData+0xe>
c0d02e1e:	460a      	mov	r2, r1
c0d02e20:	b293      	uxth	r3, r2
c0d02e22:	2500      	movs	r5, #0
c0d02e24:	4629      	mov	r1, r5
c0d02e26:	4622      	mov	r2, r4
c0d02e28:	f7ff fa91 	bl	c0d0234e <USBD_LL_Transmit>
  return USBD_OK;
c0d02e2c:	4628      	mov	r0, r5
c0d02e2e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e30 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02e30:	b5d0      	push	{r4, r6, r7, lr}
c0d02e32:	af02      	add	r7, sp, #8
c0d02e34:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02e36:	4621      	mov	r1, r4
c0d02e38:	f7ff faa3 	bl	c0d02382 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02e3c:	4620      	mov	r0, r4
c0d02e3e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e40 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02e40:	b5d0      	push	{r4, r6, r7, lr}
c0d02e42:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02e44:	21f4      	movs	r1, #244	; 0xf4
c0d02e46:	2204      	movs	r2, #4
c0d02e48:	5042      	str	r2, [r0, r1]
c0d02e4a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02e4c:	4621      	mov	r1, r4
c0d02e4e:	4622      	mov	r2, r4
c0d02e50:	4623      	mov	r3, r4
c0d02e52:	f7ff fa7c 	bl	c0d0234e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02e56:	4620      	mov	r0, r4
c0d02e58:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e5a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02e5a:	b5d0      	push	{r4, r6, r7, lr}
c0d02e5c:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02e5e:	21f4      	movs	r1, #244	; 0xf4
c0d02e60:	2205      	movs	r2, #5
c0d02e62:	5042      	str	r2, [r0, r1]
c0d02e64:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02e66:	4621      	mov	r1, r4
c0d02e68:	4622      	mov	r2, r4
c0d02e6a:	f7ff fa8a 	bl	c0d02382 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02e6e:	4620      	mov	r0, r4
c0d02e70:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02e74 <__aeabi_uidiv>:
c0d02e74:	2200      	movs	r2, #0
c0d02e76:	0843      	lsrs	r3, r0, #1
c0d02e78:	428b      	cmp	r3, r1
c0d02e7a:	d374      	bcc.n	c0d02f66 <__aeabi_uidiv+0xf2>
c0d02e7c:	0903      	lsrs	r3, r0, #4
c0d02e7e:	428b      	cmp	r3, r1
c0d02e80:	d35f      	bcc.n	c0d02f42 <__aeabi_uidiv+0xce>
c0d02e82:	0a03      	lsrs	r3, r0, #8
c0d02e84:	428b      	cmp	r3, r1
c0d02e86:	d344      	bcc.n	c0d02f12 <__aeabi_uidiv+0x9e>
c0d02e88:	0b03      	lsrs	r3, r0, #12
c0d02e8a:	428b      	cmp	r3, r1
c0d02e8c:	d328      	bcc.n	c0d02ee0 <__aeabi_uidiv+0x6c>
c0d02e8e:	0c03      	lsrs	r3, r0, #16
c0d02e90:	428b      	cmp	r3, r1
c0d02e92:	d30d      	bcc.n	c0d02eb0 <__aeabi_uidiv+0x3c>
c0d02e94:	22ff      	movs	r2, #255	; 0xff
c0d02e96:	0209      	lsls	r1, r1, #8
c0d02e98:	ba12      	rev	r2, r2
c0d02e9a:	0c03      	lsrs	r3, r0, #16
c0d02e9c:	428b      	cmp	r3, r1
c0d02e9e:	d302      	bcc.n	c0d02ea6 <__aeabi_uidiv+0x32>
c0d02ea0:	1212      	asrs	r2, r2, #8
c0d02ea2:	0209      	lsls	r1, r1, #8
c0d02ea4:	d065      	beq.n	c0d02f72 <__aeabi_uidiv+0xfe>
c0d02ea6:	0b03      	lsrs	r3, r0, #12
c0d02ea8:	428b      	cmp	r3, r1
c0d02eaa:	d319      	bcc.n	c0d02ee0 <__aeabi_uidiv+0x6c>
c0d02eac:	e000      	b.n	c0d02eb0 <__aeabi_uidiv+0x3c>
c0d02eae:	0a09      	lsrs	r1, r1, #8
c0d02eb0:	0bc3      	lsrs	r3, r0, #15
c0d02eb2:	428b      	cmp	r3, r1
c0d02eb4:	d301      	bcc.n	c0d02eba <__aeabi_uidiv+0x46>
c0d02eb6:	03cb      	lsls	r3, r1, #15
c0d02eb8:	1ac0      	subs	r0, r0, r3
c0d02eba:	4152      	adcs	r2, r2
c0d02ebc:	0b83      	lsrs	r3, r0, #14
c0d02ebe:	428b      	cmp	r3, r1
c0d02ec0:	d301      	bcc.n	c0d02ec6 <__aeabi_uidiv+0x52>
c0d02ec2:	038b      	lsls	r3, r1, #14
c0d02ec4:	1ac0      	subs	r0, r0, r3
c0d02ec6:	4152      	adcs	r2, r2
c0d02ec8:	0b43      	lsrs	r3, r0, #13
c0d02eca:	428b      	cmp	r3, r1
c0d02ecc:	d301      	bcc.n	c0d02ed2 <__aeabi_uidiv+0x5e>
c0d02ece:	034b      	lsls	r3, r1, #13
c0d02ed0:	1ac0      	subs	r0, r0, r3
c0d02ed2:	4152      	adcs	r2, r2
c0d02ed4:	0b03      	lsrs	r3, r0, #12
c0d02ed6:	428b      	cmp	r3, r1
c0d02ed8:	d301      	bcc.n	c0d02ede <__aeabi_uidiv+0x6a>
c0d02eda:	030b      	lsls	r3, r1, #12
c0d02edc:	1ac0      	subs	r0, r0, r3
c0d02ede:	4152      	adcs	r2, r2
c0d02ee0:	0ac3      	lsrs	r3, r0, #11
c0d02ee2:	428b      	cmp	r3, r1
c0d02ee4:	d301      	bcc.n	c0d02eea <__aeabi_uidiv+0x76>
c0d02ee6:	02cb      	lsls	r3, r1, #11
c0d02ee8:	1ac0      	subs	r0, r0, r3
c0d02eea:	4152      	adcs	r2, r2
c0d02eec:	0a83      	lsrs	r3, r0, #10
c0d02eee:	428b      	cmp	r3, r1
c0d02ef0:	d301      	bcc.n	c0d02ef6 <__aeabi_uidiv+0x82>
c0d02ef2:	028b      	lsls	r3, r1, #10
c0d02ef4:	1ac0      	subs	r0, r0, r3
c0d02ef6:	4152      	adcs	r2, r2
c0d02ef8:	0a43      	lsrs	r3, r0, #9
c0d02efa:	428b      	cmp	r3, r1
c0d02efc:	d301      	bcc.n	c0d02f02 <__aeabi_uidiv+0x8e>
c0d02efe:	024b      	lsls	r3, r1, #9
c0d02f00:	1ac0      	subs	r0, r0, r3
c0d02f02:	4152      	adcs	r2, r2
c0d02f04:	0a03      	lsrs	r3, r0, #8
c0d02f06:	428b      	cmp	r3, r1
c0d02f08:	d301      	bcc.n	c0d02f0e <__aeabi_uidiv+0x9a>
c0d02f0a:	020b      	lsls	r3, r1, #8
c0d02f0c:	1ac0      	subs	r0, r0, r3
c0d02f0e:	4152      	adcs	r2, r2
c0d02f10:	d2cd      	bcs.n	c0d02eae <__aeabi_uidiv+0x3a>
c0d02f12:	09c3      	lsrs	r3, r0, #7
c0d02f14:	428b      	cmp	r3, r1
c0d02f16:	d301      	bcc.n	c0d02f1c <__aeabi_uidiv+0xa8>
c0d02f18:	01cb      	lsls	r3, r1, #7
c0d02f1a:	1ac0      	subs	r0, r0, r3
c0d02f1c:	4152      	adcs	r2, r2
c0d02f1e:	0983      	lsrs	r3, r0, #6
c0d02f20:	428b      	cmp	r3, r1
c0d02f22:	d301      	bcc.n	c0d02f28 <__aeabi_uidiv+0xb4>
c0d02f24:	018b      	lsls	r3, r1, #6
c0d02f26:	1ac0      	subs	r0, r0, r3
c0d02f28:	4152      	adcs	r2, r2
c0d02f2a:	0943      	lsrs	r3, r0, #5
c0d02f2c:	428b      	cmp	r3, r1
c0d02f2e:	d301      	bcc.n	c0d02f34 <__aeabi_uidiv+0xc0>
c0d02f30:	014b      	lsls	r3, r1, #5
c0d02f32:	1ac0      	subs	r0, r0, r3
c0d02f34:	4152      	adcs	r2, r2
c0d02f36:	0903      	lsrs	r3, r0, #4
c0d02f38:	428b      	cmp	r3, r1
c0d02f3a:	d301      	bcc.n	c0d02f40 <__aeabi_uidiv+0xcc>
c0d02f3c:	010b      	lsls	r3, r1, #4
c0d02f3e:	1ac0      	subs	r0, r0, r3
c0d02f40:	4152      	adcs	r2, r2
c0d02f42:	08c3      	lsrs	r3, r0, #3
c0d02f44:	428b      	cmp	r3, r1
c0d02f46:	d301      	bcc.n	c0d02f4c <__aeabi_uidiv+0xd8>
c0d02f48:	00cb      	lsls	r3, r1, #3
c0d02f4a:	1ac0      	subs	r0, r0, r3
c0d02f4c:	4152      	adcs	r2, r2
c0d02f4e:	0883      	lsrs	r3, r0, #2
c0d02f50:	428b      	cmp	r3, r1
c0d02f52:	d301      	bcc.n	c0d02f58 <__aeabi_uidiv+0xe4>
c0d02f54:	008b      	lsls	r3, r1, #2
c0d02f56:	1ac0      	subs	r0, r0, r3
c0d02f58:	4152      	adcs	r2, r2
c0d02f5a:	0843      	lsrs	r3, r0, #1
c0d02f5c:	428b      	cmp	r3, r1
c0d02f5e:	d301      	bcc.n	c0d02f64 <__aeabi_uidiv+0xf0>
c0d02f60:	004b      	lsls	r3, r1, #1
c0d02f62:	1ac0      	subs	r0, r0, r3
c0d02f64:	4152      	adcs	r2, r2
c0d02f66:	1a41      	subs	r1, r0, r1
c0d02f68:	d200      	bcs.n	c0d02f6c <__aeabi_uidiv+0xf8>
c0d02f6a:	4601      	mov	r1, r0
c0d02f6c:	4152      	adcs	r2, r2
c0d02f6e:	4610      	mov	r0, r2
c0d02f70:	4770      	bx	lr
c0d02f72:	e7ff      	b.n	c0d02f74 <__aeabi_uidiv+0x100>
c0d02f74:	b501      	push	{r0, lr}
c0d02f76:	2000      	movs	r0, #0
c0d02f78:	f000 f8f0 	bl	c0d0315c <__aeabi_idiv0>
c0d02f7c:	bd02      	pop	{r1, pc}
c0d02f7e:	46c0      	nop			; (mov r8, r8)

c0d02f80 <__aeabi_uidivmod>:
c0d02f80:	2900      	cmp	r1, #0
c0d02f82:	d0f7      	beq.n	c0d02f74 <__aeabi_uidiv+0x100>
c0d02f84:	e776      	b.n	c0d02e74 <__aeabi_uidiv>
c0d02f86:	4770      	bx	lr

c0d02f88 <__aeabi_idiv>:
c0d02f88:	4603      	mov	r3, r0
c0d02f8a:	430b      	orrs	r3, r1
c0d02f8c:	d47f      	bmi.n	c0d0308e <__aeabi_idiv+0x106>
c0d02f8e:	2200      	movs	r2, #0
c0d02f90:	0843      	lsrs	r3, r0, #1
c0d02f92:	428b      	cmp	r3, r1
c0d02f94:	d374      	bcc.n	c0d03080 <__aeabi_idiv+0xf8>
c0d02f96:	0903      	lsrs	r3, r0, #4
c0d02f98:	428b      	cmp	r3, r1
c0d02f9a:	d35f      	bcc.n	c0d0305c <__aeabi_idiv+0xd4>
c0d02f9c:	0a03      	lsrs	r3, r0, #8
c0d02f9e:	428b      	cmp	r3, r1
c0d02fa0:	d344      	bcc.n	c0d0302c <__aeabi_idiv+0xa4>
c0d02fa2:	0b03      	lsrs	r3, r0, #12
c0d02fa4:	428b      	cmp	r3, r1
c0d02fa6:	d328      	bcc.n	c0d02ffa <__aeabi_idiv+0x72>
c0d02fa8:	0c03      	lsrs	r3, r0, #16
c0d02faa:	428b      	cmp	r3, r1
c0d02fac:	d30d      	bcc.n	c0d02fca <__aeabi_idiv+0x42>
c0d02fae:	22ff      	movs	r2, #255	; 0xff
c0d02fb0:	0209      	lsls	r1, r1, #8
c0d02fb2:	ba12      	rev	r2, r2
c0d02fb4:	0c03      	lsrs	r3, r0, #16
c0d02fb6:	428b      	cmp	r3, r1
c0d02fb8:	d302      	bcc.n	c0d02fc0 <__aeabi_idiv+0x38>
c0d02fba:	1212      	asrs	r2, r2, #8
c0d02fbc:	0209      	lsls	r1, r1, #8
c0d02fbe:	d065      	beq.n	c0d0308c <__aeabi_idiv+0x104>
c0d02fc0:	0b03      	lsrs	r3, r0, #12
c0d02fc2:	428b      	cmp	r3, r1
c0d02fc4:	d319      	bcc.n	c0d02ffa <__aeabi_idiv+0x72>
c0d02fc6:	e000      	b.n	c0d02fca <__aeabi_idiv+0x42>
c0d02fc8:	0a09      	lsrs	r1, r1, #8
c0d02fca:	0bc3      	lsrs	r3, r0, #15
c0d02fcc:	428b      	cmp	r3, r1
c0d02fce:	d301      	bcc.n	c0d02fd4 <__aeabi_idiv+0x4c>
c0d02fd0:	03cb      	lsls	r3, r1, #15
c0d02fd2:	1ac0      	subs	r0, r0, r3
c0d02fd4:	4152      	adcs	r2, r2
c0d02fd6:	0b83      	lsrs	r3, r0, #14
c0d02fd8:	428b      	cmp	r3, r1
c0d02fda:	d301      	bcc.n	c0d02fe0 <__aeabi_idiv+0x58>
c0d02fdc:	038b      	lsls	r3, r1, #14
c0d02fde:	1ac0      	subs	r0, r0, r3
c0d02fe0:	4152      	adcs	r2, r2
c0d02fe2:	0b43      	lsrs	r3, r0, #13
c0d02fe4:	428b      	cmp	r3, r1
c0d02fe6:	d301      	bcc.n	c0d02fec <__aeabi_idiv+0x64>
c0d02fe8:	034b      	lsls	r3, r1, #13
c0d02fea:	1ac0      	subs	r0, r0, r3
c0d02fec:	4152      	adcs	r2, r2
c0d02fee:	0b03      	lsrs	r3, r0, #12
c0d02ff0:	428b      	cmp	r3, r1
c0d02ff2:	d301      	bcc.n	c0d02ff8 <__aeabi_idiv+0x70>
c0d02ff4:	030b      	lsls	r3, r1, #12
c0d02ff6:	1ac0      	subs	r0, r0, r3
c0d02ff8:	4152      	adcs	r2, r2
c0d02ffa:	0ac3      	lsrs	r3, r0, #11
c0d02ffc:	428b      	cmp	r3, r1
c0d02ffe:	d301      	bcc.n	c0d03004 <__aeabi_idiv+0x7c>
c0d03000:	02cb      	lsls	r3, r1, #11
c0d03002:	1ac0      	subs	r0, r0, r3
c0d03004:	4152      	adcs	r2, r2
c0d03006:	0a83      	lsrs	r3, r0, #10
c0d03008:	428b      	cmp	r3, r1
c0d0300a:	d301      	bcc.n	c0d03010 <__aeabi_idiv+0x88>
c0d0300c:	028b      	lsls	r3, r1, #10
c0d0300e:	1ac0      	subs	r0, r0, r3
c0d03010:	4152      	adcs	r2, r2
c0d03012:	0a43      	lsrs	r3, r0, #9
c0d03014:	428b      	cmp	r3, r1
c0d03016:	d301      	bcc.n	c0d0301c <__aeabi_idiv+0x94>
c0d03018:	024b      	lsls	r3, r1, #9
c0d0301a:	1ac0      	subs	r0, r0, r3
c0d0301c:	4152      	adcs	r2, r2
c0d0301e:	0a03      	lsrs	r3, r0, #8
c0d03020:	428b      	cmp	r3, r1
c0d03022:	d301      	bcc.n	c0d03028 <__aeabi_idiv+0xa0>
c0d03024:	020b      	lsls	r3, r1, #8
c0d03026:	1ac0      	subs	r0, r0, r3
c0d03028:	4152      	adcs	r2, r2
c0d0302a:	d2cd      	bcs.n	c0d02fc8 <__aeabi_idiv+0x40>
c0d0302c:	09c3      	lsrs	r3, r0, #7
c0d0302e:	428b      	cmp	r3, r1
c0d03030:	d301      	bcc.n	c0d03036 <__aeabi_idiv+0xae>
c0d03032:	01cb      	lsls	r3, r1, #7
c0d03034:	1ac0      	subs	r0, r0, r3
c0d03036:	4152      	adcs	r2, r2
c0d03038:	0983      	lsrs	r3, r0, #6
c0d0303a:	428b      	cmp	r3, r1
c0d0303c:	d301      	bcc.n	c0d03042 <__aeabi_idiv+0xba>
c0d0303e:	018b      	lsls	r3, r1, #6
c0d03040:	1ac0      	subs	r0, r0, r3
c0d03042:	4152      	adcs	r2, r2
c0d03044:	0943      	lsrs	r3, r0, #5
c0d03046:	428b      	cmp	r3, r1
c0d03048:	d301      	bcc.n	c0d0304e <__aeabi_idiv+0xc6>
c0d0304a:	014b      	lsls	r3, r1, #5
c0d0304c:	1ac0      	subs	r0, r0, r3
c0d0304e:	4152      	adcs	r2, r2
c0d03050:	0903      	lsrs	r3, r0, #4
c0d03052:	428b      	cmp	r3, r1
c0d03054:	d301      	bcc.n	c0d0305a <__aeabi_idiv+0xd2>
c0d03056:	010b      	lsls	r3, r1, #4
c0d03058:	1ac0      	subs	r0, r0, r3
c0d0305a:	4152      	adcs	r2, r2
c0d0305c:	08c3      	lsrs	r3, r0, #3
c0d0305e:	428b      	cmp	r3, r1
c0d03060:	d301      	bcc.n	c0d03066 <__aeabi_idiv+0xde>
c0d03062:	00cb      	lsls	r3, r1, #3
c0d03064:	1ac0      	subs	r0, r0, r3
c0d03066:	4152      	adcs	r2, r2
c0d03068:	0883      	lsrs	r3, r0, #2
c0d0306a:	428b      	cmp	r3, r1
c0d0306c:	d301      	bcc.n	c0d03072 <__aeabi_idiv+0xea>
c0d0306e:	008b      	lsls	r3, r1, #2
c0d03070:	1ac0      	subs	r0, r0, r3
c0d03072:	4152      	adcs	r2, r2
c0d03074:	0843      	lsrs	r3, r0, #1
c0d03076:	428b      	cmp	r3, r1
c0d03078:	d301      	bcc.n	c0d0307e <__aeabi_idiv+0xf6>
c0d0307a:	004b      	lsls	r3, r1, #1
c0d0307c:	1ac0      	subs	r0, r0, r3
c0d0307e:	4152      	adcs	r2, r2
c0d03080:	1a41      	subs	r1, r0, r1
c0d03082:	d200      	bcs.n	c0d03086 <__aeabi_idiv+0xfe>
c0d03084:	4601      	mov	r1, r0
c0d03086:	4152      	adcs	r2, r2
c0d03088:	4610      	mov	r0, r2
c0d0308a:	4770      	bx	lr
c0d0308c:	e05d      	b.n	c0d0314a <__aeabi_idiv+0x1c2>
c0d0308e:	0fca      	lsrs	r2, r1, #31
c0d03090:	d000      	beq.n	c0d03094 <__aeabi_idiv+0x10c>
c0d03092:	4249      	negs	r1, r1
c0d03094:	1003      	asrs	r3, r0, #32
c0d03096:	d300      	bcc.n	c0d0309a <__aeabi_idiv+0x112>
c0d03098:	4240      	negs	r0, r0
c0d0309a:	4053      	eors	r3, r2
c0d0309c:	2200      	movs	r2, #0
c0d0309e:	469c      	mov	ip, r3
c0d030a0:	0903      	lsrs	r3, r0, #4
c0d030a2:	428b      	cmp	r3, r1
c0d030a4:	d32d      	bcc.n	c0d03102 <__aeabi_idiv+0x17a>
c0d030a6:	0a03      	lsrs	r3, r0, #8
c0d030a8:	428b      	cmp	r3, r1
c0d030aa:	d312      	bcc.n	c0d030d2 <__aeabi_idiv+0x14a>
c0d030ac:	22fc      	movs	r2, #252	; 0xfc
c0d030ae:	0189      	lsls	r1, r1, #6
c0d030b0:	ba12      	rev	r2, r2
c0d030b2:	0a03      	lsrs	r3, r0, #8
c0d030b4:	428b      	cmp	r3, r1
c0d030b6:	d30c      	bcc.n	c0d030d2 <__aeabi_idiv+0x14a>
c0d030b8:	0189      	lsls	r1, r1, #6
c0d030ba:	1192      	asrs	r2, r2, #6
c0d030bc:	428b      	cmp	r3, r1
c0d030be:	d308      	bcc.n	c0d030d2 <__aeabi_idiv+0x14a>
c0d030c0:	0189      	lsls	r1, r1, #6
c0d030c2:	1192      	asrs	r2, r2, #6
c0d030c4:	428b      	cmp	r3, r1
c0d030c6:	d304      	bcc.n	c0d030d2 <__aeabi_idiv+0x14a>
c0d030c8:	0189      	lsls	r1, r1, #6
c0d030ca:	d03a      	beq.n	c0d03142 <__aeabi_idiv+0x1ba>
c0d030cc:	1192      	asrs	r2, r2, #6
c0d030ce:	e000      	b.n	c0d030d2 <__aeabi_idiv+0x14a>
c0d030d0:	0989      	lsrs	r1, r1, #6
c0d030d2:	09c3      	lsrs	r3, r0, #7
c0d030d4:	428b      	cmp	r3, r1
c0d030d6:	d301      	bcc.n	c0d030dc <__aeabi_idiv+0x154>
c0d030d8:	01cb      	lsls	r3, r1, #7
c0d030da:	1ac0      	subs	r0, r0, r3
c0d030dc:	4152      	adcs	r2, r2
c0d030de:	0983      	lsrs	r3, r0, #6
c0d030e0:	428b      	cmp	r3, r1
c0d030e2:	d301      	bcc.n	c0d030e8 <__aeabi_idiv+0x160>
c0d030e4:	018b      	lsls	r3, r1, #6
c0d030e6:	1ac0      	subs	r0, r0, r3
c0d030e8:	4152      	adcs	r2, r2
c0d030ea:	0943      	lsrs	r3, r0, #5
c0d030ec:	428b      	cmp	r3, r1
c0d030ee:	d301      	bcc.n	c0d030f4 <__aeabi_idiv+0x16c>
c0d030f0:	014b      	lsls	r3, r1, #5
c0d030f2:	1ac0      	subs	r0, r0, r3
c0d030f4:	4152      	adcs	r2, r2
c0d030f6:	0903      	lsrs	r3, r0, #4
c0d030f8:	428b      	cmp	r3, r1
c0d030fa:	d301      	bcc.n	c0d03100 <__aeabi_idiv+0x178>
c0d030fc:	010b      	lsls	r3, r1, #4
c0d030fe:	1ac0      	subs	r0, r0, r3
c0d03100:	4152      	adcs	r2, r2
c0d03102:	08c3      	lsrs	r3, r0, #3
c0d03104:	428b      	cmp	r3, r1
c0d03106:	d301      	bcc.n	c0d0310c <__aeabi_idiv+0x184>
c0d03108:	00cb      	lsls	r3, r1, #3
c0d0310a:	1ac0      	subs	r0, r0, r3
c0d0310c:	4152      	adcs	r2, r2
c0d0310e:	0883      	lsrs	r3, r0, #2
c0d03110:	428b      	cmp	r3, r1
c0d03112:	d301      	bcc.n	c0d03118 <__aeabi_idiv+0x190>
c0d03114:	008b      	lsls	r3, r1, #2
c0d03116:	1ac0      	subs	r0, r0, r3
c0d03118:	4152      	adcs	r2, r2
c0d0311a:	d2d9      	bcs.n	c0d030d0 <__aeabi_idiv+0x148>
c0d0311c:	0843      	lsrs	r3, r0, #1
c0d0311e:	428b      	cmp	r3, r1
c0d03120:	d301      	bcc.n	c0d03126 <__aeabi_idiv+0x19e>
c0d03122:	004b      	lsls	r3, r1, #1
c0d03124:	1ac0      	subs	r0, r0, r3
c0d03126:	4152      	adcs	r2, r2
c0d03128:	1a41      	subs	r1, r0, r1
c0d0312a:	d200      	bcs.n	c0d0312e <__aeabi_idiv+0x1a6>
c0d0312c:	4601      	mov	r1, r0
c0d0312e:	4663      	mov	r3, ip
c0d03130:	4152      	adcs	r2, r2
c0d03132:	105b      	asrs	r3, r3, #1
c0d03134:	4610      	mov	r0, r2
c0d03136:	d301      	bcc.n	c0d0313c <__aeabi_idiv+0x1b4>
c0d03138:	4240      	negs	r0, r0
c0d0313a:	2b00      	cmp	r3, #0
c0d0313c:	d500      	bpl.n	c0d03140 <__aeabi_idiv+0x1b8>
c0d0313e:	4249      	negs	r1, r1
c0d03140:	4770      	bx	lr
c0d03142:	4663      	mov	r3, ip
c0d03144:	105b      	asrs	r3, r3, #1
c0d03146:	d300      	bcc.n	c0d0314a <__aeabi_idiv+0x1c2>
c0d03148:	4240      	negs	r0, r0
c0d0314a:	b501      	push	{r0, lr}
c0d0314c:	2000      	movs	r0, #0
c0d0314e:	f000 f805 	bl	c0d0315c <__aeabi_idiv0>
c0d03152:	bd02      	pop	{r1, pc}

c0d03154 <__aeabi_idivmod>:
c0d03154:	2900      	cmp	r1, #0
c0d03156:	d0f8      	beq.n	c0d0314a <__aeabi_idiv+0x1c2>
c0d03158:	e716      	b.n	c0d02f88 <__aeabi_idiv>
c0d0315a:	4770      	bx	lr

c0d0315c <__aeabi_idiv0>:
c0d0315c:	4770      	bx	lr
c0d0315e:	46c0      	nop			; (mov r8, r8)

c0d03160 <__aeabi_memclr>:
c0d03160:	b510      	push	{r4, lr}
c0d03162:	2200      	movs	r2, #0
c0d03164:	f000 f806 	bl	c0d03174 <__aeabi_memset>
c0d03168:	bd10      	pop	{r4, pc}
c0d0316a:	46c0      	nop			; (mov r8, r8)

c0d0316c <__aeabi_memcpy>:
c0d0316c:	b510      	push	{r4, lr}
c0d0316e:	f000 f809 	bl	c0d03184 <memcpy>
c0d03172:	bd10      	pop	{r4, pc}

c0d03174 <__aeabi_memset>:
c0d03174:	0013      	movs	r3, r2
c0d03176:	b510      	push	{r4, lr}
c0d03178:	000a      	movs	r2, r1
c0d0317a:	0019      	movs	r1, r3
c0d0317c:	f000 f840 	bl	c0d03200 <memset>
c0d03180:	bd10      	pop	{r4, pc}
c0d03182:	46c0      	nop			; (mov r8, r8)

c0d03184 <memcpy>:
c0d03184:	b570      	push	{r4, r5, r6, lr}
c0d03186:	2a0f      	cmp	r2, #15
c0d03188:	d932      	bls.n	c0d031f0 <memcpy+0x6c>
c0d0318a:	000c      	movs	r4, r1
c0d0318c:	4304      	orrs	r4, r0
c0d0318e:	000b      	movs	r3, r1
c0d03190:	07a4      	lsls	r4, r4, #30
c0d03192:	d131      	bne.n	c0d031f8 <memcpy+0x74>
c0d03194:	0015      	movs	r5, r2
c0d03196:	0004      	movs	r4, r0
c0d03198:	3d10      	subs	r5, #16
c0d0319a:	092d      	lsrs	r5, r5, #4
c0d0319c:	3501      	adds	r5, #1
c0d0319e:	012d      	lsls	r5, r5, #4
c0d031a0:	1949      	adds	r1, r1, r5
c0d031a2:	681e      	ldr	r6, [r3, #0]
c0d031a4:	6026      	str	r6, [r4, #0]
c0d031a6:	685e      	ldr	r6, [r3, #4]
c0d031a8:	6066      	str	r6, [r4, #4]
c0d031aa:	689e      	ldr	r6, [r3, #8]
c0d031ac:	60a6      	str	r6, [r4, #8]
c0d031ae:	68de      	ldr	r6, [r3, #12]
c0d031b0:	3310      	adds	r3, #16
c0d031b2:	60e6      	str	r6, [r4, #12]
c0d031b4:	3410      	adds	r4, #16
c0d031b6:	4299      	cmp	r1, r3
c0d031b8:	d1f3      	bne.n	c0d031a2 <memcpy+0x1e>
c0d031ba:	230f      	movs	r3, #15
c0d031bc:	1945      	adds	r5, r0, r5
c0d031be:	4013      	ands	r3, r2
c0d031c0:	2b03      	cmp	r3, #3
c0d031c2:	d91b      	bls.n	c0d031fc <memcpy+0x78>
c0d031c4:	1f1c      	subs	r4, r3, #4
c0d031c6:	2300      	movs	r3, #0
c0d031c8:	08a4      	lsrs	r4, r4, #2
c0d031ca:	3401      	adds	r4, #1
c0d031cc:	00a4      	lsls	r4, r4, #2
c0d031ce:	58ce      	ldr	r6, [r1, r3]
c0d031d0:	50ee      	str	r6, [r5, r3]
c0d031d2:	3304      	adds	r3, #4
c0d031d4:	429c      	cmp	r4, r3
c0d031d6:	d1fa      	bne.n	c0d031ce <memcpy+0x4a>
c0d031d8:	2303      	movs	r3, #3
c0d031da:	192d      	adds	r5, r5, r4
c0d031dc:	1909      	adds	r1, r1, r4
c0d031de:	401a      	ands	r2, r3
c0d031e0:	d005      	beq.n	c0d031ee <memcpy+0x6a>
c0d031e2:	2300      	movs	r3, #0
c0d031e4:	5ccc      	ldrb	r4, [r1, r3]
c0d031e6:	54ec      	strb	r4, [r5, r3]
c0d031e8:	3301      	adds	r3, #1
c0d031ea:	429a      	cmp	r2, r3
c0d031ec:	d1fa      	bne.n	c0d031e4 <memcpy+0x60>
c0d031ee:	bd70      	pop	{r4, r5, r6, pc}
c0d031f0:	0005      	movs	r5, r0
c0d031f2:	2a00      	cmp	r2, #0
c0d031f4:	d1f5      	bne.n	c0d031e2 <memcpy+0x5e>
c0d031f6:	e7fa      	b.n	c0d031ee <memcpy+0x6a>
c0d031f8:	0005      	movs	r5, r0
c0d031fa:	e7f2      	b.n	c0d031e2 <memcpy+0x5e>
c0d031fc:	001a      	movs	r2, r3
c0d031fe:	e7f8      	b.n	c0d031f2 <memcpy+0x6e>

c0d03200 <memset>:
c0d03200:	b570      	push	{r4, r5, r6, lr}
c0d03202:	0783      	lsls	r3, r0, #30
c0d03204:	d03f      	beq.n	c0d03286 <memset+0x86>
c0d03206:	1e54      	subs	r4, r2, #1
c0d03208:	2a00      	cmp	r2, #0
c0d0320a:	d03b      	beq.n	c0d03284 <memset+0x84>
c0d0320c:	b2ce      	uxtb	r6, r1
c0d0320e:	0003      	movs	r3, r0
c0d03210:	2503      	movs	r5, #3
c0d03212:	e003      	b.n	c0d0321c <memset+0x1c>
c0d03214:	1e62      	subs	r2, r4, #1
c0d03216:	2c00      	cmp	r4, #0
c0d03218:	d034      	beq.n	c0d03284 <memset+0x84>
c0d0321a:	0014      	movs	r4, r2
c0d0321c:	3301      	adds	r3, #1
c0d0321e:	1e5a      	subs	r2, r3, #1
c0d03220:	7016      	strb	r6, [r2, #0]
c0d03222:	422b      	tst	r3, r5
c0d03224:	d1f6      	bne.n	c0d03214 <memset+0x14>
c0d03226:	2c03      	cmp	r4, #3
c0d03228:	d924      	bls.n	c0d03274 <memset+0x74>
c0d0322a:	25ff      	movs	r5, #255	; 0xff
c0d0322c:	400d      	ands	r5, r1
c0d0322e:	022a      	lsls	r2, r5, #8
c0d03230:	4315      	orrs	r5, r2
c0d03232:	042a      	lsls	r2, r5, #16
c0d03234:	4315      	orrs	r5, r2
c0d03236:	2c0f      	cmp	r4, #15
c0d03238:	d911      	bls.n	c0d0325e <memset+0x5e>
c0d0323a:	0026      	movs	r6, r4
c0d0323c:	3e10      	subs	r6, #16
c0d0323e:	0936      	lsrs	r6, r6, #4
c0d03240:	3601      	adds	r6, #1
c0d03242:	0136      	lsls	r6, r6, #4
c0d03244:	001a      	movs	r2, r3
c0d03246:	199b      	adds	r3, r3, r6
c0d03248:	6015      	str	r5, [r2, #0]
c0d0324a:	6055      	str	r5, [r2, #4]
c0d0324c:	6095      	str	r5, [r2, #8]
c0d0324e:	60d5      	str	r5, [r2, #12]
c0d03250:	3210      	adds	r2, #16
c0d03252:	4293      	cmp	r3, r2
c0d03254:	d1f8      	bne.n	c0d03248 <memset+0x48>
c0d03256:	220f      	movs	r2, #15
c0d03258:	4014      	ands	r4, r2
c0d0325a:	2c03      	cmp	r4, #3
c0d0325c:	d90a      	bls.n	c0d03274 <memset+0x74>
c0d0325e:	1f26      	subs	r6, r4, #4
c0d03260:	08b6      	lsrs	r6, r6, #2
c0d03262:	3601      	adds	r6, #1
c0d03264:	00b6      	lsls	r6, r6, #2
c0d03266:	001a      	movs	r2, r3
c0d03268:	199b      	adds	r3, r3, r6
c0d0326a:	c220      	stmia	r2!, {r5}
c0d0326c:	4293      	cmp	r3, r2
c0d0326e:	d1fc      	bne.n	c0d0326a <memset+0x6a>
c0d03270:	2203      	movs	r2, #3
c0d03272:	4014      	ands	r4, r2
c0d03274:	2c00      	cmp	r4, #0
c0d03276:	d005      	beq.n	c0d03284 <memset+0x84>
c0d03278:	b2c9      	uxtb	r1, r1
c0d0327a:	191c      	adds	r4, r3, r4
c0d0327c:	7019      	strb	r1, [r3, #0]
c0d0327e:	3301      	adds	r3, #1
c0d03280:	429c      	cmp	r4, r3
c0d03282:	d1fb      	bne.n	c0d0327c <memset+0x7c>
c0d03284:	bd70      	pop	{r4, r5, r6, pc}
c0d03286:	0014      	movs	r4, r2
c0d03288:	0003      	movs	r3, r0
c0d0328a:	e7cc      	b.n	c0d03226 <memset+0x26>

c0d0328c <setjmp>:
c0d0328c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0328e:	4641      	mov	r1, r8
c0d03290:	464a      	mov	r2, r9
c0d03292:	4653      	mov	r3, sl
c0d03294:	465c      	mov	r4, fp
c0d03296:	466d      	mov	r5, sp
c0d03298:	4676      	mov	r6, lr
c0d0329a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d0329c:	3828      	subs	r0, #40	; 0x28
c0d0329e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d032a0:	2000      	movs	r0, #0
c0d032a2:	4770      	bx	lr

c0d032a4 <longjmp>:
c0d032a4:	3010      	adds	r0, #16
c0d032a6:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d032a8:	4690      	mov	r8, r2
c0d032aa:	4699      	mov	r9, r3
c0d032ac:	46a2      	mov	sl, r4
c0d032ae:	46ab      	mov	fp, r5
c0d032b0:	46b5      	mov	sp, r6
c0d032b2:	c808      	ldmia	r0!, {r3}
c0d032b4:	3828      	subs	r0, #40	; 0x28
c0d032b6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d032b8:	1c08      	adds	r0, r1, #0
c0d032ba:	d100      	bne.n	c0d032be <longjmp+0x1a>
c0d032bc:	2001      	movs	r0, #1
c0d032be:	4718      	bx	r3

c0d032c0 <strlen>:
c0d032c0:	b510      	push	{r4, lr}
c0d032c2:	0783      	lsls	r3, r0, #30
c0d032c4:	d027      	beq.n	c0d03316 <strlen+0x56>
c0d032c6:	7803      	ldrb	r3, [r0, #0]
c0d032c8:	2b00      	cmp	r3, #0
c0d032ca:	d026      	beq.n	c0d0331a <strlen+0x5a>
c0d032cc:	0003      	movs	r3, r0
c0d032ce:	2103      	movs	r1, #3
c0d032d0:	e002      	b.n	c0d032d8 <strlen+0x18>
c0d032d2:	781a      	ldrb	r2, [r3, #0]
c0d032d4:	2a00      	cmp	r2, #0
c0d032d6:	d01c      	beq.n	c0d03312 <strlen+0x52>
c0d032d8:	3301      	adds	r3, #1
c0d032da:	420b      	tst	r3, r1
c0d032dc:	d1f9      	bne.n	c0d032d2 <strlen+0x12>
c0d032de:	6819      	ldr	r1, [r3, #0]
c0d032e0:	4a0f      	ldr	r2, [pc, #60]	; (c0d03320 <strlen+0x60>)
c0d032e2:	4c10      	ldr	r4, [pc, #64]	; (c0d03324 <strlen+0x64>)
c0d032e4:	188a      	adds	r2, r1, r2
c0d032e6:	438a      	bics	r2, r1
c0d032e8:	4222      	tst	r2, r4
c0d032ea:	d10f      	bne.n	c0d0330c <strlen+0x4c>
c0d032ec:	3304      	adds	r3, #4
c0d032ee:	6819      	ldr	r1, [r3, #0]
c0d032f0:	4a0b      	ldr	r2, [pc, #44]	; (c0d03320 <strlen+0x60>)
c0d032f2:	188a      	adds	r2, r1, r2
c0d032f4:	438a      	bics	r2, r1
c0d032f6:	4222      	tst	r2, r4
c0d032f8:	d108      	bne.n	c0d0330c <strlen+0x4c>
c0d032fa:	3304      	adds	r3, #4
c0d032fc:	6819      	ldr	r1, [r3, #0]
c0d032fe:	4a08      	ldr	r2, [pc, #32]	; (c0d03320 <strlen+0x60>)
c0d03300:	188a      	adds	r2, r1, r2
c0d03302:	438a      	bics	r2, r1
c0d03304:	4222      	tst	r2, r4
c0d03306:	d0f1      	beq.n	c0d032ec <strlen+0x2c>
c0d03308:	e000      	b.n	c0d0330c <strlen+0x4c>
c0d0330a:	3301      	adds	r3, #1
c0d0330c:	781a      	ldrb	r2, [r3, #0]
c0d0330e:	2a00      	cmp	r2, #0
c0d03310:	d1fb      	bne.n	c0d0330a <strlen+0x4a>
c0d03312:	1a18      	subs	r0, r3, r0
c0d03314:	bd10      	pop	{r4, pc}
c0d03316:	0003      	movs	r3, r0
c0d03318:	e7e1      	b.n	c0d032de <strlen+0x1e>
c0d0331a:	2000      	movs	r0, #0
c0d0331c:	e7fa      	b.n	c0d03314 <strlen+0x54>
c0d0331e:	46c0      	nop			; (mov r8, r8)
c0d03320:	fefefeff 	.word	0xfefefeff
c0d03324:	80808080 	.word	0x80808080
c0d03328:	45544550 	.word	0x45544550
c0d0332c:	54455052 	.word	0x54455052
c0d03330:	45505245 	.word	0x45505245
c0d03334:	50524554 	.word	0x50524554
c0d03338:	52455445 	.word	0x52455445
c0d0333c:	45544550 	.word	0x45544550
c0d03340:	54455052 	.word	0x54455052
c0d03344:	45505245 	.word	0x45505245
c0d03348:	50524554 	.word	0x50524554
c0d0334c:	52455445 	.word	0x52455445
c0d03350:	45544550 	.word	0x45544550
c0d03354:	54455052 	.word	0x54455052
c0d03358:	45505245 	.word	0x45505245
c0d0335c:	50524554 	.word	0x50524554
c0d03360:	52455445 	.word	0x52455445
c0d03364:	45544550 	.word	0x45544550
c0d03368:	54455052 	.word	0x54455052
c0d0336c:	45505245 	.word	0x45505245
c0d03370:	50524554 	.word	0x50524554
c0d03374:	52455445 	.word	0x52455445
c0d03378:	00000052 	.word	0x00000052

c0d0337c <trits_mapping>:
c0d0337c:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d0338c:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d0339c:	00ff0100 000000ff 00010000 0001ff00     ................
c0d033ac:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d033bc:	00000100 01000101 000101ff 01010101     ................
c0d033cc:	00000001                                ....

c0d033d0 <HALF_3>:
c0d033d0:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d033e0:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d033f0:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d03400 <bagl_ui_nanos_screen1>:
c0d03400:	00000003 00800000 00000020 00000001     ........ .......
c0d03410:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03438:	00000107 0080000c 00000020 00000000     ........ .......
c0d03448:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03470:	00030005 0007000c 00000007 00000000     ................
	...
c0d03488:	00070000 00000000 00000000 00000000     ................
	...
c0d034a8:	00750005 0008000d 00000006 00000000     ..u.............
c0d034b8:	00ffffff 00000000 00060000 00000000     ................
	...

c0d034e0 <bagl_ui_nanos_screen2>:
c0d034e0:	00000003 00800000 00000020 00000001     ........ .......
c0d034f0:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03518:	00000107 00800012 00000020 00000000     ........ .......
c0d03528:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03550:	00030005 0007000c 00000007 00000000     ................
	...
c0d03568:	00070000 00000000 00000000 00000000     ................
	...
c0d03588:	00750005 0008000d 00000006 00000000     ..u.............
c0d03598:	00ffffff 00000000 00060000 00000000     ................
	...

c0d035c0 <bagl_ui_sample_blue>:
c0d035c0:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d035d0:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d035f8:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03608:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03630:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03640:	00ffffff 001d2028 00002004 c0d036a0     ....( ... ...6..
	...
c0d03668:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03678:	0041ccb4 00f9f9f9 0000a004 c0d036ac     ..A..........6..
c0d03688:	00000000 0037ae99 00f9f9f9 c0d02145     ......7.....E!..
	...
c0d036a0:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d036b1 <USBD_PRODUCT_FS_STRING>:
c0d036b1:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d036bf <HID_ReportDesc>:
c0d036bf:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d036cf:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d036df:	0000c008 11210900                                .....

c0d036e4 <USBD_HID_Desc>:
c0d036e4:	01112109 22220100 00011200                       .!...."".

c0d036ed <USBD_DeviceDesc>:
c0d036ed:	02000112 40000000 00012c97 02010200     .......@.,......
c0d036fd:	55000103                                         ...

c0d03700 <HID_Desc>:
c0d03700:	c0d02d55 c0d02d65 c0d02d75 c0d02d85     U-..e-..u-...-..
c0d03710:	c0d02d95 c0d02da5 c0d02db5 00000000     .-...-...-......

c0d03720 <USBD_LangIDDesc>:
c0d03720:	04090304                                ....

c0d03724 <USBD_MANUFACTURER_STRING>:
c0d03724:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03732 <USB_SERIAL_STRING>:
c0d03732:	0030030a 00300030 2c370031                       ..0.0.0.1.

c0d0373c <USBD_HID>:
c0d0373c:	c0d02c37 c0d02c69 c0d02b9b 00000000     7,..i,...+......
	...
c0d03754:	c0d02ca1 00000000 00000000 00000000     .,..............
c0d03764:	c0d02dc5 c0d02dc5 c0d02dc5 c0d02dd5     .-...-...-...-..

c0d03774 <USBD_CfgDesc>:
c0d03774:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03784:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03794:	05070100 00400302 00000001              ......@.....

c0d037a0 <USBD_DeviceQualifierDesc>:
c0d037a0:	0200060a 40000000 00000001              .......@....

c0d037ac <_etext>:
	...

c0d037c0 <N_storage_real>:
	...
