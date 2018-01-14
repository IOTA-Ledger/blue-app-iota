
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
c0d00014:	f001 f8e8 	bl	c0d011e8 <os_memset>

    // ensure exception will work as planned
    os_boot();
c0d00018:	f001 f834 	bl	c0d01084 <os_boot>

    BEGIN_TRY {
        TRY {
c0d0001c:	4d1e      	ldr	r5, [pc, #120]	; (c0d00098 <main+0x98>)
c0d0001e:	6828      	ldr	r0, [r5, #0]
c0d00020:	900d      	str	r0, [sp, #52]	; 0x34
c0d00022:	ac03      	add	r4, sp, #12
c0d00024:	4620      	mov	r0, r4
c0d00026:	f003 fc99 	bl	c0d0395c <setjmp>
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
c0d00040:	f001 fa78 	bl	c0d01534 <io_seproxyhal_init>

            if (N_storage.initialized != 0x01) {
c0d00044:	4816      	ldr	r0, [pc, #88]	; (c0d000a0 <main+0xa0>)
c0d00046:	f001 ff59 	bl	c0d01efc <pic>
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
c0d0005a:	f001 ff4f 	bl	c0d01efc <pic>
c0d0005e:	2208      	movs	r2, #8
c0d00060:	4621      	mov	r1, r4
c0d00062:	f001 ff9d 	bl	c0d01fa0 <nvm_write>
c0d00066:	2000      	movs	r0, #0
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00068:	f003 f8a4 	bl	c0d031b4 <USB_power>
            USB_power(1);
c0d0006c:	2001      	movs	r0, #1
c0d0006e:	f003 f8a1 	bl	c0d031b4 <USB_power>

            ui_idle();
c0d00072:	f002 fa35 	bl	c0d024e0 <ui_idle>

            IOTA_main();
c0d00076:	f000 fe9d 	bl	c0d00db4 <IOTA_main>
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
c0d0008c:	f003 fc72 	bl	c0d03974 <longjmp>
c0d00090:	20001b48 	.word	0x20001b48
c0d00094:	20001a98 	.word	0x20001a98
c0d00098:	20001bb8 	.word	0x20001bb8
c0d0009c:	0000ffff 	.word	0x0000ffff
c0d000a0:	c0d03e80 	.word	0xc0d03e80

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
c0d000ca:	f001 fcc7 	bl	c0d01a5c <snprintf>
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
c0d001d0:	f003 f938 	bl	c0d03444 <__aeabi_idiv>
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
c0d001fc:	f003 f898 	bl	c0d03330 <__aeabi_uidiv>
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
c0d0022c:	f003 f90a 	bl	c0d03444 <__aeabi_idiv>
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
c0d00262:	f003 f865 	bl	c0d03330 <__aeabi_uidiv>
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
c0d0029e:	f003 f8d1 	bl	c0d03444 <__aeabi_idiv>
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
c0d002cc:	f003 f830 	bl	c0d03330 <__aeabi_uidiv>
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
c0d002f2:	f000 fb3b 	bl	c0d0096c <kerl_initialize>

    { // localize bytes_in variable to discard it when we are done
        unsigned char bytes_in[48];

        //kerl requires 424 bytes
        kerl_initialize();
c0d002f6:	f000 fb39 	bl	c0d0096c <kerl_initialize>
c0d002fa:	ae04      	add	r6, sp, #16

        //copy our private key into bytes_in
        //for now just re-use the last 16 bytes to fill bytes_in
        memcpy(&bytes_in[0], privateKey, sz);
c0d002fc:	4630      	mov	r0, r6
c0d002fe:	4621      	mov	r1, r4
c0d00300:	462a      	mov	r2, r5
c0d00302:	f003 fa9b 	bl	c0d0383c <__aeabi_memcpy>
        memcpy(&bytes_in[sz], privateKey, 48-sz);
c0d00306:	1970      	adds	r0, r6, r5
c0d00308:	2430      	movs	r4, #48	; 0x30
c0d0030a:	1b62      	subs	r2, r4, r5
c0d0030c:	9902      	ldr	r1, [sp, #8]
c0d0030e:	f003 fa95 	bl	c0d0383c <__aeabi_memcpy>

        //absorb these bytes
        kerl_absorb_bytes(&bytes_in[0], 48);
c0d00312:	4630      	mov	r0, r6
c0d00314:	4621      	mov	r1, r4
c0d00316:	f000 fb35 	bl	c0d00984 <kerl_absorb_bytes>
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
c0d00324:	f003 fa84 	bl	c0d03830 <__aeabi_memclr>
c0d00328:	ac04      	add	r4, sp, #16
      {
        char test_kerl[] = "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERR";
c0d0032a:	4921      	ldr	r1, [pc, #132]	; (c0d003b0 <get_seed+0xcc>)
c0d0032c:	4479      	add	r1, pc
c0d0032e:	2252      	movs	r2, #82	; 0x52
c0d00330:	4620      	mov	r0, r4
c0d00332:	f003 fa83 	bl	c0d0383c <__aeabi_memcpy>
        chars_to_trytes(test_kerl, seed_trytes, 81);
c0d00336:	4620      	mov	r0, r4
c0d00338:	4631      	mov	r1, r6
c0d0033a:	462c      	mov	r4, r5
c0d0033c:	9402      	str	r4, [sp, #8]
c0d0033e:	4622      	mov	r2, r4
c0d00340:	f000 f978 	bl	c0d00634 <chars_to_trytes>
c0d00344:	ad04      	add	r5, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d00346:	21f3      	movs	r1, #243	; 0xf3
c0d00348:	9100      	str	r1, [sp, #0]
c0d0034a:	4628      	mov	r0, r5
c0d0034c:	f003 fa70 	bl	c0d03830 <__aeabi_memclr>
        trytes_to_trits(seed_trytes, seed_trits, 81);
c0d00350:	4630      	mov	r0, r6
c0d00352:	4629      	mov	r1, r5
c0d00354:	4622      	mov	r2, r4
c0d00356:	f000 f94f 	bl	c0d005f8 <trytes_to_trits>
c0d0035a:	ac56      	add	r4, sp, #344	; 0x158
        specific_243trits_to_49trints(seed_trits, seed_trints);
c0d0035c:	4628      	mov	r0, r5
c0d0035e:	4621      	mov	r1, r4
c0d00360:	f7ff febe 	bl	c0d000e0 <specific_243trits_to_49trints>
      }
      {
        kerl_initialize();
c0d00364:	f000 fb02 	bl	c0d0096c <kerl_initialize>
c0d00368:	2531      	movs	r5, #49	; 0x31
        kerl_absorb_trints(seed_trints, 49);
c0d0036a:	4620      	mov	r0, r4
c0d0036c:	4629      	mov	r1, r5
c0d0036e:	f000 fb1d 	bl	c0d009ac <kerl_absorb_trints>
        kerl_squeeze_trints(seed_trints, 49);
c0d00372:	4620      	mov	r0, r4
c0d00374:	4629      	mov	r1, r5
c0d00376:	f000 fb49 	bl	c0d00a0c <kerl_squeeze_trints>
c0d0037a:	ad04      	add	r5, sp, #16
      }
      {
        trit_t seed_trits[81 * 3] = {0};
c0d0037c:	4628      	mov	r0, r5
c0d0037e:	9e00      	ldr	r6, [sp, #0]
c0d00380:	4631      	mov	r1, r6
c0d00382:	f003 fa55 	bl	c0d03830 <__aeabi_memclr>
        specific_49trints_to_243trits(seed_trints, seed_trits);
c0d00386:	4620      	mov	r0, r4
c0d00388:	4629      	mov	r1, r5
c0d0038a:	f7ff ff07 	bl	c0d0019c <specific_49trints_to_243trits>
        trits_to_trytes(seed_trits, seed_trytes, 243);
c0d0038e:	4628      	mov	r0, r5
c0d00390:	9c01      	ldr	r4, [sp, #4]
c0d00392:	4621      	mov	r1, r4
c0d00394:	4632      	mov	r2, r6
c0d00396:	f000 f8fa 	bl	c0d0058e <trits_to_trytes>
        trytes_to_chars(seed_trytes, msg, 81);
c0d0039a:	4620      	mov	r0, r4
c0d0039c:	9c03      	ldr	r4, [sp, #12]
c0d0039e:	4621      	mov	r1, r4
c0d003a0:	9d02      	ldr	r5, [sp, #8]
c0d003a2:	462a      	mov	r2, r5
c0d003a4:	f000 f95c 	bl	c0d00660 <trytes_to_chars>
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
c0d003b0:	000036c8 	.word	0x000036c8

c0d003b4 <bigint_add_int>:
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
    return ret;
}

int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
c0d003b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003b6:	af03      	add	r7, sp, #12
c0d003b8:	b087      	sub	sp, #28
c0d003ba:	9105      	str	r1, [sp, #20]
c0d003bc:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d003be:	2b00      	cmp	r3, #0
c0d003c0:	d03a      	beq.n	c0d00438 <bigint_add_int+0x84>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003c2:	2100      	movs	r1, #0
c0d003c4:	43cc      	mvns	r4, r1
c0d003c6:	9400      	str	r4, [sp, #0]
c0d003c8:	460e      	mov	r6, r1
c0d003ca:	460c      	mov	r4, r1
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_in[i], val.low, val.hi);
c0d003cc:	9101      	str	r1, [sp, #4]
c0d003ce:	9302      	str	r3, [sp, #8]
c0d003d0:	9203      	str	r2, [sp, #12]
c0d003d2:	9b00      	ldr	r3, [sp, #0]
c0d003d4:	460a      	mov	r2, r1
c0d003d6:	4605      	mov	r5, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d003d8:	cd01      	ldmia	r5!, {r0}
c0d003da:	9504      	str	r5, [sp, #16]
c0d003dc:	9905      	ldr	r1, [sp, #20]
c0d003de:	1841      	adds	r1, r0, r1
c0d003e0:	4156      	adcs	r6, r2
c0d003e2:	9106      	str	r1, [sp, #24]
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d003e4:	4019      	ands	r1, r3
c0d003e6:	1c49      	adds	r1, r1, #1
c0d003e8:	4615      	mov	r5, r2
c0d003ea:	416d      	adcs	r5, r5
c0d003ec:	2001      	movs	r0, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d003ee:	4004      	ands	r4, r0
c0d003f0:	4622      	mov	r2, r4
c0d003f2:	2c00      	cmp	r4, #0
c0d003f4:	d100      	bne.n	c0d003f8 <bigint_add_int+0x44>
c0d003f6:	9906      	ldr	r1, [sp, #24]
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d003f8:	4299      	cmp	r1, r3
c0d003fa:	9006      	str	r0, [sp, #24]
c0d003fc:	d800      	bhi.n	c0d00400 <bigint_add_int+0x4c>
c0d003fe:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d00400:	2a00      	cmp	r2, #0
c0d00402:	4632      	mov	r2, r6
c0d00404:	d100      	bne.n	c0d00408 <bigint_add_int+0x54>
c0d00406:	4615      	mov	r5, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00408:	2d00      	cmp	r5, #0
c0d0040a:	9e06      	ldr	r6, [sp, #24]
c0d0040c:	d100      	bne.n	c0d00410 <bigint_add_int+0x5c>
c0d0040e:	462e      	mov	r6, r5
c0d00410:	2d00      	cmp	r5, #0
c0d00412:	d000      	beq.n	c0d00416 <bigint_add_int+0x62>
c0d00414:	4630      	mov	r0, r6
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00416:	4310      	orrs	r0, r2
c0d00418:	b2c0      	uxtb	r0, r0
c0d0041a:	2800      	cmp	r0, #0
c0d0041c:	9b02      	ldr	r3, [sp, #8]
c0d0041e:	9a03      	ldr	r2, [sp, #12]
c0d00420:	9c01      	ldr	r4, [sp, #4]
c0d00422:	d100      	bne.n	c0d00426 <bigint_add_int+0x72>
c0d00424:	9006      	str	r0, [sp, #24]
        val = full_add(bigint_in[i], val.low, val.hi);
        bigint_out[i] = val.low;
c0d00426:	c202      	stmia	r2!, {r1}
int bigint_add_int(int32_t bigint_in[], int32_t int_in, int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.low = int_in;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00428:	1e5b      	subs	r3, r3, #1
c0d0042a:	9405      	str	r4, [sp, #20]
c0d0042c:	4626      	mov	r6, r4
c0d0042e:	9d06      	ldr	r5, [sp, #24]
c0d00430:	4621      	mov	r1, r4
c0d00432:	462c      	mov	r4, r5
c0d00434:	9804      	ldr	r0, [sp, #16]
c0d00436:	d1ca      	bne.n	c0d003ce <bigint_add_int+0x1a>
        bigint_out[i] = val.low;
        val.low = 0;
    }

    if (val.hi) {
        return -1;
c0d00438:	4268      	negs	r0, r5
    }
    return 0;
}
c0d0043a:	b007      	add	sp, #28
c0d0043c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0043e <bigint_add_bigint>:

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d0043e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00440:	af03      	add	r7, sp, #12
c0d00442:	b086      	sub	sp, #24
c0d00444:	461c      	mov	r4, r3
c0d00446:	2500      	movs	r5, #0
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d00448:	2c00      	cmp	r4, #0
c0d0044a:	d034      	beq.n	c0d004b6 <bigint_add_bigint+0x78>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d0044c:	2600      	movs	r6, #0
c0d0044e:	43f3      	mvns	r3, r6
c0d00450:	9300      	str	r3, [sp, #0]
c0d00452:	9601      	str	r6, [sp, #4]
c0d00454:	9202      	str	r2, [sp, #8]
c0d00456:	9403      	str	r4, [sp, #12]
c0d00458:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d0045a:	cc01      	ldmia	r4!, {r0}
c0d0045c:	9404      	str	r4, [sp, #16]
c0d0045e:	460c      	mov	r4, r1
c0d00460:	cc02      	ldmia	r4!, {r1}
c0d00462:	9405      	str	r4, [sp, #20]
c0d00464:	180a      	adds	r2, r1, r0
c0d00466:	9d01      	ldr	r5, [sp, #4]
c0d00468:	462c      	mov	r4, r5
c0d0046a:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d0046c:	4611      	mov	r1, r2
c0d0046e:	9800      	ldr	r0, [sp, #0]
c0d00470:	4001      	ands	r1, r0
c0d00472:	1c4b      	adds	r3, r1, #1
c0d00474:	4629      	mov	r1, r5
c0d00476:	4149      	adcs	r1, r1
c0d00478:	2501      	movs	r5, #1
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0047a:	402e      	ands	r6, r5
c0d0047c:	2e00      	cmp	r6, #0
c0d0047e:	d100      	bne.n	c0d00482 <bigint_add_bigint+0x44>
c0d00480:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00482:	4283      	cmp	r3, r0
c0d00484:	4628      	mov	r0, r5
c0d00486:	d800      	bhi.n	c0d0048a <bigint_add_bigint+0x4c>
c0d00488:	9801      	ldr	r0, [sp, #4]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0048a:	2e00      	cmp	r6, #0
c0d0048c:	9a02      	ldr	r2, [sp, #8]
c0d0048e:	d100      	bne.n	c0d00492 <bigint_add_bigint+0x54>
c0d00490:	4621      	mov	r1, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00492:	2900      	cmp	r1, #0
c0d00494:	462e      	mov	r6, r5
c0d00496:	d100      	bne.n	c0d0049a <bigint_add_bigint+0x5c>
c0d00498:	460e      	mov	r6, r1
c0d0049a:	2900      	cmp	r1, #0
c0d0049c:	d000      	beq.n	c0d004a0 <bigint_add_bigint+0x62>
c0d0049e:	4630      	mov	r0, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d004a0:	4320      	orrs	r0, r4

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004a2:	2800      	cmp	r0, #0
c0d004a4:	9905      	ldr	r1, [sp, #20]
c0d004a6:	d100      	bne.n	c0d004aa <bigint_add_bigint+0x6c>
c0d004a8:	4605      	mov	r5, r0
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d004aa:	c208      	stmia	r2!, {r3}
c0d004ac:	9c03      	ldr	r4, [sp, #12]

int bigint_add_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = false;
    for (uint8_t i = 0; i < len; i++) {
c0d004ae:	1e64      	subs	r4, r4, #1
c0d004b0:	462e      	mov	r6, r5
c0d004b2:	9804      	ldr	r0, [sp, #16]
c0d004b4:	d1ce      	bne.n	c0d00454 <bigint_add_bigint+0x16>
        val = full_add(bigint_one[i], bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }

    if (val.hi) {
        return -1;
c0d004b6:	4268      	negs	r0, r5
    }
    return 0;
}
c0d004b8:	b006      	add	sp, #24
c0d004ba:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d004bc <bigint_sub_bigint>:

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
c0d004bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d004be:	af03      	add	r7, sp, #12
c0d004c0:	b087      	sub	sp, #28
c0d004c2:	461d      	mov	r5, r3
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d004c4:	2d00      	cmp	r5, #0
c0d004c6:	d037      	beq.n	c0d00538 <bigint_sub_bigint+0x7c>
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d004c8:	2400      	movs	r4, #0
c0d004ca:	9402      	str	r4, [sp, #8]
c0d004cc:	43e3      	mvns	r3, r4
c0d004ce:	9301      	str	r3, [sp, #4]
c0d004d0:	2601      	movs	r6, #1
c0d004d2:	9600      	str	r6, [sp, #0]
c0d004d4:	9203      	str	r2, [sp, #12]
c0d004d6:	9504      	str	r5, [sp, #16]
c0d004d8:	4604      	mov	r4, r0
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004da:	cc01      	ldmia	r4!, {r0}
c0d004dc:	9405      	str	r4, [sp, #20]
c0d004de:	460c      	mov	r4, r1
int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
c0d004e0:	cc02      	ldmia	r4!, {r1}
c0d004e2:	9406      	str	r4, [sp, #24]
c0d004e4:	43c9      	mvns	r1, r1
#include "bigint.h"

struct int_bool_pair full_add(const int32_t ia, const int32_t ib, const bool carry)
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
c0d004e6:	180a      	adds	r2, r1, r0
c0d004e8:	9902      	ldr	r1, [sp, #8]
c0d004ea:	460c      	mov	r4, r1
c0d004ec:	4164      	adcs	r4, r4
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
        v = (uint64_t)r + (uint64_t)1;
c0d004ee:	4610      	mov	r0, r2
c0d004f0:	9d01      	ldr	r5, [sp, #4]
c0d004f2:	4028      	ands	r0, r5
c0d004f4:	1c43      	adds	r3, r0, #1
c0d004f6:	4608      	mov	r0, r1
c0d004f8:	4140      	adcs	r0, r0
c0d004fa:	9900      	ldr	r1, [sp, #0]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d004fc:	400e      	ands	r6, r1
c0d004fe:	2e00      	cmp	r6, #0
c0d00500:	d100      	bne.n	c0d00504 <bigint_sub_bigint+0x48>
c0d00502:	4613      	mov	r3, r2
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00504:	42ab      	cmp	r3, r5
c0d00506:	460d      	mov	r5, r1
c0d00508:	d800      	bhi.n	c0d0050c <bigint_sub_bigint+0x50>
c0d0050a:	9d02      	ldr	r5, [sp, #8]
{
    uint64_t v = (uint64_t)(ia & 0xFFFFFFFF) + (uint64_t)(ib & 0xFFFFFFFF);
    uint32_t l = v >> 32;
    uint32_t r = v & 0xFFFFFFFF;
    bool carry1 = l != 0;
    if (carry) {
c0d0050c:	2e00      	cmp	r6, #0
c0d0050e:	9a03      	ldr	r2, [sp, #12]
c0d00510:	d100      	bne.n	c0d00514 <bigint_sub_bigint+0x58>
c0d00512:	4620      	mov	r0, r4
        v = (uint64_t)r + (uint64_t)1;
    }
    l = (v >> 32);
    r = v & 0xFFFFFFFF;
    bool carry2 = l != 0;
c0d00514:	2800      	cmp	r0, #0
c0d00516:	460e      	mov	r6, r1
c0d00518:	d100      	bne.n	c0d0051c <bigint_sub_bigint+0x60>
c0d0051a:	4606      	mov	r6, r0
c0d0051c:	2800      	cmp	r0, #0
c0d0051e:	d000      	beq.n	c0d00522 <bigint_sub_bigint+0x66>
c0d00520:	4635      	mov	r5, r6
    struct int_bool_pair ret = { (int32_t)r, carry1 || carry2 };
c0d00522:	4325      	orrs	r5, r4

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00524:	2d00      	cmp	r5, #0
c0d00526:	460e      	mov	r6, r1
c0d00528:	9805      	ldr	r0, [sp, #20]
c0d0052a:	d100      	bne.n	c0d0052e <bigint_sub_bigint+0x72>
c0d0052c:	462e      	mov	r6, r5
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
c0d0052e:	c208      	stmia	r2!, {r3}
c0d00530:	9d04      	ldr	r5, [sp, #16]

int bigint_sub_bigint(const int32_t bigint_one[], const int32_t bigint_two[], int32_t bigint_out[], uint8_t len)
{
    struct int_bool_pair val;
    val.hi = true;
    for (uint8_t i = 0; i < len; i++) {
c0d00532:	1e6d      	subs	r5, r5, #1
c0d00534:	9906      	ldr	r1, [sp, #24]
c0d00536:	d1cd      	bne.n	c0d004d4 <bigint_sub_bigint+0x18>
        val = full_add(bigint_one[i], ~bigint_two[i], val.hi);
        bigint_out[i] = val.low;
    }
    return 0;
c0d00538:	2000      	movs	r0, #0
c0d0053a:	b007      	add	sp, #28
c0d0053c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0053e <bigint_cmp_bigint>:
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
c0d0053e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00540:	af03      	add	r7, sp, #12
c0d00542:	b081      	sub	sp, #4
c0d00544:	2400      	movs	r4, #0
c0d00546:	43e5      	mvns	r5, r4
    for (int8_t i = len-1; i >= 0; i--) {
c0d00548:	32ff      	adds	r2, #255	; 0xff
c0d0054a:	b253      	sxtb	r3, r2
c0d0054c:	2b00      	cmp	r3, #0
c0d0054e:	db0f      	blt.n	c0d00570 <bigint_cmp_bigint+0x32>
c0d00550:	9400      	str	r4, [sp, #0]
        if (bigint_one[i] > bigint_two[i]) {
c0d00552:	009b      	lsls	r3, r3, #2
c0d00554:	58ce      	ldr	r6, [r1, r3]
c0d00556:	58c4      	ldr	r4, [r0, r3]
c0d00558:	2301      	movs	r3, #1
c0d0055a:	42b4      	cmp	r4, r6
c0d0055c:	dc0b      	bgt.n	c0d00576 <bigint_cmp_bigint+0x38>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d0055e:	1e52      	subs	r2, r2, #1
        if (bigint_one[i] > bigint_two[i]) {
            return 1;
        }
        if (bigint_one[i] < bigint_two[i]) {
c0d00560:	42b4      	cmp	r4, r6
c0d00562:	db07      	blt.n	c0d00574 <bigint_cmp_bigint+0x36>
    return 0;
}

int8_t bigint_cmp_bigint(const int32_t bigint_one[], const int32_t bigint_two[], uint8_t len)
{
    for (int8_t i = len-1; i >= 0; i--) {
c0d00564:	b253      	sxtb	r3, r2
c0d00566:	42ab      	cmp	r3, r5
c0d00568:	461a      	mov	r2, r3
c0d0056a:	dcf2      	bgt.n	c0d00552 <bigint_cmp_bigint+0x14>
c0d0056c:	9b00      	ldr	r3, [sp, #0]
c0d0056e:	e002      	b.n	c0d00576 <bigint_cmp_bigint+0x38>
c0d00570:	4623      	mov	r3, r4
c0d00572:	e000      	b.n	c0d00576 <bigint_cmp_bigint+0x38>
c0d00574:	462b      	mov	r3, r5
        if (bigint_one[i] < bigint_two[i]) {
            return -1;
        }
    }
    return 0;
}
c0d00576:	4618      	mov	r0, r3
c0d00578:	b001      	add	sp, #4
c0d0057a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0057c <bigint_not>:

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d0057c:	2900      	cmp	r1, #0
c0d0057e:	d004      	beq.n	c0d0058a <bigint_not+0xe>
        bigint[i] = ~bigint[i];
c0d00580:	6802      	ldr	r2, [r0, #0]
c0d00582:	43d2      	mvns	r2, r2
c0d00584:	c004      	stmia	r0!, {r2}
    return 0;
}

int bigint_not(int32_t bigint[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00586:	1e49      	subs	r1, r1, #1
c0d00588:	d1fa      	bne.n	c0d00580 <bigint_not+0x4>
        bigint[i] = ~bigint[i];
    }
    return 0;
c0d0058a:	2000      	movs	r0, #0
c0d0058c:	4770      	bx	lr

c0d0058e <trits_to_trytes>:

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
c0d0058e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00590:	af03      	add	r7, sp, #12
c0d00592:	b083      	sub	sp, #12
c0d00594:	4616      	mov	r6, r2
c0d00596:	460c      	mov	r4, r1
c0d00598:	4605      	mov	r5, r0
    if (trit_len % 3 != 0) {
c0d0059a:	2103      	movs	r1, #3
c0d0059c:	4630      	mov	r0, r6
c0d0059e:	f002 ff4d 	bl	c0d0343c <__aeabi_uidivmod>
c0d005a2:	2000      	movs	r0, #0
c0d005a4:	43c2      	mvns	r2, r0
c0d005a6:	2900      	cmp	r1, #0
c0d005a8:	d123      	bne.n	c0d005f2 <trits_to_trytes+0x64>
c0d005aa:	9502      	str	r5, [sp, #8]
c0d005ac:	4635      	mov	r5, r6
c0d005ae:	2603      	movs	r6, #3
c0d005b0:	9001      	str	r0, [sp, #4]
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;
c0d005b2:	4628      	mov	r0, r5
c0d005b4:	4631      	mov	r1, r6
c0d005b6:	f002 febb 	bl	c0d03330 <__aeabi_uidiv>

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d005ba:	2d03      	cmp	r5, #3
c0d005bc:	9a01      	ldr	r2, [sp, #4]
c0d005be:	d318      	bcc.n	c0d005f2 <trits_to_trytes+0x64>
c0d005c0:	2200      	movs	r2, #0
c0d005c2:	9200      	str	r2, [sp, #0]
c0d005c4:	9601      	str	r6, [sp, #4]
c0d005c6:	9e01      	ldr	r6, [sp, #4]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
c0d005c8:	4633      	mov	r3, r6
c0d005ca:	4353      	muls	r3, r2
c0d005cc:	4625      	mov	r5, r4
c0d005ce:	9902      	ldr	r1, [sp, #8]
c0d005d0:	5ccc      	ldrb	r4, [r1, r3]
c0d005d2:	18cb      	adds	r3, r1, r3
c0d005d4:	2101      	movs	r1, #1
c0d005d6:	5659      	ldrsb	r1, [r3, r1]
c0d005d8:	4371      	muls	r1, r6
c0d005da:	1909      	adds	r1, r1, r4
c0d005dc:	2402      	movs	r4, #2
c0d005de:	571b      	ldrsb	r3, [r3, r4]
c0d005e0:	2409      	movs	r4, #9
c0d005e2:	435c      	muls	r4, r3
c0d005e4:	1909      	adds	r1, r1, r4
c0d005e6:	462c      	mov	r4, r5
c0d005e8:	54a1      	strb	r1, [r4, r2]
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
c0d005ea:	1c52      	adds	r2, r2, #1
c0d005ec:	4282      	cmp	r2, r0
c0d005ee:	d3eb      	bcc.n	c0d005c8 <trits_to_trytes+0x3a>
c0d005f0:	9a00      	ldr	r2, [sp, #0]
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}
c0d005f2:	4610      	mov	r0, r2
c0d005f4:	b003      	add	sp, #12
c0d005f6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d005f8 <trytes_to_trits>:

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
c0d005f8:	b5b0      	push	{r4, r5, r7, lr}
c0d005fa:	af02      	add	r7, sp, #8
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d005fc:	2a00      	cmp	r2, #0
c0d005fe:	d015      	beq.n	c0d0062c <trytes_to_trits+0x34>
c0d00600:	4b0b      	ldr	r3, [pc, #44]	; (c0d00630 <trytes_to_trits+0x38>)
c0d00602:	447b      	add	r3, pc
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d00604:	240d      	movs	r4, #13
c0d00606:	0624      	lsls	r4, r4, #24
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
c0d00608:	7805      	ldrb	r5, [r0, #0]
        trits_out[i*3+0] = trits_mapping[idx][0];
c0d0060a:	062d      	lsls	r5, r5, #24
c0d0060c:	192c      	adds	r4, r5, r4
c0d0060e:	1624      	asrs	r4, r4, #24
c0d00610:	2503      	movs	r5, #3
c0d00612:	4365      	muls	r5, r4
c0d00614:	5d5c      	ldrb	r4, [r3, r5]
c0d00616:	700c      	strb	r4, [r1, #0]
c0d00618:	195c      	adds	r4, r3, r5
        trits_out[i*3+1] = trits_mapping[idx][1];
c0d0061a:	7865      	ldrb	r5, [r4, #1]
c0d0061c:	704d      	strb	r5, [r1, #1]
        trits_out[i*3+2] = trits_mapping[idx][2];
c0d0061e:	78a4      	ldrb	r4, [r4, #2]
c0d00620:	708c      	strb	r4, [r1, #2]
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
c0d00622:	1e52      	subs	r2, r2, #1
c0d00624:	1cc9      	adds	r1, r1, #3
c0d00626:	1c40      	adds	r0, r0, #1
c0d00628:	2a00      	cmp	r2, #0
c0d0062a:	d1eb      	bne.n	c0d00604 <trytes_to_trits+0xc>
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
c0d0062c:	2000      	movs	r0, #0
c0d0062e:	bdb0      	pop	{r4, r5, r7, pc}
c0d00630:	00003446 	.word	0x00003446

c0d00634 <chars_to_trytes>:
    }
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
c0d00634:	b5d0      	push	{r4, r6, r7, lr}
c0d00636:	af02      	add	r7, sp, #8
c0d00638:	e00e      	b.n	c0d00658 <chars_to_trytes+0x24>
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
c0d0063a:	7803      	ldrb	r3, [r0, #0]
c0d0063c:	b25b      	sxtb	r3, r3
c0d0063e:	2400      	movs	r4, #0
c0d00640:	2b39      	cmp	r3, #57	; 0x39
c0d00642:	d005      	beq.n	c0d00650 <chars_to_trytes+0x1c>
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
c0d00644:	2b4e      	cmp	r3, #78	; 0x4e
c0d00646:	db01      	blt.n	c0d0064c <chars_to_trytes+0x18>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
c0d00648:	33a5      	adds	r3, #165	; 0xa5
c0d0064a:	e000      	b.n	c0d0064e <chars_to_trytes+0x1a>
c0d0064c:	33c0      	adds	r3, #192	; 0xc0
c0d0064e:	461c      	mov	r4, r3
c0d00650:	700c      	strb	r4, [r1, #0]
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
c0d00652:	1e52      	subs	r2, r2, #1
c0d00654:	1c40      	adds	r0, r0, #1
c0d00656:	1c49      	adds	r1, r1, #1
c0d00658:	2a00      	cmp	r2, #0
c0d0065a:	d1ee      	bne.n	c0d0063a <chars_to_trytes+0x6>
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
c0d0065c:	2000      	movs	r0, #0
c0d0065e:	bdd0      	pop	{r4, r6, r7, pc}

c0d00660 <trytes_to_chars>:
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
c0d00660:	b5d0      	push	{r4, r6, r7, lr}
c0d00662:	af02      	add	r7, sp, #8
    for (uint16_t i = 0; i < len; i++) {
c0d00664:	2a00      	cmp	r2, #0
c0d00666:	d00a      	beq.n	c0d0067e <trytes_to_chars+0x1e>
c0d00668:	a306      	add	r3, pc, #24	; (adr r3, c0d00684 <tryte_to_char_mapping>)
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
c0d0066a:	7804      	ldrb	r4, [r0, #0]
c0d0066c:	b264      	sxtb	r4, r4
c0d0066e:	191c      	adds	r4, r3, r4
c0d00670:	7b64      	ldrb	r4, [r4, #13]
c0d00672:	700c      	strb	r4, [r1, #0]
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
c0d00674:	1e52      	subs	r2, r2, #1
c0d00676:	1c40      	adds	r0, r0, #1
c0d00678:	1c49      	adds	r1, r1, #1
c0d0067a:	2a00      	cmp	r2, #0
c0d0067c:	d1f5      	bne.n	c0d0066a <trytes_to_chars+0xa>
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
c0d0067e:	2000      	movs	r0, #0
c0d00680:	bdd0      	pop	{r4, r6, r7, pc}
c0d00682:	46c0      	nop			; (mov r8, r8)

c0d00684 <tryte_to_char_mapping>:
c0d00684:	51504f4e 	.word	0x51504f4e
c0d00688:	55545352 	.word	0x55545352
c0d0068c:	59585756 	.word	0x59585756
c0d00690:	4241395a 	.word	0x4241395a
c0d00694:	46454443 	.word	0x46454443
c0d00698:	4a494847 	.word	0x4a494847
c0d0069c:	004d4c4b 	.word	0x004d4c4b

c0d006a0 <words_to_bytes>:
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
c0d006a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006a2:	af03      	add	r7, sp, #12
c0d006a4:	b082      	sub	sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d006a6:	2a00      	cmp	r2, #0
c0d006a8:	d01a      	beq.n	c0d006e0 <words_to_bytes+0x40>
c0d006aa:	0093      	lsls	r3, r2, #2
c0d006ac:	18c0      	adds	r0, r0, r3
c0d006ae:	1f00      	subs	r0, r0, #4
c0d006b0:	2303      	movs	r3, #3
c0d006b2:	43db      	mvns	r3, r3
c0d006b4:	9301      	str	r3, [sp, #4]
c0d006b6:	4252      	negs	r2, r2
c0d006b8:	9200      	str	r2, [sp, #0]
c0d006ba:	2400      	movs	r4, #0
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
c0d006bc:	9d01      	ldr	r5, [sp, #4]
c0d006be:	4365      	muls	r5, r4
c0d006c0:	00a6      	lsls	r6, r4, #2
c0d006c2:	1983      	adds	r3, r0, r6
c0d006c4:	78da      	ldrb	r2, [r3, #3]
c0d006c6:	554a      	strb	r2, [r1, r5]
c0d006c8:	194a      	adds	r2, r1, r5
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
c0d006ca:	885b      	ldrh	r3, [r3, #2]
c0d006cc:	7053      	strb	r3, [r2, #1]
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
c0d006ce:	5983      	ldr	r3, [r0, r6]
c0d006d0:	0a1b      	lsrs	r3, r3, #8
c0d006d2:	7093      	strb	r3, [r2, #2]
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
c0d006d4:	5983      	ldr	r3, [r0, r6]
c0d006d6:	70d3      	strb	r3, [r2, #3]
    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d006d8:	1e64      	subs	r4, r4, #1
c0d006da:	9a00      	ldr	r2, [sp, #0]
c0d006dc:	42a2      	cmp	r2, r4
c0d006de:	d1ed      	bne.n	c0d006bc <words_to_bytes+0x1c>
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
c0d006e0:	2000      	movs	r0, #0
c0d006e2:	b002      	add	sp, #8
c0d006e4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d006e6 <bytes_to_words>:
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
c0d006e6:	b5d0      	push	{r4, r6, r7, lr}
c0d006e8:	af02      	add	r7, sp, #8
    for (uint8_t i = 0; i < word_len; i++) {
c0d006ea:	2a00      	cmp	r2, #0
c0d006ec:	d015      	beq.n	c0d0071a <bytes_to_words+0x34>
c0d006ee:	0093      	lsls	r3, r2, #2
c0d006f0:	18c0      	adds	r0, r0, r3
c0d006f2:	1f00      	subs	r0, r0, #4
c0d006f4:	2300      	movs	r3, #0
        words_out[i] = 0;
c0d006f6:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
c0d006f8:	7803      	ldrb	r3, [r0, #0]
c0d006fa:	061b      	lsls	r3, r3, #24
c0d006fc:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
c0d006fe:	7844      	ldrb	r4, [r0, #1]
c0d00700:	0424      	lsls	r4, r4, #16
c0d00702:	431c      	orrs	r4, r3
c0d00704:	600c      	str	r4, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
c0d00706:	7883      	ldrb	r3, [r0, #2]
c0d00708:	021b      	lsls	r3, r3, #8
c0d0070a:	4323      	orrs	r3, r4
c0d0070c:	600b      	str	r3, [r1, #0]
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
c0d0070e:	78c4      	ldrb	r4, [r0, #3]
c0d00710:	431c      	orrs	r4, r3
c0d00712:	c110      	stmia	r1!, {r4}
    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
c0d00714:	1f00      	subs	r0, r0, #4
c0d00716:	1e52      	subs	r2, r2, #1
c0d00718:	d1ec      	bne.n	c0d006f4 <bytes_to_words+0xe>
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
c0d0071a:	2000      	movs	r0, #0
c0d0071c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d00720 <trints_to_words>:
}

//custom conversion straight from trints to words
int trints_to_words(trint_t *trints_in, int32_t words_out[])
{
c0d00720:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00722:	af03      	add	r7, sp, #12
c0d00724:	b0a1      	sub	sp, #132	; 0x84
c0d00726:	9101      	str	r1, [sp, #4]
c0d00728:	9002      	str	r0, [sp, #8]
c0d0072a:	a814      	add	r0, sp, #80	; 0x50
    int32_t base[13] = {0};
c0d0072c:	2134      	movs	r1, #52	; 0x34
c0d0072e:	f003 f87f 	bl	c0d03830 <__aeabi_memclr>
c0d00732:	2430      	movs	r4, #48	; 0x30
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
c0d00734:	2603      	movs	r6, #3
c0d00736:	2005      	movs	r0, #5
c0d00738:	2c30      	cmp	r4, #48	; 0x30
c0d0073a:	d000      	beq.n	c0d0073e <trints_to_words+0x1e>
c0d0073c:	4606      	mov	r6, r0
        trint_to_trits(trints_in[x], &trits[0], get);
c0d0073e:	9802      	ldr	r0, [sp, #8]
c0d00740:	5700      	ldrsb	r0, [r0, r4]
c0d00742:	a912      	add	r1, sp, #72	; 0x48
c0d00744:	4632      	mov	r2, r6
c0d00746:	f7ff fd95 	bl	c0d00274 <trint_to_trits>
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0074a:	4833      	ldr	r0, [pc, #204]	; (c0d00818 <trints_to_words+0xf8>)
c0d0074c:	1832      	adds	r2, r6, r0
c0d0074e:	2006      	movs	r0, #6
c0d00750:	4010      	ands	r0, r2
            // multiply
            {
                int32_t sz = size;
                int32_t carry = 0;
                
                for (int32_t j = 0; j < sz; j++) {
c0d00752:	1e76      	subs	r6, r6, #1
c0d00754:	9403      	str	r4, [sp, #12]
            
            // add
            {
                int32_t tmp[12];
                // Ignore the last trit (48 is last trint, 2 is last trit in that trint)
                if (x == 48 & i == 2) {
c0d00756:	2c30      	cmp	r4, #48	; 0x30
c0d00758:	9204      	str	r2, [sp, #16]
c0d0075a:	d105      	bne.n	c0d00768 <trints_to_words+0x48>
c0d0075c:	b2b1      	uxth	r1, r6
c0d0075e:	2902      	cmp	r1, #2
c0d00760:	d102      	bne.n	c0d00768 <trints_to_words+0x48>
c0d00762:	a814      	add	r0, sp, #80	; 0x50
                    bigint_add_int(base, 1, tmp, 13);
c0d00764:	2101      	movs	r1, #1
c0d00766:	e003      	b.n	c0d00770 <trints_to_words+0x50>
c0d00768:	a912      	add	r1, sp, #72	; 0x48
                } else {
                    bigint_add_int(base, trits[i]+1, tmp, 13);
c0d0076a:	5608      	ldrsb	r0, [r1, r0]
c0d0076c:	1c41      	adds	r1, r0, #1
c0d0076e:	a814      	add	r0, sp, #80	; 0x50
c0d00770:	aa05      	add	r2, sp, #20
c0d00772:	230d      	movs	r3, #13
c0d00774:	f7ff fe1e 	bl	c0d003b4 <bigint_add_int>
c0d00778:	a805      	add	r0, sp, #20
c0d0077a:	a914      	add	r1, sp, #80	; 0x50
                }
                memcpy(base, tmp, 52);
c0d0077c:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d0077e:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00780:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00782:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00784:	c81c      	ldmia	r0!, {r2, r3, r4}
c0d00786:	c11c      	stmia	r1!, {r2, r3, r4}
c0d00788:	c83c      	ldmia	r0!, {r2, r3, r4, r5}
c0d0078a:	c13c      	stmia	r1!, {r2, r3, r4, r5}
        //if this is the last send, we are only get 3 trits
        uint8_t get = (x == 48) ? 3 : 5;
        trint_to_trits(trints_in[x], &trits[0], get);
        
        // array index is get - 1
        for (int16_t i = get-1; i >= 0; i--) {
c0d0078c:	1e76      	subs	r6, r6, #1
c0d0078e:	9804      	ldr	r0, [sp, #16]
c0d00790:	1e40      	subs	r0, r0, #1
c0d00792:	b200      	sxth	r0, r0
c0d00794:	2800      	cmp	r0, #0
c0d00796:	4602      	mov	r2, r0
c0d00798:	9c03      	ldr	r4, [sp, #12]
c0d0079a:	dadc      	bge.n	c0d00756 <trints_to_words+0x36>
    int32_t size = 13;
    trit_t trits[5]; // on final call only left 3 trits matter
    
    //instead of operating on all 243 trits at once, we will hotswap
    //5 trits at a time from our trints
    for(int8_t x = 48; x >= 0; x--) {
c0d0079c:	1e60      	subs	r0, r4, #1
c0d0079e:	2c00      	cmp	r4, #0
c0d007a0:	4604      	mov	r4, r0
c0d007a2:	dcc7      	bgt.n	c0d00734 <trints_to_words+0x14>
                // todo sz>size stuff
            }
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
c0d007a4:	481d      	ldr	r0, [pc, #116]	; (c0d0081c <trints_to_words+0xfc>)
c0d007a6:	4478      	add	r0, pc
c0d007a8:	a914      	add	r1, sp, #80	; 0x50
c0d007aa:	220d      	movs	r2, #13
c0d007ac:	f7ff fec7 	bl	c0d0053e <bigint_cmp_bigint>
c0d007b0:	2801      	cmp	r0, #1
c0d007b2:	db14      	blt.n	c0d007de <trints_to_words+0xbe>
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d007b4:	481b      	ldr	r0, [pc, #108]	; (c0d00824 <trints_to_words+0x104>)
c0d007b6:	4478      	add	r0, pc
c0d007b8:	ad14      	add	r5, sp, #80	; 0x50
c0d007ba:	ac05      	add	r4, sp, #20
c0d007bc:	260d      	movs	r6, #13
c0d007be:	4629      	mov	r1, r5
c0d007c0:	4622      	mov	r2, r4
c0d007c2:	4633      	mov	r3, r6
c0d007c4:	f7ff fe7a 	bl	c0d004bc <bigint_sub_bigint>
        bigint_not(tmp, 13);
c0d007c8:	4620      	mov	r0, r4
c0d007ca:	4631      	mov	r1, r6
c0d007cc:	f7ff fed6 	bl	c0d0057c <bigint_not>
        bigint_add_int(tmp, 1, base, 13);
c0d007d0:	2101      	movs	r1, #1
c0d007d2:	4620      	mov	r0, r4
c0d007d4:	462a      	mov	r2, r5
c0d007d6:	4633      	mov	r3, r6
c0d007d8:	f7ff fdec 	bl	c0d003b4 <bigint_add_int>
c0d007dc:	e010      	b.n	c0d00800 <trints_to_words+0xe0>
c0d007de:	ad14      	add	r5, sp, #80	; 0x50
        }
    }
    
    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
c0d007e0:	490f      	ldr	r1, [pc, #60]	; (c0d00820 <trints_to_words+0x100>)
c0d007e2:	4479      	add	r1, pc
c0d007e4:	ae05      	add	r6, sp, #20
c0d007e6:	230d      	movs	r3, #13
c0d007e8:	4628      	mov	r0, r5
c0d007ea:	4632      	mov	r2, r6
c0d007ec:	f7ff fe66 	bl	c0d004bc <bigint_sub_bigint>
        memcpy(base, tmp, 52);
c0d007f0:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d007f2:	c507      	stmia	r5!, {r0, r1, r2}
c0d007f4:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d007f6:	c507      	stmia	r5!, {r0, r1, r2}
c0d007f8:	ce07      	ldmia	r6!, {r0, r1, r2}
c0d007fa:	c507      	stmia	r5!, {r0, r1, r2}
c0d007fc:	ce0f      	ldmia	r6!, {r0, r1, r2, r3}
c0d007fe:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d00800:	a814      	add	r0, sp, #80	; 0x50
c0d00802:	9d01      	ldr	r5, [sp, #4]
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }
    
    
    memcpy(words_out, base, 48);
c0d00804:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d00806:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d00808:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0080a:	c51e      	stmia	r5!, {r1, r2, r3, r4}
c0d0080c:	c81e      	ldmia	r0!, {r1, r2, r3, r4}
c0d0080e:	c51e      	stmia	r5!, {r1, r2, r3, r4}
    return 0;
c0d00810:	2000      	movs	r0, #0
c0d00812:	b021      	add	sp, #132	; 0x84
c0d00814:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00816:	46c0      	nop			; (mov r8, r8)
c0d00818:	0000ffff 	.word	0x0000ffff
c0d0081c:	000032f6 	.word	0x000032f6
c0d00820:	000032ba 	.word	0x000032ba
c0d00824:	000032e6 	.word	0x000032e6

c0d00828 <words_to_trints>:
}

//straight from words into trints
int words_to_trints(const int32_t words_in[], trint_t *trints_out)
{
c0d00828:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0082a:	af03      	add	r7, sp, #12
c0d0082c:	b0a5      	sub	sp, #148	; 0x94
c0d0082e:	9100      	str	r1, [sp, #0]
c0d00830:	4604      	mov	r4, r0
    int32_t base[13] = {0};
c0d00832:	9408      	str	r4, [sp, #32]
c0d00834:	a818      	add	r0, sp, #96	; 0x60
c0d00836:	2134      	movs	r1, #52	; 0x34
c0d00838:	f002 fffa 	bl	c0d03830 <__aeabi_memclr>
c0d0083c:	2500      	movs	r5, #0
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
c0d0083e:	9517      	str	r5, [sp, #92]	; 0x5c
c0d00840:	a80b      	add	r0, sp, #44	; 0x2c
c0d00842:	4621      	mov	r1, r4
c0d00844:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d00846:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00848:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0084a:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d0084c:	c95c      	ldmia	r1!, {r2, r3, r4, r6}
c0d0084e:	c05c      	stmia	r0!, {r2, r3, r4, r6}
c0d00850:	20fe      	movs	r0, #254	; 0xfe
c0d00852:	43c1      	mvns	r1, r0
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
c0d00854:	9808      	ldr	r0, [sp, #32]
c0d00856:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d00858:	2800      	cmp	r0, #0
c0d0085a:	9103      	str	r1, [sp, #12]
c0d0085c:	db08      	blt.n	c0d00870 <words_to_trints+0x48>
c0d0085e:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
c0d00860:	4941      	ldr	r1, [pc, #260]	; (c0d00968 <words_to_trints+0x140>)
c0d00862:	4479      	add	r1, pc
c0d00864:	aa18      	add	r2, sp, #96	; 0x60
c0d00866:	230d      	movs	r3, #13
c0d00868:	f7ff fde9 	bl	c0d0043e <bigint_add_bigint>
c0d0086c:	9502      	str	r5, [sp, #8]
c0d0086e:	e01b      	b.n	c0d008a8 <words_to_trints+0x80>
c0d00870:	9501      	str	r5, [sp, #4]
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
c0d00872:	4608      	mov	r0, r1
c0d00874:	30fe      	adds	r0, #254	; 0xfe
c0d00876:	9017      	str	r0, [sp, #92]	; 0x5c
c0d00878:	ad0b      	add	r5, sp, #44	; 0x2c
c0d0087a:	260d      	movs	r6, #13
        bigint_not(tmp, 13);
c0d0087c:	4628      	mov	r0, r5
c0d0087e:	4631      	mov	r1, r6
c0d00880:	f7ff fe7c 	bl	c0d0057c <bigint_not>
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
c0d00884:	4935      	ldr	r1, [pc, #212]	; (c0d0095c <words_to_trints+0x134>)
c0d00886:	4479      	add	r1, pc
c0d00888:	4628      	mov	r0, r5
c0d0088a:	4632      	mov	r2, r6
c0d0088c:	f7ff fe57 	bl	c0d0053e <bigint_cmp_bigint>
c0d00890:	2801      	cmp	r0, #1
c0d00892:	db49      	blt.n	c0d00928 <words_to_trints+0x100>
c0d00894:	a80b      	add	r0, sp, #44	; 0x2c
            bigint_sub_bigint(tmp, HALF_3, base, 13);
c0d00896:	4932      	ldr	r1, [pc, #200]	; (c0d00960 <words_to_trints+0x138>)
c0d00898:	4479      	add	r1, pc
c0d0089a:	aa18      	add	r2, sp, #96	; 0x60
c0d0089c:	230d      	movs	r3, #13
c0d0089e:	f7ff fe0d 	bl	c0d004bc <bigint_sub_bigint>
c0d008a2:	2001      	movs	r0, #1
c0d008a4:	9002      	str	r0, [sp, #8]
c0d008a6:	9d01      	ldr	r5, [sp, #4]
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
c0d008a8:	2403      	movs	r4, #3
c0d008aa:	2005      	movs	r0, #5
c0d008ac:	9501      	str	r5, [sp, #4]
c0d008ae:	2d30      	cmp	r5, #48	; 0x30
c0d008b0:	d000      	beq.n	c0d008b4 <words_to_trints+0x8c>
c0d008b2:	4604      	mov	r4, r0
c0d008b4:	a809      	add	r0, sp, #36	; 0x24
        trits_to_trint(&trits[0], send);
c0d008b6:	4621      	mov	r1, r4
c0d008b8:	f7ff fc55 	bl	c0d00166 <trits_to_trint>
c0d008bc:	2000      	movs	r0, #0
c0d008be:	4601      	mov	r1, r0
c0d008c0:	9004      	str	r0, [sp, #16]
c0d008c2:	9405      	str	r4, [sp, #20]
c0d008c4:	9106      	str	r1, [sp, #24]
c0d008c6:	9007      	str	r0, [sp, #28]
c0d008c8:	250c      	movs	r5, #12
c0d008ca:	9a04      	ldr	r2, [sp, #16]
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
                uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
c0d008cc:	00a9      	lsls	r1, r5, #2
c0d008ce:	ac18      	add	r4, sp, #96	; 0x60
c0d008d0:	5860      	ldr	r0, [r4, r1]
c0d008d2:	2a00      	cmp	r2, #0
c0d008d4:	9108      	str	r1, [sp, #32]
c0d008d6:	2603      	movs	r6, #3
c0d008d8:	2300      	movs	r3, #0
                uint64_t q = (lhs / 3) & 0xFFFFFFFF;
                uint8_t r = lhs % 3;
c0d008da:	4611      	mov	r1, r2
c0d008dc:	4632      	mov	r2, r6
c0d008de:	f002 fe9d 	bl	c0d0361c <__aeabi_uldivmod>
                
                base[j] = q;
c0d008e2:	9908      	ldr	r1, [sp, #32]
c0d008e4:	5060      	str	r0, [r4, r1]
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
            rem = 0;
            for (int8_t j = 13-1; j >= 0 ; j--) {
c0d008e6:	1e68      	subs	r0, r5, #1
c0d008e8:	2d00      	cmp	r5, #0
c0d008ea:	4605      	mov	r5, r0
c0d008ec:	dcee      	bgt.n	c0d008cc <words_to_trints+0xa4>
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
            if (flip_trits) {
                trits[i] = -trits[i];
c0d008ee:	9803      	ldr	r0, [sp, #12]
c0d008f0:	1a80      	subs	r0, r0, r2
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d008f2:	32ff      	adds	r2, #255	; 0xff
            if (flip_trits) {
c0d008f4:	9902      	ldr	r1, [sp, #8]
c0d008f6:	2900      	cmp	r1, #0
c0d008f8:	d100      	bne.n	c0d008fc <words_to_trints+0xd4>
c0d008fa:	4610      	mov	r0, r2
c0d008fc:	a909      	add	r1, sp, #36	; 0x24
                uint8_t r = lhs % 3;
                
                base[j] = q;
                rem = r;
            }
            trits[i] = rem - 1;
c0d008fe:	9a06      	ldr	r2, [sp, #24]
c0d00900:	5488      	strb	r0, [r1, r2]
c0d00902:	9807      	ldr	r0, [sp, #28]
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
        //if this is the last send, we are only passing 3 trits
        uint8_t send = (x == 48) ? 3 : 5;
        trits_to_trint(&trits[0], send);
        
        for (int16_t i = 0; i < send; i++) {
c0d00904:	1c40      	adds	r0, r0, #1
c0d00906:	b201      	sxth	r1, r0
c0d00908:	9c05      	ldr	r4, [sp, #20]
c0d0090a:	42a1      	cmp	r1, r4
c0d0090c:	dbda      	blt.n	c0d008c4 <words_to_trints+0x9c>
c0d0090e:	a809      	add	r0, sp, #36	; 0x24
            if (flip_trits) {
                trits[i] = -trits[i];
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
c0d00910:	4621      	mov	r1, r4
c0d00912:	f7ff fc28 	bl	c0d00166 <trits_to_trint>
c0d00916:	9900      	ldr	r1, [sp, #0]
c0d00918:	9d01      	ldr	r5, [sp, #4]
c0d0091a:	5548      	strb	r0, [r1, r5]
    }
    
    
    uint32_t rem = 0;
    trit_t trits[5];
    for(int8_t x = 0; x < 49; x++) { // 49 trints make up 243 trits
c0d0091c:	1c6d      	adds	r5, r5, #1
c0d0091e:	2d31      	cmp	r5, #49	; 0x31
c0d00920:	d1c2      	bne.n	c0d008a8 <words_to_trints+0x80>
            }
        }
        //we are done getting 5 (or 3 trits) - so convert into trint
        trints_out[x] = trits_to_trint(&trits[0], send);
    }
    return 0;
c0d00922:	2000      	movs	r0, #0
c0d00924:	b025      	add	sp, #148	; 0x94
c0d00926:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00928:	ad0b      	add	r5, sp, #44	; 0x2c
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
c0d0092a:	2101      	movs	r1, #1
c0d0092c:	ae18      	add	r6, sp, #96	; 0x60
c0d0092e:	240d      	movs	r4, #13
c0d00930:	4628      	mov	r0, r5
c0d00932:	4632      	mov	r2, r6
c0d00934:	4623      	mov	r3, r4
c0d00936:	f7ff fd3d 	bl	c0d003b4 <bigint_add_int>
            bigint_sub_bigint(HALF_3, base, tmp, 13);
c0d0093a:	480a      	ldr	r0, [pc, #40]	; (c0d00964 <words_to_trints+0x13c>)
c0d0093c:	4478      	add	r0, pc
c0d0093e:	4631      	mov	r1, r6
c0d00940:	462a      	mov	r2, r5
c0d00942:	4623      	mov	r3, r4
c0d00944:	f7ff fdba 	bl	c0d004bc <bigint_sub_bigint>
            memcpy(base, tmp, 52);
c0d00948:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d0094a:	c607      	stmia	r6!, {r0, r1, r2}
c0d0094c:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d0094e:	c607      	stmia	r6!, {r0, r1, r2}
c0d00950:	cd07      	ldmia	r5!, {r0, r1, r2}
c0d00952:	c607      	stmia	r6!, {r0, r1, r2}
c0d00954:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
c0d00956:	c60f      	stmia	r6!, {r0, r1, r2, r3}
c0d00958:	9d01      	ldr	r5, [sp, #4]
c0d0095a:	e787      	b.n	c0d0086c <words_to_trints+0x44>
c0d0095c:	00003216 	.word	0x00003216
c0d00960:	00003204 	.word	0x00003204
c0d00964:	00003160 	.word	0x00003160
c0d00968:	0000323a 	.word	0x0000323a

c0d0096c <kerl_initialize>:
//sha3 is 424 bytes long
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
c0d0096c:	b580      	push	{r7, lr}
c0d0096e:	af00      	add	r7, sp, #0
    cx_keccak_init(&sha3, 384);
c0d00970:	2003      	movs	r0, #3
c0d00972:	01c1      	lsls	r1, r0, #7
c0d00974:	4802      	ldr	r0, [pc, #8]	; (c0d00980 <kerl_initialize+0x14>)
c0d00976:	f001 fb6d 	bl	c0d02054 <cx_keccak_init>
    return 0;
c0d0097a:	2000      	movs	r0, #0
c0d0097c:	bd80      	pop	{r7, pc}
c0d0097e:	46c0      	nop			; (mov r8, r8)
c0d00980:	20001840 	.word	0x20001840

c0d00984 <kerl_absorb_bytes>:
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
c0d00984:	b580      	push	{r7, lr}
c0d00986:	af00      	add	r7, sp, #0
c0d00988:	b082      	sub	sp, #8
c0d0098a:	460b      	mov	r3, r1
c0d0098c:	4602      	mov	r2, r0
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d0098e:	4805      	ldr	r0, [pc, #20]	; (c0d009a4 <kerl_absorb_bytes+0x20>)
c0d00990:	4669      	mov	r1, sp
c0d00992:	6008      	str	r0, [r1, #0]
c0d00994:	4804      	ldr	r0, [pc, #16]	; (c0d009a8 <kerl_absorb_bytes+0x24>)
c0d00996:	2101      	movs	r1, #1
c0d00998:	f001 fb7a 	bl	c0d02090 <cx_hash>
c0d0099c:	2000      	movs	r0, #0
    return 0;
c0d0099e:	b002      	add	sp, #8
c0d009a0:	bd80      	pop	{r7, pc}
c0d009a2:	46c0      	nop			; (mov r8, r8)
c0d009a4:	200019e8 	.word	0x200019e8
c0d009a8:	20001840 	.word	0x20001840

c0d009ac <kerl_absorb_trints>:
    return 0;
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
c0d009ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d009ae:	af03      	add	r7, sp, #12
c0d009b0:	b09b      	sub	sp, #108	; 0x6c
c0d009b2:	460e      	mov	r6, r1
c0d009b4:	4604      	mov	r4, r0
c0d009b6:	2131      	movs	r1, #49	; 0x31
    for (uint8_t i = 0; i < (len/49); i++) {
c0d009b8:	4630      	mov	r0, r6
c0d009ba:	f002 fcb9 	bl	c0d03330 <__aeabi_uidiv>
c0d009be:	2e31      	cmp	r6, #49	; 0x31
c0d009c0:	d31c      	bcc.n	c0d009fc <kerl_absorb_trints+0x50>
c0d009c2:	2500      	movs	r5, #0
c0d009c4:	9402      	str	r4, [sp, #8]
c0d009c6:	9001      	str	r0, [sp, #4]
c0d009c8:	ae0f      	add	r6, sp, #60	; 0x3c
        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
c0d009ca:	4620      	mov	r0, r4
c0d009cc:	4631      	mov	r1, r6
c0d009ce:	f7ff fea7 	bl	c0d00720 <trints_to_words>
c0d009d2:	ac03      	add	r4, sp, #12
        words_to_bytes(words, bytes, 12);
c0d009d4:	220c      	movs	r2, #12
c0d009d6:	4630      	mov	r0, r6
c0d009d8:	4621      	mov	r1, r4
c0d009da:	f7ff fe61 	bl	c0d006a0 <words_to_bytes>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d009de:	4668      	mov	r0, sp
c0d009e0:	4908      	ldr	r1, [pc, #32]	; (c0d00a04 <kerl_absorb_trints+0x58>)
c0d009e2:	6001      	str	r1, [r0, #0]
c0d009e4:	2101      	movs	r1, #1
c0d009e6:	2330      	movs	r3, #48	; 0x30
c0d009e8:	4807      	ldr	r0, [pc, #28]	; (c0d00a08 <kerl_absorb_trints+0x5c>)
c0d009ea:	4622      	mov	r2, r4
c0d009ec:	9c02      	ldr	r4, [sp, #8]
c0d009ee:	f001 fb4f 	bl	c0d02090 <cx_hash>
}

//utilize encoded format
int kerl_absorb_trints(trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len/49); i++) {
c0d009f2:	1c6d      	adds	r5, r5, #1
c0d009f4:	b2e8      	uxtb	r0, r5
c0d009f6:	9901      	ldr	r1, [sp, #4]
c0d009f8:	4288      	cmp	r0, r1
c0d009fa:	d3e5      	bcc.n	c0d009c8 <kerl_absorb_trints+0x1c>
        //Convert straight from trints to words
        trints_to_words(trints_in, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
c0d009fc:	2000      	movs	r0, #0
c0d009fe:	b01b      	add	sp, #108	; 0x6c
c0d00a00:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a02:	46c0      	nop			; (mov r8, r8)
c0d00a04:	200019e8 	.word	0x200019e8
c0d00a08:	20001840 	.word	0x20001840

c0d00a0c <kerl_squeeze_trints>:
}

//utilize encoded format
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len) {
c0d00a0c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a0e:	af03      	add	r7, sp, #12
c0d00a10:	b091      	sub	sp, #68	; 0x44
c0d00a12:	4605      	mov	r5, r0
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
c0d00a14:	4c1b      	ldr	r4, [pc, #108]	; (c0d00a84 <kerl_squeeze_trints+0x78>)
c0d00a16:	ae05      	add	r6, sp, #20
c0d00a18:	220c      	movs	r2, #12
c0d00a1a:	4620      	mov	r0, r4
c0d00a1c:	4631      	mov	r1, r6
c0d00a1e:	f7ff fe62 	bl	c0d006e6 <bytes_to_words>
    words_to_trints(words, &trints_out[0]);
c0d00a22:	4630      	mov	r0, r6
c0d00a24:	9502      	str	r5, [sp, #8]
c0d00a26:	4629      	mov	r1, r5
c0d00a28:	f7ff fefe 	bl	c0d00828 <words_to_trints>


    //-- Setting last trit to 0
    trit_t trits[3];
    //grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
c0d00a2c:	2030      	movs	r0, #48	; 0x30
c0d00a2e:	9003      	str	r0, [sp, #12]
c0d00a30:	5628      	ldrsb	r0, [r5, r0]
c0d00a32:	ad04      	add	r5, sp, #16
c0d00a34:	2203      	movs	r2, #3
c0d00a36:	9201      	str	r2, [sp, #4]
c0d00a38:	4629      	mov	r1, r5
c0d00a3a:	f7ff fc1b 	bl	c0d00274 <trint_to_trits>
c0d00a3e:	2600      	movs	r6, #0
    trits[2] = 0; //set last trit to 0
c0d00a40:	70ae      	strb	r6, [r5, #2]
    //convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);
c0d00a42:	4628      	mov	r0, r5
c0d00a44:	9d01      	ldr	r5, [sp, #4]
c0d00a46:	4629      	mov	r1, r5
c0d00a48:	f7ff fb8d 	bl	c0d00166 <trits_to_trint>
c0d00a4c:	9903      	ldr	r1, [sp, #12]
c0d00a4e:	9a02      	ldr	r2, [sp, #8]
c0d00a50:	5450      	strb	r0, [r2, r1]

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
c0d00a52:	1ba0      	subs	r0, r4, r6
c0d00a54:	7801      	ldrb	r1, [r0, #0]
c0d00a56:	43c9      	mvns	r1, r1
c0d00a58:	7001      	strb	r1, [r0, #0]
    trints_out[48] = trits_to_trint(&trits[0], 3);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
c0d00a5a:	1e76      	subs	r6, r6, #1
c0d00a5c:	4630      	mov	r0, r6
c0d00a5e:	3030      	adds	r0, #48	; 0x30
c0d00a60:	d1f7      	bne.n	c0d00a52 <kerl_squeeze_trints+0x46>
cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{
    cx_keccak_init(&sha3, 384);
c0d00a62:	01e9      	lsls	r1, r5, #7
c0d00a64:	4d08      	ldr	r5, [pc, #32]	; (c0d00a88 <kerl_squeeze_trints+0x7c>)
c0d00a66:	4628      	mov	r0, r5
c0d00a68:	f001 faf4 	bl	c0d02054 <cx_keccak_init>
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
c0d00a6c:	4668      	mov	r0, sp
c0d00a6e:	6004      	str	r4, [r0, #0]
c0d00a70:	2101      	movs	r1, #1
c0d00a72:	2330      	movs	r3, #48	; 0x30
c0d00a74:	4628      	mov	r0, r5
c0d00a76:	4622      	mov	r2, r4
c0d00a78:	f001 fb0a 	bl	c0d02090 <cx_hash>
c0d00a7c:	2000      	movs	r0, #0
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
c0d00a7e:	b011      	add	sp, #68	; 0x44
c0d00a80:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a82:	46c0      	nop			; (mov r8, r8)
c0d00a84:	200019e8 	.word	0x200019e8
c0d00a88:	20001840 	.word	0x20001840

c0d00a8c <nvram_is_init>:

return_to_dashboard:
    return;
}

bool nvram_is_init() {
c0d00a8c:	b580      	push	{r7, lr}
c0d00a8e:	af00      	add	r7, sp, #0
    if(N_storage.initialized != 0x01) return false;
c0d00a90:	4804      	ldr	r0, [pc, #16]	; (c0d00aa4 <nvram_is_init+0x18>)
c0d00a92:	f001 fa33 	bl	c0d01efc <pic>
c0d00a96:	7801      	ldrb	r1, [r0, #0]
c0d00a98:	2000      	movs	r0, #0
c0d00a9a:	2901      	cmp	r1, #1
c0d00a9c:	d100      	bne.n	c0d00aa0 <nvram_is_init+0x14>
c0d00a9e:	4608      	mov	r0, r1
    else return true;
}
c0d00aa0:	bd80      	pop	{r7, pc}
c0d00aa2:	46c0      	nop			; (mov r8, r8)
c0d00aa4:	c0d03e80 	.word	0xc0d03e80

c0d00aa8 <io_exchange_al>:
------------------- Not Modified ------------------
--------------------------------------------------- */


// seems to be called from io_exchange
unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00aa8:	b5b0      	push	{r4, r5, r7, lr}
c0d00aaa:	af02      	add	r7, sp, #8
c0d00aac:	4605      	mov	r5, r0
c0d00aae:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d00ab0:	4028      	ands	r0, r5
c0d00ab2:	2400      	movs	r4, #0
c0d00ab4:	2801      	cmp	r0, #1
c0d00ab6:	d013      	beq.n	c0d00ae0 <io_exchange_al+0x38>
c0d00ab8:	2802      	cmp	r0, #2
c0d00aba:	d113      	bne.n	c0d00ae4 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d00abc:	2900      	cmp	r1, #0
c0d00abe:	d008      	beq.n	c0d00ad2 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00ac0:	480b      	ldr	r0, [pc, #44]	; (c0d00af0 <io_exchange_al+0x48>)
c0d00ac2:	f001 fbd7 	bl	c0d02274 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d00ac6:	b268      	sxtb	r0, r5
c0d00ac8:	2800      	cmp	r0, #0
c0d00aca:	da09      	bge.n	c0d00ae0 <io_exchange_al+0x38>
                reset();
c0d00acc:	f001 fa4c 	bl	c0d01f68 <reset>
c0d00ad0:	e006      	b.n	c0d00ae0 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d00ad2:	2041      	movs	r0, #65	; 0x41
c0d00ad4:	0081      	lsls	r1, r0, #2
c0d00ad6:	4806      	ldr	r0, [pc, #24]	; (c0d00af0 <io_exchange_al+0x48>)
c0d00ad8:	2200      	movs	r2, #0
c0d00ada:	f001 fc05 	bl	c0d022e8 <io_seproxyhal_spi_recv>
c0d00ade:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00ae0:	4620      	mov	r0, r4
c0d00ae2:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d00ae4:	4803      	ldr	r0, [pc, #12]	; (c0d00af4 <io_exchange_al+0x4c>)
c0d00ae6:	6800      	ldr	r0, [r0, #0]
c0d00ae8:	2102      	movs	r1, #2
c0d00aea:	f002 ff43 	bl	c0d03974 <longjmp>
c0d00aee:	46c0      	nop			; (mov r8, r8)
c0d00af0:	20001c08 	.word	0x20001c08
c0d00af4:	20001bb8 	.word	0x20001bb8

c0d00af8 <io_seproxyhal_display>:
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00af8:	b580      	push	{r7, lr}
c0d00afa:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00afc:	f000 fe8e 	bl	c0d0181c <io_seproxyhal_display_default>
}
c0d00b00:	bd80      	pop	{r7, pc}
	...

c0d00b04 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d00b04:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b06:	af03      	add	r7, sp, #12
c0d00b08:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00b0a:	48a6      	ldr	r0, [pc, #664]	; (c0d00da4 <io_event+0x2a0>)
c0d00b0c:	7800      	ldrb	r0, [r0, #0]
c0d00b0e:	2805      	cmp	r0, #5
c0d00b10:	d02e      	beq.n	c0d00b70 <io_event+0x6c>
c0d00b12:	280d      	cmp	r0, #13
c0d00b14:	d04e      	beq.n	c0d00bb4 <io_event+0xb0>
c0d00b16:	280c      	cmp	r0, #12
c0d00b18:	d000      	beq.n	c0d00b1c <io_event+0x18>
c0d00b1a:	e13a      	b.n	c0d00d92 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00b1c:	4ea2      	ldr	r6, [pc, #648]	; (c0d00da8 <io_event+0x2a4>)
c0d00b1e:	2001      	movs	r0, #1
c0d00b20:	7630      	strb	r0, [r6, #24]
c0d00b22:	2500      	movs	r5, #0
c0d00b24:	61f5      	str	r5, [r6, #28]
c0d00b26:	4634      	mov	r4, r6
c0d00b28:	3418      	adds	r4, #24
c0d00b2a:	4620      	mov	r0, r4
c0d00b2c:	f001 fb68 	bl	c0d02200 <os_ux>
c0d00b30:	61f0      	str	r0, [r6, #28]
c0d00b32:	499e      	ldr	r1, [pc, #632]	; (c0d00dac <io_event+0x2a8>)
c0d00b34:	4288      	cmp	r0, r1
c0d00b36:	d100      	bne.n	c0d00b3a <io_event+0x36>
c0d00b38:	e12b      	b.n	c0d00d92 <io_event+0x28e>
c0d00b3a:	2800      	cmp	r0, #0
c0d00b3c:	d100      	bne.n	c0d00b40 <io_event+0x3c>
c0d00b3e:	e128      	b.n	c0d00d92 <io_event+0x28e>
c0d00b40:	499b      	ldr	r1, [pc, #620]	; (c0d00db0 <io_event+0x2ac>)
c0d00b42:	4288      	cmp	r0, r1
c0d00b44:	d000      	beq.n	c0d00b48 <io_event+0x44>
c0d00b46:	e0ac      	b.n	c0d00ca2 <io_event+0x19e>
c0d00b48:	2003      	movs	r0, #3
c0d00b4a:	7630      	strb	r0, [r6, #24]
c0d00b4c:	61f5      	str	r5, [r6, #28]
c0d00b4e:	4620      	mov	r0, r4
c0d00b50:	f001 fb56 	bl	c0d02200 <os_ux>
c0d00b54:	61f0      	str	r0, [r6, #28]
c0d00b56:	f000 fd17 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d00b5a:	60b5      	str	r5, [r6, #8]
c0d00b5c:	6830      	ldr	r0, [r6, #0]
c0d00b5e:	2800      	cmp	r0, #0
c0d00b60:	d100      	bne.n	c0d00b64 <io_event+0x60>
c0d00b62:	e116      	b.n	c0d00d92 <io_event+0x28e>
c0d00b64:	69f0      	ldr	r0, [r6, #28]
c0d00b66:	4991      	ldr	r1, [pc, #580]	; (c0d00dac <io_event+0x2a8>)
c0d00b68:	4288      	cmp	r0, r1
c0d00b6a:	d000      	beq.n	c0d00b6e <io_event+0x6a>
c0d00b6c:	e096      	b.n	c0d00c9c <io_event+0x198>
c0d00b6e:	e110      	b.n	c0d00d92 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00b70:	4d8d      	ldr	r5, [pc, #564]	; (c0d00da8 <io_event+0x2a4>)
c0d00b72:	2001      	movs	r0, #1
c0d00b74:	7628      	strb	r0, [r5, #24]
c0d00b76:	2600      	movs	r6, #0
c0d00b78:	61ee      	str	r6, [r5, #28]
c0d00b7a:	462c      	mov	r4, r5
c0d00b7c:	3418      	adds	r4, #24
c0d00b7e:	4620      	mov	r0, r4
c0d00b80:	f001 fb3e 	bl	c0d02200 <os_ux>
c0d00b84:	4601      	mov	r1, r0
c0d00b86:	61e9      	str	r1, [r5, #28]
c0d00b88:	4889      	ldr	r0, [pc, #548]	; (c0d00db0 <io_event+0x2ac>)
c0d00b8a:	4281      	cmp	r1, r0
c0d00b8c:	d15d      	bne.n	c0d00c4a <io_event+0x146>
c0d00b8e:	2003      	movs	r0, #3
c0d00b90:	7628      	strb	r0, [r5, #24]
c0d00b92:	61ee      	str	r6, [r5, #28]
c0d00b94:	4620      	mov	r0, r4
c0d00b96:	f001 fb33 	bl	c0d02200 <os_ux>
c0d00b9a:	61e8      	str	r0, [r5, #28]
c0d00b9c:	f000 fcf4 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d00ba0:	60ae      	str	r6, [r5, #8]
c0d00ba2:	6828      	ldr	r0, [r5, #0]
c0d00ba4:	2800      	cmp	r0, #0
c0d00ba6:	d100      	bne.n	c0d00baa <io_event+0xa6>
c0d00ba8:	e0f3      	b.n	c0d00d92 <io_event+0x28e>
c0d00baa:	69e8      	ldr	r0, [r5, #28]
c0d00bac:	497f      	ldr	r1, [pc, #508]	; (c0d00dac <io_event+0x2a8>)
c0d00bae:	4288      	cmp	r0, r1
c0d00bb0:	d148      	bne.n	c0d00c44 <io_event+0x140>
c0d00bb2:	e0ee      	b.n	c0d00d92 <io_event+0x28e>
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d00bb4:	4d7c      	ldr	r5, [pc, #496]	; (c0d00da8 <io_event+0x2a4>)
c0d00bb6:	6868      	ldr	r0, [r5, #4]
c0d00bb8:	68a9      	ldr	r1, [r5, #8]
c0d00bba:	4281      	cmp	r1, r0
c0d00bbc:	d300      	bcc.n	c0d00bc0 <io_event+0xbc>
c0d00bbe:	e0e8      	b.n	c0d00d92 <io_event+0x28e>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00bc0:	2001      	movs	r0, #1
c0d00bc2:	7628      	strb	r0, [r5, #24]
c0d00bc4:	2600      	movs	r6, #0
c0d00bc6:	61ee      	str	r6, [r5, #28]
c0d00bc8:	462c      	mov	r4, r5
c0d00bca:	3418      	adds	r4, #24
c0d00bcc:	4620      	mov	r0, r4
c0d00bce:	f001 fb17 	bl	c0d02200 <os_ux>
c0d00bd2:	61e8      	str	r0, [r5, #28]
c0d00bd4:	4975      	ldr	r1, [pc, #468]	; (c0d00dac <io_event+0x2a8>)
c0d00bd6:	4288      	cmp	r0, r1
c0d00bd8:	d100      	bne.n	c0d00bdc <io_event+0xd8>
c0d00bda:	e0da      	b.n	c0d00d92 <io_event+0x28e>
c0d00bdc:	2800      	cmp	r0, #0
c0d00bde:	d100      	bne.n	c0d00be2 <io_event+0xde>
c0d00be0:	e0d7      	b.n	c0d00d92 <io_event+0x28e>
c0d00be2:	4973      	ldr	r1, [pc, #460]	; (c0d00db0 <io_event+0x2ac>)
c0d00be4:	4288      	cmp	r0, r1
c0d00be6:	d000      	beq.n	c0d00bea <io_event+0xe6>
c0d00be8:	e08d      	b.n	c0d00d06 <io_event+0x202>
c0d00bea:	2003      	movs	r0, #3
c0d00bec:	7628      	strb	r0, [r5, #24]
c0d00bee:	61ee      	str	r6, [r5, #28]
c0d00bf0:	4620      	mov	r0, r4
c0d00bf2:	f001 fb05 	bl	c0d02200 <os_ux>
c0d00bf6:	61e8      	str	r0, [r5, #28]
c0d00bf8:	f000 fcc6 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d00bfc:	60ae      	str	r6, [r5, #8]
c0d00bfe:	6828      	ldr	r0, [r5, #0]
c0d00c00:	2800      	cmp	r0, #0
c0d00c02:	d100      	bne.n	c0d00c06 <io_event+0x102>
c0d00c04:	e0c5      	b.n	c0d00d92 <io_event+0x28e>
c0d00c06:	69e8      	ldr	r0, [r5, #28]
c0d00c08:	4968      	ldr	r1, [pc, #416]	; (c0d00dac <io_event+0x2a8>)
c0d00c0a:	4288      	cmp	r0, r1
c0d00c0c:	d178      	bne.n	c0d00d00 <io_event+0x1fc>
c0d00c0e:	e0c0      	b.n	c0d00d92 <io_event+0x28e>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c10:	6868      	ldr	r0, [r5, #4]
c0d00c12:	4286      	cmp	r6, r0
c0d00c14:	d300      	bcc.n	c0d00c18 <io_event+0x114>
c0d00c16:	e0bc      	b.n	c0d00d92 <io_event+0x28e>
c0d00c18:	f001 fb4a 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00c1c:	2800      	cmp	r0, #0
c0d00c1e:	d000      	beq.n	c0d00c22 <io_event+0x11e>
c0d00c20:	e0b7      	b.n	c0d00d92 <io_event+0x28e>
c0d00c22:	68a8      	ldr	r0, [r5, #8]
c0d00c24:	68e9      	ldr	r1, [r5, #12]
c0d00c26:	2438      	movs	r4, #56	; 0x38
c0d00c28:	4360      	muls	r0, r4
c0d00c2a:	682a      	ldr	r2, [r5, #0]
c0d00c2c:	1810      	adds	r0, r2, r0
c0d00c2e:	2900      	cmp	r1, #0
c0d00c30:	d100      	bne.n	c0d00c34 <io_event+0x130>
c0d00c32:	e085      	b.n	c0d00d40 <io_event+0x23c>
c0d00c34:	4788      	blx	r1
c0d00c36:	2800      	cmp	r0, #0
c0d00c38:	d000      	beq.n	c0d00c3c <io_event+0x138>
c0d00c3a:	e081      	b.n	c0d00d40 <io_event+0x23c>
c0d00c3c:	68a8      	ldr	r0, [r5, #8]
c0d00c3e:	1c46      	adds	r6, r0, #1
c0d00c40:	60ae      	str	r6, [r5, #8]
c0d00c42:	6828      	ldr	r0, [r5, #0]
c0d00c44:	2800      	cmp	r0, #0
c0d00c46:	d1e3      	bne.n	c0d00c10 <io_event+0x10c>
c0d00c48:	e0a3      	b.n	c0d00d92 <io_event+0x28e>
c0d00c4a:	6928      	ldr	r0, [r5, #16]
c0d00c4c:	2800      	cmp	r0, #0
c0d00c4e:	d100      	bne.n	c0d00c52 <io_event+0x14e>
c0d00c50:	e09f      	b.n	c0d00d92 <io_event+0x28e>
c0d00c52:	4a56      	ldr	r2, [pc, #344]	; (c0d00dac <io_event+0x2a8>)
c0d00c54:	4291      	cmp	r1, r2
c0d00c56:	d100      	bne.n	c0d00c5a <io_event+0x156>
c0d00c58:	e09b      	b.n	c0d00d92 <io_event+0x28e>
c0d00c5a:	2900      	cmp	r1, #0
c0d00c5c:	d100      	bne.n	c0d00c60 <io_event+0x15c>
c0d00c5e:	e098      	b.n	c0d00d92 <io_event+0x28e>
c0d00c60:	4950      	ldr	r1, [pc, #320]	; (c0d00da4 <io_event+0x2a0>)
c0d00c62:	78c9      	ldrb	r1, [r1, #3]
c0d00c64:	0849      	lsrs	r1, r1, #1
c0d00c66:	f000 fe1b 	bl	c0d018a0 <io_seproxyhal_button_push>
c0d00c6a:	e092      	b.n	c0d00d92 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c6c:	6870      	ldr	r0, [r6, #4]
c0d00c6e:	4285      	cmp	r5, r0
c0d00c70:	d300      	bcc.n	c0d00c74 <io_event+0x170>
c0d00c72:	e08e      	b.n	c0d00d92 <io_event+0x28e>
c0d00c74:	f001 fb1c 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00c78:	2800      	cmp	r0, #0
c0d00c7a:	d000      	beq.n	c0d00c7e <io_event+0x17a>
c0d00c7c:	e089      	b.n	c0d00d92 <io_event+0x28e>
c0d00c7e:	68b0      	ldr	r0, [r6, #8]
c0d00c80:	68f1      	ldr	r1, [r6, #12]
c0d00c82:	2438      	movs	r4, #56	; 0x38
c0d00c84:	4360      	muls	r0, r4
c0d00c86:	6832      	ldr	r2, [r6, #0]
c0d00c88:	1810      	adds	r0, r2, r0
c0d00c8a:	2900      	cmp	r1, #0
c0d00c8c:	d076      	beq.n	c0d00d7c <io_event+0x278>
c0d00c8e:	4788      	blx	r1
c0d00c90:	2800      	cmp	r0, #0
c0d00c92:	d173      	bne.n	c0d00d7c <io_event+0x278>
c0d00c94:	68b0      	ldr	r0, [r6, #8]
c0d00c96:	1c45      	adds	r5, r0, #1
c0d00c98:	60b5      	str	r5, [r6, #8]
c0d00c9a:	6830      	ldr	r0, [r6, #0]
c0d00c9c:	2800      	cmp	r0, #0
c0d00c9e:	d1e5      	bne.n	c0d00c6c <io_event+0x168>
c0d00ca0:	e077      	b.n	c0d00d92 <io_event+0x28e>
c0d00ca2:	88b0      	ldrh	r0, [r6, #4]
c0d00ca4:	9004      	str	r0, [sp, #16]
c0d00ca6:	6830      	ldr	r0, [r6, #0]
c0d00ca8:	9003      	str	r0, [sp, #12]
c0d00caa:	483e      	ldr	r0, [pc, #248]	; (c0d00da4 <io_event+0x2a0>)
c0d00cac:	4601      	mov	r1, r0
c0d00cae:	79cc      	ldrb	r4, [r1, #7]
c0d00cb0:	798b      	ldrb	r3, [r1, #6]
c0d00cb2:	794d      	ldrb	r5, [r1, #5]
c0d00cb4:	790a      	ldrb	r2, [r1, #4]
c0d00cb6:	4630      	mov	r0, r6
c0d00cb8:	78ce      	ldrb	r6, [r1, #3]
c0d00cba:	68c1      	ldr	r1, [r0, #12]
c0d00cbc:	4668      	mov	r0, sp
c0d00cbe:	6006      	str	r6, [r0, #0]
c0d00cc0:	6041      	str	r1, [r0, #4]
c0d00cc2:	0212      	lsls	r2, r2, #8
c0d00cc4:	432a      	orrs	r2, r5
c0d00cc6:	021b      	lsls	r3, r3, #8
c0d00cc8:	4323      	orrs	r3, r4
c0d00cca:	9803      	ldr	r0, [sp, #12]
c0d00ccc:	9904      	ldr	r1, [sp, #16]
c0d00cce:	f000 fcd5 	bl	c0d0167c <io_seproxyhal_touch_element_callback>
c0d00cd2:	e05e      	b.n	c0d00d92 <io_event+0x28e>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00cd4:	6868      	ldr	r0, [r5, #4]
c0d00cd6:	4286      	cmp	r6, r0
c0d00cd8:	d25b      	bcs.n	c0d00d92 <io_event+0x28e>
c0d00cda:	f001 fae9 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00cde:	2800      	cmp	r0, #0
c0d00ce0:	d157      	bne.n	c0d00d92 <io_event+0x28e>
c0d00ce2:	68a8      	ldr	r0, [r5, #8]
c0d00ce4:	68e9      	ldr	r1, [r5, #12]
c0d00ce6:	2438      	movs	r4, #56	; 0x38
c0d00ce8:	4360      	muls	r0, r4
c0d00cea:	682a      	ldr	r2, [r5, #0]
c0d00cec:	1810      	adds	r0, r2, r0
c0d00cee:	2900      	cmp	r1, #0
c0d00cf0:	d026      	beq.n	c0d00d40 <io_event+0x23c>
c0d00cf2:	4788      	blx	r1
c0d00cf4:	2800      	cmp	r0, #0
c0d00cf6:	d123      	bne.n	c0d00d40 <io_event+0x23c>
c0d00cf8:	68a8      	ldr	r0, [r5, #8]
c0d00cfa:	1c46      	adds	r6, r0, #1
c0d00cfc:	60ae      	str	r6, [r5, #8]
c0d00cfe:	6828      	ldr	r0, [r5, #0]
c0d00d00:	2800      	cmp	r0, #0
c0d00d02:	d1e7      	bne.n	c0d00cd4 <io_event+0x1d0>
c0d00d04:	e045      	b.n	c0d00d92 <io_event+0x28e>
c0d00d06:	6828      	ldr	r0, [r5, #0]
c0d00d08:	2800      	cmp	r0, #0
c0d00d0a:	d030      	beq.n	c0d00d6e <io_event+0x26a>
c0d00d0c:	68a8      	ldr	r0, [r5, #8]
c0d00d0e:	6869      	ldr	r1, [r5, #4]
c0d00d10:	4288      	cmp	r0, r1
c0d00d12:	d22c      	bcs.n	c0d00d6e <io_event+0x26a>
c0d00d14:	f001 facc 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00d18:	2800      	cmp	r0, #0
c0d00d1a:	d128      	bne.n	c0d00d6e <io_event+0x26a>
c0d00d1c:	68a8      	ldr	r0, [r5, #8]
c0d00d1e:	68e9      	ldr	r1, [r5, #12]
c0d00d20:	2438      	movs	r4, #56	; 0x38
c0d00d22:	4360      	muls	r0, r4
c0d00d24:	682a      	ldr	r2, [r5, #0]
c0d00d26:	1810      	adds	r0, r2, r0
c0d00d28:	2900      	cmp	r1, #0
c0d00d2a:	d015      	beq.n	c0d00d58 <io_event+0x254>
c0d00d2c:	4788      	blx	r1
c0d00d2e:	2800      	cmp	r0, #0
c0d00d30:	d112      	bne.n	c0d00d58 <io_event+0x254>
c0d00d32:	68a8      	ldr	r0, [r5, #8]
c0d00d34:	1c40      	adds	r0, r0, #1
c0d00d36:	60a8      	str	r0, [r5, #8]
c0d00d38:	6829      	ldr	r1, [r5, #0]
c0d00d3a:	2900      	cmp	r1, #0
c0d00d3c:	d1e7      	bne.n	c0d00d0e <io_event+0x20a>
c0d00d3e:	e016      	b.n	c0d00d6e <io_event+0x26a>
c0d00d40:	2801      	cmp	r0, #1
c0d00d42:	d103      	bne.n	c0d00d4c <io_event+0x248>
c0d00d44:	68a8      	ldr	r0, [r5, #8]
c0d00d46:	4344      	muls	r4, r0
c0d00d48:	6828      	ldr	r0, [r5, #0]
c0d00d4a:	1900      	adds	r0, r0, r4
c0d00d4c:	f000 fd66 	bl	c0d0181c <io_seproxyhal_display_default>
c0d00d50:	68a8      	ldr	r0, [r5, #8]
c0d00d52:	1c40      	adds	r0, r0, #1
c0d00d54:	60a8      	str	r0, [r5, #8]
c0d00d56:	e01c      	b.n	c0d00d92 <io_event+0x28e>
c0d00d58:	2801      	cmp	r0, #1
c0d00d5a:	d103      	bne.n	c0d00d64 <io_event+0x260>
c0d00d5c:	68a8      	ldr	r0, [r5, #8]
c0d00d5e:	4344      	muls	r4, r0
c0d00d60:	6828      	ldr	r0, [r5, #0]
c0d00d62:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00d64:	f000 fd5a 	bl	c0d0181c <io_seproxyhal_display_default>
c0d00d68:	68a8      	ldr	r0, [r5, #8]
c0d00d6a:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00d6c:	60a8      	str	r0, [r5, #8]
c0d00d6e:	6868      	ldr	r0, [r5, #4]
c0d00d70:	68a9      	ldr	r1, [r5, #8]
c0d00d72:	4281      	cmp	r1, r0
c0d00d74:	d30d      	bcc.n	c0d00d92 <io_event+0x28e>
c0d00d76:	f001 fa9b 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00d7a:	e00a      	b.n	c0d00d92 <io_event+0x28e>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d7c:	2801      	cmp	r0, #1
c0d00d7e:	d103      	bne.n	c0d00d88 <io_event+0x284>
c0d00d80:	68b0      	ldr	r0, [r6, #8]
c0d00d82:	4344      	muls	r4, r0
c0d00d84:	6830      	ldr	r0, [r6, #0]
c0d00d86:	1900      	adds	r0, r0, r4
    }
    return 0;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00d88:	f000 fd48 	bl	c0d0181c <io_seproxyhal_display_default>
c0d00d8c:	68b0      	ldr	r0, [r6, #8]
c0d00d8e:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d90:	60b0      	str	r0, [r6, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00d92:	f001 fa8d 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d00d96:	2800      	cmp	r0, #0
c0d00d98:	d101      	bne.n	c0d00d9e <io_event+0x29a>
        io_seproxyhal_general_status();
c0d00d9a:	f000 fac9 	bl	c0d01330 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00d9e:	2001      	movs	r0, #1
c0d00da0:	b005      	add	sp, #20
c0d00da2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00da4:	20001a18 	.word	0x20001a18
c0d00da8:	20001a98 	.word	0x20001a98
c0d00dac:	b0105044 	.word	0xb0105044
c0d00db0:	b0105055 	.word	0xb0105055

c0d00db4 <IOTA_main>:





static void IOTA_main(void) {
c0d00db4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00db6:	af03      	add	r7, sp, #12
c0d00db8:	b0dd      	sub	sp, #372	; 0x174
c0d00dba:	2500      	movs	r5, #0
    volatile unsigned int rx = 0;
c0d00dbc:	955c      	str	r5, [sp, #368]	; 0x170
    volatile unsigned int tx = 0;
c0d00dbe:	955b      	str	r5, [sp, #364]	; 0x16c
    volatile unsigned int flags = 0;
c0d00dc0:	955a      	str	r5, [sp, #360]	; 0x168

    //Hard coding messages saves RAM
    write_debug("Waiting for msg", 16, TYPE_STR);
c0d00dc2:	a0a1      	add	r0, pc, #644	; (adr r0, c0d01048 <IOTA_main+0x294>)
c0d00dc4:	2110      	movs	r1, #16
c0d00dc6:	2203      	movs	r2, #3
c0d00dc8:	9109      	str	r1, [sp, #36]	; 0x24
c0d00dca:	9208      	str	r2, [sp, #32]
c0d00dcc:	f7ff f96a 	bl	c0d000a4 <write_debug>
c0d00dd0:	a80e      	add	r0, sp, #56	; 0x38
c0d00dd2:	304d      	adds	r0, #77	; 0x4d
c0d00dd4:	9007      	str	r0, [sp, #28]
c0d00dd6:	a80b      	add	r0, sp, #44	; 0x2c
c0d00dd8:	1dc1      	adds	r1, r0, #7
c0d00dda:	9106      	str	r1, [sp, #24]
c0d00ddc:	1d00      	adds	r0, r0, #4
c0d00dde:	9005      	str	r0, [sp, #20]
c0d00de0:	4e9d      	ldr	r6, [pc, #628]	; (c0d01058 <IOTA_main+0x2a4>)
c0d00de2:	6830      	ldr	r0, [r6, #0]
c0d00de4:	e08d      	b.n	c0d00f02 <IOTA_main+0x14e>
c0d00de6:	489f      	ldr	r0, [pc, #636]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00de8:	7880      	ldrb	r0, [r0, #2]
                    ui_display_debug(NULL, 0, 0);
                } break;

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00dea:	4330      	orrs	r0, r6
c0d00dec:	2880      	cmp	r0, #128	; 0x80
c0d00dee:	d000      	beq.n	c0d00df2 <IOTA_main+0x3e>
c0d00df0:	e11e      	b.n	c0d01030 <IOTA_main+0x27c>
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    //if first part reset hash and all other tmp var's
                    if (hashTainted) {
c0d00df2:	7810      	ldrb	r0, [r2, #0]
c0d00df4:	2800      	cmp	r0, #0
c0d00df6:	4e98      	ldr	r6, [pc, #608]	; (c0d01058 <IOTA_main+0x2a4>)
c0d00df8:	d004      	beq.n	c0d00e04 <IOTA_main+0x50>
                        cx_sha256_init(&hash);
c0d00dfa:	489c      	ldr	r0, [pc, #624]	; (c0d0106c <IOTA_main+0x2b8>)
c0d00dfc:	f001 f90c 	bl	c0d02018 <cx_sha256_init>
                        hashTainted = 0;
c0d00e00:	4899      	ldr	r0, [pc, #612]	; (c0d01068 <IOTA_main+0x2b4>)
c0d00e02:	7004      	strb	r4, [r0, #0]
c0d00e04:	4897      	ldr	r0, [pc, #604]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00e06:	4601      	mov	r1, r0
                    }

                    // Position 5 is the start of the real data, pos 4 is
                    // the length of the data, flag off end with nullchar
                    G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00e08:	7908      	ldrb	r0, [r1, #4]
c0d00e0a:	1808      	adds	r0, r1, r0
c0d00e0c:	7144      	strb	r4, [r0, #5]

                    flags |= IO_ASYNCH_REPLY;
c0d00e0e:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00e10:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00e12:	4308      	orrs	r0, r1
c0d00e14:	905a      	str	r0, [sp, #360]	; 0x168
c0d00e16:	e0e5      	b.n	c0d00fe4 <IOTA_main+0x230>
                case INS_GET_PUBKEY: {
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
c0d00e18:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00e1a:	2818      	cmp	r0, #24
c0d00e1c:	d800      	bhi.n	c0d00e20 <IOTA_main+0x6c>
c0d00e1e:	e10c      	b.n	c0d0103a <IOTA_main+0x286>
c0d00e20:	950a      	str	r5, [sp, #40]	; 0x28
c0d00e22:	4d90      	ldr	r5, [pc, #576]	; (c0d01064 <IOTA_main+0x2b0>)
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
c0d00e24:	00a0      	lsls	r0, r4, #2
c0d00e26:	1829      	adds	r1, r5, r0
c0d00e28:	794a      	ldrb	r2, [r1, #5]
c0d00e2a:	0612      	lsls	r2, r2, #24
c0d00e2c:	798b      	ldrb	r3, [r1, #6]
c0d00e2e:	041b      	lsls	r3, r3, #16
c0d00e30:	4313      	orrs	r3, r2
c0d00e32:	79ca      	ldrb	r2, [r1, #7]
c0d00e34:	0212      	lsls	r2, r2, #8
c0d00e36:	431a      	orrs	r2, r3
c0d00e38:	7a09      	ldrb	r1, [r1, #8]
c0d00e3a:	4311      	orrs	r1, r2
c0d00e3c:	aa2b      	add	r2, sp, #172	; 0xac
c0d00e3e:	5011      	str	r1, [r2, r0]
                    /** BIP44 path, used to derive the private key from the mnemonic by calling os_perso_derive_node_bip32. */
                    unsigned char * bip44_in = G_io_apdu_buffer + APDU_HEADER_LENGTH;

                    unsigned int bip44_path[BIP44_PATH_LEN];
                    uint32_t i;
                    for (i = 0; i < BIP44_PATH_LEN; i++) {
c0d00e40:	1c64      	adds	r4, r4, #1
c0d00e42:	2c05      	cmp	r4, #5
c0d00e44:	d1ee      	bne.n	c0d00e24 <IOTA_main+0x70>
c0d00e46:	2100      	movs	r1, #0
                        bip44_path[i] = (bip44_in[0] << 24) | (bip44_in[1] << 16) | (bip44_in[2] << 8) | (bip44_in[3]);
                        bip44_in += 4;
                    }
                    unsigned char privateKeyData[32];
                    os_perso_derive_node_bip32(CX_CURVE_256K1, bip44_path, BIP44_PATH_LEN, privateKeyData, NULL);
c0d00e48:	9103      	str	r1, [sp, #12]
c0d00e4a:	4668      	mov	r0, sp
c0d00e4c:	6001      	str	r1, [r0, #0]
c0d00e4e:	2421      	movs	r4, #33	; 0x21
c0d00e50:	a92b      	add	r1, sp, #172	; 0xac
c0d00e52:	2205      	movs	r2, #5
c0d00e54:	ad23      	add	r5, sp, #140	; 0x8c
c0d00e56:	9502      	str	r5, [sp, #8]
c0d00e58:	4620      	mov	r0, r4
c0d00e5a:	462b      	mov	r3, r5
c0d00e5c:	f001 f992 	bl	c0d02184 <os_perso_derive_node_bip32>
c0d00e60:	2220      	movs	r2, #32
c0d00e62:	9204      	str	r2, [sp, #16]
c0d00e64:	ab30      	add	r3, sp, #192	; 0xc0
                    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00e66:	9301      	str	r3, [sp, #4]
c0d00e68:	4620      	mov	r0, r4
c0d00e6a:	4629      	mov	r1, r5
c0d00e6c:	f001 f94e 	bl	c0d0210c <cx_ecfp_init_private_key>
c0d00e70:	ad3a      	add	r5, sp, #232	; 0xe8

                    // generate the public key. (stored in publicKey.W)
                    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00e72:	4620      	mov	r0, r4
c0d00e74:	9903      	ldr	r1, [sp, #12]
c0d00e76:	460a      	mov	r2, r1
c0d00e78:	462b      	mov	r3, r5
c0d00e7a:	f001 f929 	bl	c0d020d0 <cx_ecfp_init_public_key>
c0d00e7e:	2301      	movs	r3, #1
                    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d00e80:	4620      	mov	r0, r4
c0d00e82:	4629      	mov	r1, r5
c0d00e84:	9a01      	ldr	r2, [sp, #4]
c0d00e86:	f001 f95f 	bl	c0d02148 <cx_ecfp_generate_pair>
c0d00e8a:	ac0e      	add	r4, sp, #56	; 0x38

                    //get_keys returns 82 chars unless manually exited = 5
                    char seed[82];
                    get_seed(privateKeyData, sizeof(privateKeyData), &seed[0]);
c0d00e8c:	9802      	ldr	r0, [sp, #8]
c0d00e8e:	9904      	ldr	r1, [sp, #16]
c0d00e90:	4622      	mov	r2, r4
c0d00e92:	f7ff fa27 	bl	c0d002e4 <get_seed>

                    // push the response onto the response buffer.
                    os_memmove(G_io_apdu_buffer, seed, 82);
c0d00e96:	2552      	movs	r5, #82	; 0x52
c0d00e98:	4872      	ldr	r0, [pc, #456]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00e9a:	4621      	mov	r1, r4
c0d00e9c:	462a      	mov	r2, r5
c0d00e9e:	f000 f9ad 	bl	c0d011fc <os_memmove>
                    tx = 82;
c0d00ea2:	955b      	str	r5, [sp, #364]	; 0x16c

                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[tx++] = 0x90;
c0d00ea4:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ea6:	1c41      	adds	r1, r0, #1
c0d00ea8:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00eaa:	3610      	adds	r6, #16
c0d00eac:	4a6d      	ldr	r2, [pc, #436]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00eae:	5416      	strb	r6, [r2, r0]
                    G_io_apdu_buffer[tx++] = 0x00;
c0d00eb0:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00eb2:	1c41      	adds	r1, r0, #1
c0d00eb4:	915b      	str	r1, [sp, #364]	; 0x16c
c0d00eb6:	9903      	ldr	r1, [sp, #12]
c0d00eb8:	5411      	strb	r1, [r2, r0]

                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00eba:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00ebc:	b281      	uxth	r1, r0
c0d00ebe:	9804      	ldr	r0, [sp, #16]
c0d00ec0:	f000 fd2a 	bl	c0d01918 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00ec4:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00ec6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00ec8:	4308      	orrs	r0, r1
c0d00eca:	905a      	str	r0, [sp, #360]	; 0x168

                    char seed_abbrv[12];

                    // - Convert into abbreviated seeed (first 4 and last 4 characters)
                    memcpy(&seed_abbrv[0], &seed[0], 4); // first 4 chars of seed
c0d00ecc:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00ece:	900b      	str	r0, [sp, #44]	; 0x2c
                    memcpy(&seed_abbrv[4], "...", 3); // copy ...
c0d00ed0:	202e      	movs	r0, #46	; 0x2e
c0d00ed2:	9905      	ldr	r1, [sp, #20]
c0d00ed4:	7048      	strb	r0, [r1, #1]
c0d00ed6:	7008      	strb	r0, [r1, #0]
c0d00ed8:	7088      	strb	r0, [r1, #2]
c0d00eda:	9907      	ldr	r1, [sp, #28]
                    memcpy(&seed_abbrv[7], &seed[77], 5); //copy last 4 chars + null
c0d00edc:	78c8      	ldrb	r0, [r1, #3]
c0d00ede:	9a06      	ldr	r2, [sp, #24]
c0d00ee0:	70d0      	strb	r0, [r2, #3]
c0d00ee2:	7888      	ldrb	r0, [r1, #2]
c0d00ee4:	7090      	strb	r0, [r2, #2]
c0d00ee6:	7848      	ldrb	r0, [r1, #1]
c0d00ee8:	7050      	strb	r0, [r2, #1]
c0d00eea:	7808      	ldrb	r0, [r1, #0]
c0d00eec:	7010      	strb	r0, [r2, #0]
c0d00eee:	7908      	ldrb	r0, [r1, #4]
c0d00ef0:	7110      	strb	r0, [r2, #4]
c0d00ef2:	a80b      	add	r0, sp, #44	; 0x2c


                    ui_display_debug(&seed_abbrv, 64, TYPE_STR);
c0d00ef4:	2140      	movs	r1, #64	; 0x40
c0d00ef6:	2203      	movs	r2, #3
c0d00ef8:	f001 fa8a 	bl	c0d02410 <ui_display_debug>
c0d00efc:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d00efe:	4e56      	ldr	r6, [pc, #344]	; (c0d01058 <IOTA_main+0x2a4>)
c0d00f00:	e070      	b.n	c0d00fe4 <IOTA_main+0x230>
c0d00f02:	a959      	add	r1, sp, #356	; 0x164
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00f04:	800d      	strh	r5, [r1, #0]

        BEGIN_TRY {
            TRY {
c0d00f06:	9057      	str	r0, [sp, #348]	; 0x15c
c0d00f08:	ac4d      	add	r4, sp, #308	; 0x134
c0d00f0a:	4620      	mov	r0, r4
c0d00f0c:	f002 fd26 	bl	c0d0395c <setjmp>
c0d00f10:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00f12:	6034      	str	r4, [r6, #0]
c0d00f14:	4951      	ldr	r1, [pc, #324]	; (c0d0105c <IOTA_main+0x2a8>)
c0d00f16:	4208      	tst	r0, r1
c0d00f18:	d011      	beq.n	c0d00f3e <IOTA_main+0x18a>
c0d00f1a:	a94d      	add	r1, sp, #308	; 0x134
                    hashTainted = 1;
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00f1c:	858d      	strh	r5, [r1, #44]	; 0x2c
c0d00f1e:	9957      	ldr	r1, [sp, #348]	; 0x15c
c0d00f20:	6031      	str	r1, [r6, #0]
c0d00f22:	210f      	movs	r1, #15
c0d00f24:	0309      	lsls	r1, r1, #12
                switch (e & 0xF000) {
c0d00f26:	4001      	ands	r1, r0
c0d00f28:	2209      	movs	r2, #9
c0d00f2a:	0312      	lsls	r2, r2, #12
c0d00f2c:	4291      	cmp	r1, r2
c0d00f2e:	d003      	beq.n	c0d00f38 <IOTA_main+0x184>
c0d00f30:	9a08      	ldr	r2, [sp, #32]
c0d00f32:	0352      	lsls	r2, r2, #13
c0d00f34:	4291      	cmp	r1, r2
c0d00f36:	d142      	bne.n	c0d00fbe <IOTA_main+0x20a>
c0d00f38:	a959      	add	r1, sp, #356	; 0x164
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00f3a:	8008      	strh	r0, [r1, #0]
c0d00f3c:	e046      	b.n	c0d00fcc <IOTA_main+0x218>
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
c0d00f3e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00f40:	905c      	str	r0, [sp, #368]	; 0x170
c0d00f42:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00f44:	945b      	str	r4, [sp, #364]	; 0x16c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00f46:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00f48:	995c      	ldr	r1, [sp, #368]	; 0x170
c0d00f4a:	b2c0      	uxtb	r0, r0
c0d00f4c:	b289      	uxth	r1, r1
c0d00f4e:	f000 fce3 	bl	c0d01918 <io_exchange>
c0d00f52:	905c      	str	r0, [sp, #368]	; 0x170

                //flags sets the IO to blocking, make sure to re-enable asynch
                flags = 0;
c0d00f54:	945a      	str	r4, [sp, #360]	; 0x168

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00f56:	985c      	ldr	r0, [sp, #368]	; 0x170
c0d00f58:	2800      	cmp	r0, #0
c0d00f5a:	d053      	beq.n	c0d01004 <IOTA_main+0x250>
c0d00f5c:	4941      	ldr	r1, [pc, #260]	; (c0d01064 <IOTA_main+0x2b0>)
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f5e:	7808      	ldrb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
                    G_io_apdu_buffer[2] = '!';


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00f60:	2680      	movs	r6, #128	; 0x80
                    THROW(0x6982);
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
c0d00f62:	2880      	cmp	r0, #128	; 0x80
c0d00f64:	4a40      	ldr	r2, [pc, #256]	; (c0d01068 <IOTA_main+0x2b4>)
c0d00f66:	d155      	bne.n	c0d01014 <IOTA_main+0x260>
c0d00f68:	7848      	ldrb	r0, [r1, #1]
c0d00f6a:	216d      	movs	r1, #109	; 0x6d
c0d00f6c:	0209      	lsls	r1, r1, #8
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check second byte for instruction
                switch (G_io_apdu_buffer[1]) {
c0d00f6e:	2807      	cmp	r0, #7
c0d00f70:	dc3f      	bgt.n	c0d00ff2 <IOTA_main+0x23e>
c0d00f72:	2802      	cmp	r0, #2
c0d00f74:	d100      	bne.n	c0d00f78 <IOTA_main+0x1c4>
c0d00f76:	e74f      	b.n	c0d00e18 <IOTA_main+0x64>
c0d00f78:	2804      	cmp	r0, #4
c0d00f7a:	d153      	bne.n	c0d01024 <IOTA_main+0x270>
                } break;


                // App told us current pubkey not right one
                case INS_BAD_PUBKEY: {
                    write_debug("Bad Pubkey", sizeof("Bad Pubkey"), TYPE_STR);
c0d00f7c:	210b      	movs	r1, #11
c0d00f7e:	2203      	movs	r2, #3
c0d00f80:	a03c      	add	r0, pc, #240	; (adr r0, c0d01074 <IOTA_main+0x2c0>)
c0d00f82:	f7ff f88f 	bl	c0d000a4 <write_debug>

                    G_io_apdu_buffer[0] = 'H';
c0d00f86:	2048      	movs	r0, #72	; 0x48
c0d00f88:	4936      	ldr	r1, [pc, #216]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00f8a:	7008      	strb	r0, [r1, #0]
                    G_io_apdu_buffer[1] = 'I';
c0d00f8c:	2049      	movs	r0, #73	; 0x49
c0d00f8e:	7048      	strb	r0, [r1, #1]
                    G_io_apdu_buffer[2] = '!';
c0d00f90:	2021      	movs	r0, #33	; 0x21
c0d00f92:	7088      	strb	r0, [r1, #2]


                    //Manually send back success 0x9000 at end
                    G_io_apdu_buffer[3] = 0x90;
c0d00f94:	3610      	adds	r6, #16
c0d00f96:	70ce      	strb	r6, [r1, #3]
                    G_io_apdu_buffer[4] = 0x00;
c0d00f98:	710c      	strb	r4, [r1, #4]

                    //send back response
                    tx = 5;
c0d00f9a:	2005      	movs	r0, #5
c0d00f9c:	905b      	str	r0, [sp, #364]	; 0x16c
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00f9e:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00fa0:	b281      	uxth	r1, r0
c0d00fa2:	2020      	movs	r0, #32
c0d00fa4:	f000 fcb8 	bl	c0d01918 <io_exchange>

                    flags |= IO_ASYNCH_REPLY;
c0d00fa8:	985a      	ldr	r0, [sp, #360]	; 0x168
c0d00faa:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00fac:	4308      	orrs	r0, r1
c0d00fae:	905a      	str	r0, [sp, #360]	; 0x168

                    ui_display_debug(NULL, 0, 0);
c0d00fb0:	4620      	mov	r0, r4
c0d00fb2:	4621      	mov	r1, r4
c0d00fb4:	4622      	mov	r2, r4
c0d00fb6:	f001 fa2b 	bl	c0d02410 <ui_display_debug>
c0d00fba:	4e27      	ldr	r6, [pc, #156]	; (c0d01058 <IOTA_main+0x2a4>)
c0d00fbc:	e012      	b.n	c0d00fe4 <IOTA_main+0x230>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00fbe:	4928      	ldr	r1, [pc, #160]	; (c0d01060 <IOTA_main+0x2ac>)
c0d00fc0:	4008      	ands	r0, r1
c0d00fc2:	210d      	movs	r1, #13
c0d00fc4:	02c9      	lsls	r1, r1, #11
c0d00fc6:	4301      	orrs	r1, r0
c0d00fc8:	a859      	add	r0, sp, #356	; 0x164
c0d00fca:	8001      	strh	r1, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00fcc:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00fce:	0a00      	lsrs	r0, r0, #8
c0d00fd0:	995b      	ldr	r1, [sp, #364]	; 0x16c
c0d00fd2:	4a24      	ldr	r2, [pc, #144]	; (c0d01064 <IOTA_main+0x2b0>)
c0d00fd4:	5450      	strb	r0, [r2, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00fd6:	9859      	ldr	r0, [sp, #356]	; 0x164
c0d00fd8:	995b      	ldr	r1, [sp, #364]	; 0x16c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00fda:	1851      	adds	r1, r2, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00fdc:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00fde:	985b      	ldr	r0, [sp, #364]	; 0x16c
c0d00fe0:	1c80      	adds	r0, r0, #2
c0d00fe2:	905b      	str	r0, [sp, #364]	; 0x16c
            }
            FINALLY {
c0d00fe4:	9857      	ldr	r0, [sp, #348]	; 0x15c
c0d00fe6:	6030      	str	r0, [r6, #0]
c0d00fe8:	a94d      	add	r1, sp, #308	; 0x134
            }
        }
        END_TRY;
c0d00fea:	8d89      	ldrh	r1, [r1, #44]	; 0x2c
c0d00fec:	2900      	cmp	r1, #0
c0d00fee:	d088      	beq.n	c0d00f02 <IOTA_main+0x14e>
c0d00ff0:	e006      	b.n	c0d01000 <IOTA_main+0x24c>
c0d00ff2:	2808      	cmp	r0, #8
c0d00ff4:	d100      	bne.n	c0d00ff8 <IOTA_main+0x244>
c0d00ff6:	e6f6      	b.n	c0d00de6 <IOTA_main+0x32>
c0d00ff8:	28ff      	cmp	r0, #255	; 0xff
c0d00ffa:	d113      	bne.n	c0d01024 <IOTA_main+0x270>
    }

return_to_dashboard:
    return;
}
c0d00ffc:	b05d      	add	sp, #372	; 0x174
c0d00ffe:	bdf0      	pop	{r4, r5, r6, r7, pc}
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d01000:	f002 fcb8 	bl	c0d03974 <longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d01004:	2001      	movs	r0, #1
c0d01006:	4918      	ldr	r1, [pc, #96]	; (c0d01068 <IOTA_main+0x2b4>)
c0d01008:	7008      	strb	r0, [r1, #0]
                    THROW(0x6982);
c0d0100a:	4813      	ldr	r0, [pc, #76]	; (c0d01058 <IOTA_main+0x2a4>)
c0d0100c:	6800      	ldr	r0, [r0, #0]
c0d0100e:	491c      	ldr	r1, [pc, #112]	; (c0d01080 <IOTA_main+0x2cc>)
c0d01010:	f002 fcb0 	bl	c0d03974 <longjmp>
                }

                // If it doesnt start with the magic byte return error
                // CLA is 0x80
                if (G_io_apdu_buffer[0] != CLA) {
                    hashTainted = 1;
c0d01014:	2001      	movs	r0, #1
c0d01016:	7010      	strb	r0, [r2, #0]
                    THROW(0x6E00);
c0d01018:	480f      	ldr	r0, [pc, #60]	; (c0d01058 <IOTA_main+0x2a4>)
c0d0101a:	6800      	ldr	r0, [r0, #0]
c0d0101c:	2137      	movs	r1, #55	; 0x37
c0d0101e:	0249      	lsls	r1, r1, #9
c0d01020:	f002 fca8 	bl	c0d03974 <longjmp>
                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                //unknown command ??
                default:
                    hashTainted = 1;
c0d01024:	2001      	movs	r0, #1
c0d01026:	7010      	strb	r0, [r2, #0]
                    THROW(0x6D00);
c0d01028:	480b      	ldr	r0, [pc, #44]	; (c0d01058 <IOTA_main+0x2a4>)
c0d0102a:	6800      	ldr	r0, [r0, #0]
c0d0102c:	f002 fca2 	bl	c0d03974 <longjmp>

                case INS_SIGN: {
                    //check third byte for instruction type
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
c0d01030:	4809      	ldr	r0, [pc, #36]	; (c0d01058 <IOTA_main+0x2a4>)
c0d01032:	6800      	ldr	r0, [r0, #0]
c0d01034:	490e      	ldr	r1, [pc, #56]	; (c0d01070 <IOTA_main+0x2bc>)
c0d01036:	f002 fc9d 	bl	c0d03974 <longjmp>
                    //sizeof = 76 publicKey, 40 privateKey
                    cx_ecfp_public_key_t publicKey;
                    cx_ecfp_private_key_t privateKey;

                    if (rx < APDU_HEADER_LENGTH + BIP44_BYTE_LENGTH) {
                        hashTainted = 1;
c0d0103a:	2001      	movs	r0, #1
c0d0103c:	7010      	strb	r0, [r2, #0]
                        THROW(0x6D09);
c0d0103e:	4806      	ldr	r0, [pc, #24]	; (c0d01058 <IOTA_main+0x2a4>)
c0d01040:	6800      	ldr	r0, [r0, #0]
c0d01042:	3109      	adds	r1, #9
c0d01044:	f002 fc96 	bl	c0d03974 <longjmp>
c0d01048:	74696157 	.word	0x74696157
c0d0104c:	20676e69 	.word	0x20676e69
c0d01050:	20726f66 	.word	0x20726f66
c0d01054:	0067736d 	.word	0x0067736d
c0d01058:	20001bb8 	.word	0x20001bb8
c0d0105c:	0000ffff 	.word	0x0000ffff
c0d01060:	000007ff 	.word	0x000007ff
c0d01064:	20001c08 	.word	0x20001c08
c0d01068:	20001b48 	.word	0x20001b48
c0d0106c:	20001b4c 	.word	0x20001b4c
c0d01070:	00006a86 	.word	0x00006a86
c0d01074:	20646142 	.word	0x20646142
c0d01078:	6b627550 	.word	0x6b627550
c0d0107c:	00007965 	.word	0x00007965
c0d01080:	00006982 	.word	0x00006982

c0d01084 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d01084:	4801      	ldr	r0, [pc, #4]	; (c0d0108c <os_boot+0x8>)
c0d01086:	2100      	movs	r1, #0
c0d01088:	6001      	str	r1, [r0, #0]
}
c0d0108a:	4770      	bx	lr
c0d0108c:	20001bb8 	.word	0x20001bb8

c0d01090 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01090:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01092:	af03      	add	r7, sp, #12
c0d01094:	b083      	sub	sp, #12
c0d01096:	9202      	str	r2, [sp, #8]
c0d01098:	460c      	mov	r4, r1
c0d0109a:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d0109c:	4d4a      	ldr	r5, [pc, #296]	; (c0d011c8 <io_usb_hid_receive+0x138>)
c0d0109e:	42ac      	cmp	r4, r5
c0d010a0:	d00f      	beq.n	c0d010c2 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d010a2:	4e49      	ldr	r6, [pc, #292]	; (c0d011c8 <io_usb_hid_receive+0x138>)
c0d010a4:	2540      	movs	r5, #64	; 0x40
c0d010a6:	4630      	mov	r0, r6
c0d010a8:	4629      	mov	r1, r5
c0d010aa:	f002 fbc1 	bl	c0d03830 <__aeabi_memclr>
c0d010ae:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d010b0:	2840      	cmp	r0, #64	; 0x40
c0d010b2:	4602      	mov	r2, r0
c0d010b4:	d300      	bcc.n	c0d010b8 <io_usb_hid_receive+0x28>
c0d010b6:	462a      	mov	r2, r5
c0d010b8:	4630      	mov	r0, r6
c0d010ba:	4621      	mov	r1, r4
c0d010bc:	f000 f89e 	bl	c0d011fc <os_memmove>
c0d010c0:	4d41      	ldr	r5, [pc, #260]	; (c0d011c8 <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d010c2:	78a8      	ldrb	r0, [r5, #2]
c0d010c4:	2805      	cmp	r0, #5
c0d010c6:	d900      	bls.n	c0d010ca <io_usb_hid_receive+0x3a>
c0d010c8:	e076      	b.n	c0d011b8 <io_usb_hid_receive+0x128>
c0d010ca:	46c0      	nop			; (mov r8, r8)
c0d010cc:	4478      	add	r0, pc
c0d010ce:	7900      	ldrb	r0, [r0, #4]
c0d010d0:	0040      	lsls	r0, r0, #1
c0d010d2:	4487      	add	pc, r0
c0d010d4:	71130c02 	.word	0x71130c02
c0d010d8:	1f71      	.short	0x1f71
c0d010da:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d010dc:	71ae      	strb	r6, [r5, #6]
c0d010de:	716e      	strb	r6, [r5, #5]
c0d010e0:	712e      	strb	r6, [r5, #4]
c0d010e2:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d010e4:	2140      	movs	r1, #64	; 0x40
c0d010e6:	4628      	mov	r0, r5
c0d010e8:	9a01      	ldr	r2, [sp, #4]
c0d010ea:	4790      	blx	r2
c0d010ec:	e00b      	b.n	c0d01106 <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d010ee:	1ce8      	adds	r0, r5, #3
c0d010f0:	2104      	movs	r1, #4
c0d010f2:	f000 ff73 	bl	c0d01fdc <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d010f6:	2140      	movs	r1, #64	; 0x40
c0d010f8:	4628      	mov	r0, r5
c0d010fa:	e001      	b.n	c0d01100 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d010fc:	4832      	ldr	r0, [pc, #200]	; (c0d011c8 <io_usb_hid_receive+0x138>)
c0d010fe:	2140      	movs	r1, #64	; 0x40
c0d01100:	9a01      	ldr	r2, [sp, #4]
c0d01102:	4790      	blx	r2
c0d01104:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01106:	4831      	ldr	r0, [pc, #196]	; (c0d011cc <io_usb_hid_receive+0x13c>)
c0d01108:	2100      	movs	r1, #0
c0d0110a:	6001      	str	r1, [r0, #0]
c0d0110c:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0110e:	b2c0      	uxtb	r0, r0
c0d01110:	b003      	add	sp, #12
c0d01112:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d01114:	78e8      	ldrb	r0, [r5, #3]
c0d01116:	4c2d      	ldr	r4, [pc, #180]	; (c0d011cc <io_usb_hid_receive+0x13c>)
c0d01118:	6821      	ldr	r1, [r4, #0]
c0d0111a:	0a09      	lsrs	r1, r1, #8
c0d0111c:	2600      	movs	r6, #0
c0d0111e:	4288      	cmp	r0, r1
c0d01120:	d1f1      	bne.n	c0d01106 <io_usb_hid_receive+0x76>
c0d01122:	7928      	ldrb	r0, [r5, #4]
c0d01124:	6821      	ldr	r1, [r4, #0]
c0d01126:	b2c9      	uxtb	r1, r1
c0d01128:	4288      	cmp	r0, r1
c0d0112a:	d1ec      	bne.n	c0d01106 <io_usb_hid_receive+0x76>
c0d0112c:	4b28      	ldr	r3, [pc, #160]	; (c0d011d0 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d0112e:	9802      	ldr	r0, [sp, #8]
c0d01130:	18c0      	adds	r0, r0, r3
c0d01132:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01134:	6820      	ldr	r0, [r4, #0]
c0d01136:	2800      	cmp	r0, #0
c0d01138:	d00e      	beq.n	c0d01158 <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0113a:	4629      	mov	r1, r5
c0d0113c:	4019      	ands	r1, r3
c0d0113e:	4825      	ldr	r0, [pc, #148]	; (c0d011d4 <io_usb_hid_receive+0x144>)
c0d01140:	6802      	ldr	r2, [r0, #0]
c0d01142:	4291      	cmp	r1, r2
c0d01144:	461e      	mov	r6, r3
c0d01146:	d900      	bls.n	c0d0114a <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d01148:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0114a:	462a      	mov	r2, r5
c0d0114c:	4032      	ands	r2, r6
c0d0114e:	4822      	ldr	r0, [pc, #136]	; (c0d011d8 <io_usb_hid_receive+0x148>)
c0d01150:	6800      	ldr	r0, [r0, #0]
c0d01152:	491d      	ldr	r1, [pc, #116]	; (c0d011c8 <io_usb_hid_receive+0x138>)
c0d01154:	1d49      	adds	r1, r1, #5
c0d01156:	e021      	b.n	c0d0119c <io_usb_hid_receive+0x10c>
c0d01158:	9301      	str	r3, [sp, #4]
c0d0115a:	491b      	ldr	r1, [pc, #108]	; (c0d011c8 <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d0115c:	7988      	ldrb	r0, [r1, #6]
c0d0115e:	7949      	ldrb	r1, [r1, #5]
c0d01160:	0209      	lsls	r1, r1, #8
c0d01162:	4301      	orrs	r1, r0
c0d01164:	481d      	ldr	r0, [pc, #116]	; (c0d011dc <io_usb_hid_receive+0x14c>)
c0d01166:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01168:	6801      	ldr	r1, [r0, #0]
c0d0116a:	2241      	movs	r2, #65	; 0x41
c0d0116c:	0092      	lsls	r2, r2, #2
c0d0116e:	4291      	cmp	r1, r2
c0d01170:	d8c9      	bhi.n	c0d01106 <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01172:	6801      	ldr	r1, [r0, #0]
c0d01174:	4817      	ldr	r0, [pc, #92]	; (c0d011d4 <io_usb_hid_receive+0x144>)
c0d01176:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01178:	4917      	ldr	r1, [pc, #92]	; (c0d011d8 <io_usb_hid_receive+0x148>)
c0d0117a:	4a19      	ldr	r2, [pc, #100]	; (c0d011e0 <io_usb_hid_receive+0x150>)
c0d0117c:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d0117e:	4919      	ldr	r1, [pc, #100]	; (c0d011e4 <io_usb_hid_receive+0x154>)
c0d01180:	9a02      	ldr	r2, [sp, #8]
c0d01182:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d01184:	4629      	mov	r1, r5
c0d01186:	9e01      	ldr	r6, [sp, #4]
c0d01188:	4031      	ands	r1, r6
c0d0118a:	6802      	ldr	r2, [r0, #0]
c0d0118c:	4291      	cmp	r1, r2
c0d0118e:	d900      	bls.n	c0d01192 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d01190:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d01192:	462a      	mov	r2, r5
c0d01194:	4032      	ands	r2, r6
c0d01196:	480c      	ldr	r0, [pc, #48]	; (c0d011c8 <io_usb_hid_receive+0x138>)
c0d01198:	1dc1      	adds	r1, r0, #7
c0d0119a:	4811      	ldr	r0, [pc, #68]	; (c0d011e0 <io_usb_hid_receive+0x150>)
c0d0119c:	f000 f82e 	bl	c0d011fc <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d011a0:	4035      	ands	r5, r6
c0d011a2:	480d      	ldr	r0, [pc, #52]	; (c0d011d8 <io_usb_hid_receive+0x148>)
c0d011a4:	6801      	ldr	r1, [r0, #0]
c0d011a6:	1949      	adds	r1, r1, r5
c0d011a8:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d011aa:	480a      	ldr	r0, [pc, #40]	; (c0d011d4 <io_usb_hid_receive+0x144>)
c0d011ac:	6801      	ldr	r1, [r0, #0]
c0d011ae:	1b49      	subs	r1, r1, r5
c0d011b0:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d011b2:	6820      	ldr	r0, [r4, #0]
c0d011b4:	1c40      	adds	r0, r0, #1
c0d011b6:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d011b8:	4806      	ldr	r0, [pc, #24]	; (c0d011d4 <io_usb_hid_receive+0x144>)
c0d011ba:	6801      	ldr	r1, [r0, #0]
c0d011bc:	2001      	movs	r0, #1
c0d011be:	2602      	movs	r6, #2
c0d011c0:	2900      	cmp	r1, #0
c0d011c2:	d1a4      	bne.n	c0d0110e <io_usb_hid_receive+0x7e>
c0d011c4:	e79f      	b.n	c0d01106 <io_usb_hid_receive+0x76>
c0d011c6:	46c0      	nop			; (mov r8, r8)
c0d011c8:	20001bbc 	.word	0x20001bbc
c0d011cc:	20001bfc 	.word	0x20001bfc
c0d011d0:	0000ffff 	.word	0x0000ffff
c0d011d4:	20001c04 	.word	0x20001c04
c0d011d8:	20001d0c 	.word	0x20001d0c
c0d011dc:	20001c00 	.word	0x20001c00
c0d011e0:	20001c08 	.word	0x20001c08
c0d011e4:	0001fff9 	.word	0x0001fff9

c0d011e8 <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d011e8:	b580      	push	{r7, lr}
c0d011ea:	af00      	add	r7, sp, #0
c0d011ec:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d011ee:	2a00      	cmp	r2, #0
c0d011f0:	d003      	beq.n	c0d011fa <os_memset+0x12>
    DSTCHAR[length] = c;
c0d011f2:	4611      	mov	r1, r2
c0d011f4:	461a      	mov	r2, r3
c0d011f6:	f002 fb25 	bl	c0d03844 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d011fa:	bd80      	pop	{r7, pc}

c0d011fc <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d011fc:	b5b0      	push	{r4, r5, r7, lr}
c0d011fe:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01200:	4288      	cmp	r0, r1
c0d01202:	d90d      	bls.n	c0d01220 <os_memmove+0x24>
    while(length--) {
c0d01204:	2a00      	cmp	r2, #0
c0d01206:	d014      	beq.n	c0d01232 <os_memmove+0x36>
c0d01208:	1e49      	subs	r1, r1, #1
c0d0120a:	4252      	negs	r2, r2
c0d0120c:	1e40      	subs	r0, r0, #1
c0d0120e:	2300      	movs	r3, #0
c0d01210:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01212:	461c      	mov	r4, r3
c0d01214:	4354      	muls	r4, r2
c0d01216:	5d0d      	ldrb	r5, [r1, r4]
c0d01218:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0121a:	1c52      	adds	r2, r2, #1
c0d0121c:	d1f9      	bne.n	c0d01212 <os_memmove+0x16>
c0d0121e:	e008      	b.n	c0d01232 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01220:	2a00      	cmp	r2, #0
c0d01222:	d006      	beq.n	c0d01232 <os_memmove+0x36>
c0d01224:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01226:	b29c      	uxth	r4, r3
c0d01228:	5d0d      	ldrb	r5, [r1, r4]
c0d0122a:	5505      	strb	r5, [r0, r4]
      l++;
c0d0122c:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0122e:	1e52      	subs	r2, r2, #1
c0d01230:	d1f9      	bne.n	c0d01226 <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01232:	bdb0      	pop	{r4, r5, r7, pc}

c0d01234 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01234:	4801      	ldr	r0, [pc, #4]	; (c0d0123c <io_usb_hid_init+0x8>)
c0d01236:	2100      	movs	r1, #0
c0d01238:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0123a:	4770      	bx	lr
c0d0123c:	20001bfc 	.word	0x20001bfc

c0d01240 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d01240:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01242:	af03      	add	r7, sp, #12
c0d01244:	b087      	sub	sp, #28
c0d01246:	9301      	str	r3, [sp, #4]
c0d01248:	9203      	str	r2, [sp, #12]
c0d0124a:	460e      	mov	r6, r1
c0d0124c:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d0124e:	2e00      	cmp	r6, #0
c0d01250:	d042      	beq.n	c0d012d8 <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d01252:	4d31      	ldr	r5, [pc, #196]	; (c0d01318 <io_usb_hid_exchange+0xd8>)
c0d01254:	2000      	movs	r0, #0
c0d01256:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01258:	4930      	ldr	r1, [pc, #192]	; (c0d0131c <io_usb_hid_exchange+0xdc>)
c0d0125a:	4831      	ldr	r0, [pc, #196]	; (c0d01320 <io_usb_hid_exchange+0xe0>)
c0d0125c:	6008      	str	r0, [r1, #0]
c0d0125e:	4c31      	ldr	r4, [pc, #196]	; (c0d01324 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01260:	1d60      	adds	r0, r4, #5
c0d01262:	213b      	movs	r1, #59	; 0x3b
c0d01264:	9005      	str	r0, [sp, #20]
c0d01266:	9102      	str	r1, [sp, #8]
c0d01268:	f002 fae2 	bl	c0d03830 <__aeabi_memclr>
c0d0126c:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d0126e:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d01270:	6828      	ldr	r0, [r5, #0]
c0d01272:	0a00      	lsrs	r0, r0, #8
c0d01274:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d01276:	6828      	ldr	r0, [r5, #0]
c0d01278:	7120      	strb	r0, [r4, #4]
c0d0127a:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d0127c:	6828      	ldr	r0, [r5, #0]
c0d0127e:	2800      	cmp	r0, #0
c0d01280:	9106      	str	r1, [sp, #24]
c0d01282:	d009      	beq.n	c0d01298 <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d01284:	293b      	cmp	r1, #59	; 0x3b
c0d01286:	460a      	mov	r2, r1
c0d01288:	d300      	bcc.n	c0d0128c <io_usb_hid_exchange+0x4c>
c0d0128a:	9a02      	ldr	r2, [sp, #8]
c0d0128c:	4823      	ldr	r0, [pc, #140]	; (c0d0131c <io_usb_hid_exchange+0xdc>)
c0d0128e:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01290:	6819      	ldr	r1, [r3, #0]
c0d01292:	9805      	ldr	r0, [sp, #20]
c0d01294:	461e      	mov	r6, r3
c0d01296:	e00a      	b.n	c0d012ae <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d01298:	0a30      	lsrs	r0, r6, #8
c0d0129a:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d0129c:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d0129e:	2039      	movs	r0, #57	; 0x39
c0d012a0:	2939      	cmp	r1, #57	; 0x39
c0d012a2:	460a      	mov	r2, r1
c0d012a4:	d300      	bcc.n	c0d012a8 <io_usb_hid_exchange+0x68>
c0d012a6:	4602      	mov	r2, r0
c0d012a8:	4e1c      	ldr	r6, [pc, #112]	; (c0d0131c <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d012aa:	6831      	ldr	r1, [r6, #0]
c0d012ac:	1de0      	adds	r0, r4, #7
c0d012ae:	9205      	str	r2, [sp, #20]
c0d012b0:	f7ff ffa4 	bl	c0d011fc <os_memmove>
c0d012b4:	4d18      	ldr	r5, [pc, #96]	; (c0d01318 <io_usb_hid_exchange+0xd8>)
c0d012b6:	6830      	ldr	r0, [r6, #0]
c0d012b8:	4631      	mov	r1, r6
c0d012ba:	9e05      	ldr	r6, [sp, #20]
c0d012bc:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d012be:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d012c0:	6828      	ldr	r0, [r5, #0]
c0d012c2:	1c40      	adds	r0, r0, #1
c0d012c4:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d012c6:	2140      	movs	r1, #64	; 0x40
c0d012c8:	4620      	mov	r0, r4
c0d012ca:	9a04      	ldr	r2, [sp, #16]
c0d012cc:	4790      	blx	r2
c0d012ce:	9806      	ldr	r0, [sp, #24]
c0d012d0:	1b86      	subs	r6, r0, r6
c0d012d2:	4815      	ldr	r0, [pc, #84]	; (c0d01328 <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d012d4:	4206      	tst	r6, r0
c0d012d6:	d1c3      	bne.n	c0d01260 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d012d8:	480f      	ldr	r0, [pc, #60]	; (c0d01318 <io_usb_hid_exchange+0xd8>)
c0d012da:	2400      	movs	r4, #0
c0d012dc:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d012de:	2080      	movs	r0, #128	; 0x80
c0d012e0:	9901      	ldr	r1, [sp, #4]
c0d012e2:	4201      	tst	r1, r0
c0d012e4:	d001      	beq.n	c0d012ea <io_usb_hid_exchange+0xaa>
    reset();
c0d012e6:	f000 fe3f 	bl	c0d01f68 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d012ea:	9801      	ldr	r0, [sp, #4]
c0d012ec:	0680      	lsls	r0, r0, #26
c0d012ee:	d40f      	bmi.n	c0d01310 <io_usb_hid_exchange+0xd0>
c0d012f0:	4c0c      	ldr	r4, [pc, #48]	; (c0d01324 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d012f2:	2140      	movs	r1, #64	; 0x40
c0d012f4:	4620      	mov	r0, r4
c0d012f6:	9a03      	ldr	r2, [sp, #12]
c0d012f8:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d012fa:	b2c2      	uxtb	r2, r0
c0d012fc:	2a40      	cmp	r2, #64	; 0x40
c0d012fe:	d8f8      	bhi.n	c0d012f2 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d01300:	9804      	ldr	r0, [sp, #16]
c0d01302:	4621      	mov	r1, r4
c0d01304:	f7ff fec4 	bl	c0d01090 <io_usb_hid_receive>
c0d01308:	2802      	cmp	r0, #2
c0d0130a:	d1f2      	bne.n	c0d012f2 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d0130c:	4807      	ldr	r0, [pc, #28]	; (c0d0132c <io_usb_hid_exchange+0xec>)
c0d0130e:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d01310:	b2a0      	uxth	r0, r4
c0d01312:	b007      	add	sp, #28
c0d01314:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01316:	46c0      	nop			; (mov r8, r8)
c0d01318:	20001bfc 	.word	0x20001bfc
c0d0131c:	20001d0c 	.word	0x20001d0c
c0d01320:	20001c08 	.word	0x20001c08
c0d01324:	20001bbc 	.word	0x20001bbc
c0d01328:	0000ffff 	.word	0x0000ffff
c0d0132c:	20001c00 	.word	0x20001c00

c0d01330 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d01330:	b580      	push	{r7, lr}
c0d01332:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01334:	f000 ffbc 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d01338:	2800      	cmp	r0, #0
c0d0133a:	d10b      	bne.n	c0d01354 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d0133c:	4806      	ldr	r0, [pc, #24]	; (c0d01358 <io_seproxyhal_general_status+0x28>)
c0d0133e:	2160      	movs	r1, #96	; 0x60
c0d01340:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01342:	2100      	movs	r1, #0
c0d01344:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01346:	2202      	movs	r2, #2
c0d01348:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d0134a:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d0134c:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0134e:	2105      	movs	r1, #5
c0d01350:	f000 ff90 	bl	c0d02274 <io_seproxyhal_spi_send>
}
c0d01354:	bd80      	pop	{r7, pc}
c0d01356:	46c0      	nop			; (mov r8, r8)
c0d01358:	20001a18 	.word	0x20001a18

c0d0135c <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d0135c:	b5d0      	push	{r4, r6, r7, lr}
c0d0135e:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01360:	4815      	ldr	r0, [pc, #84]	; (c0d013b8 <io_seproxyhal_handle_usb_event+0x5c>)
c0d01362:	78c0      	ldrb	r0, [r0, #3]
c0d01364:	1e40      	subs	r0, r0, #1
c0d01366:	2807      	cmp	r0, #7
c0d01368:	d824      	bhi.n	c0d013b4 <io_seproxyhal_handle_usb_event+0x58>
c0d0136a:	46c0      	nop			; (mov r8, r8)
c0d0136c:	4478      	add	r0, pc
c0d0136e:	7900      	ldrb	r0, [r0, #4]
c0d01370:	0040      	lsls	r0, r0, #1
c0d01372:	4487      	add	pc, r0
c0d01374:	141f1803 	.word	0x141f1803
c0d01378:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d0137c:	4c0f      	ldr	r4, [pc, #60]	; (c0d013bc <io_seproxyhal_handle_usb_event+0x60>)
c0d0137e:	2101      	movs	r1, #1
c0d01380:	4620      	mov	r0, r4
c0d01382:	f001 fbd5 	bl	c0d02b30 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01386:	4620      	mov	r0, r4
c0d01388:	f001 fbba 	bl	c0d02b00 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d0138c:	480c      	ldr	r0, [pc, #48]	; (c0d013c0 <io_seproxyhal_handle_usb_event+0x64>)
c0d0138e:	7800      	ldrb	r0, [r0, #0]
c0d01390:	2801      	cmp	r0, #1
c0d01392:	d10f      	bne.n	c0d013b4 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d01394:	480b      	ldr	r0, [pc, #44]	; (c0d013c4 <io_seproxyhal_handle_usb_event+0x68>)
c0d01396:	6800      	ldr	r0, [r0, #0]
c0d01398:	2110      	movs	r1, #16
c0d0139a:	f002 faeb 	bl	c0d03974 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d0139e:	4807      	ldr	r0, [pc, #28]	; (c0d013bc <io_seproxyhal_handle_usb_event+0x60>)
c0d013a0:	f001 fbc9 	bl	c0d02b36 <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d013a4:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d013a6:	4805      	ldr	r0, [pc, #20]	; (c0d013bc <io_seproxyhal_handle_usb_event+0x60>)
c0d013a8:	f001 fbc9 	bl	c0d02b3e <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d013ac:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d013ae:	4803      	ldr	r0, [pc, #12]	; (c0d013bc <io_seproxyhal_handle_usb_event+0x60>)
c0d013b0:	f001 fbc3 	bl	c0d02b3a <USBD_LL_Resume>
      break;
  }
}
c0d013b4:	bdd0      	pop	{r4, r6, r7, pc}
c0d013b6:	46c0      	nop			; (mov r8, r8)
c0d013b8:	20001a18 	.word	0x20001a18
c0d013bc:	20001d34 	.word	0x20001d34
c0d013c0:	20001d10 	.word	0x20001d10
c0d013c4:	20001bb8 	.word	0x20001bb8

c0d013c8 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d013c8:	217f      	movs	r1, #127	; 0x7f
c0d013ca:	4001      	ands	r1, r0
c0d013cc:	4801      	ldr	r0, [pc, #4]	; (c0d013d4 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d013ce:	5c40      	ldrb	r0, [r0, r1]
c0d013d0:	4770      	bx	lr
c0d013d2:	46c0      	nop			; (mov r8, r8)
c0d013d4:	20001d11 	.word	0x20001d11

c0d013d8 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d013d8:	b580      	push	{r7, lr}
c0d013da:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d013dc:	480f      	ldr	r0, [pc, #60]	; (c0d0141c <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d013de:	7901      	ldrb	r1, [r0, #4]
c0d013e0:	2904      	cmp	r1, #4
c0d013e2:	d008      	beq.n	c0d013f6 <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d013e4:	2902      	cmp	r1, #2
c0d013e6:	d011      	beq.n	c0d0140c <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d013e8:	2901      	cmp	r1, #1
c0d013ea:	d10e      	bne.n	c0d0140a <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d013ec:	1d81      	adds	r1, r0, #6
c0d013ee:	480d      	ldr	r0, [pc, #52]	; (c0d01424 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d013f0:	f001 faaa 	bl	c0d02948 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d013f4:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d013f6:	78c2      	ldrb	r2, [r0, #3]
c0d013f8:	217f      	movs	r1, #127	; 0x7f
c0d013fa:	4011      	ands	r1, r2
c0d013fc:	7942      	ldrb	r2, [r0, #5]
c0d013fe:	4b08      	ldr	r3, [pc, #32]	; (c0d01420 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d01400:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01402:	1d82      	adds	r2, r0, #6
c0d01404:	4807      	ldr	r0, [pc, #28]	; (c0d01424 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01406:	f001 fad1 	bl	c0d029ac <USBD_LL_DataOutStage>
      break;
  }
}
c0d0140a:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d0140c:	78c2      	ldrb	r2, [r0, #3]
c0d0140e:	217f      	movs	r1, #127	; 0x7f
c0d01410:	4011      	ands	r1, r2
c0d01412:	1d82      	adds	r2, r0, #6
c0d01414:	4803      	ldr	r0, [pc, #12]	; (c0d01424 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d01416:	f001 fb0f 	bl	c0d02a38 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d0141a:	bd80      	pop	{r7, pc}
c0d0141c:	20001a18 	.word	0x20001a18
c0d01420:	20001d11 	.word	0x20001d11
c0d01424:	20001d34 	.word	0x20001d34

c0d01428 <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01428:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0142a:	af03      	add	r7, sp, #12
c0d0142c:	b083      	sub	sp, #12
c0d0142e:	9201      	str	r2, [sp, #4]
c0d01430:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d01432:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d01434:	2b00      	cmp	r3, #0
c0d01436:	d100      	bne.n	c0d0143a <io_usb_send_ep+0x12>
c0d01438:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d0143a:	9801      	ldr	r0, [sp, #4]
c0d0143c:	28ff      	cmp	r0, #255	; 0xff
c0d0143e:	d843      	bhi.n	c0d014c8 <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01440:	4e25      	ldr	r6, [pc, #148]	; (c0d014d8 <io_usb_send_ep+0xb0>)
c0d01442:	2050      	movs	r0, #80	; 0x50
c0d01444:	7030      	strb	r0, [r6, #0]
c0d01446:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01448:	1ce0      	adds	r0, r4, #3
c0d0144a:	9100      	str	r1, [sp, #0]
c0d0144c:	0a01      	lsrs	r1, r0, #8
c0d0144e:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01450:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01452:	2080      	movs	r0, #128	; 0x80
c0d01454:	4302      	orrs	r2, r0
c0d01456:	9202      	str	r2, [sp, #8]
c0d01458:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0145a:	2020      	movs	r0, #32
c0d0145c:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0145e:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01460:	2106      	movs	r1, #6
c0d01462:	4630      	mov	r0, r6
c0d01464:	f000 ff06 	bl	c0d02274 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01468:	9800      	ldr	r0, [sp, #0]
c0d0146a:	4621      	mov	r1, r4
c0d0146c:	f000 ff02 	bl	c0d02274 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d01470:	2d00      	cmp	r5, #0
c0d01472:	d10d      	bne.n	c0d01490 <io_usb_send_ep+0x68>
c0d01474:	e028      	b.n	c0d014c8 <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d01476:	2d00      	cmp	r5, #0
c0d01478:	d002      	beq.n	c0d01480 <io_usb_send_ep+0x58>
c0d0147a:	1e6c      	subs	r4, r5, #1
c0d0147c:	2d01      	cmp	r5, #1
c0d0147e:	d025      	beq.n	c0d014cc <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d01480:	2915      	cmp	r1, #21
c0d01482:	d102      	bne.n	c0d0148a <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d01484:	79b0      	ldrb	r0, [r6, #6]
c0d01486:	0700      	lsls	r0, r0, #28
c0d01488:	d520      	bpl.n	c0d014cc <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d0148a:	f000 f829 	bl	c0d014e0 <io_seproxyhal_handle_event>
c0d0148e:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01490:	f000 ff0e 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d01494:	2800      	cmp	r0, #0
c0d01496:	d101      	bne.n	c0d0149c <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d01498:	f7ff ff4a 	bl	c0d01330 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0149c:	2180      	movs	r1, #128	; 0x80
c0d0149e:	2400      	movs	r4, #0
c0d014a0:	4630      	mov	r0, r6
c0d014a2:	4622      	mov	r2, r4
c0d014a4:	f000 ff20 	bl	c0d022e8 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d014a8:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d014aa:	2806      	cmp	r0, #6
c0d014ac:	d1e3      	bne.n	c0d01476 <io_usb_send_ep+0x4e>
c0d014ae:	2910      	cmp	r1, #16
c0d014b0:	d1e1      	bne.n	c0d01476 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d014b2:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d014b4:	9a02      	ldr	r2, [sp, #8]
c0d014b6:	4290      	cmp	r0, r2
c0d014b8:	d1dd      	bne.n	c0d01476 <io_usb_send_ep+0x4e>
c0d014ba:	7930      	ldrb	r0, [r6, #4]
c0d014bc:	2802      	cmp	r0, #2
c0d014be:	d1da      	bne.n	c0d01476 <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d014c0:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d014c2:	9a01      	ldr	r2, [sp, #4]
c0d014c4:	4290      	cmp	r0, r2
c0d014c6:	d1d6      	bne.n	c0d01476 <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d014c8:	b003      	add	sp, #12
c0d014ca:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014cc:	4803      	ldr	r0, [pc, #12]	; (c0d014dc <io_usb_send_ep+0xb4>)
c0d014ce:	6800      	ldr	r0, [r0, #0]
c0d014d0:	2110      	movs	r1, #16
c0d014d2:	f002 fa4f 	bl	c0d03974 <longjmp>
c0d014d6:	46c0      	nop			; (mov r8, r8)
c0d014d8:	20001a18 	.word	0x20001a18
c0d014dc:	20001bb8 	.word	0x20001bb8

c0d014e0 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d014e0:	b580      	push	{r7, lr}
c0d014e2:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d014e4:	480d      	ldr	r0, [pc, #52]	; (c0d0151c <io_seproxyhal_handle_event+0x3c>)
c0d014e6:	7882      	ldrb	r2, [r0, #2]
c0d014e8:	7841      	ldrb	r1, [r0, #1]
c0d014ea:	0209      	lsls	r1, r1, #8
c0d014ec:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d014ee:	7800      	ldrb	r0, [r0, #0]
c0d014f0:	2810      	cmp	r0, #16
c0d014f2:	d008      	beq.n	c0d01506 <io_seproxyhal_handle_event+0x26>
c0d014f4:	280f      	cmp	r0, #15
c0d014f6:	d10d      	bne.n	c0d01514 <io_seproxyhal_handle_event+0x34>
c0d014f8:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d014fa:	2904      	cmp	r1, #4
c0d014fc:	d10d      	bne.n	c0d0151a <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d014fe:	f7ff ff2d 	bl	c0d0135c <io_seproxyhal_handle_usb_event>
c0d01502:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01504:	bd80      	pop	{r7, pc}
c0d01506:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d01508:	2906      	cmp	r1, #6
c0d0150a:	d306      	bcc.n	c0d0151a <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d0150c:	f7ff ff64 	bl	c0d013d8 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01510:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d01512:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d01514:	2002      	movs	r0, #2
c0d01516:	f7ff faf5 	bl	c0d00b04 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d0151a:	bd80      	pop	{r7, pc}
c0d0151c:	20001a18 	.word	0x20001a18

c0d01520 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01520:	b580      	push	{r7, lr}
c0d01522:	af00      	add	r7, sp, #0
c0d01524:	460a      	mov	r2, r1
c0d01526:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01528:	2082      	movs	r0, #130	; 0x82
c0d0152a:	2314      	movs	r3, #20
c0d0152c:	f7ff ff7c 	bl	c0d01428 <io_usb_send_ep>
}
c0d01530:	bd80      	pop	{r7, pc}
	...

c0d01534 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d01534:	b5d0      	push	{r4, r6, r7, lr}
c0d01536:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01538:	2007      	movs	r0, #7
c0d0153a:	f000 fcf7 	bl	c0d01f2c <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d0153e:	480a      	ldr	r0, [pc, #40]	; (c0d01568 <io_seproxyhal_init+0x34>)
c0d01540:	2400      	movs	r4, #0
c0d01542:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d01544:	4809      	ldr	r0, [pc, #36]	; (c0d0156c <io_seproxyhal_init+0x38>)
c0d01546:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01548:	4809      	ldr	r0, [pc, #36]	; (c0d01570 <io_seproxyhal_init+0x3c>)
c0d0154a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d0154c:	4809      	ldr	r0, [pc, #36]	; (c0d01574 <io_seproxyhal_init+0x40>)
c0d0154e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01550:	4809      	ldr	r0, [pc, #36]	; (c0d01578 <io_seproxyhal_init+0x44>)
c0d01552:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01554:	f7ff fe6e 	bl	c0d01234 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01558:	4808      	ldr	r0, [pc, #32]	; (c0d0157c <io_seproxyhal_init+0x48>)
c0d0155a:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d0155c:	4808      	ldr	r0, [pc, #32]	; (c0d01580 <io_seproxyhal_init+0x4c>)
c0d0155e:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01560:	4808      	ldr	r0, [pc, #32]	; (c0d01584 <io_seproxyhal_init+0x50>)
c0d01562:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01564:	bdd0      	pop	{r4, r6, r7, pc}
c0d01566:	46c0      	nop			; (mov r8, r8)
c0d01568:	20001d18 	.word	0x20001d18
c0d0156c:	20001d1a 	.word	0x20001d1a
c0d01570:	20001d1c 	.word	0x20001d1c
c0d01574:	20001d1e 	.word	0x20001d1e
c0d01578:	20001d10 	.word	0x20001d10
c0d0157c:	20001d20 	.word	0x20001d20
c0d01580:	20001d24 	.word	0x20001d24
c0d01584:	20001d28 	.word	0x20001d28

c0d01588 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01588:	4801      	ldr	r0, [pc, #4]	; (c0d01590 <io_seproxyhal_init_ux+0x8>)
c0d0158a:	2100      	movs	r1, #0
c0d0158c:	6001      	str	r1, [r0, #0]

}
c0d0158e:	4770      	bx	lr
c0d01590:	20001d20 	.word	0x20001d20

c0d01594 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01594:	b5b0      	push	{r4, r5, r7, lr}
c0d01596:	af02      	add	r7, sp, #8
c0d01598:	460d      	mov	r5, r1
c0d0159a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d0159c:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d0159e:	2800      	cmp	r0, #0
c0d015a0:	d00c      	beq.n	c0d015bc <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d015a2:	f000 fcab 	bl	c0d01efc <pic>
c0d015a6:	4601      	mov	r1, r0
c0d015a8:	4620      	mov	r0, r4
c0d015aa:	4788      	blx	r1
c0d015ac:	f000 fca6 	bl	c0d01efc <pic>
c0d015b0:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d015b2:	2800      	cmp	r0, #0
c0d015b4:	d010      	beq.n	c0d015d8 <io_seproxyhal_touch_out+0x44>
c0d015b6:	2801      	cmp	r0, #1
c0d015b8:	d000      	beq.n	c0d015bc <io_seproxyhal_touch_out+0x28>
c0d015ba:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d015bc:	2d00      	cmp	r5, #0
c0d015be:	d007      	beq.n	c0d015d0 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d015c0:	4620      	mov	r0, r4
c0d015c2:	47a8      	blx	r5
c0d015c4:	2100      	movs	r1, #0
    if (!el) {
c0d015c6:	2800      	cmp	r0, #0
c0d015c8:	d006      	beq.n	c0d015d8 <io_seproxyhal_touch_out+0x44>
c0d015ca:	2801      	cmp	r0, #1
c0d015cc:	d000      	beq.n	c0d015d0 <io_seproxyhal_touch_out+0x3c>
c0d015ce:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d015d0:	4620      	mov	r0, r4
c0d015d2:	f7ff fa91 	bl	c0d00af8 <io_seproxyhal_display>
c0d015d6:	2101      	movs	r1, #1
  return 1;
}
c0d015d8:	4608      	mov	r0, r1
c0d015da:	bdb0      	pop	{r4, r5, r7, pc}

c0d015dc <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d015dc:	b5b0      	push	{r4, r5, r7, lr}
c0d015de:	af02      	add	r7, sp, #8
c0d015e0:	b08e      	sub	sp, #56	; 0x38
c0d015e2:	460c      	mov	r4, r1
c0d015e4:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d015e6:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d015e8:	2800      	cmp	r0, #0
c0d015ea:	d00c      	beq.n	c0d01606 <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d015ec:	f000 fc86 	bl	c0d01efc <pic>
c0d015f0:	4601      	mov	r1, r0
c0d015f2:	4628      	mov	r0, r5
c0d015f4:	4788      	blx	r1
c0d015f6:	f000 fc81 	bl	c0d01efc <pic>
c0d015fa:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d015fc:	2800      	cmp	r0, #0
c0d015fe:	d016      	beq.n	c0d0162e <io_seproxyhal_touch_over+0x52>
c0d01600:	2801      	cmp	r0, #1
c0d01602:	d000      	beq.n	c0d01606 <io_seproxyhal_touch_over+0x2a>
c0d01604:	4605      	mov	r5, r0
c0d01606:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01608:	2238      	movs	r2, #56	; 0x38
c0d0160a:	4629      	mov	r1, r5
c0d0160c:	f7ff fdf6 	bl	c0d011fc <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01610:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d01612:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01614:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01616:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d01618:	2c00      	cmp	r4, #0
c0d0161a:	d004      	beq.n	c0d01626 <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d0161c:	4628      	mov	r0, r5
c0d0161e:	47a0      	blx	r4
c0d01620:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01622:	2800      	cmp	r0, #0
c0d01624:	d003      	beq.n	c0d0162e <io_seproxyhal_touch_over+0x52>
c0d01626:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d01628:	f7ff fa66 	bl	c0d00af8 <io_seproxyhal_display>
c0d0162c:	2101      	movs	r1, #1
  return 1;
}
c0d0162e:	4608      	mov	r0, r1
c0d01630:	b00e      	add	sp, #56	; 0x38
c0d01632:	bdb0      	pop	{r4, r5, r7, pc}

c0d01634 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01634:	b5b0      	push	{r4, r5, r7, lr}
c0d01636:	af02      	add	r7, sp, #8
c0d01638:	460d      	mov	r5, r1
c0d0163a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d0163c:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d0163e:	2800      	cmp	r0, #0
c0d01640:	d00c      	beq.n	c0d0165c <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01642:	f000 fc5b 	bl	c0d01efc <pic>
c0d01646:	4601      	mov	r1, r0
c0d01648:	4620      	mov	r0, r4
c0d0164a:	4788      	blx	r1
c0d0164c:	f000 fc56 	bl	c0d01efc <pic>
c0d01650:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01652:	2800      	cmp	r0, #0
c0d01654:	d010      	beq.n	c0d01678 <io_seproxyhal_touch_tap+0x44>
c0d01656:	2801      	cmp	r0, #1
c0d01658:	d000      	beq.n	c0d0165c <io_seproxyhal_touch_tap+0x28>
c0d0165a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d0165c:	2d00      	cmp	r5, #0
c0d0165e:	d007      	beq.n	c0d01670 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d01660:	4620      	mov	r0, r4
c0d01662:	47a8      	blx	r5
c0d01664:	2100      	movs	r1, #0
    if (!el) {
c0d01666:	2800      	cmp	r0, #0
c0d01668:	d006      	beq.n	c0d01678 <io_seproxyhal_touch_tap+0x44>
c0d0166a:	2801      	cmp	r0, #1
c0d0166c:	d000      	beq.n	c0d01670 <io_seproxyhal_touch_tap+0x3c>
c0d0166e:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01670:	4620      	mov	r0, r4
c0d01672:	f7ff fa41 	bl	c0d00af8 <io_seproxyhal_display>
c0d01676:	2101      	movs	r1, #1
  return 1;
}
c0d01678:	4608      	mov	r0, r1
c0d0167a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0167c <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d0167c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0167e:	af03      	add	r7, sp, #12
c0d01680:	b087      	sub	sp, #28
c0d01682:	9302      	str	r3, [sp, #8]
c0d01684:	9203      	str	r2, [sp, #12]
c0d01686:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01688:	2900      	cmp	r1, #0
c0d0168a:	d076      	beq.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
c0d0168c:	9004      	str	r0, [sp, #16]
c0d0168e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01690:	9001      	str	r0, [sp, #4]
c0d01692:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01694:	9000      	str	r0, [sp, #0]
c0d01696:	2600      	movs	r6, #0
c0d01698:	9606      	str	r6, [sp, #24]
c0d0169a:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0169c:	f000 fe08 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d016a0:	2800      	cmp	r0, #0
c0d016a2:	d155      	bne.n	c0d01750 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d016a4:	2038      	movs	r0, #56	; 0x38
c0d016a6:	4370      	muls	r0, r6
c0d016a8:	9d04      	ldr	r5, [sp, #16]
c0d016aa:	182e      	adds	r6, r5, r0
c0d016ac:	4b36      	ldr	r3, [pc, #216]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d016ae:	681a      	ldr	r2, [r3, #0]
c0d016b0:	2101      	movs	r1, #1
c0d016b2:	4296      	cmp	r6, r2
c0d016b4:	d000      	beq.n	c0d016b8 <io_seproxyhal_touch_element_callback+0x3c>
c0d016b6:	9906      	ldr	r1, [sp, #24]
c0d016b8:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d016ba:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d016bc:	2800      	cmp	r0, #0
c0d016be:	da41      	bge.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
c0d016c0:	2020      	movs	r0, #32
c0d016c2:	5c35      	ldrb	r5, [r6, r0]
c0d016c4:	2102      	movs	r1, #2
c0d016c6:	5e71      	ldrsh	r1, [r6, r1]
c0d016c8:	1b4a      	subs	r2, r1, r5
c0d016ca:	9803      	ldr	r0, [sp, #12]
c0d016cc:	4282      	cmp	r2, r0
c0d016ce:	dc39      	bgt.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
c0d016d0:	1869      	adds	r1, r5, r1
c0d016d2:	88f2      	ldrh	r2, [r6, #6]
c0d016d4:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d016d6:	9803      	ldr	r0, [sp, #12]
c0d016d8:	4288      	cmp	r0, r1
c0d016da:	da33      	bge.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
c0d016dc:	2104      	movs	r1, #4
c0d016de:	5e70      	ldrsh	r0, [r6, r1]
c0d016e0:	1b42      	subs	r2, r0, r5
c0d016e2:	9902      	ldr	r1, [sp, #8]
c0d016e4:	428a      	cmp	r2, r1
c0d016e6:	dc2d      	bgt.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
c0d016e8:	1940      	adds	r0, r0, r5
c0d016ea:	8931      	ldrh	r1, [r6, #8]
c0d016ec:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d016ee:	9902      	ldr	r1, [sp, #8]
c0d016f0:	4281      	cmp	r1, r0
c0d016f2:	da27      	bge.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d016f4:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d016f6:	4286      	cmp	r6, r0
c0d016f8:	d010      	beq.n	c0d0171c <io_seproxyhal_touch_element_callback+0xa0>
c0d016fa:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d016fc:	2800      	cmp	r0, #0
c0d016fe:	d00d      	beq.n	c0d0171c <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01700:	9801      	ldr	r0, [sp, #4]
c0d01702:	2800      	cmp	r0, #0
c0d01704:	d005      	beq.n	c0d01712 <io_seproxyhal_touch_element_callback+0x96>
c0d01706:	4630      	mov	r0, r6
c0d01708:	9901      	ldr	r1, [sp, #4]
c0d0170a:	4788      	blx	r1
c0d0170c:	4b1e      	ldr	r3, [pc, #120]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d0170e:	2800      	cmp	r0, #0
c0d01710:	d018      	beq.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01712:	6818      	ldr	r0, [r3, #0]
c0d01714:	9901      	ldr	r1, [sp, #4]
c0d01716:	f7ff ff3d 	bl	c0d01594 <io_seproxyhal_touch_out>
c0d0171a:	e008      	b.n	c0d0172e <io_seproxyhal_touch_element_callback+0xb2>
c0d0171c:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d0171e:	2801      	cmp	r0, #1
c0d01720:	d009      	beq.n	c0d01736 <io_seproxyhal_touch_element_callback+0xba>
c0d01722:	2802      	cmp	r0, #2
c0d01724:	d10e      	bne.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01726:	4630      	mov	r0, r6
c0d01728:	9901      	ldr	r1, [sp, #4]
c0d0172a:	f7ff ff83 	bl	c0d01634 <io_seproxyhal_touch_tap>
c0d0172e:	4b16      	ldr	r3, [pc, #88]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01730:	2800      	cmp	r0, #0
c0d01732:	d007      	beq.n	c0d01744 <io_seproxyhal_touch_element_callback+0xc8>
c0d01734:	e023      	b.n	c0d0177e <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01736:	4630      	mov	r0, r6
c0d01738:	9901      	ldr	r1, [sp, #4]
c0d0173a:	f7ff ff4f 	bl	c0d015dc <io_seproxyhal_touch_over>
c0d0173e:	4b12      	ldr	r3, [pc, #72]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01740:	2800      	cmp	r0, #0
c0d01742:	d11f      	bne.n	c0d01784 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01744:	1c64      	adds	r4, r4, #1
c0d01746:	b2e6      	uxtb	r6, r4
c0d01748:	9805      	ldr	r0, [sp, #20]
c0d0174a:	4286      	cmp	r6, r0
c0d0174c:	d3a6      	bcc.n	c0d0169c <io_seproxyhal_touch_element_callback+0x20>
c0d0174e:	e000      	b.n	c0d01752 <io_seproxyhal_touch_element_callback+0xd6>
c0d01750:	4b0d      	ldr	r3, [pc, #52]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01752:	9806      	ldr	r0, [sp, #24]
c0d01754:	0600      	lsls	r0, r0, #24
c0d01756:	d010      	beq.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
c0d01758:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d0175a:	2800      	cmp	r0, #0
c0d0175c:	d00d      	beq.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d0175e:	f000 fda7 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d01762:	4909      	ldr	r1, [pc, #36]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01764:	2800      	cmp	r0, #0
c0d01766:	d108      	bne.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01768:	6808      	ldr	r0, [r1, #0]
c0d0176a:	9901      	ldr	r1, [sp, #4]
c0d0176c:	f7ff ff12 	bl	c0d01594 <io_seproxyhal_touch_out>
c0d01770:	4d05      	ldr	r5, [pc, #20]	; (c0d01788 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01772:	2800      	cmp	r0, #0
c0d01774:	d001      	beq.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01776:	2000      	movs	r0, #0
c0d01778:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d0177a:	b007      	add	sp, #28
c0d0177c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0177e:	2000      	movs	r0, #0
c0d01780:	6018      	str	r0, [r3, #0]
c0d01782:	e7fa      	b.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01784:	601e      	str	r6, [r3, #0]
c0d01786:	e7f8      	b.n	c0d0177a <io_seproxyhal_touch_element_callback+0xfe>
c0d01788:	20001d20 	.word	0x20001d20

c0d0178c <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d0178c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0178e:	af03      	add	r7, sp, #12
c0d01790:	b08b      	sub	sp, #44	; 0x2c
c0d01792:	460c      	mov	r4, r1
c0d01794:	4601      	mov	r1, r0
c0d01796:	ad04      	add	r5, sp, #16
c0d01798:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d0179a:	4628      	mov	r0, r5
c0d0179c:	9203      	str	r2, [sp, #12]
c0d0179e:	f7ff fd2d 	bl	c0d011fc <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d017a2:	6821      	ldr	r1, [r4, #0]
c0d017a4:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d017a6:	6862      	ldr	r2, [r4, #4]
c0d017a8:	9502      	str	r5, [sp, #8]
c0d017aa:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d017ac:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d017ae:	4e1a      	ldr	r6, [pc, #104]	; (c0d01818 <io_seproxyhal_display_icon+0x8c>)
c0d017b0:	2365      	movs	r3, #101	; 0x65
c0d017b2:	4635      	mov	r5, r6
c0d017b4:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d017b6:	b292      	uxth	r2, r2
c0d017b8:	4342      	muls	r2, r0
c0d017ba:	b28b      	uxth	r3, r1
c0d017bc:	4353      	muls	r3, r2
c0d017be:	08d9      	lsrs	r1, r3, #3
c0d017c0:	1c4e      	adds	r6, r1, #1
c0d017c2:	2207      	movs	r2, #7
c0d017c4:	4213      	tst	r3, r2
c0d017c6:	d100      	bne.n	c0d017ca <io_seproxyhal_display_icon+0x3e>
c0d017c8:	460e      	mov	r6, r1
c0d017ca:	4631      	mov	r1, r6
c0d017cc:	9101      	str	r1, [sp, #4]
c0d017ce:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d017d0:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d017d2:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d017d4:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d017d6:	0a01      	lsrs	r1, r0, #8
c0d017d8:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d017da:	70a8      	strb	r0, [r5, #2]
c0d017dc:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d017de:	4628      	mov	r0, r5
c0d017e0:	f000 fd48 	bl	c0d02274 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d017e4:	9802      	ldr	r0, [sp, #8]
c0d017e6:	9903      	ldr	r1, [sp, #12]
c0d017e8:	f000 fd44 	bl	c0d02274 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d017ec:	68a0      	ldr	r0, [r4, #8]
c0d017ee:	7028      	strb	r0, [r5, #0]
c0d017f0:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d017f2:	4628      	mov	r0, r5
c0d017f4:	f000 fd3e 	bl	c0d02274 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d017f8:	68e0      	ldr	r0, [r4, #12]
c0d017fa:	f000 fb7f 	bl	c0d01efc <pic>
c0d017fe:	b2b1      	uxth	r1, r6
c0d01800:	f000 fd38 	bl	c0d02274 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01804:	9801      	ldr	r0, [sp, #4]
c0d01806:	b285      	uxth	r5, r0
c0d01808:	6920      	ldr	r0, [r4, #16]
c0d0180a:	f000 fb77 	bl	c0d01efc <pic>
c0d0180e:	4629      	mov	r1, r5
c0d01810:	f000 fd30 	bl	c0d02274 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01814:	b00b      	add	sp, #44	; 0x2c
c0d01816:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01818:	20001a18 	.word	0x20001a18

c0d0181c <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d0181c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0181e:	af03      	add	r7, sp, #12
c0d01820:	b081      	sub	sp, #4
c0d01822:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01824:	7820      	ldrb	r0, [r4, #0]
c0d01826:	267f      	movs	r6, #127	; 0x7f
c0d01828:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d0182a:	2e00      	cmp	r6, #0
c0d0182c:	d02e      	beq.n	c0d0188c <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d0182e:	69e0      	ldr	r0, [r4, #28]
c0d01830:	2800      	cmp	r0, #0
c0d01832:	d01d      	beq.n	c0d01870 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01834:	f000 fb62 	bl	c0d01efc <pic>
c0d01838:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0183a:	2e05      	cmp	r6, #5
c0d0183c:	d102      	bne.n	c0d01844 <io_seproxyhal_display_default+0x28>
c0d0183e:	7ea0      	ldrb	r0, [r4, #26]
c0d01840:	2800      	cmp	r0, #0
c0d01842:	d025      	beq.n	c0d01890 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01844:	4628      	mov	r0, r5
c0d01846:	f002 f8a3 	bl	c0d03990 <strlen>
c0d0184a:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0184c:	4813      	ldr	r0, [pc, #76]	; (c0d0189c <io_seproxyhal_display_default+0x80>)
c0d0184e:	2165      	movs	r1, #101	; 0x65
c0d01850:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01852:	4631      	mov	r1, r6
c0d01854:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01856:	0a0a      	lsrs	r2, r1, #8
c0d01858:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0185a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0185c:	2103      	movs	r1, #3
c0d0185e:	f000 fd09 	bl	c0d02274 <io_seproxyhal_spi_send>
c0d01862:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01864:	4620      	mov	r0, r4
c0d01866:	f000 fd05 	bl	c0d02274 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d0186a:	b2b1      	uxth	r1, r6
c0d0186c:	4628      	mov	r0, r5
c0d0186e:	e00b      	b.n	c0d01888 <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01870:	480a      	ldr	r0, [pc, #40]	; (c0d0189c <io_seproxyhal_display_default+0x80>)
c0d01872:	2165      	movs	r1, #101	; 0x65
c0d01874:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01876:	2100      	movs	r1, #0
c0d01878:	7041      	strb	r1, [r0, #1]
c0d0187a:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d0187c:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0187e:	2103      	movs	r1, #3
c0d01880:	f000 fcf8 	bl	c0d02274 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01884:	4620      	mov	r0, r4
c0d01886:	4629      	mov	r1, r5
c0d01888:	f000 fcf4 	bl	c0d02274 <io_seproxyhal_spi_send>
    }
  }
}
c0d0188c:	b001      	add	sp, #4
c0d0188e:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01890:	4620      	mov	r0, r4
c0d01892:	4629      	mov	r1, r5
c0d01894:	f7ff ff7a 	bl	c0d0178c <io_seproxyhal_display_icon>
c0d01898:	e7f8      	b.n	c0d0188c <io_seproxyhal_display_default+0x70>
c0d0189a:	46c0      	nop			; (mov r8, r8)
c0d0189c:	20001a18 	.word	0x20001a18

c0d018a0 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d018a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018a2:	af03      	add	r7, sp, #12
c0d018a4:	b081      	sub	sp, #4
c0d018a6:	4604      	mov	r4, r0
  if (button_callback) {
c0d018a8:	2c00      	cmp	r4, #0
c0d018aa:	d02e      	beq.n	c0d0190a <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d018ac:	4818      	ldr	r0, [pc, #96]	; (c0d01910 <io_seproxyhal_button_push+0x70>)
c0d018ae:	6802      	ldr	r2, [r0, #0]
c0d018b0:	428a      	cmp	r2, r1
c0d018b2:	d103      	bne.n	c0d018bc <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d018b4:	4a17      	ldr	r2, [pc, #92]	; (c0d01914 <io_seproxyhal_button_push+0x74>)
c0d018b6:	6813      	ldr	r3, [r2, #0]
c0d018b8:	1c5b      	adds	r3, r3, #1
c0d018ba:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d018bc:	6806      	ldr	r6, [r0, #0]
c0d018be:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d018c0:	4a14      	ldr	r2, [pc, #80]	; (c0d01914 <io_seproxyhal_button_push+0x74>)
c0d018c2:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d018c4:	2900      	cmp	r1, #0
c0d018c6:	d001      	beq.n	c0d018cc <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d018c8:	6006      	str	r6, [r0, #0]
c0d018ca:	e005      	b.n	c0d018d8 <io_seproxyhal_button_push+0x38>
c0d018cc:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d018ce:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d018d0:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d018d2:	2301      	movs	r3, #1
c0d018d4:	07db      	lsls	r3, r3, #31
c0d018d6:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d018d8:	6800      	ldr	r0, [r0, #0]
c0d018da:	4288      	cmp	r0, r1
c0d018dc:	d001      	beq.n	c0d018e2 <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d018de:	2000      	movs	r0, #0
c0d018e0:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d018e2:	2d08      	cmp	r5, #8
c0d018e4:	d30e      	bcc.n	c0d01904 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d018e6:	2103      	movs	r1, #3
c0d018e8:	4628      	mov	r0, r5
c0d018ea:	f001 fda7 	bl	c0d0343c <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d018ee:	2001      	movs	r0, #1
c0d018f0:	0780      	lsls	r0, r0, #30
c0d018f2:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d018f4:	2900      	cmp	r1, #0
c0d018f6:	4601      	mov	r1, r0
c0d018f8:	d000      	beq.n	c0d018fc <io_seproxyhal_button_push+0x5c>
c0d018fa:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d018fc:	2900      	cmp	r1, #0
c0d018fe:	db02      	blt.n	c0d01906 <io_seproxyhal_button_push+0x66>
c0d01900:	4608      	mov	r0, r1
c0d01902:	e000      	b.n	c0d01906 <io_seproxyhal_button_push+0x66>
c0d01904:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01906:	4629      	mov	r1, r5
c0d01908:	47a0      	blx	r4
  }
}
c0d0190a:	b001      	add	sp, #4
c0d0190c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0190e:	46c0      	nop			; (mov r8, r8)
c0d01910:	20001d24 	.word	0x20001d24
c0d01914:	20001d28 	.word	0x20001d28

c0d01918 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01918:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0191a:	af03      	add	r7, sp, #12
c0d0191c:	b081      	sub	sp, #4
c0d0191e:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d01920:	200f      	movs	r0, #15
c0d01922:	4204      	tst	r4, r0
c0d01924:	d006      	beq.n	c0d01934 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01926:	4620      	mov	r0, r4
c0d01928:	f7ff f8be 	bl	c0d00aa8 <io_exchange_al>
c0d0192c:	4605      	mov	r5, r0
  }
}
c0d0192e:	b2a8      	uxth	r0, r5
c0d01930:	b001      	add	sp, #4
c0d01932:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01934:	2610      	movs	r6, #16
c0d01936:	4026      	ands	r6, r4
c0d01938:	2900      	cmp	r1, #0
c0d0193a:	d02a      	beq.n	c0d01992 <io_exchange+0x7a>
c0d0193c:	2e00      	cmp	r6, #0
c0d0193e:	d128      	bne.n	c0d01992 <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d01940:	483d      	ldr	r0, [pc, #244]	; (c0d01a38 <io_exchange+0x120>)
c0d01942:	7800      	ldrb	r0, [r0, #0]
c0d01944:	2807      	cmp	r0, #7
c0d01946:	d00b      	beq.n	c0d01960 <io_exchange+0x48>
c0d01948:	2800      	cmp	r0, #0
c0d0194a:	d004      	beq.n	c0d01956 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d0194c:	4620      	mov	r0, r4
c0d0194e:	f7ff f8ab 	bl	c0d00aa8 <io_exchange_al>
c0d01952:	2800      	cmp	r0, #0
c0d01954:	d00a      	beq.n	c0d0196c <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01956:	4839      	ldr	r0, [pc, #228]	; (c0d01a3c <io_exchange+0x124>)
c0d01958:	6800      	ldr	r0, [r0, #0]
c0d0195a:	2109      	movs	r1, #9
c0d0195c:	f002 f80a 	bl	c0d03974 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d01960:	483d      	ldr	r0, [pc, #244]	; (c0d01a58 <io_exchange+0x140>)
c0d01962:	4478      	add	r0, pc
c0d01964:	2200      	movs	r2, #0
c0d01966:	2320      	movs	r3, #32
c0d01968:	f7ff fc6a 	bl	c0d01240 <io_usb_hid_exchange>
c0d0196c:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0196e:	4832      	ldr	r0, [pc, #200]	; (c0d01a38 <io_exchange+0x120>)
c0d01970:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d01972:	4833      	ldr	r0, [pc, #204]	; (c0d01a40 <io_exchange+0x128>)
c0d01974:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01976:	4833      	ldr	r0, [pc, #204]	; (c0d01a44 <io_exchange+0x12c>)
c0d01978:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d0197a:	4833      	ldr	r0, [pc, #204]	; (c0d01a48 <io_exchange+0x130>)
c0d0197c:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0197e:	4833      	ldr	r0, [pc, #204]	; (c0d01a4c <io_exchange+0x134>)
c0d01980:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01982:	06a0      	lsls	r0, r4, #26
c0d01984:	d4d3      	bmi.n	c0d0192e <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01986:	f7ff fcd3 	bl	c0d01330 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d0198a:	0620      	lsls	r0, r4, #24
c0d0198c:	d501      	bpl.n	c0d01992 <io_exchange+0x7a>
        reset();
c0d0198e:	f000 faeb 	bl	c0d01f68 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01992:	2e00      	cmp	r6, #0
c0d01994:	d10c      	bne.n	c0d019b0 <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01996:	0660      	lsls	r0, r4, #25
c0d01998:	d448      	bmi.n	c0d01a2c <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d0199a:	4827      	ldr	r0, [pc, #156]	; (c0d01a38 <io_exchange+0x120>)
c0d0199c:	2100      	movs	r1, #0
c0d0199e:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d019a0:	4827      	ldr	r0, [pc, #156]	; (c0d01a40 <io_exchange+0x128>)
c0d019a2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d019a4:	4827      	ldr	r0, [pc, #156]	; (c0d01a44 <io_exchange+0x12c>)
c0d019a6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d019a8:	4827      	ldr	r0, [pc, #156]	; (c0d01a48 <io_exchange+0x130>)
c0d019aa:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d019ac:	4827      	ldr	r0, [pc, #156]	; (c0d01a4c <io_exchange+0x134>)
c0d019ae:	7001      	strb	r1, [r0, #0]
c0d019b0:	4c28      	ldr	r4, [pc, #160]	; (c0d01a54 <io_exchange+0x13c>)
c0d019b2:	4e24      	ldr	r6, [pc, #144]	; (c0d01a44 <io_exchange+0x12c>)
c0d019b4:	e008      	b.n	c0d019c8 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d019b6:	f7ff fd0f 	bl	c0d013d8 <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d019ba:	8830      	ldrh	r0, [r6, #0]
c0d019bc:	2800      	cmp	r0, #0
c0d019be:	d003      	beq.n	c0d019c8 <io_exchange+0xb0>
c0d019c0:	e032      	b.n	c0d01a28 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d019c2:	2002      	movs	r0, #2
c0d019c4:	f7ff f89e 	bl	c0d00b04 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d019c8:	f000 fc72 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d019cc:	2800      	cmp	r0, #0
c0d019ce:	d101      	bne.n	c0d019d4 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d019d0:	f7ff fcae 	bl	c0d01330 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d019d4:	2180      	movs	r1, #128	; 0x80
c0d019d6:	2500      	movs	r5, #0
c0d019d8:	4620      	mov	r0, r4
c0d019da:	462a      	mov	r2, r5
c0d019dc:	f000 fc84 	bl	c0d022e8 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d019e0:	1ec1      	subs	r1, r0, #3
c0d019e2:	78a2      	ldrb	r2, [r4, #2]
c0d019e4:	7863      	ldrb	r3, [r4, #1]
c0d019e6:	021b      	lsls	r3, r3, #8
c0d019e8:	4313      	orrs	r3, r2
c0d019ea:	4299      	cmp	r1, r3
c0d019ec:	d110      	bne.n	c0d01a10 <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d019ee:	4917      	ldr	r1, [pc, #92]	; (c0d01a4c <io_exchange+0x134>)
c0d019f0:	7809      	ldrb	r1, [r1, #0]
c0d019f2:	2900      	cmp	r1, #0
c0d019f4:	d002      	beq.n	c0d019fc <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d019f6:	f7ff fd73 	bl	c0d014e0 <io_seproxyhal_handle_event>
c0d019fa:	e7e5      	b.n	c0d019c8 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d019fc:	7821      	ldrb	r1, [r4, #0]
c0d019fe:	2910      	cmp	r1, #16
c0d01a00:	d00f      	beq.n	c0d01a22 <io_exchange+0x10a>
c0d01a02:	290f      	cmp	r1, #15
c0d01a04:	d1dd      	bne.n	c0d019c2 <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01a06:	2804      	cmp	r0, #4
c0d01a08:	d102      	bne.n	c0d01a10 <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01a0a:	f7ff fca7 	bl	c0d0135c <io_seproxyhal_handle_usb_event>
c0d01a0e:	e7db      	b.n	c0d019c8 <io_exchange+0xb0>
c0d01a10:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d01a12:	4909      	ldr	r1, [pc, #36]	; (c0d01a38 <io_exchange+0x120>)
c0d01a14:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01a16:	490a      	ldr	r1, [pc, #40]	; (c0d01a40 <io_exchange+0x128>)
c0d01a18:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01a1a:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01a1c:	490a      	ldr	r1, [pc, #40]	; (c0d01a48 <io_exchange+0x130>)
c0d01a1e:	8008      	strh	r0, [r1, #0]
c0d01a20:	e7d2      	b.n	c0d019c8 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d01a22:	2806      	cmp	r0, #6
c0d01a24:	d2c7      	bcs.n	c0d019b6 <io_exchange+0x9e>
c0d01a26:	e782      	b.n	c0d0192e <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01a28:	8835      	ldrh	r5, [r6, #0]
c0d01a2a:	e780      	b.n	c0d0192e <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01a2c:	4805      	ldr	r0, [pc, #20]	; (c0d01a44 <io_exchange+0x12c>)
c0d01a2e:	8800      	ldrh	r0, [r0, #0]
c0d01a30:	4907      	ldr	r1, [pc, #28]	; (c0d01a50 <io_exchange+0x138>)
c0d01a32:	1845      	adds	r5, r0, r1
c0d01a34:	e77b      	b.n	c0d0192e <io_exchange+0x16>
c0d01a36:	46c0      	nop			; (mov r8, r8)
c0d01a38:	20001d18 	.word	0x20001d18
c0d01a3c:	20001bb8 	.word	0x20001bb8
c0d01a40:	20001d1a 	.word	0x20001d1a
c0d01a44:	20001d1c 	.word	0x20001d1c
c0d01a48:	20001d1e 	.word	0x20001d1e
c0d01a4c:	20001d10 	.word	0x20001d10
c0d01a50:	0000fffb 	.word	0x0000fffb
c0d01a54:	20001a18 	.word	0x20001a18
c0d01a58:	fffffbbb 	.word	0xfffffbbb

c0d01a5c <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01a5c:	b081      	sub	sp, #4
c0d01a5e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a60:	af03      	add	r7, sp, #12
c0d01a62:	b094      	sub	sp, #80	; 0x50
c0d01a64:	4616      	mov	r6, r2
c0d01a66:	460d      	mov	r5, r1
c0d01a68:	900e      	str	r0, [sp, #56]	; 0x38
c0d01a6a:	9319      	str	r3, [sp, #100]	; 0x64
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d01a6c:	2d02      	cmp	r5, #2
c0d01a6e:	d200      	bcs.n	c0d01a72 <snprintf+0x16>
c0d01a70:	e22a      	b.n	c0d01ec8 <snprintf+0x46c>
c0d01a72:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01a74:	2800      	cmp	r0, #0
c0d01a76:	d100      	bne.n	c0d01a7a <snprintf+0x1e>
c0d01a78:	e226      	b.n	c0d01ec8 <snprintf+0x46c>
c0d01a7a:	2e00      	cmp	r6, #0
c0d01a7c:	d100      	bne.n	c0d01a80 <snprintf+0x24>
c0d01a7e:	e223      	b.n	c0d01ec8 <snprintf+0x46c>
c0d01a80:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d01a82:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01a84:	9109      	str	r1, [sp, #36]	; 0x24
c0d01a86:	462a      	mov	r2, r5
c0d01a88:	f7ff fbae 	bl	c0d011e8 <os_memset>
c0d01a8c:	a819      	add	r0, sp, #100	; 0x64


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01a8e:	900f      	str	r0, [sp, #60]	; 0x3c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01a90:	7830      	ldrb	r0, [r6, #0]
c0d01a92:	2800      	cmp	r0, #0
c0d01a94:	d100      	bne.n	c0d01a98 <snprintf+0x3c>
c0d01a96:	e217      	b.n	c0d01ec8 <snprintf+0x46c>
c0d01a98:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01a9a:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d01a9c:	1e6b      	subs	r3, r5, #1
c0d01a9e:	9108      	str	r1, [sp, #32]
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01aa0:	460a      	mov	r2, r1
c0d01aa2:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01aa4:	e003      	b.n	c0d01aae <snprintf+0x52>
c0d01aa6:	1970      	adds	r0, r6, r5
c0d01aa8:	7840      	ldrb	r0, [r0, #1]
c0d01aaa:	1e52      	subs	r2, r2, #1
            ulIdx++)
c0d01aac:	1c6d      	adds	r5, r5, #1
c0d01aae:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01ab0:	2800      	cmp	r0, #0
c0d01ab2:	d001      	beq.n	c0d01ab8 <snprintf+0x5c>
c0d01ab4:	2825      	cmp	r0, #37	; 0x25
c0d01ab6:	d1f6      	bne.n	c0d01aa6 <snprintf+0x4a>
c0d01ab8:	9205      	str	r2, [sp, #20]
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01aba:	429d      	cmp	r5, r3
c0d01abc:	d300      	bcc.n	c0d01ac0 <snprintf+0x64>
c0d01abe:	461d      	mov	r5, r3
        os_memmove(str, format, ulIdx);
c0d01ac0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01ac2:	4631      	mov	r1, r6
c0d01ac4:	462a      	mov	r2, r5
c0d01ac6:	461c      	mov	r4, r3
c0d01ac8:	f7ff fb98 	bl	c0d011fc <os_memmove>
c0d01acc:	940b      	str	r4, [sp, #44]	; 0x2c
        str+= ulIdx;
        str_size -= ulIdx;
c0d01ace:	1b63      	subs	r3, r4, r5
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d01ad0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01ad2:	1942      	adds	r2, r0, r5
        str_size -= ulIdx;
        if (str_size == 0) {
c0d01ad4:	2b00      	cmp	r3, #0
c0d01ad6:	d100      	bne.n	c0d01ada <snprintf+0x7e>
c0d01ad8:	e1f6      	b.n	c0d01ec8 <snprintf+0x46c>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01ada:	1970      	adds	r0, r6, r5

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01adc:	5d71      	ldrb	r1, [r6, r5]
c0d01ade:	2925      	cmp	r1, #37	; 0x25
c0d01ae0:	d000      	beq.n	c0d01ae4 <snprintf+0x88>
c0d01ae2:	e0ab      	b.n	c0d01c3c <snprintf+0x1e0>
c0d01ae4:	9304      	str	r3, [sp, #16]
c0d01ae6:	9207      	str	r2, [sp, #28]
        {
            //
            // Skip the %.
            //
            format++;
c0d01ae8:	1c40      	adds	r0, r0, #1
c0d01aea:	2100      	movs	r1, #0
c0d01aec:	2220      	movs	r2, #32
c0d01aee:	920a      	str	r2, [sp, #40]	; 0x28
c0d01af0:	220a      	movs	r2, #10
c0d01af2:	9203      	str	r2, [sp, #12]
c0d01af4:	9102      	str	r1, [sp, #8]
c0d01af6:	9106      	str	r1, [sp, #24]
c0d01af8:	910d      	str	r1, [sp, #52]	; 0x34
c0d01afa:	460b      	mov	r3, r1
c0d01afc:	2102      	movs	r1, #2
c0d01afe:	910c      	str	r1, [sp, #48]	; 0x30
c0d01b00:	4606      	mov	r6, r0
c0d01b02:	461a      	mov	r2, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01b04:	7831      	ldrb	r1, [r6, #0]
c0d01b06:	1c76      	adds	r6, r6, #1
c0d01b08:	2300      	movs	r3, #0
c0d01b0a:	2962      	cmp	r1, #98	; 0x62
c0d01b0c:	dc41      	bgt.n	c0d01b92 <snprintf+0x136>
c0d01b0e:	4608      	mov	r0, r1
c0d01b10:	3825      	subs	r0, #37	; 0x25
c0d01b12:	2823      	cmp	r0, #35	; 0x23
c0d01b14:	d900      	bls.n	c0d01b18 <snprintf+0xbc>
c0d01b16:	e094      	b.n	c0d01c42 <snprintf+0x1e6>
c0d01b18:	0040      	lsls	r0, r0, #1
c0d01b1a:	46c0      	nop			; (mov r8, r8)
c0d01b1c:	4478      	add	r0, pc
c0d01b1e:	8880      	ldrh	r0, [r0, #4]
c0d01b20:	0040      	lsls	r0, r0, #1
c0d01b22:	4487      	add	pc, r0
c0d01b24:	0186012d 	.word	0x0186012d
c0d01b28:	01860186 	.word	0x01860186
c0d01b2c:	00510186 	.word	0x00510186
c0d01b30:	01860186 	.word	0x01860186
c0d01b34:	00580023 	.word	0x00580023
c0d01b38:	00240186 	.word	0x00240186
c0d01b3c:	00240024 	.word	0x00240024
c0d01b40:	00240024 	.word	0x00240024
c0d01b44:	00240024 	.word	0x00240024
c0d01b48:	00240024 	.word	0x00240024
c0d01b4c:	01860024 	.word	0x01860024
c0d01b50:	01860186 	.word	0x01860186
c0d01b54:	01860186 	.word	0x01860186
c0d01b58:	01860186 	.word	0x01860186
c0d01b5c:	01860186 	.word	0x01860186
c0d01b60:	01860186 	.word	0x01860186
c0d01b64:	01860186 	.word	0x01860186
c0d01b68:	006c0186 	.word	0x006c0186
c0d01b6c:	e7c9      	b.n	c0d01b02 <snprintf+0xa6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01b6e:	2930      	cmp	r1, #48	; 0x30
c0d01b70:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01b72:	4603      	mov	r3, r0
c0d01b74:	d100      	bne.n	c0d01b78 <snprintf+0x11c>
c0d01b76:	460b      	mov	r3, r1
c0d01b78:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d01b7a:	2c00      	cmp	r4, #0
c0d01b7c:	d000      	beq.n	c0d01b80 <snprintf+0x124>
c0d01b7e:	4603      	mov	r3, r0
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01b80:	200a      	movs	r0, #10
c0d01b82:	4360      	muls	r0, r4
                    ulCount += format[-1] - '0';
c0d01b84:	1840      	adds	r0, r0, r1
c0d01b86:	3830      	subs	r0, #48	; 0x30
c0d01b88:	900d      	str	r0, [sp, #52]	; 0x34
c0d01b8a:	4630      	mov	r0, r6
c0d01b8c:	930a      	str	r3, [sp, #40]	; 0x28
c0d01b8e:	4613      	mov	r3, r2
c0d01b90:	e7b4      	b.n	c0d01afc <snprintf+0xa0>
c0d01b92:	296f      	cmp	r1, #111	; 0x6f
c0d01b94:	dd11      	ble.n	c0d01bba <snprintf+0x15e>
c0d01b96:	3970      	subs	r1, #112	; 0x70
c0d01b98:	2908      	cmp	r1, #8
c0d01b9a:	d900      	bls.n	c0d01b9e <snprintf+0x142>
c0d01b9c:	e149      	b.n	c0d01e32 <snprintf+0x3d6>
c0d01b9e:	0049      	lsls	r1, r1, #1
c0d01ba0:	4479      	add	r1, pc
c0d01ba2:	8889      	ldrh	r1, [r1, #4]
c0d01ba4:	0049      	lsls	r1, r1, #1
c0d01ba6:	448f      	add	pc, r1
c0d01ba8:	01440051 	.word	0x01440051
c0d01bac:	002e0144 	.word	0x002e0144
c0d01bb0:	00590144 	.word	0x00590144
c0d01bb4:	01440144 	.word	0x01440144
c0d01bb8:	0051      	.short	0x0051
c0d01bba:	2963      	cmp	r1, #99	; 0x63
c0d01bbc:	d054      	beq.n	c0d01c68 <snprintf+0x20c>
c0d01bbe:	2964      	cmp	r1, #100	; 0x64
c0d01bc0:	d057      	beq.n	c0d01c72 <snprintf+0x216>
c0d01bc2:	2968      	cmp	r1, #104	; 0x68
c0d01bc4:	d01d      	beq.n	c0d01c02 <snprintf+0x1a6>
c0d01bc6:	e134      	b.n	c0d01e32 <snprintf+0x3d6>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01bc8:	7830      	ldrb	r0, [r6, #0]
c0d01bca:	2873      	cmp	r0, #115	; 0x73
c0d01bcc:	d000      	beq.n	c0d01bd0 <snprintf+0x174>
c0d01bce:	e130      	b.n	c0d01e32 <snprintf+0x3d6>
c0d01bd0:	4630      	mov	r0, r6
c0d01bd2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01bd4:	e00d      	b.n	c0d01bf2 <snprintf+0x196>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01bd6:	7830      	ldrb	r0, [r6, #0]
c0d01bd8:	282a      	cmp	r0, #42	; 0x2a
c0d01bda:	d000      	beq.n	c0d01bde <snprintf+0x182>
c0d01bdc:	e129      	b.n	c0d01e32 <snprintf+0x3d6>
c0d01bde:	7871      	ldrb	r1, [r6, #1]
c0d01be0:	1c70      	adds	r0, r6, #1
c0d01be2:	2301      	movs	r3, #1
c0d01be4:	2948      	cmp	r1, #72	; 0x48
c0d01be6:	d004      	beq.n	c0d01bf2 <snprintf+0x196>
c0d01be8:	2968      	cmp	r1, #104	; 0x68
c0d01bea:	d002      	beq.n	c0d01bf2 <snprintf+0x196>
c0d01bec:	2973      	cmp	r1, #115	; 0x73
c0d01bee:	d000      	beq.n	c0d01bf2 <snprintf+0x196>
c0d01bf0:	e11f      	b.n	c0d01e32 <snprintf+0x3d6>
c0d01bf2:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01bf4:	1d0a      	adds	r2, r1, #4
c0d01bf6:	920f      	str	r2, [sp, #60]	; 0x3c
c0d01bf8:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d01bfa:	9102      	str	r1, [sp, #8]
c0d01bfc:	e77e      	b.n	c0d01afc <snprintf+0xa0>
c0d01bfe:	2001      	movs	r0, #1
c0d01c00:	9006      	str	r0, [sp, #24]
c0d01c02:	2010      	movs	r0, #16
c0d01c04:	9003      	str	r0, [sp, #12]
c0d01c06:	9b0c      	ldr	r3, [sp, #48]	; 0x30
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01c08:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c0a:	1d01      	adds	r1, r0, #4
c0d01c0c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c0e:	2103      	movs	r1, #3
c0d01c10:	400a      	ands	r2, r1
c0d01c12:	1c5b      	adds	r3, r3, #1
c0d01c14:	6801      	ldr	r1, [r0, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01c16:	2a01      	cmp	r2, #1
c0d01c18:	d100      	bne.n	c0d01c1c <snprintf+0x1c0>
c0d01c1a:	e0b8      	b.n	c0d01d8e <snprintf+0x332>
c0d01c1c:	2a02      	cmp	r2, #2
c0d01c1e:	d100      	bne.n	c0d01c22 <snprintf+0x1c6>
c0d01c20:	e104      	b.n	c0d01e2c <snprintf+0x3d0>
c0d01c22:	2a03      	cmp	r2, #3
c0d01c24:	4630      	mov	r0, r6
c0d01c26:	d100      	bne.n	c0d01c2a <snprintf+0x1ce>
c0d01c28:	e768      	b.n	c0d01afc <snprintf+0xa0>
c0d01c2a:	9c08      	ldr	r4, [sp, #32]
c0d01c2c:	4625      	mov	r5, r4
c0d01c2e:	9b04      	ldr	r3, [sp, #16]
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01c30:	1948      	adds	r0, r1, r5
c0d01c32:	7840      	ldrb	r0, [r0, #1]
c0d01c34:	1c6d      	adds	r5, r5, #1
c0d01c36:	2800      	cmp	r0, #0
c0d01c38:	d1fa      	bne.n	c0d01c30 <snprintf+0x1d4>
c0d01c3a:	e0ab      	b.n	c0d01d94 <snprintf+0x338>
c0d01c3c:	4606      	mov	r6, r0
c0d01c3e:	920e      	str	r2, [sp, #56]	; 0x38
c0d01c40:	e109      	b.n	c0d01e56 <snprintf+0x3fa>
c0d01c42:	2958      	cmp	r1, #88	; 0x58
c0d01c44:	d000      	beq.n	c0d01c48 <snprintf+0x1ec>
c0d01c46:	e0f4      	b.n	c0d01e32 <snprintf+0x3d6>
c0d01c48:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d01c4a:	9006      	str	r0, [sp, #24]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c4c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c4e:	1d01      	adds	r1, r0, #4
c0d01c50:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c52:	6802      	ldr	r2, [r0, #0]
c0d01c54:	2000      	movs	r0, #0
c0d01c56:	9005      	str	r0, [sp, #20]
c0d01c58:	2510      	movs	r5, #16
c0d01c5a:	e014      	b.n	c0d01c86 <snprintf+0x22a>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c5c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c5e:	1d01      	adds	r1, r0, #4
c0d01c60:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c62:	6802      	ldr	r2, [r0, #0]
c0d01c64:	2000      	movs	r0, #0
c0d01c66:	e00c      	b.n	c0d01c82 <snprintf+0x226>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c68:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c6a:	1d01      	adds	r1, r0, #4
c0d01c6c:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c6e:	6800      	ldr	r0, [r0, #0]
c0d01c70:	e087      	b.n	c0d01d82 <snprintf+0x326>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01c72:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01c74:	1d01      	adds	r1, r0, #4
c0d01c76:	910f      	str	r1, [sp, #60]	; 0x3c
c0d01c78:	6800      	ldr	r0, [r0, #0]
c0d01c7a:	17c1      	asrs	r1, r0, #31
c0d01c7c:	1842      	adds	r2, r0, r1
c0d01c7e:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01c80:	0fc0      	lsrs	r0, r0, #31
c0d01c82:	9005      	str	r0, [sp, #20]
c0d01c84:	250a      	movs	r5, #10
c0d01c86:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01c88:	4295      	cmp	r5, r2
c0d01c8a:	920e      	str	r2, [sp, #56]	; 0x38
c0d01c8c:	d814      	bhi.n	c0d01cb8 <snprintf+0x25c>
c0d01c8e:	2201      	movs	r2, #1
c0d01c90:	4628      	mov	r0, r5
c0d01c92:	920b      	str	r2, [sp, #44]	; 0x2c
c0d01c94:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01c96:	4629      	mov	r1, r5
c0d01c98:	f001 fb4a 	bl	c0d03330 <__aeabi_uidiv>
c0d01c9c:	990b      	ldr	r1, [sp, #44]	; 0x2c
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01c9e:	4288      	cmp	r0, r1
c0d01ca0:	d109      	bne.n	c0d01cb6 <snprintf+0x25a>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01ca2:	4628      	mov	r0, r5
c0d01ca4:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01ca6:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01ca8:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01caa:	910d      	str	r1, [sp, #52]	; 0x34
c0d01cac:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01cae:	4288      	cmp	r0, r1
c0d01cb0:	4622      	mov	r2, r4
c0d01cb2:	d9ee      	bls.n	c0d01c92 <snprintf+0x236>
c0d01cb4:	e000      	b.n	c0d01cb8 <snprintf+0x25c>
c0d01cb6:	460c      	mov	r4, r1
c0d01cb8:	950c      	str	r5, [sp, #48]	; 0x30
c0d01cba:	4625      	mov	r5, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01cbc:	2000      	movs	r0, #0
c0d01cbe:	4603      	mov	r3, r0
c0d01cc0:	43c1      	mvns	r1, r0
c0d01cc2:	9c05      	ldr	r4, [sp, #20]
c0d01cc4:	2c00      	cmp	r4, #0
c0d01cc6:	d100      	bne.n	c0d01cca <snprintf+0x26e>
c0d01cc8:	4621      	mov	r1, r4
c0d01cca:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01ccc:	910b      	str	r1, [sp, #44]	; 0x2c
c0d01cce:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d01cd0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01cd2:	b2ca      	uxtb	r2, r1
c0d01cd4:	2a30      	cmp	r2, #48	; 0x30
c0d01cd6:	d106      	bne.n	c0d01ce6 <snprintf+0x28a>
c0d01cd8:	2c00      	cmp	r4, #0
c0d01cda:	d004      	beq.n	c0d01ce6 <snprintf+0x28a>
c0d01cdc:	a910      	add	r1, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01cde:	232d      	movs	r3, #45	; 0x2d
c0d01ce0:	700b      	strb	r3, [r1, #0]
c0d01ce2:	2400      	movs	r4, #0
c0d01ce4:	2301      	movs	r3, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d01ce6:	1e81      	subs	r1, r0, #2
c0d01ce8:	290d      	cmp	r1, #13
c0d01cea:	d80d      	bhi.n	c0d01d08 <snprintf+0x2ac>
c0d01cec:	1e41      	subs	r1, r0, #1
c0d01cee:	d00b      	beq.n	c0d01d08 <snprintf+0x2ac>
c0d01cf0:	a810      	add	r0, sp, #64	; 0x40
c0d01cf2:	9405      	str	r4, [sp, #20]
c0d01cf4:	461c      	mov	r4, r3
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01cf6:	4320      	orrs	r0, r4
c0d01cf8:	f001 fda4 	bl	c0d03844 <__aeabi_memset>
c0d01cfc:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01cfe:	1900      	adds	r0, r0, r4
c0d01d00:	9c05      	ldr	r4, [sp, #20]
c0d01d02:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01d04:	1840      	adds	r0, r0, r1
c0d01d06:	1e43      	subs	r3, r0, #1
c0d01d08:	4629      	mov	r1, r5

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d01d0a:	2c00      	cmp	r4, #0
c0d01d0c:	9601      	str	r6, [sp, #4]
c0d01d0e:	d003      	beq.n	c0d01d18 <snprintf+0x2bc>
c0d01d10:	a810      	add	r0, sp, #64	; 0x40
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01d12:	222d      	movs	r2, #45	; 0x2d
c0d01d14:	54c2      	strb	r2, [r0, r3]
c0d01d16:	1c5b      	adds	r3, r3, #1
c0d01d18:	9806      	ldr	r0, [sp, #24]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01d1a:	2900      	cmp	r1, #0
c0d01d1c:	d003      	beq.n	c0d01d26 <snprintf+0x2ca>
c0d01d1e:	2800      	cmp	r0, #0
c0d01d20:	d003      	beq.n	c0d01d2a <snprintf+0x2ce>
c0d01d22:	a06c      	add	r0, pc, #432	; (adr r0, c0d01ed4 <g_pcHex_cap>)
c0d01d24:	e002      	b.n	c0d01d2c <snprintf+0x2d0>
c0d01d26:	461c      	mov	r4, r3
c0d01d28:	e016      	b.n	c0d01d58 <snprintf+0x2fc>
c0d01d2a:	a06e      	add	r0, pc, #440	; (adr r0, c0d01ee4 <g_pcHex>)
c0d01d2c:	900d      	str	r0, [sp, #52]	; 0x34
c0d01d2e:	461c      	mov	r4, r3
c0d01d30:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01d32:	460e      	mov	r6, r1
c0d01d34:	f001 fafc 	bl	c0d03330 <__aeabi_uidiv>
c0d01d38:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d01d3a:	4629      	mov	r1, r5
c0d01d3c:	f001 fb7e 	bl	c0d0343c <__aeabi_uidivmod>
c0d01d40:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01d42:	5c40      	ldrb	r0, [r0, r1]
c0d01d44:	a910      	add	r1, sp, #64	; 0x40
c0d01d46:	5508      	strb	r0, [r1, r4]
c0d01d48:	4630      	mov	r0, r6
c0d01d4a:	4629      	mov	r1, r5
c0d01d4c:	f001 faf0 	bl	c0d03330 <__aeabi_uidiv>
c0d01d50:	1c64      	adds	r4, r4, #1
c0d01d52:	42b5      	cmp	r5, r6
c0d01d54:	4601      	mov	r1, r0
c0d01d56:	d9eb      	bls.n	c0d01d30 <snprintf+0x2d4>
c0d01d58:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01d5a:	429c      	cmp	r4, r3
c0d01d5c:	4625      	mov	r5, r4
c0d01d5e:	d300      	bcc.n	c0d01d62 <snprintf+0x306>
c0d01d60:	461d      	mov	r5, r3
c0d01d62:	a910      	add	r1, sp, #64	; 0x40
c0d01d64:	9c07      	ldr	r4, [sp, #28]
                    os_memmove(str, pcBuf, ulPos);
c0d01d66:	4620      	mov	r0, r4
c0d01d68:	462a      	mov	r2, r5
c0d01d6a:	461e      	mov	r6, r3
c0d01d6c:	f7ff fa46 	bl	c0d011fc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01d70:	1b70      	subs	r0, r6, r5
                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
                    os_memmove(str, pcBuf, ulPos);
                    str+= ulPos;
c0d01d72:	1961      	adds	r1, r4, r5
c0d01d74:	910e      	str	r1, [sp, #56]	; 0x38
c0d01d76:	4603      	mov	r3, r0
                    str_size -= ulPos;
                    if (str_size == 0) {
c0d01d78:	2800      	cmp	r0, #0
c0d01d7a:	9e01      	ldr	r6, [sp, #4]
c0d01d7c:	d16b      	bne.n	c0d01e56 <snprintf+0x3fa>
c0d01d7e:	e0a3      	b.n	c0d01ec8 <snprintf+0x46c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d01d80:	2025      	movs	r0, #37	; 0x25
c0d01d82:	9907      	ldr	r1, [sp, #28]
c0d01d84:	7008      	strb	r0, [r1, #0]
c0d01d86:	9804      	ldr	r0, [sp, #16]
c0d01d88:	1e40      	subs	r0, r0, #1
c0d01d8a:	1c49      	adds	r1, r1, #1
c0d01d8c:	e05f      	b.n	c0d01e4e <snprintf+0x3f2>
c0d01d8e:	9d02      	ldr	r5, [sp, #8]
c0d01d90:	9c08      	ldr	r4, [sp, #32]
c0d01d92:	9b04      	ldr	r3, [sp, #16]
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01d94:	9803      	ldr	r0, [sp, #12]
c0d01d96:	2810      	cmp	r0, #16
c0d01d98:	9807      	ldr	r0, [sp, #28]
c0d01d9a:	d161      	bne.n	c0d01e60 <snprintf+0x404>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01d9c:	2d00      	cmp	r5, #0
c0d01d9e:	d06a      	beq.n	c0d01e76 <snprintf+0x41a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01da0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d01da2:	1900      	adds	r0, r0, r4
c0d01da4:	900e      	str	r0, [sp, #56]	; 0x38
c0d01da6:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d01da8:	1aa0      	subs	r0, r4, r2
c0d01daa:	9b05      	ldr	r3, [sp, #20]
c0d01dac:	4283      	cmp	r3, r0
c0d01dae:	d800      	bhi.n	c0d01db2 <snprintf+0x356>
c0d01db0:	4603      	mov	r3, r0
c0d01db2:	930c      	str	r3, [sp, #48]	; 0x30
c0d01db4:	435c      	muls	r4, r3
c0d01db6:	940a      	str	r4, [sp, #40]	; 0x28
c0d01db8:	1c60      	adds	r0, r4, #1
c0d01dba:	9007      	str	r0, [sp, #28]
c0d01dbc:	2000      	movs	r0, #0
c0d01dbe:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01dc0:	9100      	str	r1, [sp, #0]
c0d01dc2:	940e      	str	r4, [sp, #56]	; 0x38
c0d01dc4:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01dc6:	18e3      	adds	r3, r4, r3
c0d01dc8:	900d      	str	r0, [sp, #52]	; 0x34
c0d01dca:	5c09      	ldrb	r1, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d01dcc:	200f      	movs	r0, #15
c0d01dce:	4008      	ands	r0, r1
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01dd0:	0909      	lsrs	r1, r1, #4
c0d01dd2:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d01dd4:	18a4      	adds	r4, r4, r2
c0d01dd6:	1c64      	adds	r4, r4, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d01dd8:	2c02      	cmp	r4, #2
c0d01dda:	d375      	bcc.n	c0d01ec8 <snprintf+0x46c>
c0d01ddc:	9c06      	ldr	r4, [sp, #24]
                              return 0;
                          }
                          switch(ulCap) {
c0d01dde:	2c01      	cmp	r4, #1
c0d01de0:	d003      	beq.n	c0d01dea <snprintf+0x38e>
c0d01de2:	2c00      	cmp	r4, #0
c0d01de4:	d108      	bne.n	c0d01df8 <snprintf+0x39c>
c0d01de6:	a43f      	add	r4, pc, #252	; (adr r4, c0d01ee4 <g_pcHex>)
c0d01de8:	e000      	b.n	c0d01dec <snprintf+0x390>
c0d01dea:	a43a      	add	r4, pc, #232	; (adr r4, c0d01ed4 <g_pcHex_cap>)
c0d01dec:	b2c9      	uxtb	r1, r1
c0d01dee:	5c61      	ldrb	r1, [r4, r1]
c0d01df0:	7019      	strb	r1, [r3, #0]
c0d01df2:	b2c0      	uxtb	r0, r0
c0d01df4:	5c20      	ldrb	r0, [r4, r0]
c0d01df6:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d01df8:	9807      	ldr	r0, [sp, #28]
c0d01dfa:	4290      	cmp	r0, r2
c0d01dfc:	d064      	beq.n	c0d01ec8 <snprintf+0x46c>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01dfe:	1e92      	subs	r2, r2, #2
c0d01e00:	9c0e      	ldr	r4, [sp, #56]	; 0x38
c0d01e02:	1ca4      	adds	r4, r4, #2
c0d01e04:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e06:	1c40      	adds	r0, r0, #1
c0d01e08:	42a8      	cmp	r0, r5
c0d01e0a:	9900      	ldr	r1, [sp, #0]
c0d01e0c:	d3d9      	bcc.n	c0d01dc2 <snprintf+0x366>
c0d01e0e:	900d      	str	r0, [sp, #52]	; 0x34
c0d01e10:	9908      	ldr	r1, [sp, #32]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d01e12:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01e14:	1a08      	subs	r0, r1, r0
c0d01e16:	9b05      	ldr	r3, [sp, #20]
c0d01e18:	4283      	cmp	r3, r0
c0d01e1a:	d800      	bhi.n	c0d01e1e <snprintf+0x3c2>
c0d01e1c:	4603      	mov	r3, r0
c0d01e1e:	4608      	mov	r0, r1
c0d01e20:	4358      	muls	r0, r3
c0d01e22:	1820      	adds	r0, r4, r0
c0d01e24:	900e      	str	r0, [sp, #56]	; 0x38
c0d01e26:	1898      	adds	r0, r3, r2
c0d01e28:	1c43      	adds	r3, r0, #1
c0d01e2a:	e038      	b.n	c0d01e9e <snprintf+0x442>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01e2c:	7808      	ldrb	r0, [r1, #0]
c0d01e2e:	2800      	cmp	r0, #0
c0d01e30:	d023      	beq.n	c0d01e7a <snprintf+0x41e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d01e32:	2005      	movs	r0, #5
c0d01e34:	9d04      	ldr	r5, [sp, #16]
c0d01e36:	2d05      	cmp	r5, #5
c0d01e38:	462c      	mov	r4, r5
c0d01e3a:	d300      	bcc.n	c0d01e3e <snprintf+0x3e2>
c0d01e3c:	4604      	mov	r4, r0
                    os_memmove(str, "ERROR", ulPos);
c0d01e3e:	9807      	ldr	r0, [sp, #28]
c0d01e40:	a12c      	add	r1, pc, #176	; (adr r1, c0d01ef4 <g_pcHex+0x10>)
c0d01e42:	4622      	mov	r2, r4
c0d01e44:	f7ff f9da 	bl	c0d011fc <os_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d01e48:	1b28      	subs	r0, r5, r4
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
                    os_memmove(str, "ERROR", ulPos);
                    str+= ulPos;
c0d01e4a:	9907      	ldr	r1, [sp, #28]
c0d01e4c:	1909      	adds	r1, r1, r4
c0d01e4e:	910e      	str	r1, [sp, #56]	; 0x38
c0d01e50:	4603      	mov	r3, r0
c0d01e52:	2800      	cmp	r0, #0
c0d01e54:	d038      	beq.n	c0d01ec8 <snprintf+0x46c>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01e56:	7830      	ldrb	r0, [r6, #0]
c0d01e58:	2800      	cmp	r0, #0
c0d01e5a:	9908      	ldr	r1, [sp, #32]
c0d01e5c:	d034      	beq.n	c0d01ec8 <snprintf+0x46c>
c0d01e5e:	e61f      	b.n	c0d01aa0 <snprintf+0x44>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01e60:	429d      	cmp	r5, r3
c0d01e62:	d300      	bcc.n	c0d01e66 <snprintf+0x40a>
c0d01e64:	461d      	mov	r5, r3
                        os_memmove(str, pcStr, ulIdx);
c0d01e66:	462a      	mov	r2, r5
c0d01e68:	461c      	mov	r4, r3
c0d01e6a:	f7ff f9c7 	bl	c0d011fc <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01e6e:	1b60      	subs	r0, r4, r5
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01e70:	9907      	ldr	r1, [sp, #28]
c0d01e72:	1949      	adds	r1, r1, r5
c0d01e74:	e00f      	b.n	c0d01e96 <snprintf+0x43a>
c0d01e76:	900e      	str	r0, [sp, #56]	; 0x38
c0d01e78:	e7ed      	b.n	c0d01e56 <snprintf+0x3fa>
c0d01e7a:	9b04      	ldr	r3, [sp, #16]
c0d01e7c:	9c02      	ldr	r4, [sp, #8]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d01e7e:	429c      	cmp	r4, r3
c0d01e80:	d300      	bcc.n	c0d01e84 <snprintf+0x428>
c0d01e82:	461c      	mov	r4, r3
                          os_memset(str, ' ', ulStrlen);
c0d01e84:	2120      	movs	r1, #32
c0d01e86:	9807      	ldr	r0, [sp, #28]
c0d01e88:	4622      	mov	r2, r4
c0d01e8a:	f7ff f9ad 	bl	c0d011e8 <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d01e8e:	9804      	ldr	r0, [sp, #16]
c0d01e90:	1b00      	subs	r0, r0, r4
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d01e92:	9907      	ldr	r1, [sp, #28]
c0d01e94:	1909      	adds	r1, r1, r4
c0d01e96:	910e      	str	r1, [sp, #56]	; 0x38
c0d01e98:	4603      	mov	r3, r0
c0d01e9a:	2800      	cmp	r0, #0
c0d01e9c:	d014      	beq.n	c0d01ec8 <snprintf+0x46c>
c0d01e9e:	980d      	ldr	r0, [sp, #52]	; 0x34

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01ea0:	42a8      	cmp	r0, r5
c0d01ea2:	d9d8      	bls.n	c0d01e56 <snprintf+0x3fa>
                    {
                        ulCount -= ulIdx;
c0d01ea4:	1b42      	subs	r2, r0, r5
                        ulCount = MIN(ulCount, str_size);
c0d01ea6:	429a      	cmp	r2, r3
c0d01ea8:	d300      	bcc.n	c0d01eac <snprintf+0x450>
c0d01eaa:	461a      	mov	r2, r3
                        os_memset(str, ' ', ulCount);
c0d01eac:	2120      	movs	r1, #32
c0d01eae:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01eb0:	4628      	mov	r0, r5
c0d01eb2:	920d      	str	r2, [sp, #52]	; 0x34
c0d01eb4:	461c      	mov	r4, r3
c0d01eb6:	f7ff f997 	bl	c0d011e8 <os_memset>
c0d01eba:	980d      	ldr	r0, [sp, #52]	; 0x34
                        str+= ulCount;
                        str_size -= ulCount;
c0d01ebc:	1a24      	subs	r4, r4, r0
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d01ebe:	182d      	adds	r5, r5, r0
c0d01ec0:	950e      	str	r5, [sp, #56]	; 0x38
c0d01ec2:	4623      	mov	r3, r4
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d01ec4:	2c00      	cmp	r4, #0
c0d01ec6:	d1c6      	bne.n	c0d01e56 <snprintf+0x3fa>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01ec8:	2000      	movs	r0, #0
c0d01eca:	b014      	add	sp, #80	; 0x50
c0d01ecc:	bcf0      	pop	{r4, r5, r6, r7}
c0d01ece:	bc02      	pop	{r1}
c0d01ed0:	b001      	add	sp, #4
c0d01ed2:	4708      	bx	r1

c0d01ed4 <g_pcHex_cap>:
c0d01ed4:	33323130 	.word	0x33323130
c0d01ed8:	37363534 	.word	0x37363534
c0d01edc:	42413938 	.word	0x42413938
c0d01ee0:	46454443 	.word	0x46454443

c0d01ee4 <g_pcHex>:
c0d01ee4:	33323130 	.word	0x33323130
c0d01ee8:	37363534 	.word	0x37363534
c0d01eec:	62613938 	.word	0x62613938
c0d01ef0:	66656463 	.word	0x66656463
c0d01ef4:	4f525245 	.word	0x4f525245
c0d01ef8:	00000052 	.word	0x00000052

c0d01efc <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01efc:	b580      	push	{r7, lr}
c0d01efe:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01f00:	4904      	ldr	r1, [pc, #16]	; (c0d01f14 <pic+0x18>)
c0d01f02:	4288      	cmp	r0, r1
c0d01f04:	d304      	bcc.n	c0d01f10 <pic+0x14>
c0d01f06:	4904      	ldr	r1, [pc, #16]	; (c0d01f18 <pic+0x1c>)
c0d01f08:	4288      	cmp	r0, r1
c0d01f0a:	d201      	bcs.n	c0d01f10 <pic+0x14>
		link_address = pic_internal(link_address);
c0d01f0c:	f000 f806 	bl	c0d01f1c <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01f10:	bd80      	pop	{r7, pc}
c0d01f12:	46c0      	nop			; (mov r8, r8)
c0d01f14:	c0d00000 	.word	0xc0d00000
c0d01f18:	c0d03ec0 	.word	0xc0d03ec0

c0d01f1c <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d01f1c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d01f1e:	4902      	ldr	r1, [pc, #8]	; (c0d01f28 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01f20:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01f22:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01f24:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01f26:	4770      	bx	lr
c0d01f28:	c0d01f1d 	.word	0xc0d01f1d

c0d01f2c <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d01f2c:	b580      	push	{r7, lr}
c0d01f2e:	af00      	add	r7, sp, #0
c0d01f30:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01f32:	490a      	ldr	r1, [pc, #40]	; (c0d01f5c <check_api_level+0x30>)
c0d01f34:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f36:	490a      	ldr	r1, [pc, #40]	; (c0d01f60 <check_api_level+0x34>)
c0d01f38:	680a      	ldr	r2, [r1, #0]
c0d01f3a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d01f3c:	9003      	str	r0, [sp, #12]
c0d01f3e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f40:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01f42:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f44:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01f46:	4807      	ldr	r0, [pc, #28]	; (c0d01f64 <check_api_level+0x38>)
c0d01f48:	9a01      	ldr	r2, [sp, #4]
c0d01f4a:	4282      	cmp	r2, r0
c0d01f4c:	d101      	bne.n	c0d01f52 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01f4e:	b004      	add	sp, #16
c0d01f50:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f52:	6808      	ldr	r0, [r1, #0]
c0d01f54:	2104      	movs	r1, #4
c0d01f56:	f001 fd0d 	bl	c0d03974 <longjmp>
c0d01f5a:	46c0      	nop			; (mov r8, r8)
c0d01f5c:	60000137 	.word	0x60000137
c0d01f60:	20001bb8 	.word	0x20001bb8
c0d01f64:	900001c6 	.word	0x900001c6

c0d01f68 <reset>:
  }
}

void reset ( void ) 
{
c0d01f68:	b580      	push	{r7, lr}
c0d01f6a:	af00      	add	r7, sp, #0
c0d01f6c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d01f6e:	4809      	ldr	r0, [pc, #36]	; (c0d01f94 <reset+0x2c>)
c0d01f70:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01f72:	4809      	ldr	r0, [pc, #36]	; (c0d01f98 <reset+0x30>)
c0d01f74:	6801      	ldr	r1, [r0, #0]
c0d01f76:	9101      	str	r1, [sp, #4]
c0d01f78:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01f7a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01f7c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01f7e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01f80:	4906      	ldr	r1, [pc, #24]	; (c0d01f9c <reset+0x34>)
c0d01f82:	9a00      	ldr	r2, [sp, #0]
c0d01f84:	428a      	cmp	r2, r1
c0d01f86:	d101      	bne.n	c0d01f8c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01f88:	b002      	add	sp, #8
c0d01f8a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01f8c:	6800      	ldr	r0, [r0, #0]
c0d01f8e:	2104      	movs	r1, #4
c0d01f90:	f001 fcf0 	bl	c0d03974 <longjmp>
c0d01f94:	60000200 	.word	0x60000200
c0d01f98:	20001bb8 	.word	0x20001bb8
c0d01f9c:	900002f1 	.word	0x900002f1

c0d01fa0 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01fa0:	b5d0      	push	{r4, r6, r7, lr}
c0d01fa2:	af02      	add	r7, sp, #8
c0d01fa4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_nvm_write_ID_IN;
c0d01fa6:	4b0a      	ldr	r3, [pc, #40]	; (c0d01fd0 <nvm_write+0x30>)
c0d01fa8:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01faa:	4b0a      	ldr	r3, [pc, #40]	; (c0d01fd4 <nvm_write+0x34>)
c0d01fac:	681c      	ldr	r4, [r3, #0]
c0d01fae:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)dst_adr;
c0d01fb0:	ac03      	add	r4, sp, #12
c0d01fb2:	c407      	stmia	r4!, {r0, r1, r2}
c0d01fb4:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)src_adr;
  parameters[4] = (unsigned int)src_len;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01fb6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01fb8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01fba:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
c0d01fbc:	4806      	ldr	r0, [pc, #24]	; (c0d01fd8 <nvm_write+0x38>)
c0d01fbe:	9901      	ldr	r1, [sp, #4]
c0d01fc0:	4281      	cmp	r1, r0
c0d01fc2:	d101      	bne.n	c0d01fc8 <nvm_write+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01fc4:	b006      	add	sp, #24
c0d01fc6:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_nvm_write_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01fc8:	6818      	ldr	r0, [r3, #0]
c0d01fca:	2104      	movs	r1, #4
c0d01fcc:	f001 fcd2 	bl	c0d03974 <longjmp>
c0d01fd0:	6000037f 	.word	0x6000037f
c0d01fd4:	20001bb8 	.word	0x20001bb8
c0d01fd8:	900003bc 	.word	0x900003bc

c0d01fdc <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01fdc:	b580      	push	{r7, lr}
c0d01fde:	af00      	add	r7, sp, #0
c0d01fe0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01fe2:	4a0a      	ldr	r2, [pc, #40]	; (c0d0200c <cx_rng+0x30>)
c0d01fe4:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01fe6:	4a0a      	ldr	r2, [pc, #40]	; (c0d02010 <cx_rng+0x34>)
c0d01fe8:	6813      	ldr	r3, [r2, #0]
c0d01fea:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01fec:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01fee:	9103      	str	r1, [sp, #12]
c0d01ff0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01ff2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01ff4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01ff6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d01ff8:	4906      	ldr	r1, [pc, #24]	; (c0d02014 <cx_rng+0x38>)
c0d01ffa:	9b00      	ldr	r3, [sp, #0]
c0d01ffc:	428b      	cmp	r3, r1
c0d01ffe:	d101      	bne.n	c0d02004 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02000:	b004      	add	sp, #16
c0d02002:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02004:	6810      	ldr	r0, [r2, #0]
c0d02006:	2104      	movs	r1, #4
c0d02008:	f001 fcb4 	bl	c0d03974 <longjmp>
c0d0200c:	6000052c 	.word	0x6000052c
c0d02010:	20001bb8 	.word	0x20001bb8
c0d02014:	90000567 	.word	0x90000567

c0d02018 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d02018:	b580      	push	{r7, lr}
c0d0201a:	af00      	add	r7, sp, #0
c0d0201c:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d0201e:	490a      	ldr	r1, [pc, #40]	; (c0d02048 <cx_sha256_init+0x30>)
c0d02020:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02022:	490a      	ldr	r1, [pc, #40]	; (c0d0204c <cx_sha256_init+0x34>)
c0d02024:	680a      	ldr	r2, [r1, #0]
c0d02026:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d02028:	9003      	str	r0, [sp, #12]
c0d0202a:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0202c:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0202e:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02030:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d02032:	4a07      	ldr	r2, [pc, #28]	; (c0d02050 <cx_sha256_init+0x38>)
c0d02034:	9b01      	ldr	r3, [sp, #4]
c0d02036:	4293      	cmp	r3, r2
c0d02038:	d101      	bne.n	c0d0203e <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0203a:	b004      	add	sp, #16
c0d0203c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0203e:	6808      	ldr	r0, [r1, #0]
c0d02040:	2104      	movs	r1, #4
c0d02042:	f001 fc97 	bl	c0d03974 <longjmp>
c0d02046:	46c0      	nop			; (mov r8, r8)
c0d02048:	600008db 	.word	0x600008db
c0d0204c:	20001bb8 	.word	0x20001bb8
c0d02050:	90000864 	.word	0x90000864

c0d02054 <cx_keccak_init>:
  }
  return (int)ret;
}

int cx_keccak_init ( cx_sha3_t * hash, int size ) 
{
c0d02054:	b580      	push	{r7, lr}
c0d02056:	af00      	add	r7, sp, #0
c0d02058:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_keccak_init_ID_IN;
c0d0205a:	4a0a      	ldr	r2, [pc, #40]	; (c0d02084 <cx_keccak_init+0x30>)
c0d0205c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0205e:	4a0a      	ldr	r2, [pc, #40]	; (c0d02088 <cx_keccak_init+0x34>)
c0d02060:	6813      	ldr	r3, [r2, #0]
c0d02062:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)hash;
c0d02064:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)size;
c0d02066:	9103      	str	r1, [sp, #12]
c0d02068:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0206a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0206c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0206e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
c0d02070:	4906      	ldr	r1, [pc, #24]	; (c0d0208c <cx_keccak_init+0x38>)
c0d02072:	9b00      	ldr	r3, [sp, #0]
c0d02074:	428b      	cmp	r3, r1
c0d02076:	d101      	bne.n	c0d0207c <cx_keccak_init+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02078:	b004      	add	sp, #16
c0d0207a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_keccak_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0207c:	6810      	ldr	r0, [r2, #0]
c0d0207e:	2104      	movs	r1, #4
c0d02080:	f001 fc78 	bl	c0d03974 <longjmp>
c0d02084:	60000c3c 	.word	0x60000c3c
c0d02088:	20001bb8 	.word	0x20001bb8
c0d0208c:	90000c39 	.word	0x90000c39

c0d02090 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d02090:	b5b0      	push	{r4, r5, r7, lr}
c0d02092:	af02      	add	r7, sp, #8
c0d02094:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d02096:	4c0b      	ldr	r4, [pc, #44]	; (c0d020c4 <cx_hash+0x34>)
c0d02098:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0209a:	4c0b      	ldr	r4, [pc, #44]	; (c0d020c8 <cx_hash+0x38>)
c0d0209c:	6825      	ldr	r5, [r4, #0]
c0d0209e:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d020a0:	ad03      	add	r5, sp, #12
c0d020a2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d020a4:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d020a6:	9007      	str	r0, [sp, #28]
c0d020a8:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020aa:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020ac:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020ae:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d020b0:	4906      	ldr	r1, [pc, #24]	; (c0d020cc <cx_hash+0x3c>)
c0d020b2:	9a01      	ldr	r2, [sp, #4]
c0d020b4:	428a      	cmp	r2, r1
c0d020b6:	d101      	bne.n	c0d020bc <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d020b8:	b008      	add	sp, #32
c0d020ba:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020bc:	6820      	ldr	r0, [r4, #0]
c0d020be:	2104      	movs	r1, #4
c0d020c0:	f001 fc58 	bl	c0d03974 <longjmp>
c0d020c4:	60000ea6 	.word	0x60000ea6
c0d020c8:	20001bb8 	.word	0x20001bb8
c0d020cc:	90000e46 	.word	0x90000e46

c0d020d0 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d020d0:	b5b0      	push	{r4, r5, r7, lr}
c0d020d2:	af02      	add	r7, sp, #8
c0d020d4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_public_key_ID_IN;
c0d020d6:	4c0a      	ldr	r4, [pc, #40]	; (c0d02100 <cx_ecfp_init_public_key+0x30>)
c0d020d8:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d020da:	4c0a      	ldr	r4, [pc, #40]	; (c0d02104 <cx_ecfp_init_public_key+0x34>)
c0d020dc:	6825      	ldr	r5, [r4, #0]
c0d020de:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d020e0:	ad02      	add	r5, sp, #8
c0d020e2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d020e4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d020e6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d020e8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d020ea:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
c0d020ec:	4906      	ldr	r1, [pc, #24]	; (c0d02108 <cx_ecfp_init_public_key+0x38>)
c0d020ee:	9a00      	ldr	r2, [sp, #0]
c0d020f0:	428a      	cmp	r2, r1
c0d020f2:	d101      	bne.n	c0d020f8 <cx_ecfp_init_public_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d020f4:	b006      	add	sp, #24
c0d020f6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_public_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d020f8:	6820      	ldr	r0, [r4, #0]
c0d020fa:	2104      	movs	r1, #4
c0d020fc:	f001 fc3a 	bl	c0d03974 <longjmp>
c0d02100:	60002835 	.word	0x60002835
c0d02104:	20001bb8 	.word	0x20001bb8
c0d02108:	900028f0 	.word	0x900028f0

c0d0210c <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d0210c:	b5b0      	push	{r4, r5, r7, lr}
c0d0210e:	af02      	add	r7, sp, #8
c0d02110:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d02112:	4c0a      	ldr	r4, [pc, #40]	; (c0d0213c <cx_ecfp_init_private_key+0x30>)
c0d02114:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02116:	4c0a      	ldr	r4, [pc, #40]	; (c0d02140 <cx_ecfp_init_private_key+0x34>)
c0d02118:	6825      	ldr	r5, [r4, #0]
c0d0211a:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d0211c:	ad02      	add	r5, sp, #8
c0d0211e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02120:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02122:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02124:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02126:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d02128:	4906      	ldr	r1, [pc, #24]	; (c0d02144 <cx_ecfp_init_private_key+0x38>)
c0d0212a:	9a00      	ldr	r2, [sp, #0]
c0d0212c:	428a      	cmp	r2, r1
c0d0212e:	d101      	bne.n	c0d02134 <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02130:	b006      	add	sp, #24
c0d02132:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02134:	6820      	ldr	r0, [r4, #0]
c0d02136:	2104      	movs	r1, #4
c0d02138:	f001 fc1c 	bl	c0d03974 <longjmp>
c0d0213c:	600029ed 	.word	0x600029ed
c0d02140:	20001bb8 	.word	0x20001bb8
c0d02144:	900029ae 	.word	0x900029ae

c0d02148 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d02148:	b5b0      	push	{r4, r5, r7, lr}
c0d0214a:	af02      	add	r7, sp, #8
c0d0214c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d0214e:	4c0a      	ldr	r4, [pc, #40]	; (c0d02178 <cx_ecfp_generate_pair+0x30>)
c0d02150:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02152:	4c0a      	ldr	r4, [pc, #40]	; (c0d0217c <cx_ecfp_generate_pair+0x34>)
c0d02154:	6825      	ldr	r5, [r4, #0]
c0d02156:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d02158:	ad02      	add	r5, sp, #8
c0d0215a:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d0215c:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0215e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02160:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02162:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d02164:	4906      	ldr	r1, [pc, #24]	; (c0d02180 <cx_ecfp_generate_pair+0x38>)
c0d02166:	9a00      	ldr	r2, [sp, #0]
c0d02168:	428a      	cmp	r2, r1
c0d0216a:	d101      	bne.n	c0d02170 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0216c:	b006      	add	sp, #24
c0d0216e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02170:	6820      	ldr	r0, [r4, #0]
c0d02172:	2104      	movs	r1, #4
c0d02174:	f001 fbfe 	bl	c0d03974 <longjmp>
c0d02178:	60002a2e 	.word	0x60002a2e
c0d0217c:	20001bb8 	.word	0x20001bb8
c0d02180:	90002a74 	.word	0x90002a74

c0d02184 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02184:	b5b0      	push	{r4, r5, r7, lr}
c0d02186:	af02      	add	r7, sp, #8
c0d02188:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d0218a:	4c0b      	ldr	r4, [pc, #44]	; (c0d021b8 <os_perso_derive_node_bip32+0x34>)
c0d0218c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0218e:	4c0b      	ldr	r4, [pc, #44]	; (c0d021bc <os_perso_derive_node_bip32+0x38>)
c0d02190:	6825      	ldr	r5, [r4, #0]
c0d02192:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d02194:	ad03      	add	r5, sp, #12
c0d02196:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d02198:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d0219a:	9007      	str	r0, [sp, #28]
c0d0219c:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0219e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021a0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021a2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d021a4:	4806      	ldr	r0, [pc, #24]	; (c0d021c0 <os_perso_derive_node_bip32+0x3c>)
c0d021a6:	9901      	ldr	r1, [sp, #4]
c0d021a8:	4281      	cmp	r1, r0
c0d021aa:	d101      	bne.n	c0d021b0 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021ac:	b008      	add	sp, #32
c0d021ae:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021b0:	6820      	ldr	r0, [r4, #0]
c0d021b2:	2104      	movs	r1, #4
c0d021b4:	f001 fbde 	bl	c0d03974 <longjmp>
c0d021b8:	6000512b 	.word	0x6000512b
c0d021bc:	20001bb8 	.word	0x20001bb8
c0d021c0:	9000517f 	.word	0x9000517f

c0d021c4 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d021c4:	b580      	push	{r7, lr}
c0d021c6:	af00      	add	r7, sp, #0
c0d021c8:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d021ca:	490a      	ldr	r1, [pc, #40]	; (c0d021f4 <os_sched_exit+0x30>)
c0d021cc:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d021ce:	490a      	ldr	r1, [pc, #40]	; (c0d021f8 <os_sched_exit+0x34>)
c0d021d0:	680a      	ldr	r2, [r1, #0]
c0d021d2:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d021d4:	9003      	str	r0, [sp, #12]
c0d021d6:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d021d8:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d021da:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d021dc:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d021de:	4807      	ldr	r0, [pc, #28]	; (c0d021fc <os_sched_exit+0x38>)
c0d021e0:	9a01      	ldr	r2, [sp, #4]
c0d021e2:	4282      	cmp	r2, r0
c0d021e4:	d101      	bne.n	c0d021ea <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d021e6:	b004      	add	sp, #16
c0d021e8:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d021ea:	6808      	ldr	r0, [r1, #0]
c0d021ec:	2104      	movs	r1, #4
c0d021ee:	f001 fbc1 	bl	c0d03974 <longjmp>
c0d021f2:	46c0      	nop			; (mov r8, r8)
c0d021f4:	60005fe1 	.word	0x60005fe1
c0d021f8:	20001bb8 	.word	0x20001bb8
c0d021fc:	90005f6f 	.word	0x90005f6f

c0d02200 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d02200:	b580      	push	{r7, lr}
c0d02202:	af00      	add	r7, sp, #0
c0d02204:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d02206:	490a      	ldr	r1, [pc, #40]	; (c0d02230 <os_ux+0x30>)
c0d02208:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0220a:	490a      	ldr	r1, [pc, #40]	; (c0d02234 <os_ux+0x34>)
c0d0220c:	680a      	ldr	r2, [r1, #0]
c0d0220e:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d02210:	9003      	str	r0, [sp, #12]
c0d02212:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d02214:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02216:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02218:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d0221a:	4a07      	ldr	r2, [pc, #28]	; (c0d02238 <os_ux+0x38>)
c0d0221c:	9b01      	ldr	r3, [sp, #4]
c0d0221e:	4293      	cmp	r3, r2
c0d02220:	d101      	bne.n	c0d02226 <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d02222:	b004      	add	sp, #16
c0d02224:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02226:	6808      	ldr	r0, [r1, #0]
c0d02228:	2104      	movs	r1, #4
c0d0222a:	f001 fba3 	bl	c0d03974 <longjmp>
c0d0222e:	46c0      	nop			; (mov r8, r8)
c0d02230:	60006158 	.word	0x60006158
c0d02234:	20001bb8 	.word	0x20001bb8
c0d02238:	9000611f 	.word	0x9000611f

c0d0223c <os_seph_features>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_features ( void ) 
{
c0d0223c:	b580      	push	{r7, lr}
c0d0223e:	af00      	add	r7, sp, #0
c0d02240:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_seph_features_ID_IN;
c0d02242:	4809      	ldr	r0, [pc, #36]	; (c0d02268 <os_seph_features+0x2c>)
c0d02244:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d02246:	4909      	ldr	r1, [pc, #36]	; (c0d0226c <os_seph_features+0x30>)
c0d02248:	6808      	ldr	r0, [r1, #0]
c0d0224a:	9001      	str	r0, [sp, #4]
c0d0224c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0224e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02250:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02252:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
c0d02254:	4a06      	ldr	r2, [pc, #24]	; (c0d02270 <os_seph_features+0x34>)
c0d02256:	9b00      	ldr	r3, [sp, #0]
c0d02258:	4293      	cmp	r3, r2
c0d0225a:	d101      	bne.n	c0d02260 <os_seph_features+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0225c:	b002      	add	sp, #8
c0d0225e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_seph_features_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02260:	6808      	ldr	r0, [r1, #0]
c0d02262:	2104      	movs	r1, #4
c0d02264:	f001 fb86 	bl	c0d03974 <longjmp>
c0d02268:	600064d6 	.word	0x600064d6
c0d0226c:	20001bb8 	.word	0x20001bb8
c0d02270:	90006444 	.word	0x90006444

c0d02274 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d02274:	b580      	push	{r7, lr}
c0d02276:	af00      	add	r7, sp, #0
c0d02278:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0227a:	4a0a      	ldr	r2, [pc, #40]	; (c0d022a4 <io_seproxyhal_spi_send+0x30>)
c0d0227c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0227e:	4a0a      	ldr	r2, [pc, #40]	; (c0d022a8 <io_seproxyhal_spi_send+0x34>)
c0d02280:	6813      	ldr	r3, [r2, #0]
c0d02282:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d02284:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d02286:	9103      	str	r1, [sp, #12]
c0d02288:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0228a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0228c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0228e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d02290:	4806      	ldr	r0, [pc, #24]	; (c0d022ac <io_seproxyhal_spi_send+0x38>)
c0d02292:	9900      	ldr	r1, [sp, #0]
c0d02294:	4281      	cmp	r1, r0
c0d02296:	d101      	bne.n	c0d0229c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02298:	b004      	add	sp, #16
c0d0229a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0229c:	6810      	ldr	r0, [r2, #0]
c0d0229e:	2104      	movs	r1, #4
c0d022a0:	f001 fb68 	bl	c0d03974 <longjmp>
c0d022a4:	60006a1c 	.word	0x60006a1c
c0d022a8:	20001bb8 	.word	0x20001bb8
c0d022ac:	90006af3 	.word	0x90006af3

c0d022b0 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d022b0:	b580      	push	{r7, lr}
c0d022b2:	af00      	add	r7, sp, #0
c0d022b4:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d022b6:	4809      	ldr	r0, [pc, #36]	; (c0d022dc <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d022b8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022ba:	4909      	ldr	r1, [pc, #36]	; (c0d022e0 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d022bc:	6808      	ldr	r0, [r1, #0]
c0d022be:	9001      	str	r0, [sp, #4]
c0d022c0:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022c2:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d022c4:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d022c6:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d022c8:	4a06      	ldr	r2, [pc, #24]	; (c0d022e4 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d022ca:	9b00      	ldr	r3, [sp, #0]
c0d022cc:	4293      	cmp	r3, r2
c0d022ce:	d101      	bne.n	c0d022d4 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d022d0:	b002      	add	sp, #8
c0d022d2:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d022d4:	6808      	ldr	r0, [r1, #0]
c0d022d6:	2104      	movs	r1, #4
c0d022d8:	f001 fb4c 	bl	c0d03974 <longjmp>
c0d022dc:	60006bcf 	.word	0x60006bcf
c0d022e0:	20001bb8 	.word	0x20001bb8
c0d022e4:	90006b7f 	.word	0x90006b7f

c0d022e8 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d022e8:	b5d0      	push	{r4, r6, r7, lr}
c0d022ea:	af02      	add	r7, sp, #8
c0d022ec:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d022ee:	4b0b      	ldr	r3, [pc, #44]	; (c0d0231c <io_seproxyhal_spi_recv+0x34>)
c0d022f0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d022f2:	4b0b      	ldr	r3, [pc, #44]	; (c0d02320 <io_seproxyhal_spi_recv+0x38>)
c0d022f4:	681c      	ldr	r4, [r3, #0]
c0d022f6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d022f8:	ac03      	add	r4, sp, #12
c0d022fa:	c407      	stmia	r4!, {r0, r1, r2}
c0d022fc:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d022fe:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d02300:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d02302:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d02304:	4907      	ldr	r1, [pc, #28]	; (c0d02324 <io_seproxyhal_spi_recv+0x3c>)
c0d02306:	9a01      	ldr	r2, [sp, #4]
c0d02308:	428a      	cmp	r2, r1
c0d0230a:	d102      	bne.n	c0d02312 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d0230c:	b280      	uxth	r0, r0
c0d0230e:	b006      	add	sp, #24
c0d02310:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d02312:	6818      	ldr	r0, [r3, #0]
c0d02314:	2104      	movs	r1, #4
c0d02316:	f001 fb2d 	bl	c0d03974 <longjmp>
c0d0231a:	46c0      	nop			; (mov r8, r8)
c0d0231c:	60006cd1 	.word	0x60006cd1
c0d02320:	20001bb8 	.word	0x20001bb8
c0d02324:	90006c2b 	.word	0x90006c2b

c0d02328 <bagl_ui_nanos_screen1_button>:
/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
---------------------------------------------------------------
--------------------------------------------------------------- */
unsigned int
bagl_ui_nanos_screen1_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d02328:	b5b0      	push	{r4, r5, r7, lr}
c0d0232a:	af02      	add	r7, sp, #8
    switch (button_mask) {
c0d0232c:	492c      	ldr	r1, [pc, #176]	; (c0d023e0 <bagl_ui_nanos_screen1_button+0xb8>)
c0d0232e:	4288      	cmp	r0, r1
c0d02330:	d006      	beq.n	c0d02340 <bagl_ui_nanos_screen1_button+0x18>
c0d02332:	492c      	ldr	r1, [pc, #176]	; (c0d023e4 <bagl_ui_nanos_screen1_button+0xbc>)
c0d02334:	4288      	cmp	r0, r1
c0d02336:	d151      	bne.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>



const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d02338:	2000      	movs	r0, #0
c0d0233a:	f7ff ff43 	bl	c0d021c4 <os_sched_exit>
c0d0233e:	e04d      	b.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // Next
        if(nvram_is_init()) {
c0d02340:	f7fe fba4 	bl	c0d00a8c <nvram_is_init>
c0d02344:	2801      	cmp	r0, #1
c0d02346:	d102      	bne.n	c0d0234e <bagl_ui_nanos_screen1_button+0x26>
            write_debug("Still uninit", sizeof("Still uninit"), TYPE_STR);
c0d02348:	a029      	add	r0, pc, #164	; (adr r0, c0d023f0 <bagl_ui_nanos_screen1_button+0xc8>)
c0d0234a:	210d      	movs	r1, #13
c0d0234c:	e001      	b.n	c0d02352 <bagl_ui_nanos_screen1_button+0x2a>
        }
        else {
            write_debug("INIT", sizeof("INIT"), TYPE_STR);
c0d0234e:	a026      	add	r0, pc, #152	; (adr r0, c0d023e8 <bagl_ui_nanos_screen1_button+0xc0>)
c0d02350:	2105      	movs	r1, #5
c0d02352:	2203      	movs	r2, #3
c0d02354:	f7fd fea6 	bl	c0d000a4 <write_debug>
        }
        
        UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02358:	4c29      	ldr	r4, [pc, #164]	; (c0d02400 <bagl_ui_nanos_screen1_button+0xd8>)
c0d0235a:	482b      	ldr	r0, [pc, #172]	; (c0d02408 <bagl_ui_nanos_screen1_button+0xe0>)
c0d0235c:	4478      	add	r0, pc
c0d0235e:	6020      	str	r0, [r4, #0]
c0d02360:	2004      	movs	r0, #4
c0d02362:	6060      	str	r0, [r4, #4]
c0d02364:	4829      	ldr	r0, [pc, #164]	; (c0d0240c <bagl_ui_nanos_screen1_button+0xe4>)
c0d02366:	4478      	add	r0, pc
c0d02368:	6120      	str	r0, [r4, #16]
c0d0236a:	2500      	movs	r5, #0
c0d0236c:	60e5      	str	r5, [r4, #12]
c0d0236e:	2003      	movs	r0, #3
c0d02370:	7620      	strb	r0, [r4, #24]
c0d02372:	61e5      	str	r5, [r4, #28]
c0d02374:	4620      	mov	r0, r4
c0d02376:	3018      	adds	r0, #24
c0d02378:	f7ff ff42 	bl	c0d02200 <os_ux>
c0d0237c:	61e0      	str	r0, [r4, #28]
c0d0237e:	f7ff f903 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d02382:	60a5      	str	r5, [r4, #8]
c0d02384:	6820      	ldr	r0, [r4, #0]
c0d02386:	2800      	cmp	r0, #0
c0d02388:	d028      	beq.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
c0d0238a:	69e0      	ldr	r0, [r4, #28]
c0d0238c:	491d      	ldr	r1, [pc, #116]	; (c0d02404 <bagl_ui_nanos_screen1_button+0xdc>)
c0d0238e:	4288      	cmp	r0, r1
c0d02390:	d116      	bne.n	c0d023c0 <bagl_ui_nanos_screen1_button+0x98>
c0d02392:	e023      	b.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
c0d02394:	6860      	ldr	r0, [r4, #4]
c0d02396:	4285      	cmp	r5, r0
c0d02398:	d220      	bcs.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
c0d0239a:	f7ff ff89 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d0239e:	2800      	cmp	r0, #0
c0d023a0:	d11c      	bne.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
c0d023a2:	68a0      	ldr	r0, [r4, #8]
c0d023a4:	68e1      	ldr	r1, [r4, #12]
c0d023a6:	2538      	movs	r5, #56	; 0x38
c0d023a8:	4368      	muls	r0, r5
c0d023aa:	6822      	ldr	r2, [r4, #0]
c0d023ac:	1810      	adds	r0, r2, r0
c0d023ae:	2900      	cmp	r1, #0
c0d023b0:	d009      	beq.n	c0d023c6 <bagl_ui_nanos_screen1_button+0x9e>
c0d023b2:	4788      	blx	r1
c0d023b4:	2800      	cmp	r0, #0
c0d023b6:	d106      	bne.n	c0d023c6 <bagl_ui_nanos_screen1_button+0x9e>
c0d023b8:	68a0      	ldr	r0, [r4, #8]
c0d023ba:	1c45      	adds	r5, r0, #1
c0d023bc:	60a5      	str	r5, [r4, #8]
c0d023be:	6820      	ldr	r0, [r4, #0]
c0d023c0:	2800      	cmp	r0, #0
c0d023c2:	d1e7      	bne.n	c0d02394 <bagl_ui_nanos_screen1_button+0x6c>
c0d023c4:	e00a      	b.n	c0d023dc <bagl_ui_nanos_screen1_button+0xb4>
c0d023c6:	2801      	cmp	r0, #1
c0d023c8:	d103      	bne.n	c0d023d2 <bagl_ui_nanos_screen1_button+0xaa>
c0d023ca:	68a0      	ldr	r0, [r4, #8]
c0d023cc:	4345      	muls	r5, r0
c0d023ce:	6820      	ldr	r0, [r4, #0]
c0d023d0:	1940      	adds	r0, r0, r5
c0d023d2:	f7fe fb91 	bl	c0d00af8 <io_seproxyhal_display>
c0d023d6:	68a0      	ldr	r0, [r4, #8]
c0d023d8:	1c40      	adds	r0, r0, #1
c0d023da:	60a0      	str	r0, [r4, #8]
        break;
    }
    return 0;
c0d023dc:	2000      	movs	r0, #0
c0d023de:	bdb0      	pop	{r4, r5, r7, pc}
c0d023e0:	80000002 	.word	0x80000002
c0d023e4:	80000001 	.word	0x80000001
c0d023e8:	54494e49 	.word	0x54494e49
c0d023ec:	00000000 	.word	0x00000000
c0d023f0:	6c697453 	.word	0x6c697453
c0d023f4:	6e75206c 	.word	0x6e75206c
c0d023f8:	74696e69 	.word	0x74696e69
c0d023fc:	00000000 	.word	0x00000000
c0d02400:	20001a98 	.word	0x20001a98
c0d02404:	b0105044 	.word	0xb0105044
c0d02408:	00001854 	.word	0x00001854
c0d0240c:	00000153 	.word	0x00000153

c0d02410 <ui_display_debug>:
--------------------------------------------------------- */
void ui_display_main() {
	UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
}

void ui_display_debug(void *o, unsigned int sz, uint8_t t) {
c0d02410:	b5b0      	push	{r4, r5, r7, lr}
c0d02412:	af02      	add	r7, sp, #8
	if(o != NULL && sz > 0 && t>0)
c0d02414:	2800      	cmp	r0, #0
c0d02416:	d005      	beq.n	c0d02424 <ui_display_debug+0x14>
c0d02418:	2900      	cmp	r1, #0
c0d0241a:	d003      	beq.n	c0d02424 <ui_display_debug+0x14>
c0d0241c:	2a00      	cmp	r2, #0
c0d0241e:	d001      	beq.n	c0d02424 <ui_display_debug+0x14>
		write_debug(o, sz, t);
c0d02420:	f7fd fe40 	bl	c0d000a4 <write_debug>
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
c0d02424:	4c21      	ldr	r4, [pc, #132]	; (c0d024ac <ui_display_debug+0x9c>)
c0d02426:	4823      	ldr	r0, [pc, #140]	; (c0d024b4 <ui_display_debug+0xa4>)
c0d02428:	4478      	add	r0, pc
c0d0242a:	6020      	str	r0, [r4, #0]
c0d0242c:	2004      	movs	r0, #4
c0d0242e:	6060      	str	r0, [r4, #4]
c0d02430:	4821      	ldr	r0, [pc, #132]	; (c0d024b8 <ui_display_debug+0xa8>)
c0d02432:	4478      	add	r0, pc
c0d02434:	6120      	str	r0, [r4, #16]
c0d02436:	2500      	movs	r5, #0
c0d02438:	60e5      	str	r5, [r4, #12]
c0d0243a:	2003      	movs	r0, #3
c0d0243c:	7620      	strb	r0, [r4, #24]
c0d0243e:	61e5      	str	r5, [r4, #28]
c0d02440:	4620      	mov	r0, r4
c0d02442:	3018      	adds	r0, #24
c0d02444:	f7ff fedc 	bl	c0d02200 <os_ux>
c0d02448:	61e0      	str	r0, [r4, #28]
c0d0244a:	f7ff f89d 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d0244e:	60a5      	str	r5, [r4, #8]
c0d02450:	6820      	ldr	r0, [r4, #0]
c0d02452:	2800      	cmp	r0, #0
c0d02454:	d028      	beq.n	c0d024a8 <ui_display_debug+0x98>
c0d02456:	69e0      	ldr	r0, [r4, #28]
c0d02458:	4915      	ldr	r1, [pc, #84]	; (c0d024b0 <ui_display_debug+0xa0>)
c0d0245a:	4288      	cmp	r0, r1
c0d0245c:	d116      	bne.n	c0d0248c <ui_display_debug+0x7c>
c0d0245e:	e023      	b.n	c0d024a8 <ui_display_debug+0x98>
c0d02460:	6860      	ldr	r0, [r4, #4]
c0d02462:	4285      	cmp	r5, r0
c0d02464:	d220      	bcs.n	c0d024a8 <ui_display_debug+0x98>
c0d02466:	f7ff ff23 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d0246a:	2800      	cmp	r0, #0
c0d0246c:	d11c      	bne.n	c0d024a8 <ui_display_debug+0x98>
c0d0246e:	68a0      	ldr	r0, [r4, #8]
c0d02470:	68e1      	ldr	r1, [r4, #12]
c0d02472:	2538      	movs	r5, #56	; 0x38
c0d02474:	4368      	muls	r0, r5
c0d02476:	6822      	ldr	r2, [r4, #0]
c0d02478:	1810      	adds	r0, r2, r0
c0d0247a:	2900      	cmp	r1, #0
c0d0247c:	d009      	beq.n	c0d02492 <ui_display_debug+0x82>
c0d0247e:	4788      	blx	r1
c0d02480:	2800      	cmp	r0, #0
c0d02482:	d106      	bne.n	c0d02492 <ui_display_debug+0x82>
c0d02484:	68a0      	ldr	r0, [r4, #8]
c0d02486:	1c45      	adds	r5, r0, #1
c0d02488:	60a5      	str	r5, [r4, #8]
c0d0248a:	6820      	ldr	r0, [r4, #0]
c0d0248c:	2800      	cmp	r0, #0
c0d0248e:	d1e7      	bne.n	c0d02460 <ui_display_debug+0x50>
c0d02490:	e00a      	b.n	c0d024a8 <ui_display_debug+0x98>
c0d02492:	2801      	cmp	r0, #1
c0d02494:	d103      	bne.n	c0d0249e <ui_display_debug+0x8e>
c0d02496:	68a0      	ldr	r0, [r4, #8]
c0d02498:	4345      	muls	r5, r0
c0d0249a:	6820      	ldr	r0, [r4, #0]
c0d0249c:	1940      	adds	r0, r0, r5
c0d0249e:	f7fe fb2b 	bl	c0d00af8 <io_seproxyhal_display>
c0d024a2:	68a0      	ldr	r0, [r4, #8]
c0d024a4:	1c40      	adds	r0, r0, #1
c0d024a6:	60a0      	str	r0, [r4, #8]
}
c0d024a8:	bdb0      	pop	{r4, r5, r7, pc}
c0d024aa:	46c0      	nop			; (mov r8, r8)
c0d024ac:	20001a98 	.word	0x20001a98
c0d024b0:	b0105044 	.word	0xb0105044
c0d024b4:	00001788 	.word	0x00001788
c0d024b8:	00000087 	.word	0x00000087

c0d024bc <bagl_ui_nanos_screen2_button>:
    return 0;
}

unsigned int
bagl_ui_nanos_screen2_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d024bc:	b580      	push	{r7, lr}
c0d024be:	af00      	add	r7, sp, #0
    switch (button_mask) {
c0d024c0:	4905      	ldr	r1, [pc, #20]	; (c0d024d8 <bagl_ui_nanos_screen2_button+0x1c>)
c0d024c2:	4288      	cmp	r0, r1
c0d024c4:	d002      	beq.n	c0d024cc <bagl_ui_nanos_screen2_button+0x10>
c0d024c6:	4905      	ldr	r1, [pc, #20]	; (c0d024dc <bagl_ui_nanos_screen2_button+0x20>)
c0d024c8:	4288      	cmp	r0, r1
c0d024ca:	d102      	bne.n	c0d024d2 <bagl_ui_nanos_screen2_button+0x16>
c0d024cc:	2000      	movs	r0, #0
c0d024ce:	f7ff fe79 	bl	c0d021c4 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d024d2:	2000      	movs	r0, #0
c0d024d4:	bd80      	pop	{r7, pc}
c0d024d6:	46c0      	nop			; (mov r8, r8)
c0d024d8:	80000002 	.word	0x80000002
c0d024dc:	80000001 	.word	0x80000001

c0d024e0 <ui_idle>:
	if(o != NULL && sz > 0 && t>0)
		write_debug(o, sz, t);
	UX_DISPLAY(bagl_ui_nanos_screen2, NULL);
}

void ui_idle(void) {
c0d024e0:	b5b0      	push	{r4, r5, r7, lr}
c0d024e2:	af02      	add	r7, sp, #8
    if (os_seph_features() &
c0d024e4:	2001      	movs	r0, #1
c0d024e6:	0204      	lsls	r4, r0, #8
c0d024e8:	f7ff fea8 	bl	c0d0223c <os_seph_features>
c0d024ec:	4220      	tst	r0, r4
c0d024ee:	d136      	bne.n	c0d0255e <ui_idle+0x7e>
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
c0d024f0:	4c3c      	ldr	r4, [pc, #240]	; (c0d025e4 <ui_idle+0x104>)
c0d024f2:	4840      	ldr	r0, [pc, #256]	; (c0d025f4 <ui_idle+0x114>)
c0d024f4:	4478      	add	r0, pc
c0d024f6:	6020      	str	r0, [r4, #0]
c0d024f8:	2004      	movs	r0, #4
c0d024fa:	6060      	str	r0, [r4, #4]
c0d024fc:	483e      	ldr	r0, [pc, #248]	; (c0d025f8 <ui_idle+0x118>)
c0d024fe:	4478      	add	r0, pc
c0d02500:	6120      	str	r0, [r4, #16]
c0d02502:	2500      	movs	r5, #0
c0d02504:	60e5      	str	r5, [r4, #12]
c0d02506:	2003      	movs	r0, #3
c0d02508:	7620      	strb	r0, [r4, #24]
c0d0250a:	61e5      	str	r5, [r4, #28]
c0d0250c:	4620      	mov	r0, r4
c0d0250e:	3018      	adds	r0, #24
c0d02510:	f7ff fe76 	bl	c0d02200 <os_ux>
c0d02514:	61e0      	str	r0, [r4, #28]
c0d02516:	f7ff f837 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d0251a:	60a5      	str	r5, [r4, #8]
c0d0251c:	6820      	ldr	r0, [r4, #0]
c0d0251e:	2800      	cmp	r0, #0
c0d02520:	d05f      	beq.n	c0d025e2 <ui_idle+0x102>
c0d02522:	69e0      	ldr	r0, [r4, #28]
c0d02524:	4930      	ldr	r1, [pc, #192]	; (c0d025e8 <ui_idle+0x108>)
c0d02526:	4288      	cmp	r0, r1
c0d02528:	d116      	bne.n	c0d02558 <ui_idle+0x78>
c0d0252a:	e05a      	b.n	c0d025e2 <ui_idle+0x102>
c0d0252c:	6860      	ldr	r0, [r4, #4]
c0d0252e:	4285      	cmp	r5, r0
c0d02530:	d257      	bcs.n	c0d025e2 <ui_idle+0x102>
c0d02532:	f7ff febd 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d02536:	2800      	cmp	r0, #0
c0d02538:	d153      	bne.n	c0d025e2 <ui_idle+0x102>
c0d0253a:	68a0      	ldr	r0, [r4, #8]
c0d0253c:	68e1      	ldr	r1, [r4, #12]
c0d0253e:	2538      	movs	r5, #56	; 0x38
c0d02540:	4368      	muls	r0, r5
c0d02542:	6822      	ldr	r2, [r4, #0]
c0d02544:	1810      	adds	r0, r2, r0
c0d02546:	2900      	cmp	r1, #0
c0d02548:	d040      	beq.n	c0d025cc <ui_idle+0xec>
c0d0254a:	4788      	blx	r1
c0d0254c:	2800      	cmp	r0, #0
c0d0254e:	d13d      	bne.n	c0d025cc <ui_idle+0xec>
c0d02550:	68a0      	ldr	r0, [r4, #8]
c0d02552:	1c45      	adds	r5, r0, #1
c0d02554:	60a5      	str	r5, [r4, #8]
c0d02556:	6820      	ldr	r0, [r4, #0]
c0d02558:	2800      	cmp	r0, #0
c0d0255a:	d1e7      	bne.n	c0d0252c <ui_idle+0x4c>
c0d0255c:	e041      	b.n	c0d025e2 <ui_idle+0x102>
}

void ui_idle(void) {
    if (os_seph_features() &
        SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_SCREEN_BIG) {
        UX_DISPLAY(bagl_ui_sample_blue, NULL);
c0d0255e:	4c21      	ldr	r4, [pc, #132]	; (c0d025e4 <ui_idle+0x104>)
c0d02560:	4822      	ldr	r0, [pc, #136]	; (c0d025ec <ui_idle+0x10c>)
c0d02562:	4478      	add	r0, pc
c0d02564:	6020      	str	r0, [r4, #0]
c0d02566:	2004      	movs	r0, #4
c0d02568:	6060      	str	r0, [r4, #4]
c0d0256a:	4821      	ldr	r0, [pc, #132]	; (c0d025f0 <ui_idle+0x110>)
c0d0256c:	4478      	add	r0, pc
c0d0256e:	6120      	str	r0, [r4, #16]
c0d02570:	2500      	movs	r5, #0
c0d02572:	60e5      	str	r5, [r4, #12]
c0d02574:	2003      	movs	r0, #3
c0d02576:	7620      	strb	r0, [r4, #24]
c0d02578:	61e5      	str	r5, [r4, #28]
c0d0257a:	4620      	mov	r0, r4
c0d0257c:	3018      	adds	r0, #24
c0d0257e:	f7ff fe3f 	bl	c0d02200 <os_ux>
c0d02582:	61e0      	str	r0, [r4, #28]
c0d02584:	f7ff f800 	bl	c0d01588 <io_seproxyhal_init_ux>
c0d02588:	60a5      	str	r5, [r4, #8]
c0d0258a:	6820      	ldr	r0, [r4, #0]
c0d0258c:	2800      	cmp	r0, #0
c0d0258e:	d028      	beq.n	c0d025e2 <ui_idle+0x102>
c0d02590:	69e0      	ldr	r0, [r4, #28]
c0d02592:	4915      	ldr	r1, [pc, #84]	; (c0d025e8 <ui_idle+0x108>)
c0d02594:	4288      	cmp	r0, r1
c0d02596:	d116      	bne.n	c0d025c6 <ui_idle+0xe6>
c0d02598:	e023      	b.n	c0d025e2 <ui_idle+0x102>
c0d0259a:	6860      	ldr	r0, [r4, #4]
c0d0259c:	4285      	cmp	r5, r0
c0d0259e:	d220      	bcs.n	c0d025e2 <ui_idle+0x102>
c0d025a0:	f7ff fe86 	bl	c0d022b0 <io_seproxyhal_spi_is_status_sent>
c0d025a4:	2800      	cmp	r0, #0
c0d025a6:	d11c      	bne.n	c0d025e2 <ui_idle+0x102>
c0d025a8:	68a0      	ldr	r0, [r4, #8]
c0d025aa:	68e1      	ldr	r1, [r4, #12]
c0d025ac:	2538      	movs	r5, #56	; 0x38
c0d025ae:	4368      	muls	r0, r5
c0d025b0:	6822      	ldr	r2, [r4, #0]
c0d025b2:	1810      	adds	r0, r2, r0
c0d025b4:	2900      	cmp	r1, #0
c0d025b6:	d009      	beq.n	c0d025cc <ui_idle+0xec>
c0d025b8:	4788      	blx	r1
c0d025ba:	2800      	cmp	r0, #0
c0d025bc:	d106      	bne.n	c0d025cc <ui_idle+0xec>
c0d025be:	68a0      	ldr	r0, [r4, #8]
c0d025c0:	1c45      	adds	r5, r0, #1
c0d025c2:	60a5      	str	r5, [r4, #8]
c0d025c4:	6820      	ldr	r0, [r4, #0]
c0d025c6:	2800      	cmp	r0, #0
c0d025c8:	d1e7      	bne.n	c0d0259a <ui_idle+0xba>
c0d025ca:	e00a      	b.n	c0d025e2 <ui_idle+0x102>
c0d025cc:	2801      	cmp	r0, #1
c0d025ce:	d103      	bne.n	c0d025d8 <ui_idle+0xf8>
c0d025d0:	68a0      	ldr	r0, [r4, #8]
c0d025d2:	4345      	muls	r5, r0
c0d025d4:	6820      	ldr	r0, [r4, #0]
c0d025d6:	1940      	adds	r0, r0, r5
c0d025d8:	f7fe fa8e 	bl	c0d00af8 <io_seproxyhal_display>
c0d025dc:	68a0      	ldr	r0, [r4, #8]
c0d025de:	1c40      	adds	r0, r0, #1
c0d025e0:	60a0      	str	r0, [r4, #8]
    } else {
        UX_DISPLAY(bagl_ui_nanos_screen1, NULL);
    }
}
c0d025e2:	bdb0      	pop	{r4, r5, r7, pc}
c0d025e4:	20001a98 	.word	0x20001a98
c0d025e8:	b0105044 	.word	0xb0105044
c0d025ec:	0000172e 	.word	0x0000172e
c0d025f0:	0000008d 	.word	0x0000008d
c0d025f4:	000015dc 	.word	0x000015dc
c0d025f8:	fffffe27 	.word	0xfffffe27

c0d025fc <bagl_ui_sample_blue_button>:


unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
c0d025fc:	2000      	movs	r0, #0
c0d025fe:	4770      	bx	lr

c0d02600 <io_seproxyhal_touch_exit>:





const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
c0d02600:	b5d0      	push	{r4, r6, r7, lr}
c0d02602:	af02      	add	r7, sp, #8
c0d02604:	2400      	movs	r4, #0
    // Go back to the dashboard
    os_sched_exit(0);
c0d02606:	4620      	mov	r0, r4
c0d02608:	f7ff fddc 	bl	c0d021c4 <os_sched_exit>
    return NULL;
c0d0260c:	4620      	mov	r0, r4
c0d0260e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02610 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02610:	4902      	ldr	r1, [pc, #8]	; (c0d0261c <USBD_LL_Init+0xc>)
c0d02612:	2000      	movs	r0, #0
c0d02614:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d02616:	4902      	ldr	r1, [pc, #8]	; (c0d02620 <USBD_LL_Init+0x10>)
c0d02618:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0261a:	4770      	bx	lr
c0d0261c:	20001d2c 	.word	0x20001d2c
c0d02620:	20001d30 	.word	0x20001d30

c0d02624 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02624:	b5d0      	push	{r4, r6, r7, lr}
c0d02626:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02628:	4806      	ldr	r0, [pc, #24]	; (c0d02644 <USBD_LL_DeInit+0x20>)
c0d0262a:	214f      	movs	r1, #79	; 0x4f
c0d0262c:	7001      	strb	r1, [r0, #0]
c0d0262e:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02630:	7044      	strb	r4, [r0, #1]
c0d02632:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02634:	7081      	strb	r1, [r0, #2]
c0d02636:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02638:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0263a:	2104      	movs	r1, #4
c0d0263c:	f7ff fe1a 	bl	c0d02274 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d02640:	4620      	mov	r0, r4
c0d02642:	bdd0      	pop	{r4, r6, r7, pc}
c0d02644:	20001a18 	.word	0x20001a18

c0d02648 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02648:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0264a:	af03      	add	r7, sp, #12
c0d0264c:	b083      	sub	sp, #12
c0d0264e:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02650:	264f      	movs	r6, #79	; 0x4f
c0d02652:	702e      	strb	r6, [r5, #0]
c0d02654:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02656:	706c      	strb	r4, [r5, #1]
c0d02658:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0265a:	70a8      	strb	r0, [r5, #2]
c0d0265c:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d0265e:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02660:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d02662:	2105      	movs	r1, #5
c0d02664:	4628      	mov	r0, r5
c0d02666:	f7ff fe05 	bl	c0d02274 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0266a:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d0266c:	706c      	strb	r4, [r5, #1]
c0d0266e:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d02670:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02672:	70e8      	strb	r0, [r5, #3]
c0d02674:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02676:	4628      	mov	r0, r5
c0d02678:	f7ff fdfc 	bl	c0d02274 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0267c:	4620      	mov	r0, r4
c0d0267e:	b003      	add	sp, #12
c0d02680:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02682 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02682:	b5d0      	push	{r4, r6, r7, lr}
c0d02684:	af02      	add	r7, sp, #8
c0d02686:	b082      	sub	sp, #8
c0d02688:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0268a:	214f      	movs	r1, #79	; 0x4f
c0d0268c:	7001      	strb	r1, [r0, #0]
c0d0268e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02690:	7044      	strb	r4, [r0, #1]
c0d02692:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d02694:	7081      	strb	r1, [r0, #2]
c0d02696:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02698:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d0269a:	2104      	movs	r1, #4
c0d0269c:	f7ff fdea 	bl	c0d02274 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d026a0:	4620      	mov	r0, r4
c0d026a2:	b002      	add	sp, #8
c0d026a4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d026a8 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d026a8:	b5b0      	push	{r4, r5, r7, lr}
c0d026aa:	af02      	add	r7, sp, #8
c0d026ac:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d026ae:	480f      	ldr	r0, [pc, #60]	; (c0d026ec <USBD_LL_OpenEP+0x44>)
c0d026b0:	2400      	movs	r4, #0
c0d026b2:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d026b4:	480e      	ldr	r0, [pc, #56]	; (c0d026f0 <USBD_LL_OpenEP+0x48>)
c0d026b6:	6004      	str	r4, [r0, #0]
c0d026b8:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026ba:	254f      	movs	r5, #79	; 0x4f
c0d026bc:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d026be:	7044      	strb	r4, [r0, #1]
c0d026c0:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d026c2:	7085      	strb	r5, [r0, #2]
c0d026c4:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d026c6:	70c5      	strb	r5, [r0, #3]
c0d026c8:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d026ca:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d026cc:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d026ce:	2a03      	cmp	r2, #3
c0d026d0:	d802      	bhi.n	c0d026d8 <USBD_LL_OpenEP+0x30>
c0d026d2:	00d0      	lsls	r0, r2, #3
c0d026d4:	4c07      	ldr	r4, [pc, #28]	; (c0d026f4 <USBD_LL_OpenEP+0x4c>)
c0d026d6:	40c4      	lsrs	r4, r0
c0d026d8:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d026da:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d026dc:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d026de:	2108      	movs	r1, #8
c0d026e0:	f7ff fdc8 	bl	c0d02274 <io_seproxyhal_spi_send>
c0d026e4:	2000      	movs	r0, #0
  return USBD_OK; 
c0d026e6:	b002      	add	sp, #8
c0d026e8:	bdb0      	pop	{r4, r5, r7, pc}
c0d026ea:	46c0      	nop			; (mov r8, r8)
c0d026ec:	20001d2c 	.word	0x20001d2c
c0d026f0:	20001d30 	.word	0x20001d30
c0d026f4:	02030401 	.word	0x02030401

c0d026f8 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d026f8:	b5d0      	push	{r4, r6, r7, lr}
c0d026fa:	af02      	add	r7, sp, #8
c0d026fc:	b082      	sub	sp, #8
c0d026fe:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02700:	224f      	movs	r2, #79	; 0x4f
c0d02702:	7002      	strb	r2, [r0, #0]
c0d02704:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02706:	7044      	strb	r4, [r0, #1]
c0d02708:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d0270a:	7082      	strb	r2, [r0, #2]
c0d0270c:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0270e:	70c2      	strb	r2, [r0, #3]
c0d02710:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02712:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02714:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02716:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02718:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d0271a:	2108      	movs	r1, #8
c0d0271c:	f7ff fdaa 	bl	c0d02274 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02720:	4620      	mov	r0, r4
c0d02722:	b002      	add	sp, #8
c0d02724:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02728 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02728:	b5b0      	push	{r4, r5, r7, lr}
c0d0272a:	af02      	add	r7, sp, #8
c0d0272c:	b082      	sub	sp, #8
c0d0272e:	460d      	mov	r5, r1
c0d02730:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02732:	2150      	movs	r1, #80	; 0x50
c0d02734:	7001      	strb	r1, [r0, #0]
c0d02736:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02738:	7044      	strb	r4, [r0, #1]
c0d0273a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d0273c:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0273e:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02740:	2140      	movs	r1, #64	; 0x40
c0d02742:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02744:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02746:	2106      	movs	r1, #6
c0d02748:	f7ff fd94 	bl	c0d02274 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d0274c:	2080      	movs	r0, #128	; 0x80
c0d0274e:	4205      	tst	r5, r0
c0d02750:	d101      	bne.n	c0d02756 <USBD_LL_StallEP+0x2e>
c0d02752:	4807      	ldr	r0, [pc, #28]	; (c0d02770 <USBD_LL_StallEP+0x48>)
c0d02754:	e000      	b.n	c0d02758 <USBD_LL_StallEP+0x30>
c0d02756:	4805      	ldr	r0, [pc, #20]	; (c0d0276c <USBD_LL_StallEP+0x44>)
c0d02758:	6801      	ldr	r1, [r0, #0]
c0d0275a:	227f      	movs	r2, #127	; 0x7f
c0d0275c:	4015      	ands	r5, r2
c0d0275e:	2201      	movs	r2, #1
c0d02760:	40aa      	lsls	r2, r5
c0d02762:	430a      	orrs	r2, r1
c0d02764:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02766:	4620      	mov	r0, r4
c0d02768:	b002      	add	sp, #8
c0d0276a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0276c:	20001d2c 	.word	0x20001d2c
c0d02770:	20001d30 	.word	0x20001d30

c0d02774 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02774:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02776:	af03      	add	r7, sp, #12
c0d02778:	b083      	sub	sp, #12
c0d0277a:	460d      	mov	r5, r1
c0d0277c:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0277e:	2150      	movs	r1, #80	; 0x50
c0d02780:	7001      	strb	r1, [r0, #0]
c0d02782:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d02784:	7044      	strb	r4, [r0, #1]
c0d02786:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d02788:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0278a:	70c5      	strb	r5, [r0, #3]
c0d0278c:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0278e:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d02790:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d02792:	2106      	movs	r1, #6
c0d02794:	f7ff fd6e 	bl	c0d02274 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d02798:	4235      	tst	r5, r6
c0d0279a:	d101      	bne.n	c0d027a0 <USBD_LL_ClearStallEP+0x2c>
c0d0279c:	4807      	ldr	r0, [pc, #28]	; (c0d027bc <USBD_LL_ClearStallEP+0x48>)
c0d0279e:	e000      	b.n	c0d027a2 <USBD_LL_ClearStallEP+0x2e>
c0d027a0:	4805      	ldr	r0, [pc, #20]	; (c0d027b8 <USBD_LL_ClearStallEP+0x44>)
c0d027a2:	6801      	ldr	r1, [r0, #0]
c0d027a4:	227f      	movs	r2, #127	; 0x7f
c0d027a6:	4015      	ands	r5, r2
c0d027a8:	2201      	movs	r2, #1
c0d027aa:	40aa      	lsls	r2, r5
c0d027ac:	4391      	bics	r1, r2
c0d027ae:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d027b0:	4620      	mov	r0, r4
c0d027b2:	b003      	add	sp, #12
c0d027b4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d027b6:	46c0      	nop			; (mov r8, r8)
c0d027b8:	20001d2c 	.word	0x20001d2c
c0d027bc:	20001d30 	.word	0x20001d30

c0d027c0 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d027c0:	2080      	movs	r0, #128	; 0x80
c0d027c2:	4201      	tst	r1, r0
c0d027c4:	d001      	beq.n	c0d027ca <USBD_LL_IsStallEP+0xa>
c0d027c6:	4806      	ldr	r0, [pc, #24]	; (c0d027e0 <USBD_LL_IsStallEP+0x20>)
c0d027c8:	e000      	b.n	c0d027cc <USBD_LL_IsStallEP+0xc>
c0d027ca:	4804      	ldr	r0, [pc, #16]	; (c0d027dc <USBD_LL_IsStallEP+0x1c>)
c0d027cc:	6800      	ldr	r0, [r0, #0]
c0d027ce:	227f      	movs	r2, #127	; 0x7f
c0d027d0:	4011      	ands	r1, r2
c0d027d2:	2201      	movs	r2, #1
c0d027d4:	408a      	lsls	r2, r1
c0d027d6:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d027d8:	b2d0      	uxtb	r0, r2
c0d027da:	4770      	bx	lr
c0d027dc:	20001d30 	.word	0x20001d30
c0d027e0:	20001d2c 	.word	0x20001d2c

c0d027e4 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d027e4:	b5d0      	push	{r4, r6, r7, lr}
c0d027e6:	af02      	add	r7, sp, #8
c0d027e8:	b082      	sub	sp, #8
c0d027ea:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027ec:	224f      	movs	r2, #79	; 0x4f
c0d027ee:	7002      	strb	r2, [r0, #0]
c0d027f0:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d027f2:	7044      	strb	r4, [r0, #1]
c0d027f4:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d027f6:	7082      	strb	r2, [r0, #2]
c0d027f8:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d027fa:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d027fc:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d027fe:	2105      	movs	r1, #5
c0d02800:	f7ff fd38 	bl	c0d02274 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d02804:	4620      	mov	r0, r4
c0d02806:	b002      	add	sp, #8
c0d02808:	bdd0      	pop	{r4, r6, r7, pc}

c0d0280a <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d0280a:	b5b0      	push	{r4, r5, r7, lr}
c0d0280c:	af02      	add	r7, sp, #8
c0d0280e:	b082      	sub	sp, #8
c0d02810:	461c      	mov	r4, r3
c0d02812:	4615      	mov	r5, r2
c0d02814:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02816:	2250      	movs	r2, #80	; 0x50
c0d02818:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0281a:	1ce2      	adds	r2, r4, #3
c0d0281c:	0a13      	lsrs	r3, r2, #8
c0d0281e:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d02820:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d02822:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02824:	2120      	movs	r1, #32
c0d02826:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02828:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0282a:	2106      	movs	r1, #6
c0d0282c:	f7ff fd22 	bl	c0d02274 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02830:	4628      	mov	r0, r5
c0d02832:	4621      	mov	r1, r4
c0d02834:	f7ff fd1e 	bl	c0d02274 <io_seproxyhal_spi_send>
c0d02838:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0283a:	b002      	add	sp, #8
c0d0283c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0283e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0283e:	b5d0      	push	{r4, r6, r7, lr}
c0d02840:	af02      	add	r7, sp, #8
c0d02842:	b082      	sub	sp, #8
c0d02844:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02846:	2350      	movs	r3, #80	; 0x50
c0d02848:	7003      	strb	r3, [r0, #0]
c0d0284a:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d0284c:	7044      	strb	r4, [r0, #1]
c0d0284e:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d02850:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02852:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02854:	2130      	movs	r1, #48	; 0x30
c0d02856:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02858:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0285a:	2106      	movs	r1, #6
c0d0285c:	f7ff fd0a 	bl	c0d02274 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d02860:	4620      	mov	r0, r4
c0d02862:	b002      	add	sp, #8
c0d02864:	bdd0      	pop	{r4, r6, r7, pc}

c0d02866 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02866:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02868:	af03      	add	r7, sp, #12
c0d0286a:	b081      	sub	sp, #4
c0d0286c:	4615      	mov	r5, r2
c0d0286e:	460e      	mov	r6, r1
c0d02870:	4604      	mov	r4, r0
c0d02872:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02874:	2c00      	cmp	r4, #0
c0d02876:	d011      	beq.n	c0d0289c <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02878:	2049      	movs	r0, #73	; 0x49
c0d0287a:	0081      	lsls	r1, r0, #2
c0d0287c:	4620      	mov	r0, r4
c0d0287e:	f000 ffd7 	bl	c0d03830 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02882:	2e00      	cmp	r6, #0
c0d02884:	d002      	beq.n	c0d0288c <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d02886:	2011      	movs	r0, #17
c0d02888:	0100      	lsls	r0, r0, #4
c0d0288a:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d0288c:	20fc      	movs	r0, #252	; 0xfc
c0d0288e:	2101      	movs	r1, #1
c0d02890:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02892:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02894:	4620      	mov	r0, r4
c0d02896:	f7ff febb 	bl	c0d02610 <USBD_LL_Init>
c0d0289a:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d0289c:	b2c0      	uxtb	r0, r0
c0d0289e:	b001      	add	sp, #4
c0d028a0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d028a2 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d028a2:	b5d0      	push	{r4, r6, r7, lr}
c0d028a4:	af02      	add	r7, sp, #8
c0d028a6:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d028a8:	20fc      	movs	r0, #252	; 0xfc
c0d028aa:	2101      	movs	r1, #1
c0d028ac:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d028ae:	2045      	movs	r0, #69	; 0x45
c0d028b0:	0080      	lsls	r0, r0, #2
c0d028b2:	5820      	ldr	r0, [r4, r0]
c0d028b4:	2800      	cmp	r0, #0
c0d028b6:	d006      	beq.n	c0d028c6 <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d028b8:	6840      	ldr	r0, [r0, #4]
c0d028ba:	f7ff fb1f 	bl	c0d01efc <pic>
c0d028be:	4602      	mov	r2, r0
c0d028c0:	7921      	ldrb	r1, [r4, #4]
c0d028c2:	4620      	mov	r0, r4
c0d028c4:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d028c6:	4620      	mov	r0, r4
c0d028c8:	f7ff fedb 	bl	c0d02682 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d028cc:	4620      	mov	r0, r4
c0d028ce:	f7ff fea9 	bl	c0d02624 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d028d2:	2000      	movs	r0, #0
c0d028d4:	bdd0      	pop	{r4, r6, r7, pc}

c0d028d6 <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d028d6:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d028d8:	2900      	cmp	r1, #0
c0d028da:	d003      	beq.n	c0d028e4 <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d028dc:	2245      	movs	r2, #69	; 0x45
c0d028de:	0092      	lsls	r2, r2, #2
c0d028e0:	5081      	str	r1, [r0, r2]
c0d028e2:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d028e4:	b2d0      	uxtb	r0, r2
c0d028e6:	4770      	bx	lr

c0d028e8 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d028e8:	b580      	push	{r7, lr}
c0d028ea:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d028ec:	f7ff feac 	bl	c0d02648 <USBD_LL_Start>
  
  return USBD_OK;  
c0d028f0:	2000      	movs	r0, #0
c0d028f2:	bd80      	pop	{r7, pc}

c0d028f4 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d028f4:	b5b0      	push	{r4, r5, r7, lr}
c0d028f6:	af02      	add	r7, sp, #8
c0d028f8:	460c      	mov	r4, r1
c0d028fa:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d028fc:	2045      	movs	r0, #69	; 0x45
c0d028fe:	0080      	lsls	r0, r0, #2
c0d02900:	5828      	ldr	r0, [r5, r0]
c0d02902:	2800      	cmp	r0, #0
c0d02904:	d00c      	beq.n	c0d02920 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d02906:	6800      	ldr	r0, [r0, #0]
c0d02908:	f7ff faf8 	bl	c0d01efc <pic>
c0d0290c:	4602      	mov	r2, r0
c0d0290e:	4628      	mov	r0, r5
c0d02910:	4621      	mov	r1, r4
c0d02912:	4790      	blx	r2
c0d02914:	4601      	mov	r1, r0
c0d02916:	2002      	movs	r0, #2
c0d02918:	2900      	cmp	r1, #0
c0d0291a:	d100      	bne.n	c0d0291e <USBD_SetClassConfig+0x2a>
c0d0291c:	4608      	mov	r0, r1
c0d0291e:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d02920:	2002      	movs	r0, #2
c0d02922:	bdb0      	pop	{r4, r5, r7, pc}

c0d02924 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02924:	b5b0      	push	{r4, r5, r7, lr}
c0d02926:	af02      	add	r7, sp, #8
c0d02928:	460c      	mov	r4, r1
c0d0292a:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d0292c:	2045      	movs	r0, #69	; 0x45
c0d0292e:	0080      	lsls	r0, r0, #2
c0d02930:	5828      	ldr	r0, [r5, r0]
c0d02932:	2800      	cmp	r0, #0
c0d02934:	d006      	beq.n	c0d02944 <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d02936:	6840      	ldr	r0, [r0, #4]
c0d02938:	f7ff fae0 	bl	c0d01efc <pic>
c0d0293c:	4602      	mov	r2, r0
c0d0293e:	4628      	mov	r0, r5
c0d02940:	4621      	mov	r1, r4
c0d02942:	4790      	blx	r2
  }
  return USBD_OK;
c0d02944:	2000      	movs	r0, #0
c0d02946:	bdb0      	pop	{r4, r5, r7, pc}

c0d02948 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02948:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0294a:	af03      	add	r7, sp, #12
c0d0294c:	b081      	sub	sp, #4
c0d0294e:	4604      	mov	r4, r0
c0d02950:	2021      	movs	r0, #33	; 0x21
c0d02952:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02954:	19a5      	adds	r5, r4, r6
c0d02956:	4628      	mov	r0, r5
c0d02958:	f000 fb69 	bl	c0d0302e <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d0295c:	20f4      	movs	r0, #244	; 0xf4
c0d0295e:	2101      	movs	r1, #1
c0d02960:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d02962:	2087      	movs	r0, #135	; 0x87
c0d02964:	0040      	lsls	r0, r0, #1
c0d02966:	5a20      	ldrh	r0, [r4, r0]
c0d02968:	21f8      	movs	r1, #248	; 0xf8
c0d0296a:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d0296c:	5da1      	ldrb	r1, [r4, r6]
c0d0296e:	201f      	movs	r0, #31
c0d02970:	4008      	ands	r0, r1
c0d02972:	2802      	cmp	r0, #2
c0d02974:	d008      	beq.n	c0d02988 <USBD_LL_SetupStage+0x40>
c0d02976:	2801      	cmp	r0, #1
c0d02978:	d00b      	beq.n	c0d02992 <USBD_LL_SetupStage+0x4a>
c0d0297a:	2800      	cmp	r0, #0
c0d0297c:	d10e      	bne.n	c0d0299c <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d0297e:	4620      	mov	r0, r4
c0d02980:	4629      	mov	r1, r5
c0d02982:	f000 f8f1 	bl	c0d02b68 <USBD_StdDevReq>
c0d02986:	e00e      	b.n	c0d029a6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d02988:	4620      	mov	r0, r4
c0d0298a:	4629      	mov	r1, r5
c0d0298c:	f000 fad3 	bl	c0d02f36 <USBD_StdEPReq>
c0d02990:	e009      	b.n	c0d029a6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02992:	4620      	mov	r0, r4
c0d02994:	4629      	mov	r1, r5
c0d02996:	f000 faa6 	bl	c0d02ee6 <USBD_StdItfReq>
c0d0299a:	e004      	b.n	c0d029a6 <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d0299c:	2080      	movs	r0, #128	; 0x80
c0d0299e:	4001      	ands	r1, r0
c0d029a0:	4620      	mov	r0, r4
c0d029a2:	f7ff fec1 	bl	c0d02728 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d029a6:	2000      	movs	r0, #0
c0d029a8:	b001      	add	sp, #4
c0d029aa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d029ac <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d029ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029ae:	af03      	add	r7, sp, #12
c0d029b0:	b081      	sub	sp, #4
c0d029b2:	4615      	mov	r5, r2
c0d029b4:	460e      	mov	r6, r1
c0d029b6:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d029b8:	2e00      	cmp	r6, #0
c0d029ba:	d011      	beq.n	c0d029e0 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d029bc:	2045      	movs	r0, #69	; 0x45
c0d029be:	0080      	lsls	r0, r0, #2
c0d029c0:	5820      	ldr	r0, [r4, r0]
c0d029c2:	6980      	ldr	r0, [r0, #24]
c0d029c4:	2800      	cmp	r0, #0
c0d029c6:	d034      	beq.n	c0d02a32 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d029c8:	21fc      	movs	r1, #252	; 0xfc
c0d029ca:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d029cc:	2903      	cmp	r1, #3
c0d029ce:	d130      	bne.n	c0d02a32 <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d029d0:	f7ff fa94 	bl	c0d01efc <pic>
c0d029d4:	4603      	mov	r3, r0
c0d029d6:	4620      	mov	r0, r4
c0d029d8:	4631      	mov	r1, r6
c0d029da:	462a      	mov	r2, r5
c0d029dc:	4798      	blx	r3
c0d029de:	e028      	b.n	c0d02a32 <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d029e0:	20f4      	movs	r0, #244	; 0xf4
c0d029e2:	5820      	ldr	r0, [r4, r0]
c0d029e4:	2803      	cmp	r0, #3
c0d029e6:	d124      	bne.n	c0d02a32 <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d029e8:	2090      	movs	r0, #144	; 0x90
c0d029ea:	5820      	ldr	r0, [r4, r0]
c0d029ec:	218c      	movs	r1, #140	; 0x8c
c0d029ee:	5861      	ldr	r1, [r4, r1]
c0d029f0:	4622      	mov	r2, r4
c0d029f2:	328c      	adds	r2, #140	; 0x8c
c0d029f4:	4281      	cmp	r1, r0
c0d029f6:	d90a      	bls.n	c0d02a0e <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d029f8:	1a09      	subs	r1, r1, r0
c0d029fa:	6011      	str	r1, [r2, #0]
c0d029fc:	4281      	cmp	r1, r0
c0d029fe:	d300      	bcc.n	c0d02a02 <USBD_LL_DataOutStage+0x56>
c0d02a00:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d02a02:	b28a      	uxth	r2, r1
c0d02a04:	4620      	mov	r0, r4
c0d02a06:	4629      	mov	r1, r5
c0d02a08:	f000 fc70 	bl	c0d032ec <USBD_CtlContinueRx>
c0d02a0c:	e011      	b.n	c0d02a32 <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02a0e:	2045      	movs	r0, #69	; 0x45
c0d02a10:	0080      	lsls	r0, r0, #2
c0d02a12:	5820      	ldr	r0, [r4, r0]
c0d02a14:	6900      	ldr	r0, [r0, #16]
c0d02a16:	2800      	cmp	r0, #0
c0d02a18:	d008      	beq.n	c0d02a2c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a1a:	21fc      	movs	r1, #252	; 0xfc
c0d02a1c:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d02a1e:	2903      	cmp	r1, #3
c0d02a20:	d104      	bne.n	c0d02a2c <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d02a22:	f7ff fa6b 	bl	c0d01efc <pic>
c0d02a26:	4601      	mov	r1, r0
c0d02a28:	4620      	mov	r0, r4
c0d02a2a:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d02a2c:	4620      	mov	r0, r4
c0d02a2e:	f000 fc65 	bl	c0d032fc <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d02a32:	2000      	movs	r0, #0
c0d02a34:	b001      	add	sp, #4
c0d02a36:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a38 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02a38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a3a:	af03      	add	r7, sp, #12
c0d02a3c:	b081      	sub	sp, #4
c0d02a3e:	460d      	mov	r5, r1
c0d02a40:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02a42:	2d00      	cmp	r5, #0
c0d02a44:	d012      	beq.n	c0d02a6c <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02a46:	2045      	movs	r0, #69	; 0x45
c0d02a48:	0080      	lsls	r0, r0, #2
c0d02a4a:	5820      	ldr	r0, [r4, r0]
c0d02a4c:	2800      	cmp	r0, #0
c0d02a4e:	d054      	beq.n	c0d02afa <USBD_LL_DataInStage+0xc2>
c0d02a50:	6940      	ldr	r0, [r0, #20]
c0d02a52:	2800      	cmp	r0, #0
c0d02a54:	d051      	beq.n	c0d02afa <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a56:	21fc      	movs	r1, #252	; 0xfc
c0d02a58:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d02a5a:	2903      	cmp	r1, #3
c0d02a5c:	d14d      	bne.n	c0d02afa <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d02a5e:	f7ff fa4d 	bl	c0d01efc <pic>
c0d02a62:	4602      	mov	r2, r0
c0d02a64:	4620      	mov	r0, r4
c0d02a66:	4629      	mov	r1, r5
c0d02a68:	4790      	blx	r2
c0d02a6a:	e046      	b.n	c0d02afa <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02a6c:	20f4      	movs	r0, #244	; 0xf4
c0d02a6e:	5820      	ldr	r0, [r4, r0]
c0d02a70:	2802      	cmp	r0, #2
c0d02a72:	d13a      	bne.n	c0d02aea <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02a74:	69e0      	ldr	r0, [r4, #28]
c0d02a76:	6a25      	ldr	r5, [r4, #32]
c0d02a78:	42a8      	cmp	r0, r5
c0d02a7a:	d90b      	bls.n	c0d02a94 <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02a7c:	1b40      	subs	r0, r0, r5
c0d02a7e:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d02a80:	2109      	movs	r1, #9
c0d02a82:	014a      	lsls	r2, r1, #5
c0d02a84:	58a1      	ldr	r1, [r4, r2]
c0d02a86:	1949      	adds	r1, r1, r5
c0d02a88:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02a8a:	b282      	uxth	r2, r0
c0d02a8c:	4620      	mov	r0, r4
c0d02a8e:	f000 fc1e 	bl	c0d032ce <USBD_CtlContinueSendData>
c0d02a92:	e02a      	b.n	c0d02aea <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02a94:	69a6      	ldr	r6, [r4, #24]
c0d02a96:	4630      	mov	r0, r6
c0d02a98:	4629      	mov	r1, r5
c0d02a9a:	f000 fccf 	bl	c0d0343c <__aeabi_uidivmod>
c0d02a9e:	42ae      	cmp	r6, r5
c0d02aa0:	d30f      	bcc.n	c0d02ac2 <USBD_LL_DataInStage+0x8a>
c0d02aa2:	2900      	cmp	r1, #0
c0d02aa4:	d10d      	bne.n	c0d02ac2 <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02aa6:	20f8      	movs	r0, #248	; 0xf8
c0d02aa8:	5820      	ldr	r0, [r4, r0]
c0d02aaa:	4625      	mov	r5, r4
c0d02aac:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02aae:	4286      	cmp	r6, r0
c0d02ab0:	d207      	bcs.n	c0d02ac2 <USBD_LL_DataInStage+0x8a>
c0d02ab2:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02ab4:	4620      	mov	r0, r4
c0d02ab6:	4631      	mov	r1, r6
c0d02ab8:	4632      	mov	r2, r6
c0d02aba:	f000 fc08 	bl	c0d032ce <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02abe:	602e      	str	r6, [r5, #0]
c0d02ac0:	e013      	b.n	c0d02aea <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02ac2:	2045      	movs	r0, #69	; 0x45
c0d02ac4:	0080      	lsls	r0, r0, #2
c0d02ac6:	5820      	ldr	r0, [r4, r0]
c0d02ac8:	2800      	cmp	r0, #0
c0d02aca:	d00b      	beq.n	c0d02ae4 <USBD_LL_DataInStage+0xac>
c0d02acc:	68c0      	ldr	r0, [r0, #12]
c0d02ace:	2800      	cmp	r0, #0
c0d02ad0:	d008      	beq.n	c0d02ae4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02ad2:	21fc      	movs	r1, #252	; 0xfc
c0d02ad4:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d02ad6:	2903      	cmp	r1, #3
c0d02ad8:	d104      	bne.n	c0d02ae4 <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d02ada:	f7ff fa0f 	bl	c0d01efc <pic>
c0d02ade:	4601      	mov	r1, r0
c0d02ae0:	4620      	mov	r0, r4
c0d02ae2:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d02ae4:	4620      	mov	r0, r4
c0d02ae6:	f000 fc16 	bl	c0d03316 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02aea:	2001      	movs	r0, #1
c0d02aec:	0201      	lsls	r1, r0, #8
c0d02aee:	1860      	adds	r0, r4, r1
c0d02af0:	5c61      	ldrb	r1, [r4, r1]
c0d02af2:	2901      	cmp	r1, #1
c0d02af4:	d101      	bne.n	c0d02afa <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02af6:	2100      	movs	r1, #0
c0d02af8:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d02afa:	2000      	movs	r0, #0
c0d02afc:	b001      	add	sp, #4
c0d02afe:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b00 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02b00:	b5d0      	push	{r4, r6, r7, lr}
c0d02b02:	af02      	add	r7, sp, #8
c0d02b04:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b06:	2090      	movs	r0, #144	; 0x90
c0d02b08:	2140      	movs	r1, #64	; 0x40
c0d02b0a:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b0c:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02b0e:	20fc      	movs	r0, #252	; 0xfc
c0d02b10:	2101      	movs	r1, #1
c0d02b12:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d02b14:	2045      	movs	r0, #69	; 0x45
c0d02b16:	0080      	lsls	r0, r0, #2
c0d02b18:	5820      	ldr	r0, [r4, r0]
c0d02b1a:	2800      	cmp	r0, #0
c0d02b1c:	d006      	beq.n	c0d02b2c <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d02b1e:	6840      	ldr	r0, [r0, #4]
c0d02b20:	f7ff f9ec 	bl	c0d01efc <pic>
c0d02b24:	4602      	mov	r2, r0
c0d02b26:	7921      	ldrb	r1, [r4, #4]
c0d02b28:	4620      	mov	r0, r4
c0d02b2a:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d02b2c:	2000      	movs	r0, #0
c0d02b2e:	bdd0      	pop	{r4, r6, r7, pc}

c0d02b30 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02b30:	7401      	strb	r1, [r0, #16]
c0d02b32:	2000      	movs	r0, #0
  return USBD_OK;
c0d02b34:	4770      	bx	lr

c0d02b36 <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02b36:	2000      	movs	r0, #0
c0d02b38:	4770      	bx	lr

c0d02b3a <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02b3a:	2000      	movs	r0, #0
c0d02b3c:	4770      	bx	lr

c0d02b3e <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02b3e:	b5d0      	push	{r4, r6, r7, lr}
c0d02b40:	af02      	add	r7, sp, #8
c0d02b42:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02b44:	20fc      	movs	r0, #252	; 0xfc
c0d02b46:	5c20      	ldrb	r0, [r4, r0]
c0d02b48:	2803      	cmp	r0, #3
c0d02b4a:	d10a      	bne.n	c0d02b62 <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d02b4c:	2045      	movs	r0, #69	; 0x45
c0d02b4e:	0080      	lsls	r0, r0, #2
c0d02b50:	5820      	ldr	r0, [r4, r0]
c0d02b52:	69c0      	ldr	r0, [r0, #28]
c0d02b54:	2800      	cmp	r0, #0
c0d02b56:	d004      	beq.n	c0d02b62 <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d02b58:	f7ff f9d0 	bl	c0d01efc <pic>
c0d02b5c:	4601      	mov	r1, r0
c0d02b5e:	4620      	mov	r0, r4
c0d02b60:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d02b62:	2000      	movs	r0, #0
c0d02b64:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02b68 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02b68:	b5d0      	push	{r4, r6, r7, lr}
c0d02b6a:	af02      	add	r7, sp, #8
c0d02b6c:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02b6e:	7848      	ldrb	r0, [r1, #1]
c0d02b70:	2809      	cmp	r0, #9
c0d02b72:	d810      	bhi.n	c0d02b96 <USBD_StdDevReq+0x2e>
c0d02b74:	4478      	add	r0, pc
c0d02b76:	7900      	ldrb	r0, [r0, #4]
c0d02b78:	0040      	lsls	r0, r0, #1
c0d02b7a:	4487      	add	pc, r0
c0d02b7c:	150c0804 	.word	0x150c0804
c0d02b80:	0c25190c 	.word	0x0c25190c
c0d02b84:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02b86:	4620      	mov	r0, r4
c0d02b88:	f000 f938 	bl	c0d02dfc <USBD_GetStatus>
c0d02b8c:	e01f      	b.n	c0d02bce <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02b8e:	4620      	mov	r0, r4
c0d02b90:	f000 f976 	bl	c0d02e80 <USBD_ClrFeature>
c0d02b94:	e01b      	b.n	c0d02bce <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02b96:	2180      	movs	r1, #128	; 0x80
c0d02b98:	4620      	mov	r0, r4
c0d02b9a:	f7ff fdc5 	bl	c0d02728 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02b9e:	2100      	movs	r1, #0
c0d02ba0:	4620      	mov	r0, r4
c0d02ba2:	f7ff fdc1 	bl	c0d02728 <USBD_LL_StallEP>
c0d02ba6:	e012      	b.n	c0d02bce <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02ba8:	4620      	mov	r0, r4
c0d02baa:	f000 f950 	bl	c0d02e4e <USBD_SetFeature>
c0d02bae:	e00e      	b.n	c0d02bce <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02bb0:	4620      	mov	r0, r4
c0d02bb2:	f000 f897 	bl	c0d02ce4 <USBD_SetAddress>
c0d02bb6:	e00a      	b.n	c0d02bce <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02bb8:	4620      	mov	r0, r4
c0d02bba:	f000 f8ff 	bl	c0d02dbc <USBD_GetConfig>
c0d02bbe:	e006      	b.n	c0d02bce <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02bc0:	4620      	mov	r0, r4
c0d02bc2:	f000 f8bd 	bl	c0d02d40 <USBD_SetConfig>
c0d02bc6:	e002      	b.n	c0d02bce <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02bc8:	4620      	mov	r0, r4
c0d02bca:	f000 f803 	bl	c0d02bd4 <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02bce:	2000      	movs	r0, #0
c0d02bd0:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d02bd4 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02bd4:	b5b0      	push	{r4, r5, r7, lr}
c0d02bd6:	af02      	add	r7, sp, #8
c0d02bd8:	b082      	sub	sp, #8
c0d02bda:	460d      	mov	r5, r1
c0d02bdc:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02bde:	8868      	ldrh	r0, [r5, #2]
c0d02be0:	0a01      	lsrs	r1, r0, #8
c0d02be2:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02be4:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d02be6:	2a0e      	cmp	r2, #14
c0d02be8:	d83e      	bhi.n	c0d02c68 <USBD_GetDescriptor+0x94>
c0d02bea:	46c0      	nop			; (mov r8, r8)
c0d02bec:	447a      	add	r2, pc
c0d02bee:	7912      	ldrb	r2, [r2, #4]
c0d02bf0:	0052      	lsls	r2, r2, #1
c0d02bf2:	4497      	add	pc, r2
c0d02bf4:	390c2607 	.word	0x390c2607
c0d02bf8:	39362e39 	.word	0x39362e39
c0d02bfc:	39393939 	.word	0x39393939
c0d02c00:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02c04:	2011      	movs	r0, #17
c0d02c06:	0100      	lsls	r0, r0, #4
c0d02c08:	5820      	ldr	r0, [r4, r0]
c0d02c0a:	6800      	ldr	r0, [r0, #0]
c0d02c0c:	e012      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02c0e:	b2c0      	uxtb	r0, r0
c0d02c10:	2805      	cmp	r0, #5
c0d02c12:	d829      	bhi.n	c0d02c68 <USBD_GetDescriptor+0x94>
c0d02c14:	4478      	add	r0, pc
c0d02c16:	7900      	ldrb	r0, [r0, #4]
c0d02c18:	0040      	lsls	r0, r0, #1
c0d02c1a:	4487      	add	pc, r0
c0d02c1c:	544f4a02 	.word	0x544f4a02
c0d02c20:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02c22:	2011      	movs	r0, #17
c0d02c24:	0100      	lsls	r0, r0, #4
c0d02c26:	5820      	ldr	r0, [r4, r0]
c0d02c28:	6840      	ldr	r0, [r0, #4]
c0d02c2a:	e003      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d02c2c:	2011      	movs	r0, #17
c0d02c2e:	0100      	lsls	r0, r0, #4
c0d02c30:	5820      	ldr	r0, [r4, r0]
c0d02c32:	69c0      	ldr	r0, [r0, #28]
c0d02c34:	f7ff f962 	bl	c0d01efc <pic>
c0d02c38:	4602      	mov	r2, r0
c0d02c3a:	7c20      	ldrb	r0, [r4, #16]
c0d02c3c:	a901      	add	r1, sp, #4
c0d02c3e:	4790      	blx	r2
c0d02c40:	e025      	b.n	c0d02c8e <USBD_GetDescriptor+0xba>
c0d02c42:	2045      	movs	r0, #69	; 0x45
c0d02c44:	0080      	lsls	r0, r0, #2
c0d02c46:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02c48:	7c21      	ldrb	r1, [r4, #16]
c0d02c4a:	2900      	cmp	r1, #0
c0d02c4c:	d014      	beq.n	c0d02c78 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d02c4e:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02c50:	e018      	b.n	c0d02c84 <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02c52:	7c20      	ldrb	r0, [r4, #16]
c0d02c54:	2800      	cmp	r0, #0
c0d02c56:	d107      	bne.n	c0d02c68 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d02c58:	2045      	movs	r0, #69	; 0x45
c0d02c5a:	0080      	lsls	r0, r0, #2
c0d02c5c:	5820      	ldr	r0, [r4, r0]
c0d02c5e:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02c60:	e010      	b.n	c0d02c84 <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d02c62:	7c20      	ldrb	r0, [r4, #16]
c0d02c64:	2800      	cmp	r0, #0
c0d02c66:	d009      	beq.n	c0d02c7c <USBD_GetDescriptor+0xa8>
c0d02c68:	4620      	mov	r0, r4
c0d02c6a:	f7ff fd5d 	bl	c0d02728 <USBD_LL_StallEP>
c0d02c6e:	2100      	movs	r1, #0
c0d02c70:	4620      	mov	r0, r4
c0d02c72:	f7ff fd59 	bl	c0d02728 <USBD_LL_StallEP>
c0d02c76:	e01a      	b.n	c0d02cae <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d02c78:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02c7a:	e003      	b.n	c0d02c84 <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02c7c:	2045      	movs	r0, #69	; 0x45
c0d02c7e:	0080      	lsls	r0, r0, #2
c0d02c80:	5820      	ldr	r0, [r4, r0]
c0d02c82:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02c84:	f7ff f93a 	bl	c0d01efc <pic>
c0d02c88:	4601      	mov	r1, r0
c0d02c8a:	a801      	add	r0, sp, #4
c0d02c8c:	4788      	blx	r1
c0d02c8e:	4601      	mov	r1, r0
c0d02c90:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02c92:	8802      	ldrh	r2, [r0, #0]
c0d02c94:	2a00      	cmp	r2, #0
c0d02c96:	d00a      	beq.n	c0d02cae <USBD_GetDescriptor+0xda>
c0d02c98:	88e8      	ldrh	r0, [r5, #6]
c0d02c9a:	2800      	cmp	r0, #0
c0d02c9c:	d007      	beq.n	c0d02cae <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d02c9e:	4282      	cmp	r2, r0
c0d02ca0:	d300      	bcc.n	c0d02ca4 <USBD_GetDescriptor+0xd0>
c0d02ca2:	4602      	mov	r2, r0
c0d02ca4:	a801      	add	r0, sp, #4
c0d02ca6:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02ca8:	4620      	mov	r0, r4
c0d02caa:	f000 faf9 	bl	c0d032a0 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02cae:	b002      	add	sp, #8
c0d02cb0:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02cb2:	2011      	movs	r0, #17
c0d02cb4:	0100      	lsls	r0, r0, #4
c0d02cb6:	5820      	ldr	r0, [r4, r0]
c0d02cb8:	6880      	ldr	r0, [r0, #8]
c0d02cba:	e7bb      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02cbc:	2011      	movs	r0, #17
c0d02cbe:	0100      	lsls	r0, r0, #4
c0d02cc0:	5820      	ldr	r0, [r4, r0]
c0d02cc2:	68c0      	ldr	r0, [r0, #12]
c0d02cc4:	e7b6      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02cc6:	2011      	movs	r0, #17
c0d02cc8:	0100      	lsls	r0, r0, #4
c0d02cca:	5820      	ldr	r0, [r4, r0]
c0d02ccc:	6900      	ldr	r0, [r0, #16]
c0d02cce:	e7b1      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02cd0:	2011      	movs	r0, #17
c0d02cd2:	0100      	lsls	r0, r0, #4
c0d02cd4:	5820      	ldr	r0, [r4, r0]
c0d02cd6:	6940      	ldr	r0, [r0, #20]
c0d02cd8:	e7ac      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02cda:	2011      	movs	r0, #17
c0d02cdc:	0100      	lsls	r0, r0, #4
c0d02cde:	5820      	ldr	r0, [r4, r0]
c0d02ce0:	6980      	ldr	r0, [r0, #24]
c0d02ce2:	e7a7      	b.n	c0d02c34 <USBD_GetDescriptor+0x60>

c0d02ce4 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02ce4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ce6:	af03      	add	r7, sp, #12
c0d02ce8:	b081      	sub	sp, #4
c0d02cea:	460a      	mov	r2, r1
c0d02cec:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02cee:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02cf0:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02cf2:	2800      	cmp	r0, #0
c0d02cf4:	d10b      	bne.n	c0d02d0e <USBD_SetAddress+0x2a>
c0d02cf6:	88d0      	ldrh	r0, [r2, #6]
c0d02cf8:	2800      	cmp	r0, #0
c0d02cfa:	d108      	bne.n	c0d02d0e <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02cfc:	8850      	ldrh	r0, [r2, #2]
c0d02cfe:	267f      	movs	r6, #127	; 0x7f
c0d02d00:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02d02:	20fc      	movs	r0, #252	; 0xfc
c0d02d04:	5c20      	ldrb	r0, [r4, r0]
c0d02d06:	4625      	mov	r5, r4
c0d02d08:	35fc      	adds	r5, #252	; 0xfc
c0d02d0a:	2803      	cmp	r0, #3
c0d02d0c:	d108      	bne.n	c0d02d20 <USBD_SetAddress+0x3c>
c0d02d0e:	4620      	mov	r0, r4
c0d02d10:	f7ff fd0a 	bl	c0d02728 <USBD_LL_StallEP>
c0d02d14:	2100      	movs	r1, #0
c0d02d16:	4620      	mov	r0, r4
c0d02d18:	f7ff fd06 	bl	c0d02728 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02d1c:	b001      	add	sp, #4
c0d02d1e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02d20:	20fe      	movs	r0, #254	; 0xfe
c0d02d22:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02d24:	b2f1      	uxtb	r1, r6
c0d02d26:	4620      	mov	r0, r4
c0d02d28:	f7ff fd5c 	bl	c0d027e4 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02d2c:	4620      	mov	r0, r4
c0d02d2e:	f000 fae5 	bl	c0d032fc <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02d32:	2002      	movs	r0, #2
c0d02d34:	2101      	movs	r1, #1
c0d02d36:	2e00      	cmp	r6, #0
c0d02d38:	d100      	bne.n	c0d02d3c <USBD_SetAddress+0x58>
c0d02d3a:	4608      	mov	r0, r1
c0d02d3c:	7028      	strb	r0, [r5, #0]
c0d02d3e:	e7ed      	b.n	c0d02d1c <USBD_SetAddress+0x38>

c0d02d40 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02d40:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d42:	af03      	add	r7, sp, #12
c0d02d44:	b081      	sub	sp, #4
c0d02d46:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02d48:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02d4a:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02d4c:	2e02      	cmp	r6, #2
c0d02d4e:	d21d      	bcs.n	c0d02d8c <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02d50:	20fc      	movs	r0, #252	; 0xfc
c0d02d52:	5c21      	ldrb	r1, [r4, r0]
c0d02d54:	4620      	mov	r0, r4
c0d02d56:	30fc      	adds	r0, #252	; 0xfc
c0d02d58:	2903      	cmp	r1, #3
c0d02d5a:	d007      	beq.n	c0d02d6c <USBD_SetConfig+0x2c>
c0d02d5c:	2902      	cmp	r1, #2
c0d02d5e:	d115      	bne.n	c0d02d8c <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02d60:	2e00      	cmp	r6, #0
c0d02d62:	d026      	beq.n	c0d02db2 <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02d64:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02d66:	2103      	movs	r1, #3
c0d02d68:	7001      	strb	r1, [r0, #0]
c0d02d6a:	e009      	b.n	c0d02d80 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02d6c:	2e00      	cmp	r6, #0
c0d02d6e:	d016      	beq.n	c0d02d9e <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02d70:	6860      	ldr	r0, [r4, #4]
c0d02d72:	4286      	cmp	r6, r0
c0d02d74:	d01d      	beq.n	c0d02db2 <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02d76:	b2c1      	uxtb	r1, r0
c0d02d78:	4620      	mov	r0, r4
c0d02d7a:	f7ff fdd3 	bl	c0d02924 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02d7e:	6066      	str	r6, [r4, #4]
c0d02d80:	4620      	mov	r0, r4
c0d02d82:	4631      	mov	r1, r6
c0d02d84:	f7ff fdb6 	bl	c0d028f4 <USBD_SetClassConfig>
c0d02d88:	2802      	cmp	r0, #2
c0d02d8a:	d112      	bne.n	c0d02db2 <USBD_SetConfig+0x72>
c0d02d8c:	4620      	mov	r0, r4
c0d02d8e:	4629      	mov	r1, r5
c0d02d90:	f7ff fcca 	bl	c0d02728 <USBD_LL_StallEP>
c0d02d94:	2100      	movs	r1, #0
c0d02d96:	4620      	mov	r0, r4
c0d02d98:	f7ff fcc6 	bl	c0d02728 <USBD_LL_StallEP>
c0d02d9c:	e00c      	b.n	c0d02db8 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02d9e:	2102      	movs	r1, #2
c0d02da0:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02da2:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02da4:	4620      	mov	r0, r4
c0d02da6:	4631      	mov	r1, r6
c0d02da8:	f7ff fdbc 	bl	c0d02924 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02dac:	4620      	mov	r0, r4
c0d02dae:	f000 faa5 	bl	c0d032fc <USBD_CtlSendStatus>
c0d02db2:	4620      	mov	r0, r4
c0d02db4:	f000 faa2 	bl	c0d032fc <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02db8:	b001      	add	sp, #4
c0d02dba:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02dbc <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02dbc:	b5d0      	push	{r4, r6, r7, lr}
c0d02dbe:	af02      	add	r7, sp, #8
c0d02dc0:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d02dc2:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02dc4:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d02dc6:	2801      	cmp	r0, #1
c0d02dc8:	d10a      	bne.n	c0d02de0 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02dca:	20fc      	movs	r0, #252	; 0xfc
c0d02dcc:	5c20      	ldrb	r0, [r4, r0]
c0d02dce:	2803      	cmp	r0, #3
c0d02dd0:	d00e      	beq.n	c0d02df0 <USBD_GetConfig+0x34>
c0d02dd2:	2802      	cmp	r0, #2
c0d02dd4:	d104      	bne.n	c0d02de0 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02dd6:	2000      	movs	r0, #0
c0d02dd8:	60a0      	str	r0, [r4, #8]
c0d02dda:	4621      	mov	r1, r4
c0d02ddc:	3108      	adds	r1, #8
c0d02dde:	e008      	b.n	c0d02df2 <USBD_GetConfig+0x36>
c0d02de0:	4620      	mov	r0, r4
c0d02de2:	f7ff fca1 	bl	c0d02728 <USBD_LL_StallEP>
c0d02de6:	2100      	movs	r1, #0
c0d02de8:	4620      	mov	r0, r4
c0d02dea:	f7ff fc9d 	bl	c0d02728 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02dee:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02df0:	1d21      	adds	r1, r4, #4
c0d02df2:	2201      	movs	r2, #1
c0d02df4:	4620      	mov	r0, r4
c0d02df6:	f000 fa53 	bl	c0d032a0 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02dfa:	bdd0      	pop	{r4, r6, r7, pc}

c0d02dfc <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02dfc:	b5b0      	push	{r4, r5, r7, lr}
c0d02dfe:	af02      	add	r7, sp, #8
c0d02e00:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d02e02:	20fc      	movs	r0, #252	; 0xfc
c0d02e04:	5c20      	ldrb	r0, [r4, r0]
c0d02e06:	21fe      	movs	r1, #254	; 0xfe
c0d02e08:	4001      	ands	r1, r0
c0d02e0a:	2902      	cmp	r1, #2
c0d02e0c:	d116      	bne.n	c0d02e3c <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e0e:	2001      	movs	r0, #1
c0d02e10:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e12:	2041      	movs	r0, #65	; 0x41
c0d02e14:	0080      	lsls	r0, r0, #2
c0d02e16:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e18:	4625      	mov	r5, r4
c0d02e1a:	350c      	adds	r5, #12
c0d02e1c:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e1e:	2900      	cmp	r1, #0
c0d02e20:	d005      	beq.n	c0d02e2e <USBD_GetStatus+0x32>
c0d02e22:	4620      	mov	r0, r4
c0d02e24:	f000 fa77 	bl	c0d03316 <USBD_CtlReceiveStatus>
c0d02e28:	68e1      	ldr	r1, [r4, #12]
c0d02e2a:	2002      	movs	r0, #2
c0d02e2c:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02e2e:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d02e30:	2202      	movs	r2, #2
c0d02e32:	4620      	mov	r0, r4
c0d02e34:	4629      	mov	r1, r5
c0d02e36:	f000 fa33 	bl	c0d032a0 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02e3a:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02e3c:	2180      	movs	r1, #128	; 0x80
c0d02e3e:	4620      	mov	r0, r4
c0d02e40:	f7ff fc72 	bl	c0d02728 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02e44:	2100      	movs	r1, #0
c0d02e46:	4620      	mov	r0, r4
c0d02e48:	f7ff fc6e 	bl	c0d02728 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02e4c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e4e <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e4e:	b5b0      	push	{r4, r5, r7, lr}
c0d02e50:	af02      	add	r7, sp, #8
c0d02e52:	460d      	mov	r5, r1
c0d02e54:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02e56:	8868      	ldrh	r0, [r5, #2]
c0d02e58:	2801      	cmp	r0, #1
c0d02e5a:	d110      	bne.n	c0d02e7e <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02e5c:	2041      	movs	r0, #65	; 0x41
c0d02e5e:	0080      	lsls	r0, r0, #2
c0d02e60:	2101      	movs	r1, #1
c0d02e62:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02e64:	2045      	movs	r0, #69	; 0x45
c0d02e66:	0080      	lsls	r0, r0, #2
c0d02e68:	5820      	ldr	r0, [r4, r0]
c0d02e6a:	6880      	ldr	r0, [r0, #8]
c0d02e6c:	f7ff f846 	bl	c0d01efc <pic>
c0d02e70:	4602      	mov	r2, r0
c0d02e72:	4620      	mov	r0, r4
c0d02e74:	4629      	mov	r1, r5
c0d02e76:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02e78:	4620      	mov	r0, r4
c0d02e7a:	f000 fa3f 	bl	c0d032fc <USBD_CtlSendStatus>
  }

}
c0d02e7e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e80 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e80:	b5b0      	push	{r4, r5, r7, lr}
c0d02e82:	af02      	add	r7, sp, #8
c0d02e84:	460d      	mov	r5, r1
c0d02e86:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02e88:	20fc      	movs	r0, #252	; 0xfc
c0d02e8a:	5c20      	ldrb	r0, [r4, r0]
c0d02e8c:	21fe      	movs	r1, #254	; 0xfe
c0d02e8e:	4001      	ands	r1, r0
c0d02e90:	2902      	cmp	r1, #2
c0d02e92:	d114      	bne.n	c0d02ebe <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02e94:	8868      	ldrh	r0, [r5, #2]
c0d02e96:	2801      	cmp	r0, #1
c0d02e98:	d119      	bne.n	c0d02ece <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02e9a:	2041      	movs	r0, #65	; 0x41
c0d02e9c:	0080      	lsls	r0, r0, #2
c0d02e9e:	2100      	movs	r1, #0
c0d02ea0:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d02ea2:	2045      	movs	r0, #69	; 0x45
c0d02ea4:	0080      	lsls	r0, r0, #2
c0d02ea6:	5820      	ldr	r0, [r4, r0]
c0d02ea8:	6880      	ldr	r0, [r0, #8]
c0d02eaa:	f7ff f827 	bl	c0d01efc <pic>
c0d02eae:	4602      	mov	r2, r0
c0d02eb0:	4620      	mov	r0, r4
c0d02eb2:	4629      	mov	r1, r5
c0d02eb4:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d02eb6:	4620      	mov	r0, r4
c0d02eb8:	f000 fa20 	bl	c0d032fc <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02ebc:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ebe:	2180      	movs	r1, #128	; 0x80
c0d02ec0:	4620      	mov	r0, r4
c0d02ec2:	f7ff fc31 	bl	c0d02728 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02ec6:	2100      	movs	r1, #0
c0d02ec8:	4620      	mov	r0, r4
c0d02eca:	f7ff fc2d 	bl	c0d02728 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02ece:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ed0 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02ed0:	b5d0      	push	{r4, r6, r7, lr}
c0d02ed2:	af02      	add	r7, sp, #8
c0d02ed4:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ed6:	2180      	movs	r1, #128	; 0x80
c0d02ed8:	f7ff fc26 	bl	c0d02728 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02edc:	2100      	movs	r1, #0
c0d02ede:	4620      	mov	r0, r4
c0d02ee0:	f7ff fc22 	bl	c0d02728 <USBD_LL_StallEP>
}
c0d02ee4:	bdd0      	pop	{r4, r6, r7, pc}

c0d02ee6 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02ee6:	b5b0      	push	{r4, r5, r7, lr}
c0d02ee8:	af02      	add	r7, sp, #8
c0d02eea:	460d      	mov	r5, r1
c0d02eec:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02eee:	20fc      	movs	r0, #252	; 0xfc
c0d02ef0:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02ef2:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02ef4:	2803      	cmp	r0, #3
c0d02ef6:	d115      	bne.n	c0d02f24 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d02ef8:	88a8      	ldrh	r0, [r5, #4]
c0d02efa:	22fe      	movs	r2, #254	; 0xfe
c0d02efc:	4002      	ands	r2, r0
c0d02efe:	2a01      	cmp	r2, #1
c0d02f00:	d810      	bhi.n	c0d02f24 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d02f02:	2045      	movs	r0, #69	; 0x45
c0d02f04:	0080      	lsls	r0, r0, #2
c0d02f06:	5820      	ldr	r0, [r4, r0]
c0d02f08:	6880      	ldr	r0, [r0, #8]
c0d02f0a:	f7fe fff7 	bl	c0d01efc <pic>
c0d02f0e:	4602      	mov	r2, r0
c0d02f10:	4620      	mov	r0, r4
c0d02f12:	4629      	mov	r1, r5
c0d02f14:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02f16:	88e8      	ldrh	r0, [r5, #6]
c0d02f18:	2800      	cmp	r0, #0
c0d02f1a:	d10a      	bne.n	c0d02f32 <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d02f1c:	4620      	mov	r0, r4
c0d02f1e:	f000 f9ed 	bl	c0d032fc <USBD_CtlSendStatus>
c0d02f22:	e006      	b.n	c0d02f32 <USBD_StdItfReq+0x4c>
c0d02f24:	4620      	mov	r0, r4
c0d02f26:	f7ff fbff 	bl	c0d02728 <USBD_LL_StallEP>
c0d02f2a:	2100      	movs	r1, #0
c0d02f2c:	4620      	mov	r0, r4
c0d02f2e:	f7ff fbfb 	bl	c0d02728 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02f32:	2000      	movs	r0, #0
c0d02f34:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f36 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f36:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f38:	af03      	add	r7, sp, #12
c0d02f3a:	b081      	sub	sp, #4
c0d02f3c:	460e      	mov	r6, r1
c0d02f3e:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d02f40:	7830      	ldrb	r0, [r6, #0]
c0d02f42:	2160      	movs	r1, #96	; 0x60
c0d02f44:	4001      	ands	r1, r0
c0d02f46:	2920      	cmp	r1, #32
c0d02f48:	d10a      	bne.n	c0d02f60 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d02f4a:	2045      	movs	r0, #69	; 0x45
c0d02f4c:	0080      	lsls	r0, r0, #2
c0d02f4e:	5820      	ldr	r0, [r4, r0]
c0d02f50:	6880      	ldr	r0, [r0, #8]
c0d02f52:	f7fe ffd3 	bl	c0d01efc <pic>
c0d02f56:	4602      	mov	r2, r0
c0d02f58:	4620      	mov	r0, r4
c0d02f5a:	4631      	mov	r1, r6
c0d02f5c:	4790      	blx	r2
c0d02f5e:	e063      	b.n	c0d03028 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02f60:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02f62:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02f64:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02f66:	2800      	cmp	r0, #0
c0d02f68:	d012      	beq.n	c0d02f90 <USBD_StdEPReq+0x5a>
c0d02f6a:	2801      	cmp	r0, #1
c0d02f6c:	d019      	beq.n	c0d02fa2 <USBD_StdEPReq+0x6c>
c0d02f6e:	2803      	cmp	r0, #3
c0d02f70:	d15a      	bne.n	c0d03028 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02f72:	20fc      	movs	r0, #252	; 0xfc
c0d02f74:	5c20      	ldrb	r0, [r4, r0]
c0d02f76:	2803      	cmp	r0, #3
c0d02f78:	d117      	bne.n	c0d02faa <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02f7a:	8870      	ldrh	r0, [r6, #2]
c0d02f7c:	2800      	cmp	r0, #0
c0d02f7e:	d12d      	bne.n	c0d02fdc <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02f80:	4329      	orrs	r1, r5
c0d02f82:	2980      	cmp	r1, #128	; 0x80
c0d02f84:	d02a      	beq.n	c0d02fdc <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02f86:	4620      	mov	r0, r4
c0d02f88:	4629      	mov	r1, r5
c0d02f8a:	f7ff fbcd 	bl	c0d02728 <USBD_LL_StallEP>
c0d02f8e:	e025      	b.n	c0d02fdc <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02f90:	20fc      	movs	r0, #252	; 0xfc
c0d02f92:	5c20      	ldrb	r0, [r4, r0]
c0d02f94:	2803      	cmp	r0, #3
c0d02f96:	d02f      	beq.n	c0d02ff8 <USBD_StdEPReq+0xc2>
c0d02f98:	2802      	cmp	r0, #2
c0d02f9a:	d10e      	bne.n	c0d02fba <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02f9c:	0668      	lsls	r0, r5, #25
c0d02f9e:	d109      	bne.n	c0d02fb4 <USBD_StdEPReq+0x7e>
c0d02fa0:	e042      	b.n	c0d03028 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02fa2:	20fc      	movs	r0, #252	; 0xfc
c0d02fa4:	5c20      	ldrb	r0, [r4, r0]
c0d02fa6:	2803      	cmp	r0, #3
c0d02fa8:	d00f      	beq.n	c0d02fca <USBD_StdEPReq+0x94>
c0d02faa:	2802      	cmp	r0, #2
c0d02fac:	d105      	bne.n	c0d02fba <USBD_StdEPReq+0x84>
c0d02fae:	4329      	orrs	r1, r5
c0d02fb0:	2980      	cmp	r1, #128	; 0x80
c0d02fb2:	d039      	beq.n	c0d03028 <USBD_StdEPReq+0xf2>
c0d02fb4:	4620      	mov	r0, r4
c0d02fb6:	4629      	mov	r1, r5
c0d02fb8:	e004      	b.n	c0d02fc4 <USBD_StdEPReq+0x8e>
c0d02fba:	4620      	mov	r0, r4
c0d02fbc:	f7ff fbb4 	bl	c0d02728 <USBD_LL_StallEP>
c0d02fc0:	2100      	movs	r1, #0
c0d02fc2:	4620      	mov	r0, r4
c0d02fc4:	f7ff fbb0 	bl	c0d02728 <USBD_LL_StallEP>
c0d02fc8:	e02e      	b.n	c0d03028 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02fca:	8870      	ldrh	r0, [r6, #2]
c0d02fcc:	2800      	cmp	r0, #0
c0d02fce:	d12b      	bne.n	c0d03028 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02fd0:	0668      	lsls	r0, r5, #25
c0d02fd2:	d00d      	beq.n	c0d02ff0 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02fd4:	4620      	mov	r0, r4
c0d02fd6:	4629      	mov	r1, r5
c0d02fd8:	f7ff fbcc 	bl	c0d02774 <USBD_LL_ClearStallEP>
c0d02fdc:	2045      	movs	r0, #69	; 0x45
c0d02fde:	0080      	lsls	r0, r0, #2
c0d02fe0:	5820      	ldr	r0, [r4, r0]
c0d02fe2:	6880      	ldr	r0, [r0, #8]
c0d02fe4:	f7fe ff8a 	bl	c0d01efc <pic>
c0d02fe8:	4602      	mov	r2, r0
c0d02fea:	4620      	mov	r0, r4
c0d02fec:	4631      	mov	r1, r6
c0d02fee:	4790      	blx	r2
c0d02ff0:	4620      	mov	r0, r4
c0d02ff2:	f000 f983 	bl	c0d032fc <USBD_CtlSendStatus>
c0d02ff6:	e017      	b.n	c0d03028 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02ff8:	4626      	mov	r6, r4
c0d02ffa:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02ffc:	4620      	mov	r0, r4
c0d02ffe:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03000:	420d      	tst	r5, r1
c0d03002:	d100      	bne.n	c0d03006 <USBD_StdEPReq+0xd0>
c0d03004:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03006:	4620      	mov	r0, r4
c0d03008:	4629      	mov	r1, r5
c0d0300a:	f7ff fbd9 	bl	c0d027c0 <USBD_LL_IsStallEP>
c0d0300e:	2101      	movs	r1, #1
c0d03010:	2800      	cmp	r0, #0
c0d03012:	d100      	bne.n	c0d03016 <USBD_StdEPReq+0xe0>
c0d03014:	4601      	mov	r1, r0
c0d03016:	207f      	movs	r0, #127	; 0x7f
c0d03018:	4005      	ands	r5, r0
c0d0301a:	0128      	lsls	r0, r5, #4
c0d0301c:	5031      	str	r1, [r6, r0]
c0d0301e:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03020:	2202      	movs	r2, #2
c0d03022:	4620      	mov	r0, r4
c0d03024:	f000 f93c 	bl	c0d032a0 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d03028:	2000      	movs	r0, #0
c0d0302a:	b001      	add	sp, #4
c0d0302c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0302e <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d0302e:	780a      	ldrb	r2, [r1, #0]
c0d03030:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03032:	784a      	ldrb	r2, [r1, #1]
c0d03034:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03036:	788a      	ldrb	r2, [r1, #2]
c0d03038:	78cb      	ldrb	r3, [r1, #3]
c0d0303a:	021b      	lsls	r3, r3, #8
c0d0303c:	4313      	orrs	r3, r2
c0d0303e:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03040:	790a      	ldrb	r2, [r1, #4]
c0d03042:	794b      	ldrb	r3, [r1, #5]
c0d03044:	021b      	lsls	r3, r3, #8
c0d03046:	4313      	orrs	r3, r2
c0d03048:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0304a:	798a      	ldrb	r2, [r1, #6]
c0d0304c:	79c9      	ldrb	r1, [r1, #7]
c0d0304e:	0209      	lsls	r1, r1, #8
c0d03050:	4311      	orrs	r1, r2
c0d03052:	80c1      	strh	r1, [r0, #6]

}
c0d03054:	4770      	bx	lr

c0d03056 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03056:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03058:	af03      	add	r7, sp, #12
c0d0305a:	b083      	sub	sp, #12
c0d0305c:	460d      	mov	r5, r1
c0d0305e:	4604      	mov	r4, r0
c0d03060:	a802      	add	r0, sp, #8
c0d03062:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d03064:	8006      	strh	r6, [r0, #0]
c0d03066:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d03068:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0306a:	7829      	ldrb	r1, [r5, #0]
c0d0306c:	2060      	movs	r0, #96	; 0x60
c0d0306e:	4008      	ands	r0, r1
c0d03070:	2800      	cmp	r0, #0
c0d03072:	d010      	beq.n	c0d03096 <USBD_HID_Setup+0x40>
c0d03074:	2820      	cmp	r0, #32
c0d03076:	d139      	bne.n	c0d030ec <USBD_HID_Setup+0x96>
c0d03078:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0307a:	4601      	mov	r1, r0
c0d0307c:	390a      	subs	r1, #10
c0d0307e:	2902      	cmp	r1, #2
c0d03080:	d334      	bcc.n	c0d030ec <USBD_HID_Setup+0x96>
c0d03082:	2802      	cmp	r0, #2
c0d03084:	d01c      	beq.n	c0d030c0 <USBD_HID_Setup+0x6a>
c0d03086:	2803      	cmp	r0, #3
c0d03088:	d01a      	beq.n	c0d030c0 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0308a:	4620      	mov	r0, r4
c0d0308c:	4629      	mov	r1, r5
c0d0308e:	f7ff ff1f 	bl	c0d02ed0 <USBD_CtlError>
c0d03092:	2602      	movs	r6, #2
c0d03094:	e02a      	b.n	c0d030ec <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d03096:	7868      	ldrb	r0, [r5, #1]
c0d03098:	280b      	cmp	r0, #11
c0d0309a:	d014      	beq.n	c0d030c6 <USBD_HID_Setup+0x70>
c0d0309c:	280a      	cmp	r0, #10
c0d0309e:	d00f      	beq.n	c0d030c0 <USBD_HID_Setup+0x6a>
c0d030a0:	2806      	cmp	r0, #6
c0d030a2:	d123      	bne.n	c0d030ec <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d030a4:	8868      	ldrh	r0, [r5, #2]
c0d030a6:	0a00      	lsrs	r0, r0, #8
c0d030a8:	2600      	movs	r6, #0
c0d030aa:	2821      	cmp	r0, #33	; 0x21
c0d030ac:	d00f      	beq.n	c0d030ce <USBD_HID_Setup+0x78>
c0d030ae:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d030b0:	4632      	mov	r2, r6
c0d030b2:	4631      	mov	r1, r6
c0d030b4:	d117      	bne.n	c0d030e6 <USBD_HID_Setup+0x90>
c0d030b6:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d030b8:	9000      	str	r0, [sp, #0]
c0d030ba:	f000 f847 	bl	c0d0314c <USBD_HID_GetReportDescriptor_impl>
c0d030be:	e00a      	b.n	c0d030d6 <USBD_HID_Setup+0x80>
c0d030c0:	a901      	add	r1, sp, #4
c0d030c2:	2201      	movs	r2, #1
c0d030c4:	e00f      	b.n	c0d030e6 <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d030c6:	4620      	mov	r0, r4
c0d030c8:	f000 f918 	bl	c0d032fc <USBD_CtlSendStatus>
c0d030cc:	e00e      	b.n	c0d030ec <USBD_HID_Setup+0x96>
c0d030ce:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d030d0:	9000      	str	r0, [sp, #0]
c0d030d2:	f000 f833 	bl	c0d0313c <USBD_HID_GetHidDescriptor_impl>
c0d030d6:	9b00      	ldr	r3, [sp, #0]
c0d030d8:	4601      	mov	r1, r0
c0d030da:	881a      	ldrh	r2, [r3, #0]
c0d030dc:	88e8      	ldrh	r0, [r5, #6]
c0d030de:	4282      	cmp	r2, r0
c0d030e0:	d300      	bcc.n	c0d030e4 <USBD_HID_Setup+0x8e>
c0d030e2:	4602      	mov	r2, r0
c0d030e4:	801a      	strh	r2, [r3, #0]
c0d030e6:	4620      	mov	r0, r4
c0d030e8:	f000 f8da 	bl	c0d032a0 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d030ec:	b2f0      	uxtb	r0, r6
c0d030ee:	b003      	add	sp, #12
c0d030f0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d030f2 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d030f2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d030f4:	af03      	add	r7, sp, #12
c0d030f6:	b081      	sub	sp, #4
c0d030f8:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d030fa:	2182      	movs	r1, #130	; 0x82
c0d030fc:	2502      	movs	r5, #2
c0d030fe:	2640      	movs	r6, #64	; 0x40
c0d03100:	462a      	mov	r2, r5
c0d03102:	4633      	mov	r3, r6
c0d03104:	f7ff fad0 	bl	c0d026a8 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03108:	4620      	mov	r0, r4
c0d0310a:	4629      	mov	r1, r5
c0d0310c:	462a      	mov	r2, r5
c0d0310e:	4633      	mov	r3, r6
c0d03110:	f7ff faca 	bl	c0d026a8 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03114:	4620      	mov	r0, r4
c0d03116:	4629      	mov	r1, r5
c0d03118:	4632      	mov	r2, r6
c0d0311a:	f7ff fb90 	bl	c0d0283e <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d0311e:	2000      	movs	r0, #0
c0d03120:	b001      	add	sp, #4
c0d03122:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03124 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03124:	b5d0      	push	{r4, r6, r7, lr}
c0d03126:	af02      	add	r7, sp, #8
c0d03128:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0312a:	2182      	movs	r1, #130	; 0x82
c0d0312c:	f7ff fae4 	bl	c0d026f8 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03130:	2102      	movs	r1, #2
c0d03132:	4620      	mov	r0, r4
c0d03134:	f7ff fae0 	bl	c0d026f8 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03138:	2000      	movs	r0, #0
c0d0313a:	bdd0      	pop	{r4, r6, r7, pc}

c0d0313c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d0313c:	2109      	movs	r1, #9
c0d0313e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d03140:	4801      	ldr	r0, [pc, #4]	; (c0d03148 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d03142:	4478      	add	r0, pc
c0d03144:	4770      	bx	lr
c0d03146:	46c0      	nop			; (mov r8, r8)
c0d03148:	00000c72 	.word	0x00000c72

c0d0314c <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d0314c:	2122      	movs	r1, #34	; 0x22
c0d0314e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d03150:	4801      	ldr	r0, [pc, #4]	; (c0d03158 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d03152:	4478      	add	r0, pc
c0d03154:	4770      	bx	lr
c0d03156:	46c0      	nop			; (mov r8, r8)
c0d03158:	00000c3d 	.word	0x00000c3d

c0d0315c <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d0315c:	b5b0      	push	{r4, r5, r7, lr}
c0d0315e:	af02      	add	r7, sp, #8
c0d03160:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03162:	2102      	movs	r1, #2
c0d03164:	2240      	movs	r2, #64	; 0x40
c0d03166:	f7ff fb6a 	bl	c0d0283e <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d0316a:	4d0d      	ldr	r5, [pc, #52]	; (c0d031a0 <USBD_HID_DataOut_impl+0x44>)
c0d0316c:	7828      	ldrb	r0, [r5, #0]
c0d0316e:	2800      	cmp	r0, #0
c0d03170:	d113      	bne.n	c0d0319a <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d03172:	2002      	movs	r0, #2
c0d03174:	f7fe f928 	bl	c0d013c8 <io_seproxyhal_get_ep_rx_size>
c0d03178:	4602      	mov	r2, r0
c0d0317a:	480d      	ldr	r0, [pc, #52]	; (c0d031b0 <USBD_HID_DataOut_impl+0x54>)
c0d0317c:	4478      	add	r0, pc
c0d0317e:	4621      	mov	r1, r4
c0d03180:	f7fd ff86 	bl	c0d01090 <io_usb_hid_receive>
c0d03184:	2802      	cmp	r0, #2
c0d03186:	d108      	bne.n	c0d0319a <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03188:	2001      	movs	r0, #1
c0d0318a:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0318c:	4805      	ldr	r0, [pc, #20]	; (c0d031a4 <USBD_HID_DataOut_impl+0x48>)
c0d0318e:	2107      	movs	r1, #7
c0d03190:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d03192:	4805      	ldr	r0, [pc, #20]	; (c0d031a8 <USBD_HID_DataOut_impl+0x4c>)
c0d03194:	6800      	ldr	r0, [r0, #0]
c0d03196:	4905      	ldr	r1, [pc, #20]	; (c0d031ac <USBD_HID_DataOut_impl+0x50>)
c0d03198:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d0319a:	2000      	movs	r0, #0
c0d0319c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0319e:	46c0      	nop			; (mov r8, r8)
c0d031a0:	20001d10 	.word	0x20001d10
c0d031a4:	20001d18 	.word	0x20001d18
c0d031a8:	20001c00 	.word	0x20001c00
c0d031ac:	20001d1c 	.word	0x20001d1c
c0d031b0:	ffffe3a1 	.word	0xffffe3a1

c0d031b4 <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d031b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031b6:	af03      	add	r7, sp, #12
c0d031b8:	b081      	sub	sp, #4
c0d031ba:	4604      	mov	r4, r0
c0d031bc:	2049      	movs	r0, #73	; 0x49
c0d031be:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d031c0:	4810      	ldr	r0, [pc, #64]	; (c0d03204 <USB_power+0x50>)
c0d031c2:	2100      	movs	r1, #0
c0d031c4:	462a      	mov	r2, r5
c0d031c6:	f7fe f80f 	bl	c0d011e8 <os_memset>

  if (enabled) {
c0d031ca:	2c00      	cmp	r4, #0
c0d031cc:	d015      	beq.n	c0d031fa <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d031ce:	4c0d      	ldr	r4, [pc, #52]	; (c0d03204 <USB_power+0x50>)
c0d031d0:	2600      	movs	r6, #0
c0d031d2:	4620      	mov	r0, r4
c0d031d4:	4631      	mov	r1, r6
c0d031d6:	462a      	mov	r2, r5
c0d031d8:	f7fe f806 	bl	c0d011e8 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d031dc:	490a      	ldr	r1, [pc, #40]	; (c0d03208 <USB_power+0x54>)
c0d031de:	4479      	add	r1, pc
c0d031e0:	4620      	mov	r0, r4
c0d031e2:	4632      	mov	r2, r6
c0d031e4:	f7ff fb3f 	bl	c0d02866 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d031e8:	4908      	ldr	r1, [pc, #32]	; (c0d0320c <USB_power+0x58>)
c0d031ea:	4479      	add	r1, pc
c0d031ec:	4620      	mov	r0, r4
c0d031ee:	f7ff fb72 	bl	c0d028d6 <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d031f2:	4620      	mov	r0, r4
c0d031f4:	f7ff fb78 	bl	c0d028e8 <USBD_Start>
c0d031f8:	e002      	b.n	c0d03200 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d031fa:	4802      	ldr	r0, [pc, #8]	; (c0d03204 <USB_power+0x50>)
c0d031fc:	f7ff fb51 	bl	c0d028a2 <USBD_DeInit>
  }
}
c0d03200:	b001      	add	sp, #4
c0d03202:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03204:	20001d34 	.word	0x20001d34
c0d03208:	00000bf2 	.word	0x00000bf2
c0d0320c:	00000c22 	.word	0x00000c22

c0d03210 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03210:	2012      	movs	r0, #18
c0d03212:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03214:	4801      	ldr	r0, [pc, #4]	; (c0d0321c <USBD_DeviceDescriptor+0xc>)
c0d03216:	4478      	add	r0, pc
c0d03218:	4770      	bx	lr
c0d0321a:	46c0      	nop			; (mov r8, r8)
c0d0321c:	00000ba7 	.word	0x00000ba7

c0d03220 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03220:	2004      	movs	r0, #4
c0d03222:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03224:	4801      	ldr	r0, [pc, #4]	; (c0d0322c <USBD_LangIDStrDescriptor+0xc>)
c0d03226:	4478      	add	r0, pc
c0d03228:	4770      	bx	lr
c0d0322a:	46c0      	nop			; (mov r8, r8)
c0d0322c:	00000bca 	.word	0x00000bca

c0d03230 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03230:	200e      	movs	r0, #14
c0d03232:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03234:	4801      	ldr	r0, [pc, #4]	; (c0d0323c <USBD_ManufacturerStrDescriptor+0xc>)
c0d03236:	4478      	add	r0, pc
c0d03238:	4770      	bx	lr
c0d0323a:	46c0      	nop			; (mov r8, r8)
c0d0323c:	00000bbe 	.word	0x00000bbe

c0d03240 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03240:	200e      	movs	r0, #14
c0d03242:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03244:	4801      	ldr	r0, [pc, #4]	; (c0d0324c <USBD_ProductStrDescriptor+0xc>)
c0d03246:	4478      	add	r0, pc
c0d03248:	4770      	bx	lr
c0d0324a:	46c0      	nop			; (mov r8, r8)
c0d0324c:	00000b3b 	.word	0x00000b3b

c0d03250 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03250:	200a      	movs	r0, #10
c0d03252:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03254:	4801      	ldr	r0, [pc, #4]	; (c0d0325c <USBD_SerialStrDescriptor+0xc>)
c0d03256:	4478      	add	r0, pc
c0d03258:	4770      	bx	lr
c0d0325a:	46c0      	nop			; (mov r8, r8)
c0d0325c:	00000bac 	.word	0x00000bac

c0d03260 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03260:	200e      	movs	r0, #14
c0d03262:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03264:	4801      	ldr	r0, [pc, #4]	; (c0d0326c <USBD_ConfigStrDescriptor+0xc>)
c0d03266:	4478      	add	r0, pc
c0d03268:	4770      	bx	lr
c0d0326a:	46c0      	nop			; (mov r8, r8)
c0d0326c:	00000b1b 	.word	0x00000b1b

c0d03270 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03270:	200e      	movs	r0, #14
c0d03272:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03274:	4801      	ldr	r0, [pc, #4]	; (c0d0327c <USBD_InterfaceStrDescriptor+0xc>)
c0d03276:	4478      	add	r0, pc
c0d03278:	4770      	bx	lr
c0d0327a:	46c0      	nop			; (mov r8, r8)
c0d0327c:	00000b0b 	.word	0x00000b0b

c0d03280 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d03280:	2129      	movs	r1, #41	; 0x29
c0d03282:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03284:	4801      	ldr	r0, [pc, #4]	; (c0d0328c <USBD_GetCfgDesc_impl+0xc>)
c0d03286:	4478      	add	r0, pc
c0d03288:	4770      	bx	lr
c0d0328a:	46c0      	nop			; (mov r8, r8)
c0d0328c:	00000bbe 	.word	0x00000bbe

c0d03290 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03290:	210a      	movs	r1, #10
c0d03292:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03294:	4801      	ldr	r0, [pc, #4]	; (c0d0329c <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d03296:	4478      	add	r0, pc
c0d03298:	4770      	bx	lr
c0d0329a:	46c0      	nop			; (mov r8, r8)
c0d0329c:	00000bda 	.word	0x00000bda

c0d032a0 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d032a0:	b5b0      	push	{r4, r5, r7, lr}
c0d032a2:	af02      	add	r7, sp, #8
c0d032a4:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d032a6:	21f4      	movs	r1, #244	; 0xf4
c0d032a8:	2302      	movs	r3, #2
c0d032aa:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d032ac:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d032ae:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d032b0:	2109      	movs	r1, #9
c0d032b2:	0149      	lsls	r1, r1, #5
c0d032b4:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d032b6:	6a01      	ldr	r1, [r0, #32]
c0d032b8:	428a      	cmp	r2, r1
c0d032ba:	d300      	bcc.n	c0d032be <USBD_CtlSendData+0x1e>
c0d032bc:	460a      	mov	r2, r1
c0d032be:	b293      	uxth	r3, r2
c0d032c0:	2500      	movs	r5, #0
c0d032c2:	4629      	mov	r1, r5
c0d032c4:	4622      	mov	r2, r4
c0d032c6:	f7ff faa0 	bl	c0d0280a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d032ca:	4628      	mov	r0, r5
c0d032cc:	bdb0      	pop	{r4, r5, r7, pc}

c0d032ce <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d032ce:	b5b0      	push	{r4, r5, r7, lr}
c0d032d0:	af02      	add	r7, sp, #8
c0d032d2:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d032d4:	6a01      	ldr	r1, [r0, #32]
c0d032d6:	428a      	cmp	r2, r1
c0d032d8:	d300      	bcc.n	c0d032dc <USBD_CtlContinueSendData+0xe>
c0d032da:	460a      	mov	r2, r1
c0d032dc:	b293      	uxth	r3, r2
c0d032de:	2500      	movs	r5, #0
c0d032e0:	4629      	mov	r1, r5
c0d032e2:	4622      	mov	r2, r4
c0d032e4:	f7ff fa91 	bl	c0d0280a <USBD_LL_Transmit>
  return USBD_OK;
c0d032e8:	4628      	mov	r0, r5
c0d032ea:	bdb0      	pop	{r4, r5, r7, pc}

c0d032ec <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d032ec:	b5d0      	push	{r4, r6, r7, lr}
c0d032ee:	af02      	add	r7, sp, #8
c0d032f0:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d032f2:	4621      	mov	r1, r4
c0d032f4:	f7ff faa3 	bl	c0d0283e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d032f8:	4620      	mov	r0, r4
c0d032fa:	bdd0      	pop	{r4, r6, r7, pc}

c0d032fc <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d032fc:	b5d0      	push	{r4, r6, r7, lr}
c0d032fe:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03300:	21f4      	movs	r1, #244	; 0xf4
c0d03302:	2204      	movs	r2, #4
c0d03304:	5042      	str	r2, [r0, r1]
c0d03306:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03308:	4621      	mov	r1, r4
c0d0330a:	4622      	mov	r2, r4
c0d0330c:	4623      	mov	r3, r4
c0d0330e:	f7ff fa7c 	bl	c0d0280a <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03312:	4620      	mov	r0, r4
c0d03314:	bdd0      	pop	{r4, r6, r7, pc}

c0d03316 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03316:	b5d0      	push	{r4, r6, r7, lr}
c0d03318:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0331a:	21f4      	movs	r1, #244	; 0xf4
c0d0331c:	2205      	movs	r2, #5
c0d0331e:	5042      	str	r2, [r0, r1]
c0d03320:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03322:	4621      	mov	r1, r4
c0d03324:	4622      	mov	r2, r4
c0d03326:	f7ff fa8a 	bl	c0d0283e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0332a:	4620      	mov	r0, r4
c0d0332c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d03330 <__aeabi_uidiv>:
c0d03330:	2200      	movs	r2, #0
c0d03332:	0843      	lsrs	r3, r0, #1
c0d03334:	428b      	cmp	r3, r1
c0d03336:	d374      	bcc.n	c0d03422 <__aeabi_uidiv+0xf2>
c0d03338:	0903      	lsrs	r3, r0, #4
c0d0333a:	428b      	cmp	r3, r1
c0d0333c:	d35f      	bcc.n	c0d033fe <__aeabi_uidiv+0xce>
c0d0333e:	0a03      	lsrs	r3, r0, #8
c0d03340:	428b      	cmp	r3, r1
c0d03342:	d344      	bcc.n	c0d033ce <__aeabi_uidiv+0x9e>
c0d03344:	0b03      	lsrs	r3, r0, #12
c0d03346:	428b      	cmp	r3, r1
c0d03348:	d328      	bcc.n	c0d0339c <__aeabi_uidiv+0x6c>
c0d0334a:	0c03      	lsrs	r3, r0, #16
c0d0334c:	428b      	cmp	r3, r1
c0d0334e:	d30d      	bcc.n	c0d0336c <__aeabi_uidiv+0x3c>
c0d03350:	22ff      	movs	r2, #255	; 0xff
c0d03352:	0209      	lsls	r1, r1, #8
c0d03354:	ba12      	rev	r2, r2
c0d03356:	0c03      	lsrs	r3, r0, #16
c0d03358:	428b      	cmp	r3, r1
c0d0335a:	d302      	bcc.n	c0d03362 <__aeabi_uidiv+0x32>
c0d0335c:	1212      	asrs	r2, r2, #8
c0d0335e:	0209      	lsls	r1, r1, #8
c0d03360:	d065      	beq.n	c0d0342e <__aeabi_uidiv+0xfe>
c0d03362:	0b03      	lsrs	r3, r0, #12
c0d03364:	428b      	cmp	r3, r1
c0d03366:	d319      	bcc.n	c0d0339c <__aeabi_uidiv+0x6c>
c0d03368:	e000      	b.n	c0d0336c <__aeabi_uidiv+0x3c>
c0d0336a:	0a09      	lsrs	r1, r1, #8
c0d0336c:	0bc3      	lsrs	r3, r0, #15
c0d0336e:	428b      	cmp	r3, r1
c0d03370:	d301      	bcc.n	c0d03376 <__aeabi_uidiv+0x46>
c0d03372:	03cb      	lsls	r3, r1, #15
c0d03374:	1ac0      	subs	r0, r0, r3
c0d03376:	4152      	adcs	r2, r2
c0d03378:	0b83      	lsrs	r3, r0, #14
c0d0337a:	428b      	cmp	r3, r1
c0d0337c:	d301      	bcc.n	c0d03382 <__aeabi_uidiv+0x52>
c0d0337e:	038b      	lsls	r3, r1, #14
c0d03380:	1ac0      	subs	r0, r0, r3
c0d03382:	4152      	adcs	r2, r2
c0d03384:	0b43      	lsrs	r3, r0, #13
c0d03386:	428b      	cmp	r3, r1
c0d03388:	d301      	bcc.n	c0d0338e <__aeabi_uidiv+0x5e>
c0d0338a:	034b      	lsls	r3, r1, #13
c0d0338c:	1ac0      	subs	r0, r0, r3
c0d0338e:	4152      	adcs	r2, r2
c0d03390:	0b03      	lsrs	r3, r0, #12
c0d03392:	428b      	cmp	r3, r1
c0d03394:	d301      	bcc.n	c0d0339a <__aeabi_uidiv+0x6a>
c0d03396:	030b      	lsls	r3, r1, #12
c0d03398:	1ac0      	subs	r0, r0, r3
c0d0339a:	4152      	adcs	r2, r2
c0d0339c:	0ac3      	lsrs	r3, r0, #11
c0d0339e:	428b      	cmp	r3, r1
c0d033a0:	d301      	bcc.n	c0d033a6 <__aeabi_uidiv+0x76>
c0d033a2:	02cb      	lsls	r3, r1, #11
c0d033a4:	1ac0      	subs	r0, r0, r3
c0d033a6:	4152      	adcs	r2, r2
c0d033a8:	0a83      	lsrs	r3, r0, #10
c0d033aa:	428b      	cmp	r3, r1
c0d033ac:	d301      	bcc.n	c0d033b2 <__aeabi_uidiv+0x82>
c0d033ae:	028b      	lsls	r3, r1, #10
c0d033b0:	1ac0      	subs	r0, r0, r3
c0d033b2:	4152      	adcs	r2, r2
c0d033b4:	0a43      	lsrs	r3, r0, #9
c0d033b6:	428b      	cmp	r3, r1
c0d033b8:	d301      	bcc.n	c0d033be <__aeabi_uidiv+0x8e>
c0d033ba:	024b      	lsls	r3, r1, #9
c0d033bc:	1ac0      	subs	r0, r0, r3
c0d033be:	4152      	adcs	r2, r2
c0d033c0:	0a03      	lsrs	r3, r0, #8
c0d033c2:	428b      	cmp	r3, r1
c0d033c4:	d301      	bcc.n	c0d033ca <__aeabi_uidiv+0x9a>
c0d033c6:	020b      	lsls	r3, r1, #8
c0d033c8:	1ac0      	subs	r0, r0, r3
c0d033ca:	4152      	adcs	r2, r2
c0d033cc:	d2cd      	bcs.n	c0d0336a <__aeabi_uidiv+0x3a>
c0d033ce:	09c3      	lsrs	r3, r0, #7
c0d033d0:	428b      	cmp	r3, r1
c0d033d2:	d301      	bcc.n	c0d033d8 <__aeabi_uidiv+0xa8>
c0d033d4:	01cb      	lsls	r3, r1, #7
c0d033d6:	1ac0      	subs	r0, r0, r3
c0d033d8:	4152      	adcs	r2, r2
c0d033da:	0983      	lsrs	r3, r0, #6
c0d033dc:	428b      	cmp	r3, r1
c0d033de:	d301      	bcc.n	c0d033e4 <__aeabi_uidiv+0xb4>
c0d033e0:	018b      	lsls	r3, r1, #6
c0d033e2:	1ac0      	subs	r0, r0, r3
c0d033e4:	4152      	adcs	r2, r2
c0d033e6:	0943      	lsrs	r3, r0, #5
c0d033e8:	428b      	cmp	r3, r1
c0d033ea:	d301      	bcc.n	c0d033f0 <__aeabi_uidiv+0xc0>
c0d033ec:	014b      	lsls	r3, r1, #5
c0d033ee:	1ac0      	subs	r0, r0, r3
c0d033f0:	4152      	adcs	r2, r2
c0d033f2:	0903      	lsrs	r3, r0, #4
c0d033f4:	428b      	cmp	r3, r1
c0d033f6:	d301      	bcc.n	c0d033fc <__aeabi_uidiv+0xcc>
c0d033f8:	010b      	lsls	r3, r1, #4
c0d033fa:	1ac0      	subs	r0, r0, r3
c0d033fc:	4152      	adcs	r2, r2
c0d033fe:	08c3      	lsrs	r3, r0, #3
c0d03400:	428b      	cmp	r3, r1
c0d03402:	d301      	bcc.n	c0d03408 <__aeabi_uidiv+0xd8>
c0d03404:	00cb      	lsls	r3, r1, #3
c0d03406:	1ac0      	subs	r0, r0, r3
c0d03408:	4152      	adcs	r2, r2
c0d0340a:	0883      	lsrs	r3, r0, #2
c0d0340c:	428b      	cmp	r3, r1
c0d0340e:	d301      	bcc.n	c0d03414 <__aeabi_uidiv+0xe4>
c0d03410:	008b      	lsls	r3, r1, #2
c0d03412:	1ac0      	subs	r0, r0, r3
c0d03414:	4152      	adcs	r2, r2
c0d03416:	0843      	lsrs	r3, r0, #1
c0d03418:	428b      	cmp	r3, r1
c0d0341a:	d301      	bcc.n	c0d03420 <__aeabi_uidiv+0xf0>
c0d0341c:	004b      	lsls	r3, r1, #1
c0d0341e:	1ac0      	subs	r0, r0, r3
c0d03420:	4152      	adcs	r2, r2
c0d03422:	1a41      	subs	r1, r0, r1
c0d03424:	d200      	bcs.n	c0d03428 <__aeabi_uidiv+0xf8>
c0d03426:	4601      	mov	r1, r0
c0d03428:	4152      	adcs	r2, r2
c0d0342a:	4610      	mov	r0, r2
c0d0342c:	4770      	bx	lr
c0d0342e:	e7ff      	b.n	c0d03430 <__aeabi_uidiv+0x100>
c0d03430:	b501      	push	{r0, lr}
c0d03432:	2000      	movs	r0, #0
c0d03434:	f000 f8f0 	bl	c0d03618 <__aeabi_idiv0>
c0d03438:	bd02      	pop	{r1, pc}
c0d0343a:	46c0      	nop			; (mov r8, r8)

c0d0343c <__aeabi_uidivmod>:
c0d0343c:	2900      	cmp	r1, #0
c0d0343e:	d0f7      	beq.n	c0d03430 <__aeabi_uidiv+0x100>
c0d03440:	e776      	b.n	c0d03330 <__aeabi_uidiv>
c0d03442:	4770      	bx	lr

c0d03444 <__aeabi_idiv>:
c0d03444:	4603      	mov	r3, r0
c0d03446:	430b      	orrs	r3, r1
c0d03448:	d47f      	bmi.n	c0d0354a <__aeabi_idiv+0x106>
c0d0344a:	2200      	movs	r2, #0
c0d0344c:	0843      	lsrs	r3, r0, #1
c0d0344e:	428b      	cmp	r3, r1
c0d03450:	d374      	bcc.n	c0d0353c <__aeabi_idiv+0xf8>
c0d03452:	0903      	lsrs	r3, r0, #4
c0d03454:	428b      	cmp	r3, r1
c0d03456:	d35f      	bcc.n	c0d03518 <__aeabi_idiv+0xd4>
c0d03458:	0a03      	lsrs	r3, r0, #8
c0d0345a:	428b      	cmp	r3, r1
c0d0345c:	d344      	bcc.n	c0d034e8 <__aeabi_idiv+0xa4>
c0d0345e:	0b03      	lsrs	r3, r0, #12
c0d03460:	428b      	cmp	r3, r1
c0d03462:	d328      	bcc.n	c0d034b6 <__aeabi_idiv+0x72>
c0d03464:	0c03      	lsrs	r3, r0, #16
c0d03466:	428b      	cmp	r3, r1
c0d03468:	d30d      	bcc.n	c0d03486 <__aeabi_idiv+0x42>
c0d0346a:	22ff      	movs	r2, #255	; 0xff
c0d0346c:	0209      	lsls	r1, r1, #8
c0d0346e:	ba12      	rev	r2, r2
c0d03470:	0c03      	lsrs	r3, r0, #16
c0d03472:	428b      	cmp	r3, r1
c0d03474:	d302      	bcc.n	c0d0347c <__aeabi_idiv+0x38>
c0d03476:	1212      	asrs	r2, r2, #8
c0d03478:	0209      	lsls	r1, r1, #8
c0d0347a:	d065      	beq.n	c0d03548 <__aeabi_idiv+0x104>
c0d0347c:	0b03      	lsrs	r3, r0, #12
c0d0347e:	428b      	cmp	r3, r1
c0d03480:	d319      	bcc.n	c0d034b6 <__aeabi_idiv+0x72>
c0d03482:	e000      	b.n	c0d03486 <__aeabi_idiv+0x42>
c0d03484:	0a09      	lsrs	r1, r1, #8
c0d03486:	0bc3      	lsrs	r3, r0, #15
c0d03488:	428b      	cmp	r3, r1
c0d0348a:	d301      	bcc.n	c0d03490 <__aeabi_idiv+0x4c>
c0d0348c:	03cb      	lsls	r3, r1, #15
c0d0348e:	1ac0      	subs	r0, r0, r3
c0d03490:	4152      	adcs	r2, r2
c0d03492:	0b83      	lsrs	r3, r0, #14
c0d03494:	428b      	cmp	r3, r1
c0d03496:	d301      	bcc.n	c0d0349c <__aeabi_idiv+0x58>
c0d03498:	038b      	lsls	r3, r1, #14
c0d0349a:	1ac0      	subs	r0, r0, r3
c0d0349c:	4152      	adcs	r2, r2
c0d0349e:	0b43      	lsrs	r3, r0, #13
c0d034a0:	428b      	cmp	r3, r1
c0d034a2:	d301      	bcc.n	c0d034a8 <__aeabi_idiv+0x64>
c0d034a4:	034b      	lsls	r3, r1, #13
c0d034a6:	1ac0      	subs	r0, r0, r3
c0d034a8:	4152      	adcs	r2, r2
c0d034aa:	0b03      	lsrs	r3, r0, #12
c0d034ac:	428b      	cmp	r3, r1
c0d034ae:	d301      	bcc.n	c0d034b4 <__aeabi_idiv+0x70>
c0d034b0:	030b      	lsls	r3, r1, #12
c0d034b2:	1ac0      	subs	r0, r0, r3
c0d034b4:	4152      	adcs	r2, r2
c0d034b6:	0ac3      	lsrs	r3, r0, #11
c0d034b8:	428b      	cmp	r3, r1
c0d034ba:	d301      	bcc.n	c0d034c0 <__aeabi_idiv+0x7c>
c0d034bc:	02cb      	lsls	r3, r1, #11
c0d034be:	1ac0      	subs	r0, r0, r3
c0d034c0:	4152      	adcs	r2, r2
c0d034c2:	0a83      	lsrs	r3, r0, #10
c0d034c4:	428b      	cmp	r3, r1
c0d034c6:	d301      	bcc.n	c0d034cc <__aeabi_idiv+0x88>
c0d034c8:	028b      	lsls	r3, r1, #10
c0d034ca:	1ac0      	subs	r0, r0, r3
c0d034cc:	4152      	adcs	r2, r2
c0d034ce:	0a43      	lsrs	r3, r0, #9
c0d034d0:	428b      	cmp	r3, r1
c0d034d2:	d301      	bcc.n	c0d034d8 <__aeabi_idiv+0x94>
c0d034d4:	024b      	lsls	r3, r1, #9
c0d034d6:	1ac0      	subs	r0, r0, r3
c0d034d8:	4152      	adcs	r2, r2
c0d034da:	0a03      	lsrs	r3, r0, #8
c0d034dc:	428b      	cmp	r3, r1
c0d034de:	d301      	bcc.n	c0d034e4 <__aeabi_idiv+0xa0>
c0d034e0:	020b      	lsls	r3, r1, #8
c0d034e2:	1ac0      	subs	r0, r0, r3
c0d034e4:	4152      	adcs	r2, r2
c0d034e6:	d2cd      	bcs.n	c0d03484 <__aeabi_idiv+0x40>
c0d034e8:	09c3      	lsrs	r3, r0, #7
c0d034ea:	428b      	cmp	r3, r1
c0d034ec:	d301      	bcc.n	c0d034f2 <__aeabi_idiv+0xae>
c0d034ee:	01cb      	lsls	r3, r1, #7
c0d034f0:	1ac0      	subs	r0, r0, r3
c0d034f2:	4152      	adcs	r2, r2
c0d034f4:	0983      	lsrs	r3, r0, #6
c0d034f6:	428b      	cmp	r3, r1
c0d034f8:	d301      	bcc.n	c0d034fe <__aeabi_idiv+0xba>
c0d034fa:	018b      	lsls	r3, r1, #6
c0d034fc:	1ac0      	subs	r0, r0, r3
c0d034fe:	4152      	adcs	r2, r2
c0d03500:	0943      	lsrs	r3, r0, #5
c0d03502:	428b      	cmp	r3, r1
c0d03504:	d301      	bcc.n	c0d0350a <__aeabi_idiv+0xc6>
c0d03506:	014b      	lsls	r3, r1, #5
c0d03508:	1ac0      	subs	r0, r0, r3
c0d0350a:	4152      	adcs	r2, r2
c0d0350c:	0903      	lsrs	r3, r0, #4
c0d0350e:	428b      	cmp	r3, r1
c0d03510:	d301      	bcc.n	c0d03516 <__aeabi_idiv+0xd2>
c0d03512:	010b      	lsls	r3, r1, #4
c0d03514:	1ac0      	subs	r0, r0, r3
c0d03516:	4152      	adcs	r2, r2
c0d03518:	08c3      	lsrs	r3, r0, #3
c0d0351a:	428b      	cmp	r3, r1
c0d0351c:	d301      	bcc.n	c0d03522 <__aeabi_idiv+0xde>
c0d0351e:	00cb      	lsls	r3, r1, #3
c0d03520:	1ac0      	subs	r0, r0, r3
c0d03522:	4152      	adcs	r2, r2
c0d03524:	0883      	lsrs	r3, r0, #2
c0d03526:	428b      	cmp	r3, r1
c0d03528:	d301      	bcc.n	c0d0352e <__aeabi_idiv+0xea>
c0d0352a:	008b      	lsls	r3, r1, #2
c0d0352c:	1ac0      	subs	r0, r0, r3
c0d0352e:	4152      	adcs	r2, r2
c0d03530:	0843      	lsrs	r3, r0, #1
c0d03532:	428b      	cmp	r3, r1
c0d03534:	d301      	bcc.n	c0d0353a <__aeabi_idiv+0xf6>
c0d03536:	004b      	lsls	r3, r1, #1
c0d03538:	1ac0      	subs	r0, r0, r3
c0d0353a:	4152      	adcs	r2, r2
c0d0353c:	1a41      	subs	r1, r0, r1
c0d0353e:	d200      	bcs.n	c0d03542 <__aeabi_idiv+0xfe>
c0d03540:	4601      	mov	r1, r0
c0d03542:	4152      	adcs	r2, r2
c0d03544:	4610      	mov	r0, r2
c0d03546:	4770      	bx	lr
c0d03548:	e05d      	b.n	c0d03606 <__aeabi_idiv+0x1c2>
c0d0354a:	0fca      	lsrs	r2, r1, #31
c0d0354c:	d000      	beq.n	c0d03550 <__aeabi_idiv+0x10c>
c0d0354e:	4249      	negs	r1, r1
c0d03550:	1003      	asrs	r3, r0, #32
c0d03552:	d300      	bcc.n	c0d03556 <__aeabi_idiv+0x112>
c0d03554:	4240      	negs	r0, r0
c0d03556:	4053      	eors	r3, r2
c0d03558:	2200      	movs	r2, #0
c0d0355a:	469c      	mov	ip, r3
c0d0355c:	0903      	lsrs	r3, r0, #4
c0d0355e:	428b      	cmp	r3, r1
c0d03560:	d32d      	bcc.n	c0d035be <__aeabi_idiv+0x17a>
c0d03562:	0a03      	lsrs	r3, r0, #8
c0d03564:	428b      	cmp	r3, r1
c0d03566:	d312      	bcc.n	c0d0358e <__aeabi_idiv+0x14a>
c0d03568:	22fc      	movs	r2, #252	; 0xfc
c0d0356a:	0189      	lsls	r1, r1, #6
c0d0356c:	ba12      	rev	r2, r2
c0d0356e:	0a03      	lsrs	r3, r0, #8
c0d03570:	428b      	cmp	r3, r1
c0d03572:	d30c      	bcc.n	c0d0358e <__aeabi_idiv+0x14a>
c0d03574:	0189      	lsls	r1, r1, #6
c0d03576:	1192      	asrs	r2, r2, #6
c0d03578:	428b      	cmp	r3, r1
c0d0357a:	d308      	bcc.n	c0d0358e <__aeabi_idiv+0x14a>
c0d0357c:	0189      	lsls	r1, r1, #6
c0d0357e:	1192      	asrs	r2, r2, #6
c0d03580:	428b      	cmp	r3, r1
c0d03582:	d304      	bcc.n	c0d0358e <__aeabi_idiv+0x14a>
c0d03584:	0189      	lsls	r1, r1, #6
c0d03586:	d03a      	beq.n	c0d035fe <__aeabi_idiv+0x1ba>
c0d03588:	1192      	asrs	r2, r2, #6
c0d0358a:	e000      	b.n	c0d0358e <__aeabi_idiv+0x14a>
c0d0358c:	0989      	lsrs	r1, r1, #6
c0d0358e:	09c3      	lsrs	r3, r0, #7
c0d03590:	428b      	cmp	r3, r1
c0d03592:	d301      	bcc.n	c0d03598 <__aeabi_idiv+0x154>
c0d03594:	01cb      	lsls	r3, r1, #7
c0d03596:	1ac0      	subs	r0, r0, r3
c0d03598:	4152      	adcs	r2, r2
c0d0359a:	0983      	lsrs	r3, r0, #6
c0d0359c:	428b      	cmp	r3, r1
c0d0359e:	d301      	bcc.n	c0d035a4 <__aeabi_idiv+0x160>
c0d035a0:	018b      	lsls	r3, r1, #6
c0d035a2:	1ac0      	subs	r0, r0, r3
c0d035a4:	4152      	adcs	r2, r2
c0d035a6:	0943      	lsrs	r3, r0, #5
c0d035a8:	428b      	cmp	r3, r1
c0d035aa:	d301      	bcc.n	c0d035b0 <__aeabi_idiv+0x16c>
c0d035ac:	014b      	lsls	r3, r1, #5
c0d035ae:	1ac0      	subs	r0, r0, r3
c0d035b0:	4152      	adcs	r2, r2
c0d035b2:	0903      	lsrs	r3, r0, #4
c0d035b4:	428b      	cmp	r3, r1
c0d035b6:	d301      	bcc.n	c0d035bc <__aeabi_idiv+0x178>
c0d035b8:	010b      	lsls	r3, r1, #4
c0d035ba:	1ac0      	subs	r0, r0, r3
c0d035bc:	4152      	adcs	r2, r2
c0d035be:	08c3      	lsrs	r3, r0, #3
c0d035c0:	428b      	cmp	r3, r1
c0d035c2:	d301      	bcc.n	c0d035c8 <__aeabi_idiv+0x184>
c0d035c4:	00cb      	lsls	r3, r1, #3
c0d035c6:	1ac0      	subs	r0, r0, r3
c0d035c8:	4152      	adcs	r2, r2
c0d035ca:	0883      	lsrs	r3, r0, #2
c0d035cc:	428b      	cmp	r3, r1
c0d035ce:	d301      	bcc.n	c0d035d4 <__aeabi_idiv+0x190>
c0d035d0:	008b      	lsls	r3, r1, #2
c0d035d2:	1ac0      	subs	r0, r0, r3
c0d035d4:	4152      	adcs	r2, r2
c0d035d6:	d2d9      	bcs.n	c0d0358c <__aeabi_idiv+0x148>
c0d035d8:	0843      	lsrs	r3, r0, #1
c0d035da:	428b      	cmp	r3, r1
c0d035dc:	d301      	bcc.n	c0d035e2 <__aeabi_idiv+0x19e>
c0d035de:	004b      	lsls	r3, r1, #1
c0d035e0:	1ac0      	subs	r0, r0, r3
c0d035e2:	4152      	adcs	r2, r2
c0d035e4:	1a41      	subs	r1, r0, r1
c0d035e6:	d200      	bcs.n	c0d035ea <__aeabi_idiv+0x1a6>
c0d035e8:	4601      	mov	r1, r0
c0d035ea:	4663      	mov	r3, ip
c0d035ec:	4152      	adcs	r2, r2
c0d035ee:	105b      	asrs	r3, r3, #1
c0d035f0:	4610      	mov	r0, r2
c0d035f2:	d301      	bcc.n	c0d035f8 <__aeabi_idiv+0x1b4>
c0d035f4:	4240      	negs	r0, r0
c0d035f6:	2b00      	cmp	r3, #0
c0d035f8:	d500      	bpl.n	c0d035fc <__aeabi_idiv+0x1b8>
c0d035fa:	4249      	negs	r1, r1
c0d035fc:	4770      	bx	lr
c0d035fe:	4663      	mov	r3, ip
c0d03600:	105b      	asrs	r3, r3, #1
c0d03602:	d300      	bcc.n	c0d03606 <__aeabi_idiv+0x1c2>
c0d03604:	4240      	negs	r0, r0
c0d03606:	b501      	push	{r0, lr}
c0d03608:	2000      	movs	r0, #0
c0d0360a:	f000 f805 	bl	c0d03618 <__aeabi_idiv0>
c0d0360e:	bd02      	pop	{r1, pc}

c0d03610 <__aeabi_idivmod>:
c0d03610:	2900      	cmp	r1, #0
c0d03612:	d0f8      	beq.n	c0d03606 <__aeabi_idiv+0x1c2>
c0d03614:	e716      	b.n	c0d03444 <__aeabi_idiv>
c0d03616:	4770      	bx	lr

c0d03618 <__aeabi_idiv0>:
c0d03618:	4770      	bx	lr
c0d0361a:	46c0      	nop			; (mov r8, r8)

c0d0361c <__aeabi_uldivmod>:
c0d0361c:	2b00      	cmp	r3, #0
c0d0361e:	d111      	bne.n	c0d03644 <__aeabi_uldivmod+0x28>
c0d03620:	2a00      	cmp	r2, #0
c0d03622:	d10f      	bne.n	c0d03644 <__aeabi_uldivmod+0x28>
c0d03624:	2900      	cmp	r1, #0
c0d03626:	d100      	bne.n	c0d0362a <__aeabi_uldivmod+0xe>
c0d03628:	2800      	cmp	r0, #0
c0d0362a:	d002      	beq.n	c0d03632 <__aeabi_uldivmod+0x16>
c0d0362c:	2100      	movs	r1, #0
c0d0362e:	43c9      	mvns	r1, r1
c0d03630:	1c08      	adds	r0, r1, #0
c0d03632:	b407      	push	{r0, r1, r2}
c0d03634:	4802      	ldr	r0, [pc, #8]	; (c0d03640 <__aeabi_uldivmod+0x24>)
c0d03636:	a102      	add	r1, pc, #8	; (adr r1, c0d03640 <__aeabi_uldivmod+0x24>)
c0d03638:	1840      	adds	r0, r0, r1
c0d0363a:	9002      	str	r0, [sp, #8]
c0d0363c:	bd03      	pop	{r0, r1, pc}
c0d0363e:	46c0      	nop			; (mov r8, r8)
c0d03640:	ffffffd9 	.word	0xffffffd9
c0d03644:	b403      	push	{r0, r1}
c0d03646:	4668      	mov	r0, sp
c0d03648:	b501      	push	{r0, lr}
c0d0364a:	9802      	ldr	r0, [sp, #8]
c0d0364c:	f000 f806 	bl	c0d0365c <__udivmoddi4>
c0d03650:	9b01      	ldr	r3, [sp, #4]
c0d03652:	469e      	mov	lr, r3
c0d03654:	b002      	add	sp, #8
c0d03656:	bc0c      	pop	{r2, r3}
c0d03658:	4770      	bx	lr
c0d0365a:	46c0      	nop			; (mov r8, r8)

c0d0365c <__udivmoddi4>:
c0d0365c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0365e:	464d      	mov	r5, r9
c0d03660:	4656      	mov	r6, sl
c0d03662:	4644      	mov	r4, r8
c0d03664:	465f      	mov	r7, fp
c0d03666:	b4f0      	push	{r4, r5, r6, r7}
c0d03668:	4692      	mov	sl, r2
c0d0366a:	b083      	sub	sp, #12
c0d0366c:	0004      	movs	r4, r0
c0d0366e:	000d      	movs	r5, r1
c0d03670:	4699      	mov	r9, r3
c0d03672:	428b      	cmp	r3, r1
c0d03674:	d82f      	bhi.n	c0d036d6 <__udivmoddi4+0x7a>
c0d03676:	d02c      	beq.n	c0d036d2 <__udivmoddi4+0x76>
c0d03678:	4649      	mov	r1, r9
c0d0367a:	4650      	mov	r0, sl
c0d0367c:	f000 f8ae 	bl	c0d037dc <__clzdi2>
c0d03680:	0029      	movs	r1, r5
c0d03682:	0006      	movs	r6, r0
c0d03684:	0020      	movs	r0, r4
c0d03686:	f000 f8a9 	bl	c0d037dc <__clzdi2>
c0d0368a:	1a33      	subs	r3, r6, r0
c0d0368c:	4698      	mov	r8, r3
c0d0368e:	3b20      	subs	r3, #32
c0d03690:	469b      	mov	fp, r3
c0d03692:	d500      	bpl.n	c0d03696 <__udivmoddi4+0x3a>
c0d03694:	e074      	b.n	c0d03780 <__udivmoddi4+0x124>
c0d03696:	4653      	mov	r3, sl
c0d03698:	465a      	mov	r2, fp
c0d0369a:	4093      	lsls	r3, r2
c0d0369c:	001f      	movs	r7, r3
c0d0369e:	4653      	mov	r3, sl
c0d036a0:	4642      	mov	r2, r8
c0d036a2:	4093      	lsls	r3, r2
c0d036a4:	001e      	movs	r6, r3
c0d036a6:	42af      	cmp	r7, r5
c0d036a8:	d829      	bhi.n	c0d036fe <__udivmoddi4+0xa2>
c0d036aa:	d026      	beq.n	c0d036fa <__udivmoddi4+0x9e>
c0d036ac:	465b      	mov	r3, fp
c0d036ae:	1ba4      	subs	r4, r4, r6
c0d036b0:	41bd      	sbcs	r5, r7
c0d036b2:	2b00      	cmp	r3, #0
c0d036b4:	da00      	bge.n	c0d036b8 <__udivmoddi4+0x5c>
c0d036b6:	e079      	b.n	c0d037ac <__udivmoddi4+0x150>
c0d036b8:	2200      	movs	r2, #0
c0d036ba:	2300      	movs	r3, #0
c0d036bc:	9200      	str	r2, [sp, #0]
c0d036be:	9301      	str	r3, [sp, #4]
c0d036c0:	2301      	movs	r3, #1
c0d036c2:	465a      	mov	r2, fp
c0d036c4:	4093      	lsls	r3, r2
c0d036c6:	9301      	str	r3, [sp, #4]
c0d036c8:	2301      	movs	r3, #1
c0d036ca:	4642      	mov	r2, r8
c0d036cc:	4093      	lsls	r3, r2
c0d036ce:	9300      	str	r3, [sp, #0]
c0d036d0:	e019      	b.n	c0d03706 <__udivmoddi4+0xaa>
c0d036d2:	4282      	cmp	r2, r0
c0d036d4:	d9d0      	bls.n	c0d03678 <__udivmoddi4+0x1c>
c0d036d6:	2200      	movs	r2, #0
c0d036d8:	2300      	movs	r3, #0
c0d036da:	9200      	str	r2, [sp, #0]
c0d036dc:	9301      	str	r3, [sp, #4]
c0d036de:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d036e0:	2b00      	cmp	r3, #0
c0d036e2:	d001      	beq.n	c0d036e8 <__udivmoddi4+0x8c>
c0d036e4:	601c      	str	r4, [r3, #0]
c0d036e6:	605d      	str	r5, [r3, #4]
c0d036e8:	9800      	ldr	r0, [sp, #0]
c0d036ea:	9901      	ldr	r1, [sp, #4]
c0d036ec:	b003      	add	sp, #12
c0d036ee:	bc3c      	pop	{r2, r3, r4, r5}
c0d036f0:	4690      	mov	r8, r2
c0d036f2:	4699      	mov	r9, r3
c0d036f4:	46a2      	mov	sl, r4
c0d036f6:	46ab      	mov	fp, r5
c0d036f8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d036fa:	42a3      	cmp	r3, r4
c0d036fc:	d9d6      	bls.n	c0d036ac <__udivmoddi4+0x50>
c0d036fe:	2200      	movs	r2, #0
c0d03700:	2300      	movs	r3, #0
c0d03702:	9200      	str	r2, [sp, #0]
c0d03704:	9301      	str	r3, [sp, #4]
c0d03706:	4643      	mov	r3, r8
c0d03708:	2b00      	cmp	r3, #0
c0d0370a:	d0e8      	beq.n	c0d036de <__udivmoddi4+0x82>
c0d0370c:	07fb      	lsls	r3, r7, #31
c0d0370e:	0872      	lsrs	r2, r6, #1
c0d03710:	431a      	orrs	r2, r3
c0d03712:	4646      	mov	r6, r8
c0d03714:	087b      	lsrs	r3, r7, #1
c0d03716:	e00e      	b.n	c0d03736 <__udivmoddi4+0xda>
c0d03718:	42ab      	cmp	r3, r5
c0d0371a:	d101      	bne.n	c0d03720 <__udivmoddi4+0xc4>
c0d0371c:	42a2      	cmp	r2, r4
c0d0371e:	d80c      	bhi.n	c0d0373a <__udivmoddi4+0xde>
c0d03720:	1aa4      	subs	r4, r4, r2
c0d03722:	419d      	sbcs	r5, r3
c0d03724:	2001      	movs	r0, #1
c0d03726:	1924      	adds	r4, r4, r4
c0d03728:	416d      	adcs	r5, r5
c0d0372a:	2100      	movs	r1, #0
c0d0372c:	3e01      	subs	r6, #1
c0d0372e:	1824      	adds	r4, r4, r0
c0d03730:	414d      	adcs	r5, r1
c0d03732:	2e00      	cmp	r6, #0
c0d03734:	d006      	beq.n	c0d03744 <__udivmoddi4+0xe8>
c0d03736:	42ab      	cmp	r3, r5
c0d03738:	d9ee      	bls.n	c0d03718 <__udivmoddi4+0xbc>
c0d0373a:	3e01      	subs	r6, #1
c0d0373c:	1924      	adds	r4, r4, r4
c0d0373e:	416d      	adcs	r5, r5
c0d03740:	2e00      	cmp	r6, #0
c0d03742:	d1f8      	bne.n	c0d03736 <__udivmoddi4+0xda>
c0d03744:	465b      	mov	r3, fp
c0d03746:	9800      	ldr	r0, [sp, #0]
c0d03748:	9901      	ldr	r1, [sp, #4]
c0d0374a:	1900      	adds	r0, r0, r4
c0d0374c:	4169      	adcs	r1, r5
c0d0374e:	2b00      	cmp	r3, #0
c0d03750:	db22      	blt.n	c0d03798 <__udivmoddi4+0x13c>
c0d03752:	002b      	movs	r3, r5
c0d03754:	465a      	mov	r2, fp
c0d03756:	40d3      	lsrs	r3, r2
c0d03758:	002a      	movs	r2, r5
c0d0375a:	4644      	mov	r4, r8
c0d0375c:	40e2      	lsrs	r2, r4
c0d0375e:	001c      	movs	r4, r3
c0d03760:	465b      	mov	r3, fp
c0d03762:	0015      	movs	r5, r2
c0d03764:	2b00      	cmp	r3, #0
c0d03766:	db2c      	blt.n	c0d037c2 <__udivmoddi4+0x166>
c0d03768:	0026      	movs	r6, r4
c0d0376a:	409e      	lsls	r6, r3
c0d0376c:	0033      	movs	r3, r6
c0d0376e:	0026      	movs	r6, r4
c0d03770:	4647      	mov	r7, r8
c0d03772:	40be      	lsls	r6, r7
c0d03774:	0032      	movs	r2, r6
c0d03776:	1a80      	subs	r0, r0, r2
c0d03778:	4199      	sbcs	r1, r3
c0d0377a:	9000      	str	r0, [sp, #0]
c0d0377c:	9101      	str	r1, [sp, #4]
c0d0377e:	e7ae      	b.n	c0d036de <__udivmoddi4+0x82>
c0d03780:	4642      	mov	r2, r8
c0d03782:	2320      	movs	r3, #32
c0d03784:	1a9b      	subs	r3, r3, r2
c0d03786:	4652      	mov	r2, sl
c0d03788:	40da      	lsrs	r2, r3
c0d0378a:	4641      	mov	r1, r8
c0d0378c:	0013      	movs	r3, r2
c0d0378e:	464a      	mov	r2, r9
c0d03790:	408a      	lsls	r2, r1
c0d03792:	0017      	movs	r7, r2
c0d03794:	431f      	orrs	r7, r3
c0d03796:	e782      	b.n	c0d0369e <__udivmoddi4+0x42>
c0d03798:	4642      	mov	r2, r8
c0d0379a:	2320      	movs	r3, #32
c0d0379c:	1a9b      	subs	r3, r3, r2
c0d0379e:	002a      	movs	r2, r5
c0d037a0:	4646      	mov	r6, r8
c0d037a2:	409a      	lsls	r2, r3
c0d037a4:	0023      	movs	r3, r4
c0d037a6:	40f3      	lsrs	r3, r6
c0d037a8:	4313      	orrs	r3, r2
c0d037aa:	e7d5      	b.n	c0d03758 <__udivmoddi4+0xfc>
c0d037ac:	4642      	mov	r2, r8
c0d037ae:	2320      	movs	r3, #32
c0d037b0:	2100      	movs	r1, #0
c0d037b2:	1a9b      	subs	r3, r3, r2
c0d037b4:	2200      	movs	r2, #0
c0d037b6:	9100      	str	r1, [sp, #0]
c0d037b8:	9201      	str	r2, [sp, #4]
c0d037ba:	2201      	movs	r2, #1
c0d037bc:	40da      	lsrs	r2, r3
c0d037be:	9201      	str	r2, [sp, #4]
c0d037c0:	e782      	b.n	c0d036c8 <__udivmoddi4+0x6c>
c0d037c2:	4642      	mov	r2, r8
c0d037c4:	2320      	movs	r3, #32
c0d037c6:	0026      	movs	r6, r4
c0d037c8:	1a9b      	subs	r3, r3, r2
c0d037ca:	40de      	lsrs	r6, r3
c0d037cc:	002f      	movs	r7, r5
c0d037ce:	46b4      	mov	ip, r6
c0d037d0:	4097      	lsls	r7, r2
c0d037d2:	4666      	mov	r6, ip
c0d037d4:	003b      	movs	r3, r7
c0d037d6:	4333      	orrs	r3, r6
c0d037d8:	e7c9      	b.n	c0d0376e <__udivmoddi4+0x112>
c0d037da:	46c0      	nop			; (mov r8, r8)

c0d037dc <__clzdi2>:
c0d037dc:	b510      	push	{r4, lr}
c0d037de:	2900      	cmp	r1, #0
c0d037e0:	d103      	bne.n	c0d037ea <__clzdi2+0xe>
c0d037e2:	f000 f807 	bl	c0d037f4 <__clzsi2>
c0d037e6:	3020      	adds	r0, #32
c0d037e8:	e002      	b.n	c0d037f0 <__clzdi2+0x14>
c0d037ea:	1c08      	adds	r0, r1, #0
c0d037ec:	f000 f802 	bl	c0d037f4 <__clzsi2>
c0d037f0:	bd10      	pop	{r4, pc}
c0d037f2:	46c0      	nop			; (mov r8, r8)

c0d037f4 <__clzsi2>:
c0d037f4:	211c      	movs	r1, #28
c0d037f6:	2301      	movs	r3, #1
c0d037f8:	041b      	lsls	r3, r3, #16
c0d037fa:	4298      	cmp	r0, r3
c0d037fc:	d301      	bcc.n	c0d03802 <__clzsi2+0xe>
c0d037fe:	0c00      	lsrs	r0, r0, #16
c0d03800:	3910      	subs	r1, #16
c0d03802:	0a1b      	lsrs	r3, r3, #8
c0d03804:	4298      	cmp	r0, r3
c0d03806:	d301      	bcc.n	c0d0380c <__clzsi2+0x18>
c0d03808:	0a00      	lsrs	r0, r0, #8
c0d0380a:	3908      	subs	r1, #8
c0d0380c:	091b      	lsrs	r3, r3, #4
c0d0380e:	4298      	cmp	r0, r3
c0d03810:	d301      	bcc.n	c0d03816 <__clzsi2+0x22>
c0d03812:	0900      	lsrs	r0, r0, #4
c0d03814:	3904      	subs	r1, #4
c0d03816:	a202      	add	r2, pc, #8	; (adr r2, c0d03820 <__clzsi2+0x2c>)
c0d03818:	5c10      	ldrb	r0, [r2, r0]
c0d0381a:	1840      	adds	r0, r0, r1
c0d0381c:	4770      	bx	lr
c0d0381e:	46c0      	nop			; (mov r8, r8)
c0d03820:	02020304 	.word	0x02020304
c0d03824:	01010101 	.word	0x01010101
	...

c0d03830 <__aeabi_memclr>:
c0d03830:	b510      	push	{r4, lr}
c0d03832:	2200      	movs	r2, #0
c0d03834:	f000 f806 	bl	c0d03844 <__aeabi_memset>
c0d03838:	bd10      	pop	{r4, pc}
c0d0383a:	46c0      	nop			; (mov r8, r8)

c0d0383c <__aeabi_memcpy>:
c0d0383c:	b510      	push	{r4, lr}
c0d0383e:	f000 f809 	bl	c0d03854 <memcpy>
c0d03842:	bd10      	pop	{r4, pc}

c0d03844 <__aeabi_memset>:
c0d03844:	0013      	movs	r3, r2
c0d03846:	b510      	push	{r4, lr}
c0d03848:	000a      	movs	r2, r1
c0d0384a:	0019      	movs	r1, r3
c0d0384c:	f000 f840 	bl	c0d038d0 <memset>
c0d03850:	bd10      	pop	{r4, pc}
c0d03852:	46c0      	nop			; (mov r8, r8)

c0d03854 <memcpy>:
c0d03854:	b570      	push	{r4, r5, r6, lr}
c0d03856:	2a0f      	cmp	r2, #15
c0d03858:	d932      	bls.n	c0d038c0 <memcpy+0x6c>
c0d0385a:	000c      	movs	r4, r1
c0d0385c:	4304      	orrs	r4, r0
c0d0385e:	000b      	movs	r3, r1
c0d03860:	07a4      	lsls	r4, r4, #30
c0d03862:	d131      	bne.n	c0d038c8 <memcpy+0x74>
c0d03864:	0015      	movs	r5, r2
c0d03866:	0004      	movs	r4, r0
c0d03868:	3d10      	subs	r5, #16
c0d0386a:	092d      	lsrs	r5, r5, #4
c0d0386c:	3501      	adds	r5, #1
c0d0386e:	012d      	lsls	r5, r5, #4
c0d03870:	1949      	adds	r1, r1, r5
c0d03872:	681e      	ldr	r6, [r3, #0]
c0d03874:	6026      	str	r6, [r4, #0]
c0d03876:	685e      	ldr	r6, [r3, #4]
c0d03878:	6066      	str	r6, [r4, #4]
c0d0387a:	689e      	ldr	r6, [r3, #8]
c0d0387c:	60a6      	str	r6, [r4, #8]
c0d0387e:	68de      	ldr	r6, [r3, #12]
c0d03880:	3310      	adds	r3, #16
c0d03882:	60e6      	str	r6, [r4, #12]
c0d03884:	3410      	adds	r4, #16
c0d03886:	4299      	cmp	r1, r3
c0d03888:	d1f3      	bne.n	c0d03872 <memcpy+0x1e>
c0d0388a:	230f      	movs	r3, #15
c0d0388c:	1945      	adds	r5, r0, r5
c0d0388e:	4013      	ands	r3, r2
c0d03890:	2b03      	cmp	r3, #3
c0d03892:	d91b      	bls.n	c0d038cc <memcpy+0x78>
c0d03894:	1f1c      	subs	r4, r3, #4
c0d03896:	2300      	movs	r3, #0
c0d03898:	08a4      	lsrs	r4, r4, #2
c0d0389a:	3401      	adds	r4, #1
c0d0389c:	00a4      	lsls	r4, r4, #2
c0d0389e:	58ce      	ldr	r6, [r1, r3]
c0d038a0:	50ee      	str	r6, [r5, r3]
c0d038a2:	3304      	adds	r3, #4
c0d038a4:	429c      	cmp	r4, r3
c0d038a6:	d1fa      	bne.n	c0d0389e <memcpy+0x4a>
c0d038a8:	2303      	movs	r3, #3
c0d038aa:	192d      	adds	r5, r5, r4
c0d038ac:	1909      	adds	r1, r1, r4
c0d038ae:	401a      	ands	r2, r3
c0d038b0:	d005      	beq.n	c0d038be <memcpy+0x6a>
c0d038b2:	2300      	movs	r3, #0
c0d038b4:	5ccc      	ldrb	r4, [r1, r3]
c0d038b6:	54ec      	strb	r4, [r5, r3]
c0d038b8:	3301      	adds	r3, #1
c0d038ba:	429a      	cmp	r2, r3
c0d038bc:	d1fa      	bne.n	c0d038b4 <memcpy+0x60>
c0d038be:	bd70      	pop	{r4, r5, r6, pc}
c0d038c0:	0005      	movs	r5, r0
c0d038c2:	2a00      	cmp	r2, #0
c0d038c4:	d1f5      	bne.n	c0d038b2 <memcpy+0x5e>
c0d038c6:	e7fa      	b.n	c0d038be <memcpy+0x6a>
c0d038c8:	0005      	movs	r5, r0
c0d038ca:	e7f2      	b.n	c0d038b2 <memcpy+0x5e>
c0d038cc:	001a      	movs	r2, r3
c0d038ce:	e7f8      	b.n	c0d038c2 <memcpy+0x6e>

c0d038d0 <memset>:
c0d038d0:	b570      	push	{r4, r5, r6, lr}
c0d038d2:	0783      	lsls	r3, r0, #30
c0d038d4:	d03f      	beq.n	c0d03956 <memset+0x86>
c0d038d6:	1e54      	subs	r4, r2, #1
c0d038d8:	2a00      	cmp	r2, #0
c0d038da:	d03b      	beq.n	c0d03954 <memset+0x84>
c0d038dc:	b2ce      	uxtb	r6, r1
c0d038de:	0003      	movs	r3, r0
c0d038e0:	2503      	movs	r5, #3
c0d038e2:	e003      	b.n	c0d038ec <memset+0x1c>
c0d038e4:	1e62      	subs	r2, r4, #1
c0d038e6:	2c00      	cmp	r4, #0
c0d038e8:	d034      	beq.n	c0d03954 <memset+0x84>
c0d038ea:	0014      	movs	r4, r2
c0d038ec:	3301      	adds	r3, #1
c0d038ee:	1e5a      	subs	r2, r3, #1
c0d038f0:	7016      	strb	r6, [r2, #0]
c0d038f2:	422b      	tst	r3, r5
c0d038f4:	d1f6      	bne.n	c0d038e4 <memset+0x14>
c0d038f6:	2c03      	cmp	r4, #3
c0d038f8:	d924      	bls.n	c0d03944 <memset+0x74>
c0d038fa:	25ff      	movs	r5, #255	; 0xff
c0d038fc:	400d      	ands	r5, r1
c0d038fe:	022a      	lsls	r2, r5, #8
c0d03900:	4315      	orrs	r5, r2
c0d03902:	042a      	lsls	r2, r5, #16
c0d03904:	4315      	orrs	r5, r2
c0d03906:	2c0f      	cmp	r4, #15
c0d03908:	d911      	bls.n	c0d0392e <memset+0x5e>
c0d0390a:	0026      	movs	r6, r4
c0d0390c:	3e10      	subs	r6, #16
c0d0390e:	0936      	lsrs	r6, r6, #4
c0d03910:	3601      	adds	r6, #1
c0d03912:	0136      	lsls	r6, r6, #4
c0d03914:	001a      	movs	r2, r3
c0d03916:	199b      	adds	r3, r3, r6
c0d03918:	6015      	str	r5, [r2, #0]
c0d0391a:	6055      	str	r5, [r2, #4]
c0d0391c:	6095      	str	r5, [r2, #8]
c0d0391e:	60d5      	str	r5, [r2, #12]
c0d03920:	3210      	adds	r2, #16
c0d03922:	4293      	cmp	r3, r2
c0d03924:	d1f8      	bne.n	c0d03918 <memset+0x48>
c0d03926:	220f      	movs	r2, #15
c0d03928:	4014      	ands	r4, r2
c0d0392a:	2c03      	cmp	r4, #3
c0d0392c:	d90a      	bls.n	c0d03944 <memset+0x74>
c0d0392e:	1f26      	subs	r6, r4, #4
c0d03930:	08b6      	lsrs	r6, r6, #2
c0d03932:	3601      	adds	r6, #1
c0d03934:	00b6      	lsls	r6, r6, #2
c0d03936:	001a      	movs	r2, r3
c0d03938:	199b      	adds	r3, r3, r6
c0d0393a:	c220      	stmia	r2!, {r5}
c0d0393c:	4293      	cmp	r3, r2
c0d0393e:	d1fc      	bne.n	c0d0393a <memset+0x6a>
c0d03940:	2203      	movs	r2, #3
c0d03942:	4014      	ands	r4, r2
c0d03944:	2c00      	cmp	r4, #0
c0d03946:	d005      	beq.n	c0d03954 <memset+0x84>
c0d03948:	b2c9      	uxtb	r1, r1
c0d0394a:	191c      	adds	r4, r3, r4
c0d0394c:	7019      	strb	r1, [r3, #0]
c0d0394e:	3301      	adds	r3, #1
c0d03950:	429c      	cmp	r4, r3
c0d03952:	d1fb      	bne.n	c0d0394c <memset+0x7c>
c0d03954:	bd70      	pop	{r4, r5, r6, pc}
c0d03956:	0014      	movs	r4, r2
c0d03958:	0003      	movs	r3, r0
c0d0395a:	e7cc      	b.n	c0d038f6 <memset+0x26>

c0d0395c <setjmp>:
c0d0395c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0395e:	4641      	mov	r1, r8
c0d03960:	464a      	mov	r2, r9
c0d03962:	4653      	mov	r3, sl
c0d03964:	465c      	mov	r4, fp
c0d03966:	466d      	mov	r5, sp
c0d03968:	4676      	mov	r6, lr
c0d0396a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d0396c:	3828      	subs	r0, #40	; 0x28
c0d0396e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03970:	2000      	movs	r0, #0
c0d03972:	4770      	bx	lr

c0d03974 <longjmp>:
c0d03974:	3010      	adds	r0, #16
c0d03976:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d03978:	4690      	mov	r8, r2
c0d0397a:	4699      	mov	r9, r3
c0d0397c:	46a2      	mov	sl, r4
c0d0397e:	46ab      	mov	fp, r5
c0d03980:	46b5      	mov	sp, r6
c0d03982:	c808      	ldmia	r0!, {r3}
c0d03984:	3828      	subs	r0, #40	; 0x28
c0d03986:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d03988:	1c08      	adds	r0, r1, #0
c0d0398a:	d100      	bne.n	c0d0398e <longjmp+0x1a>
c0d0398c:	2001      	movs	r0, #1
c0d0398e:	4718      	bx	r3

c0d03990 <strlen>:
c0d03990:	b510      	push	{r4, lr}
c0d03992:	0783      	lsls	r3, r0, #30
c0d03994:	d027      	beq.n	c0d039e6 <strlen+0x56>
c0d03996:	7803      	ldrb	r3, [r0, #0]
c0d03998:	2b00      	cmp	r3, #0
c0d0399a:	d026      	beq.n	c0d039ea <strlen+0x5a>
c0d0399c:	0003      	movs	r3, r0
c0d0399e:	2103      	movs	r1, #3
c0d039a0:	e002      	b.n	c0d039a8 <strlen+0x18>
c0d039a2:	781a      	ldrb	r2, [r3, #0]
c0d039a4:	2a00      	cmp	r2, #0
c0d039a6:	d01c      	beq.n	c0d039e2 <strlen+0x52>
c0d039a8:	3301      	adds	r3, #1
c0d039aa:	420b      	tst	r3, r1
c0d039ac:	d1f9      	bne.n	c0d039a2 <strlen+0x12>
c0d039ae:	6819      	ldr	r1, [r3, #0]
c0d039b0:	4a0f      	ldr	r2, [pc, #60]	; (c0d039f0 <strlen+0x60>)
c0d039b2:	4c10      	ldr	r4, [pc, #64]	; (c0d039f4 <strlen+0x64>)
c0d039b4:	188a      	adds	r2, r1, r2
c0d039b6:	438a      	bics	r2, r1
c0d039b8:	4222      	tst	r2, r4
c0d039ba:	d10f      	bne.n	c0d039dc <strlen+0x4c>
c0d039bc:	3304      	adds	r3, #4
c0d039be:	6819      	ldr	r1, [r3, #0]
c0d039c0:	4a0b      	ldr	r2, [pc, #44]	; (c0d039f0 <strlen+0x60>)
c0d039c2:	188a      	adds	r2, r1, r2
c0d039c4:	438a      	bics	r2, r1
c0d039c6:	4222      	tst	r2, r4
c0d039c8:	d108      	bne.n	c0d039dc <strlen+0x4c>
c0d039ca:	3304      	adds	r3, #4
c0d039cc:	6819      	ldr	r1, [r3, #0]
c0d039ce:	4a08      	ldr	r2, [pc, #32]	; (c0d039f0 <strlen+0x60>)
c0d039d0:	188a      	adds	r2, r1, r2
c0d039d2:	438a      	bics	r2, r1
c0d039d4:	4222      	tst	r2, r4
c0d039d6:	d0f1      	beq.n	c0d039bc <strlen+0x2c>
c0d039d8:	e000      	b.n	c0d039dc <strlen+0x4c>
c0d039da:	3301      	adds	r3, #1
c0d039dc:	781a      	ldrb	r2, [r3, #0]
c0d039de:	2a00      	cmp	r2, #0
c0d039e0:	d1fb      	bne.n	c0d039da <strlen+0x4a>
c0d039e2:	1a18      	subs	r0, r3, r0
c0d039e4:	bd10      	pop	{r4, pc}
c0d039e6:	0003      	movs	r3, r0
c0d039e8:	e7e1      	b.n	c0d039ae <strlen+0x1e>
c0d039ea:	2000      	movs	r0, #0
c0d039ec:	e7fa      	b.n	c0d039e4 <strlen+0x54>
c0d039ee:	46c0      	nop			; (mov r8, r8)
c0d039f0:	fefefeff 	.word	0xfefefeff
c0d039f4:	80808080 	.word	0x80808080
c0d039f8:	45544550 	.word	0x45544550
c0d039fc:	54455052 	.word	0x54455052
c0d03a00:	45505245 	.word	0x45505245
c0d03a04:	50524554 	.word	0x50524554
c0d03a08:	52455445 	.word	0x52455445
c0d03a0c:	45544550 	.word	0x45544550
c0d03a10:	54455052 	.word	0x54455052
c0d03a14:	45505245 	.word	0x45505245
c0d03a18:	50524554 	.word	0x50524554
c0d03a1c:	52455445 	.word	0x52455445
c0d03a20:	45544550 	.word	0x45544550
c0d03a24:	54455052 	.word	0x54455052
c0d03a28:	45505245 	.word	0x45505245
c0d03a2c:	50524554 	.word	0x50524554
c0d03a30:	52455445 	.word	0x52455445
c0d03a34:	45544550 	.word	0x45544550
c0d03a38:	54455052 	.word	0x54455052
c0d03a3c:	45505245 	.word	0x45505245
c0d03a40:	50524554 	.word	0x50524554
c0d03a44:	52455445 	.word	0x52455445
c0d03a48:	00000052 	.word	0x00000052

c0d03a4c <trits_mapping>:
c0d03a4c:	00ffffff ff01ffff ff00ffff 01ff0000     ................
c0d03a5c:	01ffff00 ff0100ff ffff0101 ff0000ff     ................
c0d03a6c:	00ff0100 000000ff 00010000 0001ff00     ................
c0d03a7c:	01000100 ffff0001 01ff0001 ff01ff01     ................
c0d03a8c:	00000100 01000101 000101ff 01010101     ................
c0d03a9c:	00000001                                ....

c0d03aa0 <HALF_3>:
c0d03aa0:	f16b9c2d dd01633c 3d8cf0ee b09a028b     -.k.<c.....=....
c0d03ab0:	246cd94a f1c6d805 6cee5506 da330aa3     J.l$.....U.l..3.
c0d03ac0:	fde381a1 fe13f810 f97f039e 1b3dc3ce     ..............=.
c0d03ad0:	00000001                                ....

c0d03ad4 <bagl_ui_nanos_screen1>:
c0d03ad4:	00000003 00800000 00000020 00000001     ........ .......
c0d03ae4:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03b0c:	00000107 0080000c 00000020 00000000     ........ .......
c0d03b1c:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03b44:	00030005 0007000c 00000007 00000000     ................
	...
c0d03b5c:	00070000 00000000 00000000 00000000     ................
	...
c0d03b7c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03b8c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03bb4 <bagl_ui_nanos_screen2>:
c0d03bb4:	00000003 00800000 00000020 00000001     ........ .......
c0d03bc4:	00000000 00ffffff 00000000 00000000     ................
	...
c0d03bec:	00000107 00800012 00000020 00000000     ........ .......
c0d03bfc:	00ffffff 00000000 0000800a 20001800     ............... 
	...
c0d03c24:	00030005 0007000c 00000007 00000000     ................
	...
c0d03c3c:	00070000 00000000 00000000 00000000     ................
	...
c0d03c5c:	00750005 0008000d 00000006 00000000     ..u.............
c0d03c6c:	00ffffff 00000000 00060000 00000000     ................
	...

c0d03c94 <bagl_ui_sample_blue>:
c0d03c94:	00000003 0140003c 000001a4 00000001     ....<.@.........
c0d03ca4:	00f9f9f9 00f9f9f9 00000000 00000000     ................
	...
c0d03ccc:	00000003 01400000 0000003c 00000001     ......@.<.......
c0d03cdc:	001d2028 001d2028 00000000 00000000     ( ..( ..........
	...
c0d03d04:	00140002 01400000 0000003c 00000001     ......@.<.......
c0d03d14:	00ffffff 001d2028 00002004 c0d03d74     ....( ... ..t=..
	...
c0d03d3c:	00a50081 007800e1 06000028 00000001     ......x.(.......
c0d03d4c:	0041ccb4 00f9f9f9 0000a004 c0d03d80     ..A..........=..
c0d03d5c:	00000000 0037ae99 00f9f9f9 c0d02601     ......7......&..
	...
c0d03d74:	6c6c6548 6f57206f 00646c72 54495845     Hello World.EXIT
	...

c0d03d85 <USBD_PRODUCT_FS_STRING>:
c0d03d85:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d03d93 <HID_ReportDesc>:
c0d03d93:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d03da3:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d03db3:	0000c008 11210900                                .....

c0d03db8 <USBD_HID_Desc>:
c0d03db8:	01112109 22220100 00011200                       .!...."".

c0d03dc1 <USBD_DeviceDesc>:
c0d03dc1:	02000112 40000000 00012c97 02010200     .......@.,......
c0d03dd1:	11000103                                         ...

c0d03dd4 <HID_Desc>:
c0d03dd4:	c0d03211 c0d03221 c0d03231 c0d03241     .2..!2..12..A2..
c0d03de4:	c0d03251 c0d03261 c0d03271 00000000     Q2..a2..q2......

c0d03df4 <USBD_LangIDDesc>:
c0d03df4:	04090304                                ....

c0d03df8 <USBD_MANUFACTURER_STRING>:
c0d03df8:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d03e06 <USB_SERIAL_STRING>:
c0d03e06:	0030030a 00300030 30f30031                       ..0.0.0.1.

c0d03e10 <USBD_HID>:
c0d03e10:	c0d030f3 c0d03125 c0d03057 00000000     .0..%1..W0......
	...
c0d03e28:	c0d0315d 00000000 00000000 00000000     ]1..............
c0d03e38:	c0d03281 c0d03281 c0d03281 c0d03291     .2...2...2...2..

c0d03e48 <USBD_CfgDesc>:
c0d03e48:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d03e58:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03e68:	05070100 00400302 00000001              ......@.....

c0d03e74 <USBD_DeviceQualifierDesc>:
c0d03e74:	0200060a 40000000 00000001              .......@....

c0d03e80 <N_storage_real>:
	...
