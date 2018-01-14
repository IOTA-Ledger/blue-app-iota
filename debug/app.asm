
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
c0d00014:	f000 febe 	bl	c0d00d94 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fe0a 	bl	c0d00c30 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f991 	bl	c0d0334c <setjmp>
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
c0d00040:	f001 f84e 	bl	c0d010e0 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fd2f 	bl	c0d01aa8 <pic>
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
c0d0005a:	f001 fd25 	bl	c0d01aa8 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fd73 	bl	c0d01b4c <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fe7a 	bl	c0d02d60 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fe77 	bl	c0d02d60 <USB_power>

            ui_idle();
c0d00072:	f002 f80b 	bl	c0d0208c <ui_idle>

            IOTA_main();
c0d00076:	f000 fc73 	bl	c0d00960 <IOTA_main>
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
c0d0008c:	f003 f96a 	bl	c0d03364 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03880 	.word	0xc0d03880

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
c0d000ca:	f001 fa9d 	bl	c0d01608 <snprintf>
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
c0d00192:	f002 ff2d 	bl	c0d02ff0 <__aeabi_idiv>
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
c0d001c0:	f002 fe8c 	bl	c0d02edc <__aeabi_uidiv>
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
c0d001e6:	f000 fa07 	bl	c0d005f8 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001ea:	f000 fa05 	bl	c0d005f8 <kerl_initialize>
c0d001ee:	ac04      	add	r4, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001f0:	4620      	mov	r0, r4
c0d001f2:	4629      	mov	r1, r5
c0d001f4:	4632      	mov	r2, r6
c0d001f6:	f003 f819 	bl	c0d0322c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001fa:	19a0      	adds	r0, r4, r6
c0d001fc:	2530      	movs	r5, #48	; 0x30
c0d001fe:	1baa      	subs	r2, r5, r6
c0d00200:	9902      	ldr	r1, [sp, #8]
c0d00202:	f003 f813 	bl	c0d0322c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00206:	4620      	mov	r0, r4
c0d00208:	4629      	mov	r1, r5
c0d0020a:	f000 fa01 	bl	c0d00610 <kerl_absorb_bytes>
c0d0020e:	ae41      	add	r6, sp, #260	; 0x104
c0d00210:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00212:	4630      	mov	r0, r6
c0d00214:	4629      	mov	r1, r5
c0d00216:	f003 f803 	bl	c0d03220 <__aeabi_memclr>
c0d0021a:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021c:	4919      	ldr	r1, [pc, #100]	; (c0d00284 <get_seed+0xac>)
c0d0021e:	4479      	add	r1, pc
c0d00220:	2252      	movs	r2, #82	; 0x52
c0d00222:	4620      	mov	r0, r4
c0d00224:	f003 f802 	bl	c0d0322c <__aeabi_memcpy>
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
c0d00238:	f002 fff2 	bl	c0d03220 <__aeabi_memclr>
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
c0d0026a:	f001 f9cd 	bl	c0d01608 <snprintf>
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
c0d00284:	000031c6 	.word	0x000031c6

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
c0d0041c:	0000304a 	.word	0x0000304a

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
c0d00450:	b0a5      	sub	sp, #148	; 0x94
c0d00452:	9100      	str	r1, [sp, #0]
c0d00454:	9001      	str	r0, [sp, #4]
c0d00456:	a819      	add	r0, sp, #100	; 0x64
    int32_t size = 12;
    int32_t base[12] = {0};
c0d00458:	2130      	movs	r1, #48	; 0x30
c0d0045a:	f002 fee1 	bl	c0d03220 <__aeabi_memclr>
c0d0045e:	260c      	movs	r6, #12
c0d00460:	2031      	movs	r0, #49	; 0x31
    trit_t trits[5]; // on final call only left 3 trits matter
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 49; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 49) ? 3 : 5;
c0d00462:	2503      	movs	r5, #3
c0d00464:	4601      	mov	r1, r0
c0d00466:	2005      	movs	r0, #5
c0d00468:	9102      	str	r1, [sp, #8]
c0d0046a:	2931      	cmp	r1, #49	; 0x31
c0d0046c:	d000      	beq.n	c0d00470 <trints_to_words+0x24>
c0d0046e:	4605      	mov	r5, r0
        trint_to_trits(trints_in[x], trits, get);
c0d00470:	9801      	ldr	r0, [sp, #4]
c0d00472:	9c02      	ldr	r4, [sp, #8]
c0d00474:	5700      	ldrsb	r0, [r0, r4]
c0d00476:	a917      	add	r1, sp, #92	; 0x5c
c0d00478:	462a      	mov	r2, r5
c0d0047a:	f7ff fe75 	bl	c0d00168 <trint_to_trits>
c0d0047e:	2001      	movs	r0, #1
c0d00480:	9005      	str	r0, [sp, #20]
c0d00482:	2000      	movs	r0, #0
c0d00484:	2c31      	cmp	r4, #49	; 0x31
c0d00486:	d100      	bne.n	c0d0048a <trints_to_words+0x3e>
c0d00488:	9005      	str	r0, [sp, #20]

        // array index is get - 1
        for (int8_t i = get - 1; i >= 0; i--) {
c0d0048a:	462b      	mov	r3, r5
c0d0048c:	33ff      	adds	r3, #255	; 0xff
c0d0048e:	2406      	movs	r4, #6
c0d00490:	401c      	ands	r4, r3
c0d00492:	1e6d      	subs	r5, r5, #1
            if(i == 2 && x == 49) {
c0d00494:	b2ea      	uxtb	r2, r5
c0d00496:	2001      	movs	r0, #1
c0d00498:	2100      	movs	r1, #0
c0d0049a:	2a02      	cmp	r2, #2
c0d0049c:	d100      	bne.n	c0d004a0 <trints_to_words+0x54>
c0d0049e:	4608      	mov	r0, r1
c0d004a0:	9905      	ldr	r1, [sp, #20]
c0d004a2:	4308      	orrs	r0, r1
c0d004a4:	2800      	cmp	r0, #0
c0d004a6:	9506      	str	r5, [sp, #24]
c0d004a8:	d040      	beq.n	c0d0052c <trints_to_words+0xe0>
c0d004aa:	9304      	str	r3, [sp, #16]
            // multiply
            int32_t sz = size;
            {
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
c0d004ac:	2e01      	cmp	r6, #1
c0d004ae:	4630      	mov	r0, r6
c0d004b0:	db24      	blt.n	c0d004fc <trints_to_words+0xb0>
c0d004b2:	9403      	str	r4, [sp, #12]
c0d004b4:	2000      	movs	r0, #0
c0d004b6:	4604      	mov	r4, r0
c0d004b8:	9608      	str	r6, [sp, #32]
c0d004ba:	9007      	str	r0, [sp, #28]
c0d004bc:	4606      	mov	r6, r0
                  int64_t v = ((int64_t)base[j]&0xFFFFFFFF) * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
c0d004be:	00a1      	lsls	r1, r4, #2
c0d004c0:	9109      	str	r1, [sp, #36]	; 0x24
c0d004c2:	a819      	add	r0, sp, #100	; 0x64
c0d004c4:	900a      	str	r0, [sp, #40]	; 0x28
c0d004c6:	5840      	ldr	r0, [r0, r1]
c0d004c8:	2203      	movs	r2, #3
c0d004ca:	9d07      	ldr	r5, [sp, #28]
c0d004cc:	4629      	mov	r1, r5
c0d004ce:	462b      	mov	r3, r5
c0d004d0:	f002 fe7a 	bl	c0d031c8 <__aeabi_lmul>
c0d004d4:	1980      	adds	r0, r0, r6
c0d004d6:	4169      	adcs	r1, r5
                   carry = (int32_t)((v >> 32) & 0xFFFFFFFF);
                   base[j] = (int32_t) (v & 0xFFFFFFFF);
c0d004d8:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d004da:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d004dc:	50d0      	str	r0, [r2, r3]
            // multiply
            int32_t sz = size;
            {
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
c0d004de:	1c64      	adds	r4, r4, #1
c0d004e0:	9808      	ldr	r0, [sp, #32]
c0d004e2:	42a0      	cmp	r0, r4
c0d004e4:	460e      	mov	r6, r1
c0d004e6:	d1ea      	bne.n	c0d004be <trints_to_words+0x72>
                  int64_t v = ((int64_t)base[j]&0xFFFFFFFF) * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
                   carry = (int32_t)((v >> 32) & 0xFFFFFFFF);
                   base[j] = (int32_t) (v & 0xFFFFFFFF);
                }

                if (carry > 0) {
c0d004e8:	2900      	cmp	r1, #0
c0d004ea:	9a08      	ldr	r2, [sp, #32]
c0d004ec:	4610      	mov	r0, r2
c0d004ee:	4616      	mov	r6, r2
c0d004f0:	9c03      	ldr	r4, [sp, #12]
c0d004f2:	d003      	beq.n	c0d004fc <trints_to_words+0xb0>
                  base[sz] = carry;
c0d004f4:	00b0      	lsls	r0, r6, #2
c0d004f6:	aa19      	add	r2, sp, #100	; 0x64
c0d004f8:	5011      	str	r1, [r2, r0]
                  size++;
c0d004fa:	1c70      	adds	r0, r6, #1
c0d004fc:	900a      	str	r0, [sp, #40]	; 0x28
c0d004fe:	a817      	add	r0, sp, #92	; 0x5c
            }

            // add
            {
                int32_t tmp[12];
                bigint_add_int(base, trits[i]+1, tmp, 12);
c0d00500:	5700      	ldrsb	r0, [r0, r4]
c0d00502:	1c41      	adds	r1, r0, #1
c0d00504:	ac19      	add	r4, sp, #100	; 0x64
c0d00506:	ad0b      	add	r5, sp, #44	; 0x2c
c0d00508:	230c      	movs	r3, #12
c0d0050a:	4620      	mov	r0, r4
c0d0050c:	462a      	mov	r2, r5
c0d0050e:	f7ff febb 	bl	c0d00288 <bigint_add_int>
                memcpy(base, tmp, 48);
c0d00512:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00514:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d00516:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00518:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d0051a:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d0051c:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d0051e:	980a      	ldr	r0, [sp, #40]	; 0x28
                if (sz > size) {
c0d00520:	4286      	cmp	r6, r0
c0d00522:	dc00      	bgt.n	c0d00526 <trints_to_words+0xda>
c0d00524:	4606      	mov	r6, r0
c0d00526:	9d06      	ldr	r5, [sp, #24]
c0d00528:	9804      	ldr	r0, [sp, #16]
c0d0052a:	e012      	b.n	c0d00552 <trints_to_words+0x106>
c0d0052c:	ac19      	add	r4, sp, #100	; 0x64
        // array index is get - 1
        for (int8_t i = get - 1; i >= 0; i--) {
            if(i == 2 && x == 49) {
              // Ignore the last trit
              int32_t tmp[12];
              bigint_add_int(base, 1, tmp, 12);
c0d0052e:	2101      	movs	r1, #1
c0d00530:	9608      	str	r6, [sp, #32]
c0d00532:	ad0b      	add	r5, sp, #44	; 0x2c
c0d00534:	461e      	mov	r6, r3
c0d00536:	230c      	movs	r3, #12
c0d00538:	4620      	mov	r0, r4
c0d0053a:	462a      	mov	r2, r5
c0d0053c:	f7ff fea4 	bl	c0d00288 <bigint_add_int>
              memcpy(base, tmp, 48);          
c0d00540:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00542:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d00544:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00546:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d00548:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d0054a:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d0054c:	4630      	mov	r0, r6
c0d0054e:	9d06      	ldr	r5, [sp, #24]
c0d00550:	9e08      	ldr	r6, [sp, #32]
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 49) ? 3 : 5;
        trint_to_trits(trints_in[x], trits, get);

        // array index is get - 1
        for (int8_t i = get - 1; i >= 0; i--) {
c0d00552:	1e40      	subs	r0, r0, #1
c0d00554:	b244      	sxtb	r4, r0
c0d00556:	2c00      	cmp	r4, #0
c0d00558:	4623      	mov	r3, r4
c0d0055a:	da9a      	bge.n	c0d00492 <trints_to_words+0x46>
c0d0055c:	9902      	ldr	r1, [sp, #8]
    int32_t size = 12;
    int32_t base[12] = {0};
    trit_t trits[5]; // on final call only left 3 trits matter
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 49; x >= 0; x--) {
c0d0055e:	1e48      	subs	r0, r1, #1
c0d00560:	2900      	cmp	r1, #0
c0d00562:	dd00      	ble.n	c0d00566 <trints_to_words+0x11a>
c0d00564:	e77d      	b.n	c0d00462 <trints_to_words+0x16>
                }
            }
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 12) <= 0 ) {
c0d00566:	4821      	ldr	r0, [pc, #132]	; (c0d005ec <trints_to_words+0x1a0>)
c0d00568:	4478      	add	r0, pc
c0d0056a:	a919      	add	r1, sp, #100	; 0x64
c0d0056c:	220c      	movs	r2, #12
c0d0056e:	f7ff ff11 	bl	c0d00394 <bigint_cmp_bigint>
c0d00572:	2801      	cmp	r0, #1
c0d00574:	db14      	blt.n	c0d005a0 <trints_to_words+0x154>
        int32_t tmp[12];
        bigint_sub_bigint(base, HALF_3, tmp, 12);
        memcpy(base, tmp, 48);
    } else {
        int32_t tmp[12];
        bigint_sub_bigint(HALF_3, base, tmp, 12);
c0d00576:	481f      	ldr	r0, [pc, #124]	; (c0d005f4 <trints_to_words+0x1a8>)
c0d00578:	4478      	add	r0, pc
c0d0057a:	ac19      	add	r4, sp, #100	; 0x64
c0d0057c:	ae0b      	add	r6, sp, #44	; 0x2c
c0d0057e:	250c      	movs	r5, #12
c0d00580:	4621      	mov	r1, r4
c0d00582:	4632      	mov	r2, r6
c0d00584:	462b      	mov	r3, r5
c0d00586:	f7ff fec4 	bl	c0d00312 <bigint_sub_bigint>
        bigint_not(tmp, 12);
c0d0058a:	4630      	mov	r0, r6
c0d0058c:	4629      	mov	r1, r5
c0d0058e:	f7ff ff20 	bl	c0d003d2 <bigint_not>
        bigint_add_int(tmp, 1, base, 12);
c0d00592:	2101      	movs	r1, #1
c0d00594:	4630      	mov	r0, r6
c0d00596:	4622      	mov	r2, r4
c0d00598:	462b      	mov	r3, r5
c0d0059a:	f7ff fe75 	bl	c0d00288 <bigint_add_int>
c0d0059e:	e00e      	b.n	c0d005be <trints_to_words+0x172>
c0d005a0:	ac19      	add	r4, sp, #100	; 0x64
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 12) <= 0 ) {
        int32_t tmp[12];
        bigint_sub_bigint(base, HALF_3, tmp, 12);
c0d005a2:	4913      	ldr	r1, [pc, #76]	; (c0d005f0 <trints_to_words+0x1a4>)
c0d005a4:	4479      	add	r1, pc
c0d005a6:	ad0b      	add	r5, sp, #44	; 0x2c
c0d005a8:	230c      	movs	r3, #12
c0d005aa:	4620      	mov	r0, r4
c0d005ac:	462a      	mov	r2, r5
c0d005ae:	f7ff feb0 	bl	c0d00312 <bigint_sub_bigint>
        memcpy(base, tmp, 48);
c0d005b2:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d005b4:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d005b6:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d005b8:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d005ba:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d005bc:	c40f      	stmia	r4!, {r0, r1, r2, r3}
c0d005be:	a819      	add	r0, sp, #100	; 0x64
        bigint_add_int(tmp, 1, base, 12);
    }

    // Reverse array and do the swap32 thing.
    int32_t tmp[12];
    for(uint8_t i = 0; i < 12; i++) {
c0d005c0:	302c      	adds	r0, #44	; 0x2c
c0d005c2:	2100      	movs	r1, #0
      int32_t val = base[11 - i];
c0d005c4:	008a      	lsls	r2, r1, #2
c0d005c6:	1a83      	subs	r3, r0, r2
c0d005c8:	681b      	ldr	r3, [r3, #0]
      val = ((val & 0xFF) << 24) |
          ((val & 0xFF00) << 8) |
          ((val >> 8) & 0xFF00) |
c0d005ca:	ba1b      	rev	r3, r3
c0d005cc:	ac0b      	add	r4, sp, #44	; 0x2c
          ((val >> 24) & 0xFF);
      tmp[i] = val;
c0d005ce:	50a3      	str	r3, [r4, r2]
        bigint_add_int(tmp, 1, base, 12);
    }

    // Reverse array and do the swap32 thing.
    int32_t tmp[12];
    for(uint8_t i = 0; i < 12; i++) {
c0d005d0:	1c49      	adds	r1, r1, #1
c0d005d2:	290c      	cmp	r1, #12
c0d005d4:	d1f6      	bne.n	c0d005c4 <trints_to_words+0x178>
c0d005d6:	a80b      	add	r0, sp, #44	; 0x2c
c0d005d8:	9d00      	ldr	r5, [sp, #0]
          ((val >> 8) & 0xFF00) |
          ((val >> 24) & 0xFF);
      tmp[i] = val;
    }

    memcpy(words_out, tmp, 48);
c0d005da:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d005dc:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d005de:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d005e0:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d005e2:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d005e4:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d005e6:	2000      	movs	r0, #0
c0d005e8:	b025      	add	sp, #148	; 0x94
c0d005ea:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d005ec:	00002f24 	.word	0x00002f24
c0d005f0:	00002ee8 	.word	0x00002ee8
c0d005f4:	00002f14 	.word	0x00002f14

c0d005f8 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d005f8:	b580      	push	{r7, lr}
c0d005fa:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d005fc:	2003      	movs	r0, #3
c0d005fe:	01c1      	lsls	r1, r0, #7
c0d00600:	4802      	ldr	r0, [pc, #8]	; (c0d0060c <kerl_initialize+0x14>)
c0d00602:	f001 fafd 	bl	c0d01c00 <cx_keccak_init>
    return 0;
c0d00606:	2000      	movs	r0, #0
c0d00608:	bd80      	pop	{r7, pc}
c0d0060a:	46c0      	nop			; (mov r8, r8)
c0d0060c:	20001840 	.word	0x20001840

c0d00610 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00610:	b580      	push	{r7, lr}
c0d00612:	af00      	add	r7, sp, #0
c0d00614:	b082      	sub	sp, #8
c0d00616:	460b      	mov	r3, r1
c0d00618:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0061a:	4805      	ldr	r0, [pc, #20]	; (c0d00630 <kerl_absorb_bytes+0x20>)
c0d0061c:	4669      	mov	r1, sp
c0d0061e:	6008      	str	r0, [r1, #0]
c0d00620:	4804      	ldr	r0, [pc, #16]	; (c0d00634 <kerl_absorb_bytes+0x24>)
c0d00622:	2101      	movs	r1, #1
c0d00624:	f001 fb0a 	bl	c0d01c3c <cx_hash>
c0d00628:	2000      	movs	r0, #0
    return 0;
c0d0062a:	b002      	add	sp, #8
c0d0062c:	bd80      	pop	{r7, pc}
c0d0062e:	46c0      	nop			; (mov r8, r8)
c0d00630:	200019e8 	.word	0x200019e8
c0d00634:	20001840 	.word	0x20001840

c0d00638 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00638:	b580      	push	{r7, lr}
c0d0063a:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d0063c:	4804      	ldr	r0, [pc, #16]	; (c0d00650 <nvram_is_init+0x18>)
c0d0063e:	f001 fa33 	bl	c0d01aa8 <pic>
c0d00642:	7801      	ldrb	r1, [r0, #0]
c0d00644:	2000      	movs	r0, #0
c0d00646:	2901      	cmp	r1, #1
c0d00648:	d100      	bne.n	c0d0064c <nvram_is_init+0x14>
c0d0064a:	4608      	mov	r0, r1
    else return true;
}
c0d0064c:	bd80      	pop	{r7, pc}
c0d0064e:	46c0      	nop			; (mov r8, r8)
c0d00650:	c0d03880 	.word	0xc0d03880

c0d00654 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00654:	b5b0      	push	{r4, r5, r7, lr}
c0d00656:	af02      	add	r7, sp, #8
c0d00658:	4605      	mov	r5, r0
c0d0065a:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d0065c:	4028      	ands	r0, r5
c0d0065e:	2400      	movs	r4, #0
c0d00660:	2801      	cmp	r0, #1
c0d00662:	d013      	beq.n	c0d0068c <io_exchange_al+0x38>
c0d00664:	2802      	cmp	r0, #2
c0d00666:	d113      	bne.n	c0d00690 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00668:	2900      	cmp	r1, #0
c0d0066a:	d008      	beq.n	c0d0067e <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d0066c:	480b      	ldr	r0, [pc, #44]	; (c0d0069c <io_exchange_al+0x48>)
c0d0066e:	f001 fbd7 	bl	c0d01e20 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00672:	b268      	sxtb	r0, r5
c0d00674:	2800      	cmp	r0, #0
c0d00676:	da09      	bge.n	c0d0068c <io_exchange_al+0x38>
                reset();
c0d00678:	f001 fa4c 	bl	c0d01b14 <reset>
c0d0067c:	e006      	b.n	c0d0068c <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d0067e:	2041      	movs	r0, #65	; 0x41
c0d00680:	0081      	lsls	r1, r0, #2
c0d00682:	4806      	ldr	r0, [pc, #24]	; (c0d0069c <io_exchange_al+0x48>)
c0d00684:	2200      	movs	r2, #0
c0d00686:	f001 fc05 	bl	c0d01e94 <io_seproxyhal_spi_recv>
c0d0068a:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d0068c:	4620      	mov	r0, r4
c0d0068e:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00690:	4803      	ldr	r0, [pc, #12]	; (c0d006a0 <io_exchange_al+0x4c>)
c0d00692:	6800      	ldr	r0, [r0, #0]
c0d00694:	2102      	movs	r1, #2
c0d00696:	f002 fe65 	bl	c0d03364 <longjmp>
c0d0069a:	46c0      	nop			; (mov r8, r8)
c0d0069c:	20001c08 	.word	0x20001c08
c0d006a0:	20001bb8 	.word	0x20001bb8

c0d006a4 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d006a4:	b580      	push	{r7, lr}
c0d006a6:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d006a8:	f000 fe8e 	bl	c0d013c8 <io_seproxyhal_display_default>
}
c0d006ac:	bd80      	pop	{r7, pc}
	...

c0d006b0 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d006b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006b2:	af03      	add	r7, sp, #12
c0d006b4:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d006b6:	48a6      	ldr	r0, [pc, #664]	; (c0d00950 <io_event+0x2a0>)
c0d006b8:	7800      	ldrb	r0, [r0, #0]
c0d006ba:	2805      	cmp	r0, #5
c0d006bc:	d02e      	beq.n	c0d0071c <io_event+0x6c>
c0d006be:	280d      	cmp	r0, #13
c0d006c0:	d04e      	beq.n	c0d00760 <io_event+0xb0>
c0d006c2:	280c      	cmp	r0, #12
c0d006c4:	d000      	beq.n	c0d006c8 <io_event+0x18>
c0d006c6:	e13a      	b.n	c0d0093e <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d006c8:	4ea2      	ldr	r6, [pc, #648]	; (c0d00954 <io_event+0x2a4>)
c0d006ca:	2001      	movs	r0, #1
c0d006cc:	7630      	strb	r0, [r6, #24]
c0d006ce:	2500      	movs	r5, #0
c0d006d0:	61f5      	str	r5, [r6, #28]
c0d006d2:	4634      	mov	r4, r6
c0d006d4:	3418      	adds	r4, #24
c0d006d6:	4620      	mov	r0, r4
c0d006d8:	f001 fb68 	bl	c0d01dac <os_ux>
c0d006dc:	61f0      	str	r0, [r6, #28]
c0d006de:	499e      	ldr	r1, [pc, #632]	; (c0d00958 <io_event+0x2a8>)
c0d006e0:	4288      	cmp	r0, r1
c0d006e2:	d100      	bne.n	c0d006e6 <io_event+0x36>
c0d006e4:	e12b      	b.n	c0d0093e <io_event+0x28e>
c0d006e6:	2800      	cmp	r0, #0
c0d006e8:	d100      	bne.n	c0d006ec <io_event+0x3c>
c0d006ea:	e128      	b.n	c0d0093e <io_event+0x28e>
c0d006ec:	499b      	ldr	r1, [pc, #620]	; (c0d0095c <io_event+0x2ac>)
c0d006ee:	4288      	cmp	r0, r1
c0d006f0:	d000      	beq.n	c0d006f4 <io_event+0x44>
c0d006f2:	e0ac      	b.n	c0d0084e <io_event+0x19e>
c0d006f4:	2003      	movs	r0, #3
c0d006f6:	7630      	strb	r0, [r6, #24]
c0d006f8:	61f5      	str	r5, [r6, #28]
c0d006fa:	4620      	mov	r0, r4
c0d006fc:	f001 fb56 	bl	c0d01dac <os_ux>
c0d00700:	61f0      	str	r0, [r6, #28]
c0d00702:	f000 fd17 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d00706:	60b5      	str	r5, [r6, #8]
c0d00708:	6830      	ldr	r0, [r6, #0]
c0d0070a:	2800      	cmp	r0, #0
c0d0070c:	d100      	bne.n	c0d00710 <io_event+0x60>
c0d0070e:	e116      	b.n	c0d0093e <io_event+0x28e>
c0d00710:	69f0      	ldr	r0, [r6, #28]
c0d00712:	4991      	ldr	r1, [pc, #580]	; (c0d00958 <io_event+0x2a8>)
c0d00714:	4288      	cmp	r0, r1
c0d00716:	d000      	beq.n	c0d0071a <io_event+0x6a>
c0d00718:	e096      	b.n	c0d00848 <io_event+0x198>
c0d0071a:	e110      	b.n	c0d0093e <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0071c:	4d8d      	ldr	r5, [pc, #564]	; (c0d00954 <io_event+0x2a4>)
c0d0071e:	2001      	movs	r0, #1
c0d00720:	7628      	strb	r0, [r5, #24]
c0d00722:	2600      	movs	r6, #0
c0d00724:	61ee      	str	r6, [r5, #28]
c0d00726:	462c      	mov	r4, r5
c0d00728:	3418      	adds	r4, #24
c0d0072a:	4620      	mov	r0, r4
c0d0072c:	f001 fb3e 	bl	c0d01dac <os_ux>
c0d00730:	4601      	mov	r1, r0
c0d00732:	61e9      	str	r1, [r5, #28]
c0d00734:	4889      	ldr	r0, [pc, #548]	; (c0d0095c <io_event+0x2ac>)
c0d00736:	4281      	cmp	r1, r0
c0d00738:	d15d      	bne.n	c0d007f6 <io_event+0x146>
c0d0073a:	2003      	movs	r0, #3
c0d0073c:	7628      	strb	r0, [r5, #24]
c0d0073e:	61ee      	str	r6, [r5, #28]
c0d00740:	4620      	mov	r0, r4
c0d00742:	f001 fb33 	bl	c0d01dac <os_ux>
c0d00746:	61e8      	str	r0, [r5, #28]
c0d00748:	f000 fcf4 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d0074c:	60ae      	str	r6, [r5, #8]
c0d0074e:	6828      	ldr	r0, [r5, #0]
c0d00750:	2800      	cmp	r0, #0
c0d00752:	d100      	bne.n	c0d00756 <io_event+0xa6>
c0d00754:	e0f3      	b.n	c0d0093e <io_event+0x28e>
c0d00756:	69e8      	ldr	r0, [r5, #28]
c0d00758:	497f      	ldr	r1, [pc, #508]	; (c0d00958 <io_event+0x2a8>)
c0d0075a:	4288      	cmp	r0, r1
c0d0075c:	d148      	bne.n	c0d007f0 <io_event+0x140>
c0d0075e:	e0ee      	b.n	c0d0093e <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00760:	4d7c      	ldr	r5, [pc, #496]	; (c0d00954 <io_event+0x2a4>)
c0d00762:	6868      	ldr	r0, [r5, #4]
c0d00764:	68a9      	ldr	r1, [r5, #8]
c0d00766:	4281      	cmp	r1, r0
c0d00768:	d300      	bcc.n	c0d0076c <io_event+0xbc>
c0d0076a:	e0e8      	b.n	c0d0093e <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d0076c:	2001      	movs	r0, #1
c0d0076e:	7628      	strb	r0, [r5, #24]
c0d00770:	2600      	movs	r6, #0
c0d00772:	61ee      	str	r6, [r5, #28]
c0d00774:	462c      	mov	r4, r5
c0d00776:	3418      	adds	r4, #24
c0d00778:	4620      	mov	r0, r4
c0d0077a:	f001 fb17 	bl	c0d01dac <os_ux>
c0d0077e:	61e8      	str	r0, [r5, #28]
c0d00780:	4975      	ldr	r1, [pc, #468]	; (c0d00958 <io_event+0x2a8>)
c0d00782:	4288      	cmp	r0, r1
c0d00784:	d100      	bne.n	c0d00788 <io_event+0xd8>
c0d00786:	e0da      	b.n	c0d0093e <io_event+0x28e>
c0d00788:	2800      	cmp	r0, #0
c0d0078a:	d100      	bne.n	c0d0078e <io_event+0xde>
c0d0078c:	e0d7      	b.n	c0d0093e <io_event+0x28e>
c0d0078e:	4973      	ldr	r1, [pc, #460]	; (c0d0095c <io_event+0x2ac>)
c0d00790:	4288      	cmp	r0, r1
c0d00792:	d000      	beq.n	c0d00796 <io_event+0xe6>
c0d00794:	e08d      	b.n	c0d008b2 <io_event+0x202>
c0d00796:	2003      	movs	r0, #3
c0d00798:	7628      	strb	r0, [r5, #24]
c0d0079a:	61ee      	str	r6, [r5, #28]
c0d0079c:	4620      	mov	r0, r4
c0d0079e:	f001 fb05 	bl	c0d01dac <os_ux>
c0d007a2:	61e8      	str	r0, [r5, #28]
c0d007a4:	f000 fcc6 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d007a8:	60ae      	str	r6, [r5, #8]
c0d007aa:	6828      	ldr	r0, [r5, #0]
c0d007ac:	2800      	cmp	r0, #0
c0d007ae:	d100      	bne.n	c0d007b2 <io_event+0x102>
c0d007b0:	e0c5      	b.n	c0d0093e <io_event+0x28e>
c0d007b2:	69e8      	ldr	r0, [r5, #28]
c0d007b4:	4968      	ldr	r1, [pc, #416]	; (c0d00958 <io_event+0x2a8>)
c0d007b6:	4288      	cmp	r0, r1
c0d007b8:	d178      	bne.n	c0d008ac <io_event+0x1fc>
c0d007ba:	e0c0      	b.n	c0d0093e <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d007bc:	6868      	ldr	r0, [r5, #4]
c0d007be:	4286      	cmp	r6, r0
c0d007c0:	d300      	bcc.n	c0d007c4 <io_event+0x114>
c0d007c2:	e0bc      	b.n	c0d0093e <io_event+0x28e>
c0d007c4:	f001 fb4a 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d007c8:	2800      	cmp	r0, #0
c0d007ca:	d000      	beq.n	c0d007ce <io_event+0x11e>
c0d007cc:	e0b7      	b.n	c0d0093e <io_event+0x28e>
c0d007ce:	68a8      	ldr	r0, [r5, #8]
c0d007d0:	68e9      	ldr	r1, [r5, #12]
c0d007d2:	2438      	movs	r4, #56	; 0x38
c0d007d4:	4360      	muls	r0, r4
c0d007d6:	682a      	ldr	r2, [r5, #0]
c0d007d8:	1810      	adds	r0, r2, r0
c0d007da:	2900      	cmp	r1, #0
c0d007dc:	d100      	bne.n	c0d007e0 <io_event+0x130>
c0d007de:	e085      	b.n	c0d008ec <io_event+0x23c>
c0d007e0:	4788      	blx	r1
c0d007e2:	2800      	cmp	r0, #0
c0d007e4:	d000      	beq.n	c0d007e8 <io_event+0x138>
c0d007e6:	e081      	b.n	c0d008ec <io_event+0x23c>
c0d007e8:	68a8      	ldr	r0, [r5, #8]
c0d007ea:	1c46      	adds	r6, r0, #1
c0d007ec:	60ae      	str	r6, [r5, #8]
c0d007ee:	6828      	ldr	r0, [r5, #0]
c0d007f0:	2800      	cmp	r0, #0
c0d007f2:	d1e3      	bne.n	c0d007bc <io_event+0x10c>
c0d007f4:	e0a3      	b.n	c0d0093e <io_event+0x28e>
c0d007f6:	6928      	ldr	r0, [r5, #16]
c0d007f8:	2800      	cmp	r0, #0
c0d007fa:	d100      	bne.n	c0d007fe <io_event+0x14e>
c0d007fc:	e09f      	b.n	c0d0093e <io_event+0x28e>
c0d007fe:	4a56      	ldr	r2, [pc, #344]	; (c0d00958 <io_event+0x2a8>)
c0d00800:	4291      	cmp	r1, r2
c0d00802:	d100      	bne.n	c0d00806 <io_event+0x156>
c0d00804:	e09b      	b.n	c0d0093e <io_event+0x28e>
c0d00806:	2900      	cmp	r1, #0
c0d00808:	d100      	bne.n	c0d0080c <io_event+0x15c>
c0d0080a:	e098      	b.n	c0d0093e <io_event+0x28e>
c0d0080c:	4950      	ldr	r1, [pc, #320]	; (c0d00950 <io_event+0x2a0>)
c0d0080e:	78c9      	ldrb	r1, [r1, #3]
c0d00810:	0849      	lsrs	r1, r1, #1
c0d00812:	f000 fe1b 	bl	c0d0144c <io_seproxyhal_button_push>
c0d00816:	e092      	b.n	c0d0093e <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00818:	6870      	ldr	r0, [r6, #4]
c0d0081a:	4285      	cmp	r5, r0
c0d0081c:	d300      	bcc.n	c0d00820 <io_event+0x170>
c0d0081e:	e08e      	b.n	c0d0093e <io_event+0x28e>
c0d00820:	f001 fb1c 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d00824:	2800      	cmp	r0, #0
c0d00826:	d000      	beq.n	c0d0082a <io_event+0x17a>
c0d00828:	e089      	b.n	c0d0093e <io_event+0x28e>
c0d0082a:	68b0      	ldr	r0, [r6, #8]
c0d0082c:	68f1      	ldr	r1, [r6, #12]
c0d0082e:	2438      	movs	r4, #56	; 0x38
c0d00830:	4360      	muls	r0, r4
c0d00832:	6832      	ldr	r2, [r6, #0]
c0d00834:	1810      	adds	r0, r2, r0
c0d00836:	2900      	cmp	r1, #0
c0d00838:	d076      	beq.n	c0d00928 <io_event+0x278>
c0d0083a:	4788      	blx	r1
c0d0083c:	2800      	cmp	r0, #0
c0d0083e:	d173      	bne.n	c0d00928 <io_event+0x278>
c0d00840:	68b0      	ldr	r0, [r6, #8]
c0d00842:	1c45      	adds	r5, r0, #1
c0d00844:	60b5      	str	r5, [r6, #8]
c0d00846:	6830      	ldr	r0, [r6, #0]
c0d00848:	2800      	cmp	r0, #0
c0d0084a:	d1e5      	bne.n	c0d00818 <io_event+0x168>
c0d0084c:	e077      	b.n	c0d0093e <io_event+0x28e>
c0d0084e:	88b0      	ldrh	r0, [r6, #4]
c0d00850:	9004      	str	r0, [sp, #16]
c0d00852:	6830      	ldr	r0, [r6, #0]
c0d00854:	9003      	str	r0, [sp, #12]
c0d00856:	483e      	ldr	r0, [pc, #248]	; (c0d00950 <io_event+0x2a0>)
c0d00858:	4601      	mov	r1, r0
c0d0085a:	79cc      	ldrb	r4, [r1, #7]
c0d0085c:	798b      	ldrb	r3, [r1, #6]
c0d0085e:	794d      	ldrb	r5, [r1, #5]
c0d00860:	790a      	ldrb	r2, [r1, #4]
c0d00862:	4630      	mov	r0, r6
c0d00864:	78ce      	ldrb	r6, [r1, #3]
c0d00866:	68c1      	ldr	r1, [r0, #12]
c0d00868:	4668      	mov	r0, sp
c0d0086a:	6006      	str	r6, [r0, #0]
c0d0086c:	6041      	str	r1, [r0, #4]
c0d0086e:	0212      	lsls	r2, r2, #8
c0d00870:	432a      	orrs	r2, r5
c0d00872:	021b      	lsls	r3, r3, #8
c0d00874:	4323      	orrs	r3, r4
c0d00876:	9803      	ldr	r0, [sp, #12]
c0d00878:	9904      	ldr	r1, [sp, #16]
c0d0087a:	f000 fcd5 	bl	c0d01228 <io_seproxyhal_touch_element_callback>
c0d0087e:	e05e      	b.n	c0d0093e <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00880:	6868      	ldr	r0, [r5, #4]
c0d00882:	4286      	cmp	r6, r0
c0d00884:	d25b      	bcs.n	c0d0093e <io_event+0x28e>
c0d00886:	f001 fae9 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d0088a:	2800      	cmp	r0, #0
c0d0088c:	d157      	bne.n	c0d0093e <io_event+0x28e>
c0d0088e:	68a8      	ldr	r0, [r5, #8]
c0d00890:	68e9      	ldr	r1, [r5, #12]
c0d00892:	2438      	movs	r4, #56	; 0x38
c0d00894:	4360      	muls	r0, r4
c0d00896:	682a      	ldr	r2, [r5, #0]
c0d00898:	1810      	adds	r0, r2, r0
c0d0089a:	2900      	cmp	r1, #0
c0d0089c:	d026      	beq.n	c0d008ec <io_event+0x23c>
c0d0089e:	4788      	blx	r1
c0d008a0:	2800      	cmp	r0, #0
c0d008a2:	d123      	bne.n	c0d008ec <io_event+0x23c>
c0d008a4:	68a8      	ldr	r0, [r5, #8]
c0d008a6:	1c46      	adds	r6, r0, #1
c0d008a8:	60ae      	str	r6, [r5, #8]
c0d008aa:	6828      	ldr	r0, [r5, #0]
c0d008ac:	2800      	cmp	r0, #0
c0d008ae:	d1e7      	bne.n	c0d00880 <io_event+0x1d0>
c0d008b0:	e045      	b.n	c0d0093e <io_event+0x28e>
c0d008b2:	6828      	ldr	r0, [r5, #0]
c0d008b4:	2800      	cmp	r0, #0
c0d008b6:	d030      	beq.n	c0d0091a <io_event+0x26a>
c0d008b8:	68a8      	ldr	r0, [r5, #8]
c0d008ba:	6869      	ldr	r1, [r5, #4]
c0d008bc:	4288      	cmp	r0, r1
c0d008be:	d22c      	bcs.n	c0d0091a <io_event+0x26a>
c0d008c0:	f001 facc 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d008c4:	2800      	cmp	r0, #0
c0d008c6:	d128      	bne.n	c0d0091a <io_event+0x26a>
c0d008c8:	68a8      	ldr	r0, [r5, #8]
c0d008ca:	68e9      	ldr	r1, [r5, #12]
c0d008cc:	2438      	movs	r4, #56	; 0x38
c0d008ce:	4360      	muls	r0, r4
c0d008d0:	682a      	ldr	r2, [r5, #0]
c0d008d2:	1810      	adds	r0, r2, r0
c0d008d4:	2900      	cmp	r1, #0
c0d008d6:	d015      	beq.n	c0d00904 <io_event+0x254>
c0d008d8:	4788      	blx	r1
c0d008da:	2800      	cmp	r0, #0
c0d008dc:	d112      	bne.n	c0d00904 <io_event+0x254>
c0d008de:	68a8      	ldr	r0, [r5, #8]
c0d008e0:	1c40      	adds	r0, r0, #1
c0d008e2:	60a8      	str	r0, [r5, #8]
c0d008e4:	6829      	ldr	r1, [r5, #0]
c0d008e6:	2900      	cmp	r1, #0
c0d008e8:	d1e7      	bne.n	c0d008ba <io_event+0x20a>
c0d008ea:	e016      	b.n	c0d0091a <io_event+0x26a>
c0d008ec:	2801      	cmp	r0, #1
c0d008ee:	d103      	bne.n	c0d008f8 <io_event+0x248>
c0d008f0:	68a8      	ldr	r0, [r5, #8]
c0d008f2:	4344      	muls	r4, r0
c0d008f4:	6828      	ldr	r0, [r5, #0]
c0d008f6:	1900      	adds	r0, r0, r4
c0d008f8:	f000 fd66 	bl	c0d013c8 <io_seproxyhal_display_default>
c0d008fc:	68a8      	ldr	r0, [r5, #8]
c0d008fe:	1c40      	adds	r0, r0, #1
c0d00900:	60a8      	str	r0, [r5, #8]
c0d00902:	e01c      	b.n	c0d0093e <io_event+0x28e>
c0d00904:	2801      	cmp	r0, #1
c0d00906:	d103      	bne.n	c0d00910 <io_event+0x260>
c0d00908:	68a8      	ldr	r0, [r5, #8]
c0d0090a:	4344      	muls	r4, r0
c0d0090c:	6828      	ldr	r0, [r5, #0]
c0d0090e:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00910:	f000 fd5a 	bl	c0d013c8 <io_seproxyhal_display_default>
c0d00914:	68a8      	ldr	r0, [r5, #8]
c0d00916:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00918:	60a8      	str	r0, [r5, #8]
c0d0091a:	6868      	ldr	r0, [r5, #4]
c0d0091c:	68a9      	ldr	r1, [r5, #8]
c0d0091e:	4281      	cmp	r1, r0
c0d00920:	d30d      	bcc.n	c0d0093e <io_event+0x28e>
c0d00922:	f001 fa9b 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d00926:	e00a      	b.n	c0d0093e <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00928:	2801      	cmp	r0, #1
c0d0092a:	d103      	bne.n	c0d00934 <io_event+0x284>
c0d0092c:	68b0      	ldr	r0, [r6, #8]
c0d0092e:	4344      	muls	r4, r0
c0d00930:	6830      	ldr	r0, [r6, #0]
c0d00932:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00934:	f000 fd48 	bl	c0d013c8 <io_seproxyhal_display_default>
c0d00938:	68b0      	ldr	r0, [r6, #8]
c0d0093a:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0093c:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d0093e:	f001 fa8d 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d00942:	2800      	cmp	r0, #0
c0d00944:	d101      	bne.n	c0d0094a <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00946:	f000 fac9 	bl	c0d00edc <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d0094a:	2001      	movs	r0, #1
c0d0094c:	b005      	add	sp, #20
c0d0094e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00950:	20001a18 	.word	0x20001a18
c0d00954:	20001a98 	.word	0x20001a98
c0d00958:	b0105044 	.word	0xb0105044
c0d0095c:	b0105055 	.word	0xb0105055

c0d00960 <IOTA_main>:





static void IOTA_main(void) {
c0d00960:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00962:	af03      	add	r7, sp, #12
c0d00964:	b0dd      	sub	sp, #372	; 0x174
c0d00966:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00968:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d0096a:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d0096c:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d0096e:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00bf4 <IOTA_main+0x294>)
c0d00970:	2110      	movs	r1, #16
c0d00972:	2203      	movs	r2, #3
c0d00974:	9109      	str	r1, [sp, #36]	; 0x24
c0d00976:	9208      	str	r2, [sp, #32]
c0d00978:	f7ff fb94 	bl	c0d000a4 <write_debug>
c0d0097c:	a80e      	add	r0, sp, #56	; 0x38
c0d0097e:	304d      	adds	r0, #77	; 0x4d
c0d00980:	9007      	str	r0, [sp, #28]
c0d00982:	a80b      	add	r0, sp, #44	; 0x2c
c0d00984:	1dc1      	adds	r1, r0, #7
c0d00986:	9106      	str	r1, [sp, #24]
c0d00988:	1d00      	adds	r0, r0, #4
c0d0098a:	9005      	str	r0, [sp, #20]
c0d0098c:	4e9d      	ldr	r6, [pc, #628]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d0098e:	6830      	ldr	r0, [r6, #0]
c0d00990:	e08d      	b.n	c0d00aae <IOTA_main+0x14e>
c0d00992:	489f      	ldr	r0, [pc, #636]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d00994:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00996:	4330      	orrs	r0, r6
c0d00998:	2880      	cmp	r0, #128	; 0x80
c0d0099a:	d000      	beq.n	c0d0099e <IOTA_main+0x3e>
c0d0099c:	e11e      	b.n	c0d00bdc <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d0099e:	7810      	ldrb	r0, [r2, #0]
c0d009a0:	2800      	cmp	r0, #0
c0d009a2:	4e98      	ldr	r6, [pc, #608]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d009a4:	d004      	beq.n	c0d009b0 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d009a6:	489c      	ldr	r0, [pc, #624]	; (c0d00c18 <IOTA_main+0x2b8>)
c0d009a8:	f001 f90c 	bl	c0d01bc4 <cx_sha256_init>
                        hashTainted = 0;
c0d009ac:	4899      	ldr	r0, [pc, #612]	; (c0d00c14 <IOTA_main+0x2b4>)
c0d009ae:	7004      	strb	r4, [r0, #0]
c0d009b0:	4897      	ldr	r0, [pc, #604]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d009b2:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d009b4:	7908      	ldrb	r0, [r1, #4]
c0d009b6:	1808      	adds	r0, r1, r0
c0d009b8:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d009ba:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d009bc:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d009be:	4308      	orrs	r0, r1
c0d009c0:	905a      	str	r0, [sp, #360]	; 0x168
c0d009c2:	e0e5      	b.n	c0d00b90 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d009c4:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d009c6:	2818      	cmp	r0, #24
c0d009c8:	d800      	bhi.n	c0d009cc <IOTA_main+0x6c>
c0d009ca:	e10c      	b.n	c0d00be6 <IOTA_main+0x286>
c0d009cc:	950a      	str	r5, [sp, #40]	; 0x28
c0d009ce:	4d90      	ldr	r5, [pc, #576]	; (c0d00c10 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d009d0:	00a0      	lsls	r0, r4, #2
c0d009d2:	1829      	adds	r1, r5, r0
c0d009d4:	794a      	ldrb	r2, [r1, #5]
c0d009d6:	0612      	lsls	r2, r2, #24
c0d009d8:	798b      	ldrb	r3, [r1, #6]
c0d009da:	041b      	lsls	r3, r3, #16
c0d009dc:	4313      	orrs	r3, r2
c0d009de:	79ca      	ldrb	r2, [r1, #7]
c0d009e0:	0212      	lsls	r2, r2, #8
c0d009e2:	431a      	orrs	r2, r3
c0d009e4:	7a09      	ldrb	r1, [r1, #8]
c0d009e6:	4311      	orrs	r1, r2
c0d009e8:	aa2b      	add	r2, sp, #172	; 0xac
c0d009ea:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d009ec:	1c64      	adds	r4, r4, #1
c0d009ee:	2c05      	cmp	r4, #5
c0d009f0:	d1ee      	bne.n	c0d009d0 <IOTA_main+0x70>
c0d009f2:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d009f4:	9103      	str	r1, [sp, #12]
c0d009f6:	4668      	mov	r0, sp
c0d009f8:	6001      	str	r1, [r0, #0]
c0d009fa:	2421      	movs	r4, #33	; 0x21
c0d009fc:	a92b      	add	r1, sp, #172	; 0xac
c0d009fe:	2205      	movs	r2, #5
c0d00a00:	ad23      	add	r5, sp, #140	; 0x8c
c0d00a02:	9502      	str	r5, [sp, #8]
c0d00a04:	4620      	mov	r0, r4
c0d00a06:	462b      	mov	r3, r5
c0d00a08:	f001 f992 	bl	c0d01d30 <os_perso_derive_node_bip32>
c0d00a0c:	2220      	movs	r2, #32
c0d00a0e:	9204      	str	r2, [sp, #16]
c0d00a10:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00a12:	9301      	str	r3, [sp, #4]
c0d00a14:	4620      	mov	r0, r4
c0d00a16:	4629      	mov	r1, r5
c0d00a18:	f001 f94e 	bl	c0d01cb8 <cx_ecfp_init_private_key>
c0d00a1c:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00a1e:	4620      	mov	r0, r4
c0d00a20:	9903      	ldr	r1, [sp, #12]
c0d00a22:	460a      	mov	r2, r1
c0d00a24:	462b      	mov	r3, r5
c0d00a26:	f001 f929 	bl	c0d01c7c <cx_ecfp_init_public_key>
c0d00a2a:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00a2c:	4620      	mov	r0, r4
c0d00a2e:	4629      	mov	r1, r5
c0d00a30:	9a01      	ldr	r2, [sp, #4]
c0d00a32:	f001 f95f 	bl	c0d01cf4 <cx_ecfp_generate_pair>
c0d00a36:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00a38:	9802      	ldr	r0, [sp, #8]
c0d00a3a:	9904      	ldr	r1, [sp, #16]
c0d00a3c:	4622      	mov	r2, r4
c0d00a3e:	f7ff fbcb 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00a42:	2552      	movs	r5, #82	; 0x52
c0d00a44:	4872      	ldr	r0, [pc, #456]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d00a46:	4621      	mov	r1, r4
c0d00a48:	462a      	mov	r2, r5
c0d00a4a:	f000 f9ad 	bl	c0d00da8 <os_memmove>
                    tx = 82;
c0d00a4e:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00a50:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a52:	1c41      	adds	r1, r0, #1
c0d00a54:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00a56:	3610      	adds	r6, #16
c0d00a58:	4a6d      	ldr	r2, [pc, #436]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d00a5a:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00a5c:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a5e:	1c41      	adds	r1, r0, #1
c0d00a60:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00a62:	9903      	ldr	r1, [sp, #12]
c0d00a64:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00a66:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a68:	b281      	uxth	r1, r0
c0d00a6a:	9804      	ldr	r0, [sp, #16]
c0d00a6c:	f000 fd2a 	bl	c0d014c4 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00a70:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00a72:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00a74:	4308      	orrs	r0, r1
c0d00a76:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00a78:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00a7a:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00a7c:	202e      	movs	r0, #46	; 0x2e
c0d00a7e:	9905      	ldr	r1, [sp, #20]
c0d00a80:	7048      	strb	r0, [r1, #1]
c0d00a82:	7008      	strb	r0, [r1, #0]
c0d00a84:	7088      	strb	r0, [r1, #2]
c0d00a86:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00a88:	78c8      	ldrb	r0, [r1, #3]
c0d00a8a:	9a06      	ldr	r2, [sp, #24]
c0d00a8c:	70d0      	strb	r0, [r2, #3]
c0d00a8e:	7888      	ldrb	r0, [r1, #2]
c0d00a90:	7090      	strb	r0, [r2, #2]
c0d00a92:	7848      	ldrb	r0, [r1, #1]
c0d00a94:	7050      	strb	r0, [r2, #1]
c0d00a96:	7808      	ldrb	r0, [r1, #0]
c0d00a98:	7010      	strb	r0, [r2, #0]
c0d00a9a:	7908      	ldrb	r0, [r1, #4]
c0d00a9c:	7110      	strb	r0, [r2, #4]
c0d00a9e:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00aa0:	2140      	movs	r1, #64	; 0x40
c0d00aa2:	2203      	movs	r2, #3
c0d00aa4:	f001 fa8a 	bl	c0d01fbc <ui_display_debug>
c0d00aa8:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00aaa:	4e56      	ldr	r6, [pc, #344]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00aac:	e070      	b.n	c0d00b90 <IOTA_main+0x230>
c0d00aae:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00ab0:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00ab2:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00ab4:	ac4d      	add	r4, sp, #308	; 0x134
c0d00ab6:	4620      	mov	r0, r4
c0d00ab8:	f002 fc48 	bl	c0d0334c <setjmp>
c0d00abc:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00abe:	6034      	str	r4, [r6, #0]
c0d00ac0:	4951      	ldr	r1, [pc, #324]	; (c0d00c08 <IOTA_main+0x2a8>)
c0d00ac2:	4208      	tst	r0, r1
c0d00ac4:	d011      	beq.n	c0d00aea <IOTA_main+0x18a>
c0d00ac6:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00ac8:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00aca:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00acc:	6031      	str	r1, [r6, #0]
c0d00ace:	210f      	movs	r1, #15
c0d00ad0:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00ad2:	4001      	ands	r1, r0
c0d00ad4:	2209      	movs	r2, #9
c0d00ad6:	0312      	lsls	r2, r2, #12
c0d00ad8:	4291      	cmp	r1, r2
c0d00ada:	d003      	beq.n	c0d00ae4 <IOTA_main+0x184>
c0d00adc:	9a08      	ldr	r2, [sp, #32]
c0d00ade:	0352      	lsls	r2, r2, #13
c0d00ae0:	4291      	cmp	r1, r2
c0d00ae2:	d142      	bne.n	c0d00b6a <IOTA_main+0x20a>
c0d00ae4:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00ae6:	8008      	strh	r0, [r1, #0]
c0d00ae8:	e046      	b.n	c0d00b78 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00aea:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00aec:	905c      	str	r0, [sp, #368]	; 0x170
c0d00aee:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00af0:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00af2:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00af4:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00af6:	b2c0      	uxtb	r0, r0
c0d00af8:	b289      	uxth	r1, r1
c0d00afa:	f000 fce3 	bl	c0d014c4 <io_exchange>
c0d00afe:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00b00:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00b02:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00b04:	2800      	cmp	r0, #0
c0d00b06:	d053      	beq.n	c0d00bb0 <IOTA_main+0x250>
c0d00b08:	4941      	ldr	r1, [pc, #260]	; (c0d00c10 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00b0a:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00b0c:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00b0e:	2880      	cmp	r0, #128	; 0x80
c0d00b10:	4a40      	ldr	r2, [pc, #256]	; (c0d00c14 <IOTA_main+0x2b4>)
c0d00b12:	d155      	bne.n	c0d00bc0 <IOTA_main+0x260>
c0d00b14:	7848      	ldrb	r0, [r1, #1]
c0d00b16:	216d      	movs	r1, #109	; 0x6d
c0d00b18:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00b1a:	2807      	cmp	r0, #7
c0d00b1c:	dc3f      	bgt.n	c0d00b9e <IOTA_main+0x23e>
c0d00b1e:	2802      	cmp	r0, #2
c0d00b20:	d100      	bne.n	c0d00b24 <IOTA_main+0x1c4>
c0d00b22:	e74f      	b.n	c0d009c4 <IOTA_main+0x64>
c0d00b24:	2804      	cmp	r0, #4
c0d00b26:	d153      	bne.n	c0d00bd0 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00b28:	210b      	movs	r1, #11
c0d00b2a:	2203      	movs	r2, #3
c0d00b2c:	a03c      	add	r0, pc, #240	; (adr r0, c0d00c20 <IOTA_main+0x2c0>)
c0d00b2e:	f7ff fab9 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00b32:	2048      	movs	r0, #72	; 0x48
c0d00b34:	4936      	ldr	r1, [pc, #216]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d00b36:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00b38:	2049      	movs	r0, #73	; 0x49
c0d00b3a:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00b3c:	2021      	movs	r0, #33	; 0x21
c0d00b3e:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00b40:	3610      	adds	r6, #16
c0d00b42:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00b44:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00b46:	2005      	movs	r0, #5
c0d00b48:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00b4a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b4c:	b281      	uxth	r1, r0
c0d00b4e:	2020      	movs	r0, #32
c0d00b50:	f000 fcb8 	bl	c0d014c4 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00b54:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00b56:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00b58:	4308      	orrs	r0, r1
c0d00b5a:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00b5c:	4620      	mov	r0, r4
c0d00b5e:	4621      	mov	r1, r4
c0d00b60:	4622      	mov	r2, r4
c0d00b62:	f001 fa2b 	bl	c0d01fbc <ui_display_debug>
c0d00b66:	4e27      	ldr	r6, [pc, #156]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00b68:	e012      	b.n	c0d00b90 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00b6a:	4928      	ldr	r1, [pc, #160]	; (c0d00c0c <IOTA_main+0x2ac>)
c0d00b6c:	4008      	ands	r0, r1
c0d00b6e:	210d      	movs	r1, #13
c0d00b70:	02c9      	lsls	r1, r1, #11
c0d00b72:	4301      	orrs	r1, r0
c0d00b74:	a859      	add	r0, sp, #356	; 0x164
c0d00b76:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00b78:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00b7a:	0a00      	lsrs	r0, r0, #8
c0d00b7c:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00b7e:	4a24      	ldr	r2, [pc, #144]	; (c0d00c10 <IOTA_main+0x2b0>)
c0d00b80:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00b82:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00b84:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00b86:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00b88:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00b8a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b8c:	1c80      	adds	r0, r0, #2
c0d00b8e:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00b90:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00b92:	6030      	str	r0, [r6, #0]
c0d00b94:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00b96:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00b98:	2900      	cmp	r1, #0
c0d00b9a:	d088      	beq.n	c0d00aae <IOTA_main+0x14e>
c0d00b9c:	e006      	b.n	c0d00bac <IOTA_main+0x24c>
c0d00b9e:	2808      	cmp	r0, #8
c0d00ba0:	d100      	bne.n	c0d00ba4 <IOTA_main+0x244>
c0d00ba2:	e6f6      	b.n	c0d00992 <IOTA_main+0x32>
c0d00ba4:	28ff      	cmp	r0, #255	; 0xff
c0d00ba6:	d113      	bne.n	c0d00bd0 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00ba8:	b05d      	add	sp, #372	; 0x174
c0d00baa:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00bac:	f002 fbda 	bl	c0d03364 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00bb0:	2001      	movs	r0, #1
c0d00bb2:	4918      	ldr	r1, [pc, #96]	; (c0d00c14 <IOTA_main+0x2b4>)
c0d00bb4:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00bb6:	4813      	ldr	r0, [pc, #76]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00bb8:	6800      	ldr	r0, [r0, #0]
c0d00bba:	491c      	ldr	r1, [pc, #112]	; (c0d00c2c <IOTA_main+0x2cc>)
c0d00bbc:	f002 fbd2 	bl	c0d03364 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00bc0:	2001      	movs	r0, #1
c0d00bc2:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00bc4:	480f      	ldr	r0, [pc, #60]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00bc6:	6800      	ldr	r0, [r0, #0]
c0d00bc8:	2137      	movs	r1, #55	; 0x37
c0d00bca:	0249      	lsls	r1, r1, #9
c0d00bcc:	f002 fbca 	bl	c0d03364 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00bd0:	2001      	movs	r0, #1
c0d00bd2:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00bd4:	480b      	ldr	r0, [pc, #44]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00bd6:	6800      	ldr	r0, [r0, #0]
c0d00bd8:	f002 fbc4 	bl	c0d03364 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00bdc:	4809      	ldr	r0, [pc, #36]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00bde:	6800      	ldr	r0, [r0, #0]
c0d00be0:	490e      	ldr	r1, [pc, #56]	; (c0d00c1c <IOTA_main+0x2bc>)
c0d00be2:	f002 fbbf 	bl	c0d03364 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00be6:	2001      	movs	r0, #1
c0d00be8:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00bea:	4806      	ldr	r0, [pc, #24]	; (c0d00c04 <IOTA_main+0x2a4>)
c0d00bec:	6800      	ldr	r0, [r0, #0]
c0d00bee:	3109      	adds	r1, #9
c0d00bf0:	f002 fbb8 	bl	c0d03364 <longjmp>
c0d00bf4:	74696157 	.word	0x74696157
c0d00bf8:	20676e69 	.word	0x20676e69
c0d00bfc:	20726f66 	.word	0x20726f66
c0d00c00:	0067736d 	.word	0x0067736d
c0d00c04:	20001bb8 	.word	0x20001bb8
c0d00c08:	0000ffff 	.word	0x0000ffff
c0d00c0c:	000007ff 	.word	0x000007ff
c0d00c10:	20001c08 	.word	0x20001c08
c0d00c14:	20001b48 	.word	0x20001b48
c0d00c18:	20001b4c 	.word	0x20001b4c
c0d00c1c:	00006a86 	.word	0x00006a86
c0d00c20:	20646142 	.word	0x20646142
c0d00c24:	6b627550 	.word	0x6b627550
c0d00c28:	00007965 	.word	0x00007965
c0d00c2c:	00006982 	.word	0x00006982

c0d00c30 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00c30:	4801      	ldr	r0, [pc, #4]	; (c0d00c38 <os_boot+0x8>)
c0d00c32:	2100      	movs	r1, #0
c0d00c34:	6001      	str	r1, [r0, #0]
}
c0d00c36:	4770      	bx	lr
c0d00c38:	20001bb8 	.word	0x20001bb8

c0d00c3c <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00c3c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c3e:	af03      	add	r7, sp, #12
c0d00c40:	b083      	sub	sp, #12
c0d00c42:	9202      	str	r2, [sp, #8]
c0d00c44:	460c      	mov	r4, r1
c0d00c46:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00c48:	4d4a      	ldr	r5, [pc, #296]	; (c0d00d74 <io_usb_hid_receive+0x138>)
c0d00c4a:	42ac      	cmp	r4, r5
c0d00c4c:	d00f      	beq.n	c0d00c6e <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00c4e:	4e49      	ldr	r6, [pc, #292]	; (c0d00d74 <io_usb_hid_receive+0x138>)
c0d00c50:	2540      	movs	r5, #64	; 0x40
c0d00c52:	4630      	mov	r0, r6
c0d00c54:	4629      	mov	r1, r5
c0d00c56:	f002 fae3 	bl	c0d03220 <__aeabi_memclr>
c0d00c5a:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00c5c:	2840      	cmp	r0, #64	; 0x40
c0d00c5e:	4602      	mov	r2, r0
c0d00c60:	d300      	bcc.n	c0d00c64 <io_usb_hid_receive+0x28>
c0d00c62:	462a      	mov	r2, r5
c0d00c64:	4630      	mov	r0, r6
c0d00c66:	4621      	mov	r1, r4
c0d00c68:	f000 f89e 	bl	c0d00da8 <os_memmove>
c0d00c6c:	4d41      	ldr	r5, [pc, #260]	; (c0d00d74 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00c6e:	78a8      	ldrb	r0, [r5, #2]
c0d00c70:	2805      	cmp	r0, #5
c0d00c72:	d900      	bls.n	c0d00c76 <io_usb_hid_receive+0x3a>
c0d00c74:	e076      	b.n	c0d00d64 <io_usb_hid_receive+0x128>
c0d00c76:	46c0      	nop			; (mov r8, r8)
c0d00c78:	4478      	add	r0, pc
c0d00c7a:	7900      	ldrb	r0, [r0, #4]
c0d00c7c:	0040      	lsls	r0, r0, #1
c0d00c7e:	4487      	add	pc, r0
c0d00c80:	71130c02 	.word	0x71130c02
c0d00c84:	1f71      	.short	0x1f71
c0d00c86:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00c88:	71ae      	strb	r6, [r5, #6]
c0d00c8a:	716e      	strb	r6, [r5, #5]
c0d00c8c:	712e      	strb	r6, [r5, #4]
c0d00c8e:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c90:	2140      	movs	r1, #64	; 0x40
c0d00c92:	4628      	mov	r0, r5
c0d00c94:	9a01      	ldr	r2, [sp, #4]
c0d00c96:	4790      	blx	r2
c0d00c98:	e00b      	b.n	c0d00cb2 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00c9a:	1ce8      	adds	r0, r5, #3
c0d00c9c:	2104      	movs	r1, #4
c0d00c9e:	f000 ff73 	bl	c0d01b88 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ca2:	2140      	movs	r1, #64	; 0x40
c0d00ca4:	4628      	mov	r0, r5
c0d00ca6:	e001      	b.n	c0d00cac <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ca8:	4832      	ldr	r0, [pc, #200]	; (c0d00d74 <io_usb_hid_receive+0x138>)
c0d00caa:	2140      	movs	r1, #64	; 0x40
c0d00cac:	9a01      	ldr	r2, [sp, #4]
c0d00cae:	4790      	blx	r2
c0d00cb0:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00cb2:	4831      	ldr	r0, [pc, #196]	; (c0d00d78 <io_usb_hid_receive+0x13c>)
c0d00cb4:	2100      	movs	r1, #0
c0d00cb6:	6001      	str	r1, [r0, #0]
c0d00cb8:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00cba:	b2c0      	uxtb	r0, r0
c0d00cbc:	b003      	add	sp, #12
c0d00cbe:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00cc0:	78e8      	ldrb	r0, [r5, #3]
c0d00cc2:	4c2d      	ldr	r4, [pc, #180]	; (c0d00d78 <io_usb_hid_receive+0x13c>)
c0d00cc4:	6821      	ldr	r1, [r4, #0]
c0d00cc6:	0a09      	lsrs	r1, r1, #8
c0d00cc8:	2600      	movs	r6, #0
c0d00cca:	4288      	cmp	r0, r1
c0d00ccc:	d1f1      	bne.n	c0d00cb2 <io_usb_hid_receive+0x76>
c0d00cce:	7928      	ldrb	r0, [r5, #4]
c0d00cd0:	6821      	ldr	r1, [r4, #0]
c0d00cd2:	b2c9      	uxtb	r1, r1
c0d00cd4:	4288      	cmp	r0, r1
c0d00cd6:	d1ec      	bne.n	c0d00cb2 <io_usb_hid_receive+0x76>
c0d00cd8:	4b28      	ldr	r3, [pc, #160]	; (c0d00d7c <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00cda:	9802      	ldr	r0, [sp, #8]
c0d00cdc:	18c0      	adds	r0, r0, r3
c0d00cde:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00ce0:	6820      	ldr	r0, [r4, #0]
c0d00ce2:	2800      	cmp	r0, #0
c0d00ce4:	d00e      	beq.n	c0d00d04 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00ce6:	4629      	mov	r1, r5
c0d00ce8:	4019      	ands	r1, r3
c0d00cea:	4825      	ldr	r0, [pc, #148]	; (c0d00d80 <io_usb_hid_receive+0x144>)
c0d00cec:	6802      	ldr	r2, [r0, #0]
c0d00cee:	4291      	cmp	r1, r2
c0d00cf0:	461e      	mov	r6, r3
c0d00cf2:	d900      	bls.n	c0d00cf6 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00cf4:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00cf6:	462a      	mov	r2, r5
c0d00cf8:	4032      	ands	r2, r6
c0d00cfa:	4822      	ldr	r0, [pc, #136]	; (c0d00d84 <io_usb_hid_receive+0x148>)
c0d00cfc:	6800      	ldr	r0, [r0, #0]
c0d00cfe:	491d      	ldr	r1, [pc, #116]	; (c0d00d74 <io_usb_hid_receive+0x138>)
c0d00d00:	1d49      	adds	r1, r1, #5
c0d00d02:	e021      	b.n	c0d00d48 <io_usb_hid_receive+0x10c>
c0d00d04:	9301      	str	r3, [sp, #4]
c0d00d06:	491b      	ldr	r1, [pc, #108]	; (c0d00d74 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00d08:	7988      	ldrb	r0, [r1, #6]
c0d00d0a:	7949      	ldrb	r1, [r1, #5]
c0d00d0c:	0209      	lsls	r1, r1, #8
c0d00d0e:	4301      	orrs	r1, r0
c0d00d10:	481d      	ldr	r0, [pc, #116]	; (c0d00d88 <io_usb_hid_receive+0x14c>)
c0d00d12:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00d14:	6801      	ldr	r1, [r0, #0]
c0d00d16:	2241      	movs	r2, #65	; 0x41
c0d00d18:	0092      	lsls	r2, r2, #2
c0d00d1a:	4291      	cmp	r1, r2
c0d00d1c:	d8c9      	bhi.n	c0d00cb2 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00d1e:	6801      	ldr	r1, [r0, #0]
c0d00d20:	4817      	ldr	r0, [pc, #92]	; (c0d00d80 <io_usb_hid_receive+0x144>)
c0d00d22:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00d24:	4917      	ldr	r1, [pc, #92]	; (c0d00d84 <io_usb_hid_receive+0x148>)
c0d00d26:	4a19      	ldr	r2, [pc, #100]	; (c0d00d8c <io_usb_hid_receive+0x150>)
c0d00d28:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00d2a:	4919      	ldr	r1, [pc, #100]	; (c0d00d90 <io_usb_hid_receive+0x154>)
c0d00d2c:	9a02      	ldr	r2, [sp, #8]
c0d00d2e:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00d30:	4629      	mov	r1, r5
c0d00d32:	9e01      	ldr	r6, [sp, #4]
c0d00d34:	4031      	ands	r1, r6
c0d00d36:	6802      	ldr	r2, [r0, #0]
c0d00d38:	4291      	cmp	r1, r2
c0d00d3a:	d900      	bls.n	c0d00d3e <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00d3c:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00d3e:	462a      	mov	r2, r5
c0d00d40:	4032      	ands	r2, r6
c0d00d42:	480c      	ldr	r0, [pc, #48]	; (c0d00d74 <io_usb_hid_receive+0x138>)
c0d00d44:	1dc1      	adds	r1, r0, #7
c0d00d46:	4811      	ldr	r0, [pc, #68]	; (c0d00d8c <io_usb_hid_receive+0x150>)
c0d00d48:	f000 f82e 	bl	c0d00da8 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00d4c:	4035      	ands	r5, r6
c0d00d4e:	480d      	ldr	r0, [pc, #52]	; (c0d00d84 <io_usb_hid_receive+0x148>)
c0d00d50:	6801      	ldr	r1, [r0, #0]
c0d00d52:	1949      	adds	r1, r1, r5
c0d00d54:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00d56:	480a      	ldr	r0, [pc, #40]	; (c0d00d80 <io_usb_hid_receive+0x144>)
c0d00d58:	6801      	ldr	r1, [r0, #0]
c0d00d5a:	1b49      	subs	r1, r1, r5
c0d00d5c:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00d5e:	6820      	ldr	r0, [r4, #0]
c0d00d60:	1c40      	adds	r0, r0, #1
c0d00d62:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00d64:	4806      	ldr	r0, [pc, #24]	; (c0d00d80 <io_usb_hid_receive+0x144>)
c0d00d66:	6801      	ldr	r1, [r0, #0]
c0d00d68:	2001      	movs	r0, #1
c0d00d6a:	2602      	movs	r6, #2
c0d00d6c:	2900      	cmp	r1, #0
c0d00d6e:	d1a4      	bne.n	c0d00cba <io_usb_hid_receive+0x7e>
c0d00d70:	e79f      	b.n	c0d00cb2 <io_usb_hid_receive+0x76>
c0d00d72:	46c0      	nop			; (mov r8, r8)
c0d00d74:	20001bbc 	.word	0x20001bbc
c0d00d78:	20001bfc 	.word	0x20001bfc
c0d00d7c:	0000ffff 	.word	0x0000ffff
c0d00d80:	20001c04 	.word	0x20001c04
c0d00d84:	20001d0c 	.word	0x20001d0c
c0d00d88:	20001c00 	.word	0x20001c00
c0d00d8c:	20001c08 	.word	0x20001c08
c0d00d90:	0001fff9 	.word	0x0001fff9

c0d00d94 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00d94:	b580      	push	{r7, lr}
c0d00d96:	af00      	add	r7, sp, #0
c0d00d98:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00d9a:	2a00      	cmp	r2, #0
c0d00d9c:	d003      	beq.n	c0d00da6 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00d9e:	4611      	mov	r1, r2
c0d00da0:	461a      	mov	r2, r3
c0d00da2:	f002 fa47 	bl	c0d03234 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00da6:	bd80      	pop	{r7, pc}

c0d00da8 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00da8:	b5b0      	push	{r4, r5, r7, lr}
c0d00daa:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00dac:	4288      	cmp	r0, r1
c0d00dae:	d90d      	bls.n	c0d00dcc <os_memmove+0x24>
    while(length--) {
c0d00db0:	2a00      	cmp	r2, #0
c0d00db2:	d014      	beq.n	c0d00dde <os_memmove+0x36>
c0d00db4:	1e49      	subs	r1, r1, #1
c0d00db6:	4252      	negs	r2, r2
c0d00db8:	1e40      	subs	r0, r0, #1
c0d00dba:	2300      	movs	r3, #0
c0d00dbc:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00dbe:	461c      	mov	r4, r3
c0d00dc0:	4354      	muls	r4, r2
c0d00dc2:	5d0d      	ldrb	r5, [r1, r4]
c0d00dc4:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00dc6:	1c52      	adds	r2, r2, #1
c0d00dc8:	d1f9      	bne.n	c0d00dbe <os_memmove+0x16>
c0d00dca:	e008      	b.n	c0d00dde <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00dcc:	2a00      	cmp	r2, #0
c0d00dce:	d006      	beq.n	c0d00dde <os_memmove+0x36>
c0d00dd0:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00dd2:	b29c      	uxth	r4, r3
c0d00dd4:	5d0d      	ldrb	r5, [r1, r4]
c0d00dd6:	5505      	strb	r5, [r0, r4]
      l++;
c0d00dd8:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00dda:	1e52      	subs	r2, r2, #1
c0d00ddc:	d1f9      	bne.n	c0d00dd2 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00dde:	bdb0      	pop	{r4, r5, r7, pc}

c0d00de0 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00de0:	4801      	ldr	r0, [pc, #4]	; (c0d00de8 <io_usb_hid_init+0x8>)
c0d00de2:	2100      	movs	r1, #0
c0d00de4:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00de6:	4770      	bx	lr
c0d00de8:	20001bfc 	.word	0x20001bfc

c0d00dec <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00dec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00dee:	af03      	add	r7, sp, #12
c0d00df0:	b087      	sub	sp, #28
c0d00df2:	9301      	str	r3, [sp, #4]
c0d00df4:	9203      	str	r2, [sp, #12]
c0d00df6:	460e      	mov	r6, r1
c0d00df8:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00dfa:	2e00      	cmp	r6, #0
c0d00dfc:	d042      	beq.n	c0d00e84 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00dfe:	4d31      	ldr	r5, [pc, #196]	; (c0d00ec4 <io_usb_hid_exchange+0xd8>)
c0d00e00:	2000      	movs	r0, #0
c0d00e02:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00e04:	4930      	ldr	r1, [pc, #192]	; (c0d00ec8 <io_usb_hid_exchange+0xdc>)
c0d00e06:	4831      	ldr	r0, [pc, #196]	; (c0d00ecc <io_usb_hid_exchange+0xe0>)
c0d00e08:	6008      	str	r0, [r1, #0]
c0d00e0a:	4c31      	ldr	r4, [pc, #196]	; (c0d00ed0 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00e0c:	1d60      	adds	r0, r4, #5
c0d00e0e:	213b      	movs	r1, #59	; 0x3b
c0d00e10:	9005      	str	r0, [sp, #20]
c0d00e12:	9102      	str	r1, [sp, #8]
c0d00e14:	f002 fa04 	bl	c0d03220 <__aeabi_memclr>
c0d00e18:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00e1a:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00e1c:	6828      	ldr	r0, [r5, #0]
c0d00e1e:	0a00      	lsrs	r0, r0, #8
c0d00e20:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00e22:	6828      	ldr	r0, [r5, #0]
c0d00e24:	7120      	strb	r0, [r4, #4]
c0d00e26:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00e28:	6828      	ldr	r0, [r5, #0]
c0d00e2a:	2800      	cmp	r0, #0
c0d00e2c:	9106      	str	r1, [sp, #24]
c0d00e2e:	d009      	beq.n	c0d00e44 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00e30:	293b      	cmp	r1, #59	; 0x3b
c0d00e32:	460a      	mov	r2, r1
c0d00e34:	d300      	bcc.n	c0d00e38 <io_usb_hid_exchange+0x4c>
c0d00e36:	9a02      	ldr	r2, [sp, #8]
c0d00e38:	4823      	ldr	r0, [pc, #140]	; (c0d00ec8 <io_usb_hid_exchange+0xdc>)
c0d00e3a:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00e3c:	6819      	ldr	r1, [r3, #0]
c0d00e3e:	9805      	ldr	r0, [sp, #20]
c0d00e40:	461e      	mov	r6, r3
c0d00e42:	e00a      	b.n	c0d00e5a <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00e44:	0a30      	lsrs	r0, r6, #8
c0d00e46:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00e48:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00e4a:	2039      	movs	r0, #57	; 0x39
c0d00e4c:	2939      	cmp	r1, #57	; 0x39
c0d00e4e:	460a      	mov	r2, r1
c0d00e50:	d300      	bcc.n	c0d00e54 <io_usb_hid_exchange+0x68>
c0d00e52:	4602      	mov	r2, r0
c0d00e54:	4e1c      	ldr	r6, [pc, #112]	; (c0d00ec8 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00e56:	6831      	ldr	r1, [r6, #0]
c0d00e58:	1de0      	adds	r0, r4, #7
c0d00e5a:	9205      	str	r2, [sp, #20]
c0d00e5c:	f7ff ffa4 	bl	c0d00da8 <os_memmove>
c0d00e60:	4d18      	ldr	r5, [pc, #96]	; (c0d00ec4 <io_usb_hid_exchange+0xd8>)
c0d00e62:	6830      	ldr	r0, [r6, #0]
c0d00e64:	4631      	mov	r1, r6
c0d00e66:	9e05      	ldr	r6, [sp, #20]
c0d00e68:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00e6a:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00e6c:	6828      	ldr	r0, [r5, #0]
c0d00e6e:	1c40      	adds	r0, r0, #1
c0d00e70:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00e72:	2140      	movs	r1, #64	; 0x40
c0d00e74:	4620      	mov	r0, r4
c0d00e76:	9a04      	ldr	r2, [sp, #16]
c0d00e78:	4790      	blx	r2
c0d00e7a:	9806      	ldr	r0, [sp, #24]
c0d00e7c:	1b86      	subs	r6, r0, r6
c0d00e7e:	4815      	ldr	r0, [pc, #84]	; (c0d00ed4 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00e80:	4206      	tst	r6, r0
c0d00e82:	d1c3      	bne.n	c0d00e0c <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00e84:	480f      	ldr	r0, [pc, #60]	; (c0d00ec4 <io_usb_hid_exchange+0xd8>)
c0d00e86:	2400      	movs	r4, #0
c0d00e88:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00e8a:	2080      	movs	r0, #128	; 0x80
c0d00e8c:	9901      	ldr	r1, [sp, #4]
c0d00e8e:	4201      	tst	r1, r0
c0d00e90:	d001      	beq.n	c0d00e96 <io_usb_hid_exchange+0xaa>
    reset();
c0d00e92:	f000 fe3f 	bl	c0d01b14 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00e96:	9801      	ldr	r0, [sp, #4]
c0d00e98:	0680      	lsls	r0, r0, #26
c0d00e9a:	d40f      	bmi.n	c0d00ebc <io_usb_hid_exchange+0xd0>
c0d00e9c:	4c0c      	ldr	r4, [pc, #48]	; (c0d00ed0 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00e9e:	2140      	movs	r1, #64	; 0x40
c0d00ea0:	4620      	mov	r0, r4
c0d00ea2:	9a03      	ldr	r2, [sp, #12]
c0d00ea4:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00ea6:	b2c2      	uxtb	r2, r0
c0d00ea8:	2a40      	cmp	r2, #64	; 0x40
c0d00eaa:	d8f8      	bhi.n	c0d00e9e <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00eac:	9804      	ldr	r0, [sp, #16]
c0d00eae:	4621      	mov	r1, r4
c0d00eb0:	f7ff fec4 	bl	c0d00c3c <io_usb_hid_receive>
c0d00eb4:	2802      	cmp	r0, #2
c0d00eb6:	d1f2      	bne.n	c0d00e9e <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00eb8:	4807      	ldr	r0, [pc, #28]	; (c0d00ed8 <io_usb_hid_exchange+0xec>)
c0d00eba:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00ebc:	b2a0      	uxth	r0, r4
c0d00ebe:	b007      	add	sp, #28
c0d00ec0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ec2:	46c0      	nop			; (mov r8, r8)
c0d00ec4:	20001bfc 	.word	0x20001bfc
c0d00ec8:	20001d0c 	.word	0x20001d0c
c0d00ecc:	20001c08 	.word	0x20001c08
c0d00ed0:	20001bbc 	.word	0x20001bbc
c0d00ed4:	0000ffff 	.word	0x0000ffff
c0d00ed8:	20001c00 	.word	0x20001c00

c0d00edc <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00edc:	b580      	push	{r7, lr}
c0d00ede:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00ee0:	f000 ffbc 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d00ee4:	2800      	cmp	r0, #0
c0d00ee6:	d10b      	bne.n	c0d00f00 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00ee8:	4806      	ldr	r0, [pc, #24]	; (c0d00f04 <io_seproxyhal_general_status+0x28>)
c0d00eea:	2160      	movs	r1, #96	; 0x60
c0d00eec:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00eee:	2100      	movs	r1, #0
c0d00ef0:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00ef2:	2202      	movs	r2, #2
c0d00ef4:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00ef6:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00ef8:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00efa:	2105      	movs	r1, #5
c0d00efc:	f000 ff90 	bl	c0d01e20 <io_seproxyhal_spi_send>
}
c0d00f00:	bd80      	pop	{r7, pc}
c0d00f02:	46c0      	nop			; (mov r8, r8)
c0d00f04:	20001a18 	.word	0x20001a18

c0d00f08 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00f08:	b5d0      	push	{r4, r6, r7, lr}
c0d00f0a:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00f0c:	4815      	ldr	r0, [pc, #84]	; (c0d00f64 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00f0e:	78c0      	ldrb	r0, [r0, #3]
c0d00f10:	1e40      	subs	r0, r0, #1
c0d00f12:	2807      	cmp	r0, #7
c0d00f14:	d824      	bhi.n	c0d00f60 <io_seproxyhal_handle_usb_event+0x58>
c0d00f16:	46c0      	nop			; (mov r8, r8)
c0d00f18:	4478      	add	r0, pc
c0d00f1a:	7900      	ldrb	r0, [r0, #4]
c0d00f1c:	0040      	lsls	r0, r0, #1
c0d00f1e:	4487      	add	pc, r0
c0d00f20:	141f1803 	.word	0x141f1803
c0d00f24:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00f28:	4c0f      	ldr	r4, [pc, #60]	; (c0d00f68 <io_seproxyhal_handle_usb_event+0x60>)
c0d00f2a:	2101      	movs	r1, #1
c0d00f2c:	4620      	mov	r0, r4
c0d00f2e:	f001 fbd5 	bl	c0d026dc <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00f32:	4620      	mov	r0, r4
c0d00f34:	f001 fbba 	bl	c0d026ac <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00f38:	480c      	ldr	r0, [pc, #48]	; (c0d00f6c <io_seproxyhal_handle_usb_event+0x64>)
c0d00f3a:	7800      	ldrb	r0, [r0, #0]
c0d00f3c:	2801      	cmp	r0, #1
c0d00f3e:	d10f      	bne.n	c0d00f60 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00f40:	480b      	ldr	r0, [pc, #44]	; (c0d00f70 <io_seproxyhal_handle_usb_event+0x68>)
c0d00f42:	6800      	ldr	r0, [r0, #0]
c0d00f44:	2110      	movs	r1, #16
c0d00f46:	f002 fa0d 	bl	c0d03364 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00f4a:	4807      	ldr	r0, [pc, #28]	; (c0d00f68 <io_seproxyhal_handle_usb_event+0x60>)
c0d00f4c:	f001 fbc9 	bl	c0d026e2 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00f50:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00f52:	4805      	ldr	r0, [pc, #20]	; (c0d00f68 <io_seproxyhal_handle_usb_event+0x60>)
c0d00f54:	f001 fbc9 	bl	c0d026ea <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00f58:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00f5a:	4803      	ldr	r0, [pc, #12]	; (c0d00f68 <io_seproxyhal_handle_usb_event+0x60>)
c0d00f5c:	f001 fbc3 	bl	c0d026e6 <USBD_LL_Resume>
      break;
  }
}
c0d00f60:	bdd0      	pop	{r4, r6, r7, pc}
c0d00f62:	46c0      	nop			; (mov r8, r8)
c0d00f64:	20001a18 	.word	0x20001a18
c0d00f68:	20001d34 	.word	0x20001d34
c0d00f6c:	20001d10 	.word	0x20001d10
c0d00f70:	20001bb8 	.word	0x20001bb8

c0d00f74 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00f74:	217f      	movs	r1, #127	; 0x7f
c0d00f76:	4001      	ands	r1, r0
c0d00f78:	4801      	ldr	r0, [pc, #4]	; (c0d00f80 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00f7a:	5c40      	ldrb	r0, [r0, r1]
c0d00f7c:	4770      	bx	lr
c0d00f7e:	46c0      	nop			; (mov r8, r8)
c0d00f80:	20001d11 	.word	0x20001d11

c0d00f84 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00f84:	b580      	push	{r7, lr}
c0d00f86:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00f88:	480f      	ldr	r0, [pc, #60]	; (c0d00fc8 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00f8a:	7901      	ldrb	r1, [r0, #4]
c0d00f8c:	2904      	cmp	r1, #4
c0d00f8e:	d008      	beq.n	c0d00fa2 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00f90:	2902      	cmp	r1, #2
c0d00f92:	d011      	beq.n	c0d00fb8 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00f94:	2901      	cmp	r1, #1
c0d00f96:	d10e      	bne.n	c0d00fb6 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00f98:	1d81      	adds	r1, r0, #6
c0d00f9a:	480d      	ldr	r0, [pc, #52]	; (c0d00fd0 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f9c:	f001 faaa 	bl	c0d024f4 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00fa0:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00fa2:	78c2      	ldrb	r2, [r0, #3]
c0d00fa4:	217f      	movs	r1, #127	; 0x7f
c0d00fa6:	4011      	ands	r1, r2
c0d00fa8:	7942      	ldrb	r2, [r0, #5]
c0d00faa:	4b08      	ldr	r3, [pc, #32]	; (c0d00fcc <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00fac:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00fae:	1d82      	adds	r2, r0, #6
c0d00fb0:	4807      	ldr	r0, [pc, #28]	; (c0d00fd0 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00fb2:	f001 fad1 	bl	c0d02558 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00fb6:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00fb8:	78c2      	ldrb	r2, [r0, #3]
c0d00fba:	217f      	movs	r1, #127	; 0x7f
c0d00fbc:	4011      	ands	r1, r2
c0d00fbe:	1d82      	adds	r2, r0, #6
c0d00fc0:	4803      	ldr	r0, [pc, #12]	; (c0d00fd0 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00fc2:	f001 fb0f 	bl	c0d025e4 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00fc6:	bd80      	pop	{r7, pc}
c0d00fc8:	20001a18 	.word	0x20001a18
c0d00fcc:	20001d11 	.word	0x20001d11
c0d00fd0:	20001d34 	.word	0x20001d34

c0d00fd4 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00fd4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fd6:	af03      	add	r7, sp, #12
c0d00fd8:	b083      	sub	sp, #12
c0d00fda:	9201      	str	r2, [sp, #4]
c0d00fdc:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00fde:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00fe0:	2b00      	cmp	r3, #0
c0d00fe2:	d100      	bne.n	c0d00fe6 <io_usb_send_ep+0x12>
c0d00fe4:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00fe6:	9801      	ldr	r0, [sp, #4]
c0d00fe8:	28ff      	cmp	r0, #255	; 0xff
c0d00fea:	d843      	bhi.n	c0d01074 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00fec:	4e25      	ldr	r6, [pc, #148]	; (c0d01084 <io_usb_send_ep+0xb0>)
c0d00fee:	2050      	movs	r0, #80	; 0x50
c0d00ff0:	7030      	strb	r0, [r6, #0]
c0d00ff2:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00ff4:	1ce0      	adds	r0, r4, #3
c0d00ff6:	9100      	str	r1, [sp, #0]
c0d00ff8:	0a01      	lsrs	r1, r0, #8
c0d00ffa:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00ffc:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00ffe:	2080      	movs	r0, #128	; 0x80
c0d01000:	4302      	orrs	r2, r0
c0d01002:	9202      	str	r2, [sp, #8]
c0d01004:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d01006:	2020      	movs	r0, #32
c0d01008:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0100a:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d0100c:	2106      	movs	r1, #6
c0d0100e:	4630      	mov	r0, r6
c0d01010:	f000 ff06 	bl	c0d01e20 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01014:	9800      	ldr	r0, [sp, #0]
c0d01016:	4621      	mov	r1, r4
c0d01018:	f000 ff02 	bl	c0d01e20 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d0101c:	2d00      	cmp	r5, #0
c0d0101e:	d10d      	bne.n	c0d0103c <io_usb_send_ep+0x68>
c0d01020:	e028      	b.n	c0d01074 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d01022:	2d00      	cmp	r5, #0
c0d01024:	d002      	beq.n	c0d0102c <io_usb_send_ep+0x58>
c0d01026:	1e6c      	subs	r4, r5, #1
c0d01028:	2d01      	cmp	r5, #1
c0d0102a:	d025      	beq.n	c0d01078 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d0102c:	2915      	cmp	r1, #21
c0d0102e:	d102      	bne.n	c0d01036 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01030:	79b0      	ldrb	r0, [r6, #6]
c0d01032:	0700      	lsls	r0, r0, #28
c0d01034:	d520      	bpl.n	c0d01078 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d01036:	f000 f829 	bl	c0d0108c <io_seproxyhal_handle_event>
c0d0103a:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d0103c:	f000 ff0e 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d01040:	2800      	cmp	r0, #0
c0d01042:	d101      	bne.n	c0d01048 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01044:	f7ff ff4a 	bl	c0d00edc <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01048:	2180      	movs	r1, #128	; 0x80
c0d0104a:	2400      	movs	r4, #0
c0d0104c:	4630      	mov	r0, r6
c0d0104e:	4622      	mov	r2, r4
c0d01050:	f000 ff20 	bl	c0d01e94 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01054:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d01056:	2806      	cmp	r0, #6
c0d01058:	d1e3      	bne.n	c0d01022 <io_usb_send_ep+0x4e>
c0d0105a:	2910      	cmp	r1, #16
c0d0105c:	d1e1      	bne.n	c0d01022 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d0105e:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01060:	9a02      	ldr	r2, [sp, #8]
c0d01062:	4290      	cmp	r0, r2
c0d01064:	d1dd      	bne.n	c0d01022 <io_usb_send_ep+0x4e>
c0d01066:	7930      	ldrb	r0, [r6, #4]
c0d01068:	2802      	cmp	r0, #2
c0d0106a:	d1da      	bne.n	c0d01022 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d0106c:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d0106e:	9a01      	ldr	r2, [sp, #4]
c0d01070:	4290      	cmp	r0, r2
c0d01072:	d1d6      	bne.n	c0d01022 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01074:	b003      	add	sp, #12
c0d01076:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01078:	4803      	ldr	r0, [pc, #12]	; (c0d01088 <io_usb_send_ep+0xb4>)
c0d0107a:	6800      	ldr	r0, [r0, #0]
c0d0107c:	2110      	movs	r1, #16
c0d0107e:	f002 f971 	bl	c0d03364 <longjmp>
c0d01082:	46c0      	nop			; (mov r8, r8)
c0d01084:	20001a18 	.word	0x20001a18
c0d01088:	20001bb8 	.word	0x20001bb8

c0d0108c <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d0108c:	b580      	push	{r7, lr}
c0d0108e:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01090:	480d      	ldr	r0, [pc, #52]	; (c0d010c8 <io_seproxyhal_handle_event+0x3c>)
c0d01092:	7882      	ldrb	r2, [r0, #2]
c0d01094:	7841      	ldrb	r1, [r0, #1]
c0d01096:	0209      	lsls	r1, r1, #8
c0d01098:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0109a:	7800      	ldrb	r0, [r0, #0]
c0d0109c:	2810      	cmp	r0, #16
c0d0109e:	d008      	beq.n	c0d010b2 <io_seproxyhal_handle_event+0x26>
c0d010a0:	280f      	cmp	r0, #15
c0d010a2:	d10d      	bne.n	c0d010c0 <io_seproxyhal_handle_event+0x34>
c0d010a4:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d010a6:	2904      	cmp	r1, #4
c0d010a8:	d10d      	bne.n	c0d010c6 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d010aa:	f7ff ff2d 	bl	c0d00f08 <io_seproxyhal_handle_usb_event>
c0d010ae:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d010b0:	bd80      	pop	{r7, pc}
c0d010b2:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d010b4:	2906      	cmp	r1, #6
c0d010b6:	d306      	bcc.n	c0d010c6 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d010b8:	f7ff ff64 	bl	c0d00f84 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d010bc:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d010be:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d010c0:	2002      	movs	r0, #2
c0d010c2:	f7ff faf5 	bl	c0d006b0 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d010c6:	bd80      	pop	{r7, pc}
c0d010c8:	20001a18 	.word	0x20001a18

c0d010cc <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d010cc:	b580      	push	{r7, lr}
c0d010ce:	af00      	add	r7, sp, #0
c0d010d0:	460a      	mov	r2, r1
c0d010d2:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d010d4:	2082      	movs	r0, #130	; 0x82
c0d010d6:	2314      	movs	r3, #20
c0d010d8:	f7ff ff7c 	bl	c0d00fd4 <io_usb_send_ep>
}
c0d010dc:	bd80      	pop	{r7, pc}
	...

c0d010e0 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d010e0:	b5d0      	push	{r4, r6, r7, lr}
c0d010e2:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d010e4:	2007      	movs	r0, #7
c0d010e6:	f000 fcf7 	bl	c0d01ad8 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d010ea:	480a      	ldr	r0, [pc, #40]	; (c0d01114 <io_seproxyhal_init+0x34>)
c0d010ec:	2400      	movs	r4, #0
c0d010ee:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d010f0:	4809      	ldr	r0, [pc, #36]	; (c0d01118 <io_seproxyhal_init+0x38>)
c0d010f2:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d010f4:	4809      	ldr	r0, [pc, #36]	; (c0d0111c <io_seproxyhal_init+0x3c>)
c0d010f6:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d010f8:	4809      	ldr	r0, [pc, #36]	; (c0d01120 <io_seproxyhal_init+0x40>)
c0d010fa:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d010fc:	4809      	ldr	r0, [pc, #36]	; (c0d01124 <io_seproxyhal_init+0x44>)
c0d010fe:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01100:	f7ff fe6e 	bl	c0d00de0 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01104:	4808      	ldr	r0, [pc, #32]	; (c0d01128 <io_seproxyhal_init+0x48>)
c0d01106:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01108:	4808      	ldr	r0, [pc, #32]	; (c0d0112c <io_seproxyhal_init+0x4c>)
c0d0110a:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d0110c:	4808      	ldr	r0, [pc, #32]	; (c0d01130 <io_seproxyhal_init+0x50>)
c0d0110e:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01110:	bdd0      	pop	{r4, r6, r7, pc}
c0d01112:	46c0      	nop			; (mov r8, r8)
c0d01114:	20001d18 	.word	0x20001d18
c0d01118:	20001d1a 	.word	0x20001d1a
c0d0111c:	20001d1c 	.word	0x20001d1c
c0d01120:	20001d1e 	.word	0x20001d1e
c0d01124:	20001d10 	.word	0x20001d10
c0d01128:	20001d20 	.word	0x20001d20
c0d0112c:	20001d24 	.word	0x20001d24
c0d01130:	20001d28 	.word	0x20001d28

c0d01134 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01134:	4801      	ldr	r0, [pc, #4]	; (c0d0113c <io_seproxyhal_init_ux+0x8>)
c0d01136:	2100      	movs	r1, #0
c0d01138:	6001      	str	r1, [r0, #0]

}
c0d0113a:	4770      	bx	lr
c0d0113c:	20001d20 	.word	0x20001d20

c0d01140 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01140:	b5b0      	push	{r4, r5, r7, lr}
c0d01142:	af02      	add	r7, sp, #8
c0d01144:	460d      	mov	r5, r1
c0d01146:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d01148:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d0114a:	2800      	cmp	r0, #0
c0d0114c:	d00c      	beq.n	c0d01168 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d0114e:	f000 fcab 	bl	c0d01aa8 <pic>
c0d01152:	4601      	mov	r1, r0
c0d01154:	4620      	mov	r0, r4
c0d01156:	4788      	blx	r1
c0d01158:	f000 fca6 	bl	c0d01aa8 <pic>
c0d0115c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d0115e:	2800      	cmp	r0, #0
c0d01160:	d010      	beq.n	c0d01184 <io_seproxyhal_touch_out+0x44>
c0d01162:	2801      	cmp	r0, #1
c0d01164:	d000      	beq.n	c0d01168 <io_seproxyhal_touch_out+0x28>
c0d01166:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01168:	2d00      	cmp	r5, #0
c0d0116a:	d007      	beq.n	c0d0117c <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d0116c:	4620      	mov	r0, r4
c0d0116e:	47a8      	blx	r5
c0d01170:	2100      	movs	r1, #0
    if (!el) {
c0d01172:	2800      	cmp	r0, #0
c0d01174:	d006      	beq.n	c0d01184 <io_seproxyhal_touch_out+0x44>
c0d01176:	2801      	cmp	r0, #1
c0d01178:	d000      	beq.n	c0d0117c <io_seproxyhal_touch_out+0x3c>
c0d0117a:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d0117c:	4620      	mov	r0, r4
c0d0117e:	f7ff fa91 	bl	c0d006a4 <io_seproxyhal_display>
c0d01182:	2101      	movs	r1, #1
  return 1;
}
c0d01184:	4608      	mov	r0, r1
c0d01186:	bdb0      	pop	{r4, r5, r7, pc}

c0d01188 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01188:	b5b0      	push	{r4, r5, r7, lr}
c0d0118a:	af02      	add	r7, sp, #8
c0d0118c:	b08e      	sub	sp, #56	; 0x38
c0d0118e:	460c      	mov	r4, r1
c0d01190:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01192:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01194:	2800      	cmp	r0, #0
c0d01196:	d00c      	beq.n	c0d011b2 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01198:	f000 fc86 	bl	c0d01aa8 <pic>
c0d0119c:	4601      	mov	r1, r0
c0d0119e:	4628      	mov	r0, r5
c0d011a0:	4788      	blx	r1
c0d011a2:	f000 fc81 	bl	c0d01aa8 <pic>
c0d011a6:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d011a8:	2800      	cmp	r0, #0
c0d011aa:	d016      	beq.n	c0d011da <io_seproxyhal_touch_over+0x52>
c0d011ac:	2801      	cmp	r0, #1
c0d011ae:	d000      	beq.n	c0d011b2 <io_seproxyhal_touch_over+0x2a>
c0d011b0:	4605      	mov	r5, r0
c0d011b2:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d011b4:	2238      	movs	r2, #56	; 0x38
c0d011b6:	4629      	mov	r1, r5
c0d011b8:	f7ff fdf6 	bl	c0d00da8 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d011bc:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d011be:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d011c0:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d011c2:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d011c4:	2c00      	cmp	r4, #0
c0d011c6:	d004      	beq.n	c0d011d2 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d011c8:	4628      	mov	r0, r5
c0d011ca:	47a0      	blx	r4
c0d011cc:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d011ce:	2800      	cmp	r0, #0
c0d011d0:	d003      	beq.n	c0d011da <io_seproxyhal_touch_over+0x52>
c0d011d2:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d011d4:	f7ff fa66 	bl	c0d006a4 <io_seproxyhal_display>
c0d011d8:	2101      	movs	r1, #1
  return 1;
}
c0d011da:	4608      	mov	r0, r1
c0d011dc:	b00e      	add	sp, #56	; 0x38
c0d011de:	bdb0      	pop	{r4, r5, r7, pc}

c0d011e0 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d011e0:	b5b0      	push	{r4, r5, r7, lr}
c0d011e2:	af02      	add	r7, sp, #8
c0d011e4:	460d      	mov	r5, r1
c0d011e6:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d011e8:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d011ea:	2800      	cmp	r0, #0
c0d011ec:	d00c      	beq.n	c0d01208 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d011ee:	f000 fc5b 	bl	c0d01aa8 <pic>
c0d011f2:	4601      	mov	r1, r0
c0d011f4:	4620      	mov	r0, r4
c0d011f6:	4788      	blx	r1
c0d011f8:	f000 fc56 	bl	c0d01aa8 <pic>
c0d011fc:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d011fe:	2800      	cmp	r0, #0
c0d01200:	d010      	beq.n	c0d01224 <io_seproxyhal_touch_tap+0x44>
c0d01202:	2801      	cmp	r0, #1
c0d01204:	d000      	beq.n	c0d01208 <io_seproxyhal_touch_tap+0x28>
c0d01206:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01208:	2d00      	cmp	r5, #0
c0d0120a:	d007      	beq.n	c0d0121c <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d0120c:	4620      	mov	r0, r4
c0d0120e:	47a8      	blx	r5
c0d01210:	2100      	movs	r1, #0
    if (!el) {
c0d01212:	2800      	cmp	r0, #0
c0d01214:	d006      	beq.n	c0d01224 <io_seproxyhal_touch_tap+0x44>
c0d01216:	2801      	cmp	r0, #1
c0d01218:	d000      	beq.n	c0d0121c <io_seproxyhal_touch_tap+0x3c>
c0d0121a:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d0121c:	4620      	mov	r0, r4
c0d0121e:	f7ff fa41 	bl	c0d006a4 <io_seproxyhal_display>
c0d01222:	2101      	movs	r1, #1
  return 1;
}
c0d01224:	4608      	mov	r0, r1
c0d01226:	bdb0      	pop	{r4, r5, r7, pc}

c0d01228 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01228:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0122a:	af03      	add	r7, sp, #12
c0d0122c:	b087      	sub	sp, #28
c0d0122e:	9302      	str	r3, [sp, #8]
c0d01230:	9203      	str	r2, [sp, #12]
c0d01232:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01234:	2900      	cmp	r1, #0
c0d01236:	d076      	beq.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
c0d01238:	9004      	str	r0, [sp, #16]
c0d0123a:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0123c:	9001      	str	r0, [sp, #4]
c0d0123e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01240:	9000      	str	r0, [sp, #0]
c0d01242:	2600      	movs	r6, #0
c0d01244:	9606      	str	r6, [sp, #24]
c0d01246:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01248:	f000 fe08 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d0124c:	2800      	cmp	r0, #0
c0d0124e:	d155      	bne.n	c0d012fc <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d01250:	2038      	movs	r0, #56	; 0x38
c0d01252:	4370      	muls	r0, r6
c0d01254:	9d04      	ldr	r5, [sp, #16]
c0d01256:	182e      	adds	r6, r5, r0
c0d01258:	4b36      	ldr	r3, [pc, #216]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0125a:	681a      	ldr	r2, [r3, #0]
c0d0125c:	2101      	movs	r1, #1
c0d0125e:	4296      	cmp	r6, r2
c0d01260:	d000      	beq.n	c0d01264 <io_seproxyhal_touch_element_callback+0x3c>
c0d01262:	9906      	ldr	r1, [sp, #24]
c0d01264:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01266:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01268:	2800      	cmp	r0, #0
c0d0126a:	da41      	bge.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
c0d0126c:	2020      	movs	r0, #32
c0d0126e:	5c35      	ldrb	r5, [r6, r0]
c0d01270:	2102      	movs	r1, #2
c0d01272:	5e71      	ldrsh	r1, [r6, r1]
c0d01274:	1b4a      	subs	r2, r1, r5
c0d01276:	9803      	ldr	r0, [sp, #12]
c0d01278:	4282      	cmp	r2, r0
c0d0127a:	dc39      	bgt.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
c0d0127c:	1869      	adds	r1, r5, r1
c0d0127e:	88f2      	ldrh	r2, [r6, #6]
c0d01280:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d01282:	9803      	ldr	r0, [sp, #12]
c0d01284:	4288      	cmp	r0, r1
c0d01286:	da33      	bge.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
c0d01288:	2104      	movs	r1, #4
c0d0128a:	5e70      	ldrsh	r0, [r6, r1]
c0d0128c:	1b42      	subs	r2, r0, r5
c0d0128e:	9902      	ldr	r1, [sp, #8]
c0d01290:	428a      	cmp	r2, r1
c0d01292:	dc2d      	bgt.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
c0d01294:	1940      	adds	r0, r0, r5
c0d01296:	8931      	ldrh	r1, [r6, #8]
c0d01298:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0129a:	9902      	ldr	r1, [sp, #8]
c0d0129c:	4281      	cmp	r1, r0
c0d0129e:	da27      	bge.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d012a0:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d012a2:	4286      	cmp	r6, r0
c0d012a4:	d010      	beq.n	c0d012c8 <io_seproxyhal_touch_element_callback+0xa0>
c0d012a6:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d012a8:	2800      	cmp	r0, #0
c0d012aa:	d00d      	beq.n	c0d012c8 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d012ac:	9801      	ldr	r0, [sp, #4]
c0d012ae:	2800      	cmp	r0, #0
c0d012b0:	d005      	beq.n	c0d012be <io_seproxyhal_touch_element_callback+0x96>
c0d012b2:	4630      	mov	r0, r6
c0d012b4:	9901      	ldr	r1, [sp, #4]
c0d012b6:	4788      	blx	r1
c0d012b8:	4b1e      	ldr	r3, [pc, #120]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d012ba:	2800      	cmp	r0, #0
c0d012bc:	d018      	beq.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d012be:	6818      	ldr	r0, [r3, #0]
c0d012c0:	9901      	ldr	r1, [sp, #4]
c0d012c2:	f7ff ff3d 	bl	c0d01140 <io_seproxyhal_touch_out>
c0d012c6:	e008      	b.n	c0d012da <io_seproxyhal_touch_element_callback+0xb2>
c0d012c8:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d012ca:	2801      	cmp	r0, #1
c0d012cc:	d009      	beq.n	c0d012e2 <io_seproxyhal_touch_element_callback+0xba>
c0d012ce:	2802      	cmp	r0, #2
c0d012d0:	d10e      	bne.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d012d2:	4630      	mov	r0, r6
c0d012d4:	9901      	ldr	r1, [sp, #4]
c0d012d6:	f7ff ff83 	bl	c0d011e0 <io_seproxyhal_touch_tap>
c0d012da:	4b16      	ldr	r3, [pc, #88]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d012dc:	2800      	cmp	r0, #0
c0d012de:	d007      	beq.n	c0d012f0 <io_seproxyhal_touch_element_callback+0xc8>
c0d012e0:	e023      	b.n	c0d0132a <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d012e2:	4630      	mov	r0, r6
c0d012e4:	9901      	ldr	r1, [sp, #4]
c0d012e6:	f7ff ff4f 	bl	c0d01188 <io_seproxyhal_touch_over>
c0d012ea:	4b12      	ldr	r3, [pc, #72]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d012ec:	2800      	cmp	r0, #0
c0d012ee:	d11f      	bne.n	c0d01330 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d012f0:	1c64      	adds	r4, r4, #1
c0d012f2:	b2e6      	uxtb	r6, r4
c0d012f4:	9805      	ldr	r0, [sp, #20]
c0d012f6:	4286      	cmp	r6, r0
c0d012f8:	d3a6      	bcc.n	c0d01248 <io_seproxyhal_touch_element_callback+0x20>
c0d012fa:	e000      	b.n	c0d012fe <io_seproxyhal_touch_element_callback+0xd6>
c0d012fc:	4b0d      	ldr	r3, [pc, #52]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d012fe:	9806      	ldr	r0, [sp, #24]
c0d01300:	0600      	lsls	r0, r0, #24
c0d01302:	d010      	beq.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
c0d01304:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01306:	2800      	cmp	r0, #0
c0d01308:	d00d      	beq.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0130a:	f000 fda7 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d0130e:	4909      	ldr	r1, [pc, #36]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01310:	2800      	cmp	r0, #0
c0d01312:	d108      	bne.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01314:	6808      	ldr	r0, [r1, #0]
c0d01316:	9901      	ldr	r1, [sp, #4]
c0d01318:	f7ff ff12 	bl	c0d01140 <io_seproxyhal_touch_out>
c0d0131c:	4d05      	ldr	r5, [pc, #20]	; (c0d01334 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0131e:	2800      	cmp	r0, #0
c0d01320:	d001      	beq.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01322:	2000      	movs	r0, #0
c0d01324:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01326:	b007      	add	sp, #28
c0d01328:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0132a:	2000      	movs	r0, #0
c0d0132c:	6018      	str	r0, [r3, #0]
c0d0132e:	e7fa      	b.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01330:	601e      	str	r6, [r3, #0]
c0d01332:	e7f8      	b.n	c0d01326 <io_seproxyhal_touch_element_callback+0xfe>
c0d01334:	20001d20 	.word	0x20001d20

c0d01338 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01338:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0133a:	af03      	add	r7, sp, #12
c0d0133c:	b08b      	sub	sp, #44	; 0x2c
c0d0133e:	460c      	mov	r4, r1
c0d01340:	4601      	mov	r1, r0
c0d01342:	ad04      	add	r5, sp, #16
c0d01344:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01346:	4628      	mov	r0, r5
c0d01348:	9203      	str	r2, [sp, #12]
c0d0134a:	f7ff fd2d 	bl	c0d00da8 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d0134e:	6821      	ldr	r1, [r4, #0]
c0d01350:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01352:	6862      	ldr	r2, [r4, #4]
c0d01354:	9502      	str	r5, [sp, #8]
c0d01356:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01358:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0135a:	4e1a      	ldr	r6, [pc, #104]	; (c0d013c4 <io_seproxyhal_display_icon+0x8c>)
c0d0135c:	2365      	movs	r3, #101	; 0x65
c0d0135e:	4635      	mov	r5, r6
c0d01360:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01362:	b292      	uxth	r2, r2
c0d01364:	4342      	muls	r2, r0
c0d01366:	b28b      	uxth	r3, r1
c0d01368:	4353      	muls	r3, r2
c0d0136a:	08d9      	lsrs	r1, r3, #3
c0d0136c:	1c4e      	adds	r6, r1, #1
c0d0136e:	2207      	movs	r2, #7
c0d01370:	4213      	tst	r3, r2
c0d01372:	d100      	bne.n	c0d01376 <io_seproxyhal_display_icon+0x3e>
c0d01374:	460e      	mov	r6, r1
c0d01376:	4631      	mov	r1, r6
c0d01378:	9101      	str	r1, [sp, #4]
c0d0137a:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0137c:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d0137e:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01380:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01382:	0a01      	lsrs	r1, r0, #8
c0d01384:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01386:	70a8      	strb	r0, [r5, #2]
c0d01388:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0138a:	4628      	mov	r0, r5
c0d0138c:	f000 fd48 	bl	c0d01e20 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01390:	9802      	ldr	r0, [sp, #8]
c0d01392:	9903      	ldr	r1, [sp, #12]
c0d01394:	f000 fd44 	bl	c0d01e20 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01398:	68a0      	ldr	r0, [r4, #8]
c0d0139a:	7028      	strb	r0, [r5, #0]
c0d0139c:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0139e:	4628      	mov	r0, r5
c0d013a0:	f000 fd3e 	bl	c0d01e20 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d013a4:	68e0      	ldr	r0, [r4, #12]
c0d013a6:	f000 fb7f 	bl	c0d01aa8 <pic>
c0d013aa:	b2b1      	uxth	r1, r6
c0d013ac:	f000 fd38 	bl	c0d01e20 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d013b0:	9801      	ldr	r0, [sp, #4]
c0d013b2:	b285      	uxth	r5, r0
c0d013b4:	6920      	ldr	r0, [r4, #16]
c0d013b6:	f000 fb77 	bl	c0d01aa8 <pic>
c0d013ba:	4629      	mov	r1, r5
c0d013bc:	f000 fd30 	bl	c0d01e20 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d013c0:	b00b      	add	sp, #44	; 0x2c
c0d013c2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013c4:	20001a18 	.word	0x20001a18

c0d013c8 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d013c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013ca:	af03      	add	r7, sp, #12
c0d013cc:	b081      	sub	sp, #4
c0d013ce:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d013d0:	7820      	ldrb	r0, [r4, #0]
c0d013d2:	267f      	movs	r6, #127	; 0x7f
c0d013d4:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d013d6:	2e00      	cmp	r6, #0
c0d013d8:	d02e      	beq.n	c0d01438 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d013da:	69e0      	ldr	r0, [r4, #28]
c0d013dc:	2800      	cmp	r0, #0
c0d013de:	d01d      	beq.n	c0d0141c <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d013e0:	f000 fb62 	bl	c0d01aa8 <pic>
c0d013e4:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d013e6:	2e05      	cmp	r6, #5
c0d013e8:	d102      	bne.n	c0d013f0 <io_seproxyhal_display_default+0x28>
c0d013ea:	7ea0      	ldrb	r0, [r4, #26]
c0d013ec:	2800      	cmp	r0, #0
c0d013ee:	d025      	beq.n	c0d0143c <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d013f0:	4628      	mov	r0, r5
c0d013f2:	f001 ffc5 	bl	c0d03380 <strlen>
c0d013f6:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d013f8:	4813      	ldr	r0, [pc, #76]	; (c0d01448 <io_seproxyhal_display_default+0x80>)
c0d013fa:	2165      	movs	r1, #101	; 0x65
c0d013fc:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d013fe:	4631      	mov	r1, r6
c0d01400:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01402:	0a0a      	lsrs	r2, r1, #8
c0d01404:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01406:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01408:	2103      	movs	r1, #3
c0d0140a:	f000 fd09 	bl	c0d01e20 <io_seproxyhal_spi_send>
c0d0140e:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01410:	4620      	mov	r0, r4
c0d01412:	f000 fd05 	bl	c0d01e20 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01416:	b2b1      	uxth	r1, r6
c0d01418:	4628      	mov	r0, r5
c0d0141a:	e00b      	b.n	c0d01434 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0141c:	480a      	ldr	r0, [pc, #40]	; (c0d01448 <io_seproxyhal_display_default+0x80>)
c0d0141e:	2165      	movs	r1, #101	; 0x65
c0d01420:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01422:	2100      	movs	r1, #0
c0d01424:	7041      	strb	r1, [r0, #1]
c0d01426:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01428:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0142a:	2103      	movs	r1, #3
c0d0142c:	f000 fcf8 	bl	c0d01e20 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01430:	4620      	mov	r0, r4
c0d01432:	4629      	mov	r1, r5
c0d01434:	f000 fcf4 	bl	c0d01e20 <io_seproxyhal_spi_send>
    }
  }
}
c0d01438:	b001      	add	sp, #4
c0d0143a:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d0143c:	4620      	mov	r0, r4
c0d0143e:	4629      	mov	r1, r5
c0d01440:	f7ff ff7a 	bl	c0d01338 <io_seproxyhal_display_icon>
c0d01444:	e7f8      	b.n	c0d01438 <io_seproxyhal_display_default+0x70>
c0d01446:	46c0      	nop			; (mov r8, r8)
c0d01448:	20001a18 	.word	0x20001a18

c0d0144c <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d0144c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0144e:	af03      	add	r7, sp, #12
c0d01450:	b081      	sub	sp, #4
c0d01452:	4604      	mov	r4, r0
  if (button_callback) {
c0d01454:	2c00      	cmp	r4, #0
c0d01456:	d02e      	beq.n	c0d014b6 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01458:	4818      	ldr	r0, [pc, #96]	; (c0d014bc <io_seproxyhal_button_push+0x70>)
c0d0145a:	6802      	ldr	r2, [r0, #0]
c0d0145c:	428a      	cmp	r2, r1
c0d0145e:	d103      	bne.n	c0d01468 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01460:	4a17      	ldr	r2, [pc, #92]	; (c0d014c0 <io_seproxyhal_button_push+0x74>)
c0d01462:	6813      	ldr	r3, [r2, #0]
c0d01464:	1c5b      	adds	r3, r3, #1
c0d01466:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01468:	6806      	ldr	r6, [r0, #0]
c0d0146a:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d0146c:	4a14      	ldr	r2, [pc, #80]	; (c0d014c0 <io_seproxyhal_button_push+0x74>)
c0d0146e:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01470:	2900      	cmp	r1, #0
c0d01472:	d001      	beq.n	c0d01478 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01474:	6006      	str	r6, [r0, #0]
c0d01476:	e005      	b.n	c0d01484 <io_seproxyhal_button_push+0x38>
c0d01478:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d0147a:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d0147c:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d0147e:	2301      	movs	r3, #1
c0d01480:	07db      	lsls	r3, r3, #31
c0d01482:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01484:	6800      	ldr	r0, [r0, #0]
c0d01486:	4288      	cmp	r0, r1
c0d01488:	d001      	beq.n	c0d0148e <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d0148a:	2000      	movs	r0, #0
c0d0148c:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0148e:	2d08      	cmp	r5, #8
c0d01490:	d30e      	bcc.n	c0d014b0 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01492:	2103      	movs	r1, #3
c0d01494:	4628      	mov	r0, r5
c0d01496:	f001 fda7 	bl	c0d02fe8 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d0149a:	2001      	movs	r0, #1
c0d0149c:	0780      	lsls	r0, r0, #30
c0d0149e:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d014a0:	2900      	cmp	r1, #0
c0d014a2:	4601      	mov	r1, r0
c0d014a4:	d000      	beq.n	c0d014a8 <io_seproxyhal_button_push+0x5c>
c0d014a6:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d014a8:	2900      	cmp	r1, #0
c0d014aa:	db02      	blt.n	c0d014b2 <io_seproxyhal_button_push+0x66>
c0d014ac:	4608      	mov	r0, r1
c0d014ae:	e000      	b.n	c0d014b2 <io_seproxyhal_button_push+0x66>
c0d014b0:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d014b2:	4629      	mov	r1, r5
c0d014b4:	47a0      	blx	r4
  }
}
c0d014b6:	b001      	add	sp, #4
c0d014b8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014ba:	46c0      	nop			; (mov r8, r8)
c0d014bc:	20001d24 	.word	0x20001d24
c0d014c0:	20001d28 	.word	0x20001d28

c0d014c4 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d014c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014c6:	af03      	add	r7, sp, #12
c0d014c8:	b081      	sub	sp, #4
c0d014ca:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d014cc:	200f      	movs	r0, #15
c0d014ce:	4204      	tst	r4, r0
c0d014d0:	d006      	beq.n	c0d014e0 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d014d2:	4620      	mov	r0, r4
c0d014d4:	f7ff f8be 	bl	c0d00654 <io_exchange_al>
c0d014d8:	4605      	mov	r5, r0
  }
}
c0d014da:	b2a8      	uxth	r0, r5
c0d014dc:	b001      	add	sp, #4
c0d014de:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d014e0:	2610      	movs	r6, #16
c0d014e2:	4026      	ands	r6, r4
c0d014e4:	2900      	cmp	r1, #0
c0d014e6:	d02a      	beq.n	c0d0153e <io_exchange+0x7a>
c0d014e8:	2e00      	cmp	r6, #0
c0d014ea:	d128      	bne.n	c0d0153e <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d014ec:	483d      	ldr	r0, [pc, #244]	; (c0d015e4 <io_exchange+0x120>)
c0d014ee:	7800      	ldrb	r0, [r0, #0]
c0d014f0:	2807      	cmp	r0, #7
c0d014f2:	d00b      	beq.n	c0d0150c <io_exchange+0x48>
c0d014f4:	2800      	cmp	r0, #0
c0d014f6:	d004      	beq.n	c0d01502 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d014f8:	4620      	mov	r0, r4
c0d014fa:	f7ff f8ab 	bl	c0d00654 <io_exchange_al>
c0d014fe:	2800      	cmp	r0, #0
c0d01500:	d00a      	beq.n	c0d01518 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01502:	4839      	ldr	r0, [pc, #228]	; (c0d015e8 <io_exchange+0x124>)
c0d01504:	6800      	ldr	r0, [r0, #0]
c0d01506:	2109      	movs	r1, #9
c0d01508:	f001 ff2c 	bl	c0d03364 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d0150c:	483d      	ldr	r0, [pc, #244]	; (c0d01604 <io_exchange+0x140>)
c0d0150e:	4478      	add	r0, pc
c0d01510:	2200      	movs	r2, #0
c0d01512:	2320      	movs	r3, #32
c0d01514:	f7ff fc6a 	bl	c0d00dec <io_usb_hid_exchange>
c0d01518:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0151a:	4832      	ldr	r0, [pc, #200]	; (c0d015e4 <io_exchange+0x120>)
c0d0151c:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d0151e:	4833      	ldr	r0, [pc, #204]	; (c0d015ec <io_exchange+0x128>)
c0d01520:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01522:	4833      	ldr	r0, [pc, #204]	; (c0d015f0 <io_exchange+0x12c>)
c0d01524:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01526:	4833      	ldr	r0, [pc, #204]	; (c0d015f4 <io_exchange+0x130>)
c0d01528:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0152a:	4833      	ldr	r0, [pc, #204]	; (c0d015f8 <io_exchange+0x134>)
c0d0152c:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0152e:	06a0      	lsls	r0, r4, #26
c0d01530:	d4d3      	bmi.n	c0d014da <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01532:	f7ff fcd3 	bl	c0d00edc <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01536:	0620      	lsls	r0, r4, #24
c0d01538:	d501      	bpl.n	c0d0153e <io_exchange+0x7a>
        reset();
c0d0153a:	f000 faeb 	bl	c0d01b14 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0153e:	2e00      	cmp	r6, #0
c0d01540:	d10c      	bne.n	c0d0155c <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01542:	0660      	lsls	r0, r4, #25
c0d01544:	d448      	bmi.n	c0d015d8 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01546:	4827      	ldr	r0, [pc, #156]	; (c0d015e4 <io_exchange+0x120>)
c0d01548:	2100      	movs	r1, #0
c0d0154a:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d0154c:	4827      	ldr	r0, [pc, #156]	; (c0d015ec <io_exchange+0x128>)
c0d0154e:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01550:	4827      	ldr	r0, [pc, #156]	; (c0d015f0 <io_exchange+0x12c>)
c0d01552:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01554:	4827      	ldr	r0, [pc, #156]	; (c0d015f4 <io_exchange+0x130>)
c0d01556:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01558:	4827      	ldr	r0, [pc, #156]	; (c0d015f8 <io_exchange+0x134>)
c0d0155a:	7001      	strb	r1, [r0, #0]
c0d0155c:	4c28      	ldr	r4, [pc, #160]	; (c0d01600 <io_exchange+0x13c>)
c0d0155e:	4e24      	ldr	r6, [pc, #144]	; (c0d015f0 <io_exchange+0x12c>)
c0d01560:	e008      	b.n	c0d01574 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01562:	f7ff fd0f 	bl	c0d00f84 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01566:	8830      	ldrh	r0, [r6, #0]
c0d01568:	2800      	cmp	r0, #0
c0d0156a:	d003      	beq.n	c0d01574 <io_exchange+0xb0>
c0d0156c:	e032      	b.n	c0d015d4 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d0156e:	2002      	movs	r0, #2
c0d01570:	f7ff f89e 	bl	c0d006b0 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01574:	f000 fc72 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d01578:	2800      	cmp	r0, #0
c0d0157a:	d101      	bne.n	c0d01580 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d0157c:	f7ff fcae 	bl	c0d00edc <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01580:	2180      	movs	r1, #128	; 0x80
c0d01582:	2500      	movs	r5, #0
c0d01584:	4620      	mov	r0, r4
c0d01586:	462a      	mov	r2, r5
c0d01588:	f000 fc84 	bl	c0d01e94 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d0158c:	1ec1      	subs	r1, r0, #3
c0d0158e:	78a2      	ldrb	r2, [r4, #2]
c0d01590:	7863      	ldrb	r3, [r4, #1]
c0d01592:	021b      	lsls	r3, r3, #8
c0d01594:	4313      	orrs	r3, r2
c0d01596:	4299      	cmp	r1, r3
c0d01598:	d110      	bne.n	c0d015bc <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d0159a:	4917      	ldr	r1, [pc, #92]	; (c0d015f8 <io_exchange+0x134>)
c0d0159c:	7809      	ldrb	r1, [r1, #0]
c0d0159e:	2900      	cmp	r1, #0
c0d015a0:	d002      	beq.n	c0d015a8 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d015a2:	f7ff fd73 	bl	c0d0108c <io_seproxyhal_handle_event>
c0d015a6:	e7e5      	b.n	c0d01574 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d015a8:	7821      	ldrb	r1, [r4, #0]
c0d015aa:	2910      	cmp	r1, #16
c0d015ac:	d00f      	beq.n	c0d015ce <io_exchange+0x10a>
c0d015ae:	290f      	cmp	r1, #15
c0d015b0:	d1dd      	bne.n	c0d0156e <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d015b2:	2804      	cmp	r0, #4
c0d015b4:	d102      	bne.n	c0d015bc <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d015b6:	f7ff fca7 	bl	c0d00f08 <io_seproxyhal_handle_usb_event>
c0d015ba:	e7db      	b.n	c0d01574 <io_exchange+0xb0>
c0d015bc:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d015be:	4909      	ldr	r1, [pc, #36]	; (c0d015e4 <io_exchange+0x120>)
c0d015c0:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d015c2:	490a      	ldr	r1, [pc, #40]	; (c0d015ec <io_exchange+0x128>)
c0d015c4:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d015c6:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d015c8:	490a      	ldr	r1, [pc, #40]	; (c0d015f4 <io_exchange+0x130>)
c0d015ca:	8008      	strh	r0, [r1, #0]
c0d015cc:	e7d2      	b.n	c0d01574 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d015ce:	2806      	cmp	r0, #6
c0d015d0:	d2c7      	bcs.n	c0d01562 <io_exchange+0x9e>
c0d015d2:	e782      	b.n	c0d014da <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d015d4:	8835      	ldrh	r5, [r6, #0]
c0d015d6:	e780      	b.n	c0d014da <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d015d8:	4805      	ldr	r0, [pc, #20]	; (c0d015f0 <io_exchange+0x12c>)
c0d015da:	8800      	ldrh	r0, [r0, #0]
c0d015dc:	4907      	ldr	r1, [pc, #28]	; (c0d015fc <io_exchange+0x138>)
c0d015de:	1845      	adds	r5, r0, r1
c0d015e0:	e77b      	b.n	c0d014da <io_exchange+0x16>
c0d015e2:	46c0      	nop			; (mov r8, r8)
c0d015e4:	20001d18 	.word	0x20001d18
c0d015e8:	20001bb8 	.word	0x20001bb8
c0d015ec:	20001d1a 	.word	0x20001d1a
c0d015f0:	20001d1c 	.word	0x20001d1c
c0d015f4:	20001d1e 	.word	0x20001d1e
c0d015f8:	20001d10 	.word	0x20001d10
c0d015fc:	0000fffb 	.word	0x0000fffb
c0d01600:	20001a18 	.word	0x20001a18
c0d01604:	fffffbbb 	.word	0xfffffbbb

c0d01608 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01608:	b081      	sub	sp, #4
c0d0160a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0160c:	af03      	add	r7, sp, #12
c0d0160e:	b094      	sub	sp, #80	; 0x50
c0d01610:	4616      	mov	r6, r2
c0d01612:	460d      	mov	r5, r1
c0d01614:	900e      	str	r0, [sp, #56]	; 0x38
c0d01616:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01618:	2d02      	cmp	r5, #2
c0d0161a:	d200      	bcs.n	c0d0161e <snprintf+0x16>
c0d0161c:	e22a      	b.n	c0d01a74 <snprintf+0x46c>
c0d0161e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01620:	2800      	cmp	r0, #0
c0d01622:	d100      	bne.n	c0d01626 <snprintf+0x1e>
c0d01624:	e226      	b.n	c0d01a74 <snprintf+0x46c>
c0d01626:	2e00      	cmp	r6, #0
c0d01628:	d100      	bne.n	c0d0162c <snprintf+0x24>
c0d0162a:	e223      	b.n	c0d01a74 <snprintf+0x46c>
c0d0162c:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d0162e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01630:	9109      	str	r1, [sp, #36]	; 0x24
c0d01632:	462a      	mov	r2, r5
c0d01634:	f7ff fbae 	bl	c0d00d94 <os_memset>
c0d01638:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d0163a:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0163c:	7830      	ldrb	r0, [r6, #0]
c0d0163e:	2800      	cmp	r0, #0
c0d01640:	d100      	bne.n	c0d01644 <snprintf+0x3c>
c0d01642:	e217      	b.n	c0d01a74 <snprintf+0x46c>
c0d01644:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01646:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01648:	1e6b      	subs	r3, r5, #1
c0d0164a:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d0164c:	460a      	mov	r2, r1
c0d0164e:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01650:	e003      	b.n	c0d0165a <snprintf+0x52>
c0d01652:	1970      	adds	r0, r6, r5
c0d01654:	7840      	ldrb	r0, [r0, #1]
c0d01656:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01658:	1c6d      	adds	r5, r5, #1
c0d0165a:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d0165c:	2800      	cmp	r0, #0
c0d0165e:	d001      	beq.n	c0d01664 <snprintf+0x5c>
c0d01660:	2825      	cmp	r0, #37	; 0x25
c0d01662:	d1f6      	bne.n	c0d01652 <snprintf+0x4a>
c0d01664:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01666:	429d      	cmp	r5, r3
c0d01668:	d300      	bcc.n	c0d0166c <snprintf+0x64>
c0d0166a:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d0166c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0166e:	4631      	mov	r1, r6
c0d01670:	462a      	mov	r2, r5
c0d01672:	461c      	mov	r4, r3
c0d01674:	f7ff fb98 	bl	c0d00da8 <os_memmove>
c0d01678:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d0167a:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d0167c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0167e:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01680:	2b00      	cmp	r3, #0
c0d01682:	d100      	bne.n	c0d01686 <snprintf+0x7e>
c0d01684:	e1f6      	b.n	c0d01a74 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01686:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01688:	5d71      	ldrb	r1, [r6, r5]
c0d0168a:	2925      	cmp	r1, #37	; 0x25
c0d0168c:	d000      	beq.n	c0d01690 <snprintf+0x88>
c0d0168e:	e0ab      	b.n	c0d017e8 <snprintf+0x1e0>
c0d01690:	9304      	str	r3, [sp, #16]
c0d01692:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01694:	1c40      	adds	r0, r0, #1
c0d01696:	2100      	movs	r1, #0
c0d01698:	2220      	movs	r2, #32
c0d0169a:	920a      	str	r2, [sp, #40]	; 0x28
c0d0169c:	220a      	movs	r2, #10
c0d0169e:	9203      	str	r2, [sp, #12]
c0d016a0:	9102      	str	r1, [sp, #8]
c0d016a2:	9106      	str	r1, [sp, #24]
c0d016a4:	910d      	str	r1, [sp, #52]	; 0x34
c0d016a6:	460b      	mov	r3, r1
c0d016a8:	2102      	movs	r1, #2
c0d016aa:	910c      	str	r1, [sp, #48]	; 0x30
c0d016ac:	4606      	mov	r6, r0
c0d016ae:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d016b0:	7831      	ldrb	r1, [r6, #0]
c0d016b2:	1c76      	adds	r6, r6, #1
c0d016b4:	2300      	movs	r3, #0
c0d016b6:	2962      	cmp	r1, #98	; 0x62
c0d016b8:	dc41      	bgt.n	c0d0173e <snprintf+0x136>
c0d016ba:	4608      	mov	r0, r1
c0d016bc:	3825      	subs	r0, #37	; 0x25
c0d016be:	2823      	cmp	r0, #35	; 0x23
c0d016c0:	d900      	bls.n	c0d016c4 <snprintf+0xbc>
c0d016c2:	e094      	b.n	c0d017ee <snprintf+0x1e6>
c0d016c4:	0040      	lsls	r0, r0, #1
c0d016c6:	46c0      	nop			; (mov r8, r8)
c0d016c8:	4478      	add	r0, pc
c0d016ca:	8880      	ldrh	r0, [r0, #4]
c0d016cc:	0040      	lsls	r0, r0, #1
c0d016ce:	4487      	add	pc, r0
c0d016d0:	0186012d 	.word	0x0186012d
c0d016d4:	01860186 	.word	0x01860186
c0d016d8:	00510186 	.word	0x00510186
c0d016dc:	01860186 	.word	0x01860186
c0d016e0:	00580023 	.word	0x00580023
c0d016e4:	00240186 	.word	0x00240186
c0d016e8:	00240024 	.word	0x00240024
c0d016ec:	00240024 	.word	0x00240024
c0d016f0:	00240024 	.word	0x00240024
c0d016f4:	00240024 	.word	0x00240024
c0d016f8:	01860024 	.word	0x01860024
c0d016fc:	01860186 	.word	0x01860186
c0d01700:	01860186 	.word	0x01860186
c0d01704:	01860186 	.word	0x01860186
c0d01708:	01860186 	.word	0x01860186
c0d0170c:	01860186 	.word	0x01860186
c0d01710:	01860186 	.word	0x01860186
c0d01714:	006c0186 	.word	0x006c0186
c0d01718:	e7c9      	b.n	c0d016ae <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d0171a:	2930      	cmp	r1, #48	; 0x30
c0d0171c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0171e:	4603      	mov	r3, r0
c0d01720:	d100      	bne.n	c0d01724 <snprintf+0x11c>
c0d01722:	460b      	mov	r3, r1
c0d01724:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01726:	2c00      	cmp	r4, #0
c0d01728:	d000      	beq.n	c0d0172c <snprintf+0x124>
c0d0172a:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d0172c:	200a      	movs	r0, #10
c0d0172e:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01730:	1840      	adds	r0, r0, r1
c0d01732:	3830      	subs	r0, #48	; 0x30
c0d01734:	900d      	str	r0, [sp, #52]	; 0x34
c0d01736:	4630      	mov	r0, r6
c0d01738:	930a      	str	r3, [sp, #40]	; 0x28
c0d0173a:	4613      	mov	r3, r2
c0d0173c:	e7b4      	b.n	c0d016a8 <snprintf+0xa0>
c0d0173e:	296f      	cmp	r1, #111	; 0x6f
c0d01740:	dd11      	ble.n	c0d01766 <snprintf+0x15e>
c0d01742:	3970      	subs	r1, #112	; 0x70
c0d01744:	2908      	cmp	r1, #8
c0d01746:	d900      	bls.n	c0d0174a <snprintf+0x142>
c0d01748:	e149      	b.n	c0d019de <snprintf+0x3d6>
c0d0174a:	0049      	lsls	r1, r1, #1
c0d0174c:	4479      	add	r1, pc
c0d0174e:	8889      	ldrh	r1, [r1, #4]
c0d01750:	0049      	lsls	r1, r1, #1
c0d01752:	448f      	add	pc, r1
c0d01754:	01440051 	.word	0x01440051
c0d01758:	002e0144 	.word	0x002e0144
c0d0175c:	00590144 	.word	0x00590144
c0d01760:	01440144 	.word	0x01440144
c0d01764:	0051      	.short	0x0051
c0d01766:	2963      	cmp	r1, #99	; 0x63
c0d01768:	d054      	beq.n	c0d01814 <snprintf+0x20c>
c0d0176a:	2964      	cmp	r1, #100	; 0x64
c0d0176c:	d057      	beq.n	c0d0181e <snprintf+0x216>
c0d0176e:	2968      	cmp	r1, #104	; 0x68
c0d01770:	d01d      	beq.n	c0d017ae <snprintf+0x1a6>
c0d01772:	e134      	b.n	c0d019de <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01774:	7830      	ldrb	r0, [r6, #0]
c0d01776:	2873      	cmp	r0, #115	; 0x73
c0d01778:	d000      	beq.n	c0d0177c <snprintf+0x174>
c0d0177a:	e130      	b.n	c0d019de <snprintf+0x3d6>
c0d0177c:	4630      	mov	r0, r6
c0d0177e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01780:	e00d      	b.n	c0d0179e <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01782:	7830      	ldrb	r0, [r6, #0]
c0d01784:	282a      	cmp	r0, #42	; 0x2a
c0d01786:	d000      	beq.n	c0d0178a <snprintf+0x182>
c0d01788:	e129      	b.n	c0d019de <snprintf+0x3d6>
c0d0178a:	7871      	ldrb	r1, [r6, #1]
c0d0178c:	1c70      	adds	r0, r6, #1
c0d0178e:	2301      	movs	r3, #1
c0d01790:	2948      	cmp	r1, #72	; 0x48
c0d01792:	d004      	beq.n	c0d0179e <snprintf+0x196>
c0d01794:	2968      	cmp	r1, #104	; 0x68
c0d01796:	d002      	beq.n	c0d0179e <snprintf+0x196>
c0d01798:	2973      	cmp	r1, #115	; 0x73
c0d0179a:	d000      	beq.n	c0d0179e <snprintf+0x196>
c0d0179c:	e11f      	b.n	c0d019de <snprintf+0x3d6>
c0d0179e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d017a0:	1d0a      	adds	r2, r1, #4
c0d017a2:	920f      	str	r2, [sp, #60]	; 0x3c
c0d017a4:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d017a6:	9102      	str	r1, [sp, #8]
c0d017a8:	e77e      	b.n	c0d016a8 <snprintf+0xa0>
c0d017aa:	2001      	movs	r0, #1
c0d017ac:	9006      	str	r0, [sp, #24]
c0d017ae:	2010      	movs	r0, #16
c0d017b0:	9003      	str	r0, [sp, #12]
c0d017b2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d017b4:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d017b6:	1d01      	adds	r1, r0, #4
c0d017b8:	910f      	str	r1, [sp, #60]	; 0x3c
c0d017ba:	2103      	movs	r1, #3
c0d017bc:	400a      	ands	r2, r1
c0d017be:	1c5b      	adds	r3, r3, #1
c0d017c0:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d017c2:	2a01      	cmp	r2, #1
c0d017c4:	d100      	bne.n	c0d017c8 <snprintf+0x1c0>
c0d017c6:	e0b8      	b.n	c0d0193a <snprintf+0x332>
c0d017c8:	2a02      	cmp	r2, #2
c0d017ca:	d100      	bne.n	c0d017ce <snprintf+0x1c6>
c0d017cc:	e104      	b.n	c0d019d8 <snprintf+0x3d0>
c0d017ce:	2a03      	cmp	r2, #3
c0d017d0:	4630      	mov	r0, r6
c0d017d2:	d100      	bne.n	c0d017d6 <snprintf+0x1ce>
c0d017d4:	e768      	b.n	c0d016a8 <snprintf+0xa0>
c0d017d6:	9c08      	ldr	r4, [sp, #32]
c0d017d8:	4625      	mov	r5, r4
c0d017da:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d017dc:	1948      	adds	r0, r1, r5
c0d017de:	7840      	ldrb	r0, [r0, #1]
c0d017e0:	1c6d      	adds	r5, r5, #1
c0d017e2:	2800      	cmp	r0, #0
c0d017e4:	d1fa      	bne.n	c0d017dc <snprintf+0x1d4>
c0d017e6:	e0ab      	b.n	c0d01940 <snprintf+0x338>
c0d017e8:	4606      	mov	r6, r0
c0d017ea:	920e      	str	r2, [sp, #56]	; 0x38
c0d017ec:	e109      	b.n	c0d01a02 <snprintf+0x3fa>
c0d017ee:	2958      	cmp	r1, #88	; 0x58
c0d017f0:	d000      	beq.n	c0d017f4 <snprintf+0x1ec>
c0d017f2:	e0f4      	b.n	c0d019de <snprintf+0x3d6>
c0d017f4:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d017f6:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d017f8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d017fa:	1d01      	adds	r1, r0, #4
c0d017fc:	910f      	str	r1, [sp, #60]	; 0x3c
c0d017fe:	6802      	ldr	r2, [r0, #0]
c0d01800:	2000      	movs	r0, #0
c0d01802:	9005      	str	r0, [sp, #20]
c0d01804:	2510      	movs	r5, #16
c0d01806:	e014      	b.n	c0d01832 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01808:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0180a:	1d01      	adds	r1, r0, #4
c0d0180c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0180e:	6802      	ldr	r2, [r0, #0]
c0d01810:	2000      	movs	r0, #0
c0d01812:	e00c      	b.n	c0d0182e <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01814:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01816:	1d01      	adds	r1, r0, #4
c0d01818:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0181a:	6800      	ldr	r0, [r0, #0]
c0d0181c:	e087      	b.n	c0d0192e <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0181e:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01820:	1d01      	adds	r1, r0, #4
c0d01822:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01824:	6800      	ldr	r0, [r0, #0]
c0d01826:	17c1      	asrs	r1, r0, #31
c0d01828:	1842      	adds	r2, r0, r1
c0d0182a:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d0182c:	0fc0      	lsrs	r0, r0, #31
c0d0182e:	9005      	str	r0, [sp, #20]
c0d01830:	250a      	movs	r5, #10
c0d01832:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01834:	4295      	cmp	r5, r2
c0d01836:	920e      	str	r2, [sp, #56]	; 0x38
c0d01838:	d814      	bhi.n	c0d01864 <snprintf+0x25c>
c0d0183a:	2201      	movs	r2, #1
c0d0183c:	4628      	mov	r0, r5
c0d0183e:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01840:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01842:	4629      	mov	r1, r5
c0d01844:	f001 fb4a 	bl	c0d02edc <__aeabi_uidiv>
c0d01848:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d0184a:	4288      	cmp	r0, r1
c0d0184c:	d109      	bne.n	c0d01862 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d0184e:	4628      	mov	r0, r5
c0d01850:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01852:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01854:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01856:	910d      	str	r1, [sp, #52]	; 0x34
c0d01858:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0185a:	4288      	cmp	r0, r1
c0d0185c:	4622      	mov	r2, r4
c0d0185e:	d9ee      	bls.n	c0d0183e <snprintf+0x236>
c0d01860:	e000      	b.n	c0d01864 <snprintf+0x25c>
c0d01862:	460c      	mov	r4, r1
c0d01864:	950c      	str	r5, [sp, #48]	; 0x30
c0d01866:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01868:	2000      	movs	r0, #0
c0d0186a:	4603      	mov	r3, r0
c0d0186c:	43c1      	mvns	r1, r0
c0d0186e:	9c05      	ldr	r4, [sp, #20]
c0d01870:	2c00      	cmp	r4, #0
c0d01872:	d100      	bne.n	c0d01876 <snprintf+0x26e>
c0d01874:	4621      	mov	r1, r4
c0d01876:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01878:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0187a:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d0187c:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0187e:	b2ca      	uxtb	r2, r1
c0d01880:	2a30      	cmp	r2, #48	; 0x30
c0d01882:	d106      	bne.n	c0d01892 <snprintf+0x28a>
c0d01884:	2c00      	cmp	r4, #0
c0d01886:	d004      	beq.n	c0d01892 <snprintf+0x28a>
c0d01888:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d0188a:	232d      	movs	r3, #45	; 0x2d
c0d0188c:	700b      	strb	r3, [r1, #0]
c0d0188e:	2400      	movs	r4, #0
c0d01890:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01892:	1e81      	subs	r1, r0, #2
c0d01894:	290d      	cmp	r1, #13
c0d01896:	d80d      	bhi.n	c0d018b4 <snprintf+0x2ac>
c0d01898:	1e41      	subs	r1, r0, #1
c0d0189a:	d00b      	beq.n	c0d018b4 <snprintf+0x2ac>
c0d0189c:	a810      	add	r0, sp, #64	; 0x40
c0d0189e:	9405      	str	r4, [sp, #20]
c0d018a0:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d018a2:	4320      	orrs	r0, r4
c0d018a4:	f001 fcc6 	bl	c0d03234 <__aeabi_memset>
c0d018a8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d018aa:	1900      	adds	r0, r0, r4
c0d018ac:	9c05      	ldr	r4, [sp, #20]
c0d018ae:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d018b0:	1840      	adds	r0, r0, r1
c0d018b2:	1e43      	subs	r3, r0, #1
c0d018b4:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d018b6:	2c00      	cmp	r4, #0
c0d018b8:	9601      	str	r6, [sp, #4]
c0d018ba:	d003      	beq.n	c0d018c4 <snprintf+0x2bc>
c0d018bc:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d018be:	222d      	movs	r2, #45	; 0x2d
c0d018c0:	54c2      	strb	r2, [r0, r3]
c0d018c2:	1c5b      	adds	r3, r3, #1
c0d018c4:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d018c6:	2900      	cmp	r1, #0
c0d018c8:	d003      	beq.n	c0d018d2 <snprintf+0x2ca>
c0d018ca:	2800      	cmp	r0, #0
c0d018cc:	d003      	beq.n	c0d018d6 <snprintf+0x2ce>
c0d018ce:	a06c      	add	r0, pc, #432	; (adr r0, c0d01a80 <g_pcHex_cap>)
c0d018d0:	e002      	b.n	c0d018d8 <snprintf+0x2d0>
c0d018d2:	461c      	mov	r4, r3
c0d018d4:	e016      	b.n	c0d01904 <snprintf+0x2fc>
c0d018d6:	a06e      	add	r0, pc, #440	; (adr r0, c0d01a90 <g_pcHex>)
c0d018d8:	900d      	str	r0, [sp, #52]	; 0x34
c0d018da:	461c      	mov	r4, r3
c0d018dc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d018de:	460e      	mov	r6, r1
c0d018e0:	f001 fafc 	bl	c0d02edc <__aeabi_uidiv>
c0d018e4:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d018e6:	4629      	mov	r1, r5
c0d018e8:	f001 fb7e 	bl	c0d02fe8 <__aeabi_uidivmod>
c0d018ec:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d018ee:	5c40      	ldrb	r0, [r0, r1]
c0d018f0:	a910      	add	r1, sp, #64	; 0x40
c0d018f2:	5508      	strb	r0, [r1, r4]
c0d018f4:	4630      	mov	r0, r6
c0d018f6:	4629      	mov	r1, r5
c0d018f8:	f001 faf0 	bl	c0d02edc <__aeabi_uidiv>
c0d018fc:	1c64      	adds	r4, r4, #1
c0d018fe:	42b5      	cmp	r5, r6
c0d01900:	4601      	mov	r1, r0
c0d01902:	d9eb      	bls.n	c0d018dc <snprintf+0x2d4>
c0d01904:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01906:	429c      	cmp	r4, r3
c0d01908:	4625      	mov	r5, r4
c0d0190a:	d300      	bcc.n	c0d0190e <snprintf+0x306>
c0d0190c:	461d      	mov	r5, r3
c0d0190e:	a910      	add	r1, sp, #64	; 0x40
c0d01910:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01912:	4620      	mov	r0, r4
c0d01914:	462a      	mov	r2, r5
c0d01916:	461e      	mov	r6, r3
c0d01918:	f7ff fa46 	bl	c0d00da8 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d0191c:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d0191e:	1961      	adds	r1, r4, r5
c0d01920:	910e      	str	r1, [sp, #56]	; 0x38
c0d01922:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01924:	2800      	cmp	r0, #0
c0d01926:	9e01      	ldr	r6, [sp, #4]
c0d01928:	d16b      	bne.n	c0d01a02 <snprintf+0x3fa>
c0d0192a:	e0a3      	b.n	c0d01a74 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d0192c:	2025      	movs	r0, #37	; 0x25
c0d0192e:	9907      	ldr	r1, [sp, #28]
c0d01930:	7008      	strb	r0, [r1, #0]
c0d01932:	9804      	ldr	r0, [sp, #16]
c0d01934:	1e40      	subs	r0, r0, #1
c0d01936:	1c49      	adds	r1, r1, #1
c0d01938:	e05f      	b.n	c0d019fa <snprintf+0x3f2>
c0d0193a:	9d02      	ldr	r5, [sp, #8]
c0d0193c:	9c08      	ldr	r4, [sp, #32]
c0d0193e:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01940:	9803      	ldr	r0, [sp, #12]
c0d01942:	2810      	cmp	r0, #16
c0d01944:	9807      	ldr	r0, [sp, #28]
c0d01946:	d161      	bne.n	c0d01a0c <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01948:	2d00      	cmp	r5, #0
c0d0194a:	d06a      	beq.n	c0d01a22 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d0194c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0194e:	1900      	adds	r0, r0, r4
c0d01950:	900e      	str	r0, [sp, #56]	; 0x38
c0d01952:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01954:	1aa0      	subs	r0, r4, r2
c0d01956:	9b05      	ldr	r3, [sp, #20]
c0d01958:	4283      	cmp	r3, r0
c0d0195a:	d800      	bhi.n	c0d0195e <snprintf+0x356>
c0d0195c:	4603      	mov	r3, r0
c0d0195e:	930c      	str	r3, [sp, #48]	; 0x30
c0d01960:	435c      	muls	r4, r3
c0d01962:	940a      	str	r4, [sp, #40]	; 0x28
c0d01964:	1c60      	adds	r0, r4, #1
c0d01966:	9007      	str	r0, [sp, #28]
c0d01968:	2000      	movs	r0, #0
c0d0196a:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d0196c:	9100      	str	r1, [sp, #0]
c0d0196e:	940e      	str	r4, [sp, #56]	; 0x38
c0d01970:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01972:	18e3      	adds	r3, r4, r3
c0d01974:	900d      	str	r0, [sp, #52]	; 0x34
c0d01976:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01978:	200f      	movs	r0, #15
c0d0197a:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d0197c:	0909      	lsrs	r1, r1, #4
c0d0197e:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01980:	18a4      	adds	r4, r4, r2
c0d01982:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01984:	2c02      	cmp	r4, #2
c0d01986:	d375      	bcc.n	c0d01a74 <snprintf+0x46c>
c0d01988:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d0198a:	2c01      	cmp	r4, #1
c0d0198c:	d003      	beq.n	c0d01996 <snprintf+0x38e>
c0d0198e:	2c00      	cmp	r4, #0
c0d01990:	d108      	bne.n	c0d019a4 <snprintf+0x39c>
c0d01992:	a43f      	add	r4, pc, #252	; (adr r4, c0d01a90 <g_pcHex>)
c0d01994:	e000      	b.n	c0d01998 <snprintf+0x390>
c0d01996:	a43a      	add	r4, pc, #232	; (adr r4, c0d01a80 <g_pcHex_cap>)
c0d01998:	b2c9      	uxtb	r1, r1
c0d0199a:	5c61      	ldrb	r1, [r4, r1]
c0d0199c:	7019      	strb	r1, [r3, #0]
c0d0199e:	b2c0      	uxtb	r0, r0
c0d019a0:	5c20      	ldrb	r0, [r4, r0]
c0d019a2:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d019a4:	9807      	ldr	r0, [sp, #28]
c0d019a6:	4290      	cmp	r0, r2
c0d019a8:	d064      	beq.n	c0d01a74 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d019aa:	1e92      	subs	r2, r2, #2
c0d019ac:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d019ae:	1ca4      	adds	r4, r4, #2
c0d019b0:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d019b2:	1c40      	adds	r0, r0, #1
c0d019b4:	42a8      	cmp	r0, r5
c0d019b6:	9900      	ldr	r1, [sp, #0]
c0d019b8:	d3d9      	bcc.n	c0d0196e <snprintf+0x366>
c0d019ba:	900d      	str	r0, [sp, #52]	; 0x34
c0d019bc:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d019be:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d019c0:	1a08      	subs	r0, r1, r0
c0d019c2:	9b05      	ldr	r3, [sp, #20]
c0d019c4:	4283      	cmp	r3, r0
c0d019c6:	d800      	bhi.n	c0d019ca <snprintf+0x3c2>
c0d019c8:	4603      	mov	r3, r0
c0d019ca:	4608      	mov	r0, r1
c0d019cc:	4358      	muls	r0, r3
c0d019ce:	1820      	adds	r0, r4, r0
c0d019d0:	900e      	str	r0, [sp, #56]	; 0x38
c0d019d2:	1898      	adds	r0, r3, r2
c0d019d4:	1c43      	adds	r3, r0, #1
c0d019d6:	e038      	b.n	c0d01a4a <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d019d8:	7808      	ldrb	r0, [r1, #0]
c0d019da:	2800      	cmp	r0, #0
c0d019dc:	d023      	beq.n	c0d01a26 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d019de:	2005      	movs	r0, #5
c0d019e0:	9d04      	ldr	r5, [sp, #16]
c0d019e2:	2d05      	cmp	r5, #5
c0d019e4:	462c      	mov	r4, r5
c0d019e6:	d300      	bcc.n	c0d019ea <snprintf+0x3e2>
c0d019e8:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d019ea:	9807      	ldr	r0, [sp, #28]
c0d019ec:	a12c      	add	r1, pc, #176	; (adr r1, c0d01aa0 <g_pcHex+0x10>)
c0d019ee:	4622      	mov	r2, r4
c0d019f0:	f7ff f9da 	bl	c0d00da8 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d019f4:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d019f6:	9907      	ldr	r1, [sp, #28]
c0d019f8:	1909      	adds	r1, r1, r4
c0d019fa:	910e      	str	r1, [sp, #56]	; 0x38
c0d019fc:	4603      	mov	r3, r0
c0d019fe:	2800      	cmp	r0, #0
c0d01a00:	d038      	beq.n	c0d01a74 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01a02:	7830      	ldrb	r0, [r6, #0]
c0d01a04:	2800      	cmp	r0, #0
c0d01a06:	9908      	ldr	r1, [sp, #32]
c0d01a08:	d034      	beq.n	c0d01a74 <snprintf+0x46c>
c0d01a0a:	e61f      	b.n	c0d0164c <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01a0c:	429d      	cmp	r5, r3
c0d01a0e:	d300      	bcc.n	c0d01a12 <snprintf+0x40a>
c0d01a10:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01a12:	462a      	mov	r2, r5
c0d01a14:	461c      	mov	r4, r3
c0d01a16:	f7ff f9c7 	bl	c0d00da8 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01a1a:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01a1c:	9907      	ldr	r1, [sp, #28]
c0d01a1e:	1949      	adds	r1, r1, r5
c0d01a20:	e00f      	b.n	c0d01a42 <snprintf+0x43a>
c0d01a22:	900e      	str	r0, [sp, #56]	; 0x38
c0d01a24:	e7ed      	b.n	c0d01a02 <snprintf+0x3fa>
c0d01a26:	9b04      	ldr	r3, [sp, #16]
c0d01a28:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01a2a:	429c      	cmp	r4, r3
c0d01a2c:	d300      	bcc.n	c0d01a30 <snprintf+0x428>
c0d01a2e:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01a30:	2120      	movs	r1, #32
c0d01a32:	9807      	ldr	r0, [sp, #28]
c0d01a34:	4622      	mov	r2, r4
c0d01a36:	f7ff f9ad 	bl	c0d00d94 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01a3a:	9804      	ldr	r0, [sp, #16]
c0d01a3c:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01a3e:	9907      	ldr	r1, [sp, #28]
c0d01a40:	1909      	adds	r1, r1, r4
c0d01a42:	910e      	str	r1, [sp, #56]	; 0x38
c0d01a44:	4603      	mov	r3, r0
c0d01a46:	2800      	cmp	r0, #0
c0d01a48:	d014      	beq.n	c0d01a74 <snprintf+0x46c>
c0d01a4a:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01a4c:	42a8      	cmp	r0, r5
c0d01a4e:	d9d8      	bls.n	c0d01a02 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01a50:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01a52:	429a      	cmp	r2, r3
c0d01a54:	d300      	bcc.n	c0d01a58 <snprintf+0x450>
c0d01a56:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01a58:	2120      	movs	r1, #32
c0d01a5a:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01a5c:	4628      	mov	r0, r5
c0d01a5e:	920d      	str	r2, [sp, #52]	; 0x34
c0d01a60:	461c      	mov	r4, r3
c0d01a62:	f7ff f997 	bl	c0d00d94 <os_memset>
c0d01a66:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01a68:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01a6a:	182d      	adds	r5, r5, r0
c0d01a6c:	950e      	str	r5, [sp, #56]	; 0x38
c0d01a6e:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01a70:	2c00      	cmp	r4, #0
c0d01a72:	d1c6      	bne.n	c0d01a02 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01a74:	2000      	movs	r0, #0
c0d01a76:	b014      	add	sp, #80	; 0x50
c0d01a78:	bcf0      	pop	{r4, r5, r6, r7}
c0d01a7a:	bc02      	pop	{r1}
c0d01a7c:	b001      	add	sp, #4
c0d01a7e:	4708      	bx	r1

c0d01a80 <g_pcHex_cap>:
c0d01a80:	33323130 	.word	0x33323130
c0d01a84:	37363534 	.word	0x37363534
c0d01a88:	42413938 	.word	0x42413938
c0d01a8c:	46454443 	.word	0x46454443

c0d01a90 <g_pcHex>:
c0d01a90:	33323130 	.word	0x33323130
c0d01a94:	37363534 	.word	0x37363534
c0d01a98:	62613938 	.word	0x62613938
c0d01a9c:	66656463 	.word	0x66656463
c0d01aa0:	4f525245 	.word	0x4f525245
c0d01aa4:	00000052 	.word	0x00000052

c0d01aa8 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01aa8:	b580      	push	{r7, lr}
c0d01aaa:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01aac:	4904      	ldr	r1, [pc, #16]	; (c0d01ac0 <pic+0x18>)
c0d01aae:	4288      	cmp	r0, r1
c0d01ab0:	d304      	bcc.n	c0d01abc <pic+0x14>
c0d01ab2:	4904      	ldr	r1, [pc, #16]	; (c0d01ac4 <pic+0x1c>)
c0d01ab4:	4288      	cmp	r0, r1
c0d01ab6:	d201      	bcs.n	c0d01abc <pic+0x14>
		link_address = pic_internal(link_address);
c0d01ab8:	f000 f806 	bl	c0d01ac8 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01abc:	bd80      	pop	{r7, pc}
c0d01abe:	46c0      	nop			; (mov r8, r8)
c0d01ac0:	c0d00000 	.word	0xc0d00000
c0d01ac4:	c0d038c0 	.word	0xc0d038c0

c0d01ac8 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01ac8:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01aca:	4902      	ldr	r1, [pc, #8]	; (c0d01ad4 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01acc:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01ace:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01ad0:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01ad2:	4770      	bx	lr
c0d01ad4:	c0d01ac9 	.word	0xc0d01ac9

c0d01ad8 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01ad8:	b580      	push	{r7, lr}
c0d01ada:	af00      	add	r7, sp, #0
c0d01adc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01ade:	490a      	ldr	r1, [pc, #40]	; (c0d01b08 <check_api_level+0x30>)
c0d01ae0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ae2:	490a      	ldr	r1, [pc, #40]	; (c0d01b0c <check_api_level+0x34>)
c0d01ae4:	680a      	ldr	r2, [r1, #0]
c0d01ae6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01ae8:	9003      	str	r0, [sp, #12]
c0d01aea:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01aec:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01aee:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01af0:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01af2:	4807      	ldr	r0, [pc, #28]	; (c0d01b10 <check_api_level+0x38>)
c0d01af4:	9a01      	ldr	r2, [sp, #4]
c0d01af6:	4282      	cmp	r2, r0
c0d01af8:	d101      	bne.n	c0d01afe <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01afa:	b004      	add	sp, #16
c0d01afc:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01afe:	6808      	ldr	r0, [r1, #0]
c0d01b00:	2104      	movs	r1, #4
c0d01b02:	f001 fc2f 	bl	c0d03364 <longjmp>
c0d01b06:	46c0      	nop			; (mov r8, r8)
c0d01b08:	60000137 	.word	0x60000137
c0d01b0c:	20001bb8 	.word	0x20001bb8
c0d01b10:	900001c6 	.word	0x900001c6

c0d01b14 <reset>:
  }
}

void reset ( void ) 
{
c0d01b14:	b580      	push	{r7, lr}
c0d01b16:	af00      	add	r7, sp, #0
c0d01b18:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01b1a:	4809      	ldr	r0, [pc, #36]	; (c0d01b40 <reset+0x2c>)
c0d01b1c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b1e:	4809      	ldr	r0, [pc, #36]	; (c0d01b44 <reset+0x30>)
c0d01b20:	6801      	ldr	r1, [r0, #0]
c0d01b22:	9101      	str	r1, [sp, #4]
c0d01b24:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b26:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01b28:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b2a:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01b2c:	4906      	ldr	r1, [pc, #24]	; (c0d01b48 <reset+0x34>)
c0d01b2e:	9a00      	ldr	r2, [sp, #0]
c0d01b30:	428a      	cmp	r2, r1
c0d01b32:	d101      	bne.n	c0d01b38 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01b34:	b002      	add	sp, #8
c0d01b36:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b38:	6800      	ldr	r0, [r0, #0]
c0d01b3a:	2104      	movs	r1, #4
c0d01b3c:	f001 fc12 	bl	c0d03364 <longjmp>
c0d01b40:	60000200 	.word	0x60000200
c0d01b44:	20001bb8 	.word	0x20001bb8
c0d01b48:	900002f1 	.word	0x900002f1

c0d01b4c <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01b4c:	b5d0      	push	{r4, r6, r7, lr}
c0d01b4e:	af02      	add	r7, sp, #8
c0d01b50:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01b52:	4b0a      	ldr	r3, [pc, #40]	; (c0d01b7c <nvm_write+0x30>)
c0d01b54:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b56:	4b0a      	ldr	r3, [pc, #40]	; (c0d01b80 <nvm_write+0x34>)
c0d01b58:	681c      	ldr	r4, [r3, #0]
c0d01b5a:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01b5c:	ac03      	add	r4, sp, #12
c0d01b5e:	c407      	stmia	r4!, {r0, r1, r2}
c0d01b60:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b62:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b64:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b66:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01b68:	4806      	ldr	r0, [pc, #24]	; (c0d01b84 <nvm_write+0x38>)
c0d01b6a:	9901      	ldr	r1, [sp, #4]
c0d01b6c:	4281      	cmp	r1, r0
c0d01b6e:	d101      	bne.n	c0d01b74 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01b70:	b006      	add	sp, #24
c0d01b72:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b74:	6818      	ldr	r0, [r3, #0]
c0d01b76:	2104      	movs	r1, #4
c0d01b78:	f001 fbf4 	bl	c0d03364 <longjmp>
c0d01b7c:	6000037f 	.word	0x6000037f
c0d01b80:	20001bb8 	.word	0x20001bb8
c0d01b84:	900003bc 	.word	0x900003bc

c0d01b88 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01b88:	b580      	push	{r7, lr}
c0d01b8a:	af00      	add	r7, sp, #0
c0d01b8c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01b8e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01bb8 <cx_rng+0x30>)
c0d01b90:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b92:	4a0a      	ldr	r2, [pc, #40]	; (c0d01bbc <cx_rng+0x34>)
c0d01b94:	6813      	ldr	r3, [r2, #0]
c0d01b96:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01b98:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01b9a:	9103      	str	r1, [sp, #12]
c0d01b9c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b9e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ba0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ba2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01ba4:	4906      	ldr	r1, [pc, #24]	; (c0d01bc0 <cx_rng+0x38>)
c0d01ba6:	9b00      	ldr	r3, [sp, #0]
c0d01ba8:	428b      	cmp	r3, r1
c0d01baa:	d101      	bne.n	c0d01bb0 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01bac:	b004      	add	sp, #16
c0d01bae:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bb0:	6810      	ldr	r0, [r2, #0]
c0d01bb2:	2104      	movs	r1, #4
c0d01bb4:	f001 fbd6 	bl	c0d03364 <longjmp>
c0d01bb8:	6000052c 	.word	0x6000052c
c0d01bbc:	20001bb8 	.word	0x20001bb8
c0d01bc0:	90000567 	.word	0x90000567

c0d01bc4 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01bc4:	b580      	push	{r7, lr}
c0d01bc6:	af00      	add	r7, sp, #0
c0d01bc8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01bca:	490a      	ldr	r1, [pc, #40]	; (c0d01bf4 <cx_sha256_init+0x30>)
c0d01bcc:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bce:	490a      	ldr	r1, [pc, #40]	; (c0d01bf8 <cx_sha256_init+0x34>)
c0d01bd0:	680a      	ldr	r2, [r1, #0]
c0d01bd2:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01bd4:	9003      	str	r0, [sp, #12]
c0d01bd6:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bd8:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bda:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bdc:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01bde:	4a07      	ldr	r2, [pc, #28]	; (c0d01bfc <cx_sha256_init+0x38>)
c0d01be0:	9b01      	ldr	r3, [sp, #4]
c0d01be2:	4293      	cmp	r3, r2
c0d01be4:	d101      	bne.n	c0d01bea <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01be6:	b004      	add	sp, #16
c0d01be8:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bea:	6808      	ldr	r0, [r1, #0]
c0d01bec:	2104      	movs	r1, #4
c0d01bee:	f001 fbb9 	bl	c0d03364 <longjmp>
c0d01bf2:	46c0      	nop			; (mov r8, r8)
c0d01bf4:	600008db 	.word	0x600008db
c0d01bf8:	20001bb8 	.word	0x20001bb8
c0d01bfc:	90000864 	.word	0x90000864

c0d01c00 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01c00:	b580      	push	{r7, lr}
c0d01c02:	af00      	add	r7, sp, #0
c0d01c04:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01c06:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c30 <cx_keccak_init+0x30>)
c0d01c08:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c0a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c34 <cx_keccak_init+0x34>)
c0d01c0c:	6813      	ldr	r3, [r2, #0]
c0d01c0e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01c10:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01c12:	9103      	str	r1, [sp, #12]
c0d01c14:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c16:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c18:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c1a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01c1c:	4906      	ldr	r1, [pc, #24]	; (c0d01c38 <cx_keccak_init+0x38>)
c0d01c1e:	9b00      	ldr	r3, [sp, #0]
c0d01c20:	428b      	cmp	r3, r1
c0d01c22:	d101      	bne.n	c0d01c28 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c24:	b004      	add	sp, #16
c0d01c26:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c28:	6810      	ldr	r0, [r2, #0]
c0d01c2a:	2104      	movs	r1, #4
c0d01c2c:	f001 fb9a 	bl	c0d03364 <longjmp>
c0d01c30:	60000c3c 	.word	0x60000c3c
c0d01c34:	20001bb8 	.word	0x20001bb8
c0d01c38:	90000c39 	.word	0x90000c39

c0d01c3c <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01c3c:	b5b0      	push	{r4, r5, r7, lr}
c0d01c3e:	af02      	add	r7, sp, #8
c0d01c40:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01c42:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c70 <cx_hash+0x34>)
c0d01c44:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c46:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c74 <cx_hash+0x38>)
c0d01c48:	6825      	ldr	r5, [r4, #0]
c0d01c4a:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01c4c:	ad03      	add	r5, sp, #12
c0d01c4e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c50:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01c52:	9007      	str	r0, [sp, #28]
c0d01c54:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c56:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c58:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c5a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01c5c:	4906      	ldr	r1, [pc, #24]	; (c0d01c78 <cx_hash+0x3c>)
c0d01c5e:	9a01      	ldr	r2, [sp, #4]
c0d01c60:	428a      	cmp	r2, r1
c0d01c62:	d101      	bne.n	c0d01c68 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c64:	b008      	add	sp, #32
c0d01c66:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c68:	6820      	ldr	r0, [r4, #0]
c0d01c6a:	2104      	movs	r1, #4
c0d01c6c:	f001 fb7a 	bl	c0d03364 <longjmp>
c0d01c70:	60000ea6 	.word	0x60000ea6
c0d01c74:	20001bb8 	.word	0x20001bb8
c0d01c78:	90000e46 	.word	0x90000e46

c0d01c7c <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01c7c:	b5b0      	push	{r4, r5, r7, lr}
c0d01c7e:	af02      	add	r7, sp, #8
c0d01c80:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01c82:	4c0a      	ldr	r4, [pc, #40]	; (c0d01cac <cx_ecfp_init_public_key+0x30>)
c0d01c84:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c86:	4c0a      	ldr	r4, [pc, #40]	; (c0d01cb0 <cx_ecfp_init_public_key+0x34>)
c0d01c88:	6825      	ldr	r5, [r4, #0]
c0d01c8a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c8c:	ad02      	add	r5, sp, #8
c0d01c8e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c90:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c92:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c94:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c96:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01c98:	4906      	ldr	r1, [pc, #24]	; (c0d01cb4 <cx_ecfp_init_public_key+0x38>)
c0d01c9a:	9a00      	ldr	r2, [sp, #0]
c0d01c9c:	428a      	cmp	r2, r1
c0d01c9e:	d101      	bne.n	c0d01ca4 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ca0:	b006      	add	sp, #24
c0d01ca2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ca4:	6820      	ldr	r0, [r4, #0]
c0d01ca6:	2104      	movs	r1, #4
c0d01ca8:	f001 fb5c 	bl	c0d03364 <longjmp>
c0d01cac:	60002835 	.word	0x60002835
c0d01cb0:	20001bb8 	.word	0x20001bb8
c0d01cb4:	900028f0 	.word	0x900028f0

c0d01cb8 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01cb8:	b5b0      	push	{r4, r5, r7, lr}
c0d01cba:	af02      	add	r7, sp, #8
c0d01cbc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01cbe:	4c0a      	ldr	r4, [pc, #40]	; (c0d01ce8 <cx_ecfp_init_private_key+0x30>)
c0d01cc0:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cc2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01cec <cx_ecfp_init_private_key+0x34>)
c0d01cc4:	6825      	ldr	r5, [r4, #0]
c0d01cc6:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01cc8:	ad02      	add	r5, sp, #8
c0d01cca:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01ccc:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cce:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cd0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cd2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01cd4:	4906      	ldr	r1, [pc, #24]	; (c0d01cf0 <cx_ecfp_init_private_key+0x38>)
c0d01cd6:	9a00      	ldr	r2, [sp, #0]
c0d01cd8:	428a      	cmp	r2, r1
c0d01cda:	d101      	bne.n	c0d01ce0 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01cdc:	b006      	add	sp, #24
c0d01cde:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ce0:	6820      	ldr	r0, [r4, #0]
c0d01ce2:	2104      	movs	r1, #4
c0d01ce4:	f001 fb3e 	bl	c0d03364 <longjmp>
c0d01ce8:	600029ed 	.word	0x600029ed
c0d01cec:	20001bb8 	.word	0x20001bb8
c0d01cf0:	900029ae 	.word	0x900029ae

c0d01cf4 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01cf4:	b5b0      	push	{r4, r5, r7, lr}
c0d01cf6:	af02      	add	r7, sp, #8
c0d01cf8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01cfa:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d24 <cx_ecfp_generate_pair+0x30>)
c0d01cfc:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cfe:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d28 <cx_ecfp_generate_pair+0x34>)
c0d01d00:	6825      	ldr	r5, [r4, #0]
c0d01d02:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01d04:	ad02      	add	r5, sp, #8
c0d01d06:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01d08:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d0a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d0c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d0e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01d10:	4906      	ldr	r1, [pc, #24]	; (c0d01d2c <cx_ecfp_generate_pair+0x38>)
c0d01d12:	9a00      	ldr	r2, [sp, #0]
c0d01d14:	428a      	cmp	r2, r1
c0d01d16:	d101      	bne.n	c0d01d1c <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d18:	b006      	add	sp, #24
c0d01d1a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d1c:	6820      	ldr	r0, [r4, #0]
c0d01d1e:	2104      	movs	r1, #4
c0d01d20:	f001 fb20 	bl	c0d03364 <longjmp>
c0d01d24:	60002a2e 	.word	0x60002a2e
c0d01d28:	20001bb8 	.word	0x20001bb8
c0d01d2c:	90002a74 	.word	0x90002a74

c0d01d30 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01d30:	b5b0      	push	{r4, r5, r7, lr}
c0d01d32:	af02      	add	r7, sp, #8
c0d01d34:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01d36:	4c0b      	ldr	r4, [pc, #44]	; (c0d01d64 <os_perso_derive_node_bip32+0x34>)
c0d01d38:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d3a:	4c0b      	ldr	r4, [pc, #44]	; (c0d01d68 <os_perso_derive_node_bip32+0x38>)
c0d01d3c:	6825      	ldr	r5, [r4, #0]
c0d01d3e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01d40:	ad03      	add	r5, sp, #12
c0d01d42:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01d44:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01d46:	9007      	str	r0, [sp, #28]
c0d01d48:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d4a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d4c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d4e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01d50:	4806      	ldr	r0, [pc, #24]	; (c0d01d6c <os_perso_derive_node_bip32+0x3c>)
c0d01d52:	9901      	ldr	r1, [sp, #4]
c0d01d54:	4281      	cmp	r1, r0
c0d01d56:	d101      	bne.n	c0d01d5c <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01d58:	b008      	add	sp, #32
c0d01d5a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d5c:	6820      	ldr	r0, [r4, #0]
c0d01d5e:	2104      	movs	r1, #4
c0d01d60:	f001 fb00 	bl	c0d03364 <longjmp>
c0d01d64:	6000512b 	.word	0x6000512b
c0d01d68:	20001bb8 	.word	0x20001bb8
c0d01d6c:	9000517f 	.word	0x9000517f

c0d01d70 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01d70:	b580      	push	{r7, lr}
c0d01d72:	af00      	add	r7, sp, #0
c0d01d74:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01d76:	490a      	ldr	r1, [pc, #40]	; (c0d01da0 <os_sched_exit+0x30>)
c0d01d78:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d7a:	490a      	ldr	r1, [pc, #40]	; (c0d01da4 <os_sched_exit+0x34>)
c0d01d7c:	680a      	ldr	r2, [r1, #0]
c0d01d7e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01d80:	9003      	str	r0, [sp, #12]
c0d01d82:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d84:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d86:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d88:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01d8a:	4807      	ldr	r0, [pc, #28]	; (c0d01da8 <os_sched_exit+0x38>)
c0d01d8c:	9a01      	ldr	r2, [sp, #4]
c0d01d8e:	4282      	cmp	r2, r0
c0d01d90:	d101      	bne.n	c0d01d96 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01d92:	b004      	add	sp, #16
c0d01d94:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d96:	6808      	ldr	r0, [r1, #0]
c0d01d98:	2104      	movs	r1, #4
c0d01d9a:	f001 fae3 	bl	c0d03364 <longjmp>
c0d01d9e:	46c0      	nop			; (mov r8, r8)
c0d01da0:	60005fe1 	.word	0x60005fe1
c0d01da4:	20001bb8 	.word	0x20001bb8
c0d01da8:	90005f6f 	.word	0x90005f6f

c0d01dac <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01dac:	b580      	push	{r7, lr}
c0d01dae:	af00      	add	r7, sp, #0
c0d01db0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01db2:	490a      	ldr	r1, [pc, #40]	; (c0d01ddc <os_ux+0x30>)
c0d01db4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01db6:	490a      	ldr	r1, [pc, #40]	; (c0d01de0 <os_ux+0x34>)
c0d01db8:	680a      	ldr	r2, [r1, #0]
c0d01dba:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01dbc:	9003      	str	r0, [sp, #12]
c0d01dbe:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dc0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01dc2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01dc4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01dc6:	4a07      	ldr	r2, [pc, #28]	; (c0d01de4 <os_ux+0x38>)
c0d01dc8:	9b01      	ldr	r3, [sp, #4]
c0d01dca:	4293      	cmp	r3, r2
c0d01dcc:	d101      	bne.n	c0d01dd2 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01dce:	b004      	add	sp, #16
c0d01dd0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01dd2:	6808      	ldr	r0, [r1, #0]
c0d01dd4:	2104      	movs	r1, #4
c0d01dd6:	f001 fac5 	bl	c0d03364 <longjmp>
c0d01dda:	46c0      	nop			; (mov r8, r8)
c0d01ddc:	60006158 	.word	0x60006158
c0d01de0:	20001bb8 	.word	0x20001bb8
c0d01de4:	9000611f 	.word	0x9000611f

c0d01de8 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01de8:	b580      	push	{r7, lr}
c0d01dea:	af00      	add	r7, sp, #0
c0d01dec:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01dee:	4809      	ldr	r0, [pc, #36]	; (c0d01e14 <os_seph_features+0x2c>)
c0d01df0:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01df2:	4909      	ldr	r1, [pc, #36]	; (c0d01e18 <os_seph_features+0x30>)
c0d01df4:	6808      	ldr	r0, [r1, #0]
c0d01df6:	9001      	str	r0, [sp, #4]
c0d01df8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dfa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01dfc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01dfe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01e00:	4a06      	ldr	r2, [pc, #24]	; (c0d01e1c <os_seph_features+0x34>)
c0d01e02:	9b00      	ldr	r3, [sp, #0]
c0d01e04:	4293      	cmp	r3, r2
c0d01e06:	d101      	bne.n	c0d01e0c <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01e08:	b002      	add	sp, #8
c0d01e0a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e0c:	6808      	ldr	r0, [r1, #0]
c0d01e0e:	2104      	movs	r1, #4
c0d01e10:	f001 faa8 	bl	c0d03364 <longjmp>
c0d01e14:	600064d6 	.word	0x600064d6
c0d01e18:	20001bb8 	.word	0x20001bb8
c0d01e1c:	90006444 	.word	0x90006444

c0d01e20 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01e20:	b580      	push	{r7, lr}
c0d01e22:	af00      	add	r7, sp, #0
c0d01e24:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01e26:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e50 <io_seproxyhal_spi_send+0x30>)
c0d01e28:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e2a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e54 <io_seproxyhal_spi_send+0x34>)
c0d01e2c:	6813      	ldr	r3, [r2, #0]
c0d01e2e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01e30:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01e32:	9103      	str	r1, [sp, #12]
c0d01e34:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e36:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e38:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e3a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01e3c:	4806      	ldr	r0, [pc, #24]	; (c0d01e58 <io_seproxyhal_spi_send+0x38>)
c0d01e3e:	9900      	ldr	r1, [sp, #0]
c0d01e40:	4281      	cmp	r1, r0
c0d01e42:	d101      	bne.n	c0d01e48 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e44:	b004      	add	sp, #16
c0d01e46:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e48:	6810      	ldr	r0, [r2, #0]
c0d01e4a:	2104      	movs	r1, #4
c0d01e4c:	f001 fa8a 	bl	c0d03364 <longjmp>
c0d01e50:	60006a1c 	.word	0x60006a1c
c0d01e54:	20001bb8 	.word	0x20001bb8
c0d01e58:	90006af3 	.word	0x90006af3

c0d01e5c <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01e5c:	b580      	push	{r7, lr}
c0d01e5e:	af00      	add	r7, sp, #0
c0d01e60:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01e62:	4809      	ldr	r0, [pc, #36]	; (c0d01e88 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01e64:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e66:	4909      	ldr	r1, [pc, #36]	; (c0d01e8c <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01e68:	6808      	ldr	r0, [r1, #0]
c0d01e6a:	9001      	str	r0, [sp, #4]
c0d01e6c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e6e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e70:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e72:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01e74:	4a06      	ldr	r2, [pc, #24]	; (c0d01e90 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01e76:	9b00      	ldr	r3, [sp, #0]
c0d01e78:	4293      	cmp	r3, r2
c0d01e7a:	d101      	bne.n	c0d01e80 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01e7c:	b002      	add	sp, #8
c0d01e7e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e80:	6808      	ldr	r0, [r1, #0]
c0d01e82:	2104      	movs	r1, #4
c0d01e84:	f001 fa6e 	bl	c0d03364 <longjmp>
c0d01e88:	60006bcf 	.word	0x60006bcf
c0d01e8c:	20001bb8 	.word	0x20001bb8
c0d01e90:	90006b7f 	.word	0x90006b7f

c0d01e94 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01e94:	b5d0      	push	{r4, r6, r7, lr}
c0d01e96:	af02      	add	r7, sp, #8
c0d01e98:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01e9a:	4b0b      	ldr	r3, [pc, #44]	; (c0d01ec8 <io_seproxyhal_spi_recv+0x34>)
c0d01e9c:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e9e:	4b0b      	ldr	r3, [pc, #44]	; (c0d01ecc <io_seproxyhal_spi_recv+0x38>)
c0d01ea0:	681c      	ldr	r4, [r3, #0]
c0d01ea2:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01ea4:	ac03      	add	r4, sp, #12
c0d01ea6:	c407      	stmia	r4!, {r0, r1, r2}
c0d01ea8:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01eaa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01eac:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01eae:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01eb0:	4907      	ldr	r1, [pc, #28]	; (c0d01ed0 <io_seproxyhal_spi_recv+0x3c>)
c0d01eb2:	9a01      	ldr	r2, [sp, #4]
c0d01eb4:	428a      	cmp	r2, r1
c0d01eb6:	d102      	bne.n	c0d01ebe <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01eb8:	b280      	uxth	r0, r0
c0d01eba:	b006      	add	sp, #24
c0d01ebc:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ebe:	6818      	ldr	r0, [r3, #0]
c0d01ec0:	2104      	movs	r1, #4
c0d01ec2:	f001 fa4f 	bl	c0d03364 <longjmp>
c0d01ec6:	46c0      	nop			; (mov r8, r8)
c0d01ec8:	60006cd1 	.word	0x60006cd1
c0d01ecc:	20001bb8 	.word	0x20001bb8
c0d01ed0:	90006c2b 	.word	0x90006c2b

c0d01ed4 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01ed4:	b5b0      	push	{r4, r5, r7, lr}
c0d01ed6:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01ed8:	492c      	ldr	r1, [pc, #176]	; (c0d01f8c <bagl_ui_nanos_screen1_button+0xb8>)
c0d01eda:	4288      	cmp	r0, r1
c0d01edc:	d006      	beq.n	c0d01eec <bagl_ui_nanos_screen1_button+0x18>
c0d01ede:	492c      	ldr	r1, [pc, #176]	; (c0d01f90 <bagl_ui_nanos_screen1_button+0xbc>)
c0d01ee0:	4288      	cmp	r0, r1
c0d01ee2:	d151      	bne.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01ee4:	2000      	movs	r0, #0
c0d01ee6:	f7ff ff43 	bl	c0d01d70 <os_sched_exit>
c0d01eea:	e04d      	b.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01eec:	f7fe fba4 	bl	c0d00638 <nvram_is_init>
c0d01ef0:	2801      	cmp	r0, #1
c0d01ef2:	d102      	bne.n	c0d01efa <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01ef4:	a029      	add	r0, pc, #164	; (adr r0, c0d01f9c <bagl_ui_nanos_screen1_button+0xc8>)
c0d01ef6:	210d      	movs	r1, #13
c0d01ef8:	e001      	b.n	c0d01efe <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01efa:	a026      	add	r0, pc, #152	; (adr r0, c0d01f94 <bagl_ui_nanos_screen1_button+0xc0>)
c0d01efc:	2105      	movs	r1, #5
c0d01efe:	2203      	movs	r2, #3
c0d01f00:	f7fe f8d0 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01f04:	4c29      	ldr	r4, [pc, #164]	; (c0d01fac <bagl_ui_nanos_screen1_button+0xd8>)
c0d01f06:	482b      	ldr	r0, [pc, #172]	; (c0d01fb4 <bagl_ui_nanos_screen1_button+0xe0>)
c0d01f08:	4478      	add	r0, pc
c0d01f0a:	6020      	str	r0, [r4, #0]
c0d01f0c:	2004      	movs	r0, #4
c0d01f0e:	6060      	str	r0, [r4, #4]
c0d01f10:	4829      	ldr	r0, [pc, #164]	; (c0d01fb8 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01f12:	4478      	add	r0, pc
c0d01f14:	6120      	str	r0, [r4, #16]
c0d01f16:	2500      	movs	r5, #0
c0d01f18:	60e5      	str	r5, [r4, #12]
c0d01f1a:	2003      	movs	r0, #3
c0d01f1c:	7620      	strb	r0, [r4, #24]
c0d01f1e:	61e5      	str	r5, [r4, #28]
c0d01f20:	4620      	mov	r0, r4
c0d01f22:	3018      	adds	r0, #24
c0d01f24:	f7ff ff42 	bl	c0d01dac <os_ux>
c0d01f28:	61e0      	str	r0, [r4, #28]
c0d01f2a:	f7ff f903 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d01f2e:	60a5      	str	r5, [r4, #8]
c0d01f30:	6820      	ldr	r0, [r4, #0]
c0d01f32:	2800      	cmp	r0, #0
c0d01f34:	d028      	beq.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f36:	69e0      	ldr	r0, [r4, #28]
c0d01f38:	491d      	ldr	r1, [pc, #116]	; (c0d01fb0 <bagl_ui_nanos_screen1_button+0xdc>)
c0d01f3a:	4288      	cmp	r0, r1
c0d01f3c:	d116      	bne.n	c0d01f6c <bagl_ui_nanos_screen1_button+0x98>
c0d01f3e:	e023      	b.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f40:	6860      	ldr	r0, [r4, #4]
c0d01f42:	4285      	cmp	r5, r0
c0d01f44:	d220      	bcs.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f46:	f7ff ff89 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d01f4a:	2800      	cmp	r0, #0
c0d01f4c:	d11c      	bne.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f4e:	68a0      	ldr	r0, [r4, #8]
c0d01f50:	68e1      	ldr	r1, [r4, #12]
c0d01f52:	2538      	movs	r5, #56	; 0x38
c0d01f54:	4368      	muls	r0, r5
c0d01f56:	6822      	ldr	r2, [r4, #0]
c0d01f58:	1810      	adds	r0, r2, r0
c0d01f5a:	2900      	cmp	r1, #0
c0d01f5c:	d009      	beq.n	c0d01f72 <bagl_ui_nanos_screen1_button+0x9e>
c0d01f5e:	4788      	blx	r1
c0d01f60:	2800      	cmp	r0, #0
c0d01f62:	d106      	bne.n	c0d01f72 <bagl_ui_nanos_screen1_button+0x9e>
c0d01f64:	68a0      	ldr	r0, [r4, #8]
c0d01f66:	1c45      	adds	r5, r0, #1
c0d01f68:	60a5      	str	r5, [r4, #8]
c0d01f6a:	6820      	ldr	r0, [r4, #0]
c0d01f6c:	2800      	cmp	r0, #0
c0d01f6e:	d1e7      	bne.n	c0d01f40 <bagl_ui_nanos_screen1_button+0x6c>
c0d01f70:	e00a      	b.n	c0d01f88 <bagl_ui_nanos_screen1_button+0xb4>
c0d01f72:	2801      	cmp	r0, #1
c0d01f74:	d103      	bne.n	c0d01f7e <bagl_ui_nanos_screen1_button+0xaa>
c0d01f76:	68a0      	ldr	r0, [r4, #8]
c0d01f78:	4345      	muls	r5, r0
c0d01f7a:	6820      	ldr	r0, [r4, #0]
c0d01f7c:	1940      	adds	r0, r0, r5
c0d01f7e:	f7fe fb91 	bl	c0d006a4 <io_seproxyhal_display>
c0d01f82:	68a0      	ldr	r0, [r4, #8]
c0d01f84:	1c40      	adds	r0, r0, #1
c0d01f86:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01f88:	2000      	movs	r0, #0
c0d01f8a:	bdb0      	pop	{r4, r5, r7, pc}
c0d01f8c:	80000002 	.word	0x80000002
c0d01f90:	80000001 	.word	0x80000001
c0d01f94:	54494e49 	.word	0x54494e49
c0d01f98:	00000000 	.word	0x00000000
c0d01f9c:	6c697453 	.word	0x6c697453
c0d01fa0:	6e75206c 	.word	0x6e75206c
c0d01fa4:	74696e69 	.word	0x74696e69
c0d01fa8:	00000000 	.word	0x00000000
c0d01fac:	20001a98 	.word	0x20001a98
c0d01fb0:	b0105044 	.word	0xb0105044
c0d01fb4:	00001694 	.word	0x00001694
c0d01fb8:	00000153 	.word	0x00000153

c0d01fbc <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01fbc:	b5b0      	push	{r4, r5, r7, lr}
c0d01fbe:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01fc0:	2800      	cmp	r0, #0
c0d01fc2:	d005      	beq.n	c0d01fd0 <ui_display_debug+0x14>
c0d01fc4:	2900      	cmp	r1, #0
c0d01fc6:	d003      	beq.n	c0d01fd0 <ui_display_debug+0x14>
c0d01fc8:	2a00      	cmp	r2, #0
c0d01fca:	d001      	beq.n	c0d01fd0 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01fcc:	f7fe f86a 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01fd0:	4c21      	ldr	r4, [pc, #132]	; (c0d02058 <ui_display_debug+0x9c>)
c0d01fd2:	4823      	ldr	r0, [pc, #140]	; (c0d02060 <ui_display_debug+0xa4>)
c0d01fd4:	4478      	add	r0, pc
c0d01fd6:	6020      	str	r0, [r4, #0]
c0d01fd8:	2004      	movs	r0, #4
c0d01fda:	6060      	str	r0, [r4, #4]
c0d01fdc:	4821      	ldr	r0, [pc, #132]	; (c0d02064 <ui_display_debug+0xa8>)
c0d01fde:	4478      	add	r0, pc
c0d01fe0:	6120      	str	r0, [r4, #16]
c0d01fe2:	2500      	movs	r5, #0
c0d01fe4:	60e5      	str	r5, [r4, #12]
c0d01fe6:	2003      	movs	r0, #3
c0d01fe8:	7620      	strb	r0, [r4, #24]
c0d01fea:	61e5      	str	r5, [r4, #28]
c0d01fec:	4620      	mov	r0, r4
c0d01fee:	3018      	adds	r0, #24
c0d01ff0:	f7ff fedc 	bl	c0d01dac <os_ux>
c0d01ff4:	61e0      	str	r0, [r4, #28]
c0d01ff6:	f7ff f89d 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d01ffa:	60a5      	str	r5, [r4, #8]
c0d01ffc:	6820      	ldr	r0, [r4, #0]
c0d01ffe:	2800      	cmp	r0, #0
c0d02000:	d028      	beq.n	c0d02054 <ui_display_debug+0x98>
c0d02002:	69e0      	ldr	r0, [r4, #28]
c0d02004:	4915      	ldr	r1, [pc, #84]	; (c0d0205c <ui_display_debug+0xa0>)
c0d02006:	4288      	cmp	r0, r1
c0d02008:	d116      	bne.n	c0d02038 <ui_display_debug+0x7c>
c0d0200a:	e023      	b.n	c0d02054 <ui_display_debug+0x98>
c0d0200c:	6860      	ldr	r0, [r4, #4]
c0d0200e:	4285      	cmp	r5, r0
c0d02010:	d220      	bcs.n	c0d02054 <ui_display_debug+0x98>
c0d02012:	f7ff ff23 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d02016:	2800      	cmp	r0, #0
c0d02018:	d11c      	bne.n	c0d02054 <ui_display_debug+0x98>
c0d0201a:	68a0      	ldr	r0, [r4, #8]
c0d0201c:	68e1      	ldr	r1, [r4, #12]
c0d0201e:	2538      	movs	r5, #56	; 0x38
c0d02020:	4368      	muls	r0, r5
c0d02022:	6822      	ldr	r2, [r4, #0]
c0d02024:	1810      	adds	r0, r2, r0
c0d02026:	2900      	cmp	r1, #0
c0d02028:	d009      	beq.n	c0d0203e <ui_display_debug+0x82>
c0d0202a:	4788      	blx	r1
c0d0202c:	2800      	cmp	r0, #0
c0d0202e:	d106      	bne.n	c0d0203e <ui_display_debug+0x82>
c0d02030:	68a0      	ldr	r0, [r4, #8]
c0d02032:	1c45      	adds	r5, r0, #1
c0d02034:	60a5      	str	r5, [r4, #8]
c0d02036:	6820      	ldr	r0, [r4, #0]
c0d02038:	2800      	cmp	r0, #0
c0d0203a:	d1e7      	bne.n	c0d0200c <ui_display_debug+0x50>
c0d0203c:	e00a      	b.n	c0d02054 <ui_display_debug+0x98>
c0d0203e:	2801      	cmp	r0, #1
c0d02040:	d103      	bne.n	c0d0204a <ui_display_debug+0x8e>
c0d02042:	68a0      	ldr	r0, [r4, #8]
c0d02044:	4345      	muls	r5, r0
c0d02046:	6820      	ldr	r0, [r4, #0]
c0d02048:	1940      	adds	r0, r0, r5
c0d0204a:	f7fe fb2b 	bl	c0d006a4 <io_seproxyhal_display>
c0d0204e:	68a0      	ldr	r0, [r4, #8]
c0d02050:	1c40      	adds	r0, r0, #1
c0d02052:	60a0      	str	r0, [r4, #8]
}
c0d02054:	bdb0      	pop	{r4, r5, r7, pc}
c0d02056:	46c0      	nop			; (mov r8, r8)
c0d02058:	20001a98 	.word	0x20001a98
c0d0205c:	b0105044 	.word	0xb0105044
c0d02060:	000015c8 	.word	0x000015c8
c0d02064:	00000087 	.word	0x00000087

c0d02068 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02068:	b580      	push	{r7, lr}
c0d0206a:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d0206c:	4905      	ldr	r1, [pc, #20]	; (c0d02084 <bagl_ui_nanos_screen2_button+0x1c>)
c0d0206e:	4288      	cmp	r0, r1
c0d02070:	d002      	beq.n	c0d02078 <bagl_ui_nanos_screen2_button+0x10>
c0d02072:	4905      	ldr	r1, [pc, #20]	; (c0d02088 <bagl_ui_nanos_screen2_button+0x20>)
c0d02074:	4288      	cmp	r0, r1
c0d02076:	d102      	bne.n	c0d0207e <bagl_ui_nanos_screen2_button+0x16>
c0d02078:	2000      	movs	r0, #0
c0d0207a:	f7ff fe79 	bl	c0d01d70 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0207e:	2000      	movs	r0, #0
c0d02080:	bd80      	pop	{r7, pc}
c0d02082:	46c0      	nop			; (mov r8, r8)
c0d02084:	80000002 	.word	0x80000002
c0d02088:	80000001 	.word	0x80000001

c0d0208c <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d0208c:	b5b0      	push	{r4, r5, r7, lr}
c0d0208e:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02090:	2001      	movs	r0, #1
c0d02092:	0204      	lsls	r4, r0, #8
c0d02094:	f7ff fea8 	bl	c0d01de8 <os_seph_features>
c0d02098:	4220      	tst	r0, r4
c0d0209a:	d136      	bne.n	c0d0210a <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d0209c:	4c3c      	ldr	r4, [pc, #240]	; (c0d02190 <ui_idle+0x104>)
c0d0209e:	4840      	ldr	r0, [pc, #256]	; (c0d021a0 <ui_idle+0x114>)
c0d020a0:	4478      	add	r0, pc
c0d020a2:	6020      	str	r0, [r4, #0]
c0d020a4:	2004      	movs	r0, #4
c0d020a6:	6060      	str	r0, [r4, #4]
c0d020a8:	483e      	ldr	r0, [pc, #248]	; (c0d021a4 <ui_idle+0x118>)
c0d020aa:	4478      	add	r0, pc
c0d020ac:	6120      	str	r0, [r4, #16]
c0d020ae:	2500      	movs	r5, #0
c0d020b0:	60e5      	str	r5, [r4, #12]
c0d020b2:	2003      	movs	r0, #3
c0d020b4:	7620      	strb	r0, [r4, #24]
c0d020b6:	61e5      	str	r5, [r4, #28]
c0d020b8:	4620      	mov	r0, r4
c0d020ba:	3018      	adds	r0, #24
c0d020bc:	f7ff fe76 	bl	c0d01dac <os_ux>
c0d020c0:	61e0      	str	r0, [r4, #28]
c0d020c2:	f7ff f837 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d020c6:	60a5      	str	r5, [r4, #8]
c0d020c8:	6820      	ldr	r0, [r4, #0]
c0d020ca:	2800      	cmp	r0, #0
c0d020cc:	d05f      	beq.n	c0d0218e <ui_idle+0x102>
c0d020ce:	69e0      	ldr	r0, [r4, #28]
c0d020d0:	4930      	ldr	r1, [pc, #192]	; (c0d02194 <ui_idle+0x108>)
c0d020d2:	4288      	cmp	r0, r1
c0d020d4:	d116      	bne.n	c0d02104 <ui_idle+0x78>
c0d020d6:	e05a      	b.n	c0d0218e <ui_idle+0x102>
c0d020d8:	6860      	ldr	r0, [r4, #4]
c0d020da:	4285      	cmp	r5, r0
c0d020dc:	d257      	bcs.n	c0d0218e <ui_idle+0x102>
c0d020de:	f7ff febd 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d020e2:	2800      	cmp	r0, #0
c0d020e4:	d153      	bne.n	c0d0218e <ui_idle+0x102>
c0d020e6:	68a0      	ldr	r0, [r4, #8]
c0d020e8:	68e1      	ldr	r1, [r4, #12]
c0d020ea:	2538      	movs	r5, #56	; 0x38
c0d020ec:	4368      	muls	r0, r5
c0d020ee:	6822      	ldr	r2, [r4, #0]
c0d020f0:	1810      	adds	r0, r2, r0
c0d020f2:	2900      	cmp	r1, #0
c0d020f4:	d040      	beq.n	c0d02178 <ui_idle+0xec>
c0d020f6:	4788      	blx	r1
c0d020f8:	2800      	cmp	r0, #0
c0d020fa:	d13d      	bne.n	c0d02178 <ui_idle+0xec>
c0d020fc:	68a0      	ldr	r0, [r4, #8]
c0d020fe:	1c45      	adds	r5, r0, #1
c0d02100:	60a5      	str	r5, [r4, #8]
c0d02102:	6820      	ldr	r0, [r4, #0]
c0d02104:	2800      	cmp	r0, #0
c0d02106:	d1e7      	bne.n	c0d020d8 <ui_idle+0x4c>
c0d02108:	e041      	b.n	c0d0218e <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0210a:	4c21      	ldr	r4, [pc, #132]	; (c0d02190 <ui_idle+0x104>)
c0d0210c:	4822      	ldr	r0, [pc, #136]	; (c0d02198 <ui_idle+0x10c>)
c0d0210e:	4478      	add	r0, pc
c0d02110:	6020      	str	r0, [r4, #0]
c0d02112:	2004      	movs	r0, #4
c0d02114:	6060      	str	r0, [r4, #4]
c0d02116:	4821      	ldr	r0, [pc, #132]	; (c0d0219c <ui_idle+0x110>)
c0d02118:	4478      	add	r0, pc
c0d0211a:	6120      	str	r0, [r4, #16]
c0d0211c:	2500      	movs	r5, #0
c0d0211e:	60e5      	str	r5, [r4, #12]
c0d02120:	2003      	movs	r0, #3
c0d02122:	7620      	strb	r0, [r4, #24]
c0d02124:	61e5      	str	r5, [r4, #28]
c0d02126:	4620      	mov	r0, r4
c0d02128:	3018      	adds	r0, #24
c0d0212a:	f7ff fe3f 	bl	c0d01dac <os_ux>
c0d0212e:	61e0      	str	r0, [r4, #28]
c0d02130:	f7ff f800 	bl	c0d01134 <io_seproxyhal_init_ux>
c0d02134:	60a5      	str	r5, [r4, #8]
c0d02136:	6820      	ldr	r0, [r4, #0]
c0d02138:	2800      	cmp	r0, #0
c0d0213a:	d028      	beq.n	c0d0218e <ui_idle+0x102>
c0d0213c:	69e0      	ldr	r0, [r4, #28]
c0d0213e:	4915      	ldr	r1, [pc, #84]	; (c0d02194 <ui_idle+0x108>)
c0d02140:	4288      	cmp	r0, r1
c0d02142:	d116      	bne.n	c0d02172 <ui_idle+0xe6>
c0d02144:	e023      	b.n	c0d0218e <ui_idle+0x102>
c0d02146:	6860      	ldr	r0, [r4, #4]
c0d02148:	4285      	cmp	r5, r0
c0d0214a:	d220      	bcs.n	c0d0218e <ui_idle+0x102>
c0d0214c:	f7ff fe86 	bl	c0d01e5c <io_seproxyhal_spi_is_status_sent>
c0d02150:	2800      	cmp	r0, #0
c0d02152:	d11c      	bne.n	c0d0218e <ui_idle+0x102>
c0d02154:	68a0      	ldr	r0, [r4, #8]
c0d02156:	68e1      	ldr	r1, [r4, #12]
c0d02158:	2538      	movs	r5, #56	; 0x38
c0d0215a:	4368      	muls	r0, r5
c0d0215c:	6822      	ldr	r2, [r4, #0]
c0d0215e:	1810      	adds	r0, r2, r0
c0d02160:	2900      	cmp	r1, #0
c0d02162:	d009      	beq.n	c0d02178 <ui_idle+0xec>
c0d02164:	4788      	blx	r1
c0d02166:	2800      	cmp	r0, #0
c0d02168:	d106      	bne.n	c0d02178 <ui_idle+0xec>
c0d0216a:	68a0      	ldr	r0, [r4, #8]
c0d0216c:	1c45      	adds	r5, r0, #1
c0d0216e:	60a5      	str	r5, [r4, #8]
c0d02170:	6820      	ldr	r0, [r4, #0]
c0d02172:	2800      	cmp	r0, #0
c0d02174:	d1e7      	bne.n	c0d02146 <ui_idle+0xba>
c0d02176:	e00a      	b.n	c0d0218e <ui_idle+0x102>
c0d02178:	2801      	cmp	r0, #1
c0d0217a:	d103      	bne.n	c0d02184 <ui_idle+0xf8>
c0d0217c:	68a0      	ldr	r0, [r4, #8]
c0d0217e:	4345      	muls	r5, r0
c0d02180:	6820      	ldr	r0, [r4, #0]
c0d02182:	1940      	adds	r0, r0, r5
c0d02184:	f7fe fa8e 	bl	c0d006a4 <io_seproxyhal_display>
c0d02188:	68a0      	ldr	r0, [r4, #8]
c0d0218a:	1c40      	adds	r0, r0, #1
c0d0218c:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d0218e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02190:	20001a98 	.word	0x20001a98
c0d02194:	b0105044 	.word	0xb0105044
c0d02198:	0000156e 	.word	0x0000156e
c0d0219c:	0000008d 	.word	0x0000008d
c0d021a0:	0000141c 	.word	0x0000141c
c0d021a4:	fffffe27 	.word	0xfffffe27

c0d021a8 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d021a8:	2000      	movs	r0, #0
c0d021aa:	4770      	bx	lr

c0d021ac <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d021ac:	b5d0      	push	{r4, r6, r7, lr}
c0d021ae:	af02      	add	r7, sp, #8
c0d021b0:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d021b2:	4620      	mov	r0, r4
c0d021b4:	f7ff fddc 	bl	c0d01d70 <os_sched_exit>
    return NULL;
c0d021b8:	4620      	mov	r0, r4
c0d021ba:	bdd0      	pop	{r4, r6, r7, pc}

c0d021bc <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d021bc:	4902      	ldr	r1, [pc, #8]	; (c0d021c8 <USBD_LL_Init+0xc>)
c0d021be:	2000      	movs	r0, #0
c0d021c0:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d021c2:	4902      	ldr	r1, [pc, #8]	; (c0d021cc <USBD_LL_Init+0x10>)
c0d021c4:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d021c6:	4770      	bx	lr
c0d021c8:	20001d2c 	.word	0x20001d2c
c0d021cc:	20001d30 	.word	0x20001d30

c0d021d0 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d021d0:	b5d0      	push	{r4, r6, r7, lr}
c0d021d2:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021d4:	4806      	ldr	r0, [pc, #24]	; (c0d021f0 <USBD_LL_DeInit+0x20>)
c0d021d6:	214f      	movs	r1, #79	; 0x4f
c0d021d8:	7001      	strb	r1, [r0, #0]
c0d021da:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d021dc:	7044      	strb	r4, [r0, #1]
c0d021de:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d021e0:	7081      	strb	r1, [r0, #2]
c0d021e2:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d021e4:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d021e6:	2104      	movs	r1, #4
c0d021e8:	f7ff fe1a 	bl	c0d01e20 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d021ec:	4620      	mov	r0, r4
c0d021ee:	bdd0      	pop	{r4, r6, r7, pc}
c0d021f0:	20001a18 	.word	0x20001a18

c0d021f4 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d021f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d021f6:	af03      	add	r7, sp, #12
c0d021f8:	b083      	sub	sp, #12
c0d021fa:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021fc:	264f      	movs	r6, #79	; 0x4f
c0d021fe:	702e      	strb	r6, [r5, #0]
c0d02200:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02202:	706c      	strb	r4, [r5, #1]
c0d02204:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02206:	70a8      	strb	r0, [r5, #2]
c0d02208:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0220a:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d0220c:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0220e:	2105      	movs	r1, #5
c0d02210:	4628      	mov	r0, r5
c0d02212:	f7ff fe05 	bl	c0d01e20 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02216:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02218:	706c      	strb	r4, [r5, #1]
c0d0221a:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d0221c:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0221e:	70e8      	strb	r0, [r5, #3]
c0d02220:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02222:	4628      	mov	r0, r5
c0d02224:	f7ff fdfc 	bl	c0d01e20 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02228:	4620      	mov	r0, r4
c0d0222a:	b003      	add	sp, #12
c0d0222c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0222e <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0222e:	b5d0      	push	{r4, r6, r7, lr}
c0d02230:	af02      	add	r7, sp, #8
c0d02232:	b082      	sub	sp, #8
c0d02234:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02236:	214f      	movs	r1, #79	; 0x4f
c0d02238:	7001      	strb	r1, [r0, #0]
c0d0223a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0223c:	7044      	strb	r4, [r0, #1]
c0d0223e:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02240:	7081      	strb	r1, [r0, #2]
c0d02242:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02244:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d02246:	2104      	movs	r1, #4
c0d02248:	f7ff fdea 	bl	c0d01e20 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0224c:	4620      	mov	r0, r4
c0d0224e:	b002      	add	sp, #8
c0d02250:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02254 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02254:	b5b0      	push	{r4, r5, r7, lr}
c0d02256:	af02      	add	r7, sp, #8
c0d02258:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0225a:	480f      	ldr	r0, [pc, #60]	; (c0d02298 <USBD_LL_OpenEP+0x44>)
c0d0225c:	2400      	movs	r4, #0
c0d0225e:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02260:	480e      	ldr	r0, [pc, #56]	; (c0d0229c <USBD_LL_OpenEP+0x48>)
c0d02262:	6004      	str	r4, [r0, #0]
c0d02264:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02266:	254f      	movs	r5, #79	; 0x4f
c0d02268:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0226a:	7044      	strb	r4, [r0, #1]
c0d0226c:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0226e:	7085      	strb	r5, [r0, #2]
c0d02270:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02272:	70c5      	strb	r5, [r0, #3]
c0d02274:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02276:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02278:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0227a:	2a03      	cmp	r2, #3
c0d0227c:	d802      	bhi.n	c0d02284 <USBD_LL_OpenEP+0x30>
c0d0227e:	00d0      	lsls	r0, r2, #3
c0d02280:	4c07      	ldr	r4, [pc, #28]	; (c0d022a0 <USBD_LL_OpenEP+0x4c>)
c0d02282:	40c4      	lsrs	r4, r0
c0d02284:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02286:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02288:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0228a:	2108      	movs	r1, #8
c0d0228c:	f7ff fdc8 	bl	c0d01e20 <io_seproxyhal_spi_send>
c0d02290:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02292:	b002      	add	sp, #8
c0d02294:	bdb0      	pop	{r4, r5, r7, pc}
c0d02296:	46c0      	nop			; (mov r8, r8)
c0d02298:	20001d2c 	.word	0x20001d2c
c0d0229c:	20001d30 	.word	0x20001d30
c0d022a0:	02030401 	.word	0x02030401

c0d022a4 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d022a4:	b5d0      	push	{r4, r6, r7, lr}
c0d022a6:	af02      	add	r7, sp, #8
c0d022a8:	b082      	sub	sp, #8
c0d022aa:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d022ac:	224f      	movs	r2, #79	; 0x4f
c0d022ae:	7002      	strb	r2, [r0, #0]
c0d022b0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022b2:	7044      	strb	r4, [r0, #1]
c0d022b4:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d022b6:	7082      	strb	r2, [r0, #2]
c0d022b8:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d022ba:	70c2      	strb	r2, [r0, #3]
c0d022bc:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d022be:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d022c0:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d022c2:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d022c4:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d022c6:	2108      	movs	r1, #8
c0d022c8:	f7ff fdaa 	bl	c0d01e20 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d022cc:	4620      	mov	r0, r4
c0d022ce:	b002      	add	sp, #8
c0d022d0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d022d4 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d022d4:	b5b0      	push	{r4, r5, r7, lr}
c0d022d6:	af02      	add	r7, sp, #8
c0d022d8:	b082      	sub	sp, #8
c0d022da:	460d      	mov	r5, r1
c0d022dc:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d022de:	2150      	movs	r1, #80	; 0x50
c0d022e0:	7001      	strb	r1, [r0, #0]
c0d022e2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022e4:	7044      	strb	r4, [r0, #1]
c0d022e6:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d022e8:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d022ea:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d022ec:	2140      	movs	r1, #64	; 0x40
c0d022ee:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d022f0:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d022f2:	2106      	movs	r1, #6
c0d022f4:	f7ff fd94 	bl	c0d01e20 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d022f8:	2080      	movs	r0, #128	; 0x80
c0d022fa:	4205      	tst	r5, r0
c0d022fc:	d101      	bne.n	c0d02302 <USBD_LL_StallEP+0x2e>
c0d022fe:	4807      	ldr	r0, [pc, #28]	; (c0d0231c <USBD_LL_StallEP+0x48>)
c0d02300:	e000      	b.n	c0d02304 <USBD_LL_StallEP+0x30>
c0d02302:	4805      	ldr	r0, [pc, #20]	; (c0d02318 <USBD_LL_StallEP+0x44>)
c0d02304:	6801      	ldr	r1, [r0, #0]
c0d02306:	227f      	movs	r2, #127	; 0x7f
c0d02308:	4015      	ands	r5, r2
c0d0230a:	2201      	movs	r2, #1
c0d0230c:	40aa      	lsls	r2, r5
c0d0230e:	430a      	orrs	r2, r1
c0d02310:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02312:	4620      	mov	r0, r4
c0d02314:	b002      	add	sp, #8
c0d02316:	bdb0      	pop	{r4, r5, r7, pc}
c0d02318:	20001d2c 	.word	0x20001d2c
c0d0231c:	20001d30 	.word	0x20001d30

c0d02320 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02320:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02322:	af03      	add	r7, sp, #12
c0d02324:	b083      	sub	sp, #12
c0d02326:	460d      	mov	r5, r1
c0d02328:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0232a:	2150      	movs	r1, #80	; 0x50
c0d0232c:	7001      	strb	r1, [r0, #0]
c0d0232e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02330:	7044      	strb	r4, [r0, #1]
c0d02332:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02334:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02336:	70c5      	strb	r5, [r0, #3]
c0d02338:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0233a:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d0233c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0233e:	2106      	movs	r1, #6
c0d02340:	f7ff fd6e 	bl	c0d01e20 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02344:	4235      	tst	r5, r6
c0d02346:	d101      	bne.n	c0d0234c <USBD_LL_ClearStallEP+0x2c>
c0d02348:	4807      	ldr	r0, [pc, #28]	; (c0d02368 <USBD_LL_ClearStallEP+0x48>)
c0d0234a:	e000      	b.n	c0d0234e <USBD_LL_ClearStallEP+0x2e>
c0d0234c:	4805      	ldr	r0, [pc, #20]	; (c0d02364 <USBD_LL_ClearStallEP+0x44>)
c0d0234e:	6801      	ldr	r1, [r0, #0]
c0d02350:	227f      	movs	r2, #127	; 0x7f
c0d02352:	4015      	ands	r5, r2
c0d02354:	2201      	movs	r2, #1
c0d02356:	40aa      	lsls	r2, r5
c0d02358:	4391      	bics	r1, r2
c0d0235a:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0235c:	4620      	mov	r0, r4
c0d0235e:	b003      	add	sp, #12
c0d02360:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02362:	46c0      	nop			; (mov r8, r8)
c0d02364:	20001d2c 	.word	0x20001d2c
c0d02368:	20001d30 	.word	0x20001d30

c0d0236c <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d0236c:	2080      	movs	r0, #128	; 0x80
c0d0236e:	4201      	tst	r1, r0
c0d02370:	d001      	beq.n	c0d02376 <USBD_LL_IsStallEP+0xa>
c0d02372:	4806      	ldr	r0, [pc, #24]	; (c0d0238c <USBD_LL_IsStallEP+0x20>)
c0d02374:	e000      	b.n	c0d02378 <USBD_LL_IsStallEP+0xc>
c0d02376:	4804      	ldr	r0, [pc, #16]	; (c0d02388 <USBD_LL_IsStallEP+0x1c>)
c0d02378:	6800      	ldr	r0, [r0, #0]
c0d0237a:	227f      	movs	r2, #127	; 0x7f
c0d0237c:	4011      	ands	r1, r2
c0d0237e:	2201      	movs	r2, #1
c0d02380:	408a      	lsls	r2, r1
c0d02382:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02384:	b2d0      	uxtb	r0, r2
c0d02386:	4770      	bx	lr
c0d02388:	20001d30 	.word	0x20001d30
c0d0238c:	20001d2c 	.word	0x20001d2c

c0d02390 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02390:	b5d0      	push	{r4, r6, r7, lr}
c0d02392:	af02      	add	r7, sp, #8
c0d02394:	b082      	sub	sp, #8
c0d02396:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02398:	224f      	movs	r2, #79	; 0x4f
c0d0239a:	7002      	strb	r2, [r0, #0]
c0d0239c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0239e:	7044      	strb	r4, [r0, #1]
c0d023a0:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d023a2:	7082      	strb	r2, [r0, #2]
c0d023a4:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d023a6:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d023a8:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d023aa:	2105      	movs	r1, #5
c0d023ac:	f7ff fd38 	bl	c0d01e20 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d023b0:	4620      	mov	r0, r4
c0d023b2:	b002      	add	sp, #8
c0d023b4:	bdd0      	pop	{r4, r6, r7, pc}

c0d023b6 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d023b6:	b5b0      	push	{r4, r5, r7, lr}
c0d023b8:	af02      	add	r7, sp, #8
c0d023ba:	b082      	sub	sp, #8
c0d023bc:	461c      	mov	r4, r3
c0d023be:	4615      	mov	r5, r2
c0d023c0:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d023c2:	2250      	movs	r2, #80	; 0x50
c0d023c4:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d023c6:	1ce2      	adds	r2, r4, #3
c0d023c8:	0a13      	lsrs	r3, r2, #8
c0d023ca:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d023cc:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d023ce:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d023d0:	2120      	movs	r1, #32
c0d023d2:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d023d4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d023d6:	2106      	movs	r1, #6
c0d023d8:	f7ff fd22 	bl	c0d01e20 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d023dc:	4628      	mov	r0, r5
c0d023de:	4621      	mov	r1, r4
c0d023e0:	f7ff fd1e 	bl	c0d01e20 <io_seproxyhal_spi_send>
c0d023e4:	2000      	movs	r0, #0
  return USBD_OK;   
c0d023e6:	b002      	add	sp, #8
c0d023e8:	bdb0      	pop	{r4, r5, r7, pc}

c0d023ea <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d023ea:	b5d0      	push	{r4, r6, r7, lr}
c0d023ec:	af02      	add	r7, sp, #8
c0d023ee:	b082      	sub	sp, #8
c0d023f0:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d023f2:	2350      	movs	r3, #80	; 0x50
c0d023f4:	7003      	strb	r3, [r0, #0]
c0d023f6:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d023f8:	7044      	strb	r4, [r0, #1]
c0d023fa:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d023fc:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d023fe:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02400:	2130      	movs	r1, #48	; 0x30
c0d02402:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02404:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02406:	2106      	movs	r1, #6
c0d02408:	f7ff fd0a 	bl	c0d01e20 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d0240c:	4620      	mov	r0, r4
c0d0240e:	b002      	add	sp, #8
c0d02410:	bdd0      	pop	{r4, r6, r7, pc}

c0d02412 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02412:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02414:	af03      	add	r7, sp, #12
c0d02416:	b081      	sub	sp, #4
c0d02418:	4615      	mov	r5, r2
c0d0241a:	460e      	mov	r6, r1
c0d0241c:	4604      	mov	r4, r0
c0d0241e:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02420:	2c00      	cmp	r4, #0
c0d02422:	d011      	beq.n	c0d02448 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02424:	2049      	movs	r0, #73	; 0x49
c0d02426:	0081      	lsls	r1, r0, #2
c0d02428:	4620      	mov	r0, r4
c0d0242a:	f000 fef9 	bl	c0d03220 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0242e:	2e00      	cmp	r6, #0
c0d02430:	d002      	beq.n	c0d02438 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02432:	2011      	movs	r0, #17
c0d02434:	0100      	lsls	r0, r0, #4
c0d02436:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02438:	20fc      	movs	r0, #252	; 0xfc
c0d0243a:	2101      	movs	r1, #1
c0d0243c:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d0243e:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02440:	4620      	mov	r0, r4
c0d02442:	f7ff febb 	bl	c0d021bc <USBD_LL_Init>
c0d02446:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02448:	b2c0      	uxtb	r0, r0
c0d0244a:	b001      	add	sp, #4
c0d0244c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0244e <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d0244e:	b5d0      	push	{r4, r6, r7, lr}
c0d02450:	af02      	add	r7, sp, #8
c0d02452:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02454:	20fc      	movs	r0, #252	; 0xfc
c0d02456:	2101      	movs	r1, #1
c0d02458:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d0245a:	2045      	movs	r0, #69	; 0x45
c0d0245c:	0080      	lsls	r0, r0, #2
c0d0245e:	5820      	ldr	r0, [r4, r0]
c0d02460:	2800      	cmp	r0, #0
c0d02462:	d006      	beq.n	c0d02472 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02464:	6840      	ldr	r0, [r0, #4]
c0d02466:	f7ff fb1f 	bl	c0d01aa8 <pic>
c0d0246a:	4602      	mov	r2, r0
c0d0246c:	7921      	ldrb	r1, [r4, #4]
c0d0246e:	4620      	mov	r0, r4
c0d02470:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02472:	4620      	mov	r0, r4
c0d02474:	f7ff fedb 	bl	c0d0222e <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02478:	4620      	mov	r0, r4
c0d0247a:	f7ff fea9 	bl	c0d021d0 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d0247e:	2000      	movs	r0, #0
c0d02480:	bdd0      	pop	{r4, r6, r7, pc}

c0d02482 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02482:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02484:	2900      	cmp	r1, #0
c0d02486:	d003      	beq.n	c0d02490 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02488:	2245      	movs	r2, #69	; 0x45
c0d0248a:	0092      	lsls	r2, r2, #2
c0d0248c:	5081      	str	r1, [r0, r2]
c0d0248e:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02490:	b2d0      	uxtb	r0, r2
c0d02492:	4770      	bx	lr

c0d02494 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02494:	b580      	push	{r7, lr}
c0d02496:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02498:	f7ff feac 	bl	c0d021f4 <USBD_LL_Start>
  
  return USBD_OK;  
c0d0249c:	2000      	movs	r0, #0
c0d0249e:	bd80      	pop	{r7, pc}

c0d024a0 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d024a0:	b5b0      	push	{r4, r5, r7, lr}
c0d024a2:	af02      	add	r7, sp, #8
c0d024a4:	460c      	mov	r4, r1
c0d024a6:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d024a8:	2045      	movs	r0, #69	; 0x45
c0d024aa:	0080      	lsls	r0, r0, #2
c0d024ac:	5828      	ldr	r0, [r5, r0]
c0d024ae:	2800      	cmp	r0, #0
c0d024b0:	d00c      	beq.n	c0d024cc <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d024b2:	6800      	ldr	r0, [r0, #0]
c0d024b4:	f7ff faf8 	bl	c0d01aa8 <pic>
c0d024b8:	4602      	mov	r2, r0
c0d024ba:	4628      	mov	r0, r5
c0d024bc:	4621      	mov	r1, r4
c0d024be:	4790      	blx	r2
c0d024c0:	4601      	mov	r1, r0
c0d024c2:	2002      	movs	r0, #2
c0d024c4:	2900      	cmp	r1, #0
c0d024c6:	d100      	bne.n	c0d024ca <USBD_SetClassConfig+0x2a>
c0d024c8:	4608      	mov	r0, r1
c0d024ca:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d024cc:	2002      	movs	r0, #2
c0d024ce:	bdb0      	pop	{r4, r5, r7, pc}

c0d024d0 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d024d0:	b5b0      	push	{r4, r5, r7, lr}
c0d024d2:	af02      	add	r7, sp, #8
c0d024d4:	460c      	mov	r4, r1
c0d024d6:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d024d8:	2045      	movs	r0, #69	; 0x45
c0d024da:	0080      	lsls	r0, r0, #2
c0d024dc:	5828      	ldr	r0, [r5, r0]
c0d024de:	2800      	cmp	r0, #0
c0d024e0:	d006      	beq.n	c0d024f0 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d024e2:	6840      	ldr	r0, [r0, #4]
c0d024e4:	f7ff fae0 	bl	c0d01aa8 <pic>
c0d024e8:	4602      	mov	r2, r0
c0d024ea:	4628      	mov	r0, r5
c0d024ec:	4621      	mov	r1, r4
c0d024ee:	4790      	blx	r2
  }
  return USBD_OK;
c0d024f0:	2000      	movs	r0, #0
c0d024f2:	bdb0      	pop	{r4, r5, r7, pc}

c0d024f4 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d024f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d024f6:	af03      	add	r7, sp, #12
c0d024f8:	b081      	sub	sp, #4
c0d024fa:	4604      	mov	r4, r0
c0d024fc:	2021      	movs	r0, #33	; 0x21
c0d024fe:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02500:	19a5      	adds	r5, r4, r6
c0d02502:	4628      	mov	r0, r5
c0d02504:	f000 fb69 	bl	c0d02bda <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02508:	20f4      	movs	r0, #244	; 0xf4
c0d0250a:	2101      	movs	r1, #1
c0d0250c:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0250e:	2087      	movs	r0, #135	; 0x87
c0d02510:	0040      	lsls	r0, r0, #1
c0d02512:	5a20      	ldrh	r0, [r4, r0]
c0d02514:	21f8      	movs	r1, #248	; 0xf8
c0d02516:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02518:	5da1      	ldrb	r1, [r4, r6]
c0d0251a:	201f      	movs	r0, #31
c0d0251c:	4008      	ands	r0, r1
c0d0251e:	2802      	cmp	r0, #2
c0d02520:	d008      	beq.n	c0d02534 <USBD_LL_SetupStage+0x40>
c0d02522:	2801      	cmp	r0, #1
c0d02524:	d00b      	beq.n	c0d0253e <USBD_LL_SetupStage+0x4a>
c0d02526:	2800      	cmp	r0, #0
c0d02528:	d10e      	bne.n	c0d02548 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d0252a:	4620      	mov	r0, r4
c0d0252c:	4629      	mov	r1, r5
c0d0252e:	f000 f8f1 	bl	c0d02714 <USBD_StdDevReq>
c0d02532:	e00e      	b.n	c0d02552 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02534:	4620      	mov	r0, r4
c0d02536:	4629      	mov	r1, r5
c0d02538:	f000 fad3 	bl	c0d02ae2 <USBD_StdEPReq>
c0d0253c:	e009      	b.n	c0d02552 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d0253e:	4620      	mov	r0, r4
c0d02540:	4629      	mov	r1, r5
c0d02542:	f000 faa6 	bl	c0d02a92 <USBD_StdItfReq>
c0d02546:	e004      	b.n	c0d02552 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02548:	2080      	movs	r0, #128	; 0x80
c0d0254a:	4001      	ands	r1, r0
c0d0254c:	4620      	mov	r0, r4
c0d0254e:	f7ff fec1 	bl	c0d022d4 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02552:	2000      	movs	r0, #0
c0d02554:	b001      	add	sp, #4
c0d02556:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02558 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02558:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0255a:	af03      	add	r7, sp, #12
c0d0255c:	b081      	sub	sp, #4
c0d0255e:	4615      	mov	r5, r2
c0d02560:	460e      	mov	r6, r1
c0d02562:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02564:	2e00      	cmp	r6, #0
c0d02566:	d011      	beq.n	c0d0258c <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02568:	2045      	movs	r0, #69	; 0x45
c0d0256a:	0080      	lsls	r0, r0, #2
c0d0256c:	5820      	ldr	r0, [r4, r0]
c0d0256e:	6980      	ldr	r0, [r0, #24]
c0d02570:	2800      	cmp	r0, #0
c0d02572:	d034      	beq.n	c0d025de <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02574:	21fc      	movs	r1, #252	; 0xfc
c0d02576:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02578:	2903      	cmp	r1, #3
c0d0257a:	d130      	bne.n	c0d025de <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d0257c:	f7ff fa94 	bl	c0d01aa8 <pic>
c0d02580:	4603      	mov	r3, r0
c0d02582:	4620      	mov	r0, r4
c0d02584:	4631      	mov	r1, r6
c0d02586:	462a      	mov	r2, r5
c0d02588:	4798      	blx	r3
c0d0258a:	e028      	b.n	c0d025de <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d0258c:	20f4      	movs	r0, #244	; 0xf4
c0d0258e:	5820      	ldr	r0, [r4, r0]
c0d02590:	2803      	cmp	r0, #3
c0d02592:	d124      	bne.n	c0d025de <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02594:	2090      	movs	r0, #144	; 0x90
c0d02596:	5820      	ldr	r0, [r4, r0]
c0d02598:	218c      	movs	r1, #140	; 0x8c
c0d0259a:	5861      	ldr	r1, [r4, r1]
c0d0259c:	4622      	mov	r2, r4
c0d0259e:	328c      	adds	r2, #140	; 0x8c
c0d025a0:	4281      	cmp	r1, r0
c0d025a2:	d90a      	bls.n	c0d025ba <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d025a4:	1a09      	subs	r1, r1, r0
c0d025a6:	6011      	str	r1, [r2, #0]
c0d025a8:	4281      	cmp	r1, r0
c0d025aa:	d300      	bcc.n	c0d025ae <USBD_LL_DataOutStage+0x56>
c0d025ac:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d025ae:	b28a      	uxth	r2, r1
c0d025b0:	4620      	mov	r0, r4
c0d025b2:	4629      	mov	r1, r5
c0d025b4:	f000 fc70 	bl	c0d02e98 <USBD_CtlContinueRx>
c0d025b8:	e011      	b.n	c0d025de <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d025ba:	2045      	movs	r0, #69	; 0x45
c0d025bc:	0080      	lsls	r0, r0, #2
c0d025be:	5820      	ldr	r0, [r4, r0]
c0d025c0:	6900      	ldr	r0, [r0, #16]
c0d025c2:	2800      	cmp	r0, #0
c0d025c4:	d008      	beq.n	c0d025d8 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d025c6:	21fc      	movs	r1, #252	; 0xfc
c0d025c8:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d025ca:	2903      	cmp	r1, #3
c0d025cc:	d104      	bne.n	c0d025d8 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d025ce:	f7ff fa6b 	bl	c0d01aa8 <pic>
c0d025d2:	4601      	mov	r1, r0
c0d025d4:	4620      	mov	r0, r4
c0d025d6:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d025d8:	4620      	mov	r0, r4
c0d025da:	f000 fc65 	bl	c0d02ea8 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d025de:	2000      	movs	r0, #0
c0d025e0:	b001      	add	sp, #4
c0d025e2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d025e4 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d025e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d025e6:	af03      	add	r7, sp, #12
c0d025e8:	b081      	sub	sp, #4
c0d025ea:	460d      	mov	r5, r1
c0d025ec:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d025ee:	2d00      	cmp	r5, #0
c0d025f0:	d012      	beq.n	c0d02618 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d025f2:	2045      	movs	r0, #69	; 0x45
c0d025f4:	0080      	lsls	r0, r0, #2
c0d025f6:	5820      	ldr	r0, [r4, r0]
c0d025f8:	2800      	cmp	r0, #0
c0d025fa:	d054      	beq.n	c0d026a6 <USBD_LL_DataInStage+0xc2>
c0d025fc:	6940      	ldr	r0, [r0, #20]
c0d025fe:	2800      	cmp	r0, #0
c0d02600:	d051      	beq.n	c0d026a6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02602:	21fc      	movs	r1, #252	; 0xfc
c0d02604:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02606:	2903      	cmp	r1, #3
c0d02608:	d14d      	bne.n	c0d026a6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d0260a:	f7ff fa4d 	bl	c0d01aa8 <pic>
c0d0260e:	4602      	mov	r2, r0
c0d02610:	4620      	mov	r0, r4
c0d02612:	4629      	mov	r1, r5
c0d02614:	4790      	blx	r2
c0d02616:	e046      	b.n	c0d026a6 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02618:	20f4      	movs	r0, #244	; 0xf4
c0d0261a:	5820      	ldr	r0, [r4, r0]
c0d0261c:	2802      	cmp	r0, #2
c0d0261e:	d13a      	bne.n	c0d02696 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02620:	69e0      	ldr	r0, [r4, #28]
c0d02622:	6a25      	ldr	r5, [r4, #32]
c0d02624:	42a8      	cmp	r0, r5
c0d02626:	d90b      	bls.n	c0d02640 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02628:	1b40      	subs	r0, r0, r5
c0d0262a:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d0262c:	2109      	movs	r1, #9
c0d0262e:	014a      	lsls	r2, r1, #5
c0d02630:	58a1      	ldr	r1, [r4, r2]
c0d02632:	1949      	adds	r1, r1, r5
c0d02634:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02636:	b282      	uxth	r2, r0
c0d02638:	4620      	mov	r0, r4
c0d0263a:	f000 fc1e 	bl	c0d02e7a <USBD_CtlContinueSendData>
c0d0263e:	e02a      	b.n	c0d02696 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02640:	69a6      	ldr	r6, [r4, #24]
c0d02642:	4630      	mov	r0, r6
c0d02644:	4629      	mov	r1, r5
c0d02646:	f000 fccf 	bl	c0d02fe8 <__aeabi_uidivmod>
c0d0264a:	42ae      	cmp	r6, r5
c0d0264c:	d30f      	bcc.n	c0d0266e <USBD_LL_DataInStage+0x8a>
c0d0264e:	2900      	cmp	r1, #0
c0d02650:	d10d      	bne.n	c0d0266e <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02652:	20f8      	movs	r0, #248	; 0xf8
c0d02654:	5820      	ldr	r0, [r4, r0]
c0d02656:	4625      	mov	r5, r4
c0d02658:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d0265a:	4286      	cmp	r6, r0
c0d0265c:	d207      	bcs.n	c0d0266e <USBD_LL_DataInStage+0x8a>
c0d0265e:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02660:	4620      	mov	r0, r4
c0d02662:	4631      	mov	r1, r6
c0d02664:	4632      	mov	r2, r6
c0d02666:	f000 fc08 	bl	c0d02e7a <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d0266a:	602e      	str	r6, [r5, #0]
c0d0266c:	e013      	b.n	c0d02696 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0266e:	2045      	movs	r0, #69	; 0x45
c0d02670:	0080      	lsls	r0, r0, #2
c0d02672:	5820      	ldr	r0, [r4, r0]
c0d02674:	2800      	cmp	r0, #0
c0d02676:	d00b      	beq.n	c0d02690 <USBD_LL_DataInStage+0xac>
c0d02678:	68c0      	ldr	r0, [r0, #12]
c0d0267a:	2800      	cmp	r0, #0
c0d0267c:	d008      	beq.n	c0d02690 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0267e:	21fc      	movs	r1, #252	; 0xfc
c0d02680:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02682:	2903      	cmp	r1, #3
c0d02684:	d104      	bne.n	c0d02690 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02686:	f7ff fa0f 	bl	c0d01aa8 <pic>
c0d0268a:	4601      	mov	r1, r0
c0d0268c:	4620      	mov	r0, r4
c0d0268e:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02690:	4620      	mov	r0, r4
c0d02692:	f000 fc16 	bl	c0d02ec2 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02696:	2001      	movs	r0, #1
c0d02698:	0201      	lsls	r1, r0, #8
c0d0269a:	1860      	adds	r0, r4, r1
c0d0269c:	5c61      	ldrb	r1, [r4, r1]
c0d0269e:	2901      	cmp	r1, #1
c0d026a0:	d101      	bne.n	c0d026a6 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d026a2:	2100      	movs	r1, #0
c0d026a4:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d026a6:	2000      	movs	r0, #0
c0d026a8:	b001      	add	sp, #4
c0d026aa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d026ac <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d026ac:	b5d0      	push	{r4, r6, r7, lr}
c0d026ae:	af02      	add	r7, sp, #8
c0d026b0:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d026b2:	2090      	movs	r0, #144	; 0x90
c0d026b4:	2140      	movs	r1, #64	; 0x40
c0d026b6:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d026b8:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d026ba:	20fc      	movs	r0, #252	; 0xfc
c0d026bc:	2101      	movs	r1, #1
c0d026be:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d026c0:	2045      	movs	r0, #69	; 0x45
c0d026c2:	0080      	lsls	r0, r0, #2
c0d026c4:	5820      	ldr	r0, [r4, r0]
c0d026c6:	2800      	cmp	r0, #0
c0d026c8:	d006      	beq.n	c0d026d8 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d026ca:	6840      	ldr	r0, [r0, #4]
c0d026cc:	f7ff f9ec 	bl	c0d01aa8 <pic>
c0d026d0:	4602      	mov	r2, r0
c0d026d2:	7921      	ldrb	r1, [r4, #4]
c0d026d4:	4620      	mov	r0, r4
c0d026d6:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d026d8:	2000      	movs	r0, #0
c0d026da:	bdd0      	pop	{r4, r6, r7, pc}

c0d026dc <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d026dc:	7401      	strb	r1, [r0, #16]
c0d026de:	2000      	movs	r0, #0
  return USBD_OK;
c0d026e0:	4770      	bx	lr

c0d026e2 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d026e2:	2000      	movs	r0, #0
c0d026e4:	4770      	bx	lr

c0d026e6 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d026e6:	2000      	movs	r0, #0
c0d026e8:	4770      	bx	lr

c0d026ea <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d026ea:	b5d0      	push	{r4, r6, r7, lr}
c0d026ec:	af02      	add	r7, sp, #8
c0d026ee:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d026f0:	20fc      	movs	r0, #252	; 0xfc
c0d026f2:	5c20      	ldrb	r0, [r4, r0]
c0d026f4:	2803      	cmp	r0, #3
c0d026f6:	d10a      	bne.n	c0d0270e <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d026f8:	2045      	movs	r0, #69	; 0x45
c0d026fa:	0080      	lsls	r0, r0, #2
c0d026fc:	5820      	ldr	r0, [r4, r0]
c0d026fe:	69c0      	ldr	r0, [r0, #28]
c0d02700:	2800      	cmp	r0, #0
c0d02702:	d004      	beq.n	c0d0270e <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02704:	f7ff f9d0 	bl	c0d01aa8 <pic>
c0d02708:	4601      	mov	r1, r0
c0d0270a:	4620      	mov	r0, r4
c0d0270c:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d0270e:	2000      	movs	r0, #0
c0d02710:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02714 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02714:	b5d0      	push	{r4, r6, r7, lr}
c0d02716:	af02      	add	r7, sp, #8
c0d02718:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d0271a:	7848      	ldrb	r0, [r1, #1]
c0d0271c:	2809      	cmp	r0, #9
c0d0271e:	d810      	bhi.n	c0d02742 <USBD_StdDevReq+0x2e>
c0d02720:	4478      	add	r0, pc
c0d02722:	7900      	ldrb	r0, [r0, #4]
c0d02724:	0040      	lsls	r0, r0, #1
c0d02726:	4487      	add	pc, r0
c0d02728:	150c0804 	.word	0x150c0804
c0d0272c:	0c25190c 	.word	0x0c25190c
c0d02730:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02732:	4620      	mov	r0, r4
c0d02734:	f000 f938 	bl	c0d029a8 <USBD_GetStatus>
c0d02738:	e01f      	b.n	c0d0277a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d0273a:	4620      	mov	r0, r4
c0d0273c:	f000 f976 	bl	c0d02a2c <USBD_ClrFeature>
c0d02740:	e01b      	b.n	c0d0277a <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02742:	2180      	movs	r1, #128	; 0x80
c0d02744:	4620      	mov	r0, r4
c0d02746:	f7ff fdc5 	bl	c0d022d4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0274a:	2100      	movs	r1, #0
c0d0274c:	4620      	mov	r0, r4
c0d0274e:	f7ff fdc1 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02752:	e012      	b.n	c0d0277a <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02754:	4620      	mov	r0, r4
c0d02756:	f000 f950 	bl	c0d029fa <USBD_SetFeature>
c0d0275a:	e00e      	b.n	c0d0277a <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d0275c:	4620      	mov	r0, r4
c0d0275e:	f000 f897 	bl	c0d02890 <USBD_SetAddress>
c0d02762:	e00a      	b.n	c0d0277a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02764:	4620      	mov	r0, r4
c0d02766:	f000 f8ff 	bl	c0d02968 <USBD_GetConfig>
c0d0276a:	e006      	b.n	c0d0277a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d0276c:	4620      	mov	r0, r4
c0d0276e:	f000 f8bd 	bl	c0d028ec <USBD_SetConfig>
c0d02772:	e002      	b.n	c0d0277a <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02774:	4620      	mov	r0, r4
c0d02776:	f000 f803 	bl	c0d02780 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d0277a:	2000      	movs	r0, #0
c0d0277c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02780 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02780:	b5b0      	push	{r4, r5, r7, lr}
c0d02782:	af02      	add	r7, sp, #8
c0d02784:	b082      	sub	sp, #8
c0d02786:	460d      	mov	r5, r1
c0d02788:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d0278a:	8868      	ldrh	r0, [r5, #2]
c0d0278c:	0a01      	lsrs	r1, r0, #8
c0d0278e:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02790:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02792:	2a0e      	cmp	r2, #14
c0d02794:	d83e      	bhi.n	c0d02814 <USBD_GetDescriptor+0x94>
c0d02796:	46c0      	nop			; (mov r8, r8)
c0d02798:	447a      	add	r2, pc
c0d0279a:	7912      	ldrb	r2, [r2, #4]
c0d0279c:	0052      	lsls	r2, r2, #1
c0d0279e:	4497      	add	pc, r2
c0d027a0:	390c2607 	.word	0x390c2607
c0d027a4:	39362e39 	.word	0x39362e39
c0d027a8:	39393939 	.word	0x39393939
c0d027ac:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d027b0:	2011      	movs	r0, #17
c0d027b2:	0100      	lsls	r0, r0, #4
c0d027b4:	5820      	ldr	r0, [r4, r0]
c0d027b6:	6800      	ldr	r0, [r0, #0]
c0d027b8:	e012      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d027ba:	b2c0      	uxtb	r0, r0
c0d027bc:	2805      	cmp	r0, #5
c0d027be:	d829      	bhi.n	c0d02814 <USBD_GetDescriptor+0x94>
c0d027c0:	4478      	add	r0, pc
c0d027c2:	7900      	ldrb	r0, [r0, #4]
c0d027c4:	0040      	lsls	r0, r0, #1
c0d027c6:	4487      	add	pc, r0
c0d027c8:	544f4a02 	.word	0x544f4a02
c0d027cc:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d027ce:	2011      	movs	r0, #17
c0d027d0:	0100      	lsls	r0, r0, #4
c0d027d2:	5820      	ldr	r0, [r4, r0]
c0d027d4:	6840      	ldr	r0, [r0, #4]
c0d027d6:	e003      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d027d8:	2011      	movs	r0, #17
c0d027da:	0100      	lsls	r0, r0, #4
c0d027dc:	5820      	ldr	r0, [r4, r0]
c0d027de:	69c0      	ldr	r0, [r0, #28]
c0d027e0:	f7ff f962 	bl	c0d01aa8 <pic>
c0d027e4:	4602      	mov	r2, r0
c0d027e6:	7c20      	ldrb	r0, [r4, #16]
c0d027e8:	a901      	add	r1, sp, #4
c0d027ea:	4790      	blx	r2
c0d027ec:	e025      	b.n	c0d0283a <USBD_GetDescriptor+0xba>
c0d027ee:	2045      	movs	r0, #69	; 0x45
c0d027f0:	0080      	lsls	r0, r0, #2
c0d027f2:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d027f4:	7c21      	ldrb	r1, [r4, #16]
c0d027f6:	2900      	cmp	r1, #0
c0d027f8:	d014      	beq.n	c0d02824 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d027fa:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d027fc:	e018      	b.n	c0d02830 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d027fe:	7c20      	ldrb	r0, [r4, #16]
c0d02800:	2800      	cmp	r0, #0
c0d02802:	d107      	bne.n	c0d02814 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02804:	2045      	movs	r0, #69	; 0x45
c0d02806:	0080      	lsls	r0, r0, #2
c0d02808:	5820      	ldr	r0, [r4, r0]
c0d0280a:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d0280c:	e010      	b.n	c0d02830 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0280e:	7c20      	ldrb	r0, [r4, #16]
c0d02810:	2800      	cmp	r0, #0
c0d02812:	d009      	beq.n	c0d02828 <USBD_GetDescriptor+0xa8>
c0d02814:	4620      	mov	r0, r4
c0d02816:	f7ff fd5d 	bl	c0d022d4 <USBD_LL_StallEP>
c0d0281a:	2100      	movs	r1, #0
c0d0281c:	4620      	mov	r0, r4
c0d0281e:	f7ff fd59 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02822:	e01a      	b.n	c0d0285a <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02824:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02826:	e003      	b.n	c0d02830 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02828:	2045      	movs	r0, #69	; 0x45
c0d0282a:	0080      	lsls	r0, r0, #2
c0d0282c:	5820      	ldr	r0, [r4, r0]
c0d0282e:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02830:	f7ff f93a 	bl	c0d01aa8 <pic>
c0d02834:	4601      	mov	r1, r0
c0d02836:	a801      	add	r0, sp, #4
c0d02838:	4788      	blx	r1
c0d0283a:	4601      	mov	r1, r0
c0d0283c:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0283e:	8802      	ldrh	r2, [r0, #0]
c0d02840:	2a00      	cmp	r2, #0
c0d02842:	d00a      	beq.n	c0d0285a <USBD_GetDescriptor+0xda>
c0d02844:	88e8      	ldrh	r0, [r5, #6]
c0d02846:	2800      	cmp	r0, #0
c0d02848:	d007      	beq.n	c0d0285a <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d0284a:	4282      	cmp	r2, r0
c0d0284c:	d300      	bcc.n	c0d02850 <USBD_GetDescriptor+0xd0>
c0d0284e:	4602      	mov	r2, r0
c0d02850:	a801      	add	r0, sp, #4
c0d02852:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02854:	4620      	mov	r0, r4
c0d02856:	f000 faf9 	bl	c0d02e4c <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d0285a:	b002      	add	sp, #8
c0d0285c:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d0285e:	2011      	movs	r0, #17
c0d02860:	0100      	lsls	r0, r0, #4
c0d02862:	5820      	ldr	r0, [r4, r0]
c0d02864:	6880      	ldr	r0, [r0, #8]
c0d02866:	e7bb      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02868:	2011      	movs	r0, #17
c0d0286a:	0100      	lsls	r0, r0, #4
c0d0286c:	5820      	ldr	r0, [r4, r0]
c0d0286e:	68c0      	ldr	r0, [r0, #12]
c0d02870:	e7b6      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02872:	2011      	movs	r0, #17
c0d02874:	0100      	lsls	r0, r0, #4
c0d02876:	5820      	ldr	r0, [r4, r0]
c0d02878:	6900      	ldr	r0, [r0, #16]
c0d0287a:	e7b1      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d0287c:	2011      	movs	r0, #17
c0d0287e:	0100      	lsls	r0, r0, #4
c0d02880:	5820      	ldr	r0, [r4, r0]
c0d02882:	6940      	ldr	r0, [r0, #20]
c0d02884:	e7ac      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02886:	2011      	movs	r0, #17
c0d02888:	0100      	lsls	r0, r0, #4
c0d0288a:	5820      	ldr	r0, [r4, r0]
c0d0288c:	6980      	ldr	r0, [r0, #24]
c0d0288e:	e7a7      	b.n	c0d027e0 <USBD_GetDescriptor+0x60>

c0d02890 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02890:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02892:	af03      	add	r7, sp, #12
c0d02894:	b081      	sub	sp, #4
c0d02896:	460a      	mov	r2, r1
c0d02898:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0289a:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0289c:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0289e:	2800      	cmp	r0, #0
c0d028a0:	d10b      	bne.n	c0d028ba <USBD_SetAddress+0x2a>
c0d028a2:	88d0      	ldrh	r0, [r2, #6]
c0d028a4:	2800      	cmp	r0, #0
c0d028a6:	d108      	bne.n	c0d028ba <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d028a8:	8850      	ldrh	r0, [r2, #2]
c0d028aa:	267f      	movs	r6, #127	; 0x7f
c0d028ac:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d028ae:	20fc      	movs	r0, #252	; 0xfc
c0d028b0:	5c20      	ldrb	r0, [r4, r0]
c0d028b2:	4625      	mov	r5, r4
c0d028b4:	35fc      	adds	r5, #252	; 0xfc
c0d028b6:	2803      	cmp	r0, #3
c0d028b8:	d108      	bne.n	c0d028cc <USBD_SetAddress+0x3c>
c0d028ba:	4620      	mov	r0, r4
c0d028bc:	f7ff fd0a 	bl	c0d022d4 <USBD_LL_StallEP>
c0d028c0:	2100      	movs	r1, #0
c0d028c2:	4620      	mov	r0, r4
c0d028c4:	f7ff fd06 	bl	c0d022d4 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d028c8:	b001      	add	sp, #4
c0d028ca:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d028cc:	20fe      	movs	r0, #254	; 0xfe
c0d028ce:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d028d0:	b2f1      	uxtb	r1, r6
c0d028d2:	4620      	mov	r0, r4
c0d028d4:	f7ff fd5c 	bl	c0d02390 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d028d8:	4620      	mov	r0, r4
c0d028da:	f000 fae5 	bl	c0d02ea8 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d028de:	2002      	movs	r0, #2
c0d028e0:	2101      	movs	r1, #1
c0d028e2:	2e00      	cmp	r6, #0
c0d028e4:	d100      	bne.n	c0d028e8 <USBD_SetAddress+0x58>
c0d028e6:	4608      	mov	r0, r1
c0d028e8:	7028      	strb	r0, [r5, #0]
c0d028ea:	e7ed      	b.n	c0d028c8 <USBD_SetAddress+0x38>

c0d028ec <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d028ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028ee:	af03      	add	r7, sp, #12
c0d028f0:	b081      	sub	sp, #4
c0d028f2:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d028f4:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028f6:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d028f8:	2e02      	cmp	r6, #2
c0d028fa:	d21d      	bcs.n	c0d02938 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d028fc:	20fc      	movs	r0, #252	; 0xfc
c0d028fe:	5c21      	ldrb	r1, [r4, r0]
c0d02900:	4620      	mov	r0, r4
c0d02902:	30fc      	adds	r0, #252	; 0xfc
c0d02904:	2903      	cmp	r1, #3
c0d02906:	d007      	beq.n	c0d02918 <USBD_SetConfig+0x2c>
c0d02908:	2902      	cmp	r1, #2
c0d0290a:	d115      	bne.n	c0d02938 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d0290c:	2e00      	cmp	r6, #0
c0d0290e:	d026      	beq.n	c0d0295e <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02910:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02912:	2103      	movs	r1, #3
c0d02914:	7001      	strb	r1, [r0, #0]
c0d02916:	e009      	b.n	c0d0292c <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02918:	2e00      	cmp	r6, #0
c0d0291a:	d016      	beq.n	c0d0294a <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d0291c:	6860      	ldr	r0, [r4, #4]
c0d0291e:	4286      	cmp	r6, r0
c0d02920:	d01d      	beq.n	c0d0295e <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02922:	b2c1      	uxtb	r1, r0
c0d02924:	4620      	mov	r0, r4
c0d02926:	f7ff fdd3 	bl	c0d024d0 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d0292a:	6066      	str	r6, [r4, #4]
c0d0292c:	4620      	mov	r0, r4
c0d0292e:	4631      	mov	r1, r6
c0d02930:	f7ff fdb6 	bl	c0d024a0 <USBD_SetClassConfig>
c0d02934:	2802      	cmp	r0, #2
c0d02936:	d112      	bne.n	c0d0295e <USBD_SetConfig+0x72>
c0d02938:	4620      	mov	r0, r4
c0d0293a:	4629      	mov	r1, r5
c0d0293c:	f7ff fcca 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02940:	2100      	movs	r1, #0
c0d02942:	4620      	mov	r0, r4
c0d02944:	f7ff fcc6 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02948:	e00c      	b.n	c0d02964 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d0294a:	2102      	movs	r1, #2
c0d0294c:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d0294e:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02950:	4620      	mov	r0, r4
c0d02952:	4631      	mov	r1, r6
c0d02954:	f7ff fdbc 	bl	c0d024d0 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02958:	4620      	mov	r0, r4
c0d0295a:	f000 faa5 	bl	c0d02ea8 <USBD_CtlSendStatus>
c0d0295e:	4620      	mov	r0, r4
c0d02960:	f000 faa2 	bl	c0d02ea8 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02964:	b001      	add	sp, #4
c0d02966:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02968 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02968:	b5d0      	push	{r4, r6, r7, lr}
c0d0296a:	af02      	add	r7, sp, #8
c0d0296c:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d0296e:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02970:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02972:	2801      	cmp	r0, #1
c0d02974:	d10a      	bne.n	c0d0298c <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02976:	20fc      	movs	r0, #252	; 0xfc
c0d02978:	5c20      	ldrb	r0, [r4, r0]
c0d0297a:	2803      	cmp	r0, #3
c0d0297c:	d00e      	beq.n	c0d0299c <USBD_GetConfig+0x34>
c0d0297e:	2802      	cmp	r0, #2
c0d02980:	d104      	bne.n	c0d0298c <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02982:	2000      	movs	r0, #0
c0d02984:	60a0      	str	r0, [r4, #8]
c0d02986:	4621      	mov	r1, r4
c0d02988:	3108      	adds	r1, #8
c0d0298a:	e008      	b.n	c0d0299e <USBD_GetConfig+0x36>
c0d0298c:	4620      	mov	r0, r4
c0d0298e:	f7ff fca1 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02992:	2100      	movs	r1, #0
c0d02994:	4620      	mov	r0, r4
c0d02996:	f7ff fc9d 	bl	c0d022d4 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0299a:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d0299c:	1d21      	adds	r1, r4, #4
c0d0299e:	2201      	movs	r2, #1
c0d029a0:	4620      	mov	r0, r4
c0d029a2:	f000 fa53 	bl	c0d02e4c <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d029a6:	bdd0      	pop	{r4, r6, r7, pc}

c0d029a8 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d029a8:	b5b0      	push	{r4, r5, r7, lr}
c0d029aa:	af02      	add	r7, sp, #8
c0d029ac:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d029ae:	20fc      	movs	r0, #252	; 0xfc
c0d029b0:	5c20      	ldrb	r0, [r4, r0]
c0d029b2:	21fe      	movs	r1, #254	; 0xfe
c0d029b4:	4001      	ands	r1, r0
c0d029b6:	2902      	cmp	r1, #2
c0d029b8:	d116      	bne.n	c0d029e8 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d029ba:	2001      	movs	r0, #1
c0d029bc:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d029be:	2041      	movs	r0, #65	; 0x41
c0d029c0:	0080      	lsls	r0, r0, #2
c0d029c2:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d029c4:	4625      	mov	r5, r4
c0d029c6:	350c      	adds	r5, #12
c0d029c8:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d029ca:	2900      	cmp	r1, #0
c0d029cc:	d005      	beq.n	c0d029da <USBD_GetStatus+0x32>
c0d029ce:	4620      	mov	r0, r4
c0d029d0:	f000 fa77 	bl	c0d02ec2 <USBD_CtlReceiveStatus>
c0d029d4:	68e1      	ldr	r1, [r4, #12]
c0d029d6:	2002      	movs	r0, #2
c0d029d8:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d029da:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d029dc:	2202      	movs	r2, #2
c0d029de:	4620      	mov	r0, r4
c0d029e0:	4629      	mov	r1, r5
c0d029e2:	f000 fa33 	bl	c0d02e4c <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d029e6:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029e8:	2180      	movs	r1, #128	; 0x80
c0d029ea:	4620      	mov	r0, r4
c0d029ec:	f7ff fc72 	bl	c0d022d4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d029f0:	2100      	movs	r1, #0
c0d029f2:	4620      	mov	r0, r4
c0d029f4:	f7ff fc6e 	bl	c0d022d4 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d029f8:	bdb0      	pop	{r4, r5, r7, pc}

c0d029fa <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d029fa:	b5b0      	push	{r4, r5, r7, lr}
c0d029fc:	af02      	add	r7, sp, #8
c0d029fe:	460d      	mov	r5, r1
c0d02a00:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02a02:	8868      	ldrh	r0, [r5, #2]
c0d02a04:	2801      	cmp	r0, #1
c0d02a06:	d110      	bne.n	c0d02a2a <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02a08:	2041      	movs	r0, #65	; 0x41
c0d02a0a:	0080      	lsls	r0, r0, #2
c0d02a0c:	2101      	movs	r1, #1
c0d02a0e:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02a10:	2045      	movs	r0, #69	; 0x45
c0d02a12:	0080      	lsls	r0, r0, #2
c0d02a14:	5820      	ldr	r0, [r4, r0]
c0d02a16:	6880      	ldr	r0, [r0, #8]
c0d02a18:	f7ff f846 	bl	c0d01aa8 <pic>
c0d02a1c:	4602      	mov	r2, r0
c0d02a1e:	4620      	mov	r0, r4
c0d02a20:	4629      	mov	r1, r5
c0d02a22:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02a24:	4620      	mov	r0, r4
c0d02a26:	f000 fa3f 	bl	c0d02ea8 <USBD_CtlSendStatus>
  }

}
c0d02a2a:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a2c <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02a2c:	b5b0      	push	{r4, r5, r7, lr}
c0d02a2e:	af02      	add	r7, sp, #8
c0d02a30:	460d      	mov	r5, r1
c0d02a32:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02a34:	20fc      	movs	r0, #252	; 0xfc
c0d02a36:	5c20      	ldrb	r0, [r4, r0]
c0d02a38:	21fe      	movs	r1, #254	; 0xfe
c0d02a3a:	4001      	ands	r1, r0
c0d02a3c:	2902      	cmp	r1, #2
c0d02a3e:	d114      	bne.n	c0d02a6a <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02a40:	8868      	ldrh	r0, [r5, #2]
c0d02a42:	2801      	cmp	r0, #1
c0d02a44:	d119      	bne.n	c0d02a7a <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02a46:	2041      	movs	r0, #65	; 0x41
c0d02a48:	0080      	lsls	r0, r0, #2
c0d02a4a:	2100      	movs	r1, #0
c0d02a4c:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02a4e:	2045      	movs	r0, #69	; 0x45
c0d02a50:	0080      	lsls	r0, r0, #2
c0d02a52:	5820      	ldr	r0, [r4, r0]
c0d02a54:	6880      	ldr	r0, [r0, #8]
c0d02a56:	f7ff f827 	bl	c0d01aa8 <pic>
c0d02a5a:	4602      	mov	r2, r0
c0d02a5c:	4620      	mov	r0, r4
c0d02a5e:	4629      	mov	r1, r5
c0d02a60:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02a62:	4620      	mov	r0, r4
c0d02a64:	f000 fa20 	bl	c0d02ea8 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02a68:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a6a:	2180      	movs	r1, #128	; 0x80
c0d02a6c:	4620      	mov	r0, r4
c0d02a6e:	f7ff fc31 	bl	c0d022d4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02a72:	2100      	movs	r1, #0
c0d02a74:	4620      	mov	r0, r4
c0d02a76:	f7ff fc2d 	bl	c0d022d4 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02a7a:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a7c <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02a7c:	b5d0      	push	{r4, r6, r7, lr}
c0d02a7e:	af02      	add	r7, sp, #8
c0d02a80:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a82:	2180      	movs	r1, #128	; 0x80
c0d02a84:	f7ff fc26 	bl	c0d022d4 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02a88:	2100      	movs	r1, #0
c0d02a8a:	4620      	mov	r0, r4
c0d02a8c:	f7ff fc22 	bl	c0d022d4 <USBD_LL_StallEP>
}
c0d02a90:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a92 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02a92:	b5b0      	push	{r4, r5, r7, lr}
c0d02a94:	af02      	add	r7, sp, #8
c0d02a96:	460d      	mov	r5, r1
c0d02a98:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02a9a:	20fc      	movs	r0, #252	; 0xfc
c0d02a9c:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a9e:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02aa0:	2803      	cmp	r0, #3
c0d02aa2:	d115      	bne.n	c0d02ad0 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02aa4:	88a8      	ldrh	r0, [r5, #4]
c0d02aa6:	22fe      	movs	r2, #254	; 0xfe
c0d02aa8:	4002      	ands	r2, r0
c0d02aaa:	2a01      	cmp	r2, #1
c0d02aac:	d810      	bhi.n	c0d02ad0 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02aae:	2045      	movs	r0, #69	; 0x45
c0d02ab0:	0080      	lsls	r0, r0, #2
c0d02ab2:	5820      	ldr	r0, [r4, r0]
c0d02ab4:	6880      	ldr	r0, [r0, #8]
c0d02ab6:	f7fe fff7 	bl	c0d01aa8 <pic>
c0d02aba:	4602      	mov	r2, r0
c0d02abc:	4620      	mov	r0, r4
c0d02abe:	4629      	mov	r1, r5
c0d02ac0:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02ac2:	88e8      	ldrh	r0, [r5, #6]
c0d02ac4:	2800      	cmp	r0, #0
c0d02ac6:	d10a      	bne.n	c0d02ade <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02ac8:	4620      	mov	r0, r4
c0d02aca:	f000 f9ed 	bl	c0d02ea8 <USBD_CtlSendStatus>
c0d02ace:	e006      	b.n	c0d02ade <USBD_StdItfReq+0x4c>
c0d02ad0:	4620      	mov	r0, r4
c0d02ad2:	f7ff fbff 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02ad6:	2100      	movs	r1, #0
c0d02ad8:	4620      	mov	r0, r4
c0d02ada:	f7ff fbfb 	bl	c0d022d4 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02ade:	2000      	movs	r0, #0
c0d02ae0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ae2 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02ae2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ae4:	af03      	add	r7, sp, #12
c0d02ae6:	b081      	sub	sp, #4
c0d02ae8:	460e      	mov	r6, r1
c0d02aea:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02aec:	7830      	ldrb	r0, [r6, #0]
c0d02aee:	2160      	movs	r1, #96	; 0x60
c0d02af0:	4001      	ands	r1, r0
c0d02af2:	2920      	cmp	r1, #32
c0d02af4:	d10a      	bne.n	c0d02b0c <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02af6:	2045      	movs	r0, #69	; 0x45
c0d02af8:	0080      	lsls	r0, r0, #2
c0d02afa:	5820      	ldr	r0, [r4, r0]
c0d02afc:	6880      	ldr	r0, [r0, #8]
c0d02afe:	f7fe ffd3 	bl	c0d01aa8 <pic>
c0d02b02:	4602      	mov	r2, r0
c0d02b04:	4620      	mov	r0, r4
c0d02b06:	4631      	mov	r1, r6
c0d02b08:	4790      	blx	r2
c0d02b0a:	e063      	b.n	c0d02bd4 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02b0c:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02b0e:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b10:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02b12:	2800      	cmp	r0, #0
c0d02b14:	d012      	beq.n	c0d02b3c <USBD_StdEPReq+0x5a>
c0d02b16:	2801      	cmp	r0, #1
c0d02b18:	d019      	beq.n	c0d02b4e <USBD_StdEPReq+0x6c>
c0d02b1a:	2803      	cmp	r0, #3
c0d02b1c:	d15a      	bne.n	c0d02bd4 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02b1e:	20fc      	movs	r0, #252	; 0xfc
c0d02b20:	5c20      	ldrb	r0, [r4, r0]
c0d02b22:	2803      	cmp	r0, #3
c0d02b24:	d117      	bne.n	c0d02b56 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02b26:	8870      	ldrh	r0, [r6, #2]
c0d02b28:	2800      	cmp	r0, #0
c0d02b2a:	d12d      	bne.n	c0d02b88 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02b2c:	4329      	orrs	r1, r5
c0d02b2e:	2980      	cmp	r1, #128	; 0x80
c0d02b30:	d02a      	beq.n	c0d02b88 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02b32:	4620      	mov	r0, r4
c0d02b34:	4629      	mov	r1, r5
c0d02b36:	f7ff fbcd 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02b3a:	e025      	b.n	c0d02b88 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02b3c:	20fc      	movs	r0, #252	; 0xfc
c0d02b3e:	5c20      	ldrb	r0, [r4, r0]
c0d02b40:	2803      	cmp	r0, #3
c0d02b42:	d02f      	beq.n	c0d02ba4 <USBD_StdEPReq+0xc2>
c0d02b44:	2802      	cmp	r0, #2
c0d02b46:	d10e      	bne.n	c0d02b66 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02b48:	0668      	lsls	r0, r5, #25
c0d02b4a:	d109      	bne.n	c0d02b60 <USBD_StdEPReq+0x7e>
c0d02b4c:	e042      	b.n	c0d02bd4 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02b4e:	20fc      	movs	r0, #252	; 0xfc
c0d02b50:	5c20      	ldrb	r0, [r4, r0]
c0d02b52:	2803      	cmp	r0, #3
c0d02b54:	d00f      	beq.n	c0d02b76 <USBD_StdEPReq+0x94>
c0d02b56:	2802      	cmp	r0, #2
c0d02b58:	d105      	bne.n	c0d02b66 <USBD_StdEPReq+0x84>
c0d02b5a:	4329      	orrs	r1, r5
c0d02b5c:	2980      	cmp	r1, #128	; 0x80
c0d02b5e:	d039      	beq.n	c0d02bd4 <USBD_StdEPReq+0xf2>
c0d02b60:	4620      	mov	r0, r4
c0d02b62:	4629      	mov	r1, r5
c0d02b64:	e004      	b.n	c0d02b70 <USBD_StdEPReq+0x8e>
c0d02b66:	4620      	mov	r0, r4
c0d02b68:	f7ff fbb4 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02b6c:	2100      	movs	r1, #0
c0d02b6e:	4620      	mov	r0, r4
c0d02b70:	f7ff fbb0 	bl	c0d022d4 <USBD_LL_StallEP>
c0d02b74:	e02e      	b.n	c0d02bd4 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02b76:	8870      	ldrh	r0, [r6, #2]
c0d02b78:	2800      	cmp	r0, #0
c0d02b7a:	d12b      	bne.n	c0d02bd4 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02b7c:	0668      	lsls	r0, r5, #25
c0d02b7e:	d00d      	beq.n	c0d02b9c <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02b80:	4620      	mov	r0, r4
c0d02b82:	4629      	mov	r1, r5
c0d02b84:	f7ff fbcc 	bl	c0d02320 <USBD_LL_ClearStallEP>
c0d02b88:	2045      	movs	r0, #69	; 0x45
c0d02b8a:	0080      	lsls	r0, r0, #2
c0d02b8c:	5820      	ldr	r0, [r4, r0]
c0d02b8e:	6880      	ldr	r0, [r0, #8]
c0d02b90:	f7fe ff8a 	bl	c0d01aa8 <pic>
c0d02b94:	4602      	mov	r2, r0
c0d02b96:	4620      	mov	r0, r4
c0d02b98:	4631      	mov	r1, r6
c0d02b9a:	4790      	blx	r2
c0d02b9c:	4620      	mov	r0, r4
c0d02b9e:	f000 f983 	bl	c0d02ea8 <USBD_CtlSendStatus>
c0d02ba2:	e017      	b.n	c0d02bd4 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02ba4:	4626      	mov	r6, r4
c0d02ba6:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02ba8:	4620      	mov	r0, r4
c0d02baa:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02bac:	420d      	tst	r5, r1
c0d02bae:	d100      	bne.n	c0d02bb2 <USBD_StdEPReq+0xd0>
c0d02bb0:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02bb2:	4620      	mov	r0, r4
c0d02bb4:	4629      	mov	r1, r5
c0d02bb6:	f7ff fbd9 	bl	c0d0236c <USBD_LL_IsStallEP>
c0d02bba:	2101      	movs	r1, #1
c0d02bbc:	2800      	cmp	r0, #0
c0d02bbe:	d100      	bne.n	c0d02bc2 <USBD_StdEPReq+0xe0>
c0d02bc0:	4601      	mov	r1, r0
c0d02bc2:	207f      	movs	r0, #127	; 0x7f
c0d02bc4:	4005      	ands	r5, r0
c0d02bc6:	0128      	lsls	r0, r5, #4
c0d02bc8:	5031      	str	r1, [r6, r0]
c0d02bca:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02bcc:	2202      	movs	r2, #2
c0d02bce:	4620      	mov	r0, r4
c0d02bd0:	f000 f93c 	bl	c0d02e4c <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02bd4:	2000      	movs	r0, #0
c0d02bd6:	b001      	add	sp, #4
c0d02bd8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02bda <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02bda:	780a      	ldrb	r2, [r1, #0]
c0d02bdc:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02bde:	784a      	ldrb	r2, [r1, #1]
c0d02be0:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02be2:	788a      	ldrb	r2, [r1, #2]
c0d02be4:	78cb      	ldrb	r3, [r1, #3]
c0d02be6:	021b      	lsls	r3, r3, #8
c0d02be8:	4313      	orrs	r3, r2
c0d02bea:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02bec:	790a      	ldrb	r2, [r1, #4]
c0d02bee:	794b      	ldrb	r3, [r1, #5]
c0d02bf0:	021b      	lsls	r3, r3, #8
c0d02bf2:	4313      	orrs	r3, r2
c0d02bf4:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02bf6:	798a      	ldrb	r2, [r1, #6]
c0d02bf8:	79c9      	ldrb	r1, [r1, #7]
c0d02bfa:	0209      	lsls	r1, r1, #8
c0d02bfc:	4311      	orrs	r1, r2
c0d02bfe:	80c1      	strh	r1, [r0, #6]

}
c0d02c00:	4770      	bx	lr

c0d02c02 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02c02:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c04:	af03      	add	r7, sp, #12
c0d02c06:	b083      	sub	sp, #12
c0d02c08:	460d      	mov	r5, r1
c0d02c0a:	4604      	mov	r4, r0
c0d02c0c:	a802      	add	r0, sp, #8
c0d02c0e:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02c10:	8006      	strh	r6, [r0, #0]
c0d02c12:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02c14:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02c16:	7829      	ldrb	r1, [r5, #0]
c0d02c18:	2060      	movs	r0, #96	; 0x60
c0d02c1a:	4008      	ands	r0, r1
c0d02c1c:	2800      	cmp	r0, #0
c0d02c1e:	d010      	beq.n	c0d02c42 <USBD_HID_Setup+0x40>
c0d02c20:	2820      	cmp	r0, #32
c0d02c22:	d139      	bne.n	c0d02c98 <USBD_HID_Setup+0x96>
c0d02c24:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02c26:	4601      	mov	r1, r0
c0d02c28:	390a      	subs	r1, #10
c0d02c2a:	2902      	cmp	r1, #2
c0d02c2c:	d334      	bcc.n	c0d02c98 <USBD_HID_Setup+0x96>
c0d02c2e:	2802      	cmp	r0, #2
c0d02c30:	d01c      	beq.n	c0d02c6c <USBD_HID_Setup+0x6a>
c0d02c32:	2803      	cmp	r0, #3
c0d02c34:	d01a      	beq.n	c0d02c6c <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02c36:	4620      	mov	r0, r4
c0d02c38:	4629      	mov	r1, r5
c0d02c3a:	f7ff ff1f 	bl	c0d02a7c <USBD_CtlError>
c0d02c3e:	2602      	movs	r6, #2
c0d02c40:	e02a      	b.n	c0d02c98 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02c42:	7868      	ldrb	r0, [r5, #1]
c0d02c44:	280b      	cmp	r0, #11
c0d02c46:	d014      	beq.n	c0d02c72 <USBD_HID_Setup+0x70>
c0d02c48:	280a      	cmp	r0, #10
c0d02c4a:	d00f      	beq.n	c0d02c6c <USBD_HID_Setup+0x6a>
c0d02c4c:	2806      	cmp	r0, #6
c0d02c4e:	d123      	bne.n	c0d02c98 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02c50:	8868      	ldrh	r0, [r5, #2]
c0d02c52:	0a00      	lsrs	r0, r0, #8
c0d02c54:	2600      	movs	r6, #0
c0d02c56:	2821      	cmp	r0, #33	; 0x21
c0d02c58:	d00f      	beq.n	c0d02c7a <USBD_HID_Setup+0x78>
c0d02c5a:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02c5c:	4632      	mov	r2, r6
c0d02c5e:	4631      	mov	r1, r6
c0d02c60:	d117      	bne.n	c0d02c92 <USBD_HID_Setup+0x90>
c0d02c62:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02c64:	9000      	str	r0, [sp, #0]
c0d02c66:	f000 f847 	bl	c0d02cf8 <USBD_HID_GetReportDescriptor_impl>
c0d02c6a:	e00a      	b.n	c0d02c82 <USBD_HID_Setup+0x80>
c0d02c6c:	a901      	add	r1, sp, #4
c0d02c6e:	2201      	movs	r2, #1
c0d02c70:	e00f      	b.n	c0d02c92 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02c72:	4620      	mov	r0, r4
c0d02c74:	f000 f918 	bl	c0d02ea8 <USBD_CtlSendStatus>
c0d02c78:	e00e      	b.n	c0d02c98 <USBD_HID_Setup+0x96>
c0d02c7a:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02c7c:	9000      	str	r0, [sp, #0]
c0d02c7e:	f000 f833 	bl	c0d02ce8 <USBD_HID_GetHidDescriptor_impl>
c0d02c82:	9b00      	ldr	r3, [sp, #0]
c0d02c84:	4601      	mov	r1, r0
c0d02c86:	881a      	ldrh	r2, [r3, #0]
c0d02c88:	88e8      	ldrh	r0, [r5, #6]
c0d02c8a:	4282      	cmp	r2, r0
c0d02c8c:	d300      	bcc.n	c0d02c90 <USBD_HID_Setup+0x8e>
c0d02c8e:	4602      	mov	r2, r0
c0d02c90:	801a      	strh	r2, [r3, #0]
c0d02c92:	4620      	mov	r0, r4
c0d02c94:	f000 f8da 	bl	c0d02e4c <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02c98:	b2f0      	uxtb	r0, r6
c0d02c9a:	b003      	add	sp, #12
c0d02c9c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c9e <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02c9e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ca0:	af03      	add	r7, sp, #12
c0d02ca2:	b081      	sub	sp, #4
c0d02ca4:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02ca6:	2182      	movs	r1, #130	; 0x82
c0d02ca8:	2502      	movs	r5, #2
c0d02caa:	2640      	movs	r6, #64	; 0x40
c0d02cac:	462a      	mov	r2, r5
c0d02cae:	4633      	mov	r3, r6
c0d02cb0:	f7ff fad0 	bl	c0d02254 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02cb4:	4620      	mov	r0, r4
c0d02cb6:	4629      	mov	r1, r5
c0d02cb8:	462a      	mov	r2, r5
c0d02cba:	4633      	mov	r3, r6
c0d02cbc:	f7ff faca 	bl	c0d02254 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02cc0:	4620      	mov	r0, r4
c0d02cc2:	4629      	mov	r1, r5
c0d02cc4:	4632      	mov	r2, r6
c0d02cc6:	f7ff fb90 	bl	c0d023ea <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02cca:	2000      	movs	r0, #0
c0d02ccc:	b001      	add	sp, #4
c0d02cce:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02cd0 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02cd0:	b5d0      	push	{r4, r6, r7, lr}
c0d02cd2:	af02      	add	r7, sp, #8
c0d02cd4:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02cd6:	2182      	movs	r1, #130	; 0x82
c0d02cd8:	f7ff fae4 	bl	c0d022a4 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02cdc:	2102      	movs	r1, #2
c0d02cde:	4620      	mov	r0, r4
c0d02ce0:	f7ff fae0 	bl	c0d022a4 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02ce4:	2000      	movs	r0, #0
c0d02ce6:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ce8 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02ce8:	2109      	movs	r1, #9
c0d02cea:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02cec:	4801      	ldr	r0, [pc, #4]	; (c0d02cf4 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02cee:	4478      	add	r0, pc
c0d02cf0:	4770      	bx	lr
c0d02cf2:	46c0      	nop			; (mov r8, r8)
c0d02cf4:	00000ab2 	.word	0x00000ab2

c0d02cf8 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02cf8:	2122      	movs	r1, #34	; 0x22
c0d02cfa:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02cfc:	4801      	ldr	r0, [pc, #4]	; (c0d02d04 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02cfe:	4478      	add	r0, pc
c0d02d00:	4770      	bx	lr
c0d02d02:	46c0      	nop			; (mov r8, r8)
c0d02d04:	00000a7d 	.word	0x00000a7d

c0d02d08 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02d08:	b5b0      	push	{r4, r5, r7, lr}
c0d02d0a:	af02      	add	r7, sp, #8
c0d02d0c:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02d0e:	2102      	movs	r1, #2
c0d02d10:	2240      	movs	r2, #64	; 0x40
c0d02d12:	f7ff fb6a 	bl	c0d023ea <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02d16:	4d0d      	ldr	r5, [pc, #52]	; (c0d02d4c <USBD_HID_DataOut_impl+0x44>)
c0d02d18:	7828      	ldrb	r0, [r5, #0]
c0d02d1a:	2800      	cmp	r0, #0
c0d02d1c:	d113      	bne.n	c0d02d46 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02d1e:	2002      	movs	r0, #2
c0d02d20:	f7fe f928 	bl	c0d00f74 <io_seproxyhal_get_ep_rx_size>
c0d02d24:	4602      	mov	r2, r0
c0d02d26:	480d      	ldr	r0, [pc, #52]	; (c0d02d5c <USBD_HID_DataOut_impl+0x54>)
c0d02d28:	4478      	add	r0, pc
c0d02d2a:	4621      	mov	r1, r4
c0d02d2c:	f7fd ff86 	bl	c0d00c3c <io_usb_hid_receive>
c0d02d30:	2802      	cmp	r0, #2
c0d02d32:	d108      	bne.n	c0d02d46 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02d34:	2001      	movs	r0, #1
c0d02d36:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02d38:	4805      	ldr	r0, [pc, #20]	; (c0d02d50 <USBD_HID_DataOut_impl+0x48>)
c0d02d3a:	2107      	movs	r1, #7
c0d02d3c:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02d3e:	4805      	ldr	r0, [pc, #20]	; (c0d02d54 <USBD_HID_DataOut_impl+0x4c>)
c0d02d40:	6800      	ldr	r0, [r0, #0]
c0d02d42:	4905      	ldr	r1, [pc, #20]	; (c0d02d58 <USBD_HID_DataOut_impl+0x50>)
c0d02d44:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02d46:	2000      	movs	r0, #0
c0d02d48:	bdb0      	pop	{r4, r5, r7, pc}
c0d02d4a:	46c0      	nop			; (mov r8, r8)
c0d02d4c:	20001d10 	.word	0x20001d10
c0d02d50:	20001d18 	.word	0x20001d18
c0d02d54:	20001c00 	.word	0x20001c00
c0d02d58:	20001d1c 	.word	0x20001d1c
c0d02d5c:	ffffe3a1 	.word	0xffffe3a1

c0d02d60 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02d60:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d62:	af03      	add	r7, sp, #12
c0d02d64:	b081      	sub	sp, #4
c0d02d66:	4604      	mov	r4, r0
c0d02d68:	2049      	movs	r0, #73	; 0x49
c0d02d6a:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02d6c:	4810      	ldr	r0, [pc, #64]	; (c0d02db0 <USB_power+0x50>)
c0d02d6e:	2100      	movs	r1, #0
c0d02d70:	462a      	mov	r2, r5
c0d02d72:	f7fe f80f 	bl	c0d00d94 <os_memset>

  if (enabled) {
c0d02d76:	2c00      	cmp	r4, #0
c0d02d78:	d015      	beq.n	c0d02da6 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02d7a:	4c0d      	ldr	r4, [pc, #52]	; (c0d02db0 <USB_power+0x50>)
c0d02d7c:	2600      	movs	r6, #0
c0d02d7e:	4620      	mov	r0, r4
c0d02d80:	4631      	mov	r1, r6
c0d02d82:	462a      	mov	r2, r5
c0d02d84:	f7fe f806 	bl	c0d00d94 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02d88:	490a      	ldr	r1, [pc, #40]	; (c0d02db4 <USB_power+0x54>)
c0d02d8a:	4479      	add	r1, pc
c0d02d8c:	4620      	mov	r0, r4
c0d02d8e:	4632      	mov	r2, r6
c0d02d90:	f7ff fb3f 	bl	c0d02412 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02d94:	4908      	ldr	r1, [pc, #32]	; (c0d02db8 <USB_power+0x58>)
c0d02d96:	4479      	add	r1, pc
c0d02d98:	4620      	mov	r0, r4
c0d02d9a:	f7ff fb72 	bl	c0d02482 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02d9e:	4620      	mov	r0, r4
c0d02da0:	f7ff fb78 	bl	c0d02494 <USBD_Start>
c0d02da4:	e002      	b.n	c0d02dac <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02da6:	4802      	ldr	r0, [pc, #8]	; (c0d02db0 <USB_power+0x50>)
c0d02da8:	f7ff fb51 	bl	c0d0244e <USBD_DeInit>
  }
}
c0d02dac:	b001      	add	sp, #4
c0d02dae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02db0:	20001d34 	.word	0x20001d34
c0d02db4:	00000a32 	.word	0x00000a32
c0d02db8:	00000a62 	.word	0x00000a62

c0d02dbc <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02dbc:	2012      	movs	r0, #18
c0d02dbe:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02dc0:	4801      	ldr	r0, [pc, #4]	; (c0d02dc8 <USBD_DeviceDescriptor+0xc>)
c0d02dc2:	4478      	add	r0, pc
c0d02dc4:	4770      	bx	lr
c0d02dc6:	46c0      	nop			; (mov r8, r8)
c0d02dc8:	000009e7 	.word	0x000009e7

c0d02dcc <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02dcc:	2004      	movs	r0, #4
c0d02dce:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02dd0:	4801      	ldr	r0, [pc, #4]	; (c0d02dd8 <USBD_LangIDStrDescriptor+0xc>)
c0d02dd2:	4478      	add	r0, pc
c0d02dd4:	4770      	bx	lr
c0d02dd6:	46c0      	nop			; (mov r8, r8)
c0d02dd8:	00000a0a 	.word	0x00000a0a

c0d02ddc <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02ddc:	200e      	movs	r0, #14
c0d02dde:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02de0:	4801      	ldr	r0, [pc, #4]	; (c0d02de8 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02de2:	4478      	add	r0, pc
c0d02de4:	4770      	bx	lr
c0d02de6:	46c0      	nop			; (mov r8, r8)
c0d02de8:	000009fe 	.word	0x000009fe

c0d02dec <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02dec:	200e      	movs	r0, #14
c0d02dee:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02df0:	4801      	ldr	r0, [pc, #4]	; (c0d02df8 <USBD_ProductStrDescriptor+0xc>)
c0d02df2:	4478      	add	r0, pc
c0d02df4:	4770      	bx	lr
c0d02df6:	46c0      	nop			; (mov r8, r8)
c0d02df8:	0000097b 	.word	0x0000097b

c0d02dfc <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02dfc:	200a      	movs	r0, #10
c0d02dfe:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02e00:	4801      	ldr	r0, [pc, #4]	; (c0d02e08 <USBD_SerialStrDescriptor+0xc>)
c0d02e02:	4478      	add	r0, pc
c0d02e04:	4770      	bx	lr
c0d02e06:	46c0      	nop			; (mov r8, r8)
c0d02e08:	000009ec 	.word	0x000009ec

c0d02e0c <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02e0c:	200e      	movs	r0, #14
c0d02e0e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02e10:	4801      	ldr	r0, [pc, #4]	; (c0d02e18 <USBD_ConfigStrDescriptor+0xc>)
c0d02e12:	4478      	add	r0, pc
c0d02e14:	4770      	bx	lr
c0d02e16:	46c0      	nop			; (mov r8, r8)
c0d02e18:	0000095b 	.word	0x0000095b

c0d02e1c <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02e1c:	200e      	movs	r0, #14
c0d02e1e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02e20:	4801      	ldr	r0, [pc, #4]	; (c0d02e28 <USBD_InterfaceStrDescriptor+0xc>)
c0d02e22:	4478      	add	r0, pc
c0d02e24:	4770      	bx	lr
c0d02e26:	46c0      	nop			; (mov r8, r8)
c0d02e28:	0000094b 	.word	0x0000094b

c0d02e2c <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02e2c:	2129      	movs	r1, #41	; 0x29
c0d02e2e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02e30:	4801      	ldr	r0, [pc, #4]	; (c0d02e38 <USBD_GetCfgDesc_impl+0xc>)
c0d02e32:	4478      	add	r0, pc
c0d02e34:	4770      	bx	lr
c0d02e36:	46c0      	nop			; (mov r8, r8)
c0d02e38:	000009fe 	.word	0x000009fe

c0d02e3c <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02e3c:	210a      	movs	r1, #10
c0d02e3e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02e40:	4801      	ldr	r0, [pc, #4]	; (c0d02e48 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02e42:	4478      	add	r0, pc
c0d02e44:	4770      	bx	lr
c0d02e46:	46c0      	nop			; (mov r8, r8)
c0d02e48:	00000a1a 	.word	0x00000a1a

c0d02e4c <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02e4c:	b5b0      	push	{r4, r5, r7, lr}
c0d02e4e:	af02      	add	r7, sp, #8
c0d02e50:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02e52:	21f4      	movs	r1, #244	; 0xf4
c0d02e54:	2302      	movs	r3, #2
c0d02e56:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02e58:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02e5a:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02e5c:	2109      	movs	r1, #9
c0d02e5e:	0149      	lsls	r1, r1, #5
c0d02e60:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02e62:	6a01      	ldr	r1, [r0, #32]
c0d02e64:	428a      	cmp	r2, r1
c0d02e66:	d300      	bcc.n	c0d02e6a <USBD_CtlSendData+0x1e>
c0d02e68:	460a      	mov	r2, r1
c0d02e6a:	b293      	uxth	r3, r2
c0d02e6c:	2500      	movs	r5, #0
c0d02e6e:	4629      	mov	r1, r5
c0d02e70:	4622      	mov	r2, r4
c0d02e72:	f7ff faa0 	bl	c0d023b6 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02e76:	4628      	mov	r0, r5
c0d02e78:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e7a <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02e7a:	b5b0      	push	{r4, r5, r7, lr}
c0d02e7c:	af02      	add	r7, sp, #8
c0d02e7e:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02e80:	6a01      	ldr	r1, [r0, #32]
c0d02e82:	428a      	cmp	r2, r1
c0d02e84:	d300      	bcc.n	c0d02e88 <USBD_CtlContinueSendData+0xe>
c0d02e86:	460a      	mov	r2, r1
c0d02e88:	b293      	uxth	r3, r2
c0d02e8a:	2500      	movs	r5, #0
c0d02e8c:	4629      	mov	r1, r5
c0d02e8e:	4622      	mov	r2, r4
c0d02e90:	f7ff fa91 	bl	c0d023b6 <USBD_LL_Transmit>
  return USBD_OK;
c0d02e94:	4628      	mov	r0, r5
c0d02e96:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e98 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02e98:	b5d0      	push	{r4, r6, r7, lr}
c0d02e9a:	af02      	add	r7, sp, #8
c0d02e9c:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02e9e:	4621      	mov	r1, r4
c0d02ea0:	f7ff faa3 	bl	c0d023ea <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02ea4:	4620      	mov	r0, r4
c0d02ea6:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ea8 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02ea8:	b5d0      	push	{r4, r6, r7, lr}
c0d02eaa:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02eac:	21f4      	movs	r1, #244	; 0xf4
c0d02eae:	2204      	movs	r2, #4
c0d02eb0:	5042      	str	r2, [r0, r1]
c0d02eb2:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02eb4:	4621      	mov	r1, r4
c0d02eb6:	4622      	mov	r2, r4
c0d02eb8:	4623      	mov	r3, r4
c0d02eba:	f7ff fa7c 	bl	c0d023b6 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02ebe:	4620      	mov	r0, r4
c0d02ec0:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ec2 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02ec2:	b5d0      	push	{r4, r6, r7, lr}
c0d02ec4:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02ec6:	21f4      	movs	r1, #244	; 0xf4
c0d02ec8:	2205      	movs	r2, #5
c0d02eca:	5042      	str	r2, [r0, r1]
c0d02ecc:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02ece:	4621      	mov	r1, r4
c0d02ed0:	4622      	mov	r2, r4
c0d02ed2:	f7ff fa8a 	bl	c0d023ea <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02ed6:	4620      	mov	r0, r4
c0d02ed8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02edc <__aeabi_uidiv>:
c0d02edc:	2200      	movs	r2, #0
c0d02ede:	0843      	lsrs	r3, r0, #1
c0d02ee0:	428b      	cmp	r3, r1
c0d02ee2:	d374      	bcc.n	c0d02fce <__aeabi_uidiv+0xf2>
c0d02ee4:	0903      	lsrs	r3, r0, #4
c0d02ee6:	428b      	cmp	r3, r1
c0d02ee8:	d35f      	bcc.n	c0d02faa <__aeabi_uidiv+0xce>
c0d02eea:	0a03      	lsrs	r3, r0, #8
c0d02eec:	428b      	cmp	r3, r1
c0d02eee:	d344      	bcc.n	c0d02f7a <__aeabi_uidiv+0x9e>
c0d02ef0:	0b03      	lsrs	r3, r0, #12
c0d02ef2:	428b      	cmp	r3, r1
c0d02ef4:	d328      	bcc.n	c0d02f48 <__aeabi_uidiv+0x6c>
c0d02ef6:	0c03      	lsrs	r3, r0, #16
c0d02ef8:	428b      	cmp	r3, r1
c0d02efa:	d30d      	bcc.n	c0d02f18 <__aeabi_uidiv+0x3c>
c0d02efc:	22ff      	movs	r2, #255	; 0xff
c0d02efe:	0209      	lsls	r1, r1, #8
c0d02f00:	ba12      	rev	r2, r2
c0d02f02:	0c03      	lsrs	r3, r0, #16
c0d02f04:	428b      	cmp	r3, r1
c0d02f06:	d302      	bcc.n	c0d02f0e <__aeabi_uidiv+0x32>
c0d02f08:	1212      	asrs	r2, r2, #8
c0d02f0a:	0209      	lsls	r1, r1, #8
c0d02f0c:	d065      	beq.n	c0d02fda <__aeabi_uidiv+0xfe>
c0d02f0e:	0b03      	lsrs	r3, r0, #12
c0d02f10:	428b      	cmp	r3, r1
c0d02f12:	d319      	bcc.n	c0d02f48 <__aeabi_uidiv+0x6c>
c0d02f14:	e000      	b.n	c0d02f18 <__aeabi_uidiv+0x3c>
c0d02f16:	0a09      	lsrs	r1, r1, #8
c0d02f18:	0bc3      	lsrs	r3, r0, #15
c0d02f1a:	428b      	cmp	r3, r1
c0d02f1c:	d301      	bcc.n	c0d02f22 <__aeabi_uidiv+0x46>
c0d02f1e:	03cb      	lsls	r3, r1, #15
c0d02f20:	1ac0      	subs	r0, r0, r3
c0d02f22:	4152      	adcs	r2, r2
c0d02f24:	0b83      	lsrs	r3, r0, #14
c0d02f26:	428b      	cmp	r3, r1
c0d02f28:	d301      	bcc.n	c0d02f2e <__aeabi_uidiv+0x52>
c0d02f2a:	038b      	lsls	r3, r1, #14
c0d02f2c:	1ac0      	subs	r0, r0, r3
c0d02f2e:	4152      	adcs	r2, r2
c0d02f30:	0b43      	lsrs	r3, r0, #13
c0d02f32:	428b      	cmp	r3, r1
c0d02f34:	d301      	bcc.n	c0d02f3a <__aeabi_uidiv+0x5e>
c0d02f36:	034b      	lsls	r3, r1, #13
c0d02f38:	1ac0      	subs	r0, r0, r3
c0d02f3a:	4152      	adcs	r2, r2
c0d02f3c:	0b03      	lsrs	r3, r0, #12
c0d02f3e:	428b      	cmp	r3, r1
c0d02f40:	d301      	bcc.n	c0d02f46 <__aeabi_uidiv+0x6a>
c0d02f42:	030b      	lsls	r3, r1, #12
c0d02f44:	1ac0      	subs	r0, r0, r3
c0d02f46:	4152      	adcs	r2, r2
c0d02f48:	0ac3      	lsrs	r3, r0, #11
c0d02f4a:	428b      	cmp	r3, r1
c0d02f4c:	d301      	bcc.n	c0d02f52 <__aeabi_uidiv+0x76>
c0d02f4e:	02cb      	lsls	r3, r1, #11
c0d02f50:	1ac0      	subs	r0, r0, r3
c0d02f52:	4152      	adcs	r2, r2
c0d02f54:	0a83      	lsrs	r3, r0, #10
c0d02f56:	428b      	cmp	r3, r1
c0d02f58:	d301      	bcc.n	c0d02f5e <__aeabi_uidiv+0x82>
c0d02f5a:	028b      	lsls	r3, r1, #10
c0d02f5c:	1ac0      	subs	r0, r0, r3
c0d02f5e:	4152      	adcs	r2, r2
c0d02f60:	0a43      	lsrs	r3, r0, #9
c0d02f62:	428b      	cmp	r3, r1
c0d02f64:	d301      	bcc.n	c0d02f6a <__aeabi_uidiv+0x8e>
c0d02f66:	024b      	lsls	r3, r1, #9
c0d02f68:	1ac0      	subs	r0, r0, r3
c0d02f6a:	4152      	adcs	r2, r2
c0d02f6c:	0a03      	lsrs	r3, r0, #8
c0d02f6e:	428b      	cmp	r3, r1
c0d02f70:	d301      	bcc.n	c0d02f76 <__aeabi_uidiv+0x9a>
c0d02f72:	020b      	lsls	r3, r1, #8
c0d02f74:	1ac0      	subs	r0, r0, r3
c0d02f76:	4152      	adcs	r2, r2
c0d02f78:	d2cd      	bcs.n	c0d02f16 <__aeabi_uidiv+0x3a>
c0d02f7a:	09c3      	lsrs	r3, r0, #7
c0d02f7c:	428b      	cmp	r3, r1
c0d02f7e:	d301      	bcc.n	c0d02f84 <__aeabi_uidiv+0xa8>
c0d02f80:	01cb      	lsls	r3, r1, #7
c0d02f82:	1ac0      	subs	r0, r0, r3
c0d02f84:	4152      	adcs	r2, r2
c0d02f86:	0983      	lsrs	r3, r0, #6
c0d02f88:	428b      	cmp	r3, r1
c0d02f8a:	d301      	bcc.n	c0d02f90 <__aeabi_uidiv+0xb4>
c0d02f8c:	018b      	lsls	r3, r1, #6
c0d02f8e:	1ac0      	subs	r0, r0, r3
c0d02f90:	4152      	adcs	r2, r2
c0d02f92:	0943      	lsrs	r3, r0, #5
c0d02f94:	428b      	cmp	r3, r1
c0d02f96:	d301      	bcc.n	c0d02f9c <__aeabi_uidiv+0xc0>
c0d02f98:	014b      	lsls	r3, r1, #5
c0d02f9a:	1ac0      	subs	r0, r0, r3
c0d02f9c:	4152      	adcs	r2, r2
c0d02f9e:	0903      	lsrs	r3, r0, #4
c0d02fa0:	428b      	cmp	r3, r1
c0d02fa2:	d301      	bcc.n	c0d02fa8 <__aeabi_uidiv+0xcc>
c0d02fa4:	010b      	lsls	r3, r1, #4
c0d02fa6:	1ac0      	subs	r0, r0, r3
c0d02fa8:	4152      	adcs	r2, r2
c0d02faa:	08c3      	lsrs	r3, r0, #3
c0d02fac:	428b      	cmp	r3, r1
c0d02fae:	d301      	bcc.n	c0d02fb4 <__aeabi_uidiv+0xd8>
c0d02fb0:	00cb      	lsls	r3, r1, #3
c0d02fb2:	1ac0      	subs	r0, r0, r3
c0d02fb4:	4152      	adcs	r2, r2
c0d02fb6:	0883      	lsrs	r3, r0, #2
c0d02fb8:	428b      	cmp	r3, r1
c0d02fba:	d301      	bcc.n	c0d02fc0 <__aeabi_uidiv+0xe4>
c0d02fbc:	008b      	lsls	r3, r1, #2
c0d02fbe:	1ac0      	subs	r0, r0, r3
c0d02fc0:	4152      	adcs	r2, r2
c0d02fc2:	0843      	lsrs	r3, r0, #1
c0d02fc4:	428b      	cmp	r3, r1
c0d02fc6:	d301      	bcc.n	c0d02fcc <__aeabi_uidiv+0xf0>
c0d02fc8:	004b      	lsls	r3, r1, #1
c0d02fca:	1ac0      	subs	r0, r0, r3
c0d02fcc:	4152      	adcs	r2, r2
c0d02fce:	1a41      	subs	r1, r0, r1
c0d02fd0:	d200      	bcs.n	c0d02fd4 <__aeabi_uidiv+0xf8>
c0d02fd2:	4601      	mov	r1, r0
c0d02fd4:	4152      	adcs	r2, r2
c0d02fd6:	4610      	mov	r0, r2
c0d02fd8:	4770      	bx	lr
c0d02fda:	e7ff      	b.n	c0d02fdc <__aeabi_uidiv+0x100>
c0d02fdc:	b501      	push	{r0, lr}
c0d02fde:	2000      	movs	r0, #0
c0d02fe0:	f000 f8f0 	bl	c0d031c4 <__aeabi_idiv0>
c0d02fe4:	bd02      	pop	{r1, pc}
c0d02fe6:	46c0      	nop			; (mov r8, r8)

c0d02fe8 <__aeabi_uidivmod>:
c0d02fe8:	2900      	cmp	r1, #0
c0d02fea:	d0f7      	beq.n	c0d02fdc <__aeabi_uidiv+0x100>
c0d02fec:	e776      	b.n	c0d02edc <__aeabi_uidiv>
c0d02fee:	4770      	bx	lr

c0d02ff0 <__aeabi_idiv>:
c0d02ff0:	4603      	mov	r3, r0
c0d02ff2:	430b      	orrs	r3, r1
c0d02ff4:	d47f      	bmi.n	c0d030f6 <__aeabi_idiv+0x106>
c0d02ff6:	2200      	movs	r2, #0
c0d02ff8:	0843      	lsrs	r3, r0, #1
c0d02ffa:	428b      	cmp	r3, r1
c0d02ffc:	d374      	bcc.n	c0d030e8 <__aeabi_idiv+0xf8>
c0d02ffe:	0903      	lsrs	r3, r0, #4
c0d03000:	428b      	cmp	r3, r1
c0d03002:	d35f      	bcc.n	c0d030c4 <__aeabi_idiv+0xd4>
c0d03004:	0a03      	lsrs	r3, r0, #8
c0d03006:	428b      	cmp	r3, r1
c0d03008:	d344      	bcc.n	c0d03094 <__aeabi_idiv+0xa4>
c0d0300a:	0b03      	lsrs	r3, r0, #12
c0d0300c:	428b      	cmp	r3, r1
c0d0300e:	d328      	bcc.n	c0d03062 <__aeabi_idiv+0x72>
c0d03010:	0c03      	lsrs	r3, r0, #16
c0d03012:	428b      	cmp	r3, r1
c0d03014:	d30d      	bcc.n	c0d03032 <__aeabi_idiv+0x42>
c0d03016:	22ff      	movs	r2, #255	; 0xff
c0d03018:	0209      	lsls	r1, r1, #8
c0d0301a:	ba12      	rev	r2, r2
c0d0301c:	0c03      	lsrs	r3, r0, #16
c0d0301e:	428b      	cmp	r3, r1
c0d03020:	d302      	bcc.n	c0d03028 <__aeabi_idiv+0x38>
c0d03022:	1212      	asrs	r2, r2, #8
c0d03024:	0209      	lsls	r1, r1, #8
c0d03026:	d065      	beq.n	c0d030f4 <__aeabi_idiv+0x104>
c0d03028:	0b03      	lsrs	r3, r0, #12
c0d0302a:	428b      	cmp	r3, r1
c0d0302c:	d319      	bcc.n	c0d03062 <__aeabi_idiv+0x72>
c0d0302e:	e000      	b.n	c0d03032 <__aeabi_idiv+0x42>
c0d03030:	0a09      	lsrs	r1, r1, #8
c0d03032:	0bc3      	lsrs	r3, r0, #15
c0d03034:	428b      	cmp	r3, r1
c0d03036:	d301      	bcc.n	c0d0303c <__aeabi_idiv+0x4c>
c0d03038:	03cb      	lsls	r3, r1, #15
c0d0303a:	1ac0      	subs	r0, r0, r3
c0d0303c:	4152      	adcs	r2, r2
c0d0303e:	0b83      	lsrs	r3, r0, #14
c0d03040:	428b      	cmp	r3, r1
c0d03042:	d301      	bcc.n	c0d03048 <__aeabi_idiv+0x58>
c0d03044:	038b      	lsls	r3, r1, #14
c0d03046:	1ac0      	subs	r0, r0, r3
c0d03048:	4152      	adcs	r2, r2
c0d0304a:	0b43      	lsrs	r3, r0, #13
c0d0304c:	428b      	cmp	r3, r1
c0d0304e:	d301      	bcc.n	c0d03054 <__aeabi_idiv+0x64>
c0d03050:	034b      	lsls	r3, r1, #13
c0d03052:	1ac0      	subs	r0, r0, r3
c0d03054:	4152      	adcs	r2, r2
c0d03056:	0b03      	lsrs	r3, r0, #12
c0d03058:	428b      	cmp	r3, r1
c0d0305a:	d301      	bcc.n	c0d03060 <__aeabi_idiv+0x70>
c0d0305c:	030b      	lsls	r3, r1, #12
c0d0305e:	1ac0      	subs	r0, r0, r3
c0d03060:	4152      	adcs	r2, r2
c0d03062:	0ac3      	lsrs	r3, r0, #11
c0d03064:	428b      	cmp	r3, r1
c0d03066:	d301      	bcc.n	c0d0306c <__aeabi_idiv+0x7c>
c0d03068:	02cb      	lsls	r3, r1, #11
c0d0306a:	1ac0      	subs	r0, r0, r3
c0d0306c:	4152      	adcs	r2, r2
c0d0306e:	0a83      	lsrs	r3, r0, #10
c0d03070:	428b      	cmp	r3, r1
c0d03072:	d301      	bcc.n	c0d03078 <__aeabi_idiv+0x88>
c0d03074:	028b      	lsls	r3, r1, #10
c0d03076:	1ac0      	subs	r0, r0, r3
c0d03078:	4152      	adcs	r2, r2
c0d0307a:	0a43      	lsrs	r3, r0, #9
c0d0307c:	428b      	cmp	r3, r1
c0d0307e:	d301      	bcc.n	c0d03084 <__aeabi_idiv+0x94>
c0d03080:	024b      	lsls	r3, r1, #9
c0d03082:	1ac0      	subs	r0, r0, r3
c0d03084:	4152      	adcs	r2, r2
c0d03086:	0a03      	lsrs	r3, r0, #8
c0d03088:	428b      	cmp	r3, r1
c0d0308a:	d301      	bcc.n	c0d03090 <__aeabi_idiv+0xa0>
c0d0308c:	020b      	lsls	r3, r1, #8
c0d0308e:	1ac0      	subs	r0, r0, r3
c0d03090:	4152      	adcs	r2, r2
c0d03092:	d2cd      	bcs.n	c0d03030 <__aeabi_idiv+0x40>
c0d03094:	09c3      	lsrs	r3, r0, #7
c0d03096:	428b      	cmp	r3, r1
c0d03098:	d301      	bcc.n	c0d0309e <__aeabi_idiv+0xae>
c0d0309a:	01cb      	lsls	r3, r1, #7
c0d0309c:	1ac0      	subs	r0, r0, r3
c0d0309e:	4152      	adcs	r2, r2
c0d030a0:	0983      	lsrs	r3, r0, #6
c0d030a2:	428b      	cmp	r3, r1
c0d030a4:	d301      	bcc.n	c0d030aa <__aeabi_idiv+0xba>
c0d030a6:	018b      	lsls	r3, r1, #6
c0d030a8:	1ac0      	subs	r0, r0, r3
c0d030aa:	4152      	adcs	r2, r2
c0d030ac:	0943      	lsrs	r3, r0, #5
c0d030ae:	428b      	cmp	r3, r1
c0d030b0:	d301      	bcc.n	c0d030b6 <__aeabi_idiv+0xc6>
c0d030b2:	014b      	lsls	r3, r1, #5
c0d030b4:	1ac0      	subs	r0, r0, r3
c0d030b6:	4152      	adcs	r2, r2
c0d030b8:	0903      	lsrs	r3, r0, #4
c0d030ba:	428b      	cmp	r3, r1
c0d030bc:	d301      	bcc.n	c0d030c2 <__aeabi_idiv+0xd2>
c0d030be:	010b      	lsls	r3, r1, #4
c0d030c0:	1ac0      	subs	r0, r0, r3
c0d030c2:	4152      	adcs	r2, r2
c0d030c4:	08c3      	lsrs	r3, r0, #3
c0d030c6:	428b      	cmp	r3, r1
c0d030c8:	d301      	bcc.n	c0d030ce <__aeabi_idiv+0xde>
c0d030ca:	00cb      	lsls	r3, r1, #3
c0d030cc:	1ac0      	subs	r0, r0, r3
c0d030ce:	4152      	adcs	r2, r2
c0d030d0:	0883      	lsrs	r3, r0, #2
c0d030d2:	428b      	cmp	r3, r1
c0d030d4:	d301      	bcc.n	c0d030da <__aeabi_idiv+0xea>
c0d030d6:	008b      	lsls	r3, r1, #2
c0d030d8:	1ac0      	subs	r0, r0, r3
c0d030da:	4152      	adcs	r2, r2
c0d030dc:	0843      	lsrs	r3, r0, #1
c0d030de:	428b      	cmp	r3, r1
c0d030e0:	d301      	bcc.n	c0d030e6 <__aeabi_idiv+0xf6>
c0d030e2:	004b      	lsls	r3, r1, #1
c0d030e4:	1ac0      	subs	r0, r0, r3
c0d030e6:	4152      	adcs	r2, r2
c0d030e8:	1a41      	subs	r1, r0, r1
c0d030ea:	d200      	bcs.n	c0d030ee <__aeabi_idiv+0xfe>
c0d030ec:	4601      	mov	r1, r0
c0d030ee:	4152      	adcs	r2, r2
c0d030f0:	4610      	mov	r0, r2
c0d030f2:	4770      	bx	lr
c0d030f4:	e05d      	b.n	c0d031b2 <__aeabi_idiv+0x1c2>
c0d030f6:	0fca      	lsrs	r2, r1, #31
c0d030f8:	d000      	beq.n	c0d030fc <__aeabi_idiv+0x10c>
c0d030fa:	4249      	negs	r1, r1
c0d030fc:	1003      	asrs	r3, r0, #32
c0d030fe:	d300      	bcc.n	c0d03102 <__aeabi_idiv+0x112>
c0d03100:	4240      	negs	r0, r0
c0d03102:	4053      	eors	r3, r2
c0d03104:	2200      	movs	r2, #0
c0d03106:	469c      	mov	ip, r3
c0d03108:	0903      	lsrs	r3, r0, #4
c0d0310a:	428b      	cmp	r3, r1
c0d0310c:	d32d      	bcc.n	c0d0316a <__aeabi_idiv+0x17a>
c0d0310e:	0a03      	lsrs	r3, r0, #8
c0d03110:	428b      	cmp	r3, r1
c0d03112:	d312      	bcc.n	c0d0313a <__aeabi_idiv+0x14a>
c0d03114:	22fc      	movs	r2, #252	; 0xfc
c0d03116:	0189      	lsls	r1, r1, #6
c0d03118:	ba12      	rev	r2, r2
c0d0311a:	0a03      	lsrs	r3, r0, #8
c0d0311c:	428b      	cmp	r3, r1
c0d0311e:	d30c      	bcc.n	c0d0313a <__aeabi_idiv+0x14a>
c0d03120:	0189      	lsls	r1, r1, #6
c0d03122:	1192      	asrs	r2, r2, #6
c0d03124:	428b      	cmp	r3, r1
c0d03126:	d308      	bcc.n	c0d0313a <__aeabi_idiv+0x14a>
c0d03128:	0189      	lsls	r1, r1, #6
c0d0312a:	1192      	asrs	r2, r2, #6
c0d0312c:	428b      	cmp	r3, r1
c0d0312e:	d304      	bcc.n	c0d0313a <__aeabi_idiv+0x14a>
c0d03130:	0189      	lsls	r1, r1, #6
c0d03132:	d03a      	beq.n	c0d031aa <__aeabi_idiv+0x1ba>
c0d03134:	1192      	asrs	r2, r2, #6
c0d03136:	e000      	b.n	c0d0313a <__aeabi_idiv+0x14a>
c0d03138:	0989      	lsrs	r1, r1, #6
c0d0313a:	09c3      	lsrs	r3, r0, #7
c0d0313c:	428b      	cmp	r3, r1
c0d0313e:	d301      	bcc.n	c0d03144 <__aeabi_idiv+0x154>
c0d03140:	01cb      	lsls	r3, r1, #7
c0d03142:	1ac0      	subs	r0, r0, r3
c0d03144:	4152      	adcs	r2, r2
c0d03146:	0983      	lsrs	r3, r0, #6
c0d03148:	428b      	cmp	r3, r1
c0d0314a:	d301      	bcc.n	c0d03150 <__aeabi_idiv+0x160>
c0d0314c:	018b      	lsls	r3, r1, #6
c0d0314e:	1ac0      	subs	r0, r0, r3
c0d03150:	4152      	adcs	r2, r2
c0d03152:	0943      	lsrs	r3, r0, #5
c0d03154:	428b      	cmp	r3, r1
c0d03156:	d301      	bcc.n	c0d0315c <__aeabi_idiv+0x16c>
c0d03158:	014b      	lsls	r3, r1, #5
c0d0315a:	1ac0      	subs	r0, r0, r3
c0d0315c:	4152      	adcs	r2, r2
c0d0315e:	0903      	lsrs	r3, r0, #4
c0d03160:	428b      	cmp	r3, r1
c0d03162:	d301      	bcc.n	c0d03168 <__aeabi_idiv+0x178>
c0d03164:	010b      	lsls	r3, r1, #4
c0d03166:	1ac0      	subs	r0, r0, r3
c0d03168:	4152      	adcs	r2, r2
c0d0316a:	08c3      	lsrs	r3, r0, #3
c0d0316c:	428b      	cmp	r3, r1
c0d0316e:	d301      	bcc.n	c0d03174 <__aeabi_idiv+0x184>
c0d03170:	00cb      	lsls	r3, r1, #3
c0d03172:	1ac0      	subs	r0, r0, r3
c0d03174:	4152      	adcs	r2, r2
c0d03176:	0883      	lsrs	r3, r0, #2
c0d03178:	428b      	cmp	r3, r1
c0d0317a:	d301      	bcc.n	c0d03180 <__aeabi_idiv+0x190>
c0d0317c:	008b      	lsls	r3, r1, #2
c0d0317e:	1ac0      	subs	r0, r0, r3
c0d03180:	4152      	adcs	r2, r2
c0d03182:	d2d9      	bcs.n	c0d03138 <__aeabi_idiv+0x148>
c0d03184:	0843      	lsrs	r3, r0, #1
c0d03186:	428b      	cmp	r3, r1
c0d03188:	d301      	bcc.n	c0d0318e <__aeabi_idiv+0x19e>
c0d0318a:	004b      	lsls	r3, r1, #1
c0d0318c:	1ac0      	subs	r0, r0, r3
c0d0318e:	4152      	adcs	r2, r2
c0d03190:	1a41      	subs	r1, r0, r1
c0d03192:	d200      	bcs.n	c0d03196 <__aeabi_idiv+0x1a6>
c0d03194:	4601      	mov	r1, r0
c0d03196:	4663      	mov	r3, ip
c0d03198:	4152      	adcs	r2, r2
c0d0319a:	105b      	asrs	r3, r3, #1
c0d0319c:	4610      	mov	r0, r2
c0d0319e:	d301      	bcc.n	c0d031a4 <__aeabi_idiv+0x1b4>
c0d031a0:	4240      	negs	r0, r0
c0d031a2:	2b00      	cmp	r3, #0
c0d031a4:	d500      	bpl.n	c0d031a8 <__aeabi_idiv+0x1b8>
c0d031a6:	4249      	negs	r1, r1
c0d031a8:	4770      	bx	lr
c0d031aa:	4663      	mov	r3, ip
c0d031ac:	105b      	asrs	r3, r3, #1
c0d031ae:	d300      	bcc.n	c0d031b2 <__aeabi_idiv+0x1c2>
c0d031b0:	4240      	negs	r0, r0
c0d031b2:	b501      	push	{r0, lr}
c0d031b4:	2000      	movs	r0, #0
c0d031b6:	f000 f805 	bl	c0d031c4 <__aeabi_idiv0>
c0d031ba:	bd02      	pop	{r1, pc}

c0d031bc <__aeabi_idivmod>:
c0d031bc:	2900      	cmp	r1, #0
c0d031be:	d0f8      	beq.n	c0d031b2 <__aeabi_idiv+0x1c2>
c0d031c0:	e716      	b.n	c0d02ff0 <__aeabi_idiv>
c0d031c2:	4770      	bx	lr

c0d031c4 <__aeabi_idiv0>:
c0d031c4:	4770      	bx	lr
c0d031c6:	46c0      	nop			; (mov r8, r8)

c0d031c8 <__aeabi_lmul>:
c0d031c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031ca:	464f      	mov	r7, r9
c0d031cc:	4646      	mov	r6, r8
c0d031ce:	b4c0      	push	{r6, r7}
c0d031d0:	0416      	lsls	r6, r2, #16
c0d031d2:	0c36      	lsrs	r6, r6, #16
c0d031d4:	4699      	mov	r9, r3
c0d031d6:	0033      	movs	r3, r6
c0d031d8:	0405      	lsls	r5, r0, #16
c0d031da:	0c2c      	lsrs	r4, r5, #16
c0d031dc:	0c07      	lsrs	r7, r0, #16
c0d031de:	0c15      	lsrs	r5, r2, #16
c0d031e0:	4363      	muls	r3, r4
c0d031e2:	437e      	muls	r6, r7
c0d031e4:	436f      	muls	r7, r5
c0d031e6:	4365      	muls	r5, r4
c0d031e8:	0c1c      	lsrs	r4, r3, #16
c0d031ea:	19ad      	adds	r5, r5, r6
c0d031ec:	1964      	adds	r4, r4, r5
c0d031ee:	469c      	mov	ip, r3
c0d031f0:	42a6      	cmp	r6, r4
c0d031f2:	d903      	bls.n	c0d031fc <__aeabi_lmul+0x34>
c0d031f4:	2380      	movs	r3, #128	; 0x80
c0d031f6:	025b      	lsls	r3, r3, #9
c0d031f8:	4698      	mov	r8, r3
c0d031fa:	4447      	add	r7, r8
c0d031fc:	4663      	mov	r3, ip
c0d031fe:	0c25      	lsrs	r5, r4, #16
c0d03200:	19ef      	adds	r7, r5, r7
c0d03202:	041d      	lsls	r5, r3, #16
c0d03204:	464b      	mov	r3, r9
c0d03206:	434a      	muls	r2, r1
c0d03208:	4343      	muls	r3, r0
c0d0320a:	0c2d      	lsrs	r5, r5, #16
c0d0320c:	0424      	lsls	r4, r4, #16
c0d0320e:	1964      	adds	r4, r4, r5
c0d03210:	1899      	adds	r1, r3, r2
c0d03212:	19c9      	adds	r1, r1, r7
c0d03214:	0020      	movs	r0, r4
c0d03216:	bc0c      	pop	{r2, r3}
c0d03218:	4690      	mov	r8, r2
c0d0321a:	4699      	mov	r9, r3
c0d0321c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0321e:	46c0      	nop			; (mov r8, r8)

c0d03220 <__aeabi_memclr>:
c0d03220:	b510      	push	{r4, lr}
c0d03222:	2200      	movs	r2, #0
c0d03224:	f000 f806 	bl	c0d03234 <__aeabi_memset>
c0d03228:	bd10      	pop	{r4, pc}
c0d0322a:	46c0      	nop			; (mov r8, r8)

c0d0322c <__aeabi_memcpy>:
c0d0322c:	b510      	push	{r4, lr}
c0d0322e:	f000 f809 	bl	c0d03244 <memcpy>
c0d03232:	bd10      	pop	{r4, pc}

c0d03234 <__aeabi_memset>:
c0d03234:	0013      	movs	r3, r2
c0d03236:	b510      	push	{r4, lr}
c0d03238:	000a      	movs	r2, r1
c0d0323a:	0019      	movs	r1, r3
c0d0323c:	f000 f840 	bl	c0d032c0 <memset>
c0d03240:	bd10      	pop	{r4, pc}
c0d03242:	46c0      	nop			; (mov r8, r8)

c0d03244 <memcpy>:
c0d03244:	b570      	push	{r4, r5, r6, lr}
c0d03246:	2a0f      	cmp	r2, #15
c0d03248:	d932      	bls.n	c0d032b0 <memcpy+0x6c>
c0d0324a:	000c      	movs	r4, r1
c0d0324c:	4304      	orrs	r4, r0
c0d0324e:	000b      	movs	r3, r1
c0d03250:	07a4      	lsls	r4, r4, #30
c0d03252:	d131      	bne.n	c0d032b8 <memcpy+0x74>
c0d03254:	0015      	movs	r5, r2
c0d03256:	0004      	movs	r4, r0
c0d03258:	3d10      	subs	r5, #16
c0d0325a:	092d      	lsrs	r5, r5, #4
c0d0325c:	3501      	adds	r5, #1
c0d0325e:	012d      	lsls	r5, r5, #4
c0d03260:	1949      	adds	r1, r1, r5
c0d03262:	681e      	ldr	r6, [r3, #0]
c0d03264:	6026      	str	r6, [r4, #0]
c0d03266:	685e      	ldr	r6, [r3, #4]
c0d03268:	6066      	str	r6, [r4, #4]
c0d0326a:	689e      	ldr	r6, [r3, #8]
c0d0326c:	60a6      	str	r6, [r4, #8]
c0d0326e:	68de      	ldr	r6, [r3, #12]
c0d03270:	3310      	adds	r3, #16
c0d03272:	60e6      	str	r6, [r4, #12]
c0d03274:	3410      	adds	r4, #16
c0d03276:	4299      	cmp	r1, r3
c0d03278:	d1f3      	bne.n	c0d03262 <memcpy+0x1e>
c0d0327a:	230f      	movs	r3, #15
c0d0327c:	1945      	adds	r5, r0, r5
c0d0327e:	4013      	ands	r3, r2
c0d03280:	2b03      	cmp	r3, #3
c0d03282:	d91b      	bls.n	c0d032bc <memcpy+0x78>
c0d03284:	1f1c      	subs	r4, r3, #4
c0d03286:	2300      	movs	r3, #0
c0d03288:	08a4      	lsrs	r4, r4, #2
c0d0328a:	3401      	adds	r4, #1
c0d0328c:	00a4      	lsls	r4, r4, #2
c0d0328e:	58ce      	ldr	r6, [r1, r3]
c0d03290:	50ee      	str	r6, [r5, r3]
c0d03292:	3304      	adds	r3, #4
c0d03294:	429c      	cmp	r4, r3
c0d03296:	d1fa      	bne.n	c0d0328e <memcpy+0x4a>
c0d03298:	2303      	movs	r3, #3
c0d0329a:	192d      	adds	r5, r5, r4
c0d0329c:	1909      	adds	r1, r1, r4
c0d0329e:	401a      	ands	r2, r3
c0d032a0:	d005      	beq.n	c0d032ae <memcpy+0x6a>
c0d032a2:	2300      	movs	r3, #0
c0d032a4:	5ccc      	ldrb	r4, [r1, r3]
c0d032a6:	54ec      	strb	r4, [r5, r3]
c0d032a8:	3301      	adds	r3, #1
c0d032aa:	429a      	cmp	r2, r3
c0d032ac:	d1fa      	bne.n	c0d032a4 <memcpy+0x60>
c0d032ae:	bd70      	pop	{r4, r5, r6, pc}
c0d032b0:	0005      	movs	r5, r0
c0d032b2:	2a00      	cmp	r2, #0
c0d032b4:	d1f5      	bne.n	c0d032a2 <memcpy+0x5e>
c0d032b6:	e7fa      	b.n	c0d032ae <memcpy+0x6a>
c0d032b8:	0005      	movs	r5, r0
c0d032ba:	e7f2      	b.n	c0d032a2 <memcpy+0x5e>
c0d032bc:	001a      	movs	r2, r3
c0d032be:	e7f8      	b.n	c0d032b2 <memcpy+0x6e>

c0d032c0 <memset>:
c0d032c0:	b570      	push	{r4, r5, r6, lr}
c0d032c2:	0783      	lsls	r3, r0, #30
c0d032c4:	d03f      	beq.n	c0d03346 <memset+0x86>
c0d032c6:	1e54      	subs	r4, r2, #1
c0d032c8:	2a00      	cmp	r2, #0
c0d032ca:	d03b      	beq.n	c0d03344 <memset+0x84>
c0d032cc:	b2ce      	uxtb	r6, r1
c0d032ce:	0003      	movs	r3, r0
c0d032d0:	2503      	movs	r5, #3
c0d032d2:	e003      	b.n	c0d032dc <memset+0x1c>
c0d032d4:	1e62      	subs	r2, r4, #1
c0d032d6:	2c00      	cmp	r4, #0
c0d032d8:	d034      	beq.n	c0d03344 <memset+0x84>
c0d032da:	0014      	movs	r4, r2
c0d032dc:	3301      	adds	r3, #1
c0d032de:	1e5a      	subs	r2, r3, #1
c0d032e0:	7016      	strb	r6, [r2, #0]
c0d032e2:	422b      	tst	r3, r5
c0d032e4:	d1f6      	bne.n	c0d032d4 <memset+0x14>
c0d032e6:	2c03      	cmp	r4, #3
c0d032e8:	d924      	bls.n	c0d03334 <memset+0x74>
c0d032ea:	25ff      	movs	r5, #255	; 0xff
c0d032ec:	400d      	ands	r5, r1
c0d032ee:	022a      	lsls	r2, r5, #8
c0d032f0:	4315      	orrs	r5, r2
c0d032f2:	042a      	lsls	r2, r5, #16
c0d032f4:	4315      	orrs	r5, r2
c0d032f6:	2c0f      	cmp	r4, #15
c0d032f8:	d911      	bls.n	c0d0331e <memset+0x5e>
c0d032fa:	0026      	movs	r6, r4
c0d032fc:	3e10      	subs	r6, #16
c0d032fe:	0936      	lsrs	r6, r6, #4
c0d03300:	3601      	adds	r6, #1
c0d03302:	0136      	lsls	r6, r6, #4
c0d03304:	001a      	movs	r2, r3
c0d03306:	199b      	adds	r3, r3, r6
c0d03308:	6015      	str	r5, [r2, #0]
c0d0330a:	6055      	str	r5, [r2, #4]
c0d0330c:	6095      	str	r5, [r2, #8]
c0d0330e:	60d5      	str	r5, [r2, #12]
c0d03310:	3210      	adds	r2, #16
c0d03312:	4293      	cmp	r3, r2
c0d03314:	d1f8      	bne.n	c0d03308 <memset+0x48>
c0d03316:	220f      	movs	r2, #15
c0d03318:	4014      	ands	r4, r2
c0d0331a:	2c03      	cmp	r4, #3
c0d0331c:	d90a      	bls.n	c0d03334 <memset+0x74>
c0d0331e:	1f26      	subs	r6, r4, #4
c0d03320:	08b6      	lsrs	r6, r6, #2
c0d03322:	3601      	adds	r6, #1
c0d03324:	00b6      	lsls	r6, r6, #2
c0d03326:	001a      	movs	r2, r3
c0d03328:	199b      	adds	r3, r3, r6
c0d0332a:	c220      	stmia	r2!, {r5}
c0d0332c:	4293      	cmp	r3, r2
c0d0332e:	d1fc      	bne.n	c0d0332a <memset+0x6a>
c0d03330:	2203      	movs	r2, #3
c0d03332:	4014      	ands	r4, r2
c0d03334:	2c00      	cmp	r4, #0
c0d03336:	d005      	beq.n	c0d03344 <memset+0x84>
c0d03338:	b2c9      	uxtb	r1, r1
c0d0333a:	191c      	adds	r4, r3, r4
c0d0333c:	7019      	strb	r1, [r3, #0]
c0d0333e:	3301      	adds	r3, #1
c0d03340:	429c      	cmp	r4, r3
c0d03342:	d1fb      	bne.n	c0d0333c <memset+0x7c>
c0d03344:	bd70      	pop	{r4, r5, r6, pc}
c0d03346:	0014      	movs	r4, r2
c0d03348:	0003      	movs	r3, r0
c0d0334a:	e7cc      	b.n	c0d032e6 <memset+0x26>

c0d0334c <setjmp>:
c0d0334c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0334e:	4641      	mov	r1, r8
c0d03350:	464a      	mov	r2, r9
c0d03352:	4653      	mov	r3, sl
c0d03354:	465c      	mov	r4, fp
c0d03356:	466d      	mov	r5, sp
c0d03358:	4676      	mov	r6, lr
c0d0335a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d0335c:	3828      	subs	r0, #40	; 0x28
c0d0335e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03360:	2000      	movs	r0, #0
c0d03362:	4770      	bx	lr

c0d03364 <longjmp>:
c0d03364:	3010      	adds	r0, #16
c0d03366:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03368:	4690      	mov	r8, r2
c0d0336a:	4699      	mov	r9, r3
c0d0336c:	46a2      	mov	sl, r4
c0d0336e:	46ab      	mov	fp, r5
c0d03370:	46b5      	mov	sp, r6
c0d03372:	c808      	ldmia	r0!, {r3}
c0d03374:	3828      	subs	r0, #40	; 0x28
c0d03376:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03378:	1c08      	adds	r0, r1, #0
c0d0337a:	d100      	bne.n	c0d0337e <longjmp+0x1a>
c0d0337c:	2001      	movs	r0, #1
c0d0337e:	4718      	bx	r3

c0d03380 <strlen>:
c0d03380:	b510      	push	{r4, lr}
c0d03382:	0783      	lsls	r3, r0, #30
c0d03384:	d027      	beq.n	c0d033d6 <strlen+0x56>
c0d03386:	7803      	ldrb	r3, [r0, #0]
c0d03388:	2b00      	cmp	r3, #0
c0d0338a:	d026      	beq.n	c0d033da <strlen+0x5a>
c0d0338c:	0003      	movs	r3, r0
c0d0338e:	2103      	movs	r1, #3
c0d03390:	e002      	b.n	c0d03398 <strlen+0x18>
c0d03392:	781a      	ldrb	r2, [r3, #0]
c0d03394:	2a00      	cmp	r2, #0
c0d03396:	d01c      	beq.n	c0d033d2 <strlen+0x52>
c0d03398:	3301      	adds	r3, #1
c0d0339a:	420b      	tst	r3, r1
c0d0339c:	d1f9      	bne.n	c0d03392 <strlen+0x12>
c0d0339e:	6819      	ldr	r1, [r3, #0]
c0d033a0:	4a0f      	ldr	r2, [pc, #60]	; (c0d033e0 <strlen+0x60>)
c0d033a2:	4c10      	ldr	r4, [pc, #64]	; (c0d033e4 <strlen+0x64>)
c0d033a4:	188a      	adds	r2, r1, r2
c0d033a6:	438a      	bics	r2, r1
c0d033a8:	4222      	tst	r2, r4
c0d033aa:	d10f      	bne.n	c0d033cc <strlen+0x4c>
c0d033ac:	3304      	adds	r3, #4
c0d033ae:	6819      	ldr	r1, [r3, #0]
c0d033b0:	4a0b      	ldr	r2, [pc, #44]	; (c0d033e0 <strlen+0x60>)
c0d033b2:	188a      	adds	r2, r1, r2
c0d033b4:	438a      	bics	r2, r1
c0d033b6:	4222      	tst	r2, r4
c0d033b8:	d108      	bne.n	c0d033cc <strlen+0x4c>
c0d033ba:	3304      	adds	r3, #4
c0d033bc:	6819      	ldr	r1, [r3, #0]
c0d033be:	4a08      	ldr	r2, [pc, #32]	; (c0d033e0 <strlen+0x60>)
c0d033c0:	188a      	adds	r2, r1, r2
c0d033c2:	438a      	bics	r2, r1
c0d033c4:	4222      	tst	r2, r4
c0d033c6:	d0f1      	beq.n	c0d033ac <strlen+0x2c>
c0d033c8:	e000      	b.n	c0d033cc <strlen+0x4c>
c0d033ca:	3301      	adds	r3, #1
c0d033cc:	781a      	ldrb	r2, [r3, #0]
c0d033ce:	2a00      	cmp	r2, #0
c0d033d0:	d1fb      	bne.n	c0d033ca <strlen+0x4a>
c0d033d2:	1a18      	subs	r0, r3, r0
c0d033d4:	bd10      	pop	{r4, pc}
c0d033d6:	0003      	movs	r3, r0
c0d033d8:	e7e1      	b.n	c0d0339e <strlen+0x1e>
c0d033da:	2000      	movs	r0, #0
c0d033dc:	e7fa      	b.n	c0d033d4 <strlen+0x54>
c0d033de:	46c0      	nop			; (mov r8, r8)
c0d033e0:	fefefeff 	.word	0xfefefeff
c0d033e4:	80808080 	.word	0x80808080
c0d033e8:	45544550 	.word	0x45544550
c0d033ec:	54455052 	.word	0x54455052
c0d033f0:	45505245 	.word	0x45505245
c0d033f4:	50524554 	.word	0x50524554
c0d033f8:	52455445 	.word	0x52455445
c0d033fc:	45544550 	.word	0x45544550
c0d03400:	54455052 	.word	0x54455052
c0d03404:	45505245 	.word	0x45505245
c0d03408:	50524554 	.word	0x50524554
c0d0340c:	52455445 	.word	0x52455445
c0d03410:	45544550 	.word	0x45544550
c0d03414:	54455052 	.word	0x54455052
c0d03418:	45505245 	.word	0x45505245
c0d0341c:	50524554 	.word	0x50524554
c0d03420:	52455445 	.word	0x52455445
c0d03424:	45544550 	.word	0x45544550
c0d03428:	54455052 	.word	0x54455052
c0d0342c:	45505245 	.word	0x45505245
c0d03430:	50524554 	.word	0x50524554
c0d03434:	52455445 	.word	0x52455445
c0d03438:	00000052 	.word	0x00000052

c0d0343c <trits_mapping>:
c0d0343c:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d0344c:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d0345c:	00ff0100 000000ff 00010000 0001ff00     ................
c0d0346c:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d0347c:	00000100 01000101 000101ff 01010101     ................
c0d0348c:	00000001                                ....

c0d03490 <HALF_3>:
c0d03490:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d034a0:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d034b0:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d034c0 <bagl_ui_nanos_screen1>:
c0d034c0:	00000003 00800000 00000020 00000001     ........ .......
c0d034d0:	00000000 00ffffff 00000000 00000000     ................
	...
c0d034f8:	00000107 0080000c 00000020 00000000     ........ .......
c0d03508:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03530:	00030005 0007000c 00000007 00000000     ................
	...
c0d03548:	00070000 00000000 00000000 00000000     ................
	...
c0d03568:	00750005 0008000d 00000006 00000000     ..u.............
c0d03578:	00ffffff 00000000 00060000 00000000     ................
	...

c0d035a0 <bagl_ui_nanos_screen2>:
c0d035a0:	00000003 00800000 00000020 00000001     ........ .......
c0d035b0:	00000000 00ffffff 00000000 00000000     ................
	...
c0d035d8:	00000107 00800012 00000020 00000000     ........ .......
c0d035e8:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03610:	00030005 0007000c 00000007 00000000     ................
	...
c0d03628:	00070000 00000000 00000000 00000000     ................
	...
c0d03648:	00750005 0008000d 00000006 00000000     ..u.............
c0d03658:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03680 <bagl_ui_sample_blue>:
c0d03680:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03690:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d036b8:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d036c8:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d036f0:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03700:	00ffffff 001d2028 00002004 c0d03760     ....( ... ..`7..
	...
c0d03728:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03738:	0041ccb4 00f9f9f9 0000a004 c0d0376c     ..A.........l7..
c0d03748:	00000000 0037ae99 00f9f9f9 c0d021ad     ......7......!..
	...
c0d03760:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03771 <USBD_PRODUCT_FS_STRING>:
c0d03771:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d0377f <HID_ReportDesc>:
c0d0377f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d0378f:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0379f:	0000c008 11210900                                .....

c0d037a4 <USBD_HID_Desc>:
c0d037a4:	01112109 22220100 00011200                       .!...."".

c0d037ad <USBD_DeviceDesc>:
c0d037ad:	02000112 40000000 00012c97 02010200     .......@.,......
c0d037bd:	bd000103                                         ...

c0d037c0 <HID_Desc>:
c0d037c0:	c0d02dbd c0d02dcd c0d02ddd c0d02ded     .-...-...-...-..
c0d037d0:	c0d02dfd c0d02e0d c0d02e1d 00000000     .-..............

c0d037e0 <USBD_LangIDDesc>:
c0d037e0:	04090304                                ....

c0d037e4 <USBD_MANUFACTURER_STRING>:
c0d037e4:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d037f2 <USB_SERIAL_STRING>:
c0d037f2:	0030030a 00300030 2c9f0031                       ..0.0.0.1.

c0d037fc <USBD_HID>:
c0d037fc:	c0d02c9f c0d02cd1 c0d02c03 00000000     .,...,...,......
	...
c0d03814:	c0d02d09 00000000 00000000 00000000     .-..............
c0d03824:	c0d02e2d c0d02e2d c0d02e2d c0d02e3d     -...-...-...=...

c0d03834 <USBD_CfgDesc>:
c0d03834:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03844:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03854:	05070100 00400302 00000001              ......@.....

c0d03860 <USBD_DeviceQualifierDesc>:
c0d03860:	0200060a 40000000 00000001              .......@....

c0d0386c <_etext>:
	...

c0d03880 <N_storage_real>:
	...
