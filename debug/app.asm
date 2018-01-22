
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
c0d00014:	f000 fdd4 	bl	c0d00bc0 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f000 fd20 	bl	c0d00a5c <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 f8a7 	bl	c0d03178 <setjmp>
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
c0d00040:	f000 ff64 	bl	c0d00f0c <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 fc45 	bl	c0d018d4 <pic>
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
c0d0005a:	f001 fc3b 	bl	c0d018d4 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 fc89 	bl	c0d01978 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f002 fd90 	bl	c0d02b8c <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f002 fd8d 	bl	c0d02b8c <USB_power>

            ui_idle();
c0d00072:	f001 ff21 	bl	c0d01eb8 <ui_idle>

            IOTA_main();
c0d00076:	f000 fb89 	bl	c0d0078c <IOTA_main>
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
c0d0008c:	f003 f880 	bl	c0d03190 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03680 	.word	0xc0d03680

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
c0d000ca:	f001 f9b3 	bl	c0d01434 <snprintf>
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
c0d00192:	f002 fe43 	bl	c0d02e1c <__aeabi_idiv>
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
c0d001c0:	f002 fda2 	bl	c0d02d08 <__aeabi_uidiv>
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
c0d001e4:	f000 f91e 	bl	c0d00424 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d001e8:	f000 f91c 	bl	c0d00424 <kerl_initialize>
c0d001ec:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d001ee:	4630      	mov	r0, r6
c0d001f0:	4621      	mov	r1, r4
c0d001f2:	462a      	mov	r2, r5
c0d001f4:	f002 ff30 	bl	c0d03058 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d001f8:	1970      	adds	r0, r6, r5
c0d001fa:	2130      	movs	r1, #48	; 0x30
c0d001fc:	1b4a      	subs	r2, r1, r5
c0d001fe:	460d      	mov	r5, r1
c0d00200:	9502      	str	r5, [sp, #8]
c0d00202:	4621      	mov	r1, r4
c0d00204:	f002 ff28 	bl	c0d03058 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00208:	4630      	mov	r0, r6
c0d0020a:	4629      	mov	r1, r5
c0d0020c:	f000 f916 	bl	c0d0043c <kerl_absorb_bytes>
c0d00210:	ac41      	add	r4, sp, #260	; 0x104
c0d00212:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d00214:	4620      	mov	r0, r4
c0d00216:	4629      	mov	r1, r5
c0d00218:	f002 ff18 	bl	c0d0304c <__aeabi_memclr>
c0d0021c:	ae04      	add	r6, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0021e:	491c      	ldr	r1, [pc, #112]	; (c0d00290 <get_seed+0xb8>)
c0d00220:	4479      	add	r1, pc
c0d00222:	2252      	movs	r2, #82	; 0x52
c0d00224:	4630      	mov	r0, r6
c0d00226:	f002 ff17 	bl	c0d03058 <__aeabi_memcpy>
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
c0d0023a:	f002 ff07 	bl	c0d0304c <__aeabi_memclr>
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
c0d00258:	f002 fef8 	bl	c0d0304c <__aeabi_memclr>
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
c0d00276:	f001 f8dd 	bl	c0d01434 <snprintf>
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
c0d00290:	00002ff0 	.word	0x00002ff0

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
c0d0033c:	00002f56 	.word	0x00002f56

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
c0d00372:	460c      	mov	r4, r1
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
c0d00384:	25f1      	movs	r5, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00386:	9406      	str	r4, [sp, #24]
c0d00388:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d0038a:	2105      	movs	r1, #5
c0d0038c:	4628      	mov	r0, r5
c0d0038e:	f002 fe2b 	bl	c0d02fe8 <__aeabi_idivmod>
c0d00392:	460e      	mov	r6, r1
c0d00394:	2e04      	cmp	r6, #4
c0d00396:	d10c      	bne.n	c0d003b2 <trints_to_words_u_mem+0x46>
c0d00398:	2105      	movs	r1, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d0039a:	4628      	mov	r0, r5
c0d0039c:	460c      	mov	r4, r1
c0d0039e:	f002 fd3d 	bl	c0d02e1c <__aeabi_idiv>
c0d003a2:	b2c0      	uxtb	r0, r0
c0d003a4:	9900      	ldr	r1, [sp, #0]
c0d003a6:	5608      	ldrsb	r0, [r1, r0]
c0d003a8:	a907      	add	r1, sp, #28
c0d003aa:	4622      	mov	r2, r4
c0d003ac:	9c06      	ldr	r4, [sp, #24]
c0d003ae:	f7ff fedb 	bl	c0d00168 <trint_to_trits>
c0d003b2:	9502      	str	r5, [sp, #8]
c0d003b4:	a807      	add	r0, sp, #28

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d003b6:	5d80      	ldrb	r0, [r0, r6]
c0d003b8:	1c41      	adds	r1, r0, #1
c0d003ba:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d003bc:	9804      	ldr	r0, [sp, #16]
c0d003be:	2800      	cmp	r0, #0
c0d003c0:	d020      	beq.n	c0d00404 <trints_to_words_u_mem+0x98>
c0d003c2:	9101      	str	r1, [sp, #4]
c0d003c4:	2500      	movs	r5, #0
c0d003c6:	462e      	mov	r6, r5
c0d003c8:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d003ca:	00b1      	lsls	r1, r6, #2
c0d003cc:	9105      	str	r1, [sp, #20]
c0d003ce:	9806      	ldr	r0, [sp, #24]
c0d003d0:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d003d2:	2203      	movs	r2, #3
c0d003d4:	9c03      	ldr	r4, [sp, #12]
c0d003d6:	4621      	mov	r1, r4
c0d003d8:	4623      	mov	r3, r4
c0d003da:	f002 fe0b 	bl	c0d02ff4 <__aeabi_lmul>
c0d003de:	9b04      	ldr	r3, [sp, #16]
c0d003e0:	1940      	adds	r0, r0, r5
c0d003e2:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d003e4:	9a06      	ldr	r2, [sp, #24]
c0d003e6:	9c05      	ldr	r4, [sp, #20]
c0d003e8:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d003ea:	1c76      	adds	r6, r6, #1
c0d003ec:	42b3      	cmp	r3, r6
c0d003ee:	460d      	mov	r5, r1
c0d003f0:	d1eb      	bne.n	c0d003ca <trints_to_words_u_mem+0x5e>
c0d003f2:	9c06      	ldr	r4, [sp, #24]
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d003f4:	2900      	cmp	r1, #0
c0d003f6:	d003      	beq.n	c0d00400 <trints_to_words_u_mem+0x94>
                base[sz] = carry;
c0d003f8:	0098      	lsls	r0, r3, #2
c0d003fa:	5021      	str	r1, [r4, r0]
                size++;
c0d003fc:	1c5d      	adds	r5, r3, #1
c0d003fe:	e000      	b.n	c0d00402 <trints_to_words_u_mem+0x96>
c0d00400:	461d      	mov	r5, r3
c0d00402:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d00404:	b2c9      	uxtb	r1, r1
c0d00406:	220c      	movs	r2, #12
c0d00408:	4620      	mov	r0, r4
c0d0040a:	f7ff ff43 	bl	c0d00294 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d0040e:	42a8      	cmp	r0, r5
c0d00410:	d800      	bhi.n	c0d00414 <trints_to_words_u_mem+0xa8>
c0d00412:	4628      	mov	r0, r5
c0d00414:	9902      	ldr	r1, [sp, #8]

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00416:	1e4d      	subs	r5, r1, #1
c0d00418:	2900      	cmp	r1, #0
c0d0041a:	dcb5      	bgt.n	c0d00388 <trints_to_words_u_mem+0x1c>
    //     bigint_not_u(tmp, 12);
    //     bigint_add_int_u(tmp, 1, base, 12);
    // }

    //outputs correct words according to official js
    return 0;
c0d0041c:	2000      	movs	r0, #0
c0d0041e:	b009      	add	sp, #36	; 0x24
c0d00420:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00424 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00424:	b580      	push	{r7, lr}
c0d00426:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00428:	2003      	movs	r0, #3
c0d0042a:	01c1      	lsls	r1, r0, #7
c0d0042c:	4802      	ldr	r0, [pc, #8]	; (c0d00438 <kerl_initialize+0x14>)
c0d0042e:	f001 fafd 	bl	c0d01a2c <cx_keccak_init>
    return 0;
c0d00432:	2000      	movs	r0, #0
c0d00434:	bd80      	pop	{r7, pc}
c0d00436:	46c0      	nop			; (mov r8, r8)
c0d00438:	20001840 	.word	0x20001840

c0d0043c <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d0043c:	b580      	push	{r7, lr}
c0d0043e:	af00      	add	r7, sp, #0
c0d00440:	b082      	sub	sp, #8
c0d00442:	460b      	mov	r3, r1
c0d00444:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00446:	4805      	ldr	r0, [pc, #20]	; (c0d0045c <kerl_absorb_bytes+0x20>)
c0d00448:	4669      	mov	r1, sp
c0d0044a:	6008      	str	r0, [r1, #0]
c0d0044c:	4804      	ldr	r0, [pc, #16]	; (c0d00460 <kerl_absorb_bytes+0x24>)
c0d0044e:	2101      	movs	r1, #1
c0d00450:	f001 fb0a 	bl	c0d01a68 <cx_hash>
c0d00454:	2000      	movs	r0, #0
    return 0;
c0d00456:	b002      	add	sp, #8
c0d00458:	bd80      	pop	{r7, pc}
c0d0045a:	46c0      	nop			; (mov r8, r8)
c0d0045c:	200019e8 	.word	0x200019e8
c0d00460:	20001840 	.word	0x20001840

c0d00464 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00464:	b580      	push	{r7, lr}
c0d00466:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00468:	4804      	ldr	r0, [pc, #16]	; (c0d0047c <nvram_is_init+0x18>)
c0d0046a:	f001 fa33 	bl	c0d018d4 <pic>
c0d0046e:	7801      	ldrb	r1, [r0, #0]
c0d00470:	2000      	movs	r0, #0
c0d00472:	2901      	cmp	r1, #1
c0d00474:	d100      	bne.n	c0d00478 <nvram_is_init+0x14>
c0d00476:	4608      	mov	r0, r1
    else return true;
}
c0d00478:	bd80      	pop	{r7, pc}
c0d0047a:	46c0      	nop			; (mov r8, r8)
c0d0047c:	c0d03680 	.word	0xc0d03680

c0d00480 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00480:	b5b0      	push	{r4, r5, r7, lr}
c0d00482:	af02      	add	r7, sp, #8
c0d00484:	4605      	mov	r5, r0
c0d00486:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00488:	4028      	ands	r0, r5
c0d0048a:	2400      	movs	r4, #0
c0d0048c:	2801      	cmp	r0, #1
c0d0048e:	d013      	beq.n	c0d004b8 <io_exchange_al+0x38>
c0d00490:	2802      	cmp	r0, #2
c0d00492:	d113      	bne.n	c0d004bc <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00494:	2900      	cmp	r1, #0
c0d00496:	d008      	beq.n	c0d004aa <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00498:	480b      	ldr	r0, [pc, #44]	; (c0d004c8 <io_exchange_al+0x48>)
c0d0049a:	f001 fbd7 	bl	c0d01c4c <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d0049e:	b268      	sxtb	r0, r5
c0d004a0:	2800      	cmp	r0, #0
c0d004a2:	da09      	bge.n	c0d004b8 <io_exchange_al+0x38>
                reset();
c0d004a4:	f001 fa4c 	bl	c0d01940 <reset>
c0d004a8:	e006      	b.n	c0d004b8 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d004aa:	2041      	movs	r0, #65	; 0x41
c0d004ac:	0081      	lsls	r1, r0, #2
c0d004ae:	4806      	ldr	r0, [pc, #24]	; (c0d004c8 <io_exchange_al+0x48>)
c0d004b0:	2200      	movs	r2, #0
c0d004b2:	f001 fc05 	bl	c0d01cc0 <io_seproxyhal_spi_recv>
c0d004b6:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d004b8:	4620      	mov	r0, r4
c0d004ba:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d004bc:	4803      	ldr	r0, [pc, #12]	; (c0d004cc <io_exchange_al+0x4c>)
c0d004be:	6800      	ldr	r0, [r0, #0]
c0d004c0:	2102      	movs	r1, #2
c0d004c2:	f002 fe65 	bl	c0d03190 <longjmp>
c0d004c6:	46c0      	nop			; (mov r8, r8)
c0d004c8:	20001c08 	.word	0x20001c08
c0d004cc:	20001bb8 	.word	0x20001bb8

c0d004d0 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d004d0:	b580      	push	{r7, lr}
c0d004d2:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d004d4:	f000 fe8e 	bl	c0d011f4 <io_seproxyhal_display_default>
}
c0d004d8:	bd80      	pop	{r7, pc}
	...

c0d004dc <io_event>:

unsigned char io_event(unsigned char channel) {
c0d004dc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004de:	af03      	add	r7, sp, #12
c0d004e0:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d004e2:	48a6      	ldr	r0, [pc, #664]	; (c0d0077c <io_event+0x2a0>)
c0d004e4:	7800      	ldrb	r0, [r0, #0]
c0d004e6:	2805      	cmp	r0, #5
c0d004e8:	d02e      	beq.n	c0d00548 <io_event+0x6c>
c0d004ea:	280d      	cmp	r0, #13
c0d004ec:	d04e      	beq.n	c0d0058c <io_event+0xb0>
c0d004ee:	280c      	cmp	r0, #12
c0d004f0:	d000      	beq.n	c0d004f4 <io_event+0x18>
c0d004f2:	e13a      	b.n	c0d0076a <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d004f4:	4ea2      	ldr	r6, [pc, #648]	; (c0d00780 <io_event+0x2a4>)
c0d004f6:	2001      	movs	r0, #1
c0d004f8:	7630      	strb	r0, [r6, #24]
c0d004fa:	2500      	movs	r5, #0
c0d004fc:	61f5      	str	r5, [r6, #28]
c0d004fe:	4634      	mov	r4, r6
c0d00500:	3418      	adds	r4, #24
c0d00502:	4620      	mov	r0, r4
c0d00504:	f001 fb68 	bl	c0d01bd8 <os_ux>
c0d00508:	61f0      	str	r0, [r6, #28]
c0d0050a:	499e      	ldr	r1, [pc, #632]	; (c0d00784 <io_event+0x2a8>)
c0d0050c:	4288      	cmp	r0, r1
c0d0050e:	d100      	bne.n	c0d00512 <io_event+0x36>
c0d00510:	e12b      	b.n	c0d0076a <io_event+0x28e>
c0d00512:	2800      	cmp	r0, #0
c0d00514:	d100      	bne.n	c0d00518 <io_event+0x3c>
c0d00516:	e128      	b.n	c0d0076a <io_event+0x28e>
c0d00518:	499b      	ldr	r1, [pc, #620]	; (c0d00788 <io_event+0x2ac>)
c0d0051a:	4288      	cmp	r0, r1
c0d0051c:	d000      	beq.n	c0d00520 <io_event+0x44>
c0d0051e:	e0ac      	b.n	c0d0067a <io_event+0x19e>
c0d00520:	2003      	movs	r0, #3
c0d00522:	7630      	strb	r0, [r6, #24]
c0d00524:	61f5      	str	r5, [r6, #28]
c0d00526:	4620      	mov	r0, r4
c0d00528:	f001 fb56 	bl	c0d01bd8 <os_ux>
c0d0052c:	61f0      	str	r0, [r6, #28]
c0d0052e:	f000 fd17 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d00532:	60b5      	str	r5, [r6, #8]
c0d00534:	6830      	ldr	r0, [r6, #0]
c0d00536:	2800      	cmp	r0, #0
c0d00538:	d100      	bne.n	c0d0053c <io_event+0x60>
c0d0053a:	e116      	b.n	c0d0076a <io_event+0x28e>
c0d0053c:	69f0      	ldr	r0, [r6, #28]
c0d0053e:	4991      	ldr	r1, [pc, #580]	; (c0d00784 <io_event+0x2a8>)
c0d00540:	4288      	cmp	r0, r1
c0d00542:	d000      	beq.n	c0d00546 <io_event+0x6a>
c0d00544:	e096      	b.n	c0d00674 <io_event+0x198>
c0d00546:	e110      	b.n	c0d0076a <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00548:	4d8d      	ldr	r5, [pc, #564]	; (c0d00780 <io_event+0x2a4>)
c0d0054a:	2001      	movs	r0, #1
c0d0054c:	7628      	strb	r0, [r5, #24]
c0d0054e:	2600      	movs	r6, #0
c0d00550:	61ee      	str	r6, [r5, #28]
c0d00552:	462c      	mov	r4, r5
c0d00554:	3418      	adds	r4, #24
c0d00556:	4620      	mov	r0, r4
c0d00558:	f001 fb3e 	bl	c0d01bd8 <os_ux>
c0d0055c:	4601      	mov	r1, r0
c0d0055e:	61e9      	str	r1, [r5, #28]
c0d00560:	4889      	ldr	r0, [pc, #548]	; (c0d00788 <io_event+0x2ac>)
c0d00562:	4281      	cmp	r1, r0
c0d00564:	d15d      	bne.n	c0d00622 <io_event+0x146>
c0d00566:	2003      	movs	r0, #3
c0d00568:	7628      	strb	r0, [r5, #24]
c0d0056a:	61ee      	str	r6, [r5, #28]
c0d0056c:	4620      	mov	r0, r4
c0d0056e:	f001 fb33 	bl	c0d01bd8 <os_ux>
c0d00572:	61e8      	str	r0, [r5, #28]
c0d00574:	f000 fcf4 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d00578:	60ae      	str	r6, [r5, #8]
c0d0057a:	6828      	ldr	r0, [r5, #0]
c0d0057c:	2800      	cmp	r0, #0
c0d0057e:	d100      	bne.n	c0d00582 <io_event+0xa6>
c0d00580:	e0f3      	b.n	c0d0076a <io_event+0x28e>
c0d00582:	69e8      	ldr	r0, [r5, #28]
c0d00584:	497f      	ldr	r1, [pc, #508]	; (c0d00784 <io_event+0x2a8>)
c0d00586:	4288      	cmp	r0, r1
c0d00588:	d148      	bne.n	c0d0061c <io_event+0x140>
c0d0058a:	e0ee      	b.n	c0d0076a <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d0058c:	4d7c      	ldr	r5, [pc, #496]	; (c0d00780 <io_event+0x2a4>)
c0d0058e:	6868      	ldr	r0, [r5, #4]
c0d00590:	68a9      	ldr	r1, [r5, #8]
c0d00592:	4281      	cmp	r1, r0
c0d00594:	d300      	bcc.n	c0d00598 <io_event+0xbc>
c0d00596:	e0e8      	b.n	c0d0076a <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00598:	2001      	movs	r0, #1
c0d0059a:	7628      	strb	r0, [r5, #24]
c0d0059c:	2600      	movs	r6, #0
c0d0059e:	61ee      	str	r6, [r5, #28]
c0d005a0:	462c      	mov	r4, r5
c0d005a2:	3418      	adds	r4, #24
c0d005a4:	4620      	mov	r0, r4
c0d005a6:	f001 fb17 	bl	c0d01bd8 <os_ux>
c0d005aa:	61e8      	str	r0, [r5, #28]
c0d005ac:	4975      	ldr	r1, [pc, #468]	; (c0d00784 <io_event+0x2a8>)
c0d005ae:	4288      	cmp	r0, r1
c0d005b0:	d100      	bne.n	c0d005b4 <io_event+0xd8>
c0d005b2:	e0da      	b.n	c0d0076a <io_event+0x28e>
c0d005b4:	2800      	cmp	r0, #0
c0d005b6:	d100      	bne.n	c0d005ba <io_event+0xde>
c0d005b8:	e0d7      	b.n	c0d0076a <io_event+0x28e>
c0d005ba:	4973      	ldr	r1, [pc, #460]	; (c0d00788 <io_event+0x2ac>)
c0d005bc:	4288      	cmp	r0, r1
c0d005be:	d000      	beq.n	c0d005c2 <io_event+0xe6>
c0d005c0:	e08d      	b.n	c0d006de <io_event+0x202>
c0d005c2:	2003      	movs	r0, #3
c0d005c4:	7628      	strb	r0, [r5, #24]
c0d005c6:	61ee      	str	r6, [r5, #28]
c0d005c8:	4620      	mov	r0, r4
c0d005ca:	f001 fb05 	bl	c0d01bd8 <os_ux>
c0d005ce:	61e8      	str	r0, [r5, #28]
c0d005d0:	f000 fcc6 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d005d4:	60ae      	str	r6, [r5, #8]
c0d005d6:	6828      	ldr	r0, [r5, #0]
c0d005d8:	2800      	cmp	r0, #0
c0d005da:	d100      	bne.n	c0d005de <io_event+0x102>
c0d005dc:	e0c5      	b.n	c0d0076a <io_event+0x28e>
c0d005de:	69e8      	ldr	r0, [r5, #28]
c0d005e0:	4968      	ldr	r1, [pc, #416]	; (c0d00784 <io_event+0x2a8>)
c0d005e2:	4288      	cmp	r0, r1
c0d005e4:	d178      	bne.n	c0d006d8 <io_event+0x1fc>
c0d005e6:	e0c0      	b.n	c0d0076a <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d005e8:	6868      	ldr	r0, [r5, #4]
c0d005ea:	4286      	cmp	r6, r0
c0d005ec:	d300      	bcc.n	c0d005f0 <io_event+0x114>
c0d005ee:	e0bc      	b.n	c0d0076a <io_event+0x28e>
c0d005f0:	f001 fb4a 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d005f4:	2800      	cmp	r0, #0
c0d005f6:	d000      	beq.n	c0d005fa <io_event+0x11e>
c0d005f8:	e0b7      	b.n	c0d0076a <io_event+0x28e>
c0d005fa:	68a8      	ldr	r0, [r5, #8]
c0d005fc:	68e9      	ldr	r1, [r5, #12]
c0d005fe:	2438      	movs	r4, #56	; 0x38
c0d00600:	4360      	muls	r0, r4
c0d00602:	682a      	ldr	r2, [r5, #0]
c0d00604:	1810      	adds	r0, r2, r0
c0d00606:	2900      	cmp	r1, #0
c0d00608:	d100      	bne.n	c0d0060c <io_event+0x130>
c0d0060a:	e085      	b.n	c0d00718 <io_event+0x23c>
c0d0060c:	4788      	blx	r1
c0d0060e:	2800      	cmp	r0, #0
c0d00610:	d000      	beq.n	c0d00614 <io_event+0x138>
c0d00612:	e081      	b.n	c0d00718 <io_event+0x23c>
c0d00614:	68a8      	ldr	r0, [r5, #8]
c0d00616:	1c46      	adds	r6, r0, #1
c0d00618:	60ae      	str	r6, [r5, #8]
c0d0061a:	6828      	ldr	r0, [r5, #0]
c0d0061c:	2800      	cmp	r0, #0
c0d0061e:	d1e3      	bne.n	c0d005e8 <io_event+0x10c>
c0d00620:	e0a3      	b.n	c0d0076a <io_event+0x28e>
c0d00622:	6928      	ldr	r0, [r5, #16]
c0d00624:	2800      	cmp	r0, #0
c0d00626:	d100      	bne.n	c0d0062a <io_event+0x14e>
c0d00628:	e09f      	b.n	c0d0076a <io_event+0x28e>
c0d0062a:	4a56      	ldr	r2, [pc, #344]	; (c0d00784 <io_event+0x2a8>)
c0d0062c:	4291      	cmp	r1, r2
c0d0062e:	d100      	bne.n	c0d00632 <io_event+0x156>
c0d00630:	e09b      	b.n	c0d0076a <io_event+0x28e>
c0d00632:	2900      	cmp	r1, #0
c0d00634:	d100      	bne.n	c0d00638 <io_event+0x15c>
c0d00636:	e098      	b.n	c0d0076a <io_event+0x28e>
c0d00638:	4950      	ldr	r1, [pc, #320]	; (c0d0077c <io_event+0x2a0>)
c0d0063a:	78c9      	ldrb	r1, [r1, #3]
c0d0063c:	0849      	lsrs	r1, r1, #1
c0d0063e:	f000 fe1b 	bl	c0d01278 <io_seproxyhal_button_push>
c0d00642:	e092      	b.n	c0d0076a <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00644:	6870      	ldr	r0, [r6, #4]
c0d00646:	4285      	cmp	r5, r0
c0d00648:	d300      	bcc.n	c0d0064c <io_event+0x170>
c0d0064a:	e08e      	b.n	c0d0076a <io_event+0x28e>
c0d0064c:	f001 fb1c 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d00650:	2800      	cmp	r0, #0
c0d00652:	d000      	beq.n	c0d00656 <io_event+0x17a>
c0d00654:	e089      	b.n	c0d0076a <io_event+0x28e>
c0d00656:	68b0      	ldr	r0, [r6, #8]
c0d00658:	68f1      	ldr	r1, [r6, #12]
c0d0065a:	2438      	movs	r4, #56	; 0x38
c0d0065c:	4360      	muls	r0, r4
c0d0065e:	6832      	ldr	r2, [r6, #0]
c0d00660:	1810      	adds	r0, r2, r0
c0d00662:	2900      	cmp	r1, #0
c0d00664:	d076      	beq.n	c0d00754 <io_event+0x278>
c0d00666:	4788      	blx	r1
c0d00668:	2800      	cmp	r0, #0
c0d0066a:	d173      	bne.n	c0d00754 <io_event+0x278>
c0d0066c:	68b0      	ldr	r0, [r6, #8]
c0d0066e:	1c45      	adds	r5, r0, #1
c0d00670:	60b5      	str	r5, [r6, #8]
c0d00672:	6830      	ldr	r0, [r6, #0]
c0d00674:	2800      	cmp	r0, #0
c0d00676:	d1e5      	bne.n	c0d00644 <io_event+0x168>
c0d00678:	e077      	b.n	c0d0076a <io_event+0x28e>
c0d0067a:	88b0      	ldrh	r0, [r6, #4]
c0d0067c:	9004      	str	r0, [sp, #16]
c0d0067e:	6830      	ldr	r0, [r6, #0]
c0d00680:	9003      	str	r0, [sp, #12]
c0d00682:	483e      	ldr	r0, [pc, #248]	; (c0d0077c <io_event+0x2a0>)
c0d00684:	4601      	mov	r1, r0
c0d00686:	79cc      	ldrb	r4, [r1, #7]
c0d00688:	798b      	ldrb	r3, [r1, #6]
c0d0068a:	794d      	ldrb	r5, [r1, #5]
c0d0068c:	790a      	ldrb	r2, [r1, #4]
c0d0068e:	4630      	mov	r0, r6
c0d00690:	78ce      	ldrb	r6, [r1, #3]
c0d00692:	68c1      	ldr	r1, [r0, #12]
c0d00694:	4668      	mov	r0, sp
c0d00696:	6006      	str	r6, [r0, #0]
c0d00698:	6041      	str	r1, [r0, #4]
c0d0069a:	0212      	lsls	r2, r2, #8
c0d0069c:	432a      	orrs	r2, r5
c0d0069e:	021b      	lsls	r3, r3, #8
c0d006a0:	4323      	orrs	r3, r4
c0d006a2:	9803      	ldr	r0, [sp, #12]
c0d006a4:	9904      	ldr	r1, [sp, #16]
c0d006a6:	f000 fcd5 	bl	c0d01054 <io_seproxyhal_touch_element_callback>
c0d006aa:	e05e      	b.n	c0d0076a <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d006ac:	6868      	ldr	r0, [r5, #4]
c0d006ae:	4286      	cmp	r6, r0
c0d006b0:	d25b      	bcs.n	c0d0076a <io_event+0x28e>
c0d006b2:	f001 fae9 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d006b6:	2800      	cmp	r0, #0
c0d006b8:	d157      	bne.n	c0d0076a <io_event+0x28e>
c0d006ba:	68a8      	ldr	r0, [r5, #8]
c0d006bc:	68e9      	ldr	r1, [r5, #12]
c0d006be:	2438      	movs	r4, #56	; 0x38
c0d006c0:	4360      	muls	r0, r4
c0d006c2:	682a      	ldr	r2, [r5, #0]
c0d006c4:	1810      	adds	r0, r2, r0
c0d006c6:	2900      	cmp	r1, #0
c0d006c8:	d026      	beq.n	c0d00718 <io_event+0x23c>
c0d006ca:	4788      	blx	r1
c0d006cc:	2800      	cmp	r0, #0
c0d006ce:	d123      	bne.n	c0d00718 <io_event+0x23c>
c0d006d0:	68a8      	ldr	r0, [r5, #8]
c0d006d2:	1c46      	adds	r6, r0, #1
c0d006d4:	60ae      	str	r6, [r5, #8]
c0d006d6:	6828      	ldr	r0, [r5, #0]
c0d006d8:	2800      	cmp	r0, #0
c0d006da:	d1e7      	bne.n	c0d006ac <io_event+0x1d0>
c0d006dc:	e045      	b.n	c0d0076a <io_event+0x28e>
c0d006de:	6828      	ldr	r0, [r5, #0]
c0d006e0:	2800      	cmp	r0, #0
c0d006e2:	d030      	beq.n	c0d00746 <io_event+0x26a>
c0d006e4:	68a8      	ldr	r0, [r5, #8]
c0d006e6:	6869      	ldr	r1, [r5, #4]
c0d006e8:	4288      	cmp	r0, r1
c0d006ea:	d22c      	bcs.n	c0d00746 <io_event+0x26a>
c0d006ec:	f001 facc 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d006f0:	2800      	cmp	r0, #0
c0d006f2:	d128      	bne.n	c0d00746 <io_event+0x26a>
c0d006f4:	68a8      	ldr	r0, [r5, #8]
c0d006f6:	68e9      	ldr	r1, [r5, #12]
c0d006f8:	2438      	movs	r4, #56	; 0x38
c0d006fa:	4360      	muls	r0, r4
c0d006fc:	682a      	ldr	r2, [r5, #0]
c0d006fe:	1810      	adds	r0, r2, r0
c0d00700:	2900      	cmp	r1, #0
c0d00702:	d015      	beq.n	c0d00730 <io_event+0x254>
c0d00704:	4788      	blx	r1
c0d00706:	2800      	cmp	r0, #0
c0d00708:	d112      	bne.n	c0d00730 <io_event+0x254>
c0d0070a:	68a8      	ldr	r0, [r5, #8]
c0d0070c:	1c40      	adds	r0, r0, #1
c0d0070e:	60a8      	str	r0, [r5, #8]
c0d00710:	6829      	ldr	r1, [r5, #0]
c0d00712:	2900      	cmp	r1, #0
c0d00714:	d1e7      	bne.n	c0d006e6 <io_event+0x20a>
c0d00716:	e016      	b.n	c0d00746 <io_event+0x26a>
c0d00718:	2801      	cmp	r0, #1
c0d0071a:	d103      	bne.n	c0d00724 <io_event+0x248>
c0d0071c:	68a8      	ldr	r0, [r5, #8]
c0d0071e:	4344      	muls	r4, r0
c0d00720:	6828      	ldr	r0, [r5, #0]
c0d00722:	1900      	adds	r0, r0, r4
c0d00724:	f000 fd66 	bl	c0d011f4 <io_seproxyhal_display_default>
c0d00728:	68a8      	ldr	r0, [r5, #8]
c0d0072a:	1c40      	adds	r0, r0, #1
c0d0072c:	60a8      	str	r0, [r5, #8]
c0d0072e:	e01c      	b.n	c0d0076a <io_event+0x28e>
c0d00730:	2801      	cmp	r0, #1
c0d00732:	d103      	bne.n	c0d0073c <io_event+0x260>
c0d00734:	68a8      	ldr	r0, [r5, #8]
c0d00736:	4344      	muls	r4, r0
c0d00738:	6828      	ldr	r0, [r5, #0]
c0d0073a:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0073c:	f000 fd5a 	bl	c0d011f4 <io_seproxyhal_display_default>
c0d00740:	68a8      	ldr	r0, [r5, #8]
c0d00742:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00744:	60a8      	str	r0, [r5, #8]
c0d00746:	6868      	ldr	r0, [r5, #4]
c0d00748:	68a9      	ldr	r1, [r5, #8]
c0d0074a:	4281      	cmp	r1, r0
c0d0074c:	d30d      	bcc.n	c0d0076a <io_event+0x28e>
c0d0074e:	f001 fa9b 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d00752:	e00a      	b.n	c0d0076a <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00754:	2801      	cmp	r0, #1
c0d00756:	d103      	bne.n	c0d00760 <io_event+0x284>
c0d00758:	68b0      	ldr	r0, [r6, #8]
c0d0075a:	4344      	muls	r4, r0
c0d0075c:	6830      	ldr	r0, [r6, #0]
c0d0075e:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00760:	f000 fd48 	bl	c0d011f4 <io_seproxyhal_display_default>
c0d00764:	68b0      	ldr	r0, [r6, #8]
c0d00766:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00768:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d0076a:	f001 fa8d 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d0076e:	2800      	cmp	r0, #0
c0d00770:	d101      	bne.n	c0d00776 <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00772:	f000 fac9 	bl	c0d00d08 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00776:	2001      	movs	r0, #1
c0d00778:	b005      	add	sp, #20
c0d0077a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0077c:	20001a18 	.word	0x20001a18
c0d00780:	20001a98 	.word	0x20001a98
c0d00784:	b0105044 	.word	0xb0105044
c0d00788:	b0105055 	.word	0xb0105055

c0d0078c <IOTA_main>:





static void IOTA_main(void) {
c0d0078c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0078e:	af03      	add	r7, sp, #12
c0d00790:	b0dd      	sub	sp, #372	; 0x174
c0d00792:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00794:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00796:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00798:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d0079a:	a0a1      	add	r0, pc, #644	; (adr r0, c0d00a20 <IOTA_main+0x294>)
c0d0079c:	2110      	movs	r1, #16
c0d0079e:	2203      	movs	r2, #3
c0d007a0:	9109      	str	r1, [sp, #36]	; 0x24
c0d007a2:	9208      	str	r2, [sp, #32]
c0d007a4:	f7ff fc7e 	bl	c0d000a4 <write_debug>
c0d007a8:	a80e      	add	r0, sp, #56	; 0x38
c0d007aa:	304d      	adds	r0, #77	; 0x4d
c0d007ac:	9007      	str	r0, [sp, #28]
c0d007ae:	a80b      	add	r0, sp, #44	; 0x2c
c0d007b0:	1dc1      	adds	r1, r0, #7
c0d007b2:	9106      	str	r1, [sp, #24]
c0d007b4:	1d00      	adds	r0, r0, #4
c0d007b6:	9005      	str	r0, [sp, #20]
c0d007b8:	4e9d      	ldr	r6, [pc, #628]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d007ba:	6830      	ldr	r0, [r6, #0]
c0d007bc:	e08d      	b.n	c0d008da <IOTA_main+0x14e>
c0d007be:	489f      	ldr	r0, [pc, #636]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d007c0:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d007c2:	4330      	orrs	r0, r6
c0d007c4:	2880      	cmp	r0, #128	; 0x80
c0d007c6:	d000      	beq.n	c0d007ca <IOTA_main+0x3e>
c0d007c8:	e11e      	b.n	c0d00a08 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d007ca:	7810      	ldrb	r0, [r2, #0]
c0d007cc:	2800      	cmp	r0, #0
c0d007ce:	4e98      	ldr	r6, [pc, #608]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d007d0:	d004      	beq.n	c0d007dc <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d007d2:	489c      	ldr	r0, [pc, #624]	; (c0d00a44 <IOTA_main+0x2b8>)
c0d007d4:	f001 f90c 	bl	c0d019f0 <cx_sha256_init>
                        hashTainted = 0;
c0d007d8:	4899      	ldr	r0, [pc, #612]	; (c0d00a40 <IOTA_main+0x2b4>)
c0d007da:	7004      	strb	r4, [r0, #0]
c0d007dc:	4897      	ldr	r0, [pc, #604]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d007de:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d007e0:	7908      	ldrb	r0, [r1, #4]
c0d007e2:	1808      	adds	r0, r1, r0
c0d007e4:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d007e6:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d007e8:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d007ea:	4308      	orrs	r0, r1
c0d007ec:	905a      	str	r0, [sp, #360]	; 0x168
c0d007ee:	e0e5      	b.n	c0d009bc <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d007f0:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d007f2:	2818      	cmp	r0, #24
c0d007f4:	d800      	bhi.n	c0d007f8 <IOTA_main+0x6c>
c0d007f6:	e10c      	b.n	c0d00a12 <IOTA_main+0x286>
c0d007f8:	950a      	str	r5, [sp, #40]	; 0x28
c0d007fa:	4d90      	ldr	r5, [pc, #576]	; (c0d00a3c <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d007fc:	00a0      	lsls	r0, r4, #2
c0d007fe:	1829      	adds	r1, r5, r0
c0d00800:	794a      	ldrb	r2, [r1, #5]
c0d00802:	0612      	lsls	r2, r2, #24
c0d00804:	798b      	ldrb	r3, [r1, #6]
c0d00806:	041b      	lsls	r3, r3, #16
c0d00808:	4313      	orrs	r3, r2
c0d0080a:	79ca      	ldrb	r2, [r1, #7]
c0d0080c:	0212      	lsls	r2, r2, #8
c0d0080e:	431a      	orrs	r2, r3
c0d00810:	7a09      	ldrb	r1, [r1, #8]
c0d00812:	4311      	orrs	r1, r2
c0d00814:	aa2b      	add	r2, sp, #172	; 0xac
c0d00816:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00818:	1c64      	adds	r4, r4, #1
c0d0081a:	2c05      	cmp	r4, #5
c0d0081c:	d1ee      	bne.n	c0d007fc <IOTA_main+0x70>
c0d0081e:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00820:	9103      	str	r1, [sp, #12]
c0d00822:	4668      	mov	r0, sp
c0d00824:	6001      	str	r1, [r0, #0]
c0d00826:	2421      	movs	r4, #33	; 0x21
c0d00828:	a92b      	add	r1, sp, #172	; 0xac
c0d0082a:	2205      	movs	r2, #5
c0d0082c:	ad23      	add	r5, sp, #140	; 0x8c
c0d0082e:	9502      	str	r5, [sp, #8]
c0d00830:	4620      	mov	r0, r4
c0d00832:	462b      	mov	r3, r5
c0d00834:	f001 f992 	bl	c0d01b5c <os_perso_derive_node_bip32>
c0d00838:	2220      	movs	r2, #32
c0d0083a:	9204      	str	r2, [sp, #16]
c0d0083c:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d0083e:	9301      	str	r3, [sp, #4]
c0d00840:	4620      	mov	r0, r4
c0d00842:	4629      	mov	r1, r5
c0d00844:	f001 f94e 	bl	c0d01ae4 <cx_ecfp_init_private_key>
c0d00848:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d0084a:	4620      	mov	r0, r4
c0d0084c:	9903      	ldr	r1, [sp, #12]
c0d0084e:	460a      	mov	r2, r1
c0d00850:	462b      	mov	r3, r5
c0d00852:	f001 f929 	bl	c0d01aa8 <cx_ecfp_init_public_key>
c0d00856:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00858:	4620      	mov	r0, r4
c0d0085a:	4629      	mov	r1, r5
c0d0085c:	9a01      	ldr	r2, [sp, #4]
c0d0085e:	f001 f95f 	bl	c0d01b20 <cx_ecfp_generate_pair>
c0d00862:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00864:	9802      	ldr	r0, [sp, #8]
c0d00866:	9904      	ldr	r1, [sp, #16]
c0d00868:	4622      	mov	r2, r4
c0d0086a:	f7ff fcb5 	bl	c0d001d8 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d0086e:	2552      	movs	r5, #82	; 0x52
c0d00870:	4872      	ldr	r0, [pc, #456]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d00872:	4621      	mov	r1, r4
c0d00874:	462a      	mov	r2, r5
c0d00876:	f000 f9ad 	bl	c0d00bd4 <os_memmove>
                    tx = 82;
c0d0087a:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d0087c:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0087e:	1c41      	adds	r1, r0, #1
c0d00880:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00882:	3610      	adds	r6, #16
c0d00884:	4a6d      	ldr	r2, [pc, #436]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d00886:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00888:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0088a:	1c41      	adds	r1, r0, #1
c0d0088c:	915b      	str	r1, [sp, #364]	; 0x16c
c0d0088e:	9903      	ldr	r1, [sp, #12]
c0d00890:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00892:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00894:	b281      	uxth	r1, r0
c0d00896:	9804      	ldr	r0, [sp, #16]
c0d00898:	f000 fd2a 	bl	c0d012f0 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d0089c:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0089e:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d008a0:	4308      	orrs	r0, r1
c0d008a2:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d008a4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d008a6:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d008a8:	202e      	movs	r0, #46	; 0x2e
c0d008aa:	9905      	ldr	r1, [sp, #20]
c0d008ac:	7048      	strb	r0, [r1, #1]
c0d008ae:	7008      	strb	r0, [r1, #0]
c0d008b0:	7088      	strb	r0, [r1, #2]
c0d008b2:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d008b4:	78c8      	ldrb	r0, [r1, #3]
c0d008b6:	9a06      	ldr	r2, [sp, #24]
c0d008b8:	70d0      	strb	r0, [r2, #3]
c0d008ba:	7888      	ldrb	r0, [r1, #2]
c0d008bc:	7090      	strb	r0, [r2, #2]
c0d008be:	7848      	ldrb	r0, [r1, #1]
c0d008c0:	7050      	strb	r0, [r2, #1]
c0d008c2:	7808      	ldrb	r0, [r1, #0]
c0d008c4:	7010      	strb	r0, [r2, #0]
c0d008c6:	7908      	ldrb	r0, [r1, #4]
c0d008c8:	7110      	strb	r0, [r2, #4]
c0d008ca:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d008cc:	2140      	movs	r1, #64	; 0x40
c0d008ce:	2203      	movs	r2, #3
c0d008d0:	f001 fa8a 	bl	c0d01de8 <ui_display_debug>
c0d008d4:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d008d6:	4e56      	ldr	r6, [pc, #344]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d008d8:	e070      	b.n	c0d009bc <IOTA_main+0x230>
c0d008da:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d008dc:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d008de:	9057      	str	r0, [sp, #348]	; 0x15c
c0d008e0:	ac4d      	add	r4, sp, #308	; 0x134
c0d008e2:	4620      	mov	r0, r4
c0d008e4:	f002 fc48 	bl	c0d03178 <setjmp>
c0d008e8:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d008ea:	6034      	str	r4, [r6, #0]
c0d008ec:	4951      	ldr	r1, [pc, #324]	; (c0d00a34 <IOTA_main+0x2a8>)
c0d008ee:	4208      	tst	r0, r1
c0d008f0:	d011      	beq.n	c0d00916 <IOTA_main+0x18a>
c0d008f2:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d008f4:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d008f6:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d008f8:	6031      	str	r1, [r6, #0]
c0d008fa:	210f      	movs	r1, #15
c0d008fc:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d008fe:	4001      	ands	r1, r0
c0d00900:	2209      	movs	r2, #9
c0d00902:	0312      	lsls	r2, r2, #12
c0d00904:	4291      	cmp	r1, r2
c0d00906:	d003      	beq.n	c0d00910 <IOTA_main+0x184>
c0d00908:	9a08      	ldr	r2, [sp, #32]
c0d0090a:	0352      	lsls	r2, r2, #13
c0d0090c:	4291      	cmp	r1, r2
c0d0090e:	d142      	bne.n	c0d00996 <IOTA_main+0x20a>
c0d00910:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00912:	8008      	strh	r0, [r1, #0]
c0d00914:	e046      	b.n	c0d009a4 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00916:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00918:	905c      	str	r0, [sp, #368]	; 0x170
c0d0091a:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d0091c:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d0091e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00920:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00922:	b2c0      	uxtb	r0, r0
c0d00924:	b289      	uxth	r1, r1
c0d00926:	f000 fce3 	bl	c0d012f0 <io_exchange>
c0d0092a:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d0092c:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d0092e:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00930:	2800      	cmp	r0, #0
c0d00932:	d053      	beq.n	c0d009dc <IOTA_main+0x250>
c0d00934:	4941      	ldr	r1, [pc, #260]	; (c0d00a3c <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00936:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00938:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d0093a:	2880      	cmp	r0, #128	; 0x80
c0d0093c:	4a40      	ldr	r2, [pc, #256]	; (c0d00a40 <IOTA_main+0x2b4>)
c0d0093e:	d155      	bne.n	c0d009ec <IOTA_main+0x260>
c0d00940:	7848      	ldrb	r0, [r1, #1]
c0d00942:	216d      	movs	r1, #109	; 0x6d
c0d00944:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00946:	2807      	cmp	r0, #7
c0d00948:	dc3f      	bgt.n	c0d009ca <IOTA_main+0x23e>
c0d0094a:	2802      	cmp	r0, #2
c0d0094c:	d100      	bne.n	c0d00950 <IOTA_main+0x1c4>
c0d0094e:	e74f      	b.n	c0d007f0 <IOTA_main+0x64>
c0d00950:	2804      	cmp	r0, #4
c0d00952:	d153      	bne.n	c0d009fc <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00954:	210b      	movs	r1, #11
c0d00956:	2203      	movs	r2, #3
c0d00958:	a03c      	add	r0, pc, #240	; (adr r0, c0d00a4c <IOTA_main+0x2c0>)
c0d0095a:	f7ff fba3 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d0095e:	2048      	movs	r0, #72	; 0x48
c0d00960:	4936      	ldr	r1, [pc, #216]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d00962:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00964:	2049      	movs	r0, #73	; 0x49
c0d00966:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00968:	2021      	movs	r0, #33	; 0x21
c0d0096a:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d0096c:	3610      	adds	r6, #16
c0d0096e:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00970:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00972:	2005      	movs	r0, #5
c0d00974:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00976:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00978:	b281      	uxth	r1, r0
c0d0097a:	2020      	movs	r0, #32
c0d0097c:	f000 fcb8 	bl	c0d012f0 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00980:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00982:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00984:	4308      	orrs	r0, r1
c0d00986:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00988:	4620      	mov	r0, r4
c0d0098a:	4621      	mov	r1, r4
c0d0098c:	4622      	mov	r2, r4
c0d0098e:	f001 fa2b 	bl	c0d01de8 <ui_display_debug>
c0d00992:	4e27      	ldr	r6, [pc, #156]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d00994:	e012      	b.n	c0d009bc <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00996:	4928      	ldr	r1, [pc, #160]	; (c0d00a38 <IOTA_main+0x2ac>)
c0d00998:	4008      	ands	r0, r1
c0d0099a:	210d      	movs	r1, #13
c0d0099c:	02c9      	lsls	r1, r1, #11
c0d0099e:	4301      	orrs	r1, r0
c0d009a0:	a859      	add	r0, sp, #356	; 0x164
c0d009a2:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d009a4:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d009a6:	0a00      	lsrs	r0, r0, #8
c0d009a8:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d009aa:	4a24      	ldr	r2, [pc, #144]	; (c0d00a3c <IOTA_main+0x2b0>)
c0d009ac:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d009ae:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d009b0:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d009b2:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d009b4:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d009b6:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d009b8:	1c80      	adds	r0, r0, #2
c0d009ba:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d009bc:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d009be:	6030      	str	r0, [r6, #0]
c0d009c0:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d009c2:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d009c4:	2900      	cmp	r1, #0
c0d009c6:	d088      	beq.n	c0d008da <IOTA_main+0x14e>
c0d009c8:	e006      	b.n	c0d009d8 <IOTA_main+0x24c>
c0d009ca:	2808      	cmp	r0, #8
c0d009cc:	d100      	bne.n	c0d009d0 <IOTA_main+0x244>
c0d009ce:	e6f6      	b.n	c0d007be <IOTA_main+0x32>
c0d009d0:	28ff      	cmp	r0, #255	; 0xff
c0d009d2:	d113      	bne.n	c0d009fc <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d009d4:	b05d      	add	sp, #372	; 0x174
c0d009d6:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d009d8:	f002 fbda 	bl	c0d03190 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d009dc:	2001      	movs	r0, #1
c0d009de:	4918      	ldr	r1, [pc, #96]	; (c0d00a40 <IOTA_main+0x2b4>)
c0d009e0:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d009e2:	4813      	ldr	r0, [pc, #76]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d009e4:	6800      	ldr	r0, [r0, #0]
c0d009e6:	491c      	ldr	r1, [pc, #112]	; (c0d00a58 <IOTA_main+0x2cc>)
c0d009e8:	f002 fbd2 	bl	c0d03190 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d009ec:	2001      	movs	r0, #1
c0d009ee:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d009f0:	480f      	ldr	r0, [pc, #60]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d009f2:	6800      	ldr	r0, [r0, #0]
c0d009f4:	2137      	movs	r1, #55	; 0x37
c0d009f6:	0249      	lsls	r1, r1, #9
c0d009f8:	f002 fbca 	bl	c0d03190 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d009fc:	2001      	movs	r0, #1
c0d009fe:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d00a00:	480b      	ldr	r0, [pc, #44]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d00a02:	6800      	ldr	r0, [r0, #0]
c0d00a04:	f002 fbc4 	bl	c0d03190 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d00a08:	4809      	ldr	r0, [pc, #36]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d00a0a:	6800      	ldr	r0, [r0, #0]
c0d00a0c:	490e      	ldr	r1, [pc, #56]	; (c0d00a48 <IOTA_main+0x2bc>)
c0d00a0e:	f002 fbbf 	bl	c0d03190 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d00a12:	2001      	movs	r0, #1
c0d00a14:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d00a16:	4806      	ldr	r0, [pc, #24]	; (c0d00a30 <IOTA_main+0x2a4>)
c0d00a18:	6800      	ldr	r0, [r0, #0]
c0d00a1a:	3109      	adds	r1, #9
c0d00a1c:	f002 fbb8 	bl	c0d03190 <longjmp>
c0d00a20:	74696157 	.word	0x74696157
c0d00a24:	20676e69 	.word	0x20676e69
c0d00a28:	20726f66 	.word	0x20726f66
c0d00a2c:	0067736d 	.word	0x0067736d
c0d00a30:	20001bb8 	.word	0x20001bb8
c0d00a34:	0000ffff 	.word	0x0000ffff
c0d00a38:	000007ff 	.word	0x000007ff
c0d00a3c:	20001c08 	.word	0x20001c08
c0d00a40:	20001b48 	.word	0x20001b48
c0d00a44:	20001b4c 	.word	0x20001b4c
c0d00a48:	00006a86 	.word	0x00006a86
c0d00a4c:	20646142 	.word	0x20646142
c0d00a50:	6b627550 	.word	0x6b627550
c0d00a54:	00007965 	.word	0x00007965
c0d00a58:	00006982 	.word	0x00006982

c0d00a5c <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00a5c:	4801      	ldr	r0, [pc, #4]	; (c0d00a64 <os_boot+0x8>)
c0d00a5e:	2100      	movs	r1, #0
c0d00a60:	6001      	str	r1, [r0, #0]
}
c0d00a62:	4770      	bx	lr
c0d00a64:	20001bb8 	.word	0x20001bb8

c0d00a68 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00a68:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a6a:	af03      	add	r7, sp, #12
c0d00a6c:	b083      	sub	sp, #12
c0d00a6e:	9202      	str	r2, [sp, #8]
c0d00a70:	460c      	mov	r4, r1
c0d00a72:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00a74:	4d4a      	ldr	r5, [pc, #296]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
c0d00a76:	42ac      	cmp	r4, r5
c0d00a78:	d00f      	beq.n	c0d00a9a <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00a7a:	4e49      	ldr	r6, [pc, #292]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
c0d00a7c:	2540      	movs	r5, #64	; 0x40
c0d00a7e:	4630      	mov	r0, r6
c0d00a80:	4629      	mov	r1, r5
c0d00a82:	f002 fae3 	bl	c0d0304c <__aeabi_memclr>
c0d00a86:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00a88:	2840      	cmp	r0, #64	; 0x40
c0d00a8a:	4602      	mov	r2, r0
c0d00a8c:	d300      	bcc.n	c0d00a90 <io_usb_hid_receive+0x28>
c0d00a8e:	462a      	mov	r2, r5
c0d00a90:	4630      	mov	r0, r6
c0d00a92:	4621      	mov	r1, r4
c0d00a94:	f000 f89e 	bl	c0d00bd4 <os_memmove>
c0d00a98:	4d41      	ldr	r5, [pc, #260]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00a9a:	78a8      	ldrb	r0, [r5, #2]
c0d00a9c:	2805      	cmp	r0, #5
c0d00a9e:	d900      	bls.n	c0d00aa2 <io_usb_hid_receive+0x3a>
c0d00aa0:	e076      	b.n	c0d00b90 <io_usb_hid_receive+0x128>
c0d00aa2:	46c0      	nop			; (mov r8, r8)
c0d00aa4:	4478      	add	r0, pc
c0d00aa6:	7900      	ldrb	r0, [r0, #4]
c0d00aa8:	0040      	lsls	r0, r0, #1
c0d00aaa:	4487      	add	pc, r0
c0d00aac:	71130c02 	.word	0x71130c02
c0d00ab0:	1f71      	.short	0x1f71
c0d00ab2:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00ab4:	71ae      	strb	r6, [r5, #6]
c0d00ab6:	716e      	strb	r6, [r5, #5]
c0d00ab8:	712e      	strb	r6, [r5, #4]
c0d00aba:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00abc:	2140      	movs	r1, #64	; 0x40
c0d00abe:	4628      	mov	r0, r5
c0d00ac0:	9a01      	ldr	r2, [sp, #4]
c0d00ac2:	4790      	blx	r2
c0d00ac4:	e00b      	b.n	c0d00ade <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00ac6:	1ce8      	adds	r0, r5, #3
c0d00ac8:	2104      	movs	r1, #4
c0d00aca:	f000 ff73 	bl	c0d019b4 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ace:	2140      	movs	r1, #64	; 0x40
c0d00ad0:	4628      	mov	r0, r5
c0d00ad2:	e001      	b.n	c0d00ad8 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00ad4:	4832      	ldr	r0, [pc, #200]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
c0d00ad6:	2140      	movs	r1, #64	; 0x40
c0d00ad8:	9a01      	ldr	r2, [sp, #4]
c0d00ada:	4790      	blx	r2
c0d00adc:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00ade:	4831      	ldr	r0, [pc, #196]	; (c0d00ba4 <io_usb_hid_receive+0x13c>)
c0d00ae0:	2100      	movs	r1, #0
c0d00ae2:	6001      	str	r1, [r0, #0]
c0d00ae4:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00ae6:	b2c0      	uxtb	r0, r0
c0d00ae8:	b003      	add	sp, #12
c0d00aea:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00aec:	78e8      	ldrb	r0, [r5, #3]
c0d00aee:	4c2d      	ldr	r4, [pc, #180]	; (c0d00ba4 <io_usb_hid_receive+0x13c>)
c0d00af0:	6821      	ldr	r1, [r4, #0]
c0d00af2:	0a09      	lsrs	r1, r1, #8
c0d00af4:	2600      	movs	r6, #0
c0d00af6:	4288      	cmp	r0, r1
c0d00af8:	d1f1      	bne.n	c0d00ade <io_usb_hid_receive+0x76>
c0d00afa:	7928      	ldrb	r0, [r5, #4]
c0d00afc:	6821      	ldr	r1, [r4, #0]
c0d00afe:	b2c9      	uxtb	r1, r1
c0d00b00:	4288      	cmp	r0, r1
c0d00b02:	d1ec      	bne.n	c0d00ade <io_usb_hid_receive+0x76>
c0d00b04:	4b28      	ldr	r3, [pc, #160]	; (c0d00ba8 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00b06:	9802      	ldr	r0, [sp, #8]
c0d00b08:	18c0      	adds	r0, r0, r3
c0d00b0a:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00b0c:	6820      	ldr	r0, [r4, #0]
c0d00b0e:	2800      	cmp	r0, #0
c0d00b10:	d00e      	beq.n	c0d00b30 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d00b12:	4629      	mov	r1, r5
c0d00b14:	4019      	ands	r1, r3
c0d00b16:	4825      	ldr	r0, [pc, #148]	; (c0d00bac <io_usb_hid_receive+0x144>)
c0d00b18:	6802      	ldr	r2, [r0, #0]
c0d00b1a:	4291      	cmp	r1, r2
c0d00b1c:	461e      	mov	r6, r3
c0d00b1e:	d900      	bls.n	c0d00b22 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d00b20:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d00b22:	462a      	mov	r2, r5
c0d00b24:	4032      	ands	r2, r6
c0d00b26:	4822      	ldr	r0, [pc, #136]	; (c0d00bb0 <io_usb_hid_receive+0x148>)
c0d00b28:	6800      	ldr	r0, [r0, #0]
c0d00b2a:	491d      	ldr	r1, [pc, #116]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
c0d00b2c:	1d49      	adds	r1, r1, #5
c0d00b2e:	e021      	b.n	c0d00b74 <io_usb_hid_receive+0x10c>
c0d00b30:	9301      	str	r3, [sp, #4]
c0d00b32:	491b      	ldr	r1, [pc, #108]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00b34:	7988      	ldrb	r0, [r1, #6]
c0d00b36:	7949      	ldrb	r1, [r1, #5]
c0d00b38:	0209      	lsls	r1, r1, #8
c0d00b3a:	4301      	orrs	r1, r0
c0d00b3c:	481d      	ldr	r0, [pc, #116]	; (c0d00bb4 <io_usb_hid_receive+0x14c>)
c0d00b3e:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d00b40:	6801      	ldr	r1, [r0, #0]
c0d00b42:	2241      	movs	r2, #65	; 0x41
c0d00b44:	0092      	lsls	r2, r2, #2
c0d00b46:	4291      	cmp	r1, r2
c0d00b48:	d8c9      	bhi.n	c0d00ade <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00b4a:	6801      	ldr	r1, [r0, #0]
c0d00b4c:	4817      	ldr	r0, [pc, #92]	; (c0d00bac <io_usb_hid_receive+0x144>)
c0d00b4e:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00b50:	4917      	ldr	r1, [pc, #92]	; (c0d00bb0 <io_usb_hid_receive+0x148>)
c0d00b52:	4a19      	ldr	r2, [pc, #100]	; (c0d00bb8 <io_usb_hid_receive+0x150>)
c0d00b54:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00b56:	4919      	ldr	r1, [pc, #100]	; (c0d00bbc <io_usb_hid_receive+0x154>)
c0d00b58:	9a02      	ldr	r2, [sp, #8]
c0d00b5a:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00b5c:	4629      	mov	r1, r5
c0d00b5e:	9e01      	ldr	r6, [sp, #4]
c0d00b60:	4031      	ands	r1, r6
c0d00b62:	6802      	ldr	r2, [r0, #0]
c0d00b64:	4291      	cmp	r1, r2
c0d00b66:	d900      	bls.n	c0d00b6a <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00b68:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00b6a:	462a      	mov	r2, r5
c0d00b6c:	4032      	ands	r2, r6
c0d00b6e:	480c      	ldr	r0, [pc, #48]	; (c0d00ba0 <io_usb_hid_receive+0x138>)
c0d00b70:	1dc1      	adds	r1, r0, #7
c0d00b72:	4811      	ldr	r0, [pc, #68]	; (c0d00bb8 <io_usb_hid_receive+0x150>)
c0d00b74:	f000 f82e 	bl	c0d00bd4 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00b78:	4035      	ands	r5, r6
c0d00b7a:	480d      	ldr	r0, [pc, #52]	; (c0d00bb0 <io_usb_hid_receive+0x148>)
c0d00b7c:	6801      	ldr	r1, [r0, #0]
c0d00b7e:	1949      	adds	r1, r1, r5
c0d00b80:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00b82:	480a      	ldr	r0, [pc, #40]	; (c0d00bac <io_usb_hid_receive+0x144>)
c0d00b84:	6801      	ldr	r1, [r0, #0]
c0d00b86:	1b49      	subs	r1, r1, r5
c0d00b88:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00b8a:	6820      	ldr	r0, [r4, #0]
c0d00b8c:	1c40      	adds	r0, r0, #1
c0d00b8e:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00b90:	4806      	ldr	r0, [pc, #24]	; (c0d00bac <io_usb_hid_receive+0x144>)
c0d00b92:	6801      	ldr	r1, [r0, #0]
c0d00b94:	2001      	movs	r0, #1
c0d00b96:	2602      	movs	r6, #2
c0d00b98:	2900      	cmp	r1, #0
c0d00b9a:	d1a4      	bne.n	c0d00ae6 <io_usb_hid_receive+0x7e>
c0d00b9c:	e79f      	b.n	c0d00ade <io_usb_hid_receive+0x76>
c0d00b9e:	46c0      	nop			; (mov r8, r8)
c0d00ba0:	20001bbc 	.word	0x20001bbc
c0d00ba4:	20001bfc 	.word	0x20001bfc
c0d00ba8:	0000ffff 	.word	0x0000ffff
c0d00bac:	20001c04 	.word	0x20001c04
c0d00bb0:	20001d0c 	.word	0x20001d0c
c0d00bb4:	20001c00 	.word	0x20001c00
c0d00bb8:	20001c08 	.word	0x20001c08
c0d00bbc:	0001fff9 	.word	0x0001fff9

c0d00bc0 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00bc0:	b580      	push	{r7, lr}
c0d00bc2:	af00      	add	r7, sp, #0
c0d00bc4:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00bc6:	2a00      	cmp	r2, #0
c0d00bc8:	d003      	beq.n	c0d00bd2 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00bca:	4611      	mov	r1, r2
c0d00bcc:	461a      	mov	r2, r3
c0d00bce:	f002 fa47 	bl	c0d03060 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00bd2:	bd80      	pop	{r7, pc}

c0d00bd4 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00bd4:	b5b0      	push	{r4, r5, r7, lr}
c0d00bd6:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00bd8:	4288      	cmp	r0, r1
c0d00bda:	d90d      	bls.n	c0d00bf8 <os_memmove+0x24>
    while(length--) {
c0d00bdc:	2a00      	cmp	r2, #0
c0d00bde:	d014      	beq.n	c0d00c0a <os_memmove+0x36>
c0d00be0:	1e49      	subs	r1, r1, #1
c0d00be2:	4252      	negs	r2, r2
c0d00be4:	1e40      	subs	r0, r0, #1
c0d00be6:	2300      	movs	r3, #0
c0d00be8:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00bea:	461c      	mov	r4, r3
c0d00bec:	4354      	muls	r4, r2
c0d00bee:	5d0d      	ldrb	r5, [r1, r4]
c0d00bf0:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00bf2:	1c52      	adds	r2, r2, #1
c0d00bf4:	d1f9      	bne.n	c0d00bea <os_memmove+0x16>
c0d00bf6:	e008      	b.n	c0d00c0a <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00bf8:	2a00      	cmp	r2, #0
c0d00bfa:	d006      	beq.n	c0d00c0a <os_memmove+0x36>
c0d00bfc:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00bfe:	b29c      	uxth	r4, r3
c0d00c00:	5d0d      	ldrb	r5, [r1, r4]
c0d00c02:	5505      	strb	r5, [r0, r4]
      l++;
c0d00c04:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00c06:	1e52      	subs	r2, r2, #1
c0d00c08:	d1f9      	bne.n	c0d00bfe <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00c0a:	bdb0      	pop	{r4, r5, r7, pc}

c0d00c0c <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00c0c:	4801      	ldr	r0, [pc, #4]	; (c0d00c14 <io_usb_hid_init+0x8>)
c0d00c0e:	2100      	movs	r1, #0
c0d00c10:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00c12:	4770      	bx	lr
c0d00c14:	20001bfc 	.word	0x20001bfc

c0d00c18 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00c18:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c1a:	af03      	add	r7, sp, #12
c0d00c1c:	b087      	sub	sp, #28
c0d00c1e:	9301      	str	r3, [sp, #4]
c0d00c20:	9203      	str	r2, [sp, #12]
c0d00c22:	460e      	mov	r6, r1
c0d00c24:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00c26:	2e00      	cmp	r6, #0
c0d00c28:	d042      	beq.n	c0d00cb0 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00c2a:	4d31      	ldr	r5, [pc, #196]	; (c0d00cf0 <io_usb_hid_exchange+0xd8>)
c0d00c2c:	2000      	movs	r0, #0
c0d00c2e:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00c30:	4930      	ldr	r1, [pc, #192]	; (c0d00cf4 <io_usb_hid_exchange+0xdc>)
c0d00c32:	4831      	ldr	r0, [pc, #196]	; (c0d00cf8 <io_usb_hid_exchange+0xe0>)
c0d00c34:	6008      	str	r0, [r1, #0]
c0d00c36:	4c31      	ldr	r4, [pc, #196]	; (c0d00cfc <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00c38:	1d60      	adds	r0, r4, #5
c0d00c3a:	213b      	movs	r1, #59	; 0x3b
c0d00c3c:	9005      	str	r0, [sp, #20]
c0d00c3e:	9102      	str	r1, [sp, #8]
c0d00c40:	f002 fa04 	bl	c0d0304c <__aeabi_memclr>
c0d00c44:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00c46:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00c48:	6828      	ldr	r0, [r5, #0]
c0d00c4a:	0a00      	lsrs	r0, r0, #8
c0d00c4c:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00c4e:	6828      	ldr	r0, [r5, #0]
c0d00c50:	7120      	strb	r0, [r4, #4]
c0d00c52:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00c54:	6828      	ldr	r0, [r5, #0]
c0d00c56:	2800      	cmp	r0, #0
c0d00c58:	9106      	str	r1, [sp, #24]
c0d00c5a:	d009      	beq.n	c0d00c70 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00c5c:	293b      	cmp	r1, #59	; 0x3b
c0d00c5e:	460a      	mov	r2, r1
c0d00c60:	d300      	bcc.n	c0d00c64 <io_usb_hid_exchange+0x4c>
c0d00c62:	9a02      	ldr	r2, [sp, #8]
c0d00c64:	4823      	ldr	r0, [pc, #140]	; (c0d00cf4 <io_usb_hid_exchange+0xdc>)
c0d00c66:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00c68:	6819      	ldr	r1, [r3, #0]
c0d00c6a:	9805      	ldr	r0, [sp, #20]
c0d00c6c:	461e      	mov	r6, r3
c0d00c6e:	e00a      	b.n	c0d00c86 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00c70:	0a30      	lsrs	r0, r6, #8
c0d00c72:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00c74:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00c76:	2039      	movs	r0, #57	; 0x39
c0d00c78:	2939      	cmp	r1, #57	; 0x39
c0d00c7a:	460a      	mov	r2, r1
c0d00c7c:	d300      	bcc.n	c0d00c80 <io_usb_hid_exchange+0x68>
c0d00c7e:	4602      	mov	r2, r0
c0d00c80:	4e1c      	ldr	r6, [pc, #112]	; (c0d00cf4 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00c82:	6831      	ldr	r1, [r6, #0]
c0d00c84:	1de0      	adds	r0, r4, #7
c0d00c86:	9205      	str	r2, [sp, #20]
c0d00c88:	f7ff ffa4 	bl	c0d00bd4 <os_memmove>
c0d00c8c:	4d18      	ldr	r5, [pc, #96]	; (c0d00cf0 <io_usb_hid_exchange+0xd8>)
c0d00c8e:	6830      	ldr	r0, [r6, #0]
c0d00c90:	4631      	mov	r1, r6
c0d00c92:	9e05      	ldr	r6, [sp, #20]
c0d00c94:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00c96:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00c98:	6828      	ldr	r0, [r5, #0]
c0d00c9a:	1c40      	adds	r0, r0, #1
c0d00c9c:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00c9e:	2140      	movs	r1, #64	; 0x40
c0d00ca0:	4620      	mov	r0, r4
c0d00ca2:	9a04      	ldr	r2, [sp, #16]
c0d00ca4:	4790      	blx	r2
c0d00ca6:	9806      	ldr	r0, [sp, #24]
c0d00ca8:	1b86      	subs	r6, r0, r6
c0d00caa:	4815      	ldr	r0, [pc, #84]	; (c0d00d00 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00cac:	4206      	tst	r6, r0
c0d00cae:	d1c3      	bne.n	c0d00c38 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00cb0:	480f      	ldr	r0, [pc, #60]	; (c0d00cf0 <io_usb_hid_exchange+0xd8>)
c0d00cb2:	2400      	movs	r4, #0
c0d00cb4:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00cb6:	2080      	movs	r0, #128	; 0x80
c0d00cb8:	9901      	ldr	r1, [sp, #4]
c0d00cba:	4201      	tst	r1, r0
c0d00cbc:	d001      	beq.n	c0d00cc2 <io_usb_hid_exchange+0xaa>
    reset();
c0d00cbe:	f000 fe3f 	bl	c0d01940 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00cc2:	9801      	ldr	r0, [sp, #4]
c0d00cc4:	0680      	lsls	r0, r0, #26
c0d00cc6:	d40f      	bmi.n	c0d00ce8 <io_usb_hid_exchange+0xd0>
c0d00cc8:	4c0c      	ldr	r4, [pc, #48]	; (c0d00cfc <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00cca:	2140      	movs	r1, #64	; 0x40
c0d00ccc:	4620      	mov	r0, r4
c0d00cce:	9a03      	ldr	r2, [sp, #12]
c0d00cd0:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00cd2:	b2c2      	uxtb	r2, r0
c0d00cd4:	2a40      	cmp	r2, #64	; 0x40
c0d00cd6:	d8f8      	bhi.n	c0d00cca <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00cd8:	9804      	ldr	r0, [sp, #16]
c0d00cda:	4621      	mov	r1, r4
c0d00cdc:	f7ff fec4 	bl	c0d00a68 <io_usb_hid_receive>
c0d00ce0:	2802      	cmp	r0, #2
c0d00ce2:	d1f2      	bne.n	c0d00cca <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00ce4:	4807      	ldr	r0, [pc, #28]	; (c0d00d04 <io_usb_hid_exchange+0xec>)
c0d00ce6:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00ce8:	b2a0      	uxth	r0, r4
c0d00cea:	b007      	add	sp, #28
c0d00cec:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00cee:	46c0      	nop			; (mov r8, r8)
c0d00cf0:	20001bfc 	.word	0x20001bfc
c0d00cf4:	20001d0c 	.word	0x20001d0c
c0d00cf8:	20001c08 	.word	0x20001c08
c0d00cfc:	20001bbc 	.word	0x20001bbc
c0d00d00:	0000ffff 	.word	0x0000ffff
c0d00d04:	20001c00 	.word	0x20001c00

c0d00d08 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00d08:	b580      	push	{r7, lr}
c0d00d0a:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00d0c:	f000 ffbc 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d00d10:	2800      	cmp	r0, #0
c0d00d12:	d10b      	bne.n	c0d00d2c <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00d14:	4806      	ldr	r0, [pc, #24]	; (c0d00d30 <io_seproxyhal_general_status+0x28>)
c0d00d16:	2160      	movs	r1, #96	; 0x60
c0d00d18:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00d1a:	2100      	movs	r1, #0
c0d00d1c:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00d1e:	2202      	movs	r2, #2
c0d00d20:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00d22:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00d24:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00d26:	2105      	movs	r1, #5
c0d00d28:	f000 ff90 	bl	c0d01c4c <io_seproxyhal_spi_send>
}
c0d00d2c:	bd80      	pop	{r7, pc}
c0d00d2e:	46c0      	nop			; (mov r8, r8)
c0d00d30:	20001a18 	.word	0x20001a18

c0d00d34 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00d34:	b5d0      	push	{r4, r6, r7, lr}
c0d00d36:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00d38:	4815      	ldr	r0, [pc, #84]	; (c0d00d90 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00d3a:	78c0      	ldrb	r0, [r0, #3]
c0d00d3c:	1e40      	subs	r0, r0, #1
c0d00d3e:	2807      	cmp	r0, #7
c0d00d40:	d824      	bhi.n	c0d00d8c <io_seproxyhal_handle_usb_event+0x58>
c0d00d42:	46c0      	nop			; (mov r8, r8)
c0d00d44:	4478      	add	r0, pc
c0d00d46:	7900      	ldrb	r0, [r0, #4]
c0d00d48:	0040      	lsls	r0, r0, #1
c0d00d4a:	4487      	add	pc, r0
c0d00d4c:	141f1803 	.word	0x141f1803
c0d00d50:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00d54:	4c0f      	ldr	r4, [pc, #60]	; (c0d00d94 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d56:	2101      	movs	r1, #1
c0d00d58:	4620      	mov	r0, r4
c0d00d5a:	f001 fbd5 	bl	c0d02508 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00d5e:	4620      	mov	r0, r4
c0d00d60:	f001 fbba 	bl	c0d024d8 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00d64:	480c      	ldr	r0, [pc, #48]	; (c0d00d98 <io_seproxyhal_handle_usb_event+0x64>)
c0d00d66:	7800      	ldrb	r0, [r0, #0]
c0d00d68:	2801      	cmp	r0, #1
c0d00d6a:	d10f      	bne.n	c0d00d8c <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00d6c:	480b      	ldr	r0, [pc, #44]	; (c0d00d9c <io_seproxyhal_handle_usb_event+0x68>)
c0d00d6e:	6800      	ldr	r0, [r0, #0]
c0d00d70:	2110      	movs	r1, #16
c0d00d72:	f002 fa0d 	bl	c0d03190 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00d76:	4807      	ldr	r0, [pc, #28]	; (c0d00d94 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d78:	f001 fbc9 	bl	c0d0250e <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00d7c:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00d7e:	4805      	ldr	r0, [pc, #20]	; (c0d00d94 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d80:	f001 fbc9 	bl	c0d02516 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00d84:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00d86:	4803      	ldr	r0, [pc, #12]	; (c0d00d94 <io_seproxyhal_handle_usb_event+0x60>)
c0d00d88:	f001 fbc3 	bl	c0d02512 <USBD_LL_Resume>
      break;
  }
}
c0d00d8c:	bdd0      	pop	{r4, r6, r7, pc}
c0d00d8e:	46c0      	nop			; (mov r8, r8)
c0d00d90:	20001a18 	.word	0x20001a18
c0d00d94:	20001d34 	.word	0x20001d34
c0d00d98:	20001d10 	.word	0x20001d10
c0d00d9c:	20001bb8 	.word	0x20001bb8

c0d00da0 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00da0:	217f      	movs	r1, #127	; 0x7f
c0d00da2:	4001      	ands	r1, r0
c0d00da4:	4801      	ldr	r0, [pc, #4]	; (c0d00dac <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00da6:	5c40      	ldrb	r0, [r0, r1]
c0d00da8:	4770      	bx	lr
c0d00daa:	46c0      	nop			; (mov r8, r8)
c0d00dac:	20001d11 	.word	0x20001d11

c0d00db0 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00db0:	b580      	push	{r7, lr}
c0d00db2:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00db4:	480f      	ldr	r0, [pc, #60]	; (c0d00df4 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00db6:	7901      	ldrb	r1, [r0, #4]
c0d00db8:	2904      	cmp	r1, #4
c0d00dba:	d008      	beq.n	c0d00dce <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00dbc:	2902      	cmp	r1, #2
c0d00dbe:	d011      	beq.n	c0d00de4 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00dc0:	2901      	cmp	r1, #1
c0d00dc2:	d10e      	bne.n	c0d00de2 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00dc4:	1d81      	adds	r1, r0, #6
c0d00dc6:	480d      	ldr	r0, [pc, #52]	; (c0d00dfc <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00dc8:	f001 faaa 	bl	c0d02320 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00dcc:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00dce:	78c2      	ldrb	r2, [r0, #3]
c0d00dd0:	217f      	movs	r1, #127	; 0x7f
c0d00dd2:	4011      	ands	r1, r2
c0d00dd4:	7942      	ldrb	r2, [r0, #5]
c0d00dd6:	4b08      	ldr	r3, [pc, #32]	; (c0d00df8 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00dd8:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00dda:	1d82      	adds	r2, r0, #6
c0d00ddc:	4807      	ldr	r0, [pc, #28]	; (c0d00dfc <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00dde:	f001 fad1 	bl	c0d02384 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00de2:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00de4:	78c2      	ldrb	r2, [r0, #3]
c0d00de6:	217f      	movs	r1, #127	; 0x7f
c0d00de8:	4011      	ands	r1, r2
c0d00dea:	1d82      	adds	r2, r0, #6
c0d00dec:	4803      	ldr	r0, [pc, #12]	; (c0d00dfc <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00dee:	f001 fb0f 	bl	c0d02410 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00df2:	bd80      	pop	{r7, pc}
c0d00df4:	20001a18 	.word	0x20001a18
c0d00df8:	20001d11 	.word	0x20001d11
c0d00dfc:	20001d34 	.word	0x20001d34

c0d00e00 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00e00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e02:	af03      	add	r7, sp, #12
c0d00e04:	b083      	sub	sp, #12
c0d00e06:	9201      	str	r2, [sp, #4]
c0d00e08:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00e0a:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00e0c:	2b00      	cmp	r3, #0
c0d00e0e:	d100      	bne.n	c0d00e12 <io_usb_send_ep+0x12>
c0d00e10:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00e12:	9801      	ldr	r0, [sp, #4]
c0d00e14:	28ff      	cmp	r0, #255	; 0xff
c0d00e16:	d843      	bhi.n	c0d00ea0 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00e18:	4e25      	ldr	r6, [pc, #148]	; (c0d00eb0 <io_usb_send_ep+0xb0>)
c0d00e1a:	2050      	movs	r0, #80	; 0x50
c0d00e1c:	7030      	strb	r0, [r6, #0]
c0d00e1e:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00e20:	1ce0      	adds	r0, r4, #3
c0d00e22:	9100      	str	r1, [sp, #0]
c0d00e24:	0a01      	lsrs	r1, r0, #8
c0d00e26:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00e28:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00e2a:	2080      	movs	r0, #128	; 0x80
c0d00e2c:	4302      	orrs	r2, r0
c0d00e2e:	9202      	str	r2, [sp, #8]
c0d00e30:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00e32:	2020      	movs	r0, #32
c0d00e34:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00e36:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00e38:	2106      	movs	r1, #6
c0d00e3a:	4630      	mov	r0, r6
c0d00e3c:	f000 ff06 	bl	c0d01c4c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00e40:	9800      	ldr	r0, [sp, #0]
c0d00e42:	4621      	mov	r1, r4
c0d00e44:	f000 ff02 	bl	c0d01c4c <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00e48:	2d00      	cmp	r5, #0
c0d00e4a:	d10d      	bne.n	c0d00e68 <io_usb_send_ep+0x68>
c0d00e4c:	e028      	b.n	c0d00ea0 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00e4e:	2d00      	cmp	r5, #0
c0d00e50:	d002      	beq.n	c0d00e58 <io_usb_send_ep+0x58>
c0d00e52:	1e6c      	subs	r4, r5, #1
c0d00e54:	2d01      	cmp	r5, #1
c0d00e56:	d025      	beq.n	c0d00ea4 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00e58:	2915      	cmp	r1, #21
c0d00e5a:	d102      	bne.n	c0d00e62 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00e5c:	79b0      	ldrb	r0, [r6, #6]
c0d00e5e:	0700      	lsls	r0, r0, #28
c0d00e60:	d520      	bpl.n	c0d00ea4 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00e62:	f000 f829 	bl	c0d00eb8 <io_seproxyhal_handle_event>
c0d00e66:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00e68:	f000 ff0e 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d00e6c:	2800      	cmp	r0, #0
c0d00e6e:	d101      	bne.n	c0d00e74 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00e70:	f7ff ff4a 	bl	c0d00d08 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00e74:	2180      	movs	r1, #128	; 0x80
c0d00e76:	2400      	movs	r4, #0
c0d00e78:	4630      	mov	r0, r6
c0d00e7a:	4622      	mov	r2, r4
c0d00e7c:	f000 ff20 	bl	c0d01cc0 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00e80:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00e82:	2806      	cmp	r0, #6
c0d00e84:	d1e3      	bne.n	c0d00e4e <io_usb_send_ep+0x4e>
c0d00e86:	2910      	cmp	r1, #16
c0d00e88:	d1e1      	bne.n	c0d00e4e <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00e8a:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00e8c:	9a02      	ldr	r2, [sp, #8]
c0d00e8e:	4290      	cmp	r0, r2
c0d00e90:	d1dd      	bne.n	c0d00e4e <io_usb_send_ep+0x4e>
c0d00e92:	7930      	ldrb	r0, [r6, #4]
c0d00e94:	2802      	cmp	r0, #2
c0d00e96:	d1da      	bne.n	c0d00e4e <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00e98:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00e9a:	9a01      	ldr	r2, [sp, #4]
c0d00e9c:	4290      	cmp	r0, r2
c0d00e9e:	d1d6      	bne.n	c0d00e4e <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00ea0:	b003      	add	sp, #12
c0d00ea2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ea4:	4803      	ldr	r0, [pc, #12]	; (c0d00eb4 <io_usb_send_ep+0xb4>)
c0d00ea6:	6800      	ldr	r0, [r0, #0]
c0d00ea8:	2110      	movs	r1, #16
c0d00eaa:	f002 f971 	bl	c0d03190 <longjmp>
c0d00eae:	46c0      	nop			; (mov r8, r8)
c0d00eb0:	20001a18 	.word	0x20001a18
c0d00eb4:	20001bb8 	.word	0x20001bb8

c0d00eb8 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00eb8:	b580      	push	{r7, lr}
c0d00eba:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00ebc:	480d      	ldr	r0, [pc, #52]	; (c0d00ef4 <io_seproxyhal_handle_event+0x3c>)
c0d00ebe:	7882      	ldrb	r2, [r0, #2]
c0d00ec0:	7841      	ldrb	r1, [r0, #1]
c0d00ec2:	0209      	lsls	r1, r1, #8
c0d00ec4:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00ec6:	7800      	ldrb	r0, [r0, #0]
c0d00ec8:	2810      	cmp	r0, #16
c0d00eca:	d008      	beq.n	c0d00ede <io_seproxyhal_handle_event+0x26>
c0d00ecc:	280f      	cmp	r0, #15
c0d00ece:	d10d      	bne.n	c0d00eec <io_seproxyhal_handle_event+0x34>
c0d00ed0:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d00ed2:	2904      	cmp	r1, #4
c0d00ed4:	d10d      	bne.n	c0d00ef2 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00ed6:	f7ff ff2d 	bl	c0d00d34 <io_seproxyhal_handle_usb_event>
c0d00eda:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00edc:	bd80      	pop	{r7, pc}
c0d00ede:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d00ee0:	2906      	cmp	r1, #6
c0d00ee2:	d306      	bcc.n	c0d00ef2 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00ee4:	f7ff ff64 	bl	c0d00db0 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00ee8:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00eea:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d00eec:	2002      	movs	r0, #2
c0d00eee:	f7ff faf5 	bl	c0d004dc <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d00ef2:	bd80      	pop	{r7, pc}
c0d00ef4:	20001a18 	.word	0x20001a18

c0d00ef8 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00ef8:	b580      	push	{r7, lr}
c0d00efa:	af00      	add	r7, sp, #0
c0d00efc:	460a      	mov	r2, r1
c0d00efe:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00f00:	2082      	movs	r0, #130	; 0x82
c0d00f02:	2314      	movs	r3, #20
c0d00f04:	f7ff ff7c 	bl	c0d00e00 <io_usb_send_ep>
}
c0d00f08:	bd80      	pop	{r7, pc}
	...

c0d00f0c <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d00f0c:	b5d0      	push	{r4, r6, r7, lr}
c0d00f0e:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00f10:	2007      	movs	r0, #7
c0d00f12:	f000 fcf7 	bl	c0d01904 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d00f16:	480a      	ldr	r0, [pc, #40]	; (c0d00f40 <io_seproxyhal_init+0x34>)
c0d00f18:	2400      	movs	r4, #0
c0d00f1a:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d00f1c:	4809      	ldr	r0, [pc, #36]	; (c0d00f44 <io_seproxyhal_init+0x38>)
c0d00f1e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d00f20:	4809      	ldr	r0, [pc, #36]	; (c0d00f48 <io_seproxyhal_init+0x3c>)
c0d00f22:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d00f24:	4809      	ldr	r0, [pc, #36]	; (c0d00f4c <io_seproxyhal_init+0x40>)
c0d00f26:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d00f28:	4809      	ldr	r0, [pc, #36]	; (c0d00f50 <io_seproxyhal_init+0x44>)
c0d00f2a:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00f2c:	f7ff fe6e 	bl	c0d00c0c <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00f30:	4808      	ldr	r0, [pc, #32]	; (c0d00f54 <io_seproxyhal_init+0x48>)
c0d00f32:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d00f34:	4808      	ldr	r0, [pc, #32]	; (c0d00f58 <io_seproxyhal_init+0x4c>)
c0d00f36:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d00f38:	4808      	ldr	r0, [pc, #32]	; (c0d00f5c <io_seproxyhal_init+0x50>)
c0d00f3a:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00f3c:	bdd0      	pop	{r4, r6, r7, pc}
c0d00f3e:	46c0      	nop			; (mov r8, r8)
c0d00f40:	20001d18 	.word	0x20001d18
c0d00f44:	20001d1a 	.word	0x20001d1a
c0d00f48:	20001d1c 	.word	0x20001d1c
c0d00f4c:	20001d1e 	.word	0x20001d1e
c0d00f50:	20001d10 	.word	0x20001d10
c0d00f54:	20001d20 	.word	0x20001d20
c0d00f58:	20001d24 	.word	0x20001d24
c0d00f5c:	20001d28 	.word	0x20001d28

c0d00f60 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00f60:	4801      	ldr	r0, [pc, #4]	; (c0d00f68 <io_seproxyhal_init_ux+0x8>)
c0d00f62:	2100      	movs	r1, #0
c0d00f64:	6001      	str	r1, [r0, #0]

}
c0d00f66:	4770      	bx	lr
c0d00f68:	20001d20 	.word	0x20001d20

c0d00f6c <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00f6c:	b5b0      	push	{r4, r5, r7, lr}
c0d00f6e:	af02      	add	r7, sp, #8
c0d00f70:	460d      	mov	r5, r1
c0d00f72:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d00f74:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d00f76:	2800      	cmp	r0, #0
c0d00f78:	d00c      	beq.n	c0d00f94 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d00f7a:	f000 fcab 	bl	c0d018d4 <pic>
c0d00f7e:	4601      	mov	r1, r0
c0d00f80:	4620      	mov	r0, r4
c0d00f82:	4788      	blx	r1
c0d00f84:	f000 fca6 	bl	c0d018d4 <pic>
c0d00f88:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d00f8a:	2800      	cmp	r0, #0
c0d00f8c:	d010      	beq.n	c0d00fb0 <io_seproxyhal_touch_out+0x44>
c0d00f8e:	2801      	cmp	r0, #1
c0d00f90:	d000      	beq.n	c0d00f94 <io_seproxyhal_touch_out+0x28>
c0d00f92:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00f94:	2d00      	cmp	r5, #0
c0d00f96:	d007      	beq.n	c0d00fa8 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d00f98:	4620      	mov	r0, r4
c0d00f9a:	47a8      	blx	r5
c0d00f9c:	2100      	movs	r1, #0
    if (!el) {
c0d00f9e:	2800      	cmp	r0, #0
c0d00fa0:	d006      	beq.n	c0d00fb0 <io_seproxyhal_touch_out+0x44>
c0d00fa2:	2801      	cmp	r0, #1
c0d00fa4:	d000      	beq.n	c0d00fa8 <io_seproxyhal_touch_out+0x3c>
c0d00fa6:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d00fa8:	4620      	mov	r0, r4
c0d00faa:	f7ff fa91 	bl	c0d004d0 <io_seproxyhal_display>
c0d00fae:	2101      	movs	r1, #1
  return 1;
}
c0d00fb0:	4608      	mov	r0, r1
c0d00fb2:	bdb0      	pop	{r4, r5, r7, pc}

c0d00fb4 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00fb4:	b5b0      	push	{r4, r5, r7, lr}
c0d00fb6:	af02      	add	r7, sp, #8
c0d00fb8:	b08e      	sub	sp, #56	; 0x38
c0d00fba:	460c      	mov	r4, r1
c0d00fbc:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d00fbe:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d00fc0:	2800      	cmp	r0, #0
c0d00fc2:	d00c      	beq.n	c0d00fde <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d00fc4:	f000 fc86 	bl	c0d018d4 <pic>
c0d00fc8:	4601      	mov	r1, r0
c0d00fca:	4628      	mov	r0, r5
c0d00fcc:	4788      	blx	r1
c0d00fce:	f000 fc81 	bl	c0d018d4 <pic>
c0d00fd2:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00fd4:	2800      	cmp	r0, #0
c0d00fd6:	d016      	beq.n	c0d01006 <io_seproxyhal_touch_over+0x52>
c0d00fd8:	2801      	cmp	r0, #1
c0d00fda:	d000      	beq.n	c0d00fde <io_seproxyhal_touch_over+0x2a>
c0d00fdc:	4605      	mov	r5, r0
c0d00fde:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d00fe0:	2238      	movs	r2, #56	; 0x38
c0d00fe2:	4629      	mov	r1, r5
c0d00fe4:	f7ff fdf6 	bl	c0d00bd4 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d00fe8:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d00fea:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d00fec:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00fee:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d00ff0:	2c00      	cmp	r4, #0
c0d00ff2:	d004      	beq.n	c0d00ffe <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d00ff4:	4628      	mov	r0, r5
c0d00ff6:	47a0      	blx	r4
c0d00ff8:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d00ffa:	2800      	cmp	r0, #0
c0d00ffc:	d003      	beq.n	c0d01006 <io_seproxyhal_touch_over+0x52>
c0d00ffe:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01000:	f7ff fa66 	bl	c0d004d0 <io_seproxyhal_display>
c0d01004:	2101      	movs	r1, #1
  return 1;
}
c0d01006:	4608      	mov	r0, r1
c0d01008:	b00e      	add	sp, #56	; 0x38
c0d0100a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0100c <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0100c:	b5b0      	push	{r4, r5, r7, lr}
c0d0100e:	af02      	add	r7, sp, #8
c0d01010:	460d      	mov	r5, r1
c0d01012:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01014:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01016:	2800      	cmp	r0, #0
c0d01018:	d00c      	beq.n	c0d01034 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0101a:	f000 fc5b 	bl	c0d018d4 <pic>
c0d0101e:	4601      	mov	r1, r0
c0d01020:	4620      	mov	r0, r4
c0d01022:	4788      	blx	r1
c0d01024:	f000 fc56 	bl	c0d018d4 <pic>
c0d01028:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0102a:	2800      	cmp	r0, #0
c0d0102c:	d010      	beq.n	c0d01050 <io_seproxyhal_touch_tap+0x44>
c0d0102e:	2801      	cmp	r0, #1
c0d01030:	d000      	beq.n	c0d01034 <io_seproxyhal_touch_tap+0x28>
c0d01032:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01034:	2d00      	cmp	r5, #0
c0d01036:	d007      	beq.n	c0d01048 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01038:	4620      	mov	r0, r4
c0d0103a:	47a8      	blx	r5
c0d0103c:	2100      	movs	r1, #0
    if (!el) {
c0d0103e:	2800      	cmp	r0, #0
c0d01040:	d006      	beq.n	c0d01050 <io_seproxyhal_touch_tap+0x44>
c0d01042:	2801      	cmp	r0, #1
c0d01044:	d000      	beq.n	c0d01048 <io_seproxyhal_touch_tap+0x3c>
c0d01046:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01048:	4620      	mov	r0, r4
c0d0104a:	f7ff fa41 	bl	c0d004d0 <io_seproxyhal_display>
c0d0104e:	2101      	movs	r1, #1
  return 1;
}
c0d01050:	4608      	mov	r0, r1
c0d01052:	bdb0      	pop	{r4, r5, r7, pc}

c0d01054 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01054:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01056:	af03      	add	r7, sp, #12
c0d01058:	b087      	sub	sp, #28
c0d0105a:	9302      	str	r3, [sp, #8]
c0d0105c:	9203      	str	r2, [sp, #12]
c0d0105e:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01060:	2900      	cmp	r1, #0
c0d01062:	d076      	beq.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
c0d01064:	9004      	str	r0, [sp, #16]
c0d01066:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01068:	9001      	str	r0, [sp, #4]
c0d0106a:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d0106c:	9000      	str	r0, [sp, #0]
c0d0106e:	2600      	movs	r6, #0
c0d01070:	9606      	str	r6, [sp, #24]
c0d01072:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01074:	f000 fe08 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d01078:	2800      	cmp	r0, #0
c0d0107a:	d155      	bne.n	c0d01128 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d0107c:	2038      	movs	r0, #56	; 0x38
c0d0107e:	4370      	muls	r0, r6
c0d01080:	9d04      	ldr	r5, [sp, #16]
c0d01082:	182e      	adds	r6, r5, r0
c0d01084:	4b36      	ldr	r3, [pc, #216]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01086:	681a      	ldr	r2, [r3, #0]
c0d01088:	2101      	movs	r1, #1
c0d0108a:	4296      	cmp	r6, r2
c0d0108c:	d000      	beq.n	c0d01090 <io_seproxyhal_touch_element_callback+0x3c>
c0d0108e:	9906      	ldr	r1, [sp, #24]
c0d01090:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01092:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01094:	2800      	cmp	r0, #0
c0d01096:	da41      	bge.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
c0d01098:	2020      	movs	r0, #32
c0d0109a:	5c35      	ldrb	r5, [r6, r0]
c0d0109c:	2102      	movs	r1, #2
c0d0109e:	5e71      	ldrsh	r1, [r6, r1]
c0d010a0:	1b4a      	subs	r2, r1, r5
c0d010a2:	9803      	ldr	r0, [sp, #12]
c0d010a4:	4282      	cmp	r2, r0
c0d010a6:	dc39      	bgt.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
c0d010a8:	1869      	adds	r1, r5, r1
c0d010aa:	88f2      	ldrh	r2, [r6, #6]
c0d010ac:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d010ae:	9803      	ldr	r0, [sp, #12]
c0d010b0:	4288      	cmp	r0, r1
c0d010b2:	da33      	bge.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
c0d010b4:	2104      	movs	r1, #4
c0d010b6:	5e70      	ldrsh	r0, [r6, r1]
c0d010b8:	1b42      	subs	r2, r0, r5
c0d010ba:	9902      	ldr	r1, [sp, #8]
c0d010bc:	428a      	cmp	r2, r1
c0d010be:	dc2d      	bgt.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
c0d010c0:	1940      	adds	r0, r0, r5
c0d010c2:	8931      	ldrh	r1, [r6, #8]
c0d010c4:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d010c6:	9902      	ldr	r1, [sp, #8]
c0d010c8:	4281      	cmp	r1, r0
c0d010ca:	da27      	bge.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d010cc:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d010ce:	4286      	cmp	r6, r0
c0d010d0:	d010      	beq.n	c0d010f4 <io_seproxyhal_touch_element_callback+0xa0>
c0d010d2:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d010d4:	2800      	cmp	r0, #0
c0d010d6:	d00d      	beq.n	c0d010f4 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d010d8:	9801      	ldr	r0, [sp, #4]
c0d010da:	2800      	cmp	r0, #0
c0d010dc:	d005      	beq.n	c0d010ea <io_seproxyhal_touch_element_callback+0x96>
c0d010de:	4630      	mov	r0, r6
c0d010e0:	9901      	ldr	r1, [sp, #4]
c0d010e2:	4788      	blx	r1
c0d010e4:	4b1e      	ldr	r3, [pc, #120]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d010e6:	2800      	cmp	r0, #0
c0d010e8:	d018      	beq.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d010ea:	6818      	ldr	r0, [r3, #0]
c0d010ec:	9901      	ldr	r1, [sp, #4]
c0d010ee:	f7ff ff3d 	bl	c0d00f6c <io_seproxyhal_touch_out>
c0d010f2:	e008      	b.n	c0d01106 <io_seproxyhal_touch_element_callback+0xb2>
c0d010f4:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d010f6:	2801      	cmp	r0, #1
c0d010f8:	d009      	beq.n	c0d0110e <io_seproxyhal_touch_element_callback+0xba>
c0d010fa:	2802      	cmp	r0, #2
c0d010fc:	d10e      	bne.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d010fe:	4630      	mov	r0, r6
c0d01100:	9901      	ldr	r1, [sp, #4]
c0d01102:	f7ff ff83 	bl	c0d0100c <io_seproxyhal_touch_tap>
c0d01106:	4b16      	ldr	r3, [pc, #88]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01108:	2800      	cmp	r0, #0
c0d0110a:	d007      	beq.n	c0d0111c <io_seproxyhal_touch_element_callback+0xc8>
c0d0110c:	e023      	b.n	c0d01156 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d0110e:	4630      	mov	r0, r6
c0d01110:	9901      	ldr	r1, [sp, #4]
c0d01112:	f7ff ff4f 	bl	c0d00fb4 <io_seproxyhal_touch_over>
c0d01116:	4b12      	ldr	r3, [pc, #72]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01118:	2800      	cmp	r0, #0
c0d0111a:	d11f      	bne.n	c0d0115c <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d0111c:	1c64      	adds	r4, r4, #1
c0d0111e:	b2e6      	uxtb	r6, r4
c0d01120:	9805      	ldr	r0, [sp, #20]
c0d01122:	4286      	cmp	r6, r0
c0d01124:	d3a6      	bcc.n	c0d01074 <io_seproxyhal_touch_element_callback+0x20>
c0d01126:	e000      	b.n	c0d0112a <io_seproxyhal_touch_element_callback+0xd6>
c0d01128:	4b0d      	ldr	r3, [pc, #52]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0112a:	9806      	ldr	r0, [sp, #24]
c0d0112c:	0600      	lsls	r0, r0, #24
c0d0112e:	d010      	beq.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
c0d01130:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01132:	2800      	cmp	r0, #0
c0d01134:	d00d      	beq.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01136:	f000 fda7 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d0113a:	4909      	ldr	r1, [pc, #36]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0113c:	2800      	cmp	r0, #0
c0d0113e:	d108      	bne.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01140:	6808      	ldr	r0, [r1, #0]
c0d01142:	9901      	ldr	r1, [sp, #4]
c0d01144:	f7ff ff12 	bl	c0d00f6c <io_seproxyhal_touch_out>
c0d01148:	4d05      	ldr	r5, [pc, #20]	; (c0d01160 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0114a:	2800      	cmp	r0, #0
c0d0114c:	d001      	beq.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d0114e:	2000      	movs	r0, #0
c0d01150:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d01152:	b007      	add	sp, #28
c0d01154:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01156:	2000      	movs	r0, #0
c0d01158:	6018      	str	r0, [r3, #0]
c0d0115a:	e7fa      	b.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d0115c:	601e      	str	r6, [r3, #0]
c0d0115e:	e7f8      	b.n	c0d01152 <io_seproxyhal_touch_element_callback+0xfe>
c0d01160:	20001d20 	.word	0x20001d20

c0d01164 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01164:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01166:	af03      	add	r7, sp, #12
c0d01168:	b08b      	sub	sp, #44	; 0x2c
c0d0116a:	460c      	mov	r4, r1
c0d0116c:	4601      	mov	r1, r0
c0d0116e:	ad04      	add	r5, sp, #16
c0d01170:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01172:	4628      	mov	r0, r5
c0d01174:	9203      	str	r2, [sp, #12]
c0d01176:	f7ff fd2d 	bl	c0d00bd4 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d0117a:	6821      	ldr	r1, [r4, #0]
c0d0117c:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d0117e:	6862      	ldr	r2, [r4, #4]
c0d01180:	9502      	str	r5, [sp, #8]
c0d01182:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01184:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01186:	4e1a      	ldr	r6, [pc, #104]	; (c0d011f0 <io_seproxyhal_display_icon+0x8c>)
c0d01188:	2365      	movs	r3, #101	; 0x65
c0d0118a:	4635      	mov	r5, r6
c0d0118c:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d0118e:	b292      	uxth	r2, r2
c0d01190:	4342      	muls	r2, r0
c0d01192:	b28b      	uxth	r3, r1
c0d01194:	4353      	muls	r3, r2
c0d01196:	08d9      	lsrs	r1, r3, #3
c0d01198:	1c4e      	adds	r6, r1, #1
c0d0119a:	2207      	movs	r2, #7
c0d0119c:	4213      	tst	r3, r2
c0d0119e:	d100      	bne.n	c0d011a2 <io_seproxyhal_display_icon+0x3e>
c0d011a0:	460e      	mov	r6, r1
c0d011a2:	4631      	mov	r1, r6
c0d011a4:	9101      	str	r1, [sp, #4]
c0d011a6:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d011a8:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d011aa:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d011ac:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d011ae:	0a01      	lsrs	r1, r0, #8
c0d011b0:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d011b2:	70a8      	strb	r0, [r5, #2]
c0d011b4:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d011b6:	4628      	mov	r0, r5
c0d011b8:	f000 fd48 	bl	c0d01c4c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d011bc:	9802      	ldr	r0, [sp, #8]
c0d011be:	9903      	ldr	r1, [sp, #12]
c0d011c0:	f000 fd44 	bl	c0d01c4c <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d011c4:	68a0      	ldr	r0, [r4, #8]
c0d011c6:	7028      	strb	r0, [r5, #0]
c0d011c8:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d011ca:	4628      	mov	r0, r5
c0d011cc:	f000 fd3e 	bl	c0d01c4c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d011d0:	68e0      	ldr	r0, [r4, #12]
c0d011d2:	f000 fb7f 	bl	c0d018d4 <pic>
c0d011d6:	b2b1      	uxth	r1, r6
c0d011d8:	f000 fd38 	bl	c0d01c4c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d011dc:	9801      	ldr	r0, [sp, #4]
c0d011de:	b285      	uxth	r5, r0
c0d011e0:	6920      	ldr	r0, [r4, #16]
c0d011e2:	f000 fb77 	bl	c0d018d4 <pic>
c0d011e6:	4629      	mov	r1, r5
c0d011e8:	f000 fd30 	bl	c0d01c4c <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d011ec:	b00b      	add	sp, #44	; 0x2c
c0d011ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d011f0:	20001a18 	.word	0x20001a18

c0d011f4 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d011f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011f6:	af03      	add	r7, sp, #12
c0d011f8:	b081      	sub	sp, #4
c0d011fa:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d011fc:	7820      	ldrb	r0, [r4, #0]
c0d011fe:	267f      	movs	r6, #127	; 0x7f
c0d01200:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01202:	2e00      	cmp	r6, #0
c0d01204:	d02e      	beq.n	c0d01264 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01206:	69e0      	ldr	r0, [r4, #28]
c0d01208:	2800      	cmp	r0, #0
c0d0120a:	d01d      	beq.n	c0d01248 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d0120c:	f000 fb62 	bl	c0d018d4 <pic>
c0d01210:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01212:	2e05      	cmp	r6, #5
c0d01214:	d102      	bne.n	c0d0121c <io_seproxyhal_display_default+0x28>
c0d01216:	7ea0      	ldrb	r0, [r4, #26]
c0d01218:	2800      	cmp	r0, #0
c0d0121a:	d025      	beq.n	c0d01268 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0121c:	4628      	mov	r0, r5
c0d0121e:	f001 ffc5 	bl	c0d031ac <strlen>
c0d01222:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01224:	4813      	ldr	r0, [pc, #76]	; (c0d01274 <io_seproxyhal_display_default+0x80>)
c0d01226:	2165      	movs	r1, #101	; 0x65
c0d01228:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0122a:	4631      	mov	r1, r6
c0d0122c:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0122e:	0a0a      	lsrs	r2, r1, #8
c0d01230:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01232:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01234:	2103      	movs	r1, #3
c0d01236:	f000 fd09 	bl	c0d01c4c <io_seproxyhal_spi_send>
c0d0123a:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d0123c:	4620      	mov	r0, r4
c0d0123e:	f000 fd05 	bl	c0d01c4c <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d01242:	b2b1      	uxth	r1, r6
c0d01244:	4628      	mov	r0, r5
c0d01246:	e00b      	b.n	c0d01260 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01248:	480a      	ldr	r0, [pc, #40]	; (c0d01274 <io_seproxyhal_display_default+0x80>)
c0d0124a:	2165      	movs	r1, #101	; 0x65
c0d0124c:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0124e:	2100      	movs	r1, #0
c0d01250:	7041      	strb	r1, [r0, #1]
c0d01252:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01254:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01256:	2103      	movs	r1, #3
c0d01258:	f000 fcf8 	bl	c0d01c4c <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d0125c:	4620      	mov	r0, r4
c0d0125e:	4629      	mov	r1, r5
c0d01260:	f000 fcf4 	bl	c0d01c4c <io_seproxyhal_spi_send>
    }
  }
}
c0d01264:	b001      	add	sp, #4
c0d01266:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01268:	4620      	mov	r0, r4
c0d0126a:	4629      	mov	r1, r5
c0d0126c:	f7ff ff7a 	bl	c0d01164 <io_seproxyhal_display_icon>
c0d01270:	e7f8      	b.n	c0d01264 <io_seproxyhal_display_default+0x70>
c0d01272:	46c0      	nop			; (mov r8, r8)
c0d01274:	20001a18 	.word	0x20001a18

c0d01278 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01278:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0127a:	af03      	add	r7, sp, #12
c0d0127c:	b081      	sub	sp, #4
c0d0127e:	4604      	mov	r4, r0
  if (button_callback) {
c0d01280:	2c00      	cmp	r4, #0
c0d01282:	d02e      	beq.n	c0d012e2 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01284:	4818      	ldr	r0, [pc, #96]	; (c0d012e8 <io_seproxyhal_button_push+0x70>)
c0d01286:	6802      	ldr	r2, [r0, #0]
c0d01288:	428a      	cmp	r2, r1
c0d0128a:	d103      	bne.n	c0d01294 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d0128c:	4a17      	ldr	r2, [pc, #92]	; (c0d012ec <io_seproxyhal_button_push+0x74>)
c0d0128e:	6813      	ldr	r3, [r2, #0]
c0d01290:	1c5b      	adds	r3, r3, #1
c0d01292:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01294:	6806      	ldr	r6, [r0, #0]
c0d01296:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01298:	4a14      	ldr	r2, [pc, #80]	; (c0d012ec <io_seproxyhal_button_push+0x74>)
c0d0129a:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d0129c:	2900      	cmp	r1, #0
c0d0129e:	d001      	beq.n	c0d012a4 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d012a0:	6006      	str	r6, [r0, #0]
c0d012a2:	e005      	b.n	c0d012b0 <io_seproxyhal_button_push+0x38>
c0d012a4:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d012a6:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d012a8:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d012aa:	2301      	movs	r3, #1
c0d012ac:	07db      	lsls	r3, r3, #31
c0d012ae:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d012b0:	6800      	ldr	r0, [r0, #0]
c0d012b2:	4288      	cmp	r0, r1
c0d012b4:	d001      	beq.n	c0d012ba <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d012b6:	2000      	movs	r0, #0
c0d012b8:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d012ba:	2d08      	cmp	r5, #8
c0d012bc:	d30e      	bcc.n	c0d012dc <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d012be:	2103      	movs	r1, #3
c0d012c0:	4628      	mov	r0, r5
c0d012c2:	f001 fda7 	bl	c0d02e14 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d012c6:	2001      	movs	r0, #1
c0d012c8:	0780      	lsls	r0, r0, #30
c0d012ca:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d012cc:	2900      	cmp	r1, #0
c0d012ce:	4601      	mov	r1, r0
c0d012d0:	d000      	beq.n	c0d012d4 <io_seproxyhal_button_push+0x5c>
c0d012d2:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d012d4:	2900      	cmp	r1, #0
c0d012d6:	db02      	blt.n	c0d012de <io_seproxyhal_button_push+0x66>
c0d012d8:	4608      	mov	r0, r1
c0d012da:	e000      	b.n	c0d012de <io_seproxyhal_button_push+0x66>
c0d012dc:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d012de:	4629      	mov	r1, r5
c0d012e0:	47a0      	blx	r4
  }
}
c0d012e2:	b001      	add	sp, #4
c0d012e4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d012e6:	46c0      	nop			; (mov r8, r8)
c0d012e8:	20001d24 	.word	0x20001d24
c0d012ec:	20001d28 	.word	0x20001d28

c0d012f0 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d012f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012f2:	af03      	add	r7, sp, #12
c0d012f4:	b081      	sub	sp, #4
c0d012f6:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d012f8:	200f      	movs	r0, #15
c0d012fa:	4204      	tst	r4, r0
c0d012fc:	d006      	beq.n	c0d0130c <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d012fe:	4620      	mov	r0, r4
c0d01300:	f7ff f8be 	bl	c0d00480 <io_exchange_al>
c0d01304:	4605      	mov	r5, r0
  }
}
c0d01306:	b2a8      	uxth	r0, r5
c0d01308:	b001      	add	sp, #4
c0d0130a:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d0130c:	2610      	movs	r6, #16
c0d0130e:	4026      	ands	r6, r4
c0d01310:	2900      	cmp	r1, #0
c0d01312:	d02a      	beq.n	c0d0136a <io_exchange+0x7a>
c0d01314:	2e00      	cmp	r6, #0
c0d01316:	d128      	bne.n	c0d0136a <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01318:	483d      	ldr	r0, [pc, #244]	; (c0d01410 <io_exchange+0x120>)
c0d0131a:	7800      	ldrb	r0, [r0, #0]
c0d0131c:	2807      	cmp	r0, #7
c0d0131e:	d00b      	beq.n	c0d01338 <io_exchange+0x48>
c0d01320:	2800      	cmp	r0, #0
c0d01322:	d004      	beq.n	c0d0132e <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01324:	4620      	mov	r0, r4
c0d01326:	f7ff f8ab 	bl	c0d00480 <io_exchange_al>
c0d0132a:	2800      	cmp	r0, #0
c0d0132c:	d00a      	beq.n	c0d01344 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d0132e:	4839      	ldr	r0, [pc, #228]	; (c0d01414 <io_exchange+0x124>)
c0d01330:	6800      	ldr	r0, [r0, #0]
c0d01332:	2109      	movs	r1, #9
c0d01334:	f001 ff2c 	bl	c0d03190 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01338:	483d      	ldr	r0, [pc, #244]	; (c0d01430 <io_exchange+0x140>)
c0d0133a:	4478      	add	r0, pc
c0d0133c:	2200      	movs	r2, #0
c0d0133e:	2320      	movs	r3, #32
c0d01340:	f7ff fc6a 	bl	c0d00c18 <io_usb_hid_exchange>
c0d01344:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01346:	4832      	ldr	r0, [pc, #200]	; (c0d01410 <io_exchange+0x120>)
c0d01348:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d0134a:	4833      	ldr	r0, [pc, #204]	; (c0d01418 <io_exchange+0x128>)
c0d0134c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d0134e:	4833      	ldr	r0, [pc, #204]	; (c0d0141c <io_exchange+0x12c>)
c0d01350:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01352:	4833      	ldr	r0, [pc, #204]	; (c0d01420 <io_exchange+0x130>)
c0d01354:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01356:	4833      	ldr	r0, [pc, #204]	; (c0d01424 <io_exchange+0x134>)
c0d01358:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0135a:	06a0      	lsls	r0, r4, #26
c0d0135c:	d4d3      	bmi.n	c0d01306 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d0135e:	f7ff fcd3 	bl	c0d00d08 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01362:	0620      	lsls	r0, r4, #24
c0d01364:	d501      	bpl.n	c0d0136a <io_exchange+0x7a>
        reset();
c0d01366:	f000 faeb 	bl	c0d01940 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0136a:	2e00      	cmp	r6, #0
c0d0136c:	d10c      	bne.n	c0d01388 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d0136e:	0660      	lsls	r0, r4, #25
c0d01370:	d448      	bmi.n	c0d01404 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01372:	4827      	ldr	r0, [pc, #156]	; (c0d01410 <io_exchange+0x120>)
c0d01374:	2100      	movs	r1, #0
c0d01376:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01378:	4827      	ldr	r0, [pc, #156]	; (c0d01418 <io_exchange+0x128>)
c0d0137a:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d0137c:	4827      	ldr	r0, [pc, #156]	; (c0d0141c <io_exchange+0x12c>)
c0d0137e:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01380:	4827      	ldr	r0, [pc, #156]	; (c0d01420 <io_exchange+0x130>)
c0d01382:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01384:	4827      	ldr	r0, [pc, #156]	; (c0d01424 <io_exchange+0x134>)
c0d01386:	7001      	strb	r1, [r0, #0]
c0d01388:	4c28      	ldr	r4, [pc, #160]	; (c0d0142c <io_exchange+0x13c>)
c0d0138a:	4e24      	ldr	r6, [pc, #144]	; (c0d0141c <io_exchange+0x12c>)
c0d0138c:	e008      	b.n	c0d013a0 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d0138e:	f7ff fd0f 	bl	c0d00db0 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01392:	8830      	ldrh	r0, [r6, #0]
c0d01394:	2800      	cmp	r0, #0
c0d01396:	d003      	beq.n	c0d013a0 <io_exchange+0xb0>
c0d01398:	e032      	b.n	c0d01400 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d0139a:	2002      	movs	r0, #2
c0d0139c:	f7ff f89e 	bl	c0d004dc <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d013a0:	f000 fc72 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d013a4:	2800      	cmp	r0, #0
c0d013a6:	d101      	bne.n	c0d013ac <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d013a8:	f7ff fcae 	bl	c0d00d08 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d013ac:	2180      	movs	r1, #128	; 0x80
c0d013ae:	2500      	movs	r5, #0
c0d013b0:	4620      	mov	r0, r4
c0d013b2:	462a      	mov	r2, r5
c0d013b4:	f000 fc84 	bl	c0d01cc0 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d013b8:	1ec1      	subs	r1, r0, #3
c0d013ba:	78a2      	ldrb	r2, [r4, #2]
c0d013bc:	7863      	ldrb	r3, [r4, #1]
c0d013be:	021b      	lsls	r3, r3, #8
c0d013c0:	4313      	orrs	r3, r2
c0d013c2:	4299      	cmp	r1, r3
c0d013c4:	d110      	bne.n	c0d013e8 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d013c6:	4917      	ldr	r1, [pc, #92]	; (c0d01424 <io_exchange+0x134>)
c0d013c8:	7809      	ldrb	r1, [r1, #0]
c0d013ca:	2900      	cmp	r1, #0
c0d013cc:	d002      	beq.n	c0d013d4 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d013ce:	f7ff fd73 	bl	c0d00eb8 <io_seproxyhal_handle_event>
c0d013d2:	e7e5      	b.n	c0d013a0 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d013d4:	7821      	ldrb	r1, [r4, #0]
c0d013d6:	2910      	cmp	r1, #16
c0d013d8:	d00f      	beq.n	c0d013fa <io_exchange+0x10a>
c0d013da:	290f      	cmp	r1, #15
c0d013dc:	d1dd      	bne.n	c0d0139a <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d013de:	2804      	cmp	r0, #4
c0d013e0:	d102      	bne.n	c0d013e8 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d013e2:	f7ff fca7 	bl	c0d00d34 <io_seproxyhal_handle_usb_event>
c0d013e6:	e7db      	b.n	c0d013a0 <io_exchange+0xb0>
c0d013e8:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d013ea:	4909      	ldr	r1, [pc, #36]	; (c0d01410 <io_exchange+0x120>)
c0d013ec:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d013ee:	490a      	ldr	r1, [pc, #40]	; (c0d01418 <io_exchange+0x128>)
c0d013f0:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d013f2:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d013f4:	490a      	ldr	r1, [pc, #40]	; (c0d01420 <io_exchange+0x130>)
c0d013f6:	8008      	strh	r0, [r1, #0]
c0d013f8:	e7d2      	b.n	c0d013a0 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d013fa:	2806      	cmp	r0, #6
c0d013fc:	d2c7      	bcs.n	c0d0138e <io_exchange+0x9e>
c0d013fe:	e782      	b.n	c0d01306 <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01400:	8835      	ldrh	r5, [r6, #0]
c0d01402:	e780      	b.n	c0d01306 <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01404:	4805      	ldr	r0, [pc, #20]	; (c0d0141c <io_exchange+0x12c>)
c0d01406:	8800      	ldrh	r0, [r0, #0]
c0d01408:	4907      	ldr	r1, [pc, #28]	; (c0d01428 <io_exchange+0x138>)
c0d0140a:	1845      	adds	r5, r0, r1
c0d0140c:	e77b      	b.n	c0d01306 <io_exchange+0x16>
c0d0140e:	46c0      	nop			; (mov r8, r8)
c0d01410:	20001d18 	.word	0x20001d18
c0d01414:	20001bb8 	.word	0x20001bb8
c0d01418:	20001d1a 	.word	0x20001d1a
c0d0141c:	20001d1c 	.word	0x20001d1c
c0d01420:	20001d1e 	.word	0x20001d1e
c0d01424:	20001d10 	.word	0x20001d10
c0d01428:	0000fffb 	.word	0x0000fffb
c0d0142c:	20001a18 	.word	0x20001a18
c0d01430:	fffffbbb 	.word	0xfffffbbb

c0d01434 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01434:	b081      	sub	sp, #4
c0d01436:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01438:	af03      	add	r7, sp, #12
c0d0143a:	b094      	sub	sp, #80	; 0x50
c0d0143c:	4616      	mov	r6, r2
c0d0143e:	460d      	mov	r5, r1
c0d01440:	900e      	str	r0, [sp, #56]	; 0x38
c0d01442:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01444:	2d02      	cmp	r5, #2
c0d01446:	d200      	bcs.n	c0d0144a <snprintf+0x16>
c0d01448:	e22a      	b.n	c0d018a0 <snprintf+0x46c>
c0d0144a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0144c:	2800      	cmp	r0, #0
c0d0144e:	d100      	bne.n	c0d01452 <snprintf+0x1e>
c0d01450:	e226      	b.n	c0d018a0 <snprintf+0x46c>
c0d01452:	2e00      	cmp	r6, #0
c0d01454:	d100      	bne.n	c0d01458 <snprintf+0x24>
c0d01456:	e223      	b.n	c0d018a0 <snprintf+0x46c>
c0d01458:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d0145a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0145c:	9109      	str	r1, [sp, #36]	; 0x24
c0d0145e:	462a      	mov	r2, r5
c0d01460:	f7ff fbae 	bl	c0d00bc0 <os_memset>
c0d01464:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01466:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01468:	7830      	ldrb	r0, [r6, #0]
c0d0146a:	2800      	cmp	r0, #0
c0d0146c:	d100      	bne.n	c0d01470 <snprintf+0x3c>
c0d0146e:	e217      	b.n	c0d018a0 <snprintf+0x46c>
c0d01470:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01472:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01474:	1e6b      	subs	r3, r5, #1
c0d01476:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01478:	460a      	mov	r2, r1
c0d0147a:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d0147c:	e003      	b.n	c0d01486 <snprintf+0x52>
c0d0147e:	1970      	adds	r0, r6, r5
c0d01480:	7840      	ldrb	r0, [r0, #1]
c0d01482:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01484:	1c6d      	adds	r5, r5, #1
c0d01486:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01488:	2800      	cmp	r0, #0
c0d0148a:	d001      	beq.n	c0d01490 <snprintf+0x5c>
c0d0148c:	2825      	cmp	r0, #37	; 0x25
c0d0148e:	d1f6      	bne.n	c0d0147e <snprintf+0x4a>
c0d01490:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01492:	429d      	cmp	r5, r3
c0d01494:	d300      	bcc.n	c0d01498 <snprintf+0x64>
c0d01496:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01498:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0149a:	4631      	mov	r1, r6
c0d0149c:	462a      	mov	r2, r5
c0d0149e:	461c      	mov	r4, r3
c0d014a0:	f7ff fb98 	bl	c0d00bd4 <os_memmove>
c0d014a4:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d014a6:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d014a8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d014aa:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d014ac:	2b00      	cmp	r3, #0
c0d014ae:	d100      	bne.n	c0d014b2 <snprintf+0x7e>
c0d014b0:	e1f6      	b.n	c0d018a0 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d014b2:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d014b4:	5d71      	ldrb	r1, [r6, r5]
c0d014b6:	2925      	cmp	r1, #37	; 0x25
c0d014b8:	d000      	beq.n	c0d014bc <snprintf+0x88>
c0d014ba:	e0ab      	b.n	c0d01614 <snprintf+0x1e0>
c0d014bc:	9304      	str	r3, [sp, #16]
c0d014be:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d014c0:	1c40      	adds	r0, r0, #1
c0d014c2:	2100      	movs	r1, #0
c0d014c4:	2220      	movs	r2, #32
c0d014c6:	920a      	str	r2, [sp, #40]	; 0x28
c0d014c8:	220a      	movs	r2, #10
c0d014ca:	9203      	str	r2, [sp, #12]
c0d014cc:	9102      	str	r1, [sp, #8]
c0d014ce:	9106      	str	r1, [sp, #24]
c0d014d0:	910d      	str	r1, [sp, #52]	; 0x34
c0d014d2:	460b      	mov	r3, r1
c0d014d4:	2102      	movs	r1, #2
c0d014d6:	910c      	str	r1, [sp, #48]	; 0x30
c0d014d8:	4606      	mov	r6, r0
c0d014da:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d014dc:	7831      	ldrb	r1, [r6, #0]
c0d014de:	1c76      	adds	r6, r6, #1
c0d014e0:	2300      	movs	r3, #0
c0d014e2:	2962      	cmp	r1, #98	; 0x62
c0d014e4:	dc41      	bgt.n	c0d0156a <snprintf+0x136>
c0d014e6:	4608      	mov	r0, r1
c0d014e8:	3825      	subs	r0, #37	; 0x25
c0d014ea:	2823      	cmp	r0, #35	; 0x23
c0d014ec:	d900      	bls.n	c0d014f0 <snprintf+0xbc>
c0d014ee:	e094      	b.n	c0d0161a <snprintf+0x1e6>
c0d014f0:	0040      	lsls	r0, r0, #1
c0d014f2:	46c0      	nop			; (mov r8, r8)
c0d014f4:	4478      	add	r0, pc
c0d014f6:	8880      	ldrh	r0, [r0, #4]
c0d014f8:	0040      	lsls	r0, r0, #1
c0d014fa:	4487      	add	pc, r0
c0d014fc:	0186012d 	.word	0x0186012d
c0d01500:	01860186 	.word	0x01860186
c0d01504:	00510186 	.word	0x00510186
c0d01508:	01860186 	.word	0x01860186
c0d0150c:	00580023 	.word	0x00580023
c0d01510:	00240186 	.word	0x00240186
c0d01514:	00240024 	.word	0x00240024
c0d01518:	00240024 	.word	0x00240024
c0d0151c:	00240024 	.word	0x00240024
c0d01520:	00240024 	.word	0x00240024
c0d01524:	01860024 	.word	0x01860024
c0d01528:	01860186 	.word	0x01860186
c0d0152c:	01860186 	.word	0x01860186
c0d01530:	01860186 	.word	0x01860186
c0d01534:	01860186 	.word	0x01860186
c0d01538:	01860186 	.word	0x01860186
c0d0153c:	01860186 	.word	0x01860186
c0d01540:	006c0186 	.word	0x006c0186
c0d01544:	e7c9      	b.n	c0d014da <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01546:	2930      	cmp	r1, #48	; 0x30
c0d01548:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0154a:	4603      	mov	r3, r0
c0d0154c:	d100      	bne.n	c0d01550 <snprintf+0x11c>
c0d0154e:	460b      	mov	r3, r1
c0d01550:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01552:	2c00      	cmp	r4, #0
c0d01554:	d000      	beq.n	c0d01558 <snprintf+0x124>
c0d01556:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01558:	200a      	movs	r0, #10
c0d0155a:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d0155c:	1840      	adds	r0, r0, r1
c0d0155e:	3830      	subs	r0, #48	; 0x30
c0d01560:	900d      	str	r0, [sp, #52]	; 0x34
c0d01562:	4630      	mov	r0, r6
c0d01564:	930a      	str	r3, [sp, #40]	; 0x28
c0d01566:	4613      	mov	r3, r2
c0d01568:	e7b4      	b.n	c0d014d4 <snprintf+0xa0>
c0d0156a:	296f      	cmp	r1, #111	; 0x6f
c0d0156c:	dd11      	ble.n	c0d01592 <snprintf+0x15e>
c0d0156e:	3970      	subs	r1, #112	; 0x70
c0d01570:	2908      	cmp	r1, #8
c0d01572:	d900      	bls.n	c0d01576 <snprintf+0x142>
c0d01574:	e149      	b.n	c0d0180a <snprintf+0x3d6>
c0d01576:	0049      	lsls	r1, r1, #1
c0d01578:	4479      	add	r1, pc
c0d0157a:	8889      	ldrh	r1, [r1, #4]
c0d0157c:	0049      	lsls	r1, r1, #1
c0d0157e:	448f      	add	pc, r1
c0d01580:	01440051 	.word	0x01440051
c0d01584:	002e0144 	.word	0x002e0144
c0d01588:	00590144 	.word	0x00590144
c0d0158c:	01440144 	.word	0x01440144
c0d01590:	0051      	.short	0x0051
c0d01592:	2963      	cmp	r1, #99	; 0x63
c0d01594:	d054      	beq.n	c0d01640 <snprintf+0x20c>
c0d01596:	2964      	cmp	r1, #100	; 0x64
c0d01598:	d057      	beq.n	c0d0164a <snprintf+0x216>
c0d0159a:	2968      	cmp	r1, #104	; 0x68
c0d0159c:	d01d      	beq.n	c0d015da <snprintf+0x1a6>
c0d0159e:	e134      	b.n	c0d0180a <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d015a0:	7830      	ldrb	r0, [r6, #0]
c0d015a2:	2873      	cmp	r0, #115	; 0x73
c0d015a4:	d000      	beq.n	c0d015a8 <snprintf+0x174>
c0d015a6:	e130      	b.n	c0d0180a <snprintf+0x3d6>
c0d015a8:	4630      	mov	r0, r6
c0d015aa:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d015ac:	e00d      	b.n	c0d015ca <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d015ae:	7830      	ldrb	r0, [r6, #0]
c0d015b0:	282a      	cmp	r0, #42	; 0x2a
c0d015b2:	d000      	beq.n	c0d015b6 <snprintf+0x182>
c0d015b4:	e129      	b.n	c0d0180a <snprintf+0x3d6>
c0d015b6:	7871      	ldrb	r1, [r6, #1]
c0d015b8:	1c70      	adds	r0, r6, #1
c0d015ba:	2301      	movs	r3, #1
c0d015bc:	2948      	cmp	r1, #72	; 0x48
c0d015be:	d004      	beq.n	c0d015ca <snprintf+0x196>
c0d015c0:	2968      	cmp	r1, #104	; 0x68
c0d015c2:	d002      	beq.n	c0d015ca <snprintf+0x196>
c0d015c4:	2973      	cmp	r1, #115	; 0x73
c0d015c6:	d000      	beq.n	c0d015ca <snprintf+0x196>
c0d015c8:	e11f      	b.n	c0d0180a <snprintf+0x3d6>
c0d015ca:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d015cc:	1d0a      	adds	r2, r1, #4
c0d015ce:	920f      	str	r2, [sp, #60]	; 0x3c
c0d015d0:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d015d2:	9102      	str	r1, [sp, #8]
c0d015d4:	e77e      	b.n	c0d014d4 <snprintf+0xa0>
c0d015d6:	2001      	movs	r0, #1
c0d015d8:	9006      	str	r0, [sp, #24]
c0d015da:	2010      	movs	r0, #16
c0d015dc:	9003      	str	r0, [sp, #12]
c0d015de:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d015e0:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d015e2:	1d01      	adds	r1, r0, #4
c0d015e4:	910f      	str	r1, [sp, #60]	; 0x3c
c0d015e6:	2103      	movs	r1, #3
c0d015e8:	400a      	ands	r2, r1
c0d015ea:	1c5b      	adds	r3, r3, #1
c0d015ec:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d015ee:	2a01      	cmp	r2, #1
c0d015f0:	d100      	bne.n	c0d015f4 <snprintf+0x1c0>
c0d015f2:	e0b8      	b.n	c0d01766 <snprintf+0x332>
c0d015f4:	2a02      	cmp	r2, #2
c0d015f6:	d100      	bne.n	c0d015fa <snprintf+0x1c6>
c0d015f8:	e104      	b.n	c0d01804 <snprintf+0x3d0>
c0d015fa:	2a03      	cmp	r2, #3
c0d015fc:	4630      	mov	r0, r6
c0d015fe:	d100      	bne.n	c0d01602 <snprintf+0x1ce>
c0d01600:	e768      	b.n	c0d014d4 <snprintf+0xa0>
c0d01602:	9c08      	ldr	r4, [sp, #32]
c0d01604:	4625      	mov	r5, r4
c0d01606:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01608:	1948      	adds	r0, r1, r5
c0d0160a:	7840      	ldrb	r0, [r0, #1]
c0d0160c:	1c6d      	adds	r5, r5, #1
c0d0160e:	2800      	cmp	r0, #0
c0d01610:	d1fa      	bne.n	c0d01608 <snprintf+0x1d4>
c0d01612:	e0ab      	b.n	c0d0176c <snprintf+0x338>
c0d01614:	4606      	mov	r6, r0
c0d01616:	920e      	str	r2, [sp, #56]	; 0x38
c0d01618:	e109      	b.n	c0d0182e <snprintf+0x3fa>
c0d0161a:	2958      	cmp	r1, #88	; 0x58
c0d0161c:	d000      	beq.n	c0d01620 <snprintf+0x1ec>
c0d0161e:	e0f4      	b.n	c0d0180a <snprintf+0x3d6>
c0d01620:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01622:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01624:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01626:	1d01      	adds	r1, r0, #4
c0d01628:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0162a:	6802      	ldr	r2, [r0, #0]
c0d0162c:	2000      	movs	r0, #0
c0d0162e:	9005      	str	r0, [sp, #20]
c0d01630:	2510      	movs	r5, #16
c0d01632:	e014      	b.n	c0d0165e <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01634:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01636:	1d01      	adds	r1, r0, #4
c0d01638:	910f      	str	r1, [sp, #60]	; 0x3c
c0d0163a:	6802      	ldr	r2, [r0, #0]
c0d0163c:	2000      	movs	r0, #0
c0d0163e:	e00c      	b.n	c0d0165a <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01640:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01642:	1d01      	adds	r1, r0, #4
c0d01644:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01646:	6800      	ldr	r0, [r0, #0]
c0d01648:	e087      	b.n	c0d0175a <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0164a:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0164c:	1d01      	adds	r1, r0, #4
c0d0164e:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01650:	6800      	ldr	r0, [r0, #0]
c0d01652:	17c1      	asrs	r1, r0, #31
c0d01654:	1842      	adds	r2, r0, r1
c0d01656:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01658:	0fc0      	lsrs	r0, r0, #31
c0d0165a:	9005      	str	r0, [sp, #20]
c0d0165c:	250a      	movs	r5, #10
c0d0165e:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01660:	4295      	cmp	r5, r2
c0d01662:	920e      	str	r2, [sp, #56]	; 0x38
c0d01664:	d814      	bhi.n	c0d01690 <snprintf+0x25c>
c0d01666:	2201      	movs	r2, #1
c0d01668:	4628      	mov	r0, r5
c0d0166a:	920b      	str	r2, [sp, #44]	; 0x2c
c0d0166c:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d0166e:	4629      	mov	r1, r5
c0d01670:	f001 fb4a 	bl	c0d02d08 <__aeabi_uidiv>
c0d01674:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01676:	4288      	cmp	r0, r1
c0d01678:	d109      	bne.n	c0d0168e <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d0167a:	4628      	mov	r0, r5
c0d0167c:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d0167e:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01680:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01682:	910d      	str	r1, [sp, #52]	; 0x34
c0d01684:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01686:	4288      	cmp	r0, r1
c0d01688:	4622      	mov	r2, r4
c0d0168a:	d9ee      	bls.n	c0d0166a <snprintf+0x236>
c0d0168c:	e000      	b.n	c0d01690 <snprintf+0x25c>
c0d0168e:	460c      	mov	r4, r1
c0d01690:	950c      	str	r5, [sp, #48]	; 0x30
c0d01692:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01694:	2000      	movs	r0, #0
c0d01696:	4603      	mov	r3, r0
c0d01698:	43c1      	mvns	r1, r0
c0d0169a:	9c05      	ldr	r4, [sp, #20]
c0d0169c:	2c00      	cmp	r4, #0
c0d0169e:	d100      	bne.n	c0d016a2 <snprintf+0x26e>
c0d016a0:	4621      	mov	r1, r4
c0d016a2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016a4:	910b      	str	r1, [sp, #44]	; 0x2c
c0d016a6:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d016a8:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d016aa:	b2ca      	uxtb	r2, r1
c0d016ac:	2a30      	cmp	r2, #48	; 0x30
c0d016ae:	d106      	bne.n	c0d016be <snprintf+0x28a>
c0d016b0:	2c00      	cmp	r4, #0
c0d016b2:	d004      	beq.n	c0d016be <snprintf+0x28a>
c0d016b4:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d016b6:	232d      	movs	r3, #45	; 0x2d
c0d016b8:	700b      	strb	r3, [r1, #0]
c0d016ba:	2400      	movs	r4, #0
c0d016bc:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d016be:	1e81      	subs	r1, r0, #2
c0d016c0:	290d      	cmp	r1, #13
c0d016c2:	d80d      	bhi.n	c0d016e0 <snprintf+0x2ac>
c0d016c4:	1e41      	subs	r1, r0, #1
c0d016c6:	d00b      	beq.n	c0d016e0 <snprintf+0x2ac>
c0d016c8:	a810      	add	r0, sp, #64	; 0x40
c0d016ca:	9405      	str	r4, [sp, #20]
c0d016cc:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d016ce:	4320      	orrs	r0, r4
c0d016d0:	f001 fcc6 	bl	c0d03060 <__aeabi_memset>
c0d016d4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016d6:	1900      	adds	r0, r0, r4
c0d016d8:	9c05      	ldr	r4, [sp, #20]
c0d016da:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d016dc:	1840      	adds	r0, r0, r1
c0d016de:	1e43      	subs	r3, r0, #1
c0d016e0:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d016e2:	2c00      	cmp	r4, #0
c0d016e4:	9601      	str	r6, [sp, #4]
c0d016e6:	d003      	beq.n	c0d016f0 <snprintf+0x2bc>
c0d016e8:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d016ea:	222d      	movs	r2, #45	; 0x2d
c0d016ec:	54c2      	strb	r2, [r0, r3]
c0d016ee:	1c5b      	adds	r3, r3, #1
c0d016f0:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d016f2:	2900      	cmp	r1, #0
c0d016f4:	d003      	beq.n	c0d016fe <snprintf+0x2ca>
c0d016f6:	2800      	cmp	r0, #0
c0d016f8:	d003      	beq.n	c0d01702 <snprintf+0x2ce>
c0d016fa:	a06c      	add	r0, pc, #432	; (adr r0, c0d018ac <g_pcHex_cap>)
c0d016fc:	e002      	b.n	c0d01704 <snprintf+0x2d0>
c0d016fe:	461c      	mov	r4, r3
c0d01700:	e016      	b.n	c0d01730 <snprintf+0x2fc>
c0d01702:	a06e      	add	r0, pc, #440	; (adr r0, c0d018bc <g_pcHex>)
c0d01704:	900d      	str	r0, [sp, #52]	; 0x34
c0d01706:	461c      	mov	r4, r3
c0d01708:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0170a:	460e      	mov	r6, r1
c0d0170c:	f001 fafc 	bl	c0d02d08 <__aeabi_uidiv>
c0d01710:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01712:	4629      	mov	r1, r5
c0d01714:	f001 fb7e 	bl	c0d02e14 <__aeabi_uidivmod>
c0d01718:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0171a:	5c40      	ldrb	r0, [r0, r1]
c0d0171c:	a910      	add	r1, sp, #64	; 0x40
c0d0171e:	5508      	strb	r0, [r1, r4]
c0d01720:	4630      	mov	r0, r6
c0d01722:	4629      	mov	r1, r5
c0d01724:	f001 faf0 	bl	c0d02d08 <__aeabi_uidiv>
c0d01728:	1c64      	adds	r4, r4, #1
c0d0172a:	42b5      	cmp	r5, r6
c0d0172c:	4601      	mov	r1, r0
c0d0172e:	d9eb      	bls.n	c0d01708 <snprintf+0x2d4>
c0d01730:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01732:	429c      	cmp	r4, r3
c0d01734:	4625      	mov	r5, r4
c0d01736:	d300      	bcc.n	c0d0173a <snprintf+0x306>
c0d01738:	461d      	mov	r5, r3
c0d0173a:	a910      	add	r1, sp, #64	; 0x40
c0d0173c:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d0173e:	4620      	mov	r0, r4
c0d01740:	462a      	mov	r2, r5
c0d01742:	461e      	mov	r6, r3
c0d01744:	f7ff fa46 	bl	c0d00bd4 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01748:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d0174a:	1961      	adds	r1, r4, r5
c0d0174c:	910e      	str	r1, [sp, #56]	; 0x38
c0d0174e:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01750:	2800      	cmp	r0, #0
c0d01752:	9e01      	ldr	r6, [sp, #4]
c0d01754:	d16b      	bne.n	c0d0182e <snprintf+0x3fa>
c0d01756:	e0a3      	b.n	c0d018a0 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01758:	2025      	movs	r0, #37	; 0x25
c0d0175a:	9907      	ldr	r1, [sp, #28]
c0d0175c:	7008      	strb	r0, [r1, #0]
c0d0175e:	9804      	ldr	r0, [sp, #16]
c0d01760:	1e40      	subs	r0, r0, #1
c0d01762:	1c49      	adds	r1, r1, #1
c0d01764:	e05f      	b.n	c0d01826 <snprintf+0x3f2>
c0d01766:	9d02      	ldr	r5, [sp, #8]
c0d01768:	9c08      	ldr	r4, [sp, #32]
c0d0176a:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d0176c:	9803      	ldr	r0, [sp, #12]
c0d0176e:	2810      	cmp	r0, #16
c0d01770:	9807      	ldr	r0, [sp, #28]
c0d01772:	d161      	bne.n	c0d01838 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01774:	2d00      	cmp	r5, #0
c0d01776:	d06a      	beq.n	c0d0184e <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01778:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0177a:	1900      	adds	r0, r0, r4
c0d0177c:	900e      	str	r0, [sp, #56]	; 0x38
c0d0177e:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01780:	1aa0      	subs	r0, r4, r2
c0d01782:	9b05      	ldr	r3, [sp, #20]
c0d01784:	4283      	cmp	r3, r0
c0d01786:	d800      	bhi.n	c0d0178a <snprintf+0x356>
c0d01788:	4603      	mov	r3, r0
c0d0178a:	930c      	str	r3, [sp, #48]	; 0x30
c0d0178c:	435c      	muls	r4, r3
c0d0178e:	940a      	str	r4, [sp, #40]	; 0x28
c0d01790:	1c60      	adds	r0, r4, #1
c0d01792:	9007      	str	r0, [sp, #28]
c0d01794:	2000      	movs	r0, #0
c0d01796:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01798:	9100      	str	r1, [sp, #0]
c0d0179a:	940e      	str	r4, [sp, #56]	; 0x38
c0d0179c:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0179e:	18e3      	adds	r3, r4, r3
c0d017a0:	900d      	str	r0, [sp, #52]	; 0x34
c0d017a2:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d017a4:	200f      	movs	r0, #15
c0d017a6:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d017a8:	0909      	lsrs	r1, r1, #4
c0d017aa:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d017ac:	18a4      	adds	r4, r4, r2
c0d017ae:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d017b0:	2c02      	cmp	r4, #2
c0d017b2:	d375      	bcc.n	c0d018a0 <snprintf+0x46c>
c0d017b4:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d017b6:	2c01      	cmp	r4, #1
c0d017b8:	d003      	beq.n	c0d017c2 <snprintf+0x38e>
c0d017ba:	2c00      	cmp	r4, #0
c0d017bc:	d108      	bne.n	c0d017d0 <snprintf+0x39c>
c0d017be:	a43f      	add	r4, pc, #252	; (adr r4, c0d018bc <g_pcHex>)
c0d017c0:	e000      	b.n	c0d017c4 <snprintf+0x390>
c0d017c2:	a43a      	add	r4, pc, #232	; (adr r4, c0d018ac <g_pcHex_cap>)
c0d017c4:	b2c9      	uxtb	r1, r1
c0d017c6:	5c61      	ldrb	r1, [r4, r1]
c0d017c8:	7019      	strb	r1, [r3, #0]
c0d017ca:	b2c0      	uxtb	r0, r0
c0d017cc:	5c20      	ldrb	r0, [r4, r0]
c0d017ce:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d017d0:	9807      	ldr	r0, [sp, #28]
c0d017d2:	4290      	cmp	r0, r2
c0d017d4:	d064      	beq.n	c0d018a0 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d017d6:	1e92      	subs	r2, r2, #2
c0d017d8:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d017da:	1ca4      	adds	r4, r4, #2
c0d017dc:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d017de:	1c40      	adds	r0, r0, #1
c0d017e0:	42a8      	cmp	r0, r5
c0d017e2:	9900      	ldr	r1, [sp, #0]
c0d017e4:	d3d9      	bcc.n	c0d0179a <snprintf+0x366>
c0d017e6:	900d      	str	r0, [sp, #52]	; 0x34
c0d017e8:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d017ea:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d017ec:	1a08      	subs	r0, r1, r0
c0d017ee:	9b05      	ldr	r3, [sp, #20]
c0d017f0:	4283      	cmp	r3, r0
c0d017f2:	d800      	bhi.n	c0d017f6 <snprintf+0x3c2>
c0d017f4:	4603      	mov	r3, r0
c0d017f6:	4608      	mov	r0, r1
c0d017f8:	4358      	muls	r0, r3
c0d017fa:	1820      	adds	r0, r4, r0
c0d017fc:	900e      	str	r0, [sp, #56]	; 0x38
c0d017fe:	1898      	adds	r0, r3, r2
c0d01800:	1c43      	adds	r3, r0, #1
c0d01802:	e038      	b.n	c0d01876 <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01804:	7808      	ldrb	r0, [r1, #0]
c0d01806:	2800      	cmp	r0, #0
c0d01808:	d023      	beq.n	c0d01852 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d0180a:	2005      	movs	r0, #5
c0d0180c:	9d04      	ldr	r5, [sp, #16]
c0d0180e:	2d05      	cmp	r5, #5
c0d01810:	462c      	mov	r4, r5
c0d01812:	d300      	bcc.n	c0d01816 <snprintf+0x3e2>
c0d01814:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01816:	9807      	ldr	r0, [sp, #28]
c0d01818:	a12c      	add	r1, pc, #176	; (adr r1, c0d018cc <g_pcHex+0x10>)
c0d0181a:	4622      	mov	r2, r4
c0d0181c:	f7ff f9da 	bl	c0d00bd4 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01820:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01822:	9907      	ldr	r1, [sp, #28]
c0d01824:	1909      	adds	r1, r1, r4
c0d01826:	910e      	str	r1, [sp, #56]	; 0x38
c0d01828:	4603      	mov	r3, r0
c0d0182a:	2800      	cmp	r0, #0
c0d0182c:	d038      	beq.n	c0d018a0 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0182e:	7830      	ldrb	r0, [r6, #0]
c0d01830:	2800      	cmp	r0, #0
c0d01832:	9908      	ldr	r1, [sp, #32]
c0d01834:	d034      	beq.n	c0d018a0 <snprintf+0x46c>
c0d01836:	e61f      	b.n	c0d01478 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01838:	429d      	cmp	r5, r3
c0d0183a:	d300      	bcc.n	c0d0183e <snprintf+0x40a>
c0d0183c:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d0183e:	462a      	mov	r2, r5
c0d01840:	461c      	mov	r4, r3
c0d01842:	f7ff f9c7 	bl	c0d00bd4 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01846:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01848:	9907      	ldr	r1, [sp, #28]
c0d0184a:	1949      	adds	r1, r1, r5
c0d0184c:	e00f      	b.n	c0d0186e <snprintf+0x43a>
c0d0184e:	900e      	str	r0, [sp, #56]	; 0x38
c0d01850:	e7ed      	b.n	c0d0182e <snprintf+0x3fa>
c0d01852:	9b04      	ldr	r3, [sp, #16]
c0d01854:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01856:	429c      	cmp	r4, r3
c0d01858:	d300      	bcc.n	c0d0185c <snprintf+0x428>
c0d0185a:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d0185c:	2120      	movs	r1, #32
c0d0185e:	9807      	ldr	r0, [sp, #28]
c0d01860:	4622      	mov	r2, r4
c0d01862:	f7ff f9ad 	bl	c0d00bc0 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01866:	9804      	ldr	r0, [sp, #16]
c0d01868:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d0186a:	9907      	ldr	r1, [sp, #28]
c0d0186c:	1909      	adds	r1, r1, r4
c0d0186e:	910e      	str	r1, [sp, #56]	; 0x38
c0d01870:	4603      	mov	r3, r0
c0d01872:	2800      	cmp	r0, #0
c0d01874:	d014      	beq.n	c0d018a0 <snprintf+0x46c>
c0d01876:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01878:	42a8      	cmp	r0, r5
c0d0187a:	d9d8      	bls.n	c0d0182e <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d0187c:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d0187e:	429a      	cmp	r2, r3
c0d01880:	d300      	bcc.n	c0d01884 <snprintf+0x450>
c0d01882:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01884:	2120      	movs	r1, #32
c0d01886:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01888:	4628      	mov	r0, r5
c0d0188a:	920d      	str	r2, [sp, #52]	; 0x34
c0d0188c:	461c      	mov	r4, r3
c0d0188e:	f7ff f997 	bl	c0d00bc0 <os_memset>
c0d01892:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01894:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01896:	182d      	adds	r5, r5, r0
c0d01898:	950e      	str	r5, [sp, #56]	; 0x38
c0d0189a:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d0189c:	2c00      	cmp	r4, #0
c0d0189e:	d1c6      	bne.n	c0d0182e <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d018a0:	2000      	movs	r0, #0
c0d018a2:	b014      	add	sp, #80	; 0x50
c0d018a4:	bcf0      	pop	{r4, r5, r6, r7}
c0d018a6:	bc02      	pop	{r1}
c0d018a8:	b001      	add	sp, #4
c0d018aa:	4708      	bx	r1

c0d018ac <g_pcHex_cap>:
c0d018ac:	33323130 	.word	0x33323130
c0d018b0:	37363534 	.word	0x37363534
c0d018b4:	42413938 	.word	0x42413938
c0d018b8:	46454443 	.word	0x46454443

c0d018bc <g_pcHex>:
c0d018bc:	33323130 	.word	0x33323130
c0d018c0:	37363534 	.word	0x37363534
c0d018c4:	62613938 	.word	0x62613938
c0d018c8:	66656463 	.word	0x66656463
c0d018cc:	4f525245 	.word	0x4f525245
c0d018d0:	00000052 	.word	0x00000052

c0d018d4 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d018d4:	b580      	push	{r7, lr}
c0d018d6:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d018d8:	4904      	ldr	r1, [pc, #16]	; (c0d018ec <pic+0x18>)
c0d018da:	4288      	cmp	r0, r1
c0d018dc:	d304      	bcc.n	c0d018e8 <pic+0x14>
c0d018de:	4904      	ldr	r1, [pc, #16]	; (c0d018f0 <pic+0x1c>)
c0d018e0:	4288      	cmp	r0, r1
c0d018e2:	d201      	bcs.n	c0d018e8 <pic+0x14>
		link_address = pic_internal(link_address);
c0d018e4:	f000 f806 	bl	c0d018f4 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d018e8:	bd80      	pop	{r7, pc}
c0d018ea:	46c0      	nop			; (mov r8, r8)
c0d018ec:	c0d00000 	.word	0xc0d00000
c0d018f0:	c0d036c0 	.word	0xc0d036c0

c0d018f4 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d018f4:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d018f6:	4902      	ldr	r1, [pc, #8]	; (c0d01900 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d018f8:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d018fa:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d018fc:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d018fe:	4770      	bx	lr
c0d01900:	c0d018f5 	.word	0xc0d018f5

c0d01904 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01904:	b580      	push	{r7, lr}
c0d01906:	af00      	add	r7, sp, #0
c0d01908:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d0190a:	490a      	ldr	r1, [pc, #40]	; (c0d01934 <check_api_level+0x30>)
c0d0190c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0190e:	490a      	ldr	r1, [pc, #40]	; (c0d01938 <check_api_level+0x34>)
c0d01910:	680a      	ldr	r2, [r1, #0]
c0d01912:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01914:	9003      	str	r0, [sp, #12]
c0d01916:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01918:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0191a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0191c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d0191e:	4807      	ldr	r0, [pc, #28]	; (c0d0193c <check_api_level+0x38>)
c0d01920:	9a01      	ldr	r2, [sp, #4]
c0d01922:	4282      	cmp	r2, r0
c0d01924:	d101      	bne.n	c0d0192a <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01926:	b004      	add	sp, #16
c0d01928:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0192a:	6808      	ldr	r0, [r1, #0]
c0d0192c:	2104      	movs	r1, #4
c0d0192e:	f001 fc2f 	bl	c0d03190 <longjmp>
c0d01932:	46c0      	nop			; (mov r8, r8)
c0d01934:	60000137 	.word	0x60000137
c0d01938:	20001bb8 	.word	0x20001bb8
c0d0193c:	900001c6 	.word	0x900001c6

c0d01940 <reset>:
  }
}

void reset ( void ) 
{
c0d01940:	b580      	push	{r7, lr}
c0d01942:	af00      	add	r7, sp, #0
c0d01944:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01946:	4809      	ldr	r0, [pc, #36]	; (c0d0196c <reset+0x2c>)
c0d01948:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0194a:	4809      	ldr	r0, [pc, #36]	; (c0d01970 <reset+0x30>)
c0d0194c:	6801      	ldr	r1, [r0, #0]
c0d0194e:	9101      	str	r1, [sp, #4]
c0d01950:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01952:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01954:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01956:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01958:	4906      	ldr	r1, [pc, #24]	; (c0d01974 <reset+0x34>)
c0d0195a:	9a00      	ldr	r2, [sp, #0]
c0d0195c:	428a      	cmp	r2, r1
c0d0195e:	d101      	bne.n	c0d01964 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01960:	b002      	add	sp, #8
c0d01962:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01964:	6800      	ldr	r0, [r0, #0]
c0d01966:	2104      	movs	r1, #4
c0d01968:	f001 fc12 	bl	c0d03190 <longjmp>
c0d0196c:	60000200 	.word	0x60000200
c0d01970:	20001bb8 	.word	0x20001bb8
c0d01974:	900002f1 	.word	0x900002f1

c0d01978 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01978:	b5d0      	push	{r4, r6, r7, lr}
c0d0197a:	af02      	add	r7, sp, #8
c0d0197c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d0197e:	4b0a      	ldr	r3, [pc, #40]	; (c0d019a8 <nvm_write+0x30>)
c0d01980:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01982:	4b0a      	ldr	r3, [pc, #40]	; (c0d019ac <nvm_write+0x34>)
c0d01984:	681c      	ldr	r4, [r3, #0]
c0d01986:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01988:	ac03      	add	r4, sp, #12
c0d0198a:	c407      	stmia	r4!, {r0, r1, r2}
c0d0198c:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0198e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01990:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01992:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01994:	4806      	ldr	r0, [pc, #24]	; (c0d019b0 <nvm_write+0x38>)
c0d01996:	9901      	ldr	r1, [sp, #4]
c0d01998:	4281      	cmp	r1, r0
c0d0199a:	d101      	bne.n	c0d019a0 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0199c:	b006      	add	sp, #24
c0d0199e:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d019a0:	6818      	ldr	r0, [r3, #0]
c0d019a2:	2104      	movs	r1, #4
c0d019a4:	f001 fbf4 	bl	c0d03190 <longjmp>
c0d019a8:	6000037f 	.word	0x6000037f
c0d019ac:	20001bb8 	.word	0x20001bb8
c0d019b0:	900003bc 	.word	0x900003bc

c0d019b4 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d019b4:	b580      	push	{r7, lr}
c0d019b6:	af00      	add	r7, sp, #0
c0d019b8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d019ba:	4a0a      	ldr	r2, [pc, #40]	; (c0d019e4 <cx_rng+0x30>)
c0d019bc:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019be:	4a0a      	ldr	r2, [pc, #40]	; (c0d019e8 <cx_rng+0x34>)
c0d019c0:	6813      	ldr	r3, [r2, #0]
c0d019c2:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d019c4:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d019c6:	9103      	str	r1, [sp, #12]
c0d019c8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d019ca:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d019cc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d019ce:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d019d0:	4906      	ldr	r1, [pc, #24]	; (c0d019ec <cx_rng+0x38>)
c0d019d2:	9b00      	ldr	r3, [sp, #0]
c0d019d4:	428b      	cmp	r3, r1
c0d019d6:	d101      	bne.n	c0d019dc <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d019d8:	b004      	add	sp, #16
c0d019da:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d019dc:	6810      	ldr	r0, [r2, #0]
c0d019de:	2104      	movs	r1, #4
c0d019e0:	f001 fbd6 	bl	c0d03190 <longjmp>
c0d019e4:	6000052c 	.word	0x6000052c
c0d019e8:	20001bb8 	.word	0x20001bb8
c0d019ec:	90000567 	.word	0x90000567

c0d019f0 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d019f0:	b580      	push	{r7, lr}
c0d019f2:	af00      	add	r7, sp, #0
c0d019f4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d019f6:	490a      	ldr	r1, [pc, #40]	; (c0d01a20 <cx_sha256_init+0x30>)
c0d019f8:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d019fa:	490a      	ldr	r1, [pc, #40]	; (c0d01a24 <cx_sha256_init+0x34>)
c0d019fc:	680a      	ldr	r2, [r1, #0]
c0d019fe:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01a00:	9003      	str	r0, [sp, #12]
c0d01a02:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a04:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a06:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a08:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01a0a:	4a07      	ldr	r2, [pc, #28]	; (c0d01a28 <cx_sha256_init+0x38>)
c0d01a0c:	9b01      	ldr	r3, [sp, #4]
c0d01a0e:	4293      	cmp	r3, r2
c0d01a10:	d101      	bne.n	c0d01a16 <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a12:	b004      	add	sp, #16
c0d01a14:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a16:	6808      	ldr	r0, [r1, #0]
c0d01a18:	2104      	movs	r1, #4
c0d01a1a:	f001 fbb9 	bl	c0d03190 <longjmp>
c0d01a1e:	46c0      	nop			; (mov r8, r8)
c0d01a20:	600008db 	.word	0x600008db
c0d01a24:	20001bb8 	.word	0x20001bb8
c0d01a28:	90000864 	.word	0x90000864

c0d01a2c <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d01a2c:	b580      	push	{r7, lr}
c0d01a2e:	af00      	add	r7, sp, #0
c0d01a30:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d01a32:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a5c <cx_keccak_init+0x30>)
c0d01a34:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a36:	4a0a      	ldr	r2, [pc, #40]	; (c0d01a60 <cx_keccak_init+0x34>)
c0d01a38:	6813      	ldr	r3, [r2, #0]
c0d01a3a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d01a3c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d01a3e:	9103      	str	r1, [sp, #12]
c0d01a40:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a42:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a44:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a46:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d01a48:	4906      	ldr	r1, [pc, #24]	; (c0d01a64 <cx_keccak_init+0x38>)
c0d01a4a:	9b00      	ldr	r3, [sp, #0]
c0d01a4c:	428b      	cmp	r3, r1
c0d01a4e:	d101      	bne.n	c0d01a54 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a50:	b004      	add	sp, #16
c0d01a52:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a54:	6810      	ldr	r0, [r2, #0]
c0d01a56:	2104      	movs	r1, #4
c0d01a58:	f001 fb9a 	bl	c0d03190 <longjmp>
c0d01a5c:	60000c3c 	.word	0x60000c3c
c0d01a60:	20001bb8 	.word	0x20001bb8
c0d01a64:	90000c39 	.word	0x90000c39

c0d01a68 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01a68:	b5b0      	push	{r4, r5, r7, lr}
c0d01a6a:	af02      	add	r7, sp, #8
c0d01a6c:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d01a6e:	4c0b      	ldr	r4, [pc, #44]	; (c0d01a9c <cx_hash+0x34>)
c0d01a70:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01a72:	4c0b      	ldr	r4, [pc, #44]	; (c0d01aa0 <cx_hash+0x38>)
c0d01a74:	6825      	ldr	r5, [r4, #0]
c0d01a76:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01a78:	ad03      	add	r5, sp, #12
c0d01a7a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01a7c:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d01a7e:	9007      	str	r0, [sp, #28]
c0d01a80:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01a82:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01a84:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01a86:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01a88:	4906      	ldr	r1, [pc, #24]	; (c0d01aa4 <cx_hash+0x3c>)
c0d01a8a:	9a01      	ldr	r2, [sp, #4]
c0d01a8c:	428a      	cmp	r2, r1
c0d01a8e:	d101      	bne.n	c0d01a94 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01a90:	b008      	add	sp, #32
c0d01a92:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01a94:	6820      	ldr	r0, [r4, #0]
c0d01a96:	2104      	movs	r1, #4
c0d01a98:	f001 fb7a 	bl	c0d03190 <longjmp>
c0d01a9c:	60000ea6 	.word	0x60000ea6
c0d01aa0:	20001bb8 	.word	0x20001bb8
c0d01aa4:	90000e46 	.word	0x90000e46

c0d01aa8 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d01aa8:	b5b0      	push	{r4, r5, r7, lr}
c0d01aaa:	af02      	add	r7, sp, #8
c0d01aac:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d01aae:	4c0a      	ldr	r4, [pc, #40]	; (c0d01ad8 <cx_ecfp_init_public_key+0x30>)
c0d01ab0:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ab2:	4c0a      	ldr	r4, [pc, #40]	; (c0d01adc <cx_ecfp_init_public_key+0x34>)
c0d01ab4:	6825      	ldr	r5, [r4, #0]
c0d01ab6:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01ab8:	ad02      	add	r5, sp, #8
c0d01aba:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01abc:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01abe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ac0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ac2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d01ac4:	4906      	ldr	r1, [pc, #24]	; (c0d01ae0 <cx_ecfp_init_public_key+0x38>)
c0d01ac6:	9a00      	ldr	r2, [sp, #0]
c0d01ac8:	428a      	cmp	r2, r1
c0d01aca:	d101      	bne.n	c0d01ad0 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01acc:	b006      	add	sp, #24
c0d01ace:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01ad0:	6820      	ldr	r0, [r4, #0]
c0d01ad2:	2104      	movs	r1, #4
c0d01ad4:	f001 fb5c 	bl	c0d03190 <longjmp>
c0d01ad8:	60002835 	.word	0x60002835
c0d01adc:	20001bb8 	.word	0x20001bb8
c0d01ae0:	900028f0 	.word	0x900028f0

c0d01ae4 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01ae4:	b5b0      	push	{r4, r5, r7, lr}
c0d01ae6:	af02      	add	r7, sp, #8
c0d01ae8:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d01aea:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b14 <cx_ecfp_init_private_key+0x30>)
c0d01aec:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01aee:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b18 <cx_ecfp_init_private_key+0x34>)
c0d01af0:	6825      	ldr	r5, [r4, #0]
c0d01af2:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01af4:	ad02      	add	r5, sp, #8
c0d01af6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01af8:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01afa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01afc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01afe:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01b00:	4906      	ldr	r1, [pc, #24]	; (c0d01b1c <cx_ecfp_init_private_key+0x38>)
c0d01b02:	9a00      	ldr	r2, [sp, #0]
c0d01b04:	428a      	cmp	r2, r1
c0d01b06:	d101      	bne.n	c0d01b0c <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b08:	b006      	add	sp, #24
c0d01b0a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b0c:	6820      	ldr	r0, [r4, #0]
c0d01b0e:	2104      	movs	r1, #4
c0d01b10:	f001 fb3e 	bl	c0d03190 <longjmp>
c0d01b14:	600029ed 	.word	0x600029ed
c0d01b18:	20001bb8 	.word	0x20001bb8
c0d01b1c:	900029ae 	.word	0x900029ae

c0d01b20 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01b20:	b5b0      	push	{r4, r5, r7, lr}
c0d01b22:	af02      	add	r7, sp, #8
c0d01b24:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d01b26:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b50 <cx_ecfp_generate_pair+0x30>)
c0d01b28:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b2a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01b54 <cx_ecfp_generate_pair+0x34>)
c0d01b2c:	6825      	ldr	r5, [r4, #0]
c0d01b2e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01b30:	ad02      	add	r5, sp, #8
c0d01b32:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b34:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b36:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b38:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b3a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d01b3c:	4906      	ldr	r1, [pc, #24]	; (c0d01b58 <cx_ecfp_generate_pair+0x38>)
c0d01b3e:	9a00      	ldr	r2, [sp, #0]
c0d01b40:	428a      	cmp	r2, r1
c0d01b42:	d101      	bne.n	c0d01b48 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01b44:	b006      	add	sp, #24
c0d01b46:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b48:	6820      	ldr	r0, [r4, #0]
c0d01b4a:	2104      	movs	r1, #4
c0d01b4c:	f001 fb20 	bl	c0d03190 <longjmp>
c0d01b50:	60002a2e 	.word	0x60002a2e
c0d01b54:	20001bb8 	.word	0x20001bb8
c0d01b58:	90002a74 	.word	0x90002a74

c0d01b5c <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d01b5c:	b5b0      	push	{r4, r5, r7, lr}
c0d01b5e:	af02      	add	r7, sp, #8
c0d01b60:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01b62:	4c0b      	ldr	r4, [pc, #44]	; (c0d01b90 <os_perso_derive_node_bip32+0x34>)
c0d01b64:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01b66:	4c0b      	ldr	r4, [pc, #44]	; (c0d01b94 <os_perso_derive_node_bip32+0x38>)
c0d01b68:	6825      	ldr	r5, [r4, #0]
c0d01b6a:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d01b6c:	ad03      	add	r5, sp, #12
c0d01b6e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01b70:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01b72:	9007      	str	r0, [sp, #28]
c0d01b74:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01b76:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01b78:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01b7a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d01b7c:	4806      	ldr	r0, [pc, #24]	; (c0d01b98 <os_perso_derive_node_bip32+0x3c>)
c0d01b7e:	9901      	ldr	r1, [sp, #4]
c0d01b80:	4281      	cmp	r1, r0
c0d01b82:	d101      	bne.n	c0d01b88 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01b84:	b008      	add	sp, #32
c0d01b86:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01b88:	6820      	ldr	r0, [r4, #0]
c0d01b8a:	2104      	movs	r1, #4
c0d01b8c:	f001 fb00 	bl	c0d03190 <longjmp>
c0d01b90:	6000512b 	.word	0x6000512b
c0d01b94:	20001bb8 	.word	0x20001bb8
c0d01b98:	9000517f 	.word	0x9000517f

c0d01b9c <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d01b9c:	b580      	push	{r7, lr}
c0d01b9e:	af00      	add	r7, sp, #0
c0d01ba0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01ba2:	490a      	ldr	r1, [pc, #40]	; (c0d01bcc <os_sched_exit+0x30>)
c0d01ba4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01ba6:	490a      	ldr	r1, [pc, #40]	; (c0d01bd0 <os_sched_exit+0x34>)
c0d01ba8:	680a      	ldr	r2, [r1, #0]
c0d01baa:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d01bac:	9003      	str	r0, [sp, #12]
c0d01bae:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bb0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bb2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bb4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d01bb6:	4807      	ldr	r0, [pc, #28]	; (c0d01bd4 <os_sched_exit+0x38>)
c0d01bb8:	9a01      	ldr	r2, [sp, #4]
c0d01bba:	4282      	cmp	r2, r0
c0d01bbc:	d101      	bne.n	c0d01bc2 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01bbe:	b004      	add	sp, #16
c0d01bc0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bc2:	6808      	ldr	r0, [r1, #0]
c0d01bc4:	2104      	movs	r1, #4
c0d01bc6:	f001 fae3 	bl	c0d03190 <longjmp>
c0d01bca:	46c0      	nop			; (mov r8, r8)
c0d01bcc:	60005fe1 	.word	0x60005fe1
c0d01bd0:	20001bb8 	.word	0x20001bb8
c0d01bd4:	90005f6f 	.word	0x90005f6f

c0d01bd8 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01bd8:	b580      	push	{r7, lr}
c0d01bda:	af00      	add	r7, sp, #0
c0d01bdc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d01bde:	490a      	ldr	r1, [pc, #40]	; (c0d01c08 <os_ux+0x30>)
c0d01be0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01be2:	490a      	ldr	r1, [pc, #40]	; (c0d01c0c <os_ux+0x34>)
c0d01be4:	680a      	ldr	r2, [r1, #0]
c0d01be6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d01be8:	9003      	str	r0, [sp, #12]
c0d01bea:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01bec:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01bee:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01bf0:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01bf2:	4a07      	ldr	r2, [pc, #28]	; (c0d01c10 <os_ux+0x38>)
c0d01bf4:	9b01      	ldr	r3, [sp, #4]
c0d01bf6:	4293      	cmp	r3, r2
c0d01bf8:	d101      	bne.n	c0d01bfe <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01bfa:	b004      	add	sp, #16
c0d01bfc:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01bfe:	6808      	ldr	r0, [r1, #0]
c0d01c00:	2104      	movs	r1, #4
c0d01c02:	f001 fac5 	bl	c0d03190 <longjmp>
c0d01c06:	46c0      	nop			; (mov r8, r8)
c0d01c08:	60006158 	.word	0x60006158
c0d01c0c:	20001bb8 	.word	0x20001bb8
c0d01c10:	9000611f 	.word	0x9000611f

c0d01c14 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d01c14:	b580      	push	{r7, lr}
c0d01c16:	af00      	add	r7, sp, #0
c0d01c18:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d01c1a:	4809      	ldr	r0, [pc, #36]	; (c0d01c40 <os_seph_features+0x2c>)
c0d01c1c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c1e:	4909      	ldr	r1, [pc, #36]	; (c0d01c44 <os_seph_features+0x30>)
c0d01c20:	6808      	ldr	r0, [r1, #0]
c0d01c22:	9001      	str	r0, [sp, #4]
c0d01c24:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c26:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c28:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c2a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d01c2c:	4a06      	ldr	r2, [pc, #24]	; (c0d01c48 <os_seph_features+0x34>)
c0d01c2e:	9b00      	ldr	r3, [sp, #0]
c0d01c30:	4293      	cmp	r3, r2
c0d01c32:	d101      	bne.n	c0d01c38 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01c34:	b002      	add	sp, #8
c0d01c36:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c38:	6808      	ldr	r0, [r1, #0]
c0d01c3a:	2104      	movs	r1, #4
c0d01c3c:	f001 faa8 	bl	c0d03190 <longjmp>
c0d01c40:	600064d6 	.word	0x600064d6
c0d01c44:	20001bb8 	.word	0x20001bb8
c0d01c48:	90006444 	.word	0x90006444

c0d01c4c <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01c4c:	b580      	push	{r7, lr}
c0d01c4e:	af00      	add	r7, sp, #0
c0d01c50:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d01c52:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c7c <io_seproxyhal_spi_send+0x30>)
c0d01c54:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c56:	4a0a      	ldr	r2, [pc, #40]	; (c0d01c80 <io_seproxyhal_spi_send+0x34>)
c0d01c58:	6813      	ldr	r3, [r2, #0]
c0d01c5a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01c5c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01c5e:	9103      	str	r1, [sp, #12]
c0d01c60:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c62:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c64:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c66:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01c68:	4806      	ldr	r0, [pc, #24]	; (c0d01c84 <io_seproxyhal_spi_send+0x38>)
c0d01c6a:	9900      	ldr	r1, [sp, #0]
c0d01c6c:	4281      	cmp	r1, r0
c0d01c6e:	d101      	bne.n	c0d01c74 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01c70:	b004      	add	sp, #16
c0d01c72:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01c74:	6810      	ldr	r0, [r2, #0]
c0d01c76:	2104      	movs	r1, #4
c0d01c78:	f001 fa8a 	bl	c0d03190 <longjmp>
c0d01c7c:	60006a1c 	.word	0x60006a1c
c0d01c80:	20001bb8 	.word	0x20001bb8
c0d01c84:	90006af3 	.word	0x90006af3

c0d01c88 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01c88:	b580      	push	{r7, lr}
c0d01c8a:	af00      	add	r7, sp, #0
c0d01c8c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01c8e:	4809      	ldr	r0, [pc, #36]	; (c0d01cb4 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01c90:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01c92:	4909      	ldr	r1, [pc, #36]	; (c0d01cb8 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d01c94:	6808      	ldr	r0, [r1, #0]
c0d01c96:	9001      	str	r0, [sp, #4]
c0d01c98:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01c9a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01c9c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01c9e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01ca0:	4a06      	ldr	r2, [pc, #24]	; (c0d01cbc <io_seproxyhal_spi_is_status_sent+0x34>)
c0d01ca2:	9b00      	ldr	r3, [sp, #0]
c0d01ca4:	4293      	cmp	r3, r2
c0d01ca6:	d101      	bne.n	c0d01cac <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01ca8:	b002      	add	sp, #8
c0d01caa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cac:	6808      	ldr	r0, [r1, #0]
c0d01cae:	2104      	movs	r1, #4
c0d01cb0:	f001 fa6e 	bl	c0d03190 <longjmp>
c0d01cb4:	60006bcf 	.word	0x60006bcf
c0d01cb8:	20001bb8 	.word	0x20001bb8
c0d01cbc:	90006b7f 	.word	0x90006b7f

c0d01cc0 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01cc0:	b5d0      	push	{r4, r6, r7, lr}
c0d01cc2:	af02      	add	r7, sp, #8
c0d01cc4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d01cc6:	4b0b      	ldr	r3, [pc, #44]	; (c0d01cf4 <io_seproxyhal_spi_recv+0x34>)
c0d01cc8:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01cca:	4b0b      	ldr	r3, [pc, #44]	; (c0d01cf8 <io_seproxyhal_spi_recv+0x38>)
c0d01ccc:	681c      	ldr	r4, [r3, #0]
c0d01cce:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01cd0:	ac03      	add	r4, sp, #12
c0d01cd2:	c407      	stmia	r4!, {r0, r1, r2}
c0d01cd4:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01cd6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01cd8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01cda:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01cdc:	4907      	ldr	r1, [pc, #28]	; (c0d01cfc <io_seproxyhal_spi_recv+0x3c>)
c0d01cde:	9a01      	ldr	r2, [sp, #4]
c0d01ce0:	428a      	cmp	r2, r1
c0d01ce2:	d102      	bne.n	c0d01cea <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d01ce4:	b280      	uxth	r0, r0
c0d01ce6:	b006      	add	sp, #24
c0d01ce8:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01cea:	6818      	ldr	r0, [r3, #0]
c0d01cec:	2104      	movs	r1, #4
c0d01cee:	f001 fa4f 	bl	c0d03190 <longjmp>
c0d01cf2:	46c0      	nop			; (mov r8, r8)
c0d01cf4:	60006cd1 	.word	0x60006cd1
c0d01cf8:	20001bb8 	.word	0x20001bb8
c0d01cfc:	90006c2b 	.word	0x90006c2b

c0d01d00 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01d00:	b5b0      	push	{r4, r5, r7, lr}
c0d01d02:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d01d04:	492c      	ldr	r1, [pc, #176]	; (c0d01db8 <bagl_ui_nanos_screen1_button+0xb8>)
c0d01d06:	4288      	cmp	r0, r1
c0d01d08:	d006      	beq.n	c0d01d18 <bagl_ui_nanos_screen1_button+0x18>
c0d01d0a:	492c      	ldr	r1, [pc, #176]	; (c0d01dbc <bagl_ui_nanos_screen1_button+0xbc>)
c0d01d0c:	4288      	cmp	r0, r1
c0d01d0e:	d151      	bne.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d01d10:	2000      	movs	r0, #0
c0d01d12:	f7ff ff43 	bl	c0d01b9c <os_sched_exit>
c0d01d16:	e04d      	b.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d01d18:	f7fe fba4 	bl	c0d00464 <nvram_is_init>
c0d01d1c:	2801      	cmp	r0, #1
c0d01d1e:	d102      	bne.n	c0d01d26 <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d01d20:	a029      	add	r0, pc, #164	; (adr r0, c0d01dc8 <bagl_ui_nanos_screen1_button+0xc8>)
c0d01d22:	210d      	movs	r1, #13
c0d01d24:	e001      	b.n	c0d01d2a <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d01d26:	a026      	add	r0, pc, #152	; (adr r0, c0d01dc0 <bagl_ui_nanos_screen1_button+0xc0>)
c0d01d28:	2105      	movs	r1, #5
c0d01d2a:	2203      	movs	r2, #3
c0d01d2c:	f7fe f9ba 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01d30:	4c29      	ldr	r4, [pc, #164]	; (c0d01dd8 <bagl_ui_nanos_screen1_button+0xd8>)
c0d01d32:	482b      	ldr	r0, [pc, #172]	; (c0d01de0 <bagl_ui_nanos_screen1_button+0xe0>)
c0d01d34:	4478      	add	r0, pc
c0d01d36:	6020      	str	r0, [r4, #0]
c0d01d38:	2004      	movs	r0, #4
c0d01d3a:	6060      	str	r0, [r4, #4]
c0d01d3c:	4829      	ldr	r0, [pc, #164]	; (c0d01de4 <bagl_ui_nanos_screen1_button+0xe4>)
c0d01d3e:	4478      	add	r0, pc
c0d01d40:	6120      	str	r0, [r4, #16]
c0d01d42:	2500      	movs	r5, #0
c0d01d44:	60e5      	str	r5, [r4, #12]
c0d01d46:	2003      	movs	r0, #3
c0d01d48:	7620      	strb	r0, [r4, #24]
c0d01d4a:	61e5      	str	r5, [r4, #28]
c0d01d4c:	4620      	mov	r0, r4
c0d01d4e:	3018      	adds	r0, #24
c0d01d50:	f7ff ff42 	bl	c0d01bd8 <os_ux>
c0d01d54:	61e0      	str	r0, [r4, #28]
c0d01d56:	f7ff f903 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d01d5a:	60a5      	str	r5, [r4, #8]
c0d01d5c:	6820      	ldr	r0, [r4, #0]
c0d01d5e:	2800      	cmp	r0, #0
c0d01d60:	d028      	beq.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d62:	69e0      	ldr	r0, [r4, #28]
c0d01d64:	491d      	ldr	r1, [pc, #116]	; (c0d01ddc <bagl_ui_nanos_screen1_button+0xdc>)
c0d01d66:	4288      	cmp	r0, r1
c0d01d68:	d116      	bne.n	c0d01d98 <bagl_ui_nanos_screen1_button+0x98>
c0d01d6a:	e023      	b.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d6c:	6860      	ldr	r0, [r4, #4]
c0d01d6e:	4285      	cmp	r5, r0
c0d01d70:	d220      	bcs.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d72:	f7ff ff89 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d01d76:	2800      	cmp	r0, #0
c0d01d78:	d11c      	bne.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d7a:	68a0      	ldr	r0, [r4, #8]
c0d01d7c:	68e1      	ldr	r1, [r4, #12]
c0d01d7e:	2538      	movs	r5, #56	; 0x38
c0d01d80:	4368      	muls	r0, r5
c0d01d82:	6822      	ldr	r2, [r4, #0]
c0d01d84:	1810      	adds	r0, r2, r0
c0d01d86:	2900      	cmp	r1, #0
c0d01d88:	d009      	beq.n	c0d01d9e <bagl_ui_nanos_screen1_button+0x9e>
c0d01d8a:	4788      	blx	r1
c0d01d8c:	2800      	cmp	r0, #0
c0d01d8e:	d106      	bne.n	c0d01d9e <bagl_ui_nanos_screen1_button+0x9e>
c0d01d90:	68a0      	ldr	r0, [r4, #8]
c0d01d92:	1c45      	adds	r5, r0, #1
c0d01d94:	60a5      	str	r5, [r4, #8]
c0d01d96:	6820      	ldr	r0, [r4, #0]
c0d01d98:	2800      	cmp	r0, #0
c0d01d9a:	d1e7      	bne.n	c0d01d6c <bagl_ui_nanos_screen1_button+0x6c>
c0d01d9c:	e00a      	b.n	c0d01db4 <bagl_ui_nanos_screen1_button+0xb4>
c0d01d9e:	2801      	cmp	r0, #1
c0d01da0:	d103      	bne.n	c0d01daa <bagl_ui_nanos_screen1_button+0xaa>
c0d01da2:	68a0      	ldr	r0, [r4, #8]
c0d01da4:	4345      	muls	r5, r0
c0d01da6:	6820      	ldr	r0, [r4, #0]
c0d01da8:	1940      	adds	r0, r0, r5
c0d01daa:	f7fe fb91 	bl	c0d004d0 <io_seproxyhal_display>
c0d01dae:	68a0      	ldr	r0, [r4, #8]
c0d01db0:	1c40      	adds	r0, r0, #1
c0d01db2:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d01db4:	2000      	movs	r0, #0
c0d01db6:	bdb0      	pop	{r4, r5, r7, pc}
c0d01db8:	80000002 	.word	0x80000002
c0d01dbc:	80000001 	.word	0x80000001
c0d01dc0:	54494e49 	.word	0x54494e49
c0d01dc4:	00000000 	.word	0x00000000
c0d01dc8:	6c697453 	.word	0x6c697453
c0d01dcc:	6e75206c 	.word	0x6e75206c
c0d01dd0:	74696e69 	.word	0x74696e69
c0d01dd4:	00000000 	.word	0x00000000
c0d01dd8:	20001a98 	.word	0x20001a98
c0d01ddc:	b0105044 	.word	0xb0105044
c0d01de0:	00001664 	.word	0x00001664
c0d01de4:	00000153 	.word	0x00000153

c0d01de8 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d01de8:	b5b0      	push	{r4, r5, r7, lr}
c0d01dea:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d01dec:	2800      	cmp	r0, #0
c0d01dee:	d005      	beq.n	c0d01dfc <ui_display_debug+0x14>
c0d01df0:	2900      	cmp	r1, #0
c0d01df2:	d003      	beq.n	c0d01dfc <ui_display_debug+0x14>
c0d01df4:	2a00      	cmp	r2, #0
c0d01df6:	d001      	beq.n	c0d01dfc <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d01df8:	f7fe f954 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d01dfc:	4c21      	ldr	r4, [pc, #132]	; (c0d01e84 <ui_display_debug+0x9c>)
c0d01dfe:	4823      	ldr	r0, [pc, #140]	; (c0d01e8c <ui_display_debug+0xa4>)
c0d01e00:	4478      	add	r0, pc
c0d01e02:	6020      	str	r0, [r4, #0]
c0d01e04:	2004      	movs	r0, #4
c0d01e06:	6060      	str	r0, [r4, #4]
c0d01e08:	4821      	ldr	r0, [pc, #132]	; (c0d01e90 <ui_display_debug+0xa8>)
c0d01e0a:	4478      	add	r0, pc
c0d01e0c:	6120      	str	r0, [r4, #16]
c0d01e0e:	2500      	movs	r5, #0
c0d01e10:	60e5      	str	r5, [r4, #12]
c0d01e12:	2003      	movs	r0, #3
c0d01e14:	7620      	strb	r0, [r4, #24]
c0d01e16:	61e5      	str	r5, [r4, #28]
c0d01e18:	4620      	mov	r0, r4
c0d01e1a:	3018      	adds	r0, #24
c0d01e1c:	f7ff fedc 	bl	c0d01bd8 <os_ux>
c0d01e20:	61e0      	str	r0, [r4, #28]
c0d01e22:	f7ff f89d 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d01e26:	60a5      	str	r5, [r4, #8]
c0d01e28:	6820      	ldr	r0, [r4, #0]
c0d01e2a:	2800      	cmp	r0, #0
c0d01e2c:	d028      	beq.n	c0d01e80 <ui_display_debug+0x98>
c0d01e2e:	69e0      	ldr	r0, [r4, #28]
c0d01e30:	4915      	ldr	r1, [pc, #84]	; (c0d01e88 <ui_display_debug+0xa0>)
c0d01e32:	4288      	cmp	r0, r1
c0d01e34:	d116      	bne.n	c0d01e64 <ui_display_debug+0x7c>
c0d01e36:	e023      	b.n	c0d01e80 <ui_display_debug+0x98>
c0d01e38:	6860      	ldr	r0, [r4, #4]
c0d01e3a:	4285      	cmp	r5, r0
c0d01e3c:	d220      	bcs.n	c0d01e80 <ui_display_debug+0x98>
c0d01e3e:	f7ff ff23 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d01e42:	2800      	cmp	r0, #0
c0d01e44:	d11c      	bne.n	c0d01e80 <ui_display_debug+0x98>
c0d01e46:	68a0      	ldr	r0, [r4, #8]
c0d01e48:	68e1      	ldr	r1, [r4, #12]
c0d01e4a:	2538      	movs	r5, #56	; 0x38
c0d01e4c:	4368      	muls	r0, r5
c0d01e4e:	6822      	ldr	r2, [r4, #0]
c0d01e50:	1810      	adds	r0, r2, r0
c0d01e52:	2900      	cmp	r1, #0
c0d01e54:	d009      	beq.n	c0d01e6a <ui_display_debug+0x82>
c0d01e56:	4788      	blx	r1
c0d01e58:	2800      	cmp	r0, #0
c0d01e5a:	d106      	bne.n	c0d01e6a <ui_display_debug+0x82>
c0d01e5c:	68a0      	ldr	r0, [r4, #8]
c0d01e5e:	1c45      	adds	r5, r0, #1
c0d01e60:	60a5      	str	r5, [r4, #8]
c0d01e62:	6820      	ldr	r0, [r4, #0]
c0d01e64:	2800      	cmp	r0, #0
c0d01e66:	d1e7      	bne.n	c0d01e38 <ui_display_debug+0x50>
c0d01e68:	e00a      	b.n	c0d01e80 <ui_display_debug+0x98>
c0d01e6a:	2801      	cmp	r0, #1
c0d01e6c:	d103      	bne.n	c0d01e76 <ui_display_debug+0x8e>
c0d01e6e:	68a0      	ldr	r0, [r4, #8]
c0d01e70:	4345      	muls	r5, r0
c0d01e72:	6820      	ldr	r0, [r4, #0]
c0d01e74:	1940      	adds	r0, r0, r5
c0d01e76:	f7fe fb2b 	bl	c0d004d0 <io_seproxyhal_display>
c0d01e7a:	68a0      	ldr	r0, [r4, #8]
c0d01e7c:	1c40      	adds	r0, r0, #1
c0d01e7e:	60a0      	str	r0, [r4, #8]
}
c0d01e80:	bdb0      	pop	{r4, r5, r7, pc}
c0d01e82:	46c0      	nop			; (mov r8, r8)
c0d01e84:	20001a98 	.word	0x20001a98
c0d01e88:	b0105044 	.word	0xb0105044
c0d01e8c:	00001598 	.word	0x00001598
c0d01e90:	00000087 	.word	0x00000087

c0d01e94 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d01e94:	b580      	push	{r7, lr}
c0d01e96:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d01e98:	4905      	ldr	r1, [pc, #20]	; (c0d01eb0 <bagl_ui_nanos_screen2_button+0x1c>)
c0d01e9a:	4288      	cmp	r0, r1
c0d01e9c:	d002      	beq.n	c0d01ea4 <bagl_ui_nanos_screen2_button+0x10>
c0d01e9e:	4905      	ldr	r1, [pc, #20]	; (c0d01eb4 <bagl_ui_nanos_screen2_button+0x20>)
c0d01ea0:	4288      	cmp	r0, r1
c0d01ea2:	d102      	bne.n	c0d01eaa <bagl_ui_nanos_screen2_button+0x16>
c0d01ea4:	2000      	movs	r0, #0
c0d01ea6:	f7ff fe79 	bl	c0d01b9c <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d01eaa:	2000      	movs	r0, #0
c0d01eac:	bd80      	pop	{r7, pc}
c0d01eae:	46c0      	nop			; (mov r8, r8)
c0d01eb0:	80000002 	.word	0x80000002
c0d01eb4:	80000001 	.word	0x80000001

c0d01eb8 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d01eb8:	b5b0      	push	{r4, r5, r7, lr}
c0d01eba:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d01ebc:	2001      	movs	r0, #1
c0d01ebe:	0204      	lsls	r4, r0, #8
c0d01ec0:	f7ff fea8 	bl	c0d01c14 <os_seph_features>
c0d01ec4:	4220      	tst	r0, r4
c0d01ec6:	d136      	bne.n	c0d01f36 <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d01ec8:	4c3c      	ldr	r4, [pc, #240]	; (c0d01fbc <ui_idle+0x104>)
c0d01eca:	4840      	ldr	r0, [pc, #256]	; (c0d01fcc <ui_idle+0x114>)
c0d01ecc:	4478      	add	r0, pc
c0d01ece:	6020      	str	r0, [r4, #0]
c0d01ed0:	2004      	movs	r0, #4
c0d01ed2:	6060      	str	r0, [r4, #4]
c0d01ed4:	483e      	ldr	r0, [pc, #248]	; (c0d01fd0 <ui_idle+0x118>)
c0d01ed6:	4478      	add	r0, pc
c0d01ed8:	6120      	str	r0, [r4, #16]
c0d01eda:	2500      	movs	r5, #0
c0d01edc:	60e5      	str	r5, [r4, #12]
c0d01ede:	2003      	movs	r0, #3
c0d01ee0:	7620      	strb	r0, [r4, #24]
c0d01ee2:	61e5      	str	r5, [r4, #28]
c0d01ee4:	4620      	mov	r0, r4
c0d01ee6:	3018      	adds	r0, #24
c0d01ee8:	f7ff fe76 	bl	c0d01bd8 <os_ux>
c0d01eec:	61e0      	str	r0, [r4, #28]
c0d01eee:	f7ff f837 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d01ef2:	60a5      	str	r5, [r4, #8]
c0d01ef4:	6820      	ldr	r0, [r4, #0]
c0d01ef6:	2800      	cmp	r0, #0
c0d01ef8:	d05f      	beq.n	c0d01fba <ui_idle+0x102>
c0d01efa:	69e0      	ldr	r0, [r4, #28]
c0d01efc:	4930      	ldr	r1, [pc, #192]	; (c0d01fc0 <ui_idle+0x108>)
c0d01efe:	4288      	cmp	r0, r1
c0d01f00:	d116      	bne.n	c0d01f30 <ui_idle+0x78>
c0d01f02:	e05a      	b.n	c0d01fba <ui_idle+0x102>
c0d01f04:	6860      	ldr	r0, [r4, #4]
c0d01f06:	4285      	cmp	r5, r0
c0d01f08:	d257      	bcs.n	c0d01fba <ui_idle+0x102>
c0d01f0a:	f7ff febd 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d01f0e:	2800      	cmp	r0, #0
c0d01f10:	d153      	bne.n	c0d01fba <ui_idle+0x102>
c0d01f12:	68a0      	ldr	r0, [r4, #8]
c0d01f14:	68e1      	ldr	r1, [r4, #12]
c0d01f16:	2538      	movs	r5, #56	; 0x38
c0d01f18:	4368      	muls	r0, r5
c0d01f1a:	6822      	ldr	r2, [r4, #0]
c0d01f1c:	1810      	adds	r0, r2, r0
c0d01f1e:	2900      	cmp	r1, #0
c0d01f20:	d040      	beq.n	c0d01fa4 <ui_idle+0xec>
c0d01f22:	4788      	blx	r1
c0d01f24:	2800      	cmp	r0, #0
c0d01f26:	d13d      	bne.n	c0d01fa4 <ui_idle+0xec>
c0d01f28:	68a0      	ldr	r0, [r4, #8]
c0d01f2a:	1c45      	adds	r5, r0, #1
c0d01f2c:	60a5      	str	r5, [r4, #8]
c0d01f2e:	6820      	ldr	r0, [r4, #0]
c0d01f30:	2800      	cmp	r0, #0
c0d01f32:	d1e7      	bne.n	c0d01f04 <ui_idle+0x4c>
c0d01f34:	e041      	b.n	c0d01fba <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d01f36:	4c21      	ldr	r4, [pc, #132]	; (c0d01fbc <ui_idle+0x104>)
c0d01f38:	4822      	ldr	r0, [pc, #136]	; (c0d01fc4 <ui_idle+0x10c>)
c0d01f3a:	4478      	add	r0, pc
c0d01f3c:	6020      	str	r0, [r4, #0]
c0d01f3e:	2004      	movs	r0, #4
c0d01f40:	6060      	str	r0, [r4, #4]
c0d01f42:	4821      	ldr	r0, [pc, #132]	; (c0d01fc8 <ui_idle+0x110>)
c0d01f44:	4478      	add	r0, pc
c0d01f46:	6120      	str	r0, [r4, #16]
c0d01f48:	2500      	movs	r5, #0
c0d01f4a:	60e5      	str	r5, [r4, #12]
c0d01f4c:	2003      	movs	r0, #3
c0d01f4e:	7620      	strb	r0, [r4, #24]
c0d01f50:	61e5      	str	r5, [r4, #28]
c0d01f52:	4620      	mov	r0, r4
c0d01f54:	3018      	adds	r0, #24
c0d01f56:	f7ff fe3f 	bl	c0d01bd8 <os_ux>
c0d01f5a:	61e0      	str	r0, [r4, #28]
c0d01f5c:	f7ff f800 	bl	c0d00f60 <io_seproxyhal_init_ux>
c0d01f60:	60a5      	str	r5, [r4, #8]
c0d01f62:	6820      	ldr	r0, [r4, #0]
c0d01f64:	2800      	cmp	r0, #0
c0d01f66:	d028      	beq.n	c0d01fba <ui_idle+0x102>
c0d01f68:	69e0      	ldr	r0, [r4, #28]
c0d01f6a:	4915      	ldr	r1, [pc, #84]	; (c0d01fc0 <ui_idle+0x108>)
c0d01f6c:	4288      	cmp	r0, r1
c0d01f6e:	d116      	bne.n	c0d01f9e <ui_idle+0xe6>
c0d01f70:	e023      	b.n	c0d01fba <ui_idle+0x102>
c0d01f72:	6860      	ldr	r0, [r4, #4]
c0d01f74:	4285      	cmp	r5, r0
c0d01f76:	d220      	bcs.n	c0d01fba <ui_idle+0x102>
c0d01f78:	f7ff fe86 	bl	c0d01c88 <io_seproxyhal_spi_is_status_sent>
c0d01f7c:	2800      	cmp	r0, #0
c0d01f7e:	d11c      	bne.n	c0d01fba <ui_idle+0x102>
c0d01f80:	68a0      	ldr	r0, [r4, #8]
c0d01f82:	68e1      	ldr	r1, [r4, #12]
c0d01f84:	2538      	movs	r5, #56	; 0x38
c0d01f86:	4368      	muls	r0, r5
c0d01f88:	6822      	ldr	r2, [r4, #0]
c0d01f8a:	1810      	adds	r0, r2, r0
c0d01f8c:	2900      	cmp	r1, #0
c0d01f8e:	d009      	beq.n	c0d01fa4 <ui_idle+0xec>
c0d01f90:	4788      	blx	r1
c0d01f92:	2800      	cmp	r0, #0
c0d01f94:	d106      	bne.n	c0d01fa4 <ui_idle+0xec>
c0d01f96:	68a0      	ldr	r0, [r4, #8]
c0d01f98:	1c45      	adds	r5, r0, #1
c0d01f9a:	60a5      	str	r5, [r4, #8]
c0d01f9c:	6820      	ldr	r0, [r4, #0]
c0d01f9e:	2800      	cmp	r0, #0
c0d01fa0:	d1e7      	bne.n	c0d01f72 <ui_idle+0xba>
c0d01fa2:	e00a      	b.n	c0d01fba <ui_idle+0x102>
c0d01fa4:	2801      	cmp	r0, #1
c0d01fa6:	d103      	bne.n	c0d01fb0 <ui_idle+0xf8>
c0d01fa8:	68a0      	ldr	r0, [r4, #8]
c0d01faa:	4345      	muls	r5, r0
c0d01fac:	6820      	ldr	r0, [r4, #0]
c0d01fae:	1940      	adds	r0, r0, r5
c0d01fb0:	f7fe fa8e 	bl	c0d004d0 <io_seproxyhal_display>
c0d01fb4:	68a0      	ldr	r0, [r4, #8]
c0d01fb6:	1c40      	adds	r0, r0, #1
c0d01fb8:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d01fba:	bdb0      	pop	{r4, r5, r7, pc}
c0d01fbc:	20001a98 	.word	0x20001a98
c0d01fc0:	b0105044 	.word	0xb0105044
c0d01fc4:	0000153e 	.word	0x0000153e
c0d01fc8:	0000008d 	.word	0x0000008d
c0d01fcc:	000013ec 	.word	0x000013ec
c0d01fd0:	fffffe27 	.word	0xfffffe27

c0d01fd4 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d01fd4:	2000      	movs	r0, #0
c0d01fd6:	4770      	bx	lr

c0d01fd8 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d01fd8:	b5d0      	push	{r4, r6, r7, lr}
c0d01fda:	af02      	add	r7, sp, #8
c0d01fdc:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d01fde:	4620      	mov	r0, r4
c0d01fe0:	f7ff fddc 	bl	c0d01b9c <os_sched_exit>
    return NULL;
c0d01fe4:	4620      	mov	r0, r4
c0d01fe6:	bdd0      	pop	{r4, r6, r7, pc}

c0d01fe8 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d01fe8:	4902      	ldr	r1, [pc, #8]	; (c0d01ff4 <USBD_LL_Init+0xc>)
c0d01fea:	2000      	movs	r0, #0
c0d01fec:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d01fee:	4902      	ldr	r1, [pc, #8]	; (c0d01ff8 <USBD_LL_Init+0x10>)
c0d01ff0:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d01ff2:	4770      	bx	lr
c0d01ff4:	20001d2c 	.word	0x20001d2c
c0d01ff8:	20001d30 	.word	0x20001d30

c0d01ffc <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d01ffc:	b5d0      	push	{r4, r6, r7, lr}
c0d01ffe:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02000:	4806      	ldr	r0, [pc, #24]	; (c0d0201c <USBD_LL_DeInit+0x20>)
c0d02002:	214f      	movs	r1, #79	; 0x4f
c0d02004:	7001      	strb	r1, [r0, #0]
c0d02006:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02008:	7044      	strb	r4, [r0, #1]
c0d0200a:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d0200c:	7081      	strb	r1, [r0, #2]
c0d0200e:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02010:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02012:	2104      	movs	r1, #4
c0d02014:	f7ff fe1a 	bl	c0d01c4c <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02018:	4620      	mov	r0, r4
c0d0201a:	bdd0      	pop	{r4, r6, r7, pc}
c0d0201c:	20001a18 	.word	0x20001a18

c0d02020 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02020:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02022:	af03      	add	r7, sp, #12
c0d02024:	b083      	sub	sp, #12
c0d02026:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02028:	264f      	movs	r6, #79	; 0x4f
c0d0202a:	702e      	strb	r6, [r5, #0]
c0d0202c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0202e:	706c      	strb	r4, [r5, #1]
c0d02030:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d02032:	70a8      	strb	r0, [r5, #2]
c0d02034:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02036:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02038:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0203a:	2105      	movs	r1, #5
c0d0203c:	4628      	mov	r0, r5
c0d0203e:	f7ff fe05 	bl	c0d01c4c <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02042:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d02044:	706c      	strb	r4, [r5, #1]
c0d02046:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02048:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0204a:	70e8      	strb	r0, [r5, #3]
c0d0204c:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d0204e:	4628      	mov	r0, r5
c0d02050:	f7ff fdfc 	bl	c0d01c4c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02054:	4620      	mov	r0, r4
c0d02056:	b003      	add	sp, #12
c0d02058:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0205a <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0205a:	b5d0      	push	{r4, r6, r7, lr}
c0d0205c:	af02      	add	r7, sp, #8
c0d0205e:	b082      	sub	sp, #8
c0d02060:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02062:	214f      	movs	r1, #79	; 0x4f
c0d02064:	7001      	strb	r1, [r0, #0]
c0d02066:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02068:	7044      	strb	r4, [r0, #1]
c0d0206a:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d0206c:	7081      	strb	r1, [r0, #2]
c0d0206e:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02070:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d02072:	2104      	movs	r1, #4
c0d02074:	f7ff fdea 	bl	c0d01c4c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02078:	4620      	mov	r0, r4
c0d0207a:	b002      	add	sp, #8
c0d0207c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02080 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02080:	b5b0      	push	{r4, r5, r7, lr}
c0d02082:	af02      	add	r7, sp, #8
c0d02084:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d02086:	480f      	ldr	r0, [pc, #60]	; (c0d020c4 <USBD_LL_OpenEP+0x44>)
c0d02088:	2400      	movs	r4, #0
c0d0208a:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d0208c:	480e      	ldr	r0, [pc, #56]	; (c0d020c8 <USBD_LL_OpenEP+0x48>)
c0d0208e:	6004      	str	r4, [r0, #0]
c0d02090:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02092:	254f      	movs	r5, #79	; 0x4f
c0d02094:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d02096:	7044      	strb	r4, [r0, #1]
c0d02098:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0209a:	7085      	strb	r5, [r0, #2]
c0d0209c:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0209e:	70c5      	strb	r5, [r0, #3]
c0d020a0:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d020a2:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d020a4:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d020a6:	2a03      	cmp	r2, #3
c0d020a8:	d802      	bhi.n	c0d020b0 <USBD_LL_OpenEP+0x30>
c0d020aa:	00d0      	lsls	r0, r2, #3
c0d020ac:	4c07      	ldr	r4, [pc, #28]	; (c0d020cc <USBD_LL_OpenEP+0x4c>)
c0d020ae:	40c4      	lsrs	r4, r0
c0d020b0:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d020b2:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d020b4:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d020b6:	2108      	movs	r1, #8
c0d020b8:	f7ff fdc8 	bl	c0d01c4c <io_seproxyhal_spi_send>
c0d020bc:	2000      	movs	r0, #0
  return USBD_OK; 
c0d020be:	b002      	add	sp, #8
c0d020c0:	bdb0      	pop	{r4, r5, r7, pc}
c0d020c2:	46c0      	nop			; (mov r8, r8)
c0d020c4:	20001d2c 	.word	0x20001d2c
c0d020c8:	20001d30 	.word	0x20001d30
c0d020cc:	02030401 	.word	0x02030401

c0d020d0 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d020d0:	b5d0      	push	{r4, r6, r7, lr}
c0d020d2:	af02      	add	r7, sp, #8
c0d020d4:	b082      	sub	sp, #8
c0d020d6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d020d8:	224f      	movs	r2, #79	; 0x4f
c0d020da:	7002      	strb	r2, [r0, #0]
c0d020dc:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d020de:	7044      	strb	r4, [r0, #1]
c0d020e0:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d020e2:	7082      	strb	r2, [r0, #2]
c0d020e4:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d020e6:	70c2      	strb	r2, [r0, #3]
c0d020e8:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d020ea:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d020ec:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d020ee:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d020f0:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d020f2:	2108      	movs	r1, #8
c0d020f4:	f7ff fdaa 	bl	c0d01c4c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d020f8:	4620      	mov	r0, r4
c0d020fa:	b002      	add	sp, #8
c0d020fc:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02100 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02100:	b5b0      	push	{r4, r5, r7, lr}
c0d02102:	af02      	add	r7, sp, #8
c0d02104:	b082      	sub	sp, #8
c0d02106:	460d      	mov	r5, r1
c0d02108:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0210a:	2150      	movs	r1, #80	; 0x50
c0d0210c:	7001      	strb	r1, [r0, #0]
c0d0210e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02110:	7044      	strb	r4, [r0, #1]
c0d02112:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02114:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02116:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02118:	2140      	movs	r1, #64	; 0x40
c0d0211a:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0211c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0211e:	2106      	movs	r1, #6
c0d02120:	f7ff fd94 	bl	c0d01c4c <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02124:	2080      	movs	r0, #128	; 0x80
c0d02126:	4205      	tst	r5, r0
c0d02128:	d101      	bne.n	c0d0212e <USBD_LL_StallEP+0x2e>
c0d0212a:	4807      	ldr	r0, [pc, #28]	; (c0d02148 <USBD_LL_StallEP+0x48>)
c0d0212c:	e000      	b.n	c0d02130 <USBD_LL_StallEP+0x30>
c0d0212e:	4805      	ldr	r0, [pc, #20]	; (c0d02144 <USBD_LL_StallEP+0x44>)
c0d02130:	6801      	ldr	r1, [r0, #0]
c0d02132:	227f      	movs	r2, #127	; 0x7f
c0d02134:	4015      	ands	r5, r2
c0d02136:	2201      	movs	r2, #1
c0d02138:	40aa      	lsls	r2, r5
c0d0213a:	430a      	orrs	r2, r1
c0d0213c:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0213e:	4620      	mov	r0, r4
c0d02140:	b002      	add	sp, #8
c0d02142:	bdb0      	pop	{r4, r5, r7, pc}
c0d02144:	20001d2c 	.word	0x20001d2c
c0d02148:	20001d30 	.word	0x20001d30

c0d0214c <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0214c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0214e:	af03      	add	r7, sp, #12
c0d02150:	b083      	sub	sp, #12
c0d02152:	460d      	mov	r5, r1
c0d02154:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02156:	2150      	movs	r1, #80	; 0x50
c0d02158:	7001      	strb	r1, [r0, #0]
c0d0215a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0215c:	7044      	strb	r4, [r0, #1]
c0d0215e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02160:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02162:	70c5      	strb	r5, [r0, #3]
c0d02164:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d02166:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02168:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0216a:	2106      	movs	r1, #6
c0d0216c:	f7ff fd6e 	bl	c0d01c4c <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02170:	4235      	tst	r5, r6
c0d02172:	d101      	bne.n	c0d02178 <USBD_LL_ClearStallEP+0x2c>
c0d02174:	4807      	ldr	r0, [pc, #28]	; (c0d02194 <USBD_LL_ClearStallEP+0x48>)
c0d02176:	e000      	b.n	c0d0217a <USBD_LL_ClearStallEP+0x2e>
c0d02178:	4805      	ldr	r0, [pc, #20]	; (c0d02190 <USBD_LL_ClearStallEP+0x44>)
c0d0217a:	6801      	ldr	r1, [r0, #0]
c0d0217c:	227f      	movs	r2, #127	; 0x7f
c0d0217e:	4015      	ands	r5, r2
c0d02180:	2201      	movs	r2, #1
c0d02182:	40aa      	lsls	r2, r5
c0d02184:	4391      	bics	r1, r2
c0d02186:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02188:	4620      	mov	r0, r4
c0d0218a:	b003      	add	sp, #12
c0d0218c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0218e:	46c0      	nop			; (mov r8, r8)
c0d02190:	20001d2c 	.word	0x20001d2c
c0d02194:	20001d30 	.word	0x20001d30

c0d02198 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02198:	2080      	movs	r0, #128	; 0x80
c0d0219a:	4201      	tst	r1, r0
c0d0219c:	d001      	beq.n	c0d021a2 <USBD_LL_IsStallEP+0xa>
c0d0219e:	4806      	ldr	r0, [pc, #24]	; (c0d021b8 <USBD_LL_IsStallEP+0x20>)
c0d021a0:	e000      	b.n	c0d021a4 <USBD_LL_IsStallEP+0xc>
c0d021a2:	4804      	ldr	r0, [pc, #16]	; (c0d021b4 <USBD_LL_IsStallEP+0x1c>)
c0d021a4:	6800      	ldr	r0, [r0, #0]
c0d021a6:	227f      	movs	r2, #127	; 0x7f
c0d021a8:	4011      	ands	r1, r2
c0d021aa:	2201      	movs	r2, #1
c0d021ac:	408a      	lsls	r2, r1
c0d021ae:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d021b0:	b2d0      	uxtb	r0, r2
c0d021b2:	4770      	bx	lr
c0d021b4:	20001d30 	.word	0x20001d30
c0d021b8:	20001d2c 	.word	0x20001d2c

c0d021bc <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d021bc:	b5d0      	push	{r4, r6, r7, lr}
c0d021be:	af02      	add	r7, sp, #8
c0d021c0:	b082      	sub	sp, #8
c0d021c2:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d021c4:	224f      	movs	r2, #79	; 0x4f
c0d021c6:	7002      	strb	r2, [r0, #0]
c0d021c8:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d021ca:	7044      	strb	r4, [r0, #1]
c0d021cc:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d021ce:	7082      	strb	r2, [r0, #2]
c0d021d0:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d021d2:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d021d4:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d021d6:	2105      	movs	r1, #5
c0d021d8:	f7ff fd38 	bl	c0d01c4c <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d021dc:	4620      	mov	r0, r4
c0d021de:	b002      	add	sp, #8
c0d021e0:	bdd0      	pop	{r4, r6, r7, pc}

c0d021e2 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d021e2:	b5b0      	push	{r4, r5, r7, lr}
c0d021e4:	af02      	add	r7, sp, #8
c0d021e6:	b082      	sub	sp, #8
c0d021e8:	461c      	mov	r4, r3
c0d021ea:	4615      	mov	r5, r2
c0d021ec:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d021ee:	2250      	movs	r2, #80	; 0x50
c0d021f0:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d021f2:	1ce2      	adds	r2, r4, #3
c0d021f4:	0a13      	lsrs	r3, r2, #8
c0d021f6:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d021f8:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d021fa:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d021fc:	2120      	movs	r1, #32
c0d021fe:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02200:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02202:	2106      	movs	r1, #6
c0d02204:	f7ff fd22 	bl	c0d01c4c <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02208:	4628      	mov	r0, r5
c0d0220a:	4621      	mov	r1, r4
c0d0220c:	f7ff fd1e 	bl	c0d01c4c <io_seproxyhal_spi_send>
c0d02210:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02212:	b002      	add	sp, #8
c0d02214:	bdb0      	pop	{r4, r5, r7, pc}

c0d02216 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02216:	b5d0      	push	{r4, r6, r7, lr}
c0d02218:	af02      	add	r7, sp, #8
c0d0221a:	b082      	sub	sp, #8
c0d0221c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0221e:	2350      	movs	r3, #80	; 0x50
c0d02220:	7003      	strb	r3, [r0, #0]
c0d02222:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02224:	7044      	strb	r4, [r0, #1]
c0d02226:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02228:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0222a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d0222c:	2130      	movs	r1, #48	; 0x30
c0d0222e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02230:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02232:	2106      	movs	r1, #6
c0d02234:	f7ff fd0a 	bl	c0d01c4c <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02238:	4620      	mov	r0, r4
c0d0223a:	b002      	add	sp, #8
c0d0223c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0223e <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d0223e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02240:	af03      	add	r7, sp, #12
c0d02242:	b081      	sub	sp, #4
c0d02244:	4615      	mov	r5, r2
c0d02246:	460e      	mov	r6, r1
c0d02248:	4604      	mov	r4, r0
c0d0224a:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d0224c:	2c00      	cmp	r4, #0
c0d0224e:	d011      	beq.n	c0d02274 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02250:	2049      	movs	r0, #73	; 0x49
c0d02252:	0081      	lsls	r1, r0, #2
c0d02254:	4620      	mov	r0, r4
c0d02256:	f000 fef9 	bl	c0d0304c <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0225a:	2e00      	cmp	r6, #0
c0d0225c:	d002      	beq.n	c0d02264 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d0225e:	2011      	movs	r0, #17
c0d02260:	0100      	lsls	r0, r0, #4
c0d02262:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02264:	20fc      	movs	r0, #252	; 0xfc
c0d02266:	2101      	movs	r1, #1
c0d02268:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d0226a:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d0226c:	4620      	mov	r0, r4
c0d0226e:	f7ff febb 	bl	c0d01fe8 <USBD_LL_Init>
c0d02272:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02274:	b2c0      	uxtb	r0, r0
c0d02276:	b001      	add	sp, #4
c0d02278:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0227a <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d0227a:	b5d0      	push	{r4, r6, r7, lr}
c0d0227c:	af02      	add	r7, sp, #8
c0d0227e:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02280:	20fc      	movs	r0, #252	; 0xfc
c0d02282:	2101      	movs	r1, #1
c0d02284:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02286:	2045      	movs	r0, #69	; 0x45
c0d02288:	0080      	lsls	r0, r0, #2
c0d0228a:	5820      	ldr	r0, [r4, r0]
c0d0228c:	2800      	cmp	r0, #0
c0d0228e:	d006      	beq.n	c0d0229e <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02290:	6840      	ldr	r0, [r0, #4]
c0d02292:	f7ff fb1f 	bl	c0d018d4 <pic>
c0d02296:	4602      	mov	r2, r0
c0d02298:	7921      	ldrb	r1, [r4, #4]
c0d0229a:	4620      	mov	r0, r4
c0d0229c:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0229e:	4620      	mov	r0, r4
c0d022a0:	f7ff fedb 	bl	c0d0205a <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d022a4:	4620      	mov	r0, r4
c0d022a6:	f7ff fea9 	bl	c0d01ffc <USBD_LL_DeInit>
  
  return USBD_OK;
c0d022aa:	2000      	movs	r0, #0
c0d022ac:	bdd0      	pop	{r4, r6, r7, pc}

c0d022ae <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d022ae:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d022b0:	2900      	cmp	r1, #0
c0d022b2:	d003      	beq.n	c0d022bc <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d022b4:	2245      	movs	r2, #69	; 0x45
c0d022b6:	0092      	lsls	r2, r2, #2
c0d022b8:	5081      	str	r1, [r0, r2]
c0d022ba:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d022bc:	b2d0      	uxtb	r0, r2
c0d022be:	4770      	bx	lr

c0d022c0 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d022c0:	b580      	push	{r7, lr}
c0d022c2:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d022c4:	f7ff feac 	bl	c0d02020 <USBD_LL_Start>
  
  return USBD_OK;  
c0d022c8:	2000      	movs	r0, #0
c0d022ca:	bd80      	pop	{r7, pc}

c0d022cc <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d022cc:	b5b0      	push	{r4, r5, r7, lr}
c0d022ce:	af02      	add	r7, sp, #8
c0d022d0:	460c      	mov	r4, r1
c0d022d2:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d022d4:	2045      	movs	r0, #69	; 0x45
c0d022d6:	0080      	lsls	r0, r0, #2
c0d022d8:	5828      	ldr	r0, [r5, r0]
c0d022da:	2800      	cmp	r0, #0
c0d022dc:	d00c      	beq.n	c0d022f8 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d022de:	6800      	ldr	r0, [r0, #0]
c0d022e0:	f7ff faf8 	bl	c0d018d4 <pic>
c0d022e4:	4602      	mov	r2, r0
c0d022e6:	4628      	mov	r0, r5
c0d022e8:	4621      	mov	r1, r4
c0d022ea:	4790      	blx	r2
c0d022ec:	4601      	mov	r1, r0
c0d022ee:	2002      	movs	r0, #2
c0d022f0:	2900      	cmp	r1, #0
c0d022f2:	d100      	bne.n	c0d022f6 <USBD_SetClassConfig+0x2a>
c0d022f4:	4608      	mov	r0, r1
c0d022f6:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d022f8:	2002      	movs	r0, #2
c0d022fa:	bdb0      	pop	{r4, r5, r7, pc}

c0d022fc <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d022fc:	b5b0      	push	{r4, r5, r7, lr}
c0d022fe:	af02      	add	r7, sp, #8
c0d02300:	460c      	mov	r4, r1
c0d02302:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02304:	2045      	movs	r0, #69	; 0x45
c0d02306:	0080      	lsls	r0, r0, #2
c0d02308:	5828      	ldr	r0, [r5, r0]
c0d0230a:	2800      	cmp	r0, #0
c0d0230c:	d006      	beq.n	c0d0231c <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d0230e:	6840      	ldr	r0, [r0, #4]
c0d02310:	f7ff fae0 	bl	c0d018d4 <pic>
c0d02314:	4602      	mov	r2, r0
c0d02316:	4628      	mov	r0, r5
c0d02318:	4621      	mov	r1, r4
c0d0231a:	4790      	blx	r2
  }
  return USBD_OK;
c0d0231c:	2000      	movs	r0, #0
c0d0231e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02320 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02320:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02322:	af03      	add	r7, sp, #12
c0d02324:	b081      	sub	sp, #4
c0d02326:	4604      	mov	r4, r0
c0d02328:	2021      	movs	r0, #33	; 0x21
c0d0232a:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d0232c:	19a5      	adds	r5, r4, r6
c0d0232e:	4628      	mov	r0, r5
c0d02330:	f000 fb69 	bl	c0d02a06 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02334:	20f4      	movs	r0, #244	; 0xf4
c0d02336:	2101      	movs	r1, #1
c0d02338:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0233a:	2087      	movs	r0, #135	; 0x87
c0d0233c:	0040      	lsls	r0, r0, #1
c0d0233e:	5a20      	ldrh	r0, [r4, r0]
c0d02340:	21f8      	movs	r1, #248	; 0xf8
c0d02342:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02344:	5da1      	ldrb	r1, [r4, r6]
c0d02346:	201f      	movs	r0, #31
c0d02348:	4008      	ands	r0, r1
c0d0234a:	2802      	cmp	r0, #2
c0d0234c:	d008      	beq.n	c0d02360 <USBD_LL_SetupStage+0x40>
c0d0234e:	2801      	cmp	r0, #1
c0d02350:	d00b      	beq.n	c0d0236a <USBD_LL_SetupStage+0x4a>
c0d02352:	2800      	cmp	r0, #0
c0d02354:	d10e      	bne.n	c0d02374 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02356:	4620      	mov	r0, r4
c0d02358:	4629      	mov	r1, r5
c0d0235a:	f000 f8f1 	bl	c0d02540 <USBD_StdDevReq>
c0d0235e:	e00e      	b.n	c0d0237e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02360:	4620      	mov	r0, r4
c0d02362:	4629      	mov	r1, r5
c0d02364:	f000 fad3 	bl	c0d0290e <USBD_StdEPReq>
c0d02368:	e009      	b.n	c0d0237e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d0236a:	4620      	mov	r0, r4
c0d0236c:	4629      	mov	r1, r5
c0d0236e:	f000 faa6 	bl	c0d028be <USBD_StdItfReq>
c0d02372:	e004      	b.n	c0d0237e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02374:	2080      	movs	r0, #128	; 0x80
c0d02376:	4001      	ands	r1, r0
c0d02378:	4620      	mov	r0, r4
c0d0237a:	f7ff fec1 	bl	c0d02100 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d0237e:	2000      	movs	r0, #0
c0d02380:	b001      	add	sp, #4
c0d02382:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02384 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02384:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02386:	af03      	add	r7, sp, #12
c0d02388:	b081      	sub	sp, #4
c0d0238a:	4615      	mov	r5, r2
c0d0238c:	460e      	mov	r6, r1
c0d0238e:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02390:	2e00      	cmp	r6, #0
c0d02392:	d011      	beq.n	c0d023b8 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02394:	2045      	movs	r0, #69	; 0x45
c0d02396:	0080      	lsls	r0, r0, #2
c0d02398:	5820      	ldr	r0, [r4, r0]
c0d0239a:	6980      	ldr	r0, [r0, #24]
c0d0239c:	2800      	cmp	r0, #0
c0d0239e:	d034      	beq.n	c0d0240a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d023a0:	21fc      	movs	r1, #252	; 0xfc
c0d023a2:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d023a4:	2903      	cmp	r1, #3
c0d023a6:	d130      	bne.n	c0d0240a <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d023a8:	f7ff fa94 	bl	c0d018d4 <pic>
c0d023ac:	4603      	mov	r3, r0
c0d023ae:	4620      	mov	r0, r4
c0d023b0:	4631      	mov	r1, r6
c0d023b2:	462a      	mov	r2, r5
c0d023b4:	4798      	blx	r3
c0d023b6:	e028      	b.n	c0d0240a <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d023b8:	20f4      	movs	r0, #244	; 0xf4
c0d023ba:	5820      	ldr	r0, [r4, r0]
c0d023bc:	2803      	cmp	r0, #3
c0d023be:	d124      	bne.n	c0d0240a <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d023c0:	2090      	movs	r0, #144	; 0x90
c0d023c2:	5820      	ldr	r0, [r4, r0]
c0d023c4:	218c      	movs	r1, #140	; 0x8c
c0d023c6:	5861      	ldr	r1, [r4, r1]
c0d023c8:	4622      	mov	r2, r4
c0d023ca:	328c      	adds	r2, #140	; 0x8c
c0d023cc:	4281      	cmp	r1, r0
c0d023ce:	d90a      	bls.n	c0d023e6 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d023d0:	1a09      	subs	r1, r1, r0
c0d023d2:	6011      	str	r1, [r2, #0]
c0d023d4:	4281      	cmp	r1, r0
c0d023d6:	d300      	bcc.n	c0d023da <USBD_LL_DataOutStage+0x56>
c0d023d8:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d023da:	b28a      	uxth	r2, r1
c0d023dc:	4620      	mov	r0, r4
c0d023de:	4629      	mov	r1, r5
c0d023e0:	f000 fc70 	bl	c0d02cc4 <USBD_CtlContinueRx>
c0d023e4:	e011      	b.n	c0d0240a <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d023e6:	2045      	movs	r0, #69	; 0x45
c0d023e8:	0080      	lsls	r0, r0, #2
c0d023ea:	5820      	ldr	r0, [r4, r0]
c0d023ec:	6900      	ldr	r0, [r0, #16]
c0d023ee:	2800      	cmp	r0, #0
c0d023f0:	d008      	beq.n	c0d02404 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d023f2:	21fc      	movs	r1, #252	; 0xfc
c0d023f4:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d023f6:	2903      	cmp	r1, #3
c0d023f8:	d104      	bne.n	c0d02404 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d023fa:	f7ff fa6b 	bl	c0d018d4 <pic>
c0d023fe:	4601      	mov	r1, r0
c0d02400:	4620      	mov	r0, r4
c0d02402:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02404:	4620      	mov	r0, r4
c0d02406:	f000 fc65 	bl	c0d02cd4 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d0240a:	2000      	movs	r0, #0
c0d0240c:	b001      	add	sp, #4
c0d0240e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02410 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02410:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02412:	af03      	add	r7, sp, #12
c0d02414:	b081      	sub	sp, #4
c0d02416:	460d      	mov	r5, r1
c0d02418:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0241a:	2d00      	cmp	r5, #0
c0d0241c:	d012      	beq.n	c0d02444 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d0241e:	2045      	movs	r0, #69	; 0x45
c0d02420:	0080      	lsls	r0, r0, #2
c0d02422:	5820      	ldr	r0, [r4, r0]
c0d02424:	2800      	cmp	r0, #0
c0d02426:	d054      	beq.n	c0d024d2 <USBD_LL_DataInStage+0xc2>
c0d02428:	6940      	ldr	r0, [r0, #20]
c0d0242a:	2800      	cmp	r0, #0
c0d0242c:	d051      	beq.n	c0d024d2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0242e:	21fc      	movs	r1, #252	; 0xfc
c0d02430:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02432:	2903      	cmp	r1, #3
c0d02434:	d14d      	bne.n	c0d024d2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02436:	f7ff fa4d 	bl	c0d018d4 <pic>
c0d0243a:	4602      	mov	r2, r0
c0d0243c:	4620      	mov	r0, r4
c0d0243e:	4629      	mov	r1, r5
c0d02440:	4790      	blx	r2
c0d02442:	e046      	b.n	c0d024d2 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02444:	20f4      	movs	r0, #244	; 0xf4
c0d02446:	5820      	ldr	r0, [r4, r0]
c0d02448:	2802      	cmp	r0, #2
c0d0244a:	d13a      	bne.n	c0d024c2 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d0244c:	69e0      	ldr	r0, [r4, #28]
c0d0244e:	6a25      	ldr	r5, [r4, #32]
c0d02450:	42a8      	cmp	r0, r5
c0d02452:	d90b      	bls.n	c0d0246c <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02454:	1b40      	subs	r0, r0, r5
c0d02456:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02458:	2109      	movs	r1, #9
c0d0245a:	014a      	lsls	r2, r1, #5
c0d0245c:	58a1      	ldr	r1, [r4, r2]
c0d0245e:	1949      	adds	r1, r1, r5
c0d02460:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02462:	b282      	uxth	r2, r0
c0d02464:	4620      	mov	r0, r4
c0d02466:	f000 fc1e 	bl	c0d02ca6 <USBD_CtlContinueSendData>
c0d0246a:	e02a      	b.n	c0d024c2 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d0246c:	69a6      	ldr	r6, [r4, #24]
c0d0246e:	4630      	mov	r0, r6
c0d02470:	4629      	mov	r1, r5
c0d02472:	f000 fccf 	bl	c0d02e14 <__aeabi_uidivmod>
c0d02476:	42ae      	cmp	r6, r5
c0d02478:	d30f      	bcc.n	c0d0249a <USBD_LL_DataInStage+0x8a>
c0d0247a:	2900      	cmp	r1, #0
c0d0247c:	d10d      	bne.n	c0d0249a <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d0247e:	20f8      	movs	r0, #248	; 0xf8
c0d02480:	5820      	ldr	r0, [r4, r0]
c0d02482:	4625      	mov	r5, r4
c0d02484:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02486:	4286      	cmp	r6, r0
c0d02488:	d207      	bcs.n	c0d0249a <USBD_LL_DataInStage+0x8a>
c0d0248a:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d0248c:	4620      	mov	r0, r4
c0d0248e:	4631      	mov	r1, r6
c0d02490:	4632      	mov	r2, r6
c0d02492:	f000 fc08 	bl	c0d02ca6 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02496:	602e      	str	r6, [r5, #0]
c0d02498:	e013      	b.n	c0d024c2 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d0249a:	2045      	movs	r0, #69	; 0x45
c0d0249c:	0080      	lsls	r0, r0, #2
c0d0249e:	5820      	ldr	r0, [r4, r0]
c0d024a0:	2800      	cmp	r0, #0
c0d024a2:	d00b      	beq.n	c0d024bc <USBD_LL_DataInStage+0xac>
c0d024a4:	68c0      	ldr	r0, [r0, #12]
c0d024a6:	2800      	cmp	r0, #0
c0d024a8:	d008      	beq.n	c0d024bc <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d024aa:	21fc      	movs	r1, #252	; 0xfc
c0d024ac:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d024ae:	2903      	cmp	r1, #3
c0d024b0:	d104      	bne.n	c0d024bc <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d024b2:	f7ff fa0f 	bl	c0d018d4 <pic>
c0d024b6:	4601      	mov	r1, r0
c0d024b8:	4620      	mov	r0, r4
c0d024ba:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d024bc:	4620      	mov	r0, r4
c0d024be:	f000 fc16 	bl	c0d02cee <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d024c2:	2001      	movs	r0, #1
c0d024c4:	0201      	lsls	r1, r0, #8
c0d024c6:	1860      	adds	r0, r4, r1
c0d024c8:	5c61      	ldrb	r1, [r4, r1]
c0d024ca:	2901      	cmp	r1, #1
c0d024cc:	d101      	bne.n	c0d024d2 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d024ce:	2100      	movs	r1, #0
c0d024d0:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d024d2:	2000      	movs	r0, #0
c0d024d4:	b001      	add	sp, #4
c0d024d6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d024d8 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d024d8:	b5d0      	push	{r4, r6, r7, lr}
c0d024da:	af02      	add	r7, sp, #8
c0d024dc:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d024de:	2090      	movs	r0, #144	; 0x90
c0d024e0:	2140      	movs	r1, #64	; 0x40
c0d024e2:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d024e4:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d024e6:	20fc      	movs	r0, #252	; 0xfc
c0d024e8:	2101      	movs	r1, #1
c0d024ea:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d024ec:	2045      	movs	r0, #69	; 0x45
c0d024ee:	0080      	lsls	r0, r0, #2
c0d024f0:	5820      	ldr	r0, [r4, r0]
c0d024f2:	2800      	cmp	r0, #0
c0d024f4:	d006      	beq.n	c0d02504 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d024f6:	6840      	ldr	r0, [r0, #4]
c0d024f8:	f7ff f9ec 	bl	c0d018d4 <pic>
c0d024fc:	4602      	mov	r2, r0
c0d024fe:	7921      	ldrb	r1, [r4, #4]
c0d02500:	4620      	mov	r0, r4
c0d02502:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02504:	2000      	movs	r0, #0
c0d02506:	bdd0      	pop	{r4, r6, r7, pc}

c0d02508 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02508:	7401      	strb	r1, [r0, #16]
c0d0250a:	2000      	movs	r0, #0
  return USBD_OK;
c0d0250c:	4770      	bx	lr

c0d0250e <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0250e:	2000      	movs	r0, #0
c0d02510:	4770      	bx	lr

c0d02512 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02512:	2000      	movs	r0, #0
c0d02514:	4770      	bx	lr

c0d02516 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02516:	b5d0      	push	{r4, r6, r7, lr}
c0d02518:	af02      	add	r7, sp, #8
c0d0251a:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d0251c:	20fc      	movs	r0, #252	; 0xfc
c0d0251e:	5c20      	ldrb	r0, [r4, r0]
c0d02520:	2803      	cmp	r0, #3
c0d02522:	d10a      	bne.n	c0d0253a <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02524:	2045      	movs	r0, #69	; 0x45
c0d02526:	0080      	lsls	r0, r0, #2
c0d02528:	5820      	ldr	r0, [r4, r0]
c0d0252a:	69c0      	ldr	r0, [r0, #28]
c0d0252c:	2800      	cmp	r0, #0
c0d0252e:	d004      	beq.n	c0d0253a <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02530:	f7ff f9d0 	bl	c0d018d4 <pic>
c0d02534:	4601      	mov	r1, r0
c0d02536:	4620      	mov	r0, r4
c0d02538:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d0253a:	2000      	movs	r0, #0
c0d0253c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02540 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02540:	b5d0      	push	{r4, r6, r7, lr}
c0d02542:	af02      	add	r7, sp, #8
c0d02544:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02546:	7848      	ldrb	r0, [r1, #1]
c0d02548:	2809      	cmp	r0, #9
c0d0254a:	d810      	bhi.n	c0d0256e <USBD_StdDevReq+0x2e>
c0d0254c:	4478      	add	r0, pc
c0d0254e:	7900      	ldrb	r0, [r0, #4]
c0d02550:	0040      	lsls	r0, r0, #1
c0d02552:	4487      	add	pc, r0
c0d02554:	150c0804 	.word	0x150c0804
c0d02558:	0c25190c 	.word	0x0c25190c
c0d0255c:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d0255e:	4620      	mov	r0, r4
c0d02560:	f000 f938 	bl	c0d027d4 <USBD_GetStatus>
c0d02564:	e01f      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02566:	4620      	mov	r0, r4
c0d02568:	f000 f976 	bl	c0d02858 <USBD_ClrFeature>
c0d0256c:	e01b      	b.n	c0d025a6 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0256e:	2180      	movs	r1, #128	; 0x80
c0d02570:	4620      	mov	r0, r4
c0d02572:	f7ff fdc5 	bl	c0d02100 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02576:	2100      	movs	r1, #0
c0d02578:	4620      	mov	r0, r4
c0d0257a:	f7ff fdc1 	bl	c0d02100 <USBD_LL_StallEP>
c0d0257e:	e012      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02580:	4620      	mov	r0, r4
c0d02582:	f000 f950 	bl	c0d02826 <USBD_SetFeature>
c0d02586:	e00e      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02588:	4620      	mov	r0, r4
c0d0258a:	f000 f897 	bl	c0d026bc <USBD_SetAddress>
c0d0258e:	e00a      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02590:	4620      	mov	r0, r4
c0d02592:	f000 f8ff 	bl	c0d02794 <USBD_GetConfig>
c0d02596:	e006      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02598:	4620      	mov	r0, r4
c0d0259a:	f000 f8bd 	bl	c0d02718 <USBD_SetConfig>
c0d0259e:	e002      	b.n	c0d025a6 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d025a0:	4620      	mov	r0, r4
c0d025a2:	f000 f803 	bl	c0d025ac <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d025a6:	2000      	movs	r0, #0
c0d025a8:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d025ac <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d025ac:	b5b0      	push	{r4, r5, r7, lr}
c0d025ae:	af02      	add	r7, sp, #8
c0d025b0:	b082      	sub	sp, #8
c0d025b2:	460d      	mov	r5, r1
c0d025b4:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d025b6:	8868      	ldrh	r0, [r5, #2]
c0d025b8:	0a01      	lsrs	r1, r0, #8
c0d025ba:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d025bc:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d025be:	2a0e      	cmp	r2, #14
c0d025c0:	d83e      	bhi.n	c0d02640 <USBD_GetDescriptor+0x94>
c0d025c2:	46c0      	nop			; (mov r8, r8)
c0d025c4:	447a      	add	r2, pc
c0d025c6:	7912      	ldrb	r2, [r2, #4]
c0d025c8:	0052      	lsls	r2, r2, #1
c0d025ca:	4497      	add	pc, r2
c0d025cc:	390c2607 	.word	0x390c2607
c0d025d0:	39362e39 	.word	0x39362e39
c0d025d4:	39393939 	.word	0x39393939
c0d025d8:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d025dc:	2011      	movs	r0, #17
c0d025de:	0100      	lsls	r0, r0, #4
c0d025e0:	5820      	ldr	r0, [r4, r0]
c0d025e2:	6800      	ldr	r0, [r0, #0]
c0d025e4:	e012      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d025e6:	b2c0      	uxtb	r0, r0
c0d025e8:	2805      	cmp	r0, #5
c0d025ea:	d829      	bhi.n	c0d02640 <USBD_GetDescriptor+0x94>
c0d025ec:	4478      	add	r0, pc
c0d025ee:	7900      	ldrb	r0, [r0, #4]
c0d025f0:	0040      	lsls	r0, r0, #1
c0d025f2:	4487      	add	pc, r0
c0d025f4:	544f4a02 	.word	0x544f4a02
c0d025f8:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d025fa:	2011      	movs	r0, #17
c0d025fc:	0100      	lsls	r0, r0, #4
c0d025fe:	5820      	ldr	r0, [r4, r0]
c0d02600:	6840      	ldr	r0, [r0, #4]
c0d02602:	e003      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02604:	2011      	movs	r0, #17
c0d02606:	0100      	lsls	r0, r0, #4
c0d02608:	5820      	ldr	r0, [r4, r0]
c0d0260a:	69c0      	ldr	r0, [r0, #28]
c0d0260c:	f7ff f962 	bl	c0d018d4 <pic>
c0d02610:	4602      	mov	r2, r0
c0d02612:	7c20      	ldrb	r0, [r4, #16]
c0d02614:	a901      	add	r1, sp, #4
c0d02616:	4790      	blx	r2
c0d02618:	e025      	b.n	c0d02666 <USBD_GetDescriptor+0xba>
c0d0261a:	2045      	movs	r0, #69	; 0x45
c0d0261c:	0080      	lsls	r0, r0, #2
c0d0261e:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02620:	7c21      	ldrb	r1, [r4, #16]
c0d02622:	2900      	cmp	r1, #0
c0d02624:	d014      	beq.n	c0d02650 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02626:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02628:	e018      	b.n	c0d0265c <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0262a:	7c20      	ldrb	r0, [r4, #16]
c0d0262c:	2800      	cmp	r0, #0
c0d0262e:	d107      	bne.n	c0d02640 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02630:	2045      	movs	r0, #69	; 0x45
c0d02632:	0080      	lsls	r0, r0, #2
c0d02634:	5820      	ldr	r0, [r4, r0]
c0d02636:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02638:	e010      	b.n	c0d0265c <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d0263a:	7c20      	ldrb	r0, [r4, #16]
c0d0263c:	2800      	cmp	r0, #0
c0d0263e:	d009      	beq.n	c0d02654 <USBD_GetDescriptor+0xa8>
c0d02640:	4620      	mov	r0, r4
c0d02642:	f7ff fd5d 	bl	c0d02100 <USBD_LL_StallEP>
c0d02646:	2100      	movs	r1, #0
c0d02648:	4620      	mov	r0, r4
c0d0264a:	f7ff fd59 	bl	c0d02100 <USBD_LL_StallEP>
c0d0264e:	e01a      	b.n	c0d02686 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02650:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02652:	e003      	b.n	c0d0265c <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02654:	2045      	movs	r0, #69	; 0x45
c0d02656:	0080      	lsls	r0, r0, #2
c0d02658:	5820      	ldr	r0, [r4, r0]
c0d0265a:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d0265c:	f7ff f93a 	bl	c0d018d4 <pic>
c0d02660:	4601      	mov	r1, r0
c0d02662:	a801      	add	r0, sp, #4
c0d02664:	4788      	blx	r1
c0d02666:	4601      	mov	r1, r0
c0d02668:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0266a:	8802      	ldrh	r2, [r0, #0]
c0d0266c:	2a00      	cmp	r2, #0
c0d0266e:	d00a      	beq.n	c0d02686 <USBD_GetDescriptor+0xda>
c0d02670:	88e8      	ldrh	r0, [r5, #6]
c0d02672:	2800      	cmp	r0, #0
c0d02674:	d007      	beq.n	c0d02686 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02676:	4282      	cmp	r2, r0
c0d02678:	d300      	bcc.n	c0d0267c <USBD_GetDescriptor+0xd0>
c0d0267a:	4602      	mov	r2, r0
c0d0267c:	a801      	add	r0, sp, #4
c0d0267e:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02680:	4620      	mov	r0, r4
c0d02682:	f000 faf9 	bl	c0d02c78 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02686:	b002      	add	sp, #8
c0d02688:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d0268a:	2011      	movs	r0, #17
c0d0268c:	0100      	lsls	r0, r0, #4
c0d0268e:	5820      	ldr	r0, [r4, r0]
c0d02690:	6880      	ldr	r0, [r0, #8]
c0d02692:	e7bb      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02694:	2011      	movs	r0, #17
c0d02696:	0100      	lsls	r0, r0, #4
c0d02698:	5820      	ldr	r0, [r4, r0]
c0d0269a:	68c0      	ldr	r0, [r0, #12]
c0d0269c:	e7b6      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d0269e:	2011      	movs	r0, #17
c0d026a0:	0100      	lsls	r0, r0, #4
c0d026a2:	5820      	ldr	r0, [r4, r0]
c0d026a4:	6900      	ldr	r0, [r0, #16]
c0d026a6:	e7b1      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d026a8:	2011      	movs	r0, #17
c0d026aa:	0100      	lsls	r0, r0, #4
c0d026ac:	5820      	ldr	r0, [r4, r0]
c0d026ae:	6940      	ldr	r0, [r0, #20]
c0d026b0:	e7ac      	b.n	c0d0260c <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d026b2:	2011      	movs	r0, #17
c0d026b4:	0100      	lsls	r0, r0, #4
c0d026b6:	5820      	ldr	r0, [r4, r0]
c0d026b8:	6980      	ldr	r0, [r0, #24]
c0d026ba:	e7a7      	b.n	c0d0260c <USBD_GetDescriptor+0x60>

c0d026bc <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d026bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026be:	af03      	add	r7, sp, #12
c0d026c0:	b081      	sub	sp, #4
c0d026c2:	460a      	mov	r2, r1
c0d026c4:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d026c6:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d026c8:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d026ca:	2800      	cmp	r0, #0
c0d026cc:	d10b      	bne.n	c0d026e6 <USBD_SetAddress+0x2a>
c0d026ce:	88d0      	ldrh	r0, [r2, #6]
c0d026d0:	2800      	cmp	r0, #0
c0d026d2:	d108      	bne.n	c0d026e6 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d026d4:	8850      	ldrh	r0, [r2, #2]
c0d026d6:	267f      	movs	r6, #127	; 0x7f
c0d026d8:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d026da:	20fc      	movs	r0, #252	; 0xfc
c0d026dc:	5c20      	ldrb	r0, [r4, r0]
c0d026de:	4625      	mov	r5, r4
c0d026e0:	35fc      	adds	r5, #252	; 0xfc
c0d026e2:	2803      	cmp	r0, #3
c0d026e4:	d108      	bne.n	c0d026f8 <USBD_SetAddress+0x3c>
c0d026e6:	4620      	mov	r0, r4
c0d026e8:	f7ff fd0a 	bl	c0d02100 <USBD_LL_StallEP>
c0d026ec:	2100      	movs	r1, #0
c0d026ee:	4620      	mov	r0, r4
c0d026f0:	f7ff fd06 	bl	c0d02100 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d026f4:	b001      	add	sp, #4
c0d026f6:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d026f8:	20fe      	movs	r0, #254	; 0xfe
c0d026fa:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d026fc:	b2f1      	uxtb	r1, r6
c0d026fe:	4620      	mov	r0, r4
c0d02700:	f7ff fd5c 	bl	c0d021bc <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02704:	4620      	mov	r0, r4
c0d02706:	f000 fae5 	bl	c0d02cd4 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d0270a:	2002      	movs	r0, #2
c0d0270c:	2101      	movs	r1, #1
c0d0270e:	2e00      	cmp	r6, #0
c0d02710:	d100      	bne.n	c0d02714 <USBD_SetAddress+0x58>
c0d02712:	4608      	mov	r0, r1
c0d02714:	7028      	strb	r0, [r5, #0]
c0d02716:	e7ed      	b.n	c0d026f4 <USBD_SetAddress+0x38>

c0d02718 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02718:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0271a:	af03      	add	r7, sp, #12
c0d0271c:	b081      	sub	sp, #4
c0d0271e:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02720:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02722:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02724:	2e02      	cmp	r6, #2
c0d02726:	d21d      	bcs.n	c0d02764 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02728:	20fc      	movs	r0, #252	; 0xfc
c0d0272a:	5c21      	ldrb	r1, [r4, r0]
c0d0272c:	4620      	mov	r0, r4
c0d0272e:	30fc      	adds	r0, #252	; 0xfc
c0d02730:	2903      	cmp	r1, #3
c0d02732:	d007      	beq.n	c0d02744 <USBD_SetConfig+0x2c>
c0d02734:	2902      	cmp	r1, #2
c0d02736:	d115      	bne.n	c0d02764 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02738:	2e00      	cmp	r6, #0
c0d0273a:	d026      	beq.n	c0d0278a <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d0273c:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d0273e:	2103      	movs	r1, #3
c0d02740:	7001      	strb	r1, [r0, #0]
c0d02742:	e009      	b.n	c0d02758 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02744:	2e00      	cmp	r6, #0
c0d02746:	d016      	beq.n	c0d02776 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02748:	6860      	ldr	r0, [r4, #4]
c0d0274a:	4286      	cmp	r6, r0
c0d0274c:	d01d      	beq.n	c0d0278a <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d0274e:	b2c1      	uxtb	r1, r0
c0d02750:	4620      	mov	r0, r4
c0d02752:	f7ff fdd3 	bl	c0d022fc <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02756:	6066      	str	r6, [r4, #4]
c0d02758:	4620      	mov	r0, r4
c0d0275a:	4631      	mov	r1, r6
c0d0275c:	f7ff fdb6 	bl	c0d022cc <USBD_SetClassConfig>
c0d02760:	2802      	cmp	r0, #2
c0d02762:	d112      	bne.n	c0d0278a <USBD_SetConfig+0x72>
c0d02764:	4620      	mov	r0, r4
c0d02766:	4629      	mov	r1, r5
c0d02768:	f7ff fcca 	bl	c0d02100 <USBD_LL_StallEP>
c0d0276c:	2100      	movs	r1, #0
c0d0276e:	4620      	mov	r0, r4
c0d02770:	f7ff fcc6 	bl	c0d02100 <USBD_LL_StallEP>
c0d02774:	e00c      	b.n	c0d02790 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02776:	2102      	movs	r1, #2
c0d02778:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d0277a:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d0277c:	4620      	mov	r0, r4
c0d0277e:	4631      	mov	r1, r6
c0d02780:	f7ff fdbc 	bl	c0d022fc <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02784:	4620      	mov	r0, r4
c0d02786:	f000 faa5 	bl	c0d02cd4 <USBD_CtlSendStatus>
c0d0278a:	4620      	mov	r0, r4
c0d0278c:	f000 faa2 	bl	c0d02cd4 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02790:	b001      	add	sp, #4
c0d02792:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02794 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02794:	b5d0      	push	{r4, r6, r7, lr}
c0d02796:	af02      	add	r7, sp, #8
c0d02798:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d0279a:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0279c:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d0279e:	2801      	cmp	r0, #1
c0d027a0:	d10a      	bne.n	c0d027b8 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d027a2:	20fc      	movs	r0, #252	; 0xfc
c0d027a4:	5c20      	ldrb	r0, [r4, r0]
c0d027a6:	2803      	cmp	r0, #3
c0d027a8:	d00e      	beq.n	c0d027c8 <USBD_GetConfig+0x34>
c0d027aa:	2802      	cmp	r0, #2
c0d027ac:	d104      	bne.n	c0d027b8 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d027ae:	2000      	movs	r0, #0
c0d027b0:	60a0      	str	r0, [r4, #8]
c0d027b2:	4621      	mov	r1, r4
c0d027b4:	3108      	adds	r1, #8
c0d027b6:	e008      	b.n	c0d027ca <USBD_GetConfig+0x36>
c0d027b8:	4620      	mov	r0, r4
c0d027ba:	f7ff fca1 	bl	c0d02100 <USBD_LL_StallEP>
c0d027be:	2100      	movs	r1, #0
c0d027c0:	4620      	mov	r0, r4
c0d027c2:	f7ff fc9d 	bl	c0d02100 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d027c6:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d027c8:	1d21      	adds	r1, r4, #4
c0d027ca:	2201      	movs	r2, #1
c0d027cc:	4620      	mov	r0, r4
c0d027ce:	f000 fa53 	bl	c0d02c78 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d027d2:	bdd0      	pop	{r4, r6, r7, pc}

c0d027d4 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d027d4:	b5b0      	push	{r4, r5, r7, lr}
c0d027d6:	af02      	add	r7, sp, #8
c0d027d8:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d027da:	20fc      	movs	r0, #252	; 0xfc
c0d027dc:	5c20      	ldrb	r0, [r4, r0]
c0d027de:	21fe      	movs	r1, #254	; 0xfe
c0d027e0:	4001      	ands	r1, r0
c0d027e2:	2902      	cmp	r1, #2
c0d027e4:	d116      	bne.n	c0d02814 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d027e6:	2001      	movs	r0, #1
c0d027e8:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d027ea:	2041      	movs	r0, #65	; 0x41
c0d027ec:	0080      	lsls	r0, r0, #2
c0d027ee:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d027f0:	4625      	mov	r5, r4
c0d027f2:	350c      	adds	r5, #12
c0d027f4:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d027f6:	2900      	cmp	r1, #0
c0d027f8:	d005      	beq.n	c0d02806 <USBD_GetStatus+0x32>
c0d027fa:	4620      	mov	r0, r4
c0d027fc:	f000 fa77 	bl	c0d02cee <USBD_CtlReceiveStatus>
c0d02800:	68e1      	ldr	r1, [r4, #12]
c0d02802:	2002      	movs	r0, #2
c0d02804:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02806:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02808:	2202      	movs	r2, #2
c0d0280a:	4620      	mov	r0, r4
c0d0280c:	4629      	mov	r1, r5
c0d0280e:	f000 fa33 	bl	c0d02c78 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02812:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02814:	2180      	movs	r1, #128	; 0x80
c0d02816:	4620      	mov	r0, r4
c0d02818:	f7ff fc72 	bl	c0d02100 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0281c:	2100      	movs	r1, #0
c0d0281e:	4620      	mov	r0, r4
c0d02820:	f7ff fc6e 	bl	c0d02100 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02824:	bdb0      	pop	{r4, r5, r7, pc}

c0d02826 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02826:	b5b0      	push	{r4, r5, r7, lr}
c0d02828:	af02      	add	r7, sp, #8
c0d0282a:	460d      	mov	r5, r1
c0d0282c:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d0282e:	8868      	ldrh	r0, [r5, #2]
c0d02830:	2801      	cmp	r0, #1
c0d02832:	d110      	bne.n	c0d02856 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02834:	2041      	movs	r0, #65	; 0x41
c0d02836:	0080      	lsls	r0, r0, #2
c0d02838:	2101      	movs	r1, #1
c0d0283a:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0283c:	2045      	movs	r0, #69	; 0x45
c0d0283e:	0080      	lsls	r0, r0, #2
c0d02840:	5820      	ldr	r0, [r4, r0]
c0d02842:	6880      	ldr	r0, [r0, #8]
c0d02844:	f7ff f846 	bl	c0d018d4 <pic>
c0d02848:	4602      	mov	r2, r0
c0d0284a:	4620      	mov	r0, r4
c0d0284c:	4629      	mov	r1, r5
c0d0284e:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02850:	4620      	mov	r0, r4
c0d02852:	f000 fa3f 	bl	c0d02cd4 <USBD_CtlSendStatus>
  }

}
c0d02856:	bdb0      	pop	{r4, r5, r7, pc}

c0d02858 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02858:	b5b0      	push	{r4, r5, r7, lr}
c0d0285a:	af02      	add	r7, sp, #8
c0d0285c:	460d      	mov	r5, r1
c0d0285e:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02860:	20fc      	movs	r0, #252	; 0xfc
c0d02862:	5c20      	ldrb	r0, [r4, r0]
c0d02864:	21fe      	movs	r1, #254	; 0xfe
c0d02866:	4001      	ands	r1, r0
c0d02868:	2902      	cmp	r1, #2
c0d0286a:	d114      	bne.n	c0d02896 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d0286c:	8868      	ldrh	r0, [r5, #2]
c0d0286e:	2801      	cmp	r0, #1
c0d02870:	d119      	bne.n	c0d028a6 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02872:	2041      	movs	r0, #65	; 0x41
c0d02874:	0080      	lsls	r0, r0, #2
c0d02876:	2100      	movs	r1, #0
c0d02878:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0287a:	2045      	movs	r0, #69	; 0x45
c0d0287c:	0080      	lsls	r0, r0, #2
c0d0287e:	5820      	ldr	r0, [r4, r0]
c0d02880:	6880      	ldr	r0, [r0, #8]
c0d02882:	f7ff f827 	bl	c0d018d4 <pic>
c0d02886:	4602      	mov	r2, r0
c0d02888:	4620      	mov	r0, r4
c0d0288a:	4629      	mov	r1, r5
c0d0288c:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d0288e:	4620      	mov	r0, r4
c0d02890:	f000 fa20 	bl	c0d02cd4 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02894:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02896:	2180      	movs	r1, #128	; 0x80
c0d02898:	4620      	mov	r0, r4
c0d0289a:	f7ff fc31 	bl	c0d02100 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0289e:	2100      	movs	r1, #0
c0d028a0:	4620      	mov	r0, r4
c0d028a2:	f7ff fc2d 	bl	c0d02100 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d028a6:	bdb0      	pop	{r4, r5, r7, pc}

c0d028a8 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d028a8:	b5d0      	push	{r4, r6, r7, lr}
c0d028aa:	af02      	add	r7, sp, #8
c0d028ac:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028ae:	2180      	movs	r1, #128	; 0x80
c0d028b0:	f7ff fc26 	bl	c0d02100 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d028b4:	2100      	movs	r1, #0
c0d028b6:	4620      	mov	r0, r4
c0d028b8:	f7ff fc22 	bl	c0d02100 <USBD_LL_StallEP>
}
c0d028bc:	bdd0      	pop	{r4, r6, r7, pc}

c0d028be <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d028be:	b5b0      	push	{r4, r5, r7, lr}
c0d028c0:	af02      	add	r7, sp, #8
c0d028c2:	460d      	mov	r5, r1
c0d028c4:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d028c6:	20fc      	movs	r0, #252	; 0xfc
c0d028c8:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d028ca:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d028cc:	2803      	cmp	r0, #3
c0d028ce:	d115      	bne.n	c0d028fc <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d028d0:	88a8      	ldrh	r0, [r5, #4]
c0d028d2:	22fe      	movs	r2, #254	; 0xfe
c0d028d4:	4002      	ands	r2, r0
c0d028d6:	2a01      	cmp	r2, #1
c0d028d8:	d810      	bhi.n	c0d028fc <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d028da:	2045      	movs	r0, #69	; 0x45
c0d028dc:	0080      	lsls	r0, r0, #2
c0d028de:	5820      	ldr	r0, [r4, r0]
c0d028e0:	6880      	ldr	r0, [r0, #8]
c0d028e2:	f7fe fff7 	bl	c0d018d4 <pic>
c0d028e6:	4602      	mov	r2, r0
c0d028e8:	4620      	mov	r0, r4
c0d028ea:	4629      	mov	r1, r5
c0d028ec:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d028ee:	88e8      	ldrh	r0, [r5, #6]
c0d028f0:	2800      	cmp	r0, #0
c0d028f2:	d10a      	bne.n	c0d0290a <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d028f4:	4620      	mov	r0, r4
c0d028f6:	f000 f9ed 	bl	c0d02cd4 <USBD_CtlSendStatus>
c0d028fa:	e006      	b.n	c0d0290a <USBD_StdItfReq+0x4c>
c0d028fc:	4620      	mov	r0, r4
c0d028fe:	f7ff fbff 	bl	c0d02100 <USBD_LL_StallEP>
c0d02902:	2100      	movs	r1, #0
c0d02904:	4620      	mov	r0, r4
c0d02906:	f7ff fbfb 	bl	c0d02100 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0290a:	2000      	movs	r0, #0
c0d0290c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0290e <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0290e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02910:	af03      	add	r7, sp, #12
c0d02912:	b081      	sub	sp, #4
c0d02914:	460e      	mov	r6, r1
c0d02916:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02918:	7830      	ldrb	r0, [r6, #0]
c0d0291a:	2160      	movs	r1, #96	; 0x60
c0d0291c:	4001      	ands	r1, r0
c0d0291e:	2920      	cmp	r1, #32
c0d02920:	d10a      	bne.n	c0d02938 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02922:	2045      	movs	r0, #69	; 0x45
c0d02924:	0080      	lsls	r0, r0, #2
c0d02926:	5820      	ldr	r0, [r4, r0]
c0d02928:	6880      	ldr	r0, [r0, #8]
c0d0292a:	f7fe ffd3 	bl	c0d018d4 <pic>
c0d0292e:	4602      	mov	r2, r0
c0d02930:	4620      	mov	r0, r4
c0d02932:	4631      	mov	r1, r6
c0d02934:	4790      	blx	r2
c0d02936:	e063      	b.n	c0d02a00 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02938:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0293a:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0293c:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0293e:	2800      	cmp	r0, #0
c0d02940:	d012      	beq.n	c0d02968 <USBD_StdEPReq+0x5a>
c0d02942:	2801      	cmp	r0, #1
c0d02944:	d019      	beq.n	c0d0297a <USBD_StdEPReq+0x6c>
c0d02946:	2803      	cmp	r0, #3
c0d02948:	d15a      	bne.n	c0d02a00 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0294a:	20fc      	movs	r0, #252	; 0xfc
c0d0294c:	5c20      	ldrb	r0, [r4, r0]
c0d0294e:	2803      	cmp	r0, #3
c0d02950:	d117      	bne.n	c0d02982 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02952:	8870      	ldrh	r0, [r6, #2]
c0d02954:	2800      	cmp	r0, #0
c0d02956:	d12d      	bne.n	c0d029b4 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02958:	4329      	orrs	r1, r5
c0d0295a:	2980      	cmp	r1, #128	; 0x80
c0d0295c:	d02a      	beq.n	c0d029b4 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d0295e:	4620      	mov	r0, r4
c0d02960:	4629      	mov	r1, r5
c0d02962:	f7ff fbcd 	bl	c0d02100 <USBD_LL_StallEP>
c0d02966:	e025      	b.n	c0d029b4 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02968:	20fc      	movs	r0, #252	; 0xfc
c0d0296a:	5c20      	ldrb	r0, [r4, r0]
c0d0296c:	2803      	cmp	r0, #3
c0d0296e:	d02f      	beq.n	c0d029d0 <USBD_StdEPReq+0xc2>
c0d02970:	2802      	cmp	r0, #2
c0d02972:	d10e      	bne.n	c0d02992 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02974:	0668      	lsls	r0, r5, #25
c0d02976:	d109      	bne.n	c0d0298c <USBD_StdEPReq+0x7e>
c0d02978:	e042      	b.n	c0d02a00 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0297a:	20fc      	movs	r0, #252	; 0xfc
c0d0297c:	5c20      	ldrb	r0, [r4, r0]
c0d0297e:	2803      	cmp	r0, #3
c0d02980:	d00f      	beq.n	c0d029a2 <USBD_StdEPReq+0x94>
c0d02982:	2802      	cmp	r0, #2
c0d02984:	d105      	bne.n	c0d02992 <USBD_StdEPReq+0x84>
c0d02986:	4329      	orrs	r1, r5
c0d02988:	2980      	cmp	r1, #128	; 0x80
c0d0298a:	d039      	beq.n	c0d02a00 <USBD_StdEPReq+0xf2>
c0d0298c:	4620      	mov	r0, r4
c0d0298e:	4629      	mov	r1, r5
c0d02990:	e004      	b.n	c0d0299c <USBD_StdEPReq+0x8e>
c0d02992:	4620      	mov	r0, r4
c0d02994:	f7ff fbb4 	bl	c0d02100 <USBD_LL_StallEP>
c0d02998:	2100      	movs	r1, #0
c0d0299a:	4620      	mov	r0, r4
c0d0299c:	f7ff fbb0 	bl	c0d02100 <USBD_LL_StallEP>
c0d029a0:	e02e      	b.n	c0d02a00 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d029a2:	8870      	ldrh	r0, [r6, #2]
c0d029a4:	2800      	cmp	r0, #0
c0d029a6:	d12b      	bne.n	c0d02a00 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d029a8:	0668      	lsls	r0, r5, #25
c0d029aa:	d00d      	beq.n	c0d029c8 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d029ac:	4620      	mov	r0, r4
c0d029ae:	4629      	mov	r1, r5
c0d029b0:	f7ff fbcc 	bl	c0d0214c <USBD_LL_ClearStallEP>
c0d029b4:	2045      	movs	r0, #69	; 0x45
c0d029b6:	0080      	lsls	r0, r0, #2
c0d029b8:	5820      	ldr	r0, [r4, r0]
c0d029ba:	6880      	ldr	r0, [r0, #8]
c0d029bc:	f7fe ff8a 	bl	c0d018d4 <pic>
c0d029c0:	4602      	mov	r2, r0
c0d029c2:	4620      	mov	r0, r4
c0d029c4:	4631      	mov	r1, r6
c0d029c6:	4790      	blx	r2
c0d029c8:	4620      	mov	r0, r4
c0d029ca:	f000 f983 	bl	c0d02cd4 <USBD_CtlSendStatus>
c0d029ce:	e017      	b.n	c0d02a00 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d029d0:	4626      	mov	r6, r4
c0d029d2:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d029d4:	4620      	mov	r0, r4
c0d029d6:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d029d8:	420d      	tst	r5, r1
c0d029da:	d100      	bne.n	c0d029de <USBD_StdEPReq+0xd0>
c0d029dc:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d029de:	4620      	mov	r0, r4
c0d029e0:	4629      	mov	r1, r5
c0d029e2:	f7ff fbd9 	bl	c0d02198 <USBD_LL_IsStallEP>
c0d029e6:	2101      	movs	r1, #1
c0d029e8:	2800      	cmp	r0, #0
c0d029ea:	d100      	bne.n	c0d029ee <USBD_StdEPReq+0xe0>
c0d029ec:	4601      	mov	r1, r0
c0d029ee:	207f      	movs	r0, #127	; 0x7f
c0d029f0:	4005      	ands	r5, r0
c0d029f2:	0128      	lsls	r0, r5, #4
c0d029f4:	5031      	str	r1, [r6, r0]
c0d029f6:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d029f8:	2202      	movs	r2, #2
c0d029fa:	4620      	mov	r0, r4
c0d029fc:	f000 f93c 	bl	c0d02c78 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d02a00:	2000      	movs	r0, #0
c0d02a02:	b001      	add	sp, #4
c0d02a04:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a06 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d02a06:	780a      	ldrb	r2, [r1, #0]
c0d02a08:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02a0a:	784a      	ldrb	r2, [r1, #1]
c0d02a0c:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02a0e:	788a      	ldrb	r2, [r1, #2]
c0d02a10:	78cb      	ldrb	r3, [r1, #3]
c0d02a12:	021b      	lsls	r3, r3, #8
c0d02a14:	4313      	orrs	r3, r2
c0d02a16:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02a18:	790a      	ldrb	r2, [r1, #4]
c0d02a1a:	794b      	ldrb	r3, [r1, #5]
c0d02a1c:	021b      	lsls	r3, r3, #8
c0d02a1e:	4313      	orrs	r3, r2
c0d02a20:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02a22:	798a      	ldrb	r2, [r1, #6]
c0d02a24:	79c9      	ldrb	r1, [r1, #7]
c0d02a26:	0209      	lsls	r1, r1, #8
c0d02a28:	4311      	orrs	r1, r2
c0d02a2a:	80c1      	strh	r1, [r0, #6]

}
c0d02a2c:	4770      	bx	lr

c0d02a2e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02a2e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a30:	af03      	add	r7, sp, #12
c0d02a32:	b083      	sub	sp, #12
c0d02a34:	460d      	mov	r5, r1
c0d02a36:	4604      	mov	r4, r0
c0d02a38:	a802      	add	r0, sp, #8
c0d02a3a:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d02a3c:	8006      	strh	r6, [r0, #0]
c0d02a3e:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02a40:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02a42:	7829      	ldrb	r1, [r5, #0]
c0d02a44:	2060      	movs	r0, #96	; 0x60
c0d02a46:	4008      	ands	r0, r1
c0d02a48:	2800      	cmp	r0, #0
c0d02a4a:	d010      	beq.n	c0d02a6e <USBD_HID_Setup+0x40>
c0d02a4c:	2820      	cmp	r0, #32
c0d02a4e:	d139      	bne.n	c0d02ac4 <USBD_HID_Setup+0x96>
c0d02a50:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02a52:	4601      	mov	r1, r0
c0d02a54:	390a      	subs	r1, #10
c0d02a56:	2902      	cmp	r1, #2
c0d02a58:	d334      	bcc.n	c0d02ac4 <USBD_HID_Setup+0x96>
c0d02a5a:	2802      	cmp	r0, #2
c0d02a5c:	d01c      	beq.n	c0d02a98 <USBD_HID_Setup+0x6a>
c0d02a5e:	2803      	cmp	r0, #3
c0d02a60:	d01a      	beq.n	c0d02a98 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02a62:	4620      	mov	r0, r4
c0d02a64:	4629      	mov	r1, r5
c0d02a66:	f7ff ff1f 	bl	c0d028a8 <USBD_CtlError>
c0d02a6a:	2602      	movs	r6, #2
c0d02a6c:	e02a      	b.n	c0d02ac4 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d02a6e:	7868      	ldrb	r0, [r5, #1]
c0d02a70:	280b      	cmp	r0, #11
c0d02a72:	d014      	beq.n	c0d02a9e <USBD_HID_Setup+0x70>
c0d02a74:	280a      	cmp	r0, #10
c0d02a76:	d00f      	beq.n	c0d02a98 <USBD_HID_Setup+0x6a>
c0d02a78:	2806      	cmp	r0, #6
c0d02a7a:	d123      	bne.n	c0d02ac4 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d02a7c:	8868      	ldrh	r0, [r5, #2]
c0d02a7e:	0a00      	lsrs	r0, r0, #8
c0d02a80:	2600      	movs	r6, #0
c0d02a82:	2821      	cmp	r0, #33	; 0x21
c0d02a84:	d00f      	beq.n	c0d02aa6 <USBD_HID_Setup+0x78>
c0d02a86:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02a88:	4632      	mov	r2, r6
c0d02a8a:	4631      	mov	r1, r6
c0d02a8c:	d117      	bne.n	c0d02abe <USBD_HID_Setup+0x90>
c0d02a8e:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02a90:	9000      	str	r0, [sp, #0]
c0d02a92:	f000 f847 	bl	c0d02b24 <USBD_HID_GetReportDescriptor_impl>
c0d02a96:	e00a      	b.n	c0d02aae <USBD_HID_Setup+0x80>
c0d02a98:	a901      	add	r1, sp, #4
c0d02a9a:	2201      	movs	r2, #1
c0d02a9c:	e00f      	b.n	c0d02abe <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d02a9e:	4620      	mov	r0, r4
c0d02aa0:	f000 f918 	bl	c0d02cd4 <USBD_CtlSendStatus>
c0d02aa4:	e00e      	b.n	c0d02ac4 <USBD_HID_Setup+0x96>
c0d02aa6:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02aa8:	9000      	str	r0, [sp, #0]
c0d02aaa:	f000 f833 	bl	c0d02b14 <USBD_HID_GetHidDescriptor_impl>
c0d02aae:	9b00      	ldr	r3, [sp, #0]
c0d02ab0:	4601      	mov	r1, r0
c0d02ab2:	881a      	ldrh	r2, [r3, #0]
c0d02ab4:	88e8      	ldrh	r0, [r5, #6]
c0d02ab6:	4282      	cmp	r2, r0
c0d02ab8:	d300      	bcc.n	c0d02abc <USBD_HID_Setup+0x8e>
c0d02aba:	4602      	mov	r2, r0
c0d02abc:	801a      	strh	r2, [r3, #0]
c0d02abe:	4620      	mov	r0, r4
c0d02ac0:	f000 f8da 	bl	c0d02c78 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02ac4:	b2f0      	uxtb	r0, r6
c0d02ac6:	b003      	add	sp, #12
c0d02ac8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02aca <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02aca:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02acc:	af03      	add	r7, sp, #12
c0d02ace:	b081      	sub	sp, #4
c0d02ad0:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02ad2:	2182      	movs	r1, #130	; 0x82
c0d02ad4:	2502      	movs	r5, #2
c0d02ad6:	2640      	movs	r6, #64	; 0x40
c0d02ad8:	462a      	mov	r2, r5
c0d02ada:	4633      	mov	r3, r6
c0d02adc:	f7ff fad0 	bl	c0d02080 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02ae0:	4620      	mov	r0, r4
c0d02ae2:	4629      	mov	r1, r5
c0d02ae4:	462a      	mov	r2, r5
c0d02ae6:	4633      	mov	r3, r6
c0d02ae8:	f7ff faca 	bl	c0d02080 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d02aec:	4620      	mov	r0, r4
c0d02aee:	4629      	mov	r1, r5
c0d02af0:	4632      	mov	r2, r6
c0d02af2:	f7ff fb90 	bl	c0d02216 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d02af6:	2000      	movs	r0, #0
c0d02af8:	b001      	add	sp, #4
c0d02afa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02afc <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d02afc:	b5d0      	push	{r4, r6, r7, lr}
c0d02afe:	af02      	add	r7, sp, #8
c0d02b00:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d02b02:	2182      	movs	r1, #130	; 0x82
c0d02b04:	f7ff fae4 	bl	c0d020d0 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d02b08:	2102      	movs	r1, #2
c0d02b0a:	4620      	mov	r0, r4
c0d02b0c:	f7ff fae0 	bl	c0d020d0 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02b10:	2000      	movs	r0, #0
c0d02b12:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b14 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02b14:	2109      	movs	r1, #9
c0d02b16:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02b18:	4801      	ldr	r0, [pc, #4]	; (c0d02b20 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d02b1a:	4478      	add	r0, pc
c0d02b1c:	4770      	bx	lr
c0d02b1e:	46c0      	nop			; (mov r8, r8)
c0d02b20:	00000a82 	.word	0x00000a82

c0d02b24 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02b24:	2122      	movs	r1, #34	; 0x22
c0d02b26:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02b28:	4801      	ldr	r0, [pc, #4]	; (c0d02b30 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d02b2a:	4478      	add	r0, pc
c0d02b2c:	4770      	bx	lr
c0d02b2e:	46c0      	nop			; (mov r8, r8)
c0d02b30:	00000a4d 	.word	0x00000a4d

c0d02b34 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02b34:	b5b0      	push	{r4, r5, r7, lr}
c0d02b36:	af02      	add	r7, sp, #8
c0d02b38:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d02b3a:	2102      	movs	r1, #2
c0d02b3c:	2240      	movs	r2, #64	; 0x40
c0d02b3e:	f7ff fb6a 	bl	c0d02216 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02b42:	4d0d      	ldr	r5, [pc, #52]	; (c0d02b78 <USBD_HID_DataOut_impl+0x44>)
c0d02b44:	7828      	ldrb	r0, [r5, #0]
c0d02b46:	2800      	cmp	r0, #0
c0d02b48:	d113      	bne.n	c0d02b72 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d02b4a:	2002      	movs	r0, #2
c0d02b4c:	f7fe f928 	bl	c0d00da0 <io_seproxyhal_get_ep_rx_size>
c0d02b50:	4602      	mov	r2, r0
c0d02b52:	480d      	ldr	r0, [pc, #52]	; (c0d02b88 <USBD_HID_DataOut_impl+0x54>)
c0d02b54:	4478      	add	r0, pc
c0d02b56:	4621      	mov	r1, r4
c0d02b58:	f7fd ff86 	bl	c0d00a68 <io_usb_hid_receive>
c0d02b5c:	2802      	cmp	r0, #2
c0d02b5e:	d108      	bne.n	c0d02b72 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02b60:	2001      	movs	r0, #1
c0d02b62:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02b64:	4805      	ldr	r0, [pc, #20]	; (c0d02b7c <USBD_HID_DataOut_impl+0x48>)
c0d02b66:	2107      	movs	r1, #7
c0d02b68:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d02b6a:	4805      	ldr	r0, [pc, #20]	; (c0d02b80 <USBD_HID_DataOut_impl+0x4c>)
c0d02b6c:	6800      	ldr	r0, [r0, #0]
c0d02b6e:	4905      	ldr	r1, [pc, #20]	; (c0d02b84 <USBD_HID_DataOut_impl+0x50>)
c0d02b70:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02b72:	2000      	movs	r0, #0
c0d02b74:	bdb0      	pop	{r4, r5, r7, pc}
c0d02b76:	46c0      	nop			; (mov r8, r8)
c0d02b78:	20001d10 	.word	0x20001d10
c0d02b7c:	20001d18 	.word	0x20001d18
c0d02b80:	20001c00 	.word	0x20001c00
c0d02b84:	20001d1c 	.word	0x20001d1c
c0d02b88:	ffffe3a1 	.word	0xffffe3a1

c0d02b8c <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d02b8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b8e:	af03      	add	r7, sp, #12
c0d02b90:	b081      	sub	sp, #4
c0d02b92:	4604      	mov	r4, r0
c0d02b94:	2049      	movs	r0, #73	; 0x49
c0d02b96:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02b98:	4810      	ldr	r0, [pc, #64]	; (c0d02bdc <USB_power+0x50>)
c0d02b9a:	2100      	movs	r1, #0
c0d02b9c:	462a      	mov	r2, r5
c0d02b9e:	f7fe f80f 	bl	c0d00bc0 <os_memset>

  if (enabled) {
c0d02ba2:	2c00      	cmp	r4, #0
c0d02ba4:	d015      	beq.n	c0d02bd2 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02ba6:	4c0d      	ldr	r4, [pc, #52]	; (c0d02bdc <USB_power+0x50>)
c0d02ba8:	2600      	movs	r6, #0
c0d02baa:	4620      	mov	r0, r4
c0d02bac:	4631      	mov	r1, r6
c0d02bae:	462a      	mov	r2, r5
c0d02bb0:	f7fe f806 	bl	c0d00bc0 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02bb4:	490a      	ldr	r1, [pc, #40]	; (c0d02be0 <USB_power+0x54>)
c0d02bb6:	4479      	add	r1, pc
c0d02bb8:	4620      	mov	r0, r4
c0d02bba:	4632      	mov	r2, r6
c0d02bbc:	f7ff fb3f 	bl	c0d0223e <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02bc0:	4908      	ldr	r1, [pc, #32]	; (c0d02be4 <USB_power+0x58>)
c0d02bc2:	4479      	add	r1, pc
c0d02bc4:	4620      	mov	r0, r4
c0d02bc6:	f7ff fb72 	bl	c0d022ae <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d02bca:	4620      	mov	r0, r4
c0d02bcc:	f7ff fb78 	bl	c0d022c0 <USBD_Start>
c0d02bd0:	e002      	b.n	c0d02bd8 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d02bd2:	4802      	ldr	r0, [pc, #8]	; (c0d02bdc <USB_power+0x50>)
c0d02bd4:	f7ff fb51 	bl	c0d0227a <USBD_DeInit>
  }
}
c0d02bd8:	b001      	add	sp, #4
c0d02bda:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02bdc:	20001d34 	.word	0x20001d34
c0d02be0:	00000a02 	.word	0x00000a02
c0d02be4:	00000a32 	.word	0x00000a32

c0d02be8 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d02be8:	2012      	movs	r0, #18
c0d02bea:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d02bec:	4801      	ldr	r0, [pc, #4]	; (c0d02bf4 <USBD_DeviceDescriptor+0xc>)
c0d02bee:	4478      	add	r0, pc
c0d02bf0:	4770      	bx	lr
c0d02bf2:	46c0      	nop			; (mov r8, r8)
c0d02bf4:	000009b7 	.word	0x000009b7

c0d02bf8 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d02bf8:	2004      	movs	r0, #4
c0d02bfa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d02bfc:	4801      	ldr	r0, [pc, #4]	; (c0d02c04 <USBD_LangIDStrDescriptor+0xc>)
c0d02bfe:	4478      	add	r0, pc
c0d02c00:	4770      	bx	lr
c0d02c02:	46c0      	nop			; (mov r8, r8)
c0d02c04:	000009da 	.word	0x000009da

c0d02c08 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d02c08:	200e      	movs	r0, #14
c0d02c0a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d02c0c:	4801      	ldr	r0, [pc, #4]	; (c0d02c14 <USBD_ManufacturerStrDescriptor+0xc>)
c0d02c0e:	4478      	add	r0, pc
c0d02c10:	4770      	bx	lr
c0d02c12:	46c0      	nop			; (mov r8, r8)
c0d02c14:	000009ce 	.word	0x000009ce

c0d02c18 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02c18:	200e      	movs	r0, #14
c0d02c1a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d02c1c:	4801      	ldr	r0, [pc, #4]	; (c0d02c24 <USBD_ProductStrDescriptor+0xc>)
c0d02c1e:	4478      	add	r0, pc
c0d02c20:	4770      	bx	lr
c0d02c22:	46c0      	nop			; (mov r8, r8)
c0d02c24:	0000094b 	.word	0x0000094b

c0d02c28 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02c28:	200a      	movs	r0, #10
c0d02c2a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d02c2c:	4801      	ldr	r0, [pc, #4]	; (c0d02c34 <USBD_SerialStrDescriptor+0xc>)
c0d02c2e:	4478      	add	r0, pc
c0d02c30:	4770      	bx	lr
c0d02c32:	46c0      	nop			; (mov r8, r8)
c0d02c34:	000009bc 	.word	0x000009bc

c0d02c38 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02c38:	200e      	movs	r0, #14
c0d02c3a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d02c3c:	4801      	ldr	r0, [pc, #4]	; (c0d02c44 <USBD_ConfigStrDescriptor+0xc>)
c0d02c3e:	4478      	add	r0, pc
c0d02c40:	4770      	bx	lr
c0d02c42:	46c0      	nop			; (mov r8, r8)
c0d02c44:	0000092b 	.word	0x0000092b

c0d02c48 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02c48:	200e      	movs	r0, #14
c0d02c4a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02c4c:	4801      	ldr	r0, [pc, #4]	; (c0d02c54 <USBD_InterfaceStrDescriptor+0xc>)
c0d02c4e:	4478      	add	r0, pc
c0d02c50:	4770      	bx	lr
c0d02c52:	46c0      	nop			; (mov r8, r8)
c0d02c54:	0000091b 	.word	0x0000091b

c0d02c58 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02c58:	2129      	movs	r1, #41	; 0x29
c0d02c5a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d02c5c:	4801      	ldr	r0, [pc, #4]	; (c0d02c64 <USBD_GetCfgDesc_impl+0xc>)
c0d02c5e:	4478      	add	r0, pc
c0d02c60:	4770      	bx	lr
c0d02c62:	46c0      	nop			; (mov r8, r8)
c0d02c64:	000009ce 	.word	0x000009ce

c0d02c68 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02c68:	210a      	movs	r1, #10
c0d02c6a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d02c6c:	4801      	ldr	r0, [pc, #4]	; (c0d02c74 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d02c6e:	4478      	add	r0, pc
c0d02c70:	4770      	bx	lr
c0d02c72:	46c0      	nop			; (mov r8, r8)
c0d02c74:	000009ea 	.word	0x000009ea

c0d02c78 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02c78:	b5b0      	push	{r4, r5, r7, lr}
c0d02c7a:	af02      	add	r7, sp, #8
c0d02c7c:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02c7e:	21f4      	movs	r1, #244	; 0xf4
c0d02c80:	2302      	movs	r3, #2
c0d02c82:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02c84:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02c86:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02c88:	2109      	movs	r1, #9
c0d02c8a:	0149      	lsls	r1, r1, #5
c0d02c8c:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d02c8e:	6a01      	ldr	r1, [r0, #32]
c0d02c90:	428a      	cmp	r2, r1
c0d02c92:	d300      	bcc.n	c0d02c96 <USBD_CtlSendData+0x1e>
c0d02c94:	460a      	mov	r2, r1
c0d02c96:	b293      	uxth	r3, r2
c0d02c98:	2500      	movs	r5, #0
c0d02c9a:	4629      	mov	r1, r5
c0d02c9c:	4622      	mov	r2, r4
c0d02c9e:	f7ff faa0 	bl	c0d021e2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02ca2:	4628      	mov	r0, r5
c0d02ca4:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ca6 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02ca6:	b5b0      	push	{r4, r5, r7, lr}
c0d02ca8:	af02      	add	r7, sp, #8
c0d02caa:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02cac:	6a01      	ldr	r1, [r0, #32]
c0d02cae:	428a      	cmp	r2, r1
c0d02cb0:	d300      	bcc.n	c0d02cb4 <USBD_CtlContinueSendData+0xe>
c0d02cb2:	460a      	mov	r2, r1
c0d02cb4:	b293      	uxth	r3, r2
c0d02cb6:	2500      	movs	r5, #0
c0d02cb8:	4629      	mov	r1, r5
c0d02cba:	4622      	mov	r2, r4
c0d02cbc:	f7ff fa91 	bl	c0d021e2 <USBD_LL_Transmit>
  return USBD_OK;
c0d02cc0:	4628      	mov	r0, r5
c0d02cc2:	bdb0      	pop	{r4, r5, r7, pc}

c0d02cc4 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02cc4:	b5d0      	push	{r4, r6, r7, lr}
c0d02cc6:	af02      	add	r7, sp, #8
c0d02cc8:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02cca:	4621      	mov	r1, r4
c0d02ccc:	f7ff faa3 	bl	c0d02216 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d02cd0:	4620      	mov	r0, r4
c0d02cd2:	bdd0      	pop	{r4, r6, r7, pc}

c0d02cd4 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d02cd4:	b5d0      	push	{r4, r6, r7, lr}
c0d02cd6:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02cd8:	21f4      	movs	r1, #244	; 0xf4
c0d02cda:	2204      	movs	r2, #4
c0d02cdc:	5042      	str	r2, [r0, r1]
c0d02cde:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02ce0:	4621      	mov	r1, r4
c0d02ce2:	4622      	mov	r2, r4
c0d02ce4:	4623      	mov	r3, r4
c0d02ce6:	f7ff fa7c 	bl	c0d021e2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02cea:	4620      	mov	r0, r4
c0d02cec:	bdd0      	pop	{r4, r6, r7, pc}

c0d02cee <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d02cee:	b5d0      	push	{r4, r6, r7, lr}
c0d02cf0:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d02cf2:	21f4      	movs	r1, #244	; 0xf4
c0d02cf4:	2205      	movs	r2, #5
c0d02cf6:	5042      	str	r2, [r0, r1]
c0d02cf8:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d02cfa:	4621      	mov	r1, r4
c0d02cfc:	4622      	mov	r2, r4
c0d02cfe:	f7ff fa8a 	bl	c0d02216 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d02d02:	4620      	mov	r0, r4
c0d02d04:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d08 <__aeabi_uidiv>:
c0d02d08:	2200      	movs	r2, #0
c0d02d0a:	0843      	lsrs	r3, r0, #1
c0d02d0c:	428b      	cmp	r3, r1
c0d02d0e:	d374      	bcc.n	c0d02dfa <__aeabi_uidiv+0xf2>
c0d02d10:	0903      	lsrs	r3, r0, #4
c0d02d12:	428b      	cmp	r3, r1
c0d02d14:	d35f      	bcc.n	c0d02dd6 <__aeabi_uidiv+0xce>
c0d02d16:	0a03      	lsrs	r3, r0, #8
c0d02d18:	428b      	cmp	r3, r1
c0d02d1a:	d344      	bcc.n	c0d02da6 <__aeabi_uidiv+0x9e>
c0d02d1c:	0b03      	lsrs	r3, r0, #12
c0d02d1e:	428b      	cmp	r3, r1
c0d02d20:	d328      	bcc.n	c0d02d74 <__aeabi_uidiv+0x6c>
c0d02d22:	0c03      	lsrs	r3, r0, #16
c0d02d24:	428b      	cmp	r3, r1
c0d02d26:	d30d      	bcc.n	c0d02d44 <__aeabi_uidiv+0x3c>
c0d02d28:	22ff      	movs	r2, #255	; 0xff
c0d02d2a:	0209      	lsls	r1, r1, #8
c0d02d2c:	ba12      	rev	r2, r2
c0d02d2e:	0c03      	lsrs	r3, r0, #16
c0d02d30:	428b      	cmp	r3, r1
c0d02d32:	d302      	bcc.n	c0d02d3a <__aeabi_uidiv+0x32>
c0d02d34:	1212      	asrs	r2, r2, #8
c0d02d36:	0209      	lsls	r1, r1, #8
c0d02d38:	d065      	beq.n	c0d02e06 <__aeabi_uidiv+0xfe>
c0d02d3a:	0b03      	lsrs	r3, r0, #12
c0d02d3c:	428b      	cmp	r3, r1
c0d02d3e:	d319      	bcc.n	c0d02d74 <__aeabi_uidiv+0x6c>
c0d02d40:	e000      	b.n	c0d02d44 <__aeabi_uidiv+0x3c>
c0d02d42:	0a09      	lsrs	r1, r1, #8
c0d02d44:	0bc3      	lsrs	r3, r0, #15
c0d02d46:	428b      	cmp	r3, r1
c0d02d48:	d301      	bcc.n	c0d02d4e <__aeabi_uidiv+0x46>
c0d02d4a:	03cb      	lsls	r3, r1, #15
c0d02d4c:	1ac0      	subs	r0, r0, r3
c0d02d4e:	4152      	adcs	r2, r2
c0d02d50:	0b83      	lsrs	r3, r0, #14
c0d02d52:	428b      	cmp	r3, r1
c0d02d54:	d301      	bcc.n	c0d02d5a <__aeabi_uidiv+0x52>
c0d02d56:	038b      	lsls	r3, r1, #14
c0d02d58:	1ac0      	subs	r0, r0, r3
c0d02d5a:	4152      	adcs	r2, r2
c0d02d5c:	0b43      	lsrs	r3, r0, #13
c0d02d5e:	428b      	cmp	r3, r1
c0d02d60:	d301      	bcc.n	c0d02d66 <__aeabi_uidiv+0x5e>
c0d02d62:	034b      	lsls	r3, r1, #13
c0d02d64:	1ac0      	subs	r0, r0, r3
c0d02d66:	4152      	adcs	r2, r2
c0d02d68:	0b03      	lsrs	r3, r0, #12
c0d02d6a:	428b      	cmp	r3, r1
c0d02d6c:	d301      	bcc.n	c0d02d72 <__aeabi_uidiv+0x6a>
c0d02d6e:	030b      	lsls	r3, r1, #12
c0d02d70:	1ac0      	subs	r0, r0, r3
c0d02d72:	4152      	adcs	r2, r2
c0d02d74:	0ac3      	lsrs	r3, r0, #11
c0d02d76:	428b      	cmp	r3, r1
c0d02d78:	d301      	bcc.n	c0d02d7e <__aeabi_uidiv+0x76>
c0d02d7a:	02cb      	lsls	r3, r1, #11
c0d02d7c:	1ac0      	subs	r0, r0, r3
c0d02d7e:	4152      	adcs	r2, r2
c0d02d80:	0a83      	lsrs	r3, r0, #10
c0d02d82:	428b      	cmp	r3, r1
c0d02d84:	d301      	bcc.n	c0d02d8a <__aeabi_uidiv+0x82>
c0d02d86:	028b      	lsls	r3, r1, #10
c0d02d88:	1ac0      	subs	r0, r0, r3
c0d02d8a:	4152      	adcs	r2, r2
c0d02d8c:	0a43      	lsrs	r3, r0, #9
c0d02d8e:	428b      	cmp	r3, r1
c0d02d90:	d301      	bcc.n	c0d02d96 <__aeabi_uidiv+0x8e>
c0d02d92:	024b      	lsls	r3, r1, #9
c0d02d94:	1ac0      	subs	r0, r0, r3
c0d02d96:	4152      	adcs	r2, r2
c0d02d98:	0a03      	lsrs	r3, r0, #8
c0d02d9a:	428b      	cmp	r3, r1
c0d02d9c:	d301      	bcc.n	c0d02da2 <__aeabi_uidiv+0x9a>
c0d02d9e:	020b      	lsls	r3, r1, #8
c0d02da0:	1ac0      	subs	r0, r0, r3
c0d02da2:	4152      	adcs	r2, r2
c0d02da4:	d2cd      	bcs.n	c0d02d42 <__aeabi_uidiv+0x3a>
c0d02da6:	09c3      	lsrs	r3, r0, #7
c0d02da8:	428b      	cmp	r3, r1
c0d02daa:	d301      	bcc.n	c0d02db0 <__aeabi_uidiv+0xa8>
c0d02dac:	01cb      	lsls	r3, r1, #7
c0d02dae:	1ac0      	subs	r0, r0, r3
c0d02db0:	4152      	adcs	r2, r2
c0d02db2:	0983      	lsrs	r3, r0, #6
c0d02db4:	428b      	cmp	r3, r1
c0d02db6:	d301      	bcc.n	c0d02dbc <__aeabi_uidiv+0xb4>
c0d02db8:	018b      	lsls	r3, r1, #6
c0d02dba:	1ac0      	subs	r0, r0, r3
c0d02dbc:	4152      	adcs	r2, r2
c0d02dbe:	0943      	lsrs	r3, r0, #5
c0d02dc0:	428b      	cmp	r3, r1
c0d02dc2:	d301      	bcc.n	c0d02dc8 <__aeabi_uidiv+0xc0>
c0d02dc4:	014b      	lsls	r3, r1, #5
c0d02dc6:	1ac0      	subs	r0, r0, r3
c0d02dc8:	4152      	adcs	r2, r2
c0d02dca:	0903      	lsrs	r3, r0, #4
c0d02dcc:	428b      	cmp	r3, r1
c0d02dce:	d301      	bcc.n	c0d02dd4 <__aeabi_uidiv+0xcc>
c0d02dd0:	010b      	lsls	r3, r1, #4
c0d02dd2:	1ac0      	subs	r0, r0, r3
c0d02dd4:	4152      	adcs	r2, r2
c0d02dd6:	08c3      	lsrs	r3, r0, #3
c0d02dd8:	428b      	cmp	r3, r1
c0d02dda:	d301      	bcc.n	c0d02de0 <__aeabi_uidiv+0xd8>
c0d02ddc:	00cb      	lsls	r3, r1, #3
c0d02dde:	1ac0      	subs	r0, r0, r3
c0d02de0:	4152      	adcs	r2, r2
c0d02de2:	0883      	lsrs	r3, r0, #2
c0d02de4:	428b      	cmp	r3, r1
c0d02de6:	d301      	bcc.n	c0d02dec <__aeabi_uidiv+0xe4>
c0d02de8:	008b      	lsls	r3, r1, #2
c0d02dea:	1ac0      	subs	r0, r0, r3
c0d02dec:	4152      	adcs	r2, r2
c0d02dee:	0843      	lsrs	r3, r0, #1
c0d02df0:	428b      	cmp	r3, r1
c0d02df2:	d301      	bcc.n	c0d02df8 <__aeabi_uidiv+0xf0>
c0d02df4:	004b      	lsls	r3, r1, #1
c0d02df6:	1ac0      	subs	r0, r0, r3
c0d02df8:	4152      	adcs	r2, r2
c0d02dfa:	1a41      	subs	r1, r0, r1
c0d02dfc:	d200      	bcs.n	c0d02e00 <__aeabi_uidiv+0xf8>
c0d02dfe:	4601      	mov	r1, r0
c0d02e00:	4152      	adcs	r2, r2
c0d02e02:	4610      	mov	r0, r2
c0d02e04:	4770      	bx	lr
c0d02e06:	e7ff      	b.n	c0d02e08 <__aeabi_uidiv+0x100>
c0d02e08:	b501      	push	{r0, lr}
c0d02e0a:	2000      	movs	r0, #0
c0d02e0c:	f000 f8f0 	bl	c0d02ff0 <__aeabi_idiv0>
c0d02e10:	bd02      	pop	{r1, pc}
c0d02e12:	46c0      	nop			; (mov r8, r8)

c0d02e14 <__aeabi_uidivmod>:
c0d02e14:	2900      	cmp	r1, #0
c0d02e16:	d0f7      	beq.n	c0d02e08 <__aeabi_uidiv+0x100>
c0d02e18:	e776      	b.n	c0d02d08 <__aeabi_uidiv>
c0d02e1a:	4770      	bx	lr

c0d02e1c <__aeabi_idiv>:
c0d02e1c:	4603      	mov	r3, r0
c0d02e1e:	430b      	orrs	r3, r1
c0d02e20:	d47f      	bmi.n	c0d02f22 <__aeabi_idiv+0x106>
c0d02e22:	2200      	movs	r2, #0
c0d02e24:	0843      	lsrs	r3, r0, #1
c0d02e26:	428b      	cmp	r3, r1
c0d02e28:	d374      	bcc.n	c0d02f14 <__aeabi_idiv+0xf8>
c0d02e2a:	0903      	lsrs	r3, r0, #4
c0d02e2c:	428b      	cmp	r3, r1
c0d02e2e:	d35f      	bcc.n	c0d02ef0 <__aeabi_idiv+0xd4>
c0d02e30:	0a03      	lsrs	r3, r0, #8
c0d02e32:	428b      	cmp	r3, r1
c0d02e34:	d344      	bcc.n	c0d02ec0 <__aeabi_idiv+0xa4>
c0d02e36:	0b03      	lsrs	r3, r0, #12
c0d02e38:	428b      	cmp	r3, r1
c0d02e3a:	d328      	bcc.n	c0d02e8e <__aeabi_idiv+0x72>
c0d02e3c:	0c03      	lsrs	r3, r0, #16
c0d02e3e:	428b      	cmp	r3, r1
c0d02e40:	d30d      	bcc.n	c0d02e5e <__aeabi_idiv+0x42>
c0d02e42:	22ff      	movs	r2, #255	; 0xff
c0d02e44:	0209      	lsls	r1, r1, #8
c0d02e46:	ba12      	rev	r2, r2
c0d02e48:	0c03      	lsrs	r3, r0, #16
c0d02e4a:	428b      	cmp	r3, r1
c0d02e4c:	d302      	bcc.n	c0d02e54 <__aeabi_idiv+0x38>
c0d02e4e:	1212      	asrs	r2, r2, #8
c0d02e50:	0209      	lsls	r1, r1, #8
c0d02e52:	d065      	beq.n	c0d02f20 <__aeabi_idiv+0x104>
c0d02e54:	0b03      	lsrs	r3, r0, #12
c0d02e56:	428b      	cmp	r3, r1
c0d02e58:	d319      	bcc.n	c0d02e8e <__aeabi_idiv+0x72>
c0d02e5a:	e000      	b.n	c0d02e5e <__aeabi_idiv+0x42>
c0d02e5c:	0a09      	lsrs	r1, r1, #8
c0d02e5e:	0bc3      	lsrs	r3, r0, #15
c0d02e60:	428b      	cmp	r3, r1
c0d02e62:	d301      	bcc.n	c0d02e68 <__aeabi_idiv+0x4c>
c0d02e64:	03cb      	lsls	r3, r1, #15
c0d02e66:	1ac0      	subs	r0, r0, r3
c0d02e68:	4152      	adcs	r2, r2
c0d02e6a:	0b83      	lsrs	r3, r0, #14
c0d02e6c:	428b      	cmp	r3, r1
c0d02e6e:	d301      	bcc.n	c0d02e74 <__aeabi_idiv+0x58>
c0d02e70:	038b      	lsls	r3, r1, #14
c0d02e72:	1ac0      	subs	r0, r0, r3
c0d02e74:	4152      	adcs	r2, r2
c0d02e76:	0b43      	lsrs	r3, r0, #13
c0d02e78:	428b      	cmp	r3, r1
c0d02e7a:	d301      	bcc.n	c0d02e80 <__aeabi_idiv+0x64>
c0d02e7c:	034b      	lsls	r3, r1, #13
c0d02e7e:	1ac0      	subs	r0, r0, r3
c0d02e80:	4152      	adcs	r2, r2
c0d02e82:	0b03      	lsrs	r3, r0, #12
c0d02e84:	428b      	cmp	r3, r1
c0d02e86:	d301      	bcc.n	c0d02e8c <__aeabi_idiv+0x70>
c0d02e88:	030b      	lsls	r3, r1, #12
c0d02e8a:	1ac0      	subs	r0, r0, r3
c0d02e8c:	4152      	adcs	r2, r2
c0d02e8e:	0ac3      	lsrs	r3, r0, #11
c0d02e90:	428b      	cmp	r3, r1
c0d02e92:	d301      	bcc.n	c0d02e98 <__aeabi_idiv+0x7c>
c0d02e94:	02cb      	lsls	r3, r1, #11
c0d02e96:	1ac0      	subs	r0, r0, r3
c0d02e98:	4152      	adcs	r2, r2
c0d02e9a:	0a83      	lsrs	r3, r0, #10
c0d02e9c:	428b      	cmp	r3, r1
c0d02e9e:	d301      	bcc.n	c0d02ea4 <__aeabi_idiv+0x88>
c0d02ea0:	028b      	lsls	r3, r1, #10
c0d02ea2:	1ac0      	subs	r0, r0, r3
c0d02ea4:	4152      	adcs	r2, r2
c0d02ea6:	0a43      	lsrs	r3, r0, #9
c0d02ea8:	428b      	cmp	r3, r1
c0d02eaa:	d301      	bcc.n	c0d02eb0 <__aeabi_idiv+0x94>
c0d02eac:	024b      	lsls	r3, r1, #9
c0d02eae:	1ac0      	subs	r0, r0, r3
c0d02eb0:	4152      	adcs	r2, r2
c0d02eb2:	0a03      	lsrs	r3, r0, #8
c0d02eb4:	428b      	cmp	r3, r1
c0d02eb6:	d301      	bcc.n	c0d02ebc <__aeabi_idiv+0xa0>
c0d02eb8:	020b      	lsls	r3, r1, #8
c0d02eba:	1ac0      	subs	r0, r0, r3
c0d02ebc:	4152      	adcs	r2, r2
c0d02ebe:	d2cd      	bcs.n	c0d02e5c <__aeabi_idiv+0x40>
c0d02ec0:	09c3      	lsrs	r3, r0, #7
c0d02ec2:	428b      	cmp	r3, r1
c0d02ec4:	d301      	bcc.n	c0d02eca <__aeabi_idiv+0xae>
c0d02ec6:	01cb      	lsls	r3, r1, #7
c0d02ec8:	1ac0      	subs	r0, r0, r3
c0d02eca:	4152      	adcs	r2, r2
c0d02ecc:	0983      	lsrs	r3, r0, #6
c0d02ece:	428b      	cmp	r3, r1
c0d02ed0:	d301      	bcc.n	c0d02ed6 <__aeabi_idiv+0xba>
c0d02ed2:	018b      	lsls	r3, r1, #6
c0d02ed4:	1ac0      	subs	r0, r0, r3
c0d02ed6:	4152      	adcs	r2, r2
c0d02ed8:	0943      	lsrs	r3, r0, #5
c0d02eda:	428b      	cmp	r3, r1
c0d02edc:	d301      	bcc.n	c0d02ee2 <__aeabi_idiv+0xc6>
c0d02ede:	014b      	lsls	r3, r1, #5
c0d02ee0:	1ac0      	subs	r0, r0, r3
c0d02ee2:	4152      	adcs	r2, r2
c0d02ee4:	0903      	lsrs	r3, r0, #4
c0d02ee6:	428b      	cmp	r3, r1
c0d02ee8:	d301      	bcc.n	c0d02eee <__aeabi_idiv+0xd2>
c0d02eea:	010b      	lsls	r3, r1, #4
c0d02eec:	1ac0      	subs	r0, r0, r3
c0d02eee:	4152      	adcs	r2, r2
c0d02ef0:	08c3      	lsrs	r3, r0, #3
c0d02ef2:	428b      	cmp	r3, r1
c0d02ef4:	d301      	bcc.n	c0d02efa <__aeabi_idiv+0xde>
c0d02ef6:	00cb      	lsls	r3, r1, #3
c0d02ef8:	1ac0      	subs	r0, r0, r3
c0d02efa:	4152      	adcs	r2, r2
c0d02efc:	0883      	lsrs	r3, r0, #2
c0d02efe:	428b      	cmp	r3, r1
c0d02f00:	d301      	bcc.n	c0d02f06 <__aeabi_idiv+0xea>
c0d02f02:	008b      	lsls	r3, r1, #2
c0d02f04:	1ac0      	subs	r0, r0, r3
c0d02f06:	4152      	adcs	r2, r2
c0d02f08:	0843      	lsrs	r3, r0, #1
c0d02f0a:	428b      	cmp	r3, r1
c0d02f0c:	d301      	bcc.n	c0d02f12 <__aeabi_idiv+0xf6>
c0d02f0e:	004b      	lsls	r3, r1, #1
c0d02f10:	1ac0      	subs	r0, r0, r3
c0d02f12:	4152      	adcs	r2, r2
c0d02f14:	1a41      	subs	r1, r0, r1
c0d02f16:	d200      	bcs.n	c0d02f1a <__aeabi_idiv+0xfe>
c0d02f18:	4601      	mov	r1, r0
c0d02f1a:	4152      	adcs	r2, r2
c0d02f1c:	4610      	mov	r0, r2
c0d02f1e:	4770      	bx	lr
c0d02f20:	e05d      	b.n	c0d02fde <__aeabi_idiv+0x1c2>
c0d02f22:	0fca      	lsrs	r2, r1, #31
c0d02f24:	d000      	beq.n	c0d02f28 <__aeabi_idiv+0x10c>
c0d02f26:	4249      	negs	r1, r1
c0d02f28:	1003      	asrs	r3, r0, #32
c0d02f2a:	d300      	bcc.n	c0d02f2e <__aeabi_idiv+0x112>
c0d02f2c:	4240      	negs	r0, r0
c0d02f2e:	4053      	eors	r3, r2
c0d02f30:	2200      	movs	r2, #0
c0d02f32:	469c      	mov	ip, r3
c0d02f34:	0903      	lsrs	r3, r0, #4
c0d02f36:	428b      	cmp	r3, r1
c0d02f38:	d32d      	bcc.n	c0d02f96 <__aeabi_idiv+0x17a>
c0d02f3a:	0a03      	lsrs	r3, r0, #8
c0d02f3c:	428b      	cmp	r3, r1
c0d02f3e:	d312      	bcc.n	c0d02f66 <__aeabi_idiv+0x14a>
c0d02f40:	22fc      	movs	r2, #252	; 0xfc
c0d02f42:	0189      	lsls	r1, r1, #6
c0d02f44:	ba12      	rev	r2, r2
c0d02f46:	0a03      	lsrs	r3, r0, #8
c0d02f48:	428b      	cmp	r3, r1
c0d02f4a:	d30c      	bcc.n	c0d02f66 <__aeabi_idiv+0x14a>
c0d02f4c:	0189      	lsls	r1, r1, #6
c0d02f4e:	1192      	asrs	r2, r2, #6
c0d02f50:	428b      	cmp	r3, r1
c0d02f52:	d308      	bcc.n	c0d02f66 <__aeabi_idiv+0x14a>
c0d02f54:	0189      	lsls	r1, r1, #6
c0d02f56:	1192      	asrs	r2, r2, #6
c0d02f58:	428b      	cmp	r3, r1
c0d02f5a:	d304      	bcc.n	c0d02f66 <__aeabi_idiv+0x14a>
c0d02f5c:	0189      	lsls	r1, r1, #6
c0d02f5e:	d03a      	beq.n	c0d02fd6 <__aeabi_idiv+0x1ba>
c0d02f60:	1192      	asrs	r2, r2, #6
c0d02f62:	e000      	b.n	c0d02f66 <__aeabi_idiv+0x14a>
c0d02f64:	0989      	lsrs	r1, r1, #6
c0d02f66:	09c3      	lsrs	r3, r0, #7
c0d02f68:	428b      	cmp	r3, r1
c0d02f6a:	d301      	bcc.n	c0d02f70 <__aeabi_idiv+0x154>
c0d02f6c:	01cb      	lsls	r3, r1, #7
c0d02f6e:	1ac0      	subs	r0, r0, r3
c0d02f70:	4152      	adcs	r2, r2
c0d02f72:	0983      	lsrs	r3, r0, #6
c0d02f74:	428b      	cmp	r3, r1
c0d02f76:	d301      	bcc.n	c0d02f7c <__aeabi_idiv+0x160>
c0d02f78:	018b      	lsls	r3, r1, #6
c0d02f7a:	1ac0      	subs	r0, r0, r3
c0d02f7c:	4152      	adcs	r2, r2
c0d02f7e:	0943      	lsrs	r3, r0, #5
c0d02f80:	428b      	cmp	r3, r1
c0d02f82:	d301      	bcc.n	c0d02f88 <__aeabi_idiv+0x16c>
c0d02f84:	014b      	lsls	r3, r1, #5
c0d02f86:	1ac0      	subs	r0, r0, r3
c0d02f88:	4152      	adcs	r2, r2
c0d02f8a:	0903      	lsrs	r3, r0, #4
c0d02f8c:	428b      	cmp	r3, r1
c0d02f8e:	d301      	bcc.n	c0d02f94 <__aeabi_idiv+0x178>
c0d02f90:	010b      	lsls	r3, r1, #4
c0d02f92:	1ac0      	subs	r0, r0, r3
c0d02f94:	4152      	adcs	r2, r2
c0d02f96:	08c3      	lsrs	r3, r0, #3
c0d02f98:	428b      	cmp	r3, r1
c0d02f9a:	d301      	bcc.n	c0d02fa0 <__aeabi_idiv+0x184>
c0d02f9c:	00cb      	lsls	r3, r1, #3
c0d02f9e:	1ac0      	subs	r0, r0, r3
c0d02fa0:	4152      	adcs	r2, r2
c0d02fa2:	0883      	lsrs	r3, r0, #2
c0d02fa4:	428b      	cmp	r3, r1
c0d02fa6:	d301      	bcc.n	c0d02fac <__aeabi_idiv+0x190>
c0d02fa8:	008b      	lsls	r3, r1, #2
c0d02faa:	1ac0      	subs	r0, r0, r3
c0d02fac:	4152      	adcs	r2, r2
c0d02fae:	d2d9      	bcs.n	c0d02f64 <__aeabi_idiv+0x148>
c0d02fb0:	0843      	lsrs	r3, r0, #1
c0d02fb2:	428b      	cmp	r3, r1
c0d02fb4:	d301      	bcc.n	c0d02fba <__aeabi_idiv+0x19e>
c0d02fb6:	004b      	lsls	r3, r1, #1
c0d02fb8:	1ac0      	subs	r0, r0, r3
c0d02fba:	4152      	adcs	r2, r2
c0d02fbc:	1a41      	subs	r1, r0, r1
c0d02fbe:	d200      	bcs.n	c0d02fc2 <__aeabi_idiv+0x1a6>
c0d02fc0:	4601      	mov	r1, r0
c0d02fc2:	4663      	mov	r3, ip
c0d02fc4:	4152      	adcs	r2, r2
c0d02fc6:	105b      	asrs	r3, r3, #1
c0d02fc8:	4610      	mov	r0, r2
c0d02fca:	d301      	bcc.n	c0d02fd0 <__aeabi_idiv+0x1b4>
c0d02fcc:	4240      	negs	r0, r0
c0d02fce:	2b00      	cmp	r3, #0
c0d02fd0:	d500      	bpl.n	c0d02fd4 <__aeabi_idiv+0x1b8>
c0d02fd2:	4249      	negs	r1, r1
c0d02fd4:	4770      	bx	lr
c0d02fd6:	4663      	mov	r3, ip
c0d02fd8:	105b      	asrs	r3, r3, #1
c0d02fda:	d300      	bcc.n	c0d02fde <__aeabi_idiv+0x1c2>
c0d02fdc:	4240      	negs	r0, r0
c0d02fde:	b501      	push	{r0, lr}
c0d02fe0:	2000      	movs	r0, #0
c0d02fe2:	f000 f805 	bl	c0d02ff0 <__aeabi_idiv0>
c0d02fe6:	bd02      	pop	{r1, pc}

c0d02fe8 <__aeabi_idivmod>:
c0d02fe8:	2900      	cmp	r1, #0
c0d02fea:	d0f8      	beq.n	c0d02fde <__aeabi_idiv+0x1c2>
c0d02fec:	e716      	b.n	c0d02e1c <__aeabi_idiv>
c0d02fee:	4770      	bx	lr

c0d02ff0 <__aeabi_idiv0>:
c0d02ff0:	4770      	bx	lr
c0d02ff2:	46c0      	nop			; (mov r8, r8)

c0d02ff4 <__aeabi_lmul>:
c0d02ff4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ff6:	464f      	mov	r7, r9
c0d02ff8:	4646      	mov	r6, r8
c0d02ffa:	b4c0      	push	{r6, r7}
c0d02ffc:	0416      	lsls	r6, r2, #16
c0d02ffe:	0c36      	lsrs	r6, r6, #16
c0d03000:	4699      	mov	r9, r3
c0d03002:	0033      	movs	r3, r6
c0d03004:	0405      	lsls	r5, r0, #16
c0d03006:	0c2c      	lsrs	r4, r5, #16
c0d03008:	0c07      	lsrs	r7, r0, #16
c0d0300a:	0c15      	lsrs	r5, r2, #16
c0d0300c:	4363      	muls	r3, r4
c0d0300e:	437e      	muls	r6, r7
c0d03010:	436f      	muls	r7, r5
c0d03012:	4365      	muls	r5, r4
c0d03014:	0c1c      	lsrs	r4, r3, #16
c0d03016:	19ad      	adds	r5, r5, r6
c0d03018:	1964      	adds	r4, r4, r5
c0d0301a:	469c      	mov	ip, r3
c0d0301c:	42a6      	cmp	r6, r4
c0d0301e:	d903      	bls.n	c0d03028 <__aeabi_lmul+0x34>
c0d03020:	2380      	movs	r3, #128	; 0x80
c0d03022:	025b      	lsls	r3, r3, #9
c0d03024:	4698      	mov	r8, r3
c0d03026:	4447      	add	r7, r8
c0d03028:	4663      	mov	r3, ip
c0d0302a:	0c25      	lsrs	r5, r4, #16
c0d0302c:	19ef      	adds	r7, r5, r7
c0d0302e:	041d      	lsls	r5, r3, #16
c0d03030:	464b      	mov	r3, r9
c0d03032:	434a      	muls	r2, r1
c0d03034:	4343      	muls	r3, r0
c0d03036:	0c2d      	lsrs	r5, r5, #16
c0d03038:	0424      	lsls	r4, r4, #16
c0d0303a:	1964      	adds	r4, r4, r5
c0d0303c:	1899      	adds	r1, r3, r2
c0d0303e:	19c9      	adds	r1, r1, r7
c0d03040:	0020      	movs	r0, r4
c0d03042:	bc0c      	pop	{r2, r3}
c0d03044:	4690      	mov	r8, r2
c0d03046:	4699      	mov	r9, r3
c0d03048:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0304a:	46c0      	nop			; (mov r8, r8)

c0d0304c <__aeabi_memclr>:
c0d0304c:	b510      	push	{r4, lr}
c0d0304e:	2200      	movs	r2, #0
c0d03050:	f000 f806 	bl	c0d03060 <__aeabi_memset>
c0d03054:	bd10      	pop	{r4, pc}
c0d03056:	46c0      	nop			; (mov r8, r8)

c0d03058 <__aeabi_memcpy>:
c0d03058:	b510      	push	{r4, lr}
c0d0305a:	f000 f809 	bl	c0d03070 <memcpy>
c0d0305e:	bd10      	pop	{r4, pc}

c0d03060 <__aeabi_memset>:
c0d03060:	0013      	movs	r3, r2
c0d03062:	b510      	push	{r4, lr}
c0d03064:	000a      	movs	r2, r1
c0d03066:	0019      	movs	r1, r3
c0d03068:	f000 f840 	bl	c0d030ec <memset>
c0d0306c:	bd10      	pop	{r4, pc}
c0d0306e:	46c0      	nop			; (mov r8, r8)

c0d03070 <memcpy>:
c0d03070:	b570      	push	{r4, r5, r6, lr}
c0d03072:	2a0f      	cmp	r2, #15
c0d03074:	d932      	bls.n	c0d030dc <memcpy+0x6c>
c0d03076:	000c      	movs	r4, r1
c0d03078:	4304      	orrs	r4, r0
c0d0307a:	000b      	movs	r3, r1
c0d0307c:	07a4      	lsls	r4, r4, #30
c0d0307e:	d131      	bne.n	c0d030e4 <memcpy+0x74>
c0d03080:	0015      	movs	r5, r2
c0d03082:	0004      	movs	r4, r0
c0d03084:	3d10      	subs	r5, #16
c0d03086:	092d      	lsrs	r5, r5, #4
c0d03088:	3501      	adds	r5, #1
c0d0308a:	012d      	lsls	r5, r5, #4
c0d0308c:	1949      	adds	r1, r1, r5
c0d0308e:	681e      	ldr	r6, [r3, #0]
c0d03090:	6026      	str	r6, [r4, #0]
c0d03092:	685e      	ldr	r6, [r3, #4]
c0d03094:	6066      	str	r6, [r4, #4]
c0d03096:	689e      	ldr	r6, [r3, #8]
c0d03098:	60a6      	str	r6, [r4, #8]
c0d0309a:	68de      	ldr	r6, [r3, #12]
c0d0309c:	3310      	adds	r3, #16
c0d0309e:	60e6      	str	r6, [r4, #12]
c0d030a0:	3410      	adds	r4, #16
c0d030a2:	4299      	cmp	r1, r3
c0d030a4:	d1f3      	bne.n	c0d0308e <memcpy+0x1e>
c0d030a6:	230f      	movs	r3, #15
c0d030a8:	1945      	adds	r5, r0, r5
c0d030aa:	4013      	ands	r3, r2
c0d030ac:	2b03      	cmp	r3, #3
c0d030ae:	d91b      	bls.n	c0d030e8 <memcpy+0x78>
c0d030b0:	1f1c      	subs	r4, r3, #4
c0d030b2:	2300      	movs	r3, #0
c0d030b4:	08a4      	lsrs	r4, r4, #2
c0d030b6:	3401      	adds	r4, #1
c0d030b8:	00a4      	lsls	r4, r4, #2
c0d030ba:	58ce      	ldr	r6, [r1, r3]
c0d030bc:	50ee      	str	r6, [r5, r3]
c0d030be:	3304      	adds	r3, #4
c0d030c0:	429c      	cmp	r4, r3
c0d030c2:	d1fa      	bne.n	c0d030ba <memcpy+0x4a>
c0d030c4:	2303      	movs	r3, #3
c0d030c6:	192d      	adds	r5, r5, r4
c0d030c8:	1909      	adds	r1, r1, r4
c0d030ca:	401a      	ands	r2, r3
c0d030cc:	d005      	beq.n	c0d030da <memcpy+0x6a>
c0d030ce:	2300      	movs	r3, #0
c0d030d0:	5ccc      	ldrb	r4, [r1, r3]
c0d030d2:	54ec      	strb	r4, [r5, r3]
c0d030d4:	3301      	adds	r3, #1
c0d030d6:	429a      	cmp	r2, r3
c0d030d8:	d1fa      	bne.n	c0d030d0 <memcpy+0x60>
c0d030da:	bd70      	pop	{r4, r5, r6, pc}
c0d030dc:	0005      	movs	r5, r0
c0d030de:	2a00      	cmp	r2, #0
c0d030e0:	d1f5      	bne.n	c0d030ce <memcpy+0x5e>
c0d030e2:	e7fa      	b.n	c0d030da <memcpy+0x6a>
c0d030e4:	0005      	movs	r5, r0
c0d030e6:	e7f2      	b.n	c0d030ce <memcpy+0x5e>
c0d030e8:	001a      	movs	r2, r3
c0d030ea:	e7f8      	b.n	c0d030de <memcpy+0x6e>

c0d030ec <memset>:
c0d030ec:	b570      	push	{r4, r5, r6, lr}
c0d030ee:	0783      	lsls	r3, r0, #30
c0d030f0:	d03f      	beq.n	c0d03172 <memset+0x86>
c0d030f2:	1e54      	subs	r4, r2, #1
c0d030f4:	2a00      	cmp	r2, #0
c0d030f6:	d03b      	beq.n	c0d03170 <memset+0x84>
c0d030f8:	b2ce      	uxtb	r6, r1
c0d030fa:	0003      	movs	r3, r0
c0d030fc:	2503      	movs	r5, #3
c0d030fe:	e003      	b.n	c0d03108 <memset+0x1c>
c0d03100:	1e62      	subs	r2, r4, #1
c0d03102:	2c00      	cmp	r4, #0
c0d03104:	d034      	beq.n	c0d03170 <memset+0x84>
c0d03106:	0014      	movs	r4, r2
c0d03108:	3301      	adds	r3, #1
c0d0310a:	1e5a      	subs	r2, r3, #1
c0d0310c:	7016      	strb	r6, [r2, #0]
c0d0310e:	422b      	tst	r3, r5
c0d03110:	d1f6      	bne.n	c0d03100 <memset+0x14>
c0d03112:	2c03      	cmp	r4, #3
c0d03114:	d924      	bls.n	c0d03160 <memset+0x74>
c0d03116:	25ff      	movs	r5, #255	; 0xff
c0d03118:	400d      	ands	r5, r1
c0d0311a:	022a      	lsls	r2, r5, #8
c0d0311c:	4315      	orrs	r5, r2
c0d0311e:	042a      	lsls	r2, r5, #16
c0d03120:	4315      	orrs	r5, r2
c0d03122:	2c0f      	cmp	r4, #15
c0d03124:	d911      	bls.n	c0d0314a <memset+0x5e>
c0d03126:	0026      	movs	r6, r4
c0d03128:	3e10      	subs	r6, #16
c0d0312a:	0936      	lsrs	r6, r6, #4
c0d0312c:	3601      	adds	r6, #1
c0d0312e:	0136      	lsls	r6, r6, #4
c0d03130:	001a      	movs	r2, r3
c0d03132:	199b      	adds	r3, r3, r6
c0d03134:	6015      	str	r5, [r2, #0]
c0d03136:	6055      	str	r5, [r2, #4]
c0d03138:	6095      	str	r5, [r2, #8]
c0d0313a:	60d5      	str	r5, [r2, #12]
c0d0313c:	3210      	adds	r2, #16
c0d0313e:	4293      	cmp	r3, r2
c0d03140:	d1f8      	bne.n	c0d03134 <memset+0x48>
c0d03142:	220f      	movs	r2, #15
c0d03144:	4014      	ands	r4, r2
c0d03146:	2c03      	cmp	r4, #3
c0d03148:	d90a      	bls.n	c0d03160 <memset+0x74>
c0d0314a:	1f26      	subs	r6, r4, #4
c0d0314c:	08b6      	lsrs	r6, r6, #2
c0d0314e:	3601      	adds	r6, #1
c0d03150:	00b6      	lsls	r6, r6, #2
c0d03152:	001a      	movs	r2, r3
c0d03154:	199b      	adds	r3, r3, r6
c0d03156:	c220      	stmia	r2!, {r5}
c0d03158:	4293      	cmp	r3, r2
c0d0315a:	d1fc      	bne.n	c0d03156 <memset+0x6a>
c0d0315c:	2203      	movs	r2, #3
c0d0315e:	4014      	ands	r4, r2
c0d03160:	2c00      	cmp	r4, #0
c0d03162:	d005      	beq.n	c0d03170 <memset+0x84>
c0d03164:	b2c9      	uxtb	r1, r1
c0d03166:	191c      	adds	r4, r3, r4
c0d03168:	7019      	strb	r1, [r3, #0]
c0d0316a:	3301      	adds	r3, #1
c0d0316c:	429c      	cmp	r4, r3
c0d0316e:	d1fb      	bne.n	c0d03168 <memset+0x7c>
c0d03170:	bd70      	pop	{r4, r5, r6, pc}
c0d03172:	0014      	movs	r4, r2
c0d03174:	0003      	movs	r3, r0
c0d03176:	e7cc      	b.n	c0d03112 <memset+0x26>

c0d03178 <setjmp>:
c0d03178:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0317a:	4641      	mov	r1, r8
c0d0317c:	464a      	mov	r2, r9
c0d0317e:	4653      	mov	r3, sl
c0d03180:	465c      	mov	r4, fp
c0d03182:	466d      	mov	r5, sp
c0d03184:	4676      	mov	r6, lr
c0d03186:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03188:	3828      	subs	r0, #40	; 0x28
c0d0318a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d0318c:	2000      	movs	r0, #0
c0d0318e:	4770      	bx	lr

c0d03190 <longjmp>:
c0d03190:	3010      	adds	r0, #16
c0d03192:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03194:	4690      	mov	r8, r2
c0d03196:	4699      	mov	r9, r3
c0d03198:	46a2      	mov	sl, r4
c0d0319a:	46ab      	mov	fp, r5
c0d0319c:	46b5      	mov	sp, r6
c0d0319e:	c808      	ldmia	r0!, {r3}
c0d031a0:	3828      	subs	r0, #40	; 0x28
c0d031a2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d031a4:	1c08      	adds	r0, r1, #0
c0d031a6:	d100      	bne.n	c0d031aa <longjmp+0x1a>
c0d031a8:	2001      	movs	r0, #1
c0d031aa:	4718      	bx	r3

c0d031ac <strlen>:
c0d031ac:	b510      	push	{r4, lr}
c0d031ae:	0783      	lsls	r3, r0, #30
c0d031b0:	d027      	beq.n	c0d03202 <strlen+0x56>
c0d031b2:	7803      	ldrb	r3, [r0, #0]
c0d031b4:	2b00      	cmp	r3, #0
c0d031b6:	d026      	beq.n	c0d03206 <strlen+0x5a>
c0d031b8:	0003      	movs	r3, r0
c0d031ba:	2103      	movs	r1, #3
c0d031bc:	e002      	b.n	c0d031c4 <strlen+0x18>
c0d031be:	781a      	ldrb	r2, [r3, #0]
c0d031c0:	2a00      	cmp	r2, #0
c0d031c2:	d01c      	beq.n	c0d031fe <strlen+0x52>
c0d031c4:	3301      	adds	r3, #1
c0d031c6:	420b      	tst	r3, r1
c0d031c8:	d1f9      	bne.n	c0d031be <strlen+0x12>
c0d031ca:	6819      	ldr	r1, [r3, #0]
c0d031cc:	4a0f      	ldr	r2, [pc, #60]	; (c0d0320c <strlen+0x60>)
c0d031ce:	4c10      	ldr	r4, [pc, #64]	; (c0d03210 <strlen+0x64>)
c0d031d0:	188a      	adds	r2, r1, r2
c0d031d2:	438a      	bics	r2, r1
c0d031d4:	4222      	tst	r2, r4
c0d031d6:	d10f      	bne.n	c0d031f8 <strlen+0x4c>
c0d031d8:	3304      	adds	r3, #4
c0d031da:	6819      	ldr	r1, [r3, #0]
c0d031dc:	4a0b      	ldr	r2, [pc, #44]	; (c0d0320c <strlen+0x60>)
c0d031de:	188a      	adds	r2, r1, r2
c0d031e0:	438a      	bics	r2, r1
c0d031e2:	4222      	tst	r2, r4
c0d031e4:	d108      	bne.n	c0d031f8 <strlen+0x4c>
c0d031e6:	3304      	adds	r3, #4
c0d031e8:	6819      	ldr	r1, [r3, #0]
c0d031ea:	4a08      	ldr	r2, [pc, #32]	; (c0d0320c <strlen+0x60>)
c0d031ec:	188a      	adds	r2, r1, r2
c0d031ee:	438a      	bics	r2, r1
c0d031f0:	4222      	tst	r2, r4
c0d031f2:	d0f1      	beq.n	c0d031d8 <strlen+0x2c>
c0d031f4:	e000      	b.n	c0d031f8 <strlen+0x4c>
c0d031f6:	3301      	adds	r3, #1
c0d031f8:	781a      	ldrb	r2, [r3, #0]
c0d031fa:	2a00      	cmp	r2, #0
c0d031fc:	d1fb      	bne.n	c0d031f6 <strlen+0x4a>
c0d031fe:	1a18      	subs	r0, r3, r0
c0d03200:	bd10      	pop	{r4, pc}
c0d03202:	0003      	movs	r3, r0
c0d03204:	e7e1      	b.n	c0d031ca <strlen+0x1e>
c0d03206:	2000      	movs	r0, #0
c0d03208:	e7fa      	b.n	c0d03200 <strlen+0x54>
c0d0320a:	46c0      	nop			; (mov r8, r8)
c0d0320c:	fefefeff 	.word	0xfefefeff
c0d03210:	80808080 	.word	0x80808080
c0d03214:	45544550 	.word	0x45544550
c0d03218:	54455052 	.word	0x54455052
c0d0321c:	45505245 	.word	0x45505245
c0d03220:	50524554 	.word	0x50524554
c0d03224:	52455445 	.word	0x52455445
c0d03228:	45544550 	.word	0x45544550
c0d0322c:	54455052 	.word	0x54455052
c0d03230:	45505245 	.word	0x45505245
c0d03234:	50524554 	.word	0x50524554
c0d03238:	52455445 	.word	0x52455445
c0d0323c:	45544550 	.word	0x45544550
c0d03240:	54455052 	.word	0x54455052
c0d03244:	45505245 	.word	0x45505245
c0d03248:	50524554 	.word	0x50524554
c0d0324c:	52455445 	.word	0x52455445
c0d03250:	45544550 	.word	0x45544550
c0d03254:	54455052 	.word	0x54455052
c0d03258:	45505245 	.word	0x45505245
c0d0325c:	50524554 	.word	0x50524554
c0d03260:	52455445 	.word	0x52455445
c0d03264:	00000052 	.word	0x00000052

c0d03268 <trits_mapping>:
c0d03268:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03278:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03288:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03298:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d032a8:	00000100 01000101 000101ff 01010101     ................
c0d032b8:	00000001                                ....

c0d032bc <bagl_ui_nanos_screen1>:
c0d032bc:	00000003 00800000 00000020 00000001     ........ .......
c0d032cc:	00000000 00ffffff 00000000 00000000     ................
	...
c0d032f4:	00000107 0080000c 00000020 00000000     ........ .......
c0d03304:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0332c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03344:	00070000 00000000 00000000 00000000     ................
	...
c0d03364:	00750005 0008000d 00000006 00000000     ..u.............
c0d03374:	00ffffff 00000000 00060000 00000000     ................
	...

c0d0339c <bagl_ui_nanos_screen2>:
c0d0339c:	00000003 00800000 00000020 00000001     ........ .......
c0d033ac:	00000000 00ffffff 00000000 00000000     ................
	...
c0d033d4:	00000107 00800012 00000020 00000000     ........ .......
c0d033e4:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d0340c:	00030005 0007000c 00000007 00000000     ................
	...
c0d03424:	00070000 00000000 00000000 00000000     ................
	...
c0d03444:	00750005 0008000d 00000006 00000000     ..u.............
c0d03454:	00ffffff 00000000 00060000 00000000     ................
	...

c0d0347c <bagl_ui_sample_blue>:
c0d0347c:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d0348c:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d034b4:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d034c4:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d034ec:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d034fc:	00ffffff 001d2028 00002004 c0d0355c     ....( ... ..\5..
	...
c0d03524:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03534:	0041ccb4 00f9f9f9 0000a004 c0d03568     ..A.........h5..
c0d03544:	00000000 0037ae99 00f9f9f9 c0d01fd9     ......7.........
	...
c0d0355c:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d0356d <USBD_PRODUCT_FS_STRING>:
c0d0356d:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d0357b <HID_ReportDesc>:
c0d0357b:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d0358b:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0359b:	0000c008 11210900                                .....

c0d035a0 <USBD_HID_Desc>:
c0d035a0:	01112109 22220100 00011200                       .!...."".

c0d035a9 <USBD_DeviceDesc>:
c0d035a9:	02000112 40000000 00012c97 02010200     .......@.,......
c0d035b9:	e9000103                                         ...

c0d035bc <HID_Desc>:
c0d035bc:	c0d02be9 c0d02bf9 c0d02c09 c0d02c19     .+...+...,...,..
c0d035cc:	c0d02c29 c0d02c39 c0d02c49 00000000     ),..9,..I,......

c0d035dc <USBD_LangIDDesc>:
c0d035dc:	04090304                                ....

c0d035e0 <USBD_MANUFACTURER_STRING>:
c0d035e0:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d035ee <USB_SERIAL_STRING>:
c0d035ee:	0030030a 00300030 2acb0031                       ..0.0.0.1.

c0d035f8 <USBD_HID>:
c0d035f8:	c0d02acb c0d02afd c0d02a2f 00000000     .*...*../*......
	...
c0d03610:	c0d02b35 00000000 00000000 00000000     5+..............
c0d03620:	c0d02c59 c0d02c59 c0d02c59 c0d02c69     Y,..Y,..Y,..i,..

c0d03630 <USBD_CfgDesc>:
c0d03630:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03640:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03650:	05070100 00400302 00000001              ......@.....

c0d0365c <USBD_DeviceQualifierDesc>:
c0d0365c:	0200060a 40000000 00000001              .......@....

c0d03668 <_etext>:
	...

c0d03680 <N_storage_real>:
	...
