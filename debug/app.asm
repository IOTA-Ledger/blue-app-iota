
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
c0d00014:	f000 ff12 	bl	c0d00e3c <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fe5e 	bl	c0d00cd8 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f9e5 	bl	c0d033f4 <setjmp>
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
c0d00040:	f001 f8a2 	bl	c0d01188 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fd83 	bl	c0d01b50 <pic>
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
c0d0005a:	f001 fd79 	bl	c0d01b50 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fdc7 	bl	c0d01bf4 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fece 	bl	c0d02e08 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fecb 	bl	c0d02e08 <USB_power>

            ui_idle();
c0d00072:	f002 f85f 	bl	c0d02134 <ui_idle>

            IOTA_main();
c0d00076:	f000 fcc7 	bl	c0d00a08 <IOTA_main>
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
c0d0008c:	f003 f9be 	bl	c0d0340c <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03940 	.word	0xc0d03940

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
c0d000ca:	f001 faf1 	bl	c0d016b0 <snprintf>
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
c0d00192:	f002 ff81 	bl	c0d03098 <__aeabi_idiv>
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
c0d001c0:	f002 fee0 	bl	c0d02f84 <__aeabi_uidiv>
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
c0d001e0:	460d      	mov	r5, r1
c0d001e2:	4604      	mov	r4, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d001e4:	f000 fa5c 	bl	c0d006a0 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001e8:	f000 fa5a 	bl	c0d006a0 <kerl_initialize>
c0d001ec:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001ee:	4630      	mov	r0, r6
c0d001f0:	4621      	mov	r1, r4
c0d001f2:	462a      	mov	r2, r5
c0d001f4:	f003 f86e 	bl	c0d032d4 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001f8:	1970      	adds	r0, r6, r5
c0d001fa:	2130      	movs	r1, #48	; 0x30
c0d001fc:	1b4a      	subs	r2, r1, r5
c0d001fe:	460d      	mov	r5, r1
c0d00200:	9502      	str	r5, [sp, #8]
c0d00202:	4621      	mov	r1, r4
c0d00204:	f003 f866 	bl	c0d032d4 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00208:	4630      	mov	r0, r6
c0d0020a:	4629      	mov	r1, r5
c0d0020c:	f000 fa54 	bl	c0d006b8 <kerl_absorb_bytes>
c0d00210:	ac41      	add	r4, sp, #260	; 0x104
c0d00212:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00214:	4620      	mov	r0, r4
c0d00216:	4629      	mov	r1, r5
c0d00218:	f003 f856 	bl	c0d032c8 <__aeabi_memclr>
c0d0021c:	ae04      	add	r6, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021e:	491c      	ldr	r1, [pc, #112]	; (c0d00290 <get_seed+0xb8>)
c0d00220:	4479      	add	r1, pc
c0d00222:	2252      	movs	r2, #82	; 0x52
c0d00224:	4630      	mov	r0, r6
c0d00226:	f003 f855 	bl	c0d032d4 <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d0022a:	4630      	mov	r0, r6
c0d0022c:	4621      	mov	r1, r4
c0d0022e:	462a      	mov	r2, r5
c0d00230:	f000 f988 	bl	c0d00544 <chars_to_trytes>
c0d00234:	ae04      	add	r6, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00236:	21f3      	movs	r1, #243	; 0xf3
c0d00238:	4630      	mov	r0, r6
c0d0023a:	f003 f845 	bl	c0d032c8 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0023e:	4620      	mov	r0, r4
c0d00240:	4631      	mov	r1, r6
c0d00242:	462a      	mov	r2, r5
c0d00244:	f000 f960 	bl	c0d00508 <trytes_to_trits>
c0d00248:	ac56      	add	r4, sp, #344	; 0x158
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d0024a:	4630      	mov	r0, r6
c0d0024c:	4621      	mov	r1, r4
c0d0024e:	f7ff ff47 	bl	c0d000e0 <specific_243trits_to_49trints>
c0d00252:	ae04      	add	r6, sp, #16
      //   kerl_squeeze_trints(seed_trints, 49);
      // }
      {
        // Print result of trints_to_words
        uint32_t words[12];
        memset(words, 0, sizeof(words));
c0d00254:	4630      	mov	r0, r6
c0d00256:	9902      	ldr	r1, [sp, #8]
c0d00258:	f003 f836 	bl	c0d032c8 <__aeabi_memclr>
        trints_to_words_u_mem(seed_trints, words);
c0d0025c:	4620      	mov	r0, r4
c0d0025e:	4631      	mov	r1, r6
c0d00260:	f000 f986 	bl	c0d00570 <trints_to_words_u_mem>
        snprintf(msg, 81, "%u %u %u", words[0], words[1], words[2]);
c0d00264:	9b04      	ldr	r3, [sp, #16]
c0d00266:	9805      	ldr	r0, [sp, #20]
c0d00268:	9906      	ldr	r1, [sp, #24]
c0d0026a:	466a      	mov	r2, sp
c0d0026c:	c203      	stmia	r2!, {r0, r1}
c0d0026e:	a205      	add	r2, pc, #20	; (adr r2, c0d00284 <get_seed+0xac>)
c0d00270:	9c03      	ldr	r4, [sp, #12]
c0d00272:	4620      	mov	r0, r4
c0d00274:	4629      	mov	r1, r5
c0d00276:	f001 fa1b 	bl	c0d016b0 <snprintf>
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d0027a:	2000      	movs	r0, #0
      //   specific_49trints_to_243trits(seed_trints, seed_trits);
      //   trits_to_trytes(seed_trits, seed_trytes, 243);
      //   trytes_to_chars(seed_trytes, msg, 81);
      // }
      {
        msg[81] = '\0';
c0d0027c:	5560      	strb	r0, [r4, r5]
    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
}
c0d0027e:	b063      	add	sp, #396	; 0x18c
c0d00280:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00282:	46c0      	nop			; (mov r8, r8)
c0d00284:	25207525 	.word	0x25207525
c0d00288:	75252075 	.word	0x75252075
c0d0028c:	00000000 	.word	0x00000000
c0d00290:	0000326c 	.word	0x0000326c

c0d00294 <bigint_add_int_u_mem>:
    return len;
}

//memory optimized for add in place
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len)
{
c0d00294:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00296:	af03      	add	r7, sp, #12
c0d00298:	b083      	sub	sp, #12

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0029a:	6803      	ldr	r3, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0029c:	2600      	movs	r6, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0029e:	1859      	adds	r1, r3, r1
c0d002a0:	4633      	mov	r3, r6
c0d002a2:	415b      	adcs	r3, r3
c0d002a4:	9001      	str	r0, [sp, #4]
{
    struct int_bool_pair val;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;
c0d002a6:	6001      	str	r1, [r0, #0]
c0d002a8:	2101      	movs	r1, #1
c0d002aa:	2b00      	cmp	r3, #0
c0d002ac:	d100      	bne.n	c0d002b0 <bigint_add_int_u_mem+0x1c>
c0d002ae:	4619      	mov	r1, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002b0:	43f0      	mvns	r0, r6

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d002b2:	9002      	str	r0, [sp, #8]
c0d002b4:	2a02      	cmp	r2, #2
c0d002b6:	d31b      	bcc.n	c0d002f0 <bigint_add_int_u_mem+0x5c>
c0d002b8:	2301      	movs	r3, #1
c0d002ba:	9200      	str	r2, [sp, #0]
        // only continue adding, if there is a carry bit
        if (!val.hi) {
c0d002bc:	07c9      	lsls	r1, r1, #31
c0d002be:	d01d      	beq.n	c0d002fc <bigint_add_int_u_mem+0x68>
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d002c0:	0099      	lsls	r1, r3, #2
c0d002c2:	9801      	ldr	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d002c4:	5845      	ldr	r5, [r0, r1]
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d002c6:	1c6a      	adds	r2, r5, #1
c0d002c8:	4634      	mov	r4, r6
c0d002ca:	4176      	adcs	r6, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
c0d002cc:	5042      	str	r2, [r0, r1]
c0d002ce:	2501      	movs	r5, #1
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d002d0:	9802      	ldr	r0, [sp, #8]
c0d002d2:	4282      	cmp	r2, r0
c0d002d4:	4629      	mov	r1, r5
c0d002d6:	d800      	bhi.n	c0d002da <bigint_add_int_u_mem+0x46>
c0d002d8:	4621      	mov	r1, r4
c0d002da:	2e00      	cmp	r6, #0
c0d002dc:	d100      	bne.n	c0d002e0 <bigint_add_int_u_mem+0x4c>
c0d002de:	4635      	mov	r5, r6
c0d002e0:	2e00      	cmp	r6, #0
c0d002e2:	d000      	beq.n	c0d002e6 <bigint_add_int_u_mem+0x52>
c0d002e4:	4629      	mov	r1, r5

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d002e6:	1c5b      	adds	r3, r3, #1
c0d002e8:	9a00      	ldr	r2, [sp, #0]
c0d002ea:	4293      	cmp	r3, r2
c0d002ec:	4626      	mov	r6, r4
c0d002ee:	d3e5      	bcc.n	c0d002bc <bigint_add_int_u_mem+0x28>
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
    }

    // detect overflow
    if (val.hi) {
c0d002f0:	2900      	cmp	r1, #0
c0d002f2:	d100      	bne.n	c0d002f6 <bigint_add_int_u_mem+0x62>
c0d002f4:	9202      	str	r2, [sp, #8]
c0d002f6:	9802      	ldr	r0, [sp, #8]
c0d002f8:	b003      	add	sp, #12
c0d002fa:	bdf0      	pop	{r4, r5, r6, r7, pc}
        return -1;
    }
    return len;
}
c0d002fc:	4618      	mov	r0, r3
c0d002fe:	b003      	add	sp, #12
c0d00300:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00302 <bigint_add_int_u>:

int bigint_add_int_u(uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len)
{
c0d00302:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00304:	af03      	add	r7, sp, #12
c0d00306:	b085      	sub	sp, #20
c0d00308:	9303      	str	r3, [sp, #12]
c0d0030a:	9001      	str	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0030c:	6800      	ldr	r0, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0030e:	2400      	movs	r4, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00310:	1840      	adds	r0, r0, r1
c0d00312:	4623      	mov	r3, r4
c0d00314:	415b      	adcs	r3, r3
c0d00316:	9202      	str	r2, [sp, #8]
    struct int_bool_pair val;
    uint8_t i;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;
c0d00318:	6010      	str	r0, [r2, #0]

    i = 1;
    for (; i < len; i++) {
c0d0031a:	2601      	movs	r6, #1
c0d0031c:	2b00      	cmp	r3, #0
c0d0031e:	4631      	mov	r1, r6
c0d00320:	d000      	beq.n	c0d00324 <bigint_add_int_u+0x22>
c0d00322:	4621      	mov	r1, r4
c0d00324:	2b00      	cmp	r3, #0
c0d00326:	4635      	mov	r5, r6
c0d00328:	d100      	bne.n	c0d0032c <bigint_add_int_u+0x2a>
c0d0032a:	461d      	mov	r5, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0032c:	43e0      	mvns	r0, r4
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d0032e:	9000      	str	r0, [sp, #0]
c0d00330:	9803      	ldr	r0, [sp, #12]
c0d00332:	2802      	cmp	r0, #2
c0d00334:	d323      	bcc.n	c0d0037e <bigint_add_int_u+0x7c>
c0d00336:	2900      	cmp	r1, #0
c0d00338:	d121      	bne.n	c0d0037e <bigint_add_int_u+0x7c>
c0d0033a:	2101      	movs	r1, #1
c0d0033c:	9104      	str	r1, [sp, #16]
c0d0033e:	4634      	mov	r4, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d00340:	008d      	lsls	r5, r1, #2

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00342:	9801      	ldr	r0, [sp, #4]
c0d00344:	5943      	ldr	r3, [r0, r5]
c0d00346:	2200      	movs	r2, #0
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00348:	1c58      	adds	r0, r3, #1
c0d0034a:	4613      	mov	r3, r2
c0d0034c:	415b      	adcs	r3, r3
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
c0d0034e:	9e02      	ldr	r6, [sp, #8]
c0d00350:	5170      	str	r0, [r6, r5]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00352:	9d00      	ldr	r5, [sp, #0]
c0d00354:	42a8      	cmp	r0, r5
c0d00356:	9d04      	ldr	r5, [sp, #16]
c0d00358:	d800      	bhi.n	c0d0035c <bigint_add_int_u+0x5a>
c0d0035a:	4615      	mov	r5, r2
c0d0035c:	2b00      	cmp	r3, #0
c0d0035e:	9a04      	ldr	r2, [sp, #16]
c0d00360:	d100      	bne.n	c0d00364 <bigint_add_int_u+0x62>
c0d00362:	461a      	mov	r2, r3
c0d00364:	2b00      	cmp	r3, #0
c0d00366:	4626      	mov	r6, r4
c0d00368:	d000      	beq.n	c0d0036c <bigint_add_int_u+0x6a>
c0d0036a:	4615      	mov	r5, r2
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d0036c:	462a      	mov	r2, r5
c0d0036e:	4072      	eors	r2, r6
c0d00370:	1c49      	adds	r1, r1, #1
c0d00372:	9803      	ldr	r0, [sp, #12]
c0d00374:	4281      	cmp	r1, r0
c0d00376:	d203      	bcs.n	c0d00380 <bigint_add_int_u+0x7e>
c0d00378:	2a00      	cmp	r2, #0
c0d0037a:	d0e0      	beq.n	c0d0033e <bigint_add_int_u+0x3c>
c0d0037c:	e000      	b.n	c0d00380 <bigint_add_int_u+0x7e>
c0d0037e:	4631      	mov	r1, r6
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d00380:	b2cb      	uxtb	r3, r1
c0d00382:	9803      	ldr	r0, [sp, #12]
c0d00384:	4283      	cmp	r3, r0
c0d00386:	d20a      	bcs.n	c0d0039e <bigint_add_int_u+0x9c>
        bigint_out[j] = bigint_in[j];
c0d00388:	9803      	ldr	r0, [sp, #12]
c0d0038a:	1ac4      	subs	r4, r0, r3
c0d0038c:	009a      	lsls	r2, r3, #2
c0d0038e:	9801      	ldr	r0, [sp, #4]
c0d00390:	1880      	adds	r0, r0, r2
c0d00392:	9e02      	ldr	r6, [sp, #8]
c0d00394:	18b2      	adds	r2, r6, r2
c0d00396:	c840      	ldmia	r0!, {r6}
c0d00398:	c240      	stmia	r2!, {r6}
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d0039a:	1e64      	subs	r4, r4, #1
c0d0039c:	d1fb      	bne.n	c0d00396 <bigint_add_int_u+0x94>
        bigint_out[j] = bigint_in[j];
    }

    if (val.hi && i == len) {
c0d0039e:	2000      	movs	r0, #0
c0d003a0:	43c0      	mvns	r0, r0
c0d003a2:	9a03      	ldr	r2, [sp, #12]
c0d003a4:	4293      	cmp	r3, r2
c0d003a6:	d000      	beq.n	c0d003aa <bigint_add_int_u+0xa8>
c0d003a8:	4608      	mov	r0, r1
c0d003aa:	2d00      	cmp	r5, #0
c0d003ac:	d100      	bne.n	c0d003b0 <bigint_add_int_u+0xae>
c0d003ae:	4608      	mov	r0, r1
        return -1;
    }
    return i;
}
c0d003b0:	b005      	add	sp, #20
c0d003b2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d003b4 <bigint_sub_bigint_u_mem>:
    return len;
}

//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
c0d003b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003b6:	af03      	add	r7, sp, #12
c0d003b8:	b086      	sub	sp, #24
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d003ba:	2a00      	cmp	r2, #0
c0d003bc:	d037      	beq.n	c0d0042e <bigint_sub_bigint_u_mem+0x7a>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003be:	2300      	movs	r3, #0
c0d003c0:	9300      	str	r3, [sp, #0]
c0d003c2:	43de      	mvns	r6, r3
c0d003c4:	2501      	movs	r5, #1
c0d003c6:	9505      	str	r5, [sp, #20]
c0d003c8:	9203      	str	r2, [sp, #12]
c0d003ca:	9001      	str	r0, [sp, #4]
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003cc:	6804      	ldr	r4, [r0, #0]
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d003ce:	c908      	ldmia	r1!, {r3}
c0d003d0:	9104      	str	r1, [sp, #16]
c0d003d2:	43db      	mvns	r3, r3
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003d4:	1918      	adds	r0, r3, r4
c0d003d6:	4633      	mov	r3, r6
c0d003d8:	9e00      	ldr	r6, [sp, #0]
c0d003da:	4632      	mov	r2, r6
c0d003dc:	4152      	adcs	r2, r2
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d003de:	4601      	mov	r1, r0
c0d003e0:	4019      	ands	r1, r3
c0d003e2:	1c4c      	adds	r4, r1, #1
c0d003e4:	4631      	mov	r1, r6
c0d003e6:	4149      	adcs	r1, r1
c0d003e8:	9e05      	ldr	r6, [sp, #20]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d003ea:	4035      	ands	r5, r6
c0d003ec:	2d00      	cmp	r5, #0
c0d003ee:	d100      	bne.n	c0d003f2 <bigint_sub_bigint_u_mem+0x3e>
c0d003f0:	4604      	mov	r4, r0
c0d003f2:	9402      	str	r4, [sp, #8]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003f4:	429c      	cmp	r4, r3
c0d003f6:	4634      	mov	r4, r6
c0d003f8:	461e      	mov	r6, r3
c0d003fa:	d800      	bhi.n	c0d003fe <bigint_sub_bigint_u_mem+0x4a>
c0d003fc:	9c00      	ldr	r4, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d003fe:	2d00      	cmp	r5, #0
c0d00400:	d100      	bne.n	c0d00404 <bigint_sub_bigint_u_mem+0x50>
c0d00402:	4611      	mov	r1, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00404:	2900      	cmp	r1, #0
c0d00406:	9b05      	ldr	r3, [sp, #20]
c0d00408:	461d      	mov	r5, r3
c0d0040a:	d100      	bne.n	c0d0040e <bigint_sub_bigint_u_mem+0x5a>
c0d0040c:	460d      	mov	r5, r1
c0d0040e:	2900      	cmp	r1, #0
c0d00410:	d000      	beq.n	c0d00414 <bigint_sub_bigint_u_mem+0x60>
c0d00412:	462c      	mov	r4, r5
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00414:	4314      	orrs	r4, r2
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00416:	2c00      	cmp	r4, #0
c0d00418:	461d      	mov	r5, r3
c0d0041a:	9802      	ldr	r0, [sp, #8]
c0d0041c:	d100      	bne.n	c0d00420 <bigint_sub_bigint_u_mem+0x6c>
c0d0041e:	4625      	mov	r5, r4
c0d00420:	9901      	ldr	r1, [sp, #4]
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
c0d00422:	c101      	stmia	r1!, {r0}
c0d00424:	4608      	mov	r0, r1
c0d00426:	9a03      	ldr	r2, [sp, #12]
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00428:	1e52      	subs	r2, r2, #1
c0d0042a:	9904      	ldr	r1, [sp, #16]
c0d0042c:	d1cc      	bne.n	c0d003c8 <bigint_sub_bigint_u_mem+0x14>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
    }
    return 0;
c0d0042e:	2000      	movs	r0, #0
c0d00430:	b006      	add	sp, #24
c0d00432:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00434 <bigint_sub_bigint_u>:
}

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
c0d00434:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00436:	af03      	add	r7, sp, #12
c0d00438:	b087      	sub	sp, #28
c0d0043a:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0043c:	2d00      	cmp	r5, #0
c0d0043e:	d037      	beq.n	c0d004b0 <bigint_sub_bigint_u+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00440:	2400      	movs	r4, #0
c0d00442:	9402      	str	r4, [sp, #8]
c0d00444:	43e3      	mvns	r3, r4
c0d00446:	9301      	str	r3, [sp, #4]
c0d00448:	2601      	movs	r6, #1
c0d0044a:	9600      	str	r6, [sp, #0]
c0d0044c:	9203      	str	r2, [sp, #12]
c0d0044e:	9504      	str	r5, [sp, #16]
c0d00450:	4604      	mov	r4, r0
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00452:	cc01      	ldmia	r4!, {r0}
c0d00454:	9405      	str	r4, [sp, #20]
c0d00456:	460c      	mov	r4, r1
int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00458:	cc02      	ldmia	r4!, {r1}
c0d0045a:	9406      	str	r4, [sp, #24]
c0d0045c:	43c9      	mvns	r1, r1
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0045e:	180a      	adds	r2, r1, r0
c0d00460:	9902      	ldr	r1, [sp, #8]
c0d00462:	460c      	mov	r4, r1
c0d00464:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00466:	4610      	mov	r0, r2
c0d00468:	9d01      	ldr	r5, [sp, #4]
c0d0046a:	4028      	ands	r0, r5
c0d0046c:	1c43      	adds	r3, r0, #1
c0d0046e:	4608      	mov	r0, r1
c0d00470:	4140      	adcs	r0, r0
c0d00472:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00474:	400e      	ands	r6, r1
c0d00476:	2e00      	cmp	r6, #0
c0d00478:	d100      	bne.n	c0d0047c <bigint_sub_bigint_u+0x48>
c0d0047a:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0047c:	42ab      	cmp	r3, r5
c0d0047e:	460d      	mov	r5, r1
c0d00480:	d800      	bhi.n	c0d00484 <bigint_sub_bigint_u+0x50>
c0d00482:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00484:	2e00      	cmp	r6, #0
c0d00486:	9a03      	ldr	r2, [sp, #12]
c0d00488:	d100      	bne.n	c0d0048c <bigint_sub_bigint_u+0x58>
c0d0048a:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0048c:	2800      	cmp	r0, #0
c0d0048e:	460e      	mov	r6, r1
c0d00490:	d100      	bne.n	c0d00494 <bigint_sub_bigint_u+0x60>
c0d00492:	4606      	mov	r6, r0
c0d00494:	2800      	cmp	r0, #0
c0d00496:	d000      	beq.n	c0d0049a <bigint_sub_bigint_u+0x66>
c0d00498:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0049a:	4325      	orrs	r5, r4

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0049c:	2d00      	cmp	r5, #0
c0d0049e:	460e      	mov	r6, r1
c0d004a0:	9805      	ldr	r0, [sp, #20]
c0d004a2:	d100      	bne.n	c0d004a6 <bigint_sub_bigint_u+0x72>
c0d004a4:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d004a6:	c208      	stmia	r2!, {r3}
c0d004a8:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004aa:	1e6d      	subs	r5, r5, #1
c0d004ac:	9906      	ldr	r1, [sp, #24]
c0d004ae:	d1cd      	bne.n	c0d0044c <bigint_sub_bigint_u+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d004b0:	2000      	movs	r0, #0
c0d004b2:	b007      	add	sp, #28
c0d004b4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004b6 <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d004b6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004b8:	af03      	add	r7, sp, #12
c0d004ba:	b081      	sub	sp, #4
c0d004bc:	2400      	movs	r4, #0
c0d004be:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d004c0:	32ff      	adds	r2, #255	; 0xff
c0d004c2:	b253      	sxtb	r3, r2
c0d004c4:	2b00      	cmp	r3, #0
c0d004c6:	db0f      	blt.n	c0d004e8 <bigint_cmp_bigint_u+0x32>
c0d004c8:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d004ca:	009b      	lsls	r3, r3, #2
c0d004cc:	58ce      	ldr	r6, [r1, r3]
c0d004ce:	58c4      	ldr	r4, [r0, r3]
c0d004d0:	2301      	movs	r3, #1
c0d004d2:	42b4      	cmp	r4, r6
c0d004d4:	d80b      	bhi.n	c0d004ee <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d004d6:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d004d8:	42b4      	cmp	r4, r6
c0d004da:	d307      	bcc.n	c0d004ec <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d004dc:	b253      	sxtb	r3, r2
c0d004de:	42ab      	cmp	r3, r5
c0d004e0:	461a      	mov	r2, r3
c0d004e2:	dcf2      	bgt.n	c0d004ca <bigint_cmp_bigint_u+0x14>
c0d004e4:	9b00      	ldr	r3, [sp, #0]
c0d004e6:	e002      	b.n	c0d004ee <bigint_cmp_bigint_u+0x38>
c0d004e8:	4623      	mov	r3, r4
c0d004ea:	e000      	b.n	c0d004ee <bigint_cmp_bigint_u+0x38>
c0d004ec:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d004ee:	4618      	mov	r0, r3
c0d004f0:	b001      	add	sp, #4
c0d004f2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004f4 <bigint_not_u>:
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d004f4:	2900      	cmp	r1, #0
c0d004f6:	d004      	beq.n	c0d00502 <bigint_not_u+0xe>
        bigint[i] = ~bigint[i];
c0d004f8:	6802      	ldr	r2, [r0, #0]
c0d004fa:	43d2      	mvns	r2, r2
c0d004fc:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d004fe:	1e49      	subs	r1, r1, #1
c0d00500:	d1fa      	bne.n	c0d004f8 <bigint_not_u+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d00502:	2000      	movs	r0, #0
c0d00504:	4770      	bx	lr
	...

c0d00508 <trytes_to_trits>:
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00508:	b5b0      	push	{r4, r5, r7, lr}
c0d0050a:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0050c:	2a00      	cmp	r2, #0
c0d0050e:	d015      	beq.n	c0d0053c <trytes_to_trits+0x34>
c0d00510:	4b0b      	ldr	r3, [pc, #44]	; (c0d00540 <trytes_to_trits+0x38>)
c0d00512:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00514:	240d      	movs	r4, #13
c0d00516:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00518:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0051a:	062d      	lsls	r5, r5, #24
c0d0051c:	192c      	adds	r4, r5, r4
c0d0051e:	1624      	asrs	r4, r4, #24
c0d00520:	2503      	movs	r5, #3
c0d00522:	4365      	muls	r5, r4
c0d00524:	5d5c      	ldrb	r4, [r3, r5]
c0d00526:	700c      	strb	r4, [r1, #0]
c0d00528:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d0052a:	7865      	ldrb	r5, [r4, #1]
c0d0052c:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0052e:	78a4      	ldrb	r4, [r4, #2]
c0d00530:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00532:	1e52      	subs	r2, r2, #1
c0d00534:	1cc9      	adds	r1, r1, #3
c0d00536:	1c40      	adds	r0, r0, #1
c0d00538:	2a00      	cmp	r2, #0
c0d0053a:	d1eb      	bne.n	c0d00514 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d0053c:	2000      	movs	r0, #0
c0d0053e:	bdb0      	pop	{r4, r5, r7, pc}
c0d00540:	00002fce 	.word	0x00002fce

c0d00544 <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00544:	b5d0      	push	{r4, r6, r7, lr}
c0d00546:	af02      	add	r7, sp, #8
c0d00548:	e00e      	b.n	c0d00568 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d0054a:	7803      	ldrb	r3, [r0, #0]
c0d0054c:	b25b      	sxtb	r3, r3
c0d0054e:	2400      	movs	r4, #0
c0d00550:	2b39      	cmp	r3, #57	; 0x39
c0d00552:	d005      	beq.n	c0d00560 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00554:	2b4e      	cmp	r3, #78	; 0x4e
c0d00556:	db01      	blt.n	c0d0055c <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00558:	33a5      	adds	r3, #165	; 0xa5
c0d0055a:	e000      	b.n	c0d0055e <chars_to_trytes+0x1a>
c0d0055c:	33c0      	adds	r3, #192	; 0xc0
c0d0055e:	461c      	mov	r4, r3
c0d00560:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00562:	1e52      	subs	r2, r2, #1
c0d00564:	1c40      	adds	r0, r0, #1
c0d00566:	1c49      	adds	r1, r1, #1
c0d00568:	2a00      	cmp	r2, #0
c0d0056a:	d1ee      	bne.n	c0d0054a <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d0056c:	2000      	movs	r0, #0
c0d0056e:	bdd0      	pop	{r4, r6, r7, pc}

c0d00570 <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d00570:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00572:	af03      	add	r7, sp, #12
c0d00574:	b095      	sub	sp, #84	; 0x54
c0d00576:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d00578:	2130      	movs	r1, #48	; 0x30
c0d0057a:	9000      	str	r0, [sp, #0]
c0d0057c:	5640      	ldrsb	r0, [r0, r1]
c0d0057e:	a913      	add	r1, sp, #76	; 0x4c
c0d00580:	2203      	movs	r2, #3
c0d00582:	f7ff fdf1 	bl	c0d00168 <trint_to_trits>
c0d00586:	2001      	movs	r0, #1
c0d00588:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d0058a:	9606      	str	r6, [sp, #24]
c0d0058c:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d0058e:	2105      	movs	r1, #5
c0d00590:	4620      	mov	r0, r4
c0d00592:	f002 fe67 	bl	c0d03264 <__aeabi_idivmod>
c0d00596:	460e      	mov	r6, r1
c0d00598:	2e04      	cmp	r6, #4
c0d0059a:	d10b      	bne.n	c0d005b4 <trints_to_words_u_mem+0x44>
c0d0059c:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d0059e:	4620      	mov	r0, r4
c0d005a0:	4629      	mov	r1, r5
c0d005a2:	f002 fd79 	bl	c0d03098 <__aeabi_idiv>
c0d005a6:	b2c0      	uxtb	r0, r0
c0d005a8:	9900      	ldr	r1, [sp, #0]
c0d005aa:	5608      	ldrsb	r0, [r1, r0]
c0d005ac:	a913      	add	r1, sp, #76	; 0x4c
c0d005ae:	462a      	mov	r2, r5
c0d005b0:	f7ff fdda 	bl	c0d00168 <trint_to_trits>
c0d005b4:	a813      	add	r0, sp, #76	; 0x4c

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d005b6:	5d80      	ldrb	r0, [r0, r6]
c0d005b8:	1c41      	adds	r1, r0, #1
c0d005ba:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d005bc:	9804      	ldr	r0, [sp, #16]
c0d005be:	2800      	cmp	r0, #0
c0d005c0:	d022      	beq.n	c0d00608 <trints_to_words_u_mem+0x98>
c0d005c2:	9101      	str	r1, [sp, #4]
c0d005c4:	9402      	str	r4, [sp, #8]
c0d005c6:	2500      	movs	r5, #0
c0d005c8:	462e      	mov	r6, r5
c0d005ca:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d005cc:	00b1      	lsls	r1, r6, #2
c0d005ce:	9105      	str	r1, [sp, #20]
c0d005d0:	9806      	ldr	r0, [sp, #24]
c0d005d2:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d005d4:	2203      	movs	r2, #3
c0d005d6:	9c03      	ldr	r4, [sp, #12]
c0d005d8:	4621      	mov	r1, r4
c0d005da:	4623      	mov	r3, r4
c0d005dc:	f002 fe48 	bl	c0d03270 <__aeabi_lmul>
c0d005e0:	9b04      	ldr	r3, [sp, #16]
c0d005e2:	1940      	adds	r0, r0, r5
c0d005e4:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d005e6:	9a06      	ldr	r2, [sp, #24]
c0d005e8:	9c05      	ldr	r4, [sp, #20]
c0d005ea:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d005ec:	1c76      	adds	r6, r6, #1
c0d005ee:	42b3      	cmp	r3, r6
c0d005f0:	460d      	mov	r5, r1
c0d005f2:	d1eb      	bne.n	c0d005cc <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d005f4:	2900      	cmp	r1, #0
c0d005f6:	d004      	beq.n	c0d00602 <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d005f8:	0098      	lsls	r0, r3, #2
c0d005fa:	9a06      	ldr	r2, [sp, #24]
c0d005fc:	5011      	str	r1, [r2, r0]
                size++;
c0d005fe:	1c5d      	adds	r5, r3, #1
c0d00600:	e000      	b.n	c0d00604 <trints_to_words_u_mem+0x94>
c0d00602:	461d      	mov	r5, r3
c0d00604:	9c02      	ldr	r4, [sp, #8]
c0d00606:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00608:	b2c9      	uxtb	r1, r1
c0d0060a:	220c      	movs	r2, #12
c0d0060c:	9e06      	ldr	r6, [sp, #24]
c0d0060e:	4630      	mov	r0, r6
c0d00610:	f7ff fe40 	bl	c0d00294 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d00614:	42a8      	cmp	r0, r5
c0d00616:	d800      	bhi.n	c0d0061a <trints_to_words_u_mem+0xaa>
c0d00618:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d0061a:	1e61      	subs	r1, r4, #1
c0d0061c:	2c00      	cmp	r4, #0
c0d0061e:	460c      	mov	r4, r1
c0d00620:	dcb4      	bgt.n	c0d0058c <trints_to_words_u_mem+0x1c>
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d00622:	481c      	ldr	r0, [pc, #112]	; (c0d00694 <trints_to_words_u_mem+0x124>)
c0d00624:	4478      	add	r0, pc
c0d00626:	220c      	movs	r2, #12
c0d00628:	4631      	mov	r1, r6
c0d0062a:	f7ff ff44 	bl	c0d004b6 <bigint_cmp_bigint_u>
c0d0062e:	2801      	cmp	r0, #1
c0d00630:	db14      	blt.n	c0d0065c <trints_to_words_u_mem+0xec>
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00632:	481a      	ldr	r0, [pc, #104]	; (c0d0069c <trints_to_words_u_mem+0x12c>)
c0d00634:	4478      	add	r0, pc
c0d00636:	ae07      	add	r6, sp, #28
c0d00638:	250c      	movs	r5, #12
c0d0063a:	9906      	ldr	r1, [sp, #24]
c0d0063c:	4632      	mov	r2, r6
c0d0063e:	462b      	mov	r3, r5
c0d00640:	f7ff fef8 	bl	c0d00434 <bigint_sub_bigint_u>
        bigint_not_u(tmp, 12);
c0d00644:	4630      	mov	r0, r6
c0d00646:	4629      	mov	r1, r5
c0d00648:	f7ff ff54 	bl	c0d004f4 <bigint_not_u>
        bigint_add_int_u(tmp, 1, base, 12);
c0d0064c:	2101      	movs	r1, #1
c0d0064e:	4630      	mov	r0, r6
c0d00650:	9e06      	ldr	r6, [sp, #24]
c0d00652:	4632      	mov	r2, r6
c0d00654:	462b      	mov	r3, r5
c0d00656:	f7ff fe54 	bl	c0d00302 <bigint_add_int_u>
c0d0065a:	e005      	b.n	c0d00668 <trints_to_words_u_mem+0xf8>
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d0065c:	490e      	ldr	r1, [pc, #56]	; (c0d00698 <trints_to_words_u_mem+0x128>)
c0d0065e:	4479      	add	r1, pc
c0d00660:	220c      	movs	r2, #12
c0d00662:	4630      	mov	r0, r6
c0d00664:	f7ff fea6 	bl	c0d003b4 <bigint_sub_bigint_u_mem>
c0d00668:	2000      	movs	r0, #0
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d0066a:	0081      	lsls	r1, r0, #2
c0d0066c:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d0066e:	1a73      	subs	r3, r6, r1
c0d00670:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d00672:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d00674:	62da      	str	r2, [r3, #44]	; 0x2c
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d00676:	1c40      	adds	r0, r0, #1
c0d00678:	2806      	cmp	r0, #6
c0d0067a:	d1f6      	bne.n	c0d0066a <trints_to_words_u_mem+0xfa>
c0d0067c:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d0067e:	0081      	lsls	r1, r0, #2
c0d00680:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d00682:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00684:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d00686:	1c40      	adds	r0, r0, #1
c0d00688:	280c      	cmp	r0, #12
c0d0068a:	d1f8      	bne.n	c0d0067e <trints_to_words_u_mem+0x10e>
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
c0d0068c:	2000      	movs	r0, #0
c0d0068e:	b015      	add	sp, #84	; 0x54
c0d00690:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00692:	46c0      	nop			; (mov r8, r8)
c0d00694:	00002f10 	.word	0x00002f10
c0d00698:	00002ed6 	.word	0x00002ed6
c0d0069c:	00002f00 	.word	0x00002f00

c0d006a0 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d006a0:	b580      	push	{r7, lr}
c0d006a2:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d006a4:	2003      	movs	r0, #3
c0d006a6:	01c1      	lsls	r1, r0, #7
c0d006a8:	4802      	ldr	r0, [pc, #8]	; (c0d006b4 <kerl_initialize+0x14>)
c0d006aa:	f001 fafd 	bl	c0d01ca8 <cx_keccak_init>
    return 0;
c0d006ae:	2000      	movs	r0, #0
c0d006b0:	bd80      	pop	{r7, pc}
c0d006b2:	46c0      	nop			; (mov r8, r8)
c0d006b4:	20001840 	.word	0x20001840

c0d006b8 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d006b8:	b580      	push	{r7, lr}
c0d006ba:	af00      	add	r7, sp, #0
c0d006bc:	b082      	sub	sp, #8
c0d006be:	460b      	mov	r3, r1
c0d006c0:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d006c2:	4805      	ldr	r0, [pc, #20]	; (c0d006d8 <kerl_absorb_bytes+0x20>)
c0d006c4:	4669      	mov	r1, sp
c0d006c6:	6008      	str	r0, [r1, #0]
c0d006c8:	4804      	ldr	r0, [pc, #16]	; (c0d006dc <kerl_absorb_bytes+0x24>)
c0d006ca:	2101      	movs	r1, #1
c0d006cc:	f001 fb0a 	bl	c0d01ce4 <cx_hash>
c0d006d0:	2000      	movs	r0, #0
    return 0;
c0d006d2:	b002      	add	sp, #8
c0d006d4:	bd80      	pop	{r7, pc}
c0d006d6:	46c0      	nop			; (mov r8, r8)
c0d006d8:	200019e8 	.word	0x200019e8
c0d006dc:	20001840 	.word	0x20001840

c0d006e0 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d006e0:	b580      	push	{r7, lr}
c0d006e2:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d006e4:	4804      	ldr	r0, [pc, #16]	; (c0d006f8 <nvram_is_init+0x18>)
c0d006e6:	f001 fa33 	bl	c0d01b50 <pic>
c0d006ea:	7801      	ldrb	r1, [r0, #0]
c0d006ec:	2000      	movs	r0, #0
c0d006ee:	2901      	cmp	r1, #1
c0d006f0:	d100      	bne.n	c0d006f4 <nvram_is_init+0x14>
c0d006f2:	4608      	mov	r0, r1
    else return true;
}
c0d006f4:	bd80      	pop	{r7, pc}
c0d006f6:	46c0      	nop			; (mov r8, r8)
c0d006f8:	c0d03940 	.word	0xc0d03940

c0d006fc <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d006fc:	b5b0      	push	{r4, r5, r7, lr}
c0d006fe:	af02      	add	r7, sp, #8
c0d00700:	4605      	mov	r5, r0
c0d00702:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00704:	4028      	ands	r0, r5
c0d00706:	2400      	movs	r4, #0
c0d00708:	2801      	cmp	r0, #1
c0d0070a:	d013      	beq.n	c0d00734 <io_exchange_al+0x38>
c0d0070c:	2802      	cmp	r0, #2
c0d0070e:	d113      	bne.n	c0d00738 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00710:	2900      	cmp	r1, #0
c0d00712:	d008      	beq.n	c0d00726 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00714:	480b      	ldr	r0, [pc, #44]	; (c0d00744 <io_exchange_al+0x48>)
c0d00716:	f001 fbd7 	bl	c0d01ec8 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d0071a:	b268      	sxtb	r0, r5
c0d0071c:	2800      	cmp	r0, #0
c0d0071e:	da09      	bge.n	c0d00734 <io_exchange_al+0x38>
                reset();
c0d00720:	f001 fa4c 	bl	c0d01bbc <reset>
c0d00724:	e006      	b.n	c0d00734 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00726:	2041      	movs	r0, #65	; 0x41
c0d00728:	0081      	lsls	r1, r0, #2
c0d0072a:	4806      	ldr	r0, [pc, #24]	; (c0d00744 <io_exchange_al+0x48>)
c0d0072c:	2200      	movs	r2, #0
c0d0072e:	f001 fc05 	bl	c0d01f3c <io_seproxyhal_spi_recv>
c0d00732:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00734:	4620      	mov	r0, r4
c0d00736:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00738:	4803      	ldr	r0, [pc, #12]	; (c0d00748 <io_exchange_al+0x4c>)
c0d0073a:	6800      	ldr	r0, [r0, #0]
c0d0073c:	2102      	movs	r1, #2
c0d0073e:	f002 fe65 	bl	c0d0340c <longjmp>
c0d00742:	46c0      	nop			; (mov r8, r8)
c0d00744:	20001c08 	.word	0x20001c08
c0d00748:	20001bb8 	.word	0x20001bb8

c0d0074c <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d0074c:	b580      	push	{r7, lr}
c0d0074e:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00750:	f000 fe8e 	bl	c0d01470 <io_seproxyhal_display_default>
}
c0d00754:	bd80      	pop	{r7, pc}
	...

c0d00758 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00758:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0075a:	af03      	add	r7, sp, #12
c0d0075c:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0075e:	48a6      	ldr	r0, [pc, #664]	; (c0d009f8 <io_event+0x2a0>)
c0d00760:	7800      	ldrb	r0, [r0, #0]
c0d00762:	2805      	cmp	r0, #5
c0d00764:	d02e      	beq.n	c0d007c4 <io_event+0x6c>
c0d00766:	280d      	cmp	r0, #13
c0d00768:	d04e      	beq.n	c0d00808 <io_event+0xb0>
c0d0076a:	280c      	cmp	r0, #12
c0d0076c:	d000      	beq.n	c0d00770 <io_event+0x18>
c0d0076e:	e13a      	b.n	c0d009e6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00770:	4ea2      	ldr	r6, [pc, #648]	; (c0d009fc <io_event+0x2a4>)
c0d00772:	2001      	movs	r0, #1
c0d00774:	7630      	strb	r0, [r6, #24]
c0d00776:	2500      	movs	r5, #0
c0d00778:	61f5      	str	r5, [r6, #28]
c0d0077a:	4634      	mov	r4, r6
c0d0077c:	3418      	adds	r4, #24
c0d0077e:	4620      	mov	r0, r4
c0d00780:	f001 fb68 	bl	c0d01e54 <os_ux>
c0d00784:	61f0      	str	r0, [r6, #28]
c0d00786:	499e      	ldr	r1, [pc, #632]	; (c0d00a00 <io_event+0x2a8>)
c0d00788:	4288      	cmp	r0, r1
c0d0078a:	d100      	bne.n	c0d0078e <io_event+0x36>
c0d0078c:	e12b      	b.n	c0d009e6 <io_event+0x28e>
c0d0078e:	2800      	cmp	r0, #0
c0d00790:	d100      	bne.n	c0d00794 <io_event+0x3c>
c0d00792:	e128      	b.n	c0d009e6 <io_event+0x28e>
c0d00794:	499b      	ldr	r1, [pc, #620]	; (c0d00a04 <io_event+0x2ac>)
c0d00796:	4288      	cmp	r0, r1
c0d00798:	d000      	beq.n	c0d0079c <io_event+0x44>
c0d0079a:	e0ac      	b.n	c0d008f6 <io_event+0x19e>
c0d0079c:	2003      	movs	r0, #3
c0d0079e:	7630      	strb	r0, [r6, #24]
c0d007a0:	61f5      	str	r5, [r6, #28]
c0d007a2:	4620      	mov	r0, r4
c0d007a4:	f001 fb56 	bl	c0d01e54 <os_ux>
c0d007a8:	61f0      	str	r0, [r6, #28]
c0d007aa:	f000 fd17 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d007ae:	60b5      	str	r5, [r6, #8]
c0d007b0:	6830      	ldr	r0, [r6, #0]
c0d007b2:	2800      	cmp	r0, #0
c0d007b4:	d100      	bne.n	c0d007b8 <io_event+0x60>
c0d007b6:	e116      	b.n	c0d009e6 <io_event+0x28e>
c0d007b8:	69f0      	ldr	r0, [r6, #28]
c0d007ba:	4991      	ldr	r1, [pc, #580]	; (c0d00a00 <io_event+0x2a8>)
c0d007bc:	4288      	cmp	r0, r1
c0d007be:	d000      	beq.n	c0d007c2 <io_event+0x6a>
c0d007c0:	e096      	b.n	c0d008f0 <io_event+0x198>
c0d007c2:	e110      	b.n	c0d009e6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d007c4:	4d8d      	ldr	r5, [pc, #564]	; (c0d009fc <io_event+0x2a4>)
c0d007c6:	2001      	movs	r0, #1
c0d007c8:	7628      	strb	r0, [r5, #24]
c0d007ca:	2600      	movs	r6, #0
c0d007cc:	61ee      	str	r6, [r5, #28]
c0d007ce:	462c      	mov	r4, r5
c0d007d0:	3418      	adds	r4, #24
c0d007d2:	4620      	mov	r0, r4
c0d007d4:	f001 fb3e 	bl	c0d01e54 <os_ux>
c0d007d8:	4601      	mov	r1, r0
c0d007da:	61e9      	str	r1, [r5, #28]
c0d007dc:	4889      	ldr	r0, [pc, #548]	; (c0d00a04 <io_event+0x2ac>)
c0d007de:	4281      	cmp	r1, r0
c0d007e0:	d15d      	bne.n	c0d0089e <io_event+0x146>
c0d007e2:	2003      	movs	r0, #3
c0d007e4:	7628      	strb	r0, [r5, #24]
c0d007e6:	61ee      	str	r6, [r5, #28]
c0d007e8:	4620      	mov	r0, r4
c0d007ea:	f001 fb33 	bl	c0d01e54 <os_ux>
c0d007ee:	61e8      	str	r0, [r5, #28]
c0d007f0:	f000 fcf4 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d007f4:	60ae      	str	r6, [r5, #8]
c0d007f6:	6828      	ldr	r0, [r5, #0]
c0d007f8:	2800      	cmp	r0, #0
c0d007fa:	d100      	bne.n	c0d007fe <io_event+0xa6>
c0d007fc:	e0f3      	b.n	c0d009e6 <io_event+0x28e>
c0d007fe:	69e8      	ldr	r0, [r5, #28]
c0d00800:	497f      	ldr	r1, [pc, #508]	; (c0d00a00 <io_event+0x2a8>)
c0d00802:	4288      	cmp	r0, r1
c0d00804:	d148      	bne.n	c0d00898 <io_event+0x140>
c0d00806:	e0ee      	b.n	c0d009e6 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00808:	4d7c      	ldr	r5, [pc, #496]	; (c0d009fc <io_event+0x2a4>)
c0d0080a:	6868      	ldr	r0, [r5, #4]
c0d0080c:	68a9      	ldr	r1, [r5, #8]
c0d0080e:	4281      	cmp	r1, r0
c0d00810:	d300      	bcc.n	c0d00814 <io_event+0xbc>
c0d00812:	e0e8      	b.n	c0d009e6 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00814:	2001      	movs	r0, #1
c0d00816:	7628      	strb	r0, [r5, #24]
c0d00818:	2600      	movs	r6, #0
c0d0081a:	61ee      	str	r6, [r5, #28]
c0d0081c:	462c      	mov	r4, r5
c0d0081e:	3418      	adds	r4, #24
c0d00820:	4620      	mov	r0, r4
c0d00822:	f001 fb17 	bl	c0d01e54 <os_ux>
c0d00826:	61e8      	str	r0, [r5, #28]
c0d00828:	4975      	ldr	r1, [pc, #468]	; (c0d00a00 <io_event+0x2a8>)
c0d0082a:	4288      	cmp	r0, r1
c0d0082c:	d100      	bne.n	c0d00830 <io_event+0xd8>
c0d0082e:	e0da      	b.n	c0d009e6 <io_event+0x28e>
c0d00830:	2800      	cmp	r0, #0
c0d00832:	d100      	bne.n	c0d00836 <io_event+0xde>
c0d00834:	e0d7      	b.n	c0d009e6 <io_event+0x28e>
c0d00836:	4973      	ldr	r1, [pc, #460]	; (c0d00a04 <io_event+0x2ac>)
c0d00838:	4288      	cmp	r0, r1
c0d0083a:	d000      	beq.n	c0d0083e <io_event+0xe6>
c0d0083c:	e08d      	b.n	c0d0095a <io_event+0x202>
c0d0083e:	2003      	movs	r0, #3
c0d00840:	7628      	strb	r0, [r5, #24]
c0d00842:	61ee      	str	r6, [r5, #28]
c0d00844:	4620      	mov	r0, r4
c0d00846:	f001 fb05 	bl	c0d01e54 <os_ux>
c0d0084a:	61e8      	str	r0, [r5, #28]
c0d0084c:	f000 fcc6 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d00850:	60ae      	str	r6, [r5, #8]
c0d00852:	6828      	ldr	r0, [r5, #0]
c0d00854:	2800      	cmp	r0, #0
c0d00856:	d100      	bne.n	c0d0085a <io_event+0x102>
c0d00858:	e0c5      	b.n	c0d009e6 <io_event+0x28e>
c0d0085a:	69e8      	ldr	r0, [r5, #28]
c0d0085c:	4968      	ldr	r1, [pc, #416]	; (c0d00a00 <io_event+0x2a8>)
c0d0085e:	4288      	cmp	r0, r1
c0d00860:	d178      	bne.n	c0d00954 <io_event+0x1fc>
c0d00862:	e0c0      	b.n	c0d009e6 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00864:	6868      	ldr	r0, [r5, #4]
c0d00866:	4286      	cmp	r6, r0
c0d00868:	d300      	bcc.n	c0d0086c <io_event+0x114>
c0d0086a:	e0bc      	b.n	c0d009e6 <io_event+0x28e>
c0d0086c:	f001 fb4a 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d00870:	2800      	cmp	r0, #0
c0d00872:	d000      	beq.n	c0d00876 <io_event+0x11e>
c0d00874:	e0b7      	b.n	c0d009e6 <io_event+0x28e>
c0d00876:	68a8      	ldr	r0, [r5, #8]
c0d00878:	68e9      	ldr	r1, [r5, #12]
c0d0087a:	2438      	movs	r4, #56	; 0x38
c0d0087c:	4360      	muls	r0, r4
c0d0087e:	682a      	ldr	r2, [r5, #0]
c0d00880:	1810      	adds	r0, r2, r0
c0d00882:	2900      	cmp	r1, #0
c0d00884:	d100      	bne.n	c0d00888 <io_event+0x130>
c0d00886:	e085      	b.n	c0d00994 <io_event+0x23c>
c0d00888:	4788      	blx	r1
c0d0088a:	2800      	cmp	r0, #0
c0d0088c:	d000      	beq.n	c0d00890 <io_event+0x138>
c0d0088e:	e081      	b.n	c0d00994 <io_event+0x23c>
c0d00890:	68a8      	ldr	r0, [r5, #8]
c0d00892:	1c46      	adds	r6, r0, #1
c0d00894:	60ae      	str	r6, [r5, #8]
c0d00896:	6828      	ldr	r0, [r5, #0]
c0d00898:	2800      	cmp	r0, #0
c0d0089a:	d1e3      	bne.n	c0d00864 <io_event+0x10c>
c0d0089c:	e0a3      	b.n	c0d009e6 <io_event+0x28e>
c0d0089e:	6928      	ldr	r0, [r5, #16]
c0d008a0:	2800      	cmp	r0, #0
c0d008a2:	d100      	bne.n	c0d008a6 <io_event+0x14e>
c0d008a4:	e09f      	b.n	c0d009e6 <io_event+0x28e>
c0d008a6:	4a56      	ldr	r2, [pc, #344]	; (c0d00a00 <io_event+0x2a8>)
c0d008a8:	4291      	cmp	r1, r2
c0d008aa:	d100      	bne.n	c0d008ae <io_event+0x156>
c0d008ac:	e09b      	b.n	c0d009e6 <io_event+0x28e>
c0d008ae:	2900      	cmp	r1, #0
c0d008b0:	d100      	bne.n	c0d008b4 <io_event+0x15c>
c0d008b2:	e098      	b.n	c0d009e6 <io_event+0x28e>
c0d008b4:	4950      	ldr	r1, [pc, #320]	; (c0d009f8 <io_event+0x2a0>)
c0d008b6:	78c9      	ldrb	r1, [r1, #3]
c0d008b8:	0849      	lsrs	r1, r1, #1
c0d008ba:	f000 fe1b 	bl	c0d014f4 <io_seproxyhal_button_push>
c0d008be:	e092      	b.n	c0d009e6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d008c0:	6870      	ldr	r0, [r6, #4]
c0d008c2:	4285      	cmp	r5, r0
c0d008c4:	d300      	bcc.n	c0d008c8 <io_event+0x170>
c0d008c6:	e08e      	b.n	c0d009e6 <io_event+0x28e>
c0d008c8:	f001 fb1c 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d008cc:	2800      	cmp	r0, #0
c0d008ce:	d000      	beq.n	c0d008d2 <io_event+0x17a>
c0d008d0:	e089      	b.n	c0d009e6 <io_event+0x28e>
c0d008d2:	68b0      	ldr	r0, [r6, #8]
c0d008d4:	68f1      	ldr	r1, [r6, #12]
c0d008d6:	2438      	movs	r4, #56	; 0x38
c0d008d8:	4360      	muls	r0, r4
c0d008da:	6832      	ldr	r2, [r6, #0]
c0d008dc:	1810      	adds	r0, r2, r0
c0d008de:	2900      	cmp	r1, #0
c0d008e0:	d076      	beq.n	c0d009d0 <io_event+0x278>
c0d008e2:	4788      	blx	r1
c0d008e4:	2800      	cmp	r0, #0
c0d008e6:	d173      	bne.n	c0d009d0 <io_event+0x278>
c0d008e8:	68b0      	ldr	r0, [r6, #8]
c0d008ea:	1c45      	adds	r5, r0, #1
c0d008ec:	60b5      	str	r5, [r6, #8]
c0d008ee:	6830      	ldr	r0, [r6, #0]
c0d008f0:	2800      	cmp	r0, #0
c0d008f2:	d1e5      	bne.n	c0d008c0 <io_event+0x168>
c0d008f4:	e077      	b.n	c0d009e6 <io_event+0x28e>
c0d008f6:	88b0      	ldrh	r0, [r6, #4]
c0d008f8:	9004      	str	r0, [sp, #16]
c0d008fa:	6830      	ldr	r0, [r6, #0]
c0d008fc:	9003      	str	r0, [sp, #12]
c0d008fe:	483e      	ldr	r0, [pc, #248]	; (c0d009f8 <io_event+0x2a0>)
c0d00900:	4601      	mov	r1, r0
c0d00902:	79cc      	ldrb	r4, [r1, #7]
c0d00904:	798b      	ldrb	r3, [r1, #6]
c0d00906:	794d      	ldrb	r5, [r1, #5]
c0d00908:	790a      	ldrb	r2, [r1, #4]
c0d0090a:	4630      	mov	r0, r6
c0d0090c:	78ce      	ldrb	r6, [r1, #3]
c0d0090e:	68c1      	ldr	r1, [r0, #12]
c0d00910:	4668      	mov	r0, sp
c0d00912:	6006      	str	r6, [r0, #0]
c0d00914:	6041      	str	r1, [r0, #4]
c0d00916:	0212      	lsls	r2, r2, #8
c0d00918:	432a      	orrs	r2, r5
c0d0091a:	021b      	lsls	r3, r3, #8
c0d0091c:	4323      	orrs	r3, r4
c0d0091e:	9803      	ldr	r0, [sp, #12]
c0d00920:	9904      	ldr	r1, [sp, #16]
c0d00922:	f000 fcd5 	bl	c0d012d0 <io_seproxyhal_touch_element_callback>
c0d00926:	e05e      	b.n	c0d009e6 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00928:	6868      	ldr	r0, [r5, #4]
c0d0092a:	4286      	cmp	r6, r0
c0d0092c:	d25b      	bcs.n	c0d009e6 <io_event+0x28e>
c0d0092e:	f001 fae9 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d00932:	2800      	cmp	r0, #0
c0d00934:	d157      	bne.n	c0d009e6 <io_event+0x28e>
c0d00936:	68a8      	ldr	r0, [r5, #8]
c0d00938:	68e9      	ldr	r1, [r5, #12]
c0d0093a:	2438      	movs	r4, #56	; 0x38
c0d0093c:	4360      	muls	r0, r4
c0d0093e:	682a      	ldr	r2, [r5, #0]
c0d00940:	1810      	adds	r0, r2, r0
c0d00942:	2900      	cmp	r1, #0
c0d00944:	d026      	beq.n	c0d00994 <io_event+0x23c>
c0d00946:	4788      	blx	r1
c0d00948:	2800      	cmp	r0, #0
c0d0094a:	d123      	bne.n	c0d00994 <io_event+0x23c>
c0d0094c:	68a8      	ldr	r0, [r5, #8]
c0d0094e:	1c46      	adds	r6, r0, #1
c0d00950:	60ae      	str	r6, [r5, #8]
c0d00952:	6828      	ldr	r0, [r5, #0]
c0d00954:	2800      	cmp	r0, #0
c0d00956:	d1e7      	bne.n	c0d00928 <io_event+0x1d0>
c0d00958:	e045      	b.n	c0d009e6 <io_event+0x28e>
c0d0095a:	6828      	ldr	r0, [r5, #0]
c0d0095c:	2800      	cmp	r0, #0
c0d0095e:	d030      	beq.n	c0d009c2 <io_event+0x26a>
c0d00960:	68a8      	ldr	r0, [r5, #8]
c0d00962:	6869      	ldr	r1, [r5, #4]
c0d00964:	4288      	cmp	r0, r1
c0d00966:	d22c      	bcs.n	c0d009c2 <io_event+0x26a>
c0d00968:	f001 facc 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d0096c:	2800      	cmp	r0, #0
c0d0096e:	d128      	bne.n	c0d009c2 <io_event+0x26a>
c0d00970:	68a8      	ldr	r0, [r5, #8]
c0d00972:	68e9      	ldr	r1, [r5, #12]
c0d00974:	2438      	movs	r4, #56	; 0x38
c0d00976:	4360      	muls	r0, r4
c0d00978:	682a      	ldr	r2, [r5, #0]
c0d0097a:	1810      	adds	r0, r2, r0
c0d0097c:	2900      	cmp	r1, #0
c0d0097e:	d015      	beq.n	c0d009ac <io_event+0x254>
c0d00980:	4788      	blx	r1
c0d00982:	2800      	cmp	r0, #0
c0d00984:	d112      	bne.n	c0d009ac <io_event+0x254>
c0d00986:	68a8      	ldr	r0, [r5, #8]
c0d00988:	1c40      	adds	r0, r0, #1
c0d0098a:	60a8      	str	r0, [r5, #8]
c0d0098c:	6829      	ldr	r1, [r5, #0]
c0d0098e:	2900      	cmp	r1, #0
c0d00990:	d1e7      	bne.n	c0d00962 <io_event+0x20a>
c0d00992:	e016      	b.n	c0d009c2 <io_event+0x26a>
c0d00994:	2801      	cmp	r0, #1
c0d00996:	d103      	bne.n	c0d009a0 <io_event+0x248>
c0d00998:	68a8      	ldr	r0, [r5, #8]
c0d0099a:	4344      	muls	r4, r0
c0d0099c:	6828      	ldr	r0, [r5, #0]
c0d0099e:	1900      	adds	r0, r0, r4
c0d009a0:	f000 fd66 	bl	c0d01470 <io_seproxyhal_display_default>
c0d009a4:	68a8      	ldr	r0, [r5, #8]
c0d009a6:	1c40      	adds	r0, r0, #1
c0d009a8:	60a8      	str	r0, [r5, #8]
c0d009aa:	e01c      	b.n	c0d009e6 <io_event+0x28e>
c0d009ac:	2801      	cmp	r0, #1
c0d009ae:	d103      	bne.n	c0d009b8 <io_event+0x260>
c0d009b0:	68a8      	ldr	r0, [r5, #8]
c0d009b2:	4344      	muls	r4, r0
c0d009b4:	6828      	ldr	r0, [r5, #0]
c0d009b6:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d009b8:	f000 fd5a 	bl	c0d01470 <io_seproxyhal_display_default>
c0d009bc:	68a8      	ldr	r0, [r5, #8]
c0d009be:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d009c0:	60a8      	str	r0, [r5, #8]
c0d009c2:	6868      	ldr	r0, [r5, #4]
c0d009c4:	68a9      	ldr	r1, [r5, #8]
c0d009c6:	4281      	cmp	r1, r0
c0d009c8:	d30d      	bcc.n	c0d009e6 <io_event+0x28e>
c0d009ca:	f001 fa9b 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d009ce:	e00a      	b.n	c0d009e6 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d009d0:	2801      	cmp	r0, #1
c0d009d2:	d103      	bne.n	c0d009dc <io_event+0x284>
c0d009d4:	68b0      	ldr	r0, [r6, #8]
c0d009d6:	4344      	muls	r4, r0
c0d009d8:	6830      	ldr	r0, [r6, #0]
c0d009da:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d009dc:	f000 fd48 	bl	c0d01470 <io_seproxyhal_display_default>
c0d009e0:	68b0      	ldr	r0, [r6, #8]
c0d009e2:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d009e4:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d009e6:	f001 fa8d 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d009ea:	2800      	cmp	r0, #0
c0d009ec:	d101      	bne.n	c0d009f2 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d009ee:	f000 fac9 	bl	c0d00f84 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d009f2:	2001      	movs	r0, #1
c0d009f4:	b005      	add	sp, #20
c0d009f6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d009f8:	20001a18 	.word	0x20001a18
c0d009fc:	20001a98 	.word	0x20001a98
c0d00a00:	b0105044 	.word	0xb0105044
c0d00a04:	b0105055 	.word	0xb0105055

c0d00a08 <IOTA_main>:





static void IOTA_main(void) {
c0d00a08:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a0a:	af03      	add	r7, sp, #12
c0d00a0c:	b0dd      	sub	sp, #372	; 0x174
c0d00a0e:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00a10:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00a12:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00a14:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00a16:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00c9c <IOTA_main+0x294>)
c0d00a18:	2110      	movs	r1, #16
c0d00a1a:	2203      	movs	r2, #3
c0d00a1c:	9109      	str	r1, [sp, #36]	; 0x24
c0d00a1e:	9208      	str	r2, [sp, #32]
c0d00a20:	f7ff fb40 	bl	c0d000a4 <write_debug>
c0d00a24:	a80e      	add	r0, sp, #56	; 0x38
c0d00a26:	304d      	adds	r0, #77	; 0x4d
c0d00a28:	9007      	str	r0, [sp, #28]
c0d00a2a:	a80b      	add	r0, sp, #44	; 0x2c
c0d00a2c:	1dc1      	adds	r1, r0, #7
c0d00a2e:	9106      	str	r1, [sp, #24]
c0d00a30:	1d00      	adds	r0, r0, #4
c0d00a32:	9005      	str	r0, [sp, #20]
c0d00a34:	4e9d      	ldr	r6, [pc, #628]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00a36:	6830      	ldr	r0, [r6, #0]
c0d00a38:	e08d      	b.n	c0d00b56 <IOTA_main+0x14e>
c0d00a3a:	489f      	ldr	r0, [pc, #636]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00a3c:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00a3e:	4330      	orrs	r0, r6
c0d00a40:	2880      	cmp	r0, #128	; 0x80
c0d00a42:	d000      	beq.n	c0d00a46 <IOTA_main+0x3e>
c0d00a44:	e11e      	b.n	c0d00c84 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00a46:	7810      	ldrb	r0, [r2, #0]
c0d00a48:	2800      	cmp	r0, #0
c0d00a4a:	4e98      	ldr	r6, [pc, #608]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00a4c:	d004      	beq.n	c0d00a58 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00a4e:	489c      	ldr	r0, [pc, #624]	; (c0d00cc0 <IOTA_main+0x2b8>)
c0d00a50:	f001 f90c 	bl	c0d01c6c <cx_sha256_init>
                        hashTainted = 0;
c0d00a54:	4899      	ldr	r0, [pc, #612]	; (c0d00cbc <IOTA_main+0x2b4>)
c0d00a56:	7004      	strb	r4, [r0, #0]
c0d00a58:	4897      	ldr	r0, [pc, #604]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00a5a:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00a5c:	7908      	ldrb	r0, [r1, #4]
c0d00a5e:	1808      	adds	r0, r1, r0
c0d00a60:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00a62:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00a64:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00a66:	4308      	orrs	r0, r1
c0d00a68:	905a      	str	r0, [sp, #360]	; 0x168
c0d00a6a:	e0e5      	b.n	c0d00c38 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00a6c:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00a6e:	2818      	cmp	r0, #24
c0d00a70:	d800      	bhi.n	c0d00a74 <IOTA_main+0x6c>
c0d00a72:	e10c      	b.n	c0d00c8e <IOTA_main+0x286>
c0d00a74:	950a      	str	r5, [sp, #40]	; 0x28
c0d00a76:	4d90      	ldr	r5, [pc, #576]	; (c0d00cb8 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00a78:	00a0      	lsls	r0, r4, #2
c0d00a7a:	1829      	adds	r1, r5, r0
c0d00a7c:	794a      	ldrb	r2, [r1, #5]
c0d00a7e:	0612      	lsls	r2, r2, #24
c0d00a80:	798b      	ldrb	r3, [r1, #6]
c0d00a82:	041b      	lsls	r3, r3, #16
c0d00a84:	4313      	orrs	r3, r2
c0d00a86:	79ca      	ldrb	r2, [r1, #7]
c0d00a88:	0212      	lsls	r2, r2, #8
c0d00a8a:	431a      	orrs	r2, r3
c0d00a8c:	7a09      	ldrb	r1, [r1, #8]
c0d00a8e:	4311      	orrs	r1, r2
c0d00a90:	aa2b      	add	r2, sp, #172	; 0xac
c0d00a92:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00a94:	1c64      	adds	r4, r4, #1
c0d00a96:	2c05      	cmp	r4, #5
c0d00a98:	d1ee      	bne.n	c0d00a78 <IOTA_main+0x70>
c0d00a9a:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00a9c:	9103      	str	r1, [sp, #12]
c0d00a9e:	4668      	mov	r0, sp
c0d00aa0:	6001      	str	r1, [r0, #0]
c0d00aa2:	2421      	movs	r4, #33	; 0x21
c0d00aa4:	a92b      	add	r1, sp, #172	; 0xac
c0d00aa6:	2205      	movs	r2, #5
c0d00aa8:	ad23      	add	r5, sp, #140	; 0x8c
c0d00aaa:	9502      	str	r5, [sp, #8]
c0d00aac:	4620      	mov	r0, r4
c0d00aae:	462b      	mov	r3, r5
c0d00ab0:	f001 f992 	bl	c0d01dd8 <os_perso_derive_node_bip32>
c0d00ab4:	2220      	movs	r2, #32
c0d00ab6:	9204      	str	r2, [sp, #16]
c0d00ab8:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00aba:	9301      	str	r3, [sp, #4]
c0d00abc:	4620      	mov	r0, r4
c0d00abe:	4629      	mov	r1, r5
c0d00ac0:	f001 f94e 	bl	c0d01d60 <cx_ecfp_init_private_key>
c0d00ac4:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00ac6:	4620      	mov	r0, r4
c0d00ac8:	9903      	ldr	r1, [sp, #12]
c0d00aca:	460a      	mov	r2, r1
c0d00acc:	462b      	mov	r3, r5
c0d00ace:	f001 f929 	bl	c0d01d24 <cx_ecfp_init_public_key>
c0d00ad2:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00ad4:	4620      	mov	r0, r4
c0d00ad6:	4629      	mov	r1, r5
c0d00ad8:	9a01      	ldr	r2, [sp, #4]
c0d00ada:	f001 f95f 	bl	c0d01d9c <cx_ecfp_generate_pair>
c0d00ade:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00ae0:	9802      	ldr	r0, [sp, #8]
c0d00ae2:	9904      	ldr	r1, [sp, #16]
c0d00ae4:	4622      	mov	r2, r4
c0d00ae6:	f7ff fb77 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00aea:	2552      	movs	r5, #82	; 0x52
c0d00aec:	4872      	ldr	r0, [pc, #456]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00aee:	4621      	mov	r1, r4
c0d00af0:	462a      	mov	r2, r5
c0d00af2:	f000 f9ad 	bl	c0d00e50 <os_memmove>
                    tx = 82;
c0d00af6:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00af8:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00afa:	1c41      	adds	r1, r0, #1
c0d00afc:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00afe:	3610      	adds	r6, #16
c0d00b00:	4a6d      	ldr	r2, [pc, #436]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00b02:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00b04:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b06:	1c41      	adds	r1, r0, #1
c0d00b08:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00b0a:	9903      	ldr	r1, [sp, #12]
c0d00b0c:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00b0e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b10:	b281      	uxth	r1, r0
c0d00b12:	9804      	ldr	r0, [sp, #16]
c0d00b14:	f000 fd2a 	bl	c0d0156c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00b18:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00b1a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00b1c:	4308      	orrs	r0, r1
c0d00b1e:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00b20:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00b22:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00b24:	202e      	movs	r0, #46	; 0x2e
c0d00b26:	9905      	ldr	r1, [sp, #20]
c0d00b28:	7048      	strb	r0, [r1, #1]
c0d00b2a:	7008      	strb	r0, [r1, #0]
c0d00b2c:	7088      	strb	r0, [r1, #2]
c0d00b2e:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00b30:	78c8      	ldrb	r0, [r1, #3]
c0d00b32:	9a06      	ldr	r2, [sp, #24]
c0d00b34:	70d0      	strb	r0, [r2, #3]
c0d00b36:	7888      	ldrb	r0, [r1, #2]
c0d00b38:	7090      	strb	r0, [r2, #2]
c0d00b3a:	7848      	ldrb	r0, [r1, #1]
c0d00b3c:	7050      	strb	r0, [r2, #1]
c0d00b3e:	7808      	ldrb	r0, [r1, #0]
c0d00b40:	7010      	strb	r0, [r2, #0]
c0d00b42:	7908      	ldrb	r0, [r1, #4]
c0d00b44:	7110      	strb	r0, [r2, #4]
c0d00b46:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00b48:	2140      	movs	r1, #64	; 0x40
c0d00b4a:	2203      	movs	r2, #3
c0d00b4c:	f001 fa8a 	bl	c0d02064 <ui_display_debug>
c0d00b50:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00b52:	4e56      	ldr	r6, [pc, #344]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00b54:	e070      	b.n	c0d00c38 <IOTA_main+0x230>
c0d00b56:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00b58:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00b5a:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00b5c:	ac4d      	add	r4, sp, #308	; 0x134
c0d00b5e:	4620      	mov	r0, r4
c0d00b60:	f002 fc48 	bl	c0d033f4 <setjmp>
c0d00b64:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00b66:	6034      	str	r4, [r6, #0]
c0d00b68:	4951      	ldr	r1, [pc, #324]	; (c0d00cb0 <IOTA_main+0x2a8>)
c0d00b6a:	4208      	tst	r0, r1
c0d00b6c:	d011      	beq.n	c0d00b92 <IOTA_main+0x18a>
c0d00b6e:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00b70:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00b72:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00b74:	6031      	str	r1, [r6, #0]
c0d00b76:	210f      	movs	r1, #15
c0d00b78:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00b7a:	4001      	ands	r1, r0
c0d00b7c:	2209      	movs	r2, #9
c0d00b7e:	0312      	lsls	r2, r2, #12
c0d00b80:	4291      	cmp	r1, r2
c0d00b82:	d003      	beq.n	c0d00b8c <IOTA_main+0x184>
c0d00b84:	9a08      	ldr	r2, [sp, #32]
c0d00b86:	0352      	lsls	r2, r2, #13
c0d00b88:	4291      	cmp	r1, r2
c0d00b8a:	d142      	bne.n	c0d00c12 <IOTA_main+0x20a>
c0d00b8c:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00b8e:	8008      	strh	r0, [r1, #0]
c0d00b90:	e046      	b.n	c0d00c20 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00b92:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00b94:	905c      	str	r0, [sp, #368]	; 0x170
c0d00b96:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00b98:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00b9a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00b9c:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00b9e:	b2c0      	uxtb	r0, r0
c0d00ba0:	b289      	uxth	r1, r1
c0d00ba2:	f000 fce3 	bl	c0d0156c <io_exchange>
c0d00ba6:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00ba8:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00baa:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00bac:	2800      	cmp	r0, #0
c0d00bae:	d053      	beq.n	c0d00c58 <IOTA_main+0x250>
c0d00bb0:	4941      	ldr	r1, [pc, #260]	; (c0d00cb8 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00bb2:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00bb4:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00bb6:	2880      	cmp	r0, #128	; 0x80
c0d00bb8:	4a40      	ldr	r2, [pc, #256]	; (c0d00cbc <IOTA_main+0x2b4>)
c0d00bba:	d155      	bne.n	c0d00c68 <IOTA_main+0x260>
c0d00bbc:	7848      	ldrb	r0, [r1, #1]
c0d00bbe:	216d      	movs	r1, #109	; 0x6d
c0d00bc0:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00bc2:	2807      	cmp	r0, #7
c0d00bc4:	dc3f      	bgt.n	c0d00c46 <IOTA_main+0x23e>
c0d00bc6:	2802      	cmp	r0, #2
c0d00bc8:	d100      	bne.n	c0d00bcc <IOTA_main+0x1c4>
c0d00bca:	e74f      	b.n	c0d00a6c <IOTA_main+0x64>
c0d00bcc:	2804      	cmp	r0, #4
c0d00bce:	d153      	bne.n	c0d00c78 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00bd0:	210b      	movs	r1, #11
c0d00bd2:	2203      	movs	r2, #3
c0d00bd4:	a03c      	add	r0, pc, #240	; (adr r0, c0d00cc8 <IOTA_main+0x2c0>)
c0d00bd6:	f7ff fa65 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00bda:	2048      	movs	r0, #72	; 0x48
c0d00bdc:	4936      	ldr	r1, [pc, #216]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00bde:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00be0:	2049      	movs	r0, #73	; 0x49
c0d00be2:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00be4:	2021      	movs	r0, #33	; 0x21
c0d00be6:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00be8:	3610      	adds	r6, #16
c0d00bea:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00bec:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00bee:	2005      	movs	r0, #5
c0d00bf0:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00bf2:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00bf4:	b281      	uxth	r1, r0
c0d00bf6:	2020      	movs	r0, #32
c0d00bf8:	f000 fcb8 	bl	c0d0156c <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00bfc:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00bfe:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00c00:	4308      	orrs	r0, r1
c0d00c02:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00c04:	4620      	mov	r0, r4
c0d00c06:	4621      	mov	r1, r4
c0d00c08:	4622      	mov	r2, r4
c0d00c0a:	f001 fa2b 	bl	c0d02064 <ui_display_debug>
c0d00c0e:	4e27      	ldr	r6, [pc, #156]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c10:	e012      	b.n	c0d00c38 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00c12:	4928      	ldr	r1, [pc, #160]	; (c0d00cb4 <IOTA_main+0x2ac>)
c0d00c14:	4008      	ands	r0, r1
c0d00c16:	210d      	movs	r1, #13
c0d00c18:	02c9      	lsls	r1, r1, #11
c0d00c1a:	4301      	orrs	r1, r0
c0d00c1c:	a859      	add	r0, sp, #356	; 0x164
c0d00c1e:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00c20:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00c22:	0a00      	lsrs	r0, r0, #8
c0d00c24:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00c26:	4a24      	ldr	r2, [pc, #144]	; (c0d00cb8 <IOTA_main+0x2b0>)
c0d00c28:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00c2a:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00c2c:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00c2e:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00c30:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00c32:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00c34:	1c80      	adds	r0, r0, #2
c0d00c36:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00c38:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00c3a:	6030      	str	r0, [r6, #0]
c0d00c3c:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00c3e:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00c40:	2900      	cmp	r1, #0
c0d00c42:	d088      	beq.n	c0d00b56 <IOTA_main+0x14e>
c0d00c44:	e006      	b.n	c0d00c54 <IOTA_main+0x24c>
c0d00c46:	2808      	cmp	r0, #8
c0d00c48:	d100      	bne.n	c0d00c4c <IOTA_main+0x244>
c0d00c4a:	e6f6      	b.n	c0d00a3a <IOTA_main+0x32>
c0d00c4c:	28ff      	cmp	r0, #255	; 0xff
c0d00c4e:	d113      	bne.n	c0d00c78 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00c50:	b05d      	add	sp, #372	; 0x174
c0d00c52:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00c54:	f002 fbda 	bl	c0d0340c <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00c58:	2001      	movs	r0, #1
c0d00c5a:	4918      	ldr	r1, [pc, #96]	; (c0d00cbc <IOTA_main+0x2b4>)
c0d00c5c:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00c5e:	4813      	ldr	r0, [pc, #76]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c60:	6800      	ldr	r0, [r0, #0]
c0d00c62:	491c      	ldr	r1, [pc, #112]	; (c0d00cd4 <IOTA_main+0x2cc>)
c0d00c64:	f002 fbd2 	bl	c0d0340c <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00c68:	2001      	movs	r0, #1
c0d00c6a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00c6c:	480f      	ldr	r0, [pc, #60]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c6e:	6800      	ldr	r0, [r0, #0]
c0d00c70:	2137      	movs	r1, #55	; 0x37
c0d00c72:	0249      	lsls	r1, r1, #9
c0d00c74:	f002 fbca 	bl	c0d0340c <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00c78:	2001      	movs	r0, #1
c0d00c7a:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00c7c:	480b      	ldr	r0, [pc, #44]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c7e:	6800      	ldr	r0, [r0, #0]
c0d00c80:	f002 fbc4 	bl	c0d0340c <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00c84:	4809      	ldr	r0, [pc, #36]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c86:	6800      	ldr	r0, [r0, #0]
c0d00c88:	490e      	ldr	r1, [pc, #56]	; (c0d00cc4 <IOTA_main+0x2bc>)
c0d00c8a:	f002 fbbf 	bl	c0d0340c <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00c8e:	2001      	movs	r0, #1
c0d00c90:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00c92:	4806      	ldr	r0, [pc, #24]	; (c0d00cac <IOTA_main+0x2a4>)
c0d00c94:	6800      	ldr	r0, [r0, #0]
c0d00c96:	3109      	adds	r1, #9
c0d00c98:	f002 fbb8 	bl	c0d0340c <longjmp>
c0d00c9c:	74696157 	.word	0x74696157
c0d00ca0:	20676e69 	.word	0x20676e69
c0d00ca4:	20726f66 	.word	0x20726f66
c0d00ca8:	0067736d 	.word	0x0067736d
c0d00cac:	20001bb8 	.word	0x20001bb8
c0d00cb0:	0000ffff 	.word	0x0000ffff
c0d00cb4:	000007ff 	.word	0x000007ff
c0d00cb8:	20001c08 	.word	0x20001c08
c0d00cbc:	20001b48 	.word	0x20001b48
c0d00cc0:	20001b4c 	.word	0x20001b4c
c0d00cc4:	00006a86 	.word	0x00006a86
c0d00cc8:	20646142 	.word	0x20646142
c0d00ccc:	6b627550 	.word	0x6b627550
c0d00cd0:	00007965 	.word	0x00007965
c0d00cd4:	00006982 	.word	0x00006982

c0d00cd8 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00cd8:	4801      	ldr	r0, [pc, #4]	; (c0d00ce0 <os_boot+0x8>)
c0d00cda:	2100      	movs	r1, #0
c0d00cdc:	6001      	str	r1, [r0, #0]
}
c0d00cde:	4770      	bx	lr
c0d00ce0:	20001bb8 	.word	0x20001bb8

c0d00ce4 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00ce4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ce6:	af03      	add	r7, sp, #12
c0d00ce8:	b083      	sub	sp, #12
c0d00cea:	9202      	str	r2, [sp, #8]
c0d00cec:	460c      	mov	r4, r1
c0d00cee:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00cf0:	4d4a      	ldr	r5, [pc, #296]	; (c0d00e1c <io_usb_hid_receive+0x138>)
c0d00cf2:	42ac      	cmp	r4, r5
c0d00cf4:	d00f      	beq.n	c0d00d16 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00cf6:	4e49      	ldr	r6, [pc, #292]	; (c0d00e1c <io_usb_hid_receive+0x138>)
c0d00cf8:	2540      	movs	r5, #64	; 0x40
c0d00cfa:	4630      	mov	r0, r6
c0d00cfc:	4629      	mov	r1, r5
c0d00cfe:	f002 fae3 	bl	c0d032c8 <__aeabi_memclr>
c0d00d02:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00d04:	2840      	cmp	r0, #64	; 0x40
c0d00d06:	4602      	mov	r2, r0
c0d00d08:	d300      	bcc.n	c0d00d0c <io_usb_hid_receive+0x28>
c0d00d0a:	462a      	mov	r2, r5
c0d00d0c:	4630      	mov	r0, r6
c0d00d0e:	4621      	mov	r1, r4
c0d00d10:	f000 f89e 	bl	c0d00e50 <os_memmove>
c0d00d14:	4d41      	ldr	r5, [pc, #260]	; (c0d00e1c <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00d16:	78a8      	ldrb	r0, [r5, #2]
c0d00d18:	2805      	cmp	r0, #5
c0d00d1a:	d900      	bls.n	c0d00d1e <io_usb_hid_receive+0x3a>
c0d00d1c:	e076      	b.n	c0d00e0c <io_usb_hid_receive+0x128>
c0d00d1e:	46c0      	nop			; (mov r8, r8)
c0d00d20:	4478      	add	r0, pc
c0d00d22:	7900      	ldrb	r0, [r0, #4]
c0d00d24:	0040      	lsls	r0, r0, #1
c0d00d26:	4487      	add	pc, r0
c0d00d28:	71130c02 	.word	0x71130c02
c0d00d2c:	1f71      	.short	0x1f71
c0d00d2e:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00d30:	71ae      	strb	r6, [r5, #6]
c0d00d32:	716e      	strb	r6, [r5, #5]
c0d00d34:	712e      	strb	r6, [r5, #4]
c0d00d36:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00d38:	2140      	movs	r1, #64	; 0x40
c0d00d3a:	4628      	mov	r0, r5
c0d00d3c:	9a01      	ldr	r2, [sp, #4]
c0d00d3e:	4790      	blx	r2
c0d00d40:	e00b      	b.n	c0d00d5a <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00d42:	1ce8      	adds	r0, r5, #3
c0d00d44:	2104      	movs	r1, #4
c0d00d46:	f000 ff73 	bl	c0d01c30 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00d4a:	2140      	movs	r1, #64	; 0x40
c0d00d4c:	4628      	mov	r0, r5
c0d00d4e:	e001      	b.n	c0d00d54 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00d50:	4832      	ldr	r0, [pc, #200]	; (c0d00e1c <io_usb_hid_receive+0x138>)
c0d00d52:	2140      	movs	r1, #64	; 0x40
c0d00d54:	9a01      	ldr	r2, [sp, #4]
c0d00d56:	4790      	blx	r2
c0d00d58:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00d5a:	4831      	ldr	r0, [pc, #196]	; (c0d00e20 <io_usb_hid_receive+0x13c>)
c0d00d5c:	2100      	movs	r1, #0
c0d00d5e:	6001      	str	r1, [r0, #0]
c0d00d60:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00d62:	b2c0      	uxtb	r0, r0
c0d00d64:	b003      	add	sp, #12
c0d00d66:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00d68:	78e8      	ldrb	r0, [r5, #3]
c0d00d6a:	4c2d      	ldr	r4, [pc, #180]	; (c0d00e20 <io_usb_hid_receive+0x13c>)
c0d00d6c:	6821      	ldr	r1, [r4, #0]
c0d00d6e:	0a09      	lsrs	r1, r1, #8
c0d00d70:	2600      	movs	r6, #0
c0d00d72:	4288      	cmp	r0, r1
c0d00d74:	d1f1      	bne.n	c0d00d5a <io_usb_hid_receive+0x76>
c0d00d76:	7928      	ldrb	r0, [r5, #4]
c0d00d78:	6821      	ldr	r1, [r4, #0]
c0d00d7a:	b2c9      	uxtb	r1, r1
c0d00d7c:	4288      	cmp	r0, r1
c0d00d7e:	d1ec      	bne.n	c0d00d5a <io_usb_hid_receive+0x76>
c0d00d80:	4b28      	ldr	r3, [pc, #160]	; (c0d00e24 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00d82:	9802      	ldr	r0, [sp, #8]
c0d00d84:	18c0      	adds	r0, r0, r3
c0d00d86:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00d88:	6820      	ldr	r0, [r4, #0]
c0d00d8a:	2800      	cmp	r0, #0
c0d00d8c:	d00e      	beq.n	c0d00dac <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00d8e:	4629      	mov	r1, r5
c0d00d90:	4019      	ands	r1, r3
c0d00d92:	4825      	ldr	r0, [pc, #148]	; (c0d00e28 <io_usb_hid_receive+0x144>)
c0d00d94:	6802      	ldr	r2, [r0, #0]
c0d00d96:	4291      	cmp	r1, r2
c0d00d98:	461e      	mov	r6, r3
c0d00d9a:	d900      	bls.n	c0d00d9e <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00d9c:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00d9e:	462a      	mov	r2, r5
c0d00da0:	4032      	ands	r2, r6
c0d00da2:	4822      	ldr	r0, [pc, #136]	; (c0d00e2c <io_usb_hid_receive+0x148>)
c0d00da4:	6800      	ldr	r0, [r0, #0]
c0d00da6:	491d      	ldr	r1, [pc, #116]	; (c0d00e1c <io_usb_hid_receive+0x138>)
c0d00da8:	1d49      	adds	r1, r1, #5
c0d00daa:	e021      	b.n	c0d00df0 <io_usb_hid_receive+0x10c>
c0d00dac:	9301      	str	r3, [sp, #4]
c0d00dae:	491b      	ldr	r1, [pc, #108]	; (c0d00e1c <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00db0:	7988      	ldrb	r0, [r1, #6]
c0d00db2:	7949      	ldrb	r1, [r1, #5]
c0d00db4:	0209      	lsls	r1, r1, #8
c0d00db6:	4301      	orrs	r1, r0
c0d00db8:	481d      	ldr	r0, [pc, #116]	; (c0d00e30 <io_usb_hid_receive+0x14c>)
c0d00dba:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00dbc:	6801      	ldr	r1, [r0, #0]
c0d00dbe:	2241      	movs	r2, #65	; 0x41
c0d00dc0:	0092      	lsls	r2, r2, #2
c0d00dc2:	4291      	cmp	r1, r2
c0d00dc4:	d8c9      	bhi.n	c0d00d5a <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00dc6:	6801      	ldr	r1, [r0, #0]
c0d00dc8:	4817      	ldr	r0, [pc, #92]	; (c0d00e28 <io_usb_hid_receive+0x144>)
c0d00dca:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00dcc:	4917      	ldr	r1, [pc, #92]	; (c0d00e2c <io_usb_hid_receive+0x148>)
c0d00dce:	4a19      	ldr	r2, [pc, #100]	; (c0d00e34 <io_usb_hid_receive+0x150>)
c0d00dd0:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00dd2:	4919      	ldr	r1, [pc, #100]	; (c0d00e38 <io_usb_hid_receive+0x154>)
c0d00dd4:	9a02      	ldr	r2, [sp, #8]
c0d00dd6:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00dd8:	4629      	mov	r1, r5
c0d00dda:	9e01      	ldr	r6, [sp, #4]
c0d00ddc:	4031      	ands	r1, r6
c0d00dde:	6802      	ldr	r2, [r0, #0]
c0d00de0:	4291      	cmp	r1, r2
c0d00de2:	d900      	bls.n	c0d00de6 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00de4:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00de6:	462a      	mov	r2, r5
c0d00de8:	4032      	ands	r2, r6
c0d00dea:	480c      	ldr	r0, [pc, #48]	; (c0d00e1c <io_usb_hid_receive+0x138>)
c0d00dec:	1dc1      	adds	r1, r0, #7
c0d00dee:	4811      	ldr	r0, [pc, #68]	; (c0d00e34 <io_usb_hid_receive+0x150>)
c0d00df0:	f000 f82e 	bl	c0d00e50 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00df4:	4035      	ands	r5, r6
c0d00df6:	480d      	ldr	r0, [pc, #52]	; (c0d00e2c <io_usb_hid_receive+0x148>)
c0d00df8:	6801      	ldr	r1, [r0, #0]
c0d00dfa:	1949      	adds	r1, r1, r5
c0d00dfc:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00dfe:	480a      	ldr	r0, [pc, #40]	; (c0d00e28 <io_usb_hid_receive+0x144>)
c0d00e00:	6801      	ldr	r1, [r0, #0]
c0d00e02:	1b49      	subs	r1, r1, r5
c0d00e04:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00e06:	6820      	ldr	r0, [r4, #0]
c0d00e08:	1c40      	adds	r0, r0, #1
c0d00e0a:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00e0c:	4806      	ldr	r0, [pc, #24]	; (c0d00e28 <io_usb_hid_receive+0x144>)
c0d00e0e:	6801      	ldr	r1, [r0, #0]
c0d00e10:	2001      	movs	r0, #1
c0d00e12:	2602      	movs	r6, #2
c0d00e14:	2900      	cmp	r1, #0
c0d00e16:	d1a4      	bne.n	c0d00d62 <io_usb_hid_receive+0x7e>
c0d00e18:	e79f      	b.n	c0d00d5a <io_usb_hid_receive+0x76>
c0d00e1a:	46c0      	nop			; (mov r8, r8)
c0d00e1c:	20001bbc 	.word	0x20001bbc
c0d00e20:	20001bfc 	.word	0x20001bfc
c0d00e24:	0000ffff 	.word	0x0000ffff
c0d00e28:	20001c04 	.word	0x20001c04
c0d00e2c:	20001d0c 	.word	0x20001d0c
c0d00e30:	20001c00 	.word	0x20001c00
c0d00e34:	20001c08 	.word	0x20001c08
c0d00e38:	0001fff9 	.word	0x0001fff9

c0d00e3c <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00e3c:	b580      	push	{r7, lr}
c0d00e3e:	af00      	add	r7, sp, #0
c0d00e40:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00e42:	2a00      	cmp	r2, #0
c0d00e44:	d003      	beq.n	c0d00e4e <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00e46:	4611      	mov	r1, r2
c0d00e48:	461a      	mov	r2, r3
c0d00e4a:	f002 fa47 	bl	c0d032dc <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00e4e:	bd80      	pop	{r7, pc}

c0d00e50 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00e50:	b5b0      	push	{r4, r5, r7, lr}
c0d00e52:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00e54:	4288      	cmp	r0, r1
c0d00e56:	d90d      	bls.n	c0d00e74 <os_memmove+0x24>
    while(length--) {
c0d00e58:	2a00      	cmp	r2, #0
c0d00e5a:	d014      	beq.n	c0d00e86 <os_memmove+0x36>
c0d00e5c:	1e49      	subs	r1, r1, #1
c0d00e5e:	4252      	negs	r2, r2
c0d00e60:	1e40      	subs	r0, r0, #1
c0d00e62:	2300      	movs	r3, #0
c0d00e64:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00e66:	461c      	mov	r4, r3
c0d00e68:	4354      	muls	r4, r2
c0d00e6a:	5d0d      	ldrb	r5, [r1, r4]
c0d00e6c:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00e6e:	1c52      	adds	r2, r2, #1
c0d00e70:	d1f9      	bne.n	c0d00e66 <os_memmove+0x16>
c0d00e72:	e008      	b.n	c0d00e86 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00e74:	2a00      	cmp	r2, #0
c0d00e76:	d006      	beq.n	c0d00e86 <os_memmove+0x36>
c0d00e78:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00e7a:	b29c      	uxth	r4, r3
c0d00e7c:	5d0d      	ldrb	r5, [r1, r4]
c0d00e7e:	5505      	strb	r5, [r0, r4]
      l++;
c0d00e80:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00e82:	1e52      	subs	r2, r2, #1
c0d00e84:	d1f9      	bne.n	c0d00e7a <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00e86:	bdb0      	pop	{r4, r5, r7, pc}

c0d00e88 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00e88:	4801      	ldr	r0, [pc, #4]	; (c0d00e90 <io_usb_hid_init+0x8>)
c0d00e8a:	2100      	movs	r1, #0
c0d00e8c:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00e8e:	4770      	bx	lr
c0d00e90:	20001bfc 	.word	0x20001bfc

c0d00e94 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00e94:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e96:	af03      	add	r7, sp, #12
c0d00e98:	b087      	sub	sp, #28
c0d00e9a:	9301      	str	r3, [sp, #4]
c0d00e9c:	9203      	str	r2, [sp, #12]
c0d00e9e:	460e      	mov	r6, r1
c0d00ea0:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00ea2:	2e00      	cmp	r6, #0
c0d00ea4:	d042      	beq.n	c0d00f2c <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00ea6:	4d31      	ldr	r5, [pc, #196]	; (c0d00f6c <io_usb_hid_exchange+0xd8>)
c0d00ea8:	2000      	movs	r0, #0
c0d00eaa:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00eac:	4930      	ldr	r1, [pc, #192]	; (c0d00f70 <io_usb_hid_exchange+0xdc>)
c0d00eae:	4831      	ldr	r0, [pc, #196]	; (c0d00f74 <io_usb_hid_exchange+0xe0>)
c0d00eb0:	6008      	str	r0, [r1, #0]
c0d00eb2:	4c31      	ldr	r4, [pc, #196]	; (c0d00f78 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00eb4:	1d60      	adds	r0, r4, #5
c0d00eb6:	213b      	movs	r1, #59	; 0x3b
c0d00eb8:	9005      	str	r0, [sp, #20]
c0d00eba:	9102      	str	r1, [sp, #8]
c0d00ebc:	f002 fa04 	bl	c0d032c8 <__aeabi_memclr>
c0d00ec0:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00ec2:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00ec4:	6828      	ldr	r0, [r5, #0]
c0d00ec6:	0a00      	lsrs	r0, r0, #8
c0d00ec8:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00eca:	6828      	ldr	r0, [r5, #0]
c0d00ecc:	7120      	strb	r0, [r4, #4]
c0d00ece:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00ed0:	6828      	ldr	r0, [r5, #0]
c0d00ed2:	2800      	cmp	r0, #0
c0d00ed4:	9106      	str	r1, [sp, #24]
c0d00ed6:	d009      	beq.n	c0d00eec <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00ed8:	293b      	cmp	r1, #59	; 0x3b
c0d00eda:	460a      	mov	r2, r1
c0d00edc:	d300      	bcc.n	c0d00ee0 <io_usb_hid_exchange+0x4c>
c0d00ede:	9a02      	ldr	r2, [sp, #8]
c0d00ee0:	4823      	ldr	r0, [pc, #140]	; (c0d00f70 <io_usb_hid_exchange+0xdc>)
c0d00ee2:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00ee4:	6819      	ldr	r1, [r3, #0]
c0d00ee6:	9805      	ldr	r0, [sp, #20]
c0d00ee8:	461e      	mov	r6, r3
c0d00eea:	e00a      	b.n	c0d00f02 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00eec:	0a30      	lsrs	r0, r6, #8
c0d00eee:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00ef0:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00ef2:	2039      	movs	r0, #57	; 0x39
c0d00ef4:	2939      	cmp	r1, #57	; 0x39
c0d00ef6:	460a      	mov	r2, r1
c0d00ef8:	d300      	bcc.n	c0d00efc <io_usb_hid_exchange+0x68>
c0d00efa:	4602      	mov	r2, r0
c0d00efc:	4e1c      	ldr	r6, [pc, #112]	; (c0d00f70 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00efe:	6831      	ldr	r1, [r6, #0]
c0d00f00:	1de0      	adds	r0, r4, #7
c0d00f02:	9205      	str	r2, [sp, #20]
c0d00f04:	f7ff ffa4 	bl	c0d00e50 <os_memmove>
c0d00f08:	4d18      	ldr	r5, [pc, #96]	; (c0d00f6c <io_usb_hid_exchange+0xd8>)
c0d00f0a:	6830      	ldr	r0, [r6, #0]
c0d00f0c:	4631      	mov	r1, r6
c0d00f0e:	9e05      	ldr	r6, [sp, #20]
c0d00f10:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00f12:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00f14:	6828      	ldr	r0, [r5, #0]
c0d00f16:	1c40      	adds	r0, r0, #1
c0d00f18:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00f1a:	2140      	movs	r1, #64	; 0x40
c0d00f1c:	4620      	mov	r0, r4
c0d00f1e:	9a04      	ldr	r2, [sp, #16]
c0d00f20:	4790      	blx	r2
c0d00f22:	9806      	ldr	r0, [sp, #24]
c0d00f24:	1b86      	subs	r6, r0, r6
c0d00f26:	4815      	ldr	r0, [pc, #84]	; (c0d00f7c <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00f28:	4206      	tst	r6, r0
c0d00f2a:	d1c3      	bne.n	c0d00eb4 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00f2c:	480f      	ldr	r0, [pc, #60]	; (c0d00f6c <io_usb_hid_exchange+0xd8>)
c0d00f2e:	2400      	movs	r4, #0
c0d00f30:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00f32:	2080      	movs	r0, #128	; 0x80
c0d00f34:	9901      	ldr	r1, [sp, #4]
c0d00f36:	4201      	tst	r1, r0
c0d00f38:	d001      	beq.n	c0d00f3e <io_usb_hid_exchange+0xaa>
    reset();
c0d00f3a:	f000 fe3f 	bl	c0d01bbc <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00f3e:	9801      	ldr	r0, [sp, #4]
c0d00f40:	0680      	lsls	r0, r0, #26
c0d00f42:	d40f      	bmi.n	c0d00f64 <io_usb_hid_exchange+0xd0>
c0d00f44:	4c0c      	ldr	r4, [pc, #48]	; (c0d00f78 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00f46:	2140      	movs	r1, #64	; 0x40
c0d00f48:	4620      	mov	r0, r4
c0d00f4a:	9a03      	ldr	r2, [sp, #12]
c0d00f4c:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00f4e:	b2c2      	uxtb	r2, r0
c0d00f50:	2a40      	cmp	r2, #64	; 0x40
c0d00f52:	d8f8      	bhi.n	c0d00f46 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00f54:	9804      	ldr	r0, [sp, #16]
c0d00f56:	4621      	mov	r1, r4
c0d00f58:	f7ff fec4 	bl	c0d00ce4 <io_usb_hid_receive>
c0d00f5c:	2802      	cmp	r0, #2
c0d00f5e:	d1f2      	bne.n	c0d00f46 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00f60:	4807      	ldr	r0, [pc, #28]	; (c0d00f80 <io_usb_hid_exchange+0xec>)
c0d00f62:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00f64:	b2a0      	uxth	r0, r4
c0d00f66:	b007      	add	sp, #28
c0d00f68:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f6a:	46c0      	nop			; (mov r8, r8)
c0d00f6c:	20001bfc 	.word	0x20001bfc
c0d00f70:	20001d0c 	.word	0x20001d0c
c0d00f74:	20001c08 	.word	0x20001c08
c0d00f78:	20001bbc 	.word	0x20001bbc
c0d00f7c:	0000ffff 	.word	0x0000ffff
c0d00f80:	20001c00 	.word	0x20001c00

c0d00f84 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00f84:	b580      	push	{r7, lr}
c0d00f86:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00f88:	f000 ffbc 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d00f8c:	2800      	cmp	r0, #0
c0d00f8e:	d10b      	bne.n	c0d00fa8 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00f90:	4806      	ldr	r0, [pc, #24]	; (c0d00fac <io_seproxyhal_general_status+0x28>)
c0d00f92:	2160      	movs	r1, #96	; 0x60
c0d00f94:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00f96:	2100      	movs	r1, #0
c0d00f98:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00f9a:	2202      	movs	r2, #2
c0d00f9c:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00f9e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00fa0:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00fa2:	2105      	movs	r1, #5
c0d00fa4:	f000 ff90 	bl	c0d01ec8 <io_seproxyhal_spi_send>
}
c0d00fa8:	bd80      	pop	{r7, pc}
c0d00faa:	46c0      	nop			; (mov r8, r8)
c0d00fac:	20001a18 	.word	0x20001a18

c0d00fb0 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00fb0:	b5d0      	push	{r4, r6, r7, lr}
c0d00fb2:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00fb4:	4815      	ldr	r0, [pc, #84]	; (c0d0100c <io_seproxyhal_handle_usb_event+0x5c>)
c0d00fb6:	78c0      	ldrb	r0, [r0, #3]
c0d00fb8:	1e40      	subs	r0, r0, #1
c0d00fba:	2807      	cmp	r0, #7
c0d00fbc:	d824      	bhi.n	c0d01008 <io_seproxyhal_handle_usb_event+0x58>
c0d00fbe:	46c0      	nop			; (mov r8, r8)
c0d00fc0:	4478      	add	r0, pc
c0d00fc2:	7900      	ldrb	r0, [r0, #4]
c0d00fc4:	0040      	lsls	r0, r0, #1
c0d00fc6:	4487      	add	pc, r0
c0d00fc8:	141f1803 	.word	0x141f1803
c0d00fcc:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00fd0:	4c0f      	ldr	r4, [pc, #60]	; (c0d01010 <io_seproxyhal_handle_usb_event+0x60>)
c0d00fd2:	2101      	movs	r1, #1
c0d00fd4:	4620      	mov	r0, r4
c0d00fd6:	f001 fbd5 	bl	c0d02784 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00fda:	4620      	mov	r0, r4
c0d00fdc:	f001 fbba 	bl	c0d02754 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00fe0:	480c      	ldr	r0, [pc, #48]	; (c0d01014 <io_seproxyhal_handle_usb_event+0x64>)
c0d00fe2:	7800      	ldrb	r0, [r0, #0]
c0d00fe4:	2801      	cmp	r0, #1
c0d00fe6:	d10f      	bne.n	c0d01008 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00fe8:	480b      	ldr	r0, [pc, #44]	; (c0d01018 <io_seproxyhal_handle_usb_event+0x68>)
c0d00fea:	6800      	ldr	r0, [r0, #0]
c0d00fec:	2110      	movs	r1, #16
c0d00fee:	f002 fa0d 	bl	c0d0340c <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00ff2:	4807      	ldr	r0, [pc, #28]	; (c0d01010 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ff4:	f001 fbc9 	bl	c0d0278a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00ff8:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00ffa:	4805      	ldr	r0, [pc, #20]	; (c0d01010 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ffc:	f001 fbc9 	bl	c0d02792 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01000:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d01002:	4803      	ldr	r0, [pc, #12]	; (c0d01010 <io_seproxyhal_handle_usb_event+0x60>)
c0d01004:	f001 fbc3 	bl	c0d0278e <USBD_LL_Resume>
      break;
  }
}
c0d01008:	bdd0      	pop	{r4, r6, r7, pc}
c0d0100a:	46c0      	nop			; (mov r8, r8)
c0d0100c:	20001a18 	.word	0x20001a18
c0d01010:	20001d34 	.word	0x20001d34
c0d01014:	20001d10 	.word	0x20001d10
c0d01018:	20001bb8 	.word	0x20001bb8

c0d0101c <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d0101c:	217f      	movs	r1, #127	; 0x7f
c0d0101e:	4001      	ands	r1, r0
c0d01020:	4801      	ldr	r0, [pc, #4]	; (c0d01028 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d01022:	5c40      	ldrb	r0, [r0, r1]
c0d01024:	4770      	bx	lr
c0d01026:	46c0      	nop			; (mov r8, r8)
c0d01028:	20001d11 	.word	0x20001d11

c0d0102c <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d0102c:	b580      	push	{r7, lr}
c0d0102e:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01030:	480f      	ldr	r0, [pc, #60]	; (c0d01070 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d01032:	7901      	ldrb	r1, [r0, #4]
c0d01034:	2904      	cmp	r1, #4
c0d01036:	d008      	beq.n	c0d0104a <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d01038:	2902      	cmp	r1, #2
c0d0103a:	d011      	beq.n	c0d01060 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d0103c:	2901      	cmp	r1, #1
c0d0103e:	d10e      	bne.n	c0d0105e <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01040:	1d81      	adds	r1, r0, #6
c0d01042:	480d      	ldr	r0, [pc, #52]	; (c0d01078 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01044:	f001 faaa 	bl	c0d0259c <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01048:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d0104a:	78c2      	ldrb	r2, [r0, #3]
c0d0104c:	217f      	movs	r1, #127	; 0x7f
c0d0104e:	4011      	ands	r1, r2
c0d01050:	7942      	ldrb	r2, [r0, #5]
c0d01052:	4b08      	ldr	r3, [pc, #32]	; (c0d01074 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01054:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01056:	1d82      	adds	r2, r0, #6
c0d01058:	4807      	ldr	r0, [pc, #28]	; (c0d01078 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0105a:	f001 fad1 	bl	c0d02600 <USBD_LL_DataOutStage>
      break;
  }
}
c0d0105e:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01060:	78c2      	ldrb	r2, [r0, #3]
c0d01062:	217f      	movs	r1, #127	; 0x7f
c0d01064:	4011      	ands	r1, r2
c0d01066:	1d82      	adds	r2, r0, #6
c0d01068:	4803      	ldr	r0, [pc, #12]	; (c0d01078 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0106a:	f001 fb0f 	bl	c0d0268c <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0106e:	bd80      	pop	{r7, pc}
c0d01070:	20001a18 	.word	0x20001a18
c0d01074:	20001d11 	.word	0x20001d11
c0d01078:	20001d34 	.word	0x20001d34

c0d0107c <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d0107c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0107e:	af03      	add	r7, sp, #12
c0d01080:	b083      	sub	sp, #12
c0d01082:	9201      	str	r2, [sp, #4]
c0d01084:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01086:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01088:	2b00      	cmp	r3, #0
c0d0108a:	d100      	bne.n	c0d0108e <io_usb_send_ep+0x12>
c0d0108c:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0108e:	9801      	ldr	r0, [sp, #4]
c0d01090:	28ff      	cmp	r0, #255	; 0xff
c0d01092:	d843      	bhi.n	c0d0111c <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01094:	4e25      	ldr	r6, [pc, #148]	; (c0d0112c <io_usb_send_ep+0xb0>)
c0d01096:	2050      	movs	r0, #80	; 0x50
c0d01098:	7030      	strb	r0, [r6, #0]
c0d0109a:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d0109c:	1ce0      	adds	r0, r4, #3
c0d0109e:	9100      	str	r1, [sp, #0]
c0d010a0:	0a01      	lsrs	r1, r0, #8
c0d010a2:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d010a4:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d010a6:	2080      	movs	r0, #128	; 0x80
c0d010a8:	4302      	orrs	r2, r0
c0d010aa:	9202      	str	r2, [sp, #8]
c0d010ac:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d010ae:	2020      	movs	r0, #32
c0d010b0:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d010b2:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d010b4:	2106      	movs	r1, #6
c0d010b6:	4630      	mov	r0, r6
c0d010b8:	f000 ff06 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d010bc:	9800      	ldr	r0, [sp, #0]
c0d010be:	4621      	mov	r1, r4
c0d010c0:	f000 ff02 	bl	c0d01ec8 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d010c4:	2d00      	cmp	r5, #0
c0d010c6:	d10d      	bne.n	c0d010e4 <io_usb_send_ep+0x68>
c0d010c8:	e028      	b.n	c0d0111c <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d010ca:	2d00      	cmp	r5, #0
c0d010cc:	d002      	beq.n	c0d010d4 <io_usb_send_ep+0x58>
c0d010ce:	1e6c      	subs	r4, r5, #1
c0d010d0:	2d01      	cmp	r5, #1
c0d010d2:	d025      	beq.n	c0d01120 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d010d4:	2915      	cmp	r1, #21
c0d010d6:	d102      	bne.n	c0d010de <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d010d8:	79b0      	ldrb	r0, [r6, #6]
c0d010da:	0700      	lsls	r0, r0, #28
c0d010dc:	d520      	bpl.n	c0d01120 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d010de:	f000 f829 	bl	c0d01134 <io_seproxyhal_handle_event>
c0d010e2:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d010e4:	f000 ff0e 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d010e8:	2800      	cmp	r0, #0
c0d010ea:	d101      	bne.n	c0d010f0 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d010ec:	f7ff ff4a 	bl	c0d00f84 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d010f0:	2180      	movs	r1, #128	; 0x80
c0d010f2:	2400      	movs	r4, #0
c0d010f4:	4630      	mov	r0, r6
c0d010f6:	4622      	mov	r2, r4
c0d010f8:	f000 ff20 	bl	c0d01f3c <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d010fc:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d010fe:	2806      	cmp	r0, #6
c0d01100:	d1e3      	bne.n	c0d010ca <io_usb_send_ep+0x4e>
c0d01102:	2910      	cmp	r1, #16
c0d01104:	d1e1      	bne.n	c0d010ca <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d01106:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01108:	9a02      	ldr	r2, [sp, #8]
c0d0110a:	4290      	cmp	r0, r2
c0d0110c:	d1dd      	bne.n	c0d010ca <io_usb_send_ep+0x4e>
c0d0110e:	7930      	ldrb	r0, [r6, #4]
c0d01110:	2802      	cmp	r0, #2
c0d01112:	d1da      	bne.n	c0d010ca <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d01114:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01116:	9a01      	ldr	r2, [sp, #4]
c0d01118:	4290      	cmp	r0, r2
c0d0111a:	d1d6      	bne.n	c0d010ca <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d0111c:	b003      	add	sp, #12
c0d0111e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01120:	4803      	ldr	r0, [pc, #12]	; (c0d01130 <io_usb_send_ep+0xb4>)
c0d01122:	6800      	ldr	r0, [r0, #0]
c0d01124:	2110      	movs	r1, #16
c0d01126:	f002 f971 	bl	c0d0340c <longjmp>
c0d0112a:	46c0      	nop			; (mov r8, r8)
c0d0112c:	20001a18 	.word	0x20001a18
c0d01130:	20001bb8 	.word	0x20001bb8

c0d01134 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d01134:	b580      	push	{r7, lr}
c0d01136:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01138:	480d      	ldr	r0, [pc, #52]	; (c0d01170 <io_seproxyhal_handle_event+0x3c>)
c0d0113a:	7882      	ldrb	r2, [r0, #2]
c0d0113c:	7841      	ldrb	r1, [r0, #1]
c0d0113e:	0209      	lsls	r1, r1, #8
c0d01140:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01142:	7800      	ldrb	r0, [r0, #0]
c0d01144:	2810      	cmp	r0, #16
c0d01146:	d008      	beq.n	c0d0115a <io_seproxyhal_handle_event+0x26>
c0d01148:	280f      	cmp	r0, #15
c0d0114a:	d10d      	bne.n	c0d01168 <io_seproxyhal_handle_event+0x34>
c0d0114c:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d0114e:	2904      	cmp	r1, #4
c0d01150:	d10d      	bne.n	c0d0116e <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01152:	f7ff ff2d 	bl	c0d00fb0 <io_seproxyhal_handle_usb_event>
c0d01156:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01158:	bd80      	pop	{r7, pc}
c0d0115a:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d0115c:	2906      	cmp	r1, #6
c0d0115e:	d306      	bcc.n	c0d0116e <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01160:	f7ff ff64 	bl	c0d0102c <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01164:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01166:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01168:	2002      	movs	r0, #2
c0d0116a:	f7ff faf5 	bl	c0d00758 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0116e:	bd80      	pop	{r7, pc}
c0d01170:	20001a18 	.word	0x20001a18

c0d01174 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01174:	b580      	push	{r7, lr}
c0d01176:	af00      	add	r7, sp, #0
c0d01178:	460a      	mov	r2, r1
c0d0117a:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d0117c:	2082      	movs	r0, #130	; 0x82
c0d0117e:	2314      	movs	r3, #20
c0d01180:	f7ff ff7c 	bl	c0d0107c <io_usb_send_ep>
}
c0d01184:	bd80      	pop	{r7, pc}
	...

c0d01188 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01188:	b5d0      	push	{r4, r6, r7, lr}
c0d0118a:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0118c:	2007      	movs	r0, #7
c0d0118e:	f000 fcf7 	bl	c0d01b80 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d01192:	480a      	ldr	r0, [pc, #40]	; (c0d011bc <io_seproxyhal_init+0x34>)
c0d01194:	2400      	movs	r4, #0
c0d01196:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01198:	4809      	ldr	r0, [pc, #36]	; (c0d011c0 <io_seproxyhal_init+0x38>)
c0d0119a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d0119c:	4809      	ldr	r0, [pc, #36]	; (c0d011c4 <io_seproxyhal_init+0x3c>)
c0d0119e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d011a0:	4809      	ldr	r0, [pc, #36]	; (c0d011c8 <io_seproxyhal_init+0x40>)
c0d011a2:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d011a4:	4809      	ldr	r0, [pc, #36]	; (c0d011cc <io_seproxyhal_init+0x44>)
c0d011a6:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d011a8:	f7ff fe6e 	bl	c0d00e88 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d011ac:	4808      	ldr	r0, [pc, #32]	; (c0d011d0 <io_seproxyhal_init+0x48>)
c0d011ae:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d011b0:	4808      	ldr	r0, [pc, #32]	; (c0d011d4 <io_seproxyhal_init+0x4c>)
c0d011b2:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d011b4:	4808      	ldr	r0, [pc, #32]	; (c0d011d8 <io_seproxyhal_init+0x50>)
c0d011b6:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d011b8:	bdd0      	pop	{r4, r6, r7, pc}
c0d011ba:	46c0      	nop			; (mov r8, r8)
c0d011bc:	20001d18 	.word	0x20001d18
c0d011c0:	20001d1a 	.word	0x20001d1a
c0d011c4:	20001d1c 	.word	0x20001d1c
c0d011c8:	20001d1e 	.word	0x20001d1e
c0d011cc:	20001d10 	.word	0x20001d10
c0d011d0:	20001d20 	.word	0x20001d20
c0d011d4:	20001d24 	.word	0x20001d24
c0d011d8:	20001d28 	.word	0x20001d28

c0d011dc <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d011dc:	4801      	ldr	r0, [pc, #4]	; (c0d011e4 <io_seproxyhal_init_ux+0x8>)
c0d011de:	2100      	movs	r1, #0
c0d011e0:	6001      	str	r1, [r0, #0]

}
c0d011e2:	4770      	bx	lr
c0d011e4:	20001d20 	.word	0x20001d20

c0d011e8 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d011e8:	b5b0      	push	{r4, r5, r7, lr}
c0d011ea:	af02      	add	r7, sp, #8
c0d011ec:	460d      	mov	r5, r1
c0d011ee:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d011f0:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d011f2:	2800      	cmp	r0, #0
c0d011f4:	d00c      	beq.n	c0d01210 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d011f6:	f000 fcab 	bl	c0d01b50 <pic>
c0d011fa:	4601      	mov	r1, r0
c0d011fc:	4620      	mov	r0, r4
c0d011fe:	4788      	blx	r1
c0d01200:	f000 fca6 	bl	c0d01b50 <pic>
c0d01204:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d01206:	2800      	cmp	r0, #0
c0d01208:	d010      	beq.n	c0d0122c <io_seproxyhal_touch_out+0x44>
c0d0120a:	2801      	cmp	r0, #1
c0d0120c:	d000      	beq.n	c0d01210 <io_seproxyhal_touch_out+0x28>
c0d0120e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01210:	2d00      	cmp	r5, #0
c0d01212:	d007      	beq.n	c0d01224 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d01214:	4620      	mov	r0, r4
c0d01216:	47a8      	blx	r5
c0d01218:	2100      	movs	r1, #0
    if (!el) {
c0d0121a:	2800      	cmp	r0, #0
c0d0121c:	d006      	beq.n	c0d0122c <io_seproxyhal_touch_out+0x44>
c0d0121e:	2801      	cmp	r0, #1
c0d01220:	d000      	beq.n	c0d01224 <io_seproxyhal_touch_out+0x3c>
c0d01222:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01224:	4620      	mov	r0, r4
c0d01226:	f7ff fa91 	bl	c0d0074c <io_seproxyhal_display>
c0d0122a:	2101      	movs	r1, #1
  return 1;
}
c0d0122c:	4608      	mov	r0, r1
c0d0122e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01230 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01230:	b5b0      	push	{r4, r5, r7, lr}
c0d01232:	af02      	add	r7, sp, #8
c0d01234:	b08e      	sub	sp, #56	; 0x38
c0d01236:	460c      	mov	r4, r1
c0d01238:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0123a:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d0123c:	2800      	cmp	r0, #0
c0d0123e:	d00c      	beq.n	c0d0125a <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01240:	f000 fc86 	bl	c0d01b50 <pic>
c0d01244:	4601      	mov	r1, r0
c0d01246:	4628      	mov	r0, r5
c0d01248:	4788      	blx	r1
c0d0124a:	f000 fc81 	bl	c0d01b50 <pic>
c0d0124e:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01250:	2800      	cmp	r0, #0
c0d01252:	d016      	beq.n	c0d01282 <io_seproxyhal_touch_over+0x52>
c0d01254:	2801      	cmp	r0, #1
c0d01256:	d000      	beq.n	c0d0125a <io_seproxyhal_touch_over+0x2a>
c0d01258:	4605      	mov	r5, r0
c0d0125a:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d0125c:	2238      	movs	r2, #56	; 0x38
c0d0125e:	4629      	mov	r1, r5
c0d01260:	f7ff fdf6 	bl	c0d00e50 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01264:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01266:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01268:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0126a:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d0126c:	2c00      	cmp	r4, #0
c0d0126e:	d004      	beq.n	c0d0127a <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01270:	4628      	mov	r0, r5
c0d01272:	47a0      	blx	r4
c0d01274:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01276:	2800      	cmp	r0, #0
c0d01278:	d003      	beq.n	c0d01282 <io_seproxyhal_touch_over+0x52>
c0d0127a:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d0127c:	f7ff fa66 	bl	c0d0074c <io_seproxyhal_display>
c0d01280:	2101      	movs	r1, #1
  return 1;
}
c0d01282:	4608      	mov	r0, r1
c0d01284:	b00e      	add	sp, #56	; 0x38
c0d01286:	bdb0      	pop	{r4, r5, r7, pc}

c0d01288 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01288:	b5b0      	push	{r4, r5, r7, lr}
c0d0128a:	af02      	add	r7, sp, #8
c0d0128c:	460d      	mov	r5, r1
c0d0128e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01290:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01292:	2800      	cmp	r0, #0
c0d01294:	d00c      	beq.n	c0d012b0 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01296:	f000 fc5b 	bl	c0d01b50 <pic>
c0d0129a:	4601      	mov	r1, r0
c0d0129c:	4620      	mov	r0, r4
c0d0129e:	4788      	blx	r1
c0d012a0:	f000 fc56 	bl	c0d01b50 <pic>
c0d012a4:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d012a6:	2800      	cmp	r0, #0
c0d012a8:	d010      	beq.n	c0d012cc <io_seproxyhal_touch_tap+0x44>
c0d012aa:	2801      	cmp	r0, #1
c0d012ac:	d000      	beq.n	c0d012b0 <io_seproxyhal_touch_tap+0x28>
c0d012ae:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d012b0:	2d00      	cmp	r5, #0
c0d012b2:	d007      	beq.n	c0d012c4 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d012b4:	4620      	mov	r0, r4
c0d012b6:	47a8      	blx	r5
c0d012b8:	2100      	movs	r1, #0
    if (!el) {
c0d012ba:	2800      	cmp	r0, #0
c0d012bc:	d006      	beq.n	c0d012cc <io_seproxyhal_touch_tap+0x44>
c0d012be:	2801      	cmp	r0, #1
c0d012c0:	d000      	beq.n	c0d012c4 <io_seproxyhal_touch_tap+0x3c>
c0d012c2:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d012c4:	4620      	mov	r0, r4
c0d012c6:	f7ff fa41 	bl	c0d0074c <io_seproxyhal_display>
c0d012ca:	2101      	movs	r1, #1
  return 1;
}
c0d012cc:	4608      	mov	r0, r1
c0d012ce:	bdb0      	pop	{r4, r5, r7, pc}

c0d012d0 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d012d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012d2:	af03      	add	r7, sp, #12
c0d012d4:	b087      	sub	sp, #28
c0d012d6:	9302      	str	r3, [sp, #8]
c0d012d8:	9203      	str	r2, [sp, #12]
c0d012da:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d012dc:	2900      	cmp	r1, #0
c0d012de:	d076      	beq.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
c0d012e0:	9004      	str	r0, [sp, #16]
c0d012e2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d012e4:	9001      	str	r0, [sp, #4]
c0d012e6:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d012e8:	9000      	str	r0, [sp, #0]
c0d012ea:	2600      	movs	r6, #0
c0d012ec:	9606      	str	r6, [sp, #24]
c0d012ee:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d012f0:	f000 fe08 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d012f4:	2800      	cmp	r0, #0
c0d012f6:	d155      	bne.n	c0d013a4 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d012f8:	2038      	movs	r0, #56	; 0x38
c0d012fa:	4370      	muls	r0, r6
c0d012fc:	9d04      	ldr	r5, [sp, #16]
c0d012fe:	182e      	adds	r6, r5, r0
c0d01300:	4b36      	ldr	r3, [pc, #216]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01302:	681a      	ldr	r2, [r3, #0]
c0d01304:	2101      	movs	r1, #1
c0d01306:	4296      	cmp	r6, r2
c0d01308:	d000      	beq.n	c0d0130c <io_seproxyhal_touch_element_callback+0x3c>
c0d0130a:	9906      	ldr	r1, [sp, #24]
c0d0130c:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0130e:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01310:	2800      	cmp	r0, #0
c0d01312:	da41      	bge.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
c0d01314:	2020      	movs	r0, #32
c0d01316:	5c35      	ldrb	r5, [r6, r0]
c0d01318:	2102      	movs	r1, #2
c0d0131a:	5e71      	ldrsh	r1, [r6, r1]
c0d0131c:	1b4a      	subs	r2, r1, r5
c0d0131e:	9803      	ldr	r0, [sp, #12]
c0d01320:	4282      	cmp	r2, r0
c0d01322:	dc39      	bgt.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
c0d01324:	1869      	adds	r1, r5, r1
c0d01326:	88f2      	ldrh	r2, [r6, #6]
c0d01328:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d0132a:	9803      	ldr	r0, [sp, #12]
c0d0132c:	4288      	cmp	r0, r1
c0d0132e:	da33      	bge.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
c0d01330:	2104      	movs	r1, #4
c0d01332:	5e70      	ldrsh	r0, [r6, r1]
c0d01334:	1b42      	subs	r2, r0, r5
c0d01336:	9902      	ldr	r1, [sp, #8]
c0d01338:	428a      	cmp	r2, r1
c0d0133a:	dc2d      	bgt.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
c0d0133c:	1940      	adds	r0, r0, r5
c0d0133e:	8931      	ldrh	r1, [r6, #8]
c0d01340:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01342:	9902      	ldr	r1, [sp, #8]
c0d01344:	4281      	cmp	r1, r0
c0d01346:	da27      	bge.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01348:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d0134a:	4286      	cmp	r6, r0
c0d0134c:	d010      	beq.n	c0d01370 <io_seproxyhal_touch_element_callback+0xa0>
c0d0134e:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01350:	2800      	cmp	r0, #0
c0d01352:	d00d      	beq.n	c0d01370 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01354:	9801      	ldr	r0, [sp, #4]
c0d01356:	2800      	cmp	r0, #0
c0d01358:	d005      	beq.n	c0d01366 <io_seproxyhal_touch_element_callback+0x96>
c0d0135a:	4630      	mov	r0, r6
c0d0135c:	9901      	ldr	r1, [sp, #4]
c0d0135e:	4788      	blx	r1
c0d01360:	4b1e      	ldr	r3, [pc, #120]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01362:	2800      	cmp	r0, #0
c0d01364:	d018      	beq.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01366:	6818      	ldr	r0, [r3, #0]
c0d01368:	9901      	ldr	r1, [sp, #4]
c0d0136a:	f7ff ff3d 	bl	c0d011e8 <io_seproxyhal_touch_out>
c0d0136e:	e008      	b.n	c0d01382 <io_seproxyhal_touch_element_callback+0xb2>
c0d01370:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01372:	2801      	cmp	r0, #1
c0d01374:	d009      	beq.n	c0d0138a <io_seproxyhal_touch_element_callback+0xba>
c0d01376:	2802      	cmp	r0, #2
c0d01378:	d10e      	bne.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0137a:	4630      	mov	r0, r6
c0d0137c:	9901      	ldr	r1, [sp, #4]
c0d0137e:	f7ff ff83 	bl	c0d01288 <io_seproxyhal_touch_tap>
c0d01382:	4b16      	ldr	r3, [pc, #88]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01384:	2800      	cmp	r0, #0
c0d01386:	d007      	beq.n	c0d01398 <io_seproxyhal_touch_element_callback+0xc8>
c0d01388:	e023      	b.n	c0d013d2 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0138a:	4630      	mov	r0, r6
c0d0138c:	9901      	ldr	r1, [sp, #4]
c0d0138e:	f7ff ff4f 	bl	c0d01230 <io_seproxyhal_touch_over>
c0d01392:	4b12      	ldr	r3, [pc, #72]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d01394:	2800      	cmp	r0, #0
c0d01396:	d11f      	bne.n	c0d013d8 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01398:	1c64      	adds	r4, r4, #1
c0d0139a:	b2e6      	uxtb	r6, r4
c0d0139c:	9805      	ldr	r0, [sp, #20]
c0d0139e:	4286      	cmp	r6, r0
c0d013a0:	d3a6      	bcc.n	c0d012f0 <io_seproxyhal_touch_element_callback+0x20>
c0d013a2:	e000      	b.n	c0d013a6 <io_seproxyhal_touch_element_callback+0xd6>
c0d013a4:	4b0d      	ldr	r3, [pc, #52]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d013a6:	9806      	ldr	r0, [sp, #24]
c0d013a8:	0600      	lsls	r0, r0, #24
c0d013aa:	d010      	beq.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
c0d013ac:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d013ae:	2800      	cmp	r0, #0
c0d013b0:	d00d      	beq.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d013b2:	f000 fda7 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d013b6:	4909      	ldr	r1, [pc, #36]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d013b8:	2800      	cmp	r0, #0
c0d013ba:	d108      	bne.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d013bc:	6808      	ldr	r0, [r1, #0]
c0d013be:	9901      	ldr	r1, [sp, #4]
c0d013c0:	f7ff ff12 	bl	c0d011e8 <io_seproxyhal_touch_out>
c0d013c4:	4d05      	ldr	r5, [pc, #20]	; (c0d013dc <io_seproxyhal_touch_element_callback+0x10c>)
c0d013c6:	2800      	cmp	r0, #0
c0d013c8:	d001      	beq.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d013ca:	2000      	movs	r0, #0
c0d013cc:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d013ce:	b007      	add	sp, #28
c0d013d0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013d2:	2000      	movs	r0, #0
c0d013d4:	6018      	str	r0, [r3, #0]
c0d013d6:	e7fa      	b.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d013d8:	601e      	str	r6, [r3, #0]
c0d013da:	e7f8      	b.n	c0d013ce <io_seproxyhal_touch_element_callback+0xfe>
c0d013dc:	20001d20 	.word	0x20001d20

c0d013e0 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d013e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013e2:	af03      	add	r7, sp, #12
c0d013e4:	b08b      	sub	sp, #44	; 0x2c
c0d013e6:	460c      	mov	r4, r1
c0d013e8:	4601      	mov	r1, r0
c0d013ea:	ad04      	add	r5, sp, #16
c0d013ec:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d013ee:	4628      	mov	r0, r5
c0d013f0:	9203      	str	r2, [sp, #12]
c0d013f2:	f7ff fd2d 	bl	c0d00e50 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d013f6:	6821      	ldr	r1, [r4, #0]
c0d013f8:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d013fa:	6862      	ldr	r2, [r4, #4]
c0d013fc:	9502      	str	r5, [sp, #8]
c0d013fe:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01400:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01402:	4e1a      	ldr	r6, [pc, #104]	; (c0d0146c <io_seproxyhal_display_icon+0x8c>)
c0d01404:	2365      	movs	r3, #101	; 0x65
c0d01406:	4635      	mov	r5, r6
c0d01408:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d0140a:	b292      	uxth	r2, r2
c0d0140c:	4342      	muls	r2, r0
c0d0140e:	b28b      	uxth	r3, r1
c0d01410:	4353      	muls	r3, r2
c0d01412:	08d9      	lsrs	r1, r3, #3
c0d01414:	1c4e      	adds	r6, r1, #1
c0d01416:	2207      	movs	r2, #7
c0d01418:	4213      	tst	r3, r2
c0d0141a:	d100      	bne.n	c0d0141e <io_seproxyhal_display_icon+0x3e>
c0d0141c:	460e      	mov	r6, r1
c0d0141e:	4631      	mov	r1, r6
c0d01420:	9101      	str	r1, [sp, #4]
c0d01422:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01424:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01426:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01428:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0142a:	0a01      	lsrs	r1, r0, #8
c0d0142c:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d0142e:	70a8      	strb	r0, [r5, #2]
c0d01430:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01432:	4628      	mov	r0, r5
c0d01434:	f000 fd48 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01438:	9802      	ldr	r0, [sp, #8]
c0d0143a:	9903      	ldr	r1, [sp, #12]
c0d0143c:	f000 fd44 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01440:	68a0      	ldr	r0, [r4, #8]
c0d01442:	7028      	strb	r0, [r5, #0]
c0d01444:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01446:	4628      	mov	r0, r5
c0d01448:	f000 fd3e 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0144c:	68e0      	ldr	r0, [r4, #12]
c0d0144e:	f000 fb7f 	bl	c0d01b50 <pic>
c0d01452:	b2b1      	uxth	r1, r6
c0d01454:	f000 fd38 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01458:	9801      	ldr	r0, [sp, #4]
c0d0145a:	b285      	uxth	r5, r0
c0d0145c:	6920      	ldr	r0, [r4, #16]
c0d0145e:	f000 fb77 	bl	c0d01b50 <pic>
c0d01462:	4629      	mov	r1, r5
c0d01464:	f000 fd30 	bl	c0d01ec8 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01468:	b00b      	add	sp, #44	; 0x2c
c0d0146a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0146c:	20001a18 	.word	0x20001a18

c0d01470 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01470:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01472:	af03      	add	r7, sp, #12
c0d01474:	b081      	sub	sp, #4
c0d01476:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01478:	7820      	ldrb	r0, [r4, #0]
c0d0147a:	267f      	movs	r6, #127	; 0x7f
c0d0147c:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d0147e:	2e00      	cmp	r6, #0
c0d01480:	d02e      	beq.n	c0d014e0 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01482:	69e0      	ldr	r0, [r4, #28]
c0d01484:	2800      	cmp	r0, #0
c0d01486:	d01d      	beq.n	c0d014c4 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01488:	f000 fb62 	bl	c0d01b50 <pic>
c0d0148c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0148e:	2e05      	cmp	r6, #5
c0d01490:	d102      	bne.n	c0d01498 <io_seproxyhal_display_default+0x28>
c0d01492:	7ea0      	ldrb	r0, [r4, #26]
c0d01494:	2800      	cmp	r0, #0
c0d01496:	d025      	beq.n	c0d014e4 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01498:	4628      	mov	r0, r5
c0d0149a:	f001 ffc5 	bl	c0d03428 <strlen>
c0d0149e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d014a0:	4813      	ldr	r0, [pc, #76]	; (c0d014f0 <io_seproxyhal_display_default+0x80>)
c0d014a2:	2165      	movs	r1, #101	; 0x65
c0d014a4:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d014a6:	4631      	mov	r1, r6
c0d014a8:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d014aa:	0a0a      	lsrs	r2, r1, #8
c0d014ac:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d014ae:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d014b0:	2103      	movs	r1, #3
c0d014b2:	f000 fd09 	bl	c0d01ec8 <io_seproxyhal_spi_send>
c0d014b6:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d014b8:	4620      	mov	r0, r4
c0d014ba:	f000 fd05 	bl	c0d01ec8 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d014be:	b2b1      	uxth	r1, r6
c0d014c0:	4628      	mov	r0, r5
c0d014c2:	e00b      	b.n	c0d014dc <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d014c4:	480a      	ldr	r0, [pc, #40]	; (c0d014f0 <io_seproxyhal_display_default+0x80>)
c0d014c6:	2165      	movs	r1, #101	; 0x65
c0d014c8:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d014ca:	2100      	movs	r1, #0
c0d014cc:	7041      	strb	r1, [r0, #1]
c0d014ce:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d014d0:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d014d2:	2103      	movs	r1, #3
c0d014d4:	f000 fcf8 	bl	c0d01ec8 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d014d8:	4620      	mov	r0, r4
c0d014da:	4629      	mov	r1, r5
c0d014dc:	f000 fcf4 	bl	c0d01ec8 <io_seproxyhal_spi_send>
    }
  }
}
c0d014e0:	b001      	add	sp, #4
c0d014e2:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d014e4:	4620      	mov	r0, r4
c0d014e6:	4629      	mov	r1, r5
c0d014e8:	f7ff ff7a 	bl	c0d013e0 <io_seproxyhal_display_icon>
c0d014ec:	e7f8      	b.n	c0d014e0 <io_seproxyhal_display_default+0x70>
c0d014ee:	46c0      	nop			; (mov r8, r8)
c0d014f0:	20001a18 	.word	0x20001a18

c0d014f4 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d014f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014f6:	af03      	add	r7, sp, #12
c0d014f8:	b081      	sub	sp, #4
c0d014fa:	4604      	mov	r4, r0
  if (button_callback) {
c0d014fc:	2c00      	cmp	r4, #0
c0d014fe:	d02e      	beq.n	c0d0155e <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01500:	4818      	ldr	r0, [pc, #96]	; (c0d01564 <io_seproxyhal_button_push+0x70>)
c0d01502:	6802      	ldr	r2, [r0, #0]
c0d01504:	428a      	cmp	r2, r1
c0d01506:	d103      	bne.n	c0d01510 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01508:	4a17      	ldr	r2, [pc, #92]	; (c0d01568 <io_seproxyhal_button_push+0x74>)
c0d0150a:	6813      	ldr	r3, [r2, #0]
c0d0150c:	1c5b      	adds	r3, r3, #1
c0d0150e:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01510:	6806      	ldr	r6, [r0, #0]
c0d01512:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01514:	4a14      	ldr	r2, [pc, #80]	; (c0d01568 <io_seproxyhal_button_push+0x74>)
c0d01516:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01518:	2900      	cmp	r1, #0
c0d0151a:	d001      	beq.n	c0d01520 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d0151c:	6006      	str	r6, [r0, #0]
c0d0151e:	e005      	b.n	c0d0152c <io_seproxyhal_button_push+0x38>
c0d01520:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01522:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01524:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01526:	2301      	movs	r3, #1
c0d01528:	07db      	lsls	r3, r3, #31
c0d0152a:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d0152c:	6800      	ldr	r0, [r0, #0]
c0d0152e:	4288      	cmp	r0, r1
c0d01530:	d001      	beq.n	c0d01536 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01532:	2000      	movs	r0, #0
c0d01534:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01536:	2d08      	cmp	r5, #8
c0d01538:	d30e      	bcc.n	c0d01558 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0153a:	2103      	movs	r1, #3
c0d0153c:	4628      	mov	r0, r5
c0d0153e:	f001 fda7 	bl	c0d03090 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01542:	2001      	movs	r0, #1
c0d01544:	0780      	lsls	r0, r0, #30
c0d01546:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01548:	2900      	cmp	r1, #0
c0d0154a:	4601      	mov	r1, r0
c0d0154c:	d000      	beq.n	c0d01550 <io_seproxyhal_button_push+0x5c>
c0d0154e:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01550:	2900      	cmp	r1, #0
c0d01552:	db02      	blt.n	c0d0155a <io_seproxyhal_button_push+0x66>
c0d01554:	4608      	mov	r0, r1
c0d01556:	e000      	b.n	c0d0155a <io_seproxyhal_button_push+0x66>
c0d01558:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0155a:	4629      	mov	r1, r5
c0d0155c:	47a0      	blx	r4
  }
}
c0d0155e:	b001      	add	sp, #4
c0d01560:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01562:	46c0      	nop			; (mov r8, r8)
c0d01564:	20001d24 	.word	0x20001d24
c0d01568:	20001d28 	.word	0x20001d28

c0d0156c <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d0156c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0156e:	af03      	add	r7, sp, #12
c0d01570:	b081      	sub	sp, #4
c0d01572:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01574:	200f      	movs	r0, #15
c0d01576:	4204      	tst	r4, r0
c0d01578:	d006      	beq.n	c0d01588 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d0157a:	4620      	mov	r0, r4
c0d0157c:	f7ff f8be 	bl	c0d006fc <io_exchange_al>
c0d01580:	4605      	mov	r5, r0
  }
}
c0d01582:	b2a8      	uxth	r0, r5
c0d01584:	b001      	add	sp, #4
c0d01586:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01588:	2610      	movs	r6, #16
c0d0158a:	4026      	ands	r6, r4
c0d0158c:	2900      	cmp	r1, #0
c0d0158e:	d02a      	beq.n	c0d015e6 <io_exchange+0x7a>
c0d01590:	2e00      	cmp	r6, #0
c0d01592:	d128      	bne.n	c0d015e6 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01594:	483d      	ldr	r0, [pc, #244]	; (c0d0168c <io_exchange+0x120>)
c0d01596:	7800      	ldrb	r0, [r0, #0]
c0d01598:	2807      	cmp	r0, #7
c0d0159a:	d00b      	beq.n	c0d015b4 <io_exchange+0x48>
c0d0159c:	2800      	cmp	r0, #0
c0d0159e:	d004      	beq.n	c0d015aa <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d015a0:	4620      	mov	r0, r4
c0d015a2:	f7ff f8ab 	bl	c0d006fc <io_exchange_al>
c0d015a6:	2800      	cmp	r0, #0
c0d015a8:	d00a      	beq.n	c0d015c0 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d015aa:	4839      	ldr	r0, [pc, #228]	; (c0d01690 <io_exchange+0x124>)
c0d015ac:	6800      	ldr	r0, [r0, #0]
c0d015ae:	2109      	movs	r1, #9
c0d015b0:	f001 ff2c 	bl	c0d0340c <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d015b4:	483d      	ldr	r0, [pc, #244]	; (c0d016ac <io_exchange+0x140>)
c0d015b6:	4478      	add	r0, pc
c0d015b8:	2200      	movs	r2, #0
c0d015ba:	2320      	movs	r3, #32
c0d015bc:	f7ff fc6a 	bl	c0d00e94 <io_usb_hid_exchange>
c0d015c0:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d015c2:	4832      	ldr	r0, [pc, #200]	; (c0d0168c <io_exchange+0x120>)
c0d015c4:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d015c6:	4833      	ldr	r0, [pc, #204]	; (c0d01694 <io_exchange+0x128>)
c0d015c8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d015ca:	4833      	ldr	r0, [pc, #204]	; (c0d01698 <io_exchange+0x12c>)
c0d015cc:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d015ce:	4833      	ldr	r0, [pc, #204]	; (c0d0169c <io_exchange+0x130>)
c0d015d0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d015d2:	4833      	ldr	r0, [pc, #204]	; (c0d016a0 <io_exchange+0x134>)
c0d015d4:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d015d6:	06a0      	lsls	r0, r4, #26
c0d015d8:	d4d3      	bmi.n	c0d01582 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d015da:	f7ff fcd3 	bl	c0d00f84 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d015de:	0620      	lsls	r0, r4, #24
c0d015e0:	d501      	bpl.n	c0d015e6 <io_exchange+0x7a>
        reset();
c0d015e2:	f000 faeb 	bl	c0d01bbc <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d015e6:	2e00      	cmp	r6, #0
c0d015e8:	d10c      	bne.n	c0d01604 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d015ea:	0660      	lsls	r0, r4, #25
c0d015ec:	d448      	bmi.n	c0d01680 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d015ee:	4827      	ldr	r0, [pc, #156]	; (c0d0168c <io_exchange+0x120>)
c0d015f0:	2100      	movs	r1, #0
c0d015f2:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d015f4:	4827      	ldr	r0, [pc, #156]	; (c0d01694 <io_exchange+0x128>)
c0d015f6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d015f8:	4827      	ldr	r0, [pc, #156]	; (c0d01698 <io_exchange+0x12c>)
c0d015fa:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d015fc:	4827      	ldr	r0, [pc, #156]	; (c0d0169c <io_exchange+0x130>)
c0d015fe:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01600:	4827      	ldr	r0, [pc, #156]	; (c0d016a0 <io_exchange+0x134>)
c0d01602:	7001      	strb	r1, [r0, #0]
c0d01604:	4c28      	ldr	r4, [pc, #160]	; (c0d016a8 <io_exchange+0x13c>)
c0d01606:	4e24      	ldr	r6, [pc, #144]	; (c0d01698 <io_exchange+0x12c>)
c0d01608:	e008      	b.n	c0d0161c <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d0160a:	f7ff fd0f 	bl	c0d0102c <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d0160e:	8830      	ldrh	r0, [r6, #0]
c0d01610:	2800      	cmp	r0, #0
c0d01612:	d003      	beq.n	c0d0161c <io_exchange+0xb0>
c0d01614:	e032      	b.n	c0d0167c <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01616:	2002      	movs	r0, #2
c0d01618:	f7ff f89e 	bl	c0d00758 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d0161c:	f000 fc72 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d01620:	2800      	cmp	r0, #0
c0d01622:	d101      	bne.n	c0d01628 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01624:	f7ff fcae 	bl	c0d00f84 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01628:	2180      	movs	r1, #128	; 0x80
c0d0162a:	2500      	movs	r5, #0
c0d0162c:	4620      	mov	r0, r4
c0d0162e:	462a      	mov	r2, r5
c0d01630:	f000 fc84 	bl	c0d01f3c <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01634:	1ec1      	subs	r1, r0, #3
c0d01636:	78a2      	ldrb	r2, [r4, #2]
c0d01638:	7863      	ldrb	r3, [r4, #1]
c0d0163a:	021b      	lsls	r3, r3, #8
c0d0163c:	4313      	orrs	r3, r2
c0d0163e:	4299      	cmp	r1, r3
c0d01640:	d110      	bne.n	c0d01664 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01642:	4917      	ldr	r1, [pc, #92]	; (c0d016a0 <io_exchange+0x134>)
c0d01644:	7809      	ldrb	r1, [r1, #0]
c0d01646:	2900      	cmp	r1, #0
c0d01648:	d002      	beq.n	c0d01650 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d0164a:	f7ff fd73 	bl	c0d01134 <io_seproxyhal_handle_event>
c0d0164e:	e7e5      	b.n	c0d0161c <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01650:	7821      	ldrb	r1, [r4, #0]
c0d01652:	2910      	cmp	r1, #16
c0d01654:	d00f      	beq.n	c0d01676 <io_exchange+0x10a>
c0d01656:	290f      	cmp	r1, #15
c0d01658:	d1dd      	bne.n	c0d01616 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d0165a:	2804      	cmp	r0, #4
c0d0165c:	d102      	bne.n	c0d01664 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d0165e:	f7ff fca7 	bl	c0d00fb0 <io_seproxyhal_handle_usb_event>
c0d01662:	e7db      	b.n	c0d0161c <io_exchange+0xb0>
c0d01664:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01666:	4909      	ldr	r1, [pc, #36]	; (c0d0168c <io_exchange+0x120>)
c0d01668:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d0166a:	490a      	ldr	r1, [pc, #40]	; (c0d01694 <io_exchange+0x128>)
c0d0166c:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d0166e:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01670:	490a      	ldr	r1, [pc, #40]	; (c0d0169c <io_exchange+0x130>)
c0d01672:	8008      	strh	r0, [r1, #0]
c0d01674:	e7d2      	b.n	c0d0161c <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01676:	2806      	cmp	r0, #6
c0d01678:	d2c7      	bcs.n	c0d0160a <io_exchange+0x9e>
c0d0167a:	e782      	b.n	c0d01582 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d0167c:	8835      	ldrh	r5, [r6, #0]
c0d0167e:	e780      	b.n	c0d01582 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01680:	4805      	ldr	r0, [pc, #20]	; (c0d01698 <io_exchange+0x12c>)
c0d01682:	8800      	ldrh	r0, [r0, #0]
c0d01684:	4907      	ldr	r1, [pc, #28]	; (c0d016a4 <io_exchange+0x138>)
c0d01686:	1845      	adds	r5, r0, r1
c0d01688:	e77b      	b.n	c0d01582 <io_exchange+0x16>
c0d0168a:	46c0      	nop			; (mov r8, r8)
c0d0168c:	20001d18 	.word	0x20001d18
c0d01690:	20001bb8 	.word	0x20001bb8
c0d01694:	20001d1a 	.word	0x20001d1a
c0d01698:	20001d1c 	.word	0x20001d1c
c0d0169c:	20001d1e 	.word	0x20001d1e
c0d016a0:	20001d10 	.word	0x20001d10
c0d016a4:	0000fffb 	.word	0x0000fffb
c0d016a8:	20001a18 	.word	0x20001a18
c0d016ac:	fffffbbb 	.word	0xfffffbbb

c0d016b0 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d016b0:	b081      	sub	sp, #4
c0d016b2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d016b4:	af03      	add	r7, sp, #12
c0d016b6:	b094      	sub	sp, #80	; 0x50
c0d016b8:	4616      	mov	r6, r2
c0d016ba:	460d      	mov	r5, r1
c0d016bc:	900e      	str	r0, [sp, #56]	; 0x38
c0d016be:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d016c0:	2d02      	cmp	r5, #2
c0d016c2:	d200      	bcs.n	c0d016c6 <snprintf+0x16>
c0d016c4:	e22a      	b.n	c0d01b1c <snprintf+0x46c>
c0d016c6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d016c8:	2800      	cmp	r0, #0
c0d016ca:	d100      	bne.n	c0d016ce <snprintf+0x1e>
c0d016cc:	e226      	b.n	c0d01b1c <snprintf+0x46c>
c0d016ce:	2e00      	cmp	r6, #0
c0d016d0:	d100      	bne.n	c0d016d4 <snprintf+0x24>
c0d016d2:	e223      	b.n	c0d01b1c <snprintf+0x46c>
c0d016d4:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d016d6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d016d8:	9109      	str	r1, [sp, #36]	; 0x24
c0d016da:	462a      	mov	r2, r5
c0d016dc:	f7ff fbae 	bl	c0d00e3c <os_memset>
c0d016e0:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d016e2:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d016e4:	7830      	ldrb	r0, [r6, #0]
c0d016e6:	2800      	cmp	r0, #0
c0d016e8:	d100      	bne.n	c0d016ec <snprintf+0x3c>
c0d016ea:	e217      	b.n	c0d01b1c <snprintf+0x46c>
c0d016ec:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d016ee:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d016f0:	1e6b      	subs	r3, r5, #1
c0d016f2:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d016f4:	460a      	mov	r2, r1
c0d016f6:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d016f8:	e003      	b.n	c0d01702 <snprintf+0x52>
c0d016fa:	1970      	adds	r0, r6, r5
c0d016fc:	7840      	ldrb	r0, [r0, #1]
c0d016fe:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01700:	1c6d      	adds	r5, r5, #1
c0d01702:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01704:	2800      	cmp	r0, #0
c0d01706:	d001      	beq.n	c0d0170c <snprintf+0x5c>
c0d01708:	2825      	cmp	r0, #37	; 0x25
c0d0170a:	d1f6      	bne.n	c0d016fa <snprintf+0x4a>
c0d0170c:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d0170e:	429d      	cmp	r5, r3
c0d01710:	d300      	bcc.n	c0d01714 <snprintf+0x64>
c0d01712:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01714:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01716:	4631      	mov	r1, r6
c0d01718:	462a      	mov	r2, r5
c0d0171a:	461c      	mov	r4, r3
c0d0171c:	f7ff fb98 	bl	c0d00e50 <os_memmove>
c0d01720:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01722:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01724:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01726:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01728:	2b00      	cmp	r3, #0
c0d0172a:	d100      	bne.n	c0d0172e <snprintf+0x7e>
c0d0172c:	e1f6      	b.n	c0d01b1c <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d0172e:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01730:	5d71      	ldrb	r1, [r6, r5]
c0d01732:	2925      	cmp	r1, #37	; 0x25
c0d01734:	d000      	beq.n	c0d01738 <snprintf+0x88>
c0d01736:	e0ab      	b.n	c0d01890 <snprintf+0x1e0>
c0d01738:	9304      	str	r3, [sp, #16]
c0d0173a:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d0173c:	1c40      	adds	r0, r0, #1
c0d0173e:	2100      	movs	r1, #0
c0d01740:	2220      	movs	r2, #32
c0d01742:	920a      	str	r2, [sp, #40]	; 0x28
c0d01744:	220a      	movs	r2, #10
c0d01746:	9203      	str	r2, [sp, #12]
c0d01748:	9102      	str	r1, [sp, #8]
c0d0174a:	9106      	str	r1, [sp, #24]
c0d0174c:	910d      	str	r1, [sp, #52]	; 0x34
c0d0174e:	460b      	mov	r3, r1
c0d01750:	2102      	movs	r1, #2
c0d01752:	910c      	str	r1, [sp, #48]	; 0x30
c0d01754:	4606      	mov	r6, r0
c0d01756:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01758:	7831      	ldrb	r1, [r6, #0]
c0d0175a:	1c76      	adds	r6, r6, #1
c0d0175c:	2300      	movs	r3, #0
c0d0175e:	2962      	cmp	r1, #98	; 0x62
c0d01760:	dc41      	bgt.n	c0d017e6 <snprintf+0x136>
c0d01762:	4608      	mov	r0, r1
c0d01764:	3825      	subs	r0, #37	; 0x25
c0d01766:	2823      	cmp	r0, #35	; 0x23
c0d01768:	d900      	bls.n	c0d0176c <snprintf+0xbc>
c0d0176a:	e094      	b.n	c0d01896 <snprintf+0x1e6>
c0d0176c:	0040      	lsls	r0, r0, #1
c0d0176e:	46c0      	nop			; (mov r8, r8)
c0d01770:	4478      	add	r0, pc
c0d01772:	8880      	ldrh	r0, [r0, #4]
c0d01774:	0040      	lsls	r0, r0, #1
c0d01776:	4487      	add	pc, r0
c0d01778:	0186012d 	.word	0x0186012d
c0d0177c:	01860186 	.word	0x01860186
c0d01780:	00510186 	.word	0x00510186
c0d01784:	01860186 	.word	0x01860186
c0d01788:	00580023 	.word	0x00580023
c0d0178c:	00240186 	.word	0x00240186
c0d01790:	00240024 	.word	0x00240024
c0d01794:	00240024 	.word	0x00240024
c0d01798:	00240024 	.word	0x00240024
c0d0179c:	00240024 	.word	0x00240024
c0d017a0:	01860024 	.word	0x01860024
c0d017a4:	01860186 	.word	0x01860186
c0d017a8:	01860186 	.word	0x01860186
c0d017ac:	01860186 	.word	0x01860186
c0d017b0:	01860186 	.word	0x01860186
c0d017b4:	01860186 	.word	0x01860186
c0d017b8:	01860186 	.word	0x01860186
c0d017bc:	006c0186 	.word	0x006c0186
c0d017c0:	e7c9      	b.n	c0d01756 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d017c2:	2930      	cmp	r1, #48	; 0x30
c0d017c4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d017c6:	4603      	mov	r3, r0
c0d017c8:	d100      	bne.n	c0d017cc <snprintf+0x11c>
c0d017ca:	460b      	mov	r3, r1
c0d017cc:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d017ce:	2c00      	cmp	r4, #0
c0d017d0:	d000      	beq.n	c0d017d4 <snprintf+0x124>
c0d017d2:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d017d4:	200a      	movs	r0, #10
c0d017d6:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d017d8:	1840      	adds	r0, r0, r1
c0d017da:	3830      	subs	r0, #48	; 0x30
c0d017dc:	900d      	str	r0, [sp, #52]	; 0x34
c0d017de:	4630      	mov	r0, r6
c0d017e0:	930a      	str	r3, [sp, #40]	; 0x28
c0d017e2:	4613      	mov	r3, r2
c0d017e4:	e7b4      	b.n	c0d01750 <snprintf+0xa0>
c0d017e6:	296f      	cmp	r1, #111	; 0x6f
c0d017e8:	dd11      	ble.n	c0d0180e <snprintf+0x15e>
c0d017ea:	3970      	subs	r1, #112	; 0x70
c0d017ec:	2908      	cmp	r1, #8
c0d017ee:	d900      	bls.n	c0d017f2 <snprintf+0x142>
c0d017f0:	e149      	b.n	c0d01a86 <snprintf+0x3d6>
c0d017f2:	0049      	lsls	r1, r1, #1
c0d017f4:	4479      	add	r1, pc
c0d017f6:	8889      	ldrh	r1, [r1, #4]
c0d017f8:	0049      	lsls	r1, r1, #1
c0d017fa:	448f      	add	pc, r1
c0d017fc:	01440051 	.word	0x01440051
c0d01800:	002e0144 	.word	0x002e0144
c0d01804:	00590144 	.word	0x00590144
c0d01808:	01440144 	.word	0x01440144
c0d0180c:	0051      	.short	0x0051
c0d0180e:	2963      	cmp	r1, #99	; 0x63
c0d01810:	d054      	beq.n	c0d018bc <snprintf+0x20c>
c0d01812:	2964      	cmp	r1, #100	; 0x64
c0d01814:	d057      	beq.n	c0d018c6 <snprintf+0x216>
c0d01816:	2968      	cmp	r1, #104	; 0x68
c0d01818:	d01d      	beq.n	c0d01856 <snprintf+0x1a6>
c0d0181a:	e134      	b.n	c0d01a86 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d0181c:	7830      	ldrb	r0, [r6, #0]
c0d0181e:	2873      	cmp	r0, #115	; 0x73
c0d01820:	d000      	beq.n	c0d01824 <snprintf+0x174>
c0d01822:	e130      	b.n	c0d01a86 <snprintf+0x3d6>
c0d01824:	4630      	mov	r0, r6
c0d01826:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01828:	e00d      	b.n	c0d01846 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d0182a:	7830      	ldrb	r0, [r6, #0]
c0d0182c:	282a      	cmp	r0, #42	; 0x2a
c0d0182e:	d000      	beq.n	c0d01832 <snprintf+0x182>
c0d01830:	e129      	b.n	c0d01a86 <snprintf+0x3d6>
c0d01832:	7871      	ldrb	r1, [r6, #1]
c0d01834:	1c70      	adds	r0, r6, #1
c0d01836:	2301      	movs	r3, #1
c0d01838:	2948      	cmp	r1, #72	; 0x48
c0d0183a:	d004      	beq.n	c0d01846 <snprintf+0x196>
c0d0183c:	2968      	cmp	r1, #104	; 0x68
c0d0183e:	d002      	beq.n	c0d01846 <snprintf+0x196>
c0d01840:	2973      	cmp	r1, #115	; 0x73
c0d01842:	d000      	beq.n	c0d01846 <snprintf+0x196>
c0d01844:	e11f      	b.n	c0d01a86 <snprintf+0x3d6>
c0d01846:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01848:	1d0a      	adds	r2, r1, #4
c0d0184a:	920f      	str	r2, [sp, #60]	; 0x3c
c0d0184c:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d0184e:	9102      	str	r1, [sp, #8]
c0d01850:	e77e      	b.n	c0d01750 <snprintf+0xa0>
c0d01852:	2001      	movs	r0, #1
c0d01854:	9006      	str	r0, [sp, #24]
c0d01856:	2010      	movs	r0, #16
c0d01858:	9003      	str	r0, [sp, #12]
c0d0185a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d0185c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0185e:	1d01      	adds	r1, r0, #4
c0d01860:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01862:	2103      	movs	r1, #3
c0d01864:	400a      	ands	r2, r1
c0d01866:	1c5b      	adds	r3, r3, #1
c0d01868:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d0186a:	2a01      	cmp	r2, #1
c0d0186c:	d100      	bne.n	c0d01870 <snprintf+0x1c0>
c0d0186e:	e0b8      	b.n	c0d019e2 <snprintf+0x332>
c0d01870:	2a02      	cmp	r2, #2
c0d01872:	d100      	bne.n	c0d01876 <snprintf+0x1c6>
c0d01874:	e104      	b.n	c0d01a80 <snprintf+0x3d0>
c0d01876:	2a03      	cmp	r2, #3
c0d01878:	4630      	mov	r0, r6
c0d0187a:	d100      	bne.n	c0d0187e <snprintf+0x1ce>
c0d0187c:	e768      	b.n	c0d01750 <snprintf+0xa0>
c0d0187e:	9c08      	ldr	r4, [sp, #32]
c0d01880:	4625      	mov	r5, r4
c0d01882:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01884:	1948      	adds	r0, r1, r5
c0d01886:	7840      	ldrb	r0, [r0, #1]
c0d01888:	1c6d      	adds	r5, r5, #1
c0d0188a:	2800      	cmp	r0, #0
c0d0188c:	d1fa      	bne.n	c0d01884 <snprintf+0x1d4>
c0d0188e:	e0ab      	b.n	c0d019e8 <snprintf+0x338>
c0d01890:	4606      	mov	r6, r0
c0d01892:	920e      	str	r2, [sp, #56]	; 0x38
c0d01894:	e109      	b.n	c0d01aaa <snprintf+0x3fa>
c0d01896:	2958      	cmp	r1, #88	; 0x58
c0d01898:	d000      	beq.n	c0d0189c <snprintf+0x1ec>
c0d0189a:	e0f4      	b.n	c0d01a86 <snprintf+0x3d6>
c0d0189c:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d0189e:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d018a0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d018a2:	1d01      	adds	r1, r0, #4
c0d018a4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d018a6:	6802      	ldr	r2, [r0, #0]
c0d018a8:	2000      	movs	r0, #0
c0d018aa:	9005      	str	r0, [sp, #20]
c0d018ac:	2510      	movs	r5, #16
c0d018ae:	e014      	b.n	c0d018da <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d018b0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d018b2:	1d01      	adds	r1, r0, #4
c0d018b4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d018b6:	6802      	ldr	r2, [r0, #0]
c0d018b8:	2000      	movs	r0, #0
c0d018ba:	e00c      	b.n	c0d018d6 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d018bc:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d018be:	1d01      	adds	r1, r0, #4
c0d018c0:	910f      	str	r1, [sp, #60]	; 0x3c
c0d018c2:	6800      	ldr	r0, [r0, #0]
c0d018c4:	e087      	b.n	c0d019d6 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d018c6:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d018c8:	1d01      	adds	r1, r0, #4
c0d018ca:	910f      	str	r1, [sp, #60]	; 0x3c
c0d018cc:	6800      	ldr	r0, [r0, #0]
c0d018ce:	17c1      	asrs	r1, r0, #31
c0d018d0:	1842      	adds	r2, r0, r1
c0d018d2:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d018d4:	0fc0      	lsrs	r0, r0, #31
c0d018d6:	9005      	str	r0, [sp, #20]
c0d018d8:	250a      	movs	r5, #10
c0d018da:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d018dc:	4295      	cmp	r5, r2
c0d018de:	920e      	str	r2, [sp, #56]	; 0x38
c0d018e0:	d814      	bhi.n	c0d0190c <snprintf+0x25c>
c0d018e2:	2201      	movs	r2, #1
c0d018e4:	4628      	mov	r0, r5
c0d018e6:	920b      	str	r2, [sp, #44]	; 0x2c
c0d018e8:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d018ea:	4629      	mov	r1, r5
c0d018ec:	f001 fb4a 	bl	c0d02f84 <__aeabi_uidiv>
c0d018f0:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d018f2:	4288      	cmp	r0, r1
c0d018f4:	d109      	bne.n	c0d0190a <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d018f6:	4628      	mov	r0, r5
c0d018f8:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d018fa:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d018fc:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d018fe:	910d      	str	r1, [sp, #52]	; 0x34
c0d01900:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01902:	4288      	cmp	r0, r1
c0d01904:	4622      	mov	r2, r4
c0d01906:	d9ee      	bls.n	c0d018e6 <snprintf+0x236>
c0d01908:	e000      	b.n	c0d0190c <snprintf+0x25c>
c0d0190a:	460c      	mov	r4, r1
c0d0190c:	950c      	str	r5, [sp, #48]	; 0x30
c0d0190e:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01910:	2000      	movs	r0, #0
c0d01912:	4603      	mov	r3, r0
c0d01914:	43c1      	mvns	r1, r0
c0d01916:	9c05      	ldr	r4, [sp, #20]
c0d01918:	2c00      	cmp	r4, #0
c0d0191a:	d100      	bne.n	c0d0191e <snprintf+0x26e>
c0d0191c:	4621      	mov	r1, r4
c0d0191e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01920:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01922:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01924:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01926:	b2ca      	uxtb	r2, r1
c0d01928:	2a30      	cmp	r2, #48	; 0x30
c0d0192a:	d106      	bne.n	c0d0193a <snprintf+0x28a>
c0d0192c:	2c00      	cmp	r4, #0
c0d0192e:	d004      	beq.n	c0d0193a <snprintf+0x28a>
c0d01930:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01932:	232d      	movs	r3, #45	; 0x2d
c0d01934:	700b      	strb	r3, [r1, #0]
c0d01936:	2400      	movs	r4, #0
c0d01938:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d0193a:	1e81      	subs	r1, r0, #2
c0d0193c:	290d      	cmp	r1, #13
c0d0193e:	d80d      	bhi.n	c0d0195c <snprintf+0x2ac>
c0d01940:	1e41      	subs	r1, r0, #1
c0d01942:	d00b      	beq.n	c0d0195c <snprintf+0x2ac>
c0d01944:	a810      	add	r0, sp, #64	; 0x40
c0d01946:	9405      	str	r4, [sp, #20]
c0d01948:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d0194a:	4320      	orrs	r0, r4
c0d0194c:	f001 fcc6 	bl	c0d032dc <__aeabi_memset>
c0d01950:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01952:	1900      	adds	r0, r0, r4
c0d01954:	9c05      	ldr	r4, [sp, #20]
c0d01956:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01958:	1840      	adds	r0, r0, r1
c0d0195a:	1e43      	subs	r3, r0, #1
c0d0195c:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0195e:	2c00      	cmp	r4, #0
c0d01960:	9601      	str	r6, [sp, #4]
c0d01962:	d003      	beq.n	c0d0196c <snprintf+0x2bc>
c0d01964:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01966:	222d      	movs	r2, #45	; 0x2d
c0d01968:	54c2      	strb	r2, [r0, r3]
c0d0196a:	1c5b      	adds	r3, r3, #1
c0d0196c:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d0196e:	2900      	cmp	r1, #0
c0d01970:	d003      	beq.n	c0d0197a <snprintf+0x2ca>
c0d01972:	2800      	cmp	r0, #0
c0d01974:	d003      	beq.n	c0d0197e <snprintf+0x2ce>
c0d01976:	a06c      	add	r0, pc, #432	; (adr r0, c0d01b28 <g_pcHex_cap>)
c0d01978:	e002      	b.n	c0d01980 <snprintf+0x2d0>
c0d0197a:	461c      	mov	r4, r3
c0d0197c:	e016      	b.n	c0d019ac <snprintf+0x2fc>
c0d0197e:	a06e      	add	r0, pc, #440	; (adr r0, c0d01b38 <g_pcHex>)
c0d01980:	900d      	str	r0, [sp, #52]	; 0x34
c0d01982:	461c      	mov	r4, r3
c0d01984:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01986:	460e      	mov	r6, r1
c0d01988:	f001 fafc 	bl	c0d02f84 <__aeabi_uidiv>
c0d0198c:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d0198e:	4629      	mov	r1, r5
c0d01990:	f001 fb7e 	bl	c0d03090 <__aeabi_uidivmod>
c0d01994:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01996:	5c40      	ldrb	r0, [r0, r1]
c0d01998:	a910      	add	r1, sp, #64	; 0x40
c0d0199a:	5508      	strb	r0, [r1, r4]
c0d0199c:	4630      	mov	r0, r6
c0d0199e:	4629      	mov	r1, r5
c0d019a0:	f001 faf0 	bl	c0d02f84 <__aeabi_uidiv>
c0d019a4:	1c64      	adds	r4, r4, #1
c0d019a6:	42b5      	cmp	r5, r6
c0d019a8:	4601      	mov	r1, r0
c0d019aa:	d9eb      	bls.n	c0d01984 <snprintf+0x2d4>
c0d019ac:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d019ae:	429c      	cmp	r4, r3
c0d019b0:	4625      	mov	r5, r4
c0d019b2:	d300      	bcc.n	c0d019b6 <snprintf+0x306>
c0d019b4:	461d      	mov	r5, r3
c0d019b6:	a910      	add	r1, sp, #64	; 0x40
c0d019b8:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d019ba:	4620      	mov	r0, r4
c0d019bc:	462a      	mov	r2, r5
c0d019be:	461e      	mov	r6, r3
c0d019c0:	f7ff fa46 	bl	c0d00e50 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d019c4:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d019c6:	1961      	adds	r1, r4, r5
c0d019c8:	910e      	str	r1, [sp, #56]	; 0x38
c0d019ca:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d019cc:	2800      	cmp	r0, #0
c0d019ce:	9e01      	ldr	r6, [sp, #4]
c0d019d0:	d16b      	bne.n	c0d01aaa <snprintf+0x3fa>
c0d019d2:	e0a3      	b.n	c0d01b1c <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d019d4:	2025      	movs	r0, #37	; 0x25
c0d019d6:	9907      	ldr	r1, [sp, #28]
c0d019d8:	7008      	strb	r0, [r1, #0]
c0d019da:	9804      	ldr	r0, [sp, #16]
c0d019dc:	1e40      	subs	r0, r0, #1
c0d019de:	1c49      	adds	r1, r1, #1
c0d019e0:	e05f      	b.n	c0d01aa2 <snprintf+0x3f2>
c0d019e2:	9d02      	ldr	r5, [sp, #8]
c0d019e4:	9c08      	ldr	r4, [sp, #32]
c0d019e6:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d019e8:	9803      	ldr	r0, [sp, #12]
c0d019ea:	2810      	cmp	r0, #16
c0d019ec:	9807      	ldr	r0, [sp, #28]
c0d019ee:	d161      	bne.n	c0d01ab4 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d019f0:	2d00      	cmp	r5, #0
c0d019f2:	d06a      	beq.n	c0d01aca <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d019f4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d019f6:	1900      	adds	r0, r0, r4
c0d019f8:	900e      	str	r0, [sp, #56]	; 0x38
c0d019fa:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d019fc:	1aa0      	subs	r0, r4, r2
c0d019fe:	9b05      	ldr	r3, [sp, #20]
c0d01a00:	4283      	cmp	r3, r0
c0d01a02:	d800      	bhi.n	c0d01a06 <snprintf+0x356>
c0d01a04:	4603      	mov	r3, r0
c0d01a06:	930c      	str	r3, [sp, #48]	; 0x30
c0d01a08:	435c      	muls	r4, r3
c0d01a0a:	940a      	str	r4, [sp, #40]	; 0x28
c0d01a0c:	1c60      	adds	r0, r4, #1
c0d01a0e:	9007      	str	r0, [sp, #28]
c0d01a10:	2000      	movs	r0, #0
c0d01a12:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01a14:	9100      	str	r1, [sp, #0]
c0d01a16:	940e      	str	r4, [sp, #56]	; 0x38
c0d01a18:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01a1a:	18e3      	adds	r3, r4, r3
c0d01a1c:	900d      	str	r0, [sp, #52]	; 0x34
c0d01a1e:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01a20:	200f      	movs	r0, #15
c0d01a22:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01a24:	0909      	lsrs	r1, r1, #4
c0d01a26:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01a28:	18a4      	adds	r4, r4, r2
c0d01a2a:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01a2c:	2c02      	cmp	r4, #2
c0d01a2e:	d375      	bcc.n	c0d01b1c <snprintf+0x46c>
c0d01a30:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01a32:	2c01      	cmp	r4, #1
c0d01a34:	d003      	beq.n	c0d01a3e <snprintf+0x38e>
c0d01a36:	2c00      	cmp	r4, #0
c0d01a38:	d108      	bne.n	c0d01a4c <snprintf+0x39c>
c0d01a3a:	a43f      	add	r4, pc, #252	; (adr r4, c0d01b38 <g_pcHex>)
c0d01a3c:	e000      	b.n	c0d01a40 <snprintf+0x390>
c0d01a3e:	a43a      	add	r4, pc, #232	; (adr r4, c0d01b28 <g_pcHex_cap>)
c0d01a40:	b2c9      	uxtb	r1, r1
c0d01a42:	5c61      	ldrb	r1, [r4, r1]
c0d01a44:	7019      	strb	r1, [r3, #0]
c0d01a46:	b2c0      	uxtb	r0, r0
c0d01a48:	5c20      	ldrb	r0, [r4, r0]
c0d01a4a:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01a4c:	9807      	ldr	r0, [sp, #28]
c0d01a4e:	4290      	cmp	r0, r2
c0d01a50:	d064      	beq.n	c0d01b1c <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01a52:	1e92      	subs	r2, r2, #2
c0d01a54:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01a56:	1ca4      	adds	r4, r4, #2
c0d01a58:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01a5a:	1c40      	adds	r0, r0, #1
c0d01a5c:	42a8      	cmp	r0, r5
c0d01a5e:	9900      	ldr	r1, [sp, #0]
c0d01a60:	d3d9      	bcc.n	c0d01a16 <snprintf+0x366>
c0d01a62:	900d      	str	r0, [sp, #52]	; 0x34
c0d01a64:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01a66:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01a68:	1a08      	subs	r0, r1, r0
c0d01a6a:	9b05      	ldr	r3, [sp, #20]
c0d01a6c:	4283      	cmp	r3, r0
c0d01a6e:	d800      	bhi.n	c0d01a72 <snprintf+0x3c2>
c0d01a70:	4603      	mov	r3, r0
c0d01a72:	4608      	mov	r0, r1
c0d01a74:	4358      	muls	r0, r3
c0d01a76:	1820      	adds	r0, r4, r0
c0d01a78:	900e      	str	r0, [sp, #56]	; 0x38
c0d01a7a:	1898      	adds	r0, r3, r2
c0d01a7c:	1c43      	adds	r3, r0, #1
c0d01a7e:	e038      	b.n	c0d01af2 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01a80:	7808      	ldrb	r0, [r1, #0]
c0d01a82:	2800      	cmp	r0, #0
c0d01a84:	d023      	beq.n	c0d01ace <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01a86:	2005      	movs	r0, #5
c0d01a88:	9d04      	ldr	r5, [sp, #16]
c0d01a8a:	2d05      	cmp	r5, #5
c0d01a8c:	462c      	mov	r4, r5
c0d01a8e:	d300      	bcc.n	c0d01a92 <snprintf+0x3e2>
c0d01a90:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01a92:	9807      	ldr	r0, [sp, #28]
c0d01a94:	a12c      	add	r1, pc, #176	; (adr r1, c0d01b48 <g_pcHex+0x10>)
c0d01a96:	4622      	mov	r2, r4
c0d01a98:	f7ff f9da 	bl	c0d00e50 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01a9c:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01a9e:	9907      	ldr	r1, [sp, #28]
c0d01aa0:	1909      	adds	r1, r1, r4
c0d01aa2:	910e      	str	r1, [sp, #56]	; 0x38
c0d01aa4:	4603      	mov	r3, r0
c0d01aa6:	2800      	cmp	r0, #0
c0d01aa8:	d038      	beq.n	c0d01b1c <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01aaa:	7830      	ldrb	r0, [r6, #0]
c0d01aac:	2800      	cmp	r0, #0
c0d01aae:	9908      	ldr	r1, [sp, #32]
c0d01ab0:	d034      	beq.n	c0d01b1c <snprintf+0x46c>
c0d01ab2:	e61f      	b.n	c0d016f4 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01ab4:	429d      	cmp	r5, r3
c0d01ab6:	d300      	bcc.n	c0d01aba <snprintf+0x40a>
c0d01ab8:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01aba:	462a      	mov	r2, r5
c0d01abc:	461c      	mov	r4, r3
c0d01abe:	f7ff f9c7 	bl	c0d00e50 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01ac2:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01ac4:	9907      	ldr	r1, [sp, #28]
c0d01ac6:	1949      	adds	r1, r1, r5
c0d01ac8:	e00f      	b.n	c0d01aea <snprintf+0x43a>
c0d01aca:	900e      	str	r0, [sp, #56]	; 0x38
c0d01acc:	e7ed      	b.n	c0d01aaa <snprintf+0x3fa>
c0d01ace:	9b04      	ldr	r3, [sp, #16]
c0d01ad0:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01ad2:	429c      	cmp	r4, r3
c0d01ad4:	d300      	bcc.n	c0d01ad8 <snprintf+0x428>
c0d01ad6:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01ad8:	2120      	movs	r1, #32
c0d01ada:	9807      	ldr	r0, [sp, #28]
c0d01adc:	4622      	mov	r2, r4
c0d01ade:	f7ff f9ad 	bl	c0d00e3c <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01ae2:	9804      	ldr	r0, [sp, #16]
c0d01ae4:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01ae6:	9907      	ldr	r1, [sp, #28]
c0d01ae8:	1909      	adds	r1, r1, r4
c0d01aea:	910e      	str	r1, [sp, #56]	; 0x38
c0d01aec:	4603      	mov	r3, r0
c0d01aee:	2800      	cmp	r0, #0
c0d01af0:	d014      	beq.n	c0d01b1c <snprintf+0x46c>
c0d01af2:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01af4:	42a8      	cmp	r0, r5
c0d01af6:	d9d8      	bls.n	c0d01aaa <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01af8:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01afa:	429a      	cmp	r2, r3
c0d01afc:	d300      	bcc.n	c0d01b00 <snprintf+0x450>
c0d01afe:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01b00:	2120      	movs	r1, #32
c0d01b02:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01b04:	4628      	mov	r0, r5
c0d01b06:	920d      	str	r2, [sp, #52]	; 0x34
c0d01b08:	461c      	mov	r4, r3
c0d01b0a:	f7ff f997 	bl	c0d00e3c <os_memset>
c0d01b0e:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01b10:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01b12:	182d      	adds	r5, r5, r0
c0d01b14:	950e      	str	r5, [sp, #56]	; 0x38
c0d01b16:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01b18:	2c00      	cmp	r4, #0
c0d01b1a:	d1c6      	bne.n	c0d01aaa <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01b1c:	2000      	movs	r0, #0
c0d01b1e:	b014      	add	sp, #80	; 0x50
c0d01b20:	bcf0      	pop	{r4, r5, r6, r7}
c0d01b22:	bc02      	pop	{r1}
c0d01b24:	b001      	add	sp, #4
c0d01b26:	4708      	bx	r1

c0d01b28 <g_pcHex_cap>:
c0d01b28:	33323130 	.word	0x33323130
c0d01b2c:	37363534 	.word	0x37363534
c0d01b30:	42413938 	.word	0x42413938
c0d01b34:	46454443 	.word	0x46454443

c0d01b38 <g_pcHex>:
c0d01b38:	33323130 	.word	0x33323130
c0d01b3c:	37363534 	.word	0x37363534
c0d01b40:	62613938 	.word	0x62613938
c0d01b44:	66656463 	.word	0x66656463
c0d01b48:	4f525245 	.word	0x4f525245
c0d01b4c:	00000052 	.word	0x00000052

c0d01b50 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01b50:	b580      	push	{r7, lr}
c0d01b52:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01b54:	4904      	ldr	r1, [pc, #16]	; (c0d01b68 <pic+0x18>)
c0d01b56:	4288      	cmp	r0, r1
c0d01b58:	d304      	bcc.n	c0d01b64 <pic+0x14>
c0d01b5a:	4904      	ldr	r1, [pc, #16]	; (c0d01b6c <pic+0x1c>)
c0d01b5c:	4288      	cmp	r0, r1
c0d01b5e:	d201      	bcs.n	c0d01b64 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01b60:	f000 f806 	bl	c0d01b70 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01b64:	bd80      	pop	{r7, pc}
c0d01b66:	46c0      	nop			; (mov r8, r8)
c0d01b68:	c0d00000 	.word	0xc0d00000
c0d01b6c:	c0d03980 	.word	0xc0d03980

c0d01b70 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01b70:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01b72:	4902      	ldr	r1, [pc, #8]	; (c0d01b7c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01b74:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01b76:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01b78:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01b7a:	4770      	bx	lr
c0d01b7c:	c0d01b71 	.word	0xc0d01b71

c0d01b80 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01b80:	b580      	push	{r7, lr}
c0d01b82:	af00      	add	r7, sp, #0
c0d01b84:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01b86:	490a      	ldr	r1, [pc, #40]	; (c0d01bb0 <check_api_level+0x30>)
c0d01b88:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b8a:	490a      	ldr	r1, [pc, #40]	; (c0d01bb4 <check_api_level+0x34>)
c0d01b8c:	680a      	ldr	r2, [r1, #0]
c0d01b8e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01b90:	9003      	str	r0, [sp, #12]
c0d01b92:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b94:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b96:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b98:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01b9a:	4807      	ldr	r0, [pc, #28]	; (c0d01bb8 <check_api_level+0x38>)
c0d01b9c:	9a01      	ldr	r2, [sp, #4]
c0d01b9e:	4282      	cmp	r2, r0
c0d01ba0:	d101      	bne.n	c0d01ba6 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ba2:	b004      	add	sp, #16
c0d01ba4:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ba6:	6808      	ldr	r0, [r1, #0]
c0d01ba8:	2104      	movs	r1, #4
c0d01baa:	f001 fc2f 	bl	c0d0340c <longjmp>
c0d01bae:	46c0      	nop			; (mov r8, r8)
c0d01bb0:	60000137 	.word	0x60000137
c0d01bb4:	20001bb8 	.word	0x20001bb8
c0d01bb8:	900001c6 	.word	0x900001c6

c0d01bbc <reset>:
  }
}

void reset ( void ) 
{
c0d01bbc:	b580      	push	{r7, lr}
c0d01bbe:	af00      	add	r7, sp, #0
c0d01bc0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01bc2:	4809      	ldr	r0, [pc, #36]	; (c0d01be8 <reset+0x2c>)
c0d01bc4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bc6:	4809      	ldr	r0, [pc, #36]	; (c0d01bec <reset+0x30>)
c0d01bc8:	6801      	ldr	r1, [r0, #0]
c0d01bca:	9101      	str	r1, [sp, #4]
c0d01bcc:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bce:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01bd0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bd2:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01bd4:	4906      	ldr	r1, [pc, #24]	; (c0d01bf0 <reset+0x34>)
c0d01bd6:	9a00      	ldr	r2, [sp, #0]
c0d01bd8:	428a      	cmp	r2, r1
c0d01bda:	d101      	bne.n	c0d01be0 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01bdc:	b002      	add	sp, #8
c0d01bde:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01be0:	6800      	ldr	r0, [r0, #0]
c0d01be2:	2104      	movs	r1, #4
c0d01be4:	f001 fc12 	bl	c0d0340c <longjmp>
c0d01be8:	60000200 	.word	0x60000200
c0d01bec:	20001bb8 	.word	0x20001bb8
c0d01bf0:	900002f1 	.word	0x900002f1

c0d01bf4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01bf4:	b5d0      	push	{r4, r6, r7, lr}
c0d01bf6:	af02      	add	r7, sp, #8
c0d01bf8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01bfa:	4b0a      	ldr	r3, [pc, #40]	; (c0d01c24 <nvm_write+0x30>)
c0d01bfc:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bfe:	4b0a      	ldr	r3, [pc, #40]	; (c0d01c28 <nvm_write+0x34>)
c0d01c00:	681c      	ldr	r4, [r3, #0]
c0d01c02:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01c04:	ac03      	add	r4, sp, #12
c0d01c06:	c407      	stmia	r4!, {r0, r1, r2}
c0d01c08:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c0a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c0c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c0e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01c10:	4806      	ldr	r0, [pc, #24]	; (c0d01c2c <nvm_write+0x38>)
c0d01c12:	9901      	ldr	r1, [sp, #4]
c0d01c14:	4281      	cmp	r1, r0
c0d01c16:	d101      	bne.n	c0d01c1c <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c18:	b006      	add	sp, #24
c0d01c1a:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c1c:	6818      	ldr	r0, [r3, #0]
c0d01c1e:	2104      	movs	r1, #4
c0d01c20:	f001 fbf4 	bl	c0d0340c <longjmp>
c0d01c24:	6000037f 	.word	0x6000037f
c0d01c28:	20001bb8 	.word	0x20001bb8
c0d01c2c:	900003bc 	.word	0x900003bc

c0d01c30 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01c30:	b580      	push	{r7, lr}
c0d01c32:	af00      	add	r7, sp, #0
c0d01c34:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01c36:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c60 <cx_rng+0x30>)
c0d01c38:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c3a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c64 <cx_rng+0x34>)
c0d01c3c:	6813      	ldr	r3, [r2, #0]
c0d01c3e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01c40:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01c42:	9103      	str	r1, [sp, #12]
c0d01c44:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c46:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c48:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c4a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01c4c:	4906      	ldr	r1, [pc, #24]	; (c0d01c68 <cx_rng+0x38>)
c0d01c4e:	9b00      	ldr	r3, [sp, #0]
c0d01c50:	428b      	cmp	r3, r1
c0d01c52:	d101      	bne.n	c0d01c58 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01c54:	b004      	add	sp, #16
c0d01c56:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c58:	6810      	ldr	r0, [r2, #0]
c0d01c5a:	2104      	movs	r1, #4
c0d01c5c:	f001 fbd6 	bl	c0d0340c <longjmp>
c0d01c60:	6000052c 	.word	0x6000052c
c0d01c64:	20001bb8 	.word	0x20001bb8
c0d01c68:	90000567 	.word	0x90000567

c0d01c6c <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01c6c:	b580      	push	{r7, lr}
c0d01c6e:	af00      	add	r7, sp, #0
c0d01c70:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01c72:	490a      	ldr	r1, [pc, #40]	; (c0d01c9c <cx_sha256_init+0x30>)
c0d01c74:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c76:	490a      	ldr	r1, [pc, #40]	; (c0d01ca0 <cx_sha256_init+0x34>)
c0d01c78:	680a      	ldr	r2, [r1, #0]
c0d01c7a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01c7c:	9003      	str	r0, [sp, #12]
c0d01c7e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c80:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c82:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c84:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01c86:	4a07      	ldr	r2, [pc, #28]	; (c0d01ca4 <cx_sha256_init+0x38>)
c0d01c88:	9b01      	ldr	r3, [sp, #4]
c0d01c8a:	4293      	cmp	r3, r2
c0d01c8c:	d101      	bne.n	c0d01c92 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c8e:	b004      	add	sp, #16
c0d01c90:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c92:	6808      	ldr	r0, [r1, #0]
c0d01c94:	2104      	movs	r1, #4
c0d01c96:	f001 fbb9 	bl	c0d0340c <longjmp>
c0d01c9a:	46c0      	nop			; (mov r8, r8)
c0d01c9c:	600008db 	.word	0x600008db
c0d01ca0:	20001bb8 	.word	0x20001bb8
c0d01ca4:	90000864 	.word	0x90000864

c0d01ca8 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01ca8:	b580      	push	{r7, lr}
c0d01caa:	af00      	add	r7, sp, #0
c0d01cac:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01cae:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cd8 <cx_keccak_init+0x30>)
c0d01cb0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cb2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cdc <cx_keccak_init+0x34>)
c0d01cb4:	6813      	ldr	r3, [r2, #0]
c0d01cb6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01cb8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01cba:	9103      	str	r1, [sp, #12]
c0d01cbc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cbe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cc0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cc2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01cc4:	4906      	ldr	r1, [pc, #24]	; (c0d01ce0 <cx_keccak_init+0x38>)
c0d01cc6:	9b00      	ldr	r3, [sp, #0]
c0d01cc8:	428b      	cmp	r3, r1
c0d01cca:	d101      	bne.n	c0d01cd0 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ccc:	b004      	add	sp, #16
c0d01cce:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cd0:	6810      	ldr	r0, [r2, #0]
c0d01cd2:	2104      	movs	r1, #4
c0d01cd4:	f001 fb9a 	bl	c0d0340c <longjmp>
c0d01cd8:	60000c3c 	.word	0x60000c3c
c0d01cdc:	20001bb8 	.word	0x20001bb8
c0d01ce0:	90000c39 	.word	0x90000c39

c0d01ce4 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01ce4:	b5b0      	push	{r4, r5, r7, lr}
c0d01ce6:	af02      	add	r7, sp, #8
c0d01ce8:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01cea:	4c0b      	ldr	r4, [pc, #44]	; (c0d01d18 <cx_hash+0x34>)
c0d01cec:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cee:	4c0b      	ldr	r4, [pc, #44]	; (c0d01d1c <cx_hash+0x38>)
c0d01cf0:	6825      	ldr	r5, [r4, #0]
c0d01cf2:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01cf4:	ad03      	add	r5, sp, #12
c0d01cf6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01cf8:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01cfa:	9007      	str	r0, [sp, #28]
c0d01cfc:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cfe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d00:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d02:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01d04:	4906      	ldr	r1, [pc, #24]	; (c0d01d20 <cx_hash+0x3c>)
c0d01d06:	9a01      	ldr	r2, [sp, #4]
c0d01d08:	428a      	cmp	r2, r1
c0d01d0a:	d101      	bne.n	c0d01d10 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d0c:	b008      	add	sp, #32
c0d01d0e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d10:	6820      	ldr	r0, [r4, #0]
c0d01d12:	2104      	movs	r1, #4
c0d01d14:	f001 fb7a 	bl	c0d0340c <longjmp>
c0d01d18:	60000ea6 	.word	0x60000ea6
c0d01d1c:	20001bb8 	.word	0x20001bb8
c0d01d20:	90000e46 	.word	0x90000e46

c0d01d24 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01d24:	b5b0      	push	{r4, r5, r7, lr}
c0d01d26:	af02      	add	r7, sp, #8
c0d01d28:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01d2a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d54 <cx_ecfp_init_public_key+0x30>)
c0d01d2c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d2e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d58 <cx_ecfp_init_public_key+0x34>)
c0d01d30:	6825      	ldr	r5, [r4, #0]
c0d01d32:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01d34:	ad02      	add	r5, sp, #8
c0d01d36:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01d38:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d3a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d3c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d3e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01d40:	4906      	ldr	r1, [pc, #24]	; (c0d01d5c <cx_ecfp_init_public_key+0x38>)
c0d01d42:	9a00      	ldr	r2, [sp, #0]
c0d01d44:	428a      	cmp	r2, r1
c0d01d46:	d101      	bne.n	c0d01d4c <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d48:	b006      	add	sp, #24
c0d01d4a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d4c:	6820      	ldr	r0, [r4, #0]
c0d01d4e:	2104      	movs	r1, #4
c0d01d50:	f001 fb5c 	bl	c0d0340c <longjmp>
c0d01d54:	60002835 	.word	0x60002835
c0d01d58:	20001bb8 	.word	0x20001bb8
c0d01d5c:	900028f0 	.word	0x900028f0

c0d01d60 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01d60:	b5b0      	push	{r4, r5, r7, lr}
c0d01d62:	af02      	add	r7, sp, #8
c0d01d64:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01d66:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d90 <cx_ecfp_init_private_key+0x30>)
c0d01d68:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d6a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01d94 <cx_ecfp_init_private_key+0x34>)
c0d01d6c:	6825      	ldr	r5, [r4, #0]
c0d01d6e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01d70:	ad02      	add	r5, sp, #8
c0d01d72:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01d74:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d76:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d78:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d7a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01d7c:	4906      	ldr	r1, [pc, #24]	; (c0d01d98 <cx_ecfp_init_private_key+0x38>)
c0d01d7e:	9a00      	ldr	r2, [sp, #0]
c0d01d80:	428a      	cmp	r2, r1
c0d01d82:	d101      	bne.n	c0d01d88 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01d84:	b006      	add	sp, #24
c0d01d86:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d88:	6820      	ldr	r0, [r4, #0]
c0d01d8a:	2104      	movs	r1, #4
c0d01d8c:	f001 fb3e 	bl	c0d0340c <longjmp>
c0d01d90:	600029ed 	.word	0x600029ed
c0d01d94:	20001bb8 	.word	0x20001bb8
c0d01d98:	900029ae 	.word	0x900029ae

c0d01d9c <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01d9c:	b5b0      	push	{r4, r5, r7, lr}
c0d01d9e:	af02      	add	r7, sp, #8
c0d01da0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01da2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01dcc <cx_ecfp_generate_pair+0x30>)
c0d01da4:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01da6:	4c0a      	ldr	r4, [pc, #40]	; (c0d01dd0 <cx_ecfp_generate_pair+0x34>)
c0d01da8:	6825      	ldr	r5, [r4, #0]
c0d01daa:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01dac:	ad02      	add	r5, sp, #8
c0d01dae:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01db0:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01db2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01db4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01db6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01db8:	4906      	ldr	r1, [pc, #24]	; (c0d01dd4 <cx_ecfp_generate_pair+0x38>)
c0d01dba:	9a00      	ldr	r2, [sp, #0]
c0d01dbc:	428a      	cmp	r2, r1
c0d01dbe:	d101      	bne.n	c0d01dc4 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01dc0:	b006      	add	sp, #24
c0d01dc2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01dc4:	6820      	ldr	r0, [r4, #0]
c0d01dc6:	2104      	movs	r1, #4
c0d01dc8:	f001 fb20 	bl	c0d0340c <longjmp>
c0d01dcc:	60002a2e 	.word	0x60002a2e
c0d01dd0:	20001bb8 	.word	0x20001bb8
c0d01dd4:	90002a74 	.word	0x90002a74

c0d01dd8 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01dd8:	b5b0      	push	{r4, r5, r7, lr}
c0d01dda:	af02      	add	r7, sp, #8
c0d01ddc:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01dde:	4c0b      	ldr	r4, [pc, #44]	; (c0d01e0c <os_perso_derive_node_bip32+0x34>)
c0d01de0:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01de2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01e10 <os_perso_derive_node_bip32+0x38>)
c0d01de4:	6825      	ldr	r5, [r4, #0]
c0d01de6:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01de8:	ad03      	add	r5, sp, #12
c0d01dea:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01dec:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01dee:	9007      	str	r0, [sp, #28]
c0d01df0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01df2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01df4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01df6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01df8:	4806      	ldr	r0, [pc, #24]	; (c0d01e14 <os_perso_derive_node_bip32+0x3c>)
c0d01dfa:	9901      	ldr	r1, [sp, #4]
c0d01dfc:	4281      	cmp	r1, r0
c0d01dfe:	d101      	bne.n	c0d01e04 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e00:	b008      	add	sp, #32
c0d01e02:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e04:	6820      	ldr	r0, [r4, #0]
c0d01e06:	2104      	movs	r1, #4
c0d01e08:	f001 fb00 	bl	c0d0340c <longjmp>
c0d01e0c:	6000512b 	.word	0x6000512b
c0d01e10:	20001bb8 	.word	0x20001bb8
c0d01e14:	9000517f 	.word	0x9000517f

c0d01e18 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01e18:	b580      	push	{r7, lr}
c0d01e1a:	af00      	add	r7, sp, #0
c0d01e1c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01e1e:	490a      	ldr	r1, [pc, #40]	; (c0d01e48 <os_sched_exit+0x30>)
c0d01e20:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e22:	490a      	ldr	r1, [pc, #40]	; (c0d01e4c <os_sched_exit+0x34>)
c0d01e24:	680a      	ldr	r2, [r1, #0]
c0d01e26:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01e28:	9003      	str	r0, [sp, #12]
c0d01e2a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e2c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e2e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e30:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01e32:	4807      	ldr	r0, [pc, #28]	; (c0d01e50 <os_sched_exit+0x38>)
c0d01e34:	9a01      	ldr	r2, [sp, #4]
c0d01e36:	4282      	cmp	r2, r0
c0d01e38:	d101      	bne.n	c0d01e3e <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01e3a:	b004      	add	sp, #16
c0d01e3c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e3e:	6808      	ldr	r0, [r1, #0]
c0d01e40:	2104      	movs	r1, #4
c0d01e42:	f001 fae3 	bl	c0d0340c <longjmp>
c0d01e46:	46c0      	nop			; (mov r8, r8)
c0d01e48:	60005fe1 	.word	0x60005fe1
c0d01e4c:	20001bb8 	.word	0x20001bb8
c0d01e50:	90005f6f 	.word	0x90005f6f

c0d01e54 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01e54:	b580      	push	{r7, lr}
c0d01e56:	af00      	add	r7, sp, #0
c0d01e58:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01e5a:	490a      	ldr	r1, [pc, #40]	; (c0d01e84 <os_ux+0x30>)
c0d01e5c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e5e:	490a      	ldr	r1, [pc, #40]	; (c0d01e88 <os_ux+0x34>)
c0d01e60:	680a      	ldr	r2, [r1, #0]
c0d01e62:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01e64:	9003      	str	r0, [sp, #12]
c0d01e66:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e68:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e6a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e6c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01e6e:	4a07      	ldr	r2, [pc, #28]	; (c0d01e8c <os_ux+0x38>)
c0d01e70:	9b01      	ldr	r3, [sp, #4]
c0d01e72:	4293      	cmp	r3, r2
c0d01e74:	d101      	bne.n	c0d01e7a <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01e76:	b004      	add	sp, #16
c0d01e78:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e7a:	6808      	ldr	r0, [r1, #0]
c0d01e7c:	2104      	movs	r1, #4
c0d01e7e:	f001 fac5 	bl	c0d0340c <longjmp>
c0d01e82:	46c0      	nop			; (mov r8, r8)
c0d01e84:	60006158 	.word	0x60006158
c0d01e88:	20001bb8 	.word	0x20001bb8
c0d01e8c:	9000611f 	.word	0x9000611f

c0d01e90 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01e90:	b580      	push	{r7, lr}
c0d01e92:	af00      	add	r7, sp, #0
c0d01e94:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01e96:	4809      	ldr	r0, [pc, #36]	; (c0d01ebc <os_seph_features+0x2c>)
c0d01e98:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e9a:	4909      	ldr	r1, [pc, #36]	; (c0d01ec0 <os_seph_features+0x30>)
c0d01e9c:	6808      	ldr	r0, [r1, #0]
c0d01e9e:	9001      	str	r0, [sp, #4]
c0d01ea0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ea2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ea4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ea6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01ea8:	4a06      	ldr	r2, [pc, #24]	; (c0d01ec4 <os_seph_features+0x34>)
c0d01eaa:	9b00      	ldr	r3, [sp, #0]
c0d01eac:	4293      	cmp	r3, r2
c0d01eae:	d101      	bne.n	c0d01eb4 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01eb0:	b002      	add	sp, #8
c0d01eb2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01eb4:	6808      	ldr	r0, [r1, #0]
c0d01eb6:	2104      	movs	r1, #4
c0d01eb8:	f001 faa8 	bl	c0d0340c <longjmp>
c0d01ebc:	600064d6 	.word	0x600064d6
c0d01ec0:	20001bb8 	.word	0x20001bb8
c0d01ec4:	90006444 	.word	0x90006444

c0d01ec8 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01ec8:	b580      	push	{r7, lr}
c0d01eca:	af00      	add	r7, sp, #0
c0d01ecc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01ece:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ef8 <io_seproxyhal_spi_send+0x30>)
c0d01ed0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ed2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01efc <io_seproxyhal_spi_send+0x34>)
c0d01ed4:	6813      	ldr	r3, [r2, #0]
c0d01ed6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01ed8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01eda:	9103      	str	r1, [sp, #12]
c0d01edc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ede:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ee0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ee2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01ee4:	4806      	ldr	r0, [pc, #24]	; (c0d01f00 <io_seproxyhal_spi_send+0x38>)
c0d01ee6:	9900      	ldr	r1, [sp, #0]
c0d01ee8:	4281      	cmp	r1, r0
c0d01eea:	d101      	bne.n	c0d01ef0 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01eec:	b004      	add	sp, #16
c0d01eee:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ef0:	6810      	ldr	r0, [r2, #0]
c0d01ef2:	2104      	movs	r1, #4
c0d01ef4:	f001 fa8a 	bl	c0d0340c <longjmp>
c0d01ef8:	60006a1c 	.word	0x60006a1c
c0d01efc:	20001bb8 	.word	0x20001bb8
c0d01f00:	90006af3 	.word	0x90006af3

c0d01f04 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01f04:	b580      	push	{r7, lr}
c0d01f06:	af00      	add	r7, sp, #0
c0d01f08:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01f0a:	4809      	ldr	r0, [pc, #36]	; (c0d01f30 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01f0c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f0e:	4909      	ldr	r1, [pc, #36]	; (c0d01f34 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01f10:	6808      	ldr	r0, [r1, #0]
c0d01f12:	9001      	str	r0, [sp, #4]
c0d01f14:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f16:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f18:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f1a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01f1c:	4a06      	ldr	r2, [pc, #24]	; (c0d01f38 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01f1e:	9b00      	ldr	r3, [sp, #0]
c0d01f20:	4293      	cmp	r3, r2
c0d01f22:	d101      	bne.n	c0d01f28 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01f24:	b002      	add	sp, #8
c0d01f26:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f28:	6808      	ldr	r0, [r1, #0]
c0d01f2a:	2104      	movs	r1, #4
c0d01f2c:	f001 fa6e 	bl	c0d0340c <longjmp>
c0d01f30:	60006bcf 	.word	0x60006bcf
c0d01f34:	20001bb8 	.word	0x20001bb8
c0d01f38:	90006b7f 	.word	0x90006b7f

c0d01f3c <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01f3c:	b5d0      	push	{r4, r6, r7, lr}
c0d01f3e:	af02      	add	r7, sp, #8
c0d01f40:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01f42:	4b0b      	ldr	r3, [pc, #44]	; (c0d01f70 <io_seproxyhal_spi_recv+0x34>)
c0d01f44:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f46:	4b0b      	ldr	r3, [pc, #44]	; (c0d01f74 <io_seproxyhal_spi_recv+0x38>)
c0d01f48:	681c      	ldr	r4, [r3, #0]
c0d01f4a:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01f4c:	ac03      	add	r4, sp, #12
c0d01f4e:	c407      	stmia	r4!, {r0, r1, r2}
c0d01f50:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f52:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f54:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f56:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01f58:	4907      	ldr	r1, [pc, #28]	; (c0d01f78 <io_seproxyhal_spi_recv+0x3c>)
c0d01f5a:	9a01      	ldr	r2, [sp, #4]
c0d01f5c:	428a      	cmp	r2, r1
c0d01f5e:	d102      	bne.n	c0d01f66 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01f60:	b280      	uxth	r0, r0
c0d01f62:	b006      	add	sp, #24
c0d01f64:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f66:	6818      	ldr	r0, [r3, #0]
c0d01f68:	2104      	movs	r1, #4
c0d01f6a:	f001 fa4f 	bl	c0d0340c <longjmp>
c0d01f6e:	46c0      	nop			; (mov r8, r8)
c0d01f70:	60006cd1 	.word	0x60006cd1
c0d01f74:	20001bb8 	.word	0x20001bb8
c0d01f78:	90006c2b 	.word	0x90006c2b

c0d01f7c <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01f7c:	b5b0      	push	{r4, r5, r7, lr}
c0d01f7e:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01f80:	492c      	ldr	r1, [pc, #176]	; (c0d02034 <bagl_ui_nanos_screen1_button+0xb8>)
c0d01f82:	4288      	cmp	r0, r1
c0d01f84:	d006      	beq.n	c0d01f94 <bagl_ui_nanos_screen1_button+0x18>
c0d01f86:	492c      	ldr	r1, [pc, #176]	; (c0d02038 <bagl_ui_nanos_screen1_button+0xbc>)
c0d01f88:	4288      	cmp	r0, r1
c0d01f8a:	d151      	bne.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01f8c:	2000      	movs	r0, #0
c0d01f8e:	f7ff ff43 	bl	c0d01e18 <os_sched_exit>
c0d01f92:	e04d      	b.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01f94:	f7fe fba4 	bl	c0d006e0 <nvram_is_init>
c0d01f98:	2801      	cmp	r0, #1
c0d01f9a:	d102      	bne.n	c0d01fa2 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01f9c:	a029      	add	r0, pc, #164	; (adr r0, c0d02044 <bagl_ui_nanos_screen1_button+0xc8>)
c0d01f9e:	210d      	movs	r1, #13
c0d01fa0:	e001      	b.n	c0d01fa6 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01fa2:	a026      	add	r0, pc, #152	; (adr r0, c0d0203c <bagl_ui_nanos_screen1_button+0xc0>)
c0d01fa4:	2105      	movs	r1, #5
c0d01fa6:	2203      	movs	r2, #3
c0d01fa8:	f7fe f87c 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01fac:	4c29      	ldr	r4, [pc, #164]	; (c0d02054 <bagl_ui_nanos_screen1_button+0xd8>)
c0d01fae:	482b      	ldr	r0, [pc, #172]	; (c0d0205c <bagl_ui_nanos_screen1_button+0xe0>)
c0d01fb0:	4478      	add	r0, pc
c0d01fb2:	6020      	str	r0, [r4, #0]
c0d01fb4:	2004      	movs	r0, #4
c0d01fb6:	6060      	str	r0, [r4, #4]
c0d01fb8:	4829      	ldr	r0, [pc, #164]	; (c0d02060 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01fba:	4478      	add	r0, pc
c0d01fbc:	6120      	str	r0, [r4, #16]
c0d01fbe:	2500      	movs	r5, #0
c0d01fc0:	60e5      	str	r5, [r4, #12]
c0d01fc2:	2003      	movs	r0, #3
c0d01fc4:	7620      	strb	r0, [r4, #24]
c0d01fc6:	61e5      	str	r5, [r4, #28]
c0d01fc8:	4620      	mov	r0, r4
c0d01fca:	3018      	adds	r0, #24
c0d01fcc:	f7ff ff42 	bl	c0d01e54 <os_ux>
c0d01fd0:	61e0      	str	r0, [r4, #28]
c0d01fd2:	f7ff f903 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d01fd6:	60a5      	str	r5, [r4, #8]
c0d01fd8:	6820      	ldr	r0, [r4, #0]
c0d01fda:	2800      	cmp	r0, #0
c0d01fdc:	d028      	beq.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
c0d01fde:	69e0      	ldr	r0, [r4, #28]
c0d01fe0:	491d      	ldr	r1, [pc, #116]	; (c0d02058 <bagl_ui_nanos_screen1_button+0xdc>)
c0d01fe2:	4288      	cmp	r0, r1
c0d01fe4:	d116      	bne.n	c0d02014 <bagl_ui_nanos_screen1_button+0x98>
c0d01fe6:	e023      	b.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
c0d01fe8:	6860      	ldr	r0, [r4, #4]
c0d01fea:	4285      	cmp	r5, r0
c0d01fec:	d220      	bcs.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
c0d01fee:	f7ff ff89 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d01ff2:	2800      	cmp	r0, #0
c0d01ff4:	d11c      	bne.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ff6:	68a0      	ldr	r0, [r4, #8]
c0d01ff8:	68e1      	ldr	r1, [r4, #12]
c0d01ffa:	2538      	movs	r5, #56	; 0x38
c0d01ffc:	4368      	muls	r0, r5
c0d01ffe:	6822      	ldr	r2, [r4, #0]
c0d02000:	1810      	adds	r0, r2, r0
c0d02002:	2900      	cmp	r1, #0
c0d02004:	d009      	beq.n	c0d0201a <bagl_ui_nanos_screen1_button+0x9e>
c0d02006:	4788      	blx	r1
c0d02008:	2800      	cmp	r0, #0
c0d0200a:	d106      	bne.n	c0d0201a <bagl_ui_nanos_screen1_button+0x9e>
c0d0200c:	68a0      	ldr	r0, [r4, #8]
c0d0200e:	1c45      	adds	r5, r0, #1
c0d02010:	60a5      	str	r5, [r4, #8]
c0d02012:	6820      	ldr	r0, [r4, #0]
c0d02014:	2800      	cmp	r0, #0
c0d02016:	d1e7      	bne.n	c0d01fe8 <bagl_ui_nanos_screen1_button+0x6c>
c0d02018:	e00a      	b.n	c0d02030 <bagl_ui_nanos_screen1_button+0xb4>
c0d0201a:	2801      	cmp	r0, #1
c0d0201c:	d103      	bne.n	c0d02026 <bagl_ui_nanos_screen1_button+0xaa>
c0d0201e:	68a0      	ldr	r0, [r4, #8]
c0d02020:	4345      	muls	r5, r0
c0d02022:	6820      	ldr	r0, [r4, #0]
c0d02024:	1940      	adds	r0, r0, r5
c0d02026:	f7fe fb91 	bl	c0d0074c <io_seproxyhal_display>
c0d0202a:	68a0      	ldr	r0, [r4, #8]
c0d0202c:	1c40      	adds	r0, r0, #1
c0d0202e:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d02030:	2000      	movs	r0, #0
c0d02032:	bdb0      	pop	{r4, r5, r7, pc}
c0d02034:	80000002 	.word	0x80000002
c0d02038:	80000001 	.word	0x80000001
c0d0203c:	54494e49 	.word	0x54494e49
c0d02040:	00000000 	.word	0x00000000
c0d02044:	6c697453 	.word	0x6c697453
c0d02048:	6e75206c 	.word	0x6e75206c
c0d0204c:	74696e69 	.word	0x74696e69
c0d02050:	00000000 	.word	0x00000000
c0d02054:	20001a98 	.word	0x20001a98
c0d02058:	b0105044 	.word	0xb0105044
c0d0205c:	00001694 	.word	0x00001694
c0d02060:	00000153 	.word	0x00000153

c0d02064 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02064:	b5b0      	push	{r4, r5, r7, lr}
c0d02066:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02068:	2800      	cmp	r0, #0
c0d0206a:	d005      	beq.n	c0d02078 <ui_display_debug+0x14>
c0d0206c:	2900      	cmp	r1, #0
c0d0206e:	d003      	beq.n	c0d02078 <ui_display_debug+0x14>
c0d02070:	2a00      	cmp	r2, #0
c0d02072:	d001      	beq.n	c0d02078 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02074:	f7fe f816 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02078:	4c21      	ldr	r4, [pc, #132]	; (c0d02100 <ui_display_debug+0x9c>)
c0d0207a:	4823      	ldr	r0, [pc, #140]	; (c0d02108 <ui_display_debug+0xa4>)
c0d0207c:	4478      	add	r0, pc
c0d0207e:	6020      	str	r0, [r4, #0]
c0d02080:	2004      	movs	r0, #4
c0d02082:	6060      	str	r0, [r4, #4]
c0d02084:	4821      	ldr	r0, [pc, #132]	; (c0d0210c <ui_display_debug+0xa8>)
c0d02086:	4478      	add	r0, pc
c0d02088:	6120      	str	r0, [r4, #16]
c0d0208a:	2500      	movs	r5, #0
c0d0208c:	60e5      	str	r5, [r4, #12]
c0d0208e:	2003      	movs	r0, #3
c0d02090:	7620      	strb	r0, [r4, #24]
c0d02092:	61e5      	str	r5, [r4, #28]
c0d02094:	4620      	mov	r0, r4
c0d02096:	3018      	adds	r0, #24
c0d02098:	f7ff fedc 	bl	c0d01e54 <os_ux>
c0d0209c:	61e0      	str	r0, [r4, #28]
c0d0209e:	f7ff f89d 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d020a2:	60a5      	str	r5, [r4, #8]
c0d020a4:	6820      	ldr	r0, [r4, #0]
c0d020a6:	2800      	cmp	r0, #0
c0d020a8:	d028      	beq.n	c0d020fc <ui_display_debug+0x98>
c0d020aa:	69e0      	ldr	r0, [r4, #28]
c0d020ac:	4915      	ldr	r1, [pc, #84]	; (c0d02104 <ui_display_debug+0xa0>)
c0d020ae:	4288      	cmp	r0, r1
c0d020b0:	d116      	bne.n	c0d020e0 <ui_display_debug+0x7c>
c0d020b2:	e023      	b.n	c0d020fc <ui_display_debug+0x98>
c0d020b4:	6860      	ldr	r0, [r4, #4]
c0d020b6:	4285      	cmp	r5, r0
c0d020b8:	d220      	bcs.n	c0d020fc <ui_display_debug+0x98>
c0d020ba:	f7ff ff23 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d020be:	2800      	cmp	r0, #0
c0d020c0:	d11c      	bne.n	c0d020fc <ui_display_debug+0x98>
c0d020c2:	68a0      	ldr	r0, [r4, #8]
c0d020c4:	68e1      	ldr	r1, [r4, #12]
c0d020c6:	2538      	movs	r5, #56	; 0x38
c0d020c8:	4368      	muls	r0, r5
c0d020ca:	6822      	ldr	r2, [r4, #0]
c0d020cc:	1810      	adds	r0, r2, r0
c0d020ce:	2900      	cmp	r1, #0
c0d020d0:	d009      	beq.n	c0d020e6 <ui_display_debug+0x82>
c0d020d2:	4788      	blx	r1
c0d020d4:	2800      	cmp	r0, #0
c0d020d6:	d106      	bne.n	c0d020e6 <ui_display_debug+0x82>
c0d020d8:	68a0      	ldr	r0, [r4, #8]
c0d020da:	1c45      	adds	r5, r0, #1
c0d020dc:	60a5      	str	r5, [r4, #8]
c0d020de:	6820      	ldr	r0, [r4, #0]
c0d020e0:	2800      	cmp	r0, #0
c0d020e2:	d1e7      	bne.n	c0d020b4 <ui_display_debug+0x50>
c0d020e4:	e00a      	b.n	c0d020fc <ui_display_debug+0x98>
c0d020e6:	2801      	cmp	r0, #1
c0d020e8:	d103      	bne.n	c0d020f2 <ui_display_debug+0x8e>
c0d020ea:	68a0      	ldr	r0, [r4, #8]
c0d020ec:	4345      	muls	r5, r0
c0d020ee:	6820      	ldr	r0, [r4, #0]
c0d020f0:	1940      	adds	r0, r0, r5
c0d020f2:	f7fe fb2b 	bl	c0d0074c <io_seproxyhal_display>
c0d020f6:	68a0      	ldr	r0, [r4, #8]
c0d020f8:	1c40      	adds	r0, r0, #1
c0d020fa:	60a0      	str	r0, [r4, #8]
}
c0d020fc:	bdb0      	pop	{r4, r5, r7, pc}
c0d020fe:	46c0      	nop			; (mov r8, r8)
c0d02100:	20001a98 	.word	0x20001a98
c0d02104:	b0105044 	.word	0xb0105044
c0d02108:	000015c8 	.word	0x000015c8
c0d0210c:	00000087 	.word	0x00000087

c0d02110 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02110:	b580      	push	{r7, lr}
c0d02112:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d02114:	4905      	ldr	r1, [pc, #20]	; (c0d0212c <bagl_ui_nanos_screen2_button+0x1c>)
c0d02116:	4288      	cmp	r0, r1
c0d02118:	d002      	beq.n	c0d02120 <bagl_ui_nanos_screen2_button+0x10>
c0d0211a:	4905      	ldr	r1, [pc, #20]	; (c0d02130 <bagl_ui_nanos_screen2_button+0x20>)
c0d0211c:	4288      	cmp	r0, r1
c0d0211e:	d102      	bne.n	c0d02126 <bagl_ui_nanos_screen2_button+0x16>
c0d02120:	2000      	movs	r0, #0
c0d02122:	f7ff fe79 	bl	c0d01e18 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d02126:	2000      	movs	r0, #0
c0d02128:	bd80      	pop	{r7, pc}
c0d0212a:	46c0      	nop			; (mov r8, r8)
c0d0212c:	80000002 	.word	0x80000002
c0d02130:	80000001 	.word	0x80000001

c0d02134 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d02134:	b5b0      	push	{r4, r5, r7, lr}
c0d02136:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02138:	2001      	movs	r0, #1
c0d0213a:	0204      	lsls	r4, r0, #8
c0d0213c:	f7ff fea8 	bl	c0d01e90 <os_seph_features>
c0d02140:	4220      	tst	r0, r4
c0d02142:	d136      	bne.n	c0d021b2 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02144:	4c3c      	ldr	r4, [pc, #240]	; (c0d02238 <ui_idle+0x104>)
c0d02146:	4840      	ldr	r0, [pc, #256]	; (c0d02248 <ui_idle+0x114>)
c0d02148:	4478      	add	r0, pc
c0d0214a:	6020      	str	r0, [r4, #0]
c0d0214c:	2004      	movs	r0, #4
c0d0214e:	6060      	str	r0, [r4, #4]
c0d02150:	483e      	ldr	r0, [pc, #248]	; (c0d0224c <ui_idle+0x118>)
c0d02152:	4478      	add	r0, pc
c0d02154:	6120      	str	r0, [r4, #16]
c0d02156:	2500      	movs	r5, #0
c0d02158:	60e5      	str	r5, [r4, #12]
c0d0215a:	2003      	movs	r0, #3
c0d0215c:	7620      	strb	r0, [r4, #24]
c0d0215e:	61e5      	str	r5, [r4, #28]
c0d02160:	4620      	mov	r0, r4
c0d02162:	3018      	adds	r0, #24
c0d02164:	f7ff fe76 	bl	c0d01e54 <os_ux>
c0d02168:	61e0      	str	r0, [r4, #28]
c0d0216a:	f7ff f837 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d0216e:	60a5      	str	r5, [r4, #8]
c0d02170:	6820      	ldr	r0, [r4, #0]
c0d02172:	2800      	cmp	r0, #0
c0d02174:	d05f      	beq.n	c0d02236 <ui_idle+0x102>
c0d02176:	69e0      	ldr	r0, [r4, #28]
c0d02178:	4930      	ldr	r1, [pc, #192]	; (c0d0223c <ui_idle+0x108>)
c0d0217a:	4288      	cmp	r0, r1
c0d0217c:	d116      	bne.n	c0d021ac <ui_idle+0x78>
c0d0217e:	e05a      	b.n	c0d02236 <ui_idle+0x102>
c0d02180:	6860      	ldr	r0, [r4, #4]
c0d02182:	4285      	cmp	r5, r0
c0d02184:	d257      	bcs.n	c0d02236 <ui_idle+0x102>
c0d02186:	f7ff febd 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d0218a:	2800      	cmp	r0, #0
c0d0218c:	d153      	bne.n	c0d02236 <ui_idle+0x102>
c0d0218e:	68a0      	ldr	r0, [r4, #8]
c0d02190:	68e1      	ldr	r1, [r4, #12]
c0d02192:	2538      	movs	r5, #56	; 0x38
c0d02194:	4368      	muls	r0, r5
c0d02196:	6822      	ldr	r2, [r4, #0]
c0d02198:	1810      	adds	r0, r2, r0
c0d0219a:	2900      	cmp	r1, #0
c0d0219c:	d040      	beq.n	c0d02220 <ui_idle+0xec>
c0d0219e:	4788      	blx	r1
c0d021a0:	2800      	cmp	r0, #0
c0d021a2:	d13d      	bne.n	c0d02220 <ui_idle+0xec>
c0d021a4:	68a0      	ldr	r0, [r4, #8]
c0d021a6:	1c45      	adds	r5, r0, #1
c0d021a8:	60a5      	str	r5, [r4, #8]
c0d021aa:	6820      	ldr	r0, [r4, #0]
c0d021ac:	2800      	cmp	r0, #0
c0d021ae:	d1e7      	bne.n	c0d02180 <ui_idle+0x4c>
c0d021b0:	e041      	b.n	c0d02236 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d021b2:	4c21      	ldr	r4, [pc, #132]	; (c0d02238 <ui_idle+0x104>)
c0d021b4:	4822      	ldr	r0, [pc, #136]	; (c0d02240 <ui_idle+0x10c>)
c0d021b6:	4478      	add	r0, pc
c0d021b8:	6020      	str	r0, [r4, #0]
c0d021ba:	2004      	movs	r0, #4
c0d021bc:	6060      	str	r0, [r4, #4]
c0d021be:	4821      	ldr	r0, [pc, #132]	; (c0d02244 <ui_idle+0x110>)
c0d021c0:	4478      	add	r0, pc
c0d021c2:	6120      	str	r0, [r4, #16]
c0d021c4:	2500      	movs	r5, #0
c0d021c6:	60e5      	str	r5, [r4, #12]
c0d021c8:	2003      	movs	r0, #3
c0d021ca:	7620      	strb	r0, [r4, #24]
c0d021cc:	61e5      	str	r5, [r4, #28]
c0d021ce:	4620      	mov	r0, r4
c0d021d0:	3018      	adds	r0, #24
c0d021d2:	f7ff fe3f 	bl	c0d01e54 <os_ux>
c0d021d6:	61e0      	str	r0, [r4, #28]
c0d021d8:	f7ff f800 	bl	c0d011dc <io_seproxyhal_init_ux>
c0d021dc:	60a5      	str	r5, [r4, #8]
c0d021de:	6820      	ldr	r0, [r4, #0]
c0d021e0:	2800      	cmp	r0, #0
c0d021e2:	d028      	beq.n	c0d02236 <ui_idle+0x102>
c0d021e4:	69e0      	ldr	r0, [r4, #28]
c0d021e6:	4915      	ldr	r1, [pc, #84]	; (c0d0223c <ui_idle+0x108>)
c0d021e8:	4288      	cmp	r0, r1
c0d021ea:	d116      	bne.n	c0d0221a <ui_idle+0xe6>
c0d021ec:	e023      	b.n	c0d02236 <ui_idle+0x102>
c0d021ee:	6860      	ldr	r0, [r4, #4]
c0d021f0:	4285      	cmp	r5, r0
c0d021f2:	d220      	bcs.n	c0d02236 <ui_idle+0x102>
c0d021f4:	f7ff fe86 	bl	c0d01f04 <io_seproxyhal_spi_is_status_sent>
c0d021f8:	2800      	cmp	r0, #0
c0d021fa:	d11c      	bne.n	c0d02236 <ui_idle+0x102>
c0d021fc:	68a0      	ldr	r0, [r4, #8]
c0d021fe:	68e1      	ldr	r1, [r4, #12]
c0d02200:	2538      	movs	r5, #56	; 0x38
c0d02202:	4368      	muls	r0, r5
c0d02204:	6822      	ldr	r2, [r4, #0]
c0d02206:	1810      	adds	r0, r2, r0
c0d02208:	2900      	cmp	r1, #0
c0d0220a:	d009      	beq.n	c0d02220 <ui_idle+0xec>
c0d0220c:	4788      	blx	r1
c0d0220e:	2800      	cmp	r0, #0
c0d02210:	d106      	bne.n	c0d02220 <ui_idle+0xec>
c0d02212:	68a0      	ldr	r0, [r4, #8]
c0d02214:	1c45      	adds	r5, r0, #1
c0d02216:	60a5      	str	r5, [r4, #8]
c0d02218:	6820      	ldr	r0, [r4, #0]
c0d0221a:	2800      	cmp	r0, #0
c0d0221c:	d1e7      	bne.n	c0d021ee <ui_idle+0xba>
c0d0221e:	e00a      	b.n	c0d02236 <ui_idle+0x102>
c0d02220:	2801      	cmp	r0, #1
c0d02222:	d103      	bne.n	c0d0222c <ui_idle+0xf8>
c0d02224:	68a0      	ldr	r0, [r4, #8]
c0d02226:	4345      	muls	r5, r0
c0d02228:	6820      	ldr	r0, [r4, #0]
c0d0222a:	1940      	adds	r0, r0, r5
c0d0222c:	f7fe fa8e 	bl	c0d0074c <io_seproxyhal_display>
c0d02230:	68a0      	ldr	r0, [r4, #8]
c0d02232:	1c40      	adds	r0, r0, #1
c0d02234:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d02236:	bdb0      	pop	{r4, r5, r7, pc}
c0d02238:	20001a98 	.word	0x20001a98
c0d0223c:	b0105044 	.word	0xb0105044
c0d02240:	0000156e 	.word	0x0000156e
c0d02244:	0000008d 	.word	0x0000008d
c0d02248:	0000141c 	.word	0x0000141c
c0d0224c:	fffffe27 	.word	0xfffffe27

c0d02250 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02250:	2000      	movs	r0, #0
c0d02252:	4770      	bx	lr

c0d02254 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02254:	b5d0      	push	{r4, r6, r7, lr}
c0d02256:	af02      	add	r7, sp, #8
c0d02258:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0225a:	4620      	mov	r0, r4
c0d0225c:	f7ff fddc 	bl	c0d01e18 <os_sched_exit>
    return NULL;
c0d02260:	4620      	mov	r0, r4
c0d02262:	bdd0      	pop	{r4, r6, r7, pc}

c0d02264 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02264:	4902      	ldr	r1, [pc, #8]	; (c0d02270 <USBD_LL_Init+0xc>)
c0d02266:	2000      	movs	r0, #0
c0d02268:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0226a:	4902      	ldr	r1, [pc, #8]	; (c0d02274 <USBD_LL_Init+0x10>)
c0d0226c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0226e:	4770      	bx	lr
c0d02270:	20001d2c 	.word	0x20001d2c
c0d02274:	20001d30 	.word	0x20001d30

c0d02278 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02278:	b5d0      	push	{r4, r6, r7, lr}
c0d0227a:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0227c:	4806      	ldr	r0, [pc, #24]	; (c0d02298 <USBD_LL_DeInit+0x20>)
c0d0227e:	214f      	movs	r1, #79	; 0x4f
c0d02280:	7001      	strb	r1, [r0, #0]
c0d02282:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02284:	7044      	strb	r4, [r0, #1]
c0d02286:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02288:	7081      	strb	r1, [r0, #2]
c0d0228a:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0228c:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0228e:	2104      	movs	r1, #4
c0d02290:	f7ff fe1a 	bl	c0d01ec8 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02294:	4620      	mov	r0, r4
c0d02296:	bdd0      	pop	{r4, r6, r7, pc}
c0d02298:	20001a18 	.word	0x20001a18

c0d0229c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0229c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0229e:	af03      	add	r7, sp, #12
c0d022a0:	b083      	sub	sp, #12
c0d022a2:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d022a4:	264f      	movs	r6, #79	; 0x4f
c0d022a6:	702e      	strb	r6, [r5, #0]
c0d022a8:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022aa:	706c      	strb	r4, [r5, #1]
c0d022ac:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d022ae:	70a8      	strb	r0, [r5, #2]
c0d022b0:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d022b2:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d022b4:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d022b6:	2105      	movs	r1, #5
c0d022b8:	4628      	mov	r0, r5
c0d022ba:	f7ff fe05 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d022be:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d022c0:	706c      	strb	r4, [r5, #1]
c0d022c2:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d022c4:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d022c6:	70e8      	strb	r0, [r5, #3]
c0d022c8:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d022ca:	4628      	mov	r0, r5
c0d022cc:	f7ff fdfc 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d022d0:	4620      	mov	r0, r4
c0d022d2:	b003      	add	sp, #12
c0d022d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d022d6 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d022d6:	b5d0      	push	{r4, r6, r7, lr}
c0d022d8:	af02      	add	r7, sp, #8
c0d022da:	b082      	sub	sp, #8
c0d022dc:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d022de:	214f      	movs	r1, #79	; 0x4f
c0d022e0:	7001      	strb	r1, [r0, #0]
c0d022e2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022e4:	7044      	strb	r4, [r0, #1]
c0d022e6:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d022e8:	7081      	strb	r1, [r0, #2]
c0d022ea:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d022ec:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d022ee:	2104      	movs	r1, #4
c0d022f0:	f7ff fdea 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d022f4:	4620      	mov	r0, r4
c0d022f6:	b002      	add	sp, #8
c0d022f8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d022fc <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d022fc:	b5b0      	push	{r4, r5, r7, lr}
c0d022fe:	af02      	add	r7, sp, #8
c0d02300:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d02302:	480f      	ldr	r0, [pc, #60]	; (c0d02340 <USBD_LL_OpenEP+0x44>)
c0d02304:	2400      	movs	r4, #0
c0d02306:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02308:	480e      	ldr	r0, [pc, #56]	; (c0d02344 <USBD_LL_OpenEP+0x48>)
c0d0230a:	6004      	str	r4, [r0, #0]
c0d0230c:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0230e:	254f      	movs	r5, #79	; 0x4f
c0d02310:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d02312:	7044      	strb	r4, [r0, #1]
c0d02314:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d02316:	7085      	strb	r5, [r0, #2]
c0d02318:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0231a:	70c5      	strb	r5, [r0, #3]
c0d0231c:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d0231e:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02320:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d02322:	2a03      	cmp	r2, #3
c0d02324:	d802      	bhi.n	c0d0232c <USBD_LL_OpenEP+0x30>
c0d02326:	00d0      	lsls	r0, r2, #3
c0d02328:	4c07      	ldr	r4, [pc, #28]	; (c0d02348 <USBD_LL_OpenEP+0x4c>)
c0d0232a:	40c4      	lsrs	r4, r0
c0d0232c:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d0232e:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02330:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02332:	2108      	movs	r1, #8
c0d02334:	f7ff fdc8 	bl	c0d01ec8 <io_seproxyhal_spi_send>
c0d02338:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0233a:	b002      	add	sp, #8
c0d0233c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0233e:	46c0      	nop			; (mov r8, r8)
c0d02340:	20001d2c 	.word	0x20001d2c
c0d02344:	20001d30 	.word	0x20001d30
c0d02348:	02030401 	.word	0x02030401

c0d0234c <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0234c:	b5d0      	push	{r4, r6, r7, lr}
c0d0234e:	af02      	add	r7, sp, #8
c0d02350:	b082      	sub	sp, #8
c0d02352:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02354:	224f      	movs	r2, #79	; 0x4f
c0d02356:	7002      	strb	r2, [r0, #0]
c0d02358:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0235a:	7044      	strb	r4, [r0, #1]
c0d0235c:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0235e:	7082      	strb	r2, [r0, #2]
c0d02360:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02362:	70c2      	strb	r2, [r0, #3]
c0d02364:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02366:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02368:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d0236a:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d0236c:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0236e:	2108      	movs	r1, #8
c0d02370:	f7ff fdaa 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02374:	4620      	mov	r0, r4
c0d02376:	b002      	add	sp, #8
c0d02378:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0237c <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d0237c:	b5b0      	push	{r4, r5, r7, lr}
c0d0237e:	af02      	add	r7, sp, #8
c0d02380:	b082      	sub	sp, #8
c0d02382:	460d      	mov	r5, r1
c0d02384:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02386:	2150      	movs	r1, #80	; 0x50
c0d02388:	7001      	strb	r1, [r0, #0]
c0d0238a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0238c:	7044      	strb	r4, [r0, #1]
c0d0238e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02390:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02392:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02394:	2140      	movs	r1, #64	; 0x40
c0d02396:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02398:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0239a:	2106      	movs	r1, #6
c0d0239c:	f7ff fd94 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d023a0:	2080      	movs	r0, #128	; 0x80
c0d023a2:	4205      	tst	r5, r0
c0d023a4:	d101      	bne.n	c0d023aa <USBD_LL_StallEP+0x2e>
c0d023a6:	4807      	ldr	r0, [pc, #28]	; (c0d023c4 <USBD_LL_StallEP+0x48>)
c0d023a8:	e000      	b.n	c0d023ac <USBD_LL_StallEP+0x30>
c0d023aa:	4805      	ldr	r0, [pc, #20]	; (c0d023c0 <USBD_LL_StallEP+0x44>)
c0d023ac:	6801      	ldr	r1, [r0, #0]
c0d023ae:	227f      	movs	r2, #127	; 0x7f
c0d023b0:	4015      	ands	r5, r2
c0d023b2:	2201      	movs	r2, #1
c0d023b4:	40aa      	lsls	r2, r5
c0d023b6:	430a      	orrs	r2, r1
c0d023b8:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d023ba:	4620      	mov	r0, r4
c0d023bc:	b002      	add	sp, #8
c0d023be:	bdb0      	pop	{r4, r5, r7, pc}
c0d023c0:	20001d2c 	.word	0x20001d2c
c0d023c4:	20001d30 	.word	0x20001d30

c0d023c8 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d023c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d023ca:	af03      	add	r7, sp, #12
c0d023cc:	b083      	sub	sp, #12
c0d023ce:	460d      	mov	r5, r1
c0d023d0:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d023d2:	2150      	movs	r1, #80	; 0x50
c0d023d4:	7001      	strb	r1, [r0, #0]
c0d023d6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d023d8:	7044      	strb	r4, [r0, #1]
c0d023da:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d023dc:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d023de:	70c5      	strb	r5, [r0, #3]
c0d023e0:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d023e2:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d023e4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d023e6:	2106      	movs	r1, #6
c0d023e8:	f7ff fd6e 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d023ec:	4235      	tst	r5, r6
c0d023ee:	d101      	bne.n	c0d023f4 <USBD_LL_ClearStallEP+0x2c>
c0d023f0:	4807      	ldr	r0, [pc, #28]	; (c0d02410 <USBD_LL_ClearStallEP+0x48>)
c0d023f2:	e000      	b.n	c0d023f6 <USBD_LL_ClearStallEP+0x2e>
c0d023f4:	4805      	ldr	r0, [pc, #20]	; (c0d0240c <USBD_LL_ClearStallEP+0x44>)
c0d023f6:	6801      	ldr	r1, [r0, #0]
c0d023f8:	227f      	movs	r2, #127	; 0x7f
c0d023fa:	4015      	ands	r5, r2
c0d023fc:	2201      	movs	r2, #1
c0d023fe:	40aa      	lsls	r2, r5
c0d02400:	4391      	bics	r1, r2
c0d02402:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02404:	4620      	mov	r0, r4
c0d02406:	b003      	add	sp, #12
c0d02408:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0240a:	46c0      	nop			; (mov r8, r8)
c0d0240c:	20001d2c 	.word	0x20001d2c
c0d02410:	20001d30 	.word	0x20001d30

c0d02414 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02414:	2080      	movs	r0, #128	; 0x80
c0d02416:	4201      	tst	r1, r0
c0d02418:	d001      	beq.n	c0d0241e <USBD_LL_IsStallEP+0xa>
c0d0241a:	4806      	ldr	r0, [pc, #24]	; (c0d02434 <USBD_LL_IsStallEP+0x20>)
c0d0241c:	e000      	b.n	c0d02420 <USBD_LL_IsStallEP+0xc>
c0d0241e:	4804      	ldr	r0, [pc, #16]	; (c0d02430 <USBD_LL_IsStallEP+0x1c>)
c0d02420:	6800      	ldr	r0, [r0, #0]
c0d02422:	227f      	movs	r2, #127	; 0x7f
c0d02424:	4011      	ands	r1, r2
c0d02426:	2201      	movs	r2, #1
c0d02428:	408a      	lsls	r2, r1
c0d0242a:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d0242c:	b2d0      	uxtb	r0, r2
c0d0242e:	4770      	bx	lr
c0d02430:	20001d30 	.word	0x20001d30
c0d02434:	20001d2c 	.word	0x20001d2c

c0d02438 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02438:	b5d0      	push	{r4, r6, r7, lr}
c0d0243a:	af02      	add	r7, sp, #8
c0d0243c:	b082      	sub	sp, #8
c0d0243e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02440:	224f      	movs	r2, #79	; 0x4f
c0d02442:	7002      	strb	r2, [r0, #0]
c0d02444:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02446:	7044      	strb	r4, [r0, #1]
c0d02448:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0244a:	7082      	strb	r2, [r0, #2]
c0d0244c:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0244e:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02450:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02452:	2105      	movs	r1, #5
c0d02454:	f7ff fd38 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02458:	4620      	mov	r0, r4
c0d0245a:	b002      	add	sp, #8
c0d0245c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0245e <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d0245e:	b5b0      	push	{r4, r5, r7, lr}
c0d02460:	af02      	add	r7, sp, #8
c0d02462:	b082      	sub	sp, #8
c0d02464:	461c      	mov	r4, r3
c0d02466:	4615      	mov	r5, r2
c0d02468:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0246a:	2250      	movs	r2, #80	; 0x50
c0d0246c:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0246e:	1ce2      	adds	r2, r4, #3
c0d02470:	0a13      	lsrs	r3, r2, #8
c0d02472:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02474:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02476:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02478:	2120      	movs	r1, #32
c0d0247a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d0247c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0247e:	2106      	movs	r1, #6
c0d02480:	f7ff fd22 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02484:	4628      	mov	r0, r5
c0d02486:	4621      	mov	r1, r4
c0d02488:	f7ff fd1e 	bl	c0d01ec8 <io_seproxyhal_spi_send>
c0d0248c:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0248e:	b002      	add	sp, #8
c0d02490:	bdb0      	pop	{r4, r5, r7, pc}

c0d02492 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02492:	b5d0      	push	{r4, r6, r7, lr}
c0d02494:	af02      	add	r7, sp, #8
c0d02496:	b082      	sub	sp, #8
c0d02498:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0249a:	2350      	movs	r3, #80	; 0x50
c0d0249c:	7003      	strb	r3, [r0, #0]
c0d0249e:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d024a0:	7044      	strb	r4, [r0, #1]
c0d024a2:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d024a4:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d024a6:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d024a8:	2130      	movs	r1, #48	; 0x30
c0d024aa:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d024ac:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d024ae:	2106      	movs	r1, #6
c0d024b0:	f7ff fd0a 	bl	c0d01ec8 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d024b4:	4620      	mov	r0, r4
c0d024b6:	b002      	add	sp, #8
c0d024b8:	bdd0      	pop	{r4, r6, r7, pc}

c0d024ba <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d024ba:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d024bc:	af03      	add	r7, sp, #12
c0d024be:	b081      	sub	sp, #4
c0d024c0:	4615      	mov	r5, r2
c0d024c2:	460e      	mov	r6, r1
c0d024c4:	4604      	mov	r4, r0
c0d024c6:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d024c8:	2c00      	cmp	r4, #0
c0d024ca:	d011      	beq.n	c0d024f0 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d024cc:	2049      	movs	r0, #73	; 0x49
c0d024ce:	0081      	lsls	r1, r0, #2
c0d024d0:	4620      	mov	r0, r4
c0d024d2:	f000 fef9 	bl	c0d032c8 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d024d6:	2e00      	cmp	r6, #0
c0d024d8:	d002      	beq.n	c0d024e0 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d024da:	2011      	movs	r0, #17
c0d024dc:	0100      	lsls	r0, r0, #4
c0d024de:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d024e0:	20fc      	movs	r0, #252	; 0xfc
c0d024e2:	2101      	movs	r1, #1
c0d024e4:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d024e6:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d024e8:	4620      	mov	r0, r4
c0d024ea:	f7ff febb 	bl	c0d02264 <USBD_LL_Init>
c0d024ee:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d024f0:	b2c0      	uxtb	r0, r0
c0d024f2:	b001      	add	sp, #4
c0d024f4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024f6 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d024f6:	b5d0      	push	{r4, r6, r7, lr}
c0d024f8:	af02      	add	r7, sp, #8
c0d024fa:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d024fc:	20fc      	movs	r0, #252	; 0xfc
c0d024fe:	2101      	movs	r1, #1
c0d02500:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02502:	2045      	movs	r0, #69	; 0x45
c0d02504:	0080      	lsls	r0, r0, #2
c0d02506:	5820      	ldr	r0, [r4, r0]
c0d02508:	2800      	cmp	r0, #0
c0d0250a:	d006      	beq.n	c0d0251a <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d0250c:	6840      	ldr	r0, [r0, #4]
c0d0250e:	f7ff fb1f 	bl	c0d01b50 <pic>
c0d02512:	4602      	mov	r2, r0
c0d02514:	7921      	ldrb	r1, [r4, #4]
c0d02516:	4620      	mov	r0, r4
c0d02518:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0251a:	4620      	mov	r0, r4
c0d0251c:	f7ff fedb 	bl	c0d022d6 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02520:	4620      	mov	r0, r4
c0d02522:	f7ff fea9 	bl	c0d02278 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02526:	2000      	movs	r0, #0
c0d02528:	bdd0      	pop	{r4, r6, r7, pc}

c0d0252a <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0252a:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d0252c:	2900      	cmp	r1, #0
c0d0252e:	d003      	beq.n	c0d02538 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02530:	2245      	movs	r2, #69	; 0x45
c0d02532:	0092      	lsls	r2, r2, #2
c0d02534:	5081      	str	r1, [r0, r2]
c0d02536:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02538:	b2d0      	uxtb	r0, r2
c0d0253a:	4770      	bx	lr

c0d0253c <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d0253c:	b580      	push	{r7, lr}
c0d0253e:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02540:	f7ff feac 	bl	c0d0229c <USBD_LL_Start>
  
  return USBD_OK;  
c0d02544:	2000      	movs	r0, #0
c0d02546:	bd80      	pop	{r7, pc}

c0d02548 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02548:	b5b0      	push	{r4, r5, r7, lr}
c0d0254a:	af02      	add	r7, sp, #8
c0d0254c:	460c      	mov	r4, r1
c0d0254e:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02550:	2045      	movs	r0, #69	; 0x45
c0d02552:	0080      	lsls	r0, r0, #2
c0d02554:	5828      	ldr	r0, [r5, r0]
c0d02556:	2800      	cmp	r0, #0
c0d02558:	d00c      	beq.n	c0d02574 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d0255a:	6800      	ldr	r0, [r0, #0]
c0d0255c:	f7ff faf8 	bl	c0d01b50 <pic>
c0d02560:	4602      	mov	r2, r0
c0d02562:	4628      	mov	r0, r5
c0d02564:	4621      	mov	r1, r4
c0d02566:	4790      	blx	r2
c0d02568:	4601      	mov	r1, r0
c0d0256a:	2002      	movs	r0, #2
c0d0256c:	2900      	cmp	r1, #0
c0d0256e:	d100      	bne.n	c0d02572 <USBD_SetClassConfig+0x2a>
c0d02570:	4608      	mov	r0, r1
c0d02572:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02574:	2002      	movs	r0, #2
c0d02576:	bdb0      	pop	{r4, r5, r7, pc}

c0d02578 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02578:	b5b0      	push	{r4, r5, r7, lr}
c0d0257a:	af02      	add	r7, sp, #8
c0d0257c:	460c      	mov	r4, r1
c0d0257e:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02580:	2045      	movs	r0, #69	; 0x45
c0d02582:	0080      	lsls	r0, r0, #2
c0d02584:	5828      	ldr	r0, [r5, r0]
c0d02586:	2800      	cmp	r0, #0
c0d02588:	d006      	beq.n	c0d02598 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0258a:	6840      	ldr	r0, [r0, #4]
c0d0258c:	f7ff fae0 	bl	c0d01b50 <pic>
c0d02590:	4602      	mov	r2, r0
c0d02592:	4628      	mov	r0, r5
c0d02594:	4621      	mov	r1, r4
c0d02596:	4790      	blx	r2
  }
  return USBD_OK;
c0d02598:	2000      	movs	r0, #0
c0d0259a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0259c <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d0259c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0259e:	af03      	add	r7, sp, #12
c0d025a0:	b081      	sub	sp, #4
c0d025a2:	4604      	mov	r4, r0
c0d025a4:	2021      	movs	r0, #33	; 0x21
c0d025a6:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d025a8:	19a5      	adds	r5, r4, r6
c0d025aa:	4628      	mov	r0, r5
c0d025ac:	f000 fb69 	bl	c0d02c82 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d025b0:	20f4      	movs	r0, #244	; 0xf4
c0d025b2:	2101      	movs	r1, #1
c0d025b4:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d025b6:	2087      	movs	r0, #135	; 0x87
c0d025b8:	0040      	lsls	r0, r0, #1
c0d025ba:	5a20      	ldrh	r0, [r4, r0]
c0d025bc:	21f8      	movs	r1, #248	; 0xf8
c0d025be:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d025c0:	5da1      	ldrb	r1, [r4, r6]
c0d025c2:	201f      	movs	r0, #31
c0d025c4:	4008      	ands	r0, r1
c0d025c6:	2802      	cmp	r0, #2
c0d025c8:	d008      	beq.n	c0d025dc <USBD_LL_SetupStage+0x40>
c0d025ca:	2801      	cmp	r0, #1
c0d025cc:	d00b      	beq.n	c0d025e6 <USBD_LL_SetupStage+0x4a>
c0d025ce:	2800      	cmp	r0, #0
c0d025d0:	d10e      	bne.n	c0d025f0 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d025d2:	4620      	mov	r0, r4
c0d025d4:	4629      	mov	r1, r5
c0d025d6:	f000 f8f1 	bl	c0d027bc <USBD_StdDevReq>
c0d025da:	e00e      	b.n	c0d025fa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d025dc:	4620      	mov	r0, r4
c0d025de:	4629      	mov	r1, r5
c0d025e0:	f000 fad3 	bl	c0d02b8a <USBD_StdEPReq>
c0d025e4:	e009      	b.n	c0d025fa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d025e6:	4620      	mov	r0, r4
c0d025e8:	4629      	mov	r1, r5
c0d025ea:	f000 faa6 	bl	c0d02b3a <USBD_StdItfReq>
c0d025ee:	e004      	b.n	c0d025fa <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d025f0:	2080      	movs	r0, #128	; 0x80
c0d025f2:	4001      	ands	r1, r0
c0d025f4:	4620      	mov	r0, r4
c0d025f6:	f7ff fec1 	bl	c0d0237c <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d025fa:	2000      	movs	r0, #0
c0d025fc:	b001      	add	sp, #4
c0d025fe:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02600 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02600:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02602:	af03      	add	r7, sp, #12
c0d02604:	b081      	sub	sp, #4
c0d02606:	4615      	mov	r5, r2
c0d02608:	460e      	mov	r6, r1
c0d0260a:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d0260c:	2e00      	cmp	r6, #0
c0d0260e:	d011      	beq.n	c0d02634 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02610:	2045      	movs	r0, #69	; 0x45
c0d02612:	0080      	lsls	r0, r0, #2
c0d02614:	5820      	ldr	r0, [r4, r0]
c0d02616:	6980      	ldr	r0, [r0, #24]
c0d02618:	2800      	cmp	r0, #0
c0d0261a:	d034      	beq.n	c0d02686 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0261c:	21fc      	movs	r1, #252	; 0xfc
c0d0261e:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02620:	2903      	cmp	r1, #3
c0d02622:	d130      	bne.n	c0d02686 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02624:	f7ff fa94 	bl	c0d01b50 <pic>
c0d02628:	4603      	mov	r3, r0
c0d0262a:	4620      	mov	r0, r4
c0d0262c:	4631      	mov	r1, r6
c0d0262e:	462a      	mov	r2, r5
c0d02630:	4798      	blx	r3
c0d02632:	e028      	b.n	c0d02686 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02634:	20f4      	movs	r0, #244	; 0xf4
c0d02636:	5820      	ldr	r0, [r4, r0]
c0d02638:	2803      	cmp	r0, #3
c0d0263a:	d124      	bne.n	c0d02686 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d0263c:	2090      	movs	r0, #144	; 0x90
c0d0263e:	5820      	ldr	r0, [r4, r0]
c0d02640:	218c      	movs	r1, #140	; 0x8c
c0d02642:	5861      	ldr	r1, [r4, r1]
c0d02644:	4622      	mov	r2, r4
c0d02646:	328c      	adds	r2, #140	; 0x8c
c0d02648:	4281      	cmp	r1, r0
c0d0264a:	d90a      	bls.n	c0d02662 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d0264c:	1a09      	subs	r1, r1, r0
c0d0264e:	6011      	str	r1, [r2, #0]
c0d02650:	4281      	cmp	r1, r0
c0d02652:	d300      	bcc.n	c0d02656 <USBD_LL_DataOutStage+0x56>
c0d02654:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02656:	b28a      	uxth	r2, r1
c0d02658:	4620      	mov	r0, r4
c0d0265a:	4629      	mov	r1, r5
c0d0265c:	f000 fc70 	bl	c0d02f40 <USBD_CtlContinueRx>
c0d02660:	e011      	b.n	c0d02686 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02662:	2045      	movs	r0, #69	; 0x45
c0d02664:	0080      	lsls	r0, r0, #2
c0d02666:	5820      	ldr	r0, [r4, r0]
c0d02668:	6900      	ldr	r0, [r0, #16]
c0d0266a:	2800      	cmp	r0, #0
c0d0266c:	d008      	beq.n	c0d02680 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0266e:	21fc      	movs	r1, #252	; 0xfc
c0d02670:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02672:	2903      	cmp	r1, #3
c0d02674:	d104      	bne.n	c0d02680 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02676:	f7ff fa6b 	bl	c0d01b50 <pic>
c0d0267a:	4601      	mov	r1, r0
c0d0267c:	4620      	mov	r0, r4
c0d0267e:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02680:	4620      	mov	r0, r4
c0d02682:	f000 fc65 	bl	c0d02f50 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02686:	2000      	movs	r0, #0
c0d02688:	b001      	add	sp, #4
c0d0268a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0268c <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d0268c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0268e:	af03      	add	r7, sp, #12
c0d02690:	b081      	sub	sp, #4
c0d02692:	460d      	mov	r5, r1
c0d02694:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02696:	2d00      	cmp	r5, #0
c0d02698:	d012      	beq.n	c0d026c0 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0269a:	2045      	movs	r0, #69	; 0x45
c0d0269c:	0080      	lsls	r0, r0, #2
c0d0269e:	5820      	ldr	r0, [r4, r0]
c0d026a0:	2800      	cmp	r0, #0
c0d026a2:	d054      	beq.n	c0d0274e <USBD_LL_DataInStage+0xc2>
c0d026a4:	6940      	ldr	r0, [r0, #20]
c0d026a6:	2800      	cmp	r0, #0
c0d026a8:	d051      	beq.n	c0d0274e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d026aa:	21fc      	movs	r1, #252	; 0xfc
c0d026ac:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d026ae:	2903      	cmp	r1, #3
c0d026b0:	d14d      	bne.n	c0d0274e <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d026b2:	f7ff fa4d 	bl	c0d01b50 <pic>
c0d026b6:	4602      	mov	r2, r0
c0d026b8:	4620      	mov	r0, r4
c0d026ba:	4629      	mov	r1, r5
c0d026bc:	4790      	blx	r2
c0d026be:	e046      	b.n	c0d0274e <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d026c0:	20f4      	movs	r0, #244	; 0xf4
c0d026c2:	5820      	ldr	r0, [r4, r0]
c0d026c4:	2802      	cmp	r0, #2
c0d026c6:	d13a      	bne.n	c0d0273e <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d026c8:	69e0      	ldr	r0, [r4, #28]
c0d026ca:	6a25      	ldr	r5, [r4, #32]
c0d026cc:	42a8      	cmp	r0, r5
c0d026ce:	d90b      	bls.n	c0d026e8 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d026d0:	1b40      	subs	r0, r0, r5
c0d026d2:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d026d4:	2109      	movs	r1, #9
c0d026d6:	014a      	lsls	r2, r1, #5
c0d026d8:	58a1      	ldr	r1, [r4, r2]
c0d026da:	1949      	adds	r1, r1, r5
c0d026dc:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d026de:	b282      	uxth	r2, r0
c0d026e0:	4620      	mov	r0, r4
c0d026e2:	f000 fc1e 	bl	c0d02f22 <USBD_CtlContinueSendData>
c0d026e6:	e02a      	b.n	c0d0273e <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d026e8:	69a6      	ldr	r6, [r4, #24]
c0d026ea:	4630      	mov	r0, r6
c0d026ec:	4629      	mov	r1, r5
c0d026ee:	f000 fccf 	bl	c0d03090 <__aeabi_uidivmod>
c0d026f2:	42ae      	cmp	r6, r5
c0d026f4:	d30f      	bcc.n	c0d02716 <USBD_LL_DataInStage+0x8a>
c0d026f6:	2900      	cmp	r1, #0
c0d026f8:	d10d      	bne.n	c0d02716 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d026fa:	20f8      	movs	r0, #248	; 0xf8
c0d026fc:	5820      	ldr	r0, [r4, r0]
c0d026fe:	4625      	mov	r5, r4
c0d02700:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02702:	4286      	cmp	r6, r0
c0d02704:	d207      	bcs.n	c0d02716 <USBD_LL_DataInStage+0x8a>
c0d02706:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02708:	4620      	mov	r0, r4
c0d0270a:	4631      	mov	r1, r6
c0d0270c:	4632      	mov	r2, r6
c0d0270e:	f000 fc08 	bl	c0d02f22 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02712:	602e      	str	r6, [r5, #0]
c0d02714:	e013      	b.n	c0d0273e <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02716:	2045      	movs	r0, #69	; 0x45
c0d02718:	0080      	lsls	r0, r0, #2
c0d0271a:	5820      	ldr	r0, [r4, r0]
c0d0271c:	2800      	cmp	r0, #0
c0d0271e:	d00b      	beq.n	c0d02738 <USBD_LL_DataInStage+0xac>
c0d02720:	68c0      	ldr	r0, [r0, #12]
c0d02722:	2800      	cmp	r0, #0
c0d02724:	d008      	beq.n	c0d02738 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02726:	21fc      	movs	r1, #252	; 0xfc
c0d02728:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0272a:	2903      	cmp	r1, #3
c0d0272c:	d104      	bne.n	c0d02738 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d0272e:	f7ff fa0f 	bl	c0d01b50 <pic>
c0d02732:	4601      	mov	r1, r0
c0d02734:	4620      	mov	r0, r4
c0d02736:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02738:	4620      	mov	r0, r4
c0d0273a:	f000 fc16 	bl	c0d02f6a <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d0273e:	2001      	movs	r0, #1
c0d02740:	0201      	lsls	r1, r0, #8
c0d02742:	1860      	adds	r0, r4, r1
c0d02744:	5c61      	ldrb	r1, [r4, r1]
c0d02746:	2901      	cmp	r1, #1
c0d02748:	d101      	bne.n	c0d0274e <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d0274a:	2100      	movs	r1, #0
c0d0274c:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d0274e:	2000      	movs	r0, #0
c0d02750:	b001      	add	sp, #4
c0d02752:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02754 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02754:	b5d0      	push	{r4, r6, r7, lr}
c0d02756:	af02      	add	r7, sp, #8
c0d02758:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d0275a:	2090      	movs	r0, #144	; 0x90
c0d0275c:	2140      	movs	r1, #64	; 0x40
c0d0275e:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02760:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02762:	20fc      	movs	r0, #252	; 0xfc
c0d02764:	2101      	movs	r1, #1
c0d02766:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02768:	2045      	movs	r0, #69	; 0x45
c0d0276a:	0080      	lsls	r0, r0, #2
c0d0276c:	5820      	ldr	r0, [r4, r0]
c0d0276e:	2800      	cmp	r0, #0
c0d02770:	d006      	beq.n	c0d02780 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02772:	6840      	ldr	r0, [r0, #4]
c0d02774:	f7ff f9ec 	bl	c0d01b50 <pic>
c0d02778:	4602      	mov	r2, r0
c0d0277a:	7921      	ldrb	r1, [r4, #4]
c0d0277c:	4620      	mov	r0, r4
c0d0277e:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02780:	2000      	movs	r0, #0
c0d02782:	bdd0      	pop	{r4, r6, r7, pc}

c0d02784 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02784:	7401      	strb	r1, [r0, #16]
c0d02786:	2000      	movs	r0, #0
  return USBD_OK;
c0d02788:	4770      	bx	lr

c0d0278a <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0278a:	2000      	movs	r0, #0
c0d0278c:	4770      	bx	lr

c0d0278e <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d0278e:	2000      	movs	r0, #0
c0d02790:	4770      	bx	lr

c0d02792 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02792:	b5d0      	push	{r4, r6, r7, lr}
c0d02794:	af02      	add	r7, sp, #8
c0d02796:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02798:	20fc      	movs	r0, #252	; 0xfc
c0d0279a:	5c20      	ldrb	r0, [r4, r0]
c0d0279c:	2803      	cmp	r0, #3
c0d0279e:	d10a      	bne.n	c0d027b6 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d027a0:	2045      	movs	r0, #69	; 0x45
c0d027a2:	0080      	lsls	r0, r0, #2
c0d027a4:	5820      	ldr	r0, [r4, r0]
c0d027a6:	69c0      	ldr	r0, [r0, #28]
c0d027a8:	2800      	cmp	r0, #0
c0d027aa:	d004      	beq.n	c0d027b6 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d027ac:	f7ff f9d0 	bl	c0d01b50 <pic>
c0d027b0:	4601      	mov	r1, r0
c0d027b2:	4620      	mov	r0, r4
c0d027b4:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d027b6:	2000      	movs	r0, #0
c0d027b8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d027bc <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d027bc:	b5d0      	push	{r4, r6, r7, lr}
c0d027be:	af02      	add	r7, sp, #8
c0d027c0:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d027c2:	7848      	ldrb	r0, [r1, #1]
c0d027c4:	2809      	cmp	r0, #9
c0d027c6:	d810      	bhi.n	c0d027ea <USBD_StdDevReq+0x2e>
c0d027c8:	4478      	add	r0, pc
c0d027ca:	7900      	ldrb	r0, [r0, #4]
c0d027cc:	0040      	lsls	r0, r0, #1
c0d027ce:	4487      	add	pc, r0
c0d027d0:	150c0804 	.word	0x150c0804
c0d027d4:	0c25190c 	.word	0x0c25190c
c0d027d8:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d027da:	4620      	mov	r0, r4
c0d027dc:	f000 f938 	bl	c0d02a50 <USBD_GetStatus>
c0d027e0:	e01f      	b.n	c0d02822 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d027e2:	4620      	mov	r0, r4
c0d027e4:	f000 f976 	bl	c0d02ad4 <USBD_ClrFeature>
c0d027e8:	e01b      	b.n	c0d02822 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d027ea:	2180      	movs	r1, #128	; 0x80
c0d027ec:	4620      	mov	r0, r4
c0d027ee:	f7ff fdc5 	bl	c0d0237c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d027f2:	2100      	movs	r1, #0
c0d027f4:	4620      	mov	r0, r4
c0d027f6:	f7ff fdc1 	bl	c0d0237c <USBD_LL_StallEP>
c0d027fa:	e012      	b.n	c0d02822 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d027fc:	4620      	mov	r0, r4
c0d027fe:	f000 f950 	bl	c0d02aa2 <USBD_SetFeature>
c0d02802:	e00e      	b.n	c0d02822 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02804:	4620      	mov	r0, r4
c0d02806:	f000 f897 	bl	c0d02938 <USBD_SetAddress>
c0d0280a:	e00a      	b.n	c0d02822 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d0280c:	4620      	mov	r0, r4
c0d0280e:	f000 f8ff 	bl	c0d02a10 <USBD_GetConfig>
c0d02812:	e006      	b.n	c0d02822 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02814:	4620      	mov	r0, r4
c0d02816:	f000 f8bd 	bl	c0d02994 <USBD_SetConfig>
c0d0281a:	e002      	b.n	c0d02822 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d0281c:	4620      	mov	r0, r4
c0d0281e:	f000 f803 	bl	c0d02828 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02822:	2000      	movs	r0, #0
c0d02824:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02828 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02828:	b5b0      	push	{r4, r5, r7, lr}
c0d0282a:	af02      	add	r7, sp, #8
c0d0282c:	b082      	sub	sp, #8
c0d0282e:	460d      	mov	r5, r1
c0d02830:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02832:	8868      	ldrh	r0, [r5, #2]
c0d02834:	0a01      	lsrs	r1, r0, #8
c0d02836:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02838:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d0283a:	2a0e      	cmp	r2, #14
c0d0283c:	d83e      	bhi.n	c0d028bc <USBD_GetDescriptor+0x94>
c0d0283e:	46c0      	nop			; (mov r8, r8)
c0d02840:	447a      	add	r2, pc
c0d02842:	7912      	ldrb	r2, [r2, #4]
c0d02844:	0052      	lsls	r2, r2, #1
c0d02846:	4497      	add	pc, r2
c0d02848:	390c2607 	.word	0x390c2607
c0d0284c:	39362e39 	.word	0x39362e39
c0d02850:	39393939 	.word	0x39393939
c0d02854:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02858:	2011      	movs	r0, #17
c0d0285a:	0100      	lsls	r0, r0, #4
c0d0285c:	5820      	ldr	r0, [r4, r0]
c0d0285e:	6800      	ldr	r0, [r0, #0]
c0d02860:	e012      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02862:	b2c0      	uxtb	r0, r0
c0d02864:	2805      	cmp	r0, #5
c0d02866:	d829      	bhi.n	c0d028bc <USBD_GetDescriptor+0x94>
c0d02868:	4478      	add	r0, pc
c0d0286a:	7900      	ldrb	r0, [r0, #4]
c0d0286c:	0040      	lsls	r0, r0, #1
c0d0286e:	4487      	add	pc, r0
c0d02870:	544f4a02 	.word	0x544f4a02
c0d02874:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02876:	2011      	movs	r0, #17
c0d02878:	0100      	lsls	r0, r0, #4
c0d0287a:	5820      	ldr	r0, [r4, r0]
c0d0287c:	6840      	ldr	r0, [r0, #4]
c0d0287e:	e003      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02880:	2011      	movs	r0, #17
c0d02882:	0100      	lsls	r0, r0, #4
c0d02884:	5820      	ldr	r0, [r4, r0]
c0d02886:	69c0      	ldr	r0, [r0, #28]
c0d02888:	f7ff f962 	bl	c0d01b50 <pic>
c0d0288c:	4602      	mov	r2, r0
c0d0288e:	7c20      	ldrb	r0, [r4, #16]
c0d02890:	a901      	add	r1, sp, #4
c0d02892:	4790      	blx	r2
c0d02894:	e025      	b.n	c0d028e2 <USBD_GetDescriptor+0xba>
c0d02896:	2045      	movs	r0, #69	; 0x45
c0d02898:	0080      	lsls	r0, r0, #2
c0d0289a:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d0289c:	7c21      	ldrb	r1, [r4, #16]
c0d0289e:	2900      	cmp	r1, #0
c0d028a0:	d014      	beq.n	c0d028cc <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d028a2:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d028a4:	e018      	b.n	c0d028d8 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d028a6:	7c20      	ldrb	r0, [r4, #16]
c0d028a8:	2800      	cmp	r0, #0
c0d028aa:	d107      	bne.n	c0d028bc <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d028ac:	2045      	movs	r0, #69	; 0x45
c0d028ae:	0080      	lsls	r0, r0, #2
c0d028b0:	5820      	ldr	r0, [r4, r0]
c0d028b2:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d028b4:	e010      	b.n	c0d028d8 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d028b6:	7c20      	ldrb	r0, [r4, #16]
c0d028b8:	2800      	cmp	r0, #0
c0d028ba:	d009      	beq.n	c0d028d0 <USBD_GetDescriptor+0xa8>
c0d028bc:	4620      	mov	r0, r4
c0d028be:	f7ff fd5d 	bl	c0d0237c <USBD_LL_StallEP>
c0d028c2:	2100      	movs	r1, #0
c0d028c4:	4620      	mov	r0, r4
c0d028c6:	f7ff fd59 	bl	c0d0237c <USBD_LL_StallEP>
c0d028ca:	e01a      	b.n	c0d02902 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d028cc:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d028ce:	e003      	b.n	c0d028d8 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d028d0:	2045      	movs	r0, #69	; 0x45
c0d028d2:	0080      	lsls	r0, r0, #2
c0d028d4:	5820      	ldr	r0, [r4, r0]
c0d028d6:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d028d8:	f7ff f93a 	bl	c0d01b50 <pic>
c0d028dc:	4601      	mov	r1, r0
c0d028de:	a801      	add	r0, sp, #4
c0d028e0:	4788      	blx	r1
c0d028e2:	4601      	mov	r1, r0
c0d028e4:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d028e6:	8802      	ldrh	r2, [r0, #0]
c0d028e8:	2a00      	cmp	r2, #0
c0d028ea:	d00a      	beq.n	c0d02902 <USBD_GetDescriptor+0xda>
c0d028ec:	88e8      	ldrh	r0, [r5, #6]
c0d028ee:	2800      	cmp	r0, #0
c0d028f0:	d007      	beq.n	c0d02902 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d028f2:	4282      	cmp	r2, r0
c0d028f4:	d300      	bcc.n	c0d028f8 <USBD_GetDescriptor+0xd0>
c0d028f6:	4602      	mov	r2, r0
c0d028f8:	a801      	add	r0, sp, #4
c0d028fa:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d028fc:	4620      	mov	r0, r4
c0d028fe:	f000 faf9 	bl	c0d02ef4 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02902:	b002      	add	sp, #8
c0d02904:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02906:	2011      	movs	r0, #17
c0d02908:	0100      	lsls	r0, r0, #4
c0d0290a:	5820      	ldr	r0, [r4, r0]
c0d0290c:	6880      	ldr	r0, [r0, #8]
c0d0290e:	e7bb      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02910:	2011      	movs	r0, #17
c0d02912:	0100      	lsls	r0, r0, #4
c0d02914:	5820      	ldr	r0, [r4, r0]
c0d02916:	68c0      	ldr	r0, [r0, #12]
c0d02918:	e7b6      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d0291a:	2011      	movs	r0, #17
c0d0291c:	0100      	lsls	r0, r0, #4
c0d0291e:	5820      	ldr	r0, [r4, r0]
c0d02920:	6900      	ldr	r0, [r0, #16]
c0d02922:	e7b1      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02924:	2011      	movs	r0, #17
c0d02926:	0100      	lsls	r0, r0, #4
c0d02928:	5820      	ldr	r0, [r4, r0]
c0d0292a:	6940      	ldr	r0, [r0, #20]
c0d0292c:	e7ac      	b.n	c0d02888 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d0292e:	2011      	movs	r0, #17
c0d02930:	0100      	lsls	r0, r0, #4
c0d02932:	5820      	ldr	r0, [r4, r0]
c0d02934:	6980      	ldr	r0, [r0, #24]
c0d02936:	e7a7      	b.n	c0d02888 <USBD_GetDescriptor+0x60>

c0d02938 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02938:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0293a:	af03      	add	r7, sp, #12
c0d0293c:	b081      	sub	sp, #4
c0d0293e:	460a      	mov	r2, r1
c0d02940:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02942:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02944:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02946:	2800      	cmp	r0, #0
c0d02948:	d10b      	bne.n	c0d02962 <USBD_SetAddress+0x2a>
c0d0294a:	88d0      	ldrh	r0, [r2, #6]
c0d0294c:	2800      	cmp	r0, #0
c0d0294e:	d108      	bne.n	c0d02962 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02950:	8850      	ldrh	r0, [r2, #2]
c0d02952:	267f      	movs	r6, #127	; 0x7f
c0d02954:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02956:	20fc      	movs	r0, #252	; 0xfc
c0d02958:	5c20      	ldrb	r0, [r4, r0]
c0d0295a:	4625      	mov	r5, r4
c0d0295c:	35fc      	adds	r5, #252	; 0xfc
c0d0295e:	2803      	cmp	r0, #3
c0d02960:	d108      	bne.n	c0d02974 <USBD_SetAddress+0x3c>
c0d02962:	4620      	mov	r0, r4
c0d02964:	f7ff fd0a 	bl	c0d0237c <USBD_LL_StallEP>
c0d02968:	2100      	movs	r1, #0
c0d0296a:	4620      	mov	r0, r4
c0d0296c:	f7ff fd06 	bl	c0d0237c <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02970:	b001      	add	sp, #4
c0d02972:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02974:	20fe      	movs	r0, #254	; 0xfe
c0d02976:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02978:	b2f1      	uxtb	r1, r6
c0d0297a:	4620      	mov	r0, r4
c0d0297c:	f7ff fd5c 	bl	c0d02438 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02980:	4620      	mov	r0, r4
c0d02982:	f000 fae5 	bl	c0d02f50 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02986:	2002      	movs	r0, #2
c0d02988:	2101      	movs	r1, #1
c0d0298a:	2e00      	cmp	r6, #0
c0d0298c:	d100      	bne.n	c0d02990 <USBD_SetAddress+0x58>
c0d0298e:	4608      	mov	r0, r1
c0d02990:	7028      	strb	r0, [r5, #0]
c0d02992:	e7ed      	b.n	c0d02970 <USBD_SetAddress+0x38>

c0d02994 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02994:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02996:	af03      	add	r7, sp, #12
c0d02998:	b081      	sub	sp, #4
c0d0299a:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d0299c:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0299e:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d029a0:	2e02      	cmp	r6, #2
c0d029a2:	d21d      	bcs.n	c0d029e0 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d029a4:	20fc      	movs	r0, #252	; 0xfc
c0d029a6:	5c21      	ldrb	r1, [r4, r0]
c0d029a8:	4620      	mov	r0, r4
c0d029aa:	30fc      	adds	r0, #252	; 0xfc
c0d029ac:	2903      	cmp	r1, #3
c0d029ae:	d007      	beq.n	c0d029c0 <USBD_SetConfig+0x2c>
c0d029b0:	2902      	cmp	r1, #2
c0d029b2:	d115      	bne.n	c0d029e0 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d029b4:	2e00      	cmp	r6, #0
c0d029b6:	d026      	beq.n	c0d02a06 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d029b8:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d029ba:	2103      	movs	r1, #3
c0d029bc:	7001      	strb	r1, [r0, #0]
c0d029be:	e009      	b.n	c0d029d4 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d029c0:	2e00      	cmp	r6, #0
c0d029c2:	d016      	beq.n	c0d029f2 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d029c4:	6860      	ldr	r0, [r4, #4]
c0d029c6:	4286      	cmp	r6, r0
c0d029c8:	d01d      	beq.n	c0d02a06 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d029ca:	b2c1      	uxtb	r1, r0
c0d029cc:	4620      	mov	r0, r4
c0d029ce:	f7ff fdd3 	bl	c0d02578 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d029d2:	6066      	str	r6, [r4, #4]
c0d029d4:	4620      	mov	r0, r4
c0d029d6:	4631      	mov	r1, r6
c0d029d8:	f7ff fdb6 	bl	c0d02548 <USBD_SetClassConfig>
c0d029dc:	2802      	cmp	r0, #2
c0d029de:	d112      	bne.n	c0d02a06 <USBD_SetConfig+0x72>
c0d029e0:	4620      	mov	r0, r4
c0d029e2:	4629      	mov	r1, r5
c0d029e4:	f7ff fcca 	bl	c0d0237c <USBD_LL_StallEP>
c0d029e8:	2100      	movs	r1, #0
c0d029ea:	4620      	mov	r0, r4
c0d029ec:	f7ff fcc6 	bl	c0d0237c <USBD_LL_StallEP>
c0d029f0:	e00c      	b.n	c0d02a0c <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d029f2:	2102      	movs	r1, #2
c0d029f4:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d029f6:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d029f8:	4620      	mov	r0, r4
c0d029fa:	4631      	mov	r1, r6
c0d029fc:	f7ff fdbc 	bl	c0d02578 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02a00:	4620      	mov	r0, r4
c0d02a02:	f000 faa5 	bl	c0d02f50 <USBD_CtlSendStatus>
c0d02a06:	4620      	mov	r0, r4
c0d02a08:	f000 faa2 	bl	c0d02f50 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02a0c:	b001      	add	sp, #4
c0d02a0e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a10 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02a10:	b5d0      	push	{r4, r6, r7, lr}
c0d02a12:	af02      	add	r7, sp, #8
c0d02a14:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02a16:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a18:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02a1a:	2801      	cmp	r0, #1
c0d02a1c:	d10a      	bne.n	c0d02a34 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02a1e:	20fc      	movs	r0, #252	; 0xfc
c0d02a20:	5c20      	ldrb	r0, [r4, r0]
c0d02a22:	2803      	cmp	r0, #3
c0d02a24:	d00e      	beq.n	c0d02a44 <USBD_GetConfig+0x34>
c0d02a26:	2802      	cmp	r0, #2
c0d02a28:	d104      	bne.n	c0d02a34 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02a2a:	2000      	movs	r0, #0
c0d02a2c:	60a0      	str	r0, [r4, #8]
c0d02a2e:	4621      	mov	r1, r4
c0d02a30:	3108      	adds	r1, #8
c0d02a32:	e008      	b.n	c0d02a46 <USBD_GetConfig+0x36>
c0d02a34:	4620      	mov	r0, r4
c0d02a36:	f7ff fca1 	bl	c0d0237c <USBD_LL_StallEP>
c0d02a3a:	2100      	movs	r1, #0
c0d02a3c:	4620      	mov	r0, r4
c0d02a3e:	f7ff fc9d 	bl	c0d0237c <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02a42:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02a44:	1d21      	adds	r1, r4, #4
c0d02a46:	2201      	movs	r2, #1
c0d02a48:	4620      	mov	r0, r4
c0d02a4a:	f000 fa53 	bl	c0d02ef4 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02a4e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a50 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02a50:	b5b0      	push	{r4, r5, r7, lr}
c0d02a52:	af02      	add	r7, sp, #8
c0d02a54:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02a56:	20fc      	movs	r0, #252	; 0xfc
c0d02a58:	5c20      	ldrb	r0, [r4, r0]
c0d02a5a:	21fe      	movs	r1, #254	; 0xfe
c0d02a5c:	4001      	ands	r1, r0
c0d02a5e:	2902      	cmp	r1, #2
c0d02a60:	d116      	bne.n	c0d02a90 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02a62:	2001      	movs	r0, #1
c0d02a64:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02a66:	2041      	movs	r0, #65	; 0x41
c0d02a68:	0080      	lsls	r0, r0, #2
c0d02a6a:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02a6c:	4625      	mov	r5, r4
c0d02a6e:	350c      	adds	r5, #12
c0d02a70:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02a72:	2900      	cmp	r1, #0
c0d02a74:	d005      	beq.n	c0d02a82 <USBD_GetStatus+0x32>
c0d02a76:	4620      	mov	r0, r4
c0d02a78:	f000 fa77 	bl	c0d02f6a <USBD_CtlReceiveStatus>
c0d02a7c:	68e1      	ldr	r1, [r4, #12]
c0d02a7e:	2002      	movs	r0, #2
c0d02a80:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02a82:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02a84:	2202      	movs	r2, #2
c0d02a86:	4620      	mov	r0, r4
c0d02a88:	4629      	mov	r1, r5
c0d02a8a:	f000 fa33 	bl	c0d02ef4 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02a8e:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a90:	2180      	movs	r1, #128	; 0x80
c0d02a92:	4620      	mov	r0, r4
c0d02a94:	f7ff fc72 	bl	c0d0237c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02a98:	2100      	movs	r1, #0
c0d02a9a:	4620      	mov	r0, r4
c0d02a9c:	f7ff fc6e 	bl	c0d0237c <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02aa0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02aa2 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02aa2:	b5b0      	push	{r4, r5, r7, lr}
c0d02aa4:	af02      	add	r7, sp, #8
c0d02aa6:	460d      	mov	r5, r1
c0d02aa8:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02aaa:	8868      	ldrh	r0, [r5, #2]
c0d02aac:	2801      	cmp	r0, #1
c0d02aae:	d110      	bne.n	c0d02ad2 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02ab0:	2041      	movs	r0, #65	; 0x41
c0d02ab2:	0080      	lsls	r0, r0, #2
c0d02ab4:	2101      	movs	r1, #1
c0d02ab6:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02ab8:	2045      	movs	r0, #69	; 0x45
c0d02aba:	0080      	lsls	r0, r0, #2
c0d02abc:	5820      	ldr	r0, [r4, r0]
c0d02abe:	6880      	ldr	r0, [r0, #8]
c0d02ac0:	f7ff f846 	bl	c0d01b50 <pic>
c0d02ac4:	4602      	mov	r2, r0
c0d02ac6:	4620      	mov	r0, r4
c0d02ac8:	4629      	mov	r1, r5
c0d02aca:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02acc:	4620      	mov	r0, r4
c0d02ace:	f000 fa3f 	bl	c0d02f50 <USBD_CtlSendStatus>
  }

}
c0d02ad2:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ad4 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02ad4:	b5b0      	push	{r4, r5, r7, lr}
c0d02ad6:	af02      	add	r7, sp, #8
c0d02ad8:	460d      	mov	r5, r1
c0d02ada:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02adc:	20fc      	movs	r0, #252	; 0xfc
c0d02ade:	5c20      	ldrb	r0, [r4, r0]
c0d02ae0:	21fe      	movs	r1, #254	; 0xfe
c0d02ae2:	4001      	ands	r1, r0
c0d02ae4:	2902      	cmp	r1, #2
c0d02ae6:	d114      	bne.n	c0d02b12 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02ae8:	8868      	ldrh	r0, [r5, #2]
c0d02aea:	2801      	cmp	r0, #1
c0d02aec:	d119      	bne.n	c0d02b22 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02aee:	2041      	movs	r0, #65	; 0x41
c0d02af0:	0080      	lsls	r0, r0, #2
c0d02af2:	2100      	movs	r1, #0
c0d02af4:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02af6:	2045      	movs	r0, #69	; 0x45
c0d02af8:	0080      	lsls	r0, r0, #2
c0d02afa:	5820      	ldr	r0, [r4, r0]
c0d02afc:	6880      	ldr	r0, [r0, #8]
c0d02afe:	f7ff f827 	bl	c0d01b50 <pic>
c0d02b02:	4602      	mov	r2, r0
c0d02b04:	4620      	mov	r0, r4
c0d02b06:	4629      	mov	r1, r5
c0d02b08:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02b0a:	4620      	mov	r0, r4
c0d02b0c:	f000 fa20 	bl	c0d02f50 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02b10:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b12:	2180      	movs	r1, #128	; 0x80
c0d02b14:	4620      	mov	r0, r4
c0d02b16:	f7ff fc31 	bl	c0d0237c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02b1a:	2100      	movs	r1, #0
c0d02b1c:	4620      	mov	r0, r4
c0d02b1e:	f7ff fc2d 	bl	c0d0237c <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02b22:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b24 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02b24:	b5d0      	push	{r4, r6, r7, lr}
c0d02b26:	af02      	add	r7, sp, #8
c0d02b28:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b2a:	2180      	movs	r1, #128	; 0x80
c0d02b2c:	f7ff fc26 	bl	c0d0237c <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02b30:	2100      	movs	r1, #0
c0d02b32:	4620      	mov	r0, r4
c0d02b34:	f7ff fc22 	bl	c0d0237c <USBD_LL_StallEP>
}
c0d02b38:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b3a <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02b3a:	b5b0      	push	{r4, r5, r7, lr}
c0d02b3c:	af02      	add	r7, sp, #8
c0d02b3e:	460d      	mov	r5, r1
c0d02b40:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02b42:	20fc      	movs	r0, #252	; 0xfc
c0d02b44:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b46:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02b48:	2803      	cmp	r0, #3
c0d02b4a:	d115      	bne.n	c0d02b78 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02b4c:	88a8      	ldrh	r0, [r5, #4]
c0d02b4e:	22fe      	movs	r2, #254	; 0xfe
c0d02b50:	4002      	ands	r2, r0
c0d02b52:	2a01      	cmp	r2, #1
c0d02b54:	d810      	bhi.n	c0d02b78 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02b56:	2045      	movs	r0, #69	; 0x45
c0d02b58:	0080      	lsls	r0, r0, #2
c0d02b5a:	5820      	ldr	r0, [r4, r0]
c0d02b5c:	6880      	ldr	r0, [r0, #8]
c0d02b5e:	f7fe fff7 	bl	c0d01b50 <pic>
c0d02b62:	4602      	mov	r2, r0
c0d02b64:	4620      	mov	r0, r4
c0d02b66:	4629      	mov	r1, r5
c0d02b68:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02b6a:	88e8      	ldrh	r0, [r5, #6]
c0d02b6c:	2800      	cmp	r0, #0
c0d02b6e:	d10a      	bne.n	c0d02b86 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02b70:	4620      	mov	r0, r4
c0d02b72:	f000 f9ed 	bl	c0d02f50 <USBD_CtlSendStatus>
c0d02b76:	e006      	b.n	c0d02b86 <USBD_StdItfReq+0x4c>
c0d02b78:	4620      	mov	r0, r4
c0d02b7a:	f7ff fbff 	bl	c0d0237c <USBD_LL_StallEP>
c0d02b7e:	2100      	movs	r1, #0
c0d02b80:	4620      	mov	r0, r4
c0d02b82:	f7ff fbfb 	bl	c0d0237c <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02b86:	2000      	movs	r0, #0
c0d02b88:	bdb0      	pop	{r4, r5, r7, pc}

c0d02b8a <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02b8a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b8c:	af03      	add	r7, sp, #12
c0d02b8e:	b081      	sub	sp, #4
c0d02b90:	460e      	mov	r6, r1
c0d02b92:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02b94:	7830      	ldrb	r0, [r6, #0]
c0d02b96:	2160      	movs	r1, #96	; 0x60
c0d02b98:	4001      	ands	r1, r0
c0d02b9a:	2920      	cmp	r1, #32
c0d02b9c:	d10a      	bne.n	c0d02bb4 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02b9e:	2045      	movs	r0, #69	; 0x45
c0d02ba0:	0080      	lsls	r0, r0, #2
c0d02ba2:	5820      	ldr	r0, [r4, r0]
c0d02ba4:	6880      	ldr	r0, [r0, #8]
c0d02ba6:	f7fe ffd3 	bl	c0d01b50 <pic>
c0d02baa:	4602      	mov	r2, r0
c0d02bac:	4620      	mov	r0, r4
c0d02bae:	4631      	mov	r1, r6
c0d02bb0:	4790      	blx	r2
c0d02bb2:	e063      	b.n	c0d02c7c <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02bb4:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02bb6:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02bb8:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02bba:	2800      	cmp	r0, #0
c0d02bbc:	d012      	beq.n	c0d02be4 <USBD_StdEPReq+0x5a>
c0d02bbe:	2801      	cmp	r0, #1
c0d02bc0:	d019      	beq.n	c0d02bf6 <USBD_StdEPReq+0x6c>
c0d02bc2:	2803      	cmp	r0, #3
c0d02bc4:	d15a      	bne.n	c0d02c7c <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02bc6:	20fc      	movs	r0, #252	; 0xfc
c0d02bc8:	5c20      	ldrb	r0, [r4, r0]
c0d02bca:	2803      	cmp	r0, #3
c0d02bcc:	d117      	bne.n	c0d02bfe <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02bce:	8870      	ldrh	r0, [r6, #2]
c0d02bd0:	2800      	cmp	r0, #0
c0d02bd2:	d12d      	bne.n	c0d02c30 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02bd4:	4329      	orrs	r1, r5
c0d02bd6:	2980      	cmp	r1, #128	; 0x80
c0d02bd8:	d02a      	beq.n	c0d02c30 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02bda:	4620      	mov	r0, r4
c0d02bdc:	4629      	mov	r1, r5
c0d02bde:	f7ff fbcd 	bl	c0d0237c <USBD_LL_StallEP>
c0d02be2:	e025      	b.n	c0d02c30 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02be4:	20fc      	movs	r0, #252	; 0xfc
c0d02be6:	5c20      	ldrb	r0, [r4, r0]
c0d02be8:	2803      	cmp	r0, #3
c0d02bea:	d02f      	beq.n	c0d02c4c <USBD_StdEPReq+0xc2>
c0d02bec:	2802      	cmp	r0, #2
c0d02bee:	d10e      	bne.n	c0d02c0e <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02bf0:	0668      	lsls	r0, r5, #25
c0d02bf2:	d109      	bne.n	c0d02c08 <USBD_StdEPReq+0x7e>
c0d02bf4:	e042      	b.n	c0d02c7c <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02bf6:	20fc      	movs	r0, #252	; 0xfc
c0d02bf8:	5c20      	ldrb	r0, [r4, r0]
c0d02bfa:	2803      	cmp	r0, #3
c0d02bfc:	d00f      	beq.n	c0d02c1e <USBD_StdEPReq+0x94>
c0d02bfe:	2802      	cmp	r0, #2
c0d02c00:	d105      	bne.n	c0d02c0e <USBD_StdEPReq+0x84>
c0d02c02:	4329      	orrs	r1, r5
c0d02c04:	2980      	cmp	r1, #128	; 0x80
c0d02c06:	d039      	beq.n	c0d02c7c <USBD_StdEPReq+0xf2>
c0d02c08:	4620      	mov	r0, r4
c0d02c0a:	4629      	mov	r1, r5
c0d02c0c:	e004      	b.n	c0d02c18 <USBD_StdEPReq+0x8e>
c0d02c0e:	4620      	mov	r0, r4
c0d02c10:	f7ff fbb4 	bl	c0d0237c <USBD_LL_StallEP>
c0d02c14:	2100      	movs	r1, #0
c0d02c16:	4620      	mov	r0, r4
c0d02c18:	f7ff fbb0 	bl	c0d0237c <USBD_LL_StallEP>
c0d02c1c:	e02e      	b.n	c0d02c7c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02c1e:	8870      	ldrh	r0, [r6, #2]
c0d02c20:	2800      	cmp	r0, #0
c0d02c22:	d12b      	bne.n	c0d02c7c <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02c24:	0668      	lsls	r0, r5, #25
c0d02c26:	d00d      	beq.n	c0d02c44 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02c28:	4620      	mov	r0, r4
c0d02c2a:	4629      	mov	r1, r5
c0d02c2c:	f7ff fbcc 	bl	c0d023c8 <USBD_LL_ClearStallEP>
c0d02c30:	2045      	movs	r0, #69	; 0x45
c0d02c32:	0080      	lsls	r0, r0, #2
c0d02c34:	5820      	ldr	r0, [r4, r0]
c0d02c36:	6880      	ldr	r0, [r0, #8]
c0d02c38:	f7fe ff8a 	bl	c0d01b50 <pic>
c0d02c3c:	4602      	mov	r2, r0
c0d02c3e:	4620      	mov	r0, r4
c0d02c40:	4631      	mov	r1, r6
c0d02c42:	4790      	blx	r2
c0d02c44:	4620      	mov	r0, r4
c0d02c46:	f000 f983 	bl	c0d02f50 <USBD_CtlSendStatus>
c0d02c4a:	e017      	b.n	c0d02c7c <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02c4c:	4626      	mov	r6, r4
c0d02c4e:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02c50:	4620      	mov	r0, r4
c0d02c52:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02c54:	420d      	tst	r5, r1
c0d02c56:	d100      	bne.n	c0d02c5a <USBD_StdEPReq+0xd0>
c0d02c58:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02c5a:	4620      	mov	r0, r4
c0d02c5c:	4629      	mov	r1, r5
c0d02c5e:	f7ff fbd9 	bl	c0d02414 <USBD_LL_IsStallEP>
c0d02c62:	2101      	movs	r1, #1
c0d02c64:	2800      	cmp	r0, #0
c0d02c66:	d100      	bne.n	c0d02c6a <USBD_StdEPReq+0xe0>
c0d02c68:	4601      	mov	r1, r0
c0d02c6a:	207f      	movs	r0, #127	; 0x7f
c0d02c6c:	4005      	ands	r5, r0
c0d02c6e:	0128      	lsls	r0, r5, #4
c0d02c70:	5031      	str	r1, [r6, r0]
c0d02c72:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02c74:	2202      	movs	r2, #2
c0d02c76:	4620      	mov	r0, r4
c0d02c78:	f000 f93c 	bl	c0d02ef4 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02c7c:	2000      	movs	r0, #0
c0d02c7e:	b001      	add	sp, #4
c0d02c80:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c82 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02c82:	780a      	ldrb	r2, [r1, #0]
c0d02c84:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02c86:	784a      	ldrb	r2, [r1, #1]
c0d02c88:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02c8a:	788a      	ldrb	r2, [r1, #2]
c0d02c8c:	78cb      	ldrb	r3, [r1, #3]
c0d02c8e:	021b      	lsls	r3, r3, #8
c0d02c90:	4313      	orrs	r3, r2
c0d02c92:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02c94:	790a      	ldrb	r2, [r1, #4]
c0d02c96:	794b      	ldrb	r3, [r1, #5]
c0d02c98:	021b      	lsls	r3, r3, #8
c0d02c9a:	4313      	orrs	r3, r2
c0d02c9c:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02c9e:	798a      	ldrb	r2, [r1, #6]
c0d02ca0:	79c9      	ldrb	r1, [r1, #7]
c0d02ca2:	0209      	lsls	r1, r1, #8
c0d02ca4:	4311      	orrs	r1, r2
c0d02ca6:	80c1      	strh	r1, [r0, #6]

}
c0d02ca8:	4770      	bx	lr

c0d02caa <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02caa:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02cac:	af03      	add	r7, sp, #12
c0d02cae:	b083      	sub	sp, #12
c0d02cb0:	460d      	mov	r5, r1
c0d02cb2:	4604      	mov	r4, r0
c0d02cb4:	a802      	add	r0, sp, #8
c0d02cb6:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02cb8:	8006      	strh	r6, [r0, #0]
c0d02cba:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02cbc:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02cbe:	7829      	ldrb	r1, [r5, #0]
c0d02cc0:	2060      	movs	r0, #96	; 0x60
c0d02cc2:	4008      	ands	r0, r1
c0d02cc4:	2800      	cmp	r0, #0
c0d02cc6:	d010      	beq.n	c0d02cea <USBD_HID_Setup+0x40>
c0d02cc8:	2820      	cmp	r0, #32
c0d02cca:	d139      	bne.n	c0d02d40 <USBD_HID_Setup+0x96>
c0d02ccc:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02cce:	4601      	mov	r1, r0
c0d02cd0:	390a      	subs	r1, #10
c0d02cd2:	2902      	cmp	r1, #2
c0d02cd4:	d334      	bcc.n	c0d02d40 <USBD_HID_Setup+0x96>
c0d02cd6:	2802      	cmp	r0, #2
c0d02cd8:	d01c      	beq.n	c0d02d14 <USBD_HID_Setup+0x6a>
c0d02cda:	2803      	cmp	r0, #3
c0d02cdc:	d01a      	beq.n	c0d02d14 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02cde:	4620      	mov	r0, r4
c0d02ce0:	4629      	mov	r1, r5
c0d02ce2:	f7ff ff1f 	bl	c0d02b24 <USBD_CtlError>
c0d02ce6:	2602      	movs	r6, #2
c0d02ce8:	e02a      	b.n	c0d02d40 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02cea:	7868      	ldrb	r0, [r5, #1]
c0d02cec:	280b      	cmp	r0, #11
c0d02cee:	d014      	beq.n	c0d02d1a <USBD_HID_Setup+0x70>
c0d02cf0:	280a      	cmp	r0, #10
c0d02cf2:	d00f      	beq.n	c0d02d14 <USBD_HID_Setup+0x6a>
c0d02cf4:	2806      	cmp	r0, #6
c0d02cf6:	d123      	bne.n	c0d02d40 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02cf8:	8868      	ldrh	r0, [r5, #2]
c0d02cfa:	0a00      	lsrs	r0, r0, #8
c0d02cfc:	2600      	movs	r6, #0
c0d02cfe:	2821      	cmp	r0, #33	; 0x21
c0d02d00:	d00f      	beq.n	c0d02d22 <USBD_HID_Setup+0x78>
c0d02d02:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02d04:	4632      	mov	r2, r6
c0d02d06:	4631      	mov	r1, r6
c0d02d08:	d117      	bne.n	c0d02d3a <USBD_HID_Setup+0x90>
c0d02d0a:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02d0c:	9000      	str	r0, [sp, #0]
c0d02d0e:	f000 f847 	bl	c0d02da0 <USBD_HID_GetReportDescriptor_impl>
c0d02d12:	e00a      	b.n	c0d02d2a <USBD_HID_Setup+0x80>
c0d02d14:	a901      	add	r1, sp, #4
c0d02d16:	2201      	movs	r2, #1
c0d02d18:	e00f      	b.n	c0d02d3a <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02d1a:	4620      	mov	r0, r4
c0d02d1c:	f000 f918 	bl	c0d02f50 <USBD_CtlSendStatus>
c0d02d20:	e00e      	b.n	c0d02d40 <USBD_HID_Setup+0x96>
c0d02d22:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02d24:	9000      	str	r0, [sp, #0]
c0d02d26:	f000 f833 	bl	c0d02d90 <USBD_HID_GetHidDescriptor_impl>
c0d02d2a:	9b00      	ldr	r3, [sp, #0]
c0d02d2c:	4601      	mov	r1, r0
c0d02d2e:	881a      	ldrh	r2, [r3, #0]
c0d02d30:	88e8      	ldrh	r0, [r5, #6]
c0d02d32:	4282      	cmp	r2, r0
c0d02d34:	d300      	bcc.n	c0d02d38 <USBD_HID_Setup+0x8e>
c0d02d36:	4602      	mov	r2, r0
c0d02d38:	801a      	strh	r2, [r3, #0]
c0d02d3a:	4620      	mov	r0, r4
c0d02d3c:	f000 f8da 	bl	c0d02ef4 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02d40:	b2f0      	uxtb	r0, r6
c0d02d42:	b003      	add	sp, #12
c0d02d44:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02d46 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02d46:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d48:	af03      	add	r7, sp, #12
c0d02d4a:	b081      	sub	sp, #4
c0d02d4c:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02d4e:	2182      	movs	r1, #130	; 0x82
c0d02d50:	2502      	movs	r5, #2
c0d02d52:	2640      	movs	r6, #64	; 0x40
c0d02d54:	462a      	mov	r2, r5
c0d02d56:	4633      	mov	r3, r6
c0d02d58:	f7ff fad0 	bl	c0d022fc <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02d5c:	4620      	mov	r0, r4
c0d02d5e:	4629      	mov	r1, r5
c0d02d60:	462a      	mov	r2, r5
c0d02d62:	4633      	mov	r3, r6
c0d02d64:	f7ff faca 	bl	c0d022fc <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02d68:	4620      	mov	r0, r4
c0d02d6a:	4629      	mov	r1, r5
c0d02d6c:	4632      	mov	r2, r6
c0d02d6e:	f7ff fb90 	bl	c0d02492 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02d72:	2000      	movs	r0, #0
c0d02d74:	b001      	add	sp, #4
c0d02d76:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02d78 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02d78:	b5d0      	push	{r4, r6, r7, lr}
c0d02d7a:	af02      	add	r7, sp, #8
c0d02d7c:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02d7e:	2182      	movs	r1, #130	; 0x82
c0d02d80:	f7ff fae4 	bl	c0d0234c <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02d84:	2102      	movs	r1, #2
c0d02d86:	4620      	mov	r0, r4
c0d02d88:	f7ff fae0 	bl	c0d0234c <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02d8c:	2000      	movs	r0, #0
c0d02d8e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d90 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02d90:	2109      	movs	r1, #9
c0d02d92:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02d94:	4801      	ldr	r0, [pc, #4]	; (c0d02d9c <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02d96:	4478      	add	r0, pc
c0d02d98:	4770      	bx	lr
c0d02d9a:	46c0      	nop			; (mov r8, r8)
c0d02d9c:	00000ab2 	.word	0x00000ab2

c0d02da0 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02da0:	2122      	movs	r1, #34	; 0x22
c0d02da2:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02da4:	4801      	ldr	r0, [pc, #4]	; (c0d02dac <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02da6:	4478      	add	r0, pc
c0d02da8:	4770      	bx	lr
c0d02daa:	46c0      	nop			; (mov r8, r8)
c0d02dac:	00000a7d 	.word	0x00000a7d

c0d02db0 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02db0:	b5b0      	push	{r4, r5, r7, lr}
c0d02db2:	af02      	add	r7, sp, #8
c0d02db4:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02db6:	2102      	movs	r1, #2
c0d02db8:	2240      	movs	r2, #64	; 0x40
c0d02dba:	f7ff fb6a 	bl	c0d02492 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02dbe:	4d0d      	ldr	r5, [pc, #52]	; (c0d02df4 <USBD_HID_DataOut_impl+0x44>)
c0d02dc0:	7828      	ldrb	r0, [r5, #0]
c0d02dc2:	2800      	cmp	r0, #0
c0d02dc4:	d113      	bne.n	c0d02dee <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02dc6:	2002      	movs	r0, #2
c0d02dc8:	f7fe f928 	bl	c0d0101c <io_seproxyhal_get_ep_rx_size>
c0d02dcc:	4602      	mov	r2, r0
c0d02dce:	480d      	ldr	r0, [pc, #52]	; (c0d02e04 <USBD_HID_DataOut_impl+0x54>)
c0d02dd0:	4478      	add	r0, pc
c0d02dd2:	4621      	mov	r1, r4
c0d02dd4:	f7fd ff86 	bl	c0d00ce4 <io_usb_hid_receive>
c0d02dd8:	2802      	cmp	r0, #2
c0d02dda:	d108      	bne.n	c0d02dee <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02ddc:	2001      	movs	r0, #1
c0d02dde:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02de0:	4805      	ldr	r0, [pc, #20]	; (c0d02df8 <USBD_HID_DataOut_impl+0x48>)
c0d02de2:	2107      	movs	r1, #7
c0d02de4:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02de6:	4805      	ldr	r0, [pc, #20]	; (c0d02dfc <USBD_HID_DataOut_impl+0x4c>)
c0d02de8:	6800      	ldr	r0, [r0, #0]
c0d02dea:	4905      	ldr	r1, [pc, #20]	; (c0d02e00 <USBD_HID_DataOut_impl+0x50>)
c0d02dec:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02dee:	2000      	movs	r0, #0
c0d02df0:	bdb0      	pop	{r4, r5, r7, pc}
c0d02df2:	46c0      	nop			; (mov r8, r8)
c0d02df4:	20001d10 	.word	0x20001d10
c0d02df8:	20001d18 	.word	0x20001d18
c0d02dfc:	20001c00 	.word	0x20001c00
c0d02e00:	20001d1c 	.word	0x20001d1c
c0d02e04:	ffffe3a1 	.word	0xffffe3a1

c0d02e08 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02e08:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e0a:	af03      	add	r7, sp, #12
c0d02e0c:	b081      	sub	sp, #4
c0d02e0e:	4604      	mov	r4, r0
c0d02e10:	2049      	movs	r0, #73	; 0x49
c0d02e12:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02e14:	4810      	ldr	r0, [pc, #64]	; (c0d02e58 <USB_power+0x50>)
c0d02e16:	2100      	movs	r1, #0
c0d02e18:	462a      	mov	r2, r5
c0d02e1a:	f7fe f80f 	bl	c0d00e3c <os_memset>

  if (enabled) {
c0d02e1e:	2c00      	cmp	r4, #0
c0d02e20:	d015      	beq.n	c0d02e4e <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02e22:	4c0d      	ldr	r4, [pc, #52]	; (c0d02e58 <USB_power+0x50>)
c0d02e24:	2600      	movs	r6, #0
c0d02e26:	4620      	mov	r0, r4
c0d02e28:	4631      	mov	r1, r6
c0d02e2a:	462a      	mov	r2, r5
c0d02e2c:	f7fe f806 	bl	c0d00e3c <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02e30:	490a      	ldr	r1, [pc, #40]	; (c0d02e5c <USB_power+0x54>)
c0d02e32:	4479      	add	r1, pc
c0d02e34:	4620      	mov	r0, r4
c0d02e36:	4632      	mov	r2, r6
c0d02e38:	f7ff fb3f 	bl	c0d024ba <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02e3c:	4908      	ldr	r1, [pc, #32]	; (c0d02e60 <USB_power+0x58>)
c0d02e3e:	4479      	add	r1, pc
c0d02e40:	4620      	mov	r0, r4
c0d02e42:	f7ff fb72 	bl	c0d0252a <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02e46:	4620      	mov	r0, r4
c0d02e48:	f7ff fb78 	bl	c0d0253c <USBD_Start>
c0d02e4c:	e002      	b.n	c0d02e54 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02e4e:	4802      	ldr	r0, [pc, #8]	; (c0d02e58 <USB_power+0x50>)
c0d02e50:	f7ff fb51 	bl	c0d024f6 <USBD_DeInit>
  }
}
c0d02e54:	b001      	add	sp, #4
c0d02e56:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02e58:	20001d34 	.word	0x20001d34
c0d02e5c:	00000a32 	.word	0x00000a32
c0d02e60:	00000a62 	.word	0x00000a62

c0d02e64 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02e64:	2012      	movs	r0, #18
c0d02e66:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02e68:	4801      	ldr	r0, [pc, #4]	; (c0d02e70 <USBD_DeviceDescriptor+0xc>)
c0d02e6a:	4478      	add	r0, pc
c0d02e6c:	4770      	bx	lr
c0d02e6e:	46c0      	nop			; (mov r8, r8)
c0d02e70:	000009e7 	.word	0x000009e7

c0d02e74 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02e74:	2004      	movs	r0, #4
c0d02e76:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02e78:	4801      	ldr	r0, [pc, #4]	; (c0d02e80 <USBD_LangIDStrDescriptor+0xc>)
c0d02e7a:	4478      	add	r0, pc
c0d02e7c:	4770      	bx	lr
c0d02e7e:	46c0      	nop			; (mov r8, r8)
c0d02e80:	00000a0a 	.word	0x00000a0a

c0d02e84 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02e84:	200e      	movs	r0, #14
c0d02e86:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02e88:	4801      	ldr	r0, [pc, #4]	; (c0d02e90 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02e8a:	4478      	add	r0, pc
c0d02e8c:	4770      	bx	lr
c0d02e8e:	46c0      	nop			; (mov r8, r8)
c0d02e90:	000009fe 	.word	0x000009fe

c0d02e94 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02e94:	200e      	movs	r0, #14
c0d02e96:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02e98:	4801      	ldr	r0, [pc, #4]	; (c0d02ea0 <USBD_ProductStrDescriptor+0xc>)
c0d02e9a:	4478      	add	r0, pc
c0d02e9c:	4770      	bx	lr
c0d02e9e:	46c0      	nop			; (mov r8, r8)
c0d02ea0:	0000097b 	.word	0x0000097b

c0d02ea4 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02ea4:	200a      	movs	r0, #10
c0d02ea6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02ea8:	4801      	ldr	r0, [pc, #4]	; (c0d02eb0 <USBD_SerialStrDescriptor+0xc>)
c0d02eaa:	4478      	add	r0, pc
c0d02eac:	4770      	bx	lr
c0d02eae:	46c0      	nop			; (mov r8, r8)
c0d02eb0:	000009ec 	.word	0x000009ec

c0d02eb4 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02eb4:	200e      	movs	r0, #14
c0d02eb6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02eb8:	4801      	ldr	r0, [pc, #4]	; (c0d02ec0 <USBD_ConfigStrDescriptor+0xc>)
c0d02eba:	4478      	add	r0, pc
c0d02ebc:	4770      	bx	lr
c0d02ebe:	46c0      	nop			; (mov r8, r8)
c0d02ec0:	0000095b 	.word	0x0000095b

c0d02ec4 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02ec4:	200e      	movs	r0, #14
c0d02ec6:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02ec8:	4801      	ldr	r0, [pc, #4]	; (c0d02ed0 <USBD_InterfaceStrDescriptor+0xc>)
c0d02eca:	4478      	add	r0, pc
c0d02ecc:	4770      	bx	lr
c0d02ece:	46c0      	nop			; (mov r8, r8)
c0d02ed0:	0000094b 	.word	0x0000094b

c0d02ed4 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02ed4:	2129      	movs	r1, #41	; 0x29
c0d02ed6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02ed8:	4801      	ldr	r0, [pc, #4]	; (c0d02ee0 <USBD_GetCfgDesc_impl+0xc>)
c0d02eda:	4478      	add	r0, pc
c0d02edc:	4770      	bx	lr
c0d02ede:	46c0      	nop			; (mov r8, r8)
c0d02ee0:	000009fe 	.word	0x000009fe

c0d02ee4 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02ee4:	210a      	movs	r1, #10
c0d02ee6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02ee8:	4801      	ldr	r0, [pc, #4]	; (c0d02ef0 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02eea:	4478      	add	r0, pc
c0d02eec:	4770      	bx	lr
c0d02eee:	46c0      	nop			; (mov r8, r8)
c0d02ef0:	00000a1a 	.word	0x00000a1a

c0d02ef4 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02ef4:	b5b0      	push	{r4, r5, r7, lr}
c0d02ef6:	af02      	add	r7, sp, #8
c0d02ef8:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02efa:	21f4      	movs	r1, #244	; 0xf4
c0d02efc:	2302      	movs	r3, #2
c0d02efe:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02f00:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02f02:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02f04:	2109      	movs	r1, #9
c0d02f06:	0149      	lsls	r1, r1, #5
c0d02f08:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02f0a:	6a01      	ldr	r1, [r0, #32]
c0d02f0c:	428a      	cmp	r2, r1
c0d02f0e:	d300      	bcc.n	c0d02f12 <USBD_CtlSendData+0x1e>
c0d02f10:	460a      	mov	r2, r1
c0d02f12:	b293      	uxth	r3, r2
c0d02f14:	2500      	movs	r5, #0
c0d02f16:	4629      	mov	r1, r5
c0d02f18:	4622      	mov	r2, r4
c0d02f1a:	f7ff faa0 	bl	c0d0245e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02f1e:	4628      	mov	r0, r5
c0d02f20:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f22 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02f22:	b5b0      	push	{r4, r5, r7, lr}
c0d02f24:	af02      	add	r7, sp, #8
c0d02f26:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02f28:	6a01      	ldr	r1, [r0, #32]
c0d02f2a:	428a      	cmp	r2, r1
c0d02f2c:	d300      	bcc.n	c0d02f30 <USBD_CtlContinueSendData+0xe>
c0d02f2e:	460a      	mov	r2, r1
c0d02f30:	b293      	uxth	r3, r2
c0d02f32:	2500      	movs	r5, #0
c0d02f34:	4629      	mov	r1, r5
c0d02f36:	4622      	mov	r2, r4
c0d02f38:	f7ff fa91 	bl	c0d0245e <USBD_LL_Transmit>
  return USBD_OK;
c0d02f3c:	4628      	mov	r0, r5
c0d02f3e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f40 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02f40:	b5d0      	push	{r4, r6, r7, lr}
c0d02f42:	af02      	add	r7, sp, #8
c0d02f44:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02f46:	4621      	mov	r1, r4
c0d02f48:	f7ff faa3 	bl	c0d02492 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02f4c:	4620      	mov	r0, r4
c0d02f4e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f50 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02f50:	b5d0      	push	{r4, r6, r7, lr}
c0d02f52:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02f54:	21f4      	movs	r1, #244	; 0xf4
c0d02f56:	2204      	movs	r2, #4
c0d02f58:	5042      	str	r2, [r0, r1]
c0d02f5a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02f5c:	4621      	mov	r1, r4
c0d02f5e:	4622      	mov	r2, r4
c0d02f60:	4623      	mov	r3, r4
c0d02f62:	f7ff fa7c 	bl	c0d0245e <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02f66:	4620      	mov	r0, r4
c0d02f68:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f6a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02f6a:	b5d0      	push	{r4, r6, r7, lr}
c0d02f6c:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02f6e:	21f4      	movs	r1, #244	; 0xf4
c0d02f70:	2205      	movs	r2, #5
c0d02f72:	5042      	str	r2, [r0, r1]
c0d02f74:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02f76:	4621      	mov	r1, r4
c0d02f78:	4622      	mov	r2, r4
c0d02f7a:	f7ff fa8a 	bl	c0d02492 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02f7e:	4620      	mov	r0, r4
c0d02f80:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02f84 <__aeabi_uidiv>:
c0d02f84:	2200      	movs	r2, #0
c0d02f86:	0843      	lsrs	r3, r0, #1
c0d02f88:	428b      	cmp	r3, r1
c0d02f8a:	d374      	bcc.n	c0d03076 <__aeabi_uidiv+0xf2>
c0d02f8c:	0903      	lsrs	r3, r0, #4
c0d02f8e:	428b      	cmp	r3, r1
c0d02f90:	d35f      	bcc.n	c0d03052 <__aeabi_uidiv+0xce>
c0d02f92:	0a03      	lsrs	r3, r0, #8
c0d02f94:	428b      	cmp	r3, r1
c0d02f96:	d344      	bcc.n	c0d03022 <__aeabi_uidiv+0x9e>
c0d02f98:	0b03      	lsrs	r3, r0, #12
c0d02f9a:	428b      	cmp	r3, r1
c0d02f9c:	d328      	bcc.n	c0d02ff0 <__aeabi_uidiv+0x6c>
c0d02f9e:	0c03      	lsrs	r3, r0, #16
c0d02fa0:	428b      	cmp	r3, r1
c0d02fa2:	d30d      	bcc.n	c0d02fc0 <__aeabi_uidiv+0x3c>
c0d02fa4:	22ff      	movs	r2, #255	; 0xff
c0d02fa6:	0209      	lsls	r1, r1, #8
c0d02fa8:	ba12      	rev	r2, r2
c0d02faa:	0c03      	lsrs	r3, r0, #16
c0d02fac:	428b      	cmp	r3, r1
c0d02fae:	d302      	bcc.n	c0d02fb6 <__aeabi_uidiv+0x32>
c0d02fb0:	1212      	asrs	r2, r2, #8
c0d02fb2:	0209      	lsls	r1, r1, #8
c0d02fb4:	d065      	beq.n	c0d03082 <__aeabi_uidiv+0xfe>
c0d02fb6:	0b03      	lsrs	r3, r0, #12
c0d02fb8:	428b      	cmp	r3, r1
c0d02fba:	d319      	bcc.n	c0d02ff0 <__aeabi_uidiv+0x6c>
c0d02fbc:	e000      	b.n	c0d02fc0 <__aeabi_uidiv+0x3c>
c0d02fbe:	0a09      	lsrs	r1, r1, #8
c0d02fc0:	0bc3      	lsrs	r3, r0, #15
c0d02fc2:	428b      	cmp	r3, r1
c0d02fc4:	d301      	bcc.n	c0d02fca <__aeabi_uidiv+0x46>
c0d02fc6:	03cb      	lsls	r3, r1, #15
c0d02fc8:	1ac0      	subs	r0, r0, r3
c0d02fca:	4152      	adcs	r2, r2
c0d02fcc:	0b83      	lsrs	r3, r0, #14
c0d02fce:	428b      	cmp	r3, r1
c0d02fd0:	d301      	bcc.n	c0d02fd6 <__aeabi_uidiv+0x52>
c0d02fd2:	038b      	lsls	r3, r1, #14
c0d02fd4:	1ac0      	subs	r0, r0, r3
c0d02fd6:	4152      	adcs	r2, r2
c0d02fd8:	0b43      	lsrs	r3, r0, #13
c0d02fda:	428b      	cmp	r3, r1
c0d02fdc:	d301      	bcc.n	c0d02fe2 <__aeabi_uidiv+0x5e>
c0d02fde:	034b      	lsls	r3, r1, #13
c0d02fe0:	1ac0      	subs	r0, r0, r3
c0d02fe2:	4152      	adcs	r2, r2
c0d02fe4:	0b03      	lsrs	r3, r0, #12
c0d02fe6:	428b      	cmp	r3, r1
c0d02fe8:	d301      	bcc.n	c0d02fee <__aeabi_uidiv+0x6a>
c0d02fea:	030b      	lsls	r3, r1, #12
c0d02fec:	1ac0      	subs	r0, r0, r3
c0d02fee:	4152      	adcs	r2, r2
c0d02ff0:	0ac3      	lsrs	r3, r0, #11
c0d02ff2:	428b      	cmp	r3, r1
c0d02ff4:	d301      	bcc.n	c0d02ffa <__aeabi_uidiv+0x76>
c0d02ff6:	02cb      	lsls	r3, r1, #11
c0d02ff8:	1ac0      	subs	r0, r0, r3
c0d02ffa:	4152      	adcs	r2, r2
c0d02ffc:	0a83      	lsrs	r3, r0, #10
c0d02ffe:	428b      	cmp	r3, r1
c0d03000:	d301      	bcc.n	c0d03006 <__aeabi_uidiv+0x82>
c0d03002:	028b      	lsls	r3, r1, #10
c0d03004:	1ac0      	subs	r0, r0, r3
c0d03006:	4152      	adcs	r2, r2
c0d03008:	0a43      	lsrs	r3, r0, #9
c0d0300a:	428b      	cmp	r3, r1
c0d0300c:	d301      	bcc.n	c0d03012 <__aeabi_uidiv+0x8e>
c0d0300e:	024b      	lsls	r3, r1, #9
c0d03010:	1ac0      	subs	r0, r0, r3
c0d03012:	4152      	adcs	r2, r2
c0d03014:	0a03      	lsrs	r3, r0, #8
c0d03016:	428b      	cmp	r3, r1
c0d03018:	d301      	bcc.n	c0d0301e <__aeabi_uidiv+0x9a>
c0d0301a:	020b      	lsls	r3, r1, #8
c0d0301c:	1ac0      	subs	r0, r0, r3
c0d0301e:	4152      	adcs	r2, r2
c0d03020:	d2cd      	bcs.n	c0d02fbe <__aeabi_uidiv+0x3a>
c0d03022:	09c3      	lsrs	r3, r0, #7
c0d03024:	428b      	cmp	r3, r1
c0d03026:	d301      	bcc.n	c0d0302c <__aeabi_uidiv+0xa8>
c0d03028:	01cb      	lsls	r3, r1, #7
c0d0302a:	1ac0      	subs	r0, r0, r3
c0d0302c:	4152      	adcs	r2, r2
c0d0302e:	0983      	lsrs	r3, r0, #6
c0d03030:	428b      	cmp	r3, r1
c0d03032:	d301      	bcc.n	c0d03038 <__aeabi_uidiv+0xb4>
c0d03034:	018b      	lsls	r3, r1, #6
c0d03036:	1ac0      	subs	r0, r0, r3
c0d03038:	4152      	adcs	r2, r2
c0d0303a:	0943      	lsrs	r3, r0, #5
c0d0303c:	428b      	cmp	r3, r1
c0d0303e:	d301      	bcc.n	c0d03044 <__aeabi_uidiv+0xc0>
c0d03040:	014b      	lsls	r3, r1, #5
c0d03042:	1ac0      	subs	r0, r0, r3
c0d03044:	4152      	adcs	r2, r2
c0d03046:	0903      	lsrs	r3, r0, #4
c0d03048:	428b      	cmp	r3, r1
c0d0304a:	d301      	bcc.n	c0d03050 <__aeabi_uidiv+0xcc>
c0d0304c:	010b      	lsls	r3, r1, #4
c0d0304e:	1ac0      	subs	r0, r0, r3
c0d03050:	4152      	adcs	r2, r2
c0d03052:	08c3      	lsrs	r3, r0, #3
c0d03054:	428b      	cmp	r3, r1
c0d03056:	d301      	bcc.n	c0d0305c <__aeabi_uidiv+0xd8>
c0d03058:	00cb      	lsls	r3, r1, #3
c0d0305a:	1ac0      	subs	r0, r0, r3
c0d0305c:	4152      	adcs	r2, r2
c0d0305e:	0883      	lsrs	r3, r0, #2
c0d03060:	428b      	cmp	r3, r1
c0d03062:	d301      	bcc.n	c0d03068 <__aeabi_uidiv+0xe4>
c0d03064:	008b      	lsls	r3, r1, #2
c0d03066:	1ac0      	subs	r0, r0, r3
c0d03068:	4152      	adcs	r2, r2
c0d0306a:	0843      	lsrs	r3, r0, #1
c0d0306c:	428b      	cmp	r3, r1
c0d0306e:	d301      	bcc.n	c0d03074 <__aeabi_uidiv+0xf0>
c0d03070:	004b      	lsls	r3, r1, #1
c0d03072:	1ac0      	subs	r0, r0, r3
c0d03074:	4152      	adcs	r2, r2
c0d03076:	1a41      	subs	r1, r0, r1
c0d03078:	d200      	bcs.n	c0d0307c <__aeabi_uidiv+0xf8>
c0d0307a:	4601      	mov	r1, r0
c0d0307c:	4152      	adcs	r2, r2
c0d0307e:	4610      	mov	r0, r2
c0d03080:	4770      	bx	lr
c0d03082:	e7ff      	b.n	c0d03084 <__aeabi_uidiv+0x100>
c0d03084:	b501      	push	{r0, lr}
c0d03086:	2000      	movs	r0, #0
c0d03088:	f000 f8f0 	bl	c0d0326c <__aeabi_idiv0>
c0d0308c:	bd02      	pop	{r1, pc}
c0d0308e:	46c0      	nop			; (mov r8, r8)

c0d03090 <__aeabi_uidivmod>:
c0d03090:	2900      	cmp	r1, #0
c0d03092:	d0f7      	beq.n	c0d03084 <__aeabi_uidiv+0x100>
c0d03094:	e776      	b.n	c0d02f84 <__aeabi_uidiv>
c0d03096:	4770      	bx	lr

c0d03098 <__aeabi_idiv>:
c0d03098:	4603      	mov	r3, r0
c0d0309a:	430b      	orrs	r3, r1
c0d0309c:	d47f      	bmi.n	c0d0319e <__aeabi_idiv+0x106>
c0d0309e:	2200      	movs	r2, #0
c0d030a0:	0843      	lsrs	r3, r0, #1
c0d030a2:	428b      	cmp	r3, r1
c0d030a4:	d374      	bcc.n	c0d03190 <__aeabi_idiv+0xf8>
c0d030a6:	0903      	lsrs	r3, r0, #4
c0d030a8:	428b      	cmp	r3, r1
c0d030aa:	d35f      	bcc.n	c0d0316c <__aeabi_idiv+0xd4>
c0d030ac:	0a03      	lsrs	r3, r0, #8
c0d030ae:	428b      	cmp	r3, r1
c0d030b0:	d344      	bcc.n	c0d0313c <__aeabi_idiv+0xa4>
c0d030b2:	0b03      	lsrs	r3, r0, #12
c0d030b4:	428b      	cmp	r3, r1
c0d030b6:	d328      	bcc.n	c0d0310a <__aeabi_idiv+0x72>
c0d030b8:	0c03      	lsrs	r3, r0, #16
c0d030ba:	428b      	cmp	r3, r1
c0d030bc:	d30d      	bcc.n	c0d030da <__aeabi_idiv+0x42>
c0d030be:	22ff      	movs	r2, #255	; 0xff
c0d030c0:	0209      	lsls	r1, r1, #8
c0d030c2:	ba12      	rev	r2, r2
c0d030c4:	0c03      	lsrs	r3, r0, #16
c0d030c6:	428b      	cmp	r3, r1
c0d030c8:	d302      	bcc.n	c0d030d0 <__aeabi_idiv+0x38>
c0d030ca:	1212      	asrs	r2, r2, #8
c0d030cc:	0209      	lsls	r1, r1, #8
c0d030ce:	d065      	beq.n	c0d0319c <__aeabi_idiv+0x104>
c0d030d0:	0b03      	lsrs	r3, r0, #12
c0d030d2:	428b      	cmp	r3, r1
c0d030d4:	d319      	bcc.n	c0d0310a <__aeabi_idiv+0x72>
c0d030d6:	e000      	b.n	c0d030da <__aeabi_idiv+0x42>
c0d030d8:	0a09      	lsrs	r1, r1, #8
c0d030da:	0bc3      	lsrs	r3, r0, #15
c0d030dc:	428b      	cmp	r3, r1
c0d030de:	d301      	bcc.n	c0d030e4 <__aeabi_idiv+0x4c>
c0d030e0:	03cb      	lsls	r3, r1, #15
c0d030e2:	1ac0      	subs	r0, r0, r3
c0d030e4:	4152      	adcs	r2, r2
c0d030e6:	0b83      	lsrs	r3, r0, #14
c0d030e8:	428b      	cmp	r3, r1
c0d030ea:	d301      	bcc.n	c0d030f0 <__aeabi_idiv+0x58>
c0d030ec:	038b      	lsls	r3, r1, #14
c0d030ee:	1ac0      	subs	r0, r0, r3
c0d030f0:	4152      	adcs	r2, r2
c0d030f2:	0b43      	lsrs	r3, r0, #13
c0d030f4:	428b      	cmp	r3, r1
c0d030f6:	d301      	bcc.n	c0d030fc <__aeabi_idiv+0x64>
c0d030f8:	034b      	lsls	r3, r1, #13
c0d030fa:	1ac0      	subs	r0, r0, r3
c0d030fc:	4152      	adcs	r2, r2
c0d030fe:	0b03      	lsrs	r3, r0, #12
c0d03100:	428b      	cmp	r3, r1
c0d03102:	d301      	bcc.n	c0d03108 <__aeabi_idiv+0x70>
c0d03104:	030b      	lsls	r3, r1, #12
c0d03106:	1ac0      	subs	r0, r0, r3
c0d03108:	4152      	adcs	r2, r2
c0d0310a:	0ac3      	lsrs	r3, r0, #11
c0d0310c:	428b      	cmp	r3, r1
c0d0310e:	d301      	bcc.n	c0d03114 <__aeabi_idiv+0x7c>
c0d03110:	02cb      	lsls	r3, r1, #11
c0d03112:	1ac0      	subs	r0, r0, r3
c0d03114:	4152      	adcs	r2, r2
c0d03116:	0a83      	lsrs	r3, r0, #10
c0d03118:	428b      	cmp	r3, r1
c0d0311a:	d301      	bcc.n	c0d03120 <__aeabi_idiv+0x88>
c0d0311c:	028b      	lsls	r3, r1, #10
c0d0311e:	1ac0      	subs	r0, r0, r3
c0d03120:	4152      	adcs	r2, r2
c0d03122:	0a43      	lsrs	r3, r0, #9
c0d03124:	428b      	cmp	r3, r1
c0d03126:	d301      	bcc.n	c0d0312c <__aeabi_idiv+0x94>
c0d03128:	024b      	lsls	r3, r1, #9
c0d0312a:	1ac0      	subs	r0, r0, r3
c0d0312c:	4152      	adcs	r2, r2
c0d0312e:	0a03      	lsrs	r3, r0, #8
c0d03130:	428b      	cmp	r3, r1
c0d03132:	d301      	bcc.n	c0d03138 <__aeabi_idiv+0xa0>
c0d03134:	020b      	lsls	r3, r1, #8
c0d03136:	1ac0      	subs	r0, r0, r3
c0d03138:	4152      	adcs	r2, r2
c0d0313a:	d2cd      	bcs.n	c0d030d8 <__aeabi_idiv+0x40>
c0d0313c:	09c3      	lsrs	r3, r0, #7
c0d0313e:	428b      	cmp	r3, r1
c0d03140:	d301      	bcc.n	c0d03146 <__aeabi_idiv+0xae>
c0d03142:	01cb      	lsls	r3, r1, #7
c0d03144:	1ac0      	subs	r0, r0, r3
c0d03146:	4152      	adcs	r2, r2
c0d03148:	0983      	lsrs	r3, r0, #6
c0d0314a:	428b      	cmp	r3, r1
c0d0314c:	d301      	bcc.n	c0d03152 <__aeabi_idiv+0xba>
c0d0314e:	018b      	lsls	r3, r1, #6
c0d03150:	1ac0      	subs	r0, r0, r3
c0d03152:	4152      	adcs	r2, r2
c0d03154:	0943      	lsrs	r3, r0, #5
c0d03156:	428b      	cmp	r3, r1
c0d03158:	d301      	bcc.n	c0d0315e <__aeabi_idiv+0xc6>
c0d0315a:	014b      	lsls	r3, r1, #5
c0d0315c:	1ac0      	subs	r0, r0, r3
c0d0315e:	4152      	adcs	r2, r2
c0d03160:	0903      	lsrs	r3, r0, #4
c0d03162:	428b      	cmp	r3, r1
c0d03164:	d301      	bcc.n	c0d0316a <__aeabi_idiv+0xd2>
c0d03166:	010b      	lsls	r3, r1, #4
c0d03168:	1ac0      	subs	r0, r0, r3
c0d0316a:	4152      	adcs	r2, r2
c0d0316c:	08c3      	lsrs	r3, r0, #3
c0d0316e:	428b      	cmp	r3, r1
c0d03170:	d301      	bcc.n	c0d03176 <__aeabi_idiv+0xde>
c0d03172:	00cb      	lsls	r3, r1, #3
c0d03174:	1ac0      	subs	r0, r0, r3
c0d03176:	4152      	adcs	r2, r2
c0d03178:	0883      	lsrs	r3, r0, #2
c0d0317a:	428b      	cmp	r3, r1
c0d0317c:	d301      	bcc.n	c0d03182 <__aeabi_idiv+0xea>
c0d0317e:	008b      	lsls	r3, r1, #2
c0d03180:	1ac0      	subs	r0, r0, r3
c0d03182:	4152      	adcs	r2, r2
c0d03184:	0843      	lsrs	r3, r0, #1
c0d03186:	428b      	cmp	r3, r1
c0d03188:	d301      	bcc.n	c0d0318e <__aeabi_idiv+0xf6>
c0d0318a:	004b      	lsls	r3, r1, #1
c0d0318c:	1ac0      	subs	r0, r0, r3
c0d0318e:	4152      	adcs	r2, r2
c0d03190:	1a41      	subs	r1, r0, r1
c0d03192:	d200      	bcs.n	c0d03196 <__aeabi_idiv+0xfe>
c0d03194:	4601      	mov	r1, r0
c0d03196:	4152      	adcs	r2, r2
c0d03198:	4610      	mov	r0, r2
c0d0319a:	4770      	bx	lr
c0d0319c:	e05d      	b.n	c0d0325a <__aeabi_idiv+0x1c2>
c0d0319e:	0fca      	lsrs	r2, r1, #31
c0d031a0:	d000      	beq.n	c0d031a4 <__aeabi_idiv+0x10c>
c0d031a2:	4249      	negs	r1, r1
c0d031a4:	1003      	asrs	r3, r0, #32
c0d031a6:	d300      	bcc.n	c0d031aa <__aeabi_idiv+0x112>
c0d031a8:	4240      	negs	r0, r0
c0d031aa:	4053      	eors	r3, r2
c0d031ac:	2200      	movs	r2, #0
c0d031ae:	469c      	mov	ip, r3
c0d031b0:	0903      	lsrs	r3, r0, #4
c0d031b2:	428b      	cmp	r3, r1
c0d031b4:	d32d      	bcc.n	c0d03212 <__aeabi_idiv+0x17a>
c0d031b6:	0a03      	lsrs	r3, r0, #8
c0d031b8:	428b      	cmp	r3, r1
c0d031ba:	d312      	bcc.n	c0d031e2 <__aeabi_idiv+0x14a>
c0d031bc:	22fc      	movs	r2, #252	; 0xfc
c0d031be:	0189      	lsls	r1, r1, #6
c0d031c0:	ba12      	rev	r2, r2
c0d031c2:	0a03      	lsrs	r3, r0, #8
c0d031c4:	428b      	cmp	r3, r1
c0d031c6:	d30c      	bcc.n	c0d031e2 <__aeabi_idiv+0x14a>
c0d031c8:	0189      	lsls	r1, r1, #6
c0d031ca:	1192      	asrs	r2, r2, #6
c0d031cc:	428b      	cmp	r3, r1
c0d031ce:	d308      	bcc.n	c0d031e2 <__aeabi_idiv+0x14a>
c0d031d0:	0189      	lsls	r1, r1, #6
c0d031d2:	1192      	asrs	r2, r2, #6
c0d031d4:	428b      	cmp	r3, r1
c0d031d6:	d304      	bcc.n	c0d031e2 <__aeabi_idiv+0x14a>
c0d031d8:	0189      	lsls	r1, r1, #6
c0d031da:	d03a      	beq.n	c0d03252 <__aeabi_idiv+0x1ba>
c0d031dc:	1192      	asrs	r2, r2, #6
c0d031de:	e000      	b.n	c0d031e2 <__aeabi_idiv+0x14a>
c0d031e0:	0989      	lsrs	r1, r1, #6
c0d031e2:	09c3      	lsrs	r3, r0, #7
c0d031e4:	428b      	cmp	r3, r1
c0d031e6:	d301      	bcc.n	c0d031ec <__aeabi_idiv+0x154>
c0d031e8:	01cb      	lsls	r3, r1, #7
c0d031ea:	1ac0      	subs	r0, r0, r3
c0d031ec:	4152      	adcs	r2, r2
c0d031ee:	0983      	lsrs	r3, r0, #6
c0d031f0:	428b      	cmp	r3, r1
c0d031f2:	d301      	bcc.n	c0d031f8 <__aeabi_idiv+0x160>
c0d031f4:	018b      	lsls	r3, r1, #6
c0d031f6:	1ac0      	subs	r0, r0, r3
c0d031f8:	4152      	adcs	r2, r2
c0d031fa:	0943      	lsrs	r3, r0, #5
c0d031fc:	428b      	cmp	r3, r1
c0d031fe:	d301      	bcc.n	c0d03204 <__aeabi_idiv+0x16c>
c0d03200:	014b      	lsls	r3, r1, #5
c0d03202:	1ac0      	subs	r0, r0, r3
c0d03204:	4152      	adcs	r2, r2
c0d03206:	0903      	lsrs	r3, r0, #4
c0d03208:	428b      	cmp	r3, r1
c0d0320a:	d301      	bcc.n	c0d03210 <__aeabi_idiv+0x178>
c0d0320c:	010b      	lsls	r3, r1, #4
c0d0320e:	1ac0      	subs	r0, r0, r3
c0d03210:	4152      	adcs	r2, r2
c0d03212:	08c3      	lsrs	r3, r0, #3
c0d03214:	428b      	cmp	r3, r1
c0d03216:	d301      	bcc.n	c0d0321c <__aeabi_idiv+0x184>
c0d03218:	00cb      	lsls	r3, r1, #3
c0d0321a:	1ac0      	subs	r0, r0, r3
c0d0321c:	4152      	adcs	r2, r2
c0d0321e:	0883      	lsrs	r3, r0, #2
c0d03220:	428b      	cmp	r3, r1
c0d03222:	d301      	bcc.n	c0d03228 <__aeabi_idiv+0x190>
c0d03224:	008b      	lsls	r3, r1, #2
c0d03226:	1ac0      	subs	r0, r0, r3
c0d03228:	4152      	adcs	r2, r2
c0d0322a:	d2d9      	bcs.n	c0d031e0 <__aeabi_idiv+0x148>
c0d0322c:	0843      	lsrs	r3, r0, #1
c0d0322e:	428b      	cmp	r3, r1
c0d03230:	d301      	bcc.n	c0d03236 <__aeabi_idiv+0x19e>
c0d03232:	004b      	lsls	r3, r1, #1
c0d03234:	1ac0      	subs	r0, r0, r3
c0d03236:	4152      	adcs	r2, r2
c0d03238:	1a41      	subs	r1, r0, r1
c0d0323a:	d200      	bcs.n	c0d0323e <__aeabi_idiv+0x1a6>
c0d0323c:	4601      	mov	r1, r0
c0d0323e:	4663      	mov	r3, ip
c0d03240:	4152      	adcs	r2, r2
c0d03242:	105b      	asrs	r3, r3, #1
c0d03244:	4610      	mov	r0, r2
c0d03246:	d301      	bcc.n	c0d0324c <__aeabi_idiv+0x1b4>
c0d03248:	4240      	negs	r0, r0
c0d0324a:	2b00      	cmp	r3, #0
c0d0324c:	d500      	bpl.n	c0d03250 <__aeabi_idiv+0x1b8>
c0d0324e:	4249      	negs	r1, r1
c0d03250:	4770      	bx	lr
c0d03252:	4663      	mov	r3, ip
c0d03254:	105b      	asrs	r3, r3, #1
c0d03256:	d300      	bcc.n	c0d0325a <__aeabi_idiv+0x1c2>
c0d03258:	4240      	negs	r0, r0
c0d0325a:	b501      	push	{r0, lr}
c0d0325c:	2000      	movs	r0, #0
c0d0325e:	f000 f805 	bl	c0d0326c <__aeabi_idiv0>
c0d03262:	bd02      	pop	{r1, pc}

c0d03264 <__aeabi_idivmod>:
c0d03264:	2900      	cmp	r1, #0
c0d03266:	d0f8      	beq.n	c0d0325a <__aeabi_idiv+0x1c2>
c0d03268:	e716      	b.n	c0d03098 <__aeabi_idiv>
c0d0326a:	4770      	bx	lr

c0d0326c <__aeabi_idiv0>:
c0d0326c:	4770      	bx	lr
c0d0326e:	46c0      	nop			; (mov r8, r8)

c0d03270 <__aeabi_lmul>:
c0d03270:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03272:	464f      	mov	r7, r9
c0d03274:	4646      	mov	r6, r8
c0d03276:	b4c0      	push	{r6, r7}
c0d03278:	0416      	lsls	r6, r2, #16
c0d0327a:	0c36      	lsrs	r6, r6, #16
c0d0327c:	4699      	mov	r9, r3
c0d0327e:	0033      	movs	r3, r6
c0d03280:	0405      	lsls	r5, r0, #16
c0d03282:	0c2c      	lsrs	r4, r5, #16
c0d03284:	0c07      	lsrs	r7, r0, #16
c0d03286:	0c15      	lsrs	r5, r2, #16
c0d03288:	4363      	muls	r3, r4
c0d0328a:	437e      	muls	r6, r7
c0d0328c:	436f      	muls	r7, r5
c0d0328e:	4365      	muls	r5, r4
c0d03290:	0c1c      	lsrs	r4, r3, #16
c0d03292:	19ad      	adds	r5, r5, r6
c0d03294:	1964      	adds	r4, r4, r5
c0d03296:	469c      	mov	ip, r3
c0d03298:	42a6      	cmp	r6, r4
c0d0329a:	d903      	bls.n	c0d032a4 <__aeabi_lmul+0x34>
c0d0329c:	2380      	movs	r3, #128	; 0x80
c0d0329e:	025b      	lsls	r3, r3, #9
c0d032a0:	4698      	mov	r8, r3
c0d032a2:	4447      	add	r7, r8
c0d032a4:	4663      	mov	r3, ip
c0d032a6:	0c25      	lsrs	r5, r4, #16
c0d032a8:	19ef      	adds	r7, r5, r7
c0d032aa:	041d      	lsls	r5, r3, #16
c0d032ac:	464b      	mov	r3, r9
c0d032ae:	434a      	muls	r2, r1
c0d032b0:	4343      	muls	r3, r0
c0d032b2:	0c2d      	lsrs	r5, r5, #16
c0d032b4:	0424      	lsls	r4, r4, #16
c0d032b6:	1964      	adds	r4, r4, r5
c0d032b8:	1899      	adds	r1, r3, r2
c0d032ba:	19c9      	adds	r1, r1, r7
c0d032bc:	0020      	movs	r0, r4
c0d032be:	bc0c      	pop	{r2, r3}
c0d032c0:	4690      	mov	r8, r2
c0d032c2:	4699      	mov	r9, r3
c0d032c4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d032c6:	46c0      	nop			; (mov r8, r8)

c0d032c8 <__aeabi_memclr>:
c0d032c8:	b510      	push	{r4, lr}
c0d032ca:	2200      	movs	r2, #0
c0d032cc:	f000 f806 	bl	c0d032dc <__aeabi_memset>
c0d032d0:	bd10      	pop	{r4, pc}
c0d032d2:	46c0      	nop			; (mov r8, r8)

c0d032d4 <__aeabi_memcpy>:
c0d032d4:	b510      	push	{r4, lr}
c0d032d6:	f000 f809 	bl	c0d032ec <memcpy>
c0d032da:	bd10      	pop	{r4, pc}

c0d032dc <__aeabi_memset>:
c0d032dc:	0013      	movs	r3, r2
c0d032de:	b510      	push	{r4, lr}
c0d032e0:	000a      	movs	r2, r1
c0d032e2:	0019      	movs	r1, r3
c0d032e4:	f000 f840 	bl	c0d03368 <memset>
c0d032e8:	bd10      	pop	{r4, pc}
c0d032ea:	46c0      	nop			; (mov r8, r8)

c0d032ec <memcpy>:
c0d032ec:	b570      	push	{r4, r5, r6, lr}
c0d032ee:	2a0f      	cmp	r2, #15
c0d032f0:	d932      	bls.n	c0d03358 <memcpy+0x6c>
c0d032f2:	000c      	movs	r4, r1
c0d032f4:	4304      	orrs	r4, r0
c0d032f6:	000b      	movs	r3, r1
c0d032f8:	07a4      	lsls	r4, r4, #30
c0d032fa:	d131      	bne.n	c0d03360 <memcpy+0x74>
c0d032fc:	0015      	movs	r5, r2
c0d032fe:	0004      	movs	r4, r0
c0d03300:	3d10      	subs	r5, #16
c0d03302:	092d      	lsrs	r5, r5, #4
c0d03304:	3501      	adds	r5, #1
c0d03306:	012d      	lsls	r5, r5, #4
c0d03308:	1949      	adds	r1, r1, r5
c0d0330a:	681e      	ldr	r6, [r3, #0]
c0d0330c:	6026      	str	r6, [r4, #0]
c0d0330e:	685e      	ldr	r6, [r3, #4]
c0d03310:	6066      	str	r6, [r4, #4]
c0d03312:	689e      	ldr	r6, [r3, #8]
c0d03314:	60a6      	str	r6, [r4, #8]
c0d03316:	68de      	ldr	r6, [r3, #12]
c0d03318:	3310      	adds	r3, #16
c0d0331a:	60e6      	str	r6, [r4, #12]
c0d0331c:	3410      	adds	r4, #16
c0d0331e:	4299      	cmp	r1, r3
c0d03320:	d1f3      	bne.n	c0d0330a <memcpy+0x1e>
c0d03322:	230f      	movs	r3, #15
c0d03324:	1945      	adds	r5, r0, r5
c0d03326:	4013      	ands	r3, r2
c0d03328:	2b03      	cmp	r3, #3
c0d0332a:	d91b      	bls.n	c0d03364 <memcpy+0x78>
c0d0332c:	1f1c      	subs	r4, r3, #4
c0d0332e:	2300      	movs	r3, #0
c0d03330:	08a4      	lsrs	r4, r4, #2
c0d03332:	3401      	adds	r4, #1
c0d03334:	00a4      	lsls	r4, r4, #2
c0d03336:	58ce      	ldr	r6, [r1, r3]
c0d03338:	50ee      	str	r6, [r5, r3]
c0d0333a:	3304      	adds	r3, #4
c0d0333c:	429c      	cmp	r4, r3
c0d0333e:	d1fa      	bne.n	c0d03336 <memcpy+0x4a>
c0d03340:	2303      	movs	r3, #3
c0d03342:	192d      	adds	r5, r5, r4
c0d03344:	1909      	adds	r1, r1, r4
c0d03346:	401a      	ands	r2, r3
c0d03348:	d005      	beq.n	c0d03356 <memcpy+0x6a>
c0d0334a:	2300      	movs	r3, #0
c0d0334c:	5ccc      	ldrb	r4, [r1, r3]
c0d0334e:	54ec      	strb	r4, [r5, r3]
c0d03350:	3301      	adds	r3, #1
c0d03352:	429a      	cmp	r2, r3
c0d03354:	d1fa      	bne.n	c0d0334c <memcpy+0x60>
c0d03356:	bd70      	pop	{r4, r5, r6, pc}
c0d03358:	0005      	movs	r5, r0
c0d0335a:	2a00      	cmp	r2, #0
c0d0335c:	d1f5      	bne.n	c0d0334a <memcpy+0x5e>
c0d0335e:	e7fa      	b.n	c0d03356 <memcpy+0x6a>
c0d03360:	0005      	movs	r5, r0
c0d03362:	e7f2      	b.n	c0d0334a <memcpy+0x5e>
c0d03364:	001a      	movs	r2, r3
c0d03366:	e7f8      	b.n	c0d0335a <memcpy+0x6e>

c0d03368 <memset>:
c0d03368:	b570      	push	{r4, r5, r6, lr}
c0d0336a:	0783      	lsls	r3, r0, #30
c0d0336c:	d03f      	beq.n	c0d033ee <memset+0x86>
c0d0336e:	1e54      	subs	r4, r2, #1
c0d03370:	2a00      	cmp	r2, #0
c0d03372:	d03b      	beq.n	c0d033ec <memset+0x84>
c0d03374:	b2ce      	uxtb	r6, r1
c0d03376:	0003      	movs	r3, r0
c0d03378:	2503      	movs	r5, #3
c0d0337a:	e003      	b.n	c0d03384 <memset+0x1c>
c0d0337c:	1e62      	subs	r2, r4, #1
c0d0337e:	2c00      	cmp	r4, #0
c0d03380:	d034      	beq.n	c0d033ec <memset+0x84>
c0d03382:	0014      	movs	r4, r2
c0d03384:	3301      	adds	r3, #1
c0d03386:	1e5a      	subs	r2, r3, #1
c0d03388:	7016      	strb	r6, [r2, #0]
c0d0338a:	422b      	tst	r3, r5
c0d0338c:	d1f6      	bne.n	c0d0337c <memset+0x14>
c0d0338e:	2c03      	cmp	r4, #3
c0d03390:	d924      	bls.n	c0d033dc <memset+0x74>
c0d03392:	25ff      	movs	r5, #255	; 0xff
c0d03394:	400d      	ands	r5, r1
c0d03396:	022a      	lsls	r2, r5, #8
c0d03398:	4315      	orrs	r5, r2
c0d0339a:	042a      	lsls	r2, r5, #16
c0d0339c:	4315      	orrs	r5, r2
c0d0339e:	2c0f      	cmp	r4, #15
c0d033a0:	d911      	bls.n	c0d033c6 <memset+0x5e>
c0d033a2:	0026      	movs	r6, r4
c0d033a4:	3e10      	subs	r6, #16
c0d033a6:	0936      	lsrs	r6, r6, #4
c0d033a8:	3601      	adds	r6, #1
c0d033aa:	0136      	lsls	r6, r6, #4
c0d033ac:	001a      	movs	r2, r3
c0d033ae:	199b      	adds	r3, r3, r6
c0d033b0:	6015      	str	r5, [r2, #0]
c0d033b2:	6055      	str	r5, [r2, #4]
c0d033b4:	6095      	str	r5, [r2, #8]
c0d033b6:	60d5      	str	r5, [r2, #12]
c0d033b8:	3210      	adds	r2, #16
c0d033ba:	4293      	cmp	r3, r2
c0d033bc:	d1f8      	bne.n	c0d033b0 <memset+0x48>
c0d033be:	220f      	movs	r2, #15
c0d033c0:	4014      	ands	r4, r2
c0d033c2:	2c03      	cmp	r4, #3
c0d033c4:	d90a      	bls.n	c0d033dc <memset+0x74>
c0d033c6:	1f26      	subs	r6, r4, #4
c0d033c8:	08b6      	lsrs	r6, r6, #2
c0d033ca:	3601      	adds	r6, #1
c0d033cc:	00b6      	lsls	r6, r6, #2
c0d033ce:	001a      	movs	r2, r3
c0d033d0:	199b      	adds	r3, r3, r6
c0d033d2:	c220      	stmia	r2!, {r5}
c0d033d4:	4293      	cmp	r3, r2
c0d033d6:	d1fc      	bne.n	c0d033d2 <memset+0x6a>
c0d033d8:	2203      	movs	r2, #3
c0d033da:	4014      	ands	r4, r2
c0d033dc:	2c00      	cmp	r4, #0
c0d033de:	d005      	beq.n	c0d033ec <memset+0x84>
c0d033e0:	b2c9      	uxtb	r1, r1
c0d033e2:	191c      	adds	r4, r3, r4
c0d033e4:	7019      	strb	r1, [r3, #0]
c0d033e6:	3301      	adds	r3, #1
c0d033e8:	429c      	cmp	r4, r3
c0d033ea:	d1fb      	bne.n	c0d033e4 <memset+0x7c>
c0d033ec:	bd70      	pop	{r4, r5, r6, pc}
c0d033ee:	0014      	movs	r4, r2
c0d033f0:	0003      	movs	r3, r0
c0d033f2:	e7cc      	b.n	c0d0338e <memset+0x26>

c0d033f4 <setjmp>:
c0d033f4:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d033f6:	4641      	mov	r1, r8
c0d033f8:	464a      	mov	r2, r9
c0d033fa:	4653      	mov	r3, sl
c0d033fc:	465c      	mov	r4, fp
c0d033fe:	466d      	mov	r5, sp
c0d03400:	4676      	mov	r6, lr
c0d03402:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03404:	3828      	subs	r0, #40	; 0x28
c0d03406:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03408:	2000      	movs	r0, #0
c0d0340a:	4770      	bx	lr

c0d0340c <longjmp>:
c0d0340c:	3010      	adds	r0, #16
c0d0340e:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03410:	4690      	mov	r8, r2
c0d03412:	4699      	mov	r9, r3
c0d03414:	46a2      	mov	sl, r4
c0d03416:	46ab      	mov	fp, r5
c0d03418:	46b5      	mov	sp, r6
c0d0341a:	c808      	ldmia	r0!, {r3}
c0d0341c:	3828      	subs	r0, #40	; 0x28
c0d0341e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03420:	1c08      	adds	r0, r1, #0
c0d03422:	d100      	bne.n	c0d03426 <longjmp+0x1a>
c0d03424:	2001      	movs	r0, #1
c0d03426:	4718      	bx	r3

c0d03428 <strlen>:
c0d03428:	b510      	push	{r4, lr}
c0d0342a:	0783      	lsls	r3, r0, #30
c0d0342c:	d027      	beq.n	c0d0347e <strlen+0x56>
c0d0342e:	7803      	ldrb	r3, [r0, #0]
c0d03430:	2b00      	cmp	r3, #0
c0d03432:	d026      	beq.n	c0d03482 <strlen+0x5a>
c0d03434:	0003      	movs	r3, r0
c0d03436:	2103      	movs	r1, #3
c0d03438:	e002      	b.n	c0d03440 <strlen+0x18>
c0d0343a:	781a      	ldrb	r2, [r3, #0]
c0d0343c:	2a00      	cmp	r2, #0
c0d0343e:	d01c      	beq.n	c0d0347a <strlen+0x52>
c0d03440:	3301      	adds	r3, #1
c0d03442:	420b      	tst	r3, r1
c0d03444:	d1f9      	bne.n	c0d0343a <strlen+0x12>
c0d03446:	6819      	ldr	r1, [r3, #0]
c0d03448:	4a0f      	ldr	r2, [pc, #60]	; (c0d03488 <strlen+0x60>)
c0d0344a:	4c10      	ldr	r4, [pc, #64]	; (c0d0348c <strlen+0x64>)
c0d0344c:	188a      	adds	r2, r1, r2
c0d0344e:	438a      	bics	r2, r1
c0d03450:	4222      	tst	r2, r4
c0d03452:	d10f      	bne.n	c0d03474 <strlen+0x4c>
c0d03454:	3304      	adds	r3, #4
c0d03456:	6819      	ldr	r1, [r3, #0]
c0d03458:	4a0b      	ldr	r2, [pc, #44]	; (c0d03488 <strlen+0x60>)
c0d0345a:	188a      	adds	r2, r1, r2
c0d0345c:	438a      	bics	r2, r1
c0d0345e:	4222      	tst	r2, r4
c0d03460:	d108      	bne.n	c0d03474 <strlen+0x4c>
c0d03462:	3304      	adds	r3, #4
c0d03464:	6819      	ldr	r1, [r3, #0]
c0d03466:	4a08      	ldr	r2, [pc, #32]	; (c0d03488 <strlen+0x60>)
c0d03468:	188a      	adds	r2, r1, r2
c0d0346a:	438a      	bics	r2, r1
c0d0346c:	4222      	tst	r2, r4
c0d0346e:	d0f1      	beq.n	c0d03454 <strlen+0x2c>
c0d03470:	e000      	b.n	c0d03474 <strlen+0x4c>
c0d03472:	3301      	adds	r3, #1
c0d03474:	781a      	ldrb	r2, [r3, #0]
c0d03476:	2a00      	cmp	r2, #0
c0d03478:	d1fb      	bne.n	c0d03472 <strlen+0x4a>
c0d0347a:	1a18      	subs	r0, r3, r0
c0d0347c:	bd10      	pop	{r4, pc}
c0d0347e:	0003      	movs	r3, r0
c0d03480:	e7e1      	b.n	c0d03446 <strlen+0x1e>
c0d03482:	2000      	movs	r0, #0
c0d03484:	e7fa      	b.n	c0d0347c <strlen+0x54>
c0d03486:	46c0      	nop			; (mov r8, r8)
c0d03488:	fefefeff 	.word	0xfefefeff
c0d0348c:	80808080 	.word	0x80808080
c0d03490:	45544550 	.word	0x45544550
c0d03494:	54455052 	.word	0x54455052
c0d03498:	45505245 	.word	0x45505245
c0d0349c:	50524554 	.word	0x50524554
c0d034a0:	52455445 	.word	0x52455445
c0d034a4:	45544550 	.word	0x45544550
c0d034a8:	54455052 	.word	0x54455052
c0d034ac:	45505245 	.word	0x45505245
c0d034b0:	50524554 	.word	0x50524554
c0d034b4:	52455445 	.word	0x52455445
c0d034b8:	45544550 	.word	0x45544550
c0d034bc:	54455052 	.word	0x54455052
c0d034c0:	45505245 	.word	0x45505245
c0d034c4:	50524554 	.word	0x50524554
c0d034c8:	52455445 	.word	0x52455445
c0d034cc:	45544550 	.word	0x45544550
c0d034d0:	54455052 	.word	0x54455052
c0d034d4:	45505245 	.word	0x45505245
c0d034d8:	50524554 	.word	0x50524554
c0d034dc:	52455445 	.word	0x52455445
c0d034e0:	00000052 	.word	0x00000052

c0d034e4 <trits_mapping>:
c0d034e4:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d034f4:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03504:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03514:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03524:	00000100 01000101 000101ff 01010101     ................
c0d03534:	00000001                                ....

c0d03538 <HALF_3_u>:
c0d03538:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d03548:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d03558:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d03568 <bagl_ui_nanos_screen1>:
c0d03568:	00000003 00800000 00000020 00000001     ........ .......
c0d03578:	00000000 00ffffff 00000000 00000000     ................
	...
c0d035a0:	00000107 0080000c 00000020 00000000     ........ .......
c0d035b0:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d035d8:	00030005 0007000c 00000007 00000000     ................
	...
c0d035f0:	00070000 00000000 00000000 00000000     ................
	...
c0d03610:	00750005 0008000d 00000006 00000000     ..u.............
c0d03620:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03648 <bagl_ui_nanos_screen2>:
c0d03648:	00000003 00800000 00000020 00000001     ........ .......
c0d03658:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03680:	00000107 00800012 00000020 00000000     ........ .......
c0d03690:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d036b8:	00030005 0007000c 00000007 00000000     ................
	...
c0d036d0:	00070000 00000000 00000000 00000000     ................
	...
c0d036f0:	00750005 0008000d 00000006 00000000     ..u.............
c0d03700:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03728 <bagl_ui_sample_blue>:
c0d03728:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03738:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03760:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03770:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03798:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d037a8:	00ffffff 001d2028 00002004 c0d03808     ....( ... ...8..
	...
c0d037d0:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d037e0:	0041ccb4 00f9f9f9 0000a004 c0d03814     ..A..........8..
c0d037f0:	00000000 0037ae99 00f9f9f9 c0d02255     ......7.....U"..
	...
c0d03808:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03819 <USBD_PRODUCT_FS_STRING>:
c0d03819:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03827 <HID_ReportDesc>:
c0d03827:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03837:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03847:	0000c008 11210900                                .....

c0d0384c <USBD_HID_Desc>:
c0d0384c:	01112109 22220100 00011200                       .!...."".

c0d03855 <USBD_DeviceDesc>:
c0d03855:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03865:	65000103                                         ...

c0d03868 <HID_Desc>:
c0d03868:	c0d02e65 c0d02e75 c0d02e85 c0d02e95     e...u...........
c0d03878:	c0d02ea5 c0d02eb5 c0d02ec5 00000000     ................

c0d03888 <USBD_LangIDDesc>:
c0d03888:	04090304                                ....

c0d0388c <USBD_MANUFACTURER_STRING>:
c0d0388c:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d0389a <USB_SERIAL_STRING>:
c0d0389a:	0030030a 00300030 2d470031                       ..0.0.0.1.

c0d038a4 <USBD_HID>:
c0d038a4:	c0d02d47 c0d02d79 c0d02cab 00000000     G-..y-...,......
	...
c0d038bc:	c0d02db1 00000000 00000000 00000000     .-..............
c0d038cc:	c0d02ed5 c0d02ed5 c0d02ed5 c0d02ee5     ................

c0d038dc <USBD_CfgDesc>:
c0d038dc:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d038ec:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d038fc:	05070100 00400302 00000001              ......@.....

c0d03908 <USBD_DeviceQualifierDesc>:
c0d03908:	0200060a 40000000 00000001              .......@....

c0d03914 <_etext>:
	...

c0d03940 <N_storage_real>:
	...
