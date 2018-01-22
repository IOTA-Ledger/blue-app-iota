
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
c0d00014:	f001 f98e 	bl	c0d01334 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f8da 	bl	c0d011d0 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fd6b 	bl	c0d03b00 <setjmp>
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
c0d00040:	f001 fb1e 	bl	c0d01680 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 ffff 	bl	c0d02048 <pic>
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
c0d0005a:	f001 fff5 	bl	c0d02048 <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f002 f843 	bl	c0d020ec <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f94a 	bl	c0d03300 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f947 	bl	c0d03300 <USB_power>

            ui_idle();
c0d00072:	f002 fadb 	bl	c0d0262c <ui_idle>

            IOTA_main();
c0d00076:	f000 ff43 	bl	c0d00f00 <IOTA_main>
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
c0d0008c:	f003 fd44 	bl	c0d03b18 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d04040 	.word	0xc0d04040

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
c0d000ca:	f001 fd6d 	bl	c0d01ba8 <snprintf>
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
c0d001d0:	f003 f9de 	bl	c0d03590 <__aeabi_idiv>
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
c0d001fc:	f003 f93e 	bl	c0d0347c <__aeabi_uidiv>
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
c0d0022c:	f003 f9b0 	bl	c0d03590 <__aeabi_idiv>
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
c0d00262:	f003 f90b 	bl	c0d0347c <__aeabi_uidiv>
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
c0d0029e:	f003 f977 	bl	c0d03590 <__aeabi_idiv>
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
c0d002cc:	f003 f8d6 	bl	c0d0347c <__aeabi_uidiv>
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
c0d002f2:	f000 fbdd 	bl	c0d00ab0 <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d002f6:	f000 fbdb 	bl	c0d00ab0 <kerl_initialize>
c0d002fa:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d002fc:	4630      	mov	r0, r6
c0d002fe:	4621      	mov	r1, r4
c0d00300:	462a      	mov	r2, r5
c0d00302:	f003 fb6d 	bl	c0d039e0 <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d00306:	1970      	adds	r0, r6, r5
c0d00308:	2430      	movs	r4, #48	; 0x30
c0d0030a:	1b62      	subs	r2, r4, r5
c0d0030c:	9902      	ldr	r1, [sp, #8]
c0d0030e:	f003 fb67 	bl	c0d039e0 <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00312:	4630      	mov	r0, r6
c0d00314:	4621      	mov	r1, r4
c0d00316:	f000 fbd7 	bl	c0d00ac8 <kerl_absorb_bytes>
c0d0031a:	ae41      	add	r6, sp, #260	; 0x104
c0d0031c:	2151      	movs	r1, #81	; 0x51
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d0031e:	4630      	mov	r0, r6
c0d00320:	9601      	str	r6, [sp, #4]
c0d00322:	460d      	mov	r5, r1
c0d00324:	f003 fb56 	bl	c0d039d4 <__aeabi_memclr>
c0d00328:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0032a:	4921      	ldr	r1, [pc, #132]	; (c0d003b0 <get_seed+0xcc>)
c0d0032c:	4479      	add	r1, pc
c0d0032e:	2252      	movs	r2, #82	; 0x52
c0d00330:	4620      	mov	r0, r4
c0d00332:	f003 fb55 	bl	c0d039e0 <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d00336:	4620      	mov	r0, r4
c0d00338:	4631      	mov	r1, r6
c0d0033a:	462c      	mov	r4, r5
c0d0033c:	9402      	str	r4, [sp, #8]
c0d0033e:	4622      	mov	r2, r4
c0d00340:	f000 fa0a 	bl	c0d00758 <chars_to_trytes>
c0d00344:	ad04      	add	r5, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00346:	21f3      	movs	r1, #243	; 0xf3
c0d00348:	9100      	str	r1, [sp, #0]
c0d0034a:	4628      	mov	r0, r5
c0d0034c:	f003 fb42 	bl	c0d039d4 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d00350:	4630      	mov	r0, r6
c0d00352:	4629      	mov	r1, r5
c0d00354:	4622      	mov	r2, r4
c0d00356:	f000 f9e1 	bl	c0d0071c <trytes_to_trits>
c0d0035a:	ac56      	add	r4, sp, #344	; 0x158
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d0035c:	4628      	mov	r0, r5
c0d0035e:	4621      	mov	r1, r4
c0d00360:	f7ff febe 	bl	c0d000e0 <specific_243trits_to_49trints>
      }
      {
        kerl_initialize();
c0d00364:	f000 fba4 	bl	c0d00ab0 <kerl_initialize>
c0d00368:	2531      	movs	r5, #49	; 0x31
        kerl_absorb_trints(seed_trints, 49);
c0d0036a:	4620      	mov	r0, r4
c0d0036c:	4629      	mov	r1, r5
c0d0036e:	f000 fbbf 	bl	c0d00af0 <kerl_absorb_trints>
        kerl_squeeze_trints(seed_trints, 49);
c0d00372:	4620      	mov	r0, r4
c0d00374:	4629      	mov	r1, r5
c0d00376:	f000 fbef 	bl	c0d00b58 <kerl_squeeze_trints>
c0d0037a:	ad04      	add	r5, sp, #16
      //   memset(words, 0, sizeof(words));
      //   trints_to_words_u_mem(seed_trints, words);
      //   snprintf(msg, 81, "%u %u %u", words[0], words[1], words[2]);
      // }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d0037c:	4628      	mov	r0, r5
c0d0037e:	9e00      	ldr	r6, [sp, #0]
c0d00380:	4631      	mov	r1, r6
c0d00382:	f003 fb27 	bl	c0d039d4 <__aeabi_memclr>
        specific_49trints_to_243trits(seed_trints, seed_trits);
c0d00386:	4620      	mov	r0, r4
c0d00388:	4629      	mov	r1, r5
c0d0038a:	f7ff ff07 	bl	c0d0019c <specific_49trints_to_243trits>
        trits_to_trytes(seed_trits, seed_trytes, 243);
c0d0038e:	4628      	mov	r0, r5
c0d00390:	9c01      	ldr	r4, [sp, #4]
c0d00392:	4621      	mov	r1, r4
c0d00394:	4632      	mov	r2, r6
c0d00396:	f000 f98b 	bl	c0d006b0 <trits_to_trytes>
        trytes_to_chars(seed_trytes, msg, 81);
c0d0039a:	4620      	mov	r0, r4
c0d0039c:	9c03      	ldr	r4, [sp, #12]
c0d0039e:	4621      	mov	r1, r4
c0d003a0:	9d02      	ldr	r5, [sp, #8]
c0d003a2:	462a      	mov	r2, r5
c0d003a4:	f000 f9ee 	bl	c0d00784 <trytes_to_chars>
    //     specific_243trits_to_49trints(seed_trits, seed_trints);
    //   }
    // }

    {
      tryte_t seed_trytes[81] = {0};
c0d003a8:	2000      	movs	r0, #0
        specific_49trints_to_243trits(seed_trints, seed_trits);
        trits_to_trytes(seed_trits, seed_trytes, 243);
        trytes_to_chars(seed_trytes, msg, 81);
      }
      {
        msg[81] = '\0';
c0d003aa:	5560      	strb	r0, [r4, r5]
    //char seed_chars[82];
    //trytes_to_chars(seed_trytes, seed_chars, 81);

    //null terminate seed
    //seed_chars[81] = '\0';
}
c0d003ac:	b063      	add	sp, #396	; 0x18c
c0d003ae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d003b0:	0000386c 	.word	0x0000386c

c0d003b4 <bigint_add_intarr_u_mem>:
    }
    return i;
}*/

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
c0d003b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003b6:	af03      	add	r7, sp, #12
c0d003b8:	b087      	sub	sp, #28
c0d003ba:	2300      	movs	r3, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003bc:	2a00      	cmp	r2, #0
c0d003be:	d03b      	beq.n	c0d00438 <bigint_add_intarr_u_mem+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003c0:	2500      	movs	r5, #0
c0d003c2:	43ec      	mvns	r4, r5
c0d003c4:	9200      	str	r2, [sp, #0]
c0d003c6:	4613      	mov	r3, r2
c0d003c8:	9502      	str	r5, [sp, #8]
int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
c0d003ca:	9401      	str	r4, [sp, #4]
c0d003cc:	9304      	str	r3, [sp, #16]
c0d003ce:	9005      	str	r0, [sp, #20]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003d0:	6802      	ldr	r2, [r0, #0]
c0d003d2:	c908      	ldmia	r1!, {r3}
c0d003d4:	9106      	str	r1, [sp, #24]
c0d003d6:	1898      	adds	r0, r3, r2
c0d003d8:	9902      	ldr	r1, [sp, #8]
c0d003da:	460b      	mov	r3, r1
c0d003dc:	415b      	adcs	r3, r3
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d003de:	4602      	mov	r2, r0
c0d003e0:	4022      	ands	r2, r4
c0d003e2:	1c52      	adds	r2, r2, #1
c0d003e4:	4626      	mov	r6, r4
c0d003e6:	460c      	mov	r4, r1
c0d003e8:	4611      	mov	r1, r2
c0d003ea:	4164      	adcs	r4, r4
c0d003ec:	2201      	movs	r2, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d003ee:	4015      	ands	r5, r2
c0d003f0:	2d00      	cmp	r5, #0
c0d003f2:	d100      	bne.n	c0d003f6 <bigint_add_intarr_u_mem+0x42>
c0d003f4:	4601      	mov	r1, r0
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003f6:	42b1      	cmp	r1, r6
c0d003f8:	4616      	mov	r6, r2
c0d003fa:	d800      	bhi.n	c0d003fe <bigint_add_intarr_u_mem+0x4a>
c0d003fc:	9e02      	ldr	r6, [sp, #8]
c0d003fe:	9103      	str	r1, [sp, #12]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
c0d00400:	2d00      	cmp	r5, #0
c0d00402:	9805      	ldr	r0, [sp, #20]
c0d00404:	d100      	bne.n	c0d00408 <bigint_add_intarr_u_mem+0x54>
c0d00406:	461c      	mov	r4, r3
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00408:	2c00      	cmp	r4, #0
c0d0040a:	4611      	mov	r1, r2
c0d0040c:	d100      	bne.n	c0d00410 <bigint_add_intarr_u_mem+0x5c>
c0d0040e:	4621      	mov	r1, r4
c0d00410:	2c00      	cmp	r4, #0
c0d00412:	d000      	beq.n	c0d00416 <bigint_add_intarr_u_mem+0x62>
c0d00414:	460e      	mov	r6, r1
    struct int_bool_pair ret = { (uint32_t)r, carry1 || carry2 };
c0d00416:	431e      	orrs	r6, r3

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00418:	2e00      	cmp	r6, #0
c0d0041a:	9906      	ldr	r1, [sp, #24]
c0d0041c:	9c01      	ldr	r4, [sp, #4]
c0d0041e:	d100      	bne.n	c0d00422 <bigint_add_intarr_u_mem+0x6e>
c0d00420:	4632      	mov	r2, r6
        val = full_add_u(bigint_in[i], int_in[i], val.hi);
        bigint_in[i] = val.low;
c0d00422:	9b03      	ldr	r3, [sp, #12]
c0d00424:	c008      	stmia	r0!, {r3}
c0d00426:	9b04      	ldr	r3, [sp, #16]

int bigint_add_intarr_u_mem(uint32_t *bigint_in, uint32_t *int_in, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00428:	1e5b      	subs	r3, r3, #1
c0d0042a:	4615      	mov	r5, r2
c0d0042c:	d1ce      	bne.n	c0d003cc <bigint_add_intarr_u_mem+0x18>
c0d0042e:	2000      	movs	r0, #0
c0d00430:	43c3      	mvns	r3, r0
c0d00432:	2e00      	cmp	r6, #0
c0d00434:	d100      	bne.n	c0d00438 <bigint_add_intarr_u_mem+0x84>
c0d00436:	9b00      	ldr	r3, [sp, #0]

    if (val.hi) {
        return -1;
    }
    return len;
}
c0d00438:	4618      	mov	r0, r3
c0d0043a:	b007      	add	sp, #28
c0d0043c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0043e <bigint_add_int_u_mem>:
    return len;
}

//memory optimized for add in place
int bigint_add_int_u_mem(uint32_t *bigint_in, uint32_t int_in, uint8_t len)
{
c0d0043e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00440:	af03      	add	r7, sp, #12
c0d00442:	b083      	sub	sp, #12

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00444:	6803      	ldr	r3, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00446:	2600      	movs	r6, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00448:	1859      	adds	r1, r3, r1
c0d0044a:	4633      	mov	r3, r6
c0d0044c:	415b      	adcs	r3, r3
c0d0044e:	9001      	str	r0, [sp, #4]
{
    struct int_bool_pair val;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;
c0d00450:	6001      	str	r1, [r0, #0]
c0d00452:	2101      	movs	r1, #1
c0d00454:	2b00      	cmp	r3, #0
c0d00456:	d100      	bne.n	c0d0045a <bigint_add_int_u_mem+0x1c>
c0d00458:	4619      	mov	r1, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0045a:	43f0      	mvns	r0, r6

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d0045c:	9002      	str	r0, [sp, #8]
c0d0045e:	2a02      	cmp	r2, #2
c0d00460:	d31b      	bcc.n	c0d0049a <bigint_add_int_u_mem+0x5c>
c0d00462:	2301      	movs	r3, #1
c0d00464:	9200      	str	r2, [sp, #0]
        // only continue adding, if there is a carry bit
        if (!val.hi) {
c0d00466:	07c9      	lsls	r1, r1, #31
c0d00468:	d01d      	beq.n	c0d004a6 <bigint_add_int_u_mem+0x68>
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d0046a:	0099      	lsls	r1, r3, #2
c0d0046c:	9801      	ldr	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0046e:	5845      	ldr	r5, [r0, r1]
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00470:	1c6a      	adds	r2, r5, #1
c0d00472:	4634      	mov	r4, r6
c0d00474:	4176      	adcs	r6, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            return i;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
c0d00476:	5042      	str	r2, [r0, r1]
c0d00478:	2501      	movs	r5, #1
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0047a:	9802      	ldr	r0, [sp, #8]
c0d0047c:	4282      	cmp	r2, r0
c0d0047e:	4629      	mov	r1, r5
c0d00480:	d800      	bhi.n	c0d00484 <bigint_add_int_u_mem+0x46>
c0d00482:	4621      	mov	r1, r4
c0d00484:	2e00      	cmp	r6, #0
c0d00486:	d100      	bne.n	c0d0048a <bigint_add_int_u_mem+0x4c>
c0d00488:	4635      	mov	r5, r6
c0d0048a:	2e00      	cmp	r6, #0
c0d0048c:	d000      	beq.n	c0d00490 <bigint_add_int_u_mem+0x52>
c0d0048e:	4629      	mov	r1, r5

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_in[0] = val.low;

    for (uint8_t i = 1; i < len; i++) {
c0d00490:	1c5b      	adds	r3, r3, #1
c0d00492:	9a00      	ldr	r2, [sp, #0]
c0d00494:	4293      	cmp	r3, r2
c0d00496:	4626      	mov	r6, r4
c0d00498:	d3e5      	bcc.n	c0d00466 <bigint_add_int_u_mem+0x28>
        val = full_add_u(bigint_in[i], 0, true);
        bigint_in[i] = val.low;
    }

    // detect overflow
    if (val.hi) {
c0d0049a:	2900      	cmp	r1, #0
c0d0049c:	d100      	bne.n	c0d004a0 <bigint_add_int_u_mem+0x62>
c0d0049e:	9202      	str	r2, [sp, #8]
c0d004a0:	9802      	ldr	r0, [sp, #8]
c0d004a2:	b003      	add	sp, #12
c0d004a4:	bdf0      	pop	{r4, r5, r6, r7, pc}
        return -1;
    }
    return len;
}
c0d004a6:	4618      	mov	r0, r3
c0d004a8:	b003      	add	sp, #12
c0d004aa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004ac <bigint_add_int_u>:

int bigint_add_int_u(uint32_t bigint_in[], uint32_t int_in, uint32_t bigint_out[], uint8_t len)
{
c0d004ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004ae:	af03      	add	r7, sp, #12
c0d004b0:	b085      	sub	sp, #20
c0d004b2:	9303      	str	r3, [sp, #12]
c0d004b4:	9001      	str	r0, [sp, #4]

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004b6:	6800      	ldr	r0, [r0, #0]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004b8:	2400      	movs	r4, #0

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004ba:	1840      	adds	r0, r0, r1
c0d004bc:	4623      	mov	r3, r4
c0d004be:	415b      	adcs	r3, r3
c0d004c0:	9202      	str	r2, [sp, #8]
    struct int_bool_pair val;
    uint8_t i;

    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;
c0d004c2:	6010      	str	r0, [r2, #0]

    i = 1;
    for (; i < len; i++) {
c0d004c4:	2601      	movs	r6, #1
c0d004c6:	2b00      	cmp	r3, #0
c0d004c8:	4631      	mov	r1, r6
c0d004ca:	d000      	beq.n	c0d004ce <bigint_add_int_u+0x22>
c0d004cc:	4621      	mov	r1, r4
c0d004ce:	2b00      	cmp	r3, #0
c0d004d0:	4635      	mov	r5, r6
c0d004d2:	d100      	bne.n	c0d004d6 <bigint_add_int_u+0x2a>
c0d004d4:	461d      	mov	r5, r3
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004d6:	43e0      	mvns	r0, r4
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d004d8:	9000      	str	r0, [sp, #0]
c0d004da:	9803      	ldr	r0, [sp, #12]
c0d004dc:	2802      	cmp	r0, #2
c0d004de:	d323      	bcc.n	c0d00528 <bigint_add_int_u+0x7c>
c0d004e0:	2900      	cmp	r1, #0
c0d004e2:	d121      	bne.n	c0d00528 <bigint_add_int_u+0x7c>
c0d004e4:	2101      	movs	r1, #1
c0d004e6:	9104      	str	r1, [sp, #16]
c0d004e8:	4634      	mov	r4, r6
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
c0d004ea:	008d      	lsls	r5, r1, #2

#include "bigint.h"

struct int_bool_pair full_add_u(const uint32_t ia, const uint32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004ec:	9801      	ldr	r0, [sp, #4]
c0d004ee:	5943      	ldr	r3, [r0, r5]
c0d004f0:	2200      	movs	r2, #0
    uint32_t l = (uint32_t)((v >> 32) & 0xFFFFFFFF);
    uint32_t r = (uint32_t)(v & 0xFFFFFFFF);
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d004f2:	1c58      	adds	r0, r3, #1
c0d004f4:	4613      	mov	r3, r2
c0d004f6:	415b      	adcs	r3, r3
        // only continue adding, if there is a carry bit
        if (!val.hi) {
            break;
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
c0d004f8:	9e02      	ldr	r6, [sp, #8]
c0d004fa:	5170      	str	r0, [r6, r5]
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32) & 0xFFFFFFFF;
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004fc:	9d00      	ldr	r5, [sp, #0]
c0d004fe:	42a8      	cmp	r0, r5
c0d00500:	9d04      	ldr	r5, [sp, #16]
c0d00502:	d800      	bhi.n	c0d00506 <bigint_add_int_u+0x5a>
c0d00504:	4615      	mov	r5, r2
c0d00506:	2b00      	cmp	r3, #0
c0d00508:	9a04      	ldr	r2, [sp, #16]
c0d0050a:	d100      	bne.n	c0d0050e <bigint_add_int_u+0x62>
c0d0050c:	461a      	mov	r2, r3
c0d0050e:	2b00      	cmp	r3, #0
c0d00510:	4626      	mov	r6, r4
c0d00512:	d000      	beq.n	c0d00516 <bigint_add_int_u+0x6a>
c0d00514:	4615      	mov	r5, r2
    // add to the first word without carry bit
    val = full_add_u(bigint_in[0], int_in, false);
    bigint_out[0] = val.low;

    i = 1;
    for (; i < len; i++) {
c0d00516:	462a      	mov	r2, r5
c0d00518:	4072      	eors	r2, r6
c0d0051a:	1c49      	adds	r1, r1, #1
c0d0051c:	9803      	ldr	r0, [sp, #12]
c0d0051e:	4281      	cmp	r1, r0
c0d00520:	d203      	bcs.n	c0d0052a <bigint_add_int_u+0x7e>
c0d00522:	2a00      	cmp	r2, #0
c0d00524:	d0e0      	beq.n	c0d004e8 <bigint_add_int_u+0x3c>
c0d00526:	e000      	b.n	c0d0052a <bigint_add_int_u+0x7e>
c0d00528:	4631      	mov	r1, r6
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d0052a:	b2cb      	uxtb	r3, r1
c0d0052c:	9803      	ldr	r0, [sp, #12]
c0d0052e:	4283      	cmp	r3, r0
c0d00530:	d20a      	bcs.n	c0d00548 <bigint_add_int_u+0x9c>
        bigint_out[j] = bigint_in[j];
c0d00532:	9803      	ldr	r0, [sp, #12]
c0d00534:	1ac4      	subs	r4, r0, r3
c0d00536:	009a      	lsls	r2, r3, #2
c0d00538:	9801      	ldr	r0, [sp, #4]
c0d0053a:	1880      	adds	r0, r0, r2
c0d0053c:	9e02      	ldr	r6, [sp, #8]
c0d0053e:	18b2      	adds	r2, r6, r2
c0d00540:	c840      	ldmia	r0!, {r6}
c0d00542:	c240      	stmia	r2!, {r6}
        }
        val = full_add_u(bigint_in[i], 0, true);
        bigint_out[i] = val.low;
    }
    // copy the remaining words
    for (uint8_t j = i; j < len; j++) {
c0d00544:	1e64      	subs	r4, r4, #1
c0d00546:	d1fb      	bne.n	c0d00540 <bigint_add_int_u+0x94>
        bigint_out[j] = bigint_in[j];
    }

    if (val.hi && i == len) {
c0d00548:	2000      	movs	r0, #0
c0d0054a:	43c0      	mvns	r0, r0
c0d0054c:	9a03      	ldr	r2, [sp, #12]
c0d0054e:	4293      	cmp	r3, r2
c0d00550:	d000      	beq.n	c0d00554 <bigint_add_int_u+0xa8>
c0d00552:	4608      	mov	r0, r1
c0d00554:	2d00      	cmp	r5, #0
c0d00556:	d100      	bne.n	c0d0055a <bigint_add_int_u+0xae>
c0d00558:	4608      	mov	r0, r1
        return -1;
    }
    return i;
}
c0d0055a:	b005      	add	sp, #20
c0d0055c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0055e <bigint_sub_bigint_u_mem>:
    return len;
}

//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
c0d0055e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00560:	af03      	add	r7, sp, #12
c0d00562:	b086      	sub	sp, #24
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00564:	2a00      	cmp	r2, #0
c0d00566:	d037      	beq.n	c0d005d8 <bigint_sub_bigint_u_mem+0x7a>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00568:	2300      	movs	r3, #0
c0d0056a:	9300      	str	r3, [sp, #0]
c0d0056c:	43de      	mvns	r6, r3
c0d0056e:	2501      	movs	r5, #1
c0d00570:	9505      	str	r5, [sp, #20]
c0d00572:	9203      	str	r2, [sp, #12]
c0d00574:	9001      	str	r0, [sp, #4]
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00576:	6804      	ldr	r4, [r0, #0]
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00578:	c908      	ldmia	r1!, {r3}
c0d0057a:	9104      	str	r1, [sp, #16]
c0d0057c:	43db      	mvns	r3, r3
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0057e:	1918      	adds	r0, r3, r4
c0d00580:	4633      	mov	r3, r6
c0d00582:	9e00      	ldr	r6, [sp, #0]
c0d00584:	4632      	mov	r2, r6
c0d00586:	4152      	adcs	r2, r2
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00588:	4601      	mov	r1, r0
c0d0058a:	4019      	ands	r1, r3
c0d0058c:	1c4c      	adds	r4, r1, #1
c0d0058e:	4631      	mov	r1, r6
c0d00590:	4149      	adcs	r1, r1
c0d00592:	9e05      	ldr	r6, [sp, #20]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00594:	4035      	ands	r5, r6
c0d00596:	2d00      	cmp	r5, #0
c0d00598:	d100      	bne.n	c0d0059c <bigint_sub_bigint_u_mem+0x3e>
c0d0059a:	4604      	mov	r4, r0
c0d0059c:	9402      	str	r4, [sp, #8]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0059e:	429c      	cmp	r4, r3
c0d005a0:	4634      	mov	r4, r6
c0d005a2:	461e      	mov	r6, r3
c0d005a4:	d800      	bhi.n	c0d005a8 <bigint_sub_bigint_u_mem+0x4a>
c0d005a6:	9c00      	ldr	r4, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d005a8:	2d00      	cmp	r5, #0
c0d005aa:	d100      	bne.n	c0d005ae <bigint_sub_bigint_u_mem+0x50>
c0d005ac:	4611      	mov	r1, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005ae:	2900      	cmp	r1, #0
c0d005b0:	9b05      	ldr	r3, [sp, #20]
c0d005b2:	461d      	mov	r5, r3
c0d005b4:	d100      	bne.n	c0d005b8 <bigint_sub_bigint_u_mem+0x5a>
c0d005b6:	460d      	mov	r5, r1
c0d005b8:	2900      	cmp	r1, #0
c0d005ba:	d000      	beq.n	c0d005be <bigint_sub_bigint_u_mem+0x60>
c0d005bc:	462c      	mov	r4, r5
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d005be:	4314      	orrs	r4, r2
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005c0:	2c00      	cmp	r4, #0
c0d005c2:	461d      	mov	r5, r3
c0d005c4:	9802      	ldr	r0, [sp, #8]
c0d005c6:	d100      	bne.n	c0d005ca <bigint_sub_bigint_u_mem+0x6c>
c0d005c8:	4625      	mov	r5, r4
c0d005ca:	9901      	ldr	r1, [sp, #4]
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
c0d005cc:	c101      	stmia	r1!, {r0}
c0d005ce:	4608      	mov	r0, r1
c0d005d0:	9a03      	ldr	r2, [sp, #12]
//subrtacts into arg1
int bigint_sub_bigint_u_mem(uint32_t *bigint_one, const uint32_t *bigint_two, uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005d2:	1e52      	subs	r2, r2, #1
c0d005d4:	9904      	ldr	r1, [sp, #16]
c0d005d6:	d1cc      	bne.n	c0d00572 <bigint_sub_bigint_u_mem+0x14>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_one[i] = val.low;
    }
    return 0;
c0d005d8:	2000      	movs	r0, #0
c0d005da:	b006      	add	sp, #24
c0d005dc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005de <bigint_sub_bigint_u>:
}

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
c0d005de:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005e0:	af03      	add	r7, sp, #12
c0d005e2:	b087      	sub	sp, #28
c0d005e4:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d005e6:	2d00      	cmp	r5, #0
c0d005e8:	d037      	beq.n	c0d0065a <bigint_sub_bigint_u+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d005ea:	2400      	movs	r4, #0
c0d005ec:	9402      	str	r4, [sp, #8]
c0d005ee:	43e3      	mvns	r3, r4
c0d005f0:	9301      	str	r3, [sp, #4]
c0d005f2:	2601      	movs	r6, #1
c0d005f4:	9600      	str	r6, [sp, #0]
c0d005f6:	9203      	str	r2, [sp, #12]
c0d005f8:	9504      	str	r5, [sp, #16]
c0d005fa:	4604      	mov	r4, r0
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d005fc:	cc01      	ldmia	r4!, {r0}
c0d005fe:	9405      	str	r4, [sp, #20]
c0d00600:	460c      	mov	r4, r1
int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d00602:	cc02      	ldmia	r4!, {r1}
c0d00604:	9406      	str	r4, [sp, #24]
c0d00606:	43c9      	mvns	r1, r1
    return ret;
}

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d00608:	180a      	adds	r2, r1, r0
c0d0060a:	9902      	ldr	r1, [sp, #8]
c0d0060c:	460c      	mov	r4, r1
c0d0060e:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d00610:	4610      	mov	r0, r2
c0d00612:	9d01      	ldr	r5, [sp, #4]
c0d00614:	4028      	ands	r0, r5
c0d00616:	1c43      	adds	r3, r0, #1
c0d00618:	4608      	mov	r0, r1
c0d0061a:	4140      	adcs	r0, r0
c0d0061c:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0061e:	400e      	ands	r6, r1
c0d00620:	2e00      	cmp	r6, #0
c0d00622:	d100      	bne.n	c0d00626 <bigint_sub_bigint_u+0x48>
c0d00624:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00626:	42ab      	cmp	r3, r5
c0d00628:	460d      	mov	r5, r1
c0d0062a:	d800      	bhi.n	c0d0062e <bigint_sub_bigint_u+0x50>
c0d0062c:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0062e:	2e00      	cmp	r6, #0
c0d00630:	9a03      	ldr	r2, [sp, #12]
c0d00632:	d100      	bne.n	c0d00636 <bigint_sub_bigint_u+0x58>
c0d00634:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00636:	2800      	cmp	r0, #0
c0d00638:	460e      	mov	r6, r1
c0d0063a:	d100      	bne.n	c0d0063e <bigint_sub_bigint_u+0x60>
c0d0063c:	4606      	mov	r6, r0
c0d0063e:	2800      	cmp	r0, #0
c0d00640:	d000      	beq.n	c0d00644 <bigint_sub_bigint_u+0x66>
c0d00642:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00644:	4325      	orrs	r5, r4

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00646:	2d00      	cmp	r5, #0
c0d00648:	460e      	mov	r6, r1
c0d0064a:	9805      	ldr	r0, [sp, #20]
c0d0064c:	d100      	bne.n	c0d00650 <bigint_sub_bigint_u+0x72>
c0d0064e:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d00650:	c208      	stmia	r2!, {r3}
c0d00652:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint_u(uint32_t bigint_one[], uint32_t bigint_two[], uint32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00654:	1e6d      	subs	r5, r5, #1
c0d00656:	9906      	ldr	r1, [sp, #24]
c0d00658:	d1cd      	bne.n	c0d005f6 <bigint_sub_bigint_u+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d0065a:	2000      	movs	r0, #0
c0d0065c:	b007      	add	sp, #28
c0d0065e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00660 <bigint_cmp_bigint_u>:
    }
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
c0d00660:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00662:	af03      	add	r7, sp, #12
c0d00664:	b081      	sub	sp, #4
c0d00666:	2400      	movs	r4, #0
c0d00668:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d0066a:	32ff      	adds	r2, #255	; 0xff
c0d0066c:	b253      	sxtb	r3, r2
c0d0066e:	2b00      	cmp	r3, #0
c0d00670:	db0f      	blt.n	c0d00692 <bigint_cmp_bigint_u+0x32>
c0d00672:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00674:	009b      	lsls	r3, r3, #2
c0d00676:	58ce      	ldr	r6, [r1, r3]
c0d00678:	58c4      	ldr	r4, [r0, r3]
c0d0067a:	2301      	movs	r3, #1
c0d0067c:	42b4      	cmp	r4, r6
c0d0067e:	d80b      	bhi.n	c0d00698 <bigint_cmp_bigint_u+0x38>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00680:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00682:	42b4      	cmp	r4, r6
c0d00684:	d307      	bcc.n	c0d00696 <bigint_cmp_bigint_u+0x36>
    return 0;
}

int8_t bigint_cmp_bigint_u(const uint32_t bigint_one[], const uint32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00686:	b253      	sxtb	r3, r2
c0d00688:	42ab      	cmp	r3, r5
c0d0068a:	461a      	mov	r2, r3
c0d0068c:	dcf2      	bgt.n	c0d00674 <bigint_cmp_bigint_u+0x14>
c0d0068e:	9b00      	ldr	r3, [sp, #0]
c0d00690:	e002      	b.n	c0d00698 <bigint_cmp_bigint_u+0x38>
c0d00692:	4623      	mov	r3, r4
c0d00694:	e000      	b.n	c0d00698 <bigint_cmp_bigint_u+0x38>
c0d00696:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00698:	4618      	mov	r0, r3
c0d0069a:	b001      	add	sp, #4
c0d0069c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0069e <bigint_not_u>:
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0069e:	2900      	cmp	r1, #0
c0d006a0:	d004      	beq.n	c0d006ac <bigint_not_u+0xe>
        bigint[i] = ~bigint[i];
c0d006a2:	6802      	ldr	r2, [r0, #0]
c0d006a4:	43d2      	mvns	r2, r2
c0d006a6:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not_u(uint32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d006a8:	1e49      	subs	r1, r1, #1
c0d006aa:	d1fa      	bne.n	c0d006a2 <bigint_not_u+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d006ac:	2000      	movs	r0, #0
c0d006ae:	4770      	bx	lr

c0d006b0 <trits_to_trytes>:
    0x1B3DC3CE,
    0x00000001};

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d006b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006b2:	af03      	add	r7, sp, #12
c0d006b4:	b083      	sub	sp, #12
c0d006b6:	4616      	mov	r6, r2
c0d006b8:	460c      	mov	r4, r1
c0d006ba:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d006bc:	2103      	movs	r1, #3
c0d006be:	4630      	mov	r0, r6
c0d006c0:	f002 ff62 	bl	c0d03588 <__aeabi_uidivmod>
c0d006c4:	2000      	movs	r0, #0
c0d006c6:	43c2      	mvns	r2, r0
c0d006c8:	2900      	cmp	r1, #0
c0d006ca:	d123      	bne.n	c0d00714 <trits_to_trytes+0x64>
c0d006cc:	9502      	str	r5, [sp, #8]
c0d006ce:	4635      	mov	r5, r6
c0d006d0:	2603      	movs	r6, #3
c0d006d2:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d006d4:	4628      	mov	r0, r5
c0d006d6:	4631      	mov	r1, r6
c0d006d8:	f002 fed0 	bl	c0d0347c <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d006dc:	2d03      	cmp	r5, #3
c0d006de:	9a01      	ldr	r2, [sp, #4]
c0d006e0:	d318      	bcc.n	c0d00714 <trits_to_trytes+0x64>
c0d006e2:	2200      	movs	r2, #0
c0d006e4:	9200      	str	r2, [sp, #0]
c0d006e6:	9601      	str	r6, [sp, #4]
c0d006e8:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d006ea:	4633      	mov	r3, r6
c0d006ec:	4353      	muls	r3, r2
c0d006ee:	4625      	mov	r5, r4
c0d006f0:	9902      	ldr	r1, [sp, #8]
c0d006f2:	5ccc      	ldrb	r4, [r1, r3]
c0d006f4:	18cb      	adds	r3, r1, r3
c0d006f6:	2101      	movs	r1, #1
c0d006f8:	5659      	ldrsb	r1, [r3, r1]
c0d006fa:	4371      	muls	r1, r6
c0d006fc:	1909      	adds	r1, r1, r4
c0d006fe:	2402      	movs	r4, #2
c0d00700:	571b      	ldrsb	r3, [r3, r4]
c0d00702:	2409      	movs	r4, #9
c0d00704:	435c      	muls	r4, r3
c0d00706:	1909      	adds	r1, r1, r4
c0d00708:	462c      	mov	r4, r5
c0d0070a:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d0070c:	1c52      	adds	r2, r2, #1
c0d0070e:	4282      	cmp	r2, r0
c0d00710:	d3eb      	bcc.n	c0d006ea <trits_to_trytes+0x3a>
c0d00712:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d00714:	4610      	mov	r0, r2
c0d00716:	b003      	add	sp, #12
c0d00718:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d0071c <trytes_to_trits>:

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d0071c:	b5b0      	push	{r4, r5, r7, lr}
c0d0071e:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00720:	2a00      	cmp	r2, #0
c0d00722:	d015      	beq.n	c0d00750 <trytes_to_trits+0x34>
c0d00724:	4b0b      	ldr	r3, [pc, #44]	; (c0d00754 <trytes_to_trits+0x38>)
c0d00726:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00728:	240d      	movs	r4, #13
c0d0072a:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d0072c:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0072e:	062d      	lsls	r5, r5, #24
c0d00730:	192c      	adds	r4, r5, r4
c0d00732:	1624      	asrs	r4, r4, #24
c0d00734:	2503      	movs	r5, #3
c0d00736:	4365      	muls	r5, r4
c0d00738:	5d5c      	ldrb	r4, [r3, r5]
c0d0073a:	700c      	strb	r4, [r1, #0]
c0d0073c:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d0073e:	7865      	ldrb	r5, [r4, #1]
c0d00740:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d00742:	78a4      	ldrb	r4, [r4, #2]
c0d00744:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00746:	1e52      	subs	r2, r2, #1
c0d00748:	1cc9      	adds	r1, r1, #3
c0d0074a:	1c40      	adds	r0, r0, #1
c0d0074c:	2a00      	cmp	r2, #0
c0d0074e:	d1eb      	bne.n	c0d00728 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d00750:	2000      	movs	r0, #0
c0d00752:	bdb0      	pop	{r4, r5, r7, pc}
c0d00754:	000034c6 	.word	0x000034c6

c0d00758 <chars_to_trytes>:
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00758:	b5d0      	push	{r4, r6, r7, lr}
c0d0075a:	af02      	add	r7, sp, #8
c0d0075c:	e00e      	b.n	c0d0077c <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d0075e:	7803      	ldrb	r3, [r0, #0]
c0d00760:	b25b      	sxtb	r3, r3
c0d00762:	2400      	movs	r4, #0
c0d00764:	2b39      	cmp	r3, #57	; 0x39
c0d00766:	d005      	beq.n	c0d00774 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00768:	2b4e      	cmp	r3, #78	; 0x4e
c0d0076a:	db01      	blt.n	c0d00770 <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d0076c:	33a5      	adds	r3, #165	; 0xa5
c0d0076e:	e000      	b.n	c0d00772 <chars_to_trytes+0x1a>
c0d00770:	33c0      	adds	r3, #192	; 0xc0
c0d00772:	461c      	mov	r4, r3
c0d00774:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00776:	1e52      	subs	r2, r2, #1
c0d00778:	1c40      	adds	r0, r0, #1
c0d0077a:	1c49      	adds	r1, r1, #1
c0d0077c:	2a00      	cmp	r2, #0
c0d0077e:	d1ee      	bne.n	c0d0075e <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d00780:	2000      	movs	r0, #0
c0d00782:	bdd0      	pop	{r4, r6, r7, pc}

c0d00784 <trytes_to_chars>:
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00784:	b5d0      	push	{r4, r6, r7, lr}
c0d00786:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00788:	2a00      	cmp	r2, #0
c0d0078a:	d00a      	beq.n	c0d007a2 <trytes_to_chars+0x1e>
c0d0078c:	a306      	add	r3, pc, #24	; (adr r3, c0d007a8 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d0078e:	7804      	ldrb	r4, [r0, #0]
c0d00790:	b264      	sxtb	r4, r4
c0d00792:	191c      	adds	r4, r3, r4
c0d00794:	7b64      	ldrb	r4, [r4, #13]
c0d00796:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d00798:	1e52      	subs	r2, r2, #1
c0d0079a:	1c40      	adds	r0, r0, #1
c0d0079c:	1c49      	adds	r1, r1, #1
c0d0079e:	2a00      	cmp	r2, #0
c0d007a0:	d1f5      	bne.n	c0d0078e <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d007a2:	2000      	movs	r0, #0
c0d007a4:	bdd0      	pop	{r4, r6, r7, pc}
c0d007a6:	46c0      	nop			; (mov r8, r8)

c0d007a8 <tryte_to_char_mapping>:
c0d007a8:	51504f4e 	.word	0x51504f4e
c0d007ac:	55545352 	.word	0x55545352
c0d007b0:	59585756 	.word	0x59585756
c0d007b4:	4241395a 	.word	0x4241395a
c0d007b8:	46454443 	.word	0x46454443
c0d007bc:	4a494847 	.word	0x4a494847
c0d007c0:	004d4c4b 	.word	0x004d4c4b

c0d007c4 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d007c4:	b5d0      	push	{r4, r6, r7, lr}
c0d007c6:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d007c8:	2a00      	cmp	r2, #0
c0d007ca:	d015      	beq.n	c0d007f8 <bytes_to_words+0x34>
c0d007cc:	0093      	lsls	r3, r2, #2
c0d007ce:	18c0      	adds	r0, r0, r3
c0d007d0:	1f00      	subs	r0, r0, #4
c0d007d2:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d007d4:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d007d6:	7803      	ldrb	r3, [r0, #0]
c0d007d8:	061b      	lsls	r3, r3, #24
c0d007da:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d007dc:	7844      	ldrb	r4, [r0, #1]
c0d007de:	0424      	lsls	r4, r4, #16
c0d007e0:	431c      	orrs	r4, r3
c0d007e2:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d007e4:	7883      	ldrb	r3, [r0, #2]
c0d007e6:	021b      	lsls	r3, r3, #8
c0d007e8:	4323      	orrs	r3, r4
c0d007ea:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d007ec:	78c4      	ldrb	r4, [r0, #3]
c0d007ee:	431c      	orrs	r4, r3
c0d007f0:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d007f2:	1f00      	subs	r0, r0, #4
c0d007f4:	1e52      	subs	r2, r2, #1
c0d007f6:	d1ec      	bne.n	c0d007d2 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d007f8:	2000      	movs	r0, #0
c0d007fa:	bdd0      	pop	{r4, r6, r7, pc}

c0d007fc <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d007fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007fe:	af03      	add	r7, sp, #12
c0d00800:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d00802:	2a00      	cmp	r2, #0
c0d00804:	d01a      	beq.n	c0d0083c <words_to_bytes+0x40>
c0d00806:	0093      	lsls	r3, r2, #2
c0d00808:	18c0      	adds	r0, r0, r3
c0d0080a:	1f00      	subs	r0, r0, #4
c0d0080c:	2303      	movs	r3, #3
c0d0080e:	43db      	mvns	r3, r3
c0d00810:	9301      	str	r3, [sp, #4]
c0d00812:	4252      	negs	r2, r2
c0d00814:	9200      	str	r2, [sp, #0]
c0d00816:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d00818:	9d01      	ldr	r5, [sp, #4]
c0d0081a:	4365      	muls	r5, r4
c0d0081c:	00a6      	lsls	r6, r4, #2
c0d0081e:	1983      	adds	r3, r0, r6
c0d00820:	78da      	ldrb	r2, [r3, #3]
c0d00822:	554a      	strb	r2, [r1, r5]
c0d00824:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d00826:	885b      	ldrh	r3, [r3, #2]
c0d00828:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d0082a:	5983      	ldr	r3, [r0, r6]
c0d0082c:	0a1b      	lsrs	r3, r3, #8
c0d0082e:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d00830:	5983      	ldr	r3, [r0, r6]
c0d00832:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d00834:	1e64      	subs	r4, r4, #1
c0d00836:	9a00      	ldr	r2, [sp, #0]
c0d00838:	42a2      	cmp	r2, r4
c0d0083a:	d1ed      	bne.n	c0d00818 <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d0083c:	2000      	movs	r0, #0
c0d0083e:	b002      	add	sp, #8
c0d00840:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d00844 <trints_to_words_u_mem>:
    ((i >> 8) & 0xFF00) |
    ((i >> 24) & 0xFF);
}

int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *base)
{
c0d00844:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00846:	af03      	add	r7, sp, #12
c0d00848:	b095      	sub	sp, #84	; 0x54
c0d0084a:	460e      	mov	r6, r1
    uint32_t size = 1;
    trit_t trits[5];

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);
c0d0084c:	2130      	movs	r1, #48	; 0x30
c0d0084e:	9000      	str	r0, [sp, #0]
c0d00850:	5640      	ldrsb	r0, [r0, r1]
c0d00852:	a913      	add	r1, sp, #76	; 0x4c
c0d00854:	2203      	movs	r2, #3
c0d00856:	f7ff fd0d 	bl	c0d00274 <trint_to_trits>
c0d0085a:	2001      	movs	r0, #1
c0d0085c:	24f1      	movs	r4, #241	; 0xf1

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d0085e:	9606      	str	r6, [sp, #24]
c0d00860:	9004      	str	r0, [sp, #16]

        if(i%5 == 4) //we need a new trint
c0d00862:	2105      	movs	r1, #5
c0d00864:	4620      	mov	r0, r4
c0d00866:	f002 ff79 	bl	c0d0375c <__aeabi_idivmod>
c0d0086a:	460e      	mov	r6, r1
c0d0086c:	2e04      	cmp	r6, #4
c0d0086e:	d10b      	bne.n	c0d00888 <trints_to_words_u_mem+0x44>
c0d00870:	2505      	movs	r5, #5
            trint_to_trits(trints_in[(uint8_t)(i/5)], &trits[0], 5);
c0d00872:	4620      	mov	r0, r4
c0d00874:	4629      	mov	r1, r5
c0d00876:	f002 fe8b 	bl	c0d03590 <__aeabi_idiv>
c0d0087a:	b2c0      	uxtb	r0, r0
c0d0087c:	9900      	ldr	r1, [sp, #0]
c0d0087e:	5608      	ldrsb	r0, [r1, r0]
c0d00880:	a913      	add	r1, sp, #76	; 0x4c
c0d00882:	462a      	mov	r2, r5
c0d00884:	f7ff fcf6 	bl	c0d00274 <trint_to_trits>
c0d00888:	a813      	add	r0, sp, #76	; 0x4c

        //trit cant be negative since we add 1
        uint8_t trit = trits[i%5] + 1;
c0d0088a:	5d80      	ldrb	r0, [r0, r6]
c0d0088c:	1c41      	adds	r1, r0, #1
c0d0088e:	2500      	movs	r5, #0
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d00890:	9804      	ldr	r0, [sp, #16]
c0d00892:	2800      	cmp	r0, #0
c0d00894:	d022      	beq.n	c0d008dc <trints_to_words_u_mem+0x98>
c0d00896:	9101      	str	r1, [sp, #4]
c0d00898:	9402      	str	r4, [sp, #8]
c0d0089a:	2500      	movs	r5, #0
c0d0089c:	462e      	mov	r6, r5
c0d0089e:	9503      	str	r5, [sp, #12]
                uint64_t v = base[j];
c0d008a0:	00b1      	lsls	r1, r6, #2
c0d008a2:	9105      	str	r1, [sp, #20]
c0d008a4:	9806      	ldr	r0, [sp, #24]
c0d008a6:	5840      	ldr	r0, [r0, r1]
                v = v * 3 + carry;
c0d008a8:	2203      	movs	r2, #3
c0d008aa:	9c03      	ldr	r4, [sp, #12]
c0d008ac:	4621      	mov	r1, r4
c0d008ae:	4623      	mov	r3, r4
c0d008b0:	f002 ff7a 	bl	c0d037a8 <__aeabi_lmul>
c0d008b4:	9b04      	ldr	r3, [sp, #16]
c0d008b6:	1940      	adds	r0, r0, r5
c0d008b8:	4161      	adcs	r1, r4

                carry = (uint32_t)(v >> 32);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (uint32_t) (v & 0xFFFFFFFF);
c0d008ba:	9a06      	ldr	r2, [sp, #24]
c0d008bc:	9c05      	ldr	r4, [sp, #20]
c0d008be:	5110      	str	r0, [r2, r4]
        // multiply
        {
            sz = size;
            uint32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
c0d008c0:	1c76      	adds	r6, r6, #1
c0d008c2:	42b3      	cmp	r3, r6
c0d008c4:	460d      	mov	r5, r1
c0d008c6:	d1eb      	bne.n	c0d008a0 <trints_to_words_u_mem+0x5c>
                //printf("-c:%d", carry);
                //printf("-b:%u", base[j]);
                //printf("-sz:%d\n", sz);
            }

            if (carry > 0) {
c0d008c8:	2900      	cmp	r1, #0
c0d008ca:	d004      	beq.n	c0d008d6 <trints_to_words_u_mem+0x92>
                base[sz] = carry;
c0d008cc:	0098      	lsls	r0, r3, #2
c0d008ce:	9a06      	ldr	r2, [sp, #24]
c0d008d0:	5011      	str	r1, [r2, r0]
                size++;
c0d008d2:	1c5d      	adds	r5, r3, #1
c0d008d4:	e000      	b.n	c0d008d8 <trints_to_words_u_mem+0x94>
c0d008d6:	461d      	mov	r5, r3
c0d008d8:	9c02      	ldr	r4, [sp, #8]
c0d008da:	9901      	ldr	r1, [sp, #4]
            }
        }

        // add
        {
            sz = bigint_add_int_u_mem(base, trit, 12);
c0d008dc:	b2c9      	uxtb	r1, r1
c0d008de:	220c      	movs	r2, #12
c0d008e0:	9e06      	ldr	r6, [sp, #24]
c0d008e2:	4630      	mov	r0, r6
c0d008e4:	f7ff fdab 	bl	c0d0043e <bigint_add_int_u_mem>
            if(sz > size) size = sz;
c0d008e8:	42a8      	cmp	r0, r5
c0d008ea:	d800      	bhi.n	c0d008ee <trints_to_words_u_mem+0xaa>
c0d008ec:	4628      	mov	r0, r5

    //it starts at the end and works backwards, so get last trit
    trint_to_trits(trints_in[48], &trits[0], 3);

    //TODO: add a case for if every val == -1 (?)
    for (int16_t i = 242; i-- > 0;) { //skips last trit
c0d008ee:	1e61      	subs	r1, r4, #1
c0d008f0:	2c00      	cmp	r4, #0
c0d008f2:	460c      	mov	r4, r1
c0d008f4:	dcb4      	bgt.n	c0d00860 <trints_to_words_u_mem+0x1c>
            sz = bigint_add_int_u_mem(base, trit, 12);
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
c0d008f6:	481c      	ldr	r0, [pc, #112]	; (c0d00968 <trints_to_words_u_mem+0x124>)
c0d008f8:	4478      	add	r0, pc
c0d008fa:	220c      	movs	r2, #12
c0d008fc:	4631      	mov	r1, r6
c0d008fe:	f7ff feaf 	bl	c0d00660 <bigint_cmp_bigint_u>
c0d00902:	2801      	cmp	r0, #1
c0d00904:	db14      	blt.n	c0d00930 <trints_to_words_u_mem+0xec>
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
    } else {
        uint32_t tmp[12];
        bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00906:	481a      	ldr	r0, [pc, #104]	; (c0d00970 <trints_to_words_u_mem+0x12c>)
c0d00908:	4478      	add	r0, pc
c0d0090a:	ae07      	add	r6, sp, #28
c0d0090c:	250c      	movs	r5, #12
c0d0090e:	9906      	ldr	r1, [sp, #24]
c0d00910:	4632      	mov	r2, r6
c0d00912:	462b      	mov	r3, r5
c0d00914:	f7ff fe63 	bl	c0d005de <bigint_sub_bigint_u>
        bigint_not_u(tmp, 12);
c0d00918:	4630      	mov	r0, r6
c0d0091a:	4629      	mov	r1, r5
c0d0091c:	f7ff febf 	bl	c0d0069e <bigint_not_u>
        bigint_add_int_u(tmp, 1, base, 12);
c0d00920:	2101      	movs	r1, #1
c0d00922:	4630      	mov	r0, r6
c0d00924:	9e06      	ldr	r6, [sp, #24]
c0d00926:	4632      	mov	r2, r6
c0d00928:	462b      	mov	r3, r5
c0d0092a:	f7ff fdbf 	bl	c0d004ac <bigint_add_int_u>
c0d0092e:	e005      	b.n	c0d0093c <trints_to_words_u_mem+0xf8>
            if(sz > size) size = sz;
        }
    }

    if (bigint_cmp_bigint_u(HALF_3_u, base, 12) <= 0 ) {
        bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d00930:	490e      	ldr	r1, [pc, #56]	; (c0d0096c <trints_to_words_u_mem+0x128>)
c0d00932:	4479      	add	r1, pc
c0d00934:	220c      	movs	r2, #12
c0d00936:	4630      	mov	r0, r6
c0d00938:	f7ff fe11 	bl	c0d0055e <bigint_sub_bigint_u_mem>
c0d0093c:	2000      	movs	r0, #0
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
        uint32_t base_tmp = base[i];
c0d0093e:	0081      	lsls	r1, r0, #2
c0d00940:	5872      	ldr	r2, [r6, r1]
        base[i] = base[11-i];
c0d00942:	1a73      	subs	r3, r6, r1
c0d00944:	6adc      	ldr	r4, [r3, #44]	; 0x2c
c0d00946:	5074      	str	r4, [r6, r1]
        base[11-i] = base_tmp;
c0d00948:	62da      	str	r2, [r3, #44]	; 0x2c
        bigint_not_u(tmp, 12);
        bigint_add_int_u(tmp, 1, base, 12);
    }

    //reverse base
    for(uint8_t i=0; i < 6; i++) {
c0d0094a:	1c40      	adds	r0, r0, #1
c0d0094c:	2806      	cmp	r0, #6
c0d0094e:	d1f6      	bne.n	c0d0093e <trints_to_words_u_mem+0xfa>
c0d00950:	2000      	movs	r0, #0
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00952:	0081      	lsls	r1, r0, #2
c0d00954:	5872      	ldr	r2, [r6, r1]
// ---- NEED ALL BELOW FOR TRITS_TO_WORDS AS WELL AS ALL _U FUNCS IN BIGINT
//probably convert since ledger doesn't have uint64
uint32_t swap32(uint32_t i) {
    return ((i & 0xFF) << 24) |
    ((i & 0xFF00) << 8) |
    ((i >> 8) & 0xFF00) |
c0d00956:	ba12      	rev	r2, r2
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
        base[i] = swap32(base[i]);
c0d00958:	5072      	str	r2, [r6, r1]
        base[i] = base[11-i];
        base[11-i] = base_tmp;
    }

    //swap endianness
    for(uint8_t i=0; i<12; i++) {
c0d0095a:	1c40      	adds	r0, r0, #1
c0d0095c:	280c      	cmp	r0, #12
c0d0095e:	d1f8      	bne.n	c0d00952 <trints_to_words_u_mem+0x10e>
        base[i] = swap32(base[i]);
    }

    //outputs correct words according to official js
    return 0;
c0d00960:	2000      	movs	r0, #0
c0d00962:	b015      	add	sp, #84	; 0x54
c0d00964:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00966:	46c0      	nop			; (mov r8, r8)
c0d00968:	00003348 	.word	0x00003348
c0d0096c:	0000330e 	.word	0x0000330e
c0d00970:	00003338 	.word	0x00003338

c0d00974 <words_to_trints_u_mem>:
    return 0;
}


int words_to_trints_u_mem(uint32_t *words_in, trint_t *trints_out)
{
c0d00974:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00976:	af03      	add	r7, sp, #12
c0d00978:	b095      	sub	sp, #84	; 0x54
c0d0097a:	9101      	str	r1, [sp, #4]
c0d0097c:	260b      	movs	r6, #11
c0d0097e:	2100      	movs	r1, #0


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00980:	b2ca      	uxtb	r2, r1
        tmp = words[i];
c0d00982:	0092      	lsls	r2, r2, #2
c0d00984:	5883      	ldr	r3, [r0, r2]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00986:	b2f4      	uxtb	r4, r6
        tmp = words[i];
        words[i] = words[j];
c0d00988:	00a4      	lsls	r4, r4, #2
c0d0098a:	5905      	ldr	r5, [r0, r4]
c0d0098c:	5085      	str	r5, [r0, r2]
        words[j] = tmp;
c0d0098e:	5103      	str	r3, [r0, r4]


void reverse_words(uint32_t *words, uint8_t sz) {
    uint8_t j=sz-1;
    uint32_t tmp;
    for(uint8_t i=0; i<j; i++, j--) {
c0d00990:	1e76      	subs	r6, r6, #1
c0d00992:	b2f2      	uxtb	r2, r6
c0d00994:	1c49      	adds	r1, r1, #1
c0d00996:	b2cb      	uxtb	r3, r1
c0d00998:	4293      	cmp	r3, r2
c0d0099a:	d3f1      	bcc.n	c0d00980 <words_to_trints_u_mem+0xc>
    reverse_words(base, 12);

    //base is properly reversed
    bool flip_trits = false;
    // check if big num is negative
    if (base[11] >> 31 == 0) {
c0d0099c:	6ac1      	ldr	r1, [r0, #44]	; 0x2c
c0d0099e:	2900      	cmp	r1, #0
c0d009a0:	9007      	str	r0, [sp, #28]
c0d009a2:	db06      	blt.n	c0d009b2 <words_to_trints_u_mem+0x3e>
        //positive two's complement
        bigint_add_intarr_u_mem(base, HALF_3_u, 12);
c0d009a4:	493e      	ldr	r1, [pc, #248]	; (c0d00aa0 <words_to_trints_u_mem+0x12c>)
c0d009a6:	4479      	add	r1, pc
c0d009a8:	220c      	movs	r2, #12
c0d009aa:	f7ff fd03 	bl	c0d003b4 <bigint_add_intarr_u_mem>
c0d009ae:	2000      	movs	r0, #0
c0d009b0:	e013      	b.n	c0d009da <words_to_trints_u_mem+0x66>
c0d009b2:	240c      	movs	r4, #12
c0d009b4:	4605      	mov	r5, r0

    } else {
        //negative number
        bigint_not_u(base, 12);
c0d009b6:	4621      	mov	r1, r4
c0d009b8:	f7ff fe71 	bl	c0d0069e <bigint_not_u>
        //***** Doesn't seem to enter here - probably because uint..
        if(bigint_cmp_bigint_u(base, HALF_3_u, 12) > 0) {
c0d009bc:	4939      	ldr	r1, [pc, #228]	; (c0d00aa4 <words_to_trints_u_mem+0x130>)
c0d009be:	4479      	add	r1, pc
c0d009c0:	4628      	mov	r0, r5
c0d009c2:	4622      	mov	r2, r4
c0d009c4:	f7ff fe4c 	bl	c0d00660 <bigint_cmp_bigint_u>
c0d009c8:	2801      	cmp	r0, #1
c0d009ca:	db54      	blt.n	c0d00a76 <words_to_trints_u_mem+0x102>
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);
c0d009cc:	4936      	ldr	r1, [pc, #216]	; (c0d00aa8 <words_to_trints_u_mem+0x134>)
c0d009ce:	4479      	add	r1, pc
c0d009d0:	220c      	movs	r2, #12
c0d009d2:	4628      	mov	r0, r5
c0d009d4:	f7ff fdc3 	bl	c0d0055e <bigint_sub_bigint_u_mem>
c0d009d8:	2001      	movs	r0, #1
c0d009da:	9005      	str	r0, [sp, #20]
c0d009dc:	2000      	movs	r0, #0
c0d009de:	9004      	str	r0, [sp, #16]
c0d009e0:	4605      	mov	r5, r0
c0d009e2:	9506      	str	r5, [sp, #24]
c0d009e4:	250b      	movs	r5, #11
c0d009e6:	9c04      	ldr	r4, [sp, #16]
c0d009e8:	9907      	ldr	r1, [sp, #28]
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
                                      + rem : 0) + base[j];
c0d009ea:	00a8      	lsls	r0, r5, #2
c0d009ec:	9008      	str	r0, [sp, #32]
c0d009ee:	5808      	ldr	r0, [r1, r0]
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF)
c0d009f0:	2c00      	cmp	r4, #0
c0d009f2:	2203      	movs	r2, #3
c0d009f4:	2600      	movs	r6, #0
                                      + rem : 0) + base[j];
            //radix is 3
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;
c0d009f6:	4621      	mov	r1, r4
c0d009f8:	4633      	mov	r3, r6
c0d009fa:	f002 feb5 	bl	c0d03768 <__aeabi_uldivmod>
c0d009fe:	4614      	mov	r4, r2
c0d00a00:	9907      	ldr	r1, [sp, #28]

            base[j] = (uint32_t)q;
c0d00a02:	9a08      	ldr	r2, [sp, #32]
c0d00a04:	5088      	str	r0, [r1, r2]
    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
        rem = 0;

        for (int8_t j = 12-1; j >= 0 ; j--) {
c0d00a06:	1e68      	subs	r0, r5, #1
c0d00a08:	2d00      	cmp	r5, #0
c0d00a0a:	4605      	mov	r5, r0
c0d00a0c:	dced      	bgt.n	c0d009ea <words_to_trints_u_mem+0x76>
c0d00a0e:	9d06      	ldr	r5, [sp, #24]

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00a10:	b2e8      	uxtb	r0, r5
c0d00a12:	2105      	movs	r1, #5
c0d00a14:	9008      	str	r0, [sp, #32]
c0d00a16:	f002 fdb7 	bl	c0d03588 <__aeabi_uidivmod>

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
c0d00a1a:	23fe      	movs	r3, #254	; 0xfe
c0d00a1c:	43d8      	mvns	r0, r3
c0d00a1e:	1b00      	subs	r0, r0, r4

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00a20:	34ff      	adds	r4, #255	; 0xff

        if (flip_trits) {
c0d00a22:	9a05      	ldr	r2, [sp, #20]
c0d00a24:	2a00      	cmp	r2, #0
c0d00a26:	d100      	bne.n	c0d00a2a <words_to_trints_u_mem+0xb6>
c0d00a28:	4620      	mov	r0, r4
c0d00a2a:	aa09      	add	r2, sp, #36	; 0x24

            base[j] = (uint32_t)q;
            rem = r;
        }

        trits[i%5] = rem - 1;
c0d00a2c:	5450      	strb	r0, [r2, r1]

        if (flip_trits) {
            trits[i%5] = -trits[i%5];
        }

        if(i%5 == 4) // we've finished a trint, store it
c0d00a2e:	2904      	cmp	r1, #4
c0d00a30:	4634      	mov	r4, r6
c0d00a32:	d110      	bne.n	c0d00a56 <words_to_trints_u_mem+0xe2>
c0d00a34:	a809      	add	r0, sp, #36	; 0x24
c0d00a36:	9403      	str	r4, [sp, #12]
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
c0d00a38:	2405      	movs	r4, #5
c0d00a3a:	4621      	mov	r1, r4
c0d00a3c:	461e      	mov	r6, r3
c0d00a3e:	f7ff fb92 	bl	c0d00166 <trits_to_trint>
c0d00a42:	9002      	str	r0, [sp, #8]
c0d00a44:	9808      	ldr	r0, [sp, #32]
c0d00a46:	4621      	mov	r1, r4
c0d00a48:	9c03      	ldr	r4, [sp, #12]
c0d00a4a:	f002 fd17 	bl	c0d0347c <__aeabi_uidiv>
c0d00a4e:	4633      	mov	r3, r6
c0d00a50:	9901      	ldr	r1, [sp, #4]
c0d00a52:	9a02      	ldr	r2, [sp, #8]
c0d00a54:	540a      	strb	r2, [r1, r0]
    // Same result up to here!!


    uint32_t rem = 0;
    trit_t trits[5];
    for (uint8_t i = 0; i < 242; i++) {
c0d00a56:	1c6d      	adds	r5, r5, #1
c0d00a58:	402b      	ands	r3, r5
c0d00a5a:	0858      	lsrs	r0, r3, #1
c0d00a5c:	2879      	cmp	r0, #121	; 0x79
c0d00a5e:	d3c0      	bcc.n	c0d009e2 <words_to_trints_u_mem+0x6e>
c0d00a60:	a809      	add	r0, sp, #36	; 0x24

        if(i%5 == 4) // we've finished a trint, store it
            trints_out[(uint8_t)(i/5)] = trits_to_trint(&trits[0], 5);
    }
    //set very last trit to 0
    trits[2] = 0;
c0d00a62:	7084      	strb	r4, [r0, #2]
    //the last trint %5 won't == 4 so store it manually
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00a64:	2103      	movs	r1, #3
c0d00a66:	f7ff fb7e 	bl	c0d00166 <trits_to_trint>
c0d00a6a:	2130      	movs	r1, #48	; 0x30
c0d00a6c:	9a01      	ldr	r2, [sp, #4]
c0d00a6e:	5450      	strb	r0, [r2, r1]

    //words_to_trints_u works (same result as official
    return 0;
c0d00a70:	4620      	mov	r0, r4
c0d00a72:	b015      	add	sp, #84	; 0x54
c0d00a74:	bdf0      	pop	{r4, r5, r6, r7, pc}
            bigint_sub_bigint_u_mem(base, HALF_3_u, 12);

            flip_trits = true;
        } else {
            //bigint is between unsigned half3 and 2**384 - 3**242/2).
            bigint_add_int_u_mem(base, 1, 12);
c0d00a76:	2101      	movs	r1, #1
c0d00a78:	240c      	movs	r4, #12
c0d00a7a:	4628      	mov	r0, r5
c0d00a7c:	4622      	mov	r2, r4
c0d00a7e:	f7ff fcde 	bl	c0d0043e <bigint_add_int_u_mem>

            //ta_slice returns same array (from official implementation)
            //so just sub base from half3 but store in base
            uint32_t tmp[12];
            bigint_sub_bigint_u(HALF_3_u, base, tmp, 12);
c0d00a82:	480a      	ldr	r0, [pc, #40]	; (c0d00aac <words_to_trints_u_mem+0x138>)
c0d00a84:	4478      	add	r0, pc
c0d00a86:	ae09      	add	r6, sp, #36	; 0x24
c0d00a88:	4629      	mov	r1, r5
c0d00a8a:	4632      	mov	r2, r6
c0d00a8c:	4623      	mov	r3, r4
c0d00a8e:	f7ff fda6 	bl	c0d005de <bigint_sub_bigint_u>
            memcpy(base, tmp, 48);
c0d00a92:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a94:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a96:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a98:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a9a:	ce1e      	ldmia	r6!, {r1, r2, r3, r4}
c0d00a9c:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00a9e:	e786      	b.n	c0d009ae <words_to_trints_u_mem+0x3a>
c0d00aa0:	0000329a 	.word	0x0000329a
c0d00aa4:	00003282 	.word	0x00003282
c0d00aa8:	00003272 	.word	0x00003272
c0d00aac:	000031bc 	.word	0x000031bc

c0d00ab0 <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d00ab0:	b580      	push	{r7, lr}
c0d00ab2:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00ab4:	2003      	movs	r0, #3
c0d00ab6:	01c1      	lsls	r1, r0, #7
c0d00ab8:	4802      	ldr	r0, [pc, #8]	; (c0d00ac4 <kerl_initialize+0x14>)
c0d00aba:	f001 fb71 	bl	c0d021a0 <cx_keccak_init>
    return 0;
c0d00abe:	2000      	movs	r0, #0
c0d00ac0:	bd80      	pop	{r7, pc}
c0d00ac2:	46c0      	nop			; (mov r8, r8)
c0d00ac4:	20001840 	.word	0x20001840

c0d00ac8 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00ac8:	b580      	push	{r7, lr}
c0d00aca:	af00      	add	r7, sp, #0
c0d00acc:	b082      	sub	sp, #8
c0d00ace:	460b      	mov	r3, r1
c0d00ad0:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00ad2:	4805      	ldr	r0, [pc, #20]	; (c0d00ae8 <kerl_absorb_bytes+0x20>)
c0d00ad4:	4669      	mov	r1, sp
c0d00ad6:	6008      	str	r0, [r1, #0]
c0d00ad8:	4804      	ldr	r0, [pc, #16]	; (c0d00aec <kerl_absorb_bytes+0x24>)
c0d00ada:	2101      	movs	r1, #1
c0d00adc:	f001 fb7e 	bl	c0d021dc <cx_hash>
c0d00ae0:	2000      	movs	r0, #0
    return 0;
c0d00ae2:	b002      	add	sp, #8
c0d00ae4:	bd80      	pop	{r7, pc}
c0d00ae6:	46c0      	nop			; (mov r8, r8)
c0d00ae8:	200019e8 	.word	0x200019e8
c0d00aec:	20001840 	.word	0x20001840

c0d00af0 <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d00af0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00af2:	af03      	add	r7, sp, #12
c0d00af4:	b09d      	sub	sp, #116	; 0x74
c0d00af6:	460e      	mov	r6, r1
c0d00af8:	4605      	mov	r5, r0
c0d00afa:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00afc:	4630      	mov	r0, r6
c0d00afe:	f002 fcbd 	bl	c0d0347c <__aeabi_uidiv>
c0d00b02:	2e31      	cmp	r6, #49	; 0x31
c0d00b04:	d321      	bcc.n	c0d00b4a <kerl_absorb_trints+0x5a>
c0d00b06:	2600      	movs	r6, #0
c0d00b08:	9503      	str	r5, [sp, #12]
c0d00b0a:	9002      	str	r0, [sp, #8]
c0d00b0c:	ac11      	add	r4, sp, #68	; 0x44
        // First, convert to bytes
        int32_t words[12];
        memset(words, 0, sizeof(words));
c0d00b0e:	2130      	movs	r1, #48	; 0x30
c0d00b10:	9104      	str	r1, [sp, #16]
c0d00b12:	4620      	mov	r0, r4
c0d00b14:	f002 ff5e 	bl	c0d039d4 <__aeabi_memclr>
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words_u_mem(trints_in, words);
c0d00b18:	4628      	mov	r0, r5
c0d00b1a:	4621      	mov	r1, r4
c0d00b1c:	f7ff fe92 	bl	c0d00844 <trints_to_words_u_mem>
c0d00b20:	ad05      	add	r5, sp, #20
        words_to_bytes(words, bytes, 12);
c0d00b22:	220c      	movs	r2, #12
c0d00b24:	4620      	mov	r0, r4
c0d00b26:	4629      	mov	r1, r5
c0d00b28:	f7ff fe68 	bl	c0d007fc <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00b2c:	4668      	mov	r0, sp
c0d00b2e:	4908      	ldr	r1, [pc, #32]	; (c0d00b50 <kerl_absorb_trints+0x60>)
c0d00b30:	6001      	str	r1, [r0, #0]
c0d00b32:	2101      	movs	r1, #1
c0d00b34:	4807      	ldr	r0, [pc, #28]	; (c0d00b54 <kerl_absorb_trints+0x64>)
c0d00b36:	462a      	mov	r2, r5
c0d00b38:	9d03      	ldr	r5, [sp, #12]
c0d00b3a:	9b04      	ldr	r3, [sp, #16]
c0d00b3c:	f001 fb4e 	bl	c0d021dc <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d00b40:	1c76      	adds	r6, r6, #1
c0d00b42:	b2f0      	uxtb	r0, r6
c0d00b44:	9902      	ldr	r1, [sp, #8]
c0d00b46:	4288      	cmp	r0, r1
c0d00b48:	d3e0      	bcc.n	c0d00b0c <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words_u_mem(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d00b4a:	2000      	movs	r0, #0
c0d00b4c:	b01d      	add	sp, #116	; 0x74
c0d00b4e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b50:	200019e8 	.word	0x200019e8
c0d00b54:	20001840 	.word	0x20001840

c0d00b58 <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00b58:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b5a:	af03      	add	r7, sp, #12
c0d00b5c:	b091      	sub	sp, #68	; 0x44
c0d00b5e:	4605      	mov	r5, r0
    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00b60:	4c1b      	ldr	r4, [pc, #108]	; (c0d00bd0 <kerl_squeeze_trints+0x78>)
c0d00b62:	ae05      	add	r6, sp, #20
c0d00b64:	220c      	movs	r2, #12
c0d00b66:	4620      	mov	r0, r4
c0d00b68:	4631      	mov	r1, r6
c0d00b6a:	f7ff fe2b 	bl	c0d007c4 <bytes_to_words>
    words_to_trints_u_mem(words, &trints_out[0]);
c0d00b6e:	4630      	mov	r0, r6
c0d00b70:	9502      	str	r5, [sp, #8]
c0d00b72:	4629      	mov	r1, r5
c0d00b74:	f7ff fefe 	bl	c0d00974 <words_to_trints_u_mem>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00b78:	2030      	movs	r0, #48	; 0x30
c0d00b7a:	9003      	str	r0, [sp, #12]
c0d00b7c:	5628      	ldrsb	r0, [r5, r0]
c0d00b7e:	ad04      	add	r5, sp, #16
c0d00b80:	2203      	movs	r2, #3
c0d00b82:	9201      	str	r2, [sp, #4]
c0d00b84:	4629      	mov	r1, r5
c0d00b86:	f7ff fb75 	bl	c0d00274 <trint_to_trits>
c0d00b8a:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00b8c:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00b8e:	4628      	mov	r0, r5
c0d00b90:	9d01      	ldr	r5, [sp, #4]
c0d00b92:	4629      	mov	r1, r5
c0d00b94:	f7ff fae7 	bl	c0d00166 <trits_to_trint>
c0d00b98:	9903      	ldr	r1, [sp, #12]
c0d00b9a:	9a02      	ldr	r2, [sp, #8]
c0d00b9c:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00b9e:	1ba0      	subs	r0, r4, r6
c0d00ba0:	7801      	ldrb	r1, [r0, #0]
c0d00ba2:	43c9      	mvns	r1, r1
c0d00ba4:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00ba6:	1e76      	subs	r6, r6, #1
c0d00ba8:	4630      	mov	r0, r6
c0d00baa:	3030      	adds	r0, #48	; 0x30
c0d00bac:	d1f7      	bne.n	c0d00b9e <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00bae:	01e9      	lsls	r1, r5, #7
c0d00bb0:	4d08      	ldr	r5, [pc, #32]	; (c0d00bd4 <kerl_squeeze_trints+0x7c>)
c0d00bb2:	4628      	mov	r0, r5
c0d00bb4:	f001 faf4 	bl	c0d021a0 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00bb8:	4668      	mov	r0, sp
c0d00bba:	6004      	str	r4, [r0, #0]
c0d00bbc:	2101      	movs	r1, #1
c0d00bbe:	2330      	movs	r3, #48	; 0x30
c0d00bc0:	4628      	mov	r0, r5
c0d00bc2:	4622      	mov	r2, r4
c0d00bc4:	f001 fb0a 	bl	c0d021dc <cx_hash>
c0d00bc8:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00bca:	b011      	add	sp, #68	; 0x44
c0d00bcc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00bce:	46c0      	nop			; (mov r8, r8)
c0d00bd0:	200019e8 	.word	0x200019e8
c0d00bd4:	20001840 	.word	0x20001840

c0d00bd8 <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00bd8:	b580      	push	{r7, lr}
c0d00bda:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00bdc:	4804      	ldr	r0, [pc, #16]	; (c0d00bf0 <nvram_is_init+0x18>)
c0d00bde:	f001 fa33 	bl	c0d02048 <pic>
c0d00be2:	7801      	ldrb	r1, [r0, #0]
c0d00be4:	2000      	movs	r0, #0
c0d00be6:	2901      	cmp	r1, #1
c0d00be8:	d100      	bne.n	c0d00bec <nvram_is_init+0x14>
c0d00bea:	4608      	mov	r0, r1
    else return true;
}
c0d00bec:	bd80      	pop	{r7, pc}
c0d00bee:	46c0      	nop			; (mov r8, r8)
c0d00bf0:	c0d04040 	.word	0xc0d04040

c0d00bf4 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00bf4:	b5b0      	push	{r4, r5, r7, lr}
c0d00bf6:	af02      	add	r7, sp, #8
c0d00bf8:	4605      	mov	r5, r0
c0d00bfa:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00bfc:	4028      	ands	r0, r5
c0d00bfe:	2400      	movs	r4, #0
c0d00c00:	2801      	cmp	r0, #1
c0d00c02:	d013      	beq.n	c0d00c2c <io_exchange_al+0x38>
c0d00c04:	2802      	cmp	r0, #2
c0d00c06:	d113      	bne.n	c0d00c30 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00c08:	2900      	cmp	r1, #0
c0d00c0a:	d008      	beq.n	c0d00c1e <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00c0c:	480b      	ldr	r0, [pc, #44]	; (c0d00c3c <io_exchange_al+0x48>)
c0d00c0e:	f001 fbd7 	bl	c0d023c0 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00c12:	b268      	sxtb	r0, r5
c0d00c14:	2800      	cmp	r0, #0
c0d00c16:	da09      	bge.n	c0d00c2c <io_exchange_al+0x38>
                reset();
c0d00c18:	f001 fa4c 	bl	c0d020b4 <reset>
c0d00c1c:	e006      	b.n	c0d00c2c <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00c1e:	2041      	movs	r0, #65	; 0x41
c0d00c20:	0081      	lsls	r1, r0, #2
c0d00c22:	4806      	ldr	r0, [pc, #24]	; (c0d00c3c <io_exchange_al+0x48>)
c0d00c24:	2200      	movs	r2, #0
c0d00c26:	f001 fc05 	bl	c0d02434 <io_seproxyhal_spi_recv>
c0d00c2a:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00c2c:	4620      	mov	r0, r4
c0d00c2e:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00c30:	4803      	ldr	r0, [pc, #12]	; (c0d00c40 <io_exchange_al+0x4c>)
c0d00c32:	6800      	ldr	r0, [r0, #0]
c0d00c34:	2102      	movs	r1, #2
c0d00c36:	f002 ff6f 	bl	c0d03b18 <longjmp>
c0d00c3a:	46c0      	nop			; (mov r8, r8)
c0d00c3c:	20001c08 	.word	0x20001c08
c0d00c40:	20001bb8 	.word	0x20001bb8

c0d00c44 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00c44:	b580      	push	{r7, lr}
c0d00c46:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c48:	f000 fe8e 	bl	c0d01968 <io_seproxyhal_display_default>
}
c0d00c4c:	bd80      	pop	{r7, pc}
	...

c0d00c50 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00c50:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c52:	af03      	add	r7, sp, #12
c0d00c54:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00c56:	48a6      	ldr	r0, [pc, #664]	; (c0d00ef0 <io_event+0x2a0>)
c0d00c58:	7800      	ldrb	r0, [r0, #0]
c0d00c5a:	2805      	cmp	r0, #5
c0d00c5c:	d02e      	beq.n	c0d00cbc <io_event+0x6c>
c0d00c5e:	280d      	cmp	r0, #13
c0d00c60:	d04e      	beq.n	c0d00d00 <io_event+0xb0>
c0d00c62:	280c      	cmp	r0, #12
c0d00c64:	d000      	beq.n	c0d00c68 <io_event+0x18>
c0d00c66:	e13a      	b.n	c0d00ede <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c68:	4ea2      	ldr	r6, [pc, #648]	; (c0d00ef4 <io_event+0x2a4>)
c0d00c6a:	2001      	movs	r0, #1
c0d00c6c:	7630      	strb	r0, [r6, #24]
c0d00c6e:	2500      	movs	r5, #0
c0d00c70:	61f5      	str	r5, [r6, #28]
c0d00c72:	4634      	mov	r4, r6
c0d00c74:	3418      	adds	r4, #24
c0d00c76:	4620      	mov	r0, r4
c0d00c78:	f001 fb68 	bl	c0d0234c <os_ux>
c0d00c7c:	61f0      	str	r0, [r6, #28]
c0d00c7e:	499e      	ldr	r1, [pc, #632]	; (c0d00ef8 <io_event+0x2a8>)
c0d00c80:	4288      	cmp	r0, r1
c0d00c82:	d100      	bne.n	c0d00c86 <io_event+0x36>
c0d00c84:	e12b      	b.n	c0d00ede <io_event+0x28e>
c0d00c86:	2800      	cmp	r0, #0
c0d00c88:	d100      	bne.n	c0d00c8c <io_event+0x3c>
c0d00c8a:	e128      	b.n	c0d00ede <io_event+0x28e>
c0d00c8c:	499b      	ldr	r1, [pc, #620]	; (c0d00efc <io_event+0x2ac>)
c0d00c8e:	4288      	cmp	r0, r1
c0d00c90:	d000      	beq.n	c0d00c94 <io_event+0x44>
c0d00c92:	e0ac      	b.n	c0d00dee <io_event+0x19e>
c0d00c94:	2003      	movs	r0, #3
c0d00c96:	7630      	strb	r0, [r6, #24]
c0d00c98:	61f5      	str	r5, [r6, #28]
c0d00c9a:	4620      	mov	r0, r4
c0d00c9c:	f001 fb56 	bl	c0d0234c <os_ux>
c0d00ca0:	61f0      	str	r0, [r6, #28]
c0d00ca2:	f000 fd17 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d00ca6:	60b5      	str	r5, [r6, #8]
c0d00ca8:	6830      	ldr	r0, [r6, #0]
c0d00caa:	2800      	cmp	r0, #0
c0d00cac:	d100      	bne.n	c0d00cb0 <io_event+0x60>
c0d00cae:	e116      	b.n	c0d00ede <io_event+0x28e>
c0d00cb0:	69f0      	ldr	r0, [r6, #28]
c0d00cb2:	4991      	ldr	r1, [pc, #580]	; (c0d00ef8 <io_event+0x2a8>)
c0d00cb4:	4288      	cmp	r0, r1
c0d00cb6:	d000      	beq.n	c0d00cba <io_event+0x6a>
c0d00cb8:	e096      	b.n	c0d00de8 <io_event+0x198>
c0d00cba:	e110      	b.n	c0d00ede <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00cbc:	4d8d      	ldr	r5, [pc, #564]	; (c0d00ef4 <io_event+0x2a4>)
c0d00cbe:	2001      	movs	r0, #1
c0d00cc0:	7628      	strb	r0, [r5, #24]
c0d00cc2:	2600      	movs	r6, #0
c0d00cc4:	61ee      	str	r6, [r5, #28]
c0d00cc6:	462c      	mov	r4, r5
c0d00cc8:	3418      	adds	r4, #24
c0d00cca:	4620      	mov	r0, r4
c0d00ccc:	f001 fb3e 	bl	c0d0234c <os_ux>
c0d00cd0:	4601      	mov	r1, r0
c0d00cd2:	61e9      	str	r1, [r5, #28]
c0d00cd4:	4889      	ldr	r0, [pc, #548]	; (c0d00efc <io_event+0x2ac>)
c0d00cd6:	4281      	cmp	r1, r0
c0d00cd8:	d15d      	bne.n	c0d00d96 <io_event+0x146>
c0d00cda:	2003      	movs	r0, #3
c0d00cdc:	7628      	strb	r0, [r5, #24]
c0d00cde:	61ee      	str	r6, [r5, #28]
c0d00ce0:	4620      	mov	r0, r4
c0d00ce2:	f001 fb33 	bl	c0d0234c <os_ux>
c0d00ce6:	61e8      	str	r0, [r5, #28]
c0d00ce8:	f000 fcf4 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d00cec:	60ae      	str	r6, [r5, #8]
c0d00cee:	6828      	ldr	r0, [r5, #0]
c0d00cf0:	2800      	cmp	r0, #0
c0d00cf2:	d100      	bne.n	c0d00cf6 <io_event+0xa6>
c0d00cf4:	e0f3      	b.n	c0d00ede <io_event+0x28e>
c0d00cf6:	69e8      	ldr	r0, [r5, #28]
c0d00cf8:	497f      	ldr	r1, [pc, #508]	; (c0d00ef8 <io_event+0x2a8>)
c0d00cfa:	4288      	cmp	r0, r1
c0d00cfc:	d148      	bne.n	c0d00d90 <io_event+0x140>
c0d00cfe:	e0ee      	b.n	c0d00ede <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00d00:	4d7c      	ldr	r5, [pc, #496]	; (c0d00ef4 <io_event+0x2a4>)
c0d00d02:	6868      	ldr	r0, [r5, #4]
c0d00d04:	68a9      	ldr	r1, [r5, #8]
c0d00d06:	4281      	cmp	r1, r0
c0d00d08:	d300      	bcc.n	c0d00d0c <io_event+0xbc>
c0d00d0a:	e0e8      	b.n	c0d00ede <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00d0c:	2001      	movs	r0, #1
c0d00d0e:	7628      	strb	r0, [r5, #24]
c0d00d10:	2600      	movs	r6, #0
c0d00d12:	61ee      	str	r6, [r5, #28]
c0d00d14:	462c      	mov	r4, r5
c0d00d16:	3418      	adds	r4, #24
c0d00d18:	4620      	mov	r0, r4
c0d00d1a:	f001 fb17 	bl	c0d0234c <os_ux>
c0d00d1e:	61e8      	str	r0, [r5, #28]
c0d00d20:	4975      	ldr	r1, [pc, #468]	; (c0d00ef8 <io_event+0x2a8>)
c0d00d22:	4288      	cmp	r0, r1
c0d00d24:	d100      	bne.n	c0d00d28 <io_event+0xd8>
c0d00d26:	e0da      	b.n	c0d00ede <io_event+0x28e>
c0d00d28:	2800      	cmp	r0, #0
c0d00d2a:	d100      	bne.n	c0d00d2e <io_event+0xde>
c0d00d2c:	e0d7      	b.n	c0d00ede <io_event+0x28e>
c0d00d2e:	4973      	ldr	r1, [pc, #460]	; (c0d00efc <io_event+0x2ac>)
c0d00d30:	4288      	cmp	r0, r1
c0d00d32:	d000      	beq.n	c0d00d36 <io_event+0xe6>
c0d00d34:	e08d      	b.n	c0d00e52 <io_event+0x202>
c0d00d36:	2003      	movs	r0, #3
c0d00d38:	7628      	strb	r0, [r5, #24]
c0d00d3a:	61ee      	str	r6, [r5, #28]
c0d00d3c:	4620      	mov	r0, r4
c0d00d3e:	f001 fb05 	bl	c0d0234c <os_ux>
c0d00d42:	61e8      	str	r0, [r5, #28]
c0d00d44:	f000 fcc6 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d00d48:	60ae      	str	r6, [r5, #8]
c0d00d4a:	6828      	ldr	r0, [r5, #0]
c0d00d4c:	2800      	cmp	r0, #0
c0d00d4e:	d100      	bne.n	c0d00d52 <io_event+0x102>
c0d00d50:	e0c5      	b.n	c0d00ede <io_event+0x28e>
c0d00d52:	69e8      	ldr	r0, [r5, #28]
c0d00d54:	4968      	ldr	r1, [pc, #416]	; (c0d00ef8 <io_event+0x2a8>)
c0d00d56:	4288      	cmp	r0, r1
c0d00d58:	d178      	bne.n	c0d00e4c <io_event+0x1fc>
c0d00d5a:	e0c0      	b.n	c0d00ede <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d5c:	6868      	ldr	r0, [r5, #4]
c0d00d5e:	4286      	cmp	r6, r0
c0d00d60:	d300      	bcc.n	c0d00d64 <io_event+0x114>
c0d00d62:	e0bc      	b.n	c0d00ede <io_event+0x28e>
c0d00d64:	f001 fb4a 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00d68:	2800      	cmp	r0, #0
c0d00d6a:	d000      	beq.n	c0d00d6e <io_event+0x11e>
c0d00d6c:	e0b7      	b.n	c0d00ede <io_event+0x28e>
c0d00d6e:	68a8      	ldr	r0, [r5, #8]
c0d00d70:	68e9      	ldr	r1, [r5, #12]
c0d00d72:	2438      	movs	r4, #56	; 0x38
c0d00d74:	4360      	muls	r0, r4
c0d00d76:	682a      	ldr	r2, [r5, #0]
c0d00d78:	1810      	adds	r0, r2, r0
c0d00d7a:	2900      	cmp	r1, #0
c0d00d7c:	d100      	bne.n	c0d00d80 <io_event+0x130>
c0d00d7e:	e085      	b.n	c0d00e8c <io_event+0x23c>
c0d00d80:	4788      	blx	r1
c0d00d82:	2800      	cmp	r0, #0
c0d00d84:	d000      	beq.n	c0d00d88 <io_event+0x138>
c0d00d86:	e081      	b.n	c0d00e8c <io_event+0x23c>
c0d00d88:	68a8      	ldr	r0, [r5, #8]
c0d00d8a:	1c46      	adds	r6, r0, #1
c0d00d8c:	60ae      	str	r6, [r5, #8]
c0d00d8e:	6828      	ldr	r0, [r5, #0]
c0d00d90:	2800      	cmp	r0, #0
c0d00d92:	d1e3      	bne.n	c0d00d5c <io_event+0x10c>
c0d00d94:	e0a3      	b.n	c0d00ede <io_event+0x28e>
c0d00d96:	6928      	ldr	r0, [r5, #16]
c0d00d98:	2800      	cmp	r0, #0
c0d00d9a:	d100      	bne.n	c0d00d9e <io_event+0x14e>
c0d00d9c:	e09f      	b.n	c0d00ede <io_event+0x28e>
c0d00d9e:	4a56      	ldr	r2, [pc, #344]	; (c0d00ef8 <io_event+0x2a8>)
c0d00da0:	4291      	cmp	r1, r2
c0d00da2:	d100      	bne.n	c0d00da6 <io_event+0x156>
c0d00da4:	e09b      	b.n	c0d00ede <io_event+0x28e>
c0d00da6:	2900      	cmp	r1, #0
c0d00da8:	d100      	bne.n	c0d00dac <io_event+0x15c>
c0d00daa:	e098      	b.n	c0d00ede <io_event+0x28e>
c0d00dac:	4950      	ldr	r1, [pc, #320]	; (c0d00ef0 <io_event+0x2a0>)
c0d00dae:	78c9      	ldrb	r1, [r1, #3]
c0d00db0:	0849      	lsrs	r1, r1, #1
c0d00db2:	f000 fe1b 	bl	c0d019ec <io_seproxyhal_button_push>
c0d00db6:	e092      	b.n	c0d00ede <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00db8:	6870      	ldr	r0, [r6, #4]
c0d00dba:	4285      	cmp	r5, r0
c0d00dbc:	d300      	bcc.n	c0d00dc0 <io_event+0x170>
c0d00dbe:	e08e      	b.n	c0d00ede <io_event+0x28e>
c0d00dc0:	f001 fb1c 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00dc4:	2800      	cmp	r0, #0
c0d00dc6:	d000      	beq.n	c0d00dca <io_event+0x17a>
c0d00dc8:	e089      	b.n	c0d00ede <io_event+0x28e>
c0d00dca:	68b0      	ldr	r0, [r6, #8]
c0d00dcc:	68f1      	ldr	r1, [r6, #12]
c0d00dce:	2438      	movs	r4, #56	; 0x38
c0d00dd0:	4360      	muls	r0, r4
c0d00dd2:	6832      	ldr	r2, [r6, #0]
c0d00dd4:	1810      	adds	r0, r2, r0
c0d00dd6:	2900      	cmp	r1, #0
c0d00dd8:	d076      	beq.n	c0d00ec8 <io_event+0x278>
c0d00dda:	4788      	blx	r1
c0d00ddc:	2800      	cmp	r0, #0
c0d00dde:	d173      	bne.n	c0d00ec8 <io_event+0x278>
c0d00de0:	68b0      	ldr	r0, [r6, #8]
c0d00de2:	1c45      	adds	r5, r0, #1
c0d00de4:	60b5      	str	r5, [r6, #8]
c0d00de6:	6830      	ldr	r0, [r6, #0]
c0d00de8:	2800      	cmp	r0, #0
c0d00dea:	d1e5      	bne.n	c0d00db8 <io_event+0x168>
c0d00dec:	e077      	b.n	c0d00ede <io_event+0x28e>
c0d00dee:	88b0      	ldrh	r0, [r6, #4]
c0d00df0:	9004      	str	r0, [sp, #16]
c0d00df2:	6830      	ldr	r0, [r6, #0]
c0d00df4:	9003      	str	r0, [sp, #12]
c0d00df6:	483e      	ldr	r0, [pc, #248]	; (c0d00ef0 <io_event+0x2a0>)
c0d00df8:	4601      	mov	r1, r0
c0d00dfa:	79cc      	ldrb	r4, [r1, #7]
c0d00dfc:	798b      	ldrb	r3, [r1, #6]
c0d00dfe:	794d      	ldrb	r5, [r1, #5]
c0d00e00:	790a      	ldrb	r2, [r1, #4]
c0d00e02:	4630      	mov	r0, r6
c0d00e04:	78ce      	ldrb	r6, [r1, #3]
c0d00e06:	68c1      	ldr	r1, [r0, #12]
c0d00e08:	4668      	mov	r0, sp
c0d00e0a:	6006      	str	r6, [r0, #0]
c0d00e0c:	6041      	str	r1, [r0, #4]
c0d00e0e:	0212      	lsls	r2, r2, #8
c0d00e10:	432a      	orrs	r2, r5
c0d00e12:	021b      	lsls	r3, r3, #8
c0d00e14:	4323      	orrs	r3, r4
c0d00e16:	9803      	ldr	r0, [sp, #12]
c0d00e18:	9904      	ldr	r1, [sp, #16]
c0d00e1a:	f000 fcd5 	bl	c0d017c8 <io_seproxyhal_touch_element_callback>
c0d00e1e:	e05e      	b.n	c0d00ede <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00e20:	6868      	ldr	r0, [r5, #4]
c0d00e22:	4286      	cmp	r6, r0
c0d00e24:	d25b      	bcs.n	c0d00ede <io_event+0x28e>
c0d00e26:	f001 fae9 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00e2a:	2800      	cmp	r0, #0
c0d00e2c:	d157      	bne.n	c0d00ede <io_event+0x28e>
c0d00e2e:	68a8      	ldr	r0, [r5, #8]
c0d00e30:	68e9      	ldr	r1, [r5, #12]
c0d00e32:	2438      	movs	r4, #56	; 0x38
c0d00e34:	4360      	muls	r0, r4
c0d00e36:	682a      	ldr	r2, [r5, #0]
c0d00e38:	1810      	adds	r0, r2, r0
c0d00e3a:	2900      	cmp	r1, #0
c0d00e3c:	d026      	beq.n	c0d00e8c <io_event+0x23c>
c0d00e3e:	4788      	blx	r1
c0d00e40:	2800      	cmp	r0, #0
c0d00e42:	d123      	bne.n	c0d00e8c <io_event+0x23c>
c0d00e44:	68a8      	ldr	r0, [r5, #8]
c0d00e46:	1c46      	adds	r6, r0, #1
c0d00e48:	60ae      	str	r6, [r5, #8]
c0d00e4a:	6828      	ldr	r0, [r5, #0]
c0d00e4c:	2800      	cmp	r0, #0
c0d00e4e:	d1e7      	bne.n	c0d00e20 <io_event+0x1d0>
c0d00e50:	e045      	b.n	c0d00ede <io_event+0x28e>
c0d00e52:	6828      	ldr	r0, [r5, #0]
c0d00e54:	2800      	cmp	r0, #0
c0d00e56:	d030      	beq.n	c0d00eba <io_event+0x26a>
c0d00e58:	68a8      	ldr	r0, [r5, #8]
c0d00e5a:	6869      	ldr	r1, [r5, #4]
c0d00e5c:	4288      	cmp	r0, r1
c0d00e5e:	d22c      	bcs.n	c0d00eba <io_event+0x26a>
c0d00e60:	f001 facc 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00e64:	2800      	cmp	r0, #0
c0d00e66:	d128      	bne.n	c0d00eba <io_event+0x26a>
c0d00e68:	68a8      	ldr	r0, [r5, #8]
c0d00e6a:	68e9      	ldr	r1, [r5, #12]
c0d00e6c:	2438      	movs	r4, #56	; 0x38
c0d00e6e:	4360      	muls	r0, r4
c0d00e70:	682a      	ldr	r2, [r5, #0]
c0d00e72:	1810      	adds	r0, r2, r0
c0d00e74:	2900      	cmp	r1, #0
c0d00e76:	d015      	beq.n	c0d00ea4 <io_event+0x254>
c0d00e78:	4788      	blx	r1
c0d00e7a:	2800      	cmp	r0, #0
c0d00e7c:	d112      	bne.n	c0d00ea4 <io_event+0x254>
c0d00e7e:	68a8      	ldr	r0, [r5, #8]
c0d00e80:	1c40      	adds	r0, r0, #1
c0d00e82:	60a8      	str	r0, [r5, #8]
c0d00e84:	6829      	ldr	r1, [r5, #0]
c0d00e86:	2900      	cmp	r1, #0
c0d00e88:	d1e7      	bne.n	c0d00e5a <io_event+0x20a>
c0d00e8a:	e016      	b.n	c0d00eba <io_event+0x26a>
c0d00e8c:	2801      	cmp	r0, #1
c0d00e8e:	d103      	bne.n	c0d00e98 <io_event+0x248>
c0d00e90:	68a8      	ldr	r0, [r5, #8]
c0d00e92:	4344      	muls	r4, r0
c0d00e94:	6828      	ldr	r0, [r5, #0]
c0d00e96:	1900      	adds	r0, r0, r4
c0d00e98:	f000 fd66 	bl	c0d01968 <io_seproxyhal_display_default>
c0d00e9c:	68a8      	ldr	r0, [r5, #8]
c0d00e9e:	1c40      	adds	r0, r0, #1
c0d00ea0:	60a8      	str	r0, [r5, #8]
c0d00ea2:	e01c      	b.n	c0d00ede <io_event+0x28e>
c0d00ea4:	2801      	cmp	r0, #1
c0d00ea6:	d103      	bne.n	c0d00eb0 <io_event+0x260>
c0d00ea8:	68a8      	ldr	r0, [r5, #8]
c0d00eaa:	4344      	muls	r4, r0
c0d00eac:	6828      	ldr	r0, [r5, #0]
c0d00eae:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00eb0:	f000 fd5a 	bl	c0d01968 <io_seproxyhal_display_default>
c0d00eb4:	68a8      	ldr	r0, [r5, #8]
c0d00eb6:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00eb8:	60a8      	str	r0, [r5, #8]
c0d00eba:	6868      	ldr	r0, [r5, #4]
c0d00ebc:	68a9      	ldr	r1, [r5, #8]
c0d00ebe:	4281      	cmp	r1, r0
c0d00ec0:	d30d      	bcc.n	c0d00ede <io_event+0x28e>
c0d00ec2:	f001 fa9b 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00ec6:	e00a      	b.n	c0d00ede <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ec8:	2801      	cmp	r0, #1
c0d00eca:	d103      	bne.n	c0d00ed4 <io_event+0x284>
c0d00ecc:	68b0      	ldr	r0, [r6, #8]
c0d00ece:	4344      	muls	r4, r0
c0d00ed0:	6830      	ldr	r0, [r6, #0]
c0d00ed2:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00ed4:	f000 fd48 	bl	c0d01968 <io_seproxyhal_display_default>
c0d00ed8:	68b0      	ldr	r0, [r6, #8]
c0d00eda:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00edc:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00ede:	f001 fa8d 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d00ee2:	2800      	cmp	r0, #0
c0d00ee4:	d101      	bne.n	c0d00eea <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00ee6:	f000 fac9 	bl	c0d0147c <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00eea:	2001      	movs	r0, #1
c0d00eec:	b005      	add	sp, #20
c0d00eee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ef0:	20001a18 	.word	0x20001a18
c0d00ef4:	20001a98 	.word	0x20001a98
c0d00ef8:	b0105044 	.word	0xb0105044
c0d00efc:	b0105055 	.word	0xb0105055

c0d00f00 <IOTA_main>:





static void IOTA_main(void) {
c0d00f00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f02:	af03      	add	r7, sp, #12
c0d00f04:	b0dd      	sub	sp, #372	; 0x174
c0d00f06:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00f08:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00f0a:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00f0c:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00f0e:	a0a1      	add	r0, pc, #644	; (adr r0, c0d01194 <IOTA_main+0x294>)
c0d00f10:	2110      	movs	r1, #16
c0d00f12:	2203      	movs	r2, #3
c0d00f14:	9109      	str	r1, [sp, #36]	; 0x24
c0d00f16:	9208      	str	r2, [sp, #32]
c0d00f18:	f7ff f8c4 	bl	c0d000a4 <write_debug>
c0d00f1c:	a80e      	add	r0, sp, #56	; 0x38
c0d00f1e:	304d      	adds	r0, #77	; 0x4d
c0d00f20:	9007      	str	r0, [sp, #28]
c0d00f22:	a80b      	add	r0, sp, #44	; 0x2c
c0d00f24:	1dc1      	adds	r1, r0, #7
c0d00f26:	9106      	str	r1, [sp, #24]
c0d00f28:	1d00      	adds	r0, r0, #4
c0d00f2a:	9005      	str	r0, [sp, #20]
c0d00f2c:	4e9d      	ldr	r6, [pc, #628]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d00f2e:	6830      	ldr	r0, [r6, #0]
c0d00f30:	e08d      	b.n	c0d0104e <IOTA_main+0x14e>
c0d00f32:	489f      	ldr	r0, [pc, #636]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d00f34:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00f36:	4330      	orrs	r0, r6
c0d00f38:	2880      	cmp	r0, #128	; 0x80
c0d00f3a:	d000      	beq.n	c0d00f3e <IOTA_main+0x3e>
c0d00f3c:	e11e      	b.n	c0d0117c <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00f3e:	7810      	ldrb	r0, [r2, #0]
c0d00f40:	2800      	cmp	r0, #0
c0d00f42:	4e98      	ldr	r6, [pc, #608]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d00f44:	d004      	beq.n	c0d00f50 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00f46:	489c      	ldr	r0, [pc, #624]	; (c0d011b8 <IOTA_main+0x2b8>)
c0d00f48:	f001 f90c 	bl	c0d02164 <cx_sha256_init>
                        hashTainted = 0;
c0d00f4c:	4899      	ldr	r0, [pc, #612]	; (c0d011b4 <IOTA_main+0x2b4>)
c0d00f4e:	7004      	strb	r4, [r0, #0]
c0d00f50:	4897      	ldr	r0, [pc, #604]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d00f52:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00f54:	7908      	ldrb	r0, [r1, #4]
c0d00f56:	1808      	adds	r0, r1, r0
c0d00f58:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00f5a:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f5c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00f5e:	4308      	orrs	r0, r1
c0d00f60:	905a      	str	r0, [sp, #360]	; 0x168
c0d00f62:	e0e5      	b.n	c0d01130 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00f64:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00f66:	2818      	cmp	r0, #24
c0d00f68:	d800      	bhi.n	c0d00f6c <IOTA_main+0x6c>
c0d00f6a:	e10c      	b.n	c0d01186 <IOTA_main+0x286>
c0d00f6c:	950a      	str	r5, [sp, #40]	; 0x28
c0d00f6e:	4d90      	ldr	r5, [pc, #576]	; (c0d011b0 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00f70:	00a0      	lsls	r0, r4, #2
c0d00f72:	1829      	adds	r1, r5, r0
c0d00f74:	794a      	ldrb	r2, [r1, #5]
c0d00f76:	0612      	lsls	r2, r2, #24
c0d00f78:	798b      	ldrb	r3, [r1, #6]
c0d00f7a:	041b      	lsls	r3, r3, #16
c0d00f7c:	4313      	orrs	r3, r2
c0d00f7e:	79ca      	ldrb	r2, [r1, #7]
c0d00f80:	0212      	lsls	r2, r2, #8
c0d00f82:	431a      	orrs	r2, r3
c0d00f84:	7a09      	ldrb	r1, [r1, #8]
c0d00f86:	4311      	orrs	r1, r2
c0d00f88:	aa2b      	add	r2, sp, #172	; 0xac
c0d00f8a:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00f8c:	1c64      	adds	r4, r4, #1
c0d00f8e:	2c05      	cmp	r4, #5
c0d00f90:	d1ee      	bne.n	c0d00f70 <IOTA_main+0x70>
c0d00f92:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00f94:	9103      	str	r1, [sp, #12]
c0d00f96:	4668      	mov	r0, sp
c0d00f98:	6001      	str	r1, [r0, #0]
c0d00f9a:	2421      	movs	r4, #33	; 0x21
c0d00f9c:	a92b      	add	r1, sp, #172	; 0xac
c0d00f9e:	2205      	movs	r2, #5
c0d00fa0:	ad23      	add	r5, sp, #140	; 0x8c
c0d00fa2:	9502      	str	r5, [sp, #8]
c0d00fa4:	4620      	mov	r0, r4
c0d00fa6:	462b      	mov	r3, r5
c0d00fa8:	f001 f992 	bl	c0d022d0 <os_perso_derive_node_bip32>
c0d00fac:	2220      	movs	r2, #32
c0d00fae:	9204      	str	r2, [sp, #16]
c0d00fb0:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00fb2:	9301      	str	r3, [sp, #4]
c0d00fb4:	4620      	mov	r0, r4
c0d00fb6:	4629      	mov	r1, r5
c0d00fb8:	f001 f94e 	bl	c0d02258 <cx_ecfp_init_private_key>
c0d00fbc:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00fbe:	4620      	mov	r0, r4
c0d00fc0:	9903      	ldr	r1, [sp, #12]
c0d00fc2:	460a      	mov	r2, r1
c0d00fc4:	462b      	mov	r3, r5
c0d00fc6:	f001 f929 	bl	c0d0221c <cx_ecfp_init_public_key>
c0d00fca:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00fcc:	4620      	mov	r0, r4
c0d00fce:	4629      	mov	r1, r5
c0d00fd0:	9a01      	ldr	r2, [sp, #4]
c0d00fd2:	f001 f95f 	bl	c0d02294 <cx_ecfp_generate_pair>
c0d00fd6:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00fd8:	9802      	ldr	r0, [sp, #8]
c0d00fda:	9904      	ldr	r1, [sp, #16]
c0d00fdc:	4622      	mov	r2, r4
c0d00fde:	f7ff f981 	bl	c0d002e4 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00fe2:	2552      	movs	r5, #82	; 0x52
c0d00fe4:	4872      	ldr	r0, [pc, #456]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d00fe6:	4621      	mov	r1, r4
c0d00fe8:	462a      	mov	r2, r5
c0d00fea:	f000 f9ad 	bl	c0d01348 <os_memmove>
                    tx = 82;
c0d00fee:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00ff0:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ff2:	1c41      	adds	r1, r0, #1
c0d00ff4:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00ff6:	3610      	adds	r6, #16
c0d00ff8:	4a6d      	ldr	r2, [pc, #436]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d00ffa:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00ffc:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ffe:	1c41      	adds	r1, r0, #1
c0d01000:	915b      	str	r1, [sp, #364]	; 0x16c
c0d01002:	9903      	ldr	r1, [sp, #12]
c0d01004:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d01006:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d01008:	b281      	uxth	r1, r0
c0d0100a:	9804      	ldr	r0, [sp, #16]
c0d0100c:	f000 fd2a 	bl	c0d01a64 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d01010:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01012:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01014:	4308      	orrs	r0, r1
c0d01016:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d01018:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0101a:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d0101c:	202e      	movs	r0, #46	; 0x2e
c0d0101e:	9905      	ldr	r1, [sp, #20]
c0d01020:	7048      	strb	r0, [r1, #1]
c0d01022:	7008      	strb	r0, [r1, #0]
c0d01024:	7088      	strb	r0, [r1, #2]
c0d01026:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d01028:	78c8      	ldrb	r0, [r1, #3]
c0d0102a:	9a06      	ldr	r2, [sp, #24]
c0d0102c:	70d0      	strb	r0, [r2, #3]
c0d0102e:	7888      	ldrb	r0, [r1, #2]
c0d01030:	7090      	strb	r0, [r2, #2]
c0d01032:	7848      	ldrb	r0, [r1, #1]
c0d01034:	7050      	strb	r0, [r2, #1]
c0d01036:	7808      	ldrb	r0, [r1, #0]
c0d01038:	7010      	strb	r0, [r2, #0]
c0d0103a:	7908      	ldrb	r0, [r1, #4]
c0d0103c:	7110      	strb	r0, [r2, #4]
c0d0103e:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d01040:	2140      	movs	r1, #64	; 0x40
c0d01042:	2203      	movs	r2, #3
c0d01044:	f001 fa8a 	bl	c0d0255c <ui_display_debug>
c0d01048:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d0104a:	4e56      	ldr	r6, [pc, #344]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d0104c:	e070      	b.n	c0d01130 <IOTA_main+0x230>
c0d0104e:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d01050:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d01052:	9057      	str	r0, [sp, #348]	; 0x15c
c0d01054:	ac4d      	add	r4, sp, #308	; 0x134
c0d01056:	4620      	mov	r0, r4
c0d01058:	f002 fd52 	bl	c0d03b00 <setjmp>
c0d0105c:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0105e:	6034      	str	r4, [r6, #0]
c0d01060:	4951      	ldr	r1, [pc, #324]	; (c0d011a8 <IOTA_main+0x2a8>)
c0d01062:	4208      	tst	r0, r1
c0d01064:	d011      	beq.n	c0d0108a <IOTA_main+0x18a>
c0d01066:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d01068:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d0106a:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d0106c:	6031      	str	r1, [r6, #0]
c0d0106e:	210f      	movs	r1, #15
c0d01070:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d01072:	4001      	ands	r1, r0
c0d01074:	2209      	movs	r2, #9
c0d01076:	0312      	lsls	r2, r2, #12
c0d01078:	4291      	cmp	r1, r2
c0d0107a:	d003      	beq.n	c0d01084 <IOTA_main+0x184>
c0d0107c:	9a08      	ldr	r2, [sp, #32]
c0d0107e:	0352      	lsls	r2, r2, #13
c0d01080:	4291      	cmp	r1, r2
c0d01082:	d142      	bne.n	c0d0110a <IOTA_main+0x20a>
c0d01084:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d01086:	8008      	strh	r0, [r1, #0]
c0d01088:	e046      	b.n	c0d01118 <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d0108a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0108c:	905c      	str	r0, [sp, #368]	; 0x170
c0d0108e:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d01090:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d01092:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d01094:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d01096:	b2c0      	uxtb	r0, r0
c0d01098:	b289      	uxth	r1, r1
c0d0109a:	f000 fce3 	bl	c0d01a64 <io_exchange>
c0d0109e:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d010a0:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d010a2:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d010a4:	2800      	cmp	r0, #0
c0d010a6:	d053      	beq.n	c0d01150 <IOTA_main+0x250>
c0d010a8:	4941      	ldr	r1, [pc, #260]	; (c0d011b0 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d010aa:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d010ac:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d010ae:	2880      	cmp	r0, #128	; 0x80
c0d010b0:	4a40      	ldr	r2, [pc, #256]	; (c0d011b4 <IOTA_main+0x2b4>)
c0d010b2:	d155      	bne.n	c0d01160 <IOTA_main+0x260>
c0d010b4:	7848      	ldrb	r0, [r1, #1]
c0d010b6:	216d      	movs	r1, #109	; 0x6d
c0d010b8:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d010ba:	2807      	cmp	r0, #7
c0d010bc:	dc3f      	bgt.n	c0d0113e <IOTA_main+0x23e>
c0d010be:	2802      	cmp	r0, #2
c0d010c0:	d100      	bne.n	c0d010c4 <IOTA_main+0x1c4>
c0d010c2:	e74f      	b.n	c0d00f64 <IOTA_main+0x64>
c0d010c4:	2804      	cmp	r0, #4
c0d010c6:	d153      	bne.n	c0d01170 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d010c8:	210b      	movs	r1, #11
c0d010ca:	2203      	movs	r2, #3
c0d010cc:	a03c      	add	r0, pc, #240	; (adr r0, c0d011c0 <IOTA_main+0x2c0>)
c0d010ce:	f7fe ffe9 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d010d2:	2048      	movs	r0, #72	; 0x48
c0d010d4:	4936      	ldr	r1, [pc, #216]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d010d6:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d010d8:	2049      	movs	r0, #73	; 0x49
c0d010da:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d010dc:	2021      	movs	r0, #33	; 0x21
c0d010de:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d010e0:	3610      	adds	r6, #16
c0d010e2:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d010e4:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d010e6:	2005      	movs	r0, #5
c0d010e8:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d010ea:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d010ec:	b281      	uxth	r1, r0
c0d010ee:	2020      	movs	r0, #32
c0d010f0:	f000 fcb8 	bl	c0d01a64 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d010f4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d010f6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d010f8:	4308      	orrs	r0, r1
c0d010fa:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d010fc:	4620      	mov	r0, r4
c0d010fe:	4621      	mov	r1, r4
c0d01100:	4622      	mov	r2, r4
c0d01102:	f001 fa2b 	bl	c0d0255c <ui_display_debug>
c0d01106:	4e27      	ldr	r6, [pc, #156]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d01108:	e012      	b.n	c0d01130 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d0110a:	4928      	ldr	r1, [pc, #160]	; (c0d011ac <IOTA_main+0x2ac>)
c0d0110c:	4008      	ands	r0, r1
c0d0110e:	210d      	movs	r1, #13
c0d01110:	02c9      	lsls	r1, r1, #11
c0d01112:	4301      	orrs	r1, r0
c0d01114:	a859      	add	r0, sp, #356	; 0x164
c0d01116:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d01118:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d0111a:	0a00      	lsrs	r0, r0, #8
c0d0111c:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d0111e:	4a24      	ldr	r2, [pc, #144]	; (c0d011b0 <IOTA_main+0x2b0>)
c0d01120:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d01122:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d01124:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d01126:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d01128:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d0112a:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d0112c:	1c80      	adds	r0, r0, #2
c0d0112e:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d01130:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d01132:	6030      	str	r0, [r6, #0]
c0d01134:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d01136:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d01138:	2900      	cmp	r1, #0
c0d0113a:	d088      	beq.n	c0d0104e <IOTA_main+0x14e>
c0d0113c:	e006      	b.n	c0d0114c <IOTA_main+0x24c>
c0d0113e:	2808      	cmp	r0, #8
c0d01140:	d100      	bne.n	c0d01144 <IOTA_main+0x244>
c0d01142:	e6f6      	b.n	c0d00f32 <IOTA_main+0x32>
c0d01144:	28ff      	cmp	r0, #255	; 0xff
c0d01146:	d113      	bne.n	c0d01170 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d01148:	b05d      	add	sp, #372	; 0x174
c0d0114a:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d0114c:	f002 fce4 	bl	c0d03b18 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01150:	2001      	movs	r0, #1
c0d01152:	4918      	ldr	r1, [pc, #96]	; (c0d011b4 <IOTA_main+0x2b4>)
c0d01154:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d01156:	4813      	ldr	r0, [pc, #76]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d01158:	6800      	ldr	r0, [r0, #0]
c0d0115a:	491c      	ldr	r1, [pc, #112]	; (c0d011cc <IOTA_main+0x2cc>)
c0d0115c:	f002 fcdc 	bl	c0d03b18 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01160:	2001      	movs	r0, #1
c0d01162:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d01164:	480f      	ldr	r0, [pc, #60]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d01166:	6800      	ldr	r0, [r0, #0]
c0d01168:	2137      	movs	r1, #55	; 0x37
c0d0116a:	0249      	lsls	r1, r1, #9
c0d0116c:	f002 fcd4 	bl	c0d03b18 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d01170:	2001      	movs	r0, #1
c0d01172:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d01174:	480b      	ldr	r0, [pc, #44]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d01176:	6800      	ldr	r0, [r0, #0]
c0d01178:	f002 fcce 	bl	c0d03b18 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d0117c:	4809      	ldr	r0, [pc, #36]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d0117e:	6800      	ldr	r0, [r0, #0]
c0d01180:	490e      	ldr	r1, [pc, #56]	; (c0d011bc <IOTA_main+0x2bc>)
c0d01182:	f002 fcc9 	bl	c0d03b18 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d01186:	2001      	movs	r0, #1
c0d01188:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d0118a:	4806      	ldr	r0, [pc, #24]	; (c0d011a4 <IOTA_main+0x2a4>)
c0d0118c:	6800      	ldr	r0, [r0, #0]
c0d0118e:	3109      	adds	r1, #9
c0d01190:	f002 fcc2 	bl	c0d03b18 <longjmp>
c0d01194:	74696157 	.word	0x74696157
c0d01198:	20676e69 	.word	0x20676e69
c0d0119c:	20726f66 	.word	0x20726f66
c0d011a0:	0067736d 	.word	0x0067736d
c0d011a4:	20001bb8 	.word	0x20001bb8
c0d011a8:	0000ffff 	.word	0x0000ffff
c0d011ac:	000007ff 	.word	0x000007ff
c0d011b0:	20001c08 	.word	0x20001c08
c0d011b4:	20001b48 	.word	0x20001b48
c0d011b8:	20001b4c 	.word	0x20001b4c
c0d011bc:	00006a86 	.word	0x00006a86
c0d011c0:	20646142 	.word	0x20646142
c0d011c4:	6b627550 	.word	0x6b627550
c0d011c8:	00007965 	.word	0x00007965
c0d011cc:	00006982 	.word	0x00006982

c0d011d0 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d011d0:	4801      	ldr	r0, [pc, #4]	; (c0d011d8 <os_boot+0x8>)
c0d011d2:	2100      	movs	r1, #0
c0d011d4:	6001      	str	r1, [r0, #0]
}
c0d011d6:	4770      	bx	lr
c0d011d8:	20001bb8 	.word	0x20001bb8

c0d011dc <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d011dc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011de:	af03      	add	r7, sp, #12
c0d011e0:	b083      	sub	sp, #12
c0d011e2:	9202      	str	r2, [sp, #8]
c0d011e4:	460c      	mov	r4, r1
c0d011e6:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d011e8:	4d4a      	ldr	r5, [pc, #296]	; (c0d01314 <io_usb_hid_receive+0x138>)
c0d011ea:	42ac      	cmp	r4, r5
c0d011ec:	d00f      	beq.n	c0d0120e <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d011ee:	4e49      	ldr	r6, [pc, #292]	; (c0d01314 <io_usb_hid_receive+0x138>)
c0d011f0:	2540      	movs	r5, #64	; 0x40
c0d011f2:	4630      	mov	r0, r6
c0d011f4:	4629      	mov	r1, r5
c0d011f6:	f002 fbed 	bl	c0d039d4 <__aeabi_memclr>
c0d011fa:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d011fc:	2840      	cmp	r0, #64	; 0x40
c0d011fe:	4602      	mov	r2, r0
c0d01200:	d300      	bcc.n	c0d01204 <io_usb_hid_receive+0x28>
c0d01202:	462a      	mov	r2, r5
c0d01204:	4630      	mov	r0, r6
c0d01206:	4621      	mov	r1, r4
c0d01208:	f000 f89e 	bl	c0d01348 <os_memmove>
c0d0120c:	4d41      	ldr	r5, [pc, #260]	; (c0d01314 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d0120e:	78a8      	ldrb	r0, [r5, #2]
c0d01210:	2805      	cmp	r0, #5
c0d01212:	d900      	bls.n	c0d01216 <io_usb_hid_receive+0x3a>
c0d01214:	e076      	b.n	c0d01304 <io_usb_hid_receive+0x128>
c0d01216:	46c0      	nop			; (mov r8, r8)
c0d01218:	4478      	add	r0, pc
c0d0121a:	7900      	ldrb	r0, [r0, #4]
c0d0121c:	0040      	lsls	r0, r0, #1
c0d0121e:	4487      	add	pc, r0
c0d01220:	71130c02 	.word	0x71130c02
c0d01224:	1f71      	.short	0x1f71
c0d01226:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01228:	71ae      	strb	r6, [r5, #6]
c0d0122a:	716e      	strb	r6, [r5, #5]
c0d0122c:	712e      	strb	r6, [r5, #4]
c0d0122e:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01230:	2140      	movs	r1, #64	; 0x40
c0d01232:	4628      	mov	r0, r5
c0d01234:	9a01      	ldr	r2, [sp, #4]
c0d01236:	4790      	blx	r2
c0d01238:	e00b      	b.n	c0d01252 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d0123a:	1ce8      	adds	r0, r5, #3
c0d0123c:	2104      	movs	r1, #4
c0d0123e:	f000 ff73 	bl	c0d02128 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01242:	2140      	movs	r1, #64	; 0x40
c0d01244:	4628      	mov	r0, r5
c0d01246:	e001      	b.n	c0d0124c <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d01248:	4832      	ldr	r0, [pc, #200]	; (c0d01314 <io_usb_hid_receive+0x138>)
c0d0124a:	2140      	movs	r1, #64	; 0x40
c0d0124c:	9a01      	ldr	r2, [sp, #4]
c0d0124e:	4790      	blx	r2
c0d01250:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01252:	4831      	ldr	r0, [pc, #196]	; (c0d01318 <io_usb_hid_receive+0x13c>)
c0d01254:	2100      	movs	r1, #0
c0d01256:	6001      	str	r1, [r0, #0]
c0d01258:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0125a:	b2c0      	uxtb	r0, r0
c0d0125c:	b003      	add	sp, #12
c0d0125e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01260:	78e8      	ldrb	r0, [r5, #3]
c0d01262:	4c2d      	ldr	r4, [pc, #180]	; (c0d01318 <io_usb_hid_receive+0x13c>)
c0d01264:	6821      	ldr	r1, [r4, #0]
c0d01266:	0a09      	lsrs	r1, r1, #8
c0d01268:	2600      	movs	r6, #0
c0d0126a:	4288      	cmp	r0, r1
c0d0126c:	d1f1      	bne.n	c0d01252 <io_usb_hid_receive+0x76>
c0d0126e:	7928      	ldrb	r0, [r5, #4]
c0d01270:	6821      	ldr	r1, [r4, #0]
c0d01272:	b2c9      	uxtb	r1, r1
c0d01274:	4288      	cmp	r0, r1
c0d01276:	d1ec      	bne.n	c0d01252 <io_usb_hid_receive+0x76>
c0d01278:	4b28      	ldr	r3, [pc, #160]	; (c0d0131c <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d0127a:	9802      	ldr	r0, [sp, #8]
c0d0127c:	18c0      	adds	r0, r0, r3
c0d0127e:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01280:	6820      	ldr	r0, [r4, #0]
c0d01282:	2800      	cmp	r0, #0
c0d01284:	d00e      	beq.n	c0d012a4 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d01286:	4629      	mov	r1, r5
c0d01288:	4019      	ands	r1, r3
c0d0128a:	4825      	ldr	r0, [pc, #148]	; (c0d01320 <io_usb_hid_receive+0x144>)
c0d0128c:	6802      	ldr	r2, [r0, #0]
c0d0128e:	4291      	cmp	r1, r2
c0d01290:	461e      	mov	r6, r3
c0d01292:	d900      	bls.n	c0d01296 <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01294:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d01296:	462a      	mov	r2, r5
c0d01298:	4032      	ands	r2, r6
c0d0129a:	4822      	ldr	r0, [pc, #136]	; (c0d01324 <io_usb_hid_receive+0x148>)
c0d0129c:	6800      	ldr	r0, [r0, #0]
c0d0129e:	491d      	ldr	r1, [pc, #116]	; (c0d01314 <io_usb_hid_receive+0x138>)
c0d012a0:	1d49      	adds	r1, r1, #5
c0d012a2:	e021      	b.n	c0d012e8 <io_usb_hid_receive+0x10c>
c0d012a4:	9301      	str	r3, [sp, #4]
c0d012a6:	491b      	ldr	r1, [pc, #108]	; (c0d01314 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d012a8:	7988      	ldrb	r0, [r1, #6]
c0d012aa:	7949      	ldrb	r1, [r1, #5]
c0d012ac:	0209      	lsls	r1, r1, #8
c0d012ae:	4301      	orrs	r1, r0
c0d012b0:	481d      	ldr	r0, [pc, #116]	; (c0d01328 <io_usb_hid_receive+0x14c>)
c0d012b2:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d012b4:	6801      	ldr	r1, [r0, #0]
c0d012b6:	2241      	movs	r2, #65	; 0x41
c0d012b8:	0092      	lsls	r2, r2, #2
c0d012ba:	4291      	cmp	r1, r2
c0d012bc:	d8c9      	bhi.n	c0d01252 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d012be:	6801      	ldr	r1, [r0, #0]
c0d012c0:	4817      	ldr	r0, [pc, #92]	; (c0d01320 <io_usb_hid_receive+0x144>)
c0d012c2:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d012c4:	4917      	ldr	r1, [pc, #92]	; (c0d01324 <io_usb_hid_receive+0x148>)
c0d012c6:	4a19      	ldr	r2, [pc, #100]	; (c0d0132c <io_usb_hid_receive+0x150>)
c0d012c8:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d012ca:	4919      	ldr	r1, [pc, #100]	; (c0d01330 <io_usb_hid_receive+0x154>)
c0d012cc:	9a02      	ldr	r2, [sp, #8]
c0d012ce:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d012d0:	4629      	mov	r1, r5
c0d012d2:	9e01      	ldr	r6, [sp, #4]
c0d012d4:	4031      	ands	r1, r6
c0d012d6:	6802      	ldr	r2, [r0, #0]
c0d012d8:	4291      	cmp	r1, r2
c0d012da:	d900      	bls.n	c0d012de <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d012dc:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d012de:	462a      	mov	r2, r5
c0d012e0:	4032      	ands	r2, r6
c0d012e2:	480c      	ldr	r0, [pc, #48]	; (c0d01314 <io_usb_hid_receive+0x138>)
c0d012e4:	1dc1      	adds	r1, r0, #7
c0d012e6:	4811      	ldr	r0, [pc, #68]	; (c0d0132c <io_usb_hid_receive+0x150>)
c0d012e8:	f000 f82e 	bl	c0d01348 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d012ec:	4035      	ands	r5, r6
c0d012ee:	480d      	ldr	r0, [pc, #52]	; (c0d01324 <io_usb_hid_receive+0x148>)
c0d012f0:	6801      	ldr	r1, [r0, #0]
c0d012f2:	1949      	adds	r1, r1, r5
c0d012f4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d012f6:	480a      	ldr	r0, [pc, #40]	; (c0d01320 <io_usb_hid_receive+0x144>)
c0d012f8:	6801      	ldr	r1, [r0, #0]
c0d012fa:	1b49      	subs	r1, r1, r5
c0d012fc:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d012fe:	6820      	ldr	r0, [r4, #0]
c0d01300:	1c40      	adds	r0, r0, #1
c0d01302:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d01304:	4806      	ldr	r0, [pc, #24]	; (c0d01320 <io_usb_hid_receive+0x144>)
c0d01306:	6801      	ldr	r1, [r0, #0]
c0d01308:	2001      	movs	r0, #1
c0d0130a:	2602      	movs	r6, #2
c0d0130c:	2900      	cmp	r1, #0
c0d0130e:	d1a4      	bne.n	c0d0125a <io_usb_hid_receive+0x7e>
c0d01310:	e79f      	b.n	c0d01252 <io_usb_hid_receive+0x76>
c0d01312:	46c0      	nop			; (mov r8, r8)
c0d01314:	20001bbc 	.word	0x20001bbc
c0d01318:	20001bfc 	.word	0x20001bfc
c0d0131c:	0000ffff 	.word	0x0000ffff
c0d01320:	20001c04 	.word	0x20001c04
c0d01324:	20001d0c 	.word	0x20001d0c
c0d01328:	20001c00 	.word	0x20001c00
c0d0132c:	20001c08 	.word	0x20001c08
c0d01330:	0001fff9 	.word	0x0001fff9

c0d01334 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d01334:	b580      	push	{r7, lr}
c0d01336:	af00      	add	r7, sp, #0
c0d01338:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d0133a:	2a00      	cmp	r2, #0
c0d0133c:	d003      	beq.n	c0d01346 <os_memset+0x12>
    DSTCHAR[length] = c;
c0d0133e:	4611      	mov	r1, r2
c0d01340:	461a      	mov	r2, r3
c0d01342:	f002 fb51 	bl	c0d039e8 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d01346:	bd80      	pop	{r7, pc}

c0d01348 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01348:	b5b0      	push	{r4, r5, r7, lr}
c0d0134a:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d0134c:	4288      	cmp	r0, r1
c0d0134e:	d90d      	bls.n	c0d0136c <os_memmove+0x24>
    while(length--) {
c0d01350:	2a00      	cmp	r2, #0
c0d01352:	d014      	beq.n	c0d0137e <os_memmove+0x36>
c0d01354:	1e49      	subs	r1, r1, #1
c0d01356:	4252      	negs	r2, r2
c0d01358:	1e40      	subs	r0, r0, #1
c0d0135a:	2300      	movs	r3, #0
c0d0135c:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d0135e:	461c      	mov	r4, r3
c0d01360:	4354      	muls	r4, r2
c0d01362:	5d0d      	ldrb	r5, [r1, r4]
c0d01364:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d01366:	1c52      	adds	r2, r2, #1
c0d01368:	d1f9      	bne.n	c0d0135e <os_memmove+0x16>
c0d0136a:	e008      	b.n	c0d0137e <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0136c:	2a00      	cmp	r2, #0
c0d0136e:	d006      	beq.n	c0d0137e <os_memmove+0x36>
c0d01370:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01372:	b29c      	uxth	r4, r3
c0d01374:	5d0d      	ldrb	r5, [r1, r4]
c0d01376:	5505      	strb	r5, [r0, r4]
      l++;
c0d01378:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0137a:	1e52      	subs	r2, r2, #1
c0d0137c:	d1f9      	bne.n	c0d01372 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d0137e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01380 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01380:	4801      	ldr	r0, [pc, #4]	; (c0d01388 <io_usb_hid_init+0x8>)
c0d01382:	2100      	movs	r1, #0
c0d01384:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d01386:	4770      	bx	lr
c0d01388:	20001bfc 	.word	0x20001bfc

c0d0138c <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d0138c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0138e:	af03      	add	r7, sp, #12
c0d01390:	b087      	sub	sp, #28
c0d01392:	9301      	str	r3, [sp, #4]
c0d01394:	9203      	str	r2, [sp, #12]
c0d01396:	460e      	mov	r6, r1
c0d01398:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d0139a:	2e00      	cmp	r6, #0
c0d0139c:	d042      	beq.n	c0d01424 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d0139e:	4d31      	ldr	r5, [pc, #196]	; (c0d01464 <io_usb_hid_exchange+0xd8>)
c0d013a0:	2000      	movs	r0, #0
c0d013a2:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d013a4:	4930      	ldr	r1, [pc, #192]	; (c0d01468 <io_usb_hid_exchange+0xdc>)
c0d013a6:	4831      	ldr	r0, [pc, #196]	; (c0d0146c <io_usb_hid_exchange+0xe0>)
c0d013a8:	6008      	str	r0, [r1, #0]
c0d013aa:	4c31      	ldr	r4, [pc, #196]	; (c0d01470 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d013ac:	1d60      	adds	r0, r4, #5
c0d013ae:	213b      	movs	r1, #59	; 0x3b
c0d013b0:	9005      	str	r0, [sp, #20]
c0d013b2:	9102      	str	r1, [sp, #8]
c0d013b4:	f002 fb0e 	bl	c0d039d4 <__aeabi_memclr>
c0d013b8:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d013ba:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d013bc:	6828      	ldr	r0, [r5, #0]
c0d013be:	0a00      	lsrs	r0, r0, #8
c0d013c0:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d013c2:	6828      	ldr	r0, [r5, #0]
c0d013c4:	7120      	strb	r0, [r4, #4]
c0d013c6:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d013c8:	6828      	ldr	r0, [r5, #0]
c0d013ca:	2800      	cmp	r0, #0
c0d013cc:	9106      	str	r1, [sp, #24]
c0d013ce:	d009      	beq.n	c0d013e4 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d013d0:	293b      	cmp	r1, #59	; 0x3b
c0d013d2:	460a      	mov	r2, r1
c0d013d4:	d300      	bcc.n	c0d013d8 <io_usb_hid_exchange+0x4c>
c0d013d6:	9a02      	ldr	r2, [sp, #8]
c0d013d8:	4823      	ldr	r0, [pc, #140]	; (c0d01468 <io_usb_hid_exchange+0xdc>)
c0d013da:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d013dc:	6819      	ldr	r1, [r3, #0]
c0d013de:	9805      	ldr	r0, [sp, #20]
c0d013e0:	461e      	mov	r6, r3
c0d013e2:	e00a      	b.n	c0d013fa <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d013e4:	0a30      	lsrs	r0, r6, #8
c0d013e6:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d013e8:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d013ea:	2039      	movs	r0, #57	; 0x39
c0d013ec:	2939      	cmp	r1, #57	; 0x39
c0d013ee:	460a      	mov	r2, r1
c0d013f0:	d300      	bcc.n	c0d013f4 <io_usb_hid_exchange+0x68>
c0d013f2:	4602      	mov	r2, r0
c0d013f4:	4e1c      	ldr	r6, [pc, #112]	; (c0d01468 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d013f6:	6831      	ldr	r1, [r6, #0]
c0d013f8:	1de0      	adds	r0, r4, #7
c0d013fa:	9205      	str	r2, [sp, #20]
c0d013fc:	f7ff ffa4 	bl	c0d01348 <os_memmove>
c0d01400:	4d18      	ldr	r5, [pc, #96]	; (c0d01464 <io_usb_hid_exchange+0xd8>)
c0d01402:	6830      	ldr	r0, [r6, #0]
c0d01404:	4631      	mov	r1, r6
c0d01406:	9e05      	ldr	r6, [sp, #20]
c0d01408:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d0140a:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d0140c:	6828      	ldr	r0, [r5, #0]
c0d0140e:	1c40      	adds	r0, r0, #1
c0d01410:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d01412:	2140      	movs	r1, #64	; 0x40
c0d01414:	4620      	mov	r0, r4
c0d01416:	9a04      	ldr	r2, [sp, #16]
c0d01418:	4790      	blx	r2
c0d0141a:	9806      	ldr	r0, [sp, #24]
c0d0141c:	1b86      	subs	r6, r0, r6
c0d0141e:	4815      	ldr	r0, [pc, #84]	; (c0d01474 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d01420:	4206      	tst	r6, r0
c0d01422:	d1c3      	bne.n	c0d013ac <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01424:	480f      	ldr	r0, [pc, #60]	; (c0d01464 <io_usb_hid_exchange+0xd8>)
c0d01426:	2400      	movs	r4, #0
c0d01428:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d0142a:	2080      	movs	r0, #128	; 0x80
c0d0142c:	9901      	ldr	r1, [sp, #4]
c0d0142e:	4201      	tst	r1, r0
c0d01430:	d001      	beq.n	c0d01436 <io_usb_hid_exchange+0xaa>
    reset();
c0d01432:	f000 fe3f 	bl	c0d020b4 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d01436:	9801      	ldr	r0, [sp, #4]
c0d01438:	0680      	lsls	r0, r0, #26
c0d0143a:	d40f      	bmi.n	c0d0145c <io_usb_hid_exchange+0xd0>
c0d0143c:	4c0c      	ldr	r4, [pc, #48]	; (c0d01470 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d0143e:	2140      	movs	r1, #64	; 0x40
c0d01440:	4620      	mov	r0, r4
c0d01442:	9a03      	ldr	r2, [sp, #12]
c0d01444:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d01446:	b2c2      	uxtb	r2, r0
c0d01448:	2a40      	cmp	r2, #64	; 0x40
c0d0144a:	d8f8      	bhi.n	c0d0143e <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d0144c:	9804      	ldr	r0, [sp, #16]
c0d0144e:	4621      	mov	r1, r4
c0d01450:	f7ff fec4 	bl	c0d011dc <io_usb_hid_receive>
c0d01454:	2802      	cmp	r0, #2
c0d01456:	d1f2      	bne.n	c0d0143e <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d01458:	4807      	ldr	r0, [pc, #28]	; (c0d01478 <io_usb_hid_exchange+0xec>)
c0d0145a:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d0145c:	b2a0      	uxth	r0, r4
c0d0145e:	b007      	add	sp, #28
c0d01460:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01462:	46c0      	nop			; (mov r8, r8)
c0d01464:	20001bfc 	.word	0x20001bfc
c0d01468:	20001d0c 	.word	0x20001d0c
c0d0146c:	20001c08 	.word	0x20001c08
c0d01470:	20001bbc 	.word	0x20001bbc
c0d01474:	0000ffff 	.word	0x0000ffff
c0d01478:	20001c00 	.word	0x20001c00

c0d0147c <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d0147c:	b580      	push	{r7, lr}
c0d0147e:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01480:	f000 ffbc 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d01484:	2800      	cmp	r0, #0
c0d01486:	d10b      	bne.n	c0d014a0 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01488:	4806      	ldr	r0, [pc, #24]	; (c0d014a4 <io_seproxyhal_general_status+0x28>)
c0d0148a:	2160      	movs	r1, #96	; 0x60
c0d0148c:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0148e:	2100      	movs	r1, #0
c0d01490:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01492:	2202      	movs	r2, #2
c0d01494:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d01496:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01498:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0149a:	2105      	movs	r1, #5
c0d0149c:	f000 ff90 	bl	c0d023c0 <io_seproxyhal_spi_send>
}
c0d014a0:	bd80      	pop	{r7, pc}
c0d014a2:	46c0      	nop			; (mov r8, r8)
c0d014a4:	20001a18 	.word	0x20001a18

c0d014a8 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d014a8:	b5d0      	push	{r4, r6, r7, lr}
c0d014aa:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d014ac:	4815      	ldr	r0, [pc, #84]	; (c0d01504 <io_seproxyhal_handle_usb_event+0x5c>)
c0d014ae:	78c0      	ldrb	r0, [r0, #3]
c0d014b0:	1e40      	subs	r0, r0, #1
c0d014b2:	2807      	cmp	r0, #7
c0d014b4:	d824      	bhi.n	c0d01500 <io_seproxyhal_handle_usb_event+0x58>
c0d014b6:	46c0      	nop			; (mov r8, r8)
c0d014b8:	4478      	add	r0, pc
c0d014ba:	7900      	ldrb	r0, [r0, #4]
c0d014bc:	0040      	lsls	r0, r0, #1
c0d014be:	4487      	add	pc, r0
c0d014c0:	141f1803 	.word	0x141f1803
c0d014c4:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d014c8:	4c0f      	ldr	r4, [pc, #60]	; (c0d01508 <io_seproxyhal_handle_usb_event+0x60>)
c0d014ca:	2101      	movs	r1, #1
c0d014cc:	4620      	mov	r0, r4
c0d014ce:	f001 fbd5 	bl	c0d02c7c <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d014d2:	4620      	mov	r0, r4
c0d014d4:	f001 fbba 	bl	c0d02c4c <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d014d8:	480c      	ldr	r0, [pc, #48]	; (c0d0150c <io_seproxyhal_handle_usb_event+0x64>)
c0d014da:	7800      	ldrb	r0, [r0, #0]
c0d014dc:	2801      	cmp	r0, #1
c0d014de:	d10f      	bne.n	c0d01500 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d014e0:	480b      	ldr	r0, [pc, #44]	; (c0d01510 <io_seproxyhal_handle_usb_event+0x68>)
c0d014e2:	6800      	ldr	r0, [r0, #0]
c0d014e4:	2110      	movs	r1, #16
c0d014e6:	f002 fb17 	bl	c0d03b18 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d014ea:	4807      	ldr	r0, [pc, #28]	; (c0d01508 <io_seproxyhal_handle_usb_event+0x60>)
c0d014ec:	f001 fbc9 	bl	c0d02c82 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d014f0:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d014f2:	4805      	ldr	r0, [pc, #20]	; (c0d01508 <io_seproxyhal_handle_usb_event+0x60>)
c0d014f4:	f001 fbc9 	bl	c0d02c8a <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d014f8:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d014fa:	4803      	ldr	r0, [pc, #12]	; (c0d01508 <io_seproxyhal_handle_usb_event+0x60>)
c0d014fc:	f001 fbc3 	bl	c0d02c86 <USBD_LL_Resume>
      break;
  }
}
c0d01500:	bdd0      	pop	{r4, r6, r7, pc}
c0d01502:	46c0      	nop			; (mov r8, r8)
c0d01504:	20001a18 	.word	0x20001a18
c0d01508:	20001d34 	.word	0x20001d34
c0d0150c:	20001d10 	.word	0x20001d10
c0d01510:	20001bb8 	.word	0x20001bb8

c0d01514 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01514:	217f      	movs	r1, #127	; 0x7f
c0d01516:	4001      	ands	r1, r0
c0d01518:	4801      	ldr	r0, [pc, #4]	; (c0d01520 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d0151a:	5c40      	ldrb	r0, [r0, r1]
c0d0151c:	4770      	bx	lr
c0d0151e:	46c0      	nop			; (mov r8, r8)
c0d01520:	20001d11 	.word	0x20001d11

c0d01524 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01524:	b580      	push	{r7, lr}
c0d01526:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01528:	480f      	ldr	r0, [pc, #60]	; (c0d01568 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d0152a:	7901      	ldrb	r1, [r0, #4]
c0d0152c:	2904      	cmp	r1, #4
c0d0152e:	d008      	beq.n	c0d01542 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d01530:	2902      	cmp	r1, #2
c0d01532:	d011      	beq.n	c0d01558 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d01534:	2901      	cmp	r1, #1
c0d01536:	d10e      	bne.n	c0d01556 <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01538:	1d81      	adds	r1, r0, #6
c0d0153a:	480d      	ldr	r0, [pc, #52]	; (c0d01570 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d0153c:	f001 faaa 	bl	c0d02a94 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01540:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01542:	78c2      	ldrb	r2, [r0, #3]
c0d01544:	217f      	movs	r1, #127	; 0x7f
c0d01546:	4011      	ands	r1, r2
c0d01548:	7942      	ldrb	r2, [r0, #5]
c0d0154a:	4b08      	ldr	r3, [pc, #32]	; (c0d0156c <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d0154c:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0154e:	1d82      	adds	r2, r0, #6
c0d01550:	4807      	ldr	r0, [pc, #28]	; (c0d01570 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01552:	f001 fad1 	bl	c0d02af8 <USBD_LL_DataOutStage>
      break;
  }
}
c0d01556:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01558:	78c2      	ldrb	r2, [r0, #3]
c0d0155a:	217f      	movs	r1, #127	; 0x7f
c0d0155c:	4011      	ands	r1, r2
c0d0155e:	1d82      	adds	r2, r0, #6
c0d01560:	4803      	ldr	r0, [pc, #12]	; (c0d01570 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01562:	f001 fb0f 	bl	c0d02b84 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d01566:	bd80      	pop	{r7, pc}
c0d01568:	20001a18 	.word	0x20001a18
c0d0156c:	20001d11 	.word	0x20001d11
c0d01570:	20001d34 	.word	0x20001d34

c0d01574 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01574:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01576:	af03      	add	r7, sp, #12
c0d01578:	b083      	sub	sp, #12
c0d0157a:	9201      	str	r2, [sp, #4]
c0d0157c:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d0157e:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01580:	2b00      	cmp	r3, #0
c0d01582:	d100      	bne.n	c0d01586 <io_usb_send_ep+0x12>
c0d01584:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d01586:	9801      	ldr	r0, [sp, #4]
c0d01588:	28ff      	cmp	r0, #255	; 0xff
c0d0158a:	d843      	bhi.n	c0d01614 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0158c:	4e25      	ldr	r6, [pc, #148]	; (c0d01624 <io_usb_send_ep+0xb0>)
c0d0158e:	2050      	movs	r0, #80	; 0x50
c0d01590:	7030      	strb	r0, [r6, #0]
c0d01592:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01594:	1ce0      	adds	r0, r4, #3
c0d01596:	9100      	str	r1, [sp, #0]
c0d01598:	0a01      	lsrs	r1, r0, #8
c0d0159a:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d0159c:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d0159e:	2080      	movs	r0, #128	; 0x80
c0d015a0:	4302      	orrs	r2, r0
c0d015a2:	9202      	str	r2, [sp, #8]
c0d015a4:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d015a6:	2020      	movs	r0, #32
c0d015a8:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d015aa:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d015ac:	2106      	movs	r1, #6
c0d015ae:	4630      	mov	r0, r6
c0d015b0:	f000 ff06 	bl	c0d023c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d015b4:	9800      	ldr	r0, [sp, #0]
c0d015b6:	4621      	mov	r1, r4
c0d015b8:	f000 ff02 	bl	c0d023c0 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d015bc:	2d00      	cmp	r5, #0
c0d015be:	d10d      	bne.n	c0d015dc <io_usb_send_ep+0x68>
c0d015c0:	e028      	b.n	c0d01614 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d015c2:	2d00      	cmp	r5, #0
c0d015c4:	d002      	beq.n	c0d015cc <io_usb_send_ep+0x58>
c0d015c6:	1e6c      	subs	r4, r5, #1
c0d015c8:	2d01      	cmp	r5, #1
c0d015ca:	d025      	beq.n	c0d01618 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d015cc:	2915      	cmp	r1, #21
c0d015ce:	d102      	bne.n	c0d015d6 <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d015d0:	79b0      	ldrb	r0, [r6, #6]
c0d015d2:	0700      	lsls	r0, r0, #28
c0d015d4:	d520      	bpl.n	c0d01618 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d015d6:	f000 f829 	bl	c0d0162c <io_seproxyhal_handle_event>
c0d015da:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d015dc:	f000 ff0e 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d015e0:	2800      	cmp	r0, #0
c0d015e2:	d101      	bne.n	c0d015e8 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d015e4:	f7ff ff4a 	bl	c0d0147c <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d015e8:	2180      	movs	r1, #128	; 0x80
c0d015ea:	2400      	movs	r4, #0
c0d015ec:	4630      	mov	r0, r6
c0d015ee:	4622      	mov	r2, r4
c0d015f0:	f000 ff20 	bl	c0d02434 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d015f4:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d015f6:	2806      	cmp	r0, #6
c0d015f8:	d1e3      	bne.n	c0d015c2 <io_usb_send_ep+0x4e>
c0d015fa:	2910      	cmp	r1, #16
c0d015fc:	d1e1      	bne.n	c0d015c2 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d015fe:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d01600:	9a02      	ldr	r2, [sp, #8]
c0d01602:	4290      	cmp	r0, r2
c0d01604:	d1dd      	bne.n	c0d015c2 <io_usb_send_ep+0x4e>
c0d01606:	7930      	ldrb	r0, [r6, #4]
c0d01608:	2802      	cmp	r0, #2
c0d0160a:	d1da      	bne.n	c0d015c2 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d0160c:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d0160e:	9a01      	ldr	r2, [sp, #4]
c0d01610:	4290      	cmp	r0, r2
c0d01612:	d1d6      	bne.n	c0d015c2 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d01614:	b003      	add	sp, #12
c0d01616:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01618:	4803      	ldr	r0, [pc, #12]	; (c0d01628 <io_usb_send_ep+0xb4>)
c0d0161a:	6800      	ldr	r0, [r0, #0]
c0d0161c:	2110      	movs	r1, #16
c0d0161e:	f002 fa7b 	bl	c0d03b18 <longjmp>
c0d01622:	46c0      	nop			; (mov r8, r8)
c0d01624:	20001a18 	.word	0x20001a18
c0d01628:	20001bb8 	.word	0x20001bb8

c0d0162c <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d0162c:	b580      	push	{r7, lr}
c0d0162e:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01630:	480d      	ldr	r0, [pc, #52]	; (c0d01668 <io_seproxyhal_handle_event+0x3c>)
c0d01632:	7882      	ldrb	r2, [r0, #2]
c0d01634:	7841      	ldrb	r1, [r0, #1]
c0d01636:	0209      	lsls	r1, r1, #8
c0d01638:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0163a:	7800      	ldrb	r0, [r0, #0]
c0d0163c:	2810      	cmp	r0, #16
c0d0163e:	d008      	beq.n	c0d01652 <io_seproxyhal_handle_event+0x26>
c0d01640:	280f      	cmp	r0, #15
c0d01642:	d10d      	bne.n	c0d01660 <io_seproxyhal_handle_event+0x34>
c0d01644:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d01646:	2904      	cmp	r1, #4
c0d01648:	d10d      	bne.n	c0d01666 <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0164a:	f7ff ff2d 	bl	c0d014a8 <io_seproxyhal_handle_usb_event>
c0d0164e:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01650:	bd80      	pop	{r7, pc}
c0d01652:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01654:	2906      	cmp	r1, #6
c0d01656:	d306      	bcc.n	c0d01666 <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01658:	f7ff ff64 	bl	c0d01524 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d0165c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d0165e:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01660:	2002      	movs	r0, #2
c0d01662:	f7ff faf5 	bl	c0d00c50 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d01666:	bd80      	pop	{r7, pc}
c0d01668:	20001a18 	.word	0x20001a18

c0d0166c <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d0166c:	b580      	push	{r7, lr}
c0d0166e:	af00      	add	r7, sp, #0
c0d01670:	460a      	mov	r2, r1
c0d01672:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01674:	2082      	movs	r0, #130	; 0x82
c0d01676:	2314      	movs	r3, #20
c0d01678:	f7ff ff7c 	bl	c0d01574 <io_usb_send_ep>
}
c0d0167c:	bd80      	pop	{r7, pc}
	...

c0d01680 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01680:	b5d0      	push	{r4, r6, r7, lr}
c0d01682:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01684:	2007      	movs	r0, #7
c0d01686:	f000 fcf7 	bl	c0d02078 <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0168a:	480a      	ldr	r0, [pc, #40]	; (c0d016b4 <io_seproxyhal_init+0x34>)
c0d0168c:	2400      	movs	r4, #0
c0d0168e:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01690:	4809      	ldr	r0, [pc, #36]	; (c0d016b8 <io_seproxyhal_init+0x38>)
c0d01692:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01694:	4809      	ldr	r0, [pc, #36]	; (c0d016bc <io_seproxyhal_init+0x3c>)
c0d01696:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d01698:	4809      	ldr	r0, [pc, #36]	; (c0d016c0 <io_seproxyhal_init+0x40>)
c0d0169a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0169c:	4809      	ldr	r0, [pc, #36]	; (c0d016c4 <io_seproxyhal_init+0x44>)
c0d0169e:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d016a0:	f7ff fe6e 	bl	c0d01380 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d016a4:	4808      	ldr	r0, [pc, #32]	; (c0d016c8 <io_seproxyhal_init+0x48>)
c0d016a6:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d016a8:	4808      	ldr	r0, [pc, #32]	; (c0d016cc <io_seproxyhal_init+0x4c>)
c0d016aa:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d016ac:	4808      	ldr	r0, [pc, #32]	; (c0d016d0 <io_seproxyhal_init+0x50>)
c0d016ae:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d016b0:	bdd0      	pop	{r4, r6, r7, pc}
c0d016b2:	46c0      	nop			; (mov r8, r8)
c0d016b4:	20001d18 	.word	0x20001d18
c0d016b8:	20001d1a 	.word	0x20001d1a
c0d016bc:	20001d1c 	.word	0x20001d1c
c0d016c0:	20001d1e 	.word	0x20001d1e
c0d016c4:	20001d10 	.word	0x20001d10
c0d016c8:	20001d20 	.word	0x20001d20
c0d016cc:	20001d24 	.word	0x20001d24
c0d016d0:	20001d28 	.word	0x20001d28

c0d016d4 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d016d4:	4801      	ldr	r0, [pc, #4]	; (c0d016dc <io_seproxyhal_init_ux+0x8>)
c0d016d6:	2100      	movs	r1, #0
c0d016d8:	6001      	str	r1, [r0, #0]

}
c0d016da:	4770      	bx	lr
c0d016dc:	20001d20 	.word	0x20001d20

c0d016e0 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d016e0:	b5b0      	push	{r4, r5, r7, lr}
c0d016e2:	af02      	add	r7, sp, #8
c0d016e4:	460d      	mov	r5, r1
c0d016e6:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d016e8:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d016ea:	2800      	cmp	r0, #0
c0d016ec:	d00c      	beq.n	c0d01708 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d016ee:	f000 fcab 	bl	c0d02048 <pic>
c0d016f2:	4601      	mov	r1, r0
c0d016f4:	4620      	mov	r0, r4
c0d016f6:	4788      	blx	r1
c0d016f8:	f000 fca6 	bl	c0d02048 <pic>
c0d016fc:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d016fe:	2800      	cmp	r0, #0
c0d01700:	d010      	beq.n	c0d01724 <io_seproxyhal_touch_out+0x44>
c0d01702:	2801      	cmp	r0, #1
c0d01704:	d000      	beq.n	c0d01708 <io_seproxyhal_touch_out+0x28>
c0d01706:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01708:	2d00      	cmp	r5, #0
c0d0170a:	d007      	beq.n	c0d0171c <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d0170c:	4620      	mov	r0, r4
c0d0170e:	47a8      	blx	r5
c0d01710:	2100      	movs	r1, #0
    if (!el) {
c0d01712:	2800      	cmp	r0, #0
c0d01714:	d006      	beq.n	c0d01724 <io_seproxyhal_touch_out+0x44>
c0d01716:	2801      	cmp	r0, #1
c0d01718:	d000      	beq.n	c0d0171c <io_seproxyhal_touch_out+0x3c>
c0d0171a:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d0171c:	4620      	mov	r0, r4
c0d0171e:	f7ff fa91 	bl	c0d00c44 <io_seproxyhal_display>
c0d01722:	2101      	movs	r1, #1
  return 1;
}
c0d01724:	4608      	mov	r0, r1
c0d01726:	bdb0      	pop	{r4, r5, r7, pc}

c0d01728 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01728:	b5b0      	push	{r4, r5, r7, lr}
c0d0172a:	af02      	add	r7, sp, #8
c0d0172c:	b08e      	sub	sp, #56	; 0x38
c0d0172e:	460c      	mov	r4, r1
c0d01730:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01732:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d01734:	2800      	cmp	r0, #0
c0d01736:	d00c      	beq.n	c0d01752 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01738:	f000 fc86 	bl	c0d02048 <pic>
c0d0173c:	4601      	mov	r1, r0
c0d0173e:	4628      	mov	r0, r5
c0d01740:	4788      	blx	r1
c0d01742:	f000 fc81 	bl	c0d02048 <pic>
c0d01746:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01748:	2800      	cmp	r0, #0
c0d0174a:	d016      	beq.n	c0d0177a <io_seproxyhal_touch_over+0x52>
c0d0174c:	2801      	cmp	r0, #1
c0d0174e:	d000      	beq.n	c0d01752 <io_seproxyhal_touch_over+0x2a>
c0d01750:	4605      	mov	r5, r0
c0d01752:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01754:	2238      	movs	r2, #56	; 0x38
c0d01756:	4629      	mov	r1, r5
c0d01758:	f7ff fdf6 	bl	c0d01348 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d0175c:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d0175e:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01760:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01762:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01764:	2c00      	cmp	r4, #0
c0d01766:	d004      	beq.n	c0d01772 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d01768:	4628      	mov	r0, r5
c0d0176a:	47a0      	blx	r4
c0d0176c:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d0176e:	2800      	cmp	r0, #0
c0d01770:	d003      	beq.n	c0d0177a <io_seproxyhal_touch_over+0x52>
c0d01772:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01774:	f7ff fa66 	bl	c0d00c44 <io_seproxyhal_display>
c0d01778:	2101      	movs	r1, #1
  return 1;
}
c0d0177a:	4608      	mov	r0, r1
c0d0177c:	b00e      	add	sp, #56	; 0x38
c0d0177e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01780 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01780:	b5b0      	push	{r4, r5, r7, lr}
c0d01782:	af02      	add	r7, sp, #8
c0d01784:	460d      	mov	r5, r1
c0d01786:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01788:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0178a:	2800      	cmp	r0, #0
c0d0178c:	d00c      	beq.n	c0d017a8 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d0178e:	f000 fc5b 	bl	c0d02048 <pic>
c0d01792:	4601      	mov	r1, r0
c0d01794:	4620      	mov	r0, r4
c0d01796:	4788      	blx	r1
c0d01798:	f000 fc56 	bl	c0d02048 <pic>
c0d0179c:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d0179e:	2800      	cmp	r0, #0
c0d017a0:	d010      	beq.n	c0d017c4 <io_seproxyhal_touch_tap+0x44>
c0d017a2:	2801      	cmp	r0, #1
c0d017a4:	d000      	beq.n	c0d017a8 <io_seproxyhal_touch_tap+0x28>
c0d017a6:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d017a8:	2d00      	cmp	r5, #0
c0d017aa:	d007      	beq.n	c0d017bc <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d017ac:	4620      	mov	r0, r4
c0d017ae:	47a8      	blx	r5
c0d017b0:	2100      	movs	r1, #0
    if (!el) {
c0d017b2:	2800      	cmp	r0, #0
c0d017b4:	d006      	beq.n	c0d017c4 <io_seproxyhal_touch_tap+0x44>
c0d017b6:	2801      	cmp	r0, #1
c0d017b8:	d000      	beq.n	c0d017bc <io_seproxyhal_touch_tap+0x3c>
c0d017ba:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d017bc:	4620      	mov	r0, r4
c0d017be:	f7ff fa41 	bl	c0d00c44 <io_seproxyhal_display>
c0d017c2:	2101      	movs	r1, #1
  return 1;
}
c0d017c4:	4608      	mov	r0, r1
c0d017c6:	bdb0      	pop	{r4, r5, r7, pc}

c0d017c8 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d017c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017ca:	af03      	add	r7, sp, #12
c0d017cc:	b087      	sub	sp, #28
c0d017ce:	9302      	str	r3, [sp, #8]
c0d017d0:	9203      	str	r2, [sp, #12]
c0d017d2:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d017d4:	2900      	cmp	r1, #0
c0d017d6:	d076      	beq.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d017d8:	9004      	str	r0, [sp, #16]
c0d017da:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d017dc:	9001      	str	r0, [sp, #4]
c0d017de:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d017e0:	9000      	str	r0, [sp, #0]
c0d017e2:	2600      	movs	r6, #0
c0d017e4:	9606      	str	r6, [sp, #24]
c0d017e6:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d017e8:	f000 fe08 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d017ec:	2800      	cmp	r0, #0
c0d017ee:	d155      	bne.n	c0d0189c <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d017f0:	2038      	movs	r0, #56	; 0x38
c0d017f2:	4370      	muls	r0, r6
c0d017f4:	9d04      	ldr	r5, [sp, #16]
c0d017f6:	182e      	adds	r6, r5, r0
c0d017f8:	4b36      	ldr	r3, [pc, #216]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d017fa:	681a      	ldr	r2, [r3, #0]
c0d017fc:	2101      	movs	r1, #1
c0d017fe:	4296      	cmp	r6, r2
c0d01800:	d000      	beq.n	c0d01804 <io_seproxyhal_touch_element_callback+0x3c>
c0d01802:	9906      	ldr	r1, [sp, #24]
c0d01804:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01806:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01808:	2800      	cmp	r0, #0
c0d0180a:	da41      	bge.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
c0d0180c:	2020      	movs	r0, #32
c0d0180e:	5c35      	ldrb	r5, [r6, r0]
c0d01810:	2102      	movs	r1, #2
c0d01812:	5e71      	ldrsh	r1, [r6, r1]
c0d01814:	1b4a      	subs	r2, r1, r5
c0d01816:	9803      	ldr	r0, [sp, #12]
c0d01818:	4282      	cmp	r2, r0
c0d0181a:	dc39      	bgt.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
c0d0181c:	1869      	adds	r1, r5, r1
c0d0181e:	88f2      	ldrh	r2, [r6, #6]
c0d01820:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d01822:	9803      	ldr	r0, [sp, #12]
c0d01824:	4288      	cmp	r0, r1
c0d01826:	da33      	bge.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
c0d01828:	2104      	movs	r1, #4
c0d0182a:	5e70      	ldrsh	r0, [r6, r1]
c0d0182c:	1b42      	subs	r2, r0, r5
c0d0182e:	9902      	ldr	r1, [sp, #8]
c0d01830:	428a      	cmp	r2, r1
c0d01832:	dc2d      	bgt.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
c0d01834:	1940      	adds	r0, r0, r5
c0d01836:	8931      	ldrh	r1, [r6, #8]
c0d01838:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d0183a:	9902      	ldr	r1, [sp, #8]
c0d0183c:	4281      	cmp	r1, r0
c0d0183e:	da27      	bge.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01840:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01842:	4286      	cmp	r6, r0
c0d01844:	d010      	beq.n	c0d01868 <io_seproxyhal_touch_element_callback+0xa0>
c0d01846:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01848:	2800      	cmp	r0, #0
c0d0184a:	d00d      	beq.n	c0d01868 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d0184c:	9801      	ldr	r0, [sp, #4]
c0d0184e:	2800      	cmp	r0, #0
c0d01850:	d005      	beq.n	c0d0185e <io_seproxyhal_touch_element_callback+0x96>
c0d01852:	4630      	mov	r0, r6
c0d01854:	9901      	ldr	r1, [sp, #4]
c0d01856:	4788      	blx	r1
c0d01858:	4b1e      	ldr	r3, [pc, #120]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0185a:	2800      	cmp	r0, #0
c0d0185c:	d018      	beq.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d0185e:	6818      	ldr	r0, [r3, #0]
c0d01860:	9901      	ldr	r1, [sp, #4]
c0d01862:	f7ff ff3d 	bl	c0d016e0 <io_seproxyhal_touch_out>
c0d01866:	e008      	b.n	c0d0187a <io_seproxyhal_touch_element_callback+0xb2>
c0d01868:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0186a:	2801      	cmp	r0, #1
c0d0186c:	d009      	beq.n	c0d01882 <io_seproxyhal_touch_element_callback+0xba>
c0d0186e:	2802      	cmp	r0, #2
c0d01870:	d10e      	bne.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01872:	4630      	mov	r0, r6
c0d01874:	9901      	ldr	r1, [sp, #4]
c0d01876:	f7ff ff83 	bl	c0d01780 <io_seproxyhal_touch_tap>
c0d0187a:	4b16      	ldr	r3, [pc, #88]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0187c:	2800      	cmp	r0, #0
c0d0187e:	d007      	beq.n	c0d01890 <io_seproxyhal_touch_element_callback+0xc8>
c0d01880:	e023      	b.n	c0d018ca <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01882:	4630      	mov	r0, r6
c0d01884:	9901      	ldr	r1, [sp, #4]
c0d01886:	f7ff ff4f 	bl	c0d01728 <io_seproxyhal_touch_over>
c0d0188a:	4b12      	ldr	r3, [pc, #72]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0188c:	2800      	cmp	r0, #0
c0d0188e:	d11f      	bne.n	c0d018d0 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01890:	1c64      	adds	r4, r4, #1
c0d01892:	b2e6      	uxtb	r6, r4
c0d01894:	9805      	ldr	r0, [sp, #20]
c0d01896:	4286      	cmp	r6, r0
c0d01898:	d3a6      	bcc.n	c0d017e8 <io_seproxyhal_touch_element_callback+0x20>
c0d0189a:	e000      	b.n	c0d0189e <io_seproxyhal_touch_element_callback+0xd6>
c0d0189c:	4b0d      	ldr	r3, [pc, #52]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d0189e:	9806      	ldr	r0, [sp, #24]
c0d018a0:	0600      	lsls	r0, r0, #24
c0d018a2:	d010      	beq.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d018a4:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d018a6:	2800      	cmp	r0, #0
c0d018a8:	d00d      	beq.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d018aa:	f000 fda7 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d018ae:	4909      	ldr	r1, [pc, #36]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018b0:	2800      	cmp	r0, #0
c0d018b2:	d108      	bne.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d018b4:	6808      	ldr	r0, [r1, #0]
c0d018b6:	9901      	ldr	r1, [sp, #4]
c0d018b8:	f7ff ff12 	bl	c0d016e0 <io_seproxyhal_touch_out>
c0d018bc:	4d05      	ldr	r5, [pc, #20]	; (c0d018d4 <io_seproxyhal_touch_element_callback+0x10c>)
c0d018be:	2800      	cmp	r0, #0
c0d018c0:	d001      	beq.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d018c2:	2000      	movs	r0, #0
c0d018c4:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d018c6:	b007      	add	sp, #28
c0d018c8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d018ca:	2000      	movs	r0, #0
c0d018cc:	6018      	str	r0, [r3, #0]
c0d018ce:	e7fa      	b.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d018d0:	601e      	str	r6, [r3, #0]
c0d018d2:	e7f8      	b.n	c0d018c6 <io_seproxyhal_touch_element_callback+0xfe>
c0d018d4:	20001d20 	.word	0x20001d20

c0d018d8 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d018d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018da:	af03      	add	r7, sp, #12
c0d018dc:	b08b      	sub	sp, #44	; 0x2c
c0d018de:	460c      	mov	r4, r1
c0d018e0:	4601      	mov	r1, r0
c0d018e2:	ad04      	add	r5, sp, #16
c0d018e4:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d018e6:	4628      	mov	r0, r5
c0d018e8:	9203      	str	r2, [sp, #12]
c0d018ea:	f7ff fd2d 	bl	c0d01348 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d018ee:	6821      	ldr	r1, [r4, #0]
c0d018f0:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d018f2:	6862      	ldr	r2, [r4, #4]
c0d018f4:	9502      	str	r5, [sp, #8]
c0d018f6:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d018f8:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d018fa:	4e1a      	ldr	r6, [pc, #104]	; (c0d01964 <io_seproxyhal_display_icon+0x8c>)
c0d018fc:	2365      	movs	r3, #101	; 0x65
c0d018fe:	4635      	mov	r5, r6
c0d01900:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01902:	b292      	uxth	r2, r2
c0d01904:	4342      	muls	r2, r0
c0d01906:	b28b      	uxth	r3, r1
c0d01908:	4353      	muls	r3, r2
c0d0190a:	08d9      	lsrs	r1, r3, #3
c0d0190c:	1c4e      	adds	r6, r1, #1
c0d0190e:	2207      	movs	r2, #7
c0d01910:	4213      	tst	r3, r2
c0d01912:	d100      	bne.n	c0d01916 <io_seproxyhal_display_icon+0x3e>
c0d01914:	460e      	mov	r6, r1
c0d01916:	4631      	mov	r1, r6
c0d01918:	9101      	str	r1, [sp, #4]
c0d0191a:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d0191c:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d0191e:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01920:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01922:	0a01      	lsrs	r1, r0, #8
c0d01924:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01926:	70a8      	strb	r0, [r5, #2]
c0d01928:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0192a:	4628      	mov	r0, r5
c0d0192c:	f000 fd48 	bl	c0d023c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01930:	9802      	ldr	r0, [sp, #8]
c0d01932:	9903      	ldr	r1, [sp, #12]
c0d01934:	f000 fd44 	bl	c0d023c0 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01938:	68a0      	ldr	r0, [r4, #8]
c0d0193a:	7028      	strb	r0, [r5, #0]
c0d0193c:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d0193e:	4628      	mov	r0, r5
c0d01940:	f000 fd3e 	bl	c0d023c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01944:	68e0      	ldr	r0, [r4, #12]
c0d01946:	f000 fb7f 	bl	c0d02048 <pic>
c0d0194a:	b2b1      	uxth	r1, r6
c0d0194c:	f000 fd38 	bl	c0d023c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01950:	9801      	ldr	r0, [sp, #4]
c0d01952:	b285      	uxth	r5, r0
c0d01954:	6920      	ldr	r0, [r4, #16]
c0d01956:	f000 fb77 	bl	c0d02048 <pic>
c0d0195a:	4629      	mov	r1, r5
c0d0195c:	f000 fd30 	bl	c0d023c0 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01960:	b00b      	add	sp, #44	; 0x2c
c0d01962:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01964:	20001a18 	.word	0x20001a18

c0d01968 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d01968:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0196a:	af03      	add	r7, sp, #12
c0d0196c:	b081      	sub	sp, #4
c0d0196e:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01970:	7820      	ldrb	r0, [r4, #0]
c0d01972:	267f      	movs	r6, #127	; 0x7f
c0d01974:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d01976:	2e00      	cmp	r6, #0
c0d01978:	d02e      	beq.n	c0d019d8 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0197a:	69e0      	ldr	r0, [r4, #28]
c0d0197c:	2800      	cmp	r0, #0
c0d0197e:	d01d      	beq.n	c0d019bc <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01980:	f000 fb62 	bl	c0d02048 <pic>
c0d01984:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d01986:	2e05      	cmp	r6, #5
c0d01988:	d102      	bne.n	c0d01990 <io_seproxyhal_display_default+0x28>
c0d0198a:	7ea0      	ldrb	r0, [r4, #26]
c0d0198c:	2800      	cmp	r0, #0
c0d0198e:	d025      	beq.n	c0d019dc <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01990:	4628      	mov	r0, r5
c0d01992:	f002 f8cf 	bl	c0d03b34 <strlen>
c0d01996:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01998:	4813      	ldr	r0, [pc, #76]	; (c0d019e8 <io_seproxyhal_display_default+0x80>)
c0d0199a:	2165      	movs	r1, #101	; 0x65
c0d0199c:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d0199e:	4631      	mov	r1, r6
c0d019a0:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019a2:	0a0a      	lsrs	r2, r1, #8
c0d019a4:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d019a6:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019a8:	2103      	movs	r1, #3
c0d019aa:	f000 fd09 	bl	c0d023c0 <io_seproxyhal_spi_send>
c0d019ae:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d019b0:	4620      	mov	r0, r4
c0d019b2:	f000 fd05 	bl	c0d023c0 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d019b6:	b2b1      	uxth	r1, r6
c0d019b8:	4628      	mov	r0, r5
c0d019ba:	e00b      	b.n	c0d019d4 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d019bc:	480a      	ldr	r0, [pc, #40]	; (c0d019e8 <io_seproxyhal_display_default+0x80>)
c0d019be:	2165      	movs	r1, #101	; 0x65
c0d019c0:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d019c2:	2100      	movs	r1, #0
c0d019c4:	7041      	strb	r1, [r0, #1]
c0d019c6:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d019c8:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d019ca:	2103      	movs	r1, #3
c0d019cc:	f000 fcf8 	bl	c0d023c0 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d019d0:	4620      	mov	r0, r4
c0d019d2:	4629      	mov	r1, r5
c0d019d4:	f000 fcf4 	bl	c0d023c0 <io_seproxyhal_spi_send>
    }
  }
}
c0d019d8:	b001      	add	sp, #4
c0d019da:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d019dc:	4620      	mov	r0, r4
c0d019de:	4629      	mov	r1, r5
c0d019e0:	f7ff ff7a 	bl	c0d018d8 <io_seproxyhal_display_icon>
c0d019e4:	e7f8      	b.n	c0d019d8 <io_seproxyhal_display_default+0x70>
c0d019e6:	46c0      	nop			; (mov r8, r8)
c0d019e8:	20001a18 	.word	0x20001a18

c0d019ec <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d019ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d019ee:	af03      	add	r7, sp, #12
c0d019f0:	b081      	sub	sp, #4
c0d019f2:	4604      	mov	r4, r0
  if (button_callback) {
c0d019f4:	2c00      	cmp	r4, #0
c0d019f6:	d02e      	beq.n	c0d01a56 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d019f8:	4818      	ldr	r0, [pc, #96]	; (c0d01a5c <io_seproxyhal_button_push+0x70>)
c0d019fa:	6802      	ldr	r2, [r0, #0]
c0d019fc:	428a      	cmp	r2, r1
c0d019fe:	d103      	bne.n	c0d01a08 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01a00:	4a17      	ldr	r2, [pc, #92]	; (c0d01a60 <io_seproxyhal_button_push+0x74>)
c0d01a02:	6813      	ldr	r3, [r2, #0]
c0d01a04:	1c5b      	adds	r3, r3, #1
c0d01a06:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01a08:	6806      	ldr	r6, [r0, #0]
c0d01a0a:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d01a0c:	4a14      	ldr	r2, [pc, #80]	; (c0d01a60 <io_seproxyhal_button_push+0x74>)
c0d01a0e:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01a10:	2900      	cmp	r1, #0
c0d01a12:	d001      	beq.n	c0d01a18 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01a14:	6006      	str	r6, [r0, #0]
c0d01a16:	e005      	b.n	c0d01a24 <io_seproxyhal_button_push+0x38>
c0d01a18:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d01a1a:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d01a1c:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01a1e:	2301      	movs	r3, #1
c0d01a20:	07db      	lsls	r3, r3, #31
c0d01a22:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01a24:	6800      	ldr	r0, [r0, #0]
c0d01a26:	4288      	cmp	r0, r1
c0d01a28:	d001      	beq.n	c0d01a2e <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d01a2a:	2000      	movs	r0, #0
c0d01a2c:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01a2e:	2d08      	cmp	r5, #8
c0d01a30:	d30e      	bcc.n	c0d01a50 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01a32:	2103      	movs	r1, #3
c0d01a34:	4628      	mov	r0, r5
c0d01a36:	f001 fda7 	bl	c0d03588 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d01a3a:	2001      	movs	r0, #1
c0d01a3c:	0780      	lsls	r0, r0, #30
c0d01a3e:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01a40:	2900      	cmp	r1, #0
c0d01a42:	4601      	mov	r1, r0
c0d01a44:	d000      	beq.n	c0d01a48 <io_seproxyhal_button_push+0x5c>
c0d01a46:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01a48:	2900      	cmp	r1, #0
c0d01a4a:	db02      	blt.n	c0d01a52 <io_seproxyhal_button_push+0x66>
c0d01a4c:	4608      	mov	r0, r1
c0d01a4e:	e000      	b.n	c0d01a52 <io_seproxyhal_button_push+0x66>
c0d01a50:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01a52:	4629      	mov	r1, r5
c0d01a54:	47a0      	blx	r4
  }
}
c0d01a56:	b001      	add	sp, #4
c0d01a58:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a5a:	46c0      	nop			; (mov r8, r8)
c0d01a5c:	20001d24 	.word	0x20001d24
c0d01a60:	20001d28 	.word	0x20001d28

c0d01a64 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01a64:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a66:	af03      	add	r7, sp, #12
c0d01a68:	b081      	sub	sp, #4
c0d01a6a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01a6c:	200f      	movs	r0, #15
c0d01a6e:	4204      	tst	r4, r0
c0d01a70:	d006      	beq.n	c0d01a80 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01a72:	4620      	mov	r0, r4
c0d01a74:	f7ff f8be 	bl	c0d00bf4 <io_exchange_al>
c0d01a78:	4605      	mov	r5, r0
  }
}
c0d01a7a:	b2a8      	uxth	r0, r5
c0d01a7c:	b001      	add	sp, #4
c0d01a7e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01a80:	2610      	movs	r6, #16
c0d01a82:	4026      	ands	r6, r4
c0d01a84:	2900      	cmp	r1, #0
c0d01a86:	d02a      	beq.n	c0d01ade <io_exchange+0x7a>
c0d01a88:	2e00      	cmp	r6, #0
c0d01a8a:	d128      	bne.n	c0d01ade <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01a8c:	483d      	ldr	r0, [pc, #244]	; (c0d01b84 <io_exchange+0x120>)
c0d01a8e:	7800      	ldrb	r0, [r0, #0]
c0d01a90:	2807      	cmp	r0, #7
c0d01a92:	d00b      	beq.n	c0d01aac <io_exchange+0x48>
c0d01a94:	2800      	cmp	r0, #0
c0d01a96:	d004      	beq.n	c0d01aa2 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01a98:	4620      	mov	r0, r4
c0d01a9a:	f7ff f8ab 	bl	c0d00bf4 <io_exchange_al>
c0d01a9e:	2800      	cmp	r0, #0
c0d01aa0:	d00a      	beq.n	c0d01ab8 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01aa2:	4839      	ldr	r0, [pc, #228]	; (c0d01b88 <io_exchange+0x124>)
c0d01aa4:	6800      	ldr	r0, [r0, #0]
c0d01aa6:	2109      	movs	r1, #9
c0d01aa8:	f002 f836 	bl	c0d03b18 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01aac:	483d      	ldr	r0, [pc, #244]	; (c0d01ba4 <io_exchange+0x140>)
c0d01aae:	4478      	add	r0, pc
c0d01ab0:	2200      	movs	r2, #0
c0d01ab2:	2320      	movs	r3, #32
c0d01ab4:	f7ff fc6a 	bl	c0d0138c <io_usb_hid_exchange>
c0d01ab8:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d01aba:	4832      	ldr	r0, [pc, #200]	; (c0d01b84 <io_exchange+0x120>)
c0d01abc:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01abe:	4833      	ldr	r0, [pc, #204]	; (c0d01b8c <io_exchange+0x128>)
c0d01ac0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01ac2:	4833      	ldr	r0, [pc, #204]	; (c0d01b90 <io_exchange+0x12c>)
c0d01ac4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01ac6:	4833      	ldr	r0, [pc, #204]	; (c0d01b94 <io_exchange+0x130>)
c0d01ac8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01aca:	4833      	ldr	r0, [pc, #204]	; (c0d01b98 <io_exchange+0x134>)
c0d01acc:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01ace:	06a0      	lsls	r0, r4, #26
c0d01ad0:	d4d3      	bmi.n	c0d01a7a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01ad2:	f7ff fcd3 	bl	c0d0147c <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01ad6:	0620      	lsls	r0, r4, #24
c0d01ad8:	d501      	bpl.n	c0d01ade <io_exchange+0x7a>
        reset();
c0d01ada:	f000 faeb 	bl	c0d020b4 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01ade:	2e00      	cmp	r6, #0
c0d01ae0:	d10c      	bne.n	c0d01afc <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01ae2:	0660      	lsls	r0, r4, #25
c0d01ae4:	d448      	bmi.n	c0d01b78 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d01ae6:	4827      	ldr	r0, [pc, #156]	; (c0d01b84 <io_exchange+0x120>)
c0d01ae8:	2100      	movs	r1, #0
c0d01aea:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d01aec:	4827      	ldr	r0, [pc, #156]	; (c0d01b8c <io_exchange+0x128>)
c0d01aee:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01af0:	4827      	ldr	r0, [pc, #156]	; (c0d01b90 <io_exchange+0x12c>)
c0d01af2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01af4:	4827      	ldr	r0, [pc, #156]	; (c0d01b94 <io_exchange+0x130>)
c0d01af6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01af8:	4827      	ldr	r0, [pc, #156]	; (c0d01b98 <io_exchange+0x134>)
c0d01afa:	7001      	strb	r1, [r0, #0]
c0d01afc:	4c28      	ldr	r4, [pc, #160]	; (c0d01ba0 <io_exchange+0x13c>)
c0d01afe:	4e24      	ldr	r6, [pc, #144]	; (c0d01b90 <io_exchange+0x12c>)
c0d01b00:	e008      	b.n	c0d01b14 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01b02:	f7ff fd0f 	bl	c0d01524 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01b06:	8830      	ldrh	r0, [r6, #0]
c0d01b08:	2800      	cmp	r0, #0
c0d01b0a:	d003      	beq.n	c0d01b14 <io_exchange+0xb0>
c0d01b0c:	e032      	b.n	c0d01b74 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d01b0e:	2002      	movs	r0, #2
c0d01b10:	f7ff f89e 	bl	c0d00c50 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01b14:	f000 fc72 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d01b18:	2800      	cmp	r0, #0
c0d01b1a:	d101      	bne.n	c0d01b20 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d01b1c:	f7ff fcae 	bl	c0d0147c <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01b20:	2180      	movs	r1, #128	; 0x80
c0d01b22:	2500      	movs	r5, #0
c0d01b24:	4620      	mov	r0, r4
c0d01b26:	462a      	mov	r2, r5
c0d01b28:	f000 fc84 	bl	c0d02434 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d01b2c:	1ec1      	subs	r1, r0, #3
c0d01b2e:	78a2      	ldrb	r2, [r4, #2]
c0d01b30:	7863      	ldrb	r3, [r4, #1]
c0d01b32:	021b      	lsls	r3, r3, #8
c0d01b34:	4313      	orrs	r3, r2
c0d01b36:	4299      	cmp	r1, r3
c0d01b38:	d110      	bne.n	c0d01b5c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01b3a:	4917      	ldr	r1, [pc, #92]	; (c0d01b98 <io_exchange+0x134>)
c0d01b3c:	7809      	ldrb	r1, [r1, #0]
c0d01b3e:	2900      	cmp	r1, #0
c0d01b40:	d002      	beq.n	c0d01b48 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01b42:	f7ff fd73 	bl	c0d0162c <io_seproxyhal_handle_event>
c0d01b46:	e7e5      	b.n	c0d01b14 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01b48:	7821      	ldrb	r1, [r4, #0]
c0d01b4a:	2910      	cmp	r1, #16
c0d01b4c:	d00f      	beq.n	c0d01b6e <io_exchange+0x10a>
c0d01b4e:	290f      	cmp	r1, #15
c0d01b50:	d1dd      	bne.n	c0d01b0e <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01b52:	2804      	cmp	r0, #4
c0d01b54:	d102      	bne.n	c0d01b5c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01b56:	f7ff fca7 	bl	c0d014a8 <io_seproxyhal_handle_usb_event>
c0d01b5a:	e7db      	b.n	c0d01b14 <io_exchange+0xb0>
c0d01b5c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01b5e:	4909      	ldr	r1, [pc, #36]	; (c0d01b84 <io_exchange+0x120>)
c0d01b60:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01b62:	490a      	ldr	r1, [pc, #40]	; (c0d01b8c <io_exchange+0x128>)
c0d01b64:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01b66:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01b68:	490a      	ldr	r1, [pc, #40]	; (c0d01b94 <io_exchange+0x130>)
c0d01b6a:	8008      	strh	r0, [r1, #0]
c0d01b6c:	e7d2      	b.n	c0d01b14 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01b6e:	2806      	cmp	r0, #6
c0d01b70:	d2c7      	bcs.n	c0d01b02 <io_exchange+0x9e>
c0d01b72:	e782      	b.n	c0d01a7a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01b74:	8835      	ldrh	r5, [r6, #0]
c0d01b76:	e780      	b.n	c0d01a7a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01b78:	4805      	ldr	r0, [pc, #20]	; (c0d01b90 <io_exchange+0x12c>)
c0d01b7a:	8800      	ldrh	r0, [r0, #0]
c0d01b7c:	4907      	ldr	r1, [pc, #28]	; (c0d01b9c <io_exchange+0x138>)
c0d01b7e:	1845      	adds	r5, r0, r1
c0d01b80:	e77b      	b.n	c0d01a7a <io_exchange+0x16>
c0d01b82:	46c0      	nop			; (mov r8, r8)
c0d01b84:	20001d18 	.word	0x20001d18
c0d01b88:	20001bb8 	.word	0x20001bb8
c0d01b8c:	20001d1a 	.word	0x20001d1a
c0d01b90:	20001d1c 	.word	0x20001d1c
c0d01b94:	20001d1e 	.word	0x20001d1e
c0d01b98:	20001d10 	.word	0x20001d10
c0d01b9c:	0000fffb 	.word	0x0000fffb
c0d01ba0:	20001a18 	.word	0x20001a18
c0d01ba4:	fffffbbb 	.word	0xfffffbbb

c0d01ba8 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01ba8:	b081      	sub	sp, #4
c0d01baa:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01bac:	af03      	add	r7, sp, #12
c0d01bae:	b094      	sub	sp, #80	; 0x50
c0d01bb0:	4616      	mov	r6, r2
c0d01bb2:	460d      	mov	r5, r1
c0d01bb4:	900e      	str	r0, [sp, #56]	; 0x38
c0d01bb6:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01bb8:	2d02      	cmp	r5, #2
c0d01bba:	d200      	bcs.n	c0d01bbe <snprintf+0x16>
c0d01bbc:	e22a      	b.n	c0d02014 <snprintf+0x46c>
c0d01bbe:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01bc0:	2800      	cmp	r0, #0
c0d01bc2:	d100      	bne.n	c0d01bc6 <snprintf+0x1e>
c0d01bc4:	e226      	b.n	c0d02014 <snprintf+0x46c>
c0d01bc6:	2e00      	cmp	r6, #0
c0d01bc8:	d100      	bne.n	c0d01bcc <snprintf+0x24>
c0d01bca:	e223      	b.n	c0d02014 <snprintf+0x46c>
c0d01bcc:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01bce:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01bd0:	9109      	str	r1, [sp, #36]	; 0x24
c0d01bd2:	462a      	mov	r2, r5
c0d01bd4:	f7ff fbae 	bl	c0d01334 <os_memset>
c0d01bd8:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01bda:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01bdc:	7830      	ldrb	r0, [r6, #0]
c0d01bde:	2800      	cmp	r0, #0
c0d01be0:	d100      	bne.n	c0d01be4 <snprintf+0x3c>
c0d01be2:	e217      	b.n	c0d02014 <snprintf+0x46c>
c0d01be4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01be6:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01be8:	1e6b      	subs	r3, r5, #1
c0d01bea:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01bec:	460a      	mov	r2, r1
c0d01bee:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01bf0:	e003      	b.n	c0d01bfa <snprintf+0x52>
c0d01bf2:	1970      	adds	r0, r6, r5
c0d01bf4:	7840      	ldrb	r0, [r0, #1]
c0d01bf6:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01bf8:	1c6d      	adds	r5, r5, #1
c0d01bfa:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01bfc:	2800      	cmp	r0, #0
c0d01bfe:	d001      	beq.n	c0d01c04 <snprintf+0x5c>
c0d01c00:	2825      	cmp	r0, #37	; 0x25
c0d01c02:	d1f6      	bne.n	c0d01bf2 <snprintf+0x4a>
c0d01c04:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01c06:	429d      	cmp	r5, r3
c0d01c08:	d300      	bcc.n	c0d01c0c <snprintf+0x64>
c0d01c0a:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01c0c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c0e:	4631      	mov	r1, r6
c0d01c10:	462a      	mov	r2, r5
c0d01c12:	461c      	mov	r4, r3
c0d01c14:	f7ff fb98 	bl	c0d01348 <os_memmove>
c0d01c18:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01c1a:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01c1c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01c1e:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01c20:	2b00      	cmp	r3, #0
c0d01c22:	d100      	bne.n	c0d01c26 <snprintf+0x7e>
c0d01c24:	e1f6      	b.n	c0d02014 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01c26:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01c28:	5d71      	ldrb	r1, [r6, r5]
c0d01c2a:	2925      	cmp	r1, #37	; 0x25
c0d01c2c:	d000      	beq.n	c0d01c30 <snprintf+0x88>
c0d01c2e:	e0ab      	b.n	c0d01d88 <snprintf+0x1e0>
c0d01c30:	9304      	str	r3, [sp, #16]
c0d01c32:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01c34:	1c40      	adds	r0, r0, #1
c0d01c36:	2100      	movs	r1, #0
c0d01c38:	2220      	movs	r2, #32
c0d01c3a:	920a      	str	r2, [sp, #40]	; 0x28
c0d01c3c:	220a      	movs	r2, #10
c0d01c3e:	9203      	str	r2, [sp, #12]
c0d01c40:	9102      	str	r1, [sp, #8]
c0d01c42:	9106      	str	r1, [sp, #24]
c0d01c44:	910d      	str	r1, [sp, #52]	; 0x34
c0d01c46:	460b      	mov	r3, r1
c0d01c48:	2102      	movs	r1, #2
c0d01c4a:	910c      	str	r1, [sp, #48]	; 0x30
c0d01c4c:	4606      	mov	r6, r0
c0d01c4e:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01c50:	7831      	ldrb	r1, [r6, #0]
c0d01c52:	1c76      	adds	r6, r6, #1
c0d01c54:	2300      	movs	r3, #0
c0d01c56:	2962      	cmp	r1, #98	; 0x62
c0d01c58:	dc41      	bgt.n	c0d01cde <snprintf+0x136>
c0d01c5a:	4608      	mov	r0, r1
c0d01c5c:	3825      	subs	r0, #37	; 0x25
c0d01c5e:	2823      	cmp	r0, #35	; 0x23
c0d01c60:	d900      	bls.n	c0d01c64 <snprintf+0xbc>
c0d01c62:	e094      	b.n	c0d01d8e <snprintf+0x1e6>
c0d01c64:	0040      	lsls	r0, r0, #1
c0d01c66:	46c0      	nop			; (mov r8, r8)
c0d01c68:	4478      	add	r0, pc
c0d01c6a:	8880      	ldrh	r0, [r0, #4]
c0d01c6c:	0040      	lsls	r0, r0, #1
c0d01c6e:	4487      	add	pc, r0
c0d01c70:	0186012d 	.word	0x0186012d
c0d01c74:	01860186 	.word	0x01860186
c0d01c78:	00510186 	.word	0x00510186
c0d01c7c:	01860186 	.word	0x01860186
c0d01c80:	00580023 	.word	0x00580023
c0d01c84:	00240186 	.word	0x00240186
c0d01c88:	00240024 	.word	0x00240024
c0d01c8c:	00240024 	.word	0x00240024
c0d01c90:	00240024 	.word	0x00240024
c0d01c94:	00240024 	.word	0x00240024
c0d01c98:	01860024 	.word	0x01860024
c0d01c9c:	01860186 	.word	0x01860186
c0d01ca0:	01860186 	.word	0x01860186
c0d01ca4:	01860186 	.word	0x01860186
c0d01ca8:	01860186 	.word	0x01860186
c0d01cac:	01860186 	.word	0x01860186
c0d01cb0:	01860186 	.word	0x01860186
c0d01cb4:	006c0186 	.word	0x006c0186
c0d01cb8:	e7c9      	b.n	c0d01c4e <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01cba:	2930      	cmp	r1, #48	; 0x30
c0d01cbc:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01cbe:	4603      	mov	r3, r0
c0d01cc0:	d100      	bne.n	c0d01cc4 <snprintf+0x11c>
c0d01cc2:	460b      	mov	r3, r1
c0d01cc4:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01cc6:	2c00      	cmp	r4, #0
c0d01cc8:	d000      	beq.n	c0d01ccc <snprintf+0x124>
c0d01cca:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01ccc:	200a      	movs	r0, #10
c0d01cce:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01cd0:	1840      	adds	r0, r0, r1
c0d01cd2:	3830      	subs	r0, #48	; 0x30
c0d01cd4:	900d      	str	r0, [sp, #52]	; 0x34
c0d01cd6:	4630      	mov	r0, r6
c0d01cd8:	930a      	str	r3, [sp, #40]	; 0x28
c0d01cda:	4613      	mov	r3, r2
c0d01cdc:	e7b4      	b.n	c0d01c48 <snprintf+0xa0>
c0d01cde:	296f      	cmp	r1, #111	; 0x6f
c0d01ce0:	dd11      	ble.n	c0d01d06 <snprintf+0x15e>
c0d01ce2:	3970      	subs	r1, #112	; 0x70
c0d01ce4:	2908      	cmp	r1, #8
c0d01ce6:	d900      	bls.n	c0d01cea <snprintf+0x142>
c0d01ce8:	e149      	b.n	c0d01f7e <snprintf+0x3d6>
c0d01cea:	0049      	lsls	r1, r1, #1
c0d01cec:	4479      	add	r1, pc
c0d01cee:	8889      	ldrh	r1, [r1, #4]
c0d01cf0:	0049      	lsls	r1, r1, #1
c0d01cf2:	448f      	add	pc, r1
c0d01cf4:	01440051 	.word	0x01440051
c0d01cf8:	002e0144 	.word	0x002e0144
c0d01cfc:	00590144 	.word	0x00590144
c0d01d00:	01440144 	.word	0x01440144
c0d01d04:	0051      	.short	0x0051
c0d01d06:	2963      	cmp	r1, #99	; 0x63
c0d01d08:	d054      	beq.n	c0d01db4 <snprintf+0x20c>
c0d01d0a:	2964      	cmp	r1, #100	; 0x64
c0d01d0c:	d057      	beq.n	c0d01dbe <snprintf+0x216>
c0d01d0e:	2968      	cmp	r1, #104	; 0x68
c0d01d10:	d01d      	beq.n	c0d01d4e <snprintf+0x1a6>
c0d01d12:	e134      	b.n	c0d01f7e <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01d14:	7830      	ldrb	r0, [r6, #0]
c0d01d16:	2873      	cmp	r0, #115	; 0x73
c0d01d18:	d000      	beq.n	c0d01d1c <snprintf+0x174>
c0d01d1a:	e130      	b.n	c0d01f7e <snprintf+0x3d6>
c0d01d1c:	4630      	mov	r0, r6
c0d01d1e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01d20:	e00d      	b.n	c0d01d3e <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01d22:	7830      	ldrb	r0, [r6, #0]
c0d01d24:	282a      	cmp	r0, #42	; 0x2a
c0d01d26:	d000      	beq.n	c0d01d2a <snprintf+0x182>
c0d01d28:	e129      	b.n	c0d01f7e <snprintf+0x3d6>
c0d01d2a:	7871      	ldrb	r1, [r6, #1]
c0d01d2c:	1c70      	adds	r0, r6, #1
c0d01d2e:	2301      	movs	r3, #1
c0d01d30:	2948      	cmp	r1, #72	; 0x48
c0d01d32:	d004      	beq.n	c0d01d3e <snprintf+0x196>
c0d01d34:	2968      	cmp	r1, #104	; 0x68
c0d01d36:	d002      	beq.n	c0d01d3e <snprintf+0x196>
c0d01d38:	2973      	cmp	r1, #115	; 0x73
c0d01d3a:	d000      	beq.n	c0d01d3e <snprintf+0x196>
c0d01d3c:	e11f      	b.n	c0d01f7e <snprintf+0x3d6>
c0d01d3e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01d40:	1d0a      	adds	r2, r1, #4
c0d01d42:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01d44:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01d46:	9102      	str	r1, [sp, #8]
c0d01d48:	e77e      	b.n	c0d01c48 <snprintf+0xa0>
c0d01d4a:	2001      	movs	r0, #1
c0d01d4c:	9006      	str	r0, [sp, #24]
c0d01d4e:	2010      	movs	r0, #16
c0d01d50:	9003      	str	r0, [sp, #12]
c0d01d52:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01d54:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d56:	1d01      	adds	r1, r0, #4
c0d01d58:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d5a:	2103      	movs	r1, #3
c0d01d5c:	400a      	ands	r2, r1
c0d01d5e:	1c5b      	adds	r3, r3, #1
c0d01d60:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01d62:	2a01      	cmp	r2, #1
c0d01d64:	d100      	bne.n	c0d01d68 <snprintf+0x1c0>
c0d01d66:	e0b8      	b.n	c0d01eda <snprintf+0x332>
c0d01d68:	2a02      	cmp	r2, #2
c0d01d6a:	d100      	bne.n	c0d01d6e <snprintf+0x1c6>
c0d01d6c:	e104      	b.n	c0d01f78 <snprintf+0x3d0>
c0d01d6e:	2a03      	cmp	r2, #3
c0d01d70:	4630      	mov	r0, r6
c0d01d72:	d100      	bne.n	c0d01d76 <snprintf+0x1ce>
c0d01d74:	e768      	b.n	c0d01c48 <snprintf+0xa0>
c0d01d76:	9c08      	ldr	r4, [sp, #32]
c0d01d78:	4625      	mov	r5, r4
c0d01d7a:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01d7c:	1948      	adds	r0, r1, r5
c0d01d7e:	7840      	ldrb	r0, [r0, #1]
c0d01d80:	1c6d      	adds	r5, r5, #1
c0d01d82:	2800      	cmp	r0, #0
c0d01d84:	d1fa      	bne.n	c0d01d7c <snprintf+0x1d4>
c0d01d86:	e0ab      	b.n	c0d01ee0 <snprintf+0x338>
c0d01d88:	4606      	mov	r6, r0
c0d01d8a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01d8c:	e109      	b.n	c0d01fa2 <snprintf+0x3fa>
c0d01d8e:	2958      	cmp	r1, #88	; 0x58
c0d01d90:	d000      	beq.n	c0d01d94 <snprintf+0x1ec>
c0d01d92:	e0f4      	b.n	c0d01f7e <snprintf+0x3d6>
c0d01d94:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01d96:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01d98:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01d9a:	1d01      	adds	r1, r0, #4
c0d01d9c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01d9e:	6802      	ldr	r2, [r0, #0]
c0d01da0:	2000      	movs	r0, #0
c0d01da2:	9005      	str	r0, [sp, #20]
c0d01da4:	2510      	movs	r5, #16
c0d01da6:	e014      	b.n	c0d01dd2 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01da8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01daa:	1d01      	adds	r1, r0, #4
c0d01dac:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01dae:	6802      	ldr	r2, [r0, #0]
c0d01db0:	2000      	movs	r0, #0
c0d01db2:	e00c      	b.n	c0d01dce <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01db4:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01db6:	1d01      	adds	r1, r0, #4
c0d01db8:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01dba:	6800      	ldr	r0, [r0, #0]
c0d01dbc:	e087      	b.n	c0d01ece <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01dbe:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01dc0:	1d01      	adds	r1, r0, #4
c0d01dc2:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01dc4:	6800      	ldr	r0, [r0, #0]
c0d01dc6:	17c1      	asrs	r1, r0, #31
c0d01dc8:	1842      	adds	r2, r0, r1
c0d01dca:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01dcc:	0fc0      	lsrs	r0, r0, #31
c0d01dce:	9005      	str	r0, [sp, #20]
c0d01dd0:	250a      	movs	r5, #10
c0d01dd2:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01dd4:	4295      	cmp	r5, r2
c0d01dd6:	920e      	str	r2, [sp, #56]	; 0x38
c0d01dd8:	d814      	bhi.n	c0d01e04 <snprintf+0x25c>
c0d01dda:	2201      	movs	r2, #1
c0d01ddc:	4628      	mov	r0, r5
c0d01dde:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01de0:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01de2:	4629      	mov	r1, r5
c0d01de4:	f001 fb4a 	bl	c0d0347c <__aeabi_uidiv>
c0d01de8:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01dea:	4288      	cmp	r0, r1
c0d01dec:	d109      	bne.n	c0d01e02 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01dee:	4628      	mov	r0, r5
c0d01df0:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01df2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01df4:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01df6:	910d      	str	r1, [sp, #52]	; 0x34
c0d01df8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01dfa:	4288      	cmp	r0, r1
c0d01dfc:	4622      	mov	r2, r4
c0d01dfe:	d9ee      	bls.n	c0d01dde <snprintf+0x236>
c0d01e00:	e000      	b.n	c0d01e04 <snprintf+0x25c>
c0d01e02:	460c      	mov	r4, r1
c0d01e04:	950c      	str	r5, [sp, #48]	; 0x30
c0d01e06:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01e08:	2000      	movs	r0, #0
c0d01e0a:	4603      	mov	r3, r0
c0d01e0c:	43c1      	mvns	r1, r0
c0d01e0e:	9c05      	ldr	r4, [sp, #20]
c0d01e10:	2c00      	cmp	r4, #0
c0d01e12:	d100      	bne.n	c0d01e16 <snprintf+0x26e>
c0d01e14:	4621      	mov	r1, r4
c0d01e16:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e18:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01e1a:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01e1c:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01e1e:	b2ca      	uxtb	r2, r1
c0d01e20:	2a30      	cmp	r2, #48	; 0x30
c0d01e22:	d106      	bne.n	c0d01e32 <snprintf+0x28a>
c0d01e24:	2c00      	cmp	r4, #0
c0d01e26:	d004      	beq.n	c0d01e32 <snprintf+0x28a>
c0d01e28:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01e2a:	232d      	movs	r3, #45	; 0x2d
c0d01e2c:	700b      	strb	r3, [r1, #0]
c0d01e2e:	2400      	movs	r4, #0
c0d01e30:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01e32:	1e81      	subs	r1, r0, #2
c0d01e34:	290d      	cmp	r1, #13
c0d01e36:	d80d      	bhi.n	c0d01e54 <snprintf+0x2ac>
c0d01e38:	1e41      	subs	r1, r0, #1
c0d01e3a:	d00b      	beq.n	c0d01e54 <snprintf+0x2ac>
c0d01e3c:	a810      	add	r0, sp, #64	; 0x40
c0d01e3e:	9405      	str	r4, [sp, #20]
c0d01e40:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01e42:	4320      	orrs	r0, r4
c0d01e44:	f001 fdd0 	bl	c0d039e8 <__aeabi_memset>
c0d01e48:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e4a:	1900      	adds	r0, r0, r4
c0d01e4c:	9c05      	ldr	r4, [sp, #20]
c0d01e4e:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01e50:	1840      	adds	r0, r0, r1
c0d01e52:	1e43      	subs	r3, r0, #1
c0d01e54:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01e56:	2c00      	cmp	r4, #0
c0d01e58:	9601      	str	r6, [sp, #4]
c0d01e5a:	d003      	beq.n	c0d01e64 <snprintf+0x2bc>
c0d01e5c:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01e5e:	222d      	movs	r2, #45	; 0x2d
c0d01e60:	54c2      	strb	r2, [r0, r3]
c0d01e62:	1c5b      	adds	r3, r3, #1
c0d01e64:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01e66:	2900      	cmp	r1, #0
c0d01e68:	d003      	beq.n	c0d01e72 <snprintf+0x2ca>
c0d01e6a:	2800      	cmp	r0, #0
c0d01e6c:	d003      	beq.n	c0d01e76 <snprintf+0x2ce>
c0d01e6e:	a06c      	add	r0, pc, #432	; (adr r0, c0d02020 <g_pcHex_cap>)
c0d01e70:	e002      	b.n	c0d01e78 <snprintf+0x2d0>
c0d01e72:	461c      	mov	r4, r3
c0d01e74:	e016      	b.n	c0d01ea4 <snprintf+0x2fc>
c0d01e76:	a06e      	add	r0, pc, #440	; (adr r0, c0d02030 <g_pcHex>)
c0d01e78:	900d      	str	r0, [sp, #52]	; 0x34
c0d01e7a:	461c      	mov	r4, r3
c0d01e7c:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01e7e:	460e      	mov	r6, r1
c0d01e80:	f001 fafc 	bl	c0d0347c <__aeabi_uidiv>
c0d01e84:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01e86:	4629      	mov	r1, r5
c0d01e88:	f001 fb7e 	bl	c0d03588 <__aeabi_uidivmod>
c0d01e8c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e8e:	5c40      	ldrb	r0, [r0, r1]
c0d01e90:	a910      	add	r1, sp, #64	; 0x40
c0d01e92:	5508      	strb	r0, [r1, r4]
c0d01e94:	4630      	mov	r0, r6
c0d01e96:	4629      	mov	r1, r5
c0d01e98:	f001 faf0 	bl	c0d0347c <__aeabi_uidiv>
c0d01e9c:	1c64      	adds	r4, r4, #1
c0d01e9e:	42b5      	cmp	r5, r6
c0d01ea0:	4601      	mov	r1, r0
c0d01ea2:	d9eb      	bls.n	c0d01e7c <snprintf+0x2d4>
c0d01ea4:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01ea6:	429c      	cmp	r4, r3
c0d01ea8:	4625      	mov	r5, r4
c0d01eaa:	d300      	bcc.n	c0d01eae <snprintf+0x306>
c0d01eac:	461d      	mov	r5, r3
c0d01eae:	a910      	add	r1, sp, #64	; 0x40
c0d01eb0:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01eb2:	4620      	mov	r0, r4
c0d01eb4:	462a      	mov	r2, r5
c0d01eb6:	461e      	mov	r6, r3
c0d01eb8:	f7ff fa46 	bl	c0d01348 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01ebc:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01ebe:	1961      	adds	r1, r4, r5
c0d01ec0:	910e      	str	r1, [sp, #56]	; 0x38
c0d01ec2:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01ec4:	2800      	cmp	r0, #0
c0d01ec6:	9e01      	ldr	r6, [sp, #4]
c0d01ec8:	d16b      	bne.n	c0d01fa2 <snprintf+0x3fa>
c0d01eca:	e0a3      	b.n	c0d02014 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01ecc:	2025      	movs	r0, #37	; 0x25
c0d01ece:	9907      	ldr	r1, [sp, #28]
c0d01ed0:	7008      	strb	r0, [r1, #0]
c0d01ed2:	9804      	ldr	r0, [sp, #16]
c0d01ed4:	1e40      	subs	r0, r0, #1
c0d01ed6:	1c49      	adds	r1, r1, #1
c0d01ed8:	e05f      	b.n	c0d01f9a <snprintf+0x3f2>
c0d01eda:	9d02      	ldr	r5, [sp, #8]
c0d01edc:	9c08      	ldr	r4, [sp, #32]
c0d01ede:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01ee0:	9803      	ldr	r0, [sp, #12]
c0d01ee2:	2810      	cmp	r0, #16
c0d01ee4:	9807      	ldr	r0, [sp, #28]
c0d01ee6:	d161      	bne.n	c0d01fac <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01ee8:	2d00      	cmp	r5, #0
c0d01eea:	d06a      	beq.n	c0d01fc2 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01eec:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01eee:	1900      	adds	r0, r0, r4
c0d01ef0:	900e      	str	r0, [sp, #56]	; 0x38
c0d01ef2:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01ef4:	1aa0      	subs	r0, r4, r2
c0d01ef6:	9b05      	ldr	r3, [sp, #20]
c0d01ef8:	4283      	cmp	r3, r0
c0d01efa:	d800      	bhi.n	c0d01efe <snprintf+0x356>
c0d01efc:	4603      	mov	r3, r0
c0d01efe:	930c      	str	r3, [sp, #48]	; 0x30
c0d01f00:	435c      	muls	r4, r3
c0d01f02:	940a      	str	r4, [sp, #40]	; 0x28
c0d01f04:	1c60      	adds	r0, r4, #1
c0d01f06:	9007      	str	r0, [sp, #28]
c0d01f08:	2000      	movs	r0, #0
c0d01f0a:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01f0c:	9100      	str	r1, [sp, #0]
c0d01f0e:	940e      	str	r4, [sp, #56]	; 0x38
c0d01f10:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01f12:	18e3      	adds	r3, r4, r3
c0d01f14:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f16:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01f18:	200f      	movs	r0, #15
c0d01f1a:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f1c:	0909      	lsrs	r1, r1, #4
c0d01f1e:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01f20:	18a4      	adds	r4, r4, r2
c0d01f22:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01f24:	2c02      	cmp	r4, #2
c0d01f26:	d375      	bcc.n	c0d02014 <snprintf+0x46c>
c0d01f28:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01f2a:	2c01      	cmp	r4, #1
c0d01f2c:	d003      	beq.n	c0d01f36 <snprintf+0x38e>
c0d01f2e:	2c00      	cmp	r4, #0
c0d01f30:	d108      	bne.n	c0d01f44 <snprintf+0x39c>
c0d01f32:	a43f      	add	r4, pc, #252	; (adr r4, c0d02030 <g_pcHex>)
c0d01f34:	e000      	b.n	c0d01f38 <snprintf+0x390>
c0d01f36:	a43a      	add	r4, pc, #232	; (adr r4, c0d02020 <g_pcHex_cap>)
c0d01f38:	b2c9      	uxtb	r1, r1
c0d01f3a:	5c61      	ldrb	r1, [r4, r1]
c0d01f3c:	7019      	strb	r1, [r3, #0]
c0d01f3e:	b2c0      	uxtb	r0, r0
c0d01f40:	5c20      	ldrb	r0, [r4, r0]
c0d01f42:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01f44:	9807      	ldr	r0, [sp, #28]
c0d01f46:	4290      	cmp	r0, r2
c0d01f48:	d064      	beq.n	c0d02014 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01f4a:	1e92      	subs	r2, r2, #2
c0d01f4c:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01f4e:	1ca4      	adds	r4, r4, #2
c0d01f50:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01f52:	1c40      	adds	r0, r0, #1
c0d01f54:	42a8      	cmp	r0, r5
c0d01f56:	9900      	ldr	r1, [sp, #0]
c0d01f58:	d3d9      	bcc.n	c0d01f0e <snprintf+0x366>
c0d01f5a:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f5c:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01f5e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01f60:	1a08      	subs	r0, r1, r0
c0d01f62:	9b05      	ldr	r3, [sp, #20]
c0d01f64:	4283      	cmp	r3, r0
c0d01f66:	d800      	bhi.n	c0d01f6a <snprintf+0x3c2>
c0d01f68:	4603      	mov	r3, r0
c0d01f6a:	4608      	mov	r0, r1
c0d01f6c:	4358      	muls	r0, r3
c0d01f6e:	1820      	adds	r0, r4, r0
c0d01f70:	900e      	str	r0, [sp, #56]	; 0x38
c0d01f72:	1898      	adds	r0, r3, r2
c0d01f74:	1c43      	adds	r3, r0, #1
c0d01f76:	e038      	b.n	c0d01fea <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01f78:	7808      	ldrb	r0, [r1, #0]
c0d01f7a:	2800      	cmp	r0, #0
c0d01f7c:	d023      	beq.n	c0d01fc6 <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01f7e:	2005      	movs	r0, #5
c0d01f80:	9d04      	ldr	r5, [sp, #16]
c0d01f82:	2d05      	cmp	r5, #5
c0d01f84:	462c      	mov	r4, r5
c0d01f86:	d300      	bcc.n	c0d01f8a <snprintf+0x3e2>
c0d01f88:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01f8a:	9807      	ldr	r0, [sp, #28]
c0d01f8c:	a12c      	add	r1, pc, #176	; (adr r1, c0d02040 <g_pcHex+0x10>)
c0d01f8e:	4622      	mov	r2, r4
c0d01f90:	f7ff f9da 	bl	c0d01348 <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01f94:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01f96:	9907      	ldr	r1, [sp, #28]
c0d01f98:	1909      	adds	r1, r1, r4
c0d01f9a:	910e      	str	r1, [sp, #56]	; 0x38
c0d01f9c:	4603      	mov	r3, r0
c0d01f9e:	2800      	cmp	r0, #0
c0d01fa0:	d038      	beq.n	c0d02014 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01fa2:	7830      	ldrb	r0, [r6, #0]
c0d01fa4:	2800      	cmp	r0, #0
c0d01fa6:	9908      	ldr	r1, [sp, #32]
c0d01fa8:	d034      	beq.n	c0d02014 <snprintf+0x46c>
c0d01faa:	e61f      	b.n	c0d01bec <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01fac:	429d      	cmp	r5, r3
c0d01fae:	d300      	bcc.n	c0d01fb2 <snprintf+0x40a>
c0d01fb0:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01fb2:	462a      	mov	r2, r5
c0d01fb4:	461c      	mov	r4, r3
c0d01fb6:	f7ff f9c7 	bl	c0d01348 <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01fba:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01fbc:	9907      	ldr	r1, [sp, #28]
c0d01fbe:	1949      	adds	r1, r1, r5
c0d01fc0:	e00f      	b.n	c0d01fe2 <snprintf+0x43a>
c0d01fc2:	900e      	str	r0, [sp, #56]	; 0x38
c0d01fc4:	e7ed      	b.n	c0d01fa2 <snprintf+0x3fa>
c0d01fc6:	9b04      	ldr	r3, [sp, #16]
c0d01fc8:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01fca:	429c      	cmp	r4, r3
c0d01fcc:	d300      	bcc.n	c0d01fd0 <snprintf+0x428>
c0d01fce:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01fd0:	2120      	movs	r1, #32
c0d01fd2:	9807      	ldr	r0, [sp, #28]
c0d01fd4:	4622      	mov	r2, r4
c0d01fd6:	f7ff f9ad 	bl	c0d01334 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01fda:	9804      	ldr	r0, [sp, #16]
c0d01fdc:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01fde:	9907      	ldr	r1, [sp, #28]
c0d01fe0:	1909      	adds	r1, r1, r4
c0d01fe2:	910e      	str	r1, [sp, #56]	; 0x38
c0d01fe4:	4603      	mov	r3, r0
c0d01fe6:	2800      	cmp	r0, #0
c0d01fe8:	d014      	beq.n	c0d02014 <snprintf+0x46c>
c0d01fea:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01fec:	42a8      	cmp	r0, r5
c0d01fee:	d9d8      	bls.n	c0d01fa2 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01ff0:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01ff2:	429a      	cmp	r2, r3
c0d01ff4:	d300      	bcc.n	c0d01ff8 <snprintf+0x450>
c0d01ff6:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01ff8:	2120      	movs	r1, #32
c0d01ffa:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01ffc:	4628      	mov	r0, r5
c0d01ffe:	920d      	str	r2, [sp, #52]	; 0x34
c0d02000:	461c      	mov	r4, r3
c0d02002:	f7ff f997 	bl	c0d01334 <os_memset>
c0d02006:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d02008:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d0200a:	182d      	adds	r5, r5, r0
c0d0200c:	950e      	str	r5, [sp, #56]	; 0x38
c0d0200e:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d02010:	2c00      	cmp	r4, #0
c0d02012:	d1c6      	bne.n	c0d01fa2 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d02014:	2000      	movs	r0, #0
c0d02016:	b014      	add	sp, #80	; 0x50
c0d02018:	bcf0      	pop	{r4, r5, r6, r7}
c0d0201a:	bc02      	pop	{r1}
c0d0201c:	b001      	add	sp, #4
c0d0201e:	4708      	bx	r1

c0d02020 <g_pcHex_cap>:
c0d02020:	33323130 	.word	0x33323130
c0d02024:	37363534 	.word	0x37363534
c0d02028:	42413938 	.word	0x42413938
c0d0202c:	46454443 	.word	0x46454443

c0d02030 <g_pcHex>:
c0d02030:	33323130 	.word	0x33323130
c0d02034:	37363534 	.word	0x37363534
c0d02038:	62613938 	.word	0x62613938
c0d0203c:	66656463 	.word	0x66656463
c0d02040:	4f525245 	.word	0x4f525245
c0d02044:	00000052 	.word	0x00000052

c0d02048 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d02048:	b580      	push	{r7, lr}
c0d0204a:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d0204c:	4904      	ldr	r1, [pc, #16]	; (c0d02060 <pic+0x18>)
c0d0204e:	4288      	cmp	r0, r1
c0d02050:	d304      	bcc.n	c0d0205c <pic+0x14>
c0d02052:	4904      	ldr	r1, [pc, #16]	; (c0d02064 <pic+0x1c>)
c0d02054:	4288      	cmp	r0, r1
c0d02056:	d201      	bcs.n	c0d0205c <pic+0x14>
		link_address = pic_internal(link_address);
c0d02058:	f000 f806 	bl	c0d02068 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d0205c:	bd80      	pop	{r7, pc}
c0d0205e:	46c0      	nop			; (mov r8, r8)
c0d02060:	c0d00000 	.word	0xc0d00000
c0d02064:	c0d04080 	.word	0xc0d04080

c0d02068 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d02068:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0206a:	4902      	ldr	r1, [pc, #8]	; (c0d02074 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d0206c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d0206e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d02070:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d02072:	4770      	bx	lr
c0d02074:	c0d02069 	.word	0xc0d02069

c0d02078 <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d02078:	b580      	push	{r7, lr}
c0d0207a:	af00      	add	r7, sp, #0
c0d0207c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d0207e:	490a      	ldr	r1, [pc, #40]	; (c0d020a8 <check_api_level+0x30>)
c0d02080:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02082:	490a      	ldr	r1, [pc, #40]	; (c0d020ac <check_api_level+0x34>)
c0d02084:	680a      	ldr	r2, [r1, #0]
c0d02086:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d02088:	9003      	str	r0, [sp, #12]
c0d0208a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0208c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0208e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02090:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d02092:	4807      	ldr	r0, [pc, #28]	; (c0d020b0 <check_api_level+0x38>)
c0d02094:	9a01      	ldr	r2, [sp, #4]
c0d02096:	4282      	cmp	r2, r0
c0d02098:	d101      	bne.n	c0d0209e <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0209a:	b004      	add	sp, #16
c0d0209c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0209e:	6808      	ldr	r0, [r1, #0]
c0d020a0:	2104      	movs	r1, #4
c0d020a2:	f001 fd39 	bl	c0d03b18 <longjmp>
c0d020a6:	46c0      	nop			; (mov r8, r8)
c0d020a8:	60000137 	.word	0x60000137
c0d020ac:	20001bb8 	.word	0x20001bb8
c0d020b0:	900001c6 	.word	0x900001c6

c0d020b4 <reset>:
  }
}

void reset ( void ) 
{
c0d020b4:	b580      	push	{r7, lr}
c0d020b6:	af00      	add	r7, sp, #0
c0d020b8:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d020ba:	4809      	ldr	r0, [pc, #36]	; (c0d020e0 <reset+0x2c>)
c0d020bc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020be:	4809      	ldr	r0, [pc, #36]	; (c0d020e4 <reset+0x30>)
c0d020c0:	6801      	ldr	r1, [r0, #0]
c0d020c2:	9101      	str	r1, [sp, #4]
c0d020c4:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020c6:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d020c8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020ca:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d020cc:	4906      	ldr	r1, [pc, #24]	; (c0d020e8 <reset+0x34>)
c0d020ce:	9a00      	ldr	r2, [sp, #0]
c0d020d0:	428a      	cmp	r2, r1
c0d020d2:	d101      	bne.n	c0d020d8 <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d020d4:	b002      	add	sp, #8
c0d020d6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020d8:	6800      	ldr	r0, [r0, #0]
c0d020da:	2104      	movs	r1, #4
c0d020dc:	f001 fd1c 	bl	c0d03b18 <longjmp>
c0d020e0:	60000200 	.word	0x60000200
c0d020e4:	20001bb8 	.word	0x20001bb8
c0d020e8:	900002f1 	.word	0x900002f1

c0d020ec <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d020ec:	b5d0      	push	{r4, r6, r7, lr}
c0d020ee:	af02      	add	r7, sp, #8
c0d020f0:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d020f2:	4b0a      	ldr	r3, [pc, #40]	; (c0d0211c <nvm_write+0x30>)
c0d020f4:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020f6:	4b0a      	ldr	r3, [pc, #40]	; (c0d02120 <nvm_write+0x34>)
c0d020f8:	681c      	ldr	r4, [r3, #0]
c0d020fa:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d020fc:	ac03      	add	r4, sp, #12
c0d020fe:	c407      	stmia	r4!, {r0, r1, r2}
c0d02100:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02102:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02104:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02106:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d02108:	4806      	ldr	r0, [pc, #24]	; (c0d02124 <nvm_write+0x38>)
c0d0210a:	9901      	ldr	r1, [sp, #4]
c0d0210c:	4281      	cmp	r1, r0
c0d0210e:	d101      	bne.n	c0d02114 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02110:	b006      	add	sp, #24
c0d02112:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02114:	6818      	ldr	r0, [r3, #0]
c0d02116:	2104      	movs	r1, #4
c0d02118:	f001 fcfe 	bl	c0d03b18 <longjmp>
c0d0211c:	6000037f 	.word	0x6000037f
c0d02120:	20001bb8 	.word	0x20001bb8
c0d02124:	900003bc 	.word	0x900003bc

c0d02128 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d02128:	b580      	push	{r7, lr}
c0d0212a:	af00      	add	r7, sp, #0
c0d0212c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d0212e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02158 <cx_rng+0x30>)
c0d02130:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02132:	4a0a      	ldr	r2, [pc, #40]	; (c0d0215c <cx_rng+0x34>)
c0d02134:	6813      	ldr	r3, [r2, #0]
c0d02136:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02138:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d0213a:	9103      	str	r1, [sp, #12]
c0d0213c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0213e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02140:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02142:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d02144:	4906      	ldr	r1, [pc, #24]	; (c0d02160 <cx_rng+0x38>)
c0d02146:	9b00      	ldr	r3, [sp, #0]
c0d02148:	428b      	cmp	r3, r1
c0d0214a:	d101      	bne.n	c0d02150 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d0214c:	b004      	add	sp, #16
c0d0214e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02150:	6810      	ldr	r0, [r2, #0]
c0d02152:	2104      	movs	r1, #4
c0d02154:	f001 fce0 	bl	c0d03b18 <longjmp>
c0d02158:	6000052c 	.word	0x6000052c
c0d0215c:	20001bb8 	.word	0x20001bb8
c0d02160:	90000567 	.word	0x90000567

c0d02164 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d02164:	b580      	push	{r7, lr}
c0d02166:	af00      	add	r7, sp, #0
c0d02168:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d0216a:	490a      	ldr	r1, [pc, #40]	; (c0d02194 <cx_sha256_init+0x30>)
c0d0216c:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0216e:	490a      	ldr	r1, [pc, #40]	; (c0d02198 <cx_sha256_init+0x34>)
c0d02170:	680a      	ldr	r2, [r1, #0]
c0d02172:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02174:	9003      	str	r0, [sp, #12]
c0d02176:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02178:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0217a:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0217c:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d0217e:	4a07      	ldr	r2, [pc, #28]	; (c0d0219c <cx_sha256_init+0x38>)
c0d02180:	9b01      	ldr	r3, [sp, #4]
c0d02182:	4293      	cmp	r3, r2
c0d02184:	d101      	bne.n	c0d0218a <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02186:	b004      	add	sp, #16
c0d02188:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0218a:	6808      	ldr	r0, [r1, #0]
c0d0218c:	2104      	movs	r1, #4
c0d0218e:	f001 fcc3 	bl	c0d03b18 <longjmp>
c0d02192:	46c0      	nop			; (mov r8, r8)
c0d02194:	600008db 	.word	0x600008db
c0d02198:	20001bb8 	.word	0x20001bb8
c0d0219c:	90000864 	.word	0x90000864

c0d021a0 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d021a0:	b580      	push	{r7, lr}
c0d021a2:	af00      	add	r7, sp, #0
c0d021a4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d021a6:	4a0a      	ldr	r2, [pc, #40]	; (c0d021d0 <cx_keccak_init+0x30>)
c0d021a8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021aa:	4a0a      	ldr	r2, [pc, #40]	; (c0d021d4 <cx_keccak_init+0x34>)
c0d021ac:	6813      	ldr	r3, [r2, #0]
c0d021ae:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d021b0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d021b2:	9103      	str	r1, [sp, #12]
c0d021b4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021b6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021b8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021ba:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d021bc:	4906      	ldr	r1, [pc, #24]	; (c0d021d8 <cx_keccak_init+0x38>)
c0d021be:	9b00      	ldr	r3, [sp, #0]
c0d021c0:	428b      	cmp	r3, r1
c0d021c2:	d101      	bne.n	c0d021c8 <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d021c4:	b004      	add	sp, #16
c0d021c6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021c8:	6810      	ldr	r0, [r2, #0]
c0d021ca:	2104      	movs	r1, #4
c0d021cc:	f001 fca4 	bl	c0d03b18 <longjmp>
c0d021d0:	60000c3c 	.word	0x60000c3c
c0d021d4:	20001bb8 	.word	0x20001bb8
c0d021d8:	90000c39 	.word	0x90000c39

c0d021dc <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d021dc:	b5b0      	push	{r4, r5, r7, lr}
c0d021de:	af02      	add	r7, sp, #8
c0d021e0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d021e2:	4c0b      	ldr	r4, [pc, #44]	; (c0d02210 <cx_hash+0x34>)
c0d021e4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021e6:	4c0b      	ldr	r4, [pc, #44]	; (c0d02214 <cx_hash+0x38>)
c0d021e8:	6825      	ldr	r5, [r4, #0]
c0d021ea:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d021ec:	ad03      	add	r5, sp, #12
c0d021ee:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d021f0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d021f2:	9007      	str	r0, [sp, #28]
c0d021f4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021f6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021f8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021fa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d021fc:	4906      	ldr	r1, [pc, #24]	; (c0d02218 <cx_hash+0x3c>)
c0d021fe:	9a01      	ldr	r2, [sp, #4]
c0d02200:	428a      	cmp	r2, r1
c0d02202:	d101      	bne.n	c0d02208 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02204:	b008      	add	sp, #32
c0d02206:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02208:	6820      	ldr	r0, [r4, #0]
c0d0220a:	2104      	movs	r1, #4
c0d0220c:	f001 fc84 	bl	c0d03b18 <longjmp>
c0d02210:	60000ea6 	.word	0x60000ea6
c0d02214:	20001bb8 	.word	0x20001bb8
c0d02218:	90000e46 	.word	0x90000e46

c0d0221c <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d0221c:	b5b0      	push	{r4, r5, r7, lr}
c0d0221e:	af02      	add	r7, sp, #8
c0d02220:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d02222:	4c0a      	ldr	r4, [pc, #40]	; (c0d0224c <cx_ecfp_init_public_key+0x30>)
c0d02224:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02226:	4c0a      	ldr	r4, [pc, #40]	; (c0d02250 <cx_ecfp_init_public_key+0x34>)
c0d02228:	6825      	ldr	r5, [r4, #0]
c0d0222a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0222c:	ad02      	add	r5, sp, #8
c0d0222e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02230:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02232:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02234:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02236:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d02238:	4906      	ldr	r1, [pc, #24]	; (c0d02254 <cx_ecfp_init_public_key+0x38>)
c0d0223a:	9a00      	ldr	r2, [sp, #0]
c0d0223c:	428a      	cmp	r2, r1
c0d0223e:	d101      	bne.n	c0d02244 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02240:	b006      	add	sp, #24
c0d02242:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02244:	6820      	ldr	r0, [r4, #0]
c0d02246:	2104      	movs	r1, #4
c0d02248:	f001 fc66 	bl	c0d03b18 <longjmp>
c0d0224c:	60002835 	.word	0x60002835
c0d02250:	20001bb8 	.word	0x20001bb8
c0d02254:	900028f0 	.word	0x900028f0

c0d02258 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d02258:	b5b0      	push	{r4, r5, r7, lr}
c0d0225a:	af02      	add	r7, sp, #8
c0d0225c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d0225e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02288 <cx_ecfp_init_private_key+0x30>)
c0d02260:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02262:	4c0a      	ldr	r4, [pc, #40]	; (c0d0228c <cx_ecfp_init_private_key+0x34>)
c0d02264:	6825      	ldr	r5, [r4, #0]
c0d02266:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02268:	ad02      	add	r5, sp, #8
c0d0226a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0226c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0226e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02270:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02272:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d02274:	4906      	ldr	r1, [pc, #24]	; (c0d02290 <cx_ecfp_init_private_key+0x38>)
c0d02276:	9a00      	ldr	r2, [sp, #0]
c0d02278:	428a      	cmp	r2, r1
c0d0227a:	d101      	bne.n	c0d02280 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0227c:	b006      	add	sp, #24
c0d0227e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02280:	6820      	ldr	r0, [r4, #0]
c0d02282:	2104      	movs	r1, #4
c0d02284:	f001 fc48 	bl	c0d03b18 <longjmp>
c0d02288:	600029ed 	.word	0x600029ed
c0d0228c:	20001bb8 	.word	0x20001bb8
c0d02290:	900029ae 	.word	0x900029ae

c0d02294 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02294:	b5b0      	push	{r4, r5, r7, lr}
c0d02296:	af02      	add	r7, sp, #8
c0d02298:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d0229a:	4c0a      	ldr	r4, [pc, #40]	; (c0d022c4 <cx_ecfp_generate_pair+0x30>)
c0d0229c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0229e:	4c0a      	ldr	r4, [pc, #40]	; (c0d022c8 <cx_ecfp_generate_pair+0x34>)
c0d022a0:	6825      	ldr	r5, [r4, #0]
c0d022a2:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d022a4:	ad02      	add	r5, sp, #8
c0d022a6:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022a8:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022aa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022ac:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022ae:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d022b0:	4906      	ldr	r1, [pc, #24]	; (c0d022cc <cx_ecfp_generate_pair+0x38>)
c0d022b2:	9a00      	ldr	r2, [sp, #0]
c0d022b4:	428a      	cmp	r2, r1
c0d022b6:	d101      	bne.n	c0d022bc <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d022b8:	b006      	add	sp, #24
c0d022ba:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022bc:	6820      	ldr	r0, [r4, #0]
c0d022be:	2104      	movs	r1, #4
c0d022c0:	f001 fc2a 	bl	c0d03b18 <longjmp>
c0d022c4:	60002a2e 	.word	0x60002a2e
c0d022c8:	20001bb8 	.word	0x20001bb8
c0d022cc:	90002a74 	.word	0x90002a74

c0d022d0 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d022d0:	b5b0      	push	{r4, r5, r7, lr}
c0d022d2:	af02      	add	r7, sp, #8
c0d022d4:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d022d6:	4c0b      	ldr	r4, [pc, #44]	; (c0d02304 <os_perso_derive_node_bip32+0x34>)
c0d022d8:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022da:	4c0b      	ldr	r4, [pc, #44]	; (c0d02308 <os_perso_derive_node_bip32+0x38>)
c0d022dc:	6825      	ldr	r5, [r4, #0]
c0d022de:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d022e0:	ad03      	add	r5, sp, #12
c0d022e2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d022e4:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d022e6:	9007      	str	r0, [sp, #28]
c0d022e8:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022ea:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022ec:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022ee:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d022f0:	4806      	ldr	r0, [pc, #24]	; (c0d0230c <os_perso_derive_node_bip32+0x3c>)
c0d022f2:	9901      	ldr	r1, [sp, #4]
c0d022f4:	4281      	cmp	r1, r0
c0d022f6:	d101      	bne.n	c0d022fc <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d022f8:	b008      	add	sp, #32
c0d022fa:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022fc:	6820      	ldr	r0, [r4, #0]
c0d022fe:	2104      	movs	r1, #4
c0d02300:	f001 fc0a 	bl	c0d03b18 <longjmp>
c0d02304:	6000512b 	.word	0x6000512b
c0d02308:	20001bb8 	.word	0x20001bb8
c0d0230c:	9000517f 	.word	0x9000517f

c0d02310 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d02310:	b580      	push	{r7, lr}
c0d02312:	af00      	add	r7, sp, #0
c0d02314:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d02316:	490a      	ldr	r1, [pc, #40]	; (c0d02340 <os_sched_exit+0x30>)
c0d02318:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0231a:	490a      	ldr	r1, [pc, #40]	; (c0d02344 <os_sched_exit+0x34>)
c0d0231c:	680a      	ldr	r2, [r1, #0]
c0d0231e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d02320:	9003      	str	r0, [sp, #12]
c0d02322:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02324:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02326:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02328:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d0232a:	4807      	ldr	r0, [pc, #28]	; (c0d02348 <os_sched_exit+0x38>)
c0d0232c:	9a01      	ldr	r2, [sp, #4]
c0d0232e:	4282      	cmp	r2, r0
c0d02330:	d101      	bne.n	c0d02336 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02332:	b004      	add	sp, #16
c0d02334:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02336:	6808      	ldr	r0, [r1, #0]
c0d02338:	2104      	movs	r1, #4
c0d0233a:	f001 fbed 	bl	c0d03b18 <longjmp>
c0d0233e:	46c0      	nop			; (mov r8, r8)
c0d02340:	60005fe1 	.word	0x60005fe1
c0d02344:	20001bb8 	.word	0x20001bb8
c0d02348:	90005f6f 	.word	0x90005f6f

c0d0234c <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d0234c:	b580      	push	{r7, lr}
c0d0234e:	af00      	add	r7, sp, #0
c0d02350:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d02352:	490a      	ldr	r1, [pc, #40]	; (c0d0237c <os_ux+0x30>)
c0d02354:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02356:	490a      	ldr	r1, [pc, #40]	; (c0d02380 <os_ux+0x34>)
c0d02358:	680a      	ldr	r2, [r1, #0]
c0d0235a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d0235c:	9003      	str	r0, [sp, #12]
c0d0235e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02360:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02362:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02364:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d02366:	4a07      	ldr	r2, [pc, #28]	; (c0d02384 <os_ux+0x38>)
c0d02368:	9b01      	ldr	r3, [sp, #4]
c0d0236a:	4293      	cmp	r3, r2
c0d0236c:	d101      	bne.n	c0d02372 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0236e:	b004      	add	sp, #16
c0d02370:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02372:	6808      	ldr	r0, [r1, #0]
c0d02374:	2104      	movs	r1, #4
c0d02376:	f001 fbcf 	bl	c0d03b18 <longjmp>
c0d0237a:	46c0      	nop			; (mov r8, r8)
c0d0237c:	60006158 	.word	0x60006158
c0d02380:	20001bb8 	.word	0x20001bb8
c0d02384:	9000611f 	.word	0x9000611f

c0d02388 <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d02388:	b580      	push	{r7, lr}
c0d0238a:	af00      	add	r7, sp, #0
c0d0238c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d0238e:	4809      	ldr	r0, [pc, #36]	; (c0d023b4 <os_seph_features+0x2c>)
c0d02390:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02392:	4909      	ldr	r1, [pc, #36]	; (c0d023b8 <os_seph_features+0x30>)
c0d02394:	6808      	ldr	r0, [r1, #0]
c0d02396:	9001      	str	r0, [sp, #4]
c0d02398:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0239a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0239c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0239e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d023a0:	4a06      	ldr	r2, [pc, #24]	; (c0d023bc <os_seph_features+0x34>)
c0d023a2:	9b00      	ldr	r3, [sp, #0]
c0d023a4:	4293      	cmp	r3, r2
c0d023a6:	d101      	bne.n	c0d023ac <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d023a8:	b002      	add	sp, #8
c0d023aa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023ac:	6808      	ldr	r0, [r1, #0]
c0d023ae:	2104      	movs	r1, #4
c0d023b0:	f001 fbb2 	bl	c0d03b18 <longjmp>
c0d023b4:	600064d6 	.word	0x600064d6
c0d023b8:	20001bb8 	.word	0x20001bb8
c0d023bc:	90006444 	.word	0x90006444

c0d023c0 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d023c0:	b580      	push	{r7, lr}
c0d023c2:	af00      	add	r7, sp, #0
c0d023c4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d023c6:	4a0a      	ldr	r2, [pc, #40]	; (c0d023f0 <io_seproxyhal_spi_send+0x30>)
c0d023c8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d023ca:	4a0a      	ldr	r2, [pc, #40]	; (c0d023f4 <io_seproxyhal_spi_send+0x34>)
c0d023cc:	6813      	ldr	r3, [r2, #0]
c0d023ce:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d023d0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d023d2:	9103      	str	r1, [sp, #12]
c0d023d4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d023d6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d023d8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d023da:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d023dc:	4806      	ldr	r0, [pc, #24]	; (c0d023f8 <io_seproxyhal_spi_send+0x38>)
c0d023de:	9900      	ldr	r1, [sp, #0]
c0d023e0:	4281      	cmp	r1, r0
c0d023e2:	d101      	bne.n	c0d023e8 <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d023e4:	b004      	add	sp, #16
c0d023e6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d023e8:	6810      	ldr	r0, [r2, #0]
c0d023ea:	2104      	movs	r1, #4
c0d023ec:	f001 fb94 	bl	c0d03b18 <longjmp>
c0d023f0:	60006a1c 	.word	0x60006a1c
c0d023f4:	20001bb8 	.word	0x20001bb8
c0d023f8:	90006af3 	.word	0x90006af3

c0d023fc <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d023fc:	b580      	push	{r7, lr}
c0d023fe:	af00      	add	r7, sp, #0
c0d02400:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d02402:	4809      	ldr	r0, [pc, #36]	; (c0d02428 <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d02404:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02406:	4909      	ldr	r1, [pc, #36]	; (c0d0242c <io_seproxyhal_spi_is_status_sent+0x30>)
c0d02408:	6808      	ldr	r0, [r1, #0]
c0d0240a:	9001      	str	r0, [sp, #4]
c0d0240c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0240e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02410:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02412:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d02414:	4a06      	ldr	r2, [pc, #24]	; (c0d02430 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d02416:	9b00      	ldr	r3, [sp, #0]
c0d02418:	4293      	cmp	r3, r2
c0d0241a:	d101      	bne.n	c0d02420 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0241c:	b002      	add	sp, #8
c0d0241e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02420:	6808      	ldr	r0, [r1, #0]
c0d02422:	2104      	movs	r1, #4
c0d02424:	f001 fb78 	bl	c0d03b18 <longjmp>
c0d02428:	60006bcf 	.word	0x60006bcf
c0d0242c:	20001bb8 	.word	0x20001bb8
c0d02430:	90006b7f 	.word	0x90006b7f

c0d02434 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d02434:	b5d0      	push	{r4, r6, r7, lr}
c0d02436:	af02      	add	r7, sp, #8
c0d02438:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d0243a:	4b0b      	ldr	r3, [pc, #44]	; (c0d02468 <io_seproxyhal_spi_recv+0x34>)
c0d0243c:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0243e:	4b0b      	ldr	r3, [pc, #44]	; (c0d0246c <io_seproxyhal_spi_recv+0x38>)
c0d02440:	681c      	ldr	r4, [r3, #0]
c0d02442:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d02444:	ac03      	add	r4, sp, #12
c0d02446:	c407      	stmia	r4!, {r0, r1, r2}
c0d02448:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0244a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0244c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0244e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02450:	4907      	ldr	r1, [pc, #28]	; (c0d02470 <io_seproxyhal_spi_recv+0x3c>)
c0d02452:	9a01      	ldr	r2, [sp, #4]
c0d02454:	428a      	cmp	r2, r1
c0d02456:	d102      	bne.n	c0d0245e <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d02458:	b280      	uxth	r0, r0
c0d0245a:	b006      	add	sp, #24
c0d0245c:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0245e:	6818      	ldr	r0, [r3, #0]
c0d02460:	2104      	movs	r1, #4
c0d02462:	f001 fb59 	bl	c0d03b18 <longjmp>
c0d02466:	46c0      	nop			; (mov r8, r8)
c0d02468:	60006cd1 	.word	0x60006cd1
c0d0246c:	20001bb8 	.word	0x20001bb8
c0d02470:	90006c2b 	.word	0x90006c2b

c0d02474 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02474:	b5b0      	push	{r4, r5, r7, lr}
c0d02476:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d02478:	492c      	ldr	r1, [pc, #176]	; (c0d0252c <bagl_ui_nanos_screen1_button+0xb8>)
c0d0247a:	4288      	cmp	r0, r1
c0d0247c:	d006      	beq.n	c0d0248c <bagl_ui_nanos_screen1_button+0x18>
c0d0247e:	492c      	ldr	r1, [pc, #176]	; (c0d02530 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02480:	4288      	cmp	r0, r1
c0d02482:	d151      	bne.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02484:	2000      	movs	r0, #0
c0d02486:	f7ff ff43 	bl	c0d02310 <os_sched_exit>
c0d0248a:	e04d      	b.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d0248c:	f7fe fba4 	bl	c0d00bd8 <nvram_is_init>
c0d02490:	2801      	cmp	r0, #1
c0d02492:	d102      	bne.n	c0d0249a <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02494:	a029      	add	r0, pc, #164	; (adr r0, c0d0253c <bagl_ui_nanos_screen1_button+0xc8>)
c0d02496:	210d      	movs	r1, #13
c0d02498:	e001      	b.n	c0d0249e <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0249a:	a026      	add	r0, pc, #152	; (adr r0, c0d02534 <bagl_ui_nanos_screen1_button+0xc0>)
c0d0249c:	2105      	movs	r1, #5
c0d0249e:	2203      	movs	r2, #3
c0d024a0:	f7fd fe00 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d024a4:	4c29      	ldr	r4, [pc, #164]	; (c0d0254c <bagl_ui_nanos_screen1_button+0xd8>)
c0d024a6:	482b      	ldr	r0, [pc, #172]	; (c0d02554 <bagl_ui_nanos_screen1_button+0xe0>)
c0d024a8:	4478      	add	r0, pc
c0d024aa:	6020      	str	r0, [r4, #0]
c0d024ac:	2004      	movs	r0, #4
c0d024ae:	6060      	str	r0, [r4, #4]
c0d024b0:	4829      	ldr	r0, [pc, #164]	; (c0d02558 <bagl_ui_nanos_screen1_button+0xe4>)
c0d024b2:	4478      	add	r0, pc
c0d024b4:	6120      	str	r0, [r4, #16]
c0d024b6:	2500      	movs	r5, #0
c0d024b8:	60e5      	str	r5, [r4, #12]
c0d024ba:	2003      	movs	r0, #3
c0d024bc:	7620      	strb	r0, [r4, #24]
c0d024be:	61e5      	str	r5, [r4, #28]
c0d024c0:	4620      	mov	r0, r4
c0d024c2:	3018      	adds	r0, #24
c0d024c4:	f7ff ff42 	bl	c0d0234c <os_ux>
c0d024c8:	61e0      	str	r0, [r4, #28]
c0d024ca:	f7ff f903 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d024ce:	60a5      	str	r5, [r4, #8]
c0d024d0:	6820      	ldr	r0, [r4, #0]
c0d024d2:	2800      	cmp	r0, #0
c0d024d4:	d028      	beq.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
c0d024d6:	69e0      	ldr	r0, [r4, #28]
c0d024d8:	491d      	ldr	r1, [pc, #116]	; (c0d02550 <bagl_ui_nanos_screen1_button+0xdc>)
c0d024da:	4288      	cmp	r0, r1
c0d024dc:	d116      	bne.n	c0d0250c <bagl_ui_nanos_screen1_button+0x98>
c0d024de:	e023      	b.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
c0d024e0:	6860      	ldr	r0, [r4, #4]
c0d024e2:	4285      	cmp	r5, r0
c0d024e4:	d220      	bcs.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
c0d024e6:	f7ff ff89 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d024ea:	2800      	cmp	r0, #0
c0d024ec:	d11c      	bne.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
c0d024ee:	68a0      	ldr	r0, [r4, #8]
c0d024f0:	68e1      	ldr	r1, [r4, #12]
c0d024f2:	2538      	movs	r5, #56	; 0x38
c0d024f4:	4368      	muls	r0, r5
c0d024f6:	6822      	ldr	r2, [r4, #0]
c0d024f8:	1810      	adds	r0, r2, r0
c0d024fa:	2900      	cmp	r1, #0
c0d024fc:	d009      	beq.n	c0d02512 <bagl_ui_nanos_screen1_button+0x9e>
c0d024fe:	4788      	blx	r1
c0d02500:	2800      	cmp	r0, #0
c0d02502:	d106      	bne.n	c0d02512 <bagl_ui_nanos_screen1_button+0x9e>
c0d02504:	68a0      	ldr	r0, [r4, #8]
c0d02506:	1c45      	adds	r5, r0, #1
c0d02508:	60a5      	str	r5, [r4, #8]
c0d0250a:	6820      	ldr	r0, [r4, #0]
c0d0250c:	2800      	cmp	r0, #0
c0d0250e:	d1e7      	bne.n	c0d024e0 <bagl_ui_nanos_screen1_button+0x6c>
c0d02510:	e00a      	b.n	c0d02528 <bagl_ui_nanos_screen1_button+0xb4>
c0d02512:	2801      	cmp	r0, #1
c0d02514:	d103      	bne.n	c0d0251e <bagl_ui_nanos_screen1_button+0xaa>
c0d02516:	68a0      	ldr	r0, [r4, #8]
c0d02518:	4345      	muls	r5, r0
c0d0251a:	6820      	ldr	r0, [r4, #0]
c0d0251c:	1940      	adds	r0, r0, r5
c0d0251e:	f7fe fb91 	bl	c0d00c44 <io_seproxyhal_display>
c0d02522:	68a0      	ldr	r0, [r4, #8]
c0d02524:	1c40      	adds	r0, r0, #1
c0d02526:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d02528:	2000      	movs	r0, #0
c0d0252a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0252c:	80000002 	.word	0x80000002
c0d02530:	80000001 	.word	0x80000001
c0d02534:	54494e49 	.word	0x54494e49
c0d02538:	00000000 	.word	0x00000000
c0d0253c:	6c697453 	.word	0x6c697453
c0d02540:	6e75206c 	.word	0x6e75206c
c0d02544:	74696e69 	.word	0x74696e69
c0d02548:	00000000 	.word	0x00000000
c0d0254c:	20001a98 	.word	0x20001a98
c0d02550:	b0105044 	.word	0xb0105044
c0d02554:	000018a8 	.word	0x000018a8
c0d02558:	00000153 	.word	0x00000153

c0d0255c <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d0255c:	b5b0      	push	{r4, r5, r7, lr}
c0d0255e:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02560:	2800      	cmp	r0, #0
c0d02562:	d005      	beq.n	c0d02570 <ui_display_debug+0x14>
c0d02564:	2900      	cmp	r1, #0
c0d02566:	d003      	beq.n	c0d02570 <ui_display_debug+0x14>
c0d02568:	2a00      	cmp	r2, #0
c0d0256a:	d001      	beq.n	c0d02570 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d0256c:	f7fd fd9a 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02570:	4c21      	ldr	r4, [pc, #132]	; (c0d025f8 <ui_display_debug+0x9c>)
c0d02572:	4823      	ldr	r0, [pc, #140]	; (c0d02600 <ui_display_debug+0xa4>)
c0d02574:	4478      	add	r0, pc
c0d02576:	6020      	str	r0, [r4, #0]
c0d02578:	2004      	movs	r0, #4
c0d0257a:	6060      	str	r0, [r4, #4]
c0d0257c:	4821      	ldr	r0, [pc, #132]	; (c0d02604 <ui_display_debug+0xa8>)
c0d0257e:	4478      	add	r0, pc
c0d02580:	6120      	str	r0, [r4, #16]
c0d02582:	2500      	movs	r5, #0
c0d02584:	60e5      	str	r5, [r4, #12]
c0d02586:	2003      	movs	r0, #3
c0d02588:	7620      	strb	r0, [r4, #24]
c0d0258a:	61e5      	str	r5, [r4, #28]
c0d0258c:	4620      	mov	r0, r4
c0d0258e:	3018      	adds	r0, #24
c0d02590:	f7ff fedc 	bl	c0d0234c <os_ux>
c0d02594:	61e0      	str	r0, [r4, #28]
c0d02596:	f7ff f89d 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d0259a:	60a5      	str	r5, [r4, #8]
c0d0259c:	6820      	ldr	r0, [r4, #0]
c0d0259e:	2800      	cmp	r0, #0
c0d025a0:	d028      	beq.n	c0d025f4 <ui_display_debug+0x98>
c0d025a2:	69e0      	ldr	r0, [r4, #28]
c0d025a4:	4915      	ldr	r1, [pc, #84]	; (c0d025fc <ui_display_debug+0xa0>)
c0d025a6:	4288      	cmp	r0, r1
c0d025a8:	d116      	bne.n	c0d025d8 <ui_display_debug+0x7c>
c0d025aa:	e023      	b.n	c0d025f4 <ui_display_debug+0x98>
c0d025ac:	6860      	ldr	r0, [r4, #4]
c0d025ae:	4285      	cmp	r5, r0
c0d025b0:	d220      	bcs.n	c0d025f4 <ui_display_debug+0x98>
c0d025b2:	f7ff ff23 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d025b6:	2800      	cmp	r0, #0
c0d025b8:	d11c      	bne.n	c0d025f4 <ui_display_debug+0x98>
c0d025ba:	68a0      	ldr	r0, [r4, #8]
c0d025bc:	68e1      	ldr	r1, [r4, #12]
c0d025be:	2538      	movs	r5, #56	; 0x38
c0d025c0:	4368      	muls	r0, r5
c0d025c2:	6822      	ldr	r2, [r4, #0]
c0d025c4:	1810      	adds	r0, r2, r0
c0d025c6:	2900      	cmp	r1, #0
c0d025c8:	d009      	beq.n	c0d025de <ui_display_debug+0x82>
c0d025ca:	4788      	blx	r1
c0d025cc:	2800      	cmp	r0, #0
c0d025ce:	d106      	bne.n	c0d025de <ui_display_debug+0x82>
c0d025d0:	68a0      	ldr	r0, [r4, #8]
c0d025d2:	1c45      	adds	r5, r0, #1
c0d025d4:	60a5      	str	r5, [r4, #8]
c0d025d6:	6820      	ldr	r0, [r4, #0]
c0d025d8:	2800      	cmp	r0, #0
c0d025da:	d1e7      	bne.n	c0d025ac <ui_display_debug+0x50>
c0d025dc:	e00a      	b.n	c0d025f4 <ui_display_debug+0x98>
c0d025de:	2801      	cmp	r0, #1
c0d025e0:	d103      	bne.n	c0d025ea <ui_display_debug+0x8e>
c0d025e2:	68a0      	ldr	r0, [r4, #8]
c0d025e4:	4345      	muls	r5, r0
c0d025e6:	6820      	ldr	r0, [r4, #0]
c0d025e8:	1940      	adds	r0, r0, r5
c0d025ea:	f7fe fb2b 	bl	c0d00c44 <io_seproxyhal_display>
c0d025ee:	68a0      	ldr	r0, [r4, #8]
c0d025f0:	1c40      	adds	r0, r0, #1
c0d025f2:	60a0      	str	r0, [r4, #8]
}
c0d025f4:	bdb0      	pop	{r4, r5, r7, pc}
c0d025f6:	46c0      	nop			; (mov r8, r8)
c0d025f8:	20001a98 	.word	0x20001a98
c0d025fc:	b0105044 	.word	0xb0105044
c0d02600:	000017dc 	.word	0x000017dc
c0d02604:	00000087 	.word	0x00000087

c0d02608 <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02608:	b580      	push	{r7, lr}
c0d0260a:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d0260c:	4905      	ldr	r1, [pc, #20]	; (c0d02624 <bagl_ui_nanos_screen2_button+0x1c>)
c0d0260e:	4288      	cmp	r0, r1
c0d02610:	d002      	beq.n	c0d02618 <bagl_ui_nanos_screen2_button+0x10>
c0d02612:	4905      	ldr	r1, [pc, #20]	; (c0d02628 <bagl_ui_nanos_screen2_button+0x20>)
c0d02614:	4288      	cmp	r0, r1
c0d02616:	d102      	bne.n	c0d0261e <bagl_ui_nanos_screen2_button+0x16>
c0d02618:	2000      	movs	r0, #0
c0d0261a:	f7ff fe79 	bl	c0d02310 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0261e:	2000      	movs	r0, #0
c0d02620:	bd80      	pop	{r7, pc}
c0d02622:	46c0      	nop			; (mov r8, r8)
c0d02624:	80000002 	.word	0x80000002
c0d02628:	80000001 	.word	0x80000001

c0d0262c <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d0262c:	b5b0      	push	{r4, r5, r7, lr}
c0d0262e:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d02630:	2001      	movs	r0, #1
c0d02632:	0204      	lsls	r4, r0, #8
c0d02634:	f7ff fea8 	bl	c0d02388 <os_seph_features>
c0d02638:	4220      	tst	r0, r4
c0d0263a:	d136      	bne.n	c0d026aa <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d0263c:	4c3c      	ldr	r4, [pc, #240]	; (c0d02730 <ui_idle+0x104>)
c0d0263e:	4840      	ldr	r0, [pc, #256]	; (c0d02740 <ui_idle+0x114>)
c0d02640:	4478      	add	r0, pc
c0d02642:	6020      	str	r0, [r4, #0]
c0d02644:	2004      	movs	r0, #4
c0d02646:	6060      	str	r0, [r4, #4]
c0d02648:	483e      	ldr	r0, [pc, #248]	; (c0d02744 <ui_idle+0x118>)
c0d0264a:	4478      	add	r0, pc
c0d0264c:	6120      	str	r0, [r4, #16]
c0d0264e:	2500      	movs	r5, #0
c0d02650:	60e5      	str	r5, [r4, #12]
c0d02652:	2003      	movs	r0, #3
c0d02654:	7620      	strb	r0, [r4, #24]
c0d02656:	61e5      	str	r5, [r4, #28]
c0d02658:	4620      	mov	r0, r4
c0d0265a:	3018      	adds	r0, #24
c0d0265c:	f7ff fe76 	bl	c0d0234c <os_ux>
c0d02660:	61e0      	str	r0, [r4, #28]
c0d02662:	f7ff f837 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d02666:	60a5      	str	r5, [r4, #8]
c0d02668:	6820      	ldr	r0, [r4, #0]
c0d0266a:	2800      	cmp	r0, #0
c0d0266c:	d05f      	beq.n	c0d0272e <ui_idle+0x102>
c0d0266e:	69e0      	ldr	r0, [r4, #28]
c0d02670:	4930      	ldr	r1, [pc, #192]	; (c0d02734 <ui_idle+0x108>)
c0d02672:	4288      	cmp	r0, r1
c0d02674:	d116      	bne.n	c0d026a4 <ui_idle+0x78>
c0d02676:	e05a      	b.n	c0d0272e <ui_idle+0x102>
c0d02678:	6860      	ldr	r0, [r4, #4]
c0d0267a:	4285      	cmp	r5, r0
c0d0267c:	d257      	bcs.n	c0d0272e <ui_idle+0x102>
c0d0267e:	f7ff febd 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d02682:	2800      	cmp	r0, #0
c0d02684:	d153      	bne.n	c0d0272e <ui_idle+0x102>
c0d02686:	68a0      	ldr	r0, [r4, #8]
c0d02688:	68e1      	ldr	r1, [r4, #12]
c0d0268a:	2538      	movs	r5, #56	; 0x38
c0d0268c:	4368      	muls	r0, r5
c0d0268e:	6822      	ldr	r2, [r4, #0]
c0d02690:	1810      	adds	r0, r2, r0
c0d02692:	2900      	cmp	r1, #0
c0d02694:	d040      	beq.n	c0d02718 <ui_idle+0xec>
c0d02696:	4788      	blx	r1
c0d02698:	2800      	cmp	r0, #0
c0d0269a:	d13d      	bne.n	c0d02718 <ui_idle+0xec>
c0d0269c:	68a0      	ldr	r0, [r4, #8]
c0d0269e:	1c45      	adds	r5, r0, #1
c0d026a0:	60a5      	str	r5, [r4, #8]
c0d026a2:	6820      	ldr	r0, [r4, #0]
c0d026a4:	2800      	cmp	r0, #0
c0d026a6:	d1e7      	bne.n	c0d02678 <ui_idle+0x4c>
c0d026a8:	e041      	b.n	c0d0272e <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d026aa:	4c21      	ldr	r4, [pc, #132]	; (c0d02730 <ui_idle+0x104>)
c0d026ac:	4822      	ldr	r0, [pc, #136]	; (c0d02738 <ui_idle+0x10c>)
c0d026ae:	4478      	add	r0, pc
c0d026b0:	6020      	str	r0, [r4, #0]
c0d026b2:	2004      	movs	r0, #4
c0d026b4:	6060      	str	r0, [r4, #4]
c0d026b6:	4821      	ldr	r0, [pc, #132]	; (c0d0273c <ui_idle+0x110>)
c0d026b8:	4478      	add	r0, pc
c0d026ba:	6120      	str	r0, [r4, #16]
c0d026bc:	2500      	movs	r5, #0
c0d026be:	60e5      	str	r5, [r4, #12]
c0d026c0:	2003      	movs	r0, #3
c0d026c2:	7620      	strb	r0, [r4, #24]
c0d026c4:	61e5      	str	r5, [r4, #28]
c0d026c6:	4620      	mov	r0, r4
c0d026c8:	3018      	adds	r0, #24
c0d026ca:	f7ff fe3f 	bl	c0d0234c <os_ux>
c0d026ce:	61e0      	str	r0, [r4, #28]
c0d026d0:	f7ff f800 	bl	c0d016d4 <io_seproxyhal_init_ux>
c0d026d4:	60a5      	str	r5, [r4, #8]
c0d026d6:	6820      	ldr	r0, [r4, #0]
c0d026d8:	2800      	cmp	r0, #0
c0d026da:	d028      	beq.n	c0d0272e <ui_idle+0x102>
c0d026dc:	69e0      	ldr	r0, [r4, #28]
c0d026de:	4915      	ldr	r1, [pc, #84]	; (c0d02734 <ui_idle+0x108>)
c0d026e0:	4288      	cmp	r0, r1
c0d026e2:	d116      	bne.n	c0d02712 <ui_idle+0xe6>
c0d026e4:	e023      	b.n	c0d0272e <ui_idle+0x102>
c0d026e6:	6860      	ldr	r0, [r4, #4]
c0d026e8:	4285      	cmp	r5, r0
c0d026ea:	d220      	bcs.n	c0d0272e <ui_idle+0x102>
c0d026ec:	f7ff fe86 	bl	c0d023fc <io_seproxyhal_spi_is_status_sent>
c0d026f0:	2800      	cmp	r0, #0
c0d026f2:	d11c      	bne.n	c0d0272e <ui_idle+0x102>
c0d026f4:	68a0      	ldr	r0, [r4, #8]
c0d026f6:	68e1      	ldr	r1, [r4, #12]
c0d026f8:	2538      	movs	r5, #56	; 0x38
c0d026fa:	4368      	muls	r0, r5
c0d026fc:	6822      	ldr	r2, [r4, #0]
c0d026fe:	1810      	adds	r0, r2, r0
c0d02700:	2900      	cmp	r1, #0
c0d02702:	d009      	beq.n	c0d02718 <ui_idle+0xec>
c0d02704:	4788      	blx	r1
c0d02706:	2800      	cmp	r0, #0
c0d02708:	d106      	bne.n	c0d02718 <ui_idle+0xec>
c0d0270a:	68a0      	ldr	r0, [r4, #8]
c0d0270c:	1c45      	adds	r5, r0, #1
c0d0270e:	60a5      	str	r5, [r4, #8]
c0d02710:	6820      	ldr	r0, [r4, #0]
c0d02712:	2800      	cmp	r0, #0
c0d02714:	d1e7      	bne.n	c0d026e6 <ui_idle+0xba>
c0d02716:	e00a      	b.n	c0d0272e <ui_idle+0x102>
c0d02718:	2801      	cmp	r0, #1
c0d0271a:	d103      	bne.n	c0d02724 <ui_idle+0xf8>
c0d0271c:	68a0      	ldr	r0, [r4, #8]
c0d0271e:	4345      	muls	r5, r0
c0d02720:	6820      	ldr	r0, [r4, #0]
c0d02722:	1940      	adds	r0, r0, r5
c0d02724:	f7fe fa8e 	bl	c0d00c44 <io_seproxyhal_display>
c0d02728:	68a0      	ldr	r0, [r4, #8]
c0d0272a:	1c40      	adds	r0, r0, #1
c0d0272c:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d0272e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02730:	20001a98 	.word	0x20001a98
c0d02734:	b0105044 	.word	0xb0105044
c0d02738:	00001782 	.word	0x00001782
c0d0273c:	0000008d 	.word	0x0000008d
c0d02740:	00001630 	.word	0x00001630
c0d02744:	fffffe27 	.word	0xfffffe27

c0d02748 <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d02748:	2000      	movs	r0, #0
c0d0274a:	4770      	bx	lr

c0d0274c <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d0274c:	b5d0      	push	{r4, r6, r7, lr}
c0d0274e:	af02      	add	r7, sp, #8
c0d02750:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02752:	4620      	mov	r0, r4
c0d02754:	f7ff fddc 	bl	c0d02310 <os_sched_exit>
    return NULL;
c0d02758:	4620      	mov	r0, r4
c0d0275a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0275c <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d0275c:	4902      	ldr	r1, [pc, #8]	; (c0d02768 <USBD_LL_Init+0xc>)
c0d0275e:	2000      	movs	r0, #0
c0d02760:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02762:	4902      	ldr	r1, [pc, #8]	; (c0d0276c <USBD_LL_Init+0x10>)
c0d02764:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d02766:	4770      	bx	lr
c0d02768:	20001d2c 	.word	0x20001d2c
c0d0276c:	20001d30 	.word	0x20001d30

c0d02770 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02770:	b5d0      	push	{r4, r6, r7, lr}
c0d02772:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02774:	4806      	ldr	r0, [pc, #24]	; (c0d02790 <USBD_LL_DeInit+0x20>)
c0d02776:	214f      	movs	r1, #79	; 0x4f
c0d02778:	7001      	strb	r1, [r0, #0]
c0d0277a:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0277c:	7044      	strb	r4, [r0, #1]
c0d0277e:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02780:	7081      	strb	r1, [r0, #2]
c0d02782:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02784:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02786:	2104      	movs	r1, #4
c0d02788:	f7ff fe1a 	bl	c0d023c0 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d0278c:	4620      	mov	r0, r4
c0d0278e:	bdd0      	pop	{r4, r6, r7, pc}
c0d02790:	20001a18 	.word	0x20001a18

c0d02794 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02794:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02796:	af03      	add	r7, sp, #12
c0d02798:	b083      	sub	sp, #12
c0d0279a:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0279c:	264f      	movs	r6, #79	; 0x4f
c0d0279e:	702e      	strb	r6, [r5, #0]
c0d027a0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027a2:	706c      	strb	r4, [r5, #1]
c0d027a4:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d027a6:	70a8      	strb	r0, [r5, #2]
c0d027a8:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d027aa:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d027ac:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d027ae:	2105      	movs	r1, #5
c0d027b0:	4628      	mov	r0, r5
c0d027b2:	f7ff fe05 	bl	c0d023c0 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027b6:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d027b8:	706c      	strb	r4, [r5, #1]
c0d027ba:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d027bc:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d027be:	70e8      	strb	r0, [r5, #3]
c0d027c0:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d027c2:	4628      	mov	r0, r5
c0d027c4:	f7ff fdfc 	bl	c0d023c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d027c8:	4620      	mov	r0, r4
c0d027ca:	b003      	add	sp, #12
c0d027cc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d027ce <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d027ce:	b5d0      	push	{r4, r6, r7, lr}
c0d027d0:	af02      	add	r7, sp, #8
c0d027d2:	b082      	sub	sp, #8
c0d027d4:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027d6:	214f      	movs	r1, #79	; 0x4f
c0d027d8:	7001      	strb	r1, [r0, #0]
c0d027da:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027dc:	7044      	strb	r4, [r0, #1]
c0d027de:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d027e0:	7081      	strb	r1, [r0, #2]
c0d027e2:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d027e4:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d027e6:	2104      	movs	r1, #4
c0d027e8:	f7ff fdea 	bl	c0d023c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d027ec:	4620      	mov	r0, r4
c0d027ee:	b002      	add	sp, #8
c0d027f0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d027f4 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d027f4:	b5b0      	push	{r4, r5, r7, lr}
c0d027f6:	af02      	add	r7, sp, #8
c0d027f8:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d027fa:	480f      	ldr	r0, [pc, #60]	; (c0d02838 <USBD_LL_OpenEP+0x44>)
c0d027fc:	2400      	movs	r4, #0
c0d027fe:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d02800:	480e      	ldr	r0, [pc, #56]	; (c0d0283c <USBD_LL_OpenEP+0x48>)
c0d02802:	6004      	str	r4, [r0, #0]
c0d02804:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02806:	254f      	movs	r5, #79	; 0x4f
c0d02808:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d0280a:	7044      	strb	r4, [r0, #1]
c0d0280c:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0280e:	7085      	strb	r5, [r0, #2]
c0d02810:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02812:	70c5      	strb	r5, [r0, #3]
c0d02814:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d02816:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d02818:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d0281a:	2a03      	cmp	r2, #3
c0d0281c:	d802      	bhi.n	c0d02824 <USBD_LL_OpenEP+0x30>
c0d0281e:	00d0      	lsls	r0, r2, #3
c0d02820:	4c07      	ldr	r4, [pc, #28]	; (c0d02840 <USBD_LL_OpenEP+0x4c>)
c0d02822:	40c4      	lsrs	r4, r0
c0d02824:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02826:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02828:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0282a:	2108      	movs	r1, #8
c0d0282c:	f7ff fdc8 	bl	c0d023c0 <io_seproxyhal_spi_send>
c0d02830:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02832:	b002      	add	sp, #8
c0d02834:	bdb0      	pop	{r4, r5, r7, pc}
c0d02836:	46c0      	nop			; (mov r8, r8)
c0d02838:	20001d2c 	.word	0x20001d2c
c0d0283c:	20001d30 	.word	0x20001d30
c0d02840:	02030401 	.word	0x02030401

c0d02844 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02844:	b5d0      	push	{r4, r6, r7, lr}
c0d02846:	af02      	add	r7, sp, #8
c0d02848:	b082      	sub	sp, #8
c0d0284a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0284c:	224f      	movs	r2, #79	; 0x4f
c0d0284e:	7002      	strb	r2, [r0, #0]
c0d02850:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02852:	7044      	strb	r4, [r0, #1]
c0d02854:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d02856:	7082      	strb	r2, [r0, #2]
c0d02858:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0285a:	70c2      	strb	r2, [r0, #3]
c0d0285c:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0285e:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02860:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02862:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02864:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d02866:	2108      	movs	r1, #8
c0d02868:	f7ff fdaa 	bl	c0d023c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0286c:	4620      	mov	r0, r4
c0d0286e:	b002      	add	sp, #8
c0d02870:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02874 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02874:	b5b0      	push	{r4, r5, r7, lr}
c0d02876:	af02      	add	r7, sp, #8
c0d02878:	b082      	sub	sp, #8
c0d0287a:	460d      	mov	r5, r1
c0d0287c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0287e:	2150      	movs	r1, #80	; 0x50
c0d02880:	7001      	strb	r1, [r0, #0]
c0d02882:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02884:	7044      	strb	r4, [r0, #1]
c0d02886:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02888:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0288a:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0288c:	2140      	movs	r1, #64	; 0x40
c0d0288e:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02890:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02892:	2106      	movs	r1, #6
c0d02894:	f7ff fd94 	bl	c0d023c0 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02898:	2080      	movs	r0, #128	; 0x80
c0d0289a:	4205      	tst	r5, r0
c0d0289c:	d101      	bne.n	c0d028a2 <USBD_LL_StallEP+0x2e>
c0d0289e:	4807      	ldr	r0, [pc, #28]	; (c0d028bc <USBD_LL_StallEP+0x48>)
c0d028a0:	e000      	b.n	c0d028a4 <USBD_LL_StallEP+0x30>
c0d028a2:	4805      	ldr	r0, [pc, #20]	; (c0d028b8 <USBD_LL_StallEP+0x44>)
c0d028a4:	6801      	ldr	r1, [r0, #0]
c0d028a6:	227f      	movs	r2, #127	; 0x7f
c0d028a8:	4015      	ands	r5, r2
c0d028aa:	2201      	movs	r2, #1
c0d028ac:	40aa      	lsls	r2, r5
c0d028ae:	430a      	orrs	r2, r1
c0d028b0:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d028b2:	4620      	mov	r0, r4
c0d028b4:	b002      	add	sp, #8
c0d028b6:	bdb0      	pop	{r4, r5, r7, pc}
c0d028b8:	20001d2c 	.word	0x20001d2c
c0d028bc:	20001d30 	.word	0x20001d30

c0d028c0 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d028c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028c2:	af03      	add	r7, sp, #12
c0d028c4:	b083      	sub	sp, #12
c0d028c6:	460d      	mov	r5, r1
c0d028c8:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d028ca:	2150      	movs	r1, #80	; 0x50
c0d028cc:	7001      	strb	r1, [r0, #0]
c0d028ce:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d028d0:	7044      	strb	r4, [r0, #1]
c0d028d2:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d028d4:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d028d6:	70c5      	strb	r5, [r0, #3]
c0d028d8:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d028da:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d028dc:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d028de:	2106      	movs	r1, #6
c0d028e0:	f7ff fd6e 	bl	c0d023c0 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d028e4:	4235      	tst	r5, r6
c0d028e6:	d101      	bne.n	c0d028ec <USBD_LL_ClearStallEP+0x2c>
c0d028e8:	4807      	ldr	r0, [pc, #28]	; (c0d02908 <USBD_LL_ClearStallEP+0x48>)
c0d028ea:	e000      	b.n	c0d028ee <USBD_LL_ClearStallEP+0x2e>
c0d028ec:	4805      	ldr	r0, [pc, #20]	; (c0d02904 <USBD_LL_ClearStallEP+0x44>)
c0d028ee:	6801      	ldr	r1, [r0, #0]
c0d028f0:	227f      	movs	r2, #127	; 0x7f
c0d028f2:	4015      	ands	r5, r2
c0d028f4:	2201      	movs	r2, #1
c0d028f6:	40aa      	lsls	r2, r5
c0d028f8:	4391      	bics	r1, r2
c0d028fa:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d028fc:	4620      	mov	r0, r4
c0d028fe:	b003      	add	sp, #12
c0d02900:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02902:	46c0      	nop			; (mov r8, r8)
c0d02904:	20001d2c 	.word	0x20001d2c
c0d02908:	20001d30 	.word	0x20001d30

c0d0290c <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d0290c:	2080      	movs	r0, #128	; 0x80
c0d0290e:	4201      	tst	r1, r0
c0d02910:	d001      	beq.n	c0d02916 <USBD_LL_IsStallEP+0xa>
c0d02912:	4806      	ldr	r0, [pc, #24]	; (c0d0292c <USBD_LL_IsStallEP+0x20>)
c0d02914:	e000      	b.n	c0d02918 <USBD_LL_IsStallEP+0xc>
c0d02916:	4804      	ldr	r0, [pc, #16]	; (c0d02928 <USBD_LL_IsStallEP+0x1c>)
c0d02918:	6800      	ldr	r0, [r0, #0]
c0d0291a:	227f      	movs	r2, #127	; 0x7f
c0d0291c:	4011      	ands	r1, r2
c0d0291e:	2201      	movs	r2, #1
c0d02920:	408a      	lsls	r2, r1
c0d02922:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02924:	b2d0      	uxtb	r0, r2
c0d02926:	4770      	bx	lr
c0d02928:	20001d30 	.word	0x20001d30
c0d0292c:	20001d2c 	.word	0x20001d2c

c0d02930 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02930:	b5d0      	push	{r4, r6, r7, lr}
c0d02932:	af02      	add	r7, sp, #8
c0d02934:	b082      	sub	sp, #8
c0d02936:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02938:	224f      	movs	r2, #79	; 0x4f
c0d0293a:	7002      	strb	r2, [r0, #0]
c0d0293c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0293e:	7044      	strb	r4, [r0, #1]
c0d02940:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d02942:	7082      	strb	r2, [r0, #2]
c0d02944:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02946:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02948:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0294a:	2105      	movs	r1, #5
c0d0294c:	f7ff fd38 	bl	c0d023c0 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02950:	4620      	mov	r0, r4
c0d02952:	b002      	add	sp, #8
c0d02954:	bdd0      	pop	{r4, r6, r7, pc}

c0d02956 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02956:	b5b0      	push	{r4, r5, r7, lr}
c0d02958:	af02      	add	r7, sp, #8
c0d0295a:	b082      	sub	sp, #8
c0d0295c:	461c      	mov	r4, r3
c0d0295e:	4615      	mov	r5, r2
c0d02960:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02962:	2250      	movs	r2, #80	; 0x50
c0d02964:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02966:	1ce2      	adds	r2, r4, #3
c0d02968:	0a13      	lsrs	r3, r2, #8
c0d0296a:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d0296c:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d0296e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02970:	2120      	movs	r1, #32
c0d02972:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02974:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02976:	2106      	movs	r1, #6
c0d02978:	f7ff fd22 	bl	c0d023c0 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d0297c:	4628      	mov	r0, r5
c0d0297e:	4621      	mov	r1, r4
c0d02980:	f7ff fd1e 	bl	c0d023c0 <io_seproxyhal_spi_send>
c0d02984:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02986:	b002      	add	sp, #8
c0d02988:	bdb0      	pop	{r4, r5, r7, pc}

c0d0298a <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0298a:	b5d0      	push	{r4, r6, r7, lr}
c0d0298c:	af02      	add	r7, sp, #8
c0d0298e:	b082      	sub	sp, #8
c0d02990:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02992:	2350      	movs	r3, #80	; 0x50
c0d02994:	7003      	strb	r3, [r0, #0]
c0d02996:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d02998:	7044      	strb	r4, [r0, #1]
c0d0299a:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d0299c:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0299e:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d029a0:	2130      	movs	r1, #48	; 0x30
c0d029a2:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d029a4:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d029a6:	2106      	movs	r1, #6
c0d029a8:	f7ff fd0a 	bl	c0d023c0 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d029ac:	4620      	mov	r0, r4
c0d029ae:	b002      	add	sp, #8
c0d029b0:	bdd0      	pop	{r4, r6, r7, pc}

c0d029b2 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d029b2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029b4:	af03      	add	r7, sp, #12
c0d029b6:	b081      	sub	sp, #4
c0d029b8:	4615      	mov	r5, r2
c0d029ba:	460e      	mov	r6, r1
c0d029bc:	4604      	mov	r4, r0
c0d029be:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d029c0:	2c00      	cmp	r4, #0
c0d029c2:	d011      	beq.n	c0d029e8 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d029c4:	2049      	movs	r0, #73	; 0x49
c0d029c6:	0081      	lsls	r1, r0, #2
c0d029c8:	4620      	mov	r0, r4
c0d029ca:	f001 f803 	bl	c0d039d4 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d029ce:	2e00      	cmp	r6, #0
c0d029d0:	d002      	beq.n	c0d029d8 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d029d2:	2011      	movs	r0, #17
c0d029d4:	0100      	lsls	r0, r0, #4
c0d029d6:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d029d8:	20fc      	movs	r0, #252	; 0xfc
c0d029da:	2101      	movs	r1, #1
c0d029dc:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d029de:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d029e0:	4620      	mov	r0, r4
c0d029e2:	f7ff febb 	bl	c0d0275c <USBD_LL_Init>
c0d029e6:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d029e8:	b2c0      	uxtb	r0, r0
c0d029ea:	b001      	add	sp, #4
c0d029ec:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d029ee <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d029ee:	b5d0      	push	{r4, r6, r7, lr}
c0d029f0:	af02      	add	r7, sp, #8
c0d029f2:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d029f4:	20fc      	movs	r0, #252	; 0xfc
c0d029f6:	2101      	movs	r1, #1
c0d029f8:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d029fa:	2045      	movs	r0, #69	; 0x45
c0d029fc:	0080      	lsls	r0, r0, #2
c0d029fe:	5820      	ldr	r0, [r4, r0]
c0d02a00:	2800      	cmp	r0, #0
c0d02a02:	d006      	beq.n	c0d02a12 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02a04:	6840      	ldr	r0, [r0, #4]
c0d02a06:	f7ff fb1f 	bl	c0d02048 <pic>
c0d02a0a:	4602      	mov	r2, r0
c0d02a0c:	7921      	ldrb	r1, [r4, #4]
c0d02a0e:	4620      	mov	r0, r4
c0d02a10:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02a12:	4620      	mov	r0, r4
c0d02a14:	f7ff fedb 	bl	c0d027ce <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02a18:	4620      	mov	r0, r4
c0d02a1a:	f7ff fea9 	bl	c0d02770 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d02a1e:	2000      	movs	r0, #0
c0d02a20:	bdd0      	pop	{r4, r6, r7, pc}

c0d02a22 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d02a22:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02a24:	2900      	cmp	r1, #0
c0d02a26:	d003      	beq.n	c0d02a30 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d02a28:	2245      	movs	r2, #69	; 0x45
c0d02a2a:	0092      	lsls	r2, r2, #2
c0d02a2c:	5081      	str	r1, [r0, r2]
c0d02a2e:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02a30:	b2d0      	uxtb	r0, r2
c0d02a32:	4770      	bx	lr

c0d02a34 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02a34:	b580      	push	{r7, lr}
c0d02a36:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02a38:	f7ff feac 	bl	c0d02794 <USBD_LL_Start>
  
  return USBD_OK;  
c0d02a3c:	2000      	movs	r0, #0
c0d02a3e:	bd80      	pop	{r7, pc}

c0d02a40 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02a40:	b5b0      	push	{r4, r5, r7, lr}
c0d02a42:	af02      	add	r7, sp, #8
c0d02a44:	460c      	mov	r4, r1
c0d02a46:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d02a48:	2045      	movs	r0, #69	; 0x45
c0d02a4a:	0080      	lsls	r0, r0, #2
c0d02a4c:	5828      	ldr	r0, [r5, r0]
c0d02a4e:	2800      	cmp	r0, #0
c0d02a50:	d00c      	beq.n	c0d02a6c <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02a52:	6800      	ldr	r0, [r0, #0]
c0d02a54:	f7ff faf8 	bl	c0d02048 <pic>
c0d02a58:	4602      	mov	r2, r0
c0d02a5a:	4628      	mov	r0, r5
c0d02a5c:	4621      	mov	r1, r4
c0d02a5e:	4790      	blx	r2
c0d02a60:	4601      	mov	r1, r0
c0d02a62:	2002      	movs	r0, #2
c0d02a64:	2900      	cmp	r1, #0
c0d02a66:	d100      	bne.n	c0d02a6a <USBD_SetClassConfig+0x2a>
c0d02a68:	4608      	mov	r0, r1
c0d02a6a:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02a6c:	2002      	movs	r0, #2
c0d02a6e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a70 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02a70:	b5b0      	push	{r4, r5, r7, lr}
c0d02a72:	af02      	add	r7, sp, #8
c0d02a74:	460c      	mov	r4, r1
c0d02a76:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d02a78:	2045      	movs	r0, #69	; 0x45
c0d02a7a:	0080      	lsls	r0, r0, #2
c0d02a7c:	5828      	ldr	r0, [r5, r0]
c0d02a7e:	2800      	cmp	r0, #0
c0d02a80:	d006      	beq.n	c0d02a90 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02a82:	6840      	ldr	r0, [r0, #4]
c0d02a84:	f7ff fae0 	bl	c0d02048 <pic>
c0d02a88:	4602      	mov	r2, r0
c0d02a8a:	4628      	mov	r0, r5
c0d02a8c:	4621      	mov	r1, r4
c0d02a8e:	4790      	blx	r2
  }
  return USBD_OK;
c0d02a90:	2000      	movs	r0, #0
c0d02a92:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a94 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02a94:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a96:	af03      	add	r7, sp, #12
c0d02a98:	b081      	sub	sp, #4
c0d02a9a:	4604      	mov	r4, r0
c0d02a9c:	2021      	movs	r0, #33	; 0x21
c0d02a9e:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02aa0:	19a5      	adds	r5, r4, r6
c0d02aa2:	4628      	mov	r0, r5
c0d02aa4:	f000 fb69 	bl	c0d0317a <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02aa8:	20f4      	movs	r0, #244	; 0xf4
c0d02aaa:	2101      	movs	r1, #1
c0d02aac:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02aae:	2087      	movs	r0, #135	; 0x87
c0d02ab0:	0040      	lsls	r0, r0, #1
c0d02ab2:	5a20      	ldrh	r0, [r4, r0]
c0d02ab4:	21f8      	movs	r1, #248	; 0xf8
c0d02ab6:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02ab8:	5da1      	ldrb	r1, [r4, r6]
c0d02aba:	201f      	movs	r0, #31
c0d02abc:	4008      	ands	r0, r1
c0d02abe:	2802      	cmp	r0, #2
c0d02ac0:	d008      	beq.n	c0d02ad4 <USBD_LL_SetupStage+0x40>
c0d02ac2:	2801      	cmp	r0, #1
c0d02ac4:	d00b      	beq.n	c0d02ade <USBD_LL_SetupStage+0x4a>
c0d02ac6:	2800      	cmp	r0, #0
c0d02ac8:	d10e      	bne.n	c0d02ae8 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02aca:	4620      	mov	r0, r4
c0d02acc:	4629      	mov	r1, r5
c0d02ace:	f000 f8f1 	bl	c0d02cb4 <USBD_StdDevReq>
c0d02ad2:	e00e      	b.n	c0d02af2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02ad4:	4620      	mov	r0, r4
c0d02ad6:	4629      	mov	r1, r5
c0d02ad8:	f000 fad3 	bl	c0d03082 <USBD_StdEPReq>
c0d02adc:	e009      	b.n	c0d02af2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02ade:	4620      	mov	r0, r4
c0d02ae0:	4629      	mov	r1, r5
c0d02ae2:	f000 faa6 	bl	c0d03032 <USBD_StdItfReq>
c0d02ae6:	e004      	b.n	c0d02af2 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02ae8:	2080      	movs	r0, #128	; 0x80
c0d02aea:	4001      	ands	r1, r0
c0d02aec:	4620      	mov	r0, r4
c0d02aee:	f7ff fec1 	bl	c0d02874 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d02af2:	2000      	movs	r0, #0
c0d02af4:	b001      	add	sp, #4
c0d02af6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02af8 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02af8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02afa:	af03      	add	r7, sp, #12
c0d02afc:	b081      	sub	sp, #4
c0d02afe:	4615      	mov	r5, r2
c0d02b00:	460e      	mov	r6, r1
c0d02b02:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02b04:	2e00      	cmp	r6, #0
c0d02b06:	d011      	beq.n	c0d02b2c <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b08:	2045      	movs	r0, #69	; 0x45
c0d02b0a:	0080      	lsls	r0, r0, #2
c0d02b0c:	5820      	ldr	r0, [r4, r0]
c0d02b0e:	6980      	ldr	r0, [r0, #24]
c0d02b10:	2800      	cmp	r0, #0
c0d02b12:	d034      	beq.n	c0d02b7e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b14:	21fc      	movs	r1, #252	; 0xfc
c0d02b16:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d02b18:	2903      	cmp	r1, #3
c0d02b1a:	d130      	bne.n	c0d02b7e <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d02b1c:	f7ff fa94 	bl	c0d02048 <pic>
c0d02b20:	4603      	mov	r3, r0
c0d02b22:	4620      	mov	r0, r4
c0d02b24:	4631      	mov	r1, r6
c0d02b26:	462a      	mov	r2, r5
c0d02b28:	4798      	blx	r3
c0d02b2a:	e028      	b.n	c0d02b7e <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02b2c:	20f4      	movs	r0, #244	; 0xf4
c0d02b2e:	5820      	ldr	r0, [r4, r0]
c0d02b30:	2803      	cmp	r0, #3
c0d02b32:	d124      	bne.n	c0d02b7e <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02b34:	2090      	movs	r0, #144	; 0x90
c0d02b36:	5820      	ldr	r0, [r4, r0]
c0d02b38:	218c      	movs	r1, #140	; 0x8c
c0d02b3a:	5861      	ldr	r1, [r4, r1]
c0d02b3c:	4622      	mov	r2, r4
c0d02b3e:	328c      	adds	r2, #140	; 0x8c
c0d02b40:	4281      	cmp	r1, r0
c0d02b42:	d90a      	bls.n	c0d02b5a <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02b44:	1a09      	subs	r1, r1, r0
c0d02b46:	6011      	str	r1, [r2, #0]
c0d02b48:	4281      	cmp	r1, r0
c0d02b4a:	d300      	bcc.n	c0d02b4e <USBD_LL_DataOutStage+0x56>
c0d02b4c:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02b4e:	b28a      	uxth	r2, r1
c0d02b50:	4620      	mov	r0, r4
c0d02b52:	4629      	mov	r1, r5
c0d02b54:	f000 fc70 	bl	c0d03438 <USBD_CtlContinueRx>
c0d02b58:	e011      	b.n	c0d02b7e <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02b5a:	2045      	movs	r0, #69	; 0x45
c0d02b5c:	0080      	lsls	r0, r0, #2
c0d02b5e:	5820      	ldr	r0, [r4, r0]
c0d02b60:	6900      	ldr	r0, [r0, #16]
c0d02b62:	2800      	cmp	r0, #0
c0d02b64:	d008      	beq.n	c0d02b78 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b66:	21fc      	movs	r1, #252	; 0xfc
c0d02b68:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02b6a:	2903      	cmp	r1, #3
c0d02b6c:	d104      	bne.n	c0d02b78 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02b6e:	f7ff fa6b 	bl	c0d02048 <pic>
c0d02b72:	4601      	mov	r1, r0
c0d02b74:	4620      	mov	r0, r4
c0d02b76:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02b78:	4620      	mov	r0, r4
c0d02b7a:	f000 fc65 	bl	c0d03448 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02b7e:	2000      	movs	r0, #0
c0d02b80:	b001      	add	sp, #4
c0d02b82:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b84 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02b84:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b86:	af03      	add	r7, sp, #12
c0d02b88:	b081      	sub	sp, #4
c0d02b8a:	460d      	mov	r5, r1
c0d02b8c:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02b8e:	2d00      	cmp	r5, #0
c0d02b90:	d012      	beq.n	c0d02bb8 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02b92:	2045      	movs	r0, #69	; 0x45
c0d02b94:	0080      	lsls	r0, r0, #2
c0d02b96:	5820      	ldr	r0, [r4, r0]
c0d02b98:	2800      	cmp	r0, #0
c0d02b9a:	d054      	beq.n	c0d02c46 <USBD_LL_DataInStage+0xc2>
c0d02b9c:	6940      	ldr	r0, [r0, #20]
c0d02b9e:	2800      	cmp	r0, #0
c0d02ba0:	d051      	beq.n	c0d02c46 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02ba2:	21fc      	movs	r1, #252	; 0xfc
c0d02ba4:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02ba6:	2903      	cmp	r1, #3
c0d02ba8:	d14d      	bne.n	c0d02c46 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02baa:	f7ff fa4d 	bl	c0d02048 <pic>
c0d02bae:	4602      	mov	r2, r0
c0d02bb0:	4620      	mov	r0, r4
c0d02bb2:	4629      	mov	r1, r5
c0d02bb4:	4790      	blx	r2
c0d02bb6:	e046      	b.n	c0d02c46 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02bb8:	20f4      	movs	r0, #244	; 0xf4
c0d02bba:	5820      	ldr	r0, [r4, r0]
c0d02bbc:	2802      	cmp	r0, #2
c0d02bbe:	d13a      	bne.n	c0d02c36 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02bc0:	69e0      	ldr	r0, [r4, #28]
c0d02bc2:	6a25      	ldr	r5, [r4, #32]
c0d02bc4:	42a8      	cmp	r0, r5
c0d02bc6:	d90b      	bls.n	c0d02be0 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02bc8:	1b40      	subs	r0, r0, r5
c0d02bca:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02bcc:	2109      	movs	r1, #9
c0d02bce:	014a      	lsls	r2, r1, #5
c0d02bd0:	58a1      	ldr	r1, [r4, r2]
c0d02bd2:	1949      	adds	r1, r1, r5
c0d02bd4:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02bd6:	b282      	uxth	r2, r0
c0d02bd8:	4620      	mov	r0, r4
c0d02bda:	f000 fc1e 	bl	c0d0341a <USBD_CtlContinueSendData>
c0d02bde:	e02a      	b.n	c0d02c36 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02be0:	69a6      	ldr	r6, [r4, #24]
c0d02be2:	4630      	mov	r0, r6
c0d02be4:	4629      	mov	r1, r5
c0d02be6:	f000 fccf 	bl	c0d03588 <__aeabi_uidivmod>
c0d02bea:	42ae      	cmp	r6, r5
c0d02bec:	d30f      	bcc.n	c0d02c0e <USBD_LL_DataInStage+0x8a>
c0d02bee:	2900      	cmp	r1, #0
c0d02bf0:	d10d      	bne.n	c0d02c0e <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02bf2:	20f8      	movs	r0, #248	; 0xf8
c0d02bf4:	5820      	ldr	r0, [r4, r0]
c0d02bf6:	4625      	mov	r5, r4
c0d02bf8:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02bfa:	4286      	cmp	r6, r0
c0d02bfc:	d207      	bcs.n	c0d02c0e <USBD_LL_DataInStage+0x8a>
c0d02bfe:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02c00:	4620      	mov	r0, r4
c0d02c02:	4631      	mov	r1, r6
c0d02c04:	4632      	mov	r2, r6
c0d02c06:	f000 fc08 	bl	c0d0341a <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02c0a:	602e      	str	r6, [r5, #0]
c0d02c0c:	e013      	b.n	c0d02c36 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02c0e:	2045      	movs	r0, #69	; 0x45
c0d02c10:	0080      	lsls	r0, r0, #2
c0d02c12:	5820      	ldr	r0, [r4, r0]
c0d02c14:	2800      	cmp	r0, #0
c0d02c16:	d00b      	beq.n	c0d02c30 <USBD_LL_DataInStage+0xac>
c0d02c18:	68c0      	ldr	r0, [r0, #12]
c0d02c1a:	2800      	cmp	r0, #0
c0d02c1c:	d008      	beq.n	c0d02c30 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02c1e:	21fc      	movs	r1, #252	; 0xfc
c0d02c20:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02c22:	2903      	cmp	r1, #3
c0d02c24:	d104      	bne.n	c0d02c30 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02c26:	f7ff fa0f 	bl	c0d02048 <pic>
c0d02c2a:	4601      	mov	r1, r0
c0d02c2c:	4620      	mov	r0, r4
c0d02c2e:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02c30:	4620      	mov	r0, r4
c0d02c32:	f000 fc16 	bl	c0d03462 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02c36:	2001      	movs	r0, #1
c0d02c38:	0201      	lsls	r1, r0, #8
c0d02c3a:	1860      	adds	r0, r4, r1
c0d02c3c:	5c61      	ldrb	r1, [r4, r1]
c0d02c3e:	2901      	cmp	r1, #1
c0d02c40:	d101      	bne.n	c0d02c46 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02c42:	2100      	movs	r1, #0
c0d02c44:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02c46:	2000      	movs	r0, #0
c0d02c48:	b001      	add	sp, #4
c0d02c4a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02c4c <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02c4c:	b5d0      	push	{r4, r6, r7, lr}
c0d02c4e:	af02      	add	r7, sp, #8
c0d02c50:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02c52:	2090      	movs	r0, #144	; 0x90
c0d02c54:	2140      	movs	r1, #64	; 0x40
c0d02c56:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02c58:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02c5a:	20fc      	movs	r0, #252	; 0xfc
c0d02c5c:	2101      	movs	r1, #1
c0d02c5e:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02c60:	2045      	movs	r0, #69	; 0x45
c0d02c62:	0080      	lsls	r0, r0, #2
c0d02c64:	5820      	ldr	r0, [r4, r0]
c0d02c66:	2800      	cmp	r0, #0
c0d02c68:	d006      	beq.n	c0d02c78 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02c6a:	6840      	ldr	r0, [r0, #4]
c0d02c6c:	f7ff f9ec 	bl	c0d02048 <pic>
c0d02c70:	4602      	mov	r2, r0
c0d02c72:	7921      	ldrb	r1, [r4, #4]
c0d02c74:	4620      	mov	r0, r4
c0d02c76:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02c78:	2000      	movs	r0, #0
c0d02c7a:	bdd0      	pop	{r4, r6, r7, pc}

c0d02c7c <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02c7c:	7401      	strb	r1, [r0, #16]
c0d02c7e:	2000      	movs	r0, #0
  return USBD_OK;
c0d02c80:	4770      	bx	lr

c0d02c82 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02c82:	2000      	movs	r0, #0
c0d02c84:	4770      	bx	lr

c0d02c86 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02c86:	2000      	movs	r0, #0
c0d02c88:	4770      	bx	lr

c0d02c8a <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02c8a:	b5d0      	push	{r4, r6, r7, lr}
c0d02c8c:	af02      	add	r7, sp, #8
c0d02c8e:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02c90:	20fc      	movs	r0, #252	; 0xfc
c0d02c92:	5c20      	ldrb	r0, [r4, r0]
c0d02c94:	2803      	cmp	r0, #3
c0d02c96:	d10a      	bne.n	c0d02cae <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02c98:	2045      	movs	r0, #69	; 0x45
c0d02c9a:	0080      	lsls	r0, r0, #2
c0d02c9c:	5820      	ldr	r0, [r4, r0]
c0d02c9e:	69c0      	ldr	r0, [r0, #28]
c0d02ca0:	2800      	cmp	r0, #0
c0d02ca2:	d004      	beq.n	c0d02cae <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02ca4:	f7ff f9d0 	bl	c0d02048 <pic>
c0d02ca8:	4601      	mov	r1, r0
c0d02caa:	4620      	mov	r0, r4
c0d02cac:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02cae:	2000      	movs	r0, #0
c0d02cb0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02cb4 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02cb4:	b5d0      	push	{r4, r6, r7, lr}
c0d02cb6:	af02      	add	r7, sp, #8
c0d02cb8:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02cba:	7848      	ldrb	r0, [r1, #1]
c0d02cbc:	2809      	cmp	r0, #9
c0d02cbe:	d810      	bhi.n	c0d02ce2 <USBD_StdDevReq+0x2e>
c0d02cc0:	4478      	add	r0, pc
c0d02cc2:	7900      	ldrb	r0, [r0, #4]
c0d02cc4:	0040      	lsls	r0, r0, #1
c0d02cc6:	4487      	add	pc, r0
c0d02cc8:	150c0804 	.word	0x150c0804
c0d02ccc:	0c25190c 	.word	0x0c25190c
c0d02cd0:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02cd2:	4620      	mov	r0, r4
c0d02cd4:	f000 f938 	bl	c0d02f48 <USBD_GetStatus>
c0d02cd8:	e01f      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02cda:	4620      	mov	r0, r4
c0d02cdc:	f000 f976 	bl	c0d02fcc <USBD_ClrFeature>
c0d02ce0:	e01b      	b.n	c0d02d1a <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ce2:	2180      	movs	r1, #128	; 0x80
c0d02ce4:	4620      	mov	r0, r4
c0d02ce6:	f7ff fdc5 	bl	c0d02874 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02cea:	2100      	movs	r1, #0
c0d02cec:	4620      	mov	r0, r4
c0d02cee:	f7ff fdc1 	bl	c0d02874 <USBD_LL_StallEP>
c0d02cf2:	e012      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02cf4:	4620      	mov	r0, r4
c0d02cf6:	f000 f950 	bl	c0d02f9a <USBD_SetFeature>
c0d02cfa:	e00e      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02cfc:	4620      	mov	r0, r4
c0d02cfe:	f000 f897 	bl	c0d02e30 <USBD_SetAddress>
c0d02d02:	e00a      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02d04:	4620      	mov	r0, r4
c0d02d06:	f000 f8ff 	bl	c0d02f08 <USBD_GetConfig>
c0d02d0a:	e006      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02d0c:	4620      	mov	r0, r4
c0d02d0e:	f000 f8bd 	bl	c0d02e8c <USBD_SetConfig>
c0d02d12:	e002      	b.n	c0d02d1a <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02d14:	4620      	mov	r0, r4
c0d02d16:	f000 f803 	bl	c0d02d20 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02d1a:	2000      	movs	r0, #0
c0d02d1c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02d20 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02d20:	b5b0      	push	{r4, r5, r7, lr}
c0d02d22:	af02      	add	r7, sp, #8
c0d02d24:	b082      	sub	sp, #8
c0d02d26:	460d      	mov	r5, r1
c0d02d28:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02d2a:	8868      	ldrh	r0, [r5, #2]
c0d02d2c:	0a01      	lsrs	r1, r0, #8
c0d02d2e:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d30:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02d32:	2a0e      	cmp	r2, #14
c0d02d34:	d83e      	bhi.n	c0d02db4 <USBD_GetDescriptor+0x94>
c0d02d36:	46c0      	nop			; (mov r8, r8)
c0d02d38:	447a      	add	r2, pc
c0d02d3a:	7912      	ldrb	r2, [r2, #4]
c0d02d3c:	0052      	lsls	r2, r2, #1
c0d02d3e:	4497      	add	pc, r2
c0d02d40:	390c2607 	.word	0x390c2607
c0d02d44:	39362e39 	.word	0x39362e39
c0d02d48:	39393939 	.word	0x39393939
c0d02d4c:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02d50:	2011      	movs	r0, #17
c0d02d52:	0100      	lsls	r0, r0, #4
c0d02d54:	5820      	ldr	r0, [r4, r0]
c0d02d56:	6800      	ldr	r0, [r0, #0]
c0d02d58:	e012      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02d5a:	b2c0      	uxtb	r0, r0
c0d02d5c:	2805      	cmp	r0, #5
c0d02d5e:	d829      	bhi.n	c0d02db4 <USBD_GetDescriptor+0x94>
c0d02d60:	4478      	add	r0, pc
c0d02d62:	7900      	ldrb	r0, [r0, #4]
c0d02d64:	0040      	lsls	r0, r0, #1
c0d02d66:	4487      	add	pc, r0
c0d02d68:	544f4a02 	.word	0x544f4a02
c0d02d6c:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02d6e:	2011      	movs	r0, #17
c0d02d70:	0100      	lsls	r0, r0, #4
c0d02d72:	5820      	ldr	r0, [r4, r0]
c0d02d74:	6840      	ldr	r0, [r0, #4]
c0d02d76:	e003      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02d78:	2011      	movs	r0, #17
c0d02d7a:	0100      	lsls	r0, r0, #4
c0d02d7c:	5820      	ldr	r0, [r4, r0]
c0d02d7e:	69c0      	ldr	r0, [r0, #28]
c0d02d80:	f7ff f962 	bl	c0d02048 <pic>
c0d02d84:	4602      	mov	r2, r0
c0d02d86:	7c20      	ldrb	r0, [r4, #16]
c0d02d88:	a901      	add	r1, sp, #4
c0d02d8a:	4790      	blx	r2
c0d02d8c:	e025      	b.n	c0d02dda <USBD_GetDescriptor+0xba>
c0d02d8e:	2045      	movs	r0, #69	; 0x45
c0d02d90:	0080      	lsls	r0, r0, #2
c0d02d92:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02d94:	7c21      	ldrb	r1, [r4, #16]
c0d02d96:	2900      	cmp	r1, #0
c0d02d98:	d014      	beq.n	c0d02dc4 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02d9a:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02d9c:	e018      	b.n	c0d02dd0 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02d9e:	7c20      	ldrb	r0, [r4, #16]
c0d02da0:	2800      	cmp	r0, #0
c0d02da2:	d107      	bne.n	c0d02db4 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02da4:	2045      	movs	r0, #69	; 0x45
c0d02da6:	0080      	lsls	r0, r0, #2
c0d02da8:	5820      	ldr	r0, [r4, r0]
c0d02daa:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02dac:	e010      	b.n	c0d02dd0 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02dae:	7c20      	ldrb	r0, [r4, #16]
c0d02db0:	2800      	cmp	r0, #0
c0d02db2:	d009      	beq.n	c0d02dc8 <USBD_GetDescriptor+0xa8>
c0d02db4:	4620      	mov	r0, r4
c0d02db6:	f7ff fd5d 	bl	c0d02874 <USBD_LL_StallEP>
c0d02dba:	2100      	movs	r1, #0
c0d02dbc:	4620      	mov	r0, r4
c0d02dbe:	f7ff fd59 	bl	c0d02874 <USBD_LL_StallEP>
c0d02dc2:	e01a      	b.n	c0d02dfa <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02dc4:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02dc6:	e003      	b.n	c0d02dd0 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02dc8:	2045      	movs	r0, #69	; 0x45
c0d02dca:	0080      	lsls	r0, r0, #2
c0d02dcc:	5820      	ldr	r0, [r4, r0]
c0d02dce:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02dd0:	f7ff f93a 	bl	c0d02048 <pic>
c0d02dd4:	4601      	mov	r1, r0
c0d02dd6:	a801      	add	r0, sp, #4
c0d02dd8:	4788      	blx	r1
c0d02dda:	4601      	mov	r1, r0
c0d02ddc:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02dde:	8802      	ldrh	r2, [r0, #0]
c0d02de0:	2a00      	cmp	r2, #0
c0d02de2:	d00a      	beq.n	c0d02dfa <USBD_GetDescriptor+0xda>
c0d02de4:	88e8      	ldrh	r0, [r5, #6]
c0d02de6:	2800      	cmp	r0, #0
c0d02de8:	d007      	beq.n	c0d02dfa <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02dea:	4282      	cmp	r2, r0
c0d02dec:	d300      	bcc.n	c0d02df0 <USBD_GetDescriptor+0xd0>
c0d02dee:	4602      	mov	r2, r0
c0d02df0:	a801      	add	r0, sp, #4
c0d02df2:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02df4:	4620      	mov	r0, r4
c0d02df6:	f000 faf9 	bl	c0d033ec <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02dfa:	b002      	add	sp, #8
c0d02dfc:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02dfe:	2011      	movs	r0, #17
c0d02e00:	0100      	lsls	r0, r0, #4
c0d02e02:	5820      	ldr	r0, [r4, r0]
c0d02e04:	6880      	ldr	r0, [r0, #8]
c0d02e06:	e7bb      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02e08:	2011      	movs	r0, #17
c0d02e0a:	0100      	lsls	r0, r0, #4
c0d02e0c:	5820      	ldr	r0, [r4, r0]
c0d02e0e:	68c0      	ldr	r0, [r0, #12]
c0d02e10:	e7b6      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02e12:	2011      	movs	r0, #17
c0d02e14:	0100      	lsls	r0, r0, #4
c0d02e16:	5820      	ldr	r0, [r4, r0]
c0d02e18:	6900      	ldr	r0, [r0, #16]
c0d02e1a:	e7b1      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02e1c:	2011      	movs	r0, #17
c0d02e1e:	0100      	lsls	r0, r0, #4
c0d02e20:	5820      	ldr	r0, [r4, r0]
c0d02e22:	6940      	ldr	r0, [r0, #20]
c0d02e24:	e7ac      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02e26:	2011      	movs	r0, #17
c0d02e28:	0100      	lsls	r0, r0, #4
c0d02e2a:	5820      	ldr	r0, [r4, r0]
c0d02e2c:	6980      	ldr	r0, [r0, #24]
c0d02e2e:	e7a7      	b.n	c0d02d80 <USBD_GetDescriptor+0x60>

c0d02e30 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e32:	af03      	add	r7, sp, #12
c0d02e34:	b081      	sub	sp, #4
c0d02e36:	460a      	mov	r2, r1
c0d02e38:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02e3a:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e3c:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02e3e:	2800      	cmp	r0, #0
c0d02e40:	d10b      	bne.n	c0d02e5a <USBD_SetAddress+0x2a>
c0d02e42:	88d0      	ldrh	r0, [r2, #6]
c0d02e44:	2800      	cmp	r0, #0
c0d02e46:	d108      	bne.n	c0d02e5a <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02e48:	8850      	ldrh	r0, [r2, #2]
c0d02e4a:	267f      	movs	r6, #127	; 0x7f
c0d02e4c:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02e4e:	20fc      	movs	r0, #252	; 0xfc
c0d02e50:	5c20      	ldrb	r0, [r4, r0]
c0d02e52:	4625      	mov	r5, r4
c0d02e54:	35fc      	adds	r5, #252	; 0xfc
c0d02e56:	2803      	cmp	r0, #3
c0d02e58:	d108      	bne.n	c0d02e6c <USBD_SetAddress+0x3c>
c0d02e5a:	4620      	mov	r0, r4
c0d02e5c:	f7ff fd0a 	bl	c0d02874 <USBD_LL_StallEP>
c0d02e60:	2100      	movs	r1, #0
c0d02e62:	4620      	mov	r0, r4
c0d02e64:	f7ff fd06 	bl	c0d02874 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02e68:	b001      	add	sp, #4
c0d02e6a:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02e6c:	20fe      	movs	r0, #254	; 0xfe
c0d02e6e:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02e70:	b2f1      	uxtb	r1, r6
c0d02e72:	4620      	mov	r0, r4
c0d02e74:	f7ff fd5c 	bl	c0d02930 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02e78:	4620      	mov	r0, r4
c0d02e7a:	f000 fae5 	bl	c0d03448 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02e7e:	2002      	movs	r0, #2
c0d02e80:	2101      	movs	r1, #1
c0d02e82:	2e00      	cmp	r6, #0
c0d02e84:	d100      	bne.n	c0d02e88 <USBD_SetAddress+0x58>
c0d02e86:	4608      	mov	r0, r1
c0d02e88:	7028      	strb	r0, [r5, #0]
c0d02e8a:	e7ed      	b.n	c0d02e68 <USBD_SetAddress+0x38>

c0d02e8c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e8e:	af03      	add	r7, sp, #12
c0d02e90:	b081      	sub	sp, #4
c0d02e92:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02e94:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e96:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02e98:	2e02      	cmp	r6, #2
c0d02e9a:	d21d      	bcs.n	c0d02ed8 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02e9c:	20fc      	movs	r0, #252	; 0xfc
c0d02e9e:	5c21      	ldrb	r1, [r4, r0]
c0d02ea0:	4620      	mov	r0, r4
c0d02ea2:	30fc      	adds	r0, #252	; 0xfc
c0d02ea4:	2903      	cmp	r1, #3
c0d02ea6:	d007      	beq.n	c0d02eb8 <USBD_SetConfig+0x2c>
c0d02ea8:	2902      	cmp	r1, #2
c0d02eaa:	d115      	bne.n	c0d02ed8 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02eac:	2e00      	cmp	r6, #0
c0d02eae:	d026      	beq.n	c0d02efe <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02eb0:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02eb2:	2103      	movs	r1, #3
c0d02eb4:	7001      	strb	r1, [r0, #0]
c0d02eb6:	e009      	b.n	c0d02ecc <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02eb8:	2e00      	cmp	r6, #0
c0d02eba:	d016      	beq.n	c0d02eea <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02ebc:	6860      	ldr	r0, [r4, #4]
c0d02ebe:	4286      	cmp	r6, r0
c0d02ec0:	d01d      	beq.n	c0d02efe <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02ec2:	b2c1      	uxtb	r1, r0
c0d02ec4:	4620      	mov	r0, r4
c0d02ec6:	f7ff fdd3 	bl	c0d02a70 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02eca:	6066      	str	r6, [r4, #4]
c0d02ecc:	4620      	mov	r0, r4
c0d02ece:	4631      	mov	r1, r6
c0d02ed0:	f7ff fdb6 	bl	c0d02a40 <USBD_SetClassConfig>
c0d02ed4:	2802      	cmp	r0, #2
c0d02ed6:	d112      	bne.n	c0d02efe <USBD_SetConfig+0x72>
c0d02ed8:	4620      	mov	r0, r4
c0d02eda:	4629      	mov	r1, r5
c0d02edc:	f7ff fcca 	bl	c0d02874 <USBD_LL_StallEP>
c0d02ee0:	2100      	movs	r1, #0
c0d02ee2:	4620      	mov	r0, r4
c0d02ee4:	f7ff fcc6 	bl	c0d02874 <USBD_LL_StallEP>
c0d02ee8:	e00c      	b.n	c0d02f04 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02eea:	2102      	movs	r1, #2
c0d02eec:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02eee:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02ef0:	4620      	mov	r0, r4
c0d02ef2:	4631      	mov	r1, r6
c0d02ef4:	f7ff fdbc 	bl	c0d02a70 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02ef8:	4620      	mov	r0, r4
c0d02efa:	f000 faa5 	bl	c0d03448 <USBD_CtlSendStatus>
c0d02efe:	4620      	mov	r0, r4
c0d02f00:	f000 faa2 	bl	c0d03448 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02f04:	b001      	add	sp, #4
c0d02f06:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02f08 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f08:	b5d0      	push	{r4, r6, r7, lr}
c0d02f0a:	af02      	add	r7, sp, #8
c0d02f0c:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02f0e:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f10:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02f12:	2801      	cmp	r0, #1
c0d02f14:	d10a      	bne.n	c0d02f2c <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02f16:	20fc      	movs	r0, #252	; 0xfc
c0d02f18:	5c20      	ldrb	r0, [r4, r0]
c0d02f1a:	2803      	cmp	r0, #3
c0d02f1c:	d00e      	beq.n	c0d02f3c <USBD_GetConfig+0x34>
c0d02f1e:	2802      	cmp	r0, #2
c0d02f20:	d104      	bne.n	c0d02f2c <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02f22:	2000      	movs	r0, #0
c0d02f24:	60a0      	str	r0, [r4, #8]
c0d02f26:	4621      	mov	r1, r4
c0d02f28:	3108      	adds	r1, #8
c0d02f2a:	e008      	b.n	c0d02f3e <USBD_GetConfig+0x36>
c0d02f2c:	4620      	mov	r0, r4
c0d02f2e:	f7ff fca1 	bl	c0d02874 <USBD_LL_StallEP>
c0d02f32:	2100      	movs	r1, #0
c0d02f34:	4620      	mov	r0, r4
c0d02f36:	f7ff fc9d 	bl	c0d02874 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02f3a:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02f3c:	1d21      	adds	r1, r4, #4
c0d02f3e:	2201      	movs	r2, #1
c0d02f40:	4620      	mov	r0, r4
c0d02f42:	f000 fa53 	bl	c0d033ec <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02f46:	bdd0      	pop	{r4, r6, r7, pc}

c0d02f48 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02f48:	b5b0      	push	{r4, r5, r7, lr}
c0d02f4a:	af02      	add	r7, sp, #8
c0d02f4c:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02f4e:	20fc      	movs	r0, #252	; 0xfc
c0d02f50:	5c20      	ldrb	r0, [r4, r0]
c0d02f52:	21fe      	movs	r1, #254	; 0xfe
c0d02f54:	4001      	ands	r1, r0
c0d02f56:	2902      	cmp	r1, #2
c0d02f58:	d116      	bne.n	c0d02f88 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02f5a:	2001      	movs	r0, #1
c0d02f5c:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02f5e:	2041      	movs	r0, #65	; 0x41
c0d02f60:	0080      	lsls	r0, r0, #2
c0d02f62:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02f64:	4625      	mov	r5, r4
c0d02f66:	350c      	adds	r5, #12
c0d02f68:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02f6a:	2900      	cmp	r1, #0
c0d02f6c:	d005      	beq.n	c0d02f7a <USBD_GetStatus+0x32>
c0d02f6e:	4620      	mov	r0, r4
c0d02f70:	f000 fa77 	bl	c0d03462 <USBD_CtlReceiveStatus>
c0d02f74:	68e1      	ldr	r1, [r4, #12]
c0d02f76:	2002      	movs	r0, #2
c0d02f78:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02f7a:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02f7c:	2202      	movs	r2, #2
c0d02f7e:	4620      	mov	r0, r4
c0d02f80:	4629      	mov	r1, r5
c0d02f82:	f000 fa33 	bl	c0d033ec <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02f86:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f88:	2180      	movs	r1, #128	; 0x80
c0d02f8a:	4620      	mov	r0, r4
c0d02f8c:	f7ff fc72 	bl	c0d02874 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02f90:	2100      	movs	r1, #0
c0d02f92:	4620      	mov	r0, r4
c0d02f94:	f7ff fc6e 	bl	c0d02874 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02f98:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f9a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02f9a:	b5b0      	push	{r4, r5, r7, lr}
c0d02f9c:	af02      	add	r7, sp, #8
c0d02f9e:	460d      	mov	r5, r1
c0d02fa0:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02fa2:	8868      	ldrh	r0, [r5, #2]
c0d02fa4:	2801      	cmp	r0, #1
c0d02fa6:	d110      	bne.n	c0d02fca <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02fa8:	2041      	movs	r0, #65	; 0x41
c0d02faa:	0080      	lsls	r0, r0, #2
c0d02fac:	2101      	movs	r1, #1
c0d02fae:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02fb0:	2045      	movs	r0, #69	; 0x45
c0d02fb2:	0080      	lsls	r0, r0, #2
c0d02fb4:	5820      	ldr	r0, [r4, r0]
c0d02fb6:	6880      	ldr	r0, [r0, #8]
c0d02fb8:	f7ff f846 	bl	c0d02048 <pic>
c0d02fbc:	4602      	mov	r2, r0
c0d02fbe:	4620      	mov	r0, r4
c0d02fc0:	4629      	mov	r1, r5
c0d02fc2:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02fc4:	4620      	mov	r0, r4
c0d02fc6:	f000 fa3f 	bl	c0d03448 <USBD_CtlSendStatus>
  }

}
c0d02fca:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fcc <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02fcc:	b5b0      	push	{r4, r5, r7, lr}
c0d02fce:	af02      	add	r7, sp, #8
c0d02fd0:	460d      	mov	r5, r1
c0d02fd2:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02fd4:	20fc      	movs	r0, #252	; 0xfc
c0d02fd6:	5c20      	ldrb	r0, [r4, r0]
c0d02fd8:	21fe      	movs	r1, #254	; 0xfe
c0d02fda:	4001      	ands	r1, r0
c0d02fdc:	2902      	cmp	r1, #2
c0d02fde:	d114      	bne.n	c0d0300a <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02fe0:	8868      	ldrh	r0, [r5, #2]
c0d02fe2:	2801      	cmp	r0, #1
c0d02fe4:	d119      	bne.n	c0d0301a <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02fe6:	2041      	movs	r0, #65	; 0x41
c0d02fe8:	0080      	lsls	r0, r0, #2
c0d02fea:	2100      	movs	r1, #0
c0d02fec:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02fee:	2045      	movs	r0, #69	; 0x45
c0d02ff0:	0080      	lsls	r0, r0, #2
c0d02ff2:	5820      	ldr	r0, [r4, r0]
c0d02ff4:	6880      	ldr	r0, [r0, #8]
c0d02ff6:	f7ff f827 	bl	c0d02048 <pic>
c0d02ffa:	4602      	mov	r2, r0
c0d02ffc:	4620      	mov	r0, r4
c0d02ffe:	4629      	mov	r1, r5
c0d03000:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d03002:	4620      	mov	r0, r4
c0d03004:	f000 fa20 	bl	c0d03448 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d03008:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0300a:	2180      	movs	r1, #128	; 0x80
c0d0300c:	4620      	mov	r0, r4
c0d0300e:	f7ff fc31 	bl	c0d02874 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03012:	2100      	movs	r1, #0
c0d03014:	4620      	mov	r0, r4
c0d03016:	f7ff fc2d 	bl	c0d02874 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d0301a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0301c <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d0301c:	b5d0      	push	{r4, r6, r7, lr}
c0d0301e:	af02      	add	r7, sp, #8
c0d03020:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d03022:	2180      	movs	r1, #128	; 0x80
c0d03024:	f7ff fc26 	bl	c0d02874 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d03028:	2100      	movs	r1, #0
c0d0302a:	4620      	mov	r0, r4
c0d0302c:	f7ff fc22 	bl	c0d02874 <USBD_LL_StallEP>
}
c0d03030:	bdd0      	pop	{r4, r6, r7, pc}

c0d03032 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03032:	b5b0      	push	{r4, r5, r7, lr}
c0d03034:	af02      	add	r7, sp, #8
c0d03036:	460d      	mov	r5, r1
c0d03038:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0303a:	20fc      	movs	r0, #252	; 0xfc
c0d0303c:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0303e:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d03040:	2803      	cmp	r0, #3
c0d03042:	d115      	bne.n	c0d03070 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d03044:	88a8      	ldrh	r0, [r5, #4]
c0d03046:	22fe      	movs	r2, #254	; 0xfe
c0d03048:	4002      	ands	r2, r0
c0d0304a:	2a01      	cmp	r2, #1
c0d0304c:	d810      	bhi.n	c0d03070 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d0304e:	2045      	movs	r0, #69	; 0x45
c0d03050:	0080      	lsls	r0, r0, #2
c0d03052:	5820      	ldr	r0, [r4, r0]
c0d03054:	6880      	ldr	r0, [r0, #8]
c0d03056:	f7fe fff7 	bl	c0d02048 <pic>
c0d0305a:	4602      	mov	r2, r0
c0d0305c:	4620      	mov	r0, r4
c0d0305e:	4629      	mov	r1, r5
c0d03060:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d03062:	88e8      	ldrh	r0, [r5, #6]
c0d03064:	2800      	cmp	r0, #0
c0d03066:	d10a      	bne.n	c0d0307e <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d03068:	4620      	mov	r0, r4
c0d0306a:	f000 f9ed 	bl	c0d03448 <USBD_CtlSendStatus>
c0d0306e:	e006      	b.n	c0d0307e <USBD_StdItfReq+0x4c>
c0d03070:	4620      	mov	r0, r4
c0d03072:	f7ff fbff 	bl	c0d02874 <USBD_LL_StallEP>
c0d03076:	2100      	movs	r1, #0
c0d03078:	4620      	mov	r0, r4
c0d0307a:	f7ff fbfb 	bl	c0d02874 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0307e:	2000      	movs	r0, #0
c0d03080:	bdb0      	pop	{r4, r5, r7, pc}

c0d03082 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03082:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03084:	af03      	add	r7, sp, #12
c0d03086:	b081      	sub	sp, #4
c0d03088:	460e      	mov	r6, r1
c0d0308a:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d0308c:	7830      	ldrb	r0, [r6, #0]
c0d0308e:	2160      	movs	r1, #96	; 0x60
c0d03090:	4001      	ands	r1, r0
c0d03092:	2920      	cmp	r1, #32
c0d03094:	d10a      	bne.n	c0d030ac <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d03096:	2045      	movs	r0, #69	; 0x45
c0d03098:	0080      	lsls	r0, r0, #2
c0d0309a:	5820      	ldr	r0, [r4, r0]
c0d0309c:	6880      	ldr	r0, [r0, #8]
c0d0309e:	f7fe ffd3 	bl	c0d02048 <pic>
c0d030a2:	4602      	mov	r2, r0
c0d030a4:	4620      	mov	r0, r4
c0d030a6:	4631      	mov	r1, r6
c0d030a8:	4790      	blx	r2
c0d030aa:	e063      	b.n	c0d03174 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d030ac:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d030ae:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d030b0:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d030b2:	2800      	cmp	r0, #0
c0d030b4:	d012      	beq.n	c0d030dc <USBD_StdEPReq+0x5a>
c0d030b6:	2801      	cmp	r0, #1
c0d030b8:	d019      	beq.n	c0d030ee <USBD_StdEPReq+0x6c>
c0d030ba:	2803      	cmp	r0, #3
c0d030bc:	d15a      	bne.n	c0d03174 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d030be:	20fc      	movs	r0, #252	; 0xfc
c0d030c0:	5c20      	ldrb	r0, [r4, r0]
c0d030c2:	2803      	cmp	r0, #3
c0d030c4:	d117      	bne.n	c0d030f6 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d030c6:	8870      	ldrh	r0, [r6, #2]
c0d030c8:	2800      	cmp	r0, #0
c0d030ca:	d12d      	bne.n	c0d03128 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d030cc:	4329      	orrs	r1, r5
c0d030ce:	2980      	cmp	r1, #128	; 0x80
c0d030d0:	d02a      	beq.n	c0d03128 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d030d2:	4620      	mov	r0, r4
c0d030d4:	4629      	mov	r1, r5
c0d030d6:	f7ff fbcd 	bl	c0d02874 <USBD_LL_StallEP>
c0d030da:	e025      	b.n	c0d03128 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d030dc:	20fc      	movs	r0, #252	; 0xfc
c0d030de:	5c20      	ldrb	r0, [r4, r0]
c0d030e0:	2803      	cmp	r0, #3
c0d030e2:	d02f      	beq.n	c0d03144 <USBD_StdEPReq+0xc2>
c0d030e4:	2802      	cmp	r0, #2
c0d030e6:	d10e      	bne.n	c0d03106 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d030e8:	0668      	lsls	r0, r5, #25
c0d030ea:	d109      	bne.n	c0d03100 <USBD_StdEPReq+0x7e>
c0d030ec:	e042      	b.n	c0d03174 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d030ee:	20fc      	movs	r0, #252	; 0xfc
c0d030f0:	5c20      	ldrb	r0, [r4, r0]
c0d030f2:	2803      	cmp	r0, #3
c0d030f4:	d00f      	beq.n	c0d03116 <USBD_StdEPReq+0x94>
c0d030f6:	2802      	cmp	r0, #2
c0d030f8:	d105      	bne.n	c0d03106 <USBD_StdEPReq+0x84>
c0d030fa:	4329      	orrs	r1, r5
c0d030fc:	2980      	cmp	r1, #128	; 0x80
c0d030fe:	d039      	beq.n	c0d03174 <USBD_StdEPReq+0xf2>
c0d03100:	4620      	mov	r0, r4
c0d03102:	4629      	mov	r1, r5
c0d03104:	e004      	b.n	c0d03110 <USBD_StdEPReq+0x8e>
c0d03106:	4620      	mov	r0, r4
c0d03108:	f7ff fbb4 	bl	c0d02874 <USBD_LL_StallEP>
c0d0310c:	2100      	movs	r1, #0
c0d0310e:	4620      	mov	r0, r4
c0d03110:	f7ff fbb0 	bl	c0d02874 <USBD_LL_StallEP>
c0d03114:	e02e      	b.n	c0d03174 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03116:	8870      	ldrh	r0, [r6, #2]
c0d03118:	2800      	cmp	r0, #0
c0d0311a:	d12b      	bne.n	c0d03174 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d0311c:	0668      	lsls	r0, r5, #25
c0d0311e:	d00d      	beq.n	c0d0313c <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d03120:	4620      	mov	r0, r4
c0d03122:	4629      	mov	r1, r5
c0d03124:	f7ff fbcc 	bl	c0d028c0 <USBD_LL_ClearStallEP>
c0d03128:	2045      	movs	r0, #69	; 0x45
c0d0312a:	0080      	lsls	r0, r0, #2
c0d0312c:	5820      	ldr	r0, [r4, r0]
c0d0312e:	6880      	ldr	r0, [r0, #8]
c0d03130:	f7fe ff8a 	bl	c0d02048 <pic>
c0d03134:	4602      	mov	r2, r0
c0d03136:	4620      	mov	r0, r4
c0d03138:	4631      	mov	r1, r6
c0d0313a:	4790      	blx	r2
c0d0313c:	4620      	mov	r0, r4
c0d0313e:	f000 f983 	bl	c0d03448 <USBD_CtlSendStatus>
c0d03142:	e017      	b.n	c0d03174 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03144:	4626      	mov	r6, r4
c0d03146:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d03148:	4620      	mov	r0, r4
c0d0314a:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d0314c:	420d      	tst	r5, r1
c0d0314e:	d100      	bne.n	c0d03152 <USBD_StdEPReq+0xd0>
c0d03150:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03152:	4620      	mov	r0, r4
c0d03154:	4629      	mov	r1, r5
c0d03156:	f7ff fbd9 	bl	c0d0290c <USBD_LL_IsStallEP>
c0d0315a:	2101      	movs	r1, #1
c0d0315c:	2800      	cmp	r0, #0
c0d0315e:	d100      	bne.n	c0d03162 <USBD_StdEPReq+0xe0>
c0d03160:	4601      	mov	r1, r0
c0d03162:	207f      	movs	r0, #127	; 0x7f
c0d03164:	4005      	ands	r5, r0
c0d03166:	0128      	lsls	r0, r5, #4
c0d03168:	5031      	str	r1, [r6, r0]
c0d0316a:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d0316c:	2202      	movs	r2, #2
c0d0316e:	4620      	mov	r0, r4
c0d03170:	f000 f93c 	bl	c0d033ec <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d03174:	2000      	movs	r0, #0
c0d03176:	b001      	add	sp, #4
c0d03178:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0317a <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d0317a:	780a      	ldrb	r2, [r1, #0]
c0d0317c:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d0317e:	784a      	ldrb	r2, [r1, #1]
c0d03180:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03182:	788a      	ldrb	r2, [r1, #2]
c0d03184:	78cb      	ldrb	r3, [r1, #3]
c0d03186:	021b      	lsls	r3, r3, #8
c0d03188:	4313      	orrs	r3, r2
c0d0318a:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d0318c:	790a      	ldrb	r2, [r1, #4]
c0d0318e:	794b      	ldrb	r3, [r1, #5]
c0d03190:	021b      	lsls	r3, r3, #8
c0d03192:	4313      	orrs	r3, r2
c0d03194:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d03196:	798a      	ldrb	r2, [r1, #6]
c0d03198:	79c9      	ldrb	r1, [r1, #7]
c0d0319a:	0209      	lsls	r1, r1, #8
c0d0319c:	4311      	orrs	r1, r2
c0d0319e:	80c1      	strh	r1, [r0, #6]

}
c0d031a0:	4770      	bx	lr

c0d031a2 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d031a2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031a4:	af03      	add	r7, sp, #12
c0d031a6:	b083      	sub	sp, #12
c0d031a8:	460d      	mov	r5, r1
c0d031aa:	4604      	mov	r4, r0
c0d031ac:	a802      	add	r0, sp, #8
c0d031ae:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d031b0:	8006      	strh	r6, [r0, #0]
c0d031b2:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d031b4:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d031b6:	7829      	ldrb	r1, [r5, #0]
c0d031b8:	2060      	movs	r0, #96	; 0x60
c0d031ba:	4008      	ands	r0, r1
c0d031bc:	2800      	cmp	r0, #0
c0d031be:	d010      	beq.n	c0d031e2 <USBD_HID_Setup+0x40>
c0d031c0:	2820      	cmp	r0, #32
c0d031c2:	d139      	bne.n	c0d03238 <USBD_HID_Setup+0x96>
c0d031c4:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d031c6:	4601      	mov	r1, r0
c0d031c8:	390a      	subs	r1, #10
c0d031ca:	2902      	cmp	r1, #2
c0d031cc:	d334      	bcc.n	c0d03238 <USBD_HID_Setup+0x96>
c0d031ce:	2802      	cmp	r0, #2
c0d031d0:	d01c      	beq.n	c0d0320c <USBD_HID_Setup+0x6a>
c0d031d2:	2803      	cmp	r0, #3
c0d031d4:	d01a      	beq.n	c0d0320c <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d031d6:	4620      	mov	r0, r4
c0d031d8:	4629      	mov	r1, r5
c0d031da:	f7ff ff1f 	bl	c0d0301c <USBD_CtlError>
c0d031de:	2602      	movs	r6, #2
c0d031e0:	e02a      	b.n	c0d03238 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d031e2:	7868      	ldrb	r0, [r5, #1]
c0d031e4:	280b      	cmp	r0, #11
c0d031e6:	d014      	beq.n	c0d03212 <USBD_HID_Setup+0x70>
c0d031e8:	280a      	cmp	r0, #10
c0d031ea:	d00f      	beq.n	c0d0320c <USBD_HID_Setup+0x6a>
c0d031ec:	2806      	cmp	r0, #6
c0d031ee:	d123      	bne.n	c0d03238 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d031f0:	8868      	ldrh	r0, [r5, #2]
c0d031f2:	0a00      	lsrs	r0, r0, #8
c0d031f4:	2600      	movs	r6, #0
c0d031f6:	2821      	cmp	r0, #33	; 0x21
c0d031f8:	d00f      	beq.n	c0d0321a <USBD_HID_Setup+0x78>
c0d031fa:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d031fc:	4632      	mov	r2, r6
c0d031fe:	4631      	mov	r1, r6
c0d03200:	d117      	bne.n	c0d03232 <USBD_HID_Setup+0x90>
c0d03202:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d03204:	9000      	str	r0, [sp, #0]
c0d03206:	f000 f847 	bl	c0d03298 <USBD_HID_GetReportDescriptor_impl>
c0d0320a:	e00a      	b.n	c0d03222 <USBD_HID_Setup+0x80>
c0d0320c:	a901      	add	r1, sp, #4
c0d0320e:	2201      	movs	r2, #1
c0d03210:	e00f      	b.n	c0d03232 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d03212:	4620      	mov	r0, r4
c0d03214:	f000 f918 	bl	c0d03448 <USBD_CtlSendStatus>
c0d03218:	e00e      	b.n	c0d03238 <USBD_HID_Setup+0x96>
c0d0321a:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d0321c:	9000      	str	r0, [sp, #0]
c0d0321e:	f000 f833 	bl	c0d03288 <USBD_HID_GetHidDescriptor_impl>
c0d03222:	9b00      	ldr	r3, [sp, #0]
c0d03224:	4601      	mov	r1, r0
c0d03226:	881a      	ldrh	r2, [r3, #0]
c0d03228:	88e8      	ldrh	r0, [r5, #6]
c0d0322a:	4282      	cmp	r2, r0
c0d0322c:	d300      	bcc.n	c0d03230 <USBD_HID_Setup+0x8e>
c0d0322e:	4602      	mov	r2, r0
c0d03230:	801a      	strh	r2, [r3, #0]
c0d03232:	4620      	mov	r0, r4
c0d03234:	f000 f8da 	bl	c0d033ec <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d03238:	b2f0      	uxtb	r0, r6
c0d0323a:	b003      	add	sp, #12
c0d0323c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0323e <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0323e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03240:	af03      	add	r7, sp, #12
c0d03242:	b081      	sub	sp, #4
c0d03244:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03246:	2182      	movs	r1, #130	; 0x82
c0d03248:	2502      	movs	r5, #2
c0d0324a:	2640      	movs	r6, #64	; 0x40
c0d0324c:	462a      	mov	r2, r5
c0d0324e:	4633      	mov	r3, r6
c0d03250:	f7ff fad0 	bl	c0d027f4 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03254:	4620      	mov	r0, r4
c0d03256:	4629      	mov	r1, r5
c0d03258:	462a      	mov	r2, r5
c0d0325a:	4633      	mov	r3, r6
c0d0325c:	f7ff faca 	bl	c0d027f4 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03260:	4620      	mov	r0, r4
c0d03262:	4629      	mov	r1, r5
c0d03264:	4632      	mov	r2, r6
c0d03266:	f7ff fb90 	bl	c0d0298a <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d0326a:	2000      	movs	r0, #0
c0d0326c:	b001      	add	sp, #4
c0d0326e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03270 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03270:	b5d0      	push	{r4, r6, r7, lr}
c0d03272:	af02      	add	r7, sp, #8
c0d03274:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d03276:	2182      	movs	r1, #130	; 0x82
c0d03278:	f7ff fae4 	bl	c0d02844 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d0327c:	2102      	movs	r1, #2
c0d0327e:	4620      	mov	r0, r4
c0d03280:	f7ff fae0 	bl	c0d02844 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03284:	2000      	movs	r0, #0
c0d03286:	bdd0      	pop	{r4, r6, r7, pc}

c0d03288 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d03288:	2109      	movs	r1, #9
c0d0328a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d0328c:	4801      	ldr	r0, [pc, #4]	; (c0d03294 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d0328e:	4478      	add	r0, pc
c0d03290:	4770      	bx	lr
c0d03292:	46c0      	nop			; (mov r8, r8)
c0d03294:	00000cc6 	.word	0x00000cc6

c0d03298 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d03298:	2122      	movs	r1, #34	; 0x22
c0d0329a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d0329c:	4801      	ldr	r0, [pc, #4]	; (c0d032a4 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d0329e:	4478      	add	r0, pc
c0d032a0:	4770      	bx	lr
c0d032a2:	46c0      	nop			; (mov r8, r8)
c0d032a4:	00000c91 	.word	0x00000c91

c0d032a8 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d032a8:	b5b0      	push	{r4, r5, r7, lr}
c0d032aa:	af02      	add	r7, sp, #8
c0d032ac:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d032ae:	2102      	movs	r1, #2
c0d032b0:	2240      	movs	r2, #64	; 0x40
c0d032b2:	f7ff fb6a 	bl	c0d0298a <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d032b6:	4d0d      	ldr	r5, [pc, #52]	; (c0d032ec <USBD_HID_DataOut_impl+0x44>)
c0d032b8:	7828      	ldrb	r0, [r5, #0]
c0d032ba:	2800      	cmp	r0, #0
c0d032bc:	d113      	bne.n	c0d032e6 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d032be:	2002      	movs	r0, #2
c0d032c0:	f7fe f928 	bl	c0d01514 <io_seproxyhal_get_ep_rx_size>
c0d032c4:	4602      	mov	r2, r0
c0d032c6:	480d      	ldr	r0, [pc, #52]	; (c0d032fc <USBD_HID_DataOut_impl+0x54>)
c0d032c8:	4478      	add	r0, pc
c0d032ca:	4621      	mov	r1, r4
c0d032cc:	f7fd ff86 	bl	c0d011dc <io_usb_hid_receive>
c0d032d0:	2802      	cmp	r0, #2
c0d032d2:	d108      	bne.n	c0d032e6 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d032d4:	2001      	movs	r0, #1
c0d032d6:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d032d8:	4805      	ldr	r0, [pc, #20]	; (c0d032f0 <USBD_HID_DataOut_impl+0x48>)
c0d032da:	2107      	movs	r1, #7
c0d032dc:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d032de:	4805      	ldr	r0, [pc, #20]	; (c0d032f4 <USBD_HID_DataOut_impl+0x4c>)
c0d032e0:	6800      	ldr	r0, [r0, #0]
c0d032e2:	4905      	ldr	r1, [pc, #20]	; (c0d032f8 <USBD_HID_DataOut_impl+0x50>)
c0d032e4:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d032e6:	2000      	movs	r0, #0
c0d032e8:	bdb0      	pop	{r4, r5, r7, pc}
c0d032ea:	46c0      	nop			; (mov r8, r8)
c0d032ec:	20001d10 	.word	0x20001d10
c0d032f0:	20001d18 	.word	0x20001d18
c0d032f4:	20001c00 	.word	0x20001c00
c0d032f8:	20001d1c 	.word	0x20001d1c
c0d032fc:	ffffe3a1 	.word	0xffffe3a1

c0d03300 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d03300:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03302:	af03      	add	r7, sp, #12
c0d03304:	b081      	sub	sp, #4
c0d03306:	4604      	mov	r4, r0
c0d03308:	2049      	movs	r0, #73	; 0x49
c0d0330a:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0330c:	4810      	ldr	r0, [pc, #64]	; (c0d03350 <USB_power+0x50>)
c0d0330e:	2100      	movs	r1, #0
c0d03310:	462a      	mov	r2, r5
c0d03312:	f7fe f80f 	bl	c0d01334 <os_memset>

  if (enabled) {
c0d03316:	2c00      	cmp	r4, #0
c0d03318:	d015      	beq.n	c0d03346 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0331a:	4c0d      	ldr	r4, [pc, #52]	; (c0d03350 <USB_power+0x50>)
c0d0331c:	2600      	movs	r6, #0
c0d0331e:	4620      	mov	r0, r4
c0d03320:	4631      	mov	r1, r6
c0d03322:	462a      	mov	r2, r5
c0d03324:	f7fe f806 	bl	c0d01334 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03328:	490a      	ldr	r1, [pc, #40]	; (c0d03354 <USB_power+0x54>)
c0d0332a:	4479      	add	r1, pc
c0d0332c:	4620      	mov	r0, r4
c0d0332e:	4632      	mov	r2, r6
c0d03330:	f7ff fb3f 	bl	c0d029b2 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03334:	4908      	ldr	r1, [pc, #32]	; (c0d03358 <USB_power+0x58>)
c0d03336:	4479      	add	r1, pc
c0d03338:	4620      	mov	r0, r4
c0d0333a:	f7ff fb72 	bl	c0d02a22 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d0333e:	4620      	mov	r0, r4
c0d03340:	f7ff fb78 	bl	c0d02a34 <USBD_Start>
c0d03344:	e002      	b.n	c0d0334c <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d03346:	4802      	ldr	r0, [pc, #8]	; (c0d03350 <USB_power+0x50>)
c0d03348:	f7ff fb51 	bl	c0d029ee <USBD_DeInit>
  }
}
c0d0334c:	b001      	add	sp, #4
c0d0334e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03350:	20001d34 	.word	0x20001d34
c0d03354:	00000c46 	.word	0x00000c46
c0d03358:	00000c76 	.word	0x00000c76

c0d0335c <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d0335c:	2012      	movs	r0, #18
c0d0335e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03360:	4801      	ldr	r0, [pc, #4]	; (c0d03368 <USBD_DeviceDescriptor+0xc>)
c0d03362:	4478      	add	r0, pc
c0d03364:	4770      	bx	lr
c0d03366:	46c0      	nop			; (mov r8, r8)
c0d03368:	00000bfb 	.word	0x00000bfb

c0d0336c <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d0336c:	2004      	movs	r0, #4
c0d0336e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03370:	4801      	ldr	r0, [pc, #4]	; (c0d03378 <USBD_LangIDStrDescriptor+0xc>)
c0d03372:	4478      	add	r0, pc
c0d03374:	4770      	bx	lr
c0d03376:	46c0      	nop			; (mov r8, r8)
c0d03378:	00000c1e 	.word	0x00000c1e

c0d0337c <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d0337c:	200e      	movs	r0, #14
c0d0337e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03380:	4801      	ldr	r0, [pc, #4]	; (c0d03388 <USBD_ManufacturerStrDescriptor+0xc>)
c0d03382:	4478      	add	r0, pc
c0d03384:	4770      	bx	lr
c0d03386:	46c0      	nop			; (mov r8, r8)
c0d03388:	00000c12 	.word	0x00000c12

c0d0338c <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d0338c:	200e      	movs	r0, #14
c0d0338e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03390:	4801      	ldr	r0, [pc, #4]	; (c0d03398 <USBD_ProductStrDescriptor+0xc>)
c0d03392:	4478      	add	r0, pc
c0d03394:	4770      	bx	lr
c0d03396:	46c0      	nop			; (mov r8, r8)
c0d03398:	00000b8f 	.word	0x00000b8f

c0d0339c <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d0339c:	200a      	movs	r0, #10
c0d0339e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d033a0:	4801      	ldr	r0, [pc, #4]	; (c0d033a8 <USBD_SerialStrDescriptor+0xc>)
c0d033a2:	4478      	add	r0, pc
c0d033a4:	4770      	bx	lr
c0d033a6:	46c0      	nop			; (mov r8, r8)
c0d033a8:	00000c00 	.word	0x00000c00

c0d033ac <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d033ac:	200e      	movs	r0, #14
c0d033ae:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d033b0:	4801      	ldr	r0, [pc, #4]	; (c0d033b8 <USBD_ConfigStrDescriptor+0xc>)
c0d033b2:	4478      	add	r0, pc
c0d033b4:	4770      	bx	lr
c0d033b6:	46c0      	nop			; (mov r8, r8)
c0d033b8:	00000b6f 	.word	0x00000b6f

c0d033bc <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d033bc:	200e      	movs	r0, #14
c0d033be:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d033c0:	4801      	ldr	r0, [pc, #4]	; (c0d033c8 <USBD_InterfaceStrDescriptor+0xc>)
c0d033c2:	4478      	add	r0, pc
c0d033c4:	4770      	bx	lr
c0d033c6:	46c0      	nop			; (mov r8, r8)
c0d033c8:	00000b5f 	.word	0x00000b5f

c0d033cc <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d033cc:	2129      	movs	r1, #41	; 0x29
c0d033ce:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d033d0:	4801      	ldr	r0, [pc, #4]	; (c0d033d8 <USBD_GetCfgDesc_impl+0xc>)
c0d033d2:	4478      	add	r0, pc
c0d033d4:	4770      	bx	lr
c0d033d6:	46c0      	nop			; (mov r8, r8)
c0d033d8:	00000c12 	.word	0x00000c12

c0d033dc <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d033dc:	210a      	movs	r1, #10
c0d033de:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d033e0:	4801      	ldr	r0, [pc, #4]	; (c0d033e8 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d033e2:	4478      	add	r0, pc
c0d033e4:	4770      	bx	lr
c0d033e6:	46c0      	nop			; (mov r8, r8)
c0d033e8:	00000c2e 	.word	0x00000c2e

c0d033ec <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d033ec:	b5b0      	push	{r4, r5, r7, lr}
c0d033ee:	af02      	add	r7, sp, #8
c0d033f0:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d033f2:	21f4      	movs	r1, #244	; 0xf4
c0d033f4:	2302      	movs	r3, #2
c0d033f6:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d033f8:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d033fa:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d033fc:	2109      	movs	r1, #9
c0d033fe:	0149      	lsls	r1, r1, #5
c0d03400:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03402:	6a01      	ldr	r1, [r0, #32]
c0d03404:	428a      	cmp	r2, r1
c0d03406:	d300      	bcc.n	c0d0340a <USBD_CtlSendData+0x1e>
c0d03408:	460a      	mov	r2, r1
c0d0340a:	b293      	uxth	r3, r2
c0d0340c:	2500      	movs	r5, #0
c0d0340e:	4629      	mov	r1, r5
c0d03410:	4622      	mov	r2, r4
c0d03412:	f7ff faa0 	bl	c0d02956 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03416:	4628      	mov	r0, r5
c0d03418:	bdb0      	pop	{r4, r5, r7, pc}

c0d0341a <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d0341a:	b5b0      	push	{r4, r5, r7, lr}
c0d0341c:	af02      	add	r7, sp, #8
c0d0341e:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d03420:	6a01      	ldr	r1, [r0, #32]
c0d03422:	428a      	cmp	r2, r1
c0d03424:	d300      	bcc.n	c0d03428 <USBD_CtlContinueSendData+0xe>
c0d03426:	460a      	mov	r2, r1
c0d03428:	b293      	uxth	r3, r2
c0d0342a:	2500      	movs	r5, #0
c0d0342c:	4629      	mov	r1, r5
c0d0342e:	4622      	mov	r2, r4
c0d03430:	f7ff fa91 	bl	c0d02956 <USBD_LL_Transmit>
  return USBD_OK;
c0d03434:	4628      	mov	r0, r5
c0d03436:	bdb0      	pop	{r4, r5, r7, pc}

c0d03438 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03438:	b5d0      	push	{r4, r6, r7, lr}
c0d0343a:	af02      	add	r7, sp, #8
c0d0343c:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d0343e:	4621      	mov	r1, r4
c0d03440:	f7ff faa3 	bl	c0d0298a <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03444:	4620      	mov	r0, r4
c0d03446:	bdd0      	pop	{r4, r6, r7, pc}

c0d03448 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03448:	b5d0      	push	{r4, r6, r7, lr}
c0d0344a:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d0344c:	21f4      	movs	r1, #244	; 0xf4
c0d0344e:	2204      	movs	r2, #4
c0d03450:	5042      	str	r2, [r0, r1]
c0d03452:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03454:	4621      	mov	r1, r4
c0d03456:	4622      	mov	r2, r4
c0d03458:	4623      	mov	r3, r4
c0d0345a:	f7ff fa7c 	bl	c0d02956 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d0345e:	4620      	mov	r0, r4
c0d03460:	bdd0      	pop	{r4, r6, r7, pc}

c0d03462 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03462:	b5d0      	push	{r4, r6, r7, lr}
c0d03464:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03466:	21f4      	movs	r1, #244	; 0xf4
c0d03468:	2205      	movs	r2, #5
c0d0346a:	5042      	str	r2, [r0, r1]
c0d0346c:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d0346e:	4621      	mov	r1, r4
c0d03470:	4622      	mov	r2, r4
c0d03472:	f7ff fa8a 	bl	c0d0298a <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d03476:	4620      	mov	r0, r4
c0d03478:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d0347c <__aeabi_uidiv>:
c0d0347c:	2200      	movs	r2, #0
c0d0347e:	0843      	lsrs	r3, r0, #1
c0d03480:	428b      	cmp	r3, r1
c0d03482:	d374      	bcc.n	c0d0356e <__aeabi_uidiv+0xf2>
c0d03484:	0903      	lsrs	r3, r0, #4
c0d03486:	428b      	cmp	r3, r1
c0d03488:	d35f      	bcc.n	c0d0354a <__aeabi_uidiv+0xce>
c0d0348a:	0a03      	lsrs	r3, r0, #8
c0d0348c:	428b      	cmp	r3, r1
c0d0348e:	d344      	bcc.n	c0d0351a <__aeabi_uidiv+0x9e>
c0d03490:	0b03      	lsrs	r3, r0, #12
c0d03492:	428b      	cmp	r3, r1
c0d03494:	d328      	bcc.n	c0d034e8 <__aeabi_uidiv+0x6c>
c0d03496:	0c03      	lsrs	r3, r0, #16
c0d03498:	428b      	cmp	r3, r1
c0d0349a:	d30d      	bcc.n	c0d034b8 <__aeabi_uidiv+0x3c>
c0d0349c:	22ff      	movs	r2, #255	; 0xff
c0d0349e:	0209      	lsls	r1, r1, #8
c0d034a0:	ba12      	rev	r2, r2
c0d034a2:	0c03      	lsrs	r3, r0, #16
c0d034a4:	428b      	cmp	r3, r1
c0d034a6:	d302      	bcc.n	c0d034ae <__aeabi_uidiv+0x32>
c0d034a8:	1212      	asrs	r2, r2, #8
c0d034aa:	0209      	lsls	r1, r1, #8
c0d034ac:	d065      	beq.n	c0d0357a <__aeabi_uidiv+0xfe>
c0d034ae:	0b03      	lsrs	r3, r0, #12
c0d034b0:	428b      	cmp	r3, r1
c0d034b2:	d319      	bcc.n	c0d034e8 <__aeabi_uidiv+0x6c>
c0d034b4:	e000      	b.n	c0d034b8 <__aeabi_uidiv+0x3c>
c0d034b6:	0a09      	lsrs	r1, r1, #8
c0d034b8:	0bc3      	lsrs	r3, r0, #15
c0d034ba:	428b      	cmp	r3, r1
c0d034bc:	d301      	bcc.n	c0d034c2 <__aeabi_uidiv+0x46>
c0d034be:	03cb      	lsls	r3, r1, #15
c0d034c0:	1ac0      	subs	r0, r0, r3
c0d034c2:	4152      	adcs	r2, r2
c0d034c4:	0b83      	lsrs	r3, r0, #14
c0d034c6:	428b      	cmp	r3, r1
c0d034c8:	d301      	bcc.n	c0d034ce <__aeabi_uidiv+0x52>
c0d034ca:	038b      	lsls	r3, r1, #14
c0d034cc:	1ac0      	subs	r0, r0, r3
c0d034ce:	4152      	adcs	r2, r2
c0d034d0:	0b43      	lsrs	r3, r0, #13
c0d034d2:	428b      	cmp	r3, r1
c0d034d4:	d301      	bcc.n	c0d034da <__aeabi_uidiv+0x5e>
c0d034d6:	034b      	lsls	r3, r1, #13
c0d034d8:	1ac0      	subs	r0, r0, r3
c0d034da:	4152      	adcs	r2, r2
c0d034dc:	0b03      	lsrs	r3, r0, #12
c0d034de:	428b      	cmp	r3, r1
c0d034e0:	d301      	bcc.n	c0d034e6 <__aeabi_uidiv+0x6a>
c0d034e2:	030b      	lsls	r3, r1, #12
c0d034e4:	1ac0      	subs	r0, r0, r3
c0d034e6:	4152      	adcs	r2, r2
c0d034e8:	0ac3      	lsrs	r3, r0, #11
c0d034ea:	428b      	cmp	r3, r1
c0d034ec:	d301      	bcc.n	c0d034f2 <__aeabi_uidiv+0x76>
c0d034ee:	02cb      	lsls	r3, r1, #11
c0d034f0:	1ac0      	subs	r0, r0, r3
c0d034f2:	4152      	adcs	r2, r2
c0d034f4:	0a83      	lsrs	r3, r0, #10
c0d034f6:	428b      	cmp	r3, r1
c0d034f8:	d301      	bcc.n	c0d034fe <__aeabi_uidiv+0x82>
c0d034fa:	028b      	lsls	r3, r1, #10
c0d034fc:	1ac0      	subs	r0, r0, r3
c0d034fe:	4152      	adcs	r2, r2
c0d03500:	0a43      	lsrs	r3, r0, #9
c0d03502:	428b      	cmp	r3, r1
c0d03504:	d301      	bcc.n	c0d0350a <__aeabi_uidiv+0x8e>
c0d03506:	024b      	lsls	r3, r1, #9
c0d03508:	1ac0      	subs	r0, r0, r3
c0d0350a:	4152      	adcs	r2, r2
c0d0350c:	0a03      	lsrs	r3, r0, #8
c0d0350e:	428b      	cmp	r3, r1
c0d03510:	d301      	bcc.n	c0d03516 <__aeabi_uidiv+0x9a>
c0d03512:	020b      	lsls	r3, r1, #8
c0d03514:	1ac0      	subs	r0, r0, r3
c0d03516:	4152      	adcs	r2, r2
c0d03518:	d2cd      	bcs.n	c0d034b6 <__aeabi_uidiv+0x3a>
c0d0351a:	09c3      	lsrs	r3, r0, #7
c0d0351c:	428b      	cmp	r3, r1
c0d0351e:	d301      	bcc.n	c0d03524 <__aeabi_uidiv+0xa8>
c0d03520:	01cb      	lsls	r3, r1, #7
c0d03522:	1ac0      	subs	r0, r0, r3
c0d03524:	4152      	adcs	r2, r2
c0d03526:	0983      	lsrs	r3, r0, #6
c0d03528:	428b      	cmp	r3, r1
c0d0352a:	d301      	bcc.n	c0d03530 <__aeabi_uidiv+0xb4>
c0d0352c:	018b      	lsls	r3, r1, #6
c0d0352e:	1ac0      	subs	r0, r0, r3
c0d03530:	4152      	adcs	r2, r2
c0d03532:	0943      	lsrs	r3, r0, #5
c0d03534:	428b      	cmp	r3, r1
c0d03536:	d301      	bcc.n	c0d0353c <__aeabi_uidiv+0xc0>
c0d03538:	014b      	lsls	r3, r1, #5
c0d0353a:	1ac0      	subs	r0, r0, r3
c0d0353c:	4152      	adcs	r2, r2
c0d0353e:	0903      	lsrs	r3, r0, #4
c0d03540:	428b      	cmp	r3, r1
c0d03542:	d301      	bcc.n	c0d03548 <__aeabi_uidiv+0xcc>
c0d03544:	010b      	lsls	r3, r1, #4
c0d03546:	1ac0      	subs	r0, r0, r3
c0d03548:	4152      	adcs	r2, r2
c0d0354a:	08c3      	lsrs	r3, r0, #3
c0d0354c:	428b      	cmp	r3, r1
c0d0354e:	d301      	bcc.n	c0d03554 <__aeabi_uidiv+0xd8>
c0d03550:	00cb      	lsls	r3, r1, #3
c0d03552:	1ac0      	subs	r0, r0, r3
c0d03554:	4152      	adcs	r2, r2
c0d03556:	0883      	lsrs	r3, r0, #2
c0d03558:	428b      	cmp	r3, r1
c0d0355a:	d301      	bcc.n	c0d03560 <__aeabi_uidiv+0xe4>
c0d0355c:	008b      	lsls	r3, r1, #2
c0d0355e:	1ac0      	subs	r0, r0, r3
c0d03560:	4152      	adcs	r2, r2
c0d03562:	0843      	lsrs	r3, r0, #1
c0d03564:	428b      	cmp	r3, r1
c0d03566:	d301      	bcc.n	c0d0356c <__aeabi_uidiv+0xf0>
c0d03568:	004b      	lsls	r3, r1, #1
c0d0356a:	1ac0      	subs	r0, r0, r3
c0d0356c:	4152      	adcs	r2, r2
c0d0356e:	1a41      	subs	r1, r0, r1
c0d03570:	d200      	bcs.n	c0d03574 <__aeabi_uidiv+0xf8>
c0d03572:	4601      	mov	r1, r0
c0d03574:	4152      	adcs	r2, r2
c0d03576:	4610      	mov	r0, r2
c0d03578:	4770      	bx	lr
c0d0357a:	e7ff      	b.n	c0d0357c <__aeabi_uidiv+0x100>
c0d0357c:	b501      	push	{r0, lr}
c0d0357e:	2000      	movs	r0, #0
c0d03580:	f000 f8f0 	bl	c0d03764 <__aeabi_idiv0>
c0d03584:	bd02      	pop	{r1, pc}
c0d03586:	46c0      	nop			; (mov r8, r8)

c0d03588 <__aeabi_uidivmod>:
c0d03588:	2900      	cmp	r1, #0
c0d0358a:	d0f7      	beq.n	c0d0357c <__aeabi_uidiv+0x100>
c0d0358c:	e776      	b.n	c0d0347c <__aeabi_uidiv>
c0d0358e:	4770      	bx	lr

c0d03590 <__aeabi_idiv>:
c0d03590:	4603      	mov	r3, r0
c0d03592:	430b      	orrs	r3, r1
c0d03594:	d47f      	bmi.n	c0d03696 <__aeabi_idiv+0x106>
c0d03596:	2200      	movs	r2, #0
c0d03598:	0843      	lsrs	r3, r0, #1
c0d0359a:	428b      	cmp	r3, r1
c0d0359c:	d374      	bcc.n	c0d03688 <__aeabi_idiv+0xf8>
c0d0359e:	0903      	lsrs	r3, r0, #4
c0d035a0:	428b      	cmp	r3, r1
c0d035a2:	d35f      	bcc.n	c0d03664 <__aeabi_idiv+0xd4>
c0d035a4:	0a03      	lsrs	r3, r0, #8
c0d035a6:	428b      	cmp	r3, r1
c0d035a8:	d344      	bcc.n	c0d03634 <__aeabi_idiv+0xa4>
c0d035aa:	0b03      	lsrs	r3, r0, #12
c0d035ac:	428b      	cmp	r3, r1
c0d035ae:	d328      	bcc.n	c0d03602 <__aeabi_idiv+0x72>
c0d035b0:	0c03      	lsrs	r3, r0, #16
c0d035b2:	428b      	cmp	r3, r1
c0d035b4:	d30d      	bcc.n	c0d035d2 <__aeabi_idiv+0x42>
c0d035b6:	22ff      	movs	r2, #255	; 0xff
c0d035b8:	0209      	lsls	r1, r1, #8
c0d035ba:	ba12      	rev	r2, r2
c0d035bc:	0c03      	lsrs	r3, r0, #16
c0d035be:	428b      	cmp	r3, r1
c0d035c0:	d302      	bcc.n	c0d035c8 <__aeabi_idiv+0x38>
c0d035c2:	1212      	asrs	r2, r2, #8
c0d035c4:	0209      	lsls	r1, r1, #8
c0d035c6:	d065      	beq.n	c0d03694 <__aeabi_idiv+0x104>
c0d035c8:	0b03      	lsrs	r3, r0, #12
c0d035ca:	428b      	cmp	r3, r1
c0d035cc:	d319      	bcc.n	c0d03602 <__aeabi_idiv+0x72>
c0d035ce:	e000      	b.n	c0d035d2 <__aeabi_idiv+0x42>
c0d035d0:	0a09      	lsrs	r1, r1, #8
c0d035d2:	0bc3      	lsrs	r3, r0, #15
c0d035d4:	428b      	cmp	r3, r1
c0d035d6:	d301      	bcc.n	c0d035dc <__aeabi_idiv+0x4c>
c0d035d8:	03cb      	lsls	r3, r1, #15
c0d035da:	1ac0      	subs	r0, r0, r3
c0d035dc:	4152      	adcs	r2, r2
c0d035de:	0b83      	lsrs	r3, r0, #14
c0d035e0:	428b      	cmp	r3, r1
c0d035e2:	d301      	bcc.n	c0d035e8 <__aeabi_idiv+0x58>
c0d035e4:	038b      	lsls	r3, r1, #14
c0d035e6:	1ac0      	subs	r0, r0, r3
c0d035e8:	4152      	adcs	r2, r2
c0d035ea:	0b43      	lsrs	r3, r0, #13
c0d035ec:	428b      	cmp	r3, r1
c0d035ee:	d301      	bcc.n	c0d035f4 <__aeabi_idiv+0x64>
c0d035f0:	034b      	lsls	r3, r1, #13
c0d035f2:	1ac0      	subs	r0, r0, r3
c0d035f4:	4152      	adcs	r2, r2
c0d035f6:	0b03      	lsrs	r3, r0, #12
c0d035f8:	428b      	cmp	r3, r1
c0d035fa:	d301      	bcc.n	c0d03600 <__aeabi_idiv+0x70>
c0d035fc:	030b      	lsls	r3, r1, #12
c0d035fe:	1ac0      	subs	r0, r0, r3
c0d03600:	4152      	adcs	r2, r2
c0d03602:	0ac3      	lsrs	r3, r0, #11
c0d03604:	428b      	cmp	r3, r1
c0d03606:	d301      	bcc.n	c0d0360c <__aeabi_idiv+0x7c>
c0d03608:	02cb      	lsls	r3, r1, #11
c0d0360a:	1ac0      	subs	r0, r0, r3
c0d0360c:	4152      	adcs	r2, r2
c0d0360e:	0a83      	lsrs	r3, r0, #10
c0d03610:	428b      	cmp	r3, r1
c0d03612:	d301      	bcc.n	c0d03618 <__aeabi_idiv+0x88>
c0d03614:	028b      	lsls	r3, r1, #10
c0d03616:	1ac0      	subs	r0, r0, r3
c0d03618:	4152      	adcs	r2, r2
c0d0361a:	0a43      	lsrs	r3, r0, #9
c0d0361c:	428b      	cmp	r3, r1
c0d0361e:	d301      	bcc.n	c0d03624 <__aeabi_idiv+0x94>
c0d03620:	024b      	lsls	r3, r1, #9
c0d03622:	1ac0      	subs	r0, r0, r3
c0d03624:	4152      	adcs	r2, r2
c0d03626:	0a03      	lsrs	r3, r0, #8
c0d03628:	428b      	cmp	r3, r1
c0d0362a:	d301      	bcc.n	c0d03630 <__aeabi_idiv+0xa0>
c0d0362c:	020b      	lsls	r3, r1, #8
c0d0362e:	1ac0      	subs	r0, r0, r3
c0d03630:	4152      	adcs	r2, r2
c0d03632:	d2cd      	bcs.n	c0d035d0 <__aeabi_idiv+0x40>
c0d03634:	09c3      	lsrs	r3, r0, #7
c0d03636:	428b      	cmp	r3, r1
c0d03638:	d301      	bcc.n	c0d0363e <__aeabi_idiv+0xae>
c0d0363a:	01cb      	lsls	r3, r1, #7
c0d0363c:	1ac0      	subs	r0, r0, r3
c0d0363e:	4152      	adcs	r2, r2
c0d03640:	0983      	lsrs	r3, r0, #6
c0d03642:	428b      	cmp	r3, r1
c0d03644:	d301      	bcc.n	c0d0364a <__aeabi_idiv+0xba>
c0d03646:	018b      	lsls	r3, r1, #6
c0d03648:	1ac0      	subs	r0, r0, r3
c0d0364a:	4152      	adcs	r2, r2
c0d0364c:	0943      	lsrs	r3, r0, #5
c0d0364e:	428b      	cmp	r3, r1
c0d03650:	d301      	bcc.n	c0d03656 <__aeabi_idiv+0xc6>
c0d03652:	014b      	lsls	r3, r1, #5
c0d03654:	1ac0      	subs	r0, r0, r3
c0d03656:	4152      	adcs	r2, r2
c0d03658:	0903      	lsrs	r3, r0, #4
c0d0365a:	428b      	cmp	r3, r1
c0d0365c:	d301      	bcc.n	c0d03662 <__aeabi_idiv+0xd2>
c0d0365e:	010b      	lsls	r3, r1, #4
c0d03660:	1ac0      	subs	r0, r0, r3
c0d03662:	4152      	adcs	r2, r2
c0d03664:	08c3      	lsrs	r3, r0, #3
c0d03666:	428b      	cmp	r3, r1
c0d03668:	d301      	bcc.n	c0d0366e <__aeabi_idiv+0xde>
c0d0366a:	00cb      	lsls	r3, r1, #3
c0d0366c:	1ac0      	subs	r0, r0, r3
c0d0366e:	4152      	adcs	r2, r2
c0d03670:	0883      	lsrs	r3, r0, #2
c0d03672:	428b      	cmp	r3, r1
c0d03674:	d301      	bcc.n	c0d0367a <__aeabi_idiv+0xea>
c0d03676:	008b      	lsls	r3, r1, #2
c0d03678:	1ac0      	subs	r0, r0, r3
c0d0367a:	4152      	adcs	r2, r2
c0d0367c:	0843      	lsrs	r3, r0, #1
c0d0367e:	428b      	cmp	r3, r1
c0d03680:	d301      	bcc.n	c0d03686 <__aeabi_idiv+0xf6>
c0d03682:	004b      	lsls	r3, r1, #1
c0d03684:	1ac0      	subs	r0, r0, r3
c0d03686:	4152      	adcs	r2, r2
c0d03688:	1a41      	subs	r1, r0, r1
c0d0368a:	d200      	bcs.n	c0d0368e <__aeabi_idiv+0xfe>
c0d0368c:	4601      	mov	r1, r0
c0d0368e:	4152      	adcs	r2, r2
c0d03690:	4610      	mov	r0, r2
c0d03692:	4770      	bx	lr
c0d03694:	e05d      	b.n	c0d03752 <__aeabi_idiv+0x1c2>
c0d03696:	0fca      	lsrs	r2, r1, #31
c0d03698:	d000      	beq.n	c0d0369c <__aeabi_idiv+0x10c>
c0d0369a:	4249      	negs	r1, r1
c0d0369c:	1003      	asrs	r3, r0, #32
c0d0369e:	d300      	bcc.n	c0d036a2 <__aeabi_idiv+0x112>
c0d036a0:	4240      	negs	r0, r0
c0d036a2:	4053      	eors	r3, r2
c0d036a4:	2200      	movs	r2, #0
c0d036a6:	469c      	mov	ip, r3
c0d036a8:	0903      	lsrs	r3, r0, #4
c0d036aa:	428b      	cmp	r3, r1
c0d036ac:	d32d      	bcc.n	c0d0370a <__aeabi_idiv+0x17a>
c0d036ae:	0a03      	lsrs	r3, r0, #8
c0d036b0:	428b      	cmp	r3, r1
c0d036b2:	d312      	bcc.n	c0d036da <__aeabi_idiv+0x14a>
c0d036b4:	22fc      	movs	r2, #252	; 0xfc
c0d036b6:	0189      	lsls	r1, r1, #6
c0d036b8:	ba12      	rev	r2, r2
c0d036ba:	0a03      	lsrs	r3, r0, #8
c0d036bc:	428b      	cmp	r3, r1
c0d036be:	d30c      	bcc.n	c0d036da <__aeabi_idiv+0x14a>
c0d036c0:	0189      	lsls	r1, r1, #6
c0d036c2:	1192      	asrs	r2, r2, #6
c0d036c4:	428b      	cmp	r3, r1
c0d036c6:	d308      	bcc.n	c0d036da <__aeabi_idiv+0x14a>
c0d036c8:	0189      	lsls	r1, r1, #6
c0d036ca:	1192      	asrs	r2, r2, #6
c0d036cc:	428b      	cmp	r3, r1
c0d036ce:	d304      	bcc.n	c0d036da <__aeabi_idiv+0x14a>
c0d036d0:	0189      	lsls	r1, r1, #6
c0d036d2:	d03a      	beq.n	c0d0374a <__aeabi_idiv+0x1ba>
c0d036d4:	1192      	asrs	r2, r2, #6
c0d036d6:	e000      	b.n	c0d036da <__aeabi_idiv+0x14a>
c0d036d8:	0989      	lsrs	r1, r1, #6
c0d036da:	09c3      	lsrs	r3, r0, #7
c0d036dc:	428b      	cmp	r3, r1
c0d036de:	d301      	bcc.n	c0d036e4 <__aeabi_idiv+0x154>
c0d036e0:	01cb      	lsls	r3, r1, #7
c0d036e2:	1ac0      	subs	r0, r0, r3
c0d036e4:	4152      	adcs	r2, r2
c0d036e6:	0983      	lsrs	r3, r0, #6
c0d036e8:	428b      	cmp	r3, r1
c0d036ea:	d301      	bcc.n	c0d036f0 <__aeabi_idiv+0x160>
c0d036ec:	018b      	lsls	r3, r1, #6
c0d036ee:	1ac0      	subs	r0, r0, r3
c0d036f0:	4152      	adcs	r2, r2
c0d036f2:	0943      	lsrs	r3, r0, #5
c0d036f4:	428b      	cmp	r3, r1
c0d036f6:	d301      	bcc.n	c0d036fc <__aeabi_idiv+0x16c>
c0d036f8:	014b      	lsls	r3, r1, #5
c0d036fa:	1ac0      	subs	r0, r0, r3
c0d036fc:	4152      	adcs	r2, r2
c0d036fe:	0903      	lsrs	r3, r0, #4
c0d03700:	428b      	cmp	r3, r1
c0d03702:	d301      	bcc.n	c0d03708 <__aeabi_idiv+0x178>
c0d03704:	010b      	lsls	r3, r1, #4
c0d03706:	1ac0      	subs	r0, r0, r3
c0d03708:	4152      	adcs	r2, r2
c0d0370a:	08c3      	lsrs	r3, r0, #3
c0d0370c:	428b      	cmp	r3, r1
c0d0370e:	d301      	bcc.n	c0d03714 <__aeabi_idiv+0x184>
c0d03710:	00cb      	lsls	r3, r1, #3
c0d03712:	1ac0      	subs	r0, r0, r3
c0d03714:	4152      	adcs	r2, r2
c0d03716:	0883      	lsrs	r3, r0, #2
c0d03718:	428b      	cmp	r3, r1
c0d0371a:	d301      	bcc.n	c0d03720 <__aeabi_idiv+0x190>
c0d0371c:	008b      	lsls	r3, r1, #2
c0d0371e:	1ac0      	subs	r0, r0, r3
c0d03720:	4152      	adcs	r2, r2
c0d03722:	d2d9      	bcs.n	c0d036d8 <__aeabi_idiv+0x148>
c0d03724:	0843      	lsrs	r3, r0, #1
c0d03726:	428b      	cmp	r3, r1
c0d03728:	d301      	bcc.n	c0d0372e <__aeabi_idiv+0x19e>
c0d0372a:	004b      	lsls	r3, r1, #1
c0d0372c:	1ac0      	subs	r0, r0, r3
c0d0372e:	4152      	adcs	r2, r2
c0d03730:	1a41      	subs	r1, r0, r1
c0d03732:	d200      	bcs.n	c0d03736 <__aeabi_idiv+0x1a6>
c0d03734:	4601      	mov	r1, r0
c0d03736:	4663      	mov	r3, ip
c0d03738:	4152      	adcs	r2, r2
c0d0373a:	105b      	asrs	r3, r3, #1
c0d0373c:	4610      	mov	r0, r2
c0d0373e:	d301      	bcc.n	c0d03744 <__aeabi_idiv+0x1b4>
c0d03740:	4240      	negs	r0, r0
c0d03742:	2b00      	cmp	r3, #0
c0d03744:	d500      	bpl.n	c0d03748 <__aeabi_idiv+0x1b8>
c0d03746:	4249      	negs	r1, r1
c0d03748:	4770      	bx	lr
c0d0374a:	4663      	mov	r3, ip
c0d0374c:	105b      	asrs	r3, r3, #1
c0d0374e:	d300      	bcc.n	c0d03752 <__aeabi_idiv+0x1c2>
c0d03750:	4240      	negs	r0, r0
c0d03752:	b501      	push	{r0, lr}
c0d03754:	2000      	movs	r0, #0
c0d03756:	f000 f805 	bl	c0d03764 <__aeabi_idiv0>
c0d0375a:	bd02      	pop	{r1, pc}

c0d0375c <__aeabi_idivmod>:
c0d0375c:	2900      	cmp	r1, #0
c0d0375e:	d0f8      	beq.n	c0d03752 <__aeabi_idiv+0x1c2>
c0d03760:	e716      	b.n	c0d03590 <__aeabi_idiv>
c0d03762:	4770      	bx	lr

c0d03764 <__aeabi_idiv0>:
c0d03764:	4770      	bx	lr
c0d03766:	46c0      	nop			; (mov r8, r8)

c0d03768 <__aeabi_uldivmod>:
c0d03768:	2b00      	cmp	r3, #0
c0d0376a:	d111      	bne.n	c0d03790 <__aeabi_uldivmod+0x28>
c0d0376c:	2a00      	cmp	r2, #0
c0d0376e:	d10f      	bne.n	c0d03790 <__aeabi_uldivmod+0x28>
c0d03770:	2900      	cmp	r1, #0
c0d03772:	d100      	bne.n	c0d03776 <__aeabi_uldivmod+0xe>
c0d03774:	2800      	cmp	r0, #0
c0d03776:	d002      	beq.n	c0d0377e <__aeabi_uldivmod+0x16>
c0d03778:	2100      	movs	r1, #0
c0d0377a:	43c9      	mvns	r1, r1
c0d0377c:	1c08      	adds	r0, r1, #0
c0d0377e:	b407      	push	{r0, r1, r2}
c0d03780:	4802      	ldr	r0, [pc, #8]	; (c0d0378c <__aeabi_uldivmod+0x24>)
c0d03782:	a102      	add	r1, pc, #8	; (adr r1, c0d0378c <__aeabi_uldivmod+0x24>)
c0d03784:	1840      	adds	r0, r0, r1
c0d03786:	9002      	str	r0, [sp, #8]
c0d03788:	bd03      	pop	{r0, r1, pc}
c0d0378a:	46c0      	nop			; (mov r8, r8)
c0d0378c:	ffffffd9 	.word	0xffffffd9
c0d03790:	b403      	push	{r0, r1}
c0d03792:	4668      	mov	r0, sp
c0d03794:	b501      	push	{r0, lr}
c0d03796:	9802      	ldr	r0, [sp, #8]
c0d03798:	f000 f832 	bl	c0d03800 <__udivmoddi4>
c0d0379c:	9b01      	ldr	r3, [sp, #4]
c0d0379e:	469e      	mov	lr, r3
c0d037a0:	b002      	add	sp, #8
c0d037a2:	bc0c      	pop	{r2, r3}
c0d037a4:	4770      	bx	lr
c0d037a6:	46c0      	nop			; (mov r8, r8)

c0d037a8 <__aeabi_lmul>:
c0d037a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d037aa:	464f      	mov	r7, r9
c0d037ac:	4646      	mov	r6, r8
c0d037ae:	b4c0      	push	{r6, r7}
c0d037b0:	0416      	lsls	r6, r2, #16
c0d037b2:	0c36      	lsrs	r6, r6, #16
c0d037b4:	4699      	mov	r9, r3
c0d037b6:	0033      	movs	r3, r6
c0d037b8:	0405      	lsls	r5, r0, #16
c0d037ba:	0c2c      	lsrs	r4, r5, #16
c0d037bc:	0c07      	lsrs	r7, r0, #16
c0d037be:	0c15      	lsrs	r5, r2, #16
c0d037c0:	4363      	muls	r3, r4
c0d037c2:	437e      	muls	r6, r7
c0d037c4:	436f      	muls	r7, r5
c0d037c6:	4365      	muls	r5, r4
c0d037c8:	0c1c      	lsrs	r4, r3, #16
c0d037ca:	19ad      	adds	r5, r5, r6
c0d037cc:	1964      	adds	r4, r4, r5
c0d037ce:	469c      	mov	ip, r3
c0d037d0:	42a6      	cmp	r6, r4
c0d037d2:	d903      	bls.n	c0d037dc <__aeabi_lmul+0x34>
c0d037d4:	2380      	movs	r3, #128	; 0x80
c0d037d6:	025b      	lsls	r3, r3, #9
c0d037d8:	4698      	mov	r8, r3
c0d037da:	4447      	add	r7, r8
c0d037dc:	4663      	mov	r3, ip
c0d037de:	0c25      	lsrs	r5, r4, #16
c0d037e0:	19ef      	adds	r7, r5, r7
c0d037e2:	041d      	lsls	r5, r3, #16
c0d037e4:	464b      	mov	r3, r9
c0d037e6:	434a      	muls	r2, r1
c0d037e8:	4343      	muls	r3, r0
c0d037ea:	0c2d      	lsrs	r5, r5, #16
c0d037ec:	0424      	lsls	r4, r4, #16
c0d037ee:	1964      	adds	r4, r4, r5
c0d037f0:	1899      	adds	r1, r3, r2
c0d037f2:	19c9      	adds	r1, r1, r7
c0d037f4:	0020      	movs	r0, r4
c0d037f6:	bc0c      	pop	{r2, r3}
c0d037f8:	4690      	mov	r8, r2
c0d037fa:	4699      	mov	r9, r3
c0d037fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d037fe:	46c0      	nop			; (mov r8, r8)

c0d03800 <__udivmoddi4>:
c0d03800:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03802:	464d      	mov	r5, r9
c0d03804:	4656      	mov	r6, sl
c0d03806:	4644      	mov	r4, r8
c0d03808:	465f      	mov	r7, fp
c0d0380a:	b4f0      	push	{r4, r5, r6, r7}
c0d0380c:	4692      	mov	sl, r2
c0d0380e:	b083      	sub	sp, #12
c0d03810:	0004      	movs	r4, r0
c0d03812:	000d      	movs	r5, r1
c0d03814:	4699      	mov	r9, r3
c0d03816:	428b      	cmp	r3, r1
c0d03818:	d82f      	bhi.n	c0d0387a <__udivmoddi4+0x7a>
c0d0381a:	d02c      	beq.n	c0d03876 <__udivmoddi4+0x76>
c0d0381c:	4649      	mov	r1, r9
c0d0381e:	4650      	mov	r0, sl
c0d03820:	f000 f8ae 	bl	c0d03980 <__clzdi2>
c0d03824:	0029      	movs	r1, r5
c0d03826:	0006      	movs	r6, r0
c0d03828:	0020      	movs	r0, r4
c0d0382a:	f000 f8a9 	bl	c0d03980 <__clzdi2>
c0d0382e:	1a33      	subs	r3, r6, r0
c0d03830:	4698      	mov	r8, r3
c0d03832:	3b20      	subs	r3, #32
c0d03834:	469b      	mov	fp, r3
c0d03836:	d500      	bpl.n	c0d0383a <__udivmoddi4+0x3a>
c0d03838:	e074      	b.n	c0d03924 <__udivmoddi4+0x124>
c0d0383a:	4653      	mov	r3, sl
c0d0383c:	465a      	mov	r2, fp
c0d0383e:	4093      	lsls	r3, r2
c0d03840:	001f      	movs	r7, r3
c0d03842:	4653      	mov	r3, sl
c0d03844:	4642      	mov	r2, r8
c0d03846:	4093      	lsls	r3, r2
c0d03848:	001e      	movs	r6, r3
c0d0384a:	42af      	cmp	r7, r5
c0d0384c:	d829      	bhi.n	c0d038a2 <__udivmoddi4+0xa2>
c0d0384e:	d026      	beq.n	c0d0389e <__udivmoddi4+0x9e>
c0d03850:	465b      	mov	r3, fp
c0d03852:	1ba4      	subs	r4, r4, r6
c0d03854:	41bd      	sbcs	r5, r7
c0d03856:	2b00      	cmp	r3, #0
c0d03858:	da00      	bge.n	c0d0385c <__udivmoddi4+0x5c>
c0d0385a:	e079      	b.n	c0d03950 <__udivmoddi4+0x150>
c0d0385c:	2200      	movs	r2, #0
c0d0385e:	2300      	movs	r3, #0
c0d03860:	9200      	str	r2, [sp, #0]
c0d03862:	9301      	str	r3, [sp, #4]
c0d03864:	2301      	movs	r3, #1
c0d03866:	465a      	mov	r2, fp
c0d03868:	4093      	lsls	r3, r2
c0d0386a:	9301      	str	r3, [sp, #4]
c0d0386c:	2301      	movs	r3, #1
c0d0386e:	4642      	mov	r2, r8
c0d03870:	4093      	lsls	r3, r2
c0d03872:	9300      	str	r3, [sp, #0]
c0d03874:	e019      	b.n	c0d038aa <__udivmoddi4+0xaa>
c0d03876:	4282      	cmp	r2, r0
c0d03878:	d9d0      	bls.n	c0d0381c <__udivmoddi4+0x1c>
c0d0387a:	2200      	movs	r2, #0
c0d0387c:	2300      	movs	r3, #0
c0d0387e:	9200      	str	r2, [sp, #0]
c0d03880:	9301      	str	r3, [sp, #4]
c0d03882:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d03884:	2b00      	cmp	r3, #0
c0d03886:	d001      	beq.n	c0d0388c <__udivmoddi4+0x8c>
c0d03888:	601c      	str	r4, [r3, #0]
c0d0388a:	605d      	str	r5, [r3, #4]
c0d0388c:	9800      	ldr	r0, [sp, #0]
c0d0388e:	9901      	ldr	r1, [sp, #4]
c0d03890:	b003      	add	sp, #12
c0d03892:	bc3c      	pop	{r2, r3, r4, r5}
c0d03894:	4690      	mov	r8, r2
c0d03896:	4699      	mov	r9, r3
c0d03898:	46a2      	mov	sl, r4
c0d0389a:	46ab      	mov	fp, r5
c0d0389c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0389e:	42a3      	cmp	r3, r4
c0d038a0:	d9d6      	bls.n	c0d03850 <__udivmoddi4+0x50>
c0d038a2:	2200      	movs	r2, #0
c0d038a4:	2300      	movs	r3, #0
c0d038a6:	9200      	str	r2, [sp, #0]
c0d038a8:	9301      	str	r3, [sp, #4]
c0d038aa:	4643      	mov	r3, r8
c0d038ac:	2b00      	cmp	r3, #0
c0d038ae:	d0e8      	beq.n	c0d03882 <__udivmoddi4+0x82>
c0d038b0:	07fb      	lsls	r3, r7, #31
c0d038b2:	0872      	lsrs	r2, r6, #1
c0d038b4:	431a      	orrs	r2, r3
c0d038b6:	4646      	mov	r6, r8
c0d038b8:	087b      	lsrs	r3, r7, #1
c0d038ba:	e00e      	b.n	c0d038da <__udivmoddi4+0xda>
c0d038bc:	42ab      	cmp	r3, r5
c0d038be:	d101      	bne.n	c0d038c4 <__udivmoddi4+0xc4>
c0d038c0:	42a2      	cmp	r2, r4
c0d038c2:	d80c      	bhi.n	c0d038de <__udivmoddi4+0xde>
c0d038c4:	1aa4      	subs	r4, r4, r2
c0d038c6:	419d      	sbcs	r5, r3
c0d038c8:	2001      	movs	r0, #1
c0d038ca:	1924      	adds	r4, r4, r4
c0d038cc:	416d      	adcs	r5, r5
c0d038ce:	2100      	movs	r1, #0
c0d038d0:	3e01      	subs	r6, #1
c0d038d2:	1824      	adds	r4, r4, r0
c0d038d4:	414d      	adcs	r5, r1
c0d038d6:	2e00      	cmp	r6, #0
c0d038d8:	d006      	beq.n	c0d038e8 <__udivmoddi4+0xe8>
c0d038da:	42ab      	cmp	r3, r5
c0d038dc:	d9ee      	bls.n	c0d038bc <__udivmoddi4+0xbc>
c0d038de:	3e01      	subs	r6, #1
c0d038e0:	1924      	adds	r4, r4, r4
c0d038e2:	416d      	adcs	r5, r5
c0d038e4:	2e00      	cmp	r6, #0
c0d038e6:	d1f8      	bne.n	c0d038da <__udivmoddi4+0xda>
c0d038e8:	465b      	mov	r3, fp
c0d038ea:	9800      	ldr	r0, [sp, #0]
c0d038ec:	9901      	ldr	r1, [sp, #4]
c0d038ee:	1900      	adds	r0, r0, r4
c0d038f0:	4169      	adcs	r1, r5
c0d038f2:	2b00      	cmp	r3, #0
c0d038f4:	db22      	blt.n	c0d0393c <__udivmoddi4+0x13c>
c0d038f6:	002b      	movs	r3, r5
c0d038f8:	465a      	mov	r2, fp
c0d038fa:	40d3      	lsrs	r3, r2
c0d038fc:	002a      	movs	r2, r5
c0d038fe:	4644      	mov	r4, r8
c0d03900:	40e2      	lsrs	r2, r4
c0d03902:	001c      	movs	r4, r3
c0d03904:	465b      	mov	r3, fp
c0d03906:	0015      	movs	r5, r2
c0d03908:	2b00      	cmp	r3, #0
c0d0390a:	db2c      	blt.n	c0d03966 <__udivmoddi4+0x166>
c0d0390c:	0026      	movs	r6, r4
c0d0390e:	409e      	lsls	r6, r3
c0d03910:	0033      	movs	r3, r6
c0d03912:	0026      	movs	r6, r4
c0d03914:	4647      	mov	r7, r8
c0d03916:	40be      	lsls	r6, r7
c0d03918:	0032      	movs	r2, r6
c0d0391a:	1a80      	subs	r0, r0, r2
c0d0391c:	4199      	sbcs	r1, r3
c0d0391e:	9000      	str	r0, [sp, #0]
c0d03920:	9101      	str	r1, [sp, #4]
c0d03922:	e7ae      	b.n	c0d03882 <__udivmoddi4+0x82>
c0d03924:	4642      	mov	r2, r8
c0d03926:	2320      	movs	r3, #32
c0d03928:	1a9b      	subs	r3, r3, r2
c0d0392a:	4652      	mov	r2, sl
c0d0392c:	40da      	lsrs	r2, r3
c0d0392e:	4641      	mov	r1, r8
c0d03930:	0013      	movs	r3, r2
c0d03932:	464a      	mov	r2, r9
c0d03934:	408a      	lsls	r2, r1
c0d03936:	0017      	movs	r7, r2
c0d03938:	431f      	orrs	r7, r3
c0d0393a:	e782      	b.n	c0d03842 <__udivmoddi4+0x42>
c0d0393c:	4642      	mov	r2, r8
c0d0393e:	2320      	movs	r3, #32
c0d03940:	1a9b      	subs	r3, r3, r2
c0d03942:	002a      	movs	r2, r5
c0d03944:	4646      	mov	r6, r8
c0d03946:	409a      	lsls	r2, r3
c0d03948:	0023      	movs	r3, r4
c0d0394a:	40f3      	lsrs	r3, r6
c0d0394c:	4313      	orrs	r3, r2
c0d0394e:	e7d5      	b.n	c0d038fc <__udivmoddi4+0xfc>
c0d03950:	4642      	mov	r2, r8
c0d03952:	2320      	movs	r3, #32
c0d03954:	2100      	movs	r1, #0
c0d03956:	1a9b      	subs	r3, r3, r2
c0d03958:	2200      	movs	r2, #0
c0d0395a:	9100      	str	r1, [sp, #0]
c0d0395c:	9201      	str	r2, [sp, #4]
c0d0395e:	2201      	movs	r2, #1
c0d03960:	40da      	lsrs	r2, r3
c0d03962:	9201      	str	r2, [sp, #4]
c0d03964:	e782      	b.n	c0d0386c <__udivmoddi4+0x6c>
c0d03966:	4642      	mov	r2, r8
c0d03968:	2320      	movs	r3, #32
c0d0396a:	0026      	movs	r6, r4
c0d0396c:	1a9b      	subs	r3, r3, r2
c0d0396e:	40de      	lsrs	r6, r3
c0d03970:	002f      	movs	r7, r5
c0d03972:	46b4      	mov	ip, r6
c0d03974:	4097      	lsls	r7, r2
c0d03976:	4666      	mov	r6, ip
c0d03978:	003b      	movs	r3, r7
c0d0397a:	4333      	orrs	r3, r6
c0d0397c:	e7c9      	b.n	c0d03912 <__udivmoddi4+0x112>
c0d0397e:	46c0      	nop			; (mov r8, r8)

c0d03980 <__clzdi2>:
c0d03980:	b510      	push	{r4, lr}
c0d03982:	2900      	cmp	r1, #0
c0d03984:	d103      	bne.n	c0d0398e <__clzdi2+0xe>
c0d03986:	f000 f807 	bl	c0d03998 <__clzsi2>
c0d0398a:	3020      	adds	r0, #32
c0d0398c:	e002      	b.n	c0d03994 <__clzdi2+0x14>
c0d0398e:	1c08      	adds	r0, r1, #0
c0d03990:	f000 f802 	bl	c0d03998 <__clzsi2>
c0d03994:	bd10      	pop	{r4, pc}
c0d03996:	46c0      	nop			; (mov r8, r8)

c0d03998 <__clzsi2>:
c0d03998:	211c      	movs	r1, #28
c0d0399a:	2301      	movs	r3, #1
c0d0399c:	041b      	lsls	r3, r3, #16
c0d0399e:	4298      	cmp	r0, r3
c0d039a0:	d301      	bcc.n	c0d039a6 <__clzsi2+0xe>
c0d039a2:	0c00      	lsrs	r0, r0, #16
c0d039a4:	3910      	subs	r1, #16
c0d039a6:	0a1b      	lsrs	r3, r3, #8
c0d039a8:	4298      	cmp	r0, r3
c0d039aa:	d301      	bcc.n	c0d039b0 <__clzsi2+0x18>
c0d039ac:	0a00      	lsrs	r0, r0, #8
c0d039ae:	3908      	subs	r1, #8
c0d039b0:	091b      	lsrs	r3, r3, #4
c0d039b2:	4298      	cmp	r0, r3
c0d039b4:	d301      	bcc.n	c0d039ba <__clzsi2+0x22>
c0d039b6:	0900      	lsrs	r0, r0, #4
c0d039b8:	3904      	subs	r1, #4
c0d039ba:	a202      	add	r2, pc, #8	; (adr r2, c0d039c4 <__clzsi2+0x2c>)
c0d039bc:	5c10      	ldrb	r0, [r2, r0]
c0d039be:	1840      	adds	r0, r0, r1
c0d039c0:	4770      	bx	lr
c0d039c2:	46c0      	nop			; (mov r8, r8)
c0d039c4:	02020304 	.word	0x02020304
c0d039c8:	01010101 	.word	0x01010101
	...

c0d039d4 <__aeabi_memclr>:
c0d039d4:	b510      	push	{r4, lr}
c0d039d6:	2200      	movs	r2, #0
c0d039d8:	f000 f806 	bl	c0d039e8 <__aeabi_memset>
c0d039dc:	bd10      	pop	{r4, pc}
c0d039de:	46c0      	nop			; (mov r8, r8)

c0d039e0 <__aeabi_memcpy>:
c0d039e0:	b510      	push	{r4, lr}
c0d039e2:	f000 f809 	bl	c0d039f8 <memcpy>
c0d039e6:	bd10      	pop	{r4, pc}

c0d039e8 <__aeabi_memset>:
c0d039e8:	0013      	movs	r3, r2
c0d039ea:	b510      	push	{r4, lr}
c0d039ec:	000a      	movs	r2, r1
c0d039ee:	0019      	movs	r1, r3
c0d039f0:	f000 f840 	bl	c0d03a74 <memset>
c0d039f4:	bd10      	pop	{r4, pc}
c0d039f6:	46c0      	nop			; (mov r8, r8)

c0d039f8 <memcpy>:
c0d039f8:	b570      	push	{r4, r5, r6, lr}
c0d039fa:	2a0f      	cmp	r2, #15
c0d039fc:	d932      	bls.n	c0d03a64 <memcpy+0x6c>
c0d039fe:	000c      	movs	r4, r1
c0d03a00:	4304      	orrs	r4, r0
c0d03a02:	000b      	movs	r3, r1
c0d03a04:	07a4      	lsls	r4, r4, #30
c0d03a06:	d131      	bne.n	c0d03a6c <memcpy+0x74>
c0d03a08:	0015      	movs	r5, r2
c0d03a0a:	0004      	movs	r4, r0
c0d03a0c:	3d10      	subs	r5, #16
c0d03a0e:	092d      	lsrs	r5, r5, #4
c0d03a10:	3501      	adds	r5, #1
c0d03a12:	012d      	lsls	r5, r5, #4
c0d03a14:	1949      	adds	r1, r1, r5
c0d03a16:	681e      	ldr	r6, [r3, #0]
c0d03a18:	6026      	str	r6, [r4, #0]
c0d03a1a:	685e      	ldr	r6, [r3, #4]
c0d03a1c:	6066      	str	r6, [r4, #4]
c0d03a1e:	689e      	ldr	r6, [r3, #8]
c0d03a20:	60a6      	str	r6, [r4, #8]
c0d03a22:	68de      	ldr	r6, [r3, #12]
c0d03a24:	3310      	adds	r3, #16
c0d03a26:	60e6      	str	r6, [r4, #12]
c0d03a28:	3410      	adds	r4, #16
c0d03a2a:	4299      	cmp	r1, r3
c0d03a2c:	d1f3      	bne.n	c0d03a16 <memcpy+0x1e>
c0d03a2e:	230f      	movs	r3, #15
c0d03a30:	1945      	adds	r5, r0, r5
c0d03a32:	4013      	ands	r3, r2
c0d03a34:	2b03      	cmp	r3, #3
c0d03a36:	d91b      	bls.n	c0d03a70 <memcpy+0x78>
c0d03a38:	1f1c      	subs	r4, r3, #4
c0d03a3a:	2300      	movs	r3, #0
c0d03a3c:	08a4      	lsrs	r4, r4, #2
c0d03a3e:	3401      	adds	r4, #1
c0d03a40:	00a4      	lsls	r4, r4, #2
c0d03a42:	58ce      	ldr	r6, [r1, r3]
c0d03a44:	50ee      	str	r6, [r5, r3]
c0d03a46:	3304      	adds	r3, #4
c0d03a48:	429c      	cmp	r4, r3
c0d03a4a:	d1fa      	bne.n	c0d03a42 <memcpy+0x4a>
c0d03a4c:	2303      	movs	r3, #3
c0d03a4e:	192d      	adds	r5, r5, r4
c0d03a50:	1909      	adds	r1, r1, r4
c0d03a52:	401a      	ands	r2, r3
c0d03a54:	d005      	beq.n	c0d03a62 <memcpy+0x6a>
c0d03a56:	2300      	movs	r3, #0
c0d03a58:	5ccc      	ldrb	r4, [r1, r3]
c0d03a5a:	54ec      	strb	r4, [r5, r3]
c0d03a5c:	3301      	adds	r3, #1
c0d03a5e:	429a      	cmp	r2, r3
c0d03a60:	d1fa      	bne.n	c0d03a58 <memcpy+0x60>
c0d03a62:	bd70      	pop	{r4, r5, r6, pc}
c0d03a64:	0005      	movs	r5, r0
c0d03a66:	2a00      	cmp	r2, #0
c0d03a68:	d1f5      	bne.n	c0d03a56 <memcpy+0x5e>
c0d03a6a:	e7fa      	b.n	c0d03a62 <memcpy+0x6a>
c0d03a6c:	0005      	movs	r5, r0
c0d03a6e:	e7f2      	b.n	c0d03a56 <memcpy+0x5e>
c0d03a70:	001a      	movs	r2, r3
c0d03a72:	e7f8      	b.n	c0d03a66 <memcpy+0x6e>

c0d03a74 <memset>:
c0d03a74:	b570      	push	{r4, r5, r6, lr}
c0d03a76:	0783      	lsls	r3, r0, #30
c0d03a78:	d03f      	beq.n	c0d03afa <memset+0x86>
c0d03a7a:	1e54      	subs	r4, r2, #1
c0d03a7c:	2a00      	cmp	r2, #0
c0d03a7e:	d03b      	beq.n	c0d03af8 <memset+0x84>
c0d03a80:	b2ce      	uxtb	r6, r1
c0d03a82:	0003      	movs	r3, r0
c0d03a84:	2503      	movs	r5, #3
c0d03a86:	e003      	b.n	c0d03a90 <memset+0x1c>
c0d03a88:	1e62      	subs	r2, r4, #1
c0d03a8a:	2c00      	cmp	r4, #0
c0d03a8c:	d034      	beq.n	c0d03af8 <memset+0x84>
c0d03a8e:	0014      	movs	r4, r2
c0d03a90:	3301      	adds	r3, #1
c0d03a92:	1e5a      	subs	r2, r3, #1
c0d03a94:	7016      	strb	r6, [r2, #0]
c0d03a96:	422b      	tst	r3, r5
c0d03a98:	d1f6      	bne.n	c0d03a88 <memset+0x14>
c0d03a9a:	2c03      	cmp	r4, #3
c0d03a9c:	d924      	bls.n	c0d03ae8 <memset+0x74>
c0d03a9e:	25ff      	movs	r5, #255	; 0xff
c0d03aa0:	400d      	ands	r5, r1
c0d03aa2:	022a      	lsls	r2, r5, #8
c0d03aa4:	4315      	orrs	r5, r2
c0d03aa6:	042a      	lsls	r2, r5, #16
c0d03aa8:	4315      	orrs	r5, r2
c0d03aaa:	2c0f      	cmp	r4, #15
c0d03aac:	d911      	bls.n	c0d03ad2 <memset+0x5e>
c0d03aae:	0026      	movs	r6, r4
c0d03ab0:	3e10      	subs	r6, #16
c0d03ab2:	0936      	lsrs	r6, r6, #4
c0d03ab4:	3601      	adds	r6, #1
c0d03ab6:	0136      	lsls	r6, r6, #4
c0d03ab8:	001a      	movs	r2, r3
c0d03aba:	199b      	adds	r3, r3, r6
c0d03abc:	6015      	str	r5, [r2, #0]
c0d03abe:	6055      	str	r5, [r2, #4]
c0d03ac0:	6095      	str	r5, [r2, #8]
c0d03ac2:	60d5      	str	r5, [r2, #12]
c0d03ac4:	3210      	adds	r2, #16
c0d03ac6:	4293      	cmp	r3, r2
c0d03ac8:	d1f8      	bne.n	c0d03abc <memset+0x48>
c0d03aca:	220f      	movs	r2, #15
c0d03acc:	4014      	ands	r4, r2
c0d03ace:	2c03      	cmp	r4, #3
c0d03ad0:	d90a      	bls.n	c0d03ae8 <memset+0x74>
c0d03ad2:	1f26      	subs	r6, r4, #4
c0d03ad4:	08b6      	lsrs	r6, r6, #2
c0d03ad6:	3601      	adds	r6, #1
c0d03ad8:	00b6      	lsls	r6, r6, #2
c0d03ada:	001a      	movs	r2, r3
c0d03adc:	199b      	adds	r3, r3, r6
c0d03ade:	c220      	stmia	r2!, {r5}
c0d03ae0:	4293      	cmp	r3, r2
c0d03ae2:	d1fc      	bne.n	c0d03ade <memset+0x6a>
c0d03ae4:	2203      	movs	r2, #3
c0d03ae6:	4014      	ands	r4, r2
c0d03ae8:	2c00      	cmp	r4, #0
c0d03aea:	d005      	beq.n	c0d03af8 <memset+0x84>
c0d03aec:	b2c9      	uxtb	r1, r1
c0d03aee:	191c      	adds	r4, r3, r4
c0d03af0:	7019      	strb	r1, [r3, #0]
c0d03af2:	3301      	adds	r3, #1
c0d03af4:	429c      	cmp	r4, r3
c0d03af6:	d1fb      	bne.n	c0d03af0 <memset+0x7c>
c0d03af8:	bd70      	pop	{r4, r5, r6, pc}
c0d03afa:	0014      	movs	r4, r2
c0d03afc:	0003      	movs	r3, r0
c0d03afe:	e7cc      	b.n	c0d03a9a <memset+0x26>

c0d03b00 <setjmp>:
c0d03b00:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d03b02:	4641      	mov	r1, r8
c0d03b04:	464a      	mov	r2, r9
c0d03b06:	4653      	mov	r3, sl
c0d03b08:	465c      	mov	r4, fp
c0d03b0a:	466d      	mov	r5, sp
c0d03b0c:	4676      	mov	r6, lr
c0d03b0e:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d03b10:	3828      	subs	r0, #40	; 0x28
c0d03b12:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b14:	2000      	movs	r0, #0
c0d03b16:	4770      	bx	lr

c0d03b18 <longjmp>:
c0d03b18:	3010      	adds	r0, #16
c0d03b1a:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03b1c:	4690      	mov	r8, r2
c0d03b1e:	4699      	mov	r9, r3
c0d03b20:	46a2      	mov	sl, r4
c0d03b22:	46ab      	mov	fp, r5
c0d03b24:	46b5      	mov	sp, r6
c0d03b26:	c808      	ldmia	r0!, {r3}
c0d03b28:	3828      	subs	r0, #40	; 0x28
c0d03b2a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03b2c:	1c08      	adds	r0, r1, #0
c0d03b2e:	d100      	bne.n	c0d03b32 <longjmp+0x1a>
c0d03b30:	2001      	movs	r0, #1
c0d03b32:	4718      	bx	r3

c0d03b34 <strlen>:
c0d03b34:	b510      	push	{r4, lr}
c0d03b36:	0783      	lsls	r3, r0, #30
c0d03b38:	d027      	beq.n	c0d03b8a <strlen+0x56>
c0d03b3a:	7803      	ldrb	r3, [r0, #0]
c0d03b3c:	2b00      	cmp	r3, #0
c0d03b3e:	d026      	beq.n	c0d03b8e <strlen+0x5a>
c0d03b40:	0003      	movs	r3, r0
c0d03b42:	2103      	movs	r1, #3
c0d03b44:	e002      	b.n	c0d03b4c <strlen+0x18>
c0d03b46:	781a      	ldrb	r2, [r3, #0]
c0d03b48:	2a00      	cmp	r2, #0
c0d03b4a:	d01c      	beq.n	c0d03b86 <strlen+0x52>
c0d03b4c:	3301      	adds	r3, #1
c0d03b4e:	420b      	tst	r3, r1
c0d03b50:	d1f9      	bne.n	c0d03b46 <strlen+0x12>
c0d03b52:	6819      	ldr	r1, [r3, #0]
c0d03b54:	4a0f      	ldr	r2, [pc, #60]	; (c0d03b94 <strlen+0x60>)
c0d03b56:	4c10      	ldr	r4, [pc, #64]	; (c0d03b98 <strlen+0x64>)
c0d03b58:	188a      	adds	r2, r1, r2
c0d03b5a:	438a      	bics	r2, r1
c0d03b5c:	4222      	tst	r2, r4
c0d03b5e:	d10f      	bne.n	c0d03b80 <strlen+0x4c>
c0d03b60:	3304      	adds	r3, #4
c0d03b62:	6819      	ldr	r1, [r3, #0]
c0d03b64:	4a0b      	ldr	r2, [pc, #44]	; (c0d03b94 <strlen+0x60>)
c0d03b66:	188a      	adds	r2, r1, r2
c0d03b68:	438a      	bics	r2, r1
c0d03b6a:	4222      	tst	r2, r4
c0d03b6c:	d108      	bne.n	c0d03b80 <strlen+0x4c>
c0d03b6e:	3304      	adds	r3, #4
c0d03b70:	6819      	ldr	r1, [r3, #0]
c0d03b72:	4a08      	ldr	r2, [pc, #32]	; (c0d03b94 <strlen+0x60>)
c0d03b74:	188a      	adds	r2, r1, r2
c0d03b76:	438a      	bics	r2, r1
c0d03b78:	4222      	tst	r2, r4
c0d03b7a:	d0f1      	beq.n	c0d03b60 <strlen+0x2c>
c0d03b7c:	e000      	b.n	c0d03b80 <strlen+0x4c>
c0d03b7e:	3301      	adds	r3, #1
c0d03b80:	781a      	ldrb	r2, [r3, #0]
c0d03b82:	2a00      	cmp	r2, #0
c0d03b84:	d1fb      	bne.n	c0d03b7e <strlen+0x4a>
c0d03b86:	1a18      	subs	r0, r3, r0
c0d03b88:	bd10      	pop	{r4, pc}
c0d03b8a:	0003      	movs	r3, r0
c0d03b8c:	e7e1      	b.n	c0d03b52 <strlen+0x1e>
c0d03b8e:	2000      	movs	r0, #0
c0d03b90:	e7fa      	b.n	c0d03b88 <strlen+0x54>
c0d03b92:	46c0      	nop			; (mov r8, r8)
c0d03b94:	fefefeff 	.word	0xfefefeff
c0d03b98:	80808080 	.word	0x80808080
c0d03b9c:	45544550 	.word	0x45544550
c0d03ba0:	54455052 	.word	0x54455052
c0d03ba4:	45505245 	.word	0x45505245
c0d03ba8:	50524554 	.word	0x50524554
c0d03bac:	52455445 	.word	0x52455445
c0d03bb0:	45544550 	.word	0x45544550
c0d03bb4:	54455052 	.word	0x54455052
c0d03bb8:	45505245 	.word	0x45505245
c0d03bbc:	50524554 	.word	0x50524554
c0d03bc0:	52455445 	.word	0x52455445
c0d03bc4:	45544550 	.word	0x45544550
c0d03bc8:	54455052 	.word	0x54455052
c0d03bcc:	45505245 	.word	0x45505245
c0d03bd0:	50524554 	.word	0x50524554
c0d03bd4:	52455445 	.word	0x52455445
c0d03bd8:	45544550 	.word	0x45544550
c0d03bdc:	54455052 	.word	0x54455052
c0d03be0:	45505245 	.word	0x45505245
c0d03be4:	50524554 	.word	0x50524554
c0d03be8:	52455445 	.word	0x52455445
c0d03bec:	00000052 	.word	0x00000052

c0d03bf0 <trits_mapping>:
c0d03bf0:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03c00:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03c10:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03c20:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03c30:	00000100 01000101 000101ff 01010101     ................
c0d03c40:	00000001                                ....

c0d03c44 <HALF_3_u>:
c0d03c44:	a5ce8964 9f007669 1484504f 3ade00d9     d...iv..OP.....:
c0d03c54:	0c24486e 50979d57 79a4c702 48bbae36     nH$.W..P...y6..H
c0d03c64:	a9f6808b aa06a805 a87fabdf 5e69ebef     ..............i^

c0d03c74 <bagl_ui_nanos_screen1>:
c0d03c74:	00000003 00800000 00000020 00000001     ........ .......
c0d03c84:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03cac:	00000107 0080000c 00000020 00000000     ........ .......
c0d03cbc:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03ce4:	00030005 0007000c 00000007 00000000     ................
	...
c0d03cfc:	00070000 00000000 00000000 00000000     ................
	...
c0d03d1c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03d2c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03d54 <bagl_ui_nanos_screen2>:
c0d03d54:	00000003 00800000 00000020 00000001     ........ .......
c0d03d64:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03d8c:	00000107 00800012 00000020 00000000     ........ .......
c0d03d9c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03dc4:	00030005 0007000c 00000007 00000000     ................
	...
c0d03ddc:	00070000 00000000 00000000 00000000     ................
	...
c0d03dfc:	00750005 0008000d 00000006 00000000     ..u.............
c0d03e0c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03e34 <bagl_ui_sample_blue>:
c0d03e34:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03e44:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03e6c:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03e7c:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03ea4:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03eb4:	00ffffff 001d2028 00002004 c0d03f14     ....( ... ...?..
	...
c0d03edc:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03eec:	0041ccb4 00f9f9f9 0000a004 c0d03f20     ..A......... ?..
c0d03efc:	00000000 0037ae99 00f9f9f9 c0d0274d     ......7.....M'..
	...
c0d03f14:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03f25 <USBD_PRODUCT_FS_STRING>:
c0d03f25:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03f33 <HID_ReportDesc>:
c0d03f33:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03f43:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03f53:	0000c008 11210900                                .....

c0d03f58 <USBD_HID_Desc>:
c0d03f58:	01112109 22220100 00011200                       .!...."".

c0d03f61 <USBD_DeviceDesc>:
c0d03f61:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03f71:	5d000103                                         ...

c0d03f74 <HID_Desc>:
c0d03f74:	c0d0335d c0d0336d c0d0337d c0d0338d     ]3..m3..}3...3..
c0d03f84:	c0d0339d c0d033ad c0d033bd 00000000     .3...3...3......

c0d03f94 <USBD_LangIDDesc>:
c0d03f94:	04090304                                ....

c0d03f98 <USBD_MANUFACTURER_STRING>:
c0d03f98:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03fa6 <USB_SERIAL_STRING>:
c0d03fa6:	0030030a 00300030 323f0031                       ..0.0.0.1.

c0d03fb0 <USBD_HID>:
c0d03fb0:	c0d0323f c0d03271 c0d031a3 00000000     ?2..q2...1......
	...
c0d03fc8:	c0d032a9 00000000 00000000 00000000     .2..............
c0d03fd8:	c0d033cd c0d033cd c0d033cd c0d033dd     .3...3...3...3..

c0d03fe8 <USBD_CfgDesc>:
c0d03fe8:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03ff8:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04008:	05070100 00400302 00000001              ......@.....

c0d04014 <USBD_DeviceQualifierDesc>:
c0d04014:	0200060a 40000000 00000001              .......@....

c0d04020 <_etext>:
	...

c0d04040 <N_storage_real>:
	...
