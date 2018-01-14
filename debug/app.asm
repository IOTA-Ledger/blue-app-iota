
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
c0d00014:	f000 fe76 	bl	c0d00d04 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fdc2 	bl	c0d00ba0 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f91d 	bl	c0d03264 <setjmp>
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
c0d00040:	f001 f806 	bl	c0d01050 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fce7 	bl	c0d01a18 <pic>
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
c0d0005a:	f001 fcdd 	bl	c0d01a18 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fd2b 	bl	c0d01abc <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fe32 	bl	c0d02cd0 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fe2f 	bl	c0d02cd0 <USB_power>

            ui_idle();
c0d00072:	f001 ffc3 	bl	c0d01ffc <ui_idle>

            IOTA_main();
c0d00076:	f000 fc2b 	bl	c0d008d0 <IOTA_main>
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
c0d0008c:	f003 f8f6 	bl	c0d0327c <longjmp>
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
c0d000ca:	f001 fa55 	bl	c0d01578 <snprintf>
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
c0d00192:	f002 fee5 	bl	c0d02f60 <__aeabi_idiv>
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
c0d001c0:	f002 fe44 	bl	c0d02e4c <__aeabi_uidiv>
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
c0d001e6:	f000 f9bf 	bl	c0d00568 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001ea:	f000 f9bd 	bl	c0d00568 <kerl_initialize>
c0d001ee:	ac04      	add	r4, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001f0:	4620      	mov	r0, r4
c0d001f2:	4629      	mov	r1, r5
c0d001f4:	4632      	mov	r2, r6
c0d001f6:	f002 ffa5 	bl	c0d03144 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001fa:	19a0      	adds	r0, r4, r6
c0d001fc:	2530      	movs	r5, #48	; 0x30
c0d001fe:	1baa      	subs	r2, r5, r6
c0d00200:	9902      	ldr	r1, [sp, #8]
c0d00202:	f002 ff9f 	bl	c0d03144 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00206:	4620      	mov	r0, r4
c0d00208:	4629      	mov	r1, r5
c0d0020a:	f000 f9b9 	bl	c0d00580 <kerl_absorb_bytes>
c0d0020e:	ae41      	add	r6, sp, #260	; 0x104
c0d00210:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00212:	4630      	mov	r0, r6
c0d00214:	4629      	mov	r1, r5
c0d00216:	f002 ff8f 	bl	c0d03138 <__aeabi_memclr>
c0d0021a:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021c:	4919      	ldr	r1, [pc, #100]	; (c0d00284 <get_seed+0xac>)
c0d0021e:	4479      	add	r1, pc
c0d00220:	2252      	movs	r2, #82	; 0x52
c0d00222:	4620      	mov	r0, r4
c0d00224:	f002 ff8e 	bl	c0d03144 <__aeabi_memcpy>
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
c0d00238:	f002 ff7e 	bl	c0d03138 <__aeabi_memclr>
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
c0d0026a:	f001 f985 	bl	c0d01578 <snprintf>
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
c0d00284:	000030de 	.word	0x000030de

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
c0d0041c:	00002f62 	.word	0x00002f62

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
c0d00456:	a814      	add	r0, sp, #80	; 0x50
    uint32_t base[13] = {0};
c0d00458:	2134      	movs	r1, #52	; 0x34
c0d0045a:	f002 fe6d 	bl	c0d03138 <__aeabi_memclr>
c0d0045e:	2130      	movs	r1, #48	; 0x30

    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00460:	2403      	movs	r4, #3
c0d00462:	2005      	movs	r0, #5
c0d00464:	2930      	cmp	r1, #48	; 0x30
c0d00466:	d000      	beq.n	c0d0046a <trints_to_words+0x1e>
c0d00468:	4604      	mov	r4, r0
        trint_to_trits(trints_in[x], trits, get);
c0d0046a:	9802      	ldr	r0, [sp, #8]
c0d0046c:	9103      	str	r1, [sp, #12]
c0d0046e:	5640      	ldrsb	r0, [r0, r1]
c0d00470:	a912      	add	r1, sp, #72	; 0x48
c0d00472:	4622      	mov	r2, r4
c0d00474:	f7ff fe78 	bl	c0d00168 <trint_to_trits>

        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d00478:	4837      	ldr	r0, [pc, #220]	; (c0d00558 <trints_to_words+0x10c>)
c0d0047a:	1825      	adds	r5, r4, r0
c0d0047c:	2006      	movs	r0, #6
c0d0047e:	4028      	ands	r0, r5
c0d00480:	1e64      	subs	r4, r4, #1
c0d00482:	9404      	str	r4, [sp, #16]
c0d00484:	2100      	movs	r1, #0
                  /*
                  var v = base[j] * RADIX + carry;
                  carry = rshift(v, 32);
                  base[j] = (v & 0xFFFFFFFF) >>> 0;
                  */
                    int64_t v = base[j] * RADIX + carry;// * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
c0d00486:	008a      	lsls	r2, r1, #2
c0d00488:	ab14      	add	r3, sp, #80	; 0x50
c0d0048a:	589c      	ldr	r4, [r3, r2]
c0d0048c:	2603      	movs	r6, #3
c0d0048e:	4366      	muls	r6, r4
                    carry = (int32_t)((v >> 32));
                    base[j] = (int32_t) (v & 0xFFFFFFFF);
c0d00490:	509e      	str	r6, [r3, r2]
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;

                for (int32_t j = 0; j < sz; j++) {
c0d00492:	1c49      	adds	r1, r1, #1
c0d00494:	290d      	cmp	r1, #13
c0d00496:	d1f6      	bne.n	c0d00486 <trints_to_words+0x3a>

            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00498:	9903      	ldr	r1, [sp, #12]
c0d0049a:	2930      	cmp	r1, #48	; 0x30
c0d0049c:	d106      	bne.n	c0d004ac <trints_to_words+0x60>
c0d0049e:	9904      	ldr	r1, [sp, #16]
c0d004a0:	b289      	uxth	r1, r1
c0d004a2:	2902      	cmp	r1, #2
c0d004a4:	d102      	bne.n	c0d004ac <trints_to_words+0x60>
c0d004a6:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d004a8:	2101      	movs	r1, #1
c0d004aa:	e003      	b.n	c0d004b4 <trints_to_words+0x68>
c0d004ac:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d004ae:	5608      	ldrsb	r0, [r1, r0]
c0d004b0:	1c41      	adds	r1, r0, #1
c0d004b2:	a814      	add	r0, sp, #80	; 0x50
c0d004b4:	aa05      	add	r2, sp, #20
c0d004b6:	230d      	movs	r3, #13
c0d004b8:	f7ff fee6 	bl	c0d00288 <bigint_add_int>
c0d004bc:	a805      	add	r0, sp, #20
c0d004be:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d004c0:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d004c2:	c11c      	stmia	r1!, {r2, r3, r4}
c0d004c4:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d004c6:	c11c      	stmia	r1!, {r2, r3, r4}
c0d004c8:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d004ca:	c11c      	stmia	r1!, {r2, r3, r4}
c0d004cc:	c85c      	ldmia	r0!, {r2, r3, r4, r6}
c0d004ce:	c15c      	stmia	r1!, {r2, r3, r4, r6}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], trits, get);

        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d004d0:	1e68      	subs	r0, r5, #1
c0d004d2:	b200      	sxth	r0, r0
c0d004d4:	2800      	cmp	r0, #0
c0d004d6:	4605      	mov	r5, r0
c0d004d8:	9c04      	ldr	r4, [sp, #16]
c0d004da:	dad1      	bge.n	c0d00480 <trints_to_words+0x34>
c0d004dc:	9903      	ldr	r1, [sp, #12]
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter

    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d004de:	1e48      	subs	r0, r1, #1
c0d004e0:	2900      	cmp	r1, #0
c0d004e2:	4601      	mov	r1, r0
c0d004e4:	dcbc      	bgt.n	c0d00460 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d004e6:	481d      	ldr	r0, [pc, #116]	; (c0d0055c <trints_to_words+0x110>)
c0d004e8:	4478      	add	r0, pc
c0d004ea:	a914      	add	r1, sp, #80	; 0x50
c0d004ec:	220d      	movs	r2, #13
c0d004ee:	f7ff ff51 	bl	c0d00394 <bigint_cmp_bigint>
c0d004f2:	2801      	cmp	r0, #1
c0d004f4:	db14      	blt.n	c0d00520 <trints_to_words+0xd4>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d004f6:	481b      	ldr	r0, [pc, #108]	; (c0d00564 <trints_to_words+0x118>)
c0d004f8:	4478      	add	r0, pc
c0d004fa:	ad14      	add	r5, sp, #80	; 0x50
c0d004fc:	ac05      	add	r4, sp, #20
c0d004fe:	260d      	movs	r6, #13
c0d00500:	4629      	mov	r1, r5
c0d00502:	4622      	mov	r2, r4
c0d00504:	4633      	mov	r3, r6
c0d00506:	f7ff ff04 	bl	c0d00312 <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d0050a:	4620      	mov	r0, r4
c0d0050c:	4631      	mov	r1, r6
c0d0050e:	f7ff ff60 	bl	c0d003d2 <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d00512:	2101      	movs	r1, #1
c0d00514:	4620      	mov	r0, r4
c0d00516:	462a      	mov	r2, r5
c0d00518:	4633      	mov	r3, r6
c0d0051a:	f7ff feb5 	bl	c0d00288 <bigint_add_int>
c0d0051e:	e010      	b.n	c0d00542 <trints_to_words+0xf6>
c0d00520:	ad14      	add	r5, sp, #80	; 0x50
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d00522:	490f      	ldr	r1, [pc, #60]	; (c0d00560 <trints_to_words+0x114>)
c0d00524:	4479      	add	r1, pc
c0d00526:	ae05      	add	r6, sp, #20
c0d00528:	230d      	movs	r3, #13
c0d0052a:	4628      	mov	r0, r5
c0d0052c:	4632      	mov	r2, r6
c0d0052e:	f7ff fef0 	bl	c0d00312 <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d00532:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00534:	c507      	stmia	r5!, {r0, r1, r2}
c0d00536:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d00538:	c507      	stmia	r5!, {r0, r1, r2}
c0d0053a:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d0053c:	c507      	stmia	r5!, {r0, r1, r2}
c0d0053e:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d00540:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00542:	a814      	add	r0, sp, #80	; 0x50
c0d00544:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }


    memcpy(words_out, base, 48);
c0d00546:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00548:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0054a:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0054c:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0054e:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00550:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00552:	2000      	movs	r0, #0
c0d00554:	b021      	add	sp, #132	; 0x84
c0d00556:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00558:	0000ffff 	.word	0x0000ffff
c0d0055c:	00002ebc 	.word	0x00002ebc
c0d00560:	00002e80 	.word	0x00002e80
c0d00564:	00002eac 	.word	0x00002eac

c0d00568 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00568:	b580      	push	{r7, lr}
c0d0056a:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d0056c:	2003      	movs	r0, #3
c0d0056e:	01c1      	lsls	r1, r0, #7
c0d00570:	4802      	ldr	r0, [pc, #8]	; (c0d0057c <kerl_initialize+0x14>)
c0d00572:	f001 fafd 	bl	c0d01b70 <cx_keccak_init>
    return 0;
c0d00576:	2000      	movs	r0, #0
c0d00578:	bd80      	pop	{r7, pc}
c0d0057a:	46c0      	nop			; (mov r8, r8)
c0d0057c:	20001840 	.word	0x20001840

c0d00580 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00580:	b580      	push	{r7, lr}
c0d00582:	af00      	add	r7, sp, #0
c0d00584:	b082      	sub	sp, #8
c0d00586:	460b      	mov	r3, r1
c0d00588:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0058a:	4805      	ldr	r0, [pc, #20]	; (c0d005a0 <kerl_absorb_bytes+0x20>)
c0d0058c:	4669      	mov	r1, sp
c0d0058e:	6008      	str	r0, [r1, #0]
c0d00590:	4804      	ldr	r0, [pc, #16]	; (c0d005a4 <kerl_absorb_bytes+0x24>)
c0d00592:	2101      	movs	r1, #1
c0d00594:	f001 fb0a 	bl	c0d01bac <cx_hash>
c0d00598:	2000      	movs	r0, #0
    return 0;
c0d0059a:	b002      	add	sp, #8
c0d0059c:	bd80      	pop	{r7, pc}
c0d0059e:	46c0      	nop			; (mov r8, r8)
c0d005a0:	200019e8 	.word	0x200019e8
c0d005a4:	20001840 	.word	0x20001840

c0d005a8 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d005a8:	b580      	push	{r7, lr}
c0d005aa:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d005ac:	4804      	ldr	r0, [pc, #16]	; (c0d005c0 <nvram_is_init+0x18>)
c0d005ae:	f001 fa33 	bl	c0d01a18 <pic>
c0d005b2:	7801      	ldrb	r1, [r0, #0]
c0d005b4:	2000      	movs	r0, #0
c0d005b6:	2901      	cmp	r1, #1
c0d005b8:	d100      	bne.n	c0d005bc <nvram_is_init+0x14>
c0d005ba:	4608      	mov	r0, r1
    else return true;
}
c0d005bc:	bd80      	pop	{r7, pc}
c0d005be:	46c0      	nop			; (mov r8, r8)
c0d005c0:	c0d037c0 	.word	0xc0d037c0

c0d005c4 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d005c4:	b5b0      	push	{r4, r5, r7, lr}
c0d005c6:	af02      	add	r7, sp, #8
c0d005c8:	4605      	mov	r5, r0
c0d005ca:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d005cc:	4028      	ands	r0, r5
c0d005ce:	2400      	movs	r4, #0
c0d005d0:	2801      	cmp	r0, #1
c0d005d2:	d013      	beq.n	c0d005fc <io_exchange_al+0x38>
c0d005d4:	2802      	cmp	r0, #2
c0d005d6:	d113      	bne.n	c0d00600 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d005d8:	2900      	cmp	r1, #0
c0d005da:	d008      	beq.n	c0d005ee <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d005dc:	480b      	ldr	r0, [pc, #44]	; (c0d0060c <io_exchange_al+0x48>)
c0d005de:	f001 fbd7 	bl	c0d01d90 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d005e2:	b268      	sxtb	r0, r5
c0d005e4:	2800      	cmp	r0, #0
c0d005e6:	da09      	bge.n	c0d005fc <io_exchange_al+0x38>
                reset();
c0d005e8:	f001 fa4c 	bl	c0d01a84 <reset>
c0d005ec:	e006      	b.n	c0d005fc <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d005ee:	2041      	movs	r0, #65	; 0x41
c0d005f0:	0081      	lsls	r1, r0, #2
c0d005f2:	4806      	ldr	r0, [pc, #24]	; (c0d0060c <io_exchange_al+0x48>)
c0d005f4:	2200      	movs	r2, #0
c0d005f6:	f001 fc05 	bl	c0d01e04 <io_seproxyhal_spi_recv>
c0d005fa:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d005fc:	4620      	mov	r0, r4
c0d005fe:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00600:	4803      	ldr	r0, [pc, #12]	; (c0d00610 <io_exchange_al+0x4c>)
c0d00602:	6800      	ldr	r0, [r0, #0]
c0d00604:	2102      	movs	r1, #2
c0d00606:	f002 fe39 	bl	c0d0327c <longjmp>
c0d0060a:	46c0      	nop			; (mov r8, r8)
c0d0060c:	20001c08 	.word	0x20001c08
c0d00610:	20001bb8 	.word	0x20001bb8

c0d00614 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00614:	b580      	push	{r7, lr}
c0d00616:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00618:	f000 fe8e 	bl	c0d01338 <io_seproxyhal_display_default>
}
c0d0061c:	bd80      	pop	{r7, pc}
	...

c0d00620 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00620:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00622:	af03      	add	r7, sp, #12
c0d00624:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00626:	48a6      	ldr	r0, [pc, #664]	; (c0d008c0 <io_event+0x2a0>)
c0d00628:	7800      	ldrb	r0, [r0, #0]
c0d0062a:	2805      	cmp	r0, #5
c0d0062c:	d02e      	beq.n	c0d0068c <io_event+0x6c>
c0d0062e:	280d      	cmp	r0, #13
c0d00630:	d04e      	beq.n	c0d006d0 <io_event+0xb0>
c0d00632:	280c      	cmp	r0, #12
c0d00634:	d000      	beq.n	c0d00638 <io_event+0x18>
c0d00636:	e13a      	b.n	c0d008ae <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00638:	4ea2      	ldr	r6, [pc, #648]	; (c0d008c4 <io_event+0x2a4>)
c0d0063a:	2001      	movs	r0, #1
c0d0063c:	7630      	strb	r0, [r6, #24]
c0d0063e:	2500      	movs	r5, #0
c0d00640:	61f5      	str	r5, [r6, #28]
c0d00642:	4634      	mov	r4, r6
c0d00644:	3418      	adds	r4, #24
c0d00646:	4620      	mov	r0, r4
c0d00648:	f001 fb68 	bl	c0d01d1c <os_ux>
c0d0064c:	61f0      	str	r0, [r6, #28]
c0d0064e:	499e      	ldr	r1, [pc, #632]	; (c0d008c8 <io_event+0x2a8>)
c0d00650:	4288      	cmp	r0, r1
c0d00652:	d100      	bne.n	c0d00656 <io_event+0x36>
c0d00654:	e12b      	b.n	c0d008ae <io_event+0x28e>
c0d00656:	2800      	cmp	r0, #0
c0d00658:	d100      	bne.n	c0d0065c <io_event+0x3c>
c0d0065a:	e128      	b.n	c0d008ae <io_event+0x28e>
c0d0065c:	499b      	ldr	r1, [pc, #620]	; (c0d008cc <io_event+0x2ac>)
c0d0065e:	4288      	cmp	r0, r1
c0d00660:	d000      	beq.n	c0d00664 <io_event+0x44>
c0d00662:	e0ac      	b.n	c0d007be <io_event+0x19e>
c0d00664:	2003      	movs	r0, #3
c0d00666:	7630      	strb	r0, [r6, #24]
c0d00668:	61f5      	str	r5, [r6, #28]
c0d0066a:	4620      	mov	r0, r4
c0d0066c:	f001 fb56 	bl	c0d01d1c <os_ux>
c0d00670:	61f0      	str	r0, [r6, #28]
c0d00672:	f000 fd17 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d00676:	60b5      	str	r5, [r6, #8]
c0d00678:	6830      	ldr	r0, [r6, #0]
c0d0067a:	2800      	cmp	r0, #0
c0d0067c:	d100      	bne.n	c0d00680 <io_event+0x60>
c0d0067e:	e116      	b.n	c0d008ae <io_event+0x28e>
c0d00680:	69f0      	ldr	r0, [r6, #28]
c0d00682:	4991      	ldr	r1, [pc, #580]	; (c0d008c8 <io_event+0x2a8>)
c0d00684:	4288      	cmp	r0, r1
c0d00686:	d000      	beq.n	c0d0068a <io_event+0x6a>
c0d00688:	e096      	b.n	c0d007b8 <io_event+0x198>
c0d0068a:	e110      	b.n	c0d008ae <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0068c:	4d8d      	ldr	r5, [pc, #564]	; (c0d008c4 <io_event+0x2a4>)
c0d0068e:	2001      	movs	r0, #1
c0d00690:	7628      	strb	r0, [r5, #24]
c0d00692:	2600      	movs	r6, #0
c0d00694:	61ee      	str	r6, [r5, #28]
c0d00696:	462c      	mov	r4, r5
c0d00698:	3418      	adds	r4, #24
c0d0069a:	4620      	mov	r0, r4
c0d0069c:	f001 fb3e 	bl	c0d01d1c <os_ux>
c0d006a0:	4601      	mov	r1, r0
c0d006a2:	61e9      	str	r1, [r5, #28]
c0d006a4:	4889      	ldr	r0, [pc, #548]	; (c0d008cc <io_event+0x2ac>)
c0d006a6:	4281      	cmp	r1, r0
c0d006a8:	d15d      	bne.n	c0d00766 <io_event+0x146>
c0d006aa:	2003      	movs	r0, #3
c0d006ac:	7628      	strb	r0, [r5, #24]
c0d006ae:	61ee      	str	r6, [r5, #28]
c0d006b0:	4620      	mov	r0, r4
c0d006b2:	f001 fb33 	bl	c0d01d1c <os_ux>
c0d006b6:	61e8      	str	r0, [r5, #28]
c0d006b8:	f000 fcf4 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d006bc:	60ae      	str	r6, [r5, #8]
c0d006be:	6828      	ldr	r0, [r5, #0]
c0d006c0:	2800      	cmp	r0, #0
c0d006c2:	d100      	bne.n	c0d006c6 <io_event+0xa6>
c0d006c4:	e0f3      	b.n	c0d008ae <io_event+0x28e>
c0d006c6:	69e8      	ldr	r0, [r5, #28]
c0d006c8:	497f      	ldr	r1, [pc, #508]	; (c0d008c8 <io_event+0x2a8>)
c0d006ca:	4288      	cmp	r0, r1
c0d006cc:	d148      	bne.n	c0d00760 <io_event+0x140>
c0d006ce:	e0ee      	b.n	c0d008ae <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d006d0:	4d7c      	ldr	r5, [pc, #496]	; (c0d008c4 <io_event+0x2a4>)
c0d006d2:	6868      	ldr	r0, [r5, #4]
c0d006d4:	68a9      	ldr	r1, [r5, #8]
c0d006d6:	4281      	cmp	r1, r0
c0d006d8:	d300      	bcc.n	c0d006dc <io_event+0xbc>
c0d006da:	e0e8      	b.n	c0d008ae <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d006dc:	2001      	movs	r0, #1
c0d006de:	7628      	strb	r0, [r5, #24]
c0d006e0:	2600      	movs	r6, #0
c0d006e2:	61ee      	str	r6, [r5, #28]
c0d006e4:	462c      	mov	r4, r5
c0d006e6:	3418      	adds	r4, #24
c0d006e8:	4620      	mov	r0, r4
c0d006ea:	f001 fb17 	bl	c0d01d1c <os_ux>
c0d006ee:	61e8      	str	r0, [r5, #28]
c0d006f0:	4975      	ldr	r1, [pc, #468]	; (c0d008c8 <io_event+0x2a8>)
c0d006f2:	4288      	cmp	r0, r1
c0d006f4:	d100      	bne.n	c0d006f8 <io_event+0xd8>
c0d006f6:	e0da      	b.n	c0d008ae <io_event+0x28e>
c0d006f8:	2800      	cmp	r0, #0
c0d006fa:	d100      	bne.n	c0d006fe <io_event+0xde>
c0d006fc:	e0d7      	b.n	c0d008ae <io_event+0x28e>
c0d006fe:	4973      	ldr	r1, [pc, #460]	; (c0d008cc <io_event+0x2ac>)
c0d00700:	4288      	cmp	r0, r1
c0d00702:	d000      	beq.n	c0d00706 <io_event+0xe6>
c0d00704:	e08d      	b.n	c0d00822 <io_event+0x202>
c0d00706:	2003      	movs	r0, #3
c0d00708:	7628      	strb	r0, [r5, #24]
c0d0070a:	61ee      	str	r6, [r5, #28]
c0d0070c:	4620      	mov	r0, r4
c0d0070e:	f001 fb05 	bl	c0d01d1c <os_ux>
c0d00712:	61e8      	str	r0, [r5, #28]
c0d00714:	f000 fcc6 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d00718:	60ae      	str	r6, [r5, #8]
c0d0071a:	6828      	ldr	r0, [r5, #0]
c0d0071c:	2800      	cmp	r0, #0
c0d0071e:	d100      	bne.n	c0d00722 <io_event+0x102>
c0d00720:	e0c5      	b.n	c0d008ae <io_event+0x28e>
c0d00722:	69e8      	ldr	r0, [r5, #28]
c0d00724:	4968      	ldr	r1, [pc, #416]	; (c0d008c8 <io_event+0x2a8>)
c0d00726:	4288      	cmp	r0, r1
c0d00728:	d178      	bne.n	c0d0081c <io_event+0x1fc>
c0d0072a:	e0c0      	b.n	c0d008ae <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0072c:	6868      	ldr	r0, [r5, #4]
c0d0072e:	4286      	cmp	r6, r0
c0d00730:	d300      	bcc.n	c0d00734 <io_event+0x114>
c0d00732:	e0bc      	b.n	c0d008ae <io_event+0x28e>
c0d00734:	f001 fb4a 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00738:	2800      	cmp	r0, #0
c0d0073a:	d000      	beq.n	c0d0073e <io_event+0x11e>
c0d0073c:	e0b7      	b.n	c0d008ae <io_event+0x28e>
c0d0073e:	68a8      	ldr	r0, [r5, #8]
c0d00740:	68e9      	ldr	r1, [r5, #12]
c0d00742:	2438      	movs	r4, #56	; 0x38
c0d00744:	4360      	muls	r0, r4
c0d00746:	682a      	ldr	r2, [r5, #0]
c0d00748:	1810      	adds	r0, r2, r0
c0d0074a:	2900      	cmp	r1, #0
c0d0074c:	d100      	bne.n	c0d00750 <io_event+0x130>
c0d0074e:	e085      	b.n	c0d0085c <io_event+0x23c>
c0d00750:	4788      	blx	r1
c0d00752:	2800      	cmp	r0, #0
c0d00754:	d000      	beq.n	c0d00758 <io_event+0x138>
c0d00756:	e081      	b.n	c0d0085c <io_event+0x23c>
c0d00758:	68a8      	ldr	r0, [r5, #8]
c0d0075a:	1c46      	adds	r6, r0, #1
c0d0075c:	60ae      	str	r6, [r5, #8]
c0d0075e:	6828      	ldr	r0, [r5, #0]
c0d00760:	2800      	cmp	r0, #0
c0d00762:	d1e3      	bne.n	c0d0072c <io_event+0x10c>
c0d00764:	e0a3      	b.n	c0d008ae <io_event+0x28e>
c0d00766:	6928      	ldr	r0, [r5, #16]
c0d00768:	2800      	cmp	r0, #0
c0d0076a:	d100      	bne.n	c0d0076e <io_event+0x14e>
c0d0076c:	e09f      	b.n	c0d008ae <io_event+0x28e>
c0d0076e:	4a56      	ldr	r2, [pc, #344]	; (c0d008c8 <io_event+0x2a8>)
c0d00770:	4291      	cmp	r1, r2
c0d00772:	d100      	bne.n	c0d00776 <io_event+0x156>
c0d00774:	e09b      	b.n	c0d008ae <io_event+0x28e>
c0d00776:	2900      	cmp	r1, #0
c0d00778:	d100      	bne.n	c0d0077c <io_event+0x15c>
c0d0077a:	e098      	b.n	c0d008ae <io_event+0x28e>
c0d0077c:	4950      	ldr	r1, [pc, #320]	; (c0d008c0 <io_event+0x2a0>)
c0d0077e:	78c9      	ldrb	r1, [r1, #3]
c0d00780:	0849      	lsrs	r1, r1, #1
c0d00782:	f000 fe1b 	bl	c0d013bc <io_seproxyhal_button_push>
c0d00786:	e092      	b.n	c0d008ae <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00788:	6870      	ldr	r0, [r6, #4]
c0d0078a:	4285      	cmp	r5, r0
c0d0078c:	d300      	bcc.n	c0d00790 <io_event+0x170>
c0d0078e:	e08e      	b.n	c0d008ae <io_event+0x28e>
c0d00790:	f001 fb1c 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00794:	2800      	cmp	r0, #0
c0d00796:	d000      	beq.n	c0d0079a <io_event+0x17a>
c0d00798:	e089      	b.n	c0d008ae <io_event+0x28e>
c0d0079a:	68b0      	ldr	r0, [r6, #8]
c0d0079c:	68f1      	ldr	r1, [r6, #12]
c0d0079e:	2438      	movs	r4, #56	; 0x38
c0d007a0:	4360      	muls	r0, r4
c0d007a2:	6832      	ldr	r2, [r6, #0]
c0d007a4:	1810      	adds	r0, r2, r0
c0d007a6:	2900      	cmp	r1, #0
c0d007a8:	d076      	beq.n	c0d00898 <io_event+0x278>
c0d007aa:	4788      	blx	r1
c0d007ac:	2800      	cmp	r0, #0
c0d007ae:	d173      	bne.n	c0d00898 <io_event+0x278>
c0d007b0:	68b0      	ldr	r0, [r6, #8]
c0d007b2:	1c45      	adds	r5, r0, #1
c0d007b4:	60b5      	str	r5, [r6, #8]
c0d007b6:	6830      	ldr	r0, [r6, #0]
c0d007b8:	2800      	cmp	r0, #0
c0d007ba:	d1e5      	bne.n	c0d00788 <io_event+0x168>
c0d007bc:	e077      	b.n	c0d008ae <io_event+0x28e>
c0d007be:	88b0      	ldrh	r0, [r6, #4]
c0d007c0:	9004      	str	r0, [sp, #16]
c0d007c2:	6830      	ldr	r0, [r6, #0]
c0d007c4:	9003      	str	r0, [sp, #12]
c0d007c6:	483e      	ldr	r0, [pc, #248]	; (c0d008c0 <io_event+0x2a0>)
c0d007c8:	4601      	mov	r1, r0
c0d007ca:	79cc      	ldrb	r4, [r1, #7]
c0d007cc:	798b      	ldrb	r3, [r1, #6]
c0d007ce:	794d      	ldrb	r5, [r1, #5]
c0d007d0:	790a      	ldrb	r2, [r1, #4]
c0d007d2:	4630      	mov	r0, r6
c0d007d4:	78ce      	ldrb	r6, [r1, #3]
c0d007d6:	68c1      	ldr	r1, [r0, #12]
c0d007d8:	4668      	mov	r0, sp
c0d007da:	6006      	str	r6, [r0, #0]
c0d007dc:	6041      	str	r1, [r0, #4]
c0d007de:	0212      	lsls	r2, r2, #8
c0d007e0:	432a      	orrs	r2, r5
c0d007e2:	021b      	lsls	r3, r3, #8
c0d007e4:	4323      	orrs	r3, r4
c0d007e6:	9803      	ldr	r0, [sp, #12]
c0d007e8:	9904      	ldr	r1, [sp, #16]
c0d007ea:	f000 fcd5 	bl	c0d01198 <io_seproxyhal_touch_element_callback>
c0d007ee:	e05e      	b.n	c0d008ae <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d007f0:	6868      	ldr	r0, [r5, #4]
c0d007f2:	4286      	cmp	r6, r0
c0d007f4:	d25b      	bcs.n	c0d008ae <io_event+0x28e>
c0d007f6:	f001 fae9 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d007fa:	2800      	cmp	r0, #0
c0d007fc:	d157      	bne.n	c0d008ae <io_event+0x28e>
c0d007fe:	68a8      	ldr	r0, [r5, #8]
c0d00800:	68e9      	ldr	r1, [r5, #12]
c0d00802:	2438      	movs	r4, #56	; 0x38
c0d00804:	4360      	muls	r0, r4
c0d00806:	682a      	ldr	r2, [r5, #0]
c0d00808:	1810      	adds	r0, r2, r0
c0d0080a:	2900      	cmp	r1, #0
c0d0080c:	d026      	beq.n	c0d0085c <io_event+0x23c>
c0d0080e:	4788      	blx	r1
c0d00810:	2800      	cmp	r0, #0
c0d00812:	d123      	bne.n	c0d0085c <io_event+0x23c>
c0d00814:	68a8      	ldr	r0, [r5, #8]
c0d00816:	1c46      	adds	r6, r0, #1
c0d00818:	60ae      	str	r6, [r5, #8]
c0d0081a:	6828      	ldr	r0, [r5, #0]
c0d0081c:	2800      	cmp	r0, #0
c0d0081e:	d1e7      	bne.n	c0d007f0 <io_event+0x1d0>
c0d00820:	e045      	b.n	c0d008ae <io_event+0x28e>
c0d00822:	6828      	ldr	r0, [r5, #0]
c0d00824:	2800      	cmp	r0, #0
c0d00826:	d030      	beq.n	c0d0088a <io_event+0x26a>
c0d00828:	68a8      	ldr	r0, [r5, #8]
c0d0082a:	6869      	ldr	r1, [r5, #4]
c0d0082c:	4288      	cmp	r0, r1
c0d0082e:	d22c      	bcs.n	c0d0088a <io_event+0x26a>
c0d00830:	f001 facc 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00834:	2800      	cmp	r0, #0
c0d00836:	d128      	bne.n	c0d0088a <io_event+0x26a>
c0d00838:	68a8      	ldr	r0, [r5, #8]
c0d0083a:	68e9      	ldr	r1, [r5, #12]
c0d0083c:	2438      	movs	r4, #56	; 0x38
c0d0083e:	4360      	muls	r0, r4
c0d00840:	682a      	ldr	r2, [r5, #0]
c0d00842:	1810      	adds	r0, r2, r0
c0d00844:	2900      	cmp	r1, #0
c0d00846:	d015      	beq.n	c0d00874 <io_event+0x254>
c0d00848:	4788      	blx	r1
c0d0084a:	2800      	cmp	r0, #0
c0d0084c:	d112      	bne.n	c0d00874 <io_event+0x254>
c0d0084e:	68a8      	ldr	r0, [r5, #8]
c0d00850:	1c40      	adds	r0, r0, #1
c0d00852:	60a8      	str	r0, [r5, #8]
c0d00854:	6829      	ldr	r1, [r5, #0]
c0d00856:	2900      	cmp	r1, #0
c0d00858:	d1e7      	bne.n	c0d0082a <io_event+0x20a>
c0d0085a:	e016      	b.n	c0d0088a <io_event+0x26a>
c0d0085c:	2801      	cmp	r0, #1
c0d0085e:	d103      	bne.n	c0d00868 <io_event+0x248>
c0d00860:	68a8      	ldr	r0, [r5, #8]
c0d00862:	4344      	muls	r4, r0
c0d00864:	6828      	ldr	r0, [r5, #0]
c0d00866:	1900      	adds	r0, r0, r4
c0d00868:	f000 fd66 	bl	c0d01338 <io_seproxyhal_display_default>
c0d0086c:	68a8      	ldr	r0, [r5, #8]
c0d0086e:	1c40      	adds	r0, r0, #1
c0d00870:	60a8      	str	r0, [r5, #8]
c0d00872:	e01c      	b.n	c0d008ae <io_event+0x28e>
c0d00874:	2801      	cmp	r0, #1
c0d00876:	d103      	bne.n	c0d00880 <io_event+0x260>
c0d00878:	68a8      	ldr	r0, [r5, #8]
c0d0087a:	4344      	muls	r4, r0
c0d0087c:	6828      	ldr	r0, [r5, #0]
c0d0087e:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00880:	f000 fd5a 	bl	c0d01338 <io_seproxyhal_display_default>
c0d00884:	68a8      	ldr	r0, [r5, #8]
c0d00886:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00888:	60a8      	str	r0, [r5, #8]
c0d0088a:	6868      	ldr	r0, [r5, #4]
c0d0088c:	68a9      	ldr	r1, [r5, #8]
c0d0088e:	4281      	cmp	r1, r0
c0d00890:	d30d      	bcc.n	c0d008ae <io_event+0x28e>
c0d00892:	f001 fa9b 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00896:	e00a      	b.n	c0d008ae <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00898:	2801      	cmp	r0, #1
c0d0089a:	d103      	bne.n	c0d008a4 <io_event+0x284>
c0d0089c:	68b0      	ldr	r0, [r6, #8]
c0d0089e:	4344      	muls	r4, r0
c0d008a0:	6830      	ldr	r0, [r6, #0]
c0d008a2:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d008a4:	f000 fd48 	bl	c0d01338 <io_seproxyhal_display_default>
c0d008a8:	68b0      	ldr	r0, [r6, #8]
c0d008aa:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d008ac:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d008ae:	f001 fa8d 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d008b2:	2800      	cmp	r0, #0
c0d008b4:	d101      	bne.n	c0d008ba <io_event+0x29a>
        io_seproxyhal_general_status();
c0d008b6:	f000 fac9 	bl	c0d00e4c <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d008ba:	2001      	movs	r0, #1
c0d008bc:	b005      	add	sp, #20
c0d008be:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008c0:	20001a18 	.word	0x20001a18
c0d008c4:	20001a98 	.word	0x20001a98
c0d008c8:	b0105044 	.word	0xb0105044
c0d008cc:	b0105055 	.word	0xb0105055

c0d008d0 <IOTA_main>:





static void IOTA_main(void) {
c0d008d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008d2:	af03      	add	r7, sp, #12
c0d008d4:	b0dd      	sub	sp, #372	; 0x174
c0d008d6:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d008d8:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d008da:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d008dc:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d008de:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00b64 <IOTA_main+0x294>)
c0d008e0:	2110      	movs	r1, #16
c0d008e2:	2203      	movs	r2, #3
c0d008e4:	9109      	str	r1, [sp, #36]	; 0x24
c0d008e6:	9208      	str	r2, [sp, #32]
c0d008e8:	f7ff fbdc 	bl	c0d000a4 <write_debug>
c0d008ec:	a80e      	add	r0, sp, #56	; 0x38
c0d008ee:	304d      	adds	r0, #77	; 0x4d
c0d008f0:	9007      	str	r0, [sp, #28]
c0d008f2:	a80b      	add	r0, sp, #44	; 0x2c
c0d008f4:	1dc1      	adds	r1, r0, #7
c0d008f6:	9106      	str	r1, [sp, #24]
c0d008f8:	1d00      	adds	r0, r0, #4
c0d008fa:	9005      	str	r0, [sp, #20]
c0d008fc:	4e9d      	ldr	r6, [pc, #628]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d008fe:	6830      	ldr	r0, [r6, #0]
c0d00900:	e08d      	b.n	c0d00a1e <IOTA_main+0x14e>
c0d00902:	489f      	ldr	r0, [pc, #636]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d00904:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00906:	4330      	orrs	r0, r6
c0d00908:	2880      	cmp	r0, #128	; 0x80
c0d0090a:	d000      	beq.n	c0d0090e <IOTA_main+0x3e>
c0d0090c:	e11e      	b.n	c0d00b4c <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d0090e:	7810      	ldrb	r0, [r2, #0]
c0d00910:	2800      	cmp	r0, #0
c0d00912:	4e98      	ldr	r6, [pc, #608]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00914:	d004      	beq.n	c0d00920 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00916:	489c      	ldr	r0, [pc, #624]	; (c0d00b88 <IOTA_main+0x2b8>)
c0d00918:	f001 f90c 	bl	c0d01b34 <cx_sha256_init>
                        hashTainted = 0;
c0d0091c:	4899      	ldr	r0, [pc, #612]	; (c0d00b84 <IOTA_main+0x2b4>)
c0d0091e:	7004      	strb	r4, [r0, #0]
c0d00920:	4897      	ldr	r0, [pc, #604]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d00922:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00924:	7908      	ldrb	r0, [r1, #4]
c0d00926:	1808      	adds	r0, r1, r0
c0d00928:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d0092a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0092c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0092e:	4308      	orrs	r0, r1
c0d00930:	905a      	str	r0, [sp, #360]	; 0x168
c0d00932:	e0e5      	b.n	c0d00b00 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00934:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00936:	2818      	cmp	r0, #24
c0d00938:	d800      	bhi.n	c0d0093c <IOTA_main+0x6c>
c0d0093a:	e10c      	b.n	c0d00b56 <IOTA_main+0x286>
c0d0093c:	950a      	str	r5, [sp, #40]	; 0x28
c0d0093e:	4d90      	ldr	r5, [pc, #576]	; (c0d00b80 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00940:	00a0      	lsls	r0, r4, #2
c0d00942:	1829      	adds	r1, r5, r0
c0d00944:	794a      	ldrb	r2, [r1, #5]
c0d00946:	0612      	lsls	r2, r2, #24
c0d00948:	798b      	ldrb	r3, [r1, #6]
c0d0094a:	041b      	lsls	r3, r3, #16
c0d0094c:	4313      	orrs	r3, r2
c0d0094e:	79ca      	ldrb	r2, [r1, #7]
c0d00950:	0212      	lsls	r2, r2, #8
c0d00952:	431a      	orrs	r2, r3
c0d00954:	7a09      	ldrb	r1, [r1, #8]
c0d00956:	4311      	orrs	r1, r2
c0d00958:	aa2b      	add	r2, sp, #172	; 0xac
c0d0095a:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d0095c:	1c64      	adds	r4, r4, #1
c0d0095e:	2c05      	cmp	r4, #5
c0d00960:	d1ee      	bne.n	c0d00940 <IOTA_main+0x70>
c0d00962:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00964:	9103      	str	r1, [sp, #12]
c0d00966:	4668      	mov	r0, sp
c0d00968:	6001      	str	r1, [r0, #0]
c0d0096a:	2421      	movs	r4, #33	; 0x21
c0d0096c:	a92b      	add	r1, sp, #172	; 0xac
c0d0096e:	2205      	movs	r2, #5
c0d00970:	ad23      	add	r5, sp, #140	; 0x8c
c0d00972:	9502      	str	r5, [sp, #8]
c0d00974:	4620      	mov	r0, r4
c0d00976:	462b      	mov	r3, r5
c0d00978:	f001 f992 	bl	c0d01ca0 <os_perso_derive_node_bip32>
c0d0097c:	2220      	movs	r2, #32
c0d0097e:	9204      	str	r2, [sp, #16]
c0d00980:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00982:	9301      	str	r3, [sp, #4]
c0d00984:	4620      	mov	r0, r4
c0d00986:	4629      	mov	r1, r5
c0d00988:	f001 f94e 	bl	c0d01c28 <cx_ecfp_init_private_key>
c0d0098c:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d0098e:	4620      	mov	r0, r4
c0d00990:	9903      	ldr	r1, [sp, #12]
c0d00992:	460a      	mov	r2, r1
c0d00994:	462b      	mov	r3, r5
c0d00996:	f001 f929 	bl	c0d01bec <cx_ecfp_init_public_key>
c0d0099a:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d0099c:	4620      	mov	r0, r4
c0d0099e:	4629      	mov	r1, r5
c0d009a0:	9a01      	ldr	r2, [sp, #4]
c0d009a2:	f001 f95f 	bl	c0d01c64 <cx_ecfp_generate_pair>
c0d009a6:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d009a8:	9802      	ldr	r0, [sp, #8]
c0d009aa:	9904      	ldr	r1, [sp, #16]
c0d009ac:	4622      	mov	r2, r4
c0d009ae:	f7ff fc13 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d009b2:	2552      	movs	r5, #82	; 0x52
c0d009b4:	4872      	ldr	r0, [pc, #456]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d009b6:	4621      	mov	r1, r4
c0d009b8:	462a      	mov	r2, r5
c0d009ba:	f000 f9ad 	bl	c0d00d18 <os_memmove>
                    tx = 82;
c0d009be:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d009c0:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009c2:	1c41      	adds	r1, r0, #1
c0d009c4:	915b      	str	r1, [sp, #364]	; 0x16c
c0d009c6:	3610      	adds	r6, #16
c0d009c8:	4a6d      	ldr	r2, [pc, #436]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d009ca:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d009cc:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009ce:	1c41      	adds	r1, r0, #1
c0d009d0:	915b      	str	r1, [sp, #364]	; 0x16c
c0d009d2:	9903      	ldr	r1, [sp, #12]
c0d009d4:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d009d6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009d8:	b281      	uxth	r1, r0
c0d009da:	9804      	ldr	r0, [sp, #16]
c0d009dc:	f000 fd2a 	bl	c0d01434 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d009e0:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d009e2:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d009e4:	4308      	orrs	r0, r1
c0d009e6:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d009e8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d009ea:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d009ec:	202e      	movs	r0, #46	; 0x2e
c0d009ee:	9905      	ldr	r1, [sp, #20]
c0d009f0:	7048      	strb	r0, [r1, #1]
c0d009f2:	7008      	strb	r0, [r1, #0]
c0d009f4:	7088      	strb	r0, [r1, #2]
c0d009f6:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d009f8:	78c8      	ldrb	r0, [r1, #3]
c0d009fa:	9a06      	ldr	r2, [sp, #24]
c0d009fc:	70d0      	strb	r0, [r2, #3]
c0d009fe:	7888      	ldrb	r0, [r1, #2]
c0d00a00:	7090      	strb	r0, [r2, #2]
c0d00a02:	7848      	ldrb	r0, [r1, #1]
c0d00a04:	7050      	strb	r0, [r2, #1]
c0d00a06:	7808      	ldrb	r0, [r1, #0]
c0d00a08:	7010      	strb	r0, [r2, #0]
c0d00a0a:	7908      	ldrb	r0, [r1, #4]
c0d00a0c:	7110      	strb	r0, [r2, #4]
c0d00a0e:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00a10:	2140      	movs	r1, #64	; 0x40
c0d00a12:	2203      	movs	r2, #3
c0d00a14:	f001 fa8a 	bl	c0d01f2c <ui_display_debug>
c0d00a18:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00a1a:	4e56      	ldr	r6, [pc, #344]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00a1c:	e070      	b.n	c0d00b00 <IOTA_main+0x230>
c0d00a1e:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00a20:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00a22:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00a24:	ac4d      	add	r4, sp, #308	; 0x134
c0d00a26:	4620      	mov	r0, r4
c0d00a28:	f002 fc1c 	bl	c0d03264 <setjmp>
c0d00a2c:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00a2e:	6034      	str	r4, [r6, #0]
c0d00a30:	4951      	ldr	r1, [pc, #324]	; (c0d00b78 <IOTA_main+0x2a8>)
c0d00a32:	4208      	tst	r0, r1
c0d00a34:	d011      	beq.n	c0d00a5a <IOTA_main+0x18a>
c0d00a36:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00a38:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00a3a:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00a3c:	6031      	str	r1, [r6, #0]
c0d00a3e:	210f      	movs	r1, #15
c0d00a40:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00a42:	4001      	ands	r1, r0
c0d00a44:	2209      	movs	r2, #9
c0d00a46:	0312      	lsls	r2, r2, #12
c0d00a48:	4291      	cmp	r1, r2
c0d00a4a:	d003      	beq.n	c0d00a54 <IOTA_main+0x184>
c0d00a4c:	9a08      	ldr	r2, [sp, #32]
c0d00a4e:	0352      	lsls	r2, r2, #13
c0d00a50:	4291      	cmp	r1, r2
c0d00a52:	d142      	bne.n	c0d00ada <IOTA_main+0x20a>
c0d00a54:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00a56:	8008      	strh	r0, [r1, #0]
c0d00a58:	e046      	b.n	c0d00ae8 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00a5a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00a5c:	905c      	str	r0, [sp, #368]	; 0x170
c0d00a5e:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00a60:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00a62:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00a64:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00a66:	b2c0      	uxtb	r0, r0
c0d00a68:	b289      	uxth	r1, r1
c0d00a6a:	f000 fce3 	bl	c0d01434 <io_exchange>
c0d00a6e:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00a70:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00a72:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00a74:	2800      	cmp	r0, #0
c0d00a76:	d053      	beq.n	c0d00b20 <IOTA_main+0x250>
c0d00a78:	4941      	ldr	r1, [pc, #260]	; (c0d00b80 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00a7a:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00a7c:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00a7e:	2880      	cmp	r0, #128	; 0x80
c0d00a80:	4a40      	ldr	r2, [pc, #256]	; (c0d00b84 <IOTA_main+0x2b4>)
c0d00a82:	d155      	bne.n	c0d00b30 <IOTA_main+0x260>
c0d00a84:	7848      	ldrb	r0, [r1, #1]
c0d00a86:	216d      	movs	r1, #109	; 0x6d
c0d00a88:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00a8a:	2807      	cmp	r0, #7
c0d00a8c:	dc3f      	bgt.n	c0d00b0e <IOTA_main+0x23e>
c0d00a8e:	2802      	cmp	r0, #2
c0d00a90:	d100      	bne.n	c0d00a94 <IOTA_main+0x1c4>
c0d00a92:	e74f      	b.n	c0d00934 <IOTA_main+0x64>
c0d00a94:	2804      	cmp	r0, #4
c0d00a96:	d153      	bne.n	c0d00b40 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00a98:	210b      	movs	r1, #11
c0d00a9a:	2203      	movs	r2, #3
c0d00a9c:	a03c      	add	r0, pc, #240	; (adr r0, c0d00b90 <IOTA_main+0x2c0>)
c0d00a9e:	f7ff fb01 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00aa2:	2048      	movs	r0, #72	; 0x48
c0d00aa4:	4936      	ldr	r1, [pc, #216]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d00aa6:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00aa8:	2049      	movs	r0, #73	; 0x49
c0d00aaa:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00aac:	2021      	movs	r0, #33	; 0x21
c0d00aae:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00ab0:	3610      	adds	r6, #16
c0d00ab2:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00ab4:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00ab6:	2005      	movs	r0, #5
c0d00ab8:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00aba:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00abc:	b281      	uxth	r1, r0
c0d00abe:	2020      	movs	r0, #32
c0d00ac0:	f000 fcb8 	bl	c0d01434 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00ac4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00ac6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00ac8:	4308      	orrs	r0, r1
c0d00aca:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00acc:	4620      	mov	r0, r4
c0d00ace:	4621      	mov	r1, r4
c0d00ad0:	4622      	mov	r2, r4
c0d00ad2:	f001 fa2b 	bl	c0d01f2c <ui_display_debug>
c0d00ad6:	4e27      	ldr	r6, [pc, #156]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00ad8:	e012      	b.n	c0d00b00 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00ada:	4928      	ldr	r1, [pc, #160]	; (c0d00b7c <IOTA_main+0x2ac>)
c0d00adc:	4008      	ands	r0, r1
c0d00ade:	210d      	movs	r1, #13
c0d00ae0:	02c9      	lsls	r1, r1, #11
c0d00ae2:	4301      	orrs	r1, r0
c0d00ae4:	a859      	add	r0, sp, #356	; 0x164
c0d00ae6:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00ae8:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00aea:	0a00      	lsrs	r0, r0, #8
c0d00aec:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00aee:	4a24      	ldr	r2, [pc, #144]	; (c0d00b80 <IOTA_main+0x2b0>)
c0d00af0:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00af2:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00af4:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00af6:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00af8:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00afa:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00afc:	1c80      	adds	r0, r0, #2
c0d00afe:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00b00:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00b02:	6030      	str	r0, [r6, #0]
c0d00b04:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00b06:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00b08:	2900      	cmp	r1, #0
c0d00b0a:	d088      	beq.n	c0d00a1e <IOTA_main+0x14e>
c0d00b0c:	e006      	b.n	c0d00b1c <IOTA_main+0x24c>
c0d00b0e:	2808      	cmp	r0, #8
c0d00b10:	d100      	bne.n	c0d00b14 <IOTA_main+0x244>
c0d00b12:	e6f6      	b.n	c0d00902 <IOTA_main+0x32>
c0d00b14:	28ff      	cmp	r0, #255	; 0xff
c0d00b16:	d113      	bne.n	c0d00b40 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00b18:	b05d      	add	sp, #372	; 0x174
c0d00b1a:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00b1c:	f002 fbae 	bl	c0d0327c <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00b20:	2001      	movs	r0, #1
c0d00b22:	4918      	ldr	r1, [pc, #96]	; (c0d00b84 <IOTA_main+0x2b4>)
c0d00b24:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d00b26:	4813      	ldr	r0, [pc, #76]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00b28:	6800      	ldr	r0, [r0, #0]
c0d00b2a:	491c      	ldr	r1, [pc, #112]	; (c0d00b9c <IOTA_main+0x2cc>)
c0d00b2c:	f002 fba6 	bl	c0d0327c <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d00b30:	2001      	movs	r0, #1
c0d00b32:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d00b34:	480f      	ldr	r0, [pc, #60]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00b36:	6800      	ldr	r0, [r0, #0]
c0d00b38:	2137      	movs	r1, #55	; 0x37
c0d00b3a:	0249      	lsls	r1, r1, #9
c0d00b3c:	f002 fb9e 	bl	c0d0327c <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d00b40:	2001      	movs	r0, #1
c0d00b42:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00b44:	480b      	ldr	r0, [pc, #44]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00b46:	6800      	ldr	r0, [r0, #0]
c0d00b48:	f002 fb98 	bl	c0d0327c <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00b4c:	4809      	ldr	r0, [pc, #36]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00b4e:	6800      	ldr	r0, [r0, #0]
c0d00b50:	490e      	ldr	r1, [pc, #56]	; (c0d00b8c <IOTA_main+0x2bc>)
c0d00b52:	f002 fb93 	bl	c0d0327c <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00b56:	2001      	movs	r0, #1
c0d00b58:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00b5a:	4806      	ldr	r0, [pc, #24]	; (c0d00b74 <IOTA_main+0x2a4>)
c0d00b5c:	6800      	ldr	r0, [r0, #0]
c0d00b5e:	3109      	adds	r1, #9
c0d00b60:	f002 fb8c 	bl	c0d0327c <longjmp>
c0d00b64:	74696157 	.word	0x74696157
c0d00b68:	20676e69 	.word	0x20676e69
c0d00b6c:	20726f66 	.word	0x20726f66
c0d00b70:	0067736d 	.word	0x0067736d
c0d00b74:	20001bb8 	.word	0x20001bb8
c0d00b78:	0000ffff 	.word	0x0000ffff
c0d00b7c:	000007ff 	.word	0x000007ff
c0d00b80:	20001c08 	.word	0x20001c08
c0d00b84:	20001b48 	.word	0x20001b48
c0d00b88:	20001b4c 	.word	0x20001b4c
c0d00b8c:	00006a86 	.word	0x00006a86
c0d00b90:	20646142 	.word	0x20646142
c0d00b94:	6b627550 	.word	0x6b627550
c0d00b98:	00007965 	.word	0x00007965
c0d00b9c:	00006982 	.word	0x00006982

c0d00ba0 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00ba0:	4801      	ldr	r0, [pc, #4]	; (c0d00ba8 <os_boot+0x8>)
c0d00ba2:	2100      	movs	r1, #0
c0d00ba4:	6001      	str	r1, [r0, #0]
}
c0d00ba6:	4770      	bx	lr
c0d00ba8:	20001bb8 	.word	0x20001bb8

c0d00bac <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00bac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bae:	af03      	add	r7, sp, #12
c0d00bb0:	b083      	sub	sp, #12
c0d00bb2:	9202      	str	r2, [sp, #8]
c0d00bb4:	460c      	mov	r4, r1
c0d00bb6:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00bb8:	4d4a      	ldr	r5, [pc, #296]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
c0d00bba:	42ac      	cmp	r4, r5
c0d00bbc:	d00f      	beq.n	c0d00bde <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00bbe:	4e49      	ldr	r6, [pc, #292]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
c0d00bc0:	2540      	movs	r5, #64	; 0x40
c0d00bc2:	4630      	mov	r0, r6
c0d00bc4:	4629      	mov	r1, r5
c0d00bc6:	f002 fab7 	bl	c0d03138 <__aeabi_memclr>
c0d00bca:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00bcc:	2840      	cmp	r0, #64	; 0x40
c0d00bce:	4602      	mov	r2, r0
c0d00bd0:	d300      	bcc.n	c0d00bd4 <io_usb_hid_receive+0x28>
c0d00bd2:	462a      	mov	r2, r5
c0d00bd4:	4630      	mov	r0, r6
c0d00bd6:	4621      	mov	r1, r4
c0d00bd8:	f000 f89e 	bl	c0d00d18 <os_memmove>
c0d00bdc:	4d41      	ldr	r5, [pc, #260]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00bde:	78a8      	ldrb	r0, [r5, #2]
c0d00be0:	2805      	cmp	r0, #5
c0d00be2:	d900      	bls.n	c0d00be6 <io_usb_hid_receive+0x3a>
c0d00be4:	e076      	b.n	c0d00cd4 <io_usb_hid_receive+0x128>
c0d00be6:	46c0      	nop			; (mov r8, r8)
c0d00be8:	4478      	add	r0, pc
c0d00bea:	7900      	ldrb	r0, [r0, #4]
c0d00bec:	0040      	lsls	r0, r0, #1
c0d00bee:	4487      	add	pc, r0
c0d00bf0:	71130c02 	.word	0x71130c02
c0d00bf4:	1f71      	.short	0x1f71
c0d00bf6:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00bf8:	71ae      	strb	r6, [r5, #6]
c0d00bfa:	716e      	strb	r6, [r5, #5]
c0d00bfc:	712e      	strb	r6, [r5, #4]
c0d00bfe:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c00:	2140      	movs	r1, #64	; 0x40
c0d00c02:	4628      	mov	r0, r5
c0d00c04:	9a01      	ldr	r2, [sp, #4]
c0d00c06:	4790      	blx	r2
c0d00c08:	e00b      	b.n	c0d00c22 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00c0a:	1ce8      	adds	r0, r5, #3
c0d00c0c:	2104      	movs	r1, #4
c0d00c0e:	f000 ff73 	bl	c0d01af8 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c12:	2140      	movs	r1, #64	; 0x40
c0d00c14:	4628      	mov	r0, r5
c0d00c16:	e001      	b.n	c0d00c1c <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00c18:	4832      	ldr	r0, [pc, #200]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
c0d00c1a:	2140      	movs	r1, #64	; 0x40
c0d00c1c:	9a01      	ldr	r2, [sp, #4]
c0d00c1e:	4790      	blx	r2
c0d00c20:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00c22:	4831      	ldr	r0, [pc, #196]	; (c0d00ce8 <io_usb_hid_receive+0x13c>)
c0d00c24:	2100      	movs	r1, #0
c0d00c26:	6001      	str	r1, [r0, #0]
c0d00c28:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00c2a:	b2c0      	uxtb	r0, r0
c0d00c2c:	b003      	add	sp, #12
c0d00c2e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00c30:	78e8      	ldrb	r0, [r5, #3]
c0d00c32:	4c2d      	ldr	r4, [pc, #180]	; (c0d00ce8 <io_usb_hid_receive+0x13c>)
c0d00c34:	6821      	ldr	r1, [r4, #0]
c0d00c36:	0a09      	lsrs	r1, r1, #8
c0d00c38:	2600      	movs	r6, #0
c0d00c3a:	4288      	cmp	r0, r1
c0d00c3c:	d1f1      	bne.n	c0d00c22 <io_usb_hid_receive+0x76>
c0d00c3e:	7928      	ldrb	r0, [r5, #4]
c0d00c40:	6821      	ldr	r1, [r4, #0]
c0d00c42:	b2c9      	uxtb	r1, r1
c0d00c44:	4288      	cmp	r0, r1
c0d00c46:	d1ec      	bne.n	c0d00c22 <io_usb_hid_receive+0x76>
c0d00c48:	4b28      	ldr	r3, [pc, #160]	; (c0d00cec <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00c4a:	9802      	ldr	r0, [sp, #8]
c0d00c4c:	18c0      	adds	r0, r0, r3
c0d00c4e:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00c50:	6820      	ldr	r0, [r4, #0]
c0d00c52:	2800      	cmp	r0, #0
c0d00c54:	d00e      	beq.n	c0d00c74 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00c56:	4629      	mov	r1, r5
c0d00c58:	4019      	ands	r1, r3
c0d00c5a:	4825      	ldr	r0, [pc, #148]	; (c0d00cf0 <io_usb_hid_receive+0x144>)
c0d00c5c:	6802      	ldr	r2, [r0, #0]
c0d00c5e:	4291      	cmp	r1, r2
c0d00c60:	461e      	mov	r6, r3
c0d00c62:	d900      	bls.n	c0d00c66 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00c64:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00c66:	462a      	mov	r2, r5
c0d00c68:	4032      	ands	r2, r6
c0d00c6a:	4822      	ldr	r0, [pc, #136]	; (c0d00cf4 <io_usb_hid_receive+0x148>)
c0d00c6c:	6800      	ldr	r0, [r0, #0]
c0d00c6e:	491d      	ldr	r1, [pc, #116]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
c0d00c70:	1d49      	adds	r1, r1, #5
c0d00c72:	e021      	b.n	c0d00cb8 <io_usb_hid_receive+0x10c>
c0d00c74:	9301      	str	r3, [sp, #4]
c0d00c76:	491b      	ldr	r1, [pc, #108]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00c78:	7988      	ldrb	r0, [r1, #6]
c0d00c7a:	7949      	ldrb	r1, [r1, #5]
c0d00c7c:	0209      	lsls	r1, r1, #8
c0d00c7e:	4301      	orrs	r1, r0
c0d00c80:	481d      	ldr	r0, [pc, #116]	; (c0d00cf8 <io_usb_hid_receive+0x14c>)
c0d00c82:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00c84:	6801      	ldr	r1, [r0, #0]
c0d00c86:	2241      	movs	r2, #65	; 0x41
c0d00c88:	0092      	lsls	r2, r2, #2
c0d00c8a:	4291      	cmp	r1, r2
c0d00c8c:	d8c9      	bhi.n	c0d00c22 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00c8e:	6801      	ldr	r1, [r0, #0]
c0d00c90:	4817      	ldr	r0, [pc, #92]	; (c0d00cf0 <io_usb_hid_receive+0x144>)
c0d00c92:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00c94:	4917      	ldr	r1, [pc, #92]	; (c0d00cf4 <io_usb_hid_receive+0x148>)
c0d00c96:	4a19      	ldr	r2, [pc, #100]	; (c0d00cfc <io_usb_hid_receive+0x150>)
c0d00c98:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00c9a:	4919      	ldr	r1, [pc, #100]	; (c0d00d00 <io_usb_hid_receive+0x154>)
c0d00c9c:	9a02      	ldr	r2, [sp, #8]
c0d00c9e:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00ca0:	4629      	mov	r1, r5
c0d00ca2:	9e01      	ldr	r6, [sp, #4]
c0d00ca4:	4031      	ands	r1, r6
c0d00ca6:	6802      	ldr	r2, [r0, #0]
c0d00ca8:	4291      	cmp	r1, r2
c0d00caa:	d900      	bls.n	c0d00cae <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00cac:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00cae:	462a      	mov	r2, r5
c0d00cb0:	4032      	ands	r2, r6
c0d00cb2:	480c      	ldr	r0, [pc, #48]	; (c0d00ce4 <io_usb_hid_receive+0x138>)
c0d00cb4:	1dc1      	adds	r1, r0, #7
c0d00cb6:	4811      	ldr	r0, [pc, #68]	; (c0d00cfc <io_usb_hid_receive+0x150>)
c0d00cb8:	f000 f82e 	bl	c0d00d18 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00cbc:	4035      	ands	r5, r6
c0d00cbe:	480d      	ldr	r0, [pc, #52]	; (c0d00cf4 <io_usb_hid_receive+0x148>)
c0d00cc0:	6801      	ldr	r1, [r0, #0]
c0d00cc2:	1949      	adds	r1, r1, r5
c0d00cc4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00cc6:	480a      	ldr	r0, [pc, #40]	; (c0d00cf0 <io_usb_hid_receive+0x144>)
c0d00cc8:	6801      	ldr	r1, [r0, #0]
c0d00cca:	1b49      	subs	r1, r1, r5
c0d00ccc:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00cce:	6820      	ldr	r0, [r4, #0]
c0d00cd0:	1c40      	adds	r0, r0, #1
c0d00cd2:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00cd4:	4806      	ldr	r0, [pc, #24]	; (c0d00cf0 <io_usb_hid_receive+0x144>)
c0d00cd6:	6801      	ldr	r1, [r0, #0]
c0d00cd8:	2001      	movs	r0, #1
c0d00cda:	2602      	movs	r6, #2
c0d00cdc:	2900      	cmp	r1, #0
c0d00cde:	d1a4      	bne.n	c0d00c2a <io_usb_hid_receive+0x7e>
c0d00ce0:	e79f      	b.n	c0d00c22 <io_usb_hid_receive+0x76>
c0d00ce2:	46c0      	nop			; (mov r8, r8)
c0d00ce4:	20001bbc 	.word	0x20001bbc
c0d00ce8:	20001bfc 	.word	0x20001bfc
c0d00cec:	0000ffff 	.word	0x0000ffff
c0d00cf0:	20001c04 	.word	0x20001c04
c0d00cf4:	20001d0c 	.word	0x20001d0c
c0d00cf8:	20001c00 	.word	0x20001c00
c0d00cfc:	20001c08 	.word	0x20001c08
c0d00d00:	0001fff9 	.word	0x0001fff9

c0d00d04 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00d04:	b580      	push	{r7, lr}
c0d00d06:	af00      	add	r7, sp, #0
c0d00d08:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00d0a:	2a00      	cmp	r2, #0
c0d00d0c:	d003      	beq.n	c0d00d16 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00d0e:	4611      	mov	r1, r2
c0d00d10:	461a      	mov	r2, r3
c0d00d12:	f002 fa1b 	bl	c0d0314c <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00d16:	bd80      	pop	{r7, pc}

c0d00d18 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00d18:	b5b0      	push	{r4, r5, r7, lr}
c0d00d1a:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00d1c:	4288      	cmp	r0, r1
c0d00d1e:	d90d      	bls.n	c0d00d3c <os_memmove+0x24>
    while(length--) {
c0d00d20:	2a00      	cmp	r2, #0
c0d00d22:	d014      	beq.n	c0d00d4e <os_memmove+0x36>
c0d00d24:	1e49      	subs	r1, r1, #1
c0d00d26:	4252      	negs	r2, r2
c0d00d28:	1e40      	subs	r0, r0, #1
c0d00d2a:	2300      	movs	r3, #0
c0d00d2c:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00d2e:	461c      	mov	r4, r3
c0d00d30:	4354      	muls	r4, r2
c0d00d32:	5d0d      	ldrb	r5, [r1, r4]
c0d00d34:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00d36:	1c52      	adds	r2, r2, #1
c0d00d38:	d1f9      	bne.n	c0d00d2e <os_memmove+0x16>
c0d00d3a:	e008      	b.n	c0d00d4e <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00d3c:	2a00      	cmp	r2, #0
c0d00d3e:	d006      	beq.n	c0d00d4e <os_memmove+0x36>
c0d00d40:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00d42:	b29c      	uxth	r4, r3
c0d00d44:	5d0d      	ldrb	r5, [r1, r4]
c0d00d46:	5505      	strb	r5, [r0, r4]
      l++;
c0d00d48:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00d4a:	1e52      	subs	r2, r2, #1
c0d00d4c:	d1f9      	bne.n	c0d00d42 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00d4e:	bdb0      	pop	{r4, r5, r7, pc}

c0d00d50 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00d50:	4801      	ldr	r0, [pc, #4]	; (c0d00d58 <io_usb_hid_init+0x8>)
c0d00d52:	2100      	movs	r1, #0
c0d00d54:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00d56:	4770      	bx	lr
c0d00d58:	20001bfc 	.word	0x20001bfc

c0d00d5c <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00d5c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d5e:	af03      	add	r7, sp, #12
c0d00d60:	b087      	sub	sp, #28
c0d00d62:	9301      	str	r3, [sp, #4]
c0d00d64:	9203      	str	r2, [sp, #12]
c0d00d66:	460e      	mov	r6, r1
c0d00d68:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00d6a:	2e00      	cmp	r6, #0
c0d00d6c:	d042      	beq.n	c0d00df4 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00d6e:	4d31      	ldr	r5, [pc, #196]	; (c0d00e34 <io_usb_hid_exchange+0xd8>)
c0d00d70:	2000      	movs	r0, #0
c0d00d72:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00d74:	4930      	ldr	r1, [pc, #192]	; (c0d00e38 <io_usb_hid_exchange+0xdc>)
c0d00d76:	4831      	ldr	r0, [pc, #196]	; (c0d00e3c <io_usb_hid_exchange+0xe0>)
c0d00d78:	6008      	str	r0, [r1, #0]
c0d00d7a:	4c31      	ldr	r4, [pc, #196]	; (c0d00e40 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00d7c:	1d60      	adds	r0, r4, #5
c0d00d7e:	213b      	movs	r1, #59	; 0x3b
c0d00d80:	9005      	str	r0, [sp, #20]
c0d00d82:	9102      	str	r1, [sp, #8]
c0d00d84:	f002 f9d8 	bl	c0d03138 <__aeabi_memclr>
c0d00d88:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00d8a:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00d8c:	6828      	ldr	r0, [r5, #0]
c0d00d8e:	0a00      	lsrs	r0, r0, #8
c0d00d90:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00d92:	6828      	ldr	r0, [r5, #0]
c0d00d94:	7120      	strb	r0, [r4, #4]
c0d00d96:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00d98:	6828      	ldr	r0, [r5, #0]
c0d00d9a:	2800      	cmp	r0, #0
c0d00d9c:	9106      	str	r1, [sp, #24]
c0d00d9e:	d009      	beq.n	c0d00db4 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00da0:	293b      	cmp	r1, #59	; 0x3b
c0d00da2:	460a      	mov	r2, r1
c0d00da4:	d300      	bcc.n	c0d00da8 <io_usb_hid_exchange+0x4c>
c0d00da6:	9a02      	ldr	r2, [sp, #8]
c0d00da8:	4823      	ldr	r0, [pc, #140]	; (c0d00e38 <io_usb_hid_exchange+0xdc>)
c0d00daa:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00dac:	6819      	ldr	r1, [r3, #0]
c0d00dae:	9805      	ldr	r0, [sp, #20]
c0d00db0:	461e      	mov	r6, r3
c0d00db2:	e00a      	b.n	c0d00dca <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00db4:	0a30      	lsrs	r0, r6, #8
c0d00db6:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00db8:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00dba:	2039      	movs	r0, #57	; 0x39
c0d00dbc:	2939      	cmp	r1, #57	; 0x39
c0d00dbe:	460a      	mov	r2, r1
c0d00dc0:	d300      	bcc.n	c0d00dc4 <io_usb_hid_exchange+0x68>
c0d00dc2:	4602      	mov	r2, r0
c0d00dc4:	4e1c      	ldr	r6, [pc, #112]	; (c0d00e38 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00dc6:	6831      	ldr	r1, [r6, #0]
c0d00dc8:	1de0      	adds	r0, r4, #7
c0d00dca:	9205      	str	r2, [sp, #20]
c0d00dcc:	f7ff ffa4 	bl	c0d00d18 <os_memmove>
c0d00dd0:	4d18      	ldr	r5, [pc, #96]	; (c0d00e34 <io_usb_hid_exchange+0xd8>)
c0d00dd2:	6830      	ldr	r0, [r6, #0]
c0d00dd4:	4631      	mov	r1, r6
c0d00dd6:	9e05      	ldr	r6, [sp, #20]
c0d00dd8:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00dda:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00ddc:	6828      	ldr	r0, [r5, #0]
c0d00dde:	1c40      	adds	r0, r0, #1
c0d00de0:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00de2:	2140      	movs	r1, #64	; 0x40
c0d00de4:	4620      	mov	r0, r4
c0d00de6:	9a04      	ldr	r2, [sp, #16]
c0d00de8:	4790      	blx	r2
c0d00dea:	9806      	ldr	r0, [sp, #24]
c0d00dec:	1b86      	subs	r6, r0, r6
c0d00dee:	4815      	ldr	r0, [pc, #84]	; (c0d00e44 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00df0:	4206      	tst	r6, r0
c0d00df2:	d1c3      	bne.n	c0d00d7c <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00df4:	480f      	ldr	r0, [pc, #60]	; (c0d00e34 <io_usb_hid_exchange+0xd8>)
c0d00df6:	2400      	movs	r4, #0
c0d00df8:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00dfa:	2080      	movs	r0, #128	; 0x80
c0d00dfc:	9901      	ldr	r1, [sp, #4]
c0d00dfe:	4201      	tst	r1, r0
c0d00e00:	d001      	beq.n	c0d00e06 <io_usb_hid_exchange+0xaa>
    reset();
c0d00e02:	f000 fe3f 	bl	c0d01a84 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00e06:	9801      	ldr	r0, [sp, #4]
c0d00e08:	0680      	lsls	r0, r0, #26
c0d00e0a:	d40f      	bmi.n	c0d00e2c <io_usb_hid_exchange+0xd0>
c0d00e0c:	4c0c      	ldr	r4, [pc, #48]	; (c0d00e40 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00e0e:	2140      	movs	r1, #64	; 0x40
c0d00e10:	4620      	mov	r0, r4
c0d00e12:	9a03      	ldr	r2, [sp, #12]
c0d00e14:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00e16:	b2c2      	uxtb	r2, r0
c0d00e18:	2a40      	cmp	r2, #64	; 0x40
c0d00e1a:	d8f8      	bhi.n	c0d00e0e <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00e1c:	9804      	ldr	r0, [sp, #16]
c0d00e1e:	4621      	mov	r1, r4
c0d00e20:	f7ff fec4 	bl	c0d00bac <io_usb_hid_receive>
c0d00e24:	2802      	cmp	r0, #2
c0d00e26:	d1f2      	bne.n	c0d00e0e <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00e28:	4807      	ldr	r0, [pc, #28]	; (c0d00e48 <io_usb_hid_exchange+0xec>)
c0d00e2a:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00e2c:	b2a0      	uxth	r0, r4
c0d00e2e:	b007      	add	sp, #28
c0d00e30:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e32:	46c0      	nop			; (mov r8, r8)
c0d00e34:	20001bfc 	.word	0x20001bfc
c0d00e38:	20001d0c 	.word	0x20001d0c
c0d00e3c:	20001c08 	.word	0x20001c08
c0d00e40:	20001bbc 	.word	0x20001bbc
c0d00e44:	0000ffff 	.word	0x0000ffff
c0d00e48:	20001c00 	.word	0x20001c00

c0d00e4c <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00e4c:	b580      	push	{r7, lr}
c0d00e4e:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00e50:	f000 ffbc 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00e54:	2800      	cmp	r0, #0
c0d00e56:	d10b      	bne.n	c0d00e70 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00e58:	4806      	ldr	r0, [pc, #24]	; (c0d00e74 <io_seproxyhal_general_status+0x28>)
c0d00e5a:	2160      	movs	r1, #96	; 0x60
c0d00e5c:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00e5e:	2100      	movs	r1, #0
c0d00e60:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00e62:	2202      	movs	r2, #2
c0d00e64:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00e66:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00e68:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00e6a:	2105      	movs	r1, #5
c0d00e6c:	f000 ff90 	bl	c0d01d90 <io_seproxyhal_spi_send>
}
c0d00e70:	bd80      	pop	{r7, pc}
c0d00e72:	46c0      	nop			; (mov r8, r8)
c0d00e74:	20001a18 	.word	0x20001a18

c0d00e78 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00e78:	b5d0      	push	{r4, r6, r7, lr}
c0d00e7a:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00e7c:	4815      	ldr	r0, [pc, #84]	; (c0d00ed4 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00e7e:	78c0      	ldrb	r0, [r0, #3]
c0d00e80:	1e40      	subs	r0, r0, #1
c0d00e82:	2807      	cmp	r0, #7
c0d00e84:	d824      	bhi.n	c0d00ed0 <io_seproxyhal_handle_usb_event+0x58>
c0d00e86:	46c0      	nop			; (mov r8, r8)
c0d00e88:	4478      	add	r0, pc
c0d00e8a:	7900      	ldrb	r0, [r0, #4]
c0d00e8c:	0040      	lsls	r0, r0, #1
c0d00e8e:	4487      	add	pc, r0
c0d00e90:	141f1803 	.word	0x141f1803
c0d00e94:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00e98:	4c0f      	ldr	r4, [pc, #60]	; (c0d00ed8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00e9a:	2101      	movs	r1, #1
c0d00e9c:	4620      	mov	r0, r4
c0d00e9e:	f001 fbd5 	bl	c0d0264c <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00ea2:	4620      	mov	r0, r4
c0d00ea4:	f001 fbba 	bl	c0d0261c <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00ea8:	480c      	ldr	r0, [pc, #48]	; (c0d00edc <io_seproxyhal_handle_usb_event+0x64>)
c0d00eaa:	7800      	ldrb	r0, [r0, #0]
c0d00eac:	2801      	cmp	r0, #1
c0d00eae:	d10f      	bne.n	c0d00ed0 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00eb0:	480b      	ldr	r0, [pc, #44]	; (c0d00ee0 <io_seproxyhal_handle_usb_event+0x68>)
c0d00eb2:	6800      	ldr	r0, [r0, #0]
c0d00eb4:	2110      	movs	r1, #16
c0d00eb6:	f002 f9e1 	bl	c0d0327c <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00eba:	4807      	ldr	r0, [pc, #28]	; (c0d00ed8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ebc:	f001 fbc9 	bl	c0d02652 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00ec0:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00ec2:	4805      	ldr	r0, [pc, #20]	; (c0d00ed8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ec4:	f001 fbc9 	bl	c0d0265a <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00ec8:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00eca:	4803      	ldr	r0, [pc, #12]	; (c0d00ed8 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ecc:	f001 fbc3 	bl	c0d02656 <USBD_LL_Resume>
      break;
  }
}
c0d00ed0:	bdd0      	pop	{r4, r6, r7, pc}
c0d00ed2:	46c0      	nop			; (mov r8, r8)
c0d00ed4:	20001a18 	.word	0x20001a18
c0d00ed8:	20001d34 	.word	0x20001d34
c0d00edc:	20001d10 	.word	0x20001d10
c0d00ee0:	20001bb8 	.word	0x20001bb8

c0d00ee4 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00ee4:	217f      	movs	r1, #127	; 0x7f
c0d00ee6:	4001      	ands	r1, r0
c0d00ee8:	4801      	ldr	r0, [pc, #4]	; (c0d00ef0 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00eea:	5c40      	ldrb	r0, [r0, r1]
c0d00eec:	4770      	bx	lr
c0d00eee:	46c0      	nop			; (mov r8, r8)
c0d00ef0:	20001d11 	.word	0x20001d11

c0d00ef4 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00ef4:	b580      	push	{r7, lr}
c0d00ef6:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00ef8:	480f      	ldr	r0, [pc, #60]	; (c0d00f38 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00efa:	7901      	ldrb	r1, [r0, #4]
c0d00efc:	2904      	cmp	r1, #4
c0d00efe:	d008      	beq.n	c0d00f12 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00f00:	2902      	cmp	r1, #2
c0d00f02:	d011      	beq.n	c0d00f28 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00f04:	2901      	cmp	r1, #1
c0d00f06:	d10e      	bne.n	c0d00f26 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00f08:	1d81      	adds	r1, r0, #6
c0d00f0a:	480d      	ldr	r0, [pc, #52]	; (c0d00f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f0c:	f001 faaa 	bl	c0d02464 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00f10:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00f12:	78c2      	ldrb	r2, [r0, #3]
c0d00f14:	217f      	movs	r1, #127	; 0x7f
c0d00f16:	4011      	ands	r1, r2
c0d00f18:	7942      	ldrb	r2, [r0, #5]
c0d00f1a:	4b08      	ldr	r3, [pc, #32]	; (c0d00f3c <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00f1c:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00f1e:	1d82      	adds	r2, r0, #6
c0d00f20:	4807      	ldr	r0, [pc, #28]	; (c0d00f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f22:	f001 fad1 	bl	c0d024c8 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00f26:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00f28:	78c2      	ldrb	r2, [r0, #3]
c0d00f2a:	217f      	movs	r1, #127	; 0x7f
c0d00f2c:	4011      	ands	r1, r2
c0d00f2e:	1d82      	adds	r2, r0, #6
c0d00f30:	4803      	ldr	r0, [pc, #12]	; (c0d00f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00f32:	f001 fb0f 	bl	c0d02554 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00f36:	bd80      	pop	{r7, pc}
c0d00f38:	20001a18 	.word	0x20001a18
c0d00f3c:	20001d11 	.word	0x20001d11
c0d00f40:	20001d34 	.word	0x20001d34

c0d00f44 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00f44:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f46:	af03      	add	r7, sp, #12
c0d00f48:	b083      	sub	sp, #12
c0d00f4a:	9201      	str	r2, [sp, #4]
c0d00f4c:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00f4e:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00f50:	2b00      	cmp	r3, #0
c0d00f52:	d100      	bne.n	c0d00f56 <io_usb_send_ep+0x12>
c0d00f54:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00f56:	9801      	ldr	r0, [sp, #4]
c0d00f58:	28ff      	cmp	r0, #255	; 0xff
c0d00f5a:	d843      	bhi.n	c0d00fe4 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00f5c:	4e25      	ldr	r6, [pc, #148]	; (c0d00ff4 <io_usb_send_ep+0xb0>)
c0d00f5e:	2050      	movs	r0, #80	; 0x50
c0d00f60:	7030      	strb	r0, [r6, #0]
c0d00f62:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00f64:	1ce0      	adds	r0, r4, #3
c0d00f66:	9100      	str	r1, [sp, #0]
c0d00f68:	0a01      	lsrs	r1, r0, #8
c0d00f6a:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00f6c:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00f6e:	2080      	movs	r0, #128	; 0x80
c0d00f70:	4302      	orrs	r2, r0
c0d00f72:	9202      	str	r2, [sp, #8]
c0d00f74:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00f76:	2020      	movs	r0, #32
c0d00f78:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00f7a:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00f7c:	2106      	movs	r1, #6
c0d00f7e:	4630      	mov	r0, r6
c0d00f80:	f000 ff06 	bl	c0d01d90 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00f84:	9800      	ldr	r0, [sp, #0]
c0d00f86:	4621      	mov	r1, r4
c0d00f88:	f000 ff02 	bl	c0d01d90 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00f8c:	2d00      	cmp	r5, #0
c0d00f8e:	d10d      	bne.n	c0d00fac <io_usb_send_ep+0x68>
c0d00f90:	e028      	b.n	c0d00fe4 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00f92:	2d00      	cmp	r5, #0
c0d00f94:	d002      	beq.n	c0d00f9c <io_usb_send_ep+0x58>
c0d00f96:	1e6c      	subs	r4, r5, #1
c0d00f98:	2d01      	cmp	r5, #1
c0d00f9a:	d025      	beq.n	c0d00fe8 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00f9c:	2915      	cmp	r1, #21
c0d00f9e:	d102      	bne.n	c0d00fa6 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00fa0:	79b0      	ldrb	r0, [r6, #6]
c0d00fa2:	0700      	lsls	r0, r0, #28
c0d00fa4:	d520      	bpl.n	c0d00fe8 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00fa6:	f000 f829 	bl	c0d00ffc <io_seproxyhal_handle_event>
c0d00faa:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00fac:	f000 ff0e 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d00fb0:	2800      	cmp	r0, #0
c0d00fb2:	d101      	bne.n	c0d00fb8 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00fb4:	f7ff ff4a 	bl	c0d00e4c <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00fb8:	2180      	movs	r1, #128	; 0x80
c0d00fba:	2400      	movs	r4, #0
c0d00fbc:	4630      	mov	r0, r6
c0d00fbe:	4622      	mov	r2, r4
c0d00fc0:	f000 ff20 	bl	c0d01e04 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00fc4:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00fc6:	2806      	cmp	r0, #6
c0d00fc8:	d1e3      	bne.n	c0d00f92 <io_usb_send_ep+0x4e>
c0d00fca:	2910      	cmp	r1, #16
c0d00fcc:	d1e1      	bne.n	c0d00f92 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00fce:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00fd0:	9a02      	ldr	r2, [sp, #8]
c0d00fd2:	4290      	cmp	r0, r2
c0d00fd4:	d1dd      	bne.n	c0d00f92 <io_usb_send_ep+0x4e>
c0d00fd6:	7930      	ldrb	r0, [r6, #4]
c0d00fd8:	2802      	cmp	r0, #2
c0d00fda:	d1da      	bne.n	c0d00f92 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00fdc:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00fde:	9a01      	ldr	r2, [sp, #4]
c0d00fe0:	4290      	cmp	r0, r2
c0d00fe2:	d1d6      	bne.n	c0d00f92 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00fe4:	b003      	add	sp, #12
c0d00fe6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00fe8:	4803      	ldr	r0, [pc, #12]	; (c0d00ff8 <io_usb_send_ep+0xb4>)
c0d00fea:	6800      	ldr	r0, [r0, #0]
c0d00fec:	2110      	movs	r1, #16
c0d00fee:	f002 f945 	bl	c0d0327c <longjmp>
c0d00ff2:	46c0      	nop			; (mov r8, r8)
c0d00ff4:	20001a18 	.word	0x20001a18
c0d00ff8:	20001bb8 	.word	0x20001bb8

c0d00ffc <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00ffc:	b580      	push	{r7, lr}
c0d00ffe:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01000:	480d      	ldr	r0, [pc, #52]	; (c0d01038 <io_seproxyhal_handle_event+0x3c>)
c0d01002:	7882      	ldrb	r2, [r0, #2]
c0d01004:	7841      	ldrb	r1, [r0, #1]
c0d01006:	0209      	lsls	r1, r1, #8
c0d01008:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0100a:	7800      	ldrb	r0, [r0, #0]
c0d0100c:	2810      	cmp	r0, #16
c0d0100e:	d008      	beq.n	c0d01022 <io_seproxyhal_handle_event+0x26>
c0d01010:	280f      	cmp	r0, #15
c0d01012:	d10d      	bne.n	c0d01030 <io_seproxyhal_handle_event+0x34>
c0d01014:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d01016:	2904      	cmp	r1, #4
c0d01018:	d10d      	bne.n	c0d01036 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0101a:	f7ff ff2d 	bl	c0d00e78 <io_seproxyhal_handle_usb_event>
c0d0101e:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01020:	bd80      	pop	{r7, pc}
c0d01022:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01024:	2906      	cmp	r1, #6
c0d01026:	d306      	bcc.n	c0d01036 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01028:	f7ff ff64 	bl	c0d00ef4 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d0102c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d0102e:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01030:	2002      	movs	r0, #2
c0d01032:	f7ff faf5 	bl	c0d00620 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d01036:	bd80      	pop	{r7, pc}
c0d01038:	20001a18 	.word	0x20001a18

c0d0103c <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d0103c:	b580      	push	{r7, lr}
c0d0103e:	af00      	add	r7, sp, #0
c0d01040:	460a      	mov	r2, r1
c0d01042:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01044:	2082      	movs	r0, #130	; 0x82
c0d01046:	2314      	movs	r3, #20
c0d01048:	f7ff ff7c 	bl	c0d00f44 <io_usb_send_ep>
}
c0d0104c:	bd80      	pop	{r7, pc}
	...

c0d01050 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01050:	b5d0      	push	{r4, r6, r7, lr}
c0d01052:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01054:	2007      	movs	r0, #7
c0d01056:	f000 fcf7 	bl	c0d01a48 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0105a:	480a      	ldr	r0, [pc, #40]	; (c0d01084 <io_seproxyhal_init+0x34>)
c0d0105c:	2400      	movs	r4, #0
c0d0105e:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01060:	4809      	ldr	r0, [pc, #36]	; (c0d01088 <io_seproxyhal_init+0x38>)
c0d01062:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01064:	4809      	ldr	r0, [pc, #36]	; (c0d0108c <io_seproxyhal_init+0x3c>)
c0d01066:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01068:	4809      	ldr	r0, [pc, #36]	; (c0d01090 <io_seproxyhal_init+0x40>)
c0d0106a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0106c:	4809      	ldr	r0, [pc, #36]	; (c0d01094 <io_seproxyhal_init+0x44>)
c0d0106e:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01070:	f7ff fe6e 	bl	c0d00d50 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01074:	4808      	ldr	r0, [pc, #32]	; (c0d01098 <io_seproxyhal_init+0x48>)
c0d01076:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01078:	4808      	ldr	r0, [pc, #32]	; (c0d0109c <io_seproxyhal_init+0x4c>)
c0d0107a:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d0107c:	4808      	ldr	r0, [pc, #32]	; (c0d010a0 <io_seproxyhal_init+0x50>)
c0d0107e:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01080:	bdd0      	pop	{r4, r6, r7, pc}
c0d01082:	46c0      	nop			; (mov r8, r8)
c0d01084:	20001d18 	.word	0x20001d18
c0d01088:	20001d1a 	.word	0x20001d1a
c0d0108c:	20001d1c 	.word	0x20001d1c
c0d01090:	20001d1e 	.word	0x20001d1e
c0d01094:	20001d10 	.word	0x20001d10
c0d01098:	20001d20 	.word	0x20001d20
c0d0109c:	20001d24 	.word	0x20001d24
c0d010a0:	20001d28 	.word	0x20001d28

c0d010a4 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d010a4:	4801      	ldr	r0, [pc, #4]	; (c0d010ac <io_seproxyhal_init_ux+0x8>)
c0d010a6:	2100      	movs	r1, #0
c0d010a8:	6001      	str	r1, [r0, #0]

}
c0d010aa:	4770      	bx	lr
c0d010ac:	20001d20 	.word	0x20001d20

c0d010b0 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d010b0:	b5b0      	push	{r4, r5, r7, lr}
c0d010b2:	af02      	add	r7, sp, #8
c0d010b4:	460d      	mov	r5, r1
c0d010b6:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d010b8:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d010ba:	2800      	cmp	r0, #0
c0d010bc:	d00c      	beq.n	c0d010d8 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d010be:	f000 fcab 	bl	c0d01a18 <pic>
c0d010c2:	4601      	mov	r1, r0
c0d010c4:	4620      	mov	r0, r4
c0d010c6:	4788      	blx	r1
c0d010c8:	f000 fca6 	bl	c0d01a18 <pic>
c0d010cc:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d010ce:	2800      	cmp	r0, #0
c0d010d0:	d010      	beq.n	c0d010f4 <io_seproxyhal_touch_out+0x44>
c0d010d2:	2801      	cmp	r0, #1
c0d010d4:	d000      	beq.n	c0d010d8 <io_seproxyhal_touch_out+0x28>
c0d010d6:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d010d8:	2d00      	cmp	r5, #0
c0d010da:	d007      	beq.n	c0d010ec <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d010dc:	4620      	mov	r0, r4
c0d010de:	47a8      	blx	r5
c0d010e0:	2100      	movs	r1, #0
    if (!el) {
c0d010e2:	2800      	cmp	r0, #0
c0d010e4:	d006      	beq.n	c0d010f4 <io_seproxyhal_touch_out+0x44>
c0d010e6:	2801      	cmp	r0, #1
c0d010e8:	d000      	beq.n	c0d010ec <io_seproxyhal_touch_out+0x3c>
c0d010ea:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d010ec:	4620      	mov	r0, r4
c0d010ee:	f7ff fa91 	bl	c0d00614 <io_seproxyhal_display>
c0d010f2:	2101      	movs	r1, #1
  return 1;
}
c0d010f4:	4608      	mov	r0, r1
c0d010f6:	bdb0      	pop	{r4, r5, r7, pc}

c0d010f8 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d010f8:	b5b0      	push	{r4, r5, r7, lr}
c0d010fa:	af02      	add	r7, sp, #8
c0d010fc:	b08e      	sub	sp, #56	; 0x38
c0d010fe:	460c      	mov	r4, r1
c0d01100:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01102:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01104:	2800      	cmp	r0, #0
c0d01106:	d00c      	beq.n	c0d01122 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01108:	f000 fc86 	bl	c0d01a18 <pic>
c0d0110c:	4601      	mov	r1, r0
c0d0110e:	4628      	mov	r0, r5
c0d01110:	4788      	blx	r1
c0d01112:	f000 fc81 	bl	c0d01a18 <pic>
c0d01116:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01118:	2800      	cmp	r0, #0
c0d0111a:	d016      	beq.n	c0d0114a <io_seproxyhal_touch_over+0x52>
c0d0111c:	2801      	cmp	r0, #1
c0d0111e:	d000      	beq.n	c0d01122 <io_seproxyhal_touch_over+0x2a>
c0d01120:	4605      	mov	r5, r0
c0d01122:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01124:	2238      	movs	r2, #56	; 0x38
c0d01126:	4629      	mov	r1, r5
c0d01128:	f7ff fdf6 	bl	c0d00d18 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d0112c:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0112e:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01130:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01132:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01134:	2c00      	cmp	r4, #0
c0d01136:	d004      	beq.n	c0d01142 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01138:	4628      	mov	r0, r5
c0d0113a:	47a0      	blx	r4
c0d0113c:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0113e:	2800      	cmp	r0, #0
c0d01140:	d003      	beq.n	c0d0114a <io_seproxyhal_touch_over+0x52>
c0d01142:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01144:	f7ff fa66 	bl	c0d00614 <io_seproxyhal_display>
c0d01148:	2101      	movs	r1, #1
  return 1;
}
c0d0114a:	4608      	mov	r0, r1
c0d0114c:	b00e      	add	sp, #56	; 0x38
c0d0114e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01150 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01150:	b5b0      	push	{r4, r5, r7, lr}
c0d01152:	af02      	add	r7, sp, #8
c0d01154:	460d      	mov	r5, r1
c0d01156:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01158:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0115a:	2800      	cmp	r0, #0
c0d0115c:	d00c      	beq.n	c0d01178 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0115e:	f000 fc5b 	bl	c0d01a18 <pic>
c0d01162:	4601      	mov	r1, r0
c0d01164:	4620      	mov	r0, r4
c0d01166:	4788      	blx	r1
c0d01168:	f000 fc56 	bl	c0d01a18 <pic>
c0d0116c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0116e:	2800      	cmp	r0, #0
c0d01170:	d010      	beq.n	c0d01194 <io_seproxyhal_touch_tap+0x44>
c0d01172:	2801      	cmp	r0, #1
c0d01174:	d000      	beq.n	c0d01178 <io_seproxyhal_touch_tap+0x28>
c0d01176:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01178:	2d00      	cmp	r5, #0
c0d0117a:	d007      	beq.n	c0d0118c <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d0117c:	4620      	mov	r0, r4
c0d0117e:	47a8      	blx	r5
c0d01180:	2100      	movs	r1, #0
    if (!el) {
c0d01182:	2800      	cmp	r0, #0
c0d01184:	d006      	beq.n	c0d01194 <io_seproxyhal_touch_tap+0x44>
c0d01186:	2801      	cmp	r0, #1
c0d01188:	d000      	beq.n	c0d0118c <io_seproxyhal_touch_tap+0x3c>
c0d0118a:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d0118c:	4620      	mov	r0, r4
c0d0118e:	f7ff fa41 	bl	c0d00614 <io_seproxyhal_display>
c0d01192:	2101      	movs	r1, #1
  return 1;
}
c0d01194:	4608      	mov	r0, r1
c0d01196:	bdb0      	pop	{r4, r5, r7, pc}

c0d01198 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01198:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0119a:	af03      	add	r7, sp, #12
c0d0119c:	b087      	sub	sp, #28
c0d0119e:	9302      	str	r3, [sp, #8]
c0d011a0:	9203      	str	r2, [sp, #12]
c0d011a2:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d011a4:	2900      	cmp	r1, #0
c0d011a6:	d076      	beq.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
c0d011a8:	9004      	str	r0, [sp, #16]
c0d011aa:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d011ac:	9001      	str	r0, [sp, #4]
c0d011ae:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d011b0:	9000      	str	r0, [sp, #0]
c0d011b2:	2600      	movs	r6, #0
c0d011b4:	9606      	str	r6, [sp, #24]
c0d011b6:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d011b8:	f000 fe08 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d011bc:	2800      	cmp	r0, #0
c0d011be:	d155      	bne.n	c0d0126c <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d011c0:	2038      	movs	r0, #56	; 0x38
c0d011c2:	4370      	muls	r0, r6
c0d011c4:	9d04      	ldr	r5, [sp, #16]
c0d011c6:	182e      	adds	r6, r5, r0
c0d011c8:	4b36      	ldr	r3, [pc, #216]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d011ca:	681a      	ldr	r2, [r3, #0]
c0d011cc:	2101      	movs	r1, #1
c0d011ce:	4296      	cmp	r6, r2
c0d011d0:	d000      	beq.n	c0d011d4 <io_seproxyhal_touch_element_callback+0x3c>
c0d011d2:	9906      	ldr	r1, [sp, #24]
c0d011d4:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d011d6:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d011d8:	2800      	cmp	r0, #0
c0d011da:	da41      	bge.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
c0d011dc:	2020      	movs	r0, #32
c0d011de:	5c35      	ldrb	r5, [r6, r0]
c0d011e0:	2102      	movs	r1, #2
c0d011e2:	5e71      	ldrsh	r1, [r6, r1]
c0d011e4:	1b4a      	subs	r2, r1, r5
c0d011e6:	9803      	ldr	r0, [sp, #12]
c0d011e8:	4282      	cmp	r2, r0
c0d011ea:	dc39      	bgt.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
c0d011ec:	1869      	adds	r1, r5, r1
c0d011ee:	88f2      	ldrh	r2, [r6, #6]
c0d011f0:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d011f2:	9803      	ldr	r0, [sp, #12]
c0d011f4:	4288      	cmp	r0, r1
c0d011f6:	da33      	bge.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
c0d011f8:	2104      	movs	r1, #4
c0d011fa:	5e70      	ldrsh	r0, [r6, r1]
c0d011fc:	1b42      	subs	r2, r0, r5
c0d011fe:	9902      	ldr	r1, [sp, #8]
c0d01200:	428a      	cmp	r2, r1
c0d01202:	dc2d      	bgt.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
c0d01204:	1940      	adds	r0, r0, r5
c0d01206:	8931      	ldrh	r1, [r6, #8]
c0d01208:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0120a:	9902      	ldr	r1, [sp, #8]
c0d0120c:	4281      	cmp	r1, r0
c0d0120e:	da27      	bge.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01210:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01212:	4286      	cmp	r6, r0
c0d01214:	d010      	beq.n	c0d01238 <io_seproxyhal_touch_element_callback+0xa0>
c0d01216:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01218:	2800      	cmp	r0, #0
c0d0121a:	d00d      	beq.n	c0d01238 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d0121c:	9801      	ldr	r0, [sp, #4]
c0d0121e:	2800      	cmp	r0, #0
c0d01220:	d005      	beq.n	c0d0122e <io_seproxyhal_touch_element_callback+0x96>
c0d01222:	4630      	mov	r0, r6
c0d01224:	9901      	ldr	r1, [sp, #4]
c0d01226:	4788      	blx	r1
c0d01228:	4b1e      	ldr	r3, [pc, #120]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0122a:	2800      	cmp	r0, #0
c0d0122c:	d018      	beq.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0122e:	6818      	ldr	r0, [r3, #0]
c0d01230:	9901      	ldr	r1, [sp, #4]
c0d01232:	f7ff ff3d 	bl	c0d010b0 <io_seproxyhal_touch_out>
c0d01236:	e008      	b.n	c0d0124a <io_seproxyhal_touch_element_callback+0xb2>
c0d01238:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0123a:	2801      	cmp	r0, #1
c0d0123c:	d009      	beq.n	c0d01252 <io_seproxyhal_touch_element_callback+0xba>
c0d0123e:	2802      	cmp	r0, #2
c0d01240:	d10e      	bne.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01242:	4630      	mov	r0, r6
c0d01244:	9901      	ldr	r1, [sp, #4]
c0d01246:	f7ff ff83 	bl	c0d01150 <io_seproxyhal_touch_tap>
c0d0124a:	4b16      	ldr	r3, [pc, #88]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0124c:	2800      	cmp	r0, #0
c0d0124e:	d007      	beq.n	c0d01260 <io_seproxyhal_touch_element_callback+0xc8>
c0d01250:	e023      	b.n	c0d0129a <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01252:	4630      	mov	r0, r6
c0d01254:	9901      	ldr	r1, [sp, #4]
c0d01256:	f7ff ff4f 	bl	c0d010f8 <io_seproxyhal_touch_over>
c0d0125a:	4b12      	ldr	r3, [pc, #72]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0125c:	2800      	cmp	r0, #0
c0d0125e:	d11f      	bne.n	c0d012a0 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01260:	1c64      	adds	r4, r4, #1
c0d01262:	b2e6      	uxtb	r6, r4
c0d01264:	9805      	ldr	r0, [sp, #20]
c0d01266:	4286      	cmp	r6, r0
c0d01268:	d3a6      	bcc.n	c0d011b8 <io_seproxyhal_touch_element_callback+0x20>
c0d0126a:	e000      	b.n	c0d0126e <io_seproxyhal_touch_element_callback+0xd6>
c0d0126c:	4b0d      	ldr	r3, [pc, #52]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0126e:	9806      	ldr	r0, [sp, #24]
c0d01270:	0600      	lsls	r0, r0, #24
c0d01272:	d010      	beq.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
c0d01274:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01276:	2800      	cmp	r0, #0
c0d01278:	d00d      	beq.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0127a:	f000 fda7 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d0127e:	4909      	ldr	r1, [pc, #36]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01280:	2800      	cmp	r0, #0
c0d01282:	d108      	bne.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01284:	6808      	ldr	r0, [r1, #0]
c0d01286:	9901      	ldr	r1, [sp, #4]
c0d01288:	f7ff ff12 	bl	c0d010b0 <io_seproxyhal_touch_out>
c0d0128c:	4d05      	ldr	r5, [pc, #20]	; (c0d012a4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0128e:	2800      	cmp	r0, #0
c0d01290:	d001      	beq.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01292:	2000      	movs	r0, #0
c0d01294:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01296:	b007      	add	sp, #28
c0d01298:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0129a:	2000      	movs	r0, #0
c0d0129c:	6018      	str	r0, [r3, #0]
c0d0129e:	e7fa      	b.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d012a0:	601e      	str	r6, [r3, #0]
c0d012a2:	e7f8      	b.n	c0d01296 <io_seproxyhal_touch_element_callback+0xfe>
c0d012a4:	20001d20 	.word	0x20001d20

c0d012a8 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d012a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012aa:	af03      	add	r7, sp, #12
c0d012ac:	b08b      	sub	sp, #44	; 0x2c
c0d012ae:	460c      	mov	r4, r1
c0d012b0:	4601      	mov	r1, r0
c0d012b2:	ad04      	add	r5, sp, #16
c0d012b4:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d012b6:	4628      	mov	r0, r5
c0d012b8:	9203      	str	r2, [sp, #12]
c0d012ba:	f7ff fd2d 	bl	c0d00d18 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d012be:	6821      	ldr	r1, [r4, #0]
c0d012c0:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d012c2:	6862      	ldr	r2, [r4, #4]
c0d012c4:	9502      	str	r5, [sp, #8]
c0d012c6:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d012c8:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d012ca:	4e1a      	ldr	r6, [pc, #104]	; (c0d01334 <io_seproxyhal_display_icon+0x8c>)
c0d012cc:	2365      	movs	r3, #101	; 0x65
c0d012ce:	4635      	mov	r5, r6
c0d012d0:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d012d2:	b292      	uxth	r2, r2
c0d012d4:	4342      	muls	r2, r0
c0d012d6:	b28b      	uxth	r3, r1
c0d012d8:	4353      	muls	r3, r2
c0d012da:	08d9      	lsrs	r1, r3, #3
c0d012dc:	1c4e      	adds	r6, r1, #1
c0d012de:	2207      	movs	r2, #7
c0d012e0:	4213      	tst	r3, r2
c0d012e2:	d100      	bne.n	c0d012e6 <io_seproxyhal_display_icon+0x3e>
c0d012e4:	460e      	mov	r6, r1
c0d012e6:	4631      	mov	r1, r6
c0d012e8:	9101      	str	r1, [sp, #4]
c0d012ea:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d012ec:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d012ee:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d012f0:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d012f2:	0a01      	lsrs	r1, r0, #8
c0d012f4:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d012f6:	70a8      	strb	r0, [r5, #2]
c0d012f8:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d012fa:	4628      	mov	r0, r5
c0d012fc:	f000 fd48 	bl	c0d01d90 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01300:	9802      	ldr	r0, [sp, #8]
c0d01302:	9903      	ldr	r1, [sp, #12]
c0d01304:	f000 fd44 	bl	c0d01d90 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01308:	68a0      	ldr	r0, [r4, #8]
c0d0130a:	7028      	strb	r0, [r5, #0]
c0d0130c:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0130e:	4628      	mov	r0, r5
c0d01310:	f000 fd3e 	bl	c0d01d90 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01314:	68e0      	ldr	r0, [r4, #12]
c0d01316:	f000 fb7f 	bl	c0d01a18 <pic>
c0d0131a:	b2b1      	uxth	r1, r6
c0d0131c:	f000 fd38 	bl	c0d01d90 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01320:	9801      	ldr	r0, [sp, #4]
c0d01322:	b285      	uxth	r5, r0
c0d01324:	6920      	ldr	r0, [r4, #16]
c0d01326:	f000 fb77 	bl	c0d01a18 <pic>
c0d0132a:	4629      	mov	r1, r5
c0d0132c:	f000 fd30 	bl	c0d01d90 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01330:	b00b      	add	sp, #44	; 0x2c
c0d01332:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01334:	20001a18 	.word	0x20001a18

c0d01338 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01338:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0133a:	af03      	add	r7, sp, #12
c0d0133c:	b081      	sub	sp, #4
c0d0133e:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01340:	7820      	ldrb	r0, [r4, #0]
c0d01342:	267f      	movs	r6, #127	; 0x7f
c0d01344:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01346:	2e00      	cmp	r6, #0
c0d01348:	d02e      	beq.n	c0d013a8 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0134a:	69e0      	ldr	r0, [r4, #28]
c0d0134c:	2800      	cmp	r0, #0
c0d0134e:	d01d      	beq.n	c0d0138c <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01350:	f000 fb62 	bl	c0d01a18 <pic>
c0d01354:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01356:	2e05      	cmp	r6, #5
c0d01358:	d102      	bne.n	c0d01360 <io_seproxyhal_display_default+0x28>
c0d0135a:	7ea0      	ldrb	r0, [r4, #26]
c0d0135c:	2800      	cmp	r0, #0
c0d0135e:	d025      	beq.n	c0d013ac <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01360:	4628      	mov	r0, r5
c0d01362:	f001 ff99 	bl	c0d03298 <strlen>
c0d01366:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01368:	4813      	ldr	r0, [pc, #76]	; (c0d013b8 <io_seproxyhal_display_default+0x80>)
c0d0136a:	2165      	movs	r1, #101	; 0x65
c0d0136c:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0136e:	4631      	mov	r1, r6
c0d01370:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01372:	0a0a      	lsrs	r2, r1, #8
c0d01374:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01376:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01378:	2103      	movs	r1, #3
c0d0137a:	f000 fd09 	bl	c0d01d90 <io_seproxyhal_spi_send>
c0d0137e:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01380:	4620      	mov	r0, r4
c0d01382:	f000 fd05 	bl	c0d01d90 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01386:	b2b1      	uxth	r1, r6
c0d01388:	4628      	mov	r0, r5
c0d0138a:	e00b      	b.n	c0d013a4 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0138c:	480a      	ldr	r0, [pc, #40]	; (c0d013b8 <io_seproxyhal_display_default+0x80>)
c0d0138e:	2165      	movs	r1, #101	; 0x65
c0d01390:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01392:	2100      	movs	r1, #0
c0d01394:	7041      	strb	r1, [r0, #1]
c0d01396:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01398:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0139a:	2103      	movs	r1, #3
c0d0139c:	f000 fcf8 	bl	c0d01d90 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d013a0:	4620      	mov	r0, r4
c0d013a2:	4629      	mov	r1, r5
c0d013a4:	f000 fcf4 	bl	c0d01d90 <io_seproxyhal_spi_send>
    }
  }
}
c0d013a8:	b001      	add	sp, #4
c0d013aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d013ac:	4620      	mov	r0, r4
c0d013ae:	4629      	mov	r1, r5
c0d013b0:	f7ff ff7a 	bl	c0d012a8 <io_seproxyhal_display_icon>
c0d013b4:	e7f8      	b.n	c0d013a8 <io_seproxyhal_display_default+0x70>
c0d013b6:	46c0      	nop			; (mov r8, r8)
c0d013b8:	20001a18 	.word	0x20001a18

c0d013bc <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d013bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013be:	af03      	add	r7, sp, #12
c0d013c0:	b081      	sub	sp, #4
c0d013c2:	4604      	mov	r4, r0
  if (button_callback) {
c0d013c4:	2c00      	cmp	r4, #0
c0d013c6:	d02e      	beq.n	c0d01426 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d013c8:	4818      	ldr	r0, [pc, #96]	; (c0d0142c <io_seproxyhal_button_push+0x70>)
c0d013ca:	6802      	ldr	r2, [r0, #0]
c0d013cc:	428a      	cmp	r2, r1
c0d013ce:	d103      	bne.n	c0d013d8 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d013d0:	4a17      	ldr	r2, [pc, #92]	; (c0d01430 <io_seproxyhal_button_push+0x74>)
c0d013d2:	6813      	ldr	r3, [r2, #0]
c0d013d4:	1c5b      	adds	r3, r3, #1
c0d013d6:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d013d8:	6806      	ldr	r6, [r0, #0]
c0d013da:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d013dc:	4a14      	ldr	r2, [pc, #80]	; (c0d01430 <io_seproxyhal_button_push+0x74>)
c0d013de:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d013e0:	2900      	cmp	r1, #0
c0d013e2:	d001      	beq.n	c0d013e8 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d013e4:	6006      	str	r6, [r0, #0]
c0d013e6:	e005      	b.n	c0d013f4 <io_seproxyhal_button_push+0x38>
c0d013e8:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d013ea:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d013ec:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d013ee:	2301      	movs	r3, #1
c0d013f0:	07db      	lsls	r3, r3, #31
c0d013f2:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d013f4:	6800      	ldr	r0, [r0, #0]
c0d013f6:	4288      	cmp	r0, r1
c0d013f8:	d001      	beq.n	c0d013fe <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d013fa:	2000      	movs	r0, #0
c0d013fc:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d013fe:	2d08      	cmp	r5, #8
c0d01400:	d30e      	bcc.n	c0d01420 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01402:	2103      	movs	r1, #3
c0d01404:	4628      	mov	r0, r5
c0d01406:	f001 fda7 	bl	c0d02f58 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d0140a:	2001      	movs	r0, #1
c0d0140c:	0780      	lsls	r0, r0, #30
c0d0140e:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01410:	2900      	cmp	r1, #0
c0d01412:	4601      	mov	r1, r0
c0d01414:	d000      	beq.n	c0d01418 <io_seproxyhal_button_push+0x5c>
c0d01416:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01418:	2900      	cmp	r1, #0
c0d0141a:	db02      	blt.n	c0d01422 <io_seproxyhal_button_push+0x66>
c0d0141c:	4608      	mov	r0, r1
c0d0141e:	e000      	b.n	c0d01422 <io_seproxyhal_button_push+0x66>
c0d01420:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01422:	4629      	mov	r1, r5
c0d01424:	47a0      	blx	r4
  }
}
c0d01426:	b001      	add	sp, #4
c0d01428:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0142a:	46c0      	nop			; (mov r8, r8)
c0d0142c:	20001d24 	.word	0x20001d24
c0d01430:	20001d28 	.word	0x20001d28

c0d01434 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01434:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01436:	af03      	add	r7, sp, #12
c0d01438:	b081      	sub	sp, #4
c0d0143a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d0143c:	200f      	movs	r0, #15
c0d0143e:	4204      	tst	r4, r0
c0d01440:	d006      	beq.n	c0d01450 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01442:	4620      	mov	r0, r4
c0d01444:	f7ff f8be 	bl	c0d005c4 <io_exchange_al>
c0d01448:	4605      	mov	r5, r0
  }
}
c0d0144a:	b2a8      	uxth	r0, r5
c0d0144c:	b001      	add	sp, #4
c0d0144e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01450:	2610      	movs	r6, #16
c0d01452:	4026      	ands	r6, r4
c0d01454:	2900      	cmp	r1, #0
c0d01456:	d02a      	beq.n	c0d014ae <io_exchange+0x7a>
c0d01458:	2e00      	cmp	r6, #0
c0d0145a:	d128      	bne.n	c0d014ae <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0145c:	483d      	ldr	r0, [pc, #244]	; (c0d01554 <io_exchange+0x120>)
c0d0145e:	7800      	ldrb	r0, [r0, #0]
c0d01460:	2807      	cmp	r0, #7
c0d01462:	d00b      	beq.n	c0d0147c <io_exchange+0x48>
c0d01464:	2800      	cmp	r0, #0
c0d01466:	d004      	beq.n	c0d01472 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01468:	4620      	mov	r0, r4
c0d0146a:	f7ff f8ab 	bl	c0d005c4 <io_exchange_al>
c0d0146e:	2800      	cmp	r0, #0
c0d01470:	d00a      	beq.n	c0d01488 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01472:	4839      	ldr	r0, [pc, #228]	; (c0d01558 <io_exchange+0x124>)
c0d01474:	6800      	ldr	r0, [r0, #0]
c0d01476:	2109      	movs	r1, #9
c0d01478:	f001 ff00 	bl	c0d0327c <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d0147c:	483d      	ldr	r0, [pc, #244]	; (c0d01574 <io_exchange+0x140>)
c0d0147e:	4478      	add	r0, pc
c0d01480:	2200      	movs	r2, #0
c0d01482:	2320      	movs	r3, #32
c0d01484:	f7ff fc6a 	bl	c0d00d5c <io_usb_hid_exchange>
c0d01488:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0148a:	4832      	ldr	r0, [pc, #200]	; (c0d01554 <io_exchange+0x120>)
c0d0148c:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d0148e:	4833      	ldr	r0, [pc, #204]	; (c0d0155c <io_exchange+0x128>)
c0d01490:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01492:	4833      	ldr	r0, [pc, #204]	; (c0d01560 <io_exchange+0x12c>)
c0d01494:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01496:	4833      	ldr	r0, [pc, #204]	; (c0d01564 <io_exchange+0x130>)
c0d01498:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0149a:	4833      	ldr	r0, [pc, #204]	; (c0d01568 <io_exchange+0x134>)
c0d0149c:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0149e:	06a0      	lsls	r0, r4, #26
c0d014a0:	d4d3      	bmi.n	c0d0144a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d014a2:	f7ff fcd3 	bl	c0d00e4c <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d014a6:	0620      	lsls	r0, r4, #24
c0d014a8:	d501      	bpl.n	c0d014ae <io_exchange+0x7a>
        reset();
c0d014aa:	f000 faeb 	bl	c0d01a84 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d014ae:	2e00      	cmp	r6, #0
c0d014b0:	d10c      	bne.n	c0d014cc <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d014b2:	0660      	lsls	r0, r4, #25
c0d014b4:	d448      	bmi.n	c0d01548 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d014b6:	4827      	ldr	r0, [pc, #156]	; (c0d01554 <io_exchange+0x120>)
c0d014b8:	2100      	movs	r1, #0
c0d014ba:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d014bc:	4827      	ldr	r0, [pc, #156]	; (c0d0155c <io_exchange+0x128>)
c0d014be:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d014c0:	4827      	ldr	r0, [pc, #156]	; (c0d01560 <io_exchange+0x12c>)
c0d014c2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d014c4:	4827      	ldr	r0, [pc, #156]	; (c0d01564 <io_exchange+0x130>)
c0d014c6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d014c8:	4827      	ldr	r0, [pc, #156]	; (c0d01568 <io_exchange+0x134>)
c0d014ca:	7001      	strb	r1, [r0, #0]
c0d014cc:	4c28      	ldr	r4, [pc, #160]	; (c0d01570 <io_exchange+0x13c>)
c0d014ce:	4e24      	ldr	r6, [pc, #144]	; (c0d01560 <io_exchange+0x12c>)
c0d014d0:	e008      	b.n	c0d014e4 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d014d2:	f7ff fd0f 	bl	c0d00ef4 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d014d6:	8830      	ldrh	r0, [r6, #0]
c0d014d8:	2800      	cmp	r0, #0
c0d014da:	d003      	beq.n	c0d014e4 <io_exchange+0xb0>
c0d014dc:	e032      	b.n	c0d01544 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d014de:	2002      	movs	r0, #2
c0d014e0:	f7ff f89e 	bl	c0d00620 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d014e4:	f000 fc72 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d014e8:	2800      	cmp	r0, #0
c0d014ea:	d101      	bne.n	c0d014f0 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d014ec:	f7ff fcae 	bl	c0d00e4c <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d014f0:	2180      	movs	r1, #128	; 0x80
c0d014f2:	2500      	movs	r5, #0
c0d014f4:	4620      	mov	r0, r4
c0d014f6:	462a      	mov	r2, r5
c0d014f8:	f000 fc84 	bl	c0d01e04 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d014fc:	1ec1      	subs	r1, r0, #3
c0d014fe:	78a2      	ldrb	r2, [r4, #2]
c0d01500:	7863      	ldrb	r3, [r4, #1]
c0d01502:	021b      	lsls	r3, r3, #8
c0d01504:	4313      	orrs	r3, r2
c0d01506:	4299      	cmp	r1, r3
c0d01508:	d110      	bne.n	c0d0152c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d0150a:	4917      	ldr	r1, [pc, #92]	; (c0d01568 <io_exchange+0x134>)
c0d0150c:	7809      	ldrb	r1, [r1, #0]
c0d0150e:	2900      	cmp	r1, #0
c0d01510:	d002      	beq.n	c0d01518 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01512:	f7ff fd73 	bl	c0d00ffc <io_seproxyhal_handle_event>
c0d01516:	e7e5      	b.n	c0d014e4 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01518:	7821      	ldrb	r1, [r4, #0]
c0d0151a:	2910      	cmp	r1, #16
c0d0151c:	d00f      	beq.n	c0d0153e <io_exchange+0x10a>
c0d0151e:	290f      	cmp	r1, #15
c0d01520:	d1dd      	bne.n	c0d014de <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01522:	2804      	cmp	r0, #4
c0d01524:	d102      	bne.n	c0d0152c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01526:	f7ff fca7 	bl	c0d00e78 <io_seproxyhal_handle_usb_event>
c0d0152a:	e7db      	b.n	c0d014e4 <io_exchange+0xb0>
c0d0152c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0152e:	4909      	ldr	r1, [pc, #36]	; (c0d01554 <io_exchange+0x120>)
c0d01530:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01532:	490a      	ldr	r1, [pc, #40]	; (c0d0155c <io_exchange+0x128>)
c0d01534:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01536:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01538:	490a      	ldr	r1, [pc, #40]	; (c0d01564 <io_exchange+0x130>)
c0d0153a:	8008      	strh	r0, [r1, #0]
c0d0153c:	e7d2      	b.n	c0d014e4 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0153e:	2806      	cmp	r0, #6
c0d01540:	d2c7      	bcs.n	c0d014d2 <io_exchange+0x9e>
c0d01542:	e782      	b.n	c0d0144a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01544:	8835      	ldrh	r5, [r6, #0]
c0d01546:	e780      	b.n	c0d0144a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01548:	4805      	ldr	r0, [pc, #20]	; (c0d01560 <io_exchange+0x12c>)
c0d0154a:	8800      	ldrh	r0, [r0, #0]
c0d0154c:	4907      	ldr	r1, [pc, #28]	; (c0d0156c <io_exchange+0x138>)
c0d0154e:	1845      	adds	r5, r0, r1
c0d01550:	e77b      	b.n	c0d0144a <io_exchange+0x16>
c0d01552:	46c0      	nop			; (mov r8, r8)
c0d01554:	20001d18 	.word	0x20001d18
c0d01558:	20001bb8 	.word	0x20001bb8
c0d0155c:	20001d1a 	.word	0x20001d1a
c0d01560:	20001d1c 	.word	0x20001d1c
c0d01564:	20001d1e 	.word	0x20001d1e
c0d01568:	20001d10 	.word	0x20001d10
c0d0156c:	0000fffb 	.word	0x0000fffb
c0d01570:	20001a18 	.word	0x20001a18
c0d01574:	fffffbbb 	.word	0xfffffbbb

c0d01578 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01578:	b081      	sub	sp, #4
c0d0157a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0157c:	af03      	add	r7, sp, #12
c0d0157e:	b094      	sub	sp, #80	; 0x50
c0d01580:	4616      	mov	r6, r2
c0d01582:	460d      	mov	r5, r1
c0d01584:	900e      	str	r0, [sp, #56]	; 0x38
c0d01586:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01588:	2d02      	cmp	r5, #2
c0d0158a:	d200      	bcs.n	c0d0158e <snprintf+0x16>
c0d0158c:	e22a      	b.n	c0d019e4 <snprintf+0x46c>
c0d0158e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01590:	2800      	cmp	r0, #0
c0d01592:	d100      	bne.n	c0d01596 <snprintf+0x1e>
c0d01594:	e226      	b.n	c0d019e4 <snprintf+0x46c>
c0d01596:	2e00      	cmp	r6, #0
c0d01598:	d100      	bne.n	c0d0159c <snprintf+0x24>
c0d0159a:	e223      	b.n	c0d019e4 <snprintf+0x46c>
c0d0159c:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d0159e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d015a0:	9109      	str	r1, [sp, #36]	; 0x24
c0d015a2:	462a      	mov	r2, r5
c0d015a4:	f7ff fbae 	bl	c0d00d04 <os_memset>
c0d015a8:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d015aa:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d015ac:	7830      	ldrb	r0, [r6, #0]
c0d015ae:	2800      	cmp	r0, #0
c0d015b0:	d100      	bne.n	c0d015b4 <snprintf+0x3c>
c0d015b2:	e217      	b.n	c0d019e4 <snprintf+0x46c>
c0d015b4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d015b6:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d015b8:	1e6b      	subs	r3, r5, #1
c0d015ba:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d015bc:	460a      	mov	r2, r1
c0d015be:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d015c0:	e003      	b.n	c0d015ca <snprintf+0x52>
c0d015c2:	1970      	adds	r0, r6, r5
c0d015c4:	7840      	ldrb	r0, [r0, #1]
c0d015c6:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d015c8:	1c6d      	adds	r5, r5, #1
c0d015ca:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d015cc:	2800      	cmp	r0, #0
c0d015ce:	d001      	beq.n	c0d015d4 <snprintf+0x5c>
c0d015d0:	2825      	cmp	r0, #37	; 0x25
c0d015d2:	d1f6      	bne.n	c0d015c2 <snprintf+0x4a>
c0d015d4:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d015d6:	429d      	cmp	r5, r3
c0d015d8:	d300      	bcc.n	c0d015dc <snprintf+0x64>
c0d015da:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d015dc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d015de:	4631      	mov	r1, r6
c0d015e0:	462a      	mov	r2, r5
c0d015e2:	461c      	mov	r4, r3
c0d015e4:	f7ff fb98 	bl	c0d00d18 <os_memmove>
c0d015e8:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d015ea:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d015ec:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d015ee:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d015f0:	2b00      	cmp	r3, #0
c0d015f2:	d100      	bne.n	c0d015f6 <snprintf+0x7e>
c0d015f4:	e1f6      	b.n	c0d019e4 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d015f6:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d015f8:	5d71      	ldrb	r1, [r6, r5]
c0d015fa:	2925      	cmp	r1, #37	; 0x25
c0d015fc:	d000      	beq.n	c0d01600 <snprintf+0x88>
c0d015fe:	e0ab      	b.n	c0d01758 <snprintf+0x1e0>
c0d01600:	9304      	str	r3, [sp, #16]
c0d01602:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01604:	1c40      	adds	r0, r0, #1
c0d01606:	2100      	movs	r1, #0
c0d01608:	2220      	movs	r2, #32
c0d0160a:	920a      	str	r2, [sp, #40]	; 0x28
c0d0160c:	220a      	movs	r2, #10
c0d0160e:	9203      	str	r2, [sp, #12]
c0d01610:	9102      	str	r1, [sp, #8]
c0d01612:	9106      	str	r1, [sp, #24]
c0d01614:	910d      	str	r1, [sp, #52]	; 0x34
c0d01616:	460b      	mov	r3, r1
c0d01618:	2102      	movs	r1, #2
c0d0161a:	910c      	str	r1, [sp, #48]	; 0x30
c0d0161c:	4606      	mov	r6, r0
c0d0161e:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01620:	7831      	ldrb	r1, [r6, #0]
c0d01622:	1c76      	adds	r6, r6, #1
c0d01624:	2300      	movs	r3, #0
c0d01626:	2962      	cmp	r1, #98	; 0x62
c0d01628:	dc41      	bgt.n	c0d016ae <snprintf+0x136>
c0d0162a:	4608      	mov	r0, r1
c0d0162c:	3825      	subs	r0, #37	; 0x25
c0d0162e:	2823      	cmp	r0, #35	; 0x23
c0d01630:	d900      	bls.n	c0d01634 <snprintf+0xbc>
c0d01632:	e094      	b.n	c0d0175e <snprintf+0x1e6>
c0d01634:	0040      	lsls	r0, r0, #1
c0d01636:	46c0      	nop			; (mov r8, r8)
c0d01638:	4478      	add	r0, pc
c0d0163a:	8880      	ldrh	r0, [r0, #4]
c0d0163c:	0040      	lsls	r0, r0, #1
c0d0163e:	4487      	add	pc, r0
c0d01640:	0186012d 	.word	0x0186012d
c0d01644:	01860186 	.word	0x01860186
c0d01648:	00510186 	.word	0x00510186
c0d0164c:	01860186 	.word	0x01860186
c0d01650:	00580023 	.word	0x00580023
c0d01654:	00240186 	.word	0x00240186
c0d01658:	00240024 	.word	0x00240024
c0d0165c:	00240024 	.word	0x00240024
c0d01660:	00240024 	.word	0x00240024
c0d01664:	00240024 	.word	0x00240024
c0d01668:	01860024 	.word	0x01860024
c0d0166c:	01860186 	.word	0x01860186
c0d01670:	01860186 	.word	0x01860186
c0d01674:	01860186 	.word	0x01860186
c0d01678:	01860186 	.word	0x01860186
c0d0167c:	01860186 	.word	0x01860186
c0d01680:	01860186 	.word	0x01860186
c0d01684:	006c0186 	.word	0x006c0186
c0d01688:	e7c9      	b.n	c0d0161e <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d0168a:	2930      	cmp	r1, #48	; 0x30
c0d0168c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0168e:	4603      	mov	r3, r0
c0d01690:	d100      	bne.n	c0d01694 <snprintf+0x11c>
c0d01692:	460b      	mov	r3, r1
c0d01694:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01696:	2c00      	cmp	r4, #0
c0d01698:	d000      	beq.n	c0d0169c <snprintf+0x124>
c0d0169a:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d0169c:	200a      	movs	r0, #10
c0d0169e:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d016a0:	1840      	adds	r0, r0, r1
c0d016a2:	3830      	subs	r0, #48	; 0x30
c0d016a4:	900d      	str	r0, [sp, #52]	; 0x34
c0d016a6:	4630      	mov	r0, r6
c0d016a8:	930a      	str	r3, [sp, #40]	; 0x28
c0d016aa:	4613      	mov	r3, r2
c0d016ac:	e7b4      	b.n	c0d01618 <snprintf+0xa0>
c0d016ae:	296f      	cmp	r1, #111	; 0x6f
c0d016b0:	dd11      	ble.n	c0d016d6 <snprintf+0x15e>
c0d016b2:	3970      	subs	r1, #112	; 0x70
c0d016b4:	2908      	cmp	r1, #8
c0d016b6:	d900      	bls.n	c0d016ba <snprintf+0x142>
c0d016b8:	e149      	b.n	c0d0194e <snprintf+0x3d6>
c0d016ba:	0049      	lsls	r1, r1, #1
c0d016bc:	4479      	add	r1, pc
c0d016be:	8889      	ldrh	r1, [r1, #4]
c0d016c0:	0049      	lsls	r1, r1, #1
c0d016c2:	448f      	add	pc, r1
c0d016c4:	01440051 	.word	0x01440051
c0d016c8:	002e0144 	.word	0x002e0144
c0d016cc:	00590144 	.word	0x00590144
c0d016d0:	01440144 	.word	0x01440144
c0d016d4:	0051      	.short	0x0051
c0d016d6:	2963      	cmp	r1, #99	; 0x63
c0d016d8:	d054      	beq.n	c0d01784 <snprintf+0x20c>
c0d016da:	2964      	cmp	r1, #100	; 0x64
c0d016dc:	d057      	beq.n	c0d0178e <snprintf+0x216>
c0d016de:	2968      	cmp	r1, #104	; 0x68
c0d016e0:	d01d      	beq.n	c0d0171e <snprintf+0x1a6>
c0d016e2:	e134      	b.n	c0d0194e <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d016e4:	7830      	ldrb	r0, [r6, #0]
c0d016e6:	2873      	cmp	r0, #115	; 0x73
c0d016e8:	d000      	beq.n	c0d016ec <snprintf+0x174>
c0d016ea:	e130      	b.n	c0d0194e <snprintf+0x3d6>
c0d016ec:	4630      	mov	r0, r6
c0d016ee:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d016f0:	e00d      	b.n	c0d0170e <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d016f2:	7830      	ldrb	r0, [r6, #0]
c0d016f4:	282a      	cmp	r0, #42	; 0x2a
c0d016f6:	d000      	beq.n	c0d016fa <snprintf+0x182>
c0d016f8:	e129      	b.n	c0d0194e <snprintf+0x3d6>
c0d016fa:	7871      	ldrb	r1, [r6, #1]
c0d016fc:	1c70      	adds	r0, r6, #1
c0d016fe:	2301      	movs	r3, #1
c0d01700:	2948      	cmp	r1, #72	; 0x48
c0d01702:	d004      	beq.n	c0d0170e <snprintf+0x196>
c0d01704:	2968      	cmp	r1, #104	; 0x68
c0d01706:	d002      	beq.n	c0d0170e <snprintf+0x196>
c0d01708:	2973      	cmp	r1, #115	; 0x73
c0d0170a:	d000      	beq.n	c0d0170e <snprintf+0x196>
c0d0170c:	e11f      	b.n	c0d0194e <snprintf+0x3d6>
c0d0170e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01710:	1d0a      	adds	r2, r1, #4
c0d01712:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01714:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01716:	9102      	str	r1, [sp, #8]
c0d01718:	e77e      	b.n	c0d01618 <snprintf+0xa0>
c0d0171a:	2001      	movs	r0, #1
c0d0171c:	9006      	str	r0, [sp, #24]
c0d0171e:	2010      	movs	r0, #16
c0d01720:	9003      	str	r0, [sp, #12]
c0d01722:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01724:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01726:	1d01      	adds	r1, r0, #4
c0d01728:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0172a:	2103      	movs	r1, #3
c0d0172c:	400a      	ands	r2, r1
c0d0172e:	1c5b      	adds	r3, r3, #1
c0d01730:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01732:	2a01      	cmp	r2, #1
c0d01734:	d100      	bne.n	c0d01738 <snprintf+0x1c0>
c0d01736:	e0b8      	b.n	c0d018aa <snprintf+0x332>
c0d01738:	2a02      	cmp	r2, #2
c0d0173a:	d100      	bne.n	c0d0173e <snprintf+0x1c6>
c0d0173c:	e104      	b.n	c0d01948 <snprintf+0x3d0>
c0d0173e:	2a03      	cmp	r2, #3
c0d01740:	4630      	mov	r0, r6
c0d01742:	d100      	bne.n	c0d01746 <snprintf+0x1ce>
c0d01744:	e768      	b.n	c0d01618 <snprintf+0xa0>
c0d01746:	9c08      	ldr	r4, [sp, #32]
c0d01748:	4625      	mov	r5, r4
c0d0174a:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d0174c:	1948      	adds	r0, r1, r5
c0d0174e:	7840      	ldrb	r0, [r0, #1]
c0d01750:	1c6d      	adds	r5, r5, #1
c0d01752:	2800      	cmp	r0, #0
c0d01754:	d1fa      	bne.n	c0d0174c <snprintf+0x1d4>
c0d01756:	e0ab      	b.n	c0d018b0 <snprintf+0x338>
c0d01758:	4606      	mov	r6, r0
c0d0175a:	920e      	str	r2, [sp, #56]	; 0x38
c0d0175c:	e109      	b.n	c0d01972 <snprintf+0x3fa>
c0d0175e:	2958      	cmp	r1, #88	; 0x58
c0d01760:	d000      	beq.n	c0d01764 <snprintf+0x1ec>
c0d01762:	e0f4      	b.n	c0d0194e <snprintf+0x3d6>
c0d01764:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01766:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01768:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0176a:	1d01      	adds	r1, r0, #4
c0d0176c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0176e:	6802      	ldr	r2, [r0, #0]
c0d01770:	2000      	movs	r0, #0
c0d01772:	9005      	str	r0, [sp, #20]
c0d01774:	2510      	movs	r5, #16
c0d01776:	e014      	b.n	c0d017a2 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01778:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0177a:	1d01      	adds	r1, r0, #4
c0d0177c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0177e:	6802      	ldr	r2, [r0, #0]
c0d01780:	2000      	movs	r0, #0
c0d01782:	e00c      	b.n	c0d0179e <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01784:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01786:	1d01      	adds	r1, r0, #4
c0d01788:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0178a:	6800      	ldr	r0, [r0, #0]
c0d0178c:	e087      	b.n	c0d0189e <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0178e:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01790:	1d01      	adds	r1, r0, #4
c0d01792:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01794:	6800      	ldr	r0, [r0, #0]
c0d01796:	17c1      	asrs	r1, r0, #31
c0d01798:	1842      	adds	r2, r0, r1
c0d0179a:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d0179c:	0fc0      	lsrs	r0, r0, #31
c0d0179e:	9005      	str	r0, [sp, #20]
c0d017a0:	250a      	movs	r5, #10
c0d017a2:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017a4:	4295      	cmp	r5, r2
c0d017a6:	920e      	str	r2, [sp, #56]	; 0x38
c0d017a8:	d814      	bhi.n	c0d017d4 <snprintf+0x25c>
c0d017aa:	2201      	movs	r2, #1
c0d017ac:	4628      	mov	r0, r5
c0d017ae:	920b      	str	r2, [sp, #44]	; 0x2c
c0d017b0:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d017b2:	4629      	mov	r1, r5
c0d017b4:	f001 fb4a 	bl	c0d02e4c <__aeabi_uidiv>
c0d017b8:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d017ba:	4288      	cmp	r0, r1
c0d017bc:	d109      	bne.n	c0d017d2 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017be:	4628      	mov	r0, r5
c0d017c0:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d017c2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d017c4:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d017c6:	910d      	str	r1, [sp, #52]	; 0x34
c0d017c8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d017ca:	4288      	cmp	r0, r1
c0d017cc:	4622      	mov	r2, r4
c0d017ce:	d9ee      	bls.n	c0d017ae <snprintf+0x236>
c0d017d0:	e000      	b.n	c0d017d4 <snprintf+0x25c>
c0d017d2:	460c      	mov	r4, r1
c0d017d4:	950c      	str	r5, [sp, #48]	; 0x30
c0d017d6:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d017d8:	2000      	movs	r0, #0
c0d017da:	4603      	mov	r3, r0
c0d017dc:	43c1      	mvns	r1, r0
c0d017de:	9c05      	ldr	r4, [sp, #20]
c0d017e0:	2c00      	cmp	r4, #0
c0d017e2:	d100      	bne.n	c0d017e6 <snprintf+0x26e>
c0d017e4:	4621      	mov	r1, r4
c0d017e6:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d017e8:	910b      	str	r1, [sp, #44]	; 0x2c
c0d017ea:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d017ec:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d017ee:	b2ca      	uxtb	r2, r1
c0d017f0:	2a30      	cmp	r2, #48	; 0x30
c0d017f2:	d106      	bne.n	c0d01802 <snprintf+0x28a>
c0d017f4:	2c00      	cmp	r4, #0
c0d017f6:	d004      	beq.n	c0d01802 <snprintf+0x28a>
c0d017f8:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d017fa:	232d      	movs	r3, #45	; 0x2d
c0d017fc:	700b      	strb	r3, [r1, #0]
c0d017fe:	2400      	movs	r4, #0
c0d01800:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01802:	1e81      	subs	r1, r0, #2
c0d01804:	290d      	cmp	r1, #13
c0d01806:	d80d      	bhi.n	c0d01824 <snprintf+0x2ac>
c0d01808:	1e41      	subs	r1, r0, #1
c0d0180a:	d00b      	beq.n	c0d01824 <snprintf+0x2ac>
c0d0180c:	a810      	add	r0, sp, #64	; 0x40
c0d0180e:	9405      	str	r4, [sp, #20]
c0d01810:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01812:	4320      	orrs	r0, r4
c0d01814:	f001 fc9a 	bl	c0d0314c <__aeabi_memset>
c0d01818:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0181a:	1900      	adds	r0, r0, r4
c0d0181c:	9c05      	ldr	r4, [sp, #20]
c0d0181e:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01820:	1840      	adds	r0, r0, r1
c0d01822:	1e43      	subs	r3, r0, #1
c0d01824:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01826:	2c00      	cmp	r4, #0
c0d01828:	9601      	str	r6, [sp, #4]
c0d0182a:	d003      	beq.n	c0d01834 <snprintf+0x2bc>
c0d0182c:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d0182e:	222d      	movs	r2, #45	; 0x2d
c0d01830:	54c2      	strb	r2, [r0, r3]
c0d01832:	1c5b      	adds	r3, r3, #1
c0d01834:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01836:	2900      	cmp	r1, #0
c0d01838:	d003      	beq.n	c0d01842 <snprintf+0x2ca>
c0d0183a:	2800      	cmp	r0, #0
c0d0183c:	d003      	beq.n	c0d01846 <snprintf+0x2ce>
c0d0183e:	a06c      	add	r0, pc, #432	; (adr r0, c0d019f0 <g_pcHex_cap>)
c0d01840:	e002      	b.n	c0d01848 <snprintf+0x2d0>
c0d01842:	461c      	mov	r4, r3
c0d01844:	e016      	b.n	c0d01874 <snprintf+0x2fc>
c0d01846:	a06e      	add	r0, pc, #440	; (adr r0, c0d01a00 <g_pcHex>)
c0d01848:	900d      	str	r0, [sp, #52]	; 0x34
c0d0184a:	461c      	mov	r4, r3
c0d0184c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0184e:	460e      	mov	r6, r1
c0d01850:	f001 fafc 	bl	c0d02e4c <__aeabi_uidiv>
c0d01854:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01856:	4629      	mov	r1, r5
c0d01858:	f001 fb7e 	bl	c0d02f58 <__aeabi_uidivmod>
c0d0185c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0185e:	5c40      	ldrb	r0, [r0, r1]
c0d01860:	a910      	add	r1, sp, #64	; 0x40
c0d01862:	5508      	strb	r0, [r1, r4]
c0d01864:	4630      	mov	r0, r6
c0d01866:	4629      	mov	r1, r5
c0d01868:	f001 faf0 	bl	c0d02e4c <__aeabi_uidiv>
c0d0186c:	1c64      	adds	r4, r4, #1
c0d0186e:	42b5      	cmp	r5, r6
c0d01870:	4601      	mov	r1, r0
c0d01872:	d9eb      	bls.n	c0d0184c <snprintf+0x2d4>
c0d01874:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01876:	429c      	cmp	r4, r3
c0d01878:	4625      	mov	r5, r4
c0d0187a:	d300      	bcc.n	c0d0187e <snprintf+0x306>
c0d0187c:	461d      	mov	r5, r3
c0d0187e:	a910      	add	r1, sp, #64	; 0x40
c0d01880:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01882:	4620      	mov	r0, r4
c0d01884:	462a      	mov	r2, r5
c0d01886:	461e      	mov	r6, r3
c0d01888:	f7ff fa46 	bl	c0d00d18 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d0188c:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d0188e:	1961      	adds	r1, r4, r5
c0d01890:	910e      	str	r1, [sp, #56]	; 0x38
c0d01892:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01894:	2800      	cmp	r0, #0
c0d01896:	9e01      	ldr	r6, [sp, #4]
c0d01898:	d16b      	bne.n	c0d01972 <snprintf+0x3fa>
c0d0189a:	e0a3      	b.n	c0d019e4 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d0189c:	2025      	movs	r0, #37	; 0x25
c0d0189e:	9907      	ldr	r1, [sp, #28]
c0d018a0:	7008      	strb	r0, [r1, #0]
c0d018a2:	9804      	ldr	r0, [sp, #16]
c0d018a4:	1e40      	subs	r0, r0, #1
c0d018a6:	1c49      	adds	r1, r1, #1
c0d018a8:	e05f      	b.n	c0d0196a <snprintf+0x3f2>
c0d018aa:	9d02      	ldr	r5, [sp, #8]
c0d018ac:	9c08      	ldr	r4, [sp, #32]
c0d018ae:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d018b0:	9803      	ldr	r0, [sp, #12]
c0d018b2:	2810      	cmp	r0, #16
c0d018b4:	9807      	ldr	r0, [sp, #28]
c0d018b6:	d161      	bne.n	c0d0197c <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d018b8:	2d00      	cmp	r5, #0
c0d018ba:	d06a      	beq.n	c0d01992 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d018bc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d018be:	1900      	adds	r0, r0, r4
c0d018c0:	900e      	str	r0, [sp, #56]	; 0x38
c0d018c2:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d018c4:	1aa0      	subs	r0, r4, r2
c0d018c6:	9b05      	ldr	r3, [sp, #20]
c0d018c8:	4283      	cmp	r3, r0
c0d018ca:	d800      	bhi.n	c0d018ce <snprintf+0x356>
c0d018cc:	4603      	mov	r3, r0
c0d018ce:	930c      	str	r3, [sp, #48]	; 0x30
c0d018d0:	435c      	muls	r4, r3
c0d018d2:	940a      	str	r4, [sp, #40]	; 0x28
c0d018d4:	1c60      	adds	r0, r4, #1
c0d018d6:	9007      	str	r0, [sp, #28]
c0d018d8:	2000      	movs	r0, #0
c0d018da:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d018dc:	9100      	str	r1, [sp, #0]
c0d018de:	940e      	str	r4, [sp, #56]	; 0x38
c0d018e0:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d018e2:	18e3      	adds	r3, r4, r3
c0d018e4:	900d      	str	r0, [sp, #52]	; 0x34
c0d018e6:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d018e8:	200f      	movs	r0, #15
c0d018ea:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d018ec:	0909      	lsrs	r1, r1, #4
c0d018ee:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d018f0:	18a4      	adds	r4, r4, r2
c0d018f2:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d018f4:	2c02      	cmp	r4, #2
c0d018f6:	d375      	bcc.n	c0d019e4 <snprintf+0x46c>
c0d018f8:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d018fa:	2c01      	cmp	r4, #1
c0d018fc:	d003      	beq.n	c0d01906 <snprintf+0x38e>
c0d018fe:	2c00      	cmp	r4, #0
c0d01900:	d108      	bne.n	c0d01914 <snprintf+0x39c>
c0d01902:	a43f      	add	r4, pc, #252	; (adr r4, c0d01a00 <g_pcHex>)
c0d01904:	e000      	b.n	c0d01908 <snprintf+0x390>
c0d01906:	a43a      	add	r4, pc, #232	; (adr r4, c0d019f0 <g_pcHex_cap>)
c0d01908:	b2c9      	uxtb	r1, r1
c0d0190a:	5c61      	ldrb	r1, [r4, r1]
c0d0190c:	7019      	strb	r1, [r3, #0]
c0d0190e:	b2c0      	uxtb	r0, r0
c0d01910:	5c20      	ldrb	r0, [r4, r0]
c0d01912:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01914:	9807      	ldr	r0, [sp, #28]
c0d01916:	4290      	cmp	r0, r2
c0d01918:	d064      	beq.n	c0d019e4 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d0191a:	1e92      	subs	r2, r2, #2
c0d0191c:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d0191e:	1ca4      	adds	r4, r4, #2
c0d01920:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01922:	1c40      	adds	r0, r0, #1
c0d01924:	42a8      	cmp	r0, r5
c0d01926:	9900      	ldr	r1, [sp, #0]
c0d01928:	d3d9      	bcc.n	c0d018de <snprintf+0x366>
c0d0192a:	900d      	str	r0, [sp, #52]	; 0x34
c0d0192c:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d0192e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01930:	1a08      	subs	r0, r1, r0
c0d01932:	9b05      	ldr	r3, [sp, #20]
c0d01934:	4283      	cmp	r3, r0
c0d01936:	d800      	bhi.n	c0d0193a <snprintf+0x3c2>
c0d01938:	4603      	mov	r3, r0
c0d0193a:	4608      	mov	r0, r1
c0d0193c:	4358      	muls	r0, r3
c0d0193e:	1820      	adds	r0, r4, r0
c0d01940:	900e      	str	r0, [sp, #56]	; 0x38
c0d01942:	1898      	adds	r0, r3, r2
c0d01944:	1c43      	adds	r3, r0, #1
c0d01946:	e038      	b.n	c0d019ba <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01948:	7808      	ldrb	r0, [r1, #0]
c0d0194a:	2800      	cmp	r0, #0
c0d0194c:	d023      	beq.n	c0d01996 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d0194e:	2005      	movs	r0, #5
c0d01950:	9d04      	ldr	r5, [sp, #16]
c0d01952:	2d05      	cmp	r5, #5
c0d01954:	462c      	mov	r4, r5
c0d01956:	d300      	bcc.n	c0d0195a <snprintf+0x3e2>
c0d01958:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d0195a:	9807      	ldr	r0, [sp, #28]
c0d0195c:	a12c      	add	r1, pc, #176	; (adr r1, c0d01a10 <g_pcHex+0x10>)
c0d0195e:	4622      	mov	r2, r4
c0d01960:	f7ff f9da 	bl	c0d00d18 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01964:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01966:	9907      	ldr	r1, [sp, #28]
c0d01968:	1909      	adds	r1, r1, r4
c0d0196a:	910e      	str	r1, [sp, #56]	; 0x38
c0d0196c:	4603      	mov	r3, r0
c0d0196e:	2800      	cmp	r0, #0
c0d01970:	d038      	beq.n	c0d019e4 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01972:	7830      	ldrb	r0, [r6, #0]
c0d01974:	2800      	cmp	r0, #0
c0d01976:	9908      	ldr	r1, [sp, #32]
c0d01978:	d034      	beq.n	c0d019e4 <snprintf+0x46c>
c0d0197a:	e61f      	b.n	c0d015bc <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d0197c:	429d      	cmp	r5, r3
c0d0197e:	d300      	bcc.n	c0d01982 <snprintf+0x40a>
c0d01980:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01982:	462a      	mov	r2, r5
c0d01984:	461c      	mov	r4, r3
c0d01986:	f7ff f9c7 	bl	c0d00d18 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d0198a:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d0198c:	9907      	ldr	r1, [sp, #28]
c0d0198e:	1949      	adds	r1, r1, r5
c0d01990:	e00f      	b.n	c0d019b2 <snprintf+0x43a>
c0d01992:	900e      	str	r0, [sp, #56]	; 0x38
c0d01994:	e7ed      	b.n	c0d01972 <snprintf+0x3fa>
c0d01996:	9b04      	ldr	r3, [sp, #16]
c0d01998:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d0199a:	429c      	cmp	r4, r3
c0d0199c:	d300      	bcc.n	c0d019a0 <snprintf+0x428>
c0d0199e:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d019a0:	2120      	movs	r1, #32
c0d019a2:	9807      	ldr	r0, [sp, #28]
c0d019a4:	4622      	mov	r2, r4
c0d019a6:	f7ff f9ad 	bl	c0d00d04 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d019aa:	9804      	ldr	r0, [sp, #16]
c0d019ac:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d019ae:	9907      	ldr	r1, [sp, #28]
c0d019b0:	1909      	adds	r1, r1, r4
c0d019b2:	910e      	str	r1, [sp, #56]	; 0x38
c0d019b4:	4603      	mov	r3, r0
c0d019b6:	2800      	cmp	r0, #0
c0d019b8:	d014      	beq.n	c0d019e4 <snprintf+0x46c>
c0d019ba:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d019bc:	42a8      	cmp	r0, r5
c0d019be:	d9d8      	bls.n	c0d01972 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d019c0:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d019c2:	429a      	cmp	r2, r3
c0d019c4:	d300      	bcc.n	c0d019c8 <snprintf+0x450>
c0d019c6:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d019c8:	2120      	movs	r1, #32
c0d019ca:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d019cc:	4628      	mov	r0, r5
c0d019ce:	920d      	str	r2, [sp, #52]	; 0x34
c0d019d0:	461c      	mov	r4, r3
c0d019d2:	f7ff f997 	bl	c0d00d04 <os_memset>
c0d019d6:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d019d8:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d019da:	182d      	adds	r5, r5, r0
c0d019dc:	950e      	str	r5, [sp, #56]	; 0x38
c0d019de:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d019e0:	2c00      	cmp	r4, #0
c0d019e2:	d1c6      	bne.n	c0d01972 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d019e4:	2000      	movs	r0, #0
c0d019e6:	b014      	add	sp, #80	; 0x50
c0d019e8:	bcf0      	pop	{r4, r5, r6, r7}
c0d019ea:	bc02      	pop	{r1}
c0d019ec:	b001      	add	sp, #4
c0d019ee:	4708      	bx	r1

c0d019f0 <g_pcHex_cap>:
c0d019f0:	33323130 	.word	0x33323130
c0d019f4:	37363534 	.word	0x37363534
c0d019f8:	42413938 	.word	0x42413938
c0d019fc:	46454443 	.word	0x46454443

c0d01a00 <g_pcHex>:
c0d01a00:	33323130 	.word	0x33323130
c0d01a04:	37363534 	.word	0x37363534
c0d01a08:	62613938 	.word	0x62613938
c0d01a0c:	66656463 	.word	0x66656463
c0d01a10:	4f525245 	.word	0x4f525245
c0d01a14:	00000052 	.word	0x00000052

c0d01a18 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01a18:	b580      	push	{r7, lr}
c0d01a1a:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01a1c:	4904      	ldr	r1, [pc, #16]	; (c0d01a30 <pic+0x18>)
c0d01a1e:	4288      	cmp	r0, r1
c0d01a20:	d304      	bcc.n	c0d01a2c <pic+0x14>
c0d01a22:	4904      	ldr	r1, [pc, #16]	; (c0d01a34 <pic+0x1c>)
c0d01a24:	4288      	cmp	r0, r1
c0d01a26:	d201      	bcs.n	c0d01a2c <pic+0x14>
		link_address = pic_internal(link_address);
c0d01a28:	f000 f806 	bl	c0d01a38 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01a2c:	bd80      	pop	{r7, pc}
c0d01a2e:	46c0      	nop			; (mov r8, r8)
c0d01a30:	c0d00000 	.word	0xc0d00000
c0d01a34:	c0d03800 	.word	0xc0d03800

c0d01a38 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01a38:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01a3a:	4902      	ldr	r1, [pc, #8]	; (c0d01a44 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01a3c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01a3e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01a40:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01a42:	4770      	bx	lr
c0d01a44:	c0d01a39 	.word	0xc0d01a39

c0d01a48 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01a48:	b580      	push	{r7, lr}
c0d01a4a:	af00      	add	r7, sp, #0
c0d01a4c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01a4e:	490a      	ldr	r1, [pc, #40]	; (c0d01a78 <check_api_level+0x30>)
c0d01a50:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a52:	490a      	ldr	r1, [pc, #40]	; (c0d01a7c <check_api_level+0x34>)
c0d01a54:	680a      	ldr	r2, [r1, #0]
c0d01a56:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01a58:	9003      	str	r0, [sp, #12]
c0d01a5a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a5c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a5e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a60:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01a62:	4807      	ldr	r0, [pc, #28]	; (c0d01a80 <check_api_level+0x38>)
c0d01a64:	9a01      	ldr	r2, [sp, #4]
c0d01a66:	4282      	cmp	r2, r0
c0d01a68:	d101      	bne.n	c0d01a6e <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01a6a:	b004      	add	sp, #16
c0d01a6c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a6e:	6808      	ldr	r0, [r1, #0]
c0d01a70:	2104      	movs	r1, #4
c0d01a72:	f001 fc03 	bl	c0d0327c <longjmp>
c0d01a76:	46c0      	nop			; (mov r8, r8)
c0d01a78:	60000137 	.word	0x60000137
c0d01a7c:	20001bb8 	.word	0x20001bb8
c0d01a80:	900001c6 	.word	0x900001c6

c0d01a84 <reset>:
  }
}

void reset ( void ) 
{
c0d01a84:	b580      	push	{r7, lr}
c0d01a86:	af00      	add	r7, sp, #0
c0d01a88:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01a8a:	4809      	ldr	r0, [pc, #36]	; (c0d01ab0 <reset+0x2c>)
c0d01a8c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a8e:	4809      	ldr	r0, [pc, #36]	; (c0d01ab4 <reset+0x30>)
c0d01a90:	6801      	ldr	r1, [r0, #0]
c0d01a92:	9101      	str	r1, [sp, #4]
c0d01a94:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a96:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01a98:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a9a:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01a9c:	4906      	ldr	r1, [pc, #24]	; (c0d01ab8 <reset+0x34>)
c0d01a9e:	9a00      	ldr	r2, [sp, #0]
c0d01aa0:	428a      	cmp	r2, r1
c0d01aa2:	d101      	bne.n	c0d01aa8 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01aa4:	b002      	add	sp, #8
c0d01aa6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01aa8:	6800      	ldr	r0, [r0, #0]
c0d01aaa:	2104      	movs	r1, #4
c0d01aac:	f001 fbe6 	bl	c0d0327c <longjmp>
c0d01ab0:	60000200 	.word	0x60000200
c0d01ab4:	20001bb8 	.word	0x20001bb8
c0d01ab8:	900002f1 	.word	0x900002f1

c0d01abc <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01abc:	b5d0      	push	{r4, r6, r7, lr}
c0d01abe:	af02      	add	r7, sp, #8
c0d01ac0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01ac2:	4b0a      	ldr	r3, [pc, #40]	; (c0d01aec <nvm_write+0x30>)
c0d01ac4:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ac6:	4b0a      	ldr	r3, [pc, #40]	; (c0d01af0 <nvm_write+0x34>)
c0d01ac8:	681c      	ldr	r4, [r3, #0]
c0d01aca:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01acc:	ac03      	add	r4, sp, #12
c0d01ace:	c407      	stmia	r4!, {r0, r1, r2}
c0d01ad0:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ad2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ad4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ad6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01ad8:	4806      	ldr	r0, [pc, #24]	; (c0d01af4 <nvm_write+0x38>)
c0d01ada:	9901      	ldr	r1, [sp, #4]
c0d01adc:	4281      	cmp	r1, r0
c0d01ade:	d101      	bne.n	c0d01ae4 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01ae0:	b006      	add	sp, #24
c0d01ae2:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ae4:	6818      	ldr	r0, [r3, #0]
c0d01ae6:	2104      	movs	r1, #4
c0d01ae8:	f001 fbc8 	bl	c0d0327c <longjmp>
c0d01aec:	6000037f 	.word	0x6000037f
c0d01af0:	20001bb8 	.word	0x20001bb8
c0d01af4:	900003bc 	.word	0x900003bc

c0d01af8 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01af8:	b580      	push	{r7, lr}
c0d01afa:	af00      	add	r7, sp, #0
c0d01afc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01afe:	4a0a      	ldr	r2, [pc, #40]	; (c0d01b28 <cx_rng+0x30>)
c0d01b00:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b02:	4a0a      	ldr	r2, [pc, #40]	; (c0d01b2c <cx_rng+0x34>)
c0d01b04:	6813      	ldr	r3, [r2, #0]
c0d01b06:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01b08:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01b0a:	9103      	str	r1, [sp, #12]
c0d01b0c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b0e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b10:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b12:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01b14:	4906      	ldr	r1, [pc, #24]	; (c0d01b30 <cx_rng+0x38>)
c0d01b16:	9b00      	ldr	r3, [sp, #0]
c0d01b18:	428b      	cmp	r3, r1
c0d01b1a:	d101      	bne.n	c0d01b20 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01b1c:	b004      	add	sp, #16
c0d01b1e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b20:	6810      	ldr	r0, [r2, #0]
c0d01b22:	2104      	movs	r1, #4
c0d01b24:	f001 fbaa 	bl	c0d0327c <longjmp>
c0d01b28:	6000052c 	.word	0x6000052c
c0d01b2c:	20001bb8 	.word	0x20001bb8
c0d01b30:	90000567 	.word	0x90000567

c0d01b34 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d01b34:	b580      	push	{r7, lr}
c0d01b36:	af00      	add	r7, sp, #0
c0d01b38:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d01b3a:	490a      	ldr	r1, [pc, #40]	; (c0d01b64 <cx_sha256_init+0x30>)
c0d01b3c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b3e:	490a      	ldr	r1, [pc, #40]	; (c0d01b68 <cx_sha256_init+0x34>)
c0d01b40:	680a      	ldr	r2, [r1, #0]
c0d01b42:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01b44:	9003      	str	r0, [sp, #12]
c0d01b46:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b48:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b4a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b4c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01b4e:	4a07      	ldr	r2, [pc, #28]	; (c0d01b6c <cx_sha256_init+0x38>)
c0d01b50:	9b01      	ldr	r3, [sp, #4]
c0d01b52:	4293      	cmp	r3, r2
c0d01b54:	d101      	bne.n	c0d01b5a <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b56:	b004      	add	sp, #16
c0d01b58:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b5a:	6808      	ldr	r0, [r1, #0]
c0d01b5c:	2104      	movs	r1, #4
c0d01b5e:	f001 fb8d 	bl	c0d0327c <longjmp>
c0d01b62:	46c0      	nop			; (mov r8, r8)
c0d01b64:	600008db 	.word	0x600008db
c0d01b68:	20001bb8 	.word	0x20001bb8
c0d01b6c:	90000864 	.word	0x90000864

c0d01b70 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01b70:	b580      	push	{r7, lr}
c0d01b72:	af00      	add	r7, sp, #0
c0d01b74:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01b76:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ba0 <cx_keccak_init+0x30>)
c0d01b78:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b7a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ba4 <cx_keccak_init+0x34>)
c0d01b7c:	6813      	ldr	r3, [r2, #0]
c0d01b7e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01b80:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01b82:	9103      	str	r1, [sp, #12]
c0d01b84:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b86:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b88:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b8a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01b8c:	4906      	ldr	r1, [pc, #24]	; (c0d01ba8 <cx_keccak_init+0x38>)
c0d01b8e:	9b00      	ldr	r3, [sp, #0]
c0d01b90:	428b      	cmp	r3, r1
c0d01b92:	d101      	bne.n	c0d01b98 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b94:	b004      	add	sp, #16
c0d01b96:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b98:	6810      	ldr	r0, [r2, #0]
c0d01b9a:	2104      	movs	r1, #4
c0d01b9c:	f001 fb6e 	bl	c0d0327c <longjmp>
c0d01ba0:	60000c3c 	.word	0x60000c3c
c0d01ba4:	20001bb8 	.word	0x20001bb8
c0d01ba8:	90000c39 	.word	0x90000c39

c0d01bac <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01bac:	b5b0      	push	{r4, r5, r7, lr}
c0d01bae:	af02      	add	r7, sp, #8
c0d01bb0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01bb2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01be0 <cx_hash+0x34>)
c0d01bb4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bb6:	4c0b      	ldr	r4, [pc, #44]	; (c0d01be4 <cx_hash+0x38>)
c0d01bb8:	6825      	ldr	r5, [r4, #0]
c0d01bba:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01bbc:	ad03      	add	r5, sp, #12
c0d01bbe:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01bc0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01bc2:	9007      	str	r0, [sp, #28]
c0d01bc4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bc6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bc8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bca:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01bcc:	4906      	ldr	r1, [pc, #24]	; (c0d01be8 <cx_hash+0x3c>)
c0d01bce:	9a01      	ldr	r2, [sp, #4]
c0d01bd0:	428a      	cmp	r2, r1
c0d01bd2:	d101      	bne.n	c0d01bd8 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01bd4:	b008      	add	sp, #32
c0d01bd6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bd8:	6820      	ldr	r0, [r4, #0]
c0d01bda:	2104      	movs	r1, #4
c0d01bdc:	f001 fb4e 	bl	c0d0327c <longjmp>
c0d01be0:	60000ea6 	.word	0x60000ea6
c0d01be4:	20001bb8 	.word	0x20001bb8
c0d01be8:	90000e46 	.word	0x90000e46

c0d01bec <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01bec:	b5b0      	push	{r4, r5, r7, lr}
c0d01bee:	af02      	add	r7, sp, #8
c0d01bf0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01bf2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c1c <cx_ecfp_init_public_key+0x30>)
c0d01bf4:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01bf6:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c20 <cx_ecfp_init_public_key+0x34>)
c0d01bf8:	6825      	ldr	r5, [r4, #0]
c0d01bfa:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01bfc:	ad02      	add	r5, sp, #8
c0d01bfe:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c00:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c02:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c04:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c06:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01c08:	4906      	ldr	r1, [pc, #24]	; (c0d01c24 <cx_ecfp_init_public_key+0x38>)
c0d01c0a:	9a00      	ldr	r2, [sp, #0]
c0d01c0c:	428a      	cmp	r2, r1
c0d01c0e:	d101      	bne.n	c0d01c14 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c10:	b006      	add	sp, #24
c0d01c12:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c14:	6820      	ldr	r0, [r4, #0]
c0d01c16:	2104      	movs	r1, #4
c0d01c18:	f001 fb30 	bl	c0d0327c <longjmp>
c0d01c1c:	60002835 	.word	0x60002835
c0d01c20:	20001bb8 	.word	0x20001bb8
c0d01c24:	900028f0 	.word	0x900028f0

c0d01c28 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01c28:	b5b0      	push	{r4, r5, r7, lr}
c0d01c2a:	af02      	add	r7, sp, #8
c0d01c2c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01c2e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c58 <cx_ecfp_init_private_key+0x30>)
c0d01c30:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c32:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c5c <cx_ecfp_init_private_key+0x34>)
c0d01c34:	6825      	ldr	r5, [r4, #0]
c0d01c36:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c38:	ad02      	add	r5, sp, #8
c0d01c3a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c3c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c3e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c40:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c42:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01c44:	4906      	ldr	r1, [pc, #24]	; (c0d01c60 <cx_ecfp_init_private_key+0x38>)
c0d01c46:	9a00      	ldr	r2, [sp, #0]
c0d01c48:	428a      	cmp	r2, r1
c0d01c4a:	d101      	bne.n	c0d01c50 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c4c:	b006      	add	sp, #24
c0d01c4e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c50:	6820      	ldr	r0, [r4, #0]
c0d01c52:	2104      	movs	r1, #4
c0d01c54:	f001 fb12 	bl	c0d0327c <longjmp>
c0d01c58:	600029ed 	.word	0x600029ed
c0d01c5c:	20001bb8 	.word	0x20001bb8
c0d01c60:	900029ae 	.word	0x900029ae

c0d01c64 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01c64:	b5b0      	push	{r4, r5, r7, lr}
c0d01c66:	af02      	add	r7, sp, #8
c0d01c68:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01c6a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c94 <cx_ecfp_generate_pair+0x30>)
c0d01c6c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c6e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01c98 <cx_ecfp_generate_pair+0x34>)
c0d01c70:	6825      	ldr	r5, [r4, #0]
c0d01c72:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01c74:	ad02      	add	r5, sp, #8
c0d01c76:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01c78:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c7a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c7c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c7e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01c80:	4906      	ldr	r1, [pc, #24]	; (c0d01c9c <cx_ecfp_generate_pair+0x38>)
c0d01c82:	9a00      	ldr	r2, [sp, #0]
c0d01c84:	428a      	cmp	r2, r1
c0d01c86:	d101      	bne.n	c0d01c8c <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01c88:	b006      	add	sp, #24
c0d01c8a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c8c:	6820      	ldr	r0, [r4, #0]
c0d01c8e:	2104      	movs	r1, #4
c0d01c90:	f001 faf4 	bl	c0d0327c <longjmp>
c0d01c94:	60002a2e 	.word	0x60002a2e
c0d01c98:	20001bb8 	.word	0x20001bb8
c0d01c9c:	90002a74 	.word	0x90002a74

c0d01ca0 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01ca0:	b5b0      	push	{r4, r5, r7, lr}
c0d01ca2:	af02      	add	r7, sp, #8
c0d01ca4:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01ca6:	4c0b      	ldr	r4, [pc, #44]	; (c0d01cd4 <os_perso_derive_node_bip32+0x34>)
c0d01ca8:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01caa:	4c0b      	ldr	r4, [pc, #44]	; (c0d01cd8 <os_perso_derive_node_bip32+0x38>)
c0d01cac:	6825      	ldr	r5, [r4, #0]
c0d01cae:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01cb0:	ad03      	add	r5, sp, #12
c0d01cb2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01cb4:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01cb6:	9007      	str	r0, [sp, #28]
c0d01cb8:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cba:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cbc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cbe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01cc0:	4806      	ldr	r0, [pc, #24]	; (c0d01cdc <os_perso_derive_node_bip32+0x3c>)
c0d01cc2:	9901      	ldr	r1, [sp, #4]
c0d01cc4:	4281      	cmp	r1, r0
c0d01cc6:	d101      	bne.n	c0d01ccc <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01cc8:	b008      	add	sp, #32
c0d01cca:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ccc:	6820      	ldr	r0, [r4, #0]
c0d01cce:	2104      	movs	r1, #4
c0d01cd0:	f001 fad4 	bl	c0d0327c <longjmp>
c0d01cd4:	6000512b 	.word	0x6000512b
c0d01cd8:	20001bb8 	.word	0x20001bb8
c0d01cdc:	9000517f 	.word	0x9000517f

c0d01ce0 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01ce0:	b580      	push	{r7, lr}
c0d01ce2:	af00      	add	r7, sp, #0
c0d01ce4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01ce6:	490a      	ldr	r1, [pc, #40]	; (c0d01d10 <os_sched_exit+0x30>)
c0d01ce8:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cea:	490a      	ldr	r1, [pc, #40]	; (c0d01d14 <os_sched_exit+0x34>)
c0d01cec:	680a      	ldr	r2, [r1, #0]
c0d01cee:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01cf0:	9003      	str	r0, [sp, #12]
c0d01cf2:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cf4:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cf6:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cf8:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01cfa:	4807      	ldr	r0, [pc, #28]	; (c0d01d18 <os_sched_exit+0x38>)
c0d01cfc:	9a01      	ldr	r2, [sp, #4]
c0d01cfe:	4282      	cmp	r2, r0
c0d01d00:	d101      	bne.n	c0d01d06 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01d02:	b004      	add	sp, #16
c0d01d04:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d06:	6808      	ldr	r0, [r1, #0]
c0d01d08:	2104      	movs	r1, #4
c0d01d0a:	f001 fab7 	bl	c0d0327c <longjmp>
c0d01d0e:	46c0      	nop			; (mov r8, r8)
c0d01d10:	60005fe1 	.word	0x60005fe1
c0d01d14:	20001bb8 	.word	0x20001bb8
c0d01d18:	90005f6f 	.word	0x90005f6f

c0d01d1c <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01d1c:	b580      	push	{r7, lr}
c0d01d1e:	af00      	add	r7, sp, #0
c0d01d20:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01d22:	490a      	ldr	r1, [pc, #40]	; (c0d01d4c <os_ux+0x30>)
c0d01d24:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d26:	490a      	ldr	r1, [pc, #40]	; (c0d01d50 <os_ux+0x34>)
c0d01d28:	680a      	ldr	r2, [r1, #0]
c0d01d2a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01d2c:	9003      	str	r0, [sp, #12]
c0d01d2e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d30:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d32:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d34:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01d36:	4a07      	ldr	r2, [pc, #28]	; (c0d01d54 <os_ux+0x38>)
c0d01d38:	9b01      	ldr	r3, [sp, #4]
c0d01d3a:	4293      	cmp	r3, r2
c0d01d3c:	d101      	bne.n	c0d01d42 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01d3e:	b004      	add	sp, #16
c0d01d40:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d42:	6808      	ldr	r0, [r1, #0]
c0d01d44:	2104      	movs	r1, #4
c0d01d46:	f001 fa99 	bl	c0d0327c <longjmp>
c0d01d4a:	46c0      	nop			; (mov r8, r8)
c0d01d4c:	60006158 	.word	0x60006158
c0d01d50:	20001bb8 	.word	0x20001bb8
c0d01d54:	9000611f 	.word	0x9000611f

c0d01d58 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01d58:	b580      	push	{r7, lr}
c0d01d5a:	af00      	add	r7, sp, #0
c0d01d5c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01d5e:	4809      	ldr	r0, [pc, #36]	; (c0d01d84 <os_seph_features+0x2c>)
c0d01d60:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d62:	4909      	ldr	r1, [pc, #36]	; (c0d01d88 <os_seph_features+0x30>)
c0d01d64:	6808      	ldr	r0, [r1, #0]
c0d01d66:	9001      	str	r0, [sp, #4]
c0d01d68:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01d6a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01d6c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01d6e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01d70:	4a06      	ldr	r2, [pc, #24]	; (c0d01d8c <os_seph_features+0x34>)
c0d01d72:	9b00      	ldr	r3, [sp, #0]
c0d01d74:	4293      	cmp	r3, r2
c0d01d76:	d101      	bne.n	c0d01d7c <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01d78:	b002      	add	sp, #8
c0d01d7a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01d7c:	6808      	ldr	r0, [r1, #0]
c0d01d7e:	2104      	movs	r1, #4
c0d01d80:	f001 fa7c 	bl	c0d0327c <longjmp>
c0d01d84:	600064d6 	.word	0x600064d6
c0d01d88:	20001bb8 	.word	0x20001bb8
c0d01d8c:	90006444 	.word	0x90006444

c0d01d90 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01d90:	b580      	push	{r7, lr}
c0d01d92:	af00      	add	r7, sp, #0
c0d01d94:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01d96:	4a0a      	ldr	r2, [pc, #40]	; (c0d01dc0 <io_seproxyhal_spi_send+0x30>)
c0d01d98:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01d9a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01dc4 <io_seproxyhal_spi_send+0x34>)
c0d01d9c:	6813      	ldr	r3, [r2, #0]
c0d01d9e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01da0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01da2:	9103      	str	r1, [sp, #12]
c0d01da4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01da6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01da8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01daa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01dac:	4806      	ldr	r0, [pc, #24]	; (c0d01dc8 <io_seproxyhal_spi_send+0x38>)
c0d01dae:	9900      	ldr	r1, [sp, #0]
c0d01db0:	4281      	cmp	r1, r0
c0d01db2:	d101      	bne.n	c0d01db8 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01db4:	b004      	add	sp, #16
c0d01db6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01db8:	6810      	ldr	r0, [r2, #0]
c0d01dba:	2104      	movs	r1, #4
c0d01dbc:	f001 fa5e 	bl	c0d0327c <longjmp>
c0d01dc0:	60006a1c 	.word	0x60006a1c
c0d01dc4:	20001bb8 	.word	0x20001bb8
c0d01dc8:	90006af3 	.word	0x90006af3

c0d01dcc <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01dcc:	b580      	push	{r7, lr}
c0d01dce:	af00      	add	r7, sp, #0
c0d01dd0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01dd2:	4809      	ldr	r0, [pc, #36]	; (c0d01df8 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01dd4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01dd6:	4909      	ldr	r1, [pc, #36]	; (c0d01dfc <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01dd8:	6808      	ldr	r0, [r1, #0]
c0d01dda:	9001      	str	r0, [sp, #4]
c0d01ddc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01dde:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01de0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01de2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01de4:	4a06      	ldr	r2, [pc, #24]	; (c0d01e00 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01de6:	9b00      	ldr	r3, [sp, #0]
c0d01de8:	4293      	cmp	r3, r2
c0d01dea:	d101      	bne.n	c0d01df0 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01dec:	b002      	add	sp, #8
c0d01dee:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01df0:	6808      	ldr	r0, [r1, #0]
c0d01df2:	2104      	movs	r1, #4
c0d01df4:	f001 fa42 	bl	c0d0327c <longjmp>
c0d01df8:	60006bcf 	.word	0x60006bcf
c0d01dfc:	20001bb8 	.word	0x20001bb8
c0d01e00:	90006b7f 	.word	0x90006b7f

c0d01e04 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01e04:	b5d0      	push	{r4, r6, r7, lr}
c0d01e06:	af02      	add	r7, sp, #8
c0d01e08:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01e0a:	4b0b      	ldr	r3, [pc, #44]	; (c0d01e38 <io_seproxyhal_spi_recv+0x34>)
c0d01e0c:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01e0e:	4b0b      	ldr	r3, [pc, #44]	; (c0d01e3c <io_seproxyhal_spi_recv+0x38>)
c0d01e10:	681c      	ldr	r4, [r3, #0]
c0d01e12:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01e14:	ac03      	add	r4, sp, #12
c0d01e16:	c407      	stmia	r4!, {r0, r1, r2}
c0d01e18:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01e1a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01e1c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01e1e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01e20:	4907      	ldr	r1, [pc, #28]	; (c0d01e40 <io_seproxyhal_spi_recv+0x3c>)
c0d01e22:	9a01      	ldr	r2, [sp, #4]
c0d01e24:	428a      	cmp	r2, r1
c0d01e26:	d102      	bne.n	c0d01e2e <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01e28:	b280      	uxth	r0, r0
c0d01e2a:	b006      	add	sp, #24
c0d01e2c:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01e2e:	6818      	ldr	r0, [r3, #0]
c0d01e30:	2104      	movs	r1, #4
c0d01e32:	f001 fa23 	bl	c0d0327c <longjmp>
c0d01e36:	46c0      	nop			; (mov r8, r8)
c0d01e38:	60006cd1 	.word	0x60006cd1
c0d01e3c:	20001bb8 	.word	0x20001bb8
c0d01e40:	90006c2b 	.word	0x90006c2b

c0d01e44 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01e44:	b5b0      	push	{r4, r5, r7, lr}
c0d01e46:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01e48:	492c      	ldr	r1, [pc, #176]	; (c0d01efc <bagl_ui_nanos_screen1_button+0xb8>)
c0d01e4a:	4288      	cmp	r0, r1
c0d01e4c:	d006      	beq.n	c0d01e5c <bagl_ui_nanos_screen1_button+0x18>
c0d01e4e:	492c      	ldr	r1, [pc, #176]	; (c0d01f00 <bagl_ui_nanos_screen1_button+0xbc>)
c0d01e50:	4288      	cmp	r0, r1
c0d01e52:	d151      	bne.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01e54:	2000      	movs	r0, #0
c0d01e56:	f7ff ff43 	bl	c0d01ce0 <os_sched_exit>
c0d01e5a:	e04d      	b.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01e5c:	f7fe fba4 	bl	c0d005a8 <nvram_is_init>
c0d01e60:	2801      	cmp	r0, #1
c0d01e62:	d102      	bne.n	c0d01e6a <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01e64:	a029      	add	r0, pc, #164	; (adr r0, c0d01f0c <bagl_ui_nanos_screen1_button+0xc8>)
c0d01e66:	210d      	movs	r1, #13
c0d01e68:	e001      	b.n	c0d01e6e <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01e6a:	a026      	add	r0, pc, #152	; (adr r0, c0d01f04 <bagl_ui_nanos_screen1_button+0xc0>)
c0d01e6c:	2105      	movs	r1, #5
c0d01e6e:	2203      	movs	r2, #3
c0d01e70:	f7fe f918 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01e74:	4c29      	ldr	r4, [pc, #164]	; (c0d01f1c <bagl_ui_nanos_screen1_button+0xd8>)
c0d01e76:	482b      	ldr	r0, [pc, #172]	; (c0d01f24 <bagl_ui_nanos_screen1_button+0xe0>)
c0d01e78:	4478      	add	r0, pc
c0d01e7a:	6020      	str	r0, [r4, #0]
c0d01e7c:	2004      	movs	r0, #4
c0d01e7e:	6060      	str	r0, [r4, #4]
c0d01e80:	4829      	ldr	r0, [pc, #164]	; (c0d01f28 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01e82:	4478      	add	r0, pc
c0d01e84:	6120      	str	r0, [r4, #16]
c0d01e86:	2500      	movs	r5, #0
c0d01e88:	60e5      	str	r5, [r4, #12]
c0d01e8a:	2003      	movs	r0, #3
c0d01e8c:	7620      	strb	r0, [r4, #24]
c0d01e8e:	61e5      	str	r5, [r4, #28]
c0d01e90:	4620      	mov	r0, r4
c0d01e92:	3018      	adds	r0, #24
c0d01e94:	f7ff ff42 	bl	c0d01d1c <os_ux>
c0d01e98:	61e0      	str	r0, [r4, #28]
c0d01e9a:	f7ff f903 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d01e9e:	60a5      	str	r5, [r4, #8]
c0d01ea0:	6820      	ldr	r0, [r4, #0]
c0d01ea2:	2800      	cmp	r0, #0
c0d01ea4:	d028      	beq.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ea6:	69e0      	ldr	r0, [r4, #28]
c0d01ea8:	491d      	ldr	r1, [pc, #116]	; (c0d01f20 <bagl_ui_nanos_screen1_button+0xdc>)
c0d01eaa:	4288      	cmp	r0, r1
c0d01eac:	d116      	bne.n	c0d01edc <bagl_ui_nanos_screen1_button+0x98>
c0d01eae:	e023      	b.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01eb0:	6860      	ldr	r0, [r4, #4]
c0d01eb2:	4285      	cmp	r5, r0
c0d01eb4:	d220      	bcs.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01eb6:	f7ff ff89 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d01eba:	2800      	cmp	r0, #0
c0d01ebc:	d11c      	bne.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ebe:	68a0      	ldr	r0, [r4, #8]
c0d01ec0:	68e1      	ldr	r1, [r4, #12]
c0d01ec2:	2538      	movs	r5, #56	; 0x38
c0d01ec4:	4368      	muls	r0, r5
c0d01ec6:	6822      	ldr	r2, [r4, #0]
c0d01ec8:	1810      	adds	r0, r2, r0
c0d01eca:	2900      	cmp	r1, #0
c0d01ecc:	d009      	beq.n	c0d01ee2 <bagl_ui_nanos_screen1_button+0x9e>
c0d01ece:	4788      	blx	r1
c0d01ed0:	2800      	cmp	r0, #0
c0d01ed2:	d106      	bne.n	c0d01ee2 <bagl_ui_nanos_screen1_button+0x9e>
c0d01ed4:	68a0      	ldr	r0, [r4, #8]
c0d01ed6:	1c45      	adds	r5, r0, #1
c0d01ed8:	60a5      	str	r5, [r4, #8]
c0d01eda:	6820      	ldr	r0, [r4, #0]
c0d01edc:	2800      	cmp	r0, #0
c0d01ede:	d1e7      	bne.n	c0d01eb0 <bagl_ui_nanos_screen1_button+0x6c>
c0d01ee0:	e00a      	b.n	c0d01ef8 <bagl_ui_nanos_screen1_button+0xb4>
c0d01ee2:	2801      	cmp	r0, #1
c0d01ee4:	d103      	bne.n	c0d01eee <bagl_ui_nanos_screen1_button+0xaa>
c0d01ee6:	68a0      	ldr	r0, [r4, #8]
c0d01ee8:	4345      	muls	r5, r0
c0d01eea:	6820      	ldr	r0, [r4, #0]
c0d01eec:	1940      	adds	r0, r0, r5
c0d01eee:	f7fe fb91 	bl	c0d00614 <io_seproxyhal_display>
c0d01ef2:	68a0      	ldr	r0, [r4, #8]
c0d01ef4:	1c40      	adds	r0, r0, #1
c0d01ef6:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01ef8:	2000      	movs	r0, #0
c0d01efa:	bdb0      	pop	{r4, r5, r7, pc}
c0d01efc:	80000002 	.word	0x80000002
c0d01f00:	80000001 	.word	0x80000001
c0d01f04:	54494e49 	.word	0x54494e49
c0d01f08:	00000000 	.word	0x00000000
c0d01f0c:	6c697453 	.word	0x6c697453
c0d01f10:	6e75206c 	.word	0x6e75206c
c0d01f14:	74696e69 	.word	0x74696e69
c0d01f18:	00000000 	.word	0x00000000
c0d01f1c:	20001a98 	.word	0x20001a98
c0d01f20:	b0105044 	.word	0xb0105044
c0d01f24:	00001640 	.word	0x00001640
c0d01f28:	00000153 	.word	0x00000153

c0d01f2c <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01f2c:	b5b0      	push	{r4, r5, r7, lr}
c0d01f2e:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01f30:	2800      	cmp	r0, #0
c0d01f32:	d005      	beq.n	c0d01f40 <ui_display_debug+0x14>
c0d01f34:	2900      	cmp	r1, #0
c0d01f36:	d003      	beq.n	c0d01f40 <ui_display_debug+0x14>
c0d01f38:	2a00      	cmp	r2, #0
c0d01f3a:	d001      	beq.n	c0d01f40 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01f3c:	f7fe f8b2 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01f40:	4c21      	ldr	r4, [pc, #132]	; (c0d01fc8 <ui_display_debug+0x9c>)
c0d01f42:	4823      	ldr	r0, [pc, #140]	; (c0d01fd0 <ui_display_debug+0xa4>)
c0d01f44:	4478      	add	r0, pc
c0d01f46:	6020      	str	r0, [r4, #0]
c0d01f48:	2004      	movs	r0, #4
c0d01f4a:	6060      	str	r0, [r4, #4]
c0d01f4c:	4821      	ldr	r0, [pc, #132]	; (c0d01fd4 <ui_display_debug+0xa8>)
c0d01f4e:	4478      	add	r0, pc
c0d01f50:	6120      	str	r0, [r4, #16]
c0d01f52:	2500      	movs	r5, #0
c0d01f54:	60e5      	str	r5, [r4, #12]
c0d01f56:	2003      	movs	r0, #3
c0d01f58:	7620      	strb	r0, [r4, #24]
c0d01f5a:	61e5      	str	r5, [r4, #28]
c0d01f5c:	4620      	mov	r0, r4
c0d01f5e:	3018      	adds	r0, #24
c0d01f60:	f7ff fedc 	bl	c0d01d1c <os_ux>
c0d01f64:	61e0      	str	r0, [r4, #28]
c0d01f66:	f7ff f89d 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d01f6a:	60a5      	str	r5, [r4, #8]
c0d01f6c:	6820      	ldr	r0, [r4, #0]
c0d01f6e:	2800      	cmp	r0, #0
c0d01f70:	d028      	beq.n	c0d01fc4 <ui_display_debug+0x98>
c0d01f72:	69e0      	ldr	r0, [r4, #28]
c0d01f74:	4915      	ldr	r1, [pc, #84]	; (c0d01fcc <ui_display_debug+0xa0>)
c0d01f76:	4288      	cmp	r0, r1
c0d01f78:	d116      	bne.n	c0d01fa8 <ui_display_debug+0x7c>
c0d01f7a:	e023      	b.n	c0d01fc4 <ui_display_debug+0x98>
c0d01f7c:	6860      	ldr	r0, [r4, #4]
c0d01f7e:	4285      	cmp	r5, r0
c0d01f80:	d220      	bcs.n	c0d01fc4 <ui_display_debug+0x98>
c0d01f82:	f7ff ff23 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d01f86:	2800      	cmp	r0, #0
c0d01f88:	d11c      	bne.n	c0d01fc4 <ui_display_debug+0x98>
c0d01f8a:	68a0      	ldr	r0, [r4, #8]
c0d01f8c:	68e1      	ldr	r1, [r4, #12]
c0d01f8e:	2538      	movs	r5, #56	; 0x38
c0d01f90:	4368      	muls	r0, r5
c0d01f92:	6822      	ldr	r2, [r4, #0]
c0d01f94:	1810      	adds	r0, r2, r0
c0d01f96:	2900      	cmp	r1, #0
c0d01f98:	d009      	beq.n	c0d01fae <ui_display_debug+0x82>
c0d01f9a:	4788      	blx	r1
c0d01f9c:	2800      	cmp	r0, #0
c0d01f9e:	d106      	bne.n	c0d01fae <ui_display_debug+0x82>
c0d01fa0:	68a0      	ldr	r0, [r4, #8]
c0d01fa2:	1c45      	adds	r5, r0, #1
c0d01fa4:	60a5      	str	r5, [r4, #8]
c0d01fa6:	6820      	ldr	r0, [r4, #0]
c0d01fa8:	2800      	cmp	r0, #0
c0d01faa:	d1e7      	bne.n	c0d01f7c <ui_display_debug+0x50>
c0d01fac:	e00a      	b.n	c0d01fc4 <ui_display_debug+0x98>
c0d01fae:	2801      	cmp	r0, #1
c0d01fb0:	d103      	bne.n	c0d01fba <ui_display_debug+0x8e>
c0d01fb2:	68a0      	ldr	r0, [r4, #8]
c0d01fb4:	4345      	muls	r5, r0
c0d01fb6:	6820      	ldr	r0, [r4, #0]
c0d01fb8:	1940      	adds	r0, r0, r5
c0d01fba:	f7fe fb2b 	bl	c0d00614 <io_seproxyhal_display>
c0d01fbe:	68a0      	ldr	r0, [r4, #8]
c0d01fc0:	1c40      	adds	r0, r0, #1
c0d01fc2:	60a0      	str	r0, [r4, #8]
}
c0d01fc4:	bdb0      	pop	{r4, r5, r7, pc}
c0d01fc6:	46c0      	nop			; (mov r8, r8)
c0d01fc8:	20001a98 	.word	0x20001a98
c0d01fcc:	b0105044 	.word	0xb0105044
c0d01fd0:	00001574 	.word	0x00001574
c0d01fd4:	00000087 	.word	0x00000087

c0d01fd8 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01fd8:	b580      	push	{r7, lr}
c0d01fda:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d01fdc:	4905      	ldr	r1, [pc, #20]	; (c0d01ff4 <bagl_ui_nanos_screen2_button+0x1c>)
c0d01fde:	4288      	cmp	r0, r1
c0d01fe0:	d002      	beq.n	c0d01fe8 <bagl_ui_nanos_screen2_button+0x10>
c0d01fe2:	4905      	ldr	r1, [pc, #20]	; (c0d01ff8 <bagl_ui_nanos_screen2_button+0x20>)
c0d01fe4:	4288      	cmp	r0, r1
c0d01fe6:	d102      	bne.n	c0d01fee <bagl_ui_nanos_screen2_button+0x16>
c0d01fe8:	2000      	movs	r0, #0
c0d01fea:	f7ff fe79 	bl	c0d01ce0 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d01fee:	2000      	movs	r0, #0
c0d01ff0:	bd80      	pop	{r7, pc}
c0d01ff2:	46c0      	nop			; (mov r8, r8)
c0d01ff4:	80000002 	.word	0x80000002
c0d01ff8:	80000001 	.word	0x80000001

c0d01ffc <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d01ffc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ffe:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02000:	2001      	movs	r0, #1
c0d02002:	0204      	lsls	r4, r0, #8
c0d02004:	f7ff fea8 	bl	c0d01d58 <os_seph_features>
c0d02008:	4220      	tst	r0, r4
c0d0200a:	d136      	bne.n	c0d0207a <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d0200c:	4c3c      	ldr	r4, [pc, #240]	; (c0d02100 <ui_idle+0x104>)
c0d0200e:	4840      	ldr	r0, [pc, #256]	; (c0d02110 <ui_idle+0x114>)
c0d02010:	4478      	add	r0, pc
c0d02012:	6020      	str	r0, [r4, #0]
c0d02014:	2004      	movs	r0, #4
c0d02016:	6060      	str	r0, [r4, #4]
c0d02018:	483e      	ldr	r0, [pc, #248]	; (c0d02114 <ui_idle+0x118>)
c0d0201a:	4478      	add	r0, pc
c0d0201c:	6120      	str	r0, [r4, #16]
c0d0201e:	2500      	movs	r5, #0
c0d02020:	60e5      	str	r5, [r4, #12]
c0d02022:	2003      	movs	r0, #3
c0d02024:	7620      	strb	r0, [r4, #24]
c0d02026:	61e5      	str	r5, [r4, #28]
c0d02028:	4620      	mov	r0, r4
c0d0202a:	3018      	adds	r0, #24
c0d0202c:	f7ff fe76 	bl	c0d01d1c <os_ux>
c0d02030:	61e0      	str	r0, [r4, #28]
c0d02032:	f7ff f837 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d02036:	60a5      	str	r5, [r4, #8]
c0d02038:	6820      	ldr	r0, [r4, #0]
c0d0203a:	2800      	cmp	r0, #0
c0d0203c:	d05f      	beq.n	c0d020fe <ui_idle+0x102>
c0d0203e:	69e0      	ldr	r0, [r4, #28]
c0d02040:	4930      	ldr	r1, [pc, #192]	; (c0d02104 <ui_idle+0x108>)
c0d02042:	4288      	cmp	r0, r1
c0d02044:	d116      	bne.n	c0d02074 <ui_idle+0x78>
c0d02046:	e05a      	b.n	c0d020fe <ui_idle+0x102>
c0d02048:	6860      	ldr	r0, [r4, #4]
c0d0204a:	4285      	cmp	r5, r0
c0d0204c:	d257      	bcs.n	c0d020fe <ui_idle+0x102>
c0d0204e:	f7ff febd 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d02052:	2800      	cmp	r0, #0
c0d02054:	d153      	bne.n	c0d020fe <ui_idle+0x102>
c0d02056:	68a0      	ldr	r0, [r4, #8]
c0d02058:	68e1      	ldr	r1, [r4, #12]
c0d0205a:	2538      	movs	r5, #56	; 0x38
c0d0205c:	4368      	muls	r0, r5
c0d0205e:	6822      	ldr	r2, [r4, #0]
c0d02060:	1810      	adds	r0, r2, r0
c0d02062:	2900      	cmp	r1, #0
c0d02064:	d040      	beq.n	c0d020e8 <ui_idle+0xec>
c0d02066:	4788      	blx	r1
c0d02068:	2800      	cmp	r0, #0
c0d0206a:	d13d      	bne.n	c0d020e8 <ui_idle+0xec>
c0d0206c:	68a0      	ldr	r0, [r4, #8]
c0d0206e:	1c45      	adds	r5, r0, #1
c0d02070:	60a5      	str	r5, [r4, #8]
c0d02072:	6820      	ldr	r0, [r4, #0]
c0d02074:	2800      	cmp	r0, #0
c0d02076:	d1e7      	bne.n	c0d02048 <ui_idle+0x4c>
c0d02078:	e041      	b.n	c0d020fe <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0207a:	4c21      	ldr	r4, [pc, #132]	; (c0d02100 <ui_idle+0x104>)
c0d0207c:	4822      	ldr	r0, [pc, #136]	; (c0d02108 <ui_idle+0x10c>)
c0d0207e:	4478      	add	r0, pc
c0d02080:	6020      	str	r0, [r4, #0]
c0d02082:	2004      	movs	r0, #4
c0d02084:	6060      	str	r0, [r4, #4]
c0d02086:	4821      	ldr	r0, [pc, #132]	; (c0d0210c <ui_idle+0x110>)
c0d02088:	4478      	add	r0, pc
c0d0208a:	6120      	str	r0, [r4, #16]
c0d0208c:	2500      	movs	r5, #0
c0d0208e:	60e5      	str	r5, [r4, #12]
c0d02090:	2003      	movs	r0, #3
c0d02092:	7620      	strb	r0, [r4, #24]
c0d02094:	61e5      	str	r5, [r4, #28]
c0d02096:	4620      	mov	r0, r4
c0d02098:	3018      	adds	r0, #24
c0d0209a:	f7ff fe3f 	bl	c0d01d1c <os_ux>
c0d0209e:	61e0      	str	r0, [r4, #28]
c0d020a0:	f7ff f800 	bl	c0d010a4 <io_seproxyhal_init_ux>
c0d020a4:	60a5      	str	r5, [r4, #8]
c0d020a6:	6820      	ldr	r0, [r4, #0]
c0d020a8:	2800      	cmp	r0, #0
c0d020aa:	d028      	beq.n	c0d020fe <ui_idle+0x102>
c0d020ac:	69e0      	ldr	r0, [r4, #28]
c0d020ae:	4915      	ldr	r1, [pc, #84]	; (c0d02104 <ui_idle+0x108>)
c0d020b0:	4288      	cmp	r0, r1
c0d020b2:	d116      	bne.n	c0d020e2 <ui_idle+0xe6>
c0d020b4:	e023      	b.n	c0d020fe <ui_idle+0x102>
c0d020b6:	6860      	ldr	r0, [r4, #4]
c0d020b8:	4285      	cmp	r5, r0
c0d020ba:	d220      	bcs.n	c0d020fe <ui_idle+0x102>
c0d020bc:	f7ff fe86 	bl	c0d01dcc <io_seproxyhal_spi_is_status_sent>
c0d020c0:	2800      	cmp	r0, #0
c0d020c2:	d11c      	bne.n	c0d020fe <ui_idle+0x102>
c0d020c4:	68a0      	ldr	r0, [r4, #8]
c0d020c6:	68e1      	ldr	r1, [r4, #12]
c0d020c8:	2538      	movs	r5, #56	; 0x38
c0d020ca:	4368      	muls	r0, r5
c0d020cc:	6822      	ldr	r2, [r4, #0]
c0d020ce:	1810      	adds	r0, r2, r0
c0d020d0:	2900      	cmp	r1, #0
c0d020d2:	d009      	beq.n	c0d020e8 <ui_idle+0xec>
c0d020d4:	4788      	blx	r1
c0d020d6:	2800      	cmp	r0, #0
c0d020d8:	d106      	bne.n	c0d020e8 <ui_idle+0xec>
c0d020da:	68a0      	ldr	r0, [r4, #8]
c0d020dc:	1c45      	adds	r5, r0, #1
c0d020de:	60a5      	str	r5, [r4, #8]
c0d020e0:	6820      	ldr	r0, [r4, #0]
c0d020e2:	2800      	cmp	r0, #0
c0d020e4:	d1e7      	bne.n	c0d020b6 <ui_idle+0xba>
c0d020e6:	e00a      	b.n	c0d020fe <ui_idle+0x102>
c0d020e8:	2801      	cmp	r0, #1
c0d020ea:	d103      	bne.n	c0d020f4 <ui_idle+0xf8>
c0d020ec:	68a0      	ldr	r0, [r4, #8]
c0d020ee:	4345      	muls	r5, r0
c0d020f0:	6820      	ldr	r0, [r4, #0]
c0d020f2:	1940      	adds	r0, r0, r5
c0d020f4:	f7fe fa8e 	bl	c0d00614 <io_seproxyhal_display>
c0d020f8:	68a0      	ldr	r0, [r4, #8]
c0d020fa:	1c40      	adds	r0, r0, #1
c0d020fc:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d020fe:	bdb0      	pop	{r4, r5, r7, pc}
c0d02100:	20001a98 	.word	0x20001a98
c0d02104:	b0105044 	.word	0xb0105044
c0d02108:	0000151a 	.word	0x0000151a
c0d0210c:	0000008d 	.word	0x0000008d
c0d02110:	000013c8 	.word	0x000013c8
c0d02114:	fffffe27 	.word	0xfffffe27

c0d02118 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02118:	2000      	movs	r0, #0
c0d0211a:	4770      	bx	lr

c0d0211c <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d0211c:	b5d0      	push	{r4, r6, r7, lr}
c0d0211e:	af02      	add	r7, sp, #8
c0d02120:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02122:	4620      	mov	r0, r4
c0d02124:	f7ff fddc 	bl	c0d01ce0 <os_sched_exit>
    return NULL;
c0d02128:	4620      	mov	r0, r4
c0d0212a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0212c <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d0212c:	4902      	ldr	r1, [pc, #8]	; (c0d02138 <USBD_LL_Init+0xc>)
c0d0212e:	2000      	movs	r0, #0
c0d02130:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02132:	4902      	ldr	r1, [pc, #8]	; (c0d0213c <USBD_LL_Init+0x10>)
c0d02134:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02136:	4770      	bx	lr
c0d02138:	20001d2c 	.word	0x20001d2c
c0d0213c:	20001d30 	.word	0x20001d30

c0d02140 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02140:	b5d0      	push	{r4, r6, r7, lr}
c0d02142:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02144:	4806      	ldr	r0, [pc, #24]	; (c0d02160 <USBD_LL_DeInit+0x20>)
c0d02146:	214f      	movs	r1, #79	; 0x4f
c0d02148:	7001      	strb	r1, [r0, #0]
c0d0214a:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0214c:	7044      	strb	r4, [r0, #1]
c0d0214e:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02150:	7081      	strb	r1, [r0, #2]
c0d02152:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02154:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02156:	2104      	movs	r1, #4
c0d02158:	f7ff fe1a 	bl	c0d01d90 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d0215c:	4620      	mov	r0, r4
c0d0215e:	bdd0      	pop	{r4, r6, r7, pc}
c0d02160:	20001a18 	.word	0x20001a18

c0d02164 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02164:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02166:	af03      	add	r7, sp, #12
c0d02168:	b083      	sub	sp, #12
c0d0216a:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0216c:	264f      	movs	r6, #79	; 0x4f
c0d0216e:	702e      	strb	r6, [r5, #0]
c0d02170:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02172:	706c      	strb	r4, [r5, #1]
c0d02174:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02176:	70a8      	strb	r0, [r5, #2]
c0d02178:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0217a:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d0217c:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0217e:	2105      	movs	r1, #5
c0d02180:	4628      	mov	r0, r5
c0d02182:	f7ff fe05 	bl	c0d01d90 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02186:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02188:	706c      	strb	r4, [r5, #1]
c0d0218a:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d0218c:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0218e:	70e8      	strb	r0, [r5, #3]
c0d02190:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02192:	4628      	mov	r0, r5
c0d02194:	f7ff fdfc 	bl	c0d01d90 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02198:	4620      	mov	r0, r4
c0d0219a:	b003      	add	sp, #12
c0d0219c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0219e <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0219e:	b5d0      	push	{r4, r6, r7, lr}
c0d021a0:	af02      	add	r7, sp, #8
c0d021a2:	b082      	sub	sp, #8
c0d021a4:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021a6:	214f      	movs	r1, #79	; 0x4f
c0d021a8:	7001      	strb	r1, [r0, #0]
c0d021aa:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d021ac:	7044      	strb	r4, [r0, #1]
c0d021ae:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d021b0:	7081      	strb	r1, [r0, #2]
c0d021b2:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d021b4:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d021b6:	2104      	movs	r1, #4
c0d021b8:	f7ff fdea 	bl	c0d01d90 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d021bc:	4620      	mov	r0, r4
c0d021be:	b002      	add	sp, #8
c0d021c0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d021c4 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d021c4:	b5b0      	push	{r4, r5, r7, lr}
c0d021c6:	af02      	add	r7, sp, #8
c0d021c8:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d021ca:	480f      	ldr	r0, [pc, #60]	; (c0d02208 <USBD_LL_OpenEP+0x44>)
c0d021cc:	2400      	movs	r4, #0
c0d021ce:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d021d0:	480e      	ldr	r0, [pc, #56]	; (c0d0220c <USBD_LL_OpenEP+0x48>)
c0d021d2:	6004      	str	r4, [r0, #0]
c0d021d4:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021d6:	254f      	movs	r5, #79	; 0x4f
c0d021d8:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d021da:	7044      	strb	r4, [r0, #1]
c0d021dc:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d021de:	7085      	strb	r5, [r0, #2]
c0d021e0:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d021e2:	70c5      	strb	r5, [r0, #3]
c0d021e4:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d021e6:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d021e8:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d021ea:	2a03      	cmp	r2, #3
c0d021ec:	d802      	bhi.n	c0d021f4 <USBD_LL_OpenEP+0x30>
c0d021ee:	00d0      	lsls	r0, r2, #3
c0d021f0:	4c07      	ldr	r4, [pc, #28]	; (c0d02210 <USBD_LL_OpenEP+0x4c>)
c0d021f2:	40c4      	lsrs	r4, r0
c0d021f4:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d021f6:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d021f8:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d021fa:	2108      	movs	r1, #8
c0d021fc:	f7ff fdc8 	bl	c0d01d90 <io_seproxyhal_spi_send>
c0d02200:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02202:	b002      	add	sp, #8
c0d02204:	bdb0      	pop	{r4, r5, r7, pc}
c0d02206:	46c0      	nop			; (mov r8, r8)
c0d02208:	20001d2c 	.word	0x20001d2c
c0d0220c:	20001d30 	.word	0x20001d30
c0d02210:	02030401 	.word	0x02030401

c0d02214 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02214:	b5d0      	push	{r4, r6, r7, lr}
c0d02216:	af02      	add	r7, sp, #8
c0d02218:	b082      	sub	sp, #8
c0d0221a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0221c:	224f      	movs	r2, #79	; 0x4f
c0d0221e:	7002      	strb	r2, [r0, #0]
c0d02220:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02222:	7044      	strb	r4, [r0, #1]
c0d02224:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02226:	7082      	strb	r2, [r0, #2]
c0d02228:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0222a:	70c2      	strb	r2, [r0, #3]
c0d0222c:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0222e:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02230:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02232:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02234:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02236:	2108      	movs	r1, #8
c0d02238:	f7ff fdaa 	bl	c0d01d90 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0223c:	4620      	mov	r0, r4
c0d0223e:	b002      	add	sp, #8
c0d02240:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02244 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02244:	b5b0      	push	{r4, r5, r7, lr}
c0d02246:	af02      	add	r7, sp, #8
c0d02248:	b082      	sub	sp, #8
c0d0224a:	460d      	mov	r5, r1
c0d0224c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0224e:	2150      	movs	r1, #80	; 0x50
c0d02250:	7001      	strb	r1, [r0, #0]
c0d02252:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02254:	7044      	strb	r4, [r0, #1]
c0d02256:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02258:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0225a:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0225c:	2140      	movs	r1, #64	; 0x40
c0d0225e:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02260:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02262:	2106      	movs	r1, #6
c0d02264:	f7ff fd94 	bl	c0d01d90 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02268:	2080      	movs	r0, #128	; 0x80
c0d0226a:	4205      	tst	r5, r0
c0d0226c:	d101      	bne.n	c0d02272 <USBD_LL_StallEP+0x2e>
c0d0226e:	4807      	ldr	r0, [pc, #28]	; (c0d0228c <USBD_LL_StallEP+0x48>)
c0d02270:	e000      	b.n	c0d02274 <USBD_LL_StallEP+0x30>
c0d02272:	4805      	ldr	r0, [pc, #20]	; (c0d02288 <USBD_LL_StallEP+0x44>)
c0d02274:	6801      	ldr	r1, [r0, #0]
c0d02276:	227f      	movs	r2, #127	; 0x7f
c0d02278:	4015      	ands	r5, r2
c0d0227a:	2201      	movs	r2, #1
c0d0227c:	40aa      	lsls	r2, r5
c0d0227e:	430a      	orrs	r2, r1
c0d02280:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02282:	4620      	mov	r0, r4
c0d02284:	b002      	add	sp, #8
c0d02286:	bdb0      	pop	{r4, r5, r7, pc}
c0d02288:	20001d2c 	.word	0x20001d2c
c0d0228c:	20001d30 	.word	0x20001d30

c0d02290 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02290:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02292:	af03      	add	r7, sp, #12
c0d02294:	b083      	sub	sp, #12
c0d02296:	460d      	mov	r5, r1
c0d02298:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0229a:	2150      	movs	r1, #80	; 0x50
c0d0229c:	7001      	strb	r1, [r0, #0]
c0d0229e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d022a0:	7044      	strb	r4, [r0, #1]
c0d022a2:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d022a4:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d022a6:	70c5      	strb	r5, [r0, #3]
c0d022a8:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d022aa:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d022ac:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d022ae:	2106      	movs	r1, #6
c0d022b0:	f7ff fd6e 	bl	c0d01d90 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d022b4:	4235      	tst	r5, r6
c0d022b6:	d101      	bne.n	c0d022bc <USBD_LL_ClearStallEP+0x2c>
c0d022b8:	4807      	ldr	r0, [pc, #28]	; (c0d022d8 <USBD_LL_ClearStallEP+0x48>)
c0d022ba:	e000      	b.n	c0d022be <USBD_LL_ClearStallEP+0x2e>
c0d022bc:	4805      	ldr	r0, [pc, #20]	; (c0d022d4 <USBD_LL_ClearStallEP+0x44>)
c0d022be:	6801      	ldr	r1, [r0, #0]
c0d022c0:	227f      	movs	r2, #127	; 0x7f
c0d022c2:	4015      	ands	r5, r2
c0d022c4:	2201      	movs	r2, #1
c0d022c6:	40aa      	lsls	r2, r5
c0d022c8:	4391      	bics	r1, r2
c0d022ca:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d022cc:	4620      	mov	r0, r4
c0d022ce:	b003      	add	sp, #12
c0d022d0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d022d2:	46c0      	nop			; (mov r8, r8)
c0d022d4:	20001d2c 	.word	0x20001d2c
c0d022d8:	20001d30 	.word	0x20001d30

c0d022dc <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d022dc:	2080      	movs	r0, #128	; 0x80
c0d022de:	4201      	tst	r1, r0
c0d022e0:	d001      	beq.n	c0d022e6 <USBD_LL_IsStallEP+0xa>
c0d022e2:	4806      	ldr	r0, [pc, #24]	; (c0d022fc <USBD_LL_IsStallEP+0x20>)
c0d022e4:	e000      	b.n	c0d022e8 <USBD_LL_IsStallEP+0xc>
c0d022e6:	4804      	ldr	r0, [pc, #16]	; (c0d022f8 <USBD_LL_IsStallEP+0x1c>)
c0d022e8:	6800      	ldr	r0, [r0, #0]
c0d022ea:	227f      	movs	r2, #127	; 0x7f
c0d022ec:	4011      	ands	r1, r2
c0d022ee:	2201      	movs	r2, #1
c0d022f0:	408a      	lsls	r2, r1
c0d022f2:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d022f4:	b2d0      	uxtb	r0, r2
c0d022f6:	4770      	bx	lr
c0d022f8:	20001d30 	.word	0x20001d30
c0d022fc:	20001d2c 	.word	0x20001d2c

c0d02300 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02300:	b5d0      	push	{r4, r6, r7, lr}
c0d02302:	af02      	add	r7, sp, #8
c0d02304:	b082      	sub	sp, #8
c0d02306:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02308:	224f      	movs	r2, #79	; 0x4f
c0d0230a:	7002      	strb	r2, [r0, #0]
c0d0230c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0230e:	7044      	strb	r4, [r0, #1]
c0d02310:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02312:	7082      	strb	r2, [r0, #2]
c0d02314:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02316:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02318:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0231a:	2105      	movs	r1, #5
c0d0231c:	f7ff fd38 	bl	c0d01d90 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02320:	4620      	mov	r0, r4
c0d02322:	b002      	add	sp, #8
c0d02324:	bdd0      	pop	{r4, r6, r7, pc}

c0d02326 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02326:	b5b0      	push	{r4, r5, r7, lr}
c0d02328:	af02      	add	r7, sp, #8
c0d0232a:	b082      	sub	sp, #8
c0d0232c:	461c      	mov	r4, r3
c0d0232e:	4615      	mov	r5, r2
c0d02330:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02332:	2250      	movs	r2, #80	; 0x50
c0d02334:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02336:	1ce2      	adds	r2, r4, #3
c0d02338:	0a13      	lsrs	r3, r2, #8
c0d0233a:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d0233c:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0233e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02340:	2120      	movs	r1, #32
c0d02342:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02344:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02346:	2106      	movs	r1, #6
c0d02348:	f7ff fd22 	bl	c0d01d90 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d0234c:	4628      	mov	r0, r5
c0d0234e:	4621      	mov	r1, r4
c0d02350:	f7ff fd1e 	bl	c0d01d90 <io_seproxyhal_spi_send>
c0d02354:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02356:	b002      	add	sp, #8
c0d02358:	bdb0      	pop	{r4, r5, r7, pc}

c0d0235a <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0235a:	b5d0      	push	{r4, r6, r7, lr}
c0d0235c:	af02      	add	r7, sp, #8
c0d0235e:	b082      	sub	sp, #8
c0d02360:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02362:	2350      	movs	r3, #80	; 0x50
c0d02364:	7003      	strb	r3, [r0, #0]
c0d02366:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02368:	7044      	strb	r4, [r0, #1]
c0d0236a:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d0236c:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0236e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02370:	2130      	movs	r1, #48	; 0x30
c0d02372:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02374:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02376:	2106      	movs	r1, #6
c0d02378:	f7ff fd0a 	bl	c0d01d90 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d0237c:	4620      	mov	r0, r4
c0d0237e:	b002      	add	sp, #8
c0d02380:	bdd0      	pop	{r4, r6, r7, pc}

c0d02382 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02382:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02384:	af03      	add	r7, sp, #12
c0d02386:	b081      	sub	sp, #4
c0d02388:	4615      	mov	r5, r2
c0d0238a:	460e      	mov	r6, r1
c0d0238c:	4604      	mov	r4, r0
c0d0238e:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02390:	2c00      	cmp	r4, #0
c0d02392:	d011      	beq.n	c0d023b8 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02394:	2049      	movs	r0, #73	; 0x49
c0d02396:	0081      	lsls	r1, r0, #2
c0d02398:	4620      	mov	r0, r4
c0d0239a:	f000 fecd 	bl	c0d03138 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0239e:	2e00      	cmp	r6, #0
c0d023a0:	d002      	beq.n	c0d023a8 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d023a2:	2011      	movs	r0, #17
c0d023a4:	0100      	lsls	r0, r0, #4
c0d023a6:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d023a8:	20fc      	movs	r0, #252	; 0xfc
c0d023aa:	2101      	movs	r1, #1
c0d023ac:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d023ae:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d023b0:	4620      	mov	r0, r4
c0d023b2:	f7ff febb 	bl	c0d0212c <USBD_LL_Init>
c0d023b6:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d023b8:	b2c0      	uxtb	r0, r0
c0d023ba:	b001      	add	sp, #4
c0d023bc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d023be <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d023be:	b5d0      	push	{r4, r6, r7, lr}
c0d023c0:	af02      	add	r7, sp, #8
c0d023c2:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d023c4:	20fc      	movs	r0, #252	; 0xfc
c0d023c6:	2101      	movs	r1, #1
c0d023c8:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d023ca:	2045      	movs	r0, #69	; 0x45
c0d023cc:	0080      	lsls	r0, r0, #2
c0d023ce:	5820      	ldr	r0, [r4, r0]
c0d023d0:	2800      	cmp	r0, #0
c0d023d2:	d006      	beq.n	c0d023e2 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d023d4:	6840      	ldr	r0, [r0, #4]
c0d023d6:	f7ff fb1f 	bl	c0d01a18 <pic>
c0d023da:	4602      	mov	r2, r0
c0d023dc:	7921      	ldrb	r1, [r4, #4]
c0d023de:	4620      	mov	r0, r4
c0d023e0:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d023e2:	4620      	mov	r0, r4
c0d023e4:	f7ff fedb 	bl	c0d0219e <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d023e8:	4620      	mov	r0, r4
c0d023ea:	f7ff fea9 	bl	c0d02140 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d023ee:	2000      	movs	r0, #0
c0d023f0:	bdd0      	pop	{r4, r6, r7, pc}

c0d023f2 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d023f2:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d023f4:	2900      	cmp	r1, #0
c0d023f6:	d003      	beq.n	c0d02400 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d023f8:	2245      	movs	r2, #69	; 0x45
c0d023fa:	0092      	lsls	r2, r2, #2
c0d023fc:	5081      	str	r1, [r0, r2]
c0d023fe:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02400:	b2d0      	uxtb	r0, r2
c0d02402:	4770      	bx	lr

c0d02404 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02404:	b580      	push	{r7, lr}
c0d02406:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02408:	f7ff feac 	bl	c0d02164 <USBD_LL_Start>
  
  return USBD_OK;  
c0d0240c:	2000      	movs	r0, #0
c0d0240e:	bd80      	pop	{r7, pc}

c0d02410 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02410:	b5b0      	push	{r4, r5, r7, lr}
c0d02412:	af02      	add	r7, sp, #8
c0d02414:	460c      	mov	r4, r1
c0d02416:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02418:	2045      	movs	r0, #69	; 0x45
c0d0241a:	0080      	lsls	r0, r0, #2
c0d0241c:	5828      	ldr	r0, [r5, r0]
c0d0241e:	2800      	cmp	r0, #0
c0d02420:	d00c      	beq.n	c0d0243c <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02422:	6800      	ldr	r0, [r0, #0]
c0d02424:	f7ff faf8 	bl	c0d01a18 <pic>
c0d02428:	4602      	mov	r2, r0
c0d0242a:	4628      	mov	r0, r5
c0d0242c:	4621      	mov	r1, r4
c0d0242e:	4790      	blx	r2
c0d02430:	4601      	mov	r1, r0
c0d02432:	2002      	movs	r0, #2
c0d02434:	2900      	cmp	r1, #0
c0d02436:	d100      	bne.n	c0d0243a <USBD_SetClassConfig+0x2a>
c0d02438:	4608      	mov	r0, r1
c0d0243a:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d0243c:	2002      	movs	r0, #2
c0d0243e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02440 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02440:	b5b0      	push	{r4, r5, r7, lr}
c0d02442:	af02      	add	r7, sp, #8
c0d02444:	460c      	mov	r4, r1
c0d02446:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02448:	2045      	movs	r0, #69	; 0x45
c0d0244a:	0080      	lsls	r0, r0, #2
c0d0244c:	5828      	ldr	r0, [r5, r0]
c0d0244e:	2800      	cmp	r0, #0
c0d02450:	d006      	beq.n	c0d02460 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02452:	6840      	ldr	r0, [r0, #4]
c0d02454:	f7ff fae0 	bl	c0d01a18 <pic>
c0d02458:	4602      	mov	r2, r0
c0d0245a:	4628      	mov	r0, r5
c0d0245c:	4621      	mov	r1, r4
c0d0245e:	4790      	blx	r2
  }
  return USBD_OK;
c0d02460:	2000      	movs	r0, #0
c0d02462:	bdb0      	pop	{r4, r5, r7, pc}

c0d02464 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02464:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02466:	af03      	add	r7, sp, #12
c0d02468:	b081      	sub	sp, #4
c0d0246a:	4604      	mov	r4, r0
c0d0246c:	2021      	movs	r0, #33	; 0x21
c0d0246e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02470:	19a5      	adds	r5, r4, r6
c0d02472:	4628      	mov	r0, r5
c0d02474:	f000 fb69 	bl	c0d02b4a <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02478:	20f4      	movs	r0, #244	; 0xf4
c0d0247a:	2101      	movs	r1, #1
c0d0247c:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0247e:	2087      	movs	r0, #135	; 0x87
c0d02480:	0040      	lsls	r0, r0, #1
c0d02482:	5a20      	ldrh	r0, [r4, r0]
c0d02484:	21f8      	movs	r1, #248	; 0xf8
c0d02486:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02488:	5da1      	ldrb	r1, [r4, r6]
c0d0248a:	201f      	movs	r0, #31
c0d0248c:	4008      	ands	r0, r1
c0d0248e:	2802      	cmp	r0, #2
c0d02490:	d008      	beq.n	c0d024a4 <USBD_LL_SetupStage+0x40>
c0d02492:	2801      	cmp	r0, #1
c0d02494:	d00b      	beq.n	c0d024ae <USBD_LL_SetupStage+0x4a>
c0d02496:	2800      	cmp	r0, #0
c0d02498:	d10e      	bne.n	c0d024b8 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d0249a:	4620      	mov	r0, r4
c0d0249c:	4629      	mov	r1, r5
c0d0249e:	f000 f8f1 	bl	c0d02684 <USBD_StdDevReq>
c0d024a2:	e00e      	b.n	c0d024c2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d024a4:	4620      	mov	r0, r4
c0d024a6:	4629      	mov	r1, r5
c0d024a8:	f000 fad3 	bl	c0d02a52 <USBD_StdEPReq>
c0d024ac:	e009      	b.n	c0d024c2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d024ae:	4620      	mov	r0, r4
c0d024b0:	4629      	mov	r1, r5
c0d024b2:	f000 faa6 	bl	c0d02a02 <USBD_StdItfReq>
c0d024b6:	e004      	b.n	c0d024c2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d024b8:	2080      	movs	r0, #128	; 0x80
c0d024ba:	4001      	ands	r1, r0
c0d024bc:	4620      	mov	r0, r4
c0d024be:	f7ff fec1 	bl	c0d02244 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d024c2:	2000      	movs	r0, #0
c0d024c4:	b001      	add	sp, #4
c0d024c6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024c8 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d024c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d024ca:	af03      	add	r7, sp, #12
c0d024cc:	b081      	sub	sp, #4
c0d024ce:	4615      	mov	r5, r2
c0d024d0:	460e      	mov	r6, r1
c0d024d2:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d024d4:	2e00      	cmp	r6, #0
c0d024d6:	d011      	beq.n	c0d024fc <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d024d8:	2045      	movs	r0, #69	; 0x45
c0d024da:	0080      	lsls	r0, r0, #2
c0d024dc:	5820      	ldr	r0, [r4, r0]
c0d024de:	6980      	ldr	r0, [r0, #24]
c0d024e0:	2800      	cmp	r0, #0
c0d024e2:	d034      	beq.n	c0d0254e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d024e4:	21fc      	movs	r1, #252	; 0xfc
c0d024e6:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d024e8:	2903      	cmp	r1, #3
c0d024ea:	d130      	bne.n	c0d0254e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d024ec:	f7ff fa94 	bl	c0d01a18 <pic>
c0d024f0:	4603      	mov	r3, r0
c0d024f2:	4620      	mov	r0, r4
c0d024f4:	4631      	mov	r1, r6
c0d024f6:	462a      	mov	r2, r5
c0d024f8:	4798      	blx	r3
c0d024fa:	e028      	b.n	c0d0254e <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d024fc:	20f4      	movs	r0, #244	; 0xf4
c0d024fe:	5820      	ldr	r0, [r4, r0]
c0d02500:	2803      	cmp	r0, #3
c0d02502:	d124      	bne.n	c0d0254e <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02504:	2090      	movs	r0, #144	; 0x90
c0d02506:	5820      	ldr	r0, [r4, r0]
c0d02508:	218c      	movs	r1, #140	; 0x8c
c0d0250a:	5861      	ldr	r1, [r4, r1]
c0d0250c:	4622      	mov	r2, r4
c0d0250e:	328c      	adds	r2, #140	; 0x8c
c0d02510:	4281      	cmp	r1, r0
c0d02512:	d90a      	bls.n	c0d0252a <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02514:	1a09      	subs	r1, r1, r0
c0d02516:	6011      	str	r1, [r2, #0]
c0d02518:	4281      	cmp	r1, r0
c0d0251a:	d300      	bcc.n	c0d0251e <USBD_LL_DataOutStage+0x56>
c0d0251c:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d0251e:	b28a      	uxth	r2, r1
c0d02520:	4620      	mov	r0, r4
c0d02522:	4629      	mov	r1, r5
c0d02524:	f000 fc70 	bl	c0d02e08 <USBD_CtlContinueRx>
c0d02528:	e011      	b.n	c0d0254e <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0252a:	2045      	movs	r0, #69	; 0x45
c0d0252c:	0080      	lsls	r0, r0, #2
c0d0252e:	5820      	ldr	r0, [r4, r0]
c0d02530:	6900      	ldr	r0, [r0, #16]
c0d02532:	2800      	cmp	r0, #0
c0d02534:	d008      	beq.n	c0d02548 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02536:	21fc      	movs	r1, #252	; 0xfc
c0d02538:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d0253a:	2903      	cmp	r1, #3
c0d0253c:	d104      	bne.n	c0d02548 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d0253e:	f7ff fa6b 	bl	c0d01a18 <pic>
c0d02542:	4601      	mov	r1, r0
c0d02544:	4620      	mov	r0, r4
c0d02546:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02548:	4620      	mov	r0, r4
c0d0254a:	f000 fc65 	bl	c0d02e18 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0254e:	2000      	movs	r0, #0
c0d02550:	b001      	add	sp, #4
c0d02552:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02554 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02554:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02556:	af03      	add	r7, sp, #12
c0d02558:	b081      	sub	sp, #4
c0d0255a:	460d      	mov	r5, r1
c0d0255c:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0255e:	2d00      	cmp	r5, #0
c0d02560:	d012      	beq.n	c0d02588 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02562:	2045      	movs	r0, #69	; 0x45
c0d02564:	0080      	lsls	r0, r0, #2
c0d02566:	5820      	ldr	r0, [r4, r0]
c0d02568:	2800      	cmp	r0, #0
c0d0256a:	d054      	beq.n	c0d02616 <USBD_LL_DataInStage+0xc2>
c0d0256c:	6940      	ldr	r0, [r0, #20]
c0d0256e:	2800      	cmp	r0, #0
c0d02570:	d051      	beq.n	c0d02616 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02572:	21fc      	movs	r1, #252	; 0xfc
c0d02574:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02576:	2903      	cmp	r1, #3
c0d02578:	d14d      	bne.n	c0d02616 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d0257a:	f7ff fa4d 	bl	c0d01a18 <pic>
c0d0257e:	4602      	mov	r2, r0
c0d02580:	4620      	mov	r0, r4
c0d02582:	4629      	mov	r1, r5
c0d02584:	4790      	blx	r2
c0d02586:	e046      	b.n	c0d02616 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02588:	20f4      	movs	r0, #244	; 0xf4
c0d0258a:	5820      	ldr	r0, [r4, r0]
c0d0258c:	2802      	cmp	r0, #2
c0d0258e:	d13a      	bne.n	c0d02606 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02590:	69e0      	ldr	r0, [r4, #28]
c0d02592:	6a25      	ldr	r5, [r4, #32]
c0d02594:	42a8      	cmp	r0, r5
c0d02596:	d90b      	bls.n	c0d025b0 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02598:	1b40      	subs	r0, r0, r5
c0d0259a:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d0259c:	2109      	movs	r1, #9
c0d0259e:	014a      	lsls	r2, r1, #5
c0d025a0:	58a1      	ldr	r1, [r4, r2]
c0d025a2:	1949      	adds	r1, r1, r5
c0d025a4:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d025a6:	b282      	uxth	r2, r0
c0d025a8:	4620      	mov	r0, r4
c0d025aa:	f000 fc1e 	bl	c0d02dea <USBD_CtlContinueSendData>
c0d025ae:	e02a      	b.n	c0d02606 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d025b0:	69a6      	ldr	r6, [r4, #24]
c0d025b2:	4630      	mov	r0, r6
c0d025b4:	4629      	mov	r1, r5
c0d025b6:	f000 fccf 	bl	c0d02f58 <__aeabi_uidivmod>
c0d025ba:	42ae      	cmp	r6, r5
c0d025bc:	d30f      	bcc.n	c0d025de <USBD_LL_DataInStage+0x8a>
c0d025be:	2900      	cmp	r1, #0
c0d025c0:	d10d      	bne.n	c0d025de <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d025c2:	20f8      	movs	r0, #248	; 0xf8
c0d025c4:	5820      	ldr	r0, [r4, r0]
c0d025c6:	4625      	mov	r5, r4
c0d025c8:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d025ca:	4286      	cmp	r6, r0
c0d025cc:	d207      	bcs.n	c0d025de <USBD_LL_DataInStage+0x8a>
c0d025ce:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d025d0:	4620      	mov	r0, r4
c0d025d2:	4631      	mov	r1, r6
c0d025d4:	4632      	mov	r2, r6
c0d025d6:	f000 fc08 	bl	c0d02dea <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d025da:	602e      	str	r6, [r5, #0]
c0d025dc:	e013      	b.n	c0d02606 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d025de:	2045      	movs	r0, #69	; 0x45
c0d025e0:	0080      	lsls	r0, r0, #2
c0d025e2:	5820      	ldr	r0, [r4, r0]
c0d025e4:	2800      	cmp	r0, #0
c0d025e6:	d00b      	beq.n	c0d02600 <USBD_LL_DataInStage+0xac>
c0d025e8:	68c0      	ldr	r0, [r0, #12]
c0d025ea:	2800      	cmp	r0, #0
c0d025ec:	d008      	beq.n	c0d02600 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d025ee:	21fc      	movs	r1, #252	; 0xfc
c0d025f0:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d025f2:	2903      	cmp	r1, #3
c0d025f4:	d104      	bne.n	c0d02600 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d025f6:	f7ff fa0f 	bl	c0d01a18 <pic>
c0d025fa:	4601      	mov	r1, r0
c0d025fc:	4620      	mov	r0, r4
c0d025fe:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02600:	4620      	mov	r0, r4
c0d02602:	f000 fc16 	bl	c0d02e32 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02606:	2001      	movs	r0, #1
c0d02608:	0201      	lsls	r1, r0, #8
c0d0260a:	1860      	adds	r0, r4, r1
c0d0260c:	5c61      	ldrb	r1, [r4, r1]
c0d0260e:	2901      	cmp	r1, #1
c0d02610:	d101      	bne.n	c0d02616 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02612:	2100      	movs	r1, #0
c0d02614:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02616:	2000      	movs	r0, #0
c0d02618:	b001      	add	sp, #4
c0d0261a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0261c <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d0261c:	b5d0      	push	{r4, r6, r7, lr}
c0d0261e:	af02      	add	r7, sp, #8
c0d02620:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02622:	2090      	movs	r0, #144	; 0x90
c0d02624:	2140      	movs	r1, #64	; 0x40
c0d02626:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02628:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d0262a:	20fc      	movs	r0, #252	; 0xfc
c0d0262c:	2101      	movs	r1, #1
c0d0262e:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02630:	2045      	movs	r0, #69	; 0x45
c0d02632:	0080      	lsls	r0, r0, #2
c0d02634:	5820      	ldr	r0, [r4, r0]
c0d02636:	2800      	cmp	r0, #0
c0d02638:	d006      	beq.n	c0d02648 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d0263a:	6840      	ldr	r0, [r0, #4]
c0d0263c:	f7ff f9ec 	bl	c0d01a18 <pic>
c0d02640:	4602      	mov	r2, r0
c0d02642:	7921      	ldrb	r1, [r4, #4]
c0d02644:	4620      	mov	r0, r4
c0d02646:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02648:	2000      	movs	r0, #0
c0d0264a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0264c <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d0264c:	7401      	strb	r1, [r0, #16]
c0d0264e:	2000      	movs	r0, #0
  return USBD_OK;
c0d02650:	4770      	bx	lr

c0d02652 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02652:	2000      	movs	r0, #0
c0d02654:	4770      	bx	lr

c0d02656 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02656:	2000      	movs	r0, #0
c0d02658:	4770      	bx	lr

c0d0265a <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d0265a:	b5d0      	push	{r4, r6, r7, lr}
c0d0265c:	af02      	add	r7, sp, #8
c0d0265e:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02660:	20fc      	movs	r0, #252	; 0xfc
c0d02662:	5c20      	ldrb	r0, [r4, r0]
c0d02664:	2803      	cmp	r0, #3
c0d02666:	d10a      	bne.n	c0d0267e <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02668:	2045      	movs	r0, #69	; 0x45
c0d0266a:	0080      	lsls	r0, r0, #2
c0d0266c:	5820      	ldr	r0, [r4, r0]
c0d0266e:	69c0      	ldr	r0, [r0, #28]
c0d02670:	2800      	cmp	r0, #0
c0d02672:	d004      	beq.n	c0d0267e <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02674:	f7ff f9d0 	bl	c0d01a18 <pic>
c0d02678:	4601      	mov	r1, r0
c0d0267a:	4620      	mov	r0, r4
c0d0267c:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d0267e:	2000      	movs	r0, #0
c0d02680:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02684 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02684:	b5d0      	push	{r4, r6, r7, lr}
c0d02686:	af02      	add	r7, sp, #8
c0d02688:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d0268a:	7848      	ldrb	r0, [r1, #1]
c0d0268c:	2809      	cmp	r0, #9
c0d0268e:	d810      	bhi.n	c0d026b2 <USBD_StdDevReq+0x2e>
c0d02690:	4478      	add	r0, pc
c0d02692:	7900      	ldrb	r0, [r0, #4]
c0d02694:	0040      	lsls	r0, r0, #1
c0d02696:	4487      	add	pc, r0
c0d02698:	150c0804 	.word	0x150c0804
c0d0269c:	0c25190c 	.word	0x0c25190c
c0d026a0:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d026a2:	4620      	mov	r0, r4
c0d026a4:	f000 f938 	bl	c0d02918 <USBD_GetStatus>
c0d026a8:	e01f      	b.n	c0d026ea <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d026aa:	4620      	mov	r0, r4
c0d026ac:	f000 f976 	bl	c0d0299c <USBD_ClrFeature>
c0d026b0:	e01b      	b.n	c0d026ea <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d026b2:	2180      	movs	r1, #128	; 0x80
c0d026b4:	4620      	mov	r0, r4
c0d026b6:	f7ff fdc5 	bl	c0d02244 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d026ba:	2100      	movs	r1, #0
c0d026bc:	4620      	mov	r0, r4
c0d026be:	f7ff fdc1 	bl	c0d02244 <USBD_LL_StallEP>
c0d026c2:	e012      	b.n	c0d026ea <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d026c4:	4620      	mov	r0, r4
c0d026c6:	f000 f950 	bl	c0d0296a <USBD_SetFeature>
c0d026ca:	e00e      	b.n	c0d026ea <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d026cc:	4620      	mov	r0, r4
c0d026ce:	f000 f897 	bl	c0d02800 <USBD_SetAddress>
c0d026d2:	e00a      	b.n	c0d026ea <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d026d4:	4620      	mov	r0, r4
c0d026d6:	f000 f8ff 	bl	c0d028d8 <USBD_GetConfig>
c0d026da:	e006      	b.n	c0d026ea <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d026dc:	4620      	mov	r0, r4
c0d026de:	f000 f8bd 	bl	c0d0285c <USBD_SetConfig>
c0d026e2:	e002      	b.n	c0d026ea <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d026e4:	4620      	mov	r0, r4
c0d026e6:	f000 f803 	bl	c0d026f0 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d026ea:	2000      	movs	r0, #0
c0d026ec:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d026f0 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d026f0:	b5b0      	push	{r4, r5, r7, lr}
c0d026f2:	af02      	add	r7, sp, #8
c0d026f4:	b082      	sub	sp, #8
c0d026f6:	460d      	mov	r5, r1
c0d026f8:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d026fa:	8868      	ldrh	r0, [r5, #2]
c0d026fc:	0a01      	lsrs	r1, r0, #8
c0d026fe:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02700:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02702:	2a0e      	cmp	r2, #14
c0d02704:	d83e      	bhi.n	c0d02784 <USBD_GetDescriptor+0x94>
c0d02706:	46c0      	nop			; (mov r8, r8)
c0d02708:	447a      	add	r2, pc
c0d0270a:	7912      	ldrb	r2, [r2, #4]
c0d0270c:	0052      	lsls	r2, r2, #1
c0d0270e:	4497      	add	pc, r2
c0d02710:	390c2607 	.word	0x390c2607
c0d02714:	39362e39 	.word	0x39362e39
c0d02718:	39393939 	.word	0x39393939
c0d0271c:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02720:	2011      	movs	r0, #17
c0d02722:	0100      	lsls	r0, r0, #4
c0d02724:	5820      	ldr	r0, [r4, r0]
c0d02726:	6800      	ldr	r0, [r0, #0]
c0d02728:	e012      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d0272a:	b2c0      	uxtb	r0, r0
c0d0272c:	2805      	cmp	r0, #5
c0d0272e:	d829      	bhi.n	c0d02784 <USBD_GetDescriptor+0x94>
c0d02730:	4478      	add	r0, pc
c0d02732:	7900      	ldrb	r0, [r0, #4]
c0d02734:	0040      	lsls	r0, r0, #1
c0d02736:	4487      	add	pc, r0
c0d02738:	544f4a02 	.word	0x544f4a02
c0d0273c:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0273e:	2011      	movs	r0, #17
c0d02740:	0100      	lsls	r0, r0, #4
c0d02742:	5820      	ldr	r0, [r4, r0]
c0d02744:	6840      	ldr	r0, [r0, #4]
c0d02746:	e003      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02748:	2011      	movs	r0, #17
c0d0274a:	0100      	lsls	r0, r0, #4
c0d0274c:	5820      	ldr	r0, [r4, r0]
c0d0274e:	69c0      	ldr	r0, [r0, #28]
c0d02750:	f7ff f962 	bl	c0d01a18 <pic>
c0d02754:	4602      	mov	r2, r0
c0d02756:	7c20      	ldrb	r0, [r4, #16]
c0d02758:	a901      	add	r1, sp, #4
c0d0275a:	4790      	blx	r2
c0d0275c:	e025      	b.n	c0d027aa <USBD_GetDescriptor+0xba>
c0d0275e:	2045      	movs	r0, #69	; 0x45
c0d02760:	0080      	lsls	r0, r0, #2
c0d02762:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02764:	7c21      	ldrb	r1, [r4, #16]
c0d02766:	2900      	cmp	r1, #0
c0d02768:	d014      	beq.n	c0d02794 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d0276a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d0276c:	e018      	b.n	c0d027a0 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0276e:	7c20      	ldrb	r0, [r4, #16]
c0d02770:	2800      	cmp	r0, #0
c0d02772:	d107      	bne.n	c0d02784 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02774:	2045      	movs	r0, #69	; 0x45
c0d02776:	0080      	lsls	r0, r0, #2
c0d02778:	5820      	ldr	r0, [r4, r0]
c0d0277a:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d0277c:	e010      	b.n	c0d027a0 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0277e:	7c20      	ldrb	r0, [r4, #16]
c0d02780:	2800      	cmp	r0, #0
c0d02782:	d009      	beq.n	c0d02798 <USBD_GetDescriptor+0xa8>
c0d02784:	4620      	mov	r0, r4
c0d02786:	f7ff fd5d 	bl	c0d02244 <USBD_LL_StallEP>
c0d0278a:	2100      	movs	r1, #0
c0d0278c:	4620      	mov	r0, r4
c0d0278e:	f7ff fd59 	bl	c0d02244 <USBD_LL_StallEP>
c0d02792:	e01a      	b.n	c0d027ca <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02794:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02796:	e003      	b.n	c0d027a0 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02798:	2045      	movs	r0, #69	; 0x45
c0d0279a:	0080      	lsls	r0, r0, #2
c0d0279c:	5820      	ldr	r0, [r4, r0]
c0d0279e:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d027a0:	f7ff f93a 	bl	c0d01a18 <pic>
c0d027a4:	4601      	mov	r1, r0
c0d027a6:	a801      	add	r0, sp, #4
c0d027a8:	4788      	blx	r1
c0d027aa:	4601      	mov	r1, r0
c0d027ac:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d027ae:	8802      	ldrh	r2, [r0, #0]
c0d027b0:	2a00      	cmp	r2, #0
c0d027b2:	d00a      	beq.n	c0d027ca <USBD_GetDescriptor+0xda>
c0d027b4:	88e8      	ldrh	r0, [r5, #6]
c0d027b6:	2800      	cmp	r0, #0
c0d027b8:	d007      	beq.n	c0d027ca <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d027ba:	4282      	cmp	r2, r0
c0d027bc:	d300      	bcc.n	c0d027c0 <USBD_GetDescriptor+0xd0>
c0d027be:	4602      	mov	r2, r0
c0d027c0:	a801      	add	r0, sp, #4
c0d027c2:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d027c4:	4620      	mov	r0, r4
c0d027c6:	f000 faf9 	bl	c0d02dbc <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d027ca:	b002      	add	sp, #8
c0d027cc:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d027ce:	2011      	movs	r0, #17
c0d027d0:	0100      	lsls	r0, r0, #4
c0d027d2:	5820      	ldr	r0, [r4, r0]
c0d027d4:	6880      	ldr	r0, [r0, #8]
c0d027d6:	e7bb      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d027d8:	2011      	movs	r0, #17
c0d027da:	0100      	lsls	r0, r0, #4
c0d027dc:	5820      	ldr	r0, [r4, r0]
c0d027de:	68c0      	ldr	r0, [r0, #12]
c0d027e0:	e7b6      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d027e2:	2011      	movs	r0, #17
c0d027e4:	0100      	lsls	r0, r0, #4
c0d027e6:	5820      	ldr	r0, [r4, r0]
c0d027e8:	6900      	ldr	r0, [r0, #16]
c0d027ea:	e7b1      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d027ec:	2011      	movs	r0, #17
c0d027ee:	0100      	lsls	r0, r0, #4
c0d027f0:	5820      	ldr	r0, [r4, r0]
c0d027f2:	6940      	ldr	r0, [r0, #20]
c0d027f4:	e7ac      	b.n	c0d02750 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d027f6:	2011      	movs	r0, #17
c0d027f8:	0100      	lsls	r0, r0, #4
c0d027fa:	5820      	ldr	r0, [r4, r0]
c0d027fc:	6980      	ldr	r0, [r0, #24]
c0d027fe:	e7a7      	b.n	c0d02750 <USBD_GetDescriptor+0x60>

c0d02800 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02800:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02802:	af03      	add	r7, sp, #12
c0d02804:	b081      	sub	sp, #4
c0d02806:	460a      	mov	r2, r1
c0d02808:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0280a:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0280c:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0280e:	2800      	cmp	r0, #0
c0d02810:	d10b      	bne.n	c0d0282a <USBD_SetAddress+0x2a>
c0d02812:	88d0      	ldrh	r0, [r2, #6]
c0d02814:	2800      	cmp	r0, #0
c0d02816:	d108      	bne.n	c0d0282a <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02818:	8850      	ldrh	r0, [r2, #2]
c0d0281a:	267f      	movs	r6, #127	; 0x7f
c0d0281c:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d0281e:	20fc      	movs	r0, #252	; 0xfc
c0d02820:	5c20      	ldrb	r0, [r4, r0]
c0d02822:	4625      	mov	r5, r4
c0d02824:	35fc      	adds	r5, #252	; 0xfc
c0d02826:	2803      	cmp	r0, #3
c0d02828:	d108      	bne.n	c0d0283c <USBD_SetAddress+0x3c>
c0d0282a:	4620      	mov	r0, r4
c0d0282c:	f7ff fd0a 	bl	c0d02244 <USBD_LL_StallEP>
c0d02830:	2100      	movs	r1, #0
c0d02832:	4620      	mov	r0, r4
c0d02834:	f7ff fd06 	bl	c0d02244 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02838:	b001      	add	sp, #4
c0d0283a:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d0283c:	20fe      	movs	r0, #254	; 0xfe
c0d0283e:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02840:	b2f1      	uxtb	r1, r6
c0d02842:	4620      	mov	r0, r4
c0d02844:	f7ff fd5c 	bl	c0d02300 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02848:	4620      	mov	r0, r4
c0d0284a:	f000 fae5 	bl	c0d02e18 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d0284e:	2002      	movs	r0, #2
c0d02850:	2101      	movs	r1, #1
c0d02852:	2e00      	cmp	r6, #0
c0d02854:	d100      	bne.n	c0d02858 <USBD_SetAddress+0x58>
c0d02856:	4608      	mov	r0, r1
c0d02858:	7028      	strb	r0, [r5, #0]
c0d0285a:	e7ed      	b.n	c0d02838 <USBD_SetAddress+0x38>

c0d0285c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0285c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0285e:	af03      	add	r7, sp, #12
c0d02860:	b081      	sub	sp, #4
c0d02862:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02864:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02866:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02868:	2e02      	cmp	r6, #2
c0d0286a:	d21d      	bcs.n	c0d028a8 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d0286c:	20fc      	movs	r0, #252	; 0xfc
c0d0286e:	5c21      	ldrb	r1, [r4, r0]
c0d02870:	4620      	mov	r0, r4
c0d02872:	30fc      	adds	r0, #252	; 0xfc
c0d02874:	2903      	cmp	r1, #3
c0d02876:	d007      	beq.n	c0d02888 <USBD_SetConfig+0x2c>
c0d02878:	2902      	cmp	r1, #2
c0d0287a:	d115      	bne.n	c0d028a8 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d0287c:	2e00      	cmp	r6, #0
c0d0287e:	d026      	beq.n	c0d028ce <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02880:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02882:	2103      	movs	r1, #3
c0d02884:	7001      	strb	r1, [r0, #0]
c0d02886:	e009      	b.n	c0d0289c <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02888:	2e00      	cmp	r6, #0
c0d0288a:	d016      	beq.n	c0d028ba <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d0288c:	6860      	ldr	r0, [r4, #4]
c0d0288e:	4286      	cmp	r6, r0
c0d02890:	d01d      	beq.n	c0d028ce <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02892:	b2c1      	uxtb	r1, r0
c0d02894:	4620      	mov	r0, r4
c0d02896:	f7ff fdd3 	bl	c0d02440 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d0289a:	6066      	str	r6, [r4, #4]
c0d0289c:	4620      	mov	r0, r4
c0d0289e:	4631      	mov	r1, r6
c0d028a0:	f7ff fdb6 	bl	c0d02410 <USBD_SetClassConfig>
c0d028a4:	2802      	cmp	r0, #2
c0d028a6:	d112      	bne.n	c0d028ce <USBD_SetConfig+0x72>
c0d028a8:	4620      	mov	r0, r4
c0d028aa:	4629      	mov	r1, r5
c0d028ac:	f7ff fcca 	bl	c0d02244 <USBD_LL_StallEP>
c0d028b0:	2100      	movs	r1, #0
c0d028b2:	4620      	mov	r0, r4
c0d028b4:	f7ff fcc6 	bl	c0d02244 <USBD_LL_StallEP>
c0d028b8:	e00c      	b.n	c0d028d4 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d028ba:	2102      	movs	r1, #2
c0d028bc:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d028be:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d028c0:	4620      	mov	r0, r4
c0d028c2:	4631      	mov	r1, r6
c0d028c4:	f7ff fdbc 	bl	c0d02440 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d028c8:	4620      	mov	r0, r4
c0d028ca:	f000 faa5 	bl	c0d02e18 <USBD_CtlSendStatus>
c0d028ce:	4620      	mov	r0, r4
c0d028d0:	f000 faa2 	bl	c0d02e18 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d028d4:	b001      	add	sp, #4
c0d028d6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d028d8 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d028d8:	b5d0      	push	{r4, r6, r7, lr}
c0d028da:	af02      	add	r7, sp, #8
c0d028dc:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d028de:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028e0:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d028e2:	2801      	cmp	r0, #1
c0d028e4:	d10a      	bne.n	c0d028fc <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d028e6:	20fc      	movs	r0, #252	; 0xfc
c0d028e8:	5c20      	ldrb	r0, [r4, r0]
c0d028ea:	2803      	cmp	r0, #3
c0d028ec:	d00e      	beq.n	c0d0290c <USBD_GetConfig+0x34>
c0d028ee:	2802      	cmp	r0, #2
c0d028f0:	d104      	bne.n	c0d028fc <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d028f2:	2000      	movs	r0, #0
c0d028f4:	60a0      	str	r0, [r4, #8]
c0d028f6:	4621      	mov	r1, r4
c0d028f8:	3108      	adds	r1, #8
c0d028fa:	e008      	b.n	c0d0290e <USBD_GetConfig+0x36>
c0d028fc:	4620      	mov	r0, r4
c0d028fe:	f7ff fca1 	bl	c0d02244 <USBD_LL_StallEP>
c0d02902:	2100      	movs	r1, #0
c0d02904:	4620      	mov	r0, r4
c0d02906:	f7ff fc9d 	bl	c0d02244 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0290a:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d0290c:	1d21      	adds	r1, r4, #4
c0d0290e:	2201      	movs	r2, #1
c0d02910:	4620      	mov	r0, r4
c0d02912:	f000 fa53 	bl	c0d02dbc <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02916:	bdd0      	pop	{r4, r6, r7, pc}

c0d02918 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02918:	b5b0      	push	{r4, r5, r7, lr}
c0d0291a:	af02      	add	r7, sp, #8
c0d0291c:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d0291e:	20fc      	movs	r0, #252	; 0xfc
c0d02920:	5c20      	ldrb	r0, [r4, r0]
c0d02922:	21fe      	movs	r1, #254	; 0xfe
c0d02924:	4001      	ands	r1, r0
c0d02926:	2902      	cmp	r1, #2
c0d02928:	d116      	bne.n	c0d02958 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0292a:	2001      	movs	r0, #1
c0d0292c:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0292e:	2041      	movs	r0, #65	; 0x41
c0d02930:	0080      	lsls	r0, r0, #2
c0d02932:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02934:	4625      	mov	r5, r4
c0d02936:	350c      	adds	r5, #12
c0d02938:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0293a:	2900      	cmp	r1, #0
c0d0293c:	d005      	beq.n	c0d0294a <USBD_GetStatus+0x32>
c0d0293e:	4620      	mov	r0, r4
c0d02940:	f000 fa77 	bl	c0d02e32 <USBD_CtlReceiveStatus>
c0d02944:	68e1      	ldr	r1, [r4, #12]
c0d02946:	2002      	movs	r0, #2
c0d02948:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0294a:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d0294c:	2202      	movs	r2, #2
c0d0294e:	4620      	mov	r0, r4
c0d02950:	4629      	mov	r1, r5
c0d02952:	f000 fa33 	bl	c0d02dbc <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02956:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02958:	2180      	movs	r1, #128	; 0x80
c0d0295a:	4620      	mov	r0, r4
c0d0295c:	f7ff fc72 	bl	c0d02244 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02960:	2100      	movs	r1, #0
c0d02962:	4620      	mov	r0, r4
c0d02964:	f7ff fc6e 	bl	c0d02244 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02968:	bdb0      	pop	{r4, r5, r7, pc}

c0d0296a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0296a:	b5b0      	push	{r4, r5, r7, lr}
c0d0296c:	af02      	add	r7, sp, #8
c0d0296e:	460d      	mov	r5, r1
c0d02970:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02972:	8868      	ldrh	r0, [r5, #2]
c0d02974:	2801      	cmp	r0, #1
c0d02976:	d110      	bne.n	c0d0299a <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02978:	2041      	movs	r0, #65	; 0x41
c0d0297a:	0080      	lsls	r0, r0, #2
c0d0297c:	2101      	movs	r1, #1
c0d0297e:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02980:	2045      	movs	r0, #69	; 0x45
c0d02982:	0080      	lsls	r0, r0, #2
c0d02984:	5820      	ldr	r0, [r4, r0]
c0d02986:	6880      	ldr	r0, [r0, #8]
c0d02988:	f7ff f846 	bl	c0d01a18 <pic>
c0d0298c:	4602      	mov	r2, r0
c0d0298e:	4620      	mov	r0, r4
c0d02990:	4629      	mov	r1, r5
c0d02992:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02994:	4620      	mov	r0, r4
c0d02996:	f000 fa3f 	bl	c0d02e18 <USBD_CtlSendStatus>
  }

}
c0d0299a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0299c <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0299c:	b5b0      	push	{r4, r5, r7, lr}
c0d0299e:	af02      	add	r7, sp, #8
c0d029a0:	460d      	mov	r5, r1
c0d029a2:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d029a4:	20fc      	movs	r0, #252	; 0xfc
c0d029a6:	5c20      	ldrb	r0, [r4, r0]
c0d029a8:	21fe      	movs	r1, #254	; 0xfe
c0d029aa:	4001      	ands	r1, r0
c0d029ac:	2902      	cmp	r1, #2
c0d029ae:	d114      	bne.n	c0d029da <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d029b0:	8868      	ldrh	r0, [r5, #2]
c0d029b2:	2801      	cmp	r0, #1
c0d029b4:	d119      	bne.n	c0d029ea <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d029b6:	2041      	movs	r0, #65	; 0x41
c0d029b8:	0080      	lsls	r0, r0, #2
c0d029ba:	2100      	movs	r1, #0
c0d029bc:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d029be:	2045      	movs	r0, #69	; 0x45
c0d029c0:	0080      	lsls	r0, r0, #2
c0d029c2:	5820      	ldr	r0, [r4, r0]
c0d029c4:	6880      	ldr	r0, [r0, #8]
c0d029c6:	f7ff f827 	bl	c0d01a18 <pic>
c0d029ca:	4602      	mov	r2, r0
c0d029cc:	4620      	mov	r0, r4
c0d029ce:	4629      	mov	r1, r5
c0d029d0:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d029d2:	4620      	mov	r0, r4
c0d029d4:	f000 fa20 	bl	c0d02e18 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d029d8:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029da:	2180      	movs	r1, #128	; 0x80
c0d029dc:	4620      	mov	r0, r4
c0d029de:	f7ff fc31 	bl	c0d02244 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d029e2:	2100      	movs	r1, #0
c0d029e4:	4620      	mov	r0, r4
c0d029e6:	f7ff fc2d 	bl	c0d02244 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d029ea:	bdb0      	pop	{r4, r5, r7, pc}

c0d029ec <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d029ec:	b5d0      	push	{r4, r6, r7, lr}
c0d029ee:	af02      	add	r7, sp, #8
c0d029f0:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d029f2:	2180      	movs	r1, #128	; 0x80
c0d029f4:	f7ff fc26 	bl	c0d02244 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d029f8:	2100      	movs	r1, #0
c0d029fa:	4620      	mov	r0, r4
c0d029fc:	f7ff fc22 	bl	c0d02244 <USBD_LL_StallEP>
}
c0d02a00:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a02 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02a02:	b5b0      	push	{r4, r5, r7, lr}
c0d02a04:	af02      	add	r7, sp, #8
c0d02a06:	460d      	mov	r5, r1
c0d02a08:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02a0a:	20fc      	movs	r0, #252	; 0xfc
c0d02a0c:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a0e:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02a10:	2803      	cmp	r0, #3
c0d02a12:	d115      	bne.n	c0d02a40 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02a14:	88a8      	ldrh	r0, [r5, #4]
c0d02a16:	22fe      	movs	r2, #254	; 0xfe
c0d02a18:	4002      	ands	r2, r0
c0d02a1a:	2a01      	cmp	r2, #1
c0d02a1c:	d810      	bhi.n	c0d02a40 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02a1e:	2045      	movs	r0, #69	; 0x45
c0d02a20:	0080      	lsls	r0, r0, #2
c0d02a22:	5820      	ldr	r0, [r4, r0]
c0d02a24:	6880      	ldr	r0, [r0, #8]
c0d02a26:	f7fe fff7 	bl	c0d01a18 <pic>
c0d02a2a:	4602      	mov	r2, r0
c0d02a2c:	4620      	mov	r0, r4
c0d02a2e:	4629      	mov	r1, r5
c0d02a30:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02a32:	88e8      	ldrh	r0, [r5, #6]
c0d02a34:	2800      	cmp	r0, #0
c0d02a36:	d10a      	bne.n	c0d02a4e <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02a38:	4620      	mov	r0, r4
c0d02a3a:	f000 f9ed 	bl	c0d02e18 <USBD_CtlSendStatus>
c0d02a3e:	e006      	b.n	c0d02a4e <USBD_StdItfReq+0x4c>
c0d02a40:	4620      	mov	r0, r4
c0d02a42:	f7ff fbff 	bl	c0d02244 <USBD_LL_StallEP>
c0d02a46:	2100      	movs	r1, #0
c0d02a48:	4620      	mov	r0, r4
c0d02a4a:	f7ff fbfb 	bl	c0d02244 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02a4e:	2000      	movs	r0, #0
c0d02a50:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a52 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02a52:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a54:	af03      	add	r7, sp, #12
c0d02a56:	b081      	sub	sp, #4
c0d02a58:	460e      	mov	r6, r1
c0d02a5a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02a5c:	7830      	ldrb	r0, [r6, #0]
c0d02a5e:	2160      	movs	r1, #96	; 0x60
c0d02a60:	4001      	ands	r1, r0
c0d02a62:	2920      	cmp	r1, #32
c0d02a64:	d10a      	bne.n	c0d02a7c <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02a66:	2045      	movs	r0, #69	; 0x45
c0d02a68:	0080      	lsls	r0, r0, #2
c0d02a6a:	5820      	ldr	r0, [r4, r0]
c0d02a6c:	6880      	ldr	r0, [r0, #8]
c0d02a6e:	f7fe ffd3 	bl	c0d01a18 <pic>
c0d02a72:	4602      	mov	r2, r0
c0d02a74:	4620      	mov	r0, r4
c0d02a76:	4631      	mov	r1, r6
c0d02a78:	4790      	blx	r2
c0d02a7a:	e063      	b.n	c0d02b44 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02a7c:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02a7e:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02a80:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02a82:	2800      	cmp	r0, #0
c0d02a84:	d012      	beq.n	c0d02aac <USBD_StdEPReq+0x5a>
c0d02a86:	2801      	cmp	r0, #1
c0d02a88:	d019      	beq.n	c0d02abe <USBD_StdEPReq+0x6c>
c0d02a8a:	2803      	cmp	r0, #3
c0d02a8c:	d15a      	bne.n	c0d02b44 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02a8e:	20fc      	movs	r0, #252	; 0xfc
c0d02a90:	5c20      	ldrb	r0, [r4, r0]
c0d02a92:	2803      	cmp	r0, #3
c0d02a94:	d117      	bne.n	c0d02ac6 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02a96:	8870      	ldrh	r0, [r6, #2]
c0d02a98:	2800      	cmp	r0, #0
c0d02a9a:	d12d      	bne.n	c0d02af8 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02a9c:	4329      	orrs	r1, r5
c0d02a9e:	2980      	cmp	r1, #128	; 0x80
c0d02aa0:	d02a      	beq.n	c0d02af8 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02aa2:	4620      	mov	r0, r4
c0d02aa4:	4629      	mov	r1, r5
c0d02aa6:	f7ff fbcd 	bl	c0d02244 <USBD_LL_StallEP>
c0d02aaa:	e025      	b.n	c0d02af8 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02aac:	20fc      	movs	r0, #252	; 0xfc
c0d02aae:	5c20      	ldrb	r0, [r4, r0]
c0d02ab0:	2803      	cmp	r0, #3
c0d02ab2:	d02f      	beq.n	c0d02b14 <USBD_StdEPReq+0xc2>
c0d02ab4:	2802      	cmp	r0, #2
c0d02ab6:	d10e      	bne.n	c0d02ad6 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02ab8:	0668      	lsls	r0, r5, #25
c0d02aba:	d109      	bne.n	c0d02ad0 <USBD_StdEPReq+0x7e>
c0d02abc:	e042      	b.n	c0d02b44 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02abe:	20fc      	movs	r0, #252	; 0xfc
c0d02ac0:	5c20      	ldrb	r0, [r4, r0]
c0d02ac2:	2803      	cmp	r0, #3
c0d02ac4:	d00f      	beq.n	c0d02ae6 <USBD_StdEPReq+0x94>
c0d02ac6:	2802      	cmp	r0, #2
c0d02ac8:	d105      	bne.n	c0d02ad6 <USBD_StdEPReq+0x84>
c0d02aca:	4329      	orrs	r1, r5
c0d02acc:	2980      	cmp	r1, #128	; 0x80
c0d02ace:	d039      	beq.n	c0d02b44 <USBD_StdEPReq+0xf2>
c0d02ad0:	4620      	mov	r0, r4
c0d02ad2:	4629      	mov	r1, r5
c0d02ad4:	e004      	b.n	c0d02ae0 <USBD_StdEPReq+0x8e>
c0d02ad6:	4620      	mov	r0, r4
c0d02ad8:	f7ff fbb4 	bl	c0d02244 <USBD_LL_StallEP>
c0d02adc:	2100      	movs	r1, #0
c0d02ade:	4620      	mov	r0, r4
c0d02ae0:	f7ff fbb0 	bl	c0d02244 <USBD_LL_StallEP>
c0d02ae4:	e02e      	b.n	c0d02b44 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02ae6:	8870      	ldrh	r0, [r6, #2]
c0d02ae8:	2800      	cmp	r0, #0
c0d02aea:	d12b      	bne.n	c0d02b44 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02aec:	0668      	lsls	r0, r5, #25
c0d02aee:	d00d      	beq.n	c0d02b0c <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02af0:	4620      	mov	r0, r4
c0d02af2:	4629      	mov	r1, r5
c0d02af4:	f7ff fbcc 	bl	c0d02290 <USBD_LL_ClearStallEP>
c0d02af8:	2045      	movs	r0, #69	; 0x45
c0d02afa:	0080      	lsls	r0, r0, #2
c0d02afc:	5820      	ldr	r0, [r4, r0]
c0d02afe:	6880      	ldr	r0, [r0, #8]
c0d02b00:	f7fe ff8a 	bl	c0d01a18 <pic>
c0d02b04:	4602      	mov	r2, r0
c0d02b06:	4620      	mov	r0, r4
c0d02b08:	4631      	mov	r1, r6
c0d02b0a:	4790      	blx	r2
c0d02b0c:	4620      	mov	r0, r4
c0d02b0e:	f000 f983 	bl	c0d02e18 <USBD_CtlSendStatus>
c0d02b12:	e017      	b.n	c0d02b44 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02b14:	4626      	mov	r6, r4
c0d02b16:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02b18:	4620      	mov	r0, r4
c0d02b1a:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02b1c:	420d      	tst	r5, r1
c0d02b1e:	d100      	bne.n	c0d02b22 <USBD_StdEPReq+0xd0>
c0d02b20:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02b22:	4620      	mov	r0, r4
c0d02b24:	4629      	mov	r1, r5
c0d02b26:	f7ff fbd9 	bl	c0d022dc <USBD_LL_IsStallEP>
c0d02b2a:	2101      	movs	r1, #1
c0d02b2c:	2800      	cmp	r0, #0
c0d02b2e:	d100      	bne.n	c0d02b32 <USBD_StdEPReq+0xe0>
c0d02b30:	4601      	mov	r1, r0
c0d02b32:	207f      	movs	r0, #127	; 0x7f
c0d02b34:	4005      	ands	r5, r0
c0d02b36:	0128      	lsls	r0, r5, #4
c0d02b38:	5031      	str	r1, [r6, r0]
c0d02b3a:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d02b3c:	2202      	movs	r2, #2
c0d02b3e:	4620      	mov	r0, r4
c0d02b40:	f000 f93c 	bl	c0d02dbc <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02b44:	2000      	movs	r0, #0
c0d02b46:	b001      	add	sp, #4
c0d02b48:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b4a <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02b4a:	780a      	ldrb	r2, [r1, #0]
c0d02b4c:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02b4e:	784a      	ldrb	r2, [r1, #1]
c0d02b50:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02b52:	788a      	ldrb	r2, [r1, #2]
c0d02b54:	78cb      	ldrb	r3, [r1, #3]
c0d02b56:	021b      	lsls	r3, r3, #8
c0d02b58:	4313      	orrs	r3, r2
c0d02b5a:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02b5c:	790a      	ldrb	r2, [r1, #4]
c0d02b5e:	794b      	ldrb	r3, [r1, #5]
c0d02b60:	021b      	lsls	r3, r3, #8
c0d02b62:	4313      	orrs	r3, r2
c0d02b64:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02b66:	798a      	ldrb	r2, [r1, #6]
c0d02b68:	79c9      	ldrb	r1, [r1, #7]
c0d02b6a:	0209      	lsls	r1, r1, #8
c0d02b6c:	4311      	orrs	r1, r2
c0d02b6e:	80c1      	strh	r1, [r0, #6]

}
c0d02b70:	4770      	bx	lr

c0d02b72 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02b72:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b74:	af03      	add	r7, sp, #12
c0d02b76:	b083      	sub	sp, #12
c0d02b78:	460d      	mov	r5, r1
c0d02b7a:	4604      	mov	r4, r0
c0d02b7c:	a802      	add	r0, sp, #8
c0d02b7e:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02b80:	8006      	strh	r6, [r0, #0]
c0d02b82:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02b84:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02b86:	7829      	ldrb	r1, [r5, #0]
c0d02b88:	2060      	movs	r0, #96	; 0x60
c0d02b8a:	4008      	ands	r0, r1
c0d02b8c:	2800      	cmp	r0, #0
c0d02b8e:	d010      	beq.n	c0d02bb2 <USBD_HID_Setup+0x40>
c0d02b90:	2820      	cmp	r0, #32
c0d02b92:	d139      	bne.n	c0d02c08 <USBD_HID_Setup+0x96>
c0d02b94:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02b96:	4601      	mov	r1, r0
c0d02b98:	390a      	subs	r1, #10
c0d02b9a:	2902      	cmp	r1, #2
c0d02b9c:	d334      	bcc.n	c0d02c08 <USBD_HID_Setup+0x96>
c0d02b9e:	2802      	cmp	r0, #2
c0d02ba0:	d01c      	beq.n	c0d02bdc <USBD_HID_Setup+0x6a>
c0d02ba2:	2803      	cmp	r0, #3
c0d02ba4:	d01a      	beq.n	c0d02bdc <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02ba6:	4620      	mov	r0, r4
c0d02ba8:	4629      	mov	r1, r5
c0d02baa:	f7ff ff1f 	bl	c0d029ec <USBD_CtlError>
c0d02bae:	2602      	movs	r6, #2
c0d02bb0:	e02a      	b.n	c0d02c08 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02bb2:	7868      	ldrb	r0, [r5, #1]
c0d02bb4:	280b      	cmp	r0, #11
c0d02bb6:	d014      	beq.n	c0d02be2 <USBD_HID_Setup+0x70>
c0d02bb8:	280a      	cmp	r0, #10
c0d02bba:	d00f      	beq.n	c0d02bdc <USBD_HID_Setup+0x6a>
c0d02bbc:	2806      	cmp	r0, #6
c0d02bbe:	d123      	bne.n	c0d02c08 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02bc0:	8868      	ldrh	r0, [r5, #2]
c0d02bc2:	0a00      	lsrs	r0, r0, #8
c0d02bc4:	2600      	movs	r6, #0
c0d02bc6:	2821      	cmp	r0, #33	; 0x21
c0d02bc8:	d00f      	beq.n	c0d02bea <USBD_HID_Setup+0x78>
c0d02bca:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02bcc:	4632      	mov	r2, r6
c0d02bce:	4631      	mov	r1, r6
c0d02bd0:	d117      	bne.n	c0d02c02 <USBD_HID_Setup+0x90>
c0d02bd2:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02bd4:	9000      	str	r0, [sp, #0]
c0d02bd6:	f000 f847 	bl	c0d02c68 <USBD_HID_GetReportDescriptor_impl>
c0d02bda:	e00a      	b.n	c0d02bf2 <USBD_HID_Setup+0x80>
c0d02bdc:	a901      	add	r1, sp, #4
c0d02bde:	2201      	movs	r2, #1
c0d02be0:	e00f      	b.n	c0d02c02 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02be2:	4620      	mov	r0, r4
c0d02be4:	f000 f918 	bl	c0d02e18 <USBD_CtlSendStatus>
c0d02be8:	e00e      	b.n	c0d02c08 <USBD_HID_Setup+0x96>
c0d02bea:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02bec:	9000      	str	r0, [sp, #0]
c0d02bee:	f000 f833 	bl	c0d02c58 <USBD_HID_GetHidDescriptor_impl>
c0d02bf2:	9b00      	ldr	r3, [sp, #0]
c0d02bf4:	4601      	mov	r1, r0
c0d02bf6:	881a      	ldrh	r2, [r3, #0]
c0d02bf8:	88e8      	ldrh	r0, [r5, #6]
c0d02bfa:	4282      	cmp	r2, r0
c0d02bfc:	d300      	bcc.n	c0d02c00 <USBD_HID_Setup+0x8e>
c0d02bfe:	4602      	mov	r2, r0
c0d02c00:	801a      	strh	r2, [r3, #0]
c0d02c02:	4620      	mov	r0, r4
c0d02c04:	f000 f8da 	bl	c0d02dbc <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02c08:	b2f0      	uxtb	r0, r6
c0d02c0a:	b003      	add	sp, #12
c0d02c0c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c0e <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02c0e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c10:	af03      	add	r7, sp, #12
c0d02c12:	b081      	sub	sp, #4
c0d02c14:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02c16:	2182      	movs	r1, #130	; 0x82
c0d02c18:	2502      	movs	r5, #2
c0d02c1a:	2640      	movs	r6, #64	; 0x40
c0d02c1c:	462a      	mov	r2, r5
c0d02c1e:	4633      	mov	r3, r6
c0d02c20:	f7ff fad0 	bl	c0d021c4 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02c24:	4620      	mov	r0, r4
c0d02c26:	4629      	mov	r1, r5
c0d02c28:	462a      	mov	r2, r5
c0d02c2a:	4633      	mov	r3, r6
c0d02c2c:	f7ff faca 	bl	c0d021c4 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02c30:	4620      	mov	r0, r4
c0d02c32:	4629      	mov	r1, r5
c0d02c34:	4632      	mov	r2, r6
c0d02c36:	f7ff fb90 	bl	c0d0235a <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02c3a:	2000      	movs	r0, #0
c0d02c3c:	b001      	add	sp, #4
c0d02c3e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c40 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02c40:	b5d0      	push	{r4, r6, r7, lr}
c0d02c42:	af02      	add	r7, sp, #8
c0d02c44:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02c46:	2182      	movs	r1, #130	; 0x82
c0d02c48:	f7ff fae4 	bl	c0d02214 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02c4c:	2102      	movs	r1, #2
c0d02c4e:	4620      	mov	r0, r4
c0d02c50:	f7ff fae0 	bl	c0d02214 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02c54:	2000      	movs	r0, #0
c0d02c56:	bdd0      	pop	{r4, r6, r7, pc}

c0d02c58 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02c58:	2109      	movs	r1, #9
c0d02c5a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02c5c:	4801      	ldr	r0, [pc, #4]	; (c0d02c64 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02c5e:	4478      	add	r0, pc
c0d02c60:	4770      	bx	lr
c0d02c62:	46c0      	nop			; (mov r8, r8)
c0d02c64:	00000a5e 	.word	0x00000a5e

c0d02c68 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02c68:	2122      	movs	r1, #34	; 0x22
c0d02c6a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02c6c:	4801      	ldr	r0, [pc, #4]	; (c0d02c74 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02c6e:	4478      	add	r0, pc
c0d02c70:	4770      	bx	lr
c0d02c72:	46c0      	nop			; (mov r8, r8)
c0d02c74:	00000a29 	.word	0x00000a29

c0d02c78 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02c78:	b5b0      	push	{r4, r5, r7, lr}
c0d02c7a:	af02      	add	r7, sp, #8
c0d02c7c:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02c7e:	2102      	movs	r1, #2
c0d02c80:	2240      	movs	r2, #64	; 0x40
c0d02c82:	f7ff fb6a 	bl	c0d0235a <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02c86:	4d0d      	ldr	r5, [pc, #52]	; (c0d02cbc <USBD_HID_DataOut_impl+0x44>)
c0d02c88:	7828      	ldrb	r0, [r5, #0]
c0d02c8a:	2800      	cmp	r0, #0
c0d02c8c:	d113      	bne.n	c0d02cb6 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02c8e:	2002      	movs	r0, #2
c0d02c90:	f7fe f928 	bl	c0d00ee4 <io_seproxyhal_get_ep_rx_size>
c0d02c94:	4602      	mov	r2, r0
c0d02c96:	480d      	ldr	r0, [pc, #52]	; (c0d02ccc <USBD_HID_DataOut_impl+0x54>)
c0d02c98:	4478      	add	r0, pc
c0d02c9a:	4621      	mov	r1, r4
c0d02c9c:	f7fd ff86 	bl	c0d00bac <io_usb_hid_receive>
c0d02ca0:	2802      	cmp	r0, #2
c0d02ca2:	d108      	bne.n	c0d02cb6 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02ca4:	2001      	movs	r0, #1
c0d02ca6:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02ca8:	4805      	ldr	r0, [pc, #20]	; (c0d02cc0 <USBD_HID_DataOut_impl+0x48>)
c0d02caa:	2107      	movs	r1, #7
c0d02cac:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02cae:	4805      	ldr	r0, [pc, #20]	; (c0d02cc4 <USBD_HID_DataOut_impl+0x4c>)
c0d02cb0:	6800      	ldr	r0, [r0, #0]
c0d02cb2:	4905      	ldr	r1, [pc, #20]	; (c0d02cc8 <USBD_HID_DataOut_impl+0x50>)
c0d02cb4:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02cb6:	2000      	movs	r0, #0
c0d02cb8:	bdb0      	pop	{r4, r5, r7, pc}
c0d02cba:	46c0      	nop			; (mov r8, r8)
c0d02cbc:	20001d10 	.word	0x20001d10
c0d02cc0:	20001d18 	.word	0x20001d18
c0d02cc4:	20001c00 	.word	0x20001c00
c0d02cc8:	20001d1c 	.word	0x20001d1c
c0d02ccc:	ffffe3a1 	.word	0xffffe3a1

c0d02cd0 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02cd0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02cd2:	af03      	add	r7, sp, #12
c0d02cd4:	b081      	sub	sp, #4
c0d02cd6:	4604      	mov	r4, r0
c0d02cd8:	2049      	movs	r0, #73	; 0x49
c0d02cda:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02cdc:	4810      	ldr	r0, [pc, #64]	; (c0d02d20 <USB_power+0x50>)
c0d02cde:	2100      	movs	r1, #0
c0d02ce0:	462a      	mov	r2, r5
c0d02ce2:	f7fe f80f 	bl	c0d00d04 <os_memset>

  if (enabled) {
c0d02ce6:	2c00      	cmp	r4, #0
c0d02ce8:	d015      	beq.n	c0d02d16 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02cea:	4c0d      	ldr	r4, [pc, #52]	; (c0d02d20 <USB_power+0x50>)
c0d02cec:	2600      	movs	r6, #0
c0d02cee:	4620      	mov	r0, r4
c0d02cf0:	4631      	mov	r1, r6
c0d02cf2:	462a      	mov	r2, r5
c0d02cf4:	f7fe f806 	bl	c0d00d04 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02cf8:	490a      	ldr	r1, [pc, #40]	; (c0d02d24 <USB_power+0x54>)
c0d02cfa:	4479      	add	r1, pc
c0d02cfc:	4620      	mov	r0, r4
c0d02cfe:	4632      	mov	r2, r6
c0d02d00:	f7ff fb3f 	bl	c0d02382 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02d04:	4908      	ldr	r1, [pc, #32]	; (c0d02d28 <USB_power+0x58>)
c0d02d06:	4479      	add	r1, pc
c0d02d08:	4620      	mov	r0, r4
c0d02d0a:	f7ff fb72 	bl	c0d023f2 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02d0e:	4620      	mov	r0, r4
c0d02d10:	f7ff fb78 	bl	c0d02404 <USBD_Start>
c0d02d14:	e002      	b.n	c0d02d1c <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02d16:	4802      	ldr	r0, [pc, #8]	; (c0d02d20 <USB_power+0x50>)
c0d02d18:	f7ff fb51 	bl	c0d023be <USBD_DeInit>
  }
}
c0d02d1c:	b001      	add	sp, #4
c0d02d1e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02d20:	20001d34 	.word	0x20001d34
c0d02d24:	000009de 	.word	0x000009de
c0d02d28:	00000a0e 	.word	0x00000a0e

c0d02d2c <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02d2c:	2012      	movs	r0, #18
c0d02d2e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02d30:	4801      	ldr	r0, [pc, #4]	; (c0d02d38 <USBD_DeviceDescriptor+0xc>)
c0d02d32:	4478      	add	r0, pc
c0d02d34:	4770      	bx	lr
c0d02d36:	46c0      	nop			; (mov r8, r8)
c0d02d38:	00000993 	.word	0x00000993

c0d02d3c <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02d3c:	2004      	movs	r0, #4
c0d02d3e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02d40:	4801      	ldr	r0, [pc, #4]	; (c0d02d48 <USBD_LangIDStrDescriptor+0xc>)
c0d02d42:	4478      	add	r0, pc
c0d02d44:	4770      	bx	lr
c0d02d46:	46c0      	nop			; (mov r8, r8)
c0d02d48:	000009b6 	.word	0x000009b6

c0d02d4c <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02d4c:	200e      	movs	r0, #14
c0d02d4e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02d50:	4801      	ldr	r0, [pc, #4]	; (c0d02d58 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02d52:	4478      	add	r0, pc
c0d02d54:	4770      	bx	lr
c0d02d56:	46c0      	nop			; (mov r8, r8)
c0d02d58:	000009aa 	.word	0x000009aa

c0d02d5c <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02d5c:	200e      	movs	r0, #14
c0d02d5e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02d60:	4801      	ldr	r0, [pc, #4]	; (c0d02d68 <USBD_ProductStrDescriptor+0xc>)
c0d02d62:	4478      	add	r0, pc
c0d02d64:	4770      	bx	lr
c0d02d66:	46c0      	nop			; (mov r8, r8)
c0d02d68:	00000927 	.word	0x00000927

c0d02d6c <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02d6c:	200a      	movs	r0, #10
c0d02d6e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02d70:	4801      	ldr	r0, [pc, #4]	; (c0d02d78 <USBD_SerialStrDescriptor+0xc>)
c0d02d72:	4478      	add	r0, pc
c0d02d74:	4770      	bx	lr
c0d02d76:	46c0      	nop			; (mov r8, r8)
c0d02d78:	00000998 	.word	0x00000998

c0d02d7c <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02d7c:	200e      	movs	r0, #14
c0d02d7e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02d80:	4801      	ldr	r0, [pc, #4]	; (c0d02d88 <USBD_ConfigStrDescriptor+0xc>)
c0d02d82:	4478      	add	r0, pc
c0d02d84:	4770      	bx	lr
c0d02d86:	46c0      	nop			; (mov r8, r8)
c0d02d88:	00000907 	.word	0x00000907

c0d02d8c <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02d8c:	200e      	movs	r0, #14
c0d02d8e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02d90:	4801      	ldr	r0, [pc, #4]	; (c0d02d98 <USBD_InterfaceStrDescriptor+0xc>)
c0d02d92:	4478      	add	r0, pc
c0d02d94:	4770      	bx	lr
c0d02d96:	46c0      	nop			; (mov r8, r8)
c0d02d98:	000008f7 	.word	0x000008f7

c0d02d9c <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02d9c:	2129      	movs	r1, #41	; 0x29
c0d02d9e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02da0:	4801      	ldr	r0, [pc, #4]	; (c0d02da8 <USBD_GetCfgDesc_impl+0xc>)
c0d02da2:	4478      	add	r0, pc
c0d02da4:	4770      	bx	lr
c0d02da6:	46c0      	nop			; (mov r8, r8)
c0d02da8:	000009aa 	.word	0x000009aa

c0d02dac <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02dac:	210a      	movs	r1, #10
c0d02dae:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02db0:	4801      	ldr	r0, [pc, #4]	; (c0d02db8 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02db2:	4478      	add	r0, pc
c0d02db4:	4770      	bx	lr
c0d02db6:	46c0      	nop			; (mov r8, r8)
c0d02db8:	000009c6 	.word	0x000009c6

c0d02dbc <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02dbc:	b5b0      	push	{r4, r5, r7, lr}
c0d02dbe:	af02      	add	r7, sp, #8
c0d02dc0:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02dc2:	21f4      	movs	r1, #244	; 0xf4
c0d02dc4:	2302      	movs	r3, #2
c0d02dc6:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02dc8:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02dca:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02dcc:	2109      	movs	r1, #9
c0d02dce:	0149      	lsls	r1, r1, #5
c0d02dd0:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02dd2:	6a01      	ldr	r1, [r0, #32]
c0d02dd4:	428a      	cmp	r2, r1
c0d02dd6:	d300      	bcc.n	c0d02dda <USBD_CtlSendData+0x1e>
c0d02dd8:	460a      	mov	r2, r1
c0d02dda:	b293      	uxth	r3, r2
c0d02ddc:	2500      	movs	r5, #0
c0d02dde:	4629      	mov	r1, r5
c0d02de0:	4622      	mov	r2, r4
c0d02de2:	f7ff faa0 	bl	c0d02326 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02de6:	4628      	mov	r0, r5
c0d02de8:	bdb0      	pop	{r4, r5, r7, pc}

c0d02dea <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02dea:	b5b0      	push	{r4, r5, r7, lr}
c0d02dec:	af02      	add	r7, sp, #8
c0d02dee:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02df0:	6a01      	ldr	r1, [r0, #32]
c0d02df2:	428a      	cmp	r2, r1
c0d02df4:	d300      	bcc.n	c0d02df8 <USBD_CtlContinueSendData+0xe>
c0d02df6:	460a      	mov	r2, r1
c0d02df8:	b293      	uxth	r3, r2
c0d02dfa:	2500      	movs	r5, #0
c0d02dfc:	4629      	mov	r1, r5
c0d02dfe:	4622      	mov	r2, r4
c0d02e00:	f7ff fa91 	bl	c0d02326 <USBD_LL_Transmit>
  return USBD_OK;
c0d02e04:	4628      	mov	r0, r5
c0d02e06:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e08 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02e08:	b5d0      	push	{r4, r6, r7, lr}
c0d02e0a:	af02      	add	r7, sp, #8
c0d02e0c:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02e0e:	4621      	mov	r1, r4
c0d02e10:	f7ff faa3 	bl	c0d0235a <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02e14:	4620      	mov	r0, r4
c0d02e16:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e18 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02e18:	b5d0      	push	{r4, r6, r7, lr}
c0d02e1a:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02e1c:	21f4      	movs	r1, #244	; 0xf4
c0d02e1e:	2204      	movs	r2, #4
c0d02e20:	5042      	str	r2, [r0, r1]
c0d02e22:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02e24:	4621      	mov	r1, r4
c0d02e26:	4622      	mov	r2, r4
c0d02e28:	4623      	mov	r3, r4
c0d02e2a:	f7ff fa7c 	bl	c0d02326 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02e2e:	4620      	mov	r0, r4
c0d02e30:	bdd0      	pop	{r4, r6, r7, pc}

c0d02e32 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02e32:	b5d0      	push	{r4, r6, r7, lr}
c0d02e34:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02e36:	21f4      	movs	r1, #244	; 0xf4
c0d02e38:	2205      	movs	r2, #5
c0d02e3a:	5042      	str	r2, [r0, r1]
c0d02e3c:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02e3e:	4621      	mov	r1, r4
c0d02e40:	4622      	mov	r2, r4
c0d02e42:	f7ff fa8a 	bl	c0d0235a <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02e46:	4620      	mov	r0, r4
c0d02e48:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02e4c <__aeabi_uidiv>:
c0d02e4c:	2200      	movs	r2, #0
c0d02e4e:	0843      	lsrs	r3, r0, #1
c0d02e50:	428b      	cmp	r3, r1
c0d02e52:	d374      	bcc.n	c0d02f3e <__aeabi_uidiv+0xf2>
c0d02e54:	0903      	lsrs	r3, r0, #4
c0d02e56:	428b      	cmp	r3, r1
c0d02e58:	d35f      	bcc.n	c0d02f1a <__aeabi_uidiv+0xce>
c0d02e5a:	0a03      	lsrs	r3, r0, #8
c0d02e5c:	428b      	cmp	r3, r1
c0d02e5e:	d344      	bcc.n	c0d02eea <__aeabi_uidiv+0x9e>
c0d02e60:	0b03      	lsrs	r3, r0, #12
c0d02e62:	428b      	cmp	r3, r1
c0d02e64:	d328      	bcc.n	c0d02eb8 <__aeabi_uidiv+0x6c>
c0d02e66:	0c03      	lsrs	r3, r0, #16
c0d02e68:	428b      	cmp	r3, r1
c0d02e6a:	d30d      	bcc.n	c0d02e88 <__aeabi_uidiv+0x3c>
c0d02e6c:	22ff      	movs	r2, #255	; 0xff
c0d02e6e:	0209      	lsls	r1, r1, #8
c0d02e70:	ba12      	rev	r2, r2
c0d02e72:	0c03      	lsrs	r3, r0, #16
c0d02e74:	428b      	cmp	r3, r1
c0d02e76:	d302      	bcc.n	c0d02e7e <__aeabi_uidiv+0x32>
c0d02e78:	1212      	asrs	r2, r2, #8
c0d02e7a:	0209      	lsls	r1, r1, #8
c0d02e7c:	d065      	beq.n	c0d02f4a <__aeabi_uidiv+0xfe>
c0d02e7e:	0b03      	lsrs	r3, r0, #12
c0d02e80:	428b      	cmp	r3, r1
c0d02e82:	d319      	bcc.n	c0d02eb8 <__aeabi_uidiv+0x6c>
c0d02e84:	e000      	b.n	c0d02e88 <__aeabi_uidiv+0x3c>
c0d02e86:	0a09      	lsrs	r1, r1, #8
c0d02e88:	0bc3      	lsrs	r3, r0, #15
c0d02e8a:	428b      	cmp	r3, r1
c0d02e8c:	d301      	bcc.n	c0d02e92 <__aeabi_uidiv+0x46>
c0d02e8e:	03cb      	lsls	r3, r1, #15
c0d02e90:	1ac0      	subs	r0, r0, r3
c0d02e92:	4152      	adcs	r2, r2
c0d02e94:	0b83      	lsrs	r3, r0, #14
c0d02e96:	428b      	cmp	r3, r1
c0d02e98:	d301      	bcc.n	c0d02e9e <__aeabi_uidiv+0x52>
c0d02e9a:	038b      	lsls	r3, r1, #14
c0d02e9c:	1ac0      	subs	r0, r0, r3
c0d02e9e:	4152      	adcs	r2, r2
c0d02ea0:	0b43      	lsrs	r3, r0, #13
c0d02ea2:	428b      	cmp	r3, r1
c0d02ea4:	d301      	bcc.n	c0d02eaa <__aeabi_uidiv+0x5e>
c0d02ea6:	034b      	lsls	r3, r1, #13
c0d02ea8:	1ac0      	subs	r0, r0, r3
c0d02eaa:	4152      	adcs	r2, r2
c0d02eac:	0b03      	lsrs	r3, r0, #12
c0d02eae:	428b      	cmp	r3, r1
c0d02eb0:	d301      	bcc.n	c0d02eb6 <__aeabi_uidiv+0x6a>
c0d02eb2:	030b      	lsls	r3, r1, #12
c0d02eb4:	1ac0      	subs	r0, r0, r3
c0d02eb6:	4152      	adcs	r2, r2
c0d02eb8:	0ac3      	lsrs	r3, r0, #11
c0d02eba:	428b      	cmp	r3, r1
c0d02ebc:	d301      	bcc.n	c0d02ec2 <__aeabi_uidiv+0x76>
c0d02ebe:	02cb      	lsls	r3, r1, #11
c0d02ec0:	1ac0      	subs	r0, r0, r3
c0d02ec2:	4152      	adcs	r2, r2
c0d02ec4:	0a83      	lsrs	r3, r0, #10
c0d02ec6:	428b      	cmp	r3, r1
c0d02ec8:	d301      	bcc.n	c0d02ece <__aeabi_uidiv+0x82>
c0d02eca:	028b      	lsls	r3, r1, #10
c0d02ecc:	1ac0      	subs	r0, r0, r3
c0d02ece:	4152      	adcs	r2, r2
c0d02ed0:	0a43      	lsrs	r3, r0, #9
c0d02ed2:	428b      	cmp	r3, r1
c0d02ed4:	d301      	bcc.n	c0d02eda <__aeabi_uidiv+0x8e>
c0d02ed6:	024b      	lsls	r3, r1, #9
c0d02ed8:	1ac0      	subs	r0, r0, r3
c0d02eda:	4152      	adcs	r2, r2
c0d02edc:	0a03      	lsrs	r3, r0, #8
c0d02ede:	428b      	cmp	r3, r1
c0d02ee0:	d301      	bcc.n	c0d02ee6 <__aeabi_uidiv+0x9a>
c0d02ee2:	020b      	lsls	r3, r1, #8
c0d02ee4:	1ac0      	subs	r0, r0, r3
c0d02ee6:	4152      	adcs	r2, r2
c0d02ee8:	d2cd      	bcs.n	c0d02e86 <__aeabi_uidiv+0x3a>
c0d02eea:	09c3      	lsrs	r3, r0, #7
c0d02eec:	428b      	cmp	r3, r1
c0d02eee:	d301      	bcc.n	c0d02ef4 <__aeabi_uidiv+0xa8>
c0d02ef0:	01cb      	lsls	r3, r1, #7
c0d02ef2:	1ac0      	subs	r0, r0, r3
c0d02ef4:	4152      	adcs	r2, r2
c0d02ef6:	0983      	lsrs	r3, r0, #6
c0d02ef8:	428b      	cmp	r3, r1
c0d02efa:	d301      	bcc.n	c0d02f00 <__aeabi_uidiv+0xb4>
c0d02efc:	018b      	lsls	r3, r1, #6
c0d02efe:	1ac0      	subs	r0, r0, r3
c0d02f00:	4152      	adcs	r2, r2
c0d02f02:	0943      	lsrs	r3, r0, #5
c0d02f04:	428b      	cmp	r3, r1
c0d02f06:	d301      	bcc.n	c0d02f0c <__aeabi_uidiv+0xc0>
c0d02f08:	014b      	lsls	r3, r1, #5
c0d02f0a:	1ac0      	subs	r0, r0, r3
c0d02f0c:	4152      	adcs	r2, r2
c0d02f0e:	0903      	lsrs	r3, r0, #4
c0d02f10:	428b      	cmp	r3, r1
c0d02f12:	d301      	bcc.n	c0d02f18 <__aeabi_uidiv+0xcc>
c0d02f14:	010b      	lsls	r3, r1, #4
c0d02f16:	1ac0      	subs	r0, r0, r3
c0d02f18:	4152      	adcs	r2, r2
c0d02f1a:	08c3      	lsrs	r3, r0, #3
c0d02f1c:	428b      	cmp	r3, r1
c0d02f1e:	d301      	bcc.n	c0d02f24 <__aeabi_uidiv+0xd8>
c0d02f20:	00cb      	lsls	r3, r1, #3
c0d02f22:	1ac0      	subs	r0, r0, r3
c0d02f24:	4152      	adcs	r2, r2
c0d02f26:	0883      	lsrs	r3, r0, #2
c0d02f28:	428b      	cmp	r3, r1
c0d02f2a:	d301      	bcc.n	c0d02f30 <__aeabi_uidiv+0xe4>
c0d02f2c:	008b      	lsls	r3, r1, #2
c0d02f2e:	1ac0      	subs	r0, r0, r3
c0d02f30:	4152      	adcs	r2, r2
c0d02f32:	0843      	lsrs	r3, r0, #1
c0d02f34:	428b      	cmp	r3, r1
c0d02f36:	d301      	bcc.n	c0d02f3c <__aeabi_uidiv+0xf0>
c0d02f38:	004b      	lsls	r3, r1, #1
c0d02f3a:	1ac0      	subs	r0, r0, r3
c0d02f3c:	4152      	adcs	r2, r2
c0d02f3e:	1a41      	subs	r1, r0, r1
c0d02f40:	d200      	bcs.n	c0d02f44 <__aeabi_uidiv+0xf8>
c0d02f42:	4601      	mov	r1, r0
c0d02f44:	4152      	adcs	r2, r2
c0d02f46:	4610      	mov	r0, r2
c0d02f48:	4770      	bx	lr
c0d02f4a:	e7ff      	b.n	c0d02f4c <__aeabi_uidiv+0x100>
c0d02f4c:	b501      	push	{r0, lr}
c0d02f4e:	2000      	movs	r0, #0
c0d02f50:	f000 f8f0 	bl	c0d03134 <__aeabi_idiv0>
c0d02f54:	bd02      	pop	{r1, pc}
c0d02f56:	46c0      	nop			; (mov r8, r8)

c0d02f58 <__aeabi_uidivmod>:
c0d02f58:	2900      	cmp	r1, #0
c0d02f5a:	d0f7      	beq.n	c0d02f4c <__aeabi_uidiv+0x100>
c0d02f5c:	e776      	b.n	c0d02e4c <__aeabi_uidiv>
c0d02f5e:	4770      	bx	lr

c0d02f60 <__aeabi_idiv>:
c0d02f60:	4603      	mov	r3, r0
c0d02f62:	430b      	orrs	r3, r1
c0d02f64:	d47f      	bmi.n	c0d03066 <__aeabi_idiv+0x106>
c0d02f66:	2200      	movs	r2, #0
c0d02f68:	0843      	lsrs	r3, r0, #1
c0d02f6a:	428b      	cmp	r3, r1
c0d02f6c:	d374      	bcc.n	c0d03058 <__aeabi_idiv+0xf8>
c0d02f6e:	0903      	lsrs	r3, r0, #4
c0d02f70:	428b      	cmp	r3, r1
c0d02f72:	d35f      	bcc.n	c0d03034 <__aeabi_idiv+0xd4>
c0d02f74:	0a03      	lsrs	r3, r0, #8
c0d02f76:	428b      	cmp	r3, r1
c0d02f78:	d344      	bcc.n	c0d03004 <__aeabi_idiv+0xa4>
c0d02f7a:	0b03      	lsrs	r3, r0, #12
c0d02f7c:	428b      	cmp	r3, r1
c0d02f7e:	d328      	bcc.n	c0d02fd2 <__aeabi_idiv+0x72>
c0d02f80:	0c03      	lsrs	r3, r0, #16
c0d02f82:	428b      	cmp	r3, r1
c0d02f84:	d30d      	bcc.n	c0d02fa2 <__aeabi_idiv+0x42>
c0d02f86:	22ff      	movs	r2, #255	; 0xff
c0d02f88:	0209      	lsls	r1, r1, #8
c0d02f8a:	ba12      	rev	r2, r2
c0d02f8c:	0c03      	lsrs	r3, r0, #16
c0d02f8e:	428b      	cmp	r3, r1
c0d02f90:	d302      	bcc.n	c0d02f98 <__aeabi_idiv+0x38>
c0d02f92:	1212      	asrs	r2, r2, #8
c0d02f94:	0209      	lsls	r1, r1, #8
c0d02f96:	d065      	beq.n	c0d03064 <__aeabi_idiv+0x104>
c0d02f98:	0b03      	lsrs	r3, r0, #12
c0d02f9a:	428b      	cmp	r3, r1
c0d02f9c:	d319      	bcc.n	c0d02fd2 <__aeabi_idiv+0x72>
c0d02f9e:	e000      	b.n	c0d02fa2 <__aeabi_idiv+0x42>
c0d02fa0:	0a09      	lsrs	r1, r1, #8
c0d02fa2:	0bc3      	lsrs	r3, r0, #15
c0d02fa4:	428b      	cmp	r3, r1
c0d02fa6:	d301      	bcc.n	c0d02fac <__aeabi_idiv+0x4c>
c0d02fa8:	03cb      	lsls	r3, r1, #15
c0d02faa:	1ac0      	subs	r0, r0, r3
c0d02fac:	4152      	adcs	r2, r2
c0d02fae:	0b83      	lsrs	r3, r0, #14
c0d02fb0:	428b      	cmp	r3, r1
c0d02fb2:	d301      	bcc.n	c0d02fb8 <__aeabi_idiv+0x58>
c0d02fb4:	038b      	lsls	r3, r1, #14
c0d02fb6:	1ac0      	subs	r0, r0, r3
c0d02fb8:	4152      	adcs	r2, r2
c0d02fba:	0b43      	lsrs	r3, r0, #13
c0d02fbc:	428b      	cmp	r3, r1
c0d02fbe:	d301      	bcc.n	c0d02fc4 <__aeabi_idiv+0x64>
c0d02fc0:	034b      	lsls	r3, r1, #13
c0d02fc2:	1ac0      	subs	r0, r0, r3
c0d02fc4:	4152      	adcs	r2, r2
c0d02fc6:	0b03      	lsrs	r3, r0, #12
c0d02fc8:	428b      	cmp	r3, r1
c0d02fca:	d301      	bcc.n	c0d02fd0 <__aeabi_idiv+0x70>
c0d02fcc:	030b      	lsls	r3, r1, #12
c0d02fce:	1ac0      	subs	r0, r0, r3
c0d02fd0:	4152      	adcs	r2, r2
c0d02fd2:	0ac3      	lsrs	r3, r0, #11
c0d02fd4:	428b      	cmp	r3, r1
c0d02fd6:	d301      	bcc.n	c0d02fdc <__aeabi_idiv+0x7c>
c0d02fd8:	02cb      	lsls	r3, r1, #11
c0d02fda:	1ac0      	subs	r0, r0, r3
c0d02fdc:	4152      	adcs	r2, r2
c0d02fde:	0a83      	lsrs	r3, r0, #10
c0d02fe0:	428b      	cmp	r3, r1
c0d02fe2:	d301      	bcc.n	c0d02fe8 <__aeabi_idiv+0x88>
c0d02fe4:	028b      	lsls	r3, r1, #10
c0d02fe6:	1ac0      	subs	r0, r0, r3
c0d02fe8:	4152      	adcs	r2, r2
c0d02fea:	0a43      	lsrs	r3, r0, #9
c0d02fec:	428b      	cmp	r3, r1
c0d02fee:	d301      	bcc.n	c0d02ff4 <__aeabi_idiv+0x94>
c0d02ff0:	024b      	lsls	r3, r1, #9
c0d02ff2:	1ac0      	subs	r0, r0, r3
c0d02ff4:	4152      	adcs	r2, r2
c0d02ff6:	0a03      	lsrs	r3, r0, #8
c0d02ff8:	428b      	cmp	r3, r1
c0d02ffa:	d301      	bcc.n	c0d03000 <__aeabi_idiv+0xa0>
c0d02ffc:	020b      	lsls	r3, r1, #8
c0d02ffe:	1ac0      	subs	r0, r0, r3
c0d03000:	4152      	adcs	r2, r2
c0d03002:	d2cd      	bcs.n	c0d02fa0 <__aeabi_idiv+0x40>
c0d03004:	09c3      	lsrs	r3, r0, #7
c0d03006:	428b      	cmp	r3, r1
c0d03008:	d301      	bcc.n	c0d0300e <__aeabi_idiv+0xae>
c0d0300a:	01cb      	lsls	r3, r1, #7
c0d0300c:	1ac0      	subs	r0, r0, r3
c0d0300e:	4152      	adcs	r2, r2
c0d03010:	0983      	lsrs	r3, r0, #6
c0d03012:	428b      	cmp	r3, r1
c0d03014:	d301      	bcc.n	c0d0301a <__aeabi_idiv+0xba>
c0d03016:	018b      	lsls	r3, r1, #6
c0d03018:	1ac0      	subs	r0, r0, r3
c0d0301a:	4152      	adcs	r2, r2
c0d0301c:	0943      	lsrs	r3, r0, #5
c0d0301e:	428b      	cmp	r3, r1
c0d03020:	d301      	bcc.n	c0d03026 <__aeabi_idiv+0xc6>
c0d03022:	014b      	lsls	r3, r1, #5
c0d03024:	1ac0      	subs	r0, r0, r3
c0d03026:	4152      	adcs	r2, r2
c0d03028:	0903      	lsrs	r3, r0, #4
c0d0302a:	428b      	cmp	r3, r1
c0d0302c:	d301      	bcc.n	c0d03032 <__aeabi_idiv+0xd2>
c0d0302e:	010b      	lsls	r3, r1, #4
c0d03030:	1ac0      	subs	r0, r0, r3
c0d03032:	4152      	adcs	r2, r2
c0d03034:	08c3      	lsrs	r3, r0, #3
c0d03036:	428b      	cmp	r3, r1
c0d03038:	d301      	bcc.n	c0d0303e <__aeabi_idiv+0xde>
c0d0303a:	00cb      	lsls	r3, r1, #3
c0d0303c:	1ac0      	subs	r0, r0, r3
c0d0303e:	4152      	adcs	r2, r2
c0d03040:	0883      	lsrs	r3, r0, #2
c0d03042:	428b      	cmp	r3, r1
c0d03044:	d301      	bcc.n	c0d0304a <__aeabi_idiv+0xea>
c0d03046:	008b      	lsls	r3, r1, #2
c0d03048:	1ac0      	subs	r0, r0, r3
c0d0304a:	4152      	adcs	r2, r2
c0d0304c:	0843      	lsrs	r3, r0, #1
c0d0304e:	428b      	cmp	r3, r1
c0d03050:	d301      	bcc.n	c0d03056 <__aeabi_idiv+0xf6>
c0d03052:	004b      	lsls	r3, r1, #1
c0d03054:	1ac0      	subs	r0, r0, r3
c0d03056:	4152      	adcs	r2, r2
c0d03058:	1a41      	subs	r1, r0, r1
c0d0305a:	d200      	bcs.n	c0d0305e <__aeabi_idiv+0xfe>
c0d0305c:	4601      	mov	r1, r0
c0d0305e:	4152      	adcs	r2, r2
c0d03060:	4610      	mov	r0, r2
c0d03062:	4770      	bx	lr
c0d03064:	e05d      	b.n	c0d03122 <__aeabi_idiv+0x1c2>
c0d03066:	0fca      	lsrs	r2, r1, #31
c0d03068:	d000      	beq.n	c0d0306c <__aeabi_idiv+0x10c>
c0d0306a:	4249      	negs	r1, r1
c0d0306c:	1003      	asrs	r3, r0, #32
c0d0306e:	d300      	bcc.n	c0d03072 <__aeabi_idiv+0x112>
c0d03070:	4240      	negs	r0, r0
c0d03072:	4053      	eors	r3, r2
c0d03074:	2200      	movs	r2, #0
c0d03076:	469c      	mov	ip, r3
c0d03078:	0903      	lsrs	r3, r0, #4
c0d0307a:	428b      	cmp	r3, r1
c0d0307c:	d32d      	bcc.n	c0d030da <__aeabi_idiv+0x17a>
c0d0307e:	0a03      	lsrs	r3, r0, #8
c0d03080:	428b      	cmp	r3, r1
c0d03082:	d312      	bcc.n	c0d030aa <__aeabi_idiv+0x14a>
c0d03084:	22fc      	movs	r2, #252	; 0xfc
c0d03086:	0189      	lsls	r1, r1, #6
c0d03088:	ba12      	rev	r2, r2
c0d0308a:	0a03      	lsrs	r3, r0, #8
c0d0308c:	428b      	cmp	r3, r1
c0d0308e:	d30c      	bcc.n	c0d030aa <__aeabi_idiv+0x14a>
c0d03090:	0189      	lsls	r1, r1, #6
c0d03092:	1192      	asrs	r2, r2, #6
c0d03094:	428b      	cmp	r3, r1
c0d03096:	d308      	bcc.n	c0d030aa <__aeabi_idiv+0x14a>
c0d03098:	0189      	lsls	r1, r1, #6
c0d0309a:	1192      	asrs	r2, r2, #6
c0d0309c:	428b      	cmp	r3, r1
c0d0309e:	d304      	bcc.n	c0d030aa <__aeabi_idiv+0x14a>
c0d030a0:	0189      	lsls	r1, r1, #6
c0d030a2:	d03a      	beq.n	c0d0311a <__aeabi_idiv+0x1ba>
c0d030a4:	1192      	asrs	r2, r2, #6
c0d030a6:	e000      	b.n	c0d030aa <__aeabi_idiv+0x14a>
c0d030a8:	0989      	lsrs	r1, r1, #6
c0d030aa:	09c3      	lsrs	r3, r0, #7
c0d030ac:	428b      	cmp	r3, r1
c0d030ae:	d301      	bcc.n	c0d030b4 <__aeabi_idiv+0x154>
c0d030b0:	01cb      	lsls	r3, r1, #7
c0d030b2:	1ac0      	subs	r0, r0, r3
c0d030b4:	4152      	adcs	r2, r2
c0d030b6:	0983      	lsrs	r3, r0, #6
c0d030b8:	428b      	cmp	r3, r1
c0d030ba:	d301      	bcc.n	c0d030c0 <__aeabi_idiv+0x160>
c0d030bc:	018b      	lsls	r3, r1, #6
c0d030be:	1ac0      	subs	r0, r0, r3
c0d030c0:	4152      	adcs	r2, r2
c0d030c2:	0943      	lsrs	r3, r0, #5
c0d030c4:	428b      	cmp	r3, r1
c0d030c6:	d301      	bcc.n	c0d030cc <__aeabi_idiv+0x16c>
c0d030c8:	014b      	lsls	r3, r1, #5
c0d030ca:	1ac0      	subs	r0, r0, r3
c0d030cc:	4152      	adcs	r2, r2
c0d030ce:	0903      	lsrs	r3, r0, #4
c0d030d0:	428b      	cmp	r3, r1
c0d030d2:	d301      	bcc.n	c0d030d8 <__aeabi_idiv+0x178>
c0d030d4:	010b      	lsls	r3, r1, #4
c0d030d6:	1ac0      	subs	r0, r0, r3
c0d030d8:	4152      	adcs	r2, r2
c0d030da:	08c3      	lsrs	r3, r0, #3
c0d030dc:	428b      	cmp	r3, r1
c0d030de:	d301      	bcc.n	c0d030e4 <__aeabi_idiv+0x184>
c0d030e0:	00cb      	lsls	r3, r1, #3
c0d030e2:	1ac0      	subs	r0, r0, r3
c0d030e4:	4152      	adcs	r2, r2
c0d030e6:	0883      	lsrs	r3, r0, #2
c0d030e8:	428b      	cmp	r3, r1
c0d030ea:	d301      	bcc.n	c0d030f0 <__aeabi_idiv+0x190>
c0d030ec:	008b      	lsls	r3, r1, #2
c0d030ee:	1ac0      	subs	r0, r0, r3
c0d030f0:	4152      	adcs	r2, r2
c0d030f2:	d2d9      	bcs.n	c0d030a8 <__aeabi_idiv+0x148>
c0d030f4:	0843      	lsrs	r3, r0, #1
c0d030f6:	428b      	cmp	r3, r1
c0d030f8:	d301      	bcc.n	c0d030fe <__aeabi_idiv+0x19e>
c0d030fa:	004b      	lsls	r3, r1, #1
c0d030fc:	1ac0      	subs	r0, r0, r3
c0d030fe:	4152      	adcs	r2, r2
c0d03100:	1a41      	subs	r1, r0, r1
c0d03102:	d200      	bcs.n	c0d03106 <__aeabi_idiv+0x1a6>
c0d03104:	4601      	mov	r1, r0
c0d03106:	4663      	mov	r3, ip
c0d03108:	4152      	adcs	r2, r2
c0d0310a:	105b      	asrs	r3, r3, #1
c0d0310c:	4610      	mov	r0, r2
c0d0310e:	d301      	bcc.n	c0d03114 <__aeabi_idiv+0x1b4>
c0d03110:	4240      	negs	r0, r0
c0d03112:	2b00      	cmp	r3, #0
c0d03114:	d500      	bpl.n	c0d03118 <__aeabi_idiv+0x1b8>
c0d03116:	4249      	negs	r1, r1
c0d03118:	4770      	bx	lr
c0d0311a:	4663      	mov	r3, ip
c0d0311c:	105b      	asrs	r3, r3, #1
c0d0311e:	d300      	bcc.n	c0d03122 <__aeabi_idiv+0x1c2>
c0d03120:	4240      	negs	r0, r0
c0d03122:	b501      	push	{r0, lr}
c0d03124:	2000      	movs	r0, #0
c0d03126:	f000 f805 	bl	c0d03134 <__aeabi_idiv0>
c0d0312a:	bd02      	pop	{r1, pc}

c0d0312c <__aeabi_idivmod>:
c0d0312c:	2900      	cmp	r1, #0
c0d0312e:	d0f8      	beq.n	c0d03122 <__aeabi_idiv+0x1c2>
c0d03130:	e716      	b.n	c0d02f60 <__aeabi_idiv>
c0d03132:	4770      	bx	lr

c0d03134 <__aeabi_idiv0>:
c0d03134:	4770      	bx	lr
c0d03136:	46c0      	nop			; (mov r8, r8)

c0d03138 <__aeabi_memclr>:
c0d03138:	b510      	push	{r4, lr}
c0d0313a:	2200      	movs	r2, #0
c0d0313c:	f000 f806 	bl	c0d0314c <__aeabi_memset>
c0d03140:	bd10      	pop	{r4, pc}
c0d03142:	46c0      	nop			; (mov r8, r8)

c0d03144 <__aeabi_memcpy>:
c0d03144:	b510      	push	{r4, lr}
c0d03146:	f000 f809 	bl	c0d0315c <memcpy>
c0d0314a:	bd10      	pop	{r4, pc}

c0d0314c <__aeabi_memset>:
c0d0314c:	0013      	movs	r3, r2
c0d0314e:	b510      	push	{r4, lr}
c0d03150:	000a      	movs	r2, r1
c0d03152:	0019      	movs	r1, r3
c0d03154:	f000 f840 	bl	c0d031d8 <memset>
c0d03158:	bd10      	pop	{r4, pc}
c0d0315a:	46c0      	nop			; (mov r8, r8)

c0d0315c <memcpy>:
c0d0315c:	b570      	push	{r4, r5, r6, lr}
c0d0315e:	2a0f      	cmp	r2, #15
c0d03160:	d932      	bls.n	c0d031c8 <memcpy+0x6c>
c0d03162:	000c      	movs	r4, r1
c0d03164:	4304      	orrs	r4, r0
c0d03166:	000b      	movs	r3, r1
c0d03168:	07a4      	lsls	r4, r4, #30
c0d0316a:	d131      	bne.n	c0d031d0 <memcpy+0x74>
c0d0316c:	0015      	movs	r5, r2
c0d0316e:	0004      	movs	r4, r0
c0d03170:	3d10      	subs	r5, #16
c0d03172:	092d      	lsrs	r5, r5, #4
c0d03174:	3501      	adds	r5, #1
c0d03176:	012d      	lsls	r5, r5, #4
c0d03178:	1949      	adds	r1, r1, r5
c0d0317a:	681e      	ldr	r6, [r3, #0]
c0d0317c:	6026      	str	r6, [r4, #0]
c0d0317e:	685e      	ldr	r6, [r3, #4]
c0d03180:	6066      	str	r6, [r4, #4]
c0d03182:	689e      	ldr	r6, [r3, #8]
c0d03184:	60a6      	str	r6, [r4, #8]
c0d03186:	68de      	ldr	r6, [r3, #12]
c0d03188:	3310      	adds	r3, #16
c0d0318a:	60e6      	str	r6, [r4, #12]
c0d0318c:	3410      	adds	r4, #16
c0d0318e:	4299      	cmp	r1, r3
c0d03190:	d1f3      	bne.n	c0d0317a <memcpy+0x1e>
c0d03192:	230f      	movs	r3, #15
c0d03194:	1945      	adds	r5, r0, r5
c0d03196:	4013      	ands	r3, r2
c0d03198:	2b03      	cmp	r3, #3
c0d0319a:	d91b      	bls.n	c0d031d4 <memcpy+0x78>
c0d0319c:	1f1c      	subs	r4, r3, #4
c0d0319e:	2300      	movs	r3, #0
c0d031a0:	08a4      	lsrs	r4, r4, #2
c0d031a2:	3401      	adds	r4, #1
c0d031a4:	00a4      	lsls	r4, r4, #2
c0d031a6:	58ce      	ldr	r6, [r1, r3]
c0d031a8:	50ee      	str	r6, [r5, r3]
c0d031aa:	3304      	adds	r3, #4
c0d031ac:	429c      	cmp	r4, r3
c0d031ae:	d1fa      	bne.n	c0d031a6 <memcpy+0x4a>
c0d031b0:	2303      	movs	r3, #3
c0d031b2:	192d      	adds	r5, r5, r4
c0d031b4:	1909      	adds	r1, r1, r4
c0d031b6:	401a      	ands	r2, r3
c0d031b8:	d005      	beq.n	c0d031c6 <memcpy+0x6a>
c0d031ba:	2300      	movs	r3, #0
c0d031bc:	5ccc      	ldrb	r4, [r1, r3]
c0d031be:	54ec      	strb	r4, [r5, r3]
c0d031c0:	3301      	adds	r3, #1
c0d031c2:	429a      	cmp	r2, r3
c0d031c4:	d1fa      	bne.n	c0d031bc <memcpy+0x60>
c0d031c6:	bd70      	pop	{r4, r5, r6, pc}
c0d031c8:	0005      	movs	r5, r0
c0d031ca:	2a00      	cmp	r2, #0
c0d031cc:	d1f5      	bne.n	c0d031ba <memcpy+0x5e>
c0d031ce:	e7fa      	b.n	c0d031c6 <memcpy+0x6a>
c0d031d0:	0005      	movs	r5, r0
c0d031d2:	e7f2      	b.n	c0d031ba <memcpy+0x5e>
c0d031d4:	001a      	movs	r2, r3
c0d031d6:	e7f8      	b.n	c0d031ca <memcpy+0x6e>

c0d031d8 <memset>:
c0d031d8:	b570      	push	{r4, r5, r6, lr}
c0d031da:	0783      	lsls	r3, r0, #30
c0d031dc:	d03f      	beq.n	c0d0325e <memset+0x86>
c0d031de:	1e54      	subs	r4, r2, #1
c0d031e0:	2a00      	cmp	r2, #0
c0d031e2:	d03b      	beq.n	c0d0325c <memset+0x84>
c0d031e4:	b2ce      	uxtb	r6, r1
c0d031e6:	0003      	movs	r3, r0
c0d031e8:	2503      	movs	r5, #3
c0d031ea:	e003      	b.n	c0d031f4 <memset+0x1c>
c0d031ec:	1e62      	subs	r2, r4, #1
c0d031ee:	2c00      	cmp	r4, #0
c0d031f0:	d034      	beq.n	c0d0325c <memset+0x84>
c0d031f2:	0014      	movs	r4, r2
c0d031f4:	3301      	adds	r3, #1
c0d031f6:	1e5a      	subs	r2, r3, #1
c0d031f8:	7016      	strb	r6, [r2, #0]
c0d031fa:	422b      	tst	r3, r5
c0d031fc:	d1f6      	bne.n	c0d031ec <memset+0x14>
c0d031fe:	2c03      	cmp	r4, #3
c0d03200:	d924      	bls.n	c0d0324c <memset+0x74>
c0d03202:	25ff      	movs	r5, #255	; 0xff
c0d03204:	400d      	ands	r5, r1
c0d03206:	022a      	lsls	r2, r5, #8
c0d03208:	4315      	orrs	r5, r2
c0d0320a:	042a      	lsls	r2, r5, #16
c0d0320c:	4315      	orrs	r5, r2
c0d0320e:	2c0f      	cmp	r4, #15
c0d03210:	d911      	bls.n	c0d03236 <memset+0x5e>
c0d03212:	0026      	movs	r6, r4
c0d03214:	3e10      	subs	r6, #16
c0d03216:	0936      	lsrs	r6, r6, #4
c0d03218:	3601      	adds	r6, #1
c0d0321a:	0136      	lsls	r6, r6, #4
c0d0321c:	001a      	movs	r2, r3
c0d0321e:	199b      	adds	r3, r3, r6
c0d03220:	6015      	str	r5, [r2, #0]
c0d03222:	6055      	str	r5, [r2, #4]
c0d03224:	6095      	str	r5, [r2, #8]
c0d03226:	60d5      	str	r5, [r2, #12]
c0d03228:	3210      	adds	r2, #16
c0d0322a:	4293      	cmp	r3, r2
c0d0322c:	d1f8      	bne.n	c0d03220 <memset+0x48>
c0d0322e:	220f      	movs	r2, #15
c0d03230:	4014      	ands	r4, r2
c0d03232:	2c03      	cmp	r4, #3
c0d03234:	d90a      	bls.n	c0d0324c <memset+0x74>
c0d03236:	1f26      	subs	r6, r4, #4
c0d03238:	08b6      	lsrs	r6, r6, #2
c0d0323a:	3601      	adds	r6, #1
c0d0323c:	00b6      	lsls	r6, r6, #2
c0d0323e:	001a      	movs	r2, r3
c0d03240:	199b      	adds	r3, r3, r6
c0d03242:	c220      	stmia	r2!, {r5}
c0d03244:	4293      	cmp	r3, r2
c0d03246:	d1fc      	bne.n	c0d03242 <memset+0x6a>
c0d03248:	2203      	movs	r2, #3
c0d0324a:	4014      	ands	r4, r2
c0d0324c:	2c00      	cmp	r4, #0
c0d0324e:	d005      	beq.n	c0d0325c <memset+0x84>
c0d03250:	b2c9      	uxtb	r1, r1
c0d03252:	191c      	adds	r4, r3, r4
c0d03254:	7019      	strb	r1, [r3, #0]
c0d03256:	3301      	adds	r3, #1
c0d03258:	429c      	cmp	r4, r3
c0d0325a:	d1fb      	bne.n	c0d03254 <memset+0x7c>
c0d0325c:	bd70      	pop	{r4, r5, r6, pc}
c0d0325e:	0014      	movs	r4, r2
c0d03260:	0003      	movs	r3, r0
c0d03262:	e7cc      	b.n	c0d031fe <memset+0x26>

c0d03264 <setjmp>:
c0d03264:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03266:	4641      	mov	r1, r8
c0d03268:	464a      	mov	r2, r9
c0d0326a:	4653      	mov	r3, sl
c0d0326c:	465c      	mov	r4, fp
c0d0326e:	466d      	mov	r5, sp
c0d03270:	4676      	mov	r6, lr
c0d03272:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03274:	3828      	subs	r0, #40	; 0x28
c0d03276:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03278:	2000      	movs	r0, #0
c0d0327a:	4770      	bx	lr

c0d0327c <longjmp>:
c0d0327c:	3010      	adds	r0, #16
c0d0327e:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03280:	4690      	mov	r8, r2
c0d03282:	4699      	mov	r9, r3
c0d03284:	46a2      	mov	sl, r4
c0d03286:	46ab      	mov	fp, r5
c0d03288:	46b5      	mov	sp, r6
c0d0328a:	c808      	ldmia	r0!, {r3}
c0d0328c:	3828      	subs	r0, #40	; 0x28
c0d0328e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03290:	1c08      	adds	r0, r1, #0
c0d03292:	d100      	bne.n	c0d03296 <longjmp+0x1a>
c0d03294:	2001      	movs	r0, #1
c0d03296:	4718      	bx	r3

c0d03298 <strlen>:
c0d03298:	b510      	push	{r4, lr}
c0d0329a:	0783      	lsls	r3, r0, #30
c0d0329c:	d027      	beq.n	c0d032ee <strlen+0x56>
c0d0329e:	7803      	ldrb	r3, [r0, #0]
c0d032a0:	2b00      	cmp	r3, #0
c0d032a2:	d026      	beq.n	c0d032f2 <strlen+0x5a>
c0d032a4:	0003      	movs	r3, r0
c0d032a6:	2103      	movs	r1, #3
c0d032a8:	e002      	b.n	c0d032b0 <strlen+0x18>
c0d032aa:	781a      	ldrb	r2, [r3, #0]
c0d032ac:	2a00      	cmp	r2, #0
c0d032ae:	d01c      	beq.n	c0d032ea <strlen+0x52>
c0d032b0:	3301      	adds	r3, #1
c0d032b2:	420b      	tst	r3, r1
c0d032b4:	d1f9      	bne.n	c0d032aa <strlen+0x12>
c0d032b6:	6819      	ldr	r1, [r3, #0]
c0d032b8:	4a0f      	ldr	r2, [pc, #60]	; (c0d032f8 <strlen+0x60>)
c0d032ba:	4c10      	ldr	r4, [pc, #64]	; (c0d032fc <strlen+0x64>)
c0d032bc:	188a      	adds	r2, r1, r2
c0d032be:	438a      	bics	r2, r1
c0d032c0:	4222      	tst	r2, r4
c0d032c2:	d10f      	bne.n	c0d032e4 <strlen+0x4c>
c0d032c4:	3304      	adds	r3, #4
c0d032c6:	6819      	ldr	r1, [r3, #0]
c0d032c8:	4a0b      	ldr	r2, [pc, #44]	; (c0d032f8 <strlen+0x60>)
c0d032ca:	188a      	adds	r2, r1, r2
c0d032cc:	438a      	bics	r2, r1
c0d032ce:	4222      	tst	r2, r4
c0d032d0:	d108      	bne.n	c0d032e4 <strlen+0x4c>
c0d032d2:	3304      	adds	r3, #4
c0d032d4:	6819      	ldr	r1, [r3, #0]
c0d032d6:	4a08      	ldr	r2, [pc, #32]	; (c0d032f8 <strlen+0x60>)
c0d032d8:	188a      	adds	r2, r1, r2
c0d032da:	438a      	bics	r2, r1
c0d032dc:	4222      	tst	r2, r4
c0d032de:	d0f1      	beq.n	c0d032c4 <strlen+0x2c>
c0d032e0:	e000      	b.n	c0d032e4 <strlen+0x4c>
c0d032e2:	3301      	adds	r3, #1
c0d032e4:	781a      	ldrb	r2, [r3, #0]
c0d032e6:	2a00      	cmp	r2, #0
c0d032e8:	d1fb      	bne.n	c0d032e2 <strlen+0x4a>
c0d032ea:	1a18      	subs	r0, r3, r0
c0d032ec:	bd10      	pop	{r4, pc}
c0d032ee:	0003      	movs	r3, r0
c0d032f0:	e7e1      	b.n	c0d032b6 <strlen+0x1e>
c0d032f2:	2000      	movs	r0, #0
c0d032f4:	e7fa      	b.n	c0d032ec <strlen+0x54>
c0d032f6:	46c0      	nop			; (mov r8, r8)
c0d032f8:	fefefeff 	.word	0xfefefeff
c0d032fc:	80808080 	.word	0x80808080
c0d03300:	45544550 	.word	0x45544550
c0d03304:	54455052 	.word	0x54455052
c0d03308:	45505245 	.word	0x45505245
c0d0330c:	50524554 	.word	0x50524554
c0d03310:	52455445 	.word	0x52455445
c0d03314:	45544550 	.word	0x45544550
c0d03318:	54455052 	.word	0x54455052
c0d0331c:	45505245 	.word	0x45505245
c0d03320:	50524554 	.word	0x50524554
c0d03324:	52455445 	.word	0x52455445
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
c0d03350:	00000052 	.word	0x00000052

c0d03354 <trits_mapping>:
c0d03354:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03364:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03374:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03384:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03394:	00000100 01000101 000101ff 01010101     ................
c0d033a4:	00000001                                ....

c0d033a8 <HALF_3>:
c0d033a8:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d033b8:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d033c8:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d033d8:	00000001                                ....

c0d033dc <bagl_ui_nanos_screen1>:
c0d033dc:	00000003 00800000 00000020 00000001     ........ .......
c0d033ec:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03414:	00000107 0080000c 00000020 00000000     ........ .......
c0d03424:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0344c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03464:	00070000 00000000 00000000 00000000     ................
	...
c0d03484:	00750005 0008000d 00000006 00000000     ..u.............
c0d03494:	00ffffff 00000000 00060000 00000000     ................
	...

c0d034bc <bagl_ui_nanos_screen2>:
c0d034bc:	00000003 00800000 00000020 00000001     ........ .......
c0d034cc:	00000000 00ffffff 00000000 00000000     ................
	...
c0d034f4:	00000107 00800012 00000020 00000000     ........ .......
c0d03504:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0352c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03544:	00070000 00000000 00000000 00000000     ................
	...
c0d03564:	00750005 0008000d 00000006 00000000     ..u.............
c0d03574:	00ffffff 00000000 00060000 00000000     ................
	...

c0d0359c <bagl_ui_sample_blue>:
c0d0359c:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d035ac:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d035d4:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d035e4:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d0360c:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d0361c:	00ffffff 001d2028 00002004 c0d0367c     ....( ... ..|6..
	...
c0d03644:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03654:	0041ccb4 00f9f9f9 0000a004 c0d03688     ..A..........6..
c0d03664:	00000000 0037ae99 00f9f9f9 c0d0211d     ......7......!..
	...
c0d0367c:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d0368d <USBD_PRODUCT_FS_STRING>:
c0d0368d:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d0369b <HID_ReportDesc>:
c0d0369b:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d036ab:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d036bb:	0000c008 11210900                                .....

c0d036c0 <USBD_HID_Desc>:
c0d036c0:	01112109 22220100 00011200                       .!...."".

c0d036c9 <USBD_DeviceDesc>:
c0d036c9:	02000112 40000000 00012c97 02010200     .......@.,......
c0d036d9:	2d000103                                         ...

c0d036dc <HID_Desc>:
c0d036dc:	c0d02d2d c0d02d3d c0d02d4d c0d02d5d     --..=-..M-..]-..
c0d036ec:	c0d02d6d c0d02d7d c0d02d8d 00000000     m-..}-...-......

c0d036fc <USBD_LangIDDesc>:
c0d036fc:	04090304                                ....

c0d03700 <USBD_MANUFACTURER_STRING>:
c0d03700:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d0370e <USB_SERIAL_STRING>:
c0d0370e:	0030030a 00300030 2c0f0031                       ..0.0.0.1.

c0d03718 <USBD_HID>:
c0d03718:	c0d02c0f c0d02c41 c0d02b73 00000000     .,..A,..s+......
	...
c0d03730:	c0d02c79 00000000 00000000 00000000     y,..............
c0d03740:	c0d02d9d c0d02d9d c0d02d9d c0d02dad     .-...-...-...-..

c0d03750 <USBD_CfgDesc>:
c0d03750:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03760:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03770:	05070100 00400302 00000001              ......@.....

c0d0377c <USBD_DeviceQualifierDesc>:
c0d0377c:	0200060a 40000000 00000001              .......@....

c0d03788 <_etext>:
	...

c0d037c0 <N_storage_real>:
	...
