
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
c0d00014:	f000 ff58 	bl	c0d00ec8 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fea4 	bl	c0d00d64 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fa2b 	bl	c0d03480 <setjmp>
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
c0d00040:	f001 f8e8 	bl	c0d01214 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fdc9 	bl	c0d01bdc <pic>
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
c0d0005a:	f001 fdbf 	bl	c0d01bdc <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fe0d 	bl	c0d01c80 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 ff14 	bl	c0d02e94 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 ff11 	bl	c0d02e94 <USB_power>

            ui_idle();
c0d00072:	f002 f8a5 	bl	c0d021c0 <ui_idle>

            IOTA_main();
c0d00076:	f000 fd0d 	bl	c0d00a94 <IOTA_main>
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
c0d0008c:	f003 fa04 	bl	c0d03498 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d039c0 	.word	0xc0d039c0

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
c0d000ca:	f001 fb37 	bl	c0d0173c <snprintf>
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
c0d00192:	f002 ffc7 	bl	c0d03124 <__aeabi_idiv>
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
c0d001c0:	f002 ff26 	bl	c0d03010 <__aeabi_uidiv>
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
c0d001dc:	b0f7      	sub	sp, #476	; 0x1dc
c0d001de:	920b      	str	r2, [sp, #44]	; 0x2c
c0d001e0:	460d      	mov	r5, r1
c0d001e2:	4604      	mov	r4, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d001e4:	f000 faa2 	bl	c0d0072c <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001e8:	f000 faa0 	bl	c0d0072c <kerl_initialize>
c0d001ec:	ae18      	add	r6, sp, #96	; 0x60

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001ee:	4630      	mov	r0, r6
c0d001f0:	4621      	mov	r1, r4
c0d001f2:	462a      	mov	r2, r5
c0d001f4:	f003 f8b4 	bl	c0d03360 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001f8:	1970      	adds	r0, r6, r5
c0d001fa:	2130      	movs	r1, #48	; 0x30
c0d001fc:	1b4a      	subs	r2, r1, r5
c0d001fe:	460d      	mov	r5, r1
c0d00200:	950a      	str	r5, [sp, #40]	; 0x28
c0d00202:	4621      	mov	r1, r4
c0d00204:	f003 f8ac 	bl	c0d03360 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00208:	4630      	mov	r0, r6
c0d0020a:	4629      	mov	r1, r5
c0d0020c:	f000 fa9a 	bl	c0d00744 <kerl_absorb_bytes>
c0d00210:	ac55      	add	r4, sp, #340	; 0x154
c0d00212:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00214:	4620      	mov	r0, r4
c0d00216:	4629      	mov	r1, r5
c0d00218:	f003 f89c 	bl	c0d03354 <__aeabi_memclr>
c0d0021c:	ae18      	add	r6, sp, #96	; 0x60
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021e:	492e      	ldr	r1, [pc, #184]	; (c0d002d8 <get_seed+0x100>)
c0d00220:	4479      	add	r1, pc
c0d00222:	2252      	movs	r2, #82	; 0x52
c0d00224:	4630      	mov	r0, r6
c0d00226:	f003 f89b 	bl	c0d03360 <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d0022a:	4630      	mov	r0, r6
c0d0022c:	4621      	mov	r1, r4
c0d0022e:	462a      	mov	r2, r5
c0d00230:	f000 f9ac 	bl	c0d0058c <chars_to_trytes>
c0d00234:	ae18      	add	r6, sp, #96	; 0x60
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00236:	21f3      	movs	r1, #243	; 0xf3
c0d00238:	4630      	mov	r0, r6
c0d0023a:	f003 f88b 	bl	c0d03354 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0023e:	4620      	mov	r0, r4
c0d00240:	4631      	mov	r1, r6
c0d00242:	462a      	mov	r2, r5
c0d00244:	f000 f984 	bl	c0d00550 <trytes_to_trits>
c0d00248:	ac6a      	add	r4, sp, #424	; 0x1a8
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d0024a:	4630      	mov	r0, r6
c0d0024c:	4621      	mov	r1, r4
c0d0024e:	f7ff ff47 	bl	c0d000e0 <specific_243trits_to_49trints>
c0d00252:	ae18      	add	r6, sp, #96	; 0x60
        // kerl_squeeze_trints(seed_trints, 49);
      }
      // {
      //   // Print result of trints_to_words
        uint32_t words[12];
        memset(words, 0, sizeof(words));
c0d00254:	4630      	mov	r0, r6
c0d00256:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00258:	f003 f87c 	bl	c0d03354 <__aeabi_memclr>
        trints_to_words_u_mem(seed_trints, words);
c0d0025c:	4620      	mov	r0, r4
c0d0025e:	4631      	mov	r1, r6
c0d00260:	f000 f9cc 	bl	c0d005fc <trints_to_words_u_mem>
c0d00264:	ac0c      	add	r4, sp, #48	; 0x30
c0d00266:	220c      	movs	r2, #12
        unsigned char bytes[48];
        words_to_bytes(words, bytes, 12);
c0d00268:	4630      	mov	r0, r6
c0d0026a:	4621      	mov	r1, r4
c0d0026c:	f000 f9a4 	bl	c0d005b8 <words_to_bytes>
        snprintf(msg, 81, "words: %u %u %u bytes: %u %u %u %u %u", words[0], words[1], words[2], bytes[0], bytes[1], bytes[2], bytes[3], bytes[4]);
c0d00270:	7823      	ldrb	r3, [r4, #0]
c0d00272:	7860      	ldrb	r0, [r4, #1]
c0d00274:	9009      	str	r0, [sp, #36]	; 0x24
c0d00276:	78a0      	ldrb	r0, [r4, #2]
c0d00278:	9008      	str	r0, [sp, #32]
c0d0027a:	78e6      	ldrb	r6, [r4, #3]
c0d0027c:	7924      	ldrb	r4, [r4, #4]
c0d0027e:	9818      	ldr	r0, [sp, #96]	; 0x60
c0d00280:	900a      	str	r0, [sp, #40]	; 0x28
c0d00282:	9a19      	ldr	r2, [sp, #100]	; 0x64
c0d00284:	991a      	ldr	r1, [sp, #104]	; 0x68
c0d00286:	4668      	mov	r0, sp
c0d00288:	6002      	str	r2, [r0, #0]
c0d0028a:	6041      	str	r1, [r0, #4]
c0d0028c:	6083      	str	r3, [r0, #8]
c0d0028e:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00290:	60c1      	str	r1, [r0, #12]
c0d00292:	9908      	ldr	r1, [sp, #32]
c0d00294:	6101      	str	r1, [r0, #16]
c0d00296:	6146      	str	r6, [r0, #20]
c0d00298:	6184      	str	r4, [r0, #24]
c0d0029a:	a205      	add	r2, pc, #20	; (adr r2, c0d002b0 <get_seed+0xd8>)
c0d0029c:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d0029e:	4620      	mov	r0, r4
c0d002a0:	4629      	mov	r1, r5
c0d002a2:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d002a4:	f001 fa4a 	bl	c0d0173c <snprintf>
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d002a8:	2000      	movs	r0, #0
        // specific_49trints_to_243trits(seed_trints, seed_trits);
        // trits_to_trytes(seed_trits, seed_trytes, 243);
        // trytes_to_chars(seed_trytes, msg, 81);
      }
      {
        msg[81] = '\0';
c0d002aa:	5560      	strb	r0, [r4, r5]
    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
}
c0d002ac:	b077      	add	sp, #476	; 0x1dc
c0d002ae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d002b0:	64726f77 	.word	0x64726f77
c0d002b4:	25203a73 	.word	0x25203a73
c0d002b8:	75252075 	.word	0x75252075
c0d002bc:	20752520 	.word	0x20752520
c0d002c0:	65747962 	.word	0x65747962
c0d002c4:	25203a73 	.word	0x25203a73
c0d002c8:	75252075 	.word	0x75252075
c0d002cc:	20752520 	.word	0x20752520
c0d002d0:	25207525 	.word	0x25207525
c0d002d4:	00000075 	.word	0x00000075
c0d002d8:	000032f8 	.word	0x000032f8

c0d002dc <bigint_add_int_u_mem>:
    return len;
}

//memory optimized for add in place
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len)
{
c0d002dc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002de:	af03      	add	r7, sp, #12
c0d002e0:	b083      	sub	sp, #12

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d002e2:	6803      	ldr	r3, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002e4:	2600      	movs	r6, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d002e6:	1859      	adds	r1, r3, r1
c0d002e8:	4633      	mov	r3, r6
c0d002ea:	415b      	adcs	r3, r3
c0d002ec:	9001      	str	r0, [sp, #4]
{
    struct int_bool_pair val;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;
c0d002ee:	6001      	str	r1, [r0, #0]
c0d002f0:	2101      	movs	r1, #1
c0d002f2:	2b00      	cmp	r3, #0
c0d002f4:	d100      	bne.n	c0d002f8 <bigint_add_int_u_mem+0x1c>
c0d002f6:	4619      	mov	r1, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002f8:	43f0      	mvns	r0, r6

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d002fa:	9002      	str	r0, [sp, #8]
c0d002fc:	2a02      	cmp	r2, #2
c0d002fe:	d31b      	bcc.n	c0d00338 <bigint_add_int_u_mem+0x5c>
c0d00300:	2301      	movs	r3, #1
c0d00302:	9200      	str	r2, [sp, #0]
        // only continue adding, if there is a carry bit
        if (!val.hi) {
c0d00304:	07c9      	lsls	r1, r1, #31
c0d00306:	d01d      	beq.n	c0d00344 <bigint_add_int_u_mem+0x68>
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d00308:	0099      	lsls	r1, r3, #2
c0d0030a:	9801      	ldr	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0030c:	5845      	ldr	r5, [r0, r1]
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0030e:	1c6a      	adds	r2, r5, #1
c0d00310:	4634      	mov	r4, r6
c0d00312:	4176      	adcs	r6, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
c0d00314:	5042      	str	r2, [r0, r1]
c0d00316:	2501      	movs	r5, #1
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00318:	9802      	ldr	r0, [sp, #8]
c0d0031a:	4282      	cmp	r2, r0
c0d0031c:	4629      	mov	r1, r5
c0d0031e:	d800      	bhi.n	c0d00322 <bigint_add_int_u_mem+0x46>
c0d00320:	4621      	mov	r1, r4
c0d00322:	2e00      	cmp	r6, #0
c0d00324:	d100      	bne.n	c0d00328 <bigint_add_int_u_mem+0x4c>
c0d00326:	4635      	mov	r5, r6
c0d00328:	2e00      	cmp	r6, #0
c0d0032a:	d000      	beq.n	c0d0032e <bigint_add_int_u_mem+0x52>
c0d0032c:	4629      	mov	r1, r5

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d0032e:	1c5b      	adds	r3, r3, #1
c0d00330:	9a00      	ldr	r2, [sp, #0]
c0d00332:	4293      	cmp	r3, r2
c0d00334:	4626      	mov	r6, r4
c0d00336:	d3e5      	bcc.n	c0d00304 <bigint_add_int_u_mem+0x28>
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
    }

    // detect overflow
    if (val.hi) {
c0d00338:	2900      	cmp	r1, #0
c0d0033a:	d100      	bne.n	c0d0033e <bigint_add_int_u_mem+0x62>
c0d0033c:	9202      	str	r2, [sp, #8]
c0d0033e:	9802      	ldr	r0, [sp, #8]
c0d00340:	b003      	add	sp, #12
c0d00342:	bdf0      	pop	{r4, r5, r6, r7, pc}
        return -1;
    }
    return len;
}
c0d00344:	4618      	mov	r0, r3
c0d00346:	b003      	add	sp, #12
c0d00348:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0034a <bigint_add_int_u>:

int bigint_add_int_u(uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len)
{
c0d0034a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0034c:	af03      	add	r7, sp, #12
c0d0034e:	b085      	sub	sp, #20
c0d00350:	9303      	str	r3, [sp, #12]
c0d00352:	9001      	str	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00354:	6800      	ldr	r0, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00356:	2400      	movs	r4, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00358:	1840      	adds	r0, r0, r1
c0d0035a:	4623      	mov	r3, r4
c0d0035c:	415b      	adcs	r3, r3
c0d0035e:	9202      	str	r2, [sp, #8]
    struct int_bool_pair val;
    uint8_t i;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;
c0d00360:	6010      	str	r0, [r2, #0]

    i = 1;
    for (; i < len; i++) {
c0d00362:	2601      	movs	r6, #1
c0d00364:	2b00      	cmp	r3, #0
c0d00366:	4631      	mov	r1, r6
c0d00368:	d000      	beq.n	c0d0036c <bigint_add_int_u+0x22>
c0d0036a:	4621      	mov	r1, r4
c0d0036c:	2b00      	cmp	r3, #0
c0d0036e:	4635      	mov	r5, r6
c0d00370:	d100      	bne.n	c0d00374 <bigint_add_int_u+0x2a>
c0d00372:	461d      	mov	r5, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00374:	43e0      	mvns	r0, r4
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d00376:	9000      	str	r0, [sp, #0]
c0d00378:	9803      	ldr	r0, [sp, #12]
c0d0037a:	2802      	cmp	r0, #2
c0d0037c:	d323      	bcc.n	c0d003c6 <bigint_add_int_u+0x7c>
c0d0037e:	2900      	cmp	r1, #0
c0d00380:	d121      	bne.n	c0d003c6 <bigint_add_int_u+0x7c>
c0d00382:	2101      	movs	r1, #1
c0d00384:	9104      	str	r1, [sp, #16]
c0d00386:	4634      	mov	r4, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d00388:	008d      	lsls	r5, r1, #2

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0038a:	9801      	ldr	r0, [sp, #4]
c0d0038c:	5943      	ldr	r3, [r0, r5]
c0d0038e:	2200      	movs	r2, #0
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00390:	1c58      	adds	r0, r3, #1
c0d00392:	4613      	mov	r3, r2
c0d00394:	415b      	adcs	r3, r3
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
c0d00396:	9e02      	ldr	r6, [sp, #8]
c0d00398:	5170      	str	r0, [r6, r5]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0039a:	9d00      	ldr	r5, [sp, #0]
c0d0039c:	42a8      	cmp	r0, r5
c0d0039e:	9d04      	ldr	r5, [sp, #16]
c0d003a0:	d800      	bhi.n	c0d003a4 <bigint_add_int_u+0x5a>
c0d003a2:	4615      	mov	r5, r2
c0d003a4:	2b00      	cmp	r3, #0
c0d003a6:	9a04      	ldr	r2, [sp, #16]
c0d003a8:	d100      	bne.n	c0d003ac <bigint_add_int_u+0x62>
c0d003aa:	461a      	mov	r2, r3
c0d003ac:	2b00      	cmp	r3, #0
c0d003ae:	4626      	mov	r6, r4
c0d003b0:	d000      	beq.n	c0d003b4 <bigint_add_int_u+0x6a>
c0d003b2:	4615      	mov	r5, r2
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d003b4:	462a      	mov	r2, r5
c0d003b6:	4072      	eors	r2, r6
c0d003b8:	1c49      	adds	r1, r1, #1
c0d003ba:	9803      	ldr	r0, [sp, #12]
c0d003bc:	4281      	cmp	r1, r0
c0d003be:	d203      	bcs.n	c0d003c8 <bigint_add_int_u+0x7e>
c0d003c0:	2a00      	cmp	r2, #0
c0d003c2:	d0e0      	beq.n	c0d00386 <bigint_add_int_u+0x3c>
c0d003c4:	e000      	b.n	c0d003c8 <bigint_add_int_u+0x7e>
c0d003c6:	4631      	mov	r1, r6
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d003c8:	b2cb      	uxtb	r3, r1
c0d003ca:	9803      	ldr	r0, [sp, #12]
c0d003cc:	4283      	cmp	r3, r0
c0d003ce:	d20a      	bcs.n	c0d003e6 <bigint_add_int_u+0x9c>
        bigint_out[j] = bigint_in[j];
c0d003d0:	9803      	ldr	r0, [sp, #12]
c0d003d2:	1ac4      	subs	r4, r0, r3
c0d003d4:	009a      	lsls	r2, r3, #2
c0d003d6:	9801      	ldr	r0, [sp, #4]
c0d003d8:	1880      	adds	r0, r0, r2
c0d003da:	9e02      	ldr	r6, [sp, #8]
c0d003dc:	18b2      	adds	r2, r6, r2
c0d003de:	c840      	ldmia	r0!, {r6}
c0d003e0:	c240      	stmia	r2!, {r6}
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d003e2:	1e64      	subs	r4, r4, #1
c0d003e4:	d1fb      	bne.n	c0d003de <bigint_add_int_u+0x94>
        bigint_out[j] = bigint_in[j];
    }

    if (val.hi && i == len) {
c0d003e6:	2000      	movs	r0, #0
c0d003e8:	43c0      	mvns	r0, r0
c0d003ea:	9a03      	ldr	r2, [sp, #12]
c0d003ec:	4293      	cmp	r3, r2
c0d003ee:	d000      	beq.n	c0d003f2 <bigint_add_int_u+0xa8>
c0d003f0:	4608      	mov	r0, r1
c0d003f2:	2d00      	cmp	r5, #0
c0d003f4:	d100      	bne.n	c0d003f8 <bigint_add_int_u+0xae>
c0d003f6:	4608      	mov	r0, r1
        return -1;
    }
    return i;
}
c0d003f8:	b005      	add	sp, #20
c0d003fa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003fc <bigint_sub_bigint_u_mem>:
    return len;
}

//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
c0d003fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003fe:	af03      	add	r7, sp, #12
c0d00400:	b086      	sub	sp, #24
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00402:	2a00      	cmp	r2, #0
c0d00404:	d037      	beq.n	c0d00476 <bigint_sub_bigint_u_mem+0x7a>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00406:	2300      	movs	r3, #0
c0d00408:	9300      	str	r3, [sp, #0]
c0d0040a:	43de      	mvns	r6, r3
c0d0040c:	2501      	movs	r5, #1
c0d0040e:	9505      	str	r5, [sp, #20]
c0d00410:	9203      	str	r2, [sp, #12]
c0d00412:	9001      	str	r0, [sp, #4]
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00414:	6804      	ldr	r4, [r0, #0]
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00416:	c908      	ldmia	r1!, {r3}
c0d00418:	9104      	str	r1, [sp, #16]
c0d0041a:	43db      	mvns	r3, r3
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0041c:	1918      	adds	r0, r3, r4
c0d0041e:	4633      	mov	r3, r6
c0d00420:	9e00      	ldr	r6, [sp, #0]
c0d00422:	4632      	mov	r2, r6
c0d00424:	4152      	adcs	r2, r2
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00426:	4601      	mov	r1, r0
c0d00428:	4019      	ands	r1, r3
c0d0042a:	1c4c      	adds	r4, r1, #1
c0d0042c:	4631      	mov	r1, r6
c0d0042e:	4149      	adcs	r1, r1
c0d00430:	9e05      	ldr	r6, [sp, #20]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00432:	4035      	ands	r5, r6
c0d00434:	2d00      	cmp	r5, #0
c0d00436:	d100      	bne.n	c0d0043a <bigint_sub_bigint_u_mem+0x3e>
c0d00438:	4604      	mov	r4, r0
c0d0043a:	9402      	str	r4, [sp, #8]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0043c:	429c      	cmp	r4, r3
c0d0043e:	4634      	mov	r4, r6
c0d00440:	461e      	mov	r6, r3
c0d00442:	d800      	bhi.n	c0d00446 <bigint_sub_bigint_u_mem+0x4a>
c0d00444:	9c00      	ldr	r4, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00446:	2d00      	cmp	r5, #0
c0d00448:	d100      	bne.n	c0d0044c <bigint_sub_bigint_u_mem+0x50>
c0d0044a:	4611      	mov	r1, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0044c:	2900      	cmp	r1, #0
c0d0044e:	9b05      	ldr	r3, [sp, #20]
c0d00450:	461d      	mov	r5, r3
c0d00452:	d100      	bne.n	c0d00456 <bigint_sub_bigint_u_mem+0x5a>
c0d00454:	460d      	mov	r5, r1
c0d00456:	2900      	cmp	r1, #0
c0d00458:	d000      	beq.n	c0d0045c <bigint_sub_bigint_u_mem+0x60>
c0d0045a:	462c      	mov	r4, r5
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0045c:	4314      	orrs	r4, r2
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0045e:	2c00      	cmp	r4, #0
c0d00460:	461d      	mov	r5, r3
c0d00462:	9802      	ldr	r0, [sp, #8]
c0d00464:	d100      	bne.n	c0d00468 <bigint_sub_bigint_u_mem+0x6c>
c0d00466:	4625      	mov	r5, r4
c0d00468:	9901      	ldr	r1, [sp, #4]
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
c0d0046a:	c101      	stmia	r1!, {r0}
c0d0046c:	4608      	mov	r0, r1
c0d0046e:	9a03      	ldr	r2, [sp, #12]
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00470:	1e52      	subs	r2, r2, #1
c0d00472:	9904      	ldr	r1, [sp, #16]
c0d00474:	d1cc      	bne.n	c0d00410 <bigint_sub_bigint_u_mem+0x14>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
    }
    return 0;
c0d00476:	2000      	movs	r0, #0
c0d00478:	b006      	add	sp, #24
c0d0047a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0047c <bigint_sub_bigint_u>:
}

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
c0d0047c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0047e:	af03      	add	r7, sp, #12
c0d00480:	b087      	sub	sp, #28
c0d00482:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00484:	2d00      	cmp	r5, #0
c0d00486:	d037      	beq.n	c0d004f8 <bigint_sub_bigint_u+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00488:	2400      	movs	r4, #0
c0d0048a:	9402      	str	r4, [sp, #8]
c0d0048c:	43e3      	mvns	r3, r4
c0d0048e:	9301      	str	r3, [sp, #4]
c0d00490:	2601      	movs	r6, #1
c0d00492:	9600      	str	r6, [sp, #0]
c0d00494:	9203      	str	r2, [sp, #12]
c0d00496:	9504      	str	r5, [sp, #16]
c0d00498:	4604      	mov	r4, r0
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0049a:	cc01      	ldmia	r4!, {r0}
c0d0049c:	9405      	str	r4, [sp, #20]
c0d0049e:	460c      	mov	r4, r1
int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d004a0:	cc02      	ldmia	r4!, {r1}
c0d004a2:	9406      	str	r4, [sp, #24]
c0d004a4:	43c9      	mvns	r1, r1
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004a6:	180a      	adds	r2, r1, r0
c0d004a8:	9902      	ldr	r1, [sp, #8]
c0d004aa:	460c      	mov	r4, r1
c0d004ac:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d004ae:	4610      	mov	r0, r2
c0d004b0:	9d01      	ldr	r5, [sp, #4]
c0d004b2:	4028      	ands	r0, r5
c0d004b4:	1c43      	adds	r3, r0, #1
c0d004b6:	4608      	mov	r0, r1
c0d004b8:	4140      	adcs	r0, r0
c0d004ba:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d004bc:	400e      	ands	r6, r1
c0d004be:	2e00      	cmp	r6, #0
c0d004c0:	d100      	bne.n	c0d004c4 <bigint_sub_bigint_u+0x48>
c0d004c2:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004c4:	42ab      	cmp	r3, r5
c0d004c6:	460d      	mov	r5, r1
c0d004c8:	d800      	bhi.n	c0d004cc <bigint_sub_bigint_u+0x50>
c0d004ca:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d004cc:	2e00      	cmp	r6, #0
c0d004ce:	9a03      	ldr	r2, [sp, #12]
c0d004d0:	d100      	bne.n	c0d004d4 <bigint_sub_bigint_u+0x58>
c0d004d2:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004d4:	2800      	cmp	r0, #0
c0d004d6:	460e      	mov	r6, r1
c0d004d8:	d100      	bne.n	c0d004dc <bigint_sub_bigint_u+0x60>
c0d004da:	4606      	mov	r6, r0
c0d004dc:	2800      	cmp	r0, #0
c0d004de:	d000      	beq.n	c0d004e2 <bigint_sub_bigint_u+0x66>
c0d004e0:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d004e2:	4325      	orrs	r5, r4

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004e4:	2d00      	cmp	r5, #0
c0d004e6:	460e      	mov	r6, r1
c0d004e8:	9805      	ldr	r0, [sp, #20]
c0d004ea:	d100      	bne.n	c0d004ee <bigint_sub_bigint_u+0x72>
c0d004ec:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d004ee:	c208      	stmia	r2!, {r3}
c0d004f0:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004f2:	1e6d      	subs	r5, r5, #1
c0d004f4:	9906      	ldr	r1, [sp, #24]
c0d004f6:	d1cd      	bne.n	c0d00494 <bigint_sub_bigint_u+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d004f8:	2000      	movs	r0, #0
c0d004fa:	b007      	add	sp, #28
c0d004fc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004fe <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d004fe:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00500:	af03      	add	r7, sp, #12
c0d00502:	b081      	sub	sp, #4
c0d00504:	2400      	movs	r4, #0
c0d00506:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00508:	32ff      	adds	r2, #255	; 0xff
c0d0050a:	b253      	sxtb	r3, r2
c0d0050c:	2b00      	cmp	r3, #0
c0d0050e:	db0f      	blt.n	c0d00530 <bigint_cmp_bigint_u+0x32>
c0d00510:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00512:	009b      	lsls	r3, r3, #2
c0d00514:	58ce      	ldr	r6, [r1, r3]
c0d00516:	58c4      	ldr	r4, [r0, r3]
c0d00518:	2301      	movs	r3, #1
c0d0051a:	42b4      	cmp	r4, r6
c0d0051c:	d80b      	bhi.n	c0d00536 <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0051e:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00520:	42b4      	cmp	r4, r6
c0d00522:	d307      	bcc.n	c0d00534 <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00524:	b253      	sxtb	r3, r2
c0d00526:	42ab      	cmp	r3, r5
c0d00528:	461a      	mov	r2, r3
c0d0052a:	dcf2      	bgt.n	c0d00512 <bigint_cmp_bigint_u+0x14>
c0d0052c:	9b00      	ldr	r3, [sp, #0]
c0d0052e:	e002      	b.n	c0d00536 <bigint_cmp_bigint_u+0x38>
c0d00530:	4623      	mov	r3, r4
c0d00532:	e000      	b.n	c0d00536 <bigint_cmp_bigint_u+0x38>
c0d00534:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00536:	4618      	mov	r0, r3
c0d00538:	b001      	add	sp, #4
c0d0053a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0053c <bigint_not_u>:
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0053c:	2900      	cmp	r1, #0
c0d0053e:	d004      	beq.n	c0d0054a <bigint_not_u+0xe>
        bigint[i] = ~bigint[i];
c0d00540:	6802      	ldr	r2, [r0, #0]
c0d00542:	43d2      	mvns	r2, r2
c0d00544:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00546:	1e49      	subs	r1, r1, #1
c0d00548:	d1fa      	bne.n	c0d00540 <bigint_not_u+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d0054a:	2000      	movs	r0, #0
c0d0054c:	4770      	bx	lr
	...

c0d00550 <trytes_to_trits>:
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00550:	b5b0      	push	{r4, r5, r7, lr}
c0d00552:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00554:	2a00      	cmp	r2, #0
c0d00556:	d015      	beq.n	c0d00584 <trytes_to_trits+0x34>
c0d00558:	4b0b      	ldr	r3, [pc, #44]	; (c0d00588 <trytes_to_trits+0x38>)
c0d0055a:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0055c:	240d      	movs	r4, #13
c0d0055e:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00560:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00562:	062d      	lsls	r5, r5, #24
c0d00564:	192c      	adds	r4, r5, r4
c0d00566:	1624      	asrs	r4, r4, #24
c0d00568:	2503      	movs	r5, #3
c0d0056a:	4365      	muls	r5, r4
c0d0056c:	5d5c      	ldrb	r4, [r3, r5]
c0d0056e:	700c      	strb	r4, [r1, #0]
c0d00570:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00572:	7865      	ldrb	r5, [r4, #1]
c0d00574:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d00576:	78a4      	ldrb	r4, [r4, #2]
c0d00578:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0057a:	1e52      	subs	r2, r2, #1
c0d0057c:	1cc9      	adds	r1, r1, #3
c0d0057e:	1c40      	adds	r0, r0, #1
c0d00580:	2a00      	cmp	r2, #0
c0d00582:	d1eb      	bne.n	c0d0055c <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00584:	2000      	movs	r0, #0
c0d00586:	bdb0      	pop	{r4, r5, r7, pc}
c0d00588:	00003012 	.word	0x00003012

c0d0058c <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d0058c:	b5d0      	push	{r4, r6, r7, lr}
c0d0058e:	af02      	add	r7, sp, #8
c0d00590:	e00e      	b.n	c0d005b0 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00592:	7803      	ldrb	r3, [r0, #0]
c0d00594:	b25b      	sxtb	r3, r3
c0d00596:	2400      	movs	r4, #0
c0d00598:	2b39      	cmp	r3, #57	; 0x39
c0d0059a:	d005      	beq.n	c0d005a8 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d0059c:	2b4e      	cmp	r3, #78	; 0x4e
c0d0059e:	db01      	blt.n	c0d005a4 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d005a0:	33a5      	adds	r3, #165	; 0xa5
c0d005a2:	e000      	b.n	c0d005a6 <chars_to_trytes+0x1a>
c0d005a4:	33c0      	adds	r3, #192	; 0xc0
c0d005a6:	461c      	mov	r4, r3
c0d005a8:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d005aa:	1e52      	subs	r2, r2, #1
c0d005ac:	1c40      	adds	r0, r0, #1
c0d005ae:	1c49      	adds	r1, r1, #1
c0d005b0:	2a00      	cmp	r2, #0
c0d005b2:	d1ee      	bne.n	c0d00592 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d005b4:	2000      	movs	r0, #0
c0d005b6:	bdd0      	pop	{r4, r6, r7, pc}

c0d005b8 <words_to_bytes>:
    }
    return 0;
}

int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d005b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005ba:	af03      	add	r7, sp, #12
c0d005bc:	b081      	sub	sp, #4
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d005be:	2300      	movs	r3, #0
c0d005c0:	43db      	mvns	r3, r3
c0d005c2:	32ff      	adds	r2, #255	; 0xff
c0d005c4:	b254      	sxtb	r4, r2
c0d005c6:	2c00      	cmp	r4, #0
c0d005c8:	db15      	blt.n	c0d005f6 <words_to_bytes+0x3e>
      uint32_t value = words_in[i];
c0d005ca:	9300      	str	r3, [sp, #0]
c0d005cc:	00a4      	lsls	r4, r4, #2
c0d005ce:	5905      	ldr	r5, [r0, r4]
      bytes_out[i*4+0] = (value & 0x000000ff);
c0d005d0:	550d      	strb	r5, [r1, r4]
      bytes_out[i*4+1] = (value & 0x0000ff00) >> 8;
c0d005d2:	2601      	movs	r6, #1
c0d005d4:	4326      	orrs	r6, r4
c0d005d6:	0a2b      	lsrs	r3, r5, #8
c0d005d8:	558b      	strb	r3, [r1, r6]
c0d005da:	2302      	movs	r3, #2
      bytes_out[i*4+2] = (value & 0x00ff0000) >> 16;
c0d005dc:	4323      	orrs	r3, r4
c0d005de:	0c2e      	lsrs	r6, r5, #16
c0d005e0:	54ce      	strb	r6, [r1, r3]
      bytes_out[i*4+3] = (value & 0xff000000) >> 24;
c0d005e2:	2303      	movs	r3, #3
c0d005e4:	4323      	orrs	r3, r4
c0d005e6:	0e2c      	lsrs	r4, r5, #24
c0d005e8:	54cc      	strb	r4, [r1, r3]
c0d005ea:	9b00      	ldr	r3, [sp, #0]
    return 0;
}

int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d005ec:	1e52      	subs	r2, r2, #1
c0d005ee:	b254      	sxtb	r4, r2
c0d005f0:	429c      	cmp	r4, r3
c0d005f2:	4622      	mov	r2, r4
c0d005f4:	dcea      	bgt.n	c0d005cc <words_to_bytes+0x14>
      bytes_out[i*4+1] = (value & 0x0000ff00) >> 8;
      bytes_out[i*4+2] = (value & 0x00ff0000) >> 16;
      bytes_out[i*4+3] = (value & 0xff000000) >> 24;
    }

    return 0;
c0d005f6:	2000      	movs	r0, #0
c0d005f8:	b001      	add	sp, #4
c0d005fa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005fc <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d005fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005fe:	af03      	add	r7, sp, #12
c0d00600:	b095      	sub	sp, #84	; 0x54
c0d00602:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d00604:	2130      	movs	r1, #48	; 0x30
c0d00606:	9000      	str	r0, [sp, #0]
c0d00608:	5640      	ldrsb	r0, [r0, r1]
c0d0060a:	a913      	add	r1, sp, #76	; 0x4c
c0d0060c:	2203      	movs	r2, #3
c0d0060e:	f7ff fdab 	bl	c0d00168 <trint_to_trits>
c0d00612:	2001      	movs	r0, #1
c0d00614:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00616:	9606      	str	r6, [sp, #24]
c0d00618:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d0061a:	2105      	movs	r1, #5
c0d0061c:	4620      	mov	r0, r4
c0d0061e:	f002 fe67 	bl	c0d032f0 <__aeabi_idivmod>
c0d00622:	460e      	mov	r6, r1
c0d00624:	2e04      	cmp	r6, #4
c0d00626:	d10b      	bne.n	c0d00640 <trints_to_words_u_mem+0x44>
c0d00628:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d0062a:	4620      	mov	r0, r4
c0d0062c:	4629      	mov	r1, r5
c0d0062e:	f002 fd79 	bl	c0d03124 <__aeabi_idiv>
c0d00632:	b2c0      	uxtb	r0, r0
c0d00634:	9900      	ldr	r1, [sp, #0]
c0d00636:	5608      	ldrsb	r0, [r1, r0]
c0d00638:	a913      	add	r1, sp, #76	; 0x4c
c0d0063a:	462a      	mov	r2, r5
c0d0063c:	f7ff fd94 	bl	c0d00168 <trint_to_trits>
c0d00640:	a813      	add	r0, sp, #76	; 0x4c

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d00642:	5d80      	ldrb	r0, [r0, r6]
c0d00644:	1c41      	adds	r1, r0, #1
c0d00646:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00648:	9804      	ldr	r0, [sp, #16]
c0d0064a:	2800      	cmp	r0, #0
c0d0064c:	d022      	beq.n	c0d00694 <trints_to_words_u_mem+0x98>
c0d0064e:	9101      	str	r1, [sp, #4]
c0d00650:	9402      	str	r4, [sp, #8]
c0d00652:	2500      	movs	r5, #0
c0d00654:	462e      	mov	r6, r5
c0d00656:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d00658:	00b1      	lsls	r1, r6, #2
c0d0065a:	9105      	str	r1, [sp, #20]
c0d0065c:	9806      	ldr	r0, [sp, #24]
c0d0065e:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d00660:	2203      	movs	r2, #3
c0d00662:	9c03      	ldr	r4, [sp, #12]
c0d00664:	4621      	mov	r1, r4
c0d00666:	4623      	mov	r3, r4
c0d00668:	f002 fe48 	bl	c0d032fc <__aeabi_lmul>
c0d0066c:	9b04      	ldr	r3, [sp, #16]
c0d0066e:	1940      	adds	r0, r0, r5
c0d00670:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d00672:	9a06      	ldr	r2, [sp, #24]
c0d00674:	9c05      	ldr	r4, [sp, #20]
c0d00676:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00678:	1c76      	adds	r6, r6, #1
c0d0067a:	42b3      	cmp	r3, r6
c0d0067c:	460d      	mov	r5, r1
c0d0067e:	d1eb      	bne.n	c0d00658 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d00680:	2900      	cmp	r1, #0
c0d00682:	d004      	beq.n	c0d0068e <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d00684:	0098      	lsls	r0, r3, #2
c0d00686:	9a06      	ldr	r2, [sp, #24]
c0d00688:	5011      	str	r1, [r2, r0]
                size++;
c0d0068a:	1c5d      	adds	r5, r3, #1
c0d0068c:	e000      	b.n	c0d00690 <trints_to_words_u_mem+0x94>
c0d0068e:	461d      	mov	r5, r3
c0d00690:	9c02      	ldr	r4, [sp, #8]
c0d00692:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00694:	b2c9      	uxtb	r1, r1
c0d00696:	220c      	movs	r2, #12
c0d00698:	9e06      	ldr	r6, [sp, #24]
c0d0069a:	4630      	mov	r0, r6
c0d0069c:	f7ff fe1e 	bl	c0d002dc <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d006a0:	42a8      	cmp	r0, r5
c0d006a2:	d800      	bhi.n	c0d006a6 <trints_to_words_u_mem+0xaa>
c0d006a4:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d006a6:	1e61      	subs	r1, r4, #1
c0d006a8:	2c00      	cmp	r4, #0
c0d006aa:	460c      	mov	r4, r1
c0d006ac:	dcb4      	bgt.n	c0d00618 <trints_to_words_u_mem+0x1c>
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d006ae:	481c      	ldr	r0, [pc, #112]	; (c0d00720 <trints_to_words_u_mem+0x124>)
c0d006b0:	4478      	add	r0, pc
c0d006b2:	220c      	movs	r2, #12
c0d006b4:	4631      	mov	r1, r6
c0d006b6:	f7ff ff22 	bl	c0d004fe <bigint_cmp_bigint_u>
c0d006ba:	2801      	cmp	r0, #1
c0d006bc:	db14      	blt.n	c0d006e8 <trints_to_words_u_mem+0xec>
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d006be:	481a      	ldr	r0, [pc, #104]	; (c0d00728 <trints_to_words_u_mem+0x12c>)
c0d006c0:	4478      	add	r0, pc
c0d006c2:	ae07      	add	r6, sp, #28
c0d006c4:	250c      	movs	r5, #12
c0d006c6:	9906      	ldr	r1, [sp, #24]
c0d006c8:	4632      	mov	r2, r6
c0d006ca:	462b      	mov	r3, r5
c0d006cc:	f7ff fed6 	bl	c0d0047c <bigint_sub_bigint_u>
        bigint_not_u(tmp, 12);
c0d006d0:	4630      	mov	r0, r6
c0d006d2:	4629      	mov	r1, r5
c0d006d4:	f7ff ff32 	bl	c0d0053c <bigint_not_u>
        bigint_add_int_u(tmp, 1, base, 12);
c0d006d8:	2101      	movs	r1, #1
c0d006da:	4630      	mov	r0, r6
c0d006dc:	9e06      	ldr	r6, [sp, #24]
c0d006de:	4632      	mov	r2, r6
c0d006e0:	462b      	mov	r3, r5
c0d006e2:	f7ff fe32 	bl	c0d0034a <bigint_add_int_u>
c0d006e6:	e005      	b.n	c0d006f4 <trints_to_words_u_mem+0xf8>
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d006e8:	490e      	ldr	r1, [pc, #56]	; (c0d00724 <trints_to_words_u_mem+0x128>)
c0d006ea:	4479      	add	r1, pc
c0d006ec:	220c      	movs	r2, #12
c0d006ee:	4630      	mov	r0, r6
c0d006f0:	f7ff fe84 	bl	c0d003fc <bigint_sub_bigint_u_mem>
c0d006f4:	2000      	movs	r0, #0
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d006f6:	0081      	lsls	r1, r0, #2
c0d006f8:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d006fa:	1a73      	subs	r3, r6, r1
c0d006fc:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d006fe:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d00700:	62da      	str	r2, [r3, #44]	; 0x2c
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d00702:	1c40      	adds	r0, r0, #1
c0d00704:	2806      	cmp	r0, #6
c0d00706:	d1f6      	bne.n	c0d006f6 <trints_to_words_u_mem+0xfa>
c0d00708:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d0070a:	0081      	lsls	r1, r0, #2
c0d0070c:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d0070e:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00710:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d00712:	1c40      	adds	r0, r0, #1
c0d00714:	280c      	cmp	r0, #12
c0d00716:	d1f8      	bne.n	c0d0070a <trints_to_words_u_mem+0x10e>
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
c0d00718:	2000      	movs	r0, #0
c0d0071a:	b015      	add	sp, #84	; 0x54
c0d0071c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0071e:	46c0      	nop			; (mov r8, r8)
c0d00720:	00002f10 	.word	0x00002f10
c0d00724:	00002ed6 	.word	0x00002ed6
c0d00728:	00002f00 	.word	0x00002f00

c0d0072c <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d0072c:	b580      	push	{r7, lr}
c0d0072e:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00730:	2003      	movs	r0, #3
c0d00732:	01c1      	lsls	r1, r0, #7
c0d00734:	4802      	ldr	r0, [pc, #8]	; (c0d00740 <kerl_initialize+0x14>)
c0d00736:	f001 fafd 	bl	c0d01d34 <cx_keccak_init>
    return 0;
c0d0073a:	2000      	movs	r0, #0
c0d0073c:	bd80      	pop	{r7, pc}
c0d0073e:	46c0      	nop			; (mov r8, r8)
c0d00740:	20001840 	.word	0x20001840

c0d00744 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00744:	b580      	push	{r7, lr}
c0d00746:	af00      	add	r7, sp, #0
c0d00748:	b082      	sub	sp, #8
c0d0074a:	460b      	mov	r3, r1
c0d0074c:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0074e:	4805      	ldr	r0, [pc, #20]	; (c0d00764 <kerl_absorb_bytes+0x20>)
c0d00750:	4669      	mov	r1, sp
c0d00752:	6008      	str	r0, [r1, #0]
c0d00754:	4804      	ldr	r0, [pc, #16]	; (c0d00768 <kerl_absorb_bytes+0x24>)
c0d00756:	2101      	movs	r1, #1
c0d00758:	f001 fb0a 	bl	c0d01d70 <cx_hash>
c0d0075c:	2000      	movs	r0, #0
    return 0;
c0d0075e:	b002      	add	sp, #8
c0d00760:	bd80      	pop	{r7, pc}
c0d00762:	46c0      	nop			; (mov r8, r8)
c0d00764:	200019e8 	.word	0x200019e8
c0d00768:	20001840 	.word	0x20001840

c0d0076c <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d0076c:	b580      	push	{r7, lr}
c0d0076e:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00770:	4804      	ldr	r0, [pc, #16]	; (c0d00784 <nvram_is_init+0x18>)
c0d00772:	f001 fa33 	bl	c0d01bdc <pic>
c0d00776:	7801      	ldrb	r1, [r0, #0]
c0d00778:	2000      	movs	r0, #0
c0d0077a:	2901      	cmp	r1, #1
c0d0077c:	d100      	bne.n	c0d00780 <nvram_is_init+0x14>
c0d0077e:	4608      	mov	r0, r1
    else return true;
}
c0d00780:	bd80      	pop	{r7, pc}
c0d00782:	46c0      	nop			; (mov r8, r8)
c0d00784:	c0d039c0 	.word	0xc0d039c0

c0d00788 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00788:	b5b0      	push	{r4, r5, r7, lr}
c0d0078a:	af02      	add	r7, sp, #8
c0d0078c:	4605      	mov	r5, r0
c0d0078e:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00790:	4028      	ands	r0, r5
c0d00792:	2400      	movs	r4, #0
c0d00794:	2801      	cmp	r0, #1
c0d00796:	d013      	beq.n	c0d007c0 <io_exchange_al+0x38>
c0d00798:	2802      	cmp	r0, #2
c0d0079a:	d113      	bne.n	c0d007c4 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d0079c:	2900      	cmp	r1, #0
c0d0079e:	d008      	beq.n	c0d007b2 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d007a0:	480b      	ldr	r0, [pc, #44]	; (c0d007d0 <io_exchange_al+0x48>)
c0d007a2:	f001 fbd7 	bl	c0d01f54 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d007a6:	b268      	sxtb	r0, r5
c0d007a8:	2800      	cmp	r0, #0
c0d007aa:	da09      	bge.n	c0d007c0 <io_exchange_al+0x38>
                reset();
c0d007ac:	f001 fa4c 	bl	c0d01c48 <reset>
c0d007b0:	e006      	b.n	c0d007c0 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d007b2:	2041      	movs	r0, #65	; 0x41
c0d007b4:	0081      	lsls	r1, r0, #2
c0d007b6:	4806      	ldr	r0, [pc, #24]	; (c0d007d0 <io_exchange_al+0x48>)
c0d007b8:	2200      	movs	r2, #0
c0d007ba:	f001 fc05 	bl	c0d01fc8 <io_seproxyhal_spi_recv>
c0d007be:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d007c0:	4620      	mov	r0, r4
c0d007c2:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d007c4:	4803      	ldr	r0, [pc, #12]	; (c0d007d4 <io_exchange_al+0x4c>)
c0d007c6:	6800      	ldr	r0, [r0, #0]
c0d007c8:	2102      	movs	r1, #2
c0d007ca:	f002 fe65 	bl	c0d03498 <longjmp>
c0d007ce:	46c0      	nop			; (mov r8, r8)
c0d007d0:	20001c08 	.word	0x20001c08
c0d007d4:	20001bb8 	.word	0x20001bb8

c0d007d8 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d007d8:	b580      	push	{r7, lr}
c0d007da:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d007dc:	f000 fe8e 	bl	c0d014fc <io_seproxyhal_display_default>
}
c0d007e0:	bd80      	pop	{r7, pc}
	...

c0d007e4 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d007e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007e6:	af03      	add	r7, sp, #12
c0d007e8:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d007ea:	48a6      	ldr	r0, [pc, #664]	; (c0d00a84 <io_event+0x2a0>)
c0d007ec:	7800      	ldrb	r0, [r0, #0]
c0d007ee:	2805      	cmp	r0, #5
c0d007f0:	d02e      	beq.n	c0d00850 <io_event+0x6c>
c0d007f2:	280d      	cmp	r0, #13
c0d007f4:	d04e      	beq.n	c0d00894 <io_event+0xb0>
c0d007f6:	280c      	cmp	r0, #12
c0d007f8:	d000      	beq.n	c0d007fc <io_event+0x18>
c0d007fa:	e13a      	b.n	c0d00a72 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d007fc:	4ea2      	ldr	r6, [pc, #648]	; (c0d00a88 <io_event+0x2a4>)
c0d007fe:	2001      	movs	r0, #1
c0d00800:	7630      	strb	r0, [r6, #24]
c0d00802:	2500      	movs	r5, #0
c0d00804:	61f5      	str	r5, [r6, #28]
c0d00806:	4634      	mov	r4, r6
c0d00808:	3418      	adds	r4, #24
c0d0080a:	4620      	mov	r0, r4
c0d0080c:	f001 fb68 	bl	c0d01ee0 <os_ux>
c0d00810:	61f0      	str	r0, [r6, #28]
c0d00812:	499e      	ldr	r1, [pc, #632]	; (c0d00a8c <io_event+0x2a8>)
c0d00814:	4288      	cmp	r0, r1
c0d00816:	d100      	bne.n	c0d0081a <io_event+0x36>
c0d00818:	e12b      	b.n	c0d00a72 <io_event+0x28e>
c0d0081a:	2800      	cmp	r0, #0
c0d0081c:	d100      	bne.n	c0d00820 <io_event+0x3c>
c0d0081e:	e128      	b.n	c0d00a72 <io_event+0x28e>
c0d00820:	499b      	ldr	r1, [pc, #620]	; (c0d00a90 <io_event+0x2ac>)
c0d00822:	4288      	cmp	r0, r1
c0d00824:	d000      	beq.n	c0d00828 <io_event+0x44>
c0d00826:	e0ac      	b.n	c0d00982 <io_event+0x19e>
c0d00828:	2003      	movs	r0, #3
c0d0082a:	7630      	strb	r0, [r6, #24]
c0d0082c:	61f5      	str	r5, [r6, #28]
c0d0082e:	4620      	mov	r0, r4
c0d00830:	f001 fb56 	bl	c0d01ee0 <os_ux>
c0d00834:	61f0      	str	r0, [r6, #28]
c0d00836:	f000 fd17 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d0083a:	60b5      	str	r5, [r6, #8]
c0d0083c:	6830      	ldr	r0, [r6, #0]
c0d0083e:	2800      	cmp	r0, #0
c0d00840:	d100      	bne.n	c0d00844 <io_event+0x60>
c0d00842:	e116      	b.n	c0d00a72 <io_event+0x28e>
c0d00844:	69f0      	ldr	r0, [r6, #28]
c0d00846:	4991      	ldr	r1, [pc, #580]	; (c0d00a8c <io_event+0x2a8>)
c0d00848:	4288      	cmp	r0, r1
c0d0084a:	d000      	beq.n	c0d0084e <io_event+0x6a>
c0d0084c:	e096      	b.n	c0d0097c <io_event+0x198>
c0d0084e:	e110      	b.n	c0d00a72 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00850:	4d8d      	ldr	r5, [pc, #564]	; (c0d00a88 <io_event+0x2a4>)
c0d00852:	2001      	movs	r0, #1
c0d00854:	7628      	strb	r0, [r5, #24]
c0d00856:	2600      	movs	r6, #0
c0d00858:	61ee      	str	r6, [r5, #28]
c0d0085a:	462c      	mov	r4, r5
c0d0085c:	3418      	adds	r4, #24
c0d0085e:	4620      	mov	r0, r4
c0d00860:	f001 fb3e 	bl	c0d01ee0 <os_ux>
c0d00864:	4601      	mov	r1, r0
c0d00866:	61e9      	str	r1, [r5, #28]
c0d00868:	4889      	ldr	r0, [pc, #548]	; (c0d00a90 <io_event+0x2ac>)
c0d0086a:	4281      	cmp	r1, r0
c0d0086c:	d15d      	bne.n	c0d0092a <io_event+0x146>
c0d0086e:	2003      	movs	r0, #3
c0d00870:	7628      	strb	r0, [r5, #24]
c0d00872:	61ee      	str	r6, [r5, #28]
c0d00874:	4620      	mov	r0, r4
c0d00876:	f001 fb33 	bl	c0d01ee0 <os_ux>
c0d0087a:	61e8      	str	r0, [r5, #28]
c0d0087c:	f000 fcf4 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d00880:	60ae      	str	r6, [r5, #8]
c0d00882:	6828      	ldr	r0, [r5, #0]
c0d00884:	2800      	cmp	r0, #0
c0d00886:	d100      	bne.n	c0d0088a <io_event+0xa6>
c0d00888:	e0f3      	b.n	c0d00a72 <io_event+0x28e>
c0d0088a:	69e8      	ldr	r0, [r5, #28]
c0d0088c:	497f      	ldr	r1, [pc, #508]	; (c0d00a8c <io_event+0x2a8>)
c0d0088e:	4288      	cmp	r0, r1
c0d00890:	d148      	bne.n	c0d00924 <io_event+0x140>
c0d00892:	e0ee      	b.n	c0d00a72 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00894:	4d7c      	ldr	r5, [pc, #496]	; (c0d00a88 <io_event+0x2a4>)
c0d00896:	6868      	ldr	r0, [r5, #4]
c0d00898:	68a9      	ldr	r1, [r5, #8]
c0d0089a:	4281      	cmp	r1, r0
c0d0089c:	d300      	bcc.n	c0d008a0 <io_event+0xbc>
c0d0089e:	e0e8      	b.n	c0d00a72 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d008a0:	2001      	movs	r0, #1
c0d008a2:	7628      	strb	r0, [r5, #24]
c0d008a4:	2600      	movs	r6, #0
c0d008a6:	61ee      	str	r6, [r5, #28]
c0d008a8:	462c      	mov	r4, r5
c0d008aa:	3418      	adds	r4, #24
c0d008ac:	4620      	mov	r0, r4
c0d008ae:	f001 fb17 	bl	c0d01ee0 <os_ux>
c0d008b2:	61e8      	str	r0, [r5, #28]
c0d008b4:	4975      	ldr	r1, [pc, #468]	; (c0d00a8c <io_event+0x2a8>)
c0d008b6:	4288      	cmp	r0, r1
c0d008b8:	d100      	bne.n	c0d008bc <io_event+0xd8>
c0d008ba:	e0da      	b.n	c0d00a72 <io_event+0x28e>
c0d008bc:	2800      	cmp	r0, #0
c0d008be:	d100      	bne.n	c0d008c2 <io_event+0xde>
c0d008c0:	e0d7      	b.n	c0d00a72 <io_event+0x28e>
c0d008c2:	4973      	ldr	r1, [pc, #460]	; (c0d00a90 <io_event+0x2ac>)
c0d008c4:	4288      	cmp	r0, r1
c0d008c6:	d000      	beq.n	c0d008ca <io_event+0xe6>
c0d008c8:	e08d      	b.n	c0d009e6 <io_event+0x202>
c0d008ca:	2003      	movs	r0, #3
c0d008cc:	7628      	strb	r0, [r5, #24]
c0d008ce:	61ee      	str	r6, [r5, #28]
c0d008d0:	4620      	mov	r0, r4
c0d008d2:	f001 fb05 	bl	c0d01ee0 <os_ux>
c0d008d6:	61e8      	str	r0, [r5, #28]
c0d008d8:	f000 fcc6 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d008dc:	60ae      	str	r6, [r5, #8]
c0d008de:	6828      	ldr	r0, [r5, #0]
c0d008e0:	2800      	cmp	r0, #0
c0d008e2:	d100      	bne.n	c0d008e6 <io_event+0x102>
c0d008e4:	e0c5      	b.n	c0d00a72 <io_event+0x28e>
c0d008e6:	69e8      	ldr	r0, [r5, #28]
c0d008e8:	4968      	ldr	r1, [pc, #416]	; (c0d00a8c <io_event+0x2a8>)
c0d008ea:	4288      	cmp	r0, r1
c0d008ec:	d178      	bne.n	c0d009e0 <io_event+0x1fc>
c0d008ee:	e0c0      	b.n	c0d00a72 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d008f0:	6868      	ldr	r0, [r5, #4]
c0d008f2:	4286      	cmp	r6, r0
c0d008f4:	d300      	bcc.n	c0d008f8 <io_event+0x114>
c0d008f6:	e0bc      	b.n	c0d00a72 <io_event+0x28e>
c0d008f8:	f001 fb4a 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d008fc:	2800      	cmp	r0, #0
c0d008fe:	d000      	beq.n	c0d00902 <io_event+0x11e>
c0d00900:	e0b7      	b.n	c0d00a72 <io_event+0x28e>
c0d00902:	68a8      	ldr	r0, [r5, #8]
c0d00904:	68e9      	ldr	r1, [r5, #12]
c0d00906:	2438      	movs	r4, #56	; 0x38
c0d00908:	4360      	muls	r0, r4
c0d0090a:	682a      	ldr	r2, [r5, #0]
c0d0090c:	1810      	adds	r0, r2, r0
c0d0090e:	2900      	cmp	r1, #0
c0d00910:	d100      	bne.n	c0d00914 <io_event+0x130>
c0d00912:	e085      	b.n	c0d00a20 <io_event+0x23c>
c0d00914:	4788      	blx	r1
c0d00916:	2800      	cmp	r0, #0
c0d00918:	d000      	beq.n	c0d0091c <io_event+0x138>
c0d0091a:	e081      	b.n	c0d00a20 <io_event+0x23c>
c0d0091c:	68a8      	ldr	r0, [r5, #8]
c0d0091e:	1c46      	adds	r6, r0, #1
c0d00920:	60ae      	str	r6, [r5, #8]
c0d00922:	6828      	ldr	r0, [r5, #0]
c0d00924:	2800      	cmp	r0, #0
c0d00926:	d1e3      	bne.n	c0d008f0 <io_event+0x10c>
c0d00928:	e0a3      	b.n	c0d00a72 <io_event+0x28e>
c0d0092a:	6928      	ldr	r0, [r5, #16]
c0d0092c:	2800      	cmp	r0, #0
c0d0092e:	d100      	bne.n	c0d00932 <io_event+0x14e>
c0d00930:	e09f      	b.n	c0d00a72 <io_event+0x28e>
c0d00932:	4a56      	ldr	r2, [pc, #344]	; (c0d00a8c <io_event+0x2a8>)
c0d00934:	4291      	cmp	r1, r2
c0d00936:	d100      	bne.n	c0d0093a <io_event+0x156>
c0d00938:	e09b      	b.n	c0d00a72 <io_event+0x28e>
c0d0093a:	2900      	cmp	r1, #0
c0d0093c:	d100      	bne.n	c0d00940 <io_event+0x15c>
c0d0093e:	e098      	b.n	c0d00a72 <io_event+0x28e>
c0d00940:	4950      	ldr	r1, [pc, #320]	; (c0d00a84 <io_event+0x2a0>)
c0d00942:	78c9      	ldrb	r1, [r1, #3]
c0d00944:	0849      	lsrs	r1, r1, #1
c0d00946:	f000 fe1b 	bl	c0d01580 <io_seproxyhal_button_push>
c0d0094a:	e092      	b.n	c0d00a72 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0094c:	6870      	ldr	r0, [r6, #4]
c0d0094e:	4285      	cmp	r5, r0
c0d00950:	d300      	bcc.n	c0d00954 <io_event+0x170>
c0d00952:	e08e      	b.n	c0d00a72 <io_event+0x28e>
c0d00954:	f001 fb1c 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d00958:	2800      	cmp	r0, #0
c0d0095a:	d000      	beq.n	c0d0095e <io_event+0x17a>
c0d0095c:	e089      	b.n	c0d00a72 <io_event+0x28e>
c0d0095e:	68b0      	ldr	r0, [r6, #8]
c0d00960:	68f1      	ldr	r1, [r6, #12]
c0d00962:	2438      	movs	r4, #56	; 0x38
c0d00964:	4360      	muls	r0, r4
c0d00966:	6832      	ldr	r2, [r6, #0]
c0d00968:	1810      	adds	r0, r2, r0
c0d0096a:	2900      	cmp	r1, #0
c0d0096c:	d076      	beq.n	c0d00a5c <io_event+0x278>
c0d0096e:	4788      	blx	r1
c0d00970:	2800      	cmp	r0, #0
c0d00972:	d173      	bne.n	c0d00a5c <io_event+0x278>
c0d00974:	68b0      	ldr	r0, [r6, #8]
c0d00976:	1c45      	adds	r5, r0, #1
c0d00978:	60b5      	str	r5, [r6, #8]
c0d0097a:	6830      	ldr	r0, [r6, #0]
c0d0097c:	2800      	cmp	r0, #0
c0d0097e:	d1e5      	bne.n	c0d0094c <io_event+0x168>
c0d00980:	e077      	b.n	c0d00a72 <io_event+0x28e>
c0d00982:	88b0      	ldrh	r0, [r6, #4]
c0d00984:	9004      	str	r0, [sp, #16]
c0d00986:	6830      	ldr	r0, [r6, #0]
c0d00988:	9003      	str	r0, [sp, #12]
c0d0098a:	483e      	ldr	r0, [pc, #248]	; (c0d00a84 <io_event+0x2a0>)
c0d0098c:	4601      	mov	r1, r0
c0d0098e:	79cc      	ldrb	r4, [r1, #7]
c0d00990:	798b      	ldrb	r3, [r1, #6]
c0d00992:	794d      	ldrb	r5, [r1, #5]
c0d00994:	790a      	ldrb	r2, [r1, #4]
c0d00996:	4630      	mov	r0, r6
c0d00998:	78ce      	ldrb	r6, [r1, #3]
c0d0099a:	68c1      	ldr	r1, [r0, #12]
c0d0099c:	4668      	mov	r0, sp
c0d0099e:	6006      	str	r6, [r0, #0]
c0d009a0:	6041      	str	r1, [r0, #4]
c0d009a2:	0212      	lsls	r2, r2, #8
c0d009a4:	432a      	orrs	r2, r5
c0d009a6:	021b      	lsls	r3, r3, #8
c0d009a8:	4323      	orrs	r3, r4
c0d009aa:	9803      	ldr	r0, [sp, #12]
c0d009ac:	9904      	ldr	r1, [sp, #16]
c0d009ae:	f000 fcd5 	bl	c0d0135c <io_seproxyhal_touch_element_callback>
c0d009b2:	e05e      	b.n	c0d00a72 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d009b4:	6868      	ldr	r0, [r5, #4]
c0d009b6:	4286      	cmp	r6, r0
c0d009b8:	d25b      	bcs.n	c0d00a72 <io_event+0x28e>
c0d009ba:	f001 fae9 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d009be:	2800      	cmp	r0, #0
c0d009c0:	d157      	bne.n	c0d00a72 <io_event+0x28e>
c0d009c2:	68a8      	ldr	r0, [r5, #8]
c0d009c4:	68e9      	ldr	r1, [r5, #12]
c0d009c6:	2438      	movs	r4, #56	; 0x38
c0d009c8:	4360      	muls	r0, r4
c0d009ca:	682a      	ldr	r2, [r5, #0]
c0d009cc:	1810      	adds	r0, r2, r0
c0d009ce:	2900      	cmp	r1, #0
c0d009d0:	d026      	beq.n	c0d00a20 <io_event+0x23c>
c0d009d2:	4788      	blx	r1
c0d009d4:	2800      	cmp	r0, #0
c0d009d6:	d123      	bne.n	c0d00a20 <io_event+0x23c>
c0d009d8:	68a8      	ldr	r0, [r5, #8]
c0d009da:	1c46      	adds	r6, r0, #1
c0d009dc:	60ae      	str	r6, [r5, #8]
c0d009de:	6828      	ldr	r0, [r5, #0]
c0d009e0:	2800      	cmp	r0, #0
c0d009e2:	d1e7      	bne.n	c0d009b4 <io_event+0x1d0>
c0d009e4:	e045      	b.n	c0d00a72 <io_event+0x28e>
c0d009e6:	6828      	ldr	r0, [r5, #0]
c0d009e8:	2800      	cmp	r0, #0
c0d009ea:	d030      	beq.n	c0d00a4e <io_event+0x26a>
c0d009ec:	68a8      	ldr	r0, [r5, #8]
c0d009ee:	6869      	ldr	r1, [r5, #4]
c0d009f0:	4288      	cmp	r0, r1
c0d009f2:	d22c      	bcs.n	c0d00a4e <io_event+0x26a>
c0d009f4:	f001 facc 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d009f8:	2800      	cmp	r0, #0
c0d009fa:	d128      	bne.n	c0d00a4e <io_event+0x26a>
c0d009fc:	68a8      	ldr	r0, [r5, #8]
c0d009fe:	68e9      	ldr	r1, [r5, #12]
c0d00a00:	2438      	movs	r4, #56	; 0x38
c0d00a02:	4360      	muls	r0, r4
c0d00a04:	682a      	ldr	r2, [r5, #0]
c0d00a06:	1810      	adds	r0, r2, r0
c0d00a08:	2900      	cmp	r1, #0
c0d00a0a:	d015      	beq.n	c0d00a38 <io_event+0x254>
c0d00a0c:	4788      	blx	r1
c0d00a0e:	2800      	cmp	r0, #0
c0d00a10:	d112      	bne.n	c0d00a38 <io_event+0x254>
c0d00a12:	68a8      	ldr	r0, [r5, #8]
c0d00a14:	1c40      	adds	r0, r0, #1
c0d00a16:	60a8      	str	r0, [r5, #8]
c0d00a18:	6829      	ldr	r1, [r5, #0]
c0d00a1a:	2900      	cmp	r1, #0
c0d00a1c:	d1e7      	bne.n	c0d009ee <io_event+0x20a>
c0d00a1e:	e016      	b.n	c0d00a4e <io_event+0x26a>
c0d00a20:	2801      	cmp	r0, #1
c0d00a22:	d103      	bne.n	c0d00a2c <io_event+0x248>
c0d00a24:	68a8      	ldr	r0, [r5, #8]
c0d00a26:	4344      	muls	r4, r0
c0d00a28:	6828      	ldr	r0, [r5, #0]
c0d00a2a:	1900      	adds	r0, r0, r4
c0d00a2c:	f000 fd66 	bl	c0d014fc <io_seproxyhal_display_default>
c0d00a30:	68a8      	ldr	r0, [r5, #8]
c0d00a32:	1c40      	adds	r0, r0, #1
c0d00a34:	60a8      	str	r0, [r5, #8]
c0d00a36:	e01c      	b.n	c0d00a72 <io_event+0x28e>
c0d00a38:	2801      	cmp	r0, #1
c0d00a3a:	d103      	bne.n	c0d00a44 <io_event+0x260>
c0d00a3c:	68a8      	ldr	r0, [r5, #8]
c0d00a3e:	4344      	muls	r4, r0
c0d00a40:	6828      	ldr	r0, [r5, #0]
c0d00a42:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00a44:	f000 fd5a 	bl	c0d014fc <io_seproxyhal_display_default>
c0d00a48:	68a8      	ldr	r0, [r5, #8]
c0d00a4a:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00a4c:	60a8      	str	r0, [r5, #8]
c0d00a4e:	6868      	ldr	r0, [r5, #4]
c0d00a50:	68a9      	ldr	r1, [r5, #8]
c0d00a52:	4281      	cmp	r1, r0
c0d00a54:	d30d      	bcc.n	c0d00a72 <io_event+0x28e>
c0d00a56:	f001 fa9b 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d00a5a:	e00a      	b.n	c0d00a72 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00a5c:	2801      	cmp	r0, #1
c0d00a5e:	d103      	bne.n	c0d00a68 <io_event+0x284>
c0d00a60:	68b0      	ldr	r0, [r6, #8]
c0d00a62:	4344      	muls	r4, r0
c0d00a64:	6830      	ldr	r0, [r6, #0]
c0d00a66:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00a68:	f000 fd48 	bl	c0d014fc <io_seproxyhal_display_default>
c0d00a6c:	68b0      	ldr	r0, [r6, #8]
c0d00a6e:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00a70:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00a72:	f001 fa8d 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d00a76:	2800      	cmp	r0, #0
c0d00a78:	d101      	bne.n	c0d00a7e <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00a7a:	f000 fac9 	bl	c0d01010 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00a7e:	2001      	movs	r0, #1
c0d00a80:	b005      	add	sp, #20
c0d00a82:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a84:	20001a18 	.word	0x20001a18
c0d00a88:	20001a98 	.word	0x20001a98
c0d00a8c:	b0105044 	.word	0xb0105044
c0d00a90:	b0105055 	.word	0xb0105055

c0d00a94 <IOTA_main>:





static void IOTA_main(void) {
c0d00a94:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a96:	af03      	add	r7, sp, #12
c0d00a98:	b0dd      	sub	sp, #372	; 0x174
c0d00a9a:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00a9c:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00a9e:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00aa0:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00aa2:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00d28 <IOTA_main+0x294>)
c0d00aa4:	2110      	movs	r1, #16
c0d00aa6:	2203      	movs	r2, #3
c0d00aa8:	9109      	str	r1, [sp, #36]	; 0x24
c0d00aaa:	9208      	str	r2, [sp, #32]
c0d00aac:	f7ff fafa 	bl	c0d000a4 <write_debug>
c0d00ab0:	a80e      	add	r0, sp, #56	; 0x38
c0d00ab2:	304d      	adds	r0, #77	; 0x4d
c0d00ab4:	9007      	str	r0, [sp, #28]
c0d00ab6:	a80b      	add	r0, sp, #44	; 0x2c
c0d00ab8:	1dc1      	adds	r1, r0, #7
c0d00aba:	9106      	str	r1, [sp, #24]
c0d00abc:	1d00      	adds	r0, r0, #4
c0d00abe:	9005      	str	r0, [sp, #20]
c0d00ac0:	4e9d      	ldr	r6, [pc, #628]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00ac2:	6830      	ldr	r0, [r6, #0]
c0d00ac4:	e08d      	b.n	c0d00be2 <IOTA_main+0x14e>
c0d00ac6:	489f      	ldr	r0, [pc, #636]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00ac8:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00aca:	4330      	orrs	r0, r6
c0d00acc:	2880      	cmp	r0, #128	; 0x80
c0d00ace:	d000      	beq.n	c0d00ad2 <IOTA_main+0x3e>
c0d00ad0:	e11e      	b.n	c0d00d10 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00ad2:	7810      	ldrb	r0, [r2, #0]
c0d00ad4:	2800      	cmp	r0, #0
c0d00ad6:	4e98      	ldr	r6, [pc, #608]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00ad8:	d004      	beq.n	c0d00ae4 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00ada:	489c      	ldr	r0, [pc, #624]	; (c0d00d4c <IOTA_main+0x2b8>)
c0d00adc:	f001 f90c 	bl	c0d01cf8 <cx_sha256_init>
                        hashTainted = 0;
c0d00ae0:	4899      	ldr	r0, [pc, #612]	; (c0d00d48 <IOTA_main+0x2b4>)
c0d00ae2:	7004      	strb	r4, [r0, #0]
c0d00ae4:	4897      	ldr	r0, [pc, #604]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00ae6:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00ae8:	7908      	ldrb	r0, [r1, #4]
c0d00aea:	1808      	adds	r0, r1, r0
c0d00aec:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00aee:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00af0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00af2:	4308      	orrs	r0, r1
c0d00af4:	905a      	str	r0, [sp, #360]	; 0x168
c0d00af6:	e0e5      	b.n	c0d00cc4 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00af8:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00afa:	2818      	cmp	r0, #24
c0d00afc:	d800      	bhi.n	c0d00b00 <IOTA_main+0x6c>
c0d00afe:	e10c      	b.n	c0d00d1a <IOTA_main+0x286>
c0d00b00:	950a      	str	r5, [sp, #40]	; 0x28
c0d00b02:	4d90      	ldr	r5, [pc, #576]	; (c0d00d44 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00b04:	00a0      	lsls	r0, r4, #2
c0d00b06:	1829      	adds	r1, r5, r0
c0d00b08:	794a      	ldrb	r2, [r1, #5]
c0d00b0a:	0612      	lsls	r2, r2, #24
c0d00b0c:	798b      	ldrb	r3, [r1, #6]
c0d00b0e:	041b      	lsls	r3, r3, #16
c0d00b10:	4313      	orrs	r3, r2
c0d00b12:	79ca      	ldrb	r2, [r1, #7]
c0d00b14:	0212      	lsls	r2, r2, #8
c0d00b16:	431a      	orrs	r2, r3
c0d00b18:	7a09      	ldrb	r1, [r1, #8]
c0d00b1a:	4311      	orrs	r1, r2
c0d00b1c:	aa2b      	add	r2, sp, #172	; 0xac
c0d00b1e:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00b20:	1c64      	adds	r4, r4, #1
c0d00b22:	2c05      	cmp	r4, #5
c0d00b24:	d1ee      	bne.n	c0d00b04 <IOTA_main+0x70>
c0d00b26:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00b28:	9103      	str	r1, [sp, #12]
c0d00b2a:	4668      	mov	r0, sp
c0d00b2c:	6001      	str	r1, [r0, #0]
c0d00b2e:	2421      	movs	r4, #33	; 0x21
c0d00b30:	a92b      	add	r1, sp, #172	; 0xac
c0d00b32:	2205      	movs	r2, #5
c0d00b34:	ad23      	add	r5, sp, #140	; 0x8c
c0d00b36:	9502      	str	r5, [sp, #8]
c0d00b38:	4620      	mov	r0, r4
c0d00b3a:	462b      	mov	r3, r5
c0d00b3c:	f001 f992 	bl	c0d01e64 <os_perso_derive_node_bip32>
c0d00b40:	2220      	movs	r2, #32
c0d00b42:	9204      	str	r2, [sp, #16]
c0d00b44:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00b46:	9301      	str	r3, [sp, #4]
c0d00b48:	4620      	mov	r0, r4
c0d00b4a:	4629      	mov	r1, r5
c0d00b4c:	f001 f94e 	bl	c0d01dec <cx_ecfp_init_private_key>
c0d00b50:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00b52:	4620      	mov	r0, r4
c0d00b54:	9903      	ldr	r1, [sp, #12]
c0d00b56:	460a      	mov	r2, r1
c0d00b58:	462b      	mov	r3, r5
c0d00b5a:	f001 f929 	bl	c0d01db0 <cx_ecfp_init_public_key>
c0d00b5e:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00b60:	4620      	mov	r0, r4
c0d00b62:	4629      	mov	r1, r5
c0d00b64:	9a01      	ldr	r2, [sp, #4]
c0d00b66:	f001 f95f 	bl	c0d01e28 <cx_ecfp_generate_pair>
c0d00b6a:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00b6c:	9802      	ldr	r0, [sp, #8]
c0d00b6e:	9904      	ldr	r1, [sp, #16]
c0d00b70:	4622      	mov	r2, r4
c0d00b72:	f7ff fb31 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00b76:	2552      	movs	r5, #82	; 0x52
c0d00b78:	4872      	ldr	r0, [pc, #456]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00b7a:	4621      	mov	r1, r4
c0d00b7c:	462a      	mov	r2, r5
c0d00b7e:	f000 f9ad 	bl	c0d00edc <os_memmove>
                    tx = 82;
c0d00b82:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00b84:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b86:	1c41      	adds	r1, r0, #1
c0d00b88:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00b8a:	3610      	adds	r6, #16
c0d00b8c:	4a6d      	ldr	r2, [pc, #436]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00b8e:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00b90:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b92:	1c41      	adds	r1, r0, #1
c0d00b94:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00b96:	9903      	ldr	r1, [sp, #12]
c0d00b98:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00b9a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b9c:	b281      	uxth	r1, r0
c0d00b9e:	9804      	ldr	r0, [sp, #16]
c0d00ba0:	f000 fd2a 	bl	c0d015f8 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00ba4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00ba6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00ba8:	4308      	orrs	r0, r1
c0d00baa:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00bac:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00bae:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00bb0:	202e      	movs	r0, #46	; 0x2e
c0d00bb2:	9905      	ldr	r1, [sp, #20]
c0d00bb4:	7048      	strb	r0, [r1, #1]
c0d00bb6:	7008      	strb	r0, [r1, #0]
c0d00bb8:	7088      	strb	r0, [r1, #2]
c0d00bba:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00bbc:	78c8      	ldrb	r0, [r1, #3]
c0d00bbe:	9a06      	ldr	r2, [sp, #24]
c0d00bc0:	70d0      	strb	r0, [r2, #3]
c0d00bc2:	7888      	ldrb	r0, [r1, #2]
c0d00bc4:	7090      	strb	r0, [r2, #2]
c0d00bc6:	7848      	ldrb	r0, [r1, #1]
c0d00bc8:	7050      	strb	r0, [r2, #1]
c0d00bca:	7808      	ldrb	r0, [r1, #0]
c0d00bcc:	7010      	strb	r0, [r2, #0]
c0d00bce:	7908      	ldrb	r0, [r1, #4]
c0d00bd0:	7110      	strb	r0, [r2, #4]
c0d00bd2:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00bd4:	2140      	movs	r1, #64	; 0x40
c0d00bd6:	2203      	movs	r2, #3
c0d00bd8:	f001 fa8a 	bl	c0d020f0 <ui_display_debug>
c0d00bdc:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00bde:	4e56      	ldr	r6, [pc, #344]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00be0:	e070      	b.n	c0d00cc4 <IOTA_main+0x230>
c0d00be2:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00be4:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00be6:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00be8:	ac4d      	add	r4, sp, #308	; 0x134
c0d00bea:	4620      	mov	r0, r4
c0d00bec:	f002 fc48 	bl	c0d03480 <setjmp>
c0d00bf0:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00bf2:	6034      	str	r4, [r6, #0]
c0d00bf4:	4951      	ldr	r1, [pc, #324]	; (c0d00d3c <IOTA_main+0x2a8>)
c0d00bf6:	4208      	tst	r0, r1
c0d00bf8:	d011      	beq.n	c0d00c1e <IOTA_main+0x18a>
c0d00bfa:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00bfc:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00bfe:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00c00:	6031      	str	r1, [r6, #0]
c0d00c02:	210f      	movs	r1, #15
c0d00c04:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00c06:	4001      	ands	r1, r0
c0d00c08:	2209      	movs	r2, #9
c0d00c0a:	0312      	lsls	r2, r2, #12
c0d00c0c:	4291      	cmp	r1, r2
c0d00c0e:	d003      	beq.n	c0d00c18 <IOTA_main+0x184>
c0d00c10:	9a08      	ldr	r2, [sp, #32]
c0d00c12:	0352      	lsls	r2, r2, #13
c0d00c14:	4291      	cmp	r1, r2
c0d00c16:	d142      	bne.n	c0d00c9e <IOTA_main+0x20a>
c0d00c18:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00c1a:	8008      	strh	r0, [r1, #0]
c0d00c1c:	e046      	b.n	c0d00cac <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00c1e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00c20:	905c      	str	r0, [sp, #368]	; 0x170
c0d00c22:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00c24:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00c26:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00c28:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00c2a:	b2c0      	uxtb	r0, r0
c0d00c2c:	b289      	uxth	r1, r1
c0d00c2e:	f000 fce3 	bl	c0d015f8 <io_exchange>
c0d00c32:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00c34:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00c36:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00c38:	2800      	cmp	r0, #0
c0d00c3a:	d053      	beq.n	c0d00ce4 <IOTA_main+0x250>
c0d00c3c:	4941      	ldr	r1, [pc, #260]	; (c0d00d44 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00c3e:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00c40:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00c42:	2880      	cmp	r0, #128	; 0x80
c0d00c44:	4a40      	ldr	r2, [pc, #256]	; (c0d00d48 <IOTA_main+0x2b4>)
c0d00c46:	d155      	bne.n	c0d00cf4 <IOTA_main+0x260>
c0d00c48:	7848      	ldrb	r0, [r1, #1]
c0d00c4a:	216d      	movs	r1, #109	; 0x6d
c0d00c4c:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00c4e:	2807      	cmp	r0, #7
c0d00c50:	dc3f      	bgt.n	c0d00cd2 <IOTA_main+0x23e>
c0d00c52:	2802      	cmp	r0, #2
c0d00c54:	d100      	bne.n	c0d00c58 <IOTA_main+0x1c4>
c0d00c56:	e74f      	b.n	c0d00af8 <IOTA_main+0x64>
c0d00c58:	2804      	cmp	r0, #4
c0d00c5a:	d153      	bne.n	c0d00d04 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00c5c:	210b      	movs	r1, #11
c0d00c5e:	2203      	movs	r2, #3
c0d00c60:	a03c      	add	r0, pc, #240	; (adr r0, c0d00d54 <IOTA_main+0x2c0>)
c0d00c62:	f7ff fa1f 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00c66:	2048      	movs	r0, #72	; 0x48
c0d00c68:	4936      	ldr	r1, [pc, #216]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00c6a:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00c6c:	2049      	movs	r0, #73	; 0x49
c0d00c6e:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00c70:	2021      	movs	r0, #33	; 0x21
c0d00c72:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00c74:	3610      	adds	r6, #16
c0d00c76:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00c78:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00c7a:	2005      	movs	r0, #5
c0d00c7c:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00c7e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00c80:	b281      	uxth	r1, r0
c0d00c82:	2020      	movs	r0, #32
c0d00c84:	f000 fcb8 	bl	c0d015f8 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00c88:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00c8a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00c8c:	4308      	orrs	r0, r1
c0d00c8e:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00c90:	4620      	mov	r0, r4
c0d00c92:	4621      	mov	r1, r4
c0d00c94:	4622      	mov	r2, r4
c0d00c96:	f001 fa2b 	bl	c0d020f0 <ui_display_debug>
c0d00c9a:	4e27      	ldr	r6, [pc, #156]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00c9c:	e012      	b.n	c0d00cc4 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00c9e:	4928      	ldr	r1, [pc, #160]	; (c0d00d40 <IOTA_main+0x2ac>)
c0d00ca0:	4008      	ands	r0, r1
c0d00ca2:	210d      	movs	r1, #13
c0d00ca4:	02c9      	lsls	r1, r1, #11
c0d00ca6:	4301      	orrs	r1, r0
c0d00ca8:	a859      	add	r0, sp, #356	; 0x164
c0d00caa:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00cac:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00cae:	0a00      	lsrs	r0, r0, #8
c0d00cb0:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00cb2:	4a24      	ldr	r2, [pc, #144]	; (c0d00d44 <IOTA_main+0x2b0>)
c0d00cb4:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00cb6:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00cb8:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00cba:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00cbc:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00cbe:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00cc0:	1c80      	adds	r0, r0, #2
c0d00cc2:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00cc4:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00cc6:	6030      	str	r0, [r6, #0]
c0d00cc8:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00cca:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00ccc:	2900      	cmp	r1, #0
c0d00cce:	d088      	beq.n	c0d00be2 <IOTA_main+0x14e>
c0d00cd0:	e006      	b.n	c0d00ce0 <IOTA_main+0x24c>
c0d00cd2:	2808      	cmp	r0, #8
c0d00cd4:	d100      	bne.n	c0d00cd8 <IOTA_main+0x244>
c0d00cd6:	e6f6      	b.n	c0d00ac6 <IOTA_main+0x32>
c0d00cd8:	28ff      	cmp	r0, #255	; 0xff
c0d00cda:	d113      	bne.n	c0d00d04 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00cdc:	b05d      	add	sp, #372	; 0x174
c0d00cde:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00ce0:	f002 fbda 	bl	c0d03498 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00ce4:	2001      	movs	r0, #1
c0d00ce6:	4918      	ldr	r1, [pc, #96]	; (c0d00d48 <IOTA_main+0x2b4>)
c0d00ce8:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00cea:	4813      	ldr	r0, [pc, #76]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00cec:	6800      	ldr	r0, [r0, #0]
c0d00cee:	491c      	ldr	r1, [pc, #112]	; (c0d00d60 <IOTA_main+0x2cc>)
c0d00cf0:	f002 fbd2 	bl	c0d03498 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00cf4:	2001      	movs	r0, #1
c0d00cf6:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00cf8:	480f      	ldr	r0, [pc, #60]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00cfa:	6800      	ldr	r0, [r0, #0]
c0d00cfc:	2137      	movs	r1, #55	; 0x37
c0d00cfe:	0249      	lsls	r1, r1, #9
c0d00d00:	f002 fbca 	bl	c0d03498 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00d04:	2001      	movs	r0, #1
c0d00d06:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00d08:	480b      	ldr	r0, [pc, #44]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00d0a:	6800      	ldr	r0, [r0, #0]
c0d00d0c:	f002 fbc4 	bl	c0d03498 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00d10:	4809      	ldr	r0, [pc, #36]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00d12:	6800      	ldr	r0, [r0, #0]
c0d00d14:	490e      	ldr	r1, [pc, #56]	; (c0d00d50 <IOTA_main+0x2bc>)
c0d00d16:	f002 fbbf 	bl	c0d03498 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00d1a:	2001      	movs	r0, #1
c0d00d1c:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00d1e:	4806      	ldr	r0, [pc, #24]	; (c0d00d38 <IOTA_main+0x2a4>)
c0d00d20:	6800      	ldr	r0, [r0, #0]
c0d00d22:	3109      	adds	r1, #9
c0d00d24:	f002 fbb8 	bl	c0d03498 <longjmp>
c0d00d28:	74696157 	.word	0x74696157
c0d00d2c:	20676e69 	.word	0x20676e69
c0d00d30:	20726f66 	.word	0x20726f66
c0d00d34:	0067736d 	.word	0x0067736d
c0d00d38:	20001bb8 	.word	0x20001bb8
c0d00d3c:	0000ffff 	.word	0x0000ffff
c0d00d40:	000007ff 	.word	0x000007ff
c0d00d44:	20001c08 	.word	0x20001c08
c0d00d48:	20001b48 	.word	0x20001b48
c0d00d4c:	20001b4c 	.word	0x20001b4c
c0d00d50:	00006a86 	.word	0x00006a86
c0d00d54:	20646142 	.word	0x20646142
c0d00d58:	6b627550 	.word	0x6b627550
c0d00d5c:	00007965 	.word	0x00007965
c0d00d60:	00006982 	.word	0x00006982

c0d00d64 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00d64:	4801      	ldr	r0, [pc, #4]	; (c0d00d6c <os_boot+0x8>)
c0d00d66:	2100      	movs	r1, #0
c0d00d68:	6001      	str	r1, [r0, #0]
}
c0d00d6a:	4770      	bx	lr
c0d00d6c:	20001bb8 	.word	0x20001bb8

c0d00d70 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00d70:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d72:	af03      	add	r7, sp, #12
c0d00d74:	b083      	sub	sp, #12
c0d00d76:	9202      	str	r2, [sp, #8]
c0d00d78:	460c      	mov	r4, r1
c0d00d7a:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00d7c:	4d4a      	ldr	r5, [pc, #296]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
c0d00d7e:	42ac      	cmp	r4, r5
c0d00d80:	d00f      	beq.n	c0d00da2 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00d82:	4e49      	ldr	r6, [pc, #292]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
c0d00d84:	2540      	movs	r5, #64	; 0x40
c0d00d86:	4630      	mov	r0, r6
c0d00d88:	4629      	mov	r1, r5
c0d00d8a:	f002 fae3 	bl	c0d03354 <__aeabi_memclr>
c0d00d8e:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00d90:	2840      	cmp	r0, #64	; 0x40
c0d00d92:	4602      	mov	r2, r0
c0d00d94:	d300      	bcc.n	c0d00d98 <io_usb_hid_receive+0x28>
c0d00d96:	462a      	mov	r2, r5
c0d00d98:	4630      	mov	r0, r6
c0d00d9a:	4621      	mov	r1, r4
c0d00d9c:	f000 f89e 	bl	c0d00edc <os_memmove>
c0d00da0:	4d41      	ldr	r5, [pc, #260]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00da2:	78a8      	ldrb	r0, [r5, #2]
c0d00da4:	2805      	cmp	r0, #5
c0d00da6:	d900      	bls.n	c0d00daa <io_usb_hid_receive+0x3a>
c0d00da8:	e076      	b.n	c0d00e98 <io_usb_hid_receive+0x128>
c0d00daa:	46c0      	nop			; (mov r8, r8)
c0d00dac:	4478      	add	r0, pc
c0d00dae:	7900      	ldrb	r0, [r0, #4]
c0d00db0:	0040      	lsls	r0, r0, #1
c0d00db2:	4487      	add	pc, r0
c0d00db4:	71130c02 	.word	0x71130c02
c0d00db8:	1f71      	.short	0x1f71
c0d00dba:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00dbc:	71ae      	strb	r6, [r5, #6]
c0d00dbe:	716e      	strb	r6, [r5, #5]
c0d00dc0:	712e      	strb	r6, [r5, #4]
c0d00dc2:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00dc4:	2140      	movs	r1, #64	; 0x40
c0d00dc6:	4628      	mov	r0, r5
c0d00dc8:	9a01      	ldr	r2, [sp, #4]
c0d00dca:	4790      	blx	r2
c0d00dcc:	e00b      	b.n	c0d00de6 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00dce:	1ce8      	adds	r0, r5, #3
c0d00dd0:	2104      	movs	r1, #4
c0d00dd2:	f000 ff73 	bl	c0d01cbc <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00dd6:	2140      	movs	r1, #64	; 0x40
c0d00dd8:	4628      	mov	r0, r5
c0d00dda:	e001      	b.n	c0d00de0 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ddc:	4832      	ldr	r0, [pc, #200]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
c0d00dde:	2140      	movs	r1, #64	; 0x40
c0d00de0:	9a01      	ldr	r2, [sp, #4]
c0d00de2:	4790      	blx	r2
c0d00de4:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00de6:	4831      	ldr	r0, [pc, #196]	; (c0d00eac <io_usb_hid_receive+0x13c>)
c0d00de8:	2100      	movs	r1, #0
c0d00dea:	6001      	str	r1, [r0, #0]
c0d00dec:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00dee:	b2c0      	uxtb	r0, r0
c0d00df0:	b003      	add	sp, #12
c0d00df2:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00df4:	78e8      	ldrb	r0, [r5, #3]
c0d00df6:	4c2d      	ldr	r4, [pc, #180]	; (c0d00eac <io_usb_hid_receive+0x13c>)
c0d00df8:	6821      	ldr	r1, [r4, #0]
c0d00dfa:	0a09      	lsrs	r1, r1, #8
c0d00dfc:	2600      	movs	r6, #0
c0d00dfe:	4288      	cmp	r0, r1
c0d00e00:	d1f1      	bne.n	c0d00de6 <io_usb_hid_receive+0x76>
c0d00e02:	7928      	ldrb	r0, [r5, #4]
c0d00e04:	6821      	ldr	r1, [r4, #0]
c0d00e06:	b2c9      	uxtb	r1, r1
c0d00e08:	4288      	cmp	r0, r1
c0d00e0a:	d1ec      	bne.n	c0d00de6 <io_usb_hid_receive+0x76>
c0d00e0c:	4b28      	ldr	r3, [pc, #160]	; (c0d00eb0 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00e0e:	9802      	ldr	r0, [sp, #8]
c0d00e10:	18c0      	adds	r0, r0, r3
c0d00e12:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00e14:	6820      	ldr	r0, [r4, #0]
c0d00e16:	2800      	cmp	r0, #0
c0d00e18:	d00e      	beq.n	c0d00e38 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00e1a:	4629      	mov	r1, r5
c0d00e1c:	4019      	ands	r1, r3
c0d00e1e:	4825      	ldr	r0, [pc, #148]	; (c0d00eb4 <io_usb_hid_receive+0x144>)
c0d00e20:	6802      	ldr	r2, [r0, #0]
c0d00e22:	4291      	cmp	r1, r2
c0d00e24:	461e      	mov	r6, r3
c0d00e26:	d900      	bls.n	c0d00e2a <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00e28:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00e2a:	462a      	mov	r2, r5
c0d00e2c:	4032      	ands	r2, r6
c0d00e2e:	4822      	ldr	r0, [pc, #136]	; (c0d00eb8 <io_usb_hid_receive+0x148>)
c0d00e30:	6800      	ldr	r0, [r0, #0]
c0d00e32:	491d      	ldr	r1, [pc, #116]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
c0d00e34:	1d49      	adds	r1, r1, #5
c0d00e36:	e021      	b.n	c0d00e7c <io_usb_hid_receive+0x10c>
c0d00e38:	9301      	str	r3, [sp, #4]
c0d00e3a:	491b      	ldr	r1, [pc, #108]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00e3c:	7988      	ldrb	r0, [r1, #6]
c0d00e3e:	7949      	ldrb	r1, [r1, #5]
c0d00e40:	0209      	lsls	r1, r1, #8
c0d00e42:	4301      	orrs	r1, r0
c0d00e44:	481d      	ldr	r0, [pc, #116]	; (c0d00ebc <io_usb_hid_receive+0x14c>)
c0d00e46:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00e48:	6801      	ldr	r1, [r0, #0]
c0d00e4a:	2241      	movs	r2, #65	; 0x41
c0d00e4c:	0092      	lsls	r2, r2, #2
c0d00e4e:	4291      	cmp	r1, r2
c0d00e50:	d8c9      	bhi.n	c0d00de6 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00e52:	6801      	ldr	r1, [r0, #0]
c0d00e54:	4817      	ldr	r0, [pc, #92]	; (c0d00eb4 <io_usb_hid_receive+0x144>)
c0d00e56:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00e58:	4917      	ldr	r1, [pc, #92]	; (c0d00eb8 <io_usb_hid_receive+0x148>)
c0d00e5a:	4a19      	ldr	r2, [pc, #100]	; (c0d00ec0 <io_usb_hid_receive+0x150>)
c0d00e5c:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00e5e:	4919      	ldr	r1, [pc, #100]	; (c0d00ec4 <io_usb_hid_receive+0x154>)
c0d00e60:	9a02      	ldr	r2, [sp, #8]
c0d00e62:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00e64:	4629      	mov	r1, r5
c0d00e66:	9e01      	ldr	r6, [sp, #4]
c0d00e68:	4031      	ands	r1, r6
c0d00e6a:	6802      	ldr	r2, [r0, #0]
c0d00e6c:	4291      	cmp	r1, r2
c0d00e6e:	d900      	bls.n	c0d00e72 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00e70:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00e72:	462a      	mov	r2, r5
c0d00e74:	4032      	ands	r2, r6
c0d00e76:	480c      	ldr	r0, [pc, #48]	; (c0d00ea8 <io_usb_hid_receive+0x138>)
c0d00e78:	1dc1      	adds	r1, r0, #7
c0d00e7a:	4811      	ldr	r0, [pc, #68]	; (c0d00ec0 <io_usb_hid_receive+0x150>)
c0d00e7c:	f000 f82e 	bl	c0d00edc <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00e80:	4035      	ands	r5, r6
c0d00e82:	480d      	ldr	r0, [pc, #52]	; (c0d00eb8 <io_usb_hid_receive+0x148>)
c0d00e84:	6801      	ldr	r1, [r0, #0]
c0d00e86:	1949      	adds	r1, r1, r5
c0d00e88:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00e8a:	480a      	ldr	r0, [pc, #40]	; (c0d00eb4 <io_usb_hid_receive+0x144>)
c0d00e8c:	6801      	ldr	r1, [r0, #0]
c0d00e8e:	1b49      	subs	r1, r1, r5
c0d00e90:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00e92:	6820      	ldr	r0, [r4, #0]
c0d00e94:	1c40      	adds	r0, r0, #1
c0d00e96:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00e98:	4806      	ldr	r0, [pc, #24]	; (c0d00eb4 <io_usb_hid_receive+0x144>)
c0d00e9a:	6801      	ldr	r1, [r0, #0]
c0d00e9c:	2001      	movs	r0, #1
c0d00e9e:	2602      	movs	r6, #2
c0d00ea0:	2900      	cmp	r1, #0
c0d00ea2:	d1a4      	bne.n	c0d00dee <io_usb_hid_receive+0x7e>
c0d00ea4:	e79f      	b.n	c0d00de6 <io_usb_hid_receive+0x76>
c0d00ea6:	46c0      	nop			; (mov r8, r8)
c0d00ea8:	20001bbc 	.word	0x20001bbc
c0d00eac:	20001bfc 	.word	0x20001bfc
c0d00eb0:	0000ffff 	.word	0x0000ffff
c0d00eb4:	20001c04 	.word	0x20001c04
c0d00eb8:	20001d0c 	.word	0x20001d0c
c0d00ebc:	20001c00 	.word	0x20001c00
c0d00ec0:	20001c08 	.word	0x20001c08
c0d00ec4:	0001fff9 	.word	0x0001fff9

c0d00ec8 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00ec8:	b580      	push	{r7, lr}
c0d00eca:	af00      	add	r7, sp, #0
c0d00ecc:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00ece:	2a00      	cmp	r2, #0
c0d00ed0:	d003      	beq.n	c0d00eda <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00ed2:	4611      	mov	r1, r2
c0d00ed4:	461a      	mov	r2, r3
c0d00ed6:	f002 fa47 	bl	c0d03368 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00eda:	bd80      	pop	{r7, pc}

c0d00edc <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00edc:	b5b0      	push	{r4, r5, r7, lr}
c0d00ede:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00ee0:	4288      	cmp	r0, r1
c0d00ee2:	d90d      	bls.n	c0d00f00 <os_memmove+0x24>
    while(length--) {
c0d00ee4:	2a00      	cmp	r2, #0
c0d00ee6:	d014      	beq.n	c0d00f12 <os_memmove+0x36>
c0d00ee8:	1e49      	subs	r1, r1, #1
c0d00eea:	4252      	negs	r2, r2
c0d00eec:	1e40      	subs	r0, r0, #1
c0d00eee:	2300      	movs	r3, #0
c0d00ef0:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00ef2:	461c      	mov	r4, r3
c0d00ef4:	4354      	muls	r4, r2
c0d00ef6:	5d0d      	ldrb	r5, [r1, r4]
c0d00ef8:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00efa:	1c52      	adds	r2, r2, #1
c0d00efc:	d1f9      	bne.n	c0d00ef2 <os_memmove+0x16>
c0d00efe:	e008      	b.n	c0d00f12 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00f00:	2a00      	cmp	r2, #0
c0d00f02:	d006      	beq.n	c0d00f12 <os_memmove+0x36>
c0d00f04:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00f06:	b29c      	uxth	r4, r3
c0d00f08:	5d0d      	ldrb	r5, [r1, r4]
c0d00f0a:	5505      	strb	r5, [r0, r4]
      l++;
c0d00f0c:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00f0e:	1e52      	subs	r2, r2, #1
c0d00f10:	d1f9      	bne.n	c0d00f06 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00f12:	bdb0      	pop	{r4, r5, r7, pc}

c0d00f14 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00f14:	4801      	ldr	r0, [pc, #4]	; (c0d00f1c <io_usb_hid_init+0x8>)
c0d00f16:	2100      	movs	r1, #0
c0d00f18:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00f1a:	4770      	bx	lr
c0d00f1c:	20001bfc 	.word	0x20001bfc

c0d00f20 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00f20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f22:	af03      	add	r7, sp, #12
c0d00f24:	b087      	sub	sp, #28
c0d00f26:	9301      	str	r3, [sp, #4]
c0d00f28:	9203      	str	r2, [sp, #12]
c0d00f2a:	460e      	mov	r6, r1
c0d00f2c:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00f2e:	2e00      	cmp	r6, #0
c0d00f30:	d042      	beq.n	c0d00fb8 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00f32:	4d31      	ldr	r5, [pc, #196]	; (c0d00ff8 <io_usb_hid_exchange+0xd8>)
c0d00f34:	2000      	movs	r0, #0
c0d00f36:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00f38:	4930      	ldr	r1, [pc, #192]	; (c0d00ffc <io_usb_hid_exchange+0xdc>)
c0d00f3a:	4831      	ldr	r0, [pc, #196]	; (c0d01000 <io_usb_hid_exchange+0xe0>)
c0d00f3c:	6008      	str	r0, [r1, #0]
c0d00f3e:	4c31      	ldr	r4, [pc, #196]	; (c0d01004 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00f40:	1d60      	adds	r0, r4, #5
c0d00f42:	213b      	movs	r1, #59	; 0x3b
c0d00f44:	9005      	str	r0, [sp, #20]
c0d00f46:	9102      	str	r1, [sp, #8]
c0d00f48:	f002 fa04 	bl	c0d03354 <__aeabi_memclr>
c0d00f4c:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00f4e:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00f50:	6828      	ldr	r0, [r5, #0]
c0d00f52:	0a00      	lsrs	r0, r0, #8
c0d00f54:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00f56:	6828      	ldr	r0, [r5, #0]
c0d00f58:	7120      	strb	r0, [r4, #4]
c0d00f5a:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00f5c:	6828      	ldr	r0, [r5, #0]
c0d00f5e:	2800      	cmp	r0, #0
c0d00f60:	9106      	str	r1, [sp, #24]
c0d00f62:	d009      	beq.n	c0d00f78 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00f64:	293b      	cmp	r1, #59	; 0x3b
c0d00f66:	460a      	mov	r2, r1
c0d00f68:	d300      	bcc.n	c0d00f6c <io_usb_hid_exchange+0x4c>
c0d00f6a:	9a02      	ldr	r2, [sp, #8]
c0d00f6c:	4823      	ldr	r0, [pc, #140]	; (c0d00ffc <io_usb_hid_exchange+0xdc>)
c0d00f6e:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00f70:	6819      	ldr	r1, [r3, #0]
c0d00f72:	9805      	ldr	r0, [sp, #20]
c0d00f74:	461e      	mov	r6, r3
c0d00f76:	e00a      	b.n	c0d00f8e <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00f78:	0a30      	lsrs	r0, r6, #8
c0d00f7a:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00f7c:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00f7e:	2039      	movs	r0, #57	; 0x39
c0d00f80:	2939      	cmp	r1, #57	; 0x39
c0d00f82:	460a      	mov	r2, r1
c0d00f84:	d300      	bcc.n	c0d00f88 <io_usb_hid_exchange+0x68>
c0d00f86:	4602      	mov	r2, r0
c0d00f88:	4e1c      	ldr	r6, [pc, #112]	; (c0d00ffc <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00f8a:	6831      	ldr	r1, [r6, #0]
c0d00f8c:	1de0      	adds	r0, r4, #7
c0d00f8e:	9205      	str	r2, [sp, #20]
c0d00f90:	f7ff ffa4 	bl	c0d00edc <os_memmove>
c0d00f94:	4d18      	ldr	r5, [pc, #96]	; (c0d00ff8 <io_usb_hid_exchange+0xd8>)
c0d00f96:	6830      	ldr	r0, [r6, #0]
c0d00f98:	4631      	mov	r1, r6
c0d00f9a:	9e05      	ldr	r6, [sp, #20]
c0d00f9c:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00f9e:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00fa0:	6828      	ldr	r0, [r5, #0]
c0d00fa2:	1c40      	adds	r0, r0, #1
c0d00fa4:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00fa6:	2140      	movs	r1, #64	; 0x40
c0d00fa8:	4620      	mov	r0, r4
c0d00faa:	9a04      	ldr	r2, [sp, #16]
c0d00fac:	4790      	blx	r2
c0d00fae:	9806      	ldr	r0, [sp, #24]
c0d00fb0:	1b86      	subs	r6, r0, r6
c0d00fb2:	4815      	ldr	r0, [pc, #84]	; (c0d01008 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00fb4:	4206      	tst	r6, r0
c0d00fb6:	d1c3      	bne.n	c0d00f40 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00fb8:	480f      	ldr	r0, [pc, #60]	; (c0d00ff8 <io_usb_hid_exchange+0xd8>)
c0d00fba:	2400      	movs	r4, #0
c0d00fbc:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00fbe:	2080      	movs	r0, #128	; 0x80
c0d00fc0:	9901      	ldr	r1, [sp, #4]
c0d00fc2:	4201      	tst	r1, r0
c0d00fc4:	d001      	beq.n	c0d00fca <io_usb_hid_exchange+0xaa>
    reset();
c0d00fc6:	f000 fe3f 	bl	c0d01c48 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00fca:	9801      	ldr	r0, [sp, #4]
c0d00fcc:	0680      	lsls	r0, r0, #26
c0d00fce:	d40f      	bmi.n	c0d00ff0 <io_usb_hid_exchange+0xd0>
c0d00fd0:	4c0c      	ldr	r4, [pc, #48]	; (c0d01004 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00fd2:	2140      	movs	r1, #64	; 0x40
c0d00fd4:	4620      	mov	r0, r4
c0d00fd6:	9a03      	ldr	r2, [sp, #12]
c0d00fd8:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00fda:	b2c2      	uxtb	r2, r0
c0d00fdc:	2a40      	cmp	r2, #64	; 0x40
c0d00fde:	d8f8      	bhi.n	c0d00fd2 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00fe0:	9804      	ldr	r0, [sp, #16]
c0d00fe2:	4621      	mov	r1, r4
c0d00fe4:	f7ff fec4 	bl	c0d00d70 <io_usb_hid_receive>
c0d00fe8:	2802      	cmp	r0, #2
c0d00fea:	d1f2      	bne.n	c0d00fd2 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00fec:	4807      	ldr	r0, [pc, #28]	; (c0d0100c <io_usb_hid_exchange+0xec>)
c0d00fee:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00ff0:	b2a0      	uxth	r0, r4
c0d00ff2:	b007      	add	sp, #28
c0d00ff4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ff6:	46c0      	nop			; (mov r8, r8)
c0d00ff8:	20001bfc 	.word	0x20001bfc
c0d00ffc:	20001d0c 	.word	0x20001d0c
c0d01000:	20001c08 	.word	0x20001c08
c0d01004:	20001bbc 	.word	0x20001bbc
c0d01008:	0000ffff 	.word	0x0000ffff
c0d0100c:	20001c00 	.word	0x20001c00

c0d01010 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01010:	b580      	push	{r7, lr}
c0d01012:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01014:	f000 ffbc 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d01018:	2800      	cmp	r0, #0
c0d0101a:	d10b      	bne.n	c0d01034 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d0101c:	4806      	ldr	r0, [pc, #24]	; (c0d01038 <io_seproxyhal_general_status+0x28>)
c0d0101e:	2160      	movs	r1, #96	; 0x60
c0d01020:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01022:	2100      	movs	r1, #0
c0d01024:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01026:	2202      	movs	r2, #2
c0d01028:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0102a:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d0102c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0102e:	2105      	movs	r1, #5
c0d01030:	f000 ff90 	bl	c0d01f54 <io_seproxyhal_spi_send>
}
c0d01034:	bd80      	pop	{r7, pc}
c0d01036:	46c0      	nop			; (mov r8, r8)
c0d01038:	20001a18 	.word	0x20001a18

c0d0103c <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d0103c:	b5d0      	push	{r4, r6, r7, lr}
c0d0103e:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01040:	4815      	ldr	r0, [pc, #84]	; (c0d01098 <io_seproxyhal_handle_usb_event+0x5c>)
c0d01042:	78c0      	ldrb	r0, [r0, #3]
c0d01044:	1e40      	subs	r0, r0, #1
c0d01046:	2807      	cmp	r0, #7
c0d01048:	d824      	bhi.n	c0d01094 <io_seproxyhal_handle_usb_event+0x58>
c0d0104a:	46c0      	nop			; (mov r8, r8)
c0d0104c:	4478      	add	r0, pc
c0d0104e:	7900      	ldrb	r0, [r0, #4]
c0d01050:	0040      	lsls	r0, r0, #1
c0d01052:	4487      	add	pc, r0
c0d01054:	141f1803 	.word	0x141f1803
c0d01058:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d0105c:	4c0f      	ldr	r4, [pc, #60]	; (c0d0109c <io_seproxyhal_handle_usb_event+0x60>)
c0d0105e:	2101      	movs	r1, #1
c0d01060:	4620      	mov	r0, r4
c0d01062:	f001 fbd5 	bl	c0d02810 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01066:	4620      	mov	r0, r4
c0d01068:	f001 fbba 	bl	c0d027e0 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d0106c:	480c      	ldr	r0, [pc, #48]	; (c0d010a0 <io_seproxyhal_handle_usb_event+0x64>)
c0d0106e:	7800      	ldrb	r0, [r0, #0]
c0d01070:	2801      	cmp	r0, #1
c0d01072:	d10f      	bne.n	c0d01094 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d01074:	480b      	ldr	r0, [pc, #44]	; (c0d010a4 <io_seproxyhal_handle_usb_event+0x68>)
c0d01076:	6800      	ldr	r0, [r0, #0]
c0d01078:	2110      	movs	r1, #16
c0d0107a:	f002 fa0d 	bl	c0d03498 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d0107e:	4807      	ldr	r0, [pc, #28]	; (c0d0109c <io_seproxyhal_handle_usb_event+0x60>)
c0d01080:	f001 fbc9 	bl	c0d02816 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01084:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d01086:	4805      	ldr	r0, [pc, #20]	; (c0d0109c <io_seproxyhal_handle_usb_event+0x60>)
c0d01088:	f001 fbc9 	bl	c0d0281e <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d0108c:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d0108e:	4803      	ldr	r0, [pc, #12]	; (c0d0109c <io_seproxyhal_handle_usb_event+0x60>)
c0d01090:	f001 fbc3 	bl	c0d0281a <USBD_LL_Resume>
      break;
  }
}
c0d01094:	bdd0      	pop	{r4, r6, r7, pc}
c0d01096:	46c0      	nop			; (mov r8, r8)
c0d01098:	20001a18 	.word	0x20001a18
c0d0109c:	20001d34 	.word	0x20001d34
c0d010a0:	20001d10 	.word	0x20001d10
c0d010a4:	20001bb8 	.word	0x20001bb8

c0d010a8 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d010a8:	217f      	movs	r1, #127	; 0x7f
c0d010aa:	4001      	ands	r1, r0
c0d010ac:	4801      	ldr	r0, [pc, #4]	; (c0d010b4 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d010ae:	5c40      	ldrb	r0, [r0, r1]
c0d010b0:	4770      	bx	lr
c0d010b2:	46c0      	nop			; (mov r8, r8)
c0d010b4:	20001d11 	.word	0x20001d11

c0d010b8 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d010b8:	b580      	push	{r7, lr}
c0d010ba:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d010bc:	480f      	ldr	r0, [pc, #60]	; (c0d010fc <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d010be:	7901      	ldrb	r1, [r0, #4]
c0d010c0:	2904      	cmp	r1, #4
c0d010c2:	d008      	beq.n	c0d010d6 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d010c4:	2902      	cmp	r1, #2
c0d010c6:	d011      	beq.n	c0d010ec <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d010c8:	2901      	cmp	r1, #1
c0d010ca:	d10e      	bne.n	c0d010ea <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d010cc:	1d81      	adds	r1, r0, #6
c0d010ce:	480d      	ldr	r0, [pc, #52]	; (c0d01104 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d010d0:	f001 faaa 	bl	c0d02628 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d010d4:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d010d6:	78c2      	ldrb	r2, [r0, #3]
c0d010d8:	217f      	movs	r1, #127	; 0x7f
c0d010da:	4011      	ands	r1, r2
c0d010dc:	7942      	ldrb	r2, [r0, #5]
c0d010de:	4b08      	ldr	r3, [pc, #32]	; (c0d01100 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d010e0:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d010e2:	1d82      	adds	r2, r0, #6
c0d010e4:	4807      	ldr	r0, [pc, #28]	; (c0d01104 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d010e6:	f001 fad1 	bl	c0d0268c <USBD_LL_DataOutStage>
      break;
  }
}
c0d010ea:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d010ec:	78c2      	ldrb	r2, [r0, #3]
c0d010ee:	217f      	movs	r1, #127	; 0x7f
c0d010f0:	4011      	ands	r1, r2
c0d010f2:	1d82      	adds	r2, r0, #6
c0d010f4:	4803      	ldr	r0, [pc, #12]	; (c0d01104 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d010f6:	f001 fb0f 	bl	c0d02718 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d010fa:	bd80      	pop	{r7, pc}
c0d010fc:	20001a18 	.word	0x20001a18
c0d01100:	20001d11 	.word	0x20001d11
c0d01104:	20001d34 	.word	0x20001d34

c0d01108 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01108:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0110a:	af03      	add	r7, sp, #12
c0d0110c:	b083      	sub	sp, #12
c0d0110e:	9201      	str	r2, [sp, #4]
c0d01110:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01112:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01114:	2b00      	cmp	r3, #0
c0d01116:	d100      	bne.n	c0d0111a <io_usb_send_ep+0x12>
c0d01118:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0111a:	9801      	ldr	r0, [sp, #4]
c0d0111c:	28ff      	cmp	r0, #255	; 0xff
c0d0111e:	d843      	bhi.n	c0d011a8 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01120:	4e25      	ldr	r6, [pc, #148]	; (c0d011b8 <io_usb_send_ep+0xb0>)
c0d01122:	2050      	movs	r0, #80	; 0x50
c0d01124:	7030      	strb	r0, [r6, #0]
c0d01126:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01128:	1ce0      	adds	r0, r4, #3
c0d0112a:	9100      	str	r1, [sp, #0]
c0d0112c:	0a01      	lsrs	r1, r0, #8
c0d0112e:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01130:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01132:	2080      	movs	r0, #128	; 0x80
c0d01134:	4302      	orrs	r2, r0
c0d01136:	9202      	str	r2, [sp, #8]
c0d01138:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0113a:	2020      	movs	r0, #32
c0d0113c:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0113e:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01140:	2106      	movs	r1, #6
c0d01142:	4630      	mov	r0, r6
c0d01144:	f000 ff06 	bl	c0d01f54 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01148:	9800      	ldr	r0, [sp, #0]
c0d0114a:	4621      	mov	r1, r4
c0d0114c:	f000 ff02 	bl	c0d01f54 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01150:	2d00      	cmp	r5, #0
c0d01152:	d10d      	bne.n	c0d01170 <io_usb_send_ep+0x68>
c0d01154:	e028      	b.n	c0d011a8 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d01156:	2d00      	cmp	r5, #0
c0d01158:	d002      	beq.n	c0d01160 <io_usb_send_ep+0x58>
c0d0115a:	1e6c      	subs	r4, r5, #1
c0d0115c:	2d01      	cmp	r5, #1
c0d0115e:	d025      	beq.n	c0d011ac <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01160:	2915      	cmp	r1, #21
c0d01162:	d102      	bne.n	c0d0116a <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01164:	79b0      	ldrb	r0, [r6, #6]
c0d01166:	0700      	lsls	r0, r0, #28
c0d01168:	d520      	bpl.n	c0d011ac <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0116a:	f000 f829 	bl	c0d011c0 <io_seproxyhal_handle_event>
c0d0116e:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01170:	f000 ff0e 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d01174:	2800      	cmp	r0, #0
c0d01176:	d101      	bne.n	c0d0117c <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01178:	f7ff ff4a 	bl	c0d01010 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0117c:	2180      	movs	r1, #128	; 0x80
c0d0117e:	2400      	movs	r4, #0
c0d01180:	4630      	mov	r0, r6
c0d01182:	4622      	mov	r2, r4
c0d01184:	f000 ff20 	bl	c0d01fc8 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01188:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d0118a:	2806      	cmp	r0, #6
c0d0118c:	d1e3      	bne.n	c0d01156 <io_usb_send_ep+0x4e>
c0d0118e:	2910      	cmp	r1, #16
c0d01190:	d1e1      	bne.n	c0d01156 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d01192:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01194:	9a02      	ldr	r2, [sp, #8]
c0d01196:	4290      	cmp	r0, r2
c0d01198:	d1dd      	bne.n	c0d01156 <io_usb_send_ep+0x4e>
c0d0119a:	7930      	ldrb	r0, [r6, #4]
c0d0119c:	2802      	cmp	r0, #2
c0d0119e:	d1da      	bne.n	c0d01156 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d011a0:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d011a2:	9a01      	ldr	r2, [sp, #4]
c0d011a4:	4290      	cmp	r0, r2
c0d011a6:	d1d6      	bne.n	c0d01156 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d011a8:	b003      	add	sp, #12
c0d011aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d011ac:	4803      	ldr	r0, [pc, #12]	; (c0d011bc <io_usb_send_ep+0xb4>)
c0d011ae:	6800      	ldr	r0, [r0, #0]
c0d011b0:	2110      	movs	r1, #16
c0d011b2:	f002 f971 	bl	c0d03498 <longjmp>
c0d011b6:	46c0      	nop			; (mov r8, r8)
c0d011b8:	20001a18 	.word	0x20001a18
c0d011bc:	20001bb8 	.word	0x20001bb8

c0d011c0 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d011c0:	b580      	push	{r7, lr}
c0d011c2:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d011c4:	480d      	ldr	r0, [pc, #52]	; (c0d011fc <io_seproxyhal_handle_event+0x3c>)
c0d011c6:	7882      	ldrb	r2, [r0, #2]
c0d011c8:	7841      	ldrb	r1, [r0, #1]
c0d011ca:	0209      	lsls	r1, r1, #8
c0d011cc:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d011ce:	7800      	ldrb	r0, [r0, #0]
c0d011d0:	2810      	cmp	r0, #16
c0d011d2:	d008      	beq.n	c0d011e6 <io_seproxyhal_handle_event+0x26>
c0d011d4:	280f      	cmp	r0, #15
c0d011d6:	d10d      	bne.n	c0d011f4 <io_seproxyhal_handle_event+0x34>
c0d011d8:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d011da:	2904      	cmp	r1, #4
c0d011dc:	d10d      	bne.n	c0d011fa <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d011de:	f7ff ff2d 	bl	c0d0103c <io_seproxyhal_handle_usb_event>
c0d011e2:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d011e4:	bd80      	pop	{r7, pc}
c0d011e6:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d011e8:	2906      	cmp	r1, #6
c0d011ea:	d306      	bcc.n	c0d011fa <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d011ec:	f7ff ff64 	bl	c0d010b8 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d011f0:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d011f2:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d011f4:	2002      	movs	r0, #2
c0d011f6:	f7ff faf5 	bl	c0d007e4 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d011fa:	bd80      	pop	{r7, pc}
c0d011fc:	20001a18 	.word	0x20001a18

c0d01200 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01200:	b580      	push	{r7, lr}
c0d01202:	af00      	add	r7, sp, #0
c0d01204:	460a      	mov	r2, r1
c0d01206:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01208:	2082      	movs	r0, #130	; 0x82
c0d0120a:	2314      	movs	r3, #20
c0d0120c:	f7ff ff7c 	bl	c0d01108 <io_usb_send_ep>
}
c0d01210:	bd80      	pop	{r7, pc}
	...

c0d01214 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01214:	b5d0      	push	{r4, r6, r7, lr}
c0d01216:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01218:	2007      	movs	r0, #7
c0d0121a:	f000 fcf7 	bl	c0d01c0c <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0121e:	480a      	ldr	r0, [pc, #40]	; (c0d01248 <io_seproxyhal_init+0x34>)
c0d01220:	2400      	movs	r4, #0
c0d01222:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01224:	4809      	ldr	r0, [pc, #36]	; (c0d0124c <io_seproxyhal_init+0x38>)
c0d01226:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01228:	4809      	ldr	r0, [pc, #36]	; (c0d01250 <io_seproxyhal_init+0x3c>)
c0d0122a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d0122c:	4809      	ldr	r0, [pc, #36]	; (c0d01254 <io_seproxyhal_init+0x40>)
c0d0122e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01230:	4809      	ldr	r0, [pc, #36]	; (c0d01258 <io_seproxyhal_init+0x44>)
c0d01232:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01234:	f7ff fe6e 	bl	c0d00f14 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01238:	4808      	ldr	r0, [pc, #32]	; (c0d0125c <io_seproxyhal_init+0x48>)
c0d0123a:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d0123c:	4808      	ldr	r0, [pc, #32]	; (c0d01260 <io_seproxyhal_init+0x4c>)
c0d0123e:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01240:	4808      	ldr	r0, [pc, #32]	; (c0d01264 <io_seproxyhal_init+0x50>)
c0d01242:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01244:	bdd0      	pop	{r4, r6, r7, pc}
c0d01246:	46c0      	nop			; (mov r8, r8)
c0d01248:	20001d18 	.word	0x20001d18
c0d0124c:	20001d1a 	.word	0x20001d1a
c0d01250:	20001d1c 	.word	0x20001d1c
c0d01254:	20001d1e 	.word	0x20001d1e
c0d01258:	20001d10 	.word	0x20001d10
c0d0125c:	20001d20 	.word	0x20001d20
c0d01260:	20001d24 	.word	0x20001d24
c0d01264:	20001d28 	.word	0x20001d28

c0d01268 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01268:	4801      	ldr	r0, [pc, #4]	; (c0d01270 <io_seproxyhal_init_ux+0x8>)
c0d0126a:	2100      	movs	r1, #0
c0d0126c:	6001      	str	r1, [r0, #0]

}
c0d0126e:	4770      	bx	lr
c0d01270:	20001d20 	.word	0x20001d20

c0d01274 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01274:	b5b0      	push	{r4, r5, r7, lr}
c0d01276:	af02      	add	r7, sp, #8
c0d01278:	460d      	mov	r5, r1
c0d0127a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d0127c:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d0127e:	2800      	cmp	r0, #0
c0d01280:	d00c      	beq.n	c0d0129c <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d01282:	f000 fcab 	bl	c0d01bdc <pic>
c0d01286:	4601      	mov	r1, r0
c0d01288:	4620      	mov	r0, r4
c0d0128a:	4788      	blx	r1
c0d0128c:	f000 fca6 	bl	c0d01bdc <pic>
c0d01290:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d01292:	2800      	cmp	r0, #0
c0d01294:	d010      	beq.n	c0d012b8 <io_seproxyhal_touch_out+0x44>
c0d01296:	2801      	cmp	r0, #1
c0d01298:	d000      	beq.n	c0d0129c <io_seproxyhal_touch_out+0x28>
c0d0129a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0129c:	2d00      	cmp	r5, #0
c0d0129e:	d007      	beq.n	c0d012b0 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d012a0:	4620      	mov	r0, r4
c0d012a2:	47a8      	blx	r5
c0d012a4:	2100      	movs	r1, #0
    if (!el) {
c0d012a6:	2800      	cmp	r0, #0
c0d012a8:	d006      	beq.n	c0d012b8 <io_seproxyhal_touch_out+0x44>
c0d012aa:	2801      	cmp	r0, #1
c0d012ac:	d000      	beq.n	c0d012b0 <io_seproxyhal_touch_out+0x3c>
c0d012ae:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d012b0:	4620      	mov	r0, r4
c0d012b2:	f7ff fa91 	bl	c0d007d8 <io_seproxyhal_display>
c0d012b6:	2101      	movs	r1, #1
  return 1;
}
c0d012b8:	4608      	mov	r0, r1
c0d012ba:	bdb0      	pop	{r4, r5, r7, pc}

c0d012bc <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d012bc:	b5b0      	push	{r4, r5, r7, lr}
c0d012be:	af02      	add	r7, sp, #8
c0d012c0:	b08e      	sub	sp, #56	; 0x38
c0d012c2:	460c      	mov	r4, r1
c0d012c4:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d012c6:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d012c8:	2800      	cmp	r0, #0
c0d012ca:	d00c      	beq.n	c0d012e6 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d012cc:	f000 fc86 	bl	c0d01bdc <pic>
c0d012d0:	4601      	mov	r1, r0
c0d012d2:	4628      	mov	r0, r5
c0d012d4:	4788      	blx	r1
c0d012d6:	f000 fc81 	bl	c0d01bdc <pic>
c0d012da:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d012dc:	2800      	cmp	r0, #0
c0d012de:	d016      	beq.n	c0d0130e <io_seproxyhal_touch_over+0x52>
c0d012e0:	2801      	cmp	r0, #1
c0d012e2:	d000      	beq.n	c0d012e6 <io_seproxyhal_touch_over+0x2a>
c0d012e4:	4605      	mov	r5, r0
c0d012e6:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d012e8:	2238      	movs	r2, #56	; 0x38
c0d012ea:	4629      	mov	r1, r5
c0d012ec:	f7ff fdf6 	bl	c0d00edc <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d012f0:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d012f2:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d012f4:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d012f6:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d012f8:	2c00      	cmp	r4, #0
c0d012fa:	d004      	beq.n	c0d01306 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d012fc:	4628      	mov	r0, r5
c0d012fe:	47a0      	blx	r4
c0d01300:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01302:	2800      	cmp	r0, #0
c0d01304:	d003      	beq.n	c0d0130e <io_seproxyhal_touch_over+0x52>
c0d01306:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01308:	f7ff fa66 	bl	c0d007d8 <io_seproxyhal_display>
c0d0130c:	2101      	movs	r1, #1
  return 1;
}
c0d0130e:	4608      	mov	r0, r1
c0d01310:	b00e      	add	sp, #56	; 0x38
c0d01312:	bdb0      	pop	{r4, r5, r7, pc}

c0d01314 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01314:	b5b0      	push	{r4, r5, r7, lr}
c0d01316:	af02      	add	r7, sp, #8
c0d01318:	460d      	mov	r5, r1
c0d0131a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d0131c:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0131e:	2800      	cmp	r0, #0
c0d01320:	d00c      	beq.n	c0d0133c <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01322:	f000 fc5b 	bl	c0d01bdc <pic>
c0d01326:	4601      	mov	r1, r0
c0d01328:	4620      	mov	r0, r4
c0d0132a:	4788      	blx	r1
c0d0132c:	f000 fc56 	bl	c0d01bdc <pic>
c0d01330:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01332:	2800      	cmp	r0, #0
c0d01334:	d010      	beq.n	c0d01358 <io_seproxyhal_touch_tap+0x44>
c0d01336:	2801      	cmp	r0, #1
c0d01338:	d000      	beq.n	c0d0133c <io_seproxyhal_touch_tap+0x28>
c0d0133a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0133c:	2d00      	cmp	r5, #0
c0d0133e:	d007      	beq.n	c0d01350 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01340:	4620      	mov	r0, r4
c0d01342:	47a8      	blx	r5
c0d01344:	2100      	movs	r1, #0
    if (!el) {
c0d01346:	2800      	cmp	r0, #0
c0d01348:	d006      	beq.n	c0d01358 <io_seproxyhal_touch_tap+0x44>
c0d0134a:	2801      	cmp	r0, #1
c0d0134c:	d000      	beq.n	c0d01350 <io_seproxyhal_touch_tap+0x3c>
c0d0134e:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01350:	4620      	mov	r0, r4
c0d01352:	f7ff fa41 	bl	c0d007d8 <io_seproxyhal_display>
c0d01356:	2101      	movs	r1, #1
  return 1;
}
c0d01358:	4608      	mov	r0, r1
c0d0135a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0135c <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d0135c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0135e:	af03      	add	r7, sp, #12
c0d01360:	b087      	sub	sp, #28
c0d01362:	9302      	str	r3, [sp, #8]
c0d01364:	9203      	str	r2, [sp, #12]
c0d01366:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01368:	2900      	cmp	r1, #0
c0d0136a:	d076      	beq.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
c0d0136c:	9004      	str	r0, [sp, #16]
c0d0136e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01370:	9001      	str	r0, [sp, #4]
c0d01372:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01374:	9000      	str	r0, [sp, #0]
c0d01376:	2600      	movs	r6, #0
c0d01378:	9606      	str	r6, [sp, #24]
c0d0137a:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0137c:	f000 fe08 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d01380:	2800      	cmp	r0, #0
c0d01382:	d155      	bne.n	c0d01430 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d01384:	2038      	movs	r0, #56	; 0x38
c0d01386:	4370      	muls	r0, r6
c0d01388:	9d04      	ldr	r5, [sp, #16]
c0d0138a:	182e      	adds	r6, r5, r0
c0d0138c:	4b36      	ldr	r3, [pc, #216]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0138e:	681a      	ldr	r2, [r3, #0]
c0d01390:	2101      	movs	r1, #1
c0d01392:	4296      	cmp	r6, r2
c0d01394:	d000      	beq.n	c0d01398 <io_seproxyhal_touch_element_callback+0x3c>
c0d01396:	9906      	ldr	r1, [sp, #24]
c0d01398:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0139a:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d0139c:	2800      	cmp	r0, #0
c0d0139e:	da41      	bge.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
c0d013a0:	2020      	movs	r0, #32
c0d013a2:	5c35      	ldrb	r5, [r6, r0]
c0d013a4:	2102      	movs	r1, #2
c0d013a6:	5e71      	ldrsh	r1, [r6, r1]
c0d013a8:	1b4a      	subs	r2, r1, r5
c0d013aa:	9803      	ldr	r0, [sp, #12]
c0d013ac:	4282      	cmp	r2, r0
c0d013ae:	dc39      	bgt.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
c0d013b0:	1869      	adds	r1, r5, r1
c0d013b2:	88f2      	ldrh	r2, [r6, #6]
c0d013b4:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d013b6:	9803      	ldr	r0, [sp, #12]
c0d013b8:	4288      	cmp	r0, r1
c0d013ba:	da33      	bge.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
c0d013bc:	2104      	movs	r1, #4
c0d013be:	5e70      	ldrsh	r0, [r6, r1]
c0d013c0:	1b42      	subs	r2, r0, r5
c0d013c2:	9902      	ldr	r1, [sp, #8]
c0d013c4:	428a      	cmp	r2, r1
c0d013c6:	dc2d      	bgt.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
c0d013c8:	1940      	adds	r0, r0, r5
c0d013ca:	8931      	ldrh	r1, [r6, #8]
c0d013cc:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d013ce:	9902      	ldr	r1, [sp, #8]
c0d013d0:	4281      	cmp	r1, r0
c0d013d2:	da27      	bge.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d013d4:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d013d6:	4286      	cmp	r6, r0
c0d013d8:	d010      	beq.n	c0d013fc <io_seproxyhal_touch_element_callback+0xa0>
c0d013da:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d013dc:	2800      	cmp	r0, #0
c0d013de:	d00d      	beq.n	c0d013fc <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d013e0:	9801      	ldr	r0, [sp, #4]
c0d013e2:	2800      	cmp	r0, #0
c0d013e4:	d005      	beq.n	c0d013f2 <io_seproxyhal_touch_element_callback+0x96>
c0d013e6:	4630      	mov	r0, r6
c0d013e8:	9901      	ldr	r1, [sp, #4]
c0d013ea:	4788      	blx	r1
c0d013ec:	4b1e      	ldr	r3, [pc, #120]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d013ee:	2800      	cmp	r0, #0
c0d013f0:	d018      	beq.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d013f2:	6818      	ldr	r0, [r3, #0]
c0d013f4:	9901      	ldr	r1, [sp, #4]
c0d013f6:	f7ff ff3d 	bl	c0d01274 <io_seproxyhal_touch_out>
c0d013fa:	e008      	b.n	c0d0140e <io_seproxyhal_touch_element_callback+0xb2>
c0d013fc:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d013fe:	2801      	cmp	r0, #1
c0d01400:	d009      	beq.n	c0d01416 <io_seproxyhal_touch_element_callback+0xba>
c0d01402:	2802      	cmp	r0, #2
c0d01404:	d10e      	bne.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01406:	4630      	mov	r0, r6
c0d01408:	9901      	ldr	r1, [sp, #4]
c0d0140a:	f7ff ff83 	bl	c0d01314 <io_seproxyhal_touch_tap>
c0d0140e:	4b16      	ldr	r3, [pc, #88]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01410:	2800      	cmp	r0, #0
c0d01412:	d007      	beq.n	c0d01424 <io_seproxyhal_touch_element_callback+0xc8>
c0d01414:	e023      	b.n	c0d0145e <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01416:	4630      	mov	r0, r6
c0d01418:	9901      	ldr	r1, [sp, #4]
c0d0141a:	f7ff ff4f 	bl	c0d012bc <io_seproxyhal_touch_over>
c0d0141e:	4b12      	ldr	r3, [pc, #72]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01420:	2800      	cmp	r0, #0
c0d01422:	d11f      	bne.n	c0d01464 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01424:	1c64      	adds	r4, r4, #1
c0d01426:	b2e6      	uxtb	r6, r4
c0d01428:	9805      	ldr	r0, [sp, #20]
c0d0142a:	4286      	cmp	r6, r0
c0d0142c:	d3a6      	bcc.n	c0d0137c <io_seproxyhal_touch_element_callback+0x20>
c0d0142e:	e000      	b.n	c0d01432 <io_seproxyhal_touch_element_callback+0xd6>
c0d01430:	4b0d      	ldr	r3, [pc, #52]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01432:	9806      	ldr	r0, [sp, #24]
c0d01434:	0600      	lsls	r0, r0, #24
c0d01436:	d010      	beq.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
c0d01438:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0143a:	2800      	cmp	r0, #0
c0d0143c:	d00d      	beq.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0143e:	f000 fda7 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d01442:	4909      	ldr	r1, [pc, #36]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01444:	2800      	cmp	r0, #0
c0d01446:	d108      	bne.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01448:	6808      	ldr	r0, [r1, #0]
c0d0144a:	9901      	ldr	r1, [sp, #4]
c0d0144c:	f7ff ff12 	bl	c0d01274 <io_seproxyhal_touch_out>
c0d01450:	4d05      	ldr	r5, [pc, #20]	; (c0d01468 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01452:	2800      	cmp	r0, #0
c0d01454:	d001      	beq.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01456:	2000      	movs	r0, #0
c0d01458:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d0145a:	b007      	add	sp, #28
c0d0145c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0145e:	2000      	movs	r0, #0
c0d01460:	6018      	str	r0, [r3, #0]
c0d01462:	e7fa      	b.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01464:	601e      	str	r6, [r3, #0]
c0d01466:	e7f8      	b.n	c0d0145a <io_seproxyhal_touch_element_callback+0xfe>
c0d01468:	20001d20 	.word	0x20001d20

c0d0146c <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d0146c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0146e:	af03      	add	r7, sp, #12
c0d01470:	b08b      	sub	sp, #44	; 0x2c
c0d01472:	460c      	mov	r4, r1
c0d01474:	4601      	mov	r1, r0
c0d01476:	ad04      	add	r5, sp, #16
c0d01478:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d0147a:	4628      	mov	r0, r5
c0d0147c:	9203      	str	r2, [sp, #12]
c0d0147e:	f7ff fd2d 	bl	c0d00edc <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01482:	6821      	ldr	r1, [r4, #0]
c0d01484:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01486:	6862      	ldr	r2, [r4, #4]
c0d01488:	9502      	str	r5, [sp, #8]
c0d0148a:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0148c:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0148e:	4e1a      	ldr	r6, [pc, #104]	; (c0d014f8 <io_seproxyhal_display_icon+0x8c>)
c0d01490:	2365      	movs	r3, #101	; 0x65
c0d01492:	4635      	mov	r5, r6
c0d01494:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01496:	b292      	uxth	r2, r2
c0d01498:	4342      	muls	r2, r0
c0d0149a:	b28b      	uxth	r3, r1
c0d0149c:	4353      	muls	r3, r2
c0d0149e:	08d9      	lsrs	r1, r3, #3
c0d014a0:	1c4e      	adds	r6, r1, #1
c0d014a2:	2207      	movs	r2, #7
c0d014a4:	4213      	tst	r3, r2
c0d014a6:	d100      	bne.n	c0d014aa <io_seproxyhal_display_icon+0x3e>
c0d014a8:	460e      	mov	r6, r1
c0d014aa:	4631      	mov	r1, r6
c0d014ac:	9101      	str	r1, [sp, #4]
c0d014ae:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d014b0:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d014b2:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d014b4:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d014b6:	0a01      	lsrs	r1, r0, #8
c0d014b8:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d014ba:	70a8      	strb	r0, [r5, #2]
c0d014bc:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d014be:	4628      	mov	r0, r5
c0d014c0:	f000 fd48 	bl	c0d01f54 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d014c4:	9802      	ldr	r0, [sp, #8]
c0d014c6:	9903      	ldr	r1, [sp, #12]
c0d014c8:	f000 fd44 	bl	c0d01f54 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d014cc:	68a0      	ldr	r0, [r4, #8]
c0d014ce:	7028      	strb	r0, [r5, #0]
c0d014d0:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d014d2:	4628      	mov	r0, r5
c0d014d4:	f000 fd3e 	bl	c0d01f54 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d014d8:	68e0      	ldr	r0, [r4, #12]
c0d014da:	f000 fb7f 	bl	c0d01bdc <pic>
c0d014de:	b2b1      	uxth	r1, r6
c0d014e0:	f000 fd38 	bl	c0d01f54 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d014e4:	9801      	ldr	r0, [sp, #4]
c0d014e6:	b285      	uxth	r5, r0
c0d014e8:	6920      	ldr	r0, [r4, #16]
c0d014ea:	f000 fb77 	bl	c0d01bdc <pic>
c0d014ee:	4629      	mov	r1, r5
c0d014f0:	f000 fd30 	bl	c0d01f54 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d014f4:	b00b      	add	sp, #44	; 0x2c
c0d014f6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014f8:	20001a18 	.word	0x20001a18

c0d014fc <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d014fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014fe:	af03      	add	r7, sp, #12
c0d01500:	b081      	sub	sp, #4
c0d01502:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01504:	7820      	ldrb	r0, [r4, #0]
c0d01506:	267f      	movs	r6, #127	; 0x7f
c0d01508:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d0150a:	2e00      	cmp	r6, #0
c0d0150c:	d02e      	beq.n	c0d0156c <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0150e:	69e0      	ldr	r0, [r4, #28]
c0d01510:	2800      	cmp	r0, #0
c0d01512:	d01d      	beq.n	c0d01550 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01514:	f000 fb62 	bl	c0d01bdc <pic>
c0d01518:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0151a:	2e05      	cmp	r6, #5
c0d0151c:	d102      	bne.n	c0d01524 <io_seproxyhal_display_default+0x28>
c0d0151e:	7ea0      	ldrb	r0, [r4, #26]
c0d01520:	2800      	cmp	r0, #0
c0d01522:	d025      	beq.n	c0d01570 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01524:	4628      	mov	r0, r5
c0d01526:	f001 ffc5 	bl	c0d034b4 <strlen>
c0d0152a:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0152c:	4813      	ldr	r0, [pc, #76]	; (c0d0157c <io_seproxyhal_display_default+0x80>)
c0d0152e:	2165      	movs	r1, #101	; 0x65
c0d01530:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01532:	4631      	mov	r1, r6
c0d01534:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01536:	0a0a      	lsrs	r2, r1, #8
c0d01538:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0153a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0153c:	2103      	movs	r1, #3
c0d0153e:	f000 fd09 	bl	c0d01f54 <io_seproxyhal_spi_send>
c0d01542:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01544:	4620      	mov	r0, r4
c0d01546:	f000 fd05 	bl	c0d01f54 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d0154a:	b2b1      	uxth	r1, r6
c0d0154c:	4628      	mov	r0, r5
c0d0154e:	e00b      	b.n	c0d01568 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01550:	480a      	ldr	r0, [pc, #40]	; (c0d0157c <io_seproxyhal_display_default+0x80>)
c0d01552:	2165      	movs	r1, #101	; 0x65
c0d01554:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01556:	2100      	movs	r1, #0
c0d01558:	7041      	strb	r1, [r0, #1]
c0d0155a:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d0155c:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0155e:	2103      	movs	r1, #3
c0d01560:	f000 fcf8 	bl	c0d01f54 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01564:	4620      	mov	r0, r4
c0d01566:	4629      	mov	r1, r5
c0d01568:	f000 fcf4 	bl	c0d01f54 <io_seproxyhal_spi_send>
    }
  }
}
c0d0156c:	b001      	add	sp, #4
c0d0156e:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01570:	4620      	mov	r0, r4
c0d01572:	4629      	mov	r1, r5
c0d01574:	f7ff ff7a 	bl	c0d0146c <io_seproxyhal_display_icon>
c0d01578:	e7f8      	b.n	c0d0156c <io_seproxyhal_display_default+0x70>
c0d0157a:	46c0      	nop			; (mov r8, r8)
c0d0157c:	20001a18 	.word	0x20001a18

c0d01580 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01580:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01582:	af03      	add	r7, sp, #12
c0d01584:	b081      	sub	sp, #4
c0d01586:	4604      	mov	r4, r0
  if (button_callback) {
c0d01588:	2c00      	cmp	r4, #0
c0d0158a:	d02e      	beq.n	c0d015ea <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d0158c:	4818      	ldr	r0, [pc, #96]	; (c0d015f0 <io_seproxyhal_button_push+0x70>)
c0d0158e:	6802      	ldr	r2, [r0, #0]
c0d01590:	428a      	cmp	r2, r1
c0d01592:	d103      	bne.n	c0d0159c <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01594:	4a17      	ldr	r2, [pc, #92]	; (c0d015f4 <io_seproxyhal_button_push+0x74>)
c0d01596:	6813      	ldr	r3, [r2, #0]
c0d01598:	1c5b      	adds	r3, r3, #1
c0d0159a:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d0159c:	6806      	ldr	r6, [r0, #0]
c0d0159e:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d015a0:	4a14      	ldr	r2, [pc, #80]	; (c0d015f4 <io_seproxyhal_button_push+0x74>)
c0d015a2:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d015a4:	2900      	cmp	r1, #0
c0d015a6:	d001      	beq.n	c0d015ac <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d015a8:	6006      	str	r6, [r0, #0]
c0d015aa:	e005      	b.n	c0d015b8 <io_seproxyhal_button_push+0x38>
c0d015ac:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d015ae:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d015b0:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d015b2:	2301      	movs	r3, #1
c0d015b4:	07db      	lsls	r3, r3, #31
c0d015b6:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d015b8:	6800      	ldr	r0, [r0, #0]
c0d015ba:	4288      	cmp	r0, r1
c0d015bc:	d001      	beq.n	c0d015c2 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d015be:	2000      	movs	r0, #0
c0d015c0:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d015c2:	2d08      	cmp	r5, #8
c0d015c4:	d30e      	bcc.n	c0d015e4 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d015c6:	2103      	movs	r1, #3
c0d015c8:	4628      	mov	r0, r5
c0d015ca:	f001 fda7 	bl	c0d0311c <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d015ce:	2001      	movs	r0, #1
c0d015d0:	0780      	lsls	r0, r0, #30
c0d015d2:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d015d4:	2900      	cmp	r1, #0
c0d015d6:	4601      	mov	r1, r0
c0d015d8:	d000      	beq.n	c0d015dc <io_seproxyhal_button_push+0x5c>
c0d015da:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d015dc:	2900      	cmp	r1, #0
c0d015de:	db02      	blt.n	c0d015e6 <io_seproxyhal_button_push+0x66>
c0d015e0:	4608      	mov	r0, r1
c0d015e2:	e000      	b.n	c0d015e6 <io_seproxyhal_button_push+0x66>
c0d015e4:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d015e6:	4629      	mov	r1, r5
c0d015e8:	47a0      	blx	r4
  }
}
c0d015ea:	b001      	add	sp, #4
c0d015ec:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d015ee:	46c0      	nop			; (mov r8, r8)
c0d015f0:	20001d24 	.word	0x20001d24
c0d015f4:	20001d28 	.word	0x20001d28

c0d015f8 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d015f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d015fa:	af03      	add	r7, sp, #12
c0d015fc:	b081      	sub	sp, #4
c0d015fe:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01600:	200f      	movs	r0, #15
c0d01602:	4204      	tst	r4, r0
c0d01604:	d006      	beq.n	c0d01614 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01606:	4620      	mov	r0, r4
c0d01608:	f7ff f8be 	bl	c0d00788 <io_exchange_al>
c0d0160c:	4605      	mov	r5, r0
  }
}
c0d0160e:	b2a8      	uxth	r0, r5
c0d01610:	b001      	add	sp, #4
c0d01612:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01614:	2610      	movs	r6, #16
c0d01616:	4026      	ands	r6, r4
c0d01618:	2900      	cmp	r1, #0
c0d0161a:	d02a      	beq.n	c0d01672 <io_exchange+0x7a>
c0d0161c:	2e00      	cmp	r6, #0
c0d0161e:	d128      	bne.n	c0d01672 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01620:	483d      	ldr	r0, [pc, #244]	; (c0d01718 <io_exchange+0x120>)
c0d01622:	7800      	ldrb	r0, [r0, #0]
c0d01624:	2807      	cmp	r0, #7
c0d01626:	d00b      	beq.n	c0d01640 <io_exchange+0x48>
c0d01628:	2800      	cmp	r0, #0
c0d0162a:	d004      	beq.n	c0d01636 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d0162c:	4620      	mov	r0, r4
c0d0162e:	f7ff f8ab 	bl	c0d00788 <io_exchange_al>
c0d01632:	2800      	cmp	r0, #0
c0d01634:	d00a      	beq.n	c0d0164c <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01636:	4839      	ldr	r0, [pc, #228]	; (c0d0171c <io_exchange+0x124>)
c0d01638:	6800      	ldr	r0, [r0, #0]
c0d0163a:	2109      	movs	r1, #9
c0d0163c:	f001 ff2c 	bl	c0d03498 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01640:	483d      	ldr	r0, [pc, #244]	; (c0d01738 <io_exchange+0x140>)
c0d01642:	4478      	add	r0, pc
c0d01644:	2200      	movs	r2, #0
c0d01646:	2320      	movs	r3, #32
c0d01648:	f7ff fc6a 	bl	c0d00f20 <io_usb_hid_exchange>
c0d0164c:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0164e:	4832      	ldr	r0, [pc, #200]	; (c0d01718 <io_exchange+0x120>)
c0d01650:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01652:	4833      	ldr	r0, [pc, #204]	; (c0d01720 <io_exchange+0x128>)
c0d01654:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01656:	4833      	ldr	r0, [pc, #204]	; (c0d01724 <io_exchange+0x12c>)
c0d01658:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d0165a:	4833      	ldr	r0, [pc, #204]	; (c0d01728 <io_exchange+0x130>)
c0d0165c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0165e:	4833      	ldr	r0, [pc, #204]	; (c0d0172c <io_exchange+0x134>)
c0d01660:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01662:	06a0      	lsls	r0, r4, #26
c0d01664:	d4d3      	bmi.n	c0d0160e <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01666:	f7ff fcd3 	bl	c0d01010 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d0166a:	0620      	lsls	r0, r4, #24
c0d0166c:	d501      	bpl.n	c0d01672 <io_exchange+0x7a>
        reset();
c0d0166e:	f000 faeb 	bl	c0d01c48 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01672:	2e00      	cmp	r6, #0
c0d01674:	d10c      	bne.n	c0d01690 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01676:	0660      	lsls	r0, r4, #25
c0d01678:	d448      	bmi.n	c0d0170c <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d0167a:	4827      	ldr	r0, [pc, #156]	; (c0d01718 <io_exchange+0x120>)
c0d0167c:	2100      	movs	r1, #0
c0d0167e:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01680:	4827      	ldr	r0, [pc, #156]	; (c0d01720 <io_exchange+0x128>)
c0d01682:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01684:	4827      	ldr	r0, [pc, #156]	; (c0d01724 <io_exchange+0x12c>)
c0d01686:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01688:	4827      	ldr	r0, [pc, #156]	; (c0d01728 <io_exchange+0x130>)
c0d0168a:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0168c:	4827      	ldr	r0, [pc, #156]	; (c0d0172c <io_exchange+0x134>)
c0d0168e:	7001      	strb	r1, [r0, #0]
c0d01690:	4c28      	ldr	r4, [pc, #160]	; (c0d01734 <io_exchange+0x13c>)
c0d01692:	4e24      	ldr	r6, [pc, #144]	; (c0d01724 <io_exchange+0x12c>)
c0d01694:	e008      	b.n	c0d016a8 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01696:	f7ff fd0f 	bl	c0d010b8 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d0169a:	8830      	ldrh	r0, [r6, #0]
c0d0169c:	2800      	cmp	r0, #0
c0d0169e:	d003      	beq.n	c0d016a8 <io_exchange+0xb0>
c0d016a0:	e032      	b.n	c0d01708 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d016a2:	2002      	movs	r0, #2
c0d016a4:	f7ff f89e 	bl	c0d007e4 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d016a8:	f000 fc72 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d016ac:	2800      	cmp	r0, #0
c0d016ae:	d101      	bne.n	c0d016b4 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d016b0:	f7ff fcae 	bl	c0d01010 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d016b4:	2180      	movs	r1, #128	; 0x80
c0d016b6:	2500      	movs	r5, #0
c0d016b8:	4620      	mov	r0, r4
c0d016ba:	462a      	mov	r2, r5
c0d016bc:	f000 fc84 	bl	c0d01fc8 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d016c0:	1ec1      	subs	r1, r0, #3
c0d016c2:	78a2      	ldrb	r2, [r4, #2]
c0d016c4:	7863      	ldrb	r3, [r4, #1]
c0d016c6:	021b      	lsls	r3, r3, #8
c0d016c8:	4313      	orrs	r3, r2
c0d016ca:	4299      	cmp	r1, r3
c0d016cc:	d110      	bne.n	c0d016f0 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d016ce:	4917      	ldr	r1, [pc, #92]	; (c0d0172c <io_exchange+0x134>)
c0d016d0:	7809      	ldrb	r1, [r1, #0]
c0d016d2:	2900      	cmp	r1, #0
c0d016d4:	d002      	beq.n	c0d016dc <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d016d6:	f7ff fd73 	bl	c0d011c0 <io_seproxyhal_handle_event>
c0d016da:	e7e5      	b.n	c0d016a8 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d016dc:	7821      	ldrb	r1, [r4, #0]
c0d016de:	2910      	cmp	r1, #16
c0d016e0:	d00f      	beq.n	c0d01702 <io_exchange+0x10a>
c0d016e2:	290f      	cmp	r1, #15
c0d016e4:	d1dd      	bne.n	c0d016a2 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d016e6:	2804      	cmp	r0, #4
c0d016e8:	d102      	bne.n	c0d016f0 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d016ea:	f7ff fca7 	bl	c0d0103c <io_seproxyhal_handle_usb_event>
c0d016ee:	e7db      	b.n	c0d016a8 <io_exchange+0xb0>
c0d016f0:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d016f2:	4909      	ldr	r1, [pc, #36]	; (c0d01718 <io_exchange+0x120>)
c0d016f4:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d016f6:	490a      	ldr	r1, [pc, #40]	; (c0d01720 <io_exchange+0x128>)
c0d016f8:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d016fa:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d016fc:	490a      	ldr	r1, [pc, #40]	; (c0d01728 <io_exchange+0x130>)
c0d016fe:	8008      	strh	r0, [r1, #0]
c0d01700:	e7d2      	b.n	c0d016a8 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01702:	2806      	cmp	r0, #6
c0d01704:	d2c7      	bcs.n	c0d01696 <io_exchange+0x9e>
c0d01706:	e782      	b.n	c0d0160e <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01708:	8835      	ldrh	r5, [r6, #0]
c0d0170a:	e780      	b.n	c0d0160e <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d0170c:	4805      	ldr	r0, [pc, #20]	; (c0d01724 <io_exchange+0x12c>)
c0d0170e:	8800      	ldrh	r0, [r0, #0]
c0d01710:	4907      	ldr	r1, [pc, #28]	; (c0d01730 <io_exchange+0x138>)
c0d01712:	1845      	adds	r5, r0, r1
c0d01714:	e77b      	b.n	c0d0160e <io_exchange+0x16>
c0d01716:	46c0      	nop			; (mov r8, r8)
c0d01718:	20001d18 	.word	0x20001d18
c0d0171c:	20001bb8 	.word	0x20001bb8
c0d01720:	20001d1a 	.word	0x20001d1a
c0d01724:	20001d1c 	.word	0x20001d1c
c0d01728:	20001d1e 	.word	0x20001d1e
c0d0172c:	20001d10 	.word	0x20001d10
c0d01730:	0000fffb 	.word	0x0000fffb
c0d01734:	20001a18 	.word	0x20001a18
c0d01738:	fffffbbb 	.word	0xfffffbbb

c0d0173c <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d0173c:	b081      	sub	sp, #4
c0d0173e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01740:	af03      	add	r7, sp, #12
c0d01742:	b094      	sub	sp, #80	; 0x50
c0d01744:	4616      	mov	r6, r2
c0d01746:	460d      	mov	r5, r1
c0d01748:	900e      	str	r0, [sp, #56]	; 0x38
c0d0174a:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d0174c:	2d02      	cmp	r5, #2
c0d0174e:	d200      	bcs.n	c0d01752 <snprintf+0x16>
c0d01750:	e22a      	b.n	c0d01ba8 <snprintf+0x46c>
c0d01752:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01754:	2800      	cmp	r0, #0
c0d01756:	d100      	bne.n	c0d0175a <snprintf+0x1e>
c0d01758:	e226      	b.n	c0d01ba8 <snprintf+0x46c>
c0d0175a:	2e00      	cmp	r6, #0
c0d0175c:	d100      	bne.n	c0d01760 <snprintf+0x24>
c0d0175e:	e223      	b.n	c0d01ba8 <snprintf+0x46c>
c0d01760:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01762:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01764:	9109      	str	r1, [sp, #36]	; 0x24
c0d01766:	462a      	mov	r2, r5
c0d01768:	f7ff fbae 	bl	c0d00ec8 <os_memset>
c0d0176c:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d0176e:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01770:	7830      	ldrb	r0, [r6, #0]
c0d01772:	2800      	cmp	r0, #0
c0d01774:	d100      	bne.n	c0d01778 <snprintf+0x3c>
c0d01776:	e217      	b.n	c0d01ba8 <snprintf+0x46c>
c0d01778:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0177a:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d0177c:	1e6b      	subs	r3, r5, #1
c0d0177e:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01780:	460a      	mov	r2, r1
c0d01782:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01784:	e003      	b.n	c0d0178e <snprintf+0x52>
c0d01786:	1970      	adds	r0, r6, r5
c0d01788:	7840      	ldrb	r0, [r0, #1]
c0d0178a:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d0178c:	1c6d      	adds	r5, r5, #1
c0d0178e:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01790:	2800      	cmp	r0, #0
c0d01792:	d001      	beq.n	c0d01798 <snprintf+0x5c>
c0d01794:	2825      	cmp	r0, #37	; 0x25
c0d01796:	d1f6      	bne.n	c0d01786 <snprintf+0x4a>
c0d01798:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d0179a:	429d      	cmp	r5, r3
c0d0179c:	d300      	bcc.n	c0d017a0 <snprintf+0x64>
c0d0179e:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d017a0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d017a2:	4631      	mov	r1, r6
c0d017a4:	462a      	mov	r2, r5
c0d017a6:	461c      	mov	r4, r3
c0d017a8:	f7ff fb98 	bl	c0d00edc <os_memmove>
c0d017ac:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d017ae:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d017b0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d017b2:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d017b4:	2b00      	cmp	r3, #0
c0d017b6:	d100      	bne.n	c0d017ba <snprintf+0x7e>
c0d017b8:	e1f6      	b.n	c0d01ba8 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d017ba:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d017bc:	5d71      	ldrb	r1, [r6, r5]
c0d017be:	2925      	cmp	r1, #37	; 0x25
c0d017c0:	d000      	beq.n	c0d017c4 <snprintf+0x88>
c0d017c2:	e0ab      	b.n	c0d0191c <snprintf+0x1e0>
c0d017c4:	9304      	str	r3, [sp, #16]
c0d017c6:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d017c8:	1c40      	adds	r0, r0, #1
c0d017ca:	2100      	movs	r1, #0
c0d017cc:	2220      	movs	r2, #32
c0d017ce:	920a      	str	r2, [sp, #40]	; 0x28
c0d017d0:	220a      	movs	r2, #10
c0d017d2:	9203      	str	r2, [sp, #12]
c0d017d4:	9102      	str	r1, [sp, #8]
c0d017d6:	9106      	str	r1, [sp, #24]
c0d017d8:	910d      	str	r1, [sp, #52]	; 0x34
c0d017da:	460b      	mov	r3, r1
c0d017dc:	2102      	movs	r1, #2
c0d017de:	910c      	str	r1, [sp, #48]	; 0x30
c0d017e0:	4606      	mov	r6, r0
c0d017e2:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d017e4:	7831      	ldrb	r1, [r6, #0]
c0d017e6:	1c76      	adds	r6, r6, #1
c0d017e8:	2300      	movs	r3, #0
c0d017ea:	2962      	cmp	r1, #98	; 0x62
c0d017ec:	dc41      	bgt.n	c0d01872 <snprintf+0x136>
c0d017ee:	4608      	mov	r0, r1
c0d017f0:	3825      	subs	r0, #37	; 0x25
c0d017f2:	2823      	cmp	r0, #35	; 0x23
c0d017f4:	d900      	bls.n	c0d017f8 <snprintf+0xbc>
c0d017f6:	e094      	b.n	c0d01922 <snprintf+0x1e6>
c0d017f8:	0040      	lsls	r0, r0, #1
c0d017fa:	46c0      	nop			; (mov r8, r8)
c0d017fc:	4478      	add	r0, pc
c0d017fe:	8880      	ldrh	r0, [r0, #4]
c0d01800:	0040      	lsls	r0, r0, #1
c0d01802:	4487      	add	pc, r0
c0d01804:	0186012d 	.word	0x0186012d
c0d01808:	01860186 	.word	0x01860186
c0d0180c:	00510186 	.word	0x00510186
c0d01810:	01860186 	.word	0x01860186
c0d01814:	00580023 	.word	0x00580023
c0d01818:	00240186 	.word	0x00240186
c0d0181c:	00240024 	.word	0x00240024
c0d01820:	00240024 	.word	0x00240024
c0d01824:	00240024 	.word	0x00240024
c0d01828:	00240024 	.word	0x00240024
c0d0182c:	01860024 	.word	0x01860024
c0d01830:	01860186 	.word	0x01860186
c0d01834:	01860186 	.word	0x01860186
c0d01838:	01860186 	.word	0x01860186
c0d0183c:	01860186 	.word	0x01860186
c0d01840:	01860186 	.word	0x01860186
c0d01844:	01860186 	.word	0x01860186
c0d01848:	006c0186 	.word	0x006c0186
c0d0184c:	e7c9      	b.n	c0d017e2 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d0184e:	2930      	cmp	r1, #48	; 0x30
c0d01850:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01852:	4603      	mov	r3, r0
c0d01854:	d100      	bne.n	c0d01858 <snprintf+0x11c>
c0d01856:	460b      	mov	r3, r1
c0d01858:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d0185a:	2c00      	cmp	r4, #0
c0d0185c:	d000      	beq.n	c0d01860 <snprintf+0x124>
c0d0185e:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01860:	200a      	movs	r0, #10
c0d01862:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01864:	1840      	adds	r0, r0, r1
c0d01866:	3830      	subs	r0, #48	; 0x30
c0d01868:	900d      	str	r0, [sp, #52]	; 0x34
c0d0186a:	4630      	mov	r0, r6
c0d0186c:	930a      	str	r3, [sp, #40]	; 0x28
c0d0186e:	4613      	mov	r3, r2
c0d01870:	e7b4      	b.n	c0d017dc <snprintf+0xa0>
c0d01872:	296f      	cmp	r1, #111	; 0x6f
c0d01874:	dd11      	ble.n	c0d0189a <snprintf+0x15e>
c0d01876:	3970      	subs	r1, #112	; 0x70
c0d01878:	2908      	cmp	r1, #8
c0d0187a:	d900      	bls.n	c0d0187e <snprintf+0x142>
c0d0187c:	e149      	b.n	c0d01b12 <snprintf+0x3d6>
c0d0187e:	0049      	lsls	r1, r1, #1
c0d01880:	4479      	add	r1, pc
c0d01882:	8889      	ldrh	r1, [r1, #4]
c0d01884:	0049      	lsls	r1, r1, #1
c0d01886:	448f      	add	pc, r1
c0d01888:	01440051 	.word	0x01440051
c0d0188c:	002e0144 	.word	0x002e0144
c0d01890:	00590144 	.word	0x00590144
c0d01894:	01440144 	.word	0x01440144
c0d01898:	0051      	.short	0x0051
c0d0189a:	2963      	cmp	r1, #99	; 0x63
c0d0189c:	d054      	beq.n	c0d01948 <snprintf+0x20c>
c0d0189e:	2964      	cmp	r1, #100	; 0x64
c0d018a0:	d057      	beq.n	c0d01952 <snprintf+0x216>
c0d018a2:	2968      	cmp	r1, #104	; 0x68
c0d018a4:	d01d      	beq.n	c0d018e2 <snprintf+0x1a6>
c0d018a6:	e134      	b.n	c0d01b12 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d018a8:	7830      	ldrb	r0, [r6, #0]
c0d018aa:	2873      	cmp	r0, #115	; 0x73
c0d018ac:	d000      	beq.n	c0d018b0 <snprintf+0x174>
c0d018ae:	e130      	b.n	c0d01b12 <snprintf+0x3d6>
c0d018b0:	4630      	mov	r0, r6
c0d018b2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d018b4:	e00d      	b.n	c0d018d2 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d018b6:	7830      	ldrb	r0, [r6, #0]
c0d018b8:	282a      	cmp	r0, #42	; 0x2a
c0d018ba:	d000      	beq.n	c0d018be <snprintf+0x182>
c0d018bc:	e129      	b.n	c0d01b12 <snprintf+0x3d6>
c0d018be:	7871      	ldrb	r1, [r6, #1]
c0d018c0:	1c70      	adds	r0, r6, #1
c0d018c2:	2301      	movs	r3, #1
c0d018c4:	2948      	cmp	r1, #72	; 0x48
c0d018c6:	d004      	beq.n	c0d018d2 <snprintf+0x196>
c0d018c8:	2968      	cmp	r1, #104	; 0x68
c0d018ca:	d002      	beq.n	c0d018d2 <snprintf+0x196>
c0d018cc:	2973      	cmp	r1, #115	; 0x73
c0d018ce:	d000      	beq.n	c0d018d2 <snprintf+0x196>
c0d018d0:	e11f      	b.n	c0d01b12 <snprintf+0x3d6>
c0d018d2:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d018d4:	1d0a      	adds	r2, r1, #4
c0d018d6:	920f      	str	r2, [sp, #60]	; 0x3c
c0d018d8:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d018da:	9102      	str	r1, [sp, #8]
c0d018dc:	e77e      	b.n	c0d017dc <snprintf+0xa0>
c0d018de:	2001      	movs	r0, #1
c0d018e0:	9006      	str	r0, [sp, #24]
c0d018e2:	2010      	movs	r0, #16
c0d018e4:	9003      	str	r0, [sp, #12]
c0d018e6:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d018e8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d018ea:	1d01      	adds	r1, r0, #4
c0d018ec:	910f      	str	r1, [sp, #60]	; 0x3c
c0d018ee:	2103      	movs	r1, #3
c0d018f0:	400a      	ands	r2, r1
c0d018f2:	1c5b      	adds	r3, r3, #1
c0d018f4:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d018f6:	2a01      	cmp	r2, #1
c0d018f8:	d100      	bne.n	c0d018fc <snprintf+0x1c0>
c0d018fa:	e0b8      	b.n	c0d01a6e <snprintf+0x332>
c0d018fc:	2a02      	cmp	r2, #2
c0d018fe:	d100      	bne.n	c0d01902 <snprintf+0x1c6>
c0d01900:	e104      	b.n	c0d01b0c <snprintf+0x3d0>
c0d01902:	2a03      	cmp	r2, #3
c0d01904:	4630      	mov	r0, r6
c0d01906:	d100      	bne.n	c0d0190a <snprintf+0x1ce>
c0d01908:	e768      	b.n	c0d017dc <snprintf+0xa0>
c0d0190a:	9c08      	ldr	r4, [sp, #32]
c0d0190c:	4625      	mov	r5, r4
c0d0190e:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01910:	1948      	adds	r0, r1, r5
c0d01912:	7840      	ldrb	r0, [r0, #1]
c0d01914:	1c6d      	adds	r5, r5, #1
c0d01916:	2800      	cmp	r0, #0
c0d01918:	d1fa      	bne.n	c0d01910 <snprintf+0x1d4>
c0d0191a:	e0ab      	b.n	c0d01a74 <snprintf+0x338>
c0d0191c:	4606      	mov	r6, r0
c0d0191e:	920e      	str	r2, [sp, #56]	; 0x38
c0d01920:	e109      	b.n	c0d01b36 <snprintf+0x3fa>
c0d01922:	2958      	cmp	r1, #88	; 0x58
c0d01924:	d000      	beq.n	c0d01928 <snprintf+0x1ec>
c0d01926:	e0f4      	b.n	c0d01b12 <snprintf+0x3d6>
c0d01928:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d0192a:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0192c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0192e:	1d01      	adds	r1, r0, #4
c0d01930:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01932:	6802      	ldr	r2, [r0, #0]
c0d01934:	2000      	movs	r0, #0
c0d01936:	9005      	str	r0, [sp, #20]
c0d01938:	2510      	movs	r5, #16
c0d0193a:	e014      	b.n	c0d01966 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0193c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0193e:	1d01      	adds	r1, r0, #4
c0d01940:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01942:	6802      	ldr	r2, [r0, #0]
c0d01944:	2000      	movs	r0, #0
c0d01946:	e00c      	b.n	c0d01962 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01948:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0194a:	1d01      	adds	r1, r0, #4
c0d0194c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0194e:	6800      	ldr	r0, [r0, #0]
c0d01950:	e087      	b.n	c0d01a62 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01952:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01954:	1d01      	adds	r1, r0, #4
c0d01956:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01958:	6800      	ldr	r0, [r0, #0]
c0d0195a:	17c1      	asrs	r1, r0, #31
c0d0195c:	1842      	adds	r2, r0, r1
c0d0195e:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01960:	0fc0      	lsrs	r0, r0, #31
c0d01962:	9005      	str	r0, [sp, #20]
c0d01964:	250a      	movs	r5, #10
c0d01966:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01968:	4295      	cmp	r5, r2
c0d0196a:	920e      	str	r2, [sp, #56]	; 0x38
c0d0196c:	d814      	bhi.n	c0d01998 <snprintf+0x25c>
c0d0196e:	2201      	movs	r2, #1
c0d01970:	4628      	mov	r0, r5
c0d01972:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01974:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01976:	4629      	mov	r1, r5
c0d01978:	f001 fb4a 	bl	c0d03010 <__aeabi_uidiv>
c0d0197c:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d0197e:	4288      	cmp	r0, r1
c0d01980:	d109      	bne.n	c0d01996 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01982:	4628      	mov	r0, r5
c0d01984:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01986:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01988:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d0198a:	910d      	str	r1, [sp, #52]	; 0x34
c0d0198c:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0198e:	4288      	cmp	r0, r1
c0d01990:	4622      	mov	r2, r4
c0d01992:	d9ee      	bls.n	c0d01972 <snprintf+0x236>
c0d01994:	e000      	b.n	c0d01998 <snprintf+0x25c>
c0d01996:	460c      	mov	r4, r1
c0d01998:	950c      	str	r5, [sp, #48]	; 0x30
c0d0199a:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d0199c:	2000      	movs	r0, #0
c0d0199e:	4603      	mov	r3, r0
c0d019a0:	43c1      	mvns	r1, r0
c0d019a2:	9c05      	ldr	r4, [sp, #20]
c0d019a4:	2c00      	cmp	r4, #0
c0d019a6:	d100      	bne.n	c0d019aa <snprintf+0x26e>
c0d019a8:	4621      	mov	r1, r4
c0d019aa:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d019ac:	910b      	str	r1, [sp, #44]	; 0x2c
c0d019ae:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d019b0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d019b2:	b2ca      	uxtb	r2, r1
c0d019b4:	2a30      	cmp	r2, #48	; 0x30
c0d019b6:	d106      	bne.n	c0d019c6 <snprintf+0x28a>
c0d019b8:	2c00      	cmp	r4, #0
c0d019ba:	d004      	beq.n	c0d019c6 <snprintf+0x28a>
c0d019bc:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d019be:	232d      	movs	r3, #45	; 0x2d
c0d019c0:	700b      	strb	r3, [r1, #0]
c0d019c2:	2400      	movs	r4, #0
c0d019c4:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d019c6:	1e81      	subs	r1, r0, #2
c0d019c8:	290d      	cmp	r1, #13
c0d019ca:	d80d      	bhi.n	c0d019e8 <snprintf+0x2ac>
c0d019cc:	1e41      	subs	r1, r0, #1
c0d019ce:	d00b      	beq.n	c0d019e8 <snprintf+0x2ac>
c0d019d0:	a810      	add	r0, sp, #64	; 0x40
c0d019d2:	9405      	str	r4, [sp, #20]
c0d019d4:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d019d6:	4320      	orrs	r0, r4
c0d019d8:	f001 fcc6 	bl	c0d03368 <__aeabi_memset>
c0d019dc:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d019de:	1900      	adds	r0, r0, r4
c0d019e0:	9c05      	ldr	r4, [sp, #20]
c0d019e2:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d019e4:	1840      	adds	r0, r0, r1
c0d019e6:	1e43      	subs	r3, r0, #1
c0d019e8:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d019ea:	2c00      	cmp	r4, #0
c0d019ec:	9601      	str	r6, [sp, #4]
c0d019ee:	d003      	beq.n	c0d019f8 <snprintf+0x2bc>
c0d019f0:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d019f2:	222d      	movs	r2, #45	; 0x2d
c0d019f4:	54c2      	strb	r2, [r0, r3]
c0d019f6:	1c5b      	adds	r3, r3, #1
c0d019f8:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d019fa:	2900      	cmp	r1, #0
c0d019fc:	d003      	beq.n	c0d01a06 <snprintf+0x2ca>
c0d019fe:	2800      	cmp	r0, #0
c0d01a00:	d003      	beq.n	c0d01a0a <snprintf+0x2ce>
c0d01a02:	a06c      	add	r0, pc, #432	; (adr r0, c0d01bb4 <g_pcHex_cap>)
c0d01a04:	e002      	b.n	c0d01a0c <snprintf+0x2d0>
c0d01a06:	461c      	mov	r4, r3
c0d01a08:	e016      	b.n	c0d01a38 <snprintf+0x2fc>
c0d01a0a:	a06e      	add	r0, pc, #440	; (adr r0, c0d01bc4 <g_pcHex>)
c0d01a0c:	900d      	str	r0, [sp, #52]	; 0x34
c0d01a0e:	461c      	mov	r4, r3
c0d01a10:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01a12:	460e      	mov	r6, r1
c0d01a14:	f001 fafc 	bl	c0d03010 <__aeabi_uidiv>
c0d01a18:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01a1a:	4629      	mov	r1, r5
c0d01a1c:	f001 fb7e 	bl	c0d0311c <__aeabi_uidivmod>
c0d01a20:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01a22:	5c40      	ldrb	r0, [r0, r1]
c0d01a24:	a910      	add	r1, sp, #64	; 0x40
c0d01a26:	5508      	strb	r0, [r1, r4]
c0d01a28:	4630      	mov	r0, r6
c0d01a2a:	4629      	mov	r1, r5
c0d01a2c:	f001 faf0 	bl	c0d03010 <__aeabi_uidiv>
c0d01a30:	1c64      	adds	r4, r4, #1
c0d01a32:	42b5      	cmp	r5, r6
c0d01a34:	4601      	mov	r1, r0
c0d01a36:	d9eb      	bls.n	c0d01a10 <snprintf+0x2d4>
c0d01a38:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01a3a:	429c      	cmp	r4, r3
c0d01a3c:	4625      	mov	r5, r4
c0d01a3e:	d300      	bcc.n	c0d01a42 <snprintf+0x306>
c0d01a40:	461d      	mov	r5, r3
c0d01a42:	a910      	add	r1, sp, #64	; 0x40
c0d01a44:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01a46:	4620      	mov	r0, r4
c0d01a48:	462a      	mov	r2, r5
c0d01a4a:	461e      	mov	r6, r3
c0d01a4c:	f7ff fa46 	bl	c0d00edc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01a50:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01a52:	1961      	adds	r1, r4, r5
c0d01a54:	910e      	str	r1, [sp, #56]	; 0x38
c0d01a56:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01a58:	2800      	cmp	r0, #0
c0d01a5a:	9e01      	ldr	r6, [sp, #4]
c0d01a5c:	d16b      	bne.n	c0d01b36 <snprintf+0x3fa>
c0d01a5e:	e0a3      	b.n	c0d01ba8 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01a60:	2025      	movs	r0, #37	; 0x25
c0d01a62:	9907      	ldr	r1, [sp, #28]
c0d01a64:	7008      	strb	r0, [r1, #0]
c0d01a66:	9804      	ldr	r0, [sp, #16]
c0d01a68:	1e40      	subs	r0, r0, #1
c0d01a6a:	1c49      	adds	r1, r1, #1
c0d01a6c:	e05f      	b.n	c0d01b2e <snprintf+0x3f2>
c0d01a6e:	9d02      	ldr	r5, [sp, #8]
c0d01a70:	9c08      	ldr	r4, [sp, #32]
c0d01a72:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01a74:	9803      	ldr	r0, [sp, #12]
c0d01a76:	2810      	cmp	r0, #16
c0d01a78:	9807      	ldr	r0, [sp, #28]
c0d01a7a:	d161      	bne.n	c0d01b40 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01a7c:	2d00      	cmp	r5, #0
c0d01a7e:	d06a      	beq.n	c0d01b56 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01a80:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01a82:	1900      	adds	r0, r0, r4
c0d01a84:	900e      	str	r0, [sp, #56]	; 0x38
c0d01a86:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01a88:	1aa0      	subs	r0, r4, r2
c0d01a8a:	9b05      	ldr	r3, [sp, #20]
c0d01a8c:	4283      	cmp	r3, r0
c0d01a8e:	d800      	bhi.n	c0d01a92 <snprintf+0x356>
c0d01a90:	4603      	mov	r3, r0
c0d01a92:	930c      	str	r3, [sp, #48]	; 0x30
c0d01a94:	435c      	muls	r4, r3
c0d01a96:	940a      	str	r4, [sp, #40]	; 0x28
c0d01a98:	1c60      	adds	r0, r4, #1
c0d01a9a:	9007      	str	r0, [sp, #28]
c0d01a9c:	2000      	movs	r0, #0
c0d01a9e:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01aa0:	9100      	str	r1, [sp, #0]
c0d01aa2:	940e      	str	r4, [sp, #56]	; 0x38
c0d01aa4:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01aa6:	18e3      	adds	r3, r4, r3
c0d01aa8:	900d      	str	r0, [sp, #52]	; 0x34
c0d01aaa:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01aac:	200f      	movs	r0, #15
c0d01aae:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01ab0:	0909      	lsrs	r1, r1, #4
c0d01ab2:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01ab4:	18a4      	adds	r4, r4, r2
c0d01ab6:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01ab8:	2c02      	cmp	r4, #2
c0d01aba:	d375      	bcc.n	c0d01ba8 <snprintf+0x46c>
c0d01abc:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01abe:	2c01      	cmp	r4, #1
c0d01ac0:	d003      	beq.n	c0d01aca <snprintf+0x38e>
c0d01ac2:	2c00      	cmp	r4, #0
c0d01ac4:	d108      	bne.n	c0d01ad8 <snprintf+0x39c>
c0d01ac6:	a43f      	add	r4, pc, #252	; (adr r4, c0d01bc4 <g_pcHex>)
c0d01ac8:	e000      	b.n	c0d01acc <snprintf+0x390>
c0d01aca:	a43a      	add	r4, pc, #232	; (adr r4, c0d01bb4 <g_pcHex_cap>)
c0d01acc:	b2c9      	uxtb	r1, r1
c0d01ace:	5c61      	ldrb	r1, [r4, r1]
c0d01ad0:	7019      	strb	r1, [r3, #0]
c0d01ad2:	b2c0      	uxtb	r0, r0
c0d01ad4:	5c20      	ldrb	r0, [r4, r0]
c0d01ad6:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01ad8:	9807      	ldr	r0, [sp, #28]
c0d01ada:	4290      	cmp	r0, r2
c0d01adc:	d064      	beq.n	c0d01ba8 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01ade:	1e92      	subs	r2, r2, #2
c0d01ae0:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01ae2:	1ca4      	adds	r4, r4, #2
c0d01ae4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01ae6:	1c40      	adds	r0, r0, #1
c0d01ae8:	42a8      	cmp	r0, r5
c0d01aea:	9900      	ldr	r1, [sp, #0]
c0d01aec:	d3d9      	bcc.n	c0d01aa2 <snprintf+0x366>
c0d01aee:	900d      	str	r0, [sp, #52]	; 0x34
c0d01af0:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01af2:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01af4:	1a08      	subs	r0, r1, r0
c0d01af6:	9b05      	ldr	r3, [sp, #20]
c0d01af8:	4283      	cmp	r3, r0
c0d01afa:	d800      	bhi.n	c0d01afe <snprintf+0x3c2>
c0d01afc:	4603      	mov	r3, r0
c0d01afe:	4608      	mov	r0, r1
c0d01b00:	4358      	muls	r0, r3
c0d01b02:	1820      	adds	r0, r4, r0
c0d01b04:	900e      	str	r0, [sp, #56]	; 0x38
c0d01b06:	1898      	adds	r0, r3, r2
c0d01b08:	1c43      	adds	r3, r0, #1
c0d01b0a:	e038      	b.n	c0d01b7e <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01b0c:	7808      	ldrb	r0, [r1, #0]
c0d01b0e:	2800      	cmp	r0, #0
c0d01b10:	d023      	beq.n	c0d01b5a <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01b12:	2005      	movs	r0, #5
c0d01b14:	9d04      	ldr	r5, [sp, #16]
c0d01b16:	2d05      	cmp	r5, #5
c0d01b18:	462c      	mov	r4, r5
c0d01b1a:	d300      	bcc.n	c0d01b1e <snprintf+0x3e2>
c0d01b1c:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01b1e:	9807      	ldr	r0, [sp, #28]
c0d01b20:	a12c      	add	r1, pc, #176	; (adr r1, c0d01bd4 <g_pcHex+0x10>)
c0d01b22:	4622      	mov	r2, r4
c0d01b24:	f7ff f9da 	bl	c0d00edc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01b28:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01b2a:	9907      	ldr	r1, [sp, #28]
c0d01b2c:	1909      	adds	r1, r1, r4
c0d01b2e:	910e      	str	r1, [sp, #56]	; 0x38
c0d01b30:	4603      	mov	r3, r0
c0d01b32:	2800      	cmp	r0, #0
c0d01b34:	d038      	beq.n	c0d01ba8 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01b36:	7830      	ldrb	r0, [r6, #0]
c0d01b38:	2800      	cmp	r0, #0
c0d01b3a:	9908      	ldr	r1, [sp, #32]
c0d01b3c:	d034      	beq.n	c0d01ba8 <snprintf+0x46c>
c0d01b3e:	e61f      	b.n	c0d01780 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01b40:	429d      	cmp	r5, r3
c0d01b42:	d300      	bcc.n	c0d01b46 <snprintf+0x40a>
c0d01b44:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01b46:	462a      	mov	r2, r5
c0d01b48:	461c      	mov	r4, r3
c0d01b4a:	f7ff f9c7 	bl	c0d00edc <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01b4e:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01b50:	9907      	ldr	r1, [sp, #28]
c0d01b52:	1949      	adds	r1, r1, r5
c0d01b54:	e00f      	b.n	c0d01b76 <snprintf+0x43a>
c0d01b56:	900e      	str	r0, [sp, #56]	; 0x38
c0d01b58:	e7ed      	b.n	c0d01b36 <snprintf+0x3fa>
c0d01b5a:	9b04      	ldr	r3, [sp, #16]
c0d01b5c:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01b5e:	429c      	cmp	r4, r3
c0d01b60:	d300      	bcc.n	c0d01b64 <snprintf+0x428>
c0d01b62:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01b64:	2120      	movs	r1, #32
c0d01b66:	9807      	ldr	r0, [sp, #28]
c0d01b68:	4622      	mov	r2, r4
c0d01b6a:	f7ff f9ad 	bl	c0d00ec8 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01b6e:	9804      	ldr	r0, [sp, #16]
c0d01b70:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01b72:	9907      	ldr	r1, [sp, #28]
c0d01b74:	1909      	adds	r1, r1, r4
c0d01b76:	910e      	str	r1, [sp, #56]	; 0x38
c0d01b78:	4603      	mov	r3, r0
c0d01b7a:	2800      	cmp	r0, #0
c0d01b7c:	d014      	beq.n	c0d01ba8 <snprintf+0x46c>
c0d01b7e:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01b80:	42a8      	cmp	r0, r5
c0d01b82:	d9d8      	bls.n	c0d01b36 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01b84:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01b86:	429a      	cmp	r2, r3
c0d01b88:	d300      	bcc.n	c0d01b8c <snprintf+0x450>
c0d01b8a:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01b8c:	2120      	movs	r1, #32
c0d01b8e:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01b90:	4628      	mov	r0, r5
c0d01b92:	920d      	str	r2, [sp, #52]	; 0x34
c0d01b94:	461c      	mov	r4, r3
c0d01b96:	f7ff f997 	bl	c0d00ec8 <os_memset>
c0d01b9a:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01b9c:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01b9e:	182d      	adds	r5, r5, r0
c0d01ba0:	950e      	str	r5, [sp, #56]	; 0x38
c0d01ba2:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01ba4:	2c00      	cmp	r4, #0
c0d01ba6:	d1c6      	bne.n	c0d01b36 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01ba8:	2000      	movs	r0, #0
c0d01baa:	b014      	add	sp, #80	; 0x50
c0d01bac:	bcf0      	pop	{r4, r5, r6, r7}
c0d01bae:	bc02      	pop	{r1}
c0d01bb0:	b001      	add	sp, #4
c0d01bb2:	4708      	bx	r1

c0d01bb4 <g_pcHex_cap>:
c0d01bb4:	33323130 	.word	0x33323130
c0d01bb8:	37363534 	.word	0x37363534
c0d01bbc:	42413938 	.word	0x42413938
c0d01bc0:	46454443 	.word	0x46454443

c0d01bc4 <g_pcHex>:
c0d01bc4:	33323130 	.word	0x33323130
c0d01bc8:	37363534 	.word	0x37363534
c0d01bcc:	62613938 	.word	0x62613938
c0d01bd0:	66656463 	.word	0x66656463
c0d01bd4:	4f525245 	.word	0x4f525245
c0d01bd8:	00000052 	.word	0x00000052

c0d01bdc <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01bdc:	b580      	push	{r7, lr}
c0d01bde:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01be0:	4904      	ldr	r1, [pc, #16]	; (c0d01bf4 <pic+0x18>)
c0d01be2:	4288      	cmp	r0, r1
c0d01be4:	d304      	bcc.n	c0d01bf0 <pic+0x14>
c0d01be6:	4904      	ldr	r1, [pc, #16]	; (c0d01bf8 <pic+0x1c>)
c0d01be8:	4288      	cmp	r0, r1
c0d01bea:	d201      	bcs.n	c0d01bf0 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01bec:	f000 f806 	bl	c0d01bfc <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01bf0:	bd80      	pop	{r7, pc}
c0d01bf2:	46c0      	nop			; (mov r8, r8)
c0d01bf4:	c0d00000 	.word	0xc0d00000
c0d01bf8:	c0d03a00 	.word	0xc0d03a00

c0d01bfc <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01bfc:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01bfe:	4902      	ldr	r1, [pc, #8]	; (c0d01c08 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01c00:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01c02:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01c04:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01c06:	4770      	bx	lr
c0d01c08:	c0d01bfd 	.word	0xc0d01bfd

c0d01c0c <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01c0c:	b580      	push	{r7, lr}
c0d01c0e:	af00      	add	r7, sp, #0
c0d01c10:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01c12:	490a      	ldr	r1, [pc, #40]	; (c0d01c3c <check_api_level+0x30>)
c0d01c14:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c16:	490a      	ldr	r1, [pc, #40]	; (c0d01c40 <check_api_level+0x34>)
c0d01c18:	680a      	ldr	r2, [r1, #0]
c0d01c1a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01c1c:	9003      	str	r0, [sp, #12]
c0d01c1e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c20:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c22:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c24:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01c26:	4807      	ldr	r0, [pc, #28]	; (c0d01c44 <check_api_level+0x38>)
c0d01c28:	9a01      	ldr	r2, [sp, #4]
c0d01c2a:	4282      	cmp	r2, r0
c0d01c2c:	d101      	bne.n	c0d01c32 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c2e:	b004      	add	sp, #16
c0d01c30:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c32:	6808      	ldr	r0, [r1, #0]
c0d01c34:	2104      	movs	r1, #4
c0d01c36:	f001 fc2f 	bl	c0d03498 <longjmp>
c0d01c3a:	46c0      	nop			; (mov r8, r8)
c0d01c3c:	60000137 	.word	0x60000137
c0d01c40:	20001bb8 	.word	0x20001bb8
c0d01c44:	900001c6 	.word	0x900001c6

c0d01c48 <reset>:
  }
}

void reset ( void ) 
{
c0d01c48:	b580      	push	{r7, lr}
c0d01c4a:	af00      	add	r7, sp, #0
c0d01c4c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01c4e:	4809      	ldr	r0, [pc, #36]	; (c0d01c74 <reset+0x2c>)
c0d01c50:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c52:	4809      	ldr	r0, [pc, #36]	; (c0d01c78 <reset+0x30>)
c0d01c54:	6801      	ldr	r1, [r0, #0]
c0d01c56:	9101      	str	r1, [sp, #4]
c0d01c58:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c5a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01c5c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c5e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01c60:	4906      	ldr	r1, [pc, #24]	; (c0d01c7c <reset+0x34>)
c0d01c62:	9a00      	ldr	r2, [sp, #0]
c0d01c64:	428a      	cmp	r2, r1
c0d01c66:	d101      	bne.n	c0d01c6c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c68:	b002      	add	sp, #8
c0d01c6a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c6c:	6800      	ldr	r0, [r0, #0]
c0d01c6e:	2104      	movs	r1, #4
c0d01c70:	f001 fc12 	bl	c0d03498 <longjmp>
c0d01c74:	60000200 	.word	0x60000200
c0d01c78:	20001bb8 	.word	0x20001bb8
c0d01c7c:	900002f1 	.word	0x900002f1

c0d01c80 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01c80:	b5d0      	push	{r4, r6, r7, lr}
c0d01c82:	af02      	add	r7, sp, #8
c0d01c84:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01c86:	4b0a      	ldr	r3, [pc, #40]	; (c0d01cb0 <nvm_write+0x30>)
c0d01c88:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c8a:	4b0a      	ldr	r3, [pc, #40]	; (c0d01cb4 <nvm_write+0x34>)
c0d01c8c:	681c      	ldr	r4, [r3, #0]
c0d01c8e:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01c90:	ac03      	add	r4, sp, #12
c0d01c92:	c407      	stmia	r4!, {r0, r1, r2}
c0d01c94:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c96:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c98:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c9a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01c9c:	4806      	ldr	r0, [pc, #24]	; (c0d01cb8 <nvm_write+0x38>)
c0d01c9e:	9901      	ldr	r1, [sp, #4]
c0d01ca0:	4281      	cmp	r1, r0
c0d01ca2:	d101      	bne.n	c0d01ca8 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ca4:	b006      	add	sp, #24
c0d01ca6:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ca8:	6818      	ldr	r0, [r3, #0]
c0d01caa:	2104      	movs	r1, #4
c0d01cac:	f001 fbf4 	bl	c0d03498 <longjmp>
c0d01cb0:	6000037f 	.word	0x6000037f
c0d01cb4:	20001bb8 	.word	0x20001bb8
c0d01cb8:	900003bc 	.word	0x900003bc

c0d01cbc <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01cbc:	b580      	push	{r7, lr}
c0d01cbe:	af00      	add	r7, sp, #0
c0d01cc0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01cc2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cec <cx_rng+0x30>)
c0d01cc4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cc6:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cf0 <cx_rng+0x34>)
c0d01cc8:	6813      	ldr	r3, [r2, #0]
c0d01cca:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01ccc:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01cce:	9103      	str	r1, [sp, #12]
c0d01cd0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cd2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cd4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cd6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01cd8:	4906      	ldr	r1, [pc, #24]	; (c0d01cf4 <cx_rng+0x38>)
c0d01cda:	9b00      	ldr	r3, [sp, #0]
c0d01cdc:	428b      	cmp	r3, r1
c0d01cde:	d101      	bne.n	c0d01ce4 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01ce0:	b004      	add	sp, #16
c0d01ce2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ce4:	6810      	ldr	r0, [r2, #0]
c0d01ce6:	2104      	movs	r1, #4
c0d01ce8:	f001 fbd6 	bl	c0d03498 <longjmp>
c0d01cec:	6000052c 	.word	0x6000052c
c0d01cf0:	20001bb8 	.word	0x20001bb8
c0d01cf4:	90000567 	.word	0x90000567

c0d01cf8 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01cf8:	b580      	push	{r7, lr}
c0d01cfa:	af00      	add	r7, sp, #0
c0d01cfc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01cfe:	490a      	ldr	r1, [pc, #40]	; (c0d01d28 <cx_sha256_init+0x30>)
c0d01d00:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d02:	490a      	ldr	r1, [pc, #40]	; (c0d01d2c <cx_sha256_init+0x34>)
c0d01d04:	680a      	ldr	r2, [r1, #0]
c0d01d06:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01d08:	9003      	str	r0, [sp, #12]
c0d01d0a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d0c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d0e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d10:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01d12:	4a07      	ldr	r2, [pc, #28]	; (c0d01d30 <cx_sha256_init+0x38>)
c0d01d14:	9b01      	ldr	r3, [sp, #4]
c0d01d16:	4293      	cmp	r3, r2
c0d01d18:	d101      	bne.n	c0d01d1e <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d1a:	b004      	add	sp, #16
c0d01d1c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d1e:	6808      	ldr	r0, [r1, #0]
c0d01d20:	2104      	movs	r1, #4
c0d01d22:	f001 fbb9 	bl	c0d03498 <longjmp>
c0d01d26:	46c0      	nop			; (mov r8, r8)
c0d01d28:	600008db 	.word	0x600008db
c0d01d2c:	20001bb8 	.word	0x20001bb8
c0d01d30:	90000864 	.word	0x90000864

c0d01d34 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01d34:	b580      	push	{r7, lr}
c0d01d36:	af00      	add	r7, sp, #0
c0d01d38:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01d3a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01d64 <cx_keccak_init+0x30>)
c0d01d3c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d3e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01d68 <cx_keccak_init+0x34>)
c0d01d40:	6813      	ldr	r3, [r2, #0]
c0d01d42:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01d44:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01d46:	9103      	str	r1, [sp, #12]
c0d01d48:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d4a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d4c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d4e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01d50:	4906      	ldr	r1, [pc, #24]	; (c0d01d6c <cx_keccak_init+0x38>)
c0d01d52:	9b00      	ldr	r3, [sp, #0]
c0d01d54:	428b      	cmp	r3, r1
c0d01d56:	d101      	bne.n	c0d01d5c <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d58:	b004      	add	sp, #16
c0d01d5a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d5c:	6810      	ldr	r0, [r2, #0]
c0d01d5e:	2104      	movs	r1, #4
c0d01d60:	f001 fb9a 	bl	c0d03498 <longjmp>
c0d01d64:	60000c3c 	.word	0x60000c3c
c0d01d68:	20001bb8 	.word	0x20001bb8
c0d01d6c:	90000c39 	.word	0x90000c39

c0d01d70 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01d70:	b5b0      	push	{r4, r5, r7, lr}
c0d01d72:	af02      	add	r7, sp, #8
c0d01d74:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01d76:	4c0b      	ldr	r4, [pc, #44]	; (c0d01da4 <cx_hash+0x34>)
c0d01d78:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d7a:	4c0b      	ldr	r4, [pc, #44]	; (c0d01da8 <cx_hash+0x38>)
c0d01d7c:	6825      	ldr	r5, [r4, #0]
c0d01d7e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01d80:	ad03      	add	r5, sp, #12
c0d01d82:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01d84:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01d86:	9007      	str	r0, [sp, #28]
c0d01d88:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d8a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d8c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d8e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01d90:	4906      	ldr	r1, [pc, #24]	; (c0d01dac <cx_hash+0x3c>)
c0d01d92:	9a01      	ldr	r2, [sp, #4]
c0d01d94:	428a      	cmp	r2, r1
c0d01d96:	d101      	bne.n	c0d01d9c <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d98:	b008      	add	sp, #32
c0d01d9a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d9c:	6820      	ldr	r0, [r4, #0]
c0d01d9e:	2104      	movs	r1, #4
c0d01da0:	f001 fb7a 	bl	c0d03498 <longjmp>
c0d01da4:	60000ea6 	.word	0x60000ea6
c0d01da8:	20001bb8 	.word	0x20001bb8
c0d01dac:	90000e46 	.word	0x90000e46

c0d01db0 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01db0:	b5b0      	push	{r4, r5, r7, lr}
c0d01db2:	af02      	add	r7, sp, #8
c0d01db4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01db6:	4c0a      	ldr	r4, [pc, #40]	; (c0d01de0 <cx_ecfp_init_public_key+0x30>)
c0d01db8:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01dba:	4c0a      	ldr	r4, [pc, #40]	; (c0d01de4 <cx_ecfp_init_public_key+0x34>)
c0d01dbc:	6825      	ldr	r5, [r4, #0]
c0d01dbe:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01dc0:	ad02      	add	r5, sp, #8
c0d01dc2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01dc4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dc6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01dc8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01dca:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01dcc:	4906      	ldr	r1, [pc, #24]	; (c0d01de8 <cx_ecfp_init_public_key+0x38>)
c0d01dce:	9a00      	ldr	r2, [sp, #0]
c0d01dd0:	428a      	cmp	r2, r1
c0d01dd2:	d101      	bne.n	c0d01dd8 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01dd4:	b006      	add	sp, #24
c0d01dd6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01dd8:	6820      	ldr	r0, [r4, #0]
c0d01dda:	2104      	movs	r1, #4
c0d01ddc:	f001 fb5c 	bl	c0d03498 <longjmp>
c0d01de0:	60002835 	.word	0x60002835
c0d01de4:	20001bb8 	.word	0x20001bb8
c0d01de8:	900028f0 	.word	0x900028f0

c0d01dec <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01dec:	b5b0      	push	{r4, r5, r7, lr}
c0d01dee:	af02      	add	r7, sp, #8
c0d01df0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01df2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01e1c <cx_ecfp_init_private_key+0x30>)
c0d01df4:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01df6:	4c0a      	ldr	r4, [pc, #40]	; (c0d01e20 <cx_ecfp_init_private_key+0x34>)
c0d01df8:	6825      	ldr	r5, [r4, #0]
c0d01dfa:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01dfc:	ad02      	add	r5, sp, #8
c0d01dfe:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01e00:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e02:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e04:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e06:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01e08:	4906      	ldr	r1, [pc, #24]	; (c0d01e24 <cx_ecfp_init_private_key+0x38>)
c0d01e0a:	9a00      	ldr	r2, [sp, #0]
c0d01e0c:	428a      	cmp	r2, r1
c0d01e0e:	d101      	bne.n	c0d01e14 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01e10:	b006      	add	sp, #24
c0d01e12:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e14:	6820      	ldr	r0, [r4, #0]
c0d01e16:	2104      	movs	r1, #4
c0d01e18:	f001 fb3e 	bl	c0d03498 <longjmp>
c0d01e1c:	600029ed 	.word	0x600029ed
c0d01e20:	20001bb8 	.word	0x20001bb8
c0d01e24:	900029ae 	.word	0x900029ae

c0d01e28 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01e28:	b5b0      	push	{r4, r5, r7, lr}
c0d01e2a:	af02      	add	r7, sp, #8
c0d01e2c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01e2e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01e58 <cx_ecfp_generate_pair+0x30>)
c0d01e30:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e32:	4c0a      	ldr	r4, [pc, #40]	; (c0d01e5c <cx_ecfp_generate_pair+0x34>)
c0d01e34:	6825      	ldr	r5, [r4, #0]
c0d01e36:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01e38:	ad02      	add	r5, sp, #8
c0d01e3a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01e3c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e3e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e40:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e42:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01e44:	4906      	ldr	r1, [pc, #24]	; (c0d01e60 <cx_ecfp_generate_pair+0x38>)
c0d01e46:	9a00      	ldr	r2, [sp, #0]
c0d01e48:	428a      	cmp	r2, r1
c0d01e4a:	d101      	bne.n	c0d01e50 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01e4c:	b006      	add	sp, #24
c0d01e4e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e50:	6820      	ldr	r0, [r4, #0]
c0d01e52:	2104      	movs	r1, #4
c0d01e54:	f001 fb20 	bl	c0d03498 <longjmp>
c0d01e58:	60002a2e 	.word	0x60002a2e
c0d01e5c:	20001bb8 	.word	0x20001bb8
c0d01e60:	90002a74 	.word	0x90002a74

c0d01e64 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01e64:	b5b0      	push	{r4, r5, r7, lr}
c0d01e66:	af02      	add	r7, sp, #8
c0d01e68:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01e6a:	4c0b      	ldr	r4, [pc, #44]	; (c0d01e98 <os_perso_derive_node_bip32+0x34>)
c0d01e6c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e6e:	4c0b      	ldr	r4, [pc, #44]	; (c0d01e9c <os_perso_derive_node_bip32+0x38>)
c0d01e70:	6825      	ldr	r5, [r4, #0]
c0d01e72:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01e74:	ad03      	add	r5, sp, #12
c0d01e76:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01e78:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01e7a:	9007      	str	r0, [sp, #28]
c0d01e7c:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e7e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e80:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e82:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01e84:	4806      	ldr	r0, [pc, #24]	; (c0d01ea0 <os_perso_derive_node_bip32+0x3c>)
c0d01e86:	9901      	ldr	r1, [sp, #4]
c0d01e88:	4281      	cmp	r1, r0
c0d01e8a:	d101      	bne.n	c0d01e90 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e8c:	b008      	add	sp, #32
c0d01e8e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e90:	6820      	ldr	r0, [r4, #0]
c0d01e92:	2104      	movs	r1, #4
c0d01e94:	f001 fb00 	bl	c0d03498 <longjmp>
c0d01e98:	6000512b 	.word	0x6000512b
c0d01e9c:	20001bb8 	.word	0x20001bb8
c0d01ea0:	9000517f 	.word	0x9000517f

c0d01ea4 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01ea4:	b580      	push	{r7, lr}
c0d01ea6:	af00      	add	r7, sp, #0
c0d01ea8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01eaa:	490a      	ldr	r1, [pc, #40]	; (c0d01ed4 <os_sched_exit+0x30>)
c0d01eac:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01eae:	490a      	ldr	r1, [pc, #40]	; (c0d01ed8 <os_sched_exit+0x34>)
c0d01eb0:	680a      	ldr	r2, [r1, #0]
c0d01eb2:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01eb4:	9003      	str	r0, [sp, #12]
c0d01eb6:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01eb8:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01eba:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ebc:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01ebe:	4807      	ldr	r0, [pc, #28]	; (c0d01edc <os_sched_exit+0x38>)
c0d01ec0:	9a01      	ldr	r2, [sp, #4]
c0d01ec2:	4282      	cmp	r2, r0
c0d01ec4:	d101      	bne.n	c0d01eca <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ec6:	b004      	add	sp, #16
c0d01ec8:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01eca:	6808      	ldr	r0, [r1, #0]
c0d01ecc:	2104      	movs	r1, #4
c0d01ece:	f001 fae3 	bl	c0d03498 <longjmp>
c0d01ed2:	46c0      	nop			; (mov r8, r8)
c0d01ed4:	60005fe1 	.word	0x60005fe1
c0d01ed8:	20001bb8 	.word	0x20001bb8
c0d01edc:	90005f6f 	.word	0x90005f6f

c0d01ee0 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01ee0:	b580      	push	{r7, lr}
c0d01ee2:	af00      	add	r7, sp, #0
c0d01ee4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01ee6:	490a      	ldr	r1, [pc, #40]	; (c0d01f10 <os_ux+0x30>)
c0d01ee8:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01eea:	490a      	ldr	r1, [pc, #40]	; (c0d01f14 <os_ux+0x34>)
c0d01eec:	680a      	ldr	r2, [r1, #0]
c0d01eee:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01ef0:	9003      	str	r0, [sp, #12]
c0d01ef2:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ef4:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ef6:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ef8:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01efa:	4a07      	ldr	r2, [pc, #28]	; (c0d01f18 <os_ux+0x38>)
c0d01efc:	9b01      	ldr	r3, [sp, #4]
c0d01efe:	4293      	cmp	r3, r2
c0d01f00:	d101      	bne.n	c0d01f06 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01f02:	b004      	add	sp, #16
c0d01f04:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f06:	6808      	ldr	r0, [r1, #0]
c0d01f08:	2104      	movs	r1, #4
c0d01f0a:	f001 fac5 	bl	c0d03498 <longjmp>
c0d01f0e:	46c0      	nop			; (mov r8, r8)
c0d01f10:	60006158 	.word	0x60006158
c0d01f14:	20001bb8 	.word	0x20001bb8
c0d01f18:	9000611f 	.word	0x9000611f

c0d01f1c <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01f1c:	b580      	push	{r7, lr}
c0d01f1e:	af00      	add	r7, sp, #0
c0d01f20:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01f22:	4809      	ldr	r0, [pc, #36]	; (c0d01f48 <os_seph_features+0x2c>)
c0d01f24:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f26:	4909      	ldr	r1, [pc, #36]	; (c0d01f4c <os_seph_features+0x30>)
c0d01f28:	6808      	ldr	r0, [r1, #0]
c0d01f2a:	9001      	str	r0, [sp, #4]
c0d01f2c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f2e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f30:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f32:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01f34:	4a06      	ldr	r2, [pc, #24]	; (c0d01f50 <os_seph_features+0x34>)
c0d01f36:	9b00      	ldr	r3, [sp, #0]
c0d01f38:	4293      	cmp	r3, r2
c0d01f3a:	d101      	bne.n	c0d01f40 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01f3c:	b002      	add	sp, #8
c0d01f3e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f40:	6808      	ldr	r0, [r1, #0]
c0d01f42:	2104      	movs	r1, #4
c0d01f44:	f001 faa8 	bl	c0d03498 <longjmp>
c0d01f48:	600064d6 	.word	0x600064d6
c0d01f4c:	20001bb8 	.word	0x20001bb8
c0d01f50:	90006444 	.word	0x90006444

c0d01f54 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01f54:	b580      	push	{r7, lr}
c0d01f56:	af00      	add	r7, sp, #0
c0d01f58:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01f5a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01f84 <io_seproxyhal_spi_send+0x30>)
c0d01f5c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f5e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01f88 <io_seproxyhal_spi_send+0x34>)
c0d01f60:	6813      	ldr	r3, [r2, #0]
c0d01f62:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01f64:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01f66:	9103      	str	r1, [sp, #12]
c0d01f68:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f6a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f6c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f6e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01f70:	4806      	ldr	r0, [pc, #24]	; (c0d01f8c <io_seproxyhal_spi_send+0x38>)
c0d01f72:	9900      	ldr	r1, [sp, #0]
c0d01f74:	4281      	cmp	r1, r0
c0d01f76:	d101      	bne.n	c0d01f7c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01f78:	b004      	add	sp, #16
c0d01f7a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f7c:	6810      	ldr	r0, [r2, #0]
c0d01f7e:	2104      	movs	r1, #4
c0d01f80:	f001 fa8a 	bl	c0d03498 <longjmp>
c0d01f84:	60006a1c 	.word	0x60006a1c
c0d01f88:	20001bb8 	.word	0x20001bb8
c0d01f8c:	90006af3 	.word	0x90006af3

c0d01f90 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01f90:	b580      	push	{r7, lr}
c0d01f92:	af00      	add	r7, sp, #0
c0d01f94:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01f96:	4809      	ldr	r0, [pc, #36]	; (c0d01fbc <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01f98:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f9a:	4909      	ldr	r1, [pc, #36]	; (c0d01fc0 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01f9c:	6808      	ldr	r0, [r1, #0]
c0d01f9e:	9001      	str	r0, [sp, #4]
c0d01fa0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fa2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fa4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fa6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01fa8:	4a06      	ldr	r2, [pc, #24]	; (c0d01fc4 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01faa:	9b00      	ldr	r3, [sp, #0]
c0d01fac:	4293      	cmp	r3, r2
c0d01fae:	d101      	bne.n	c0d01fb4 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01fb0:	b002      	add	sp, #8
c0d01fb2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01fb4:	6808      	ldr	r0, [r1, #0]
c0d01fb6:	2104      	movs	r1, #4
c0d01fb8:	f001 fa6e 	bl	c0d03498 <longjmp>
c0d01fbc:	60006bcf 	.word	0x60006bcf
c0d01fc0:	20001bb8 	.word	0x20001bb8
c0d01fc4:	90006b7f 	.word	0x90006b7f

c0d01fc8 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01fc8:	b5d0      	push	{r4, r6, r7, lr}
c0d01fca:	af02      	add	r7, sp, #8
c0d01fcc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01fce:	4b0b      	ldr	r3, [pc, #44]	; (c0d01ffc <io_seproxyhal_spi_recv+0x34>)
c0d01fd0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fd2:	4b0b      	ldr	r3, [pc, #44]	; (c0d02000 <io_seproxyhal_spi_recv+0x38>)
c0d01fd4:	681c      	ldr	r4, [r3, #0]
c0d01fd6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01fd8:	ac03      	add	r4, sp, #12
c0d01fda:	c407      	stmia	r4!, {r0, r1, r2}
c0d01fdc:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fde:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fe0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fe2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01fe4:	4907      	ldr	r1, [pc, #28]	; (c0d02004 <io_seproxyhal_spi_recv+0x3c>)
c0d01fe6:	9a01      	ldr	r2, [sp, #4]
c0d01fe8:	428a      	cmp	r2, r1
c0d01fea:	d102      	bne.n	c0d01ff2 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01fec:	b280      	uxth	r0, r0
c0d01fee:	b006      	add	sp, #24
c0d01ff0:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ff2:	6818      	ldr	r0, [r3, #0]
c0d01ff4:	2104      	movs	r1, #4
c0d01ff6:	f001 fa4f 	bl	c0d03498 <longjmp>
c0d01ffa:	46c0      	nop			; (mov r8, r8)
c0d01ffc:	60006cd1 	.word	0x60006cd1
c0d02000:	20001bb8 	.word	0x20001bb8
c0d02004:	90006c2b 	.word	0x90006c2b

c0d02008 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02008:	b5b0      	push	{r4, r5, r7, lr}
c0d0200a:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d0200c:	492c      	ldr	r1, [pc, #176]	; (c0d020c0 <bagl_ui_nanos_screen1_button+0xb8>)
c0d0200e:	4288      	cmp	r0, r1
c0d02010:	d006      	beq.n	c0d02020 <bagl_ui_nanos_screen1_button+0x18>
c0d02012:	492c      	ldr	r1, [pc, #176]	; (c0d020c4 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02014:	4288      	cmp	r0, r1
c0d02016:	d151      	bne.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02018:	2000      	movs	r0, #0
c0d0201a:	f7ff ff43 	bl	c0d01ea4 <os_sched_exit>
c0d0201e:	e04d      	b.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02020:	f7fe fba4 	bl	c0d0076c <nvram_is_init>
c0d02024:	2801      	cmp	r0, #1
c0d02026:	d102      	bne.n	c0d0202e <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02028:	a029      	add	r0, pc, #164	; (adr r0, c0d020d0 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0202a:	210d      	movs	r1, #13
c0d0202c:	e001      	b.n	c0d02032 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0202e:	a026      	add	r0, pc, #152	; (adr r0, c0d020c8 <bagl_ui_nanos_screen1_button+0xc0>)
c0d02030:	2105      	movs	r1, #5
c0d02032:	2203      	movs	r2, #3
c0d02034:	f7fe f836 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02038:	4c29      	ldr	r4, [pc, #164]	; (c0d020e0 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0203a:	482b      	ldr	r0, [pc, #172]	; (c0d020e8 <bagl_ui_nanos_screen1_button+0xe0>)
c0d0203c:	4478      	add	r0, pc
c0d0203e:	6020      	str	r0, [r4, #0]
c0d02040:	2004      	movs	r0, #4
c0d02042:	6060      	str	r0, [r4, #4]
c0d02044:	4829      	ldr	r0, [pc, #164]	; (c0d020ec <bagl_ui_nanos_screen1_button+0xe4>)
c0d02046:	4478      	add	r0, pc
c0d02048:	6120      	str	r0, [r4, #16]
c0d0204a:	2500      	movs	r5, #0
c0d0204c:	60e5      	str	r5, [r4, #12]
c0d0204e:	2003      	movs	r0, #3
c0d02050:	7620      	strb	r0, [r4, #24]
c0d02052:	61e5      	str	r5, [r4, #28]
c0d02054:	4620      	mov	r0, r4
c0d02056:	3018      	adds	r0, #24
c0d02058:	f7ff ff42 	bl	c0d01ee0 <os_ux>
c0d0205c:	61e0      	str	r0, [r4, #28]
c0d0205e:	f7ff f903 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d02062:	60a5      	str	r5, [r4, #8]
c0d02064:	6820      	ldr	r0, [r4, #0]
c0d02066:	2800      	cmp	r0, #0
c0d02068:	d028      	beq.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
c0d0206a:	69e0      	ldr	r0, [r4, #28]
c0d0206c:	491d      	ldr	r1, [pc, #116]	; (c0d020e4 <bagl_ui_nanos_screen1_button+0xdc>)
c0d0206e:	4288      	cmp	r0, r1
c0d02070:	d116      	bne.n	c0d020a0 <bagl_ui_nanos_screen1_button+0x98>
c0d02072:	e023      	b.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
c0d02074:	6860      	ldr	r0, [r4, #4]
c0d02076:	4285      	cmp	r5, r0
c0d02078:	d220      	bcs.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
c0d0207a:	f7ff ff89 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d0207e:	2800      	cmp	r0, #0
c0d02080:	d11c      	bne.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
c0d02082:	68a0      	ldr	r0, [r4, #8]
c0d02084:	68e1      	ldr	r1, [r4, #12]
c0d02086:	2538      	movs	r5, #56	; 0x38
c0d02088:	4368      	muls	r0, r5
c0d0208a:	6822      	ldr	r2, [r4, #0]
c0d0208c:	1810      	adds	r0, r2, r0
c0d0208e:	2900      	cmp	r1, #0
c0d02090:	d009      	beq.n	c0d020a6 <bagl_ui_nanos_screen1_button+0x9e>
c0d02092:	4788      	blx	r1
c0d02094:	2800      	cmp	r0, #0
c0d02096:	d106      	bne.n	c0d020a6 <bagl_ui_nanos_screen1_button+0x9e>
c0d02098:	68a0      	ldr	r0, [r4, #8]
c0d0209a:	1c45      	adds	r5, r0, #1
c0d0209c:	60a5      	str	r5, [r4, #8]
c0d0209e:	6820      	ldr	r0, [r4, #0]
c0d020a0:	2800      	cmp	r0, #0
c0d020a2:	d1e7      	bne.n	c0d02074 <bagl_ui_nanos_screen1_button+0x6c>
c0d020a4:	e00a      	b.n	c0d020bc <bagl_ui_nanos_screen1_button+0xb4>
c0d020a6:	2801      	cmp	r0, #1
c0d020a8:	d103      	bne.n	c0d020b2 <bagl_ui_nanos_screen1_button+0xaa>
c0d020aa:	68a0      	ldr	r0, [r4, #8]
c0d020ac:	4345      	muls	r5, r0
c0d020ae:	6820      	ldr	r0, [r4, #0]
c0d020b0:	1940      	adds	r0, r0, r5
c0d020b2:	f7fe fb91 	bl	c0d007d8 <io_seproxyhal_display>
c0d020b6:	68a0      	ldr	r0, [r4, #8]
c0d020b8:	1c40      	adds	r0, r0, #1
c0d020ba:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d020bc:	2000      	movs	r0, #0
c0d020be:	bdb0      	pop	{r4, r5, r7, pc}
c0d020c0:	80000002 	.word	0x80000002
c0d020c4:	80000001 	.word	0x80000001
c0d020c8:	54494e49 	.word	0x54494e49
c0d020cc:	00000000 	.word	0x00000000
c0d020d0:	6c697453 	.word	0x6c697453
c0d020d4:	6e75206c 	.word	0x6e75206c
c0d020d8:	74696e69 	.word	0x74696e69
c0d020dc:	00000000 	.word	0x00000000
c0d020e0:	20001a98 	.word	0x20001a98
c0d020e4:	b0105044 	.word	0xb0105044
c0d020e8:	00001694 	.word	0x00001694
c0d020ec:	00000153 	.word	0x00000153

c0d020f0 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d020f0:	b5b0      	push	{r4, r5, r7, lr}
c0d020f2:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d020f4:	2800      	cmp	r0, #0
c0d020f6:	d005      	beq.n	c0d02104 <ui_display_debug+0x14>
c0d020f8:	2900      	cmp	r1, #0
c0d020fa:	d003      	beq.n	c0d02104 <ui_display_debug+0x14>
c0d020fc:	2a00      	cmp	r2, #0
c0d020fe:	d001      	beq.n	c0d02104 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02100:	f7fd ffd0 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02104:	4c21      	ldr	r4, [pc, #132]	; (c0d0218c <ui_display_debug+0x9c>)
c0d02106:	4823      	ldr	r0, [pc, #140]	; (c0d02194 <ui_display_debug+0xa4>)
c0d02108:	4478      	add	r0, pc
c0d0210a:	6020      	str	r0, [r4, #0]
c0d0210c:	2004      	movs	r0, #4
c0d0210e:	6060      	str	r0, [r4, #4]
c0d02110:	4821      	ldr	r0, [pc, #132]	; (c0d02198 <ui_display_debug+0xa8>)
c0d02112:	4478      	add	r0, pc
c0d02114:	6120      	str	r0, [r4, #16]
c0d02116:	2500      	movs	r5, #0
c0d02118:	60e5      	str	r5, [r4, #12]
c0d0211a:	2003      	movs	r0, #3
c0d0211c:	7620      	strb	r0, [r4, #24]
c0d0211e:	61e5      	str	r5, [r4, #28]
c0d02120:	4620      	mov	r0, r4
c0d02122:	3018      	adds	r0, #24
c0d02124:	f7ff fedc 	bl	c0d01ee0 <os_ux>
c0d02128:	61e0      	str	r0, [r4, #28]
c0d0212a:	f7ff f89d 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d0212e:	60a5      	str	r5, [r4, #8]
c0d02130:	6820      	ldr	r0, [r4, #0]
c0d02132:	2800      	cmp	r0, #0
c0d02134:	d028      	beq.n	c0d02188 <ui_display_debug+0x98>
c0d02136:	69e0      	ldr	r0, [r4, #28]
c0d02138:	4915      	ldr	r1, [pc, #84]	; (c0d02190 <ui_display_debug+0xa0>)
c0d0213a:	4288      	cmp	r0, r1
c0d0213c:	d116      	bne.n	c0d0216c <ui_display_debug+0x7c>
c0d0213e:	e023      	b.n	c0d02188 <ui_display_debug+0x98>
c0d02140:	6860      	ldr	r0, [r4, #4]
c0d02142:	4285      	cmp	r5, r0
c0d02144:	d220      	bcs.n	c0d02188 <ui_display_debug+0x98>
c0d02146:	f7ff ff23 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d0214a:	2800      	cmp	r0, #0
c0d0214c:	d11c      	bne.n	c0d02188 <ui_display_debug+0x98>
c0d0214e:	68a0      	ldr	r0, [r4, #8]
c0d02150:	68e1      	ldr	r1, [r4, #12]
c0d02152:	2538      	movs	r5, #56	; 0x38
c0d02154:	4368      	muls	r0, r5
c0d02156:	6822      	ldr	r2, [r4, #0]
c0d02158:	1810      	adds	r0, r2, r0
c0d0215a:	2900      	cmp	r1, #0
c0d0215c:	d009      	beq.n	c0d02172 <ui_display_debug+0x82>
c0d0215e:	4788      	blx	r1
c0d02160:	2800      	cmp	r0, #0
c0d02162:	d106      	bne.n	c0d02172 <ui_display_debug+0x82>
c0d02164:	68a0      	ldr	r0, [r4, #8]
c0d02166:	1c45      	adds	r5, r0, #1
c0d02168:	60a5      	str	r5, [r4, #8]
c0d0216a:	6820      	ldr	r0, [r4, #0]
c0d0216c:	2800      	cmp	r0, #0
c0d0216e:	d1e7      	bne.n	c0d02140 <ui_display_debug+0x50>
c0d02170:	e00a      	b.n	c0d02188 <ui_display_debug+0x98>
c0d02172:	2801      	cmp	r0, #1
c0d02174:	d103      	bne.n	c0d0217e <ui_display_debug+0x8e>
c0d02176:	68a0      	ldr	r0, [r4, #8]
c0d02178:	4345      	muls	r5, r0
c0d0217a:	6820      	ldr	r0, [r4, #0]
c0d0217c:	1940      	adds	r0, r0, r5
c0d0217e:	f7fe fb2b 	bl	c0d007d8 <io_seproxyhal_display>
c0d02182:	68a0      	ldr	r0, [r4, #8]
c0d02184:	1c40      	adds	r0, r0, #1
c0d02186:	60a0      	str	r0, [r4, #8]
}
c0d02188:	bdb0      	pop	{r4, r5, r7, pc}
c0d0218a:	46c0      	nop			; (mov r8, r8)
c0d0218c:	20001a98 	.word	0x20001a98
c0d02190:	b0105044 	.word	0xb0105044
c0d02194:	000015c8 	.word	0x000015c8
c0d02198:	00000087 	.word	0x00000087

c0d0219c <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0219c:	b580      	push	{r7, lr}
c0d0219e:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d021a0:	4905      	ldr	r1, [pc, #20]	; (c0d021b8 <bagl_ui_nanos_screen2_button+0x1c>)
c0d021a2:	4288      	cmp	r0, r1
c0d021a4:	d002      	beq.n	c0d021ac <bagl_ui_nanos_screen2_button+0x10>
c0d021a6:	4905      	ldr	r1, [pc, #20]	; (c0d021bc <bagl_ui_nanos_screen2_button+0x20>)
c0d021a8:	4288      	cmp	r0, r1
c0d021aa:	d102      	bne.n	c0d021b2 <bagl_ui_nanos_screen2_button+0x16>
c0d021ac:	2000      	movs	r0, #0
c0d021ae:	f7ff fe79 	bl	c0d01ea4 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d021b2:	2000      	movs	r0, #0
c0d021b4:	bd80      	pop	{r7, pc}
c0d021b6:	46c0      	nop			; (mov r8, r8)
c0d021b8:	80000002 	.word	0x80000002
c0d021bc:	80000001 	.word	0x80000001

c0d021c0 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d021c0:	b5b0      	push	{r4, r5, r7, lr}
c0d021c2:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d021c4:	2001      	movs	r0, #1
c0d021c6:	0204      	lsls	r4, r0, #8
c0d021c8:	f7ff fea8 	bl	c0d01f1c <os_seph_features>
c0d021cc:	4220      	tst	r0, r4
c0d021ce:	d136      	bne.n	c0d0223e <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d021d0:	4c3c      	ldr	r4, [pc, #240]	; (c0d022c4 <ui_idle+0x104>)
c0d021d2:	4840      	ldr	r0, [pc, #256]	; (c0d022d4 <ui_idle+0x114>)
c0d021d4:	4478      	add	r0, pc
c0d021d6:	6020      	str	r0, [r4, #0]
c0d021d8:	2004      	movs	r0, #4
c0d021da:	6060      	str	r0, [r4, #4]
c0d021dc:	483e      	ldr	r0, [pc, #248]	; (c0d022d8 <ui_idle+0x118>)
c0d021de:	4478      	add	r0, pc
c0d021e0:	6120      	str	r0, [r4, #16]
c0d021e2:	2500      	movs	r5, #0
c0d021e4:	60e5      	str	r5, [r4, #12]
c0d021e6:	2003      	movs	r0, #3
c0d021e8:	7620      	strb	r0, [r4, #24]
c0d021ea:	61e5      	str	r5, [r4, #28]
c0d021ec:	4620      	mov	r0, r4
c0d021ee:	3018      	adds	r0, #24
c0d021f0:	f7ff fe76 	bl	c0d01ee0 <os_ux>
c0d021f4:	61e0      	str	r0, [r4, #28]
c0d021f6:	f7ff f837 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d021fa:	60a5      	str	r5, [r4, #8]
c0d021fc:	6820      	ldr	r0, [r4, #0]
c0d021fe:	2800      	cmp	r0, #0
c0d02200:	d05f      	beq.n	c0d022c2 <ui_idle+0x102>
c0d02202:	69e0      	ldr	r0, [r4, #28]
c0d02204:	4930      	ldr	r1, [pc, #192]	; (c0d022c8 <ui_idle+0x108>)
c0d02206:	4288      	cmp	r0, r1
c0d02208:	d116      	bne.n	c0d02238 <ui_idle+0x78>
c0d0220a:	e05a      	b.n	c0d022c2 <ui_idle+0x102>
c0d0220c:	6860      	ldr	r0, [r4, #4]
c0d0220e:	4285      	cmp	r5, r0
c0d02210:	d257      	bcs.n	c0d022c2 <ui_idle+0x102>
c0d02212:	f7ff febd 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d02216:	2800      	cmp	r0, #0
c0d02218:	d153      	bne.n	c0d022c2 <ui_idle+0x102>
c0d0221a:	68a0      	ldr	r0, [r4, #8]
c0d0221c:	68e1      	ldr	r1, [r4, #12]
c0d0221e:	2538      	movs	r5, #56	; 0x38
c0d02220:	4368      	muls	r0, r5
c0d02222:	6822      	ldr	r2, [r4, #0]
c0d02224:	1810      	adds	r0, r2, r0
c0d02226:	2900      	cmp	r1, #0
c0d02228:	d040      	beq.n	c0d022ac <ui_idle+0xec>
c0d0222a:	4788      	blx	r1
c0d0222c:	2800      	cmp	r0, #0
c0d0222e:	d13d      	bne.n	c0d022ac <ui_idle+0xec>
c0d02230:	68a0      	ldr	r0, [r4, #8]
c0d02232:	1c45      	adds	r5, r0, #1
c0d02234:	60a5      	str	r5, [r4, #8]
c0d02236:	6820      	ldr	r0, [r4, #0]
c0d02238:	2800      	cmp	r0, #0
c0d0223a:	d1e7      	bne.n	c0d0220c <ui_idle+0x4c>
c0d0223c:	e041      	b.n	c0d022c2 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0223e:	4c21      	ldr	r4, [pc, #132]	; (c0d022c4 <ui_idle+0x104>)
c0d02240:	4822      	ldr	r0, [pc, #136]	; (c0d022cc <ui_idle+0x10c>)
c0d02242:	4478      	add	r0, pc
c0d02244:	6020      	str	r0, [r4, #0]
c0d02246:	2004      	movs	r0, #4
c0d02248:	6060      	str	r0, [r4, #4]
c0d0224a:	4821      	ldr	r0, [pc, #132]	; (c0d022d0 <ui_idle+0x110>)
c0d0224c:	4478      	add	r0, pc
c0d0224e:	6120      	str	r0, [r4, #16]
c0d02250:	2500      	movs	r5, #0
c0d02252:	60e5      	str	r5, [r4, #12]
c0d02254:	2003      	movs	r0, #3
c0d02256:	7620      	strb	r0, [r4, #24]
c0d02258:	61e5      	str	r5, [r4, #28]
c0d0225a:	4620      	mov	r0, r4
c0d0225c:	3018      	adds	r0, #24
c0d0225e:	f7ff fe3f 	bl	c0d01ee0 <os_ux>
c0d02262:	61e0      	str	r0, [r4, #28]
c0d02264:	f7ff f800 	bl	c0d01268 <io_seproxyhal_init_ux>
c0d02268:	60a5      	str	r5, [r4, #8]
c0d0226a:	6820      	ldr	r0, [r4, #0]
c0d0226c:	2800      	cmp	r0, #0
c0d0226e:	d028      	beq.n	c0d022c2 <ui_idle+0x102>
c0d02270:	69e0      	ldr	r0, [r4, #28]
c0d02272:	4915      	ldr	r1, [pc, #84]	; (c0d022c8 <ui_idle+0x108>)
c0d02274:	4288      	cmp	r0, r1
c0d02276:	d116      	bne.n	c0d022a6 <ui_idle+0xe6>
c0d02278:	e023      	b.n	c0d022c2 <ui_idle+0x102>
c0d0227a:	6860      	ldr	r0, [r4, #4]
c0d0227c:	4285      	cmp	r5, r0
c0d0227e:	d220      	bcs.n	c0d022c2 <ui_idle+0x102>
c0d02280:	f7ff fe86 	bl	c0d01f90 <io_seproxyhal_spi_is_status_sent>
c0d02284:	2800      	cmp	r0, #0
c0d02286:	d11c      	bne.n	c0d022c2 <ui_idle+0x102>
c0d02288:	68a0      	ldr	r0, [r4, #8]
c0d0228a:	68e1      	ldr	r1, [r4, #12]
c0d0228c:	2538      	movs	r5, #56	; 0x38
c0d0228e:	4368      	muls	r0, r5
c0d02290:	6822      	ldr	r2, [r4, #0]
c0d02292:	1810      	adds	r0, r2, r0
c0d02294:	2900      	cmp	r1, #0
c0d02296:	d009      	beq.n	c0d022ac <ui_idle+0xec>
c0d02298:	4788      	blx	r1
c0d0229a:	2800      	cmp	r0, #0
c0d0229c:	d106      	bne.n	c0d022ac <ui_idle+0xec>
c0d0229e:	68a0      	ldr	r0, [r4, #8]
c0d022a0:	1c45      	adds	r5, r0, #1
c0d022a2:	60a5      	str	r5, [r4, #8]
c0d022a4:	6820      	ldr	r0, [r4, #0]
c0d022a6:	2800      	cmp	r0, #0
c0d022a8:	d1e7      	bne.n	c0d0227a <ui_idle+0xba>
c0d022aa:	e00a      	b.n	c0d022c2 <ui_idle+0x102>
c0d022ac:	2801      	cmp	r0, #1
c0d022ae:	d103      	bne.n	c0d022b8 <ui_idle+0xf8>
c0d022b0:	68a0      	ldr	r0, [r4, #8]
c0d022b2:	4345      	muls	r5, r0
c0d022b4:	6820      	ldr	r0, [r4, #0]
c0d022b6:	1940      	adds	r0, r0, r5
c0d022b8:	f7fe fa8e 	bl	c0d007d8 <io_seproxyhal_display>
c0d022bc:	68a0      	ldr	r0, [r4, #8]
c0d022be:	1c40      	adds	r0, r0, #1
c0d022c0:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d022c2:	bdb0      	pop	{r4, r5, r7, pc}
c0d022c4:	20001a98 	.word	0x20001a98
c0d022c8:	b0105044 	.word	0xb0105044
c0d022cc:	0000156e 	.word	0x0000156e
c0d022d0:	0000008d 	.word	0x0000008d
c0d022d4:	0000141c 	.word	0x0000141c
c0d022d8:	fffffe27 	.word	0xfffffe27

c0d022dc <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d022dc:	2000      	movs	r0, #0
c0d022de:	4770      	bx	lr

c0d022e0 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d022e0:	b5d0      	push	{r4, r6, r7, lr}
c0d022e2:	af02      	add	r7, sp, #8
c0d022e4:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d022e6:	4620      	mov	r0, r4
c0d022e8:	f7ff fddc 	bl	c0d01ea4 <os_sched_exit>
    return NULL;
c0d022ec:	4620      	mov	r0, r4
c0d022ee:	bdd0      	pop	{r4, r6, r7, pc}

c0d022f0 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d022f0:	4902      	ldr	r1, [pc, #8]	; (c0d022fc <USBD_LL_Init+0xc>)
c0d022f2:	2000      	movs	r0, #0
c0d022f4:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d022f6:	4902      	ldr	r1, [pc, #8]	; (c0d02300 <USBD_LL_Init+0x10>)
c0d022f8:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d022fa:	4770      	bx	lr
c0d022fc:	20001d2c 	.word	0x20001d2c
c0d02300:	20001d30 	.word	0x20001d30

c0d02304 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02304:	b5d0      	push	{r4, r6, r7, lr}
c0d02306:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02308:	4806      	ldr	r0, [pc, #24]	; (c0d02324 <USBD_LL_DeInit+0x20>)
c0d0230a:	214f      	movs	r1, #79	; 0x4f
c0d0230c:	7001      	strb	r1, [r0, #0]
c0d0230e:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02310:	7044      	strb	r4, [r0, #1]
c0d02312:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02314:	7081      	strb	r1, [r0, #2]
c0d02316:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02318:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0231a:	2104      	movs	r1, #4
c0d0231c:	f7ff fe1a 	bl	c0d01f54 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02320:	4620      	mov	r0, r4
c0d02322:	bdd0      	pop	{r4, r6, r7, pc}
c0d02324:	20001a18 	.word	0x20001a18

c0d02328 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02328:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0232a:	af03      	add	r7, sp, #12
c0d0232c:	b083      	sub	sp, #12
c0d0232e:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02330:	264f      	movs	r6, #79	; 0x4f
c0d02332:	702e      	strb	r6, [r5, #0]
c0d02334:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02336:	706c      	strb	r4, [r5, #1]
c0d02338:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0233a:	70a8      	strb	r0, [r5, #2]
c0d0233c:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0233e:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02340:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02342:	2105      	movs	r1, #5
c0d02344:	4628      	mov	r0, r5
c0d02346:	f7ff fe05 	bl	c0d01f54 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0234a:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d0234c:	706c      	strb	r4, [r5, #1]
c0d0234e:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02350:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02352:	70e8      	strb	r0, [r5, #3]
c0d02354:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02356:	4628      	mov	r0, r5
c0d02358:	f7ff fdfc 	bl	c0d01f54 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0235c:	4620      	mov	r0, r4
c0d0235e:	b003      	add	sp, #12
c0d02360:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02362 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02362:	b5d0      	push	{r4, r6, r7, lr}
c0d02364:	af02      	add	r7, sp, #8
c0d02366:	b082      	sub	sp, #8
c0d02368:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0236a:	214f      	movs	r1, #79	; 0x4f
c0d0236c:	7001      	strb	r1, [r0, #0]
c0d0236e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02370:	7044      	strb	r4, [r0, #1]
c0d02372:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02374:	7081      	strb	r1, [r0, #2]
c0d02376:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02378:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d0237a:	2104      	movs	r1, #4
c0d0237c:	f7ff fdea 	bl	c0d01f54 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02380:	4620      	mov	r0, r4
c0d02382:	b002      	add	sp, #8
c0d02384:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02388 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02388:	b5b0      	push	{r4, r5, r7, lr}
c0d0238a:	af02      	add	r7, sp, #8
c0d0238c:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0238e:	480f      	ldr	r0, [pc, #60]	; (c0d023cc <USBD_LL_OpenEP+0x44>)
c0d02390:	2400      	movs	r4, #0
c0d02392:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02394:	480e      	ldr	r0, [pc, #56]	; (c0d023d0 <USBD_LL_OpenEP+0x48>)
c0d02396:	6004      	str	r4, [r0, #0]
c0d02398:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0239a:	254f      	movs	r5, #79	; 0x4f
c0d0239c:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0239e:	7044      	strb	r4, [r0, #1]
c0d023a0:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d023a2:	7085      	strb	r5, [r0, #2]
c0d023a4:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d023a6:	70c5      	strb	r5, [r0, #3]
c0d023a8:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d023aa:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d023ac:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d023ae:	2a03      	cmp	r2, #3
c0d023b0:	d802      	bhi.n	c0d023b8 <USBD_LL_OpenEP+0x30>
c0d023b2:	00d0      	lsls	r0, r2, #3
c0d023b4:	4c07      	ldr	r4, [pc, #28]	; (c0d023d4 <USBD_LL_OpenEP+0x4c>)
c0d023b6:	40c4      	lsrs	r4, r0
c0d023b8:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d023ba:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d023bc:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d023be:	2108      	movs	r1, #8
c0d023c0:	f7ff fdc8 	bl	c0d01f54 <io_seproxyhal_spi_send>
c0d023c4:	2000      	movs	r0, #0
  return USBD_OK; 
c0d023c6:	b002      	add	sp, #8
c0d023c8:	bdb0      	pop	{r4, r5, r7, pc}
c0d023ca:	46c0      	nop			; (mov r8, r8)
c0d023cc:	20001d2c 	.word	0x20001d2c
c0d023d0:	20001d30 	.word	0x20001d30
c0d023d4:	02030401 	.word	0x02030401

c0d023d8 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d023d8:	b5d0      	push	{r4, r6, r7, lr}
c0d023da:	af02      	add	r7, sp, #8
c0d023dc:	b082      	sub	sp, #8
c0d023de:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d023e0:	224f      	movs	r2, #79	; 0x4f
c0d023e2:	7002      	strb	r2, [r0, #0]
c0d023e4:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d023e6:	7044      	strb	r4, [r0, #1]
c0d023e8:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d023ea:	7082      	strb	r2, [r0, #2]
c0d023ec:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d023ee:	70c2      	strb	r2, [r0, #3]
c0d023f0:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d023f2:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d023f4:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d023f6:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d023f8:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d023fa:	2108      	movs	r1, #8
c0d023fc:	f7ff fdaa 	bl	c0d01f54 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02400:	4620      	mov	r0, r4
c0d02402:	b002      	add	sp, #8
c0d02404:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02408 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02408:	b5b0      	push	{r4, r5, r7, lr}
c0d0240a:	af02      	add	r7, sp, #8
c0d0240c:	b082      	sub	sp, #8
c0d0240e:	460d      	mov	r5, r1
c0d02410:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02412:	2150      	movs	r1, #80	; 0x50
c0d02414:	7001      	strb	r1, [r0, #0]
c0d02416:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02418:	7044      	strb	r4, [r0, #1]
c0d0241a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d0241c:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0241e:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02420:	2140      	movs	r1, #64	; 0x40
c0d02422:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02424:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02426:	2106      	movs	r1, #6
c0d02428:	f7ff fd94 	bl	c0d01f54 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d0242c:	2080      	movs	r0, #128	; 0x80
c0d0242e:	4205      	tst	r5, r0
c0d02430:	d101      	bne.n	c0d02436 <USBD_LL_StallEP+0x2e>
c0d02432:	4807      	ldr	r0, [pc, #28]	; (c0d02450 <USBD_LL_StallEP+0x48>)
c0d02434:	e000      	b.n	c0d02438 <USBD_LL_StallEP+0x30>
c0d02436:	4805      	ldr	r0, [pc, #20]	; (c0d0244c <USBD_LL_StallEP+0x44>)
c0d02438:	6801      	ldr	r1, [r0, #0]
c0d0243a:	227f      	movs	r2, #127	; 0x7f
c0d0243c:	4015      	ands	r5, r2
c0d0243e:	2201      	movs	r2, #1
c0d02440:	40aa      	lsls	r2, r5
c0d02442:	430a      	orrs	r2, r1
c0d02444:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02446:	4620      	mov	r0, r4
c0d02448:	b002      	add	sp, #8
c0d0244a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0244c:	20001d2c 	.word	0x20001d2c
c0d02450:	20001d30 	.word	0x20001d30

c0d02454 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02454:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02456:	af03      	add	r7, sp, #12
c0d02458:	b083      	sub	sp, #12
c0d0245a:	460d      	mov	r5, r1
c0d0245c:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0245e:	2150      	movs	r1, #80	; 0x50
c0d02460:	7001      	strb	r1, [r0, #0]
c0d02462:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02464:	7044      	strb	r4, [r0, #1]
c0d02466:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02468:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0246a:	70c5      	strb	r5, [r0, #3]
c0d0246c:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0246e:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02470:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02472:	2106      	movs	r1, #6
c0d02474:	f7ff fd6e 	bl	c0d01f54 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02478:	4235      	tst	r5, r6
c0d0247a:	d101      	bne.n	c0d02480 <USBD_LL_ClearStallEP+0x2c>
c0d0247c:	4807      	ldr	r0, [pc, #28]	; (c0d0249c <USBD_LL_ClearStallEP+0x48>)
c0d0247e:	e000      	b.n	c0d02482 <USBD_LL_ClearStallEP+0x2e>
c0d02480:	4805      	ldr	r0, [pc, #20]	; (c0d02498 <USBD_LL_ClearStallEP+0x44>)
c0d02482:	6801      	ldr	r1, [r0, #0]
c0d02484:	227f      	movs	r2, #127	; 0x7f
c0d02486:	4015      	ands	r5, r2
c0d02488:	2201      	movs	r2, #1
c0d0248a:	40aa      	lsls	r2, r5
c0d0248c:	4391      	bics	r1, r2
c0d0248e:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02490:	4620      	mov	r0, r4
c0d02492:	b003      	add	sp, #12
c0d02494:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02496:	46c0      	nop			; (mov r8, r8)
c0d02498:	20001d2c 	.word	0x20001d2c
c0d0249c:	20001d30 	.word	0x20001d30

c0d024a0 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d024a0:	2080      	movs	r0, #128	; 0x80
c0d024a2:	4201      	tst	r1, r0
c0d024a4:	d001      	beq.n	c0d024aa <USBD_LL_IsStallEP+0xa>
c0d024a6:	4806      	ldr	r0, [pc, #24]	; (c0d024c0 <USBD_LL_IsStallEP+0x20>)
c0d024a8:	e000      	b.n	c0d024ac <USBD_LL_IsStallEP+0xc>
c0d024aa:	4804      	ldr	r0, [pc, #16]	; (c0d024bc <USBD_LL_IsStallEP+0x1c>)
c0d024ac:	6800      	ldr	r0, [r0, #0]
c0d024ae:	227f      	movs	r2, #127	; 0x7f
c0d024b0:	4011      	ands	r1, r2
c0d024b2:	2201      	movs	r2, #1
c0d024b4:	408a      	lsls	r2, r1
c0d024b6:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d024b8:	b2d0      	uxtb	r0, r2
c0d024ba:	4770      	bx	lr
c0d024bc:	20001d30 	.word	0x20001d30
c0d024c0:	20001d2c 	.word	0x20001d2c

c0d024c4 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d024c4:	b5d0      	push	{r4, r6, r7, lr}
c0d024c6:	af02      	add	r7, sp, #8
c0d024c8:	b082      	sub	sp, #8
c0d024ca:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d024cc:	224f      	movs	r2, #79	; 0x4f
c0d024ce:	7002      	strb	r2, [r0, #0]
c0d024d0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d024d2:	7044      	strb	r4, [r0, #1]
c0d024d4:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d024d6:	7082      	strb	r2, [r0, #2]
c0d024d8:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d024da:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d024dc:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d024de:	2105      	movs	r1, #5
c0d024e0:	f7ff fd38 	bl	c0d01f54 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d024e4:	4620      	mov	r0, r4
c0d024e6:	b002      	add	sp, #8
c0d024e8:	bdd0      	pop	{r4, r6, r7, pc}

c0d024ea <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d024ea:	b5b0      	push	{r4, r5, r7, lr}
c0d024ec:	af02      	add	r7, sp, #8
c0d024ee:	b082      	sub	sp, #8
c0d024f0:	461c      	mov	r4, r3
c0d024f2:	4615      	mov	r5, r2
c0d024f4:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d024f6:	2250      	movs	r2, #80	; 0x50
c0d024f8:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d024fa:	1ce2      	adds	r2, r4, #3
c0d024fc:	0a13      	lsrs	r3, r2, #8
c0d024fe:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02500:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02502:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02504:	2120      	movs	r1, #32
c0d02506:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02508:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0250a:	2106      	movs	r1, #6
c0d0250c:	f7ff fd22 	bl	c0d01f54 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02510:	4628      	mov	r0, r5
c0d02512:	4621      	mov	r1, r4
c0d02514:	f7ff fd1e 	bl	c0d01f54 <io_seproxyhal_spi_send>
c0d02518:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0251a:	b002      	add	sp, #8
c0d0251c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0251e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0251e:	b5d0      	push	{r4, r6, r7, lr}
c0d02520:	af02      	add	r7, sp, #8
c0d02522:	b082      	sub	sp, #8
c0d02524:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02526:	2350      	movs	r3, #80	; 0x50
c0d02528:	7003      	strb	r3, [r0, #0]
c0d0252a:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d0252c:	7044      	strb	r4, [r0, #1]
c0d0252e:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02530:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02532:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02534:	2130      	movs	r1, #48	; 0x30
c0d02536:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02538:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0253a:	2106      	movs	r1, #6
c0d0253c:	f7ff fd0a 	bl	c0d01f54 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02540:	4620      	mov	r0, r4
c0d02542:	b002      	add	sp, #8
c0d02544:	bdd0      	pop	{r4, r6, r7, pc}

c0d02546 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02546:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02548:	af03      	add	r7, sp, #12
c0d0254a:	b081      	sub	sp, #4
c0d0254c:	4615      	mov	r5, r2
c0d0254e:	460e      	mov	r6, r1
c0d02550:	4604      	mov	r4, r0
c0d02552:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02554:	2c00      	cmp	r4, #0
c0d02556:	d011      	beq.n	c0d0257c <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02558:	2049      	movs	r0, #73	; 0x49
c0d0255a:	0081      	lsls	r1, r0, #2
c0d0255c:	4620      	mov	r0, r4
c0d0255e:	f000 fef9 	bl	c0d03354 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02562:	2e00      	cmp	r6, #0
c0d02564:	d002      	beq.n	c0d0256c <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02566:	2011      	movs	r0, #17
c0d02568:	0100      	lsls	r0, r0, #4
c0d0256a:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d0256c:	20fc      	movs	r0, #252	; 0xfc
c0d0256e:	2101      	movs	r1, #1
c0d02570:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02572:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02574:	4620      	mov	r0, r4
c0d02576:	f7ff febb 	bl	c0d022f0 <USBD_LL_Init>
c0d0257a:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d0257c:	b2c0      	uxtb	r0, r0
c0d0257e:	b001      	add	sp, #4
c0d02580:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02582 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02582:	b5d0      	push	{r4, r6, r7, lr}
c0d02584:	af02      	add	r7, sp, #8
c0d02586:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02588:	20fc      	movs	r0, #252	; 0xfc
c0d0258a:	2101      	movs	r1, #1
c0d0258c:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d0258e:	2045      	movs	r0, #69	; 0x45
c0d02590:	0080      	lsls	r0, r0, #2
c0d02592:	5820      	ldr	r0, [r4, r0]
c0d02594:	2800      	cmp	r0, #0
c0d02596:	d006      	beq.n	c0d025a6 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02598:	6840      	ldr	r0, [r0, #4]
c0d0259a:	f7ff fb1f 	bl	c0d01bdc <pic>
c0d0259e:	4602      	mov	r2, r0
c0d025a0:	7921      	ldrb	r1, [r4, #4]
c0d025a2:	4620      	mov	r0, r4
c0d025a4:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d025a6:	4620      	mov	r0, r4
c0d025a8:	f7ff fedb 	bl	c0d02362 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d025ac:	4620      	mov	r0, r4
c0d025ae:	f7ff fea9 	bl	c0d02304 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d025b2:	2000      	movs	r0, #0
c0d025b4:	bdd0      	pop	{r4, r6, r7, pc}

c0d025b6 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d025b6:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d025b8:	2900      	cmp	r1, #0
c0d025ba:	d003      	beq.n	c0d025c4 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d025bc:	2245      	movs	r2, #69	; 0x45
c0d025be:	0092      	lsls	r2, r2, #2
c0d025c0:	5081      	str	r1, [r0, r2]
c0d025c2:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d025c4:	b2d0      	uxtb	r0, r2
c0d025c6:	4770      	bx	lr

c0d025c8 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d025c8:	b580      	push	{r7, lr}
c0d025ca:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d025cc:	f7ff feac 	bl	c0d02328 <USBD_LL_Start>
  
  return USBD_OK;  
c0d025d0:	2000      	movs	r0, #0
c0d025d2:	bd80      	pop	{r7, pc}

c0d025d4 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d025d4:	b5b0      	push	{r4, r5, r7, lr}
c0d025d6:	af02      	add	r7, sp, #8
c0d025d8:	460c      	mov	r4, r1
c0d025da:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d025dc:	2045      	movs	r0, #69	; 0x45
c0d025de:	0080      	lsls	r0, r0, #2
c0d025e0:	5828      	ldr	r0, [r5, r0]
c0d025e2:	2800      	cmp	r0, #0
c0d025e4:	d00c      	beq.n	c0d02600 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d025e6:	6800      	ldr	r0, [r0, #0]
c0d025e8:	f7ff faf8 	bl	c0d01bdc <pic>
c0d025ec:	4602      	mov	r2, r0
c0d025ee:	4628      	mov	r0, r5
c0d025f0:	4621      	mov	r1, r4
c0d025f2:	4790      	blx	r2
c0d025f4:	4601      	mov	r1, r0
c0d025f6:	2002      	movs	r0, #2
c0d025f8:	2900      	cmp	r1, #0
c0d025fa:	d100      	bne.n	c0d025fe <USBD_SetClassConfig+0x2a>
c0d025fc:	4608      	mov	r0, r1
c0d025fe:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02600:	2002      	movs	r0, #2
c0d02602:	bdb0      	pop	{r4, r5, r7, pc}

c0d02604 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02604:	b5b0      	push	{r4, r5, r7, lr}
c0d02606:	af02      	add	r7, sp, #8
c0d02608:	460c      	mov	r4, r1
c0d0260a:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d0260c:	2045      	movs	r0, #69	; 0x45
c0d0260e:	0080      	lsls	r0, r0, #2
c0d02610:	5828      	ldr	r0, [r5, r0]
c0d02612:	2800      	cmp	r0, #0
c0d02614:	d006      	beq.n	c0d02624 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02616:	6840      	ldr	r0, [r0, #4]
c0d02618:	f7ff fae0 	bl	c0d01bdc <pic>
c0d0261c:	4602      	mov	r2, r0
c0d0261e:	4628      	mov	r0, r5
c0d02620:	4621      	mov	r1, r4
c0d02622:	4790      	blx	r2
  }
  return USBD_OK;
c0d02624:	2000      	movs	r0, #0
c0d02626:	bdb0      	pop	{r4, r5, r7, pc}

c0d02628 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02628:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0262a:	af03      	add	r7, sp, #12
c0d0262c:	b081      	sub	sp, #4
c0d0262e:	4604      	mov	r4, r0
c0d02630:	2021      	movs	r0, #33	; 0x21
c0d02632:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02634:	19a5      	adds	r5, r4, r6
c0d02636:	4628      	mov	r0, r5
c0d02638:	f000 fb69 	bl	c0d02d0e <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d0263c:	20f4      	movs	r0, #244	; 0xf4
c0d0263e:	2101      	movs	r1, #1
c0d02640:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02642:	2087      	movs	r0, #135	; 0x87
c0d02644:	0040      	lsls	r0, r0, #1
c0d02646:	5a20      	ldrh	r0, [r4, r0]
c0d02648:	21f8      	movs	r1, #248	; 0xf8
c0d0264a:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d0264c:	5da1      	ldrb	r1, [r4, r6]
c0d0264e:	201f      	movs	r0, #31
c0d02650:	4008      	ands	r0, r1
c0d02652:	2802      	cmp	r0, #2
c0d02654:	d008      	beq.n	c0d02668 <USBD_LL_SetupStage+0x40>
c0d02656:	2801      	cmp	r0, #1
c0d02658:	d00b      	beq.n	c0d02672 <USBD_LL_SetupStage+0x4a>
c0d0265a:	2800      	cmp	r0, #0
c0d0265c:	d10e      	bne.n	c0d0267c <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d0265e:	4620      	mov	r0, r4
c0d02660:	4629      	mov	r1, r5
c0d02662:	f000 f8f1 	bl	c0d02848 <USBD_StdDevReq>
c0d02666:	e00e      	b.n	c0d02686 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02668:	4620      	mov	r0, r4
c0d0266a:	4629      	mov	r1, r5
c0d0266c:	f000 fad3 	bl	c0d02c16 <USBD_StdEPReq>
c0d02670:	e009      	b.n	c0d02686 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02672:	4620      	mov	r0, r4
c0d02674:	4629      	mov	r1, r5
c0d02676:	f000 faa6 	bl	c0d02bc6 <USBD_StdItfReq>
c0d0267a:	e004      	b.n	c0d02686 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d0267c:	2080      	movs	r0, #128	; 0x80
c0d0267e:	4001      	ands	r1, r0
c0d02680:	4620      	mov	r0, r4
c0d02682:	f7ff fec1 	bl	c0d02408 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02686:	2000      	movs	r0, #0
c0d02688:	b001      	add	sp, #4
c0d0268a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0268c <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d0268c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0268e:	af03      	add	r7, sp, #12
c0d02690:	b081      	sub	sp, #4
c0d02692:	4615      	mov	r5, r2
c0d02694:	460e      	mov	r6, r1
c0d02696:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02698:	2e00      	cmp	r6, #0
c0d0269a:	d011      	beq.n	c0d026c0 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d0269c:	2045      	movs	r0, #69	; 0x45
c0d0269e:	0080      	lsls	r0, r0, #2
c0d026a0:	5820      	ldr	r0, [r4, r0]
c0d026a2:	6980      	ldr	r0, [r0, #24]
c0d026a4:	2800      	cmp	r0, #0
c0d026a6:	d034      	beq.n	c0d02712 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d026a8:	21fc      	movs	r1, #252	; 0xfc
c0d026aa:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d026ac:	2903      	cmp	r1, #3
c0d026ae:	d130      	bne.n	c0d02712 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d026b0:	f7ff fa94 	bl	c0d01bdc <pic>
c0d026b4:	4603      	mov	r3, r0
c0d026b6:	4620      	mov	r0, r4
c0d026b8:	4631      	mov	r1, r6
c0d026ba:	462a      	mov	r2, r5
c0d026bc:	4798      	blx	r3
c0d026be:	e028      	b.n	c0d02712 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d026c0:	20f4      	movs	r0, #244	; 0xf4
c0d026c2:	5820      	ldr	r0, [r4, r0]
c0d026c4:	2803      	cmp	r0, #3
c0d026c6:	d124      	bne.n	c0d02712 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d026c8:	2090      	movs	r0, #144	; 0x90
c0d026ca:	5820      	ldr	r0, [r4, r0]
c0d026cc:	218c      	movs	r1, #140	; 0x8c
c0d026ce:	5861      	ldr	r1, [r4, r1]
c0d026d0:	4622      	mov	r2, r4
c0d026d2:	328c      	adds	r2, #140	; 0x8c
c0d026d4:	4281      	cmp	r1, r0
c0d026d6:	d90a      	bls.n	c0d026ee <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d026d8:	1a09      	subs	r1, r1, r0
c0d026da:	6011      	str	r1, [r2, #0]
c0d026dc:	4281      	cmp	r1, r0
c0d026de:	d300      	bcc.n	c0d026e2 <USBD_LL_DataOutStage+0x56>
c0d026e0:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d026e2:	b28a      	uxth	r2, r1
c0d026e4:	4620      	mov	r0, r4
c0d026e6:	4629      	mov	r1, r5
c0d026e8:	f000 fc70 	bl	c0d02fcc <USBD_CtlContinueRx>
c0d026ec:	e011      	b.n	c0d02712 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d026ee:	2045      	movs	r0, #69	; 0x45
c0d026f0:	0080      	lsls	r0, r0, #2
c0d026f2:	5820      	ldr	r0, [r4, r0]
c0d026f4:	6900      	ldr	r0, [r0, #16]
c0d026f6:	2800      	cmp	r0, #0
c0d026f8:	d008      	beq.n	c0d0270c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d026fa:	21fc      	movs	r1, #252	; 0xfc
c0d026fc:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d026fe:	2903      	cmp	r1, #3
c0d02700:	d104      	bne.n	c0d0270c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02702:	f7ff fa6b 	bl	c0d01bdc <pic>
c0d02706:	4601      	mov	r1, r0
c0d02708:	4620      	mov	r0, r4
c0d0270a:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d0270c:	4620      	mov	r0, r4
c0d0270e:	f000 fc65 	bl	c0d02fdc <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02712:	2000      	movs	r0, #0
c0d02714:	b001      	add	sp, #4
c0d02716:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02718 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02718:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0271a:	af03      	add	r7, sp, #12
c0d0271c:	b081      	sub	sp, #4
c0d0271e:	460d      	mov	r5, r1
c0d02720:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02722:	2d00      	cmp	r5, #0
c0d02724:	d012      	beq.n	c0d0274c <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02726:	2045      	movs	r0, #69	; 0x45
c0d02728:	0080      	lsls	r0, r0, #2
c0d0272a:	5820      	ldr	r0, [r4, r0]
c0d0272c:	2800      	cmp	r0, #0
c0d0272e:	d054      	beq.n	c0d027da <USBD_LL_DataInStage+0xc2>
c0d02730:	6940      	ldr	r0, [r0, #20]
c0d02732:	2800      	cmp	r0, #0
c0d02734:	d051      	beq.n	c0d027da <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02736:	21fc      	movs	r1, #252	; 0xfc
c0d02738:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0273a:	2903      	cmp	r1, #3
c0d0273c:	d14d      	bne.n	c0d027da <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d0273e:	f7ff fa4d 	bl	c0d01bdc <pic>
c0d02742:	4602      	mov	r2, r0
c0d02744:	4620      	mov	r0, r4
c0d02746:	4629      	mov	r1, r5
c0d02748:	4790      	blx	r2
c0d0274a:	e046      	b.n	c0d027da <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d0274c:	20f4      	movs	r0, #244	; 0xf4
c0d0274e:	5820      	ldr	r0, [r4, r0]
c0d02750:	2802      	cmp	r0, #2
c0d02752:	d13a      	bne.n	c0d027ca <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02754:	69e0      	ldr	r0, [r4, #28]
c0d02756:	6a25      	ldr	r5, [r4, #32]
c0d02758:	42a8      	cmp	r0, r5
c0d0275a:	d90b      	bls.n	c0d02774 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d0275c:	1b40      	subs	r0, r0, r5
c0d0275e:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02760:	2109      	movs	r1, #9
c0d02762:	014a      	lsls	r2, r1, #5
c0d02764:	58a1      	ldr	r1, [r4, r2]
c0d02766:	1949      	adds	r1, r1, r5
c0d02768:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d0276a:	b282      	uxth	r2, r0
c0d0276c:	4620      	mov	r0, r4
c0d0276e:	f000 fc1e 	bl	c0d02fae <USBD_CtlContinueSendData>
c0d02772:	e02a      	b.n	c0d027ca <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02774:	69a6      	ldr	r6, [r4, #24]
c0d02776:	4630      	mov	r0, r6
c0d02778:	4629      	mov	r1, r5
c0d0277a:	f000 fccf 	bl	c0d0311c <__aeabi_uidivmod>
c0d0277e:	42ae      	cmp	r6, r5
c0d02780:	d30f      	bcc.n	c0d027a2 <USBD_LL_DataInStage+0x8a>
c0d02782:	2900      	cmp	r1, #0
c0d02784:	d10d      	bne.n	c0d027a2 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02786:	20f8      	movs	r0, #248	; 0xf8
c0d02788:	5820      	ldr	r0, [r4, r0]
c0d0278a:	4625      	mov	r5, r4
c0d0278c:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d0278e:	4286      	cmp	r6, r0
c0d02790:	d207      	bcs.n	c0d027a2 <USBD_LL_DataInStage+0x8a>
c0d02792:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02794:	4620      	mov	r0, r4
c0d02796:	4631      	mov	r1, r6
c0d02798:	4632      	mov	r2, r6
c0d0279a:	f000 fc08 	bl	c0d02fae <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d0279e:	602e      	str	r6, [r5, #0]
c0d027a0:	e013      	b.n	c0d027ca <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d027a2:	2045      	movs	r0, #69	; 0x45
c0d027a4:	0080      	lsls	r0, r0, #2
c0d027a6:	5820      	ldr	r0, [r4, r0]
c0d027a8:	2800      	cmp	r0, #0
c0d027aa:	d00b      	beq.n	c0d027c4 <USBD_LL_DataInStage+0xac>
c0d027ac:	68c0      	ldr	r0, [r0, #12]
c0d027ae:	2800      	cmp	r0, #0
c0d027b0:	d008      	beq.n	c0d027c4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d027b2:	21fc      	movs	r1, #252	; 0xfc
c0d027b4:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d027b6:	2903      	cmp	r1, #3
c0d027b8:	d104      	bne.n	c0d027c4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d027ba:	f7ff fa0f 	bl	c0d01bdc <pic>
c0d027be:	4601      	mov	r1, r0
c0d027c0:	4620      	mov	r0, r4
c0d027c2:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d027c4:	4620      	mov	r0, r4
c0d027c6:	f000 fc16 	bl	c0d02ff6 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d027ca:	2001      	movs	r0, #1
c0d027cc:	0201      	lsls	r1, r0, #8
c0d027ce:	1860      	adds	r0, r4, r1
c0d027d0:	5c61      	ldrb	r1, [r4, r1]
c0d027d2:	2901      	cmp	r1, #1
c0d027d4:	d101      	bne.n	c0d027da <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d027d6:	2100      	movs	r1, #0
c0d027d8:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d027da:	2000      	movs	r0, #0
c0d027dc:	b001      	add	sp, #4
c0d027de:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d027e0 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d027e0:	b5d0      	push	{r4, r6, r7, lr}
c0d027e2:	af02      	add	r7, sp, #8
c0d027e4:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d027e6:	2090      	movs	r0, #144	; 0x90
c0d027e8:	2140      	movs	r1, #64	; 0x40
c0d027ea:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d027ec:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d027ee:	20fc      	movs	r0, #252	; 0xfc
c0d027f0:	2101      	movs	r1, #1
c0d027f2:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d027f4:	2045      	movs	r0, #69	; 0x45
c0d027f6:	0080      	lsls	r0, r0, #2
c0d027f8:	5820      	ldr	r0, [r4, r0]
c0d027fa:	2800      	cmp	r0, #0
c0d027fc:	d006      	beq.n	c0d0280c <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d027fe:	6840      	ldr	r0, [r0, #4]
c0d02800:	f7ff f9ec 	bl	c0d01bdc <pic>
c0d02804:	4602      	mov	r2, r0
c0d02806:	7921      	ldrb	r1, [r4, #4]
c0d02808:	4620      	mov	r0, r4
c0d0280a:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d0280c:	2000      	movs	r0, #0
c0d0280e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02810 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02810:	7401      	strb	r1, [r0, #16]
c0d02812:	2000      	movs	r0, #0
  return USBD_OK;
c0d02814:	4770      	bx	lr

c0d02816 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02816:	2000      	movs	r0, #0
c0d02818:	4770      	bx	lr

c0d0281a <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d0281a:	2000      	movs	r0, #0
c0d0281c:	4770      	bx	lr

c0d0281e <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d0281e:	b5d0      	push	{r4, r6, r7, lr}
c0d02820:	af02      	add	r7, sp, #8
c0d02822:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02824:	20fc      	movs	r0, #252	; 0xfc
c0d02826:	5c20      	ldrb	r0, [r4, r0]
c0d02828:	2803      	cmp	r0, #3
c0d0282a:	d10a      	bne.n	c0d02842 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d0282c:	2045      	movs	r0, #69	; 0x45
c0d0282e:	0080      	lsls	r0, r0, #2
c0d02830:	5820      	ldr	r0, [r4, r0]
c0d02832:	69c0      	ldr	r0, [r0, #28]
c0d02834:	2800      	cmp	r0, #0
c0d02836:	d004      	beq.n	c0d02842 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02838:	f7ff f9d0 	bl	c0d01bdc <pic>
c0d0283c:	4601      	mov	r1, r0
c0d0283e:	4620      	mov	r0, r4
c0d02840:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02842:	2000      	movs	r0, #0
c0d02844:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02848 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02848:	b5d0      	push	{r4, r6, r7, lr}
c0d0284a:	af02      	add	r7, sp, #8
c0d0284c:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d0284e:	7848      	ldrb	r0, [r1, #1]
c0d02850:	2809      	cmp	r0, #9
c0d02852:	d810      	bhi.n	c0d02876 <USBD_StdDevReq+0x2e>
c0d02854:	4478      	add	r0, pc
c0d02856:	7900      	ldrb	r0, [r0, #4]
c0d02858:	0040      	lsls	r0, r0, #1
c0d0285a:	4487      	add	pc, r0
c0d0285c:	150c0804 	.word	0x150c0804
c0d02860:	0c25190c 	.word	0x0c25190c
c0d02864:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02866:	4620      	mov	r0, r4
c0d02868:	f000 f938 	bl	c0d02adc <USBD_GetStatus>
c0d0286c:	e01f      	b.n	c0d028ae <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d0286e:	4620      	mov	r0, r4
c0d02870:	f000 f976 	bl	c0d02b60 <USBD_ClrFeature>
c0d02874:	e01b      	b.n	c0d028ae <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02876:	2180      	movs	r1, #128	; 0x80
c0d02878:	4620      	mov	r0, r4
c0d0287a:	f7ff fdc5 	bl	c0d02408 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0287e:	2100      	movs	r1, #0
c0d02880:	4620      	mov	r0, r4
c0d02882:	f7ff fdc1 	bl	c0d02408 <USBD_LL_StallEP>
c0d02886:	e012      	b.n	c0d028ae <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02888:	4620      	mov	r0, r4
c0d0288a:	f000 f950 	bl	c0d02b2e <USBD_SetFeature>
c0d0288e:	e00e      	b.n	c0d028ae <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02890:	4620      	mov	r0, r4
c0d02892:	f000 f897 	bl	c0d029c4 <USBD_SetAddress>
c0d02896:	e00a      	b.n	c0d028ae <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02898:	4620      	mov	r0, r4
c0d0289a:	f000 f8ff 	bl	c0d02a9c <USBD_GetConfig>
c0d0289e:	e006      	b.n	c0d028ae <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d028a0:	4620      	mov	r0, r4
c0d028a2:	f000 f8bd 	bl	c0d02a20 <USBD_SetConfig>
c0d028a6:	e002      	b.n	c0d028ae <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d028a8:	4620      	mov	r0, r4
c0d028aa:	f000 f803 	bl	c0d028b4 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d028ae:	2000      	movs	r0, #0
c0d028b0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d028b4 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d028b4:	b5b0      	push	{r4, r5, r7, lr}
c0d028b6:	af02      	add	r7, sp, #8
c0d028b8:	b082      	sub	sp, #8
c0d028ba:	460d      	mov	r5, r1
c0d028bc:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d028be:	8868      	ldrh	r0, [r5, #2]
c0d028c0:	0a01      	lsrs	r1, r0, #8
c0d028c2:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028c4:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d028c6:	2a0e      	cmp	r2, #14
c0d028c8:	d83e      	bhi.n	c0d02948 <USBD_GetDescriptor+0x94>
c0d028ca:	46c0      	nop			; (mov r8, r8)
c0d028cc:	447a      	add	r2, pc
c0d028ce:	7912      	ldrb	r2, [r2, #4]
c0d028d0:	0052      	lsls	r2, r2, #1
c0d028d2:	4497      	add	pc, r2
c0d028d4:	390c2607 	.word	0x390c2607
c0d028d8:	39362e39 	.word	0x39362e39
c0d028dc:	39393939 	.word	0x39393939
c0d028e0:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d028e4:	2011      	movs	r0, #17
c0d028e6:	0100      	lsls	r0, r0, #4
c0d028e8:	5820      	ldr	r0, [r4, r0]
c0d028ea:	6800      	ldr	r0, [r0, #0]
c0d028ec:	e012      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d028ee:	b2c0      	uxtb	r0, r0
c0d028f0:	2805      	cmp	r0, #5
c0d028f2:	d829      	bhi.n	c0d02948 <USBD_GetDescriptor+0x94>
c0d028f4:	4478      	add	r0, pc
c0d028f6:	7900      	ldrb	r0, [r0, #4]
c0d028f8:	0040      	lsls	r0, r0, #1
c0d028fa:	4487      	add	pc, r0
c0d028fc:	544f4a02 	.word	0x544f4a02
c0d02900:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02902:	2011      	movs	r0, #17
c0d02904:	0100      	lsls	r0, r0, #4
c0d02906:	5820      	ldr	r0, [r4, r0]
c0d02908:	6840      	ldr	r0, [r0, #4]
c0d0290a:	e003      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d0290c:	2011      	movs	r0, #17
c0d0290e:	0100      	lsls	r0, r0, #4
c0d02910:	5820      	ldr	r0, [r4, r0]
c0d02912:	69c0      	ldr	r0, [r0, #28]
c0d02914:	f7ff f962 	bl	c0d01bdc <pic>
c0d02918:	4602      	mov	r2, r0
c0d0291a:	7c20      	ldrb	r0, [r4, #16]
c0d0291c:	a901      	add	r1, sp, #4
c0d0291e:	4790      	blx	r2
c0d02920:	e025      	b.n	c0d0296e <USBD_GetDescriptor+0xba>
c0d02922:	2045      	movs	r0, #69	; 0x45
c0d02924:	0080      	lsls	r0, r0, #2
c0d02926:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02928:	7c21      	ldrb	r1, [r4, #16]
c0d0292a:	2900      	cmp	r1, #0
c0d0292c:	d014      	beq.n	c0d02958 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d0292e:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02930:	e018      	b.n	c0d02964 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02932:	7c20      	ldrb	r0, [r4, #16]
c0d02934:	2800      	cmp	r0, #0
c0d02936:	d107      	bne.n	c0d02948 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02938:	2045      	movs	r0, #69	; 0x45
c0d0293a:	0080      	lsls	r0, r0, #2
c0d0293c:	5820      	ldr	r0, [r4, r0]
c0d0293e:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02940:	e010      	b.n	c0d02964 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02942:	7c20      	ldrb	r0, [r4, #16]
c0d02944:	2800      	cmp	r0, #0
c0d02946:	d009      	beq.n	c0d0295c <USBD_GetDescriptor+0xa8>
c0d02948:	4620      	mov	r0, r4
c0d0294a:	f7ff fd5d 	bl	c0d02408 <USBD_LL_StallEP>
c0d0294e:	2100      	movs	r1, #0
c0d02950:	4620      	mov	r0, r4
c0d02952:	f7ff fd59 	bl	c0d02408 <USBD_LL_StallEP>
c0d02956:	e01a      	b.n	c0d0298e <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02958:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d0295a:	e003      	b.n	c0d02964 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d0295c:	2045      	movs	r0, #69	; 0x45
c0d0295e:	0080      	lsls	r0, r0, #2
c0d02960:	5820      	ldr	r0, [r4, r0]
c0d02962:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02964:	f7ff f93a 	bl	c0d01bdc <pic>
c0d02968:	4601      	mov	r1, r0
c0d0296a:	a801      	add	r0, sp, #4
c0d0296c:	4788      	blx	r1
c0d0296e:	4601      	mov	r1, r0
c0d02970:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02972:	8802      	ldrh	r2, [r0, #0]
c0d02974:	2a00      	cmp	r2, #0
c0d02976:	d00a      	beq.n	c0d0298e <USBD_GetDescriptor+0xda>
c0d02978:	88e8      	ldrh	r0, [r5, #6]
c0d0297a:	2800      	cmp	r0, #0
c0d0297c:	d007      	beq.n	c0d0298e <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d0297e:	4282      	cmp	r2, r0
c0d02980:	d300      	bcc.n	c0d02984 <USBD_GetDescriptor+0xd0>
c0d02982:	4602      	mov	r2, r0
c0d02984:	a801      	add	r0, sp, #4
c0d02986:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02988:	4620      	mov	r0, r4
c0d0298a:	f000 faf9 	bl	c0d02f80 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d0298e:	b002      	add	sp, #8
c0d02990:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02992:	2011      	movs	r0, #17
c0d02994:	0100      	lsls	r0, r0, #4
c0d02996:	5820      	ldr	r0, [r4, r0]
c0d02998:	6880      	ldr	r0, [r0, #8]
c0d0299a:	e7bb      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d0299c:	2011      	movs	r0, #17
c0d0299e:	0100      	lsls	r0, r0, #4
c0d029a0:	5820      	ldr	r0, [r4, r0]
c0d029a2:	68c0      	ldr	r0, [r0, #12]
c0d029a4:	e7b6      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d029a6:	2011      	movs	r0, #17
c0d029a8:	0100      	lsls	r0, r0, #4
c0d029aa:	5820      	ldr	r0, [r4, r0]
c0d029ac:	6900      	ldr	r0, [r0, #16]
c0d029ae:	e7b1      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d029b0:	2011      	movs	r0, #17
c0d029b2:	0100      	lsls	r0, r0, #4
c0d029b4:	5820      	ldr	r0, [r4, r0]
c0d029b6:	6940      	ldr	r0, [r0, #20]
c0d029b8:	e7ac      	b.n	c0d02914 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d029ba:	2011      	movs	r0, #17
c0d029bc:	0100      	lsls	r0, r0, #4
c0d029be:	5820      	ldr	r0, [r4, r0]
c0d029c0:	6980      	ldr	r0, [r0, #24]
c0d029c2:	e7a7      	b.n	c0d02914 <USBD_GetDescriptor+0x60>

c0d029c4 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d029c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029c6:	af03      	add	r7, sp, #12
c0d029c8:	b081      	sub	sp, #4
c0d029ca:	460a      	mov	r2, r1
c0d029cc:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d029ce:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029d0:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d029d2:	2800      	cmp	r0, #0
c0d029d4:	d10b      	bne.n	c0d029ee <USBD_SetAddress+0x2a>
c0d029d6:	88d0      	ldrh	r0, [r2, #6]
c0d029d8:	2800      	cmp	r0, #0
c0d029da:	d108      	bne.n	c0d029ee <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d029dc:	8850      	ldrh	r0, [r2, #2]
c0d029de:	267f      	movs	r6, #127	; 0x7f
c0d029e0:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d029e2:	20fc      	movs	r0, #252	; 0xfc
c0d029e4:	5c20      	ldrb	r0, [r4, r0]
c0d029e6:	4625      	mov	r5, r4
c0d029e8:	35fc      	adds	r5, #252	; 0xfc
c0d029ea:	2803      	cmp	r0, #3
c0d029ec:	d108      	bne.n	c0d02a00 <USBD_SetAddress+0x3c>
c0d029ee:	4620      	mov	r0, r4
c0d029f0:	f7ff fd0a 	bl	c0d02408 <USBD_LL_StallEP>
c0d029f4:	2100      	movs	r1, #0
c0d029f6:	4620      	mov	r0, r4
c0d029f8:	f7ff fd06 	bl	c0d02408 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d029fc:	b001      	add	sp, #4
c0d029fe:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02a00:	20fe      	movs	r0, #254	; 0xfe
c0d02a02:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02a04:	b2f1      	uxtb	r1, r6
c0d02a06:	4620      	mov	r0, r4
c0d02a08:	f7ff fd5c 	bl	c0d024c4 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02a0c:	4620      	mov	r0, r4
c0d02a0e:	f000 fae5 	bl	c0d02fdc <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02a12:	2002      	movs	r0, #2
c0d02a14:	2101      	movs	r1, #1
c0d02a16:	2e00      	cmp	r6, #0
c0d02a18:	d100      	bne.n	c0d02a1c <USBD_SetAddress+0x58>
c0d02a1a:	4608      	mov	r0, r1
c0d02a1c:	7028      	strb	r0, [r5, #0]
c0d02a1e:	e7ed      	b.n	c0d029fc <USBD_SetAddress+0x38>

c0d02a20 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02a20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a22:	af03      	add	r7, sp, #12
c0d02a24:	b081      	sub	sp, #4
c0d02a26:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02a28:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a2a:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02a2c:	2e02      	cmp	r6, #2
c0d02a2e:	d21d      	bcs.n	c0d02a6c <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02a30:	20fc      	movs	r0, #252	; 0xfc
c0d02a32:	5c21      	ldrb	r1, [r4, r0]
c0d02a34:	4620      	mov	r0, r4
c0d02a36:	30fc      	adds	r0, #252	; 0xfc
c0d02a38:	2903      	cmp	r1, #3
c0d02a3a:	d007      	beq.n	c0d02a4c <USBD_SetConfig+0x2c>
c0d02a3c:	2902      	cmp	r1, #2
c0d02a3e:	d115      	bne.n	c0d02a6c <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02a40:	2e00      	cmp	r6, #0
c0d02a42:	d026      	beq.n	c0d02a92 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02a44:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02a46:	2103      	movs	r1, #3
c0d02a48:	7001      	strb	r1, [r0, #0]
c0d02a4a:	e009      	b.n	c0d02a60 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02a4c:	2e00      	cmp	r6, #0
c0d02a4e:	d016      	beq.n	c0d02a7e <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02a50:	6860      	ldr	r0, [r4, #4]
c0d02a52:	4286      	cmp	r6, r0
c0d02a54:	d01d      	beq.n	c0d02a92 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02a56:	b2c1      	uxtb	r1, r0
c0d02a58:	4620      	mov	r0, r4
c0d02a5a:	f7ff fdd3 	bl	c0d02604 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02a5e:	6066      	str	r6, [r4, #4]
c0d02a60:	4620      	mov	r0, r4
c0d02a62:	4631      	mov	r1, r6
c0d02a64:	f7ff fdb6 	bl	c0d025d4 <USBD_SetClassConfig>
c0d02a68:	2802      	cmp	r0, #2
c0d02a6a:	d112      	bne.n	c0d02a92 <USBD_SetConfig+0x72>
c0d02a6c:	4620      	mov	r0, r4
c0d02a6e:	4629      	mov	r1, r5
c0d02a70:	f7ff fcca 	bl	c0d02408 <USBD_LL_StallEP>
c0d02a74:	2100      	movs	r1, #0
c0d02a76:	4620      	mov	r0, r4
c0d02a78:	f7ff fcc6 	bl	c0d02408 <USBD_LL_StallEP>
c0d02a7c:	e00c      	b.n	c0d02a98 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02a7e:	2102      	movs	r1, #2
c0d02a80:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02a82:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02a84:	4620      	mov	r0, r4
c0d02a86:	4631      	mov	r1, r6
c0d02a88:	f7ff fdbc 	bl	c0d02604 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02a8c:	4620      	mov	r0, r4
c0d02a8e:	f000 faa5 	bl	c0d02fdc <USBD_CtlSendStatus>
c0d02a92:	4620      	mov	r0, r4
c0d02a94:	f000 faa2 	bl	c0d02fdc <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02a98:	b001      	add	sp, #4
c0d02a9a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a9c <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02a9c:	b5d0      	push	{r4, r6, r7, lr}
c0d02a9e:	af02      	add	r7, sp, #8
c0d02aa0:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02aa2:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02aa4:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02aa6:	2801      	cmp	r0, #1
c0d02aa8:	d10a      	bne.n	c0d02ac0 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02aaa:	20fc      	movs	r0, #252	; 0xfc
c0d02aac:	5c20      	ldrb	r0, [r4, r0]
c0d02aae:	2803      	cmp	r0, #3
c0d02ab0:	d00e      	beq.n	c0d02ad0 <USBD_GetConfig+0x34>
c0d02ab2:	2802      	cmp	r0, #2
c0d02ab4:	d104      	bne.n	c0d02ac0 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02ab6:	2000      	movs	r0, #0
c0d02ab8:	60a0      	str	r0, [r4, #8]
c0d02aba:	4621      	mov	r1, r4
c0d02abc:	3108      	adds	r1, #8
c0d02abe:	e008      	b.n	c0d02ad2 <USBD_GetConfig+0x36>
c0d02ac0:	4620      	mov	r0, r4
c0d02ac2:	f7ff fca1 	bl	c0d02408 <USBD_LL_StallEP>
c0d02ac6:	2100      	movs	r1, #0
c0d02ac8:	4620      	mov	r0, r4
c0d02aca:	f7ff fc9d 	bl	c0d02408 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02ace:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02ad0:	1d21      	adds	r1, r4, #4
c0d02ad2:	2201      	movs	r2, #1
c0d02ad4:	4620      	mov	r0, r4
c0d02ad6:	f000 fa53 	bl	c0d02f80 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02ada:	bdd0      	pop	{r4, r6, r7, pc}

c0d02adc <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02adc:	b5b0      	push	{r4, r5, r7, lr}
c0d02ade:	af02      	add	r7, sp, #8
c0d02ae0:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02ae2:	20fc      	movs	r0, #252	; 0xfc
c0d02ae4:	5c20      	ldrb	r0, [r4, r0]
c0d02ae6:	21fe      	movs	r1, #254	; 0xfe
c0d02ae8:	4001      	ands	r1, r0
c0d02aea:	2902      	cmp	r1, #2
c0d02aec:	d116      	bne.n	c0d02b1c <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02aee:	2001      	movs	r0, #1
c0d02af0:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02af2:	2041      	movs	r0, #65	; 0x41
c0d02af4:	0080      	lsls	r0, r0, #2
c0d02af6:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02af8:	4625      	mov	r5, r4
c0d02afa:	350c      	adds	r5, #12
c0d02afc:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02afe:	2900      	cmp	r1, #0
c0d02b00:	d005      	beq.n	c0d02b0e <USBD_GetStatus+0x32>
c0d02b02:	4620      	mov	r0, r4
c0d02b04:	f000 fa77 	bl	c0d02ff6 <USBD_CtlReceiveStatus>
c0d02b08:	68e1      	ldr	r1, [r4, #12]
c0d02b0a:	2002      	movs	r0, #2
c0d02b0c:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02b0e:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02b10:	2202      	movs	r2, #2
c0d02b12:	4620      	mov	r0, r4
c0d02b14:	4629      	mov	r1, r5
c0d02b16:	f000 fa33 	bl	c0d02f80 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02b1a:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b1c:	2180      	movs	r1, #128	; 0x80
c0d02b1e:	4620      	mov	r0, r4
c0d02b20:	f7ff fc72 	bl	c0d02408 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02b24:	2100      	movs	r1, #0
c0d02b26:	4620      	mov	r0, r4
c0d02b28:	f7ff fc6e 	bl	c0d02408 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02b2c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b2e <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02b2e:	b5b0      	push	{r4, r5, r7, lr}
c0d02b30:	af02      	add	r7, sp, #8
c0d02b32:	460d      	mov	r5, r1
c0d02b34:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02b36:	8868      	ldrh	r0, [r5, #2]
c0d02b38:	2801      	cmp	r0, #1
c0d02b3a:	d110      	bne.n	c0d02b5e <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02b3c:	2041      	movs	r0, #65	; 0x41
c0d02b3e:	0080      	lsls	r0, r0, #2
c0d02b40:	2101      	movs	r1, #1
c0d02b42:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02b44:	2045      	movs	r0, #69	; 0x45
c0d02b46:	0080      	lsls	r0, r0, #2
c0d02b48:	5820      	ldr	r0, [r4, r0]
c0d02b4a:	6880      	ldr	r0, [r0, #8]
c0d02b4c:	f7ff f846 	bl	c0d01bdc <pic>
c0d02b50:	4602      	mov	r2, r0
c0d02b52:	4620      	mov	r0, r4
c0d02b54:	4629      	mov	r1, r5
c0d02b56:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02b58:	4620      	mov	r0, r4
c0d02b5a:	f000 fa3f 	bl	c0d02fdc <USBD_CtlSendStatus>
  }

}
c0d02b5e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b60 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02b60:	b5b0      	push	{r4, r5, r7, lr}
c0d02b62:	af02      	add	r7, sp, #8
c0d02b64:	460d      	mov	r5, r1
c0d02b66:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02b68:	20fc      	movs	r0, #252	; 0xfc
c0d02b6a:	5c20      	ldrb	r0, [r4, r0]
c0d02b6c:	21fe      	movs	r1, #254	; 0xfe
c0d02b6e:	4001      	ands	r1, r0
c0d02b70:	2902      	cmp	r1, #2
c0d02b72:	d114      	bne.n	c0d02b9e <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02b74:	8868      	ldrh	r0, [r5, #2]
c0d02b76:	2801      	cmp	r0, #1
c0d02b78:	d119      	bne.n	c0d02bae <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02b7a:	2041      	movs	r0, #65	; 0x41
c0d02b7c:	0080      	lsls	r0, r0, #2
c0d02b7e:	2100      	movs	r1, #0
c0d02b80:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02b82:	2045      	movs	r0, #69	; 0x45
c0d02b84:	0080      	lsls	r0, r0, #2
c0d02b86:	5820      	ldr	r0, [r4, r0]
c0d02b88:	6880      	ldr	r0, [r0, #8]
c0d02b8a:	f7ff f827 	bl	c0d01bdc <pic>
c0d02b8e:	4602      	mov	r2, r0
c0d02b90:	4620      	mov	r0, r4
c0d02b92:	4629      	mov	r1, r5
c0d02b94:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02b96:	4620      	mov	r0, r4
c0d02b98:	f000 fa20 	bl	c0d02fdc <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02b9c:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b9e:	2180      	movs	r1, #128	; 0x80
c0d02ba0:	4620      	mov	r0, r4
c0d02ba2:	f7ff fc31 	bl	c0d02408 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02ba6:	2100      	movs	r1, #0
c0d02ba8:	4620      	mov	r0, r4
c0d02baa:	f7ff fc2d 	bl	c0d02408 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02bae:	bdb0      	pop	{r4, r5, r7, pc}

c0d02bb0 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02bb0:	b5d0      	push	{r4, r6, r7, lr}
c0d02bb2:	af02      	add	r7, sp, #8
c0d02bb4:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02bb6:	2180      	movs	r1, #128	; 0x80
c0d02bb8:	f7ff fc26 	bl	c0d02408 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02bbc:	2100      	movs	r1, #0
c0d02bbe:	4620      	mov	r0, r4
c0d02bc0:	f7ff fc22 	bl	c0d02408 <USBD_LL_StallEP>
}
c0d02bc4:	bdd0      	pop	{r4, r6, r7, pc}

c0d02bc6 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02bc6:	b5b0      	push	{r4, r5, r7, lr}
c0d02bc8:	af02      	add	r7, sp, #8
c0d02bca:	460d      	mov	r5, r1
c0d02bcc:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02bce:	20fc      	movs	r0, #252	; 0xfc
c0d02bd0:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02bd2:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02bd4:	2803      	cmp	r0, #3
c0d02bd6:	d115      	bne.n	c0d02c04 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02bd8:	88a8      	ldrh	r0, [r5, #4]
c0d02bda:	22fe      	movs	r2, #254	; 0xfe
c0d02bdc:	4002      	ands	r2, r0
c0d02bde:	2a01      	cmp	r2, #1
c0d02be0:	d810      	bhi.n	c0d02c04 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02be2:	2045      	movs	r0, #69	; 0x45
c0d02be4:	0080      	lsls	r0, r0, #2
c0d02be6:	5820      	ldr	r0, [r4, r0]
c0d02be8:	6880      	ldr	r0, [r0, #8]
c0d02bea:	f7fe fff7 	bl	c0d01bdc <pic>
c0d02bee:	4602      	mov	r2, r0
c0d02bf0:	4620      	mov	r0, r4
c0d02bf2:	4629      	mov	r1, r5
c0d02bf4:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02bf6:	88e8      	ldrh	r0, [r5, #6]
c0d02bf8:	2800      	cmp	r0, #0
c0d02bfa:	d10a      	bne.n	c0d02c12 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02bfc:	4620      	mov	r0, r4
c0d02bfe:	f000 f9ed 	bl	c0d02fdc <USBD_CtlSendStatus>
c0d02c02:	e006      	b.n	c0d02c12 <USBD_StdItfReq+0x4c>
c0d02c04:	4620      	mov	r0, r4
c0d02c06:	f7ff fbff 	bl	c0d02408 <USBD_LL_StallEP>
c0d02c0a:	2100      	movs	r1, #0
c0d02c0c:	4620      	mov	r0, r4
c0d02c0e:	f7ff fbfb 	bl	c0d02408 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02c12:	2000      	movs	r0, #0
c0d02c14:	bdb0      	pop	{r4, r5, r7, pc}

c0d02c16 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02c16:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c18:	af03      	add	r7, sp, #12
c0d02c1a:	b081      	sub	sp, #4
c0d02c1c:	460e      	mov	r6, r1
c0d02c1e:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02c20:	7830      	ldrb	r0, [r6, #0]
c0d02c22:	2160      	movs	r1, #96	; 0x60
c0d02c24:	4001      	ands	r1, r0
c0d02c26:	2920      	cmp	r1, #32
c0d02c28:	d10a      	bne.n	c0d02c40 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02c2a:	2045      	movs	r0, #69	; 0x45
c0d02c2c:	0080      	lsls	r0, r0, #2
c0d02c2e:	5820      	ldr	r0, [r4, r0]
c0d02c30:	6880      	ldr	r0, [r0, #8]
c0d02c32:	f7fe ffd3 	bl	c0d01bdc <pic>
c0d02c36:	4602      	mov	r2, r0
c0d02c38:	4620      	mov	r0, r4
c0d02c3a:	4631      	mov	r1, r6
c0d02c3c:	4790      	blx	r2
c0d02c3e:	e063      	b.n	c0d02d08 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02c40:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02c42:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02c44:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02c46:	2800      	cmp	r0, #0
c0d02c48:	d012      	beq.n	c0d02c70 <USBD_StdEPReq+0x5a>
c0d02c4a:	2801      	cmp	r0, #1
c0d02c4c:	d019      	beq.n	c0d02c82 <USBD_StdEPReq+0x6c>
c0d02c4e:	2803      	cmp	r0, #3
c0d02c50:	d15a      	bne.n	c0d02d08 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02c52:	20fc      	movs	r0, #252	; 0xfc
c0d02c54:	5c20      	ldrb	r0, [r4, r0]
c0d02c56:	2803      	cmp	r0, #3
c0d02c58:	d117      	bne.n	c0d02c8a <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02c5a:	8870      	ldrh	r0, [r6, #2]
c0d02c5c:	2800      	cmp	r0, #0
c0d02c5e:	d12d      	bne.n	c0d02cbc <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02c60:	4329      	orrs	r1, r5
c0d02c62:	2980      	cmp	r1, #128	; 0x80
c0d02c64:	d02a      	beq.n	c0d02cbc <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02c66:	4620      	mov	r0, r4
c0d02c68:	4629      	mov	r1, r5
c0d02c6a:	f7ff fbcd 	bl	c0d02408 <USBD_LL_StallEP>
c0d02c6e:	e025      	b.n	c0d02cbc <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02c70:	20fc      	movs	r0, #252	; 0xfc
c0d02c72:	5c20      	ldrb	r0, [r4, r0]
c0d02c74:	2803      	cmp	r0, #3
c0d02c76:	d02f      	beq.n	c0d02cd8 <USBD_StdEPReq+0xc2>
c0d02c78:	2802      	cmp	r0, #2
c0d02c7a:	d10e      	bne.n	c0d02c9a <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02c7c:	0668      	lsls	r0, r5, #25
c0d02c7e:	d109      	bne.n	c0d02c94 <USBD_StdEPReq+0x7e>
c0d02c80:	e042      	b.n	c0d02d08 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02c82:	20fc      	movs	r0, #252	; 0xfc
c0d02c84:	5c20      	ldrb	r0, [r4, r0]
c0d02c86:	2803      	cmp	r0, #3
c0d02c88:	d00f      	beq.n	c0d02caa <USBD_StdEPReq+0x94>
c0d02c8a:	2802      	cmp	r0, #2
c0d02c8c:	d105      	bne.n	c0d02c9a <USBD_StdEPReq+0x84>
c0d02c8e:	4329      	orrs	r1, r5
c0d02c90:	2980      	cmp	r1, #128	; 0x80
c0d02c92:	d039      	beq.n	c0d02d08 <USBD_StdEPReq+0xf2>
c0d02c94:	4620      	mov	r0, r4
c0d02c96:	4629      	mov	r1, r5
c0d02c98:	e004      	b.n	c0d02ca4 <USBD_StdEPReq+0x8e>
c0d02c9a:	4620      	mov	r0, r4
c0d02c9c:	f7ff fbb4 	bl	c0d02408 <USBD_LL_StallEP>
c0d02ca0:	2100      	movs	r1, #0
c0d02ca2:	4620      	mov	r0, r4
c0d02ca4:	f7ff fbb0 	bl	c0d02408 <USBD_LL_StallEP>
c0d02ca8:	e02e      	b.n	c0d02d08 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02caa:	8870      	ldrh	r0, [r6, #2]
c0d02cac:	2800      	cmp	r0, #0
c0d02cae:	d12b      	bne.n	c0d02d08 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02cb0:	0668      	lsls	r0, r5, #25
c0d02cb2:	d00d      	beq.n	c0d02cd0 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02cb4:	4620      	mov	r0, r4
c0d02cb6:	4629      	mov	r1, r5
c0d02cb8:	f7ff fbcc 	bl	c0d02454 <USBD_LL_ClearStallEP>
c0d02cbc:	2045      	movs	r0, #69	; 0x45
c0d02cbe:	0080      	lsls	r0, r0, #2
c0d02cc0:	5820      	ldr	r0, [r4, r0]
c0d02cc2:	6880      	ldr	r0, [r0, #8]
c0d02cc4:	f7fe ff8a 	bl	c0d01bdc <pic>
c0d02cc8:	4602      	mov	r2, r0
c0d02cca:	4620      	mov	r0, r4
c0d02ccc:	4631      	mov	r1, r6
c0d02cce:	4790      	blx	r2
c0d02cd0:	4620      	mov	r0, r4
c0d02cd2:	f000 f983 	bl	c0d02fdc <USBD_CtlSendStatus>
c0d02cd6:	e017      	b.n	c0d02d08 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02cd8:	4626      	mov	r6, r4
c0d02cda:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02cdc:	4620      	mov	r0, r4
c0d02cde:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02ce0:	420d      	tst	r5, r1
c0d02ce2:	d100      	bne.n	c0d02ce6 <USBD_StdEPReq+0xd0>
c0d02ce4:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02ce6:	4620      	mov	r0, r4
c0d02ce8:	4629      	mov	r1, r5
c0d02cea:	f7ff fbd9 	bl	c0d024a0 <USBD_LL_IsStallEP>
c0d02cee:	2101      	movs	r1, #1
c0d02cf0:	2800      	cmp	r0, #0
c0d02cf2:	d100      	bne.n	c0d02cf6 <USBD_StdEPReq+0xe0>
c0d02cf4:	4601      	mov	r1, r0
c0d02cf6:	207f      	movs	r0, #127	; 0x7f
c0d02cf8:	4005      	ands	r5, r0
c0d02cfa:	0128      	lsls	r0, r5, #4
c0d02cfc:	5031      	str	r1, [r6, r0]
c0d02cfe:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02d00:	2202      	movs	r2, #2
c0d02d02:	4620      	mov	r0, r4
c0d02d04:	f000 f93c 	bl	c0d02f80 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02d08:	2000      	movs	r0, #0
c0d02d0a:	b001      	add	sp, #4
c0d02d0c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02d0e <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02d0e:	780a      	ldrb	r2, [r1, #0]
c0d02d10:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02d12:	784a      	ldrb	r2, [r1, #1]
c0d02d14:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02d16:	788a      	ldrb	r2, [r1, #2]
c0d02d18:	78cb      	ldrb	r3, [r1, #3]
c0d02d1a:	021b      	lsls	r3, r3, #8
c0d02d1c:	4313      	orrs	r3, r2
c0d02d1e:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02d20:	790a      	ldrb	r2, [r1, #4]
c0d02d22:	794b      	ldrb	r3, [r1, #5]
c0d02d24:	021b      	lsls	r3, r3, #8
c0d02d26:	4313      	orrs	r3, r2
c0d02d28:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02d2a:	798a      	ldrb	r2, [r1, #6]
c0d02d2c:	79c9      	ldrb	r1, [r1, #7]
c0d02d2e:	0209      	lsls	r1, r1, #8
c0d02d30:	4311      	orrs	r1, r2
c0d02d32:	80c1      	strh	r1, [r0, #6]

}
c0d02d34:	4770      	bx	lr

c0d02d36 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02d36:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d38:	af03      	add	r7, sp, #12
c0d02d3a:	b083      	sub	sp, #12
c0d02d3c:	460d      	mov	r5, r1
c0d02d3e:	4604      	mov	r4, r0
c0d02d40:	a802      	add	r0, sp, #8
c0d02d42:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02d44:	8006      	strh	r6, [r0, #0]
c0d02d46:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02d48:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02d4a:	7829      	ldrb	r1, [r5, #0]
c0d02d4c:	2060      	movs	r0, #96	; 0x60
c0d02d4e:	4008      	ands	r0, r1
c0d02d50:	2800      	cmp	r0, #0
c0d02d52:	d010      	beq.n	c0d02d76 <USBD_HID_Setup+0x40>
c0d02d54:	2820      	cmp	r0, #32
c0d02d56:	d139      	bne.n	c0d02dcc <USBD_HID_Setup+0x96>
c0d02d58:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02d5a:	4601      	mov	r1, r0
c0d02d5c:	390a      	subs	r1, #10
c0d02d5e:	2902      	cmp	r1, #2
c0d02d60:	d334      	bcc.n	c0d02dcc <USBD_HID_Setup+0x96>
c0d02d62:	2802      	cmp	r0, #2
c0d02d64:	d01c      	beq.n	c0d02da0 <USBD_HID_Setup+0x6a>
c0d02d66:	2803      	cmp	r0, #3
c0d02d68:	d01a      	beq.n	c0d02da0 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02d6a:	4620      	mov	r0, r4
c0d02d6c:	4629      	mov	r1, r5
c0d02d6e:	f7ff ff1f 	bl	c0d02bb0 <USBD_CtlError>
c0d02d72:	2602      	movs	r6, #2
c0d02d74:	e02a      	b.n	c0d02dcc <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02d76:	7868      	ldrb	r0, [r5, #1]
c0d02d78:	280b      	cmp	r0, #11
c0d02d7a:	d014      	beq.n	c0d02da6 <USBD_HID_Setup+0x70>
c0d02d7c:	280a      	cmp	r0, #10
c0d02d7e:	d00f      	beq.n	c0d02da0 <USBD_HID_Setup+0x6a>
c0d02d80:	2806      	cmp	r0, #6
c0d02d82:	d123      	bne.n	c0d02dcc <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02d84:	8868      	ldrh	r0, [r5, #2]
c0d02d86:	0a00      	lsrs	r0, r0, #8
c0d02d88:	2600      	movs	r6, #0
c0d02d8a:	2821      	cmp	r0, #33	; 0x21
c0d02d8c:	d00f      	beq.n	c0d02dae <USBD_HID_Setup+0x78>
c0d02d8e:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02d90:	4632      	mov	r2, r6
c0d02d92:	4631      	mov	r1, r6
c0d02d94:	d117      	bne.n	c0d02dc6 <USBD_HID_Setup+0x90>
c0d02d96:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02d98:	9000      	str	r0, [sp, #0]
c0d02d9a:	f000 f847 	bl	c0d02e2c <USBD_HID_GetReportDescriptor_impl>
c0d02d9e:	e00a      	b.n	c0d02db6 <USBD_HID_Setup+0x80>
c0d02da0:	a901      	add	r1, sp, #4
c0d02da2:	2201      	movs	r2, #1
c0d02da4:	e00f      	b.n	c0d02dc6 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02da6:	4620      	mov	r0, r4
c0d02da8:	f000 f918 	bl	c0d02fdc <USBD_CtlSendStatus>
c0d02dac:	e00e      	b.n	c0d02dcc <USBD_HID_Setup+0x96>
c0d02dae:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02db0:	9000      	str	r0, [sp, #0]
c0d02db2:	f000 f833 	bl	c0d02e1c <USBD_HID_GetHidDescriptor_impl>
c0d02db6:	9b00      	ldr	r3, [sp, #0]
c0d02db8:	4601      	mov	r1, r0
c0d02dba:	881a      	ldrh	r2, [r3, #0]
c0d02dbc:	88e8      	ldrh	r0, [r5, #6]
c0d02dbe:	4282      	cmp	r2, r0
c0d02dc0:	d300      	bcc.n	c0d02dc4 <USBD_HID_Setup+0x8e>
c0d02dc2:	4602      	mov	r2, r0
c0d02dc4:	801a      	strh	r2, [r3, #0]
c0d02dc6:	4620      	mov	r0, r4
c0d02dc8:	f000 f8da 	bl	c0d02f80 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02dcc:	b2f0      	uxtb	r0, r6
c0d02dce:	b003      	add	sp, #12
c0d02dd0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02dd2 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02dd2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02dd4:	af03      	add	r7, sp, #12
c0d02dd6:	b081      	sub	sp, #4
c0d02dd8:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02dda:	2182      	movs	r1, #130	; 0x82
c0d02ddc:	2502      	movs	r5, #2
c0d02dde:	2640      	movs	r6, #64	; 0x40
c0d02de0:	462a      	mov	r2, r5
c0d02de2:	4633      	mov	r3, r6
c0d02de4:	f7ff fad0 	bl	c0d02388 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02de8:	4620      	mov	r0, r4
c0d02dea:	4629      	mov	r1, r5
c0d02dec:	462a      	mov	r2, r5
c0d02dee:	4633      	mov	r3, r6
c0d02df0:	f7ff faca 	bl	c0d02388 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02df4:	4620      	mov	r0, r4
c0d02df6:	4629      	mov	r1, r5
c0d02df8:	4632      	mov	r2, r6
c0d02dfa:	f7ff fb90 	bl	c0d0251e <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02dfe:	2000      	movs	r0, #0
c0d02e00:	b001      	add	sp, #4
c0d02e02:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02e04 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02e04:	b5d0      	push	{r4, r6, r7, lr}
c0d02e06:	af02      	add	r7, sp, #8
c0d02e08:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02e0a:	2182      	movs	r1, #130	; 0x82
c0d02e0c:	f7ff fae4 	bl	c0d023d8 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02e10:	2102      	movs	r1, #2
c0d02e12:	4620      	mov	r0, r4
c0d02e14:	f7ff fae0 	bl	c0d023d8 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02e18:	2000      	movs	r0, #0
c0d02e1a:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e1c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02e1c:	2109      	movs	r1, #9
c0d02e1e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02e20:	4801      	ldr	r0, [pc, #4]	; (c0d02e28 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02e22:	4478      	add	r0, pc
c0d02e24:	4770      	bx	lr
c0d02e26:	46c0      	nop			; (mov r8, r8)
c0d02e28:	00000ab2 	.word	0x00000ab2

c0d02e2c <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02e2c:	2122      	movs	r1, #34	; 0x22
c0d02e2e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02e30:	4801      	ldr	r0, [pc, #4]	; (c0d02e38 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02e32:	4478      	add	r0, pc
c0d02e34:	4770      	bx	lr
c0d02e36:	46c0      	nop			; (mov r8, r8)
c0d02e38:	00000a7d 	.word	0x00000a7d

c0d02e3c <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02e3c:	b5b0      	push	{r4, r5, r7, lr}
c0d02e3e:	af02      	add	r7, sp, #8
c0d02e40:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02e42:	2102      	movs	r1, #2
c0d02e44:	2240      	movs	r2, #64	; 0x40
c0d02e46:	f7ff fb6a 	bl	c0d0251e <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02e4a:	4d0d      	ldr	r5, [pc, #52]	; (c0d02e80 <USBD_HID_DataOut_impl+0x44>)
c0d02e4c:	7828      	ldrb	r0, [r5, #0]
c0d02e4e:	2800      	cmp	r0, #0
c0d02e50:	d113      	bne.n	c0d02e7a <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02e52:	2002      	movs	r0, #2
c0d02e54:	f7fe f928 	bl	c0d010a8 <io_seproxyhal_get_ep_rx_size>
c0d02e58:	4602      	mov	r2, r0
c0d02e5a:	480d      	ldr	r0, [pc, #52]	; (c0d02e90 <USBD_HID_DataOut_impl+0x54>)
c0d02e5c:	4478      	add	r0, pc
c0d02e5e:	4621      	mov	r1, r4
c0d02e60:	f7fd ff86 	bl	c0d00d70 <io_usb_hid_receive>
c0d02e64:	2802      	cmp	r0, #2
c0d02e66:	d108      	bne.n	c0d02e7a <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02e68:	2001      	movs	r0, #1
c0d02e6a:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02e6c:	4805      	ldr	r0, [pc, #20]	; (c0d02e84 <USBD_HID_DataOut_impl+0x48>)
c0d02e6e:	2107      	movs	r1, #7
c0d02e70:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02e72:	4805      	ldr	r0, [pc, #20]	; (c0d02e88 <USBD_HID_DataOut_impl+0x4c>)
c0d02e74:	6800      	ldr	r0, [r0, #0]
c0d02e76:	4905      	ldr	r1, [pc, #20]	; (c0d02e8c <USBD_HID_DataOut_impl+0x50>)
c0d02e78:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02e7a:	2000      	movs	r0, #0
c0d02e7c:	bdb0      	pop	{r4, r5, r7, pc}
c0d02e7e:	46c0      	nop			; (mov r8, r8)
c0d02e80:	20001d10 	.word	0x20001d10
c0d02e84:	20001d18 	.word	0x20001d18
c0d02e88:	20001c00 	.word	0x20001c00
c0d02e8c:	20001d1c 	.word	0x20001d1c
c0d02e90:	ffffe3a1 	.word	0xffffe3a1

c0d02e94 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02e94:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e96:	af03      	add	r7, sp, #12
c0d02e98:	b081      	sub	sp, #4
c0d02e9a:	4604      	mov	r4, r0
c0d02e9c:	2049      	movs	r0, #73	; 0x49
c0d02e9e:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02ea0:	4810      	ldr	r0, [pc, #64]	; (c0d02ee4 <USB_power+0x50>)
c0d02ea2:	2100      	movs	r1, #0
c0d02ea4:	462a      	mov	r2, r5
c0d02ea6:	f7fe f80f 	bl	c0d00ec8 <os_memset>

  if (enabled) {
c0d02eaa:	2c00      	cmp	r4, #0
c0d02eac:	d015      	beq.n	c0d02eda <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02eae:	4c0d      	ldr	r4, [pc, #52]	; (c0d02ee4 <USB_power+0x50>)
c0d02eb0:	2600      	movs	r6, #0
c0d02eb2:	4620      	mov	r0, r4
c0d02eb4:	4631      	mov	r1, r6
c0d02eb6:	462a      	mov	r2, r5
c0d02eb8:	f7fe f806 	bl	c0d00ec8 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02ebc:	490a      	ldr	r1, [pc, #40]	; (c0d02ee8 <USB_power+0x54>)
c0d02ebe:	4479      	add	r1, pc
c0d02ec0:	4620      	mov	r0, r4
c0d02ec2:	4632      	mov	r2, r6
c0d02ec4:	f7ff fb3f 	bl	c0d02546 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02ec8:	4908      	ldr	r1, [pc, #32]	; (c0d02eec <USB_power+0x58>)
c0d02eca:	4479      	add	r1, pc
c0d02ecc:	4620      	mov	r0, r4
c0d02ece:	f7ff fb72 	bl	c0d025b6 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02ed2:	4620      	mov	r0, r4
c0d02ed4:	f7ff fb78 	bl	c0d025c8 <USBD_Start>
c0d02ed8:	e002      	b.n	c0d02ee0 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02eda:	4802      	ldr	r0, [pc, #8]	; (c0d02ee4 <USB_power+0x50>)
c0d02edc:	f7ff fb51 	bl	c0d02582 <USBD_DeInit>
  }
}
c0d02ee0:	b001      	add	sp, #4
c0d02ee2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02ee4:	20001d34 	.word	0x20001d34
c0d02ee8:	00000a32 	.word	0x00000a32
c0d02eec:	00000a62 	.word	0x00000a62

c0d02ef0 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02ef0:	2012      	movs	r0, #18
c0d02ef2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02ef4:	4801      	ldr	r0, [pc, #4]	; (c0d02efc <USBD_DeviceDescriptor+0xc>)
c0d02ef6:	4478      	add	r0, pc
c0d02ef8:	4770      	bx	lr
c0d02efa:	46c0      	nop			; (mov r8, r8)
c0d02efc:	000009e7 	.word	0x000009e7

c0d02f00 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02f00:	2004      	movs	r0, #4
c0d02f02:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02f04:	4801      	ldr	r0, [pc, #4]	; (c0d02f0c <USBD_LangIDStrDescriptor+0xc>)
c0d02f06:	4478      	add	r0, pc
c0d02f08:	4770      	bx	lr
c0d02f0a:	46c0      	nop			; (mov r8, r8)
c0d02f0c:	00000a0a 	.word	0x00000a0a

c0d02f10 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02f10:	200e      	movs	r0, #14
c0d02f12:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02f14:	4801      	ldr	r0, [pc, #4]	; (c0d02f1c <USBD_ManufacturerStrDescriptor+0xc>)
c0d02f16:	4478      	add	r0, pc
c0d02f18:	4770      	bx	lr
c0d02f1a:	46c0      	nop			; (mov r8, r8)
c0d02f1c:	000009fe 	.word	0x000009fe

c0d02f20 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02f20:	200e      	movs	r0, #14
c0d02f22:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02f24:	4801      	ldr	r0, [pc, #4]	; (c0d02f2c <USBD_ProductStrDescriptor+0xc>)
c0d02f26:	4478      	add	r0, pc
c0d02f28:	4770      	bx	lr
c0d02f2a:	46c0      	nop			; (mov r8, r8)
c0d02f2c:	0000097b 	.word	0x0000097b

c0d02f30 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02f30:	200a      	movs	r0, #10
c0d02f32:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02f34:	4801      	ldr	r0, [pc, #4]	; (c0d02f3c <USBD_SerialStrDescriptor+0xc>)
c0d02f36:	4478      	add	r0, pc
c0d02f38:	4770      	bx	lr
c0d02f3a:	46c0      	nop			; (mov r8, r8)
c0d02f3c:	000009ec 	.word	0x000009ec

c0d02f40 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02f40:	200e      	movs	r0, #14
c0d02f42:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02f44:	4801      	ldr	r0, [pc, #4]	; (c0d02f4c <USBD_ConfigStrDescriptor+0xc>)
c0d02f46:	4478      	add	r0, pc
c0d02f48:	4770      	bx	lr
c0d02f4a:	46c0      	nop			; (mov r8, r8)
c0d02f4c:	0000095b 	.word	0x0000095b

c0d02f50 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02f50:	200e      	movs	r0, #14
c0d02f52:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02f54:	4801      	ldr	r0, [pc, #4]	; (c0d02f5c <USBD_InterfaceStrDescriptor+0xc>)
c0d02f56:	4478      	add	r0, pc
c0d02f58:	4770      	bx	lr
c0d02f5a:	46c0      	nop			; (mov r8, r8)
c0d02f5c:	0000094b 	.word	0x0000094b

c0d02f60 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02f60:	2129      	movs	r1, #41	; 0x29
c0d02f62:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02f64:	4801      	ldr	r0, [pc, #4]	; (c0d02f6c <USBD_GetCfgDesc_impl+0xc>)
c0d02f66:	4478      	add	r0, pc
c0d02f68:	4770      	bx	lr
c0d02f6a:	46c0      	nop			; (mov r8, r8)
c0d02f6c:	000009fe 	.word	0x000009fe

c0d02f70 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02f70:	210a      	movs	r1, #10
c0d02f72:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02f74:	4801      	ldr	r0, [pc, #4]	; (c0d02f7c <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02f76:	4478      	add	r0, pc
c0d02f78:	4770      	bx	lr
c0d02f7a:	46c0      	nop			; (mov r8, r8)
c0d02f7c:	00000a1a 	.word	0x00000a1a

c0d02f80 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02f80:	b5b0      	push	{r4, r5, r7, lr}
c0d02f82:	af02      	add	r7, sp, #8
c0d02f84:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02f86:	21f4      	movs	r1, #244	; 0xf4
c0d02f88:	2302      	movs	r3, #2
c0d02f8a:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02f8c:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02f8e:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02f90:	2109      	movs	r1, #9
c0d02f92:	0149      	lsls	r1, r1, #5
c0d02f94:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02f96:	6a01      	ldr	r1, [r0, #32]
c0d02f98:	428a      	cmp	r2, r1
c0d02f9a:	d300      	bcc.n	c0d02f9e <USBD_CtlSendData+0x1e>
c0d02f9c:	460a      	mov	r2, r1
c0d02f9e:	b293      	uxth	r3, r2
c0d02fa0:	2500      	movs	r5, #0
c0d02fa2:	4629      	mov	r1, r5
c0d02fa4:	4622      	mov	r2, r4
c0d02fa6:	f7ff faa0 	bl	c0d024ea <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02faa:	4628      	mov	r0, r5
c0d02fac:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fae <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02fae:	b5b0      	push	{r4, r5, r7, lr}
c0d02fb0:	af02      	add	r7, sp, #8
c0d02fb2:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02fb4:	6a01      	ldr	r1, [r0, #32]
c0d02fb6:	428a      	cmp	r2, r1
c0d02fb8:	d300      	bcc.n	c0d02fbc <USBD_CtlContinueSendData+0xe>
c0d02fba:	460a      	mov	r2, r1
c0d02fbc:	b293      	uxth	r3, r2
c0d02fbe:	2500      	movs	r5, #0
c0d02fc0:	4629      	mov	r1, r5
c0d02fc2:	4622      	mov	r2, r4
c0d02fc4:	f7ff fa91 	bl	c0d024ea <USBD_LL_Transmit>
  return USBD_OK;
c0d02fc8:	4628      	mov	r0, r5
c0d02fca:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fcc <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02fcc:	b5d0      	push	{r4, r6, r7, lr}
c0d02fce:	af02      	add	r7, sp, #8
c0d02fd0:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02fd2:	4621      	mov	r1, r4
c0d02fd4:	f7ff faa3 	bl	c0d0251e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02fd8:	4620      	mov	r0, r4
c0d02fda:	bdd0      	pop	{r4, r6, r7, pc}

c0d02fdc <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02fdc:	b5d0      	push	{r4, r6, r7, lr}
c0d02fde:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02fe0:	21f4      	movs	r1, #244	; 0xf4
c0d02fe2:	2204      	movs	r2, #4
c0d02fe4:	5042      	str	r2, [r0, r1]
c0d02fe6:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02fe8:	4621      	mov	r1, r4
c0d02fea:	4622      	mov	r2, r4
c0d02fec:	4623      	mov	r3, r4
c0d02fee:	f7ff fa7c 	bl	c0d024ea <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02ff2:	4620      	mov	r0, r4
c0d02ff4:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ff6 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02ff6:	b5d0      	push	{r4, r6, r7, lr}
c0d02ff8:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02ffa:	21f4      	movs	r1, #244	; 0xf4
c0d02ffc:	2205      	movs	r2, #5
c0d02ffe:	5042      	str	r2, [r0, r1]
c0d03000:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03002:	4621      	mov	r1, r4
c0d03004:	4622      	mov	r2, r4
c0d03006:	f7ff fa8a 	bl	c0d0251e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0300a:	4620      	mov	r0, r4
c0d0300c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03010 <__aeabi_uidiv>:
c0d03010:	2200      	movs	r2, #0
c0d03012:	0843      	lsrs	r3, r0, #1
c0d03014:	428b      	cmp	r3, r1
c0d03016:	d374      	bcc.n	c0d03102 <__aeabi_uidiv+0xf2>
c0d03018:	0903      	lsrs	r3, r0, #4
c0d0301a:	428b      	cmp	r3, r1
c0d0301c:	d35f      	bcc.n	c0d030de <__aeabi_uidiv+0xce>
c0d0301e:	0a03      	lsrs	r3, r0, #8
c0d03020:	428b      	cmp	r3, r1
c0d03022:	d344      	bcc.n	c0d030ae <__aeabi_uidiv+0x9e>
c0d03024:	0b03      	lsrs	r3, r0, #12
c0d03026:	428b      	cmp	r3, r1
c0d03028:	d328      	bcc.n	c0d0307c <__aeabi_uidiv+0x6c>
c0d0302a:	0c03      	lsrs	r3, r0, #16
c0d0302c:	428b      	cmp	r3, r1
c0d0302e:	d30d      	bcc.n	c0d0304c <__aeabi_uidiv+0x3c>
c0d03030:	22ff      	movs	r2, #255	; 0xff
c0d03032:	0209      	lsls	r1, r1, #8
c0d03034:	ba12      	rev	r2, r2
c0d03036:	0c03      	lsrs	r3, r0, #16
c0d03038:	428b      	cmp	r3, r1
c0d0303a:	d302      	bcc.n	c0d03042 <__aeabi_uidiv+0x32>
c0d0303c:	1212      	asrs	r2, r2, #8
c0d0303e:	0209      	lsls	r1, r1, #8
c0d03040:	d065      	beq.n	c0d0310e <__aeabi_uidiv+0xfe>
c0d03042:	0b03      	lsrs	r3, r0, #12
c0d03044:	428b      	cmp	r3, r1
c0d03046:	d319      	bcc.n	c0d0307c <__aeabi_uidiv+0x6c>
c0d03048:	e000      	b.n	c0d0304c <__aeabi_uidiv+0x3c>
c0d0304a:	0a09      	lsrs	r1, r1, #8
c0d0304c:	0bc3      	lsrs	r3, r0, #15
c0d0304e:	428b      	cmp	r3, r1
c0d03050:	d301      	bcc.n	c0d03056 <__aeabi_uidiv+0x46>
c0d03052:	03cb      	lsls	r3, r1, #15
c0d03054:	1ac0      	subs	r0, r0, r3
c0d03056:	4152      	adcs	r2, r2
c0d03058:	0b83      	lsrs	r3, r0, #14
c0d0305a:	428b      	cmp	r3, r1
c0d0305c:	d301      	bcc.n	c0d03062 <__aeabi_uidiv+0x52>
c0d0305e:	038b      	lsls	r3, r1, #14
c0d03060:	1ac0      	subs	r0, r0, r3
c0d03062:	4152      	adcs	r2, r2
c0d03064:	0b43      	lsrs	r3, r0, #13
c0d03066:	428b      	cmp	r3, r1
c0d03068:	d301      	bcc.n	c0d0306e <__aeabi_uidiv+0x5e>
c0d0306a:	034b      	lsls	r3, r1, #13
c0d0306c:	1ac0      	subs	r0, r0, r3
c0d0306e:	4152      	adcs	r2, r2
c0d03070:	0b03      	lsrs	r3, r0, #12
c0d03072:	428b      	cmp	r3, r1
c0d03074:	d301      	bcc.n	c0d0307a <__aeabi_uidiv+0x6a>
c0d03076:	030b      	lsls	r3, r1, #12
c0d03078:	1ac0      	subs	r0, r0, r3
c0d0307a:	4152      	adcs	r2, r2
c0d0307c:	0ac3      	lsrs	r3, r0, #11
c0d0307e:	428b      	cmp	r3, r1
c0d03080:	d301      	bcc.n	c0d03086 <__aeabi_uidiv+0x76>
c0d03082:	02cb      	lsls	r3, r1, #11
c0d03084:	1ac0      	subs	r0, r0, r3
c0d03086:	4152      	adcs	r2, r2
c0d03088:	0a83      	lsrs	r3, r0, #10
c0d0308a:	428b      	cmp	r3, r1
c0d0308c:	d301      	bcc.n	c0d03092 <__aeabi_uidiv+0x82>
c0d0308e:	028b      	lsls	r3, r1, #10
c0d03090:	1ac0      	subs	r0, r0, r3
c0d03092:	4152      	adcs	r2, r2
c0d03094:	0a43      	lsrs	r3, r0, #9
c0d03096:	428b      	cmp	r3, r1
c0d03098:	d301      	bcc.n	c0d0309e <__aeabi_uidiv+0x8e>
c0d0309a:	024b      	lsls	r3, r1, #9
c0d0309c:	1ac0      	subs	r0, r0, r3
c0d0309e:	4152      	adcs	r2, r2
c0d030a0:	0a03      	lsrs	r3, r0, #8
c0d030a2:	428b      	cmp	r3, r1
c0d030a4:	d301      	bcc.n	c0d030aa <__aeabi_uidiv+0x9a>
c0d030a6:	020b      	lsls	r3, r1, #8
c0d030a8:	1ac0      	subs	r0, r0, r3
c0d030aa:	4152      	adcs	r2, r2
c0d030ac:	d2cd      	bcs.n	c0d0304a <__aeabi_uidiv+0x3a>
c0d030ae:	09c3      	lsrs	r3, r0, #7
c0d030b0:	428b      	cmp	r3, r1
c0d030b2:	d301      	bcc.n	c0d030b8 <__aeabi_uidiv+0xa8>
c0d030b4:	01cb      	lsls	r3, r1, #7
c0d030b6:	1ac0      	subs	r0, r0, r3
c0d030b8:	4152      	adcs	r2, r2
c0d030ba:	0983      	lsrs	r3, r0, #6
c0d030bc:	428b      	cmp	r3, r1
c0d030be:	d301      	bcc.n	c0d030c4 <__aeabi_uidiv+0xb4>
c0d030c0:	018b      	lsls	r3, r1, #6
c0d030c2:	1ac0      	subs	r0, r0, r3
c0d030c4:	4152      	adcs	r2, r2
c0d030c6:	0943      	lsrs	r3, r0, #5
c0d030c8:	428b      	cmp	r3, r1
c0d030ca:	d301      	bcc.n	c0d030d0 <__aeabi_uidiv+0xc0>
c0d030cc:	014b      	lsls	r3, r1, #5
c0d030ce:	1ac0      	subs	r0, r0, r3
c0d030d0:	4152      	adcs	r2, r2
c0d030d2:	0903      	lsrs	r3, r0, #4
c0d030d4:	428b      	cmp	r3, r1
c0d030d6:	d301      	bcc.n	c0d030dc <__aeabi_uidiv+0xcc>
c0d030d8:	010b      	lsls	r3, r1, #4
c0d030da:	1ac0      	subs	r0, r0, r3
c0d030dc:	4152      	adcs	r2, r2
c0d030de:	08c3      	lsrs	r3, r0, #3
c0d030e0:	428b      	cmp	r3, r1
c0d030e2:	d301      	bcc.n	c0d030e8 <__aeabi_uidiv+0xd8>
c0d030e4:	00cb      	lsls	r3, r1, #3
c0d030e6:	1ac0      	subs	r0, r0, r3
c0d030e8:	4152      	adcs	r2, r2
c0d030ea:	0883      	lsrs	r3, r0, #2
c0d030ec:	428b      	cmp	r3, r1
c0d030ee:	d301      	bcc.n	c0d030f4 <__aeabi_uidiv+0xe4>
c0d030f0:	008b      	lsls	r3, r1, #2
c0d030f2:	1ac0      	subs	r0, r0, r3
c0d030f4:	4152      	adcs	r2, r2
c0d030f6:	0843      	lsrs	r3, r0, #1
c0d030f8:	428b      	cmp	r3, r1
c0d030fa:	d301      	bcc.n	c0d03100 <__aeabi_uidiv+0xf0>
c0d030fc:	004b      	lsls	r3, r1, #1
c0d030fe:	1ac0      	subs	r0, r0, r3
c0d03100:	4152      	adcs	r2, r2
c0d03102:	1a41      	subs	r1, r0, r1
c0d03104:	d200      	bcs.n	c0d03108 <__aeabi_uidiv+0xf8>
c0d03106:	4601      	mov	r1, r0
c0d03108:	4152      	adcs	r2, r2
c0d0310a:	4610      	mov	r0, r2
c0d0310c:	4770      	bx	lr
c0d0310e:	e7ff      	b.n	c0d03110 <__aeabi_uidiv+0x100>
c0d03110:	b501      	push	{r0, lr}
c0d03112:	2000      	movs	r0, #0
c0d03114:	f000 f8f0 	bl	c0d032f8 <__aeabi_idiv0>
c0d03118:	bd02      	pop	{r1, pc}
c0d0311a:	46c0      	nop			; (mov r8, r8)

c0d0311c <__aeabi_uidivmod>:
c0d0311c:	2900      	cmp	r1, #0
c0d0311e:	d0f7      	beq.n	c0d03110 <__aeabi_uidiv+0x100>
c0d03120:	e776      	b.n	c0d03010 <__aeabi_uidiv>
c0d03122:	4770      	bx	lr

c0d03124 <__aeabi_idiv>:
c0d03124:	4603      	mov	r3, r0
c0d03126:	430b      	orrs	r3, r1
c0d03128:	d47f      	bmi.n	c0d0322a <__aeabi_idiv+0x106>
c0d0312a:	2200      	movs	r2, #0
c0d0312c:	0843      	lsrs	r3, r0, #1
c0d0312e:	428b      	cmp	r3, r1
c0d03130:	d374      	bcc.n	c0d0321c <__aeabi_idiv+0xf8>
c0d03132:	0903      	lsrs	r3, r0, #4
c0d03134:	428b      	cmp	r3, r1
c0d03136:	d35f      	bcc.n	c0d031f8 <__aeabi_idiv+0xd4>
c0d03138:	0a03      	lsrs	r3, r0, #8
c0d0313a:	428b      	cmp	r3, r1
c0d0313c:	d344      	bcc.n	c0d031c8 <__aeabi_idiv+0xa4>
c0d0313e:	0b03      	lsrs	r3, r0, #12
c0d03140:	428b      	cmp	r3, r1
c0d03142:	d328      	bcc.n	c0d03196 <__aeabi_idiv+0x72>
c0d03144:	0c03      	lsrs	r3, r0, #16
c0d03146:	428b      	cmp	r3, r1
c0d03148:	d30d      	bcc.n	c0d03166 <__aeabi_idiv+0x42>
c0d0314a:	22ff      	movs	r2, #255	; 0xff
c0d0314c:	0209      	lsls	r1, r1, #8
c0d0314e:	ba12      	rev	r2, r2
c0d03150:	0c03      	lsrs	r3, r0, #16
c0d03152:	428b      	cmp	r3, r1
c0d03154:	d302      	bcc.n	c0d0315c <__aeabi_idiv+0x38>
c0d03156:	1212      	asrs	r2, r2, #8
c0d03158:	0209      	lsls	r1, r1, #8
c0d0315a:	d065      	beq.n	c0d03228 <__aeabi_idiv+0x104>
c0d0315c:	0b03      	lsrs	r3, r0, #12
c0d0315e:	428b      	cmp	r3, r1
c0d03160:	d319      	bcc.n	c0d03196 <__aeabi_idiv+0x72>
c0d03162:	e000      	b.n	c0d03166 <__aeabi_idiv+0x42>
c0d03164:	0a09      	lsrs	r1, r1, #8
c0d03166:	0bc3      	lsrs	r3, r0, #15
c0d03168:	428b      	cmp	r3, r1
c0d0316a:	d301      	bcc.n	c0d03170 <__aeabi_idiv+0x4c>
c0d0316c:	03cb      	lsls	r3, r1, #15
c0d0316e:	1ac0      	subs	r0, r0, r3
c0d03170:	4152      	adcs	r2, r2
c0d03172:	0b83      	lsrs	r3, r0, #14
c0d03174:	428b      	cmp	r3, r1
c0d03176:	d301      	bcc.n	c0d0317c <__aeabi_idiv+0x58>
c0d03178:	038b      	lsls	r3, r1, #14
c0d0317a:	1ac0      	subs	r0, r0, r3
c0d0317c:	4152      	adcs	r2, r2
c0d0317e:	0b43      	lsrs	r3, r0, #13
c0d03180:	428b      	cmp	r3, r1
c0d03182:	d301      	bcc.n	c0d03188 <__aeabi_idiv+0x64>
c0d03184:	034b      	lsls	r3, r1, #13
c0d03186:	1ac0      	subs	r0, r0, r3
c0d03188:	4152      	adcs	r2, r2
c0d0318a:	0b03      	lsrs	r3, r0, #12
c0d0318c:	428b      	cmp	r3, r1
c0d0318e:	d301      	bcc.n	c0d03194 <__aeabi_idiv+0x70>
c0d03190:	030b      	lsls	r3, r1, #12
c0d03192:	1ac0      	subs	r0, r0, r3
c0d03194:	4152      	adcs	r2, r2
c0d03196:	0ac3      	lsrs	r3, r0, #11
c0d03198:	428b      	cmp	r3, r1
c0d0319a:	d301      	bcc.n	c0d031a0 <__aeabi_idiv+0x7c>
c0d0319c:	02cb      	lsls	r3, r1, #11
c0d0319e:	1ac0      	subs	r0, r0, r3
c0d031a0:	4152      	adcs	r2, r2
c0d031a2:	0a83      	lsrs	r3, r0, #10
c0d031a4:	428b      	cmp	r3, r1
c0d031a6:	d301      	bcc.n	c0d031ac <__aeabi_idiv+0x88>
c0d031a8:	028b      	lsls	r3, r1, #10
c0d031aa:	1ac0      	subs	r0, r0, r3
c0d031ac:	4152      	adcs	r2, r2
c0d031ae:	0a43      	lsrs	r3, r0, #9
c0d031b0:	428b      	cmp	r3, r1
c0d031b2:	d301      	bcc.n	c0d031b8 <__aeabi_idiv+0x94>
c0d031b4:	024b      	lsls	r3, r1, #9
c0d031b6:	1ac0      	subs	r0, r0, r3
c0d031b8:	4152      	adcs	r2, r2
c0d031ba:	0a03      	lsrs	r3, r0, #8
c0d031bc:	428b      	cmp	r3, r1
c0d031be:	d301      	bcc.n	c0d031c4 <__aeabi_idiv+0xa0>
c0d031c0:	020b      	lsls	r3, r1, #8
c0d031c2:	1ac0      	subs	r0, r0, r3
c0d031c4:	4152      	adcs	r2, r2
c0d031c6:	d2cd      	bcs.n	c0d03164 <__aeabi_idiv+0x40>
c0d031c8:	09c3      	lsrs	r3, r0, #7
c0d031ca:	428b      	cmp	r3, r1
c0d031cc:	d301      	bcc.n	c0d031d2 <__aeabi_idiv+0xae>
c0d031ce:	01cb      	lsls	r3, r1, #7
c0d031d0:	1ac0      	subs	r0, r0, r3
c0d031d2:	4152      	adcs	r2, r2
c0d031d4:	0983      	lsrs	r3, r0, #6
c0d031d6:	428b      	cmp	r3, r1
c0d031d8:	d301      	bcc.n	c0d031de <__aeabi_idiv+0xba>
c0d031da:	018b      	lsls	r3, r1, #6
c0d031dc:	1ac0      	subs	r0, r0, r3
c0d031de:	4152      	adcs	r2, r2
c0d031e0:	0943      	lsrs	r3, r0, #5
c0d031e2:	428b      	cmp	r3, r1
c0d031e4:	d301      	bcc.n	c0d031ea <__aeabi_idiv+0xc6>
c0d031e6:	014b      	lsls	r3, r1, #5
c0d031e8:	1ac0      	subs	r0, r0, r3
c0d031ea:	4152      	adcs	r2, r2
c0d031ec:	0903      	lsrs	r3, r0, #4
c0d031ee:	428b      	cmp	r3, r1
c0d031f0:	d301      	bcc.n	c0d031f6 <__aeabi_idiv+0xd2>
c0d031f2:	010b      	lsls	r3, r1, #4
c0d031f4:	1ac0      	subs	r0, r0, r3
c0d031f6:	4152      	adcs	r2, r2
c0d031f8:	08c3      	lsrs	r3, r0, #3
c0d031fa:	428b      	cmp	r3, r1
c0d031fc:	d301      	bcc.n	c0d03202 <__aeabi_idiv+0xde>
c0d031fe:	00cb      	lsls	r3, r1, #3
c0d03200:	1ac0      	subs	r0, r0, r3
c0d03202:	4152      	adcs	r2, r2
c0d03204:	0883      	lsrs	r3, r0, #2
c0d03206:	428b      	cmp	r3, r1
c0d03208:	d301      	bcc.n	c0d0320e <__aeabi_idiv+0xea>
c0d0320a:	008b      	lsls	r3, r1, #2
c0d0320c:	1ac0      	subs	r0, r0, r3
c0d0320e:	4152      	adcs	r2, r2
c0d03210:	0843      	lsrs	r3, r0, #1
c0d03212:	428b      	cmp	r3, r1
c0d03214:	d301      	bcc.n	c0d0321a <__aeabi_idiv+0xf6>
c0d03216:	004b      	lsls	r3, r1, #1
c0d03218:	1ac0      	subs	r0, r0, r3
c0d0321a:	4152      	adcs	r2, r2
c0d0321c:	1a41      	subs	r1, r0, r1
c0d0321e:	d200      	bcs.n	c0d03222 <__aeabi_idiv+0xfe>
c0d03220:	4601      	mov	r1, r0
c0d03222:	4152      	adcs	r2, r2
c0d03224:	4610      	mov	r0, r2
c0d03226:	4770      	bx	lr
c0d03228:	e05d      	b.n	c0d032e6 <__aeabi_idiv+0x1c2>
c0d0322a:	0fca      	lsrs	r2, r1, #31
c0d0322c:	d000      	beq.n	c0d03230 <__aeabi_idiv+0x10c>
c0d0322e:	4249      	negs	r1, r1
c0d03230:	1003      	asrs	r3, r0, #32
c0d03232:	d300      	bcc.n	c0d03236 <__aeabi_idiv+0x112>
c0d03234:	4240      	negs	r0, r0
c0d03236:	4053      	eors	r3, r2
c0d03238:	2200      	movs	r2, #0
c0d0323a:	469c      	mov	ip, r3
c0d0323c:	0903      	lsrs	r3, r0, #4
c0d0323e:	428b      	cmp	r3, r1
c0d03240:	d32d      	bcc.n	c0d0329e <__aeabi_idiv+0x17a>
c0d03242:	0a03      	lsrs	r3, r0, #8
c0d03244:	428b      	cmp	r3, r1
c0d03246:	d312      	bcc.n	c0d0326e <__aeabi_idiv+0x14a>
c0d03248:	22fc      	movs	r2, #252	; 0xfc
c0d0324a:	0189      	lsls	r1, r1, #6
c0d0324c:	ba12      	rev	r2, r2
c0d0324e:	0a03      	lsrs	r3, r0, #8
c0d03250:	428b      	cmp	r3, r1
c0d03252:	d30c      	bcc.n	c0d0326e <__aeabi_idiv+0x14a>
c0d03254:	0189      	lsls	r1, r1, #6
c0d03256:	1192      	asrs	r2, r2, #6
c0d03258:	428b      	cmp	r3, r1
c0d0325a:	d308      	bcc.n	c0d0326e <__aeabi_idiv+0x14a>
c0d0325c:	0189      	lsls	r1, r1, #6
c0d0325e:	1192      	asrs	r2, r2, #6
c0d03260:	428b      	cmp	r3, r1
c0d03262:	d304      	bcc.n	c0d0326e <__aeabi_idiv+0x14a>
c0d03264:	0189      	lsls	r1, r1, #6
c0d03266:	d03a      	beq.n	c0d032de <__aeabi_idiv+0x1ba>
c0d03268:	1192      	asrs	r2, r2, #6
c0d0326a:	e000      	b.n	c0d0326e <__aeabi_idiv+0x14a>
c0d0326c:	0989      	lsrs	r1, r1, #6
c0d0326e:	09c3      	lsrs	r3, r0, #7
c0d03270:	428b      	cmp	r3, r1
c0d03272:	d301      	bcc.n	c0d03278 <__aeabi_idiv+0x154>
c0d03274:	01cb      	lsls	r3, r1, #7
c0d03276:	1ac0      	subs	r0, r0, r3
c0d03278:	4152      	adcs	r2, r2
c0d0327a:	0983      	lsrs	r3, r0, #6
c0d0327c:	428b      	cmp	r3, r1
c0d0327e:	d301      	bcc.n	c0d03284 <__aeabi_idiv+0x160>
c0d03280:	018b      	lsls	r3, r1, #6
c0d03282:	1ac0      	subs	r0, r0, r3
c0d03284:	4152      	adcs	r2, r2
c0d03286:	0943      	lsrs	r3, r0, #5
c0d03288:	428b      	cmp	r3, r1
c0d0328a:	d301      	bcc.n	c0d03290 <__aeabi_idiv+0x16c>
c0d0328c:	014b      	lsls	r3, r1, #5
c0d0328e:	1ac0      	subs	r0, r0, r3
c0d03290:	4152      	adcs	r2, r2
c0d03292:	0903      	lsrs	r3, r0, #4
c0d03294:	428b      	cmp	r3, r1
c0d03296:	d301      	bcc.n	c0d0329c <__aeabi_idiv+0x178>
c0d03298:	010b      	lsls	r3, r1, #4
c0d0329a:	1ac0      	subs	r0, r0, r3
c0d0329c:	4152      	adcs	r2, r2
c0d0329e:	08c3      	lsrs	r3, r0, #3
c0d032a0:	428b      	cmp	r3, r1
c0d032a2:	d301      	bcc.n	c0d032a8 <__aeabi_idiv+0x184>
c0d032a4:	00cb      	lsls	r3, r1, #3
c0d032a6:	1ac0      	subs	r0, r0, r3
c0d032a8:	4152      	adcs	r2, r2
c0d032aa:	0883      	lsrs	r3, r0, #2
c0d032ac:	428b      	cmp	r3, r1
c0d032ae:	d301      	bcc.n	c0d032b4 <__aeabi_idiv+0x190>
c0d032b0:	008b      	lsls	r3, r1, #2
c0d032b2:	1ac0      	subs	r0, r0, r3
c0d032b4:	4152      	adcs	r2, r2
c0d032b6:	d2d9      	bcs.n	c0d0326c <__aeabi_idiv+0x148>
c0d032b8:	0843      	lsrs	r3, r0, #1
c0d032ba:	428b      	cmp	r3, r1
c0d032bc:	d301      	bcc.n	c0d032c2 <__aeabi_idiv+0x19e>
c0d032be:	004b      	lsls	r3, r1, #1
c0d032c0:	1ac0      	subs	r0, r0, r3
c0d032c2:	4152      	adcs	r2, r2
c0d032c4:	1a41      	subs	r1, r0, r1
c0d032c6:	d200      	bcs.n	c0d032ca <__aeabi_idiv+0x1a6>
c0d032c8:	4601      	mov	r1, r0
c0d032ca:	4663      	mov	r3, ip
c0d032cc:	4152      	adcs	r2, r2
c0d032ce:	105b      	asrs	r3, r3, #1
c0d032d0:	4610      	mov	r0, r2
c0d032d2:	d301      	bcc.n	c0d032d8 <__aeabi_idiv+0x1b4>
c0d032d4:	4240      	negs	r0, r0
c0d032d6:	2b00      	cmp	r3, #0
c0d032d8:	d500      	bpl.n	c0d032dc <__aeabi_idiv+0x1b8>
c0d032da:	4249      	negs	r1, r1
c0d032dc:	4770      	bx	lr
c0d032de:	4663      	mov	r3, ip
c0d032e0:	105b      	asrs	r3, r3, #1
c0d032e2:	d300      	bcc.n	c0d032e6 <__aeabi_idiv+0x1c2>
c0d032e4:	4240      	negs	r0, r0
c0d032e6:	b501      	push	{r0, lr}
c0d032e8:	2000      	movs	r0, #0
c0d032ea:	f000 f805 	bl	c0d032f8 <__aeabi_idiv0>
c0d032ee:	bd02      	pop	{r1, pc}

c0d032f0 <__aeabi_idivmod>:
c0d032f0:	2900      	cmp	r1, #0
c0d032f2:	d0f8      	beq.n	c0d032e6 <__aeabi_idiv+0x1c2>
c0d032f4:	e716      	b.n	c0d03124 <__aeabi_idiv>
c0d032f6:	4770      	bx	lr

c0d032f8 <__aeabi_idiv0>:
c0d032f8:	4770      	bx	lr
c0d032fa:	46c0      	nop			; (mov r8, r8)

c0d032fc <__aeabi_lmul>:
c0d032fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d032fe:	464f      	mov	r7, r9
c0d03300:	4646      	mov	r6, r8
c0d03302:	b4c0      	push	{r6, r7}
c0d03304:	0416      	lsls	r6, r2, #16
c0d03306:	0c36      	lsrs	r6, r6, #16
c0d03308:	4699      	mov	r9, r3
c0d0330a:	0033      	movs	r3, r6
c0d0330c:	0405      	lsls	r5, r0, #16
c0d0330e:	0c2c      	lsrs	r4, r5, #16
c0d03310:	0c07      	lsrs	r7, r0, #16
c0d03312:	0c15      	lsrs	r5, r2, #16
c0d03314:	4363      	muls	r3, r4
c0d03316:	437e      	muls	r6, r7
c0d03318:	436f      	muls	r7, r5
c0d0331a:	4365      	muls	r5, r4
c0d0331c:	0c1c      	lsrs	r4, r3, #16
c0d0331e:	19ad      	adds	r5, r5, r6
c0d03320:	1964      	adds	r4, r4, r5
c0d03322:	469c      	mov	ip, r3
c0d03324:	42a6      	cmp	r6, r4
c0d03326:	d903      	bls.n	c0d03330 <__aeabi_lmul+0x34>
c0d03328:	2380      	movs	r3, #128	; 0x80
c0d0332a:	025b      	lsls	r3, r3, #9
c0d0332c:	4698      	mov	r8, r3
c0d0332e:	4447      	add	r7, r8
c0d03330:	4663      	mov	r3, ip
c0d03332:	0c25      	lsrs	r5, r4, #16
c0d03334:	19ef      	adds	r7, r5, r7
c0d03336:	041d      	lsls	r5, r3, #16
c0d03338:	464b      	mov	r3, r9
c0d0333a:	434a      	muls	r2, r1
c0d0333c:	4343      	muls	r3, r0
c0d0333e:	0c2d      	lsrs	r5, r5, #16
c0d03340:	0424      	lsls	r4, r4, #16
c0d03342:	1964      	adds	r4, r4, r5
c0d03344:	1899      	adds	r1, r3, r2
c0d03346:	19c9      	adds	r1, r1, r7
c0d03348:	0020      	movs	r0, r4
c0d0334a:	bc0c      	pop	{r2, r3}
c0d0334c:	4690      	mov	r8, r2
c0d0334e:	4699      	mov	r9, r3
c0d03350:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03352:	46c0      	nop			; (mov r8, r8)

c0d03354 <__aeabi_memclr>:
c0d03354:	b510      	push	{r4, lr}
c0d03356:	2200      	movs	r2, #0
c0d03358:	f000 f806 	bl	c0d03368 <__aeabi_memset>
c0d0335c:	bd10      	pop	{r4, pc}
c0d0335e:	46c0      	nop			; (mov r8, r8)

c0d03360 <__aeabi_memcpy>:
c0d03360:	b510      	push	{r4, lr}
c0d03362:	f000 f809 	bl	c0d03378 <memcpy>
c0d03366:	bd10      	pop	{r4, pc}

c0d03368 <__aeabi_memset>:
c0d03368:	0013      	movs	r3, r2
c0d0336a:	b510      	push	{r4, lr}
c0d0336c:	000a      	movs	r2, r1
c0d0336e:	0019      	movs	r1, r3
c0d03370:	f000 f840 	bl	c0d033f4 <memset>
c0d03374:	bd10      	pop	{r4, pc}
c0d03376:	46c0      	nop			; (mov r8, r8)

c0d03378 <memcpy>:
c0d03378:	b570      	push	{r4, r5, r6, lr}
c0d0337a:	2a0f      	cmp	r2, #15
c0d0337c:	d932      	bls.n	c0d033e4 <memcpy+0x6c>
c0d0337e:	000c      	movs	r4, r1
c0d03380:	4304      	orrs	r4, r0
c0d03382:	000b      	movs	r3, r1
c0d03384:	07a4      	lsls	r4, r4, #30
c0d03386:	d131      	bne.n	c0d033ec <memcpy+0x74>
c0d03388:	0015      	movs	r5, r2
c0d0338a:	0004      	movs	r4, r0
c0d0338c:	3d10      	subs	r5, #16
c0d0338e:	092d      	lsrs	r5, r5, #4
c0d03390:	3501      	adds	r5, #1
c0d03392:	012d      	lsls	r5, r5, #4
c0d03394:	1949      	adds	r1, r1, r5
c0d03396:	681e      	ldr	r6, [r3, #0]
c0d03398:	6026      	str	r6, [r4, #0]
c0d0339a:	685e      	ldr	r6, [r3, #4]
c0d0339c:	6066      	str	r6, [r4, #4]
c0d0339e:	689e      	ldr	r6, [r3, #8]
c0d033a0:	60a6      	str	r6, [r4, #8]
c0d033a2:	68de      	ldr	r6, [r3, #12]
c0d033a4:	3310      	adds	r3, #16
c0d033a6:	60e6      	str	r6, [r4, #12]
c0d033a8:	3410      	adds	r4, #16
c0d033aa:	4299      	cmp	r1, r3
c0d033ac:	d1f3      	bne.n	c0d03396 <memcpy+0x1e>
c0d033ae:	230f      	movs	r3, #15
c0d033b0:	1945      	adds	r5, r0, r5
c0d033b2:	4013      	ands	r3, r2
c0d033b4:	2b03      	cmp	r3, #3
c0d033b6:	d91b      	bls.n	c0d033f0 <memcpy+0x78>
c0d033b8:	1f1c      	subs	r4, r3, #4
c0d033ba:	2300      	movs	r3, #0
c0d033bc:	08a4      	lsrs	r4, r4, #2
c0d033be:	3401      	adds	r4, #1
c0d033c0:	00a4      	lsls	r4, r4, #2
c0d033c2:	58ce      	ldr	r6, [r1, r3]
c0d033c4:	50ee      	str	r6, [r5, r3]
c0d033c6:	3304      	adds	r3, #4
c0d033c8:	429c      	cmp	r4, r3
c0d033ca:	d1fa      	bne.n	c0d033c2 <memcpy+0x4a>
c0d033cc:	2303      	movs	r3, #3
c0d033ce:	192d      	adds	r5, r5, r4
c0d033d0:	1909      	adds	r1, r1, r4
c0d033d2:	401a      	ands	r2, r3
c0d033d4:	d005      	beq.n	c0d033e2 <memcpy+0x6a>
c0d033d6:	2300      	movs	r3, #0
c0d033d8:	5ccc      	ldrb	r4, [r1, r3]
c0d033da:	54ec      	strb	r4, [r5, r3]
c0d033dc:	3301      	adds	r3, #1
c0d033de:	429a      	cmp	r2, r3
c0d033e0:	d1fa      	bne.n	c0d033d8 <memcpy+0x60>
c0d033e2:	bd70      	pop	{r4, r5, r6, pc}
c0d033e4:	0005      	movs	r5, r0
c0d033e6:	2a00      	cmp	r2, #0
c0d033e8:	d1f5      	bne.n	c0d033d6 <memcpy+0x5e>
c0d033ea:	e7fa      	b.n	c0d033e2 <memcpy+0x6a>
c0d033ec:	0005      	movs	r5, r0
c0d033ee:	e7f2      	b.n	c0d033d6 <memcpy+0x5e>
c0d033f0:	001a      	movs	r2, r3
c0d033f2:	e7f8      	b.n	c0d033e6 <memcpy+0x6e>

c0d033f4 <memset>:
c0d033f4:	b570      	push	{r4, r5, r6, lr}
c0d033f6:	0783      	lsls	r3, r0, #30
c0d033f8:	d03f      	beq.n	c0d0347a <memset+0x86>
c0d033fa:	1e54      	subs	r4, r2, #1
c0d033fc:	2a00      	cmp	r2, #0
c0d033fe:	d03b      	beq.n	c0d03478 <memset+0x84>
c0d03400:	b2ce      	uxtb	r6, r1
c0d03402:	0003      	movs	r3, r0
c0d03404:	2503      	movs	r5, #3
c0d03406:	e003      	b.n	c0d03410 <memset+0x1c>
c0d03408:	1e62      	subs	r2, r4, #1
c0d0340a:	2c00      	cmp	r4, #0
c0d0340c:	d034      	beq.n	c0d03478 <memset+0x84>
c0d0340e:	0014      	movs	r4, r2
c0d03410:	3301      	adds	r3, #1
c0d03412:	1e5a      	subs	r2, r3, #1
c0d03414:	7016      	strb	r6, [r2, #0]
c0d03416:	422b      	tst	r3, r5
c0d03418:	d1f6      	bne.n	c0d03408 <memset+0x14>
c0d0341a:	2c03      	cmp	r4, #3
c0d0341c:	d924      	bls.n	c0d03468 <memset+0x74>
c0d0341e:	25ff      	movs	r5, #255	; 0xff
c0d03420:	400d      	ands	r5, r1
c0d03422:	022a      	lsls	r2, r5, #8
c0d03424:	4315      	orrs	r5, r2
c0d03426:	042a      	lsls	r2, r5, #16
c0d03428:	4315      	orrs	r5, r2
c0d0342a:	2c0f      	cmp	r4, #15
c0d0342c:	d911      	bls.n	c0d03452 <memset+0x5e>
c0d0342e:	0026      	movs	r6, r4
c0d03430:	3e10      	subs	r6, #16
c0d03432:	0936      	lsrs	r6, r6, #4
c0d03434:	3601      	adds	r6, #1
c0d03436:	0136      	lsls	r6, r6, #4
c0d03438:	001a      	movs	r2, r3
c0d0343a:	199b      	adds	r3, r3, r6
c0d0343c:	6015      	str	r5, [r2, #0]
c0d0343e:	6055      	str	r5, [r2, #4]
c0d03440:	6095      	str	r5, [r2, #8]
c0d03442:	60d5      	str	r5, [r2, #12]
c0d03444:	3210      	adds	r2, #16
c0d03446:	4293      	cmp	r3, r2
c0d03448:	d1f8      	bne.n	c0d0343c <memset+0x48>
c0d0344a:	220f      	movs	r2, #15
c0d0344c:	4014      	ands	r4, r2
c0d0344e:	2c03      	cmp	r4, #3
c0d03450:	d90a      	bls.n	c0d03468 <memset+0x74>
c0d03452:	1f26      	subs	r6, r4, #4
c0d03454:	08b6      	lsrs	r6, r6, #2
c0d03456:	3601      	adds	r6, #1
c0d03458:	00b6      	lsls	r6, r6, #2
c0d0345a:	001a      	movs	r2, r3
c0d0345c:	199b      	adds	r3, r3, r6
c0d0345e:	c220      	stmia	r2!, {r5}
c0d03460:	4293      	cmp	r3, r2
c0d03462:	d1fc      	bne.n	c0d0345e <memset+0x6a>
c0d03464:	2203      	movs	r2, #3
c0d03466:	4014      	ands	r4, r2
c0d03468:	2c00      	cmp	r4, #0
c0d0346a:	d005      	beq.n	c0d03478 <memset+0x84>
c0d0346c:	b2c9      	uxtb	r1, r1
c0d0346e:	191c      	adds	r4, r3, r4
c0d03470:	7019      	strb	r1, [r3, #0]
c0d03472:	3301      	adds	r3, #1
c0d03474:	429c      	cmp	r4, r3
c0d03476:	d1fb      	bne.n	c0d03470 <memset+0x7c>
c0d03478:	bd70      	pop	{r4, r5, r6, pc}
c0d0347a:	0014      	movs	r4, r2
c0d0347c:	0003      	movs	r3, r0
c0d0347e:	e7cc      	b.n	c0d0341a <memset+0x26>

c0d03480 <setjmp>:
c0d03480:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03482:	4641      	mov	r1, r8
c0d03484:	464a      	mov	r2, r9
c0d03486:	4653      	mov	r3, sl
c0d03488:	465c      	mov	r4, fp
c0d0348a:	466d      	mov	r5, sp
c0d0348c:	4676      	mov	r6, lr
c0d0348e:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03490:	3828      	subs	r0, #40	; 0x28
c0d03492:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03494:	2000      	movs	r0, #0
c0d03496:	4770      	bx	lr

c0d03498 <longjmp>:
c0d03498:	3010      	adds	r0, #16
c0d0349a:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d0349c:	4690      	mov	r8, r2
c0d0349e:	4699      	mov	r9, r3
c0d034a0:	46a2      	mov	sl, r4
c0d034a2:	46ab      	mov	fp, r5
c0d034a4:	46b5      	mov	sp, r6
c0d034a6:	c808      	ldmia	r0!, {r3}
c0d034a8:	3828      	subs	r0, #40	; 0x28
c0d034aa:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d034ac:	1c08      	adds	r0, r1, #0
c0d034ae:	d100      	bne.n	c0d034b2 <longjmp+0x1a>
c0d034b0:	2001      	movs	r0, #1
c0d034b2:	4718      	bx	r3

c0d034b4 <strlen>:
c0d034b4:	b510      	push	{r4, lr}
c0d034b6:	0783      	lsls	r3, r0, #30
c0d034b8:	d027      	beq.n	c0d0350a <strlen+0x56>
c0d034ba:	7803      	ldrb	r3, [r0, #0]
c0d034bc:	2b00      	cmp	r3, #0
c0d034be:	d026      	beq.n	c0d0350e <strlen+0x5a>
c0d034c0:	0003      	movs	r3, r0
c0d034c2:	2103      	movs	r1, #3
c0d034c4:	e002      	b.n	c0d034cc <strlen+0x18>
c0d034c6:	781a      	ldrb	r2, [r3, #0]
c0d034c8:	2a00      	cmp	r2, #0
c0d034ca:	d01c      	beq.n	c0d03506 <strlen+0x52>
c0d034cc:	3301      	adds	r3, #1
c0d034ce:	420b      	tst	r3, r1
c0d034d0:	d1f9      	bne.n	c0d034c6 <strlen+0x12>
c0d034d2:	6819      	ldr	r1, [r3, #0]
c0d034d4:	4a0f      	ldr	r2, [pc, #60]	; (c0d03514 <strlen+0x60>)
c0d034d6:	4c10      	ldr	r4, [pc, #64]	; (c0d03518 <strlen+0x64>)
c0d034d8:	188a      	adds	r2, r1, r2
c0d034da:	438a      	bics	r2, r1
c0d034dc:	4222      	tst	r2, r4
c0d034de:	d10f      	bne.n	c0d03500 <strlen+0x4c>
c0d034e0:	3304      	adds	r3, #4
c0d034e2:	6819      	ldr	r1, [r3, #0]
c0d034e4:	4a0b      	ldr	r2, [pc, #44]	; (c0d03514 <strlen+0x60>)
c0d034e6:	188a      	adds	r2, r1, r2
c0d034e8:	438a      	bics	r2, r1
c0d034ea:	4222      	tst	r2, r4
c0d034ec:	d108      	bne.n	c0d03500 <strlen+0x4c>
c0d034ee:	3304      	adds	r3, #4
c0d034f0:	6819      	ldr	r1, [r3, #0]
c0d034f2:	4a08      	ldr	r2, [pc, #32]	; (c0d03514 <strlen+0x60>)
c0d034f4:	188a      	adds	r2, r1, r2
c0d034f6:	438a      	bics	r2, r1
c0d034f8:	4222      	tst	r2, r4
c0d034fa:	d0f1      	beq.n	c0d034e0 <strlen+0x2c>
c0d034fc:	e000      	b.n	c0d03500 <strlen+0x4c>
c0d034fe:	3301      	adds	r3, #1
c0d03500:	781a      	ldrb	r2, [r3, #0]
c0d03502:	2a00      	cmp	r2, #0
c0d03504:	d1fb      	bne.n	c0d034fe <strlen+0x4a>
c0d03506:	1a18      	subs	r0, r3, r0
c0d03508:	bd10      	pop	{r4, pc}
c0d0350a:	0003      	movs	r3, r0
c0d0350c:	e7e1      	b.n	c0d034d2 <strlen+0x1e>
c0d0350e:	2000      	movs	r0, #0
c0d03510:	e7fa      	b.n	c0d03508 <strlen+0x54>
c0d03512:	46c0      	nop			; (mov r8, r8)
c0d03514:	fefefeff 	.word	0xfefefeff
c0d03518:	80808080 	.word	0x80808080
c0d0351c:	45544550 	.word	0x45544550
c0d03520:	54455052 	.word	0x54455052
c0d03524:	45505245 	.word	0x45505245
c0d03528:	50524554 	.word	0x50524554
c0d0352c:	52455445 	.word	0x52455445
c0d03530:	45544550 	.word	0x45544550
c0d03534:	54455052 	.word	0x54455052
c0d03538:	45505245 	.word	0x45505245
c0d0353c:	50524554 	.word	0x50524554
c0d03540:	52455445 	.word	0x52455445
c0d03544:	45544550 	.word	0x45544550
c0d03548:	54455052 	.word	0x54455052
c0d0354c:	45505245 	.word	0x45505245
c0d03550:	50524554 	.word	0x50524554
c0d03554:	52455445 	.word	0x52455445
c0d03558:	45544550 	.word	0x45544550
c0d0355c:	54455052 	.word	0x54455052
c0d03560:	45505245 	.word	0x45505245
c0d03564:	50524554 	.word	0x50524554
c0d03568:	52455445 	.word	0x52455445
c0d0356c:	00000052 	.word	0x00000052

c0d03570 <trits_mapping>:
c0d03570:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03580:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03590:	00ff0100 000000ff 00010000 0001ff00     ................
c0d035a0:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d035b0:	00000100 01000101 000101ff 01010101     ................
c0d035c0:	00000001                                ....

c0d035c4 <HALF_3_u>:
c0d035c4:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d035d4:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d035e4:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d035f4 <bagl_ui_nanos_screen1>:
c0d035f4:	00000003 00800000 00000020 00000001     ........ .......
c0d03604:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0362c:	00000107 0080000c 00000020 00000000     ........ .......
c0d0363c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03664:	00030005 0007000c 00000007 00000000     ................
	...
c0d0367c:	00070000 00000000 00000000 00000000     ................
	...
c0d0369c:	00750005 0008000d 00000006 00000000     ..u.............
c0d036ac:	00ffffff 00000000 00060000 00000000     ................
	...

c0d036d4 <bagl_ui_nanos_screen2>:
c0d036d4:	00000003 00800000 00000020 00000001     ........ .......
c0d036e4:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0370c:	00000107 00800012 00000020 00000000     ........ .......
c0d0371c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03744:	00030005 0007000c 00000007 00000000     ................
	...
c0d0375c:	00070000 00000000 00000000 00000000     ................
	...
c0d0377c:	00750005 0008000d 00000006 00000000     ..u.............
c0d0378c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d037b4 <bagl_ui_sample_blue>:
c0d037b4:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d037c4:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d037ec:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d037fc:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03824:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03834:	00ffffff 001d2028 00002004 c0d03894     ....( ... ...8..
	...
c0d0385c:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d0386c:	0041ccb4 00f9f9f9 0000a004 c0d038a0     ..A..........8..
c0d0387c:	00000000 0037ae99 00f9f9f9 c0d022e1     ......7......"..
	...
c0d03894:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d038a5 <USBD_PRODUCT_FS_STRING>:
c0d038a5:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d038b3 <HID_ReportDesc>:
c0d038b3:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d038c3:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d038d3:	0000c008 11210900                                .....

c0d038d8 <USBD_HID_Desc>:
c0d038d8:	01112109 22220100 00011200                       .!...."".

c0d038e1 <USBD_DeviceDesc>:
c0d038e1:	02000112 40000000 00012c97 02010200     .......@.,......
c0d038f1:	f1000103                                         ...

c0d038f4 <HID_Desc>:
c0d038f4:	c0d02ef1 c0d02f01 c0d02f11 c0d02f21     ...../.../..!/..
c0d03904:	c0d02f31 c0d02f41 c0d02f51 00000000     1/..A/..Q/......

c0d03914 <USBD_LangIDDesc>:
c0d03914:	04090304                                ....

c0d03918 <USBD_MANUFACTURER_STRING>:
c0d03918:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03926 <USB_SERIAL_STRING>:
c0d03926:	0030030a 00300030 2dd30031                       ..0.0.0.1.

c0d03930 <USBD_HID>:
c0d03930:	c0d02dd3 c0d02e05 c0d02d37 00000000     .-......7-......
	...
c0d03948:	c0d02e3d 00000000 00000000 00000000     =...............
c0d03958:	c0d02f61 c0d02f61 c0d02f61 c0d02f71     a/..a/..a/..q/..

c0d03968 <USBD_CfgDesc>:
c0d03968:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03978:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03988:	05070100 00400302 00000001              ......@.....

c0d03994 <USBD_DeviceQualifierDesc>:
c0d03994:	0200060a 40000000 00000001              .......@....

c0d039a0 <_etext>:
	...

c0d039c0 <N_storage_real>:
	...
