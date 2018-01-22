
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
c0d00014:	f000 fde6 	bl	c0d00be4 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fd32 	bl	c0d00a80 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f8b9 	bl	c0d0319c <setjmp>
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
c0d00040:	f000 ff76 	bl	c0d00f30 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fc57 	bl	c0d018f8 <pic>
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
c0d0005a:	f001 fc4d 	bl	c0d018f8 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fc9b 	bl	c0d0199c <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fda2 	bl	c0d02bb0 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fd9f 	bl	c0d02bb0 <USB_power>

            ui_idle();
c0d00072:	f001 ff33 	bl	c0d01edc <ui_idle>

            IOTA_main();
c0d00076:	f000 fb9b 	bl	c0d007b0 <IOTA_main>
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
c0d0008c:	f003 f892 	bl	c0d031b4 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d036c0 	.word	0xc0d036c0

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
c0d000ca:	f001 f9c5 	bl	c0d01458 <snprintf>
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
c0d00192:	f002 fe55 	bl	c0d02e40 <__aeabi_idiv>
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
c0d001c0:	f002 fdb4 	bl	c0d02d2c <__aeabi_uidiv>
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
c0d001e4:	f000 f930 	bl	c0d00448 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001e8:	f000 f92e 	bl	c0d00448 <kerl_initialize>
c0d001ec:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001ee:	4630      	mov	r0, r6
c0d001f0:	4621      	mov	r1, r4
c0d001f2:	462a      	mov	r2, r5
c0d001f4:	f002 ff42 	bl	c0d0307c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001f8:	1970      	adds	r0, r6, r5
c0d001fa:	2130      	movs	r1, #48	; 0x30
c0d001fc:	1b4a      	subs	r2, r1, r5
c0d001fe:	460d      	mov	r5, r1
c0d00200:	9502      	str	r5, [sp, #8]
c0d00202:	4621      	mov	r1, r4
c0d00204:	f002 ff3a 	bl	c0d0307c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00208:	4630      	mov	r0, r6
c0d0020a:	4629      	mov	r1, r5
c0d0020c:	f000 f928 	bl	c0d00460 <kerl_absorb_bytes>
c0d00210:	ac41      	add	r4, sp, #260	; 0x104
c0d00212:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00214:	4620      	mov	r0, r4
c0d00216:	4629      	mov	r1, r5
c0d00218:	f002 ff2a 	bl	c0d03070 <__aeabi_memclr>
c0d0021c:	ae04      	add	r6, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021e:	491c      	ldr	r1, [pc, #112]	; (c0d00290 <get_seed+0xb8>)
c0d00220:	4479      	add	r1, pc
c0d00222:	2252      	movs	r2, #82	; 0x52
c0d00224:	4630      	mov	r0, r6
c0d00226:	f002 ff29 	bl	c0d0307c <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d0022a:	4630      	mov	r0, r6
c0d0022c:	4621      	mov	r1, r4
c0d0022e:	462a      	mov	r2, r5
c0d00230:	f000 f886 	bl	c0d00340 <chars_to_trytes>
c0d00234:	ae04      	add	r6, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00236:	21f3      	movs	r1, #243	; 0xf3
c0d00238:	4630      	mov	r0, r6
c0d0023a:	f002 ff19 	bl	c0d03070 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0023e:	4620      	mov	r0, r4
c0d00240:	4631      	mov	r1, r6
c0d00242:	462a      	mov	r2, r5
c0d00244:	f000 f85e 	bl	c0d00304 <trytes_to_trits>
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
c0d00258:	f002 ff0a 	bl	c0d03070 <__aeabi_memclr>
        trints_to_words_u_mem(seed_trints, words);
c0d0025c:	4620      	mov	r0, r4
c0d0025e:	4631      	mov	r1, r6
c0d00260:	f000 f884 	bl	c0d0036c <trints_to_words_u_mem>
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
c0d00276:	f001 f8ef 	bl	c0d01458 <snprintf>
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
c0d00290:	00003014 	.word	0x00003014

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
	...

c0d00304 <trytes_to_trits>:
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00304:	b5b0      	push	{r4, r5, r7, lr}
c0d00306:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00308:	2a00      	cmp	r2, #0
c0d0030a:	d015      	beq.n	c0d00338 <trytes_to_trits+0x34>
c0d0030c:	4b0b      	ldr	r3, [pc, #44]	; (c0d0033c <trytes_to_trits+0x38>)
c0d0030e:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00310:	240d      	movs	r4, #13
c0d00312:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00314:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00316:	062d      	lsls	r5, r5, #24
c0d00318:	192c      	adds	r4, r5, r4
c0d0031a:	1624      	asrs	r4, r4, #24
c0d0031c:	2503      	movs	r5, #3
c0d0031e:	4365      	muls	r5, r4
c0d00320:	5d5c      	ldrb	r4, [r3, r5]
c0d00322:	700c      	strb	r4, [r1, #0]
c0d00324:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00326:	7865      	ldrb	r5, [r4, #1]
c0d00328:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0032a:	78a4      	ldrb	r4, [r4, #2]
c0d0032c:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0032e:	1e52      	subs	r2, r2, #1
c0d00330:	1cc9      	adds	r1, r1, #3
c0d00332:	1c40      	adds	r0, r0, #1
c0d00334:	2a00      	cmp	r2, #0
c0d00336:	d1eb      	bne.n	c0d00310 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00338:	2000      	movs	r0, #0
c0d0033a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0033c:	00002f7a 	.word	0x00002f7a

c0d00340 <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00340:	b5d0      	push	{r4, r6, r7, lr}
c0d00342:	af02      	add	r7, sp, #8
c0d00344:	e00e      	b.n	c0d00364 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00346:	7803      	ldrb	r3, [r0, #0]
c0d00348:	b25b      	sxtb	r3, r3
c0d0034a:	2400      	movs	r4, #0
c0d0034c:	2b39      	cmp	r3, #57	; 0x39
c0d0034e:	d005      	beq.n	c0d0035c <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00350:	2b4e      	cmp	r3, #78	; 0x4e
c0d00352:	db01      	blt.n	c0d00358 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00354:	33a5      	adds	r3, #165	; 0xa5
c0d00356:	e000      	b.n	c0d0035a <chars_to_trytes+0x1a>
c0d00358:	33c0      	adds	r3, #192	; 0xc0
c0d0035a:	461c      	mov	r4, r3
c0d0035c:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0035e:	1e52      	subs	r2, r2, #1
c0d00360:	1c40      	adds	r0, r0, #1
c0d00362:	1c49      	adds	r1, r1, #1
c0d00364:	2a00      	cmp	r2, #0
c0d00366:	d1ee      	bne.n	c0d00346 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d00368:	2000      	movs	r0, #0
c0d0036a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0036c <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d0036c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0036e:	af03      	add	r7, sp, #12
c0d00370:	b089      	sub	sp, #36	; 0x24
c0d00372:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d00374:	2130      	movs	r1, #48	; 0x30
c0d00376:	9000      	str	r0, [sp, #0]
c0d00378:	5640      	ldrsb	r0, [r0, r1]
c0d0037a:	a907      	add	r1, sp, #28
c0d0037c:	2203      	movs	r2, #3
c0d0037e:	f7ff fef3 	bl	c0d00168 <trint_to_trits>
c0d00382:	2001      	movs	r0, #1
c0d00384:	24f1      	movs	r4, #241	; 0xf1
c0d00386:	9606      	str	r6, [sp, #24]
c0d00388:	9004      	str	r0, [sp, #16]

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit

        if(i%5 == 4) //we need a new trint
c0d0038a:	2105      	movs	r1, #5
c0d0038c:	4620      	mov	r0, r4
c0d0038e:	f002 fe3d 	bl	c0d0300c <__aeabi_idivmod>
c0d00392:	460e      	mov	r6, r1
c0d00394:	2e04      	cmp	r6, #4
c0d00396:	d10b      	bne.n	c0d003b0 <trints_to_words_u_mem+0x44>
c0d00398:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d0039a:	4620      	mov	r0, r4
c0d0039c:	4629      	mov	r1, r5
c0d0039e:	f002 fd4f 	bl	c0d02e40 <__aeabi_idiv>
c0d003a2:	b2c0      	uxtb	r0, r0
c0d003a4:	9900      	ldr	r1, [sp, #0]
c0d003a6:	5608      	ldrsb	r0, [r1, r0]
c0d003a8:	a907      	add	r1, sp, #28
c0d003aa:	462a      	mov	r2, r5
c0d003ac:	f7ff fedc 	bl	c0d00168 <trint_to_trits>
c0d003b0:	a807      	add	r0, sp, #28

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d003b2:	5d80      	ldrb	r0, [r0, r6]
c0d003b4:	1c41      	adds	r1, r0, #1
c0d003b6:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d003b8:	9804      	ldr	r0, [sp, #16]
c0d003ba:	2800      	cmp	r0, #0
c0d003bc:	d022      	beq.n	c0d00404 <trints_to_words_u_mem+0x98>
c0d003be:	9101      	str	r1, [sp, #4]
c0d003c0:	9402      	str	r4, [sp, #8]
c0d003c2:	2500      	movs	r5, #0
c0d003c4:	462e      	mov	r6, r5
c0d003c6:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d003c8:	00b1      	lsls	r1, r6, #2
c0d003ca:	9105      	str	r1, [sp, #20]
c0d003cc:	9806      	ldr	r0, [sp, #24]
c0d003ce:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d003d0:	2203      	movs	r2, #3
c0d003d2:	9c03      	ldr	r4, [sp, #12]
c0d003d4:	4621      	mov	r1, r4
c0d003d6:	4623      	mov	r3, r4
c0d003d8:	f002 fe1e 	bl	c0d03018 <__aeabi_lmul>
c0d003dc:	9b04      	ldr	r3, [sp, #16]
c0d003de:	1940      	adds	r0, r0, r5
c0d003e0:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d003e2:	9a06      	ldr	r2, [sp, #24]
c0d003e4:	9c05      	ldr	r4, [sp, #20]
c0d003e6:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d003e8:	1c76      	adds	r6, r6, #1
c0d003ea:	42b3      	cmp	r3, r6
c0d003ec:	460d      	mov	r5, r1
c0d003ee:	d1eb      	bne.n	c0d003c8 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d003f0:	2900      	cmp	r1, #0
c0d003f2:	d004      	beq.n	c0d003fe <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d003f4:	0098      	lsls	r0, r3, #2
c0d003f6:	9a06      	ldr	r2, [sp, #24]
c0d003f8:	5011      	str	r1, [r2, r0]
                size++;
c0d003fa:	1c5d      	adds	r5, r3, #1
c0d003fc:	e000      	b.n	c0d00400 <trints_to_words_u_mem+0x94>
c0d003fe:	461d      	mov	r5, r3
c0d00400:	9c02      	ldr	r4, [sp, #8]
c0d00402:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00404:	b2c9      	uxtb	r1, r1
c0d00406:	220c      	movs	r2, #12
c0d00408:	9e06      	ldr	r6, [sp, #24]
c0d0040a:	4630      	mov	r0, r6
c0d0040c:	f7ff ff42 	bl	c0d00294 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d00410:	42a8      	cmp	r0, r5
c0d00412:	d800      	bhi.n	c0d00416 <trints_to_words_u_mem+0xaa>
c0d00414:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00416:	1e61      	subs	r1, r4, #1
c0d00418:	2c00      	cmp	r4, #0
c0d0041a:	460c      	mov	r4, r1
c0d0041c:	dcb4      	bgt.n	c0d00388 <trints_to_words_u_mem+0x1c>
c0d0041e:	2000      	movs	r0, #0
    //hang start
    

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d00420:	0081      	lsls	r1, r0, #2
c0d00422:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d00424:	1a73      	subs	r3, r6, r1
c0d00426:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d00428:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d0042a:	62da      	str	r2, [r3, #44]	; 0x2c

    //hang start
    

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d0042c:	1c40      	adds	r0, r0, #1
c0d0042e:	2806      	cmp	r0, #6
c0d00430:	d1f6      	bne.n	c0d00420 <trints_to_words_u_mem+0xb4>
c0d00432:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00434:	0081      	lsls	r1, r0, #2
c0d00436:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d00438:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d0043a:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d0043c:	1c40      	adds	r0, r0, #1
c0d0043e:	280c      	cmp	r0, #12
c0d00440:	d1f8      	bne.n	c0d00434 <trints_to_words_u_mem+0xc8>
        base[i] = swap32(base[i]);
    }
    // hang end

    //outputs correct words according to official js
    return 0;
c0d00442:	2000      	movs	r0, #0
c0d00444:	b009      	add	sp, #36	; 0x24
c0d00446:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00448 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00448:	b580      	push	{r7, lr}
c0d0044a:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d0044c:	2003      	movs	r0, #3
c0d0044e:	01c1      	lsls	r1, r0, #7
c0d00450:	4802      	ldr	r0, [pc, #8]	; (c0d0045c <kerl_initialize+0x14>)
c0d00452:	f001 fafd 	bl	c0d01a50 <cx_keccak_init>
    return 0;
c0d00456:	2000      	movs	r0, #0
c0d00458:	bd80      	pop	{r7, pc}
c0d0045a:	46c0      	nop			; (mov r8, r8)
c0d0045c:	20001840 	.word	0x20001840

c0d00460 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00460:	b580      	push	{r7, lr}
c0d00462:	af00      	add	r7, sp, #0
c0d00464:	b082      	sub	sp, #8
c0d00466:	460b      	mov	r3, r1
c0d00468:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0046a:	4805      	ldr	r0, [pc, #20]	; (c0d00480 <kerl_absorb_bytes+0x20>)
c0d0046c:	4669      	mov	r1, sp
c0d0046e:	6008      	str	r0, [r1, #0]
c0d00470:	4804      	ldr	r0, [pc, #16]	; (c0d00484 <kerl_absorb_bytes+0x24>)
c0d00472:	2101      	movs	r1, #1
c0d00474:	f001 fb0a 	bl	c0d01a8c <cx_hash>
c0d00478:	2000      	movs	r0, #0
    return 0;
c0d0047a:	b002      	add	sp, #8
c0d0047c:	bd80      	pop	{r7, pc}
c0d0047e:	46c0      	nop			; (mov r8, r8)
c0d00480:	200019e8 	.word	0x200019e8
c0d00484:	20001840 	.word	0x20001840

c0d00488 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00488:	b580      	push	{r7, lr}
c0d0048a:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d0048c:	4804      	ldr	r0, [pc, #16]	; (c0d004a0 <nvram_is_init+0x18>)
c0d0048e:	f001 fa33 	bl	c0d018f8 <pic>
c0d00492:	7801      	ldrb	r1, [r0, #0]
c0d00494:	2000      	movs	r0, #0
c0d00496:	2901      	cmp	r1, #1
c0d00498:	d100      	bne.n	c0d0049c <nvram_is_init+0x14>
c0d0049a:	4608      	mov	r0, r1
    else return true;
}
c0d0049c:	bd80      	pop	{r7, pc}
c0d0049e:	46c0      	nop			; (mov r8, r8)
c0d004a0:	c0d036c0 	.word	0xc0d036c0

c0d004a4 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d004a4:	b5b0      	push	{r4, r5, r7, lr}
c0d004a6:	af02      	add	r7, sp, #8
c0d004a8:	4605      	mov	r5, r0
c0d004aa:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d004ac:	4028      	ands	r0, r5
c0d004ae:	2400      	movs	r4, #0
c0d004b0:	2801      	cmp	r0, #1
c0d004b2:	d013      	beq.n	c0d004dc <io_exchange_al+0x38>
c0d004b4:	2802      	cmp	r0, #2
c0d004b6:	d113      	bne.n	c0d004e0 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d004b8:	2900      	cmp	r1, #0
c0d004ba:	d008      	beq.n	c0d004ce <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d004bc:	480b      	ldr	r0, [pc, #44]	; (c0d004ec <io_exchange_al+0x48>)
c0d004be:	f001 fbd7 	bl	c0d01c70 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d004c2:	b268      	sxtb	r0, r5
c0d004c4:	2800      	cmp	r0, #0
c0d004c6:	da09      	bge.n	c0d004dc <io_exchange_al+0x38>
                reset();
c0d004c8:	f001 fa4c 	bl	c0d01964 <reset>
c0d004cc:	e006      	b.n	c0d004dc <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d004ce:	2041      	movs	r0, #65	; 0x41
c0d004d0:	0081      	lsls	r1, r0, #2
c0d004d2:	4806      	ldr	r0, [pc, #24]	; (c0d004ec <io_exchange_al+0x48>)
c0d004d4:	2200      	movs	r2, #0
c0d004d6:	f001 fc05 	bl	c0d01ce4 <io_seproxyhal_spi_recv>
c0d004da:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d004dc:	4620      	mov	r0, r4
c0d004de:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d004e0:	4803      	ldr	r0, [pc, #12]	; (c0d004f0 <io_exchange_al+0x4c>)
c0d004e2:	6800      	ldr	r0, [r0, #0]
c0d004e4:	2102      	movs	r1, #2
c0d004e6:	f002 fe65 	bl	c0d031b4 <longjmp>
c0d004ea:	46c0      	nop			; (mov r8, r8)
c0d004ec:	20001c08 	.word	0x20001c08
c0d004f0:	20001bb8 	.word	0x20001bb8

c0d004f4 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d004f4:	b580      	push	{r7, lr}
c0d004f6:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d004f8:	f000 fe8e 	bl	c0d01218 <io_seproxyhal_display_default>
}
c0d004fc:	bd80      	pop	{r7, pc}
	...

c0d00500 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00500:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00502:	af03      	add	r7, sp, #12
c0d00504:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00506:	48a6      	ldr	r0, [pc, #664]	; (c0d007a0 <io_event+0x2a0>)
c0d00508:	7800      	ldrb	r0, [r0, #0]
c0d0050a:	2805      	cmp	r0, #5
c0d0050c:	d02e      	beq.n	c0d0056c <io_event+0x6c>
c0d0050e:	280d      	cmp	r0, #13
c0d00510:	d04e      	beq.n	c0d005b0 <io_event+0xb0>
c0d00512:	280c      	cmp	r0, #12
c0d00514:	d000      	beq.n	c0d00518 <io_event+0x18>
c0d00516:	e13a      	b.n	c0d0078e <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00518:	4ea2      	ldr	r6, [pc, #648]	; (c0d007a4 <io_event+0x2a4>)
c0d0051a:	2001      	movs	r0, #1
c0d0051c:	7630      	strb	r0, [r6, #24]
c0d0051e:	2500      	movs	r5, #0
c0d00520:	61f5      	str	r5, [r6, #28]
c0d00522:	4634      	mov	r4, r6
c0d00524:	3418      	adds	r4, #24
c0d00526:	4620      	mov	r0, r4
c0d00528:	f001 fb68 	bl	c0d01bfc <os_ux>
c0d0052c:	61f0      	str	r0, [r6, #28]
c0d0052e:	499e      	ldr	r1, [pc, #632]	; (c0d007a8 <io_event+0x2a8>)
c0d00530:	4288      	cmp	r0, r1
c0d00532:	d100      	bne.n	c0d00536 <io_event+0x36>
c0d00534:	e12b      	b.n	c0d0078e <io_event+0x28e>
c0d00536:	2800      	cmp	r0, #0
c0d00538:	d100      	bne.n	c0d0053c <io_event+0x3c>
c0d0053a:	e128      	b.n	c0d0078e <io_event+0x28e>
c0d0053c:	499b      	ldr	r1, [pc, #620]	; (c0d007ac <io_event+0x2ac>)
c0d0053e:	4288      	cmp	r0, r1
c0d00540:	d000      	beq.n	c0d00544 <io_event+0x44>
c0d00542:	e0ac      	b.n	c0d0069e <io_event+0x19e>
c0d00544:	2003      	movs	r0, #3
c0d00546:	7630      	strb	r0, [r6, #24]
c0d00548:	61f5      	str	r5, [r6, #28]
c0d0054a:	4620      	mov	r0, r4
c0d0054c:	f001 fb56 	bl	c0d01bfc <os_ux>
c0d00550:	61f0      	str	r0, [r6, #28]
c0d00552:	f000 fd17 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d00556:	60b5      	str	r5, [r6, #8]
c0d00558:	6830      	ldr	r0, [r6, #0]
c0d0055a:	2800      	cmp	r0, #0
c0d0055c:	d100      	bne.n	c0d00560 <io_event+0x60>
c0d0055e:	e116      	b.n	c0d0078e <io_event+0x28e>
c0d00560:	69f0      	ldr	r0, [r6, #28]
c0d00562:	4991      	ldr	r1, [pc, #580]	; (c0d007a8 <io_event+0x2a8>)
c0d00564:	4288      	cmp	r0, r1
c0d00566:	d000      	beq.n	c0d0056a <io_event+0x6a>
c0d00568:	e096      	b.n	c0d00698 <io_event+0x198>
c0d0056a:	e110      	b.n	c0d0078e <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0056c:	4d8d      	ldr	r5, [pc, #564]	; (c0d007a4 <io_event+0x2a4>)
c0d0056e:	2001      	movs	r0, #1
c0d00570:	7628      	strb	r0, [r5, #24]
c0d00572:	2600      	movs	r6, #0
c0d00574:	61ee      	str	r6, [r5, #28]
c0d00576:	462c      	mov	r4, r5
c0d00578:	3418      	adds	r4, #24
c0d0057a:	4620      	mov	r0, r4
c0d0057c:	f001 fb3e 	bl	c0d01bfc <os_ux>
c0d00580:	4601      	mov	r1, r0
c0d00582:	61e9      	str	r1, [r5, #28]
c0d00584:	4889      	ldr	r0, [pc, #548]	; (c0d007ac <io_event+0x2ac>)
c0d00586:	4281      	cmp	r1, r0
c0d00588:	d15d      	bne.n	c0d00646 <io_event+0x146>
c0d0058a:	2003      	movs	r0, #3
c0d0058c:	7628      	strb	r0, [r5, #24]
c0d0058e:	61ee      	str	r6, [r5, #28]
c0d00590:	4620      	mov	r0, r4
c0d00592:	f001 fb33 	bl	c0d01bfc <os_ux>
c0d00596:	61e8      	str	r0, [r5, #28]
c0d00598:	f000 fcf4 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d0059c:	60ae      	str	r6, [r5, #8]
c0d0059e:	6828      	ldr	r0, [r5, #0]
c0d005a0:	2800      	cmp	r0, #0
c0d005a2:	d100      	bne.n	c0d005a6 <io_event+0xa6>
c0d005a4:	e0f3      	b.n	c0d0078e <io_event+0x28e>
c0d005a6:	69e8      	ldr	r0, [r5, #28]
c0d005a8:	497f      	ldr	r1, [pc, #508]	; (c0d007a8 <io_event+0x2a8>)
c0d005aa:	4288      	cmp	r0, r1
c0d005ac:	d148      	bne.n	c0d00640 <io_event+0x140>
c0d005ae:	e0ee      	b.n	c0d0078e <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d005b0:	4d7c      	ldr	r5, [pc, #496]	; (c0d007a4 <io_event+0x2a4>)
c0d005b2:	6868      	ldr	r0, [r5, #4]
c0d005b4:	68a9      	ldr	r1, [r5, #8]
c0d005b6:	4281      	cmp	r1, r0
c0d005b8:	d300      	bcc.n	c0d005bc <io_event+0xbc>
c0d005ba:	e0e8      	b.n	c0d0078e <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d005bc:	2001      	movs	r0, #1
c0d005be:	7628      	strb	r0, [r5, #24]
c0d005c0:	2600      	movs	r6, #0
c0d005c2:	61ee      	str	r6, [r5, #28]
c0d005c4:	462c      	mov	r4, r5
c0d005c6:	3418      	adds	r4, #24
c0d005c8:	4620      	mov	r0, r4
c0d005ca:	f001 fb17 	bl	c0d01bfc <os_ux>
c0d005ce:	61e8      	str	r0, [r5, #28]
c0d005d0:	4975      	ldr	r1, [pc, #468]	; (c0d007a8 <io_event+0x2a8>)
c0d005d2:	4288      	cmp	r0, r1
c0d005d4:	d100      	bne.n	c0d005d8 <io_event+0xd8>
c0d005d6:	e0da      	b.n	c0d0078e <io_event+0x28e>
c0d005d8:	2800      	cmp	r0, #0
c0d005da:	d100      	bne.n	c0d005de <io_event+0xde>
c0d005dc:	e0d7      	b.n	c0d0078e <io_event+0x28e>
c0d005de:	4973      	ldr	r1, [pc, #460]	; (c0d007ac <io_event+0x2ac>)
c0d005e0:	4288      	cmp	r0, r1
c0d005e2:	d000      	beq.n	c0d005e6 <io_event+0xe6>
c0d005e4:	e08d      	b.n	c0d00702 <io_event+0x202>
c0d005e6:	2003      	movs	r0, #3
c0d005e8:	7628      	strb	r0, [r5, #24]
c0d005ea:	61ee      	str	r6, [r5, #28]
c0d005ec:	4620      	mov	r0, r4
c0d005ee:	f001 fb05 	bl	c0d01bfc <os_ux>
c0d005f2:	61e8      	str	r0, [r5, #28]
c0d005f4:	f000 fcc6 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d005f8:	60ae      	str	r6, [r5, #8]
c0d005fa:	6828      	ldr	r0, [r5, #0]
c0d005fc:	2800      	cmp	r0, #0
c0d005fe:	d100      	bne.n	c0d00602 <io_event+0x102>
c0d00600:	e0c5      	b.n	c0d0078e <io_event+0x28e>
c0d00602:	69e8      	ldr	r0, [r5, #28]
c0d00604:	4968      	ldr	r1, [pc, #416]	; (c0d007a8 <io_event+0x2a8>)
c0d00606:	4288      	cmp	r0, r1
c0d00608:	d178      	bne.n	c0d006fc <io_event+0x1fc>
c0d0060a:	e0c0      	b.n	c0d0078e <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0060c:	6868      	ldr	r0, [r5, #4]
c0d0060e:	4286      	cmp	r6, r0
c0d00610:	d300      	bcc.n	c0d00614 <io_event+0x114>
c0d00612:	e0bc      	b.n	c0d0078e <io_event+0x28e>
c0d00614:	f001 fb4a 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00618:	2800      	cmp	r0, #0
c0d0061a:	d000      	beq.n	c0d0061e <io_event+0x11e>
c0d0061c:	e0b7      	b.n	c0d0078e <io_event+0x28e>
c0d0061e:	68a8      	ldr	r0, [r5, #8]
c0d00620:	68e9      	ldr	r1, [r5, #12]
c0d00622:	2438      	movs	r4, #56	; 0x38
c0d00624:	4360      	muls	r0, r4
c0d00626:	682a      	ldr	r2, [r5, #0]
c0d00628:	1810      	adds	r0, r2, r0
c0d0062a:	2900      	cmp	r1, #0
c0d0062c:	d100      	bne.n	c0d00630 <io_event+0x130>
c0d0062e:	e085      	b.n	c0d0073c <io_event+0x23c>
c0d00630:	4788      	blx	r1
c0d00632:	2800      	cmp	r0, #0
c0d00634:	d000      	beq.n	c0d00638 <io_event+0x138>
c0d00636:	e081      	b.n	c0d0073c <io_event+0x23c>
c0d00638:	68a8      	ldr	r0, [r5, #8]
c0d0063a:	1c46      	adds	r6, r0, #1
c0d0063c:	60ae      	str	r6, [r5, #8]
c0d0063e:	6828      	ldr	r0, [r5, #0]
c0d00640:	2800      	cmp	r0, #0
c0d00642:	d1e3      	bne.n	c0d0060c <io_event+0x10c>
c0d00644:	e0a3      	b.n	c0d0078e <io_event+0x28e>
c0d00646:	6928      	ldr	r0, [r5, #16]
c0d00648:	2800      	cmp	r0, #0
c0d0064a:	d100      	bne.n	c0d0064e <io_event+0x14e>
c0d0064c:	e09f      	b.n	c0d0078e <io_event+0x28e>
c0d0064e:	4a56      	ldr	r2, [pc, #344]	; (c0d007a8 <io_event+0x2a8>)
c0d00650:	4291      	cmp	r1, r2
c0d00652:	d100      	bne.n	c0d00656 <io_event+0x156>
c0d00654:	e09b      	b.n	c0d0078e <io_event+0x28e>
c0d00656:	2900      	cmp	r1, #0
c0d00658:	d100      	bne.n	c0d0065c <io_event+0x15c>
c0d0065a:	e098      	b.n	c0d0078e <io_event+0x28e>
c0d0065c:	4950      	ldr	r1, [pc, #320]	; (c0d007a0 <io_event+0x2a0>)
c0d0065e:	78c9      	ldrb	r1, [r1, #3]
c0d00660:	0849      	lsrs	r1, r1, #1
c0d00662:	f000 fe1b 	bl	c0d0129c <io_seproxyhal_button_push>
c0d00666:	e092      	b.n	c0d0078e <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00668:	6870      	ldr	r0, [r6, #4]
c0d0066a:	4285      	cmp	r5, r0
c0d0066c:	d300      	bcc.n	c0d00670 <io_event+0x170>
c0d0066e:	e08e      	b.n	c0d0078e <io_event+0x28e>
c0d00670:	f001 fb1c 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00674:	2800      	cmp	r0, #0
c0d00676:	d000      	beq.n	c0d0067a <io_event+0x17a>
c0d00678:	e089      	b.n	c0d0078e <io_event+0x28e>
c0d0067a:	68b0      	ldr	r0, [r6, #8]
c0d0067c:	68f1      	ldr	r1, [r6, #12]
c0d0067e:	2438      	movs	r4, #56	; 0x38
c0d00680:	4360      	muls	r0, r4
c0d00682:	6832      	ldr	r2, [r6, #0]
c0d00684:	1810      	adds	r0, r2, r0
c0d00686:	2900      	cmp	r1, #0
c0d00688:	d076      	beq.n	c0d00778 <io_event+0x278>
c0d0068a:	4788      	blx	r1
c0d0068c:	2800      	cmp	r0, #0
c0d0068e:	d173      	bne.n	c0d00778 <io_event+0x278>
c0d00690:	68b0      	ldr	r0, [r6, #8]
c0d00692:	1c45      	adds	r5, r0, #1
c0d00694:	60b5      	str	r5, [r6, #8]
c0d00696:	6830      	ldr	r0, [r6, #0]
c0d00698:	2800      	cmp	r0, #0
c0d0069a:	d1e5      	bne.n	c0d00668 <io_event+0x168>
c0d0069c:	e077      	b.n	c0d0078e <io_event+0x28e>
c0d0069e:	88b0      	ldrh	r0, [r6, #4]
c0d006a0:	9004      	str	r0, [sp, #16]
c0d006a2:	6830      	ldr	r0, [r6, #0]
c0d006a4:	9003      	str	r0, [sp, #12]
c0d006a6:	483e      	ldr	r0, [pc, #248]	; (c0d007a0 <io_event+0x2a0>)
c0d006a8:	4601      	mov	r1, r0
c0d006aa:	79cc      	ldrb	r4, [r1, #7]
c0d006ac:	798b      	ldrb	r3, [r1, #6]
c0d006ae:	794d      	ldrb	r5, [r1, #5]
c0d006b0:	790a      	ldrb	r2, [r1, #4]
c0d006b2:	4630      	mov	r0, r6
c0d006b4:	78ce      	ldrb	r6, [r1, #3]
c0d006b6:	68c1      	ldr	r1, [r0, #12]
c0d006b8:	4668      	mov	r0, sp
c0d006ba:	6006      	str	r6, [r0, #0]
c0d006bc:	6041      	str	r1, [r0, #4]
c0d006be:	0212      	lsls	r2, r2, #8
c0d006c0:	432a      	orrs	r2, r5
c0d006c2:	021b      	lsls	r3, r3, #8
c0d006c4:	4323      	orrs	r3, r4
c0d006c6:	9803      	ldr	r0, [sp, #12]
c0d006c8:	9904      	ldr	r1, [sp, #16]
c0d006ca:	f000 fcd5 	bl	c0d01078 <io_seproxyhal_touch_element_callback>
c0d006ce:	e05e      	b.n	c0d0078e <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d006d0:	6868      	ldr	r0, [r5, #4]
c0d006d2:	4286      	cmp	r6, r0
c0d006d4:	d25b      	bcs.n	c0d0078e <io_event+0x28e>
c0d006d6:	f001 fae9 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d006da:	2800      	cmp	r0, #0
c0d006dc:	d157      	bne.n	c0d0078e <io_event+0x28e>
c0d006de:	68a8      	ldr	r0, [r5, #8]
c0d006e0:	68e9      	ldr	r1, [r5, #12]
c0d006e2:	2438      	movs	r4, #56	; 0x38
c0d006e4:	4360      	muls	r0, r4
c0d006e6:	682a      	ldr	r2, [r5, #0]
c0d006e8:	1810      	adds	r0, r2, r0
c0d006ea:	2900      	cmp	r1, #0
c0d006ec:	d026      	beq.n	c0d0073c <io_event+0x23c>
c0d006ee:	4788      	blx	r1
c0d006f0:	2800      	cmp	r0, #0
c0d006f2:	d123      	bne.n	c0d0073c <io_event+0x23c>
c0d006f4:	68a8      	ldr	r0, [r5, #8]
c0d006f6:	1c46      	adds	r6, r0, #1
c0d006f8:	60ae      	str	r6, [r5, #8]
c0d006fa:	6828      	ldr	r0, [r5, #0]
c0d006fc:	2800      	cmp	r0, #0
c0d006fe:	d1e7      	bne.n	c0d006d0 <io_event+0x1d0>
c0d00700:	e045      	b.n	c0d0078e <io_event+0x28e>
c0d00702:	6828      	ldr	r0, [r5, #0]
c0d00704:	2800      	cmp	r0, #0
c0d00706:	d030      	beq.n	c0d0076a <io_event+0x26a>
c0d00708:	68a8      	ldr	r0, [r5, #8]
c0d0070a:	6869      	ldr	r1, [r5, #4]
c0d0070c:	4288      	cmp	r0, r1
c0d0070e:	d22c      	bcs.n	c0d0076a <io_event+0x26a>
c0d00710:	f001 facc 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00714:	2800      	cmp	r0, #0
c0d00716:	d128      	bne.n	c0d0076a <io_event+0x26a>
c0d00718:	68a8      	ldr	r0, [r5, #8]
c0d0071a:	68e9      	ldr	r1, [r5, #12]
c0d0071c:	2438      	movs	r4, #56	; 0x38
c0d0071e:	4360      	muls	r0, r4
c0d00720:	682a      	ldr	r2, [r5, #0]
c0d00722:	1810      	adds	r0, r2, r0
c0d00724:	2900      	cmp	r1, #0
c0d00726:	d015      	beq.n	c0d00754 <io_event+0x254>
c0d00728:	4788      	blx	r1
c0d0072a:	2800      	cmp	r0, #0
c0d0072c:	d112      	bne.n	c0d00754 <io_event+0x254>
c0d0072e:	68a8      	ldr	r0, [r5, #8]
c0d00730:	1c40      	adds	r0, r0, #1
c0d00732:	60a8      	str	r0, [r5, #8]
c0d00734:	6829      	ldr	r1, [r5, #0]
c0d00736:	2900      	cmp	r1, #0
c0d00738:	d1e7      	bne.n	c0d0070a <io_event+0x20a>
c0d0073a:	e016      	b.n	c0d0076a <io_event+0x26a>
c0d0073c:	2801      	cmp	r0, #1
c0d0073e:	d103      	bne.n	c0d00748 <io_event+0x248>
c0d00740:	68a8      	ldr	r0, [r5, #8]
c0d00742:	4344      	muls	r4, r0
c0d00744:	6828      	ldr	r0, [r5, #0]
c0d00746:	1900      	adds	r0, r0, r4
c0d00748:	f000 fd66 	bl	c0d01218 <io_seproxyhal_display_default>
c0d0074c:	68a8      	ldr	r0, [r5, #8]
c0d0074e:	1c40      	adds	r0, r0, #1
c0d00750:	60a8      	str	r0, [r5, #8]
c0d00752:	e01c      	b.n	c0d0078e <io_event+0x28e>
c0d00754:	2801      	cmp	r0, #1
c0d00756:	d103      	bne.n	c0d00760 <io_event+0x260>
c0d00758:	68a8      	ldr	r0, [r5, #8]
c0d0075a:	4344      	muls	r4, r0
c0d0075c:	6828      	ldr	r0, [r5, #0]
c0d0075e:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00760:	f000 fd5a 	bl	c0d01218 <io_seproxyhal_display_default>
c0d00764:	68a8      	ldr	r0, [r5, #8]
c0d00766:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00768:	60a8      	str	r0, [r5, #8]
c0d0076a:	6868      	ldr	r0, [r5, #4]
c0d0076c:	68a9      	ldr	r1, [r5, #8]
c0d0076e:	4281      	cmp	r1, r0
c0d00770:	d30d      	bcc.n	c0d0078e <io_event+0x28e>
c0d00772:	f001 fa9b 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00776:	e00a      	b.n	c0d0078e <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00778:	2801      	cmp	r0, #1
c0d0077a:	d103      	bne.n	c0d00784 <io_event+0x284>
c0d0077c:	68b0      	ldr	r0, [r6, #8]
c0d0077e:	4344      	muls	r4, r0
c0d00780:	6830      	ldr	r0, [r6, #0]
c0d00782:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00784:	f000 fd48 	bl	c0d01218 <io_seproxyhal_display_default>
c0d00788:	68b0      	ldr	r0, [r6, #8]
c0d0078a:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0078c:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d0078e:	f001 fa8d 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00792:	2800      	cmp	r0, #0
c0d00794:	d101      	bne.n	c0d0079a <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00796:	f000 fac9 	bl	c0d00d2c <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d0079a:	2001      	movs	r0, #1
c0d0079c:	b005      	add	sp, #20
c0d0079e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d007a0:	20001a18 	.word	0x20001a18
c0d007a4:	20001a98 	.word	0x20001a98
c0d007a8:	b0105044 	.word	0xb0105044
c0d007ac:	b0105055 	.word	0xb0105055

c0d007b0 <IOTA_main>:





static void IOTA_main(void) {
c0d007b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007b2:	af03      	add	r7, sp, #12
c0d007b4:	b0dd      	sub	sp, #372	; 0x174
c0d007b6:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d007b8:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d007ba:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d007bc:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d007be:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00a44 <IOTA_main+0x294>)
c0d007c0:	2110      	movs	r1, #16
c0d007c2:	2203      	movs	r2, #3
c0d007c4:	9109      	str	r1, [sp, #36]	; 0x24
c0d007c6:	9208      	str	r2, [sp, #32]
c0d007c8:	f7ff fc6c 	bl	c0d000a4 <write_debug>
c0d007cc:	a80e      	add	r0, sp, #56	; 0x38
c0d007ce:	304d      	adds	r0, #77	; 0x4d
c0d007d0:	9007      	str	r0, [sp, #28]
c0d007d2:	a80b      	add	r0, sp, #44	; 0x2c
c0d007d4:	1dc1      	adds	r1, r0, #7
c0d007d6:	9106      	str	r1, [sp, #24]
c0d007d8:	1d00      	adds	r0, r0, #4
c0d007da:	9005      	str	r0, [sp, #20]
c0d007dc:	4e9d      	ldr	r6, [pc, #628]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d007de:	6830      	ldr	r0, [r6, #0]
c0d007e0:	e08d      	b.n	c0d008fe <IOTA_main+0x14e>
c0d007e2:	489f      	ldr	r0, [pc, #636]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d007e4:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d007e6:	4330      	orrs	r0, r6
c0d007e8:	2880      	cmp	r0, #128	; 0x80
c0d007ea:	d000      	beq.n	c0d007ee <IOTA_main+0x3e>
c0d007ec:	e11e      	b.n	c0d00a2c <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d007ee:	7810      	ldrb	r0, [r2, #0]
c0d007f0:	2800      	cmp	r0, #0
c0d007f2:	4e98      	ldr	r6, [pc, #608]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d007f4:	d004      	beq.n	c0d00800 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d007f6:	489c      	ldr	r0, [pc, #624]	; (c0d00a68 <IOTA_main+0x2b8>)
c0d007f8:	f001 f90c 	bl	c0d01a14 <cx_sha256_init>
                        hashTainted = 0;
c0d007fc:	4899      	ldr	r0, [pc, #612]	; (c0d00a64 <IOTA_main+0x2b4>)
c0d007fe:	7004      	strb	r4, [r0, #0]
c0d00800:	4897      	ldr	r0, [pc, #604]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d00802:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00804:	7908      	ldrb	r0, [r1, #4]
c0d00806:	1808      	adds	r0, r1, r0
c0d00808:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d0080a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0080c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0080e:	4308      	orrs	r0, r1
c0d00810:	905a      	str	r0, [sp, #360]	; 0x168
c0d00812:	e0e5      	b.n	c0d009e0 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00814:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00816:	2818      	cmp	r0, #24
c0d00818:	d800      	bhi.n	c0d0081c <IOTA_main+0x6c>
c0d0081a:	e10c      	b.n	c0d00a36 <IOTA_main+0x286>
c0d0081c:	950a      	str	r5, [sp, #40]	; 0x28
c0d0081e:	4d90      	ldr	r5, [pc, #576]	; (c0d00a60 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00820:	00a0      	lsls	r0, r4, #2
c0d00822:	1829      	adds	r1, r5, r0
c0d00824:	794a      	ldrb	r2, [r1, #5]
c0d00826:	0612      	lsls	r2, r2, #24
c0d00828:	798b      	ldrb	r3, [r1, #6]
c0d0082a:	041b      	lsls	r3, r3, #16
c0d0082c:	4313      	orrs	r3, r2
c0d0082e:	79ca      	ldrb	r2, [r1, #7]
c0d00830:	0212      	lsls	r2, r2, #8
c0d00832:	431a      	orrs	r2, r3
c0d00834:	7a09      	ldrb	r1, [r1, #8]
c0d00836:	4311      	orrs	r1, r2
c0d00838:	aa2b      	add	r2, sp, #172	; 0xac
c0d0083a:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d0083c:	1c64      	adds	r4, r4, #1
c0d0083e:	2c05      	cmp	r4, #5
c0d00840:	d1ee      	bne.n	c0d00820 <IOTA_main+0x70>
c0d00842:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00844:	9103      	str	r1, [sp, #12]
c0d00846:	4668      	mov	r0, sp
c0d00848:	6001      	str	r1, [r0, #0]
c0d0084a:	2421      	movs	r4, #33	; 0x21
c0d0084c:	a92b      	add	r1, sp, #172	; 0xac
c0d0084e:	2205      	movs	r2, #5
c0d00850:	ad23      	add	r5, sp, #140	; 0x8c
c0d00852:	9502      	str	r5, [sp, #8]
c0d00854:	4620      	mov	r0, r4
c0d00856:	462b      	mov	r3, r5
c0d00858:	f001 f992 	bl	c0d01b80 <os_perso_derive_node_bip32>
c0d0085c:	2220      	movs	r2, #32
c0d0085e:	9204      	str	r2, [sp, #16]
c0d00860:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00862:	9301      	str	r3, [sp, #4]
c0d00864:	4620      	mov	r0, r4
c0d00866:	4629      	mov	r1, r5
c0d00868:	f001 f94e 	bl	c0d01b08 <cx_ecfp_init_private_key>
c0d0086c:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d0086e:	4620      	mov	r0, r4
c0d00870:	9903      	ldr	r1, [sp, #12]
c0d00872:	460a      	mov	r2, r1
c0d00874:	462b      	mov	r3, r5
c0d00876:	f001 f929 	bl	c0d01acc <cx_ecfp_init_public_key>
c0d0087a:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d0087c:	4620      	mov	r0, r4
c0d0087e:	4629      	mov	r1, r5
c0d00880:	9a01      	ldr	r2, [sp, #4]
c0d00882:	f001 f95f 	bl	c0d01b44 <cx_ecfp_generate_pair>
c0d00886:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00888:	9802      	ldr	r0, [sp, #8]
c0d0088a:	9904      	ldr	r1, [sp, #16]
c0d0088c:	4622      	mov	r2, r4
c0d0088e:	f7ff fca3 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00892:	2552      	movs	r5, #82	; 0x52
c0d00894:	4872      	ldr	r0, [pc, #456]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d00896:	4621      	mov	r1, r4
c0d00898:	462a      	mov	r2, r5
c0d0089a:	f000 f9ad 	bl	c0d00bf8 <os_memmove>
                    tx = 82;
c0d0089e:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d008a0:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d008a2:	1c41      	adds	r1, r0, #1
c0d008a4:	915b      	str	r1, [sp, #364]	; 0x16c
c0d008a6:	3610      	adds	r6, #16
c0d008a8:	4a6d      	ldr	r2, [pc, #436]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d008aa:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d008ac:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d008ae:	1c41      	adds	r1, r0, #1
c0d008b0:	915b      	str	r1, [sp, #364]	; 0x16c
c0d008b2:	9903      	ldr	r1, [sp, #12]
c0d008b4:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d008b6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d008b8:	b281      	uxth	r1, r0
c0d008ba:	9804      	ldr	r0, [sp, #16]
c0d008bc:	f000 fd2a 	bl	c0d01314 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d008c0:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d008c2:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d008c4:	4308      	orrs	r0, r1
c0d008c6:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d008c8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d008ca:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d008cc:	202e      	movs	r0, #46	; 0x2e
c0d008ce:	9905      	ldr	r1, [sp, #20]
c0d008d0:	7048      	strb	r0, [r1, #1]
c0d008d2:	7008      	strb	r0, [r1, #0]
c0d008d4:	7088      	strb	r0, [r1, #2]
c0d008d6:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d008d8:	78c8      	ldrb	r0, [r1, #3]
c0d008da:	9a06      	ldr	r2, [sp, #24]
c0d008dc:	70d0      	strb	r0, [r2, #3]
c0d008de:	7888      	ldrb	r0, [r1, #2]
c0d008e0:	7090      	strb	r0, [r2, #2]
c0d008e2:	7848      	ldrb	r0, [r1, #1]
c0d008e4:	7050      	strb	r0, [r2, #1]
c0d008e6:	7808      	ldrb	r0, [r1, #0]
c0d008e8:	7010      	strb	r0, [r2, #0]
c0d008ea:	7908      	ldrb	r0, [r1, #4]
c0d008ec:	7110      	strb	r0, [r2, #4]
c0d008ee:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d008f0:	2140      	movs	r1, #64	; 0x40
c0d008f2:	2203      	movs	r2, #3
c0d008f4:	f001 fa8a 	bl	c0d01e0c <ui_display_debug>
c0d008f8:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d008fa:	4e56      	ldr	r6, [pc, #344]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d008fc:	e070      	b.n	c0d009e0 <IOTA_main+0x230>
c0d008fe:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00900:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00902:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00904:	ac4d      	add	r4, sp, #308	; 0x134
c0d00906:	4620      	mov	r0, r4
c0d00908:	f002 fc48 	bl	c0d0319c <setjmp>
c0d0090c:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0090e:	6034      	str	r4, [r6, #0]
c0d00910:	4951      	ldr	r1, [pc, #324]	; (c0d00a58 <IOTA_main+0x2a8>)
c0d00912:	4208      	tst	r0, r1
c0d00914:	d011      	beq.n	c0d0093a <IOTA_main+0x18a>
c0d00916:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00918:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d0091a:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d0091c:	6031      	str	r1, [r6, #0]
c0d0091e:	210f      	movs	r1, #15
c0d00920:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00922:	4001      	ands	r1, r0
c0d00924:	2209      	movs	r2, #9
c0d00926:	0312      	lsls	r2, r2, #12
c0d00928:	4291      	cmp	r1, r2
c0d0092a:	d003      	beq.n	c0d00934 <IOTA_main+0x184>
c0d0092c:	9a08      	ldr	r2, [sp, #32]
c0d0092e:	0352      	lsls	r2, r2, #13
c0d00930:	4291      	cmp	r1, r2
c0d00932:	d142      	bne.n	c0d009ba <IOTA_main+0x20a>
c0d00934:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00936:	8008      	strh	r0, [r1, #0]
c0d00938:	e046      	b.n	c0d009c8 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d0093a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0093c:	905c      	str	r0, [sp, #368]	; 0x170
c0d0093e:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00940:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00942:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00944:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00946:	b2c0      	uxtb	r0, r0
c0d00948:	b289      	uxth	r1, r1
c0d0094a:	f000 fce3 	bl	c0d01314 <io_exchange>
c0d0094e:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00950:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00952:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00954:	2800      	cmp	r0, #0
c0d00956:	d053      	beq.n	c0d00a00 <IOTA_main+0x250>
c0d00958:	4941      	ldr	r1, [pc, #260]	; (c0d00a60 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d0095a:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d0095c:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d0095e:	2880      	cmp	r0, #128	; 0x80
c0d00960:	4a40      	ldr	r2, [pc, #256]	; (c0d00a64 <IOTA_main+0x2b4>)
c0d00962:	d155      	bne.n	c0d00a10 <IOTA_main+0x260>
c0d00964:	7848      	ldrb	r0, [r1, #1]
c0d00966:	216d      	movs	r1, #109	; 0x6d
c0d00968:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d0096a:	2807      	cmp	r0, #7
c0d0096c:	dc3f      	bgt.n	c0d009ee <IOTA_main+0x23e>
c0d0096e:	2802      	cmp	r0, #2
c0d00970:	d100      	bne.n	c0d00974 <IOTA_main+0x1c4>
c0d00972:	e74f      	b.n	c0d00814 <IOTA_main+0x64>
c0d00974:	2804      	cmp	r0, #4
c0d00976:	d153      	bne.n	c0d00a20 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00978:	210b      	movs	r1, #11
c0d0097a:	2203      	movs	r2, #3
c0d0097c:	a03c      	add	r0, pc, #240	; (adr r0, c0d00a70 <IOTA_main+0x2c0>)
c0d0097e:	f7ff fb91 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00982:	2048      	movs	r0, #72	; 0x48
c0d00984:	4936      	ldr	r1, [pc, #216]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d00986:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00988:	2049      	movs	r0, #73	; 0x49
c0d0098a:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d0098c:	2021      	movs	r0, #33	; 0x21
c0d0098e:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00990:	3610      	adds	r6, #16
c0d00992:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00994:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00996:	2005      	movs	r0, #5
c0d00998:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0099a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0099c:	b281      	uxth	r1, r0
c0d0099e:	2020      	movs	r0, #32
c0d009a0:	f000 fcb8 	bl	c0d01314 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d009a4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d009a6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d009a8:	4308      	orrs	r0, r1
c0d009aa:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d009ac:	4620      	mov	r0, r4
c0d009ae:	4621      	mov	r1, r4
c0d009b0:	4622      	mov	r2, r4
c0d009b2:	f001 fa2b 	bl	c0d01e0c <ui_display_debug>
c0d009b6:	4e27      	ldr	r6, [pc, #156]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d009b8:	e012      	b.n	c0d009e0 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d009ba:	4928      	ldr	r1, [pc, #160]	; (c0d00a5c <IOTA_main+0x2ac>)
c0d009bc:	4008      	ands	r0, r1
c0d009be:	210d      	movs	r1, #13
c0d009c0:	02c9      	lsls	r1, r1, #11
c0d009c2:	4301      	orrs	r1, r0
c0d009c4:	a859      	add	r0, sp, #356	; 0x164
c0d009c6:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d009c8:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d009ca:	0a00      	lsrs	r0, r0, #8
c0d009cc:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d009ce:	4a24      	ldr	r2, [pc, #144]	; (c0d00a60 <IOTA_main+0x2b0>)
c0d009d0:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d009d2:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d009d4:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d009d6:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d009d8:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d009da:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009dc:	1c80      	adds	r0, r0, #2
c0d009de:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d009e0:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d009e2:	6030      	str	r0, [r6, #0]
c0d009e4:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d009e6:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d009e8:	2900      	cmp	r1, #0
c0d009ea:	d088      	beq.n	c0d008fe <IOTA_main+0x14e>
c0d009ec:	e006      	b.n	c0d009fc <IOTA_main+0x24c>
c0d009ee:	2808      	cmp	r0, #8
c0d009f0:	d100      	bne.n	c0d009f4 <IOTA_main+0x244>
c0d009f2:	e6f6      	b.n	c0d007e2 <IOTA_main+0x32>
c0d009f4:	28ff      	cmp	r0, #255	; 0xff
c0d009f6:	d113      	bne.n	c0d00a20 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d009f8:	b05d      	add	sp, #372	; 0x174
c0d009fa:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d009fc:	f002 fbda 	bl	c0d031b4 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00a00:	2001      	movs	r0, #1
c0d00a02:	4918      	ldr	r1, [pc, #96]	; (c0d00a64 <IOTA_main+0x2b4>)
c0d00a04:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00a06:	4813      	ldr	r0, [pc, #76]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d00a08:	6800      	ldr	r0, [r0, #0]
c0d00a0a:	491c      	ldr	r1, [pc, #112]	; (c0d00a7c <IOTA_main+0x2cc>)
c0d00a0c:	f002 fbd2 	bl	c0d031b4 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00a10:	2001      	movs	r0, #1
c0d00a12:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00a14:	480f      	ldr	r0, [pc, #60]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d00a16:	6800      	ldr	r0, [r0, #0]
c0d00a18:	2137      	movs	r1, #55	; 0x37
c0d00a1a:	0249      	lsls	r1, r1, #9
c0d00a1c:	f002 fbca 	bl	c0d031b4 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00a20:	2001      	movs	r0, #1
c0d00a22:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00a24:	480b      	ldr	r0, [pc, #44]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d00a26:	6800      	ldr	r0, [r0, #0]
c0d00a28:	f002 fbc4 	bl	c0d031b4 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00a2c:	4809      	ldr	r0, [pc, #36]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d00a2e:	6800      	ldr	r0, [r0, #0]
c0d00a30:	490e      	ldr	r1, [pc, #56]	; (c0d00a6c <IOTA_main+0x2bc>)
c0d00a32:	f002 fbbf 	bl	c0d031b4 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00a36:	2001      	movs	r0, #1
c0d00a38:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00a3a:	4806      	ldr	r0, [pc, #24]	; (c0d00a54 <IOTA_main+0x2a4>)
c0d00a3c:	6800      	ldr	r0, [r0, #0]
c0d00a3e:	3109      	adds	r1, #9
c0d00a40:	f002 fbb8 	bl	c0d031b4 <longjmp>
c0d00a44:	74696157 	.word	0x74696157
c0d00a48:	20676e69 	.word	0x20676e69
c0d00a4c:	20726f66 	.word	0x20726f66
c0d00a50:	0067736d 	.word	0x0067736d
c0d00a54:	20001bb8 	.word	0x20001bb8
c0d00a58:	0000ffff 	.word	0x0000ffff
c0d00a5c:	000007ff 	.word	0x000007ff
c0d00a60:	20001c08 	.word	0x20001c08
c0d00a64:	20001b48 	.word	0x20001b48
c0d00a68:	20001b4c 	.word	0x20001b4c
c0d00a6c:	00006a86 	.word	0x00006a86
c0d00a70:	20646142 	.word	0x20646142
c0d00a74:	6b627550 	.word	0x6b627550
c0d00a78:	00007965 	.word	0x00007965
c0d00a7c:	00006982 	.word	0x00006982

c0d00a80 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00a80:	4801      	ldr	r0, [pc, #4]	; (c0d00a88 <os_boot+0x8>)
c0d00a82:	2100      	movs	r1, #0
c0d00a84:	6001      	str	r1, [r0, #0]
}
c0d00a86:	4770      	bx	lr
c0d00a88:	20001bb8 	.word	0x20001bb8

c0d00a8c <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00a8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a8e:	af03      	add	r7, sp, #12
c0d00a90:	b083      	sub	sp, #12
c0d00a92:	9202      	str	r2, [sp, #8]
c0d00a94:	460c      	mov	r4, r1
c0d00a96:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00a98:	4d4a      	ldr	r5, [pc, #296]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
c0d00a9a:	42ac      	cmp	r4, r5
c0d00a9c:	d00f      	beq.n	c0d00abe <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00a9e:	4e49      	ldr	r6, [pc, #292]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
c0d00aa0:	2540      	movs	r5, #64	; 0x40
c0d00aa2:	4630      	mov	r0, r6
c0d00aa4:	4629      	mov	r1, r5
c0d00aa6:	f002 fae3 	bl	c0d03070 <__aeabi_memclr>
c0d00aaa:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00aac:	2840      	cmp	r0, #64	; 0x40
c0d00aae:	4602      	mov	r2, r0
c0d00ab0:	d300      	bcc.n	c0d00ab4 <io_usb_hid_receive+0x28>
c0d00ab2:	462a      	mov	r2, r5
c0d00ab4:	4630      	mov	r0, r6
c0d00ab6:	4621      	mov	r1, r4
c0d00ab8:	f000 f89e 	bl	c0d00bf8 <os_memmove>
c0d00abc:	4d41      	ldr	r5, [pc, #260]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00abe:	78a8      	ldrb	r0, [r5, #2]
c0d00ac0:	2805      	cmp	r0, #5
c0d00ac2:	d900      	bls.n	c0d00ac6 <io_usb_hid_receive+0x3a>
c0d00ac4:	e076      	b.n	c0d00bb4 <io_usb_hid_receive+0x128>
c0d00ac6:	46c0      	nop			; (mov r8, r8)
c0d00ac8:	4478      	add	r0, pc
c0d00aca:	7900      	ldrb	r0, [r0, #4]
c0d00acc:	0040      	lsls	r0, r0, #1
c0d00ace:	4487      	add	pc, r0
c0d00ad0:	71130c02 	.word	0x71130c02
c0d00ad4:	1f71      	.short	0x1f71
c0d00ad6:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00ad8:	71ae      	strb	r6, [r5, #6]
c0d00ada:	716e      	strb	r6, [r5, #5]
c0d00adc:	712e      	strb	r6, [r5, #4]
c0d00ade:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ae0:	2140      	movs	r1, #64	; 0x40
c0d00ae2:	4628      	mov	r0, r5
c0d00ae4:	9a01      	ldr	r2, [sp, #4]
c0d00ae6:	4790      	blx	r2
c0d00ae8:	e00b      	b.n	c0d00b02 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00aea:	1ce8      	adds	r0, r5, #3
c0d00aec:	2104      	movs	r1, #4
c0d00aee:	f000 ff73 	bl	c0d019d8 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00af2:	2140      	movs	r1, #64	; 0x40
c0d00af4:	4628      	mov	r0, r5
c0d00af6:	e001      	b.n	c0d00afc <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00af8:	4832      	ldr	r0, [pc, #200]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
c0d00afa:	2140      	movs	r1, #64	; 0x40
c0d00afc:	9a01      	ldr	r2, [sp, #4]
c0d00afe:	4790      	blx	r2
c0d00b00:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00b02:	4831      	ldr	r0, [pc, #196]	; (c0d00bc8 <io_usb_hid_receive+0x13c>)
c0d00b04:	2100      	movs	r1, #0
c0d00b06:	6001      	str	r1, [r0, #0]
c0d00b08:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00b0a:	b2c0      	uxtb	r0, r0
c0d00b0c:	b003      	add	sp, #12
c0d00b0e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00b10:	78e8      	ldrb	r0, [r5, #3]
c0d00b12:	4c2d      	ldr	r4, [pc, #180]	; (c0d00bc8 <io_usb_hid_receive+0x13c>)
c0d00b14:	6821      	ldr	r1, [r4, #0]
c0d00b16:	0a09      	lsrs	r1, r1, #8
c0d00b18:	2600      	movs	r6, #0
c0d00b1a:	4288      	cmp	r0, r1
c0d00b1c:	d1f1      	bne.n	c0d00b02 <io_usb_hid_receive+0x76>
c0d00b1e:	7928      	ldrb	r0, [r5, #4]
c0d00b20:	6821      	ldr	r1, [r4, #0]
c0d00b22:	b2c9      	uxtb	r1, r1
c0d00b24:	4288      	cmp	r0, r1
c0d00b26:	d1ec      	bne.n	c0d00b02 <io_usb_hid_receive+0x76>
c0d00b28:	4b28      	ldr	r3, [pc, #160]	; (c0d00bcc <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00b2a:	9802      	ldr	r0, [sp, #8]
c0d00b2c:	18c0      	adds	r0, r0, r3
c0d00b2e:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00b30:	6820      	ldr	r0, [r4, #0]
c0d00b32:	2800      	cmp	r0, #0
c0d00b34:	d00e      	beq.n	c0d00b54 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00b36:	4629      	mov	r1, r5
c0d00b38:	4019      	ands	r1, r3
c0d00b3a:	4825      	ldr	r0, [pc, #148]	; (c0d00bd0 <io_usb_hid_receive+0x144>)
c0d00b3c:	6802      	ldr	r2, [r0, #0]
c0d00b3e:	4291      	cmp	r1, r2
c0d00b40:	461e      	mov	r6, r3
c0d00b42:	d900      	bls.n	c0d00b46 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00b44:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00b46:	462a      	mov	r2, r5
c0d00b48:	4032      	ands	r2, r6
c0d00b4a:	4822      	ldr	r0, [pc, #136]	; (c0d00bd4 <io_usb_hid_receive+0x148>)
c0d00b4c:	6800      	ldr	r0, [r0, #0]
c0d00b4e:	491d      	ldr	r1, [pc, #116]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
c0d00b50:	1d49      	adds	r1, r1, #5
c0d00b52:	e021      	b.n	c0d00b98 <io_usb_hid_receive+0x10c>
c0d00b54:	9301      	str	r3, [sp, #4]
c0d00b56:	491b      	ldr	r1, [pc, #108]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00b58:	7988      	ldrb	r0, [r1, #6]
c0d00b5a:	7949      	ldrb	r1, [r1, #5]
c0d00b5c:	0209      	lsls	r1, r1, #8
c0d00b5e:	4301      	orrs	r1, r0
c0d00b60:	481d      	ldr	r0, [pc, #116]	; (c0d00bd8 <io_usb_hid_receive+0x14c>)
c0d00b62:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00b64:	6801      	ldr	r1, [r0, #0]
c0d00b66:	2241      	movs	r2, #65	; 0x41
c0d00b68:	0092      	lsls	r2, r2, #2
c0d00b6a:	4291      	cmp	r1, r2
c0d00b6c:	d8c9      	bhi.n	c0d00b02 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00b6e:	6801      	ldr	r1, [r0, #0]
c0d00b70:	4817      	ldr	r0, [pc, #92]	; (c0d00bd0 <io_usb_hid_receive+0x144>)
c0d00b72:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00b74:	4917      	ldr	r1, [pc, #92]	; (c0d00bd4 <io_usb_hid_receive+0x148>)
c0d00b76:	4a19      	ldr	r2, [pc, #100]	; (c0d00bdc <io_usb_hid_receive+0x150>)
c0d00b78:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00b7a:	4919      	ldr	r1, [pc, #100]	; (c0d00be0 <io_usb_hid_receive+0x154>)
c0d00b7c:	9a02      	ldr	r2, [sp, #8]
c0d00b7e:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00b80:	4629      	mov	r1, r5
c0d00b82:	9e01      	ldr	r6, [sp, #4]
c0d00b84:	4031      	ands	r1, r6
c0d00b86:	6802      	ldr	r2, [r0, #0]
c0d00b88:	4291      	cmp	r1, r2
c0d00b8a:	d900      	bls.n	c0d00b8e <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00b8c:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00b8e:	462a      	mov	r2, r5
c0d00b90:	4032      	ands	r2, r6
c0d00b92:	480c      	ldr	r0, [pc, #48]	; (c0d00bc4 <io_usb_hid_receive+0x138>)
c0d00b94:	1dc1      	adds	r1, r0, #7
c0d00b96:	4811      	ldr	r0, [pc, #68]	; (c0d00bdc <io_usb_hid_receive+0x150>)
c0d00b98:	f000 f82e 	bl	c0d00bf8 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00b9c:	4035      	ands	r5, r6
c0d00b9e:	480d      	ldr	r0, [pc, #52]	; (c0d00bd4 <io_usb_hid_receive+0x148>)
c0d00ba0:	6801      	ldr	r1, [r0, #0]
c0d00ba2:	1949      	adds	r1, r1, r5
c0d00ba4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00ba6:	480a      	ldr	r0, [pc, #40]	; (c0d00bd0 <io_usb_hid_receive+0x144>)
c0d00ba8:	6801      	ldr	r1, [r0, #0]
c0d00baa:	1b49      	subs	r1, r1, r5
c0d00bac:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00bae:	6820      	ldr	r0, [r4, #0]
c0d00bb0:	1c40      	adds	r0, r0, #1
c0d00bb2:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00bb4:	4806      	ldr	r0, [pc, #24]	; (c0d00bd0 <io_usb_hid_receive+0x144>)
c0d00bb6:	6801      	ldr	r1, [r0, #0]
c0d00bb8:	2001      	movs	r0, #1
c0d00bba:	2602      	movs	r6, #2
c0d00bbc:	2900      	cmp	r1, #0
c0d00bbe:	d1a4      	bne.n	c0d00b0a <io_usb_hid_receive+0x7e>
c0d00bc0:	e79f      	b.n	c0d00b02 <io_usb_hid_receive+0x76>
c0d00bc2:	46c0      	nop			; (mov r8, r8)
c0d00bc4:	20001bbc 	.word	0x20001bbc
c0d00bc8:	20001bfc 	.word	0x20001bfc
c0d00bcc:	0000ffff 	.word	0x0000ffff
c0d00bd0:	20001c04 	.word	0x20001c04
c0d00bd4:	20001d0c 	.word	0x20001d0c
c0d00bd8:	20001c00 	.word	0x20001c00
c0d00bdc:	20001c08 	.word	0x20001c08
c0d00be0:	0001fff9 	.word	0x0001fff9

c0d00be4 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00be4:	b580      	push	{r7, lr}
c0d00be6:	af00      	add	r7, sp, #0
c0d00be8:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00bea:	2a00      	cmp	r2, #0
c0d00bec:	d003      	beq.n	c0d00bf6 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00bee:	4611      	mov	r1, r2
c0d00bf0:	461a      	mov	r2, r3
c0d00bf2:	f002 fa47 	bl	c0d03084 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00bf6:	bd80      	pop	{r7, pc}

c0d00bf8 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00bf8:	b5b0      	push	{r4, r5, r7, lr}
c0d00bfa:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00bfc:	4288      	cmp	r0, r1
c0d00bfe:	d90d      	bls.n	c0d00c1c <os_memmove+0x24>
    while(length--) {
c0d00c00:	2a00      	cmp	r2, #0
c0d00c02:	d014      	beq.n	c0d00c2e <os_memmove+0x36>
c0d00c04:	1e49      	subs	r1, r1, #1
c0d00c06:	4252      	negs	r2, r2
c0d00c08:	1e40      	subs	r0, r0, #1
c0d00c0a:	2300      	movs	r3, #0
c0d00c0c:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00c0e:	461c      	mov	r4, r3
c0d00c10:	4354      	muls	r4, r2
c0d00c12:	5d0d      	ldrb	r5, [r1, r4]
c0d00c14:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00c16:	1c52      	adds	r2, r2, #1
c0d00c18:	d1f9      	bne.n	c0d00c0e <os_memmove+0x16>
c0d00c1a:	e008      	b.n	c0d00c2e <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00c1c:	2a00      	cmp	r2, #0
c0d00c1e:	d006      	beq.n	c0d00c2e <os_memmove+0x36>
c0d00c20:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00c22:	b29c      	uxth	r4, r3
c0d00c24:	5d0d      	ldrb	r5, [r1, r4]
c0d00c26:	5505      	strb	r5, [r0, r4]
      l++;
c0d00c28:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00c2a:	1e52      	subs	r2, r2, #1
c0d00c2c:	d1f9      	bne.n	c0d00c22 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00c2e:	bdb0      	pop	{r4, r5, r7, pc}

c0d00c30 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00c30:	4801      	ldr	r0, [pc, #4]	; (c0d00c38 <io_usb_hid_init+0x8>)
c0d00c32:	2100      	movs	r1, #0
c0d00c34:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00c36:	4770      	bx	lr
c0d00c38:	20001bfc 	.word	0x20001bfc

c0d00c3c <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00c3c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c3e:	af03      	add	r7, sp, #12
c0d00c40:	b087      	sub	sp, #28
c0d00c42:	9301      	str	r3, [sp, #4]
c0d00c44:	9203      	str	r2, [sp, #12]
c0d00c46:	460e      	mov	r6, r1
c0d00c48:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00c4a:	2e00      	cmp	r6, #0
c0d00c4c:	d042      	beq.n	c0d00cd4 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00c4e:	4d31      	ldr	r5, [pc, #196]	; (c0d00d14 <io_usb_hid_exchange+0xd8>)
c0d00c50:	2000      	movs	r0, #0
c0d00c52:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00c54:	4930      	ldr	r1, [pc, #192]	; (c0d00d18 <io_usb_hid_exchange+0xdc>)
c0d00c56:	4831      	ldr	r0, [pc, #196]	; (c0d00d1c <io_usb_hid_exchange+0xe0>)
c0d00c58:	6008      	str	r0, [r1, #0]
c0d00c5a:	4c31      	ldr	r4, [pc, #196]	; (c0d00d20 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00c5c:	1d60      	adds	r0, r4, #5
c0d00c5e:	213b      	movs	r1, #59	; 0x3b
c0d00c60:	9005      	str	r0, [sp, #20]
c0d00c62:	9102      	str	r1, [sp, #8]
c0d00c64:	f002 fa04 	bl	c0d03070 <__aeabi_memclr>
c0d00c68:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00c6a:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00c6c:	6828      	ldr	r0, [r5, #0]
c0d00c6e:	0a00      	lsrs	r0, r0, #8
c0d00c70:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00c72:	6828      	ldr	r0, [r5, #0]
c0d00c74:	7120      	strb	r0, [r4, #4]
c0d00c76:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00c78:	6828      	ldr	r0, [r5, #0]
c0d00c7a:	2800      	cmp	r0, #0
c0d00c7c:	9106      	str	r1, [sp, #24]
c0d00c7e:	d009      	beq.n	c0d00c94 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00c80:	293b      	cmp	r1, #59	; 0x3b
c0d00c82:	460a      	mov	r2, r1
c0d00c84:	d300      	bcc.n	c0d00c88 <io_usb_hid_exchange+0x4c>
c0d00c86:	9a02      	ldr	r2, [sp, #8]
c0d00c88:	4823      	ldr	r0, [pc, #140]	; (c0d00d18 <io_usb_hid_exchange+0xdc>)
c0d00c8a:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00c8c:	6819      	ldr	r1, [r3, #0]
c0d00c8e:	9805      	ldr	r0, [sp, #20]
c0d00c90:	461e      	mov	r6, r3
c0d00c92:	e00a      	b.n	c0d00caa <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00c94:	0a30      	lsrs	r0, r6, #8
c0d00c96:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00c98:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00c9a:	2039      	movs	r0, #57	; 0x39
c0d00c9c:	2939      	cmp	r1, #57	; 0x39
c0d00c9e:	460a      	mov	r2, r1
c0d00ca0:	d300      	bcc.n	c0d00ca4 <io_usb_hid_exchange+0x68>
c0d00ca2:	4602      	mov	r2, r0
c0d00ca4:	4e1c      	ldr	r6, [pc, #112]	; (c0d00d18 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00ca6:	6831      	ldr	r1, [r6, #0]
c0d00ca8:	1de0      	adds	r0, r4, #7
c0d00caa:	9205      	str	r2, [sp, #20]
c0d00cac:	f7ff ffa4 	bl	c0d00bf8 <os_memmove>
c0d00cb0:	4d18      	ldr	r5, [pc, #96]	; (c0d00d14 <io_usb_hid_exchange+0xd8>)
c0d00cb2:	6830      	ldr	r0, [r6, #0]
c0d00cb4:	4631      	mov	r1, r6
c0d00cb6:	9e05      	ldr	r6, [sp, #20]
c0d00cb8:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00cba:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00cbc:	6828      	ldr	r0, [r5, #0]
c0d00cbe:	1c40      	adds	r0, r0, #1
c0d00cc0:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00cc2:	2140      	movs	r1, #64	; 0x40
c0d00cc4:	4620      	mov	r0, r4
c0d00cc6:	9a04      	ldr	r2, [sp, #16]
c0d00cc8:	4790      	blx	r2
c0d00cca:	9806      	ldr	r0, [sp, #24]
c0d00ccc:	1b86      	subs	r6, r0, r6
c0d00cce:	4815      	ldr	r0, [pc, #84]	; (c0d00d24 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00cd0:	4206      	tst	r6, r0
c0d00cd2:	d1c3      	bne.n	c0d00c5c <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00cd4:	480f      	ldr	r0, [pc, #60]	; (c0d00d14 <io_usb_hid_exchange+0xd8>)
c0d00cd6:	2400      	movs	r4, #0
c0d00cd8:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00cda:	2080      	movs	r0, #128	; 0x80
c0d00cdc:	9901      	ldr	r1, [sp, #4]
c0d00cde:	4201      	tst	r1, r0
c0d00ce0:	d001      	beq.n	c0d00ce6 <io_usb_hid_exchange+0xaa>
    reset();
c0d00ce2:	f000 fe3f 	bl	c0d01964 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00ce6:	9801      	ldr	r0, [sp, #4]
c0d00ce8:	0680      	lsls	r0, r0, #26
c0d00cea:	d40f      	bmi.n	c0d00d0c <io_usb_hid_exchange+0xd0>
c0d00cec:	4c0c      	ldr	r4, [pc, #48]	; (c0d00d20 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00cee:	2140      	movs	r1, #64	; 0x40
c0d00cf0:	4620      	mov	r0, r4
c0d00cf2:	9a03      	ldr	r2, [sp, #12]
c0d00cf4:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00cf6:	b2c2      	uxtb	r2, r0
c0d00cf8:	2a40      	cmp	r2, #64	; 0x40
c0d00cfa:	d8f8      	bhi.n	c0d00cee <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00cfc:	9804      	ldr	r0, [sp, #16]
c0d00cfe:	4621      	mov	r1, r4
c0d00d00:	f7ff fec4 	bl	c0d00a8c <io_usb_hid_receive>
c0d00d04:	2802      	cmp	r0, #2
c0d00d06:	d1f2      	bne.n	c0d00cee <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00d08:	4807      	ldr	r0, [pc, #28]	; (c0d00d28 <io_usb_hid_exchange+0xec>)
c0d00d0a:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00d0c:	b2a0      	uxth	r0, r4
c0d00d0e:	b007      	add	sp, #28
c0d00d10:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d12:	46c0      	nop			; (mov r8, r8)
c0d00d14:	20001bfc 	.word	0x20001bfc
c0d00d18:	20001d0c 	.word	0x20001d0c
c0d00d1c:	20001c08 	.word	0x20001c08
c0d00d20:	20001bbc 	.word	0x20001bbc
c0d00d24:	0000ffff 	.word	0x0000ffff
c0d00d28:	20001c00 	.word	0x20001c00

c0d00d2c <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00d2c:	b580      	push	{r7, lr}
c0d00d2e:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00d30:	f000 ffbc 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00d34:	2800      	cmp	r0, #0
c0d00d36:	d10b      	bne.n	c0d00d50 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00d38:	4806      	ldr	r0, [pc, #24]	; (c0d00d54 <io_seproxyhal_general_status+0x28>)
c0d00d3a:	2160      	movs	r1, #96	; 0x60
c0d00d3c:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00d3e:	2100      	movs	r1, #0
c0d00d40:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00d42:	2202      	movs	r2, #2
c0d00d44:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00d46:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00d48:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00d4a:	2105      	movs	r1, #5
c0d00d4c:	f000 ff90 	bl	c0d01c70 <io_seproxyhal_spi_send>
}
c0d00d50:	bd80      	pop	{r7, pc}
c0d00d52:	46c0      	nop			; (mov r8, r8)
c0d00d54:	20001a18 	.word	0x20001a18

c0d00d58 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00d58:	b5d0      	push	{r4, r6, r7, lr}
c0d00d5a:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00d5c:	4815      	ldr	r0, [pc, #84]	; (c0d00db4 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00d5e:	78c0      	ldrb	r0, [r0, #3]
c0d00d60:	1e40      	subs	r0, r0, #1
c0d00d62:	2807      	cmp	r0, #7
c0d00d64:	d824      	bhi.n	c0d00db0 <io_seproxyhal_handle_usb_event+0x58>
c0d00d66:	46c0      	nop			; (mov r8, r8)
c0d00d68:	4478      	add	r0, pc
c0d00d6a:	7900      	ldrb	r0, [r0, #4]
c0d00d6c:	0040      	lsls	r0, r0, #1
c0d00d6e:	4487      	add	pc, r0
c0d00d70:	141f1803 	.word	0x141f1803
c0d00d74:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00d78:	4c0f      	ldr	r4, [pc, #60]	; (c0d00db8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d7a:	2101      	movs	r1, #1
c0d00d7c:	4620      	mov	r0, r4
c0d00d7e:	f001 fbd5 	bl	c0d0252c <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00d82:	4620      	mov	r0, r4
c0d00d84:	f001 fbba 	bl	c0d024fc <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00d88:	480c      	ldr	r0, [pc, #48]	; (c0d00dbc <io_seproxyhal_handle_usb_event+0x64>)
c0d00d8a:	7800      	ldrb	r0, [r0, #0]
c0d00d8c:	2801      	cmp	r0, #1
c0d00d8e:	d10f      	bne.n	c0d00db0 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00d90:	480b      	ldr	r0, [pc, #44]	; (c0d00dc0 <io_seproxyhal_handle_usb_event+0x68>)
c0d00d92:	6800      	ldr	r0, [r0, #0]
c0d00d94:	2110      	movs	r1, #16
c0d00d96:	f002 fa0d 	bl	c0d031b4 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00d9a:	4807      	ldr	r0, [pc, #28]	; (c0d00db8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d9c:	f001 fbc9 	bl	c0d02532 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00da0:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00da2:	4805      	ldr	r0, [pc, #20]	; (c0d00db8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00da4:	f001 fbc9 	bl	c0d0253a <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00da8:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00daa:	4803      	ldr	r0, [pc, #12]	; (c0d00db8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00dac:	f001 fbc3 	bl	c0d02536 <USBD_LL_Resume>
      break;
  }
}
c0d00db0:	bdd0      	pop	{r4, r6, r7, pc}
c0d00db2:	46c0      	nop			; (mov r8, r8)
c0d00db4:	20001a18 	.word	0x20001a18
c0d00db8:	20001d34 	.word	0x20001d34
c0d00dbc:	20001d10 	.word	0x20001d10
c0d00dc0:	20001bb8 	.word	0x20001bb8

c0d00dc4 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00dc4:	217f      	movs	r1, #127	; 0x7f
c0d00dc6:	4001      	ands	r1, r0
c0d00dc8:	4801      	ldr	r0, [pc, #4]	; (c0d00dd0 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00dca:	5c40      	ldrb	r0, [r0, r1]
c0d00dcc:	4770      	bx	lr
c0d00dce:	46c0      	nop			; (mov r8, r8)
c0d00dd0:	20001d11 	.word	0x20001d11

c0d00dd4 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00dd4:	b580      	push	{r7, lr}
c0d00dd6:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00dd8:	480f      	ldr	r0, [pc, #60]	; (c0d00e18 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00dda:	7901      	ldrb	r1, [r0, #4]
c0d00ddc:	2904      	cmp	r1, #4
c0d00dde:	d008      	beq.n	c0d00df2 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00de0:	2902      	cmp	r1, #2
c0d00de2:	d011      	beq.n	c0d00e08 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00de4:	2901      	cmp	r1, #1
c0d00de6:	d10e      	bne.n	c0d00e06 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00de8:	1d81      	adds	r1, r0, #6
c0d00dea:	480d      	ldr	r0, [pc, #52]	; (c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00dec:	f001 faaa 	bl	c0d02344 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00df0:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00df2:	78c2      	ldrb	r2, [r0, #3]
c0d00df4:	217f      	movs	r1, #127	; 0x7f
c0d00df6:	4011      	ands	r1, r2
c0d00df8:	7942      	ldrb	r2, [r0, #5]
c0d00dfa:	4b08      	ldr	r3, [pc, #32]	; (c0d00e1c <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00dfc:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00dfe:	1d82      	adds	r2, r0, #6
c0d00e00:	4807      	ldr	r0, [pc, #28]	; (c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00e02:	f001 fad1 	bl	c0d023a8 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00e06:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00e08:	78c2      	ldrb	r2, [r0, #3]
c0d00e0a:	217f      	movs	r1, #127	; 0x7f
c0d00e0c:	4011      	ands	r1, r2
c0d00e0e:	1d82      	adds	r2, r0, #6
c0d00e10:	4803      	ldr	r0, [pc, #12]	; (c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00e12:	f001 fb0f 	bl	c0d02434 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00e16:	bd80      	pop	{r7, pc}
c0d00e18:	20001a18 	.word	0x20001a18
c0d00e1c:	20001d11 	.word	0x20001d11
c0d00e20:	20001d34 	.word	0x20001d34

c0d00e24 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00e24:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e26:	af03      	add	r7, sp, #12
c0d00e28:	b083      	sub	sp, #12
c0d00e2a:	9201      	str	r2, [sp, #4]
c0d00e2c:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00e2e:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00e30:	2b00      	cmp	r3, #0
c0d00e32:	d100      	bne.n	c0d00e36 <io_usb_send_ep+0x12>
c0d00e34:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00e36:	9801      	ldr	r0, [sp, #4]
c0d00e38:	28ff      	cmp	r0, #255	; 0xff
c0d00e3a:	d843      	bhi.n	c0d00ec4 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00e3c:	4e25      	ldr	r6, [pc, #148]	; (c0d00ed4 <io_usb_send_ep+0xb0>)
c0d00e3e:	2050      	movs	r0, #80	; 0x50
c0d00e40:	7030      	strb	r0, [r6, #0]
c0d00e42:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00e44:	1ce0      	adds	r0, r4, #3
c0d00e46:	9100      	str	r1, [sp, #0]
c0d00e48:	0a01      	lsrs	r1, r0, #8
c0d00e4a:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00e4c:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00e4e:	2080      	movs	r0, #128	; 0x80
c0d00e50:	4302      	orrs	r2, r0
c0d00e52:	9202      	str	r2, [sp, #8]
c0d00e54:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00e56:	2020      	movs	r0, #32
c0d00e58:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00e5a:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00e5c:	2106      	movs	r1, #6
c0d00e5e:	4630      	mov	r0, r6
c0d00e60:	f000 ff06 	bl	c0d01c70 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00e64:	9800      	ldr	r0, [sp, #0]
c0d00e66:	4621      	mov	r1, r4
c0d00e68:	f000 ff02 	bl	c0d01c70 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00e6c:	2d00      	cmp	r5, #0
c0d00e6e:	d10d      	bne.n	c0d00e8c <io_usb_send_ep+0x68>
c0d00e70:	e028      	b.n	c0d00ec4 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00e72:	2d00      	cmp	r5, #0
c0d00e74:	d002      	beq.n	c0d00e7c <io_usb_send_ep+0x58>
c0d00e76:	1e6c      	subs	r4, r5, #1
c0d00e78:	2d01      	cmp	r5, #1
c0d00e7a:	d025      	beq.n	c0d00ec8 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00e7c:	2915      	cmp	r1, #21
c0d00e7e:	d102      	bne.n	c0d00e86 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00e80:	79b0      	ldrb	r0, [r6, #6]
c0d00e82:	0700      	lsls	r0, r0, #28
c0d00e84:	d520      	bpl.n	c0d00ec8 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00e86:	f000 f829 	bl	c0d00edc <io_seproxyhal_handle_event>
c0d00e8a:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00e8c:	f000 ff0e 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d00e90:	2800      	cmp	r0, #0
c0d00e92:	d101      	bne.n	c0d00e98 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00e94:	f7ff ff4a 	bl	c0d00d2c <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00e98:	2180      	movs	r1, #128	; 0x80
c0d00e9a:	2400      	movs	r4, #0
c0d00e9c:	4630      	mov	r0, r6
c0d00e9e:	4622      	mov	r2, r4
c0d00ea0:	f000 ff20 	bl	c0d01ce4 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00ea4:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00ea6:	2806      	cmp	r0, #6
c0d00ea8:	d1e3      	bne.n	c0d00e72 <io_usb_send_ep+0x4e>
c0d00eaa:	2910      	cmp	r1, #16
c0d00eac:	d1e1      	bne.n	c0d00e72 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00eae:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00eb0:	9a02      	ldr	r2, [sp, #8]
c0d00eb2:	4290      	cmp	r0, r2
c0d00eb4:	d1dd      	bne.n	c0d00e72 <io_usb_send_ep+0x4e>
c0d00eb6:	7930      	ldrb	r0, [r6, #4]
c0d00eb8:	2802      	cmp	r0, #2
c0d00eba:	d1da      	bne.n	c0d00e72 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00ebc:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00ebe:	9a01      	ldr	r2, [sp, #4]
c0d00ec0:	4290      	cmp	r0, r2
c0d00ec2:	d1d6      	bne.n	c0d00e72 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00ec4:	b003      	add	sp, #12
c0d00ec6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ec8:	4803      	ldr	r0, [pc, #12]	; (c0d00ed8 <io_usb_send_ep+0xb4>)
c0d00eca:	6800      	ldr	r0, [r0, #0]
c0d00ecc:	2110      	movs	r1, #16
c0d00ece:	f002 f971 	bl	c0d031b4 <longjmp>
c0d00ed2:	46c0      	nop			; (mov r8, r8)
c0d00ed4:	20001a18 	.word	0x20001a18
c0d00ed8:	20001bb8 	.word	0x20001bb8

c0d00edc <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00edc:	b580      	push	{r7, lr}
c0d00ede:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00ee0:	480d      	ldr	r0, [pc, #52]	; (c0d00f18 <io_seproxyhal_handle_event+0x3c>)
c0d00ee2:	7882      	ldrb	r2, [r0, #2]
c0d00ee4:	7841      	ldrb	r1, [r0, #1]
c0d00ee6:	0209      	lsls	r1, r1, #8
c0d00ee8:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00eea:	7800      	ldrb	r0, [r0, #0]
c0d00eec:	2810      	cmp	r0, #16
c0d00eee:	d008      	beq.n	c0d00f02 <io_seproxyhal_handle_event+0x26>
c0d00ef0:	280f      	cmp	r0, #15
c0d00ef2:	d10d      	bne.n	c0d00f10 <io_seproxyhal_handle_event+0x34>
c0d00ef4:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d00ef6:	2904      	cmp	r1, #4
c0d00ef8:	d10d      	bne.n	c0d00f16 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00efa:	f7ff ff2d 	bl	c0d00d58 <io_seproxyhal_handle_usb_event>
c0d00efe:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00f00:	bd80      	pop	{r7, pc}
c0d00f02:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d00f04:	2906      	cmp	r1, #6
c0d00f06:	d306      	bcc.n	c0d00f16 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00f08:	f7ff ff64 	bl	c0d00dd4 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00f0c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00f0e:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d00f10:	2002      	movs	r0, #2
c0d00f12:	f7ff faf5 	bl	c0d00500 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d00f16:	bd80      	pop	{r7, pc}
c0d00f18:	20001a18 	.word	0x20001a18

c0d00f1c <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00f1c:	b580      	push	{r7, lr}
c0d00f1e:	af00      	add	r7, sp, #0
c0d00f20:	460a      	mov	r2, r1
c0d00f22:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00f24:	2082      	movs	r0, #130	; 0x82
c0d00f26:	2314      	movs	r3, #20
c0d00f28:	f7ff ff7c 	bl	c0d00e24 <io_usb_send_ep>
}
c0d00f2c:	bd80      	pop	{r7, pc}
	...

c0d00f30 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d00f30:	b5d0      	push	{r4, r6, r7, lr}
c0d00f32:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00f34:	2007      	movs	r0, #7
c0d00f36:	f000 fcf7 	bl	c0d01928 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d00f3a:	480a      	ldr	r0, [pc, #40]	; (c0d00f64 <io_seproxyhal_init+0x34>)
c0d00f3c:	2400      	movs	r4, #0
c0d00f3e:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d00f40:	4809      	ldr	r0, [pc, #36]	; (c0d00f68 <io_seproxyhal_init+0x38>)
c0d00f42:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d00f44:	4809      	ldr	r0, [pc, #36]	; (c0d00f6c <io_seproxyhal_init+0x3c>)
c0d00f46:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d00f48:	4809      	ldr	r0, [pc, #36]	; (c0d00f70 <io_seproxyhal_init+0x40>)
c0d00f4a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d00f4c:	4809      	ldr	r0, [pc, #36]	; (c0d00f74 <io_seproxyhal_init+0x44>)
c0d00f4e:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00f50:	f7ff fe6e 	bl	c0d00c30 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00f54:	4808      	ldr	r0, [pc, #32]	; (c0d00f78 <io_seproxyhal_init+0x48>)
c0d00f56:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d00f58:	4808      	ldr	r0, [pc, #32]	; (c0d00f7c <io_seproxyhal_init+0x4c>)
c0d00f5a:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d00f5c:	4808      	ldr	r0, [pc, #32]	; (c0d00f80 <io_seproxyhal_init+0x50>)
c0d00f5e:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00f60:	bdd0      	pop	{r4, r6, r7, pc}
c0d00f62:	46c0      	nop			; (mov r8, r8)
c0d00f64:	20001d18 	.word	0x20001d18
c0d00f68:	20001d1a 	.word	0x20001d1a
c0d00f6c:	20001d1c 	.word	0x20001d1c
c0d00f70:	20001d1e 	.word	0x20001d1e
c0d00f74:	20001d10 	.word	0x20001d10
c0d00f78:	20001d20 	.word	0x20001d20
c0d00f7c:	20001d24 	.word	0x20001d24
c0d00f80:	20001d28 	.word	0x20001d28

c0d00f84 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00f84:	4801      	ldr	r0, [pc, #4]	; (c0d00f8c <io_seproxyhal_init_ux+0x8>)
c0d00f86:	2100      	movs	r1, #0
c0d00f88:	6001      	str	r1, [r0, #0]

}
c0d00f8a:	4770      	bx	lr
c0d00f8c:	20001d20 	.word	0x20001d20

c0d00f90 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00f90:	b5b0      	push	{r4, r5, r7, lr}
c0d00f92:	af02      	add	r7, sp, #8
c0d00f94:	460d      	mov	r5, r1
c0d00f96:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d00f98:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d00f9a:	2800      	cmp	r0, #0
c0d00f9c:	d00c      	beq.n	c0d00fb8 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d00f9e:	f000 fcab 	bl	c0d018f8 <pic>
c0d00fa2:	4601      	mov	r1, r0
c0d00fa4:	4620      	mov	r0, r4
c0d00fa6:	4788      	blx	r1
c0d00fa8:	f000 fca6 	bl	c0d018f8 <pic>
c0d00fac:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d00fae:	2800      	cmp	r0, #0
c0d00fb0:	d010      	beq.n	c0d00fd4 <io_seproxyhal_touch_out+0x44>
c0d00fb2:	2801      	cmp	r0, #1
c0d00fb4:	d000      	beq.n	c0d00fb8 <io_seproxyhal_touch_out+0x28>
c0d00fb6:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00fb8:	2d00      	cmp	r5, #0
c0d00fba:	d007      	beq.n	c0d00fcc <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d00fbc:	4620      	mov	r0, r4
c0d00fbe:	47a8      	blx	r5
c0d00fc0:	2100      	movs	r1, #0
    if (!el) {
c0d00fc2:	2800      	cmp	r0, #0
c0d00fc4:	d006      	beq.n	c0d00fd4 <io_seproxyhal_touch_out+0x44>
c0d00fc6:	2801      	cmp	r0, #1
c0d00fc8:	d000      	beq.n	c0d00fcc <io_seproxyhal_touch_out+0x3c>
c0d00fca:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d00fcc:	4620      	mov	r0, r4
c0d00fce:	f7ff fa91 	bl	c0d004f4 <io_seproxyhal_display>
c0d00fd2:	2101      	movs	r1, #1
  return 1;
}
c0d00fd4:	4608      	mov	r0, r1
c0d00fd6:	bdb0      	pop	{r4, r5, r7, pc}

c0d00fd8 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00fd8:	b5b0      	push	{r4, r5, r7, lr}
c0d00fda:	af02      	add	r7, sp, #8
c0d00fdc:	b08e      	sub	sp, #56	; 0x38
c0d00fde:	460c      	mov	r4, r1
c0d00fe0:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d00fe2:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d00fe4:	2800      	cmp	r0, #0
c0d00fe6:	d00c      	beq.n	c0d01002 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d00fe8:	f000 fc86 	bl	c0d018f8 <pic>
c0d00fec:	4601      	mov	r1, r0
c0d00fee:	4628      	mov	r0, r5
c0d00ff0:	4788      	blx	r1
c0d00ff2:	f000 fc81 	bl	c0d018f8 <pic>
c0d00ff6:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00ff8:	2800      	cmp	r0, #0
c0d00ffa:	d016      	beq.n	c0d0102a <io_seproxyhal_touch_over+0x52>
c0d00ffc:	2801      	cmp	r0, #1
c0d00ffe:	d000      	beq.n	c0d01002 <io_seproxyhal_touch_over+0x2a>
c0d01000:	4605      	mov	r5, r0
c0d01002:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01004:	2238      	movs	r2, #56	; 0x38
c0d01006:	4629      	mov	r1, r5
c0d01008:	f7ff fdf6 	bl	c0d00bf8 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d0100c:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0100e:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01010:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01012:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01014:	2c00      	cmp	r4, #0
c0d01016:	d004      	beq.n	c0d01022 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01018:	4628      	mov	r0, r5
c0d0101a:	47a0      	blx	r4
c0d0101c:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0101e:	2800      	cmp	r0, #0
c0d01020:	d003      	beq.n	c0d0102a <io_seproxyhal_touch_over+0x52>
c0d01022:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01024:	f7ff fa66 	bl	c0d004f4 <io_seproxyhal_display>
c0d01028:	2101      	movs	r1, #1
  return 1;
}
c0d0102a:	4608      	mov	r0, r1
c0d0102c:	b00e      	add	sp, #56	; 0x38
c0d0102e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01030 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01030:	b5b0      	push	{r4, r5, r7, lr}
c0d01032:	af02      	add	r7, sp, #8
c0d01034:	460d      	mov	r5, r1
c0d01036:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01038:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0103a:	2800      	cmp	r0, #0
c0d0103c:	d00c      	beq.n	c0d01058 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0103e:	f000 fc5b 	bl	c0d018f8 <pic>
c0d01042:	4601      	mov	r1, r0
c0d01044:	4620      	mov	r0, r4
c0d01046:	4788      	blx	r1
c0d01048:	f000 fc56 	bl	c0d018f8 <pic>
c0d0104c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0104e:	2800      	cmp	r0, #0
c0d01050:	d010      	beq.n	c0d01074 <io_seproxyhal_touch_tap+0x44>
c0d01052:	2801      	cmp	r0, #1
c0d01054:	d000      	beq.n	c0d01058 <io_seproxyhal_touch_tap+0x28>
c0d01056:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01058:	2d00      	cmp	r5, #0
c0d0105a:	d007      	beq.n	c0d0106c <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d0105c:	4620      	mov	r0, r4
c0d0105e:	47a8      	blx	r5
c0d01060:	2100      	movs	r1, #0
    if (!el) {
c0d01062:	2800      	cmp	r0, #0
c0d01064:	d006      	beq.n	c0d01074 <io_seproxyhal_touch_tap+0x44>
c0d01066:	2801      	cmp	r0, #1
c0d01068:	d000      	beq.n	c0d0106c <io_seproxyhal_touch_tap+0x3c>
c0d0106a:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d0106c:	4620      	mov	r0, r4
c0d0106e:	f7ff fa41 	bl	c0d004f4 <io_seproxyhal_display>
c0d01072:	2101      	movs	r1, #1
  return 1;
}
c0d01074:	4608      	mov	r0, r1
c0d01076:	bdb0      	pop	{r4, r5, r7, pc}

c0d01078 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01078:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0107a:	af03      	add	r7, sp, #12
c0d0107c:	b087      	sub	sp, #28
c0d0107e:	9302      	str	r3, [sp, #8]
c0d01080:	9203      	str	r2, [sp, #12]
c0d01082:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01084:	2900      	cmp	r1, #0
c0d01086:	d076      	beq.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
c0d01088:	9004      	str	r0, [sp, #16]
c0d0108a:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0108c:	9001      	str	r0, [sp, #4]
c0d0108e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01090:	9000      	str	r0, [sp, #0]
c0d01092:	2600      	movs	r6, #0
c0d01094:	9606      	str	r6, [sp, #24]
c0d01096:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01098:	f000 fe08 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d0109c:	2800      	cmp	r0, #0
c0d0109e:	d155      	bne.n	c0d0114c <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d010a0:	2038      	movs	r0, #56	; 0x38
c0d010a2:	4370      	muls	r0, r6
c0d010a4:	9d04      	ldr	r5, [sp, #16]
c0d010a6:	182e      	adds	r6, r5, r0
c0d010a8:	4b36      	ldr	r3, [pc, #216]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d010aa:	681a      	ldr	r2, [r3, #0]
c0d010ac:	2101      	movs	r1, #1
c0d010ae:	4296      	cmp	r6, r2
c0d010b0:	d000      	beq.n	c0d010b4 <io_seproxyhal_touch_element_callback+0x3c>
c0d010b2:	9906      	ldr	r1, [sp, #24]
c0d010b4:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d010b6:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d010b8:	2800      	cmp	r0, #0
c0d010ba:	da41      	bge.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
c0d010bc:	2020      	movs	r0, #32
c0d010be:	5c35      	ldrb	r5, [r6, r0]
c0d010c0:	2102      	movs	r1, #2
c0d010c2:	5e71      	ldrsh	r1, [r6, r1]
c0d010c4:	1b4a      	subs	r2, r1, r5
c0d010c6:	9803      	ldr	r0, [sp, #12]
c0d010c8:	4282      	cmp	r2, r0
c0d010ca:	dc39      	bgt.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
c0d010cc:	1869      	adds	r1, r5, r1
c0d010ce:	88f2      	ldrh	r2, [r6, #6]
c0d010d0:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d010d2:	9803      	ldr	r0, [sp, #12]
c0d010d4:	4288      	cmp	r0, r1
c0d010d6:	da33      	bge.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
c0d010d8:	2104      	movs	r1, #4
c0d010da:	5e70      	ldrsh	r0, [r6, r1]
c0d010dc:	1b42      	subs	r2, r0, r5
c0d010de:	9902      	ldr	r1, [sp, #8]
c0d010e0:	428a      	cmp	r2, r1
c0d010e2:	dc2d      	bgt.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
c0d010e4:	1940      	adds	r0, r0, r5
c0d010e6:	8931      	ldrh	r1, [r6, #8]
c0d010e8:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d010ea:	9902      	ldr	r1, [sp, #8]
c0d010ec:	4281      	cmp	r1, r0
c0d010ee:	da27      	bge.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d010f0:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d010f2:	4286      	cmp	r6, r0
c0d010f4:	d010      	beq.n	c0d01118 <io_seproxyhal_touch_element_callback+0xa0>
c0d010f6:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d010f8:	2800      	cmp	r0, #0
c0d010fa:	d00d      	beq.n	c0d01118 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d010fc:	9801      	ldr	r0, [sp, #4]
c0d010fe:	2800      	cmp	r0, #0
c0d01100:	d005      	beq.n	c0d0110e <io_seproxyhal_touch_element_callback+0x96>
c0d01102:	4630      	mov	r0, r6
c0d01104:	9901      	ldr	r1, [sp, #4]
c0d01106:	4788      	blx	r1
c0d01108:	4b1e      	ldr	r3, [pc, #120]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0110a:	2800      	cmp	r0, #0
c0d0110c:	d018      	beq.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0110e:	6818      	ldr	r0, [r3, #0]
c0d01110:	9901      	ldr	r1, [sp, #4]
c0d01112:	f7ff ff3d 	bl	c0d00f90 <io_seproxyhal_touch_out>
c0d01116:	e008      	b.n	c0d0112a <io_seproxyhal_touch_element_callback+0xb2>
c0d01118:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0111a:	2801      	cmp	r0, #1
c0d0111c:	d009      	beq.n	c0d01132 <io_seproxyhal_touch_element_callback+0xba>
c0d0111e:	2802      	cmp	r0, #2
c0d01120:	d10e      	bne.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01122:	4630      	mov	r0, r6
c0d01124:	9901      	ldr	r1, [sp, #4]
c0d01126:	f7ff ff83 	bl	c0d01030 <io_seproxyhal_touch_tap>
c0d0112a:	4b16      	ldr	r3, [pc, #88]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0112c:	2800      	cmp	r0, #0
c0d0112e:	d007      	beq.n	c0d01140 <io_seproxyhal_touch_element_callback+0xc8>
c0d01130:	e023      	b.n	c0d0117a <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01132:	4630      	mov	r0, r6
c0d01134:	9901      	ldr	r1, [sp, #4]
c0d01136:	f7ff ff4f 	bl	c0d00fd8 <io_seproxyhal_touch_over>
c0d0113a:	4b12      	ldr	r3, [pc, #72]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0113c:	2800      	cmp	r0, #0
c0d0113e:	d11f      	bne.n	c0d01180 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01140:	1c64      	adds	r4, r4, #1
c0d01142:	b2e6      	uxtb	r6, r4
c0d01144:	9805      	ldr	r0, [sp, #20]
c0d01146:	4286      	cmp	r6, r0
c0d01148:	d3a6      	bcc.n	c0d01098 <io_seproxyhal_touch_element_callback+0x20>
c0d0114a:	e000      	b.n	c0d0114e <io_seproxyhal_touch_element_callback+0xd6>
c0d0114c:	4b0d      	ldr	r3, [pc, #52]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0114e:	9806      	ldr	r0, [sp, #24]
c0d01150:	0600      	lsls	r0, r0, #24
c0d01152:	d010      	beq.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
c0d01154:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01156:	2800      	cmp	r0, #0
c0d01158:	d00d      	beq.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0115a:	f000 fda7 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d0115e:	4909      	ldr	r1, [pc, #36]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01160:	2800      	cmp	r0, #0
c0d01162:	d108      	bne.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01164:	6808      	ldr	r0, [r1, #0]
c0d01166:	9901      	ldr	r1, [sp, #4]
c0d01168:	f7ff ff12 	bl	c0d00f90 <io_seproxyhal_touch_out>
c0d0116c:	4d05      	ldr	r5, [pc, #20]	; (c0d01184 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0116e:	2800      	cmp	r0, #0
c0d01170:	d001      	beq.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01172:	2000      	movs	r0, #0
c0d01174:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01176:	b007      	add	sp, #28
c0d01178:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0117a:	2000      	movs	r0, #0
c0d0117c:	6018      	str	r0, [r3, #0]
c0d0117e:	e7fa      	b.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01180:	601e      	str	r6, [r3, #0]
c0d01182:	e7f8      	b.n	c0d01176 <io_seproxyhal_touch_element_callback+0xfe>
c0d01184:	20001d20 	.word	0x20001d20

c0d01188 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01188:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0118a:	af03      	add	r7, sp, #12
c0d0118c:	b08b      	sub	sp, #44	; 0x2c
c0d0118e:	460c      	mov	r4, r1
c0d01190:	4601      	mov	r1, r0
c0d01192:	ad04      	add	r5, sp, #16
c0d01194:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01196:	4628      	mov	r0, r5
c0d01198:	9203      	str	r2, [sp, #12]
c0d0119a:	f7ff fd2d 	bl	c0d00bf8 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d0119e:	6821      	ldr	r1, [r4, #0]
c0d011a0:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d011a2:	6862      	ldr	r2, [r4, #4]
c0d011a4:	9502      	str	r5, [sp, #8]
c0d011a6:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d011a8:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d011aa:	4e1a      	ldr	r6, [pc, #104]	; (c0d01214 <io_seproxyhal_display_icon+0x8c>)
c0d011ac:	2365      	movs	r3, #101	; 0x65
c0d011ae:	4635      	mov	r5, r6
c0d011b0:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d011b2:	b292      	uxth	r2, r2
c0d011b4:	4342      	muls	r2, r0
c0d011b6:	b28b      	uxth	r3, r1
c0d011b8:	4353      	muls	r3, r2
c0d011ba:	08d9      	lsrs	r1, r3, #3
c0d011bc:	1c4e      	adds	r6, r1, #1
c0d011be:	2207      	movs	r2, #7
c0d011c0:	4213      	tst	r3, r2
c0d011c2:	d100      	bne.n	c0d011c6 <io_seproxyhal_display_icon+0x3e>
c0d011c4:	460e      	mov	r6, r1
c0d011c6:	4631      	mov	r1, r6
c0d011c8:	9101      	str	r1, [sp, #4]
c0d011ca:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d011cc:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d011ce:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d011d0:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d011d2:	0a01      	lsrs	r1, r0, #8
c0d011d4:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d011d6:	70a8      	strb	r0, [r5, #2]
c0d011d8:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d011da:	4628      	mov	r0, r5
c0d011dc:	f000 fd48 	bl	c0d01c70 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d011e0:	9802      	ldr	r0, [sp, #8]
c0d011e2:	9903      	ldr	r1, [sp, #12]
c0d011e4:	f000 fd44 	bl	c0d01c70 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d011e8:	68a0      	ldr	r0, [r4, #8]
c0d011ea:	7028      	strb	r0, [r5, #0]
c0d011ec:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d011ee:	4628      	mov	r0, r5
c0d011f0:	f000 fd3e 	bl	c0d01c70 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d011f4:	68e0      	ldr	r0, [r4, #12]
c0d011f6:	f000 fb7f 	bl	c0d018f8 <pic>
c0d011fa:	b2b1      	uxth	r1, r6
c0d011fc:	f000 fd38 	bl	c0d01c70 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01200:	9801      	ldr	r0, [sp, #4]
c0d01202:	b285      	uxth	r5, r0
c0d01204:	6920      	ldr	r0, [r4, #16]
c0d01206:	f000 fb77 	bl	c0d018f8 <pic>
c0d0120a:	4629      	mov	r1, r5
c0d0120c:	f000 fd30 	bl	c0d01c70 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01210:	b00b      	add	sp, #44	; 0x2c
c0d01212:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01214:	20001a18 	.word	0x20001a18

c0d01218 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01218:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0121a:	af03      	add	r7, sp, #12
c0d0121c:	b081      	sub	sp, #4
c0d0121e:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01220:	7820      	ldrb	r0, [r4, #0]
c0d01222:	267f      	movs	r6, #127	; 0x7f
c0d01224:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01226:	2e00      	cmp	r6, #0
c0d01228:	d02e      	beq.n	c0d01288 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0122a:	69e0      	ldr	r0, [r4, #28]
c0d0122c:	2800      	cmp	r0, #0
c0d0122e:	d01d      	beq.n	c0d0126c <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01230:	f000 fb62 	bl	c0d018f8 <pic>
c0d01234:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01236:	2e05      	cmp	r6, #5
c0d01238:	d102      	bne.n	c0d01240 <io_seproxyhal_display_default+0x28>
c0d0123a:	7ea0      	ldrb	r0, [r4, #26]
c0d0123c:	2800      	cmp	r0, #0
c0d0123e:	d025      	beq.n	c0d0128c <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01240:	4628      	mov	r0, r5
c0d01242:	f001 ffc5 	bl	c0d031d0 <strlen>
c0d01246:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01248:	4813      	ldr	r0, [pc, #76]	; (c0d01298 <io_seproxyhal_display_default+0x80>)
c0d0124a:	2165      	movs	r1, #101	; 0x65
c0d0124c:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0124e:	4631      	mov	r1, r6
c0d01250:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01252:	0a0a      	lsrs	r2, r1, #8
c0d01254:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01256:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01258:	2103      	movs	r1, #3
c0d0125a:	f000 fd09 	bl	c0d01c70 <io_seproxyhal_spi_send>
c0d0125e:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01260:	4620      	mov	r0, r4
c0d01262:	f000 fd05 	bl	c0d01c70 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01266:	b2b1      	uxth	r1, r6
c0d01268:	4628      	mov	r0, r5
c0d0126a:	e00b      	b.n	c0d01284 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0126c:	480a      	ldr	r0, [pc, #40]	; (c0d01298 <io_seproxyhal_display_default+0x80>)
c0d0126e:	2165      	movs	r1, #101	; 0x65
c0d01270:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01272:	2100      	movs	r1, #0
c0d01274:	7041      	strb	r1, [r0, #1]
c0d01276:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01278:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0127a:	2103      	movs	r1, #3
c0d0127c:	f000 fcf8 	bl	c0d01c70 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01280:	4620      	mov	r0, r4
c0d01282:	4629      	mov	r1, r5
c0d01284:	f000 fcf4 	bl	c0d01c70 <io_seproxyhal_spi_send>
    }
  }
}
c0d01288:	b001      	add	sp, #4
c0d0128a:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d0128c:	4620      	mov	r0, r4
c0d0128e:	4629      	mov	r1, r5
c0d01290:	f7ff ff7a 	bl	c0d01188 <io_seproxyhal_display_icon>
c0d01294:	e7f8      	b.n	c0d01288 <io_seproxyhal_display_default+0x70>
c0d01296:	46c0      	nop			; (mov r8, r8)
c0d01298:	20001a18 	.word	0x20001a18

c0d0129c <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d0129c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0129e:	af03      	add	r7, sp, #12
c0d012a0:	b081      	sub	sp, #4
c0d012a2:	4604      	mov	r4, r0
  if (button_callback) {
c0d012a4:	2c00      	cmp	r4, #0
c0d012a6:	d02e      	beq.n	c0d01306 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d012a8:	4818      	ldr	r0, [pc, #96]	; (c0d0130c <io_seproxyhal_button_push+0x70>)
c0d012aa:	6802      	ldr	r2, [r0, #0]
c0d012ac:	428a      	cmp	r2, r1
c0d012ae:	d103      	bne.n	c0d012b8 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d012b0:	4a17      	ldr	r2, [pc, #92]	; (c0d01310 <io_seproxyhal_button_push+0x74>)
c0d012b2:	6813      	ldr	r3, [r2, #0]
c0d012b4:	1c5b      	adds	r3, r3, #1
c0d012b6:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d012b8:	6806      	ldr	r6, [r0, #0]
c0d012ba:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d012bc:	4a14      	ldr	r2, [pc, #80]	; (c0d01310 <io_seproxyhal_button_push+0x74>)
c0d012be:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d012c0:	2900      	cmp	r1, #0
c0d012c2:	d001      	beq.n	c0d012c8 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d012c4:	6006      	str	r6, [r0, #0]
c0d012c6:	e005      	b.n	c0d012d4 <io_seproxyhal_button_push+0x38>
c0d012c8:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d012ca:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d012cc:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d012ce:	2301      	movs	r3, #1
c0d012d0:	07db      	lsls	r3, r3, #31
c0d012d2:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d012d4:	6800      	ldr	r0, [r0, #0]
c0d012d6:	4288      	cmp	r0, r1
c0d012d8:	d001      	beq.n	c0d012de <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d012da:	2000      	movs	r0, #0
c0d012dc:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d012de:	2d08      	cmp	r5, #8
c0d012e0:	d30e      	bcc.n	c0d01300 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d012e2:	2103      	movs	r1, #3
c0d012e4:	4628      	mov	r0, r5
c0d012e6:	f001 fda7 	bl	c0d02e38 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d012ea:	2001      	movs	r0, #1
c0d012ec:	0780      	lsls	r0, r0, #30
c0d012ee:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d012f0:	2900      	cmp	r1, #0
c0d012f2:	4601      	mov	r1, r0
c0d012f4:	d000      	beq.n	c0d012f8 <io_seproxyhal_button_push+0x5c>
c0d012f6:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d012f8:	2900      	cmp	r1, #0
c0d012fa:	db02      	blt.n	c0d01302 <io_seproxyhal_button_push+0x66>
c0d012fc:	4608      	mov	r0, r1
c0d012fe:	e000      	b.n	c0d01302 <io_seproxyhal_button_push+0x66>
c0d01300:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01302:	4629      	mov	r1, r5
c0d01304:	47a0      	blx	r4
  }
}
c0d01306:	b001      	add	sp, #4
c0d01308:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0130a:	46c0      	nop			; (mov r8, r8)
c0d0130c:	20001d24 	.word	0x20001d24
c0d01310:	20001d28 	.word	0x20001d28

c0d01314 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01314:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01316:	af03      	add	r7, sp, #12
c0d01318:	b081      	sub	sp, #4
c0d0131a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d0131c:	200f      	movs	r0, #15
c0d0131e:	4204      	tst	r4, r0
c0d01320:	d006      	beq.n	c0d01330 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01322:	4620      	mov	r0, r4
c0d01324:	f7ff f8be 	bl	c0d004a4 <io_exchange_al>
c0d01328:	4605      	mov	r5, r0
  }
}
c0d0132a:	b2a8      	uxth	r0, r5
c0d0132c:	b001      	add	sp, #4
c0d0132e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01330:	2610      	movs	r6, #16
c0d01332:	4026      	ands	r6, r4
c0d01334:	2900      	cmp	r1, #0
c0d01336:	d02a      	beq.n	c0d0138e <io_exchange+0x7a>
c0d01338:	2e00      	cmp	r6, #0
c0d0133a:	d128      	bne.n	c0d0138e <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0133c:	483d      	ldr	r0, [pc, #244]	; (c0d01434 <io_exchange+0x120>)
c0d0133e:	7800      	ldrb	r0, [r0, #0]
c0d01340:	2807      	cmp	r0, #7
c0d01342:	d00b      	beq.n	c0d0135c <io_exchange+0x48>
c0d01344:	2800      	cmp	r0, #0
c0d01346:	d004      	beq.n	c0d01352 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01348:	4620      	mov	r0, r4
c0d0134a:	f7ff f8ab 	bl	c0d004a4 <io_exchange_al>
c0d0134e:	2800      	cmp	r0, #0
c0d01350:	d00a      	beq.n	c0d01368 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01352:	4839      	ldr	r0, [pc, #228]	; (c0d01438 <io_exchange+0x124>)
c0d01354:	6800      	ldr	r0, [r0, #0]
c0d01356:	2109      	movs	r1, #9
c0d01358:	f001 ff2c 	bl	c0d031b4 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d0135c:	483d      	ldr	r0, [pc, #244]	; (c0d01454 <io_exchange+0x140>)
c0d0135e:	4478      	add	r0, pc
c0d01360:	2200      	movs	r2, #0
c0d01362:	2320      	movs	r3, #32
c0d01364:	f7ff fc6a 	bl	c0d00c3c <io_usb_hid_exchange>
c0d01368:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0136a:	4832      	ldr	r0, [pc, #200]	; (c0d01434 <io_exchange+0x120>)
c0d0136c:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d0136e:	4833      	ldr	r0, [pc, #204]	; (c0d0143c <io_exchange+0x128>)
c0d01370:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01372:	4833      	ldr	r0, [pc, #204]	; (c0d01440 <io_exchange+0x12c>)
c0d01374:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01376:	4833      	ldr	r0, [pc, #204]	; (c0d01444 <io_exchange+0x130>)
c0d01378:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0137a:	4833      	ldr	r0, [pc, #204]	; (c0d01448 <io_exchange+0x134>)
c0d0137c:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0137e:	06a0      	lsls	r0, r4, #26
c0d01380:	d4d3      	bmi.n	c0d0132a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01382:	f7ff fcd3 	bl	c0d00d2c <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01386:	0620      	lsls	r0, r4, #24
c0d01388:	d501      	bpl.n	c0d0138e <io_exchange+0x7a>
        reset();
c0d0138a:	f000 faeb 	bl	c0d01964 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0138e:	2e00      	cmp	r6, #0
c0d01390:	d10c      	bne.n	c0d013ac <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01392:	0660      	lsls	r0, r4, #25
c0d01394:	d448      	bmi.n	c0d01428 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01396:	4827      	ldr	r0, [pc, #156]	; (c0d01434 <io_exchange+0x120>)
c0d01398:	2100      	movs	r1, #0
c0d0139a:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d0139c:	4827      	ldr	r0, [pc, #156]	; (c0d0143c <io_exchange+0x128>)
c0d0139e:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d013a0:	4827      	ldr	r0, [pc, #156]	; (c0d01440 <io_exchange+0x12c>)
c0d013a2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d013a4:	4827      	ldr	r0, [pc, #156]	; (c0d01444 <io_exchange+0x130>)
c0d013a6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d013a8:	4827      	ldr	r0, [pc, #156]	; (c0d01448 <io_exchange+0x134>)
c0d013aa:	7001      	strb	r1, [r0, #0]
c0d013ac:	4c28      	ldr	r4, [pc, #160]	; (c0d01450 <io_exchange+0x13c>)
c0d013ae:	4e24      	ldr	r6, [pc, #144]	; (c0d01440 <io_exchange+0x12c>)
c0d013b0:	e008      	b.n	c0d013c4 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d013b2:	f7ff fd0f 	bl	c0d00dd4 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d013b6:	8830      	ldrh	r0, [r6, #0]
c0d013b8:	2800      	cmp	r0, #0
c0d013ba:	d003      	beq.n	c0d013c4 <io_exchange+0xb0>
c0d013bc:	e032      	b.n	c0d01424 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d013be:	2002      	movs	r0, #2
c0d013c0:	f7ff f89e 	bl	c0d00500 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d013c4:	f000 fc72 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d013c8:	2800      	cmp	r0, #0
c0d013ca:	d101      	bne.n	c0d013d0 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d013cc:	f7ff fcae 	bl	c0d00d2c <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d013d0:	2180      	movs	r1, #128	; 0x80
c0d013d2:	2500      	movs	r5, #0
c0d013d4:	4620      	mov	r0, r4
c0d013d6:	462a      	mov	r2, r5
c0d013d8:	f000 fc84 	bl	c0d01ce4 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d013dc:	1ec1      	subs	r1, r0, #3
c0d013de:	78a2      	ldrb	r2, [r4, #2]
c0d013e0:	7863      	ldrb	r3, [r4, #1]
c0d013e2:	021b      	lsls	r3, r3, #8
c0d013e4:	4313      	orrs	r3, r2
c0d013e6:	4299      	cmp	r1, r3
c0d013e8:	d110      	bne.n	c0d0140c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d013ea:	4917      	ldr	r1, [pc, #92]	; (c0d01448 <io_exchange+0x134>)
c0d013ec:	7809      	ldrb	r1, [r1, #0]
c0d013ee:	2900      	cmp	r1, #0
c0d013f0:	d002      	beq.n	c0d013f8 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d013f2:	f7ff fd73 	bl	c0d00edc <io_seproxyhal_handle_event>
c0d013f6:	e7e5      	b.n	c0d013c4 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d013f8:	7821      	ldrb	r1, [r4, #0]
c0d013fa:	2910      	cmp	r1, #16
c0d013fc:	d00f      	beq.n	c0d0141e <io_exchange+0x10a>
c0d013fe:	290f      	cmp	r1, #15
c0d01400:	d1dd      	bne.n	c0d013be <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01402:	2804      	cmp	r0, #4
c0d01404:	d102      	bne.n	c0d0140c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01406:	f7ff fca7 	bl	c0d00d58 <io_seproxyhal_handle_usb_event>
c0d0140a:	e7db      	b.n	c0d013c4 <io_exchange+0xb0>
c0d0140c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0140e:	4909      	ldr	r1, [pc, #36]	; (c0d01434 <io_exchange+0x120>)
c0d01410:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01412:	490a      	ldr	r1, [pc, #40]	; (c0d0143c <io_exchange+0x128>)
c0d01414:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01416:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01418:	490a      	ldr	r1, [pc, #40]	; (c0d01444 <io_exchange+0x130>)
c0d0141a:	8008      	strh	r0, [r1, #0]
c0d0141c:	e7d2      	b.n	c0d013c4 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0141e:	2806      	cmp	r0, #6
c0d01420:	d2c7      	bcs.n	c0d013b2 <io_exchange+0x9e>
c0d01422:	e782      	b.n	c0d0132a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01424:	8835      	ldrh	r5, [r6, #0]
c0d01426:	e780      	b.n	c0d0132a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01428:	4805      	ldr	r0, [pc, #20]	; (c0d01440 <io_exchange+0x12c>)
c0d0142a:	8800      	ldrh	r0, [r0, #0]
c0d0142c:	4907      	ldr	r1, [pc, #28]	; (c0d0144c <io_exchange+0x138>)
c0d0142e:	1845      	adds	r5, r0, r1
c0d01430:	e77b      	b.n	c0d0132a <io_exchange+0x16>
c0d01432:	46c0      	nop			; (mov r8, r8)
c0d01434:	20001d18 	.word	0x20001d18
c0d01438:	20001bb8 	.word	0x20001bb8
c0d0143c:	20001d1a 	.word	0x20001d1a
c0d01440:	20001d1c 	.word	0x20001d1c
c0d01444:	20001d1e 	.word	0x20001d1e
c0d01448:	20001d10 	.word	0x20001d10
c0d0144c:	0000fffb 	.word	0x0000fffb
c0d01450:	20001a18 	.word	0x20001a18
c0d01454:	fffffbbb 	.word	0xfffffbbb

c0d01458 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01458:	b081      	sub	sp, #4
c0d0145a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0145c:	af03      	add	r7, sp, #12
c0d0145e:	b094      	sub	sp, #80	; 0x50
c0d01460:	4616      	mov	r6, r2
c0d01462:	460d      	mov	r5, r1
c0d01464:	900e      	str	r0, [sp, #56]	; 0x38
c0d01466:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01468:	2d02      	cmp	r5, #2
c0d0146a:	d200      	bcs.n	c0d0146e <snprintf+0x16>
c0d0146c:	e22a      	b.n	c0d018c4 <snprintf+0x46c>
c0d0146e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01470:	2800      	cmp	r0, #0
c0d01472:	d100      	bne.n	c0d01476 <snprintf+0x1e>
c0d01474:	e226      	b.n	c0d018c4 <snprintf+0x46c>
c0d01476:	2e00      	cmp	r6, #0
c0d01478:	d100      	bne.n	c0d0147c <snprintf+0x24>
c0d0147a:	e223      	b.n	c0d018c4 <snprintf+0x46c>
c0d0147c:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d0147e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01480:	9109      	str	r1, [sp, #36]	; 0x24
c0d01482:	462a      	mov	r2, r5
c0d01484:	f7ff fbae 	bl	c0d00be4 <os_memset>
c0d01488:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d0148a:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0148c:	7830      	ldrb	r0, [r6, #0]
c0d0148e:	2800      	cmp	r0, #0
c0d01490:	d100      	bne.n	c0d01494 <snprintf+0x3c>
c0d01492:	e217      	b.n	c0d018c4 <snprintf+0x46c>
c0d01494:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01496:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01498:	1e6b      	subs	r3, r5, #1
c0d0149a:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d0149c:	460a      	mov	r2, r1
c0d0149e:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d014a0:	e003      	b.n	c0d014aa <snprintf+0x52>
c0d014a2:	1970      	adds	r0, r6, r5
c0d014a4:	7840      	ldrb	r0, [r0, #1]
c0d014a6:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d014a8:	1c6d      	adds	r5, r5, #1
c0d014aa:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d014ac:	2800      	cmp	r0, #0
c0d014ae:	d001      	beq.n	c0d014b4 <snprintf+0x5c>
c0d014b0:	2825      	cmp	r0, #37	; 0x25
c0d014b2:	d1f6      	bne.n	c0d014a2 <snprintf+0x4a>
c0d014b4:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d014b6:	429d      	cmp	r5, r3
c0d014b8:	d300      	bcc.n	c0d014bc <snprintf+0x64>
c0d014ba:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d014bc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d014be:	4631      	mov	r1, r6
c0d014c0:	462a      	mov	r2, r5
c0d014c2:	461c      	mov	r4, r3
c0d014c4:	f7ff fb98 	bl	c0d00bf8 <os_memmove>
c0d014c8:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d014ca:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d014cc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d014ce:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d014d0:	2b00      	cmp	r3, #0
c0d014d2:	d100      	bne.n	c0d014d6 <snprintf+0x7e>
c0d014d4:	e1f6      	b.n	c0d018c4 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d014d6:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d014d8:	5d71      	ldrb	r1, [r6, r5]
c0d014da:	2925      	cmp	r1, #37	; 0x25
c0d014dc:	d000      	beq.n	c0d014e0 <snprintf+0x88>
c0d014de:	e0ab      	b.n	c0d01638 <snprintf+0x1e0>
c0d014e0:	9304      	str	r3, [sp, #16]
c0d014e2:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d014e4:	1c40      	adds	r0, r0, #1
c0d014e6:	2100      	movs	r1, #0
c0d014e8:	2220      	movs	r2, #32
c0d014ea:	920a      	str	r2, [sp, #40]	; 0x28
c0d014ec:	220a      	movs	r2, #10
c0d014ee:	9203      	str	r2, [sp, #12]
c0d014f0:	9102      	str	r1, [sp, #8]
c0d014f2:	9106      	str	r1, [sp, #24]
c0d014f4:	910d      	str	r1, [sp, #52]	; 0x34
c0d014f6:	460b      	mov	r3, r1
c0d014f8:	2102      	movs	r1, #2
c0d014fa:	910c      	str	r1, [sp, #48]	; 0x30
c0d014fc:	4606      	mov	r6, r0
c0d014fe:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01500:	7831      	ldrb	r1, [r6, #0]
c0d01502:	1c76      	adds	r6, r6, #1
c0d01504:	2300      	movs	r3, #0
c0d01506:	2962      	cmp	r1, #98	; 0x62
c0d01508:	dc41      	bgt.n	c0d0158e <snprintf+0x136>
c0d0150a:	4608      	mov	r0, r1
c0d0150c:	3825      	subs	r0, #37	; 0x25
c0d0150e:	2823      	cmp	r0, #35	; 0x23
c0d01510:	d900      	bls.n	c0d01514 <snprintf+0xbc>
c0d01512:	e094      	b.n	c0d0163e <snprintf+0x1e6>
c0d01514:	0040      	lsls	r0, r0, #1
c0d01516:	46c0      	nop			; (mov r8, r8)
c0d01518:	4478      	add	r0, pc
c0d0151a:	8880      	ldrh	r0, [r0, #4]
c0d0151c:	0040      	lsls	r0, r0, #1
c0d0151e:	4487      	add	pc, r0
c0d01520:	0186012d 	.word	0x0186012d
c0d01524:	01860186 	.word	0x01860186
c0d01528:	00510186 	.word	0x00510186
c0d0152c:	01860186 	.word	0x01860186
c0d01530:	00580023 	.word	0x00580023
c0d01534:	00240186 	.word	0x00240186
c0d01538:	00240024 	.word	0x00240024
c0d0153c:	00240024 	.word	0x00240024
c0d01540:	00240024 	.word	0x00240024
c0d01544:	00240024 	.word	0x00240024
c0d01548:	01860024 	.word	0x01860024
c0d0154c:	01860186 	.word	0x01860186
c0d01550:	01860186 	.word	0x01860186
c0d01554:	01860186 	.word	0x01860186
c0d01558:	01860186 	.word	0x01860186
c0d0155c:	01860186 	.word	0x01860186
c0d01560:	01860186 	.word	0x01860186
c0d01564:	006c0186 	.word	0x006c0186
c0d01568:	e7c9      	b.n	c0d014fe <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d0156a:	2930      	cmp	r1, #48	; 0x30
c0d0156c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0156e:	4603      	mov	r3, r0
c0d01570:	d100      	bne.n	c0d01574 <snprintf+0x11c>
c0d01572:	460b      	mov	r3, r1
c0d01574:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01576:	2c00      	cmp	r4, #0
c0d01578:	d000      	beq.n	c0d0157c <snprintf+0x124>
c0d0157a:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d0157c:	200a      	movs	r0, #10
c0d0157e:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01580:	1840      	adds	r0, r0, r1
c0d01582:	3830      	subs	r0, #48	; 0x30
c0d01584:	900d      	str	r0, [sp, #52]	; 0x34
c0d01586:	4630      	mov	r0, r6
c0d01588:	930a      	str	r3, [sp, #40]	; 0x28
c0d0158a:	4613      	mov	r3, r2
c0d0158c:	e7b4      	b.n	c0d014f8 <snprintf+0xa0>
c0d0158e:	296f      	cmp	r1, #111	; 0x6f
c0d01590:	dd11      	ble.n	c0d015b6 <snprintf+0x15e>
c0d01592:	3970      	subs	r1, #112	; 0x70
c0d01594:	2908      	cmp	r1, #8
c0d01596:	d900      	bls.n	c0d0159a <snprintf+0x142>
c0d01598:	e149      	b.n	c0d0182e <snprintf+0x3d6>
c0d0159a:	0049      	lsls	r1, r1, #1
c0d0159c:	4479      	add	r1, pc
c0d0159e:	8889      	ldrh	r1, [r1, #4]
c0d015a0:	0049      	lsls	r1, r1, #1
c0d015a2:	448f      	add	pc, r1
c0d015a4:	01440051 	.word	0x01440051
c0d015a8:	002e0144 	.word	0x002e0144
c0d015ac:	00590144 	.word	0x00590144
c0d015b0:	01440144 	.word	0x01440144
c0d015b4:	0051      	.short	0x0051
c0d015b6:	2963      	cmp	r1, #99	; 0x63
c0d015b8:	d054      	beq.n	c0d01664 <snprintf+0x20c>
c0d015ba:	2964      	cmp	r1, #100	; 0x64
c0d015bc:	d057      	beq.n	c0d0166e <snprintf+0x216>
c0d015be:	2968      	cmp	r1, #104	; 0x68
c0d015c0:	d01d      	beq.n	c0d015fe <snprintf+0x1a6>
c0d015c2:	e134      	b.n	c0d0182e <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d015c4:	7830      	ldrb	r0, [r6, #0]
c0d015c6:	2873      	cmp	r0, #115	; 0x73
c0d015c8:	d000      	beq.n	c0d015cc <snprintf+0x174>
c0d015ca:	e130      	b.n	c0d0182e <snprintf+0x3d6>
c0d015cc:	4630      	mov	r0, r6
c0d015ce:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d015d0:	e00d      	b.n	c0d015ee <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d015d2:	7830      	ldrb	r0, [r6, #0]
c0d015d4:	282a      	cmp	r0, #42	; 0x2a
c0d015d6:	d000      	beq.n	c0d015da <snprintf+0x182>
c0d015d8:	e129      	b.n	c0d0182e <snprintf+0x3d6>
c0d015da:	7871      	ldrb	r1, [r6, #1]
c0d015dc:	1c70      	adds	r0, r6, #1
c0d015de:	2301      	movs	r3, #1
c0d015e0:	2948      	cmp	r1, #72	; 0x48
c0d015e2:	d004      	beq.n	c0d015ee <snprintf+0x196>
c0d015e4:	2968      	cmp	r1, #104	; 0x68
c0d015e6:	d002      	beq.n	c0d015ee <snprintf+0x196>
c0d015e8:	2973      	cmp	r1, #115	; 0x73
c0d015ea:	d000      	beq.n	c0d015ee <snprintf+0x196>
c0d015ec:	e11f      	b.n	c0d0182e <snprintf+0x3d6>
c0d015ee:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d015f0:	1d0a      	adds	r2, r1, #4
c0d015f2:	920f      	str	r2, [sp, #60]	; 0x3c
c0d015f4:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d015f6:	9102      	str	r1, [sp, #8]
c0d015f8:	e77e      	b.n	c0d014f8 <snprintf+0xa0>
c0d015fa:	2001      	movs	r0, #1
c0d015fc:	9006      	str	r0, [sp, #24]
c0d015fe:	2010      	movs	r0, #16
c0d01600:	9003      	str	r0, [sp, #12]
c0d01602:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01604:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01606:	1d01      	adds	r1, r0, #4
c0d01608:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0160a:	2103      	movs	r1, #3
c0d0160c:	400a      	ands	r2, r1
c0d0160e:	1c5b      	adds	r3, r3, #1
c0d01610:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01612:	2a01      	cmp	r2, #1
c0d01614:	d100      	bne.n	c0d01618 <snprintf+0x1c0>
c0d01616:	e0b8      	b.n	c0d0178a <snprintf+0x332>
c0d01618:	2a02      	cmp	r2, #2
c0d0161a:	d100      	bne.n	c0d0161e <snprintf+0x1c6>
c0d0161c:	e104      	b.n	c0d01828 <snprintf+0x3d0>
c0d0161e:	2a03      	cmp	r2, #3
c0d01620:	4630      	mov	r0, r6
c0d01622:	d100      	bne.n	c0d01626 <snprintf+0x1ce>
c0d01624:	e768      	b.n	c0d014f8 <snprintf+0xa0>
c0d01626:	9c08      	ldr	r4, [sp, #32]
c0d01628:	4625      	mov	r5, r4
c0d0162a:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d0162c:	1948      	adds	r0, r1, r5
c0d0162e:	7840      	ldrb	r0, [r0, #1]
c0d01630:	1c6d      	adds	r5, r5, #1
c0d01632:	2800      	cmp	r0, #0
c0d01634:	d1fa      	bne.n	c0d0162c <snprintf+0x1d4>
c0d01636:	e0ab      	b.n	c0d01790 <snprintf+0x338>
c0d01638:	4606      	mov	r6, r0
c0d0163a:	920e      	str	r2, [sp, #56]	; 0x38
c0d0163c:	e109      	b.n	c0d01852 <snprintf+0x3fa>
c0d0163e:	2958      	cmp	r1, #88	; 0x58
c0d01640:	d000      	beq.n	c0d01644 <snprintf+0x1ec>
c0d01642:	e0f4      	b.n	c0d0182e <snprintf+0x3d6>
c0d01644:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01646:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01648:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0164a:	1d01      	adds	r1, r0, #4
c0d0164c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0164e:	6802      	ldr	r2, [r0, #0]
c0d01650:	2000      	movs	r0, #0
c0d01652:	9005      	str	r0, [sp, #20]
c0d01654:	2510      	movs	r5, #16
c0d01656:	e014      	b.n	c0d01682 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01658:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0165a:	1d01      	adds	r1, r0, #4
c0d0165c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0165e:	6802      	ldr	r2, [r0, #0]
c0d01660:	2000      	movs	r0, #0
c0d01662:	e00c      	b.n	c0d0167e <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01664:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01666:	1d01      	adds	r1, r0, #4
c0d01668:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0166a:	6800      	ldr	r0, [r0, #0]
c0d0166c:	e087      	b.n	c0d0177e <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0166e:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01670:	1d01      	adds	r1, r0, #4
c0d01672:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01674:	6800      	ldr	r0, [r0, #0]
c0d01676:	17c1      	asrs	r1, r0, #31
c0d01678:	1842      	adds	r2, r0, r1
c0d0167a:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d0167c:	0fc0      	lsrs	r0, r0, #31
c0d0167e:	9005      	str	r0, [sp, #20]
c0d01680:	250a      	movs	r5, #10
c0d01682:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01684:	4295      	cmp	r5, r2
c0d01686:	920e      	str	r2, [sp, #56]	; 0x38
c0d01688:	d814      	bhi.n	c0d016b4 <snprintf+0x25c>
c0d0168a:	2201      	movs	r2, #1
c0d0168c:	4628      	mov	r0, r5
c0d0168e:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01690:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01692:	4629      	mov	r1, r5
c0d01694:	f001 fb4a 	bl	c0d02d2c <__aeabi_uidiv>
c0d01698:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d0169a:	4288      	cmp	r0, r1
c0d0169c:	d109      	bne.n	c0d016b2 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d0169e:	4628      	mov	r0, r5
c0d016a0:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d016a2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d016a4:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016a6:	910d      	str	r1, [sp, #52]	; 0x34
c0d016a8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d016aa:	4288      	cmp	r0, r1
c0d016ac:	4622      	mov	r2, r4
c0d016ae:	d9ee      	bls.n	c0d0168e <snprintf+0x236>
c0d016b0:	e000      	b.n	c0d016b4 <snprintf+0x25c>
c0d016b2:	460c      	mov	r4, r1
c0d016b4:	950c      	str	r5, [sp, #48]	; 0x30
c0d016b6:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d016b8:	2000      	movs	r0, #0
c0d016ba:	4603      	mov	r3, r0
c0d016bc:	43c1      	mvns	r1, r0
c0d016be:	9c05      	ldr	r4, [sp, #20]
c0d016c0:	2c00      	cmp	r4, #0
c0d016c2:	d100      	bne.n	c0d016c6 <snprintf+0x26e>
c0d016c4:	4621      	mov	r1, r4
c0d016c6:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016c8:	910b      	str	r1, [sp, #44]	; 0x2c
c0d016ca:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d016cc:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d016ce:	b2ca      	uxtb	r2, r1
c0d016d0:	2a30      	cmp	r2, #48	; 0x30
c0d016d2:	d106      	bne.n	c0d016e2 <snprintf+0x28a>
c0d016d4:	2c00      	cmp	r4, #0
c0d016d6:	d004      	beq.n	c0d016e2 <snprintf+0x28a>
c0d016d8:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d016da:	232d      	movs	r3, #45	; 0x2d
c0d016dc:	700b      	strb	r3, [r1, #0]
c0d016de:	2400      	movs	r4, #0
c0d016e0:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d016e2:	1e81      	subs	r1, r0, #2
c0d016e4:	290d      	cmp	r1, #13
c0d016e6:	d80d      	bhi.n	c0d01704 <snprintf+0x2ac>
c0d016e8:	1e41      	subs	r1, r0, #1
c0d016ea:	d00b      	beq.n	c0d01704 <snprintf+0x2ac>
c0d016ec:	a810      	add	r0, sp, #64	; 0x40
c0d016ee:	9405      	str	r4, [sp, #20]
c0d016f0:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d016f2:	4320      	orrs	r0, r4
c0d016f4:	f001 fcc6 	bl	c0d03084 <__aeabi_memset>
c0d016f8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016fa:	1900      	adds	r0, r0, r4
c0d016fc:	9c05      	ldr	r4, [sp, #20]
c0d016fe:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01700:	1840      	adds	r0, r0, r1
c0d01702:	1e43      	subs	r3, r0, #1
c0d01704:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01706:	2c00      	cmp	r4, #0
c0d01708:	9601      	str	r6, [sp, #4]
c0d0170a:	d003      	beq.n	c0d01714 <snprintf+0x2bc>
c0d0170c:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d0170e:	222d      	movs	r2, #45	; 0x2d
c0d01710:	54c2      	strb	r2, [r0, r3]
c0d01712:	1c5b      	adds	r3, r3, #1
c0d01714:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01716:	2900      	cmp	r1, #0
c0d01718:	d003      	beq.n	c0d01722 <snprintf+0x2ca>
c0d0171a:	2800      	cmp	r0, #0
c0d0171c:	d003      	beq.n	c0d01726 <snprintf+0x2ce>
c0d0171e:	a06c      	add	r0, pc, #432	; (adr r0, c0d018d0 <g_pcHex_cap>)
c0d01720:	e002      	b.n	c0d01728 <snprintf+0x2d0>
c0d01722:	461c      	mov	r4, r3
c0d01724:	e016      	b.n	c0d01754 <snprintf+0x2fc>
c0d01726:	a06e      	add	r0, pc, #440	; (adr r0, c0d018e0 <g_pcHex>)
c0d01728:	900d      	str	r0, [sp, #52]	; 0x34
c0d0172a:	461c      	mov	r4, r3
c0d0172c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0172e:	460e      	mov	r6, r1
c0d01730:	f001 fafc 	bl	c0d02d2c <__aeabi_uidiv>
c0d01734:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01736:	4629      	mov	r1, r5
c0d01738:	f001 fb7e 	bl	c0d02e38 <__aeabi_uidivmod>
c0d0173c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0173e:	5c40      	ldrb	r0, [r0, r1]
c0d01740:	a910      	add	r1, sp, #64	; 0x40
c0d01742:	5508      	strb	r0, [r1, r4]
c0d01744:	4630      	mov	r0, r6
c0d01746:	4629      	mov	r1, r5
c0d01748:	f001 faf0 	bl	c0d02d2c <__aeabi_uidiv>
c0d0174c:	1c64      	adds	r4, r4, #1
c0d0174e:	42b5      	cmp	r5, r6
c0d01750:	4601      	mov	r1, r0
c0d01752:	d9eb      	bls.n	c0d0172c <snprintf+0x2d4>
c0d01754:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01756:	429c      	cmp	r4, r3
c0d01758:	4625      	mov	r5, r4
c0d0175a:	d300      	bcc.n	c0d0175e <snprintf+0x306>
c0d0175c:	461d      	mov	r5, r3
c0d0175e:	a910      	add	r1, sp, #64	; 0x40
c0d01760:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01762:	4620      	mov	r0, r4
c0d01764:	462a      	mov	r2, r5
c0d01766:	461e      	mov	r6, r3
c0d01768:	f7ff fa46 	bl	c0d00bf8 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d0176c:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d0176e:	1961      	adds	r1, r4, r5
c0d01770:	910e      	str	r1, [sp, #56]	; 0x38
c0d01772:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01774:	2800      	cmp	r0, #0
c0d01776:	9e01      	ldr	r6, [sp, #4]
c0d01778:	d16b      	bne.n	c0d01852 <snprintf+0x3fa>
c0d0177a:	e0a3      	b.n	c0d018c4 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d0177c:	2025      	movs	r0, #37	; 0x25
c0d0177e:	9907      	ldr	r1, [sp, #28]
c0d01780:	7008      	strb	r0, [r1, #0]
c0d01782:	9804      	ldr	r0, [sp, #16]
c0d01784:	1e40      	subs	r0, r0, #1
c0d01786:	1c49      	adds	r1, r1, #1
c0d01788:	e05f      	b.n	c0d0184a <snprintf+0x3f2>
c0d0178a:	9d02      	ldr	r5, [sp, #8]
c0d0178c:	9c08      	ldr	r4, [sp, #32]
c0d0178e:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01790:	9803      	ldr	r0, [sp, #12]
c0d01792:	2810      	cmp	r0, #16
c0d01794:	9807      	ldr	r0, [sp, #28]
c0d01796:	d161      	bne.n	c0d0185c <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01798:	2d00      	cmp	r5, #0
c0d0179a:	d06a      	beq.n	c0d01872 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d0179c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0179e:	1900      	adds	r0, r0, r4
c0d017a0:	900e      	str	r0, [sp, #56]	; 0x38
c0d017a2:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d017a4:	1aa0      	subs	r0, r4, r2
c0d017a6:	9b05      	ldr	r3, [sp, #20]
c0d017a8:	4283      	cmp	r3, r0
c0d017aa:	d800      	bhi.n	c0d017ae <snprintf+0x356>
c0d017ac:	4603      	mov	r3, r0
c0d017ae:	930c      	str	r3, [sp, #48]	; 0x30
c0d017b0:	435c      	muls	r4, r3
c0d017b2:	940a      	str	r4, [sp, #40]	; 0x28
c0d017b4:	1c60      	adds	r0, r4, #1
c0d017b6:	9007      	str	r0, [sp, #28]
c0d017b8:	2000      	movs	r0, #0
c0d017ba:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d017bc:	9100      	str	r1, [sp, #0]
c0d017be:	940e      	str	r4, [sp, #56]	; 0x38
c0d017c0:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d017c2:	18e3      	adds	r3, r4, r3
c0d017c4:	900d      	str	r0, [sp, #52]	; 0x34
c0d017c6:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d017c8:	200f      	movs	r0, #15
c0d017ca:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d017cc:	0909      	lsrs	r1, r1, #4
c0d017ce:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d017d0:	18a4      	adds	r4, r4, r2
c0d017d2:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d017d4:	2c02      	cmp	r4, #2
c0d017d6:	d375      	bcc.n	c0d018c4 <snprintf+0x46c>
c0d017d8:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d017da:	2c01      	cmp	r4, #1
c0d017dc:	d003      	beq.n	c0d017e6 <snprintf+0x38e>
c0d017de:	2c00      	cmp	r4, #0
c0d017e0:	d108      	bne.n	c0d017f4 <snprintf+0x39c>
c0d017e2:	a43f      	add	r4, pc, #252	; (adr r4, c0d018e0 <g_pcHex>)
c0d017e4:	e000      	b.n	c0d017e8 <snprintf+0x390>
c0d017e6:	a43a      	add	r4, pc, #232	; (adr r4, c0d018d0 <g_pcHex_cap>)
c0d017e8:	b2c9      	uxtb	r1, r1
c0d017ea:	5c61      	ldrb	r1, [r4, r1]
c0d017ec:	7019      	strb	r1, [r3, #0]
c0d017ee:	b2c0      	uxtb	r0, r0
c0d017f0:	5c20      	ldrb	r0, [r4, r0]
c0d017f2:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d017f4:	9807      	ldr	r0, [sp, #28]
c0d017f6:	4290      	cmp	r0, r2
c0d017f8:	d064      	beq.n	c0d018c4 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d017fa:	1e92      	subs	r2, r2, #2
c0d017fc:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d017fe:	1ca4      	adds	r4, r4, #2
c0d01800:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01802:	1c40      	adds	r0, r0, #1
c0d01804:	42a8      	cmp	r0, r5
c0d01806:	9900      	ldr	r1, [sp, #0]
c0d01808:	d3d9      	bcc.n	c0d017be <snprintf+0x366>
c0d0180a:	900d      	str	r0, [sp, #52]	; 0x34
c0d0180c:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d0180e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01810:	1a08      	subs	r0, r1, r0
c0d01812:	9b05      	ldr	r3, [sp, #20]
c0d01814:	4283      	cmp	r3, r0
c0d01816:	d800      	bhi.n	c0d0181a <snprintf+0x3c2>
c0d01818:	4603      	mov	r3, r0
c0d0181a:	4608      	mov	r0, r1
c0d0181c:	4358      	muls	r0, r3
c0d0181e:	1820      	adds	r0, r4, r0
c0d01820:	900e      	str	r0, [sp, #56]	; 0x38
c0d01822:	1898      	adds	r0, r3, r2
c0d01824:	1c43      	adds	r3, r0, #1
c0d01826:	e038      	b.n	c0d0189a <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01828:	7808      	ldrb	r0, [r1, #0]
c0d0182a:	2800      	cmp	r0, #0
c0d0182c:	d023      	beq.n	c0d01876 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d0182e:	2005      	movs	r0, #5
c0d01830:	9d04      	ldr	r5, [sp, #16]
c0d01832:	2d05      	cmp	r5, #5
c0d01834:	462c      	mov	r4, r5
c0d01836:	d300      	bcc.n	c0d0183a <snprintf+0x3e2>
c0d01838:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d0183a:	9807      	ldr	r0, [sp, #28]
c0d0183c:	a12c      	add	r1, pc, #176	; (adr r1, c0d018f0 <g_pcHex+0x10>)
c0d0183e:	4622      	mov	r2, r4
c0d01840:	f7ff f9da 	bl	c0d00bf8 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01844:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01846:	9907      	ldr	r1, [sp, #28]
c0d01848:	1909      	adds	r1, r1, r4
c0d0184a:	910e      	str	r1, [sp, #56]	; 0x38
c0d0184c:	4603      	mov	r3, r0
c0d0184e:	2800      	cmp	r0, #0
c0d01850:	d038      	beq.n	c0d018c4 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01852:	7830      	ldrb	r0, [r6, #0]
c0d01854:	2800      	cmp	r0, #0
c0d01856:	9908      	ldr	r1, [sp, #32]
c0d01858:	d034      	beq.n	c0d018c4 <snprintf+0x46c>
c0d0185a:	e61f      	b.n	c0d0149c <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d0185c:	429d      	cmp	r5, r3
c0d0185e:	d300      	bcc.n	c0d01862 <snprintf+0x40a>
c0d01860:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01862:	462a      	mov	r2, r5
c0d01864:	461c      	mov	r4, r3
c0d01866:	f7ff f9c7 	bl	c0d00bf8 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d0186a:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d0186c:	9907      	ldr	r1, [sp, #28]
c0d0186e:	1949      	adds	r1, r1, r5
c0d01870:	e00f      	b.n	c0d01892 <snprintf+0x43a>
c0d01872:	900e      	str	r0, [sp, #56]	; 0x38
c0d01874:	e7ed      	b.n	c0d01852 <snprintf+0x3fa>
c0d01876:	9b04      	ldr	r3, [sp, #16]
c0d01878:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d0187a:	429c      	cmp	r4, r3
c0d0187c:	d300      	bcc.n	c0d01880 <snprintf+0x428>
c0d0187e:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01880:	2120      	movs	r1, #32
c0d01882:	9807      	ldr	r0, [sp, #28]
c0d01884:	4622      	mov	r2, r4
c0d01886:	f7ff f9ad 	bl	c0d00be4 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d0188a:	9804      	ldr	r0, [sp, #16]
c0d0188c:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d0188e:	9907      	ldr	r1, [sp, #28]
c0d01890:	1909      	adds	r1, r1, r4
c0d01892:	910e      	str	r1, [sp, #56]	; 0x38
c0d01894:	4603      	mov	r3, r0
c0d01896:	2800      	cmp	r0, #0
c0d01898:	d014      	beq.n	c0d018c4 <snprintf+0x46c>
c0d0189a:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d0189c:	42a8      	cmp	r0, r5
c0d0189e:	d9d8      	bls.n	c0d01852 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d018a0:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d018a2:	429a      	cmp	r2, r3
c0d018a4:	d300      	bcc.n	c0d018a8 <snprintf+0x450>
c0d018a6:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d018a8:	2120      	movs	r1, #32
c0d018aa:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d018ac:	4628      	mov	r0, r5
c0d018ae:	920d      	str	r2, [sp, #52]	; 0x34
c0d018b0:	461c      	mov	r4, r3
c0d018b2:	f7ff f997 	bl	c0d00be4 <os_memset>
c0d018b6:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d018b8:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d018ba:	182d      	adds	r5, r5, r0
c0d018bc:	950e      	str	r5, [sp, #56]	; 0x38
c0d018be:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d018c0:	2c00      	cmp	r4, #0
c0d018c2:	d1c6      	bne.n	c0d01852 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d018c4:	2000      	movs	r0, #0
c0d018c6:	b014      	add	sp, #80	; 0x50
c0d018c8:	bcf0      	pop	{r4, r5, r6, r7}
c0d018ca:	bc02      	pop	{r1}
c0d018cc:	b001      	add	sp, #4
c0d018ce:	4708      	bx	r1

c0d018d0 <g_pcHex_cap>:
c0d018d0:	33323130 	.word	0x33323130
c0d018d4:	37363534 	.word	0x37363534
c0d018d8:	42413938 	.word	0x42413938
c0d018dc:	46454443 	.word	0x46454443

c0d018e0 <g_pcHex>:
c0d018e0:	33323130 	.word	0x33323130
c0d018e4:	37363534 	.word	0x37363534
c0d018e8:	62613938 	.word	0x62613938
c0d018ec:	66656463 	.word	0x66656463
c0d018f0:	4f525245 	.word	0x4f525245
c0d018f4:	00000052 	.word	0x00000052

c0d018f8 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d018f8:	b580      	push	{r7, lr}
c0d018fa:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d018fc:	4904      	ldr	r1, [pc, #16]	; (c0d01910 <pic+0x18>)
c0d018fe:	4288      	cmp	r0, r1
c0d01900:	d304      	bcc.n	c0d0190c <pic+0x14>
c0d01902:	4904      	ldr	r1, [pc, #16]	; (c0d01914 <pic+0x1c>)
c0d01904:	4288      	cmp	r0, r1
c0d01906:	d201      	bcs.n	c0d0190c <pic+0x14>
		link_address = pic_internal(link_address);
c0d01908:	f000 f806 	bl	c0d01918 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d0190c:	bd80      	pop	{r7, pc}
c0d0190e:	46c0      	nop			; (mov r8, r8)
c0d01910:	c0d00000 	.word	0xc0d00000
c0d01914:	c0d03700 	.word	0xc0d03700

c0d01918 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01918:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0191a:	4902      	ldr	r1, [pc, #8]	; (c0d01924 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d0191c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d0191e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01920:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01922:	4770      	bx	lr
c0d01924:	c0d01919 	.word	0xc0d01919

c0d01928 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01928:	b580      	push	{r7, lr}
c0d0192a:	af00      	add	r7, sp, #0
c0d0192c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d0192e:	490a      	ldr	r1, [pc, #40]	; (c0d01958 <check_api_level+0x30>)
c0d01930:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01932:	490a      	ldr	r1, [pc, #40]	; (c0d0195c <check_api_level+0x34>)
c0d01934:	680a      	ldr	r2, [r1, #0]
c0d01936:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01938:	9003      	str	r0, [sp, #12]
c0d0193a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0193c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0193e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01940:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01942:	4807      	ldr	r0, [pc, #28]	; (c0d01960 <check_api_level+0x38>)
c0d01944:	9a01      	ldr	r2, [sp, #4]
c0d01946:	4282      	cmp	r2, r0
c0d01948:	d101      	bne.n	c0d0194e <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0194a:	b004      	add	sp, #16
c0d0194c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0194e:	6808      	ldr	r0, [r1, #0]
c0d01950:	2104      	movs	r1, #4
c0d01952:	f001 fc2f 	bl	c0d031b4 <longjmp>
c0d01956:	46c0      	nop			; (mov r8, r8)
c0d01958:	60000137 	.word	0x60000137
c0d0195c:	20001bb8 	.word	0x20001bb8
c0d01960:	900001c6 	.word	0x900001c6

c0d01964 <reset>:
  }
}

void reset ( void ) 
{
c0d01964:	b580      	push	{r7, lr}
c0d01966:	af00      	add	r7, sp, #0
c0d01968:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d0196a:	4809      	ldr	r0, [pc, #36]	; (c0d01990 <reset+0x2c>)
c0d0196c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0196e:	4809      	ldr	r0, [pc, #36]	; (c0d01994 <reset+0x30>)
c0d01970:	6801      	ldr	r1, [r0, #0]
c0d01972:	9101      	str	r1, [sp, #4]
c0d01974:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01976:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01978:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0197a:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d0197c:	4906      	ldr	r1, [pc, #24]	; (c0d01998 <reset+0x34>)
c0d0197e:	9a00      	ldr	r2, [sp, #0]
c0d01980:	428a      	cmp	r2, r1
c0d01982:	d101      	bne.n	c0d01988 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01984:	b002      	add	sp, #8
c0d01986:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01988:	6800      	ldr	r0, [r0, #0]
c0d0198a:	2104      	movs	r1, #4
c0d0198c:	f001 fc12 	bl	c0d031b4 <longjmp>
c0d01990:	60000200 	.word	0x60000200
c0d01994:	20001bb8 	.word	0x20001bb8
c0d01998:	900002f1 	.word	0x900002f1

c0d0199c <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d0199c:	b5d0      	push	{r4, r6, r7, lr}
c0d0199e:	af02      	add	r7, sp, #8
c0d019a0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d019a2:	4b0a      	ldr	r3, [pc, #40]	; (c0d019cc <nvm_write+0x30>)
c0d019a4:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019a6:	4b0a      	ldr	r3, [pc, #40]	; (c0d019d0 <nvm_write+0x34>)
c0d019a8:	681c      	ldr	r4, [r3, #0]
c0d019aa:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d019ac:	ac03      	add	r4, sp, #12
c0d019ae:	c407      	stmia	r4!, {r0, r1, r2}
c0d019b0:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d019b2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d019b4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d019b6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d019b8:	4806      	ldr	r0, [pc, #24]	; (c0d019d4 <nvm_write+0x38>)
c0d019ba:	9901      	ldr	r1, [sp, #4]
c0d019bc:	4281      	cmp	r1, r0
c0d019be:	d101      	bne.n	c0d019c4 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d019c0:	b006      	add	sp, #24
c0d019c2:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d019c4:	6818      	ldr	r0, [r3, #0]
c0d019c6:	2104      	movs	r1, #4
c0d019c8:	f001 fbf4 	bl	c0d031b4 <longjmp>
c0d019cc:	6000037f 	.word	0x6000037f
c0d019d0:	20001bb8 	.word	0x20001bb8
c0d019d4:	900003bc 	.word	0x900003bc

c0d019d8 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d019d8:	b580      	push	{r7, lr}
c0d019da:	af00      	add	r7, sp, #0
c0d019dc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d019de:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a08 <cx_rng+0x30>)
c0d019e0:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019e2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a0c <cx_rng+0x34>)
c0d019e4:	6813      	ldr	r3, [r2, #0]
c0d019e6:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d019e8:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d019ea:	9103      	str	r1, [sp, #12]
c0d019ec:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d019ee:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d019f0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d019f2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d019f4:	4906      	ldr	r1, [pc, #24]	; (c0d01a10 <cx_rng+0x38>)
c0d019f6:	9b00      	ldr	r3, [sp, #0]
c0d019f8:	428b      	cmp	r3, r1
c0d019fa:	d101      	bne.n	c0d01a00 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d019fc:	b004      	add	sp, #16
c0d019fe:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a00:	6810      	ldr	r0, [r2, #0]
c0d01a02:	2104      	movs	r1, #4
c0d01a04:	f001 fbd6 	bl	c0d031b4 <longjmp>
c0d01a08:	6000052c 	.word	0x6000052c
c0d01a0c:	20001bb8 	.word	0x20001bb8
c0d01a10:	90000567 	.word	0x90000567

c0d01a14 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01a14:	b580      	push	{r7, lr}
c0d01a16:	af00      	add	r7, sp, #0
c0d01a18:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01a1a:	490a      	ldr	r1, [pc, #40]	; (c0d01a44 <cx_sha256_init+0x30>)
c0d01a1c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a1e:	490a      	ldr	r1, [pc, #40]	; (c0d01a48 <cx_sha256_init+0x34>)
c0d01a20:	680a      	ldr	r2, [r1, #0]
c0d01a22:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01a24:	9003      	str	r0, [sp, #12]
c0d01a26:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a28:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a2a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a2c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01a2e:	4a07      	ldr	r2, [pc, #28]	; (c0d01a4c <cx_sha256_init+0x38>)
c0d01a30:	9b01      	ldr	r3, [sp, #4]
c0d01a32:	4293      	cmp	r3, r2
c0d01a34:	d101      	bne.n	c0d01a3a <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a36:	b004      	add	sp, #16
c0d01a38:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a3a:	6808      	ldr	r0, [r1, #0]
c0d01a3c:	2104      	movs	r1, #4
c0d01a3e:	f001 fbb9 	bl	c0d031b4 <longjmp>
c0d01a42:	46c0      	nop			; (mov r8, r8)
c0d01a44:	600008db 	.word	0x600008db
c0d01a48:	20001bb8 	.word	0x20001bb8
c0d01a4c:	90000864 	.word	0x90000864

c0d01a50 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01a50:	b580      	push	{r7, lr}
c0d01a52:	af00      	add	r7, sp, #0
c0d01a54:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01a56:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a80 <cx_keccak_init+0x30>)
c0d01a58:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a5a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a84 <cx_keccak_init+0x34>)
c0d01a5c:	6813      	ldr	r3, [r2, #0]
c0d01a5e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01a60:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01a62:	9103      	str	r1, [sp, #12]
c0d01a64:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a66:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a68:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a6a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01a6c:	4906      	ldr	r1, [pc, #24]	; (c0d01a88 <cx_keccak_init+0x38>)
c0d01a6e:	9b00      	ldr	r3, [sp, #0]
c0d01a70:	428b      	cmp	r3, r1
c0d01a72:	d101      	bne.n	c0d01a78 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a74:	b004      	add	sp, #16
c0d01a76:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a78:	6810      	ldr	r0, [r2, #0]
c0d01a7a:	2104      	movs	r1, #4
c0d01a7c:	f001 fb9a 	bl	c0d031b4 <longjmp>
c0d01a80:	60000c3c 	.word	0x60000c3c
c0d01a84:	20001bb8 	.word	0x20001bb8
c0d01a88:	90000c39 	.word	0x90000c39

c0d01a8c <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01a8c:	b5b0      	push	{r4, r5, r7, lr}
c0d01a8e:	af02      	add	r7, sp, #8
c0d01a90:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01a92:	4c0b      	ldr	r4, [pc, #44]	; (c0d01ac0 <cx_hash+0x34>)
c0d01a94:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a96:	4c0b      	ldr	r4, [pc, #44]	; (c0d01ac4 <cx_hash+0x38>)
c0d01a98:	6825      	ldr	r5, [r4, #0]
c0d01a9a:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01a9c:	ad03      	add	r5, sp, #12
c0d01a9e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01aa0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01aa2:	9007      	str	r0, [sp, #28]
c0d01aa4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01aa6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01aa8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01aaa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01aac:	4906      	ldr	r1, [pc, #24]	; (c0d01ac8 <cx_hash+0x3c>)
c0d01aae:	9a01      	ldr	r2, [sp, #4]
c0d01ab0:	428a      	cmp	r2, r1
c0d01ab2:	d101      	bne.n	c0d01ab8 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ab4:	b008      	add	sp, #32
c0d01ab6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ab8:	6820      	ldr	r0, [r4, #0]
c0d01aba:	2104      	movs	r1, #4
c0d01abc:	f001 fb7a 	bl	c0d031b4 <longjmp>
c0d01ac0:	60000ea6 	.word	0x60000ea6
c0d01ac4:	20001bb8 	.word	0x20001bb8
c0d01ac8:	90000e46 	.word	0x90000e46

c0d01acc <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01acc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ace:	af02      	add	r7, sp, #8
c0d01ad0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01ad2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01afc <cx_ecfp_init_public_key+0x30>)
c0d01ad4:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ad6:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b00 <cx_ecfp_init_public_key+0x34>)
c0d01ad8:	6825      	ldr	r5, [r4, #0]
c0d01ada:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01adc:	ad02      	add	r5, sp, #8
c0d01ade:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01ae0:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ae2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ae4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ae6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01ae8:	4906      	ldr	r1, [pc, #24]	; (c0d01b04 <cx_ecfp_init_public_key+0x38>)
c0d01aea:	9a00      	ldr	r2, [sp, #0]
c0d01aec:	428a      	cmp	r2, r1
c0d01aee:	d101      	bne.n	c0d01af4 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01af0:	b006      	add	sp, #24
c0d01af2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01af4:	6820      	ldr	r0, [r4, #0]
c0d01af6:	2104      	movs	r1, #4
c0d01af8:	f001 fb5c 	bl	c0d031b4 <longjmp>
c0d01afc:	60002835 	.word	0x60002835
c0d01b00:	20001bb8 	.word	0x20001bb8
c0d01b04:	900028f0 	.word	0x900028f0

c0d01b08 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01b08:	b5b0      	push	{r4, r5, r7, lr}
c0d01b0a:	af02      	add	r7, sp, #8
c0d01b0c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01b0e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b38 <cx_ecfp_init_private_key+0x30>)
c0d01b10:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b12:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b3c <cx_ecfp_init_private_key+0x34>)
c0d01b14:	6825      	ldr	r5, [r4, #0]
c0d01b16:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01b18:	ad02      	add	r5, sp, #8
c0d01b1a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b1c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b1e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b20:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b22:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01b24:	4906      	ldr	r1, [pc, #24]	; (c0d01b40 <cx_ecfp_init_private_key+0x38>)
c0d01b26:	9a00      	ldr	r2, [sp, #0]
c0d01b28:	428a      	cmp	r2, r1
c0d01b2a:	d101      	bne.n	c0d01b30 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b2c:	b006      	add	sp, #24
c0d01b2e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b30:	6820      	ldr	r0, [r4, #0]
c0d01b32:	2104      	movs	r1, #4
c0d01b34:	f001 fb3e 	bl	c0d031b4 <longjmp>
c0d01b38:	600029ed 	.word	0x600029ed
c0d01b3c:	20001bb8 	.word	0x20001bb8
c0d01b40:	900029ae 	.word	0x900029ae

c0d01b44 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01b44:	b5b0      	push	{r4, r5, r7, lr}
c0d01b46:	af02      	add	r7, sp, #8
c0d01b48:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01b4a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b74 <cx_ecfp_generate_pair+0x30>)
c0d01b4c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b4e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b78 <cx_ecfp_generate_pair+0x34>)
c0d01b50:	6825      	ldr	r5, [r4, #0]
c0d01b52:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01b54:	ad02      	add	r5, sp, #8
c0d01b56:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b58:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b5a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b5c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b5e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01b60:	4906      	ldr	r1, [pc, #24]	; (c0d01b7c <cx_ecfp_generate_pair+0x38>)
c0d01b62:	9a00      	ldr	r2, [sp, #0]
c0d01b64:	428a      	cmp	r2, r1
c0d01b66:	d101      	bne.n	c0d01b6c <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b68:	b006      	add	sp, #24
c0d01b6a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b6c:	6820      	ldr	r0, [r4, #0]
c0d01b6e:	2104      	movs	r1, #4
c0d01b70:	f001 fb20 	bl	c0d031b4 <longjmp>
c0d01b74:	60002a2e 	.word	0x60002a2e
c0d01b78:	20001bb8 	.word	0x20001bb8
c0d01b7c:	90002a74 	.word	0x90002a74

c0d01b80 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01b80:	b5b0      	push	{r4, r5, r7, lr}
c0d01b82:	af02      	add	r7, sp, #8
c0d01b84:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01b86:	4c0b      	ldr	r4, [pc, #44]	; (c0d01bb4 <os_perso_derive_node_bip32+0x34>)
c0d01b88:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b8a:	4c0b      	ldr	r4, [pc, #44]	; (c0d01bb8 <os_perso_derive_node_bip32+0x38>)
c0d01b8c:	6825      	ldr	r5, [r4, #0]
c0d01b8e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01b90:	ad03      	add	r5, sp, #12
c0d01b92:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b94:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01b96:	9007      	str	r0, [sp, #28]
c0d01b98:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b9a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b9c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b9e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01ba0:	4806      	ldr	r0, [pc, #24]	; (c0d01bbc <os_perso_derive_node_bip32+0x3c>)
c0d01ba2:	9901      	ldr	r1, [sp, #4]
c0d01ba4:	4281      	cmp	r1, r0
c0d01ba6:	d101      	bne.n	c0d01bac <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ba8:	b008      	add	sp, #32
c0d01baa:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bac:	6820      	ldr	r0, [r4, #0]
c0d01bae:	2104      	movs	r1, #4
c0d01bb0:	f001 fb00 	bl	c0d031b4 <longjmp>
c0d01bb4:	6000512b 	.word	0x6000512b
c0d01bb8:	20001bb8 	.word	0x20001bb8
c0d01bbc:	9000517f 	.word	0x9000517f

c0d01bc0 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01bc0:	b580      	push	{r7, lr}
c0d01bc2:	af00      	add	r7, sp, #0
c0d01bc4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01bc6:	490a      	ldr	r1, [pc, #40]	; (c0d01bf0 <os_sched_exit+0x30>)
c0d01bc8:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bca:	490a      	ldr	r1, [pc, #40]	; (c0d01bf4 <os_sched_exit+0x34>)
c0d01bcc:	680a      	ldr	r2, [r1, #0]
c0d01bce:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01bd0:	9003      	str	r0, [sp, #12]
c0d01bd2:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bd4:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bd6:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bd8:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01bda:	4807      	ldr	r0, [pc, #28]	; (c0d01bf8 <os_sched_exit+0x38>)
c0d01bdc:	9a01      	ldr	r2, [sp, #4]
c0d01bde:	4282      	cmp	r2, r0
c0d01be0:	d101      	bne.n	c0d01be6 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01be2:	b004      	add	sp, #16
c0d01be4:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01be6:	6808      	ldr	r0, [r1, #0]
c0d01be8:	2104      	movs	r1, #4
c0d01bea:	f001 fae3 	bl	c0d031b4 <longjmp>
c0d01bee:	46c0      	nop			; (mov r8, r8)
c0d01bf0:	60005fe1 	.word	0x60005fe1
c0d01bf4:	20001bb8 	.word	0x20001bb8
c0d01bf8:	90005f6f 	.word	0x90005f6f

c0d01bfc <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01bfc:	b580      	push	{r7, lr}
c0d01bfe:	af00      	add	r7, sp, #0
c0d01c00:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01c02:	490a      	ldr	r1, [pc, #40]	; (c0d01c2c <os_ux+0x30>)
c0d01c04:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c06:	490a      	ldr	r1, [pc, #40]	; (c0d01c30 <os_ux+0x34>)
c0d01c08:	680a      	ldr	r2, [r1, #0]
c0d01c0a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01c0c:	9003      	str	r0, [sp, #12]
c0d01c0e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c10:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c12:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c14:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01c16:	4a07      	ldr	r2, [pc, #28]	; (c0d01c34 <os_ux+0x38>)
c0d01c18:	9b01      	ldr	r3, [sp, #4]
c0d01c1a:	4293      	cmp	r3, r2
c0d01c1c:	d101      	bne.n	c0d01c22 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01c1e:	b004      	add	sp, #16
c0d01c20:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c22:	6808      	ldr	r0, [r1, #0]
c0d01c24:	2104      	movs	r1, #4
c0d01c26:	f001 fac5 	bl	c0d031b4 <longjmp>
c0d01c2a:	46c0      	nop			; (mov r8, r8)
c0d01c2c:	60006158 	.word	0x60006158
c0d01c30:	20001bb8 	.word	0x20001bb8
c0d01c34:	9000611f 	.word	0x9000611f

c0d01c38 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01c38:	b580      	push	{r7, lr}
c0d01c3a:	af00      	add	r7, sp, #0
c0d01c3c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01c3e:	4809      	ldr	r0, [pc, #36]	; (c0d01c64 <os_seph_features+0x2c>)
c0d01c40:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c42:	4909      	ldr	r1, [pc, #36]	; (c0d01c68 <os_seph_features+0x30>)
c0d01c44:	6808      	ldr	r0, [r1, #0]
c0d01c46:	9001      	str	r0, [sp, #4]
c0d01c48:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c4a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c4c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c4e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01c50:	4a06      	ldr	r2, [pc, #24]	; (c0d01c6c <os_seph_features+0x34>)
c0d01c52:	9b00      	ldr	r3, [sp, #0]
c0d01c54:	4293      	cmp	r3, r2
c0d01c56:	d101      	bne.n	c0d01c5c <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01c58:	b002      	add	sp, #8
c0d01c5a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c5c:	6808      	ldr	r0, [r1, #0]
c0d01c5e:	2104      	movs	r1, #4
c0d01c60:	f001 faa8 	bl	c0d031b4 <longjmp>
c0d01c64:	600064d6 	.word	0x600064d6
c0d01c68:	20001bb8 	.word	0x20001bb8
c0d01c6c:	90006444 	.word	0x90006444

c0d01c70 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01c70:	b580      	push	{r7, lr}
c0d01c72:	af00      	add	r7, sp, #0
c0d01c74:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01c76:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ca0 <io_seproxyhal_spi_send+0x30>)
c0d01c78:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c7a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ca4 <io_seproxyhal_spi_send+0x34>)
c0d01c7c:	6813      	ldr	r3, [r2, #0]
c0d01c7e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01c80:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01c82:	9103      	str	r1, [sp, #12]
c0d01c84:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c86:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c88:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c8a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01c8c:	4806      	ldr	r0, [pc, #24]	; (c0d01ca8 <io_seproxyhal_spi_send+0x38>)
c0d01c8e:	9900      	ldr	r1, [sp, #0]
c0d01c90:	4281      	cmp	r1, r0
c0d01c92:	d101      	bne.n	c0d01c98 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c94:	b004      	add	sp, #16
c0d01c96:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c98:	6810      	ldr	r0, [r2, #0]
c0d01c9a:	2104      	movs	r1, #4
c0d01c9c:	f001 fa8a 	bl	c0d031b4 <longjmp>
c0d01ca0:	60006a1c 	.word	0x60006a1c
c0d01ca4:	20001bb8 	.word	0x20001bb8
c0d01ca8:	90006af3 	.word	0x90006af3

c0d01cac <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01cac:	b580      	push	{r7, lr}
c0d01cae:	af00      	add	r7, sp, #0
c0d01cb0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01cb2:	4809      	ldr	r0, [pc, #36]	; (c0d01cd8 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01cb4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cb6:	4909      	ldr	r1, [pc, #36]	; (c0d01cdc <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01cb8:	6808      	ldr	r0, [r1, #0]
c0d01cba:	9001      	str	r0, [sp, #4]
c0d01cbc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cbe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cc0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cc2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01cc4:	4a06      	ldr	r2, [pc, #24]	; (c0d01ce0 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01cc6:	9b00      	ldr	r3, [sp, #0]
c0d01cc8:	4293      	cmp	r3, r2
c0d01cca:	d101      	bne.n	c0d01cd0 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01ccc:	b002      	add	sp, #8
c0d01cce:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cd0:	6808      	ldr	r0, [r1, #0]
c0d01cd2:	2104      	movs	r1, #4
c0d01cd4:	f001 fa6e 	bl	c0d031b4 <longjmp>
c0d01cd8:	60006bcf 	.word	0x60006bcf
c0d01cdc:	20001bb8 	.word	0x20001bb8
c0d01ce0:	90006b7f 	.word	0x90006b7f

c0d01ce4 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01ce4:	b5d0      	push	{r4, r6, r7, lr}
c0d01ce6:	af02      	add	r7, sp, #8
c0d01ce8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01cea:	4b0b      	ldr	r3, [pc, #44]	; (c0d01d18 <io_seproxyhal_spi_recv+0x34>)
c0d01cec:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cee:	4b0b      	ldr	r3, [pc, #44]	; (c0d01d1c <io_seproxyhal_spi_recv+0x38>)
c0d01cf0:	681c      	ldr	r4, [r3, #0]
c0d01cf2:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01cf4:	ac03      	add	r4, sp, #12
c0d01cf6:	c407      	stmia	r4!, {r0, r1, r2}
c0d01cf8:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cfa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cfc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cfe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01d00:	4907      	ldr	r1, [pc, #28]	; (c0d01d20 <io_seproxyhal_spi_recv+0x3c>)
c0d01d02:	9a01      	ldr	r2, [sp, #4]
c0d01d04:	428a      	cmp	r2, r1
c0d01d06:	d102      	bne.n	c0d01d0e <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01d08:	b280      	uxth	r0, r0
c0d01d0a:	b006      	add	sp, #24
c0d01d0c:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d0e:	6818      	ldr	r0, [r3, #0]
c0d01d10:	2104      	movs	r1, #4
c0d01d12:	f001 fa4f 	bl	c0d031b4 <longjmp>
c0d01d16:	46c0      	nop			; (mov r8, r8)
c0d01d18:	60006cd1 	.word	0x60006cd1
c0d01d1c:	20001bb8 	.word	0x20001bb8
c0d01d20:	90006c2b 	.word	0x90006c2b

c0d01d24 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01d24:	b5b0      	push	{r4, r5, r7, lr}
c0d01d26:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01d28:	492c      	ldr	r1, [pc, #176]	; (c0d01ddc <bagl_ui_nanos_screen1_button+0xb8>)
c0d01d2a:	4288      	cmp	r0, r1
c0d01d2c:	d006      	beq.n	c0d01d3c <bagl_ui_nanos_screen1_button+0x18>
c0d01d2e:	492c      	ldr	r1, [pc, #176]	; (c0d01de0 <bagl_ui_nanos_screen1_button+0xbc>)
c0d01d30:	4288      	cmp	r0, r1
c0d01d32:	d151      	bne.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01d34:	2000      	movs	r0, #0
c0d01d36:	f7ff ff43 	bl	c0d01bc0 <os_sched_exit>
c0d01d3a:	e04d      	b.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01d3c:	f7fe fba4 	bl	c0d00488 <nvram_is_init>
c0d01d40:	2801      	cmp	r0, #1
c0d01d42:	d102      	bne.n	c0d01d4a <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01d44:	a029      	add	r0, pc, #164	; (adr r0, c0d01dec <bagl_ui_nanos_screen1_button+0xc8>)
c0d01d46:	210d      	movs	r1, #13
c0d01d48:	e001      	b.n	c0d01d4e <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01d4a:	a026      	add	r0, pc, #152	; (adr r0, c0d01de4 <bagl_ui_nanos_screen1_button+0xc0>)
c0d01d4c:	2105      	movs	r1, #5
c0d01d4e:	2203      	movs	r2, #3
c0d01d50:	f7fe f9a8 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01d54:	4c29      	ldr	r4, [pc, #164]	; (c0d01dfc <bagl_ui_nanos_screen1_button+0xd8>)
c0d01d56:	482b      	ldr	r0, [pc, #172]	; (c0d01e04 <bagl_ui_nanos_screen1_button+0xe0>)
c0d01d58:	4478      	add	r0, pc
c0d01d5a:	6020      	str	r0, [r4, #0]
c0d01d5c:	2004      	movs	r0, #4
c0d01d5e:	6060      	str	r0, [r4, #4]
c0d01d60:	4829      	ldr	r0, [pc, #164]	; (c0d01e08 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01d62:	4478      	add	r0, pc
c0d01d64:	6120      	str	r0, [r4, #16]
c0d01d66:	2500      	movs	r5, #0
c0d01d68:	60e5      	str	r5, [r4, #12]
c0d01d6a:	2003      	movs	r0, #3
c0d01d6c:	7620      	strb	r0, [r4, #24]
c0d01d6e:	61e5      	str	r5, [r4, #28]
c0d01d70:	4620      	mov	r0, r4
c0d01d72:	3018      	adds	r0, #24
c0d01d74:	f7ff ff42 	bl	c0d01bfc <os_ux>
c0d01d78:	61e0      	str	r0, [r4, #28]
c0d01d7a:	f7ff f903 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d01d7e:	60a5      	str	r5, [r4, #8]
c0d01d80:	6820      	ldr	r0, [r4, #0]
c0d01d82:	2800      	cmp	r0, #0
c0d01d84:	d028      	beq.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d86:	69e0      	ldr	r0, [r4, #28]
c0d01d88:	491d      	ldr	r1, [pc, #116]	; (c0d01e00 <bagl_ui_nanos_screen1_button+0xdc>)
c0d01d8a:	4288      	cmp	r0, r1
c0d01d8c:	d116      	bne.n	c0d01dbc <bagl_ui_nanos_screen1_button+0x98>
c0d01d8e:	e023      	b.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d90:	6860      	ldr	r0, [r4, #4]
c0d01d92:	4285      	cmp	r5, r0
c0d01d94:	d220      	bcs.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d96:	f7ff ff89 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d01d9a:	2800      	cmp	r0, #0
c0d01d9c:	d11c      	bne.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d9e:	68a0      	ldr	r0, [r4, #8]
c0d01da0:	68e1      	ldr	r1, [r4, #12]
c0d01da2:	2538      	movs	r5, #56	; 0x38
c0d01da4:	4368      	muls	r0, r5
c0d01da6:	6822      	ldr	r2, [r4, #0]
c0d01da8:	1810      	adds	r0, r2, r0
c0d01daa:	2900      	cmp	r1, #0
c0d01dac:	d009      	beq.n	c0d01dc2 <bagl_ui_nanos_screen1_button+0x9e>
c0d01dae:	4788      	blx	r1
c0d01db0:	2800      	cmp	r0, #0
c0d01db2:	d106      	bne.n	c0d01dc2 <bagl_ui_nanos_screen1_button+0x9e>
c0d01db4:	68a0      	ldr	r0, [r4, #8]
c0d01db6:	1c45      	adds	r5, r0, #1
c0d01db8:	60a5      	str	r5, [r4, #8]
c0d01dba:	6820      	ldr	r0, [r4, #0]
c0d01dbc:	2800      	cmp	r0, #0
c0d01dbe:	d1e7      	bne.n	c0d01d90 <bagl_ui_nanos_screen1_button+0x6c>
c0d01dc0:	e00a      	b.n	c0d01dd8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01dc2:	2801      	cmp	r0, #1
c0d01dc4:	d103      	bne.n	c0d01dce <bagl_ui_nanos_screen1_button+0xaa>
c0d01dc6:	68a0      	ldr	r0, [r4, #8]
c0d01dc8:	4345      	muls	r5, r0
c0d01dca:	6820      	ldr	r0, [r4, #0]
c0d01dcc:	1940      	adds	r0, r0, r5
c0d01dce:	f7fe fb91 	bl	c0d004f4 <io_seproxyhal_display>
c0d01dd2:	68a0      	ldr	r0, [r4, #8]
c0d01dd4:	1c40      	adds	r0, r0, #1
c0d01dd6:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01dd8:	2000      	movs	r0, #0
c0d01dda:	bdb0      	pop	{r4, r5, r7, pc}
c0d01ddc:	80000002 	.word	0x80000002
c0d01de0:	80000001 	.word	0x80000001
c0d01de4:	54494e49 	.word	0x54494e49
c0d01de8:	00000000 	.word	0x00000000
c0d01dec:	6c697453 	.word	0x6c697453
c0d01df0:	6e75206c 	.word	0x6e75206c
c0d01df4:	74696e69 	.word	0x74696e69
c0d01df8:	00000000 	.word	0x00000000
c0d01dfc:	20001a98 	.word	0x20001a98
c0d01e00:	b0105044 	.word	0xb0105044
c0d01e04:	00001664 	.word	0x00001664
c0d01e08:	00000153 	.word	0x00000153

c0d01e0c <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01e0c:	b5b0      	push	{r4, r5, r7, lr}
c0d01e0e:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01e10:	2800      	cmp	r0, #0
c0d01e12:	d005      	beq.n	c0d01e20 <ui_display_debug+0x14>
c0d01e14:	2900      	cmp	r1, #0
c0d01e16:	d003      	beq.n	c0d01e20 <ui_display_debug+0x14>
c0d01e18:	2a00      	cmp	r2, #0
c0d01e1a:	d001      	beq.n	c0d01e20 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01e1c:	f7fe f942 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01e20:	4c21      	ldr	r4, [pc, #132]	; (c0d01ea8 <ui_display_debug+0x9c>)
c0d01e22:	4823      	ldr	r0, [pc, #140]	; (c0d01eb0 <ui_display_debug+0xa4>)
c0d01e24:	4478      	add	r0, pc
c0d01e26:	6020      	str	r0, [r4, #0]
c0d01e28:	2004      	movs	r0, #4
c0d01e2a:	6060      	str	r0, [r4, #4]
c0d01e2c:	4821      	ldr	r0, [pc, #132]	; (c0d01eb4 <ui_display_debug+0xa8>)
c0d01e2e:	4478      	add	r0, pc
c0d01e30:	6120      	str	r0, [r4, #16]
c0d01e32:	2500      	movs	r5, #0
c0d01e34:	60e5      	str	r5, [r4, #12]
c0d01e36:	2003      	movs	r0, #3
c0d01e38:	7620      	strb	r0, [r4, #24]
c0d01e3a:	61e5      	str	r5, [r4, #28]
c0d01e3c:	4620      	mov	r0, r4
c0d01e3e:	3018      	adds	r0, #24
c0d01e40:	f7ff fedc 	bl	c0d01bfc <os_ux>
c0d01e44:	61e0      	str	r0, [r4, #28]
c0d01e46:	f7ff f89d 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d01e4a:	60a5      	str	r5, [r4, #8]
c0d01e4c:	6820      	ldr	r0, [r4, #0]
c0d01e4e:	2800      	cmp	r0, #0
c0d01e50:	d028      	beq.n	c0d01ea4 <ui_display_debug+0x98>
c0d01e52:	69e0      	ldr	r0, [r4, #28]
c0d01e54:	4915      	ldr	r1, [pc, #84]	; (c0d01eac <ui_display_debug+0xa0>)
c0d01e56:	4288      	cmp	r0, r1
c0d01e58:	d116      	bne.n	c0d01e88 <ui_display_debug+0x7c>
c0d01e5a:	e023      	b.n	c0d01ea4 <ui_display_debug+0x98>
c0d01e5c:	6860      	ldr	r0, [r4, #4]
c0d01e5e:	4285      	cmp	r5, r0
c0d01e60:	d220      	bcs.n	c0d01ea4 <ui_display_debug+0x98>
c0d01e62:	f7ff ff23 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d01e66:	2800      	cmp	r0, #0
c0d01e68:	d11c      	bne.n	c0d01ea4 <ui_display_debug+0x98>
c0d01e6a:	68a0      	ldr	r0, [r4, #8]
c0d01e6c:	68e1      	ldr	r1, [r4, #12]
c0d01e6e:	2538      	movs	r5, #56	; 0x38
c0d01e70:	4368      	muls	r0, r5
c0d01e72:	6822      	ldr	r2, [r4, #0]
c0d01e74:	1810      	adds	r0, r2, r0
c0d01e76:	2900      	cmp	r1, #0
c0d01e78:	d009      	beq.n	c0d01e8e <ui_display_debug+0x82>
c0d01e7a:	4788      	blx	r1
c0d01e7c:	2800      	cmp	r0, #0
c0d01e7e:	d106      	bne.n	c0d01e8e <ui_display_debug+0x82>
c0d01e80:	68a0      	ldr	r0, [r4, #8]
c0d01e82:	1c45      	adds	r5, r0, #1
c0d01e84:	60a5      	str	r5, [r4, #8]
c0d01e86:	6820      	ldr	r0, [r4, #0]
c0d01e88:	2800      	cmp	r0, #0
c0d01e8a:	d1e7      	bne.n	c0d01e5c <ui_display_debug+0x50>
c0d01e8c:	e00a      	b.n	c0d01ea4 <ui_display_debug+0x98>
c0d01e8e:	2801      	cmp	r0, #1
c0d01e90:	d103      	bne.n	c0d01e9a <ui_display_debug+0x8e>
c0d01e92:	68a0      	ldr	r0, [r4, #8]
c0d01e94:	4345      	muls	r5, r0
c0d01e96:	6820      	ldr	r0, [r4, #0]
c0d01e98:	1940      	adds	r0, r0, r5
c0d01e9a:	f7fe fb2b 	bl	c0d004f4 <io_seproxyhal_display>
c0d01e9e:	68a0      	ldr	r0, [r4, #8]
c0d01ea0:	1c40      	adds	r0, r0, #1
c0d01ea2:	60a0      	str	r0, [r4, #8]
}
c0d01ea4:	bdb0      	pop	{r4, r5, r7, pc}
c0d01ea6:	46c0      	nop			; (mov r8, r8)
c0d01ea8:	20001a98 	.word	0x20001a98
c0d01eac:	b0105044 	.word	0xb0105044
c0d01eb0:	00001598 	.word	0x00001598
c0d01eb4:	00000087 	.word	0x00000087

c0d01eb8 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01eb8:	b580      	push	{r7, lr}
c0d01eba:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d01ebc:	4905      	ldr	r1, [pc, #20]	; (c0d01ed4 <bagl_ui_nanos_screen2_button+0x1c>)
c0d01ebe:	4288      	cmp	r0, r1
c0d01ec0:	d002      	beq.n	c0d01ec8 <bagl_ui_nanos_screen2_button+0x10>
c0d01ec2:	4905      	ldr	r1, [pc, #20]	; (c0d01ed8 <bagl_ui_nanos_screen2_button+0x20>)
c0d01ec4:	4288      	cmp	r0, r1
c0d01ec6:	d102      	bne.n	c0d01ece <bagl_ui_nanos_screen2_button+0x16>
c0d01ec8:	2000      	movs	r0, #0
c0d01eca:	f7ff fe79 	bl	c0d01bc0 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d01ece:	2000      	movs	r0, #0
c0d01ed0:	bd80      	pop	{r7, pc}
c0d01ed2:	46c0      	nop			; (mov r8, r8)
c0d01ed4:	80000002 	.word	0x80000002
c0d01ed8:	80000001 	.word	0x80000001

c0d01edc <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d01edc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ede:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d01ee0:	2001      	movs	r0, #1
c0d01ee2:	0204      	lsls	r4, r0, #8
c0d01ee4:	f7ff fea8 	bl	c0d01c38 <os_seph_features>
c0d01ee8:	4220      	tst	r0, r4
c0d01eea:	d136      	bne.n	c0d01f5a <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d01eec:	4c3c      	ldr	r4, [pc, #240]	; (c0d01fe0 <ui_idle+0x104>)
c0d01eee:	4840      	ldr	r0, [pc, #256]	; (c0d01ff0 <ui_idle+0x114>)
c0d01ef0:	4478      	add	r0, pc
c0d01ef2:	6020      	str	r0, [r4, #0]
c0d01ef4:	2004      	movs	r0, #4
c0d01ef6:	6060      	str	r0, [r4, #4]
c0d01ef8:	483e      	ldr	r0, [pc, #248]	; (c0d01ff4 <ui_idle+0x118>)
c0d01efa:	4478      	add	r0, pc
c0d01efc:	6120      	str	r0, [r4, #16]
c0d01efe:	2500      	movs	r5, #0
c0d01f00:	60e5      	str	r5, [r4, #12]
c0d01f02:	2003      	movs	r0, #3
c0d01f04:	7620      	strb	r0, [r4, #24]
c0d01f06:	61e5      	str	r5, [r4, #28]
c0d01f08:	4620      	mov	r0, r4
c0d01f0a:	3018      	adds	r0, #24
c0d01f0c:	f7ff fe76 	bl	c0d01bfc <os_ux>
c0d01f10:	61e0      	str	r0, [r4, #28]
c0d01f12:	f7ff f837 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d01f16:	60a5      	str	r5, [r4, #8]
c0d01f18:	6820      	ldr	r0, [r4, #0]
c0d01f1a:	2800      	cmp	r0, #0
c0d01f1c:	d05f      	beq.n	c0d01fde <ui_idle+0x102>
c0d01f1e:	69e0      	ldr	r0, [r4, #28]
c0d01f20:	4930      	ldr	r1, [pc, #192]	; (c0d01fe4 <ui_idle+0x108>)
c0d01f22:	4288      	cmp	r0, r1
c0d01f24:	d116      	bne.n	c0d01f54 <ui_idle+0x78>
c0d01f26:	e05a      	b.n	c0d01fde <ui_idle+0x102>
c0d01f28:	6860      	ldr	r0, [r4, #4]
c0d01f2a:	4285      	cmp	r5, r0
c0d01f2c:	d257      	bcs.n	c0d01fde <ui_idle+0x102>
c0d01f2e:	f7ff febd 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d01f32:	2800      	cmp	r0, #0
c0d01f34:	d153      	bne.n	c0d01fde <ui_idle+0x102>
c0d01f36:	68a0      	ldr	r0, [r4, #8]
c0d01f38:	68e1      	ldr	r1, [r4, #12]
c0d01f3a:	2538      	movs	r5, #56	; 0x38
c0d01f3c:	4368      	muls	r0, r5
c0d01f3e:	6822      	ldr	r2, [r4, #0]
c0d01f40:	1810      	adds	r0, r2, r0
c0d01f42:	2900      	cmp	r1, #0
c0d01f44:	d040      	beq.n	c0d01fc8 <ui_idle+0xec>
c0d01f46:	4788      	blx	r1
c0d01f48:	2800      	cmp	r0, #0
c0d01f4a:	d13d      	bne.n	c0d01fc8 <ui_idle+0xec>
c0d01f4c:	68a0      	ldr	r0, [r4, #8]
c0d01f4e:	1c45      	adds	r5, r0, #1
c0d01f50:	60a5      	str	r5, [r4, #8]
c0d01f52:	6820      	ldr	r0, [r4, #0]
c0d01f54:	2800      	cmp	r0, #0
c0d01f56:	d1e7      	bne.n	c0d01f28 <ui_idle+0x4c>
c0d01f58:	e041      	b.n	c0d01fde <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d01f5a:	4c21      	ldr	r4, [pc, #132]	; (c0d01fe0 <ui_idle+0x104>)
c0d01f5c:	4822      	ldr	r0, [pc, #136]	; (c0d01fe8 <ui_idle+0x10c>)
c0d01f5e:	4478      	add	r0, pc
c0d01f60:	6020      	str	r0, [r4, #0]
c0d01f62:	2004      	movs	r0, #4
c0d01f64:	6060      	str	r0, [r4, #4]
c0d01f66:	4821      	ldr	r0, [pc, #132]	; (c0d01fec <ui_idle+0x110>)
c0d01f68:	4478      	add	r0, pc
c0d01f6a:	6120      	str	r0, [r4, #16]
c0d01f6c:	2500      	movs	r5, #0
c0d01f6e:	60e5      	str	r5, [r4, #12]
c0d01f70:	2003      	movs	r0, #3
c0d01f72:	7620      	strb	r0, [r4, #24]
c0d01f74:	61e5      	str	r5, [r4, #28]
c0d01f76:	4620      	mov	r0, r4
c0d01f78:	3018      	adds	r0, #24
c0d01f7a:	f7ff fe3f 	bl	c0d01bfc <os_ux>
c0d01f7e:	61e0      	str	r0, [r4, #28]
c0d01f80:	f7ff f800 	bl	c0d00f84 <io_seproxyhal_init_ux>
c0d01f84:	60a5      	str	r5, [r4, #8]
c0d01f86:	6820      	ldr	r0, [r4, #0]
c0d01f88:	2800      	cmp	r0, #0
c0d01f8a:	d028      	beq.n	c0d01fde <ui_idle+0x102>
c0d01f8c:	69e0      	ldr	r0, [r4, #28]
c0d01f8e:	4915      	ldr	r1, [pc, #84]	; (c0d01fe4 <ui_idle+0x108>)
c0d01f90:	4288      	cmp	r0, r1
c0d01f92:	d116      	bne.n	c0d01fc2 <ui_idle+0xe6>
c0d01f94:	e023      	b.n	c0d01fde <ui_idle+0x102>
c0d01f96:	6860      	ldr	r0, [r4, #4]
c0d01f98:	4285      	cmp	r5, r0
c0d01f9a:	d220      	bcs.n	c0d01fde <ui_idle+0x102>
c0d01f9c:	f7ff fe86 	bl	c0d01cac <io_seproxyhal_spi_is_status_sent>
c0d01fa0:	2800      	cmp	r0, #0
c0d01fa2:	d11c      	bne.n	c0d01fde <ui_idle+0x102>
c0d01fa4:	68a0      	ldr	r0, [r4, #8]
c0d01fa6:	68e1      	ldr	r1, [r4, #12]
c0d01fa8:	2538      	movs	r5, #56	; 0x38
c0d01faa:	4368      	muls	r0, r5
c0d01fac:	6822      	ldr	r2, [r4, #0]
c0d01fae:	1810      	adds	r0, r2, r0
c0d01fb0:	2900      	cmp	r1, #0
c0d01fb2:	d009      	beq.n	c0d01fc8 <ui_idle+0xec>
c0d01fb4:	4788      	blx	r1
c0d01fb6:	2800      	cmp	r0, #0
c0d01fb8:	d106      	bne.n	c0d01fc8 <ui_idle+0xec>
c0d01fba:	68a0      	ldr	r0, [r4, #8]
c0d01fbc:	1c45      	adds	r5, r0, #1
c0d01fbe:	60a5      	str	r5, [r4, #8]
c0d01fc0:	6820      	ldr	r0, [r4, #0]
c0d01fc2:	2800      	cmp	r0, #0
c0d01fc4:	d1e7      	bne.n	c0d01f96 <ui_idle+0xba>
c0d01fc6:	e00a      	b.n	c0d01fde <ui_idle+0x102>
c0d01fc8:	2801      	cmp	r0, #1
c0d01fca:	d103      	bne.n	c0d01fd4 <ui_idle+0xf8>
c0d01fcc:	68a0      	ldr	r0, [r4, #8]
c0d01fce:	4345      	muls	r5, r0
c0d01fd0:	6820      	ldr	r0, [r4, #0]
c0d01fd2:	1940      	adds	r0, r0, r5
c0d01fd4:	f7fe fa8e 	bl	c0d004f4 <io_seproxyhal_display>
c0d01fd8:	68a0      	ldr	r0, [r4, #8]
c0d01fda:	1c40      	adds	r0, r0, #1
c0d01fdc:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d01fde:	bdb0      	pop	{r4, r5, r7, pc}
c0d01fe0:	20001a98 	.word	0x20001a98
c0d01fe4:	b0105044 	.word	0xb0105044
c0d01fe8:	0000153e 	.word	0x0000153e
c0d01fec:	0000008d 	.word	0x0000008d
c0d01ff0:	000013ec 	.word	0x000013ec
c0d01ff4:	fffffe27 	.word	0xfffffe27

c0d01ff8 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d01ff8:	2000      	movs	r0, #0
c0d01ffa:	4770      	bx	lr

c0d01ffc <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d01ffc:	b5d0      	push	{r4, r6, r7, lr}
c0d01ffe:	af02      	add	r7, sp, #8
c0d02000:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02002:	4620      	mov	r0, r4
c0d02004:	f7ff fddc 	bl	c0d01bc0 <os_sched_exit>
    return NULL;
c0d02008:	4620      	mov	r0, r4
c0d0200a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0200c <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d0200c:	4902      	ldr	r1, [pc, #8]	; (c0d02018 <USBD_LL_Init+0xc>)
c0d0200e:	2000      	movs	r0, #0
c0d02010:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02012:	4902      	ldr	r1, [pc, #8]	; (c0d0201c <USBD_LL_Init+0x10>)
c0d02014:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02016:	4770      	bx	lr
c0d02018:	20001d2c 	.word	0x20001d2c
c0d0201c:	20001d30 	.word	0x20001d30

c0d02020 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02020:	b5d0      	push	{r4, r6, r7, lr}
c0d02022:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02024:	4806      	ldr	r0, [pc, #24]	; (c0d02040 <USBD_LL_DeInit+0x20>)
c0d02026:	214f      	movs	r1, #79	; 0x4f
c0d02028:	7001      	strb	r1, [r0, #0]
c0d0202a:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0202c:	7044      	strb	r4, [r0, #1]
c0d0202e:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02030:	7081      	strb	r1, [r0, #2]
c0d02032:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02034:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02036:	2104      	movs	r1, #4
c0d02038:	f7ff fe1a 	bl	c0d01c70 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d0203c:	4620      	mov	r0, r4
c0d0203e:	bdd0      	pop	{r4, r6, r7, pc}
c0d02040:	20001a18 	.word	0x20001a18

c0d02044 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02044:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02046:	af03      	add	r7, sp, #12
c0d02048:	b083      	sub	sp, #12
c0d0204a:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0204c:	264f      	movs	r6, #79	; 0x4f
c0d0204e:	702e      	strb	r6, [r5, #0]
c0d02050:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02052:	706c      	strb	r4, [r5, #1]
c0d02054:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02056:	70a8      	strb	r0, [r5, #2]
c0d02058:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0205a:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d0205c:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0205e:	2105      	movs	r1, #5
c0d02060:	4628      	mov	r0, r5
c0d02062:	f7ff fe05 	bl	c0d01c70 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02066:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02068:	706c      	strb	r4, [r5, #1]
c0d0206a:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d0206c:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0206e:	70e8      	strb	r0, [r5, #3]
c0d02070:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02072:	4628      	mov	r0, r5
c0d02074:	f7ff fdfc 	bl	c0d01c70 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02078:	4620      	mov	r0, r4
c0d0207a:	b003      	add	sp, #12
c0d0207c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0207e <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0207e:	b5d0      	push	{r4, r6, r7, lr}
c0d02080:	af02      	add	r7, sp, #8
c0d02082:	b082      	sub	sp, #8
c0d02084:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02086:	214f      	movs	r1, #79	; 0x4f
c0d02088:	7001      	strb	r1, [r0, #0]
c0d0208a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0208c:	7044      	strb	r4, [r0, #1]
c0d0208e:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02090:	7081      	strb	r1, [r0, #2]
c0d02092:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02094:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d02096:	2104      	movs	r1, #4
c0d02098:	f7ff fdea 	bl	c0d01c70 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0209c:	4620      	mov	r0, r4
c0d0209e:	b002      	add	sp, #8
c0d020a0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d020a4 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d020a4:	b5b0      	push	{r4, r5, r7, lr}
c0d020a6:	af02      	add	r7, sp, #8
c0d020a8:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d020aa:	480f      	ldr	r0, [pc, #60]	; (c0d020e8 <USBD_LL_OpenEP+0x44>)
c0d020ac:	2400      	movs	r4, #0
c0d020ae:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d020b0:	480e      	ldr	r0, [pc, #56]	; (c0d020ec <USBD_LL_OpenEP+0x48>)
c0d020b2:	6004      	str	r4, [r0, #0]
c0d020b4:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d020b6:	254f      	movs	r5, #79	; 0x4f
c0d020b8:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d020ba:	7044      	strb	r4, [r0, #1]
c0d020bc:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d020be:	7085      	strb	r5, [r0, #2]
c0d020c0:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d020c2:	70c5      	strb	r5, [r0, #3]
c0d020c4:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d020c6:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d020c8:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d020ca:	2a03      	cmp	r2, #3
c0d020cc:	d802      	bhi.n	c0d020d4 <USBD_LL_OpenEP+0x30>
c0d020ce:	00d0      	lsls	r0, r2, #3
c0d020d0:	4c07      	ldr	r4, [pc, #28]	; (c0d020f0 <USBD_LL_OpenEP+0x4c>)
c0d020d2:	40c4      	lsrs	r4, r0
c0d020d4:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d020d6:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d020d8:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d020da:	2108      	movs	r1, #8
c0d020dc:	f7ff fdc8 	bl	c0d01c70 <io_seproxyhal_spi_send>
c0d020e0:	2000      	movs	r0, #0
  return USBD_OK; 
c0d020e2:	b002      	add	sp, #8
c0d020e4:	bdb0      	pop	{r4, r5, r7, pc}
c0d020e6:	46c0      	nop			; (mov r8, r8)
c0d020e8:	20001d2c 	.word	0x20001d2c
c0d020ec:	20001d30 	.word	0x20001d30
c0d020f0:	02030401 	.word	0x02030401

c0d020f4 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d020f4:	b5d0      	push	{r4, r6, r7, lr}
c0d020f6:	af02      	add	r7, sp, #8
c0d020f8:	b082      	sub	sp, #8
c0d020fa:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d020fc:	224f      	movs	r2, #79	; 0x4f
c0d020fe:	7002      	strb	r2, [r0, #0]
c0d02100:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02102:	7044      	strb	r4, [r0, #1]
c0d02104:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02106:	7082      	strb	r2, [r0, #2]
c0d02108:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0210a:	70c2      	strb	r2, [r0, #3]
c0d0210c:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0210e:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02110:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02112:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02114:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02116:	2108      	movs	r1, #8
c0d02118:	f7ff fdaa 	bl	c0d01c70 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0211c:	4620      	mov	r0, r4
c0d0211e:	b002      	add	sp, #8
c0d02120:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02124 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02124:	b5b0      	push	{r4, r5, r7, lr}
c0d02126:	af02      	add	r7, sp, #8
c0d02128:	b082      	sub	sp, #8
c0d0212a:	460d      	mov	r5, r1
c0d0212c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0212e:	2150      	movs	r1, #80	; 0x50
c0d02130:	7001      	strb	r1, [r0, #0]
c0d02132:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02134:	7044      	strb	r4, [r0, #1]
c0d02136:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02138:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0213a:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0213c:	2140      	movs	r1, #64	; 0x40
c0d0213e:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02140:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02142:	2106      	movs	r1, #6
c0d02144:	f7ff fd94 	bl	c0d01c70 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02148:	2080      	movs	r0, #128	; 0x80
c0d0214a:	4205      	tst	r5, r0
c0d0214c:	d101      	bne.n	c0d02152 <USBD_LL_StallEP+0x2e>
c0d0214e:	4807      	ldr	r0, [pc, #28]	; (c0d0216c <USBD_LL_StallEP+0x48>)
c0d02150:	e000      	b.n	c0d02154 <USBD_LL_StallEP+0x30>
c0d02152:	4805      	ldr	r0, [pc, #20]	; (c0d02168 <USBD_LL_StallEP+0x44>)
c0d02154:	6801      	ldr	r1, [r0, #0]
c0d02156:	227f      	movs	r2, #127	; 0x7f
c0d02158:	4015      	ands	r5, r2
c0d0215a:	2201      	movs	r2, #1
c0d0215c:	40aa      	lsls	r2, r5
c0d0215e:	430a      	orrs	r2, r1
c0d02160:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02162:	4620      	mov	r0, r4
c0d02164:	b002      	add	sp, #8
c0d02166:	bdb0      	pop	{r4, r5, r7, pc}
c0d02168:	20001d2c 	.word	0x20001d2c
c0d0216c:	20001d30 	.word	0x20001d30

c0d02170 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02170:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02172:	af03      	add	r7, sp, #12
c0d02174:	b083      	sub	sp, #12
c0d02176:	460d      	mov	r5, r1
c0d02178:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0217a:	2150      	movs	r1, #80	; 0x50
c0d0217c:	7001      	strb	r1, [r0, #0]
c0d0217e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02180:	7044      	strb	r4, [r0, #1]
c0d02182:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02184:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02186:	70c5      	strb	r5, [r0, #3]
c0d02188:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0218a:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d0218c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0218e:	2106      	movs	r1, #6
c0d02190:	f7ff fd6e 	bl	c0d01c70 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02194:	4235      	tst	r5, r6
c0d02196:	d101      	bne.n	c0d0219c <USBD_LL_ClearStallEP+0x2c>
c0d02198:	4807      	ldr	r0, [pc, #28]	; (c0d021b8 <USBD_LL_ClearStallEP+0x48>)
c0d0219a:	e000      	b.n	c0d0219e <USBD_LL_ClearStallEP+0x2e>
c0d0219c:	4805      	ldr	r0, [pc, #20]	; (c0d021b4 <USBD_LL_ClearStallEP+0x44>)
c0d0219e:	6801      	ldr	r1, [r0, #0]
c0d021a0:	227f      	movs	r2, #127	; 0x7f
c0d021a2:	4015      	ands	r5, r2
c0d021a4:	2201      	movs	r2, #1
c0d021a6:	40aa      	lsls	r2, r5
c0d021a8:	4391      	bics	r1, r2
c0d021aa:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d021ac:	4620      	mov	r0, r4
c0d021ae:	b003      	add	sp, #12
c0d021b0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021b2:	46c0      	nop			; (mov r8, r8)
c0d021b4:	20001d2c 	.word	0x20001d2c
c0d021b8:	20001d30 	.word	0x20001d30

c0d021bc <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d021bc:	2080      	movs	r0, #128	; 0x80
c0d021be:	4201      	tst	r1, r0
c0d021c0:	d001      	beq.n	c0d021c6 <USBD_LL_IsStallEP+0xa>
c0d021c2:	4806      	ldr	r0, [pc, #24]	; (c0d021dc <USBD_LL_IsStallEP+0x20>)
c0d021c4:	e000      	b.n	c0d021c8 <USBD_LL_IsStallEP+0xc>
c0d021c6:	4804      	ldr	r0, [pc, #16]	; (c0d021d8 <USBD_LL_IsStallEP+0x1c>)
c0d021c8:	6800      	ldr	r0, [r0, #0]
c0d021ca:	227f      	movs	r2, #127	; 0x7f
c0d021cc:	4011      	ands	r1, r2
c0d021ce:	2201      	movs	r2, #1
c0d021d0:	408a      	lsls	r2, r1
c0d021d2:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d021d4:	b2d0      	uxtb	r0, r2
c0d021d6:	4770      	bx	lr
c0d021d8:	20001d30 	.word	0x20001d30
c0d021dc:	20001d2c 	.word	0x20001d2c

c0d021e0 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d021e0:	b5d0      	push	{r4, r6, r7, lr}
c0d021e2:	af02      	add	r7, sp, #8
c0d021e4:	b082      	sub	sp, #8
c0d021e6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021e8:	224f      	movs	r2, #79	; 0x4f
c0d021ea:	7002      	strb	r2, [r0, #0]
c0d021ec:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d021ee:	7044      	strb	r4, [r0, #1]
c0d021f0:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d021f2:	7082      	strb	r2, [r0, #2]
c0d021f4:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d021f6:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d021f8:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d021fa:	2105      	movs	r1, #5
c0d021fc:	f7ff fd38 	bl	c0d01c70 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02200:	4620      	mov	r0, r4
c0d02202:	b002      	add	sp, #8
c0d02204:	bdd0      	pop	{r4, r6, r7, pc}

c0d02206 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02206:	b5b0      	push	{r4, r5, r7, lr}
c0d02208:	af02      	add	r7, sp, #8
c0d0220a:	b082      	sub	sp, #8
c0d0220c:	461c      	mov	r4, r3
c0d0220e:	4615      	mov	r5, r2
c0d02210:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02212:	2250      	movs	r2, #80	; 0x50
c0d02214:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02216:	1ce2      	adds	r2, r4, #3
c0d02218:	0a13      	lsrs	r3, r2, #8
c0d0221a:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d0221c:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0221e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02220:	2120      	movs	r1, #32
c0d02222:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02224:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02226:	2106      	movs	r1, #6
c0d02228:	f7ff fd22 	bl	c0d01c70 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d0222c:	4628      	mov	r0, r5
c0d0222e:	4621      	mov	r1, r4
c0d02230:	f7ff fd1e 	bl	c0d01c70 <io_seproxyhal_spi_send>
c0d02234:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02236:	b002      	add	sp, #8
c0d02238:	bdb0      	pop	{r4, r5, r7, pc}

c0d0223a <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0223a:	b5d0      	push	{r4, r6, r7, lr}
c0d0223c:	af02      	add	r7, sp, #8
c0d0223e:	b082      	sub	sp, #8
c0d02240:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02242:	2350      	movs	r3, #80	; 0x50
c0d02244:	7003      	strb	r3, [r0, #0]
c0d02246:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02248:	7044      	strb	r4, [r0, #1]
c0d0224a:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d0224c:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0224e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02250:	2130      	movs	r1, #48	; 0x30
c0d02252:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02254:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02256:	2106      	movs	r1, #6
c0d02258:	f7ff fd0a 	bl	c0d01c70 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d0225c:	4620      	mov	r0, r4
c0d0225e:	b002      	add	sp, #8
c0d02260:	bdd0      	pop	{r4, r6, r7, pc}

c0d02262 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02262:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02264:	af03      	add	r7, sp, #12
c0d02266:	b081      	sub	sp, #4
c0d02268:	4615      	mov	r5, r2
c0d0226a:	460e      	mov	r6, r1
c0d0226c:	4604      	mov	r4, r0
c0d0226e:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02270:	2c00      	cmp	r4, #0
c0d02272:	d011      	beq.n	c0d02298 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02274:	2049      	movs	r0, #73	; 0x49
c0d02276:	0081      	lsls	r1, r0, #2
c0d02278:	4620      	mov	r0, r4
c0d0227a:	f000 fef9 	bl	c0d03070 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0227e:	2e00      	cmp	r6, #0
c0d02280:	d002      	beq.n	c0d02288 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02282:	2011      	movs	r0, #17
c0d02284:	0100      	lsls	r0, r0, #4
c0d02286:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02288:	20fc      	movs	r0, #252	; 0xfc
c0d0228a:	2101      	movs	r1, #1
c0d0228c:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d0228e:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02290:	4620      	mov	r0, r4
c0d02292:	f7ff febb 	bl	c0d0200c <USBD_LL_Init>
c0d02296:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02298:	b2c0      	uxtb	r0, r0
c0d0229a:	b001      	add	sp, #4
c0d0229c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0229e <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d0229e:	b5d0      	push	{r4, r6, r7, lr}
c0d022a0:	af02      	add	r7, sp, #8
c0d022a2:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d022a4:	20fc      	movs	r0, #252	; 0xfc
c0d022a6:	2101      	movs	r1, #1
c0d022a8:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d022aa:	2045      	movs	r0, #69	; 0x45
c0d022ac:	0080      	lsls	r0, r0, #2
c0d022ae:	5820      	ldr	r0, [r4, r0]
c0d022b0:	2800      	cmp	r0, #0
c0d022b2:	d006      	beq.n	c0d022c2 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d022b4:	6840      	ldr	r0, [r0, #4]
c0d022b6:	f7ff fb1f 	bl	c0d018f8 <pic>
c0d022ba:	4602      	mov	r2, r0
c0d022bc:	7921      	ldrb	r1, [r4, #4]
c0d022be:	4620      	mov	r0, r4
c0d022c0:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d022c2:	4620      	mov	r0, r4
c0d022c4:	f7ff fedb 	bl	c0d0207e <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d022c8:	4620      	mov	r0, r4
c0d022ca:	f7ff fea9 	bl	c0d02020 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d022ce:	2000      	movs	r0, #0
c0d022d0:	bdd0      	pop	{r4, r6, r7, pc}

c0d022d2 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d022d2:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d022d4:	2900      	cmp	r1, #0
c0d022d6:	d003      	beq.n	c0d022e0 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d022d8:	2245      	movs	r2, #69	; 0x45
c0d022da:	0092      	lsls	r2, r2, #2
c0d022dc:	5081      	str	r1, [r0, r2]
c0d022de:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d022e0:	b2d0      	uxtb	r0, r2
c0d022e2:	4770      	bx	lr

c0d022e4 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d022e4:	b580      	push	{r7, lr}
c0d022e6:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d022e8:	f7ff feac 	bl	c0d02044 <USBD_LL_Start>
  
  return USBD_OK;  
c0d022ec:	2000      	movs	r0, #0
c0d022ee:	bd80      	pop	{r7, pc}

c0d022f0 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d022f0:	b5b0      	push	{r4, r5, r7, lr}
c0d022f2:	af02      	add	r7, sp, #8
c0d022f4:	460c      	mov	r4, r1
c0d022f6:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d022f8:	2045      	movs	r0, #69	; 0x45
c0d022fa:	0080      	lsls	r0, r0, #2
c0d022fc:	5828      	ldr	r0, [r5, r0]
c0d022fe:	2800      	cmp	r0, #0
c0d02300:	d00c      	beq.n	c0d0231c <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02302:	6800      	ldr	r0, [r0, #0]
c0d02304:	f7ff faf8 	bl	c0d018f8 <pic>
c0d02308:	4602      	mov	r2, r0
c0d0230a:	4628      	mov	r0, r5
c0d0230c:	4621      	mov	r1, r4
c0d0230e:	4790      	blx	r2
c0d02310:	4601      	mov	r1, r0
c0d02312:	2002      	movs	r0, #2
c0d02314:	2900      	cmp	r1, #0
c0d02316:	d100      	bne.n	c0d0231a <USBD_SetClassConfig+0x2a>
c0d02318:	4608      	mov	r0, r1
c0d0231a:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d0231c:	2002      	movs	r0, #2
c0d0231e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02320 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02320:	b5b0      	push	{r4, r5, r7, lr}
c0d02322:	af02      	add	r7, sp, #8
c0d02324:	460c      	mov	r4, r1
c0d02326:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02328:	2045      	movs	r0, #69	; 0x45
c0d0232a:	0080      	lsls	r0, r0, #2
c0d0232c:	5828      	ldr	r0, [r5, r0]
c0d0232e:	2800      	cmp	r0, #0
c0d02330:	d006      	beq.n	c0d02340 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02332:	6840      	ldr	r0, [r0, #4]
c0d02334:	f7ff fae0 	bl	c0d018f8 <pic>
c0d02338:	4602      	mov	r2, r0
c0d0233a:	4628      	mov	r0, r5
c0d0233c:	4621      	mov	r1, r4
c0d0233e:	4790      	blx	r2
  }
  return USBD_OK;
c0d02340:	2000      	movs	r0, #0
c0d02342:	bdb0      	pop	{r4, r5, r7, pc}

c0d02344 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02344:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02346:	af03      	add	r7, sp, #12
c0d02348:	b081      	sub	sp, #4
c0d0234a:	4604      	mov	r4, r0
c0d0234c:	2021      	movs	r0, #33	; 0x21
c0d0234e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02350:	19a5      	adds	r5, r4, r6
c0d02352:	4628      	mov	r0, r5
c0d02354:	f000 fb69 	bl	c0d02a2a <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02358:	20f4      	movs	r0, #244	; 0xf4
c0d0235a:	2101      	movs	r1, #1
c0d0235c:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0235e:	2087      	movs	r0, #135	; 0x87
c0d02360:	0040      	lsls	r0, r0, #1
c0d02362:	5a20      	ldrh	r0, [r4, r0]
c0d02364:	21f8      	movs	r1, #248	; 0xf8
c0d02366:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02368:	5da1      	ldrb	r1, [r4, r6]
c0d0236a:	201f      	movs	r0, #31
c0d0236c:	4008      	ands	r0, r1
c0d0236e:	2802      	cmp	r0, #2
c0d02370:	d008      	beq.n	c0d02384 <USBD_LL_SetupStage+0x40>
c0d02372:	2801      	cmp	r0, #1
c0d02374:	d00b      	beq.n	c0d0238e <USBD_LL_SetupStage+0x4a>
c0d02376:	2800      	cmp	r0, #0
c0d02378:	d10e      	bne.n	c0d02398 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d0237a:	4620      	mov	r0, r4
c0d0237c:	4629      	mov	r1, r5
c0d0237e:	f000 f8f1 	bl	c0d02564 <USBD_StdDevReq>
c0d02382:	e00e      	b.n	c0d023a2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02384:	4620      	mov	r0, r4
c0d02386:	4629      	mov	r1, r5
c0d02388:	f000 fad3 	bl	c0d02932 <USBD_StdEPReq>
c0d0238c:	e009      	b.n	c0d023a2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d0238e:	4620      	mov	r0, r4
c0d02390:	4629      	mov	r1, r5
c0d02392:	f000 faa6 	bl	c0d028e2 <USBD_StdItfReq>
c0d02396:	e004      	b.n	c0d023a2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02398:	2080      	movs	r0, #128	; 0x80
c0d0239a:	4001      	ands	r1, r0
c0d0239c:	4620      	mov	r0, r4
c0d0239e:	f7ff fec1 	bl	c0d02124 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d023a2:	2000      	movs	r0, #0
c0d023a4:	b001      	add	sp, #4
c0d023a6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d023a8 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d023a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d023aa:	af03      	add	r7, sp, #12
c0d023ac:	b081      	sub	sp, #4
c0d023ae:	4615      	mov	r5, r2
c0d023b0:	460e      	mov	r6, r1
c0d023b2:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d023b4:	2e00      	cmp	r6, #0
c0d023b6:	d011      	beq.n	c0d023dc <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d023b8:	2045      	movs	r0, #69	; 0x45
c0d023ba:	0080      	lsls	r0, r0, #2
c0d023bc:	5820      	ldr	r0, [r4, r0]
c0d023be:	6980      	ldr	r0, [r0, #24]
c0d023c0:	2800      	cmp	r0, #0
c0d023c2:	d034      	beq.n	c0d0242e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d023c4:	21fc      	movs	r1, #252	; 0xfc
c0d023c6:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d023c8:	2903      	cmp	r1, #3
c0d023ca:	d130      	bne.n	c0d0242e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d023cc:	f7ff fa94 	bl	c0d018f8 <pic>
c0d023d0:	4603      	mov	r3, r0
c0d023d2:	4620      	mov	r0, r4
c0d023d4:	4631      	mov	r1, r6
c0d023d6:	462a      	mov	r2, r5
c0d023d8:	4798      	blx	r3
c0d023da:	e028      	b.n	c0d0242e <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d023dc:	20f4      	movs	r0, #244	; 0xf4
c0d023de:	5820      	ldr	r0, [r4, r0]
c0d023e0:	2803      	cmp	r0, #3
c0d023e2:	d124      	bne.n	c0d0242e <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d023e4:	2090      	movs	r0, #144	; 0x90
c0d023e6:	5820      	ldr	r0, [r4, r0]
c0d023e8:	218c      	movs	r1, #140	; 0x8c
c0d023ea:	5861      	ldr	r1, [r4, r1]
c0d023ec:	4622      	mov	r2, r4
c0d023ee:	328c      	adds	r2, #140	; 0x8c
c0d023f0:	4281      	cmp	r1, r0
c0d023f2:	d90a      	bls.n	c0d0240a <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d023f4:	1a09      	subs	r1, r1, r0
c0d023f6:	6011      	str	r1, [r2, #0]
c0d023f8:	4281      	cmp	r1, r0
c0d023fa:	d300      	bcc.n	c0d023fe <USBD_LL_DataOutStage+0x56>
c0d023fc:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d023fe:	b28a      	uxth	r2, r1
c0d02400:	4620      	mov	r0, r4
c0d02402:	4629      	mov	r1, r5
c0d02404:	f000 fc70 	bl	c0d02ce8 <USBD_CtlContinueRx>
c0d02408:	e011      	b.n	c0d0242e <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0240a:	2045      	movs	r0, #69	; 0x45
c0d0240c:	0080      	lsls	r0, r0, #2
c0d0240e:	5820      	ldr	r0, [r4, r0]
c0d02410:	6900      	ldr	r0, [r0, #16]
c0d02412:	2800      	cmp	r0, #0
c0d02414:	d008      	beq.n	c0d02428 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02416:	21fc      	movs	r1, #252	; 0xfc
c0d02418:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0241a:	2903      	cmp	r1, #3
c0d0241c:	d104      	bne.n	c0d02428 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d0241e:	f7ff fa6b 	bl	c0d018f8 <pic>
c0d02422:	4601      	mov	r1, r0
c0d02424:	4620      	mov	r0, r4
c0d02426:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02428:	4620      	mov	r0, r4
c0d0242a:	f000 fc65 	bl	c0d02cf8 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0242e:	2000      	movs	r0, #0
c0d02430:	b001      	add	sp, #4
c0d02432:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02434 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02434:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02436:	af03      	add	r7, sp, #12
c0d02438:	b081      	sub	sp, #4
c0d0243a:	460d      	mov	r5, r1
c0d0243c:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0243e:	2d00      	cmp	r5, #0
c0d02440:	d012      	beq.n	c0d02468 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02442:	2045      	movs	r0, #69	; 0x45
c0d02444:	0080      	lsls	r0, r0, #2
c0d02446:	5820      	ldr	r0, [r4, r0]
c0d02448:	2800      	cmp	r0, #0
c0d0244a:	d054      	beq.n	c0d024f6 <USBD_LL_DataInStage+0xc2>
c0d0244c:	6940      	ldr	r0, [r0, #20]
c0d0244e:	2800      	cmp	r0, #0
c0d02450:	d051      	beq.n	c0d024f6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02452:	21fc      	movs	r1, #252	; 0xfc
c0d02454:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02456:	2903      	cmp	r1, #3
c0d02458:	d14d      	bne.n	c0d024f6 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d0245a:	f7ff fa4d 	bl	c0d018f8 <pic>
c0d0245e:	4602      	mov	r2, r0
c0d02460:	4620      	mov	r0, r4
c0d02462:	4629      	mov	r1, r5
c0d02464:	4790      	blx	r2
c0d02466:	e046      	b.n	c0d024f6 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02468:	20f4      	movs	r0, #244	; 0xf4
c0d0246a:	5820      	ldr	r0, [r4, r0]
c0d0246c:	2802      	cmp	r0, #2
c0d0246e:	d13a      	bne.n	c0d024e6 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02470:	69e0      	ldr	r0, [r4, #28]
c0d02472:	6a25      	ldr	r5, [r4, #32]
c0d02474:	42a8      	cmp	r0, r5
c0d02476:	d90b      	bls.n	c0d02490 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02478:	1b40      	subs	r0, r0, r5
c0d0247a:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d0247c:	2109      	movs	r1, #9
c0d0247e:	014a      	lsls	r2, r1, #5
c0d02480:	58a1      	ldr	r1, [r4, r2]
c0d02482:	1949      	adds	r1, r1, r5
c0d02484:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02486:	b282      	uxth	r2, r0
c0d02488:	4620      	mov	r0, r4
c0d0248a:	f000 fc1e 	bl	c0d02cca <USBD_CtlContinueSendData>
c0d0248e:	e02a      	b.n	c0d024e6 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02490:	69a6      	ldr	r6, [r4, #24]
c0d02492:	4630      	mov	r0, r6
c0d02494:	4629      	mov	r1, r5
c0d02496:	f000 fccf 	bl	c0d02e38 <__aeabi_uidivmod>
c0d0249a:	42ae      	cmp	r6, r5
c0d0249c:	d30f      	bcc.n	c0d024be <USBD_LL_DataInStage+0x8a>
c0d0249e:	2900      	cmp	r1, #0
c0d024a0:	d10d      	bne.n	c0d024be <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d024a2:	20f8      	movs	r0, #248	; 0xf8
c0d024a4:	5820      	ldr	r0, [r4, r0]
c0d024a6:	4625      	mov	r5, r4
c0d024a8:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d024aa:	4286      	cmp	r6, r0
c0d024ac:	d207      	bcs.n	c0d024be <USBD_LL_DataInStage+0x8a>
c0d024ae:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d024b0:	4620      	mov	r0, r4
c0d024b2:	4631      	mov	r1, r6
c0d024b4:	4632      	mov	r2, r6
c0d024b6:	f000 fc08 	bl	c0d02cca <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d024ba:	602e      	str	r6, [r5, #0]
c0d024bc:	e013      	b.n	c0d024e6 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d024be:	2045      	movs	r0, #69	; 0x45
c0d024c0:	0080      	lsls	r0, r0, #2
c0d024c2:	5820      	ldr	r0, [r4, r0]
c0d024c4:	2800      	cmp	r0, #0
c0d024c6:	d00b      	beq.n	c0d024e0 <USBD_LL_DataInStage+0xac>
c0d024c8:	68c0      	ldr	r0, [r0, #12]
c0d024ca:	2800      	cmp	r0, #0
c0d024cc:	d008      	beq.n	c0d024e0 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d024ce:	21fc      	movs	r1, #252	; 0xfc
c0d024d0:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d024d2:	2903      	cmp	r1, #3
c0d024d4:	d104      	bne.n	c0d024e0 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d024d6:	f7ff fa0f 	bl	c0d018f8 <pic>
c0d024da:	4601      	mov	r1, r0
c0d024dc:	4620      	mov	r0, r4
c0d024de:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d024e0:	4620      	mov	r0, r4
c0d024e2:	f000 fc16 	bl	c0d02d12 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d024e6:	2001      	movs	r0, #1
c0d024e8:	0201      	lsls	r1, r0, #8
c0d024ea:	1860      	adds	r0, r4, r1
c0d024ec:	5c61      	ldrb	r1, [r4, r1]
c0d024ee:	2901      	cmp	r1, #1
c0d024f0:	d101      	bne.n	c0d024f6 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d024f2:	2100      	movs	r1, #0
c0d024f4:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d024f6:	2000      	movs	r0, #0
c0d024f8:	b001      	add	sp, #4
c0d024fa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024fc <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d024fc:	b5d0      	push	{r4, r6, r7, lr}
c0d024fe:	af02      	add	r7, sp, #8
c0d02500:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02502:	2090      	movs	r0, #144	; 0x90
c0d02504:	2140      	movs	r1, #64	; 0x40
c0d02506:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02508:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d0250a:	20fc      	movs	r0, #252	; 0xfc
c0d0250c:	2101      	movs	r1, #1
c0d0250e:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02510:	2045      	movs	r0, #69	; 0x45
c0d02512:	0080      	lsls	r0, r0, #2
c0d02514:	5820      	ldr	r0, [r4, r0]
c0d02516:	2800      	cmp	r0, #0
c0d02518:	d006      	beq.n	c0d02528 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d0251a:	6840      	ldr	r0, [r0, #4]
c0d0251c:	f7ff f9ec 	bl	c0d018f8 <pic>
c0d02520:	4602      	mov	r2, r0
c0d02522:	7921      	ldrb	r1, [r4, #4]
c0d02524:	4620      	mov	r0, r4
c0d02526:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02528:	2000      	movs	r0, #0
c0d0252a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0252c <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d0252c:	7401      	strb	r1, [r0, #16]
c0d0252e:	2000      	movs	r0, #0
  return USBD_OK;
c0d02530:	4770      	bx	lr

c0d02532 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02532:	2000      	movs	r0, #0
c0d02534:	4770      	bx	lr

c0d02536 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02536:	2000      	movs	r0, #0
c0d02538:	4770      	bx	lr

c0d0253a <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d0253a:	b5d0      	push	{r4, r6, r7, lr}
c0d0253c:	af02      	add	r7, sp, #8
c0d0253e:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02540:	20fc      	movs	r0, #252	; 0xfc
c0d02542:	5c20      	ldrb	r0, [r4, r0]
c0d02544:	2803      	cmp	r0, #3
c0d02546:	d10a      	bne.n	c0d0255e <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02548:	2045      	movs	r0, #69	; 0x45
c0d0254a:	0080      	lsls	r0, r0, #2
c0d0254c:	5820      	ldr	r0, [r4, r0]
c0d0254e:	69c0      	ldr	r0, [r0, #28]
c0d02550:	2800      	cmp	r0, #0
c0d02552:	d004      	beq.n	c0d0255e <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02554:	f7ff f9d0 	bl	c0d018f8 <pic>
c0d02558:	4601      	mov	r1, r0
c0d0255a:	4620      	mov	r0, r4
c0d0255c:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d0255e:	2000      	movs	r0, #0
c0d02560:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02564 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02564:	b5d0      	push	{r4, r6, r7, lr}
c0d02566:	af02      	add	r7, sp, #8
c0d02568:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d0256a:	7848      	ldrb	r0, [r1, #1]
c0d0256c:	2809      	cmp	r0, #9
c0d0256e:	d810      	bhi.n	c0d02592 <USBD_StdDevReq+0x2e>
c0d02570:	4478      	add	r0, pc
c0d02572:	7900      	ldrb	r0, [r0, #4]
c0d02574:	0040      	lsls	r0, r0, #1
c0d02576:	4487      	add	pc, r0
c0d02578:	150c0804 	.word	0x150c0804
c0d0257c:	0c25190c 	.word	0x0c25190c
c0d02580:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02582:	4620      	mov	r0, r4
c0d02584:	f000 f938 	bl	c0d027f8 <USBD_GetStatus>
c0d02588:	e01f      	b.n	c0d025ca <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d0258a:	4620      	mov	r0, r4
c0d0258c:	f000 f976 	bl	c0d0287c <USBD_ClrFeature>
c0d02590:	e01b      	b.n	c0d025ca <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02592:	2180      	movs	r1, #128	; 0x80
c0d02594:	4620      	mov	r0, r4
c0d02596:	f7ff fdc5 	bl	c0d02124 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0259a:	2100      	movs	r1, #0
c0d0259c:	4620      	mov	r0, r4
c0d0259e:	f7ff fdc1 	bl	c0d02124 <USBD_LL_StallEP>
c0d025a2:	e012      	b.n	c0d025ca <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d025a4:	4620      	mov	r0, r4
c0d025a6:	f000 f950 	bl	c0d0284a <USBD_SetFeature>
c0d025aa:	e00e      	b.n	c0d025ca <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d025ac:	4620      	mov	r0, r4
c0d025ae:	f000 f897 	bl	c0d026e0 <USBD_SetAddress>
c0d025b2:	e00a      	b.n	c0d025ca <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d025b4:	4620      	mov	r0, r4
c0d025b6:	f000 f8ff 	bl	c0d027b8 <USBD_GetConfig>
c0d025ba:	e006      	b.n	c0d025ca <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d025bc:	4620      	mov	r0, r4
c0d025be:	f000 f8bd 	bl	c0d0273c <USBD_SetConfig>
c0d025c2:	e002      	b.n	c0d025ca <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d025c4:	4620      	mov	r0, r4
c0d025c6:	f000 f803 	bl	c0d025d0 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d025ca:	2000      	movs	r0, #0
c0d025cc:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d025d0 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d025d0:	b5b0      	push	{r4, r5, r7, lr}
c0d025d2:	af02      	add	r7, sp, #8
c0d025d4:	b082      	sub	sp, #8
c0d025d6:	460d      	mov	r5, r1
c0d025d8:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d025da:	8868      	ldrh	r0, [r5, #2]
c0d025dc:	0a01      	lsrs	r1, r0, #8
c0d025de:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d025e0:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d025e2:	2a0e      	cmp	r2, #14
c0d025e4:	d83e      	bhi.n	c0d02664 <USBD_GetDescriptor+0x94>
c0d025e6:	46c0      	nop			; (mov r8, r8)
c0d025e8:	447a      	add	r2, pc
c0d025ea:	7912      	ldrb	r2, [r2, #4]
c0d025ec:	0052      	lsls	r2, r2, #1
c0d025ee:	4497      	add	pc, r2
c0d025f0:	390c2607 	.word	0x390c2607
c0d025f4:	39362e39 	.word	0x39362e39
c0d025f8:	39393939 	.word	0x39393939
c0d025fc:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02600:	2011      	movs	r0, #17
c0d02602:	0100      	lsls	r0, r0, #4
c0d02604:	5820      	ldr	r0, [r4, r0]
c0d02606:	6800      	ldr	r0, [r0, #0]
c0d02608:	e012      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d0260a:	b2c0      	uxtb	r0, r0
c0d0260c:	2805      	cmp	r0, #5
c0d0260e:	d829      	bhi.n	c0d02664 <USBD_GetDescriptor+0x94>
c0d02610:	4478      	add	r0, pc
c0d02612:	7900      	ldrb	r0, [r0, #4]
c0d02614:	0040      	lsls	r0, r0, #1
c0d02616:	4487      	add	pc, r0
c0d02618:	544f4a02 	.word	0x544f4a02
c0d0261c:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0261e:	2011      	movs	r0, #17
c0d02620:	0100      	lsls	r0, r0, #4
c0d02622:	5820      	ldr	r0, [r4, r0]
c0d02624:	6840      	ldr	r0, [r0, #4]
c0d02626:	e003      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02628:	2011      	movs	r0, #17
c0d0262a:	0100      	lsls	r0, r0, #4
c0d0262c:	5820      	ldr	r0, [r4, r0]
c0d0262e:	69c0      	ldr	r0, [r0, #28]
c0d02630:	f7ff f962 	bl	c0d018f8 <pic>
c0d02634:	4602      	mov	r2, r0
c0d02636:	7c20      	ldrb	r0, [r4, #16]
c0d02638:	a901      	add	r1, sp, #4
c0d0263a:	4790      	blx	r2
c0d0263c:	e025      	b.n	c0d0268a <USBD_GetDescriptor+0xba>
c0d0263e:	2045      	movs	r0, #69	; 0x45
c0d02640:	0080      	lsls	r0, r0, #2
c0d02642:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02644:	7c21      	ldrb	r1, [r4, #16]
c0d02646:	2900      	cmp	r1, #0
c0d02648:	d014      	beq.n	c0d02674 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d0264a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d0264c:	e018      	b.n	c0d02680 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0264e:	7c20      	ldrb	r0, [r4, #16]
c0d02650:	2800      	cmp	r0, #0
c0d02652:	d107      	bne.n	c0d02664 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02654:	2045      	movs	r0, #69	; 0x45
c0d02656:	0080      	lsls	r0, r0, #2
c0d02658:	5820      	ldr	r0, [r4, r0]
c0d0265a:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d0265c:	e010      	b.n	c0d02680 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0265e:	7c20      	ldrb	r0, [r4, #16]
c0d02660:	2800      	cmp	r0, #0
c0d02662:	d009      	beq.n	c0d02678 <USBD_GetDescriptor+0xa8>
c0d02664:	4620      	mov	r0, r4
c0d02666:	f7ff fd5d 	bl	c0d02124 <USBD_LL_StallEP>
c0d0266a:	2100      	movs	r1, #0
c0d0266c:	4620      	mov	r0, r4
c0d0266e:	f7ff fd59 	bl	c0d02124 <USBD_LL_StallEP>
c0d02672:	e01a      	b.n	c0d026aa <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02674:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02676:	e003      	b.n	c0d02680 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02678:	2045      	movs	r0, #69	; 0x45
c0d0267a:	0080      	lsls	r0, r0, #2
c0d0267c:	5820      	ldr	r0, [r4, r0]
c0d0267e:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02680:	f7ff f93a 	bl	c0d018f8 <pic>
c0d02684:	4601      	mov	r1, r0
c0d02686:	a801      	add	r0, sp, #4
c0d02688:	4788      	blx	r1
c0d0268a:	4601      	mov	r1, r0
c0d0268c:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0268e:	8802      	ldrh	r2, [r0, #0]
c0d02690:	2a00      	cmp	r2, #0
c0d02692:	d00a      	beq.n	c0d026aa <USBD_GetDescriptor+0xda>
c0d02694:	88e8      	ldrh	r0, [r5, #6]
c0d02696:	2800      	cmp	r0, #0
c0d02698:	d007      	beq.n	c0d026aa <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d0269a:	4282      	cmp	r2, r0
c0d0269c:	d300      	bcc.n	c0d026a0 <USBD_GetDescriptor+0xd0>
c0d0269e:	4602      	mov	r2, r0
c0d026a0:	a801      	add	r0, sp, #4
c0d026a2:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d026a4:	4620      	mov	r0, r4
c0d026a6:	f000 faf9 	bl	c0d02c9c <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d026aa:	b002      	add	sp, #8
c0d026ac:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d026ae:	2011      	movs	r0, #17
c0d026b0:	0100      	lsls	r0, r0, #4
c0d026b2:	5820      	ldr	r0, [r4, r0]
c0d026b4:	6880      	ldr	r0, [r0, #8]
c0d026b6:	e7bb      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d026b8:	2011      	movs	r0, #17
c0d026ba:	0100      	lsls	r0, r0, #4
c0d026bc:	5820      	ldr	r0, [r4, r0]
c0d026be:	68c0      	ldr	r0, [r0, #12]
c0d026c0:	e7b6      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d026c2:	2011      	movs	r0, #17
c0d026c4:	0100      	lsls	r0, r0, #4
c0d026c6:	5820      	ldr	r0, [r4, r0]
c0d026c8:	6900      	ldr	r0, [r0, #16]
c0d026ca:	e7b1      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d026cc:	2011      	movs	r0, #17
c0d026ce:	0100      	lsls	r0, r0, #4
c0d026d0:	5820      	ldr	r0, [r4, r0]
c0d026d2:	6940      	ldr	r0, [r0, #20]
c0d026d4:	e7ac      	b.n	c0d02630 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d026d6:	2011      	movs	r0, #17
c0d026d8:	0100      	lsls	r0, r0, #4
c0d026da:	5820      	ldr	r0, [r4, r0]
c0d026dc:	6980      	ldr	r0, [r0, #24]
c0d026de:	e7a7      	b.n	c0d02630 <USBD_GetDescriptor+0x60>

c0d026e0 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d026e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026e2:	af03      	add	r7, sp, #12
c0d026e4:	b081      	sub	sp, #4
c0d026e6:	460a      	mov	r2, r1
c0d026e8:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d026ea:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d026ec:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d026ee:	2800      	cmp	r0, #0
c0d026f0:	d10b      	bne.n	c0d0270a <USBD_SetAddress+0x2a>
c0d026f2:	88d0      	ldrh	r0, [r2, #6]
c0d026f4:	2800      	cmp	r0, #0
c0d026f6:	d108      	bne.n	c0d0270a <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d026f8:	8850      	ldrh	r0, [r2, #2]
c0d026fa:	267f      	movs	r6, #127	; 0x7f
c0d026fc:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d026fe:	20fc      	movs	r0, #252	; 0xfc
c0d02700:	5c20      	ldrb	r0, [r4, r0]
c0d02702:	4625      	mov	r5, r4
c0d02704:	35fc      	adds	r5, #252	; 0xfc
c0d02706:	2803      	cmp	r0, #3
c0d02708:	d108      	bne.n	c0d0271c <USBD_SetAddress+0x3c>
c0d0270a:	4620      	mov	r0, r4
c0d0270c:	f7ff fd0a 	bl	c0d02124 <USBD_LL_StallEP>
c0d02710:	2100      	movs	r1, #0
c0d02712:	4620      	mov	r0, r4
c0d02714:	f7ff fd06 	bl	c0d02124 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02718:	b001      	add	sp, #4
c0d0271a:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d0271c:	20fe      	movs	r0, #254	; 0xfe
c0d0271e:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02720:	b2f1      	uxtb	r1, r6
c0d02722:	4620      	mov	r0, r4
c0d02724:	f7ff fd5c 	bl	c0d021e0 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02728:	4620      	mov	r0, r4
c0d0272a:	f000 fae5 	bl	c0d02cf8 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d0272e:	2002      	movs	r0, #2
c0d02730:	2101      	movs	r1, #1
c0d02732:	2e00      	cmp	r6, #0
c0d02734:	d100      	bne.n	c0d02738 <USBD_SetAddress+0x58>
c0d02736:	4608      	mov	r0, r1
c0d02738:	7028      	strb	r0, [r5, #0]
c0d0273a:	e7ed      	b.n	c0d02718 <USBD_SetAddress+0x38>

c0d0273c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0273c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0273e:	af03      	add	r7, sp, #12
c0d02740:	b081      	sub	sp, #4
c0d02742:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02744:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02746:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02748:	2e02      	cmp	r6, #2
c0d0274a:	d21d      	bcs.n	c0d02788 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d0274c:	20fc      	movs	r0, #252	; 0xfc
c0d0274e:	5c21      	ldrb	r1, [r4, r0]
c0d02750:	4620      	mov	r0, r4
c0d02752:	30fc      	adds	r0, #252	; 0xfc
c0d02754:	2903      	cmp	r1, #3
c0d02756:	d007      	beq.n	c0d02768 <USBD_SetConfig+0x2c>
c0d02758:	2902      	cmp	r1, #2
c0d0275a:	d115      	bne.n	c0d02788 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d0275c:	2e00      	cmp	r6, #0
c0d0275e:	d026      	beq.n	c0d027ae <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02760:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02762:	2103      	movs	r1, #3
c0d02764:	7001      	strb	r1, [r0, #0]
c0d02766:	e009      	b.n	c0d0277c <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02768:	2e00      	cmp	r6, #0
c0d0276a:	d016      	beq.n	c0d0279a <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d0276c:	6860      	ldr	r0, [r4, #4]
c0d0276e:	4286      	cmp	r6, r0
c0d02770:	d01d      	beq.n	c0d027ae <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02772:	b2c1      	uxtb	r1, r0
c0d02774:	4620      	mov	r0, r4
c0d02776:	f7ff fdd3 	bl	c0d02320 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d0277a:	6066      	str	r6, [r4, #4]
c0d0277c:	4620      	mov	r0, r4
c0d0277e:	4631      	mov	r1, r6
c0d02780:	f7ff fdb6 	bl	c0d022f0 <USBD_SetClassConfig>
c0d02784:	2802      	cmp	r0, #2
c0d02786:	d112      	bne.n	c0d027ae <USBD_SetConfig+0x72>
c0d02788:	4620      	mov	r0, r4
c0d0278a:	4629      	mov	r1, r5
c0d0278c:	f7ff fcca 	bl	c0d02124 <USBD_LL_StallEP>
c0d02790:	2100      	movs	r1, #0
c0d02792:	4620      	mov	r0, r4
c0d02794:	f7ff fcc6 	bl	c0d02124 <USBD_LL_StallEP>
c0d02798:	e00c      	b.n	c0d027b4 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d0279a:	2102      	movs	r1, #2
c0d0279c:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d0279e:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d027a0:	4620      	mov	r0, r4
c0d027a2:	4631      	mov	r1, r6
c0d027a4:	f7ff fdbc 	bl	c0d02320 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d027a8:	4620      	mov	r0, r4
c0d027aa:	f000 faa5 	bl	c0d02cf8 <USBD_CtlSendStatus>
c0d027ae:	4620      	mov	r0, r4
c0d027b0:	f000 faa2 	bl	c0d02cf8 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d027b4:	b001      	add	sp, #4
c0d027b6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d027b8 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d027b8:	b5d0      	push	{r4, r6, r7, lr}
c0d027ba:	af02      	add	r7, sp, #8
c0d027bc:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d027be:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d027c0:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d027c2:	2801      	cmp	r0, #1
c0d027c4:	d10a      	bne.n	c0d027dc <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d027c6:	20fc      	movs	r0, #252	; 0xfc
c0d027c8:	5c20      	ldrb	r0, [r4, r0]
c0d027ca:	2803      	cmp	r0, #3
c0d027cc:	d00e      	beq.n	c0d027ec <USBD_GetConfig+0x34>
c0d027ce:	2802      	cmp	r0, #2
c0d027d0:	d104      	bne.n	c0d027dc <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d027d2:	2000      	movs	r0, #0
c0d027d4:	60a0      	str	r0, [r4, #8]
c0d027d6:	4621      	mov	r1, r4
c0d027d8:	3108      	adds	r1, #8
c0d027da:	e008      	b.n	c0d027ee <USBD_GetConfig+0x36>
c0d027dc:	4620      	mov	r0, r4
c0d027de:	f7ff fca1 	bl	c0d02124 <USBD_LL_StallEP>
c0d027e2:	2100      	movs	r1, #0
c0d027e4:	4620      	mov	r0, r4
c0d027e6:	f7ff fc9d 	bl	c0d02124 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d027ea:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d027ec:	1d21      	adds	r1, r4, #4
c0d027ee:	2201      	movs	r2, #1
c0d027f0:	4620      	mov	r0, r4
c0d027f2:	f000 fa53 	bl	c0d02c9c <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d027f6:	bdd0      	pop	{r4, r6, r7, pc}

c0d027f8 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d027f8:	b5b0      	push	{r4, r5, r7, lr}
c0d027fa:	af02      	add	r7, sp, #8
c0d027fc:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d027fe:	20fc      	movs	r0, #252	; 0xfc
c0d02800:	5c20      	ldrb	r0, [r4, r0]
c0d02802:	21fe      	movs	r1, #254	; 0xfe
c0d02804:	4001      	ands	r1, r0
c0d02806:	2902      	cmp	r1, #2
c0d02808:	d116      	bne.n	c0d02838 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0280a:	2001      	movs	r0, #1
c0d0280c:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0280e:	2041      	movs	r0, #65	; 0x41
c0d02810:	0080      	lsls	r0, r0, #2
c0d02812:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02814:	4625      	mov	r5, r4
c0d02816:	350c      	adds	r5, #12
c0d02818:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0281a:	2900      	cmp	r1, #0
c0d0281c:	d005      	beq.n	c0d0282a <USBD_GetStatus+0x32>
c0d0281e:	4620      	mov	r0, r4
c0d02820:	f000 fa77 	bl	c0d02d12 <USBD_CtlReceiveStatus>
c0d02824:	68e1      	ldr	r1, [r4, #12]
c0d02826:	2002      	movs	r0, #2
c0d02828:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0282a:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d0282c:	2202      	movs	r2, #2
c0d0282e:	4620      	mov	r0, r4
c0d02830:	4629      	mov	r1, r5
c0d02832:	f000 fa33 	bl	c0d02c9c <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02836:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02838:	2180      	movs	r1, #128	; 0x80
c0d0283a:	4620      	mov	r0, r4
c0d0283c:	f7ff fc72 	bl	c0d02124 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02840:	2100      	movs	r1, #0
c0d02842:	4620      	mov	r0, r4
c0d02844:	f7ff fc6e 	bl	c0d02124 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02848:	bdb0      	pop	{r4, r5, r7, pc}

c0d0284a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0284a:	b5b0      	push	{r4, r5, r7, lr}
c0d0284c:	af02      	add	r7, sp, #8
c0d0284e:	460d      	mov	r5, r1
c0d02850:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02852:	8868      	ldrh	r0, [r5, #2]
c0d02854:	2801      	cmp	r0, #1
c0d02856:	d110      	bne.n	c0d0287a <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02858:	2041      	movs	r0, #65	; 0x41
c0d0285a:	0080      	lsls	r0, r0, #2
c0d0285c:	2101      	movs	r1, #1
c0d0285e:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02860:	2045      	movs	r0, #69	; 0x45
c0d02862:	0080      	lsls	r0, r0, #2
c0d02864:	5820      	ldr	r0, [r4, r0]
c0d02866:	6880      	ldr	r0, [r0, #8]
c0d02868:	f7ff f846 	bl	c0d018f8 <pic>
c0d0286c:	4602      	mov	r2, r0
c0d0286e:	4620      	mov	r0, r4
c0d02870:	4629      	mov	r1, r5
c0d02872:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02874:	4620      	mov	r0, r4
c0d02876:	f000 fa3f 	bl	c0d02cf8 <USBD_CtlSendStatus>
  }

}
c0d0287a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0287c <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0287c:	b5b0      	push	{r4, r5, r7, lr}
c0d0287e:	af02      	add	r7, sp, #8
c0d02880:	460d      	mov	r5, r1
c0d02882:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02884:	20fc      	movs	r0, #252	; 0xfc
c0d02886:	5c20      	ldrb	r0, [r4, r0]
c0d02888:	21fe      	movs	r1, #254	; 0xfe
c0d0288a:	4001      	ands	r1, r0
c0d0288c:	2902      	cmp	r1, #2
c0d0288e:	d114      	bne.n	c0d028ba <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02890:	8868      	ldrh	r0, [r5, #2]
c0d02892:	2801      	cmp	r0, #1
c0d02894:	d119      	bne.n	c0d028ca <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02896:	2041      	movs	r0, #65	; 0x41
c0d02898:	0080      	lsls	r0, r0, #2
c0d0289a:	2100      	movs	r1, #0
c0d0289c:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0289e:	2045      	movs	r0, #69	; 0x45
c0d028a0:	0080      	lsls	r0, r0, #2
c0d028a2:	5820      	ldr	r0, [r4, r0]
c0d028a4:	6880      	ldr	r0, [r0, #8]
c0d028a6:	f7ff f827 	bl	c0d018f8 <pic>
c0d028aa:	4602      	mov	r2, r0
c0d028ac:	4620      	mov	r0, r4
c0d028ae:	4629      	mov	r1, r5
c0d028b0:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d028b2:	4620      	mov	r0, r4
c0d028b4:	f000 fa20 	bl	c0d02cf8 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d028b8:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028ba:	2180      	movs	r1, #128	; 0x80
c0d028bc:	4620      	mov	r0, r4
c0d028be:	f7ff fc31 	bl	c0d02124 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d028c2:	2100      	movs	r1, #0
c0d028c4:	4620      	mov	r0, r4
c0d028c6:	f7ff fc2d 	bl	c0d02124 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d028ca:	bdb0      	pop	{r4, r5, r7, pc}

c0d028cc <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d028cc:	b5d0      	push	{r4, r6, r7, lr}
c0d028ce:	af02      	add	r7, sp, #8
c0d028d0:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028d2:	2180      	movs	r1, #128	; 0x80
c0d028d4:	f7ff fc26 	bl	c0d02124 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d028d8:	2100      	movs	r1, #0
c0d028da:	4620      	mov	r0, r4
c0d028dc:	f7ff fc22 	bl	c0d02124 <USBD_LL_StallEP>
}
c0d028e0:	bdd0      	pop	{r4, r6, r7, pc}

c0d028e2 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d028e2:	b5b0      	push	{r4, r5, r7, lr}
c0d028e4:	af02      	add	r7, sp, #8
c0d028e6:	460d      	mov	r5, r1
c0d028e8:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d028ea:	20fc      	movs	r0, #252	; 0xfc
c0d028ec:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028ee:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d028f0:	2803      	cmp	r0, #3
c0d028f2:	d115      	bne.n	c0d02920 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d028f4:	88a8      	ldrh	r0, [r5, #4]
c0d028f6:	22fe      	movs	r2, #254	; 0xfe
c0d028f8:	4002      	ands	r2, r0
c0d028fa:	2a01      	cmp	r2, #1
c0d028fc:	d810      	bhi.n	c0d02920 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d028fe:	2045      	movs	r0, #69	; 0x45
c0d02900:	0080      	lsls	r0, r0, #2
c0d02902:	5820      	ldr	r0, [r4, r0]
c0d02904:	6880      	ldr	r0, [r0, #8]
c0d02906:	f7fe fff7 	bl	c0d018f8 <pic>
c0d0290a:	4602      	mov	r2, r0
c0d0290c:	4620      	mov	r0, r4
c0d0290e:	4629      	mov	r1, r5
c0d02910:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02912:	88e8      	ldrh	r0, [r5, #6]
c0d02914:	2800      	cmp	r0, #0
c0d02916:	d10a      	bne.n	c0d0292e <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02918:	4620      	mov	r0, r4
c0d0291a:	f000 f9ed 	bl	c0d02cf8 <USBD_CtlSendStatus>
c0d0291e:	e006      	b.n	c0d0292e <USBD_StdItfReq+0x4c>
c0d02920:	4620      	mov	r0, r4
c0d02922:	f7ff fbff 	bl	c0d02124 <USBD_LL_StallEP>
c0d02926:	2100      	movs	r1, #0
c0d02928:	4620      	mov	r0, r4
c0d0292a:	f7ff fbfb 	bl	c0d02124 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0292e:	2000      	movs	r0, #0
c0d02930:	bdb0      	pop	{r4, r5, r7, pc}

c0d02932 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02932:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02934:	af03      	add	r7, sp, #12
c0d02936:	b081      	sub	sp, #4
c0d02938:	460e      	mov	r6, r1
c0d0293a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d0293c:	7830      	ldrb	r0, [r6, #0]
c0d0293e:	2160      	movs	r1, #96	; 0x60
c0d02940:	4001      	ands	r1, r0
c0d02942:	2920      	cmp	r1, #32
c0d02944:	d10a      	bne.n	c0d0295c <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02946:	2045      	movs	r0, #69	; 0x45
c0d02948:	0080      	lsls	r0, r0, #2
c0d0294a:	5820      	ldr	r0, [r4, r0]
c0d0294c:	6880      	ldr	r0, [r0, #8]
c0d0294e:	f7fe ffd3 	bl	c0d018f8 <pic>
c0d02952:	4602      	mov	r2, r0
c0d02954:	4620      	mov	r0, r4
c0d02956:	4631      	mov	r1, r6
c0d02958:	4790      	blx	r2
c0d0295a:	e063      	b.n	c0d02a24 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d0295c:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0295e:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02960:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02962:	2800      	cmp	r0, #0
c0d02964:	d012      	beq.n	c0d0298c <USBD_StdEPReq+0x5a>
c0d02966:	2801      	cmp	r0, #1
c0d02968:	d019      	beq.n	c0d0299e <USBD_StdEPReq+0x6c>
c0d0296a:	2803      	cmp	r0, #3
c0d0296c:	d15a      	bne.n	c0d02a24 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0296e:	20fc      	movs	r0, #252	; 0xfc
c0d02970:	5c20      	ldrb	r0, [r4, r0]
c0d02972:	2803      	cmp	r0, #3
c0d02974:	d117      	bne.n	c0d029a6 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02976:	8870      	ldrh	r0, [r6, #2]
c0d02978:	2800      	cmp	r0, #0
c0d0297a:	d12d      	bne.n	c0d029d8 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d0297c:	4329      	orrs	r1, r5
c0d0297e:	2980      	cmp	r1, #128	; 0x80
c0d02980:	d02a      	beq.n	c0d029d8 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02982:	4620      	mov	r0, r4
c0d02984:	4629      	mov	r1, r5
c0d02986:	f7ff fbcd 	bl	c0d02124 <USBD_LL_StallEP>
c0d0298a:	e025      	b.n	c0d029d8 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d0298c:	20fc      	movs	r0, #252	; 0xfc
c0d0298e:	5c20      	ldrb	r0, [r4, r0]
c0d02990:	2803      	cmp	r0, #3
c0d02992:	d02f      	beq.n	c0d029f4 <USBD_StdEPReq+0xc2>
c0d02994:	2802      	cmp	r0, #2
c0d02996:	d10e      	bne.n	c0d029b6 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02998:	0668      	lsls	r0, r5, #25
c0d0299a:	d109      	bne.n	c0d029b0 <USBD_StdEPReq+0x7e>
c0d0299c:	e042      	b.n	c0d02a24 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0299e:	20fc      	movs	r0, #252	; 0xfc
c0d029a0:	5c20      	ldrb	r0, [r4, r0]
c0d029a2:	2803      	cmp	r0, #3
c0d029a4:	d00f      	beq.n	c0d029c6 <USBD_StdEPReq+0x94>
c0d029a6:	2802      	cmp	r0, #2
c0d029a8:	d105      	bne.n	c0d029b6 <USBD_StdEPReq+0x84>
c0d029aa:	4329      	orrs	r1, r5
c0d029ac:	2980      	cmp	r1, #128	; 0x80
c0d029ae:	d039      	beq.n	c0d02a24 <USBD_StdEPReq+0xf2>
c0d029b0:	4620      	mov	r0, r4
c0d029b2:	4629      	mov	r1, r5
c0d029b4:	e004      	b.n	c0d029c0 <USBD_StdEPReq+0x8e>
c0d029b6:	4620      	mov	r0, r4
c0d029b8:	f7ff fbb4 	bl	c0d02124 <USBD_LL_StallEP>
c0d029bc:	2100      	movs	r1, #0
c0d029be:	4620      	mov	r0, r4
c0d029c0:	f7ff fbb0 	bl	c0d02124 <USBD_LL_StallEP>
c0d029c4:	e02e      	b.n	c0d02a24 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d029c6:	8870      	ldrh	r0, [r6, #2]
c0d029c8:	2800      	cmp	r0, #0
c0d029ca:	d12b      	bne.n	c0d02a24 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d029cc:	0668      	lsls	r0, r5, #25
c0d029ce:	d00d      	beq.n	c0d029ec <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d029d0:	4620      	mov	r0, r4
c0d029d2:	4629      	mov	r1, r5
c0d029d4:	f7ff fbcc 	bl	c0d02170 <USBD_LL_ClearStallEP>
c0d029d8:	2045      	movs	r0, #69	; 0x45
c0d029da:	0080      	lsls	r0, r0, #2
c0d029dc:	5820      	ldr	r0, [r4, r0]
c0d029de:	6880      	ldr	r0, [r0, #8]
c0d029e0:	f7fe ff8a 	bl	c0d018f8 <pic>
c0d029e4:	4602      	mov	r2, r0
c0d029e6:	4620      	mov	r0, r4
c0d029e8:	4631      	mov	r1, r6
c0d029ea:	4790      	blx	r2
c0d029ec:	4620      	mov	r0, r4
c0d029ee:	f000 f983 	bl	c0d02cf8 <USBD_CtlSendStatus>
c0d029f2:	e017      	b.n	c0d02a24 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d029f4:	4626      	mov	r6, r4
c0d029f6:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d029f8:	4620      	mov	r0, r4
c0d029fa:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d029fc:	420d      	tst	r5, r1
c0d029fe:	d100      	bne.n	c0d02a02 <USBD_StdEPReq+0xd0>
c0d02a00:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02a02:	4620      	mov	r0, r4
c0d02a04:	4629      	mov	r1, r5
c0d02a06:	f7ff fbd9 	bl	c0d021bc <USBD_LL_IsStallEP>
c0d02a0a:	2101      	movs	r1, #1
c0d02a0c:	2800      	cmp	r0, #0
c0d02a0e:	d100      	bne.n	c0d02a12 <USBD_StdEPReq+0xe0>
c0d02a10:	4601      	mov	r1, r0
c0d02a12:	207f      	movs	r0, #127	; 0x7f
c0d02a14:	4005      	ands	r5, r0
c0d02a16:	0128      	lsls	r0, r5, #4
c0d02a18:	5031      	str	r1, [r6, r0]
c0d02a1a:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02a1c:	2202      	movs	r2, #2
c0d02a1e:	4620      	mov	r0, r4
c0d02a20:	f000 f93c 	bl	c0d02c9c <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02a24:	2000      	movs	r0, #0
c0d02a26:	b001      	add	sp, #4
c0d02a28:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a2a <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02a2a:	780a      	ldrb	r2, [r1, #0]
c0d02a2c:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02a2e:	784a      	ldrb	r2, [r1, #1]
c0d02a30:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02a32:	788a      	ldrb	r2, [r1, #2]
c0d02a34:	78cb      	ldrb	r3, [r1, #3]
c0d02a36:	021b      	lsls	r3, r3, #8
c0d02a38:	4313      	orrs	r3, r2
c0d02a3a:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02a3c:	790a      	ldrb	r2, [r1, #4]
c0d02a3e:	794b      	ldrb	r3, [r1, #5]
c0d02a40:	021b      	lsls	r3, r3, #8
c0d02a42:	4313      	orrs	r3, r2
c0d02a44:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02a46:	798a      	ldrb	r2, [r1, #6]
c0d02a48:	79c9      	ldrb	r1, [r1, #7]
c0d02a4a:	0209      	lsls	r1, r1, #8
c0d02a4c:	4311      	orrs	r1, r2
c0d02a4e:	80c1      	strh	r1, [r0, #6]

}
c0d02a50:	4770      	bx	lr

c0d02a52 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02a52:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a54:	af03      	add	r7, sp, #12
c0d02a56:	b083      	sub	sp, #12
c0d02a58:	460d      	mov	r5, r1
c0d02a5a:	4604      	mov	r4, r0
c0d02a5c:	a802      	add	r0, sp, #8
c0d02a5e:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02a60:	8006      	strh	r6, [r0, #0]
c0d02a62:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02a64:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02a66:	7829      	ldrb	r1, [r5, #0]
c0d02a68:	2060      	movs	r0, #96	; 0x60
c0d02a6a:	4008      	ands	r0, r1
c0d02a6c:	2800      	cmp	r0, #0
c0d02a6e:	d010      	beq.n	c0d02a92 <USBD_HID_Setup+0x40>
c0d02a70:	2820      	cmp	r0, #32
c0d02a72:	d139      	bne.n	c0d02ae8 <USBD_HID_Setup+0x96>
c0d02a74:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02a76:	4601      	mov	r1, r0
c0d02a78:	390a      	subs	r1, #10
c0d02a7a:	2902      	cmp	r1, #2
c0d02a7c:	d334      	bcc.n	c0d02ae8 <USBD_HID_Setup+0x96>
c0d02a7e:	2802      	cmp	r0, #2
c0d02a80:	d01c      	beq.n	c0d02abc <USBD_HID_Setup+0x6a>
c0d02a82:	2803      	cmp	r0, #3
c0d02a84:	d01a      	beq.n	c0d02abc <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02a86:	4620      	mov	r0, r4
c0d02a88:	4629      	mov	r1, r5
c0d02a8a:	f7ff ff1f 	bl	c0d028cc <USBD_CtlError>
c0d02a8e:	2602      	movs	r6, #2
c0d02a90:	e02a      	b.n	c0d02ae8 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02a92:	7868      	ldrb	r0, [r5, #1]
c0d02a94:	280b      	cmp	r0, #11
c0d02a96:	d014      	beq.n	c0d02ac2 <USBD_HID_Setup+0x70>
c0d02a98:	280a      	cmp	r0, #10
c0d02a9a:	d00f      	beq.n	c0d02abc <USBD_HID_Setup+0x6a>
c0d02a9c:	2806      	cmp	r0, #6
c0d02a9e:	d123      	bne.n	c0d02ae8 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02aa0:	8868      	ldrh	r0, [r5, #2]
c0d02aa2:	0a00      	lsrs	r0, r0, #8
c0d02aa4:	2600      	movs	r6, #0
c0d02aa6:	2821      	cmp	r0, #33	; 0x21
c0d02aa8:	d00f      	beq.n	c0d02aca <USBD_HID_Setup+0x78>
c0d02aaa:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02aac:	4632      	mov	r2, r6
c0d02aae:	4631      	mov	r1, r6
c0d02ab0:	d117      	bne.n	c0d02ae2 <USBD_HID_Setup+0x90>
c0d02ab2:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02ab4:	9000      	str	r0, [sp, #0]
c0d02ab6:	f000 f847 	bl	c0d02b48 <USBD_HID_GetReportDescriptor_impl>
c0d02aba:	e00a      	b.n	c0d02ad2 <USBD_HID_Setup+0x80>
c0d02abc:	a901      	add	r1, sp, #4
c0d02abe:	2201      	movs	r2, #1
c0d02ac0:	e00f      	b.n	c0d02ae2 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02ac2:	4620      	mov	r0, r4
c0d02ac4:	f000 f918 	bl	c0d02cf8 <USBD_CtlSendStatus>
c0d02ac8:	e00e      	b.n	c0d02ae8 <USBD_HID_Setup+0x96>
c0d02aca:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02acc:	9000      	str	r0, [sp, #0]
c0d02ace:	f000 f833 	bl	c0d02b38 <USBD_HID_GetHidDescriptor_impl>
c0d02ad2:	9b00      	ldr	r3, [sp, #0]
c0d02ad4:	4601      	mov	r1, r0
c0d02ad6:	881a      	ldrh	r2, [r3, #0]
c0d02ad8:	88e8      	ldrh	r0, [r5, #6]
c0d02ada:	4282      	cmp	r2, r0
c0d02adc:	d300      	bcc.n	c0d02ae0 <USBD_HID_Setup+0x8e>
c0d02ade:	4602      	mov	r2, r0
c0d02ae0:	801a      	strh	r2, [r3, #0]
c0d02ae2:	4620      	mov	r0, r4
c0d02ae4:	f000 f8da 	bl	c0d02c9c <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02ae8:	b2f0      	uxtb	r0, r6
c0d02aea:	b003      	add	sp, #12
c0d02aec:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02aee <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02aee:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02af0:	af03      	add	r7, sp, #12
c0d02af2:	b081      	sub	sp, #4
c0d02af4:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02af6:	2182      	movs	r1, #130	; 0x82
c0d02af8:	2502      	movs	r5, #2
c0d02afa:	2640      	movs	r6, #64	; 0x40
c0d02afc:	462a      	mov	r2, r5
c0d02afe:	4633      	mov	r3, r6
c0d02b00:	f7ff fad0 	bl	c0d020a4 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02b04:	4620      	mov	r0, r4
c0d02b06:	4629      	mov	r1, r5
c0d02b08:	462a      	mov	r2, r5
c0d02b0a:	4633      	mov	r3, r6
c0d02b0c:	f7ff faca 	bl	c0d020a4 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02b10:	4620      	mov	r0, r4
c0d02b12:	4629      	mov	r1, r5
c0d02b14:	4632      	mov	r2, r6
c0d02b16:	f7ff fb90 	bl	c0d0223a <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02b1a:	2000      	movs	r0, #0
c0d02b1c:	b001      	add	sp, #4
c0d02b1e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b20 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02b20:	b5d0      	push	{r4, r6, r7, lr}
c0d02b22:	af02      	add	r7, sp, #8
c0d02b24:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02b26:	2182      	movs	r1, #130	; 0x82
c0d02b28:	f7ff fae4 	bl	c0d020f4 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02b2c:	2102      	movs	r1, #2
c0d02b2e:	4620      	mov	r0, r4
c0d02b30:	f7ff fae0 	bl	c0d020f4 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02b34:	2000      	movs	r0, #0
c0d02b36:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b38 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02b38:	2109      	movs	r1, #9
c0d02b3a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02b3c:	4801      	ldr	r0, [pc, #4]	; (c0d02b44 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02b3e:	4478      	add	r0, pc
c0d02b40:	4770      	bx	lr
c0d02b42:	46c0      	nop			; (mov r8, r8)
c0d02b44:	00000a82 	.word	0x00000a82

c0d02b48 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02b48:	2122      	movs	r1, #34	; 0x22
c0d02b4a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02b4c:	4801      	ldr	r0, [pc, #4]	; (c0d02b54 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02b4e:	4478      	add	r0, pc
c0d02b50:	4770      	bx	lr
c0d02b52:	46c0      	nop			; (mov r8, r8)
c0d02b54:	00000a4d 	.word	0x00000a4d

c0d02b58 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02b58:	b5b0      	push	{r4, r5, r7, lr}
c0d02b5a:	af02      	add	r7, sp, #8
c0d02b5c:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02b5e:	2102      	movs	r1, #2
c0d02b60:	2240      	movs	r2, #64	; 0x40
c0d02b62:	f7ff fb6a 	bl	c0d0223a <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02b66:	4d0d      	ldr	r5, [pc, #52]	; (c0d02b9c <USBD_HID_DataOut_impl+0x44>)
c0d02b68:	7828      	ldrb	r0, [r5, #0]
c0d02b6a:	2800      	cmp	r0, #0
c0d02b6c:	d113      	bne.n	c0d02b96 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02b6e:	2002      	movs	r0, #2
c0d02b70:	f7fe f928 	bl	c0d00dc4 <io_seproxyhal_get_ep_rx_size>
c0d02b74:	4602      	mov	r2, r0
c0d02b76:	480d      	ldr	r0, [pc, #52]	; (c0d02bac <USBD_HID_DataOut_impl+0x54>)
c0d02b78:	4478      	add	r0, pc
c0d02b7a:	4621      	mov	r1, r4
c0d02b7c:	f7fd ff86 	bl	c0d00a8c <io_usb_hid_receive>
c0d02b80:	2802      	cmp	r0, #2
c0d02b82:	d108      	bne.n	c0d02b96 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02b84:	2001      	movs	r0, #1
c0d02b86:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02b88:	4805      	ldr	r0, [pc, #20]	; (c0d02ba0 <USBD_HID_DataOut_impl+0x48>)
c0d02b8a:	2107      	movs	r1, #7
c0d02b8c:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02b8e:	4805      	ldr	r0, [pc, #20]	; (c0d02ba4 <USBD_HID_DataOut_impl+0x4c>)
c0d02b90:	6800      	ldr	r0, [r0, #0]
c0d02b92:	4905      	ldr	r1, [pc, #20]	; (c0d02ba8 <USBD_HID_DataOut_impl+0x50>)
c0d02b94:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02b96:	2000      	movs	r0, #0
c0d02b98:	bdb0      	pop	{r4, r5, r7, pc}
c0d02b9a:	46c0      	nop			; (mov r8, r8)
c0d02b9c:	20001d10 	.word	0x20001d10
c0d02ba0:	20001d18 	.word	0x20001d18
c0d02ba4:	20001c00 	.word	0x20001c00
c0d02ba8:	20001d1c 	.word	0x20001d1c
c0d02bac:	ffffe3a1 	.word	0xffffe3a1

c0d02bb0 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02bb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02bb2:	af03      	add	r7, sp, #12
c0d02bb4:	b081      	sub	sp, #4
c0d02bb6:	4604      	mov	r4, r0
c0d02bb8:	2049      	movs	r0, #73	; 0x49
c0d02bba:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02bbc:	4810      	ldr	r0, [pc, #64]	; (c0d02c00 <USB_power+0x50>)
c0d02bbe:	2100      	movs	r1, #0
c0d02bc0:	462a      	mov	r2, r5
c0d02bc2:	f7fe f80f 	bl	c0d00be4 <os_memset>

  if (enabled) {
c0d02bc6:	2c00      	cmp	r4, #0
c0d02bc8:	d015      	beq.n	c0d02bf6 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02bca:	4c0d      	ldr	r4, [pc, #52]	; (c0d02c00 <USB_power+0x50>)
c0d02bcc:	2600      	movs	r6, #0
c0d02bce:	4620      	mov	r0, r4
c0d02bd0:	4631      	mov	r1, r6
c0d02bd2:	462a      	mov	r2, r5
c0d02bd4:	f7fe f806 	bl	c0d00be4 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02bd8:	490a      	ldr	r1, [pc, #40]	; (c0d02c04 <USB_power+0x54>)
c0d02bda:	4479      	add	r1, pc
c0d02bdc:	4620      	mov	r0, r4
c0d02bde:	4632      	mov	r2, r6
c0d02be0:	f7ff fb3f 	bl	c0d02262 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02be4:	4908      	ldr	r1, [pc, #32]	; (c0d02c08 <USB_power+0x58>)
c0d02be6:	4479      	add	r1, pc
c0d02be8:	4620      	mov	r0, r4
c0d02bea:	f7ff fb72 	bl	c0d022d2 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02bee:	4620      	mov	r0, r4
c0d02bf0:	f7ff fb78 	bl	c0d022e4 <USBD_Start>
c0d02bf4:	e002      	b.n	c0d02bfc <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02bf6:	4802      	ldr	r0, [pc, #8]	; (c0d02c00 <USB_power+0x50>)
c0d02bf8:	f7ff fb51 	bl	c0d0229e <USBD_DeInit>
  }
}
c0d02bfc:	b001      	add	sp, #4
c0d02bfe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02c00:	20001d34 	.word	0x20001d34
c0d02c04:	00000a02 	.word	0x00000a02
c0d02c08:	00000a32 	.word	0x00000a32

c0d02c0c <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02c0c:	2012      	movs	r0, #18
c0d02c0e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02c10:	4801      	ldr	r0, [pc, #4]	; (c0d02c18 <USBD_DeviceDescriptor+0xc>)
c0d02c12:	4478      	add	r0, pc
c0d02c14:	4770      	bx	lr
c0d02c16:	46c0      	nop			; (mov r8, r8)
c0d02c18:	000009b7 	.word	0x000009b7

c0d02c1c <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02c1c:	2004      	movs	r0, #4
c0d02c1e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02c20:	4801      	ldr	r0, [pc, #4]	; (c0d02c28 <USBD_LangIDStrDescriptor+0xc>)
c0d02c22:	4478      	add	r0, pc
c0d02c24:	4770      	bx	lr
c0d02c26:	46c0      	nop			; (mov r8, r8)
c0d02c28:	000009da 	.word	0x000009da

c0d02c2c <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02c2c:	200e      	movs	r0, #14
c0d02c2e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02c30:	4801      	ldr	r0, [pc, #4]	; (c0d02c38 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02c32:	4478      	add	r0, pc
c0d02c34:	4770      	bx	lr
c0d02c36:	46c0      	nop			; (mov r8, r8)
c0d02c38:	000009ce 	.word	0x000009ce

c0d02c3c <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02c3c:	200e      	movs	r0, #14
c0d02c3e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02c40:	4801      	ldr	r0, [pc, #4]	; (c0d02c48 <USBD_ProductStrDescriptor+0xc>)
c0d02c42:	4478      	add	r0, pc
c0d02c44:	4770      	bx	lr
c0d02c46:	46c0      	nop			; (mov r8, r8)
c0d02c48:	0000094b 	.word	0x0000094b

c0d02c4c <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02c4c:	200a      	movs	r0, #10
c0d02c4e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02c50:	4801      	ldr	r0, [pc, #4]	; (c0d02c58 <USBD_SerialStrDescriptor+0xc>)
c0d02c52:	4478      	add	r0, pc
c0d02c54:	4770      	bx	lr
c0d02c56:	46c0      	nop			; (mov r8, r8)
c0d02c58:	000009bc 	.word	0x000009bc

c0d02c5c <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02c5c:	200e      	movs	r0, #14
c0d02c5e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02c60:	4801      	ldr	r0, [pc, #4]	; (c0d02c68 <USBD_ConfigStrDescriptor+0xc>)
c0d02c62:	4478      	add	r0, pc
c0d02c64:	4770      	bx	lr
c0d02c66:	46c0      	nop			; (mov r8, r8)
c0d02c68:	0000092b 	.word	0x0000092b

c0d02c6c <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02c6c:	200e      	movs	r0, #14
c0d02c6e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02c70:	4801      	ldr	r0, [pc, #4]	; (c0d02c78 <USBD_InterfaceStrDescriptor+0xc>)
c0d02c72:	4478      	add	r0, pc
c0d02c74:	4770      	bx	lr
c0d02c76:	46c0      	nop			; (mov r8, r8)
c0d02c78:	0000091b 	.word	0x0000091b

c0d02c7c <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02c7c:	2129      	movs	r1, #41	; 0x29
c0d02c7e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02c80:	4801      	ldr	r0, [pc, #4]	; (c0d02c88 <USBD_GetCfgDesc_impl+0xc>)
c0d02c82:	4478      	add	r0, pc
c0d02c84:	4770      	bx	lr
c0d02c86:	46c0      	nop			; (mov r8, r8)
c0d02c88:	000009ce 	.word	0x000009ce

c0d02c8c <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02c8c:	210a      	movs	r1, #10
c0d02c8e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02c90:	4801      	ldr	r0, [pc, #4]	; (c0d02c98 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02c92:	4478      	add	r0, pc
c0d02c94:	4770      	bx	lr
c0d02c96:	46c0      	nop			; (mov r8, r8)
c0d02c98:	000009ea 	.word	0x000009ea

c0d02c9c <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02c9c:	b5b0      	push	{r4, r5, r7, lr}
c0d02c9e:	af02      	add	r7, sp, #8
c0d02ca0:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02ca2:	21f4      	movs	r1, #244	; 0xf4
c0d02ca4:	2302      	movs	r3, #2
c0d02ca6:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02ca8:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02caa:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02cac:	2109      	movs	r1, #9
c0d02cae:	0149      	lsls	r1, r1, #5
c0d02cb0:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02cb2:	6a01      	ldr	r1, [r0, #32]
c0d02cb4:	428a      	cmp	r2, r1
c0d02cb6:	d300      	bcc.n	c0d02cba <USBD_CtlSendData+0x1e>
c0d02cb8:	460a      	mov	r2, r1
c0d02cba:	b293      	uxth	r3, r2
c0d02cbc:	2500      	movs	r5, #0
c0d02cbe:	4629      	mov	r1, r5
c0d02cc0:	4622      	mov	r2, r4
c0d02cc2:	f7ff faa0 	bl	c0d02206 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02cc6:	4628      	mov	r0, r5
c0d02cc8:	bdb0      	pop	{r4, r5, r7, pc}

c0d02cca <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02cca:	b5b0      	push	{r4, r5, r7, lr}
c0d02ccc:	af02      	add	r7, sp, #8
c0d02cce:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02cd0:	6a01      	ldr	r1, [r0, #32]
c0d02cd2:	428a      	cmp	r2, r1
c0d02cd4:	d300      	bcc.n	c0d02cd8 <USBD_CtlContinueSendData+0xe>
c0d02cd6:	460a      	mov	r2, r1
c0d02cd8:	b293      	uxth	r3, r2
c0d02cda:	2500      	movs	r5, #0
c0d02cdc:	4629      	mov	r1, r5
c0d02cde:	4622      	mov	r2, r4
c0d02ce0:	f7ff fa91 	bl	c0d02206 <USBD_LL_Transmit>
  return USBD_OK;
c0d02ce4:	4628      	mov	r0, r5
c0d02ce6:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ce8 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02ce8:	b5d0      	push	{r4, r6, r7, lr}
c0d02cea:	af02      	add	r7, sp, #8
c0d02cec:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02cee:	4621      	mov	r1, r4
c0d02cf0:	f7ff faa3 	bl	c0d0223a <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02cf4:	4620      	mov	r0, r4
c0d02cf6:	bdd0      	pop	{r4, r6, r7, pc}

c0d02cf8 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02cf8:	b5d0      	push	{r4, r6, r7, lr}
c0d02cfa:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02cfc:	21f4      	movs	r1, #244	; 0xf4
c0d02cfe:	2204      	movs	r2, #4
c0d02d00:	5042      	str	r2, [r0, r1]
c0d02d02:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02d04:	4621      	mov	r1, r4
c0d02d06:	4622      	mov	r2, r4
c0d02d08:	4623      	mov	r3, r4
c0d02d0a:	f7ff fa7c 	bl	c0d02206 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02d0e:	4620      	mov	r0, r4
c0d02d10:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d12 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02d12:	b5d0      	push	{r4, r6, r7, lr}
c0d02d14:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02d16:	21f4      	movs	r1, #244	; 0xf4
c0d02d18:	2205      	movs	r2, #5
c0d02d1a:	5042      	str	r2, [r0, r1]
c0d02d1c:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02d1e:	4621      	mov	r1, r4
c0d02d20:	4622      	mov	r2, r4
c0d02d22:	f7ff fa8a 	bl	c0d0223a <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02d26:	4620      	mov	r0, r4
c0d02d28:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d2c <__aeabi_uidiv>:
c0d02d2c:	2200      	movs	r2, #0
c0d02d2e:	0843      	lsrs	r3, r0, #1
c0d02d30:	428b      	cmp	r3, r1
c0d02d32:	d374      	bcc.n	c0d02e1e <__aeabi_uidiv+0xf2>
c0d02d34:	0903      	lsrs	r3, r0, #4
c0d02d36:	428b      	cmp	r3, r1
c0d02d38:	d35f      	bcc.n	c0d02dfa <__aeabi_uidiv+0xce>
c0d02d3a:	0a03      	lsrs	r3, r0, #8
c0d02d3c:	428b      	cmp	r3, r1
c0d02d3e:	d344      	bcc.n	c0d02dca <__aeabi_uidiv+0x9e>
c0d02d40:	0b03      	lsrs	r3, r0, #12
c0d02d42:	428b      	cmp	r3, r1
c0d02d44:	d328      	bcc.n	c0d02d98 <__aeabi_uidiv+0x6c>
c0d02d46:	0c03      	lsrs	r3, r0, #16
c0d02d48:	428b      	cmp	r3, r1
c0d02d4a:	d30d      	bcc.n	c0d02d68 <__aeabi_uidiv+0x3c>
c0d02d4c:	22ff      	movs	r2, #255	; 0xff
c0d02d4e:	0209      	lsls	r1, r1, #8
c0d02d50:	ba12      	rev	r2, r2
c0d02d52:	0c03      	lsrs	r3, r0, #16
c0d02d54:	428b      	cmp	r3, r1
c0d02d56:	d302      	bcc.n	c0d02d5e <__aeabi_uidiv+0x32>
c0d02d58:	1212      	asrs	r2, r2, #8
c0d02d5a:	0209      	lsls	r1, r1, #8
c0d02d5c:	d065      	beq.n	c0d02e2a <__aeabi_uidiv+0xfe>
c0d02d5e:	0b03      	lsrs	r3, r0, #12
c0d02d60:	428b      	cmp	r3, r1
c0d02d62:	d319      	bcc.n	c0d02d98 <__aeabi_uidiv+0x6c>
c0d02d64:	e000      	b.n	c0d02d68 <__aeabi_uidiv+0x3c>
c0d02d66:	0a09      	lsrs	r1, r1, #8
c0d02d68:	0bc3      	lsrs	r3, r0, #15
c0d02d6a:	428b      	cmp	r3, r1
c0d02d6c:	d301      	bcc.n	c0d02d72 <__aeabi_uidiv+0x46>
c0d02d6e:	03cb      	lsls	r3, r1, #15
c0d02d70:	1ac0      	subs	r0, r0, r3
c0d02d72:	4152      	adcs	r2, r2
c0d02d74:	0b83      	lsrs	r3, r0, #14
c0d02d76:	428b      	cmp	r3, r1
c0d02d78:	d301      	bcc.n	c0d02d7e <__aeabi_uidiv+0x52>
c0d02d7a:	038b      	lsls	r3, r1, #14
c0d02d7c:	1ac0      	subs	r0, r0, r3
c0d02d7e:	4152      	adcs	r2, r2
c0d02d80:	0b43      	lsrs	r3, r0, #13
c0d02d82:	428b      	cmp	r3, r1
c0d02d84:	d301      	bcc.n	c0d02d8a <__aeabi_uidiv+0x5e>
c0d02d86:	034b      	lsls	r3, r1, #13
c0d02d88:	1ac0      	subs	r0, r0, r3
c0d02d8a:	4152      	adcs	r2, r2
c0d02d8c:	0b03      	lsrs	r3, r0, #12
c0d02d8e:	428b      	cmp	r3, r1
c0d02d90:	d301      	bcc.n	c0d02d96 <__aeabi_uidiv+0x6a>
c0d02d92:	030b      	lsls	r3, r1, #12
c0d02d94:	1ac0      	subs	r0, r0, r3
c0d02d96:	4152      	adcs	r2, r2
c0d02d98:	0ac3      	lsrs	r3, r0, #11
c0d02d9a:	428b      	cmp	r3, r1
c0d02d9c:	d301      	bcc.n	c0d02da2 <__aeabi_uidiv+0x76>
c0d02d9e:	02cb      	lsls	r3, r1, #11
c0d02da0:	1ac0      	subs	r0, r0, r3
c0d02da2:	4152      	adcs	r2, r2
c0d02da4:	0a83      	lsrs	r3, r0, #10
c0d02da6:	428b      	cmp	r3, r1
c0d02da8:	d301      	bcc.n	c0d02dae <__aeabi_uidiv+0x82>
c0d02daa:	028b      	lsls	r3, r1, #10
c0d02dac:	1ac0      	subs	r0, r0, r3
c0d02dae:	4152      	adcs	r2, r2
c0d02db0:	0a43      	lsrs	r3, r0, #9
c0d02db2:	428b      	cmp	r3, r1
c0d02db4:	d301      	bcc.n	c0d02dba <__aeabi_uidiv+0x8e>
c0d02db6:	024b      	lsls	r3, r1, #9
c0d02db8:	1ac0      	subs	r0, r0, r3
c0d02dba:	4152      	adcs	r2, r2
c0d02dbc:	0a03      	lsrs	r3, r0, #8
c0d02dbe:	428b      	cmp	r3, r1
c0d02dc0:	d301      	bcc.n	c0d02dc6 <__aeabi_uidiv+0x9a>
c0d02dc2:	020b      	lsls	r3, r1, #8
c0d02dc4:	1ac0      	subs	r0, r0, r3
c0d02dc6:	4152      	adcs	r2, r2
c0d02dc8:	d2cd      	bcs.n	c0d02d66 <__aeabi_uidiv+0x3a>
c0d02dca:	09c3      	lsrs	r3, r0, #7
c0d02dcc:	428b      	cmp	r3, r1
c0d02dce:	d301      	bcc.n	c0d02dd4 <__aeabi_uidiv+0xa8>
c0d02dd0:	01cb      	lsls	r3, r1, #7
c0d02dd2:	1ac0      	subs	r0, r0, r3
c0d02dd4:	4152      	adcs	r2, r2
c0d02dd6:	0983      	lsrs	r3, r0, #6
c0d02dd8:	428b      	cmp	r3, r1
c0d02dda:	d301      	bcc.n	c0d02de0 <__aeabi_uidiv+0xb4>
c0d02ddc:	018b      	lsls	r3, r1, #6
c0d02dde:	1ac0      	subs	r0, r0, r3
c0d02de0:	4152      	adcs	r2, r2
c0d02de2:	0943      	lsrs	r3, r0, #5
c0d02de4:	428b      	cmp	r3, r1
c0d02de6:	d301      	bcc.n	c0d02dec <__aeabi_uidiv+0xc0>
c0d02de8:	014b      	lsls	r3, r1, #5
c0d02dea:	1ac0      	subs	r0, r0, r3
c0d02dec:	4152      	adcs	r2, r2
c0d02dee:	0903      	lsrs	r3, r0, #4
c0d02df0:	428b      	cmp	r3, r1
c0d02df2:	d301      	bcc.n	c0d02df8 <__aeabi_uidiv+0xcc>
c0d02df4:	010b      	lsls	r3, r1, #4
c0d02df6:	1ac0      	subs	r0, r0, r3
c0d02df8:	4152      	adcs	r2, r2
c0d02dfa:	08c3      	lsrs	r3, r0, #3
c0d02dfc:	428b      	cmp	r3, r1
c0d02dfe:	d301      	bcc.n	c0d02e04 <__aeabi_uidiv+0xd8>
c0d02e00:	00cb      	lsls	r3, r1, #3
c0d02e02:	1ac0      	subs	r0, r0, r3
c0d02e04:	4152      	adcs	r2, r2
c0d02e06:	0883      	lsrs	r3, r0, #2
c0d02e08:	428b      	cmp	r3, r1
c0d02e0a:	d301      	bcc.n	c0d02e10 <__aeabi_uidiv+0xe4>
c0d02e0c:	008b      	lsls	r3, r1, #2
c0d02e0e:	1ac0      	subs	r0, r0, r3
c0d02e10:	4152      	adcs	r2, r2
c0d02e12:	0843      	lsrs	r3, r0, #1
c0d02e14:	428b      	cmp	r3, r1
c0d02e16:	d301      	bcc.n	c0d02e1c <__aeabi_uidiv+0xf0>
c0d02e18:	004b      	lsls	r3, r1, #1
c0d02e1a:	1ac0      	subs	r0, r0, r3
c0d02e1c:	4152      	adcs	r2, r2
c0d02e1e:	1a41      	subs	r1, r0, r1
c0d02e20:	d200      	bcs.n	c0d02e24 <__aeabi_uidiv+0xf8>
c0d02e22:	4601      	mov	r1, r0
c0d02e24:	4152      	adcs	r2, r2
c0d02e26:	4610      	mov	r0, r2
c0d02e28:	4770      	bx	lr
c0d02e2a:	e7ff      	b.n	c0d02e2c <__aeabi_uidiv+0x100>
c0d02e2c:	b501      	push	{r0, lr}
c0d02e2e:	2000      	movs	r0, #0
c0d02e30:	f000 f8f0 	bl	c0d03014 <__aeabi_idiv0>
c0d02e34:	bd02      	pop	{r1, pc}
c0d02e36:	46c0      	nop			; (mov r8, r8)

c0d02e38 <__aeabi_uidivmod>:
c0d02e38:	2900      	cmp	r1, #0
c0d02e3a:	d0f7      	beq.n	c0d02e2c <__aeabi_uidiv+0x100>
c0d02e3c:	e776      	b.n	c0d02d2c <__aeabi_uidiv>
c0d02e3e:	4770      	bx	lr

c0d02e40 <__aeabi_idiv>:
c0d02e40:	4603      	mov	r3, r0
c0d02e42:	430b      	orrs	r3, r1
c0d02e44:	d47f      	bmi.n	c0d02f46 <__aeabi_idiv+0x106>
c0d02e46:	2200      	movs	r2, #0
c0d02e48:	0843      	lsrs	r3, r0, #1
c0d02e4a:	428b      	cmp	r3, r1
c0d02e4c:	d374      	bcc.n	c0d02f38 <__aeabi_idiv+0xf8>
c0d02e4e:	0903      	lsrs	r3, r0, #4
c0d02e50:	428b      	cmp	r3, r1
c0d02e52:	d35f      	bcc.n	c0d02f14 <__aeabi_idiv+0xd4>
c0d02e54:	0a03      	lsrs	r3, r0, #8
c0d02e56:	428b      	cmp	r3, r1
c0d02e58:	d344      	bcc.n	c0d02ee4 <__aeabi_idiv+0xa4>
c0d02e5a:	0b03      	lsrs	r3, r0, #12
c0d02e5c:	428b      	cmp	r3, r1
c0d02e5e:	d328      	bcc.n	c0d02eb2 <__aeabi_idiv+0x72>
c0d02e60:	0c03      	lsrs	r3, r0, #16
c0d02e62:	428b      	cmp	r3, r1
c0d02e64:	d30d      	bcc.n	c0d02e82 <__aeabi_idiv+0x42>
c0d02e66:	22ff      	movs	r2, #255	; 0xff
c0d02e68:	0209      	lsls	r1, r1, #8
c0d02e6a:	ba12      	rev	r2, r2
c0d02e6c:	0c03      	lsrs	r3, r0, #16
c0d02e6e:	428b      	cmp	r3, r1
c0d02e70:	d302      	bcc.n	c0d02e78 <__aeabi_idiv+0x38>
c0d02e72:	1212      	asrs	r2, r2, #8
c0d02e74:	0209      	lsls	r1, r1, #8
c0d02e76:	d065      	beq.n	c0d02f44 <__aeabi_idiv+0x104>
c0d02e78:	0b03      	lsrs	r3, r0, #12
c0d02e7a:	428b      	cmp	r3, r1
c0d02e7c:	d319      	bcc.n	c0d02eb2 <__aeabi_idiv+0x72>
c0d02e7e:	e000      	b.n	c0d02e82 <__aeabi_idiv+0x42>
c0d02e80:	0a09      	lsrs	r1, r1, #8
c0d02e82:	0bc3      	lsrs	r3, r0, #15
c0d02e84:	428b      	cmp	r3, r1
c0d02e86:	d301      	bcc.n	c0d02e8c <__aeabi_idiv+0x4c>
c0d02e88:	03cb      	lsls	r3, r1, #15
c0d02e8a:	1ac0      	subs	r0, r0, r3
c0d02e8c:	4152      	adcs	r2, r2
c0d02e8e:	0b83      	lsrs	r3, r0, #14
c0d02e90:	428b      	cmp	r3, r1
c0d02e92:	d301      	bcc.n	c0d02e98 <__aeabi_idiv+0x58>
c0d02e94:	038b      	lsls	r3, r1, #14
c0d02e96:	1ac0      	subs	r0, r0, r3
c0d02e98:	4152      	adcs	r2, r2
c0d02e9a:	0b43      	lsrs	r3, r0, #13
c0d02e9c:	428b      	cmp	r3, r1
c0d02e9e:	d301      	bcc.n	c0d02ea4 <__aeabi_idiv+0x64>
c0d02ea0:	034b      	lsls	r3, r1, #13
c0d02ea2:	1ac0      	subs	r0, r0, r3
c0d02ea4:	4152      	adcs	r2, r2
c0d02ea6:	0b03      	lsrs	r3, r0, #12
c0d02ea8:	428b      	cmp	r3, r1
c0d02eaa:	d301      	bcc.n	c0d02eb0 <__aeabi_idiv+0x70>
c0d02eac:	030b      	lsls	r3, r1, #12
c0d02eae:	1ac0      	subs	r0, r0, r3
c0d02eb0:	4152      	adcs	r2, r2
c0d02eb2:	0ac3      	lsrs	r3, r0, #11
c0d02eb4:	428b      	cmp	r3, r1
c0d02eb6:	d301      	bcc.n	c0d02ebc <__aeabi_idiv+0x7c>
c0d02eb8:	02cb      	lsls	r3, r1, #11
c0d02eba:	1ac0      	subs	r0, r0, r3
c0d02ebc:	4152      	adcs	r2, r2
c0d02ebe:	0a83      	lsrs	r3, r0, #10
c0d02ec0:	428b      	cmp	r3, r1
c0d02ec2:	d301      	bcc.n	c0d02ec8 <__aeabi_idiv+0x88>
c0d02ec4:	028b      	lsls	r3, r1, #10
c0d02ec6:	1ac0      	subs	r0, r0, r3
c0d02ec8:	4152      	adcs	r2, r2
c0d02eca:	0a43      	lsrs	r3, r0, #9
c0d02ecc:	428b      	cmp	r3, r1
c0d02ece:	d301      	bcc.n	c0d02ed4 <__aeabi_idiv+0x94>
c0d02ed0:	024b      	lsls	r3, r1, #9
c0d02ed2:	1ac0      	subs	r0, r0, r3
c0d02ed4:	4152      	adcs	r2, r2
c0d02ed6:	0a03      	lsrs	r3, r0, #8
c0d02ed8:	428b      	cmp	r3, r1
c0d02eda:	d301      	bcc.n	c0d02ee0 <__aeabi_idiv+0xa0>
c0d02edc:	020b      	lsls	r3, r1, #8
c0d02ede:	1ac0      	subs	r0, r0, r3
c0d02ee0:	4152      	adcs	r2, r2
c0d02ee2:	d2cd      	bcs.n	c0d02e80 <__aeabi_idiv+0x40>
c0d02ee4:	09c3      	lsrs	r3, r0, #7
c0d02ee6:	428b      	cmp	r3, r1
c0d02ee8:	d301      	bcc.n	c0d02eee <__aeabi_idiv+0xae>
c0d02eea:	01cb      	lsls	r3, r1, #7
c0d02eec:	1ac0      	subs	r0, r0, r3
c0d02eee:	4152      	adcs	r2, r2
c0d02ef0:	0983      	lsrs	r3, r0, #6
c0d02ef2:	428b      	cmp	r3, r1
c0d02ef4:	d301      	bcc.n	c0d02efa <__aeabi_idiv+0xba>
c0d02ef6:	018b      	lsls	r3, r1, #6
c0d02ef8:	1ac0      	subs	r0, r0, r3
c0d02efa:	4152      	adcs	r2, r2
c0d02efc:	0943      	lsrs	r3, r0, #5
c0d02efe:	428b      	cmp	r3, r1
c0d02f00:	d301      	bcc.n	c0d02f06 <__aeabi_idiv+0xc6>
c0d02f02:	014b      	lsls	r3, r1, #5
c0d02f04:	1ac0      	subs	r0, r0, r3
c0d02f06:	4152      	adcs	r2, r2
c0d02f08:	0903      	lsrs	r3, r0, #4
c0d02f0a:	428b      	cmp	r3, r1
c0d02f0c:	d301      	bcc.n	c0d02f12 <__aeabi_idiv+0xd2>
c0d02f0e:	010b      	lsls	r3, r1, #4
c0d02f10:	1ac0      	subs	r0, r0, r3
c0d02f12:	4152      	adcs	r2, r2
c0d02f14:	08c3      	lsrs	r3, r0, #3
c0d02f16:	428b      	cmp	r3, r1
c0d02f18:	d301      	bcc.n	c0d02f1e <__aeabi_idiv+0xde>
c0d02f1a:	00cb      	lsls	r3, r1, #3
c0d02f1c:	1ac0      	subs	r0, r0, r3
c0d02f1e:	4152      	adcs	r2, r2
c0d02f20:	0883      	lsrs	r3, r0, #2
c0d02f22:	428b      	cmp	r3, r1
c0d02f24:	d301      	bcc.n	c0d02f2a <__aeabi_idiv+0xea>
c0d02f26:	008b      	lsls	r3, r1, #2
c0d02f28:	1ac0      	subs	r0, r0, r3
c0d02f2a:	4152      	adcs	r2, r2
c0d02f2c:	0843      	lsrs	r3, r0, #1
c0d02f2e:	428b      	cmp	r3, r1
c0d02f30:	d301      	bcc.n	c0d02f36 <__aeabi_idiv+0xf6>
c0d02f32:	004b      	lsls	r3, r1, #1
c0d02f34:	1ac0      	subs	r0, r0, r3
c0d02f36:	4152      	adcs	r2, r2
c0d02f38:	1a41      	subs	r1, r0, r1
c0d02f3a:	d200      	bcs.n	c0d02f3e <__aeabi_idiv+0xfe>
c0d02f3c:	4601      	mov	r1, r0
c0d02f3e:	4152      	adcs	r2, r2
c0d02f40:	4610      	mov	r0, r2
c0d02f42:	4770      	bx	lr
c0d02f44:	e05d      	b.n	c0d03002 <__aeabi_idiv+0x1c2>
c0d02f46:	0fca      	lsrs	r2, r1, #31
c0d02f48:	d000      	beq.n	c0d02f4c <__aeabi_idiv+0x10c>
c0d02f4a:	4249      	negs	r1, r1
c0d02f4c:	1003      	asrs	r3, r0, #32
c0d02f4e:	d300      	bcc.n	c0d02f52 <__aeabi_idiv+0x112>
c0d02f50:	4240      	negs	r0, r0
c0d02f52:	4053      	eors	r3, r2
c0d02f54:	2200      	movs	r2, #0
c0d02f56:	469c      	mov	ip, r3
c0d02f58:	0903      	lsrs	r3, r0, #4
c0d02f5a:	428b      	cmp	r3, r1
c0d02f5c:	d32d      	bcc.n	c0d02fba <__aeabi_idiv+0x17a>
c0d02f5e:	0a03      	lsrs	r3, r0, #8
c0d02f60:	428b      	cmp	r3, r1
c0d02f62:	d312      	bcc.n	c0d02f8a <__aeabi_idiv+0x14a>
c0d02f64:	22fc      	movs	r2, #252	; 0xfc
c0d02f66:	0189      	lsls	r1, r1, #6
c0d02f68:	ba12      	rev	r2, r2
c0d02f6a:	0a03      	lsrs	r3, r0, #8
c0d02f6c:	428b      	cmp	r3, r1
c0d02f6e:	d30c      	bcc.n	c0d02f8a <__aeabi_idiv+0x14a>
c0d02f70:	0189      	lsls	r1, r1, #6
c0d02f72:	1192      	asrs	r2, r2, #6
c0d02f74:	428b      	cmp	r3, r1
c0d02f76:	d308      	bcc.n	c0d02f8a <__aeabi_idiv+0x14a>
c0d02f78:	0189      	lsls	r1, r1, #6
c0d02f7a:	1192      	asrs	r2, r2, #6
c0d02f7c:	428b      	cmp	r3, r1
c0d02f7e:	d304      	bcc.n	c0d02f8a <__aeabi_idiv+0x14a>
c0d02f80:	0189      	lsls	r1, r1, #6
c0d02f82:	d03a      	beq.n	c0d02ffa <__aeabi_idiv+0x1ba>
c0d02f84:	1192      	asrs	r2, r2, #6
c0d02f86:	e000      	b.n	c0d02f8a <__aeabi_idiv+0x14a>
c0d02f88:	0989      	lsrs	r1, r1, #6
c0d02f8a:	09c3      	lsrs	r3, r0, #7
c0d02f8c:	428b      	cmp	r3, r1
c0d02f8e:	d301      	bcc.n	c0d02f94 <__aeabi_idiv+0x154>
c0d02f90:	01cb      	lsls	r3, r1, #7
c0d02f92:	1ac0      	subs	r0, r0, r3
c0d02f94:	4152      	adcs	r2, r2
c0d02f96:	0983      	lsrs	r3, r0, #6
c0d02f98:	428b      	cmp	r3, r1
c0d02f9a:	d301      	bcc.n	c0d02fa0 <__aeabi_idiv+0x160>
c0d02f9c:	018b      	lsls	r3, r1, #6
c0d02f9e:	1ac0      	subs	r0, r0, r3
c0d02fa0:	4152      	adcs	r2, r2
c0d02fa2:	0943      	lsrs	r3, r0, #5
c0d02fa4:	428b      	cmp	r3, r1
c0d02fa6:	d301      	bcc.n	c0d02fac <__aeabi_idiv+0x16c>
c0d02fa8:	014b      	lsls	r3, r1, #5
c0d02faa:	1ac0      	subs	r0, r0, r3
c0d02fac:	4152      	adcs	r2, r2
c0d02fae:	0903      	lsrs	r3, r0, #4
c0d02fb0:	428b      	cmp	r3, r1
c0d02fb2:	d301      	bcc.n	c0d02fb8 <__aeabi_idiv+0x178>
c0d02fb4:	010b      	lsls	r3, r1, #4
c0d02fb6:	1ac0      	subs	r0, r0, r3
c0d02fb8:	4152      	adcs	r2, r2
c0d02fba:	08c3      	lsrs	r3, r0, #3
c0d02fbc:	428b      	cmp	r3, r1
c0d02fbe:	d301      	bcc.n	c0d02fc4 <__aeabi_idiv+0x184>
c0d02fc0:	00cb      	lsls	r3, r1, #3
c0d02fc2:	1ac0      	subs	r0, r0, r3
c0d02fc4:	4152      	adcs	r2, r2
c0d02fc6:	0883      	lsrs	r3, r0, #2
c0d02fc8:	428b      	cmp	r3, r1
c0d02fca:	d301      	bcc.n	c0d02fd0 <__aeabi_idiv+0x190>
c0d02fcc:	008b      	lsls	r3, r1, #2
c0d02fce:	1ac0      	subs	r0, r0, r3
c0d02fd0:	4152      	adcs	r2, r2
c0d02fd2:	d2d9      	bcs.n	c0d02f88 <__aeabi_idiv+0x148>
c0d02fd4:	0843      	lsrs	r3, r0, #1
c0d02fd6:	428b      	cmp	r3, r1
c0d02fd8:	d301      	bcc.n	c0d02fde <__aeabi_idiv+0x19e>
c0d02fda:	004b      	lsls	r3, r1, #1
c0d02fdc:	1ac0      	subs	r0, r0, r3
c0d02fde:	4152      	adcs	r2, r2
c0d02fe0:	1a41      	subs	r1, r0, r1
c0d02fe2:	d200      	bcs.n	c0d02fe6 <__aeabi_idiv+0x1a6>
c0d02fe4:	4601      	mov	r1, r0
c0d02fe6:	4663      	mov	r3, ip
c0d02fe8:	4152      	adcs	r2, r2
c0d02fea:	105b      	asrs	r3, r3, #1
c0d02fec:	4610      	mov	r0, r2
c0d02fee:	d301      	bcc.n	c0d02ff4 <__aeabi_idiv+0x1b4>
c0d02ff0:	4240      	negs	r0, r0
c0d02ff2:	2b00      	cmp	r3, #0
c0d02ff4:	d500      	bpl.n	c0d02ff8 <__aeabi_idiv+0x1b8>
c0d02ff6:	4249      	negs	r1, r1
c0d02ff8:	4770      	bx	lr
c0d02ffa:	4663      	mov	r3, ip
c0d02ffc:	105b      	asrs	r3, r3, #1
c0d02ffe:	d300      	bcc.n	c0d03002 <__aeabi_idiv+0x1c2>
c0d03000:	4240      	negs	r0, r0
c0d03002:	b501      	push	{r0, lr}
c0d03004:	2000      	movs	r0, #0
c0d03006:	f000 f805 	bl	c0d03014 <__aeabi_idiv0>
c0d0300a:	bd02      	pop	{r1, pc}

c0d0300c <__aeabi_idivmod>:
c0d0300c:	2900      	cmp	r1, #0
c0d0300e:	d0f8      	beq.n	c0d03002 <__aeabi_idiv+0x1c2>
c0d03010:	e716      	b.n	c0d02e40 <__aeabi_idiv>
c0d03012:	4770      	bx	lr

c0d03014 <__aeabi_idiv0>:
c0d03014:	4770      	bx	lr
c0d03016:	46c0      	nop			; (mov r8, r8)

c0d03018 <__aeabi_lmul>:
c0d03018:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0301a:	464f      	mov	r7, r9
c0d0301c:	4646      	mov	r6, r8
c0d0301e:	b4c0      	push	{r6, r7}
c0d03020:	0416      	lsls	r6, r2, #16
c0d03022:	0c36      	lsrs	r6, r6, #16
c0d03024:	4699      	mov	r9, r3
c0d03026:	0033      	movs	r3, r6
c0d03028:	0405      	lsls	r5, r0, #16
c0d0302a:	0c2c      	lsrs	r4, r5, #16
c0d0302c:	0c07      	lsrs	r7, r0, #16
c0d0302e:	0c15      	lsrs	r5, r2, #16
c0d03030:	4363      	muls	r3, r4
c0d03032:	437e      	muls	r6, r7
c0d03034:	436f      	muls	r7, r5
c0d03036:	4365      	muls	r5, r4
c0d03038:	0c1c      	lsrs	r4, r3, #16
c0d0303a:	19ad      	adds	r5, r5, r6
c0d0303c:	1964      	adds	r4, r4, r5
c0d0303e:	469c      	mov	ip, r3
c0d03040:	42a6      	cmp	r6, r4
c0d03042:	d903      	bls.n	c0d0304c <__aeabi_lmul+0x34>
c0d03044:	2380      	movs	r3, #128	; 0x80
c0d03046:	025b      	lsls	r3, r3, #9
c0d03048:	4698      	mov	r8, r3
c0d0304a:	4447      	add	r7, r8
c0d0304c:	4663      	mov	r3, ip
c0d0304e:	0c25      	lsrs	r5, r4, #16
c0d03050:	19ef      	adds	r7, r5, r7
c0d03052:	041d      	lsls	r5, r3, #16
c0d03054:	464b      	mov	r3, r9
c0d03056:	434a      	muls	r2, r1
c0d03058:	4343      	muls	r3, r0
c0d0305a:	0c2d      	lsrs	r5, r5, #16
c0d0305c:	0424      	lsls	r4, r4, #16
c0d0305e:	1964      	adds	r4, r4, r5
c0d03060:	1899      	adds	r1, r3, r2
c0d03062:	19c9      	adds	r1, r1, r7
c0d03064:	0020      	movs	r0, r4
c0d03066:	bc0c      	pop	{r2, r3}
c0d03068:	4690      	mov	r8, r2
c0d0306a:	4699      	mov	r9, r3
c0d0306c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0306e:	46c0      	nop			; (mov r8, r8)

c0d03070 <__aeabi_memclr>:
c0d03070:	b510      	push	{r4, lr}
c0d03072:	2200      	movs	r2, #0
c0d03074:	f000 f806 	bl	c0d03084 <__aeabi_memset>
c0d03078:	bd10      	pop	{r4, pc}
c0d0307a:	46c0      	nop			; (mov r8, r8)

c0d0307c <__aeabi_memcpy>:
c0d0307c:	b510      	push	{r4, lr}
c0d0307e:	f000 f809 	bl	c0d03094 <memcpy>
c0d03082:	bd10      	pop	{r4, pc}

c0d03084 <__aeabi_memset>:
c0d03084:	0013      	movs	r3, r2
c0d03086:	b510      	push	{r4, lr}
c0d03088:	000a      	movs	r2, r1
c0d0308a:	0019      	movs	r1, r3
c0d0308c:	f000 f840 	bl	c0d03110 <memset>
c0d03090:	bd10      	pop	{r4, pc}
c0d03092:	46c0      	nop			; (mov r8, r8)

c0d03094 <memcpy>:
c0d03094:	b570      	push	{r4, r5, r6, lr}
c0d03096:	2a0f      	cmp	r2, #15
c0d03098:	d932      	bls.n	c0d03100 <memcpy+0x6c>
c0d0309a:	000c      	movs	r4, r1
c0d0309c:	4304      	orrs	r4, r0
c0d0309e:	000b      	movs	r3, r1
c0d030a0:	07a4      	lsls	r4, r4, #30
c0d030a2:	d131      	bne.n	c0d03108 <memcpy+0x74>
c0d030a4:	0015      	movs	r5, r2
c0d030a6:	0004      	movs	r4, r0
c0d030a8:	3d10      	subs	r5, #16
c0d030aa:	092d      	lsrs	r5, r5, #4
c0d030ac:	3501      	adds	r5, #1
c0d030ae:	012d      	lsls	r5, r5, #4
c0d030b0:	1949      	adds	r1, r1, r5
c0d030b2:	681e      	ldr	r6, [r3, #0]
c0d030b4:	6026      	str	r6, [r4, #0]
c0d030b6:	685e      	ldr	r6, [r3, #4]
c0d030b8:	6066      	str	r6, [r4, #4]
c0d030ba:	689e      	ldr	r6, [r3, #8]
c0d030bc:	60a6      	str	r6, [r4, #8]
c0d030be:	68de      	ldr	r6, [r3, #12]
c0d030c0:	3310      	adds	r3, #16
c0d030c2:	60e6      	str	r6, [r4, #12]
c0d030c4:	3410      	adds	r4, #16
c0d030c6:	4299      	cmp	r1, r3
c0d030c8:	d1f3      	bne.n	c0d030b2 <memcpy+0x1e>
c0d030ca:	230f      	movs	r3, #15
c0d030cc:	1945      	adds	r5, r0, r5
c0d030ce:	4013      	ands	r3, r2
c0d030d0:	2b03      	cmp	r3, #3
c0d030d2:	d91b      	bls.n	c0d0310c <memcpy+0x78>
c0d030d4:	1f1c      	subs	r4, r3, #4
c0d030d6:	2300      	movs	r3, #0
c0d030d8:	08a4      	lsrs	r4, r4, #2
c0d030da:	3401      	adds	r4, #1
c0d030dc:	00a4      	lsls	r4, r4, #2
c0d030de:	58ce      	ldr	r6, [r1, r3]
c0d030e0:	50ee      	str	r6, [r5, r3]
c0d030e2:	3304      	adds	r3, #4
c0d030e4:	429c      	cmp	r4, r3
c0d030e6:	d1fa      	bne.n	c0d030de <memcpy+0x4a>
c0d030e8:	2303      	movs	r3, #3
c0d030ea:	192d      	adds	r5, r5, r4
c0d030ec:	1909      	adds	r1, r1, r4
c0d030ee:	401a      	ands	r2, r3
c0d030f0:	d005      	beq.n	c0d030fe <memcpy+0x6a>
c0d030f2:	2300      	movs	r3, #0
c0d030f4:	5ccc      	ldrb	r4, [r1, r3]
c0d030f6:	54ec      	strb	r4, [r5, r3]
c0d030f8:	3301      	adds	r3, #1
c0d030fa:	429a      	cmp	r2, r3
c0d030fc:	d1fa      	bne.n	c0d030f4 <memcpy+0x60>
c0d030fe:	bd70      	pop	{r4, r5, r6, pc}
c0d03100:	0005      	movs	r5, r0
c0d03102:	2a00      	cmp	r2, #0
c0d03104:	d1f5      	bne.n	c0d030f2 <memcpy+0x5e>
c0d03106:	e7fa      	b.n	c0d030fe <memcpy+0x6a>
c0d03108:	0005      	movs	r5, r0
c0d0310a:	e7f2      	b.n	c0d030f2 <memcpy+0x5e>
c0d0310c:	001a      	movs	r2, r3
c0d0310e:	e7f8      	b.n	c0d03102 <memcpy+0x6e>

c0d03110 <memset>:
c0d03110:	b570      	push	{r4, r5, r6, lr}
c0d03112:	0783      	lsls	r3, r0, #30
c0d03114:	d03f      	beq.n	c0d03196 <memset+0x86>
c0d03116:	1e54      	subs	r4, r2, #1
c0d03118:	2a00      	cmp	r2, #0
c0d0311a:	d03b      	beq.n	c0d03194 <memset+0x84>
c0d0311c:	b2ce      	uxtb	r6, r1
c0d0311e:	0003      	movs	r3, r0
c0d03120:	2503      	movs	r5, #3
c0d03122:	e003      	b.n	c0d0312c <memset+0x1c>
c0d03124:	1e62      	subs	r2, r4, #1
c0d03126:	2c00      	cmp	r4, #0
c0d03128:	d034      	beq.n	c0d03194 <memset+0x84>
c0d0312a:	0014      	movs	r4, r2
c0d0312c:	3301      	adds	r3, #1
c0d0312e:	1e5a      	subs	r2, r3, #1
c0d03130:	7016      	strb	r6, [r2, #0]
c0d03132:	422b      	tst	r3, r5
c0d03134:	d1f6      	bne.n	c0d03124 <memset+0x14>
c0d03136:	2c03      	cmp	r4, #3
c0d03138:	d924      	bls.n	c0d03184 <memset+0x74>
c0d0313a:	25ff      	movs	r5, #255	; 0xff
c0d0313c:	400d      	ands	r5, r1
c0d0313e:	022a      	lsls	r2, r5, #8
c0d03140:	4315      	orrs	r5, r2
c0d03142:	042a      	lsls	r2, r5, #16
c0d03144:	4315      	orrs	r5, r2
c0d03146:	2c0f      	cmp	r4, #15
c0d03148:	d911      	bls.n	c0d0316e <memset+0x5e>
c0d0314a:	0026      	movs	r6, r4
c0d0314c:	3e10      	subs	r6, #16
c0d0314e:	0936      	lsrs	r6, r6, #4
c0d03150:	3601      	adds	r6, #1
c0d03152:	0136      	lsls	r6, r6, #4
c0d03154:	001a      	movs	r2, r3
c0d03156:	199b      	adds	r3, r3, r6
c0d03158:	6015      	str	r5, [r2, #0]
c0d0315a:	6055      	str	r5, [r2, #4]
c0d0315c:	6095      	str	r5, [r2, #8]
c0d0315e:	60d5      	str	r5, [r2, #12]
c0d03160:	3210      	adds	r2, #16
c0d03162:	4293      	cmp	r3, r2
c0d03164:	d1f8      	bne.n	c0d03158 <memset+0x48>
c0d03166:	220f      	movs	r2, #15
c0d03168:	4014      	ands	r4, r2
c0d0316a:	2c03      	cmp	r4, #3
c0d0316c:	d90a      	bls.n	c0d03184 <memset+0x74>
c0d0316e:	1f26      	subs	r6, r4, #4
c0d03170:	08b6      	lsrs	r6, r6, #2
c0d03172:	3601      	adds	r6, #1
c0d03174:	00b6      	lsls	r6, r6, #2
c0d03176:	001a      	movs	r2, r3
c0d03178:	199b      	adds	r3, r3, r6
c0d0317a:	c220      	stmia	r2!, {r5}
c0d0317c:	4293      	cmp	r3, r2
c0d0317e:	d1fc      	bne.n	c0d0317a <memset+0x6a>
c0d03180:	2203      	movs	r2, #3
c0d03182:	4014      	ands	r4, r2
c0d03184:	2c00      	cmp	r4, #0
c0d03186:	d005      	beq.n	c0d03194 <memset+0x84>
c0d03188:	b2c9      	uxtb	r1, r1
c0d0318a:	191c      	adds	r4, r3, r4
c0d0318c:	7019      	strb	r1, [r3, #0]
c0d0318e:	3301      	adds	r3, #1
c0d03190:	429c      	cmp	r4, r3
c0d03192:	d1fb      	bne.n	c0d0318c <memset+0x7c>
c0d03194:	bd70      	pop	{r4, r5, r6, pc}
c0d03196:	0014      	movs	r4, r2
c0d03198:	0003      	movs	r3, r0
c0d0319a:	e7cc      	b.n	c0d03136 <memset+0x26>

c0d0319c <setjmp>:
c0d0319c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0319e:	4641      	mov	r1, r8
c0d031a0:	464a      	mov	r2, r9
c0d031a2:	4653      	mov	r3, sl
c0d031a4:	465c      	mov	r4, fp
c0d031a6:	466d      	mov	r5, sp
c0d031a8:	4676      	mov	r6, lr
c0d031aa:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d031ac:	3828      	subs	r0, #40	; 0x28
c0d031ae:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d031b0:	2000      	movs	r0, #0
c0d031b2:	4770      	bx	lr

c0d031b4 <longjmp>:
c0d031b4:	3010      	adds	r0, #16
c0d031b6:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d031b8:	4690      	mov	r8, r2
c0d031ba:	4699      	mov	r9, r3
c0d031bc:	46a2      	mov	sl, r4
c0d031be:	46ab      	mov	fp, r5
c0d031c0:	46b5      	mov	sp, r6
c0d031c2:	c808      	ldmia	r0!, {r3}
c0d031c4:	3828      	subs	r0, #40	; 0x28
c0d031c6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d031c8:	1c08      	adds	r0, r1, #0
c0d031ca:	d100      	bne.n	c0d031ce <longjmp+0x1a>
c0d031cc:	2001      	movs	r0, #1
c0d031ce:	4718      	bx	r3

c0d031d0 <strlen>:
c0d031d0:	b510      	push	{r4, lr}
c0d031d2:	0783      	lsls	r3, r0, #30
c0d031d4:	d027      	beq.n	c0d03226 <strlen+0x56>
c0d031d6:	7803      	ldrb	r3, [r0, #0]
c0d031d8:	2b00      	cmp	r3, #0
c0d031da:	d026      	beq.n	c0d0322a <strlen+0x5a>
c0d031dc:	0003      	movs	r3, r0
c0d031de:	2103      	movs	r1, #3
c0d031e0:	e002      	b.n	c0d031e8 <strlen+0x18>
c0d031e2:	781a      	ldrb	r2, [r3, #0]
c0d031e4:	2a00      	cmp	r2, #0
c0d031e6:	d01c      	beq.n	c0d03222 <strlen+0x52>
c0d031e8:	3301      	adds	r3, #1
c0d031ea:	420b      	tst	r3, r1
c0d031ec:	d1f9      	bne.n	c0d031e2 <strlen+0x12>
c0d031ee:	6819      	ldr	r1, [r3, #0]
c0d031f0:	4a0f      	ldr	r2, [pc, #60]	; (c0d03230 <strlen+0x60>)
c0d031f2:	4c10      	ldr	r4, [pc, #64]	; (c0d03234 <strlen+0x64>)
c0d031f4:	188a      	adds	r2, r1, r2
c0d031f6:	438a      	bics	r2, r1
c0d031f8:	4222      	tst	r2, r4
c0d031fa:	d10f      	bne.n	c0d0321c <strlen+0x4c>
c0d031fc:	3304      	adds	r3, #4
c0d031fe:	6819      	ldr	r1, [r3, #0]
c0d03200:	4a0b      	ldr	r2, [pc, #44]	; (c0d03230 <strlen+0x60>)
c0d03202:	188a      	adds	r2, r1, r2
c0d03204:	438a      	bics	r2, r1
c0d03206:	4222      	tst	r2, r4
c0d03208:	d108      	bne.n	c0d0321c <strlen+0x4c>
c0d0320a:	3304      	adds	r3, #4
c0d0320c:	6819      	ldr	r1, [r3, #0]
c0d0320e:	4a08      	ldr	r2, [pc, #32]	; (c0d03230 <strlen+0x60>)
c0d03210:	188a      	adds	r2, r1, r2
c0d03212:	438a      	bics	r2, r1
c0d03214:	4222      	tst	r2, r4
c0d03216:	d0f1      	beq.n	c0d031fc <strlen+0x2c>
c0d03218:	e000      	b.n	c0d0321c <strlen+0x4c>
c0d0321a:	3301      	adds	r3, #1
c0d0321c:	781a      	ldrb	r2, [r3, #0]
c0d0321e:	2a00      	cmp	r2, #0
c0d03220:	d1fb      	bne.n	c0d0321a <strlen+0x4a>
c0d03222:	1a18      	subs	r0, r3, r0
c0d03224:	bd10      	pop	{r4, pc}
c0d03226:	0003      	movs	r3, r0
c0d03228:	e7e1      	b.n	c0d031ee <strlen+0x1e>
c0d0322a:	2000      	movs	r0, #0
c0d0322c:	e7fa      	b.n	c0d03224 <strlen+0x54>
c0d0322e:	46c0      	nop			; (mov r8, r8)
c0d03230:	fefefeff 	.word	0xfefefeff
c0d03234:	80808080 	.word	0x80808080
c0d03238:	45544550 	.word	0x45544550
c0d0323c:	54455052 	.word	0x54455052
c0d03240:	45505245 	.word	0x45505245
c0d03244:	50524554 	.word	0x50524554
c0d03248:	52455445 	.word	0x52455445
c0d0324c:	45544550 	.word	0x45544550
c0d03250:	54455052 	.word	0x54455052
c0d03254:	45505245 	.word	0x45505245
c0d03258:	50524554 	.word	0x50524554
c0d0325c:	52455445 	.word	0x52455445
c0d03260:	45544550 	.word	0x45544550
c0d03264:	54455052 	.word	0x54455052
c0d03268:	45505245 	.word	0x45505245
c0d0326c:	50524554 	.word	0x50524554
c0d03270:	52455445 	.word	0x52455445
c0d03274:	45544550 	.word	0x45544550
c0d03278:	54455052 	.word	0x54455052
c0d0327c:	45505245 	.word	0x45505245
c0d03280:	50524554 	.word	0x50524554
c0d03284:	52455445 	.word	0x52455445
c0d03288:	00000052 	.word	0x00000052

c0d0328c <trits_mapping>:
c0d0328c:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d0329c:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d032ac:	00ff0100 000000ff 00010000 0001ff00     ................
c0d032bc:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d032cc:	00000100 01000101 000101ff 01010101     ................
c0d032dc:	00000001                                ....

c0d032e0 <bagl_ui_nanos_screen1>:
c0d032e0:	00000003 00800000 00000020 00000001     ........ .......
c0d032f0:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03318:	00000107 0080000c 00000020 00000000     ........ .......
c0d03328:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03350:	00030005 0007000c 00000007 00000000     ................
	...
c0d03368:	00070000 00000000 00000000 00000000     ................
	...
c0d03388:	00750005 0008000d 00000006 00000000     ..u.............
c0d03398:	00ffffff 00000000 00060000 00000000     ................
	...

c0d033c0 <bagl_ui_nanos_screen2>:
c0d033c0:	00000003 00800000 00000020 00000001     ........ .......
c0d033d0:	00000000 00ffffff 00000000 00000000     ................
	...
c0d033f8:	00000107 00800012 00000020 00000000     ........ .......
c0d03408:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03430:	00030005 0007000c 00000007 00000000     ................
	...
c0d03448:	00070000 00000000 00000000 00000000     ................
	...
c0d03468:	00750005 0008000d 00000006 00000000     ..u.............
c0d03478:	00ffffff 00000000 00060000 00000000     ................
	...

c0d034a0 <bagl_ui_sample_blue>:
c0d034a0:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d034b0:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d034d8:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d034e8:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03510:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03520:	00ffffff 001d2028 00002004 c0d03580     ....( ... ...5..
	...
c0d03548:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03558:	0041ccb4 00f9f9f9 0000a004 c0d0358c     ..A..........5..
c0d03568:	00000000 0037ae99 00f9f9f9 c0d01ffd     ......7.........
	...
c0d03580:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03591 <USBD_PRODUCT_FS_STRING>:
c0d03591:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d0359f <HID_ReportDesc>:
c0d0359f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d035af:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d035bf:	0000c008 11210900                                .....

c0d035c4 <USBD_HID_Desc>:
c0d035c4:	01112109 22220100 00011200                       .!...."".

c0d035cd <USBD_DeviceDesc>:
c0d035cd:	02000112 40000000 00012c97 02010200     .......@.,......
c0d035dd:	0d000103                                         ...

c0d035e0 <HID_Desc>:
c0d035e0:	c0d02c0d c0d02c1d c0d02c2d c0d02c3d     .,...,..-,..=,..
c0d035f0:	c0d02c4d c0d02c5d c0d02c6d 00000000     M,..],..m,......

c0d03600 <USBD_LangIDDesc>:
c0d03600:	04090304                                ....

c0d03604 <USBD_MANUFACTURER_STRING>:
c0d03604:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03612 <USB_SERIAL_STRING>:
c0d03612:	0030030a 00300030 2aef0031                       ..0.0.0.1.

c0d0361c <USBD_HID>:
c0d0361c:	c0d02aef c0d02b21 c0d02a53 00000000     .*..!+..S*......
	...
c0d03634:	c0d02b59 00000000 00000000 00000000     Y+..............
c0d03644:	c0d02c7d c0d02c7d c0d02c7d c0d02c8d     },..},..},...,..

c0d03654 <USBD_CfgDesc>:
c0d03654:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03664:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03674:	05070100 00400302 00000001              ......@.....

c0d03680 <USBD_DeviceQualifierDesc>:
c0d03680:	0200060a 40000000 00000001              .......@....

c0d0368c <_etext>:
	...

c0d036c0 <N_storage_real>:
	...
