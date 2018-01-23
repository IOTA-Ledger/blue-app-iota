
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
c0d00014:	f001 f9a8 	bl	c0d01368 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f8f4 	bl	c0d01204 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fd85 	bl	c0d03b34 <setjmp>
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
c0d00040:	f001 fb38 	bl	c0d016b4 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f002 f819 	bl	c0d0207c <pic>
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
c0d0005a:	f002 f80f 	bl	c0d0207c <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f002 f85d 	bl	c0d02120 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f964 	bl	c0d03334 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f961 	bl	c0d03334 <USB_power>

            ui_idle();
c0d00072:	f002 faf5 	bl	c0d02660 <ui_idle>

            IOTA_main();
c0d00076:	f000 ff5d 	bl	c0d00f34 <IOTA_main>
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
c0d0008c:	f003 fd5e 	bl	c0d03b4c <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d04080 	.word	0xc0d04080

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
c0d000ca:	f001 fd87 	bl	c0d01bdc <snprintf>
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

c0d00166 <trits_to_trint>:
        pow3_val /= 3;
    }
}

//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
c0d00166:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00168:	af03      	add	r7, sp, #12
c0d0016a:	2200      	movs	r2, #0
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d0016c:	43d3      	mvns	r3, r2
c0d0016e:	b2c9      	uxtb	r1, r1
c0d00170:	31ff      	adds	r1, #255	; 0xff
c0d00172:	b24c      	sxtb	r4, r1
c0d00174:	2c00      	cmp	r4, #0
c0d00176:	db0f      	blt.n	c0d00198 <trits_to_trint+0x32>
c0d00178:	1900      	adds	r0, r0, r4
c0d0017a:	2401      	movs	r4, #1
c0d0017c:	2200      	movs	r2, #0
    {
        ret += trits[i]*pow3_val;
c0d0017e:	b265      	sxtb	r5, r4
        pow3_val *= 3;
c0d00180:	2403      	movs	r4, #3
c0d00182:	436c      	muls	r4, r5
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
    {
        ret += trits[i]*pow3_val;
c0d00184:	7806      	ldrb	r6, [r0, #0]
c0d00186:	b276      	sxtb	r6, r6
c0d00188:	436e      	muls	r6, r5
c0d0018a:	b2d2      	uxtb	r2, r2
c0d0018c:	18b2      	adds	r2, r6, r2
//standard is 5 trits in 8 bits, final call may have < 5 trits
int8_t trits_to_trint(int8_t *trits, int8_t sz) {
    int8_t pow3_val = 1;
    int8_t ret = 0;

    for(int8_t i=sz-1; i>=0; i--)
c0d0018e:	1e40      	subs	r0, r0, #1
c0d00190:	1e49      	subs	r1, r1, #1
c0d00192:	b249      	sxtb	r1, r1
c0d00194:	4299      	cmp	r1, r3
c0d00196:	dcf2      	bgt.n	c0d0017e <trits_to_trint+0x18>
    {
        ret += trits[i]*pow3_val;
        pow3_val *= 3;
    }

    return ret;
c0d00198:	b250      	sxtb	r0, r2
c0d0019a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0019c <specific_49trints_to_243trits>:
        //incr count as we get trints
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
c0d0019c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0019e:	af03      	add	r7, sp, #12
c0d001a0:	b089      	sub	sp, #36	; 0x24
c0d001a2:	460c      	mov	r4, r1
c0d001a4:	9001      	str	r0, [sp, #4]
c0d001a6:	2200      	movs	r2, #0
c0d001a8:	9400      	str	r4, [sp, #0]
    for(uint8_t i = 0; i < 48; i++) {
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
c0d001aa:	9801      	ldr	r0, [sp, #4]
c0d001ac:	9203      	str	r2, [sp, #12]
c0d001ae:	5c82      	ldrb	r2, [r0, r2]
c0d001b0:	20ff      	movs	r0, #255	; 0xff
c0d001b2:	9005      	str	r0, [sp, #20]
c0d001b4:	0600      	lsls	r0, r0, #24
c0d001b6:	9004      	str	r0, [sp, #16]
c0d001b8:	2001      	movs	r0, #1
c0d001ba:	9006      	str	r0, [sp, #24]
c0d001bc:	0600      	lsls	r0, r0, #24
c0d001be:	9007      	str	r0, [sp, #28]
c0d001c0:	2051      	movs	r0, #81	; 0x51
c0d001c2:	2505      	movs	r5, #5
c0d001c4:	9402      	str	r4, [sp, #8]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d001c6:	b2c6      	uxtb	r6, r0
c0d001c8:	b250      	sxtb	r0, r2
c0d001ca:	9008      	str	r0, [sp, #32]
c0d001cc:	0040      	lsls	r0, r0, #1
c0d001ce:	4631      	mov	r1, r6
c0d001d0:	f003 f9f8 	bl	c0d035c4 <__aeabi_idiv>
c0d001d4:	7020      	strb	r0, [r4, #0]


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d001d6:	0602      	lsls	r2, r0, #24
c0d001d8:	9907      	ldr	r1, [sp, #28]
c0d001da:	428a      	cmp	r2, r1
c0d001dc:	9906      	ldr	r1, [sp, #24]
c0d001de:	dc03      	bgt.n	c0d001e8 <specific_49trints_to_243trits+0x4c>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d001e0:	9904      	ldr	r1, [sp, #16]
c0d001e2:	428a      	cmp	r2, r1
c0d001e4:	9905      	ldr	r1, [sp, #20]
c0d001e6:	da01      	bge.n	c0d001ec <specific_49trints_to_243trits+0x50>
c0d001e8:	7021      	strb	r1, [r4, #0]
c0d001ea:	e000      	b.n	c0d001ee <specific_49trints_to_243trits+0x52>

        integ -= trits_r[j] * pow3_val;
c0d001ec:	4601      	mov	r1, r0
c0d001ee:	9a08      	ldr	r2, [sp, #32]
c0d001f0:	b248      	sxtb	r0, r1
c0d001f2:	4370      	muls	r0, r6
c0d001f4:	1a10      	subs	r0, r2, r0
        pow3_val /= 3;
c0d001f6:	9008      	str	r0, [sp, #32]
c0d001f8:	2103      	movs	r1, #3
c0d001fa:	4630      	mov	r0, r6
c0d001fc:	f003 f958 	bl	c0d034b0 <__aeabi_uidiv>
c0d00200:	9a08      	ldr	r2, [sp, #32]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00202:	1e6d      	subs	r5, r5, #1
c0d00204:	1c64      	adds	r4, r4, #1
c0d00206:	2d00      	cmp	r5, #0
c0d00208:	d1dd      	bne.n	c0d001c6 <specific_49trints_to_243trits+0x2a>
c0d0020a:	9c02      	ldr	r4, [sp, #8]
        trints_r[count++] = trits_to_trint(&trits[i], send);
    }
}

void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r) {
    for(uint8_t i = 0; i < 48; i++) {
c0d0020c:	1d64      	adds	r4, r4, #5
c0d0020e:	9a03      	ldr	r2, [sp, #12]
c0d00210:	1c52      	adds	r2, r2, #1
c0d00212:	2a30      	cmp	r2, #48	; 0x30
c0d00214:	d1c9      	bne.n	c0d001aa <specific_49trints_to_243trits+0xe>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
c0d00216:	2030      	movs	r0, #48	; 0x30
c0d00218:	9901      	ldr	r1, [sp, #4]
c0d0021a:	5c0d      	ldrb	r5, [r1, r0]
c0d0021c:	20ef      	movs	r0, #239	; 0xef
c0d0021e:	43c4      	mvns	r4, r0
c0d00220:	2009      	movs	r0, #9
c0d00222:	9406      	str	r4, [sp, #24]
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00224:	b2c6      	uxtb	r6, r0
c0d00226:	b26d      	sxtb	r5, r5
c0d00228:	0068      	lsls	r0, r5, #1
c0d0022a:	4631      	mov	r1, r6
c0d0022c:	f003 f9ca 	bl	c0d035c4 <__aeabi_idiv>
c0d00230:	9906      	ldr	r1, [sp, #24]
c0d00232:	31ef      	adds	r1, #239	; 0xef
c0d00234:	4361      	muls	r1, r4
c0d00236:	9a00      	ldr	r2, [sp, #0]
c0d00238:	5450      	strb	r0, [r2, r1]
c0d0023a:	1851      	adds	r1, r2, r1


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d0023c:	9108      	str	r1, [sp, #32]
c0d0023e:	0603      	lsls	r3, r0, #24
c0d00240:	2101      	movs	r1, #1
c0d00242:	9a07      	ldr	r2, [sp, #28]
c0d00244:	4293      	cmp	r3, r2
c0d00246:	dc03      	bgt.n	c0d00250 <specific_49trints_to_243trits+0xb4>
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d00248:	9904      	ldr	r1, [sp, #16]
c0d0024a:	428b      	cmp	r3, r1
c0d0024c:	9905      	ldr	r1, [sp, #20]
c0d0024e:	da02      	bge.n	c0d00256 <specific_49trints_to_243trits+0xba>
c0d00250:	9808      	ldr	r0, [sp, #32]
c0d00252:	7001      	strb	r1, [r0, #0]
c0d00254:	e000      	b.n	c0d00258 <specific_49trints_to_243trits+0xbc>

        integ -= trits_r[j] * pow3_val;
c0d00256:	4601      	mov	r1, r0
c0d00258:	b248      	sxtb	r0, r1
c0d0025a:	4370      	muls	r0, r6
c0d0025c:	1a2d      	subs	r5, r5, r0
        pow3_val /= 3;
c0d0025e:	2103      	movs	r1, #3
c0d00260:	4630      	mov	r0, r6
c0d00262:	f003 f925 	bl	c0d034b0 <__aeabi_uidiv>
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00266:	1e64      	subs	r4, r4, #1
c0d00268:	4621      	mov	r1, r4
c0d0026a:	31f3      	adds	r1, #243	; 0xf3
c0d0026c:	d1da      	bne.n	c0d00224 <specific_49trints_to_243trits+0x88>
        //convert 1 trint into 5 trits
        trint_to_trits(trints[i], &trits_r[i*5], 5);
    }
    //do one more but this will only be 3 trits
    trint_to_trits(trints[48], &trits_r[48 * 5], 3);
}
c0d0026e:	b009      	add	sp, #36	; 0x24
c0d00270:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00274 <trint_to_trits>:

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
c0d00274:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00276:	af03      	add	r7, sp, #12
c0d00278:	b083      	sub	sp, #12
c0d0027a:	9100      	str	r1, [sp, #0]
c0d0027c:	4603      	mov	r3, r0
c0d0027e:	9201      	str	r2, [sp, #4]
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d00280:	2a01      	cmp	r2, #1
c0d00282:	db2b      	blt.n	c0d002dc <trint_to_trits+0x68>
}

void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz) {
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
c0d00284:	2009      	movs	r0, #9
c0d00286:	2151      	movs	r1, #81	; 0x51
c0d00288:	9a01      	ldr	r2, [sp, #4]
c0d0028a:	2a03      	cmp	r2, #3
c0d0028c:	d000      	beq.n	c0d00290 <trint_to_trits+0x1c>
c0d0028e:	4608      	mov	r0, r1
c0d00290:	2500      	movs	r5, #0
c0d00292:	462e      	mov	r6, r5
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
        trits_r[j] = (int8_t) (integ*2/pow3_val);
c0d00294:	b2c4      	uxtb	r4, r0
c0d00296:	b258      	sxtb	r0, r3
c0d00298:	9002      	str	r0, [sp, #8]
c0d0029a:	0040      	lsls	r0, r0, #1
c0d0029c:	4621      	mov	r1, r4
c0d0029e:	f003 f991 	bl	c0d035c4 <__aeabi_idiv>
c0d002a2:	9900      	ldr	r1, [sp, #0]
c0d002a4:	5548      	strb	r0, [r1, r5]
c0d002a6:	194a      	adds	r2, r1, r5


        if(trits_r[j] > 1) trits_r[j] = 1;
c0d002a8:	0603      	lsls	r3, r0, #24
c0d002aa:	2101      	movs	r1, #1
c0d002ac:	060d      	lsls	r5, r1, #24
c0d002ae:	42ab      	cmp	r3, r5
c0d002b0:	dc03      	bgt.n	c0d002ba <trint_to_trits+0x46>
c0d002b2:	21ff      	movs	r1, #255	; 0xff
        else if(trits_r[j] < -1) trits_r[j] = -1;
c0d002b4:	4d0a      	ldr	r5, [pc, #40]	; (c0d002e0 <trint_to_trits+0x6c>)
c0d002b6:	42ab      	cmp	r3, r5
c0d002b8:	dc01      	bgt.n	c0d002be <trint_to_trits+0x4a>
c0d002ba:	7011      	strb	r1, [r2, #0]
c0d002bc:	e000      	b.n	c0d002c0 <trint_to_trits+0x4c>

        integ -= trits_r[j] * pow3_val;
c0d002be:	4601      	mov	r1, r0
c0d002c0:	9a02      	ldr	r2, [sp, #8]
c0d002c2:	b248      	sxtb	r0, r1
c0d002c4:	4360      	muls	r0, r4
c0d002c6:	1a15      	subs	r5, r2, r0
        pow3_val /= 3;
c0d002c8:	2103      	movs	r1, #3
c0d002ca:	4620      	mov	r0, r4
c0d002cc:	f003 f8f0 	bl	c0d034b0 <__aeabi_uidiv>
c0d002d0:	462b      	mov	r3, r5
    uint8_t pow3_val = 81;
    //if only 3 trits the largest trit column is 3^2 - never called without sz 5 or 3
    if(sz == 3)
        pow3_val = 9;

    for(uint8_t j = 0; j<sz; j++) {
c0d002d2:	1c76      	adds	r6, r6, #1
c0d002d4:	b2f5      	uxtb	r5, r6
c0d002d6:	9901      	ldr	r1, [sp, #4]
c0d002d8:	428d      	cmp	r5, r1
c0d002da:	dbdb      	blt.n	c0d00294 <trint_to_trits+0x20>
        else if(trits_r[j] < -1) trits_r[j] = -1;

        integ -= trits_r[j] * pow3_val;
        pow3_val /= 3;
    }
}
c0d002dc:	b003      	add	sp, #12
c0d002de:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d002e0:	feffffff 	.word	0xfeffffff

c0d002e4 <get_seed>:
    return ret;
}

void do_nothing() {}

void get_seed(unsigned char *privateKey, uint8_t sz, char *msg) {
c0d002e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d002e6:	af03      	add	r7, sp, #12
c0d002e8:	b0e3      	sub	sp, #396	; 0x18c
c0d002ea:	9203      	str	r2, [sp, #12]
c0d002ec:	460d      	mov	r5, r1
c0d002ee:	4604      	mov	r4, r0

    //kerl requires 424 bytes
    kerl_initialize();
c0d002f0:	9402      	str	r4, [sp, #8]
c0d002f2:	f000 fbc7 	bl	c0d00a84 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d002f6:	f000 fbc5 	bl	c0d00a84 <kerl_initialize>
c0d002fa:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d002fc:	4630      	mov	r0, r6
c0d002fe:	4621      	mov	r1, r4
c0d00300:	462a      	mov	r2, r5
c0d00302:	f003 fb87 	bl	c0d03a14 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d00306:	1970      	adds	r0, r6, r5
c0d00308:	2430      	movs	r4, #48	; 0x30
c0d0030a:	1b62      	subs	r2, r4, r5
c0d0030c:	9902      	ldr	r1, [sp, #8]
c0d0030e:	f003 fb81 	bl	c0d03a14 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00312:	4630      	mov	r0, r6
c0d00314:	4621      	mov	r1, r4
c0d00316:	f000 fbc1 	bl	c0d00a9c <kerl_absorb_bytes>
c0d0031a:	ae41      	add	r6, sp, #260	; 0x104
c0d0031c:	2551      	movs	r5, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d0031e:	4630      	mov	r0, r6
c0d00320:	4629      	mov	r1, r5
c0d00322:	f003 fb71 	bl	c0d03a08 <__aeabi_memclr>
c0d00326:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d00328:	491f      	ldr	r1, [pc, #124]	; (c0d003a8 <get_seed+0xc4>)
c0d0032a:	4479      	add	r1, pc
c0d0032c:	2252      	movs	r2, #82	; 0x52
c0d0032e:	4620      	mov	r0, r4
c0d00330:	f003 fb70 	bl	c0d03a14 <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d00334:	4620      	mov	r0, r4
c0d00336:	4631      	mov	r1, r6
c0d00338:	4634      	mov	r4, r6
c0d0033a:	9401      	str	r4, [sp, #4]
c0d0033c:	462a      	mov	r2, r5
c0d0033e:	9502      	str	r5, [sp, #8]
c0d00340:	f000 fa06 	bl	c0d00750 <chars_to_trytes>
c0d00344:	ae04      	add	r6, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00346:	21f3      	movs	r1, #243	; 0xf3
c0d00348:	9100      	str	r1, [sp, #0]
c0d0034a:	4630      	mov	r0, r6
c0d0034c:	f003 fb5c 	bl	c0d03a08 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d00350:	4620      	mov	r0, r4
c0d00352:	4631      	mov	r1, r6
c0d00354:	462a      	mov	r2, r5
c0d00356:	f000 f9dd 	bl	c0d00714 <trytes_to_trits>
c0d0035a:	ad56      	add	r5, sp, #344	; 0x158
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d0035c:	4630      	mov	r0, r6
c0d0035e:	4629      	mov	r1, r5
c0d00360:	f7ff febe 	bl	c0d000e0 <specific_243trits_to_49trints>
      }
      {
        kerl_initialize();
c0d00364:	f000 fb8e 	bl	c0d00a84 <kerl_initialize>
c0d00368:	2631      	movs	r6, #49	; 0x31
        kerl_absorb_trints2(seed_trints, 49, msg);
c0d0036a:	4628      	mov	r0, r5
c0d0036c:	4631      	mov	r1, r6
c0d0036e:	9a03      	ldr	r2, [sp, #12]
c0d00370:	f000 fba8 	bl	c0d00ac4 <kerl_absorb_trints2>
        kerl_squeeze_trints(seed_trints, 49);
c0d00374:	4628      	mov	r0, r5
c0d00376:	4631      	mov	r1, r6
c0d00378:	f000 fc08 	bl	c0d00b8c <kerl_squeeze_trints>
c0d0037c:	ae04      	add	r6, sp, #16
        // unsigned char bytes[48];
        // words_to_bytes(words, bytes, 12);
        // snprintf(msg, 81, "words: %u %u %u bytes: %u %u %u %u %u", words[0], words[1], words[2], bytes[0], bytes[1], bytes[2], bytes[3], bytes[4]);
      // }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d0037e:	4630      	mov	r0, r6
c0d00380:	9c00      	ldr	r4, [sp, #0]
c0d00382:	4621      	mov	r1, r4
c0d00384:	f003 fb40 	bl	c0d03a08 <__aeabi_memclr>
        specific_49trints_to_243trits(seed_trints, seed_trits);
c0d00388:	4628      	mov	r0, r5
c0d0038a:	4631      	mov	r1, r6
c0d0038c:	f7ff ff06 	bl	c0d0019c <specific_49trints_to_243trits>
        trits_to_trytes(seed_trits, seed_trytes, 243);
c0d00390:	4630      	mov	r0, r6
c0d00392:	9901      	ldr	r1, [sp, #4]
c0d00394:	4622      	mov	r2, r4
c0d00396:	f000 f987 	bl	c0d006a8 <trits_to_trytes>
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d0039a:	2000      	movs	r0, #0
        specific_49trints_to_243trits(seed_trints, seed_trits);
        trits_to_trytes(seed_trits, seed_trytes, 243);
        // trytes_to_chars(seed_trytes, msg, 81);
      }
      {
        msg[81] = '\0';
c0d0039c:	9903      	ldr	r1, [sp, #12]
c0d0039e:	9a02      	ldr	r2, [sp, #8]
c0d003a0:	5488      	strb	r0, [r1, r2]
    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
}
c0d003a2:	b063      	add	sp, #396	; 0x18c
c0d003a4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d003a6:	46c0      	nop			; (mov r8, r8)
c0d003a8:	000038a2 	.word	0x000038a2

c0d003ac <bigint_add_intarr_u_mem>:
    }
    return i;
}*/

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
c0d003ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003ae:	af03      	add	r7, sp, #12
c0d003b0:	b087      	sub	sp, #28
c0d003b2:	2300      	movs	r3, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003b4:	2a00      	cmp	r2, #0
c0d003b6:	d03b      	beq.n	c0d00430 <bigint_add_intarr_u_mem+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003b8:	2500      	movs	r5, #0
c0d003ba:	43ec      	mvns	r4, r5
c0d003bc:	9200      	str	r2, [sp, #0]
c0d003be:	4613      	mov	r3, r2
c0d003c0:	9502      	str	r5, [sp, #8]
int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
c0d003c2:	9401      	str	r4, [sp, #4]
c0d003c4:	9304      	str	r3, [sp, #16]
c0d003c6:	9005      	str	r0, [sp, #20]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003c8:	6802      	ldr	r2, [r0, #0]
c0d003ca:	c908      	ldmia	r1!, {r3}
c0d003cc:	9106      	str	r1, [sp, #24]
c0d003ce:	1898      	adds	r0, r3, r2
c0d003d0:	9902      	ldr	r1, [sp, #8]
c0d003d2:	460b      	mov	r3, r1
c0d003d4:	415b      	adcs	r3, r3
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d003d6:	4602      	mov	r2, r0
c0d003d8:	4022      	ands	r2, r4
c0d003da:	1c52      	adds	r2, r2, #1
c0d003dc:	4626      	mov	r6, r4
c0d003de:	460c      	mov	r4, r1
c0d003e0:	4611      	mov	r1, r2
c0d003e2:	4164      	adcs	r4, r4
c0d003e4:	2201      	movs	r2, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d003e6:	4015      	ands	r5, r2
c0d003e8:	2d00      	cmp	r5, #0
c0d003ea:	d100      	bne.n	c0d003ee <bigint_add_intarr_u_mem+0x42>
c0d003ec:	4601      	mov	r1, r0
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003ee:	42b1      	cmp	r1, r6
c0d003f0:	4616      	mov	r6, r2
c0d003f2:	d800      	bhi.n	c0d003f6 <bigint_add_intarr_u_mem+0x4a>
c0d003f4:	9e02      	ldr	r6, [sp, #8]
c0d003f6:	9103      	str	r1, [sp, #12]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d003f8:	2d00      	cmp	r5, #0
c0d003fa:	9805      	ldr	r0, [sp, #20]
c0d003fc:	d100      	bne.n	c0d00400 <bigint_add_intarr_u_mem+0x54>
c0d003fe:	461c      	mov	r4, r3
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00400:	2c00      	cmp	r4, #0
c0d00402:	4611      	mov	r1, r2
c0d00404:	d100      	bne.n	c0d00408 <bigint_add_intarr_u_mem+0x5c>
c0d00406:	4621      	mov	r1, r4
c0d00408:	2c00      	cmp	r4, #0
c0d0040a:	d000      	beq.n	c0d0040e <bigint_add_intarr_u_mem+0x62>
c0d0040c:	460e      	mov	r6, r1
    struct int_bool_pair ret = { (uint32_t)r, carry1 || carry2 };
c0d0040e:	431e      	orrs	r6, r3

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00410:	2e00      	cmp	r6, #0
c0d00412:	9906      	ldr	r1, [sp, #24]
c0d00414:	9c01      	ldr	r4, [sp, #4]
c0d00416:	d100      	bne.n	c0d0041a <bigint_add_intarr_u_mem+0x6e>
c0d00418:	4632      	mov	r2, r6
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
        bigint_in[i] = val.low;
c0d0041a:	9b03      	ldr	r3, [sp, #12]
c0d0041c:	c008      	stmia	r0!, {r3}
c0d0041e:	9b04      	ldr	r3, [sp, #16]

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00420:	1e5b      	subs	r3, r3, #1
c0d00422:	4615      	mov	r5, r2
c0d00424:	d1ce      	bne.n	c0d003c4 <bigint_add_intarr_u_mem+0x18>
c0d00426:	2000      	movs	r0, #0
c0d00428:	43c3      	mvns	r3, r0
c0d0042a:	2e00      	cmp	r6, #0
c0d0042c:	d100      	bne.n	c0d00430 <bigint_add_intarr_u_mem+0x84>
c0d0042e:	9b00      	ldr	r3, [sp, #0]

    if (val.hi) {
        return -1;
    }
    return len;
}
c0d00430:	4618      	mov	r0, r3
c0d00432:	b007      	add	sp, #28
c0d00434:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00436 <bigint_add_int_u_mem>:
    return len;
}

//memory optimized for add in place
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len)
{
c0d00436:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00438:	af03      	add	r7, sp, #12
c0d0043a:	b083      	sub	sp, #12

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0043c:	6803      	ldr	r3, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0043e:	2600      	movs	r6, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00440:	1859      	adds	r1, r3, r1
c0d00442:	4633      	mov	r3, r6
c0d00444:	415b      	adcs	r3, r3
c0d00446:	9001      	str	r0, [sp, #4]
{
    struct int_bool_pair val;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;
c0d00448:	6001      	str	r1, [r0, #0]
c0d0044a:	2101      	movs	r1, #1
c0d0044c:	2b00      	cmp	r3, #0
c0d0044e:	d100      	bne.n	c0d00452 <bigint_add_int_u_mem+0x1c>
c0d00450:	4619      	mov	r1, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00452:	43f0      	mvns	r0, r6

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d00454:	9002      	str	r0, [sp, #8]
c0d00456:	2a02      	cmp	r2, #2
c0d00458:	d31b      	bcc.n	c0d00492 <bigint_add_int_u_mem+0x5c>
c0d0045a:	2301      	movs	r3, #1
c0d0045c:	9200      	str	r2, [sp, #0]
        // only continue adding, if there is a carry bit
        if (!val.hi) {
c0d0045e:	07c9      	lsls	r1, r1, #31
c0d00460:	d01d      	beq.n	c0d0049e <bigint_add_int_u_mem+0x68>
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d00462:	0099      	lsls	r1, r3, #2
c0d00464:	9801      	ldr	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00466:	5845      	ldr	r5, [r0, r1]
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00468:	1c6a      	adds	r2, r5, #1
c0d0046a:	4634      	mov	r4, r6
c0d0046c:	4176      	adcs	r6, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
c0d0046e:	5042      	str	r2, [r0, r1]
c0d00470:	2501      	movs	r5, #1
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00472:	9802      	ldr	r0, [sp, #8]
c0d00474:	4282      	cmp	r2, r0
c0d00476:	4629      	mov	r1, r5
c0d00478:	d800      	bhi.n	c0d0047c <bigint_add_int_u_mem+0x46>
c0d0047a:	4621      	mov	r1, r4
c0d0047c:	2e00      	cmp	r6, #0
c0d0047e:	d100      	bne.n	c0d00482 <bigint_add_int_u_mem+0x4c>
c0d00480:	4635      	mov	r5, r6
c0d00482:	2e00      	cmp	r6, #0
c0d00484:	d000      	beq.n	c0d00488 <bigint_add_int_u_mem+0x52>
c0d00486:	4629      	mov	r1, r5

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d00488:	1c5b      	adds	r3, r3, #1
c0d0048a:	9a00      	ldr	r2, [sp, #0]
c0d0048c:	4293      	cmp	r3, r2
c0d0048e:	4626      	mov	r6, r4
c0d00490:	d3e5      	bcc.n	c0d0045e <bigint_add_int_u_mem+0x28>
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
    }

    // detect overflow
    if (val.hi) {
c0d00492:	2900      	cmp	r1, #0
c0d00494:	d100      	bne.n	c0d00498 <bigint_add_int_u_mem+0x62>
c0d00496:	9202      	str	r2, [sp, #8]
c0d00498:	9802      	ldr	r0, [sp, #8]
c0d0049a:	b003      	add	sp, #12
c0d0049c:	bdf0      	pop	{r4, r5, r6, r7, pc}
        return -1;
    }
    return len;
}
c0d0049e:	4618      	mov	r0, r3
c0d004a0:	b003      	add	sp, #12
c0d004a2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004a4 <bigint_add_int_u>:

int bigint_add_int_u(uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len)
{
c0d004a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004a6:	af03      	add	r7, sp, #12
c0d004a8:	b085      	sub	sp, #20
c0d004aa:	9303      	str	r3, [sp, #12]
c0d004ac:	9001      	str	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004ae:	6800      	ldr	r0, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004b0:	2400      	movs	r4, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004b2:	1840      	adds	r0, r0, r1
c0d004b4:	4623      	mov	r3, r4
c0d004b6:	415b      	adcs	r3, r3
c0d004b8:	9202      	str	r2, [sp, #8]
    struct int_bool_pair val;
    uint8_t i;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;
c0d004ba:	6010      	str	r0, [r2, #0]

    i = 1;
    for (; i < len; i++) {
c0d004bc:	2601      	movs	r6, #1
c0d004be:	2b00      	cmp	r3, #0
c0d004c0:	4631      	mov	r1, r6
c0d004c2:	d000      	beq.n	c0d004c6 <bigint_add_int_u+0x22>
c0d004c4:	4621      	mov	r1, r4
c0d004c6:	2b00      	cmp	r3, #0
c0d004c8:	4635      	mov	r5, r6
c0d004ca:	d100      	bne.n	c0d004ce <bigint_add_int_u+0x2a>
c0d004cc:	461d      	mov	r5, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004ce:	43e0      	mvns	r0, r4
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d004d0:	9000      	str	r0, [sp, #0]
c0d004d2:	9803      	ldr	r0, [sp, #12]
c0d004d4:	2802      	cmp	r0, #2
c0d004d6:	d323      	bcc.n	c0d00520 <bigint_add_int_u+0x7c>
c0d004d8:	2900      	cmp	r1, #0
c0d004da:	d121      	bne.n	c0d00520 <bigint_add_int_u+0x7c>
c0d004dc:	2101      	movs	r1, #1
c0d004de:	9104      	str	r1, [sp, #16]
c0d004e0:	4634      	mov	r4, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d004e2:	008d      	lsls	r5, r1, #2

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004e4:	9801      	ldr	r0, [sp, #4]
c0d004e6:	5943      	ldr	r3, [r0, r5]
c0d004e8:	2200      	movs	r2, #0
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d004ea:	1c58      	adds	r0, r3, #1
c0d004ec:	4613      	mov	r3, r2
c0d004ee:	415b      	adcs	r3, r3
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
c0d004f0:	9e02      	ldr	r6, [sp, #8]
c0d004f2:	5170      	str	r0, [r6, r5]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004f4:	9d00      	ldr	r5, [sp, #0]
c0d004f6:	42a8      	cmp	r0, r5
c0d004f8:	9d04      	ldr	r5, [sp, #16]
c0d004fa:	d800      	bhi.n	c0d004fe <bigint_add_int_u+0x5a>
c0d004fc:	4615      	mov	r5, r2
c0d004fe:	2b00      	cmp	r3, #0
c0d00500:	9a04      	ldr	r2, [sp, #16]
c0d00502:	d100      	bne.n	c0d00506 <bigint_add_int_u+0x62>
c0d00504:	461a      	mov	r2, r3
c0d00506:	2b00      	cmp	r3, #0
c0d00508:	4626      	mov	r6, r4
c0d0050a:	d000      	beq.n	c0d0050e <bigint_add_int_u+0x6a>
c0d0050c:	4615      	mov	r5, r2
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d0050e:	462a      	mov	r2, r5
c0d00510:	4072      	eors	r2, r6
c0d00512:	1c49      	adds	r1, r1, #1
c0d00514:	9803      	ldr	r0, [sp, #12]
c0d00516:	4281      	cmp	r1, r0
c0d00518:	d203      	bcs.n	c0d00522 <bigint_add_int_u+0x7e>
c0d0051a:	2a00      	cmp	r2, #0
c0d0051c:	d0e0      	beq.n	c0d004e0 <bigint_add_int_u+0x3c>
c0d0051e:	e000      	b.n	c0d00522 <bigint_add_int_u+0x7e>
c0d00520:	4631      	mov	r1, r6
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d00522:	b2cb      	uxtb	r3, r1
c0d00524:	9803      	ldr	r0, [sp, #12]
c0d00526:	4283      	cmp	r3, r0
c0d00528:	d20a      	bcs.n	c0d00540 <bigint_add_int_u+0x9c>
        bigint_out[j] = bigint_in[j];
c0d0052a:	9803      	ldr	r0, [sp, #12]
c0d0052c:	1ac4      	subs	r4, r0, r3
c0d0052e:	009a      	lsls	r2, r3, #2
c0d00530:	9801      	ldr	r0, [sp, #4]
c0d00532:	1880      	adds	r0, r0, r2
c0d00534:	9e02      	ldr	r6, [sp, #8]
c0d00536:	18b2      	adds	r2, r6, r2
c0d00538:	c840      	ldmia	r0!, {r6}
c0d0053a:	c240      	stmia	r2!, {r6}
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d0053c:	1e64      	subs	r4, r4, #1
c0d0053e:	d1fb      	bne.n	c0d00538 <bigint_add_int_u+0x94>
        bigint_out[j] = bigint_in[j];
    }

    if (val.hi && i == len) {
c0d00540:	2000      	movs	r0, #0
c0d00542:	43c0      	mvns	r0, r0
c0d00544:	9a03      	ldr	r2, [sp, #12]
c0d00546:	4293      	cmp	r3, r2
c0d00548:	d000      	beq.n	c0d0054c <bigint_add_int_u+0xa8>
c0d0054a:	4608      	mov	r0, r1
c0d0054c:	2d00      	cmp	r5, #0
c0d0054e:	d100      	bne.n	c0d00552 <bigint_add_int_u+0xae>
c0d00550:	4608      	mov	r0, r1
        return -1;
    }
    return i;
}
c0d00552:	b005      	add	sp, #20
c0d00554:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00556 <bigint_sub_bigint_u_mem>:
    return len;
}

//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
c0d00556:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00558:	af03      	add	r7, sp, #12
c0d0055a:	b086      	sub	sp, #24
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0055c:	2a00      	cmp	r2, #0
c0d0055e:	d037      	beq.n	c0d005d0 <bigint_sub_bigint_u_mem+0x7a>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00560:	2300      	movs	r3, #0
c0d00562:	9300      	str	r3, [sp, #0]
c0d00564:	43de      	mvns	r6, r3
c0d00566:	2501      	movs	r5, #1
c0d00568:	9505      	str	r5, [sp, #20]
c0d0056a:	9203      	str	r2, [sp, #12]
c0d0056c:	9001      	str	r0, [sp, #4]
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0056e:	6804      	ldr	r4, [r0, #0]
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00570:	c908      	ldmia	r1!, {r3}
c0d00572:	9104      	str	r1, [sp, #16]
c0d00574:	43db      	mvns	r3, r3
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00576:	1918      	adds	r0, r3, r4
c0d00578:	4633      	mov	r3, r6
c0d0057a:	9e00      	ldr	r6, [sp, #0]
c0d0057c:	4632      	mov	r2, r6
c0d0057e:	4152      	adcs	r2, r2
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00580:	4601      	mov	r1, r0
c0d00582:	4019      	ands	r1, r3
c0d00584:	1c4c      	adds	r4, r1, #1
c0d00586:	4631      	mov	r1, r6
c0d00588:	4149      	adcs	r1, r1
c0d0058a:	9e05      	ldr	r6, [sp, #20]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0058c:	4035      	ands	r5, r6
c0d0058e:	2d00      	cmp	r5, #0
c0d00590:	d100      	bne.n	c0d00594 <bigint_sub_bigint_u_mem+0x3e>
c0d00592:	4604      	mov	r4, r0
c0d00594:	9402      	str	r4, [sp, #8]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00596:	429c      	cmp	r4, r3
c0d00598:	4634      	mov	r4, r6
c0d0059a:	461e      	mov	r6, r3
c0d0059c:	d800      	bhi.n	c0d005a0 <bigint_sub_bigint_u_mem+0x4a>
c0d0059e:	9c00      	ldr	r4, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005a0:	2d00      	cmp	r5, #0
c0d005a2:	d100      	bne.n	c0d005a6 <bigint_sub_bigint_u_mem+0x50>
c0d005a4:	4611      	mov	r1, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005a6:	2900      	cmp	r1, #0
c0d005a8:	9b05      	ldr	r3, [sp, #20]
c0d005aa:	461d      	mov	r5, r3
c0d005ac:	d100      	bne.n	c0d005b0 <bigint_sub_bigint_u_mem+0x5a>
c0d005ae:	460d      	mov	r5, r1
c0d005b0:	2900      	cmp	r1, #0
c0d005b2:	d000      	beq.n	c0d005b6 <bigint_sub_bigint_u_mem+0x60>
c0d005b4:	462c      	mov	r4, r5
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d005b6:	4314      	orrs	r4, r2
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005b8:	2c00      	cmp	r4, #0
c0d005ba:	461d      	mov	r5, r3
c0d005bc:	9802      	ldr	r0, [sp, #8]
c0d005be:	d100      	bne.n	c0d005c2 <bigint_sub_bigint_u_mem+0x6c>
c0d005c0:	4625      	mov	r5, r4
c0d005c2:	9901      	ldr	r1, [sp, #4]
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
c0d005c4:	c101      	stmia	r1!, {r0}
c0d005c6:	4608      	mov	r0, r1
c0d005c8:	9a03      	ldr	r2, [sp, #12]
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005ca:	1e52      	subs	r2, r2, #1
c0d005cc:	9904      	ldr	r1, [sp, #16]
c0d005ce:	d1cc      	bne.n	c0d0056a <bigint_sub_bigint_u_mem+0x14>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
    }
    return 0;
c0d005d0:	2000      	movs	r0, #0
c0d005d2:	b006      	add	sp, #24
c0d005d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005d6 <bigint_sub_bigint_u>:
}

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
c0d005d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005d8:	af03      	add	r7, sp, #12
c0d005da:	b087      	sub	sp, #28
c0d005dc:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005de:	2d00      	cmp	r5, #0
c0d005e0:	d037      	beq.n	c0d00652 <bigint_sub_bigint_u+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005e2:	2400      	movs	r4, #0
c0d005e4:	9402      	str	r4, [sp, #8]
c0d005e6:	43e3      	mvns	r3, r4
c0d005e8:	9301      	str	r3, [sp, #4]
c0d005ea:	2601      	movs	r6, #1
c0d005ec:	9600      	str	r6, [sp, #0]
c0d005ee:	9203      	str	r2, [sp, #12]
c0d005f0:	9504      	str	r5, [sp, #16]
c0d005f2:	4604      	mov	r4, r0
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d005f4:	cc01      	ldmia	r4!, {r0}
c0d005f6:	9405      	str	r4, [sp, #20]
c0d005f8:	460c      	mov	r4, r1
int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d005fa:	cc02      	ldmia	r4!, {r1}
c0d005fc:	9406      	str	r4, [sp, #24]
c0d005fe:	43c9      	mvns	r1, r1
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00600:	180a      	adds	r2, r1, r0
c0d00602:	9902      	ldr	r1, [sp, #8]
c0d00604:	460c      	mov	r4, r1
c0d00606:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00608:	4610      	mov	r0, r2
c0d0060a:	9d01      	ldr	r5, [sp, #4]
c0d0060c:	4028      	ands	r0, r5
c0d0060e:	1c43      	adds	r3, r0, #1
c0d00610:	4608      	mov	r0, r1
c0d00612:	4140      	adcs	r0, r0
c0d00614:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00616:	400e      	ands	r6, r1
c0d00618:	2e00      	cmp	r6, #0
c0d0061a:	d100      	bne.n	c0d0061e <bigint_sub_bigint_u+0x48>
c0d0061c:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0061e:	42ab      	cmp	r3, r5
c0d00620:	460d      	mov	r5, r1
c0d00622:	d800      	bhi.n	c0d00626 <bigint_sub_bigint_u+0x50>
c0d00624:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00626:	2e00      	cmp	r6, #0
c0d00628:	9a03      	ldr	r2, [sp, #12]
c0d0062a:	d100      	bne.n	c0d0062e <bigint_sub_bigint_u+0x58>
c0d0062c:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0062e:	2800      	cmp	r0, #0
c0d00630:	460e      	mov	r6, r1
c0d00632:	d100      	bne.n	c0d00636 <bigint_sub_bigint_u+0x60>
c0d00634:	4606      	mov	r6, r0
c0d00636:	2800      	cmp	r0, #0
c0d00638:	d000      	beq.n	c0d0063c <bigint_sub_bigint_u+0x66>
c0d0063a:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d0063c:	4325      	orrs	r5, r4

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0063e:	2d00      	cmp	r5, #0
c0d00640:	460e      	mov	r6, r1
c0d00642:	9805      	ldr	r0, [sp, #20]
c0d00644:	d100      	bne.n	c0d00648 <bigint_sub_bigint_u+0x72>
c0d00646:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00648:	c208      	stmia	r2!, {r3}
c0d0064a:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d0064c:	1e6d      	subs	r5, r5, #1
c0d0064e:	9906      	ldr	r1, [sp, #24]
c0d00650:	d1cd      	bne.n	c0d005ee <bigint_sub_bigint_u+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d00652:	2000      	movs	r0, #0
c0d00654:	b007      	add	sp, #28
c0d00656:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00658 <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d00658:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0065a:	af03      	add	r7, sp, #12
c0d0065c:	b081      	sub	sp, #4
c0d0065e:	2400      	movs	r4, #0
c0d00660:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00662:	32ff      	adds	r2, #255	; 0xff
c0d00664:	b253      	sxtb	r3, r2
c0d00666:	2b00      	cmp	r3, #0
c0d00668:	db0f      	blt.n	c0d0068a <bigint_cmp_bigint_u+0x32>
c0d0066a:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d0066c:	009b      	lsls	r3, r3, #2
c0d0066e:	58ce      	ldr	r6, [r1, r3]
c0d00670:	58c4      	ldr	r4, [r0, r3]
c0d00672:	2301      	movs	r3, #1
c0d00674:	42b4      	cmp	r4, r6
c0d00676:	d80b      	bhi.n	c0d00690 <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00678:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d0067a:	42b4      	cmp	r4, r6
c0d0067c:	d307      	bcc.n	c0d0068e <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0067e:	b253      	sxtb	r3, r2
c0d00680:	42ab      	cmp	r3, r5
c0d00682:	461a      	mov	r2, r3
c0d00684:	dcf2      	bgt.n	c0d0066c <bigint_cmp_bigint_u+0x14>
c0d00686:	9b00      	ldr	r3, [sp, #0]
c0d00688:	e002      	b.n	c0d00690 <bigint_cmp_bigint_u+0x38>
c0d0068a:	4623      	mov	r3, r4
c0d0068c:	e000      	b.n	c0d00690 <bigint_cmp_bigint_u+0x38>
c0d0068e:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00690:	4618      	mov	r0, r3
c0d00692:	b001      	add	sp, #4
c0d00694:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00696 <bigint_not_u>:
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00696:	2900      	cmp	r1, #0
c0d00698:	d004      	beq.n	c0d006a4 <bigint_not_u+0xe>
        bigint[i] = ~bigint[i];
c0d0069a:	6802      	ldr	r2, [r0, #0]
c0d0069c:	43d2      	mvns	r2, r2
c0d0069e:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006a0:	1e49      	subs	r1, r1, #1
c0d006a2:	d1fa      	bne.n	c0d0069a <bigint_not_u+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d006a4:	2000      	movs	r0, #0
c0d006a6:	4770      	bx	lr

c0d006a8 <trits_to_trytes>:
    0x1B3DC3CE,
    0x00000001};

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d006a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006aa:	af03      	add	r7, sp, #12
c0d006ac:	b083      	sub	sp, #12
c0d006ae:	4616      	mov	r6, r2
c0d006b0:	460c      	mov	r4, r1
c0d006b2:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d006b4:	2103      	movs	r1, #3
c0d006b6:	4630      	mov	r0, r6
c0d006b8:	f002 ff80 	bl	c0d035bc <__aeabi_uidivmod>
c0d006bc:	2000      	movs	r0, #0
c0d006be:	43c2      	mvns	r2, r0
c0d006c0:	2900      	cmp	r1, #0
c0d006c2:	d123      	bne.n	c0d0070c <trits_to_trytes+0x64>
c0d006c4:	9502      	str	r5, [sp, #8]
c0d006c6:	4635      	mov	r5, r6
c0d006c8:	2603      	movs	r6, #3
c0d006ca:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d006cc:	4628      	mov	r0, r5
c0d006ce:	4631      	mov	r1, r6
c0d006d0:	f002 feee 	bl	c0d034b0 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d006d4:	2d03      	cmp	r5, #3
c0d006d6:	9a01      	ldr	r2, [sp, #4]
c0d006d8:	d318      	bcc.n	c0d0070c <trits_to_trytes+0x64>
c0d006da:	2200      	movs	r2, #0
c0d006dc:	9200      	str	r2, [sp, #0]
c0d006de:	9601      	str	r6, [sp, #4]
c0d006e0:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d006e2:	4633      	mov	r3, r6
c0d006e4:	4353      	muls	r3, r2
c0d006e6:	4625      	mov	r5, r4
c0d006e8:	9902      	ldr	r1, [sp, #8]
c0d006ea:	5ccc      	ldrb	r4, [r1, r3]
c0d006ec:	18cb      	adds	r3, r1, r3
c0d006ee:	2101      	movs	r1, #1
c0d006f0:	5659      	ldrsb	r1, [r3, r1]
c0d006f2:	4371      	muls	r1, r6
c0d006f4:	1909      	adds	r1, r1, r4
c0d006f6:	2402      	movs	r4, #2
c0d006f8:	571b      	ldrsb	r3, [r3, r4]
c0d006fa:	2409      	movs	r4, #9
c0d006fc:	435c      	muls	r4, r3
c0d006fe:	1909      	adds	r1, r1, r4
c0d00700:	462c      	mov	r4, r5
c0d00702:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00704:	1c52      	adds	r2, r2, #1
c0d00706:	4282      	cmp	r2, r0
c0d00708:	d3eb      	bcc.n	c0d006e2 <trits_to_trytes+0x3a>
c0d0070a:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d0070c:	4610      	mov	r0, r2
c0d0070e:	b003      	add	sp, #12
c0d00710:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00714 <trytes_to_trits>:

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d00714:	b5b0      	push	{r4, r5, r7, lr}
c0d00716:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00718:	2a00      	cmp	r2, #0
c0d0071a:	d015      	beq.n	c0d00748 <trytes_to_trits+0x34>
c0d0071c:	4b0b      	ldr	r3, [pc, #44]	; (c0d0074c <trytes_to_trits+0x38>)
c0d0071e:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00720:	240d      	movs	r4, #13
c0d00722:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00724:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00726:	062d      	lsls	r5, r5, #24
c0d00728:	192c      	adds	r4, r5, r4
c0d0072a:	1624      	asrs	r4, r4, #24
c0d0072c:	2503      	movs	r5, #3
c0d0072e:	4365      	muls	r5, r4
c0d00730:	5d5c      	ldrb	r4, [r3, r5]
c0d00732:	700c      	strb	r4, [r1, #0]
c0d00734:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d00736:	7865      	ldrb	r5, [r4, #1]
c0d00738:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0073a:	78a4      	ldrb	r4, [r4, #2]
c0d0073c:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0073e:	1e52      	subs	r2, r2, #1
c0d00740:	1cc9      	adds	r1, r1, #3
c0d00742:	1c40      	adds	r0, r0, #1
c0d00744:	2a00      	cmp	r2, #0
c0d00746:	d1eb      	bne.n	c0d00720 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00748:	2000      	movs	r0, #0
c0d0074a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0074c:	00003502 	.word	0x00003502

c0d00750 <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00750:	b5d0      	push	{r4, r6, r7, lr}
c0d00752:	af02      	add	r7, sp, #8
c0d00754:	e00e      	b.n	c0d00774 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d00756:	7803      	ldrb	r3, [r0, #0]
c0d00758:	b25b      	sxtb	r3, r3
c0d0075a:	2400      	movs	r4, #0
c0d0075c:	2b39      	cmp	r3, #57	; 0x39
c0d0075e:	d005      	beq.n	c0d0076c <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00760:	2b4e      	cmp	r3, #78	; 0x4e
c0d00762:	db01      	blt.n	c0d00768 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00764:	33a5      	adds	r3, #165	; 0xa5
c0d00766:	e000      	b.n	c0d0076a <chars_to_trytes+0x1a>
c0d00768:	33c0      	adds	r3, #192	; 0xc0
c0d0076a:	461c      	mov	r4, r3
c0d0076c:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0076e:	1e52      	subs	r2, r2, #1
c0d00770:	1c40      	adds	r0, r0, #1
c0d00772:	1c49      	adds	r1, r1, #1
c0d00774:	2a00      	cmp	r2, #0
c0d00776:	d1ee      	bne.n	c0d00756 <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d00778:	2000      	movs	r0, #0
c0d0077a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0077c <bytes_to_words>:

    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], uint32_t words_out[], uint8_t word_len)
{
c0d0077c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0077e:	af03      	add	r7, sp, #12
c0d00780:	b081      	sub	sp, #4
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d00782:	2300      	movs	r3, #0
c0d00784:	43dc      	mvns	r4, r3
c0d00786:	32ff      	adds	r2, #255	; 0xff
c0d00788:	b255      	sxtb	r5, r2
c0d0078a:	2d00      	cmp	r5, #0
c0d0078c:	db1e      	blt.n	c0d007cc <bytes_to_words+0x50>
        words_out[i] = 0;
c0d0078e:	9300      	str	r3, [sp, #0]
c0d00790:	00ad      	lsls	r5, r5, #2
c0d00792:	514b      	str	r3, [r1, r5]
        words_out[i] |= (bytes_in[(i)*4+3] << 24) & 0xFF000000;
c0d00794:	2603      	movs	r6, #3
c0d00796:	432e      	orrs	r6, r5
c0d00798:	5d86      	ldrb	r6, [r0, r6]
c0d0079a:	0636      	lsls	r6, r6, #24
c0d0079c:	514e      	str	r6, [r1, r5]
c0d0079e:	4623      	mov	r3, r4
c0d007a0:	2402      	movs	r4, #2
        words_out[i] |= (bytes_in[(i)*4+2] << 16) & 0x00FF0000;
c0d007a2:	432c      	orrs	r4, r5
c0d007a4:	5d04      	ldrb	r4, [r0, r4]
c0d007a6:	0424      	lsls	r4, r4, #16
c0d007a8:	4334      	orrs	r4, r6
c0d007aa:	514c      	str	r4, [r1, r5]
        words_out[i] |= (bytes_in[(i)*4+1] <<  8) & 0x0000FF00;
c0d007ac:	2601      	movs	r6, #1
c0d007ae:	432e      	orrs	r6, r5
c0d007b0:	5d86      	ldrb	r6, [r0, r6]
c0d007b2:	0236      	lsls	r6, r6, #8
c0d007b4:	4326      	orrs	r6, r4
c0d007b6:	514e      	str	r6, [r1, r5]
        words_out[i] |= (bytes_in[(i)*4+0] <<  0) & 0x000000FF;
c0d007b8:	5d44      	ldrb	r4, [r0, r5]
c0d007ba:	4334      	orrs	r4, r6
c0d007bc:	514c      	str	r4, [r1, r5]
c0d007be:	461c      	mov	r4, r3
c0d007c0:	9b00      	ldr	r3, [sp, #0]
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], uint32_t words_out[], uint8_t word_len)
{
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d007c2:	1e52      	subs	r2, r2, #1
c0d007c4:	b255      	sxtb	r5, r2
c0d007c6:	42a5      	cmp	r5, r4
c0d007c8:	462a      	mov	r2, r5
c0d007ca:	dce1      	bgt.n	c0d00790 <bytes_to_words+0x14>
        words_out[i] |= (bytes_in[(i)*4+3] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(i)*4+2] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(i)*4+1] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(i)*4+0] <<  0) & 0x000000FF;
    }
    return 0;
c0d007cc:	2000      	movs	r0, #0
c0d007ce:	b001      	add	sp, #4
c0d007d0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d007d2 <words_to_bytes>:
}

int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d007d2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007d4:	af03      	add	r7, sp, #12
c0d007d6:	b081      	sub	sp, #4
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d007d8:	2300      	movs	r3, #0
c0d007da:	43db      	mvns	r3, r3
c0d007dc:	32ff      	adds	r2, #255	; 0xff
c0d007de:	b254      	sxtb	r4, r2
c0d007e0:	2c00      	cmp	r4, #0
c0d007e2:	db15      	blt.n	c0d00810 <words_to_bytes+0x3e>
      uint32_t value = words_in[i];
c0d007e4:	9300      	str	r3, [sp, #0]
c0d007e6:	00a4      	lsls	r4, r4, #2
c0d007e8:	5905      	ldr	r5, [r0, r4]
      bytes_out[i*4+0] = (value & 0x000000ff);
c0d007ea:	550d      	strb	r5, [r1, r4]
      bytes_out[i*4+1] = (value & 0x0000ff00) >> 8;
c0d007ec:	2601      	movs	r6, #1
c0d007ee:	4326      	orrs	r6, r4
c0d007f0:	0a2b      	lsrs	r3, r5, #8
c0d007f2:	558b      	strb	r3, [r1, r6]
c0d007f4:	2302      	movs	r3, #2
      bytes_out[i*4+2] = (value & 0x00ff0000) >> 16;
c0d007f6:	4323      	orrs	r3, r4
c0d007f8:	0c2e      	lsrs	r6, r5, #16
c0d007fa:	54ce      	strb	r6, [r1, r3]
      bytes_out[i*4+3] = (value & 0xff000000) >> 24;
c0d007fc:	2303      	movs	r3, #3
c0d007fe:	4323      	orrs	r3, r4
c0d00800:	0e2c      	lsrs	r4, r5, #24
c0d00802:	54cc      	strb	r4, [r1, r3]
c0d00804:	9b00      	ldr	r3, [sp, #0]
    return 0;
}

int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (int8_t i = word_len - 1; i >= 0; i--) {
c0d00806:	1e52      	subs	r2, r2, #1
c0d00808:	b254      	sxtb	r4, r2
c0d0080a:	429c      	cmp	r4, r3
c0d0080c:	4622      	mov	r2, r4
c0d0080e:	dcea      	bgt.n	c0d007e6 <words_to_bytes+0x14>
      bytes_out[i*4+1] = (value & 0x0000ff00) >> 8;
      bytes_out[i*4+2] = (value & 0x00ff0000) >> 16;
      bytes_out[i*4+3] = (value & 0xff000000) >> 24;
    }

    return 0;
c0d00810:	2000      	movs	r0, #0
c0d00812:	b001      	add	sp, #4
c0d00814:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00818 <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d00818:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0081a:	af03      	add	r7, sp, #12
c0d0081c:	b095      	sub	sp, #84	; 0x54
c0d0081e:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d00820:	2130      	movs	r1, #48	; 0x30
c0d00822:	9000      	str	r0, [sp, #0]
c0d00824:	5640      	ldrsb	r0, [r0, r1]
c0d00826:	a913      	add	r1, sp, #76	; 0x4c
c0d00828:	2203      	movs	r2, #3
c0d0082a:	f7ff fd23 	bl	c0d00274 <trint_to_trits>
c0d0082e:	2001      	movs	r0, #1
c0d00830:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d00832:	9606      	str	r6, [sp, #24]
c0d00834:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d00836:	2105      	movs	r1, #5
c0d00838:	4620      	mov	r0, r4
c0d0083a:	f002 ffa9 	bl	c0d03790 <__aeabi_idivmod>
c0d0083e:	460e      	mov	r6, r1
c0d00840:	2e04      	cmp	r6, #4
c0d00842:	d10b      	bne.n	c0d0085c <trints_to_words_u_mem+0x44>
c0d00844:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d00846:	4620      	mov	r0, r4
c0d00848:	4629      	mov	r1, r5
c0d0084a:	f002 febb 	bl	c0d035c4 <__aeabi_idiv>
c0d0084e:	b2c0      	uxtb	r0, r0
c0d00850:	9900      	ldr	r1, [sp, #0]
c0d00852:	5608      	ldrsb	r0, [r1, r0]
c0d00854:	a913      	add	r1, sp, #76	; 0x4c
c0d00856:	462a      	mov	r2, r5
c0d00858:	f7ff fd0c 	bl	c0d00274 <trint_to_trits>
c0d0085c:	a813      	add	r0, sp, #76	; 0x4c

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d0085e:	5d80      	ldrb	r0, [r0, r6]
c0d00860:	1c41      	adds	r1, r0, #1
c0d00862:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00864:	9804      	ldr	r0, [sp, #16]
c0d00866:	2800      	cmp	r0, #0
c0d00868:	d022      	beq.n	c0d008b0 <trints_to_words_u_mem+0x98>
c0d0086a:	9101      	str	r1, [sp, #4]
c0d0086c:	9402      	str	r4, [sp, #8]
c0d0086e:	2500      	movs	r5, #0
c0d00870:	462e      	mov	r6, r5
c0d00872:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d00874:	00b1      	lsls	r1, r6, #2
c0d00876:	9105      	str	r1, [sp, #20]
c0d00878:	9806      	ldr	r0, [sp, #24]
c0d0087a:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d0087c:	2203      	movs	r2, #3
c0d0087e:	9c03      	ldr	r4, [sp, #12]
c0d00880:	4621      	mov	r1, r4
c0d00882:	4623      	mov	r3, r4
c0d00884:	f002 ffaa 	bl	c0d037dc <__aeabi_lmul>
c0d00888:	9b04      	ldr	r3, [sp, #16]
c0d0088a:	1940      	adds	r0, r0, r5
c0d0088c:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d0088e:	9a06      	ldr	r2, [sp, #24]
c0d00890:	9c05      	ldr	r4, [sp, #20]
c0d00892:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00894:	1c76      	adds	r6, r6, #1
c0d00896:	42b3      	cmp	r3, r6
c0d00898:	460d      	mov	r5, r1
c0d0089a:	d1eb      	bne.n	c0d00874 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d0089c:	2900      	cmp	r1, #0
c0d0089e:	d004      	beq.n	c0d008aa <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d008a0:	0098      	lsls	r0, r3, #2
c0d008a2:	9a06      	ldr	r2, [sp, #24]
c0d008a4:	5011      	str	r1, [r2, r0]
                size++;
c0d008a6:	1c5d      	adds	r5, r3, #1
c0d008a8:	e000      	b.n	c0d008ac <trints_to_words_u_mem+0x94>
c0d008aa:	461d      	mov	r5, r3
c0d008ac:	9c02      	ldr	r4, [sp, #8]
c0d008ae:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d008b0:	b2c9      	uxtb	r1, r1
c0d008b2:	220c      	movs	r2, #12
c0d008b4:	9e06      	ldr	r6, [sp, #24]
c0d008b6:	4630      	mov	r0, r6
c0d008b8:	f7ff fdbd 	bl	c0d00436 <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d008bc:	42a8      	cmp	r0, r5
c0d008be:	d800      	bhi.n	c0d008c2 <trints_to_words_u_mem+0xaa>
c0d008c0:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d008c2:	1e61      	subs	r1, r4, #1
c0d008c4:	2c00      	cmp	r4, #0
c0d008c6:	460c      	mov	r4, r1
c0d008c8:	dcb4      	bgt.n	c0d00834 <trints_to_words_u_mem+0x1c>
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d008ca:	481c      	ldr	r0, [pc, #112]	; (c0d0093c <trints_to_words_u_mem+0x124>)
c0d008cc:	4478      	add	r0, pc
c0d008ce:	220c      	movs	r2, #12
c0d008d0:	4631      	mov	r1, r6
c0d008d2:	f7ff fec1 	bl	c0d00658 <bigint_cmp_bigint_u>
c0d008d6:	2801      	cmp	r0, #1
c0d008d8:	db14      	blt.n	c0d00904 <trints_to_words_u_mem+0xec>
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d008da:	481a      	ldr	r0, [pc, #104]	; (c0d00944 <trints_to_words_u_mem+0x12c>)
c0d008dc:	4478      	add	r0, pc
c0d008de:	ae07      	add	r6, sp, #28
c0d008e0:	250c      	movs	r5, #12
c0d008e2:	9906      	ldr	r1, [sp, #24]
c0d008e4:	4632      	mov	r2, r6
c0d008e6:	462b      	mov	r3, r5
c0d008e8:	f7ff fe75 	bl	c0d005d6 <bigint_sub_bigint_u>
        bigint_not_u(tmp, 12);
c0d008ec:	4630      	mov	r0, r6
c0d008ee:	4629      	mov	r1, r5
c0d008f0:	f7ff fed1 	bl	c0d00696 <bigint_not_u>
        bigint_add_int_u(tmp, 1, base, 12);
c0d008f4:	2101      	movs	r1, #1
c0d008f6:	4630      	mov	r0, r6
c0d008f8:	9e06      	ldr	r6, [sp, #24]
c0d008fa:	4632      	mov	r2, r6
c0d008fc:	462b      	mov	r3, r5
c0d008fe:	f7ff fdd1 	bl	c0d004a4 <bigint_add_int_u>
c0d00902:	e005      	b.n	c0d00910 <trints_to_words_u_mem+0xf8>
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d00904:	490e      	ldr	r1, [pc, #56]	; (c0d00940 <trints_to_words_u_mem+0x128>)
c0d00906:	4479      	add	r1, pc
c0d00908:	220c      	movs	r2, #12
c0d0090a:	4630      	mov	r0, r6
c0d0090c:	f7ff fe23 	bl	c0d00556 <bigint_sub_bigint_u_mem>
c0d00910:	2000      	movs	r0, #0
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d00912:	0081      	lsls	r1, r0, #2
c0d00914:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d00916:	1a73      	subs	r3, r6, r1
c0d00918:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d0091a:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d0091c:	62da      	str	r2, [r3, #44]	; 0x2c
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d0091e:	1c40      	adds	r0, r0, #1
c0d00920:	2806      	cmp	r0, #6
c0d00922:	d1f6      	bne.n	c0d00912 <trints_to_words_u_mem+0xfa>
c0d00924:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00926:	0081      	lsls	r1, r0, #2
c0d00928:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d0092a:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d0092c:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d0092e:	1c40      	adds	r0, r0, #1
c0d00930:	280c      	cmp	r0, #12
c0d00932:	d1f8      	bne.n	c0d00926 <trints_to_words_u_mem+0x10e>
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
c0d00934:	2000      	movs	r0, #0
c0d00936:	b015      	add	sp, #84	; 0x54
c0d00938:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0093a:	46c0      	nop			; (mov r8, r8)
c0d0093c:	000033a8 	.word	0x000033a8
c0d00940:	0000336e 	.word	0x0000336e
c0d00944:	00003398 	.word	0x00003398

c0d00948 <words_to_trints_u_mem>:
    return 0;
}


int words_to_trints_u_mem(uint32_t *words_in, trint_t *trints_out)
{
c0d00948:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0094a:	af03      	add	r7, sp, #12
c0d0094c:	b095      	sub	sp, #84	; 0x54
c0d0094e:	9101      	str	r1, [sp, #4]
c0d00950:	260b      	movs	r6, #11
c0d00952:	2100      	movs	r1, #0


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00954:	b2ca      	uxtb	r2, r1
        tmp = words[i];
c0d00956:	0092      	lsls	r2, r2, #2
c0d00958:	5883      	ldr	r3, [r0, r2]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d0095a:	b2f4      	uxtb	r4, r6
        tmp = words[i];
        words[i] = words[j];
c0d0095c:	00a4      	lsls	r4, r4, #2
c0d0095e:	5905      	ldr	r5, [r0, r4]
c0d00960:	5085      	str	r5, [r0, r2]
        words[j] = tmp;
c0d00962:	5103      	str	r3, [r0, r4]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00964:	1e76      	subs	r6, r6, #1
c0d00966:	b2f2      	uxtb	r2, r6
c0d00968:	1c49      	adds	r1, r1, #1
c0d0096a:	b2cb      	uxtb	r3, r1
c0d0096c:	4293      	cmp	r3, r2
c0d0096e:	d3f1      	bcc.n	c0d00954 <words_to_trints_u_mem+0xc>
    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
c0d00970:	6ac1      	ldr	r1, [r0, #44]	; 0x2c
c0d00972:	2900      	cmp	r1, #0
c0d00974:	9007      	str	r0, [sp, #28]
c0d00976:	db06      	blt.n	c0d00986 <words_to_trints_u_mem+0x3e>
        //positive two's complement
        bigint_add_intarr_u_mem(base, HALF_3_u, 12);
c0d00978:	493e      	ldr	r1, [pc, #248]	; (c0d00a74 <words_to_trints_u_mem+0x12c>)
c0d0097a:	4479      	add	r1, pc
c0d0097c:	220c      	movs	r2, #12
c0d0097e:	f7ff fd15 	bl	c0d003ac <bigint_add_intarr_u_mem>
c0d00982:	2000      	movs	r0, #0
c0d00984:	e013      	b.n	c0d009ae <words_to_trints_u_mem+0x66>
c0d00986:	240c      	movs	r4, #12
c0d00988:	4605      	mov	r5, r0

    } else {
        //negative number
        bigint_not_u(base, 12);
c0d0098a:	4621      	mov	r1, r4
c0d0098c:	f7ff fe83 	bl	c0d00696 <bigint_not_u>
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
c0d00990:	4939      	ldr	r1, [pc, #228]	; (c0d00a78 <words_to_trints_u_mem+0x130>)
c0d00992:	4479      	add	r1, pc
c0d00994:	4628      	mov	r0, r5
c0d00996:	4622      	mov	r2, r4
c0d00998:	f7ff fe5e 	bl	c0d00658 <bigint_cmp_bigint_u>
c0d0099c:	2801      	cmp	r0, #1
c0d0099e:	db54      	blt.n	c0d00a4a <words_to_trints_u_mem+0x102>
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d009a0:	4936      	ldr	r1, [pc, #216]	; (c0d00a7c <words_to_trints_u_mem+0x134>)
c0d009a2:	4479      	add	r1, pc
c0d009a4:	220c      	movs	r2, #12
c0d009a6:	4628      	mov	r0, r5
c0d009a8:	f7ff fdd5 	bl	c0d00556 <bigint_sub_bigint_u_mem>
c0d009ac:	2001      	movs	r0, #1
c0d009ae:	9005      	str	r0, [sp, #20]
c0d009b0:	2000      	movs	r0, #0
c0d009b2:	9004      	str	r0, [sp, #16]
c0d009b4:	4605      	mov	r5, r0
c0d009b6:	9506      	str	r5, [sp, #24]
c0d009b8:	250b      	movs	r5, #11
c0d009ba:	9c04      	ldr	r4, [sp, #16]
c0d009bc:	9907      	ldr	r1, [sp, #28]
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
c0d009be:	00a8      	lsls	r0, r5, #2
c0d009c0:	9008      	str	r0, [sp, #32]
c0d009c2:	5808      	ldr	r0, [r1, r0]
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
c0d009c4:	2c00      	cmp	r4, #0
c0d009c6:	2203      	movs	r2, #3
c0d009c8:	2600      	movs	r6, #0
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;
c0d009ca:	4621      	mov	r1, r4
c0d009cc:	4633      	mov	r3, r6
c0d009ce:	f002 fee5 	bl	c0d0379c <__aeabi_uldivmod>
c0d009d2:	4614      	mov	r4, r2
c0d009d4:	9907      	ldr	r1, [sp, #28]

            base[j] = (uint32_t)q;
c0d009d6:	9a08      	ldr	r2, [sp, #32]
c0d009d8:	5088      	str	r0, [r1, r2]
    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
c0d009da:	1e68      	subs	r0, r5, #1
c0d009dc:	2d00      	cmp	r5, #0
c0d009de:	4605      	mov	r5, r0
c0d009e0:	dced      	bgt.n	c0d009be <words_to_trints_u_mem+0x76>
c0d009e2:	9d06      	ldr	r5, [sp, #24]

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d009e4:	b2e8      	uxtb	r0, r5
c0d009e6:	2105      	movs	r1, #5
c0d009e8:	9008      	str	r0, [sp, #32]
c0d009ea:	f002 fde7 	bl	c0d035bc <__aeabi_uidivmod>

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
c0d009ee:	23fe      	movs	r3, #254	; 0xfe
c0d009f0:	43d8      	mvns	r0, r3
c0d009f2:	1b00      	subs	r0, r0, r4

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d009f4:	34ff      	adds	r4, #255	; 0xff

        if (flip_trits) {
c0d009f6:	9a05      	ldr	r2, [sp, #20]
c0d009f8:	2a00      	cmp	r2, #0
c0d009fa:	d100      	bne.n	c0d009fe <words_to_trints_u_mem+0xb6>
c0d009fc:	4620      	mov	r0, r4
c0d009fe:	aa09      	add	r2, sp, #36	; 0x24

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00a00:	5450      	strb	r0, [r2, r1]

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
        }

        if(i%5 == 4) // we've finished a trint, store it
c0d00a02:	2904      	cmp	r1, #4
c0d00a04:	4634      	mov	r4, r6
c0d00a06:	d110      	bne.n	c0d00a2a <words_to_trints_u_mem+0xe2>
c0d00a08:	a809      	add	r0, sp, #36	; 0x24
c0d00a0a:	9403      	str	r4, [sp, #12]
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
c0d00a0c:	2405      	movs	r4, #5
c0d00a0e:	4621      	mov	r1, r4
c0d00a10:	461e      	mov	r6, r3
c0d00a12:	f7ff fba8 	bl	c0d00166 <trits_to_trint>
c0d00a16:	9002      	str	r0, [sp, #8]
c0d00a18:	9808      	ldr	r0, [sp, #32]
c0d00a1a:	4621      	mov	r1, r4
c0d00a1c:	9c03      	ldr	r4, [sp, #12]
c0d00a1e:	f002 fd47 	bl	c0d034b0 <__aeabi_uidiv>
c0d00a22:	4633      	mov	r3, r6
c0d00a24:	9901      	ldr	r1, [sp, #4]
c0d00a26:	9a02      	ldr	r2, [sp, #8]
c0d00a28:	540a      	strb	r2, [r1, r0]
    // Same result up to here!!


    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
c0d00a2a:	1c6d      	adds	r5, r5, #1
c0d00a2c:	402b      	ands	r3, r5
c0d00a2e:	0858      	lsrs	r0, r3, #1
c0d00a30:	2879      	cmp	r0, #121	; 0x79
c0d00a32:	d3c0      	bcc.n	c0d009b6 <words_to_trints_u_mem+0x6e>
c0d00a34:	a809      	add	r0, sp, #36	; 0x24

        if(i%5 == 4) // we've finished a trint, store it
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
    }
    //set very last trit to 0
    trits[2] = 0;
c0d00a36:	7084      	strb	r4, [r0, #2]
    //the last trint %5 won't == 4 so store it manually
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00a38:	2103      	movs	r1, #3
c0d00a3a:	f7ff fb94 	bl	c0d00166 <trits_to_trint>
c0d00a3e:	2130      	movs	r1, #48	; 0x30
c0d00a40:	9a01      	ldr	r2, [sp, #4]
c0d00a42:	5450      	strb	r0, [r2, r1]

    //words_to_trints_u works (same result as official
    return 0;
c0d00a44:	4620      	mov	r0, r4
c0d00a46:	b015      	add	sp, #84	; 0x54
c0d00a48:	bdf0      	pop	{r4, r5, r6, r7, pc}
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);

            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u_mem(base, 1, 12);
c0d00a4a:	2101      	movs	r1, #1
c0d00a4c:	240c      	movs	r4, #12
c0d00a4e:	4628      	mov	r0, r5
c0d00a50:	4622      	mov	r2, r4
c0d00a52:	f7ff fcf0 	bl	c0d00436 <bigint_add_int_u_mem>

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            uint32_t tmp[12];
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00a56:	480a      	ldr	r0, [pc, #40]	; (c0d00a80 <words_to_trints_u_mem+0x138>)
c0d00a58:	4478      	add	r0, pc
c0d00a5a:	ae09      	add	r6, sp, #36	; 0x24
c0d00a5c:	4629      	mov	r1, r5
c0d00a5e:	4632      	mov	r2, r6
c0d00a60:	4623      	mov	r3, r4
c0d00a62:	f7ff fdb8 	bl	c0d005d6 <bigint_sub_bigint_u>
            memcpy(base, tmp, 48);
c0d00a66:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a68:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a6a:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a6c:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a6e:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a70:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a72:	e786      	b.n	c0d00982 <words_to_trints_u_mem+0x3a>
c0d00a74:	000032fa 	.word	0x000032fa
c0d00a78:	000032e2 	.word	0x000032e2
c0d00a7c:	000032d2 	.word	0x000032d2
c0d00a80:	0000321c 	.word	0x0000321c

c0d00a84 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00a84:	b580      	push	{r7, lr}
c0d00a86:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00a88:	2003      	movs	r0, #3
c0d00a8a:	01c1      	lsls	r1, r0, #7
c0d00a8c:	4802      	ldr	r0, [pc, #8]	; (c0d00a98 <kerl_initialize+0x14>)
c0d00a8e:	f001 fba1 	bl	c0d021d4 <cx_keccak_init>
    return 0;
c0d00a92:	2000      	movs	r0, #0
c0d00a94:	bd80      	pop	{r7, pc}
c0d00a96:	46c0      	nop			; (mov r8, r8)
c0d00a98:	20001840 	.word	0x20001840

c0d00a9c <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00a9c:	b580      	push	{r7, lr}
c0d00a9e:	af00      	add	r7, sp, #0
c0d00aa0:	b082      	sub	sp, #8
c0d00aa2:	460b      	mov	r3, r1
c0d00aa4:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00aa6:	4805      	ldr	r0, [pc, #20]	; (c0d00abc <kerl_absorb_bytes+0x20>)
c0d00aa8:	4669      	mov	r1, sp
c0d00aaa:	6008      	str	r0, [r1, #0]
c0d00aac:	4804      	ldr	r0, [pc, #16]	; (c0d00ac0 <kerl_absorb_bytes+0x24>)
c0d00aae:	2101      	movs	r1, #1
c0d00ab0:	f001 fbae 	bl	c0d02210 <cx_hash>
c0d00ab4:	2000      	movs	r0, #0
    return 0;
c0d00ab6:	b002      	add	sp, #8
c0d00ab8:	bd80      	pop	{r7, pc}
c0d00aba:	46c0      	nop			; (mov r8, r8)
c0d00abc:	200019e8 	.word	0x200019e8
c0d00ac0:	20001840 	.word	0x20001840

c0d00ac4 <kerl_absorb_trints2>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints2(trint_t *trints_in, uint16_t len, char *msg)
{
c0d00ac4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ac6:	af03      	add	r7, sp, #12
c0d00ac8:	b0a5      	sub	sp, #148	; 0x94
c0d00aca:	4615      	mov	r5, r2
c0d00acc:	460c      	mov	r4, r1
c0d00ace:	9009      	str	r0, [sp, #36]	; 0x24
c0d00ad0:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00ad2:	4620      	mov	r0, r4
c0d00ad4:	f002 fcec 	bl	c0d034b0 <__aeabi_uidiv>
c0d00ad8:	2c31      	cmp	r4, #49	; 0x31
c0d00ada:	d33c      	bcc.n	c0d00b56 <kerl_absorb_trints2+0x92>
c0d00adc:	2400      	movs	r4, #0
c0d00ade:	9508      	str	r5, [sp, #32]
c0d00ae0:	9007      	str	r0, [sp, #28]
c0d00ae2:	ae19      	add	r6, sp, #100	; 0x64
        // First, convert to bytes
        uint32_t words[12];
        memset(words, 0, sizeof(words));
c0d00ae4:	2130      	movs	r1, #48	; 0x30
c0d00ae6:	910c      	str	r1, [sp, #48]	; 0x30
c0d00ae8:	4630      	mov	r0, r6
c0d00aea:	f002 ff8d 	bl	c0d03a08 <__aeabi_memclr>
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words_u_mem(trints_in, words);
c0d00aee:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d00af0:	4631      	mov	r1, r6
c0d00af2:	f7ff fe91 	bl	c0d00818 <trints_to_words_u_mem>
c0d00af6:	ad0d      	add	r5, sp, #52	; 0x34
c0d00af8:	220c      	movs	r2, #12
        words_to_bytes(words, bytes, 12);
c0d00afa:	4630      	mov	r0, r6
c0d00afc:	4629      	mov	r1, r5
c0d00afe:	f7ff fe68 	bl	c0d007d2 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00b02:	4668      	mov	r0, sp
c0d00b04:	4915      	ldr	r1, [pc, #84]	; (c0d00b5c <kerl_absorb_trints2+0x98>)
c0d00b06:	6001      	str	r1, [r0, #0]
c0d00b08:	2101      	movs	r1, #1
c0d00b0a:	4815      	ldr	r0, [pc, #84]	; (c0d00b60 <kerl_absorb_trints2+0x9c>)
c0d00b0c:	462a      	mov	r2, r5
c0d00b0e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00b10:	f001 fb7e 	bl	c0d02210 <cx_hash>
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words_u_mem(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
        snprintf(msg, 81, "words: %u %u %u bytes: %u %u %u %u %u", words[0], words[1], words[2], bytes[0], bytes[1], bytes[2], bytes[3], bytes[4]);
c0d00b14:	782b      	ldrb	r3, [r5, #0]
c0d00b16:	7868      	ldrb	r0, [r5, #1]
c0d00b18:	900b      	str	r0, [sp, #44]	; 0x2c
c0d00b1a:	78a8      	ldrb	r0, [r5, #2]
c0d00b1c:	900a      	str	r0, [sp, #40]	; 0x28
c0d00b1e:	78ee      	ldrb	r6, [r5, #3]
c0d00b20:	792d      	ldrb	r5, [r5, #4]
c0d00b22:	9819      	ldr	r0, [sp, #100]	; 0x64
c0d00b24:	900c      	str	r0, [sp, #48]	; 0x30
c0d00b26:	9a1a      	ldr	r2, [sp, #104]	; 0x68
c0d00b28:	991b      	ldr	r1, [sp, #108]	; 0x6c
c0d00b2a:	4668      	mov	r0, sp
c0d00b2c:	6002      	str	r2, [r0, #0]
c0d00b2e:	6041      	str	r1, [r0, #4]
c0d00b30:	6083      	str	r3, [r0, #8]
c0d00b32:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d00b34:	60c1      	str	r1, [r0, #12]
c0d00b36:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d00b38:	6101      	str	r1, [r0, #16]
c0d00b3a:	6146      	str	r6, [r0, #20]
c0d00b3c:	6185      	str	r5, [r0, #24]
c0d00b3e:	9d08      	ldr	r5, [sp, #32]
c0d00b40:	2151      	movs	r1, #81	; 0x51
c0d00b42:	4628      	mov	r0, r5
c0d00b44:	a207      	add	r2, pc, #28	; (adr r2, c0d00b64 <kerl_absorb_trints2+0xa0>)
c0d00b46:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00b48:	f001 f848 	bl	c0d01bdc <snprintf>
}

//utilize encoded format
int kerl_absorb_trints2(trint_t *trints_in, uint16_t len, char *msg)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00b4c:	1c64      	adds	r4, r4, #1
c0d00b4e:	b2e0      	uxtb	r0, r4
c0d00b50:	9907      	ldr	r1, [sp, #28]
c0d00b52:	4288      	cmp	r0, r1
c0d00b54:	d3c5      	bcc.n	c0d00ae2 <kerl_absorb_trints2+0x1e>
        trints_to_words_u_mem(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
        snprintf(msg, 81, "words: %u %u %u bytes: %u %u %u %u %u", words[0], words[1], words[2], bytes[0], bytes[1], bytes[2], bytes[3], bytes[4]);
    }
    return 0;
c0d00b56:	2000      	movs	r0, #0
c0d00b58:	b025      	add	sp, #148	; 0x94
c0d00b5a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b5c:	200019e8 	.word	0x200019e8
c0d00b60:	20001840 	.word	0x20001840
c0d00b64:	64726f77 	.word	0x64726f77
c0d00b68:	25203a73 	.word	0x25203a73
c0d00b6c:	75252075 	.word	0x75252075
c0d00b70:	20752520 	.word	0x20752520
c0d00b74:	65747962 	.word	0x65747962
c0d00b78:	25203a73 	.word	0x25203a73
c0d00b7c:	75252075 	.word	0x75252075
c0d00b80:	20752520 	.word	0x20752520
c0d00b84:	25207525 	.word	0x25207525
c0d00b88:	00000075 	.word	0x00000075

c0d00b8c <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00b8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b8e:	af03      	add	r7, sp, #12
c0d00b90:	b091      	sub	sp, #68	; 0x44
c0d00b92:	4605      	mov	r5, r0
    // Convert to trits
    uint32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00b94:	4c1b      	ldr	r4, [pc, #108]	; (c0d00c04 <kerl_squeeze_trints+0x78>)
c0d00b96:	ae05      	add	r6, sp, #20
c0d00b98:	220c      	movs	r2, #12
c0d00b9a:	4620      	mov	r0, r4
c0d00b9c:	4631      	mov	r1, r6
c0d00b9e:	f7ff fded 	bl	c0d0077c <bytes_to_words>
    words_to_trints_u_mem(words, &trints_out[0]);
c0d00ba2:	4630      	mov	r0, r6
c0d00ba4:	9502      	str	r5, [sp, #8]
c0d00ba6:	4629      	mov	r1, r5
c0d00ba8:	f7ff fece 	bl	c0d00948 <words_to_trints_u_mem>

    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00bac:	2030      	movs	r0, #48	; 0x30
c0d00bae:	9003      	str	r0, [sp, #12]
c0d00bb0:	5628      	ldrsb	r0, [r5, r0]
c0d00bb2:	ad04      	add	r5, sp, #16
c0d00bb4:	2203      	movs	r2, #3
c0d00bb6:	9201      	str	r2, [sp, #4]
c0d00bb8:	4629      	mov	r1, r5
c0d00bba:	f7ff fb5b 	bl	c0d00274 <trint_to_trits>
c0d00bbe:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00bc0:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00bc2:	4628      	mov	r0, r5
c0d00bc4:	9d01      	ldr	r5, [sp, #4]
c0d00bc6:	4629      	mov	r1, r5
c0d00bc8:	f7ff facd 	bl	c0d00166 <trits_to_trint>
c0d00bcc:	9903      	ldr	r1, [sp, #12]
c0d00bce:	9a02      	ldr	r2, [sp, #8]
c0d00bd0:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00bd2:	1ba0      	subs	r0, r4, r6
c0d00bd4:	7801      	ldrb	r1, [r0, #0]
c0d00bd6:	43c9      	mvns	r1, r1
c0d00bd8:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00bda:	1e76      	subs	r6, r6, #1
c0d00bdc:	4630      	mov	r0, r6
c0d00bde:	3030      	adds	r0, #48	; 0x30
c0d00be0:	d1f7      	bne.n	c0d00bd2 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00be2:	01e9      	lsls	r1, r5, #7
c0d00be4:	4d08      	ldr	r5, [pc, #32]	; (c0d00c08 <kerl_squeeze_trints+0x7c>)
c0d00be6:	4628      	mov	r0, r5
c0d00be8:	f001 faf4 	bl	c0d021d4 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00bec:	4668      	mov	r0, sp
c0d00bee:	6004      	str	r4, [r0, #0]
c0d00bf0:	2101      	movs	r1, #1
c0d00bf2:	2330      	movs	r3, #48	; 0x30
c0d00bf4:	4628      	mov	r0, r5
c0d00bf6:	4622      	mov	r2, r4
c0d00bf8:	f001 fb0a 	bl	c0d02210 <cx_hash>
c0d00bfc:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00bfe:	b011      	add	sp, #68	; 0x44
c0d00c00:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00c02:	46c0      	nop			; (mov r8, r8)
c0d00c04:	200019e8 	.word	0x200019e8
c0d00c08:	20001840 	.word	0x20001840

c0d00c0c <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00c0c:	b580      	push	{r7, lr}
c0d00c0e:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00c10:	4804      	ldr	r0, [pc, #16]	; (c0d00c24 <nvram_is_init+0x18>)
c0d00c12:	f001 fa33 	bl	c0d0207c <pic>
c0d00c16:	7801      	ldrb	r1, [r0, #0]
c0d00c18:	2000      	movs	r0, #0
c0d00c1a:	2901      	cmp	r1, #1
c0d00c1c:	d100      	bne.n	c0d00c20 <nvram_is_init+0x14>
c0d00c1e:	4608      	mov	r0, r1
    else return true;
}
c0d00c20:	bd80      	pop	{r7, pc}
c0d00c22:	46c0      	nop			; (mov r8, r8)
c0d00c24:	c0d04080 	.word	0xc0d04080

c0d00c28 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00c28:	b5b0      	push	{r4, r5, r7, lr}
c0d00c2a:	af02      	add	r7, sp, #8
c0d00c2c:	4605      	mov	r5, r0
c0d00c2e:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00c30:	4028      	ands	r0, r5
c0d00c32:	2400      	movs	r4, #0
c0d00c34:	2801      	cmp	r0, #1
c0d00c36:	d013      	beq.n	c0d00c60 <io_exchange_al+0x38>
c0d00c38:	2802      	cmp	r0, #2
c0d00c3a:	d113      	bne.n	c0d00c64 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00c3c:	2900      	cmp	r1, #0
c0d00c3e:	d008      	beq.n	c0d00c52 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00c40:	480b      	ldr	r0, [pc, #44]	; (c0d00c70 <io_exchange_al+0x48>)
c0d00c42:	f001 fbd7 	bl	c0d023f4 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00c46:	b268      	sxtb	r0, r5
c0d00c48:	2800      	cmp	r0, #0
c0d00c4a:	da09      	bge.n	c0d00c60 <io_exchange_al+0x38>
                reset();
c0d00c4c:	f001 fa4c 	bl	c0d020e8 <reset>
c0d00c50:	e006      	b.n	c0d00c60 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00c52:	2041      	movs	r0, #65	; 0x41
c0d00c54:	0081      	lsls	r1, r0, #2
c0d00c56:	4806      	ldr	r0, [pc, #24]	; (c0d00c70 <io_exchange_al+0x48>)
c0d00c58:	2200      	movs	r2, #0
c0d00c5a:	f001 fc05 	bl	c0d02468 <io_seproxyhal_spi_recv>
c0d00c5e:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00c60:	4620      	mov	r0, r4
c0d00c62:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00c64:	4803      	ldr	r0, [pc, #12]	; (c0d00c74 <io_exchange_al+0x4c>)
c0d00c66:	6800      	ldr	r0, [r0, #0]
c0d00c68:	2102      	movs	r1, #2
c0d00c6a:	f002 ff6f 	bl	c0d03b4c <longjmp>
c0d00c6e:	46c0      	nop			; (mov r8, r8)
c0d00c70:	20001c08 	.word	0x20001c08
c0d00c74:	20001bb8 	.word	0x20001bb8

c0d00c78 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00c78:	b580      	push	{r7, lr}
c0d00c7a:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c7c:	f000 fe8e 	bl	c0d0199c <io_seproxyhal_display_default>
}
c0d00c80:	bd80      	pop	{r7, pc}
	...

c0d00c84 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00c84:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c86:	af03      	add	r7, sp, #12
c0d00c88:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00c8a:	48a6      	ldr	r0, [pc, #664]	; (c0d00f24 <io_event+0x2a0>)
c0d00c8c:	7800      	ldrb	r0, [r0, #0]
c0d00c8e:	2805      	cmp	r0, #5
c0d00c90:	d02e      	beq.n	c0d00cf0 <io_event+0x6c>
c0d00c92:	280d      	cmp	r0, #13
c0d00c94:	d04e      	beq.n	c0d00d34 <io_event+0xb0>
c0d00c96:	280c      	cmp	r0, #12
c0d00c98:	d000      	beq.n	c0d00c9c <io_event+0x18>
c0d00c9a:	e13a      	b.n	c0d00f12 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c9c:	4ea2      	ldr	r6, [pc, #648]	; (c0d00f28 <io_event+0x2a4>)
c0d00c9e:	2001      	movs	r0, #1
c0d00ca0:	7630      	strb	r0, [r6, #24]
c0d00ca2:	2500      	movs	r5, #0
c0d00ca4:	61f5      	str	r5, [r6, #28]
c0d00ca6:	4634      	mov	r4, r6
c0d00ca8:	3418      	adds	r4, #24
c0d00caa:	4620      	mov	r0, r4
c0d00cac:	f001 fb68 	bl	c0d02380 <os_ux>
c0d00cb0:	61f0      	str	r0, [r6, #28]
c0d00cb2:	499e      	ldr	r1, [pc, #632]	; (c0d00f2c <io_event+0x2a8>)
c0d00cb4:	4288      	cmp	r0, r1
c0d00cb6:	d100      	bne.n	c0d00cba <io_event+0x36>
c0d00cb8:	e12b      	b.n	c0d00f12 <io_event+0x28e>
c0d00cba:	2800      	cmp	r0, #0
c0d00cbc:	d100      	bne.n	c0d00cc0 <io_event+0x3c>
c0d00cbe:	e128      	b.n	c0d00f12 <io_event+0x28e>
c0d00cc0:	499b      	ldr	r1, [pc, #620]	; (c0d00f30 <io_event+0x2ac>)
c0d00cc2:	4288      	cmp	r0, r1
c0d00cc4:	d000      	beq.n	c0d00cc8 <io_event+0x44>
c0d00cc6:	e0ac      	b.n	c0d00e22 <io_event+0x19e>
c0d00cc8:	2003      	movs	r0, #3
c0d00cca:	7630      	strb	r0, [r6, #24]
c0d00ccc:	61f5      	str	r5, [r6, #28]
c0d00cce:	4620      	mov	r0, r4
c0d00cd0:	f001 fb56 	bl	c0d02380 <os_ux>
c0d00cd4:	61f0      	str	r0, [r6, #28]
c0d00cd6:	f000 fd17 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d00cda:	60b5      	str	r5, [r6, #8]
c0d00cdc:	6830      	ldr	r0, [r6, #0]
c0d00cde:	2800      	cmp	r0, #0
c0d00ce0:	d100      	bne.n	c0d00ce4 <io_event+0x60>
c0d00ce2:	e116      	b.n	c0d00f12 <io_event+0x28e>
c0d00ce4:	69f0      	ldr	r0, [r6, #28]
c0d00ce6:	4991      	ldr	r1, [pc, #580]	; (c0d00f2c <io_event+0x2a8>)
c0d00ce8:	4288      	cmp	r0, r1
c0d00cea:	d000      	beq.n	c0d00cee <io_event+0x6a>
c0d00cec:	e096      	b.n	c0d00e1c <io_event+0x198>
c0d00cee:	e110      	b.n	c0d00f12 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00cf0:	4d8d      	ldr	r5, [pc, #564]	; (c0d00f28 <io_event+0x2a4>)
c0d00cf2:	2001      	movs	r0, #1
c0d00cf4:	7628      	strb	r0, [r5, #24]
c0d00cf6:	2600      	movs	r6, #0
c0d00cf8:	61ee      	str	r6, [r5, #28]
c0d00cfa:	462c      	mov	r4, r5
c0d00cfc:	3418      	adds	r4, #24
c0d00cfe:	4620      	mov	r0, r4
c0d00d00:	f001 fb3e 	bl	c0d02380 <os_ux>
c0d00d04:	4601      	mov	r1, r0
c0d00d06:	61e9      	str	r1, [r5, #28]
c0d00d08:	4889      	ldr	r0, [pc, #548]	; (c0d00f30 <io_event+0x2ac>)
c0d00d0a:	4281      	cmp	r1, r0
c0d00d0c:	d15d      	bne.n	c0d00dca <io_event+0x146>
c0d00d0e:	2003      	movs	r0, #3
c0d00d10:	7628      	strb	r0, [r5, #24]
c0d00d12:	61ee      	str	r6, [r5, #28]
c0d00d14:	4620      	mov	r0, r4
c0d00d16:	f001 fb33 	bl	c0d02380 <os_ux>
c0d00d1a:	61e8      	str	r0, [r5, #28]
c0d00d1c:	f000 fcf4 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d00d20:	60ae      	str	r6, [r5, #8]
c0d00d22:	6828      	ldr	r0, [r5, #0]
c0d00d24:	2800      	cmp	r0, #0
c0d00d26:	d100      	bne.n	c0d00d2a <io_event+0xa6>
c0d00d28:	e0f3      	b.n	c0d00f12 <io_event+0x28e>
c0d00d2a:	69e8      	ldr	r0, [r5, #28]
c0d00d2c:	497f      	ldr	r1, [pc, #508]	; (c0d00f2c <io_event+0x2a8>)
c0d00d2e:	4288      	cmp	r0, r1
c0d00d30:	d148      	bne.n	c0d00dc4 <io_event+0x140>
c0d00d32:	e0ee      	b.n	c0d00f12 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00d34:	4d7c      	ldr	r5, [pc, #496]	; (c0d00f28 <io_event+0x2a4>)
c0d00d36:	6868      	ldr	r0, [r5, #4]
c0d00d38:	68a9      	ldr	r1, [r5, #8]
c0d00d3a:	4281      	cmp	r1, r0
c0d00d3c:	d300      	bcc.n	c0d00d40 <io_event+0xbc>
c0d00d3e:	e0e8      	b.n	c0d00f12 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00d40:	2001      	movs	r0, #1
c0d00d42:	7628      	strb	r0, [r5, #24]
c0d00d44:	2600      	movs	r6, #0
c0d00d46:	61ee      	str	r6, [r5, #28]
c0d00d48:	462c      	mov	r4, r5
c0d00d4a:	3418      	adds	r4, #24
c0d00d4c:	4620      	mov	r0, r4
c0d00d4e:	f001 fb17 	bl	c0d02380 <os_ux>
c0d00d52:	61e8      	str	r0, [r5, #28]
c0d00d54:	4975      	ldr	r1, [pc, #468]	; (c0d00f2c <io_event+0x2a8>)
c0d00d56:	4288      	cmp	r0, r1
c0d00d58:	d100      	bne.n	c0d00d5c <io_event+0xd8>
c0d00d5a:	e0da      	b.n	c0d00f12 <io_event+0x28e>
c0d00d5c:	2800      	cmp	r0, #0
c0d00d5e:	d100      	bne.n	c0d00d62 <io_event+0xde>
c0d00d60:	e0d7      	b.n	c0d00f12 <io_event+0x28e>
c0d00d62:	4973      	ldr	r1, [pc, #460]	; (c0d00f30 <io_event+0x2ac>)
c0d00d64:	4288      	cmp	r0, r1
c0d00d66:	d000      	beq.n	c0d00d6a <io_event+0xe6>
c0d00d68:	e08d      	b.n	c0d00e86 <io_event+0x202>
c0d00d6a:	2003      	movs	r0, #3
c0d00d6c:	7628      	strb	r0, [r5, #24]
c0d00d6e:	61ee      	str	r6, [r5, #28]
c0d00d70:	4620      	mov	r0, r4
c0d00d72:	f001 fb05 	bl	c0d02380 <os_ux>
c0d00d76:	61e8      	str	r0, [r5, #28]
c0d00d78:	f000 fcc6 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d00d7c:	60ae      	str	r6, [r5, #8]
c0d00d7e:	6828      	ldr	r0, [r5, #0]
c0d00d80:	2800      	cmp	r0, #0
c0d00d82:	d100      	bne.n	c0d00d86 <io_event+0x102>
c0d00d84:	e0c5      	b.n	c0d00f12 <io_event+0x28e>
c0d00d86:	69e8      	ldr	r0, [r5, #28]
c0d00d88:	4968      	ldr	r1, [pc, #416]	; (c0d00f2c <io_event+0x2a8>)
c0d00d8a:	4288      	cmp	r0, r1
c0d00d8c:	d178      	bne.n	c0d00e80 <io_event+0x1fc>
c0d00d8e:	e0c0      	b.n	c0d00f12 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d90:	6868      	ldr	r0, [r5, #4]
c0d00d92:	4286      	cmp	r6, r0
c0d00d94:	d300      	bcc.n	c0d00d98 <io_event+0x114>
c0d00d96:	e0bc      	b.n	c0d00f12 <io_event+0x28e>
c0d00d98:	f001 fb4a 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00d9c:	2800      	cmp	r0, #0
c0d00d9e:	d000      	beq.n	c0d00da2 <io_event+0x11e>
c0d00da0:	e0b7      	b.n	c0d00f12 <io_event+0x28e>
c0d00da2:	68a8      	ldr	r0, [r5, #8]
c0d00da4:	68e9      	ldr	r1, [r5, #12]
c0d00da6:	2438      	movs	r4, #56	; 0x38
c0d00da8:	4360      	muls	r0, r4
c0d00daa:	682a      	ldr	r2, [r5, #0]
c0d00dac:	1810      	adds	r0, r2, r0
c0d00dae:	2900      	cmp	r1, #0
c0d00db0:	d100      	bne.n	c0d00db4 <io_event+0x130>
c0d00db2:	e085      	b.n	c0d00ec0 <io_event+0x23c>
c0d00db4:	4788      	blx	r1
c0d00db6:	2800      	cmp	r0, #0
c0d00db8:	d000      	beq.n	c0d00dbc <io_event+0x138>
c0d00dba:	e081      	b.n	c0d00ec0 <io_event+0x23c>
c0d00dbc:	68a8      	ldr	r0, [r5, #8]
c0d00dbe:	1c46      	adds	r6, r0, #1
c0d00dc0:	60ae      	str	r6, [r5, #8]
c0d00dc2:	6828      	ldr	r0, [r5, #0]
c0d00dc4:	2800      	cmp	r0, #0
c0d00dc6:	d1e3      	bne.n	c0d00d90 <io_event+0x10c>
c0d00dc8:	e0a3      	b.n	c0d00f12 <io_event+0x28e>
c0d00dca:	6928      	ldr	r0, [r5, #16]
c0d00dcc:	2800      	cmp	r0, #0
c0d00dce:	d100      	bne.n	c0d00dd2 <io_event+0x14e>
c0d00dd0:	e09f      	b.n	c0d00f12 <io_event+0x28e>
c0d00dd2:	4a56      	ldr	r2, [pc, #344]	; (c0d00f2c <io_event+0x2a8>)
c0d00dd4:	4291      	cmp	r1, r2
c0d00dd6:	d100      	bne.n	c0d00dda <io_event+0x156>
c0d00dd8:	e09b      	b.n	c0d00f12 <io_event+0x28e>
c0d00dda:	2900      	cmp	r1, #0
c0d00ddc:	d100      	bne.n	c0d00de0 <io_event+0x15c>
c0d00dde:	e098      	b.n	c0d00f12 <io_event+0x28e>
c0d00de0:	4950      	ldr	r1, [pc, #320]	; (c0d00f24 <io_event+0x2a0>)
c0d00de2:	78c9      	ldrb	r1, [r1, #3]
c0d00de4:	0849      	lsrs	r1, r1, #1
c0d00de6:	f000 fe1b 	bl	c0d01a20 <io_seproxyhal_button_push>
c0d00dea:	e092      	b.n	c0d00f12 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00dec:	6870      	ldr	r0, [r6, #4]
c0d00dee:	4285      	cmp	r5, r0
c0d00df0:	d300      	bcc.n	c0d00df4 <io_event+0x170>
c0d00df2:	e08e      	b.n	c0d00f12 <io_event+0x28e>
c0d00df4:	f001 fb1c 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00df8:	2800      	cmp	r0, #0
c0d00dfa:	d000      	beq.n	c0d00dfe <io_event+0x17a>
c0d00dfc:	e089      	b.n	c0d00f12 <io_event+0x28e>
c0d00dfe:	68b0      	ldr	r0, [r6, #8]
c0d00e00:	68f1      	ldr	r1, [r6, #12]
c0d00e02:	2438      	movs	r4, #56	; 0x38
c0d00e04:	4360      	muls	r0, r4
c0d00e06:	6832      	ldr	r2, [r6, #0]
c0d00e08:	1810      	adds	r0, r2, r0
c0d00e0a:	2900      	cmp	r1, #0
c0d00e0c:	d076      	beq.n	c0d00efc <io_event+0x278>
c0d00e0e:	4788      	blx	r1
c0d00e10:	2800      	cmp	r0, #0
c0d00e12:	d173      	bne.n	c0d00efc <io_event+0x278>
c0d00e14:	68b0      	ldr	r0, [r6, #8]
c0d00e16:	1c45      	adds	r5, r0, #1
c0d00e18:	60b5      	str	r5, [r6, #8]
c0d00e1a:	6830      	ldr	r0, [r6, #0]
c0d00e1c:	2800      	cmp	r0, #0
c0d00e1e:	d1e5      	bne.n	c0d00dec <io_event+0x168>
c0d00e20:	e077      	b.n	c0d00f12 <io_event+0x28e>
c0d00e22:	88b0      	ldrh	r0, [r6, #4]
c0d00e24:	9004      	str	r0, [sp, #16]
c0d00e26:	6830      	ldr	r0, [r6, #0]
c0d00e28:	9003      	str	r0, [sp, #12]
c0d00e2a:	483e      	ldr	r0, [pc, #248]	; (c0d00f24 <io_event+0x2a0>)
c0d00e2c:	4601      	mov	r1, r0
c0d00e2e:	79cc      	ldrb	r4, [r1, #7]
c0d00e30:	798b      	ldrb	r3, [r1, #6]
c0d00e32:	794d      	ldrb	r5, [r1, #5]
c0d00e34:	790a      	ldrb	r2, [r1, #4]
c0d00e36:	4630      	mov	r0, r6
c0d00e38:	78ce      	ldrb	r6, [r1, #3]
c0d00e3a:	68c1      	ldr	r1, [r0, #12]
c0d00e3c:	4668      	mov	r0, sp
c0d00e3e:	6006      	str	r6, [r0, #0]
c0d00e40:	6041      	str	r1, [r0, #4]
c0d00e42:	0212      	lsls	r2, r2, #8
c0d00e44:	432a      	orrs	r2, r5
c0d00e46:	021b      	lsls	r3, r3, #8
c0d00e48:	4323      	orrs	r3, r4
c0d00e4a:	9803      	ldr	r0, [sp, #12]
c0d00e4c:	9904      	ldr	r1, [sp, #16]
c0d00e4e:	f000 fcd5 	bl	c0d017fc <io_seproxyhal_touch_element_callback>
c0d00e52:	e05e      	b.n	c0d00f12 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00e54:	6868      	ldr	r0, [r5, #4]
c0d00e56:	4286      	cmp	r6, r0
c0d00e58:	d25b      	bcs.n	c0d00f12 <io_event+0x28e>
c0d00e5a:	f001 fae9 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00e5e:	2800      	cmp	r0, #0
c0d00e60:	d157      	bne.n	c0d00f12 <io_event+0x28e>
c0d00e62:	68a8      	ldr	r0, [r5, #8]
c0d00e64:	68e9      	ldr	r1, [r5, #12]
c0d00e66:	2438      	movs	r4, #56	; 0x38
c0d00e68:	4360      	muls	r0, r4
c0d00e6a:	682a      	ldr	r2, [r5, #0]
c0d00e6c:	1810      	adds	r0, r2, r0
c0d00e6e:	2900      	cmp	r1, #0
c0d00e70:	d026      	beq.n	c0d00ec0 <io_event+0x23c>
c0d00e72:	4788      	blx	r1
c0d00e74:	2800      	cmp	r0, #0
c0d00e76:	d123      	bne.n	c0d00ec0 <io_event+0x23c>
c0d00e78:	68a8      	ldr	r0, [r5, #8]
c0d00e7a:	1c46      	adds	r6, r0, #1
c0d00e7c:	60ae      	str	r6, [r5, #8]
c0d00e7e:	6828      	ldr	r0, [r5, #0]
c0d00e80:	2800      	cmp	r0, #0
c0d00e82:	d1e7      	bne.n	c0d00e54 <io_event+0x1d0>
c0d00e84:	e045      	b.n	c0d00f12 <io_event+0x28e>
c0d00e86:	6828      	ldr	r0, [r5, #0]
c0d00e88:	2800      	cmp	r0, #0
c0d00e8a:	d030      	beq.n	c0d00eee <io_event+0x26a>
c0d00e8c:	68a8      	ldr	r0, [r5, #8]
c0d00e8e:	6869      	ldr	r1, [r5, #4]
c0d00e90:	4288      	cmp	r0, r1
c0d00e92:	d22c      	bcs.n	c0d00eee <io_event+0x26a>
c0d00e94:	f001 facc 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00e98:	2800      	cmp	r0, #0
c0d00e9a:	d128      	bne.n	c0d00eee <io_event+0x26a>
c0d00e9c:	68a8      	ldr	r0, [r5, #8]
c0d00e9e:	68e9      	ldr	r1, [r5, #12]
c0d00ea0:	2438      	movs	r4, #56	; 0x38
c0d00ea2:	4360      	muls	r0, r4
c0d00ea4:	682a      	ldr	r2, [r5, #0]
c0d00ea6:	1810      	adds	r0, r2, r0
c0d00ea8:	2900      	cmp	r1, #0
c0d00eaa:	d015      	beq.n	c0d00ed8 <io_event+0x254>
c0d00eac:	4788      	blx	r1
c0d00eae:	2800      	cmp	r0, #0
c0d00eb0:	d112      	bne.n	c0d00ed8 <io_event+0x254>
c0d00eb2:	68a8      	ldr	r0, [r5, #8]
c0d00eb4:	1c40      	adds	r0, r0, #1
c0d00eb6:	60a8      	str	r0, [r5, #8]
c0d00eb8:	6829      	ldr	r1, [r5, #0]
c0d00eba:	2900      	cmp	r1, #0
c0d00ebc:	d1e7      	bne.n	c0d00e8e <io_event+0x20a>
c0d00ebe:	e016      	b.n	c0d00eee <io_event+0x26a>
c0d00ec0:	2801      	cmp	r0, #1
c0d00ec2:	d103      	bne.n	c0d00ecc <io_event+0x248>
c0d00ec4:	68a8      	ldr	r0, [r5, #8]
c0d00ec6:	4344      	muls	r4, r0
c0d00ec8:	6828      	ldr	r0, [r5, #0]
c0d00eca:	1900      	adds	r0, r0, r4
c0d00ecc:	f000 fd66 	bl	c0d0199c <io_seproxyhal_display_default>
c0d00ed0:	68a8      	ldr	r0, [r5, #8]
c0d00ed2:	1c40      	adds	r0, r0, #1
c0d00ed4:	60a8      	str	r0, [r5, #8]
c0d00ed6:	e01c      	b.n	c0d00f12 <io_event+0x28e>
c0d00ed8:	2801      	cmp	r0, #1
c0d00eda:	d103      	bne.n	c0d00ee4 <io_event+0x260>
c0d00edc:	68a8      	ldr	r0, [r5, #8]
c0d00ede:	4344      	muls	r4, r0
c0d00ee0:	6828      	ldr	r0, [r5, #0]
c0d00ee2:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00ee4:	f000 fd5a 	bl	c0d0199c <io_seproxyhal_display_default>
c0d00ee8:	68a8      	ldr	r0, [r5, #8]
c0d00eea:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00eec:	60a8      	str	r0, [r5, #8]
c0d00eee:	6868      	ldr	r0, [r5, #4]
c0d00ef0:	68a9      	ldr	r1, [r5, #8]
c0d00ef2:	4281      	cmp	r1, r0
c0d00ef4:	d30d      	bcc.n	c0d00f12 <io_event+0x28e>
c0d00ef6:	f001 fa9b 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00efa:	e00a      	b.n	c0d00f12 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00efc:	2801      	cmp	r0, #1
c0d00efe:	d103      	bne.n	c0d00f08 <io_event+0x284>
c0d00f00:	68b0      	ldr	r0, [r6, #8]
c0d00f02:	4344      	muls	r4, r0
c0d00f04:	6830      	ldr	r0, [r6, #0]
c0d00f06:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00f08:	f000 fd48 	bl	c0d0199c <io_seproxyhal_display_default>
c0d00f0c:	68b0      	ldr	r0, [r6, #8]
c0d00f0e:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00f10:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00f12:	f001 fa8d 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d00f16:	2800      	cmp	r0, #0
c0d00f18:	d101      	bne.n	c0d00f1e <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00f1a:	f000 fac9 	bl	c0d014b0 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00f1e:	2001      	movs	r0, #1
c0d00f20:	b005      	add	sp, #20
c0d00f22:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f24:	20001a18 	.word	0x20001a18
c0d00f28:	20001a98 	.word	0x20001a98
c0d00f2c:	b0105044 	.word	0xb0105044
c0d00f30:	b0105055 	.word	0xb0105055

c0d00f34 <IOTA_main>:





static void IOTA_main(void) {
c0d00f34:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f36:	af03      	add	r7, sp, #12
c0d00f38:	b0dd      	sub	sp, #372	; 0x174
c0d00f3a:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00f3c:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00f3e:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00f40:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00f42:	a0a1      	add	r0, pc, #644	; (adr r0, c0d011c8 <IOTA_main+0x294>)
c0d00f44:	2110      	movs	r1, #16
c0d00f46:	2203      	movs	r2, #3
c0d00f48:	9109      	str	r1, [sp, #36]	; 0x24
c0d00f4a:	9208      	str	r2, [sp, #32]
c0d00f4c:	f7ff f8aa 	bl	c0d000a4 <write_debug>
c0d00f50:	a80e      	add	r0, sp, #56	; 0x38
c0d00f52:	304d      	adds	r0, #77	; 0x4d
c0d00f54:	9007      	str	r0, [sp, #28]
c0d00f56:	a80b      	add	r0, sp, #44	; 0x2c
c0d00f58:	1dc1      	adds	r1, r0, #7
c0d00f5a:	9106      	str	r1, [sp, #24]
c0d00f5c:	1d00      	adds	r0, r0, #4
c0d00f5e:	9005      	str	r0, [sp, #20]
c0d00f60:	4e9d      	ldr	r6, [pc, #628]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d00f62:	6830      	ldr	r0, [r6, #0]
c0d00f64:	e08d      	b.n	c0d01082 <IOTA_main+0x14e>
c0d00f66:	489f      	ldr	r0, [pc, #636]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d00f68:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00f6a:	4330      	orrs	r0, r6
c0d00f6c:	2880      	cmp	r0, #128	; 0x80
c0d00f6e:	d000      	beq.n	c0d00f72 <IOTA_main+0x3e>
c0d00f70:	e11e      	b.n	c0d011b0 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00f72:	7810      	ldrb	r0, [r2, #0]
c0d00f74:	2800      	cmp	r0, #0
c0d00f76:	4e98      	ldr	r6, [pc, #608]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d00f78:	d004      	beq.n	c0d00f84 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00f7a:	489c      	ldr	r0, [pc, #624]	; (c0d011ec <IOTA_main+0x2b8>)
c0d00f7c:	f001 f90c 	bl	c0d02198 <cx_sha256_init>
                        hashTainted = 0;
c0d00f80:	4899      	ldr	r0, [pc, #612]	; (c0d011e8 <IOTA_main+0x2b4>)
c0d00f82:	7004      	strb	r4, [r0, #0]
c0d00f84:	4897      	ldr	r0, [pc, #604]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d00f86:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00f88:	7908      	ldrb	r0, [r1, #4]
c0d00f8a:	1808      	adds	r0, r1, r0
c0d00f8c:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00f8e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f90:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00f92:	4308      	orrs	r0, r1
c0d00f94:	905a      	str	r0, [sp, #360]	; 0x168
c0d00f96:	e0e5      	b.n	c0d01164 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00f98:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00f9a:	2818      	cmp	r0, #24
c0d00f9c:	d800      	bhi.n	c0d00fa0 <IOTA_main+0x6c>
c0d00f9e:	e10c      	b.n	c0d011ba <IOTA_main+0x286>
c0d00fa0:	950a      	str	r5, [sp, #40]	; 0x28
c0d00fa2:	4d90      	ldr	r5, [pc, #576]	; (c0d011e4 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00fa4:	00a0      	lsls	r0, r4, #2
c0d00fa6:	1829      	adds	r1, r5, r0
c0d00fa8:	794a      	ldrb	r2, [r1, #5]
c0d00faa:	0612      	lsls	r2, r2, #24
c0d00fac:	798b      	ldrb	r3, [r1, #6]
c0d00fae:	041b      	lsls	r3, r3, #16
c0d00fb0:	4313      	orrs	r3, r2
c0d00fb2:	79ca      	ldrb	r2, [r1, #7]
c0d00fb4:	0212      	lsls	r2, r2, #8
c0d00fb6:	431a      	orrs	r2, r3
c0d00fb8:	7a09      	ldrb	r1, [r1, #8]
c0d00fba:	4311      	orrs	r1, r2
c0d00fbc:	aa2b      	add	r2, sp, #172	; 0xac
c0d00fbe:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00fc0:	1c64      	adds	r4, r4, #1
c0d00fc2:	2c05      	cmp	r4, #5
c0d00fc4:	d1ee      	bne.n	c0d00fa4 <IOTA_main+0x70>
c0d00fc6:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00fc8:	9103      	str	r1, [sp, #12]
c0d00fca:	4668      	mov	r0, sp
c0d00fcc:	6001      	str	r1, [r0, #0]
c0d00fce:	2421      	movs	r4, #33	; 0x21
c0d00fd0:	a92b      	add	r1, sp, #172	; 0xac
c0d00fd2:	2205      	movs	r2, #5
c0d00fd4:	ad23      	add	r5, sp, #140	; 0x8c
c0d00fd6:	9502      	str	r5, [sp, #8]
c0d00fd8:	4620      	mov	r0, r4
c0d00fda:	462b      	mov	r3, r5
c0d00fdc:	f001 f992 	bl	c0d02304 <os_perso_derive_node_bip32>
c0d00fe0:	2220      	movs	r2, #32
c0d00fe2:	9204      	str	r2, [sp, #16]
c0d00fe4:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00fe6:	9301      	str	r3, [sp, #4]
c0d00fe8:	4620      	mov	r0, r4
c0d00fea:	4629      	mov	r1, r5
c0d00fec:	f001 f94e 	bl	c0d0228c <cx_ecfp_init_private_key>
c0d00ff0:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00ff2:	4620      	mov	r0, r4
c0d00ff4:	9903      	ldr	r1, [sp, #12]
c0d00ff6:	460a      	mov	r2, r1
c0d00ff8:	462b      	mov	r3, r5
c0d00ffa:	f001 f929 	bl	c0d02250 <cx_ecfp_init_public_key>
c0d00ffe:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d01000:	4620      	mov	r0, r4
c0d01002:	4629      	mov	r1, r5
c0d01004:	9a01      	ldr	r2, [sp, #4]
c0d01006:	f001 f95f 	bl	c0d022c8 <cx_ecfp_generate_pair>
c0d0100a:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d0100c:	9802      	ldr	r0, [sp, #8]
c0d0100e:	9904      	ldr	r1, [sp, #16]
c0d01010:	4622      	mov	r2, r4
c0d01012:	f7ff f967 	bl	c0d002e4 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d01016:	2552      	movs	r5, #82	; 0x52
c0d01018:	4872      	ldr	r0, [pc, #456]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d0101a:	4621      	mov	r1, r4
c0d0101c:	462a      	mov	r2, r5
c0d0101e:	f000 f9ad 	bl	c0d0137c <os_memmove>
                    tx = 82;
c0d01022:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d01024:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01026:	1c41      	adds	r1, r0, #1
c0d01028:	915b      	str	r1, [sp, #364]	; 0x16c
c0d0102a:	3610      	adds	r6, #16
c0d0102c:	4a6d      	ldr	r2, [pc, #436]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d0102e:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d01030:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01032:	1c41      	adds	r1, r0, #1
c0d01034:	915b      	str	r1, [sp, #364]	; 0x16c
c0d01036:	9903      	ldr	r1, [sp, #12]
c0d01038:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0103a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0103c:	b281      	uxth	r1, r0
c0d0103e:	9804      	ldr	r0, [sp, #16]
c0d01040:	f000 fd2a 	bl	c0d01a98 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d01044:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01046:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01048:	4308      	orrs	r0, r1
c0d0104a:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d0104c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0104e:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d01050:	202e      	movs	r0, #46	; 0x2e
c0d01052:	9905      	ldr	r1, [sp, #20]
c0d01054:	7048      	strb	r0, [r1, #1]
c0d01056:	7008      	strb	r0, [r1, #0]
c0d01058:	7088      	strb	r0, [r1, #2]
c0d0105a:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d0105c:	78c8      	ldrb	r0, [r1, #3]
c0d0105e:	9a06      	ldr	r2, [sp, #24]
c0d01060:	70d0      	strb	r0, [r2, #3]
c0d01062:	7888      	ldrb	r0, [r1, #2]
c0d01064:	7090      	strb	r0, [r2, #2]
c0d01066:	7848      	ldrb	r0, [r1, #1]
c0d01068:	7050      	strb	r0, [r2, #1]
c0d0106a:	7808      	ldrb	r0, [r1, #0]
c0d0106c:	7010      	strb	r0, [r2, #0]
c0d0106e:	7908      	ldrb	r0, [r1, #4]
c0d01070:	7110      	strb	r0, [r2, #4]
c0d01072:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d01074:	2140      	movs	r1, #64	; 0x40
c0d01076:	2203      	movs	r2, #3
c0d01078:	f001 fa8a 	bl	c0d02590 <ui_display_debug>
c0d0107c:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d0107e:	4e56      	ldr	r6, [pc, #344]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d01080:	e070      	b.n	c0d01164 <IOTA_main+0x230>
c0d01082:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d01084:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d01086:	9057      	str	r0, [sp, #348]	; 0x15c
c0d01088:	ac4d      	add	r4, sp, #308	; 0x134
c0d0108a:	4620      	mov	r0, r4
c0d0108c:	f002 fd52 	bl	c0d03b34 <setjmp>
c0d01090:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d01092:	6034      	str	r4, [r6, #0]
c0d01094:	4951      	ldr	r1, [pc, #324]	; (c0d011dc <IOTA_main+0x2a8>)
c0d01096:	4208      	tst	r0, r1
c0d01098:	d011      	beq.n	c0d010be <IOTA_main+0x18a>
c0d0109a:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d0109c:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d0109e:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d010a0:	6031      	str	r1, [r6, #0]
c0d010a2:	210f      	movs	r1, #15
c0d010a4:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d010a6:	4001      	ands	r1, r0
c0d010a8:	2209      	movs	r2, #9
c0d010aa:	0312      	lsls	r2, r2, #12
c0d010ac:	4291      	cmp	r1, r2
c0d010ae:	d003      	beq.n	c0d010b8 <IOTA_main+0x184>
c0d010b0:	9a08      	ldr	r2, [sp, #32]
c0d010b2:	0352      	lsls	r2, r2, #13
c0d010b4:	4291      	cmp	r1, r2
c0d010b6:	d142      	bne.n	c0d0113e <IOTA_main+0x20a>
c0d010b8:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d010ba:	8008      	strh	r0, [r1, #0]
c0d010bc:	e046      	b.n	c0d0114c <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d010be:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010c0:	905c      	str	r0, [sp, #368]	; 0x170
c0d010c2:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d010c4:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d010c6:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d010c8:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d010ca:	b2c0      	uxtb	r0, r0
c0d010cc:	b289      	uxth	r1, r1
c0d010ce:	f000 fce3 	bl	c0d01a98 <io_exchange>
c0d010d2:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d010d4:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d010d6:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d010d8:	2800      	cmp	r0, #0
c0d010da:	d053      	beq.n	c0d01184 <IOTA_main+0x250>
c0d010dc:	4941      	ldr	r1, [pc, #260]	; (c0d011e4 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d010de:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d010e0:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d010e2:	2880      	cmp	r0, #128	; 0x80
c0d010e4:	4a40      	ldr	r2, [pc, #256]	; (c0d011e8 <IOTA_main+0x2b4>)
c0d010e6:	d155      	bne.n	c0d01194 <IOTA_main+0x260>
c0d010e8:	7848      	ldrb	r0, [r1, #1]
c0d010ea:	216d      	movs	r1, #109	; 0x6d
c0d010ec:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d010ee:	2807      	cmp	r0, #7
c0d010f0:	dc3f      	bgt.n	c0d01172 <IOTA_main+0x23e>
c0d010f2:	2802      	cmp	r0, #2
c0d010f4:	d100      	bne.n	c0d010f8 <IOTA_main+0x1c4>
c0d010f6:	e74f      	b.n	c0d00f98 <IOTA_main+0x64>
c0d010f8:	2804      	cmp	r0, #4
c0d010fa:	d153      	bne.n	c0d011a4 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d010fc:	210b      	movs	r1, #11
c0d010fe:	2203      	movs	r2, #3
c0d01100:	a03c      	add	r0, pc, #240	; (adr r0, c0d011f4 <IOTA_main+0x2c0>)
c0d01102:	f7fe ffcf 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d01106:	2048      	movs	r0, #72	; 0x48
c0d01108:	4936      	ldr	r1, [pc, #216]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d0110a:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d0110c:	2049      	movs	r0, #73	; 0x49
c0d0110e:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d01110:	2021      	movs	r0, #33	; 0x21
c0d01112:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d01114:	3610      	adds	r6, #16
c0d01116:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d01118:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d0111a:	2005      	movs	r0, #5
c0d0111c:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0111e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01120:	b281      	uxth	r1, r0
c0d01122:	2020      	movs	r0, #32
c0d01124:	f000 fcb8 	bl	c0d01a98 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d01128:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d0112a:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0112c:	4308      	orrs	r0, r1
c0d0112e:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d01130:	4620      	mov	r0, r4
c0d01132:	4621      	mov	r1, r4
c0d01134:	4622      	mov	r2, r4
c0d01136:	f001 fa2b 	bl	c0d02590 <ui_display_debug>
c0d0113a:	4e27      	ldr	r6, [pc, #156]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d0113c:	e012      	b.n	c0d01164 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d0113e:	4928      	ldr	r1, [pc, #160]	; (c0d011e0 <IOTA_main+0x2ac>)
c0d01140:	4008      	ands	r0, r1
c0d01142:	210d      	movs	r1, #13
c0d01144:	02c9      	lsls	r1, r1, #11
c0d01146:	4301      	orrs	r1, r0
c0d01148:	a859      	add	r0, sp, #356	; 0x164
c0d0114a:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0114c:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d0114e:	0a00      	lsrs	r0, r0, #8
c0d01150:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d01152:	4a24      	ldr	r2, [pc, #144]	; (c0d011e4 <IOTA_main+0x2b0>)
c0d01154:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d01156:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d01158:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0115a:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d0115c:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d0115e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01160:	1c80      	adds	r0, r0, #2
c0d01162:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d01164:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d01166:	6030      	str	r0, [r6, #0]
c0d01168:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d0116a:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d0116c:	2900      	cmp	r1, #0
c0d0116e:	d088      	beq.n	c0d01082 <IOTA_main+0x14e>
c0d01170:	e006      	b.n	c0d01180 <IOTA_main+0x24c>
c0d01172:	2808      	cmp	r0, #8
c0d01174:	d100      	bne.n	c0d01178 <IOTA_main+0x244>
c0d01176:	e6f6      	b.n	c0d00f66 <IOTA_main+0x32>
c0d01178:	28ff      	cmp	r0, #255	; 0xff
c0d0117a:	d113      	bne.n	c0d011a4 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d0117c:	b05d      	add	sp, #372	; 0x174
c0d0117e:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d01180:	f002 fce4 	bl	c0d03b4c <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01184:	2001      	movs	r0, #1
c0d01186:	4918      	ldr	r1, [pc, #96]	; (c0d011e8 <IOTA_main+0x2b4>)
c0d01188:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0118a:	4813      	ldr	r0, [pc, #76]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d0118c:	6800      	ldr	r0, [r0, #0]
c0d0118e:	491c      	ldr	r1, [pc, #112]	; (c0d01200 <IOTA_main+0x2cc>)
c0d01190:	f002 fcdc 	bl	c0d03b4c <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01194:	2001      	movs	r0, #1
c0d01196:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d01198:	480f      	ldr	r0, [pc, #60]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d0119a:	6800      	ldr	r0, [r0, #0]
c0d0119c:	2137      	movs	r1, #55	; 0x37
c0d0119e:	0249      	lsls	r1, r1, #9
c0d011a0:	f002 fcd4 	bl	c0d03b4c <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d011a4:	2001      	movs	r0, #1
c0d011a6:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d011a8:	480b      	ldr	r0, [pc, #44]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d011aa:	6800      	ldr	r0, [r0, #0]
c0d011ac:	f002 fcce 	bl	c0d03b4c <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d011b0:	4809      	ldr	r0, [pc, #36]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d011b2:	6800      	ldr	r0, [r0, #0]
c0d011b4:	490e      	ldr	r1, [pc, #56]	; (c0d011f0 <IOTA_main+0x2bc>)
c0d011b6:	f002 fcc9 	bl	c0d03b4c <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d011ba:	2001      	movs	r0, #1
c0d011bc:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d011be:	4806      	ldr	r0, [pc, #24]	; (c0d011d8 <IOTA_main+0x2a4>)
c0d011c0:	6800      	ldr	r0, [r0, #0]
c0d011c2:	3109      	adds	r1, #9
c0d011c4:	f002 fcc2 	bl	c0d03b4c <longjmp>
c0d011c8:	74696157 	.word	0x74696157
c0d011cc:	20676e69 	.word	0x20676e69
c0d011d0:	20726f66 	.word	0x20726f66
c0d011d4:	0067736d 	.word	0x0067736d
c0d011d8:	20001bb8 	.word	0x20001bb8
c0d011dc:	0000ffff 	.word	0x0000ffff
c0d011e0:	000007ff 	.word	0x000007ff
c0d011e4:	20001c08 	.word	0x20001c08
c0d011e8:	20001b48 	.word	0x20001b48
c0d011ec:	20001b4c 	.word	0x20001b4c
c0d011f0:	00006a86 	.word	0x00006a86
c0d011f4:	20646142 	.word	0x20646142
c0d011f8:	6b627550 	.word	0x6b627550
c0d011fc:	00007965 	.word	0x00007965
c0d01200:	00006982 	.word	0x00006982

c0d01204 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d01204:	4801      	ldr	r0, [pc, #4]	; (c0d0120c <os_boot+0x8>)
c0d01206:	2100      	movs	r1, #0
c0d01208:	6001      	str	r1, [r0, #0]
}
c0d0120a:	4770      	bx	lr
c0d0120c:	20001bb8 	.word	0x20001bb8

c0d01210 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01210:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01212:	af03      	add	r7, sp, #12
c0d01214:	b083      	sub	sp, #12
c0d01216:	9202      	str	r2, [sp, #8]
c0d01218:	460c      	mov	r4, r1
c0d0121a:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d0121c:	4d4a      	ldr	r5, [pc, #296]	; (c0d01348 <io_usb_hid_receive+0x138>)
c0d0121e:	42ac      	cmp	r4, r5
c0d01220:	d00f      	beq.n	c0d01242 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01222:	4e49      	ldr	r6, [pc, #292]	; (c0d01348 <io_usb_hid_receive+0x138>)
c0d01224:	2540      	movs	r5, #64	; 0x40
c0d01226:	4630      	mov	r0, r6
c0d01228:	4629      	mov	r1, r5
c0d0122a:	f002 fbed 	bl	c0d03a08 <__aeabi_memclr>
c0d0122e:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d01230:	2840      	cmp	r0, #64	; 0x40
c0d01232:	4602      	mov	r2, r0
c0d01234:	d300      	bcc.n	c0d01238 <io_usb_hid_receive+0x28>
c0d01236:	462a      	mov	r2, r5
c0d01238:	4630      	mov	r0, r6
c0d0123a:	4621      	mov	r1, r4
c0d0123c:	f000 f89e 	bl	c0d0137c <os_memmove>
c0d01240:	4d41      	ldr	r5, [pc, #260]	; (c0d01348 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d01242:	78a8      	ldrb	r0, [r5, #2]
c0d01244:	2805      	cmp	r0, #5
c0d01246:	d900      	bls.n	c0d0124a <io_usb_hid_receive+0x3a>
c0d01248:	e076      	b.n	c0d01338 <io_usb_hid_receive+0x128>
c0d0124a:	46c0      	nop			; (mov r8, r8)
c0d0124c:	4478      	add	r0, pc
c0d0124e:	7900      	ldrb	r0, [r0, #4]
c0d01250:	0040      	lsls	r0, r0, #1
c0d01252:	4487      	add	pc, r0
c0d01254:	71130c02 	.word	0x71130c02
c0d01258:	1f71      	.short	0x1f71
c0d0125a:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d0125c:	71ae      	strb	r6, [r5, #6]
c0d0125e:	716e      	strb	r6, [r5, #5]
c0d01260:	712e      	strb	r6, [r5, #4]
c0d01262:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01264:	2140      	movs	r1, #64	; 0x40
c0d01266:	4628      	mov	r0, r5
c0d01268:	9a01      	ldr	r2, [sp, #4]
c0d0126a:	4790      	blx	r2
c0d0126c:	e00b      	b.n	c0d01286 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d0126e:	1ce8      	adds	r0, r5, #3
c0d01270:	2104      	movs	r1, #4
c0d01272:	f000 ff73 	bl	c0d0215c <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01276:	2140      	movs	r1, #64	; 0x40
c0d01278:	4628      	mov	r0, r5
c0d0127a:	e001      	b.n	c0d01280 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0127c:	4832      	ldr	r0, [pc, #200]	; (c0d01348 <io_usb_hid_receive+0x138>)
c0d0127e:	2140      	movs	r1, #64	; 0x40
c0d01280:	9a01      	ldr	r2, [sp, #4]
c0d01282:	4790      	blx	r2
c0d01284:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01286:	4831      	ldr	r0, [pc, #196]	; (c0d0134c <io_usb_hid_receive+0x13c>)
c0d01288:	2100      	movs	r1, #0
c0d0128a:	6001      	str	r1, [r0, #0]
c0d0128c:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0128e:	b2c0      	uxtb	r0, r0
c0d01290:	b003      	add	sp, #12
c0d01292:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01294:	78e8      	ldrb	r0, [r5, #3]
c0d01296:	4c2d      	ldr	r4, [pc, #180]	; (c0d0134c <io_usb_hid_receive+0x13c>)
c0d01298:	6821      	ldr	r1, [r4, #0]
c0d0129a:	0a09      	lsrs	r1, r1, #8
c0d0129c:	2600      	movs	r6, #0
c0d0129e:	4288      	cmp	r0, r1
c0d012a0:	d1f1      	bne.n	c0d01286 <io_usb_hid_receive+0x76>
c0d012a2:	7928      	ldrb	r0, [r5, #4]
c0d012a4:	6821      	ldr	r1, [r4, #0]
c0d012a6:	b2c9      	uxtb	r1, r1
c0d012a8:	4288      	cmp	r0, r1
c0d012aa:	d1ec      	bne.n	c0d01286 <io_usb_hid_receive+0x76>
c0d012ac:	4b28      	ldr	r3, [pc, #160]	; (c0d01350 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d012ae:	9802      	ldr	r0, [sp, #8]
c0d012b0:	18c0      	adds	r0, r0, r3
c0d012b2:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d012b4:	6820      	ldr	r0, [r4, #0]
c0d012b6:	2800      	cmp	r0, #0
c0d012b8:	d00e      	beq.n	c0d012d8 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d012ba:	4629      	mov	r1, r5
c0d012bc:	4019      	ands	r1, r3
c0d012be:	4825      	ldr	r0, [pc, #148]	; (c0d01354 <io_usb_hid_receive+0x144>)
c0d012c0:	6802      	ldr	r2, [r0, #0]
c0d012c2:	4291      	cmp	r1, r2
c0d012c4:	461e      	mov	r6, r3
c0d012c6:	d900      	bls.n	c0d012ca <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d012c8:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d012ca:	462a      	mov	r2, r5
c0d012cc:	4032      	ands	r2, r6
c0d012ce:	4822      	ldr	r0, [pc, #136]	; (c0d01358 <io_usb_hid_receive+0x148>)
c0d012d0:	6800      	ldr	r0, [r0, #0]
c0d012d2:	491d      	ldr	r1, [pc, #116]	; (c0d01348 <io_usb_hid_receive+0x138>)
c0d012d4:	1d49      	adds	r1, r1, #5
c0d012d6:	e021      	b.n	c0d0131c <io_usb_hid_receive+0x10c>
c0d012d8:	9301      	str	r3, [sp, #4]
c0d012da:	491b      	ldr	r1, [pc, #108]	; (c0d01348 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d012dc:	7988      	ldrb	r0, [r1, #6]
c0d012de:	7949      	ldrb	r1, [r1, #5]
c0d012e0:	0209      	lsls	r1, r1, #8
c0d012e2:	4301      	orrs	r1, r0
c0d012e4:	481d      	ldr	r0, [pc, #116]	; (c0d0135c <io_usb_hid_receive+0x14c>)
c0d012e6:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d012e8:	6801      	ldr	r1, [r0, #0]
c0d012ea:	2241      	movs	r2, #65	; 0x41
c0d012ec:	0092      	lsls	r2, r2, #2
c0d012ee:	4291      	cmp	r1, r2
c0d012f0:	d8c9      	bhi.n	c0d01286 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d012f2:	6801      	ldr	r1, [r0, #0]
c0d012f4:	4817      	ldr	r0, [pc, #92]	; (c0d01354 <io_usb_hid_receive+0x144>)
c0d012f6:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d012f8:	4917      	ldr	r1, [pc, #92]	; (c0d01358 <io_usb_hid_receive+0x148>)
c0d012fa:	4a19      	ldr	r2, [pc, #100]	; (c0d01360 <io_usb_hid_receive+0x150>)
c0d012fc:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d012fe:	4919      	ldr	r1, [pc, #100]	; (c0d01364 <io_usb_hid_receive+0x154>)
c0d01300:	9a02      	ldr	r2, [sp, #8]
c0d01302:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d01304:	4629      	mov	r1, r5
c0d01306:	9e01      	ldr	r6, [sp, #4]
c0d01308:	4031      	ands	r1, r6
c0d0130a:	6802      	ldr	r2, [r0, #0]
c0d0130c:	4291      	cmp	r1, r2
c0d0130e:	d900      	bls.n	c0d01312 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d01310:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d01312:	462a      	mov	r2, r5
c0d01314:	4032      	ands	r2, r6
c0d01316:	480c      	ldr	r0, [pc, #48]	; (c0d01348 <io_usb_hid_receive+0x138>)
c0d01318:	1dc1      	adds	r1, r0, #7
c0d0131a:	4811      	ldr	r0, [pc, #68]	; (c0d01360 <io_usb_hid_receive+0x150>)
c0d0131c:	f000 f82e 	bl	c0d0137c <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d01320:	4035      	ands	r5, r6
c0d01322:	480d      	ldr	r0, [pc, #52]	; (c0d01358 <io_usb_hid_receive+0x148>)
c0d01324:	6801      	ldr	r1, [r0, #0]
c0d01326:	1949      	adds	r1, r1, r5
c0d01328:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d0132a:	480a      	ldr	r0, [pc, #40]	; (c0d01354 <io_usb_hid_receive+0x144>)
c0d0132c:	6801      	ldr	r1, [r0, #0]
c0d0132e:	1b49      	subs	r1, r1, r5
c0d01330:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d01332:	6820      	ldr	r0, [r4, #0]
c0d01334:	1c40      	adds	r0, r0, #1
c0d01336:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d01338:	4806      	ldr	r0, [pc, #24]	; (c0d01354 <io_usb_hid_receive+0x144>)
c0d0133a:	6801      	ldr	r1, [r0, #0]
c0d0133c:	2001      	movs	r0, #1
c0d0133e:	2602      	movs	r6, #2
c0d01340:	2900      	cmp	r1, #0
c0d01342:	d1a4      	bne.n	c0d0128e <io_usb_hid_receive+0x7e>
c0d01344:	e79f      	b.n	c0d01286 <io_usb_hid_receive+0x76>
c0d01346:	46c0      	nop			; (mov r8, r8)
c0d01348:	20001bbc 	.word	0x20001bbc
c0d0134c:	20001bfc 	.word	0x20001bfc
c0d01350:	0000ffff 	.word	0x0000ffff
c0d01354:	20001c04 	.word	0x20001c04
c0d01358:	20001d0c 	.word	0x20001d0c
c0d0135c:	20001c00 	.word	0x20001c00
c0d01360:	20001c08 	.word	0x20001c08
c0d01364:	0001fff9 	.word	0x0001fff9

c0d01368 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d01368:	b580      	push	{r7, lr}
c0d0136a:	af00      	add	r7, sp, #0
c0d0136c:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d0136e:	2a00      	cmp	r2, #0
c0d01370:	d003      	beq.n	c0d0137a <os_memset+0x12>
    DSTCHAR[length] = c;
c0d01372:	4611      	mov	r1, r2
c0d01374:	461a      	mov	r2, r3
c0d01376:	f002 fb51 	bl	c0d03a1c <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d0137a:	bd80      	pop	{r7, pc}

c0d0137c <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d0137c:	b5b0      	push	{r4, r5, r7, lr}
c0d0137e:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01380:	4288      	cmp	r0, r1
c0d01382:	d90d      	bls.n	c0d013a0 <os_memmove+0x24>
    while(length--) {
c0d01384:	2a00      	cmp	r2, #0
c0d01386:	d014      	beq.n	c0d013b2 <os_memmove+0x36>
c0d01388:	1e49      	subs	r1, r1, #1
c0d0138a:	4252      	negs	r2, r2
c0d0138c:	1e40      	subs	r0, r0, #1
c0d0138e:	2300      	movs	r3, #0
c0d01390:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01392:	461c      	mov	r4, r3
c0d01394:	4354      	muls	r4, r2
c0d01396:	5d0d      	ldrb	r5, [r1, r4]
c0d01398:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0139a:	1c52      	adds	r2, r2, #1
c0d0139c:	d1f9      	bne.n	c0d01392 <os_memmove+0x16>
c0d0139e:	e008      	b.n	c0d013b2 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d013a0:	2a00      	cmp	r2, #0
c0d013a2:	d006      	beq.n	c0d013b2 <os_memmove+0x36>
c0d013a4:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d013a6:	b29c      	uxth	r4, r3
c0d013a8:	5d0d      	ldrb	r5, [r1, r4]
c0d013aa:	5505      	strb	r5, [r0, r4]
      l++;
c0d013ac:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d013ae:	1e52      	subs	r2, r2, #1
c0d013b0:	d1f9      	bne.n	c0d013a6 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d013b2:	bdb0      	pop	{r4, r5, r7, pc}

c0d013b4 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d013b4:	4801      	ldr	r0, [pc, #4]	; (c0d013bc <io_usb_hid_init+0x8>)
c0d013b6:	2100      	movs	r1, #0
c0d013b8:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d013ba:	4770      	bx	lr
c0d013bc:	20001bfc 	.word	0x20001bfc

c0d013c0 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d013c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013c2:	af03      	add	r7, sp, #12
c0d013c4:	b087      	sub	sp, #28
c0d013c6:	9301      	str	r3, [sp, #4]
c0d013c8:	9203      	str	r2, [sp, #12]
c0d013ca:	460e      	mov	r6, r1
c0d013cc:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d013ce:	2e00      	cmp	r6, #0
c0d013d0:	d042      	beq.n	c0d01458 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d013d2:	4d31      	ldr	r5, [pc, #196]	; (c0d01498 <io_usb_hid_exchange+0xd8>)
c0d013d4:	2000      	movs	r0, #0
c0d013d6:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d013d8:	4930      	ldr	r1, [pc, #192]	; (c0d0149c <io_usb_hid_exchange+0xdc>)
c0d013da:	4831      	ldr	r0, [pc, #196]	; (c0d014a0 <io_usb_hid_exchange+0xe0>)
c0d013dc:	6008      	str	r0, [r1, #0]
c0d013de:	4c31      	ldr	r4, [pc, #196]	; (c0d014a4 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d013e0:	1d60      	adds	r0, r4, #5
c0d013e2:	213b      	movs	r1, #59	; 0x3b
c0d013e4:	9005      	str	r0, [sp, #20]
c0d013e6:	9102      	str	r1, [sp, #8]
c0d013e8:	f002 fb0e 	bl	c0d03a08 <__aeabi_memclr>
c0d013ec:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d013ee:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d013f0:	6828      	ldr	r0, [r5, #0]
c0d013f2:	0a00      	lsrs	r0, r0, #8
c0d013f4:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d013f6:	6828      	ldr	r0, [r5, #0]
c0d013f8:	7120      	strb	r0, [r4, #4]
c0d013fa:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d013fc:	6828      	ldr	r0, [r5, #0]
c0d013fe:	2800      	cmp	r0, #0
c0d01400:	9106      	str	r1, [sp, #24]
c0d01402:	d009      	beq.n	c0d01418 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d01404:	293b      	cmp	r1, #59	; 0x3b
c0d01406:	460a      	mov	r2, r1
c0d01408:	d300      	bcc.n	c0d0140c <io_usb_hid_exchange+0x4c>
c0d0140a:	9a02      	ldr	r2, [sp, #8]
c0d0140c:	4823      	ldr	r0, [pc, #140]	; (c0d0149c <io_usb_hid_exchange+0xdc>)
c0d0140e:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01410:	6819      	ldr	r1, [r3, #0]
c0d01412:	9805      	ldr	r0, [sp, #20]
c0d01414:	461e      	mov	r6, r3
c0d01416:	e00a      	b.n	c0d0142e <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d01418:	0a30      	lsrs	r0, r6, #8
c0d0141a:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d0141c:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d0141e:	2039      	movs	r0, #57	; 0x39
c0d01420:	2939      	cmp	r1, #57	; 0x39
c0d01422:	460a      	mov	r2, r1
c0d01424:	d300      	bcc.n	c0d01428 <io_usb_hid_exchange+0x68>
c0d01426:	4602      	mov	r2, r0
c0d01428:	4e1c      	ldr	r6, [pc, #112]	; (c0d0149c <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d0142a:	6831      	ldr	r1, [r6, #0]
c0d0142c:	1de0      	adds	r0, r4, #7
c0d0142e:	9205      	str	r2, [sp, #20]
c0d01430:	f7ff ffa4 	bl	c0d0137c <os_memmove>
c0d01434:	4d18      	ldr	r5, [pc, #96]	; (c0d01498 <io_usb_hid_exchange+0xd8>)
c0d01436:	6830      	ldr	r0, [r6, #0]
c0d01438:	4631      	mov	r1, r6
c0d0143a:	9e05      	ldr	r6, [sp, #20]
c0d0143c:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d0143e:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d01440:	6828      	ldr	r0, [r5, #0]
c0d01442:	1c40      	adds	r0, r0, #1
c0d01444:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01446:	2140      	movs	r1, #64	; 0x40
c0d01448:	4620      	mov	r0, r4
c0d0144a:	9a04      	ldr	r2, [sp, #16]
c0d0144c:	4790      	blx	r2
c0d0144e:	9806      	ldr	r0, [sp, #24]
c0d01450:	1b86      	subs	r6, r0, r6
c0d01452:	4815      	ldr	r0, [pc, #84]	; (c0d014a8 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d01454:	4206      	tst	r6, r0
c0d01456:	d1c3      	bne.n	c0d013e0 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01458:	480f      	ldr	r0, [pc, #60]	; (c0d01498 <io_usb_hid_exchange+0xd8>)
c0d0145a:	2400      	movs	r4, #0
c0d0145c:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d0145e:	2080      	movs	r0, #128	; 0x80
c0d01460:	9901      	ldr	r1, [sp, #4]
c0d01462:	4201      	tst	r1, r0
c0d01464:	d001      	beq.n	c0d0146a <io_usb_hid_exchange+0xaa>
    reset();
c0d01466:	f000 fe3f 	bl	c0d020e8 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d0146a:	9801      	ldr	r0, [sp, #4]
c0d0146c:	0680      	lsls	r0, r0, #26
c0d0146e:	d40f      	bmi.n	c0d01490 <io_usb_hid_exchange+0xd0>
c0d01470:	4c0c      	ldr	r4, [pc, #48]	; (c0d014a4 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01472:	2140      	movs	r1, #64	; 0x40
c0d01474:	4620      	mov	r0, r4
c0d01476:	9a03      	ldr	r2, [sp, #12]
c0d01478:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d0147a:	b2c2      	uxtb	r2, r0
c0d0147c:	2a40      	cmp	r2, #64	; 0x40
c0d0147e:	d8f8      	bhi.n	c0d01472 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01480:	9804      	ldr	r0, [sp, #16]
c0d01482:	4621      	mov	r1, r4
c0d01484:	f7ff fec4 	bl	c0d01210 <io_usb_hid_receive>
c0d01488:	2802      	cmp	r0, #2
c0d0148a:	d1f2      	bne.n	c0d01472 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d0148c:	4807      	ldr	r0, [pc, #28]	; (c0d014ac <io_usb_hid_exchange+0xec>)
c0d0148e:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01490:	b2a0      	uxth	r0, r4
c0d01492:	b007      	add	sp, #28
c0d01494:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01496:	46c0      	nop			; (mov r8, r8)
c0d01498:	20001bfc 	.word	0x20001bfc
c0d0149c:	20001d0c 	.word	0x20001d0c
c0d014a0:	20001c08 	.word	0x20001c08
c0d014a4:	20001bbc 	.word	0x20001bbc
c0d014a8:	0000ffff 	.word	0x0000ffff
c0d014ac:	20001c00 	.word	0x20001c00

c0d014b0 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d014b0:	b580      	push	{r7, lr}
c0d014b2:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d014b4:	f000 ffbc 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d014b8:	2800      	cmp	r0, #0
c0d014ba:	d10b      	bne.n	c0d014d4 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d014bc:	4806      	ldr	r0, [pc, #24]	; (c0d014d8 <io_seproxyhal_general_status+0x28>)
c0d014be:	2160      	movs	r1, #96	; 0x60
c0d014c0:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d014c2:	2100      	movs	r1, #0
c0d014c4:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d014c6:	2202      	movs	r2, #2
c0d014c8:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d014ca:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d014cc:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d014ce:	2105      	movs	r1, #5
c0d014d0:	f000 ff90 	bl	c0d023f4 <io_seproxyhal_spi_send>
}
c0d014d4:	bd80      	pop	{r7, pc}
c0d014d6:	46c0      	nop			; (mov r8, r8)
c0d014d8:	20001a18 	.word	0x20001a18

c0d014dc <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d014dc:	b5d0      	push	{r4, r6, r7, lr}
c0d014de:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d014e0:	4815      	ldr	r0, [pc, #84]	; (c0d01538 <io_seproxyhal_handle_usb_event+0x5c>)
c0d014e2:	78c0      	ldrb	r0, [r0, #3]
c0d014e4:	1e40      	subs	r0, r0, #1
c0d014e6:	2807      	cmp	r0, #7
c0d014e8:	d824      	bhi.n	c0d01534 <io_seproxyhal_handle_usb_event+0x58>
c0d014ea:	46c0      	nop			; (mov r8, r8)
c0d014ec:	4478      	add	r0, pc
c0d014ee:	7900      	ldrb	r0, [r0, #4]
c0d014f0:	0040      	lsls	r0, r0, #1
c0d014f2:	4487      	add	pc, r0
c0d014f4:	141f1803 	.word	0x141f1803
c0d014f8:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d014fc:	4c0f      	ldr	r4, [pc, #60]	; (c0d0153c <io_seproxyhal_handle_usb_event+0x60>)
c0d014fe:	2101      	movs	r1, #1
c0d01500:	4620      	mov	r0, r4
c0d01502:	f001 fbd5 	bl	c0d02cb0 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01506:	4620      	mov	r0, r4
c0d01508:	f001 fbba 	bl	c0d02c80 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d0150c:	480c      	ldr	r0, [pc, #48]	; (c0d01540 <io_seproxyhal_handle_usb_event+0x64>)
c0d0150e:	7800      	ldrb	r0, [r0, #0]
c0d01510:	2801      	cmp	r0, #1
c0d01512:	d10f      	bne.n	c0d01534 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d01514:	480b      	ldr	r0, [pc, #44]	; (c0d01544 <io_seproxyhal_handle_usb_event+0x68>)
c0d01516:	6800      	ldr	r0, [r0, #0]
c0d01518:	2110      	movs	r1, #16
c0d0151a:	f002 fb17 	bl	c0d03b4c <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d0151e:	4807      	ldr	r0, [pc, #28]	; (c0d0153c <io_seproxyhal_handle_usb_event+0x60>)
c0d01520:	f001 fbc9 	bl	c0d02cb6 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01524:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d01526:	4805      	ldr	r0, [pc, #20]	; (c0d0153c <io_seproxyhal_handle_usb_event+0x60>)
c0d01528:	f001 fbc9 	bl	c0d02cbe <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d0152c:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d0152e:	4803      	ldr	r0, [pc, #12]	; (c0d0153c <io_seproxyhal_handle_usb_event+0x60>)
c0d01530:	f001 fbc3 	bl	c0d02cba <USBD_LL_Resume>
      break;
  }
}
c0d01534:	bdd0      	pop	{r4, r6, r7, pc}
c0d01536:	46c0      	nop			; (mov r8, r8)
c0d01538:	20001a18 	.word	0x20001a18
c0d0153c:	20001d34 	.word	0x20001d34
c0d01540:	20001d10 	.word	0x20001d10
c0d01544:	20001bb8 	.word	0x20001bb8

c0d01548 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01548:	217f      	movs	r1, #127	; 0x7f
c0d0154a:	4001      	ands	r1, r0
c0d0154c:	4801      	ldr	r0, [pc, #4]	; (c0d01554 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d0154e:	5c40      	ldrb	r0, [r0, r1]
c0d01550:	4770      	bx	lr
c0d01552:	46c0      	nop			; (mov r8, r8)
c0d01554:	20001d11 	.word	0x20001d11

c0d01558 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01558:	b580      	push	{r7, lr}
c0d0155a:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d0155c:	480f      	ldr	r0, [pc, #60]	; (c0d0159c <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d0155e:	7901      	ldrb	r1, [r0, #4]
c0d01560:	2904      	cmp	r1, #4
c0d01562:	d008      	beq.n	c0d01576 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d01564:	2902      	cmp	r1, #2
c0d01566:	d011      	beq.n	c0d0158c <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d01568:	2901      	cmp	r1, #1
c0d0156a:	d10e      	bne.n	c0d0158a <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d0156c:	1d81      	adds	r1, r0, #6
c0d0156e:	480d      	ldr	r0, [pc, #52]	; (c0d015a4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01570:	f001 faaa 	bl	c0d02ac8 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01574:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01576:	78c2      	ldrb	r2, [r0, #3]
c0d01578:	217f      	movs	r1, #127	; 0x7f
c0d0157a:	4011      	ands	r1, r2
c0d0157c:	7942      	ldrb	r2, [r0, #5]
c0d0157e:	4b08      	ldr	r3, [pc, #32]	; (c0d015a0 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01580:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01582:	1d82      	adds	r2, r0, #6
c0d01584:	4807      	ldr	r0, [pc, #28]	; (c0d015a4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01586:	f001 fad1 	bl	c0d02b2c <USBD_LL_DataOutStage>
      break;
  }
}
c0d0158a:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0158c:	78c2      	ldrb	r2, [r0, #3]
c0d0158e:	217f      	movs	r1, #127	; 0x7f
c0d01590:	4011      	ands	r1, r2
c0d01592:	1d82      	adds	r2, r0, #6
c0d01594:	4803      	ldr	r0, [pc, #12]	; (c0d015a4 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01596:	f001 fb0f 	bl	c0d02bb8 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0159a:	bd80      	pop	{r7, pc}
c0d0159c:	20001a18 	.word	0x20001a18
c0d015a0:	20001d11 	.word	0x20001d11
c0d015a4:	20001d34 	.word	0x20001d34

c0d015a8 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d015a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d015aa:	af03      	add	r7, sp, #12
c0d015ac:	b083      	sub	sp, #12
c0d015ae:	9201      	str	r2, [sp, #4]
c0d015b0:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d015b2:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d015b4:	2b00      	cmp	r3, #0
c0d015b6:	d100      	bne.n	c0d015ba <io_usb_send_ep+0x12>
c0d015b8:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d015ba:	9801      	ldr	r0, [sp, #4]
c0d015bc:	28ff      	cmp	r0, #255	; 0xff
c0d015be:	d843      	bhi.n	c0d01648 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d015c0:	4e25      	ldr	r6, [pc, #148]	; (c0d01658 <io_usb_send_ep+0xb0>)
c0d015c2:	2050      	movs	r0, #80	; 0x50
c0d015c4:	7030      	strb	r0, [r6, #0]
c0d015c6:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d015c8:	1ce0      	adds	r0, r4, #3
c0d015ca:	9100      	str	r1, [sp, #0]
c0d015cc:	0a01      	lsrs	r1, r0, #8
c0d015ce:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d015d0:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d015d2:	2080      	movs	r0, #128	; 0x80
c0d015d4:	4302      	orrs	r2, r0
c0d015d6:	9202      	str	r2, [sp, #8]
c0d015d8:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d015da:	2020      	movs	r0, #32
c0d015dc:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d015de:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d015e0:	2106      	movs	r1, #6
c0d015e2:	4630      	mov	r0, r6
c0d015e4:	f000 ff06 	bl	c0d023f4 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d015e8:	9800      	ldr	r0, [sp, #0]
c0d015ea:	4621      	mov	r1, r4
c0d015ec:	f000 ff02 	bl	c0d023f4 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d015f0:	2d00      	cmp	r5, #0
c0d015f2:	d10d      	bne.n	c0d01610 <io_usb_send_ep+0x68>
c0d015f4:	e028      	b.n	c0d01648 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d015f6:	2d00      	cmp	r5, #0
c0d015f8:	d002      	beq.n	c0d01600 <io_usb_send_ep+0x58>
c0d015fa:	1e6c      	subs	r4, r5, #1
c0d015fc:	2d01      	cmp	r5, #1
c0d015fe:	d025      	beq.n	c0d0164c <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01600:	2915      	cmp	r1, #21
c0d01602:	d102      	bne.n	c0d0160a <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01604:	79b0      	ldrb	r0, [r6, #6]
c0d01606:	0700      	lsls	r0, r0, #28
c0d01608:	d520      	bpl.n	c0d0164c <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0160a:	f000 f829 	bl	c0d01660 <io_seproxyhal_handle_event>
c0d0160e:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01610:	f000 ff0e 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d01614:	2800      	cmp	r0, #0
c0d01616:	d101      	bne.n	c0d0161c <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01618:	f7ff ff4a 	bl	c0d014b0 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0161c:	2180      	movs	r1, #128	; 0x80
c0d0161e:	2400      	movs	r4, #0
c0d01620:	4630      	mov	r0, r6
c0d01622:	4622      	mov	r2, r4
c0d01624:	f000 ff20 	bl	c0d02468 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01628:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d0162a:	2806      	cmp	r0, #6
c0d0162c:	d1e3      	bne.n	c0d015f6 <io_usb_send_ep+0x4e>
c0d0162e:	2910      	cmp	r1, #16
c0d01630:	d1e1      	bne.n	c0d015f6 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d01632:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01634:	9a02      	ldr	r2, [sp, #8]
c0d01636:	4290      	cmp	r0, r2
c0d01638:	d1dd      	bne.n	c0d015f6 <io_usb_send_ep+0x4e>
c0d0163a:	7930      	ldrb	r0, [r6, #4]
c0d0163c:	2802      	cmp	r0, #2
c0d0163e:	d1da      	bne.n	c0d015f6 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d01640:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d01642:	9a01      	ldr	r2, [sp, #4]
c0d01644:	4290      	cmp	r0, r2
c0d01646:	d1d6      	bne.n	c0d015f6 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01648:	b003      	add	sp, #12
c0d0164a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0164c:	4803      	ldr	r0, [pc, #12]	; (c0d0165c <io_usb_send_ep+0xb4>)
c0d0164e:	6800      	ldr	r0, [r0, #0]
c0d01650:	2110      	movs	r1, #16
c0d01652:	f002 fa7b 	bl	c0d03b4c <longjmp>
c0d01656:	46c0      	nop			; (mov r8, r8)
c0d01658:	20001a18 	.word	0x20001a18
c0d0165c:	20001bb8 	.word	0x20001bb8

c0d01660 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d01660:	b580      	push	{r7, lr}
c0d01662:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01664:	480d      	ldr	r0, [pc, #52]	; (c0d0169c <io_seproxyhal_handle_event+0x3c>)
c0d01666:	7882      	ldrb	r2, [r0, #2]
c0d01668:	7841      	ldrb	r1, [r0, #1]
c0d0166a:	0209      	lsls	r1, r1, #8
c0d0166c:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0166e:	7800      	ldrb	r0, [r0, #0]
c0d01670:	2810      	cmp	r0, #16
c0d01672:	d008      	beq.n	c0d01686 <io_seproxyhal_handle_event+0x26>
c0d01674:	280f      	cmp	r0, #15
c0d01676:	d10d      	bne.n	c0d01694 <io_seproxyhal_handle_event+0x34>
c0d01678:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d0167a:	2904      	cmp	r1, #4
c0d0167c:	d10d      	bne.n	c0d0169a <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0167e:	f7ff ff2d 	bl	c0d014dc <io_seproxyhal_handle_usb_event>
c0d01682:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01684:	bd80      	pop	{r7, pc}
c0d01686:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01688:	2906      	cmp	r1, #6
c0d0168a:	d306      	bcc.n	c0d0169a <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d0168c:	f7ff ff64 	bl	c0d01558 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01690:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01692:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01694:	2002      	movs	r0, #2
c0d01696:	f7ff faf5 	bl	c0d00c84 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0169a:	bd80      	pop	{r7, pc}
c0d0169c:	20001a18 	.word	0x20001a18

c0d016a0 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d016a0:	b580      	push	{r7, lr}
c0d016a2:	af00      	add	r7, sp, #0
c0d016a4:	460a      	mov	r2, r1
c0d016a6:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d016a8:	2082      	movs	r0, #130	; 0x82
c0d016aa:	2314      	movs	r3, #20
c0d016ac:	f7ff ff7c 	bl	c0d015a8 <io_usb_send_ep>
}
c0d016b0:	bd80      	pop	{r7, pc}
	...

c0d016b4 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d016b4:	b5d0      	push	{r4, r6, r7, lr}
c0d016b6:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d016b8:	2007      	movs	r0, #7
c0d016ba:	f000 fcf7 	bl	c0d020ac <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d016be:	480a      	ldr	r0, [pc, #40]	; (c0d016e8 <io_seproxyhal_init+0x34>)
c0d016c0:	2400      	movs	r4, #0
c0d016c2:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d016c4:	4809      	ldr	r0, [pc, #36]	; (c0d016ec <io_seproxyhal_init+0x38>)
c0d016c6:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d016c8:	4809      	ldr	r0, [pc, #36]	; (c0d016f0 <io_seproxyhal_init+0x3c>)
c0d016ca:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d016cc:	4809      	ldr	r0, [pc, #36]	; (c0d016f4 <io_seproxyhal_init+0x40>)
c0d016ce:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d016d0:	4809      	ldr	r0, [pc, #36]	; (c0d016f8 <io_seproxyhal_init+0x44>)
c0d016d2:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d016d4:	f7ff fe6e 	bl	c0d013b4 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d016d8:	4808      	ldr	r0, [pc, #32]	; (c0d016fc <io_seproxyhal_init+0x48>)
c0d016da:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d016dc:	4808      	ldr	r0, [pc, #32]	; (c0d01700 <io_seproxyhal_init+0x4c>)
c0d016de:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d016e0:	4808      	ldr	r0, [pc, #32]	; (c0d01704 <io_seproxyhal_init+0x50>)
c0d016e2:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d016e4:	bdd0      	pop	{r4, r6, r7, pc}
c0d016e6:	46c0      	nop			; (mov r8, r8)
c0d016e8:	20001d18 	.word	0x20001d18
c0d016ec:	20001d1a 	.word	0x20001d1a
c0d016f0:	20001d1c 	.word	0x20001d1c
c0d016f4:	20001d1e 	.word	0x20001d1e
c0d016f8:	20001d10 	.word	0x20001d10
c0d016fc:	20001d20 	.word	0x20001d20
c0d01700:	20001d24 	.word	0x20001d24
c0d01704:	20001d28 	.word	0x20001d28

c0d01708 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01708:	4801      	ldr	r0, [pc, #4]	; (c0d01710 <io_seproxyhal_init_ux+0x8>)
c0d0170a:	2100      	movs	r1, #0
c0d0170c:	6001      	str	r1, [r0, #0]

}
c0d0170e:	4770      	bx	lr
c0d01710:	20001d20 	.word	0x20001d20

c0d01714 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01714:	b5b0      	push	{r4, r5, r7, lr}
c0d01716:	af02      	add	r7, sp, #8
c0d01718:	460d      	mov	r5, r1
c0d0171a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d0171c:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d0171e:	2800      	cmp	r0, #0
c0d01720:	d00c      	beq.n	c0d0173c <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d01722:	f000 fcab 	bl	c0d0207c <pic>
c0d01726:	4601      	mov	r1, r0
c0d01728:	4620      	mov	r0, r4
c0d0172a:	4788      	blx	r1
c0d0172c:	f000 fca6 	bl	c0d0207c <pic>
c0d01730:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d01732:	2800      	cmp	r0, #0
c0d01734:	d010      	beq.n	c0d01758 <io_seproxyhal_touch_out+0x44>
c0d01736:	2801      	cmp	r0, #1
c0d01738:	d000      	beq.n	c0d0173c <io_seproxyhal_touch_out+0x28>
c0d0173a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0173c:	2d00      	cmp	r5, #0
c0d0173e:	d007      	beq.n	c0d01750 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d01740:	4620      	mov	r0, r4
c0d01742:	47a8      	blx	r5
c0d01744:	2100      	movs	r1, #0
    if (!el) {
c0d01746:	2800      	cmp	r0, #0
c0d01748:	d006      	beq.n	c0d01758 <io_seproxyhal_touch_out+0x44>
c0d0174a:	2801      	cmp	r0, #1
c0d0174c:	d000      	beq.n	c0d01750 <io_seproxyhal_touch_out+0x3c>
c0d0174e:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01750:	4620      	mov	r0, r4
c0d01752:	f7ff fa91 	bl	c0d00c78 <io_seproxyhal_display>
c0d01756:	2101      	movs	r1, #1
  return 1;
}
c0d01758:	4608      	mov	r0, r1
c0d0175a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0175c <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d0175c:	b5b0      	push	{r4, r5, r7, lr}
c0d0175e:	af02      	add	r7, sp, #8
c0d01760:	b08e      	sub	sp, #56	; 0x38
c0d01762:	460c      	mov	r4, r1
c0d01764:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01766:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01768:	2800      	cmp	r0, #0
c0d0176a:	d00c      	beq.n	c0d01786 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d0176c:	f000 fc86 	bl	c0d0207c <pic>
c0d01770:	4601      	mov	r1, r0
c0d01772:	4628      	mov	r0, r5
c0d01774:	4788      	blx	r1
c0d01776:	f000 fc81 	bl	c0d0207c <pic>
c0d0177a:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0177c:	2800      	cmp	r0, #0
c0d0177e:	d016      	beq.n	c0d017ae <io_seproxyhal_touch_over+0x52>
c0d01780:	2801      	cmp	r0, #1
c0d01782:	d000      	beq.n	c0d01786 <io_seproxyhal_touch_over+0x2a>
c0d01784:	4605      	mov	r5, r0
c0d01786:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01788:	2238      	movs	r2, #56	; 0x38
c0d0178a:	4629      	mov	r1, r5
c0d0178c:	f7ff fdf6 	bl	c0d0137c <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01790:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01792:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01794:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01796:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01798:	2c00      	cmp	r4, #0
c0d0179a:	d004      	beq.n	c0d017a6 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d0179c:	4628      	mov	r0, r5
c0d0179e:	47a0      	blx	r4
c0d017a0:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d017a2:	2800      	cmp	r0, #0
c0d017a4:	d003      	beq.n	c0d017ae <io_seproxyhal_touch_over+0x52>
c0d017a6:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d017a8:	f7ff fa66 	bl	c0d00c78 <io_seproxyhal_display>
c0d017ac:	2101      	movs	r1, #1
  return 1;
}
c0d017ae:	4608      	mov	r0, r1
c0d017b0:	b00e      	add	sp, #56	; 0x38
c0d017b2:	bdb0      	pop	{r4, r5, r7, pc}

c0d017b4 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d017b4:	b5b0      	push	{r4, r5, r7, lr}
c0d017b6:	af02      	add	r7, sp, #8
c0d017b8:	460d      	mov	r5, r1
c0d017ba:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d017bc:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d017be:	2800      	cmp	r0, #0
c0d017c0:	d00c      	beq.n	c0d017dc <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d017c2:	f000 fc5b 	bl	c0d0207c <pic>
c0d017c6:	4601      	mov	r1, r0
c0d017c8:	4620      	mov	r0, r4
c0d017ca:	4788      	blx	r1
c0d017cc:	f000 fc56 	bl	c0d0207c <pic>
c0d017d0:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d017d2:	2800      	cmp	r0, #0
c0d017d4:	d010      	beq.n	c0d017f8 <io_seproxyhal_touch_tap+0x44>
c0d017d6:	2801      	cmp	r0, #1
c0d017d8:	d000      	beq.n	c0d017dc <io_seproxyhal_touch_tap+0x28>
c0d017da:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d017dc:	2d00      	cmp	r5, #0
c0d017de:	d007      	beq.n	c0d017f0 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d017e0:	4620      	mov	r0, r4
c0d017e2:	47a8      	blx	r5
c0d017e4:	2100      	movs	r1, #0
    if (!el) {
c0d017e6:	2800      	cmp	r0, #0
c0d017e8:	d006      	beq.n	c0d017f8 <io_seproxyhal_touch_tap+0x44>
c0d017ea:	2801      	cmp	r0, #1
c0d017ec:	d000      	beq.n	c0d017f0 <io_seproxyhal_touch_tap+0x3c>
c0d017ee:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d017f0:	4620      	mov	r0, r4
c0d017f2:	f7ff fa41 	bl	c0d00c78 <io_seproxyhal_display>
c0d017f6:	2101      	movs	r1, #1
  return 1;
}
c0d017f8:	4608      	mov	r0, r1
c0d017fa:	bdb0      	pop	{r4, r5, r7, pc}

c0d017fc <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d017fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017fe:	af03      	add	r7, sp, #12
c0d01800:	b087      	sub	sp, #28
c0d01802:	9302      	str	r3, [sp, #8]
c0d01804:	9203      	str	r2, [sp, #12]
c0d01806:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01808:	2900      	cmp	r1, #0
c0d0180a:	d076      	beq.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
c0d0180c:	9004      	str	r0, [sp, #16]
c0d0180e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01810:	9001      	str	r0, [sp, #4]
c0d01812:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01814:	9000      	str	r0, [sp, #0]
c0d01816:	2600      	movs	r6, #0
c0d01818:	9606      	str	r6, [sp, #24]
c0d0181a:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0181c:	f000 fe08 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d01820:	2800      	cmp	r0, #0
c0d01822:	d155      	bne.n	c0d018d0 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d01824:	2038      	movs	r0, #56	; 0x38
c0d01826:	4370      	muls	r0, r6
c0d01828:	9d04      	ldr	r5, [sp, #16]
c0d0182a:	182e      	adds	r6, r5, r0
c0d0182c:	4b36      	ldr	r3, [pc, #216]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0182e:	681a      	ldr	r2, [r3, #0]
c0d01830:	2101      	movs	r1, #1
c0d01832:	4296      	cmp	r6, r2
c0d01834:	d000      	beq.n	c0d01838 <io_seproxyhal_touch_element_callback+0x3c>
c0d01836:	9906      	ldr	r1, [sp, #24]
c0d01838:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0183a:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d0183c:	2800      	cmp	r0, #0
c0d0183e:	da41      	bge.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
c0d01840:	2020      	movs	r0, #32
c0d01842:	5c35      	ldrb	r5, [r6, r0]
c0d01844:	2102      	movs	r1, #2
c0d01846:	5e71      	ldrsh	r1, [r6, r1]
c0d01848:	1b4a      	subs	r2, r1, r5
c0d0184a:	9803      	ldr	r0, [sp, #12]
c0d0184c:	4282      	cmp	r2, r0
c0d0184e:	dc39      	bgt.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
c0d01850:	1869      	adds	r1, r5, r1
c0d01852:	88f2      	ldrh	r2, [r6, #6]
c0d01854:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d01856:	9803      	ldr	r0, [sp, #12]
c0d01858:	4288      	cmp	r0, r1
c0d0185a:	da33      	bge.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
c0d0185c:	2104      	movs	r1, #4
c0d0185e:	5e70      	ldrsh	r0, [r6, r1]
c0d01860:	1b42      	subs	r2, r0, r5
c0d01862:	9902      	ldr	r1, [sp, #8]
c0d01864:	428a      	cmp	r2, r1
c0d01866:	dc2d      	bgt.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
c0d01868:	1940      	adds	r0, r0, r5
c0d0186a:	8931      	ldrh	r1, [r6, #8]
c0d0186c:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0186e:	9902      	ldr	r1, [sp, #8]
c0d01870:	4281      	cmp	r1, r0
c0d01872:	da27      	bge.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01874:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01876:	4286      	cmp	r6, r0
c0d01878:	d010      	beq.n	c0d0189c <io_seproxyhal_touch_element_callback+0xa0>
c0d0187a:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d0187c:	2800      	cmp	r0, #0
c0d0187e:	d00d      	beq.n	c0d0189c <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01880:	9801      	ldr	r0, [sp, #4]
c0d01882:	2800      	cmp	r0, #0
c0d01884:	d005      	beq.n	c0d01892 <io_seproxyhal_touch_element_callback+0x96>
c0d01886:	4630      	mov	r0, r6
c0d01888:	9901      	ldr	r1, [sp, #4]
c0d0188a:	4788      	blx	r1
c0d0188c:	4b1e      	ldr	r3, [pc, #120]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0188e:	2800      	cmp	r0, #0
c0d01890:	d018      	beq.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01892:	6818      	ldr	r0, [r3, #0]
c0d01894:	9901      	ldr	r1, [sp, #4]
c0d01896:	f7ff ff3d 	bl	c0d01714 <io_seproxyhal_touch_out>
c0d0189a:	e008      	b.n	c0d018ae <io_seproxyhal_touch_element_callback+0xb2>
c0d0189c:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0189e:	2801      	cmp	r0, #1
c0d018a0:	d009      	beq.n	c0d018b6 <io_seproxyhal_touch_element_callback+0xba>
c0d018a2:	2802      	cmp	r0, #2
c0d018a4:	d10e      	bne.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d018a6:	4630      	mov	r0, r6
c0d018a8:	9901      	ldr	r1, [sp, #4]
c0d018aa:	f7ff ff83 	bl	c0d017b4 <io_seproxyhal_touch_tap>
c0d018ae:	4b16      	ldr	r3, [pc, #88]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018b0:	2800      	cmp	r0, #0
c0d018b2:	d007      	beq.n	c0d018c4 <io_seproxyhal_touch_element_callback+0xc8>
c0d018b4:	e023      	b.n	c0d018fe <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d018b6:	4630      	mov	r0, r6
c0d018b8:	9901      	ldr	r1, [sp, #4]
c0d018ba:	f7ff ff4f 	bl	c0d0175c <io_seproxyhal_touch_over>
c0d018be:	4b12      	ldr	r3, [pc, #72]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018c0:	2800      	cmp	r0, #0
c0d018c2:	d11f      	bne.n	c0d01904 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d018c4:	1c64      	adds	r4, r4, #1
c0d018c6:	b2e6      	uxtb	r6, r4
c0d018c8:	9805      	ldr	r0, [sp, #20]
c0d018ca:	4286      	cmp	r6, r0
c0d018cc:	d3a6      	bcc.n	c0d0181c <io_seproxyhal_touch_element_callback+0x20>
c0d018ce:	e000      	b.n	c0d018d2 <io_seproxyhal_touch_element_callback+0xd6>
c0d018d0:	4b0d      	ldr	r3, [pc, #52]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d018d2:	9806      	ldr	r0, [sp, #24]
c0d018d4:	0600      	lsls	r0, r0, #24
c0d018d6:	d010      	beq.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
c0d018d8:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d018da:	2800      	cmp	r0, #0
c0d018dc:	d00d      	beq.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d018de:	f000 fda7 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d018e2:	4909      	ldr	r1, [pc, #36]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018e4:	2800      	cmp	r0, #0
c0d018e6:	d108      	bne.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d018e8:	6808      	ldr	r0, [r1, #0]
c0d018ea:	9901      	ldr	r1, [sp, #4]
c0d018ec:	f7ff ff12 	bl	c0d01714 <io_seproxyhal_touch_out>
c0d018f0:	4d05      	ldr	r5, [pc, #20]	; (c0d01908 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018f2:	2800      	cmp	r0, #0
c0d018f4:	d001      	beq.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d018f6:	2000      	movs	r0, #0
c0d018f8:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d018fa:	b007      	add	sp, #28
c0d018fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d018fe:	2000      	movs	r0, #0
c0d01900:	6018      	str	r0, [r3, #0]
c0d01902:	e7fa      	b.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01904:	601e      	str	r6, [r3, #0]
c0d01906:	e7f8      	b.n	c0d018fa <io_seproxyhal_touch_element_callback+0xfe>
c0d01908:	20001d20 	.word	0x20001d20

c0d0190c <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d0190c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0190e:	af03      	add	r7, sp, #12
c0d01910:	b08b      	sub	sp, #44	; 0x2c
c0d01912:	460c      	mov	r4, r1
c0d01914:	4601      	mov	r1, r0
c0d01916:	ad04      	add	r5, sp, #16
c0d01918:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d0191a:	4628      	mov	r0, r5
c0d0191c:	9203      	str	r2, [sp, #12]
c0d0191e:	f7ff fd2d 	bl	c0d0137c <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01922:	6821      	ldr	r1, [r4, #0]
c0d01924:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01926:	6862      	ldr	r2, [r4, #4]
c0d01928:	9502      	str	r5, [sp, #8]
c0d0192a:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0192c:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0192e:	4e1a      	ldr	r6, [pc, #104]	; (c0d01998 <io_seproxyhal_display_icon+0x8c>)
c0d01930:	2365      	movs	r3, #101	; 0x65
c0d01932:	4635      	mov	r5, r6
c0d01934:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01936:	b292      	uxth	r2, r2
c0d01938:	4342      	muls	r2, r0
c0d0193a:	b28b      	uxth	r3, r1
c0d0193c:	4353      	muls	r3, r2
c0d0193e:	08d9      	lsrs	r1, r3, #3
c0d01940:	1c4e      	adds	r6, r1, #1
c0d01942:	2207      	movs	r2, #7
c0d01944:	4213      	tst	r3, r2
c0d01946:	d100      	bne.n	c0d0194a <io_seproxyhal_display_icon+0x3e>
c0d01948:	460e      	mov	r6, r1
c0d0194a:	4631      	mov	r1, r6
c0d0194c:	9101      	str	r1, [sp, #4]
c0d0194e:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01950:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01952:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01954:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01956:	0a01      	lsrs	r1, r0, #8
c0d01958:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d0195a:	70a8      	strb	r0, [r5, #2]
c0d0195c:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0195e:	4628      	mov	r0, r5
c0d01960:	f000 fd48 	bl	c0d023f4 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01964:	9802      	ldr	r0, [sp, #8]
c0d01966:	9903      	ldr	r1, [sp, #12]
c0d01968:	f000 fd44 	bl	c0d023f4 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d0196c:	68a0      	ldr	r0, [r4, #8]
c0d0196e:	7028      	strb	r0, [r5, #0]
c0d01970:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01972:	4628      	mov	r0, r5
c0d01974:	f000 fd3e 	bl	c0d023f4 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01978:	68e0      	ldr	r0, [r4, #12]
c0d0197a:	f000 fb7f 	bl	c0d0207c <pic>
c0d0197e:	b2b1      	uxth	r1, r6
c0d01980:	f000 fd38 	bl	c0d023f4 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01984:	9801      	ldr	r0, [sp, #4]
c0d01986:	b285      	uxth	r5, r0
c0d01988:	6920      	ldr	r0, [r4, #16]
c0d0198a:	f000 fb77 	bl	c0d0207c <pic>
c0d0198e:	4629      	mov	r1, r5
c0d01990:	f000 fd30 	bl	c0d023f4 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01994:	b00b      	add	sp, #44	; 0x2c
c0d01996:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01998:	20001a18 	.word	0x20001a18

c0d0199c <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d0199c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0199e:	af03      	add	r7, sp, #12
c0d019a0:	b081      	sub	sp, #4
c0d019a2:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d019a4:	7820      	ldrb	r0, [r4, #0]
c0d019a6:	267f      	movs	r6, #127	; 0x7f
c0d019a8:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d019aa:	2e00      	cmp	r6, #0
c0d019ac:	d02e      	beq.n	c0d01a0c <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d019ae:	69e0      	ldr	r0, [r4, #28]
c0d019b0:	2800      	cmp	r0, #0
c0d019b2:	d01d      	beq.n	c0d019f0 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d019b4:	f000 fb62 	bl	c0d0207c <pic>
c0d019b8:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d019ba:	2e05      	cmp	r6, #5
c0d019bc:	d102      	bne.n	c0d019c4 <io_seproxyhal_display_default+0x28>
c0d019be:	7ea0      	ldrb	r0, [r4, #26]
c0d019c0:	2800      	cmp	r0, #0
c0d019c2:	d025      	beq.n	c0d01a10 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d019c4:	4628      	mov	r0, r5
c0d019c6:	f002 f8cf 	bl	c0d03b68 <strlen>
c0d019ca:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d019cc:	4813      	ldr	r0, [pc, #76]	; (c0d01a1c <io_seproxyhal_display_default+0x80>)
c0d019ce:	2165      	movs	r1, #101	; 0x65
c0d019d0:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d019d2:	4631      	mov	r1, r6
c0d019d4:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019d6:	0a0a      	lsrs	r2, r1, #8
c0d019d8:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d019da:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019dc:	2103      	movs	r1, #3
c0d019de:	f000 fd09 	bl	c0d023f4 <io_seproxyhal_spi_send>
c0d019e2:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d019e4:	4620      	mov	r0, r4
c0d019e6:	f000 fd05 	bl	c0d023f4 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d019ea:	b2b1      	uxth	r1, r6
c0d019ec:	4628      	mov	r0, r5
c0d019ee:	e00b      	b.n	c0d01a08 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d019f0:	480a      	ldr	r0, [pc, #40]	; (c0d01a1c <io_seproxyhal_display_default+0x80>)
c0d019f2:	2165      	movs	r1, #101	; 0x65
c0d019f4:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019f6:	2100      	movs	r1, #0
c0d019f8:	7041      	strb	r1, [r0, #1]
c0d019fa:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d019fc:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019fe:	2103      	movs	r1, #3
c0d01a00:	f000 fcf8 	bl	c0d023f4 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01a04:	4620      	mov	r0, r4
c0d01a06:	4629      	mov	r1, r5
c0d01a08:	f000 fcf4 	bl	c0d023f4 <io_seproxyhal_spi_send>
    }
  }
}
c0d01a0c:	b001      	add	sp, #4
c0d01a0e:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01a10:	4620      	mov	r0, r4
c0d01a12:	4629      	mov	r1, r5
c0d01a14:	f7ff ff7a 	bl	c0d0190c <io_seproxyhal_display_icon>
c0d01a18:	e7f8      	b.n	c0d01a0c <io_seproxyhal_display_default+0x70>
c0d01a1a:	46c0      	nop			; (mov r8, r8)
c0d01a1c:	20001a18 	.word	0x20001a18

c0d01a20 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01a20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a22:	af03      	add	r7, sp, #12
c0d01a24:	b081      	sub	sp, #4
c0d01a26:	4604      	mov	r4, r0
  if (button_callback) {
c0d01a28:	2c00      	cmp	r4, #0
c0d01a2a:	d02e      	beq.n	c0d01a8a <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01a2c:	4818      	ldr	r0, [pc, #96]	; (c0d01a90 <io_seproxyhal_button_push+0x70>)
c0d01a2e:	6802      	ldr	r2, [r0, #0]
c0d01a30:	428a      	cmp	r2, r1
c0d01a32:	d103      	bne.n	c0d01a3c <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01a34:	4a17      	ldr	r2, [pc, #92]	; (c0d01a94 <io_seproxyhal_button_push+0x74>)
c0d01a36:	6813      	ldr	r3, [r2, #0]
c0d01a38:	1c5b      	adds	r3, r3, #1
c0d01a3a:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01a3c:	6806      	ldr	r6, [r0, #0]
c0d01a3e:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01a40:	4a14      	ldr	r2, [pc, #80]	; (c0d01a94 <io_seproxyhal_button_push+0x74>)
c0d01a42:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01a44:	2900      	cmp	r1, #0
c0d01a46:	d001      	beq.n	c0d01a4c <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01a48:	6006      	str	r6, [r0, #0]
c0d01a4a:	e005      	b.n	c0d01a58 <io_seproxyhal_button_push+0x38>
c0d01a4c:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01a4e:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01a50:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01a52:	2301      	movs	r3, #1
c0d01a54:	07db      	lsls	r3, r3, #31
c0d01a56:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01a58:	6800      	ldr	r0, [r0, #0]
c0d01a5a:	4288      	cmp	r0, r1
c0d01a5c:	d001      	beq.n	c0d01a62 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01a5e:	2000      	movs	r0, #0
c0d01a60:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01a62:	2d08      	cmp	r5, #8
c0d01a64:	d30e      	bcc.n	c0d01a84 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01a66:	2103      	movs	r1, #3
c0d01a68:	4628      	mov	r0, r5
c0d01a6a:	f001 fda7 	bl	c0d035bc <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01a6e:	2001      	movs	r0, #1
c0d01a70:	0780      	lsls	r0, r0, #30
c0d01a72:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01a74:	2900      	cmp	r1, #0
c0d01a76:	4601      	mov	r1, r0
c0d01a78:	d000      	beq.n	c0d01a7c <io_seproxyhal_button_push+0x5c>
c0d01a7a:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01a7c:	2900      	cmp	r1, #0
c0d01a7e:	db02      	blt.n	c0d01a86 <io_seproxyhal_button_push+0x66>
c0d01a80:	4608      	mov	r0, r1
c0d01a82:	e000      	b.n	c0d01a86 <io_seproxyhal_button_push+0x66>
c0d01a84:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01a86:	4629      	mov	r1, r5
c0d01a88:	47a0      	blx	r4
  }
}
c0d01a8a:	b001      	add	sp, #4
c0d01a8c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a8e:	46c0      	nop			; (mov r8, r8)
c0d01a90:	20001d24 	.word	0x20001d24
c0d01a94:	20001d28 	.word	0x20001d28

c0d01a98 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01a98:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a9a:	af03      	add	r7, sp, #12
c0d01a9c:	b081      	sub	sp, #4
c0d01a9e:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01aa0:	200f      	movs	r0, #15
c0d01aa2:	4204      	tst	r4, r0
c0d01aa4:	d006      	beq.n	c0d01ab4 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01aa6:	4620      	mov	r0, r4
c0d01aa8:	f7ff f8be 	bl	c0d00c28 <io_exchange_al>
c0d01aac:	4605      	mov	r5, r0
  }
}
c0d01aae:	b2a8      	uxth	r0, r5
c0d01ab0:	b001      	add	sp, #4
c0d01ab2:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01ab4:	2610      	movs	r6, #16
c0d01ab6:	4026      	ands	r6, r4
c0d01ab8:	2900      	cmp	r1, #0
c0d01aba:	d02a      	beq.n	c0d01b12 <io_exchange+0x7a>
c0d01abc:	2e00      	cmp	r6, #0
c0d01abe:	d128      	bne.n	c0d01b12 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01ac0:	483d      	ldr	r0, [pc, #244]	; (c0d01bb8 <io_exchange+0x120>)
c0d01ac2:	7800      	ldrb	r0, [r0, #0]
c0d01ac4:	2807      	cmp	r0, #7
c0d01ac6:	d00b      	beq.n	c0d01ae0 <io_exchange+0x48>
c0d01ac8:	2800      	cmp	r0, #0
c0d01aca:	d004      	beq.n	c0d01ad6 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01acc:	4620      	mov	r0, r4
c0d01ace:	f7ff f8ab 	bl	c0d00c28 <io_exchange_al>
c0d01ad2:	2800      	cmp	r0, #0
c0d01ad4:	d00a      	beq.n	c0d01aec <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01ad6:	4839      	ldr	r0, [pc, #228]	; (c0d01bbc <io_exchange+0x124>)
c0d01ad8:	6800      	ldr	r0, [r0, #0]
c0d01ada:	2109      	movs	r1, #9
c0d01adc:	f002 f836 	bl	c0d03b4c <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01ae0:	483d      	ldr	r0, [pc, #244]	; (c0d01bd8 <io_exchange+0x140>)
c0d01ae2:	4478      	add	r0, pc
c0d01ae4:	2200      	movs	r2, #0
c0d01ae6:	2320      	movs	r3, #32
c0d01ae8:	f7ff fc6a 	bl	c0d013c0 <io_usb_hid_exchange>
c0d01aec:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01aee:	4832      	ldr	r0, [pc, #200]	; (c0d01bb8 <io_exchange+0x120>)
c0d01af0:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01af2:	4833      	ldr	r0, [pc, #204]	; (c0d01bc0 <io_exchange+0x128>)
c0d01af4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01af6:	4833      	ldr	r0, [pc, #204]	; (c0d01bc4 <io_exchange+0x12c>)
c0d01af8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01afa:	4833      	ldr	r0, [pc, #204]	; (c0d01bc8 <io_exchange+0x130>)
c0d01afc:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01afe:	4833      	ldr	r0, [pc, #204]	; (c0d01bcc <io_exchange+0x134>)
c0d01b00:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01b02:	06a0      	lsls	r0, r4, #26
c0d01b04:	d4d3      	bmi.n	c0d01aae <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01b06:	f7ff fcd3 	bl	c0d014b0 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01b0a:	0620      	lsls	r0, r4, #24
c0d01b0c:	d501      	bpl.n	c0d01b12 <io_exchange+0x7a>
        reset();
c0d01b0e:	f000 faeb 	bl	c0d020e8 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01b12:	2e00      	cmp	r6, #0
c0d01b14:	d10c      	bne.n	c0d01b30 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01b16:	0660      	lsls	r0, r4, #25
c0d01b18:	d448      	bmi.n	c0d01bac <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01b1a:	4827      	ldr	r0, [pc, #156]	; (c0d01bb8 <io_exchange+0x120>)
c0d01b1c:	2100      	movs	r1, #0
c0d01b1e:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01b20:	4827      	ldr	r0, [pc, #156]	; (c0d01bc0 <io_exchange+0x128>)
c0d01b22:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01b24:	4827      	ldr	r0, [pc, #156]	; (c0d01bc4 <io_exchange+0x12c>)
c0d01b26:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01b28:	4827      	ldr	r0, [pc, #156]	; (c0d01bc8 <io_exchange+0x130>)
c0d01b2a:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01b2c:	4827      	ldr	r0, [pc, #156]	; (c0d01bcc <io_exchange+0x134>)
c0d01b2e:	7001      	strb	r1, [r0, #0]
c0d01b30:	4c28      	ldr	r4, [pc, #160]	; (c0d01bd4 <io_exchange+0x13c>)
c0d01b32:	4e24      	ldr	r6, [pc, #144]	; (c0d01bc4 <io_exchange+0x12c>)
c0d01b34:	e008      	b.n	c0d01b48 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01b36:	f7ff fd0f 	bl	c0d01558 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01b3a:	8830      	ldrh	r0, [r6, #0]
c0d01b3c:	2800      	cmp	r0, #0
c0d01b3e:	d003      	beq.n	c0d01b48 <io_exchange+0xb0>
c0d01b40:	e032      	b.n	c0d01ba8 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01b42:	2002      	movs	r0, #2
c0d01b44:	f7ff f89e 	bl	c0d00c84 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01b48:	f000 fc72 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d01b4c:	2800      	cmp	r0, #0
c0d01b4e:	d101      	bne.n	c0d01b54 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01b50:	f7ff fcae 	bl	c0d014b0 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01b54:	2180      	movs	r1, #128	; 0x80
c0d01b56:	2500      	movs	r5, #0
c0d01b58:	4620      	mov	r0, r4
c0d01b5a:	462a      	mov	r2, r5
c0d01b5c:	f000 fc84 	bl	c0d02468 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01b60:	1ec1      	subs	r1, r0, #3
c0d01b62:	78a2      	ldrb	r2, [r4, #2]
c0d01b64:	7863      	ldrb	r3, [r4, #1]
c0d01b66:	021b      	lsls	r3, r3, #8
c0d01b68:	4313      	orrs	r3, r2
c0d01b6a:	4299      	cmp	r1, r3
c0d01b6c:	d110      	bne.n	c0d01b90 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01b6e:	4917      	ldr	r1, [pc, #92]	; (c0d01bcc <io_exchange+0x134>)
c0d01b70:	7809      	ldrb	r1, [r1, #0]
c0d01b72:	2900      	cmp	r1, #0
c0d01b74:	d002      	beq.n	c0d01b7c <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01b76:	f7ff fd73 	bl	c0d01660 <io_seproxyhal_handle_event>
c0d01b7a:	e7e5      	b.n	c0d01b48 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01b7c:	7821      	ldrb	r1, [r4, #0]
c0d01b7e:	2910      	cmp	r1, #16
c0d01b80:	d00f      	beq.n	c0d01ba2 <io_exchange+0x10a>
c0d01b82:	290f      	cmp	r1, #15
c0d01b84:	d1dd      	bne.n	c0d01b42 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01b86:	2804      	cmp	r0, #4
c0d01b88:	d102      	bne.n	c0d01b90 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01b8a:	f7ff fca7 	bl	c0d014dc <io_seproxyhal_handle_usb_event>
c0d01b8e:	e7db      	b.n	c0d01b48 <io_exchange+0xb0>
c0d01b90:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01b92:	4909      	ldr	r1, [pc, #36]	; (c0d01bb8 <io_exchange+0x120>)
c0d01b94:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01b96:	490a      	ldr	r1, [pc, #40]	; (c0d01bc0 <io_exchange+0x128>)
c0d01b98:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01b9a:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01b9c:	490a      	ldr	r1, [pc, #40]	; (c0d01bc8 <io_exchange+0x130>)
c0d01b9e:	8008      	strh	r0, [r1, #0]
c0d01ba0:	e7d2      	b.n	c0d01b48 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01ba2:	2806      	cmp	r0, #6
c0d01ba4:	d2c7      	bcs.n	c0d01b36 <io_exchange+0x9e>
c0d01ba6:	e782      	b.n	c0d01aae <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01ba8:	8835      	ldrh	r5, [r6, #0]
c0d01baa:	e780      	b.n	c0d01aae <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01bac:	4805      	ldr	r0, [pc, #20]	; (c0d01bc4 <io_exchange+0x12c>)
c0d01bae:	8800      	ldrh	r0, [r0, #0]
c0d01bb0:	4907      	ldr	r1, [pc, #28]	; (c0d01bd0 <io_exchange+0x138>)
c0d01bb2:	1845      	adds	r5, r0, r1
c0d01bb4:	e77b      	b.n	c0d01aae <io_exchange+0x16>
c0d01bb6:	46c0      	nop			; (mov r8, r8)
c0d01bb8:	20001d18 	.word	0x20001d18
c0d01bbc:	20001bb8 	.word	0x20001bb8
c0d01bc0:	20001d1a 	.word	0x20001d1a
c0d01bc4:	20001d1c 	.word	0x20001d1c
c0d01bc8:	20001d1e 	.word	0x20001d1e
c0d01bcc:	20001d10 	.word	0x20001d10
c0d01bd0:	0000fffb 	.word	0x0000fffb
c0d01bd4:	20001a18 	.word	0x20001a18
c0d01bd8:	fffffbbb 	.word	0xfffffbbb

c0d01bdc <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01bdc:	b081      	sub	sp, #4
c0d01bde:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01be0:	af03      	add	r7, sp, #12
c0d01be2:	b094      	sub	sp, #80	; 0x50
c0d01be4:	4616      	mov	r6, r2
c0d01be6:	460d      	mov	r5, r1
c0d01be8:	900e      	str	r0, [sp, #56]	; 0x38
c0d01bea:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01bec:	2d02      	cmp	r5, #2
c0d01bee:	d200      	bcs.n	c0d01bf2 <snprintf+0x16>
c0d01bf0:	e22a      	b.n	c0d02048 <snprintf+0x46c>
c0d01bf2:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01bf4:	2800      	cmp	r0, #0
c0d01bf6:	d100      	bne.n	c0d01bfa <snprintf+0x1e>
c0d01bf8:	e226      	b.n	c0d02048 <snprintf+0x46c>
c0d01bfa:	2e00      	cmp	r6, #0
c0d01bfc:	d100      	bne.n	c0d01c00 <snprintf+0x24>
c0d01bfe:	e223      	b.n	c0d02048 <snprintf+0x46c>
c0d01c00:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01c02:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c04:	9109      	str	r1, [sp, #36]	; 0x24
c0d01c06:	462a      	mov	r2, r5
c0d01c08:	f7ff fbae 	bl	c0d01368 <os_memset>
c0d01c0c:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01c0e:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01c10:	7830      	ldrb	r0, [r6, #0]
c0d01c12:	2800      	cmp	r0, #0
c0d01c14:	d100      	bne.n	c0d01c18 <snprintf+0x3c>
c0d01c16:	e217      	b.n	c0d02048 <snprintf+0x46c>
c0d01c18:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01c1a:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01c1c:	1e6b      	subs	r3, r5, #1
c0d01c1e:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01c20:	460a      	mov	r2, r1
c0d01c22:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01c24:	e003      	b.n	c0d01c2e <snprintf+0x52>
c0d01c26:	1970      	adds	r0, r6, r5
c0d01c28:	7840      	ldrb	r0, [r0, #1]
c0d01c2a:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01c2c:	1c6d      	adds	r5, r5, #1
c0d01c2e:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01c30:	2800      	cmp	r0, #0
c0d01c32:	d001      	beq.n	c0d01c38 <snprintf+0x5c>
c0d01c34:	2825      	cmp	r0, #37	; 0x25
c0d01c36:	d1f6      	bne.n	c0d01c26 <snprintf+0x4a>
c0d01c38:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01c3a:	429d      	cmp	r5, r3
c0d01c3c:	d300      	bcc.n	c0d01c40 <snprintf+0x64>
c0d01c3e:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01c40:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c42:	4631      	mov	r1, r6
c0d01c44:	462a      	mov	r2, r5
c0d01c46:	461c      	mov	r4, r3
c0d01c48:	f7ff fb98 	bl	c0d0137c <os_memmove>
c0d01c4c:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01c4e:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01c50:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c52:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01c54:	2b00      	cmp	r3, #0
c0d01c56:	d100      	bne.n	c0d01c5a <snprintf+0x7e>
c0d01c58:	e1f6      	b.n	c0d02048 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01c5a:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01c5c:	5d71      	ldrb	r1, [r6, r5]
c0d01c5e:	2925      	cmp	r1, #37	; 0x25
c0d01c60:	d000      	beq.n	c0d01c64 <snprintf+0x88>
c0d01c62:	e0ab      	b.n	c0d01dbc <snprintf+0x1e0>
c0d01c64:	9304      	str	r3, [sp, #16]
c0d01c66:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01c68:	1c40      	adds	r0, r0, #1
c0d01c6a:	2100      	movs	r1, #0
c0d01c6c:	2220      	movs	r2, #32
c0d01c6e:	920a      	str	r2, [sp, #40]	; 0x28
c0d01c70:	220a      	movs	r2, #10
c0d01c72:	9203      	str	r2, [sp, #12]
c0d01c74:	9102      	str	r1, [sp, #8]
c0d01c76:	9106      	str	r1, [sp, #24]
c0d01c78:	910d      	str	r1, [sp, #52]	; 0x34
c0d01c7a:	460b      	mov	r3, r1
c0d01c7c:	2102      	movs	r1, #2
c0d01c7e:	910c      	str	r1, [sp, #48]	; 0x30
c0d01c80:	4606      	mov	r6, r0
c0d01c82:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01c84:	7831      	ldrb	r1, [r6, #0]
c0d01c86:	1c76      	adds	r6, r6, #1
c0d01c88:	2300      	movs	r3, #0
c0d01c8a:	2962      	cmp	r1, #98	; 0x62
c0d01c8c:	dc41      	bgt.n	c0d01d12 <snprintf+0x136>
c0d01c8e:	4608      	mov	r0, r1
c0d01c90:	3825      	subs	r0, #37	; 0x25
c0d01c92:	2823      	cmp	r0, #35	; 0x23
c0d01c94:	d900      	bls.n	c0d01c98 <snprintf+0xbc>
c0d01c96:	e094      	b.n	c0d01dc2 <snprintf+0x1e6>
c0d01c98:	0040      	lsls	r0, r0, #1
c0d01c9a:	46c0      	nop			; (mov r8, r8)
c0d01c9c:	4478      	add	r0, pc
c0d01c9e:	8880      	ldrh	r0, [r0, #4]
c0d01ca0:	0040      	lsls	r0, r0, #1
c0d01ca2:	4487      	add	pc, r0
c0d01ca4:	0186012d 	.word	0x0186012d
c0d01ca8:	01860186 	.word	0x01860186
c0d01cac:	00510186 	.word	0x00510186
c0d01cb0:	01860186 	.word	0x01860186
c0d01cb4:	00580023 	.word	0x00580023
c0d01cb8:	00240186 	.word	0x00240186
c0d01cbc:	00240024 	.word	0x00240024
c0d01cc0:	00240024 	.word	0x00240024
c0d01cc4:	00240024 	.word	0x00240024
c0d01cc8:	00240024 	.word	0x00240024
c0d01ccc:	01860024 	.word	0x01860024
c0d01cd0:	01860186 	.word	0x01860186
c0d01cd4:	01860186 	.word	0x01860186
c0d01cd8:	01860186 	.word	0x01860186
c0d01cdc:	01860186 	.word	0x01860186
c0d01ce0:	01860186 	.word	0x01860186
c0d01ce4:	01860186 	.word	0x01860186
c0d01ce8:	006c0186 	.word	0x006c0186
c0d01cec:	e7c9      	b.n	c0d01c82 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01cee:	2930      	cmp	r1, #48	; 0x30
c0d01cf0:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01cf2:	4603      	mov	r3, r0
c0d01cf4:	d100      	bne.n	c0d01cf8 <snprintf+0x11c>
c0d01cf6:	460b      	mov	r3, r1
c0d01cf8:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01cfa:	2c00      	cmp	r4, #0
c0d01cfc:	d000      	beq.n	c0d01d00 <snprintf+0x124>
c0d01cfe:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01d00:	200a      	movs	r0, #10
c0d01d02:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01d04:	1840      	adds	r0, r0, r1
c0d01d06:	3830      	subs	r0, #48	; 0x30
c0d01d08:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d0a:	4630      	mov	r0, r6
c0d01d0c:	930a      	str	r3, [sp, #40]	; 0x28
c0d01d0e:	4613      	mov	r3, r2
c0d01d10:	e7b4      	b.n	c0d01c7c <snprintf+0xa0>
c0d01d12:	296f      	cmp	r1, #111	; 0x6f
c0d01d14:	dd11      	ble.n	c0d01d3a <snprintf+0x15e>
c0d01d16:	3970      	subs	r1, #112	; 0x70
c0d01d18:	2908      	cmp	r1, #8
c0d01d1a:	d900      	bls.n	c0d01d1e <snprintf+0x142>
c0d01d1c:	e149      	b.n	c0d01fb2 <snprintf+0x3d6>
c0d01d1e:	0049      	lsls	r1, r1, #1
c0d01d20:	4479      	add	r1, pc
c0d01d22:	8889      	ldrh	r1, [r1, #4]
c0d01d24:	0049      	lsls	r1, r1, #1
c0d01d26:	448f      	add	pc, r1
c0d01d28:	01440051 	.word	0x01440051
c0d01d2c:	002e0144 	.word	0x002e0144
c0d01d30:	00590144 	.word	0x00590144
c0d01d34:	01440144 	.word	0x01440144
c0d01d38:	0051      	.short	0x0051
c0d01d3a:	2963      	cmp	r1, #99	; 0x63
c0d01d3c:	d054      	beq.n	c0d01de8 <snprintf+0x20c>
c0d01d3e:	2964      	cmp	r1, #100	; 0x64
c0d01d40:	d057      	beq.n	c0d01df2 <snprintf+0x216>
c0d01d42:	2968      	cmp	r1, #104	; 0x68
c0d01d44:	d01d      	beq.n	c0d01d82 <snprintf+0x1a6>
c0d01d46:	e134      	b.n	c0d01fb2 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01d48:	7830      	ldrb	r0, [r6, #0]
c0d01d4a:	2873      	cmp	r0, #115	; 0x73
c0d01d4c:	d000      	beq.n	c0d01d50 <snprintf+0x174>
c0d01d4e:	e130      	b.n	c0d01fb2 <snprintf+0x3d6>
c0d01d50:	4630      	mov	r0, r6
c0d01d52:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01d54:	e00d      	b.n	c0d01d72 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01d56:	7830      	ldrb	r0, [r6, #0]
c0d01d58:	282a      	cmp	r0, #42	; 0x2a
c0d01d5a:	d000      	beq.n	c0d01d5e <snprintf+0x182>
c0d01d5c:	e129      	b.n	c0d01fb2 <snprintf+0x3d6>
c0d01d5e:	7871      	ldrb	r1, [r6, #1]
c0d01d60:	1c70      	adds	r0, r6, #1
c0d01d62:	2301      	movs	r3, #1
c0d01d64:	2948      	cmp	r1, #72	; 0x48
c0d01d66:	d004      	beq.n	c0d01d72 <snprintf+0x196>
c0d01d68:	2968      	cmp	r1, #104	; 0x68
c0d01d6a:	d002      	beq.n	c0d01d72 <snprintf+0x196>
c0d01d6c:	2973      	cmp	r1, #115	; 0x73
c0d01d6e:	d000      	beq.n	c0d01d72 <snprintf+0x196>
c0d01d70:	e11f      	b.n	c0d01fb2 <snprintf+0x3d6>
c0d01d72:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01d74:	1d0a      	adds	r2, r1, #4
c0d01d76:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01d78:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01d7a:	9102      	str	r1, [sp, #8]
c0d01d7c:	e77e      	b.n	c0d01c7c <snprintf+0xa0>
c0d01d7e:	2001      	movs	r0, #1
c0d01d80:	9006      	str	r0, [sp, #24]
c0d01d82:	2010      	movs	r0, #16
c0d01d84:	9003      	str	r0, [sp, #12]
c0d01d86:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01d88:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d8a:	1d01      	adds	r1, r0, #4
c0d01d8c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d8e:	2103      	movs	r1, #3
c0d01d90:	400a      	ands	r2, r1
c0d01d92:	1c5b      	adds	r3, r3, #1
c0d01d94:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01d96:	2a01      	cmp	r2, #1
c0d01d98:	d100      	bne.n	c0d01d9c <snprintf+0x1c0>
c0d01d9a:	e0b8      	b.n	c0d01f0e <snprintf+0x332>
c0d01d9c:	2a02      	cmp	r2, #2
c0d01d9e:	d100      	bne.n	c0d01da2 <snprintf+0x1c6>
c0d01da0:	e104      	b.n	c0d01fac <snprintf+0x3d0>
c0d01da2:	2a03      	cmp	r2, #3
c0d01da4:	4630      	mov	r0, r6
c0d01da6:	d100      	bne.n	c0d01daa <snprintf+0x1ce>
c0d01da8:	e768      	b.n	c0d01c7c <snprintf+0xa0>
c0d01daa:	9c08      	ldr	r4, [sp, #32]
c0d01dac:	4625      	mov	r5, r4
c0d01dae:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01db0:	1948      	adds	r0, r1, r5
c0d01db2:	7840      	ldrb	r0, [r0, #1]
c0d01db4:	1c6d      	adds	r5, r5, #1
c0d01db6:	2800      	cmp	r0, #0
c0d01db8:	d1fa      	bne.n	c0d01db0 <snprintf+0x1d4>
c0d01dba:	e0ab      	b.n	c0d01f14 <snprintf+0x338>
c0d01dbc:	4606      	mov	r6, r0
c0d01dbe:	920e      	str	r2, [sp, #56]	; 0x38
c0d01dc0:	e109      	b.n	c0d01fd6 <snprintf+0x3fa>
c0d01dc2:	2958      	cmp	r1, #88	; 0x58
c0d01dc4:	d000      	beq.n	c0d01dc8 <snprintf+0x1ec>
c0d01dc6:	e0f4      	b.n	c0d01fb2 <snprintf+0x3d6>
c0d01dc8:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01dca:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01dcc:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01dce:	1d01      	adds	r1, r0, #4
c0d01dd0:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01dd2:	6802      	ldr	r2, [r0, #0]
c0d01dd4:	2000      	movs	r0, #0
c0d01dd6:	9005      	str	r0, [sp, #20]
c0d01dd8:	2510      	movs	r5, #16
c0d01dda:	e014      	b.n	c0d01e06 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01ddc:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01dde:	1d01      	adds	r1, r0, #4
c0d01de0:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01de2:	6802      	ldr	r2, [r0, #0]
c0d01de4:	2000      	movs	r0, #0
c0d01de6:	e00c      	b.n	c0d01e02 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01de8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01dea:	1d01      	adds	r1, r0, #4
c0d01dec:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01dee:	6800      	ldr	r0, [r0, #0]
c0d01df0:	e087      	b.n	c0d01f02 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01df2:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01df4:	1d01      	adds	r1, r0, #4
c0d01df6:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01df8:	6800      	ldr	r0, [r0, #0]
c0d01dfa:	17c1      	asrs	r1, r0, #31
c0d01dfc:	1842      	adds	r2, r0, r1
c0d01dfe:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01e00:	0fc0      	lsrs	r0, r0, #31
c0d01e02:	9005      	str	r0, [sp, #20]
c0d01e04:	250a      	movs	r5, #10
c0d01e06:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e08:	4295      	cmp	r5, r2
c0d01e0a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01e0c:	d814      	bhi.n	c0d01e38 <snprintf+0x25c>
c0d01e0e:	2201      	movs	r2, #1
c0d01e10:	4628      	mov	r0, r5
c0d01e12:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01e14:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01e16:	4629      	mov	r1, r5
c0d01e18:	f001 fb4a 	bl	c0d034b0 <__aeabi_uidiv>
c0d01e1c:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01e1e:	4288      	cmp	r0, r1
c0d01e20:	d109      	bne.n	c0d01e36 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e22:	4628      	mov	r0, r5
c0d01e24:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01e26:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01e28:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01e2a:	910d      	str	r1, [sp, #52]	; 0x34
c0d01e2c:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01e2e:	4288      	cmp	r0, r1
c0d01e30:	4622      	mov	r2, r4
c0d01e32:	d9ee      	bls.n	c0d01e12 <snprintf+0x236>
c0d01e34:	e000      	b.n	c0d01e38 <snprintf+0x25c>
c0d01e36:	460c      	mov	r4, r1
c0d01e38:	950c      	str	r5, [sp, #48]	; 0x30
c0d01e3a:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01e3c:	2000      	movs	r0, #0
c0d01e3e:	4603      	mov	r3, r0
c0d01e40:	43c1      	mvns	r1, r0
c0d01e42:	9c05      	ldr	r4, [sp, #20]
c0d01e44:	2c00      	cmp	r4, #0
c0d01e46:	d100      	bne.n	c0d01e4a <snprintf+0x26e>
c0d01e48:	4621      	mov	r1, r4
c0d01e4a:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e4c:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01e4e:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01e50:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01e52:	b2ca      	uxtb	r2, r1
c0d01e54:	2a30      	cmp	r2, #48	; 0x30
c0d01e56:	d106      	bne.n	c0d01e66 <snprintf+0x28a>
c0d01e58:	2c00      	cmp	r4, #0
c0d01e5a:	d004      	beq.n	c0d01e66 <snprintf+0x28a>
c0d01e5c:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01e5e:	232d      	movs	r3, #45	; 0x2d
c0d01e60:	700b      	strb	r3, [r1, #0]
c0d01e62:	2400      	movs	r4, #0
c0d01e64:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01e66:	1e81      	subs	r1, r0, #2
c0d01e68:	290d      	cmp	r1, #13
c0d01e6a:	d80d      	bhi.n	c0d01e88 <snprintf+0x2ac>
c0d01e6c:	1e41      	subs	r1, r0, #1
c0d01e6e:	d00b      	beq.n	c0d01e88 <snprintf+0x2ac>
c0d01e70:	a810      	add	r0, sp, #64	; 0x40
c0d01e72:	9405      	str	r4, [sp, #20]
c0d01e74:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01e76:	4320      	orrs	r0, r4
c0d01e78:	f001 fdd0 	bl	c0d03a1c <__aeabi_memset>
c0d01e7c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e7e:	1900      	adds	r0, r0, r4
c0d01e80:	9c05      	ldr	r4, [sp, #20]
c0d01e82:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01e84:	1840      	adds	r0, r0, r1
c0d01e86:	1e43      	subs	r3, r0, #1
c0d01e88:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01e8a:	2c00      	cmp	r4, #0
c0d01e8c:	9601      	str	r6, [sp, #4]
c0d01e8e:	d003      	beq.n	c0d01e98 <snprintf+0x2bc>
c0d01e90:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01e92:	222d      	movs	r2, #45	; 0x2d
c0d01e94:	54c2      	strb	r2, [r0, r3]
c0d01e96:	1c5b      	adds	r3, r3, #1
c0d01e98:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01e9a:	2900      	cmp	r1, #0
c0d01e9c:	d003      	beq.n	c0d01ea6 <snprintf+0x2ca>
c0d01e9e:	2800      	cmp	r0, #0
c0d01ea0:	d003      	beq.n	c0d01eaa <snprintf+0x2ce>
c0d01ea2:	a06c      	add	r0, pc, #432	; (adr r0, c0d02054 <g_pcHex_cap>)
c0d01ea4:	e002      	b.n	c0d01eac <snprintf+0x2d0>
c0d01ea6:	461c      	mov	r4, r3
c0d01ea8:	e016      	b.n	c0d01ed8 <snprintf+0x2fc>
c0d01eaa:	a06e      	add	r0, pc, #440	; (adr r0, c0d02064 <g_pcHex>)
c0d01eac:	900d      	str	r0, [sp, #52]	; 0x34
c0d01eae:	461c      	mov	r4, r3
c0d01eb0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01eb2:	460e      	mov	r6, r1
c0d01eb4:	f001 fafc 	bl	c0d034b0 <__aeabi_uidiv>
c0d01eb8:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01eba:	4629      	mov	r1, r5
c0d01ebc:	f001 fb7e 	bl	c0d035bc <__aeabi_uidivmod>
c0d01ec0:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01ec2:	5c40      	ldrb	r0, [r0, r1]
c0d01ec4:	a910      	add	r1, sp, #64	; 0x40
c0d01ec6:	5508      	strb	r0, [r1, r4]
c0d01ec8:	4630      	mov	r0, r6
c0d01eca:	4629      	mov	r1, r5
c0d01ecc:	f001 faf0 	bl	c0d034b0 <__aeabi_uidiv>
c0d01ed0:	1c64      	adds	r4, r4, #1
c0d01ed2:	42b5      	cmp	r5, r6
c0d01ed4:	4601      	mov	r1, r0
c0d01ed6:	d9eb      	bls.n	c0d01eb0 <snprintf+0x2d4>
c0d01ed8:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01eda:	429c      	cmp	r4, r3
c0d01edc:	4625      	mov	r5, r4
c0d01ede:	d300      	bcc.n	c0d01ee2 <snprintf+0x306>
c0d01ee0:	461d      	mov	r5, r3
c0d01ee2:	a910      	add	r1, sp, #64	; 0x40
c0d01ee4:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01ee6:	4620      	mov	r0, r4
c0d01ee8:	462a      	mov	r2, r5
c0d01eea:	461e      	mov	r6, r3
c0d01eec:	f7ff fa46 	bl	c0d0137c <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01ef0:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01ef2:	1961      	adds	r1, r4, r5
c0d01ef4:	910e      	str	r1, [sp, #56]	; 0x38
c0d01ef6:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01ef8:	2800      	cmp	r0, #0
c0d01efa:	9e01      	ldr	r6, [sp, #4]
c0d01efc:	d16b      	bne.n	c0d01fd6 <snprintf+0x3fa>
c0d01efe:	e0a3      	b.n	c0d02048 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01f00:	2025      	movs	r0, #37	; 0x25
c0d01f02:	9907      	ldr	r1, [sp, #28]
c0d01f04:	7008      	strb	r0, [r1, #0]
c0d01f06:	9804      	ldr	r0, [sp, #16]
c0d01f08:	1e40      	subs	r0, r0, #1
c0d01f0a:	1c49      	adds	r1, r1, #1
c0d01f0c:	e05f      	b.n	c0d01fce <snprintf+0x3f2>
c0d01f0e:	9d02      	ldr	r5, [sp, #8]
c0d01f10:	9c08      	ldr	r4, [sp, #32]
c0d01f12:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01f14:	9803      	ldr	r0, [sp, #12]
c0d01f16:	2810      	cmp	r0, #16
c0d01f18:	9807      	ldr	r0, [sp, #28]
c0d01f1a:	d161      	bne.n	c0d01fe0 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01f1c:	2d00      	cmp	r5, #0
c0d01f1e:	d06a      	beq.n	c0d01ff6 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f20:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01f22:	1900      	adds	r0, r0, r4
c0d01f24:	900e      	str	r0, [sp, #56]	; 0x38
c0d01f26:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01f28:	1aa0      	subs	r0, r4, r2
c0d01f2a:	9b05      	ldr	r3, [sp, #20]
c0d01f2c:	4283      	cmp	r3, r0
c0d01f2e:	d800      	bhi.n	c0d01f32 <snprintf+0x356>
c0d01f30:	4603      	mov	r3, r0
c0d01f32:	930c      	str	r3, [sp, #48]	; 0x30
c0d01f34:	435c      	muls	r4, r3
c0d01f36:	940a      	str	r4, [sp, #40]	; 0x28
c0d01f38:	1c60      	adds	r0, r4, #1
c0d01f3a:	9007      	str	r0, [sp, #28]
c0d01f3c:	2000      	movs	r0, #0
c0d01f3e:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01f40:	9100      	str	r1, [sp, #0]
c0d01f42:	940e      	str	r4, [sp, #56]	; 0x38
c0d01f44:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01f46:	18e3      	adds	r3, r4, r3
c0d01f48:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f4a:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01f4c:	200f      	movs	r0, #15
c0d01f4e:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f50:	0909      	lsrs	r1, r1, #4
c0d01f52:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01f54:	18a4      	adds	r4, r4, r2
c0d01f56:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01f58:	2c02      	cmp	r4, #2
c0d01f5a:	d375      	bcc.n	c0d02048 <snprintf+0x46c>
c0d01f5c:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01f5e:	2c01      	cmp	r4, #1
c0d01f60:	d003      	beq.n	c0d01f6a <snprintf+0x38e>
c0d01f62:	2c00      	cmp	r4, #0
c0d01f64:	d108      	bne.n	c0d01f78 <snprintf+0x39c>
c0d01f66:	a43f      	add	r4, pc, #252	; (adr r4, c0d02064 <g_pcHex>)
c0d01f68:	e000      	b.n	c0d01f6c <snprintf+0x390>
c0d01f6a:	a43a      	add	r4, pc, #232	; (adr r4, c0d02054 <g_pcHex_cap>)
c0d01f6c:	b2c9      	uxtb	r1, r1
c0d01f6e:	5c61      	ldrb	r1, [r4, r1]
c0d01f70:	7019      	strb	r1, [r3, #0]
c0d01f72:	b2c0      	uxtb	r0, r0
c0d01f74:	5c20      	ldrb	r0, [r4, r0]
c0d01f76:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01f78:	9807      	ldr	r0, [sp, #28]
c0d01f7a:	4290      	cmp	r0, r2
c0d01f7c:	d064      	beq.n	c0d02048 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01f7e:	1e92      	subs	r2, r2, #2
c0d01f80:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01f82:	1ca4      	adds	r4, r4, #2
c0d01f84:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01f86:	1c40      	adds	r0, r0, #1
c0d01f88:	42a8      	cmp	r0, r5
c0d01f8a:	9900      	ldr	r1, [sp, #0]
c0d01f8c:	d3d9      	bcc.n	c0d01f42 <snprintf+0x366>
c0d01f8e:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f90:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01f92:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01f94:	1a08      	subs	r0, r1, r0
c0d01f96:	9b05      	ldr	r3, [sp, #20]
c0d01f98:	4283      	cmp	r3, r0
c0d01f9a:	d800      	bhi.n	c0d01f9e <snprintf+0x3c2>
c0d01f9c:	4603      	mov	r3, r0
c0d01f9e:	4608      	mov	r0, r1
c0d01fa0:	4358      	muls	r0, r3
c0d01fa2:	1820      	adds	r0, r4, r0
c0d01fa4:	900e      	str	r0, [sp, #56]	; 0x38
c0d01fa6:	1898      	adds	r0, r3, r2
c0d01fa8:	1c43      	adds	r3, r0, #1
c0d01faa:	e038      	b.n	c0d0201e <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01fac:	7808      	ldrb	r0, [r1, #0]
c0d01fae:	2800      	cmp	r0, #0
c0d01fb0:	d023      	beq.n	c0d01ffa <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01fb2:	2005      	movs	r0, #5
c0d01fb4:	9d04      	ldr	r5, [sp, #16]
c0d01fb6:	2d05      	cmp	r5, #5
c0d01fb8:	462c      	mov	r4, r5
c0d01fba:	d300      	bcc.n	c0d01fbe <snprintf+0x3e2>
c0d01fbc:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01fbe:	9807      	ldr	r0, [sp, #28]
c0d01fc0:	a12c      	add	r1, pc, #176	; (adr r1, c0d02074 <g_pcHex+0x10>)
c0d01fc2:	4622      	mov	r2, r4
c0d01fc4:	f7ff f9da 	bl	c0d0137c <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01fc8:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01fca:	9907      	ldr	r1, [sp, #28]
c0d01fcc:	1909      	adds	r1, r1, r4
c0d01fce:	910e      	str	r1, [sp, #56]	; 0x38
c0d01fd0:	4603      	mov	r3, r0
c0d01fd2:	2800      	cmp	r0, #0
c0d01fd4:	d038      	beq.n	c0d02048 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01fd6:	7830      	ldrb	r0, [r6, #0]
c0d01fd8:	2800      	cmp	r0, #0
c0d01fda:	9908      	ldr	r1, [sp, #32]
c0d01fdc:	d034      	beq.n	c0d02048 <snprintf+0x46c>
c0d01fde:	e61f      	b.n	c0d01c20 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01fe0:	429d      	cmp	r5, r3
c0d01fe2:	d300      	bcc.n	c0d01fe6 <snprintf+0x40a>
c0d01fe4:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01fe6:	462a      	mov	r2, r5
c0d01fe8:	461c      	mov	r4, r3
c0d01fea:	f7ff f9c7 	bl	c0d0137c <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01fee:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01ff0:	9907      	ldr	r1, [sp, #28]
c0d01ff2:	1949      	adds	r1, r1, r5
c0d01ff4:	e00f      	b.n	c0d02016 <snprintf+0x43a>
c0d01ff6:	900e      	str	r0, [sp, #56]	; 0x38
c0d01ff8:	e7ed      	b.n	c0d01fd6 <snprintf+0x3fa>
c0d01ffa:	9b04      	ldr	r3, [sp, #16]
c0d01ffc:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01ffe:	429c      	cmp	r4, r3
c0d02000:	d300      	bcc.n	c0d02004 <snprintf+0x428>
c0d02002:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d02004:	2120      	movs	r1, #32
c0d02006:	9807      	ldr	r0, [sp, #28]
c0d02008:	4622      	mov	r2, r4
c0d0200a:	f7ff f9ad 	bl	c0d01368 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d0200e:	9804      	ldr	r0, [sp, #16]
c0d02010:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d02012:	9907      	ldr	r1, [sp, #28]
c0d02014:	1909      	adds	r1, r1, r4
c0d02016:	910e      	str	r1, [sp, #56]	; 0x38
c0d02018:	4603      	mov	r3, r0
c0d0201a:	2800      	cmp	r0, #0
c0d0201c:	d014      	beq.n	c0d02048 <snprintf+0x46c>
c0d0201e:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d02020:	42a8      	cmp	r0, r5
c0d02022:	d9d8      	bls.n	c0d01fd6 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d02024:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d02026:	429a      	cmp	r2, r3
c0d02028:	d300      	bcc.n	c0d0202c <snprintf+0x450>
c0d0202a:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d0202c:	2120      	movs	r1, #32
c0d0202e:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d02030:	4628      	mov	r0, r5
c0d02032:	920d      	str	r2, [sp, #52]	; 0x34
c0d02034:	461c      	mov	r4, r3
c0d02036:	f7ff f997 	bl	c0d01368 <os_memset>
c0d0203a:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d0203c:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d0203e:	182d      	adds	r5, r5, r0
c0d02040:	950e      	str	r5, [sp, #56]	; 0x38
c0d02042:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d02044:	2c00      	cmp	r4, #0
c0d02046:	d1c6      	bne.n	c0d01fd6 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d02048:	2000      	movs	r0, #0
c0d0204a:	b014      	add	sp, #80	; 0x50
c0d0204c:	bcf0      	pop	{r4, r5, r6, r7}
c0d0204e:	bc02      	pop	{r1}
c0d02050:	b001      	add	sp, #4
c0d02052:	4708      	bx	r1

c0d02054 <g_pcHex_cap>:
c0d02054:	33323130 	.word	0x33323130
c0d02058:	37363534 	.word	0x37363534
c0d0205c:	42413938 	.word	0x42413938
c0d02060:	46454443 	.word	0x46454443

c0d02064 <g_pcHex>:
c0d02064:	33323130 	.word	0x33323130
c0d02068:	37363534 	.word	0x37363534
c0d0206c:	62613938 	.word	0x62613938
c0d02070:	66656463 	.word	0x66656463
c0d02074:	4f525245 	.word	0x4f525245
c0d02078:	00000052 	.word	0x00000052

c0d0207c <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d0207c:	b580      	push	{r7, lr}
c0d0207e:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d02080:	4904      	ldr	r1, [pc, #16]	; (c0d02094 <pic+0x18>)
c0d02082:	4288      	cmp	r0, r1
c0d02084:	d304      	bcc.n	c0d02090 <pic+0x14>
c0d02086:	4904      	ldr	r1, [pc, #16]	; (c0d02098 <pic+0x1c>)
c0d02088:	4288      	cmp	r0, r1
c0d0208a:	d201      	bcs.n	c0d02090 <pic+0x14>
		link_address = pic_internal(link_address);
c0d0208c:	f000 f806 	bl	c0d0209c <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d02090:	bd80      	pop	{r7, pc}
c0d02092:	46c0      	nop			; (mov r8, r8)
c0d02094:	c0d00000 	.word	0xc0d00000
c0d02098:	c0d040c0 	.word	0xc0d040c0

c0d0209c <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d0209c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0209e:	4902      	ldr	r1, [pc, #8]	; (c0d020a8 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d020a0:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d020a2:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d020a4:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d020a6:	4770      	bx	lr
c0d020a8:	c0d0209d 	.word	0xc0d0209d

c0d020ac <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d020ac:	b580      	push	{r7, lr}
c0d020ae:	af00      	add	r7, sp, #0
c0d020b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d020b2:	490a      	ldr	r1, [pc, #40]	; (c0d020dc <check_api_level+0x30>)
c0d020b4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020b6:	490a      	ldr	r1, [pc, #40]	; (c0d020e0 <check_api_level+0x34>)
c0d020b8:	680a      	ldr	r2, [r1, #0]
c0d020ba:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d020bc:	9003      	str	r0, [sp, #12]
c0d020be:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020c0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020c2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020c4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d020c6:	4807      	ldr	r0, [pc, #28]	; (c0d020e4 <check_api_level+0x38>)
c0d020c8:	9a01      	ldr	r2, [sp, #4]
c0d020ca:	4282      	cmp	r2, r0
c0d020cc:	d101      	bne.n	c0d020d2 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d020ce:	b004      	add	sp, #16
c0d020d0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020d2:	6808      	ldr	r0, [r1, #0]
c0d020d4:	2104      	movs	r1, #4
c0d020d6:	f001 fd39 	bl	c0d03b4c <longjmp>
c0d020da:	46c0      	nop			; (mov r8, r8)
c0d020dc:	60000137 	.word	0x60000137
c0d020e0:	20001bb8 	.word	0x20001bb8
c0d020e4:	900001c6 	.word	0x900001c6

c0d020e8 <reset>:
  }
}

void reset ( void ) 
{
c0d020e8:	b580      	push	{r7, lr}
c0d020ea:	af00      	add	r7, sp, #0
c0d020ec:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d020ee:	4809      	ldr	r0, [pc, #36]	; (c0d02114 <reset+0x2c>)
c0d020f0:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020f2:	4809      	ldr	r0, [pc, #36]	; (c0d02118 <reset+0x30>)
c0d020f4:	6801      	ldr	r1, [r0, #0]
c0d020f6:	9101      	str	r1, [sp, #4]
c0d020f8:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020fa:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d020fc:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020fe:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d02100:	4906      	ldr	r1, [pc, #24]	; (c0d0211c <reset+0x34>)
c0d02102:	9a00      	ldr	r2, [sp, #0]
c0d02104:	428a      	cmp	r2, r1
c0d02106:	d101      	bne.n	c0d0210c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02108:	b002      	add	sp, #8
c0d0210a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0210c:	6800      	ldr	r0, [r0, #0]
c0d0210e:	2104      	movs	r1, #4
c0d02110:	f001 fd1c 	bl	c0d03b4c <longjmp>
c0d02114:	60000200 	.word	0x60000200
c0d02118:	20001bb8 	.word	0x20001bb8
c0d0211c:	900002f1 	.word	0x900002f1

c0d02120 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d02120:	b5d0      	push	{r4, r6, r7, lr}
c0d02122:	af02      	add	r7, sp, #8
c0d02124:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d02126:	4b0a      	ldr	r3, [pc, #40]	; (c0d02150 <nvm_write+0x30>)
c0d02128:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0212a:	4b0a      	ldr	r3, [pc, #40]	; (c0d02154 <nvm_write+0x34>)
c0d0212c:	681c      	ldr	r4, [r3, #0]
c0d0212e:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d02130:	ac03      	add	r4, sp, #12
c0d02132:	c407      	stmia	r4!, {r0, r1, r2}
c0d02134:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02136:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02138:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0213a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d0213c:	4806      	ldr	r0, [pc, #24]	; (c0d02158 <nvm_write+0x38>)
c0d0213e:	9901      	ldr	r1, [sp, #4]
c0d02140:	4281      	cmp	r1, r0
c0d02142:	d101      	bne.n	c0d02148 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02144:	b006      	add	sp, #24
c0d02146:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02148:	6818      	ldr	r0, [r3, #0]
c0d0214a:	2104      	movs	r1, #4
c0d0214c:	f001 fcfe 	bl	c0d03b4c <longjmp>
c0d02150:	6000037f 	.word	0x6000037f
c0d02154:	20001bb8 	.word	0x20001bb8
c0d02158:	900003bc 	.word	0x900003bc

c0d0215c <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d0215c:	b580      	push	{r7, lr}
c0d0215e:	af00      	add	r7, sp, #0
c0d02160:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d02162:	4a0a      	ldr	r2, [pc, #40]	; (c0d0218c <cx_rng+0x30>)
c0d02164:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02166:	4a0a      	ldr	r2, [pc, #40]	; (c0d02190 <cx_rng+0x34>)
c0d02168:	6813      	ldr	r3, [r2, #0]
c0d0216a:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d0216c:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d0216e:	9103      	str	r1, [sp, #12]
c0d02170:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02172:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02174:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02176:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d02178:	4906      	ldr	r1, [pc, #24]	; (c0d02194 <cx_rng+0x38>)
c0d0217a:	9b00      	ldr	r3, [sp, #0]
c0d0217c:	428b      	cmp	r3, r1
c0d0217e:	d101      	bne.n	c0d02184 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02180:	b004      	add	sp, #16
c0d02182:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02184:	6810      	ldr	r0, [r2, #0]
c0d02186:	2104      	movs	r1, #4
c0d02188:	f001 fce0 	bl	c0d03b4c <longjmp>
c0d0218c:	6000052c 	.word	0x6000052c
c0d02190:	20001bb8 	.word	0x20001bb8
c0d02194:	90000567 	.word	0x90000567

c0d02198 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d02198:	b580      	push	{r7, lr}
c0d0219a:	af00      	add	r7, sp, #0
c0d0219c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d0219e:	490a      	ldr	r1, [pc, #40]	; (c0d021c8 <cx_sha256_init+0x30>)
c0d021a0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021a2:	490a      	ldr	r1, [pc, #40]	; (c0d021cc <cx_sha256_init+0x34>)
c0d021a4:	680a      	ldr	r2, [r1, #0]
c0d021a6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d021a8:	9003      	str	r0, [sp, #12]
c0d021aa:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021ac:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021ae:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021b0:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d021b2:	4a07      	ldr	r2, [pc, #28]	; (c0d021d0 <cx_sha256_init+0x38>)
c0d021b4:	9b01      	ldr	r3, [sp, #4]
c0d021b6:	4293      	cmp	r3, r2
c0d021b8:	d101      	bne.n	c0d021be <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d021ba:	b004      	add	sp, #16
c0d021bc:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021be:	6808      	ldr	r0, [r1, #0]
c0d021c0:	2104      	movs	r1, #4
c0d021c2:	f001 fcc3 	bl	c0d03b4c <longjmp>
c0d021c6:	46c0      	nop			; (mov r8, r8)
c0d021c8:	600008db 	.word	0x600008db
c0d021cc:	20001bb8 	.word	0x20001bb8
c0d021d0:	90000864 	.word	0x90000864

c0d021d4 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d021d4:	b580      	push	{r7, lr}
c0d021d6:	af00      	add	r7, sp, #0
c0d021d8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d021da:	4a0a      	ldr	r2, [pc, #40]	; (c0d02204 <cx_keccak_init+0x30>)
c0d021dc:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021de:	4a0a      	ldr	r2, [pc, #40]	; (c0d02208 <cx_keccak_init+0x34>)
c0d021e0:	6813      	ldr	r3, [r2, #0]
c0d021e2:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d021e4:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d021e6:	9103      	str	r1, [sp, #12]
c0d021e8:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021ea:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021ec:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021ee:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d021f0:	4906      	ldr	r1, [pc, #24]	; (c0d0220c <cx_keccak_init+0x38>)
c0d021f2:	9b00      	ldr	r3, [sp, #0]
c0d021f4:	428b      	cmp	r3, r1
c0d021f6:	d101      	bne.n	c0d021fc <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d021f8:	b004      	add	sp, #16
c0d021fa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021fc:	6810      	ldr	r0, [r2, #0]
c0d021fe:	2104      	movs	r1, #4
c0d02200:	f001 fca4 	bl	c0d03b4c <longjmp>
c0d02204:	60000c3c 	.word	0x60000c3c
c0d02208:	20001bb8 	.word	0x20001bb8
c0d0220c:	90000c39 	.word	0x90000c39

c0d02210 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d02210:	b5b0      	push	{r4, r5, r7, lr}
c0d02212:	af02      	add	r7, sp, #8
c0d02214:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d02216:	4c0b      	ldr	r4, [pc, #44]	; (c0d02244 <cx_hash+0x34>)
c0d02218:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0221a:	4c0b      	ldr	r4, [pc, #44]	; (c0d02248 <cx_hash+0x38>)
c0d0221c:	6825      	ldr	r5, [r4, #0]
c0d0221e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02220:	ad03      	add	r5, sp, #12
c0d02222:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02224:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d02226:	9007      	str	r0, [sp, #28]
c0d02228:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0222a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0222c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0222e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d02230:	4906      	ldr	r1, [pc, #24]	; (c0d0224c <cx_hash+0x3c>)
c0d02232:	9a01      	ldr	r2, [sp, #4]
c0d02234:	428a      	cmp	r2, r1
c0d02236:	d101      	bne.n	c0d0223c <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02238:	b008      	add	sp, #32
c0d0223a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0223c:	6820      	ldr	r0, [r4, #0]
c0d0223e:	2104      	movs	r1, #4
c0d02240:	f001 fc84 	bl	c0d03b4c <longjmp>
c0d02244:	60000ea6 	.word	0x60000ea6
c0d02248:	20001bb8 	.word	0x20001bb8
c0d0224c:	90000e46 	.word	0x90000e46

c0d02250 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d02250:	b5b0      	push	{r4, r5, r7, lr}
c0d02252:	af02      	add	r7, sp, #8
c0d02254:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d02256:	4c0a      	ldr	r4, [pc, #40]	; (c0d02280 <cx_ecfp_init_public_key+0x30>)
c0d02258:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0225a:	4c0a      	ldr	r4, [pc, #40]	; (c0d02284 <cx_ecfp_init_public_key+0x34>)
c0d0225c:	6825      	ldr	r5, [r4, #0]
c0d0225e:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02260:	ad02      	add	r5, sp, #8
c0d02262:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02264:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02266:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02268:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0226a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d0226c:	4906      	ldr	r1, [pc, #24]	; (c0d02288 <cx_ecfp_init_public_key+0x38>)
c0d0226e:	9a00      	ldr	r2, [sp, #0]
c0d02270:	428a      	cmp	r2, r1
c0d02272:	d101      	bne.n	c0d02278 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02274:	b006      	add	sp, #24
c0d02276:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02278:	6820      	ldr	r0, [r4, #0]
c0d0227a:	2104      	movs	r1, #4
c0d0227c:	f001 fc66 	bl	c0d03b4c <longjmp>
c0d02280:	60002835 	.word	0x60002835
c0d02284:	20001bb8 	.word	0x20001bb8
c0d02288:	900028f0 	.word	0x900028f0

c0d0228c <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d0228c:	b5b0      	push	{r4, r5, r7, lr}
c0d0228e:	af02      	add	r7, sp, #8
c0d02290:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d02292:	4c0a      	ldr	r4, [pc, #40]	; (c0d022bc <cx_ecfp_init_private_key+0x30>)
c0d02294:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02296:	4c0a      	ldr	r4, [pc, #40]	; (c0d022c0 <cx_ecfp_init_private_key+0x34>)
c0d02298:	6825      	ldr	r5, [r4, #0]
c0d0229a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0229c:	ad02      	add	r5, sp, #8
c0d0229e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022a0:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022a2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022a4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022a6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d022a8:	4906      	ldr	r1, [pc, #24]	; (c0d022c4 <cx_ecfp_init_private_key+0x38>)
c0d022aa:	9a00      	ldr	r2, [sp, #0]
c0d022ac:	428a      	cmp	r2, r1
c0d022ae:	d101      	bne.n	c0d022b4 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022b0:	b006      	add	sp, #24
c0d022b2:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022b4:	6820      	ldr	r0, [r4, #0]
c0d022b6:	2104      	movs	r1, #4
c0d022b8:	f001 fc48 	bl	c0d03b4c <longjmp>
c0d022bc:	600029ed 	.word	0x600029ed
c0d022c0:	20001bb8 	.word	0x20001bb8
c0d022c4:	900029ae 	.word	0x900029ae

c0d022c8 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d022c8:	b5b0      	push	{r4, r5, r7, lr}
c0d022ca:	af02      	add	r7, sp, #8
c0d022cc:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d022ce:	4c0a      	ldr	r4, [pc, #40]	; (c0d022f8 <cx_ecfp_generate_pair+0x30>)
c0d022d0:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022d2:	4c0a      	ldr	r4, [pc, #40]	; (c0d022fc <cx_ecfp_generate_pair+0x34>)
c0d022d4:	6825      	ldr	r5, [r4, #0]
c0d022d6:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d022d8:	ad02      	add	r5, sp, #8
c0d022da:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022dc:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022de:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022e0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022e2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d022e4:	4906      	ldr	r1, [pc, #24]	; (c0d02300 <cx_ecfp_generate_pair+0x38>)
c0d022e6:	9a00      	ldr	r2, [sp, #0]
c0d022e8:	428a      	cmp	r2, r1
c0d022ea:	d101      	bne.n	c0d022f0 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022ec:	b006      	add	sp, #24
c0d022ee:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022f0:	6820      	ldr	r0, [r4, #0]
c0d022f2:	2104      	movs	r1, #4
c0d022f4:	f001 fc2a 	bl	c0d03b4c <longjmp>
c0d022f8:	60002a2e 	.word	0x60002a2e
c0d022fc:	20001bb8 	.word	0x20001bb8
c0d02300:	90002a74 	.word	0x90002a74

c0d02304 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02304:	b5b0      	push	{r4, r5, r7, lr}
c0d02306:	af02      	add	r7, sp, #8
c0d02308:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d0230a:	4c0b      	ldr	r4, [pc, #44]	; (c0d02338 <os_perso_derive_node_bip32+0x34>)
c0d0230c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0230e:	4c0b      	ldr	r4, [pc, #44]	; (c0d0233c <os_perso_derive_node_bip32+0x38>)
c0d02310:	6825      	ldr	r5, [r4, #0]
c0d02312:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d02314:	ad03      	add	r5, sp, #12
c0d02316:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02318:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d0231a:	9007      	str	r0, [sp, #28]
c0d0231c:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0231e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02320:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02322:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d02324:	4806      	ldr	r0, [pc, #24]	; (c0d02340 <os_perso_derive_node_bip32+0x3c>)
c0d02326:	9901      	ldr	r1, [sp, #4]
c0d02328:	4281      	cmp	r1, r0
c0d0232a:	d101      	bne.n	c0d02330 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0232c:	b008      	add	sp, #32
c0d0232e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02330:	6820      	ldr	r0, [r4, #0]
c0d02332:	2104      	movs	r1, #4
c0d02334:	f001 fc0a 	bl	c0d03b4c <longjmp>
c0d02338:	6000512b 	.word	0x6000512b
c0d0233c:	20001bb8 	.word	0x20001bb8
c0d02340:	9000517f 	.word	0x9000517f

c0d02344 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d02344:	b580      	push	{r7, lr}
c0d02346:	af00      	add	r7, sp, #0
c0d02348:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d0234a:	490a      	ldr	r1, [pc, #40]	; (c0d02374 <os_sched_exit+0x30>)
c0d0234c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0234e:	490a      	ldr	r1, [pc, #40]	; (c0d02378 <os_sched_exit+0x34>)
c0d02350:	680a      	ldr	r2, [r1, #0]
c0d02352:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d02354:	9003      	str	r0, [sp, #12]
c0d02356:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02358:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0235a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0235c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d0235e:	4807      	ldr	r0, [pc, #28]	; (c0d0237c <os_sched_exit+0x38>)
c0d02360:	9a01      	ldr	r2, [sp, #4]
c0d02362:	4282      	cmp	r2, r0
c0d02364:	d101      	bne.n	c0d0236a <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02366:	b004      	add	sp, #16
c0d02368:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0236a:	6808      	ldr	r0, [r1, #0]
c0d0236c:	2104      	movs	r1, #4
c0d0236e:	f001 fbed 	bl	c0d03b4c <longjmp>
c0d02372:	46c0      	nop			; (mov r8, r8)
c0d02374:	60005fe1 	.word	0x60005fe1
c0d02378:	20001bb8 	.word	0x20001bb8
c0d0237c:	90005f6f 	.word	0x90005f6f

c0d02380 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02380:	b580      	push	{r7, lr}
c0d02382:	af00      	add	r7, sp, #0
c0d02384:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d02386:	490a      	ldr	r1, [pc, #40]	; (c0d023b0 <os_ux+0x30>)
c0d02388:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0238a:	490a      	ldr	r1, [pc, #40]	; (c0d023b4 <os_ux+0x34>)
c0d0238c:	680a      	ldr	r2, [r1, #0]
c0d0238e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02390:	9003      	str	r0, [sp, #12]
c0d02392:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02394:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02396:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02398:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d0239a:	4a07      	ldr	r2, [pc, #28]	; (c0d023b8 <os_ux+0x38>)
c0d0239c:	9b01      	ldr	r3, [sp, #4]
c0d0239e:	4293      	cmp	r3, r2
c0d023a0:	d101      	bne.n	c0d023a6 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d023a2:	b004      	add	sp, #16
c0d023a4:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023a6:	6808      	ldr	r0, [r1, #0]
c0d023a8:	2104      	movs	r1, #4
c0d023aa:	f001 fbcf 	bl	c0d03b4c <longjmp>
c0d023ae:	46c0      	nop			; (mov r8, r8)
c0d023b0:	60006158 	.word	0x60006158
c0d023b4:	20001bb8 	.word	0x20001bb8
c0d023b8:	9000611f 	.word	0x9000611f

c0d023bc <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d023bc:	b580      	push	{r7, lr}
c0d023be:	af00      	add	r7, sp, #0
c0d023c0:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d023c2:	4809      	ldr	r0, [pc, #36]	; (c0d023e8 <os_seph_features+0x2c>)
c0d023c4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023c6:	4909      	ldr	r1, [pc, #36]	; (c0d023ec <os_seph_features+0x30>)
c0d023c8:	6808      	ldr	r0, [r1, #0]
c0d023ca:	9001      	str	r0, [sp, #4]
c0d023cc:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023ce:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023d0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023d2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d023d4:	4a06      	ldr	r2, [pc, #24]	; (c0d023f0 <os_seph_features+0x34>)
c0d023d6:	9b00      	ldr	r3, [sp, #0]
c0d023d8:	4293      	cmp	r3, r2
c0d023da:	d101      	bne.n	c0d023e0 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d023dc:	b002      	add	sp, #8
c0d023de:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023e0:	6808      	ldr	r0, [r1, #0]
c0d023e2:	2104      	movs	r1, #4
c0d023e4:	f001 fbb2 	bl	c0d03b4c <longjmp>
c0d023e8:	600064d6 	.word	0x600064d6
c0d023ec:	20001bb8 	.word	0x20001bb8
c0d023f0:	90006444 	.word	0x90006444

c0d023f4 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d023f4:	b580      	push	{r7, lr}
c0d023f6:	af00      	add	r7, sp, #0
c0d023f8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d023fa:	4a0a      	ldr	r2, [pc, #40]	; (c0d02424 <io_seproxyhal_spi_send+0x30>)
c0d023fc:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023fe:	4a0a      	ldr	r2, [pc, #40]	; (c0d02428 <io_seproxyhal_spi_send+0x34>)
c0d02400:	6813      	ldr	r3, [r2, #0]
c0d02402:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02404:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d02406:	9103      	str	r1, [sp, #12]
c0d02408:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0240a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0240c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0240e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d02410:	4806      	ldr	r0, [pc, #24]	; (c0d0242c <io_seproxyhal_spi_send+0x38>)
c0d02412:	9900      	ldr	r1, [sp, #0]
c0d02414:	4281      	cmp	r1, r0
c0d02416:	d101      	bne.n	c0d0241c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02418:	b004      	add	sp, #16
c0d0241a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0241c:	6810      	ldr	r0, [r2, #0]
c0d0241e:	2104      	movs	r1, #4
c0d02420:	f001 fb94 	bl	c0d03b4c <longjmp>
c0d02424:	60006a1c 	.word	0x60006a1c
c0d02428:	20001bb8 	.word	0x20001bb8
c0d0242c:	90006af3 	.word	0x90006af3

c0d02430 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d02430:	b580      	push	{r7, lr}
c0d02432:	af00      	add	r7, sp, #0
c0d02434:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d02436:	4809      	ldr	r0, [pc, #36]	; (c0d0245c <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d02438:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0243a:	4909      	ldr	r1, [pc, #36]	; (c0d02460 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d0243c:	6808      	ldr	r0, [r1, #0]
c0d0243e:	9001      	str	r0, [sp, #4]
c0d02440:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02442:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02444:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02446:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d02448:	4a06      	ldr	r2, [pc, #24]	; (c0d02464 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d0244a:	9b00      	ldr	r3, [sp, #0]
c0d0244c:	4293      	cmp	r3, r2
c0d0244e:	d101      	bne.n	c0d02454 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02450:	b002      	add	sp, #8
c0d02452:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02454:	6808      	ldr	r0, [r1, #0]
c0d02456:	2104      	movs	r1, #4
c0d02458:	f001 fb78 	bl	c0d03b4c <longjmp>
c0d0245c:	60006bcf 	.word	0x60006bcf
c0d02460:	20001bb8 	.word	0x20001bb8
c0d02464:	90006b7f 	.word	0x90006b7f

c0d02468 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d02468:	b5d0      	push	{r4, r6, r7, lr}
c0d0246a:	af02      	add	r7, sp, #8
c0d0246c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d0246e:	4b0b      	ldr	r3, [pc, #44]	; (c0d0249c <io_seproxyhal_spi_recv+0x34>)
c0d02470:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02472:	4b0b      	ldr	r3, [pc, #44]	; (c0d024a0 <io_seproxyhal_spi_recv+0x38>)
c0d02474:	681c      	ldr	r4, [r3, #0]
c0d02476:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d02478:	ac03      	add	r4, sp, #12
c0d0247a:	c407      	stmia	r4!, {r0, r1, r2}
c0d0247c:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0247e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02480:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02482:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02484:	4907      	ldr	r1, [pc, #28]	; (c0d024a4 <io_seproxyhal_spi_recv+0x3c>)
c0d02486:	9a01      	ldr	r2, [sp, #4]
c0d02488:	428a      	cmp	r2, r1
c0d0248a:	d102      	bne.n	c0d02492 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d0248c:	b280      	uxth	r0, r0
c0d0248e:	b006      	add	sp, #24
c0d02490:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02492:	6818      	ldr	r0, [r3, #0]
c0d02494:	2104      	movs	r1, #4
c0d02496:	f001 fb59 	bl	c0d03b4c <longjmp>
c0d0249a:	46c0      	nop			; (mov r8, r8)
c0d0249c:	60006cd1 	.word	0x60006cd1
c0d024a0:	20001bb8 	.word	0x20001bb8
c0d024a4:	90006c2b 	.word	0x90006c2b

c0d024a8 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d024a8:	b5b0      	push	{r4, r5, r7, lr}
c0d024aa:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d024ac:	492c      	ldr	r1, [pc, #176]	; (c0d02560 <bagl_ui_nanos_screen1_button+0xb8>)
c0d024ae:	4288      	cmp	r0, r1
c0d024b0:	d006      	beq.n	c0d024c0 <bagl_ui_nanos_screen1_button+0x18>
c0d024b2:	492c      	ldr	r1, [pc, #176]	; (c0d02564 <bagl_ui_nanos_screen1_button+0xbc>)
c0d024b4:	4288      	cmp	r0, r1
c0d024b6:	d151      	bne.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d024b8:	2000      	movs	r0, #0
c0d024ba:	f7ff ff43 	bl	c0d02344 <os_sched_exit>
c0d024be:	e04d      	b.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d024c0:	f7fe fba4 	bl	c0d00c0c <nvram_is_init>
c0d024c4:	2801      	cmp	r0, #1
c0d024c6:	d102      	bne.n	c0d024ce <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d024c8:	a029      	add	r0, pc, #164	; (adr r0, c0d02570 <bagl_ui_nanos_screen1_button+0xc8>)
c0d024ca:	210d      	movs	r1, #13
c0d024cc:	e001      	b.n	c0d024d2 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d024ce:	a026      	add	r0, pc, #152	; (adr r0, c0d02568 <bagl_ui_nanos_screen1_button+0xc0>)
c0d024d0:	2105      	movs	r1, #5
c0d024d2:	2203      	movs	r2, #3
c0d024d4:	f7fd fde6 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d024d8:	4c29      	ldr	r4, [pc, #164]	; (c0d02580 <bagl_ui_nanos_screen1_button+0xd8>)
c0d024da:	482b      	ldr	r0, [pc, #172]	; (c0d02588 <bagl_ui_nanos_screen1_button+0xe0>)
c0d024dc:	4478      	add	r0, pc
c0d024de:	6020      	str	r0, [r4, #0]
c0d024e0:	2004      	movs	r0, #4
c0d024e2:	6060      	str	r0, [r4, #4]
c0d024e4:	4829      	ldr	r0, [pc, #164]	; (c0d0258c <bagl_ui_nanos_screen1_button+0xe4>)
c0d024e6:	4478      	add	r0, pc
c0d024e8:	6120      	str	r0, [r4, #16]
c0d024ea:	2500      	movs	r5, #0
c0d024ec:	60e5      	str	r5, [r4, #12]
c0d024ee:	2003      	movs	r0, #3
c0d024f0:	7620      	strb	r0, [r4, #24]
c0d024f2:	61e5      	str	r5, [r4, #28]
c0d024f4:	4620      	mov	r0, r4
c0d024f6:	3018      	adds	r0, #24
c0d024f8:	f7ff ff42 	bl	c0d02380 <os_ux>
c0d024fc:	61e0      	str	r0, [r4, #28]
c0d024fe:	f7ff f903 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d02502:	60a5      	str	r5, [r4, #8]
c0d02504:	6820      	ldr	r0, [r4, #0]
c0d02506:	2800      	cmp	r0, #0
c0d02508:	d028      	beq.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
c0d0250a:	69e0      	ldr	r0, [r4, #28]
c0d0250c:	491d      	ldr	r1, [pc, #116]	; (c0d02584 <bagl_ui_nanos_screen1_button+0xdc>)
c0d0250e:	4288      	cmp	r0, r1
c0d02510:	d116      	bne.n	c0d02540 <bagl_ui_nanos_screen1_button+0x98>
c0d02512:	e023      	b.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
c0d02514:	6860      	ldr	r0, [r4, #4]
c0d02516:	4285      	cmp	r5, r0
c0d02518:	d220      	bcs.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
c0d0251a:	f7ff ff89 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d0251e:	2800      	cmp	r0, #0
c0d02520:	d11c      	bne.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
c0d02522:	68a0      	ldr	r0, [r4, #8]
c0d02524:	68e1      	ldr	r1, [r4, #12]
c0d02526:	2538      	movs	r5, #56	; 0x38
c0d02528:	4368      	muls	r0, r5
c0d0252a:	6822      	ldr	r2, [r4, #0]
c0d0252c:	1810      	adds	r0, r2, r0
c0d0252e:	2900      	cmp	r1, #0
c0d02530:	d009      	beq.n	c0d02546 <bagl_ui_nanos_screen1_button+0x9e>
c0d02532:	4788      	blx	r1
c0d02534:	2800      	cmp	r0, #0
c0d02536:	d106      	bne.n	c0d02546 <bagl_ui_nanos_screen1_button+0x9e>
c0d02538:	68a0      	ldr	r0, [r4, #8]
c0d0253a:	1c45      	adds	r5, r0, #1
c0d0253c:	60a5      	str	r5, [r4, #8]
c0d0253e:	6820      	ldr	r0, [r4, #0]
c0d02540:	2800      	cmp	r0, #0
c0d02542:	d1e7      	bne.n	c0d02514 <bagl_ui_nanos_screen1_button+0x6c>
c0d02544:	e00a      	b.n	c0d0255c <bagl_ui_nanos_screen1_button+0xb4>
c0d02546:	2801      	cmp	r0, #1
c0d02548:	d103      	bne.n	c0d02552 <bagl_ui_nanos_screen1_button+0xaa>
c0d0254a:	68a0      	ldr	r0, [r4, #8]
c0d0254c:	4345      	muls	r5, r0
c0d0254e:	6820      	ldr	r0, [r4, #0]
c0d02550:	1940      	adds	r0, r0, r5
c0d02552:	f7fe fb91 	bl	c0d00c78 <io_seproxyhal_display>
c0d02556:	68a0      	ldr	r0, [r4, #8]
c0d02558:	1c40      	adds	r0, r0, #1
c0d0255a:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d0255c:	2000      	movs	r0, #0
c0d0255e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02560:	80000002 	.word	0x80000002
c0d02564:	80000001 	.word	0x80000001
c0d02568:	54494e49 	.word	0x54494e49
c0d0256c:	00000000 	.word	0x00000000
c0d02570:	6c697453 	.word	0x6c697453
c0d02574:	6e75206c 	.word	0x6e75206c
c0d02578:	74696e69 	.word	0x74696e69
c0d0257c:	00000000 	.word	0x00000000
c0d02580:	20001a98 	.word	0x20001a98
c0d02584:	b0105044 	.word	0xb0105044
c0d02588:	000018a8 	.word	0x000018a8
c0d0258c:	00000153 	.word	0x00000153

c0d02590 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02590:	b5b0      	push	{r4, r5, r7, lr}
c0d02592:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02594:	2800      	cmp	r0, #0
c0d02596:	d005      	beq.n	c0d025a4 <ui_display_debug+0x14>
c0d02598:	2900      	cmp	r1, #0
c0d0259a:	d003      	beq.n	c0d025a4 <ui_display_debug+0x14>
c0d0259c:	2a00      	cmp	r2, #0
c0d0259e:	d001      	beq.n	c0d025a4 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d025a0:	f7fd fd80 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d025a4:	4c21      	ldr	r4, [pc, #132]	; (c0d0262c <ui_display_debug+0x9c>)
c0d025a6:	4823      	ldr	r0, [pc, #140]	; (c0d02634 <ui_display_debug+0xa4>)
c0d025a8:	4478      	add	r0, pc
c0d025aa:	6020      	str	r0, [r4, #0]
c0d025ac:	2004      	movs	r0, #4
c0d025ae:	6060      	str	r0, [r4, #4]
c0d025b0:	4821      	ldr	r0, [pc, #132]	; (c0d02638 <ui_display_debug+0xa8>)
c0d025b2:	4478      	add	r0, pc
c0d025b4:	6120      	str	r0, [r4, #16]
c0d025b6:	2500      	movs	r5, #0
c0d025b8:	60e5      	str	r5, [r4, #12]
c0d025ba:	2003      	movs	r0, #3
c0d025bc:	7620      	strb	r0, [r4, #24]
c0d025be:	61e5      	str	r5, [r4, #28]
c0d025c0:	4620      	mov	r0, r4
c0d025c2:	3018      	adds	r0, #24
c0d025c4:	f7ff fedc 	bl	c0d02380 <os_ux>
c0d025c8:	61e0      	str	r0, [r4, #28]
c0d025ca:	f7ff f89d 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d025ce:	60a5      	str	r5, [r4, #8]
c0d025d0:	6820      	ldr	r0, [r4, #0]
c0d025d2:	2800      	cmp	r0, #0
c0d025d4:	d028      	beq.n	c0d02628 <ui_display_debug+0x98>
c0d025d6:	69e0      	ldr	r0, [r4, #28]
c0d025d8:	4915      	ldr	r1, [pc, #84]	; (c0d02630 <ui_display_debug+0xa0>)
c0d025da:	4288      	cmp	r0, r1
c0d025dc:	d116      	bne.n	c0d0260c <ui_display_debug+0x7c>
c0d025de:	e023      	b.n	c0d02628 <ui_display_debug+0x98>
c0d025e0:	6860      	ldr	r0, [r4, #4]
c0d025e2:	4285      	cmp	r5, r0
c0d025e4:	d220      	bcs.n	c0d02628 <ui_display_debug+0x98>
c0d025e6:	f7ff ff23 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d025ea:	2800      	cmp	r0, #0
c0d025ec:	d11c      	bne.n	c0d02628 <ui_display_debug+0x98>
c0d025ee:	68a0      	ldr	r0, [r4, #8]
c0d025f0:	68e1      	ldr	r1, [r4, #12]
c0d025f2:	2538      	movs	r5, #56	; 0x38
c0d025f4:	4368      	muls	r0, r5
c0d025f6:	6822      	ldr	r2, [r4, #0]
c0d025f8:	1810      	adds	r0, r2, r0
c0d025fa:	2900      	cmp	r1, #0
c0d025fc:	d009      	beq.n	c0d02612 <ui_display_debug+0x82>
c0d025fe:	4788      	blx	r1
c0d02600:	2800      	cmp	r0, #0
c0d02602:	d106      	bne.n	c0d02612 <ui_display_debug+0x82>
c0d02604:	68a0      	ldr	r0, [r4, #8]
c0d02606:	1c45      	adds	r5, r0, #1
c0d02608:	60a5      	str	r5, [r4, #8]
c0d0260a:	6820      	ldr	r0, [r4, #0]
c0d0260c:	2800      	cmp	r0, #0
c0d0260e:	d1e7      	bne.n	c0d025e0 <ui_display_debug+0x50>
c0d02610:	e00a      	b.n	c0d02628 <ui_display_debug+0x98>
c0d02612:	2801      	cmp	r0, #1
c0d02614:	d103      	bne.n	c0d0261e <ui_display_debug+0x8e>
c0d02616:	68a0      	ldr	r0, [r4, #8]
c0d02618:	4345      	muls	r5, r0
c0d0261a:	6820      	ldr	r0, [r4, #0]
c0d0261c:	1940      	adds	r0, r0, r5
c0d0261e:	f7fe fb2b 	bl	c0d00c78 <io_seproxyhal_display>
c0d02622:	68a0      	ldr	r0, [r4, #8]
c0d02624:	1c40      	adds	r0, r0, #1
c0d02626:	60a0      	str	r0, [r4, #8]
}
c0d02628:	bdb0      	pop	{r4, r5, r7, pc}
c0d0262a:	46c0      	nop			; (mov r8, r8)
c0d0262c:	20001a98 	.word	0x20001a98
c0d02630:	b0105044 	.word	0xb0105044
c0d02634:	000017dc 	.word	0x000017dc
c0d02638:	00000087 	.word	0x00000087

c0d0263c <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0263c:	b580      	push	{r7, lr}
c0d0263e:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d02640:	4905      	ldr	r1, [pc, #20]	; (c0d02658 <bagl_ui_nanos_screen2_button+0x1c>)
c0d02642:	4288      	cmp	r0, r1
c0d02644:	d002      	beq.n	c0d0264c <bagl_ui_nanos_screen2_button+0x10>
c0d02646:	4905      	ldr	r1, [pc, #20]	; (c0d0265c <bagl_ui_nanos_screen2_button+0x20>)
c0d02648:	4288      	cmp	r0, r1
c0d0264a:	d102      	bne.n	c0d02652 <bagl_ui_nanos_screen2_button+0x16>
c0d0264c:	2000      	movs	r0, #0
c0d0264e:	f7ff fe79 	bl	c0d02344 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d02652:	2000      	movs	r0, #0
c0d02654:	bd80      	pop	{r7, pc}
c0d02656:	46c0      	nop			; (mov r8, r8)
c0d02658:	80000002 	.word	0x80000002
c0d0265c:	80000001 	.word	0x80000001

c0d02660 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d02660:	b5b0      	push	{r4, r5, r7, lr}
c0d02662:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02664:	2001      	movs	r0, #1
c0d02666:	0204      	lsls	r4, r0, #8
c0d02668:	f7ff fea8 	bl	c0d023bc <os_seph_features>
c0d0266c:	4220      	tst	r0, r4
c0d0266e:	d136      	bne.n	c0d026de <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d02670:	4c3c      	ldr	r4, [pc, #240]	; (c0d02764 <ui_idle+0x104>)
c0d02672:	4840      	ldr	r0, [pc, #256]	; (c0d02774 <ui_idle+0x114>)
c0d02674:	4478      	add	r0, pc
c0d02676:	6020      	str	r0, [r4, #0]
c0d02678:	2004      	movs	r0, #4
c0d0267a:	6060      	str	r0, [r4, #4]
c0d0267c:	483e      	ldr	r0, [pc, #248]	; (c0d02778 <ui_idle+0x118>)
c0d0267e:	4478      	add	r0, pc
c0d02680:	6120      	str	r0, [r4, #16]
c0d02682:	2500      	movs	r5, #0
c0d02684:	60e5      	str	r5, [r4, #12]
c0d02686:	2003      	movs	r0, #3
c0d02688:	7620      	strb	r0, [r4, #24]
c0d0268a:	61e5      	str	r5, [r4, #28]
c0d0268c:	4620      	mov	r0, r4
c0d0268e:	3018      	adds	r0, #24
c0d02690:	f7ff fe76 	bl	c0d02380 <os_ux>
c0d02694:	61e0      	str	r0, [r4, #28]
c0d02696:	f7ff f837 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d0269a:	60a5      	str	r5, [r4, #8]
c0d0269c:	6820      	ldr	r0, [r4, #0]
c0d0269e:	2800      	cmp	r0, #0
c0d026a0:	d05f      	beq.n	c0d02762 <ui_idle+0x102>
c0d026a2:	69e0      	ldr	r0, [r4, #28]
c0d026a4:	4930      	ldr	r1, [pc, #192]	; (c0d02768 <ui_idle+0x108>)
c0d026a6:	4288      	cmp	r0, r1
c0d026a8:	d116      	bne.n	c0d026d8 <ui_idle+0x78>
c0d026aa:	e05a      	b.n	c0d02762 <ui_idle+0x102>
c0d026ac:	6860      	ldr	r0, [r4, #4]
c0d026ae:	4285      	cmp	r5, r0
c0d026b0:	d257      	bcs.n	c0d02762 <ui_idle+0x102>
c0d026b2:	f7ff febd 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d026b6:	2800      	cmp	r0, #0
c0d026b8:	d153      	bne.n	c0d02762 <ui_idle+0x102>
c0d026ba:	68a0      	ldr	r0, [r4, #8]
c0d026bc:	68e1      	ldr	r1, [r4, #12]
c0d026be:	2538      	movs	r5, #56	; 0x38
c0d026c0:	4368      	muls	r0, r5
c0d026c2:	6822      	ldr	r2, [r4, #0]
c0d026c4:	1810      	adds	r0, r2, r0
c0d026c6:	2900      	cmp	r1, #0
c0d026c8:	d040      	beq.n	c0d0274c <ui_idle+0xec>
c0d026ca:	4788      	blx	r1
c0d026cc:	2800      	cmp	r0, #0
c0d026ce:	d13d      	bne.n	c0d0274c <ui_idle+0xec>
c0d026d0:	68a0      	ldr	r0, [r4, #8]
c0d026d2:	1c45      	adds	r5, r0, #1
c0d026d4:	60a5      	str	r5, [r4, #8]
c0d026d6:	6820      	ldr	r0, [r4, #0]
c0d026d8:	2800      	cmp	r0, #0
c0d026da:	d1e7      	bne.n	c0d026ac <ui_idle+0x4c>
c0d026dc:	e041      	b.n	c0d02762 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d026de:	4c21      	ldr	r4, [pc, #132]	; (c0d02764 <ui_idle+0x104>)
c0d026e0:	4822      	ldr	r0, [pc, #136]	; (c0d0276c <ui_idle+0x10c>)
c0d026e2:	4478      	add	r0, pc
c0d026e4:	6020      	str	r0, [r4, #0]
c0d026e6:	2004      	movs	r0, #4
c0d026e8:	6060      	str	r0, [r4, #4]
c0d026ea:	4821      	ldr	r0, [pc, #132]	; (c0d02770 <ui_idle+0x110>)
c0d026ec:	4478      	add	r0, pc
c0d026ee:	6120      	str	r0, [r4, #16]
c0d026f0:	2500      	movs	r5, #0
c0d026f2:	60e5      	str	r5, [r4, #12]
c0d026f4:	2003      	movs	r0, #3
c0d026f6:	7620      	strb	r0, [r4, #24]
c0d026f8:	61e5      	str	r5, [r4, #28]
c0d026fa:	4620      	mov	r0, r4
c0d026fc:	3018      	adds	r0, #24
c0d026fe:	f7ff fe3f 	bl	c0d02380 <os_ux>
c0d02702:	61e0      	str	r0, [r4, #28]
c0d02704:	f7ff f800 	bl	c0d01708 <io_seproxyhal_init_ux>
c0d02708:	60a5      	str	r5, [r4, #8]
c0d0270a:	6820      	ldr	r0, [r4, #0]
c0d0270c:	2800      	cmp	r0, #0
c0d0270e:	d028      	beq.n	c0d02762 <ui_idle+0x102>
c0d02710:	69e0      	ldr	r0, [r4, #28]
c0d02712:	4915      	ldr	r1, [pc, #84]	; (c0d02768 <ui_idle+0x108>)
c0d02714:	4288      	cmp	r0, r1
c0d02716:	d116      	bne.n	c0d02746 <ui_idle+0xe6>
c0d02718:	e023      	b.n	c0d02762 <ui_idle+0x102>
c0d0271a:	6860      	ldr	r0, [r4, #4]
c0d0271c:	4285      	cmp	r5, r0
c0d0271e:	d220      	bcs.n	c0d02762 <ui_idle+0x102>
c0d02720:	f7ff fe86 	bl	c0d02430 <io_seproxyhal_spi_is_status_sent>
c0d02724:	2800      	cmp	r0, #0
c0d02726:	d11c      	bne.n	c0d02762 <ui_idle+0x102>
c0d02728:	68a0      	ldr	r0, [r4, #8]
c0d0272a:	68e1      	ldr	r1, [r4, #12]
c0d0272c:	2538      	movs	r5, #56	; 0x38
c0d0272e:	4368      	muls	r0, r5
c0d02730:	6822      	ldr	r2, [r4, #0]
c0d02732:	1810      	adds	r0, r2, r0
c0d02734:	2900      	cmp	r1, #0
c0d02736:	d009      	beq.n	c0d0274c <ui_idle+0xec>
c0d02738:	4788      	blx	r1
c0d0273a:	2800      	cmp	r0, #0
c0d0273c:	d106      	bne.n	c0d0274c <ui_idle+0xec>
c0d0273e:	68a0      	ldr	r0, [r4, #8]
c0d02740:	1c45      	adds	r5, r0, #1
c0d02742:	60a5      	str	r5, [r4, #8]
c0d02744:	6820      	ldr	r0, [r4, #0]
c0d02746:	2800      	cmp	r0, #0
c0d02748:	d1e7      	bne.n	c0d0271a <ui_idle+0xba>
c0d0274a:	e00a      	b.n	c0d02762 <ui_idle+0x102>
c0d0274c:	2801      	cmp	r0, #1
c0d0274e:	d103      	bne.n	c0d02758 <ui_idle+0xf8>
c0d02750:	68a0      	ldr	r0, [r4, #8]
c0d02752:	4345      	muls	r5, r0
c0d02754:	6820      	ldr	r0, [r4, #0]
c0d02756:	1940      	adds	r0, r0, r5
c0d02758:	f7fe fa8e 	bl	c0d00c78 <io_seproxyhal_display>
c0d0275c:	68a0      	ldr	r0, [r4, #8]
c0d0275e:	1c40      	adds	r0, r0, #1
c0d02760:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d02762:	bdb0      	pop	{r4, r5, r7, pc}
c0d02764:	20001a98 	.word	0x20001a98
c0d02768:	b0105044 	.word	0xb0105044
c0d0276c:	00001782 	.word	0x00001782
c0d02770:	0000008d 	.word	0x0000008d
c0d02774:	00001630 	.word	0x00001630
c0d02778:	fffffe27 	.word	0xfffffe27

c0d0277c <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d0277c:	2000      	movs	r0, #0
c0d0277e:	4770      	bx	lr

c0d02780 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02780:	b5d0      	push	{r4, r6, r7, lr}
c0d02782:	af02      	add	r7, sp, #8
c0d02784:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02786:	4620      	mov	r0, r4
c0d02788:	f7ff fddc 	bl	c0d02344 <os_sched_exit>
    return NULL;
c0d0278c:	4620      	mov	r0, r4
c0d0278e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02790 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02790:	4902      	ldr	r1, [pc, #8]	; (c0d0279c <USBD_LL_Init+0xc>)
c0d02792:	2000      	movs	r0, #0
c0d02794:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02796:	4902      	ldr	r1, [pc, #8]	; (c0d027a0 <USBD_LL_Init+0x10>)
c0d02798:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0279a:	4770      	bx	lr
c0d0279c:	20001d2c 	.word	0x20001d2c
c0d027a0:	20001d30 	.word	0x20001d30

c0d027a4 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d027a4:	b5d0      	push	{r4, r6, r7, lr}
c0d027a6:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027a8:	4806      	ldr	r0, [pc, #24]	; (c0d027c4 <USBD_LL_DeInit+0x20>)
c0d027aa:	214f      	movs	r1, #79	; 0x4f
c0d027ac:	7001      	strb	r1, [r0, #0]
c0d027ae:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d027b0:	7044      	strb	r4, [r0, #1]
c0d027b2:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d027b4:	7081      	strb	r1, [r0, #2]
c0d027b6:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d027b8:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d027ba:	2104      	movs	r1, #4
c0d027bc:	f7ff fe1a 	bl	c0d023f4 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d027c0:	4620      	mov	r0, r4
c0d027c2:	bdd0      	pop	{r4, r6, r7, pc}
c0d027c4:	20001a18 	.word	0x20001a18

c0d027c8 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d027c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d027ca:	af03      	add	r7, sp, #12
c0d027cc:	b083      	sub	sp, #12
c0d027ce:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027d0:	264f      	movs	r6, #79	; 0x4f
c0d027d2:	702e      	strb	r6, [r5, #0]
c0d027d4:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027d6:	706c      	strb	r4, [r5, #1]
c0d027d8:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d027da:	70a8      	strb	r0, [r5, #2]
c0d027dc:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d027de:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d027e0:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d027e2:	2105      	movs	r1, #5
c0d027e4:	4628      	mov	r0, r5
c0d027e6:	f7ff fe05 	bl	c0d023f4 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027ea:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d027ec:	706c      	strb	r4, [r5, #1]
c0d027ee:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d027f0:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d027f2:	70e8      	strb	r0, [r5, #3]
c0d027f4:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d027f6:	4628      	mov	r0, r5
c0d027f8:	f7ff fdfc 	bl	c0d023f4 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d027fc:	4620      	mov	r0, r4
c0d027fe:	b003      	add	sp, #12
c0d02800:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02802 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02802:	b5d0      	push	{r4, r6, r7, lr}
c0d02804:	af02      	add	r7, sp, #8
c0d02806:	b082      	sub	sp, #8
c0d02808:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0280a:	214f      	movs	r1, #79	; 0x4f
c0d0280c:	7001      	strb	r1, [r0, #0]
c0d0280e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02810:	7044      	strb	r4, [r0, #1]
c0d02812:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02814:	7081      	strb	r1, [r0, #2]
c0d02816:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02818:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d0281a:	2104      	movs	r1, #4
c0d0281c:	f7ff fdea 	bl	c0d023f4 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02820:	4620      	mov	r0, r4
c0d02822:	b002      	add	sp, #8
c0d02824:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02828 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02828:	b5b0      	push	{r4, r5, r7, lr}
c0d0282a:	af02      	add	r7, sp, #8
c0d0282c:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0282e:	480f      	ldr	r0, [pc, #60]	; (c0d0286c <USBD_LL_OpenEP+0x44>)
c0d02830:	2400      	movs	r4, #0
c0d02832:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02834:	480e      	ldr	r0, [pc, #56]	; (c0d02870 <USBD_LL_OpenEP+0x48>)
c0d02836:	6004      	str	r4, [r0, #0]
c0d02838:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0283a:	254f      	movs	r5, #79	; 0x4f
c0d0283c:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0283e:	7044      	strb	r4, [r0, #1]
c0d02840:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d02842:	7085      	strb	r5, [r0, #2]
c0d02844:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02846:	70c5      	strb	r5, [r0, #3]
c0d02848:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d0284a:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d0284c:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0284e:	2a03      	cmp	r2, #3
c0d02850:	d802      	bhi.n	c0d02858 <USBD_LL_OpenEP+0x30>
c0d02852:	00d0      	lsls	r0, r2, #3
c0d02854:	4c07      	ldr	r4, [pc, #28]	; (c0d02874 <USBD_LL_OpenEP+0x4c>)
c0d02856:	40c4      	lsrs	r4, r0
c0d02858:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d0285a:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d0285c:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0285e:	2108      	movs	r1, #8
c0d02860:	f7ff fdc8 	bl	c0d023f4 <io_seproxyhal_spi_send>
c0d02864:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02866:	b002      	add	sp, #8
c0d02868:	bdb0      	pop	{r4, r5, r7, pc}
c0d0286a:	46c0      	nop			; (mov r8, r8)
c0d0286c:	20001d2c 	.word	0x20001d2c
c0d02870:	20001d30 	.word	0x20001d30
c0d02874:	02030401 	.word	0x02030401

c0d02878 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02878:	b5d0      	push	{r4, r6, r7, lr}
c0d0287a:	af02      	add	r7, sp, #8
c0d0287c:	b082      	sub	sp, #8
c0d0287e:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02880:	224f      	movs	r2, #79	; 0x4f
c0d02882:	7002      	strb	r2, [r0, #0]
c0d02884:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02886:	7044      	strb	r4, [r0, #1]
c0d02888:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0288a:	7082      	strb	r2, [r0, #2]
c0d0288c:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0288e:	70c2      	strb	r2, [r0, #3]
c0d02890:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02892:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02894:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02896:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02898:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0289a:	2108      	movs	r1, #8
c0d0289c:	f7ff fdaa 	bl	c0d023f4 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d028a0:	4620      	mov	r0, r4
c0d028a2:	b002      	add	sp, #8
c0d028a4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d028a8 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d028a8:	b5b0      	push	{r4, r5, r7, lr}
c0d028aa:	af02      	add	r7, sp, #8
c0d028ac:	b082      	sub	sp, #8
c0d028ae:	460d      	mov	r5, r1
c0d028b0:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d028b2:	2150      	movs	r1, #80	; 0x50
c0d028b4:	7001      	strb	r1, [r0, #0]
c0d028b6:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d028b8:	7044      	strb	r4, [r0, #1]
c0d028ba:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d028bc:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d028be:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d028c0:	2140      	movs	r1, #64	; 0x40
c0d028c2:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d028c4:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d028c6:	2106      	movs	r1, #6
c0d028c8:	f7ff fd94 	bl	c0d023f4 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d028cc:	2080      	movs	r0, #128	; 0x80
c0d028ce:	4205      	tst	r5, r0
c0d028d0:	d101      	bne.n	c0d028d6 <USBD_LL_StallEP+0x2e>
c0d028d2:	4807      	ldr	r0, [pc, #28]	; (c0d028f0 <USBD_LL_StallEP+0x48>)
c0d028d4:	e000      	b.n	c0d028d8 <USBD_LL_StallEP+0x30>
c0d028d6:	4805      	ldr	r0, [pc, #20]	; (c0d028ec <USBD_LL_StallEP+0x44>)
c0d028d8:	6801      	ldr	r1, [r0, #0]
c0d028da:	227f      	movs	r2, #127	; 0x7f
c0d028dc:	4015      	ands	r5, r2
c0d028de:	2201      	movs	r2, #1
c0d028e0:	40aa      	lsls	r2, r5
c0d028e2:	430a      	orrs	r2, r1
c0d028e4:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d028e6:	4620      	mov	r0, r4
c0d028e8:	b002      	add	sp, #8
c0d028ea:	bdb0      	pop	{r4, r5, r7, pc}
c0d028ec:	20001d2c 	.word	0x20001d2c
c0d028f0:	20001d30 	.word	0x20001d30

c0d028f4 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d028f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028f6:	af03      	add	r7, sp, #12
c0d028f8:	b083      	sub	sp, #12
c0d028fa:	460d      	mov	r5, r1
c0d028fc:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d028fe:	2150      	movs	r1, #80	; 0x50
c0d02900:	7001      	strb	r1, [r0, #0]
c0d02902:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02904:	7044      	strb	r4, [r0, #1]
c0d02906:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02908:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0290a:	70c5      	strb	r5, [r0, #3]
c0d0290c:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0290e:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02910:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02912:	2106      	movs	r1, #6
c0d02914:	f7ff fd6e 	bl	c0d023f4 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02918:	4235      	tst	r5, r6
c0d0291a:	d101      	bne.n	c0d02920 <USBD_LL_ClearStallEP+0x2c>
c0d0291c:	4807      	ldr	r0, [pc, #28]	; (c0d0293c <USBD_LL_ClearStallEP+0x48>)
c0d0291e:	e000      	b.n	c0d02922 <USBD_LL_ClearStallEP+0x2e>
c0d02920:	4805      	ldr	r0, [pc, #20]	; (c0d02938 <USBD_LL_ClearStallEP+0x44>)
c0d02922:	6801      	ldr	r1, [r0, #0]
c0d02924:	227f      	movs	r2, #127	; 0x7f
c0d02926:	4015      	ands	r5, r2
c0d02928:	2201      	movs	r2, #1
c0d0292a:	40aa      	lsls	r2, r5
c0d0292c:	4391      	bics	r1, r2
c0d0292e:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02930:	4620      	mov	r0, r4
c0d02932:	b003      	add	sp, #12
c0d02934:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02936:	46c0      	nop			; (mov r8, r8)
c0d02938:	20001d2c 	.word	0x20001d2c
c0d0293c:	20001d30 	.word	0x20001d30

c0d02940 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d02940:	2080      	movs	r0, #128	; 0x80
c0d02942:	4201      	tst	r1, r0
c0d02944:	d001      	beq.n	c0d0294a <USBD_LL_IsStallEP+0xa>
c0d02946:	4806      	ldr	r0, [pc, #24]	; (c0d02960 <USBD_LL_IsStallEP+0x20>)
c0d02948:	e000      	b.n	c0d0294c <USBD_LL_IsStallEP+0xc>
c0d0294a:	4804      	ldr	r0, [pc, #16]	; (c0d0295c <USBD_LL_IsStallEP+0x1c>)
c0d0294c:	6800      	ldr	r0, [r0, #0]
c0d0294e:	227f      	movs	r2, #127	; 0x7f
c0d02950:	4011      	ands	r1, r2
c0d02952:	2201      	movs	r2, #1
c0d02954:	408a      	lsls	r2, r1
c0d02956:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02958:	b2d0      	uxtb	r0, r2
c0d0295a:	4770      	bx	lr
c0d0295c:	20001d30 	.word	0x20001d30
c0d02960:	20001d2c 	.word	0x20001d2c

c0d02964 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02964:	b5d0      	push	{r4, r6, r7, lr}
c0d02966:	af02      	add	r7, sp, #8
c0d02968:	b082      	sub	sp, #8
c0d0296a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0296c:	224f      	movs	r2, #79	; 0x4f
c0d0296e:	7002      	strb	r2, [r0, #0]
c0d02970:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02972:	7044      	strb	r4, [r0, #1]
c0d02974:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02976:	7082      	strb	r2, [r0, #2]
c0d02978:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0297a:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d0297c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0297e:	2105      	movs	r1, #5
c0d02980:	f7ff fd38 	bl	c0d023f4 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02984:	4620      	mov	r0, r4
c0d02986:	b002      	add	sp, #8
c0d02988:	bdd0      	pop	{r4, r6, r7, pc}

c0d0298a <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d0298a:	b5b0      	push	{r4, r5, r7, lr}
c0d0298c:	af02      	add	r7, sp, #8
c0d0298e:	b082      	sub	sp, #8
c0d02990:	461c      	mov	r4, r3
c0d02992:	4615      	mov	r5, r2
c0d02994:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02996:	2250      	movs	r2, #80	; 0x50
c0d02998:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0299a:	1ce2      	adds	r2, r4, #3
c0d0299c:	0a13      	lsrs	r3, r2, #8
c0d0299e:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d029a0:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d029a2:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d029a4:	2120      	movs	r1, #32
c0d029a6:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d029a8:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d029aa:	2106      	movs	r1, #6
c0d029ac:	f7ff fd22 	bl	c0d023f4 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d029b0:	4628      	mov	r0, r5
c0d029b2:	4621      	mov	r1, r4
c0d029b4:	f7ff fd1e 	bl	c0d023f4 <io_seproxyhal_spi_send>
c0d029b8:	2000      	movs	r0, #0
  return USBD_OK;   
c0d029ba:	b002      	add	sp, #8
c0d029bc:	bdb0      	pop	{r4, r5, r7, pc}

c0d029be <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d029be:	b5d0      	push	{r4, r6, r7, lr}
c0d029c0:	af02      	add	r7, sp, #8
c0d029c2:	b082      	sub	sp, #8
c0d029c4:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d029c6:	2350      	movs	r3, #80	; 0x50
c0d029c8:	7003      	strb	r3, [r0, #0]
c0d029ca:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d029cc:	7044      	strb	r4, [r0, #1]
c0d029ce:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d029d0:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d029d2:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d029d4:	2130      	movs	r1, #48	; 0x30
c0d029d6:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d029d8:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d029da:	2106      	movs	r1, #6
c0d029dc:	f7ff fd0a 	bl	c0d023f4 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d029e0:	4620      	mov	r0, r4
c0d029e2:	b002      	add	sp, #8
c0d029e4:	bdd0      	pop	{r4, r6, r7, pc}

c0d029e6 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d029e6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029e8:	af03      	add	r7, sp, #12
c0d029ea:	b081      	sub	sp, #4
c0d029ec:	4615      	mov	r5, r2
c0d029ee:	460e      	mov	r6, r1
c0d029f0:	4604      	mov	r4, r0
c0d029f2:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d029f4:	2c00      	cmp	r4, #0
c0d029f6:	d011      	beq.n	c0d02a1c <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d029f8:	2049      	movs	r0, #73	; 0x49
c0d029fa:	0081      	lsls	r1, r0, #2
c0d029fc:	4620      	mov	r0, r4
c0d029fe:	f001 f803 	bl	c0d03a08 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02a02:	2e00      	cmp	r6, #0
c0d02a04:	d002      	beq.n	c0d02a0c <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02a06:	2011      	movs	r0, #17
c0d02a08:	0100      	lsls	r0, r0, #4
c0d02a0a:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02a0c:	20fc      	movs	r0, #252	; 0xfc
c0d02a0e:	2101      	movs	r1, #1
c0d02a10:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02a12:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02a14:	4620      	mov	r0, r4
c0d02a16:	f7ff febb 	bl	c0d02790 <USBD_LL_Init>
c0d02a1a:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02a1c:	b2c0      	uxtb	r0, r0
c0d02a1e:	b001      	add	sp, #4
c0d02a20:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a22 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02a22:	b5d0      	push	{r4, r6, r7, lr}
c0d02a24:	af02      	add	r7, sp, #8
c0d02a26:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02a28:	20fc      	movs	r0, #252	; 0xfc
c0d02a2a:	2101      	movs	r1, #1
c0d02a2c:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d02a2e:	2045      	movs	r0, #69	; 0x45
c0d02a30:	0080      	lsls	r0, r0, #2
c0d02a32:	5820      	ldr	r0, [r4, r0]
c0d02a34:	2800      	cmp	r0, #0
c0d02a36:	d006      	beq.n	c0d02a46 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02a38:	6840      	ldr	r0, [r0, #4]
c0d02a3a:	f7ff fb1f 	bl	c0d0207c <pic>
c0d02a3e:	4602      	mov	r2, r0
c0d02a40:	7921      	ldrb	r1, [r4, #4]
c0d02a42:	4620      	mov	r0, r4
c0d02a44:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02a46:	4620      	mov	r0, r4
c0d02a48:	f7ff fedb 	bl	c0d02802 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02a4c:	4620      	mov	r0, r4
c0d02a4e:	f7ff fea9 	bl	c0d027a4 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02a52:	2000      	movs	r0, #0
c0d02a54:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a56 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02a56:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02a58:	2900      	cmp	r1, #0
c0d02a5a:	d003      	beq.n	c0d02a64 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02a5c:	2245      	movs	r2, #69	; 0x45
c0d02a5e:	0092      	lsls	r2, r2, #2
c0d02a60:	5081      	str	r1, [r0, r2]
c0d02a62:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02a64:	b2d0      	uxtb	r0, r2
c0d02a66:	4770      	bx	lr

c0d02a68 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02a68:	b580      	push	{r7, lr}
c0d02a6a:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02a6c:	f7ff feac 	bl	c0d027c8 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02a70:	2000      	movs	r0, #0
c0d02a72:	bd80      	pop	{r7, pc}

c0d02a74 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02a74:	b5b0      	push	{r4, r5, r7, lr}
c0d02a76:	af02      	add	r7, sp, #8
c0d02a78:	460c      	mov	r4, r1
c0d02a7a:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02a7c:	2045      	movs	r0, #69	; 0x45
c0d02a7e:	0080      	lsls	r0, r0, #2
c0d02a80:	5828      	ldr	r0, [r5, r0]
c0d02a82:	2800      	cmp	r0, #0
c0d02a84:	d00c      	beq.n	c0d02aa0 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02a86:	6800      	ldr	r0, [r0, #0]
c0d02a88:	f7ff faf8 	bl	c0d0207c <pic>
c0d02a8c:	4602      	mov	r2, r0
c0d02a8e:	4628      	mov	r0, r5
c0d02a90:	4621      	mov	r1, r4
c0d02a92:	4790      	blx	r2
c0d02a94:	4601      	mov	r1, r0
c0d02a96:	2002      	movs	r0, #2
c0d02a98:	2900      	cmp	r1, #0
c0d02a9a:	d100      	bne.n	c0d02a9e <USBD_SetClassConfig+0x2a>
c0d02a9c:	4608      	mov	r0, r1
c0d02a9e:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02aa0:	2002      	movs	r0, #2
c0d02aa2:	bdb0      	pop	{r4, r5, r7, pc}

c0d02aa4 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02aa4:	b5b0      	push	{r4, r5, r7, lr}
c0d02aa6:	af02      	add	r7, sp, #8
c0d02aa8:	460c      	mov	r4, r1
c0d02aaa:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02aac:	2045      	movs	r0, #69	; 0x45
c0d02aae:	0080      	lsls	r0, r0, #2
c0d02ab0:	5828      	ldr	r0, [r5, r0]
c0d02ab2:	2800      	cmp	r0, #0
c0d02ab4:	d006      	beq.n	c0d02ac4 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02ab6:	6840      	ldr	r0, [r0, #4]
c0d02ab8:	f7ff fae0 	bl	c0d0207c <pic>
c0d02abc:	4602      	mov	r2, r0
c0d02abe:	4628      	mov	r0, r5
c0d02ac0:	4621      	mov	r1, r4
c0d02ac2:	4790      	blx	r2
  }
  return USBD_OK;
c0d02ac4:	2000      	movs	r0, #0
c0d02ac6:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ac8 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02ac8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02aca:	af03      	add	r7, sp, #12
c0d02acc:	b081      	sub	sp, #4
c0d02ace:	4604      	mov	r4, r0
c0d02ad0:	2021      	movs	r0, #33	; 0x21
c0d02ad2:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02ad4:	19a5      	adds	r5, r4, r6
c0d02ad6:	4628      	mov	r0, r5
c0d02ad8:	f000 fb69 	bl	c0d031ae <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02adc:	20f4      	movs	r0, #244	; 0xf4
c0d02ade:	2101      	movs	r1, #1
c0d02ae0:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02ae2:	2087      	movs	r0, #135	; 0x87
c0d02ae4:	0040      	lsls	r0, r0, #1
c0d02ae6:	5a20      	ldrh	r0, [r4, r0]
c0d02ae8:	21f8      	movs	r1, #248	; 0xf8
c0d02aea:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02aec:	5da1      	ldrb	r1, [r4, r6]
c0d02aee:	201f      	movs	r0, #31
c0d02af0:	4008      	ands	r0, r1
c0d02af2:	2802      	cmp	r0, #2
c0d02af4:	d008      	beq.n	c0d02b08 <USBD_LL_SetupStage+0x40>
c0d02af6:	2801      	cmp	r0, #1
c0d02af8:	d00b      	beq.n	c0d02b12 <USBD_LL_SetupStage+0x4a>
c0d02afa:	2800      	cmp	r0, #0
c0d02afc:	d10e      	bne.n	c0d02b1c <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02afe:	4620      	mov	r0, r4
c0d02b00:	4629      	mov	r1, r5
c0d02b02:	f000 f8f1 	bl	c0d02ce8 <USBD_StdDevReq>
c0d02b06:	e00e      	b.n	c0d02b26 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02b08:	4620      	mov	r0, r4
c0d02b0a:	4629      	mov	r1, r5
c0d02b0c:	f000 fad3 	bl	c0d030b6 <USBD_StdEPReq>
c0d02b10:	e009      	b.n	c0d02b26 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02b12:	4620      	mov	r0, r4
c0d02b14:	4629      	mov	r1, r5
c0d02b16:	f000 faa6 	bl	c0d03066 <USBD_StdItfReq>
c0d02b1a:	e004      	b.n	c0d02b26 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02b1c:	2080      	movs	r0, #128	; 0x80
c0d02b1e:	4001      	ands	r1, r0
c0d02b20:	4620      	mov	r0, r4
c0d02b22:	f7ff fec1 	bl	c0d028a8 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02b26:	2000      	movs	r0, #0
c0d02b28:	b001      	add	sp, #4
c0d02b2a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b2c <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02b2c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b2e:	af03      	add	r7, sp, #12
c0d02b30:	b081      	sub	sp, #4
c0d02b32:	4615      	mov	r5, r2
c0d02b34:	460e      	mov	r6, r1
c0d02b36:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02b38:	2e00      	cmp	r6, #0
c0d02b3a:	d011      	beq.n	c0d02b60 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b3c:	2045      	movs	r0, #69	; 0x45
c0d02b3e:	0080      	lsls	r0, r0, #2
c0d02b40:	5820      	ldr	r0, [r4, r0]
c0d02b42:	6980      	ldr	r0, [r0, #24]
c0d02b44:	2800      	cmp	r0, #0
c0d02b46:	d034      	beq.n	c0d02bb2 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b48:	21fc      	movs	r1, #252	; 0xfc
c0d02b4a:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b4c:	2903      	cmp	r1, #3
c0d02b4e:	d130      	bne.n	c0d02bb2 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02b50:	f7ff fa94 	bl	c0d0207c <pic>
c0d02b54:	4603      	mov	r3, r0
c0d02b56:	4620      	mov	r0, r4
c0d02b58:	4631      	mov	r1, r6
c0d02b5a:	462a      	mov	r2, r5
c0d02b5c:	4798      	blx	r3
c0d02b5e:	e028      	b.n	c0d02bb2 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02b60:	20f4      	movs	r0, #244	; 0xf4
c0d02b62:	5820      	ldr	r0, [r4, r0]
c0d02b64:	2803      	cmp	r0, #3
c0d02b66:	d124      	bne.n	c0d02bb2 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02b68:	2090      	movs	r0, #144	; 0x90
c0d02b6a:	5820      	ldr	r0, [r4, r0]
c0d02b6c:	218c      	movs	r1, #140	; 0x8c
c0d02b6e:	5861      	ldr	r1, [r4, r1]
c0d02b70:	4622      	mov	r2, r4
c0d02b72:	328c      	adds	r2, #140	; 0x8c
c0d02b74:	4281      	cmp	r1, r0
c0d02b76:	d90a      	bls.n	c0d02b8e <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02b78:	1a09      	subs	r1, r1, r0
c0d02b7a:	6011      	str	r1, [r2, #0]
c0d02b7c:	4281      	cmp	r1, r0
c0d02b7e:	d300      	bcc.n	c0d02b82 <USBD_LL_DataOutStage+0x56>
c0d02b80:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02b82:	b28a      	uxth	r2, r1
c0d02b84:	4620      	mov	r0, r4
c0d02b86:	4629      	mov	r1, r5
c0d02b88:	f000 fc70 	bl	c0d0346c <USBD_CtlContinueRx>
c0d02b8c:	e011      	b.n	c0d02bb2 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02b8e:	2045      	movs	r0, #69	; 0x45
c0d02b90:	0080      	lsls	r0, r0, #2
c0d02b92:	5820      	ldr	r0, [r4, r0]
c0d02b94:	6900      	ldr	r0, [r0, #16]
c0d02b96:	2800      	cmp	r0, #0
c0d02b98:	d008      	beq.n	c0d02bac <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b9a:	21fc      	movs	r1, #252	; 0xfc
c0d02b9c:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02b9e:	2903      	cmp	r1, #3
c0d02ba0:	d104      	bne.n	c0d02bac <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02ba2:	f7ff fa6b 	bl	c0d0207c <pic>
c0d02ba6:	4601      	mov	r1, r0
c0d02ba8:	4620      	mov	r0, r4
c0d02baa:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02bac:	4620      	mov	r0, r4
c0d02bae:	f000 fc65 	bl	c0d0347c <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02bb2:	2000      	movs	r0, #0
c0d02bb4:	b001      	add	sp, #4
c0d02bb6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02bb8 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02bb8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02bba:	af03      	add	r7, sp, #12
c0d02bbc:	b081      	sub	sp, #4
c0d02bbe:	460d      	mov	r5, r1
c0d02bc0:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02bc2:	2d00      	cmp	r5, #0
c0d02bc4:	d012      	beq.n	c0d02bec <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02bc6:	2045      	movs	r0, #69	; 0x45
c0d02bc8:	0080      	lsls	r0, r0, #2
c0d02bca:	5820      	ldr	r0, [r4, r0]
c0d02bcc:	2800      	cmp	r0, #0
c0d02bce:	d054      	beq.n	c0d02c7a <USBD_LL_DataInStage+0xc2>
c0d02bd0:	6940      	ldr	r0, [r0, #20]
c0d02bd2:	2800      	cmp	r0, #0
c0d02bd4:	d051      	beq.n	c0d02c7a <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02bd6:	21fc      	movs	r1, #252	; 0xfc
c0d02bd8:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02bda:	2903      	cmp	r1, #3
c0d02bdc:	d14d      	bne.n	c0d02c7a <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02bde:	f7ff fa4d 	bl	c0d0207c <pic>
c0d02be2:	4602      	mov	r2, r0
c0d02be4:	4620      	mov	r0, r4
c0d02be6:	4629      	mov	r1, r5
c0d02be8:	4790      	blx	r2
c0d02bea:	e046      	b.n	c0d02c7a <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02bec:	20f4      	movs	r0, #244	; 0xf4
c0d02bee:	5820      	ldr	r0, [r4, r0]
c0d02bf0:	2802      	cmp	r0, #2
c0d02bf2:	d13a      	bne.n	c0d02c6a <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02bf4:	69e0      	ldr	r0, [r4, #28]
c0d02bf6:	6a25      	ldr	r5, [r4, #32]
c0d02bf8:	42a8      	cmp	r0, r5
c0d02bfa:	d90b      	bls.n	c0d02c14 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02bfc:	1b40      	subs	r0, r0, r5
c0d02bfe:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02c00:	2109      	movs	r1, #9
c0d02c02:	014a      	lsls	r2, r1, #5
c0d02c04:	58a1      	ldr	r1, [r4, r2]
c0d02c06:	1949      	adds	r1, r1, r5
c0d02c08:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02c0a:	b282      	uxth	r2, r0
c0d02c0c:	4620      	mov	r0, r4
c0d02c0e:	f000 fc1e 	bl	c0d0344e <USBD_CtlContinueSendData>
c0d02c12:	e02a      	b.n	c0d02c6a <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02c14:	69a6      	ldr	r6, [r4, #24]
c0d02c16:	4630      	mov	r0, r6
c0d02c18:	4629      	mov	r1, r5
c0d02c1a:	f000 fccf 	bl	c0d035bc <__aeabi_uidivmod>
c0d02c1e:	42ae      	cmp	r6, r5
c0d02c20:	d30f      	bcc.n	c0d02c42 <USBD_LL_DataInStage+0x8a>
c0d02c22:	2900      	cmp	r1, #0
c0d02c24:	d10d      	bne.n	c0d02c42 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02c26:	20f8      	movs	r0, #248	; 0xf8
c0d02c28:	5820      	ldr	r0, [r4, r0]
c0d02c2a:	4625      	mov	r5, r4
c0d02c2c:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02c2e:	4286      	cmp	r6, r0
c0d02c30:	d207      	bcs.n	c0d02c42 <USBD_LL_DataInStage+0x8a>
c0d02c32:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02c34:	4620      	mov	r0, r4
c0d02c36:	4631      	mov	r1, r6
c0d02c38:	4632      	mov	r2, r6
c0d02c3a:	f000 fc08 	bl	c0d0344e <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02c3e:	602e      	str	r6, [r5, #0]
c0d02c40:	e013      	b.n	c0d02c6a <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02c42:	2045      	movs	r0, #69	; 0x45
c0d02c44:	0080      	lsls	r0, r0, #2
c0d02c46:	5820      	ldr	r0, [r4, r0]
c0d02c48:	2800      	cmp	r0, #0
c0d02c4a:	d00b      	beq.n	c0d02c64 <USBD_LL_DataInStage+0xac>
c0d02c4c:	68c0      	ldr	r0, [r0, #12]
c0d02c4e:	2800      	cmp	r0, #0
c0d02c50:	d008      	beq.n	c0d02c64 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c52:	21fc      	movs	r1, #252	; 0xfc
c0d02c54:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02c56:	2903      	cmp	r1, #3
c0d02c58:	d104      	bne.n	c0d02c64 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02c5a:	f7ff fa0f 	bl	c0d0207c <pic>
c0d02c5e:	4601      	mov	r1, r0
c0d02c60:	4620      	mov	r0, r4
c0d02c62:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02c64:	4620      	mov	r0, r4
c0d02c66:	f000 fc16 	bl	c0d03496 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02c6a:	2001      	movs	r0, #1
c0d02c6c:	0201      	lsls	r1, r0, #8
c0d02c6e:	1860      	adds	r0, r4, r1
c0d02c70:	5c61      	ldrb	r1, [r4, r1]
c0d02c72:	2901      	cmp	r1, #1
c0d02c74:	d101      	bne.n	c0d02c7a <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02c76:	2100      	movs	r1, #0
c0d02c78:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02c7a:	2000      	movs	r0, #0
c0d02c7c:	b001      	add	sp, #4
c0d02c7e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c80 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02c80:	b5d0      	push	{r4, r6, r7, lr}
c0d02c82:	af02      	add	r7, sp, #8
c0d02c84:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02c86:	2090      	movs	r0, #144	; 0x90
c0d02c88:	2140      	movs	r1, #64	; 0x40
c0d02c8a:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02c8c:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02c8e:	20fc      	movs	r0, #252	; 0xfc
c0d02c90:	2101      	movs	r1, #1
c0d02c92:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02c94:	2045      	movs	r0, #69	; 0x45
c0d02c96:	0080      	lsls	r0, r0, #2
c0d02c98:	5820      	ldr	r0, [r4, r0]
c0d02c9a:	2800      	cmp	r0, #0
c0d02c9c:	d006      	beq.n	c0d02cac <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02c9e:	6840      	ldr	r0, [r0, #4]
c0d02ca0:	f7ff f9ec 	bl	c0d0207c <pic>
c0d02ca4:	4602      	mov	r2, r0
c0d02ca6:	7921      	ldrb	r1, [r4, #4]
c0d02ca8:	4620      	mov	r0, r4
c0d02caa:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02cac:	2000      	movs	r0, #0
c0d02cae:	bdd0      	pop	{r4, r6, r7, pc}

c0d02cb0 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02cb0:	7401      	strb	r1, [r0, #16]
c0d02cb2:	2000      	movs	r0, #0
  return USBD_OK;
c0d02cb4:	4770      	bx	lr

c0d02cb6 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02cb6:	2000      	movs	r0, #0
c0d02cb8:	4770      	bx	lr

c0d02cba <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02cba:	2000      	movs	r0, #0
c0d02cbc:	4770      	bx	lr

c0d02cbe <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02cbe:	b5d0      	push	{r4, r6, r7, lr}
c0d02cc0:	af02      	add	r7, sp, #8
c0d02cc2:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02cc4:	20fc      	movs	r0, #252	; 0xfc
c0d02cc6:	5c20      	ldrb	r0, [r4, r0]
c0d02cc8:	2803      	cmp	r0, #3
c0d02cca:	d10a      	bne.n	c0d02ce2 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02ccc:	2045      	movs	r0, #69	; 0x45
c0d02cce:	0080      	lsls	r0, r0, #2
c0d02cd0:	5820      	ldr	r0, [r4, r0]
c0d02cd2:	69c0      	ldr	r0, [r0, #28]
c0d02cd4:	2800      	cmp	r0, #0
c0d02cd6:	d004      	beq.n	c0d02ce2 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02cd8:	f7ff f9d0 	bl	c0d0207c <pic>
c0d02cdc:	4601      	mov	r1, r0
c0d02cde:	4620      	mov	r0, r4
c0d02ce0:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02ce2:	2000      	movs	r0, #0
c0d02ce4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02ce8 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02ce8:	b5d0      	push	{r4, r6, r7, lr}
c0d02cea:	af02      	add	r7, sp, #8
c0d02cec:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02cee:	7848      	ldrb	r0, [r1, #1]
c0d02cf0:	2809      	cmp	r0, #9
c0d02cf2:	d810      	bhi.n	c0d02d16 <USBD_StdDevReq+0x2e>
c0d02cf4:	4478      	add	r0, pc
c0d02cf6:	7900      	ldrb	r0, [r0, #4]
c0d02cf8:	0040      	lsls	r0, r0, #1
c0d02cfa:	4487      	add	pc, r0
c0d02cfc:	150c0804 	.word	0x150c0804
c0d02d00:	0c25190c 	.word	0x0c25190c
c0d02d04:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02d06:	4620      	mov	r0, r4
c0d02d08:	f000 f938 	bl	c0d02f7c <USBD_GetStatus>
c0d02d0c:	e01f      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02d0e:	4620      	mov	r0, r4
c0d02d10:	f000 f976 	bl	c0d03000 <USBD_ClrFeature>
c0d02d14:	e01b      	b.n	c0d02d4e <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d16:	2180      	movs	r1, #128	; 0x80
c0d02d18:	4620      	mov	r0, r4
c0d02d1a:	f7ff fdc5 	bl	c0d028a8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02d1e:	2100      	movs	r1, #0
c0d02d20:	4620      	mov	r0, r4
c0d02d22:	f7ff fdc1 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02d26:	e012      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02d28:	4620      	mov	r0, r4
c0d02d2a:	f000 f950 	bl	c0d02fce <USBD_SetFeature>
c0d02d2e:	e00e      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02d30:	4620      	mov	r0, r4
c0d02d32:	f000 f897 	bl	c0d02e64 <USBD_SetAddress>
c0d02d36:	e00a      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02d38:	4620      	mov	r0, r4
c0d02d3a:	f000 f8ff 	bl	c0d02f3c <USBD_GetConfig>
c0d02d3e:	e006      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02d40:	4620      	mov	r0, r4
c0d02d42:	f000 f8bd 	bl	c0d02ec0 <USBD_SetConfig>
c0d02d46:	e002      	b.n	c0d02d4e <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02d48:	4620      	mov	r0, r4
c0d02d4a:	f000 f803 	bl	c0d02d54 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02d4e:	2000      	movs	r0, #0
c0d02d50:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d54 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02d54:	b5b0      	push	{r4, r5, r7, lr}
c0d02d56:	af02      	add	r7, sp, #8
c0d02d58:	b082      	sub	sp, #8
c0d02d5a:	460d      	mov	r5, r1
c0d02d5c:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02d5e:	8868      	ldrh	r0, [r5, #2]
c0d02d60:	0a01      	lsrs	r1, r0, #8
c0d02d62:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d64:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02d66:	2a0e      	cmp	r2, #14
c0d02d68:	d83e      	bhi.n	c0d02de8 <USBD_GetDescriptor+0x94>
c0d02d6a:	46c0      	nop			; (mov r8, r8)
c0d02d6c:	447a      	add	r2, pc
c0d02d6e:	7912      	ldrb	r2, [r2, #4]
c0d02d70:	0052      	lsls	r2, r2, #1
c0d02d72:	4497      	add	pc, r2
c0d02d74:	390c2607 	.word	0x390c2607
c0d02d78:	39362e39 	.word	0x39362e39
c0d02d7c:	39393939 	.word	0x39393939
c0d02d80:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02d84:	2011      	movs	r0, #17
c0d02d86:	0100      	lsls	r0, r0, #4
c0d02d88:	5820      	ldr	r0, [r4, r0]
c0d02d8a:	6800      	ldr	r0, [r0, #0]
c0d02d8c:	e012      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02d8e:	b2c0      	uxtb	r0, r0
c0d02d90:	2805      	cmp	r0, #5
c0d02d92:	d829      	bhi.n	c0d02de8 <USBD_GetDescriptor+0x94>
c0d02d94:	4478      	add	r0, pc
c0d02d96:	7900      	ldrb	r0, [r0, #4]
c0d02d98:	0040      	lsls	r0, r0, #1
c0d02d9a:	4487      	add	pc, r0
c0d02d9c:	544f4a02 	.word	0x544f4a02
c0d02da0:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02da2:	2011      	movs	r0, #17
c0d02da4:	0100      	lsls	r0, r0, #4
c0d02da6:	5820      	ldr	r0, [r4, r0]
c0d02da8:	6840      	ldr	r0, [r0, #4]
c0d02daa:	e003      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02dac:	2011      	movs	r0, #17
c0d02dae:	0100      	lsls	r0, r0, #4
c0d02db0:	5820      	ldr	r0, [r4, r0]
c0d02db2:	69c0      	ldr	r0, [r0, #28]
c0d02db4:	f7ff f962 	bl	c0d0207c <pic>
c0d02db8:	4602      	mov	r2, r0
c0d02dba:	7c20      	ldrb	r0, [r4, #16]
c0d02dbc:	a901      	add	r1, sp, #4
c0d02dbe:	4790      	blx	r2
c0d02dc0:	e025      	b.n	c0d02e0e <USBD_GetDescriptor+0xba>
c0d02dc2:	2045      	movs	r0, #69	; 0x45
c0d02dc4:	0080      	lsls	r0, r0, #2
c0d02dc6:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02dc8:	7c21      	ldrb	r1, [r4, #16]
c0d02dca:	2900      	cmp	r1, #0
c0d02dcc:	d014      	beq.n	c0d02df8 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02dce:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02dd0:	e018      	b.n	c0d02e04 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02dd2:	7c20      	ldrb	r0, [r4, #16]
c0d02dd4:	2800      	cmp	r0, #0
c0d02dd6:	d107      	bne.n	c0d02de8 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02dd8:	2045      	movs	r0, #69	; 0x45
c0d02dda:	0080      	lsls	r0, r0, #2
c0d02ddc:	5820      	ldr	r0, [r4, r0]
c0d02dde:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02de0:	e010      	b.n	c0d02e04 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02de2:	7c20      	ldrb	r0, [r4, #16]
c0d02de4:	2800      	cmp	r0, #0
c0d02de6:	d009      	beq.n	c0d02dfc <USBD_GetDescriptor+0xa8>
c0d02de8:	4620      	mov	r0, r4
c0d02dea:	f7ff fd5d 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02dee:	2100      	movs	r1, #0
c0d02df0:	4620      	mov	r0, r4
c0d02df2:	f7ff fd59 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02df6:	e01a      	b.n	c0d02e2e <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02df8:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02dfa:	e003      	b.n	c0d02e04 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02dfc:	2045      	movs	r0, #69	; 0x45
c0d02dfe:	0080      	lsls	r0, r0, #2
c0d02e00:	5820      	ldr	r0, [r4, r0]
c0d02e02:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02e04:	f7ff f93a 	bl	c0d0207c <pic>
c0d02e08:	4601      	mov	r1, r0
c0d02e0a:	a801      	add	r0, sp, #4
c0d02e0c:	4788      	blx	r1
c0d02e0e:	4601      	mov	r1, r0
c0d02e10:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02e12:	8802      	ldrh	r2, [r0, #0]
c0d02e14:	2a00      	cmp	r2, #0
c0d02e16:	d00a      	beq.n	c0d02e2e <USBD_GetDescriptor+0xda>
c0d02e18:	88e8      	ldrh	r0, [r5, #6]
c0d02e1a:	2800      	cmp	r0, #0
c0d02e1c:	d007      	beq.n	c0d02e2e <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02e1e:	4282      	cmp	r2, r0
c0d02e20:	d300      	bcc.n	c0d02e24 <USBD_GetDescriptor+0xd0>
c0d02e22:	4602      	mov	r2, r0
c0d02e24:	a801      	add	r0, sp, #4
c0d02e26:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02e28:	4620      	mov	r0, r4
c0d02e2a:	f000 faf9 	bl	c0d03420 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02e2e:	b002      	add	sp, #8
c0d02e30:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02e32:	2011      	movs	r0, #17
c0d02e34:	0100      	lsls	r0, r0, #4
c0d02e36:	5820      	ldr	r0, [r4, r0]
c0d02e38:	6880      	ldr	r0, [r0, #8]
c0d02e3a:	e7bb      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02e3c:	2011      	movs	r0, #17
c0d02e3e:	0100      	lsls	r0, r0, #4
c0d02e40:	5820      	ldr	r0, [r4, r0]
c0d02e42:	68c0      	ldr	r0, [r0, #12]
c0d02e44:	e7b6      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02e46:	2011      	movs	r0, #17
c0d02e48:	0100      	lsls	r0, r0, #4
c0d02e4a:	5820      	ldr	r0, [r4, r0]
c0d02e4c:	6900      	ldr	r0, [r0, #16]
c0d02e4e:	e7b1      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02e50:	2011      	movs	r0, #17
c0d02e52:	0100      	lsls	r0, r0, #4
c0d02e54:	5820      	ldr	r0, [r4, r0]
c0d02e56:	6940      	ldr	r0, [r0, #20]
c0d02e58:	e7ac      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02e5a:	2011      	movs	r0, #17
c0d02e5c:	0100      	lsls	r0, r0, #4
c0d02e5e:	5820      	ldr	r0, [r4, r0]
c0d02e60:	6980      	ldr	r0, [r0, #24]
c0d02e62:	e7a7      	b.n	c0d02db4 <USBD_GetDescriptor+0x60>

c0d02e64 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e64:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e66:	af03      	add	r7, sp, #12
c0d02e68:	b081      	sub	sp, #4
c0d02e6a:	460a      	mov	r2, r1
c0d02e6c:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02e6e:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e70:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02e72:	2800      	cmp	r0, #0
c0d02e74:	d10b      	bne.n	c0d02e8e <USBD_SetAddress+0x2a>
c0d02e76:	88d0      	ldrh	r0, [r2, #6]
c0d02e78:	2800      	cmp	r0, #0
c0d02e7a:	d108      	bne.n	c0d02e8e <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02e7c:	8850      	ldrh	r0, [r2, #2]
c0d02e7e:	267f      	movs	r6, #127	; 0x7f
c0d02e80:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02e82:	20fc      	movs	r0, #252	; 0xfc
c0d02e84:	5c20      	ldrb	r0, [r4, r0]
c0d02e86:	4625      	mov	r5, r4
c0d02e88:	35fc      	adds	r5, #252	; 0xfc
c0d02e8a:	2803      	cmp	r0, #3
c0d02e8c:	d108      	bne.n	c0d02ea0 <USBD_SetAddress+0x3c>
c0d02e8e:	4620      	mov	r0, r4
c0d02e90:	f7ff fd0a 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02e94:	2100      	movs	r1, #0
c0d02e96:	4620      	mov	r0, r4
c0d02e98:	f7ff fd06 	bl	c0d028a8 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02e9c:	b001      	add	sp, #4
c0d02e9e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02ea0:	20fe      	movs	r0, #254	; 0xfe
c0d02ea2:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02ea4:	b2f1      	uxtb	r1, r6
c0d02ea6:	4620      	mov	r0, r4
c0d02ea8:	f7ff fd5c 	bl	c0d02964 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02eac:	4620      	mov	r0, r4
c0d02eae:	f000 fae5 	bl	c0d0347c <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02eb2:	2002      	movs	r0, #2
c0d02eb4:	2101      	movs	r1, #1
c0d02eb6:	2e00      	cmp	r6, #0
c0d02eb8:	d100      	bne.n	c0d02ebc <USBD_SetAddress+0x58>
c0d02eba:	4608      	mov	r0, r1
c0d02ebc:	7028      	strb	r0, [r5, #0]
c0d02ebe:	e7ed      	b.n	c0d02e9c <USBD_SetAddress+0x38>

c0d02ec0 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02ec0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ec2:	af03      	add	r7, sp, #12
c0d02ec4:	b081      	sub	sp, #4
c0d02ec6:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02ec8:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02eca:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02ecc:	2e02      	cmp	r6, #2
c0d02ece:	d21d      	bcs.n	c0d02f0c <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02ed0:	20fc      	movs	r0, #252	; 0xfc
c0d02ed2:	5c21      	ldrb	r1, [r4, r0]
c0d02ed4:	4620      	mov	r0, r4
c0d02ed6:	30fc      	adds	r0, #252	; 0xfc
c0d02ed8:	2903      	cmp	r1, #3
c0d02eda:	d007      	beq.n	c0d02eec <USBD_SetConfig+0x2c>
c0d02edc:	2902      	cmp	r1, #2
c0d02ede:	d115      	bne.n	c0d02f0c <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02ee0:	2e00      	cmp	r6, #0
c0d02ee2:	d026      	beq.n	c0d02f32 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02ee4:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02ee6:	2103      	movs	r1, #3
c0d02ee8:	7001      	strb	r1, [r0, #0]
c0d02eea:	e009      	b.n	c0d02f00 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02eec:	2e00      	cmp	r6, #0
c0d02eee:	d016      	beq.n	c0d02f1e <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02ef0:	6860      	ldr	r0, [r4, #4]
c0d02ef2:	4286      	cmp	r6, r0
c0d02ef4:	d01d      	beq.n	c0d02f32 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02ef6:	b2c1      	uxtb	r1, r0
c0d02ef8:	4620      	mov	r0, r4
c0d02efa:	f7ff fdd3 	bl	c0d02aa4 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02efe:	6066      	str	r6, [r4, #4]
c0d02f00:	4620      	mov	r0, r4
c0d02f02:	4631      	mov	r1, r6
c0d02f04:	f7ff fdb6 	bl	c0d02a74 <USBD_SetClassConfig>
c0d02f08:	2802      	cmp	r0, #2
c0d02f0a:	d112      	bne.n	c0d02f32 <USBD_SetConfig+0x72>
c0d02f0c:	4620      	mov	r0, r4
c0d02f0e:	4629      	mov	r1, r5
c0d02f10:	f7ff fcca 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02f14:	2100      	movs	r1, #0
c0d02f16:	4620      	mov	r0, r4
c0d02f18:	f7ff fcc6 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02f1c:	e00c      	b.n	c0d02f38 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02f1e:	2102      	movs	r1, #2
c0d02f20:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02f22:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02f24:	4620      	mov	r0, r4
c0d02f26:	4631      	mov	r1, r6
c0d02f28:	f7ff fdbc 	bl	c0d02aa4 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02f2c:	4620      	mov	r0, r4
c0d02f2e:	f000 faa5 	bl	c0d0347c <USBD_CtlSendStatus>
c0d02f32:	4620      	mov	r0, r4
c0d02f34:	f000 faa2 	bl	c0d0347c <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02f38:	b001      	add	sp, #4
c0d02f3a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f3c <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f3c:	b5d0      	push	{r4, r6, r7, lr}
c0d02f3e:	af02      	add	r7, sp, #8
c0d02f40:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02f42:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f44:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02f46:	2801      	cmp	r0, #1
c0d02f48:	d10a      	bne.n	c0d02f60 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02f4a:	20fc      	movs	r0, #252	; 0xfc
c0d02f4c:	5c20      	ldrb	r0, [r4, r0]
c0d02f4e:	2803      	cmp	r0, #3
c0d02f50:	d00e      	beq.n	c0d02f70 <USBD_GetConfig+0x34>
c0d02f52:	2802      	cmp	r0, #2
c0d02f54:	d104      	bne.n	c0d02f60 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02f56:	2000      	movs	r0, #0
c0d02f58:	60a0      	str	r0, [r4, #8]
c0d02f5a:	4621      	mov	r1, r4
c0d02f5c:	3108      	adds	r1, #8
c0d02f5e:	e008      	b.n	c0d02f72 <USBD_GetConfig+0x36>
c0d02f60:	4620      	mov	r0, r4
c0d02f62:	f7ff fca1 	bl	c0d028a8 <USBD_LL_StallEP>
c0d02f66:	2100      	movs	r1, #0
c0d02f68:	4620      	mov	r0, r4
c0d02f6a:	f7ff fc9d 	bl	c0d028a8 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02f6e:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02f70:	1d21      	adds	r1, r4, #4
c0d02f72:	2201      	movs	r2, #1
c0d02f74:	4620      	mov	r0, r4
c0d02f76:	f000 fa53 	bl	c0d03420 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02f7a:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f7c <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f7c:	b5b0      	push	{r4, r5, r7, lr}
c0d02f7e:	af02      	add	r7, sp, #8
c0d02f80:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02f82:	20fc      	movs	r0, #252	; 0xfc
c0d02f84:	5c20      	ldrb	r0, [r4, r0]
c0d02f86:	21fe      	movs	r1, #254	; 0xfe
c0d02f88:	4001      	ands	r1, r0
c0d02f8a:	2902      	cmp	r1, #2
c0d02f8c:	d116      	bne.n	c0d02fbc <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02f8e:	2001      	movs	r0, #1
c0d02f90:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02f92:	2041      	movs	r0, #65	; 0x41
c0d02f94:	0080      	lsls	r0, r0, #2
c0d02f96:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02f98:	4625      	mov	r5, r4
c0d02f9a:	350c      	adds	r5, #12
c0d02f9c:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02f9e:	2900      	cmp	r1, #0
c0d02fa0:	d005      	beq.n	c0d02fae <USBD_GetStatus+0x32>
c0d02fa2:	4620      	mov	r0, r4
c0d02fa4:	f000 fa77 	bl	c0d03496 <USBD_CtlReceiveStatus>
c0d02fa8:	68e1      	ldr	r1, [r4, #12]
c0d02faa:	2002      	movs	r0, #2
c0d02fac:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02fae:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02fb0:	2202      	movs	r2, #2
c0d02fb2:	4620      	mov	r0, r4
c0d02fb4:	4629      	mov	r1, r5
c0d02fb6:	f000 fa33 	bl	c0d03420 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02fba:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02fbc:	2180      	movs	r1, #128	; 0x80
c0d02fbe:	4620      	mov	r0, r4
c0d02fc0:	f7ff fc72 	bl	c0d028a8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02fc4:	2100      	movs	r1, #0
c0d02fc6:	4620      	mov	r0, r4
c0d02fc8:	f7ff fc6e 	bl	c0d028a8 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02fcc:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fce <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02fce:	b5b0      	push	{r4, r5, r7, lr}
c0d02fd0:	af02      	add	r7, sp, #8
c0d02fd2:	460d      	mov	r5, r1
c0d02fd4:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02fd6:	8868      	ldrh	r0, [r5, #2]
c0d02fd8:	2801      	cmp	r0, #1
c0d02fda:	d110      	bne.n	c0d02ffe <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02fdc:	2041      	movs	r0, #65	; 0x41
c0d02fde:	0080      	lsls	r0, r0, #2
c0d02fe0:	2101      	movs	r1, #1
c0d02fe2:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02fe4:	2045      	movs	r0, #69	; 0x45
c0d02fe6:	0080      	lsls	r0, r0, #2
c0d02fe8:	5820      	ldr	r0, [r4, r0]
c0d02fea:	6880      	ldr	r0, [r0, #8]
c0d02fec:	f7ff f846 	bl	c0d0207c <pic>
c0d02ff0:	4602      	mov	r2, r0
c0d02ff2:	4620      	mov	r0, r4
c0d02ff4:	4629      	mov	r1, r5
c0d02ff6:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02ff8:	4620      	mov	r0, r4
c0d02ffa:	f000 fa3f 	bl	c0d0347c <USBD_CtlSendStatus>
  }

}
c0d02ffe:	bdb0      	pop	{r4, r5, r7, pc}

c0d03000 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d03000:	b5b0      	push	{r4, r5, r7, lr}
c0d03002:	af02      	add	r7, sp, #8
c0d03004:	460d      	mov	r5, r1
c0d03006:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d03008:	20fc      	movs	r0, #252	; 0xfc
c0d0300a:	5c20      	ldrb	r0, [r4, r0]
c0d0300c:	21fe      	movs	r1, #254	; 0xfe
c0d0300e:	4001      	ands	r1, r0
c0d03010:	2902      	cmp	r1, #2
c0d03012:	d114      	bne.n	c0d0303e <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d03014:	8868      	ldrh	r0, [r5, #2]
c0d03016:	2801      	cmp	r0, #1
c0d03018:	d119      	bne.n	c0d0304e <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d0301a:	2041      	movs	r0, #65	; 0x41
c0d0301c:	0080      	lsls	r0, r0, #2
c0d0301e:	2100      	movs	r1, #0
c0d03020:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d03022:	2045      	movs	r0, #69	; 0x45
c0d03024:	0080      	lsls	r0, r0, #2
c0d03026:	5820      	ldr	r0, [r4, r0]
c0d03028:	6880      	ldr	r0, [r0, #8]
c0d0302a:	f7ff f827 	bl	c0d0207c <pic>
c0d0302e:	4602      	mov	r2, r0
c0d03030:	4620      	mov	r0, r4
c0d03032:	4629      	mov	r1, r5
c0d03034:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d03036:	4620      	mov	r0, r4
c0d03038:	f000 fa20 	bl	c0d0347c <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d0303c:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0303e:	2180      	movs	r1, #128	; 0x80
c0d03040:	4620      	mov	r0, r4
c0d03042:	f7ff fc31 	bl	c0d028a8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03046:	2100      	movs	r1, #0
c0d03048:	4620      	mov	r0, r4
c0d0304a:	f7ff fc2d 	bl	c0d028a8 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d0304e:	bdb0      	pop	{r4, r5, r7, pc}

c0d03050 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d03050:	b5d0      	push	{r4, r6, r7, lr}
c0d03052:	af02      	add	r7, sp, #8
c0d03054:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03056:	2180      	movs	r1, #128	; 0x80
c0d03058:	f7ff fc26 	bl	c0d028a8 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0305c:	2100      	movs	r1, #0
c0d0305e:	4620      	mov	r0, r4
c0d03060:	f7ff fc22 	bl	c0d028a8 <USBD_LL_StallEP>
}
c0d03064:	bdd0      	pop	{r4, r6, r7, pc}

c0d03066 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03066:	b5b0      	push	{r4, r5, r7, lr}
c0d03068:	af02      	add	r7, sp, #8
c0d0306a:	460d      	mov	r5, r1
c0d0306c:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0306e:	20fc      	movs	r0, #252	; 0xfc
c0d03070:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03072:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d03074:	2803      	cmp	r0, #3
c0d03076:	d115      	bne.n	c0d030a4 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d03078:	88a8      	ldrh	r0, [r5, #4]
c0d0307a:	22fe      	movs	r2, #254	; 0xfe
c0d0307c:	4002      	ands	r2, r0
c0d0307e:	2a01      	cmp	r2, #1
c0d03080:	d810      	bhi.n	c0d030a4 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d03082:	2045      	movs	r0, #69	; 0x45
c0d03084:	0080      	lsls	r0, r0, #2
c0d03086:	5820      	ldr	r0, [r4, r0]
c0d03088:	6880      	ldr	r0, [r0, #8]
c0d0308a:	f7fe fff7 	bl	c0d0207c <pic>
c0d0308e:	4602      	mov	r2, r0
c0d03090:	4620      	mov	r0, r4
c0d03092:	4629      	mov	r1, r5
c0d03094:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d03096:	88e8      	ldrh	r0, [r5, #6]
c0d03098:	2800      	cmp	r0, #0
c0d0309a:	d10a      	bne.n	c0d030b2 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d0309c:	4620      	mov	r0, r4
c0d0309e:	f000 f9ed 	bl	c0d0347c <USBD_CtlSendStatus>
c0d030a2:	e006      	b.n	c0d030b2 <USBD_StdItfReq+0x4c>
c0d030a4:	4620      	mov	r0, r4
c0d030a6:	f7ff fbff 	bl	c0d028a8 <USBD_LL_StallEP>
c0d030aa:	2100      	movs	r1, #0
c0d030ac:	4620      	mov	r0, r4
c0d030ae:	f7ff fbfb 	bl	c0d028a8 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d030b2:	2000      	movs	r0, #0
c0d030b4:	bdb0      	pop	{r4, r5, r7, pc}

c0d030b6 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d030b6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d030b8:	af03      	add	r7, sp, #12
c0d030ba:	b081      	sub	sp, #4
c0d030bc:	460e      	mov	r6, r1
c0d030be:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d030c0:	7830      	ldrb	r0, [r6, #0]
c0d030c2:	2160      	movs	r1, #96	; 0x60
c0d030c4:	4001      	ands	r1, r0
c0d030c6:	2920      	cmp	r1, #32
c0d030c8:	d10a      	bne.n	c0d030e0 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d030ca:	2045      	movs	r0, #69	; 0x45
c0d030cc:	0080      	lsls	r0, r0, #2
c0d030ce:	5820      	ldr	r0, [r4, r0]
c0d030d0:	6880      	ldr	r0, [r0, #8]
c0d030d2:	f7fe ffd3 	bl	c0d0207c <pic>
c0d030d6:	4602      	mov	r2, r0
c0d030d8:	4620      	mov	r0, r4
c0d030da:	4631      	mov	r1, r6
c0d030dc:	4790      	blx	r2
c0d030de:	e063      	b.n	c0d031a8 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d030e0:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d030e2:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030e4:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d030e6:	2800      	cmp	r0, #0
c0d030e8:	d012      	beq.n	c0d03110 <USBD_StdEPReq+0x5a>
c0d030ea:	2801      	cmp	r0, #1
c0d030ec:	d019      	beq.n	c0d03122 <USBD_StdEPReq+0x6c>
c0d030ee:	2803      	cmp	r0, #3
c0d030f0:	d15a      	bne.n	c0d031a8 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d030f2:	20fc      	movs	r0, #252	; 0xfc
c0d030f4:	5c20      	ldrb	r0, [r4, r0]
c0d030f6:	2803      	cmp	r0, #3
c0d030f8:	d117      	bne.n	c0d0312a <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d030fa:	8870      	ldrh	r0, [r6, #2]
c0d030fc:	2800      	cmp	r0, #0
c0d030fe:	d12d      	bne.n	c0d0315c <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d03100:	4329      	orrs	r1, r5
c0d03102:	2980      	cmp	r1, #128	; 0x80
c0d03104:	d02a      	beq.n	c0d0315c <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d03106:	4620      	mov	r0, r4
c0d03108:	4629      	mov	r1, r5
c0d0310a:	f7ff fbcd 	bl	c0d028a8 <USBD_LL_StallEP>
c0d0310e:	e025      	b.n	c0d0315c <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d03110:	20fc      	movs	r0, #252	; 0xfc
c0d03112:	5c20      	ldrb	r0, [r4, r0]
c0d03114:	2803      	cmp	r0, #3
c0d03116:	d02f      	beq.n	c0d03178 <USBD_StdEPReq+0xc2>
c0d03118:	2802      	cmp	r0, #2
c0d0311a:	d10e      	bne.n	c0d0313a <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d0311c:	0668      	lsls	r0, r5, #25
c0d0311e:	d109      	bne.n	c0d03134 <USBD_StdEPReq+0x7e>
c0d03120:	e042      	b.n	c0d031a8 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d03122:	20fc      	movs	r0, #252	; 0xfc
c0d03124:	5c20      	ldrb	r0, [r4, r0]
c0d03126:	2803      	cmp	r0, #3
c0d03128:	d00f      	beq.n	c0d0314a <USBD_StdEPReq+0x94>
c0d0312a:	2802      	cmp	r0, #2
c0d0312c:	d105      	bne.n	c0d0313a <USBD_StdEPReq+0x84>
c0d0312e:	4329      	orrs	r1, r5
c0d03130:	2980      	cmp	r1, #128	; 0x80
c0d03132:	d039      	beq.n	c0d031a8 <USBD_StdEPReq+0xf2>
c0d03134:	4620      	mov	r0, r4
c0d03136:	4629      	mov	r1, r5
c0d03138:	e004      	b.n	c0d03144 <USBD_StdEPReq+0x8e>
c0d0313a:	4620      	mov	r0, r4
c0d0313c:	f7ff fbb4 	bl	c0d028a8 <USBD_LL_StallEP>
c0d03140:	2100      	movs	r1, #0
c0d03142:	4620      	mov	r0, r4
c0d03144:	f7ff fbb0 	bl	c0d028a8 <USBD_LL_StallEP>
c0d03148:	e02e      	b.n	c0d031a8 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d0314a:	8870      	ldrh	r0, [r6, #2]
c0d0314c:	2800      	cmp	r0, #0
c0d0314e:	d12b      	bne.n	c0d031a8 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d03150:	0668      	lsls	r0, r5, #25
c0d03152:	d00d      	beq.n	c0d03170 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d03154:	4620      	mov	r0, r4
c0d03156:	4629      	mov	r1, r5
c0d03158:	f7ff fbcc 	bl	c0d028f4 <USBD_LL_ClearStallEP>
c0d0315c:	2045      	movs	r0, #69	; 0x45
c0d0315e:	0080      	lsls	r0, r0, #2
c0d03160:	5820      	ldr	r0, [r4, r0]
c0d03162:	6880      	ldr	r0, [r0, #8]
c0d03164:	f7fe ff8a 	bl	c0d0207c <pic>
c0d03168:	4602      	mov	r2, r0
c0d0316a:	4620      	mov	r0, r4
c0d0316c:	4631      	mov	r1, r6
c0d0316e:	4790      	blx	r2
c0d03170:	4620      	mov	r0, r4
c0d03172:	f000 f983 	bl	c0d0347c <USBD_CtlSendStatus>
c0d03176:	e017      	b.n	c0d031a8 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03178:	4626      	mov	r6, r4
c0d0317a:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d0317c:	4620      	mov	r0, r4
c0d0317e:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03180:	420d      	tst	r5, r1
c0d03182:	d100      	bne.n	c0d03186 <USBD_StdEPReq+0xd0>
c0d03184:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03186:	4620      	mov	r0, r4
c0d03188:	4629      	mov	r1, r5
c0d0318a:	f7ff fbd9 	bl	c0d02940 <USBD_LL_IsStallEP>
c0d0318e:	2101      	movs	r1, #1
c0d03190:	2800      	cmp	r0, #0
c0d03192:	d100      	bne.n	c0d03196 <USBD_StdEPReq+0xe0>
c0d03194:	4601      	mov	r1, r0
c0d03196:	207f      	movs	r0, #127	; 0x7f
c0d03198:	4005      	ands	r5, r0
c0d0319a:	0128      	lsls	r0, r5, #4
c0d0319c:	5031      	str	r1, [r6, r0]
c0d0319e:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d031a0:	2202      	movs	r2, #2
c0d031a2:	4620      	mov	r0, r4
c0d031a4:	f000 f93c 	bl	c0d03420 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d031a8:	2000      	movs	r0, #0
c0d031aa:	b001      	add	sp, #4
c0d031ac:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d031ae <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d031ae:	780a      	ldrb	r2, [r1, #0]
c0d031b0:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d031b2:	784a      	ldrb	r2, [r1, #1]
c0d031b4:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d031b6:	788a      	ldrb	r2, [r1, #2]
c0d031b8:	78cb      	ldrb	r3, [r1, #3]
c0d031ba:	021b      	lsls	r3, r3, #8
c0d031bc:	4313      	orrs	r3, r2
c0d031be:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d031c0:	790a      	ldrb	r2, [r1, #4]
c0d031c2:	794b      	ldrb	r3, [r1, #5]
c0d031c4:	021b      	lsls	r3, r3, #8
c0d031c6:	4313      	orrs	r3, r2
c0d031c8:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d031ca:	798a      	ldrb	r2, [r1, #6]
c0d031cc:	79c9      	ldrb	r1, [r1, #7]
c0d031ce:	0209      	lsls	r1, r1, #8
c0d031d0:	4311      	orrs	r1, r2
c0d031d2:	80c1      	strh	r1, [r0, #6]

}
c0d031d4:	4770      	bx	lr

c0d031d6 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d031d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031d8:	af03      	add	r7, sp, #12
c0d031da:	b083      	sub	sp, #12
c0d031dc:	460d      	mov	r5, r1
c0d031de:	4604      	mov	r4, r0
c0d031e0:	a802      	add	r0, sp, #8
c0d031e2:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d031e4:	8006      	strh	r6, [r0, #0]
c0d031e6:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d031e8:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d031ea:	7829      	ldrb	r1, [r5, #0]
c0d031ec:	2060      	movs	r0, #96	; 0x60
c0d031ee:	4008      	ands	r0, r1
c0d031f0:	2800      	cmp	r0, #0
c0d031f2:	d010      	beq.n	c0d03216 <USBD_HID_Setup+0x40>
c0d031f4:	2820      	cmp	r0, #32
c0d031f6:	d139      	bne.n	c0d0326c <USBD_HID_Setup+0x96>
c0d031f8:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d031fa:	4601      	mov	r1, r0
c0d031fc:	390a      	subs	r1, #10
c0d031fe:	2902      	cmp	r1, #2
c0d03200:	d334      	bcc.n	c0d0326c <USBD_HID_Setup+0x96>
c0d03202:	2802      	cmp	r0, #2
c0d03204:	d01c      	beq.n	c0d03240 <USBD_HID_Setup+0x6a>
c0d03206:	2803      	cmp	r0, #3
c0d03208:	d01a      	beq.n	c0d03240 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0320a:	4620      	mov	r0, r4
c0d0320c:	4629      	mov	r1, r5
c0d0320e:	f7ff ff1f 	bl	c0d03050 <USBD_CtlError>
c0d03212:	2602      	movs	r6, #2
c0d03214:	e02a      	b.n	c0d0326c <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d03216:	7868      	ldrb	r0, [r5, #1]
c0d03218:	280b      	cmp	r0, #11
c0d0321a:	d014      	beq.n	c0d03246 <USBD_HID_Setup+0x70>
c0d0321c:	280a      	cmp	r0, #10
c0d0321e:	d00f      	beq.n	c0d03240 <USBD_HID_Setup+0x6a>
c0d03220:	2806      	cmp	r0, #6
c0d03222:	d123      	bne.n	c0d0326c <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d03224:	8868      	ldrh	r0, [r5, #2]
c0d03226:	0a00      	lsrs	r0, r0, #8
c0d03228:	2600      	movs	r6, #0
c0d0322a:	2821      	cmp	r0, #33	; 0x21
c0d0322c:	d00f      	beq.n	c0d0324e <USBD_HID_Setup+0x78>
c0d0322e:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d03230:	4632      	mov	r2, r6
c0d03232:	4631      	mov	r1, r6
c0d03234:	d117      	bne.n	c0d03266 <USBD_HID_Setup+0x90>
c0d03236:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d03238:	9000      	str	r0, [sp, #0]
c0d0323a:	f000 f847 	bl	c0d032cc <USBD_HID_GetReportDescriptor_impl>
c0d0323e:	e00a      	b.n	c0d03256 <USBD_HID_Setup+0x80>
c0d03240:	a901      	add	r1, sp, #4
c0d03242:	2201      	movs	r2, #1
c0d03244:	e00f      	b.n	c0d03266 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d03246:	4620      	mov	r0, r4
c0d03248:	f000 f918 	bl	c0d0347c <USBD_CtlSendStatus>
c0d0324c:	e00e      	b.n	c0d0326c <USBD_HID_Setup+0x96>
c0d0324e:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d03250:	9000      	str	r0, [sp, #0]
c0d03252:	f000 f833 	bl	c0d032bc <USBD_HID_GetHidDescriptor_impl>
c0d03256:	9b00      	ldr	r3, [sp, #0]
c0d03258:	4601      	mov	r1, r0
c0d0325a:	881a      	ldrh	r2, [r3, #0]
c0d0325c:	88e8      	ldrh	r0, [r5, #6]
c0d0325e:	4282      	cmp	r2, r0
c0d03260:	d300      	bcc.n	c0d03264 <USBD_HID_Setup+0x8e>
c0d03262:	4602      	mov	r2, r0
c0d03264:	801a      	strh	r2, [r3, #0]
c0d03266:	4620      	mov	r0, r4
c0d03268:	f000 f8da 	bl	c0d03420 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d0326c:	b2f0      	uxtb	r0, r6
c0d0326e:	b003      	add	sp, #12
c0d03270:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03272 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03272:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03274:	af03      	add	r7, sp, #12
c0d03276:	b081      	sub	sp, #4
c0d03278:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d0327a:	2182      	movs	r1, #130	; 0x82
c0d0327c:	2502      	movs	r5, #2
c0d0327e:	2640      	movs	r6, #64	; 0x40
c0d03280:	462a      	mov	r2, r5
c0d03282:	4633      	mov	r3, r6
c0d03284:	f7ff fad0 	bl	c0d02828 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03288:	4620      	mov	r0, r4
c0d0328a:	4629      	mov	r1, r5
c0d0328c:	462a      	mov	r2, r5
c0d0328e:	4633      	mov	r3, r6
c0d03290:	f7ff faca 	bl	c0d02828 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03294:	4620      	mov	r0, r4
c0d03296:	4629      	mov	r1, r5
c0d03298:	4632      	mov	r2, r6
c0d0329a:	f7ff fb90 	bl	c0d029be <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d0329e:	2000      	movs	r0, #0
c0d032a0:	b001      	add	sp, #4
c0d032a2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d032a4 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d032a4:	b5d0      	push	{r4, r6, r7, lr}
c0d032a6:	af02      	add	r7, sp, #8
c0d032a8:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d032aa:	2182      	movs	r1, #130	; 0x82
c0d032ac:	f7ff fae4 	bl	c0d02878 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d032b0:	2102      	movs	r1, #2
c0d032b2:	4620      	mov	r0, r4
c0d032b4:	f7ff fae0 	bl	c0d02878 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d032b8:	2000      	movs	r0, #0
c0d032ba:	bdd0      	pop	{r4, r6, r7, pc}

c0d032bc <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d032bc:	2109      	movs	r1, #9
c0d032be:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d032c0:	4801      	ldr	r0, [pc, #4]	; (c0d032c8 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d032c2:	4478      	add	r0, pc
c0d032c4:	4770      	bx	lr
c0d032c6:	46c0      	nop			; (mov r8, r8)
c0d032c8:	00000cc6 	.word	0x00000cc6

c0d032cc <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d032cc:	2122      	movs	r1, #34	; 0x22
c0d032ce:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d032d0:	4801      	ldr	r0, [pc, #4]	; (c0d032d8 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d032d2:	4478      	add	r0, pc
c0d032d4:	4770      	bx	lr
c0d032d6:	46c0      	nop			; (mov r8, r8)
c0d032d8:	00000c91 	.word	0x00000c91

c0d032dc <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d032dc:	b5b0      	push	{r4, r5, r7, lr}
c0d032de:	af02      	add	r7, sp, #8
c0d032e0:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d032e2:	2102      	movs	r1, #2
c0d032e4:	2240      	movs	r2, #64	; 0x40
c0d032e6:	f7ff fb6a 	bl	c0d029be <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d032ea:	4d0d      	ldr	r5, [pc, #52]	; (c0d03320 <USBD_HID_DataOut_impl+0x44>)
c0d032ec:	7828      	ldrb	r0, [r5, #0]
c0d032ee:	2800      	cmp	r0, #0
c0d032f0:	d113      	bne.n	c0d0331a <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d032f2:	2002      	movs	r0, #2
c0d032f4:	f7fe f928 	bl	c0d01548 <io_seproxyhal_get_ep_rx_size>
c0d032f8:	4602      	mov	r2, r0
c0d032fa:	480d      	ldr	r0, [pc, #52]	; (c0d03330 <USBD_HID_DataOut_impl+0x54>)
c0d032fc:	4478      	add	r0, pc
c0d032fe:	4621      	mov	r1, r4
c0d03300:	f7fd ff86 	bl	c0d01210 <io_usb_hid_receive>
c0d03304:	2802      	cmp	r0, #2
c0d03306:	d108      	bne.n	c0d0331a <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03308:	2001      	movs	r0, #1
c0d0330a:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0330c:	4805      	ldr	r0, [pc, #20]	; (c0d03324 <USBD_HID_DataOut_impl+0x48>)
c0d0330e:	2107      	movs	r1, #7
c0d03310:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d03312:	4805      	ldr	r0, [pc, #20]	; (c0d03328 <USBD_HID_DataOut_impl+0x4c>)
c0d03314:	6800      	ldr	r0, [r0, #0]
c0d03316:	4905      	ldr	r1, [pc, #20]	; (c0d0332c <USBD_HID_DataOut_impl+0x50>)
c0d03318:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d0331a:	2000      	movs	r0, #0
c0d0331c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0331e:	46c0      	nop			; (mov r8, r8)
c0d03320:	20001d10 	.word	0x20001d10
c0d03324:	20001d18 	.word	0x20001d18
c0d03328:	20001c00 	.word	0x20001c00
c0d0332c:	20001d1c 	.word	0x20001d1c
c0d03330:	ffffe3a1 	.word	0xffffe3a1

c0d03334 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d03334:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03336:	af03      	add	r7, sp, #12
c0d03338:	b081      	sub	sp, #4
c0d0333a:	4604      	mov	r4, r0
c0d0333c:	2049      	movs	r0, #73	; 0x49
c0d0333e:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03340:	4810      	ldr	r0, [pc, #64]	; (c0d03384 <USB_power+0x50>)
c0d03342:	2100      	movs	r1, #0
c0d03344:	462a      	mov	r2, r5
c0d03346:	f7fe f80f 	bl	c0d01368 <os_memset>

  if (enabled) {
c0d0334a:	2c00      	cmp	r4, #0
c0d0334c:	d015      	beq.n	c0d0337a <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0334e:	4c0d      	ldr	r4, [pc, #52]	; (c0d03384 <USB_power+0x50>)
c0d03350:	2600      	movs	r6, #0
c0d03352:	4620      	mov	r0, r4
c0d03354:	4631      	mov	r1, r6
c0d03356:	462a      	mov	r2, r5
c0d03358:	f7fe f806 	bl	c0d01368 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d0335c:	490a      	ldr	r1, [pc, #40]	; (c0d03388 <USB_power+0x54>)
c0d0335e:	4479      	add	r1, pc
c0d03360:	4620      	mov	r0, r4
c0d03362:	4632      	mov	r2, r6
c0d03364:	f7ff fb3f 	bl	c0d029e6 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03368:	4908      	ldr	r1, [pc, #32]	; (c0d0338c <USB_power+0x58>)
c0d0336a:	4479      	add	r1, pc
c0d0336c:	4620      	mov	r0, r4
c0d0336e:	f7ff fb72 	bl	c0d02a56 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d03372:	4620      	mov	r0, r4
c0d03374:	f7ff fb78 	bl	c0d02a68 <USBD_Start>
c0d03378:	e002      	b.n	c0d03380 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d0337a:	4802      	ldr	r0, [pc, #8]	; (c0d03384 <USB_power+0x50>)
c0d0337c:	f7ff fb51 	bl	c0d02a22 <USBD_DeInit>
  }
}
c0d03380:	b001      	add	sp, #4
c0d03382:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03384:	20001d34 	.word	0x20001d34
c0d03388:	00000c46 	.word	0x00000c46
c0d0338c:	00000c76 	.word	0x00000c76

c0d03390 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03390:	2012      	movs	r0, #18
c0d03392:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03394:	4801      	ldr	r0, [pc, #4]	; (c0d0339c <USBD_DeviceDescriptor+0xc>)
c0d03396:	4478      	add	r0, pc
c0d03398:	4770      	bx	lr
c0d0339a:	46c0      	nop			; (mov r8, r8)
c0d0339c:	00000bfb 	.word	0x00000bfb

c0d033a0 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d033a0:	2004      	movs	r0, #4
c0d033a2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d033a4:	4801      	ldr	r0, [pc, #4]	; (c0d033ac <USBD_LangIDStrDescriptor+0xc>)
c0d033a6:	4478      	add	r0, pc
c0d033a8:	4770      	bx	lr
c0d033aa:	46c0      	nop			; (mov r8, r8)
c0d033ac:	00000c1e 	.word	0x00000c1e

c0d033b0 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d033b0:	200e      	movs	r0, #14
c0d033b2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d033b4:	4801      	ldr	r0, [pc, #4]	; (c0d033bc <USBD_ManufacturerStrDescriptor+0xc>)
c0d033b6:	4478      	add	r0, pc
c0d033b8:	4770      	bx	lr
c0d033ba:	46c0      	nop			; (mov r8, r8)
c0d033bc:	00000c12 	.word	0x00000c12

c0d033c0 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d033c0:	200e      	movs	r0, #14
c0d033c2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d033c4:	4801      	ldr	r0, [pc, #4]	; (c0d033cc <USBD_ProductStrDescriptor+0xc>)
c0d033c6:	4478      	add	r0, pc
c0d033c8:	4770      	bx	lr
c0d033ca:	46c0      	nop			; (mov r8, r8)
c0d033cc:	00000b8f 	.word	0x00000b8f

c0d033d0 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d033d0:	200a      	movs	r0, #10
c0d033d2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d033d4:	4801      	ldr	r0, [pc, #4]	; (c0d033dc <USBD_SerialStrDescriptor+0xc>)
c0d033d6:	4478      	add	r0, pc
c0d033d8:	4770      	bx	lr
c0d033da:	46c0      	nop			; (mov r8, r8)
c0d033dc:	00000c00 	.word	0x00000c00

c0d033e0 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d033e0:	200e      	movs	r0, #14
c0d033e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d033e4:	4801      	ldr	r0, [pc, #4]	; (c0d033ec <USBD_ConfigStrDescriptor+0xc>)
c0d033e6:	4478      	add	r0, pc
c0d033e8:	4770      	bx	lr
c0d033ea:	46c0      	nop			; (mov r8, r8)
c0d033ec:	00000b6f 	.word	0x00000b6f

c0d033f0 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d033f0:	200e      	movs	r0, #14
c0d033f2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d033f4:	4801      	ldr	r0, [pc, #4]	; (c0d033fc <USBD_InterfaceStrDescriptor+0xc>)
c0d033f6:	4478      	add	r0, pc
c0d033f8:	4770      	bx	lr
c0d033fa:	46c0      	nop			; (mov r8, r8)
c0d033fc:	00000b5f 	.word	0x00000b5f

c0d03400 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d03400:	2129      	movs	r1, #41	; 0x29
c0d03402:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03404:	4801      	ldr	r0, [pc, #4]	; (c0d0340c <USBD_GetCfgDesc_impl+0xc>)
c0d03406:	4478      	add	r0, pc
c0d03408:	4770      	bx	lr
c0d0340a:	46c0      	nop			; (mov r8, r8)
c0d0340c:	00000c12 	.word	0x00000c12

c0d03410 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03410:	210a      	movs	r1, #10
c0d03412:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03414:	4801      	ldr	r0, [pc, #4]	; (c0d0341c <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d03416:	4478      	add	r0, pc
c0d03418:	4770      	bx	lr
c0d0341a:	46c0      	nop			; (mov r8, r8)
c0d0341c:	00000c2e 	.word	0x00000c2e

c0d03420 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d03420:	b5b0      	push	{r4, r5, r7, lr}
c0d03422:	af02      	add	r7, sp, #8
c0d03424:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d03426:	21f4      	movs	r1, #244	; 0xf4
c0d03428:	2302      	movs	r3, #2
c0d0342a:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d0342c:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d0342e:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d03430:	2109      	movs	r1, #9
c0d03432:	0149      	lsls	r1, r1, #5
c0d03434:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03436:	6a01      	ldr	r1, [r0, #32]
c0d03438:	428a      	cmp	r2, r1
c0d0343a:	d300      	bcc.n	c0d0343e <USBD_CtlSendData+0x1e>
c0d0343c:	460a      	mov	r2, r1
c0d0343e:	b293      	uxth	r3, r2
c0d03440:	2500      	movs	r5, #0
c0d03442:	4629      	mov	r1, r5
c0d03444:	4622      	mov	r2, r4
c0d03446:	f7ff faa0 	bl	c0d0298a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d0344a:	4628      	mov	r0, r5
c0d0344c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0344e <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d0344e:	b5b0      	push	{r4, r5, r7, lr}
c0d03450:	af02      	add	r7, sp, #8
c0d03452:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d03454:	6a01      	ldr	r1, [r0, #32]
c0d03456:	428a      	cmp	r2, r1
c0d03458:	d300      	bcc.n	c0d0345c <USBD_CtlContinueSendData+0xe>
c0d0345a:	460a      	mov	r2, r1
c0d0345c:	b293      	uxth	r3, r2
c0d0345e:	2500      	movs	r5, #0
c0d03460:	4629      	mov	r1, r5
c0d03462:	4622      	mov	r2, r4
c0d03464:	f7ff fa91 	bl	c0d0298a <USBD_LL_Transmit>
  return USBD_OK;
c0d03468:	4628      	mov	r0, r5
c0d0346a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0346c <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d0346c:	b5d0      	push	{r4, r6, r7, lr}
c0d0346e:	af02      	add	r7, sp, #8
c0d03470:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d03472:	4621      	mov	r1, r4
c0d03474:	f7ff faa3 	bl	c0d029be <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03478:	4620      	mov	r0, r4
c0d0347a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0347c <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d0347c:	b5d0      	push	{r4, r6, r7, lr}
c0d0347e:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03480:	21f4      	movs	r1, #244	; 0xf4
c0d03482:	2204      	movs	r2, #4
c0d03484:	5042      	str	r2, [r0, r1]
c0d03486:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03488:	4621      	mov	r1, r4
c0d0348a:	4622      	mov	r2, r4
c0d0348c:	4623      	mov	r3, r4
c0d0348e:	f7ff fa7c 	bl	c0d0298a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03492:	4620      	mov	r0, r4
c0d03494:	bdd0      	pop	{r4, r6, r7, pc}

c0d03496 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03496:	b5d0      	push	{r4, r6, r7, lr}
c0d03498:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0349a:	21f4      	movs	r1, #244	; 0xf4
c0d0349c:	2205      	movs	r2, #5
c0d0349e:	5042      	str	r2, [r0, r1]
c0d034a0:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d034a2:	4621      	mov	r1, r4
c0d034a4:	4622      	mov	r2, r4
c0d034a6:	f7ff fa8a 	bl	c0d029be <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d034aa:	4620      	mov	r0, r4
c0d034ac:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d034b0 <__aeabi_uidiv>:
c0d034b0:	2200      	movs	r2, #0
c0d034b2:	0843      	lsrs	r3, r0, #1
c0d034b4:	428b      	cmp	r3, r1
c0d034b6:	d374      	bcc.n	c0d035a2 <__aeabi_uidiv+0xf2>
c0d034b8:	0903      	lsrs	r3, r0, #4
c0d034ba:	428b      	cmp	r3, r1
c0d034bc:	d35f      	bcc.n	c0d0357e <__aeabi_uidiv+0xce>
c0d034be:	0a03      	lsrs	r3, r0, #8
c0d034c0:	428b      	cmp	r3, r1
c0d034c2:	d344      	bcc.n	c0d0354e <__aeabi_uidiv+0x9e>
c0d034c4:	0b03      	lsrs	r3, r0, #12
c0d034c6:	428b      	cmp	r3, r1
c0d034c8:	d328      	bcc.n	c0d0351c <__aeabi_uidiv+0x6c>
c0d034ca:	0c03      	lsrs	r3, r0, #16
c0d034cc:	428b      	cmp	r3, r1
c0d034ce:	d30d      	bcc.n	c0d034ec <__aeabi_uidiv+0x3c>
c0d034d0:	22ff      	movs	r2, #255	; 0xff
c0d034d2:	0209      	lsls	r1, r1, #8
c0d034d4:	ba12      	rev	r2, r2
c0d034d6:	0c03      	lsrs	r3, r0, #16
c0d034d8:	428b      	cmp	r3, r1
c0d034da:	d302      	bcc.n	c0d034e2 <__aeabi_uidiv+0x32>
c0d034dc:	1212      	asrs	r2, r2, #8
c0d034de:	0209      	lsls	r1, r1, #8
c0d034e0:	d065      	beq.n	c0d035ae <__aeabi_uidiv+0xfe>
c0d034e2:	0b03      	lsrs	r3, r0, #12
c0d034e4:	428b      	cmp	r3, r1
c0d034e6:	d319      	bcc.n	c0d0351c <__aeabi_uidiv+0x6c>
c0d034e8:	e000      	b.n	c0d034ec <__aeabi_uidiv+0x3c>
c0d034ea:	0a09      	lsrs	r1, r1, #8
c0d034ec:	0bc3      	lsrs	r3, r0, #15
c0d034ee:	428b      	cmp	r3, r1
c0d034f0:	d301      	bcc.n	c0d034f6 <__aeabi_uidiv+0x46>
c0d034f2:	03cb      	lsls	r3, r1, #15
c0d034f4:	1ac0      	subs	r0, r0, r3
c0d034f6:	4152      	adcs	r2, r2
c0d034f8:	0b83      	lsrs	r3, r0, #14
c0d034fa:	428b      	cmp	r3, r1
c0d034fc:	d301      	bcc.n	c0d03502 <__aeabi_uidiv+0x52>
c0d034fe:	038b      	lsls	r3, r1, #14
c0d03500:	1ac0      	subs	r0, r0, r3
c0d03502:	4152      	adcs	r2, r2
c0d03504:	0b43      	lsrs	r3, r0, #13
c0d03506:	428b      	cmp	r3, r1
c0d03508:	d301      	bcc.n	c0d0350e <__aeabi_uidiv+0x5e>
c0d0350a:	034b      	lsls	r3, r1, #13
c0d0350c:	1ac0      	subs	r0, r0, r3
c0d0350e:	4152      	adcs	r2, r2
c0d03510:	0b03      	lsrs	r3, r0, #12
c0d03512:	428b      	cmp	r3, r1
c0d03514:	d301      	bcc.n	c0d0351a <__aeabi_uidiv+0x6a>
c0d03516:	030b      	lsls	r3, r1, #12
c0d03518:	1ac0      	subs	r0, r0, r3
c0d0351a:	4152      	adcs	r2, r2
c0d0351c:	0ac3      	lsrs	r3, r0, #11
c0d0351e:	428b      	cmp	r3, r1
c0d03520:	d301      	bcc.n	c0d03526 <__aeabi_uidiv+0x76>
c0d03522:	02cb      	lsls	r3, r1, #11
c0d03524:	1ac0      	subs	r0, r0, r3
c0d03526:	4152      	adcs	r2, r2
c0d03528:	0a83      	lsrs	r3, r0, #10
c0d0352a:	428b      	cmp	r3, r1
c0d0352c:	d301      	bcc.n	c0d03532 <__aeabi_uidiv+0x82>
c0d0352e:	028b      	lsls	r3, r1, #10
c0d03530:	1ac0      	subs	r0, r0, r3
c0d03532:	4152      	adcs	r2, r2
c0d03534:	0a43      	lsrs	r3, r0, #9
c0d03536:	428b      	cmp	r3, r1
c0d03538:	d301      	bcc.n	c0d0353e <__aeabi_uidiv+0x8e>
c0d0353a:	024b      	lsls	r3, r1, #9
c0d0353c:	1ac0      	subs	r0, r0, r3
c0d0353e:	4152      	adcs	r2, r2
c0d03540:	0a03      	lsrs	r3, r0, #8
c0d03542:	428b      	cmp	r3, r1
c0d03544:	d301      	bcc.n	c0d0354a <__aeabi_uidiv+0x9a>
c0d03546:	020b      	lsls	r3, r1, #8
c0d03548:	1ac0      	subs	r0, r0, r3
c0d0354a:	4152      	adcs	r2, r2
c0d0354c:	d2cd      	bcs.n	c0d034ea <__aeabi_uidiv+0x3a>
c0d0354e:	09c3      	lsrs	r3, r0, #7
c0d03550:	428b      	cmp	r3, r1
c0d03552:	d301      	bcc.n	c0d03558 <__aeabi_uidiv+0xa8>
c0d03554:	01cb      	lsls	r3, r1, #7
c0d03556:	1ac0      	subs	r0, r0, r3
c0d03558:	4152      	adcs	r2, r2
c0d0355a:	0983      	lsrs	r3, r0, #6
c0d0355c:	428b      	cmp	r3, r1
c0d0355e:	d301      	bcc.n	c0d03564 <__aeabi_uidiv+0xb4>
c0d03560:	018b      	lsls	r3, r1, #6
c0d03562:	1ac0      	subs	r0, r0, r3
c0d03564:	4152      	adcs	r2, r2
c0d03566:	0943      	lsrs	r3, r0, #5
c0d03568:	428b      	cmp	r3, r1
c0d0356a:	d301      	bcc.n	c0d03570 <__aeabi_uidiv+0xc0>
c0d0356c:	014b      	lsls	r3, r1, #5
c0d0356e:	1ac0      	subs	r0, r0, r3
c0d03570:	4152      	adcs	r2, r2
c0d03572:	0903      	lsrs	r3, r0, #4
c0d03574:	428b      	cmp	r3, r1
c0d03576:	d301      	bcc.n	c0d0357c <__aeabi_uidiv+0xcc>
c0d03578:	010b      	lsls	r3, r1, #4
c0d0357a:	1ac0      	subs	r0, r0, r3
c0d0357c:	4152      	adcs	r2, r2
c0d0357e:	08c3      	lsrs	r3, r0, #3
c0d03580:	428b      	cmp	r3, r1
c0d03582:	d301      	bcc.n	c0d03588 <__aeabi_uidiv+0xd8>
c0d03584:	00cb      	lsls	r3, r1, #3
c0d03586:	1ac0      	subs	r0, r0, r3
c0d03588:	4152      	adcs	r2, r2
c0d0358a:	0883      	lsrs	r3, r0, #2
c0d0358c:	428b      	cmp	r3, r1
c0d0358e:	d301      	bcc.n	c0d03594 <__aeabi_uidiv+0xe4>
c0d03590:	008b      	lsls	r3, r1, #2
c0d03592:	1ac0      	subs	r0, r0, r3
c0d03594:	4152      	adcs	r2, r2
c0d03596:	0843      	lsrs	r3, r0, #1
c0d03598:	428b      	cmp	r3, r1
c0d0359a:	d301      	bcc.n	c0d035a0 <__aeabi_uidiv+0xf0>
c0d0359c:	004b      	lsls	r3, r1, #1
c0d0359e:	1ac0      	subs	r0, r0, r3
c0d035a0:	4152      	adcs	r2, r2
c0d035a2:	1a41      	subs	r1, r0, r1
c0d035a4:	d200      	bcs.n	c0d035a8 <__aeabi_uidiv+0xf8>
c0d035a6:	4601      	mov	r1, r0
c0d035a8:	4152      	adcs	r2, r2
c0d035aa:	4610      	mov	r0, r2
c0d035ac:	4770      	bx	lr
c0d035ae:	e7ff      	b.n	c0d035b0 <__aeabi_uidiv+0x100>
c0d035b0:	b501      	push	{r0, lr}
c0d035b2:	2000      	movs	r0, #0
c0d035b4:	f000 f8f0 	bl	c0d03798 <__aeabi_idiv0>
c0d035b8:	bd02      	pop	{r1, pc}
c0d035ba:	46c0      	nop			; (mov r8, r8)

c0d035bc <__aeabi_uidivmod>:
c0d035bc:	2900      	cmp	r1, #0
c0d035be:	d0f7      	beq.n	c0d035b0 <__aeabi_uidiv+0x100>
c0d035c0:	e776      	b.n	c0d034b0 <__aeabi_uidiv>
c0d035c2:	4770      	bx	lr

c0d035c4 <__aeabi_idiv>:
c0d035c4:	4603      	mov	r3, r0
c0d035c6:	430b      	orrs	r3, r1
c0d035c8:	d47f      	bmi.n	c0d036ca <__aeabi_idiv+0x106>
c0d035ca:	2200      	movs	r2, #0
c0d035cc:	0843      	lsrs	r3, r0, #1
c0d035ce:	428b      	cmp	r3, r1
c0d035d0:	d374      	bcc.n	c0d036bc <__aeabi_idiv+0xf8>
c0d035d2:	0903      	lsrs	r3, r0, #4
c0d035d4:	428b      	cmp	r3, r1
c0d035d6:	d35f      	bcc.n	c0d03698 <__aeabi_idiv+0xd4>
c0d035d8:	0a03      	lsrs	r3, r0, #8
c0d035da:	428b      	cmp	r3, r1
c0d035dc:	d344      	bcc.n	c0d03668 <__aeabi_idiv+0xa4>
c0d035de:	0b03      	lsrs	r3, r0, #12
c0d035e0:	428b      	cmp	r3, r1
c0d035e2:	d328      	bcc.n	c0d03636 <__aeabi_idiv+0x72>
c0d035e4:	0c03      	lsrs	r3, r0, #16
c0d035e6:	428b      	cmp	r3, r1
c0d035e8:	d30d      	bcc.n	c0d03606 <__aeabi_idiv+0x42>
c0d035ea:	22ff      	movs	r2, #255	; 0xff
c0d035ec:	0209      	lsls	r1, r1, #8
c0d035ee:	ba12      	rev	r2, r2
c0d035f0:	0c03      	lsrs	r3, r0, #16
c0d035f2:	428b      	cmp	r3, r1
c0d035f4:	d302      	bcc.n	c0d035fc <__aeabi_idiv+0x38>
c0d035f6:	1212      	asrs	r2, r2, #8
c0d035f8:	0209      	lsls	r1, r1, #8
c0d035fa:	d065      	beq.n	c0d036c8 <__aeabi_idiv+0x104>
c0d035fc:	0b03      	lsrs	r3, r0, #12
c0d035fe:	428b      	cmp	r3, r1
c0d03600:	d319      	bcc.n	c0d03636 <__aeabi_idiv+0x72>
c0d03602:	e000      	b.n	c0d03606 <__aeabi_idiv+0x42>
c0d03604:	0a09      	lsrs	r1, r1, #8
c0d03606:	0bc3      	lsrs	r3, r0, #15
c0d03608:	428b      	cmp	r3, r1
c0d0360a:	d301      	bcc.n	c0d03610 <__aeabi_idiv+0x4c>
c0d0360c:	03cb      	lsls	r3, r1, #15
c0d0360e:	1ac0      	subs	r0, r0, r3
c0d03610:	4152      	adcs	r2, r2
c0d03612:	0b83      	lsrs	r3, r0, #14
c0d03614:	428b      	cmp	r3, r1
c0d03616:	d301      	bcc.n	c0d0361c <__aeabi_idiv+0x58>
c0d03618:	038b      	lsls	r3, r1, #14
c0d0361a:	1ac0      	subs	r0, r0, r3
c0d0361c:	4152      	adcs	r2, r2
c0d0361e:	0b43      	lsrs	r3, r0, #13
c0d03620:	428b      	cmp	r3, r1
c0d03622:	d301      	bcc.n	c0d03628 <__aeabi_idiv+0x64>
c0d03624:	034b      	lsls	r3, r1, #13
c0d03626:	1ac0      	subs	r0, r0, r3
c0d03628:	4152      	adcs	r2, r2
c0d0362a:	0b03      	lsrs	r3, r0, #12
c0d0362c:	428b      	cmp	r3, r1
c0d0362e:	d301      	bcc.n	c0d03634 <__aeabi_idiv+0x70>
c0d03630:	030b      	lsls	r3, r1, #12
c0d03632:	1ac0      	subs	r0, r0, r3
c0d03634:	4152      	adcs	r2, r2
c0d03636:	0ac3      	lsrs	r3, r0, #11
c0d03638:	428b      	cmp	r3, r1
c0d0363a:	d301      	bcc.n	c0d03640 <__aeabi_idiv+0x7c>
c0d0363c:	02cb      	lsls	r3, r1, #11
c0d0363e:	1ac0      	subs	r0, r0, r3
c0d03640:	4152      	adcs	r2, r2
c0d03642:	0a83      	lsrs	r3, r0, #10
c0d03644:	428b      	cmp	r3, r1
c0d03646:	d301      	bcc.n	c0d0364c <__aeabi_idiv+0x88>
c0d03648:	028b      	lsls	r3, r1, #10
c0d0364a:	1ac0      	subs	r0, r0, r3
c0d0364c:	4152      	adcs	r2, r2
c0d0364e:	0a43      	lsrs	r3, r0, #9
c0d03650:	428b      	cmp	r3, r1
c0d03652:	d301      	bcc.n	c0d03658 <__aeabi_idiv+0x94>
c0d03654:	024b      	lsls	r3, r1, #9
c0d03656:	1ac0      	subs	r0, r0, r3
c0d03658:	4152      	adcs	r2, r2
c0d0365a:	0a03      	lsrs	r3, r0, #8
c0d0365c:	428b      	cmp	r3, r1
c0d0365e:	d301      	bcc.n	c0d03664 <__aeabi_idiv+0xa0>
c0d03660:	020b      	lsls	r3, r1, #8
c0d03662:	1ac0      	subs	r0, r0, r3
c0d03664:	4152      	adcs	r2, r2
c0d03666:	d2cd      	bcs.n	c0d03604 <__aeabi_idiv+0x40>
c0d03668:	09c3      	lsrs	r3, r0, #7
c0d0366a:	428b      	cmp	r3, r1
c0d0366c:	d301      	bcc.n	c0d03672 <__aeabi_idiv+0xae>
c0d0366e:	01cb      	lsls	r3, r1, #7
c0d03670:	1ac0      	subs	r0, r0, r3
c0d03672:	4152      	adcs	r2, r2
c0d03674:	0983      	lsrs	r3, r0, #6
c0d03676:	428b      	cmp	r3, r1
c0d03678:	d301      	bcc.n	c0d0367e <__aeabi_idiv+0xba>
c0d0367a:	018b      	lsls	r3, r1, #6
c0d0367c:	1ac0      	subs	r0, r0, r3
c0d0367e:	4152      	adcs	r2, r2
c0d03680:	0943      	lsrs	r3, r0, #5
c0d03682:	428b      	cmp	r3, r1
c0d03684:	d301      	bcc.n	c0d0368a <__aeabi_idiv+0xc6>
c0d03686:	014b      	lsls	r3, r1, #5
c0d03688:	1ac0      	subs	r0, r0, r3
c0d0368a:	4152      	adcs	r2, r2
c0d0368c:	0903      	lsrs	r3, r0, #4
c0d0368e:	428b      	cmp	r3, r1
c0d03690:	d301      	bcc.n	c0d03696 <__aeabi_idiv+0xd2>
c0d03692:	010b      	lsls	r3, r1, #4
c0d03694:	1ac0      	subs	r0, r0, r3
c0d03696:	4152      	adcs	r2, r2
c0d03698:	08c3      	lsrs	r3, r0, #3
c0d0369a:	428b      	cmp	r3, r1
c0d0369c:	d301      	bcc.n	c0d036a2 <__aeabi_idiv+0xde>
c0d0369e:	00cb      	lsls	r3, r1, #3
c0d036a0:	1ac0      	subs	r0, r0, r3
c0d036a2:	4152      	adcs	r2, r2
c0d036a4:	0883      	lsrs	r3, r0, #2
c0d036a6:	428b      	cmp	r3, r1
c0d036a8:	d301      	bcc.n	c0d036ae <__aeabi_idiv+0xea>
c0d036aa:	008b      	lsls	r3, r1, #2
c0d036ac:	1ac0      	subs	r0, r0, r3
c0d036ae:	4152      	adcs	r2, r2
c0d036b0:	0843      	lsrs	r3, r0, #1
c0d036b2:	428b      	cmp	r3, r1
c0d036b4:	d301      	bcc.n	c0d036ba <__aeabi_idiv+0xf6>
c0d036b6:	004b      	lsls	r3, r1, #1
c0d036b8:	1ac0      	subs	r0, r0, r3
c0d036ba:	4152      	adcs	r2, r2
c0d036bc:	1a41      	subs	r1, r0, r1
c0d036be:	d200      	bcs.n	c0d036c2 <__aeabi_idiv+0xfe>
c0d036c0:	4601      	mov	r1, r0
c0d036c2:	4152      	adcs	r2, r2
c0d036c4:	4610      	mov	r0, r2
c0d036c6:	4770      	bx	lr
c0d036c8:	e05d      	b.n	c0d03786 <__aeabi_idiv+0x1c2>
c0d036ca:	0fca      	lsrs	r2, r1, #31
c0d036cc:	d000      	beq.n	c0d036d0 <__aeabi_idiv+0x10c>
c0d036ce:	4249      	negs	r1, r1
c0d036d0:	1003      	asrs	r3, r0, #32
c0d036d2:	d300      	bcc.n	c0d036d6 <__aeabi_idiv+0x112>
c0d036d4:	4240      	negs	r0, r0
c0d036d6:	4053      	eors	r3, r2
c0d036d8:	2200      	movs	r2, #0
c0d036da:	469c      	mov	ip, r3
c0d036dc:	0903      	lsrs	r3, r0, #4
c0d036de:	428b      	cmp	r3, r1
c0d036e0:	d32d      	bcc.n	c0d0373e <__aeabi_idiv+0x17a>
c0d036e2:	0a03      	lsrs	r3, r0, #8
c0d036e4:	428b      	cmp	r3, r1
c0d036e6:	d312      	bcc.n	c0d0370e <__aeabi_idiv+0x14a>
c0d036e8:	22fc      	movs	r2, #252	; 0xfc
c0d036ea:	0189      	lsls	r1, r1, #6
c0d036ec:	ba12      	rev	r2, r2
c0d036ee:	0a03      	lsrs	r3, r0, #8
c0d036f0:	428b      	cmp	r3, r1
c0d036f2:	d30c      	bcc.n	c0d0370e <__aeabi_idiv+0x14a>
c0d036f4:	0189      	lsls	r1, r1, #6
c0d036f6:	1192      	asrs	r2, r2, #6
c0d036f8:	428b      	cmp	r3, r1
c0d036fa:	d308      	bcc.n	c0d0370e <__aeabi_idiv+0x14a>
c0d036fc:	0189      	lsls	r1, r1, #6
c0d036fe:	1192      	asrs	r2, r2, #6
c0d03700:	428b      	cmp	r3, r1
c0d03702:	d304      	bcc.n	c0d0370e <__aeabi_idiv+0x14a>
c0d03704:	0189      	lsls	r1, r1, #6
c0d03706:	d03a      	beq.n	c0d0377e <__aeabi_idiv+0x1ba>
c0d03708:	1192      	asrs	r2, r2, #6
c0d0370a:	e000      	b.n	c0d0370e <__aeabi_idiv+0x14a>
c0d0370c:	0989      	lsrs	r1, r1, #6
c0d0370e:	09c3      	lsrs	r3, r0, #7
c0d03710:	428b      	cmp	r3, r1
c0d03712:	d301      	bcc.n	c0d03718 <__aeabi_idiv+0x154>
c0d03714:	01cb      	lsls	r3, r1, #7
c0d03716:	1ac0      	subs	r0, r0, r3
c0d03718:	4152      	adcs	r2, r2
c0d0371a:	0983      	lsrs	r3, r0, #6
c0d0371c:	428b      	cmp	r3, r1
c0d0371e:	d301      	bcc.n	c0d03724 <__aeabi_idiv+0x160>
c0d03720:	018b      	lsls	r3, r1, #6
c0d03722:	1ac0      	subs	r0, r0, r3
c0d03724:	4152      	adcs	r2, r2
c0d03726:	0943      	lsrs	r3, r0, #5
c0d03728:	428b      	cmp	r3, r1
c0d0372a:	d301      	bcc.n	c0d03730 <__aeabi_idiv+0x16c>
c0d0372c:	014b      	lsls	r3, r1, #5
c0d0372e:	1ac0      	subs	r0, r0, r3
c0d03730:	4152      	adcs	r2, r2
c0d03732:	0903      	lsrs	r3, r0, #4
c0d03734:	428b      	cmp	r3, r1
c0d03736:	d301      	bcc.n	c0d0373c <__aeabi_idiv+0x178>
c0d03738:	010b      	lsls	r3, r1, #4
c0d0373a:	1ac0      	subs	r0, r0, r3
c0d0373c:	4152      	adcs	r2, r2
c0d0373e:	08c3      	lsrs	r3, r0, #3
c0d03740:	428b      	cmp	r3, r1
c0d03742:	d301      	bcc.n	c0d03748 <__aeabi_idiv+0x184>
c0d03744:	00cb      	lsls	r3, r1, #3
c0d03746:	1ac0      	subs	r0, r0, r3
c0d03748:	4152      	adcs	r2, r2
c0d0374a:	0883      	lsrs	r3, r0, #2
c0d0374c:	428b      	cmp	r3, r1
c0d0374e:	d301      	bcc.n	c0d03754 <__aeabi_idiv+0x190>
c0d03750:	008b      	lsls	r3, r1, #2
c0d03752:	1ac0      	subs	r0, r0, r3
c0d03754:	4152      	adcs	r2, r2
c0d03756:	d2d9      	bcs.n	c0d0370c <__aeabi_idiv+0x148>
c0d03758:	0843      	lsrs	r3, r0, #1
c0d0375a:	428b      	cmp	r3, r1
c0d0375c:	d301      	bcc.n	c0d03762 <__aeabi_idiv+0x19e>
c0d0375e:	004b      	lsls	r3, r1, #1
c0d03760:	1ac0      	subs	r0, r0, r3
c0d03762:	4152      	adcs	r2, r2
c0d03764:	1a41      	subs	r1, r0, r1
c0d03766:	d200      	bcs.n	c0d0376a <__aeabi_idiv+0x1a6>
c0d03768:	4601      	mov	r1, r0
c0d0376a:	4663      	mov	r3, ip
c0d0376c:	4152      	adcs	r2, r2
c0d0376e:	105b      	asrs	r3, r3, #1
c0d03770:	4610      	mov	r0, r2
c0d03772:	d301      	bcc.n	c0d03778 <__aeabi_idiv+0x1b4>
c0d03774:	4240      	negs	r0, r0
c0d03776:	2b00      	cmp	r3, #0
c0d03778:	d500      	bpl.n	c0d0377c <__aeabi_idiv+0x1b8>
c0d0377a:	4249      	negs	r1, r1
c0d0377c:	4770      	bx	lr
c0d0377e:	4663      	mov	r3, ip
c0d03780:	105b      	asrs	r3, r3, #1
c0d03782:	d300      	bcc.n	c0d03786 <__aeabi_idiv+0x1c2>
c0d03784:	4240      	negs	r0, r0
c0d03786:	b501      	push	{r0, lr}
c0d03788:	2000      	movs	r0, #0
c0d0378a:	f000 f805 	bl	c0d03798 <__aeabi_idiv0>
c0d0378e:	bd02      	pop	{r1, pc}

c0d03790 <__aeabi_idivmod>:
c0d03790:	2900      	cmp	r1, #0
c0d03792:	d0f8      	beq.n	c0d03786 <__aeabi_idiv+0x1c2>
c0d03794:	e716      	b.n	c0d035c4 <__aeabi_idiv>
c0d03796:	4770      	bx	lr

c0d03798 <__aeabi_idiv0>:
c0d03798:	4770      	bx	lr
c0d0379a:	46c0      	nop			; (mov r8, r8)

c0d0379c <__aeabi_uldivmod>:
c0d0379c:	2b00      	cmp	r3, #0
c0d0379e:	d111      	bne.n	c0d037c4 <__aeabi_uldivmod+0x28>
c0d037a0:	2a00      	cmp	r2, #0
c0d037a2:	d10f      	bne.n	c0d037c4 <__aeabi_uldivmod+0x28>
c0d037a4:	2900      	cmp	r1, #0
c0d037a6:	d100      	bne.n	c0d037aa <__aeabi_uldivmod+0xe>
c0d037a8:	2800      	cmp	r0, #0
c0d037aa:	d002      	beq.n	c0d037b2 <__aeabi_uldivmod+0x16>
c0d037ac:	2100      	movs	r1, #0
c0d037ae:	43c9      	mvns	r1, r1
c0d037b0:	1c08      	adds	r0, r1, #0
c0d037b2:	b407      	push	{r0, r1, r2}
c0d037b4:	4802      	ldr	r0, [pc, #8]	; (c0d037c0 <__aeabi_uldivmod+0x24>)
c0d037b6:	a102      	add	r1, pc, #8	; (adr r1, c0d037c0 <__aeabi_uldivmod+0x24>)
c0d037b8:	1840      	adds	r0, r0, r1
c0d037ba:	9002      	str	r0, [sp, #8]
c0d037bc:	bd03      	pop	{r0, r1, pc}
c0d037be:	46c0      	nop			; (mov r8, r8)
c0d037c0:	ffffffd9 	.word	0xffffffd9
c0d037c4:	b403      	push	{r0, r1}
c0d037c6:	4668      	mov	r0, sp
c0d037c8:	b501      	push	{r0, lr}
c0d037ca:	9802      	ldr	r0, [sp, #8]
c0d037cc:	f000 f832 	bl	c0d03834 <__udivmoddi4>
c0d037d0:	9b01      	ldr	r3, [sp, #4]
c0d037d2:	469e      	mov	lr, r3
c0d037d4:	b002      	add	sp, #8
c0d037d6:	bc0c      	pop	{r2, r3}
c0d037d8:	4770      	bx	lr
c0d037da:	46c0      	nop			; (mov r8, r8)

c0d037dc <__aeabi_lmul>:
c0d037dc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d037de:	464f      	mov	r7, r9
c0d037e0:	4646      	mov	r6, r8
c0d037e2:	b4c0      	push	{r6, r7}
c0d037e4:	0416      	lsls	r6, r2, #16
c0d037e6:	0c36      	lsrs	r6, r6, #16
c0d037e8:	4699      	mov	r9, r3
c0d037ea:	0033      	movs	r3, r6
c0d037ec:	0405      	lsls	r5, r0, #16
c0d037ee:	0c2c      	lsrs	r4, r5, #16
c0d037f0:	0c07      	lsrs	r7, r0, #16
c0d037f2:	0c15      	lsrs	r5, r2, #16
c0d037f4:	4363      	muls	r3, r4
c0d037f6:	437e      	muls	r6, r7
c0d037f8:	436f      	muls	r7, r5
c0d037fa:	4365      	muls	r5, r4
c0d037fc:	0c1c      	lsrs	r4, r3, #16
c0d037fe:	19ad      	adds	r5, r5, r6
c0d03800:	1964      	adds	r4, r4, r5
c0d03802:	469c      	mov	ip, r3
c0d03804:	42a6      	cmp	r6, r4
c0d03806:	d903      	bls.n	c0d03810 <__aeabi_lmul+0x34>
c0d03808:	2380      	movs	r3, #128	; 0x80
c0d0380a:	025b      	lsls	r3, r3, #9
c0d0380c:	4698      	mov	r8, r3
c0d0380e:	4447      	add	r7, r8
c0d03810:	4663      	mov	r3, ip
c0d03812:	0c25      	lsrs	r5, r4, #16
c0d03814:	19ef      	adds	r7, r5, r7
c0d03816:	041d      	lsls	r5, r3, #16
c0d03818:	464b      	mov	r3, r9
c0d0381a:	434a      	muls	r2, r1
c0d0381c:	4343      	muls	r3, r0
c0d0381e:	0c2d      	lsrs	r5, r5, #16
c0d03820:	0424      	lsls	r4, r4, #16
c0d03822:	1964      	adds	r4, r4, r5
c0d03824:	1899      	adds	r1, r3, r2
c0d03826:	19c9      	adds	r1, r1, r7
c0d03828:	0020      	movs	r0, r4
c0d0382a:	bc0c      	pop	{r2, r3}
c0d0382c:	4690      	mov	r8, r2
c0d0382e:	4699      	mov	r9, r3
c0d03830:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03832:	46c0      	nop			; (mov r8, r8)

c0d03834 <__udivmoddi4>:
c0d03834:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03836:	464d      	mov	r5, r9
c0d03838:	4656      	mov	r6, sl
c0d0383a:	4644      	mov	r4, r8
c0d0383c:	465f      	mov	r7, fp
c0d0383e:	b4f0      	push	{r4, r5, r6, r7}
c0d03840:	4692      	mov	sl, r2
c0d03842:	b083      	sub	sp, #12
c0d03844:	0004      	movs	r4, r0
c0d03846:	000d      	movs	r5, r1
c0d03848:	4699      	mov	r9, r3
c0d0384a:	428b      	cmp	r3, r1
c0d0384c:	d82f      	bhi.n	c0d038ae <__udivmoddi4+0x7a>
c0d0384e:	d02c      	beq.n	c0d038aa <__udivmoddi4+0x76>
c0d03850:	4649      	mov	r1, r9
c0d03852:	4650      	mov	r0, sl
c0d03854:	f000 f8ae 	bl	c0d039b4 <__clzdi2>
c0d03858:	0029      	movs	r1, r5
c0d0385a:	0006      	movs	r6, r0
c0d0385c:	0020      	movs	r0, r4
c0d0385e:	f000 f8a9 	bl	c0d039b4 <__clzdi2>
c0d03862:	1a33      	subs	r3, r6, r0
c0d03864:	4698      	mov	r8, r3
c0d03866:	3b20      	subs	r3, #32
c0d03868:	469b      	mov	fp, r3
c0d0386a:	d500      	bpl.n	c0d0386e <__udivmoddi4+0x3a>
c0d0386c:	e074      	b.n	c0d03958 <__udivmoddi4+0x124>
c0d0386e:	4653      	mov	r3, sl
c0d03870:	465a      	mov	r2, fp
c0d03872:	4093      	lsls	r3, r2
c0d03874:	001f      	movs	r7, r3
c0d03876:	4653      	mov	r3, sl
c0d03878:	4642      	mov	r2, r8
c0d0387a:	4093      	lsls	r3, r2
c0d0387c:	001e      	movs	r6, r3
c0d0387e:	42af      	cmp	r7, r5
c0d03880:	d829      	bhi.n	c0d038d6 <__udivmoddi4+0xa2>
c0d03882:	d026      	beq.n	c0d038d2 <__udivmoddi4+0x9e>
c0d03884:	465b      	mov	r3, fp
c0d03886:	1ba4      	subs	r4, r4, r6
c0d03888:	41bd      	sbcs	r5, r7
c0d0388a:	2b00      	cmp	r3, #0
c0d0388c:	da00      	bge.n	c0d03890 <__udivmoddi4+0x5c>
c0d0388e:	e079      	b.n	c0d03984 <__udivmoddi4+0x150>
c0d03890:	2200      	movs	r2, #0
c0d03892:	2300      	movs	r3, #0
c0d03894:	9200      	str	r2, [sp, #0]
c0d03896:	9301      	str	r3, [sp, #4]
c0d03898:	2301      	movs	r3, #1
c0d0389a:	465a      	mov	r2, fp
c0d0389c:	4093      	lsls	r3, r2
c0d0389e:	9301      	str	r3, [sp, #4]
c0d038a0:	2301      	movs	r3, #1
c0d038a2:	4642      	mov	r2, r8
c0d038a4:	4093      	lsls	r3, r2
c0d038a6:	9300      	str	r3, [sp, #0]
c0d038a8:	e019      	b.n	c0d038de <__udivmoddi4+0xaa>
c0d038aa:	4282      	cmp	r2, r0
c0d038ac:	d9d0      	bls.n	c0d03850 <__udivmoddi4+0x1c>
c0d038ae:	2200      	movs	r2, #0
c0d038b0:	2300      	movs	r3, #0
c0d038b2:	9200      	str	r2, [sp, #0]
c0d038b4:	9301      	str	r3, [sp, #4]
c0d038b6:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d038b8:	2b00      	cmp	r3, #0
c0d038ba:	d001      	beq.n	c0d038c0 <__udivmoddi4+0x8c>
c0d038bc:	601c      	str	r4, [r3, #0]
c0d038be:	605d      	str	r5, [r3, #4]
c0d038c0:	9800      	ldr	r0, [sp, #0]
c0d038c2:	9901      	ldr	r1, [sp, #4]
c0d038c4:	b003      	add	sp, #12
c0d038c6:	bc3c      	pop	{r2, r3, r4, r5}
c0d038c8:	4690      	mov	r8, r2
c0d038ca:	4699      	mov	r9, r3
c0d038cc:	46a2      	mov	sl, r4
c0d038ce:	46ab      	mov	fp, r5
c0d038d0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d038d2:	42a3      	cmp	r3, r4
c0d038d4:	d9d6      	bls.n	c0d03884 <__udivmoddi4+0x50>
c0d038d6:	2200      	movs	r2, #0
c0d038d8:	2300      	movs	r3, #0
c0d038da:	9200      	str	r2, [sp, #0]
c0d038dc:	9301      	str	r3, [sp, #4]
c0d038de:	4643      	mov	r3, r8
c0d038e0:	2b00      	cmp	r3, #0
c0d038e2:	d0e8      	beq.n	c0d038b6 <__udivmoddi4+0x82>
c0d038e4:	07fb      	lsls	r3, r7, #31
c0d038e6:	0872      	lsrs	r2, r6, #1
c0d038e8:	431a      	orrs	r2, r3
c0d038ea:	4646      	mov	r6, r8
c0d038ec:	087b      	lsrs	r3, r7, #1
c0d038ee:	e00e      	b.n	c0d0390e <__udivmoddi4+0xda>
c0d038f0:	42ab      	cmp	r3, r5
c0d038f2:	d101      	bne.n	c0d038f8 <__udivmoddi4+0xc4>
c0d038f4:	42a2      	cmp	r2, r4
c0d038f6:	d80c      	bhi.n	c0d03912 <__udivmoddi4+0xde>
c0d038f8:	1aa4      	subs	r4, r4, r2
c0d038fa:	419d      	sbcs	r5, r3
c0d038fc:	2001      	movs	r0, #1
c0d038fe:	1924      	adds	r4, r4, r4
c0d03900:	416d      	adcs	r5, r5
c0d03902:	2100      	movs	r1, #0
c0d03904:	3e01      	subs	r6, #1
c0d03906:	1824      	adds	r4, r4, r0
c0d03908:	414d      	adcs	r5, r1
c0d0390a:	2e00      	cmp	r6, #0
c0d0390c:	d006      	beq.n	c0d0391c <__udivmoddi4+0xe8>
c0d0390e:	42ab      	cmp	r3, r5
c0d03910:	d9ee      	bls.n	c0d038f0 <__udivmoddi4+0xbc>
c0d03912:	3e01      	subs	r6, #1
c0d03914:	1924      	adds	r4, r4, r4
c0d03916:	416d      	adcs	r5, r5
c0d03918:	2e00      	cmp	r6, #0
c0d0391a:	d1f8      	bne.n	c0d0390e <__udivmoddi4+0xda>
c0d0391c:	465b      	mov	r3, fp
c0d0391e:	9800      	ldr	r0, [sp, #0]
c0d03920:	9901      	ldr	r1, [sp, #4]
c0d03922:	1900      	adds	r0, r0, r4
c0d03924:	4169      	adcs	r1, r5
c0d03926:	2b00      	cmp	r3, #0
c0d03928:	db22      	blt.n	c0d03970 <__udivmoddi4+0x13c>
c0d0392a:	002b      	movs	r3, r5
c0d0392c:	465a      	mov	r2, fp
c0d0392e:	40d3      	lsrs	r3, r2
c0d03930:	002a      	movs	r2, r5
c0d03932:	4644      	mov	r4, r8
c0d03934:	40e2      	lsrs	r2, r4
c0d03936:	001c      	movs	r4, r3
c0d03938:	465b      	mov	r3, fp
c0d0393a:	0015      	movs	r5, r2
c0d0393c:	2b00      	cmp	r3, #0
c0d0393e:	db2c      	blt.n	c0d0399a <__udivmoddi4+0x166>
c0d03940:	0026      	movs	r6, r4
c0d03942:	409e      	lsls	r6, r3
c0d03944:	0033      	movs	r3, r6
c0d03946:	0026      	movs	r6, r4
c0d03948:	4647      	mov	r7, r8
c0d0394a:	40be      	lsls	r6, r7
c0d0394c:	0032      	movs	r2, r6
c0d0394e:	1a80      	subs	r0, r0, r2
c0d03950:	4199      	sbcs	r1, r3
c0d03952:	9000      	str	r0, [sp, #0]
c0d03954:	9101      	str	r1, [sp, #4]
c0d03956:	e7ae      	b.n	c0d038b6 <__udivmoddi4+0x82>
c0d03958:	4642      	mov	r2, r8
c0d0395a:	2320      	movs	r3, #32
c0d0395c:	1a9b      	subs	r3, r3, r2
c0d0395e:	4652      	mov	r2, sl
c0d03960:	40da      	lsrs	r2, r3
c0d03962:	4641      	mov	r1, r8
c0d03964:	0013      	movs	r3, r2
c0d03966:	464a      	mov	r2, r9
c0d03968:	408a      	lsls	r2, r1
c0d0396a:	0017      	movs	r7, r2
c0d0396c:	431f      	orrs	r7, r3
c0d0396e:	e782      	b.n	c0d03876 <__udivmoddi4+0x42>
c0d03970:	4642      	mov	r2, r8
c0d03972:	2320      	movs	r3, #32
c0d03974:	1a9b      	subs	r3, r3, r2
c0d03976:	002a      	movs	r2, r5
c0d03978:	4646      	mov	r6, r8
c0d0397a:	409a      	lsls	r2, r3
c0d0397c:	0023      	movs	r3, r4
c0d0397e:	40f3      	lsrs	r3, r6
c0d03980:	4313      	orrs	r3, r2
c0d03982:	e7d5      	b.n	c0d03930 <__udivmoddi4+0xfc>
c0d03984:	4642      	mov	r2, r8
c0d03986:	2320      	movs	r3, #32
c0d03988:	2100      	movs	r1, #0
c0d0398a:	1a9b      	subs	r3, r3, r2
c0d0398c:	2200      	movs	r2, #0
c0d0398e:	9100      	str	r1, [sp, #0]
c0d03990:	9201      	str	r2, [sp, #4]
c0d03992:	2201      	movs	r2, #1
c0d03994:	40da      	lsrs	r2, r3
c0d03996:	9201      	str	r2, [sp, #4]
c0d03998:	e782      	b.n	c0d038a0 <__udivmoddi4+0x6c>
c0d0399a:	4642      	mov	r2, r8
c0d0399c:	2320      	movs	r3, #32
c0d0399e:	0026      	movs	r6, r4
c0d039a0:	1a9b      	subs	r3, r3, r2
c0d039a2:	40de      	lsrs	r6, r3
c0d039a4:	002f      	movs	r7, r5
c0d039a6:	46b4      	mov	ip, r6
c0d039a8:	4097      	lsls	r7, r2
c0d039aa:	4666      	mov	r6, ip
c0d039ac:	003b      	movs	r3, r7
c0d039ae:	4333      	orrs	r3, r6
c0d039b0:	e7c9      	b.n	c0d03946 <__udivmoddi4+0x112>
c0d039b2:	46c0      	nop			; (mov r8, r8)

c0d039b4 <__clzdi2>:
c0d039b4:	b510      	push	{r4, lr}
c0d039b6:	2900      	cmp	r1, #0
c0d039b8:	d103      	bne.n	c0d039c2 <__clzdi2+0xe>
c0d039ba:	f000 f807 	bl	c0d039cc <__clzsi2>
c0d039be:	3020      	adds	r0, #32
c0d039c0:	e002      	b.n	c0d039c8 <__clzdi2+0x14>
c0d039c2:	1c08      	adds	r0, r1, #0
c0d039c4:	f000 f802 	bl	c0d039cc <__clzsi2>
c0d039c8:	bd10      	pop	{r4, pc}
c0d039ca:	46c0      	nop			; (mov r8, r8)

c0d039cc <__clzsi2>:
c0d039cc:	211c      	movs	r1, #28
c0d039ce:	2301      	movs	r3, #1
c0d039d0:	041b      	lsls	r3, r3, #16
c0d039d2:	4298      	cmp	r0, r3
c0d039d4:	d301      	bcc.n	c0d039da <__clzsi2+0xe>
c0d039d6:	0c00      	lsrs	r0, r0, #16
c0d039d8:	3910      	subs	r1, #16
c0d039da:	0a1b      	lsrs	r3, r3, #8
c0d039dc:	4298      	cmp	r0, r3
c0d039de:	d301      	bcc.n	c0d039e4 <__clzsi2+0x18>
c0d039e0:	0a00      	lsrs	r0, r0, #8
c0d039e2:	3908      	subs	r1, #8
c0d039e4:	091b      	lsrs	r3, r3, #4
c0d039e6:	4298      	cmp	r0, r3
c0d039e8:	d301      	bcc.n	c0d039ee <__clzsi2+0x22>
c0d039ea:	0900      	lsrs	r0, r0, #4
c0d039ec:	3904      	subs	r1, #4
c0d039ee:	a202      	add	r2, pc, #8	; (adr r2, c0d039f8 <__clzsi2+0x2c>)
c0d039f0:	5c10      	ldrb	r0, [r2, r0]
c0d039f2:	1840      	adds	r0, r0, r1
c0d039f4:	4770      	bx	lr
c0d039f6:	46c0      	nop			; (mov r8, r8)
c0d039f8:	02020304 	.word	0x02020304
c0d039fc:	01010101 	.word	0x01010101
	...

c0d03a08 <__aeabi_memclr>:
c0d03a08:	b510      	push	{r4, lr}
c0d03a0a:	2200      	movs	r2, #0
c0d03a0c:	f000 f806 	bl	c0d03a1c <__aeabi_memset>
c0d03a10:	bd10      	pop	{r4, pc}
c0d03a12:	46c0      	nop			; (mov r8, r8)

c0d03a14 <__aeabi_memcpy>:
c0d03a14:	b510      	push	{r4, lr}
c0d03a16:	f000 f809 	bl	c0d03a2c <memcpy>
c0d03a1a:	bd10      	pop	{r4, pc}

c0d03a1c <__aeabi_memset>:
c0d03a1c:	0013      	movs	r3, r2
c0d03a1e:	b510      	push	{r4, lr}
c0d03a20:	000a      	movs	r2, r1
c0d03a22:	0019      	movs	r1, r3
c0d03a24:	f000 f840 	bl	c0d03aa8 <memset>
c0d03a28:	bd10      	pop	{r4, pc}
c0d03a2a:	46c0      	nop			; (mov r8, r8)

c0d03a2c <memcpy>:
c0d03a2c:	b570      	push	{r4, r5, r6, lr}
c0d03a2e:	2a0f      	cmp	r2, #15
c0d03a30:	d932      	bls.n	c0d03a98 <memcpy+0x6c>
c0d03a32:	000c      	movs	r4, r1
c0d03a34:	4304      	orrs	r4, r0
c0d03a36:	000b      	movs	r3, r1
c0d03a38:	07a4      	lsls	r4, r4, #30
c0d03a3a:	d131      	bne.n	c0d03aa0 <memcpy+0x74>
c0d03a3c:	0015      	movs	r5, r2
c0d03a3e:	0004      	movs	r4, r0
c0d03a40:	3d10      	subs	r5, #16
c0d03a42:	092d      	lsrs	r5, r5, #4
c0d03a44:	3501      	adds	r5, #1
c0d03a46:	012d      	lsls	r5, r5, #4
c0d03a48:	1949      	adds	r1, r1, r5
c0d03a4a:	681e      	ldr	r6, [r3, #0]
c0d03a4c:	6026      	str	r6, [r4, #0]
c0d03a4e:	685e      	ldr	r6, [r3, #4]
c0d03a50:	6066      	str	r6, [r4, #4]
c0d03a52:	689e      	ldr	r6, [r3, #8]
c0d03a54:	60a6      	str	r6, [r4, #8]
c0d03a56:	68de      	ldr	r6, [r3, #12]
c0d03a58:	3310      	adds	r3, #16
c0d03a5a:	60e6      	str	r6, [r4, #12]
c0d03a5c:	3410      	adds	r4, #16
c0d03a5e:	4299      	cmp	r1, r3
c0d03a60:	d1f3      	bne.n	c0d03a4a <memcpy+0x1e>
c0d03a62:	230f      	movs	r3, #15
c0d03a64:	1945      	adds	r5, r0, r5
c0d03a66:	4013      	ands	r3, r2
c0d03a68:	2b03      	cmp	r3, #3
c0d03a6a:	d91b      	bls.n	c0d03aa4 <memcpy+0x78>
c0d03a6c:	1f1c      	subs	r4, r3, #4
c0d03a6e:	2300      	movs	r3, #0
c0d03a70:	08a4      	lsrs	r4, r4, #2
c0d03a72:	3401      	adds	r4, #1
c0d03a74:	00a4      	lsls	r4, r4, #2
c0d03a76:	58ce      	ldr	r6, [r1, r3]
c0d03a78:	50ee      	str	r6, [r5, r3]
c0d03a7a:	3304      	adds	r3, #4
c0d03a7c:	429c      	cmp	r4, r3
c0d03a7e:	d1fa      	bne.n	c0d03a76 <memcpy+0x4a>
c0d03a80:	2303      	movs	r3, #3
c0d03a82:	192d      	adds	r5, r5, r4
c0d03a84:	1909      	adds	r1, r1, r4
c0d03a86:	401a      	ands	r2, r3
c0d03a88:	d005      	beq.n	c0d03a96 <memcpy+0x6a>
c0d03a8a:	2300      	movs	r3, #0
c0d03a8c:	5ccc      	ldrb	r4, [r1, r3]
c0d03a8e:	54ec      	strb	r4, [r5, r3]
c0d03a90:	3301      	adds	r3, #1
c0d03a92:	429a      	cmp	r2, r3
c0d03a94:	d1fa      	bne.n	c0d03a8c <memcpy+0x60>
c0d03a96:	bd70      	pop	{r4, r5, r6, pc}
c0d03a98:	0005      	movs	r5, r0
c0d03a9a:	2a00      	cmp	r2, #0
c0d03a9c:	d1f5      	bne.n	c0d03a8a <memcpy+0x5e>
c0d03a9e:	e7fa      	b.n	c0d03a96 <memcpy+0x6a>
c0d03aa0:	0005      	movs	r5, r0
c0d03aa2:	e7f2      	b.n	c0d03a8a <memcpy+0x5e>
c0d03aa4:	001a      	movs	r2, r3
c0d03aa6:	e7f8      	b.n	c0d03a9a <memcpy+0x6e>

c0d03aa8 <memset>:
c0d03aa8:	b570      	push	{r4, r5, r6, lr}
c0d03aaa:	0783      	lsls	r3, r0, #30
c0d03aac:	d03f      	beq.n	c0d03b2e <memset+0x86>
c0d03aae:	1e54      	subs	r4, r2, #1
c0d03ab0:	2a00      	cmp	r2, #0
c0d03ab2:	d03b      	beq.n	c0d03b2c <memset+0x84>
c0d03ab4:	b2ce      	uxtb	r6, r1
c0d03ab6:	0003      	movs	r3, r0
c0d03ab8:	2503      	movs	r5, #3
c0d03aba:	e003      	b.n	c0d03ac4 <memset+0x1c>
c0d03abc:	1e62      	subs	r2, r4, #1
c0d03abe:	2c00      	cmp	r4, #0
c0d03ac0:	d034      	beq.n	c0d03b2c <memset+0x84>
c0d03ac2:	0014      	movs	r4, r2
c0d03ac4:	3301      	adds	r3, #1
c0d03ac6:	1e5a      	subs	r2, r3, #1
c0d03ac8:	7016      	strb	r6, [r2, #0]
c0d03aca:	422b      	tst	r3, r5
c0d03acc:	d1f6      	bne.n	c0d03abc <memset+0x14>
c0d03ace:	2c03      	cmp	r4, #3
c0d03ad0:	d924      	bls.n	c0d03b1c <memset+0x74>
c0d03ad2:	25ff      	movs	r5, #255	; 0xff
c0d03ad4:	400d      	ands	r5, r1
c0d03ad6:	022a      	lsls	r2, r5, #8
c0d03ad8:	4315      	orrs	r5, r2
c0d03ada:	042a      	lsls	r2, r5, #16
c0d03adc:	4315      	orrs	r5, r2
c0d03ade:	2c0f      	cmp	r4, #15
c0d03ae0:	d911      	bls.n	c0d03b06 <memset+0x5e>
c0d03ae2:	0026      	movs	r6, r4
c0d03ae4:	3e10      	subs	r6, #16
c0d03ae6:	0936      	lsrs	r6, r6, #4
c0d03ae8:	3601      	adds	r6, #1
c0d03aea:	0136      	lsls	r6, r6, #4
c0d03aec:	001a      	movs	r2, r3
c0d03aee:	199b      	adds	r3, r3, r6
c0d03af0:	6015      	str	r5, [r2, #0]
c0d03af2:	6055      	str	r5, [r2, #4]
c0d03af4:	6095      	str	r5, [r2, #8]
c0d03af6:	60d5      	str	r5, [r2, #12]
c0d03af8:	3210      	adds	r2, #16
c0d03afa:	4293      	cmp	r3, r2
c0d03afc:	d1f8      	bne.n	c0d03af0 <memset+0x48>
c0d03afe:	220f      	movs	r2, #15
c0d03b00:	4014      	ands	r4, r2
c0d03b02:	2c03      	cmp	r4, #3
c0d03b04:	d90a      	bls.n	c0d03b1c <memset+0x74>
c0d03b06:	1f26      	subs	r6, r4, #4
c0d03b08:	08b6      	lsrs	r6, r6, #2
c0d03b0a:	3601      	adds	r6, #1
c0d03b0c:	00b6      	lsls	r6, r6, #2
c0d03b0e:	001a      	movs	r2, r3
c0d03b10:	199b      	adds	r3, r3, r6
c0d03b12:	c220      	stmia	r2!, {r5}
c0d03b14:	4293      	cmp	r3, r2
c0d03b16:	d1fc      	bne.n	c0d03b12 <memset+0x6a>
c0d03b18:	2203      	movs	r2, #3
c0d03b1a:	4014      	ands	r4, r2
c0d03b1c:	2c00      	cmp	r4, #0
c0d03b1e:	d005      	beq.n	c0d03b2c <memset+0x84>
c0d03b20:	b2c9      	uxtb	r1, r1
c0d03b22:	191c      	adds	r4, r3, r4
c0d03b24:	7019      	strb	r1, [r3, #0]
c0d03b26:	3301      	adds	r3, #1
c0d03b28:	429c      	cmp	r4, r3
c0d03b2a:	d1fb      	bne.n	c0d03b24 <memset+0x7c>
c0d03b2c:	bd70      	pop	{r4, r5, r6, pc}
c0d03b2e:	0014      	movs	r4, r2
c0d03b30:	0003      	movs	r3, r0
c0d03b32:	e7cc      	b.n	c0d03ace <memset+0x26>

c0d03b34 <setjmp>:
c0d03b34:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03b36:	4641      	mov	r1, r8
c0d03b38:	464a      	mov	r2, r9
c0d03b3a:	4653      	mov	r3, sl
c0d03b3c:	465c      	mov	r4, fp
c0d03b3e:	466d      	mov	r5, sp
c0d03b40:	4676      	mov	r6, lr
c0d03b42:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03b44:	3828      	subs	r0, #40	; 0x28
c0d03b46:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b48:	2000      	movs	r0, #0
c0d03b4a:	4770      	bx	lr

c0d03b4c <longjmp>:
c0d03b4c:	3010      	adds	r0, #16
c0d03b4e:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03b50:	4690      	mov	r8, r2
c0d03b52:	4699      	mov	r9, r3
c0d03b54:	46a2      	mov	sl, r4
c0d03b56:	46ab      	mov	fp, r5
c0d03b58:	46b5      	mov	sp, r6
c0d03b5a:	c808      	ldmia	r0!, {r3}
c0d03b5c:	3828      	subs	r0, #40	; 0x28
c0d03b5e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b60:	1c08      	adds	r0, r1, #0
c0d03b62:	d100      	bne.n	c0d03b66 <longjmp+0x1a>
c0d03b64:	2001      	movs	r0, #1
c0d03b66:	4718      	bx	r3

c0d03b68 <strlen>:
c0d03b68:	b510      	push	{r4, lr}
c0d03b6a:	0783      	lsls	r3, r0, #30
c0d03b6c:	d027      	beq.n	c0d03bbe <strlen+0x56>
c0d03b6e:	7803      	ldrb	r3, [r0, #0]
c0d03b70:	2b00      	cmp	r3, #0
c0d03b72:	d026      	beq.n	c0d03bc2 <strlen+0x5a>
c0d03b74:	0003      	movs	r3, r0
c0d03b76:	2103      	movs	r1, #3
c0d03b78:	e002      	b.n	c0d03b80 <strlen+0x18>
c0d03b7a:	781a      	ldrb	r2, [r3, #0]
c0d03b7c:	2a00      	cmp	r2, #0
c0d03b7e:	d01c      	beq.n	c0d03bba <strlen+0x52>
c0d03b80:	3301      	adds	r3, #1
c0d03b82:	420b      	tst	r3, r1
c0d03b84:	d1f9      	bne.n	c0d03b7a <strlen+0x12>
c0d03b86:	6819      	ldr	r1, [r3, #0]
c0d03b88:	4a0f      	ldr	r2, [pc, #60]	; (c0d03bc8 <strlen+0x60>)
c0d03b8a:	4c10      	ldr	r4, [pc, #64]	; (c0d03bcc <strlen+0x64>)
c0d03b8c:	188a      	adds	r2, r1, r2
c0d03b8e:	438a      	bics	r2, r1
c0d03b90:	4222      	tst	r2, r4
c0d03b92:	d10f      	bne.n	c0d03bb4 <strlen+0x4c>
c0d03b94:	3304      	adds	r3, #4
c0d03b96:	6819      	ldr	r1, [r3, #0]
c0d03b98:	4a0b      	ldr	r2, [pc, #44]	; (c0d03bc8 <strlen+0x60>)
c0d03b9a:	188a      	adds	r2, r1, r2
c0d03b9c:	438a      	bics	r2, r1
c0d03b9e:	4222      	tst	r2, r4
c0d03ba0:	d108      	bne.n	c0d03bb4 <strlen+0x4c>
c0d03ba2:	3304      	adds	r3, #4
c0d03ba4:	6819      	ldr	r1, [r3, #0]
c0d03ba6:	4a08      	ldr	r2, [pc, #32]	; (c0d03bc8 <strlen+0x60>)
c0d03ba8:	188a      	adds	r2, r1, r2
c0d03baa:	438a      	bics	r2, r1
c0d03bac:	4222      	tst	r2, r4
c0d03bae:	d0f1      	beq.n	c0d03b94 <strlen+0x2c>
c0d03bb0:	e000      	b.n	c0d03bb4 <strlen+0x4c>
c0d03bb2:	3301      	adds	r3, #1
c0d03bb4:	781a      	ldrb	r2, [r3, #0]
c0d03bb6:	2a00      	cmp	r2, #0
c0d03bb8:	d1fb      	bne.n	c0d03bb2 <strlen+0x4a>
c0d03bba:	1a18      	subs	r0, r3, r0
c0d03bbc:	bd10      	pop	{r4, pc}
c0d03bbe:	0003      	movs	r3, r0
c0d03bc0:	e7e1      	b.n	c0d03b86 <strlen+0x1e>
c0d03bc2:	2000      	movs	r0, #0
c0d03bc4:	e7fa      	b.n	c0d03bbc <strlen+0x54>
c0d03bc6:	46c0      	nop			; (mov r8, r8)
c0d03bc8:	fefefeff 	.word	0xfefefeff
c0d03bcc:	80808080 	.word	0x80808080
c0d03bd0:	45544550 	.word	0x45544550
c0d03bd4:	54455052 	.word	0x54455052
c0d03bd8:	45505245 	.word	0x45505245
c0d03bdc:	50524554 	.word	0x50524554
c0d03be0:	52455445 	.word	0x52455445
c0d03be4:	45544550 	.word	0x45544550
c0d03be8:	54455052 	.word	0x54455052
c0d03bec:	45505245 	.word	0x45505245
c0d03bf0:	50524554 	.word	0x50524554
c0d03bf4:	52455445 	.word	0x52455445
c0d03bf8:	45544550 	.word	0x45544550
c0d03bfc:	54455052 	.word	0x54455052
c0d03c00:	45505245 	.word	0x45505245
c0d03c04:	50524554 	.word	0x50524554
c0d03c08:	52455445 	.word	0x52455445
c0d03c0c:	45544550 	.word	0x45544550
c0d03c10:	54455052 	.word	0x54455052
c0d03c14:	45505245 	.word	0x45505245
c0d03c18:	50524554 	.word	0x50524554
c0d03c1c:	52455445 	.word	0x52455445
c0d03c20:	00000052 	.word	0x00000052

c0d03c24 <trits_mapping>:
c0d03c24:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03c34:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03c44:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03c54:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03c64:	00000100 01000101 000101ff 01010101     ................
c0d03c74:	00000001                                ....

c0d03c78 <HALF_3_u>:
c0d03c78:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d03c88:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d03c98:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d03ca8 <bagl_ui_nanos_screen1>:
c0d03ca8:	00000003 00800000 00000020 00000001     ........ .......
c0d03cb8:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03ce0:	00000107 0080000c 00000020 00000000     ........ .......
c0d03cf0:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03d18:	00030005 0007000c 00000007 00000000     ................
	...
c0d03d30:	00070000 00000000 00000000 00000000     ................
	...
c0d03d50:	00750005 0008000d 00000006 00000000     ..u.............
c0d03d60:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03d88 <bagl_ui_nanos_screen2>:
c0d03d88:	00000003 00800000 00000020 00000001     ........ .......
c0d03d98:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03dc0:	00000107 00800012 00000020 00000000     ........ .......
c0d03dd0:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03df8:	00030005 0007000c 00000007 00000000     ................
	...
c0d03e10:	00070000 00000000 00000000 00000000     ................
	...
c0d03e30:	00750005 0008000d 00000006 00000000     ..u.............
c0d03e40:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03e68 <bagl_ui_sample_blue>:
c0d03e68:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03e78:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03ea0:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03eb0:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03ed8:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03ee8:	00ffffff 001d2028 00002004 c0d03f48     ....( ... ..H?..
	...
c0d03f10:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03f20:	0041ccb4 00f9f9f9 0000a004 c0d03f54     ..A.........T?..
c0d03f30:	00000000 0037ae99 00f9f9f9 c0d02781     ......7......'..
	...
c0d03f48:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03f59 <USBD_PRODUCT_FS_STRING>:
c0d03f59:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03f67 <HID_ReportDesc>:
c0d03f67:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03f77:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03f87:	0000c008 11210900                                .....

c0d03f8c <USBD_HID_Desc>:
c0d03f8c:	01112109 22220100 00011200                       .!...."".

c0d03f95 <USBD_DeviceDesc>:
c0d03f95:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03fa5:	91000103                                         ...

c0d03fa8 <HID_Desc>:
c0d03fa8:	c0d03391 c0d033a1 c0d033b1 c0d033c1     .3...3...3...3..
c0d03fb8:	c0d033d1 c0d033e1 c0d033f1 00000000     .3...3...3......

c0d03fc8 <USBD_LangIDDesc>:
c0d03fc8:	04090304                                ....

c0d03fcc <USBD_MANUFACTURER_STRING>:
c0d03fcc:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03fda <USB_SERIAL_STRING>:
c0d03fda:	0030030a 00300030 32730031                       ..0.0.0.1.

c0d03fe4 <USBD_HID>:
c0d03fe4:	c0d03273 c0d032a5 c0d031d7 00000000     s2...2...1......
	...
c0d03ffc:	c0d032dd 00000000 00000000 00000000     .2..............
c0d0400c:	c0d03401 c0d03401 c0d03401 c0d03411     .4...4...4...4..

c0d0401c <USBD_CfgDesc>:
c0d0401c:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d0402c:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d0403c:	05070100 00400302 00000001              ......@.....

c0d04048 <USBD_DeviceQualifierDesc>:
c0d04048:	0200060a 40000000 00000001              .......@....

c0d04054 <_etext>:
	...

c0d04080 <N_storage_real>:
	...
