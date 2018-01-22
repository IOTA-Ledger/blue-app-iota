
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
c0d00014:	f000 fe0c 	bl	c0d00c30 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fd58 	bl	c0d00acc <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f8df 	bl	c0d031e8 <setjmp>
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
c0d00040:	f000 ff9c 	bl	c0d00f7c <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fc7d 	bl	c0d01944 <pic>
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
c0d0005a:	f001 fc73 	bl	c0d01944 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fcc1 	bl	c0d019e8 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fdc8 	bl	c0d02bfc <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fdc5 	bl	c0d02bfc <USB_power>

            ui_idle();
c0d00072:	f001 ff59 	bl	c0d01f28 <ui_idle>

            IOTA_main();
c0d00076:	f000 fbc1 	bl	c0d007fc <IOTA_main>
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
c0d0008c:	f003 f8b8 	bl	c0d03200 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03700 	.word	0xc0d03700

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
c0d000ca:	f001 f9eb 	bl	c0d014a4 <snprintf>
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
c0d00192:	f002 fe7b 	bl	c0d02e8c <__aeabi_idiv>
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
c0d001c0:	f002 fdda 	bl	c0d02d78 <__aeabi_uidiv>
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
c0d001e4:	f000 f956 	bl	c0d00494 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001e8:	f000 f954 	bl	c0d00494 <kerl_initialize>
c0d001ec:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001ee:	4630      	mov	r0, r6
c0d001f0:	4621      	mov	r1, r4
c0d001f2:	462a      	mov	r2, r5
c0d001f4:	f002 ff68 	bl	c0d030c8 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001f8:	1970      	adds	r0, r6, r5
c0d001fa:	2130      	movs	r1, #48	; 0x30
c0d001fc:	1b4a      	subs	r2, r1, r5
c0d001fe:	460d      	mov	r5, r1
c0d00200:	9502      	str	r5, [sp, #8]
c0d00202:	4621      	mov	r1, r4
c0d00204:	f002 ff60 	bl	c0d030c8 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00208:	4630      	mov	r0, r6
c0d0020a:	4629      	mov	r1, r5
c0d0020c:	f000 f94e 	bl	c0d004ac <kerl_absorb_bytes>
c0d00210:	ac41      	add	r4, sp, #260	; 0x104
c0d00212:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00214:	4620      	mov	r0, r4
c0d00216:	4629      	mov	r1, r5
c0d00218:	f002 ff50 	bl	c0d030bc <__aeabi_memclr>
c0d0021c:	ae04      	add	r6, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021e:	491c      	ldr	r1, [pc, #112]	; (c0d00290 <get_seed+0xb8>)
c0d00220:	4479      	add	r1, pc
c0d00222:	2252      	movs	r2, #82	; 0x52
c0d00224:	4630      	mov	r0, r6
c0d00226:	f002 ff4f 	bl	c0d030c8 <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d0022a:	4630      	mov	r0, r6
c0d0022c:	4621      	mov	r1, r4
c0d0022e:	462a      	mov	r2, r5
c0d00230:	f000 f8a4 	bl	c0d0037c <chars_to_trytes>
c0d00234:	ae04      	add	r6, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00236:	21f3      	movs	r1, #243	; 0xf3
c0d00238:	4630      	mov	r0, r6
c0d0023a:	f002 ff3f 	bl	c0d030bc <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d0023e:	4620      	mov	r0, r4
c0d00240:	4631      	mov	r1, r6
c0d00242:	462a      	mov	r2, r5
c0d00244:	f000 f87c 	bl	c0d00340 <trytes_to_trits>
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
c0d00258:	f002 ff30 	bl	c0d030bc <__aeabi_memclr>
        trints_to_words_u_mem(seed_trints, words);
c0d0025c:	4620      	mov	r0, r4
c0d0025e:	4631      	mov	r1, r6
c0d00260:	f000 f8a2 	bl	c0d003a8 <trints_to_words_u_mem>
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
c0d00276:	f001 f915 	bl	c0d014a4 <snprintf>
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
c0d00290:	00003060 	.word	0x00003060

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

c0d00302 <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d00302:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00304:	af03      	add	r7, sp, #12
c0d00306:	b081      	sub	sp, #4
c0d00308:	2400      	movs	r4, #0
c0d0030a:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d0030c:	32ff      	adds	r2, #255	; 0xff
c0d0030e:	b253      	sxtb	r3, r2
c0d00310:	2b00      	cmp	r3, #0
c0d00312:	db0f      	blt.n	c0d00334 <bigint_cmp_bigint_u+0x32>
c0d00314:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00316:	009b      	lsls	r3, r3, #2
c0d00318:	58ce      	ldr	r6, [r1, r3]
c0d0031a:	58c4      	ldr	r4, [r0, r3]
c0d0031c:	2301      	movs	r3, #1
c0d0031e:	42b4      	cmp	r4, r6
c0d00320:	d80b      	bhi.n	c0d0033a <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00322:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00324:	42b4      	cmp	r4, r6
c0d00326:	d307      	bcc.n	c0d00338 <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00328:	b253      	sxtb	r3, r2
c0d0032a:	42ab      	cmp	r3, r5
c0d0032c:	461a      	mov	r2, r3
c0d0032e:	dcf2      	bgt.n	c0d00316 <bigint_cmp_bigint_u+0x14>
c0d00330:	9b00      	ldr	r3, [sp, #0]
c0d00332:	e002      	b.n	c0d0033a <bigint_cmp_bigint_u+0x38>
c0d00334:	4623      	mov	r3, r4
c0d00336:	e000      	b.n	c0d0033a <bigint_cmp_bigint_u+0x38>
c0d00338:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d0033a:	4618      	mov	r0, r3
c0d0033c:	b001      	add	sp, #4
c0d0033e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00340 <trytes_to_trits>:
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00340:	b5b0      	push	{r4, r5, r7, lr}
c0d00342:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00344:	2a00      	cmp	r2, #0
c0d00346:	d015      	beq.n	c0d00374 <trytes_to_trits+0x34>
c0d00348:	4b0b      	ldr	r3, [pc, #44]	; (c0d00378 <trytes_to_trits+0x38>)
c0d0034a:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0034c:	240d      	movs	r4, #13
c0d0034e:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00350:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00352:	062d      	lsls	r5, r5, #24
c0d00354:	192c      	adds	r4, r5, r4
c0d00356:	1624      	asrs	r4, r4, #24
c0d00358:	2503      	movs	r5, #3
c0d0035a:	4365      	muls	r5, r4
c0d0035c:	5d5c      	ldrb	r4, [r3, r5]
c0d0035e:	700c      	strb	r4, [r1, #0]
c0d00360:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00362:	7865      	ldrb	r5, [r4, #1]
c0d00364:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d00366:	78a4      	ldrb	r4, [r4, #2]
c0d00368:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0036a:	1e52      	subs	r2, r2, #1
c0d0036c:	1cc9      	adds	r1, r1, #3
c0d0036e:	1c40      	adds	r0, r0, #1
c0d00370:	2a00      	cmp	r2, #0
c0d00372:	d1eb      	bne.n	c0d0034c <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00374:	2000      	movs	r0, #0
c0d00376:	bdb0      	pop	{r4, r5, r7, pc}
c0d00378:	00002f8a 	.word	0x00002f8a

c0d0037c <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d0037c:	b5d0      	push	{r4, r6, r7, lr}
c0d0037e:	af02      	add	r7, sp, #8
c0d00380:	e00e      	b.n	c0d003a0 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00382:	7803      	ldrb	r3, [r0, #0]
c0d00384:	b25b      	sxtb	r3, r3
c0d00386:	2400      	movs	r4, #0
c0d00388:	2b39      	cmp	r3, #57	; 0x39
c0d0038a:	d005      	beq.n	c0d00398 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d0038c:	2b4e      	cmp	r3, #78	; 0x4e
c0d0038e:	db01      	blt.n	c0d00394 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00390:	33a5      	adds	r3, #165	; 0xa5
c0d00392:	e000      	b.n	c0d00396 <chars_to_trytes+0x1a>
c0d00394:	33c0      	adds	r3, #192	; 0xc0
c0d00396:	461c      	mov	r4, r3
c0d00398:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0039a:	1e52      	subs	r2, r2, #1
c0d0039c:	1c40      	adds	r0, r0, #1
c0d0039e:	1c49      	adds	r1, r1, #1
c0d003a0:	2a00      	cmp	r2, #0
c0d003a2:	d1ee      	bne.n	c0d00382 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d003a4:	2000      	movs	r0, #0
c0d003a6:	bdd0      	pop	{r4, r6, r7, pc}

c0d003a8 <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d003a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003aa:	af03      	add	r7, sp, #12
c0d003ac:	b089      	sub	sp, #36	; 0x24
c0d003ae:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d003b0:	2130      	movs	r1, #48	; 0x30
c0d003b2:	9000      	str	r0, [sp, #0]
c0d003b4:	5640      	ldrsb	r0, [r0, r1]
c0d003b6:	a907      	add	r1, sp, #28
c0d003b8:	2203      	movs	r2, #3
c0d003ba:	f7ff fed5 	bl	c0d00168 <trint_to_trits>
c0d003be:	2001      	movs	r0, #1
c0d003c0:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d003c2:	9606      	str	r6, [sp, #24]
c0d003c4:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d003c6:	2105      	movs	r1, #5
c0d003c8:	4620      	mov	r0, r4
c0d003ca:	f002 fe45 	bl	c0d03058 <__aeabi_idivmod>
c0d003ce:	460e      	mov	r6, r1
c0d003d0:	2e04      	cmp	r6, #4
c0d003d2:	d10b      	bne.n	c0d003ec <trints_to_words_u_mem+0x44>
c0d003d4:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d003d6:	4620      	mov	r0, r4
c0d003d8:	4629      	mov	r1, r5
c0d003da:	f002 fd57 	bl	c0d02e8c <__aeabi_idiv>
c0d003de:	b2c0      	uxtb	r0, r0
c0d003e0:	9900      	ldr	r1, [sp, #0]
c0d003e2:	5608      	ldrsb	r0, [r1, r0]
c0d003e4:	a907      	add	r1, sp, #28
c0d003e6:	462a      	mov	r2, r5
c0d003e8:	f7ff febe 	bl	c0d00168 <trint_to_trits>
c0d003ec:	a807      	add	r0, sp, #28

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d003ee:	5d80      	ldrb	r0, [r0, r6]
c0d003f0:	1c41      	adds	r1, r0, #1
c0d003f2:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d003f4:	9804      	ldr	r0, [sp, #16]
c0d003f6:	2800      	cmp	r0, #0
c0d003f8:	d022      	beq.n	c0d00440 <trints_to_words_u_mem+0x98>
c0d003fa:	9101      	str	r1, [sp, #4]
c0d003fc:	9402      	str	r4, [sp, #8]
c0d003fe:	2500      	movs	r5, #0
c0d00400:	462e      	mov	r6, r5
c0d00402:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d00404:	00b1      	lsls	r1, r6, #2
c0d00406:	9105      	str	r1, [sp, #20]
c0d00408:	9806      	ldr	r0, [sp, #24]
c0d0040a:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d0040c:	2203      	movs	r2, #3
c0d0040e:	9c03      	ldr	r4, [sp, #12]
c0d00410:	4621      	mov	r1, r4
c0d00412:	4623      	mov	r3, r4
c0d00414:	f002 fe26 	bl	c0d03064 <__aeabi_lmul>
c0d00418:	9b04      	ldr	r3, [sp, #16]
c0d0041a:	1940      	adds	r0, r0, r5
c0d0041c:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d0041e:	9a06      	ldr	r2, [sp, #24]
c0d00420:	9c05      	ldr	r4, [sp, #20]
c0d00422:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00424:	1c76      	adds	r6, r6, #1
c0d00426:	42b3      	cmp	r3, r6
c0d00428:	460d      	mov	r5, r1
c0d0042a:	d1eb      	bne.n	c0d00404 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d0042c:	2900      	cmp	r1, #0
c0d0042e:	d004      	beq.n	c0d0043a <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d00430:	0098      	lsls	r0, r3, #2
c0d00432:	9a06      	ldr	r2, [sp, #24]
c0d00434:	5011      	str	r1, [r2, r0]
                size++;
c0d00436:	1c5d      	adds	r5, r3, #1
c0d00438:	e000      	b.n	c0d0043c <trints_to_words_u_mem+0x94>
c0d0043a:	461d      	mov	r5, r3
c0d0043c:	9c02      	ldr	r4, [sp, #8]
c0d0043e:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00440:	b2c9      	uxtb	r1, r1
c0d00442:	220c      	movs	r2, #12
c0d00444:	9e06      	ldr	r6, [sp, #24]
c0d00446:	4630      	mov	r0, r6
c0d00448:	f7ff ff24 	bl	c0d00294 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d0044c:	42a8      	cmp	r0, r5
c0d0044e:	d800      	bhi.n	c0d00452 <trints_to_words_u_mem+0xaa>
c0d00450:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00452:	1e61      	subs	r1, r4, #1
c0d00454:	2c00      	cmp	r4, #0
c0d00456:	460c      	mov	r4, r1
c0d00458:	dcb4      	bgt.n	c0d003c4 <trints_to_words_u_mem+0x1c>
            if(sz > size) size = sz;
        }
    }

    // bigint_cmp_bigint_u seems to hang
    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d0045a:	480d      	ldr	r0, [pc, #52]	; (c0d00490 <trints_to_words_u_mem+0xe8>)
c0d0045c:	220c      	movs	r2, #12
c0d0045e:	4631      	mov	r1, r6
c0d00460:	f7ff ff4f 	bl	c0d00302 <bigint_cmp_bigint_u>
c0d00464:	2000      	movs	r0, #0
        // bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d00466:	0081      	lsls	r1, r0, #2
c0d00468:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d0046a:	1a73      	subs	r3, r6, r1
c0d0046c:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d0046e:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d00470:	62da      	str	r2, [r3, #44]	; 0x2c
        // bigint_not_u(tmp, 12);
        // bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d00472:	1c40      	adds	r0, r0, #1
c0d00474:	2806      	cmp	r0, #6
c0d00476:	d1f6      	bne.n	c0d00466 <trints_to_words_u_mem+0xbe>
c0d00478:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d0047a:	0081      	lsls	r1, r0, #2
c0d0047c:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d0047e:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00480:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d00482:	1c40      	adds	r0, r0, #1
c0d00484:	280c      	cmp	r0, #12
c0d00486:	d1f8      	bne.n	c0d0047a <trints_to_words_u_mem+0xd2>
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
c0d00488:	2000      	movs	r0, #0
c0d0048a:	b009      	add	sp, #36	; 0x24
c0d0048c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0048e:	46c0      	nop			; (mov r8, r8)
c0d00490:	d0000000 	.word	0xd0000000

c0d00494 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00494:	b580      	push	{r7, lr}
c0d00496:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00498:	2003      	movs	r0, #3
c0d0049a:	01c1      	lsls	r1, r0, #7
c0d0049c:	4802      	ldr	r0, [pc, #8]	; (c0d004a8 <kerl_initialize+0x14>)
c0d0049e:	f001 fafd 	bl	c0d01a9c <cx_keccak_init>
    return 0;
c0d004a2:	2000      	movs	r0, #0
c0d004a4:	bd80      	pop	{r7, pc}
c0d004a6:	46c0      	nop			; (mov r8, r8)
c0d004a8:	20001840 	.word	0x20001840

c0d004ac <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d004ac:	b580      	push	{r7, lr}
c0d004ae:	af00      	add	r7, sp, #0
c0d004b0:	b082      	sub	sp, #8
c0d004b2:	460b      	mov	r3, r1
c0d004b4:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d004b6:	4805      	ldr	r0, [pc, #20]	; (c0d004cc <kerl_absorb_bytes+0x20>)
c0d004b8:	4669      	mov	r1, sp
c0d004ba:	6008      	str	r0, [r1, #0]
c0d004bc:	4804      	ldr	r0, [pc, #16]	; (c0d004d0 <kerl_absorb_bytes+0x24>)
c0d004be:	2101      	movs	r1, #1
c0d004c0:	f001 fb0a 	bl	c0d01ad8 <cx_hash>
c0d004c4:	2000      	movs	r0, #0
    return 0;
c0d004c6:	b002      	add	sp, #8
c0d004c8:	bd80      	pop	{r7, pc}
c0d004ca:	46c0      	nop			; (mov r8, r8)
c0d004cc:	200019e8 	.word	0x200019e8
c0d004d0:	20001840 	.word	0x20001840

c0d004d4 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d004d4:	b580      	push	{r7, lr}
c0d004d6:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d004d8:	4804      	ldr	r0, [pc, #16]	; (c0d004ec <nvram_is_init+0x18>)
c0d004da:	f001 fa33 	bl	c0d01944 <pic>
c0d004de:	7801      	ldrb	r1, [r0, #0]
c0d004e0:	2000      	movs	r0, #0
c0d004e2:	2901      	cmp	r1, #1
c0d004e4:	d100      	bne.n	c0d004e8 <nvram_is_init+0x14>
c0d004e6:	4608      	mov	r0, r1
    else return true;
}
c0d004e8:	bd80      	pop	{r7, pc}
c0d004ea:	46c0      	nop			; (mov r8, r8)
c0d004ec:	c0d03700 	.word	0xc0d03700

c0d004f0 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d004f0:	b5b0      	push	{r4, r5, r7, lr}
c0d004f2:	af02      	add	r7, sp, #8
c0d004f4:	4605      	mov	r5, r0
c0d004f6:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d004f8:	4028      	ands	r0, r5
c0d004fa:	2400      	movs	r4, #0
c0d004fc:	2801      	cmp	r0, #1
c0d004fe:	d013      	beq.n	c0d00528 <io_exchange_al+0x38>
c0d00500:	2802      	cmp	r0, #2
c0d00502:	d113      	bne.n	c0d0052c <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00504:	2900      	cmp	r1, #0
c0d00506:	d008      	beq.n	c0d0051a <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00508:	480b      	ldr	r0, [pc, #44]	; (c0d00538 <io_exchange_al+0x48>)
c0d0050a:	f001 fbd7 	bl	c0d01cbc <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d0050e:	b268      	sxtb	r0, r5
c0d00510:	2800      	cmp	r0, #0
c0d00512:	da09      	bge.n	c0d00528 <io_exchange_al+0x38>
                reset();
c0d00514:	f001 fa4c 	bl	c0d019b0 <reset>
c0d00518:	e006      	b.n	c0d00528 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d0051a:	2041      	movs	r0, #65	; 0x41
c0d0051c:	0081      	lsls	r1, r0, #2
c0d0051e:	4806      	ldr	r0, [pc, #24]	; (c0d00538 <io_exchange_al+0x48>)
c0d00520:	2200      	movs	r2, #0
c0d00522:	f001 fc05 	bl	c0d01d30 <io_seproxyhal_spi_recv>
c0d00526:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00528:	4620      	mov	r0, r4
c0d0052a:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d0052c:	4803      	ldr	r0, [pc, #12]	; (c0d0053c <io_exchange_al+0x4c>)
c0d0052e:	6800      	ldr	r0, [r0, #0]
c0d00530:	2102      	movs	r1, #2
c0d00532:	f002 fe65 	bl	c0d03200 <longjmp>
c0d00536:	46c0      	nop			; (mov r8, r8)
c0d00538:	20001c08 	.word	0x20001c08
c0d0053c:	20001bb8 	.word	0x20001bb8

c0d00540 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00540:	b580      	push	{r7, lr}
c0d00542:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00544:	f000 fe8e 	bl	c0d01264 <io_seproxyhal_display_default>
}
c0d00548:	bd80      	pop	{r7, pc}
	...

c0d0054c <io_event>:

unsigned char io_event(unsigned char channel) {
c0d0054c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0054e:	af03      	add	r7, sp, #12
c0d00550:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00552:	48a6      	ldr	r0, [pc, #664]	; (c0d007ec <io_event+0x2a0>)
c0d00554:	7800      	ldrb	r0, [r0, #0]
c0d00556:	2805      	cmp	r0, #5
c0d00558:	d02e      	beq.n	c0d005b8 <io_event+0x6c>
c0d0055a:	280d      	cmp	r0, #13
c0d0055c:	d04e      	beq.n	c0d005fc <io_event+0xb0>
c0d0055e:	280c      	cmp	r0, #12
c0d00560:	d000      	beq.n	c0d00564 <io_event+0x18>
c0d00562:	e13a      	b.n	c0d007da <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00564:	4ea2      	ldr	r6, [pc, #648]	; (c0d007f0 <io_event+0x2a4>)
c0d00566:	2001      	movs	r0, #1
c0d00568:	7630      	strb	r0, [r6, #24]
c0d0056a:	2500      	movs	r5, #0
c0d0056c:	61f5      	str	r5, [r6, #28]
c0d0056e:	4634      	mov	r4, r6
c0d00570:	3418      	adds	r4, #24
c0d00572:	4620      	mov	r0, r4
c0d00574:	f001 fb68 	bl	c0d01c48 <os_ux>
c0d00578:	61f0      	str	r0, [r6, #28]
c0d0057a:	499e      	ldr	r1, [pc, #632]	; (c0d007f4 <io_event+0x2a8>)
c0d0057c:	4288      	cmp	r0, r1
c0d0057e:	d100      	bne.n	c0d00582 <io_event+0x36>
c0d00580:	e12b      	b.n	c0d007da <io_event+0x28e>
c0d00582:	2800      	cmp	r0, #0
c0d00584:	d100      	bne.n	c0d00588 <io_event+0x3c>
c0d00586:	e128      	b.n	c0d007da <io_event+0x28e>
c0d00588:	499b      	ldr	r1, [pc, #620]	; (c0d007f8 <io_event+0x2ac>)
c0d0058a:	4288      	cmp	r0, r1
c0d0058c:	d000      	beq.n	c0d00590 <io_event+0x44>
c0d0058e:	e0ac      	b.n	c0d006ea <io_event+0x19e>
c0d00590:	2003      	movs	r0, #3
c0d00592:	7630      	strb	r0, [r6, #24]
c0d00594:	61f5      	str	r5, [r6, #28]
c0d00596:	4620      	mov	r0, r4
c0d00598:	f001 fb56 	bl	c0d01c48 <os_ux>
c0d0059c:	61f0      	str	r0, [r6, #28]
c0d0059e:	f000 fd17 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d005a2:	60b5      	str	r5, [r6, #8]
c0d005a4:	6830      	ldr	r0, [r6, #0]
c0d005a6:	2800      	cmp	r0, #0
c0d005a8:	d100      	bne.n	c0d005ac <io_event+0x60>
c0d005aa:	e116      	b.n	c0d007da <io_event+0x28e>
c0d005ac:	69f0      	ldr	r0, [r6, #28]
c0d005ae:	4991      	ldr	r1, [pc, #580]	; (c0d007f4 <io_event+0x2a8>)
c0d005b0:	4288      	cmp	r0, r1
c0d005b2:	d000      	beq.n	c0d005b6 <io_event+0x6a>
c0d005b4:	e096      	b.n	c0d006e4 <io_event+0x198>
c0d005b6:	e110      	b.n	c0d007da <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d005b8:	4d8d      	ldr	r5, [pc, #564]	; (c0d007f0 <io_event+0x2a4>)
c0d005ba:	2001      	movs	r0, #1
c0d005bc:	7628      	strb	r0, [r5, #24]
c0d005be:	2600      	movs	r6, #0
c0d005c0:	61ee      	str	r6, [r5, #28]
c0d005c2:	462c      	mov	r4, r5
c0d005c4:	3418      	adds	r4, #24
c0d005c6:	4620      	mov	r0, r4
c0d005c8:	f001 fb3e 	bl	c0d01c48 <os_ux>
c0d005cc:	4601      	mov	r1, r0
c0d005ce:	61e9      	str	r1, [r5, #28]
c0d005d0:	4889      	ldr	r0, [pc, #548]	; (c0d007f8 <io_event+0x2ac>)
c0d005d2:	4281      	cmp	r1, r0
c0d005d4:	d15d      	bne.n	c0d00692 <io_event+0x146>
c0d005d6:	2003      	movs	r0, #3
c0d005d8:	7628      	strb	r0, [r5, #24]
c0d005da:	61ee      	str	r6, [r5, #28]
c0d005dc:	4620      	mov	r0, r4
c0d005de:	f001 fb33 	bl	c0d01c48 <os_ux>
c0d005e2:	61e8      	str	r0, [r5, #28]
c0d005e4:	f000 fcf4 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d005e8:	60ae      	str	r6, [r5, #8]
c0d005ea:	6828      	ldr	r0, [r5, #0]
c0d005ec:	2800      	cmp	r0, #0
c0d005ee:	d100      	bne.n	c0d005f2 <io_event+0xa6>
c0d005f0:	e0f3      	b.n	c0d007da <io_event+0x28e>
c0d005f2:	69e8      	ldr	r0, [r5, #28]
c0d005f4:	497f      	ldr	r1, [pc, #508]	; (c0d007f4 <io_event+0x2a8>)
c0d005f6:	4288      	cmp	r0, r1
c0d005f8:	d148      	bne.n	c0d0068c <io_event+0x140>
c0d005fa:	e0ee      	b.n	c0d007da <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d005fc:	4d7c      	ldr	r5, [pc, #496]	; (c0d007f0 <io_event+0x2a4>)
c0d005fe:	6868      	ldr	r0, [r5, #4]
c0d00600:	68a9      	ldr	r1, [r5, #8]
c0d00602:	4281      	cmp	r1, r0
c0d00604:	d300      	bcc.n	c0d00608 <io_event+0xbc>
c0d00606:	e0e8      	b.n	c0d007da <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00608:	2001      	movs	r0, #1
c0d0060a:	7628      	strb	r0, [r5, #24]
c0d0060c:	2600      	movs	r6, #0
c0d0060e:	61ee      	str	r6, [r5, #28]
c0d00610:	462c      	mov	r4, r5
c0d00612:	3418      	adds	r4, #24
c0d00614:	4620      	mov	r0, r4
c0d00616:	f001 fb17 	bl	c0d01c48 <os_ux>
c0d0061a:	61e8      	str	r0, [r5, #28]
c0d0061c:	4975      	ldr	r1, [pc, #468]	; (c0d007f4 <io_event+0x2a8>)
c0d0061e:	4288      	cmp	r0, r1
c0d00620:	d100      	bne.n	c0d00624 <io_event+0xd8>
c0d00622:	e0da      	b.n	c0d007da <io_event+0x28e>
c0d00624:	2800      	cmp	r0, #0
c0d00626:	d100      	bne.n	c0d0062a <io_event+0xde>
c0d00628:	e0d7      	b.n	c0d007da <io_event+0x28e>
c0d0062a:	4973      	ldr	r1, [pc, #460]	; (c0d007f8 <io_event+0x2ac>)
c0d0062c:	4288      	cmp	r0, r1
c0d0062e:	d000      	beq.n	c0d00632 <io_event+0xe6>
c0d00630:	e08d      	b.n	c0d0074e <io_event+0x202>
c0d00632:	2003      	movs	r0, #3
c0d00634:	7628      	strb	r0, [r5, #24]
c0d00636:	61ee      	str	r6, [r5, #28]
c0d00638:	4620      	mov	r0, r4
c0d0063a:	f001 fb05 	bl	c0d01c48 <os_ux>
c0d0063e:	61e8      	str	r0, [r5, #28]
c0d00640:	f000 fcc6 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d00644:	60ae      	str	r6, [r5, #8]
c0d00646:	6828      	ldr	r0, [r5, #0]
c0d00648:	2800      	cmp	r0, #0
c0d0064a:	d100      	bne.n	c0d0064e <io_event+0x102>
c0d0064c:	e0c5      	b.n	c0d007da <io_event+0x28e>
c0d0064e:	69e8      	ldr	r0, [r5, #28]
c0d00650:	4968      	ldr	r1, [pc, #416]	; (c0d007f4 <io_event+0x2a8>)
c0d00652:	4288      	cmp	r0, r1
c0d00654:	d178      	bne.n	c0d00748 <io_event+0x1fc>
c0d00656:	e0c0      	b.n	c0d007da <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00658:	6868      	ldr	r0, [r5, #4]
c0d0065a:	4286      	cmp	r6, r0
c0d0065c:	d300      	bcc.n	c0d00660 <io_event+0x114>
c0d0065e:	e0bc      	b.n	c0d007da <io_event+0x28e>
c0d00660:	f001 fb4a 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d00664:	2800      	cmp	r0, #0
c0d00666:	d000      	beq.n	c0d0066a <io_event+0x11e>
c0d00668:	e0b7      	b.n	c0d007da <io_event+0x28e>
c0d0066a:	68a8      	ldr	r0, [r5, #8]
c0d0066c:	68e9      	ldr	r1, [r5, #12]
c0d0066e:	2438      	movs	r4, #56	; 0x38
c0d00670:	4360      	muls	r0, r4
c0d00672:	682a      	ldr	r2, [r5, #0]
c0d00674:	1810      	adds	r0, r2, r0
c0d00676:	2900      	cmp	r1, #0
c0d00678:	d100      	bne.n	c0d0067c <io_event+0x130>
c0d0067a:	e085      	b.n	c0d00788 <io_event+0x23c>
c0d0067c:	4788      	blx	r1
c0d0067e:	2800      	cmp	r0, #0
c0d00680:	d000      	beq.n	c0d00684 <io_event+0x138>
c0d00682:	e081      	b.n	c0d00788 <io_event+0x23c>
c0d00684:	68a8      	ldr	r0, [r5, #8]
c0d00686:	1c46      	adds	r6, r0, #1
c0d00688:	60ae      	str	r6, [r5, #8]
c0d0068a:	6828      	ldr	r0, [r5, #0]
c0d0068c:	2800      	cmp	r0, #0
c0d0068e:	d1e3      	bne.n	c0d00658 <io_event+0x10c>
c0d00690:	e0a3      	b.n	c0d007da <io_event+0x28e>
c0d00692:	6928      	ldr	r0, [r5, #16]
c0d00694:	2800      	cmp	r0, #0
c0d00696:	d100      	bne.n	c0d0069a <io_event+0x14e>
c0d00698:	e09f      	b.n	c0d007da <io_event+0x28e>
c0d0069a:	4a56      	ldr	r2, [pc, #344]	; (c0d007f4 <io_event+0x2a8>)
c0d0069c:	4291      	cmp	r1, r2
c0d0069e:	d100      	bne.n	c0d006a2 <io_event+0x156>
c0d006a0:	e09b      	b.n	c0d007da <io_event+0x28e>
c0d006a2:	2900      	cmp	r1, #0
c0d006a4:	d100      	bne.n	c0d006a8 <io_event+0x15c>
c0d006a6:	e098      	b.n	c0d007da <io_event+0x28e>
c0d006a8:	4950      	ldr	r1, [pc, #320]	; (c0d007ec <io_event+0x2a0>)
c0d006aa:	78c9      	ldrb	r1, [r1, #3]
c0d006ac:	0849      	lsrs	r1, r1, #1
c0d006ae:	f000 fe1b 	bl	c0d012e8 <io_seproxyhal_button_push>
c0d006b2:	e092      	b.n	c0d007da <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d006b4:	6870      	ldr	r0, [r6, #4]
c0d006b6:	4285      	cmp	r5, r0
c0d006b8:	d300      	bcc.n	c0d006bc <io_event+0x170>
c0d006ba:	e08e      	b.n	c0d007da <io_event+0x28e>
c0d006bc:	f001 fb1c 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d006c0:	2800      	cmp	r0, #0
c0d006c2:	d000      	beq.n	c0d006c6 <io_event+0x17a>
c0d006c4:	e089      	b.n	c0d007da <io_event+0x28e>
c0d006c6:	68b0      	ldr	r0, [r6, #8]
c0d006c8:	68f1      	ldr	r1, [r6, #12]
c0d006ca:	2438      	movs	r4, #56	; 0x38
c0d006cc:	4360      	muls	r0, r4
c0d006ce:	6832      	ldr	r2, [r6, #0]
c0d006d0:	1810      	adds	r0, r2, r0
c0d006d2:	2900      	cmp	r1, #0
c0d006d4:	d076      	beq.n	c0d007c4 <io_event+0x278>
c0d006d6:	4788      	blx	r1
c0d006d8:	2800      	cmp	r0, #0
c0d006da:	d173      	bne.n	c0d007c4 <io_event+0x278>
c0d006dc:	68b0      	ldr	r0, [r6, #8]
c0d006de:	1c45      	adds	r5, r0, #1
c0d006e0:	60b5      	str	r5, [r6, #8]
c0d006e2:	6830      	ldr	r0, [r6, #0]
c0d006e4:	2800      	cmp	r0, #0
c0d006e6:	d1e5      	bne.n	c0d006b4 <io_event+0x168>
c0d006e8:	e077      	b.n	c0d007da <io_event+0x28e>
c0d006ea:	88b0      	ldrh	r0, [r6, #4]
c0d006ec:	9004      	str	r0, [sp, #16]
c0d006ee:	6830      	ldr	r0, [r6, #0]
c0d006f0:	9003      	str	r0, [sp, #12]
c0d006f2:	483e      	ldr	r0, [pc, #248]	; (c0d007ec <io_event+0x2a0>)
c0d006f4:	4601      	mov	r1, r0
c0d006f6:	79cc      	ldrb	r4, [r1, #7]
c0d006f8:	798b      	ldrb	r3, [r1, #6]
c0d006fa:	794d      	ldrb	r5, [r1, #5]
c0d006fc:	790a      	ldrb	r2, [r1, #4]
c0d006fe:	4630      	mov	r0, r6
c0d00700:	78ce      	ldrb	r6, [r1, #3]
c0d00702:	68c1      	ldr	r1, [r0, #12]
c0d00704:	4668      	mov	r0, sp
c0d00706:	6006      	str	r6, [r0, #0]
c0d00708:	6041      	str	r1, [r0, #4]
c0d0070a:	0212      	lsls	r2, r2, #8
c0d0070c:	432a      	orrs	r2, r5
c0d0070e:	021b      	lsls	r3, r3, #8
c0d00710:	4323      	orrs	r3, r4
c0d00712:	9803      	ldr	r0, [sp, #12]
c0d00714:	9904      	ldr	r1, [sp, #16]
c0d00716:	f000 fcd5 	bl	c0d010c4 <io_seproxyhal_touch_element_callback>
c0d0071a:	e05e      	b.n	c0d007da <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d0071c:	6868      	ldr	r0, [r5, #4]
c0d0071e:	4286      	cmp	r6, r0
c0d00720:	d25b      	bcs.n	c0d007da <io_event+0x28e>
c0d00722:	f001 fae9 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d00726:	2800      	cmp	r0, #0
c0d00728:	d157      	bne.n	c0d007da <io_event+0x28e>
c0d0072a:	68a8      	ldr	r0, [r5, #8]
c0d0072c:	68e9      	ldr	r1, [r5, #12]
c0d0072e:	2438      	movs	r4, #56	; 0x38
c0d00730:	4360      	muls	r0, r4
c0d00732:	682a      	ldr	r2, [r5, #0]
c0d00734:	1810      	adds	r0, r2, r0
c0d00736:	2900      	cmp	r1, #0
c0d00738:	d026      	beq.n	c0d00788 <io_event+0x23c>
c0d0073a:	4788      	blx	r1
c0d0073c:	2800      	cmp	r0, #0
c0d0073e:	d123      	bne.n	c0d00788 <io_event+0x23c>
c0d00740:	68a8      	ldr	r0, [r5, #8]
c0d00742:	1c46      	adds	r6, r0, #1
c0d00744:	60ae      	str	r6, [r5, #8]
c0d00746:	6828      	ldr	r0, [r5, #0]
c0d00748:	2800      	cmp	r0, #0
c0d0074a:	d1e7      	bne.n	c0d0071c <io_event+0x1d0>
c0d0074c:	e045      	b.n	c0d007da <io_event+0x28e>
c0d0074e:	6828      	ldr	r0, [r5, #0]
c0d00750:	2800      	cmp	r0, #0
c0d00752:	d030      	beq.n	c0d007b6 <io_event+0x26a>
c0d00754:	68a8      	ldr	r0, [r5, #8]
c0d00756:	6869      	ldr	r1, [r5, #4]
c0d00758:	4288      	cmp	r0, r1
c0d0075a:	d22c      	bcs.n	c0d007b6 <io_event+0x26a>
c0d0075c:	f001 facc 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d00760:	2800      	cmp	r0, #0
c0d00762:	d128      	bne.n	c0d007b6 <io_event+0x26a>
c0d00764:	68a8      	ldr	r0, [r5, #8]
c0d00766:	68e9      	ldr	r1, [r5, #12]
c0d00768:	2438      	movs	r4, #56	; 0x38
c0d0076a:	4360      	muls	r0, r4
c0d0076c:	682a      	ldr	r2, [r5, #0]
c0d0076e:	1810      	adds	r0, r2, r0
c0d00770:	2900      	cmp	r1, #0
c0d00772:	d015      	beq.n	c0d007a0 <io_event+0x254>
c0d00774:	4788      	blx	r1
c0d00776:	2800      	cmp	r0, #0
c0d00778:	d112      	bne.n	c0d007a0 <io_event+0x254>
c0d0077a:	68a8      	ldr	r0, [r5, #8]
c0d0077c:	1c40      	adds	r0, r0, #1
c0d0077e:	60a8      	str	r0, [r5, #8]
c0d00780:	6829      	ldr	r1, [r5, #0]
c0d00782:	2900      	cmp	r1, #0
c0d00784:	d1e7      	bne.n	c0d00756 <io_event+0x20a>
c0d00786:	e016      	b.n	c0d007b6 <io_event+0x26a>
c0d00788:	2801      	cmp	r0, #1
c0d0078a:	d103      	bne.n	c0d00794 <io_event+0x248>
c0d0078c:	68a8      	ldr	r0, [r5, #8]
c0d0078e:	4344      	muls	r4, r0
c0d00790:	6828      	ldr	r0, [r5, #0]
c0d00792:	1900      	adds	r0, r0, r4
c0d00794:	f000 fd66 	bl	c0d01264 <io_seproxyhal_display_default>
c0d00798:	68a8      	ldr	r0, [r5, #8]
c0d0079a:	1c40      	adds	r0, r0, #1
c0d0079c:	60a8      	str	r0, [r5, #8]
c0d0079e:	e01c      	b.n	c0d007da <io_event+0x28e>
c0d007a0:	2801      	cmp	r0, #1
c0d007a2:	d103      	bne.n	c0d007ac <io_event+0x260>
c0d007a4:	68a8      	ldr	r0, [r5, #8]
c0d007a6:	4344      	muls	r4, r0
c0d007a8:	6828      	ldr	r0, [r5, #0]
c0d007aa:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d007ac:	f000 fd5a 	bl	c0d01264 <io_seproxyhal_display_default>
c0d007b0:	68a8      	ldr	r0, [r5, #8]
c0d007b2:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d007b4:	60a8      	str	r0, [r5, #8]
c0d007b6:	6868      	ldr	r0, [r5, #4]
c0d007b8:	68a9      	ldr	r1, [r5, #8]
c0d007ba:	4281      	cmp	r1, r0
c0d007bc:	d30d      	bcc.n	c0d007da <io_event+0x28e>
c0d007be:	f001 fa9b 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d007c2:	e00a      	b.n	c0d007da <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d007c4:	2801      	cmp	r0, #1
c0d007c6:	d103      	bne.n	c0d007d0 <io_event+0x284>
c0d007c8:	68b0      	ldr	r0, [r6, #8]
c0d007ca:	4344      	muls	r4, r0
c0d007cc:	6830      	ldr	r0, [r6, #0]
c0d007ce:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d007d0:	f000 fd48 	bl	c0d01264 <io_seproxyhal_display_default>
c0d007d4:	68b0      	ldr	r0, [r6, #8]
c0d007d6:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d007d8:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d007da:	f001 fa8d 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d007de:	2800      	cmp	r0, #0
c0d007e0:	d101      	bne.n	c0d007e6 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d007e2:	f000 fac9 	bl	c0d00d78 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d007e6:	2001      	movs	r0, #1
c0d007e8:	b005      	add	sp, #20
c0d007ea:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d007ec:	20001a18 	.word	0x20001a18
c0d007f0:	20001a98 	.word	0x20001a98
c0d007f4:	b0105044 	.word	0xb0105044
c0d007f8:	b0105055 	.word	0xb0105055

c0d007fc <IOTA_main>:





static void IOTA_main(void) {
c0d007fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007fe:	af03      	add	r7, sp, #12
c0d00800:	b0dd      	sub	sp, #372	; 0x174
c0d00802:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00804:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00806:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00808:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d0080a:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00a90 <IOTA_main+0x294>)
c0d0080c:	2110      	movs	r1, #16
c0d0080e:	2203      	movs	r2, #3
c0d00810:	9109      	str	r1, [sp, #36]	; 0x24
c0d00812:	9208      	str	r2, [sp, #32]
c0d00814:	f7ff fc46 	bl	c0d000a4 <write_debug>
c0d00818:	a80e      	add	r0, sp, #56	; 0x38
c0d0081a:	304d      	adds	r0, #77	; 0x4d
c0d0081c:	9007      	str	r0, [sp, #28]
c0d0081e:	a80b      	add	r0, sp, #44	; 0x2c
c0d00820:	1dc1      	adds	r1, r0, #7
c0d00822:	9106      	str	r1, [sp, #24]
c0d00824:	1d00      	adds	r0, r0, #4
c0d00826:	9005      	str	r0, [sp, #20]
c0d00828:	4e9d      	ldr	r6, [pc, #628]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d0082a:	6830      	ldr	r0, [r6, #0]
c0d0082c:	e08d      	b.n	c0d0094a <IOTA_main+0x14e>
c0d0082e:	489f      	ldr	r0, [pc, #636]	; (c0d00aac <IOTA_main+0x2b0>)
c0d00830:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00832:	4330      	orrs	r0, r6
c0d00834:	2880      	cmp	r0, #128	; 0x80
c0d00836:	d000      	beq.n	c0d0083a <IOTA_main+0x3e>
c0d00838:	e11e      	b.n	c0d00a78 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d0083a:	7810      	ldrb	r0, [r2, #0]
c0d0083c:	2800      	cmp	r0, #0
c0d0083e:	4e98      	ldr	r6, [pc, #608]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00840:	d004      	beq.n	c0d0084c <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00842:	489c      	ldr	r0, [pc, #624]	; (c0d00ab4 <IOTA_main+0x2b8>)
c0d00844:	f001 f90c 	bl	c0d01a60 <cx_sha256_init>
                        hashTainted = 0;
c0d00848:	4899      	ldr	r0, [pc, #612]	; (c0d00ab0 <IOTA_main+0x2b4>)
c0d0084a:	7004      	strb	r4, [r0, #0]
c0d0084c:	4897      	ldr	r0, [pc, #604]	; (c0d00aac <IOTA_main+0x2b0>)
c0d0084e:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00850:	7908      	ldrb	r0, [r1, #4]
c0d00852:	1808      	adds	r0, r1, r0
c0d00854:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00856:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00858:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0085a:	4308      	orrs	r0, r1
c0d0085c:	905a      	str	r0, [sp, #360]	; 0x168
c0d0085e:	e0e5      	b.n	c0d00a2c <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00860:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00862:	2818      	cmp	r0, #24
c0d00864:	d800      	bhi.n	c0d00868 <IOTA_main+0x6c>
c0d00866:	e10c      	b.n	c0d00a82 <IOTA_main+0x286>
c0d00868:	950a      	str	r5, [sp, #40]	; 0x28
c0d0086a:	4d90      	ldr	r5, [pc, #576]	; (c0d00aac <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d0086c:	00a0      	lsls	r0, r4, #2
c0d0086e:	1829      	adds	r1, r5, r0
c0d00870:	794a      	ldrb	r2, [r1, #5]
c0d00872:	0612      	lsls	r2, r2, #24
c0d00874:	798b      	ldrb	r3, [r1, #6]
c0d00876:	041b      	lsls	r3, r3, #16
c0d00878:	4313      	orrs	r3, r2
c0d0087a:	79ca      	ldrb	r2, [r1, #7]
c0d0087c:	0212      	lsls	r2, r2, #8
c0d0087e:	431a      	orrs	r2, r3
c0d00880:	7a09      	ldrb	r1, [r1, #8]
c0d00882:	4311      	orrs	r1, r2
c0d00884:	aa2b      	add	r2, sp, #172	; 0xac
c0d00886:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00888:	1c64      	adds	r4, r4, #1
c0d0088a:	2c05      	cmp	r4, #5
c0d0088c:	d1ee      	bne.n	c0d0086c <IOTA_main+0x70>
c0d0088e:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00890:	9103      	str	r1, [sp, #12]
c0d00892:	4668      	mov	r0, sp
c0d00894:	6001      	str	r1, [r0, #0]
c0d00896:	2421      	movs	r4, #33	; 0x21
c0d00898:	a92b      	add	r1, sp, #172	; 0xac
c0d0089a:	2205      	movs	r2, #5
c0d0089c:	ad23      	add	r5, sp, #140	; 0x8c
c0d0089e:	9502      	str	r5, [sp, #8]
c0d008a0:	4620      	mov	r0, r4
c0d008a2:	462b      	mov	r3, r5
c0d008a4:	f001 f992 	bl	c0d01bcc <os_perso_derive_node_bip32>
c0d008a8:	2220      	movs	r2, #32
c0d008aa:	9204      	str	r2, [sp, #16]
c0d008ac:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d008ae:	9301      	str	r3, [sp, #4]
c0d008b0:	4620      	mov	r0, r4
c0d008b2:	4629      	mov	r1, r5
c0d008b4:	f001 f94e 	bl	c0d01b54 <cx_ecfp_init_private_key>
c0d008b8:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d008ba:	4620      	mov	r0, r4
c0d008bc:	9903      	ldr	r1, [sp, #12]
c0d008be:	460a      	mov	r2, r1
c0d008c0:	462b      	mov	r3, r5
c0d008c2:	f001 f929 	bl	c0d01b18 <cx_ecfp_init_public_key>
c0d008c6:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d008c8:	4620      	mov	r0, r4
c0d008ca:	4629      	mov	r1, r5
c0d008cc:	9a01      	ldr	r2, [sp, #4]
c0d008ce:	f001 f95f 	bl	c0d01b90 <cx_ecfp_generate_pair>
c0d008d2:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d008d4:	9802      	ldr	r0, [sp, #8]
c0d008d6:	9904      	ldr	r1, [sp, #16]
c0d008d8:	4622      	mov	r2, r4
c0d008da:	f7ff fc7d 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d008de:	2552      	movs	r5, #82	; 0x52
c0d008e0:	4872      	ldr	r0, [pc, #456]	; (c0d00aac <IOTA_main+0x2b0>)
c0d008e2:	4621      	mov	r1, r4
c0d008e4:	462a      	mov	r2, r5
c0d008e6:	f000 f9ad 	bl	c0d00c44 <os_memmove>
                    tx = 82;
c0d008ea:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d008ec:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d008ee:	1c41      	adds	r1, r0, #1
c0d008f0:	915b      	str	r1, [sp, #364]	; 0x16c
c0d008f2:	3610      	adds	r6, #16
c0d008f4:	4a6d      	ldr	r2, [pc, #436]	; (c0d00aac <IOTA_main+0x2b0>)
c0d008f6:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d008f8:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d008fa:	1c41      	adds	r1, r0, #1
c0d008fc:	915b      	str	r1, [sp, #364]	; 0x16c
c0d008fe:	9903      	ldr	r1, [sp, #12]
c0d00900:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00902:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00904:	b281      	uxth	r1, r0
c0d00906:	9804      	ldr	r0, [sp, #16]
c0d00908:	f000 fd2a 	bl	c0d01360 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d0090c:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0090e:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00910:	4308      	orrs	r0, r1
c0d00912:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00914:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00916:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00918:	202e      	movs	r0, #46	; 0x2e
c0d0091a:	9905      	ldr	r1, [sp, #20]
c0d0091c:	7048      	strb	r0, [r1, #1]
c0d0091e:	7008      	strb	r0, [r1, #0]
c0d00920:	7088      	strb	r0, [r1, #2]
c0d00922:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00924:	78c8      	ldrb	r0, [r1, #3]
c0d00926:	9a06      	ldr	r2, [sp, #24]
c0d00928:	70d0      	strb	r0, [r2, #3]
c0d0092a:	7888      	ldrb	r0, [r1, #2]
c0d0092c:	7090      	strb	r0, [r2, #2]
c0d0092e:	7848      	ldrb	r0, [r1, #1]
c0d00930:	7050      	strb	r0, [r2, #1]
c0d00932:	7808      	ldrb	r0, [r1, #0]
c0d00934:	7010      	strb	r0, [r2, #0]
c0d00936:	7908      	ldrb	r0, [r1, #4]
c0d00938:	7110      	strb	r0, [r2, #4]
c0d0093a:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d0093c:	2140      	movs	r1, #64	; 0x40
c0d0093e:	2203      	movs	r2, #3
c0d00940:	f001 fa8a 	bl	c0d01e58 <ui_display_debug>
c0d00944:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00946:	4e56      	ldr	r6, [pc, #344]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00948:	e070      	b.n	c0d00a2c <IOTA_main+0x230>
c0d0094a:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d0094c:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d0094e:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00950:	ac4d      	add	r4, sp, #308	; 0x134
c0d00952:	4620      	mov	r0, r4
c0d00954:	f002 fc48 	bl	c0d031e8 <setjmp>
c0d00958:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0095a:	6034      	str	r4, [r6, #0]
c0d0095c:	4951      	ldr	r1, [pc, #324]	; (c0d00aa4 <IOTA_main+0x2a8>)
c0d0095e:	4208      	tst	r0, r1
c0d00960:	d011      	beq.n	c0d00986 <IOTA_main+0x18a>
c0d00962:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00964:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00966:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00968:	6031      	str	r1, [r6, #0]
c0d0096a:	210f      	movs	r1, #15
c0d0096c:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d0096e:	4001      	ands	r1, r0
c0d00970:	2209      	movs	r2, #9
c0d00972:	0312      	lsls	r2, r2, #12
c0d00974:	4291      	cmp	r1, r2
c0d00976:	d003      	beq.n	c0d00980 <IOTA_main+0x184>
c0d00978:	9a08      	ldr	r2, [sp, #32]
c0d0097a:	0352      	lsls	r2, r2, #13
c0d0097c:	4291      	cmp	r1, r2
c0d0097e:	d142      	bne.n	c0d00a06 <IOTA_main+0x20a>
c0d00980:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00982:	8008      	strh	r0, [r1, #0]
c0d00984:	e046      	b.n	c0d00a14 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00986:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00988:	905c      	str	r0, [sp, #368]	; 0x170
c0d0098a:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d0098c:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d0098e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00990:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00992:	b2c0      	uxtb	r0, r0
c0d00994:	b289      	uxth	r1, r1
c0d00996:	f000 fce3 	bl	c0d01360 <io_exchange>
c0d0099a:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d0099c:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d0099e:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d009a0:	2800      	cmp	r0, #0
c0d009a2:	d053      	beq.n	c0d00a4c <IOTA_main+0x250>
c0d009a4:	4941      	ldr	r1, [pc, #260]	; (c0d00aac <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d009a6:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d009a8:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d009aa:	2880      	cmp	r0, #128	; 0x80
c0d009ac:	4a40      	ldr	r2, [pc, #256]	; (c0d00ab0 <IOTA_main+0x2b4>)
c0d009ae:	d155      	bne.n	c0d00a5c <IOTA_main+0x260>
c0d009b0:	7848      	ldrb	r0, [r1, #1]
c0d009b2:	216d      	movs	r1, #109	; 0x6d
c0d009b4:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d009b6:	2807      	cmp	r0, #7
c0d009b8:	dc3f      	bgt.n	c0d00a3a <IOTA_main+0x23e>
c0d009ba:	2802      	cmp	r0, #2
c0d009bc:	d100      	bne.n	c0d009c0 <IOTA_main+0x1c4>
c0d009be:	e74f      	b.n	c0d00860 <IOTA_main+0x64>
c0d009c0:	2804      	cmp	r0, #4
c0d009c2:	d153      	bne.n	c0d00a6c <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d009c4:	210b      	movs	r1, #11
c0d009c6:	2203      	movs	r2, #3
c0d009c8:	a03c      	add	r0, pc, #240	; (adr r0, c0d00abc <IOTA_main+0x2c0>)
c0d009ca:	f7ff fb6b 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d009ce:	2048      	movs	r0, #72	; 0x48
c0d009d0:	4936      	ldr	r1, [pc, #216]	; (c0d00aac <IOTA_main+0x2b0>)
c0d009d2:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d009d4:	2049      	movs	r0, #73	; 0x49
c0d009d6:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d009d8:	2021      	movs	r0, #33	; 0x21
c0d009da:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d009dc:	3610      	adds	r6, #16
c0d009de:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d009e0:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d009e2:	2005      	movs	r0, #5
c0d009e4:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d009e6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009e8:	b281      	uxth	r1, r0
c0d009ea:	2020      	movs	r0, #32
c0d009ec:	f000 fcb8 	bl	c0d01360 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d009f0:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d009f2:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d009f4:	4308      	orrs	r0, r1
c0d009f6:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d009f8:	4620      	mov	r0, r4
c0d009fa:	4621      	mov	r1, r4
c0d009fc:	4622      	mov	r2, r4
c0d009fe:	f001 fa2b 	bl	c0d01e58 <ui_display_debug>
c0d00a02:	4e27      	ldr	r6, [pc, #156]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a04:	e012      	b.n	c0d00a2c <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00a06:	4928      	ldr	r1, [pc, #160]	; (c0d00aa8 <IOTA_main+0x2ac>)
c0d00a08:	4008      	ands	r0, r1
c0d00a0a:	210d      	movs	r1, #13
c0d00a0c:	02c9      	lsls	r1, r1, #11
c0d00a0e:	4301      	orrs	r1, r0
c0d00a10:	a859      	add	r0, sp, #356	; 0x164
c0d00a12:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00a14:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00a16:	0a00      	lsrs	r0, r0, #8
c0d00a18:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00a1a:	4a24      	ldr	r2, [pc, #144]	; (c0d00aac <IOTA_main+0x2b0>)
c0d00a1c:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00a1e:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00a20:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00a22:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00a24:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00a26:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a28:	1c80      	adds	r0, r0, #2
c0d00a2a:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00a2c:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00a2e:	6030      	str	r0, [r6, #0]
c0d00a30:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00a32:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00a34:	2900      	cmp	r1, #0
c0d00a36:	d088      	beq.n	c0d0094a <IOTA_main+0x14e>
c0d00a38:	e006      	b.n	c0d00a48 <IOTA_main+0x24c>
c0d00a3a:	2808      	cmp	r0, #8
c0d00a3c:	d100      	bne.n	c0d00a40 <IOTA_main+0x244>
c0d00a3e:	e6f6      	b.n	c0d0082e <IOTA_main+0x32>
c0d00a40:	28ff      	cmp	r0, #255	; 0xff
c0d00a42:	d113      	bne.n	c0d00a6c <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00a44:	b05d      	add	sp, #372	; 0x174
c0d00a46:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00a48:	f002 fbda 	bl	c0d03200 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00a4c:	2001      	movs	r0, #1
c0d00a4e:	4918      	ldr	r1, [pc, #96]	; (c0d00ab0 <IOTA_main+0x2b4>)
c0d00a50:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00a52:	4813      	ldr	r0, [pc, #76]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a54:	6800      	ldr	r0, [r0, #0]
c0d00a56:	491c      	ldr	r1, [pc, #112]	; (c0d00ac8 <IOTA_main+0x2cc>)
c0d00a58:	f002 fbd2 	bl	c0d03200 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00a5c:	2001      	movs	r0, #1
c0d00a5e:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00a60:	480f      	ldr	r0, [pc, #60]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a62:	6800      	ldr	r0, [r0, #0]
c0d00a64:	2137      	movs	r1, #55	; 0x37
c0d00a66:	0249      	lsls	r1, r1, #9
c0d00a68:	f002 fbca 	bl	c0d03200 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00a6c:	2001      	movs	r0, #1
c0d00a6e:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00a70:	480b      	ldr	r0, [pc, #44]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a72:	6800      	ldr	r0, [r0, #0]
c0d00a74:	f002 fbc4 	bl	c0d03200 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00a78:	4809      	ldr	r0, [pc, #36]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a7a:	6800      	ldr	r0, [r0, #0]
c0d00a7c:	490e      	ldr	r1, [pc, #56]	; (c0d00ab8 <IOTA_main+0x2bc>)
c0d00a7e:	f002 fbbf 	bl	c0d03200 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00a82:	2001      	movs	r0, #1
c0d00a84:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00a86:	4806      	ldr	r0, [pc, #24]	; (c0d00aa0 <IOTA_main+0x2a4>)
c0d00a88:	6800      	ldr	r0, [r0, #0]
c0d00a8a:	3109      	adds	r1, #9
c0d00a8c:	f002 fbb8 	bl	c0d03200 <longjmp>
c0d00a90:	74696157 	.word	0x74696157
c0d00a94:	20676e69 	.word	0x20676e69
c0d00a98:	20726f66 	.word	0x20726f66
c0d00a9c:	0067736d 	.word	0x0067736d
c0d00aa0:	20001bb8 	.word	0x20001bb8
c0d00aa4:	0000ffff 	.word	0x0000ffff
c0d00aa8:	000007ff 	.word	0x000007ff
c0d00aac:	20001c08 	.word	0x20001c08
c0d00ab0:	20001b48 	.word	0x20001b48
c0d00ab4:	20001b4c 	.word	0x20001b4c
c0d00ab8:	00006a86 	.word	0x00006a86
c0d00abc:	20646142 	.word	0x20646142
c0d00ac0:	6b627550 	.word	0x6b627550
c0d00ac4:	00007965 	.word	0x00007965
c0d00ac8:	00006982 	.word	0x00006982

c0d00acc <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00acc:	4801      	ldr	r0, [pc, #4]	; (c0d00ad4 <os_boot+0x8>)
c0d00ace:	2100      	movs	r1, #0
c0d00ad0:	6001      	str	r1, [r0, #0]
}
c0d00ad2:	4770      	bx	lr
c0d00ad4:	20001bb8 	.word	0x20001bb8

c0d00ad8 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00ad8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ada:	af03      	add	r7, sp, #12
c0d00adc:	b083      	sub	sp, #12
c0d00ade:	9202      	str	r2, [sp, #8]
c0d00ae0:	460c      	mov	r4, r1
c0d00ae2:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00ae4:	4d4a      	ldr	r5, [pc, #296]	; (c0d00c10 <io_usb_hid_receive+0x138>)
c0d00ae6:	42ac      	cmp	r4, r5
c0d00ae8:	d00f      	beq.n	c0d00b0a <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00aea:	4e49      	ldr	r6, [pc, #292]	; (c0d00c10 <io_usb_hid_receive+0x138>)
c0d00aec:	2540      	movs	r5, #64	; 0x40
c0d00aee:	4630      	mov	r0, r6
c0d00af0:	4629      	mov	r1, r5
c0d00af2:	f002 fae3 	bl	c0d030bc <__aeabi_memclr>
c0d00af6:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00af8:	2840      	cmp	r0, #64	; 0x40
c0d00afa:	4602      	mov	r2, r0
c0d00afc:	d300      	bcc.n	c0d00b00 <io_usb_hid_receive+0x28>
c0d00afe:	462a      	mov	r2, r5
c0d00b00:	4630      	mov	r0, r6
c0d00b02:	4621      	mov	r1, r4
c0d00b04:	f000 f89e 	bl	c0d00c44 <os_memmove>
c0d00b08:	4d41      	ldr	r5, [pc, #260]	; (c0d00c10 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00b0a:	78a8      	ldrb	r0, [r5, #2]
c0d00b0c:	2805      	cmp	r0, #5
c0d00b0e:	d900      	bls.n	c0d00b12 <io_usb_hid_receive+0x3a>
c0d00b10:	e076      	b.n	c0d00c00 <io_usb_hid_receive+0x128>
c0d00b12:	46c0      	nop			; (mov r8, r8)
c0d00b14:	4478      	add	r0, pc
c0d00b16:	7900      	ldrb	r0, [r0, #4]
c0d00b18:	0040      	lsls	r0, r0, #1
c0d00b1a:	4487      	add	pc, r0
c0d00b1c:	71130c02 	.word	0x71130c02
c0d00b20:	1f71      	.short	0x1f71
c0d00b22:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00b24:	71ae      	strb	r6, [r5, #6]
c0d00b26:	716e      	strb	r6, [r5, #5]
c0d00b28:	712e      	strb	r6, [r5, #4]
c0d00b2a:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00b2c:	2140      	movs	r1, #64	; 0x40
c0d00b2e:	4628      	mov	r0, r5
c0d00b30:	9a01      	ldr	r2, [sp, #4]
c0d00b32:	4790      	blx	r2
c0d00b34:	e00b      	b.n	c0d00b4e <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00b36:	1ce8      	adds	r0, r5, #3
c0d00b38:	2104      	movs	r1, #4
c0d00b3a:	f000 ff73 	bl	c0d01a24 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00b3e:	2140      	movs	r1, #64	; 0x40
c0d00b40:	4628      	mov	r0, r5
c0d00b42:	e001      	b.n	c0d00b48 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00b44:	4832      	ldr	r0, [pc, #200]	; (c0d00c10 <io_usb_hid_receive+0x138>)
c0d00b46:	2140      	movs	r1, #64	; 0x40
c0d00b48:	9a01      	ldr	r2, [sp, #4]
c0d00b4a:	4790      	blx	r2
c0d00b4c:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00b4e:	4831      	ldr	r0, [pc, #196]	; (c0d00c14 <io_usb_hid_receive+0x13c>)
c0d00b50:	2100      	movs	r1, #0
c0d00b52:	6001      	str	r1, [r0, #0]
c0d00b54:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00b56:	b2c0      	uxtb	r0, r0
c0d00b58:	b003      	add	sp, #12
c0d00b5a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00b5c:	78e8      	ldrb	r0, [r5, #3]
c0d00b5e:	4c2d      	ldr	r4, [pc, #180]	; (c0d00c14 <io_usb_hid_receive+0x13c>)
c0d00b60:	6821      	ldr	r1, [r4, #0]
c0d00b62:	0a09      	lsrs	r1, r1, #8
c0d00b64:	2600      	movs	r6, #0
c0d00b66:	4288      	cmp	r0, r1
c0d00b68:	d1f1      	bne.n	c0d00b4e <io_usb_hid_receive+0x76>
c0d00b6a:	7928      	ldrb	r0, [r5, #4]
c0d00b6c:	6821      	ldr	r1, [r4, #0]
c0d00b6e:	b2c9      	uxtb	r1, r1
c0d00b70:	4288      	cmp	r0, r1
c0d00b72:	d1ec      	bne.n	c0d00b4e <io_usb_hid_receive+0x76>
c0d00b74:	4b28      	ldr	r3, [pc, #160]	; (c0d00c18 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00b76:	9802      	ldr	r0, [sp, #8]
c0d00b78:	18c0      	adds	r0, r0, r3
c0d00b7a:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00b7c:	6820      	ldr	r0, [r4, #0]
c0d00b7e:	2800      	cmp	r0, #0
c0d00b80:	d00e      	beq.n	c0d00ba0 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00b82:	4629      	mov	r1, r5
c0d00b84:	4019      	ands	r1, r3
c0d00b86:	4825      	ldr	r0, [pc, #148]	; (c0d00c1c <io_usb_hid_receive+0x144>)
c0d00b88:	6802      	ldr	r2, [r0, #0]
c0d00b8a:	4291      	cmp	r1, r2
c0d00b8c:	461e      	mov	r6, r3
c0d00b8e:	d900      	bls.n	c0d00b92 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00b90:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00b92:	462a      	mov	r2, r5
c0d00b94:	4032      	ands	r2, r6
c0d00b96:	4822      	ldr	r0, [pc, #136]	; (c0d00c20 <io_usb_hid_receive+0x148>)
c0d00b98:	6800      	ldr	r0, [r0, #0]
c0d00b9a:	491d      	ldr	r1, [pc, #116]	; (c0d00c10 <io_usb_hid_receive+0x138>)
c0d00b9c:	1d49      	adds	r1, r1, #5
c0d00b9e:	e021      	b.n	c0d00be4 <io_usb_hid_receive+0x10c>
c0d00ba0:	9301      	str	r3, [sp, #4]
c0d00ba2:	491b      	ldr	r1, [pc, #108]	; (c0d00c10 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00ba4:	7988      	ldrb	r0, [r1, #6]
c0d00ba6:	7949      	ldrb	r1, [r1, #5]
c0d00ba8:	0209      	lsls	r1, r1, #8
c0d00baa:	4301      	orrs	r1, r0
c0d00bac:	481d      	ldr	r0, [pc, #116]	; (c0d00c24 <io_usb_hid_receive+0x14c>)
c0d00bae:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00bb0:	6801      	ldr	r1, [r0, #0]
c0d00bb2:	2241      	movs	r2, #65	; 0x41
c0d00bb4:	0092      	lsls	r2, r2, #2
c0d00bb6:	4291      	cmp	r1, r2
c0d00bb8:	d8c9      	bhi.n	c0d00b4e <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00bba:	6801      	ldr	r1, [r0, #0]
c0d00bbc:	4817      	ldr	r0, [pc, #92]	; (c0d00c1c <io_usb_hid_receive+0x144>)
c0d00bbe:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00bc0:	4917      	ldr	r1, [pc, #92]	; (c0d00c20 <io_usb_hid_receive+0x148>)
c0d00bc2:	4a19      	ldr	r2, [pc, #100]	; (c0d00c28 <io_usb_hid_receive+0x150>)
c0d00bc4:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00bc6:	4919      	ldr	r1, [pc, #100]	; (c0d00c2c <io_usb_hid_receive+0x154>)
c0d00bc8:	9a02      	ldr	r2, [sp, #8]
c0d00bca:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00bcc:	4629      	mov	r1, r5
c0d00bce:	9e01      	ldr	r6, [sp, #4]
c0d00bd0:	4031      	ands	r1, r6
c0d00bd2:	6802      	ldr	r2, [r0, #0]
c0d00bd4:	4291      	cmp	r1, r2
c0d00bd6:	d900      	bls.n	c0d00bda <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00bd8:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00bda:	462a      	mov	r2, r5
c0d00bdc:	4032      	ands	r2, r6
c0d00bde:	480c      	ldr	r0, [pc, #48]	; (c0d00c10 <io_usb_hid_receive+0x138>)
c0d00be0:	1dc1      	adds	r1, r0, #7
c0d00be2:	4811      	ldr	r0, [pc, #68]	; (c0d00c28 <io_usb_hid_receive+0x150>)
c0d00be4:	f000 f82e 	bl	c0d00c44 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00be8:	4035      	ands	r5, r6
c0d00bea:	480d      	ldr	r0, [pc, #52]	; (c0d00c20 <io_usb_hid_receive+0x148>)
c0d00bec:	6801      	ldr	r1, [r0, #0]
c0d00bee:	1949      	adds	r1, r1, r5
c0d00bf0:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00bf2:	480a      	ldr	r0, [pc, #40]	; (c0d00c1c <io_usb_hid_receive+0x144>)
c0d00bf4:	6801      	ldr	r1, [r0, #0]
c0d00bf6:	1b49      	subs	r1, r1, r5
c0d00bf8:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00bfa:	6820      	ldr	r0, [r4, #0]
c0d00bfc:	1c40      	adds	r0, r0, #1
c0d00bfe:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00c00:	4806      	ldr	r0, [pc, #24]	; (c0d00c1c <io_usb_hid_receive+0x144>)
c0d00c02:	6801      	ldr	r1, [r0, #0]
c0d00c04:	2001      	movs	r0, #1
c0d00c06:	2602      	movs	r6, #2
c0d00c08:	2900      	cmp	r1, #0
c0d00c0a:	d1a4      	bne.n	c0d00b56 <io_usb_hid_receive+0x7e>
c0d00c0c:	e79f      	b.n	c0d00b4e <io_usb_hid_receive+0x76>
c0d00c0e:	46c0      	nop			; (mov r8, r8)
c0d00c10:	20001bbc 	.word	0x20001bbc
c0d00c14:	20001bfc 	.word	0x20001bfc
c0d00c18:	0000ffff 	.word	0x0000ffff
c0d00c1c:	20001c04 	.word	0x20001c04
c0d00c20:	20001d0c 	.word	0x20001d0c
c0d00c24:	20001c00 	.word	0x20001c00
c0d00c28:	20001c08 	.word	0x20001c08
c0d00c2c:	0001fff9 	.word	0x0001fff9

c0d00c30 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00c30:	b580      	push	{r7, lr}
c0d00c32:	af00      	add	r7, sp, #0
c0d00c34:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00c36:	2a00      	cmp	r2, #0
c0d00c38:	d003      	beq.n	c0d00c42 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00c3a:	4611      	mov	r1, r2
c0d00c3c:	461a      	mov	r2, r3
c0d00c3e:	f002 fa47 	bl	c0d030d0 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00c42:	bd80      	pop	{r7, pc}

c0d00c44 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00c44:	b5b0      	push	{r4, r5, r7, lr}
c0d00c46:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00c48:	4288      	cmp	r0, r1
c0d00c4a:	d90d      	bls.n	c0d00c68 <os_memmove+0x24>
    while(length--) {
c0d00c4c:	2a00      	cmp	r2, #0
c0d00c4e:	d014      	beq.n	c0d00c7a <os_memmove+0x36>
c0d00c50:	1e49      	subs	r1, r1, #1
c0d00c52:	4252      	negs	r2, r2
c0d00c54:	1e40      	subs	r0, r0, #1
c0d00c56:	2300      	movs	r3, #0
c0d00c58:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00c5a:	461c      	mov	r4, r3
c0d00c5c:	4354      	muls	r4, r2
c0d00c5e:	5d0d      	ldrb	r5, [r1, r4]
c0d00c60:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00c62:	1c52      	adds	r2, r2, #1
c0d00c64:	d1f9      	bne.n	c0d00c5a <os_memmove+0x16>
c0d00c66:	e008      	b.n	c0d00c7a <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00c68:	2a00      	cmp	r2, #0
c0d00c6a:	d006      	beq.n	c0d00c7a <os_memmove+0x36>
c0d00c6c:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00c6e:	b29c      	uxth	r4, r3
c0d00c70:	5d0d      	ldrb	r5, [r1, r4]
c0d00c72:	5505      	strb	r5, [r0, r4]
      l++;
c0d00c74:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00c76:	1e52      	subs	r2, r2, #1
c0d00c78:	d1f9      	bne.n	c0d00c6e <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00c7a:	bdb0      	pop	{r4, r5, r7, pc}

c0d00c7c <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00c7c:	4801      	ldr	r0, [pc, #4]	; (c0d00c84 <io_usb_hid_init+0x8>)
c0d00c7e:	2100      	movs	r1, #0
c0d00c80:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00c82:	4770      	bx	lr
c0d00c84:	20001bfc 	.word	0x20001bfc

c0d00c88 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00c88:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c8a:	af03      	add	r7, sp, #12
c0d00c8c:	b087      	sub	sp, #28
c0d00c8e:	9301      	str	r3, [sp, #4]
c0d00c90:	9203      	str	r2, [sp, #12]
c0d00c92:	460e      	mov	r6, r1
c0d00c94:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00c96:	2e00      	cmp	r6, #0
c0d00c98:	d042      	beq.n	c0d00d20 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00c9a:	4d31      	ldr	r5, [pc, #196]	; (c0d00d60 <io_usb_hid_exchange+0xd8>)
c0d00c9c:	2000      	movs	r0, #0
c0d00c9e:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00ca0:	4930      	ldr	r1, [pc, #192]	; (c0d00d64 <io_usb_hid_exchange+0xdc>)
c0d00ca2:	4831      	ldr	r0, [pc, #196]	; (c0d00d68 <io_usb_hid_exchange+0xe0>)
c0d00ca4:	6008      	str	r0, [r1, #0]
c0d00ca6:	4c31      	ldr	r4, [pc, #196]	; (c0d00d6c <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00ca8:	1d60      	adds	r0, r4, #5
c0d00caa:	213b      	movs	r1, #59	; 0x3b
c0d00cac:	9005      	str	r0, [sp, #20]
c0d00cae:	9102      	str	r1, [sp, #8]
c0d00cb0:	f002 fa04 	bl	c0d030bc <__aeabi_memclr>
c0d00cb4:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00cb6:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00cb8:	6828      	ldr	r0, [r5, #0]
c0d00cba:	0a00      	lsrs	r0, r0, #8
c0d00cbc:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00cbe:	6828      	ldr	r0, [r5, #0]
c0d00cc0:	7120      	strb	r0, [r4, #4]
c0d00cc2:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00cc4:	6828      	ldr	r0, [r5, #0]
c0d00cc6:	2800      	cmp	r0, #0
c0d00cc8:	9106      	str	r1, [sp, #24]
c0d00cca:	d009      	beq.n	c0d00ce0 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00ccc:	293b      	cmp	r1, #59	; 0x3b
c0d00cce:	460a      	mov	r2, r1
c0d00cd0:	d300      	bcc.n	c0d00cd4 <io_usb_hid_exchange+0x4c>
c0d00cd2:	9a02      	ldr	r2, [sp, #8]
c0d00cd4:	4823      	ldr	r0, [pc, #140]	; (c0d00d64 <io_usb_hid_exchange+0xdc>)
c0d00cd6:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00cd8:	6819      	ldr	r1, [r3, #0]
c0d00cda:	9805      	ldr	r0, [sp, #20]
c0d00cdc:	461e      	mov	r6, r3
c0d00cde:	e00a      	b.n	c0d00cf6 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00ce0:	0a30      	lsrs	r0, r6, #8
c0d00ce2:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00ce4:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00ce6:	2039      	movs	r0, #57	; 0x39
c0d00ce8:	2939      	cmp	r1, #57	; 0x39
c0d00cea:	460a      	mov	r2, r1
c0d00cec:	d300      	bcc.n	c0d00cf0 <io_usb_hid_exchange+0x68>
c0d00cee:	4602      	mov	r2, r0
c0d00cf0:	4e1c      	ldr	r6, [pc, #112]	; (c0d00d64 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00cf2:	6831      	ldr	r1, [r6, #0]
c0d00cf4:	1de0      	adds	r0, r4, #7
c0d00cf6:	9205      	str	r2, [sp, #20]
c0d00cf8:	f7ff ffa4 	bl	c0d00c44 <os_memmove>
c0d00cfc:	4d18      	ldr	r5, [pc, #96]	; (c0d00d60 <io_usb_hid_exchange+0xd8>)
c0d00cfe:	6830      	ldr	r0, [r6, #0]
c0d00d00:	4631      	mov	r1, r6
c0d00d02:	9e05      	ldr	r6, [sp, #20]
c0d00d04:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00d06:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00d08:	6828      	ldr	r0, [r5, #0]
c0d00d0a:	1c40      	adds	r0, r0, #1
c0d00d0c:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00d0e:	2140      	movs	r1, #64	; 0x40
c0d00d10:	4620      	mov	r0, r4
c0d00d12:	9a04      	ldr	r2, [sp, #16]
c0d00d14:	4790      	blx	r2
c0d00d16:	9806      	ldr	r0, [sp, #24]
c0d00d18:	1b86      	subs	r6, r0, r6
c0d00d1a:	4815      	ldr	r0, [pc, #84]	; (c0d00d70 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00d1c:	4206      	tst	r6, r0
c0d00d1e:	d1c3      	bne.n	c0d00ca8 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00d20:	480f      	ldr	r0, [pc, #60]	; (c0d00d60 <io_usb_hid_exchange+0xd8>)
c0d00d22:	2400      	movs	r4, #0
c0d00d24:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00d26:	2080      	movs	r0, #128	; 0x80
c0d00d28:	9901      	ldr	r1, [sp, #4]
c0d00d2a:	4201      	tst	r1, r0
c0d00d2c:	d001      	beq.n	c0d00d32 <io_usb_hid_exchange+0xaa>
    reset();
c0d00d2e:	f000 fe3f 	bl	c0d019b0 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00d32:	9801      	ldr	r0, [sp, #4]
c0d00d34:	0680      	lsls	r0, r0, #26
c0d00d36:	d40f      	bmi.n	c0d00d58 <io_usb_hid_exchange+0xd0>
c0d00d38:	4c0c      	ldr	r4, [pc, #48]	; (c0d00d6c <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00d3a:	2140      	movs	r1, #64	; 0x40
c0d00d3c:	4620      	mov	r0, r4
c0d00d3e:	9a03      	ldr	r2, [sp, #12]
c0d00d40:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00d42:	b2c2      	uxtb	r2, r0
c0d00d44:	2a40      	cmp	r2, #64	; 0x40
c0d00d46:	d8f8      	bhi.n	c0d00d3a <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00d48:	9804      	ldr	r0, [sp, #16]
c0d00d4a:	4621      	mov	r1, r4
c0d00d4c:	f7ff fec4 	bl	c0d00ad8 <io_usb_hid_receive>
c0d00d50:	2802      	cmp	r0, #2
c0d00d52:	d1f2      	bne.n	c0d00d3a <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00d54:	4807      	ldr	r0, [pc, #28]	; (c0d00d74 <io_usb_hid_exchange+0xec>)
c0d00d56:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00d58:	b2a0      	uxth	r0, r4
c0d00d5a:	b007      	add	sp, #28
c0d00d5c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d5e:	46c0      	nop			; (mov r8, r8)
c0d00d60:	20001bfc 	.word	0x20001bfc
c0d00d64:	20001d0c 	.word	0x20001d0c
c0d00d68:	20001c08 	.word	0x20001c08
c0d00d6c:	20001bbc 	.word	0x20001bbc
c0d00d70:	0000ffff 	.word	0x0000ffff
c0d00d74:	20001c00 	.word	0x20001c00

c0d00d78 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00d78:	b580      	push	{r7, lr}
c0d00d7a:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00d7c:	f000 ffbc 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d00d80:	2800      	cmp	r0, #0
c0d00d82:	d10b      	bne.n	c0d00d9c <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00d84:	4806      	ldr	r0, [pc, #24]	; (c0d00da0 <io_seproxyhal_general_status+0x28>)
c0d00d86:	2160      	movs	r1, #96	; 0x60
c0d00d88:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00d8a:	2100      	movs	r1, #0
c0d00d8c:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00d8e:	2202      	movs	r2, #2
c0d00d90:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00d92:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00d94:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00d96:	2105      	movs	r1, #5
c0d00d98:	f000 ff90 	bl	c0d01cbc <io_seproxyhal_spi_send>
}
c0d00d9c:	bd80      	pop	{r7, pc}
c0d00d9e:	46c0      	nop			; (mov r8, r8)
c0d00da0:	20001a18 	.word	0x20001a18

c0d00da4 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00da4:	b5d0      	push	{r4, r6, r7, lr}
c0d00da6:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00da8:	4815      	ldr	r0, [pc, #84]	; (c0d00e00 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00daa:	78c0      	ldrb	r0, [r0, #3]
c0d00dac:	1e40      	subs	r0, r0, #1
c0d00dae:	2807      	cmp	r0, #7
c0d00db0:	d824      	bhi.n	c0d00dfc <io_seproxyhal_handle_usb_event+0x58>
c0d00db2:	46c0      	nop			; (mov r8, r8)
c0d00db4:	4478      	add	r0, pc
c0d00db6:	7900      	ldrb	r0, [r0, #4]
c0d00db8:	0040      	lsls	r0, r0, #1
c0d00dba:	4487      	add	pc, r0
c0d00dbc:	141f1803 	.word	0x141f1803
c0d00dc0:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00dc4:	4c0f      	ldr	r4, [pc, #60]	; (c0d00e04 <io_seproxyhal_handle_usb_event+0x60>)
c0d00dc6:	2101      	movs	r1, #1
c0d00dc8:	4620      	mov	r0, r4
c0d00dca:	f001 fbd5 	bl	c0d02578 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00dce:	4620      	mov	r0, r4
c0d00dd0:	f001 fbba 	bl	c0d02548 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00dd4:	480c      	ldr	r0, [pc, #48]	; (c0d00e08 <io_seproxyhal_handle_usb_event+0x64>)
c0d00dd6:	7800      	ldrb	r0, [r0, #0]
c0d00dd8:	2801      	cmp	r0, #1
c0d00dda:	d10f      	bne.n	c0d00dfc <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00ddc:	480b      	ldr	r0, [pc, #44]	; (c0d00e0c <io_seproxyhal_handle_usb_event+0x68>)
c0d00dde:	6800      	ldr	r0, [r0, #0]
c0d00de0:	2110      	movs	r1, #16
c0d00de2:	f002 fa0d 	bl	c0d03200 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00de6:	4807      	ldr	r0, [pc, #28]	; (c0d00e04 <io_seproxyhal_handle_usb_event+0x60>)
c0d00de8:	f001 fbc9 	bl	c0d0257e <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00dec:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00dee:	4805      	ldr	r0, [pc, #20]	; (c0d00e04 <io_seproxyhal_handle_usb_event+0x60>)
c0d00df0:	f001 fbc9 	bl	c0d02586 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00df4:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00df6:	4803      	ldr	r0, [pc, #12]	; (c0d00e04 <io_seproxyhal_handle_usb_event+0x60>)
c0d00df8:	f001 fbc3 	bl	c0d02582 <USBD_LL_Resume>
      break;
  }
}
c0d00dfc:	bdd0      	pop	{r4, r6, r7, pc}
c0d00dfe:	46c0      	nop			; (mov r8, r8)
c0d00e00:	20001a18 	.word	0x20001a18
c0d00e04:	20001d34 	.word	0x20001d34
c0d00e08:	20001d10 	.word	0x20001d10
c0d00e0c:	20001bb8 	.word	0x20001bb8

c0d00e10 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00e10:	217f      	movs	r1, #127	; 0x7f
c0d00e12:	4001      	ands	r1, r0
c0d00e14:	4801      	ldr	r0, [pc, #4]	; (c0d00e1c <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00e16:	5c40      	ldrb	r0, [r0, r1]
c0d00e18:	4770      	bx	lr
c0d00e1a:	46c0      	nop			; (mov r8, r8)
c0d00e1c:	20001d11 	.word	0x20001d11

c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00e20:	b580      	push	{r7, lr}
c0d00e22:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00e24:	480f      	ldr	r0, [pc, #60]	; (c0d00e64 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00e26:	7901      	ldrb	r1, [r0, #4]
c0d00e28:	2904      	cmp	r1, #4
c0d00e2a:	d008      	beq.n	c0d00e3e <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00e2c:	2902      	cmp	r1, #2
c0d00e2e:	d011      	beq.n	c0d00e54 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00e30:	2901      	cmp	r1, #1
c0d00e32:	d10e      	bne.n	c0d00e52 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00e34:	1d81      	adds	r1, r0, #6
c0d00e36:	480d      	ldr	r0, [pc, #52]	; (c0d00e6c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00e38:	f001 faaa 	bl	c0d02390 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00e3c:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00e3e:	78c2      	ldrb	r2, [r0, #3]
c0d00e40:	217f      	movs	r1, #127	; 0x7f
c0d00e42:	4011      	ands	r1, r2
c0d00e44:	7942      	ldrb	r2, [r0, #5]
c0d00e46:	4b08      	ldr	r3, [pc, #32]	; (c0d00e68 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00e48:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00e4a:	1d82      	adds	r2, r0, #6
c0d00e4c:	4807      	ldr	r0, [pc, #28]	; (c0d00e6c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00e4e:	f001 fad1 	bl	c0d023f4 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00e52:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00e54:	78c2      	ldrb	r2, [r0, #3]
c0d00e56:	217f      	movs	r1, #127	; 0x7f
c0d00e58:	4011      	ands	r1, r2
c0d00e5a:	1d82      	adds	r2, r0, #6
c0d00e5c:	4803      	ldr	r0, [pc, #12]	; (c0d00e6c <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00e5e:	f001 fb0f 	bl	c0d02480 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00e62:	bd80      	pop	{r7, pc}
c0d00e64:	20001a18 	.word	0x20001a18
c0d00e68:	20001d11 	.word	0x20001d11
c0d00e6c:	20001d34 	.word	0x20001d34

c0d00e70 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00e70:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e72:	af03      	add	r7, sp, #12
c0d00e74:	b083      	sub	sp, #12
c0d00e76:	9201      	str	r2, [sp, #4]
c0d00e78:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00e7a:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00e7c:	2b00      	cmp	r3, #0
c0d00e7e:	d100      	bne.n	c0d00e82 <io_usb_send_ep+0x12>
c0d00e80:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00e82:	9801      	ldr	r0, [sp, #4]
c0d00e84:	28ff      	cmp	r0, #255	; 0xff
c0d00e86:	d843      	bhi.n	c0d00f10 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00e88:	4e25      	ldr	r6, [pc, #148]	; (c0d00f20 <io_usb_send_ep+0xb0>)
c0d00e8a:	2050      	movs	r0, #80	; 0x50
c0d00e8c:	7030      	strb	r0, [r6, #0]
c0d00e8e:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00e90:	1ce0      	adds	r0, r4, #3
c0d00e92:	9100      	str	r1, [sp, #0]
c0d00e94:	0a01      	lsrs	r1, r0, #8
c0d00e96:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00e98:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00e9a:	2080      	movs	r0, #128	; 0x80
c0d00e9c:	4302      	orrs	r2, r0
c0d00e9e:	9202      	str	r2, [sp, #8]
c0d00ea0:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00ea2:	2020      	movs	r0, #32
c0d00ea4:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00ea6:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00ea8:	2106      	movs	r1, #6
c0d00eaa:	4630      	mov	r0, r6
c0d00eac:	f000 ff06 	bl	c0d01cbc <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00eb0:	9800      	ldr	r0, [sp, #0]
c0d00eb2:	4621      	mov	r1, r4
c0d00eb4:	f000 ff02 	bl	c0d01cbc <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00eb8:	2d00      	cmp	r5, #0
c0d00eba:	d10d      	bne.n	c0d00ed8 <io_usb_send_ep+0x68>
c0d00ebc:	e028      	b.n	c0d00f10 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00ebe:	2d00      	cmp	r5, #0
c0d00ec0:	d002      	beq.n	c0d00ec8 <io_usb_send_ep+0x58>
c0d00ec2:	1e6c      	subs	r4, r5, #1
c0d00ec4:	2d01      	cmp	r5, #1
c0d00ec6:	d025      	beq.n	c0d00f14 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00ec8:	2915      	cmp	r1, #21
c0d00eca:	d102      	bne.n	c0d00ed2 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00ecc:	79b0      	ldrb	r0, [r6, #6]
c0d00ece:	0700      	lsls	r0, r0, #28
c0d00ed0:	d520      	bpl.n	c0d00f14 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00ed2:	f000 f829 	bl	c0d00f28 <io_seproxyhal_handle_event>
c0d00ed6:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00ed8:	f000 ff0e 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d00edc:	2800      	cmp	r0, #0
c0d00ede:	d101      	bne.n	c0d00ee4 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00ee0:	f7ff ff4a 	bl	c0d00d78 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00ee4:	2180      	movs	r1, #128	; 0x80
c0d00ee6:	2400      	movs	r4, #0
c0d00ee8:	4630      	mov	r0, r6
c0d00eea:	4622      	mov	r2, r4
c0d00eec:	f000 ff20 	bl	c0d01d30 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00ef0:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00ef2:	2806      	cmp	r0, #6
c0d00ef4:	d1e3      	bne.n	c0d00ebe <io_usb_send_ep+0x4e>
c0d00ef6:	2910      	cmp	r1, #16
c0d00ef8:	d1e1      	bne.n	c0d00ebe <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00efa:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00efc:	9a02      	ldr	r2, [sp, #8]
c0d00efe:	4290      	cmp	r0, r2
c0d00f00:	d1dd      	bne.n	c0d00ebe <io_usb_send_ep+0x4e>
c0d00f02:	7930      	ldrb	r0, [r6, #4]
c0d00f04:	2802      	cmp	r0, #2
c0d00f06:	d1da      	bne.n	c0d00ebe <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00f08:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00f0a:	9a01      	ldr	r2, [sp, #4]
c0d00f0c:	4290      	cmp	r0, r2
c0d00f0e:	d1d6      	bne.n	c0d00ebe <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00f10:	b003      	add	sp, #12
c0d00f12:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f14:	4803      	ldr	r0, [pc, #12]	; (c0d00f24 <io_usb_send_ep+0xb4>)
c0d00f16:	6800      	ldr	r0, [r0, #0]
c0d00f18:	2110      	movs	r1, #16
c0d00f1a:	f002 f971 	bl	c0d03200 <longjmp>
c0d00f1e:	46c0      	nop			; (mov r8, r8)
c0d00f20:	20001a18 	.word	0x20001a18
c0d00f24:	20001bb8 	.word	0x20001bb8

c0d00f28 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00f28:	b580      	push	{r7, lr}
c0d00f2a:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00f2c:	480d      	ldr	r0, [pc, #52]	; (c0d00f64 <io_seproxyhal_handle_event+0x3c>)
c0d00f2e:	7882      	ldrb	r2, [r0, #2]
c0d00f30:	7841      	ldrb	r1, [r0, #1]
c0d00f32:	0209      	lsls	r1, r1, #8
c0d00f34:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00f36:	7800      	ldrb	r0, [r0, #0]
c0d00f38:	2810      	cmp	r0, #16
c0d00f3a:	d008      	beq.n	c0d00f4e <io_seproxyhal_handle_event+0x26>
c0d00f3c:	280f      	cmp	r0, #15
c0d00f3e:	d10d      	bne.n	c0d00f5c <io_seproxyhal_handle_event+0x34>
c0d00f40:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d00f42:	2904      	cmp	r1, #4
c0d00f44:	d10d      	bne.n	c0d00f62 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00f46:	f7ff ff2d 	bl	c0d00da4 <io_seproxyhal_handle_usb_event>
c0d00f4a:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00f4c:	bd80      	pop	{r7, pc}
c0d00f4e:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d00f50:	2906      	cmp	r1, #6
c0d00f52:	d306      	bcc.n	c0d00f62 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00f54:	f7ff ff64 	bl	c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00f58:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00f5a:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d00f5c:	2002      	movs	r0, #2
c0d00f5e:	f7ff faf5 	bl	c0d0054c <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d00f62:	bd80      	pop	{r7, pc}
c0d00f64:	20001a18 	.word	0x20001a18

c0d00f68 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00f68:	b580      	push	{r7, lr}
c0d00f6a:	af00      	add	r7, sp, #0
c0d00f6c:	460a      	mov	r2, r1
c0d00f6e:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00f70:	2082      	movs	r0, #130	; 0x82
c0d00f72:	2314      	movs	r3, #20
c0d00f74:	f7ff ff7c 	bl	c0d00e70 <io_usb_send_ep>
}
c0d00f78:	bd80      	pop	{r7, pc}
	...

c0d00f7c <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d00f7c:	b5d0      	push	{r4, r6, r7, lr}
c0d00f7e:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00f80:	2007      	movs	r0, #7
c0d00f82:	f000 fcf7 	bl	c0d01974 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d00f86:	480a      	ldr	r0, [pc, #40]	; (c0d00fb0 <io_seproxyhal_init+0x34>)
c0d00f88:	2400      	movs	r4, #0
c0d00f8a:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d00f8c:	4809      	ldr	r0, [pc, #36]	; (c0d00fb4 <io_seproxyhal_init+0x38>)
c0d00f8e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d00f90:	4809      	ldr	r0, [pc, #36]	; (c0d00fb8 <io_seproxyhal_init+0x3c>)
c0d00f92:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d00f94:	4809      	ldr	r0, [pc, #36]	; (c0d00fbc <io_seproxyhal_init+0x40>)
c0d00f96:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d00f98:	4809      	ldr	r0, [pc, #36]	; (c0d00fc0 <io_seproxyhal_init+0x44>)
c0d00f9a:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00f9c:	f7ff fe6e 	bl	c0d00c7c <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00fa0:	4808      	ldr	r0, [pc, #32]	; (c0d00fc4 <io_seproxyhal_init+0x48>)
c0d00fa2:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d00fa4:	4808      	ldr	r0, [pc, #32]	; (c0d00fc8 <io_seproxyhal_init+0x4c>)
c0d00fa6:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d00fa8:	4808      	ldr	r0, [pc, #32]	; (c0d00fcc <io_seproxyhal_init+0x50>)
c0d00faa:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00fac:	bdd0      	pop	{r4, r6, r7, pc}
c0d00fae:	46c0      	nop			; (mov r8, r8)
c0d00fb0:	20001d18 	.word	0x20001d18
c0d00fb4:	20001d1a 	.word	0x20001d1a
c0d00fb8:	20001d1c 	.word	0x20001d1c
c0d00fbc:	20001d1e 	.word	0x20001d1e
c0d00fc0:	20001d10 	.word	0x20001d10
c0d00fc4:	20001d20 	.word	0x20001d20
c0d00fc8:	20001d24 	.word	0x20001d24
c0d00fcc:	20001d28 	.word	0x20001d28

c0d00fd0 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00fd0:	4801      	ldr	r0, [pc, #4]	; (c0d00fd8 <io_seproxyhal_init_ux+0x8>)
c0d00fd2:	2100      	movs	r1, #0
c0d00fd4:	6001      	str	r1, [r0, #0]

}
c0d00fd6:	4770      	bx	lr
c0d00fd8:	20001d20 	.word	0x20001d20

c0d00fdc <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00fdc:	b5b0      	push	{r4, r5, r7, lr}
c0d00fde:	af02      	add	r7, sp, #8
c0d00fe0:	460d      	mov	r5, r1
c0d00fe2:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d00fe4:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d00fe6:	2800      	cmp	r0, #0
c0d00fe8:	d00c      	beq.n	c0d01004 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d00fea:	f000 fcab 	bl	c0d01944 <pic>
c0d00fee:	4601      	mov	r1, r0
c0d00ff0:	4620      	mov	r0, r4
c0d00ff2:	4788      	blx	r1
c0d00ff4:	f000 fca6 	bl	c0d01944 <pic>
c0d00ff8:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d00ffa:	2800      	cmp	r0, #0
c0d00ffc:	d010      	beq.n	c0d01020 <io_seproxyhal_touch_out+0x44>
c0d00ffe:	2801      	cmp	r0, #1
c0d01000:	d000      	beq.n	c0d01004 <io_seproxyhal_touch_out+0x28>
c0d01002:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01004:	2d00      	cmp	r5, #0
c0d01006:	d007      	beq.n	c0d01018 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d01008:	4620      	mov	r0, r4
c0d0100a:	47a8      	blx	r5
c0d0100c:	2100      	movs	r1, #0
    if (!el) {
c0d0100e:	2800      	cmp	r0, #0
c0d01010:	d006      	beq.n	c0d01020 <io_seproxyhal_touch_out+0x44>
c0d01012:	2801      	cmp	r0, #1
c0d01014:	d000      	beq.n	c0d01018 <io_seproxyhal_touch_out+0x3c>
c0d01016:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01018:	4620      	mov	r0, r4
c0d0101a:	f7ff fa91 	bl	c0d00540 <io_seproxyhal_display>
c0d0101e:	2101      	movs	r1, #1
  return 1;
}
c0d01020:	4608      	mov	r0, r1
c0d01022:	bdb0      	pop	{r4, r5, r7, pc}

c0d01024 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01024:	b5b0      	push	{r4, r5, r7, lr}
c0d01026:	af02      	add	r7, sp, #8
c0d01028:	b08e      	sub	sp, #56	; 0x38
c0d0102a:	460c      	mov	r4, r1
c0d0102c:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d0102e:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01030:	2800      	cmp	r0, #0
c0d01032:	d00c      	beq.n	c0d0104e <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01034:	f000 fc86 	bl	c0d01944 <pic>
c0d01038:	4601      	mov	r1, r0
c0d0103a:	4628      	mov	r0, r5
c0d0103c:	4788      	blx	r1
c0d0103e:	f000 fc81 	bl	c0d01944 <pic>
c0d01042:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01044:	2800      	cmp	r0, #0
c0d01046:	d016      	beq.n	c0d01076 <io_seproxyhal_touch_over+0x52>
c0d01048:	2801      	cmp	r0, #1
c0d0104a:	d000      	beq.n	c0d0104e <io_seproxyhal_touch_over+0x2a>
c0d0104c:	4605      	mov	r5, r0
c0d0104e:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01050:	2238      	movs	r2, #56	; 0x38
c0d01052:	4629      	mov	r1, r5
c0d01054:	f7ff fdf6 	bl	c0d00c44 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01058:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0105a:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d0105c:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0105e:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01060:	2c00      	cmp	r4, #0
c0d01062:	d004      	beq.n	c0d0106e <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01064:	4628      	mov	r0, r5
c0d01066:	47a0      	blx	r4
c0d01068:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0106a:	2800      	cmp	r0, #0
c0d0106c:	d003      	beq.n	c0d01076 <io_seproxyhal_touch_over+0x52>
c0d0106e:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01070:	f7ff fa66 	bl	c0d00540 <io_seproxyhal_display>
c0d01074:	2101      	movs	r1, #1
  return 1;
}
c0d01076:	4608      	mov	r0, r1
c0d01078:	b00e      	add	sp, #56	; 0x38
c0d0107a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0107c <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0107c:	b5b0      	push	{r4, r5, r7, lr}
c0d0107e:	af02      	add	r7, sp, #8
c0d01080:	460d      	mov	r5, r1
c0d01082:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01084:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01086:	2800      	cmp	r0, #0
c0d01088:	d00c      	beq.n	c0d010a4 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0108a:	f000 fc5b 	bl	c0d01944 <pic>
c0d0108e:	4601      	mov	r1, r0
c0d01090:	4620      	mov	r0, r4
c0d01092:	4788      	blx	r1
c0d01094:	f000 fc56 	bl	c0d01944 <pic>
c0d01098:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0109a:	2800      	cmp	r0, #0
c0d0109c:	d010      	beq.n	c0d010c0 <io_seproxyhal_touch_tap+0x44>
c0d0109e:	2801      	cmp	r0, #1
c0d010a0:	d000      	beq.n	c0d010a4 <io_seproxyhal_touch_tap+0x28>
c0d010a2:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d010a4:	2d00      	cmp	r5, #0
c0d010a6:	d007      	beq.n	c0d010b8 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d010a8:	4620      	mov	r0, r4
c0d010aa:	47a8      	blx	r5
c0d010ac:	2100      	movs	r1, #0
    if (!el) {
c0d010ae:	2800      	cmp	r0, #0
c0d010b0:	d006      	beq.n	c0d010c0 <io_seproxyhal_touch_tap+0x44>
c0d010b2:	2801      	cmp	r0, #1
c0d010b4:	d000      	beq.n	c0d010b8 <io_seproxyhal_touch_tap+0x3c>
c0d010b6:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d010b8:	4620      	mov	r0, r4
c0d010ba:	f7ff fa41 	bl	c0d00540 <io_seproxyhal_display>
c0d010be:	2101      	movs	r1, #1
  return 1;
}
c0d010c0:	4608      	mov	r0, r1
c0d010c2:	bdb0      	pop	{r4, r5, r7, pc}

c0d010c4 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d010c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010c6:	af03      	add	r7, sp, #12
c0d010c8:	b087      	sub	sp, #28
c0d010ca:	9302      	str	r3, [sp, #8]
c0d010cc:	9203      	str	r2, [sp, #12]
c0d010ce:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d010d0:	2900      	cmp	r1, #0
c0d010d2:	d076      	beq.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
c0d010d4:	9004      	str	r0, [sp, #16]
c0d010d6:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d010d8:	9001      	str	r0, [sp, #4]
c0d010da:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d010dc:	9000      	str	r0, [sp, #0]
c0d010de:	2600      	movs	r6, #0
c0d010e0:	9606      	str	r6, [sp, #24]
c0d010e2:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d010e4:	f000 fe08 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d010e8:	2800      	cmp	r0, #0
c0d010ea:	d155      	bne.n	c0d01198 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d010ec:	2038      	movs	r0, #56	; 0x38
c0d010ee:	4370      	muls	r0, r6
c0d010f0:	9d04      	ldr	r5, [sp, #16]
c0d010f2:	182e      	adds	r6, r5, r0
c0d010f4:	4b36      	ldr	r3, [pc, #216]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d010f6:	681a      	ldr	r2, [r3, #0]
c0d010f8:	2101      	movs	r1, #1
c0d010fa:	4296      	cmp	r6, r2
c0d010fc:	d000      	beq.n	c0d01100 <io_seproxyhal_touch_element_callback+0x3c>
c0d010fe:	9906      	ldr	r1, [sp, #24]
c0d01100:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01102:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01104:	2800      	cmp	r0, #0
c0d01106:	da41      	bge.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
c0d01108:	2020      	movs	r0, #32
c0d0110a:	5c35      	ldrb	r5, [r6, r0]
c0d0110c:	2102      	movs	r1, #2
c0d0110e:	5e71      	ldrsh	r1, [r6, r1]
c0d01110:	1b4a      	subs	r2, r1, r5
c0d01112:	9803      	ldr	r0, [sp, #12]
c0d01114:	4282      	cmp	r2, r0
c0d01116:	dc39      	bgt.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
c0d01118:	1869      	adds	r1, r5, r1
c0d0111a:	88f2      	ldrh	r2, [r6, #6]
c0d0111c:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d0111e:	9803      	ldr	r0, [sp, #12]
c0d01120:	4288      	cmp	r0, r1
c0d01122:	da33      	bge.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
c0d01124:	2104      	movs	r1, #4
c0d01126:	5e70      	ldrsh	r0, [r6, r1]
c0d01128:	1b42      	subs	r2, r0, r5
c0d0112a:	9902      	ldr	r1, [sp, #8]
c0d0112c:	428a      	cmp	r2, r1
c0d0112e:	dc2d      	bgt.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
c0d01130:	1940      	adds	r0, r0, r5
c0d01132:	8931      	ldrh	r1, [r6, #8]
c0d01134:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01136:	9902      	ldr	r1, [sp, #8]
c0d01138:	4281      	cmp	r1, r0
c0d0113a:	da27      	bge.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d0113c:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d0113e:	4286      	cmp	r6, r0
c0d01140:	d010      	beq.n	c0d01164 <io_seproxyhal_touch_element_callback+0xa0>
c0d01142:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01144:	2800      	cmp	r0, #0
c0d01146:	d00d      	beq.n	c0d01164 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01148:	9801      	ldr	r0, [sp, #4]
c0d0114a:	2800      	cmp	r0, #0
c0d0114c:	d005      	beq.n	c0d0115a <io_seproxyhal_touch_element_callback+0x96>
c0d0114e:	4630      	mov	r0, r6
c0d01150:	9901      	ldr	r1, [sp, #4]
c0d01152:	4788      	blx	r1
c0d01154:	4b1e      	ldr	r3, [pc, #120]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01156:	2800      	cmp	r0, #0
c0d01158:	d018      	beq.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0115a:	6818      	ldr	r0, [r3, #0]
c0d0115c:	9901      	ldr	r1, [sp, #4]
c0d0115e:	f7ff ff3d 	bl	c0d00fdc <io_seproxyhal_touch_out>
c0d01162:	e008      	b.n	c0d01176 <io_seproxyhal_touch_element_callback+0xb2>
c0d01164:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01166:	2801      	cmp	r0, #1
c0d01168:	d009      	beq.n	c0d0117e <io_seproxyhal_touch_element_callback+0xba>
c0d0116a:	2802      	cmp	r0, #2
c0d0116c:	d10e      	bne.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d0116e:	4630      	mov	r0, r6
c0d01170:	9901      	ldr	r1, [sp, #4]
c0d01172:	f7ff ff83 	bl	c0d0107c <io_seproxyhal_touch_tap>
c0d01176:	4b16      	ldr	r3, [pc, #88]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01178:	2800      	cmp	r0, #0
c0d0117a:	d007      	beq.n	c0d0118c <io_seproxyhal_touch_element_callback+0xc8>
c0d0117c:	e023      	b.n	c0d011c6 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0117e:	4630      	mov	r0, r6
c0d01180:	9901      	ldr	r1, [sp, #4]
c0d01182:	f7ff ff4f 	bl	c0d01024 <io_seproxyhal_touch_over>
c0d01186:	4b12      	ldr	r3, [pc, #72]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01188:	2800      	cmp	r0, #0
c0d0118a:	d11f      	bne.n	c0d011cc <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d0118c:	1c64      	adds	r4, r4, #1
c0d0118e:	b2e6      	uxtb	r6, r4
c0d01190:	9805      	ldr	r0, [sp, #20]
c0d01192:	4286      	cmp	r6, r0
c0d01194:	d3a6      	bcc.n	c0d010e4 <io_seproxyhal_touch_element_callback+0x20>
c0d01196:	e000      	b.n	c0d0119a <io_seproxyhal_touch_element_callback+0xd6>
c0d01198:	4b0d      	ldr	r3, [pc, #52]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0119a:	9806      	ldr	r0, [sp, #24]
c0d0119c:	0600      	lsls	r0, r0, #24
c0d0119e:	d010      	beq.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
c0d011a0:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d011a2:	2800      	cmp	r0, #0
c0d011a4:	d00d      	beq.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d011a6:	f000 fda7 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d011aa:	4909      	ldr	r1, [pc, #36]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d011ac:	2800      	cmp	r0, #0
c0d011ae:	d108      	bne.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d011b0:	6808      	ldr	r0, [r1, #0]
c0d011b2:	9901      	ldr	r1, [sp, #4]
c0d011b4:	f7ff ff12 	bl	c0d00fdc <io_seproxyhal_touch_out>
c0d011b8:	4d05      	ldr	r5, [pc, #20]	; (c0d011d0 <io_seproxyhal_touch_element_callback+0x10c>)
c0d011ba:	2800      	cmp	r0, #0
c0d011bc:	d001      	beq.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d011be:	2000      	movs	r0, #0
c0d011c0:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d011c2:	b007      	add	sp, #28
c0d011c4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d011c6:	2000      	movs	r0, #0
c0d011c8:	6018      	str	r0, [r3, #0]
c0d011ca:	e7fa      	b.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d011cc:	601e      	str	r6, [r3, #0]
c0d011ce:	e7f8      	b.n	c0d011c2 <io_seproxyhal_touch_element_callback+0xfe>
c0d011d0:	20001d20 	.word	0x20001d20

c0d011d4 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d011d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011d6:	af03      	add	r7, sp, #12
c0d011d8:	b08b      	sub	sp, #44	; 0x2c
c0d011da:	460c      	mov	r4, r1
c0d011dc:	4601      	mov	r1, r0
c0d011de:	ad04      	add	r5, sp, #16
c0d011e0:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d011e2:	4628      	mov	r0, r5
c0d011e4:	9203      	str	r2, [sp, #12]
c0d011e6:	f7ff fd2d 	bl	c0d00c44 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d011ea:	6821      	ldr	r1, [r4, #0]
c0d011ec:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d011ee:	6862      	ldr	r2, [r4, #4]
c0d011f0:	9502      	str	r5, [sp, #8]
c0d011f2:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d011f4:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d011f6:	4e1a      	ldr	r6, [pc, #104]	; (c0d01260 <io_seproxyhal_display_icon+0x8c>)
c0d011f8:	2365      	movs	r3, #101	; 0x65
c0d011fa:	4635      	mov	r5, r6
c0d011fc:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d011fe:	b292      	uxth	r2, r2
c0d01200:	4342      	muls	r2, r0
c0d01202:	b28b      	uxth	r3, r1
c0d01204:	4353      	muls	r3, r2
c0d01206:	08d9      	lsrs	r1, r3, #3
c0d01208:	1c4e      	adds	r6, r1, #1
c0d0120a:	2207      	movs	r2, #7
c0d0120c:	4213      	tst	r3, r2
c0d0120e:	d100      	bne.n	c0d01212 <io_seproxyhal_display_icon+0x3e>
c0d01210:	460e      	mov	r6, r1
c0d01212:	4631      	mov	r1, r6
c0d01214:	9101      	str	r1, [sp, #4]
c0d01216:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01218:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d0121a:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d0121c:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0121e:	0a01      	lsrs	r1, r0, #8
c0d01220:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01222:	70a8      	strb	r0, [r5, #2]
c0d01224:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01226:	4628      	mov	r0, r5
c0d01228:	f000 fd48 	bl	c0d01cbc <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d0122c:	9802      	ldr	r0, [sp, #8]
c0d0122e:	9903      	ldr	r1, [sp, #12]
c0d01230:	f000 fd44 	bl	c0d01cbc <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01234:	68a0      	ldr	r0, [r4, #8]
c0d01236:	7028      	strb	r0, [r5, #0]
c0d01238:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0123a:	4628      	mov	r0, r5
c0d0123c:	f000 fd3e 	bl	c0d01cbc <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01240:	68e0      	ldr	r0, [r4, #12]
c0d01242:	f000 fb7f 	bl	c0d01944 <pic>
c0d01246:	b2b1      	uxth	r1, r6
c0d01248:	f000 fd38 	bl	c0d01cbc <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d0124c:	9801      	ldr	r0, [sp, #4]
c0d0124e:	b285      	uxth	r5, r0
c0d01250:	6920      	ldr	r0, [r4, #16]
c0d01252:	f000 fb77 	bl	c0d01944 <pic>
c0d01256:	4629      	mov	r1, r5
c0d01258:	f000 fd30 	bl	c0d01cbc <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d0125c:	b00b      	add	sp, #44	; 0x2c
c0d0125e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01260:	20001a18 	.word	0x20001a18

c0d01264 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01264:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01266:	af03      	add	r7, sp, #12
c0d01268:	b081      	sub	sp, #4
c0d0126a:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d0126c:	7820      	ldrb	r0, [r4, #0]
c0d0126e:	267f      	movs	r6, #127	; 0x7f
c0d01270:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01272:	2e00      	cmp	r6, #0
c0d01274:	d02e      	beq.n	c0d012d4 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01276:	69e0      	ldr	r0, [r4, #28]
c0d01278:	2800      	cmp	r0, #0
c0d0127a:	d01d      	beq.n	c0d012b8 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d0127c:	f000 fb62 	bl	c0d01944 <pic>
c0d01280:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01282:	2e05      	cmp	r6, #5
c0d01284:	d102      	bne.n	c0d0128c <io_seproxyhal_display_default+0x28>
c0d01286:	7ea0      	ldrb	r0, [r4, #26]
c0d01288:	2800      	cmp	r0, #0
c0d0128a:	d025      	beq.n	c0d012d8 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0128c:	4628      	mov	r0, r5
c0d0128e:	f001 ffc5 	bl	c0d0321c <strlen>
c0d01292:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01294:	4813      	ldr	r0, [pc, #76]	; (c0d012e4 <io_seproxyhal_display_default+0x80>)
c0d01296:	2165      	movs	r1, #101	; 0x65
c0d01298:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0129a:	4631      	mov	r1, r6
c0d0129c:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0129e:	0a0a      	lsrs	r2, r1, #8
c0d012a0:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d012a2:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d012a4:	2103      	movs	r1, #3
c0d012a6:	f000 fd09 	bl	c0d01cbc <io_seproxyhal_spi_send>
c0d012aa:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d012ac:	4620      	mov	r0, r4
c0d012ae:	f000 fd05 	bl	c0d01cbc <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d012b2:	b2b1      	uxth	r1, r6
c0d012b4:	4628      	mov	r0, r5
c0d012b6:	e00b      	b.n	c0d012d0 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d012b8:	480a      	ldr	r0, [pc, #40]	; (c0d012e4 <io_seproxyhal_display_default+0x80>)
c0d012ba:	2165      	movs	r1, #101	; 0x65
c0d012bc:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d012be:	2100      	movs	r1, #0
c0d012c0:	7041      	strb	r1, [r0, #1]
c0d012c2:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d012c4:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d012c6:	2103      	movs	r1, #3
c0d012c8:	f000 fcf8 	bl	c0d01cbc <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d012cc:	4620      	mov	r0, r4
c0d012ce:	4629      	mov	r1, r5
c0d012d0:	f000 fcf4 	bl	c0d01cbc <io_seproxyhal_spi_send>
    }
  }
}
c0d012d4:	b001      	add	sp, #4
c0d012d6:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d012d8:	4620      	mov	r0, r4
c0d012da:	4629      	mov	r1, r5
c0d012dc:	f7ff ff7a 	bl	c0d011d4 <io_seproxyhal_display_icon>
c0d012e0:	e7f8      	b.n	c0d012d4 <io_seproxyhal_display_default+0x70>
c0d012e2:	46c0      	nop			; (mov r8, r8)
c0d012e4:	20001a18 	.word	0x20001a18

c0d012e8 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d012e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012ea:	af03      	add	r7, sp, #12
c0d012ec:	b081      	sub	sp, #4
c0d012ee:	4604      	mov	r4, r0
  if (button_callback) {
c0d012f0:	2c00      	cmp	r4, #0
c0d012f2:	d02e      	beq.n	c0d01352 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d012f4:	4818      	ldr	r0, [pc, #96]	; (c0d01358 <io_seproxyhal_button_push+0x70>)
c0d012f6:	6802      	ldr	r2, [r0, #0]
c0d012f8:	428a      	cmp	r2, r1
c0d012fa:	d103      	bne.n	c0d01304 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d012fc:	4a17      	ldr	r2, [pc, #92]	; (c0d0135c <io_seproxyhal_button_push+0x74>)
c0d012fe:	6813      	ldr	r3, [r2, #0]
c0d01300:	1c5b      	adds	r3, r3, #1
c0d01302:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01304:	6806      	ldr	r6, [r0, #0]
c0d01306:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01308:	4a14      	ldr	r2, [pc, #80]	; (c0d0135c <io_seproxyhal_button_push+0x74>)
c0d0130a:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d0130c:	2900      	cmp	r1, #0
c0d0130e:	d001      	beq.n	c0d01314 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01310:	6006      	str	r6, [r0, #0]
c0d01312:	e005      	b.n	c0d01320 <io_seproxyhal_button_push+0x38>
c0d01314:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01316:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01318:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d0131a:	2301      	movs	r3, #1
c0d0131c:	07db      	lsls	r3, r3, #31
c0d0131e:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01320:	6800      	ldr	r0, [r0, #0]
c0d01322:	4288      	cmp	r0, r1
c0d01324:	d001      	beq.n	c0d0132a <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01326:	2000      	movs	r0, #0
c0d01328:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0132a:	2d08      	cmp	r5, #8
c0d0132c:	d30e      	bcc.n	c0d0134c <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0132e:	2103      	movs	r1, #3
c0d01330:	4628      	mov	r0, r5
c0d01332:	f001 fda7 	bl	c0d02e84 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01336:	2001      	movs	r0, #1
c0d01338:	0780      	lsls	r0, r0, #30
c0d0133a:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0133c:	2900      	cmp	r1, #0
c0d0133e:	4601      	mov	r1, r0
c0d01340:	d000      	beq.n	c0d01344 <io_seproxyhal_button_push+0x5c>
c0d01342:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01344:	2900      	cmp	r1, #0
c0d01346:	db02      	blt.n	c0d0134e <io_seproxyhal_button_push+0x66>
c0d01348:	4608      	mov	r0, r1
c0d0134a:	e000      	b.n	c0d0134e <io_seproxyhal_button_push+0x66>
c0d0134c:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0134e:	4629      	mov	r1, r5
c0d01350:	47a0      	blx	r4
  }
}
c0d01352:	b001      	add	sp, #4
c0d01354:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01356:	46c0      	nop			; (mov r8, r8)
c0d01358:	20001d24 	.word	0x20001d24
c0d0135c:	20001d28 	.word	0x20001d28

c0d01360 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01360:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01362:	af03      	add	r7, sp, #12
c0d01364:	b081      	sub	sp, #4
c0d01366:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01368:	200f      	movs	r0, #15
c0d0136a:	4204      	tst	r4, r0
c0d0136c:	d006      	beq.n	c0d0137c <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d0136e:	4620      	mov	r0, r4
c0d01370:	f7ff f8be 	bl	c0d004f0 <io_exchange_al>
c0d01374:	4605      	mov	r5, r0
  }
}
c0d01376:	b2a8      	uxth	r0, r5
c0d01378:	b001      	add	sp, #4
c0d0137a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d0137c:	2610      	movs	r6, #16
c0d0137e:	4026      	ands	r6, r4
c0d01380:	2900      	cmp	r1, #0
c0d01382:	d02a      	beq.n	c0d013da <io_exchange+0x7a>
c0d01384:	2e00      	cmp	r6, #0
c0d01386:	d128      	bne.n	c0d013da <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01388:	483d      	ldr	r0, [pc, #244]	; (c0d01480 <io_exchange+0x120>)
c0d0138a:	7800      	ldrb	r0, [r0, #0]
c0d0138c:	2807      	cmp	r0, #7
c0d0138e:	d00b      	beq.n	c0d013a8 <io_exchange+0x48>
c0d01390:	2800      	cmp	r0, #0
c0d01392:	d004      	beq.n	c0d0139e <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01394:	4620      	mov	r0, r4
c0d01396:	f7ff f8ab 	bl	c0d004f0 <io_exchange_al>
c0d0139a:	2800      	cmp	r0, #0
c0d0139c:	d00a      	beq.n	c0d013b4 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d0139e:	4839      	ldr	r0, [pc, #228]	; (c0d01484 <io_exchange+0x124>)
c0d013a0:	6800      	ldr	r0, [r0, #0]
c0d013a2:	2109      	movs	r1, #9
c0d013a4:	f001 ff2c 	bl	c0d03200 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d013a8:	483d      	ldr	r0, [pc, #244]	; (c0d014a0 <io_exchange+0x140>)
c0d013aa:	4478      	add	r0, pc
c0d013ac:	2200      	movs	r2, #0
c0d013ae:	2320      	movs	r3, #32
c0d013b0:	f7ff fc6a 	bl	c0d00c88 <io_usb_hid_exchange>
c0d013b4:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d013b6:	4832      	ldr	r0, [pc, #200]	; (c0d01480 <io_exchange+0x120>)
c0d013b8:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d013ba:	4833      	ldr	r0, [pc, #204]	; (c0d01488 <io_exchange+0x128>)
c0d013bc:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d013be:	4833      	ldr	r0, [pc, #204]	; (c0d0148c <io_exchange+0x12c>)
c0d013c0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d013c2:	4833      	ldr	r0, [pc, #204]	; (c0d01490 <io_exchange+0x130>)
c0d013c4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d013c6:	4833      	ldr	r0, [pc, #204]	; (c0d01494 <io_exchange+0x134>)
c0d013c8:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d013ca:	06a0      	lsls	r0, r4, #26
c0d013cc:	d4d3      	bmi.n	c0d01376 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d013ce:	f7ff fcd3 	bl	c0d00d78 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d013d2:	0620      	lsls	r0, r4, #24
c0d013d4:	d501      	bpl.n	c0d013da <io_exchange+0x7a>
        reset();
c0d013d6:	f000 faeb 	bl	c0d019b0 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d013da:	2e00      	cmp	r6, #0
c0d013dc:	d10c      	bne.n	c0d013f8 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d013de:	0660      	lsls	r0, r4, #25
c0d013e0:	d448      	bmi.n	c0d01474 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d013e2:	4827      	ldr	r0, [pc, #156]	; (c0d01480 <io_exchange+0x120>)
c0d013e4:	2100      	movs	r1, #0
c0d013e6:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d013e8:	4827      	ldr	r0, [pc, #156]	; (c0d01488 <io_exchange+0x128>)
c0d013ea:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d013ec:	4827      	ldr	r0, [pc, #156]	; (c0d0148c <io_exchange+0x12c>)
c0d013ee:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d013f0:	4827      	ldr	r0, [pc, #156]	; (c0d01490 <io_exchange+0x130>)
c0d013f2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d013f4:	4827      	ldr	r0, [pc, #156]	; (c0d01494 <io_exchange+0x134>)
c0d013f6:	7001      	strb	r1, [r0, #0]
c0d013f8:	4c28      	ldr	r4, [pc, #160]	; (c0d0149c <io_exchange+0x13c>)
c0d013fa:	4e24      	ldr	r6, [pc, #144]	; (c0d0148c <io_exchange+0x12c>)
c0d013fc:	e008      	b.n	c0d01410 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d013fe:	f7ff fd0f 	bl	c0d00e20 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01402:	8830      	ldrh	r0, [r6, #0]
c0d01404:	2800      	cmp	r0, #0
c0d01406:	d003      	beq.n	c0d01410 <io_exchange+0xb0>
c0d01408:	e032      	b.n	c0d01470 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d0140a:	2002      	movs	r0, #2
c0d0140c:	f7ff f89e 	bl	c0d0054c <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01410:	f000 fc72 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d01414:	2800      	cmp	r0, #0
c0d01416:	d101      	bne.n	c0d0141c <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01418:	f7ff fcae 	bl	c0d00d78 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0141c:	2180      	movs	r1, #128	; 0x80
c0d0141e:	2500      	movs	r5, #0
c0d01420:	4620      	mov	r0, r4
c0d01422:	462a      	mov	r2, r5
c0d01424:	f000 fc84 	bl	c0d01d30 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01428:	1ec1      	subs	r1, r0, #3
c0d0142a:	78a2      	ldrb	r2, [r4, #2]
c0d0142c:	7863      	ldrb	r3, [r4, #1]
c0d0142e:	021b      	lsls	r3, r3, #8
c0d01430:	4313      	orrs	r3, r2
c0d01432:	4299      	cmp	r1, r3
c0d01434:	d110      	bne.n	c0d01458 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01436:	4917      	ldr	r1, [pc, #92]	; (c0d01494 <io_exchange+0x134>)
c0d01438:	7809      	ldrb	r1, [r1, #0]
c0d0143a:	2900      	cmp	r1, #0
c0d0143c:	d002      	beq.n	c0d01444 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d0143e:	f7ff fd73 	bl	c0d00f28 <io_seproxyhal_handle_event>
c0d01442:	e7e5      	b.n	c0d01410 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01444:	7821      	ldrb	r1, [r4, #0]
c0d01446:	2910      	cmp	r1, #16
c0d01448:	d00f      	beq.n	c0d0146a <io_exchange+0x10a>
c0d0144a:	290f      	cmp	r1, #15
c0d0144c:	d1dd      	bne.n	c0d0140a <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d0144e:	2804      	cmp	r0, #4
c0d01450:	d102      	bne.n	c0d01458 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01452:	f7ff fca7 	bl	c0d00da4 <io_seproxyhal_handle_usb_event>
c0d01456:	e7db      	b.n	c0d01410 <io_exchange+0xb0>
c0d01458:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0145a:	4909      	ldr	r1, [pc, #36]	; (c0d01480 <io_exchange+0x120>)
c0d0145c:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d0145e:	490a      	ldr	r1, [pc, #40]	; (c0d01488 <io_exchange+0x128>)
c0d01460:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01462:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01464:	490a      	ldr	r1, [pc, #40]	; (c0d01490 <io_exchange+0x130>)
c0d01466:	8008      	strh	r0, [r1, #0]
c0d01468:	e7d2      	b.n	c0d01410 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0146a:	2806      	cmp	r0, #6
c0d0146c:	d2c7      	bcs.n	c0d013fe <io_exchange+0x9e>
c0d0146e:	e782      	b.n	c0d01376 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01470:	8835      	ldrh	r5, [r6, #0]
c0d01472:	e780      	b.n	c0d01376 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01474:	4805      	ldr	r0, [pc, #20]	; (c0d0148c <io_exchange+0x12c>)
c0d01476:	8800      	ldrh	r0, [r0, #0]
c0d01478:	4907      	ldr	r1, [pc, #28]	; (c0d01498 <io_exchange+0x138>)
c0d0147a:	1845      	adds	r5, r0, r1
c0d0147c:	e77b      	b.n	c0d01376 <io_exchange+0x16>
c0d0147e:	46c0      	nop			; (mov r8, r8)
c0d01480:	20001d18 	.word	0x20001d18
c0d01484:	20001bb8 	.word	0x20001bb8
c0d01488:	20001d1a 	.word	0x20001d1a
c0d0148c:	20001d1c 	.word	0x20001d1c
c0d01490:	20001d1e 	.word	0x20001d1e
c0d01494:	20001d10 	.word	0x20001d10
c0d01498:	0000fffb 	.word	0x0000fffb
c0d0149c:	20001a18 	.word	0x20001a18
c0d014a0:	fffffbbb 	.word	0xfffffbbb

c0d014a4 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d014a4:	b081      	sub	sp, #4
c0d014a6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014a8:	af03      	add	r7, sp, #12
c0d014aa:	b094      	sub	sp, #80	; 0x50
c0d014ac:	4616      	mov	r6, r2
c0d014ae:	460d      	mov	r5, r1
c0d014b0:	900e      	str	r0, [sp, #56]	; 0x38
c0d014b2:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d014b4:	2d02      	cmp	r5, #2
c0d014b6:	d200      	bcs.n	c0d014ba <snprintf+0x16>
c0d014b8:	e22a      	b.n	c0d01910 <snprintf+0x46c>
c0d014ba:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d014bc:	2800      	cmp	r0, #0
c0d014be:	d100      	bne.n	c0d014c2 <snprintf+0x1e>
c0d014c0:	e226      	b.n	c0d01910 <snprintf+0x46c>
c0d014c2:	2e00      	cmp	r6, #0
c0d014c4:	d100      	bne.n	c0d014c8 <snprintf+0x24>
c0d014c6:	e223      	b.n	c0d01910 <snprintf+0x46c>
c0d014c8:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d014ca:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d014cc:	9109      	str	r1, [sp, #36]	; 0x24
c0d014ce:	462a      	mov	r2, r5
c0d014d0:	f7ff fbae 	bl	c0d00c30 <os_memset>
c0d014d4:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d014d6:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d014d8:	7830      	ldrb	r0, [r6, #0]
c0d014da:	2800      	cmp	r0, #0
c0d014dc:	d100      	bne.n	c0d014e0 <snprintf+0x3c>
c0d014de:	e217      	b.n	c0d01910 <snprintf+0x46c>
c0d014e0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d014e2:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d014e4:	1e6b      	subs	r3, r5, #1
c0d014e6:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d014e8:	460a      	mov	r2, r1
c0d014ea:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d014ec:	e003      	b.n	c0d014f6 <snprintf+0x52>
c0d014ee:	1970      	adds	r0, r6, r5
c0d014f0:	7840      	ldrb	r0, [r0, #1]
c0d014f2:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d014f4:	1c6d      	adds	r5, r5, #1
c0d014f6:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d014f8:	2800      	cmp	r0, #0
c0d014fa:	d001      	beq.n	c0d01500 <snprintf+0x5c>
c0d014fc:	2825      	cmp	r0, #37	; 0x25
c0d014fe:	d1f6      	bne.n	c0d014ee <snprintf+0x4a>
c0d01500:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01502:	429d      	cmp	r5, r3
c0d01504:	d300      	bcc.n	c0d01508 <snprintf+0x64>
c0d01506:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01508:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0150a:	4631      	mov	r1, r6
c0d0150c:	462a      	mov	r2, r5
c0d0150e:	461c      	mov	r4, r3
c0d01510:	f7ff fb98 	bl	c0d00c44 <os_memmove>
c0d01514:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01516:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01518:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0151a:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d0151c:	2b00      	cmp	r3, #0
c0d0151e:	d100      	bne.n	c0d01522 <snprintf+0x7e>
c0d01520:	e1f6      	b.n	c0d01910 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01522:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01524:	5d71      	ldrb	r1, [r6, r5]
c0d01526:	2925      	cmp	r1, #37	; 0x25
c0d01528:	d000      	beq.n	c0d0152c <snprintf+0x88>
c0d0152a:	e0ab      	b.n	c0d01684 <snprintf+0x1e0>
c0d0152c:	9304      	str	r3, [sp, #16]
c0d0152e:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01530:	1c40      	adds	r0, r0, #1
c0d01532:	2100      	movs	r1, #0
c0d01534:	2220      	movs	r2, #32
c0d01536:	920a      	str	r2, [sp, #40]	; 0x28
c0d01538:	220a      	movs	r2, #10
c0d0153a:	9203      	str	r2, [sp, #12]
c0d0153c:	9102      	str	r1, [sp, #8]
c0d0153e:	9106      	str	r1, [sp, #24]
c0d01540:	910d      	str	r1, [sp, #52]	; 0x34
c0d01542:	460b      	mov	r3, r1
c0d01544:	2102      	movs	r1, #2
c0d01546:	910c      	str	r1, [sp, #48]	; 0x30
c0d01548:	4606      	mov	r6, r0
c0d0154a:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d0154c:	7831      	ldrb	r1, [r6, #0]
c0d0154e:	1c76      	adds	r6, r6, #1
c0d01550:	2300      	movs	r3, #0
c0d01552:	2962      	cmp	r1, #98	; 0x62
c0d01554:	dc41      	bgt.n	c0d015da <snprintf+0x136>
c0d01556:	4608      	mov	r0, r1
c0d01558:	3825      	subs	r0, #37	; 0x25
c0d0155a:	2823      	cmp	r0, #35	; 0x23
c0d0155c:	d900      	bls.n	c0d01560 <snprintf+0xbc>
c0d0155e:	e094      	b.n	c0d0168a <snprintf+0x1e6>
c0d01560:	0040      	lsls	r0, r0, #1
c0d01562:	46c0      	nop			; (mov r8, r8)
c0d01564:	4478      	add	r0, pc
c0d01566:	8880      	ldrh	r0, [r0, #4]
c0d01568:	0040      	lsls	r0, r0, #1
c0d0156a:	4487      	add	pc, r0
c0d0156c:	0186012d 	.word	0x0186012d
c0d01570:	01860186 	.word	0x01860186
c0d01574:	00510186 	.word	0x00510186
c0d01578:	01860186 	.word	0x01860186
c0d0157c:	00580023 	.word	0x00580023
c0d01580:	00240186 	.word	0x00240186
c0d01584:	00240024 	.word	0x00240024
c0d01588:	00240024 	.word	0x00240024
c0d0158c:	00240024 	.word	0x00240024
c0d01590:	00240024 	.word	0x00240024
c0d01594:	01860024 	.word	0x01860024
c0d01598:	01860186 	.word	0x01860186
c0d0159c:	01860186 	.word	0x01860186
c0d015a0:	01860186 	.word	0x01860186
c0d015a4:	01860186 	.word	0x01860186
c0d015a8:	01860186 	.word	0x01860186
c0d015ac:	01860186 	.word	0x01860186
c0d015b0:	006c0186 	.word	0x006c0186
c0d015b4:	e7c9      	b.n	c0d0154a <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d015b6:	2930      	cmp	r1, #48	; 0x30
c0d015b8:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d015ba:	4603      	mov	r3, r0
c0d015bc:	d100      	bne.n	c0d015c0 <snprintf+0x11c>
c0d015be:	460b      	mov	r3, r1
c0d015c0:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d015c2:	2c00      	cmp	r4, #0
c0d015c4:	d000      	beq.n	c0d015c8 <snprintf+0x124>
c0d015c6:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d015c8:	200a      	movs	r0, #10
c0d015ca:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d015cc:	1840      	adds	r0, r0, r1
c0d015ce:	3830      	subs	r0, #48	; 0x30
c0d015d0:	900d      	str	r0, [sp, #52]	; 0x34
c0d015d2:	4630      	mov	r0, r6
c0d015d4:	930a      	str	r3, [sp, #40]	; 0x28
c0d015d6:	4613      	mov	r3, r2
c0d015d8:	e7b4      	b.n	c0d01544 <snprintf+0xa0>
c0d015da:	296f      	cmp	r1, #111	; 0x6f
c0d015dc:	dd11      	ble.n	c0d01602 <snprintf+0x15e>
c0d015de:	3970      	subs	r1, #112	; 0x70
c0d015e0:	2908      	cmp	r1, #8
c0d015e2:	d900      	bls.n	c0d015e6 <snprintf+0x142>
c0d015e4:	e149      	b.n	c0d0187a <snprintf+0x3d6>
c0d015e6:	0049      	lsls	r1, r1, #1
c0d015e8:	4479      	add	r1, pc
c0d015ea:	8889      	ldrh	r1, [r1, #4]
c0d015ec:	0049      	lsls	r1, r1, #1
c0d015ee:	448f      	add	pc, r1
c0d015f0:	01440051 	.word	0x01440051
c0d015f4:	002e0144 	.word	0x002e0144
c0d015f8:	00590144 	.word	0x00590144
c0d015fc:	01440144 	.word	0x01440144
c0d01600:	0051      	.short	0x0051
c0d01602:	2963      	cmp	r1, #99	; 0x63
c0d01604:	d054      	beq.n	c0d016b0 <snprintf+0x20c>
c0d01606:	2964      	cmp	r1, #100	; 0x64
c0d01608:	d057      	beq.n	c0d016ba <snprintf+0x216>
c0d0160a:	2968      	cmp	r1, #104	; 0x68
c0d0160c:	d01d      	beq.n	c0d0164a <snprintf+0x1a6>
c0d0160e:	e134      	b.n	c0d0187a <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01610:	7830      	ldrb	r0, [r6, #0]
c0d01612:	2873      	cmp	r0, #115	; 0x73
c0d01614:	d000      	beq.n	c0d01618 <snprintf+0x174>
c0d01616:	e130      	b.n	c0d0187a <snprintf+0x3d6>
c0d01618:	4630      	mov	r0, r6
c0d0161a:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0161c:	e00d      	b.n	c0d0163a <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d0161e:	7830      	ldrb	r0, [r6, #0]
c0d01620:	282a      	cmp	r0, #42	; 0x2a
c0d01622:	d000      	beq.n	c0d01626 <snprintf+0x182>
c0d01624:	e129      	b.n	c0d0187a <snprintf+0x3d6>
c0d01626:	7871      	ldrb	r1, [r6, #1]
c0d01628:	1c70      	adds	r0, r6, #1
c0d0162a:	2301      	movs	r3, #1
c0d0162c:	2948      	cmp	r1, #72	; 0x48
c0d0162e:	d004      	beq.n	c0d0163a <snprintf+0x196>
c0d01630:	2968      	cmp	r1, #104	; 0x68
c0d01632:	d002      	beq.n	c0d0163a <snprintf+0x196>
c0d01634:	2973      	cmp	r1, #115	; 0x73
c0d01636:	d000      	beq.n	c0d0163a <snprintf+0x196>
c0d01638:	e11f      	b.n	c0d0187a <snprintf+0x3d6>
c0d0163a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0163c:	1d0a      	adds	r2, r1, #4
c0d0163e:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01640:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01642:	9102      	str	r1, [sp, #8]
c0d01644:	e77e      	b.n	c0d01544 <snprintf+0xa0>
c0d01646:	2001      	movs	r0, #1
c0d01648:	9006      	str	r0, [sp, #24]
c0d0164a:	2010      	movs	r0, #16
c0d0164c:	9003      	str	r0, [sp, #12]
c0d0164e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01650:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01652:	1d01      	adds	r1, r0, #4
c0d01654:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01656:	2103      	movs	r1, #3
c0d01658:	400a      	ands	r2, r1
c0d0165a:	1c5b      	adds	r3, r3, #1
c0d0165c:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d0165e:	2a01      	cmp	r2, #1
c0d01660:	d100      	bne.n	c0d01664 <snprintf+0x1c0>
c0d01662:	e0b8      	b.n	c0d017d6 <snprintf+0x332>
c0d01664:	2a02      	cmp	r2, #2
c0d01666:	d100      	bne.n	c0d0166a <snprintf+0x1c6>
c0d01668:	e104      	b.n	c0d01874 <snprintf+0x3d0>
c0d0166a:	2a03      	cmp	r2, #3
c0d0166c:	4630      	mov	r0, r6
c0d0166e:	d100      	bne.n	c0d01672 <snprintf+0x1ce>
c0d01670:	e768      	b.n	c0d01544 <snprintf+0xa0>
c0d01672:	9c08      	ldr	r4, [sp, #32]
c0d01674:	4625      	mov	r5, r4
c0d01676:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01678:	1948      	adds	r0, r1, r5
c0d0167a:	7840      	ldrb	r0, [r0, #1]
c0d0167c:	1c6d      	adds	r5, r5, #1
c0d0167e:	2800      	cmp	r0, #0
c0d01680:	d1fa      	bne.n	c0d01678 <snprintf+0x1d4>
c0d01682:	e0ab      	b.n	c0d017dc <snprintf+0x338>
c0d01684:	4606      	mov	r6, r0
c0d01686:	920e      	str	r2, [sp, #56]	; 0x38
c0d01688:	e109      	b.n	c0d0189e <snprintf+0x3fa>
c0d0168a:	2958      	cmp	r1, #88	; 0x58
c0d0168c:	d000      	beq.n	c0d01690 <snprintf+0x1ec>
c0d0168e:	e0f4      	b.n	c0d0187a <snprintf+0x3d6>
c0d01690:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01692:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01694:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01696:	1d01      	adds	r1, r0, #4
c0d01698:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0169a:	6802      	ldr	r2, [r0, #0]
c0d0169c:	2000      	movs	r0, #0
c0d0169e:	9005      	str	r0, [sp, #20]
c0d016a0:	2510      	movs	r5, #16
c0d016a2:	e014      	b.n	c0d016ce <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d016a4:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d016a6:	1d01      	adds	r1, r0, #4
c0d016a8:	910f      	str	r1, [sp, #60]	; 0x3c
c0d016aa:	6802      	ldr	r2, [r0, #0]
c0d016ac:	2000      	movs	r0, #0
c0d016ae:	e00c      	b.n	c0d016ca <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d016b0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d016b2:	1d01      	adds	r1, r0, #4
c0d016b4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d016b6:	6800      	ldr	r0, [r0, #0]
c0d016b8:	e087      	b.n	c0d017ca <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d016ba:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d016bc:	1d01      	adds	r1, r0, #4
c0d016be:	910f      	str	r1, [sp, #60]	; 0x3c
c0d016c0:	6800      	ldr	r0, [r0, #0]
c0d016c2:	17c1      	asrs	r1, r0, #31
c0d016c4:	1842      	adds	r2, r0, r1
c0d016c6:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d016c8:	0fc0      	lsrs	r0, r0, #31
c0d016ca:	9005      	str	r0, [sp, #20]
c0d016cc:	250a      	movs	r5, #10
c0d016ce:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016d0:	4295      	cmp	r5, r2
c0d016d2:	920e      	str	r2, [sp, #56]	; 0x38
c0d016d4:	d814      	bhi.n	c0d01700 <snprintf+0x25c>
c0d016d6:	2201      	movs	r2, #1
c0d016d8:	4628      	mov	r0, r5
c0d016da:	920b      	str	r2, [sp, #44]	; 0x2c
c0d016dc:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d016de:	4629      	mov	r1, r5
c0d016e0:	f001 fb4a 	bl	c0d02d78 <__aeabi_uidiv>
c0d016e4:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d016e6:	4288      	cmp	r0, r1
c0d016e8:	d109      	bne.n	c0d016fe <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016ea:	4628      	mov	r0, r5
c0d016ec:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d016ee:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d016f0:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016f2:	910d      	str	r1, [sp, #52]	; 0x34
c0d016f4:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d016f6:	4288      	cmp	r0, r1
c0d016f8:	4622      	mov	r2, r4
c0d016fa:	d9ee      	bls.n	c0d016da <snprintf+0x236>
c0d016fc:	e000      	b.n	c0d01700 <snprintf+0x25c>
c0d016fe:	460c      	mov	r4, r1
c0d01700:	950c      	str	r5, [sp, #48]	; 0x30
c0d01702:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01704:	2000      	movs	r0, #0
c0d01706:	4603      	mov	r3, r0
c0d01708:	43c1      	mvns	r1, r0
c0d0170a:	9c05      	ldr	r4, [sp, #20]
c0d0170c:	2c00      	cmp	r4, #0
c0d0170e:	d100      	bne.n	c0d01712 <snprintf+0x26e>
c0d01710:	4621      	mov	r1, r4
c0d01712:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01714:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01716:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01718:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0171a:	b2ca      	uxtb	r2, r1
c0d0171c:	2a30      	cmp	r2, #48	; 0x30
c0d0171e:	d106      	bne.n	c0d0172e <snprintf+0x28a>
c0d01720:	2c00      	cmp	r4, #0
c0d01722:	d004      	beq.n	c0d0172e <snprintf+0x28a>
c0d01724:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01726:	232d      	movs	r3, #45	; 0x2d
c0d01728:	700b      	strb	r3, [r1, #0]
c0d0172a:	2400      	movs	r4, #0
c0d0172c:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d0172e:	1e81      	subs	r1, r0, #2
c0d01730:	290d      	cmp	r1, #13
c0d01732:	d80d      	bhi.n	c0d01750 <snprintf+0x2ac>
c0d01734:	1e41      	subs	r1, r0, #1
c0d01736:	d00b      	beq.n	c0d01750 <snprintf+0x2ac>
c0d01738:	a810      	add	r0, sp, #64	; 0x40
c0d0173a:	9405      	str	r4, [sp, #20]
c0d0173c:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d0173e:	4320      	orrs	r0, r4
c0d01740:	f001 fcc6 	bl	c0d030d0 <__aeabi_memset>
c0d01744:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01746:	1900      	adds	r0, r0, r4
c0d01748:	9c05      	ldr	r4, [sp, #20]
c0d0174a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0174c:	1840      	adds	r0, r0, r1
c0d0174e:	1e43      	subs	r3, r0, #1
c0d01750:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01752:	2c00      	cmp	r4, #0
c0d01754:	9601      	str	r6, [sp, #4]
c0d01756:	d003      	beq.n	c0d01760 <snprintf+0x2bc>
c0d01758:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d0175a:	222d      	movs	r2, #45	; 0x2d
c0d0175c:	54c2      	strb	r2, [r0, r3]
c0d0175e:	1c5b      	adds	r3, r3, #1
c0d01760:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01762:	2900      	cmp	r1, #0
c0d01764:	d003      	beq.n	c0d0176e <snprintf+0x2ca>
c0d01766:	2800      	cmp	r0, #0
c0d01768:	d003      	beq.n	c0d01772 <snprintf+0x2ce>
c0d0176a:	a06c      	add	r0, pc, #432	; (adr r0, c0d0191c <g_pcHex_cap>)
c0d0176c:	e002      	b.n	c0d01774 <snprintf+0x2d0>
c0d0176e:	461c      	mov	r4, r3
c0d01770:	e016      	b.n	c0d017a0 <snprintf+0x2fc>
c0d01772:	a06e      	add	r0, pc, #440	; (adr r0, c0d0192c <g_pcHex>)
c0d01774:	900d      	str	r0, [sp, #52]	; 0x34
c0d01776:	461c      	mov	r4, r3
c0d01778:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0177a:	460e      	mov	r6, r1
c0d0177c:	f001 fafc 	bl	c0d02d78 <__aeabi_uidiv>
c0d01780:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01782:	4629      	mov	r1, r5
c0d01784:	f001 fb7e 	bl	c0d02e84 <__aeabi_uidivmod>
c0d01788:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0178a:	5c40      	ldrb	r0, [r0, r1]
c0d0178c:	a910      	add	r1, sp, #64	; 0x40
c0d0178e:	5508      	strb	r0, [r1, r4]
c0d01790:	4630      	mov	r0, r6
c0d01792:	4629      	mov	r1, r5
c0d01794:	f001 faf0 	bl	c0d02d78 <__aeabi_uidiv>
c0d01798:	1c64      	adds	r4, r4, #1
c0d0179a:	42b5      	cmp	r5, r6
c0d0179c:	4601      	mov	r1, r0
c0d0179e:	d9eb      	bls.n	c0d01778 <snprintf+0x2d4>
c0d017a0:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d017a2:	429c      	cmp	r4, r3
c0d017a4:	4625      	mov	r5, r4
c0d017a6:	d300      	bcc.n	c0d017aa <snprintf+0x306>
c0d017a8:	461d      	mov	r5, r3
c0d017aa:	a910      	add	r1, sp, #64	; 0x40
c0d017ac:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d017ae:	4620      	mov	r0, r4
c0d017b0:	462a      	mov	r2, r5
c0d017b2:	461e      	mov	r6, r3
c0d017b4:	f7ff fa46 	bl	c0d00c44 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d017b8:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d017ba:	1961      	adds	r1, r4, r5
c0d017bc:	910e      	str	r1, [sp, #56]	; 0x38
c0d017be:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d017c0:	2800      	cmp	r0, #0
c0d017c2:	9e01      	ldr	r6, [sp, #4]
c0d017c4:	d16b      	bne.n	c0d0189e <snprintf+0x3fa>
c0d017c6:	e0a3      	b.n	c0d01910 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d017c8:	2025      	movs	r0, #37	; 0x25
c0d017ca:	9907      	ldr	r1, [sp, #28]
c0d017cc:	7008      	strb	r0, [r1, #0]
c0d017ce:	9804      	ldr	r0, [sp, #16]
c0d017d0:	1e40      	subs	r0, r0, #1
c0d017d2:	1c49      	adds	r1, r1, #1
c0d017d4:	e05f      	b.n	c0d01896 <snprintf+0x3f2>
c0d017d6:	9d02      	ldr	r5, [sp, #8]
c0d017d8:	9c08      	ldr	r4, [sp, #32]
c0d017da:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d017dc:	9803      	ldr	r0, [sp, #12]
c0d017de:	2810      	cmp	r0, #16
c0d017e0:	9807      	ldr	r0, [sp, #28]
c0d017e2:	d161      	bne.n	c0d018a8 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d017e4:	2d00      	cmp	r5, #0
c0d017e6:	d06a      	beq.n	c0d018be <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d017e8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d017ea:	1900      	adds	r0, r0, r4
c0d017ec:	900e      	str	r0, [sp, #56]	; 0x38
c0d017ee:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d017f0:	1aa0      	subs	r0, r4, r2
c0d017f2:	9b05      	ldr	r3, [sp, #20]
c0d017f4:	4283      	cmp	r3, r0
c0d017f6:	d800      	bhi.n	c0d017fa <snprintf+0x356>
c0d017f8:	4603      	mov	r3, r0
c0d017fa:	930c      	str	r3, [sp, #48]	; 0x30
c0d017fc:	435c      	muls	r4, r3
c0d017fe:	940a      	str	r4, [sp, #40]	; 0x28
c0d01800:	1c60      	adds	r0, r4, #1
c0d01802:	9007      	str	r0, [sp, #28]
c0d01804:	2000      	movs	r0, #0
c0d01806:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01808:	9100      	str	r1, [sp, #0]
c0d0180a:	940e      	str	r4, [sp, #56]	; 0x38
c0d0180c:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0180e:	18e3      	adds	r3, r4, r3
c0d01810:	900d      	str	r0, [sp, #52]	; 0x34
c0d01812:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01814:	200f      	movs	r0, #15
c0d01816:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01818:	0909      	lsrs	r1, r1, #4
c0d0181a:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d0181c:	18a4      	adds	r4, r4, r2
c0d0181e:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01820:	2c02      	cmp	r4, #2
c0d01822:	d375      	bcc.n	c0d01910 <snprintf+0x46c>
c0d01824:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01826:	2c01      	cmp	r4, #1
c0d01828:	d003      	beq.n	c0d01832 <snprintf+0x38e>
c0d0182a:	2c00      	cmp	r4, #0
c0d0182c:	d108      	bne.n	c0d01840 <snprintf+0x39c>
c0d0182e:	a43f      	add	r4, pc, #252	; (adr r4, c0d0192c <g_pcHex>)
c0d01830:	e000      	b.n	c0d01834 <snprintf+0x390>
c0d01832:	a43a      	add	r4, pc, #232	; (adr r4, c0d0191c <g_pcHex_cap>)
c0d01834:	b2c9      	uxtb	r1, r1
c0d01836:	5c61      	ldrb	r1, [r4, r1]
c0d01838:	7019      	strb	r1, [r3, #0]
c0d0183a:	b2c0      	uxtb	r0, r0
c0d0183c:	5c20      	ldrb	r0, [r4, r0]
c0d0183e:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01840:	9807      	ldr	r0, [sp, #28]
c0d01842:	4290      	cmp	r0, r2
c0d01844:	d064      	beq.n	c0d01910 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01846:	1e92      	subs	r2, r2, #2
c0d01848:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d0184a:	1ca4      	adds	r4, r4, #2
c0d0184c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0184e:	1c40      	adds	r0, r0, #1
c0d01850:	42a8      	cmp	r0, r5
c0d01852:	9900      	ldr	r1, [sp, #0]
c0d01854:	d3d9      	bcc.n	c0d0180a <snprintf+0x366>
c0d01856:	900d      	str	r0, [sp, #52]	; 0x34
c0d01858:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d0185a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0185c:	1a08      	subs	r0, r1, r0
c0d0185e:	9b05      	ldr	r3, [sp, #20]
c0d01860:	4283      	cmp	r3, r0
c0d01862:	d800      	bhi.n	c0d01866 <snprintf+0x3c2>
c0d01864:	4603      	mov	r3, r0
c0d01866:	4608      	mov	r0, r1
c0d01868:	4358      	muls	r0, r3
c0d0186a:	1820      	adds	r0, r4, r0
c0d0186c:	900e      	str	r0, [sp, #56]	; 0x38
c0d0186e:	1898      	adds	r0, r3, r2
c0d01870:	1c43      	adds	r3, r0, #1
c0d01872:	e038      	b.n	c0d018e6 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01874:	7808      	ldrb	r0, [r1, #0]
c0d01876:	2800      	cmp	r0, #0
c0d01878:	d023      	beq.n	c0d018c2 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d0187a:	2005      	movs	r0, #5
c0d0187c:	9d04      	ldr	r5, [sp, #16]
c0d0187e:	2d05      	cmp	r5, #5
c0d01880:	462c      	mov	r4, r5
c0d01882:	d300      	bcc.n	c0d01886 <snprintf+0x3e2>
c0d01884:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01886:	9807      	ldr	r0, [sp, #28]
c0d01888:	a12c      	add	r1, pc, #176	; (adr r1, c0d0193c <g_pcHex+0x10>)
c0d0188a:	4622      	mov	r2, r4
c0d0188c:	f7ff f9da 	bl	c0d00c44 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01890:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01892:	9907      	ldr	r1, [sp, #28]
c0d01894:	1909      	adds	r1, r1, r4
c0d01896:	910e      	str	r1, [sp, #56]	; 0x38
c0d01898:	4603      	mov	r3, r0
c0d0189a:	2800      	cmp	r0, #0
c0d0189c:	d038      	beq.n	c0d01910 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0189e:	7830      	ldrb	r0, [r6, #0]
c0d018a0:	2800      	cmp	r0, #0
c0d018a2:	9908      	ldr	r1, [sp, #32]
c0d018a4:	d034      	beq.n	c0d01910 <snprintf+0x46c>
c0d018a6:	e61f      	b.n	c0d014e8 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d018a8:	429d      	cmp	r5, r3
c0d018aa:	d300      	bcc.n	c0d018ae <snprintf+0x40a>
c0d018ac:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d018ae:	462a      	mov	r2, r5
c0d018b0:	461c      	mov	r4, r3
c0d018b2:	f7ff f9c7 	bl	c0d00c44 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d018b6:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d018b8:	9907      	ldr	r1, [sp, #28]
c0d018ba:	1949      	adds	r1, r1, r5
c0d018bc:	e00f      	b.n	c0d018de <snprintf+0x43a>
c0d018be:	900e      	str	r0, [sp, #56]	; 0x38
c0d018c0:	e7ed      	b.n	c0d0189e <snprintf+0x3fa>
c0d018c2:	9b04      	ldr	r3, [sp, #16]
c0d018c4:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d018c6:	429c      	cmp	r4, r3
c0d018c8:	d300      	bcc.n	c0d018cc <snprintf+0x428>
c0d018ca:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d018cc:	2120      	movs	r1, #32
c0d018ce:	9807      	ldr	r0, [sp, #28]
c0d018d0:	4622      	mov	r2, r4
c0d018d2:	f7ff f9ad 	bl	c0d00c30 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d018d6:	9804      	ldr	r0, [sp, #16]
c0d018d8:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d018da:	9907      	ldr	r1, [sp, #28]
c0d018dc:	1909      	adds	r1, r1, r4
c0d018de:	910e      	str	r1, [sp, #56]	; 0x38
c0d018e0:	4603      	mov	r3, r0
c0d018e2:	2800      	cmp	r0, #0
c0d018e4:	d014      	beq.n	c0d01910 <snprintf+0x46c>
c0d018e6:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d018e8:	42a8      	cmp	r0, r5
c0d018ea:	d9d8      	bls.n	c0d0189e <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d018ec:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d018ee:	429a      	cmp	r2, r3
c0d018f0:	d300      	bcc.n	c0d018f4 <snprintf+0x450>
c0d018f2:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d018f4:	2120      	movs	r1, #32
c0d018f6:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d018f8:	4628      	mov	r0, r5
c0d018fa:	920d      	str	r2, [sp, #52]	; 0x34
c0d018fc:	461c      	mov	r4, r3
c0d018fe:	f7ff f997 	bl	c0d00c30 <os_memset>
c0d01902:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01904:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01906:	182d      	adds	r5, r5, r0
c0d01908:	950e      	str	r5, [sp, #56]	; 0x38
c0d0190a:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d0190c:	2c00      	cmp	r4, #0
c0d0190e:	d1c6      	bne.n	c0d0189e <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01910:	2000      	movs	r0, #0
c0d01912:	b014      	add	sp, #80	; 0x50
c0d01914:	bcf0      	pop	{r4, r5, r6, r7}
c0d01916:	bc02      	pop	{r1}
c0d01918:	b001      	add	sp, #4
c0d0191a:	4708      	bx	r1

c0d0191c <g_pcHex_cap>:
c0d0191c:	33323130 	.word	0x33323130
c0d01920:	37363534 	.word	0x37363534
c0d01924:	42413938 	.word	0x42413938
c0d01928:	46454443 	.word	0x46454443

c0d0192c <g_pcHex>:
c0d0192c:	33323130 	.word	0x33323130
c0d01930:	37363534 	.word	0x37363534
c0d01934:	62613938 	.word	0x62613938
c0d01938:	66656463 	.word	0x66656463
c0d0193c:	4f525245 	.word	0x4f525245
c0d01940:	00000052 	.word	0x00000052

c0d01944 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01944:	b580      	push	{r7, lr}
c0d01946:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01948:	4904      	ldr	r1, [pc, #16]	; (c0d0195c <pic+0x18>)
c0d0194a:	4288      	cmp	r0, r1
c0d0194c:	d304      	bcc.n	c0d01958 <pic+0x14>
c0d0194e:	4904      	ldr	r1, [pc, #16]	; (c0d01960 <pic+0x1c>)
c0d01950:	4288      	cmp	r0, r1
c0d01952:	d201      	bcs.n	c0d01958 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01954:	f000 f806 	bl	c0d01964 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01958:	bd80      	pop	{r7, pc}
c0d0195a:	46c0      	nop			; (mov r8, r8)
c0d0195c:	c0d00000 	.word	0xc0d00000
c0d01960:	c0d03740 	.word	0xc0d03740

c0d01964 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01964:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01966:	4902      	ldr	r1, [pc, #8]	; (c0d01970 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01968:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d0196a:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d0196c:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d0196e:	4770      	bx	lr
c0d01970:	c0d01965 	.word	0xc0d01965

c0d01974 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01974:	b580      	push	{r7, lr}
c0d01976:	af00      	add	r7, sp, #0
c0d01978:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d0197a:	490a      	ldr	r1, [pc, #40]	; (c0d019a4 <check_api_level+0x30>)
c0d0197c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0197e:	490a      	ldr	r1, [pc, #40]	; (c0d019a8 <check_api_level+0x34>)
c0d01980:	680a      	ldr	r2, [r1, #0]
c0d01982:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01984:	9003      	str	r0, [sp, #12]
c0d01986:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01988:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0198a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0198c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d0198e:	4807      	ldr	r0, [pc, #28]	; (c0d019ac <check_api_level+0x38>)
c0d01990:	9a01      	ldr	r2, [sp, #4]
c0d01992:	4282      	cmp	r2, r0
c0d01994:	d101      	bne.n	c0d0199a <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01996:	b004      	add	sp, #16
c0d01998:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0199a:	6808      	ldr	r0, [r1, #0]
c0d0199c:	2104      	movs	r1, #4
c0d0199e:	f001 fc2f 	bl	c0d03200 <longjmp>
c0d019a2:	46c0      	nop			; (mov r8, r8)
c0d019a4:	60000137 	.word	0x60000137
c0d019a8:	20001bb8 	.word	0x20001bb8
c0d019ac:	900001c6 	.word	0x900001c6

c0d019b0 <reset>:
  }
}

void reset ( void ) 
{
c0d019b0:	b580      	push	{r7, lr}
c0d019b2:	af00      	add	r7, sp, #0
c0d019b4:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d019b6:	4809      	ldr	r0, [pc, #36]	; (c0d019dc <reset+0x2c>)
c0d019b8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019ba:	4809      	ldr	r0, [pc, #36]	; (c0d019e0 <reset+0x30>)
c0d019bc:	6801      	ldr	r1, [r0, #0]
c0d019be:	9101      	str	r1, [sp, #4]
c0d019c0:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d019c2:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d019c4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d019c6:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d019c8:	4906      	ldr	r1, [pc, #24]	; (c0d019e4 <reset+0x34>)
c0d019ca:	9a00      	ldr	r2, [sp, #0]
c0d019cc:	428a      	cmp	r2, r1
c0d019ce:	d101      	bne.n	c0d019d4 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d019d0:	b002      	add	sp, #8
c0d019d2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d019d4:	6800      	ldr	r0, [r0, #0]
c0d019d6:	2104      	movs	r1, #4
c0d019d8:	f001 fc12 	bl	c0d03200 <longjmp>
c0d019dc:	60000200 	.word	0x60000200
c0d019e0:	20001bb8 	.word	0x20001bb8
c0d019e4:	900002f1 	.word	0x900002f1

c0d019e8 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d019e8:	b5d0      	push	{r4, r6, r7, lr}
c0d019ea:	af02      	add	r7, sp, #8
c0d019ec:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d019ee:	4b0a      	ldr	r3, [pc, #40]	; (c0d01a18 <nvm_write+0x30>)
c0d019f0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019f2:	4b0a      	ldr	r3, [pc, #40]	; (c0d01a1c <nvm_write+0x34>)
c0d019f4:	681c      	ldr	r4, [r3, #0]
c0d019f6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d019f8:	ac03      	add	r4, sp, #12
c0d019fa:	c407      	stmia	r4!, {r0, r1, r2}
c0d019fc:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d019fe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a00:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a02:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01a04:	4806      	ldr	r0, [pc, #24]	; (c0d01a20 <nvm_write+0x38>)
c0d01a06:	9901      	ldr	r1, [sp, #4]
c0d01a08:	4281      	cmp	r1, r0
c0d01a0a:	d101      	bne.n	c0d01a10 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01a0c:	b006      	add	sp, #24
c0d01a0e:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a10:	6818      	ldr	r0, [r3, #0]
c0d01a12:	2104      	movs	r1, #4
c0d01a14:	f001 fbf4 	bl	c0d03200 <longjmp>
c0d01a18:	6000037f 	.word	0x6000037f
c0d01a1c:	20001bb8 	.word	0x20001bb8
c0d01a20:	900003bc 	.word	0x900003bc

c0d01a24 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01a24:	b580      	push	{r7, lr}
c0d01a26:	af00      	add	r7, sp, #0
c0d01a28:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01a2a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a54 <cx_rng+0x30>)
c0d01a2c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a2e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a58 <cx_rng+0x34>)
c0d01a30:	6813      	ldr	r3, [r2, #0]
c0d01a32:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01a34:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01a36:	9103      	str	r1, [sp, #12]
c0d01a38:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a3a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a3c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a3e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01a40:	4906      	ldr	r1, [pc, #24]	; (c0d01a5c <cx_rng+0x38>)
c0d01a42:	9b00      	ldr	r3, [sp, #0]
c0d01a44:	428b      	cmp	r3, r1
c0d01a46:	d101      	bne.n	c0d01a4c <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01a48:	b004      	add	sp, #16
c0d01a4a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a4c:	6810      	ldr	r0, [r2, #0]
c0d01a4e:	2104      	movs	r1, #4
c0d01a50:	f001 fbd6 	bl	c0d03200 <longjmp>
c0d01a54:	6000052c 	.word	0x6000052c
c0d01a58:	20001bb8 	.word	0x20001bb8
c0d01a5c:	90000567 	.word	0x90000567

c0d01a60 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01a60:	b580      	push	{r7, lr}
c0d01a62:	af00      	add	r7, sp, #0
c0d01a64:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01a66:	490a      	ldr	r1, [pc, #40]	; (c0d01a90 <cx_sha256_init+0x30>)
c0d01a68:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a6a:	490a      	ldr	r1, [pc, #40]	; (c0d01a94 <cx_sha256_init+0x34>)
c0d01a6c:	680a      	ldr	r2, [r1, #0]
c0d01a6e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01a70:	9003      	str	r0, [sp, #12]
c0d01a72:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a74:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a76:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a78:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01a7a:	4a07      	ldr	r2, [pc, #28]	; (c0d01a98 <cx_sha256_init+0x38>)
c0d01a7c:	9b01      	ldr	r3, [sp, #4]
c0d01a7e:	4293      	cmp	r3, r2
c0d01a80:	d101      	bne.n	c0d01a86 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a82:	b004      	add	sp, #16
c0d01a84:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a86:	6808      	ldr	r0, [r1, #0]
c0d01a88:	2104      	movs	r1, #4
c0d01a8a:	f001 fbb9 	bl	c0d03200 <longjmp>
c0d01a8e:	46c0      	nop			; (mov r8, r8)
c0d01a90:	600008db 	.word	0x600008db
c0d01a94:	20001bb8 	.word	0x20001bb8
c0d01a98:	90000864 	.word	0x90000864

c0d01a9c <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01a9c:	b580      	push	{r7, lr}
c0d01a9e:	af00      	add	r7, sp, #0
c0d01aa0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01aa2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01acc <cx_keccak_init+0x30>)
c0d01aa4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01aa6:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ad0 <cx_keccak_init+0x34>)
c0d01aa8:	6813      	ldr	r3, [r2, #0]
c0d01aaa:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01aac:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01aae:	9103      	str	r1, [sp, #12]
c0d01ab0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ab2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ab4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ab6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01ab8:	4906      	ldr	r1, [pc, #24]	; (c0d01ad4 <cx_keccak_init+0x38>)
c0d01aba:	9b00      	ldr	r3, [sp, #0]
c0d01abc:	428b      	cmp	r3, r1
c0d01abe:	d101      	bne.n	c0d01ac4 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01ac0:	b004      	add	sp, #16
c0d01ac2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ac4:	6810      	ldr	r0, [r2, #0]
c0d01ac6:	2104      	movs	r1, #4
c0d01ac8:	f001 fb9a 	bl	c0d03200 <longjmp>
c0d01acc:	60000c3c 	.word	0x60000c3c
c0d01ad0:	20001bb8 	.word	0x20001bb8
c0d01ad4:	90000c39 	.word	0x90000c39

c0d01ad8 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01ad8:	b5b0      	push	{r4, r5, r7, lr}
c0d01ada:	af02      	add	r7, sp, #8
c0d01adc:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01ade:	4c0b      	ldr	r4, [pc, #44]	; (c0d01b0c <cx_hash+0x34>)
c0d01ae0:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ae2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01b10 <cx_hash+0x38>)
c0d01ae4:	6825      	ldr	r5, [r4, #0]
c0d01ae6:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01ae8:	ad03      	add	r5, sp, #12
c0d01aea:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01aec:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01aee:	9007      	str	r0, [sp, #28]
c0d01af0:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01af2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01af4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01af6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01af8:	4906      	ldr	r1, [pc, #24]	; (c0d01b14 <cx_hash+0x3c>)
c0d01afa:	9a01      	ldr	r2, [sp, #4]
c0d01afc:	428a      	cmp	r2, r1
c0d01afe:	d101      	bne.n	c0d01b04 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b00:	b008      	add	sp, #32
c0d01b02:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b04:	6820      	ldr	r0, [r4, #0]
c0d01b06:	2104      	movs	r1, #4
c0d01b08:	f001 fb7a 	bl	c0d03200 <longjmp>
c0d01b0c:	60000ea6 	.word	0x60000ea6
c0d01b10:	20001bb8 	.word	0x20001bb8
c0d01b14:	90000e46 	.word	0x90000e46

c0d01b18 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01b18:	b5b0      	push	{r4, r5, r7, lr}
c0d01b1a:	af02      	add	r7, sp, #8
c0d01b1c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01b1e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b48 <cx_ecfp_init_public_key+0x30>)
c0d01b20:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b22:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b4c <cx_ecfp_init_public_key+0x34>)
c0d01b24:	6825      	ldr	r5, [r4, #0]
c0d01b26:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01b28:	ad02      	add	r5, sp, #8
c0d01b2a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b2c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b2e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b30:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b32:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01b34:	4906      	ldr	r1, [pc, #24]	; (c0d01b50 <cx_ecfp_init_public_key+0x38>)
c0d01b36:	9a00      	ldr	r2, [sp, #0]
c0d01b38:	428a      	cmp	r2, r1
c0d01b3a:	d101      	bne.n	c0d01b40 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b3c:	b006      	add	sp, #24
c0d01b3e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b40:	6820      	ldr	r0, [r4, #0]
c0d01b42:	2104      	movs	r1, #4
c0d01b44:	f001 fb5c 	bl	c0d03200 <longjmp>
c0d01b48:	60002835 	.word	0x60002835
c0d01b4c:	20001bb8 	.word	0x20001bb8
c0d01b50:	900028f0 	.word	0x900028f0

c0d01b54 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01b54:	b5b0      	push	{r4, r5, r7, lr}
c0d01b56:	af02      	add	r7, sp, #8
c0d01b58:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01b5a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b84 <cx_ecfp_init_private_key+0x30>)
c0d01b5c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b5e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b88 <cx_ecfp_init_private_key+0x34>)
c0d01b60:	6825      	ldr	r5, [r4, #0]
c0d01b62:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01b64:	ad02      	add	r5, sp, #8
c0d01b66:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b68:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b6a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b6c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b6e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01b70:	4906      	ldr	r1, [pc, #24]	; (c0d01b8c <cx_ecfp_init_private_key+0x38>)
c0d01b72:	9a00      	ldr	r2, [sp, #0]
c0d01b74:	428a      	cmp	r2, r1
c0d01b76:	d101      	bne.n	c0d01b7c <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b78:	b006      	add	sp, #24
c0d01b7a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b7c:	6820      	ldr	r0, [r4, #0]
c0d01b7e:	2104      	movs	r1, #4
c0d01b80:	f001 fb3e 	bl	c0d03200 <longjmp>
c0d01b84:	600029ed 	.word	0x600029ed
c0d01b88:	20001bb8 	.word	0x20001bb8
c0d01b8c:	900029ae 	.word	0x900029ae

c0d01b90 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01b90:	b5b0      	push	{r4, r5, r7, lr}
c0d01b92:	af02      	add	r7, sp, #8
c0d01b94:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01b96:	4c0a      	ldr	r4, [pc, #40]	; (c0d01bc0 <cx_ecfp_generate_pair+0x30>)
c0d01b98:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b9a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01bc4 <cx_ecfp_generate_pair+0x34>)
c0d01b9c:	6825      	ldr	r5, [r4, #0]
c0d01b9e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01ba0:	ad02      	add	r5, sp, #8
c0d01ba2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01ba4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ba6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ba8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01baa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01bac:	4906      	ldr	r1, [pc, #24]	; (c0d01bc8 <cx_ecfp_generate_pair+0x38>)
c0d01bae:	9a00      	ldr	r2, [sp, #0]
c0d01bb0:	428a      	cmp	r2, r1
c0d01bb2:	d101      	bne.n	c0d01bb8 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01bb4:	b006      	add	sp, #24
c0d01bb6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bb8:	6820      	ldr	r0, [r4, #0]
c0d01bba:	2104      	movs	r1, #4
c0d01bbc:	f001 fb20 	bl	c0d03200 <longjmp>
c0d01bc0:	60002a2e 	.word	0x60002a2e
c0d01bc4:	20001bb8 	.word	0x20001bb8
c0d01bc8:	90002a74 	.word	0x90002a74

c0d01bcc <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01bcc:	b5b0      	push	{r4, r5, r7, lr}
c0d01bce:	af02      	add	r7, sp, #8
c0d01bd0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01bd2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c00 <os_perso_derive_node_bip32+0x34>)
c0d01bd4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bd6:	4c0b      	ldr	r4, [pc, #44]	; (c0d01c04 <os_perso_derive_node_bip32+0x38>)
c0d01bd8:	6825      	ldr	r5, [r4, #0]
c0d01bda:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01bdc:	ad03      	add	r5, sp, #12
c0d01bde:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01be0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01be2:	9007      	str	r0, [sp, #28]
c0d01be4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01be6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01be8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bea:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01bec:	4806      	ldr	r0, [pc, #24]	; (c0d01c08 <os_perso_derive_node_bip32+0x3c>)
c0d01bee:	9901      	ldr	r1, [sp, #4]
c0d01bf0:	4281      	cmp	r1, r0
c0d01bf2:	d101      	bne.n	c0d01bf8 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01bf4:	b008      	add	sp, #32
c0d01bf6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bf8:	6820      	ldr	r0, [r4, #0]
c0d01bfa:	2104      	movs	r1, #4
c0d01bfc:	f001 fb00 	bl	c0d03200 <longjmp>
c0d01c00:	6000512b 	.word	0x6000512b
c0d01c04:	20001bb8 	.word	0x20001bb8
c0d01c08:	9000517f 	.word	0x9000517f

c0d01c0c <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01c0c:	b580      	push	{r7, lr}
c0d01c0e:	af00      	add	r7, sp, #0
c0d01c10:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01c12:	490a      	ldr	r1, [pc, #40]	; (c0d01c3c <os_sched_exit+0x30>)
c0d01c14:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c16:	490a      	ldr	r1, [pc, #40]	; (c0d01c40 <os_sched_exit+0x34>)
c0d01c18:	680a      	ldr	r2, [r1, #0]
c0d01c1a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01c1c:	9003      	str	r0, [sp, #12]
c0d01c1e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c20:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c22:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c24:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01c26:	4807      	ldr	r0, [pc, #28]	; (c0d01c44 <os_sched_exit+0x38>)
c0d01c28:	9a01      	ldr	r2, [sp, #4]
c0d01c2a:	4282      	cmp	r2, r0
c0d01c2c:	d101      	bne.n	c0d01c32 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c2e:	b004      	add	sp, #16
c0d01c30:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c32:	6808      	ldr	r0, [r1, #0]
c0d01c34:	2104      	movs	r1, #4
c0d01c36:	f001 fae3 	bl	c0d03200 <longjmp>
c0d01c3a:	46c0      	nop			; (mov r8, r8)
c0d01c3c:	60005fe1 	.word	0x60005fe1
c0d01c40:	20001bb8 	.word	0x20001bb8
c0d01c44:	90005f6f 	.word	0x90005f6f

c0d01c48 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01c48:	b580      	push	{r7, lr}
c0d01c4a:	af00      	add	r7, sp, #0
c0d01c4c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01c4e:	490a      	ldr	r1, [pc, #40]	; (c0d01c78 <os_ux+0x30>)
c0d01c50:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c52:	490a      	ldr	r1, [pc, #40]	; (c0d01c7c <os_ux+0x34>)
c0d01c54:	680a      	ldr	r2, [r1, #0]
c0d01c56:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01c58:	9003      	str	r0, [sp, #12]
c0d01c5a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c5c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c5e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c60:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01c62:	4a07      	ldr	r2, [pc, #28]	; (c0d01c80 <os_ux+0x38>)
c0d01c64:	9b01      	ldr	r3, [sp, #4]
c0d01c66:	4293      	cmp	r3, r2
c0d01c68:	d101      	bne.n	c0d01c6e <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01c6a:	b004      	add	sp, #16
c0d01c6c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c6e:	6808      	ldr	r0, [r1, #0]
c0d01c70:	2104      	movs	r1, #4
c0d01c72:	f001 fac5 	bl	c0d03200 <longjmp>
c0d01c76:	46c0      	nop			; (mov r8, r8)
c0d01c78:	60006158 	.word	0x60006158
c0d01c7c:	20001bb8 	.word	0x20001bb8
c0d01c80:	9000611f 	.word	0x9000611f

c0d01c84 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01c84:	b580      	push	{r7, lr}
c0d01c86:	af00      	add	r7, sp, #0
c0d01c88:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01c8a:	4809      	ldr	r0, [pc, #36]	; (c0d01cb0 <os_seph_features+0x2c>)
c0d01c8c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c8e:	4909      	ldr	r1, [pc, #36]	; (c0d01cb4 <os_seph_features+0x30>)
c0d01c90:	6808      	ldr	r0, [r1, #0]
c0d01c92:	9001      	str	r0, [sp, #4]
c0d01c94:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c96:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c98:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c9a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01c9c:	4a06      	ldr	r2, [pc, #24]	; (c0d01cb8 <os_seph_features+0x34>)
c0d01c9e:	9b00      	ldr	r3, [sp, #0]
c0d01ca0:	4293      	cmp	r3, r2
c0d01ca2:	d101      	bne.n	c0d01ca8 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01ca4:	b002      	add	sp, #8
c0d01ca6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ca8:	6808      	ldr	r0, [r1, #0]
c0d01caa:	2104      	movs	r1, #4
c0d01cac:	f001 faa8 	bl	c0d03200 <longjmp>
c0d01cb0:	600064d6 	.word	0x600064d6
c0d01cb4:	20001bb8 	.word	0x20001bb8
c0d01cb8:	90006444 	.word	0x90006444

c0d01cbc <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01cbc:	b580      	push	{r7, lr}
c0d01cbe:	af00      	add	r7, sp, #0
c0d01cc0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01cc2:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cec <io_seproxyhal_spi_send+0x30>)
c0d01cc4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cc6:	4a0a      	ldr	r2, [pc, #40]	; (c0d01cf0 <io_seproxyhal_spi_send+0x34>)
c0d01cc8:	6813      	ldr	r3, [r2, #0]
c0d01cca:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01ccc:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01cce:	9103      	str	r1, [sp, #12]
c0d01cd0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cd2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cd4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cd6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01cd8:	4806      	ldr	r0, [pc, #24]	; (c0d01cf4 <io_seproxyhal_spi_send+0x38>)
c0d01cda:	9900      	ldr	r1, [sp, #0]
c0d01cdc:	4281      	cmp	r1, r0
c0d01cde:	d101      	bne.n	c0d01ce4 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ce0:	b004      	add	sp, #16
c0d01ce2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ce4:	6810      	ldr	r0, [r2, #0]
c0d01ce6:	2104      	movs	r1, #4
c0d01ce8:	f001 fa8a 	bl	c0d03200 <longjmp>
c0d01cec:	60006a1c 	.word	0x60006a1c
c0d01cf0:	20001bb8 	.word	0x20001bb8
c0d01cf4:	90006af3 	.word	0x90006af3

c0d01cf8 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01cf8:	b580      	push	{r7, lr}
c0d01cfa:	af00      	add	r7, sp, #0
c0d01cfc:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01cfe:	4809      	ldr	r0, [pc, #36]	; (c0d01d24 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01d00:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d02:	4909      	ldr	r1, [pc, #36]	; (c0d01d28 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01d04:	6808      	ldr	r0, [r1, #0]
c0d01d06:	9001      	str	r0, [sp, #4]
c0d01d08:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d0a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d0c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d0e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01d10:	4a06      	ldr	r2, [pc, #24]	; (c0d01d2c <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01d12:	9b00      	ldr	r3, [sp, #0]
c0d01d14:	4293      	cmp	r3, r2
c0d01d16:	d101      	bne.n	c0d01d1c <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01d18:	b002      	add	sp, #8
c0d01d1a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d1c:	6808      	ldr	r0, [r1, #0]
c0d01d1e:	2104      	movs	r1, #4
c0d01d20:	f001 fa6e 	bl	c0d03200 <longjmp>
c0d01d24:	60006bcf 	.word	0x60006bcf
c0d01d28:	20001bb8 	.word	0x20001bb8
c0d01d2c:	90006b7f 	.word	0x90006b7f

c0d01d30 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01d30:	b5d0      	push	{r4, r6, r7, lr}
c0d01d32:	af02      	add	r7, sp, #8
c0d01d34:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01d36:	4b0b      	ldr	r3, [pc, #44]	; (c0d01d64 <io_seproxyhal_spi_recv+0x34>)
c0d01d38:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d3a:	4b0b      	ldr	r3, [pc, #44]	; (c0d01d68 <io_seproxyhal_spi_recv+0x38>)
c0d01d3c:	681c      	ldr	r4, [r3, #0]
c0d01d3e:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01d40:	ac03      	add	r4, sp, #12
c0d01d42:	c407      	stmia	r4!, {r0, r1, r2}
c0d01d44:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d46:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d48:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d4a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01d4c:	4907      	ldr	r1, [pc, #28]	; (c0d01d6c <io_seproxyhal_spi_recv+0x3c>)
c0d01d4e:	9a01      	ldr	r2, [sp, #4]
c0d01d50:	428a      	cmp	r2, r1
c0d01d52:	d102      	bne.n	c0d01d5a <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01d54:	b280      	uxth	r0, r0
c0d01d56:	b006      	add	sp, #24
c0d01d58:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d5a:	6818      	ldr	r0, [r3, #0]
c0d01d5c:	2104      	movs	r1, #4
c0d01d5e:	f001 fa4f 	bl	c0d03200 <longjmp>
c0d01d62:	46c0      	nop			; (mov r8, r8)
c0d01d64:	60006cd1 	.word	0x60006cd1
c0d01d68:	20001bb8 	.word	0x20001bb8
c0d01d6c:	90006c2b 	.word	0x90006c2b

c0d01d70 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01d70:	b5b0      	push	{r4, r5, r7, lr}
c0d01d72:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01d74:	492c      	ldr	r1, [pc, #176]	; (c0d01e28 <bagl_ui_nanos_screen1_button+0xb8>)
c0d01d76:	4288      	cmp	r0, r1
c0d01d78:	d006      	beq.n	c0d01d88 <bagl_ui_nanos_screen1_button+0x18>
c0d01d7a:	492c      	ldr	r1, [pc, #176]	; (c0d01e2c <bagl_ui_nanos_screen1_button+0xbc>)
c0d01d7c:	4288      	cmp	r0, r1
c0d01d7e:	d151      	bne.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01d80:	2000      	movs	r0, #0
c0d01d82:	f7ff ff43 	bl	c0d01c0c <os_sched_exit>
c0d01d86:	e04d      	b.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01d88:	f7fe fba4 	bl	c0d004d4 <nvram_is_init>
c0d01d8c:	2801      	cmp	r0, #1
c0d01d8e:	d102      	bne.n	c0d01d96 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01d90:	a029      	add	r0, pc, #164	; (adr r0, c0d01e38 <bagl_ui_nanos_screen1_button+0xc8>)
c0d01d92:	210d      	movs	r1, #13
c0d01d94:	e001      	b.n	c0d01d9a <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01d96:	a026      	add	r0, pc, #152	; (adr r0, c0d01e30 <bagl_ui_nanos_screen1_button+0xc0>)
c0d01d98:	2105      	movs	r1, #5
c0d01d9a:	2203      	movs	r2, #3
c0d01d9c:	f7fe f982 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01da0:	4c29      	ldr	r4, [pc, #164]	; (c0d01e48 <bagl_ui_nanos_screen1_button+0xd8>)
c0d01da2:	482b      	ldr	r0, [pc, #172]	; (c0d01e50 <bagl_ui_nanos_screen1_button+0xe0>)
c0d01da4:	4478      	add	r0, pc
c0d01da6:	6020      	str	r0, [r4, #0]
c0d01da8:	2004      	movs	r0, #4
c0d01daa:	6060      	str	r0, [r4, #4]
c0d01dac:	4829      	ldr	r0, [pc, #164]	; (c0d01e54 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01dae:	4478      	add	r0, pc
c0d01db0:	6120      	str	r0, [r4, #16]
c0d01db2:	2500      	movs	r5, #0
c0d01db4:	60e5      	str	r5, [r4, #12]
c0d01db6:	2003      	movs	r0, #3
c0d01db8:	7620      	strb	r0, [r4, #24]
c0d01dba:	61e5      	str	r5, [r4, #28]
c0d01dbc:	4620      	mov	r0, r4
c0d01dbe:	3018      	adds	r0, #24
c0d01dc0:	f7ff ff42 	bl	c0d01c48 <os_ux>
c0d01dc4:	61e0      	str	r0, [r4, #28]
c0d01dc6:	f7ff f903 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d01dca:	60a5      	str	r5, [r4, #8]
c0d01dcc:	6820      	ldr	r0, [r4, #0]
c0d01dce:	2800      	cmp	r0, #0
c0d01dd0:	d028      	beq.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
c0d01dd2:	69e0      	ldr	r0, [r4, #28]
c0d01dd4:	491d      	ldr	r1, [pc, #116]	; (c0d01e4c <bagl_ui_nanos_screen1_button+0xdc>)
c0d01dd6:	4288      	cmp	r0, r1
c0d01dd8:	d116      	bne.n	c0d01e08 <bagl_ui_nanos_screen1_button+0x98>
c0d01dda:	e023      	b.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ddc:	6860      	ldr	r0, [r4, #4]
c0d01dde:	4285      	cmp	r5, r0
c0d01de0:	d220      	bcs.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
c0d01de2:	f7ff ff89 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d01de6:	2800      	cmp	r0, #0
c0d01de8:	d11c      	bne.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
c0d01dea:	68a0      	ldr	r0, [r4, #8]
c0d01dec:	68e1      	ldr	r1, [r4, #12]
c0d01dee:	2538      	movs	r5, #56	; 0x38
c0d01df0:	4368      	muls	r0, r5
c0d01df2:	6822      	ldr	r2, [r4, #0]
c0d01df4:	1810      	adds	r0, r2, r0
c0d01df6:	2900      	cmp	r1, #0
c0d01df8:	d009      	beq.n	c0d01e0e <bagl_ui_nanos_screen1_button+0x9e>
c0d01dfa:	4788      	blx	r1
c0d01dfc:	2800      	cmp	r0, #0
c0d01dfe:	d106      	bne.n	c0d01e0e <bagl_ui_nanos_screen1_button+0x9e>
c0d01e00:	68a0      	ldr	r0, [r4, #8]
c0d01e02:	1c45      	adds	r5, r0, #1
c0d01e04:	60a5      	str	r5, [r4, #8]
c0d01e06:	6820      	ldr	r0, [r4, #0]
c0d01e08:	2800      	cmp	r0, #0
c0d01e0a:	d1e7      	bne.n	c0d01ddc <bagl_ui_nanos_screen1_button+0x6c>
c0d01e0c:	e00a      	b.n	c0d01e24 <bagl_ui_nanos_screen1_button+0xb4>
c0d01e0e:	2801      	cmp	r0, #1
c0d01e10:	d103      	bne.n	c0d01e1a <bagl_ui_nanos_screen1_button+0xaa>
c0d01e12:	68a0      	ldr	r0, [r4, #8]
c0d01e14:	4345      	muls	r5, r0
c0d01e16:	6820      	ldr	r0, [r4, #0]
c0d01e18:	1940      	adds	r0, r0, r5
c0d01e1a:	f7fe fb91 	bl	c0d00540 <io_seproxyhal_display>
c0d01e1e:	68a0      	ldr	r0, [r4, #8]
c0d01e20:	1c40      	adds	r0, r0, #1
c0d01e22:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01e24:	2000      	movs	r0, #0
c0d01e26:	bdb0      	pop	{r4, r5, r7, pc}
c0d01e28:	80000002 	.word	0x80000002
c0d01e2c:	80000001 	.word	0x80000001
c0d01e30:	54494e49 	.word	0x54494e49
c0d01e34:	00000000 	.word	0x00000000
c0d01e38:	6c697453 	.word	0x6c697453
c0d01e3c:	6e75206c 	.word	0x6e75206c
c0d01e40:	74696e69 	.word	0x74696e69
c0d01e44:	00000000 	.word	0x00000000
c0d01e48:	20001a98 	.word	0x20001a98
c0d01e4c:	b0105044 	.word	0xb0105044
c0d01e50:	00001664 	.word	0x00001664
c0d01e54:	00000153 	.word	0x00000153

c0d01e58 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01e58:	b5b0      	push	{r4, r5, r7, lr}
c0d01e5a:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01e5c:	2800      	cmp	r0, #0
c0d01e5e:	d005      	beq.n	c0d01e6c <ui_display_debug+0x14>
c0d01e60:	2900      	cmp	r1, #0
c0d01e62:	d003      	beq.n	c0d01e6c <ui_display_debug+0x14>
c0d01e64:	2a00      	cmp	r2, #0
c0d01e66:	d001      	beq.n	c0d01e6c <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01e68:	f7fe f91c 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01e6c:	4c21      	ldr	r4, [pc, #132]	; (c0d01ef4 <ui_display_debug+0x9c>)
c0d01e6e:	4823      	ldr	r0, [pc, #140]	; (c0d01efc <ui_display_debug+0xa4>)
c0d01e70:	4478      	add	r0, pc
c0d01e72:	6020      	str	r0, [r4, #0]
c0d01e74:	2004      	movs	r0, #4
c0d01e76:	6060      	str	r0, [r4, #4]
c0d01e78:	4821      	ldr	r0, [pc, #132]	; (c0d01f00 <ui_display_debug+0xa8>)
c0d01e7a:	4478      	add	r0, pc
c0d01e7c:	6120      	str	r0, [r4, #16]
c0d01e7e:	2500      	movs	r5, #0
c0d01e80:	60e5      	str	r5, [r4, #12]
c0d01e82:	2003      	movs	r0, #3
c0d01e84:	7620      	strb	r0, [r4, #24]
c0d01e86:	61e5      	str	r5, [r4, #28]
c0d01e88:	4620      	mov	r0, r4
c0d01e8a:	3018      	adds	r0, #24
c0d01e8c:	f7ff fedc 	bl	c0d01c48 <os_ux>
c0d01e90:	61e0      	str	r0, [r4, #28]
c0d01e92:	f7ff f89d 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d01e96:	60a5      	str	r5, [r4, #8]
c0d01e98:	6820      	ldr	r0, [r4, #0]
c0d01e9a:	2800      	cmp	r0, #0
c0d01e9c:	d028      	beq.n	c0d01ef0 <ui_display_debug+0x98>
c0d01e9e:	69e0      	ldr	r0, [r4, #28]
c0d01ea0:	4915      	ldr	r1, [pc, #84]	; (c0d01ef8 <ui_display_debug+0xa0>)
c0d01ea2:	4288      	cmp	r0, r1
c0d01ea4:	d116      	bne.n	c0d01ed4 <ui_display_debug+0x7c>
c0d01ea6:	e023      	b.n	c0d01ef0 <ui_display_debug+0x98>
c0d01ea8:	6860      	ldr	r0, [r4, #4]
c0d01eaa:	4285      	cmp	r5, r0
c0d01eac:	d220      	bcs.n	c0d01ef0 <ui_display_debug+0x98>
c0d01eae:	f7ff ff23 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d01eb2:	2800      	cmp	r0, #0
c0d01eb4:	d11c      	bne.n	c0d01ef0 <ui_display_debug+0x98>
c0d01eb6:	68a0      	ldr	r0, [r4, #8]
c0d01eb8:	68e1      	ldr	r1, [r4, #12]
c0d01eba:	2538      	movs	r5, #56	; 0x38
c0d01ebc:	4368      	muls	r0, r5
c0d01ebe:	6822      	ldr	r2, [r4, #0]
c0d01ec0:	1810      	adds	r0, r2, r0
c0d01ec2:	2900      	cmp	r1, #0
c0d01ec4:	d009      	beq.n	c0d01eda <ui_display_debug+0x82>
c0d01ec6:	4788      	blx	r1
c0d01ec8:	2800      	cmp	r0, #0
c0d01eca:	d106      	bne.n	c0d01eda <ui_display_debug+0x82>
c0d01ecc:	68a0      	ldr	r0, [r4, #8]
c0d01ece:	1c45      	adds	r5, r0, #1
c0d01ed0:	60a5      	str	r5, [r4, #8]
c0d01ed2:	6820      	ldr	r0, [r4, #0]
c0d01ed4:	2800      	cmp	r0, #0
c0d01ed6:	d1e7      	bne.n	c0d01ea8 <ui_display_debug+0x50>
c0d01ed8:	e00a      	b.n	c0d01ef0 <ui_display_debug+0x98>
c0d01eda:	2801      	cmp	r0, #1
c0d01edc:	d103      	bne.n	c0d01ee6 <ui_display_debug+0x8e>
c0d01ede:	68a0      	ldr	r0, [r4, #8]
c0d01ee0:	4345      	muls	r5, r0
c0d01ee2:	6820      	ldr	r0, [r4, #0]
c0d01ee4:	1940      	adds	r0, r0, r5
c0d01ee6:	f7fe fb2b 	bl	c0d00540 <io_seproxyhal_display>
c0d01eea:	68a0      	ldr	r0, [r4, #8]
c0d01eec:	1c40      	adds	r0, r0, #1
c0d01eee:	60a0      	str	r0, [r4, #8]
}
c0d01ef0:	bdb0      	pop	{r4, r5, r7, pc}
c0d01ef2:	46c0      	nop			; (mov r8, r8)
c0d01ef4:	20001a98 	.word	0x20001a98
c0d01ef8:	b0105044 	.word	0xb0105044
c0d01efc:	00001598 	.word	0x00001598
c0d01f00:	00000087 	.word	0x00000087

c0d01f04 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01f04:	b580      	push	{r7, lr}
c0d01f06:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d01f08:	4905      	ldr	r1, [pc, #20]	; (c0d01f20 <bagl_ui_nanos_screen2_button+0x1c>)
c0d01f0a:	4288      	cmp	r0, r1
c0d01f0c:	d002      	beq.n	c0d01f14 <bagl_ui_nanos_screen2_button+0x10>
c0d01f0e:	4905      	ldr	r1, [pc, #20]	; (c0d01f24 <bagl_ui_nanos_screen2_button+0x20>)
c0d01f10:	4288      	cmp	r0, r1
c0d01f12:	d102      	bne.n	c0d01f1a <bagl_ui_nanos_screen2_button+0x16>
c0d01f14:	2000      	movs	r0, #0
c0d01f16:	f7ff fe79 	bl	c0d01c0c <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d01f1a:	2000      	movs	r0, #0
c0d01f1c:	bd80      	pop	{r7, pc}
c0d01f1e:	46c0      	nop			; (mov r8, r8)
c0d01f20:	80000002 	.word	0x80000002
c0d01f24:	80000001 	.word	0x80000001

c0d01f28 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d01f28:	b5b0      	push	{r4, r5, r7, lr}
c0d01f2a:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d01f2c:	2001      	movs	r0, #1
c0d01f2e:	0204      	lsls	r4, r0, #8
c0d01f30:	f7ff fea8 	bl	c0d01c84 <os_seph_features>
c0d01f34:	4220      	tst	r0, r4
c0d01f36:	d136      	bne.n	c0d01fa6 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d01f38:	4c3c      	ldr	r4, [pc, #240]	; (c0d0202c <ui_idle+0x104>)
c0d01f3a:	4840      	ldr	r0, [pc, #256]	; (c0d0203c <ui_idle+0x114>)
c0d01f3c:	4478      	add	r0, pc
c0d01f3e:	6020      	str	r0, [r4, #0]
c0d01f40:	2004      	movs	r0, #4
c0d01f42:	6060      	str	r0, [r4, #4]
c0d01f44:	483e      	ldr	r0, [pc, #248]	; (c0d02040 <ui_idle+0x118>)
c0d01f46:	4478      	add	r0, pc
c0d01f48:	6120      	str	r0, [r4, #16]
c0d01f4a:	2500      	movs	r5, #0
c0d01f4c:	60e5      	str	r5, [r4, #12]
c0d01f4e:	2003      	movs	r0, #3
c0d01f50:	7620      	strb	r0, [r4, #24]
c0d01f52:	61e5      	str	r5, [r4, #28]
c0d01f54:	4620      	mov	r0, r4
c0d01f56:	3018      	adds	r0, #24
c0d01f58:	f7ff fe76 	bl	c0d01c48 <os_ux>
c0d01f5c:	61e0      	str	r0, [r4, #28]
c0d01f5e:	f7ff f837 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d01f62:	60a5      	str	r5, [r4, #8]
c0d01f64:	6820      	ldr	r0, [r4, #0]
c0d01f66:	2800      	cmp	r0, #0
c0d01f68:	d05f      	beq.n	c0d0202a <ui_idle+0x102>
c0d01f6a:	69e0      	ldr	r0, [r4, #28]
c0d01f6c:	4930      	ldr	r1, [pc, #192]	; (c0d02030 <ui_idle+0x108>)
c0d01f6e:	4288      	cmp	r0, r1
c0d01f70:	d116      	bne.n	c0d01fa0 <ui_idle+0x78>
c0d01f72:	e05a      	b.n	c0d0202a <ui_idle+0x102>
c0d01f74:	6860      	ldr	r0, [r4, #4]
c0d01f76:	4285      	cmp	r5, r0
c0d01f78:	d257      	bcs.n	c0d0202a <ui_idle+0x102>
c0d01f7a:	f7ff febd 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d01f7e:	2800      	cmp	r0, #0
c0d01f80:	d153      	bne.n	c0d0202a <ui_idle+0x102>
c0d01f82:	68a0      	ldr	r0, [r4, #8]
c0d01f84:	68e1      	ldr	r1, [r4, #12]
c0d01f86:	2538      	movs	r5, #56	; 0x38
c0d01f88:	4368      	muls	r0, r5
c0d01f8a:	6822      	ldr	r2, [r4, #0]
c0d01f8c:	1810      	adds	r0, r2, r0
c0d01f8e:	2900      	cmp	r1, #0
c0d01f90:	d040      	beq.n	c0d02014 <ui_idle+0xec>
c0d01f92:	4788      	blx	r1
c0d01f94:	2800      	cmp	r0, #0
c0d01f96:	d13d      	bne.n	c0d02014 <ui_idle+0xec>
c0d01f98:	68a0      	ldr	r0, [r4, #8]
c0d01f9a:	1c45      	adds	r5, r0, #1
c0d01f9c:	60a5      	str	r5, [r4, #8]
c0d01f9e:	6820      	ldr	r0, [r4, #0]
c0d01fa0:	2800      	cmp	r0, #0
c0d01fa2:	d1e7      	bne.n	c0d01f74 <ui_idle+0x4c>
c0d01fa4:	e041      	b.n	c0d0202a <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d01fa6:	4c21      	ldr	r4, [pc, #132]	; (c0d0202c <ui_idle+0x104>)
c0d01fa8:	4822      	ldr	r0, [pc, #136]	; (c0d02034 <ui_idle+0x10c>)
c0d01faa:	4478      	add	r0, pc
c0d01fac:	6020      	str	r0, [r4, #0]
c0d01fae:	2004      	movs	r0, #4
c0d01fb0:	6060      	str	r0, [r4, #4]
c0d01fb2:	4821      	ldr	r0, [pc, #132]	; (c0d02038 <ui_idle+0x110>)
c0d01fb4:	4478      	add	r0, pc
c0d01fb6:	6120      	str	r0, [r4, #16]
c0d01fb8:	2500      	movs	r5, #0
c0d01fba:	60e5      	str	r5, [r4, #12]
c0d01fbc:	2003      	movs	r0, #3
c0d01fbe:	7620      	strb	r0, [r4, #24]
c0d01fc0:	61e5      	str	r5, [r4, #28]
c0d01fc2:	4620      	mov	r0, r4
c0d01fc4:	3018      	adds	r0, #24
c0d01fc6:	f7ff fe3f 	bl	c0d01c48 <os_ux>
c0d01fca:	61e0      	str	r0, [r4, #28]
c0d01fcc:	f7ff f800 	bl	c0d00fd0 <io_seproxyhal_init_ux>
c0d01fd0:	60a5      	str	r5, [r4, #8]
c0d01fd2:	6820      	ldr	r0, [r4, #0]
c0d01fd4:	2800      	cmp	r0, #0
c0d01fd6:	d028      	beq.n	c0d0202a <ui_idle+0x102>
c0d01fd8:	69e0      	ldr	r0, [r4, #28]
c0d01fda:	4915      	ldr	r1, [pc, #84]	; (c0d02030 <ui_idle+0x108>)
c0d01fdc:	4288      	cmp	r0, r1
c0d01fde:	d116      	bne.n	c0d0200e <ui_idle+0xe6>
c0d01fe0:	e023      	b.n	c0d0202a <ui_idle+0x102>
c0d01fe2:	6860      	ldr	r0, [r4, #4]
c0d01fe4:	4285      	cmp	r5, r0
c0d01fe6:	d220      	bcs.n	c0d0202a <ui_idle+0x102>
c0d01fe8:	f7ff fe86 	bl	c0d01cf8 <io_seproxyhal_spi_is_status_sent>
c0d01fec:	2800      	cmp	r0, #0
c0d01fee:	d11c      	bne.n	c0d0202a <ui_idle+0x102>
c0d01ff0:	68a0      	ldr	r0, [r4, #8]
c0d01ff2:	68e1      	ldr	r1, [r4, #12]
c0d01ff4:	2538      	movs	r5, #56	; 0x38
c0d01ff6:	4368      	muls	r0, r5
c0d01ff8:	6822      	ldr	r2, [r4, #0]
c0d01ffa:	1810      	adds	r0, r2, r0
c0d01ffc:	2900      	cmp	r1, #0
c0d01ffe:	d009      	beq.n	c0d02014 <ui_idle+0xec>
c0d02000:	4788      	blx	r1
c0d02002:	2800      	cmp	r0, #0
c0d02004:	d106      	bne.n	c0d02014 <ui_idle+0xec>
c0d02006:	68a0      	ldr	r0, [r4, #8]
c0d02008:	1c45      	adds	r5, r0, #1
c0d0200a:	60a5      	str	r5, [r4, #8]
c0d0200c:	6820      	ldr	r0, [r4, #0]
c0d0200e:	2800      	cmp	r0, #0
c0d02010:	d1e7      	bne.n	c0d01fe2 <ui_idle+0xba>
c0d02012:	e00a      	b.n	c0d0202a <ui_idle+0x102>
c0d02014:	2801      	cmp	r0, #1
c0d02016:	d103      	bne.n	c0d02020 <ui_idle+0xf8>
c0d02018:	68a0      	ldr	r0, [r4, #8]
c0d0201a:	4345      	muls	r5, r0
c0d0201c:	6820      	ldr	r0, [r4, #0]
c0d0201e:	1940      	adds	r0, r0, r5
c0d02020:	f7fe fa8e 	bl	c0d00540 <io_seproxyhal_display>
c0d02024:	68a0      	ldr	r0, [r4, #8]
c0d02026:	1c40      	adds	r0, r0, #1
c0d02028:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d0202a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0202c:	20001a98 	.word	0x20001a98
c0d02030:	b0105044 	.word	0xb0105044
c0d02034:	0000153e 	.word	0x0000153e
c0d02038:	0000008d 	.word	0x0000008d
c0d0203c:	000013ec 	.word	0x000013ec
c0d02040:	fffffe27 	.word	0xfffffe27

c0d02044 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02044:	2000      	movs	r0, #0
c0d02046:	4770      	bx	lr

c0d02048 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02048:	b5d0      	push	{r4, r6, r7, lr}
c0d0204a:	af02      	add	r7, sp, #8
c0d0204c:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d0204e:	4620      	mov	r0, r4
c0d02050:	f7ff fddc 	bl	c0d01c0c <os_sched_exit>
    return NULL;
c0d02054:	4620      	mov	r0, r4
c0d02056:	bdd0      	pop	{r4, r6, r7, pc}

c0d02058 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02058:	4902      	ldr	r1, [pc, #8]	; (c0d02064 <USBD_LL_Init+0xc>)
c0d0205a:	2000      	movs	r0, #0
c0d0205c:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0205e:	4902      	ldr	r1, [pc, #8]	; (c0d02068 <USBD_LL_Init+0x10>)
c0d02060:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02062:	4770      	bx	lr
c0d02064:	20001d2c 	.word	0x20001d2c
c0d02068:	20001d30 	.word	0x20001d30

c0d0206c <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d0206c:	b5d0      	push	{r4, r6, r7, lr}
c0d0206e:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02070:	4806      	ldr	r0, [pc, #24]	; (c0d0208c <USBD_LL_DeInit+0x20>)
c0d02072:	214f      	movs	r1, #79	; 0x4f
c0d02074:	7001      	strb	r1, [r0, #0]
c0d02076:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02078:	7044      	strb	r4, [r0, #1]
c0d0207a:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d0207c:	7081      	strb	r1, [r0, #2]
c0d0207e:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02080:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02082:	2104      	movs	r1, #4
c0d02084:	f7ff fe1a 	bl	c0d01cbc <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02088:	4620      	mov	r0, r4
c0d0208a:	bdd0      	pop	{r4, r6, r7, pc}
c0d0208c:	20001a18 	.word	0x20001a18

c0d02090 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02090:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02092:	af03      	add	r7, sp, #12
c0d02094:	b083      	sub	sp, #12
c0d02096:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02098:	264f      	movs	r6, #79	; 0x4f
c0d0209a:	702e      	strb	r6, [r5, #0]
c0d0209c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0209e:	706c      	strb	r4, [r5, #1]
c0d020a0:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d020a2:	70a8      	strb	r0, [r5, #2]
c0d020a4:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d020a6:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d020a8:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d020aa:	2105      	movs	r1, #5
c0d020ac:	4628      	mov	r0, r5
c0d020ae:	f7ff fe05 	bl	c0d01cbc <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d020b2:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d020b4:	706c      	strb	r4, [r5, #1]
c0d020b6:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d020b8:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d020ba:	70e8      	strb	r0, [r5, #3]
c0d020bc:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d020be:	4628      	mov	r0, r5
c0d020c0:	f7ff fdfc 	bl	c0d01cbc <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d020c4:	4620      	mov	r0, r4
c0d020c6:	b003      	add	sp, #12
c0d020c8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d020ca <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d020ca:	b5d0      	push	{r4, r6, r7, lr}
c0d020cc:	af02      	add	r7, sp, #8
c0d020ce:	b082      	sub	sp, #8
c0d020d0:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d020d2:	214f      	movs	r1, #79	; 0x4f
c0d020d4:	7001      	strb	r1, [r0, #0]
c0d020d6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d020d8:	7044      	strb	r4, [r0, #1]
c0d020da:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d020dc:	7081      	strb	r1, [r0, #2]
c0d020de:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d020e0:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d020e2:	2104      	movs	r1, #4
c0d020e4:	f7ff fdea 	bl	c0d01cbc <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d020e8:	4620      	mov	r0, r4
c0d020ea:	b002      	add	sp, #8
c0d020ec:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d020f0 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d020f0:	b5b0      	push	{r4, r5, r7, lr}
c0d020f2:	af02      	add	r7, sp, #8
c0d020f4:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d020f6:	480f      	ldr	r0, [pc, #60]	; (c0d02134 <USBD_LL_OpenEP+0x44>)
c0d020f8:	2400      	movs	r4, #0
c0d020fa:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d020fc:	480e      	ldr	r0, [pc, #56]	; (c0d02138 <USBD_LL_OpenEP+0x48>)
c0d020fe:	6004      	str	r4, [r0, #0]
c0d02100:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02102:	254f      	movs	r5, #79	; 0x4f
c0d02104:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d02106:	7044      	strb	r4, [r0, #1]
c0d02108:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0210a:	7085      	strb	r5, [r0, #2]
c0d0210c:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0210e:	70c5      	strb	r5, [r0, #3]
c0d02110:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02112:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02114:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d02116:	2a03      	cmp	r2, #3
c0d02118:	d802      	bhi.n	c0d02120 <USBD_LL_OpenEP+0x30>
c0d0211a:	00d0      	lsls	r0, r2, #3
c0d0211c:	4c07      	ldr	r4, [pc, #28]	; (c0d0213c <USBD_LL_OpenEP+0x4c>)
c0d0211e:	40c4      	lsrs	r4, r0
c0d02120:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02122:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02124:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02126:	2108      	movs	r1, #8
c0d02128:	f7ff fdc8 	bl	c0d01cbc <io_seproxyhal_spi_send>
c0d0212c:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0212e:	b002      	add	sp, #8
c0d02130:	bdb0      	pop	{r4, r5, r7, pc}
c0d02132:	46c0      	nop			; (mov r8, r8)
c0d02134:	20001d2c 	.word	0x20001d2c
c0d02138:	20001d30 	.word	0x20001d30
c0d0213c:	02030401 	.word	0x02030401

c0d02140 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02140:	b5d0      	push	{r4, r6, r7, lr}
c0d02142:	af02      	add	r7, sp, #8
c0d02144:	b082      	sub	sp, #8
c0d02146:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02148:	224f      	movs	r2, #79	; 0x4f
c0d0214a:	7002      	strb	r2, [r0, #0]
c0d0214c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0214e:	7044      	strb	r4, [r0, #1]
c0d02150:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02152:	7082      	strb	r2, [r0, #2]
c0d02154:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02156:	70c2      	strb	r2, [r0, #3]
c0d02158:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0215a:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d0215c:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d0215e:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02160:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02162:	2108      	movs	r1, #8
c0d02164:	f7ff fdaa 	bl	c0d01cbc <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02168:	4620      	mov	r0, r4
c0d0216a:	b002      	add	sp, #8
c0d0216c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02170 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02170:	b5b0      	push	{r4, r5, r7, lr}
c0d02172:	af02      	add	r7, sp, #8
c0d02174:	b082      	sub	sp, #8
c0d02176:	460d      	mov	r5, r1
c0d02178:	4668      	mov	r0, sp
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
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02188:	2140      	movs	r1, #64	; 0x40
c0d0218a:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0218c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0218e:	2106      	movs	r1, #6
c0d02190:	f7ff fd94 	bl	c0d01cbc <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02194:	2080      	movs	r0, #128	; 0x80
c0d02196:	4205      	tst	r5, r0
c0d02198:	d101      	bne.n	c0d0219e <USBD_LL_StallEP+0x2e>
c0d0219a:	4807      	ldr	r0, [pc, #28]	; (c0d021b8 <USBD_LL_StallEP+0x48>)
c0d0219c:	e000      	b.n	c0d021a0 <USBD_LL_StallEP+0x30>
c0d0219e:	4805      	ldr	r0, [pc, #20]	; (c0d021b4 <USBD_LL_StallEP+0x44>)
c0d021a0:	6801      	ldr	r1, [r0, #0]
c0d021a2:	227f      	movs	r2, #127	; 0x7f
c0d021a4:	4015      	ands	r5, r2
c0d021a6:	2201      	movs	r2, #1
c0d021a8:	40aa      	lsls	r2, r5
c0d021aa:	430a      	orrs	r2, r1
c0d021ac:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d021ae:	4620      	mov	r0, r4
c0d021b0:	b002      	add	sp, #8
c0d021b2:	bdb0      	pop	{r4, r5, r7, pc}
c0d021b4:	20001d2c 	.word	0x20001d2c
c0d021b8:	20001d30 	.word	0x20001d30

c0d021bc <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d021bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d021be:	af03      	add	r7, sp, #12
c0d021c0:	b083      	sub	sp, #12
c0d021c2:	460d      	mov	r5, r1
c0d021c4:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d021c6:	2150      	movs	r1, #80	; 0x50
c0d021c8:	7001      	strb	r1, [r0, #0]
c0d021ca:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d021cc:	7044      	strb	r4, [r0, #1]
c0d021ce:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d021d0:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d021d2:	70c5      	strb	r5, [r0, #3]
c0d021d4:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d021d6:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d021d8:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d021da:	2106      	movs	r1, #6
c0d021dc:	f7ff fd6e 	bl	c0d01cbc <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d021e0:	4235      	tst	r5, r6
c0d021e2:	d101      	bne.n	c0d021e8 <USBD_LL_ClearStallEP+0x2c>
c0d021e4:	4807      	ldr	r0, [pc, #28]	; (c0d02204 <USBD_LL_ClearStallEP+0x48>)
c0d021e6:	e000      	b.n	c0d021ea <USBD_LL_ClearStallEP+0x2e>
c0d021e8:	4805      	ldr	r0, [pc, #20]	; (c0d02200 <USBD_LL_ClearStallEP+0x44>)
c0d021ea:	6801      	ldr	r1, [r0, #0]
c0d021ec:	227f      	movs	r2, #127	; 0x7f
c0d021ee:	4015      	ands	r5, r2
c0d021f0:	2201      	movs	r2, #1
c0d021f2:	40aa      	lsls	r2, r5
c0d021f4:	4391      	bics	r1, r2
c0d021f6:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d021f8:	4620      	mov	r0, r4
c0d021fa:	b003      	add	sp, #12
c0d021fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021fe:	46c0      	nop			; (mov r8, r8)
c0d02200:	20001d2c 	.word	0x20001d2c
c0d02204:	20001d30 	.word	0x20001d30

c0d02208 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02208:	2080      	movs	r0, #128	; 0x80
c0d0220a:	4201      	tst	r1, r0
c0d0220c:	d001      	beq.n	c0d02212 <USBD_LL_IsStallEP+0xa>
c0d0220e:	4806      	ldr	r0, [pc, #24]	; (c0d02228 <USBD_LL_IsStallEP+0x20>)
c0d02210:	e000      	b.n	c0d02214 <USBD_LL_IsStallEP+0xc>
c0d02212:	4804      	ldr	r0, [pc, #16]	; (c0d02224 <USBD_LL_IsStallEP+0x1c>)
c0d02214:	6800      	ldr	r0, [r0, #0]
c0d02216:	227f      	movs	r2, #127	; 0x7f
c0d02218:	4011      	ands	r1, r2
c0d0221a:	2201      	movs	r2, #1
c0d0221c:	408a      	lsls	r2, r1
c0d0221e:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02220:	b2d0      	uxtb	r0, r2
c0d02222:	4770      	bx	lr
c0d02224:	20001d30 	.word	0x20001d30
c0d02228:	20001d2c 	.word	0x20001d2c

c0d0222c <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d0222c:	b5d0      	push	{r4, r6, r7, lr}
c0d0222e:	af02      	add	r7, sp, #8
c0d02230:	b082      	sub	sp, #8
c0d02232:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02234:	224f      	movs	r2, #79	; 0x4f
c0d02236:	7002      	strb	r2, [r0, #0]
c0d02238:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0223a:	7044      	strb	r4, [r0, #1]
c0d0223c:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0223e:	7082      	strb	r2, [r0, #2]
c0d02240:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02242:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02244:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02246:	2105      	movs	r1, #5
c0d02248:	f7ff fd38 	bl	c0d01cbc <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0224c:	4620      	mov	r0, r4
c0d0224e:	b002      	add	sp, #8
c0d02250:	bdd0      	pop	{r4, r6, r7, pc}

c0d02252 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02252:	b5b0      	push	{r4, r5, r7, lr}
c0d02254:	af02      	add	r7, sp, #8
c0d02256:	b082      	sub	sp, #8
c0d02258:	461c      	mov	r4, r3
c0d0225a:	4615      	mov	r5, r2
c0d0225c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0225e:	2250      	movs	r2, #80	; 0x50
c0d02260:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02262:	1ce2      	adds	r2, r4, #3
c0d02264:	0a13      	lsrs	r3, r2, #8
c0d02266:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02268:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0226a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0226c:	2120      	movs	r1, #32
c0d0226e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02270:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02272:	2106      	movs	r1, #6
c0d02274:	f7ff fd22 	bl	c0d01cbc <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02278:	4628      	mov	r0, r5
c0d0227a:	4621      	mov	r1, r4
c0d0227c:	f7ff fd1e 	bl	c0d01cbc <io_seproxyhal_spi_send>
c0d02280:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02282:	b002      	add	sp, #8
c0d02284:	bdb0      	pop	{r4, r5, r7, pc}

c0d02286 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02286:	b5d0      	push	{r4, r6, r7, lr}
c0d02288:	af02      	add	r7, sp, #8
c0d0228a:	b082      	sub	sp, #8
c0d0228c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0228e:	2350      	movs	r3, #80	; 0x50
c0d02290:	7003      	strb	r3, [r0, #0]
c0d02292:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02294:	7044      	strb	r4, [r0, #1]
c0d02296:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02298:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0229a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d0229c:	2130      	movs	r1, #48	; 0x30
c0d0229e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d022a0:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d022a2:	2106      	movs	r1, #6
c0d022a4:	f7ff fd0a 	bl	c0d01cbc <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d022a8:	4620      	mov	r0, r4
c0d022aa:	b002      	add	sp, #8
c0d022ac:	bdd0      	pop	{r4, r6, r7, pc}

c0d022ae <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d022ae:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d022b0:	af03      	add	r7, sp, #12
c0d022b2:	b081      	sub	sp, #4
c0d022b4:	4615      	mov	r5, r2
c0d022b6:	460e      	mov	r6, r1
c0d022b8:	4604      	mov	r4, r0
c0d022ba:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d022bc:	2c00      	cmp	r4, #0
c0d022be:	d011      	beq.n	c0d022e4 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d022c0:	2049      	movs	r0, #73	; 0x49
c0d022c2:	0081      	lsls	r1, r0, #2
c0d022c4:	4620      	mov	r0, r4
c0d022c6:	f000 fef9 	bl	c0d030bc <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d022ca:	2e00      	cmp	r6, #0
c0d022cc:	d002      	beq.n	c0d022d4 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d022ce:	2011      	movs	r0, #17
c0d022d0:	0100      	lsls	r0, r0, #4
c0d022d2:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d022d4:	20fc      	movs	r0, #252	; 0xfc
c0d022d6:	2101      	movs	r1, #1
c0d022d8:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d022da:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d022dc:	4620      	mov	r0, r4
c0d022de:	f7ff febb 	bl	c0d02058 <USBD_LL_Init>
c0d022e2:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d022e4:	b2c0      	uxtb	r0, r0
c0d022e6:	b001      	add	sp, #4
c0d022e8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d022ea <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d022ea:	b5d0      	push	{r4, r6, r7, lr}
c0d022ec:	af02      	add	r7, sp, #8
c0d022ee:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d022f0:	20fc      	movs	r0, #252	; 0xfc
c0d022f2:	2101      	movs	r1, #1
c0d022f4:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d022f6:	2045      	movs	r0, #69	; 0x45
c0d022f8:	0080      	lsls	r0, r0, #2
c0d022fa:	5820      	ldr	r0, [r4, r0]
c0d022fc:	2800      	cmp	r0, #0
c0d022fe:	d006      	beq.n	c0d0230e <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02300:	6840      	ldr	r0, [r0, #4]
c0d02302:	f7ff fb1f 	bl	c0d01944 <pic>
c0d02306:	4602      	mov	r2, r0
c0d02308:	7921      	ldrb	r1, [r4, #4]
c0d0230a:	4620      	mov	r0, r4
c0d0230c:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0230e:	4620      	mov	r0, r4
c0d02310:	f7ff fedb 	bl	c0d020ca <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02314:	4620      	mov	r0, r4
c0d02316:	f7ff fea9 	bl	c0d0206c <USBD_LL_DeInit>
  
  return USBD_OK;
c0d0231a:	2000      	movs	r0, #0
c0d0231c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0231e <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0231e:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02320:	2900      	cmp	r1, #0
c0d02322:	d003      	beq.n	c0d0232c <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02324:	2245      	movs	r2, #69	; 0x45
c0d02326:	0092      	lsls	r2, r2, #2
c0d02328:	5081      	str	r1, [r0, r2]
c0d0232a:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d0232c:	b2d0      	uxtb	r0, r2
c0d0232e:	4770      	bx	lr

c0d02330 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02330:	b580      	push	{r7, lr}
c0d02332:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02334:	f7ff feac 	bl	c0d02090 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02338:	2000      	movs	r0, #0
c0d0233a:	bd80      	pop	{r7, pc}

c0d0233c <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0233c:	b5b0      	push	{r4, r5, r7, lr}
c0d0233e:	af02      	add	r7, sp, #8
c0d02340:	460c      	mov	r4, r1
c0d02342:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02344:	2045      	movs	r0, #69	; 0x45
c0d02346:	0080      	lsls	r0, r0, #2
c0d02348:	5828      	ldr	r0, [r5, r0]
c0d0234a:	2800      	cmp	r0, #0
c0d0234c:	d00c      	beq.n	c0d02368 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d0234e:	6800      	ldr	r0, [r0, #0]
c0d02350:	f7ff faf8 	bl	c0d01944 <pic>
c0d02354:	4602      	mov	r2, r0
c0d02356:	4628      	mov	r0, r5
c0d02358:	4621      	mov	r1, r4
c0d0235a:	4790      	blx	r2
c0d0235c:	4601      	mov	r1, r0
c0d0235e:	2002      	movs	r0, #2
c0d02360:	2900      	cmp	r1, #0
c0d02362:	d100      	bne.n	c0d02366 <USBD_SetClassConfig+0x2a>
c0d02364:	4608      	mov	r0, r1
c0d02366:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02368:	2002      	movs	r0, #2
c0d0236a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0236c <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0236c:	b5b0      	push	{r4, r5, r7, lr}
c0d0236e:	af02      	add	r7, sp, #8
c0d02370:	460c      	mov	r4, r1
c0d02372:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02374:	2045      	movs	r0, #69	; 0x45
c0d02376:	0080      	lsls	r0, r0, #2
c0d02378:	5828      	ldr	r0, [r5, r0]
c0d0237a:	2800      	cmp	r0, #0
c0d0237c:	d006      	beq.n	c0d0238c <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0237e:	6840      	ldr	r0, [r0, #4]
c0d02380:	f7ff fae0 	bl	c0d01944 <pic>
c0d02384:	4602      	mov	r2, r0
c0d02386:	4628      	mov	r0, r5
c0d02388:	4621      	mov	r1, r4
c0d0238a:	4790      	blx	r2
  }
  return USBD_OK;
c0d0238c:	2000      	movs	r0, #0
c0d0238e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02390 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02390:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02392:	af03      	add	r7, sp, #12
c0d02394:	b081      	sub	sp, #4
c0d02396:	4604      	mov	r4, r0
c0d02398:	2021      	movs	r0, #33	; 0x21
c0d0239a:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d0239c:	19a5      	adds	r5, r4, r6
c0d0239e:	4628      	mov	r0, r5
c0d023a0:	f000 fb69 	bl	c0d02a76 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d023a4:	20f4      	movs	r0, #244	; 0xf4
c0d023a6:	2101      	movs	r1, #1
c0d023a8:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d023aa:	2087      	movs	r0, #135	; 0x87
c0d023ac:	0040      	lsls	r0, r0, #1
c0d023ae:	5a20      	ldrh	r0, [r4, r0]
c0d023b0:	21f8      	movs	r1, #248	; 0xf8
c0d023b2:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d023b4:	5da1      	ldrb	r1, [r4, r6]
c0d023b6:	201f      	movs	r0, #31
c0d023b8:	4008      	ands	r0, r1
c0d023ba:	2802      	cmp	r0, #2
c0d023bc:	d008      	beq.n	c0d023d0 <USBD_LL_SetupStage+0x40>
c0d023be:	2801      	cmp	r0, #1
c0d023c0:	d00b      	beq.n	c0d023da <USBD_LL_SetupStage+0x4a>
c0d023c2:	2800      	cmp	r0, #0
c0d023c4:	d10e      	bne.n	c0d023e4 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d023c6:	4620      	mov	r0, r4
c0d023c8:	4629      	mov	r1, r5
c0d023ca:	f000 f8f1 	bl	c0d025b0 <USBD_StdDevReq>
c0d023ce:	e00e      	b.n	c0d023ee <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d023d0:	4620      	mov	r0, r4
c0d023d2:	4629      	mov	r1, r5
c0d023d4:	f000 fad3 	bl	c0d0297e <USBD_StdEPReq>
c0d023d8:	e009      	b.n	c0d023ee <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d023da:	4620      	mov	r0, r4
c0d023dc:	4629      	mov	r1, r5
c0d023de:	f000 faa6 	bl	c0d0292e <USBD_StdItfReq>
c0d023e2:	e004      	b.n	c0d023ee <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d023e4:	2080      	movs	r0, #128	; 0x80
c0d023e6:	4001      	ands	r1, r0
c0d023e8:	4620      	mov	r0, r4
c0d023ea:	f7ff fec1 	bl	c0d02170 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d023ee:	2000      	movs	r0, #0
c0d023f0:	b001      	add	sp, #4
c0d023f2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d023f4 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d023f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d023f6:	af03      	add	r7, sp, #12
c0d023f8:	b081      	sub	sp, #4
c0d023fa:	4615      	mov	r5, r2
c0d023fc:	460e      	mov	r6, r1
c0d023fe:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02400:	2e00      	cmp	r6, #0
c0d02402:	d011      	beq.n	c0d02428 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02404:	2045      	movs	r0, #69	; 0x45
c0d02406:	0080      	lsls	r0, r0, #2
c0d02408:	5820      	ldr	r0, [r4, r0]
c0d0240a:	6980      	ldr	r0, [r0, #24]
c0d0240c:	2800      	cmp	r0, #0
c0d0240e:	d034      	beq.n	c0d0247a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02410:	21fc      	movs	r1, #252	; 0xfc
c0d02412:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02414:	2903      	cmp	r1, #3
c0d02416:	d130      	bne.n	c0d0247a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02418:	f7ff fa94 	bl	c0d01944 <pic>
c0d0241c:	4603      	mov	r3, r0
c0d0241e:	4620      	mov	r0, r4
c0d02420:	4631      	mov	r1, r6
c0d02422:	462a      	mov	r2, r5
c0d02424:	4798      	blx	r3
c0d02426:	e028      	b.n	c0d0247a <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02428:	20f4      	movs	r0, #244	; 0xf4
c0d0242a:	5820      	ldr	r0, [r4, r0]
c0d0242c:	2803      	cmp	r0, #3
c0d0242e:	d124      	bne.n	c0d0247a <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02430:	2090      	movs	r0, #144	; 0x90
c0d02432:	5820      	ldr	r0, [r4, r0]
c0d02434:	218c      	movs	r1, #140	; 0x8c
c0d02436:	5861      	ldr	r1, [r4, r1]
c0d02438:	4622      	mov	r2, r4
c0d0243a:	328c      	adds	r2, #140	; 0x8c
c0d0243c:	4281      	cmp	r1, r0
c0d0243e:	d90a      	bls.n	c0d02456 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02440:	1a09      	subs	r1, r1, r0
c0d02442:	6011      	str	r1, [r2, #0]
c0d02444:	4281      	cmp	r1, r0
c0d02446:	d300      	bcc.n	c0d0244a <USBD_LL_DataOutStage+0x56>
c0d02448:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d0244a:	b28a      	uxth	r2, r1
c0d0244c:	4620      	mov	r0, r4
c0d0244e:	4629      	mov	r1, r5
c0d02450:	f000 fc70 	bl	c0d02d34 <USBD_CtlContinueRx>
c0d02454:	e011      	b.n	c0d0247a <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02456:	2045      	movs	r0, #69	; 0x45
c0d02458:	0080      	lsls	r0, r0, #2
c0d0245a:	5820      	ldr	r0, [r4, r0]
c0d0245c:	6900      	ldr	r0, [r0, #16]
c0d0245e:	2800      	cmp	r0, #0
c0d02460:	d008      	beq.n	c0d02474 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02462:	21fc      	movs	r1, #252	; 0xfc
c0d02464:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02466:	2903      	cmp	r1, #3
c0d02468:	d104      	bne.n	c0d02474 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d0246a:	f7ff fa6b 	bl	c0d01944 <pic>
c0d0246e:	4601      	mov	r1, r0
c0d02470:	4620      	mov	r0, r4
c0d02472:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02474:	4620      	mov	r0, r4
c0d02476:	f000 fc65 	bl	c0d02d44 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0247a:	2000      	movs	r0, #0
c0d0247c:	b001      	add	sp, #4
c0d0247e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02480 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02480:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02482:	af03      	add	r7, sp, #12
c0d02484:	b081      	sub	sp, #4
c0d02486:	460d      	mov	r5, r1
c0d02488:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0248a:	2d00      	cmp	r5, #0
c0d0248c:	d012      	beq.n	c0d024b4 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0248e:	2045      	movs	r0, #69	; 0x45
c0d02490:	0080      	lsls	r0, r0, #2
c0d02492:	5820      	ldr	r0, [r4, r0]
c0d02494:	2800      	cmp	r0, #0
c0d02496:	d054      	beq.n	c0d02542 <USBD_LL_DataInStage+0xc2>
c0d02498:	6940      	ldr	r0, [r0, #20]
c0d0249a:	2800      	cmp	r0, #0
c0d0249c:	d051      	beq.n	c0d02542 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0249e:	21fc      	movs	r1, #252	; 0xfc
c0d024a0:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d024a2:	2903      	cmp	r1, #3
c0d024a4:	d14d      	bne.n	c0d02542 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d024a6:	f7ff fa4d 	bl	c0d01944 <pic>
c0d024aa:	4602      	mov	r2, r0
c0d024ac:	4620      	mov	r0, r4
c0d024ae:	4629      	mov	r1, r5
c0d024b0:	4790      	blx	r2
c0d024b2:	e046      	b.n	c0d02542 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d024b4:	20f4      	movs	r0, #244	; 0xf4
c0d024b6:	5820      	ldr	r0, [r4, r0]
c0d024b8:	2802      	cmp	r0, #2
c0d024ba:	d13a      	bne.n	c0d02532 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d024bc:	69e0      	ldr	r0, [r4, #28]
c0d024be:	6a25      	ldr	r5, [r4, #32]
c0d024c0:	42a8      	cmp	r0, r5
c0d024c2:	d90b      	bls.n	c0d024dc <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d024c4:	1b40      	subs	r0, r0, r5
c0d024c6:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d024c8:	2109      	movs	r1, #9
c0d024ca:	014a      	lsls	r2, r1, #5
c0d024cc:	58a1      	ldr	r1, [r4, r2]
c0d024ce:	1949      	adds	r1, r1, r5
c0d024d0:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d024d2:	b282      	uxth	r2, r0
c0d024d4:	4620      	mov	r0, r4
c0d024d6:	f000 fc1e 	bl	c0d02d16 <USBD_CtlContinueSendData>
c0d024da:	e02a      	b.n	c0d02532 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d024dc:	69a6      	ldr	r6, [r4, #24]
c0d024de:	4630      	mov	r0, r6
c0d024e0:	4629      	mov	r1, r5
c0d024e2:	f000 fccf 	bl	c0d02e84 <__aeabi_uidivmod>
c0d024e6:	42ae      	cmp	r6, r5
c0d024e8:	d30f      	bcc.n	c0d0250a <USBD_LL_DataInStage+0x8a>
c0d024ea:	2900      	cmp	r1, #0
c0d024ec:	d10d      	bne.n	c0d0250a <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d024ee:	20f8      	movs	r0, #248	; 0xf8
c0d024f0:	5820      	ldr	r0, [r4, r0]
c0d024f2:	4625      	mov	r5, r4
c0d024f4:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d024f6:	4286      	cmp	r6, r0
c0d024f8:	d207      	bcs.n	c0d0250a <USBD_LL_DataInStage+0x8a>
c0d024fa:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d024fc:	4620      	mov	r0, r4
c0d024fe:	4631      	mov	r1, r6
c0d02500:	4632      	mov	r2, r6
c0d02502:	f000 fc08 	bl	c0d02d16 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02506:	602e      	str	r6, [r5, #0]
c0d02508:	e013      	b.n	c0d02532 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0250a:	2045      	movs	r0, #69	; 0x45
c0d0250c:	0080      	lsls	r0, r0, #2
c0d0250e:	5820      	ldr	r0, [r4, r0]
c0d02510:	2800      	cmp	r0, #0
c0d02512:	d00b      	beq.n	c0d0252c <USBD_LL_DataInStage+0xac>
c0d02514:	68c0      	ldr	r0, [r0, #12]
c0d02516:	2800      	cmp	r0, #0
c0d02518:	d008      	beq.n	c0d0252c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0251a:	21fc      	movs	r1, #252	; 0xfc
c0d0251c:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0251e:	2903      	cmp	r1, #3
c0d02520:	d104      	bne.n	c0d0252c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02522:	f7ff fa0f 	bl	c0d01944 <pic>
c0d02526:	4601      	mov	r1, r0
c0d02528:	4620      	mov	r0, r4
c0d0252a:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d0252c:	4620      	mov	r0, r4
c0d0252e:	f000 fc16 	bl	c0d02d5e <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02532:	2001      	movs	r0, #1
c0d02534:	0201      	lsls	r1, r0, #8
c0d02536:	1860      	adds	r0, r4, r1
c0d02538:	5c61      	ldrb	r1, [r4, r1]
c0d0253a:	2901      	cmp	r1, #1
c0d0253c:	d101      	bne.n	c0d02542 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d0253e:	2100      	movs	r1, #0
c0d02540:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02542:	2000      	movs	r0, #0
c0d02544:	b001      	add	sp, #4
c0d02546:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02548 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02548:	b5d0      	push	{r4, r6, r7, lr}
c0d0254a:	af02      	add	r7, sp, #8
c0d0254c:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d0254e:	2090      	movs	r0, #144	; 0x90
c0d02550:	2140      	movs	r1, #64	; 0x40
c0d02552:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02554:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02556:	20fc      	movs	r0, #252	; 0xfc
c0d02558:	2101      	movs	r1, #1
c0d0255a:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d0255c:	2045      	movs	r0, #69	; 0x45
c0d0255e:	0080      	lsls	r0, r0, #2
c0d02560:	5820      	ldr	r0, [r4, r0]
c0d02562:	2800      	cmp	r0, #0
c0d02564:	d006      	beq.n	c0d02574 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02566:	6840      	ldr	r0, [r0, #4]
c0d02568:	f7ff f9ec 	bl	c0d01944 <pic>
c0d0256c:	4602      	mov	r2, r0
c0d0256e:	7921      	ldrb	r1, [r4, #4]
c0d02570:	4620      	mov	r0, r4
c0d02572:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02574:	2000      	movs	r0, #0
c0d02576:	bdd0      	pop	{r4, r6, r7, pc}

c0d02578 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02578:	7401      	strb	r1, [r0, #16]
c0d0257a:	2000      	movs	r0, #0
  return USBD_OK;
c0d0257c:	4770      	bx	lr

c0d0257e <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0257e:	2000      	movs	r0, #0
c0d02580:	4770      	bx	lr

c0d02582 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02582:	2000      	movs	r0, #0
c0d02584:	4770      	bx	lr

c0d02586 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02586:	b5d0      	push	{r4, r6, r7, lr}
c0d02588:	af02      	add	r7, sp, #8
c0d0258a:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d0258c:	20fc      	movs	r0, #252	; 0xfc
c0d0258e:	5c20      	ldrb	r0, [r4, r0]
c0d02590:	2803      	cmp	r0, #3
c0d02592:	d10a      	bne.n	c0d025aa <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02594:	2045      	movs	r0, #69	; 0x45
c0d02596:	0080      	lsls	r0, r0, #2
c0d02598:	5820      	ldr	r0, [r4, r0]
c0d0259a:	69c0      	ldr	r0, [r0, #28]
c0d0259c:	2800      	cmp	r0, #0
c0d0259e:	d004      	beq.n	c0d025aa <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d025a0:	f7ff f9d0 	bl	c0d01944 <pic>
c0d025a4:	4601      	mov	r1, r0
c0d025a6:	4620      	mov	r0, r4
c0d025a8:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d025aa:	2000      	movs	r0, #0
c0d025ac:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d025b0 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d025b0:	b5d0      	push	{r4, r6, r7, lr}
c0d025b2:	af02      	add	r7, sp, #8
c0d025b4:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d025b6:	7848      	ldrb	r0, [r1, #1]
c0d025b8:	2809      	cmp	r0, #9
c0d025ba:	d810      	bhi.n	c0d025de <USBD_StdDevReq+0x2e>
c0d025bc:	4478      	add	r0, pc
c0d025be:	7900      	ldrb	r0, [r0, #4]
c0d025c0:	0040      	lsls	r0, r0, #1
c0d025c2:	4487      	add	pc, r0
c0d025c4:	150c0804 	.word	0x150c0804
c0d025c8:	0c25190c 	.word	0x0c25190c
c0d025cc:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d025ce:	4620      	mov	r0, r4
c0d025d0:	f000 f938 	bl	c0d02844 <USBD_GetStatus>
c0d025d4:	e01f      	b.n	c0d02616 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d025d6:	4620      	mov	r0, r4
c0d025d8:	f000 f976 	bl	c0d028c8 <USBD_ClrFeature>
c0d025dc:	e01b      	b.n	c0d02616 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d025de:	2180      	movs	r1, #128	; 0x80
c0d025e0:	4620      	mov	r0, r4
c0d025e2:	f7ff fdc5 	bl	c0d02170 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d025e6:	2100      	movs	r1, #0
c0d025e8:	4620      	mov	r0, r4
c0d025ea:	f7ff fdc1 	bl	c0d02170 <USBD_LL_StallEP>
c0d025ee:	e012      	b.n	c0d02616 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d025f0:	4620      	mov	r0, r4
c0d025f2:	f000 f950 	bl	c0d02896 <USBD_SetFeature>
c0d025f6:	e00e      	b.n	c0d02616 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d025f8:	4620      	mov	r0, r4
c0d025fa:	f000 f897 	bl	c0d0272c <USBD_SetAddress>
c0d025fe:	e00a      	b.n	c0d02616 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02600:	4620      	mov	r0, r4
c0d02602:	f000 f8ff 	bl	c0d02804 <USBD_GetConfig>
c0d02606:	e006      	b.n	c0d02616 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02608:	4620      	mov	r0, r4
c0d0260a:	f000 f8bd 	bl	c0d02788 <USBD_SetConfig>
c0d0260e:	e002      	b.n	c0d02616 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02610:	4620      	mov	r0, r4
c0d02612:	f000 f803 	bl	c0d0261c <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02616:	2000      	movs	r0, #0
c0d02618:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0261c <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d0261c:	b5b0      	push	{r4, r5, r7, lr}
c0d0261e:	af02      	add	r7, sp, #8
c0d02620:	b082      	sub	sp, #8
c0d02622:	460d      	mov	r5, r1
c0d02624:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02626:	8868      	ldrh	r0, [r5, #2]
c0d02628:	0a01      	lsrs	r1, r0, #8
c0d0262a:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0262c:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d0262e:	2a0e      	cmp	r2, #14
c0d02630:	d83e      	bhi.n	c0d026b0 <USBD_GetDescriptor+0x94>
c0d02632:	46c0      	nop			; (mov r8, r8)
c0d02634:	447a      	add	r2, pc
c0d02636:	7912      	ldrb	r2, [r2, #4]
c0d02638:	0052      	lsls	r2, r2, #1
c0d0263a:	4497      	add	pc, r2
c0d0263c:	390c2607 	.word	0x390c2607
c0d02640:	39362e39 	.word	0x39362e39
c0d02644:	39393939 	.word	0x39393939
c0d02648:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d0264c:	2011      	movs	r0, #17
c0d0264e:	0100      	lsls	r0, r0, #4
c0d02650:	5820      	ldr	r0, [r4, r0]
c0d02652:	6800      	ldr	r0, [r0, #0]
c0d02654:	e012      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02656:	b2c0      	uxtb	r0, r0
c0d02658:	2805      	cmp	r0, #5
c0d0265a:	d829      	bhi.n	c0d026b0 <USBD_GetDescriptor+0x94>
c0d0265c:	4478      	add	r0, pc
c0d0265e:	7900      	ldrb	r0, [r0, #4]
c0d02660:	0040      	lsls	r0, r0, #1
c0d02662:	4487      	add	pc, r0
c0d02664:	544f4a02 	.word	0x544f4a02
c0d02668:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0266a:	2011      	movs	r0, #17
c0d0266c:	0100      	lsls	r0, r0, #4
c0d0266e:	5820      	ldr	r0, [r4, r0]
c0d02670:	6840      	ldr	r0, [r0, #4]
c0d02672:	e003      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02674:	2011      	movs	r0, #17
c0d02676:	0100      	lsls	r0, r0, #4
c0d02678:	5820      	ldr	r0, [r4, r0]
c0d0267a:	69c0      	ldr	r0, [r0, #28]
c0d0267c:	f7ff f962 	bl	c0d01944 <pic>
c0d02680:	4602      	mov	r2, r0
c0d02682:	7c20      	ldrb	r0, [r4, #16]
c0d02684:	a901      	add	r1, sp, #4
c0d02686:	4790      	blx	r2
c0d02688:	e025      	b.n	c0d026d6 <USBD_GetDescriptor+0xba>
c0d0268a:	2045      	movs	r0, #69	; 0x45
c0d0268c:	0080      	lsls	r0, r0, #2
c0d0268e:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02690:	7c21      	ldrb	r1, [r4, #16]
c0d02692:	2900      	cmp	r1, #0
c0d02694:	d014      	beq.n	c0d026c0 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02696:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02698:	e018      	b.n	c0d026cc <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0269a:	7c20      	ldrb	r0, [r4, #16]
c0d0269c:	2800      	cmp	r0, #0
c0d0269e:	d107      	bne.n	c0d026b0 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d026a0:	2045      	movs	r0, #69	; 0x45
c0d026a2:	0080      	lsls	r0, r0, #2
c0d026a4:	5820      	ldr	r0, [r4, r0]
c0d026a6:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d026a8:	e010      	b.n	c0d026cc <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d026aa:	7c20      	ldrb	r0, [r4, #16]
c0d026ac:	2800      	cmp	r0, #0
c0d026ae:	d009      	beq.n	c0d026c4 <USBD_GetDescriptor+0xa8>
c0d026b0:	4620      	mov	r0, r4
c0d026b2:	f7ff fd5d 	bl	c0d02170 <USBD_LL_StallEP>
c0d026b6:	2100      	movs	r1, #0
c0d026b8:	4620      	mov	r0, r4
c0d026ba:	f7ff fd59 	bl	c0d02170 <USBD_LL_StallEP>
c0d026be:	e01a      	b.n	c0d026f6 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d026c0:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d026c2:	e003      	b.n	c0d026cc <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d026c4:	2045      	movs	r0, #69	; 0x45
c0d026c6:	0080      	lsls	r0, r0, #2
c0d026c8:	5820      	ldr	r0, [r4, r0]
c0d026ca:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d026cc:	f7ff f93a 	bl	c0d01944 <pic>
c0d026d0:	4601      	mov	r1, r0
c0d026d2:	a801      	add	r0, sp, #4
c0d026d4:	4788      	blx	r1
c0d026d6:	4601      	mov	r1, r0
c0d026d8:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d026da:	8802      	ldrh	r2, [r0, #0]
c0d026dc:	2a00      	cmp	r2, #0
c0d026de:	d00a      	beq.n	c0d026f6 <USBD_GetDescriptor+0xda>
c0d026e0:	88e8      	ldrh	r0, [r5, #6]
c0d026e2:	2800      	cmp	r0, #0
c0d026e4:	d007      	beq.n	c0d026f6 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d026e6:	4282      	cmp	r2, r0
c0d026e8:	d300      	bcc.n	c0d026ec <USBD_GetDescriptor+0xd0>
c0d026ea:	4602      	mov	r2, r0
c0d026ec:	a801      	add	r0, sp, #4
c0d026ee:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d026f0:	4620      	mov	r0, r4
c0d026f2:	f000 faf9 	bl	c0d02ce8 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d026f6:	b002      	add	sp, #8
c0d026f8:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d026fa:	2011      	movs	r0, #17
c0d026fc:	0100      	lsls	r0, r0, #4
c0d026fe:	5820      	ldr	r0, [r4, r0]
c0d02700:	6880      	ldr	r0, [r0, #8]
c0d02702:	e7bb      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02704:	2011      	movs	r0, #17
c0d02706:	0100      	lsls	r0, r0, #4
c0d02708:	5820      	ldr	r0, [r4, r0]
c0d0270a:	68c0      	ldr	r0, [r0, #12]
c0d0270c:	e7b6      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d0270e:	2011      	movs	r0, #17
c0d02710:	0100      	lsls	r0, r0, #4
c0d02712:	5820      	ldr	r0, [r4, r0]
c0d02714:	6900      	ldr	r0, [r0, #16]
c0d02716:	e7b1      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02718:	2011      	movs	r0, #17
c0d0271a:	0100      	lsls	r0, r0, #4
c0d0271c:	5820      	ldr	r0, [r4, r0]
c0d0271e:	6940      	ldr	r0, [r0, #20]
c0d02720:	e7ac      	b.n	c0d0267c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02722:	2011      	movs	r0, #17
c0d02724:	0100      	lsls	r0, r0, #4
c0d02726:	5820      	ldr	r0, [r4, r0]
c0d02728:	6980      	ldr	r0, [r0, #24]
c0d0272a:	e7a7      	b.n	c0d0267c <USBD_GetDescriptor+0x60>

c0d0272c <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0272c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0272e:	af03      	add	r7, sp, #12
c0d02730:	b081      	sub	sp, #4
c0d02732:	460a      	mov	r2, r1
c0d02734:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02736:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02738:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0273a:	2800      	cmp	r0, #0
c0d0273c:	d10b      	bne.n	c0d02756 <USBD_SetAddress+0x2a>
c0d0273e:	88d0      	ldrh	r0, [r2, #6]
c0d02740:	2800      	cmp	r0, #0
c0d02742:	d108      	bne.n	c0d02756 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02744:	8850      	ldrh	r0, [r2, #2]
c0d02746:	267f      	movs	r6, #127	; 0x7f
c0d02748:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d0274a:	20fc      	movs	r0, #252	; 0xfc
c0d0274c:	5c20      	ldrb	r0, [r4, r0]
c0d0274e:	4625      	mov	r5, r4
c0d02750:	35fc      	adds	r5, #252	; 0xfc
c0d02752:	2803      	cmp	r0, #3
c0d02754:	d108      	bne.n	c0d02768 <USBD_SetAddress+0x3c>
c0d02756:	4620      	mov	r0, r4
c0d02758:	f7ff fd0a 	bl	c0d02170 <USBD_LL_StallEP>
c0d0275c:	2100      	movs	r1, #0
c0d0275e:	4620      	mov	r0, r4
c0d02760:	f7ff fd06 	bl	c0d02170 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02764:	b001      	add	sp, #4
c0d02766:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02768:	20fe      	movs	r0, #254	; 0xfe
c0d0276a:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d0276c:	b2f1      	uxtb	r1, r6
c0d0276e:	4620      	mov	r0, r4
c0d02770:	f7ff fd5c 	bl	c0d0222c <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02774:	4620      	mov	r0, r4
c0d02776:	f000 fae5 	bl	c0d02d44 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d0277a:	2002      	movs	r0, #2
c0d0277c:	2101      	movs	r1, #1
c0d0277e:	2e00      	cmp	r6, #0
c0d02780:	d100      	bne.n	c0d02784 <USBD_SetAddress+0x58>
c0d02782:	4608      	mov	r0, r1
c0d02784:	7028      	strb	r0, [r5, #0]
c0d02786:	e7ed      	b.n	c0d02764 <USBD_SetAddress+0x38>

c0d02788 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02788:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0278a:	af03      	add	r7, sp, #12
c0d0278c:	b081      	sub	sp, #4
c0d0278e:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02790:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02792:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02794:	2e02      	cmp	r6, #2
c0d02796:	d21d      	bcs.n	c0d027d4 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02798:	20fc      	movs	r0, #252	; 0xfc
c0d0279a:	5c21      	ldrb	r1, [r4, r0]
c0d0279c:	4620      	mov	r0, r4
c0d0279e:	30fc      	adds	r0, #252	; 0xfc
c0d027a0:	2903      	cmp	r1, #3
c0d027a2:	d007      	beq.n	c0d027b4 <USBD_SetConfig+0x2c>
c0d027a4:	2902      	cmp	r1, #2
c0d027a6:	d115      	bne.n	c0d027d4 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d027a8:	2e00      	cmp	r6, #0
c0d027aa:	d026      	beq.n	c0d027fa <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d027ac:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d027ae:	2103      	movs	r1, #3
c0d027b0:	7001      	strb	r1, [r0, #0]
c0d027b2:	e009      	b.n	c0d027c8 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d027b4:	2e00      	cmp	r6, #0
c0d027b6:	d016      	beq.n	c0d027e6 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d027b8:	6860      	ldr	r0, [r4, #4]
c0d027ba:	4286      	cmp	r6, r0
c0d027bc:	d01d      	beq.n	c0d027fa <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d027be:	b2c1      	uxtb	r1, r0
c0d027c0:	4620      	mov	r0, r4
c0d027c2:	f7ff fdd3 	bl	c0d0236c <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d027c6:	6066      	str	r6, [r4, #4]
c0d027c8:	4620      	mov	r0, r4
c0d027ca:	4631      	mov	r1, r6
c0d027cc:	f7ff fdb6 	bl	c0d0233c <USBD_SetClassConfig>
c0d027d0:	2802      	cmp	r0, #2
c0d027d2:	d112      	bne.n	c0d027fa <USBD_SetConfig+0x72>
c0d027d4:	4620      	mov	r0, r4
c0d027d6:	4629      	mov	r1, r5
c0d027d8:	f7ff fcca 	bl	c0d02170 <USBD_LL_StallEP>
c0d027dc:	2100      	movs	r1, #0
c0d027de:	4620      	mov	r0, r4
c0d027e0:	f7ff fcc6 	bl	c0d02170 <USBD_LL_StallEP>
c0d027e4:	e00c      	b.n	c0d02800 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d027e6:	2102      	movs	r1, #2
c0d027e8:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d027ea:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d027ec:	4620      	mov	r0, r4
c0d027ee:	4631      	mov	r1, r6
c0d027f0:	f7ff fdbc 	bl	c0d0236c <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d027f4:	4620      	mov	r0, r4
c0d027f6:	f000 faa5 	bl	c0d02d44 <USBD_CtlSendStatus>
c0d027fa:	4620      	mov	r0, r4
c0d027fc:	f000 faa2 	bl	c0d02d44 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02800:	b001      	add	sp, #4
c0d02802:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02804 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02804:	b5d0      	push	{r4, r6, r7, lr}
c0d02806:	af02      	add	r7, sp, #8
c0d02808:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d0280a:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0280c:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d0280e:	2801      	cmp	r0, #1
c0d02810:	d10a      	bne.n	c0d02828 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02812:	20fc      	movs	r0, #252	; 0xfc
c0d02814:	5c20      	ldrb	r0, [r4, r0]
c0d02816:	2803      	cmp	r0, #3
c0d02818:	d00e      	beq.n	c0d02838 <USBD_GetConfig+0x34>
c0d0281a:	2802      	cmp	r0, #2
c0d0281c:	d104      	bne.n	c0d02828 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d0281e:	2000      	movs	r0, #0
c0d02820:	60a0      	str	r0, [r4, #8]
c0d02822:	4621      	mov	r1, r4
c0d02824:	3108      	adds	r1, #8
c0d02826:	e008      	b.n	c0d0283a <USBD_GetConfig+0x36>
c0d02828:	4620      	mov	r0, r4
c0d0282a:	f7ff fca1 	bl	c0d02170 <USBD_LL_StallEP>
c0d0282e:	2100      	movs	r1, #0
c0d02830:	4620      	mov	r0, r4
c0d02832:	f7ff fc9d 	bl	c0d02170 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02836:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02838:	1d21      	adds	r1, r4, #4
c0d0283a:	2201      	movs	r2, #1
c0d0283c:	4620      	mov	r0, r4
c0d0283e:	f000 fa53 	bl	c0d02ce8 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02842:	bdd0      	pop	{r4, r6, r7, pc}

c0d02844 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02844:	b5b0      	push	{r4, r5, r7, lr}
c0d02846:	af02      	add	r7, sp, #8
c0d02848:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d0284a:	20fc      	movs	r0, #252	; 0xfc
c0d0284c:	5c20      	ldrb	r0, [r4, r0]
c0d0284e:	21fe      	movs	r1, #254	; 0xfe
c0d02850:	4001      	ands	r1, r0
c0d02852:	2902      	cmp	r1, #2
c0d02854:	d116      	bne.n	c0d02884 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02856:	2001      	movs	r0, #1
c0d02858:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0285a:	2041      	movs	r0, #65	; 0x41
c0d0285c:	0080      	lsls	r0, r0, #2
c0d0285e:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02860:	4625      	mov	r5, r4
c0d02862:	350c      	adds	r5, #12
c0d02864:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02866:	2900      	cmp	r1, #0
c0d02868:	d005      	beq.n	c0d02876 <USBD_GetStatus+0x32>
c0d0286a:	4620      	mov	r0, r4
c0d0286c:	f000 fa77 	bl	c0d02d5e <USBD_CtlReceiveStatus>
c0d02870:	68e1      	ldr	r1, [r4, #12]
c0d02872:	2002      	movs	r0, #2
c0d02874:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02876:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02878:	2202      	movs	r2, #2
c0d0287a:	4620      	mov	r0, r4
c0d0287c:	4629      	mov	r1, r5
c0d0287e:	f000 fa33 	bl	c0d02ce8 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02882:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02884:	2180      	movs	r1, #128	; 0x80
c0d02886:	4620      	mov	r0, r4
c0d02888:	f7ff fc72 	bl	c0d02170 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0288c:	2100      	movs	r1, #0
c0d0288e:	4620      	mov	r0, r4
c0d02890:	f7ff fc6e 	bl	c0d02170 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02894:	bdb0      	pop	{r4, r5, r7, pc}

c0d02896 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02896:	b5b0      	push	{r4, r5, r7, lr}
c0d02898:	af02      	add	r7, sp, #8
c0d0289a:	460d      	mov	r5, r1
c0d0289c:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d0289e:	8868      	ldrh	r0, [r5, #2]
c0d028a0:	2801      	cmp	r0, #1
c0d028a2:	d110      	bne.n	c0d028c6 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d028a4:	2041      	movs	r0, #65	; 0x41
c0d028a6:	0080      	lsls	r0, r0, #2
c0d028a8:	2101      	movs	r1, #1
c0d028aa:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d028ac:	2045      	movs	r0, #69	; 0x45
c0d028ae:	0080      	lsls	r0, r0, #2
c0d028b0:	5820      	ldr	r0, [r4, r0]
c0d028b2:	6880      	ldr	r0, [r0, #8]
c0d028b4:	f7ff f846 	bl	c0d01944 <pic>
c0d028b8:	4602      	mov	r2, r0
c0d028ba:	4620      	mov	r0, r4
c0d028bc:	4629      	mov	r1, r5
c0d028be:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d028c0:	4620      	mov	r0, r4
c0d028c2:	f000 fa3f 	bl	c0d02d44 <USBD_CtlSendStatus>
  }

}
c0d028c6:	bdb0      	pop	{r4, r5, r7, pc}

c0d028c8 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d028c8:	b5b0      	push	{r4, r5, r7, lr}
c0d028ca:	af02      	add	r7, sp, #8
c0d028cc:	460d      	mov	r5, r1
c0d028ce:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d028d0:	20fc      	movs	r0, #252	; 0xfc
c0d028d2:	5c20      	ldrb	r0, [r4, r0]
c0d028d4:	21fe      	movs	r1, #254	; 0xfe
c0d028d6:	4001      	ands	r1, r0
c0d028d8:	2902      	cmp	r1, #2
c0d028da:	d114      	bne.n	c0d02906 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d028dc:	8868      	ldrh	r0, [r5, #2]
c0d028de:	2801      	cmp	r0, #1
c0d028e0:	d119      	bne.n	c0d02916 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d028e2:	2041      	movs	r0, #65	; 0x41
c0d028e4:	0080      	lsls	r0, r0, #2
c0d028e6:	2100      	movs	r1, #0
c0d028e8:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d028ea:	2045      	movs	r0, #69	; 0x45
c0d028ec:	0080      	lsls	r0, r0, #2
c0d028ee:	5820      	ldr	r0, [r4, r0]
c0d028f0:	6880      	ldr	r0, [r0, #8]
c0d028f2:	f7ff f827 	bl	c0d01944 <pic>
c0d028f6:	4602      	mov	r2, r0
c0d028f8:	4620      	mov	r0, r4
c0d028fa:	4629      	mov	r1, r5
c0d028fc:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d028fe:	4620      	mov	r0, r4
c0d02900:	f000 fa20 	bl	c0d02d44 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02904:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02906:	2180      	movs	r1, #128	; 0x80
c0d02908:	4620      	mov	r0, r4
c0d0290a:	f7ff fc31 	bl	c0d02170 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0290e:	2100      	movs	r1, #0
c0d02910:	4620      	mov	r0, r4
c0d02912:	f7ff fc2d 	bl	c0d02170 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02916:	bdb0      	pop	{r4, r5, r7, pc}

c0d02918 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02918:	b5d0      	push	{r4, r6, r7, lr}
c0d0291a:	af02      	add	r7, sp, #8
c0d0291c:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0291e:	2180      	movs	r1, #128	; 0x80
c0d02920:	f7ff fc26 	bl	c0d02170 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02924:	2100      	movs	r1, #0
c0d02926:	4620      	mov	r0, r4
c0d02928:	f7ff fc22 	bl	c0d02170 <USBD_LL_StallEP>
}
c0d0292c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0292e <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0292e:	b5b0      	push	{r4, r5, r7, lr}
c0d02930:	af02      	add	r7, sp, #8
c0d02932:	460d      	mov	r5, r1
c0d02934:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02936:	20fc      	movs	r0, #252	; 0xfc
c0d02938:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0293a:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0293c:	2803      	cmp	r0, #3
c0d0293e:	d115      	bne.n	c0d0296c <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02940:	88a8      	ldrh	r0, [r5, #4]
c0d02942:	22fe      	movs	r2, #254	; 0xfe
c0d02944:	4002      	ands	r2, r0
c0d02946:	2a01      	cmp	r2, #1
c0d02948:	d810      	bhi.n	c0d0296c <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d0294a:	2045      	movs	r0, #69	; 0x45
c0d0294c:	0080      	lsls	r0, r0, #2
c0d0294e:	5820      	ldr	r0, [r4, r0]
c0d02950:	6880      	ldr	r0, [r0, #8]
c0d02952:	f7fe fff7 	bl	c0d01944 <pic>
c0d02956:	4602      	mov	r2, r0
c0d02958:	4620      	mov	r0, r4
c0d0295a:	4629      	mov	r1, r5
c0d0295c:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d0295e:	88e8      	ldrh	r0, [r5, #6]
c0d02960:	2800      	cmp	r0, #0
c0d02962:	d10a      	bne.n	c0d0297a <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02964:	4620      	mov	r0, r4
c0d02966:	f000 f9ed 	bl	c0d02d44 <USBD_CtlSendStatus>
c0d0296a:	e006      	b.n	c0d0297a <USBD_StdItfReq+0x4c>
c0d0296c:	4620      	mov	r0, r4
c0d0296e:	f7ff fbff 	bl	c0d02170 <USBD_LL_StallEP>
c0d02972:	2100      	movs	r1, #0
c0d02974:	4620      	mov	r0, r4
c0d02976:	f7ff fbfb 	bl	c0d02170 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0297a:	2000      	movs	r0, #0
c0d0297c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0297e <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0297e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02980:	af03      	add	r7, sp, #12
c0d02982:	b081      	sub	sp, #4
c0d02984:	460e      	mov	r6, r1
c0d02986:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02988:	7830      	ldrb	r0, [r6, #0]
c0d0298a:	2160      	movs	r1, #96	; 0x60
c0d0298c:	4001      	ands	r1, r0
c0d0298e:	2920      	cmp	r1, #32
c0d02990:	d10a      	bne.n	c0d029a8 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02992:	2045      	movs	r0, #69	; 0x45
c0d02994:	0080      	lsls	r0, r0, #2
c0d02996:	5820      	ldr	r0, [r4, r0]
c0d02998:	6880      	ldr	r0, [r0, #8]
c0d0299a:	f7fe ffd3 	bl	c0d01944 <pic>
c0d0299e:	4602      	mov	r2, r0
c0d029a0:	4620      	mov	r0, r4
c0d029a2:	4631      	mov	r1, r6
c0d029a4:	4790      	blx	r2
c0d029a6:	e063      	b.n	c0d02a70 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d029a8:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d029aa:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029ac:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d029ae:	2800      	cmp	r0, #0
c0d029b0:	d012      	beq.n	c0d029d8 <USBD_StdEPReq+0x5a>
c0d029b2:	2801      	cmp	r0, #1
c0d029b4:	d019      	beq.n	c0d029ea <USBD_StdEPReq+0x6c>
c0d029b6:	2803      	cmp	r0, #3
c0d029b8:	d15a      	bne.n	c0d02a70 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d029ba:	20fc      	movs	r0, #252	; 0xfc
c0d029bc:	5c20      	ldrb	r0, [r4, r0]
c0d029be:	2803      	cmp	r0, #3
c0d029c0:	d117      	bne.n	c0d029f2 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d029c2:	8870      	ldrh	r0, [r6, #2]
c0d029c4:	2800      	cmp	r0, #0
c0d029c6:	d12d      	bne.n	c0d02a24 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d029c8:	4329      	orrs	r1, r5
c0d029ca:	2980      	cmp	r1, #128	; 0x80
c0d029cc:	d02a      	beq.n	c0d02a24 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d029ce:	4620      	mov	r0, r4
c0d029d0:	4629      	mov	r1, r5
c0d029d2:	f7ff fbcd 	bl	c0d02170 <USBD_LL_StallEP>
c0d029d6:	e025      	b.n	c0d02a24 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d029d8:	20fc      	movs	r0, #252	; 0xfc
c0d029da:	5c20      	ldrb	r0, [r4, r0]
c0d029dc:	2803      	cmp	r0, #3
c0d029de:	d02f      	beq.n	c0d02a40 <USBD_StdEPReq+0xc2>
c0d029e0:	2802      	cmp	r0, #2
c0d029e2:	d10e      	bne.n	c0d02a02 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d029e4:	0668      	lsls	r0, r5, #25
c0d029e6:	d109      	bne.n	c0d029fc <USBD_StdEPReq+0x7e>
c0d029e8:	e042      	b.n	c0d02a70 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d029ea:	20fc      	movs	r0, #252	; 0xfc
c0d029ec:	5c20      	ldrb	r0, [r4, r0]
c0d029ee:	2803      	cmp	r0, #3
c0d029f0:	d00f      	beq.n	c0d02a12 <USBD_StdEPReq+0x94>
c0d029f2:	2802      	cmp	r0, #2
c0d029f4:	d105      	bne.n	c0d02a02 <USBD_StdEPReq+0x84>
c0d029f6:	4329      	orrs	r1, r5
c0d029f8:	2980      	cmp	r1, #128	; 0x80
c0d029fa:	d039      	beq.n	c0d02a70 <USBD_StdEPReq+0xf2>
c0d029fc:	4620      	mov	r0, r4
c0d029fe:	4629      	mov	r1, r5
c0d02a00:	e004      	b.n	c0d02a0c <USBD_StdEPReq+0x8e>
c0d02a02:	4620      	mov	r0, r4
c0d02a04:	f7ff fbb4 	bl	c0d02170 <USBD_LL_StallEP>
c0d02a08:	2100      	movs	r1, #0
c0d02a0a:	4620      	mov	r0, r4
c0d02a0c:	f7ff fbb0 	bl	c0d02170 <USBD_LL_StallEP>
c0d02a10:	e02e      	b.n	c0d02a70 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02a12:	8870      	ldrh	r0, [r6, #2]
c0d02a14:	2800      	cmp	r0, #0
c0d02a16:	d12b      	bne.n	c0d02a70 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02a18:	0668      	lsls	r0, r5, #25
c0d02a1a:	d00d      	beq.n	c0d02a38 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02a1c:	4620      	mov	r0, r4
c0d02a1e:	4629      	mov	r1, r5
c0d02a20:	f7ff fbcc 	bl	c0d021bc <USBD_LL_ClearStallEP>
c0d02a24:	2045      	movs	r0, #69	; 0x45
c0d02a26:	0080      	lsls	r0, r0, #2
c0d02a28:	5820      	ldr	r0, [r4, r0]
c0d02a2a:	6880      	ldr	r0, [r0, #8]
c0d02a2c:	f7fe ff8a 	bl	c0d01944 <pic>
c0d02a30:	4602      	mov	r2, r0
c0d02a32:	4620      	mov	r0, r4
c0d02a34:	4631      	mov	r1, r6
c0d02a36:	4790      	blx	r2
c0d02a38:	4620      	mov	r0, r4
c0d02a3a:	f000 f983 	bl	c0d02d44 <USBD_CtlSendStatus>
c0d02a3e:	e017      	b.n	c0d02a70 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02a40:	4626      	mov	r6, r4
c0d02a42:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02a44:	4620      	mov	r0, r4
c0d02a46:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02a48:	420d      	tst	r5, r1
c0d02a4a:	d100      	bne.n	c0d02a4e <USBD_StdEPReq+0xd0>
c0d02a4c:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02a4e:	4620      	mov	r0, r4
c0d02a50:	4629      	mov	r1, r5
c0d02a52:	f7ff fbd9 	bl	c0d02208 <USBD_LL_IsStallEP>
c0d02a56:	2101      	movs	r1, #1
c0d02a58:	2800      	cmp	r0, #0
c0d02a5a:	d100      	bne.n	c0d02a5e <USBD_StdEPReq+0xe0>
c0d02a5c:	4601      	mov	r1, r0
c0d02a5e:	207f      	movs	r0, #127	; 0x7f
c0d02a60:	4005      	ands	r5, r0
c0d02a62:	0128      	lsls	r0, r5, #4
c0d02a64:	5031      	str	r1, [r6, r0]
c0d02a66:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02a68:	2202      	movs	r2, #2
c0d02a6a:	4620      	mov	r0, r4
c0d02a6c:	f000 f93c 	bl	c0d02ce8 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02a70:	2000      	movs	r0, #0
c0d02a72:	b001      	add	sp, #4
c0d02a74:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a76 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02a76:	780a      	ldrb	r2, [r1, #0]
c0d02a78:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02a7a:	784a      	ldrb	r2, [r1, #1]
c0d02a7c:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02a7e:	788a      	ldrb	r2, [r1, #2]
c0d02a80:	78cb      	ldrb	r3, [r1, #3]
c0d02a82:	021b      	lsls	r3, r3, #8
c0d02a84:	4313      	orrs	r3, r2
c0d02a86:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02a88:	790a      	ldrb	r2, [r1, #4]
c0d02a8a:	794b      	ldrb	r3, [r1, #5]
c0d02a8c:	021b      	lsls	r3, r3, #8
c0d02a8e:	4313      	orrs	r3, r2
c0d02a90:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02a92:	798a      	ldrb	r2, [r1, #6]
c0d02a94:	79c9      	ldrb	r1, [r1, #7]
c0d02a96:	0209      	lsls	r1, r1, #8
c0d02a98:	4311      	orrs	r1, r2
c0d02a9a:	80c1      	strh	r1, [r0, #6]

}
c0d02a9c:	4770      	bx	lr

c0d02a9e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02a9e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02aa0:	af03      	add	r7, sp, #12
c0d02aa2:	b083      	sub	sp, #12
c0d02aa4:	460d      	mov	r5, r1
c0d02aa6:	4604      	mov	r4, r0
c0d02aa8:	a802      	add	r0, sp, #8
c0d02aaa:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02aac:	8006      	strh	r6, [r0, #0]
c0d02aae:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02ab0:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02ab2:	7829      	ldrb	r1, [r5, #0]
c0d02ab4:	2060      	movs	r0, #96	; 0x60
c0d02ab6:	4008      	ands	r0, r1
c0d02ab8:	2800      	cmp	r0, #0
c0d02aba:	d010      	beq.n	c0d02ade <USBD_HID_Setup+0x40>
c0d02abc:	2820      	cmp	r0, #32
c0d02abe:	d139      	bne.n	c0d02b34 <USBD_HID_Setup+0x96>
c0d02ac0:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02ac2:	4601      	mov	r1, r0
c0d02ac4:	390a      	subs	r1, #10
c0d02ac6:	2902      	cmp	r1, #2
c0d02ac8:	d334      	bcc.n	c0d02b34 <USBD_HID_Setup+0x96>
c0d02aca:	2802      	cmp	r0, #2
c0d02acc:	d01c      	beq.n	c0d02b08 <USBD_HID_Setup+0x6a>
c0d02ace:	2803      	cmp	r0, #3
c0d02ad0:	d01a      	beq.n	c0d02b08 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02ad2:	4620      	mov	r0, r4
c0d02ad4:	4629      	mov	r1, r5
c0d02ad6:	f7ff ff1f 	bl	c0d02918 <USBD_CtlError>
c0d02ada:	2602      	movs	r6, #2
c0d02adc:	e02a      	b.n	c0d02b34 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02ade:	7868      	ldrb	r0, [r5, #1]
c0d02ae0:	280b      	cmp	r0, #11
c0d02ae2:	d014      	beq.n	c0d02b0e <USBD_HID_Setup+0x70>
c0d02ae4:	280a      	cmp	r0, #10
c0d02ae6:	d00f      	beq.n	c0d02b08 <USBD_HID_Setup+0x6a>
c0d02ae8:	2806      	cmp	r0, #6
c0d02aea:	d123      	bne.n	c0d02b34 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02aec:	8868      	ldrh	r0, [r5, #2]
c0d02aee:	0a00      	lsrs	r0, r0, #8
c0d02af0:	2600      	movs	r6, #0
c0d02af2:	2821      	cmp	r0, #33	; 0x21
c0d02af4:	d00f      	beq.n	c0d02b16 <USBD_HID_Setup+0x78>
c0d02af6:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02af8:	4632      	mov	r2, r6
c0d02afa:	4631      	mov	r1, r6
c0d02afc:	d117      	bne.n	c0d02b2e <USBD_HID_Setup+0x90>
c0d02afe:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02b00:	9000      	str	r0, [sp, #0]
c0d02b02:	f000 f847 	bl	c0d02b94 <USBD_HID_GetReportDescriptor_impl>
c0d02b06:	e00a      	b.n	c0d02b1e <USBD_HID_Setup+0x80>
c0d02b08:	a901      	add	r1, sp, #4
c0d02b0a:	2201      	movs	r2, #1
c0d02b0c:	e00f      	b.n	c0d02b2e <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02b0e:	4620      	mov	r0, r4
c0d02b10:	f000 f918 	bl	c0d02d44 <USBD_CtlSendStatus>
c0d02b14:	e00e      	b.n	c0d02b34 <USBD_HID_Setup+0x96>
c0d02b16:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02b18:	9000      	str	r0, [sp, #0]
c0d02b1a:	f000 f833 	bl	c0d02b84 <USBD_HID_GetHidDescriptor_impl>
c0d02b1e:	9b00      	ldr	r3, [sp, #0]
c0d02b20:	4601      	mov	r1, r0
c0d02b22:	881a      	ldrh	r2, [r3, #0]
c0d02b24:	88e8      	ldrh	r0, [r5, #6]
c0d02b26:	4282      	cmp	r2, r0
c0d02b28:	d300      	bcc.n	c0d02b2c <USBD_HID_Setup+0x8e>
c0d02b2a:	4602      	mov	r2, r0
c0d02b2c:	801a      	strh	r2, [r3, #0]
c0d02b2e:	4620      	mov	r0, r4
c0d02b30:	f000 f8da 	bl	c0d02ce8 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02b34:	b2f0      	uxtb	r0, r6
c0d02b36:	b003      	add	sp, #12
c0d02b38:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b3a <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02b3a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b3c:	af03      	add	r7, sp, #12
c0d02b3e:	b081      	sub	sp, #4
c0d02b40:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02b42:	2182      	movs	r1, #130	; 0x82
c0d02b44:	2502      	movs	r5, #2
c0d02b46:	2640      	movs	r6, #64	; 0x40
c0d02b48:	462a      	mov	r2, r5
c0d02b4a:	4633      	mov	r3, r6
c0d02b4c:	f7ff fad0 	bl	c0d020f0 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02b50:	4620      	mov	r0, r4
c0d02b52:	4629      	mov	r1, r5
c0d02b54:	462a      	mov	r2, r5
c0d02b56:	4633      	mov	r3, r6
c0d02b58:	f7ff faca 	bl	c0d020f0 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02b5c:	4620      	mov	r0, r4
c0d02b5e:	4629      	mov	r1, r5
c0d02b60:	4632      	mov	r2, r6
c0d02b62:	f7ff fb90 	bl	c0d02286 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02b66:	2000      	movs	r0, #0
c0d02b68:	b001      	add	sp, #4
c0d02b6a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b6c <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02b6c:	b5d0      	push	{r4, r6, r7, lr}
c0d02b6e:	af02      	add	r7, sp, #8
c0d02b70:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02b72:	2182      	movs	r1, #130	; 0x82
c0d02b74:	f7ff fae4 	bl	c0d02140 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02b78:	2102      	movs	r1, #2
c0d02b7a:	4620      	mov	r0, r4
c0d02b7c:	f7ff fae0 	bl	c0d02140 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02b80:	2000      	movs	r0, #0
c0d02b82:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b84 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02b84:	2109      	movs	r1, #9
c0d02b86:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02b88:	4801      	ldr	r0, [pc, #4]	; (c0d02b90 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02b8a:	4478      	add	r0, pc
c0d02b8c:	4770      	bx	lr
c0d02b8e:	46c0      	nop			; (mov r8, r8)
c0d02b90:	00000a82 	.word	0x00000a82

c0d02b94 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02b94:	2122      	movs	r1, #34	; 0x22
c0d02b96:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02b98:	4801      	ldr	r0, [pc, #4]	; (c0d02ba0 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02b9a:	4478      	add	r0, pc
c0d02b9c:	4770      	bx	lr
c0d02b9e:	46c0      	nop			; (mov r8, r8)
c0d02ba0:	00000a4d 	.word	0x00000a4d

c0d02ba4 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02ba4:	b5b0      	push	{r4, r5, r7, lr}
c0d02ba6:	af02      	add	r7, sp, #8
c0d02ba8:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02baa:	2102      	movs	r1, #2
c0d02bac:	2240      	movs	r2, #64	; 0x40
c0d02bae:	f7ff fb6a 	bl	c0d02286 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02bb2:	4d0d      	ldr	r5, [pc, #52]	; (c0d02be8 <USBD_HID_DataOut_impl+0x44>)
c0d02bb4:	7828      	ldrb	r0, [r5, #0]
c0d02bb6:	2800      	cmp	r0, #0
c0d02bb8:	d113      	bne.n	c0d02be2 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02bba:	2002      	movs	r0, #2
c0d02bbc:	f7fe f928 	bl	c0d00e10 <io_seproxyhal_get_ep_rx_size>
c0d02bc0:	4602      	mov	r2, r0
c0d02bc2:	480d      	ldr	r0, [pc, #52]	; (c0d02bf8 <USBD_HID_DataOut_impl+0x54>)
c0d02bc4:	4478      	add	r0, pc
c0d02bc6:	4621      	mov	r1, r4
c0d02bc8:	f7fd ff86 	bl	c0d00ad8 <io_usb_hid_receive>
c0d02bcc:	2802      	cmp	r0, #2
c0d02bce:	d108      	bne.n	c0d02be2 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02bd0:	2001      	movs	r0, #1
c0d02bd2:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02bd4:	4805      	ldr	r0, [pc, #20]	; (c0d02bec <USBD_HID_DataOut_impl+0x48>)
c0d02bd6:	2107      	movs	r1, #7
c0d02bd8:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02bda:	4805      	ldr	r0, [pc, #20]	; (c0d02bf0 <USBD_HID_DataOut_impl+0x4c>)
c0d02bdc:	6800      	ldr	r0, [r0, #0]
c0d02bde:	4905      	ldr	r1, [pc, #20]	; (c0d02bf4 <USBD_HID_DataOut_impl+0x50>)
c0d02be0:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02be2:	2000      	movs	r0, #0
c0d02be4:	bdb0      	pop	{r4, r5, r7, pc}
c0d02be6:	46c0      	nop			; (mov r8, r8)
c0d02be8:	20001d10 	.word	0x20001d10
c0d02bec:	20001d18 	.word	0x20001d18
c0d02bf0:	20001c00 	.word	0x20001c00
c0d02bf4:	20001d1c 	.word	0x20001d1c
c0d02bf8:	ffffe3a1 	.word	0xffffe3a1

c0d02bfc <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02bfc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02bfe:	af03      	add	r7, sp, #12
c0d02c00:	b081      	sub	sp, #4
c0d02c02:	4604      	mov	r4, r0
c0d02c04:	2049      	movs	r0, #73	; 0x49
c0d02c06:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02c08:	4810      	ldr	r0, [pc, #64]	; (c0d02c4c <USB_power+0x50>)
c0d02c0a:	2100      	movs	r1, #0
c0d02c0c:	462a      	mov	r2, r5
c0d02c0e:	f7fe f80f 	bl	c0d00c30 <os_memset>

  if (enabled) {
c0d02c12:	2c00      	cmp	r4, #0
c0d02c14:	d015      	beq.n	c0d02c42 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02c16:	4c0d      	ldr	r4, [pc, #52]	; (c0d02c4c <USB_power+0x50>)
c0d02c18:	2600      	movs	r6, #0
c0d02c1a:	4620      	mov	r0, r4
c0d02c1c:	4631      	mov	r1, r6
c0d02c1e:	462a      	mov	r2, r5
c0d02c20:	f7fe f806 	bl	c0d00c30 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02c24:	490a      	ldr	r1, [pc, #40]	; (c0d02c50 <USB_power+0x54>)
c0d02c26:	4479      	add	r1, pc
c0d02c28:	4620      	mov	r0, r4
c0d02c2a:	4632      	mov	r2, r6
c0d02c2c:	f7ff fb3f 	bl	c0d022ae <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02c30:	4908      	ldr	r1, [pc, #32]	; (c0d02c54 <USB_power+0x58>)
c0d02c32:	4479      	add	r1, pc
c0d02c34:	4620      	mov	r0, r4
c0d02c36:	f7ff fb72 	bl	c0d0231e <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02c3a:	4620      	mov	r0, r4
c0d02c3c:	f7ff fb78 	bl	c0d02330 <USBD_Start>
c0d02c40:	e002      	b.n	c0d02c48 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02c42:	4802      	ldr	r0, [pc, #8]	; (c0d02c4c <USB_power+0x50>)
c0d02c44:	f7ff fb51 	bl	c0d022ea <USBD_DeInit>
  }
}
c0d02c48:	b001      	add	sp, #4
c0d02c4a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02c4c:	20001d34 	.word	0x20001d34
c0d02c50:	00000a02 	.word	0x00000a02
c0d02c54:	00000a32 	.word	0x00000a32

c0d02c58 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02c58:	2012      	movs	r0, #18
c0d02c5a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02c5c:	4801      	ldr	r0, [pc, #4]	; (c0d02c64 <USBD_DeviceDescriptor+0xc>)
c0d02c5e:	4478      	add	r0, pc
c0d02c60:	4770      	bx	lr
c0d02c62:	46c0      	nop			; (mov r8, r8)
c0d02c64:	000009b7 	.word	0x000009b7

c0d02c68 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02c68:	2004      	movs	r0, #4
c0d02c6a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02c6c:	4801      	ldr	r0, [pc, #4]	; (c0d02c74 <USBD_LangIDStrDescriptor+0xc>)
c0d02c6e:	4478      	add	r0, pc
c0d02c70:	4770      	bx	lr
c0d02c72:	46c0      	nop			; (mov r8, r8)
c0d02c74:	000009da 	.word	0x000009da

c0d02c78 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02c78:	200e      	movs	r0, #14
c0d02c7a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02c7c:	4801      	ldr	r0, [pc, #4]	; (c0d02c84 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02c7e:	4478      	add	r0, pc
c0d02c80:	4770      	bx	lr
c0d02c82:	46c0      	nop			; (mov r8, r8)
c0d02c84:	000009ce 	.word	0x000009ce

c0d02c88 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02c88:	200e      	movs	r0, #14
c0d02c8a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02c8c:	4801      	ldr	r0, [pc, #4]	; (c0d02c94 <USBD_ProductStrDescriptor+0xc>)
c0d02c8e:	4478      	add	r0, pc
c0d02c90:	4770      	bx	lr
c0d02c92:	46c0      	nop			; (mov r8, r8)
c0d02c94:	0000094b 	.word	0x0000094b

c0d02c98 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02c98:	200a      	movs	r0, #10
c0d02c9a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02c9c:	4801      	ldr	r0, [pc, #4]	; (c0d02ca4 <USBD_SerialStrDescriptor+0xc>)
c0d02c9e:	4478      	add	r0, pc
c0d02ca0:	4770      	bx	lr
c0d02ca2:	46c0      	nop			; (mov r8, r8)
c0d02ca4:	000009bc 	.word	0x000009bc

c0d02ca8 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02ca8:	200e      	movs	r0, #14
c0d02caa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02cac:	4801      	ldr	r0, [pc, #4]	; (c0d02cb4 <USBD_ConfigStrDescriptor+0xc>)
c0d02cae:	4478      	add	r0, pc
c0d02cb0:	4770      	bx	lr
c0d02cb2:	46c0      	nop			; (mov r8, r8)
c0d02cb4:	0000092b 	.word	0x0000092b

c0d02cb8 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02cb8:	200e      	movs	r0, #14
c0d02cba:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02cbc:	4801      	ldr	r0, [pc, #4]	; (c0d02cc4 <USBD_InterfaceStrDescriptor+0xc>)
c0d02cbe:	4478      	add	r0, pc
c0d02cc0:	4770      	bx	lr
c0d02cc2:	46c0      	nop			; (mov r8, r8)
c0d02cc4:	0000091b 	.word	0x0000091b

c0d02cc8 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02cc8:	2129      	movs	r1, #41	; 0x29
c0d02cca:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02ccc:	4801      	ldr	r0, [pc, #4]	; (c0d02cd4 <USBD_GetCfgDesc_impl+0xc>)
c0d02cce:	4478      	add	r0, pc
c0d02cd0:	4770      	bx	lr
c0d02cd2:	46c0      	nop			; (mov r8, r8)
c0d02cd4:	000009ce 	.word	0x000009ce

c0d02cd8 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02cd8:	210a      	movs	r1, #10
c0d02cda:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02cdc:	4801      	ldr	r0, [pc, #4]	; (c0d02ce4 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02cde:	4478      	add	r0, pc
c0d02ce0:	4770      	bx	lr
c0d02ce2:	46c0      	nop			; (mov r8, r8)
c0d02ce4:	000009ea 	.word	0x000009ea

c0d02ce8 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02ce8:	b5b0      	push	{r4, r5, r7, lr}
c0d02cea:	af02      	add	r7, sp, #8
c0d02cec:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02cee:	21f4      	movs	r1, #244	; 0xf4
c0d02cf0:	2302      	movs	r3, #2
c0d02cf2:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02cf4:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02cf6:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02cf8:	2109      	movs	r1, #9
c0d02cfa:	0149      	lsls	r1, r1, #5
c0d02cfc:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02cfe:	6a01      	ldr	r1, [r0, #32]
c0d02d00:	428a      	cmp	r2, r1
c0d02d02:	d300      	bcc.n	c0d02d06 <USBD_CtlSendData+0x1e>
c0d02d04:	460a      	mov	r2, r1
c0d02d06:	b293      	uxth	r3, r2
c0d02d08:	2500      	movs	r5, #0
c0d02d0a:	4629      	mov	r1, r5
c0d02d0c:	4622      	mov	r2, r4
c0d02d0e:	f7ff faa0 	bl	c0d02252 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02d12:	4628      	mov	r0, r5
c0d02d14:	bdb0      	pop	{r4, r5, r7, pc}

c0d02d16 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02d16:	b5b0      	push	{r4, r5, r7, lr}
c0d02d18:	af02      	add	r7, sp, #8
c0d02d1a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02d1c:	6a01      	ldr	r1, [r0, #32]
c0d02d1e:	428a      	cmp	r2, r1
c0d02d20:	d300      	bcc.n	c0d02d24 <USBD_CtlContinueSendData+0xe>
c0d02d22:	460a      	mov	r2, r1
c0d02d24:	b293      	uxth	r3, r2
c0d02d26:	2500      	movs	r5, #0
c0d02d28:	4629      	mov	r1, r5
c0d02d2a:	4622      	mov	r2, r4
c0d02d2c:	f7ff fa91 	bl	c0d02252 <USBD_LL_Transmit>
  return USBD_OK;
c0d02d30:	4628      	mov	r0, r5
c0d02d32:	bdb0      	pop	{r4, r5, r7, pc}

c0d02d34 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02d34:	b5d0      	push	{r4, r6, r7, lr}
c0d02d36:	af02      	add	r7, sp, #8
c0d02d38:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02d3a:	4621      	mov	r1, r4
c0d02d3c:	f7ff faa3 	bl	c0d02286 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02d40:	4620      	mov	r0, r4
c0d02d42:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d44 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02d44:	b5d0      	push	{r4, r6, r7, lr}
c0d02d46:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02d48:	21f4      	movs	r1, #244	; 0xf4
c0d02d4a:	2204      	movs	r2, #4
c0d02d4c:	5042      	str	r2, [r0, r1]
c0d02d4e:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02d50:	4621      	mov	r1, r4
c0d02d52:	4622      	mov	r2, r4
c0d02d54:	4623      	mov	r3, r4
c0d02d56:	f7ff fa7c 	bl	c0d02252 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02d5a:	4620      	mov	r0, r4
c0d02d5c:	bdd0      	pop	{r4, r6, r7, pc}

c0d02d5e <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02d5e:	b5d0      	push	{r4, r6, r7, lr}
c0d02d60:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02d62:	21f4      	movs	r1, #244	; 0xf4
c0d02d64:	2205      	movs	r2, #5
c0d02d66:	5042      	str	r2, [r0, r1]
c0d02d68:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02d6a:	4621      	mov	r1, r4
c0d02d6c:	4622      	mov	r2, r4
c0d02d6e:	f7ff fa8a 	bl	c0d02286 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02d72:	4620      	mov	r0, r4
c0d02d74:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d78 <__aeabi_uidiv>:
c0d02d78:	2200      	movs	r2, #0
c0d02d7a:	0843      	lsrs	r3, r0, #1
c0d02d7c:	428b      	cmp	r3, r1
c0d02d7e:	d374      	bcc.n	c0d02e6a <__aeabi_uidiv+0xf2>
c0d02d80:	0903      	lsrs	r3, r0, #4
c0d02d82:	428b      	cmp	r3, r1
c0d02d84:	d35f      	bcc.n	c0d02e46 <__aeabi_uidiv+0xce>
c0d02d86:	0a03      	lsrs	r3, r0, #8
c0d02d88:	428b      	cmp	r3, r1
c0d02d8a:	d344      	bcc.n	c0d02e16 <__aeabi_uidiv+0x9e>
c0d02d8c:	0b03      	lsrs	r3, r0, #12
c0d02d8e:	428b      	cmp	r3, r1
c0d02d90:	d328      	bcc.n	c0d02de4 <__aeabi_uidiv+0x6c>
c0d02d92:	0c03      	lsrs	r3, r0, #16
c0d02d94:	428b      	cmp	r3, r1
c0d02d96:	d30d      	bcc.n	c0d02db4 <__aeabi_uidiv+0x3c>
c0d02d98:	22ff      	movs	r2, #255	; 0xff
c0d02d9a:	0209      	lsls	r1, r1, #8
c0d02d9c:	ba12      	rev	r2, r2
c0d02d9e:	0c03      	lsrs	r3, r0, #16
c0d02da0:	428b      	cmp	r3, r1
c0d02da2:	d302      	bcc.n	c0d02daa <__aeabi_uidiv+0x32>
c0d02da4:	1212      	asrs	r2, r2, #8
c0d02da6:	0209      	lsls	r1, r1, #8
c0d02da8:	d065      	beq.n	c0d02e76 <__aeabi_uidiv+0xfe>
c0d02daa:	0b03      	lsrs	r3, r0, #12
c0d02dac:	428b      	cmp	r3, r1
c0d02dae:	d319      	bcc.n	c0d02de4 <__aeabi_uidiv+0x6c>
c0d02db0:	e000      	b.n	c0d02db4 <__aeabi_uidiv+0x3c>
c0d02db2:	0a09      	lsrs	r1, r1, #8
c0d02db4:	0bc3      	lsrs	r3, r0, #15
c0d02db6:	428b      	cmp	r3, r1
c0d02db8:	d301      	bcc.n	c0d02dbe <__aeabi_uidiv+0x46>
c0d02dba:	03cb      	lsls	r3, r1, #15
c0d02dbc:	1ac0      	subs	r0, r0, r3
c0d02dbe:	4152      	adcs	r2, r2
c0d02dc0:	0b83      	lsrs	r3, r0, #14
c0d02dc2:	428b      	cmp	r3, r1
c0d02dc4:	d301      	bcc.n	c0d02dca <__aeabi_uidiv+0x52>
c0d02dc6:	038b      	lsls	r3, r1, #14
c0d02dc8:	1ac0      	subs	r0, r0, r3
c0d02dca:	4152      	adcs	r2, r2
c0d02dcc:	0b43      	lsrs	r3, r0, #13
c0d02dce:	428b      	cmp	r3, r1
c0d02dd0:	d301      	bcc.n	c0d02dd6 <__aeabi_uidiv+0x5e>
c0d02dd2:	034b      	lsls	r3, r1, #13
c0d02dd4:	1ac0      	subs	r0, r0, r3
c0d02dd6:	4152      	adcs	r2, r2
c0d02dd8:	0b03      	lsrs	r3, r0, #12
c0d02dda:	428b      	cmp	r3, r1
c0d02ddc:	d301      	bcc.n	c0d02de2 <__aeabi_uidiv+0x6a>
c0d02dde:	030b      	lsls	r3, r1, #12
c0d02de0:	1ac0      	subs	r0, r0, r3
c0d02de2:	4152      	adcs	r2, r2
c0d02de4:	0ac3      	lsrs	r3, r0, #11
c0d02de6:	428b      	cmp	r3, r1
c0d02de8:	d301      	bcc.n	c0d02dee <__aeabi_uidiv+0x76>
c0d02dea:	02cb      	lsls	r3, r1, #11
c0d02dec:	1ac0      	subs	r0, r0, r3
c0d02dee:	4152      	adcs	r2, r2
c0d02df0:	0a83      	lsrs	r3, r0, #10
c0d02df2:	428b      	cmp	r3, r1
c0d02df4:	d301      	bcc.n	c0d02dfa <__aeabi_uidiv+0x82>
c0d02df6:	028b      	lsls	r3, r1, #10
c0d02df8:	1ac0      	subs	r0, r0, r3
c0d02dfa:	4152      	adcs	r2, r2
c0d02dfc:	0a43      	lsrs	r3, r0, #9
c0d02dfe:	428b      	cmp	r3, r1
c0d02e00:	d301      	bcc.n	c0d02e06 <__aeabi_uidiv+0x8e>
c0d02e02:	024b      	lsls	r3, r1, #9
c0d02e04:	1ac0      	subs	r0, r0, r3
c0d02e06:	4152      	adcs	r2, r2
c0d02e08:	0a03      	lsrs	r3, r0, #8
c0d02e0a:	428b      	cmp	r3, r1
c0d02e0c:	d301      	bcc.n	c0d02e12 <__aeabi_uidiv+0x9a>
c0d02e0e:	020b      	lsls	r3, r1, #8
c0d02e10:	1ac0      	subs	r0, r0, r3
c0d02e12:	4152      	adcs	r2, r2
c0d02e14:	d2cd      	bcs.n	c0d02db2 <__aeabi_uidiv+0x3a>
c0d02e16:	09c3      	lsrs	r3, r0, #7
c0d02e18:	428b      	cmp	r3, r1
c0d02e1a:	d301      	bcc.n	c0d02e20 <__aeabi_uidiv+0xa8>
c0d02e1c:	01cb      	lsls	r3, r1, #7
c0d02e1e:	1ac0      	subs	r0, r0, r3
c0d02e20:	4152      	adcs	r2, r2
c0d02e22:	0983      	lsrs	r3, r0, #6
c0d02e24:	428b      	cmp	r3, r1
c0d02e26:	d301      	bcc.n	c0d02e2c <__aeabi_uidiv+0xb4>
c0d02e28:	018b      	lsls	r3, r1, #6
c0d02e2a:	1ac0      	subs	r0, r0, r3
c0d02e2c:	4152      	adcs	r2, r2
c0d02e2e:	0943      	lsrs	r3, r0, #5
c0d02e30:	428b      	cmp	r3, r1
c0d02e32:	d301      	bcc.n	c0d02e38 <__aeabi_uidiv+0xc0>
c0d02e34:	014b      	lsls	r3, r1, #5
c0d02e36:	1ac0      	subs	r0, r0, r3
c0d02e38:	4152      	adcs	r2, r2
c0d02e3a:	0903      	lsrs	r3, r0, #4
c0d02e3c:	428b      	cmp	r3, r1
c0d02e3e:	d301      	bcc.n	c0d02e44 <__aeabi_uidiv+0xcc>
c0d02e40:	010b      	lsls	r3, r1, #4
c0d02e42:	1ac0      	subs	r0, r0, r3
c0d02e44:	4152      	adcs	r2, r2
c0d02e46:	08c3      	lsrs	r3, r0, #3
c0d02e48:	428b      	cmp	r3, r1
c0d02e4a:	d301      	bcc.n	c0d02e50 <__aeabi_uidiv+0xd8>
c0d02e4c:	00cb      	lsls	r3, r1, #3
c0d02e4e:	1ac0      	subs	r0, r0, r3
c0d02e50:	4152      	adcs	r2, r2
c0d02e52:	0883      	lsrs	r3, r0, #2
c0d02e54:	428b      	cmp	r3, r1
c0d02e56:	d301      	bcc.n	c0d02e5c <__aeabi_uidiv+0xe4>
c0d02e58:	008b      	lsls	r3, r1, #2
c0d02e5a:	1ac0      	subs	r0, r0, r3
c0d02e5c:	4152      	adcs	r2, r2
c0d02e5e:	0843      	lsrs	r3, r0, #1
c0d02e60:	428b      	cmp	r3, r1
c0d02e62:	d301      	bcc.n	c0d02e68 <__aeabi_uidiv+0xf0>
c0d02e64:	004b      	lsls	r3, r1, #1
c0d02e66:	1ac0      	subs	r0, r0, r3
c0d02e68:	4152      	adcs	r2, r2
c0d02e6a:	1a41      	subs	r1, r0, r1
c0d02e6c:	d200      	bcs.n	c0d02e70 <__aeabi_uidiv+0xf8>
c0d02e6e:	4601      	mov	r1, r0
c0d02e70:	4152      	adcs	r2, r2
c0d02e72:	4610      	mov	r0, r2
c0d02e74:	4770      	bx	lr
c0d02e76:	e7ff      	b.n	c0d02e78 <__aeabi_uidiv+0x100>
c0d02e78:	b501      	push	{r0, lr}
c0d02e7a:	2000      	movs	r0, #0
c0d02e7c:	f000 f8f0 	bl	c0d03060 <__aeabi_idiv0>
c0d02e80:	bd02      	pop	{r1, pc}
c0d02e82:	46c0      	nop			; (mov r8, r8)

c0d02e84 <__aeabi_uidivmod>:
c0d02e84:	2900      	cmp	r1, #0
c0d02e86:	d0f7      	beq.n	c0d02e78 <__aeabi_uidiv+0x100>
c0d02e88:	e776      	b.n	c0d02d78 <__aeabi_uidiv>
c0d02e8a:	4770      	bx	lr

c0d02e8c <__aeabi_idiv>:
c0d02e8c:	4603      	mov	r3, r0
c0d02e8e:	430b      	orrs	r3, r1
c0d02e90:	d47f      	bmi.n	c0d02f92 <__aeabi_idiv+0x106>
c0d02e92:	2200      	movs	r2, #0
c0d02e94:	0843      	lsrs	r3, r0, #1
c0d02e96:	428b      	cmp	r3, r1
c0d02e98:	d374      	bcc.n	c0d02f84 <__aeabi_idiv+0xf8>
c0d02e9a:	0903      	lsrs	r3, r0, #4
c0d02e9c:	428b      	cmp	r3, r1
c0d02e9e:	d35f      	bcc.n	c0d02f60 <__aeabi_idiv+0xd4>
c0d02ea0:	0a03      	lsrs	r3, r0, #8
c0d02ea2:	428b      	cmp	r3, r1
c0d02ea4:	d344      	bcc.n	c0d02f30 <__aeabi_idiv+0xa4>
c0d02ea6:	0b03      	lsrs	r3, r0, #12
c0d02ea8:	428b      	cmp	r3, r1
c0d02eaa:	d328      	bcc.n	c0d02efe <__aeabi_idiv+0x72>
c0d02eac:	0c03      	lsrs	r3, r0, #16
c0d02eae:	428b      	cmp	r3, r1
c0d02eb0:	d30d      	bcc.n	c0d02ece <__aeabi_idiv+0x42>
c0d02eb2:	22ff      	movs	r2, #255	; 0xff
c0d02eb4:	0209      	lsls	r1, r1, #8
c0d02eb6:	ba12      	rev	r2, r2
c0d02eb8:	0c03      	lsrs	r3, r0, #16
c0d02eba:	428b      	cmp	r3, r1
c0d02ebc:	d302      	bcc.n	c0d02ec4 <__aeabi_idiv+0x38>
c0d02ebe:	1212      	asrs	r2, r2, #8
c0d02ec0:	0209      	lsls	r1, r1, #8
c0d02ec2:	d065      	beq.n	c0d02f90 <__aeabi_idiv+0x104>
c0d02ec4:	0b03      	lsrs	r3, r0, #12
c0d02ec6:	428b      	cmp	r3, r1
c0d02ec8:	d319      	bcc.n	c0d02efe <__aeabi_idiv+0x72>
c0d02eca:	e000      	b.n	c0d02ece <__aeabi_idiv+0x42>
c0d02ecc:	0a09      	lsrs	r1, r1, #8
c0d02ece:	0bc3      	lsrs	r3, r0, #15
c0d02ed0:	428b      	cmp	r3, r1
c0d02ed2:	d301      	bcc.n	c0d02ed8 <__aeabi_idiv+0x4c>
c0d02ed4:	03cb      	lsls	r3, r1, #15
c0d02ed6:	1ac0      	subs	r0, r0, r3
c0d02ed8:	4152      	adcs	r2, r2
c0d02eda:	0b83      	lsrs	r3, r0, #14
c0d02edc:	428b      	cmp	r3, r1
c0d02ede:	d301      	bcc.n	c0d02ee4 <__aeabi_idiv+0x58>
c0d02ee0:	038b      	lsls	r3, r1, #14
c0d02ee2:	1ac0      	subs	r0, r0, r3
c0d02ee4:	4152      	adcs	r2, r2
c0d02ee6:	0b43      	lsrs	r3, r0, #13
c0d02ee8:	428b      	cmp	r3, r1
c0d02eea:	d301      	bcc.n	c0d02ef0 <__aeabi_idiv+0x64>
c0d02eec:	034b      	lsls	r3, r1, #13
c0d02eee:	1ac0      	subs	r0, r0, r3
c0d02ef0:	4152      	adcs	r2, r2
c0d02ef2:	0b03      	lsrs	r3, r0, #12
c0d02ef4:	428b      	cmp	r3, r1
c0d02ef6:	d301      	bcc.n	c0d02efc <__aeabi_idiv+0x70>
c0d02ef8:	030b      	lsls	r3, r1, #12
c0d02efa:	1ac0      	subs	r0, r0, r3
c0d02efc:	4152      	adcs	r2, r2
c0d02efe:	0ac3      	lsrs	r3, r0, #11
c0d02f00:	428b      	cmp	r3, r1
c0d02f02:	d301      	bcc.n	c0d02f08 <__aeabi_idiv+0x7c>
c0d02f04:	02cb      	lsls	r3, r1, #11
c0d02f06:	1ac0      	subs	r0, r0, r3
c0d02f08:	4152      	adcs	r2, r2
c0d02f0a:	0a83      	lsrs	r3, r0, #10
c0d02f0c:	428b      	cmp	r3, r1
c0d02f0e:	d301      	bcc.n	c0d02f14 <__aeabi_idiv+0x88>
c0d02f10:	028b      	lsls	r3, r1, #10
c0d02f12:	1ac0      	subs	r0, r0, r3
c0d02f14:	4152      	adcs	r2, r2
c0d02f16:	0a43      	lsrs	r3, r0, #9
c0d02f18:	428b      	cmp	r3, r1
c0d02f1a:	d301      	bcc.n	c0d02f20 <__aeabi_idiv+0x94>
c0d02f1c:	024b      	lsls	r3, r1, #9
c0d02f1e:	1ac0      	subs	r0, r0, r3
c0d02f20:	4152      	adcs	r2, r2
c0d02f22:	0a03      	lsrs	r3, r0, #8
c0d02f24:	428b      	cmp	r3, r1
c0d02f26:	d301      	bcc.n	c0d02f2c <__aeabi_idiv+0xa0>
c0d02f28:	020b      	lsls	r3, r1, #8
c0d02f2a:	1ac0      	subs	r0, r0, r3
c0d02f2c:	4152      	adcs	r2, r2
c0d02f2e:	d2cd      	bcs.n	c0d02ecc <__aeabi_idiv+0x40>
c0d02f30:	09c3      	lsrs	r3, r0, #7
c0d02f32:	428b      	cmp	r3, r1
c0d02f34:	d301      	bcc.n	c0d02f3a <__aeabi_idiv+0xae>
c0d02f36:	01cb      	lsls	r3, r1, #7
c0d02f38:	1ac0      	subs	r0, r0, r3
c0d02f3a:	4152      	adcs	r2, r2
c0d02f3c:	0983      	lsrs	r3, r0, #6
c0d02f3e:	428b      	cmp	r3, r1
c0d02f40:	d301      	bcc.n	c0d02f46 <__aeabi_idiv+0xba>
c0d02f42:	018b      	lsls	r3, r1, #6
c0d02f44:	1ac0      	subs	r0, r0, r3
c0d02f46:	4152      	adcs	r2, r2
c0d02f48:	0943      	lsrs	r3, r0, #5
c0d02f4a:	428b      	cmp	r3, r1
c0d02f4c:	d301      	bcc.n	c0d02f52 <__aeabi_idiv+0xc6>
c0d02f4e:	014b      	lsls	r3, r1, #5
c0d02f50:	1ac0      	subs	r0, r0, r3
c0d02f52:	4152      	adcs	r2, r2
c0d02f54:	0903      	lsrs	r3, r0, #4
c0d02f56:	428b      	cmp	r3, r1
c0d02f58:	d301      	bcc.n	c0d02f5e <__aeabi_idiv+0xd2>
c0d02f5a:	010b      	lsls	r3, r1, #4
c0d02f5c:	1ac0      	subs	r0, r0, r3
c0d02f5e:	4152      	adcs	r2, r2
c0d02f60:	08c3      	lsrs	r3, r0, #3
c0d02f62:	428b      	cmp	r3, r1
c0d02f64:	d301      	bcc.n	c0d02f6a <__aeabi_idiv+0xde>
c0d02f66:	00cb      	lsls	r3, r1, #3
c0d02f68:	1ac0      	subs	r0, r0, r3
c0d02f6a:	4152      	adcs	r2, r2
c0d02f6c:	0883      	lsrs	r3, r0, #2
c0d02f6e:	428b      	cmp	r3, r1
c0d02f70:	d301      	bcc.n	c0d02f76 <__aeabi_idiv+0xea>
c0d02f72:	008b      	lsls	r3, r1, #2
c0d02f74:	1ac0      	subs	r0, r0, r3
c0d02f76:	4152      	adcs	r2, r2
c0d02f78:	0843      	lsrs	r3, r0, #1
c0d02f7a:	428b      	cmp	r3, r1
c0d02f7c:	d301      	bcc.n	c0d02f82 <__aeabi_idiv+0xf6>
c0d02f7e:	004b      	lsls	r3, r1, #1
c0d02f80:	1ac0      	subs	r0, r0, r3
c0d02f82:	4152      	adcs	r2, r2
c0d02f84:	1a41      	subs	r1, r0, r1
c0d02f86:	d200      	bcs.n	c0d02f8a <__aeabi_idiv+0xfe>
c0d02f88:	4601      	mov	r1, r0
c0d02f8a:	4152      	adcs	r2, r2
c0d02f8c:	4610      	mov	r0, r2
c0d02f8e:	4770      	bx	lr
c0d02f90:	e05d      	b.n	c0d0304e <__aeabi_idiv+0x1c2>
c0d02f92:	0fca      	lsrs	r2, r1, #31
c0d02f94:	d000      	beq.n	c0d02f98 <__aeabi_idiv+0x10c>
c0d02f96:	4249      	negs	r1, r1
c0d02f98:	1003      	asrs	r3, r0, #32
c0d02f9a:	d300      	bcc.n	c0d02f9e <__aeabi_idiv+0x112>
c0d02f9c:	4240      	negs	r0, r0
c0d02f9e:	4053      	eors	r3, r2
c0d02fa0:	2200      	movs	r2, #0
c0d02fa2:	469c      	mov	ip, r3
c0d02fa4:	0903      	lsrs	r3, r0, #4
c0d02fa6:	428b      	cmp	r3, r1
c0d02fa8:	d32d      	bcc.n	c0d03006 <__aeabi_idiv+0x17a>
c0d02faa:	0a03      	lsrs	r3, r0, #8
c0d02fac:	428b      	cmp	r3, r1
c0d02fae:	d312      	bcc.n	c0d02fd6 <__aeabi_idiv+0x14a>
c0d02fb0:	22fc      	movs	r2, #252	; 0xfc
c0d02fb2:	0189      	lsls	r1, r1, #6
c0d02fb4:	ba12      	rev	r2, r2
c0d02fb6:	0a03      	lsrs	r3, r0, #8
c0d02fb8:	428b      	cmp	r3, r1
c0d02fba:	d30c      	bcc.n	c0d02fd6 <__aeabi_idiv+0x14a>
c0d02fbc:	0189      	lsls	r1, r1, #6
c0d02fbe:	1192      	asrs	r2, r2, #6
c0d02fc0:	428b      	cmp	r3, r1
c0d02fc2:	d308      	bcc.n	c0d02fd6 <__aeabi_idiv+0x14a>
c0d02fc4:	0189      	lsls	r1, r1, #6
c0d02fc6:	1192      	asrs	r2, r2, #6
c0d02fc8:	428b      	cmp	r3, r1
c0d02fca:	d304      	bcc.n	c0d02fd6 <__aeabi_idiv+0x14a>
c0d02fcc:	0189      	lsls	r1, r1, #6
c0d02fce:	d03a      	beq.n	c0d03046 <__aeabi_idiv+0x1ba>
c0d02fd0:	1192      	asrs	r2, r2, #6
c0d02fd2:	e000      	b.n	c0d02fd6 <__aeabi_idiv+0x14a>
c0d02fd4:	0989      	lsrs	r1, r1, #6
c0d02fd6:	09c3      	lsrs	r3, r0, #7
c0d02fd8:	428b      	cmp	r3, r1
c0d02fda:	d301      	bcc.n	c0d02fe0 <__aeabi_idiv+0x154>
c0d02fdc:	01cb      	lsls	r3, r1, #7
c0d02fde:	1ac0      	subs	r0, r0, r3
c0d02fe0:	4152      	adcs	r2, r2
c0d02fe2:	0983      	lsrs	r3, r0, #6
c0d02fe4:	428b      	cmp	r3, r1
c0d02fe6:	d301      	bcc.n	c0d02fec <__aeabi_idiv+0x160>
c0d02fe8:	018b      	lsls	r3, r1, #6
c0d02fea:	1ac0      	subs	r0, r0, r3
c0d02fec:	4152      	adcs	r2, r2
c0d02fee:	0943      	lsrs	r3, r0, #5
c0d02ff0:	428b      	cmp	r3, r1
c0d02ff2:	d301      	bcc.n	c0d02ff8 <__aeabi_idiv+0x16c>
c0d02ff4:	014b      	lsls	r3, r1, #5
c0d02ff6:	1ac0      	subs	r0, r0, r3
c0d02ff8:	4152      	adcs	r2, r2
c0d02ffa:	0903      	lsrs	r3, r0, #4
c0d02ffc:	428b      	cmp	r3, r1
c0d02ffe:	d301      	bcc.n	c0d03004 <__aeabi_idiv+0x178>
c0d03000:	010b      	lsls	r3, r1, #4
c0d03002:	1ac0      	subs	r0, r0, r3
c0d03004:	4152      	adcs	r2, r2
c0d03006:	08c3      	lsrs	r3, r0, #3
c0d03008:	428b      	cmp	r3, r1
c0d0300a:	d301      	bcc.n	c0d03010 <__aeabi_idiv+0x184>
c0d0300c:	00cb      	lsls	r3, r1, #3
c0d0300e:	1ac0      	subs	r0, r0, r3
c0d03010:	4152      	adcs	r2, r2
c0d03012:	0883      	lsrs	r3, r0, #2
c0d03014:	428b      	cmp	r3, r1
c0d03016:	d301      	bcc.n	c0d0301c <__aeabi_idiv+0x190>
c0d03018:	008b      	lsls	r3, r1, #2
c0d0301a:	1ac0      	subs	r0, r0, r3
c0d0301c:	4152      	adcs	r2, r2
c0d0301e:	d2d9      	bcs.n	c0d02fd4 <__aeabi_idiv+0x148>
c0d03020:	0843      	lsrs	r3, r0, #1
c0d03022:	428b      	cmp	r3, r1
c0d03024:	d301      	bcc.n	c0d0302a <__aeabi_idiv+0x19e>
c0d03026:	004b      	lsls	r3, r1, #1
c0d03028:	1ac0      	subs	r0, r0, r3
c0d0302a:	4152      	adcs	r2, r2
c0d0302c:	1a41      	subs	r1, r0, r1
c0d0302e:	d200      	bcs.n	c0d03032 <__aeabi_idiv+0x1a6>
c0d03030:	4601      	mov	r1, r0
c0d03032:	4663      	mov	r3, ip
c0d03034:	4152      	adcs	r2, r2
c0d03036:	105b      	asrs	r3, r3, #1
c0d03038:	4610      	mov	r0, r2
c0d0303a:	d301      	bcc.n	c0d03040 <__aeabi_idiv+0x1b4>
c0d0303c:	4240      	negs	r0, r0
c0d0303e:	2b00      	cmp	r3, #0
c0d03040:	d500      	bpl.n	c0d03044 <__aeabi_idiv+0x1b8>
c0d03042:	4249      	negs	r1, r1
c0d03044:	4770      	bx	lr
c0d03046:	4663      	mov	r3, ip
c0d03048:	105b      	asrs	r3, r3, #1
c0d0304a:	d300      	bcc.n	c0d0304e <__aeabi_idiv+0x1c2>
c0d0304c:	4240      	negs	r0, r0
c0d0304e:	b501      	push	{r0, lr}
c0d03050:	2000      	movs	r0, #0
c0d03052:	f000 f805 	bl	c0d03060 <__aeabi_idiv0>
c0d03056:	bd02      	pop	{r1, pc}

c0d03058 <__aeabi_idivmod>:
c0d03058:	2900      	cmp	r1, #0
c0d0305a:	d0f8      	beq.n	c0d0304e <__aeabi_idiv+0x1c2>
c0d0305c:	e716      	b.n	c0d02e8c <__aeabi_idiv>
c0d0305e:	4770      	bx	lr

c0d03060 <__aeabi_idiv0>:
c0d03060:	4770      	bx	lr
c0d03062:	46c0      	nop			; (mov r8, r8)

c0d03064 <__aeabi_lmul>:
c0d03064:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03066:	464f      	mov	r7, r9
c0d03068:	4646      	mov	r6, r8
c0d0306a:	b4c0      	push	{r6, r7}
c0d0306c:	0416      	lsls	r6, r2, #16
c0d0306e:	0c36      	lsrs	r6, r6, #16
c0d03070:	4699      	mov	r9, r3
c0d03072:	0033      	movs	r3, r6
c0d03074:	0405      	lsls	r5, r0, #16
c0d03076:	0c2c      	lsrs	r4, r5, #16
c0d03078:	0c07      	lsrs	r7, r0, #16
c0d0307a:	0c15      	lsrs	r5, r2, #16
c0d0307c:	4363      	muls	r3, r4
c0d0307e:	437e      	muls	r6, r7
c0d03080:	436f      	muls	r7, r5
c0d03082:	4365      	muls	r5, r4
c0d03084:	0c1c      	lsrs	r4, r3, #16
c0d03086:	19ad      	adds	r5, r5, r6
c0d03088:	1964      	adds	r4, r4, r5
c0d0308a:	469c      	mov	ip, r3
c0d0308c:	42a6      	cmp	r6, r4
c0d0308e:	d903      	bls.n	c0d03098 <__aeabi_lmul+0x34>
c0d03090:	2380      	movs	r3, #128	; 0x80
c0d03092:	025b      	lsls	r3, r3, #9
c0d03094:	4698      	mov	r8, r3
c0d03096:	4447      	add	r7, r8
c0d03098:	4663      	mov	r3, ip
c0d0309a:	0c25      	lsrs	r5, r4, #16
c0d0309c:	19ef      	adds	r7, r5, r7
c0d0309e:	041d      	lsls	r5, r3, #16
c0d030a0:	464b      	mov	r3, r9
c0d030a2:	434a      	muls	r2, r1
c0d030a4:	4343      	muls	r3, r0
c0d030a6:	0c2d      	lsrs	r5, r5, #16
c0d030a8:	0424      	lsls	r4, r4, #16
c0d030aa:	1964      	adds	r4, r4, r5
c0d030ac:	1899      	adds	r1, r3, r2
c0d030ae:	19c9      	adds	r1, r1, r7
c0d030b0:	0020      	movs	r0, r4
c0d030b2:	bc0c      	pop	{r2, r3}
c0d030b4:	4690      	mov	r8, r2
c0d030b6:	4699      	mov	r9, r3
c0d030b8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d030ba:	46c0      	nop			; (mov r8, r8)

c0d030bc <__aeabi_memclr>:
c0d030bc:	b510      	push	{r4, lr}
c0d030be:	2200      	movs	r2, #0
c0d030c0:	f000 f806 	bl	c0d030d0 <__aeabi_memset>
c0d030c4:	bd10      	pop	{r4, pc}
c0d030c6:	46c0      	nop			; (mov r8, r8)

c0d030c8 <__aeabi_memcpy>:
c0d030c8:	b510      	push	{r4, lr}
c0d030ca:	f000 f809 	bl	c0d030e0 <memcpy>
c0d030ce:	bd10      	pop	{r4, pc}

c0d030d0 <__aeabi_memset>:
c0d030d0:	0013      	movs	r3, r2
c0d030d2:	b510      	push	{r4, lr}
c0d030d4:	000a      	movs	r2, r1
c0d030d6:	0019      	movs	r1, r3
c0d030d8:	f000 f840 	bl	c0d0315c <memset>
c0d030dc:	bd10      	pop	{r4, pc}
c0d030de:	46c0      	nop			; (mov r8, r8)

c0d030e0 <memcpy>:
c0d030e0:	b570      	push	{r4, r5, r6, lr}
c0d030e2:	2a0f      	cmp	r2, #15
c0d030e4:	d932      	bls.n	c0d0314c <memcpy+0x6c>
c0d030e6:	000c      	movs	r4, r1
c0d030e8:	4304      	orrs	r4, r0
c0d030ea:	000b      	movs	r3, r1
c0d030ec:	07a4      	lsls	r4, r4, #30
c0d030ee:	d131      	bne.n	c0d03154 <memcpy+0x74>
c0d030f0:	0015      	movs	r5, r2
c0d030f2:	0004      	movs	r4, r0
c0d030f4:	3d10      	subs	r5, #16
c0d030f6:	092d      	lsrs	r5, r5, #4
c0d030f8:	3501      	adds	r5, #1
c0d030fa:	012d      	lsls	r5, r5, #4
c0d030fc:	1949      	adds	r1, r1, r5
c0d030fe:	681e      	ldr	r6, [r3, #0]
c0d03100:	6026      	str	r6, [r4, #0]
c0d03102:	685e      	ldr	r6, [r3, #4]
c0d03104:	6066      	str	r6, [r4, #4]
c0d03106:	689e      	ldr	r6, [r3, #8]
c0d03108:	60a6      	str	r6, [r4, #8]
c0d0310a:	68de      	ldr	r6, [r3, #12]
c0d0310c:	3310      	adds	r3, #16
c0d0310e:	60e6      	str	r6, [r4, #12]
c0d03110:	3410      	adds	r4, #16
c0d03112:	4299      	cmp	r1, r3
c0d03114:	d1f3      	bne.n	c0d030fe <memcpy+0x1e>
c0d03116:	230f      	movs	r3, #15
c0d03118:	1945      	adds	r5, r0, r5
c0d0311a:	4013      	ands	r3, r2
c0d0311c:	2b03      	cmp	r3, #3
c0d0311e:	d91b      	bls.n	c0d03158 <memcpy+0x78>
c0d03120:	1f1c      	subs	r4, r3, #4
c0d03122:	2300      	movs	r3, #0
c0d03124:	08a4      	lsrs	r4, r4, #2
c0d03126:	3401      	adds	r4, #1
c0d03128:	00a4      	lsls	r4, r4, #2
c0d0312a:	58ce      	ldr	r6, [r1, r3]
c0d0312c:	50ee      	str	r6, [r5, r3]
c0d0312e:	3304      	adds	r3, #4
c0d03130:	429c      	cmp	r4, r3
c0d03132:	d1fa      	bne.n	c0d0312a <memcpy+0x4a>
c0d03134:	2303      	movs	r3, #3
c0d03136:	192d      	adds	r5, r5, r4
c0d03138:	1909      	adds	r1, r1, r4
c0d0313a:	401a      	ands	r2, r3
c0d0313c:	d005      	beq.n	c0d0314a <memcpy+0x6a>
c0d0313e:	2300      	movs	r3, #0
c0d03140:	5ccc      	ldrb	r4, [r1, r3]
c0d03142:	54ec      	strb	r4, [r5, r3]
c0d03144:	3301      	adds	r3, #1
c0d03146:	429a      	cmp	r2, r3
c0d03148:	d1fa      	bne.n	c0d03140 <memcpy+0x60>
c0d0314a:	bd70      	pop	{r4, r5, r6, pc}
c0d0314c:	0005      	movs	r5, r0
c0d0314e:	2a00      	cmp	r2, #0
c0d03150:	d1f5      	bne.n	c0d0313e <memcpy+0x5e>
c0d03152:	e7fa      	b.n	c0d0314a <memcpy+0x6a>
c0d03154:	0005      	movs	r5, r0
c0d03156:	e7f2      	b.n	c0d0313e <memcpy+0x5e>
c0d03158:	001a      	movs	r2, r3
c0d0315a:	e7f8      	b.n	c0d0314e <memcpy+0x6e>

c0d0315c <memset>:
c0d0315c:	b570      	push	{r4, r5, r6, lr}
c0d0315e:	0783      	lsls	r3, r0, #30
c0d03160:	d03f      	beq.n	c0d031e2 <memset+0x86>
c0d03162:	1e54      	subs	r4, r2, #1
c0d03164:	2a00      	cmp	r2, #0
c0d03166:	d03b      	beq.n	c0d031e0 <memset+0x84>
c0d03168:	b2ce      	uxtb	r6, r1
c0d0316a:	0003      	movs	r3, r0
c0d0316c:	2503      	movs	r5, #3
c0d0316e:	e003      	b.n	c0d03178 <memset+0x1c>
c0d03170:	1e62      	subs	r2, r4, #1
c0d03172:	2c00      	cmp	r4, #0
c0d03174:	d034      	beq.n	c0d031e0 <memset+0x84>
c0d03176:	0014      	movs	r4, r2
c0d03178:	3301      	adds	r3, #1
c0d0317a:	1e5a      	subs	r2, r3, #1
c0d0317c:	7016      	strb	r6, [r2, #0]
c0d0317e:	422b      	tst	r3, r5
c0d03180:	d1f6      	bne.n	c0d03170 <memset+0x14>
c0d03182:	2c03      	cmp	r4, #3
c0d03184:	d924      	bls.n	c0d031d0 <memset+0x74>
c0d03186:	25ff      	movs	r5, #255	; 0xff
c0d03188:	400d      	ands	r5, r1
c0d0318a:	022a      	lsls	r2, r5, #8
c0d0318c:	4315      	orrs	r5, r2
c0d0318e:	042a      	lsls	r2, r5, #16
c0d03190:	4315      	orrs	r5, r2
c0d03192:	2c0f      	cmp	r4, #15
c0d03194:	d911      	bls.n	c0d031ba <memset+0x5e>
c0d03196:	0026      	movs	r6, r4
c0d03198:	3e10      	subs	r6, #16
c0d0319a:	0936      	lsrs	r6, r6, #4
c0d0319c:	3601      	adds	r6, #1
c0d0319e:	0136      	lsls	r6, r6, #4
c0d031a0:	001a      	movs	r2, r3
c0d031a2:	199b      	adds	r3, r3, r6
c0d031a4:	6015      	str	r5, [r2, #0]
c0d031a6:	6055      	str	r5, [r2, #4]
c0d031a8:	6095      	str	r5, [r2, #8]
c0d031aa:	60d5      	str	r5, [r2, #12]
c0d031ac:	3210      	adds	r2, #16
c0d031ae:	4293      	cmp	r3, r2
c0d031b0:	d1f8      	bne.n	c0d031a4 <memset+0x48>
c0d031b2:	220f      	movs	r2, #15
c0d031b4:	4014      	ands	r4, r2
c0d031b6:	2c03      	cmp	r4, #3
c0d031b8:	d90a      	bls.n	c0d031d0 <memset+0x74>
c0d031ba:	1f26      	subs	r6, r4, #4
c0d031bc:	08b6      	lsrs	r6, r6, #2
c0d031be:	3601      	adds	r6, #1
c0d031c0:	00b6      	lsls	r6, r6, #2
c0d031c2:	001a      	movs	r2, r3
c0d031c4:	199b      	adds	r3, r3, r6
c0d031c6:	c220      	stmia	r2!, {r5}
c0d031c8:	4293      	cmp	r3, r2
c0d031ca:	d1fc      	bne.n	c0d031c6 <memset+0x6a>
c0d031cc:	2203      	movs	r2, #3
c0d031ce:	4014      	ands	r4, r2
c0d031d0:	2c00      	cmp	r4, #0
c0d031d2:	d005      	beq.n	c0d031e0 <memset+0x84>
c0d031d4:	b2c9      	uxtb	r1, r1
c0d031d6:	191c      	adds	r4, r3, r4
c0d031d8:	7019      	strb	r1, [r3, #0]
c0d031da:	3301      	adds	r3, #1
c0d031dc:	429c      	cmp	r4, r3
c0d031de:	d1fb      	bne.n	c0d031d8 <memset+0x7c>
c0d031e0:	bd70      	pop	{r4, r5, r6, pc}
c0d031e2:	0014      	movs	r4, r2
c0d031e4:	0003      	movs	r3, r0
c0d031e6:	e7cc      	b.n	c0d03182 <memset+0x26>

c0d031e8 <setjmp>:
c0d031e8:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d031ea:	4641      	mov	r1, r8
c0d031ec:	464a      	mov	r2, r9
c0d031ee:	4653      	mov	r3, sl
c0d031f0:	465c      	mov	r4, fp
c0d031f2:	466d      	mov	r5, sp
c0d031f4:	4676      	mov	r6, lr
c0d031f6:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d031f8:	3828      	subs	r0, #40	; 0x28
c0d031fa:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d031fc:	2000      	movs	r0, #0
c0d031fe:	4770      	bx	lr

c0d03200 <longjmp>:
c0d03200:	3010      	adds	r0, #16
c0d03202:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03204:	4690      	mov	r8, r2
c0d03206:	4699      	mov	r9, r3
c0d03208:	46a2      	mov	sl, r4
c0d0320a:	46ab      	mov	fp, r5
c0d0320c:	46b5      	mov	sp, r6
c0d0320e:	c808      	ldmia	r0!, {r3}
c0d03210:	3828      	subs	r0, #40	; 0x28
c0d03212:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03214:	1c08      	adds	r0, r1, #0
c0d03216:	d100      	bne.n	c0d0321a <longjmp+0x1a>
c0d03218:	2001      	movs	r0, #1
c0d0321a:	4718      	bx	r3

c0d0321c <strlen>:
c0d0321c:	b510      	push	{r4, lr}
c0d0321e:	0783      	lsls	r3, r0, #30
c0d03220:	d027      	beq.n	c0d03272 <strlen+0x56>
c0d03222:	7803      	ldrb	r3, [r0, #0]
c0d03224:	2b00      	cmp	r3, #0
c0d03226:	d026      	beq.n	c0d03276 <strlen+0x5a>
c0d03228:	0003      	movs	r3, r0
c0d0322a:	2103      	movs	r1, #3
c0d0322c:	e002      	b.n	c0d03234 <strlen+0x18>
c0d0322e:	781a      	ldrb	r2, [r3, #0]
c0d03230:	2a00      	cmp	r2, #0
c0d03232:	d01c      	beq.n	c0d0326e <strlen+0x52>
c0d03234:	3301      	adds	r3, #1
c0d03236:	420b      	tst	r3, r1
c0d03238:	d1f9      	bne.n	c0d0322e <strlen+0x12>
c0d0323a:	6819      	ldr	r1, [r3, #0]
c0d0323c:	4a0f      	ldr	r2, [pc, #60]	; (c0d0327c <strlen+0x60>)
c0d0323e:	4c10      	ldr	r4, [pc, #64]	; (c0d03280 <strlen+0x64>)
c0d03240:	188a      	adds	r2, r1, r2
c0d03242:	438a      	bics	r2, r1
c0d03244:	4222      	tst	r2, r4
c0d03246:	d10f      	bne.n	c0d03268 <strlen+0x4c>
c0d03248:	3304      	adds	r3, #4
c0d0324a:	6819      	ldr	r1, [r3, #0]
c0d0324c:	4a0b      	ldr	r2, [pc, #44]	; (c0d0327c <strlen+0x60>)
c0d0324e:	188a      	adds	r2, r1, r2
c0d03250:	438a      	bics	r2, r1
c0d03252:	4222      	tst	r2, r4
c0d03254:	d108      	bne.n	c0d03268 <strlen+0x4c>
c0d03256:	3304      	adds	r3, #4
c0d03258:	6819      	ldr	r1, [r3, #0]
c0d0325a:	4a08      	ldr	r2, [pc, #32]	; (c0d0327c <strlen+0x60>)
c0d0325c:	188a      	adds	r2, r1, r2
c0d0325e:	438a      	bics	r2, r1
c0d03260:	4222      	tst	r2, r4
c0d03262:	d0f1      	beq.n	c0d03248 <strlen+0x2c>
c0d03264:	e000      	b.n	c0d03268 <strlen+0x4c>
c0d03266:	3301      	adds	r3, #1
c0d03268:	781a      	ldrb	r2, [r3, #0]
c0d0326a:	2a00      	cmp	r2, #0
c0d0326c:	d1fb      	bne.n	c0d03266 <strlen+0x4a>
c0d0326e:	1a18      	subs	r0, r3, r0
c0d03270:	bd10      	pop	{r4, pc}
c0d03272:	0003      	movs	r3, r0
c0d03274:	e7e1      	b.n	c0d0323a <strlen+0x1e>
c0d03276:	2000      	movs	r0, #0
c0d03278:	e7fa      	b.n	c0d03270 <strlen+0x54>
c0d0327a:	46c0      	nop			; (mov r8, r8)
c0d0327c:	fefefeff 	.word	0xfefefeff
c0d03280:	80808080 	.word	0x80808080
c0d03284:	45544550 	.word	0x45544550
c0d03288:	54455052 	.word	0x54455052
c0d0328c:	45505245 	.word	0x45505245
c0d03290:	50524554 	.word	0x50524554
c0d03294:	52455445 	.word	0x52455445
c0d03298:	45544550 	.word	0x45544550
c0d0329c:	54455052 	.word	0x54455052
c0d032a0:	45505245 	.word	0x45505245
c0d032a4:	50524554 	.word	0x50524554
c0d032a8:	52455445 	.word	0x52455445
c0d032ac:	45544550 	.word	0x45544550
c0d032b0:	54455052 	.word	0x54455052
c0d032b4:	45505245 	.word	0x45505245
c0d032b8:	50524554 	.word	0x50524554
c0d032bc:	52455445 	.word	0x52455445
c0d032c0:	45544550 	.word	0x45544550
c0d032c4:	54455052 	.word	0x54455052
c0d032c8:	45505245 	.word	0x45505245
c0d032cc:	50524554 	.word	0x50524554
c0d032d0:	52455445 	.word	0x52455445
c0d032d4:	00000052 	.word	0x00000052

c0d032d8 <trits_mapping>:
c0d032d8:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d032e8:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d032f8:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03308:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03318:	00000100 01000101 000101ff 01010101     ................
c0d03328:	00000001                                ....

c0d0332c <bagl_ui_nanos_screen1>:
c0d0332c:	00000003 00800000 00000020 00000001     ........ .......
c0d0333c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03364:	00000107 0080000c 00000020 00000000     ........ .......
c0d03374:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0339c:	00030005 0007000c 00000007 00000000     ................
	...
c0d033b4:	00070000 00000000 00000000 00000000     ................
	...
c0d033d4:	00750005 0008000d 00000006 00000000     ..u.............
c0d033e4:	00ffffff 00000000 00060000 00000000     ................
	...

c0d0340c <bagl_ui_nanos_screen2>:
c0d0340c:	00000003 00800000 00000020 00000001     ........ .......
c0d0341c:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03444:	00000107 00800012 00000020 00000000     ........ .......
c0d03454:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0347c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03494:	00070000 00000000 00000000 00000000     ................
	...
c0d034b4:	00750005 0008000d 00000006 00000000     ..u.............
c0d034c4:	00ffffff 00000000 00060000 00000000     ................
	...

c0d034ec <bagl_ui_sample_blue>:
c0d034ec:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d034fc:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03524:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03534:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d0355c:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d0356c:	00ffffff 001d2028 00002004 c0d035cc     ....( ... ...5..
	...
c0d03594:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d035a4:	0041ccb4 00f9f9f9 0000a004 c0d035d8     ..A..........5..
c0d035b4:	00000000 0037ae99 00f9f9f9 c0d02049     ......7.....I ..
	...
c0d035cc:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d035dd <USBD_PRODUCT_FS_STRING>:
c0d035dd:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d035eb <HID_ReportDesc>:
c0d035eb:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d035fb:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0360b:	0000c008 11210900                                .....

c0d03610 <USBD_HID_Desc>:
c0d03610:	01112109 22220100 00011200                       .!...."".

c0d03619 <USBD_DeviceDesc>:
c0d03619:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03629:	59000103                                         ...

c0d0362c <HID_Desc>:
c0d0362c:	c0d02c59 c0d02c69 c0d02c79 c0d02c89     Y,..i,..y,...,..
c0d0363c:	c0d02c99 c0d02ca9 c0d02cb9 00000000     .,...,...,......

c0d0364c <USBD_LangIDDesc>:
c0d0364c:	04090304                                ....

c0d03650 <USBD_MANUFACTURER_STRING>:
c0d03650:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d0365e <USB_SERIAL_STRING>:
c0d0365e:	0030030a 00300030 2b3b0031                       ..0.0.0.1.

c0d03668 <USBD_HID>:
c0d03668:	c0d02b3b c0d02b6d c0d02a9f 00000000     ;+..m+...*......
	...
c0d03680:	c0d02ba5 00000000 00000000 00000000     .+..............
c0d03690:	c0d02cc9 c0d02cc9 c0d02cc9 c0d02cd9     .,...,...,...,..

c0d036a0 <USBD_CfgDesc>:
c0d036a0:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d036b0:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d036c0:	05070100 00400302 00000001              ......@.....

c0d036cc <USBD_DeviceQualifierDesc>:
c0d036cc:	0200060a 40000000 00000001              .......@....

c0d036d8 <_etext>:
	...

c0d03700 <N_storage_real>:
	...
